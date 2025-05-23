//
//  HomeView.swift
//  Artner
//
//  Created by 신종원 on 4/27/25.
//
import UIKit
import SnapKit

final class HomeView: BaseView {

    // MARK: - UI Components
    let customNavigationBar = CustomNavigationHomeBar()
    let tableView = UITableView()
    private let bannerView = HomeBannerView()
    private let bottomFadeView = UIView()
    private let gradientLayer = CAGradientLayer()

    // MARK: - Setup

    override func setupUI() {
        super.setupUI()

        backgroundColor = AppColor.background
        addSubview(customNavigationBar)
        addSubview(tableView)
        addSubview(bottomFadeView)

        tableView.backgroundColor = AppColor.background
        tableView.separatorStyle = .none
        tableView.showsVerticalScrollIndicator = false
        bannerView.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 247)
        tableView.tableHeaderView = bannerView

        tableView.register(DocentTableViewCell.self, forCellReuseIdentifier: "DocentCell")

        setupFadeLayer()
    }

    override func setupLayout() {
        super.setupLayout()

        customNavigationBar.snp.makeConstraints {
            $0.top.equalTo(safeAreaLayoutGuide.snp.top)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(44)
        }

        tableView.snp.makeConstraints {
            $0.top.equalTo(customNavigationBar.snp.bottom)
            $0.leading.trailing.bottom.equalToSuperview()
        }

        bottomFadeView.snp.makeConstraints {
            $0.leading.trailing.bottom.equalToSuperview()
            $0.height.equalTo(135)
        }
    }

    private func setupFadeLayer() {
        bottomFadeView.isUserInteractionEnabled = false
        bottomFadeView.layer.addSublayer(gradientLayer)

        gradientLayer.colors = [
            UIColor(hex: "#281914").cgColor,
            UIColor(hex: "#281914").withAlphaComponent(0.0).cgColor
        ]
        gradientLayer.locations = [0.0, 1.0]
        gradientLayer.startPoint = CGPoint(x: 0.5, y: 1.0) // 아래에서 시작
        gradientLayer.endPoint = CGPoint(x: 0.5, y: 0.0)   // 위로 끝남
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        gradientLayer.frame = bottomFadeView.bounds
    }

    // MARK: - Public Method
    func configureBanner(image: UIImage?, title: String, subtitle: String) {
        bannerView.configure(image: image, title: title, subtitle: subtitle)
    }
}
