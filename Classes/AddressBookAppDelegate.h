//
//  AddressBookAppDelegate.h
//  AddressBook
//
//  Created by Eric Kern on 6/15/09.
//  Copyright Deitel & Associates Inc. 2009. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AddressBookAppDelegate : NSObject <UIApplicationDelegate> {
   
   IBOutlet UIWindow *window;
   IBOutlet UINavigationController *navigationController;
}

@property (nonatomic, retain) UIWindow *window;
@property (nonatomic, retain) UINavigationController *navigationController;

- (void)addContact;

@end

