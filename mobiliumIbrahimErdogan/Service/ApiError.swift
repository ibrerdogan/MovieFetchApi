//
//  ApiError.swift
//  mobiliumIbrahimErdogan
//
//  Created by İbrahim Erdogan on 13.11.2022.
//

import Foundation

enum APIError : Error , CustomStringConvertible
{
    
    case badURL
    case urlSession(URLError)
    case badResponse(Int)
    case decodingError(DecodingError?)
    case unknown
    
    var description: String {
        switch self {
        case .badURL:
            return "badURL"
        case .urlSession(let error):
            return "urlSession \(error.localizedDescription)"
        case .badResponse(let statusCode):
            return "badResponse \(statusCode)"
        case .decodingError(let decodingError):
            return "decodingError \(decodingError?.localizedDescription ?? "decoding error")"
        case .unknown:
            return "unknown"
        }
    }
    
    var localizedDescription : String{
        switch self {
        case .badURL:
            return "something went wrong"
        case .urlSession(let uRLError):
            return uRLError.localizedDescription
        case .decodingError(let decodingError):
            return decodingError?.localizedDescription ?? "decoding error"
        case .unknown:
            return "something went wrong"
        case .badResponse(_):
            return "something went wrong"
        }
    }
    
}
