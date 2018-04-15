//
//  CategoryViewController.swift
//  Assessments
//
//  Created by matthew knowles on 14/04/2018.
//  Copyright © 2018 matthew knowles. All rights reserved.
//

import UIKit
import CoreData

class CategoryViewController: UITableViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate{

    var categoryArray = [Category]()
    
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.backgroundView = UIImageView(image: #imageLiteral(resourceName: "MainBG"))
        loadCategories()
    }
    
    override var prefersStatusBarHidden: Bool {
    return true
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 155
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categoryArray.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell", for: indexPath) as! customCell
        
        cell.backgroundColor = UIColor.clear
        
        let item = categoryArray[indexPath.row]
        
        if let personLoadedImage = UIImage(data: item.image as! Data) {
            cell.personImage.image = personLoadedImage
        }
        
        
        cell.nameLabel?.text = item.name
        return cell
        
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        performSegue(withIdentifier: "goToItems", sender: self)
       
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as! ChildsViewController
        
        if let indexPath = tableView.indexPathForSelectedRow {
            
          destinationVC.selectedCategory = categoryArray[indexPath.row]
            
        }
        
    }
    
    //MARK - Add New Items
    
    
    @IBAction func addButtonPressed(with image:UIImage) {
        
        let alertController = UIAlertController(title: "Select a device", message: "Where would you like to add the picture from?", preferredStyle: UIAlertControllerStyle.alert)
        
        alertController.addAction(UIAlertAction(title: "Camera", style: .default, handler: { action in
            
            self.openCamera()
        }))
        alertController.addAction(UIAlertAction(title: "Library", style: .default, handler: { action in
            
            self.openLibrary()
        }))
        let defaultAction = UIAlertAction(title: "Cancel", style: .default, handler: nil)
        alertController.addAction(defaultAction)
        
        
        present(alertController, animated: true, completion: nil)
        
        alertController.popoverPresentationController?.sourceView = self.view
    
        
//        let imagePicker = UIImagePickerController()
//        imagePicker.sourceType = .photoLibrary
//
//        imagePicker.delegate = self
//
//        self.present(imagePicker, animated: true, completion: nil)
        
//        var textField = UITextField()
//
//        let alert = UIAlertController(title: "Add new Category", message: "", preferredStyle: .alert)
//
//        let action = UIAlertAction(title: "Add", style: .default) { (action) in
//
//            let newCategory = Category(context: self.context)
//            newCategory.name = textField.text!
//
//            self.categoryArray.append(newCategory)
//
//            self.saveCategories()
//        }
//
//        alert.addTextField { (alertTextField) in
//            alertTextField.placeholder = "Create new item"
//            textField = alertTextField
//        }
//
//
//        alert.addAction(action)
//
//        present(alert, animated: true, completion: nil)
        
    }

func openCamera(){
    
            let imagePicker = UIImagePickerController()
            imagePicker.sourceType = .camera
            imagePicker.delegate = self
    
            self.present(imagePicker, animated: true, completion: nil)
}

func openLibrary(){

            let imagePicker = UIImagePickerController()
            imagePicker.sourceType = .photoLibrary
    
            imagePicker.delegate = self
    
            self.present(imagePicker, animated: true, completion: nil)
}
    

    
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        
        picker.dismiss(animated: true, completion: nil)
        
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage {
            dismiss(animated: true, completion: {
                self.createPersonIten(with: image)
            })
            
            
        }
   
    }


    func createPersonIten (with image:UIImage) {
        
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add new Category", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add", style: .default) { (action) in
            
            let newCategory = Category(context: self.context)
            newCategory.name = textField.text!
            newCategory.image = NSData(data: UIImageJPEGRepresentation(image, 0.3)!) as Data
            
            self.categoryArray.append(newCategory)
            
            self.saveCategories()
        }
        
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create new item"
            textField = alertTextField
        }
        
        
        alert.addAction(action)
        
        present(alert, animated: true, completion: nil)
        
        
    }
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if (editingStyle == UITableViewCellEditingStyle.delete) {
            context.delete(categoryArray[indexPath.row])
            categoryArray.remove(at: indexPath.row)
            saveCategories()
        }
    }
    
    
    
    
    func saveCategories() {
        
        do{
            try context.save()
        } catch {
            print("Error saving context \(error)")
        }
        
        self.tableView.reloadData()
        
    }
    
    func loadCategories(with request: NSFetchRequest<Category> = Category.fetchRequest()) {
        
        do{
            categoryArray = try context.fetch(request)
        } catch {
            print("Error fetching data from context\(error)")
        }
        
        tableView.reloadData()
    }
}
