//
//  TestGenericTableVC.swift
//  GenericTableView
//
//  Created by Paul Fechner on 8/5/18.
//  Copyright © 2018 peejweej.inc. All rights reserved.
//

import UIKit

struct TestTableData: TableData {
    
    
    var sections: [TableSection] = []
    
    init() {
        sections = []
    }
    init(clickAction: @escaping () -> ()) {
        sections = [TableSection(header: TestHeaderRepresentor(model: ExampleTestHeaderModel(title: "Header")), 
                                 rows: [TestCellRepresentor(model: ExampleTestCellModel(title: "First", clickAction: clickAction)),
                                        TestSecondCellRepresentor(model: ExampleTestCellModel(title: "Second", clickAction: clickAction))], 
                      footer: nil)]
    }
    
    static func registerCells(with tableView: UITableView) {
        tableView.registerReusableCellNib(cellType: TestCell.self)
        tableView.registerReusableCellNib(cellType: SecondTestCell.self)
        tableView.registerReusableHeaderFooterView(viewType: TestHeader.self)
        tableView.registerReusableHeaderFooterView(viewType: TestFooter.self)
    }
}

struct TestHeaderRepresentor: HeaderFooterRepresentor {
    
    typealias CellType = TestHeader
    
    var model: TestHeader.ModelType
    
    init(model: CellModelType) {
        self.model = model
    }
}

struct TestFooterRepresentor: HeaderFooterRepresentor {
    typealias CellType = TestFooter
    
    var model: TestFooter.ModelType
    
    init(model: CellModelType) {
        self.model = model
    }
}

struct TestCellRepresentor: CellRepresentor {
    typealias CellType = TestCell
    
    var model: TestCell.ModelType
    
    init(model: CellModelType) {
        self.model = model
    }
}

struct TestSecondCellRepresentor: CellRepresentor {
    typealias CellType = SecondTestCell
    
    var model: SecondTestCell.ModelType
    
    init(model: CellModelType) {
        self.model = model
    }
}

class TestGenericTableVC: GenericTableViewController<TestTableData> {

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.rowHeight = UITableView.AutomaticDimension
        tableView.sectionHeaderHeight = UITableView.AutomaticDimension
        tableView.estimatedSectionHeaderHeight = 60
        tableView.sectionFooterHeight = UITableView.AutomaticDimension
        tableView.estimatedSectionFooterHeight = 40
        
        data = TestTableData(clickAction: clicked)
    }
    
    func clicked() {
        print("Receieved click")
    }

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
