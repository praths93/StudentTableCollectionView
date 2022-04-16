import UIKit

class AddStudentDataViewController: UIViewController {
    
//    let field: UITextField = {
//        let field = UITextField()
//        return field
//    }()
//
    
    //MARK: Outlets
    @IBOutlet weak var nameTF: UITextField!
    // Tags are used to Auto Jump to next TextField.
//    { didSet {
//                nameTF.tag = 1
//                nameTF.delegate = self    }  }
    @IBOutlet weak var phoneTF: UITextField!
//    { didSet {
//                phoneTF.tag = 2
//                phoneTF.delegate = self    }  }
    @IBOutlet weak var ageTF: UITextField!
//    { didSet {
//                ageTF.tag = 3
//                ageTF.delegate = self    }  }
    @IBOutlet weak var techTF: UITextField!
//    { didSet {
//                techTF.tag = 4
//                techTF.delegate = self    }  }
    
    //MARK: Global Variables
    var personData: StudentDataModel?
    var studentClosure : ((StudentDataModel) -> ())? //Backdata Passing using Closure
    //MARK: Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        view.addSubview(field)
        
//        nameTF.tag = 1
//        nameTF.delegate = self
        
//        let tapGestureReconizer = UITapGestureRecognizer(target: self, action: #selector(AddStudentDataViewController.tap(_:)))
//                view.addGestureRecognizer(tapGestureReconizer)
        
        navigationItem.hidesBackButton = true
        
        self.nameTF.text = personData?.name
        self.phoneTF.text = personData?.phone
        self.ageTF.text = personData?.age
        self.techTF.text = personData?.tech
        
    }
    
    //MARK: Button Action to Save Data
    @IBAction func saveDataActionButton() {
        
        if let closure = studentClosure {
            
            guard let nameG = self.nameTF.text,
                  nameG.count > 0 else {
                      print("nameG is nil")
                      displayIncompleteStudentDetailAlert(message: "Please Enter Name")
                      return
                  }
            guard let phoneG = self.ageTF.text,
                  phoneG.count > 0 else {
                      print("phoneG is nil")
                      displayIncompleteStudentDetailAlert(message: "Please Enter Age")
                      return
                  }
            guard let ageG = self.phoneTF.text,
                  ageG.count > 0 else {
                      print("ageG is nil")
                      displayIncompleteStudentDetailAlert(message: "Please Enter Phone Number")
                      return
                  }
            guard let techG = self.techTF.text,
                  techG.count > 0 else {
                      print("techG is nil")
                      displayIncompleteStudentDetailAlert(message: "Please Enter Technology")
                      return
                  }
            let studentC = StudentDataModel(name: nameG,
                                            phone: phoneG,
                                            age: ageG,
                                            tech: techG)
            closure(studentC)
            displayStudentDetailAlert()
            //            if (studentC.name?.count == 0) ||
            //                (studentC.age?.count == 0) ||
            //                (studentC.phone?.count == 0) ||
            //                (studentC.tech?.count == 0) {
            //
            //                displayIncompleteStudentDetailAlert()
            //
            //            } else {
            //                displayStudentDetailAlert()
            //                closure(studentC)
            //            }
        } else {
            print("closure is Nil")
        }
    }
    
    //MARK: Display Alert Complete Data Added Successfully
    private func displayStudentDetailAlert() {
        // Create new Alert
        let dialogMessage = UIAlertController(title: "Student Data!!", message: "Student Data Added Successfully", preferredStyle: .alert)
        
        // Create OK button with action handler
        let ok = UIAlertAction(title: "OK", style: .default, handler: { (action) -> Void in
            self.navigationController?.popViewController(animated: true)
            print("Ok button tapped")
        })
        
        //Add OK button to a dialog message
        self.clearText()
        dialogMessage.addAction(ok)
        
        // Present Alert to
        self.present(dialogMessage, animated: true, completion: nil)
    }
    
    //MARK: Display Alert Incomplete Data Not Added
    private func displayIncompleteStudentDetailAlert(message: String) {
        // Create new Alert
        let dialogueMessage = UIAlertController(title: "Student Data Incomplete!!",
                                                message: message,
                                                preferredStyle: .alert)
        
        // Create OK button with action handler
        let edit = UIAlertAction(title: "Re-Edit", style: .default, handler: nil)
        
        //Add OK button to a dialog message
        dialogueMessage.addAction(edit)
        
        // Present Alert to
        self.present(dialogueMessage, animated: true, completion: nil)
    }
    
    //MARK: Clear Texts
    private func clearText() {
        nameTF.text = ""
        ageTF.text = ""
        phoneTF.text = ""
        techTF.text = ""
    }
}

extension AddStudentDataViewController: UITextFieldDelegate {
    
//    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
//       //Check if there is any other text-field in the view whose tag is +1 greater than the current text-field on which the return key was pressed. If yes → then move the cursor to that next text-field. If No → Dismiss the keyboard
//       if let nextField = self.view.viewWithTag(textField.tag + 1) as? UITextField {
//           nextField.becomeFirstResponder()
//       } else {
//           textField.resignFirstResponder()
//       }
//       return false
//   }
//
//    @objc func tap(_ sender: UITapGestureRecognizer) {
//            view.endEditing(true)
//        }
    
    
}
