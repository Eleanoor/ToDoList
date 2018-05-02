//  Minor Programmeren, App Studio
//
//  ToDoViewController.swift
//  ToDoList
//
//  Created by Eleanoor Polder (10979301) on 30-04-18.
//  Copyright © 2018 Eleanoor Polder. All rights reserved.
//
//  To Do View Controller for New To Do's.

import UIKit

class ToDoViewController: UITableViewController {
    
    // MARK: - Variables
    var isPickerHidden = true
    var todo: ToDo?

    
    // MARK: - Outlets
    @IBOutlet weak var isCompleteButton: UIButton!
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var dueDateLabel: UILabel!
    @IBOutlet weak var dueDatePickerView: UIDatePicker!
    @IBOutlet weak var notesTextView: UITextView!
    @IBOutlet weak var saveButton: UIBarButtonItem!
    
    // MARK: - Functions
    /// Function that updates save button if there is no text in notes.
    func updateSaveButtonState() {
        let text = titleTextField.text ?? ""
        saveButton.isEnabled = !text.isEmpty
    }
    
    /// Function that loads.
    override func viewDidLoad() {
        super.viewDidLoad()
        if let todo = todo {
            navigationItem.title = "To-Do"
            titleTextField.text = todo.title
            isCompleteButton.isSelected = todo.isComplete
            dueDatePickerView.date = todo.dueDate
            notesTextView.text = todo.notes
        } else {
            dueDatePickerView.date = Date().addingTimeInterval(24*60*60)
        }
        
        updateDueDateLabel(date: dueDatePickerView.date)
        updateSaveButtonState()
    }
    
    /// Function that updates save button after every reaction on the keyboard.
    @IBAction func textEditingChanged(_ sender: UITextField) {
        updateSaveButtonState()
    }
    
    /// Function for return key on the keyboard to dismiss it.
    @IBAction func returnPressed(_ sender: UITextField) {
        titleTextField.resignFirstResponder()
    }
    
    @IBAction func isCompleteButtonTapped(_ sender: UIButton) {
        isCompleteButton.isSelected = !isCompleteButton.isSelected
    }
    
    /// Function for the updating the due date label.
    func updateDueDateLabel(date: Date) {
        dueDateLabel.text = ToDo.dueDateFormatter.string(from: date)
    }
    
    
    /// Function for when the date picker changes.
    @IBAction func datePickerChanged(_ sender: UIDatePicker) {
        updateDueDateLabel(date: dueDatePickerView.date)
    }
    
    /// Function that changed the size for the date picker
    override func tableView(_ tableView: UITableView, heightForRowAt
    indexPath: IndexPath) -> CGFloat {
        let normalCellHeight = CGFloat(44)
        let largeCellHeight = CGFloat(200)
        
        switch(indexPath) {
            case [1,0]: //Due Date Cell
            return isPickerHidden ? normalCellHeight :
            largeCellHeight
        
            case [2,0]: //Notes Cell
            return largeCellHeight
            
            default: return normalCellHeight
        }
    }
    
    /// FUnction
    override func tableView(_ tableView: UITableView, didSelectRowAt
    indexPath: IndexPath) {
        switch (indexPath) {
            case [1,0]:
            isPickerHidden = !isPickerHidden
            
            dueDateLabel.textColor =
            isPickerHidden ? .black : tableView.tintColor
   
            tableView.beginUpdates()
            tableView.endUpdates()

            default: break
        }
    }
    
    /// Function that passes information.
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        
        guard segue.identifier == "saveUnwind" else { return }
        
        let title = titleTextField.text ?? "No Title"
        let isComplete = isCompleteButton.isSelected
        let dueDate = dueDatePickerView.date
        let notes = notesTextView.text
        
        todo = ToDo(title: title, isComplete: isComplete, dueDate: dueDate, notes: notes)
    }
}

