//
//  RecordSoundsViewController.swift
//  Pitch Perfect
//
//  Created by David Kisley on 4/3/15.
//  Copyright (c) 2015 David Kisley. All rights reserved.
//

import UIKit
import AVFoundation
class RecordSoundsViewController: UIViewController, AVAudioRecorderDelegate {
    //initialize Library and a variable to store the recorded audio
    var audioRecorder: AVAudioRecorder!
    var recordedAudio: RecordedAudio!
  
    //define Interface Builders Outlets control visibility
    @IBOutlet weak var recordButtonImage: UIButton!
    @IBOutlet weak var recordingInProgress: UILabel!
    @IBOutlet weak var stopButtonImage: UIButton!
    @IBOutlet weak var tapToRecordLabel: UILabel!
    
    //not used but ready for enhancements
    override func viewWillAppear(animated: Bool) {
        
    }
    
    //when stop button is pushed, pass file to next view with Recorderd Audio Model
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if(segue.identifier == "stopRecording"){
            let PlaySoundsVC: PlaySoundsViewController = segue.destinationViewController as PlaySoundsViewController
            let data = sender as RecordedAudio
            PlaySoundsVC.receivedAudio = data
            
            
        }
    }
    
    //not used but ready for enhancements
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    //not used but ready for enhancements
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    //interface builder action that begins recording audio to memory when microphone button it tapped
    @IBAction func recordAudio(sender: UIButton) {
        setStateToRecording()
        let dirPath = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)[0] as String
        
        let currentDateTime = NSDate()
        let formatter = NSDateFormatter()
        formatter.dateFormat = "ddMMyyyy-HHmmss"
        let recordingName = formatter.stringFromDate(currentDateTime)+".wav"
        let pathArray = [dirPath, recordingName]
        let filePath = NSURL.fileURLWithPathComponents(pathArray)
        
        var session = AVAudioSession.sharedInstance()
        session.setCategory(AVAudioSessionCategoryPlayAndRecord, error: nil)
        
        audioRecorder = AVAudioRecorder(URL: filePath, settings: nil, error: nil)
        audioRecorder.delegate = self
        audioRecorder.meteringEnabled = true
        audioRecorder.record()
        
    }
    
    //interface builder action that stops recording, and saves audio to a file
    @IBAction func stopRecording(sender: UIButton) {
        
        audioRecorder.stop()
        var audioSession = AVAudioSession.sharedInstance()
        audioSession.setActive(false, error: nil)
        setStateReadyToRecord()
        
    }
    
    //method to determine if stopRecording completed successfully and if so, perform segue with audio file info
    func audioRecorderDidFinishRecording(recorder: AVAudioRecorder!, successfully flag: Bool) {
        if (flag) {
            recordedAudio = RecordedAudio(filePathUrl: recorder.url,title: recorder.url.lastPathComponent)
            self.performSegueWithIdentifier("stopRecording", sender: recordedAudio)
        } else {
            println("Recording was not successful.")
            setStateReadyToRecord()
        }
    }
    
    //utility function to set the visibility when app is ready to record
    func setStateReadyToRecord(){
        recordButtonImage.enabled = true
        recordingInProgress.hidden = true
        stopButtonImage.hidden = true
        recordButtonImage.hidden = false
        tapToRecordLabel.hidden = false
    }
    //utility function that sets the visibility when app is recording
    func setStateToRecording(){
        recordButtonImage.enabled = false
        recordingInProgress.hidden = false
        stopButtonImage.hidden = false
        recordButtonImage.hidden = true
        tapToRecordLabel.hidden = true
        
    }
    
   
  
}

