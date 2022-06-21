# Wallbox Challenge

For this challengue I have used an MVVM architecture, with a reactive view in SwiftUI. The business logic has Use Cases that access a Gateway with two Data Sources that are abstractions, so that they could be substituted both by another backend client and by another more complex database.

The storage stores the data in an internal variable, I could have used another type of persistence such as NSCache, or some custom, but I have not seen it necessary to add that complexity. Same with the backend client.

Although due to lack of time I have not been able to test 100% of the app, I think it is clear that the app is perfectly testable.

## Advise

If the graphics library gives an error when compiling the app, right click and select update it 
