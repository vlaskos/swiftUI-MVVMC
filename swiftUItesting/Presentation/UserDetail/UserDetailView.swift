//
//  UserDetailView.swift
//  swiftUItesting
//
//  Created by vlad.kosyi on 23.02.2024.
//

import SwiftUI

struct UserDetailView: View {

    @State var viewModel: UserDetailViewModel

    var body: some View {

        let size = UIScreen.main.bounds.width/1.5

        RemoteImageView(
            url: URL(string: viewModel.userImageUrl)!,
            placeholder: {
                Image("photo")
            },
            image: {
                $0
                    .resizable()
                    .scaledToFill()
                    .clipShape(Circle())
                    .frame(width: size, height: size)
            }
        ).padding(.top, 100)

        VStack(alignment: .center) {
            Text(self.viewModel.userName)
                .multilineTextAlignment(.center)
            Text("\(self.viewModel.userUrl)")
                .font(.subheadline)
                .foregroundColor(.secondary)
                .multilineTextAlignment(.center)
        }.padding()

        Spacer()
    }
}

#if DEBUG
struct UserDetailView_Previews: PreviewProvider {
  static let appAssembler = AppAssembler()
  static let viewModel = appAssembler.resolver.resolve(UserDetailViewModel.self)!

  static var previews: some View {
    Group {
        UserDetailView(viewModel: viewModel)
        .edgesIgnoringSafeArea(.all)
    }
  }
}
#endif
