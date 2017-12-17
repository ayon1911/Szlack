//
//  ChatVC.swift
//  Szlack
//
//  Created by Khaled Rahman Ayon on 11/12/2017.
//  Copyright © 2017 Khaled Rahman Ayon. All rights reserved.
//

import UIKit

class ChatVC: UIViewController {
    
    //OutLet..
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var menuBtn: UIButton!
    @IBOutlet weak var channelNameLbl: UILabel!
    @IBOutlet weak var messageTextBox: UITextField!
    @IBOutlet weak var messageBtn: UIButton!
    @IBOutlet weak var typingUserLbl: UILabel!
    
    //Variables
    var isTyping = false

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.estimatedRowHeight = 80
        tableView.rowHeight = UITableViewAutomaticDimension
        messageBtn.isHidden = true
        
        view.bindToKeyboard()
        
        menuBtn.addTarget(self.revealViewController(), action: #selector(SWRevealViewController.revealToggle(_:)), for: .touchUpInside)
        self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        self.view.addGestureRecognizer(self.revealViewController().tapGestureRecognizer())
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(handeltap(_:)))
        view.addGestureRecognizer(tap)
        
        NotificationCenter.default.addObserver(self, selector: #selector(ChatVC.userDataDidChange(_:)), name: NOTIF_USER_DATA_CHANGE, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(ChatVC.channelSelected(_:)), name: NOTIF_CHANNEL_SELECTED, object: nil)
        
        SocketService.instance.getChatMessage { (newMessage) in
            if newMessage.channelId == MessageService.instance.selectedChannel?.id && AuthService.instance.isLoggedIn {
                MessageService.instance.messages.append(newMessage)
                self.tableView.reloadData()
                    if MessageService.instance.messages.count > 0 {
                        let endIndex = IndexPath(row: MessageService.instance.messages.count - 1, section: 0)
                        self.tableView.scrollToRow(at: endIndex, at: .bottom, animated: false)
                }
            }
        }
        
//        SocketService.instance.getChatMessage { (success) in
//            if success {
//                self.tableView.reloadData()
//                let endIndex = IndexPath(row: MessageService.instance.messages.count - 1, section: 0)
//                self.tableView.scrollToRow(at: endIndex, at: .bottom, animated: true)
//            }
//        }
        
        SocketService.instance.getTypingusers { (typingUsers) in
            guard let channelId = MessageService.instance.selectedChannel?.id else { return }
            var names = ""
            var numberOfTypers = 0
            
            for (typingUser, channel) in typingUsers {
                if typingUser != UserDataService.instance.name && channel == channelId {
                    if names == "" {
                        names = typingUser
                    } else {
                        names = "\(names), \(typingUser)"
                    }
                    numberOfTypers += 1
                }
            }
            
            if numberOfTypers > 0 && AuthService.instance.isLoggedIn == true {
                var verb = "is"
                if numberOfTypers > 1 {
                    verb = "are"
                }
                self.typingUserLbl.text = "\(names) \(verb) typing a message"
            } else {
                self.typingUserLbl.text = ""
            }
            
        }
        
        if AuthService.instance.isLoggedIn {
            AuthService.instance.finduserByEmail(completion: { (success) in
                if success {
                    NotificationCenter.default.post(name: NOTIF_USER_DATA_CHANGE, object: nil)
                   
                }
            })
        }
    }
    
    @objc func userDataDidChange(_ notifi: Notification) {
        if AuthService.instance.isLoggedIn {
            onLogInGetMessage()
        } else {
            channelNameLbl.text = "Please Log In"
            tableView.reloadData()
        }
    }
    
    @objc func channelSelected(_ notif: Notification) {
        updateWithChannel()
    }
    
    func updateWithChannel() {
        let channelName = MessageService.instance.selectedChannel?.channelTitle ?? ""
        channelNameLbl.text = "#\(channelName)"
        getMessages()
    }
    
    func onLogInGetMessage() {
        MessageService.instance.getAllChannel { (success) in
            if success {
                //Do whatever you want
                if MessageService.instance.channels.count > 0 {
                    MessageService.instance.selectedChannel = MessageService.instance.channels[0]
                    self.updateWithChannel()
                } else {
                    self.channelNameLbl.text = "No Channels"
                }
            }
        }
    }
    
    func getMessages() {
        guard let channelId = MessageService.instance.selectedChannel?.id else { return }
        
        MessageService.instance.findAllMessagesForchannel(channelId: channelId) { (success) in
            self.tableView.reloadData()
        }
    }
    
    @objc func handeltap(_ recognizer: UITapGestureRecognizer) {
        view.endEditing(true)
    }
    
  
    @IBAction func messageBoxEditing(_ sender: Any) {
        guard let channelId = MessageService.instance.selectedChannel?.id else { return }
        
        if messageTextBox.text == ""{
            isTyping = false
            messageBtn.isHidden = true
            SocketService.instance.socket.emit("stopType", UserDataService.instance.name, channelId)
        } else {
            if isTyping == false {
                messageBtn.isHidden = false
                SocketService.instance.socket.emit("startType", UserDataService.instance.name, channelId)
            }
            isTyping = true
        }
    }
    
    @IBAction func sendMessageBtnPressed(_ sender: Any) {
        if AuthService.instance.isLoggedIn {
            if messageTextBox.text != "" {
                guard let channelId = MessageService.instance.selectedChannel?.id else { return }
                guard let message = messageTextBox.text else { return }
                print("\(message)")
                SocketService.instance.addMessage(messageBody: message, userId: UserDataService.instance.id, channelId: channelId, completion: { (success) in
                    if success {
                        self.messageTextBox.text = ""
                        self.messageTextBox.resignFirstResponder()
                        SocketService.instance.socket.emit("stopType", UserDataService.instance.name, channelId)
                    }
                })
            }
        }
    }
}

extension ChatVC : UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "messageCell", for: indexPath) as? MessageCell {
            let message = MessageService.instance.messages[indexPath.row]
            cell.configurecell(message: message)
            return cell
        } else {
            return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return MessageService.instance.messages.count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
}







