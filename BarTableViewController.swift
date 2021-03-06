//
//  BarTableViewController.swift
//  Paris Best Bars
//
//  Created by Vilayvone Bouahom on 18/04/16.
//  Copyright © 2016 Jbouahom. All rights reserved.
//

import UIKit

class BarTableViewController: UITableViewController {
    var bars=[Bar]()

    override func viewDidLoad() {
        super.viewDidLoad()
        loadBars()
        tableView.contentInset.top = 20
    }
    
    func loadBars(){
        // Je lis le JSON et je le transforme en objet Bar
        guard let path=NSBundle.mainBundle().pathForResource("Pense bete", ofType: "json")
            else{
                print("Error Finding file")
                return
        }
        do{
            let data: NSData?=NSData(contentsOfFile: path)
            if let jsonResult:NSDictionary! = try NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.MutableContainers)as? NSDictionary
            {
                let datadictionnary = jsonResult!["bars"] as! NSArray
                for item in datadictionnary {
                    var tags :String
                    tags = ""
                    if  item["tags"] is String{
                        tags = item["tags"] as! String
                    }
                    let bar=Bar.init( id: item["id"] as! Int,  address: item["address"] as! String,name: item["name"] as! String, url: item["url"] as! String, image_url: item["image_url"] as! String, tags: tags, latitude: item["latitude"] as! Float,longitude: item["latitude"] as! Float)
                    bars.append(bar)
                }
            }
        } catch let error as NSError{
                print(error)
                return
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return bars.count
    }


    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("BarTableViewCell", forIndexPath: indexPath) as! BarTableViewCell
        let bar=bars[indexPath.row]
        // je dl les images, de façon synchrone je devrais le faire de façon asynchrone
        cell.name.text=bar.name
        cell.tags.text=bar.tags
        let url = NSURL(string: bar.image_url)
        let data = NSData(contentsOfURL: url!)
        cell.barIMG.image=UIImage(data:data!)
        
        return cell
    }


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

}
