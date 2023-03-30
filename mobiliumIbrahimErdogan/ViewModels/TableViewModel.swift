//
//  TableViewModel.swift
//  mobiliumIbrahimErdogan
//
//  Created by İbrahim Erdogan on 13.11.2022.
//

import Foundation
import Combine


class TableViewModel{
    var tableMovies : [MovieBaseModel] = []
    var api : ServiceAPI
    var page = 0
    var upCommingMoviesSubject = CurrentValueSubject<UpComingMovieModel,APIError>(UpComingMovieModel(dates: Dates(maximum: "", minimum: ""), page: 0, results: [], totalPages: 0, totalResults: 0))
    
    init(with api : ServiceAPI)
    {
        self.api = api
    }
    
    func getUpcomingMovies(completed : @escaping (_ errorString : String?)->())
    {
        self.page += 1
        print("\(page)")
        api.getUpcomingMovies(page: page) { [weak self] result in
            switch result{
            case .success(let upcomingMovie):
                self?.tableMovies = upcomingMovie.results
                completed(nil)
            case .failure(let error):
                completed(error.localizedDescription)
            }
        }
    }
    
    func getUpcomingMoviesFromPublisher()
    {
        self.page += 1
        api.getUpcomingMovies(page: page) { [weak self] result in
            switch result{
            case.success(let upCommingMovie):
                self?.upCommingMoviesSubject.send(upCommingMovie)
            case .failure(let error):
                print("table view error \(error.localizedDescription)")
                self?.upCommingMoviesSubject.send(completion: .failure(error))
                
            }
        }
    }
    
    
    
}

