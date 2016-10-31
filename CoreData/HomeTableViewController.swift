//
//  ViewController.swift
//  CoreData
//
//  Created by Kokpheng on 10/26/16.
//  Copyright © 2016 Kokpheng. All rights reserved.
//

import UIKit

class HomeTableViewController: UITableViewController, UISearchResultsUpdating {

    var data : [Person] = []
    
    var displayedData : [Person] = []
    
    var filteredData:[Person] = []
    
    var resultSearchController:UISearchController!
    
    var personService = PersonService()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        // 1
        resultSearchController = UISearchController(searchResultsController: nil)
        // 2
        resultSearchController.searchResultsUpdater = self
        // 3
        resultSearchController.hidesNavigationBarDuringPresentation = true
        // 4
        resultSearchController.dimsBackgroundDuringPresentation = false
        // 5
        resultSearchController.searchBar.searchBarStyle = UISearchBarStyle.Default
        // 6
        resultSearchController.searchBar.sizeToFit()
        // 7
        tableView.tableHeaderView = resultSearchController.searchBar
        tableView.setContentOffset(CGPointMake(0, 44), animated: true)
        
        
    
    }
    
    override func viewDidAppear(animated: Bool) {
        data = personService.getAll()
        displayedData = data
        tableView.reloadData()
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return displayedData.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("contactCell")
        
        let person =  displayedData[indexPath.row]
        cell?.textLabel?.text = person.name
        cell?.detailTextLabel?.text = "Age: \(person.age!)"
        cell?.imageView?.image = UIImage(data: person.profile!)
        
        return cell!
    }


    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    
    override func tableView(tableView: UITableView, editActionsForRowAtIndexPath indexPath: NSIndexPath) -> [UITableViewRowAction]? {
        let delete = UITableViewRowAction(style: .Normal, title: "Delete") { (action, index) in
            
            // find delete object by id
            let deletedPerson = self.personService.getById(self.displayedData[indexPath.row].objectID)
            
            // delete
            self.personService.delete((deletedPerson?.objectID)!)
            
            self.displayedData.removeAtIndex(indexPath.row)
            
            self.personService.saveChanges()
            
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)

            
        }
        
        let edit = UITableViewRowAction(style: .Default, title: "Edit") { (action, index) in
            
            self.performSegueWithIdentifier("showEdit", sender: self.displayedData[indexPath.row])
        }
        
        edit.backgroundColor = UIColor.brownColor()
        
        return [delete, edit]
    }
 
    
    // MARK : Search Controller
    func updateSearchResultsForSearchController(searchController: UISearchController) {
        
        if searchController.searchBar.text?.characters.count > 0 {
            // 1
            filteredData.removeAll(keepCapacity: false)
            // 2
            let searchPredicate = NSPredicate(format: "SELF.age CONTAINS[c] %@", searchController.searchBar.text!)

            // 4
            filteredData = personService.get(withPredicate: searchPredicate)
            displayedData = filteredData
            // 5
            tableView.reloadData()
            
        }else{
            displayedData = data
            //3
            tableView.reloadData()
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "showDetail" {
            let indexPath = tableView.indexPathForSelectedRow
            
            let destViewController = segue.destinationViewController as! DetailViewController
            destViewController.person = displayedData[(indexPath?.row)!]
            
        }else if segue.identifier == "showEditInfo" {
            let destViewController = segue.destinationViewController as! AddEditTableViewController
            destViewController.person = sender as! Person
        }

    }

}








