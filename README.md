# Notes-App
Since you will be learning a pletheora of information during Capital One's software engineering summit, let's build an iOS app for taking notes. While building this app we'll cover the basics of iOS and Xcode.

# Step By Step Instructions

###
SwiftUI is a declarative framework for building applications for Apple devices. 
This means that instead of using Storyboards or programmatically generating your interface, you can use the simplicity of the SwiftUI framework.

## Initial Project and SwiftUI Setup

* New Project -> Single View App -> Choose `Swift` as Language and `SwiftUI` as User Interface
* When you create a new project, Xcode provides a default `ContentView.swift` file.
 
* Next go to **Project Navigator** (⌘1) and add a new file to the project
  * Use the standard **Swift File** option then hit next
  * You are going to define a type for the notes that will go on your list so name your class as `Note`
  * Click Next and then Create
  
### A few words on `Note Model`
A note is going to be what we call a data model or more simply, a model.
A model is a way to structure data, so that you can work inside your app's code and have a type that represents a real-world concept, like a note.

   * Next you need to organize your models into groups.
   * For that you need to make sure that your Note.swift is inside the Notes folder first.
   * Now right-click on Note.swift and select **New Group from Selection**.
   * That will enclose it in a folder. Name this folder as Models.

We will be using structures inside the file to represent our `Note` model for storing information about Notes:
  ```swift
    struct Note {
    var name: String
 }
```
    > Every note needs to have a name and that name should be changeable, so a variable (var) is a way to go with a type String. This is the way to create a note but this app is going to be able to store as many notes as you want. Now you will need a place to keep track of all of those notes and that, too, is going to be a model.

### Creating the NoteStore Model
* Create a new swift file which we will use to declare our `NoteStore` model
  * Right-click on the Models folder and add a new file.
  * File -> New -> File -> Swift File
  * Name the file `NoteStore.swift`
  * Notes app is going to have one NoteStore, but you will need to use it across several screens, so a reference type that is class is what you need NoteStore to be.

```swift
    class NoteStore {
    var notes = [
    "Pay the electricity bill",
    "Pay the electricity bill Get my car washed",
    "Made assignment"
        ].map { Note(name: $0) }		
    }
```
   > Created a variable array names `notes` as property of NoteStore and pre-populate the array with three notes and used map closure to transform our name strings to full fledged notes. Now, with our notes ready we will take advantage of the SwiftUI to display on a GUI. We will be using a List to display the content. 


### Displaying notes on user interface.
   * A List is a container which displays your data in a column, with a row for each entry.
   * For this open `ContentView.swift` file.
   * At the moment, `ContentView.swift` file is still fresh from the template, with a `Hello World` Text View.
   * Command-click on `Text View`, and choose Embed in List.
   
  ![Embed In List](/Assets/MarkdownAssets/EmbedInList.png)

   * At this point you have your pre-defined list of notes ready to be displayed for UI.
   * In order to accomplish this let's define a property and create an instance of a `NoteStore`, in your `ContentView`.
```swift
    var noteStore: NoteStore
```
When we use List or ForEach to make dynamic views, SwiftUI needs to know how it can identify each item uniquely otherwise it’s not able to compare view hierarchies to figure out what has changed.
To accomplish this modify the Note structure to make it conform to a new protocol called Identifiable, like this:
  ```swift
    struct Note: Identifiable {

    let id = UUID()
    var name: String
 }
```
   > All we’ve done is add Identifiable to the list of protocol conformances, nothing more. This is one of the protocols built into Swift, and means “this type can be identified uniquely.” It has only one requirement, which is that there must be a property called id that contains a unique identifier. We just added that, so we don’t need to do any extra work – our type conforms to Identifiable just fine. Notes are now guaranteed to be identifiable uniquely, we no longer need to tell ForEach which property to use for the identifier – it knows there will be an id property and that it will be unique, because that’s the point of the Identifiable protocol.

   * As a result of this change we can modify the ForEach in ContentView, to this:
