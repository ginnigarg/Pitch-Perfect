//
//  RecordSoundViewController.swift
//  Pitch Perfect
//
//  Created by Guneet Garg on 1/28/18.
//  Copyright © 2018 Guneet Garg. All rights reserved.
//

import UIKit
import AVFoundation

class RecordSoundViewController: UIViewController, AVAudioRecorderDelegate {
    
    @IBOutlet weak var startRecording: UIButton!
    @IBOutlet weak var recordingLabel: UILabel!
    @IBOutlet weak var stopRecording: UIButton!
    
    var Recorder : AVAudioRecorder!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        stopRecording.isEnabled = false
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    @IBAction func startRecording(_ sender: AnyObject) {
        changetUIstate(isRecording: true,recordingText: "Recording in Progress")
        let dirPath = NSSearchPathForDirectoriesInDomains(.documentDirectory,.userDomainMask, true)[0] as String
        let recordingName = "recordedVoice.wav"
        let pathArray = [dirPath, recordingName]
        let filePath = URL(string: pathArray.joined(separator: "/"))
        let session = AVAudioSession.sharedInstance()
        try! session.setCategory(AVAudioSession.Category.playAndRecord, mode: AVAudioSession.Mode.default, options: AVAudioSession.CategoryOptions.defaultToSpeaker)
        
        try! Recorder = AVAudioRecorder(url: filePath!, settings: [:])
        Recorder.delegate = self
        Recorder.isMeteringEnabled = true
        Recorder.prepareToRecord()
        Recorder.record()
    }
    
    @IBAction func stopRecording(_ sender: AnyObject) {
        changetUIstate(isRecording: false,recordingText: "Tap to Start Recording")
        Recorder.stop()
        let audioSession=AVAudioSession.sharedInstance()
        try! audioSession.setActive(false)
    }
    
    func changetUIstate(isRecording:Bool,recordingText:String)
    {
        stopRecording.isEnabled = isRecording
        startRecording.isEnabled = !isRecording
        recordingLabel.text = recordingText
    }
    
    func audioRecorderDidFinishRecording(_ recorder: AVAudioRecorder, successfully flag: Bool) {
        if(flag){
            performSegue(withIdentifier: "stopRecording", sender: Recorder.url)
        }else
        {
            print("Recording Failed")
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "stopRecording" {
            let playSoundVC  = segue.destination as! PlaySoundViewController
            let recordedAudioURL = sender as! URL
            playSoundVC.recordedAudioURL = recordedAudioURL
        }
    }
}


