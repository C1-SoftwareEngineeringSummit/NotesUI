# Step By Step Instructions

SwiftUI is a **declarative** framework for building applications for Apple devices. This means that instead of using Storyboards or programmatically generating your interface, you can use the simplicity of the SwiftUI framework. After years of using UIKit and AppKit to create user interfaces, SwiftUI presents a fresh, new way to create UI for your apps.

## Initial Project Setup

1. Open Terminal, and navigate to the directory in which you want to save this project
2. Run the following command in Terminal: `git clone https://github.com/C1-SoftwareEngineeringSummit/NotesUI.git`
    * This will clone our starter project into your file system
3. Navigate into the newly created folder using the following command: `cd NotesUI`
4. Navigate to the starter project folder using: `cd NotesUI-Starter`
5. Open the starter project in the latest version of Xcode using the command: `xed .`
    * You can also double-click the `NotesUI-Starter.xcodeproj` file in Finder
  
## Setting Up Our Model

A note is going to be what we call a data model or more simply, a model.
A model is a way to structure data, so that you can work inside your app's code and have a type that represents a real-world concept, like a note.

* Go to **Project Navigator (⌘1)** and add a new file to the project
  1. Right-click on the **yellow** NotesUI-Starter folder, and select `New File...`
  2. Use the standard **Swift File** option then hit next
  3. You are going to define a type that will represent a note, so name your file `Note`
  4. Click `Create`

We will be using structures inside `Note.swift` to represent our `Note` model. Add the following code inside of `Note.swift`:

```swift
struct Note {
    var title: String
    var content: String
}
```

> Every note needs a title which should be changeable, so a variable (var) of type `String` is the way to go.

Now, with our notes model ready, we can start building our UI using SwiftUI. We will be using a List to display the content.

## Displaying Notes Using a List

A **List** is a container which displays your data in a column, with a row for each entry. This is the structure we will use to organize all our notes. Before we dive further into Lists, we need to create a view that will represent each row of our list.

> When using SwiftUI, Apple encourages you to create as many views as you need to keep your code easy to read.

### Creating A Row View

* Let's start by creating a SwiftUI view called `NoteRow`.
  1. Right-click on the `NotesUI-Starter` folder and select `New File...`
  2. Select the **SwiftUI View** option
  3. Name the file `NoteRow`
* Take a moment to explore this new view. Notice it comes with a Canvas to preview your view
* In the newly created view add `notes: [Note]` as a stored property of the `NoteRow` view.  This will be our full list of notes.
* Since we want each row to only show a single note element from the array, add an `index` property which specifies which note to show in the row.
* Since we added a new property we now have to update the previews property of the `NoteRow_Previews` struct as well
  * Add an array of `Note`s: `static let notes = [Note(title: "Note title...", content: "Note content...")]`
  * Update the `NoteRow()` initializer in the previews struct to accept notes and index as a parameter like so: `NoteRow(notes: .constant(notes), index: 0)`

Your `NoteRow.swift` file should now look like this:

```swift
import SwiftUI

struct NoteRow: View {
    var notes: [Note]
    let index: Int

    var body: some View {
        Text("Hello, World!")
    }
}

struct NoteRow_Previews: PreviewProvider {
    static let notes = [Note(title: "Note title...", content: "Note content...")]
    static var previews: some View {
        NoteRow(notes: notes, index: 0)
    }
}
```

Check out your work in the Canvas to make sure everything is working. You might have to refresh the canvas by pressing the "Resume" button located on the top of the canvas.

> If the Canvas is not open you can use the Option + Command + Return (`⌥ + ⌘ + ↩︎`) shortcut to display it.
>
> ![Display Canvas](../MarkdownAssets/DisplayCanvas.png)
>
> You can use the Option + Command + P (`⌥ + ⌘ + P`) shortcut to refresh your canvas.

### Building the Row Layout

