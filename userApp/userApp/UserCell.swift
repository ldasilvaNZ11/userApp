//
//  UserCell.swift
//  userApp
//
//  Created by Lucas Da Silva on 24/06/20.
//  Copyright © 2020 Lucas Da Silva. All rights reserved.
//

import UIKit

class UserCell: UITableViewCell {

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        // setting the subviews
        addSubview(backgroundCard)
        addSubview(username)
        addSubview(name)
        addSubview(website)
        addSubview(websiteImage)

        // setting constraints for the subviews
        setLabelConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setLabelConstraints() {
        backgroundCardConstraints()
        usernameConstraints()
        nameConstraints()
        websiteImageConstraints()
        websiteConstraints()
    }

    var backgroundCard: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 16
        view.backgroundColor = UIColor.secondarySystemBackground
        view.clipsToBounds = true
        return view
    }()

    var username: UILabel = {
        let username = UILabel()
        username.adjustsFontSizeToFitWidth = true
        username.translatesAutoresizingMaskIntoConstraints = false
        username.font = UIFont.boldSystemFont(ofSize: 25)
        return username
    }()

    var name: UILabel = {
        let name=UILabel()
        name.adjustsFontSizeToFitWidth = true
        name.translatesAutoresizingMaskIntoConstraints = false
        name.font = UIFont.systemFont(ofSize: 20)
        name.textColor = UIColor.secondaryLabel
        return name
    }()

    var website: UILabel = {
        let website = UILabel()
        website.adjustsFontSizeToFitWidth = true
        website.translatesAutoresizingMaskIntoConstraints = false
        website.font = UIFont.boldSystemFont(ofSize: 25)
        return website
    }()

    var websiteImage : UIImageView = {
        let wsimg = UIImageView()
        wsimg.translatesAutoresizingMaskIntoConstraints = false
        wsimg.clipsToBounds = true
        return wsimg
    }()

    fileprivate func backgroundCardConstraints() {
        backgroundCard.topAnchor.constraint(equalTo: topAnchor, constant: 8).isActive = true
        backgroundCard.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16).isActive = true
        backgroundCard.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16).isActive = true
        backgroundCard.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8).isActive = true
    }

    fileprivate func usernameConstraints() {
        username.topAnchor.constraint(equalTo: backgroundCard.topAnchor, constant: 14).isActive = true
        username.heightAnchor.constraint(equalToConstant: 25).isActive  = true
        username.leadingAnchor.constraint(equalTo: backgroundCard.leadingAnchor, constant: 30).isActive = true
    }

    fileprivate func nameConstraints() {
        name.topAnchor.constraint(equalTo: username.bottomAnchor , constant:10).isActive = true
        name.heightAnchor.constraint(equalToConstant: 25).isActive = true
        name.leadingAnchor.constraint(equalTo: backgroundCard.leadingAnchor, constant: 30).isActive = true
    }

    fileprivate func websiteImageConstraints() {
        websiteImage.topAnchor.constraint(equalTo: name.bottomAnchor, constant: 10).isActive = true
        websiteImage.heightAnchor.constraint(equalToConstant: 25).isActive = true
        websiteImage.leadingAnchor.constraint(equalTo: backgroundCard.leadingAnchor, constant: 30).isActive = true
        websiteImage.widthAnchor.constraint(equalToConstant: 25).isActive = true
    }

    fileprivate func websiteConstraints() {
        website.centerYAnchor.constraint(equalTo: websiteImage.centerYAnchor).isActive = true
        website.leadingAnchor.constraint(equalTo: websiteImage.trailingAnchor, constant: 4).isActive = true
        website.trailingAnchor.constraint(equalTo: backgroundCard.trailingAnchor, constant: -10).isActive = true
    }

    func setCellInformation(field: User) {
        username.text = String(field.username)
        name.text = String(field.name)
        websiteImage.image = UIImage(systemName: "globe")
        website.text = String(field.website)
    }
}
