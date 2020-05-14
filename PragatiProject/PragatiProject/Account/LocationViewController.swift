//
//  LocationViewController.swift
//  PragatiProject
//
//  Created by Pragati Pandey on 14/05/20.
//  Copyright © 2020 PragatiPandey. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class LocationViewController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate{

    @IBOutlet weak var mapView: MKMapView!
    
    let locationManager: CLLocationManager = {
        let manager = CLLocationManager()
        manager.requestWhenInUseAuthorization()
        return manager
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpMapView()
    }
    
    //MARK: Setting MapView
    func setUpMapView() {
        mapView.delegate = self
        mapView.showsUserLocation = true
        mapView.isZoomEnabled = true
        mapView.showsCompass = true
        mapView.mapType = .standard
        self.getUserCurrentLocation()
    }
    
    //MARK: Current Location
    func getUserCurrentLocation() {
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        if #available(iOS 11.0, *) {
            locationManager.showsBackgroundLocationIndicator = true
        }
        locationManager.startUpdatingLocation()
    }
   
    //MARK: CLLocationManager Delegatyes
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location = locations.last! as CLLocation
        let currentLocation = location.coordinate
        self.addAnnotationsOnMapView(cordinates: currentLocation)
        let coordinateRegion = MKCoordinateRegion(center: currentLocation, latitudinalMeters: 800, longitudinalMeters: 800)
        mapView.setRegion(coordinateRegion, animated: true)
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error.localizedDescription)
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        print(status)
    }
    
    // adding annotations
    func addAnnotationsOnMapView(cordinates: CLLocationCoordinate2D) {
           let annotaion = MKPointAnnotation()
           annotaion.title = "Lucknow"
           annotaion.subtitle = "Triveni Nagar"
           annotaion.coordinate = cordinates
           mapView.addAnnotation(annotaion)
       }
       
    //MARK: MapView Delegates
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        mapView.delegate = self
        guard annotation is MKPointAnnotation else { return nil }
        let identifier = "CurrentLocation"
        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier)
        if annotationView == nil {
            annotationView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: identifier)
            annotationView!.canShowCallout = true
        } else {
            annotationView!.annotation = annotation
        }
        return annotationView
    }

}
