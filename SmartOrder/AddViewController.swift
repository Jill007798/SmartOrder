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
    let tableViewCellHeight = 60.0
    
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
        return tableViewCellHeight
    }
}

extension AddViewController: UITableViewDataSource{
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableTypeList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let UITableViewCell = UITableViewCell(frame: CGRect(x: 0, y: 0, width: screenWidth , height: tableViewCellHeight))
        UITableViewCell.contentView.frame = CGRect(x: 10, y: 5, width: screenWidth - 20, height: tableViewCellHeight)
        UITableViewCell.contentView.backgroundColor = UIColor(cgColor: orderGray)
        UITableViewCell.contentView.layer.cornerRadius = 10
        UITableViewCell.contentView.layer.masksToBounds = true
        UITableViewCell.contentView.tintColor = UIColor.gray

        let imageEdgeInsets = 10.0
        let itemRowIndent = 50.0

        switch tableTypeList[indexPath.row] {
        case tableType.Category:
            
            let addButton = UIButton(frame: CGRect(x: imageEdgeInsets, y: imageEdgeInsets, width: tableViewCellHeight - imageEdgeInsets*2, height: tableViewCellHeight - imageEdgeInsets*2))
            var config = UIButton.Configuration.plain()
            config.background.image = UIImage(systemName:"plus.circle.fill")
            config.background.imageContentMode = .scaleAspectFill
            addButton.configuration = config
            addButton.tag = indexPath.row
            addButton.addTarget(self, action: #selector(addButtonPressed), for: .touchUpInside)
            UITableViewCell.contentView.addSubview(addButton)
            
            let minusButton = UIButton(frame: CGRect(x:screenWidth - tableViewCellHeight - imageEdgeInsets, y:imageEdgeInsets , width: tableViewCellHeight - imageEdgeInsets*2, height: tableViewCellHeight - imageEdgeInsets*2))
            config.background.image = UIImage(systemName:"minus.circle")
            minusButton.configuration = config
            minusButton.tag = indexPath.row
            minusButton.addTarget(self, action: #selector(minusButtonPressed), for: .touchUpInside)
            UITableViewCell.contentView.addSubview(minusButton)
            
            let textField = UITextField(frame: CGRect(x: tableViewCellHeight, y: 0, width: screenWidth - tableViewCellHeight*2, height: tableViewCellHeight))
            textField.placeholder = "請輸入分類名稱..."
            textField.delegate = self
            UITableViewCell.contentView.addSubview(textField)
            
            
        case tableType.Item:
            
            let addButton = UIButton(frame: CGRect(x: imageEdgeInsets + itemRowIndent, y: imageEdgeInsets, width: tableViewCellHeight - imageEdgeInsets*2, height: tableViewCellHeight - imageEdgeInsets*2))
            addButton.tag = indexPath.row
            var config = UIButton.Configuration.plain()
            config.background.image = UIImage(systemName:"plus.circle.fill")
            config.background.imageContentMode = .scaleAspectFill
            addButton.configuration = config
            addButton.addTarget(self, action: #selector(addButtonPressed), for: .touchUpInside)
            UITableViewCell.contentView.addSubview(addButton)
            
            let minusButton = UIButton(frame: CGRect(x: screenWidth - tableViewCellHeight - imageEdgeInsets, y:imageEdgeInsets , width: tableViewCellHeight - imageEdgeInsets*2, height: tableViewCellHeight - imageEdgeInsets*2))
            minusButton.tag = indexPath.row
            config.background.image = UIImage(systemName:"minus.circle")
            minusButton.configuration = config
            minusButton.addTarget(self, action: #selector(minusButtonPressed), for: .touchUpInside)
            UITableViewCell.contentView.addSubview(minusButton)
            
            let textField = UITextField(frame: CGRect(x: tableViewCellHeight + itemRowIndent, y: 0.0, width: screenWidth - tableViewCellHeight*2 - itemRowIndent, height: tableViewCellHeight))
            textField.placeholder = "請輸入品項名稱..."
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
