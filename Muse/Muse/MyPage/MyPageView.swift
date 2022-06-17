//
//  MypageView.swift
//  Muse
//
//  Created by Admin on 2022/06/10.
//

import SwiftUI
import FirebaseAuth
import Firebase
import FirebaseDatabase

enum LibraryType: String, CaseIterable {
    case myTicket = "저장한 티켓"
    case saved = "나의 음악 티켓"
}

// 선택된 segmentedPicker에 따라 TicketListView 표시
struct ChosenView: View {
    var selectedSide: LibraryType
    @Binding var saved: [TicketWritingViewModel]
    @Binding var wrote: [TicketWritingViewModel]
    
    var body: some View {
        switch selectedSide {
        case .myTicket:
            TicketListView(isMyTicket: true, tickets: $saved)
        case .saved:
            TicketListView(isMyTicket: false, tickets: $wrote)
        }
    }
}

struct MyPageView: View {
    @State var isShowMakeTicketView = false
    
    @EnvironmentObject var service: SessionServiceImpl
    @State private var selectedSide: LibraryType = .myTicket
    
    @State var savedTickets: [TicketWritingViewModel] = []
    @State var wroteTickets: [TicketWritingViewModel] = []
    
    var body: some View {
        VStack(spacing: 0) {
            // Header
            HStack {
                Text("내 라이브러리")
                    .font(.title)
                    .fontWeight(.bold)
                //                Text(service.userDetails.)
                Spacer()
                Button(action: {
                    service.logout()
                }) {
                    Image(systemName: "rectangle.portrait.and.arrow.right")
                        .font(.title2.bold())
                }
                
                NavigationLink(destination: MakeTicketView(isShowMakeTicketView: $isShowMakeTicketView), isActive: self.$isShowMakeTicketView) {
                    
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
            
            ChosenView(selectedSide: selectedSide, saved: $savedTickets, wrote: $wroteTickets)
        }
        .navigationBarHidden(true)
        .navigationTitle("내 라이브러리")
        .background(Color.bgGrey.edgesIgnoringSafeArea(.all))
        .onAppear {
            wroteTickets.removeAll()
            savedTickets.removeAll()
            let uid = Auth.auth().currentUser?.uid
            print(uid!)
            
            FirebaseManager.shared.firestore
                .collection("tracks") //식별자인 title을 불러 온다.
                .addSnapshotListener { snapshot, error in // Fire base just let me do this!
                    guard let snapshot = snapshot else { return }
                    
                    snapshot.documents.forEach { document in // Fire base just let me do this!
                        let song = TicketWritingViewModel(data: document.data())
  
                        if uid == song.writer {
                            wroteTickets.append(song)
                        }
                        if (service.userDetails?.saveTrack.contains(String(song.musicId))) ?? true {
                            savedTickets.append(song)
                        }
                    }
                    print("ticket1")
                    print(savedTickets)
                    print("ticket2")
                    print(wroteTickets)
                }
        }
    }
}

struct MyPageView_Previews: PreviewProvider {
    static var previews: some View {
        MyPageView()
    }
}
