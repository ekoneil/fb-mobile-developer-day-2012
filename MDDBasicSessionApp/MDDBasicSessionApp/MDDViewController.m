//
//  MDDViewController.m
//  MDDBasicSessionApp
//
//  Created by Eddie O'Neil on 11/13/12.
//  Copyright (c) 2012 Eddie O'Neil. All rights reserved.
//

#import "MDDViewController.h"
#import <FacebookSDK/FacebookSDK.h>

@interface MDDViewController () <FBLoginViewDelegate, CLLocationManagerDelegate>
@property (strong, nonatomic) CLLocationManager *locationManager;
@property (strong, nonatomic) FBCacheDescriptor *placeCacheDescriptor;
@property (strong, retain) id<FBGraphPlace> place;
@property (strong, retain) NSArray* friendIDs;

@end

@implementation MDDViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    FBLoginView* loginView = [[FBLoginView alloc]init];
    loginView.delegate = self;
    loginView.frame = CGRectOffset(loginView.frame, 20, 50);
    [self.view addSubview:loginView];
    
    // Get the CLLocationManager going.
    self.locationManager = [[CLLocationManager alloc] init];
    self.locationManager.delegate = self;
    self.locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters;
    // We don't want to be notified of small changes in location, preferring to use our
    // last cached results, if any.
    self.locationManager.distanceFilter = 50;
    [self.locationManager startUpdatingLocation];
}

-(void) loginViewShowingLoggedOutUser:(FBLoginView *)loginView {
    self.uiLabel.text = @"Hi, please login to get started.";
}

-(void) loginViewShowingLoggedInUser:(FBLoginView *)loginView {
    FBRequest* request = [FBRequest requestForMyFriends];
    request.parameters[@"fields"] =
        [NSString stringWithFormat:@"%@,installed", request.parameters[@"fields"]];
    
    [request startWithCompletionHandler:^(FBRequestConnection *connection, id result, NSError *error) {
        NSMutableString* string = [[NSMutableString alloc]init];
        
        for(id<FBGraphUser> user in result[@"data"]) {
            [string appendFormat:@"%@ installed the app? %@\n", [user first_name], user[@"installed"] ? @"Yes" : @"No"];
        }
        
        self.uiTextView.text = string;
    }];
}

-(void) loginViewFetchedUserInfo:(FBLoginView *)loginView user:(id<FBGraphUser>)user {
    self.uiLabel.text =
    [NSString stringWithFormat:@"Hi, %@", [user first_name]];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)clickBasicShare:(id)sender {
    [FBNativeDialogs presentShareDialogModallyFrom:self initialText:@"At Mobile Developer Day 2012" image:nil url:nil handler:^(FBNativeDialogResult result, NSError *error) {
        if(error) {
            NSLog(@"Error!");
        }
    }];
}

- (IBAction)clickFriends:(id)sender {
    FBFriendPickerViewController* vc = [[FBFriendPickerViewController alloc]init];
    [vc loadData];
    [vc presentModallyFromViewController:self animated:YES handler:^(FBViewController *sender, BOOL donePressed) {
        if(donePressed) {
            self.friendIDs = vc.selection;
            NSLog(@"Success!");
        }
    }];
}

- (IBAction)clickPlace:(id)sender {
    FBPlacePickerViewController* vc = [[FBPlacePickerViewController alloc]init];
    [vc configureUsingCachedDescriptor:self.placeCacheDescriptor];
    [vc loadData];
    [vc presentModallyFromViewController:self animated:YES handler:^(FBViewController *sender, BOOL donePressed) {
        if(donePressed) {
            self.place = vc.selection;
            NSLog(@"Success");
        }
    }];
}

- (IBAction)clickShare:(id)sender {
    [[FBSession activeSession]
        reauthorizeWithPublishPermissions:@[@"publish_actions"]
        defaultAudience:FBSessionDefaultAudienceFriends
        completionHandler:^(FBSession *session, NSError *error) {
        
        [FBRequestConnection startForPostStatusUpdate:@"At Mobile Developer Day 2012 with a working app!" place:[self.place id] tags:self.friendIDs completionHandler:^(FBRequestConnection *connection, id result, NSError *error) {
            if(error) {
                NSLog(@"Error!");
            } else {
                NSLog(@"Success! %@", result);
            }
        }];
    }];
}

-(void)locationManager:manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation {
    if (!oldLocation ||
        (oldLocation.coordinate.latitude != newLocation.coordinate.latitude &&
         oldLocation.coordinate.longitude != newLocation.coordinate.longitude &&
         newLocation.horizontalAccuracy <= 100.0)) {
            // Fetch data at this new location, and remember the cache descriptor.
            self.placeCacheDescriptor =
            [FBPlacePickerViewController cacheDescriptorWithLocationCoordinate:newLocation.coordinate
                                                                radiusInMeters:1000
                                                                    searchText:nil
                                                                  resultsLimit:50
                                                              fieldsForRequest:nil];
            
            [self.placeCacheDescriptor prefetchAndCacheForSession:FBSession.activeSession];
        }
}

-(void)locationManager:manager didFailWithError:(NSError *)error {
    NSLog(@"Error! %@", error);
}
@end
















