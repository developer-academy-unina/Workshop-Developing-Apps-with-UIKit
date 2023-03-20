//
//  MentorDetailViewController.swift
//  Mentors_UIKit
//
//  Created by Giovanni Monaco on 22/03/23.
//

import UIKit

class MentorDetailViewController: UIViewController, UITextFieldDelegate  {
    
    var mentor: Mentor?

    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet var surnameTextField: UITextField!
    @IBOutlet weak var descriptionTextField: UITextField!
    @IBOutlet weak var saveButton: UIBarButtonItem!
    
    required init?(coder: NSCoder, mentor: Mentor?) {
        self.mentor = mentor
        super.init(coder: coder)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // Called when the view has been added to a view hierarchy.
    override func viewDidLoad() {
        super.viewDidLoad()

        // Setup after loading the view.
        if let mentor = mentor {
            nameTextField.text = mentor.name
            surnameTextField.text = mentor.surname
            descriptionTextField.text = mentor.description
            if let image = UIImage(named: mentor.imageName) {
                profileImageView.image = image
            } else {
                profileImageView.image = UIImage(named: "empty")
            }
        }
        updateSaveButtonState()
    }
    
    // Check if name and surname are empty to enable (or not) the save button
    func updateSaveButtonState() {
        let nameText = nameTextField.text ?? ""
        let surnameText = surnameTextField.text ?? ""
        saveButton.isEnabled = !nameText.isEmpty && !surnameText.isEmpty
    }
    
    // MARK: - TextField Delegate
    
    //Called when 'return' key pressed. Hides the keyboard.
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    //Called when the user click on the view (outside the UITextField). Hides the keyboard.
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    // MARK: - Navigation

    // Prepare for the Segue when save button is tapped
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard segue.identifier == "saveUnwind" else { return }
        let name = nameTextField.text?.capitalized ?? ""
        let surname = surnameTextField.text?.capitalized ?? ""
        let description = descriptionTextField.text
        mentor = Mentor(name: name, surname: surname, description: description)
    }
    
}
