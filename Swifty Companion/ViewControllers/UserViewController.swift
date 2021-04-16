//
//  UserViewController.swift
//  Swifty Companion
//
//  Created by Михаил Фокин on 18.01.2021.
//

import UIKit

class UserViewController: UIViewController {
    
    @IBOutlet var tableSkills: UITableView!
    @IBOutlet var item: UINavigationItem!
    @IBOutlet var userImage: UIImageView!
    
    var user: User?
    let defaultImageURL = "https://cdn.intra.42.fr/users/default.png"
    let idetifierCell = "Skill Cell"
    
    var projects: [ProjectUser]?

    @IBAction func pressButtonProjects(_ sender: UIButton) {
        performSegue(withIdentifier: "ShowProjects", sender: nil)
    }
    
    @IBAction func pressButtonInfo(_ sender: UIButton) {
        performSegue(withIdentifier: "ShowInfo", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let projects = self.projects else { return }
        if let projectsView = segue.destination as? ProjectsViewController, segue.identifier == "ShowProjects" {
            projectsView.projects = projects
            return
        }
        
        if let infoView = segue.destination as? InfoViewController, segue.identifier == "ShowInfo" {
            infoView.user = self.user
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        item.title = user?.login
        loadImage()
        tableSkills.register(UINib(nibName: "SkillTableViewCell", bundle: nil), forCellReuseIdentifier: idetifierCell)
    }
    
    private func loadImage() {
        if let user = self.user {
            if user.imageUrl == defaultImageURL { return }
            let url = URL(string: user.imageUrl ?? "")!
            let queue = DispatchQueue.global(qos: .default)
            queue.async {
                if let data = try? Data(contentsOf: url) {
                    DispatchQueue.main.async {
                        self.userImage.image = UIImage(data: data)
                    }
                }
            }
        }
    }
}

extension UserViewController: UITableViewDataSource, UITableViewDelegate {
   
    func numberOfSections(in tableView: UITableView) -> Int {
        guard let user = user else { return 0 }
        return user.cursusUsers.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let user = user else { return 0 }
        return user.cursusUsers[section].skills.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableSkills.dequeueReusableCell(withIdentifier: idetifierCell, for: indexPath) as! SkillTableViewCell
        if let skill = user?.cursusUsers[indexPath.section].skills[indexPath.row] {
            cell.nameSkill.text = skill.name
            cell.lavelSkill.text = String(skill.level)
            cell.progressSkill.setProgress(skill.level * 0.03333, animated: true)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        guard let user = user else { return "" }
        return "\(user.cursusUsers[section].cursus.name): \(user.cursusUsers[section].level)"
    }
}
