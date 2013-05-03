//
//  AppDelegate.m
//  MyMart
//
//  Created by Komsan Noipitak on 3/15/56 BE.
//  Copyright (c) 2556 Komsan Noipitak. All rights reserved.
//

#import "AppDelegate.h"


@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Override point for customization after application launch.
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    //// Clear NSUserDefaults ////
    // NSString *appDomain = [[NSBundle mainBundle] bundleIdentifier];
    // [[NSUserDefaults standardUserDefaults] removePersistentDomainForName:appDomain];
    
    // Create navigation controller in InitialSlidingViewController
    self.viewController = [[InitialSlidingViewController alloc] init];
    self.navigationController = [[UINavigationController alloc]initWithRootViewController:self.viewController];
    
    // Set InitialSlidingViewController as a root view
    [self.window setRootViewController:self.navigationController];
    [self.window makeKeyAndVisible];
    
    
    return YES;
}


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    // return UIInterfaceOrientationIsLandscape(interfaceOrientation);
    return (interfaceOrientation == UIInterfaceOrientationLandscapeRight);
    
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    
    //// Check device has registerd ////
    
    // RegisterDeviceQuickPin : NO
    RegisterDevice *registerDevice = [[RegisterDevice alloc]init];
    [RegisterDevice sharedInstance];
    
    if(!registerDevice.registerSuccess){
        
        // Present FirstViewController
        FirstLoginViewController *firstLoginViewController = [[FirstLoginViewController alloc]init];
        [self.navigationController presentModalViewController:firstLoginViewController animated:NO];
        
        // RegisterDeviceQuickPin : YES
    }else {
        
        // Present LoginViewController
        LoginViewController *loginViewController = [[LoginViewController alloc]init];
        [self.navigationController presentModalViewController:loginViewController animated:NO];
        
    }
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
