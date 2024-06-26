//
//  ScenesData.swift
//  CoolieDIalogBox
//
//  Created by Lucky on 23/06/24.
//

import Foundation

struct ScenesData {
    enum SceneType {
        case narrative(String)
        case dialogue([(Int, String, String, String)])
        case blackScreen(String)
    }
    
    static let scenes: [SceneType] = [
        .narrative("In a home once filled with laughter and warmth, I lived with my husband. For many years, we basked in the joy of our seemingly perfect life."),
        .narrative("Until one day, the illusion shattered. I discovered my husband was cheating on me."),
        .blackScreen(""),
        .dialogue([
            (1, "Why, Dan?", "Beth Gallagher", "Wife1"),
            (2, "It's not what it looks like, Beth. Let me explain.", "Dan Gallagher", "Husband"),
            (1, "Explain? How do you explain cheating on me?", "Beth Gallagher", "Wife1"),
            (2, "I made a mistake. It was a moment of weakness.", "Dan Gallagher", "Husband"),
            (1, "A moment?", "Beth Gallagher", "Wife1"),
            (2, "Beth, please. I love you. We can work through this.", "Dan Gallagher", "Husband"),
            (1, "How could you do this to us? To me?", "Beth Gallagher", "Wife1"),
            (2, "I never wanted to hurt you. I was stupid. Please, just give me a chance to make it right.", "Dan Gallagher", "Husband"),
            (1, "I don't know if I can ever forgive you for this.", "Beth Gallagher", "Wife1")
        ]),
        .blackScreen("One Month Later"),
        .narrative("Determined to get revenge, I looked for my best friend, a woman I had been close to for a long time."),
        .blackScreen(""),
        .dialogue([
            (1, "I don't know what to do. I found out Dan has been unfaithful with another woman, and I can't hold it anymore.", "Beth Gallagher", "Wife2"),
            (2, "Oh no, Beth. I'm so sorry. Do you have any idea who it is?", "Alex Forrest", "BestFriend"),
            (1, "No, but I can't just let this go. I need your help, Alex.", "Beth Gallagher", "Wife2"),
            (2, "What do you need me to do?", "Alex Forrest", "BestFriend"),
            (1, "I want to kill him.", "Beth Gallagher", "Wife2"),
            (2, "Kill him? Are you serious? There must be another way to handle this.", "Alex Forrest", "BestFriend"),
            (1, "I've never been more sure of anything in my life.", "Beth Gallagher", "Wife2"),
            (2, "If that's what you want, I'm in. But we'll do it when he returns from work.", "Alex Forrest", "BestFriend"),
            (1, "Agreed. I'll give you a duplicate key to my house and let you know when to do it later.", "Beth Gallagher", "Wife2")
        ]),
        .blackScreen("Three Months Later"),
        .narrative("I hadn’t given my friend the signal to proceed. My relationship with my husband showed signs of improvement."),
        .narrative("The spark of hope rekindled within me, prompting me to call off the murder plot."),
        .blackScreen(""),
        .dialogue([
            (1, "I've changed my mind. Things are getting better with Dan. I want to call off the plan.", "Beth Gallagher", "Wife2"),
            (2, "Really? If that's what you want, then I understand.", "Alex Forrest", "BestFriend"),
            (1, "Thank you for understanding. I just think it's for the best.", "Beth Gallagher", "Wife2")
        ]),
        .blackScreen("Six Months Later"),
        .narrative("On a sunny morning, my husband and I had breakfast together, and then he left for work."),
        .narrative("After he left for work, I cleaned the house, feeling a strange sense of fatigue by noon. I decided to take a nap, unaware of the looming danger."),
        .narrative("While I slept, someone crept into my home, their presence hidden from me in the quiet solitude of the house."),
        .narrative("Quietly, the figure entered my room, their intentions veiled in darkness and mystery."),
        .blackScreen("")
    ]
}
