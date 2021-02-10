//
//  UIKitColorPicker.swift
//  
//
//  Created by Franklyn Weber on 10/02/2021.
//

import SwiftUI


struct UIKitColorPicker: UIViewControllerRepresentable {
    
    typealias UIViewControllerType = UIColorPickerViewController
    
    @Binding private var isPresented: Bool
    @Binding private var selection: Color
    private var colorSelected: ((Color) -> ())?
    
    var dismissOnSelection = true
    var title: String?
    
    
    init(isPresented: Binding<Bool>, selection: Binding<Color>) {
        _isPresented = isPresented
        _selection = selection
    }
    
    init(isPresented: Binding<Bool>, colorSelected: @escaping (Color) -> ()) {
        _isPresented = isPresented
        _selection = Binding<Color>(get: { .black }, set: { _ in })
        self.colorSelected = colorSelected
    }
    
    
    func makeUIViewController(context: UIViewControllerRepresentableContext<UIKitColorPicker>) -> UIViewControllerType {
        
        let controller = UIColorPickerViewController()
        controller.supportsAlpha = false
        controller.delegate = context.coordinator
        controller.title = title
        
        return controller
    }

    func updateUIViewController(_ uiViewController: UIViewControllerType, context: UIViewControllerRepresentableContext<UIKitColorPicker>) {
        
    }
    
    func makeCoordinator() -> UIKitColorPicker.Coordinator {
        Coordinator(self)
    }

    class Coordinator: NSObject, UIColorPickerViewControllerDelegate {

        let parent: UIKitColorPicker
        
        init(_ parent: UIKitColorPicker) {
            self.parent = parent
        }
        
        func colorPickerViewControllerDidSelectColor(_ viewController: UIColorPickerViewController) {
            
            let color = Color(viewController.selectedColor)
            
            parent.colorSelected?(color)
            parent.selection = color
            
            if parent.dismissOnSelection {
                parent.isPresented = false
            }
        }
        
        func colorPickerViewControllerDidFinish(_ viewController: UIColorPickerViewController) {
            parent.isPresented = false
        }
    }
}
