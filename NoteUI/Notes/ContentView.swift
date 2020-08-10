//
//  ContentView.swift
//  Notes
//
//  Created by Arshad, Fatima on 12/23/19.
//  Copyright © 2019 Arshad, Fatima. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @State var notes: [Note] = [
        Note(title: "iOS is awesome", content: "It's true"),
        Note(title: "SES is awesome", content: "It's also true")
    ]

    var body: some View {
        NavigationView {
            List(notes.indices, id: \.self) { index in
                NavigationLink(destination: NoteDetail(notes: self.$notes, index: index)) {
                    NoteRow(notes: self.$notes, index: index)
                }
            }
            .navigationBarTitle("Notes")
            .navigationBarItems(trailing:
                Button(action: {
                    self.notes.insert(Note(title: "", content: ""), at: 0)
                }) {
                    Image(systemName: "plus")
                }
            )
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
