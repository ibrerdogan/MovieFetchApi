//
//  ViewController.swift
//  mobiliumIbrahimErdogan
//
//  Created by İbrahim Erdogan on 12.11.2022.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var sliderCollectionView: UICollectionView!
    @IBOutlet weak var listTableView: UITableView!
    @IBOutlet weak var sliderPager: UIPageControl!
    
    private let refreshControl = UIRefreshControl()
    
    var api = ServiceAPI()
    var sliderViewModel : SliderViewModel
    var tableViewModel : TableViewModel

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
        getNowPlayingMovies()
        getUpcomingMovies()
       
        

      
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
      
        getUpcomingMovies()
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

}
