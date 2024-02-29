//
//  MoviesService.swift
//  RequestApp
//
//  Created by Victor Catão on 18/02/22.
//

import Foundation

protocol UserServiceable {
    func getUsers() async -> Result<[GitUser], RequestError>
}

struct UserService: HTTPClient, UserServiceable {
    func getUsers() async -> Result<[GitUser], RequestError> {
        return await sendRequest(endpoint: UserEndpoint.users, responseModel: [GitUser].self)
    }
}
