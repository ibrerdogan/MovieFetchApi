//
//  DetailViewController.swift
//  mobiliumIbrahimErdogan
//
//  Created by İbrahim Erdogan on 13.11.2022.
//

import UIKit

class DetailViewController: UIViewController {

    var movieId : Int?
   
    
   
   
    @IBOutlet weak var movieImage: UIImageView!
    @IBOutlet weak var movieRelaseDate: UILabel!
    @IBOutlet weak var movieRate: UILabel!
    @IBOutlet weak var movieDetail: UITextView!
    @IBOutlet weak var movieName: UILabel!
 
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = false
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "chevron.left"), style: .done, target: self, action: #selector(backButtonTapped))
        movieImage.contentMode = .scaleToFill
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
    
    @objc func backButtonTapped()
    {
      
        self.navigationController?.popViewController(animated: true)
    }
    
    
   
    
  
    
   

}
