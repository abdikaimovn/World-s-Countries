//
//  CountryInfoViewController.swift
//  WorldCountries
//
//  Created by Нурдаулет on 09.06.2023.
//

import UIKit
import SnapKit
class CountryInfoViewController: UIViewController {
    private var canvasView: UIView = {
        var canvas = UIView()
        return canvas
    }()
    private var flagImageView: UIImageView = {
        var image = UIImageView()
        image.layer.cornerRadius = 5
        image.layer.masksToBounds = false
        image.clipsToBounds = true
        image.layer.borderColor = UIColor.white.cgColor
        image.image = UIImage(named: "Kazakhstan")
        return image
    }()
    
    private var regionLabel: UILabel = {
        var label = UILabel()
        label.textColor = UIColor.gray
        label.font = .systemFont(ofSize: 16, weight: .bold)
        label.text = "Region:"
        return label
    }()

    private var capitalLabel: UILabel = {
        var label = UILabel()
        label.textColor = UIColor.gray
        label.text = "Capital:"
        label.font = .systemFont(ofSize: 16, weight: .bold)
        return label
    }()
    
    private var capitalCoordinatesLabel: UILabel = {
        var label = UILabel()
        label.textColor = UIColor.gray
        label.text = "Capital Coordinates:"
        label.font = .systemFont(ofSize: 16, weight: .bold)
        return label
    }()

    private var populationLabel: UILabel = {
        var label = UILabel()
        label.textColor = UIColor.gray
        label.text = "Population:"
        label.font = .systemFont(ofSize: 16, weight: .bold)
        return label
    }()
    
    private var areaLabel: UILabel = {
        var label = UILabel()
        label.textColor = UIColor.gray
        label.text = "Area:"
        label.font = .systemFont(ofSize: 16, weight: .bold)
        return label
    }()
    
    private var currencyLabel: UILabel = {
        var label = UILabel()
        label.textColor = UIColor.gray
        label.text = "Currency:"
        label.font = .systemFont(ofSize: 16, weight: .bold)
        return label
    }()
    
    private var timeZonesLabel: UILabel = {
        var label = UILabel()
        label.textColor = UIColor.gray
        label.text = "Timezones:"
        label.font = .systemFont(ofSize: 16, weight: .bold)
        return label
    }()
    
//    private var dot: UILabel = {
//        var label = UILabel()
//        label.text = "•"
//        label.font = .systemFont(ofSize: 30, weight: .bold)
//        return label
//    }()

    private var regionNameLabel: UILabel = {
        var label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .bold)
        return label
    }()
    
    private var capitalNameLabel: UILabel = {
        var label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .bold)
        return label
    }()
    
    private var capitalCoordinatesNameLabel: UILabel = {
        var label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .bold)
        return label
    }()
    
    private var populationNameLabel: UILabel = {
        var label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .bold)
        return label
    }()
    
    private var areaNameLabel: UILabel = {
        var label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .bold)
        return label
    }()
    
    private var currencyNameLabel: UILabel = {
        var label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .bold)
        return label
    }()
    
    private var timeZonesNameLabel: UILabel = {
        var label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .bold)
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.backButtonTitle = "<"
        self.view.backgroundColor = .white
        setupViews()
    }
    
    private func setupViews(){
        self.view.addSubview(flagImageView)
        flagImageView.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(20)
            make.top.equalToSuperview().inset(106)
            make.width.equalTo(350)
            make.height.equalTo(166.6)
        }
//        self.view.addSubview(dot)
//        dot.snp.makeConstraints { make in
//            make.left.equalToSuperview().inset(22)
//            make.right.equalToSuperview().inset(358)
//            make.top.equalTo(flagImageView.snp.bottom).offset(29.4)
//            make.width.equalTo(10)
//            make.height.equalTo(15)
//        }
        self.view.addSubview(regionLabel)
        regionLabel.snp.makeConstraints{ make in
            make.left.equalToSuperview().inset(41)
            make.top.equalTo(flagImageView.snp.bottom).offset(26.4)
            make.right.equalToSuperview().inset(135)
            make.width.equalTo(214)
            make.height.equalTo(16)
        }
        self.view.addSubview(regionNameLabel)
        regionNameLabel.snp.makeConstraints { make in
            make.left.equalTo(regionLabel.snp.left)
            make.top.equalTo(regionLabel.snp.bottom).offset(4)
            make.right.equalToSuperview().inset(135)
            make.width.equalTo(214)
            make.height.equalTo(16)
        }
