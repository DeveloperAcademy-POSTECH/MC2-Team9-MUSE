//
//  MakeTicketView.swift
//  Muse
//
//  Created by Admin on 2022/06/10.
//

import SwiftUI

struct MakeTicketView: View {
    @State var searchText = ""
    @State var comment: String
    
    var body: some View {
        ZStack {
            Color.bgGrey.ignoresSafeArea()
            VStack {
                Text("나만의 음악 티켓을 만들어 보세요.")
                    .font(.title2.bold())
                    .padding(.bottom)
                ZStack {
                    Image("machine")
                    Image("ticket")
                    VStack {
                        Text("Song")
                            .font(.subheadline)
                            .foregroundColor(.customGrey)
                            .padding(.bottom, 4.5)
                            .frame(width: 246, alignment: .leading)
                        
                        //Search Bar
                        ZStack {
                            Rectangle()
                                .foregroundColor(.white)
                            HStack {
                                Image(systemName: "magnifyingglass")
                                    .foregroundColor(.customGrey)
                                TextField("제목, 가수 등", text: $searchText)
                                    .disableAutocorrection(true)
                            }
                            .padding(.leading, 7)
                            
                        }
                        .background(.white)
                        .frame(width: 246, height: 44)
                        .cornerRadius(10)
                        .shadow(color: Color(red: 237/255, green: 237/255, blue: 237/255), radius: 2, x: 0, y: 2)
                        
                        Divider().padding()
                        
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
                    .frame(width: 286, height: 451)
                }
                
                
                Button(action: {
                    print("작성 완료다잉")
                    //작성 후 저장하는 코드를 짜야하는데 알려주세용
                }, label: {
                    ZStack {
                        RoundedRectangle(cornerRadius: 20)
                            .foregroundColor(.customPink)
                        HStack {
                            Image("ticket icon")
                            Text("작성 완료")
                                .font(.title3.bold())
                                .foregroundColor(.white)
                        }
                    }
                    .frame(width: 350, height: 56)
                })
            }
        }
    }
}

struct MakeTicketView_Previews: PreviewProvider {
    static var previews: some View {
        MakeTicketView(searchText: "", comment: "")
    }
}
