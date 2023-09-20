//
//  TimerCell.swift
//  BiometryProject
//
//  Created by Yani . on 20/09/23.
//

import UIKit

protocol CountDownCompleteDelegate : AnyObject {
    func countdownHasFinished(atIndex: Int)
}

class TimerCell: UITableViewCell {

    @IBOutlet weak var lblTimer: UILabel!

    var timer: Timer?
    weak var countdownCompleteDelegate: CountDownCompleteDelegate?
    static let identifier = "TimerCell"

    override func prepareForReuse() {
        super.prepareForReuse()
    }

    func calculateTimeRemaining(countdownTimer:(index: Int, createdAt: TimeInterval, duration: TimeInterval)) -> Double {
        return Double((countdownTimer.createdAt + countdownTimer.duration) - Date().timeIntervalSince1970)
    }

    func configureCell(withCountdownTimer countdownTimer: (index: Int, createdAt: TimeInterval, duration: TimeInterval)) {
        let timeRemaining = self.calculateTimeRemaining(countdownTimer: countdownTimer)
        self.lblTimer.text = "\(timeRemaining.timeRemainingFormatted())"
        if self.timer == nil {
            self.timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { timer in
                let newTime = self.calculateTimeRemaining(countdownTimer:
                countdownTimer)
                if newTime <= 0 {
                    self.countdownCompleteDelegate?.countdownHasFinished(atIndex:
                    countdownTimer.index)
                } else {
                self.lblTimer.text = newTime.timeRemainingFormatted()
                }
            }
        }
    }
}
