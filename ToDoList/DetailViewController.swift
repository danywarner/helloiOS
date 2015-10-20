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

    @IBOutlet weak var descriptionLabel: UILabel!
    
    @IBOutlet weak var dateLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("item \(item)")
        self.descriptionLabel.text=item
        // Do any additional setup after loading the view.
    }

    @IBAction func dateSelected(sender: UIDatePicker) {
        print("fecha seleccionada \(sender.date)")
        self.dateLabel.text = formatDate(sender.date)
    }
    
    func formatDate(date: NSDate) -> String {
        let formatter = NSDateFormatter()
        formatter.dateFormat = "dd/MM/yyyy HH:mm"
        return formatter.stringFromDate(date)
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
