//
//  DetailViewController.swift
//  mobiliumIbrahimErdogan
//
//  Created by İbrahim Erdogan on 13.11.2022.
//

import UIKit
import Combine

class DetailViewController: UIViewController {

    var movieId : Int?
    var movieDetailViewModel : MovieDetailViewModel!
    
    var movie = MovieBaseModel(adult: nil, backdropPath: nil, belongsToCollection: nil, budget: nil, genres: nil, homepage: nil, id: nil, originalTitle: nil, imdbID: nil, originalLanguage: nil, overview: nil, popularity: nil, posterPath: nil, productionCompanies: nil, productionCountries: nil, releaseDate: nil, revenue: nil, runtime: nil, spokenLanguages: nil, title: nil, status: nil, tagline: nil, video: nil, voteAverage: nil, voteCount: nil)
   
    @IBOutlet weak var movieImage: UIImageView!
    @IBOutlet weak var movieRelaseDate: UILabel!
    @IBOutlet weak var movieRate: UILabel!
    @IBOutlet weak var movieDetail: UITextView!
    @IBOutlet weak var movieName: UILabel!
    private var subscriber = Set<AnyCancellable>()
   
  //  required init?(coder aDecoder: NSCoder , id : Int?) {
  //
  //      movieDetailViewModel = MovieDetailViewModel(Id: id ?? 0)
  //      super.init(coder: aDecoder)
  //  }
  //
  //  required init?(coder: NSCoder) {
  //      fatalError("init(coder:) has not been implemented")
  //  }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = false
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "chevron.left"), style: .done, target: self, action: #selector(backButtonTapped))
        movieImage.contentMode = .scaleToFill
       //getMovieDetail()
        
        getMovieDetailWithPublisher()
        observeMovieDetailWithPublisher()
        
    }
    
    @objc func backButtonTapped()
    {
      
        self.navigationController?.popViewController(animated: true)
    }
    
    func getMovieDetail()
    {
        let movieDetailViewModel = MovieDetailViewModel(Id: movieId ?? 0)
        movieDetailViewModel.getMovieDetail { [weak self] errorString in
            if let errorString = errorString {
                let alert = UIAlertController(title: "Movie Detail FetchError", message: errorString , preferredStyle: UIAlertController.Style.alert)
                       alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
                       self?.present(alert, animated: true, completion: nil)
            }
            else
            {
                if let movie = movieDetailViewModel.movie
                 {
                    let url = URL(string: "\(ImageUrlBase + (movie.posterPath ?? " "))")!
                        if let data = try? Data(contentsOf: url) {
                            self?.movieImage.image = UIImage(data: data)
                            self?.movieRate.text = rateFormat(value: movie.voteAverage!)
                            self?.movieDetail.text = movie.overview
                            self?.movieRelaseDate.text = formatRelaseDate(relase: movie.releaseDate ?? "10-10-2020" )
                            self?.movieName.text = setTitle(name: movie.title ?? "", relase: movie.releaseDate ?? "10-10-2020")
                            self?.title = setTitle(name: movie.title ?? "", relase: movie.releaseDate ?? "10-10-2020")
                        }
                }
            }
        }
    }
    
    func getMovieDetailWithPublisher()
    {
        movieDetailViewModel.getMovieDetailWithPublisher()
    }
    
    func observeMovieDetailWithPublisher()
    {
       
        movieDetailViewModel.movieDetailObj
            .receive(on: DispatchQueue.main)
            .sink { receiveCompletion in
            switch receiveCompletion
            {
            case .failure(let error):
                print(error.localizedDescription)
            case .finished:
                print("finish")
            }
        } receiveValue: { [weak self] receivedMovie in
            if receivedMovie.id != nil
            {
                let url = URL(string: "\(ImageUrlBase + (receivedMovie.posterPath ?? " "))")
                    if let data = try? Data(contentsOf: url!) {
                        self?.movieImage.image = UIImage(data: data)
                        self?.movieRate.text = rateFormat(value: receivedMovie.voteAverage!)
                        self?.movieDetail.text = receivedMovie.overview
                        self?.movieRelaseDate.text = formatRelaseDate(relase: receivedMovie.releaseDate ?? "10-10-2020" )
                        self?.movieName.text = setTitle(name: receivedMovie.title ?? "", relase: receivedMovie.releaseDate ?? "10-10-2020")
                        self?.title = setTitle(name: receivedMovie.title ?? "", relase: receivedMovie.releaseDate ?? "10-10-2020")
                    }
            }
        }
        .store(in: &subscriber)

    }
    
   
    
  
    
   

}
