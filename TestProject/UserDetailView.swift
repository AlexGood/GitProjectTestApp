//
//  UserDetailView.swift
//  TestProject
//
//  Created by Alexandr Kudlak on 29.02.2024.
//

import SwiftUI

struct UserDetailView: View {
    var user: User

    var body: some View {
        VStack {
            AsyncImage(url: URL(string: user.avatarUrl))
                .aspectRatio(contentMode: .fit)
            Text(user.login)
                .font(.title)
            Link("View Profile", destination: URL(string: user.htmlUrl)!)
        }
        .padding()
        .navigationBarTitle(user.login, displayMode: .inline)
    }
}
