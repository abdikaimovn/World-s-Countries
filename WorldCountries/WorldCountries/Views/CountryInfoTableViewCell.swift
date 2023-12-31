//
//  CountryInfoTableViewCell.swift
//  WorldCountries
//
//  Created by Нурдаулет on 14.06.2023.
//

import UIKit
import SnapKit

class CountryInfoTableViewCell: UITableViewCell {
    private var dot: UILabel = {
        var label = UILabel()
        label.font = .systemFont(ofSize: 40, weight: .bold)
        return label
    }()
    
    private var firstData: UILabel = {
        var label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .bold)
        label.textColor = .gray
        return label
    }()
    
    private var secondData: UILabel = {
        var label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .bold)
        label.textColor = .black
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func configure(_ valueOfLabel1:String, _ valueOfLabel2:String){
        self.dot.text = "•"
        self.firstData.text = valueOfLabel1
        self.secondData.text = valueOfLabel2
    }
    
    private func setupViews(){
        self.selectionStyle = .none
        
        addSubview(dot)
        dot.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(-10)
            make.left.equalToSuperview().inset(10)
        }
        
        addSubview(firstData)
        firstData.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(5)
            make.left.equalTo(dot.snp.right).offset(10)
        }
        
        addSubview(secondData)
        secondData.snp.makeConstraints { make in
            make.top.equalTo(firstData.snp.bottom).offset(2)
            make.left.equalTo(dot.snp.right).offset(10)
            make.bottom.equalToSuperview().inset(5)
        }
    }
}
