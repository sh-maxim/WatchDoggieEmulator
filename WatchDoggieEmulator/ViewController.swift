//
//  ViewController.swift
//  WatchDoggieEmulator
//
//  Created by Administrator on 11/15/17.
//  Copyright © 2017 Maxim Inc. All rights reserved.
//

import Cocoa
import MapKit
//import UIKit

class ViewController: NSViewController, MKMapViewDelegate{
    @IBOutlet weak var myMapView1: MKMapView!
    @IBOutlet weak var myMapView2: MKMapView!
    @IBOutlet weak var myMapView3: MKMapView!
    
    @IBOutlet weak var myShowAllOtherUsers: NSButton!
    
    var myMapViews : [MKMapView] = []
    
    let myFixedRadius = 15.0
    let allowRadiusFluctuation = true
    
    var myPaths = [
                  [CLLocation(latitude: 39.986348, longitude: -75.151826),
                   CLLocation(latitude: 39.986422, longitude: -75.152341),
                   CLLocation(latitude: 39.985797, longitude: -75.152491),
                   CLLocation(latitude: 39.985887, longitude: -75.153264),
                   CLLocation(latitude: 39.985591, longitude: -75.153339),
                   CLLocation(latitude: 39.985698, longitude: -75.154144),
                   CLLocation(latitude: 39.984375, longitude: -75.154423),
                   CLLocation(latitude: 39.982928, longitude: -75.154734),
                   CLLocation(latitude: 39.981752, longitude: -75.155002),
                   CLLocation(latitude: 39.981687, longitude: -75.154519),
                   CLLocation(latitude: 39.981374, longitude: -75.154616),
                   CLLocation(latitude: 39.981423, longitude: -75.155066),
                   CLLocation(latitude: 39.980651, longitude: -75.155217),
                   CLLocation(latitude: 39.981438, longitude: -75.155057),
                   CLLocation(latitude: 39.981445, longitude: -75.154576),
                   CLLocation(latitude: 39.981532, longitude: -75.154379),
                   CLLocation(latitude: 39.981332, longitude: -75.154227),
                   CLLocation(latitude: 39.981215, longitude: -75.153430),
                   CLLocation(latitude: 39.981847, longitude: -75.153297),
                   CLLocation(latitude: 39.982723, longitude: -75.153153),
                   CLLocation(latitude: 39.982621, longitude: -75.152372),
                   CLLocation(latitude: 39.984079, longitude: -75.152046),
                   CLLocation(latitude: 39.984180, longitude: -75.152827),
                   CLLocation(latitude: 39.985798, longitude: -75.152503),
                   CLLocation(latitude: 39.986406, longitude: -75.152339),
                   CLLocation(latitude: 39.986348, longitude: -75.151826)],
                  
                  [CLLocation(latitude: 39.989356, longitude: -75.155524),
                   CLLocation(latitude: 39.987850, longitude: -75.155864),
                   CLLocation(latitude: 39.984689, longitude: -75.156519),
                   CLLocation(latitude: 39.984392, longitude: -75.154456),
                   CLLocation(latitude: 39.983964, longitude: -75.151229),
                   CLLocation(latitude: 39.983760, longitude: -75.149676),
                   CLLocation(latitude: 39.982304, longitude: -75.150019),
                   CLLocation(latitude: 39.980819, longitude: -75.150345),
                   CLLocation(latitude: 39.977790, longitude: -75.151005),
                   CLLocation(latitude: 39.978368, longitude: -75.155687),
                   CLLocation(latitude: 39.978696, longitude: -75.157721),
                   CLLocation(latitude: 39.978981, longitude: -75.160283),
                   CLLocation(latitude: 39.980526, longitude: -75.160009),
                   CLLocation(latitude: 39.980661, longitude: -75.160772),
                   CLLocation(latitude: 39.985146, longitude: -75.159852),
                   CLLocation(latitude: 39.988280, longitude: -75.159206),
                   CLLocation(latitude: 39.991249, longitude: -75.158490),
                   CLLocation(latitude: 39.990997, longitude: -75.156107),
                   CLLocation(latitude: 39.990840, longitude: -75.155203),
                   CLLocation(latitude: 39.989376, longitude: -75.155572)],
                  
                  [CLLocation(latitude: 40.114162, longitude: -75.153093),
                   CLLocation(latitude: 40.101297, longitude: -75.153632),
                   CLLocation(latitude: 40.092753, longitude: -75.137542),
                   CLLocation(latitude: 40.071261, longitude: -75.127707),
                   CLLocation(latitude: 40.059468, longitude: -75.129208),
                   CLLocation(latitude: 40.041358, longitude: -75.135069),
                   CLLocation(latitude: 40.022234, longitude: -75.160083),
                   CLLocation(latitude: 39.992525, longitude: -75.154073),
                   CLLocation(latitude: 39.981559, longitude: -75.149393),
                   CLLocation(latitude: 39.980719, longitude: -75.149514),
                   CLLocation(latitude: 39.980930, longitude: -75.151313),
                   CLLocation(latitude: 39.980627, longitude: -75.151343),
                   CLLocation(latitude: 39.980930, longitude: -75.151313),
                   CLLocation(latitude: 39.980719, longitude: -75.149514),
                   CLLocation(latitude: 39.981559, longitude: -75.149393),
                   CLLocation(latitude: 39.992525, longitude: -75.154073),
                   CLLocation(latitude: 40.022234, longitude: -75.160083),
                   CLLocation(latitude: 40.041358, longitude: -75.135069),
                   CLLocation(latitude: 40.059468, longitude: -75.129208),
                   CLLocation(latitude: 40.071261, longitude: -75.127707),
                   CLLocation(latitude: 40.092753, longitude: -75.137542),
                   CLLocation(latitude: 40.101297, longitude: -75.153632),
                   CLLocation(latitude: 40.114162, longitude: -75.153093)
        
        ]
                  ]
    
