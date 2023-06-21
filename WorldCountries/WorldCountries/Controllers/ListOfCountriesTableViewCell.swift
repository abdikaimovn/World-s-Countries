//
//  ListOfCountriesTableViewCell.swift
//  WorldCountries
//
//  Created by Нурдаулет on 06.06.2023.
//

import UIKit
import SnapKit
class ListOfCountriesTableViewCell: UITableViewCell {
    //MARK: Views
    private var flagImageView: UIImageView = {
        var flagImage = UIImageView()
        flagImage.layer.cornerRadius = 5
        flagImage.layer.borderWidth = 0
        flagImage.layer.borderColor = UIColor.white.cgColor
        flagImage.layer.masksToBounds = false
        flagImage.clipsToBounds = true
        return flagImage
    }()
    
    var countryNameLabel: UILabel = {
        var label = UILabel()
        label.textColor = .black
        label.font = .systemFont(ofSize: 14, weight: .bold)
        label.numberOfLines = 0
        return label
    }()
    
    private var capitalNameLabel: UILabel = {
        var label = UILabel()
        label.textColor = .black
        label.font = .systemFont(ofSize: 12, weight: .regular)
        label.numberOfLines = 0
        return label
    }()
    
    private var arrowRightImage: UIImageView={
        var image = UIImageView()
        image.image = UIImage(named: "arrow right")!
        image.contentMode = .scaleAspectFit
        return image
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(countryInfo: CountryModel){
        CountryApi.shared.fetchImage(from: countryInfo.countryImageURL) { image in
            DispatchQueue.main.async {
                self.flagImageView.image = image
            }
        }
        self.countryNameLabel.text = countryInfo.countryName
        self.capitalNameLabel.text = countryInfo.capitalName
        self.backgroundColor = .white
    }
    
    //MARK: setup all views
    private func setupViews(){
        addSubview(flagImageView)
        self.selectionStyle = .none
        flagImageView.snp.makeConstraints { make in
            make.left.equalToSuperview().inset(22)
            make.centerY.equalToSuperview()
            make.width.equalTo(100)
            make.height.equalTo(50)
        }
        
        addSubview(arrowRightImage)
        arrowRightImage.snp.makeConstraints{ make in
            make.centerY.equalToSuperview()
            make.right.equalToSuperview().inset(15)
            make.width.equalTo(30)
        }
        
        addSubview(countryNameLabel)
        countryNameLabel.snp.makeConstraints { make in
            make.left.equalTo(flagImageView.snp.right).offset(9)
            make.top.equalToSuperview().inset(30)
            make.bottom.equalToSuperview().inset(45)
        }
        
        addSubview(capitalNameLabel)
        capitalNameLabel.snp.makeConstraints { make in
            make.left.equalTo(flagImageView.snp.right).offset(9)
            make.top.equalToSuperview().inset(46)
            make.bottom.equalToSuperview().inset(29)
        }
    }

}
