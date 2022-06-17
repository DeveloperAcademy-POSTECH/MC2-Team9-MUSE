//
//  MainView.swift
//  Muse
//
//  Created by Admin on 2022/06/10.
//

import SwiftUI
import FirebaseAuth

struct MainView: View {
    let screenSize: CGSize = UIScreen.main.bounds.size

    @EnvironmentObject var service: SessionServiceImpl
    @State var randomSong = TicketWritingViewModel()
    @State var offset: CGFloat = 0.0
    @State var isSaveActivated = false
    @State var isNewActivated = true
    
    private let artworkLoader: ArtworkLoader = ArtworkLoader()
    
    var body: some View {
        ZStack {
            Color.bgGrey.edgesIgnoringSafeArea(.all)
            VStack (spacing: 0){
                
                Spacer()
                
                HStack(alignment: .center, spacing: 20) {
                    
                    Button(action: {
//
                        let currentUser = Auth.auth().currentUser
                        withAnimation {
                            offset -= 500
                        }
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5){
                            FirebaseManager.shared.firestore
                                .collection("tracks")
                                .document(String(randomSong.musicId))
                                .updateData(["downloadNum" : randomSong.downloadNum + 1])
                        }
                        print(service.userDetails?.saveTrack)
                            service.userDetails?.saveTrack.append(String(randomSong.musicId))
                        
                        print(service.userDetails?.saveTrack)
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5){
                            FirebaseManager.shared.firestore
                                .collection("users")
                                .document(currentUser!.uid)
                                .updateData(["saveTrack" : service.userDetails?.saveTrack])
                        }
                        
                        isSaveActivated = false
                        
                    }, label: {
                        ZStack {
                            Capsule()
                                .fill(Color.customGrey)
                                .frame(width: 160, height: 54)
                            HStack(spacing: 5) {
                                Image(systemName: "square.and.arrow.down")
                                    .padding(.trailing, 3)
                                    .offset(y: -2)
                                Text("티켓 저장")
                            }
                            .font(.custom("Apple SD Gothic Neo SemiBold",size:17,relativeTo: .title))
                            .foregroundColor(Color.white)
                            .padding()
                        }
                        .padding(.leading, 7)
                        .padding(.top, 5)
                    })
                    .disabled(isSaveActivated == false)
                    .frame(width: 165, height: 56)
                    
                    Button(action: {
                        isNewActivated = false
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                            FirebaseManager.shared.firestore
                                .collection("tracks") //식별자인 title을 불러 온다.
                                .addSnapshotListener { snapshot, error in // Fire base just let me do this!
                                    guard let snapshot = snapshot else { return }

                                    self.randomSong = snapshot.documents.map { document in
                                        return TicketWritingViewModel(data: document.data())
                                    }.randomElement()!
                                    
                                    self.artworkLoader.loadArtwork(forSong: randomSong.artworkUrl ) { image in
                                            print("in")
                                            print(randomSong.artworkUrl)
                                            randomSong.artwork = image
                                    }
                                }
                            
                            DispatchQueue.main.asyncAfter(deadline: .now() + 1){
                                if (service.userDetails?.saveTrack.contains(String(randomSong.musicId))) ?? true {
                                    isSaveActivated = false
                                } else {
                                    isSaveActivated = true
                                }
                                isNewActivated = true
                            }
                            
                        }
                        
                        // 랜덤한 새로운 티켓을 다시 보여주는 코드를 짜야 합니다.
                        print("새 티켓 뽑기 동작")

                        if offset == 500 {
                            withAnimation {
                                offset -= 500
                            }
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.6) {
                                withAnimation {
                                    offset += 500
                                }
                            }
                            
                        } else {
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.8) {
                                withAnimation {
                                    offset += 500
                                }
                            }
                        }
                        
                    }, label: {
                        ZStack {
                            Capsule()
                                .fill(Color.customPink)
                                .frame(width: 160, height: 54)
                            HStack(spacing: 5) {
                                Image(systemName: "arrow.triangle.2.circlepath")
                                    .padding(.trailing, 3)
                                Text("새 티켓 뽑기")
                            }
                            .font(.custom("Apple SD Gothic Neo SemiBold",size:17,relativeTo: .title))
                            .foregroundColor(Color.white)
                            .padding()
                        }
                        .padding(.trailing, 7)
                        .padding(.top, 5)
                    })
                    .disabled(isNewActivated == false)
                    .frame(width: 165, height: 56)
                }
                .foregroundColor(.red)
                .frame(width: 180, height: 70, alignment: .center)
                .padding()
            }
            
            Ticket(randomSong: randomSong, offset: $offset)

        }
        .navigationBarHidden(true)
    }
}
//
struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
