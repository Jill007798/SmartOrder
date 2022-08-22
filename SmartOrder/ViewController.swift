//
//  ViewController.swift
//  SmartOrder
//
//  Created by Chang Jill on 2022/8/17.
//

import UIKit
import MapKit

let orderGreen = CGColor(red: 37/255, green: 161/255, blue: 147/255, alpha: 1)
let orderOrange = CGColor(red: 245/255, green: 106/255, blue: 52/255, alpha: 1)

let orderGreenAlphaHalf = CGColor(red: 37/255, green: 161/255, blue: 147/255, alpha: 0.5)
let orderOrangeAlphaHalf = CGColor(red: 245/255, green: 106/255, blue: 52/255, alpha: 0.5)


class ViewController: UIViewController {

    @IBOutlet weak var SOMapView: MKMapView!
    @IBOutlet var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let coordinate = CLLocationCoordinate2D(latitude: 25.08, longitude: 121.52)
        let region = self.SOMapView.regionThatFits(MKCoordinateRegion(center: coordinate, latitudinalMeters: 2000, longitudinalMeters: 2000))
        self.SOMapView.setRegion(region, animated: true)
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
    }
}

extension ViewController: UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
    
}

extension ViewController: UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let customView = cell.contentView.subviews[0]
        customView.layer.borderWidth = 3
        customView.layer.borderColor = indexPath.row % 3 == 1 ? orderGreenAlphaHalf : orderOrangeAlphaHalf
        customView.layer.masksToBounds = true
        
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 6
    }
}


