//
//  ContentView.swift
//  Custom Textfield
//
//  Created by Derek Chan on 2020/8/31.
//

import SwiftUI

class LoginData: ObservableObject {
    @Published var nickname: String = "" {
        didSet{
            if nickname.count > 10 {
                nickname = oldValue
            }
        }
    }
    
    @Published var password: String = "" {
        didSet{
            if password.count > 8 {
                password = oldValue
            }
        }
    }
    
    @Published var showPassword: Bool = false
}

struct LoginView: View {
   @ObservedObject private var loginData = LoginData()
    
    var body: some View {
        VStack {
            Spacer()
            
            Text("Apple")
                .font(.system(size: 50, weight: .bold))
                .foregroundColor(.white)
                .padding()
            
            Spacer()
            
            HStack {
                Image(systemName: "cloud.fill")
                    .imageScale(.large)
                    .foregroundColor(.white)
                CustomTextField(placeholder: "Apple ID", text: $loginData.nickname) {
                    print("Nickname commit: \(loginData.nickname)")
                }
            }
            .loginTextFieldBorder()
            
            HStack {
                Image(systemName: "lock.fill")
                    .imageScale(.large)
                    .foregroundColor(.white)
                CustomSecureField(placeholder: "Password", text: $loginData.password, showPassword: $loginData.showPassword) {
                    print("Password commit: \(loginData.password)")
                }
                ShowPasswordImage(showPassword: loginData.showPassword)
                    .onTapGesture(count: 1, perform: {
                        loginData.showPassword.toggle()
                    })
            }
            .loginTextFieldBorder()
            
            LoginButton()
                .onTapGesture(count: 1){
                    guard let window = UIApplication.shared.windows.first else {
                        return
                    }
                    window.endEditing(true)
                    window.rootViewController = UIHostingController(rootView: Example())
                }
            
            Spacer()
            Spacer()
        }
        .frame(height: UIScreen.main.bounds.height)
        .background(LinearGradient(gradient: Gradient(colors: [Color.purple, Color.orange]), startPoint: .top, endPoint: .bottom))
        .edgesIgnoringSafeArea(.all)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}

struct CustomTextField: View {
    let placeholder: String
    @Binding var text: String
    let onCommit: () -> Void
    
    var body: some View {
        ZStack(alignment: .leading){
            if text.isEmpty {
                Text(placeholder)
                    .foregroundColor(Color(red: 1, green: 1, blue: 1, opacity: 0.5))
            }
            
            TextField("", text: $text, onCommit: onCommit)
                .foregroundColor(.white)
                .accentColor(.purple)
                .keyboardType(.emailAddress)
        }
        .font(.system(size: 20))
        .frame(height: 30)
    }
}

struct CustomSecureField: View {
    let placeholder: String
    @Binding var text: String
    @Binding var showPassword: Bool
    let onCommit: () -> Void
    
    var body: some View {
        ZStack(alignment: .leading){
            if text.isEmpty {
                Text(placeholder)
                    .foregroundColor(Color(red: 1, green: 1, blue: 1, opacity: 0.5))
            }
            
            if showPassword {
                TextField("", text: $text, onCommit: onCommit)
                    .foregroundColor(.white)
                    .accentColor(.purple)
                    .keyboardType(.default)
            } else {
                SecureField("", text: $text, onCommit: onCommit)
                    .foregroundColor(.white)
                    .accentColor(.purple)
                    .keyboardType(.default)
            }
        }
        .font(.system(size: 20))
        .frame(height: 30)
    }
}

struct ShowPasswordImage:View {
    let showPassword: Bool
    
    var body: some View {
        Image(systemName: "eye")
            .imageScale(.medium)
            .foregroundColor(.white)
            .overlay(
                Group {
                    if showPassword {
                        Image(systemName: "eye.slash")
                            .imageScale(.medium)
                            .foregroundColor(.white)
                    }
                }
            )
    }
}

struct LoginButton: View {
    var body: some View {
     Image(systemName: "arrow.right.circle")
        .resizable()
        .imageScale(.large)
        .foregroundColor(.white)
        .frame(width: 60, height: 60, alignment: .center)
        .padding()
    }
}

extension View {
    func loginTextFieldBorder() -> some View {
        self.padding(.horizontal, 60)
            .padding(.vertical, 20)
            .overlay(
            RoundedRectangle(cornerRadius: 10)
                .stroke(Color.white)
                .padding(.horizontal, 40)
                .padding(.vertical, 10)
            )
    }
}
