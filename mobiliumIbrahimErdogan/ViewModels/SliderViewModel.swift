//
//  SliderViewModel.swift
//  mobiliumIbrahimErdogan
//
//  Created by İbrahim Erdogan on 13.11.2022.
//

import Foundation
import Combine
class SliderViewModel
{
    var sliderMovies : [MovieBaseModel]?
    var playingMovies : NowPlayingMovieModel?
    var api : ServiceAPI
    var nowPlayingMoviesSubject = CurrentValueSubject<NowPlayingMovieModel,APIError>(NowPlayingMovieModel(dates: Dates(maximum: "", minimum: ""), page: 0, results: [], totalPages: 0, totalResults: 0))
    
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
    
    func getPlayingMoviesFromPublisher()
    {
        api.getPlayingMovies { [weak self] result in
            switch result{
            case .success(let nowPlayingModel):
                self?.nowPlayingMoviesSubject.send(nowPlayingModel)
            case .failure(let error):
                self?.nowPlayingMoviesSubject.send(completion: .failure(error))
                print("get playing movies \(error.localizedDescription)")
            }
        }
    }
}
