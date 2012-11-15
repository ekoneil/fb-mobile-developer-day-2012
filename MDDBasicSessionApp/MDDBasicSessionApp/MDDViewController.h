//
//  MDDViewController.h
//  MDDBasicSessionApp
//
//  Created by Eddie O'Neil on 11/13/12.
//  Copyright (c) 2012 Eddie O'Neil. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MDDViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITextView *uiTextView;
@property (weak, nonatomic) IBOutlet UILabel *uiLabel;

- (IBAction)clickBasicShare:(id)sender;
- (IBAction)clickFriends:(id)sender;
- (IBAction)clickPlace:(id)sender;
- (IBAction)clickShare:(id)sender;
@end
