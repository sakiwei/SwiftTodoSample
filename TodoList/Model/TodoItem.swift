//
//  TodoItem.swift
//  TodoList
//
//  Created by Cheung Chun Wai on 17/12/2016.
//  Copyright © 2016 Sakiwei. All rights reserved.
//

import Foundation

struct TodoItem {
  var title: String
  var completed: Bool
  var date: Date
  
  init(title: String, completed: Bool = false, date: Date = Date()) {
    self.title = title
    self.completed = completed
    self.date = date
  }
}

