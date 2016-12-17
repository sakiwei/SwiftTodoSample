//
//  TodoListViewController.swift
//  TodoList
//
//  Created by Cheung Chun Wai on 17/12/2016.
//  Copyright © 2016 Sakiwei. All rights reserved.
//

import UIKit

class TodoListViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, AddTodoItemViewControllerDelegate {
  
  let todoItemKey = "todoItemKey"
  
  @IBOutlet weak var tableView: UITableView!
  
  var todoItems: [TodoItem] = [
  ]
  
  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view, typically from a nib.
    loadItems()
    
    tableView.dataSource = self
    tableView.delegate = self
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return todoItems.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "TodoItemCell", for: indexPath)
    
    if let cell = cell as? TodoItemCell {
      let item = todoItems[indexPath.row]
      cell.titleLabel.text = item.title
      cell.checkBox.isSelected = item.completed
    }
    
    return cell
  }
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    print("didSelectRowAt = \(indexPath)")
    
    var item = todoItems[indexPath.row]
    item.completed = !item.completed
    todoItems[indexPath.row] = item
    todoItems.sort { lhs, rhs in
      rhs.completed
    }
    
    tableView.reloadData()
  }
  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//    if let addVC = segue.destination as? AddTodoItemViewController {
    if segue.identifier == "AddTodoItemViewController" {
      let addVC = segue.destination as! AddTodoItemViewController
      addVC.delegate = self
    }
  }
  
  func addTodoItem(item: TodoItem) {
    todoItems.append(item)
    tableView.reloadData()
    
    saveItems()
  }
  
  func loadItems() {
    // update todoItems from user default
    if let data = UserDefaults.standard.data(forKey: todoItemKey) {
      if let jsonDicts = try? JSONSerialization.jsonObject(with: data, options: []),
        let jsonArray = jsonDicts as? [[String: Any]] {
        
        var todoItems: [TodoItem] = []
        
        for jsonObject in jsonArray {
          if let title = jsonObject["title"] as? String,
            let completed = jsonObject["completed"] as? Bool,
            let timestamp = jsonObject["date"] as? TimeInterval {
            
            let item = TodoItem(title: title, completed: completed, date: Date.init(timeIntervalSince1970: timestamp))
            
            todoItems.append(item)
          }
        }
        
        self.todoItems = todoItems
      }
    }
  }
  
  func saveItems() {
    // save new todoItems
    
    // convert item to dictionary
    var jsonDicts: [ [String: Any] ] = []
    
    for item in todoItems {
      var jsonObject: [String: Any] = [:]
      jsonObject["title"] = item.title
      jsonObject["completed"] = item.completed
      jsonObject["date"] = item.date.timeIntervalSince1970
      
      jsonDicts.append(jsonObject)
    }
    
    print(jsonDicts)
    
    if let data = try? JSONSerialization.data(withJSONObject: jsonDicts, options: []) {
      // saved data
      UserDefaults.standard.set(data, forKey: todoItemKey)
      UserDefaults.standard.synchronize()
    }
    
  }
}

