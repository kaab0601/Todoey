//
//  ViewController.swift
//  Todoey
//
//  Created by Aboubacar Kanadji on 9/27/18.
//  Copyright © 2018 Aboubacar. All rights reserved.
//

import UIKit

class TodoListViewController: UITableViewController {
    
    var itemArray = [Item]()
      let dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("Item.plist")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        loadData()
        
  
       // print(dataFilePath)
        
    }
    
    //MARK - TableView Datasource Methods
    
    //TODO: Declare numberOfRowsInSection here:
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
        cell.textLabel?.text = itemArray[indexPath.row].title
        
        cell.accessoryType = itemArray[indexPath.row].done ? .checkmark: .none
        
        
        return cell
        
    }
    
    //MARK - TableView Delegate Methods
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        itemArray[indexPath.row].done = !itemArray[indexPath.row].done
        tableView.reloadData()
        self.saveData()
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    @IBAction func addNewItem(_ sender: Any) {
        var NewItemEntered = UITextField()
        
        let alert = UIAlertController(title: "Enter a New Item", message: "", preferredStyle: .alert)
        let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
            let newItemPresent = Item()
            newItemPresent.title = NewItemEntered.text!
            self.itemArray.append(newItemPresent)
            self.tableView.reloadData()
            self.saveData()
    
        }
        alert.addTextField { (alertTexField) in
            alertTexField.placeholder = "Enter a New Item"
            NewItemEntered = alertTexField
            
        }
        
        alert.addAction(action)
        
        present(alert, animated: true, completion: nil)
    }
    
    /* function to save data to the plist database */
    func saveData()
    {
        let encoder = PropertyListEncoder()
        
        do
        {
            let data = try encoder.encode(self.itemArray)
            try data.write(to: self.dataFilePath!)
        }catch{
            
        }
    }
    /* End of save data function*/
    
    
    /* function to load data from the plist database */
    func loadData()
    {
       if let data = try? Data(contentsOf: dataFilePath!)
       {
        
            let decoder = PropertyListDecoder()
        
            do
            {
                itemArray = try decoder.decode([Item].self, from: data)
            }catch{
            
            }
       }
    }
    
    /* End of Load data function*/
    
}

