//
//  TodoListVC.swift
//  TodoList
//
//  Created by Vikas S on 17/09/21.
//

import UIKit

class TodoListVC: UIViewController {

    @IBOutlet weak var todoSegmentedControl: UISegmentedControl!
    @IBOutlet weak var todoListTableView: UITableView!
    private var todoListViewModel = TodoListViewModel()
    override func viewDidLoad() {
        super.viewDidLoad()
        setupVC()
    }
    
    private func setupVC(){
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add,
                                                            target: self,
                                                            action: #selector(didTapAdd))
        todoListTableView.delegate = self
        todoListTableView.dataSource = self
        todoListTableView.register(UINib(nibName: TodoListTVC.reusableIdentifier, bundle: nil), forCellReuseIdentifier: TodoListTVC.reusableIdentifier)
//        todoListViewModel.items.bind { [weak self] _ in
//            guard let `self` = self else { return }
//            self.todoListTableView.reloadData()
//        }
        todoListViewModel.completion = {[weak self] items in
            guard let `self` = self else { return }
            self.todoListTableView.reloadData()
        }
    }

    @IBAction func didChangeTodoSegment(_ sender: UISegmentedControl) {
        todoListViewModel.getTodoList(selectIndex: todoSegmentedControl.selectedSegmentIndex)
    }
    
    @objc private func didTapAdd(){
        showTaskInfoRequesterView()
    }
    
    private func showTaskInfoRequesterView(editIndex: Int? = nil){
        let alert = UIAlertController(title: (editIndex != nil) ? "Edit Task" : "Add Task",
                                      message: "Enter new item",
                                      preferredStyle: .alert)
        alert.addTextField { (textField) in
            textField.placeholder = "Title"
        }
        alert.addTextField { (textField) in
            textField.placeholder = "Description"
        }
        alert.addAction(UIAlertAction(title: "Submit", style: .cancel, handler: { [weak self] _ in
            guard let `self` = self else { return }
            guard let titleField = alert.textFields?.first,let descField = alert.textFields?.last, let title = titleField.text, !title.isEmpty else{
                return
            }
            if let index = editIndex{
                self.todoListViewModel.modifyTask(title: title, desc: descField.text, selectedItem: self.todoListViewModel.items.value[index], selectIndex: self.todoSegmentedControl.selectedSegmentIndex)
            }else{
                self.todoListViewModel.addTask(title: title, desc: descField.text, selectIndex: self.todoSegmentedControl.selectedSegmentIndex)
            }
        }))
        present(alert, animated: true)
    }
    
    private func showEditTaskInfoRequesterView(selectedIndex index: Int){
        let alert = UIAlertController(title: "Edit Task",
                                      message: "",
                                      preferredStyle: .alert)
    
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        alert.addAction(UIAlertAction(title: "Edit", style: .default, handler: {[weak self] _ in
            guard let `self` = self else { return }
            self.showTaskInfoRequesterView(editIndex: index)

        }))
        
        alert.addAction(UIAlertAction(title: "Delete", style: .destructive, handler: {[weak self] _ in
            guard let `self` = self else { return }
            
            self.todoListViewModel.deleteTask(selectedItem: self.todoListViewModel.items.value[index], selectIndex: self.todoSegmentedControl.selectedSegmentIndex)
            
        }))
        present(alert, animated: true)
    }
}

//MARK:- TableViewDelegate && TableViewDataSource
extension TodoListVC: UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return todoListViewModel.items.value.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: TodoListTVC.reusableIdentifier, for: indexPath) as! TodoListTVC
        let todoItem = todoListViewModel.items.value[indexPath.row]
        cell.setupViewOnCreation(title: todoItem.title ?? "", desc: todoItem.desc)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        showEditTaskInfoRequesterView(selectedIndex: indexPath.row)
    }
}
