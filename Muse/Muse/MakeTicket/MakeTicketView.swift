//
//  MakeTicketView.swift
//  Muse
//
//  Created by Admin on 2022/06/10.
//

import SwiftUI
import FirebaseAuth
//import Foundation

class TicketWritingViewModel: ObservableObject, Identifiable {
    @Published var trackName: String = ""
    @Published var artistName: String = ""
    @Published var musicId : Int = 0
    @Published var comment: String = ""
    @Published var artworkUrl : String = ""
    @Published var artwork : Image? = nil
    @Published var writer: String = ""
    @Published var downloadNum: Int = 0
    
    init() {}
    
    init(data: [String: Any]) {
            self.trackName = data["trackName"] as? String ?? "ErrorTitle"
            self.artistName = data["artistName"] as? String ?? "Errorartist"
            self.artworkUrl = data["artworkUrl"] as? String ?? "ErrorartWork"
            self.musicId = data["musicId"] as? Int ?? 0
            self.downloadNum = data["downloadNum"] as? Int ?? 0
            self.comment = data["comment"] as? String ?? "ErrorComment"
            //data안에 title/document가 있으면 string으로 인식 하고 아닐 경우 에러메시지를 띄워주세용
    }

}

struct MakeTicketView: View {
    
    //    @Environment(\.presentationMode) var presenationMode
    
    @ObservedObject var viewModel = TicketWritingViewModel()
    @State var searchText = ""
    
    @State private var isbuttonActivated = false
    // 버튼 활성화 여부 저장할 변수
    @State var isShowMusicSearchView = false
    
    @Binding var isShowMakeTicketView: Bool
    
    var body: some View {
        ZStack {
            Color.bgGrey.ignoresSafeArea()
            VStack(spacing: 0) {
                
                ZStack {
                    
                    Image("machine")
                        .resizable()
                        .scaledToFit()
                    Image("ticket")
                        .resizable()
                        .scaledToFit()
                        .padding(.all, 32)
                    
                    VStack {
                        Text("Song")
                            .font(.subheadline)
                            .foregroundColor(.customGrey)
                            .padding(.bottom, 4.5)
                            .frame(width: 246, alignment: .leading)
                        
                        //Search Bar
                        NavigationLink {
                            MusicSearchView(
                                songListViewModel: SongListViewModel(),
                                ticketWritingViewModel: viewModel
                            )
                        } label: {
                            ZStack {
                                Rectangle()
                                    .foregroundColor(.white)
                                    .frame(height:30)
                                HStack {
                                    Image(systemName: "magnifyingglass")
                                        .foregroundColor(.customGrey)
                                    Text("제목, 가수를 입력해 보세요")
                                        .font(.subheadline)
                                        .multilineTextAlignment(.center)
                                        .foregroundColor(.customGrey)
                                    
                                }
                            }
                            .padding()
                            
                        }
                        .background(.white)
                        .frame(width: 246, height: 30)
                        .cornerRadius(10)
                        .shadow(color: Color(red: 237/255, green: 237/255, blue: 237/255), radius: 2, x: 0, y: 2)
                        
                        HStack(){
                            ArtworkView(image: viewModel.artwork)
                                .padding(.trailing)
                            VStack(alignment: .leading) {
                                Text(viewModel.trackName)
                                Text(viewModel.artistName)
                                    .font(.footnote)
                                    .foregroundColor(.gray)
                                //                                Text(String(viewModel.id ?? 0))
                            }
                            Spacer()
                        }
                        .padding()
                        
                        
                        
                        Text("Comment")
                            .font(.subheadline)
                            .foregroundColor(.customGrey)
                            .padding(.bottom, 4.5)
                            .frame(width: 246, alignment: .leading)
                        
                        //textField는 줄바꿈 불가
                        //TextEditor : 스크롤 가능한 여러 줄의 텍스트 표시, 편집 가능
                        ZStack (alignment: .topLeading){
                            // placeholder : TextEditor는 placeholder 기능 없어서 만듦.
                            Rectangle()
                                .foregroundColor(.white)
                            if self.viewModel.comment.isEmpty {
                                Text("곡에 대한 코멘트를 입력해주세요")
                                    .font(.subheadline)
                                    .foregroundColor(.customGrey)
                                    .padding(13)
                                    .onTapGesture {
                                        isbuttonActivated = true
                                    }
                            }
                            TextEditor(text: $viewModel.comment)
                                .font(.subheadline)
                                .opacity(self.viewModel.comment.isEmpty ? 0.4 : 1)
                                .lineSpacing(3)
                                .padding(6)
                                .disableAutocorrection(true)
                        }
                        .frame(width: 246, height: 160)
                        .cornerRadius(10)
                        .shadow(color: Color(red: 237/255, green: 237/255, blue: 237/255), radius: 2, x: 0, y: 2)
                        Spacer()
                    }
                    .padding(.top, 5)
                    .frame(width: 286, height: 451)
                }
                .padding(.top, 27)
                .padding(.horizontal)
                
                Button(action: {
                    let currentUser = Auth.auth().currentUser
                    
                    let document = FirebaseManager.shared.firestore
                        .collection("tracks")
                        .document() //firebase에 있는 track이 document부분!
                    
                    let data = ["trackName": viewModel.trackName,
                                "artistName": viewModel.artistName,
                                "artworkUrl": viewModel.artworkUrl,
                                "comment": viewModel.comment,
                                "writer" : currentUser?.uid ?? "",
                                "musicId": viewModel.musicId,
                                "downloadNum": viewModel.downloadNum] as [String : Any]
                    
                    document.setData(data) //firebase에 보내는작업
                    
                    print("작성 완료다잉")
                    isShowMakeTicketView.toggle()
                    //                    presenationMode.wrappedValue.dismiss()
                    
                }, label: {
                    ZStack {
                        // 버튼 활성화 조건문 구현
                        if (isbuttonActivated == false){
                            RoundedRectangle(cornerRadius: 20)
                                .foregroundColor(Color.gray)
                        }
                        else {
                            RoundedRectangle(cornerRadius: 20)
                                .foregroundColor(Color.customPink)
                        }
                        
                        HStack {
                            Image("ticket icon")
                            Text("작성 완료")
                                .font(.title3.bold())
                                .foregroundColor(.white)
                        }
                    }
                    .frame(width: 350, height: 56)
                })
                .padding()
                .disabled(isbuttonActivated == false)
                // button default : 비활성화
            }
        }
        .navigationBarTitleDisplayMode(.inline)
        .navigationTitle("티켓 제작")
    }
}

struct MakeTicketViewPreviewsContainer: View {
    @State private var isShow: Bool = false
    
    var body: some View {
        MakeTicketView(isShowMakeTicketView: $isShow)
    }
}

struct MakeTicketView_Previews: PreviewProvider {
    static var previews: some View {
        MakeTicketViewPreviewsContainer()
    }
}
