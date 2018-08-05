//
//  TestFooter.swift
//  GenericTableView
//
//  Created by Paul Fechner on 8/5/18.
//  Copyright © 2018 peejweej.inc. All rights reserved.
//

import UIKit

struct ExampleTestFooterModel: TestFooterModel {
    var title: String
}
protocol TestFooterModel {
    var title: String { get }
}

class TestFooter: UITableViewHeaderFooterView, ModelUpdatable {

    @IBOutlet weak var titleLabel: UILabel!
   
    func update(with model: TestFooterModel) {
        titleLabel.text = model.title
    }

}
