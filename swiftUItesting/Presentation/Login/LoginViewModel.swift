//
//  LoginViewModel.swift
//  swiftUItesting
//
//  Created by vlad.kosyi on 22.02.2024.
//

import Foundation
import Combine
import CombineExt

protocol LoginViewModelDelegate: AnyObject {
  func signInViewModelDidSignIn(_ source: LoginViewModel)
}

@Observable
class LoginViewModel: ViewModel {
    private let authenticationService: AuthenticationServiceable
    private weak var delegate: LoginViewModelDelegate?
    private(set) var canSignIn: AnyPublisher<Bool, Never>!

    var username: String = .empty {
      didSet { self.username$.send(self.username) }
    }

    var password: String = .empty {
      didSet { self.password$.send(self.password) }
    }

    private let username$: CurrentValueSubject<String, Never> = CurrentValueSubject(.empty)
    private let password$: CurrentValueSubject<String, Never> = CurrentValueSubject(.empty)

    let login: PassthroughSubject<Void, Never> = PassthroughSubject()

    private var cancelBag: CancelBag!

    init(authenticationService: AuthenticationServiceable) {
        self.authenticationService = authenticationService
        self.cancelBag = CancelBag()

        self.canSignIn = [
          self.username$,
          self.password$,
        ].combineLatest()
            .map {
              $0.allSatisfy { !$0.isEmpty }
            }
            .eraseToAnyPublisher()
    }

    func setup(delegate: LoginViewModelDelegate) -> Self {
        self.delegate = delegate
        bind()
        return self
    }

    func bind() {
        self.login
            .withLatestFrom(self.username$, self.password$)
            .setFailureType(to: Error.self)
            .flatMapLatest { username, password -> AnyPublisher<User, Error> in
                self.authenticationService.signIn(username: username, password: password)
            }
            .sink(receiveValue: { [weak self] user in
                guard let self = self else { return }
                self.delegate?.signInViewModelDidSignIn(self)
            })
            .store(in: &self.cancelBag)
    }
}
