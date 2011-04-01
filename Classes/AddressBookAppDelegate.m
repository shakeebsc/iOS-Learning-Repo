//
//  AddressBookAppDelegate.m
//  AddressBook
//
//  Created by Eric Kern on 6/15/09.
//  Copyright Deitel & Associates Inc. 2009. All rights reserved.
//

#import "AddressBookAppDelegate.h"
#import "RootViewController.h"


@implementation AddressBookAppDelegate

@synthesize window;
@synthesize navigationController;


- (id)init {
   if (self = [super init]) {
      // 
   }
   return self;
}


- (void)applicationDidFinishLaunching:(UIApplication *)application {
   
   // Configure and show the window
   [window addSubview:[navigationController view]];
   [window makeKeyAndVisible];
}

- (void)addContact {
   
}


- (void)applicationWillTerminate:(UIApplication *)application {
   // Save data if appropriate
}


- (void)dealloc {
   [navigationController release];
   [window release];
   [super dealloc];
}

@end
