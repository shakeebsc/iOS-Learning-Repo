// AddViewController.h
// AddViewController’s interface declaration.
// Implementation in AddViewController.m
#import <UIKit/UIKit.h>
#import "EditableCell.h"
static const int KEYBOARD_HEIGHT = 200; // the height of the keyboard

@protocol AddViewControllerDelegate; // AddViewControllerDelegate protocol

@interface AddViewController : UIViewController <UITableViewDataSource, 
   EditableCellDelegate>
{
   id <AddViewControllerDelegate> delegate; // this class's delegate
   IBOutlet UITableView *table; // table that displays editable fields
   NSArray *fields; // an array containing the field names
   NSMutableDictionary *data; // dictionary containing contact data
   BOOL keyboardShown; // is the keyboard visible?
   EditableCell *currentCell; // the cell the user is currently editing
} // end instance variable declaration

// declare delegate and table as properties
@property (nonatomic, assign) id <AddViewControllerDelegate> delegate;
@property (nonatomic, retain) IBOutlet UITableView *table; 
@property (readonly, copy, getter=values) NSDictionary *data;
- (IBAction)doneAdding:sender; // return to RootView
- (NSDictionary *)values; // return values NSDictionary
- (void)clearFields; // clear table cells
@end // end interface AddViewController

// notifies RootViewcontroller that Done Button was touched
@protocol AddViewControllerDelegate
- (void)addViewControllerDidFinishAdding:(AddViewController *)controller;
@end // end protocol AddViewControllerDelegate


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

