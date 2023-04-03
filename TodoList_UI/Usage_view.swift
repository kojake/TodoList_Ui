//
//  Usage_view.swift
//  TodoList_UI
//
//  Created by kaito on 2023/04/03.
//

import SwiftUI

struct Usage_view: View {
    @State private var tentative = ""
    @State var delete_list = ["テスト1","テスト2","テスト3"]
    
    var body: some View {
        VStack{
            Text("使い方").font(.largeTitle).fontWeight(.black)
            Spacer()
            List{
                VStack{
                    Text("項目を追加する方法").font(.largeTitle).fontWeight(.black)
                    HStack{
                        Text("1.右上にある")
                        Button(action: {
                        }){
                            Circle().foregroundColor(.brown).frame(width:50,height: 50).shadow(radius: 50).overlay(
                                Text("+").fontWeight(.black).font(.title).foregroundColor(.white)
                            )
                        }
                        Text("を押す")
                    }.font(.title).fontWeight(.black)
                }
                VStack{
                    Text("2.").font(.title).fontWeight(.black)
                    ZStack() {
                        Rectangle()
                            .foregroundColor(.gray)
                        VStack {
                            Text("新しく追加したい項目を入力して下さい").font(.title2).fontWeight(.black)
                            TextField("タップして入力",text: $tentative)
                            HStack {
                                Spacer()
                                Button("追加") {
                                }.font(.title2).fontWeight(.black)
                                Spacer()
                                Button("キャンセル") {
                                }.font(.title2).fontWeight(.black)
                                Spacer()
                            }
                        }.padding()
                    }
                    .frame(width: 350, height: 180,alignment: .center)
                    .cornerRadius(20).shadow(radius: 20)
                    Text("ここに自分の追加したい項目を入力する").font(.title).fontWeight(.black)
                }
                VStack{
                    Text("項目を削除する方法").font(.largeTitle).fontWeight(.black)
                    Spacer()
                    Text("消したい項目の所で左にスライドする").font(.title3).fontWeight(.black)
                }
                Spacer()
                VStack{
                    Spacer()
                    ForEach(0 ..< delete_list.count, id: \.self){index in
                        Text(delete_list[index]).fontWeight(.black).font(.title)
                    }.onDelete(perform: rowRemove)
                    Spacer()
                }
            }
        }
    }
    /// 行削除処理
    func rowRemove(offsets: IndexSet) {
        delete_list.remove(atOffsets: offsets)
        sleep(1)
        delete_list.removeAll()
        delete_list.append("テスト1")
        delete_list.append("テスト2")
        delete_list.append("テスト3")
    }
}

struct Usage_view_Previews: PreviewProvider {
    static var previews: some View {
        Usage_view()
    }
}
