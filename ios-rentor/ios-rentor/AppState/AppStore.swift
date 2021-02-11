//
//  AppStore.swift
//  ios-rentor
//
//  Created by Thomas on 11/02/2021.
//  Copyright © 2021 Thomas. All rights reserved.
//

import Foundation
import Combine

typealias Middleware<State, Action> = (State, Action) -> AnyPublisher<Action, Never>?
typealias AppStore = Store<AppState, AppAction>

final class Store<State, Action>: ObservableObject {
    @Published private(set) var state: State
    
    var tasks = [AnyCancellable]()
    let serialQueue = DispatchQueue(label: "redux.serial.queue")
    let middlewares: [Middleware<State, Action>]
    
    private let reducer: Reducer<State, Action>
    private var middlewareDisposables: Set<AnyCancellable> = []
    
    init(initialState: State,
         reducer: @escaping Reducer<State, Action>,
         middlewares: [Middleware<State, Action>] = []) {
        self.state = initialState
        self.reducer = reducer
        self.middlewares = middlewares
    }
    
    func dispatch(_ action: Action) {
        reducer(&state, action)
        
        for mw in middlewares {
            guard let middleware = mw(state, action) else {
                break
            }
            middleware.receive(on: DispatchQueue.main)
                .sink(receiveValue: dispatch)
                .store(in: &self.middlewareDisposables)
        }
    }
    
}
