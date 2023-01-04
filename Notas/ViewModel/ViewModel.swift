//
//  ViewModel.swift
//  Notas
//
//  Created by Alexander Marenco on 21/12/22.
//

import Foundation
import CoreData
import SwiftUI

class ViewModel : ObservableObject{
    @Published var nota = ""
    @Published var fecha = Date()
    @Published var show = false
    
    //CoreData
    
    func saveData(context: NSManagedObjectContext){
        let newNota = Notas(context: context)
        
        newNota.nota = nota
        newNota.fecha = fecha
        
        do{
            try context.save()
            print("Guardo")
            show.toggle()
        }catch let error as NSError{
            print("No guardo", error.localizedDescription)
        }
    }
    
    func deleteData(item:Notas, context: NSManagedObjectContext){
        context.delete(item)
        
        do{
            try context.save()
            print("Elimino")
        }catch let error as NSError{
            print("No Elimino", error.localizedDescription)
        }
    }
}
