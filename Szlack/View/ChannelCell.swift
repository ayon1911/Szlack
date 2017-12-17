//
//  ChannelCell.swift
//  Szlack
//
//  Created by Khaled Rahman Ayon on 15/12/2017.
//  Copyright © 2017 Khaled Rahman Ayon. All rights reserved.
//

import UIKit

class ChannelCell: UITableViewCell {
    //Outlets
    @IBOutlet weak var channelTitle: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: true)
        if selected {
            self.layer.backgroundColor = UIColor(white: 1, alpha: 0.2).cgColor
        } else {
            self.layer.backgroundColor = UIColor.clear.cgColor
        }
    }
    
    func configureCell(channel: Channel) {
        let title = channel.channelTitle ?? ""
        channelTitle.text = "#\(title)"
        channelTitle.font = UIFont(name: "AvenirNext-Regular", size: 16)
        
        for id in MessageService.instance.unreadChannels {
            if id == channel.id {
                channelTitle.font = UIFont(name: "AvenirNext-Bold", size: 18)
            }
        }
        
    }
    
    
}
