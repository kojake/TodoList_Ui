//
//  Garbage_can_View.swift
//  TodoList_UI
//
//  Created by kaito on 2023/04/04.
//

import SwiftUI



struct Garbage_can_View: View {
    @State var Garbage_can_list = Garbage_can_list_tentative
    @State var item_list_tentative = UserDefaults.standard.object(forKey: "item_list_key") as! [String]
    
    var body: some View {
        VStack{
            HStack{
                Text("ゴミ箱").font(.largeTitle).fontWeight(.black)
                Circle().foregroundColor(.brown).frame(width:100,height: 100).shadow(radius: 50).overlay(
                    Image(systemName: "trash.fill").foregroundColor(.white).font(.largeTitle))
            }
            Text("ここでは、間違って消したリスト").font(.title).fontWeight(.black)
            Text("を元に戻せます").font(.title).fontWeight(.black)
            Text("完全削除もできます。").font(.title).fontWeight(.black)
            Spacer()
            
            //ゴミ箱リスト
            List{
                ForEach(0 ..< Garbage_can_list.count, id: \.self) {index in
                    Text(Garbage_can_list[index]).fontWeight(.black).font(.title)
                }.onDelete(perform: rowRemove)
            }
        }
    }
    
    func rowRemove(offsets: IndexSet) {
        item_list += Garbage_can_list
        Garbage_can_list.remove(atOffsets: offsets)
    }
}

struct Garbage_can_View_Previews: PreviewProvider {
    static var previews: some View {
        Garbage_can_View()
    }
}
