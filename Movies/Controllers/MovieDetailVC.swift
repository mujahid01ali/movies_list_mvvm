//
//  MoviewDetailVC.swift
//  Movies
//
//  Created by Mujahid Ali on 17/12/21.
//

import UIKit

class MovieDetailVC: UIViewController {
    @IBOutlet weak var tblView: UITableView!
    var movieList: MoviesList?
    override func viewDidLoad() {
        super.viewDidLoad()
        tblView.register(UINib(nibName: MovieDetailCell.indentifire, bundle: nil), forCellReuseIdentifier: MovieDetailCell.indentifire)
        tblView.reloadData()
    }
    func injectDependancy(movieData: MoviesList?) {
        self.movieList = movieData
    }
    @IBAction func btnActionClose(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
}
extension MovieDetailVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movieList != nil ? 1 : 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tblView.dequeueReusableCell(withIdentifier: MovieDetailCell.indentifire, for: indexPath) as? MovieDetailCell else {return UITableViewCell()}
        cell.cellConfig(res: movieList)
        return cell
    }
}
