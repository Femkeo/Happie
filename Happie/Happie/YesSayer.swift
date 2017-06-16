//
//  YesSayer.swift
//  DreamPrototypeTwo
//
//  Created by G.F Offringa on 01-05-17.
//  Copyright © 2017 femkeo. All rights reserved.
//

import Foundation
import Speech

class YesSayer{
    
    var seconds = 18000
    var timer = Timer()
    var musicPlayer: AVAudioPlayer!
    var firstTime = true
    
    
    let audioEngine = AVAudioEngine()
    let speechRecognier: SFSpeechRecognizer? = SFSpeechRecognizer()
    let request = SFSpeechAudioBufferRecognitionRequest()
    var recognitionTask: SFSpeechRecognitionTask?
    
    
    @objc func stopAction(){
        seconds -= 1
        
        if seconds == 0{
            self.audioEngine.stop()
            self.request.endAudio()
            self.recognitionTask?.cancel()
            self.recognitionTask = nil
            self.firstTime = true
            
            timer.invalidate()
        }
    }
    
    func countingTillEnding(){
        timer = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(stopAction), userInfo: nil, repeats: true)
    
        //        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: stopAction(), userInfo: nil, repeats: true)
        recordAndRecognizeSpeech()
    }
    
    
    
    func recordAndRecognizeSpeech(){
        if firstTime == true{
            guard let node = audioEngine.inputNode else { return }
            node.installTap(onBus: 0, bufferSize: 1024, format: node.inputFormat(forBus: 0)) {buffer,_ in
                self.request.append(buffer)
            }
            
            audioEngine.prepare()
            do{
                try audioEngine.start()
            }
            catch {
                return print(error)
            }
            
            guard let myRecognizer = SFSpeechRecognizer() else {
                return
            }
            if !myRecognizer.isAvailable{
                return
            }
            
            recognitionTask = speechRecognier?.recognitionTask(with: request, resultHandler: { result, error in
                if let result = result{
                    let bestString = result.bestTranscription.formattedString
                    var lastString = ""
                    for segment in result.bestTranscription.segments{
                        let indexTo = bestString.index(bestString.startIndex, offsetBy: segment.substringRange.location)
                        lastString = bestString.substring(from: indexTo)
                    }
                    self.recognizingNo(resultString: lastString)
                }else{
                    self.firstTime = false
                }
            })
            
        }
    }
    
    func recognizingNo(resultString: String){
        if resultString == "Nee"{
            initAudio()
        }else if resultString == "nee"{
            initAudio()
        }
    }
    
    func initAudio(){
        let path = Bundle.main.path(forResource: "music", ofType: "mp3")!
        do {
            try AVAudioSession.sharedInstance().overrideOutputAudioPort(AVAudioSessionPortOverride.speaker)
            musicPlayer = try AVAudioPlayer(contentsOf: NSURL(string: path)! as URL)
            musicPlayer.prepareToPlay()
            musicPlayer.numberOfLoops = 0
            musicPlayer.play()
            
        }catch let err as NSError{
            print(err.debugDescription)
        }
    }
    

    
}
