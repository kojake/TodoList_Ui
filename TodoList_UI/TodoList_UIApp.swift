//
//  TodoList_UIApp.swift
//  TodoList_UI
//
//  Created by kaito on 2023/04/02.
//

import SwiftUI

var Garbage_can_list_tentative = [String]()
var item_list_tentative = [String]()

@main
struct TodoList_UIApp: App {
    var body: some Scene {
        WindowGroup {
            item_list()
        }
    }
}
