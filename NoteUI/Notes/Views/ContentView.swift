//
//  ContentView.swift
//  Notes
//
//  Created by Arshad, Fatima on 12/23/19.
//  Copyright © 2019 Arshad, Fatima. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    // We can change this to [Note]() if we want to
    // The initial list is useful to see in the preview
    @State var notes = [
        Note(title: "butter"),
        Note(title: "milk"),
        Note(title: "eggs")
    ]

    var body: some View {
        NavigationView {
            List {
                ForEach(notes.indices) { index in
                    // Adding the NavigationLink/NoteView will be bonus work
                    NavigationLink(destination: NoteView(notes: self.$notes, index: index)) {
                        NoteRow(notes: self.$notes, index: index)
                    }
                }
            }
            .navigationBarTitle("Notes")
            .navigationBarItems(
                trailing: Button(action: {
                    self.notes.insert(Note(), at: 0)
                }) {
                    Image(systemName: "plus")
            })
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
