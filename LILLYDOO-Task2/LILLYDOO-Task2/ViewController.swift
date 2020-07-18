//
//  ViewController.swift
//  LILLYDOO-Task2
//
//  Created by Maxim Vialyx on 7/18/20.
//  Copyright © 2020 Maxim Vialyx. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    private let reuseIdentifier = "cellReuseIdentifier"
    
    weak var tableV: UITableView!
    
    var directory: EmployeeDirectory = DefaultEmployeeDirectory()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tableV = UITableView()
        tableV.translatesAutoresizingMaskIntoConstraints = false
        tableV.delegate = self
        tableV.dataSource = self
        tableV.tableFooterView = UIView()
        tableV.refreshControl = UIRefreshControl()
        tableV.refreshControl?.addTarget(self, action: #selector(refresh), for: .valueChanged)
        self.tableV = tableV
        view.addSubview(tableV)
        NSLayoutConstraint.activate([
            tableV.topAnchor.constraint(equalTo: view.topAnchor),
            tableV.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableV.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableV.leadingAnchor.constraint(equalTo: view.leadingAnchor)
        ])
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(didRefresh),
                                               name: NSNotification.Name(directory.kEmployeeDirectoryDidUpdateNotification),
                                               object: nil)
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: NSLocalizedString("Sort By Name", comment: ""), style: .done, target: self, action: #selector(sortByName))
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        forceRefresh()
    }
    
    private func forceRefresh() {
        tableV.refreshControl?.beginRefreshing()
        refresh()
    }
    
    @objc
    private func refresh() {
        guard !directory.isUpdating else {
            tableV.refreshControl?.endRefreshing()
            return
        }
        directory.update()
    }
    
    @objc
    private func didRefresh() {
        DispatchQueue.main.async {
            [weak self] in
            self?.tableV.refreshControl?.endRefreshing()
            self?.tableV.reloadData()
        }
    }
    
    @objc
    private func sortByName() {
        directory.sortByName()
    }
    
}

// MARK: - UITableViewDelegate
extension ViewController: UITableViewDelegate {}

// MARK: - UITableViewDataSource
extension ViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        directory.employees.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: EmployeeTableViewCell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier) as? EmployeeTableViewCell
            ?? EmployeeTableViewCell(style: .default, reuseIdentifier: reuseIdentifier)
        cell.display(directory.employees[indexPath.row])
        return cell
    }
    
}
