//
//  CoursesViewController.swift
//  AppUIKit
//
//  Created by Samrez Ikram on 02/04/2023.
//

import UIKit

public protocol DataFetcable {
  func fetchCoursesNames(completion: @escaping ([String]) -> Void)
}

struct Courses {
  let name: String
}

public class CoursesViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

  let dataFetchable: DataFetcable
  
  private let tableView: UITableView = {
    let table = UITableView()
    table.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
    return table;
  }()
  
  var courses: [Courses] = []
  
  public init(dataFetchable: DataFetcable) {
    self.dataFetchable = dataFetchable
    super.init(nibName: nil, bundle: nil)
  }
  
  public required init?(coder: NSCoder) {
    fatalError()
  }
  
  public override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view.
    
    view.backgroundColor = .systemBackground
    
    dataFetchable.fetchCoursesNames { [weak self] names in
      self?.courses = names.map{ Courses(name: $0) }
      
      DispatchQueue.main.async {
        self?.tableView.reloadData()
      }
    }
    
  }
  
  public override func viewDidLayoutSubviews() {
    super.viewDidLayoutSubviews()
    view.addSubview(tableView)
    tableView.frame = view.bounds
    self.tableView.delegate = self
    self.tableView.dataSource = self
    self.tableView.backgroundColor = .systemBackground
  }
  
  public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return self.courses.count
  }
  
  public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
    cell.textLabel?.text = self.courses[indexPath.row].name
    return cell
    
  }

  /*
  // MARK: - Navigation

  // In a storyboard-based application, you will often want to do a little preparation before navigation
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
      // Get the new view controller using segue.destination.
      // Pass the selected object to the new view controller.
  }
  */

}
