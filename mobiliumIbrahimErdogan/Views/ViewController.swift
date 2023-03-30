//
//  ViewController.swift
//  mobiliumIbrahimErdogan
//
//  Created by İbrahim Erdogan on 12.11.2022.
//

import UIKit
import Combine
class ViewController: UIViewController {

    @IBOutlet weak var sliderCollectionView: UICollectionView!
    @IBOutlet weak var listTableView: UITableView!
    @IBOutlet weak var sliderPager: UIPageControl!
    
    private let refreshControl = UIRefreshControl()
    
    var api = ServiceAPI()
    var sliderViewModel : SliderViewModel
    var tableViewModel : TableViewModel
    
    //
    var sliderMovies : [MovieBaseModel] = []
    var sliderSubscriber : AnyCancellable?
    var tableMovies : [MovieBaseModel] = []
    var tableSubscriber : AnyCancellable?
    //

    required init?(coder aDecoder: NSCoder) {
        sliderViewModel = SliderViewModel(with: api)
        tableViewModel = TableViewModel(with: api)
        super.init(coder: aDecoder)
    }
   
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        sliderPager.currentPage = 0
        sliderPager.numberOfPages = 20
        configureCollectionView()
        configureTableView()
       // getNowPlayingMovies()
      //  getUpcomingMovies()
        getNowPlayingMoviesFromPublisher()
        observePlayingMoviesFromPublisher()
        getUpcomingMoviesFromPubliser()
        observeUpcomingMoviesFromPublisher()
        

      
    }
    
    func configureCollectionView()
    {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: sliderCollectionView.frame.width, height: sliderCollectionView.frame.height)
        sliderCollectionView.collectionViewLayout = layout
        sliderCollectionView.delegate = self
        sliderCollectionView.dataSource = self
    }
    
    func configureTableView()
    {
        listTableView.addSubview(refreshControl)
        refreshControl.addTarget(self, action: #selector(refreshTableView(_:)), for: .valueChanged)
        listTableView.delegate = self
        listTableView.dataSource = self
    }
    @objc private func refreshTableView(_ sender: Any) {
      
       // getUpcomingMovies()
        getUpcomingMoviesFromPubliser()
        observeUpcomingMoviesFromPublisher()
        self
            .refreshControl.endRefreshing()
    }
    
    
    
    
    func getUpcomingMovies()
    {
        tableViewModel.getUpcomingMovies{ [weak self] errorString in
            if let errorString = errorString {
                let alert = UIAlertController(title: "Table FetchError", message: errorString , preferredStyle: UIAlertController.Style.alert)
                       alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
                       self?.present(alert, animated: true, completion: nil)
            }
            else
            {
                DispatchQueue.main.async {
                    self?.listTableView.reloadData()
                    self?.refreshControl.endRefreshing()
                }
            }
        }
    }
    
    func getUpcomingMoviesFromPubliser()
    {
        tableViewModel.getUpcomingMoviesFromPublisher()
    }
    
    func  observeUpcomingMoviesFromPublisher()
    {
        tableSubscriber = tableViewModel.upCommingMoviesSubject
            .receive(on: DispatchQueue.main)
            .dropFirst()
            .sink { receivedResult in
                switch receivedResult {
                case .failure(let error):
                    print(error.localizedDescription)
                case .finished:
                    print("finished")
                }
            } receiveValue: {  [weak self] upComingModel in
                self?.tableMovies = upComingModel.results
                self?.listTableView.reloadData()
            }

    }
    
    func getNowPlayingMovies()
    {
        sliderViewModel.getPlayingMovies { [weak self] errorString in
            if let errorString = errorString {
                let alert = UIAlertController(title: "Slider FetchError", message: errorString , preferredStyle: UIAlertController.Style.alert)
                       alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
                       self?.present(alert, animated: true, completion: nil)
            }
            else
            {
                
                self?.sliderCollectionView.reloadData()
            }
        }
    }
    
    func getNowPlayingMoviesFromPublisher()
    {
        sliderViewModel.getPlayingMoviesFromPublisher()
    }
    func observePlayingMoviesFromPublisher()
    {
       sliderSubscriber = sliderViewModel.nowPlayingMoviesSubject
            .receive(on: DispatchQueue.main)
            .dropFirst()
            .sink { receivedResult in
                switch receivedResult {
                case .failure(let error):
                    print(error.localizedDescription)
                case .finished:
                    print("")
                }
            } receiveValue: { [weak self] nowPlayingModel in
                self?.sliderMovies = nowPlayingModel.results
                self?.sliderCollectionView.reloadData()
            }

    }

}
