//
//  MypageView.swift
//  Muse
//
//  Created by Admin on 2022/06/10.
//

import SwiftUI

enum LibraryType: String, CaseIterable {
    case myTicket = "나의 음악 티켓"
    case saved = "저장한 티켓"
}

struct TicketListView: View {
    var ticketList: String
    
    var body: some View {
        ScrollView {
            VStack(spacing: 10) {
                ForEach(0..<100) {_ in
                    Text(ticketList)
                }
            }
        }
    }
}

struct ChosenView: View {
    var selectedSide: LibraryType
    
    var body: some View {
        switch selectedSide {
            case .myTicket:
                TicketListView(ticketList: "myTicketList")
            case .saved:
                TicketListView(ticketList: "savedTicketList")
        }
    }
}

struct MyPageView: View {
    @State private var selectedSide: LibraryType = .myTicket
    
    var body: some View {
        NavigationView {
            VStack {
                Picker("Choose a Side", selection: $selectedSide) {
                    ForEach(LibraryType.allCases, id: \.self) {
                        Text($0.rawValue)
                    }
                }
                .pickerStyle(SegmentedPickerStyle())
                .padding()
                
                ChosenView(selectedSide: selectedSide)
            }
            .navigationTitle("내 라이브러리")
            .background(Color(red: 248/255, green: 248/255, blue: 248/255).edgesIgnoringSafeArea(.all))
        }
    }
}

struct MyPageView_Previews: PreviewProvider {
    static var previews: some View {
        MyPageView()
    }
}
