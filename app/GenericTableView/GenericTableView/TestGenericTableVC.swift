//
//  TestGenericTableVC.swift
//  GenericTableView
//
//  Created by Paul Fechner on 8/5/18.
//  Copyright © 2018 peejweej.inc. All rights reserved.
//

import UIKit

extension UITableView {
    static var AutomaticDimension: CGFloat {
        return UITableViewAutomaticDimension
    }
}

enum CellCreationInfo {
    case nib(nibName: String)
    case `class`(`class`: AnyClass)
}

protocol TableData {
    var sections: [TableSection] { get }
}

struct TestTableData {
    var sections = [TableSection(header: TestHeaderRepresentor(model: ExampleTestHeaderModel(title: "Header")), 
                                 rows: [TestCellRepresentor(model: ExampleTestCellModel(title: "First")),
                                        TestCellRepresentor(model: ExampleTestCellModel(title: "Second"))], 
                                 footer: TestFooterRepresentor(model: ExampleTestFooterModel(title: "Footer")))]
}

struct TableSection {
    var header: AnyHeaderFooterRepresentor?
    var rows: [AnyCellRepresentor]
    var footer: AnyHeaderFooterRepresentor?
}



protocol TableItemRepresentor {
    associatedtype CellType
    associatedtype CellModelType
    
    var model: CellModelType { get }
    
    var identifier: String { get }
    var creationInfo: CellCreationInfo { get }
}

protocol AnyHeaderFooterRepresentor {
    func makeAndUpdateCell(from tableView: UITableView) -> UIView?
}

protocol HeaderFooterRepresentor: TableItemRepresentor, AnyHeaderFooterRepresentor {
    
}

protocol AnyCellRepresentor {
    func makeAndUpdateCell(from tableView: UITableView, indexPath: IndexPath) -> UITableViewCell
}

protocol CellRepresentor: TableItemRepresentor, AnyCellRepresentor {
     
}

struct TestHeaderRepresentor: HeaderFooterRepresentor {
    
    typealias CellType = TestHeader.Type
    
    var identifier: String = "TestHeader"
    var creationInfo: CellCreationInfo = .nib(nibName: "TestHeader")
    
    var model: TestHeader.ModelType
    
    init(model: CellModelType) {
        self.model = model
    }
    
    func makeAndUpdateCell(from tableView: UITableView) -> UIView? {
        guard let cell = tableView.dequeueReusableHeaderFooterView(withIdentifier: identifier) as? TestHeader else {
            return nil
        }
        cell.update(with: model)
        return cell
    }
}

struct TestFooterRepresentor: HeaderFooterRepresentor {
    typealias CellType = TestFooter.Type
    
    var identifier: String = "TestFooter"
    var creationInfo: CellCreationInfo = .nib(nibName: "TestFooter")
    
    var model: TestFooter.ModelType
    
    init(model: CellModelType) {
        self.model = model
    }
    
    func makeAndUpdateCell(from tableView: UITableView) -> UIView? {
        guard let cell = tableView.dequeueReusableHeaderFooterView(withIdentifier: identifier) as? TestFooter else {
            return nil
        }
        cell.update(with: model)
        return cell
    }
}

struct TestCellRepresentor: CellRepresentor {
    typealias CellType = TestCell.Type
    
    var identifier: String = "TestCell"
    var creationInfo: CellCreationInfo = .nib(nibName: "TestCell")
    
    var model: TestCell.ModelType
    
    init(model: CellModelType) {
        self.model = model
    }
    
    func makeAndUpdateCell(from tableView: UITableView, indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath) as? TestCell else {
            return UITableViewCell()
        }
        cell.update(with: model)
        return cell
    }
}



class TestGenericTableVC: UITableViewController {

    var data = TestTableData()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.register(UINib(nibName: "TestCell", bundle: nil), forCellReuseIdentifier: "TestCell")
        tableView.register(UINib(nibName: "TestHeader", bundle: nil), forHeaderFooterViewReuseIdentifier: "TestHeader")
        tableView.register(UINib(nibName: "TestFooter", bundle: nil), forHeaderFooterViewReuseIdentifier: "TestFooter")
        
        tableView.rowHeight = UITableView.AutomaticDimension
        tableView.sectionHeaderHeight = UITableView.AutomaticDimension
        tableView.estimatedSectionHeaderHeight = 60
        tableView.sectionFooterHeight = UITableView.AutomaticDimension
        tableView.estimatedSectionFooterHeight = 40
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return data.sections.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.sections[section].rows.count
    }

    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return data.sections[section].header?.makeAndUpdateCell(from: tableView)
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return data.sections[indexPath.section].rows[indexPath.row].makeAndUpdateCell(from: tableView, indexPath: indexPath)
    }
    
    override func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return data.sections[section].footer?.makeAndUpdateCell(from: tableView)
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
