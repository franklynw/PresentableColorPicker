//
//  PresentableColorPicker+Modifiers.swift
//  
//
//  Created by Franklyn Weber on 10/02/2021.
//

import SwiftUI


extension PresentableColorPicker {
    
    /// The title to use for the picker
    /// - Parameter title: a String
    public func title(_ title: String) -> Self {
        var copy = self
        copy.title = title
        return copy
    }
    
    /// The color to use for the background of the picker
    /// - Parameter backgroundColor: a UIColor
    public func backgroundColor(_ backgroundColor: UIColor) -> Self {
        var copy = self
        copy.backgroundColor = backgroundColor
        return copy
    }
    
    /// Normally, selecting a colour will dismiss the picker. Use this to disable that functionality (eg if you have a preview which shows how the colour will look in context)
    public var disableDismissOnSelection: Self {
        var copy = self
        copy.dismissOnSelection = false
        return copy
    }
}


extension View {
    
    /// View extension in the style of .sheet - lacks a couple of customisation options. If more flexibility is required, use PresentableColorPicker(...) directly, and apply the required modifiers
    /// - Parameters:
    ///   - isPresented: binding to a Bool which controls whether or not to show the picker
    ///   - selection: binding to a Color var for the selected colour
    public func presentableColorPicker(isPresented: Binding<Bool>, selection: Binding<Color>) -> some View {
        modifier(ColorPickerPresentationModifier(content: { PresentableColorPicker(isPresented: isPresented, selection: selection)}))
    }
    
    /// View extension in the style of .sheet - lacks a couple of customisation options. If more flexibility is required, use PresentableColorPicker(...) directly, and apply the required modifiers
    /// - Parameters:
    ///   - isPresented: binding to a Bool which controls whether or not to show the picker
    ///   - colorSelected: closure invoked with the selected colour when the user picks a colour
    public func presentableColorPicker(isPresented: Binding<Bool>, colorSelected: @escaping (Color) -> ()) -> some View {
        modifier(ColorPickerPresentationModifier(content: { PresentableColorPicker(isPresented: isPresented, colorSelected: colorSelected)}))
    }
}


struct ColorPickerPresentationModifier: ViewModifier {
    
    var content: () -> PresentableColorPicker
    
    init(@ViewBuilder content: @escaping () -> PresentableColorPicker) {
        self.content = content
    }
    
    func body(content: Content) -> some View {
        Group {
            content
            self.content()
        }
    }
}
