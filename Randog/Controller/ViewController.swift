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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        DogAPI.requestRandomImage(completionHandler: self.handlerRandomImageResponse(imageData:error:))
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