1. Start by adding a Text Field.
2. When creating the TextField, the first parameter is the default text to show when the TextField is empty, and the second parameter is the String object to maintain the current TextField's content.  We'll use the `notes` property with the index to get a specific `Note`, then use the `title` like so: `TextField("Enter note title", text: notes[index].title)`
3. You'll notice the following error:
`Cannot convert value of type 'String' to expected argument type 'Binding<String>'`
In SwiftUI, a **binding** creates a two-way connection between the `TextView` and a property marked with the  `@Binding` property wrapper. User interaction with the `TextField` changes the value of `title`, and programmatically changing `title` causes the `TextField` to update its state.
4. Add the @Binding property wrapper to the notes property, then use the binding using the `$` prefix.

Your `NoteRow` should now look like this:

```swift
struct NoteRow: View {
    @Binding var notes: [Note]
    let index: Int

    var body: some View {
        TextField("take a note", text: $notes[index].title)
    }
}
```

### Customizing the Row Preview

You can customize the returned content from a preview provider to render exactly the previews that are most helpful to you in the Canvas. Let's play around with the `previewLayout()` modifier to create previews that actually look like rows.

* In the `NoteRow_Previews` struct, add the `.previewLayout()` modifier to the `previews` property to set it to a fixed size like so:

```swift
struct NoteRow_Previews: PreviewProvider {
    static let notes = [Note(title: "Note title...", content: "Note content...")]
    static var previews: some View {
        NoteRow(notes: .constant(notes), index: 0).previewLayout(.fixed(width: 300, height: 70))
    }
}
```

Previewing your views is a powerful feature as it lets you see all the possibilites your view can live in. You can also use the `.environment` modifer to preview your views in Dark Mode! You can also preview your views in other platforms like the AppleTV or Apple Watch.

## Using NoteRow With Our List

In your **Project Navigator (⌘1)** click on `ContentView.swift`

At this point, we are ready to show multiple notes by using multiple `NoteRow`s.  Define an array of notes including two default notes using the following var as the first line in the `ContentView` struct:

```swift
@State var notes: [Note] = [
    Note(title: "iOS is awesome", content: "It's true"),
    Note(title: "SES is awesome", content: "It's true")
]
```

We're ready to use our newly created `NoteRow`.

1. Replace the default Text view with our newly finished `NoteRow` and pass the initializer a note using our array:

```swift
struct ContentView: View {
    @State var notes: [Note] = [
        Note(title: "iOS is awesome", content: "It's true"),
        Note(title: "SES is awesome", content: "It's also true")
    ]
    var body: some View {
        NoteRow(notes: $notes, index: 0)
    }
}
```

As expected, only a single NoteRow is shown.  Now we want to show a NoteRow for each Note in the array.

2. Command-click on `NoteRow()`, and choose `Embed in List`

    ![Embed In List](../MarkdownAssets/EmbedInList.png)

4. Make the List span from `0 ..< 2` and update `NoteRow` to use the provided `item` closure parameter. `ContentView` should now look like this:

```swift
var body: some View {
    List(0 ..< 2) { item in
        NoteRow(notes: self.$notes, index: item)
    }
}
```
Here, we are "hard coding" the number of rows we want to show.  Let's instead use the size of our notes array to determine how many `NoteRow`s to create.

### Creating a Dynamic List with ForEach

When we use `List` or `ForEach` to make dynamic views, SwiftUI needs to know how it can identify each item *uniquely*, otherwise it’s not able to compare view hierarchies to figure out what has changed.

To accomplish this, modify the `Note` structure in `Note.swift` to make it conform to the **Identifiable** protocol, like this:

```swift
struct Note: Identifiable {
    let id = UUID()
    var content: String
    var title: String
}
```

