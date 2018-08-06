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
}
protocol TestCellModel {
    var title: String { get }
}

protocol ModelUpdatable {
    associatedtype ModelType 
    func update(with model: ModelType)
}

class TestCell: UITableViewCell, ModelUpdatable {
    @IBOutlet weak var titleLabel: UILabel!
    
    func update(with model: TestCellModel)   {
        
        titleLabel.text = model.title
        
    } 
}
