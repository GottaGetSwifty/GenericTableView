//
//  TestCell.swift
//  GenericTableView
//
//  Created by Paul Fechner on 8/5/18.
//  Copyright © 2018 peejweej.inc. All rights reserved.
//

import UIKit

struct ExampleTestCellModel: TestCellModel {
    var title: String
    var clickAction: () -> ()
}

protocol TestCellModel {
    var title: String { get }
    var clickAction: () -> () { get }
}

class TestCell: UITableViewCell, ModelUpdatable, NibReusable {
    @IBOutlet weak var titleLabel: UILabel!
    
    var clickAction: (() -> ())? = nil
    func update(with model: TestCellModel)   {
        clickAction = model.clickAction
        titleLabel.text = model.title
    } 
    
    @IBAction func buttonWasClicked(_ sender: Any) {
        clickAction?()
    }
}
