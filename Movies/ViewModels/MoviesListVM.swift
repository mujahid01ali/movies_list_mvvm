//
//  MoviesListVM.swift
//  Movies
//
//  Created by Mujahid Ali on 17/12/21.
//

import Foundation
import Alamofire
import CoreData

protocol CallBackProtocols {
    func reloadTable()
}

class MoviesListVM {
    let context: NSManagedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var delegate:CallBackProtocols?
    var moviesList: [MoviesList] = []
    var networkService: NetworkServiceProotocol?
    var originalMoviesList: [MoviesList] = []
    init(networkManager: NetworkServiceProotocol = NetworkServiceManager()) {
        self.networkService = networkManager
    }
    func getMoviesList(param: [String:Any]? = nil, path: String? = nil) {
        
        networkService?.apiCallForMovieList(param: param, success: { movies in
            if let list = movies {
                self.deleteList()
                self.moviesList = list
                self.originalMoviesList = self.moviesList
                DispatchQueue.global().asyncAfter(deadline: .now() + 5) {
                    self.saveUserData(self.moviesList)
                }
                self.delegate?.reloadTable()
            } else {
                self.getListFromCoreData()
            }
        }, failure: { str in
            self.getListFromCoreData()
        })
    }
    
    func getListFromCoreData() {
        moviesList.removeAll()
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: Constants.EntityKeys.MOVIES_ENTITY_KEY)
        request.returnsObjectsAsFaults = false
        do {
            let results = try context.fetch(request) as? [NSManagedObject]
            if let res = results {
                for result in res {
                    var user = MoviesList()
                    if let id = result.value(forKey: Constants.Keys.ID_KEY) as? Int {
                        user.id = id
                    }
                    if let overview = result.value(forKey: Constants.Keys.OVERVIEW_KEY) as? String {
                        user.overview = overview
                    }
                    if let original_title = result.value(forKey: Constants.Keys.ORIGINAL_TITLE_KEY) as? String {
                        user.original_title = original_title
                    }
                    if let release_date = result.value(forKey: Constants.Keys.RELEASE_DATE_KEY) as? String {
                        user.release_date = release_date
                    }
                    if let vote_average = result.value(forKey: Constants.Keys.VOTE_AVERAGE_KEY) as? Float64 {
                        user.vote_average = vote_average
                    }
                    if let title = result.value(forKey: Constants.Keys.TITLE_KEY) as? String {
                        user.title = title
                    }
                    if let backdrop_path = result.value(forKey: Constants.Keys.BACKDROP_PATH_KEY) as? String {
                        user.backdrop_path = backdrop_path
                    }
                    if let poster_path = result.value(forKey: Constants.Keys.POSTER_PATH_KEY) as? String {
                        user.poster_path = poster_path
                    }
                    if let original_language = result.value(forKey: Constants.Keys.ORIGINAL_LANGUAGE_KEY) as? String {
                        user.original_language = original_language
                    }
                    moviesList.append(user)
                }
                originalMoviesList = moviesList
                self.delegate?.reloadTable()
            }
        } catch {
            print(Constants.Error_Retrieving)
        }
    }
    
    func deleteList() {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: Constants.EntityKeys.MOVIES_ENTITY_KEY)
        if  let result = try?  context.fetch(fetchRequest){
            for object in result {
                do {
                    context.delete(object as! NSManagedObject)
                    try context.save()
                } catch {
                    //
                }
            }
        }
    }
        
    func saveUserData(_ users: [MoviesList]) {
        for user in users {
            let newUser = NSEntityDescription.insertNewObject(forEntityName: Constants.EntityKeys.MOVIES_ENTITY_KEY, into: context)
            newUser.setValue(user.id, forKey: Constants.Keys.ID_KEY)
            newUser.setValue(user.original_language, forKey: Constants.Keys.ORIGINAL_LANGUAGE_KEY)
            newUser.setValue(user.original_title, forKey: Constants.Keys.ORIGINAL_TITLE_KEY)
            newUser.setValue(user.release_date, forKey: Constants.Keys.RELEASE_DATE_KEY)
            newUser.setValue(user.poster_path, forKey: Constants.Keys.POSTER_PATH_KEY)
            newUser.setValue(user.overview, forKey: Constants.Keys.OVERVIEW_KEY)
            newUser.setValue(user.backdrop_path, forKey: Constants.Keys.BACKDROP_PATH_KEY)
            newUser.setValue(user.vote_average, forKey: Constants.Keys.VOTE_AVERAGE_KEY)
            newUser.setValue(user.title, forKey: Constants.Keys.TITLE_KEY)
        }
        do {
            try context.save()
        } catch {
            print(Constants.Error_Saving)
        }
    }
    
    func getMovieAtIndex(index: Int) -> MoviesList? {
        return moviesList[index]
    }
    func moviesCount() -> Int? {
        return moviesList.count
    }
    
    func getFilterData(val1: Float64, val2: Float64 , isClear: Bool? = false) {
        if isClear == true {
            moviesList = originalMoviesList
        } else {
            moviesList = originalMoviesList
            moviesList = moviesList.filter( {(($0.vote_average ?? 0) >= val1 && ($0.vote_average ?? 0) <= val2)})
        }
        delegate?.reloadTable()
    }
}

protocol NetworkServiceProotocol {
    func apiCallForMovieList(param: [String:Any]?, success: @escaping ([MoviesList]?) -> (), failure: @escaping (String) -> ())
}

class NetworkServiceManager: NetworkServiceProotocol {
    
    var networkService: NetworkService?
    init() {
        self.networkService = NetworkService()
    }
    func apiCallForMovieList(param: [String : Any]?, success: @escaping ([MoviesList]?) -> (), failure: @escaping (String) -> ()) {
        networkService?.callApi(path: Constants.MOVIEW_LIST_END_POINTS, requestType: .get, param: param ?? [:], success: { respoonse in
            if let responseData = respoonse {
                let parsedResult = try? JSONDecoder().decode(MoviesListRespoonse.self, from: responseData)
                if let list = parsedResult?.results {
                    success(list)
                } else {
                    failure(Constants.SOMETHING_WENT_WRONG)
                }
            }else {
                failure(Constants.SOMETHING_WENT_WRONG)
            }
        }, failure: { str in
            failure(str)
        })
    }
}

