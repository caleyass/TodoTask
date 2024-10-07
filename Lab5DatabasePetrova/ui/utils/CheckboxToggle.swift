//
//  CheckboxToggle.swift
//  Lab5DatabasePetrova
//
//  Created by Olesia Petrova on 07.10.2024.
//
import SwiftUI

struct CheckboxToggle : View {
    @State var isDone : Bool
    let updateValue : (Bool) -> Void
    
    var body: some View{
        Image(systemName: isDone ? "checkmark.square" : "square")
            .resizable()
            .frame(width: 24, height: 24)
            .foregroundColor(.black)
            .onTapGesture {
                isDone.toggle()
                updateValue(isDone)
            }
    }
}
