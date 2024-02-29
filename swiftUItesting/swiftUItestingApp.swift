//
//  swiftUItestingApp.swift
//  swiftUItesting
//
//  Created by vlad.kosyi on 22.02.2024.
//

import SwiftUI

private let appAssembler: AppAssembler = AppAssembler()

@main
struct swiftUItestingApp: App {
    var body: some Scene {
        WindowGroup {
          AppRootCoordinatorView(
            coordinator: appAssembler.resolver.resolve(AppRootCoordinator.self)!
          )
        }
    }
}
