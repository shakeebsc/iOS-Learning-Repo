// RootViewController.h
// Controller for the main table of the Address Book app.
// Implementation in RootViewController.m
#import <UIKit/UIKit.h>
#import "AddViewController.h"
#import "ContactViewController.h"

// begin interface RootViewController
@interface RootViewController : UITableViewController
   <AddViewControllerDelegate>
{
   NSMutableArray *contacts; // contains all the added contacts
   NSString *filePath; // the path of the save file
} // end instance variables declaration

- (void)addContact; // present the view for adding a new contact
@end // end interface RootViewController

// begin NSDictionary's sorting category
@interface NSDictionary (sorting)
   // compares this contact's name to the given contact's title
   - (NSComparisonResult)compareContactNames:(NSDictionary *)contact;
@end // end category sorting of interface NSDictionary


/**************************************************************************
 * (C) Copyright 2010 by Deitel & Associates, Inc. All Rights Reserved.   *
 *                                                                        *
 * DISCLAIMER: The authors and publisher of this book have used their     *
 * best efforts in preparing the book. These efforts include the          *
 * development, research, and testing of the theories and programs        *
 * to determine their effectiveness. The authors and publisher make       *
 * no warranty of any kind, expressed or implied, with regard to these    *
 * programs or to the documentation contained in these books. The authors *
 * and publisher shall not be liable in any event for incidental or       *
 * consequential damages in connection with, or arising out of, the       *
 * furnishing, performance, or use of these programs.                     *
 *                                                                        *
 * As a user of the book, Deitel & Associates, Inc. grants you the        *
 * nonexclusive right to copy, distribute, display the code, and create   *
 * derivative apps based on the code for noncommercial purposes only--so  *
 * long as you attribute the code to Deitel & Associates, Inc. and        *
 * reference www.deitel.com/books/iPhoneFP/. If you have any questions,   *
 * or specifically would like to use our code for commercial purposes,    *
 * contact deitel@deitel.com.                                             *
 *************************************************************************/

