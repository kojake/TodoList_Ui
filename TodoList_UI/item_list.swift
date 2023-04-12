//
//  ContentView.swift
//  TodoList_UI
//
//  Created by kaito on 2023/04/02.
//

import SwiftUI
import Foundation

struct item_list: View {
    @State var item_list = UserDefaults.standard.array(forKey: "item_list_key")?.compactMap { itemString in
        let components = (itemString as! String).components(separatedBy: ",")
        guard components.count == 2 else {
            return nil
        }
        return Item(isChecked: components[0] == "true", name: components[1])
    } ?? []
    @State private var item_house = ""
    @State var item_add_alert = false
    @State private var shouldShowUsage_view = false
    @State private var shouldShowGarbage_can_View = false
    
    var body: some View {
        NavigationView {
            VStack {
                NavigationLink(destination: Usage_view(), isActive: $shouldShowUsage_view) {
                    EmptyView()
                }.navigationBarBackButtonHidden(true)
                HStack{
                    Spacer()
                    Text("TodoList").font(.largeTitle).fontWeight(.black)
                    Spacer()
                    Button(action: {
                        self.item_add_alert.toggle()
                    }){
                        Circle().foregroundColor(.brown).frame(width:70,height: 70).shadow(radius: 50).overlay(
                            Text("+").fontWeight(.black).font(.title).foregroundColor(.white)
                        )
                    }
                    Button(action: {
                        shouldShowUsage_view = true
                    }){
                        Circle().foregroundColor(.brown).frame(width:70,height: 70).shadow(radius: 50).overlay(
                            Text("≡").fontWeight(.black).font(.title).foregroundColor(.white)
                        )
                    }
                    Spacer()
                }
                List{
                    ForEach(0 ..< item_list.count, id: \.self){index in
                        HStack {
                            Image(systemName: item_list[index].isChecked ? "checkmark.square" : "square")
                                .onTapGesture {
                                    item_list[index].isChecked.toggle()
                                    saveitems()
                                }
                            Text(item_list[index].name)
                        }
                    }
                    .onDelete(perform: rowRemove)
                }
                if item_add_alert {
                    ZStack() {
                        Rectangle()
                            .foregroundColor(.gray)
                        VStack {
                            Text("新しく追加したい項目を入力して下さい").font(.title2).fontWeight(.black)
                            TextField("タップして入力",text: $item_house)
                            HStack {
                                Spacer()
                                Button("追加") {
                                    item_list.append(Item(isChecked: false, name: item_house))
                                    saveitems()
                                    //項目追加内容をリセットする
                                    item_house = ""
                                    //追加入力画面を閉じる
                                    self.item_add_alert.toggle()
                                }.font(.title2).fontWeight(.black)
                                Spacer()
                                Button("キャンセル") {
                                    //追加入力画面を閉じる
                                    self.item_add_alert.toggle()
                                }.font(.title2).fontWeight(.black)
                                Spacer()
                            }
                        }.padding()
                    }
                    .frame(width: 350, height: 180,alignment: .center)
                    .cornerRadius(20).shadow(radius: 20)
                }
            }
        }
    }
    
    /// 行削除処理
    func rowRemove(offsets: IndexSet) {
        //削除する
        item_list.remove(atOffsets: offsets)
        saveitems()
    }
    func saveitems(){
        let itemStrings = item_list.map { item in
            return "\(item.isChecked),\(item.name)"
        }
        UserDefaults.standard.set(itemStrings, forKey: "item_list_key")
    }
}
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        item_list()
    }
}

struct Item {
    var isChecked: Bool
    var name: String
    
    init(_ name: String) {
        self.isChecked = false
        self.name = name
    }
}
