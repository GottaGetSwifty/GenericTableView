//
//  NibHelper.swift
//  GenericTableView
//
//  Created by Paul Fechner on 8/6/18.
//  Copyright © 2018 peejweej.inc. All rights reserved.
//

import UIKit

public protocol NibReusable  {
    static var nib: UINib { get }
    static var reuseIdentifier: String { get }
}

public extension NibReusable where Self: UITableViewCell {
    static var nib: UINib {
        return UINib(nibName: String(describing: self), bundle: Bundle(for: self))
    }
    
    static var reuseIdentifier: String {
        return String(describing: self)
    }
}

public extension NibReusable where Self: UITableViewHeaderFooterView {
    static var nib: UINib {
        return UINib(nibName: String(describing: self), bundle: Bundle(for: self))
    }
    
    static var reuseIdentifier: String {
        return String(describing: self)
    }
}

public extension UITableView {
    
    final func registerReusableCellNib<T: UITableViewCell>(cellType: T.Type) where T: NibReusable {
        self.register(T.nib, forCellReuseIdentifier: T.reuseIdentifier)
    }
    
    final func registerReusableHeaderFooterView<T: UITableViewHeaderFooterView>(viewType: T.Type) where T: NibReusable {
        self.register(T.nib, forHeaderFooterViewReuseIdentifier: T.reuseIdentifier)
    }
}
