// RAJU CODE

//  AppDelegate.m
//  PhotoSharing
//
//  Created by One Click IT Consultancy  on 6/5/15.
//  Copyright (c) 2015 One Click IT Consultancy . All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate ()

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    
    
    
    {
        self.window=[[UIWindow alloc]initWithFrame:[[UIScreen mainScreen] bounds]];
        [Fabric with:@[DigitsKit]];
        
        deviceTokenStr = @"";
        appLatitude = @"";
        appLongitude = @"";
        
        /*-----------Start Location Manager----------*/
        locationManager = [[CLLocationManager alloc] init];
        locationManager.delegate = self;
        locationManager.distanceFilter = kCLDistanceFilterNone; // whenever we move
        locationManager.desiredAccuracy = kCLLocationAccuracyBest; // 100 m
        if(IS_OS_8_OR_LATER) {
            [locationManager requestAlwaysAuthorization];
        }
        [locationManager startUpdatingLocation];
        /*-------------------------------------------*/
        
        /*-----Create DataBase Manager --------*/
        [[DataBaseManager dataBaseManager]createDatabase];
        [[DataBaseManager dataBaseManager]createImageFolder];
        [[DataBaseManager dataBaseManager]createThumbImageFolder];
        
        paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        
        
        /*-----------Push Notitications----------*/
        // Register for Push Notitications, if running iOS 8
        if ([application respondsToSelector:@selector(registerUserNotificationSettings:)])
        {
            #ifdef __IPHONE_8_0
            UIUserNotificationType userNotificationTypes = (UIUserNotificationTypeAlert | UIUserNotificationTypeBadge | UIUserNotificationTypeSound);
            UIUserNotificationSettings *settings = [UIUserNotificationSettings settingsForTypes:userNotificationTypes categories:nil];
            [application registerUserNotificationSettings:settings];
            [application registerForRemoteNotifications];
            #endif
        }
        else
        {
            // Register for Push Notifications before iOS 8
            [application registerForRemoteNotificationTypes:(UIRemoteNotificationTypeBadge | UIRemoteNotificationTypeAlert | UIRemoteNotificationTypeSound)];
            //        [application enabledRemoteNotificationTypes];
        }
        /*-------------------------------------------*/
        
        
        
        if (launchOptions != nil)
        {
            
            NSDictionary *dictionary = [launchOptions objectForKey:UIApplicationLaunchOptionsRemoteNotificationKey];
            if (dictionary != nil)
            {
                
                
                
                if ([CURRENT_USER_ID isEqualToString:@""] || [CURRENT_USER_ID isEqual:[NSNull null]] || CURRENT_USER_ID == nil || [CURRENT_USER_ID isEqualToString:@"(null)"])
                {
                    
                    SplashVC *splash=[[SplashVC alloc]initWithNibName:@"SplashVC" bundle:nil];
                    UINavigationController * navControl = [[UINavigationController alloc] initWithRootViewController:splash];
                    self.window.rootViewController = navControl;
                    
                    //    [[UIApplication sharedApplication] setStatusBarHidden:NO animated:NO];
                    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault animated:YES];
                    
                    [_window makeKeyAndVisible];
                }
                else
                {
                    
                    
                    NSMutableDictionary *userinfo=[[NSMutableDictionary alloc]init];
                    userinfo=[[[NSUserDefaults standardUserDefaults]valueForKey:@"Notificationdata"]mutableCopy];
                    
                    NSLog(@"RAJU :+==========     %@",userinfo);
                    
                    
                    
                    
                    
                    
                    
                    
                    
                    if (([[[userinfo valueForKey:@"message"]valueForKey:@"from_where"]isEqualToString:@"image_shared"]))
                    {
                        
                        NSLog(@"RAaaaaaaaaaaaa");
                        
                        
                        GalaryVc * galary=[[GalaryVc alloc]initWithNibName:@"GalaryVc" bundle:nil];
                        galary.isFrom=@"takeAPic";
                        
                        UINavigationController * navControl = [[UINavigationController alloc] initWithRootViewController:galary];
                        self.window.rootViewController = navControl;
                        [_window makeKeyAndVisible];
                        
                        [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault animated:YES];
                        

                        [self performSelector:@selector(gotosharewithme) withObject:nil afterDelay:0.0];
                        [self performSelector:@selector(reloadSharedImages) withObject:nil afterDelay:3];
                        
                    }
                    else
                    {
                        
                        
                        SplashVC *splash=[[SplashVC alloc]initWithNibName:@"SplashVC" bundle:nil];
                        UINavigationController * navControl = [[UINavigationController alloc] initWithRootViewController:splash];
                        self.window.rootViewController = navControl;
                        
                        //    [[UIApplication sharedApplication] setStatusBarHidden:NO animated:NO];
                        [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault animated:YES];
                        
                        [_window makeKeyAndVisible];
                    }
                    
                    
                }
              
                
                
                
            }
        }
        else
        {
            SplashVC *splash=[[SplashVC alloc]initWithNibName:@"SplashVC" bundle:nil];
            UINavigationController * navControl = [[UINavigationController alloc] initWithRootViewController:splash];
            self.window.rootViewController = navControl;
            
            //    [[UIApplication sharedApplication] setStatusBarHidden:NO animated:NO];
            [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault animated:YES];
            
            [_window makeKeyAndVisible];

        }
        
        
       
    }
    return YES;

}

