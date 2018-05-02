//  Minor Progreammeren, App Studio
//
//  ToDo.swift
//  ToDoList
//
//  Created by Eleanoor Polder (10979301) on 30-04-18.
//  Copyright © 2018 Eleanoor Polder. All rights reserved.
//
//  Struct for To Do.

import UIKit

// A To Do struct.
struct ToDo: Codable {
    var title: String
    var isComplete: Bool
    var dueDate: Date
    var notes: String?
    
    /// Function that retrieves the array of items stored on disk and returns them if the disk contains any items.
    static func loadToDos() -> [ToDo]?  {
        guard let codedToDos = try? Data(contentsOf: ArchiveURL) else {return nil}
        let propertyListDecoder = PropertyListDecoder()
        return try? propertyListDecoder.decode(Array<ToDo>.self,
            from: codedToDos)
    }
    
    /// Function that populates the array with sample data.
    static func loadSampleToDos() -> [ToDo] {
        let todo1 = ToDo(title: "ToDo One", isComplete: false, dueDate: Date(), notes: "Notes 1")
        let todo2 = ToDo(title: "ToDo Two", isComplete: false, dueDate: Date(), notes: "Notes 2")
        let todo3 = ToDo(title: "ToDo Three", isComplete: false,dueDate: Date(), notes: "Notes 3")
        
        return [todo1, todo2, todo3]
    }
    
    /// Function
    static func saveToDos(_ todos: [ToDo]) {
        let propertyListEncoder = PropertyListEncoder()
        let codedToDos = try? propertyListEncoder.encode(todos)
        try? codedToDos?.write(to: ArchiveURL,
        options: .noFileProtection)
    }

    // Convert date into a string.
    static let dueDateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        formatter.timeStyle = .short
        return formatter
    }()
    
    //
    static let DocumentsDirectory = FileManager.default.urls(for: .documentDirectory,in: .userDomainMask).first!
    static let ArchiveURL = DocumentsDirectory.appendingPathComponent("todos").appendingPathExtension("plist")
}


