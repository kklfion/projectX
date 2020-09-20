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
        user = User(name: "Pete", photoURL: nil, email: "pete@gmail.com")
        navigationItem.title = "Settings"
        tableView.tableFooterView = UIView()
        navigationController?.navigationBar.prefersLargeTitles = true
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


import FirebaseFirestore
import FirebaseFirestoreSwift
struct User: Identifiable, Codable {
    /// property wrapper that stores id of the document associated with data
    @DocumentID var id: String?
    
    /// The ID of the user. This corresponds with a Firebase user's uid property.
    var userID: String

    /// The display name of the user. Users with unspecified display names are given a default name.
    var name: String

    /// A url to the user's profile photo. Users with unspecified profile pictures are given a
    /// default profile picture.
    var photoURL: URL
    
    /// An email that user used to register an account
    var email: String

    /// An optional title that user can earn for  ....
    var title: String?

    /// Optional title can be followed up by some special symbol: star, light bubble etc...
    /// that will be chosen from the set of given options
    var titleImage: String?
}
extension User{
    /// All users are stored by their userIDs for easier querying later.
    var documentID: String {
      return userID
    }
    /// Returns a new User, providing a default name and photoURL if passed nil or left unspecified.
    public init(name: String? = "User",
                photoURL: URL? = User.defaultImageURL,
                email: String) {
        let uid = UUID().uuidString
        self.init(userID: uid,
                  name: name ?? "User",
                  photoURL: photoURL ?? User.defaultImageURL,
                  email: email)
    }
}
//MARK: default data
extension User{
    static let defaultImageURL = URL(string: "https://firebasestorage.googleapis.com/v0/b/projectx-e4848.appspot.com/o/defaultUserIcon.png?alt=media&token=2e6edb8e-ac03-47fb-b58c-31bd6f3598e8")!
}

