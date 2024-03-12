//
//  UserViewModel.swift
//  TestProject
//
//  Created by Alexandr Kudlak on 29.02.2024.
//

import Foundation
import Alamofire
import CoreData

class UserViewModel: ObservableObject {
    @Published var users = [User]()
    @Published var isFetching = false
    @Published var searchQuery = ""
    private var baseUrl = "https://api.github.com/search/users"

    func searchUsers() {
        guard !searchQuery.isEmpty else {
            self.users = []
            return
        }
        isFetching = true
        let url = "\(baseUrl)?q=\(searchQuery)"
        
        AF.request(url).responseDecodable(of: SearchResults<User>.self) { response in
            DispatchQueue.main.async {
                self.isFetching = false
                switch response.result {
                case .success(let results):
                    self.users = results.items
                    self.saveUsersToCache(users: results.items)
                case .failure(let error):
                    print(error.localizedDescription)
                    self.users = self.loadUsersFromCache()
                }
            }
        }
    }
    
    func saveUsersToCache(users: [User]) {
        let viewContext = PersistenceController.shared.container.viewContext
        for user in users {
            let cachedUser = CachedUser(context: viewContext)
            cachedUser.id = Int64(user.id)
            cachedUser.login = user.login
            cachedUser.avatarUrl = user.avatarUrl
            cachedUser.htmlUrl = user.htmlUrl
        }
        do {
            try viewContext.save()
        } catch {
            print("Failed to save users: \(error)")
        }
    }

    func loadUsersFromCache() -> [User] {
        let viewContext = PersistenceController.shared.container.viewContext
        let request: NSFetchRequest<CachedUser> = CachedUser.fetchRequest()
        do {
            let cachedUsers = try viewContext.fetch(request)
            return cachedUsers.map { User(id: Int($0.id), login: $0.login!, avatarUrl: $0.avatarUrl!, htmlUrl: $0.htmlUrl!) }
        } catch {
            print("Failed to fetch cached users: \(error)")
            return []
        }
    }

}

struct SearchResults<T: Codable>: Codable {
    let items: [T]
}


