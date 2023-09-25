import UIKit

final class SearchView: UIView {
    
    private var names = ["one", "one", "one", "one", "one", "one", "one", "one", "one", "one", "one", "one", "one", "one", "one", "one", "one", "one", "one", "one", "one", "one", "one", "one", "one", "one"]
    
    private lazy var tableView: UITableView = {
        let table = UITableView()
        table.isUserInteractionEnabled = true
        table.register(UITableViewCell.self, forCellReuseIdentifier: "cellId")
        table.delegate = self
        table.dataSource = self
        return table
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.isUserInteractionEnabled = false
        addSubview(tableView)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        tableView.frame = self.bounds
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension SearchView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        names.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellId", for: indexPath)
        cell.textLabel?.text = names[indexPath.row]
        return cell
    }
    
    
}

extension SearchView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100.0
    }
}
