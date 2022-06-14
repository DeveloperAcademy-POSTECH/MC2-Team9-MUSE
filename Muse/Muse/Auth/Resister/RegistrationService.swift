//
//  RegistrationModel.swift
//  Muse
//
//  Created by kelly on 2022/06/14.
//

import Combine
import Foundation
import Firebase
import FirebaseDatabase

struct RegistrationCredentials {
    
    var email: String
    var password: String
    var nickName: String
    var saveTrack: [String]
}

extension RegistrationCredentials {
    static var new: RegistrationCredentials {
        RegistrationCredentials(email: "",
                                password: "",
                                nickName: "",
                                saveTrack: [])
    }
}

protocol RegistrationService {
    func register (with credentials: RegistrationCredentials) -> AnyPublisher<Void, Error> // 에러를 피하기 위함, Subscribe를 위해 퍼블리셔 반환, 성공-> Void, 실패 -> Error
}

enum RegistrationKeys: String {
    case nickName
    case saveTrack
}

final class RegistrationServiceImpl: RegistrationService { // final 선언 이유, 이 클래스를 상속하는 다른 클래스를 막으려고
    
    func register(with credentials: RegistrationCredentials) -> AnyPublisher<Void, Error> {
        
        Deferred {
            
            Future { promise in
                
                Auth.auth().createUser(withEmail: credentials.email,
                                       password: credentials.password) { res, error in
                    
                    if let err = error {
                        promise(.failure(err))
                    } else {
                        
                        if let uid = res?.user.uid {
                            
                            let values = [RegistrationKeys.nickName.rawValue: credentials.nickName,
                                          RegistrationKeys.saveTrack.rawValue: credentials.saveTrack] as [String : Any]
                            
                            print("register values")
                            print(credentials.email)
                            print(values)
                            
                            Database
                                .database()
                                .reference()
                                .child("users")
                                .child(uid)
                                .updateChildValues(values) { error, ref in
                                    
                                    if let err = error {
                                        promise(.failure(err))
                                    } else {
                                        promise(.success(()))
                                    }
                                }
                        }
                    }
                }
            }
        }
        .receive(on: RunLoop.main) // Main 스레드에서 생성한 퍼블리셔 받기
        .eraseToAnyPublisher() // 수없이 많은 프로퍼티 래퍼가 들어갔기 때문에 복잡한 타입 형식을 기봊거인 퍼블리셔로 반환 (subscriber가 받게 될 결과값만이 중요)
    }
}
