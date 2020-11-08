//
//  SettingCell.swift
//  ios-rentor
//
//  Created by Thomas on 07/11/2020.
//  Copyright © 2020 Thomas. All rights reserved.
//

import SwiftUI

struct SettingCell: View {
    let settingData: SettingCellData
    
    init(with setting: SettingCellData) {
        self.settingData = setting
    }
    
    var body: some View {
        Text("HERE = \(self.settingData.name)")
    }
}

struct SettingCell_Previews: PreviewProvider {
    static var previews: some View {
        SettingCell(with: SettingCellData(with: "Test A"))
    }
}
