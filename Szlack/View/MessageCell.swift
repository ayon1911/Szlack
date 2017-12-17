//
//  MessageCell.swift
//  Szlack
//
//  Created by Khaled Rahman Ayon on 16/12/2017.
//  Copyright © 2017 Khaled Rahman Ayon. All rights reserved.
//

import UIKit

class MessageCell: UITableViewCell {

    //outlets
    @IBOutlet weak var userImg: CircleImage!
    @IBOutlet weak var userNameLbl: UILabel!
    @IBOutlet weak var userTimeStampLbl: UILabel!
    @IBOutlet weak var messageBodyLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func configurecell(message: Message) {
        messageBodyLbl.text = message.message
        userNameLbl.text = message.userName
//        userTimeStampLbl.text = message.timeStamp
        userImg.image = UIImage(named: message.userAvatarName)
    
        userImg.backgroundColor = UserDataService.instance.returnUiColor(components: message.userAvatarColor)
    }

}
