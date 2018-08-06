//
//  TestHeader.swift
//  GenericTableView
//
//  Created by Paul Fechner on 8/5/18.
//  Copyright © 2018 peejweej.inc. All rights reserved.
//

import UIKit

struct ExampleTestHeaderModel: TestHeaderModel {
    var title: String
}
protocol TestHeaderModel {
    var title: String { get }
}

class TestHeader: UITableViewHeaderFooterView, ModelUpdatable, NibReusable {

    @IBOutlet weak var titleLabel: UILabel!
    
    func update(with model: TestHeaderModel) {
        titleLabel.text = model.title
    }
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
