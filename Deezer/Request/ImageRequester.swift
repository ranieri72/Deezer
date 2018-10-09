//
//  ImageRequester.swift
//  Deezer
//
//  Created by Ranieri Aguiar on 09/10/18.
//  Copyright © 2018 Ranieri. All rights reserved.
//

import Foundation
import AlamofireImage
import Alamofire

typealias ImageCompletion = (_ response: ImageResponse) -> Void

class ImageRequester {
    
    init() {
        Alamofire.DataRequest.addAcceptableImageContentTypes(["image/jpg", "image/png", "image/jpeg"])
    }
    
    func getImage(url: String, completion: @escaping ImageCompletion) {
        let imgView = UIImageView()
        guard let urlRequest = URL(string: url) else { return }
        
        imgView.af_setImage(withURL: urlRequest, placeholderImage: nil, filter: nil, progress: nil, progressQueue: DispatchQueue.main, imageTransition: UIImageView.ImageTransition.noTransition, runImageTransitionIfCached: true){ (response) in
            
            switch response.result {
            case .success(let value):
                //print(String(format: "Request imageUrl: %@", url))
                completion(.success(model: value))
            case .failure(let error):
                let errorCode = error._code
                if errorCode == -999 || errorCode == 0 {
                    let erro = ServerError(description: response.result.error.debugDescription, errorCode: errorCode)
                    completion(.downloadCanceled(description: erro))
                }
            }
        }
    }
}

enum ImageResponse {
    case success(model: UIImage)
    case serverError(description: ServerError)
    case timeOut(description: ServerError)
    case noConnection(description: ServerError)
    case downloadCanceled(description: ServerError)
    case invalidResponse
}

struct ServerError {
    var description: String
    var errorCode: Int
}
