//
//  MapViewController.swift
//  Paris Best Bars
//
//  Created by Vilayvone Bouahom on 19/04/16.
//  Copyright © 2016 Jbouahom. All rights reserved.
//

import UIKit
import MapKit

class MapViewController: UIViewController, MKMapViewDelegate {
    @IBOutlet weak var barmap: MKMapView!

    func loadAnnotations(){
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
                    let barAnnotation = MKPointAnnotation()
                    barAnnotation.coordinate = CLLocationCoordinate2DMake( item["latitude"] as! Double,  item["longitude"] as! Double)
                    barAnnotation.title = item["name"] as! String
                    barAnnotation.subtitle=tags
                    barmap.addAnnotation(barAnnotation)
                }
                
                
            }
        } catch let error as NSError{
            print(error)
            return
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        barmap.delegate=self
        let initialLocation = CLLocation(latitude: 48.860033826521, longitude: 2.3508920416641)
        func centerMapOnLocation(location: CLLocation){
            let regionRadius:CLLocationDistance = 10000

            let coordinateRegion = MKCoordinateRegionMakeWithDistance(location.coordinate, regionRadius , regionRadius)
            barmap.setRegion(coordinateRegion, animated: false)
        }
        loadAnnotations()
        centerMapOnLocation(initialLocation)
}
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func mapViewDidFinishLoadingMap(mapView: MKMapView) {
        mapView.showAnnotations(mapView.annotations, animated: false)

    }
    func mapViewDidFailLoadingMap(mapView: MKMapView, withError error: NSError) {
        print(error)
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
