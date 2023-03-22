//
//  APIError.swift
//  WeatherInformation

import Foundation

//Enum to handle errors
public enum APIError: Error {
    case noData
    case requestError(Error)
    case serverError(statusCode: Int)
    case decodingError(Error)
}
