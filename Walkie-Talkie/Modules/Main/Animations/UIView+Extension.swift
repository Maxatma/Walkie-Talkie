//
//  UIView+Extension.swift
//  Walkie-Talkie
//
//  Created by Zaporozhchenko Oleksandr on 5/9/20.
//  Copyright © 2020 maxatma. All rights reserved.
//

import UIKit


extension UIView {
    func add(_ subviews: UIView...) {
        subviews.forEach(addSubview)
    }
    
    func add(_ subviews: [UIView]) {
        subviews.forEach(addSubview)
    }

    
    func remove(_ subviews: UIView...) {
        subviews.forEach { $0.removeFromSuperview() }
    }
    
    func remove(_ subviews: [UIView]) {
        subviews.forEach { $0.removeFromSuperview() }
    }

    
    func frameOfViewInWindowsCoordinateSystem() -> CGRect {
        if let superview = superview {
            return superview.convert(frame, to: nil)
        }
        print("! view is not in hierarchy: \n \(self)\n")
        return frame
    }
}

extension UIView {
    func createAndOverlapWithSnapshot(afterScreenUpdates: Bool) -> UIView? {
        let view = snapshotView(afterScreenUpdates: afterScreenUpdates)
        view?.frame = frameOfViewInWindowsCoordinateSystem()
        return view
    }
}
