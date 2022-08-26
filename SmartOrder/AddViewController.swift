//
//  AddViewController.swift
//  SmartOrder
//
//  Created by Chang Jill on 2022/8/24.
//

import UIKit


class AddViewController: UIViewController {

    @IBOutlet weak var AddTableView: UITableView!
    var rowNumber = 2
    var tableTypeList = [1,0]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        AddTableView.dataSource = self
    }
    
    @IBAction func cancelButtonClick(_ sender: Any) {
        let alert = UIAlertController(title: "注意！", message: "資料將清空", preferredStyle: .alert)

        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: {_ in
            self.dismiss(animated: true, completion: nil)
        }))
        alert.addAction(UIAlertAction(title: "Cancel", style: .default, handler: nil))

        present(alert, animated: true, completion: nil)
    }
    
    @objc func addButtonPressed() {
        rowNumber += 1
        AddTableView.reloadData()
    }
    
    @objc func minusButtonPressed() {
        rowNumber -= 1
        AddTableView.reloadData()
    }
    
    @IBAction func nextButtonClicked(_ sender: Any) {
        
        
    }
}

extension AddViewController: UITableViewDataSource{
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return rowNumber
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let UITableViewCell = UITableViewCell(frame: CGRect(x: 10, y: 10, width: 100, height: 50))
        
        let addButton = UIButton(frame: CGRect(x: 10, y: 10, width: 50, height: 50))
        addButton.setImage(UIImage(systemName:"plus.circle.fill"), for: UIControl.State.normal)
        addButton.addTarget(self, action: #selector(addButtonPressed), for: .touchUpInside)
        UITableViewCell.contentView.addSubview(addButton)
        
        let minusButton = UIButton(frame: CGRect(x: UITableViewCell.frame.width - 50, y:10 , width: 50, height: 50))
        minusButton.setImage(UIImage(systemName:"minus.circle.fill"), for: UIControl.State.normal)
        minusButton.addTarget(self, action: #selector(minusButtonPressed), for: .touchUpInside)
        UITableViewCell.contentView.addSubview(minusButton)
        
        return UITableViewCell
    }
}

