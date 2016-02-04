//
//  Pizzeria.swift
//  ZaHunter
//
//  Created by Yemi Ajibola on 2/3/16.
//  Copyright © 2016 Yemi Ajibola. All rights reserved.
//

import UIKit
import MapKit

class Pizzeria: NSObject {
    
    //var name:String
    var distanceFromCurrentLocation:Double
    var name:String
    var location:CLLocation
    
    init(userLocation:CLLocation, pizzeria:CLPlacemark)
    {
        distanceFromCurrentLocation = (userLocation.distanceFromLocation(pizzeria.location!))/1609.344
        name = pizzeria.name!
        location = pizzeria.location!
    }
    

}
