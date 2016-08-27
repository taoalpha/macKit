//
//  AppDelegate.swift
//  macKit
//
//  Created by tao on 8/25/16.
//  Copyright © 2016 tao. All rights reserved.
//

import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {

    @IBOutlet weak var window: NSWindow!
    @IBOutlet weak var statusMenu: NSMenu!
    // system section
    @IBOutlet weak var switch_system_rt: NSButton!
    @IBOutlet weak var switch_system_sr: NSButton!
    @IBOutlet weak var switch_system_ns: NSButton!
    @IBOutlet weak var switch_system_su: NSButton!
    @IBOutlet weak var switch_system_ph: NSButton!
    @IBOutlet weak var switch_system_ki: NSButton!
    // finder section
    @IBOutlet weak var switch_finder_hf: NSButton!

    let statusBar = NSStatusBar.systemStatusBar().statusItemWithLength(-1)

    func applicationDidFinishLaunching(aNotification: NSNotification) {
        let icon = NSImage(named: "icon")
        statusBar.image = icon
        statusBar.menu = statusMenu
        updateSetting("com.apple.finder", command: "AppleShowAllFiles", yes: "YES", btn: switch_finder_hf)
        updateSetting("com.apple.BezelServices", command: "kDimTime", yes: "300", btn: switch_system_ki)
        updateSetting("NSGlobalDomain", command: "ApplePressAndHoldEnabled", yes: "YES", btn: switch_system_ph)
        updateSetting("com.apple.SoftwareUpdate", command: "ScheduleFrequency", yes: "1", btn: switch_system_su)
        updateSetting("NSGlobalDomain", command: "NSQuitAlwaysKeepsWindows", yes: "YES", btn: switch_system_sr)
        updateSetting("com.apple.universalaccess", command: "reduceTransparency", yes: "YES", btn: switch_system_rt)
    }

    func applicationWillTerminate(aNotification: NSNotification) {
        // Insert code here to tear down your application
    }
    
    func updateSetting(hostname: String, command: String, yes: String, btn: NSButton) {
        let task = NSTask()
        let pipe:NSPipe = NSPipe()
        task.launchPath = "/usr/bin/defaults"
        task.arguments = ["read", hostname, command]
        task.standardOutput = pipe
        task.launch()
        let handle = pipe.fileHandleForReading
        let data = handle.readDataToEndOfFile()
        let result_s = NSString(data: data, encoding: NSUTF8StringEncoding)
        if (result_s! == yes + "\n") {
            btn.state = 1
        } else {
            btn.state = 0
        }
        
    }
    

    @IBAction func preferenceClick(sender: NSMenuItem) {
        window.setIsVisible(true)
    }
    
    @IBAction func reset(sender: NSMenuItem) {
        switch_system_rt.state = 0
        switch_system_sr.state = 0
        switch_system_ns.state = 0
        switch_system_su.state = 0
        switch_system_ph.state = 0
        switch_system_ki.state = 0
    }

    @IBAction func quit(sender: NSMenuItem) {
        NSApplication.sharedApplication().terminate(self)
    }
    @IBAction func system_rt_switch(sender: NSButton) {
        if (sender.state == 1) {
            reduceTrans("YES")
        } else {
            reduceTrans("NO")
        }
    }
    @IBAction func system_sr_switch(sender: NSButton) {
        if (sender.state == 1) {
            windowResume("YES")
        } else {
            windowResume("NO")
        }
    }
    @IBAction func system_ns_switch(sender: NSButton) {
        if (sender.state == 1) {
            noSleep("Off")
        } else {
            noSleep("On")
        }
    }
    @IBAction func system_su_switch(sender: NSButton) {
        if (sender.state == 1) {
            checkUpdate("1")
        } else {
            checkUpdate("7")
        }
    }
    @IBAction func system_ph_switch(sender: NSButton) {
        if (sender.state == 1) {
            pressHold("YES")
        } else {
            pressHold("NO")
        }
    }
    @IBAction func system_ki_switch(sender: NSButton) {
        if (sender.state == 1) {
            keyBoardIllum("300")
        } else {
            keyBoardIllum("-1")
        }
    }
    @IBAction func finder_hf_switch(sender: NSButton) {
        if (sender.state == 1) {
            hidden("YES")
        } else {
            hidden("NO")
        }
    }
}

