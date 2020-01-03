//
//  NoteEditingView.swift
//  Notes
//
//  Created by Arshad, Fatima on 12/31/19.
//  Copyright © 2019 Arshad, Fatima. All rights reserved.
//

import SwiftUI

struct NoteEditingView: View {
  @Binding var note: Note

  var body: some View {
    Form {
      TextField("Name", text: $note.name)
    }
  }
}

struct TaskEditingView_Previews: PreviewProvider {
  static var previews: some View {
    NoteEditingView(
        note: .constant(Note(name: "To Do"))
    )
  }
}
