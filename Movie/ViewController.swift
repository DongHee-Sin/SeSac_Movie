//
//  ViewController.swift
//  Movie
//
//  Created by 신동희 on 2022/07/04.
//

import UIKit

class ViewController: UIViewController {

    // MARK: - Propertys
    @IBOutlet weak var mainPoster: UIImageView!
    @IBOutlet var moviePosters: [UIImageView]!
    
    @IBOutlet weak var mainLogoButton: UIButton!
    
    
    // MARK: - View Did Load
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        setupUI()
    }


    // MARK: - Methods
    func setupUI() {
        moviePosters.forEach({
            $0.clipsToBounds = true
            $0.layer.cornerRadius = $0.frame.height / 2
            $0.layer.borderColor = UIColor.lightGray.cgColor
            $0.layer.borderWidth = 2
        })
        
        mainLogoButton.isSelected = true
        mainLogoButton.isHighlighted = true
    }
    
    @IBAction func playButtonTapped(_ sender: UIButton) {
        var randomNumberSet: Set<Int> = []
        while randomNumberSet.count <= 3 {
            randomNumberSet.insert(Int.random(in: 1...20))
        }
        mainPoster.image = UIImage(named: "포스터\(randomNumberSet.removeFirst())")
        for (num, image) in zip(randomNumberSet, moviePosters) {
            image.image = UIImage(named: "포스터\(num)")
        }
    }
    
    
    
}

