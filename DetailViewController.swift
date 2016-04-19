//
//  DetailViewController.swift
//  Paris Best Bars
//
//  Created by Vilayvone Bouahom on 19/04/16.
//  Copyright © 2016 Jbouahom. All rights reserved.
//

import UIKit
import MapKit
class DetailViewController: UIViewController , MKMapViewDelegate {
    @IBOutlet weak var barMap: MKMapView!
    //MARK: Properties
    var bar: Bar?
    override func viewDidLoad() {
        super.viewDidLoad()
        barMap.delegate=self
        let latitude = (bar?.latitude)! as Double
        let longitude = (bar?.longitude)! as Double
        let initialLocation = CLLocation(latitude: latitude, longitude: longitude)
        func centerMapOnLocation(location: CLLocation){
            let regionRadius:CLLocationDistance = 30000
            
            let coordinateRegion = MKCoordinateRegionMakeWithDistance(location.coordinate, regionRadius , regionRadius)
            barMap.setRegion(coordinateRegion, animated: false)
        }
        centerMapOnLocation(initialLocation)

        let barAnnotation = MKPointAnnotation()
        barAnnotation.coordinate = CLLocationCoordinate2DMake( latitude,longitude)
        barAnnotation.title = bar?.name
        barAnnotation.subtitle=bar?.address
        barMap.addAnnotation(barAnnotation)
        barMap.showAnnotations(barMap.annotations, animated: false)
        
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
