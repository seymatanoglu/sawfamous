//
//  AppDelegate.m
//  SawFamous
//
//  Created by Seyma Tanoglu on 10/21/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "AppDelegate.h"
#import "MainViewController.h"

@implementation AppDelegate

@synthesize window = _window;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    [self initialize];
    return YES;
}

-(void) initialize {
    self.window = [[[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]] autorelease];
    // Override point for customization after application launch.
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    
    MainViewController * main = [[MainViewController alloc] init];
    UINavigationController *NC = [[UINavigationController alloc] initWithRootViewController:main];
    [self.window addSubview:NC.view];
}

- (void)dealloc
{
    [_window release];
    [super dealloc];
}

@end
