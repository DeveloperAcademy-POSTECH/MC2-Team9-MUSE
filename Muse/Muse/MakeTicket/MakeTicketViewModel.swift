//
//  MakeTicketViewModel.swift
//  Muse
//
//  Created by kelly on 2022/06/15.
//

import Foundation
import Combine

enum MakeTicketState {
    case successfullyMake
    case failed(error: Error)
    case na
}

protocol MakeTicketViewModel {
    func create()
    var service: MakeTicketService { get }
    var state: MakeTicketState { get }
    var hasError: Bool { get }
    var ticket: MuseTicket { get }
    init(service: MakeTicketService)
}

final class MakeTicketViewModelImpl: ObservableObject, MakeTicketViewModel {
    
    let service: MakeTicketService
    @Published var state: MakeTicketState = .na
    @Published var ticket = MuseTicket(id: UUID(),
                                       trackName: "",
                                       artist: "",
                                       artworkUrl: "",
                                       comment: "",
                                       writer: "",
                                       dowmloadNum: 0)
    
    @Published var hasError: Bool = false
    
    private var subscriptions = Set<AnyCancellable>()
    
    init(service: MakeTicketService) {
        self.service = service
        setupErrorSubscription()
    }
    
    func create() {
        service
            .makeTicket(with: ticket)
            .sink { [weak self] res in
                
                switch res {
                case .failure(let error):
                    self?.state = .failed(error: error)
                default: break
                }
            } receiveValue: { [weak self] in
                self?.state = .successfullyMake
            }
            .store(in: &subscriptions)
    }
}

private extension MakeTicketViewModelImpl {
    
    func setupErrorSubscription() {
        $state
            .map { state -> Bool in
                switch state {
                case .successfullyMake,
                        .na:
                    return false
                case .failed:
                    return true
                }
            }
            .assign(to: &$hasError)
    }
}
