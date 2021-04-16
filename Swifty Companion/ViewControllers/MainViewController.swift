//
//  MainViewController.swift
//  Swifty Companion
//
//  Created by Михаил Фокин on 14.01.2021.
//

import UIKit

class MainViewController: UIViewController {
    
    @IBOutlet var searchText: UITextField!
    @IBOutlet var searchButton: UIButton!
    @IBOutlet var spinRun: UIActivityIndicatorView!
    
    //var token: Token?
    var credentials: Credentials?
    var user: User?
    var projects: [ProjectUser]?
    
    @IBAction func pressSearch(_ sender: UIButton) {
        if var userName = searchText.text {
            userName = userName.trimmingCharacters(in: .whitespaces)
            if userName.isEmpty { return }
            self.spinRun.startAnimating()
            self.searchButton.isEnabled = false
            getProjectsUser(userName: userName)
        }
    }
    
    @IBAction func logOut(_ sender: UIButton) {
        self.logout()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        self.spinRun.stopAnimating()
        if let userView = segue.destination as? UserViewController, segue.identifier == "ShowUser" {
            self.searchButton.isEnabled = true
            userView.user = self.user
            userView.projects = self.projects
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.spinRun.stopAnimating()
        navigationItem.setHidesBackButton(true, animated: false)
        if Authentication.isAccessToken == false {
            getAccessTocken()
        }
        self.searchButton.isEnabled = true
    }
    
    private func logout() {
        Authentication.accessToken = nil
        Authentication.codeAuthorisation = nil
        Authentication.isAccessToken = false
        Authentication.isCodeAuthorisation = false
        self.navigationController?.popViewController(animated: true)
    }
    
    private func getAccessTocken() {
        guard let credentials = self.credentials, let codeAuthorisation = Authentication.codeAuthorisation else {
            print("Error, not codeAuthorisation.")
            self.logout()
            return
        }
        let urlString = "https://api.intra.42.fr/oauth/token?grant_type=authorization_code&client_id=\(credentials.clientId)&client_secret=\(credentials.secret)&code=\(codeAuthorisation)&redirect_uri=\(credentials.redirectUri)"
        guard let url = URL(string: urlString) else { return }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        let session = URLSession.shared
        session.dataTask(with: request) { (data, response, error) in
            if let response = response as? HTTPURLResponse {
                if response.statusCode >= 400 && response.statusCode <= 500 {
                    DispatchQueue.main.async {
                        self.logout()
                    }
                    return
                }
            }
            guard let data = data else { return }
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            do {
                let token = try decoder.decode(Token.self, from: data)
                Authentication.accessToken = token.accessToken
                Authentication.isAccessToken = true
            } catch {
                print("\(error)")
            }
        }.resume()
    }
    
    private func getProjectsUser(userName: String) {
        let urlString = "https://api.intra.42.fr/v2/users/\(userName)/projects_users?per_page=100"
        guard let url = URL(string: urlString) else {
            showAlert(title: "Error user name.", message: "The request is malformed.")
            return
        }
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("Bearer \(Authentication.accessToken ?? "")", forHTTPHeaderField: "Authorization")
        let session = URLSession.shared
        session.dataTask(with: request) { (data, response, error) in
            if let response = response as? HTTPURLResponse {
                guard self.showErrorAlert(statusCode: response.statusCode) else { return }
            }
            guard let data = data else { return }
            do {
                self.projects = try JSONDecoder().decode([ProjectUser].self, from: data)
                DispatchQueue.main.async {
                    self.getUser(userName: userName)
                }
            } catch {
                print("\(error)")
            }
        }.resume()
    }
    
    private func getUser(userName: String) {
        let urlString = "https://api.intra.42.fr/v2/users/\(userName)"
        guard let url = URL(string: urlString) else { return }
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("Bearer \(Authentication.accessToken ?? "")", forHTTPHeaderField: "Authorization")
        let session = URLSession.shared
        session.dataTask(with: request) { (data, response, error) in
            if let response = response as? HTTPURLResponse {
                guard self.showErrorAlert(statusCode: response.statusCode) else { return }
            }
            guard let data = data else { return }
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            do {
                self.user = try decoder.decode(User.self, from: data)
                DispatchQueue.main.async {
                    self.performSegue(withIdentifier: "ShowUser", sender: nil)
                }
            } catch {
                print("\(error)")
            }
        }.resume()
    }
    
    private func showErrorAlert(statusCode: Int) -> Bool {
        switch statusCode {
        case 400:
            DispatchQueue.main.async {
                self.showAlert(title: "Error name user.", message: "The request is malformed.")
            }
            return false
        case 401:
            DispatchQueue.main.async {
                self.showAlert(title: "Unauthorized", message: "Not access token.")
                self.getAccessTocken()
            }
            return false
        case 403:
            DispatchQueue.main.async {
                self.showAlert(title: "Forbidden", message: "")
            }
            return false
        case 404:
            DispatchQueue.main.async {
                self.showAlert(title: "Error", message: "User or resource is not found.")
            }
            return false
        case 422:
            DispatchQueue.main.async {
                self.showAlert(title: "Error", message: "Unprocessable entity.")
            }
            return false
        case 500:
            DispatchQueue.main.async {
                self.showAlert(title: "Error", message: "We have a problem with our server. Please try again later.")
            }
            return false
        default:
            return true
        }
    }
    
    private func showAlert(title: String, message: String) {
        spinRun.stopAnimating()
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Close", style: .cancel, handler: nil))
        self.present(alert,animated: true,completion: nil)
        self.searchButton.isEnabled = true
    }
}
