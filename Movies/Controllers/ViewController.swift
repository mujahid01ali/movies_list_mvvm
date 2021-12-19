//
//  ViewController.swift
//  Movies
//
//  Created by Mujahid Ali on 17/12/21.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var tblView: UITableView!
    @IBOutlet weak var btnFillter1: UIButton!
    @IBOutlet weak var btnFillter2: UIButton!
    @IBOutlet weak var btnClear: UIButton!
    var viewModel: MoviesListVM?

    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = MoviesListVM()
        viewModel?.delegate = self
        Connectivity.isConnectedToInternet == true ? viewModel?.getMoviesList(param: nil, path: Constants.MOVIEW_LIST_END_POINTS) : viewModel?.getListFromCoreData()
        
        tblView.register(UINib(nibName: MoviesListCell.indentifire, bundle: nil), forCellReuseIdentifier: MoviesListCell.indentifire)
        tblView.reloadData()
    }
    @IBAction func btnActionFilter(_ sender: UIButton) {
        switch sender {
        case btnFillter1:
            viewModel?.getFilterData(val1: 0.0, val2: 5.0, isClear: false)
        case btnFillter2:
            viewModel?.getFilterData(val1: 5.1, val2: 10.0, isClear: false)
        case btnClear:
            viewModel?.getFilterData(val1: 0.0, val2: 0.0, isClear: true)
        default:
            break
        }
    }
    
}
extension ViewController: UITableViewDelegate, UITableViewDataSource, CallBackProtocols {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.moviesCount() ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tblView.dequeueReusableCell(withIdentifier: MoviesListCell.indentifire, for: indexPath) as? MoviesListCell else {return UITableViewCell()}
        cell.cellConfig(res: viewModel?.getMovieAtIndex(index: indexPath.row))
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let vc = UIStoryboard(name: Constants.MAIN_STORYBOARD, bundle: nil).instantiateViewController(withIdentifier: MovieDetailVC.indentifire) as? MovieDetailVC else {return}
        viewModel?.moviesList[indexPath.row].isSelected = true
        vc.injectDependancy(movieData: viewModel?.getMovieAtIndex(index: indexPath.row))
        vc.modalTransitionStyle = .coverVertical
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true, completion: nil)
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
    
    func reloadTable() {
        tblView.reloadData()
    }
}

