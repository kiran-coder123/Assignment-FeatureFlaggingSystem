//
//  FeatureFlagManager.swift
//  Feature_Flagging_App
//
//  Created by Neosoft on 19/09/23.
//

import Foundation
protocol PresenterView: AnyObject {
    func updateUI()
}

class FeatureFlagManager   {
    weak var view: PresenterView?
    private let nicknames: [String]
       
   init(with view: PresenterView, nicknames: [String]) {
        self.view = view
        self.nicknames = nicknames
    }
    
    func generateNickname(for username: String, from nicknames: [String]) -> (original: String, uppercase: String)? {
           guard !nicknames.isEmpty else {
               return nil
           }
           let randomIndex = Int.random(in: 0..<nicknames.count)
           let originalNickname = nicknames[randomIndex]
        let uppercaseNickname = originalNickname.uppercased()
        return (originalNickname, uppercaseNickname)
       }
}
