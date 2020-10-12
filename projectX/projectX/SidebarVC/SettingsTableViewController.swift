//
//  SettingsTableViewController.swift
//  testing
//
//  Created by Radomyr Bezghin on 9/17/20.
//  Copyright © 2020 Radomyr Bezghin. All rights reserved.
//

import UIKit
import FirebaseAuth

class SettingsTableViewController: UITableViewController {
    
    let userManager = UserManager.shared
    
    var user: User?
    
    let sections = ["User", "About", "Account"]
    var rows = [
        ["User ID", "Email Address", "Blacklisted"],
        ["Comminity Guidelines", "Terms of Service", "Privacy Policy", "Contact us"],
        []
    ]
    let signedInRows = ["Sign Out", "Delete Account"]
    let signedOutRows = ["Sign In"]
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Settings"
        tableView.tableFooterView = UIView()
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    override func viewWillAppear(_ animated: Bool) {
        print("settings view will appear")
        navigationController?.navigationBar.isHidden = false
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            self.user = UserManager.shared.user
            self.handleRowsForSignInSignOut()
        }

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
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch rows[indexPath.section][indexPath.row]{
            case "Sign Out":
                signMeOut()
            case "Delete Account":
                deleteMe()
            case "Sign In":
                logMeIn()
            default:
                print("not implemented")
        }
    }
    private func handleRowsForSignInSignOut(){
        if userManager.userStatus == .signedIn{
            rows[2] = signedInRows
            tableView.reloadData()
        }else{
            rows[2] = signedOutRows
            tableView.reloadData()
        }
    }
    private func signMeOut(){
        userManager.signMeOut()
        userManager.setUserToNil()
        user = userManager.user
        handleRowsForSignInSignOut()
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.dismiss(animated: true)
        }
    }
    private func deleteMe(){
        userManager.deleteMe()
        user = userManager.user
    }
    private func logMeIn(){
        let vc = LoginViewController()
        let navvc = UINavigationController(rootViewController: vc)
        navvc.modalPresentationStyle = .fullScreen
        self.present(navvc, animated: true)
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
