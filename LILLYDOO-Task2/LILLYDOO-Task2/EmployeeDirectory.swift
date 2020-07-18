//
//  EmployeeDirectory.swift
//  LILLYDOO-Task2
//
//  Created by Maxim Vialyx on 7/18/20.
//  Copyright © 2020 Maxim Vialyx. All rights reserved.
//

import Foundation

protocol EmployeeDirectory {
    var kEmployeeDirectoryDidUpdateNotification: String { get }
    var employees: [Employee] { get }
    var isUpdating: Bool { get }
    func update()
    func sortByName()
}

/*
 Directory can be as `Interactor` layer and call `Service` layer to retrive data
 and `Persistence` to store/get cached results
 */
class DefaultEmployeeDirectory: NSObject, EmployeeDirectory {
    
    var kEmployeeDirectoryDidUpdateNotification: String = "kEmployeeDirectoryDidUpdateNotification"
    
    private(set) var employees: [Employee] = []
    private(set) var isUpdating = false
    
    func update() {
        guard !isUpdating else { return }
        isUpdating = true
        DispatchQueue.global(qos: .background).async {
            [weak self] in
            self?.doUpdateInBackground()
        }
    }
    
    func sortByName() {
        DispatchQueue.global(qos: .background).async {
            [weak self] in
            guard let `self` = self else { return }
            let sorted = self.employees.sorted { ($0.name?.lowercased() ?? "") < ($1.name?.lowercased() ?? "") }
            self.updateDidFinishWithResults(results: sorted)
        }
    }
    
    private func doUpdateInBackground() {
        Thread.sleep(forTimeInterval: 2)
        let names = ["Anne", "Lucas", "Marc", "Zeus", "Hermes", "Bart", "Paul",
                     "John", "Ringo", "Dave", "Taylor"]
        let surnames = ["Hawkins", "Simpson", "Lennon", "Grohl", "Hawkins",
                        "Jacobs", "Holmes", "Mercury", "Matthews"]
        let amount = names.count * surnames.count
        var employees: [Employee] = []
        (0..<amount).forEach {
            _ in
            let fullName = String(format: "%@ %@", names[Int(arc4random()) % names.count], surnames[Int(arc4random()) % surnames.count])
            employees.append(Employee(with: fullName,
                                      birthYear: 1997 - Int(arc4random()) % 50))
        }
        // That is not required as it already executed in .background queue
        DispatchQueue.global(qos: .background).async {
            [weak self] in
            self?.updateDidFinishWithResults(results: employees)
        }
    }
    
    private func updateDidFinishWithResults(results: [Employee]) {
        employees = results
        isUpdating = false
        NotificationCenter.default.post(name: NSNotification.Name(rawValue:
            kEmployeeDirectoryDidUpdateNotification),
                                        object: self)
    }
    
}
