//
//  AddEditTableViewController.swift
//  CoreDataDemo
//
//  Created by Kokpheng on 10/26/16.
//  Copyright © 2016 Kokpheng. All rights reserved.
//

import UIKit

class AddEditTableViewController: UITableViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate  {

    var person : Person!
    
    @IBOutlet var profileImageView: UIImageView!
    @IBOutlet var nameTextField: UITextField!
    
    @IBOutlet var ageTextField: UITextField!
    
    let imagePicker = UIImagePickerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // set delegate for imagePicker
        imagePicker.delegate = self
        
        if person != nil {
            nameTextField.text = person.name
            ageTextField.text = "\(person.age!)"
            profileImageView.image = UIImage(data: person.profile!)
        }
    }


    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }

    /*
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("reuseIdentifier", forIndexPath: indexPath)

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    @IBAction func brosweImage(sender: AnyObject) {
        imagePicker.allowsEditing = false
        imagePicker.sourceType = .PhotoLibrary
        
        // show image picker
        presentViewController(imagePicker, animated: true, completion: nil)
        
    }
    
    // MARK: - UIImagePickerControllerDelegate Methods
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        
        if let pickedImage = info[UIImagePickerControllerOriginalImage] as? UIImage{
            profileImageView.contentMode = .ScaleAspectFit
            profileImageView.image = pickedImage
        }
        
        dismissViewControllerAnimated(true, completion: nil)
        
    }
    
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    
    @IBAction func saveData(sender: AnyObject) {
        // Create an instance of the service.
        let personService = PersonService()
        var age = 18
        
        if let personAge = Int(ageTextField.text!) {
            age =  personAge
        }
        
        if person != nil{
            // update
            person.name = nameTextField.text
            person.age = age
            person.profile = UIImageJPEGRepresentation(profileImageView.image!, 0.2)
            personService.update(person)
        }else{
            // create
            personService.create(nameTextField.text!,
                                 age: age,
                                 profile: UIImageJPEGRepresentation(profileImageView.image!, 0.2)!)
        }
        personService.saveChanges()
        self.navigationController?.popViewControllerAnimated(true) // After save go back to home.
    }
    
    
    
    

}
