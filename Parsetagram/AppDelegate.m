//
//  AppDelegate.m
//  Parsetagram
//
//  Created by Bienn Viquiera on 6/27/22.
//

#import "AppDelegate.h"
#import "Parse/Parse.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(  NSDictionary *)launchOptions {

    ParseClientConfiguration *config = [ParseClientConfiguration  configurationWithBlock:^(id<ParseMutableClientConfiguration> configuration) {

        configuration.applicationId = @"5zEKk1owDiOD5VxRXJcUhoFWh8MUYkLb75UN7Sys"; // <- UPDATE
        configuration.clientKey = @"J3jkX3Q1aHfjs938BXL99cwz6OJdb7QlEKuEP5Dg"; // <- UPDATE
        configuration.server = @"https://parseapi.back4app.com";
    }];

    [Parse initializeWithConfiguration:config];

    

    return YES;
}


#pragma mark - UISceneSession lifecycle


- (UISceneConfiguration *)application:(UIApplication *)application configurationForConnectingSceneSession:(UISceneSession *)connectingSceneSession options:(UISceneConnectionOptions *)options {
    // Called when a new scene session is being created.
    // Use this method to select a configuration to create the new scene with.
    return [[UISceneConfiguration alloc] initWithName:@"Default Configuration" sessionRole:connectingSceneSession.role];
}


- (void)application:(UIApplication *)application didDiscardSceneSessions:(NSSet<UISceneSession *> *)sceneSessions {
    // Called when the user discards a scene session.
    // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
    // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
}


@end
