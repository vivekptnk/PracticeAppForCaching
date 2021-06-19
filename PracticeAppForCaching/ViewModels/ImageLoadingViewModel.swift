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
    var cancellables = Set<AnyCancellable>()
    
    init (url : String) {
        urlString = url
        downloadImage()
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
                self?.image = returnedImage
            }
            .store(in: &cancellables)

    }
    
}
