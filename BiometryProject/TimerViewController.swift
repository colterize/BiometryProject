//
//  TimerViewController.swift
//  BiometryProject
//
//  Created by Yani . on 20/09/23.
//

import UIKit

class TimerViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!

    var countdownTimers: [(index: Int, createdAt: TimeInterval, duration: TimeInterval)] = {
        return [(0, Date().timeIntervalSince1970, 5),
                (1, Date().timeIntervalSince1970, 10),
                (2, Date().timeIntervalSince1970, 15),
                (3, Date().timeIntervalSince1970, 86400)]
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        tableView.delegate = self
        tableView.dataSource = self

    }
    
}

extension TimerViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.countdownTimers.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell =  tableView.dequeueReusableCell(withIdentifier: TimerCell.identifier) as? TimerCell

        cell?.configureCell(withCountdownTimer: countdownTimers[indexPath.row])
        cell?.countdownCompleteDelegate = self

        return cell ?? UITableViewCell()
    }

}

extension TimerViewController: CountDownCompleteDelegate {
    func countdownHasFinished(atIndex: Int) {
//        self.countdownTimers.removeAll { $0.index == atIndex }
//        self.tableView.reloadData()
    }
}

extension Double {
    func timeRemainingFormatted() -> String {
        let duration = TimeInterval(self)
        let formatter = DateComponentsFormatter()
        formatter.unitsStyle = .brief
        formatter.allowedUnits = [ .hour, .minute, .second ]
        formatter.zeroFormattingBehavior = [ .pad ]
        return formatter.string(from: duration) ?? ""
    }
}

