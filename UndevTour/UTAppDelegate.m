//
//  UTAppDelegate.m
//  UndevTour
//
//  Created by Chebulaev Oleg on 16.03.13.
//  Copyright (c) 2013 Chebulaev Oleg. All rights reserved.
//

#import "UTAppDelegate.h"
#import "UTMapViewController.h"

#import "UTHouseBuilder.h"
#import "UTHouse.h"
#import "UTLevel.h"
#import "UTExhibit.h"
#import "UTPathFinderModel.h"
#import "UTBlockService.h"

@implementation UTAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];

    UTMapViewController *vc = [[UTMapViewController alloc] init];
    UINavigationController *navVc = [[UINavigationController alloc] initWithRootViewController:vc];
    self.window.rootViewController = navVc;
    [self.window makeKeyAndVisible];
    
    UTHouse *house = [[[UTHouseBuilder alloc] init] buildHouseWithName:@"undev"];
    UTLevel *level = house.levels[0];
    
    UTBlockService *blockService = [[UTBlockService alloc] initWithWidth:[level.map[0] count] height:level.map.count blocks:level.map];
    UTPathFinderModel *model = [[UTPathFinderModel alloc] initWithBlockService:blockService];
    
    NSMutableArray *exhibits = [NSMutableArray arrayWithArray:level.exhibits];
    UTExhibit *strtExhibit = [exhibits lastObject];
    [exhibits removeObject:strtExhibit];
    
    [model findPathForObjects:exhibits startOn:strtExhibit];
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {

}

- (void)applicationDidEnterBackground:(UIApplication *)application {

}

- (void)applicationWillEnterForeground:(UIApplication *)application {

}

- (void)applicationDidBecomeActive:(UIApplication *)application {

}

- (void)applicationWillTerminate:(UIApplication *)application {
}

@end
