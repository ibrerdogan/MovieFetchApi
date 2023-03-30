//
//  TableViewExtension.swift
//  mobiliumIbrahimErdogan
//
//  Created by İbrahim Erdogan on 13.11.2022.
//

import UIKit

extension ViewController : UITableViewDelegate , UITableViewDataSource
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       return tableMovies.count
      
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = listTableView.dequeueReusableCell(withIdentifier: "listTableViewCell", for: indexPath) as! ListTableViewCell
        
      
      

        DispatchQueue.main.async { [weak self] in
            let url = URL(string: "\(ImageUrlBase + (self?.tableMovies[indexPath.row].posterPath ?? ""))")!
            if let data = try? Data(contentsOf: url) {
                cell.listTableViewMovieImage.image = UIImage(data: data)
                cell.listTableViewMovieImage.layer.cornerRadius = 10
            }
        }
        cell.listTableViewMovieName.text = setTitle(name: tableMovies[indexPath.row].originalTitle ?? "",
                                                                   relase: tableMovies[indexPath.row].releaseDate ?? "10-10-2020")
        cell.listTableViewMovieDetail.text = tableMovies[indexPath.row].overview
        cell.listTableViewMovieDate.text = formatRelaseDate(relase: tableMovies[indexPath.row].releaseDate ?? "10-10-2020")
     
        
        //MARK: eğer istenirse layout sona indiği zaman yeni sayfayı ekleme yapabiliriz
        
       // if indexPath.row == tableViewModel.tableMovies.count - 1
       // {
       //     getUpcoming()
       // }
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 136
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedRow = indexPath.row
           if let viewController = storyboard?.instantiateViewController(identifier: "DetailView") as? DetailViewController {
               viewController.movieId = tableMovies[selectedRow].id
               viewController.movieDetailViewModel = MovieDetailViewModel(Id: tableMovies[selectedRow].id!)
               navigationController?.pushViewController(viewController, animated: true)
           }
    }
    
}
