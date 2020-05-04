//
//  SelectableTableCell.swift
//
//
//  Created by Alexander Zaporozhchenko on 1/1/19.
//  Copyright © 2017 Alexander Zaporozhchenko. All rights reserved.
//

import Bond
import ReactiveKit

public protocol SelectableProtocol: BondVMProtocol {
    var doSelect: SafePublishSubject<()> { get }
}

class SelectableTableCell: BondTableCell {
    let doSelect = SafePublishSubject<()>()

    var selectableVM: SelectableProtocol {
        return viewModel as! SelectableProtocol
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        let tap = UITapGestureRecognizer(target: self, action: #selector(gestureAction))
        self.addGestureRecognizer(tap)
    }
    
    @objc func gestureAction() {
        doSelect.next()
    }
    
    override func advise() {
        super.advise()
        doSelect
            .bind(to: selectableVM.doSelect)
            .dispose(in: bag)
    }
}
