//
//  MovieDetailsVC.swift
//  DemoMovies
//
//  Created by Vijay A on 03/03/20.
//  Copyright © 2020 Goalsr. All rights reserved.
//

import UIKit

class MovieDetailsVC: UIViewController {

    //MARK: Properties
   
    lazy var _tableView: UITableView = {
        let tv = UITableView(frame: self.view.bounds, style: .plain)
        tv.delegate = self
        tv.dataSource = self
        tv.allowsSelection = false
        return tv
    }()
    var selectedMovie : Movies?
    var viewModel = MovieDetailsViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    func setupView(){
        self.navigationItem.title = "Movie Details"
        self.view.addSubview(_tableView)
        self._tableView.separatorStyle = .none
        viewModel.dataSetup(movieId: "\(selectedMovie!.id)")
        if viewModel.dataDetails == nil{
            APIManager.shared.getMoviesDetails(movieId: "\(selectedMovie!.id)") { (response, error) in
                self.viewModel.dataSetup(movieId: "\(self.selectedMovie!.id)")
                self._tableView.reloadData()
            }
        }
    }
    
      override func viewDidLayoutSubviews() {
          self._tableView.frame = self.view.bounds
          self._tableView.reloadData()
      }
    
    func getAttributedString(text: String, attributes:[NSAttributedString.Key: Any]) -> NSMutableAttributedString{
        var attributedString = NSMutableAttributedString()
        let text = text
        let attributes = attributes
        attributedString = NSMutableAttributedString(string: text, attributes: attributes)
        return attributedString
    }
}

//MARK: TableView DataSource Methods

extension MovieDetailsVC: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        if viewModel.dataDetails == nil {
            return 0
        }
        return 3
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
            case 0,1:
                 return 1
            default:
                 return 6
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell.init(style: .default, reuseIdentifier: "Cell")
        switch indexPath.section {
        case 0:
            let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: 200))
            ImageLoader.getImage(name: viewModel.dataDetails?.poster_path ?? "", round: false, width: Int(self.view.frame.width), height:200 , completion: { (image) in
                    imageView.image = image
            })
            imageView.contentMode = .scaleAspectFit
            cell.addSubview(imageView)
        case 1:
            cell.textLabel?.text = viewModel.dataDetails?.original_title
            cell.textLabel?.textAlignment = .center
            cell.textLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        case 2:
            var titleText = ""
            var valueText = ""
            
            switch indexPath.row {
            case 0:
                titleText = "Duration : "
                let durationTime = CommonCode.shared.durationTime(time: viewModel.dataDetails?.runtime ?? 0)
                valueText = durationTime
            case 1:
                titleText = "Release Date : "
                valueText = viewModel.dataDetails?.release_date ?? "Today"
            case 2:
                titleText = "Languages : "
                let languages = viewModel.dataDetails?.language?.allObjects as? [Languages] ?? []
                let laguageTextArray : [String] = languages.compactMap { $0.name ?? "" }
                valueText =  laguageTextArray.joined(separator: ",")
            case 3:
                titleText = "Genres : "
                let genres = viewModel.dataDetails?.genres?.allObjects as? [Genres] ?? []
                let genresTextArray : [String] = genres.compactMap { $0.name ?? "" }
                valueText =  genresTextArray.joined(separator: ",")
            case 4:
                titleText = "Rating : "
                valueText =  "★ \(viewModel.dataDetails!.vote_average) & \(viewModel.dataDetails!.vote_count) votes"
            case 5:
                titleText = "Overview : \n"
                valueText = viewModel.dataDetails!.overview ?? ""
                               
            default:
                break
            }
            
            let mutableAttributedString = NSMutableAttributedString()
            let title = self.getAttributedString(text: titleText, attributes: [.font: UIFont.systemFont(ofSize: 13, weight: .semibold), .foregroundColor: UIColor.black])
            mutableAttributedString.append(title)
                                         
            let detail = self.getAttributedString(text: valueText, attributes: [.font: UIFont.systemFont(ofSize: 13, weight: .regular), .foregroundColor: UIColor.black])
            mutableAttributedString.append(detail)
            cell.textLabel?.attributedText = mutableAttributedString
            cell.textLabel?.numberOfLines = 0
            cell.textLabel?.textAlignment = .center
        default:
            break
        }
        return cell
    }
}


//MARK: TableView Delegate Methods

extension MovieDetailsVC: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.section {
            case 0:
                return 200
            case 1:
                return 44
           default:
            return UITableView.automaticDimension
        }
    }
}


