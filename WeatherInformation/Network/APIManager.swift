//
//  APIManager.swift
//  WeatherInformation

import Foundation

public typealias NetworkServiceCompletion<T: Decodable, E: Error> = (Result<T, E>) -> Void

public class APIManager {
    public static let sharedInstance = APIManager()
    
    /**
     Method to make API request
     - parameter request: a URLRequest object
     - parameter completion: a Result<T, E> object
     */
    public func makeRequest<T: Decodable>(request: URLRequest,
                                   completion: @escaping NetworkServiceCompletion<T, Error>) {
        let task = URLSession.shared.dataTask(with: request) { [weak self] data, response, error in
            guard let _ = self else { return }
            DispatchQueue.main.async {
                if let error = error {
                    //When there is an error
                    completion(.failure(error))
                    return
                }
                guard let data = data else {
                    //When the data is empty
                    completion(.failure(APIError.noData))
                    return
                }
                do {
                    //Decoding JSON
                    let items = try JSONDecoder().decode(T.self, from: data)
                    completion(.success(items))
                } catch {
                    //When there is a decoding error
                    completion(.failure(error))
                }
            }
        }
        task.resume()
    }
}
