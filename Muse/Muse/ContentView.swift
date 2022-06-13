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
        .accentColor(.customPink)
        .onAppear {
            let appearance = UITabBarAppearance()
            appearance.configureWithOpaqueBackground() // View에 맞게 투명도 조절하지 않음
            UITabBar.appearance().scrollEdgeAppearance = appearance
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
