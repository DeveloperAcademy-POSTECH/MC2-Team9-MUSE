//
//  TicketListView.swift
//  Muse
//
//  Created by Admin on 2022/06/13.
//

import SwiftUI

struct TicketListView: View {
    var ticketList: String
    
    var body: some View {
        ScrollView {
            VStack(spacing: -20) {
                Spacer() // 리스트 거꾸로 돌리려고..
                    .frame(minWidth: 0, maxWidth: .infinity, minHeight:0, maxHeight: .infinity, alignment: Alignment.topLeading)
                ForEach(0..<5) { number in
                    // 카드 리스트 Vstack
                    VStack (alignment: .center, spacing: 10) {
                        // 카드 내 Content HStack
                        HStack (spacing: 5) {
                            // 곡 제목 - 가수 VStack
                            VStack(alignment: .leading, spacing: 0) {
                                Text(ticketList)
                                    .font(.title2)
                                    .fontWeight(.bold)
                                    .multilineTextAlignment(.leading)
                                    .lineLimit(1)
                                Text("이소라")
                                    .font(.callout)
                                    .multilineTextAlignment(.leading)
                                    .lineLimit(1)
                                    .padding(.top, 3)
                            }
                            Spacer()
                            // 조건문으로 받아오는 데이터 타입에 따라(저장한 티켓에서는) 아래 내용 표시 X
                            Image(systemName: "square.and.arrow.down")
                            Text("22")
                        }
                        .padding(.top)
                        .padding(.horizontal, 20)
                    }
                    .frame(width: 350, height: 100, alignment: .top)
                    .background(Color.white)
                    .cornerRadius(15)
                    .shadow(color: .gray.opacity(0.5), radius: 5)
                }
            }
            .padding(.top, 10)
            .padding(.bottom, -20)
            .frame(maxWidth: .infinity)
            .rotationEffect(Angle(degrees: 180)) // 리스트 거꾸로 돌릴려고..
        }
        .rotationEffect(Angle(degrees: 180)) // 리스트 거꾸로 돌릴려고..
    }
}

struct TicketListView_Previews: PreviewProvider {
    static var previews: some View {
        TicketListView(ticketList: "That That")
    }
}
