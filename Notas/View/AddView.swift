//
//  AddView.swift
//  Notas
//
//  Created by Alexander Marenco on 21/12/22.
//

import SwiftUI

struct AddView: View {
    
    @ObservedObject var model : ViewModel
    @Environment(\.managedObjectContext) var context
    
    var body: some View {
        VStack{
            Text("Agregar nota").font(.largeTitle).bold()
            Spacer()
            TextEditor(text: $model.nota)
            Divider()
            DatePicker("Seleccionar fecha",selection: $model.fecha)
            Spacer()
            Button(action:{
                model.saveData(context: context)
            }){
                Label(title: {
                    Text("Guardar").foregroundColor(.white).bold()
                }, icon: {
                    Image(systemName: "plus").foregroundColor(.white)
                })
            }.padding()
            .frame(width: UIScreen.main.bounds.width - 30)
            .background(Color.blue)
            .cornerRadius(8)
        }.padding()
    }
}
