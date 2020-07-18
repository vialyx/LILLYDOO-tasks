//
//  EmployeeTableViewCell.swift
//  LILLYDOO-Task2
//
//  Created by Maxim Vialyx on 7/18/20.
//  Copyright © 2020 Maxim Vialyx. All rights reserved.
//

import UIKit

class EmployeeTableViewCell: UITableViewCell {
    
    weak var nameL: UILabel!
    weak var birthdayL: UILabel!
    weak var salaryL: UILabel!
    
    private var formatter: NumberFormatter = {
        var fmt = NumberFormatter()
        fmt.numberStyle = .currency
        fmt.locale = Locale(identifier: "en-DE")
        fmt.minimumFractionDigits = 0
        return fmt
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        createUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        nameL.text = nil
        birthdayL.text = nil
        salaryL.text = nil
    }
    
    private func createUI () {
        let stackV = UIStackView()
        stackV.translatesAutoresizingMaskIntoConstraints = false
        stackV.axis = .horizontal
        stackV.spacing = 8
        
        let nameL = UILabel()
        nameL.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        stackV.addArrangedSubview(nameL)
        self.nameL = nameL
        
        let birthdayL = UILabel()
        birthdayL.textColor = .brown
        stackV.addArrangedSubview(birthdayL)
        self.birthdayL = birthdayL
        
        let salaryL = UILabel()
        stackV.addArrangedSubview(salaryL)
        self.salaryL = salaryL
        
        addSubview(stackV)
        NSLayoutConstraint.activate([
            stackV.topAnchor.constraint(equalTo: topAnchor, constant: -16),
            stackV.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 16),
            stackV.leftAnchor.constraint(equalTo: leftAnchor, constant: 16),
            stackV.rightAnchor.constraint(equalTo: rightAnchor, constant: -16)
        ])
    }
    
    func display(_ employee: Employee) {
        nameL.text = employee.name
        employee.birthYear.flatMap { birthdayL.text = String($0) }
        salaryL.text = formatter.string(for: employee.salary)
    }

}
