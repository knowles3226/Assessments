//
//  ViewController.swift
//  Assessments
//
//  Created by matthew knowles on 29/03/2018.
//  Copyright © 2018 matthew knowles. All rights reserved.
//

import UIKit
import CoreData

class ToDoListViewController: UITableViewController {
    
    var itemArray = [Item]()
    
    var selectedCategory : ChildMain? {
        didSet{
            loadItems()
        }
    }
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        print(FileManager.default.urls(for: .documentDirectory, in: .userDomainMask))
        
        
    }

    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
        
        let item = itemArray[indexPath.row]
        
        cell.textLabel?.text = item.title
        
        
        return cell
        
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
      
        saveItems()
        
        tableView.deselectRow(at: indexPath, animated: true)
        
        
        
    }
    
    func saveItems() {
        
        
        do{
            try context.save()
        } catch {
            print("Error saving context \(error)")
        }
        
        self.tableView.reloadData()
        
    }
    
    func loadItems(with request: NSFetchRequest<Item> = Item.fetchRequest()) {
        
        let predicate = NSPredicate(format: "parentCategory.name MATCHES %@", selectedCategory!.title!)

        request.predicate = predicate
        
        request.sortDescriptors = [NSSortDescriptor(key: "title", ascending: true)]
        
        do{
        itemArray = try context.fetch(request)
        } catch {
            print("Error fetching data from context\(error)")
        }
        
        tableView.reloadData()
    }
    
    
}
//
////MARK: - Search bar Methods
//
//extension ToDoListViewController: UISearchBarDelegate {
//
//    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
//
//        let request : NSFetchRequest<Item> = Item.fetchRequest()
//
//        request.predicate = NSPredicate(format: "title CONTAINS[cd] %@", searchBar.text!)
//
//        request.sortDescriptors = [NSSortDescriptor(key: "title", ascending: true)]
//
//        loadItems(with: request)
//
//    }
//
//    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
//
//        if searchBar.text?.count == 0 {
//            loadItems()
//
//            DispatchQueue.main.async {
//              searchBar.resignFirstResponder()
//            }
//
//
//        }
//
//    }
//
//}






















