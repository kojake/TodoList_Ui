//
//  ContentView.swift
//  TodoList_UI
//
//  Created by kaito on 2023/04/02.

import SwiftUI

struct TodoItem: Codable{
    var name: String
    var isChecked: Bool
}

struct item_list: View {
    @State var item_list = [TodoItem]() // Todoアイテムの配列
    @State private var item_house = ""
    @State var item_add_alert = false
    @State private var shouldShowUsageView = false
    @State private var shouldShowGarbageCanView = false
    
    var body: some View {
        NavigationView {
                    VStack {
                        NavigationLink(destination: Usage_view(), isActive: $shouldShowUsageView) {
                            EmptyView()
                        }.navigationBarBackButtonHidden(true)
                        HStack{
                            Spacer()
                            Text("TodoList").font(.largeTitle).fontWeight(.black).onAppear{
                                if let data = UserDefaults.standard.data(forKey: "item_list_key"), let items = try? PropertyListDecoder().decode([TodoItem].self, from: data) {
                                    item_list = items // UserDefaultsから読み込んだ値を代入する
                                }
                            }
                            Spacer()
                            Button(action: {
                                self.item_add_alert.toggle()
                            }){
                                Circle().foregroundColor(.brown).frame(width:70,height: 70).shadow(radius: 50).overlay(
                                    Text("+").fontWeight(.black).font(.title).foregroundColor(.white)
                                )
                            }
                            Button(action: {
                                shouldShowUsageView = true
                            }){
                                Circle().foregroundColor(.brown).frame(width:70,height: 70).shadow(radius: 50).overlay(
                                    Text("≡").fontWeight(.black).font(.title).foregroundColor(.white)
                                )
                            }
                            Spacer()
                        }
                        List{
                            ForEach(item_list.indices, id: \.self) { index in // indexを追加
                                let todoItem = item_list[index]
                                HStack {
                                    Image(systemName: todoItem.isChecked ? "checkmark.square.fill" : "square") // チェック済みの場合はチェックマーク、そうでない場合は四角を表示する
                                        .foregroundColor(todoItem.isChecked ? .green : .black) // チェック済みの場合は緑色にする
                                        .onTapGesture {
                                            item_list[index].isChecked.toggle() // isCheckedプロパティをトグル
                                            UserDefaults.standard.set(try? PropertyListEncoder().encode(item_list), forKey: "item_list_key") // UserDefaultsに保存
                                        }
                                    Text(todoItem.name).fontWeight(.black)
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
                                    item_list.append(TodoItem(name: item_house, isChecked: false))
                                    // 項目追加内容をリセットする
                                    item_house = ""
                                    // UserDefaultsに保存する
                                    UserDefaults.standard.set(item_list.map { $0.name }, forKey: "item_list_key")
                                    // 追加入力画面を閉じる
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
        UserDefaults.standard.set(item_list, forKey: "item_list_key")
    }
}
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        item_list()
    }
}
