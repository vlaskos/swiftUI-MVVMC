//
//  UserDetailViewModel.swift
//  swiftUItesting
//
//  Created by vlad.kosyi on 23.02.2024.
//

import Foundation
import Combine
import CombineExt


@Observable
class UserDetailViewModel: ViewModel {

    private var cancelBag: CancelBag!

    var userName: String = "Test"
    var userImageUrl: String = "Test"
    var userUrl: String = "Test"

    func setup(user: GitUser) -> Self {
        self.userName = user.login
        self.userUrl = user.url
        self.userImageUrl = user.avatarURL
        bind()
        return self
    }

    private func bind() {
        self.cancelBag = CancelBag()
    }
}
