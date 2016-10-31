//
//  DetailViewController.swift
//  CoreDataDemo
//
//  Created by Kokpheng on 10/24/16.
//  Copyright © 2016 Kokpheng. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    var person : Person!

    @IBOutlet var nameLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()

        nameLabel.text = person.name
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
