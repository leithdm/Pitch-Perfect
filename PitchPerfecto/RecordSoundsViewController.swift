//
//  RecordSoundsViewController
//  PitchPerfecto
//
//  Created by Darren Leith on 01/02/2016.
//  Copyright © 2016 Darren Leith. All rights reserved.
//

import UIKit
import AVFoundation

class RecordSoundsViewController: UIViewController, AVAudioRecorderDelegate {

  //MARK: - outlets
  @IBOutlet weak var recordingProgress: UILabel!
  @IBOutlet weak var stopButton: UIButton!
  @IBOutlet weak var microphoneButton: UIButton!
  
  //MARK: - properties
  var audioRecorder: AVAudioRecorder!
  var recordedAudio: RecordedAudio!
  
  
  //MARK: - viewDidLoad
  override func viewDidLoad() {
    super.viewDidLoad()
  }
  
  //MARK: - viewWillAppear
  override func viewWillAppear(animated: Bool) {
    stopButton.hidden = true
    microphoneButton.enabled = true
    recordingProgress.hidden = false
    recordingProgress.text = "Tap Icon To Record"
    recordingProgress.textColor = UIColor.whiteColor()
    loadAnimations()
  }
  
  //MARK: - loadAnimations
  func loadAnimations() {
    //Moving elements off-screen prior to being shown
    recordingProgress.center.x += view.bounds.width
    //Banner at top of view
    UIView.animateWithDuration(0.4, delay: 0, options: [.CurveEaseOut], animations: { () -> Void in
      self.recordingProgress.center.x -= self.view.bounds.width
      }, completion: nil)
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }

  //MARK: recordAudio
  @IBAction func recordAudio(sender: UIButton) {
    let dirPath = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true).first! as String
    
    let recordingName = "my_audio.wav"
    let pathArray = [dirPath, recordingName]
    let filePath = NSURL.fileURLWithPathComponents(pathArray)
    print(filePath)
    
    let session = AVAudioSession.sharedInstance()
    try! session.setCategory(AVAudioSessionCategoryPlayAndRecord)
    try! audioRecorder = AVAudioRecorder(URL: filePath!, settings: [:])
    audioRecorder.delegate = self	
    audioRecorder.meteringEnabled = true
    audioRecorder.prepareToRecord()
    audioRecorder.record()

    recordingProgress.text = "Recording in Progress"
    recordingProgress.textColor = UIColor.redColor()
    loadAnimations()
    microphoneButton.enabled = false
    stopButton.hidden = false
  }
  
  //MARK: - Delegate recorderDidFinishRecording
  func audioRecorderDidFinishRecording(recorder: AVAudioRecorder, successfully flag: Bool) {
    
    if flag {
    recordedAudio = RecordedAudio(filePathUrl: recorder.url, title: recorder.url.lastPathComponent!)
    self.performSegueWithIdentifier("stopRecording", sender: recordedAudio) //self will also work here.
    } else {
      print("Recording was not successful")
      microphoneButton.enabled = true
      stopButton.hidden = true
    }
  }
  
  //MARK: - prepareForSegue
  override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) { //sender here is "recordedAudio"
    if segue.identifier == "stopRecording" {
      let playSoundsVC = segue.destinationViewController as! PlaySoundsViewController
      let data = sender as! RecordedAudio
      playSoundsVC.recordedAudio = data
    }
  }

  //MARK: - stopRecordingAudio
  @IBAction func stopRecordingAudio(sender: UIButton) {
    audioRecorder.stop()
    let audioSession = AVAudioSession.sharedInstance()
    try! audioSession.setActive(false)
    recordingProgress.hidden = true
    stopButton.hidden = true
  }
  
  
}

