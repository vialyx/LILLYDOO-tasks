//
//  Employee.swift
//  LILLYDOO-Task2
//
//  Created by Maxim Vialyx on 7/18/20.
//  Copyright © 2020 Maxim Vialyx. All rights reserved.
//

import Foundation

class Employee: NSObject {
    private let startingSalary: Double = 10000
    
    var name: String?
    var birthYear: Int?
    var salary: Double?
    
    init(with name: String, birthYear: Int) {
        self.name = name
        self.birthYear = birthYear
        salary = startingSalary
    }
    
}
