//
//  PageThreeViewController.swift
//  PolarAdventure
//
//  Created by Isabel  Lee on 06/04/2017.
//  Copyright © 2017 Isabel  Lee. All rights reserved.
//

import UIKit

class PageThreeViewController: UIViewController, UIGestureRecognizerDelegate {

    @IBOutlet weak var iceBerg: UIImageView!

    var screenWidth = Size.shared.screenWidth
    var screenHeight = Size.shared.screenHeight
    var storyLineLength = 0.0
    var storyLineXPosition = 0.0
    var storyLineYPosition = 0.0
    var story: UILabel?
    var penguin: Penguin?
    var shark: Shark?
    let fishView = FishView()
    var playButton: UIButton?
    let iceBergShiftImg = [UIImage(named: "iceBerg")!, UIImage(named: "iceBerg_2")!]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        playButton = UIButton(frame: CGRect(x: 100, y: 10, width: 80, height: 80))
        playButton?.setImage(UIImage(named: "soundButton"), for: .normal)
        playButton?.addTarget(self, action: #selector(playButtonTapped(_:)), for: .touchUpInside)
        self.view.addSubview(playButton!)
        
        penguin = Penguin(x: screenWidth * 0.6, y: screenHeight * 0.32)
        penguin?.image = UIImage(named: "penguin_look")
        shark = Shark(x: screenWidth * 0.58, y: screenHeight * 0.7)
        
        storyLineLength = screenWidth*0.8
        storyLineXPosition = screenWidth*0.1
        storyLineYPosition = screenHeight*0.1
        story = UILabel(frame: CGRect(x: storyLineXPosition, y: storyLineYPosition, width: storyLineLength, height: 150))
        
        story?.attributedText = ReadToMe.player.pageThreeString
        story?.lineBreakMode = .byWordWrapping
        story?.numberOfLines = 0
        story?.sizeToFit()
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(sharkTapped(_:)))
        tapGestureRecognizer.delegate = self
        shark!.addGestureRecognizer(tapGestureRecognizer)
        
        self.view.addSubview(fishView)
        self.view.addSubview(story!)
        self.view.addSubview(penguin!)
        self.view.addSubview(shark!)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        UserDefaults.standard.set(2, forKey: "bookmark")
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            self.fishView.startSwim()
            self.isReadToMeOn()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        fishView.toStartPosition()
        shark!.toStartPosition()
        penguin!.toStartPosition()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        ReadToMe.player.removeAllTimer()
        SharedAudioPlayer.player.stopAllPlayer()
        ReadToMe.player.clearFormatting(storyLabel: story!)
    }
    
    //Animate the iceberg to shake, the penguin to be scared, the shark to hit the iceberg, and all the fish to flee. Also plays the sound effect
    func sharkTapped(_ recognizer: UITapGestureRecognizer) {
        iceBerg.animationImages = iceBergShiftImg
        iceBerg.animationDuration = 0.2
        iceBerg.animationRepeatCount = 8
        iceBerg.startAnimating()
        SharedAudioPlayer.player.playEffect(name: "crash")
        shark?.hitIceBerg()
        penguin?.scared()
        fishView.flee()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.001) {
            self.fishView.flee()
        }
    }
    
    func playButtonTapped(_ button: UIButton){
        print("play sound")
        ReadToMe.player.pageThree(storyLabel: story!)
    }
    
    func isReadToMeOn() {
        if let readToMe = UserDefaults.standard.object(forKey: "readToMe") {
            print("readtome option: \(readToMe)")
            if readToMe as! Bool{
                print("Read to me")
                ReadToMe.player.pageThree(storyLabel: story!)
            }
        }
    }
}
