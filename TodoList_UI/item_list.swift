//
//  ContentView.swift
//  TodoList_UI
//
//  Created by kaito on 2023/04/02.
//

import SwiftUI

struct item_list: View {
    @State var item_list = [String]()
    @State private var item_house = ""
    @State var item_add_alert = false
    
    var body: some View {
        VStack {
            HStack{
                Spacer()
                Text("チェックリスト").font(.largeTitle).fontWeight(.black)
                Spacer()
                Button(action: {
                    self.item_add_alert.toggle()
                }){
                    Circle().foregroundColor(.brown).frame(width:50,height: 50).shadow(radius: 50).overlay(
                        Text("+").fontWeight(.black).font(.title).foregroundColor(.white)
                    )
                }
                Spacer()
            }
            NavigationView{
                List{
                    ForEach(0 ..< item_list.count, id: \.self){item in
                        Text(item_list[item]).font(.largeTitle).fontWeight(.black)
                    }
                }
                .navigationBarTitle("戻る")
                    .navigationBarHidden(true)
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
                                        //項目を追加する
                                        item_list.append(item_house)
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
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        item_list()
    }
}
