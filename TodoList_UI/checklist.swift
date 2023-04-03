//
//  checklist.swift
//  TodoList_UI
//
//  Created by kaito on 2023/04/02.
//

import SwiftUI

struct checklist: View {
    var name: String = ""
    @State var check_list: [String: String] = ["": ""]
    
    var body: some View {
        VStack{
            Text(name).font(.largeTitle).fontWeight(.black)
            Spacer()
            List{
                ForEach(check_list.indices) { index in
                    ForEach(self.check_list[index]) {one in
                        Text("\(one.name)")
                    }
                }
            }
        }
    }
}

struct checklist_Previews: PreviewProvider {
    static var previews: some View {
        checklist()
    }
}
