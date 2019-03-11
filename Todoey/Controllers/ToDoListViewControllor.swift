//
//  ViewController.swift
//  Todoey
//
//  Created by Raymundo Canales on 1/28/19.
//  Copyright © 2019 Raymundo Canales. All rights reserved.
//

import UIKit

class ToDoListViewController: UITableViewController {

    var itemArray = [Item]() // Making an array of type item
    let defaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        let newItem = Item()
        newItem.title = "Find Mike"
        itemArray.append(newItem)
        
        let newItem2 = Item()
        newItem2.title = "YEET"
        itemArray.append(newItem2)
        
        if let items = UserDefaults.standard.array(forKey: "TodoListArray") as? [Item] { // file that has the SAVED Array UserDefaults
            itemArray = items
        }
        
    }

    // MARK - Tableview Datasource Methods
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
        
        let item = itemArray[indexPath.row]
        
        cell.textLabel?.text = item.title
        
        // Ternary Operator ==>
        // value = condition ? valueIfTrue : valueIfFalse
        cell.accessoryType = item.done ? .checkmark : .none // This line reads.. "Set the cells accessory type" "depending on item.done" "if true set checkmark, if not set none"
        
        return cell
    }
    
    //MARK - TableView Delegate Methods
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        print(itemArray[indexPath.row])
        
        itemArray[indexPath.row].done = !itemArray[indexPath.row].done // this line allows to set TRUE or FALSE, basically REVERSING
        
        
        tableView.reloadData()
        tableView.deselectRow(at: indexPath, animated: true)
        
    }
    
    //MARK - Add New IBAction
    @IBAction func addItemButtonPressed(_ sender: UIBarButtonItem) {
        
        var textField = UITextField() // using the UITextField
        
        let alert = UIAlertController(title: "Add New Todoey Item", message: "", preferredStyle: .alert) // This brings up the alert box to add the new item
        
        let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
            // what will happen once the user clicks the Add Item Button
            
            let newItem = Item()
            newItem.title = textField.text!
            
            
            self.itemArray.append(newItem) // This line will append the item towards the back of the array.
            
            self.defaults.set(self.itemArray, forKey: "TodoListArray")
            
            self.tableView.reloadData() // reloads the tableView data
            print("New item to table view added successfully.") // check if item was added successfully
            
            
        }
        
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create New Item"
            textField = alertTextField
        }
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    
    }
    
    
}

