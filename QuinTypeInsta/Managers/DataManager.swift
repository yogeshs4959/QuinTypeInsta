//
//  DataManager.swift
//  QuinTypeInsta
//
//  Created by Yogesh S on 2017-10-13.
//  Copyright © 2017 Yogesh S. All rights reserved.
//

import Foundation

class DataManager {
    class func parseJsonDictionary(dict: [String:Any]) -> [User]{
        var users:[User] = [User]()
        if let userList:[[String:Any]] = dict["usersList"] as? [[String:Any]] {
            for user in userList {
                let name:String = user["name"] as? String ?? ""
                let id:String = user["id"] as? String ?? ""
                let username:String = user["username"] as? String ?? ""
                let profileImg:String = user["profileImage"] as? String ?? ""
                let userStrories:[[String:Any]] = user["Stories"] as? [[String:Any]] ?? [[:]]
                var userStoriesArray: [Story] = [Story]()
                for story in userStrories {
                    let storyId:String = story["storyId"] as? String ?? ""
                    let storyType:String = story["type"] as? String ?? ""
                    let storyFileName:String = story["storyFileName"] as? String ?? ""
                    let storyUploadedDate:String = story["uploadedDate"] as? String ?? ""
                    let story = Story(id: storyId, type: storyType, fileName: storyFileName, uploadDate: storyUploadedDate)
                    userStoriesArray.append(story)
                }
                let currentUser = User(name: name, id: id, username: username, profileImg: profileImg, stories: userStoriesArray)
                users.append(currentUser)
            }
        }
        return users
    }
}
