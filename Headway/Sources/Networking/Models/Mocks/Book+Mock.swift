//
//  Book+Mock.swift
//  Headway
//
//  Created by Pavlo Tanaiev on 27.12.2023.
//

import Foundation

extension Book {
    
    static let mockedJson: [String] = [Book.jsonString1, Book.jsonString2, Book.jsonString3]
    
    static let mock = Self(coverImageUrl: URL(string:"https://static.get-headway.com/600_f3652bdbfd3e410c86e7-15cf929da987aa.jpg")!,
                           keyPoints: [
                            .init(description: "Making your bad can be an acomplishment",
                                  audioUrl:  URL(string:"https://static.get-headway.com/audio%2Ff3652bdbfd3e410c86e7%2FBunny%2BStudio%2F0_1693929664_en.mp3")!),
                            .init(description: "Find people to relly on",
                                  audioUrl: URL(string:"https://static.get-headway.com/audio%2Ff3652bdbfd3e410c86e7%2FBunny%2BStudio%2F1_1693929664_en.mp3")!),
                            .init(description: "Make peace with the imperfection of life",
                                  audioUrl: URL(string:"https://static.get-headway.com/audio%2Ff3652bdbfd3e410c86e7%2FBunny%2BStudio%2F2_1693929664_en.mp3")!),
                            .init(description: "When life gives you lemons, make lemonade",
                                  audioUrl: URL(string:"https://static.get-headway.com/audio%2Ff3652bdbfd3e410c86e7%2FBunny%2BStudio%2F3_1693929664_en.mp3")!),
                            .init(description: "Don't fear, dare!",
                                  audioUrl: URL(string:"https://static.get-headway.com/audio%2Ff3652bdbfd3e410c86e7%2FBunny%2BStudio%2F4_1693929664_en.mp3")!),
                            .init(description: "In the darknest times, there is always light",
                                  audioUrl: URL(string:"https://static.get-headway.com/audio%2Ff3652bdbfd3e410c86e7%2FBunny%2BStudio%2F5_1693929664_en.mp3")!),
                            .init(description: "Conclusion",
                                  audioUrl: URL(string:"https://static.get-headway.com/audio%2Ff3652bdbfd3e410c86e7%2FBunny%2BStudio%2F6_1693929664_en.mp3")!)
                           ])
    
    static let jsonString1 = """
    {
      "coverImageUrl": "https://static.get-headway.com/600_f3652bdbfd3e410c86e7-15cf929da987aa.jpg",
      "keyPoints": [
        {
          "description": "Making your bed can be an accomplishment",
          "audioUrl": "https://static.get-headway.com/audio%2Ff3652bdbfd3e410c86e7%2FBunny%2BStudio%2F0_1693929664_ena.mp3"
        },
        {
          "description": "Find people to rely on",
          "audioUrl": "https://static.get-headway.com/audio%2Ff3652bdbfd3e410c86e7%2FBunny%2BStudio%2F1_1693929664_en.mp3"
        },
        {
          "description": "Make peace with the imperfection of life",
          "audioUrl": "https://static.get-headway.com/audio%2Ff3652bdbfd3e410c86e7%2FBunny%2BStudio%2F2_1693929664a_en.mp3"
        },
        {
          "description": "When life gives you lemons, make lemonade",
          "audioUrl": "https://static.get-headway.com/audio%2Ff3652bdbfd3e410c86e7%2FBunny%2BStudio%2F3_1693929664_en.mp3"
        },
        {
          "description": "Don't fear, dare!",
          "audioUrl": "https://static.get-headway.com/audio%2Ff3652bdbfd3e410c86e7%2FBunny%2BStudio%2F4_1693929664_en.mp3"
        },
        {
          "description": "In the darkest times, there is always light",
          "audioUrl": "https://static.get-headway.com/audio%2Ff3652bdbfd3e410c86e7%2FBunny%2BStudio%2F5_1693929664_en.mp3"
        },
        {
          "description": "Conclusion",
          "audioUrl": "https://static.get-headway.com/audio%2Ff3652bdbfd3e410c86e7%2FBunny%2BStudio%2F6_1693929664_en.mp3"
        }
      ]
    }
    """
    
    static let jsonString2 = """
    {
      "coverImageUrl": "https://static.get-headway.com/600_bda5b563f50e42baa79f-15f241de608ded.jpg",
      "keyPoints": [
        {
          "description": "Success is not an easy to achieve; you need to be prepared to fight for it",
          "audioUrl": "https://static.get-headway.com/audio%2Fbda5b563f50e42baa79f%2FPatrick%2F0_1700476221_en.mp3"
        },
        {
          "description": "Use tedious activities as learning material",
          "audioUrl": "https://static.get-headway.com/audio%2Fbda5b563f50e42baa79f%2FPatrick%2F1_1700476221_en.mp3"
        },
        {
          "description": "Great people have a working value system",
          "audioUrl": "https://static.get-headway.com/audio%2Fbda5b563f50e42baa79f%2FPatrick%2F2_1700476221_ena.mp3"
        },
        {
          "description": "Achievers are people with persistence and focus; mastery is their main attribute",
          "audioUrl": "https://static.get-headway.com/audio%2Fbda5b563f50e42baa79f%2FPatrick%2F3_1700476221_en.mp3"
        },
        {
          "description": "Discouragement keeps many people from achieving great goals",
          "audioUrl": "https://static.get-headway.com/audio%2Fbda5b563f50e42baa79f%2FPatrick%2F4_1700476221_en.mp3"
        },
        {
          "description": "Failure is intrinsic to the journey to success; the key is to keep going despite it",
          "audioUrl": "https://static.get-headway.com/audio%2Fbda5b563f50e42baa79f%2FPatrick%2F6_1700476221_en.mp3"
        },
        {
          "description": "Conclusion",
          "audioUrl": "https://static.get-headway.com/audio%2Fbda5b563f50e42baa79f%2FPatrick%2F5_1700476221_en.mp3"
        }
      ]
    }
    """
    
    static let jsonString3 = ""
}
