//
//  RecordAudio.swift
//  PitchPerfecto
//
//  Created by Darren Leith on 01/02/2016.
//  Copyright © 2016 Darren Leith. All rights reserved.
//

import Foundation

class RecordedAudio: NSObject {
  
  var filePathUrl: NSURL
  var title: String
  
  init(filePathUrl: NSURL, title: String) {
    self.filePathUrl = filePathUrl
    self.title = title
  }
  
}