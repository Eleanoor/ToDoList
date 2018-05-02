//  Minor Programmeren, App Studio
//
//  TableViewController.swift
//  ToDoList
//
//  Created by Eleanoor Polder (10979301) on 30-04-18.
//  Copyright © 2018 Eleanoor Polder. All rights reserved.
//
//  View Controller for My To Do's.

import UIKit

// Define a subclass
class ToDoTableViewController: UITableViewController, ToDoCellDelegate {
  
    // MARK: - Variables
    var todos = [ToDo]()
    
    
    // MARK: - Functions
    /// Function for table view cells.
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return todos.count
    }
    
    /// Function to specify the cell you're in.
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell =
        tableView.dequeueReusableCell(withIdentifier:
        "ToDoCellIdentifier") as? ToDoCell else {
            fatalError("Could not dequeue a cell")
        }
    
        cell.delegate = self
        
        let todo = todos[indexPath.row]
        cell.titleLabel?.text = todo.title
        cell.isCompleteButton.isSelected = todo.isComplete
        return cell
    }
    
    /// Function to add swipe-to-delete functionality.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    /// Function for deleting.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            todos.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
    /// Function that loads items from disk.
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let savedToDos = ToDo.loadToDos() {
            todos = savedToDos
        } else {
            todos = ToDo.loadSampleToDos()
        }
        
        navigationItem.leftBarButtonItem = editButtonItem
    }

    
    /// Function for the view controller to access the property and add it to the collection.
    @IBAction func unwindToToDoList(segue: UIStoryboardSegue) {
        guard segue.identifier == "saveUnwind" else { return }
        let sourceViewController = segue.source as!
        ToDoViewController
        
        if let todo = sourceViewController.todo {
            if let selectedIndexPath =
                tableView.indexPathForSelectedRow {
                todos[selectedIndexPath.row] = todo
                tableView.reloadRows(at: [selectedIndexPath],
                                     with: .none)
            } else {
                let newIndexPath = IndexPath(row: todos.count,
                                             section: 0)
                todos.append(todo)
                tableView.insertRows(at: [newIndexPath],
                                     with: .automatic)
            }
        }
        
        ToDo.saveToDos(todos)
    }
    
    /// Function to pass the saved values.
    override func prepare(for segue: UIStoryboardSegue, sender:
        Any?) {
        if segue.identifier == "showDetails" {
            let todoViewController = segue.destination as! ToDoViewController
            let indexPath = tableView.indexPathForSelectedRow!
            let selectedTodo = todos[indexPath.row]
            todoViewController.todo = selectedTodo
        }
    }
    
    /// Function for if the checkmark is tapped.
    func checkmarkTapped(sender: ToDoCell) {
        if let indexPath = tableView.indexPath(for: sender) {
            var todo = todos[indexPath.row]
            todo.isComplete = !todo.isComplete
            todos[indexPath.row] = todo
            tableView.reloadRows(at: [indexPath], with: .automatic)
            ToDo.saveToDos(todos)
        }
    }

//    // Function for if the complete button is tapped.
//    func completeButtonTapped(sender: ToDoCell) {
//        if let indexPath = tableView.indexPath(for: sender) {
//            var todo = todos[indexPath.row]
//            todo.isComplete = !todo.isComplete
//            tableView.reloadRows(at: [indexPath], with: .automatic)
//        }
//    }
}


