//
//  SliderViewModel.swift
//  mobiliumIbrahimErdogan
//
//  Created by İbrahim Erdogan on 13.11.2022.
//

import Foundation

class SliderViewModel
{
    var sliderMovies : [MovieBaseModel]?
    var playingMovies : NowPlayingMovieModel?
    var api : ServiceAPI
    init(with api : ServiceAPI)
    {
        self.api = api
    }
    
    func getPlayingMovies(completed :@escaping (_ errorString : String?)->())
    {
        api.getPlayingMovies { result in
            switch result{
            case .success(let playingMovie):
                self.sliderMovies = playingMovie.results
                completed(nil)
            case .failure(let error):
                completed(error.localizedDescription)
            }
        }
    }
}
