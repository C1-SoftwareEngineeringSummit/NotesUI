//
//  ContentView.swift
//  Notes
//
//  Created by Arshad, Fatima on 12/23/19.
//  Copyright © 2019 Arshad, Fatima. All rights reserved.
//

import SwiftUI

struct ContentView: View {
  @ObservedObject var noteStore: NoteStore
  @State var modalIsPresented = false

  var body: some View {
    NavigationView {
        List {
            ForEach(noteStore.notes) { index in
              RowView(note: self.$noteStore.notes[index])
            
            }
            .onDelete { atIndexSet in
                self.noteStore.notes.remove(atOffsets: atIndexSet)
            }
            .onMove { sourceIndices, destinationIndex in
                self.noteStore.notes.move(fromOffsets: sourceIndices, toOffset: destinationIndex)
            }
        }
      .navigationBarTitle("Notes")
      .navigationBarItems(
        leading: EditButton(),
        trailing:
          Button(
            action: { self.modalIsPresented = true }
          ) {
            Image(systemName: "plus")
          }
      )
    }
    .sheet(isPresented: $modalIsPresented) {
      NoteDetail(noteStore: self.noteStore)
    }
  }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(noteStore: NoteStore())
    }
}
