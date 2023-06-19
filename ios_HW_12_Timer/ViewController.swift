//
//  ViewController.swift
//  ios_HW_12_Timer
//
//  Created by Ruslan Medetbayev on 19.06.2023.
//

import UIKit
import SnapKit

class ViewController: UIViewController {
    
    let timerLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 35)
        label.textAlignment = .center
        label.textColor = .black
        return label
    }()
    
    let startPauseButton: UIButton = {
        let button = UIButton()
        let startImage = UIImage(systemName: "play.fill")
        button.setImage(startImage, for: .normal)
        button.tintColor = .green
        return button
    }()
    
    var timer: Timer?
    var totalTimerSecond: Int = 25
    var isTimerRunning = false

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        startPauseButton.addTarget(self, action: #selector(startPauseButtonTapped), for: .touchUpInside)
        
    }
    
    func setupUI() {
        view.addSubview(timerLabel)
        view.addSubview(startPauseButton)
        
        timerLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview().offset(-50)
            make.width.equalTo(100)
            make.height.equalTo(50)
        }
        
        startPauseButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(timerLabel.snp.bottom).offset(20)
            
        }
    }
    
    
    func startTimer() {
        isTimerRunning = true
        let pauseImage = UIImage(systemName: "pause.fill")
        startPauseButton.setImage(pauseImage, for: .normal)
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
    }
    
    
    func pauseTimer() {
        isTimerRunning = false
        // Изменение иконки кнопки на иконку старта
        let startImage = UIImage(systemName: "play.fill")
        startPauseButton.setImage(startImage, for: .normal)
        timer?.invalidate()
        timer = nil
    }
    
    @objc func updateTimer() {
        if totalTimerSecond > 0 {
            totalTimerSecond -= 1
            let minutes = totalTimerSecond / 60
            let seconds = totalTimerSecond % 60
            timerLabel.text = String(format: "%02d:%02d", minutes, seconds)
        } else {
            stopTimer()
        }
    }
    
    @objc func startPauseButtonTapped() {
        if isTimerRunning {
            pauseTimer()
        } else {
            startTimer()
        }
    }
    
    func stopTimer() {
        pauseTimer()
        
    }


}

