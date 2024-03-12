//
//  ContentView.swift
//  TestProject
//
//  Created by Alexandr Kudlak on 29.02.2024.
//

import SwiftUI
import CoreData

import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel = UserViewModel()

    var body: some View {
        NavigationView {
            List(viewModel.users) { user in
                NavigationLink(destination: UserDetailView(user: user)) {
                    UserRow(user: user)
                }
            }
            .navigationBarTitle("GitHub Users")
            .searchable(text: $viewModel.searchQuery, prompt: "Search Users")
            .onSubmit(of: .search) {
                if Connectivity.shared.isConnected {
                    viewModel.searchUsers()
                }
            }
        }
    }
}

struct UserRow: View {
    let user: User

    var body: some View {
        HStack {
            AsyncImage(url: URL(string: user.avatarUrl)) { image in
                image.resizable()
            } placeholder: {
                Color.gray
            }
            .frame(width: 50, height: 50)
            .clipShape(Circle())

            VStack(alignment: .leading) {
                Text(user.login).font(.headline)
                Text(user.htmlUrl).font(.subheadline)
            }
        }
    }
}
