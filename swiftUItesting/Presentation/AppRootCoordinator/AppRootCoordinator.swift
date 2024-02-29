//
//  AppRootCoordinator.swift
//  swiftUItesting
//
//  Created by vlad.kosyi on 22.02.2024.
//

import Foundation
import Combine
import Swinject

@Observable
class AppRootCoordinator: ViewModel {
    
    private let resolver: Resolver

    private(set) var loginViewModel: LoginViewModel!
    var userListCoordinator: UserListCoordinator?

    let path = ObjectNavigationPath()

    init(resolver: Resolver) {
        self.resolver = resolver

        self.loginViewModel = self.resolver.resolve(LoginViewModel.self)!
            .setup(delegate: self)
    }
}

extension AppRootCoordinator: LoginViewModelDelegate {

    func signInViewModelDidSignIn(_ source: LoginViewModel) {
        self.userListCoordinator = self.resolver.resolve(UserListCoordinator.self)!
          .setup(delegate: self)
    }
}

extension AppRootCoordinator: UserListCoordinatorDelegate {

    func userListCoordinatorCoordinatorDidComplete(_ source: UserListCoordinator) {
        self.userListCoordinator = nil
    }
}
