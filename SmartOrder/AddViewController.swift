//
//  AddViewController.swift
//  SmartOrder
//
//  Created by Chang Jill on 2022/8/24.
//

import UIKit


class AddViewController: UIViewController {

    @IBOutlet weak var AddTableView: UITableView!
    var tableTypeList = [tableType.Category,tableType.Item]
    var screenWidth: CGFloat { return UIScreen.main.bounds.width }
    var screenHeight: CGFloat { return UIScreen.main.bounds.height }
    let uitableviewcellHeight = 60.0
    
    enum tableType {
        case Category
        case Item
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        AddTableView.dataSource = self
        AddTableView.delegate = self
    }
    
    @IBAction func cancelButtonClick(_ sender: Any) {
        let alert = UIAlertController(title: "注意！", message: "資料將清空", preferredStyle: .alert)

        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: {_ in
            self.dismiss(animated: true, completion: nil)
        }))
        alert.addAction(UIAlertAction(title: "Cancel", style: .default, handler: nil))

        present(alert, animated: true, completion: nil)
    }
    
    @objc func addButtonPressed(sender: UIButton) {
        switch tableTypeList[sender.tag] {
        case tableType.Category:
            tableTypeList.append(tableType.Category)
            tableTypeList.append(tableType.Item)
        case tableType.Item:
            tableTypeList.insert(tableType.Item, at: sender.tag)
        }
        AddTableView.reloadData()
    }
    
    @objc func minusButtonPressed(sender: UIButton) {
        switch tableTypeList[sender.tag] {
        case tableType.Category:
            tableTypeList.remove(at: sender.tag)
            for i in sender.tag..<tableTypeList.count {
                if i == tableTypeList.count - 1 || tableTypeList[i] == tableType.Category
                {
                    break
                }
                tableTypeList.remove(at: i)
            }
        case tableType.Item:
            tableTypeList.remove(at: sender.tag)
        }
        AddTableView.reloadData()
    }
    
    @IBAction func nextButtonClicked(_ sender: Any) {
        
        
    }
}

extension AddViewController: UITableViewDelegate{

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return uitableviewcellHeight
    }
}

extension AddViewController: UITableViewDataSource{
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableTypeList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let UITableViewCell = UITableViewCell(frame: CGRect(x: 0, y: 0, width: screenWidth , height: 60))
        UITableViewCell.contentView.frame = CGRect(x: 10, y: 5, width: screenWidth - 20, height: 70)
        UITableViewCell.contentView.backgroundColor = UIColor(cgColor: orderGray)
        UITableViewCell.contentView.layer.cornerRadius = 10
        UITableViewCell.contentView.layer.masksToBounds = true
        UITableViewCell.contentView.tintColor = UIColor.gray

        switch tableTypeList[indexPath.row] {
        case tableType.Category:
            
            let addButton = UIButton(frame: CGRect(x: 10, y: 10, width: 50, height: 50))
            addButton.setImage(UIImage(systemName:"plus.circle.fill"), for: UIControl.State.normal)
            addButton.tag = indexPath.row
            addButton.addTarget(self, action: #selector(addButtonPressed), for: .touchUpInside)
            UITableViewCell.contentView.addSubview(addButton)
            
            let minusButton = UIButton(frame: CGRect(x: UITableViewCell.frame.width - 50, y:10 , width: 50, height: 50))
            minusButton.setImage(UIImage(systemName:"minus.circle"), for: UIControl.State.normal)
            minusButton.tag = indexPath.row
            minusButton.addTarget(self, action: #selector(minusButtonPressed), for: .touchUpInside)
            UITableViewCell.contentView.addSubview(minusButton)
            
            let textField = UITextField(frame: CGRect(x: 60, y: 10, width: 100, height: 50))
            textField.placeholder = "分類名稱"
            textField.delegate = self
            UITableViewCell.contentView.addSubview(textField)
            
            
        case tableType.Item:
            
            let addButton = UIButton(frame: CGRect(x: 30, y: 10, width: 50, height: 50))
            addButton.setImage(UIImage(systemName:"plus.circle.fill"), for: UIControl.State.normal)
            addButton.tag = indexPath.row
            addButton.addTarget(self, action: #selector(addButtonPressed), for: .touchUpInside)
            UITableViewCell.contentView.addSubview(addButton)
            
            let minusButton = UIButton(frame: CGRect(x: UITableViewCell.frame.width - 50, y:10 , width: 50, height: 50))
            minusButton.setImage(UIImage(systemName:"minus.circle"), for: UIControl.State.normal)
            minusButton.tag = indexPath.row
            minusButton.addTarget(self, action: #selector(minusButtonPressed), for: .touchUpInside)
            UITableViewCell.contentView.addSubview(minusButton)
            
            let textField = UITextField(frame: CGRect(x: 100, y: 10, width: 100, height: 50))
            textField.placeholder = "品項名稱"
            textField.delegate = self
            UITableViewCell.contentView.addSubview(textField)
        }

        return UITableViewCell
    }
}

extension AddViewController: UITextFieldDelegate{
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
            self.view.endEditing(true)
            return false
        }
}
