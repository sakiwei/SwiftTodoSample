//
//  AddTodoItemViewController.swift
//  TodoList
//
//  Created by Cheung Chun Wai on 17/12/2016.
//  Copyright © 2016 Sakiwei. All rights reserved.
//

import UIKit

protocol AddTodoItemViewControllerDelegate: class {
  func addTodoItem(item: TodoItem)
}

class AddTodoItemViewController: UIViewController {
  
  @IBOutlet weak var titleField: UITextField!
  
  weak var delegate: AddTodoItemViewControllerDelegate?
  
  @IBAction func submitItem(_ sender: UIButton) {
    // create item and send back to list vc
    if let title = titleField.text, title.characters.count > 0 {
      let newItem = TodoItem(title: title)
      
      
      
      delegate?.addTodoItem(item: newItem)
      _ = self.navigationController?.popViewController(animated: true)
    } else {
      let alert = UIAlertController.init(title: "You must enter some text!", message: nil, preferredStyle: UIAlertControllerStyle.alert)
      let action = UIAlertAction(title: "Ok", style: UIAlertActionStyle.cancel, handler: { action in
        print(action.title ?? "")
      })
      alert.addAction(action)
      self.present(alert, animated: true, completion: nil)
    }
  }
}
