import UIKit

class DisplayStudentCollectionViewController: UIViewController {
    
    //MARK: Outlet
    @IBOutlet weak var studentDetailCV: UICollectionView!
    
    //MARK: Global Variables
    var noData:UILabel = UILabel()
    var studentArray: [StudentDataModel] = []
    var studentIndexPath: IndexPath?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        createBarButton()
        self.studentDetailCV.dataSource = self
        self.studentDetailCV.delegate = self
        
        let StudentCollectionViewCellXib = UINib(nibName: "StudentCollectionViewCell", bundle: .main)
        studentDetailCV.register(StudentCollectionViewCellXib, forCellWithReuseIdentifier: "StudentCollectionViewCell")
        
    }
    
    //MARK: Creat Navigation Bar Button
    private func createBarButton() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(navigateToVC2ActionButton))
    }
    
    //MARK: Button Action
    @objc func navigateToVC2ActionButton() {
        guard
            let vc2 = self.storyboard?.instantiateViewController(withIdentifier: "AddStudentDataViewController") as? AddStudentDataViewController else {
                return
            }
        vc2.studentClosure = { (student) in
            self.studentArray.append(student)
            self.studentDetailCV.reloadData()
            
        }
        self.navigationController?.pushViewController(vc2, animated: true)
    }
}
//MARK: UICollectionViewDataSource
extension DisplayStudentCollectionViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if studentArray.count > 0
        {
            self.studentDetailCV.backgroundView = nil
        } else {
            let noDataLabel: UILabel = UILabel()
            noDataLabel.text = "No Data Available"
            noDataLabel.textColor = UIColor(red: 20.0/255.0, green: 115.0/255.0, blue: 176.0/255.0, alpha: 1.0)
            noDataLabel.textAlignment = .center
            self.studentDetailCV.backgroundView = noDataLabel
        }
        return studentArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cellIdentifier = "StudentCollectionViewCell"
        guard let cell = self.studentDetailCV.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as? StudentCollectionViewCell
        else {
            return UICollectionViewCell()
        }
        let studentIndex = studentArray[indexPath.row]
        cell.nameLabel.text = studentIndex.name
        cell.ageLabel.text = studentIndex.age
        cell.phoneLabel.text = studentIndex.phone
        cell.techLabel.text = studentIndex.tech
        
        return cell
    }
    
}
//MARK: UICollectionViewDelegateFlowLayout
extension DisplayStudentCollectionViewController : UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 200.0, height: 100.0)
    }
    
}