    var myDirections = [CLLocation(latitude: 0.000, longitude: 0.000),
                       CLLocation(latitude: 0.000, longitude: 0.000),
                       CLLocation(latitude: 0.000, longitude: 0.000)]
    
    //in meters
    let myRegionRadius:CLLocationDistance = 1000
    
    let myTimerPeriod : Double = 0.01
    var myTimer: Timer!
    let secBetween2Locations : Double = 1.0
    
    var myCircArr = [MKCircle(center: CLLocationCoordinate2D(latitude: 0.000, longitude: 0.000), radius: 500.0),
                     MKCircle(center: CLLocationCoordinate2D(latitude: 0.000, longitude: 0.000), radius: 500.0),
                     MKCircle(center: CLLocationCoordinate2D(latitude: 0.000, longitude: 0.000), radius: 500.0)]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        myMapViews = [myMapView1, myMapView2, myMapView3]
        
        myMapViews[0].delegate = self
        myMapViews[1].delegate = self
        myMapViews[2].delegate = self
        
        myCircArr[0] = MKCircle(center: (myPaths[0][0] as CLLocation).coordinate, radius: myFixedRadius)
        myCircArr[1] = MKCircle(center: (myPaths[1][0] as CLLocation).coordinate, radius: myFixedRadius)
        myCircArr[2] = MKCircle(center: (myPaths[2][0] as CLLocation).coordinate, radius: myFixedRadius)
        
        myPaths[0] = myPaths[0] + myPaths[0]
        myPaths[0] = myPaths[0] + myPaths[0]
        myPaths[0] = myPaths[0] + myPaths[0]
        myPaths[0] = myPaths[0] + myPaths[0]
        myPaths[0] = myPaths[0] + myPaths[0]
        
        myPaths[1] = myPaths[1] + myPaths[1]
        myPaths[1] = myPaths[1] + myPaths[1]
        myPaths[1] = myPaths[1] + myPaths[1]
        myPaths[1] = myPaths[1] + myPaths[1]
        myPaths[1] = myPaths[1] + myPaths[1]
        
