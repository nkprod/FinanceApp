//
//  ViewController.swift
//  Spotify_Embeded
//
//  Created by Chen Chen on 8/15/20.
//  Copyright © 2020 chen chen. All rights reserved.
//

import UIKit
import RxSwift
class MusicSearchViewController: UIViewController, UISearchBarDelegate, UITableViewDelegate {
    
    @IBOutlet weak var tblView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        searchBar.accessibilityTraits = UIAccessibilityTraits.searchField
        searchBar.accessibilityIdentifier = "searchBar" 
        searchBar.delegate = self
    }

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let str = searchBar.text else{return}
        let st = UIStoryboard.init(name: "Music", bundle: nil)
        let vc = st.instantiateViewController(withIdentifier: "TrackResultViewController") as! TrackResultViewController
        vc.name = searchBar.text
        present(vc, animated: true)
        
    }

    
}

