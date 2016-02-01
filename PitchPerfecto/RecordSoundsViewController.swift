//
//  RecordSoundsViewController
//  PitchPerfecto
//
//  Created by Darren Leith on 01/02/2016.
//  Copyright © 2016 Darren Leith. All rights reserved.
//

import UIKit
import AVFoundation

class RecordSoundsViewController: UIViewController {

  @IBOutlet weak var recordingProgress: UILabel!
  @IBOutlet weak var stopButton: UIButton!
  @IBOutlet weak var microphoneButton: UIButton!
  
  var audioRecorder: AVAudioRecorder!
  
  override func viewDidLoad() {
    super.viewDidLoad()
  }
  
  override func viewWillAppear(animated: Bool) {
    stopButton.hidden = true
    microphoneButton.enabled = true 
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }

  @IBAction func recordAudio(sender: UIButton) {
    
    let dirPath = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true).first! as String
    
    let currentDateTime = NSDate()
    let formatter = NSDateFormatter()
    formatter.dateFormat = "ddMMyyyy-HHmmss"
    let recordingName = "\(formatter.stringFromDate(currentDateTime)).wav)"
    let pathArray = [dirPath, recordingName]
    let filePath = NSURL.fileURLWithPathComponents(pathArray)
    print(filePath)
    
    let session = AVAudioSession.sharedInstance()
    try! session.setCategory(AVAudioSessionCategoryPlayAndRecord)
    try! audioRecorder = AVAudioRecorder(URL: filePath!, settings: [:])
    audioRecorder.meteringEnabled = true
    audioRecorder.prepareToRecord()
    audioRecorder.record()
    
    recordingProgress.hidden = false
    microphoneButton.enabled = false
    stopButton.hidden = false
  }

  @IBAction func stopRecordingAudio(sender: UIButton) {
    audioRecorder.stop()
    let audioSession = AVAudioSession.sharedInstance()
    try! audioSession.setActive(false)
    recordingProgress.hidden = true
    stopButton.hidden = true
  }
}

