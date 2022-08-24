//
//  AddViewController.swift
//  SmartOrder
//
//  Created by Chang Jill on 2022/8/24.
//

import UIKit


class AddViewController: UIViewController {

    @IBOutlet weak var AddTableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        let alert = UIAlertController(title: "注意！", message: "資料將清空", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(okAction)
        present(alert, animated: true, completion: nil)
    }
        
    @IBAction func nextButtonClicked(_ sender: Any) {
        
        
    }
}

extension AddViewController: UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let UITableViewCell = UITableViewCell(frame: CGRect(x: 10, y: 10, width: 100, height: 50))
        
        
        return UITableViewCell
    }
}

