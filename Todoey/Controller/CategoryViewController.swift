//
//  CategoryViewController.swift
//  Todoey
//
//  Created by Aboubacar Kanadji on 10/4/18.
//  Copyright © 2018 Aboubacar. All rights reserved.
//

import UIKit
import CoreData

class CategoryViewController: UITableViewController {
    
    var categoryArray = [Category]()
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadData()

    }
    
   

    //MARK: - TableView DataSource Methods
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categoryArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell", for: indexPath)
        cell.textLabel?.text = categoryArray[indexPath.row].name
        
        return cell
        
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
         performSegue(withIdentifier: "goToItems", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as! TodoListViewController
        
        if let indexPath = tableView.indexPathForSelectedRow{
            destinationVC.selectedCategory = categoryArray[indexPath.row]
        }
    }
    
    
    //MARK: - Data Manipulation Methods
    
    
    //MARK: - Add New Category
    
    @IBAction func addButtonPress(_ sender: UIBarButtonItem) {
        var NewItemEntered = UITextField()
        let alert = UIAlertController(title: "Enter a New Category", message: "", preferredStyle: .alert)
        let action = UIAlertAction(title: "Add Category", style: .default) { (action) in
            
            let newItem = Category(context: self.context)  // Declare a new item variable object of the database
            newItem.name = NewItemEntered.text! // load the variables
            self.categoryArray.append(newItem)
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
    func loadData(with request : NSFetchRequest<Category> = Category.fetchRequest())
    {
        
        do {
            categoryArray = try context.fetch(request)
        }catch{
            
        }
        tableView.reloadData()
    }
    
    
    /* End of Load data function*/
}
