//
//  PizzaDirectionsViewController.swift
//  ZaHunter
//
//  Created by Yemi Ajibola on 2/3/16.
//  Copyright © 2016 Yemi Ajibola. All rights reserved.
//

import UIKit
import CoreLocation
import MapKit

class PizzaDirectionsViewController: UIViewController, CLLocationManagerDelegate, UITableViewDelegate, UITableViewDataSource
{
    @IBOutlet weak var pizzeriaTableView: UITableView!
    @IBOutlet weak var directionsTextView: UITextView!
    
    let locationManager = CLLocationManager()
    var pizzerias:[MKMapItem] = [MKMapItem]()
    
    
    override func viewDidLoad()
    {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.locationManager.delegate = self
        self.locationManager.requestWhenInUseAuthorization()
        self.locationManager.startUpdatingLocation()
        //self.directionsTextView.text = "Looking for you..."
    }

    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func reverseGeocode(location:CLLocation)
    {
        let geocoder = CLGeocoder()
        geocoder.reverseGeocodeLocation(location) { (placemarks:[CLPlacemark]?, error:NSError?) -> Void in
            //let placemark = placemarks?.first
            self.findPizzeriaNear(location)
        }
    }
    
    func findPizzeriaNear(location:CLLocation)
    {
        let request = MKLocalSearchRequest()
        request.naturalLanguageQuery = "Pizza"
        request.region = MKCoordinateRegionMake(location.coordinate, MKCoordinateSpanMake(0.1, 0.1))
        let search = MKLocalSearch(request: request)
        search.startWithCompletionHandler { (response:MKLocalSearchResponse?, error:NSError?) -> Void in
            let mapItems = response!.mapItems
            //let mapItem = mapItems.first!
            
            for(var i = 0; i < 4; i++)
            {
                print(mapItems[i])
                print ("--------------------------\n")
                
                self.pizzerias.append(mapItems[i])
            }
            
           print(self.pizzerias.count)
        
        }
        
    }
    
    
    // MARK: - CLLocationManager Delegate Methods
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation])
    {
        let location = locations.first
        
        if location?.verticalAccuracy < 1000 && location?.horizontalAccuracy < 1000
        {
            reverseGeocode(location!)
            //directionsTextView.text = "Found you!"
            locationManager.stopUpdatingLocation()
        }
    }
    
    
    //Mark: - TableviewDelegate Methods
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return pizzerias.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCellWithIdentifier("PizzeriaCell")
        let pizzeria = self.pizzerias[indexPath.row]
        
        cell?.textLabel!.text = pizzeria.name
        //cell?.detailTextLabel!.text = pizzeria.placemark as? String
    
        return cell!
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
