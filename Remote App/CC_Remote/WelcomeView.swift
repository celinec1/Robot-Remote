//
//  WelcomeView.swift
//  CC_Remote
//
//  Created by Celine on 2/1/24.
//

import SwiftUI
struct WelcomeView: View {
    var onStart: () -> Void

    var body: some View {
        VStack(spacing: 20) {
            Text("Welcome!")
                .font(.system(size:32))
            Text("Connect your robot :)")
                .font(.system(size:32))
                .padding()
            Button(action: onStart) {
                Text("START")
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
        }
    }
}

