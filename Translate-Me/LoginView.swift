//
//  LoginView.swift
//  Translate-Me
//
//  Created by Yulia E on 4/11/25.
//

import SwiftUI

struct LoginView: View {
    @Environment(AuthManager.self) var authManager // <-- Access the authManager from the environment
    
    @State private var email: String = ""
    @State private var password: String = ""

    var body: some View {
        VStack {
            Spacer()
            
            Text("TranslateMe App")
                .font(.largeTitle)
                .fontWeight(.bold)
                .padding(.bottom, 20)

            // Email + password fields
            VStack(spacing: 16) {
                TextField("Email", text: $email)
                    .keyboardType(.emailAddress)
                    .autocapitalization(.none)
                    .disableAutocorrection(true)

                SecureField("Password", text: $password)
            }
            .textFieldStyle(.roundedBorder)
            .textInputAutocapitalization(.never)
            .padding(.horizontal, 40)

            Spacer()

            // Sign up + Login buttons
            HStack(spacing: 20) {
                Button("Sign Up") {
                    print("Sign up user: \(email), \(password)")
                    // TODO: Sign up user
                    
                    authManager.signUp(email: email, password: password) // <-- Sign up user via authManager

                }
                .buttonStyle(.borderedProminent)

                Button("Login") {
                    print("Login user: \(email), \(password)")
                    // TODO: Login user
                    authManager.signIn(email: email, password: password) // <-- Sign in user via authManager

                }
                .buttonStyle(.bordered)
            }
            .padding(.bottom, 40)
        }
    }
}

#Preview {
    LoginView()
        .environment(AuthManager()) // <-- For the preview to work, pass an instance of AuthManager into the environment

}
