//
//  LocationSearchView.swift
//  weather2
//
//  Created by Mikita Tratseuski on 12.10.23.
//

import SwiftUI

struct LocationSearchView: View {
    @Binding var isPresented: Bool
    
    var body: some View {
        // Добавьте код для представления модального представления поиска локации
        Text("Модальное представление для поиска локации")
        
        Button(action: {
            isPresented = false
        }) {
            Text("Закрыть")
        }
    }
}

#Preview {
    LocationSearchView(isPresented:  .constant(true))
}
