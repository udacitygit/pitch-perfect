//
//  PlaySoundsViewController.swift
//  Pitch Perfect
//
//  Created by David Kisley on 4/6/15.
//  Copyright (c) 2015 David Kisley. All rights reserved.
//

import UIKit
import AVFoundation
class PlaySoundsViewController: UIViewController {
    var audioEngine: AVAudioEngine!
    var audioFile: AVAudioFile!
    var audioPlayer: AVAudioPlayer!
    var receivedAudio: RecordedAudio!
    override func viewDidLoad() {
        //call parent method
        super.viewDidLoad()

        //create intances of audio player and audio engine with rate and get audio file passed in from model
        audioPlayer = AVAudioPlayer(contentsOfURL: receivedAudio.filePathUrl, error: nil)
        audioPlayer.enableRate = true
        
        audioEngine = AVAudioEngine()
        
        audioFile = AVAudioFile(forReading: receivedAudio.filePathUrl, error: nil)

    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func playSlowAudio(sender: UIButton) {
        stopAndResetAudio()
        audioPlayer.rate = 0.5
        audioPlayer.play()
    }
   
    @IBAction func playFastAudio(sender: UIButton) {
        stopAndResetAudio()
        audioPlayer.rate = 3.0
        audioPlayer.play()
        
    }
    
    @IBAction func playChipmunkAudio(sender: UIButton) {
        stopAndResetAudio()
        playAudioWithVariablePitch(1000)
    }
    
    @IBAction func PlayDarthvaderAudio(sender: UIButton) {
        stopAndResetAudio()
        playAudioWithVariablePitch(-1000)
        
    }
    
    @IBAction func stopAllAudio(sender: UIButton) {
        stopAndResetAudio()
    }
    
    //common method that will stop both methods of playback manupilation and move the audio to start of recorded file
    func stopAndResetAudio(){
        audioPlayer.stop()
        audioPlayer.currentTime = 0.0
        audioEngine.stop()
        audioEngine.reset()
    }
    
    //common method that will be called for chipmumk and darthvader effects changing only the pitch
    func playAudioWithVariablePitch(pitch: Float){
        stopAndResetAudio()
        
        var audioPlayerNode = AVAudioPlayerNode()
        audioEngine.attachNode(audioPlayerNode)
        
        var changePitchEffect = AVAudioUnitTimePitch()
        changePitchEffect.pitch = pitch
        audioEngine.attachNode(changePitchEffect)
        
        audioEngine.connect(audioPlayerNode, to: changePitchEffect, format: nil)
        audioEngine.connect(changePitchEffect, to: audioEngine.outputNode, format: nil)
        
        audioPlayerNode.scheduleFile(audioFile, atTime: nil, completionHandler: nil)
        audioEngine.startAndReturnError(nil)
        
        audioPlayerNode.play()
    }
    
    
    
    


}