        myPaths[2] = myPaths[2] + myPaths[2]
        myPaths[2] = myPaths[2] + myPaths[2]
        myPaths[2] = myPaths[2] + myPaths[2]
        myPaths[2] = myPaths[2] + myPaths[2]
        myPaths[2] = myPaths[2] + myPaths[2]
    }
    
    override var representedObject: Any? {
        didSet {
            // Update the view, if already loaded.
        }
    }
    
    @IBAction func centerAllViewsOntoInterest(_ sender: Any) {
        //myCenterMapOnLocWithRadiusInMeters(_myMapView: myMapViews[0], _location: myPaths[0][0], _regionRadius: myRegionRadius)
        //myCenterMapOnLocWithRadiusInMeters(_myMapView: myMapViews[1], _location: myPaths[1][0], _regionRadius: myRegionRadius)
        //myCenterMapOnLocWithRadiusInMeters(_myMapView: myMapViews[2], _location: myPaths[2][0], _regionRadius: myRegionRadius)
        
        let __factor = 1.50
        var (__latDelta, __longiDelta) = getCoordSpan(_myPath: myPaths[0])
        __latDelta = __latDelta * __factor
        __longiDelta = __longiDelta * __factor
        var __location : CLLocation = CLLocation(latitude: myPaths[0][0].coordinate.latitude - __latDelta/2.0, longitude: myPaths[0][0].coordinate.longitude - __longiDelta/2.0)
        myCenterMapOnLocWithSpanInDegs(_myMapView: myMapViews[0], _location: __location, _latDelta: __latDelta, _longiDelta: __longiDelta)
        
        (__latDelta, __longiDelta) = getCoordSpan(_myPath: myPaths[1])
        __latDelta = __latDelta * __factor
        __longiDelta = __longiDelta * __factor
        __location = CLLocation(latitude: myPaths[1][0].coordinate.latitude - __latDelta/2.0, longitude: myPaths[1][0].coordinate.longitude - __longiDelta/2.0)
        myCenterMapOnLocWithSpanInDegs(_myMapView: myMapViews[1], _location: __location, _latDelta: __latDelta, _longiDelta: __longiDelta)
        
        (__latDelta, __longiDelta) = getCoordSpan(_myPath: myPaths[2])
        __latDelta = __latDelta * __factor
        __longiDelta = __longiDelta * __factor
        __location = CLLocation(latitude: myPaths[2][0].coordinate.latitude - __latDelta/2.0, longitude: myPaths[2][0].coordinate.longitude - __longiDelta/2.0)
        myCenterMapOnLocWithSpanInDegs(_myMapView: myMapViews[2], _location: __location, _latDelta: __latDelta, _longiDelta: __longiDelta)
    }
    
    @IBAction func addCircles(_ sender: Any) {
        if myShowAllOtherUsers.state == NSControl.StateValue.off  {
            myMapViews[0].add(myCircArr[0])
            myMapViews[1].add(myCircArr[1])
            myMapViews[2].add(myCircArr[2])
        }
        else {
            myMapViews[0].add(myCircArr[0])
            myMapViews[0].add(myCircArr[1])
            myMapViews[0].add(myCircArr[2])
            
            myMapViews[1].add(myCircArr[0])
            myMapViews[1].add(myCircArr[1])
            myMapViews[1].add(myCircArr[2])
            
            myMapViews[2].add(myCircArr[0])
            myMapViews[2].add(myCircArr[1])
            myMapViews[2].add(myCircArr[2])
        }
    }
    
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        var _color = NSColor.black
        if overlay as? MKCircle == myCircArr[0] {
            _color = NSColor.blue
        }
        else if overlay as? MKCircle == myCircArr[1] {
            _color = NSColor.red
        }
        else if overlay as? MKCircle == myCircArr[2] {
            _color = NSColor.purple
        }
        let circleRenderer = MKCircleRenderer(overlay: overlay)
        circleRenderer.strokeColor = _color
        circleRenderer.lineWidth = 3.0
        return circleRenderer
    }
    
    @IBAction func startMyTimer(_ sender: Any) {
        myTimer = Timer.scheduledTimer(timeInterval: myTimerPeriod, target: self, selector: #selector(runTimedCode), userInfo: nil, repeats: true)
    }
    
    @IBAction func showAllUsersChanged(_ sender: Any) {
        if myShowAllOtherUsers.state == NSControl.StateValue.off {
            myMapViews[0].remove(myCircArr[1])
            myMapViews[0].remove(myCircArr[2])
            myMapViews[1].remove(myCircArr[0])
            myMapViews[1].remove(myCircArr[2])
            myMapViews[2].remove(myCircArr[0])
            myMapViews[2].remove(myCircArr[1])
        }
        else {
            myMapViews[0].add(myCircArr[1])
            myMapViews[0].add(myCircArr[2])
            myMapViews[1].add(myCircArr[0])
            myMapViews[1].add(myCircArr[2])
            myMapViews[2].add(myCircArr[0])
            myMapViews[2].add(myCircArr[1])
        }
    }
    
}

