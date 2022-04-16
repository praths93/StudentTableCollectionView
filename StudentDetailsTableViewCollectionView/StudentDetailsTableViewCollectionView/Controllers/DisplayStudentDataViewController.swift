import UIKit

class DisplayStudentDataViewController: UIViewController {
    
    //MARK: Outlet
    @IBOutlet weak var studentDetailsTV: UITableView!
    
    //MARK: Global Variables
    //var noData:UILabel = UILabel()
    var studentArray: [StudentDataModel] = []
    
    var studentIndexPath: IndexPath?
    
    //MARK: Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        createBarButton()
        
        self.studentDetailsTV.dataSource = self
        self.studentDetailsTV.delegate = self
        
        let studentTableViewCellXib = UINib(nibName: "StudentTableViewCell", bundle: .main)
        studentDetailsTV.register(studentTableViewCellXib, forCellReuseIdentifier: "StudentTableViewCell")
        
    }
    
    //MARK: Creat Navigation Bar Button
    private func createBarButton() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add,
                                                            target: self,
                                                            action: #selector(navigateToVC2ButtonAction))
        
    }
    
    //MARK: Button Action
    @objc func navigateToVC2ButtonAction() {
        guard
            let vc2 = self.storyboard?.instantiateViewController(withIdentifier: "AddStudentDataViewController") as? AddStudentDataViewController else {
                return
            }
        vc2.studentClosure = { (student) in
            self.studentArray.append(student)
            self.studentDetailsTV.reloadData()
            
        }
        self.navigationController?.pushViewController(vc2, animated: true)
    }
}
        //MARK: UITableViewDataSource
extension DisplayStudentDataViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if studentArray.count > 0
        {
            self.studentDetailsTV.backgroundView = nil
        } else {
            let noDataLabel: UILabel = UILabel()
            noDataLabel.text = "No Data Available"
            noDataLabel.textColor = UIColor(red: 20.0/255.0, green: 115.0/255.0, blue: 176.0/255.0, alpha: 1.0)
            noDataLabel.textAlignment = .center
            self.studentDetailsTV.backgroundView = noDataLabel
        }
        return studentArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier = "StudentTableViewCell"
        guard let cell = self.studentDetailsTV.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? StudentTableViewCell
        else {
            return UITableViewCell()
        }
        let studentIndex = studentArray[indexPath.row]
        cell.nameLabel.text = studentIndex.name
        cell.ageLabel.text = studentIndex.age
        cell.phoneLabel.text = studentIndex.phone
        cell.techLabel.text = studentIndex.tech
        
        return cell
    }
    
}
        //MARK: UITableViewDelegate
extension DisplayStudentDataViewController : UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        75
    }
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .delete
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            studentDetailsTV.beginUpdates()
            studentArray.remove(at: indexPath.row)
            studentDetailsTV.deleteRows(at: [indexPath], with: .fade)
            studentDetailsTV.endUpdates()
        }
    }
}
