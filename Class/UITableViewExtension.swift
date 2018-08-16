//
//  UITableViewExtension.swift
//  WiggleSDK
//
//  Created by pkh on 2017. 11. 28..
//  Copyright © 2017년 leejaejin. All rights reserved.
//

import Foundation
import UIKit

extension UITableView {
    public func register(_ Class: AnyClass) {
        register(Class, forCellReuseIdentifier: String(describing:Class))
    }
    
    public func registerNibCell(_ Class: AnyClass) {
        register(UINib(nibName: String(describing:Class), bundle: nil), forCellReuseIdentifier: String(describing:Class))
    }
    
    public func registerNibCellHeaderFooter(_ Class: AnyClass) {
        register(UINib(nibName: String(describing:Class), bundle: nil), forHeaderFooterViewReuseIdentifier: String(describing:Class))
    }
    
    public func dequeueReusableCell<T:UITableViewCell>(_ Class: T.Type, for indexPath: IndexPath) -> T {
        return dequeueReusableCell(withIdentifier: String(describing:Class), for: indexPath) as! T
    }
    
    public func dequeueReusableHeaderFooterView<T:UITableViewHeaderFooterView>(_ Class: T.Type) -> T {
        return dequeueReusableHeaderFooterView(withIdentifier: String(describing:Class)) as! T
    }
    
    public func isValidIndexPath(_ indexPath: IndexPath) -> Bool {
        guard dataSource != nil else {
            return false
        }
        
        var sectionCount: Int = 0
        var rowCount: Int = 0
        if dataSource?.responds(to: #selector(UITableViewDataSource.tableView(_:numberOfRowsInSection:))) ?? false {
            sectionCount = dataSource?.tableView(self, numberOfRowsInSection: indexPath.section) ?? 0
        }
        if dataSource?.responds(to: #selector(UITableViewDataSource.numberOfSections(in:))) ?? false {
            rowCount = dataSource?.numberOfSections!(in: self) ?? 0
        }
        if indexPath.section >= sectionCount {
            return false
        }
        if indexPath.row >= rowCount {
            return false
        }
        return true
    }

}
