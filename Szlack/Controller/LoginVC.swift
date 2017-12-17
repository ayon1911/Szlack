//
//  LoginVC.swift
//  Szlack
//
//  Created by Khaled Rahman Ayon on 13/12/2017.
//  Copyright © 2017 Khaled Rahman Ayon. All rights reserved.
//

import UIKit

class LoginVC: UIViewController {
    
    //Outlets
    @IBOutlet weak var userNameTxt: UITextField!
    @IBOutlet weak var passwordTxt: UITextField!
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func closeBtnPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func createBtnPressed(_ sender: Any) {
        performSegue(withIdentifier: TO_CREATE_ACCT, sender: nil)
    }
    
    @IBAction func loginBtnPressed(_ sender: Any) {
        spinner.isHidden = false
        spinner.startAnimating()
        
        guard let email = userNameTxt.text, userNameTxt.text != "" else { return }
        guard let password = passwordTxt.text, passwordTxt.text != ""else { return }
        AuthService.instance.loginUser(email: email, password: password) { (success) in
            if success {
                AuthService.instance.finduserByEmail(completion: { (success) in
                    if success {
                        NotificationCenter.default.post(name: NOTIF_USER_DATA_CHANGE, object: nil)
                        self.spinner.isHidden = true
                        self.spinner.stopAnimating()
//                        MessageService.instance.getAllChannel(completion: { (success) in
//                            print("\(MessageService.instance.channels)")
//                        })
                        self.dismiss(animated: true, completion: nil)
                    }
                })
            }
        }
    }
    
    func setupView() {
        spinner.isHidden = true
        userNameTxt.attributedPlaceholder = NSAttributedString(string: "Username", attributes: [NSAttributedStringKey.foregroundColor : PURPLE_PLACEHOLDER_COLOR])
        passwordTxt.attributedPlaceholder = NSAttributedString(string: "Password", attributes: [NSAttributedStringKey.foregroundColor : PURPLE_PLACEHOLDER_COLOR])
    }
    
    
    
}
