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
    
    var menu1: SmartOrderMenu!
    let dataFormatter = DateFormatter()
    
    @IBAction func addMenuButtonClick(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "addVC")
        self.present(vc, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let coordinate = CLLocationCoordinate2D(latitude: 25.08, longitude: 121.52)
        let region = self.SOMapView.regionThatFits(MKCoordinateRegion(center: coordinate, latitudinalMeters: 2000, longitudinalMeters: 2000))
        self.SOMapView.setRegion(region, animated: true)
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        menu1 = SmartOrderMenu(dinerName: "摩斯漢堡酒泉店")
        dataFormatter.dateFormat = "YYYY / MM / dd"
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
        
        let titleLabel = UILabel(frame: CGRect(x: 90, y: 0, width: 200, height: 50))
        titleLabel.text = "\(menu1.dinerName)\(indexPath.row)"
        titleLabel.textColor = UIColor.darkGray
        titleLabel.font = UIFont(name: "Helvetica", size: 16)
        customView.addSubview(titleLabel)
        
        let detailLabel = UILabel(frame: CGRect(x: 90, y: 30, width: 300, height: 40))
        detailLabel.text = "使用次數：\(menu1.usedTimes) 次  創建日期 : \(dataFormatter.string(from: menu1.createdDate))"
        detailLabel.textColor = UIColor.darkGray
        detailLabel.font = UIFont(name: "Helvetica", size: 12)
        customView.addSubview(detailLabel)

        let imageView = UIImageView(frame: CGRect(x: 10, y: 15, width: 40, height:40))
        imageView.image = UIImage(named: "food-vector-free-icon-set-\(Int.random(in: 21..<41))")
        imageView.image = imageView.image?.alpha(0.5)
        customView.addSubview(imageView)
                
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 6
    }
}

extension UIImage {

    func alpha(_ value:CGFloat) -> UIImage {
        UIGraphicsBeginImageContextWithOptions(size, false, scale)
        draw(at: CGPoint.zero, blendMode: .normal, alpha: value)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage!
    }
}


