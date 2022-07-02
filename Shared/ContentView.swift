//
//  ContentView.swift
//  Shared
//
//  Created by Thomas Bonk on 02.07.22.
//

import SwiftUI

struct ContentView: View {
    @Binding var document: mdprsDocument

    var body: some View {
        TextEditor(text: $document.text)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(document: .constant(mdprsDocument()))
    }
}
