//
//  MoviesVC.swift
//  DemoMovies
//
//  Created by Vijay A on 03/03/20.
//  Copyright © 2020 Goalsr. All rights reserved.
//

import UIKit

class MoviesVC: UIViewController {

    //MARK: Properties
   
    lazy var _tableView: UITableView = {
        let tv = UITableView(frame: self.view.bounds, style: .grouped)
        tv.delegate = self
        tv.dataSource = self
        return tv
    }()
    
    var viewModel = MoviesViewModel()
    var searchControl: UISearchController?

    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if let indexPath = self._tableView.indexPathForSelectedRow {
            self._tableView.deselectRow(at: indexPath, animated: true)
        }
    }
    
    func setupView(){
        self.view.backgroundColor = UIColor.white
        self.navigationItem.title = "Movies"
        self._tableView.register(UINib(nibName: "movieCell", bundle: nil), forCellReuseIdentifier: "movieCell")
        self.view.addSubview(_tableView)
        if !(UserDefaults.standard.value(forKey: "isAllreadyFetch") as?  Bool ?? false ) {
            APIManager.shared.getMoviesList { (response, error) in
                self.viewModel = MoviesViewModel()
                self._tableView.reloadData()
            }
        }
        setupSearchController()
    }
    
    func setupSearchController() {
        // Setup the Search Controller
        self.searchControl = UISearchController(searchResultsController: nil)
        self.searchControl?.searchResultsUpdater = self
        //searchControl.searchResultsUpdater = self
        definesPresentationContext = true
        // Search Controller
        searchControl?.obscuresBackgroundDuringPresentation = false
        
        searchControl?.searchBar.placeholder = "Search"
        //searchControl?.searchBar.barStyle = .black
        navigationItem.hidesSearchBarWhenScrolling = false
        
        searchControl?.hidesNavigationBarDuringPresentation = false
        //searchControl.searchBar.delegate = self
        navigationItem.searchController = searchControl
    }
    
      override func viewDidLayoutSubviews() {
          self._tableView.frame = self.view.bounds
          self._tableView.reloadData()
      }
}

//MARK: TableView DataSource Methods

extension MoviesVC: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.dataItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "movieCell") as! movieCell
        cell.accessoryType = .disclosureIndicator
        let movie = viewModel.dataItems[indexPath.row]
        cell.movieName.text = movie.title
        cell.ratingView.backgroundColor = CommonCode.shared.ratingColor(rating: movie.vote_average )
        cell.movieRating.text = "\(movie.vote_average)"
        ImageLoader.getImage(name: movie.poster_path ?? "", round: false, width: 300, height: 300, completion: { (image) in
                   cell.movieImage.image = image
         })
        return cell
    }
    
}


//MARK: TableView Delegate Methods

extension MoviesVC: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailsVC = MovieDetailsVC()
        let movie = viewModel.dataItems[indexPath.row]
        detailsVC.selectedMovie  = movie
        self.navigationController?.pushViewController(detailsVC, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 91
    }
}

//MARK: Search Delegate Methods


extension MoviesVC: UISearchResultsUpdating {
    
    func updateSearchResults(for searchController: UISearchController) {
        let text = searchController.searchBar.text ?? ""
        if !text.isEmpty {
            self.viewModel.filterMovies(searchedText:text)
        }else{
            self.viewModel.dataSetup()
        }
        self._tableView.reloadData()
    }
}
