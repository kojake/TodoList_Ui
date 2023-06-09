//
//  todo_add_View.swift
//  TodoList_UI
//
//  Created by kaito on 2023/04/30.
//

import SwiftUI

struct todo_add_View: View {
    @Binding var item_list: [item_list]
    @State private var item_house = ""
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        NavigationView{
            VStack{
                Text("やることを追加する").font(.largeTitle).fontWeight(.black)
                Button("追加") {
                    item_list.append(TodoItem(name: item_house, isChecked: false))
                    // 項目追加内容をリセットする
                    item_house = ""
                    // UserDefaultsに保存する
                    UserDefaults.standard.set(item_list.map { $0.name }, forKey: "item_list_key")
                    // 追加入力画面を閉じる
                    dismiss()
                }.font(.title2).fontWeight(.black)
            }
        }.navigationBarItems(leading: Button("✖️"){
            dismiss()
        })
    }
}
