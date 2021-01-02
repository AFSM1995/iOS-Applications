//
//  ViewController.swift
//  Todoey
//
//  Created by Philipp Muellauer on 02/12/2019.
//  Copyright © 2019 App Brewery. All rights reserved.
//

import UIKit
import CoreData

class TodoListViewController: UITableViewController {
    var itemArray = [Item]()
    let dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
    // Tap into UIApplication class then getting the shared singolton object (Current app as object).
    // Taping into its delegate (of datatype UIApplicationDelegate) casting it as our class AppDelegate.
    // Since both inharete form the UIApplicationDelegate the cast is valid.
    // Now have access to app delagete as an object.
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        print(dataFilePath)
        loadItems()
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
        cell.accessoryType = itemArray[item].done ? .checkmark : .none
        return cell
    }
    
    //MARK: - Tableview Delegate Methods
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let item = indexPath.row
        
        // Better then an if else stament to reverse current state.
        itemArray[item].done = !itemArray[item].done
        
        saveItems()
        
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
            var tempItem = Item(context: self.context)
            tempItem.name = textField.text!
            tempItem.done = false
            self.itemArray.append(tempItem)
            self.saveItems()
        }
        
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create new item"
            textField = alertTextField
        }
        
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    
    func saveItems() {
        // Save using CoreData
        do {
            try context.save()
        } catch {
            print("error")
        }
        
        tableView.reloadData()
    }
    
    func loadItems(with request: NSFetchRequest<Item> = Item.fetchRequest()) {
        do {
            itemArray = try context.fetch(request)
        } catch {
            print("Error fetching")
        }
        
        tableView.reloadData()
    }
}

extension TodoListViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        let request : NSFetchRequest<Item> = Item.fetchRequest()
        request.predicate = NSPredicate(format: "name CONTAINS[cd] %@", searchBar.text!)
        request.sortDescriptors = [NSSortDescriptor(key: "name", ascending: true)]
        loadItems(with: request)
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchBar.text?.count == 0 {
            loadItems()
            
            DispatchQueue.main.async {
                searchBar.resignFirstResponder()
            }
        }
    }
}
