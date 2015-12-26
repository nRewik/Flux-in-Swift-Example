//
//  ViewController.swift
//  Flux-in-Swift-Example
//
//  Created by Nutchaphon Rewik on 05/11/2015.
//  Copyright © 2015 Nutchaphon Rewik. All rights reserved.
//

import UIKit

class TodoViewController: UIViewController {

    var todoStore = TodoStore.defaultStore
    
    @IBOutlet weak var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        todoStore.registerStoreChanged(self)
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        todoStore.unregisterStoreChanged(self)
    }
    
    func showCreateTodo(){
        
        let alertController = UIAlertController(title: "Create New Todo", message: nil, preferredStyle: .Alert)
        alertController.addTextFieldWithConfigurationHandler(nil)
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .Cancel, handler: nil)
        let okAction = UIAlertAction(title: "OK", style: .Default){ action in
            guard let textFields = alertController.textFields else { return }
            guard let todoText = textFields[0].text else { return }
            TodoAction.create(todoText)
        }
        alertController.addAction(cancelAction)
        alertController.addAction(okAction)
        
        presentViewController(alertController, animated: true, completion: nil)
    }
    
    func showEditTodo(todo: TodoItem){
        
        let alertController = UIAlertController(title: "Edit Todo", message: nil, preferredStyle: .Alert)
        alertController.addTextFieldWithConfigurationHandler{ textField in
            textField.text = todo.text
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .Cancel, handler: nil)
        let okAction = UIAlertAction(title: "OK", style: .Default){ action in
            guard let textFields = alertController.textFields else { return }
            guard let todoText = textFields[0].text else { return }
            TodoAction.edit(todo.id, text: todoText)
        }
        alertController.addAction(cancelAction)
        alertController.addAction(okAction)
        
        presentViewController(alertController, animated: true, completion: nil)
    }

    @IBAction func addButtonTapped(sender: UIBarButtonItem) {
        showCreateTodo()
    }

}

extension TodoViewController: UITableViewDataSource{
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("Table View Cell")!
        let todoItem = todoStore.todoList[indexPath.row]
        cell.textLabel?.text = todoItem.text
        return cell
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return todoStore.todoList.count
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
}

extension TodoViewController: UITableViewDelegate{
    
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        
        let selectedTodo = todoStore.todoList[indexPath.row]
        showEditTodo(selectedTodo)
    }
    
    func tableView(tableView: UITableView, editActionsForRowAtIndexPath indexPath: NSIndexPath) -> [UITableViewRowAction]? {
        
        let deleteAction = UITableViewRowAction(style: .Destructive, title: "Delete"){ rowAction , indexPath in
            let todo = self.todoStore.todoList[indexPath.row]
            TodoAction.delete(todo.id)
        }
        
        return [deleteAction]
    }
    
}


extension TodoViewController: StoreListener{
    
    func storeDidChanged(store: Store) {
        // render new data when store is updated.
        tableView.reloadData()
    }
}