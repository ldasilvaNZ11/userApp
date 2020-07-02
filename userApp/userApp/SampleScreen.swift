//
//  SampleScreen.swift
//  userApp
//
//  Created by Lucas Da Silva on 30/06/20.
//  Copyright © 2020 Lucas Da Silva. All rights reserved.
//

import UIKit

protocol PassingUser {
    func passUser(user: User)
}

fileprivate func setUpTextField(_ textField: UITextField,placeHolder: String) {
    textField.translatesAutoresizingMaskIntoConstraints = false
    textField.placeholder = placeHolder
    textField.keyboardType = UIKeyboardType.default
    textField.returnKeyType = UIReturnKeyType.done
    textField.autocorrectionType = UITextAutocorrectionType.no
    textField.font = UIFont.systemFont(ofSize: 20)
    textField.textColor = UIColor.label
    textField.tintColor = UIColor.secondaryLabel
    textField.attributedPlaceholder = NSAttributedString(string: placeHolder, attributes: [NSAttributedString.Key.foregroundColor : UIColor.secondaryLabel])
    textField.borderStyle = UITextField.BorderStyle.roundedRect
    textField.layer.borderColor = UIColor.secondaryLabel.cgColor
    textField.layer.borderWidth = 0.5
    textField.layer.cornerRadius = 5
    textField.clearButtonMode = UITextField.ViewMode.whileEditing
    textField.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
}

class SampleScreen: UIViewController {

    var delegate: PassingUser?
    var defaults = UserDefaults.standard

    var titleLabel:UILabel = {
        let titles = UILabel()
        titles.text = "Add Users"
        titles.translatesAutoresizingMaskIntoConstraints = false
        titles.font = UIFont(name: "Helvetica-Bold", size: 30)
        return titles
    }()
    var idTF: UITextField = {
        let textField=UITextField()
        setUpTextField(textField, placeHolder: "Id")
        return textField
    }()
    var nameTextField:UITextField = {
        let textField = UITextField()
        setUpTextField(textField,placeHolder: "Name")
        return textField
    }()
    var usernameTF: UITextField = {
        let textField=UITextField()
        setUpTextField(textField, placeHolder: "Username")
        return textField
    }()
    var adrTF: UITextField = {
        let textField=UITextField()
        setUpTextField(textField, placeHolder: "Address")
        return textField
    }()
    var websiteTF: UITextField = {
        let textField=UITextField()
        setUpTextField(textField, placeHolder: "Website")
        return textField
    }()
    var companyTF: UITextField = {
        let textField=UITextField()
        setUpTextField(textField, placeHolder: "Company")
        return textField
    }()
    var submit: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Add User", for: .normal)
        button.tintColor = .white
        button.backgroundColor = .systemBlue
        button.layer.cornerRadius = 5
        button.addTarget(self, action: #selector(addUser), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    var save: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Save", for: .normal)
        button.tintColor = .white
        button.backgroundColor = .systemBlue
        button.layer.cornerRadius = 5
        button.addTarget(self, action: #selector(saveCurrentUser), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    var load: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Load", for: .normal)
        button.tintColor = .white
        button.backgroundColor = .systemBlue
        button.layer.cornerRadius = 5
        button.addTarget(self, action: #selector(loadCurrentUser), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    func isStringContainsOnlyNumbers(string: String) -> Bool {
        return string.rangeOfCharacter(from: CharacterSet.decimalDigits.inverted) == nil
    }
    var text:String?
    @objc fileprivate func saveCurrentUser() {
        text = idTF.text
        defaults.set(text, forKey: "id")
    }

    @objc fileprivate func loadCurrentUser() {
        text = defaults.string(forKey: "id")
        idTF.text = text
    }

    enum SubmitError: Error{
        case fieldsCannotBeNull
    }

    @objc fileprivate func addUser()
    {
        do{
            guard let name = nameTextField.text,
                let username = usernameTF.text,
                let city = adrTF.text,
                let company = companyTF.text,
                let website = websiteTF.text,
                let id = Int(idTF.text ?? "")
                else {
                    throw SubmitError.fieldsCannotBeNull
            }

            let address = Address(city:city)
            let companys = Company(name: company)
            let user = User(id: id, name: name, username: username, website: website, address: address, company: companys)
            print(user)
            delegate?.passUser(user: user)
            dismiss(animated: true, completion: nil)
            nameTextField.text=""
            adrTF.text=""
            companyTF.text=""
            websiteTF.text=""
            usernameTF.text=""
            idTF.text=""
        }
        catch {
            print(error)
            //we can use an Alert Controller here to make a pop up with an appropriate message
            let alertController = UIAlertController(title: "Form incorrectly filled", message: "Please fill all the details correctly", preferredStyle: .alert)
            alertController.addTextField { (textField) in
                textField.placeholder = "Textfield"
            }
            alertController.addAction(UIAlertAction(title: "Submit", style: .default, handler: { (action) in
                guard let text = alertController.textFields?.first?.text else { print("Textfield empty"); return}
            }))
//            alertController.addAction(UIAlertAction(title: "Okay", style: .default, handler: nil))
//            alertController.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
//            alertController.addAction(UIAlertAction(title: "Destructive", style: .destructive, handler: nil))
            self.present(alertController, animated: true)
        }

    }
    fileprivate func setUpTF(_ tf:UITextField) {
        tf.heightAnchor.constraint(equalToConstant: 45).isActive = true
        tf.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        tf.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
    }
    fileprivate func setUpView() {
        titleLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 50).isActive = true
        titleLabel.heightAnchor.constraint(equalToConstant: 40).isActive = true
        titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true

        idTF.topAnchor.constraint(equalTo: view.topAnchor, constant: 100).isActive = true
        setUpTF(idTF)

        nameTextField.topAnchor.constraint(equalTo: idTF.bottomAnchor, constant: 20).isActive = true
        setUpTF(nameTextField)

        usernameTF.topAnchor.constraint(equalTo: nameTextField.bottomAnchor, constant: 20).isActive = true
        setUpTF(usernameTF)

        adrTF.topAnchor.constraint(equalTo: usernameTF.bottomAnchor, constant: 20).isActive = true
        setUpTF(adrTF)

        websiteTF.topAnchor.constraint(equalTo: adrTF.bottomAnchor, constant: 20).isActive = true
        setUpTF(websiteTF)

        companyTF.topAnchor.constraint(equalTo: websiteTF.bottomAnchor, constant: 20).isActive = true
        setUpTF(companyTF)

        submit.topAnchor.constraint(equalTo: companyTF.bottomAnchor, constant: 30).isActive = true
        submit.heightAnchor.constraint(equalToConstant: 45).isActive = true
        submit.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        submit.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true

        save.topAnchor.constraint(equalTo: submit.bottomAnchor, constant: 30).isActive = true
        save.heightAnchor.constraint(equalToConstant: 45).isActive = true
        save.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        save.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true

        load.topAnchor.constraint(equalTo: save.bottomAnchor, constant: 30).isActive = true
        load.heightAnchor.constraint(equalToConstant: 45).isActive = true
        load.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        load.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.systemGroupedBackground
        view.addSubview(nameTextField)
        view.addSubview(usernameTF)
        view.addSubview(idTF)
        view.addSubview(adrTF)
        view.addSubview(websiteTF)
        view.addSubview(companyTF)
        view.addSubview(titleLabel)
        view.addSubview(submit)
        view.addSubview(save)
        view.addSubview(load)
        setUpView()
    }
}
