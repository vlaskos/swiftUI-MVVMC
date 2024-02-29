//
//  LoginView.swift
//  swiftUItesting
//
//  Created by vlad.kosyi on 22.02.2024.
//

import SwiftUI

struct LoginView: View {

    @State var viewModel: LoginViewModel
    @State private var signInDisabled: Bool = true

    @ScaledMetric private var buttonFontSize: CGFloat = 18.0
    @FocusState private var focusState: FocusField?
    enum FocusField {
      case username
      case password
    }

    var body: some View {
        VStack {
            VStack(alignment: .leading, content: {
                TextField("Username", text: self.$viewModel.username)
                    .focused(self.$focusState, equals: .username)
                    .padding()
                    .background(RoundedRectangle(cornerRadius: 8.0).stroke(Color.systemGray))
                    .contentShape(Rectangle())
                    .onTapGesture {
                      if self.focusState != .username {
                        self.focusState = .username
                      }
                    }
                SecureField("Password", text: self.$viewModel.password)
                    .focused(self.$focusState, equals: .password)
                    .padding()
                    .background(RoundedRectangle(cornerRadius: 8.0).stroke(Color.systemGray))
                    .contentShape(Rectangle())
                    .onTapGesture {
                      if self.focusState != .password {
                        self.focusState = .password
                      }
                    }
                
            })
            .padding(16.0)
            .onSubmit {
              switch self.focusState {
              case .none: break
              case .username: self.focusState = .password
              case .password: self.focusState = nil
              }
            }

            Button(action: self.viewModel.login) {
              Text("LOGIN")
                .lineLimit(1)
                .minimumScaleFactor(0.75)
                .font(.system(size: self.buttonFontSize))
                .frame(maxWidth: .infinity, minHeight: 48.0)
                .contentShape(Rectangle())
                .background(RoundedRectangle(cornerRadius: 8.0).stroke(Color.systemGray))
                .foregroundColor(self.signInDisabled ? .gray : .blue)
                .frame(width: UIScreen.main.bounds.width/2)
            }
            .disabled(self.signInDisabled)
        }
        .onReceive(self.viewModel.canSignIn) {
            self.signInDisabled = !$0
        }
    }
}

#if DEBUG
struct SignInView_Previews: PreviewProvider {
  static let appAssembler = AppAssembler()
  static let viewModel = appAssembler.resolver.resolve(LoginViewModel.self)!

  static var previews: some View {
    Group {
      LoginView(viewModel: viewModel)
        .edgesIgnoringSafeArea(.all)
    }
  }
}
#endif
