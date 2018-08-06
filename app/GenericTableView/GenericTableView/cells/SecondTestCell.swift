//
//  TestCell.swift
//  GenericTableView
//
//  Created by Paul Fechner on 8/5/18.
//  Copyright © 2018 peejweej.inc. All rights reserved.
//

import UIKit


class SecondTestCell: UITableViewCell, ModelUpdatable, NibReusable {
    @IBOutlet weak var titleLabel: UILabel!
    
    func update(with model: TestCellModel)   {
        
        titleLabel.text = model.title
        
    } 
}
