//
//  MoviesEndpoint.swift
//  RequestApp
//
//  Created by Victor Catão on 18/02/22.
//

enum UserEndpoint {
    case users
}

extension UserEndpoint: Endpoint {
    var path: String {
        switch self {
        case .users:
            return "/users"
        }
    }

    var method: RequestMethod {
        switch self {
        case .users:
            return .get
        }
    }

    var header: [String: String]? {
        switch self {
        case .users:
            return [
                "Content-Type": "application/json;charset=utf-8"
            ]
        }
    }
    
    var body: [String: String]? {
        switch self {
        case .users:
            return nil
        }
    }
}
