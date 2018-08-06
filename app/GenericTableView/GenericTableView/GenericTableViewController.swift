//
//  GenericTableViewController.swift
//  GenericTableView
//
//  Created by Paul Fechner on 8/5/18.
//  Copyright © 2018 peejweej.inc. All rights reserved.
//

import UIKit

protocol ModelUpdatable {
    associatedtype ModelType 
    func update(with model: ModelType)
}

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
    
    init()
    
    static func registerCells(with tableView: UITableView)
}

extension TableData {
    func item(at indexPath: IndexPath) -> AnyCellRepresentor {
        return sections[indexPath.section].rows[indexPath.row]
    }
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

extension TableItemRepresentor where CellType: NibReusable {
    
    var identifier: String {
        return CellType.reuseIdentifier
    }
    
    var creationInfo: CellCreationInfo {
        return CellCreationInfo.nib(nibName: identifier)
    }
}

protocol AnyHeaderFooterRepresentor {
    func makeAndUpdateCell(from tableView: UITableView) -> UIView?
}

protocol HeaderFooterRepresentor: TableItemRepresentor & AnyHeaderFooterRepresentor {
    
}

struct GenericHeaderFooterRepresentor<T: UITableViewHeaderFooterView>: HeaderFooterRepresentor where T: NibReusable & ModelUpdatable {
    typealias CellType = T
    
    var model: T.ModelType
    
    init(model: CellModelType) {
        self.model = model
    }
}

protocol AnyCellRepresentor {
    func makeAndUpdateCell(from tableView: UITableView, indexPath: IndexPath) -> UITableViewCell
}

protocol CellRepresentor: TableItemRepresentor & AnyCellRepresentor {
    
}

struct GenericCellRepresentor<T: UITableViewCell>: CellRepresentor where T: NibReusable & ModelUpdatable {
    typealias CellType = T
    
    var model: T.ModelType
    
    init(model: CellModelType) {
        self.model = model
    }
}

extension CellRepresentor where CellType: UITableViewCell, CellType: ModelUpdatable, CellType.ModelType == CellModelType  {
    
    func makeAndUpdateCell(from tableView: UITableView, indexPath: IndexPath) -> UITableViewCell {
        guard let cell: CellType = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath) as? CellType else {
            return UITableViewCell()
        }
        cell.update(with: model)
        return cell
    }
}

extension HeaderFooterRepresentor where CellType: UIView, CellType: ModelUpdatable, CellType.ModelType == CellModelType  {
    
    func makeAndUpdateCell(from tableView: UITableView) -> UIView? {
        guard let cell: CellType = tableView.dequeueReusableHeaderFooterView(withIdentifier: identifier) as? CellType else {
            return UITableViewCell()
        }
        cell.update(with: model)
        return cell
    }
}



class GenericTableViewController<T: TableData>: UITableViewController {
    
    var data: T = T() {
        didSet {
            tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        T.registerCells(with: tableView)
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
}
