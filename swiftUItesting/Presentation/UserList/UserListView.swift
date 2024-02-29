//
//  UserList.swift
//  swiftUItesting
//
//  Created by vlad.kosyi on 22.02.2024.
//

import SwiftUI

struct UserListView: View {

    @State var viewModel: UserListViewModel

    var body: some View {
        List(self.viewModel.users) { user in
            HStack {

                RemoteImageView(
                    url: URL(string: user.avatarURL)!,
                    placeholder: {
                        Image("photo")
                    },
                    image: {
                        $0
                        .resizable()
                        .scaledToFill()
                        .clipShape(Circle())
                        .frame(width: 60, height: 60)
                    }
                )

                VStack(alignment: .leading) {
                    Text(user.login)
                    Text("\(user.url)")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                }
                .padding()
            }
            .listRowSeparator(.hidden)
            .onTapGesture {
                self.viewModel.onDetail.send(user)
            }
       }
        .padding(.top, 30)
        .navigationBarItems(trailing:
            Button(action: self.viewModel.onLogout) {
                Text("Logout")
            }
        )
        .task {
            await viewModel.fetchUsers()
        }
    }
}

#if DEBUG
struct UserListView_Previews: PreviewProvider {
  static let appAssembler = AppAssembler()
  static let viewModel = appAssembler.resolver.resolve(UserListViewModel.self)!

  static var previews: some View {
    Group {
        UserListView(viewModel: viewModel)
        .edgesIgnoringSafeArea(.all)
    }
  }
}
#endif

