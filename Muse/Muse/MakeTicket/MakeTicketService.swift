//
//  MakeTicketService.swift
//  Muse
//
//  Created by kelly on 2022/06/15.
//

import Combine
import Foundation
import Firebase
import FirebaseAuth
import FirebaseDatabase

struct MuseTicket {
    var id: UUID
    var trackName: String
    var artist: String
    var artworkUrl: String
    var comment: String
    var writer: String
    var dowmloadNum: Int
}

//extension MuseTicket {
//    static var new: MuseTicket {
//        MuseTicket(id: UUID(),
//                   trackName: "",
//                   artist: "",
//                   artworkUrl: "",
//                   comment: "",
//                   writer: "",
//                   dowmloadNum: 0)
//    }
//}

protocol MakeTicketService {
    func makeTicket (with ticket: MuseTicket) -> AnyPublisher<Void, Error> // 에러를 피하기 위함, Subscribe를 위해 퍼블리셔 반환, 성공-> Void, 실패 -> Error
}

enum TicketKeys: String {
    case trackName
    case artist
    case artworkUrl
    case comment
    case writer
    case downloadNum
}

final class MakeTicketServiceImpl: MakeTicketService { // final 선언 이유, 이 클래스를 상속하는 다른 클래스를 막으려고
    
    func makeTicket(with ticket: MuseTicket) -> AnyPublisher<Void, Error> {
        
        Deferred {
            
            Future { promise in

                let currentUser = Auth.auth().currentUser
                let values = [TicketKeys.trackName.rawValue: ticket.trackName,
                                  TicketKeys.artist.rawValue: ticket.artist,
                                  TicketKeys.artworkUrl.rawValue: ticket.artworkUrl,
                              TicketKeys.comment.rawValue: ticket.comment,
                              TicketKeys.writer.rawValue: currentUser?.uid ?? "",
                                  TicketKeys.downloadNum.rawValue: ticket.dowmloadNum] as [String : Any]

                print("valuse print")
                print(values)
                Database
                    .database()
                    .reference()
                    .child("tickets")
                    .childByAutoId()
                    .updateChildValues(values) { error, ref in

                        if let err = error {
                            promise(.failure(err))
                        } else {
                            promise(.success(()))
                        }
                    }
//                if let uid = currentUser?.uid { // 현재 유저 있으면 아이디 받기
                    

                    
//                    Database
//                        .database()
//                        .reference()
//                        .child("tickets")
//                        .child(uid)
//                        .observe(.value) { [weak self] snapshot in // user -> uid (현재 유저 id)에 해당하는 값 불러오기
//
//                            guard let self = self,
//                                  let value = snapshot.value as? NSDictionary, // snapshot 값 저장
//                                  let nickName = value[RegistrationKeys.nickName.rawValue] as? String, // 파베에서 불러온 값을 변수에 저장
//                                  let saveTrack = value[RegistrationKeys.saveTrack.rawValue] as? [String] else {
//                                return
//                            }
//
//                            DispatchQueue.main.async {
//                                self.userDetails = UserSessionDetails(nickName: nickName,  // 현재 로그인된 유저의 정보 업데이트
//                                                                      saveTrack: saveTrack)
//                            }
//                        }
//                }
                
            }
        }
        .receive(on: RunLoop.main) // Main 스레드에서 생성한 퍼블리셔 받기
        .eraseToAnyPublisher() // 수없이 많은 프로퍼티 래퍼가 들어갔기 때문에 복잡한 타입 형식을 기봊거인 퍼블리셔로 반환 (subscriber가 받게 될 결과값만이 중요)
    }
}
