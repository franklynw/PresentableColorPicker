//
//  PresentableColorPicker.swift
//  Simplist
//
//  Created by Franklyn Weber on 10/02/2021.
//

import SwiftUI
import HalfASheet


public struct PresentableColorPicker: View {
    
    @Binding private var isPresented: Bool
    @Binding private var selection: Color
    private var colorSelected: ((Color) -> ())?
    
    internal var title: String?
    internal var backgroundColor: UIColor = .systemBackground
    internal var dismissOnSelection = true
    
    
    public init(isPresented: Binding<Bool>, selection: Binding<Color>) {
        _isPresented = isPresented
        _selection = selection
        colorSelected = nil
    }
    
    public init(isPresented: Binding<Bool>, colorSelected: @escaping (Color) -> ()) {
        _isPresented = isPresented
        _selection = Binding<Color>(get: { .black }, set: { _ in })
        self.colorSelected = colorSelected
    }
    
    public var body: some View {
        
        HalfASheet(isPresented: $isPresented, title: title ?? NSLocalizedString("Colour", bundle: Bundle.module, comment: "Colour")) {
            presentColorPicker()
                .background(Color(backgroundColor))
                .cornerRadius(15)
                .onAppear {
                    NotificationCenter.default.post(name: .presentableColorPickerAppeared, object: self)
                }
                .onDisappear {
                    NotificationCenter.default.post(name: .presentableColorPickerDisappeared, object: self)
                }
        }
        .disableDragToDismiss
    }
    
    private func presentColorPicker() -> UIKitColorPicker {
        
        var picker: UIKitColorPicker
        
        if let colorSelected = colorSelected {
            picker = UIKitColorPicker(isPresented: _isPresented, colorSelected: colorSelected)
        } else {
            picker = UIKitColorPicker(isPresented: _isPresented, selection: _selection)
        }
        
        picker.dismissOnSelection = dismissOnSelection
        
        return picker
    }
}
