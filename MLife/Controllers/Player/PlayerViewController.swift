//
//  PlayerViewController.swift
//  MLife
//
//  Created by Nguyễn Hữu Toàn on 10/08/2022.
//

import UIKit
import SDWebImage

class PlayerViewController: UIViewController {
    
    weak var dataSource: TransmissionDataSource?
    weak var delegate: PlayerViewControllerDelegate?
    
    
    
    public var isPlaying = true
    public var position = 0;
    public var isRepeat = false;
    public var checkRandom = false;
    public var isNext = false;

    // MARK: - Cover image
    private let disk = UIView()
    
    private let playCoverImage: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    // MARK: - Controls 
    private let controlsPlayer = UIView()
    private var stack = UIStackView()
    
    private let sliderSong: UISlider = {
        let slider = UISlider()
        slider.tintColor = UIColor.systemGreen
        slider.isContinuous = true
        return slider
    }()
    
    private let nameSong: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.text = "___"
        label.textColor = .black
        label.font = .systemFont(ofSize: 18, weight: .bold)
        return label
    }()
    
    private let descriptionSong: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.text = "___"
        label.textColor = .systemGreen
        label.font = .systemFont(ofSize: 15, weight: .semibold)
        return label
    }()
    
    private let shuffleButton: UIButton = {
        let button = UIButton()
        button.tintColor = .black
        button.setImage(UIImage(systemName: "shuffle", withConfiguration: UIImage.SymbolConfiguration(pointSize: 25, weight: .light)), for: .normal)
        return button
    }()
    
    fileprivate let previousButton: UIButton = {
        let button = UIButton()
        button.tintColor = .black
        button.setImage(UIImage(systemName: "backward.end.fill", withConfiguration: UIImage.SymbolConfiguration(pointSize: 35, weight: .light, scale: .small)), for: .normal)
        return button
    }()
    
    fileprivate let playPauseButton: UIButton = {
        let button = UIButton()
        button.tintColor = .black
        button.setImage(UIImage(systemName: "pause.circle", withConfiguration: UIImage.SymbolConfiguration(pointSize: 80, weight: .light, scale: .small)), for: .normal)
        return button
    }()
    
    fileprivate let nextButton: UIButton = {
        let button = UIButton()
        button.tintColor = .black
        button.setImage(UIImage(systemName: "forward.end.fill", withConfiguration: UIImage.SymbolConfiguration(pointSize: 35, weight: .light, scale: .small)), for: .normal)
        return button
    }()
    
    fileprivate let repeatButton: UIButton = {
        let button = UIButton()
        button.tintColor = .black
        button.setImage(UIImage(systemName: "repeat", withConfiguration: UIImage.SymbolConfiguration(pointSize: 25, weight: .light)), for: .normal)
        return button
    }()
    
    override func viewDidLoad() {   
        super.viewDidLoad()
        view.backgroundColor = .systemCyan
        
        view.addSubview(disk)        
        disk.addSubview(playCoverImage)
        view.addSubview(controlsPlayer)
        
        controlsPlayer.addSubview(nameSong)
        controlsPlayer.addSubview(descriptionSong)
        controlsPlayer.addSubview(sliderSong)
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .close, target: self, action: #selector(didTapClose))
        
        configureStackControl()
        
        configureGetData()
        
        configureControlPlayer()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.disk.rotate()
        }
          
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(progressTimer), userInfo: nil, repeats: true)
    }
    
    @objc func progressTimer() {
        PlayerDataTransmission.shared.updateProgress(audioSlider: sliderSong, timeLabel: descriptionSong)
    }
    
    override func viewDidLayoutSubviews() {
        
        let sizeDisk: CGFloat = 300
        disk.clipsToBounds = true
        disk.layer.borderWidth = 0.4
        disk.layer.borderColor = CGColor(red: 209, green: 209, blue: 214, alpha: 1.0)
        disk.frame = CGRect(x: view.frame.size.width / 2 - (sizeDisk/2), y: view.frame.size.height / 3.3 - (sizeDisk/2) , width: sizeDisk, height: sizeDisk)
        disk.layer.cornerRadius = disk.frame.size.width / 2
        
        let heightImage = view.frame.size.height / 1.5 - view.safeAreaInsets.top
        playCoverImage.frame = disk.bounds
        
        controlsPlayer.frame = CGRect(x: 10, y: heightImage, width: view.frame.size.width - 20, height: view.frame.size.height - heightImage - view.safeAreaInsets.top)
        controlsPlayer.layer.cornerRadius = 20.0
        controlsPlayer.backgroundColor = .white
        nameSong.frame = CGRect(x: 20, y: 30, width:  controlsPlayer.frame.size.width - 40, height: 25)
        descriptionSong.frame = CGRect(x: 20, y: nameSong.frame.size.height + 40, width:  controlsPlayer.frame.size.width - 40, height: 25)
        
        sliderSong.frame = CGRect(x: 20, y: descriptionSong.frame.size.height + 60, width: controlsPlayer.frame.size.width - 40, height: 40)
        
        stack.frame = CGRect(x: 20, y: sliderSong.frame.size.height + 100, width: controlsPlayer.frame.size.width - 40, height: 80)
        
    }
    
    func configureStackControl() {
        stack = UIStackView(arrangedSubviews: [shuffleButton ,previousButton , playPauseButton ,nextButton, repeatButton])
        stack.axis = .horizontal
        stack.alignment = .center
        stack.distribution = .equalSpacing
        controlsPlayer.addSubview(stack)
    }
    
    @objc func didTapClose() {
        print("close")
    }
    
    func configureGetData() {
        playCoverImage.sd_setImage(with: dataSource?.URL_image, completed: nil)
        nameSong.text = dataSource?.name_song
        descriptionSong.text = dataSource?.description
    }
    
    func configureControlPlayer() {
        
        shuffleButton.addTarget(self, action: #selector(didTapShuffButton), for: .touchUpInside)
        previousButton.addTarget(self, action: #selector(didTapPreviousButton), for: .touchUpInside)
        playPauseButton.addTarget(self, action: #selector(didTapPlayPauseButton), for: .touchUpInside)
        nextButton.addTarget(self, action: #selector(didTapNextButton), for: .touchUpInside)
        repeatButton.addTarget(self, action: #selector(didTapRepeatButton), for: .touchUpInside)
        sliderSong.addTarget(self, action: #selector(didTapSelectSlider(_:)), for: .valueChanged)

    }
    
    @objc func didTapShuffButton() {
        delegate?.PlayerViewControllerDidTapShuffButton(self)
        
        if checkRandom == false {
            if isRepeat == true {
                isRepeat = false;
                shuffleButton.tintColor = .systemGreen
                repeatButton.tintColor = .black
            }
            shuffleButton.tintColor = .systemGreen
            checkRandom = true;
        } else {
            checkRandom = false;
            shuffleButton.tintColor = .black
        }
        
    }
    
    @objc func didTapPreviousButton() {
        delegate?.PlayerViewControllerDidTapPreviousButton(self)
    }
    
    @objc func didTapPlayPauseButton() {
            
        delegate?.PlayerViewControllerDidTapPlayPauseButton(self)
        
        let pause = UIImage(systemName: "pause.circle", withConfiguration: UIImage.SymbolConfiguration(pointSize: 80, weight: .light, scale: .small))
        
        let play = UIImage(systemName: "play.circle", withConfiguration: UIImage.SymbolConfiguration(pointSize: 80, weight: .light, scale: .small))

        playPauseButton.setImage(isPlaying ? pause : play, for: .normal)
        
        self.isPlaying ? disk.resumeAnimation() : disk.pauseAnimation()
        
    }
    
    @objc func didTapNextButton() {
        delegate?.PlayerViewControllerDidTapNextButton(self)
    }
    
    @objc func didTapRepeatButton() {
        delegate?.PlayerViewControllerDidTapRepeatButton(self)
        
        if isRepeat == false {
            if checkRandom == true {
                checkRandom = false;
                repeatButton.tintColor = .systemGreen
                shuffleButton.tintColor = .black
            }
            isRepeat = true;
            repeatButton.tintColor = .systemGreen
        } else {
            isRepeat = false;
            repeatButton.tintColor = .black
        }
    }
    
    @objc func didTapSelectSlider(_ slider: UISlider) {
        let value = slider.value
        delegate?.PlayerControlSlider(self, didSelectSlider: value)
    }
    
}
