//
//  ViewController.swift
//  MyMovieApp
//
//  Created by Sheryl Evangelene Pulikandala on 8/14/20.
//  Copyright © 2020 Sheryl Evangelene Pulikandala. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import AVKit
import AVFoundation
import SafariServices


class MovieViewController: UIViewController, UITextFieldDelegate {
    @IBOutlet weak var myTable: UITableView!
    

    
    @IBOutlet weak var textfield: UITextField!
    let disposeBag = DisposeBag()
        let viewModel = MovieViewModel()

        override func viewDidLoad() {
          super.viewDidLoad()
            navigationItem.title = "Top Rated Movies"
          setUpViewBindings()
          setUpSubscription()
        }
        
        func setUpViewBindings() {
          viewModel.dataSource.bind(to: self.myTable.rx.items) { (tableView, row, element) in
              let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! MyCell
//            cell.MovieTitle.text = "\(element.title) @ row \(row)"
            cell.ImageTitile.text = "\(element.title)"
            let poster = element.poster_path.replacingOccurrences(of: ".jpg", with: "")
            let poster1 = poster.replacingOccurrences(of: "\\", with: "")
            let posterImg = poster1.replacingOccurrences(of: "/", with: "")
            print(posterImg)
            cell.imagePoster.image = UIImage(named: posterImg)
            cell.Overview.text = "\(element.overview)"
//            print(cell.textLabel?.text)
            cell.Populatity.text = "Popularity: \(element.popularity)"
            cell.Rating.text = "Rating: \(element.vote_average)"
            cell.releaseDate.text = "Release Date: \(element.release_date)"
            cell.voteCount.text = "Vote Count: \(element.vote_count)"
            return cell ?? UITableViewCell()
          }
          .disposed(by: self.disposeBag)
            
//            myTable.rx.modelSelected(MovieInfo.self).subscribe(onNext: { item in
//                print("SelectedItem: \(item.id)")
//            }).disposed(by: disposeBag)
            
         myTable.rx.modelSelected(MovieInfo.self)
            .map{ _ in URL(string: "https://www.themoviedb.org/movie/top-rated") }
            .subscribe(onNext: { [weak self] url in
               guard let url = url else {
                 return
               }
               self?.present(SFSafariViewController(url: url), animated: true)
         }).disposed(by: disposeBag)
        }
        
        func setUpSubscription() {
          callAPI(withUrlString: "https://api.themoviedb.org/3/movie/top_rated?api_key=6a24c2c42cad80dbfc4195f6bb695d57&language=en-US&page=1")
        }

        public func callAPI(withUrlString : String) {
          self.viewModel.callAPIFromViewModel(withUrlString: withUrlString)
          }
    

}







