//
//  ApiClient.swift
//  iOS Challenge
//
//  Created by Binshad K B on 17/04/23.
//

import Foundation

enum APIError: Error {
    typealias RawValue = String
    
    
    case requestFailed
    case jsonConversionFailure
    case invalidData
    case noData
    case responseUnsuccessful
    case jsonParsingFailure
    case invalidUrl
    case runtimeError(String)
    
    var localizedDescription: String {
        switch self {
        case .requestFailed: return "Request Failed"
        case .invalidData: return "Invalid Data"
        case .noData: return "No Data"
        case .invalidUrl: return "invalid url"
        case .responseUnsuccessful: return "Response Unsuccessful"
        case .jsonParsingFailure: return "JSON Parsing Failure"
        case .jsonConversionFailure: return "JSON Conversion Failure"
        case .runtimeError(let message): return message
        
        }
    }
}

class APIClient {
    
    fileprivate let baseUrl = "https://swapi.dev/api/"
    
    fileprivate var sessionConfigAdditionalHeaders: Dictionary<String, String> = [
        "Content-Type"  : "application/json",
        "Accept"        : "application/json",
        "Data-Type"     : "json"
    ]
    
    func get<T: Decodable>(with endpoint: String, params: NSDictionary?, completion: @escaping (Result<T, APIError>) -> Void) {
        
        var serviceCompleteUrl: String = baseUrl + endpoint
        
        if let _params = params {
            var fieldString = ""
            var valueString = ""
            serviceCompleteUrl.append("?")
            for(field, value) in _params {
                fieldString = self.stringByAddingPercentEscapes(string: field as? String)
                valueString = self.stringByAddingPercentEscapes(string: value as? String)
                serviceCompleteUrl = serviceCompleteUrl.appendingFormat("&%@=%@", fieldString, valueString)
            }
        }
        
        guard let url = URL(string: serviceCompleteUrl) else {
            return
        }
        
        var request: URLRequest = URLRequest(url: url)
        request.httpMethod = "GET"
        
        let task = fetch(with: request, decodingType: T.self) { (json , error) in
            DispatchQueue.main.async {
                
                if let value = json as? T {
                    completion(.success(value))
                }
                else {
                    completion(.failure(.jsonParsingFailure))
                }
                
                if let error = error {
                    completion(Result.failure(error))
                }
            }
        }
        
        task.resume()
    }
    
    func fetch<T: Decodable>(with request: URLRequest, decodingType: T.Type, completionHandler completion: @escaping (Decodable?, APIError?) -> Void) -> URLSessionDataTask {
        
        let sessionConfig:URLSessionConfiguration = self.getSessionConfiguration()
        let session:URLSession = URLSession(configuration: sessionConfig, delegate: nil, delegateQueue: nil)
        let postTask = session.dataTask(with: request, completionHandler: {
            (data, response, error) -> Void in
            
            guard let httpResponse = response as? HTTPURLResponse else {
                completion(nil, .requestFailed)
                return
            }
            
            if httpResponse.statusCode == 200 {
                if let data = data {
                    do {
                        let genericModel = try  JSONDecoder().decode(T.self, from: data)
                        completion(genericModel, nil)
                    } catch let error {
                        completion(nil, error as? APIError)
                    }
                } else {
                    completion(nil, .invalidData)
                }
            } else {
                completion(nil, .responseUnsuccessful)
            }
        })
        
        return postTask
    }
    
    func post<T: Decodable>(with endpoint: String, decode: @escaping (Decodable) -> T?, params: NSDictionary?,  completion: @escaping (Result<T, APIError>) -> Void) {
        
        guard let url = URL(string: baseUrl + endpoint) else {
            DispatchQueue.main.async {
                completion(Result.failure(.invalidUrl))
            }
            return
        }
        
        var request: URLRequest = URLRequest(url: url)
        request.httpMethod = "POST"
        
        var dataToPost: Data? = nil
        if let _params = params {
            do {
                dataToPost = try JSONSerialization.data(withJSONObject: _params, options: .sortedKeys)
            }
            catch {
                
            }
        }
        
        request.httpBody = dataToPost
        
        let task = fetch(with: request, decodingType: T.self) { (json , error) in
            DispatchQueue.main.async {
                guard let json = json else {
                    if let error = error {
                        completion(Result.failure(error))
                    } else {
                        completion(Result.failure(.invalidData))
                    }
                    return
                }
                if let value = decode(json) {
                    completion(.success(value))
                } else {
                    completion(.failure(.jsonParsingFailure))
                }
            }
        }
        
        task.resume()
    }
    
    
    private func getSessionConfiguration() -> URLSessionConfiguration {
        
        let additionalHeaders: NSMutableDictionary = NSMutableDictionary(dictionary: self.sessionConfigAdditionalHeaders)
        
        /* Customizing the default configuration for session  */
        let sessionConfiguration:URLSessionConfiguration = URLSessionConfiguration.default
        
        sessionConfiguration.timeoutIntervalForRequest     = 60.0
        sessionConfiguration.requestCachePolicy            = .reloadIgnoringLocalCacheData
        sessionConfiguration.httpShouldSetCookies          = false
        sessionConfiguration.httpAdditionalHeaders         = additionalHeaders as [NSObject : AnyObject]
        
        return sessionConfiguration
    }
    
    private func getPostString(params:[String:Any]) -> String
    {
        var data = [String]()
        for(key, value) in params
        {
            data.append(key + "=\(value)")
        }
        return data.map { String($0) }.joined(separator: "&")
    }
    
    private func stringByAddingPercentEscapes(string: String?) -> String {
        
        guard let text = string?.addingPercentEncoding(withAllowedCharacters: NSCharacterSet.urlQueryAllowed) else {
            return ""
        }
        
        return text
    }
}
