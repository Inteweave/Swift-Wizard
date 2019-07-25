//
//  SnackWizardScreens.swift
//  Wizard
//
//  Created by Warren Milward on 21/7/19.
//  Copyright © 2019 Inteweave. All rights reserved.
//

import Foundation

///
/// Use an enum for screens so that we have additional checking.
/// When using data from an external source (e.g. dynamic wizard) we will probably just use strings.
///
enum SnacksScreen {
    case selectType
    case iceCreamServe
    case scoop
    case chooseTopping
    case softServeChocDip
    case softServeSprinkles
    case nuts

    var contents: ScreenContents {
        switch self {
        case .selectType:
            return SelectTypeScreen()
        case .iceCreamServe:
            return IceCreamServeScreen()
        case .scoop:
            return ScoopScreen()
        case .chooseTopping:
            return ChooseToppingScreen()
        case .softServeChocDip:
            return ChocDipScreen()
        case .softServeSprinkles:
            return SprinklesScreen()
        case .nuts:
            return NutsScreen()
        }
    }
}

// MARK: - Screen Contents

protocol ScreenContents {
    var label: String { get }
    var button1Title: String { get }
    var button2Title: String { get}
    var button1Event: Event { get }
    var button2Event: Event { get }
    var button2Hidden: Bool { get}
}

struct SelectTypeScreen: ScreenContents {
    var label = "Select type of snack"
    var button1Title = "Ice Cream"
    var button2Title = "Nuts"
    var button1Event = Event.userDidChooseIceCream
    var button2Event = Event.userDidChooseNuts
    var button2Hidden = false
}

struct IceCreamServeScreen: ScreenContents {
    var label = "Ice Cream\n\nSelect serve"
    var button1Title = "Scoop"
    var button2Title = "Soft Serve"
    var button1Event = Event.userDidChooseIceCreamScoop
    var button2Event = Event.userDidChooseSoftServe
    var button2Hidden = false
}

struct ScoopScreen: ScreenContents {
    var label = "Scoop selected"
    var button1Title = "Finish"
    var button2Title = ""
    var button1Event = Event.finish
    var button2Event = Event.finish
    var button2Hidden = true
}

struct ChooseToppingScreen: ScreenContents {
    var label = "Select a topping"
    var button1Title = "Choc Dip"
    var button2Title = "Sprinkles"
    var button1Event = Event.userDidChooseChocDip
    var button2Event = Event.userDidChooseSprinkles
    var button2Hidden = false
}

struct ChocDipScreen: ScreenContents {
    var label = "Soft Serve with Choc Dip"
    var button1Title = "Finish"
    var button2Title = ""
    var button1Event = Event.finish
    var button2Event = Event.finish
    var button2Hidden = true
}

struct SprinklesScreen: ScreenContents {
    var label = "Soft Serve with Sprinkles"
    var button1Title = "Finish"
    var button2Title = ""
    var button1Event = Event.finish
    var button2Event = Event.finish
    var button2Hidden = true
}

struct NutsScreen: ScreenContents {
    var label = "Salted Mixed Nuts"
    var button1Title = "Finish"
    var button2Title = ""
    var button1Event = Event.finish
    var button2Event = Event.finish
    var button2Hidden = true
}
