//  Minor Programmeren, App Studio
//
//  ToDoCell.swift
//  ToDoList
//
//  Created by Eleanoor Polder (10979301) on 02-05-18.
//  Copyright © 2018 Eleanoor Polder. All rights reserved.
//
//  To Do Cell.

import UIKit

// Protocol with a method that passes the cell back to the delegate.
@objc protocol ToDoCellDelegate: class {
    func checkmarkTapped(sender: ToDoCell)
}

class ToDoCell : UITableViewCell {
    var delegate: ToDoCellDelegate?
    
    // MARK: - Outlets
    @IBOutlet weak var isCompleteButton: UIButton!
    @IBOutlet weak var titleLabel: UILabel!
    
    // MARK: - Functions
    @IBAction func completeButtonTapped() {
    delegate?.checkmarkTapped(sender: self)
    }
}
