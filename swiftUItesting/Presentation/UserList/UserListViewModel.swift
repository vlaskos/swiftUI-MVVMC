//
//  UserListViewModel.swift
//  swiftUItesting
//
//  Created by vlad.kosyi on 22.02.2024.
//

import Foundation
import Combine
import CombineExt

protocol UserListViewDelegate: AnyObject {
    func userListViewModelDidOndetails(_ user: GitUser)
    func userListViewModelDidOnLogout()
}

@Observable
class UserListViewModel: ViewModel, ObservableObject {
    private weak var delegate: UserListViewDelegate?
    private let authenticationService: AuthenticationServiceable
    private let userService: UserServiceable
    private var cancelBag: CancelBag!
    let onDetail: PassthroughSubject<GitUser?, Never> = PassthroughSubject()
    let onLogout: PassthroughSubject<Void, Never> = PassthroughSubject()

    var users: [GitUser] = []

    init(authenticationService: AuthenticationServiceable, userService: UserServiceable) {
        self.authenticationService = authenticationService
        self.userService = userService
    }

    func setup(delegate: UserListViewDelegate) -> Self {
      self.delegate = delegate
      bind()
      return self
    }

    private func bind() {
        self.cancelBag = CancelBag()

        self.onDetail
            .sink { [weak self] user in
                guard let self = self, let user = user else { return }
                self.delegate?.userListViewModelDidOndetails(user)
            }
            .store(in: &self.cancelBag)

        self.onLogout
            .setFailureType(to: Error.self)
            .flatMapLatest { _ -> AnyPublisher<Void, Error> in
                self.authenticationService.signOut()
            }
            .sink { [weak self] in
                guard let self = self else { return }
                self.delegate?.userListViewModelDidOnLogout()
            }
            .store(in: &self.cancelBag)
    }

    func fetchUsers() async {
        let result = await userService.getUsers()
        switch result {
        case .success(let users):
            self.users = users
        case .failure(let error):
            print(error)
        }
    }
}
