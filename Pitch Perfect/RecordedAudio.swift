//
//  RecordedAudio.swift
//  Pitch Perfect
//
//  Created by David Kisley on 4/6/15.
//  Copyright (c) 2015 David Kisley. All rights reserved.
//

import Foundation
class RecordedAudio: NSObject{
    var filePathUrl: NSURL!
    var title: String!
     init(filePathUrl:NSURL,title: String!) {
        self.filePathUrl = filePathUrl
        self.title = title
         }
    
}
