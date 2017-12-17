//
//  Constants.swift
//  Szlack
//
//  Created by Khaled Rahman Ayon on 11/12/2017.
//  Copyright © 2017 Khaled Rahman Ayon. All rights reserved.
//

import Foundation

typealias CompletionHandler = (_ Success: Bool) -> ()

//URL constans
let BASE_URL = "https://szlackchat.herokuapp.com/v1/"
let REGISTER_URL = "\(BASE_URL)account/register"
let LOGIN_URL = "\(BASE_URL)account/login"
let CREATE_USER_URL = "\(BASE_URL)user/add"
let USER_BY_EMAIL = "\(BASE_URL)user/byEmail/"
let GET_CHANNEL_URL = "\(BASE_URL)channel"
let GET_MESSAGES_URL = "\(BASE_URL)/message/byChannel/"

//Placeholder colors
let PURPLE_PLACEHOLDER_COLOR = #colorLiteral(red: 0.3254901961, green: 0.4215201139, blue: 0.7752227187, alpha: 0.5)

//Notification Constants
let NOTIF_USER_DATA_CHANGE = Notification.Name("notificationUserDataChange")
let NOTIF_CHANNELS_LOADED = Notification.Name("notificationChannelsLoaded")
let NOTIF_CHANNEL_SELECTED = Notification.Name("notificationChannelSelected")


//Segues
let TO_LOGINVC = "toLoginVC"
let TO_CREATE_ACCT = "toCreateAccountVC"
let UNWIND = "unwindToChannelVC"
let AVATAR_PICKER = "toAvatarPicker"

//user defaults
let TOKEN_KEY = "token"
let LOGGED_IN_KEY = "loggedIn"
let EMAIL = "email"

//Header
let HEADER = [
    "Content-Type": "application/json; charset=utf-8"
]

let BEARER_HEADER = [
    "Authorization": "Bearer \(AuthService.instance.authToken)",
    "Content-Type": "application/json; charset=utf-8"
]
