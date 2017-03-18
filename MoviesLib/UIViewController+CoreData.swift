//
//  UIViewController+CoreData.swift
//  Quem vai vincular o appdelegate com o coredata
//  Forma mais facil de acessar
//

import CoreData
import UIKit

extension UIViewController {
    
    // Retorna o delegate do app
    var appDelegate: AppDelegate {
        return UIApplication.shared.delegate as! AppDelegate
    }
    
    // Acesso ao context, que manipula os arquivos
    var context: NSManagedObjectContext {
        return appDelegate.persistentContainer.viewContext
    }
}