#pragma mark SetFontMethod
-(void)setFontNameForApp
{
    
    
    //    normalGothicReguklarFont=@"4365";
    //    centutyGothickBoldFont=@"4637";
    //    gothicFont=@"GOTHIC";
    //    gothicbiFont=@"GOTHICBI";
    //    gothiciFont=@"GOTHICI";
    //    HelveticaNeueLTStd=@"HelveticaNeueLTStd-ThCn";
    //
    //
    
    NSString *strRobotoLight = @"Roboto-Light";
    NSString *strRobotoRegular = @"Roboto-Regular";
    NSString *strRobotoMedium = @"Roboto-Medium";
    NSString *strRobotoBold = @"Roboto-Bold";
    
    for (NSString* family in [UIFont familyNames])
    {
//         NSLog(@"family=======%@",family);
        for (NSString* name in [UIFont fontNamesForFamilyName: family]){
            //  NSLog(@"Hello  %@", name);
            if([strRobotoLight isEqualToString:name]){
                robotoLight = name;
            }
        }
    }
    for (NSString* family in [UIFont familyNames])
    {
        // NSLog(@"family=======%@",family);
        for (NSString* name in [UIFont fontNamesForFamilyName: family]){
            //  NSLog(@"Hello  %@", name);
            if([strRobotoRegular isEqualToString:name]){
                robotoRegular = name;
            }
        }
    }
    for (NSString* family in [UIFont familyNames])
    {
        // NSLog(@"family=======%@",family);
        for (NSString* name in [UIFont fontNamesForFamilyName: family]){
            //  NSLog(@"Hello  %@", name);
            if([strRobotoMedium isEqualToString:name]){
                robotoMedium = name;
            }
        }
    }
    for (NSString* family in [UIFont familyNames])
    {
        // NSLog(@"family=======%@",family);
        for (NSString* name in [UIFont fontNamesForFamilyName: family]){
            //  NSLog(@"Hello  %@", name);
            if([strRobotoBold isEqualToString:name]){
                robotoBold = name;
            }
        }
    }
    
   /* for (NSString* family in [UIFont familyNames])
    {
        // NSLog(@"family=======%@",family);
        for (NSString* name in [UIFont fontNamesForFamilyName: family]){
            //  NSLog(@"Hello  %@", name);
            if([strRegular isEqualToString:name]){
                normalGothicReguklarFont = name;
            }
        }
    }
    
    for (NSString* family in [UIFont familyNames])
    {
        for (NSString* name in [UIFont fontNamesForFamilyName: family]){
            // NSLog(@"Hello  %@", name);
            if([strBold isEqualToString:name]){
                centutyGothickBoldFont = name;
            }
        }
    }
    
    for (NSString* family in [UIFont familyNames])
    {
        for (NSString* name in [UIFont fontNamesForFamilyName: family]){
            // NSLog(@"Hello  %@", name);
            if([strItalic isEqualToString:name]){
                gothicFont = name;
            }
        }
    }
    
    for (NSString* family in [UIFont familyNames])
    {
        for (NSString* name in [UIFont fontNamesForFamilyName: family]){
            // NSLog(@"Hello  %@", name);
            if([strBoldIt isEqualToString:name]){
                gothicbiFont = name;
            }
        }
    }
    for (NSString* family in [UIFont familyNames])
    {
        for (NSString* name in [UIFont fontNamesForFamilyName: family]){
            // NSLog(@"Hello  %@", name);
            if([strLight isEqualToString:name]){
                SinkinSansThin = name;
            }
        }
    }for (NSString* family in [UIFont familyNames])
    {
        for (NSString* name in [UIFont fontNamesForFamilyName: family]){
            // NSLog(@"Hello  %@", name);
            if([strLightThinItalic isEqualToString:name]){
                SinkinSansThinItalic = name;
            }
        }
    }for (NSString* family in [UIFont familyNames])
    {
        for (NSString* name in [UIFont fontNamesForFamilyName: family]){
            // NSLog(@"Hello  %@", name);
            if([strLightXLight isEqualToString:name]){
                SinkinSansXLight = name;
            }
        }
    }for (NSString* family in [UIFont familyNames])
    {
        for (NSString* name in [UIFont fontNamesForFamilyName: family]){
            // NSLog(@"Hello  %@", name);
            if([strSinkinSansRegular isEqualToString:name]){
                SinkinSansRegular = name;
            }
        }
    }*/
    
}

