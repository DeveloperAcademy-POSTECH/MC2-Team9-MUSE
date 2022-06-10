//
//  MainView.swift
//  Muse
//
//  Created by Admin on 2022/06/10.
//

import SwiftUI

struct MainView: View {
    var body: some View {
        ZStack {
            Color.bgGrey.ignoresSafeArea()
            ZStack {
                Image("machine")
                Image("ticket")
                Text("메인 뷰!good")
            }
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
