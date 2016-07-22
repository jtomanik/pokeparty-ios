//
//  ImageService.swift
//  Switchboard
//
//  Created by Sebastian Osiński on 10.06.2016.
//  Copyright © 2016 nowthisnews. All rights reserved.
//

//import Kingfisher
//
//class ImageService {
//    
//    private let manager = KingfisherManager.sharedManager
//    
//    func getImageForURL(url: NSURL, progress: ImageProgressCallback, success: ImageSuccessCallback, failure: ImageFailureCallback) {
//       manager.retrieveImageWithURL(
//        url,
//        optionsInfo: nil,
//        progressBlock: { receivedSize, totalSize in
//            progress(Double(receivedSize) / Double(totalSize))
//        }, completionHandler: { image, error, _, _ in
//            if let error = error {
//                failure(error)
//                return
//            }
//            if let image = image {
//                success(image)
//                return
//            }
//        })
//    }
//}