//
//  ViewController.swift
//  Randog
//
//  Created by user on 09.04.2020.
//  Copyright © 2020 ulkoart. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var pickerView: UIPickerView!
    
    var breeds: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        pickerView.dataSource = self
        pickerView.delegate = self
        
        DogAPI.requestBreedsList(completionHandler: handleBreedsListResponse(breeds:error:))
    }
    
    func handleBreedsListResponse(breeds: [String], error: Error?) {
        self.breeds = breeds
        DispatchQueue.main.async {
            self.pickerView.reloadAllComponents()
        }
    }
    
    func handlerRandomImageResponse(imageData: DogImage?, error: Error?) -> Void {
        guard let imageUrl = URL(string: imageData?.message ?? "") else { return }
        DogAPI.requestImageFile(url: imageUrl, completionHandler: self.handlerImageFileResponse(image:error:))
    }
    
    func handlerImageFileResponse(image: UIImage?, error: Error?) -> Void {
        DispatchQueue.main.async {
            self.imageView.image = image
        }
    }
    
    
}

extension ViewController: UIPickerViewDataSource, UIPickerViewDelegate {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return breeds.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return breeds[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        DogAPI.requestRandomImage(breed: breeds[row], completionHandler: self.handlerRandomImageResponse(imageData:error:))
    }
    
    
}
