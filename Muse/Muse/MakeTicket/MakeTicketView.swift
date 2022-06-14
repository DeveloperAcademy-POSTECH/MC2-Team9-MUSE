//
//  MakeTicketView.swift
//  Muse
//
//  Created by Admin on 2022/06/10.
//

import SwiftUI

class TicketWritingViewModel: ObservableObject {
    @Published var trackName: String? = nil
    @Published var artistName: String? = nil
    @Published var id : Int? = nil
    //앨범 불러오기
    @Published var artwork : Image? = nil
}

struct MakeTicketView: View {
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var viewModel = TicketWritingViewModel()
    @State var searchText = ""
    @State var comment: String = ""
    
    @State private var isbuttonActivated = false
    // 버튼 활성화 여부 저장할 변수
    
    var body: some View {
        ZStack {
            Color.bgGrey.ignoresSafeArea()
            VStack(spacing: 0) {
                Text("나만의 음악 티켓을 만들어 보세요.")
                    .font(.title2.bold())
                    .padding(.all, 22)
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
                                        .multilineTextAlignment(.center)
                                        .foregroundColor(.customGrey)
                                    //                                    TextField("제목, 가수 등", text: $searchText)
                                    //                                        .disableAutocorrection(true)
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
                                Text(viewModel.trackName ?? "")
                                Text(viewModel.artistName ?? "")
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
                            if self.comment.isEmpty {
                                Text("곡에 대한 코멘트를 입력해주세요")
                                    .font(.subheadline)
                                    .foregroundColor(.customGrey)
                                    .padding(13)
                                    .onTapGesture {
                                        isbuttonActivated = true
                                    }
                            }
                            TextEditor(text: $comment)
                                .font(.subheadline)
                                .opacity(self.comment.isEmpty ? 0.4 : 1)
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
                .padding(.horizontal)
                
                HStack(alignment: .center, spacing: 20) {
                    Button(action: {
                        self.presentationMode.wrappedValue.dismiss()
                    }, label: {
                        ZStack {
                            RoundedRectangle(cornerRadius: 20)
                                .fill(Color.red)
                            HStack(spacing: 5) {
                                Image(systemName: "x.square")
                                Text("작성 취소")
                            }
                            .font(.custom("Apple SD Gothic Neo SemiBold",size:17,relativeTo: .title))
                            .foregroundColor(Color.white)
                            .padding()
                        }
                    })
                    .frame(width: 165, height: 56)
                    
                    Button(action: {
                        //작성 후 저장하는 코드를 짜야하는데 알려주세용
                        print("작성 완료다잉")
                    }, label: {
                        ZStack {
                            // 버튼 활성화 조건문 구현
                            if (isbuttonActivated == false){
                                RoundedRectangle(cornerRadius: 20)
                                    .fill(Color.gray)
                            }
                            else {
                                RoundedRectangle(cornerRadius: 20)
                                    .fill(Color.customPink)
                            }
                            
                            HStack(spacing: 5) {
                                Image("ticket icon")
                                Text("작성 완료")
                            }
                            .font(.custom("Apple SD Gothic Neo SemiBold",size:17,relativeTo: .title))
                            .foregroundColor(Color.white)
                            .padding()
                        }
                    })
                    .disabled(isbuttonActivated == false) // button default : 비활성화
                    .frame(width: 165, height: 56)
                }
                .padding()
            }
        }
        .navigationBarHidden(true)
        .navigationTitle("티켓 만들기")
    }
}

struct MakeTicketView_Previews: PreviewProvider {
    static var previews: some View {
        MakeTicketView(searchText: "", comment: "")
    }
}
