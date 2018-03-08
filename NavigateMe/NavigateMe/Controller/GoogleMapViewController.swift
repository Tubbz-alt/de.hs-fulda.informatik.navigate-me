//
//  GoogleMapViewController.swift
//  NavigateMe
//
//  Created by mahbub on 2/26/18.
//  Copyright © 2018 Fulda University Of Applied Sciences. All rights reserved.
//

import UIKit
import CoreLocation
import GoogleMaps

class GoogleMapViewController: UIViewController, CLLocationManagerDelegate, GMSMapViewDelegate, EngineDelegate {

    let navigation = NEngine()
    
    let floorStringValues = ["Floor: 0", "Floor: 1", "Floor: 3"]
    let floorIntValues = [0, 1, 3]

    let raumCoordinates = [265 : CLLocationCoordinate2D(latitude: 50.565298849995976, longitude: 9.6852341294288635), 268 : CLLocationCoordinate2D(latitude: 50.565215579880096, longitude: 9.6854306012392044),
                           285 : CLLocationCoordinate2D(latitude: 50.56502092742393, longitude: 9.68596201390028), 288 : CLLocationCoordinate2D(latitude: 50.564916359962844, longitude: 9.6858654543757439),
                           291 : CLLocationCoordinate2D(latitude: 50.564991324846488, longitude: 9.6857001632452011), 292 : CLLocationCoordinate2D(latitude: 50.565034344413327, longitude: 9.6857383847236633),
                           266 : CLLocationCoordinate2D(latitude: 50.565298849995976, longitude: 9.6852341294288635), 362 : CLLocationCoordinate2D(latitude: 50.565114633301896, longitude: 9.6853353828191757),
                           364 : CLLocationCoordinate2D(latitude: 50.565175542022637, longitude: 9.6851184591650963), 369 : CLLocationCoordinate2D(latitude: 50.565220052191847, longitude: 9.6854326128959656),
                           378 : CLLocationCoordinate2D(latitude: 50.565155097146139, longitude: 9.6856230497360229), 386 : CLLocationCoordinate2D(latitude: 50.565025612722266, longitude: 9.6859667077660561),
                           388 : CLLocationCoordinate2D(latitude: 50.564925943548381, longitude: 9.6858768537640572), 390 : CLLocationCoordinate2D(latitude: 50.564996223115983, longitude: 9.6857068687677383),
                           396 : CLLocationCoordinate2D(latitude: 50.565055641214094, longitude: 9.6855281665921211), 591 : CLLocationCoordinate2D(latitude: 50.565154671211111, longitude: 9.6851573511958122),
                           593 : CLLocationCoordinate2D(latitude: 50.565230487584301, longitude: 9.6851164475083351), 595 : CLLocationCoordinate2D(latitude: 50.565317378109164, longitude: 9.6852515637874603)]
    
    let universityCampusArea = CLLocationCoordinate2D(latitude: 50.5650077, longitude: 9.6853589)
    let centerCoordinateGeb46E = CLLocationCoordinate2D(latitude: 50.5650899, longitude: 9.6855439)
    
    let stepsInsideUniversity = [CLLocationCoordinate2D(latitude: 50.563954500000001, longitude: 9.6852432000000004) : [CLLocationCoordinate2D(latitude: 50.564386278163909, longitude: 9.6856210380792618)], CLLocationCoordinate2D(latitude: 50.564197700000001, longitude: 9.6845296999999988) : [CLLocationCoordinate2D(latitude: 50.564402676926854, longitude: 9.684707410633564), CLLocationCoordinate2D(latitude: 50.564451873181468, longitude: 9.6849659085273743), CLLocationCoordinate2D(latitude: 50.564930841824669, longitude: 9.6854161843657494), CLLocationCoordinate2D(latitude: 50.56500942714424, longitude: 9.6854879334568977)],
                                  CLLocationCoordinate2D(latitude: 50.565794099999998, longitude: 9.6842638000000001) : [CLLocationCoordinate2D(latitude: 50.565713068718303, longitude: 9.6844733878970146), CLLocationCoordinate2D(latitude: 50.565364443743256, longitude: 9.6854192018508911), CLLocationCoordinate2D(latitude: 50.565274571767681, longitude: 9.6853400766849518)], CLLocationCoordinate2D(latitude: 50.565069800000003, longitude: 9.6862168000000004) : [CLLocationCoordinate2D(latitude: 50.564897192785949, longitude: 9.6860646083950996), CLLocationCoordinate2D(latitude: 50.5649281, longitude: 9.6859788)]]
    
    let subStepsInsideUniversity = [CLLocationCoordinate2D(latitude: 50.563954500000001, longitude: 9.6852432000000004) : [1 : [CLLocationCoordinate2D(latitude: 50.56500942714424, longitude: 9.6854879334568977), CLLocationCoordinate2D(latitude: 50.564930841824669, longitude: 9.6854161843657494), CLLocationCoordinate2D(latitude: 50.564386278163909, longitude: 9.6856210380792618)], 2 : [CLLocationCoordinate2D(latitude: 50.5649281, longitude: 9.6859788), CLLocationCoordinate2D(latitude: 50.564897192785949, longitude: 9.6860646083950996), CLLocationCoordinate2D(latitude: 50.564386278163909, longitude: 9.6856210380792618)]]]
    
    let locationManager = CLLocationManager()
    
    var geb: String? = nil
    var floor: Int? = nil
    var raum: Int? = nil
    var duration: String? = nil
    var googleDirection: GoogleDirection? = nil
    var raumMarker: GMSMarker? = nil
    
