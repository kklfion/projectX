//
//  SettingsTableViewController.swift
//  testing
//
//  Created by Radomyr Bezghin on 9/17/20.
//  Copyright © 2020 Radomyr Bezghin. All rights reserved.
//

import UIKit

class SettingsTableViewController: UITableViewController {
    var user: User?{
        didSet{
            tableView.reloadData()
        }
    }
    let sections = ["User", "About", "Accont"]
    let rows = [
        ["User ID", "Email Address", "Blacklisted"],
        ["Comminity Guidelines", "Terms of Service", "Privacy Policy", "Contact us"],
        ["Sign Out", "Delete Account"]
    ]
    override func viewDidLoad() {
        super.viewDidLoad()
        user = User(name: "Pete", photoURL: nil, email: "pete@gmail.com", uid: "12344")
        navigationItem.title = "Settings"
        tableView.tableFooterView = UIView()
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.navigationBar.isHidden = false
    }
    override func viewWillDisappear(_ animated: Bool) {
        navigationController?.navigationBar.isHidden = true
    }
    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = SectionHeaderView()
        view.sectionTitleLabel.text = sections[section]
        return view
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return sections.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return rows[section].count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var celll = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier")
        if celll == nil {
            celll = UITableViewCell(style: .value1, reuseIdentifier: "reuseIdentifier")
        }
        guard let cell = celll else { return UITableViewCell()}
        cell.selectionStyle = .none
        addData(cell, indexPath)
        return cell
    }
    private func addData(_ cell: UITableViewCell,_ indexPath: IndexPath){
        //add text
        cell.textLabel?.text = rows[indexPath.section][indexPath.row]
        if (cell.textLabel?.text == "Delete Account" ){
            cell.textLabel?.textColor = .red
        }
        // add accessory
        if indexPath.section == 1 || rows[indexPath.section][indexPath.row] == "Blacklisted"{
            cell.accessoryType = .disclosureIndicator
        }
        //add details
        switch rows[indexPath.section][indexPath.row] {
            case "User ID":
                cell.detailTextLabel?.text = user?.name
            case "Email Address":
                cell.detailTextLabel?.text = user?.email
            case "Blacklisted":
                cell.detailTextLabel?.text = "0"
            default:
                cell.detailTextLabel?.text = ""
        }
    }
}
class SectionHeaderView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupViews()
    }
    let sectionTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Section"
        label.font = UIFont.preferredFont(forTextStyle: .headline)
        label.textAlignment = .left
        label.textColor = .black
        return label
    }()

    private func setupViews(){
        self.backgroundColor = UIColor.init(red: 223/255.0, green: 230/255.0, blue: 233/255.0, alpha: 1.0)
        self.addSubview(sectionTitleLabel)
        sectionTitleLabel.addAnchors(top: self.topAnchor,
                                     leading: self.layoutMarginsGuide.leadingAnchor,
                                     bottom: self.bottomAnchor,
                                     trailing: nil,
                                     padding: .init(top: Constants.standardPadding, left: Constants.standardPadding, bottom: Constants.standardPadding, right: 0))
    }

}
