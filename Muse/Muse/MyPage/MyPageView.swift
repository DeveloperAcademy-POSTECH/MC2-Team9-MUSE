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

// 선택된 segmentedPicker에 따라 TicketListView 표시
struct ChosenView: View {
    var selectedSide: LibraryType
    
    var body: some View {
        switch selectedSide {
            case .myTicket:
            TicketListView(ticketList: "바람이 분다", isMyTicket: true)
            case .saved:
            TicketListView(ticketList: "1월에서 6월까지", isMyTicket: false)
        }
    }
}

struct MyPageView: View {

    @EnvironmentObject var service: SessionServiceImpl
    @State private var selectedSide: LibraryType = .myTicket
    
    var body: some View {
        VStack(spacing: 0) {
            // Header
            HStack {
                Text("내 라이브러리")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                Spacer()
                Button(action: {
                    service.logout()
                }) {
                    Image(systemName: "rectangle.portrait.and.arrow.right")
                        .font(.title)
                }
                NavigationLink(destination: MakeTicketView()) {
                    Image(systemName: "square.and.pencil")
                        .font(.title)
                }
            }
            .padding(.top)
            .padding(.bottom, 10)
            .padding(.horizontal)
            // Picker
            Picker("Choose a Side", selection: $selectedSide) {
                ForEach(LibraryType.allCases, id: \.self) {
                    Text($0.rawValue)
                }
            }
            .pickerStyle(SegmentedPickerStyle())
            .padding()
            
            ChosenView(selectedSide: selectedSide)
        }
        .navigationBarHidden(true)
        .navigationTitle("내 라이브러리")
        .background(Color.bgGrey.edgesIgnoringSafeArea(.all))
    }
}

struct MyPageView_Previews: PreviewProvider {
    static var previews: some View {
        MyPageView()
    }
}
