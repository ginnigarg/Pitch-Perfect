//
//  PlaySoundViewController.swift
//  Pitch Perfect
//
//  Created by Guneet Garg on 10/11/1939 Saka.
//  Copyright © 1939 Saka Guneet Garg. All rights reserved.
//

import UIKit
import AVFoundation

class PlaySoundViewController: UIViewController {
    
    @IBOutlet weak var rabbitButton: UIButton!
    @IBOutlet weak var snailButton: UIButton!
    @IBOutlet weak var chipmunkButton: UIButton!
    @IBOutlet weak var vaderButton: UIButton!
    @IBOutlet weak var echoButton: UIButton!
    @IBOutlet weak var reverbButton: UIButton!
    @IBOutlet weak var stopButton: UIButton!
    
    var recordedAudioURL:URL!
    var audioFile:AVAudioFile!
    var audioEngine:AVAudioEngine!
    var audioPlayerNode: AVAudioPlayerNode!
    var stopTimer: Timer!
    
    enum ButtonType: Int {
        case Slow = 0, Fast, HighPitch, LowPitch, Echo, Reverb }
    
    
    @IBAction func playSound (_ sender: UIButton){
        switch(ButtonType(rawValue: sender.tag)!) {
        case .Slow:
            playSound(rate: 0.5)
            break
        case .Fast:
            playSound(rate: 1.5)
            break
        case .HighPitch:
            playSound(pitch: 1000)
            break
        case .LowPitch:
            playSound(pitch: -1000)
            break
        case .Echo:
            playSound(echo: true)
            break
        case .Reverb:
            playSound(reverb: true)
        }
        configureUI(.playing)
    }
    
    @IBAction func stopSound (_ sender: UIButton){
        stopAudio()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupAudio()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        configureUI(.notPlaying)
    }
    
    
    
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}

