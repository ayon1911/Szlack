//
//  AddChannelVC.swift
//  Szlack
//
//  Created by Khaled Rahman Ayon on 15/12/2017.
//  Copyright © 2017 Khaled Rahman Ayon. All rights reserved.
//

import UIKit

class AddChannelVC: UIViewController {

    //Outlets
    @IBOutlet weak var channelName: UITextField!
    @IBOutlet weak var channelDesc: UITextField!
    @IBOutlet weak var bgView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()

        setupView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setupView() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(AddChannelVC.closeTouch(_:)))
        bgView.addGestureRecognizer(tap)
        
        channelName.attributedPlaceholder = NSAttributedString(string: "Channel Name", attributes: [NSAttributedStringKey.foregroundColor : PURPLE_PLACEHOLDER_COLOR])
        channelDesc.attributedPlaceholder = NSAttributedString(string: "Channel Description", attributes: [NSAttributedStringKey.foregroundColor : PURPLE_PLACEHOLDER_COLOR])
    }
    
    @objc func closeTouch(_ recognizer: UITapGestureRecognizer) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func closebtnPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func createBtnPressed(_ sender: Any) {
        guard let name = channelName.text, channelName.text != "" else { return }
        guard let desc = channelDesc.text, channelDesc.text != "" else { return }
        
        SocketService.instance.addChannel(channelName: name, channelDesc: desc) { (success) in
            if success {
                self.dismiss(animated: true, completion: nil)
            }
        }
     }
    
}
