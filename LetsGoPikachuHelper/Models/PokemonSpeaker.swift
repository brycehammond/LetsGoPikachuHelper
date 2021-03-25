//
//  PokemonSpeaker.swift
//  LetsGoPikachuHelper
//
//  Created by Bryce Hammond on 1/31/21.
//

import UIKit
import AVFoundation

class PokemonSpeaker {

    class func speakName(of pokemon: Pokemon) {
        speak(text: pokemon.name)
    }

    class func speakType(_ type: PokemonType) {
        speak(text: type.rawValue)
    }

    private class func speak(text: String) {
        let utterance = AVSpeechUtterance(string: text)
        utterance.rate = 0.5
        //utterance.pitchMultiplier = 0.2
        utterance.postUtteranceDelay = 0.2
        utterance.volume = 0.8

        let voice = AVSpeechSynthesisVoice(language: "en-US")
        utterance.voice = voice

        let synthesizer = AVSpeechSynthesizer()
        synthesizer.speak(utterance)
    }

}
