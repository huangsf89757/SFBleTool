//
//  OptionListVC.swift
//  SFBleTool
//
//  Created by hsf on 2024/11/22.
//

import Foundation
import UIKit
// Basic
import SFExtension
import SFBase
// UI
import SFUI

// MARK: OptionListVC
class OptionListVC: SFTableViewController {
    
    // MARK: var
    private var models = [OptionModel]()
    
    // MARK: life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(cellType: OptionListCell.self)
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "新建", style: .plain, target: self, action: #selector(addItemClicked))
    }
    
    // MARK: - func
    func add() {
        
    }
}

// MARK: - UITableViewDelegate, UITableViewDataSource
extension OptionListVC: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return models.count
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(for: indexPath, cellType: OptionListCell.self)
        return cell
    }
}

// MARK: - Action
extension OptionListVC {
    @objc func addItemClicked() {
        add()
    }
}