> First, we added **Identifiable** to the list of protocol conformances. **Identifiable** means “this type can be identified uniquely.” The `Identifiable` protocol has only one requirement, which is that there must be a property called `id` that contains a unique identifier. We already added that to our `Note` struct, so we don’t need to do any extra work – our type conforms to **Identifiable**.
>
> Our `id` is a **UUID**, which is short for Universally Unique Identifier. You can read more about that [here](https://developer.apple.com/documentation/foundation/uuid).
>
> Notes are now guaranteed to be uniquely identifiable, and we won't need to tell our `ForEach` loop which property to use for the identifier – it knows there will be a unique `id`. You can read more about this [here](https://www.hackingwithswift.com/quick-start/swiftui/how-to-create-views-in-a-loop-using-foreach).

As a result of this change we can use the following code to display our list of notes. Modify the `List` code in `ContentView.swift` to match the following:

```swift
List {
    ForEach(notes.indices, id: \.self) { index in
        NoteRow(notes: self.$notes, index: index)
    }
}
```

### Adding a NavigationView

The List looks *okay*, but it seems a little plain. Most lists in iOS apps will have a navigation bar at their top, so let's add one now.

In `ContentView.swift`, wrap the `List` block in a `NavigationView`, and give the `List` a navigation bar title:

```swift
NavigationView {
    List {
        ForEach(notes.indices, id: \.self) { index in
            NoteRow(notes: self.$notes, index: index)
        }
    }
    .navigationBarTitle("Notes")
}
```

### Viewing the full note

To this point, we can only see and edit the title of each note.  We will need to create a new view to see and edit the content of a note.

* Create a new SwiftUI file called `NoteView.swift`.

Just like in the NoteRow, we'll add the following two vars at the beginning of the `NoteView` struct:

```swift
@Binding var notes: [Note]
let index: Int
```

Now, use a `TextView` (similar to a `TextField`, but supports multiple lines of text) to bind the note's `content` to the body:

```swift
var body: some View {
    TextView(text: $notes[index].content)
}
```

Let's also add the note's title in the navigation bar's title:

```swift
var body: some View {
    TextView(text: $notes[index].content)
        .navigationBarTitle(notes[index].title)
}
```

Lastly, let's setup the `NoteView_Previews` similarly to our NoteRow:

```swift
struct NoteView_Previews: PreviewProvider {
    static let notes = [Note(title: "Note title...", content: "Note content...")]
    static var previews: some View {
        NoteView(notes: .constant(notes), index: 0)
    }
}
```

### Navigating to our new screen

Now we have a beautiful new view, but no way of accessing it. Let's open up `ContentView.swift` and get to work.

```swift
NavigationLink(destination: NoteView(notes: self.$notes, index: index)) {
    NoteRow(notes: self.$notes, index: index)
}
```
We wrap our `NoteRow` in a `NavigationLink`.  A `NavigationLink` is a button that triggers a navigation presentation when pressed.  We specified that the destination of the link when pressed is our new `NoteView`.

### Testing it out, Part 2

<fill this in>

***

### Adding new notes

We can now see and edit each notes title and content.  But how can we add new notes?  We will do so by adding a plus icon button to the top right (called the "trailing") section of our navigation bar.  When tapped, we will add a new note to our notes array.

```swift
// ...
.navigationBarTitle("Notes")
.navigationBarItems(trailing: Button(action: {
    self.notes.insert(Note(title: "", content: ""), at: 0)
}) {
    Image(systemName: "plus")
})
```

Here we add a Button view to the trailing section of our navigation bar.  When tapped, we take action by inserting a new note with an empty title and content to the top of the array.

### Deleting and rearranging notes

What if we mess up while writing one of our notes? Right now, that's it. But it's not hard to fix, all we need to do is tell our List what to do when a user tries to delete an element. Again, we will be modifying `ContentView.swift`.

```swift
NavigationView {
    List {
        ForEach(noteStore.notes) { note in
            Text(note.title)
        }
        .onDelete { atIndexSet in
            self.noteStore.notes.remove(atOffsets: atIndexSet)
        }
    }
    .navigationBarTitle("Notes")
    .navigationBarItems(
        trailing:
        NavigationLink(destination: AddNoteView()) {
            Image(systemName: "plus")
        }
    )
}
```

> When a user swipes from right to left on a row, the `.onDelete` closure will run. We can use it to control how objects should be deleted from a collection. In practice, this is almost exclusively used with `List` and `ForEach`: we create a list of rows that are shown using `ForEach`, then attach `.onDelete` so the user can remove rows.

* The `.onDelete` modifier only exists on `ForEach`, so if we want users to delete items from a list we must put the items inside a `ForEach`
* The closure removes the note at the index that is being deleted
  * Since we modify the `noteStore`, and the `noteStore` is an EnvironmentObject, any views that rely on it will be updated, including the `ContentView`

We can add a similar closure, as well as a leading navigation bar item, to handle editing the list rows.

```swift
NavigationView {
    List {
        ForEach(noteStore.notes) { note in
            RowView(note: note)
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
        NavigationLink(destination: AddNoteView()) {
            Image(systemName: "plus")
        }
    )
}
```

* We added a leading `EditButton()` to our navigation bar
  * This is a special kind of `Button` that toggles the edit mode on/off for the current scope, in this case our `List`
  * Edit mode for a list is the state in which you can delete individual items, or rearrange them
* We added the `.onMove` closure that will run whenever a row is moved
  * The closure moves the specified rows from `sourceIndices` to the rows beginning at `destinationIndex`
  * Again, since SwiftUI is watching our state, this change to `noteStore` is reflected in our UI

### Testing it out, Part 3

Let's test this out once more. You should finally be able to get rid of your notes!

<img src="../MarkdownAssets/third_test.png" width=400/>

***

### Editing existing notes

The last major thing we need to take care of is editing the content of existing notes. Right now, if you click on any row in the List, nothing will happen. Let's start by creating a new `View` that will allow us to edit our notes.

1. Create a new SwiftUI file inside of the `Views` group and name it `NoteView.swift`
2. Start by adding the following two variables at the top of the struct

```swift
@EnvironmentObject var noteStore: NoteStore
var note: Note
```

> We already know what our EnvironmentObject is, and the second var should be straightforward. This will hold the `Note` that we are editing.

3. Add the following computed variable below the first two.

```swift
var noteIndex: Int {
    noteStore.notes.firstIndex(where: { $0.id == note.id }) ?? 0
}
```

> This is a little more complicated. Whenever we access `noteIndex`, the code inside will run. This code iterates over the `noteStore.notes` array, and finds the index of the first note that matches the `id` of our `var note`. 
>
> The `??` mean that if this function doesn't find any matching notes, we will return the index 0 instead. Now, this is not be the best idea in a production app, but it will suffice for now.
>
> We'll use this value later on in our view's `body`.

4. Replace the `body` of our `NoteView` with the following code.

```swift
VStack {
    TextField("Enter a title here", text: $noteStore.notes[noteIndex].title)
        .font(.title)
    TextView(text: $noteStore.notes[noteIndex].content)
}
.padding()
.navigationBarTitle("", displayMode: .inline)
```

> Hopefully, this looks familiar. It's basically the same code from our `AddNoteView` minus the navigation bar item.
>
> However, the key difference is that we are binding the `TextField` and the `TextView` to `$noteStore.notes[noteIndex].title`. In `AddNoteView` we bound to String variables so that we could create a new `Note`. Here, we bind directly to an existing note within the `noteStore`, since we want to edit that note. Any changes made in the `TextField` or `TextView` are reflected immediately in the `noteStore`, and elsewhere in the app.

#### Fixing our preview

Your preview for `NoteView` shouldn't work at this point. If you remember from before, we need to give our `NoteView` a `NoteStore` environment variable. However, this view also needs a `Note` to edit. However, that `Note` needs to exist in the `NoteStore` that you provide to the preview. Replace `static var previews` with the following.

```swift
static var previews: some View {
    let noteStore = NoteStore()
    return NoteView(note: noteStore.notes[0]).environmentObject(noteStore)
}
```

> This creates a NoteStore, and passes the first Note at index 0 to the preview. It also sets the evironment object to the same NoteStore.

### Adding Navigation to Our NoteView

Head back to `ContentView.swift` so we can navigate to our newly crated view.

Inside `ForEach`'s closure, wrap the returned row in a `NavigationLink`, specifying the `NoteView` view as the destination like so:

```swift
ForEach(noteStore.notes) { note in
    NavigationLink(destination: NoteView(note: note)) {
        NoteRow(note: note)
    }
}
```

### Testing it out, Part 4

We should be just about good at this point. Build and run your project once more to see if you're able to click on an existing note and edit its contents.

<img src="../MarkdownAssets/fourth_test.png" width=400/>

***
