//
//  ImageLoadingViewModel.swift
//  PracticeAppForCaching
//
//  Created by Vivek Pattanaik on 6/18/21.
//

import Foundation
import SwiftUI
import Combine

class ImageLoadingViewModel : ObservableObject {
    @Published var image : UIImage? = nil
    @Published var isLoading : Bool = false
    
    let urlString : String
    let imageKey : String
//    let manager = PhotoModelFIleManager.instance // for file manager
    let manager = PhotoModelCacheManager.instance // for cache
    var cancellables = Set<AnyCancellable>()
    
    init (url : String, key : String) {
        imageKey = key
        urlString = url
        downloadImage()
        getImage()
    }
    
    func getImage(){
        if let savedImage = manager.get(key: imageKey) {
            image = savedImage
            print("Getting saved image!")
        } else {
            downloadImage()
            print("Downloading Image Now")
        }
    }
    
    func downloadImage() {
        isLoading = true
        guard let url = URL(string: urlString) else {
            isLoading = false
            return}
        
        URLSession.shared.dataTaskPublisher(for: url)
            .map{ UIImage(data: $0.data)} // Practicing shorter code methods, down below is original method.
//            .map { (data, response) -> UIImage? in
//                return UIImage(data: data)
//            }
            .receive(on: DispatchQueue.main)
            .sink { [weak self] (_) in
                self?.isLoading = false
            } receiveValue: { [weak self] (returnedImage) in
                guard let self = self,
                      let image = returnedImage else {return}
                self.image = image
                self.manager.add(key: self.imageKey, value: image)
            }
            .store(in: &cancellables)

    }
    
}
