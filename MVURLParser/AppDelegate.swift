//
//  AppDelegate.swift
//  MVURLParser
//
//  Created by Michael on 17/6/14.
//  Copyright (c) 2014 Michael Vu. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
                            
    var window: UIWindow?


    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: NSDictionary?) -> Bool {
        var parse = MVURLParser(urlString: "http://example.com?var1=Value1&var2=Value2&var3=Value2&var4=Value2&var10=Value10")
        NSLog("Count %d", parse.count())
        NSLog("is Valid %@", parse.isValid().description)
        NSLog("Null %@", parse.valueForVariable(nil))
        NSLog("Empty %@", parse.valueForVariable(""))
        NSLog("Var1 %@", parse.valueForVariable("var1"))
        NSLog("Var2 %@", parse.valueForVariable("var2"))
        NSLog("Var3 %@", parse.valueForVariable("var3"))
        NSLog("Var4 %@", parse.valueForVariable("var4"))
        NSLog("Pattern %@", parse.valueForVariable("v", pattern: "3$"))
        let regex = NSRegularExpression(pattern: "\\d{2}", options: .CaseInsensitive, error: nil)
        NSLog("Regex %@", parse.valueForVariable("var", regex: regex))
        var newUrl = String()
        parse.updateVariable("var1", value: "Test1", url: &newUrl)
        NSLog("Updated URL %@", newUrl)
        NSLog("New URL %@", parse.updateURLByVariable("var2", value: "Test2"))
        NSLog("New Value for Var2 %@", parse.valueForVariable("var2"))
        self.window = UIWindow(frame: UIScreen.mainScreen().bounds)
        // Override point for customization after application launch.
        self.window!.backgroundColor = UIColor.whiteColor()
        self.window!.makeKeyAndVisible()
        return true
    }

    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

