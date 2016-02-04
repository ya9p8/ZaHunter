//
//  MapViewController.swift
//  ZaHunter
//
//  Created by Yemi Ajibola on 2/3/16.
//  Copyright © 2016 Yemi Ajibola. All rights reserved.
//

import UIKit
import MapKit

class MapViewController: UIViewController {
    
    var pizzerias:[Pizzeria]!
    @IBOutlet weak var mapView: MKMapView!

    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        for place in pizzerias
        {
            let annotation:MKPointAnnotation = MKPointAnnotation()
            annotation.coordinate = place.location.coordinate
            annotation.title = place.name
            mapView.addAnnotation(annotation)
        }
        

        
    }

   

    

}
