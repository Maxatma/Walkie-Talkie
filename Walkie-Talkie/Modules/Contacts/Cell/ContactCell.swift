//
//  ContactCell.swift
//  Walkie-Talkie
//
//  Created by Zaporozhchenko Oleksandr on 15.05.2020.
//  Copyright © 2020 maxatma. All rights reserved.
//

import Bond


final class СontactCell: SelectableTableCell {
    private var vm: СontactCellVM {
        return viewModel as! СontactCellVM
    }

    @IBOutlet var info: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
    }
    
    override func advise() {
        super.advise()
        vm.info.bind(to: info.reactive.text).dispose(in: bag)
    }
}

