//
//  User.swift
//  QuinTypeInsta
//
//  Created by Yogesh S on 2017-10-13.
//  Copyright © 2017 Yogesh S. All rights reserved.
//

import Foundation

class User {
    let name:String
    let id:String
    let userName:String
    let profileImage:String
    var userStories: [Story] = [Story]()
    
    init(name:String,id:String,username:String,profileImg:String,stories:[Story]) {
        self.name = name
        self.id = id
        self.userName = username
        self.profileImage = profileImg
        self.userStories = stories
    }
}
