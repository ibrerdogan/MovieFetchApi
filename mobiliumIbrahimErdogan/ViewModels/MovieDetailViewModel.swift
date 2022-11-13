//
//  MovieDetailViewModel.swift
//  mobiliumIbrahimErdogan
//
//  Created by İbrahim Erdogan on 13.11.2022.
//

import Foundation

class MovieDetailViewModel
{
    var api = ServiceAPI()
    var movieId : Int
    var movie : MovieBaseModel?
    
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
    
    
}
