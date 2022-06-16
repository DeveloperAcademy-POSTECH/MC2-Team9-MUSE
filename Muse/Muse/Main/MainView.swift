//
//  MainView.swift
//  Muse
//
//  Created by Admin on 2022/06/10.
//

import SwiftUI

struct MainView: View {
    @State var offset: CGFloat = 0.0
    @State var flag: Bool = false
    let screenSize: CGSize = UIScreen.main.bounds.size
    //@State var service = GetRandomTicketServiceImpl()

    @State var randomSong: TicketWritingViewModel?
    @State var offset: CGFloat = 0.0
    
    var body: some View {
        ZStack {
            Color.bgGrey.edgesIgnoringSafeArea(.all)
            VStack (spacing: 0){
                Text("Muse Ticket")
                    .font(.custom("Courier New", size: 34, relativeTo: .title)) //relativeTo : 모든 기기마다 title이 갖는 값을 기준으로 34를 변환 시킨다.
                    .padding()
                
                TicketMachineView()
                
                HStack(alignment: .center, spacing: 20) {
                    Button(action: {
                        //티켓 저장 하는 코드를 짜야합니다.
                        print("티켓 저장 동작")
                    }, label: {
                        ZStack {
                            RoundedRectangle(cornerRadius: 20)
                                .fill(Color.customGrey)
                            HStack(spacing: 5) {
                                Image(systemName: "square.and.arrow.down")
                                Text("티켓 저장")
                            }
                            .font(.custom("Apple SD Gothic Neo SemiBold",size:17,relativeTo: .title))
                            .foregroundColor(Color.white)
                            .padding()
                        }
                    })
                    .frame(width: 165, height: 56)
                    
                    Button(action: {
                        FirebaseManager.shared.firestore
                            .collection("tracks") //식별자인 title을 불러 온다.
                            .addSnapshotListener { snapshot, error in // Fire base just let me do this!
                                guard let snapshot = snapshot else { return }
                                self.randomSong = snapshot.documents.map { document in
                                    return TicketWritingViewModel(data: document.data())
                                }.randomElement()
                                
                                // TicketView 띄우기
                            }
                        
                        // 랜덤한 새로운 티켓을 다시 보여주는 코드를 짜야 합니다.
                        print("새 티켓 뽑기 동작")

                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                            if offset == 500 {
                                withAnimation {
                                    offset -= 500
                                }
                                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {//.milliseconds(1500)) {
                                    withAnimation {
                                        offset += 500
                                    }
                                }
                                
                            } else {
                                withAnimation {
                                    offset += 500
                                }
                            }
                        }
                    }, label: {
                        ZStack {
                            RoundedRectangle(cornerRadius: 20)
                                .fill(Color.customPink)
                            HStack(spacing: 5) {
                                Image(systemName: "arrow.triangle.2.circlepath")
                                Text("새 티켓 뽑기")
                            }
                            .font(.custom("Apple SD Gothic Neo SemiBold",size:17,relativeTo: .title))
                            .foregroundColor(Color.white)
                            .padding()
                            
                        }
                    })
                    .frame(width: 165, height: 56)
                }
                .padding()
            }
            //            Ticket(trackName: $trackName,
            //                   artist: $artist,
            //                   comment: $comment,
            //                   artworkUrl: $artworkUrl)
            Ticket(randomSong: $randomSong, offset: $offset)
        }
        .navigationBarHidden(true)
        .navigationTitle("Muse Ticket")
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
