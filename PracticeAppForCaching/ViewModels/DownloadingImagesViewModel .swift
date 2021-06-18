//
//  DownloadingImagesViewModel .swift
//  PracticeAppForCaching
//
//  Created by Vivek Pattanaik on 6/18/21.
//

import Foundation
import Combine

class DownloadingImagesViewModel : ObservableObject {
    @Published  var dataArray : [PhotoModel] = []
    var cancellables = Set<AnyCancellable>()
    let dataService = PhotoModelDataService.instance
    
    init() {
        addSubscriber()
    }
    
    func addSubscriber() {
        dataService.$photoModels
            .sink {[weak self] (returnedPhotoModels) in
                self?.dataArray = returnedPhotoModels
            }
            .store(in: &cancellables)
    }
}
