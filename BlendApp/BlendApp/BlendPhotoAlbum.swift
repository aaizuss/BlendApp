//
//  BlendPhotoAlbum.swift
//  BlendApp
//
//  Created by Amanda Aizuss on 9/10/16.
//  Copyright © 2016 aaizuss. All rights reserved.
//

import Foundation
import Photos

class BlendPhotoAlbum: NSObject {
    static let albumName = "Blend"
    static let sharedInstance = BlendPhotoAlbum()
    
    var assetCollection: PHAssetCollection!
    
    override init() {
        super.init()
        if let assetCollection = fetchAssetCollectionForAlbum() {
            self.assetCollection = assetCollection
            return
        }
        
        if PHPhotoLibrary.authorizationStatus() != .authorized {
            PHPhotoLibrary.requestAuthorization({(status:PHAuthorizationStatus) in
                switch status {
                case .authorized:
                    print("authorized. creating album")
                    break
                default:
                    print("not authorized")
                    break
                }
            })
        }
        
        if PHPhotoLibrary.authorizationStatus() == .authorized {
            self.createAlbum()
        } else {
            PHPhotoLibrary.requestAuthorization(requestAuthorizationHandler)
        }
    }
    
    func requestAuthorizationHandler(status: PHAuthorizationStatus) {
        if PHPhotoLibrary.authorizationStatus() == .authorized {
            print("trying again to create the album")
            self.createAlbum()
        } else {
            print("should tell user that album creation failed because no authorization to use photos yet")
        }
    }
    
    func createAlbum() {
        PHPhotoLibrary.shared().performChanges({
        PHAssetCollectionChangeRequest.creationRequestForAssetCollection(withTitle: BlendPhotoAlbum.albumName)
        }) { success, error in
            if success {
                self.assetCollection = self.fetchAssetCollectionForAlbum()
            } else {
                print("error \(error)")
            }
        }
    }
    
    func fetchAssetCollectionForAlbum() -> PHAssetCollection! {
        let fetchOptions = PHFetchOptions()
        fetchOptions.predicate = NSPredicate(format: "title = %@", BlendPhotoAlbum.albumName)
        let collection = PHAssetCollection.fetchAssetCollections(with: .album, subtype: .any, options: fetchOptions)
        
        if let _: AnyObject = collection.firstObject {
            return collection.firstObject! as PHAssetCollection
        }
        return nil
    }
    
    func save(image: UIImage, metadata: NSDictionary) {
        if assetCollection == nil {
            return
        }
        
        PHPhotoLibrary.shared().performChanges({
            let assetChangeRequest = PHAssetChangeRequest.creationRequestForAsset(from: image)
            let assetPlaceholder = assetChangeRequest.placeholderForCreatedAsset
            let albumChangeRequest = PHAssetCollectionChangeRequest(for: self.assetCollection)
            let fastEnumeration = NSArray(array: [assetPlaceholder!] as [PHObjectPlaceholder])
            albumChangeRequest?.addAssets(fastEnumeration)
            }, completionHandler: nil)
    }
}
