//
//  TodoView.swift
//  TodoListCleanArc
//
//  Created by Reza Harris on 26/10/21.
//

import SwiftUI

struct TodoView: View {
    @ObservedObject var presenter = TodoPresenter()
    var interactor = TodoInteractor()
//    var router: (NSObjectProtocol & TodoRoutingLogic & TodoDataPassing)?
    
    var body: some View {
        NavigationView {
            List {
                ForEach(presenter.todos, id: \.id) { todo in
                    Text(todo.text)
                }
            }
            .navigationBarTitle("Todo", displayMode: .inline)
            .navigationBarItems(trailing: Button(action: {
                print("Add")
            }){
                Image(systemName: "plus")
            })
            .onAppear(perform: {
                let request = TodoModels.Fetch.Request()
                interactor.presenter = presenter
                interactor.fetchData(request: request)
            })
        }
    }
}

struct TodoView_Previews: PreviewProvider {
    static var previews: some View {
        TodoView()
    }
}
