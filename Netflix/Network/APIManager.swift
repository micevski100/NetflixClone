//
//  APIManager.swift
//  Netflix
//
//  Created by Aleksandar Micevski on 25.6.22.
//

import Foundation
import Alamofire

typealias CompletitionCallBack = ((_ success: Bool, _ responseObject: [String:Any]?,_ statusCode : Int?)-> ())?

class APIManager {
    static let sharedInstance = APIManager()
    
    func executeRequest(url: URL, completitionCallback : CompletitionCallBack) {
        AF.request(url).responseJSON { response in
            switch response.result {
                case .success(let value):
                let json = value as? [String:Any]
                var statusCode = 200
                if let res = response.response {
                    statusCode = res.statusCode
                    if statusCode == 200 {
                        completitionCallback!(true,json,statusCode)
                    } else {
                        completitionCallback!(false,json,statusCode)
                    }
                }
            case .failure(_):
                if let res = response.response {
                    let statusCode = res.statusCode
                    completitionCallback!(false,nil,statusCode)
                } else {
                    completitionCallback!(false,nil,nil)
                }
            }
        }
    }
    
    func getTrendingMovies(completition: CompletitionCallBack) {
        guard let url = URL(string: "\(Constants.baseURL)/3/trending/movie/day?api_key=\(Constants.API_KEY)") else {return}
        
        executeRequest(url: url) { success, responseObject, statusCode in
            completition!(success, responseObject, statusCode)
        }
    }
    
    func getTrendingTVs(completition: CompletitionCallBack) {
        guard let url = URL(string: "\(Constants.baseURL)/3/trending/tv/day?api_key=\(Constants.API_KEY)") else {return}
        
        executeRequest(url: url) { success, responseObject, statusCode in
            completition!(success, responseObject, statusCode)
        }
    }
    
    func getUpcomingMovies(completition: CompletitionCallBack) {
        guard let url = URL(string: "\(Constants.baseURL)/3/movie/upcoming?api_key=\(Constants.API_KEY)&language=en-US&page=1") else {return}
        
        executeRequest(url: url) { success, responseObject, statusCode in
            completition!(success, responseObject, statusCode)
        }
    }
    
    func getPopularMovies(completition: CompletitionCallBack) {
        guard let url = URL(string: "\(Constants.baseURL)/3/movie/popular?api_key=\(Constants.API_KEY)&language=en-US&page=1") else {return}
        
        executeRequest(url: url) { success, responseObject, statusCode in
            completition!(success, responseObject, statusCode)
        }
    }
    
    func getTopRatedMovies(completition: CompletitionCallBack) {
        guard let url = URL(string: "\(Constants.baseURL)/3/movie/top_rated?api_key=\(Constants.API_KEY)&language=en-US&page=1") else {return}
        
        executeRequest(url: url) { success, responseObject, statusCode in
            completition!(success, responseObject, statusCode)
        }
    }
    
    func getDiscoverMovies(completition: CompletitionCallBack) {
        guard let url = URL(string: "\(Constants.baseURL)/3/discover/movie?api_key=\(Constants.API_KEY)&language=en-US&sort_by=popularity.desc&include_adult=false&include_video=false&page=1&with_watch_monetization_types=flatrate") else {return}
        
        executeRequest(url: url) { success, responseObject, statusCode in
            completition!(success, responseObject, statusCode)
        }
    }
    
    func saerch(query: String, completition: CompletitionCallBack) {
        guard let query = query.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) else {return}
        guard let url = URL(string: "\(Constants.baseURL)/3/search/movie?api_key=\(Constants.API_KEY)&query=\(query)") else {return}
        
        executeRequest(url: url) { success, responseObject, statusCode in
            completition!(success, responseObject, statusCode)
        }
    }
}
