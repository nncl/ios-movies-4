//
//  MoviesTableViewController.swift
//  MoviesLib
//
//  Created by Usuário Convidado on 08/03/17.
//  Copyright © 2017 EricBrito. All rights reserved.
//

import UIKit
import CoreData

class MoviesTableViewController: UITableViewController {
    
    // var fetchedResultController: NSFetchedResultsController!
    // responsável por efetuar a "busca" no banco
    // Devemos informar qual tipo de entidade, pois é genérico
    var fetchedResultController: NSFetchedResultsController<Movie>!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        
        tableView.estimatedRowHeight = 106
        tableView.rowHeight = UITableViewAutomaticDimension
        
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: 200, height: 22))
        label.text = "Sem filmes"
        label.textAlignment = .center
        label.textColor = .white
        
        tableView.backgroundView = label
        
        loadMovies()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // Ocorre antes de carregar
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let vc = segue.destination as? MovieViewController {
            vc.movie = fetchedResultController.object(at: tableView.indexPathForSelectedRow!)
        }
    }
    
    // MAKK: - Methods
    
    func loadMovies() {
        // Criar request
        let fetchRequest : NSFetchRequest<Movie> = Movie.fetchRequest()
        let sortDescriptor = NSSortDescriptor(key: "title", ascending: true)
        fetchRequest.sortDescriptors = [sortDescriptor]
        
        fetchedResultController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: context, sectionNameKeyPath: nil, cacheName: nil) // nao vamos usar os 2 ultimos, kind of advanced heheheh
        
        // **
        fetchedResultController.delegate = self // vamos implementar esse protocolo
        
        // Let's execute this request
        do {
            try fetchedResultController.performFetch() // todos os resultados ficam aqui, ele é o datasource agora
        } catch {
            print(error.localizedDescription)
        }
        
        // tá mas como sabemos quando terminou?? delegatessss**
    }
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        // return 0 //dataSource.count
        if let count = fetchedResultController.fetchedObjects?.count {
            return count
        } else {
            return 0
        }
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "movieCell", for: indexPath) as! MovieTableViewCell

        // Preparar table
        // fetchedResultController é o datasource agora
        let movie = fetchedResultController.object(at: indexPath)
        
        // Agora vamos alimentar a celula
        cell.lbRating.text = "\(movie.rating)"
        cell.lbTitle.text = movie.title
        cell.lbSummary.text = movie.summary
        
        return cell
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

extension MoviesTableViewController: NSFetchedResultsControllerDelegate {
    // disparado toda vez que modifica o conteúdo interno, que é o que faz quando termina o fetch
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.reloadData()
    }
}





