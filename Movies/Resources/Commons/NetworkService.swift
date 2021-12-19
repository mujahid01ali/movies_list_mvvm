//
//  NetworkService.swift
//  Movies
//
//  Created by Mujahid Ali on 19/12/21.
//

import Foundation
import Alamofire

class NetworkService {
    func callApi(path: String?, requestType: Alamofire.HTTPMethod, param: [String:Any]?, success: @escaping (Data?) -> (), failure: @escaping (String) -> ()) {
        if !Connectivity.isConnectedToInternet {
            failure(Constants.NO_INTERNET_CONNNECTION)
        } else {
            
            guard let url = path else {
                failure(Constants.INCORRECT_URL)
                return
            }
            let endpoint = Constants.BASE_URL + url
            guard let encodedUrl = endpoint.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else {
                failure(Constants.INCORRECT_URL)
                return
            }
            var parameters: [String:Any] = [:]
            parameters[Constants.Keys.API_KEY] = Constants.API_KEY
            let newParam = parameters.merging(param ?? [:]) { (_, new) in new }
            AF.request(encodedUrl, method: requestType, parameters: newParam).cURLDescription{print($0)}.responseData { response in
                switch response.result {
                case .success:
                    success(response.data)
                case let .failure(error):
                    failure(error.localizedDescription)
                }
            }
        }
    }
}
