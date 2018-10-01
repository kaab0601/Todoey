//
//  ViewController.swift
//  Todoey
//
//  Created by Aboubacar Kanadji on 9/27/18.
//  Copyright © 2018 Aboubacar. All rights reserved.
//

import UIKit
import CoreData

class TodoListViewController: UITableViewController {
    
    var itemArray = [Items]()
      let dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("Item.plist")
    
    // create a delegate for saving values
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
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
      
        let newItem = Items(context: self.context)  // Declare a new item variable object of the database
        newItem.title = NewItemEntered.text! // load the variables
        newItem.done = false
        self.itemArray.append(newItem)
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
        do
        {
            try context.save()
        }catch{
            
        }
    }
    /* End of save data function*/
    
    
    /* function to load data from the plist database */
    func loadData()
    {
        let request : NSFetchRequest<Items> = Items.fetchRequest()
        do {
            itemArray = try context.fetch(request)
        }catch{
            
        }
    }
    
    /* End of Load data function*/
    
}

