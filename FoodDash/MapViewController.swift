//
//  MapViewController.swift
//  FoodRun
//
//  Created by Kevin Ho on 4/15/16.
//  Copyright © 2016 KevinHo. All rights reserved.
//

import UIKit
import MapKit
import AFNetworking
import CoreLocation

class MapViewController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate {
    
    @IBOutlet weak var mapView: MKMapView!
    
    var locationManager: CLLocationManager!
    
    var location: NSDictionary!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        //Request Core Location
        locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        if CLLocationManager.locationServicesEnabled() {
            locationManager.startUpdatingLocation()
        }
        
        
        //Setup Map
        mapView.delegate = self
        mapView.showsUserLocation = true
        
        let view = location["location"]
        if (view!["latitude"] != nil)
        {
            let latitude = view!["latitude"] as! CLLocationDegrees
            let longitude = view!["longitude"] as! CLLocationDegrees
            let coordinate1 =
                CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        
            //Annotation Info
            let centerLocation = CLLocation(latitude: latitude, longitude: longitude)
        
            // Center zoom on target location
            goToLocation(centerLocation)
            zoomOnLocation(centerLocation)
            addAnnotationAtCoordinate(coordinate1)
        }
    }
    
    func goToLocation(location: CLLocation) {
        let latDelta = CLLocationDegrees(1.1)
        let lonDelta = CLLocationDegrees(1.1)
        let span = MKCoordinateSpanMake(latDelta, lonDelta)
        let region = MKCoordinateRegionMake(location.coordinate, span)
        mapView.setRegion(region, animated: true)
        // Need to set a delay before the next function plays
    }
    
    func zoomOnLocation(location: CLLocation) {
        let latDelta = CLLocationDegrees(0.01)
        let lonDelta = CLLocationDegrees(0.01)
        let span = MKCoordinateSpanMake(latDelta, lonDelta)
        let region = MKCoordinateRegionMake(location.coordinate, span)
        mapView.setRegion(region, animated: true)
    }
    
    func addAnnotationAtCoordinate(coordinate: CLLocationCoordinate2D) {
        let view = location["location"] as! [String: AnyObject]
        let locName = view["name"] as! String
        
        let annotation = MKPointAnnotation()
        annotation.coordinate = coordinate
        annotation.title = locName
        mapView.addAnnotation(annotation)
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