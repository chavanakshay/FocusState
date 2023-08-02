//
//  FocusStateDemoApp.swift
//  FocusStateDemo
//
//  Created by Akshay Diliprao Chavan on 02/08/23.
//

import SwiftUI

@main
struct FocusStateDemoApp: App {
    var body: some Scene {
        WindowGroup {
            if #available(iOS 15.0, *) {
                ContentView()
            } else {
                // Fallback on earlier versions
            }
        }
    }
}
