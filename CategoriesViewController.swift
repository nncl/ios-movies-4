//
//  CategoriesViewController.swift
//  MoviesLib
//
//  Created by Usuário Convidado on 17/03/17.
//  Copyright © 2017 EricBrito. All rights reserved.
//

import UIKit
import CoreData

class CategoriesViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    var dataSource: [Category] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadCategories()
    }
    
    func loadCategories() {
        let fetchRequest: NSFetchRequest<Category> = Category.fetchRequest()
        let sortDescriptor = NSSortDescriptor(key: "name", ascending: true)
        
        fetchRequest.sortDescriptors = [sortDescriptor]
        
        // Ao inves do fetchresultController, podemos pedir para o contexto executar a fetch 
        do {
            dataSource = try context.fetch(fetchRequest)
            tableView.reloadData()
        } catch {
            print(error.localizedDescription)
        }
    }
    
    @IBAction func add(_ sender: UIBarButtonItem) {
        let alert = UIAlertController(title: "Add Categoria", message: nil, preferredStyle: .alert)
        
        // Add textfield no alert
        alert.addTextField { (textField: UITextField) in
            textField.placeholder = "Nome da Categoria"
        }
        
        alert.addAction(UIAlertAction(title: "Adicionar", style: .default, handler: { (action: UIAlertAction) in
            let category = Category(context: self.context)
            category.name = alert.textFields?.first?.text
            
            do {
                try self.context.save()
                self.loadCategories()
            } catch {
                print(error.localizedDescription)
            }
        }))
        
        alert.addAction(UIAlertAction(title: "Cancelar", style: .cancel, handler: { (action: UIAlertAction) in
            // Dismiss by itself because of its style
        }))
        
        present(alert, animated: true, completion: nil)
    }
    
    @IBAction func close(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }

}

extension CategoriesViewController: UITableViewDelegate {
    
}

extension CategoriesViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        cell.textLabel?.text = dataSource[indexPath.row].name
        
        return cell
    }
}
