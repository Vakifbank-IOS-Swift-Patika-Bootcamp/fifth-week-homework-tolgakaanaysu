//
//  NetworkClient.swift
//  BreakingBadProject
//
//  Created by Tolga Kağan Aysu on 22.11.2022.
//

import Foundation

final class NetworkClient {
    
    //MARK: - Endpoints
    enum EndPoints {
        static let base = "https://www.breakingbadapi.com/api/"
        
        // - Case
        case allCharters
        case specificCharacter(Int)
        case allEpisodes
        case specificEpisode(Int)
        case quoteByAuthor
        
        private var urlString: String {
            switch self {
            case .allCharters:
                return EndPoints.base + "characters"
            case .specificCharacter(let id) :
                return EndPoints.base + "characters" + "/\(id)"
            case .allEpisodes:
                return EndPoints.base + "episodes?series=Breaking+Bad"
            case .specificEpisode(let id):
                return EndPoints.base + "episodes" + "/\(id)"
            case .quoteByAuthor:
                return EndPoints.base + "quote"
            }
        }
        
        // - URL
        var url: URL {
            switch self {
                
            case .allCharters:
                return URL(string: EndPoints.allCharters.urlString)!
            case .specificCharacter(let id):
                return URL(string: EndPoints.specificCharacter(id).urlString)!
            case .allEpisodes:
                return URL(string: EndPoints.allEpisodes.urlString)!
            case .specificEpisode(let id):
                return URL(string: EndPoints.specificEpisode(id).urlString)!
            case .quoteByAuthor:
                return URL(string: EndPoints.quoteByAuthor.urlString)!
            }
        }
    }
    
    // Custom response error
    enum ResponseError: Error {
        case dataParseError
        case noDataError
        
        var description: String {
            switch self {
                
            case .dataParseError:
                return "No data"
            case .noDataError:
                return "Data parse error"
            }
        }
    }
    
    //MARK: - GET Request
    @discardableResult
    private class func taskForGETRequest<ResponseType: Decodable>(url: URL, responsetType: ResponseType.Type, completion: @escaping (ResponseType?, Error?) -> Void) -> URLSessionDataTask {
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data else {
                DispatchQueue.main.async {
                    
                    completion(nil, error)
                }
                return
            }
            let decoder = JSONDecoder()
            do {
                
                let responseObject = try decoder.decode(ResponseType.self, from: data)
                DispatchQueue.main.async {
                    completion(responseObject, nil)
                }
            } catch {
                
                //                do {
                //                    let errorResponse = try decoder.decode(BaseResponse.self, from: data) as Error
                //                    DispatchQueue.main.async {
                //                        completion(nil, errorResponse)
                //                    }
                //                } catch {
                //                    DispatchQueue.main.async {
                //                        completion(nil, error)
                //                    }
                //                }
            }
        }
        task.resume()
        return task
    }
    
    // Get all characters request
    class func getAllCharacters(completion: @escaping([CharacterModel]?, Error?) -> Void){
        NetworkClient.taskForGETRequest(url: EndPoints.allCharters.url, responsetType: [CharacterModel].self) { response, error in
            if let response = response {
                completion(response,nil)
            } else {
                completion(nil,error)
            }
        }
    }
    
    // Get specific character by id
    class func getSpecificCharacter(id: Int, completion: @escaping([CharacterModel]?, Error?) -> Void) {
        NetworkClient.taskForGETRequest(url: EndPoints.specificCharacter(id).url, responsetType: [CharacterModel].self) { response, error in
            if let response = response {
                completion(response,nil)
            } else {
                completion(nil,error)
            }
        }
    }
    
    // Get all episode request
    class func getAllEpisode(completion: @escaping([EpisodeModel]?, Error?) -> Void ) {
        NetworkClient.taskForGETRequest(url: EndPoints.allEpisodes.url, responsetType: [EpisodeModel].self) { response, error in
            if let response = response {
                completion(response,nil)
            } else {
                completion(nil,error)
            }
        }
    }
    
    
    // Get specific episode by id
    class func getSpesificEpisode(id: Int, completion: @escaping([EpisodeModel]?, Error?) -> Void ) {
        NetworkClient.taskForGETRequest(url: EndPoints.specificEpisode(id).url , responsetType: [EpisodeModel].self) { response, error in
            if let response = response {
                completion(response,nil)
            } else {
                completion(nil,error)
            }
        }
    }
    
    class func getQuoteByAuthor(name: String, completion: @escaping([QuoteModel]?, Error?) -> Void ){
        var url = EndPoints.quoteByAuthor.url
        let query = URLQueryItem(name: "author", value: name)
        url.append(queryItems: [query])
        NetworkClient.taskForGETRequest(url: url, responsetType: [QuoteModel].self) { response, error in
            if let response = response {
                completion(response,nil)
            } else {
                print(error!.localizedDescription)
                completion(nil,error)
            }
        }
    }
}

