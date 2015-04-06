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
    var audioFile:AVAudioFile!
    var audioPlayer:AVAudioPlayer!
    var receivedAudio:RecordedAudio!
    override func viewDidLoad() {
        super.viewDidLoad()

        
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
        // Play audio Slowly Here
        audioPlayer.stop()
        audioPlayer.rate = 0.5
        audioPlayer.play()
    }
   

    @IBAction func playFastAudio(sender: UIButton) {
        audioPlayer.stop()
        audioPlayer.rate = 3.0
        audioPlayer.play()
        
    }
    
    @IBAction func playChipmunkAudio(sender: UIButton) {
        playAudioWithVariablePitch(1000)
          }
    
    @IBAction func PlayDarthvaderAudio(sender: UIButton) {
        playAudioWithVariablePitch(-1000)
    }
    @IBAction func stopAllAudio(sender: UIButton) {
        audioPlayer.stop()
        audioPlayer.currentTime = 0.0
        audioPlayer.rate = 1.0
    }
    func playAudioWithVariablePitch(pitch: Float){
        audioPlayer.stop()
        audioEngine.stop()
        audioEngine.reset()
        
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
    
    
    
    
    /*

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
