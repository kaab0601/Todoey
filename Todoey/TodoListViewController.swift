//
//  ViewController.swift
//  Todoey
//
//  Created by Aboubacar Kanadji on 9/27/18.
//  Copyright © 2018 Aboubacar. All rights reserved.
//

import UIKit

class TodoListViewController: UITableViewController {

    var itemArray = ["By Eggs", "Buy some meat", "Buy some fish"]
    let defaults = UserDefaults.standard
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        if let item = self.defaults.array(forKey: "NewItemEntered") as? [String] {
        itemArray = item
        }
    }
    
    //MARK - TableView Datasource Methods
   
    //TODO: Declare numberOfRowsInSection here:
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
        cell.textLabel?.text = itemArray[indexPath.row]
        
        return cell
        
    }
    
    //MARK - TableView Delegate Methods
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if(tableView.cellForRow(at: indexPath)?.accessoryType == .checkmark)
        {
            tableView.cellForRow(at: indexPath)?.accessoryType = .none
        }
        else
        {
          tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
        }
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    @IBAction func addNewItem(_ sender: Any) {
        var NewItemEntered = UITextField()
        
        let alert = UIAlertController(title: "Enter a New Item", message: "", preferredStyle: .alert)
        let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
            self.itemArray.append(NewItemEntered.text!)
            self.tableView.reloadData()
            self.defaults.set(self.itemArray, forKey: "NewItemEntered")
        }
        alert.addTextField { (alertTexField) in
            alertTexField.placeholder = "Enter a New Item"
            NewItemEntered = alertTexField
    
        }
        
        alert.addAction(action)
        
        present(alert, animated: true, completion: nil)
    }
    
}

