//
//  AppRootCoordinatorView.swift
//  swiftUItesting
//
//  Created by vlad.kosyi on 22.02.2024.
//

import SwiftUI

struct AppRootCoordinatorView: View {

    @State var coordinator: AppRootCoordinator
    @State private var loginViewModel: LoginViewModel?
    @State private var userListCoordinator: UserListCoordinator?

    var body: some View {
        ObjectNavigationStack(path: self.coordinator.path) {
          ZStack {
            LoginView(viewModel: self.coordinator.loginViewModel)
              .fullScreenCover(item: self.$userListCoordinator) { coordinator in
                  UserListCoordinatorView(coordinator: coordinator)
              }
          }
        }
        .onChange(of: self.coordinator.loginViewModel, initial: true) { _, value in
            self.loginViewModel = value
        }
        .onChange(of: self.coordinator.userListCoordinator, initial: true) { _, value in
            self.userListCoordinator = value
        }
    }
}
