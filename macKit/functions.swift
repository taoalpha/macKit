//
//  functions.swift
//  macKit
//
//  Created by tao on 8/25/16.
//  Copyright © 2016 tao. All rights reserved.
//

import Foundation

// all funcs


// system section
func reduceTrans(state: String) {
    // system-wide resume
    let task = NSTask()
    task.launchPath = "/usr/bin/defaults"
    
    task.arguments = ["write", "com.apple.universalaccess", "reduceTransparency", state]
    task.launch()
    task.waitUntilExit()
}
func windowResume(state: String) {
    // system-wide resume
    let task = NSTask()
    task.launchPath = "/usr/bin/defaults"
    
    task.arguments = ["write", "NSGlobalDomain", "NSQuitAlwaysKeepsWindows", state]
    task.launch()
    task.waitUntilExit()
}

func noSleep(state: String) {
    // no sleep mode (Off / On)
    let task = NSTask()
    task.launchPath = "/usr/bin/systemsetup"
    
    task.arguments = ["-setcomputersleep", state, ">", "/dev/null"]
    task.launch()
    task.waitUntilExit()
}

func checkUpdate(day: String) {
    // frequency of checking updates
    let task = NSTask()
    task.launchPath = "/usr/bin/defaults"
    
    task.arguments = ["write", "com.apple.SoftwareUpdate", "ScheduleFrequency", "-int", day]
    task.launch()
    task.waitUntilExit()
}

func pressHold(state: String) {
    // press-and-hold
    let task = NSTask()
    task.launchPath = "/usr/bin/defaults"
    
    task.arguments = ["write", "NSGlobalDomain", "ApplePressAndHoldEnabled", state]
    task.launch()
    task.waitUntilExit()
}

func keyBoardIllum(seconds: String) {
    // seconds
    let task = NSTask()
    task.launchPath = "/usr/bin/defaults"
    
    task.arguments = ["write", "com.apple.BezelServices", "kDimTime", "-int", seconds]
    task.launch()
    task.waitUntilExit()
}

// finder section

func hidden(state: String) {
    // show hidden or not
    let task = NSTask()
    task.launchPath = "/usr/bin/defaults"
    
    task.arguments = ["write", "com.apple.finder", "AppleShowAllFiles", state]
    task.launch()
    task.waitUntilExit()
    
    let killTask = NSTask()
    killTask.launchPath = "/usr/bin/killall"
    killTask.arguments = ["Finder"]
    killTask.launch()
}