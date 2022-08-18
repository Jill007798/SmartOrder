//
//  ViewController.swift
//  SmartOrder
//
//  Created by Chang Jill on 2022/8/17.
//

import UIKit
import MapKit

class ViewController: UIViewController {

    @IBOutlet weak var SOMapView: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        //TODO:: user's location
        let coordinate = CLLocationCoordinate2D(latitude: 25.08, longitude: 121.52)
        let region = self.SOMapView.regionThatFits(MKCoordinateRegion(center: coordinate, latitudinalMeters: 2000, longitudinalMeters: 2000))
        self.SOMapView.setRegion(region, animated: true)
        
    }


}

