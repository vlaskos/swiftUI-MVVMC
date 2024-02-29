//
//  UserListCoordinatorView.swift
//  swiftUItesting
//
//  Created by vlad.kosyi on 22.02.2024.
//

import SwiftUI

struct UserListCoordinatorView: View {
    @State var coordinator: UserListCoordinator
    @State private var userDetailViewModel: UserDetailViewModel?

    var body: some View {
      ObjectNavigationStack(path: self.coordinator.path) {
        UserListView(viewModel: self.coordinator.rootContentViewModel)
          .navigationDestination(for: UserDetailViewModel.self) {
              UserDetailView(viewModel: $0)
          }
      }
    }
}
