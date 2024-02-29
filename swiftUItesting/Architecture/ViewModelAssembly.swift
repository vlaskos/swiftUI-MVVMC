//
//  ViewModelAssembly.swift
//  MVVM.Demo.SwiftUI
//
//  Created by Jason Lew-Rapai on 11/15/21.
//

import Foundation
import Swinject

class ViewModelAssembly: Assembly {
  func assemble(container: Container) {
      container.register(LoginViewModel.self) { r in
          LoginViewModel(
            authenticationService: r.resolve(AuthenticationServiceable.self)!)
      }.inObjectScope(.transient)

      container.register(UserListViewModel.self) { r in
          UserListViewModel(authenticationService: r.resolve(AuthenticationServiceable.self)!, userService: r.resolve(UserServiceable.self)!)
      }.inObjectScope(.transient)

      container.register(UserDetailViewModel.self) { r in
          UserDetailViewModel()
      }.inObjectScope(.transient)
  }
}