    override func viewDidLoad() {
        
        super.viewDidLoad()

        let cameraPostion = GMSCameraPosition.camera(withLatitude: self.universityCampusArea.latitude, longitude: universityCampusArea.longitude, zoom: 20) // 18
        
        let mapView = GMSMapView.map(withFrame: .zero, camera: cameraPostion)
        mapView.delegate = self
        mapView.isMyLocationEnabled = true
        mapView.settings.myLocationButton = true
        mapView.settings.compassButton = true
        
        let groundOverlay = GMSGroundOverlay(position: self.centerCoordinateGeb46E, icon: UIImage(named: "E\(self.floor!).png"), zoomLevel: CGFloat(19.7))
        groundOverlay.bearing = 30
        groundOverlay.map = mapView
        
        let raumIntValue = self.geb!.sumOfAsciiValues() + self.floor! + self.raum!
        self.raumMarker = GMSMarker(position: self.raumCoordinates[raumIntValue]!)
        self.raumMarker!.title = "Free for next \(self.duration!)"
        self.raumMarker!.map = mapView
        
        self.view = mapView
        
        let floorSwitcher = UISegmentedControl(items: self.floorStringValues)
        floorSwitcher.selectedSegmentIndex = self.floorIntValues.index(where: { $0 == self.floor! })!
        floorSwitcher.autoresizingMask = .flexibleWidth
        floorSwitcher.frame = CGRect(x: 0, y: 0, width: 300, height: 200)
        floorSwitcher.addTarget(self, action: #selector(GoogleMapViewController.drawFloorPlanOnMap(_:)), for: .valueChanged)
        self.navigationItem.titleView = floorSwitcher
        
        self.navigation.delegate = self
        
        self.locationManager.delegate = self
        self.locationManager.requestWhenInUseAuthorization()
        self.locationManager.desiredAccuracy = kCLLocationAccuracyBestForNavigation
        self.locationManager.activityType = CLActivityType.otherNavigation
        self.locationManager.distanceFilter = 100
        self.locationManager.startUpdatingLocation()
    }
    
    @IBAction func drawFloorPlanOnMap(_ sender: UISegmentedControl) {
        
        let mapView = self.view as! GMSMapView
        let currentFloor = self.floorIntValues[sender.selectedSegmentIndex]
        
        let groundOverlay = GMSGroundOverlay(position: self.centerCoordinateGeb46E, icon: UIImage(named: "E\(currentFloor).png"), zoomLevel: CGFloat(19.7))
        groundOverlay.bearing = 30
        groundOverlay.zIndex = /*currentFloor == self.floor! ?*/ 0 //: 1
        groundOverlay.map = mapView
        
        self.raumMarker?.map = currentFloor == self.floor! ? mapView : nil
        
        mapView.animate(toLocation: self.centerCoordinateGeb46E)
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        let currentLocation = locations.last!
        
        (self.view as! GMSMapView).animate(toLocation: currentLocation.coordinate)
        
        let origin = currentLocation.coordinate
        self.navigation.getDirectionFromDistanceMatrix(origins: [origin], destinations: self.stepsInsideUniversity.keys.sorted(by: { destCoord1, destCoord2 in destCoord1.hashValue < destCoord2.hashValue }))
    }

    func mapView(_ mapView: GMSMapView, didTapAt coordinate: CLLocationCoordinate2D) {
        
        print("\nTap At: \(coordinate)\n")
        let tapMarker = GMSMarker(position: coordinate)
        tapMarker.title = "\(coordinate.latitude), \(coordinate.longitude)"
        tapMarker.map = mapView
        
        self.navigation.getDirectionFromDistanceMatrix(origins: [coordinate], destinations: self.stepsInsideUniversity.keys.sorted(by: { destCoord1, destCoord2 in destCoord1.hashValue < destCoord2.hashValue }))
    }
    
    func processDidComplete(then dto: Any) {
        
        let steps = dto as! [GoogleStep]
        
        DispatchQueue.main.async {
            
            let mapView = self.view as! GMSMapView
            let path = GMSMutablePath()
            
            steps.forEach { step in
                
                path.add(CLLocationCoordinate2D(latitude: step.start_location.lat, longitude: step.start_location.lng))
                path.add(CLLocationCoordinate2D(latitude: step.end_location.lat, longitude: step.end_location.lng))
            }
            
            let lastStep = steps.last!
            let destination = CLLocationCoordinate2D(latitude: lastStep.end_location.lat, longitude: lastStep.end_location.lng)
            
            // steps inside university
            self.stepsInsideUniversity[destination]!.forEach { step in path.add(step) }
            
            let polyline = GMSPolyline(path: path)
            polyline.strokeWidth = 5
            polyline.strokeColor = UIColor.purple
            polyline.zIndex = 1
            polyline.map = mapView
            
            // sub steps inside university
            if let subSteps = self.subStepsInsideUniversity[destination] {
                
                for subStep in subSteps {
                    
                    let subPath = GMSMutablePath()
                    subStep.value.forEach { step in subPath.add(step) }
                    
                    let subPolyline = GMSPolyline(path: subPath)
                    subPolyline.strokeWidth = 5
                    subPolyline.strokeColor = subStep.key == 1 ? UIColor.purple : UIColor.gray
                    subPolyline.zIndex = 1
                    subPolyline.map = mapView
                }
            }
        }
    }
    
    func processDidAbort(reason message: String) {
        
        DispatchQueue.main.async {
            
            let abortAlert = UIAlertController(title: "Process is aborted.", message: "Reason: " + message, preferredStyle: .alert)
            let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { alertAction in
                
                // TODO - Back to existing FreeRaumViewController instance
            }
            abortAlert.addAction(cancelAction)
            self.present(abortAlert, animated: true)
        }
    }
    
}
