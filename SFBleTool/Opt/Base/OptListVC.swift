//
//  OptListVC.swift
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

// MARK: OptListVC
class OptListVC: SFTableViewController {
    
    // MARK: var
    private var models = [OptModel]()
    
    // MARK: life cycle
    convenience init() {
        self.init(style: .grouped)
    }
    private override init(style: UITableView.Style) {
        super.init(style: style)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(cellType: OptListCell.self)
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: SFText.Main.opt_list_new, style: .plain, target: self, action: #selector(addItemClicked))
    }
    
    // MARK: - func
    func addNew() {
        
    }
}

// MARK: - UITableViewDelegate, UITableViewDataSource
extension OptListVC: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return models.count
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(for: indexPath, cellType: OptListCell.self)
        return cell
    }
}

// MARK: - Action
extension OptListVC {
    @objc func addItemClicked() {
        addNew()
    }
}

