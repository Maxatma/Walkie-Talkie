//
//  ContactsVC.swift
//  Walkie-Talkie
//
//  Created by Zaporozhchenko Oleksandr on 14.05.2020.
//  Copyright © 2020 maxatma. All rights reserved.
//

import UIKit


final class ContactsVC: BondVC {
    var vm: ContactsVM {
        return viewModel as! ContactsVM
    }
    
    @IBOutlet var table: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.isHidden = true
        advise()
        configureTable()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = false
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.navigationBar.isHidden = true
    }
    
    override func advise() {
        super.advise()
    }
    
    private func configureTable() {
        table.registerNibsFor(classes: [СontactCell.self])
        
        vm.items
            .bind(to: table) { vms, indexPath, tableView in
                let cell = tableView.dequeueReusableCell(withIdentifier: "СontactCell", for: indexPath) as! СontactCell
                cell.viewModel = vms[indexPath.row]
                return cell
        }
        .dispose(in: bag)
        
        table.tableFooterView = UIView()
    }
}

