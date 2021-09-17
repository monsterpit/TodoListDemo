//
//  TodoListTVC.swift
//  TodoList
//
//  Created by Vikas S on 17/09/21.
//

import UIKit

class TodoListTVC: UITableViewCell,ReusableProtocol {

    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var descLbl: UILabel!

    func setupViewOnCreation(title: String,desc: String?){
        titleLbl.text = title
        descLbl.text = desc
    }
}