//        Template
//        make.left.equalTo(regionLabel.snp.left)
//        make.right.equalToSuperview().inset(135)
//        make.width.equalTo(214)
//        make.height.equalTo(16)
        self.view.addSubview(capitalLabel)
        capitalLabel.snp.makeConstraints { make in
            make.top.equalTo(regionNameLabel.snp.bottom).offset(15)
            make.left.equalTo(regionLabel.snp.left)
            make.right.equalToSuperview().inset(135)
            make.width.equalTo(214)
            make.height.equalTo(16)
        }
        self.view.addSubview(capitalNameLabel)
        capitalNameLabel.snp.makeConstraints { make in
            make.left.equalTo(regionLabel.snp.left)
            make.right.equalToSuperview().inset(135)
            make.width.equalTo(214)
            make.height.equalTo(16)
            make.top.equalTo(capitalLabel.snp.bottom).offset(4)
        }
        self.view.addSubview(capitalCoordinatesLabel)
        capitalCoordinatesLabel.snp.makeConstraints { make in
            make.left.equalTo(regionLabel.snp.left)
            make.right.equalToSuperview().inset(135)
            make.width.equalTo(214)
            make.height.equalTo(16)
            make.top.equalTo(capitalNameLabel.snp.bottom).offset(15)
        }
        self.view.addSubview(capitalCoordinatesNameLabel)
        capitalCoordinatesNameLabel.snp.makeConstraints { make in
            make.left.equalTo(regionLabel.snp.left)
            make.right.equalToSuperview().inset(135)
            make.width.equalTo(214)
            make.height.equalTo(16)
            make.top.equalTo(capitalCoordinatesLabel.snp.bottom).offset(4)
        }
        self.view.addSubview(populationLabel)
        populationLabel.snp.makeConstraints{ make in
            make.left.equalTo(regionLabel.snp.left)
            make.right.equalToSuperview().inset(135)
            make.width.equalTo(214)
            make.height.equalTo(16)
            make.top.equalTo(capitalCoordinatesNameLabel.snp.bottom).offset(15)
        }
        self.view.addSubview(populationNameLabel)
        populationNameLabel.snp.makeConstraints { make in
            make.left.equalTo(regionLabel.snp.left)
            make.right.equalToSuperview().inset(135)
            make.width.equalTo(214)
            make.height.equalTo(16)
            make.top.equalTo(populationLabel.snp.bottom).offset(4)
        }
        self.view.addSubview(areaLabel)
        areaLabel.snp.makeConstraints { make in
            make.left.equalTo(regionLabel.snp.left)
            make.right.equalToSuperview().inset(135)
            make.width.equalTo(214)
            make.height.equalTo(16)
            make.top.equalTo(populationNameLabel.snp.bottom).offset(15)
        }
        self.view.addSubview(areaNameLabel)
        areaNameLabel.snp.makeConstraints { make in
            make.left.equalTo(regionLabel.snp.left)
            make.right.equalToSuperview().inset(135)
            make.width.equalTo(214)
            make.height.equalTo(16)
            make.top.equalTo(areaLabel.snp.bottom).offset(4)
        }
        self.view.addSubview(currencyLabel)
        currencyLabel.snp.makeConstraints { make in
            make.left.equalTo(regionLabel.snp.left)
            make.right.equalToSuperview().inset(135)
            make.width.equalTo(214)
            make.height.equalTo(16)
            make.top.equalTo(areaNameLabel.snp.bottom).offset(15)
        }
        self.view.addSubview(currencyNameLabel)
        currencyNameLabel.snp.makeConstraints { make in
            make.left.equalTo(regionLabel.snp.left)
            make.right.equalToSuperview().inset(135)
            make.width.equalTo(214)
            make.height.equalTo(16)
            make.top.equalTo(currencyLabel.snp.bottom).offset(4)
        }
        self.view.addSubview(timeZonesLabel)
        timeZonesLabel.snp.makeConstraints { make in
            make.left.equalTo(regionLabel.snp.left)
            make.right.equalToSuperview().inset(135)
            make.width.equalTo(214)
            make.height.equalTo(16)
            make.top.equalTo(currencyNameLabel.snp.bottom).offset(15)
        }
        self.view.addSubview(timeZonesNameLabel)
        timeZonesNameLabel.snp.makeConstraints { make in
            make.left.equalTo(regionLabel.snp.left)
            make.right.equalToSuperview().inset(135)
            make.width.equalTo(214)
            make.height.equalTo(16)
            make.top.equalTo(timeZonesNameLabel).offset(4)
            make.bottom.equalToSuperview().inset(351)
        }
        
    }

}
