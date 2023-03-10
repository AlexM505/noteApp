//
//  Home.swift
//  Notas
//
//  Created by Alexander Marenco on 21/12/22.
//

import SwiftUI

struct Home: View {
    
    @Environment(\.managedObjectContext) var context
    @StateObject var model = ViewModel()
    @FetchRequest(entity: Notas.entity(),
                  sortDescriptors: [NSSortDescriptor(key: "fecha", ascending: true)],
                  animation: .spring()) var results : FetchedResults<Notas>
    
    //Predicado
//    @FetchRequest(entity: Notas.entity(),
//                  sortDescriptors: [],
//                  predicate: NSPredicate(format:"fecha >= %@",Date() as CVarArg),
//                  animation: .spring()) var results : FetchedResults<Notas>
    
    var body: some View{
        NavigationView{
            List{
                ForEach(results){ item in
                    VStack(alignment: .leading){
                        Text(item.nota ?? "Sin nota").font(.title2).bold()
                        Text(item.fecha ?? Date(), style: .date)
                    }.contextMenu(menuItems: {
                        Button(action:{
                            model.sendData(item: item)
                        }){
                            Label(title:{
                                Text("Editar")
                            }, icon:{
                                Image(systemName: "pencil")
                            })
                        }
                        Button(action:{
                            model.deleteData(item: item, context: context)
                        }){
                            Label(title:{
                                Text("Eliminar")
                            }, icon:{
                                Image(systemName: "trash")
                            })
                        }
                    })
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
