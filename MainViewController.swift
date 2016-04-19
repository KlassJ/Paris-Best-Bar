//
//  MainViewController.swift
//  Paris Best Bars
//
//  Created by Vilayvone Bouahom on 19/04/16.
//  Copyright © 2016 Jbouahom. All rights reserved.
//

import UIKit

class MainViewController: UIViewController , UITableViewDelegate, UITableViewDataSource{
    //MARK : Properties
    var bars=[Bar]()

    @IBOutlet weak var bartableView: UITableView!
    
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


    override func viewDidLoad() {
        super.viewDidLoad()
        loadBars()
        bartableView.delegate = self
        bartableView.dataSource = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return bars.count
    }
    
     func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
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
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
