//
//  ProjectsViewController.swift
//  Swifty Companion
//
//  Created by Михаил Фокин on 19.01.2021.
//

import UIKit

class ProjectsViewController: UIViewController {
    
    var projects: [ProjectUser]?

    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

extension ProjectsViewController: UITableViewDataSource, UITableViewDelegate {

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let projects = projects else { return 0 }
        return projects.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .value1, reuseIdentifier: nil)
        if let projects = self.projects {
            let finalMark = projects[indexPath.row].finalMark ?? 0
            cell.textLabel?.text = projects[indexPath.row].project.name
            cell.textLabel?.font = UIFont.boldSystemFont(ofSize: 14)
            cell.detailTextLabel?.text = "\(finalMark)"
            cell.detailTextLabel?.font = UIFont.boldSystemFont(ofSize: 12)
            if let validated = projects[indexPath.row].validated {
                if validated {
                    cell.detailTextLabel?.textColor = .green
                }
                else {
                    cell.detailTextLabel?.textColor = .red
                }
            }
        }
        return cell
    }
}
