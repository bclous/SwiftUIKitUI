//
// SUIKUI+UITableView.swift
//  
//
//  Created by Brian Clouser on 6/26/22.
//

import UIKit

extension UITableView {
    
    public func registerCellByType<T>(_ type: T.Type) where T: UITableViewCell {
        register(T.classForCoder(), forCellReuseIdentifier: T.classNameString)
    }
    
    public func createCustomCellOfType<T>(_ type: T.Type, registerByType: Bool = true) -> T where T: UITableViewCell {
        if registerByType {
            registerCellByType(type.self)
        }
        return dequeueReusableCell(withIdentifier: T.classNameString) as! T
    }
    
    @discardableResult public func hideScrollIndicator() -> Self {
        self.showsVerticalScrollIndicator = false
        return self
    }
    
    @discardableResult public func assignDelegate(_ delegate: UITableViewDelegate) -> Self {
        self.delegate = delegate
        return self
    }
    
    @discardableResult public func assignDatasource(_ datasource: UITableViewDataSource) -> Self {
        self.dataSource = datasource
        return self
    }
    
    @discardableResult public func implementLocally() -> Self {
        let viewController = findViewController()
        if let dataSource = viewController as? UITableViewDataSource {
            self.dataSource = dataSource
        }
        
        if let delegate = viewController as? UITableViewDelegate {
            self.delegate = delegate
        }
            
        return self
    }
    
}

extension NSObject {
    
    static var classNameString : String {
        return String(describing: Self.self)
    }
}

extension UIView {
    func findViewController() -> UIViewController? {
        if let nextResponder = self.next as? UIViewController {
            return nextResponder
        } else if let nextResponder = self.next as? UIView {
            return nextResponder.findViewController()
        } else {
            return nil
        }
    }
}
