//
//  MovieDetailTest.swift
//  MoviesTests
//
//  Created by Mujahid Ali on 19/12/21.
//

import XCTest
import UIKit
@testable import Movies


class MovieDetailTest: XCTestCase {

    func test_load_view() {
        let vc = makeSut()
        XCTAssertNotNil(vc)
    }
    
    func test_iboutlets_are_connected_to_storyboard() {
        let vc = makeSut()
        XCTAssertNotNil(vc.tblView)
    }
    
    func test_number_of_cells_are_zero() {
        let vc = makeSut()
        vc.movieList = nil
        XCTAssertEqual(vc.tableView(vc.tblView, numberOfRowsInSection: 0), 0)
    }
    
    func test_number_of_cells_is_equall_to_1() {
        let vc = makeSut()
        vc.movieList = MoviesList(id: 1, original_title: "Hero", original_language: "hi", overview: "Good Movie", release_date: "12-01-2022", title: "Hero", vote_average: 7.8, backdrop_path: "/image", poster_path: "/image")
        XCTAssertEqual(vc.tableView(vc.tblView, numberOfRowsInSection: 0), 1)
    }
    
    func test_cell_1_heading() {
        let vc = makeSut()
        vc.movieList = MoviesList(id: 1, original_title: "Hero", original_language: "hi", overview: "Good Movie", release_date: "12-01-2022", title: "Hero", vote_average: 7.8, backdrop_path: "/image", poster_path: "/image")
        vc.tblView.reloadData()
        let cell1 = vc.tableView(vc.tblView, cellForRowAt: IndexPath(row: 0, section: 0)) as! MovieDetailCell
        XCTAssertEqual(cell1.lblHeading.text, "Hero")
    }
}

extension MovieDetailTest {
    func makeSut() -> MovieDetailVC {
        let vc = UIStoryboard(name: Constants.MAIN_STORYBOARD, bundle: nil).instantiateViewController(withIdentifier: MovieDetailVC.indentifire) as! MovieDetailVC
        _ = vc.view
        return vc
    }
}
