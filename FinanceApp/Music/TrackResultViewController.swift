//
//  TrackResultViewController.swift
//  Spotify_Embeded
//
//  Created by Chen Chen on 8/16/20.
//  Copyright © 2020 chen chen. All rights reserved.
//

import UIKit
import RxSwift
import SafariServices
class TrackResultViewController: UIViewController, UITableViewDelegate {
    @IBOutlet weak var tblView: UITableView!
    var name :String!
    let disposeBag = DisposeBag()
    override func viewDidLoad() {
        super.viewDidLoad()
        search(trackName: name)
        //tblView.delegate = self
        // Do any additional setup after loading the view.
        
    }
    

    func search(trackName: String) {
        let vm = MusicViewModel()
        let escaped = trackName.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
        vm.callAPI(urlString: "https://api.spotify.com/v1/search?q=\(escaped)&type=track&limit=50")
        vm.datasource.bind(to: self.tblView.rx.items) { (tableview, row, element) in
            let cell = tableview.dequeueReusableCell(withIdentifier: "cell") as! MusicTableViewCell
            cell.Album.text = element.album.name
            cell.Artist.text = element.artists[0].name
            cell.id = element.externalUrls.spotify
            
            
            
            URLSession.shared.dataTask(with: URL(string: element.album.images[0].url)!) { (data, response, error) in
                guard let data = data, error == nil else { return }
                DispatchQueue.main.async() { [weak self] in
                    cell.imgV.image = UIImage(data: data)
                }
                
            }.resume()
            return cell
        }.disposed(by: disposeBag)
        
        tblView.rx.itemSelected
        .subscribe(onNext: { [weak self] indexPath in
//          let cell = self?.tableview.cellForRow(at: indexPath) as? SomeCellClass
//          cell.button.isEnabled = false
            let cell = self!.tblView.cellForRow(at: indexPath) as! MusicTableViewCell
            if let url = URL(string: cell.id) {
                let config = SFSafariViewController.Configuration()
                config.entersReaderIfAvailable = true

                let vc = SFSafariViewController(url: url, configuration: config)
                self!.present(vc, animated: true)
            }

            
        }).addDisposableTo(disposeBag)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
