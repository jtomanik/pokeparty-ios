//
//  MapViewController.swift
//  PokeParty
//
//  Created by Karol Kubicki on 23.07.2016.
//  Copyright © 2016 tooploox. All rights reserved.
//

import UIKit
import MapKit

class MapViewController: UIViewController {
    
    private var currentAnnotation: MKPointAnnotation? = nil
    
    lazy var mapView: MKMapView = {
        let map = MKMapView()
        map.showsUserLocation = true
        map.translatesAutoresizingMaskIntoConstraints = false
        let tap = UITapGestureRecognizer(target: self, action: #selector(mapTap))
        map.addGestureRecognizer(tap)
        return map
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(mapView)
        mapView.topAnchor.constraintEqualToAnchor(topLayoutGuide.bottomAnchor).active = true
        mapView.bottomAnchor.constraintEqualToAnchor(bottomLayoutGuide.topAnchor).active = true
        mapView.leadingAnchor.constraintEqualToAnchor(view.leadingAnchor).active = true
        mapView.trailingAnchor.constraintEqualToAnchor(view.trailingAnchor).active = true
        
        CLLocationManager().requestWhenInUseAuthorization()
    }

    @objc func mapTap(recognizer: UIGestureRecognizer) {
        if currentAnnotation != nil {
            mapView.removeAnnotation(currentAnnotation!)
        }
        let point = recognizer.locationInView(mapView)
        let coordinate = mapView.convertPoint(point, toCoordinateFromView: mapView)
        
        currentAnnotation = MKPointAnnotation()
        currentAnnotation!.coordinate = coordinate
        mapView.addAnnotation(currentAnnotation!)
    }

}
