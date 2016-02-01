//
//  PlaySoundsViewController.swift
//  PitchPerfecto
//
//  Created by Darren Leith on 01/02/2016.
//  Copyright © 2016 Darren Leith. All rights reserved.
//

import UIKit
import AVFoundation

class PlaySoundsViewController: UIViewController {
  
  var audioPlayer = AVAudioPlayer()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    setUpAudioPlayer()
  }
  
  func setUpAudioPlayer() {
    if let path = NSBundle.mainBundle().URLForResource("movie_quote", withExtension: "mp3") {
      audioPlayer = try! AVAudioPlayer(contentsOfURL: path)
      audioPlayer.enableRate = true
    }
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }

  func playSound(rate: Float, currentTime: Double) {
    audioPlayer.rate = rate
    audioPlayer.currentTime = currentTime
    audioPlayer.play()
    
  }
  
  @IBAction func playSlowly(sender: UIButton) {
    playSound(0.5, currentTime: 0.0)
  }
  
  @IBAction func playFast(sender: UIButton) {
    playSound(1.5, currentTime: 0.0)
  }
  
  @IBAction func stop(sender: UIButton) {
    audioPlayer.stop()
  }
  
}
