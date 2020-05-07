//
//  RegisterNibsExtension.swift
//  
//
//  Created by Alexander Zaporozhchenko on 1/1/19.
//  Copyright 2017 . All rights reserved.
//

import UIKit


extension UITableView {
    
    func scrollToTop() {
        self.setContentOffset(CGPoint(x: 0, y: 0), animated: true)
    }
    
    func scrollToBot() {
        
        let lastSection = self.numberOfSections - 1
        guard lastSection >= 0 else { return }
        
        let lastRow = self.numberOfRows(inSection: lastSection) - 1
        guard lastRow >= 0 else { return }
        
        let path = IndexPath(row: lastRow, section: lastSection)
        
        DispatchQueue.main.async(execute: { () -> Void in
            self.scrollToRow(at: path as IndexPath, at: .top, animated: false)
        })
    }
    
    func registerNibsFor(classes: [AnyClass]) {
        classes.forEach { (cellClass) in
            let cellId = String(describing: cellClass)
            let bundle = Bundle(for: cellClass)
            let nib    = UINib(nibName: cellId, bundle: bundle)
            self.register(nib, forCellReuseIdentifier: cellId)
        }
    }
}

extension UICollectionView {
    
    func registerNibsFor(classes: [AnyClass]) {
        classes.forEach { (cellClass) in
            let cellId = String(describing: cellClass)
            let bundle = Bundle(for: cellClass)
            let nib    = UINib(nibName: cellId, bundle: bundle)
            self.register(nib, forCellWithReuseIdentifier: cellId)
        }
    }
}

