//
//  RootClass.swift
//  Model Generated using http://www.jsoncafe.com/ 
//  Created on August 20, 2018

import Foundation

// QUESTION: So I kind of struggled with this data model a bit. It was deeply nested and contained a lot more information than what I am used to.
// Obviously making everything optional is not ideal. but I don't see anything in the documentation for what information I am guarunteed. https://developer.spotify.com/console/get-new-releases/
// I'm  a little nervous that during an interview I will get stuck on decoding my json (if one thing is wrong the full payload fails).



/// Higher level question: Let's say I hit multiple endpoints on Spotify. Do you normally create a new data model for each endpoint? For example, Album is likely to be used across the board. Do you reuse that data model? Or do you treat each endpoint as completely independent.
struct NewReleasesPayload : Codable {
    
    let albums : Album?

}