#pragma mark Remote notification

#ifdef __IPHONE_8_0
- (void)application:(UIApplication *)application didRegisterUserNotificationSettings:   (UIUserNotificationSettings *)notificationSettings
{
    //register to receive notifications
    [application registerForRemoteNotifications];
}

- (void)application:(UIApplication *)application handleActionWithIdentifier:(NSString   *)identifier forRemoteNotification:(NSDictionary *)userInfo completionHandler:(void(^)())completionHandler
{
    //handle the actions
    if ([identifier isEqualToString:@"declineAction"]){
    }
    else if ([identifier isEqualToString:@"answerAction"]){
    }
}
#endif

- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken
{
    deviceTokenStr = [[[[deviceToken description]
                        stringByReplacingOccurrencesOfString: @"<" withString: @""]
                       stringByReplacingOccurrencesOfString: @">" withString: @""]
                      stringByReplacingOccurrencesOfString: @" " withString: @""] ;
    NSLog(@"My device token ============================>>>>>>>>>>>%@",deviceTokenStr);
    
    
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo
{
    
    
    
    
    if ([CURRENT_USER_ID isEqualToString:@""] || [CURRENT_USER_ID isEqual:[NSNull null]] || CURRENT_USER_ID == nil || [CURRENT_USER_ID isEqualToString:@"(null)"])
    {
        
    }
    else
    {
    
        NSLog(@"userInfo====================================%@",userInfo);
        [[NSUserDefaults standardUserDefaults]setObject:userInfo forKey:@"Notificationdata"];
        [[NSUserDefaults standardUserDefaults]synchronize];
        
        
        NSString * strAlert=[NSString stringWithFormat:@"%@",[[userInfo valueForKey:@"aps"] valueForKey:@"alert"]];
        UIAlertView * alert=[[UIAlertView alloc]initWithTitle:@"Camboodle" message:strAlert delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
        alert.tag=20;
        alert.delegate=self;
        [alert show];
        if ([[[userInfo valueForKey:@"message"]valueForKey:@"from_where"]isEqualToString:@"image_shared"])
        {
            [self performSelector:@selector(reloadSharedImages) withObject:nil afterDelay:3];
        }
    }
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (alertView.tag == 20)
    {
        NSLog(@"HELLO CLICKED");
        if ([CURRENT_USER_ID isEqualToString:@""] || [CURRENT_USER_ID isEqual:[NSNull null]] || CURRENT_USER_ID == nil || [CURRENT_USER_ID isEqualToString:@"(null)"])
        {

        }
        else
        {
            [self performSelector:@selector(gotosharewithme) withObject:nil afterDelay:0.0];
        }

        
    }
}
-(void)gotosharewithme
{
    [[NSNotificationCenter defaultCenter] postNotificationName:@"GoToshareWithme" object:nil];
}
-(void)reloadSharedImages
{
    [[NSNotificationCenter defaultCenter] postNotificationName:@"addSharedToMeImagesNsNotification" object:nil];
}
- (void)application:(UIApplication*)application didFailToRegisterForRemoteNotificationsWithError:(NSError*)error
{
    NSLog(@"Failed to get token, error: %@", error);
}

#pragma mark - Orientation


-(UIInterfaceOrientationMask)application:(UIApplication *)application supportedInterfaceOrientationsForWindow:(UIWindow *)window
{
//    if (isPresent)
//    {
//        return UIInterfaceOrientationMaskAll;
//    }
//    else
    {
        return UIInterfaceOrientationMaskPortrait;
    }
    
    
}

#pragma mark - Life Cycle
- (void)applicationWillResignActive:(UIApplication *)application {
  
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    /*Notification Reload I shared images*/
    [[UIApplication sharedApplication] setApplicationIconBadgeNumber:0];
   // [[UIApplication sharedApplication] cancelAllLocalNotifications];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"ReloadISharedImagesNsNotification" object:nil];
       /*add Shared to me images*/
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}
#pragma mark Location manager delegate
- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation
{
    //  NSLog(@"didUpdateToLocation: %@", newLocation);
    CLLocation *currentLocation = newLocation;
    
    if (currentLocation != nil)
    {
        appLatitude =[NSString stringWithFormat:@"%f",currentLocation.coordinate.latitude];
        appLongitude =[NSString stringWithFormat:@"%f",currentLocation.coordinate.longitude];
    }
    NSLog(@"lat==>%f, longt==>%f",currentLocation.coordinate.latitude,currentLocation.coordinate.longitude);
}

@end
