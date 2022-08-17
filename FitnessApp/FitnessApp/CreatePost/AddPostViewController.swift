//
//  AddPostViewController.swift
//  FitnessApp
//
//  Created by Caleb Ngai on 8/15/22.
//

import UIKit

class AddPostViewController: UIViewController {

//MARK: - Properties
    weak var coordinator: AddPostCoordinator?
    private let viewModel = AddPostViewModel()
    private var postType: PostType
    
    private var runView: AddPostRunView?
    
    init(postType: PostType) {
        self.postType = postType
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        title = postType.rawValue
        //configureNavBar()
        configureForRun()
    }

    private func configureNavBar() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .close, target: self, action: #selector(didTapClose))
    }
    
    @objc private func didTapClose() {
        coordinator?.popVC(sender: self)
    }
}

//MARK: - Run
extension AddPostViewController: AddPostRunViewDelegate, UITextFieldDelegate {
    private func configureForRun() {
        runView = AddPostRunView(frame: CGRect(x: 0, y: 50, width: view.width, height: view.height - 50))
        runView?.delegate = self
        runView?.nameField.delegate = self
        runView?.durationField.delegate = self
        runView?.distanceField.delegate = self
        
        guard let runView = runView else {return}
        view.addSubview(runView)
    }
    
    func didTapSaveButton(_ view: AddPostRunView) {
        guard let runview = runView,
              let name = runview.nameField.text,
              let distance = runview.distanceField.text,
              let duration = runview.durationField.text,
              !name.trimmingCharacters(in: .whitespaces).isEmpty,
              !distance.trimmingCharacters(in: .whitespaces).isEmpty,
              !duration.trimmingCharacters(in: .whitespaces).isEmpty
        else {return}
        
        coordinator?.popVC(sender: self)
        Task {
            try await AddPostViewModel.insertRunPost(
                runName: name,
                duration: (duration as NSString).doubleValue,
                distance: (distance as NSString).doubleValue,
                date: Date()
            )
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == runView?.nameField {
            resignFirstResponder()
            runView?.distanceField.becomeFirstResponder()
        } else if textField == runView?.distanceField {
            resignFirstResponder()
            runView?.durationField.becomeFirstResponder()
        } else {
            guard let runView = runView else {return false}
            didTapSaveButton(runView)
        }
        return true
    }
}
