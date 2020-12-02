//
//  SettingCell.swift
//  ios-rentor
//
//  Created by Thomas on 07/11/2020.
//  Copyright © 2020 Thomas. All rights reserved.
//

import SwiftUI

struct HelperSettingCell: View {
    let settingData: HelperSettingData
    
    init(with setting: HelperSettingData) {
        self.settingData = setting
    }
    
    var body: some View {
        Text(self.settingData.name)
    }
}

struct SettingCell_Previews: PreviewProvider {
    static var previews: some View {
        HelperSettingCell(with: HelperSettingData(with: "Test A", with: "test/"))
    }
}
