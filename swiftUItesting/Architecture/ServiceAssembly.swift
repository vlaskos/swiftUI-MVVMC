//
//  ServiceAssembly.swift
//  MVVM.Demo.SwiftUI
//
//  Created by Jason Lew-Rapai on 11/15/21.
//

import Foundation
import Swinject

class ServiceAssembly: Assembly {
  func assemble(container: Container) {

    container.register(AuthenticationServiceable.self) { r in
      AuthenticationService()
    }.inObjectScope(.container)
      
    container.register(UserServiceable.self) { r in
        UserService()
    }.inObjectScope(.container)

  }
}
