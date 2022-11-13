//
//  Extensions.swift
//  mobiliumIbrahimErdogan
//
//  Created by İbrahim Erdogan on 13.11.2022.
//

import UIKit

extension ViewController : UICollectionViewDelegateFlowLayout
{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt insetForSectionAsection: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
  
   func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
       let size = sliderCollectionView.frame.size
       return CGSize(width: size.width, height: size.height)
   }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0.0
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0.0
   
    }
    
  
}


extension ViewController : UICollectionViewDelegate , UICollectionViewDataSource
{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if let count =  sliderViewModel.sliderMovies?.count
        {
        
            return count
        }
        else
        {
            return 0
        }
       
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = sliderCollectionView.dequeueReusableCell(withReuseIdentifier: "sliderCollectionCell", for: indexPath) as! SliderCollectionCellView
        let url = URL(string: "\(ImageUrlBase + (sliderViewModel.sliderMovies![indexPath.row].posterPath ?? ""))")!
            if let data = try? Data(contentsOf: url) {
                cell.sliderCollectionViewMovieImage.image = UIImage(data: data)
            }
        cell.sliderCollectionViewMovieImage.contentMode = .scaleToFill
        cell.sliderCollectionViewMovieName.text = sliderViewModel.sliderMovies![indexPath.row].title
        cell.sliderCollectionViewMovieDetail.text = sliderViewModel.sliderMovies![indexPath.row].overview
        sliderPager.currentPage = indexPath.row
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selectedRow = indexPath.row
           if let viewController = storyboard?.instantiateViewController(identifier: "DetailView") as? DetailViewController {
               viewController.movieId = sliderViewModel.sliderMovies![selectedRow].id
               navigationController?.pushViewController(viewController, animated: true)
           }
    }
    
    
}


