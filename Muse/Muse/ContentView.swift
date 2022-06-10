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
                    Label("홈", systemImage: "house")
                }
            MyPageView()
                .tabItem {
                    Label("내 라이브러리", systemImage: "square.grid.2x2.fill")
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
