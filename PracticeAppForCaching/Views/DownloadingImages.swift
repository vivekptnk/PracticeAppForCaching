//
//  DownloadingImages.swift
//  PracticeAppForCaching
//
//  Created by Vivek Pattanaik on 6/18/21.
//

import SwiftUI

// Codable
// Understanding Background threads
// Weak Self
// Combine
// Publisher and SubScribers
// File Manager
// NSCache


// Sample Pictures from Json Placeholder website
// URL
/*
 https://jsonplaceholder.typicode.com/photos
*/

struct DownloadingImages: View {
    
    @StateObject var vm = DownloadingImagesViewModel()
    
    var body: some View {
        NavigationView {
            List {
                ForEach(vm.dataArray) { model in
                    Text(model.title)
                }
            }
            .navigationTitle("Downloading Images")
        }
    }
}

struct DownloadingImages_Previews: PreviewProvider {
    static var previews: some View {
        DownloadingImages()
    }
}
