//
//  Story.swift
//  QuinTypeInsta
//
//  Created by Yogesh S on 2017-10-13.
//  Copyright © 2017 Yogesh S. All rights reserved.
//

import Foundation

class Story {
    let storyId: String
    let storyType: String
    let storyFileName: String
    let uploadedOn: String
    
    init(id:String, type:String, fileName:String,uploadDate:String) {
        self.storyId = id
        self.storyType = type
        self.storyFileName = fileName
        self.uploadedOn = uploadDate
    }
}
