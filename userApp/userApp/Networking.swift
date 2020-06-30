//
//  Networking.swift
//  userApp
//
//  Created by Lucas Da Silva on 30/06/20.
//  Copyright © 2020 Lucas Da Silva. All rights reserved.
//

import Foundation
import UIKit

enum UserError: Error {
    case NoDataAvailable
    case CanNotProcessData
    case InvalidURL
}

struct Networking {
    static let shared = Networking()
    let session = URLSession.shared

    let userURL = "https://jsonplaceholder.typicode.com/users"

    func getUsers(completion: @escaping(Result<[User], UserError>) -> Void) {
        guard let UserURL=URL(string: userURL) else {
            completion(.failure(.InvalidURL))
            return
        }
        let dataTask = session.dataTask(with: UserURL) { data,_,_ in
            guard let jsonData = data else {
                completion(.failure(.NoDataAvailable))
                return
            }
            do {
                let decoder = JSONDecoder()
                let userResponse = try decoder.decode([User].self, from: jsonData)
                completion(.success(userResponse))
            }
            catch {
                completion(.failure(.CanNotProcessData))
            }
        }
        dataTask.resume()
    }
}
