//
//  TextFieldFocused.swift
//  FocusStateDemo
//
//  Created by Akshay Diliprao Chavan on 02/08/23.
//

import SwiftUI


protocol Focusable{
    var stringValue:String{get}
    var next:Any{get}
    var previous:Any{get}
}

@available(iOS 15.0, *)
private struct TextFieldFocused<FocusableType:Equatable & Focusable>: ViewModifier {
    
    @FocusState private var focused: Bool
    @Binding private var externalFocused: FocusableType
    private var selfkey:FocusableType
    
    init(externalFocused: Binding<FocusableType>, selfKey:FocusableType) {
        self._externalFocused = externalFocused
        self.selfkey = selfKey
        self.focused = false
    }
    
    func body(content: Content) -> some View {
        content
            .onChange(of: externalFocused) { newValue in
                focused = (newValue.stringValue == selfkey.stringValue)
            }
            .focused($focused)
            .onChange(of: focused) { isFocused in
                if isFocused {
                    externalFocused = selfkey
                }
            }
            .toolbar {
                ToolbarItemGroup(placement: .keyboard) {
                    if externalFocused == selfkey{
                        Button {
                            let nextFocusId = externalFocused.next as! FocusableType
                            focused = (externalFocused.stringValue == nextFocusId.stringValue)
                            DispatchQueue.main.asyncAfter(deadline: .now()+0.3, execute: {
                                externalFocused = nextFocusId
                            })
                        } label: {
                            Image(systemName: "chevron.down")
                                .foregroundColor(.blue)
                        }
                        Button {
                            externalFocused = externalFocused.previous as! FocusableType
                        } label: {
                            Image(systemName: "chevron.up")
                                .foregroundColor(.blue)
                        }
                        Spacer()
                    }
                }
            }
    }
}


extension View {
    
    @ViewBuilder
    func focused<FocusableType:Equatable & Focusable>(_ externalFocused: Binding<FocusableType>, selfKey:FocusableType) -> some View {
        if #available(iOS 15.0, *) {
            self.modifier(TextFieldFocused(externalFocused: externalFocused, selfKey: selfKey))
        } else {
            self
        }
    }
}
