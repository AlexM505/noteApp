//
//  Home.swift
//  Notas
//
//  Created by Alexander Marenco on 21/12/22.
//

import SwiftUI

struct Home: View {
    
    @StateObject var model = ViewModel()
    @FetchRequest(entity: Notas.entity(),
                  sortDescriptors: [NSSortDescriptor(key: "fecha", ascending: true)],
                  animation: .spring()) var results : FetchedResults<Notas>
    
    var body: some View{
        NavigationView{
            List{
                ForEach(results){ item in
                    VStack(alignment: .leading){
                        Text(item.nota ?? "Sin nota").font(.title2).bold()
                        Text(item.fecha ?? Date(), style: .date)
                    }
                }
            }.navigationTitle("Notas")
                .navigationBarItems(trailing: Button(action:{
                        model.show.toggle()
                    }){
                        Image(systemName: "plus").font(.title2).foregroundColor(.blue)
                    }.sheet(
                                isPresented: $model.show,
                                content: {
                                AddView(model: model)
                            })
                )
        }
    }
    
//    Button(action:{
//        model.show.toggle()
//    }){
//        Text("+")
//    }.sheet(
//        isPresented: $model.show,
//        content: {
//        AddView(model: model)
//    })
}
