//
//  DetailViewController.swift
//  ToDoList
//
//  Created by Daniel Warner on 10/19/15.
//  Copyright © 2015 Daniel Warner. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    var item: String?

    override func viewDidLoad() {
        super.viewDidLoad()
        print("item \(item)")

        // Do any additional setup after loading the view.
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
