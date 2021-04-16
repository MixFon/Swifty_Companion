//
//  ViewController.swift
//  Swifty Companion
//
//  Created by Михаил Фокин on 11.12.2020.
//

import UIKit
import WebKit

class ViewController: UIViewController {

    @IBOutlet var webView: WKWebView!
    
    let credentials = Credentials()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        removeCookies()
        if Authentication.isCodeAuthorisation == true {
            performSegue(withIdentifier: "ShowSearchView", sender: nil)
        }
        webView.navigationDelegate = self
        postTapped()
    }
    // Медод вызывается перед переходом к новому view. сразу после вызова метода performSegue()
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let mainView = segue.destination as? MainViewController, segue.identifier == "ShowSearchView" {
            mainView.credentials = self.credentials
        }
    }

    func postTapped() {
        let urlString = "\(credentials.hostIntra)/oauth/authorize?client_id=\(credentials.clientId)&redirect_uri=\(credentials.redirectUri)&response_type=code"
        guard let url = URL(string: urlString) else { return }
        let request = URLRequest(url: url)
        webView.load(request)
    }
    
    private func removeCookies() {
        let cookieStore = webView.configuration.websiteDataStore.httpCookieStore
        cookieStore.getAllCookies {
            cookies in
            for cookie in cookies {
                cookieStore.delete(cookie)
            }
        }
    }
}

extension ViewController : WKNavigationDelegate {
    
    // Данная функция вызывается, когда происходят события в WebView, например, переход на новую страницу.
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Swift.Void) {
        let url = navigationAction.request.url
        let component = URLComponents(url: url!, resolvingAgainstBaseURL: false)
        if let queryItems = component?.queryItems {
            for item in queryItems {
                if item.name == "code" {
                    Authentication.codeAuthorisation = item.value
                    Authentication.isCodeAuthorisation = true
                    removeCookies()
                    performSegue(withIdentifier: "ShowSearchView", sender: nil)
                    postTapped()
                }
            }
        }
        decisionHandler(.allow)
        return
    }
}

