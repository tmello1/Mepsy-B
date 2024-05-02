//
//  ViewController.swift
//  ThisApp
//
//  Created by user257736 on 4/18/24.
//

import UIKit
import MapKit
import GooglePlaces

class ViewController: UIViewController , CLLocationManagerDelegate{

    @IBOutlet weak var myMap: MKMapView!
    
    let locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        locationManager.delegate = self
        
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        
        if(CLLocationManager.locationServicesEnabled()){
            locationManager.requestLocation()
            locationManager.startUpdatingLocation()
        }
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]){
        if let userLocation = locations.first{
            manager.stopUpdatingLocation()
            
            let coordinates = CLLocationCoordinate2D(latitude: locationManager.location?.coordinate.latitude ?? 0.0, longitude: locationManager.location?.coordinate.longitude ?? 0.0)
            
            let span = MKCoordinateSpan (latitudeDelta: 0.1, longitudeDelta: 0.1)
            
            let region = MKCoordinateRegion(center: coordinates, span: span)
            
            myMap.setRegion(region, animated: true)
            
            let restRequest = MKLocalSearch.Request()
            restRequest.naturalLanguageQuery = "restaurant"
            restRequest.region = MKCoordinateRegion(center: coordinates, latitudinalMeters: 5000, longitudinalMeters: 5000)
            
            let restSearch = MKLocalSearch(request: restRequest)
            restSearch.start { restResponse, restError in
                guard let restResponse = restResponse else {
                    print("Error searching for restaurants: \(restError?.localizedDescription ?? "Unknown error")")
                    return
                }
                for item in restResponse.mapItems{
                    let annotation = MKPointAnnotation()
                    annotation.title = item.name
                    annotation.coordinate = item.placemark.coordinate
                    self.myMap.addAnnotation(annotation)
                }
                
            }
            
            let parkRequest = MKLocalSearch.Request()
            parkRequest.naturalLanguageQuery = "park"
            parkRequest.region = MKCoordinateRegion(center: coordinates, latitudinalMeters: 5000, longitudinalMeters: 5000)
                        
            let parkSearch = MKLocalSearch(request: parkRequest)
            parkSearch.start { parkResponse, parkError in
                guard let parkResponse = parkResponse else {
                    print("Error searching for restaurants: \(parkError?.localizedDescription ?? "Unknown error")")
                    return
                }
                for item in parkResponse.mapItems{
                    let annotation = MKPointAnnotation()
                    annotation.title = item.name
                    annotation.coordinate = item.placemark.coordinate
                    self.myMap.addAnnotation(annotation)
                }
                            
            }
            
            let musRequest = MKLocalSearch.Request()
            musRequest.naturalLanguageQuery = "museum"
            musRequest.region = MKCoordinateRegion(center: coordinates, latitudinalMeters: 5000, longitudinalMeters: 5000)
                        
            let musSearch = MKLocalSearch(request: musRequest)
            musSearch.start { musResponse, musError in
                guard let musResponse = musResponse else {
                    print("Error searching for restaurants: \(musError?.localizedDescription ?? "Unknown error")")
                    return
                }
                for item in musResponse.mapItems{
                    let annotation = MKPointAnnotation()
                    annotation.title = item.name
                    annotation.coordinate = item.placemark.coordinate
                    self.myMap.addAnnotation(annotation)
                }
                            
            }
            
            let mallRequest = MKLocalSearch.Request()
            mallRequest.naturalLanguageQuery = "mall"
            mallRequest.region = MKCoordinateRegion(center: coordinates, latitudinalMeters: 5000, longitudinalMeters: 5000)
                        
            let mallSearch = MKLocalSearch(request: mallRequest)
            mallSearch.start { mallResponse, mallError in
                guard let mallResponse = mallResponse else {
                    print("Error searching for restaurants: \(mallError?.localizedDescription ?? "Unknown error")")
                    return
                }
                for item in mallResponse.mapItems{
                    let annotation = MKPointAnnotation()
                    annotation.title = item.name
                    annotation.coordinate = item.placemark.coordinate
                    self.myMap.addAnnotation(annotation)
                }
                            
            }
            //let myPin = MKPointAnnotation()
            //myPin.coordinate = coordinates
            //myPin.title = "Hey There"
            //myPin.subtitle = "I'm Here!"
            //myMap.addAnnotation(myPin)
            
            
            //let pinOne = MKPointAnnotation()
            //pinOne.coordinate = CLLocationCoordinate2D(latitude: 41.76768, longitude: -71.34146)
            //pinOne.title = "Riverside Covenant Church"
            //pinOne.subtitle = "This is a Church"
            //myMap.addAnnotation(pinOne)
            
            //let pinTwo = MKPointAnnotation()
            //pinTwo.coordinate = CLLocationCoordinate2D(latitude: 41.76732, longitude: -71.33701)
            //pinTwo.title = "Pal for Cats"
            //pinTwo.subtitle = "Local Business"
            //myMap.addAnnotation(pinTwo)
            
            //let pinThree = MKPointAnnotation()
            //pinThree.coordinate = CLLocationCoordinate2D(latitude: 41.76011, longitude: -71.34136)
            //.title = "Subway"
            //pinThree.subtitle = "Restaurant"
            //myMap.addAnnotation(pinThree)
        }
    }
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        switch manager.authorizationStatus{
        case .authorizedAlways:
            return
        case .authorizedWhenInUse:
            return
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
        case .restricted:
            locationManager.requestWhenInUseAuthorization()
        case .denied:
            return
        default:
            locationManager.requestWhenInUseAuthorization()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error){
        print(error)
    }
    
}

