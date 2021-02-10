# PresentableColorPicker

A Colour Picker pretty much identical to Apple's ColorPicker (in that it uses the UIColorPickerViewController), except that this one can be presented in the way common to sheets, etc, with a bound 'isPresented' boolean var.


## Installation

### Swift Package Manager

In Xcode:
* File ⭢ Swift Packages ⭢ Add Package Dependency...
* Use the URL https://github.com/franklynw/PresentableColorPicker


## Example

> **NB:** All examples require `import PresentableColorPicker` at the top of the source file

It can be used directly as a view, which offers the full range of customisation options -

```swift
var body: some View {
    
    PresentableColorPicker(isPresented: $isStandaloneColorPickerPresented) {
        viewModel.paintColor = $0
    }
    .backgroundColor(viewModel.backgroundColor)
    .disableDismissOnSelection
}
```

or as a modifier, which presents the default colour picker (with no customisation options) -

```swift
var body: some View {

    MyView {
    
    }
    .presentableColorPicker(isPresented: $isStandaloneColorPickerPresented, Binding: $viewModel.paintColor)
}
```

Both of these methods allow you to specify either a binding to a Color var, or use a 'colorSelected' closure which is invoked when the colour is picked.


### Disable the automatic "dismiss on selection" functionality

This might be necessary if you have (eg) a preview visible above the picker, where you can see how your selected colour looks - the user can then decide when to dismiss the picker

```swift
PresentableColorPicker(isPresented: $isStandaloneColorPickerPresented, selected: $viewModel.paintColor)
    .disableDismissOnSelection
```

### Set the picker's background colour

```swift
PresentableColorPicker(isPresented: $isStandaloneColorPickerPresented, selected: $viewModel.paintColor)
    .backgroundColor(.lightGray)
```

## Additionally...

There are two NotificationCenter notifications which are sent, which are defined as static vars on Notification.Name -

* presentableColorPickerAppeared ("PresentableColorPickerAppearedNotification")
* presentableColorPickerDisappeared ("PresentableColorPickerDisappearedNotification")

These are sent as their names suggest, and there is no additional userInfo


## Dependencies

Requires HalfASheet, which is linked. Take a look at it [here](https://github.com/franklynw/HalfASheet)


## License  

`PresentableColorPicker` is available under the MIT license
