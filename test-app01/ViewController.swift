//
//  ViewController.swift
//  test-app01
//
//  Created by ds-131860 on 12.01.16.
//  Copyright (c) 2016 ds-131860. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UITableViewController {

    let context = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext;

    var daten =  [ToDoEntity]();
   
    
    override func viewDidAppear(animated: Bool) {
        
        print("ViewController - viewDidAppear");

        // load data from core data
        loadData();
    }
    

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    
    /**
     * Function to laod data from core data
     */
    func loadData(){
        print("call loadData")
        
        // create request
        let request = NSFetchRequest(entityName: "ToDoEntity");
        
        // fetch data
        do {
            try  daten = context!.executeFetchRequest(request) as! [ToDoEntity];
        }
        catch {
            // catch error - do something
        }
    
        // if there is any data reload table view
        if(daten.count >= 1){
            tableView.reloadData();
        }
        
    }
    
    
    func showString(){
        // http://stackoverflow.com/questions/28532926/if-no-table-view-results-display-no-results-on-screen
        
        // create label
        var noDataLabel: UILabel = UILabel(frame: CGRectMake(0, 0, self.tableView.bounds.size.width, self.tableView.bounds.size.height))
        //noDataLabel.text = "keine Einträge :)"
        noDataLabel.textColor = UIColor(red: 22.0/255.0, green: 106.0/255.0, blue: 176.0/255.0, alpha: 1.0)
        noDataLabel.textAlignment = NSTextAlignment.Center
        self.tableView.backgroundView = noDataLabel
        
        // set label text
        if(daten.count == 0){
            noDataLabel.text = "keine Einträge :)"
        }
        else {
            noDataLabel.text = ""
        }
    }
    
    
    
    

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Potentially incomplete method implementation.
        // Return the number of sections.
        showString()
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete method implementation.
        // Return the number of rows in the section.

        return daten.count;
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cell_id", forIndexPath: indexPath)
        // set to do tile as text
        cell.textLabel!.text = daten[indexPath.row].todo_title;
        
        return cell;
    }
    
    
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the specified item to be editable.
        return true;
    }
    
    
    
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            context!.deleteObject(daten[indexPath.row]);
            do {
                try context!.save()
            } catch _ {
            };
            
            
            let request = NSFetchRequest(entityName: "ToDoEntity");
            do {
                try  daten = context!.executeFetchRequest(request) as! [ToDoEntity];
            }
            catch {
                // do somethin
            }
            
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        }
    }
    
    
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // uebergebe die Daten an ShowToDo
        if(segue.identifier == "segue_show_todo"){
            (segue.destinationViewController as! ShowToDoViewController).todo_item = daten[tableView.indexPathForCell(sender as! UITableViewCell)!.row];
        }
    }

}

