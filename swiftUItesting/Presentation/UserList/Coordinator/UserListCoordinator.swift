//
//  UserListCoordinator.swift
//  swiftUItesting
//
//  Created by vlad.kosyi on 22.02.2024.
//

import Foundation
import Combine
import Swinject

protocol UserListCoordinatorDelegate: AnyObject {
  func userListCoordinatorCoordinatorDidComplete(_ source: UserListCoordinator)
}

@Observable
class UserListCoordinator: ViewModel {
    private let resolver: Resolver
    private weak var delegate: UserListCoordinatorDelegate?

    let path = ObjectNavigationPath()

    private(set) var rootContentViewModel: UserListViewModel!

    init(resolver: Resolver) {
        self.resolver = resolver
    }

    func setup(delegate: UserListCoordinatorDelegate) -> Self {
        self.delegate = delegate
        self.rootContentViewModel = self.resolver.resolve(UserListViewModel.self)!
          .setup(delegate: self)
        return self
    }
}

extension UserListCoordinator: UserListViewDelegate {

    func userListViewModelDidOnLogout() {
        self.delegate?.userListCoordinatorCoordinatorDidComplete(self)
    }
    
    func userListViewModelDidOndetails(_ user: GitUser) {
        self.path.append(self.resolver.resolve(UserDetailViewModel.self)!
            .setup(user: user))
    }
}
