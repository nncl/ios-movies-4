import UIKit

class MovieRegisterViewController: UIViewController {

    // MARK: - IBOutlets
    @IBOutlet weak var tfTitle: UITextField!
    @IBOutlet weak var tfScore: UITextField!
    @IBOutlet weak var lbCategories: UILabel!
    @IBOutlet weak var tfDuration: UITextField!
    @IBOutlet weak var tvSummary: UITextView!
    @IBOutlet weak var ivPoster: UIImageView!
    @IBOutlet weak var btAddUpdate: UIButton!
    
    var movie: Movie! // existe sem ter criado pq o coredata criou automagicamente quando criamos uma entidade, ou seja, representa a entidade. Temos acessa à entidade e a seus atributos
    
    // MARK: - Functions
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if movie != nil {
            tfTitle.text = movie.title
            tfScore.text = "\(movie.rating)"
            tfDuration.text = movie.duration
            tvSummary.text = movie.summary
            
            btAddUpdate.setTitle("Atualizar", for: .normal)
        }

    }

    @IBAction func close(_ sender: UIButton?) {
        dismiss(animated: true, completion: nil)
    }
    
    // Alimentamos o Movie com os dados
    @IBAction func addUpdateMovie(_ sender: UIButton) {
        if movie == nil {
            movie = Movie(context: context)
        }
        
        movie.title = tfTitle.text!
        movie.rating = Double(tfScore.text!)!
        movie.summary = tvSummary.text
        movie.duration = tfDuration.text
        
        // Vamos salvar, mas dispara exceção
        do {
            try context.save()
        } catch {
            print(error.localizedDescription)
        }
        
        close(nil)
    }
    
    
    
}
