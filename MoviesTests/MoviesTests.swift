//
//  MoviesTests.swift
//  MoviesTests
//
//  Created by Mujahid Ali on 17/12/21.
//

import XCTest
import UIKit
@testable import Movies

class MoviesTests: XCTestCase {
    //var mockNetworkService = MockNetwork()
    func test_load_view() {
        let vc = makeSut()
        XCTAssertNotNil(vc)
    }
    
    func test_iboutlets_are_connected_to_storyboard() {
        let vc = makeSut()
        XCTAssertNotNil(vc.tblView)
        XCTAssertNotNil(vc.btnClear)
        XCTAssertNotNil(vc.btnFillter2)
        XCTAssertNotNil(vc.btnFillter1)
    }
    
    func test_number_of_cells_are_zero() {
        let vc = makeSut()
        vc.viewModel?.moviesList = []
        XCTAssertEqual(vc.tableView(vc.tblView, numberOfRowsInSection: 0), 0)
    }
    
    func test_number_of_cells_is_equall_to_2() {
        let vc = makeSut()
        vc.viewModel?.moviesList = [MoviesList(id: 1, original_title: "Hero", original_language: "hi", overview: "Good Movie", release_date: "12-01-2022", title: "Hero", vote_average: 7.8, backdrop_path: "/image", poster_path: "/image"),MoviesList(id: 1, original_title: "Hero", original_language: "hi", overview: "Good Movie", release_date: "12-01-2022", title: "Hero", vote_average: 7.8, backdrop_path: "/image", poster_path: "/image")]
        XCTAssertEqual(vc.tableView(vc.tblView, numberOfRowsInSection: 0), 2)
    }
    
    func test_number_of_cells_is_equal_to_1() {
        let vc = makeSut()
        vc.viewModel?.moviesList = [MoviesList(id: 1, original_title: "Hero", original_language: "hi", overview: "Good Movie", release_date: "12-01-2022", title: "Hero", vote_average: 7.8, backdrop_path: "/image", poster_path: "/image")]
        XCTAssertEqual(vc.tableView(vc.tblView, numberOfRowsInSection: 0), 1)
    }
    
    func test_cell_1_heading() {
        let vc = makeSut()
        vc.viewModel?.moviesList = [MoviesList(id: 1, original_title: "Hero", original_language: "hi", overview: "Good Movie", release_date: "12-01-2022", title: "Hero", vote_average: 7.8, backdrop_path: "/image", poster_path: "/image")]
        vc.reloadTable()
        let cell1 = vc.tableView(vc.tblView, cellForRowAt: IndexPath(row: 0, section: 0)) as! MoviesListCell
        XCTAssertEqual(cell1.lblHeading.text, "Hero")
    }
    
    func test_cell_1_selected() {
        let vc = makeSut()
        vc.viewModel?.moviesList = [MoviesList(id: 1, original_title: "Hero", original_language: "hi", overview: "Good Movie", release_date: "12-01-2022", title: "Hero", vote_average: 7.8, backdrop_path: "/image", poster_path: "/image"),MoviesList(id: 1, original_title: "Hero", original_language: "hi", overview: "Good Movie", release_date: "12-01-2022", title: "Hero", vote_average: 7.8, backdrop_path: "/image", poster_path: "/image")]
        vc.reloadTable()
        vc.tableView(vc.tblView, didSelectRowAt: IndexPath(row: 0, section: 0))
        if let isSelected = vc.viewModel?.moviesList[0].isSelected {
            XCTAssertTrue(isSelected)
        }
        
    }

}
extension MoviesTests {
    func makeSut() -> ViewController {
        let vc = UIStoryboard(name: Constants.MAIN_STORYBOARD, bundle: nil).instantiateViewController(withIdentifier: ViewController.indentifire) as! ViewController
        let vm = MoviesListVM()
        vc.viewModel = vm
        _ = vc.view
        return vc
    }
}
//class MockNetwork: NetworkServiceProotocol {
//    var getMovieLListCallBack: (([MoviesList]?) -> Void)?
//    func apiCallForMovieList(param: [String : Any]?, success: @escaping ([MoviesList]?) -> (), failure: @escaping (String) -> ()) {
//        self.getMovieLListCallBack = success
//    }
//
//}

