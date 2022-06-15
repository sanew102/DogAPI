//
//  ViewController.swift
//  DogAPI
//
//  Created by Нурым Нагиметов on 11.06.2022.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        DogAPI.requestRandemImage(completionHandler: handleRandomImageResponse(imageData:error:))
    }
    
    func handleRandomImageResponse(imageData: DogImage?, error: Error?) {
        guard let imageURl = URL(string: imageData?.message ?? "") else { return }
        DogAPI.reguestImageFile(url: imageURl, completionHandler: self.handleImageFileResponse(image:error:))
    }
    
    func handleImageFileResponse(image: UIImage?, error: Error?) {
        DispatchQueue.main.async {
            self.imageView.image = image
        }

    }
}
