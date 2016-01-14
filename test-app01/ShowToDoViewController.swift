//
//  ShowToDoViewController.swift
//  test-app01
//
//  Created by Daniel Schwenk on 14/01/16.
//  Copyright © 2016 ds-131860. All rights reserved.
//

import UIKit

class ShowToDoViewController: UIViewController {

    @IBOutlet weak var show_todo_title: UILabel!
    @IBOutlet weak var show_todo_description: UILabel!
    @IBOutlet weak var show_todo_date: UIDatePicker!
    
    var todo_item: ToDoEntity?;
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        // show ToDo data
        show_todo_title.text = todo_item!.todo_title;
        show_todo_description.text = todo_item!.todo_desc;
        show_todo_date.date = todo_item!.todo_date;
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
