//
//  TableViewController.swift
//  userApp
//
//  Created by Lucas Da Silva on 17/06/20.
//  Copyright © 2020 Lucas Da Silva. All rights reserved.
//

import UIKit

class TableViewController: UITableViewController {

    var users : [User] = []

    fileprivate func setUpTableView() {
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(UserCell.self, forCellReuseIdentifier: "Cell")
        tableView.dataSource = self
        tableView.delegate = self
        tableView.rowHeight = 150
        tableView.allowsSelection = false
        tableView.separatorStyle = UITableViewCell.SeparatorStyle.none
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        users = fetchData()
        setUpTableView()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        // Configure the cell...
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! UserCell
        cell.layer.cornerRadius = 15
//        let t: Int = indexPath.row
//        cell.backgroundColor = (t%2==1) ? .systemTeal: .systemPink
        let user = users[indexPath.row]
        cell.setCellInformation(field: user)
        return cell
    }
}

extension TableViewController {

    func fetchData() -> [User] {
        let info1 = User(id: 1, name: "Lucas", username: "Silva", website: "www.lucassilva.com")
        let info2 = User(id: 2, name: "Caitlin", username: "Foley", website: "www.caitlinfoley.com")

        return [info1, info2]
    }
}
