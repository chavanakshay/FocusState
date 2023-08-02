//
//  ContentView.swift
//  FocusStateDemo
//
//  Created by Akshay Diliprao Chavan on 02/08/23.
//

import SwiftUI

enum Field:Focusable, Equatable {
    case username
    case password
    case unknown
    
    var stringValue: String{
        switch self {
        case .username:
            return "username"
        case .password:
            return "password"
        case .unknown:
            return "unknown"
        }
    }
    
    var next: Any{
        switch self {
        case .username:
            return Field.password
        case .password:
            return Field.password
        case .unknown:
            return Field.unknown
        }
    }
    
    var previous: Any{
        switch self {
        case .username:
            return Field.username
        case .password:
            return Field.username
        case .unknown:
            return Field.unknown
        }

    }
    
    static func == (lhs: Field, rhs: Field) -> Bool {
        lhs.stringValue == rhs.stringValue
    }
}



struct ContentView: View {
    typealias FocusableType = Field
    @State var currentlyFocused: FocusableType = Field.unknown
    @State private var username = ""
    @State private var password = ""

    var body: some View {
        VStack {
            TextField("Enter your username", text: $username)
                .background(Color.gray.opacity(0.2))
                .focused($currentlyFocused, selfKey: Field.username)
                .padding()

            SecureField("Enter your password", text: $password)
                .background(Color.gray.opacity(0.2))
                .focused($currentlyFocused, selfKey: Field.password)
                .padding()
        }
    }
}







