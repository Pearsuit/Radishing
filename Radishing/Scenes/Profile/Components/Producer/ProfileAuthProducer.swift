//
//  ProfileProducer.swift
//  Radishing
//
//  Created by Nathaniel Dillinger on 4/25/18.
//  Copyright © 2018 Nathaniel Dillinger. All rights reserved.
//

import Foundation

enum ProfileAuthProducer: AuthProducerSetupable {
    
    static var authenticator: Authenticatable.Type!
    static var presenter: Presentable.Type!
    
    static func fetchWork(_ work: Work) {
        self.authenticator = CurrentServices.authenticator
        self.presenter = work.presenter
        let assignment = work.assignment as! AuthAssignment
        switch assignment {
        case .fetchDisplayName:
            handleFetchDisplayName()
        case .signOut:
            handleSignOut()
        default: print("Error at producer")
        }
    }
    
    private static func handleFetchDisplayName() {
        authenticator?.fetchDisplayName { (displayName) in
            let results = Results(assignment: AuthAssignment.fetchDisplayName, error: nil, model: DisplayName(string: displayName))
            presenter?.fetchResults(results)
        }
    }
    
    private static func handleSignOut() {
        authenticator?.signOut { error in
            if let error = error {
                let results = Results(assignment: AuthAssignment.signOut, error: error, model: nil)
                presenter?.fetchResults(results)
            } else {
                let results = Results(assignment: AuthAssignment.signOut, error: nil, model: nil)
                presenter?.fetchResults(results)
            }
        }
    }
}
