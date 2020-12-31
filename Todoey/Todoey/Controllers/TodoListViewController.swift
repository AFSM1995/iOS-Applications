//
//  ViewController.swift
//  Todoey
//
//  Created by Philipp Muellauer on 02/12/2019.
//  Copyright © 2019 App Brewery. All rights reserved.
//

import UIKit

class TodoListViewController: UITableViewController {
    var itemArray = [ItemModel]()
    let defaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        var itemModel = ItemModel()
        itemModel.name = "A"
        itemArray.append(itemModel)
        itemModel.name = "B"
        itemArray.append(itemModel)
        itemModel.name = "C"
        itemArray.append(itemModel)
    }
    
    //MARK: - Tableview Datasource Methods
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
    
    // Figures out how to display a cell.
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let item = indexPath.row
        
        // Creates a new cell that dose not get reused.
        // let cell = UITableViewCell(style: .default, reuseIdentifier: "ToDoItemCell")
        
        // Creates a reuseable cell. If a user scrolls down enoght the cel gets reused.
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
        cell.textLabel?.text = itemArray[item].name
        
        if itemArray[item].done == true {
            cell.accessoryType = .checkmark
        } else {
            cell.accessoryType = .none
        }
        
        return cell
    }
    
    //MARK: - Tableview Delegate Methods
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let item = indexPath.row
        
        // Better then an if else stament to reverse current state.
        itemArray[item].done = !itemArray[item].done
        
        // Forces the table view to reload after you interact with one of the cells.
        tableView.reloadData()
        
        // Animates deselection of a row
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    //MARK: - Add New Item
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        var textField = UITextField()
        let alert = UIAlertController(title: "Add New Todoey Item", message: "", preferredStyle: .alert)
        
        // Completion block that gets called when "Add Item" gets pressed.
        let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
            // Adding new item
            var tempItem = ItemModel()
            tempItem.name = textField.text!
            self.itemArray.append(tempItem)
            self.tableView.reloadData()
            self.defaults.set(self.itemArray, forKey: "TodoListArray")
        }
        
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create new item"
            textField = alertTextField
        }
        
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
}