extension ViewController {
    func myCenterMapOnLocWithRadiusInMeters(_myMapView: MKMapView, _location: CLLocation, _regionRadius : Double)
    {
        let _coordRegion = MKCoordinateRegionMakeWithDistance(_location.coordinate, _regionRadius, _regionRadius)
        _myMapView.setRegion(_coordRegion, animated: true)
    }
    
    func myCenterMapOnLocWithSpanInDegs(_myMapView: MKMapView, _location: CLLocation, _latDelta : Double, _longiDelta : Double)
    {
        let _coordRegion = MKCoordinateRegionMake(_location.coordinate, MKCoordinateSpanMake(_latDelta, _longiDelta))
        _myMapView.setRegion(_coordRegion, animated: true)
    }
    
    func getCoordSpan(_myPath : [CLLocation]) -> (Double, Double) {
        var minLat : Double = 9999.99
        var maxLat : Double = -9999.99
        var minLongi : Double = 9999.99
        var maxLongi : Double = -9999.99
        
        for _loc in _myPath {
            if _loc.coordinate.latitude > maxLat {
                maxLat = _loc.coordinate.latitude
            }
            if _loc.coordinate.latitude < minLat {
                minLat = _loc.coordinate.latitude
            }
            if _loc.coordinate.longitude > maxLongi {
                maxLongi = _loc.coordinate.longitude
            }
            if _loc.coordinate.longitude < minLongi {
                minLongi = _loc.coordinate.longitude
            }
        }
        
        print("minLat", minLat, "minLongi", minLongi, "maxLat", maxLat, "maxLongi", maxLongi)
        
        return (maxLat - minLat, maxLongi - minLongi)
    }
}

extension ViewController{
    @objc func updateUser(_id : Int) {
        if !myPaths[_id].isEmpty
        {
            if abs(myDirections[_id].coordinate.latitude) < 1e-13 && abs(myDirections[_id].coordinate.longitude) < 1e-13 {
                let var1 : CLLocation = CLLocation(latitude: myCircArr[_id].coordinate.latitude, longitude: myCircArr[_id].coordinate.longitude)
                let var2 : CLLocation = myPaths[_id][0]
                
                myDirections[_id] = CLLocation(latitude: var2.coordinate.latitude - var1.coordinate.latitude, longitude: var2.coordinate.longitude - var1.coordinate.longitude)
            }
            
            if myShowAllOtherUsers.state == NSControl.StateValue.off {
                myMapViews[_id].remove(myCircArr[_id])
            }
            else {
                myMapViews[0].remove(myCircArr[_id])
                myMapViews[1].remove(myCircArr[_id])
                myMapViews[2].remove(myCircArr[_id])
            }
            var _radius : Double
            if allowRadiusFluctuation == true {
                _radius = myCircArr[_id].radius + drand48()*10-5
                if _radius < myFixedRadius {
                    _radius = myFixedRadius
                }
            }
            else {
                _radius = myFixedRadius
            }
            
            let _dist = sqrt(pow(myPaths[_id][0].coordinate.latitude - myCircArr[_id].coordinate.latitude, 2.0) + pow(myPaths[_id][0].coordinate.longitude - myCircArr[_id].coordinate.longitude, 2.0))
            
            if _dist < 1e-8 {
                myCircArr[_id] = MKCircle(center: (myPaths[_id][0] as CLLocation).coordinate, radius: _radius)
                myPaths[_id].remove(at: 0)
                myDirections[_id] = CLLocation(latitude: 0.000, longitude: 0.000)
            }
            else {
                myCircArr[_id] = MKCircle(center: CLLocationCoordinate2D(latitude: myCircArr[_id].coordinate.latitude + myDirections[_id].coordinate.latitude*myTimerPeriod/secBetween2Locations, longitude: myCircArr[_id].coordinate.longitude + myDirections[_id].coordinate.longitude*myTimerPeriod/secBetween2Locations), radius: _radius)
            }
            if myShowAllOtherUsers.state == NSControl.StateValue.off {
                myMapViews[_id].add(myCircArr[_id])
            }
            else {
                myMapViews[0].add(myCircArr[_id])
                myMapViews[1].add(myCircArr[_id])
                myMapViews[2].add(myCircArr[_id])
            }
        }
    }
    
    @objc func runTimedCode() {
        updateUser(_id: 0)
        updateUser(_id: 1)
        updateUser(_id: 2)
    }
}

