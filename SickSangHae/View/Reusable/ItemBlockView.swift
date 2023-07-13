//
//  ItemBlockView.swift
//  SickSangHae
//
//  Created by Narin Kang on 2023/07/13.
//

import SwiftUI

struct ItemBlockView: View {
    var body: some View {
        ZStack {
            Rectangle()
                .frame(width: 350, height: 116)
                .foregroundColor(.tempGrayColor)
                .cornerRadius(12)
            VStack(alignment: .leading) {
                HStack {
                    Text("품목")
                        .padding(.leading,20)
                    Text("품목을 입력해주세요.")
                        .foregroundColor(.lightGrayColor)
                        .padding(.leading,30)
                }
                Divider()
                    .frame(width: 350, height: 10)
                    .foregroundColor(.whatGrayColor)
                HStack {
                    Text("금액")
                        .padding(.leading,20)
                    Text("금액을 입력해주세요.")
                        .foregroundColor(.lightGrayColor)
                        .padding(.leading,30)
                }
            }
        }
    }
}

struct ItemBlockView_Previews: PreviewProvider {
    static var previews: some View {
        ItemBlockView()
    }
}
