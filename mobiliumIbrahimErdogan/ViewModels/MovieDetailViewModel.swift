//
//  MovieDetailViewModel.swift
//  mobiliumIbrahimErdogan
//
//  Created by İbrahim Erdogan on 13.11.2022.
//

import Foundation
import Combine
class MovieDetailViewModel
{
    var api = ServiceAPI()
    var movieId : Int
    var movie : MovieBaseModel?
    
    var movieDetailObj = CurrentValueSubject<MovieBaseModel,APIError>(MovieBaseModel(adult: nil, backdropPath: nil, belongsToCollection: nil, budget: nil, genres: nil, homepage: nil, id: nil, originalTitle: nil, imdbID: nil, originalLanguage: nil, overview: nil, popularity: nil, posterPath: nil, productionCompanies: nil, productionCountries: nil, releaseDate: nil, revenue: nil, runtime: nil, spokenLanguages: nil, title: nil, status: nil, tagline: nil, video: nil, voteAverage: nil, voteCount: nil))
    init(Id : Int)
    {
        self.movieId = Id
    }
    
    func getMovieDetail(completed : @escaping (_ errorString : String?)->())
    {
        api.getMovieDetail(id: String(self.movieId)) { result in
            switch result{
            case .success(let movie):
                self.movie = movie
                completed(nil)
            case .failure(let error):
                completed(error.localizedDescription)
            }
        }
    }
    
    func getMovieDetailWithPublisher()
    {
        api.getMovieDetail(id: String(self.movieId)) {[weak self] result in
            switch result {
            case .failure(let error):
                self?.movieDetailObj.send(completion: .failure(error))
                print(error.localizedDescription)
            case .success(let model):
                print(model.title)
                self?.movieDetailObj.send(model)
            }
        }
    }
    
    
}
