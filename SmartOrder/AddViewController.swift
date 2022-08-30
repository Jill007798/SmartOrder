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
    var tableNameList = ["",""]
    var tablePriceList = [0,0]

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
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
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
            
            dataIncrease(index: -1, times: 2)
            
        case tableType.Item:
            tableTypeList.insert(tableType.Item, at: sender.tag + 1)
            
            dataIncrease(index: sender.tag + 1, times: 1)
        }
        updateMenuData()
        AddTableView.reloadData()
    }
    
    @objc func minusButtonPressed(sender: UIButton) {
      
        if tableTypeList[sender.tag - 1] == tableType.Category && (sender.tag == (tableTypeList.count - 1) || tableTypeList[sender.tag + 1] == tableType.Category) {
            
            tableTypeList.remove(at: sender.tag - 1)
            tableTypeList.remove(at: sender.tag - 1)
            
            dataDecrease(index:  sender.tag - 1, times: 2)
        }else
        {
            tableTypeList.remove(at: sender.tag)
            
            dataDecrease(index: sender.tag, times: 1)
        }
        updateMenuData()
        AddTableView.reloadData()
    }
    
    func dataIncrease(index:Int , times:Int) -> Void {
        for _ in 1...times {
            if index == -1 {
                tableNameList.append("")
                tablePriceList.append(0)
            }else{
                tableNameList.insert("", at: index)
                tablePriceList.insert(0, at: index)
            }
        }
    }
    
    func dataDecrease(index:Int , times:Int) -> Void {
        for _ in 1...times {
            tableNameList.remove(at: index)
            tablePriceList.remove(at: index)
        }
    }
    
    func updateMenuData() -> Void {
        
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
        if self.traitCollection.userInterfaceStyle == .dark {
            UITableViewCell.contentView.backgroundColor = UIColor.black

        }else
        {
            UITableViewCell.contentView.backgroundColor = UIColor(cgColor: orderGray)
        }
        UITableViewCell.contentView.layer.cornerRadius = 10
        UITableViewCell.contentView.layer.masksToBounds = true
        UITableViewCell.contentView.tintColor = UIColor.gray
        
        let imageEdgeInsets = 12.0
        let itemRowIndent = 30.0
        let priceTextFieldWidth = 60.0
        
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
            
            let textField = UITextField(frame: CGRect(x: tableViewCellHeight, y: 0, width: screenWidth - tableViewCellHeight*2, height: tableViewCellHeight))
            if tableNameList[indexPath.row] == "" {
                textField.placeholder = "請輸入品項名稱..."
            }else {
                textField.text = tableNameList[indexPath.row]
            }
            textField.tag = 1000 + indexPath.row
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
            
            if indexPath.row > 1 {
                let minusButton = UIButton(frame: CGRect(x: screenWidth - tableViewCellHeight - imageEdgeInsets, y:imageEdgeInsets , width: tableViewCellHeight - imageEdgeInsets*2, height: tableViewCellHeight - imageEdgeInsets*2))
                minusButton.tag = indexPath.row
                config.background.image = UIImage(systemName:"minus.circle")
                minusButton.configuration = config
                minusButton.addTarget(self, action: #selector(minusButtonPressed), for: .touchUpInside)
                UITableViewCell.contentView.addSubview(minusButton)
            }
            
            let textField = UITextField(frame: CGRect(x: tableViewCellHeight + itemRowIndent, y: 0.0, width: screenWidth - tableViewCellHeight*2 - itemRowIndent - priceTextFieldWidth, height: tableViewCellHeight))
            if tableNameList[indexPath.row] == "" {
                textField.placeholder = "請輸入品項名稱..."
            }else {
                textField.text = tableNameList[indexPath.row]
            }
            textField.delegate = self
            textField.tag = 1000 + indexPath.row
            UITableViewCell.contentView.addSubview(textField)
            
            let priceTextField = UITextField(frame: CGRect(x: screenWidth - tableViewCellHeight - priceTextFieldWidth, y: 0.0, width: priceTextFieldWidth, height: tableViewCellHeight))
            if tablePriceList[indexPath.row] == 0 {
                priceTextField.placeholder = "價格.."
            }else {
                priceTextField.text = "\(tablePriceList[indexPath.row])"
            }
            priceTextField.delegate = self
            priceTextField.tag = 2000 + indexPath.row
            priceTextField.keyboardType = .asciiCapableNumberPad
            UITableViewCell.contentView.addSubview(priceTextField)
        }
        
        return UITableViewCell
    }
}

extension AddViewController: UITextFieldDelegate{
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField.tag >= 1000 && textField.tag < 2000 {
            let i = textField.tag - 1000
            if let text = textField.text{
                tableNameList[i] = text
            }
        }else if textField.tag > 2000 {
            let i = textField.tag - 2000
            if let text = textField.text{
                tablePriceList[i] = Int(text)!
            }
        }
    }
}
