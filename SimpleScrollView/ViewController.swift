//
//  ViewController.swift
//  SimpleScrollView
//
//  Created by SUNG HAO LIN on 2021/11/23.
//

import UIKit
import SnapKit
import SwiftDate

/*
 🪓: totalLabelCount:  1310
 🪓: labelCountInShowView:  4.0
 🪓: space:  91.0
 🪓: width:  119292.687775061
 */
enum PlaybackDuration {
    case mins5
    case mins30
    case hours1
    case hours2
    case hours6
    case hours12
    case day1

    var duration: TimeInterval {
        switch self {
        case .mins5: return 300
        case .mins30: return 1800
        case .hours1: return 3600
        case .hours2: return 7200
        case .hours6: return 21600
        case .hours12: return 43200
        case .day1: return 86400
        }
    }

    var durationString:String {
        switch self {
        case .mins5: return "5m"
        case .mins30: return "30m"
        case .hours1: return "1h"
        case .hours2: return "2h"
        case .hours6: return "6h"
        case .hours12: return "12h"
        case .day1: return "1d"
        }
    }
}

class ViewController: UIViewController {

    var viewDuration: PlaybackDuration = .day1
    let totalLabelCount = 1310
    let space: CGFloat = 4

    private var labelDuration: TimeInterval {
        return viewDuration.duration / 4
    }

    private lazy var contentView: UIScrollView = {
       let contentView = UIScrollView()
        contentView.showsVerticalScrollIndicator = false
        contentView.showsHorizontalScrollIndicator = true
        contentView.isDirectionalLockEnabled = false
        contentView.isScrollEnabled = true
        contentView.bouncesZoom = false
        contentView.delegate = self
        return contentView
    }()

    // 裡面的 view，撐大 contentView
    private lazy var containerView: UIView = {
        let view = UIView()
        return view
    }()

    private var startDate: Date = Date.now
    let phoneWidth = UIScreen.main.bounds.width

    private func makeTimeLabel(count: Int) -> UILabel {
        let startTime = startDate.timeIntervalSince1970
        let currentTime = startTime + labelDuration * Double(count)
        let currentDate = Date(timeIntervalSince1970: currentTime)
        let label = UILabel()

        if currentDate.hour == 0 && currentDate.minute == 0 {
            label.text = "\(currentDate.month) / \(currentDate.day)"
            label.textColor = .black
            label.font = .systemFont(ofSize: 10, weight: .medium)
        } else {
            label.text = "\(currentDate.hourString):\(currentDate.minuteString)"
            label.textColor = .gray
            label.font = .systemFont(ofSize: 8, weight: .regular)
        }

        return label
    }

    private func makeTimeLineText(count: Int) -> String {
        let startTime = startDate.timeIntervalSince1970
        let currentTime = startTime + labelDuration * Double(count)
        let currentDate = Date(timeIntervalSince1970: currentTime)
        var text = ""

        if currentDate.hour == 0 && currentDate.minute == 0 {
            text = "\(currentDate.month) / \(currentDate.day)"
        } else {
            text = "\(currentDate.hourString):\(currentDate.minuteString)"
        }

        return text
    }

    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        view.backgroundColor = .white
        contentView.backgroundColor = .green
        containerView.backgroundColor = .red
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        print("🟡 phoneWidth: ", phoneWidth)

        view.addSubview(contentView)
        contentView.addSubview(containerView)

        contentView.snp.makeConstraints {
            $0.left.right.equalToSuperview()
            $0.height.equalTo(140)
            $0.center.equalToSuperview()
        }

        let contentSize = CGSize(width: 119292.687775061, height: 80)
        containerView.snp.remakeConstraints {
            $0.top.left.right.equalToSuperview()
            $0.width.equalTo(contentSize.width)
            $0.height.equalTo(contentSize.height)
        }

        for i in 0...totalLabelCount {
            let position = space * CGFloat(i)
            labelFlags.append(Position(index: i, position: position))
        }

        labelFlags.forEach { position in
            let text = makeTimeLineText(count: position.index)
            print("🔰 第 \(position.index) 個 Label, 位置：\(position.position), 顯示時間：\(text)")
        }
    }

    struct Position {
        let index: Int
        let position: CGFloat
    }

    var labelFlags: [Position] = []
}

extension ViewController: UIScrollViewDelegate {
    // 開始滑動時
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        print("🔰 開始滑動時")
    }

    // 滑動時
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        print("🔰 滑動時")
    }

    // 結束滑動
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        print("🔰 滑動時")
    }
}
