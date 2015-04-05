//
//  LightsCard.swift
//  Apartment
//
//  Created by Rachel Brindle on 4/4/15.
//  Copyright (c) 2015 Rachel Brindle. All rights reserved.
//

import UIKit
import MaterialKit
import Cartography

class LightsCard: UICollectionViewCell, UITableViewDelegate, UITableViewDataSource {
    var bulbs : [Bulb] = []

    lazy var tableView : UITableView = {
        let tv = UITableView(frame: self.contentView.bounds, style: .Grouped)
        tv.delegate = self
        tv.dataSource = self
        tv.registerClass(MKTableViewCell.self, forCellReuseIdentifier: "cell")

        tv.setTranslatesAutoresizingMaskIntoConstraints(false)
        self.contentView.addSubview(tv)
        layout(tv) {view in
            view.edges == view.superview!.edges
        }

        return tv
    }()

    func configure(bulbs: [Bulb]) {
        self.bulbs = bulbs

        self.tableView.reloadData()

        self.contentView.layer.cornerRadius = 5
        self.contentView.backgroundColor = UIColor.whiteColor()
    }

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return bulbs.count
    }

    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Lights"
    }

    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 100
    }

    func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 100
    }

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as! MKTableViewCell
        let bulb = bulbs[indexPath.row]
        cell.textLabel?.text = bulb.name
        cell.contentView.backgroundColor = bulb.color
        cell.rippleLayerColor = bulb.color.darkerColor()
        return cell
    }
}