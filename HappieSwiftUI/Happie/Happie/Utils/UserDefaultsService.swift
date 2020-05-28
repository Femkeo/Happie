//
//  UserDefaultsService.swift
//  Happie
//
//  Created by Femke Offringa on 22/05/2020.
//  Copyright © 2020 Femke Offringa. All rights reserved.
//

import Foundation

class UserDefaultsService {
    let userDefaults = UserDefaults.standard

    func userWasStored() -> Bool {
        return userDefaults.data(forKey: userDefaultKeys.currentUser) != nil
    }

    func fetchCurrentUser() -> User? {
        do {
            guard let user = userDefaults.data(forKey: userDefaultKeys.currentUser) else { return nil }
            if let userData = try NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(user) {
                let currentUser = try JSONDecoder().decode(User.self, from: userData as? Data ?? Data())
                return currentUser
            }
        } catch let error {
            logger(object: String("Could not fetch user because of: \(error)"))
        }
        return nil
    }

    func safeCurrentUser(user: User) {
        do {
            let newUser = try JSONEncoder().encode(user)
            let data: Data? = try NSKeyedArchiver.archivedData(withRootObject: newUser, requiringSecureCoding: false)
            userDefaults.set(data, forKey: userDefaultKeys.currentUser)
            userDefaults.synchronize()
        } catch let error {
            logger(object: String("Could not safe user because of: \(error)"))
        }
    }

    func appWasLaunchedBefore() -> Bool {
        return userDefaults.value(forKey: userDefaultKeys.launchedBefore) != nil
    }

    func setAsLaunchedBefore() {
        userDefaults.set(true, forKey: userDefaultKeys.launchedBefore)
    }
}
