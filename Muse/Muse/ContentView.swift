//
//  ContentView.swift
//  Muse
//
//  Created by Admin on 2022/06/10.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            MainView()
                .tabItem {
                    Image(systemName: "house")
                    Text("홈")
                }
            MyPageView()
                .tabItem {
                    Image(systemName: "square.grid.2x2.fill")
                    Text("내 라이브러리")
                }
        }
        .accentColor(.red)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
