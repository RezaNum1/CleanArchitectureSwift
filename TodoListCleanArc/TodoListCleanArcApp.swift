//
//  TodoListCleanArcApp.swift
//  TodoListCleanArc
//
//  Created by Reza Harris on 26/10/21.
//

import SwiftUI

@main
struct TodoListCleanArcApp: App {
    let interactor = TodoInteractor()
    let presenter = TodoPresenter()
    var body: some Scene {
        WindowGroup {
            TodoView(presenter: presenter, interactor: interactor)
        }
    }
}
