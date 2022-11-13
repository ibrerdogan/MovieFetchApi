//
//  Api.swift
//  mobiliumIbrahimErdogan
//
//  Created by İbrahim Erdogan on 13.11.2022.
//

import Foundation
import Alamofire
class ServiceAPI
{
    //farklı sorgular için farklı endpointler gerekebilir diyerek url creationu farklı bir fonksiyon içerisinde yazdım.
    //burada page = 0 geldiği zaman sadece movie sorgusu yaptığımız ortaya çıkıyor ve page parametresini url içerisine almıyorum
    //api key info.plisy içerisine saklanabilir.
    //servide error enumu ile belli hataları kontrol ediğ ekrana veriyorum
    
    
    func createUrl(endpoind : String,page : Int) -> URL?
    {
        let apiKey = "1f28ee049ce766acadb7f46eb0a9e2f0"
        var componenets = URLComponents()
        componenets.scheme = "https"
        componenets.host = "api.themoviedb.org"
        componenets.path = "/3/movie/\(endpoind)"
        componenets.queryItems = [
        URLQueryItem(name: "api_key", value: apiKey),
        URLQueryItem(name: "language", value: "en-US")]
        
        if page != 0 {
            componenets.queryItems?.append(URLQueryItem(name: "page", value: "\(page)"))
        }
        let url = componenets.url
        return url
        
    }
    
    //3 ayrı sorgu sistemi için tek bir fonksiyon yazdım asıl api bağlantısını buradan saplıyorum
     private func fetch<T : Codable>(type : T.Type ,url : URL? , completion : @escaping (Result<T,APIError>)->Void)
    {
        if let url = url {
            AF.request(url).responseDecodable(of: T.self) { response in
                
               if let error = response.error
                {
                   debugPrint(error.localizedDescription)
                   completion(.failure(.badResponse(error.responseCode!)))
                }
                else
                {
                    if let movie = response.value
                    {
                        completion(.success(movie))
                    }
                }
                
            }

        }
        else
        {
            completion(.failure(.badURL))
        }
    }
    
    
    //bu fonksiyon da viewmodellerden istenen bilgileri fetch fonksiyonuna iletiyor ver geri istenen itemleri döndürüyor
    func getPlayingMovies(completion : @escaping (Result<NowPlayingMovieModel,APIError>)->Void)
    {
        let url = createUrl(endpoind: "now_playing",page: 1)
        fetch(type: NowPlayingMovieModel.self, url: url, completion: completion)
    }
    
    func getUpcomingMovies(page : Int,completion : @escaping (Result<UpComingMovieModel,APIError>)->Void)
    {
        let url = createUrl(endpoind: "upcoming",page: page)
        fetch(type: UpComingMovieModel.self, url: url, completion: completion)
    }
    
    func getMovieDetail(id : String,completion : @escaping (Result<MovieBaseModel,APIError>)->Void)
    {
        let url = createUrl(endpoind: id, page: 0)
        fetch(type: MovieBaseModel.self, url: url, completion: completion)
    }

    
}