```swift
   ForEach(noteStore.notes) { note in
                Text(note.name)
            }
```
* In SwiftUI, there is a type of modal view, which takes up almost the entire screen. It's called a `sheet` and you can add one to a view using the sheet methods. 
     A sheet requires a `Bool binding` to know where it should be presented and because you are only going to be launching the sheet from your ContentView,
     you can provide that binding by way of a State variable.
    * We will now define a state variable `modalIsPresented` to know when the sheet should be presented. By default we will keep the value of this state variable as `false`.
    * We will turn modalIsPresented value as true on pressing `+` button on navigation bar.

```swift
   @State var modalIsPresented = false
```
We will add more UI elements to our first view. First embed your list inside a NavigationView and add trailing and leading navigation bar buttons as follows:
```swift
   NavigationView {
        List {
            ForEach(noteStore.notes) { index in
              Text(note.name)
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
```

As the NavigationView is all setup, you can now add a sheet by searching `sheet` in the modifier tab on Library. You can easily drag the `sheet` on your canvas.
```swift
   .sheet(isPresented: $modalIsPresented) {
      NoteDetail()
   }
```
   

### Creating New Notes
For adding new notes we will be creating a new SwiftUI file and will name it as `NoteDetail.swift`.
   * Use a TextFiled as its body using this initializer:
```swift
	TextField("Name", text: $note.name)
```
   * Set the placeholder title to `Name`
   * Set the text argument to a new @state variable
   * Now hit Shift + command + L to bring up the library, search for `TextFiled` and add inside the view's body.
   * We’ll also adding a button with title as `Add` which will used to update Notes array.

To combine the TextField and Add button on `NoteDetails.swift` view will will use `Form` container and put both of these UI elements inside it as follows:
```swift
TextField("Add note here", text: $text)
      Button("Add") {
      }
      .disabled(text.isEmpty)
    }
```

* We will define a variable of type NoteStore in the same class and update above code to add a new Note when user performs button action.
```swift
Button("Add") {
        self.noteStore.notes.append(
          Note(name: self.text)
        )
      }
```
   * As of now we are able to add new note in our NoteStore but when we clicked on `Add` button it didn’t dismiss the `sheet` for us. 
   * Every SwiftUI view exists in an environment which is a storage container for information that it either needs to function.
   * To dismiss the sheet we will be taking advantage of `SwiftUI’s Environment` and will add an Environment view property.
   * This Environment view property would let us to know if the sheet is already presented and would also allow us to dismiss the sheet programatically.
   * The syntax for this starts with an Environment attribute and set of parentheses, inside the parentheses we will provide the key path which is backslash dot presentationMode.
   * This gives you an access to environment’s presentationMode but we need to let compiler know how
      we are going to refer this inside the class. For this we will supply a var name as follows:

```swift
@Environment(\.presentationMode) var presentationMode
```
   > You can check by click on presentationMode that its a binding to a presentationMode instance. Within the button action you need to access presentationMode instance itself. To get the value that a binding encapsulates, use the wrappedValue property. You will use this wrapped value to dismiss the sheet.
```swift
	self.presentationMode.wrappedValue.dismiss()
```

## Deleting from the List
SwiftUI gives us the onDelete() modifier for us to use to control how objects should be deleted from a collection.
In practice, this is almost exclusively used with List and ForEach: we create a list of rows that are shown using ForEach, then attach onDelete() to that ForEach so the user can remove rows they don’t want.
   
* The onDelete() modifier only exists on ForEach, so if we want users to delete items from a list we must put the items inside a ForEach.
 
```swift
    .onDelete { atIndexSet in
        self.noteStore.notes.remove(atOffsets: atIndexSet)
            }
```
   > Given how easy that was. We can also add an Edit/Done button to the navigation bar, that lets users delete several rows more easily.
```swift
    .navigationBarItems(
        leading: EditButton()
    )
```


To be continued...

