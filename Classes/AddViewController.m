// AddViewController.m
// Controls a view for adding a new contact.
#import "AddViewController.h"

@implementation AddViewController
@synthesize delegate;
@synthesize table;

// initialize the AddViewController
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:
   (NSBundle *)nibBundleOrNil
{
   // if the superclass initialized properly
   if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil])
   {
      // create the names of the fields
      fields = [[NSArray alloc] initWithObjects:@"Name", @"Email",
         @"Phone", @"Street", @"City/State/Zip", nil];

      // initialize the data NSMutableDictionary
      data = [[NSMutableDictionary alloc] initWithCapacity:fields.count];
      keyboardShown = NO; // hide the keyboard
      currentCell = nil; // there is no cell currently selected
   } // end if
   
   return self; // return this AddViewController
} // end method initWithNibName:bundle:

// alert RootViewController that the "Done" Button was touched
- (IBAction)doneAdding:sender
{
   // if there is a cell currently selected
   if (currentCell != nil)
      // update data with the text in the currently selected cell
      [data setValue:currentCell.textField.text
         forKey:currentCell.label.text];
   
   // return to the RootView
   [delegate addViewControllerDidFinishAdding:self]; 
} // end method doneAdding:

// returns a dictionary containing all the supplied contact information
- (NSDictionary *)values
{
   // if the user did not supply a name
   if ([data valueForKey:@"Name"] == nil)
      return nil; // return nil
   
   // returns a copy of the data NSDictionary
   return [NSDictionary dictionaryWithDictionary:data];
} // end method values

// clear table’s cells
- (void)clearFields
{
   [data removeAllObjects]; // remove all of the stored keys and values
   
   // loop through the fields
   for (int i = 0; i < fields.count; i++) 
   {
      // get the index path for the given row
      NSIndexPath *path = [NSIndexPath indexPathForRow:i inSection:0];
      
      // get the cell at the index path
      EditableCell *cell =
      (EditableCell *)[table cellForRowAtIndexPath:path];
      [cell clearText]; // clear all the text in the cell
   } // end for
} // end method clearFields

// called when the user begins editing a cell
- (void)editableCellDidBeginEditing:(EditableCell *)cell
{
   // if the keyboard is hidden
   if (!keyboardShown)
   {
      // animate resizing the table to fit the keyboard
      [UIView beginAnimations:nil context:NULL]; // begin animation block
      [UIView setAnimationDuration:0.25]; // set the animation duration
      [UIView setAnimationCurve:UIViewAnimationCurveEaseIn];
      CGRect frame = table.frame; // get the frame of the table
      frame.size.height -= KEYBOARD_HEIGHT; // subtract from the height
      [table setFrame:frame]; // apply the new frame
      [UIView commitAnimations]; // end animation block
   } // end if
   
   keyboardShown = YES; // the keyboard appears on the screen
   currentCell = cell; // update the currently selected cell
   
   // get the index path for the selected cell
   NSIndexPath *path = [table indexPathForCell:cell];
   
   // scroll the table so that the selected cell is at the top
   [table scrollToRowAtIndexPath:path atScrollPosition:
      UITableViewScrollPositionTop animated:YES];
} // end method cellBeganEditing:

// called when the user stops editing a cell or selects another cell
- (void)editableCellDidEndEditing:(EditableCell *)cell
{
   // add the new entered data
   [data setValue:cell.textField.text forKey:cell.label.text];
} // end method editableCellDidEndEditing:

// called when the user touches the Done button on the keyboard
- (void)editableCellDidEndOnExit:(EditableCell *)cell
{

   // resize the table to fit the keyboard
   CGRect frame = table.frame; // get the frame of the table
   frame.size.height += KEYBOARD_HEIGHT; // subtract from the height
   [table setFrame:frame]; // apply the new frame
   
   keyboardShown = NO; // hide the keyboard
   currentCell = nil; // there is no cell currently selected
} // end method editableCellDidEndOnExit:

// returns the number of sections in table
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
   return 2; // the number of sections in the table
} // end method numberOfSectionsInTableView:

// returns the number of rows in the given table section
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:
   (NSInteger)section
{
   // if it’s the first section
   if (section == 0)
      return 3; // there are three rows in the first section
   else
      return fields.count - 3; // all other rows are in the second section
} // end method tableView:numberOfRowsInSection:

// returns the title for the given section
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:
   (NSInteger)section
{
   // if it’s the second section
   if (section == 1) // return the title
      return @"Address";
   else // none of the other sections have titles
      return nil; // return nil
} // end method tableView:titleForHeaderInSection:

// returns the cell at the given index path
- (UITableViewCell *)tableView:(UITableView *)tableView
   cellForRowAtIndexPath:(NSIndexPath *)indexPath
{   
   static NSString *identifier = @"EditableCell";
   
   // get a reusable cell
   EditableCell *cell = (EditableCell *)[table
      dequeueReusableCellWithIdentifier:identifier];
   
   // if no reusable cell exists
   if (cell == nil)
   {   
      // create a new EditableCell
      cell = [[EditableCell alloc] initWithStyle:
              UITableViewCellStyleDefault reuseIdentifier:identifier];
      [cell autorelease]; // autorelease the cell UITableViewCell
   } // end if
   // get the key for the given index path
   NSString *key =
      [fields objectAtIndex:indexPath.row + indexPath.section * 3];
   [cell setLabelText:key]; // update the cell text with the key
   
   // update the text in the text field with the value
   cell.textField.text = [data valueForKey:key];
   
   // if cell is going to store an e-mail address (1st section 2nd row)
   if (indexPath.section == 0 && indexPath.row == 1)
   {
      // set the cell's keyboard to email address keyboard
      cell.textField.keyboardType = UIKeyboardTypeEmailAddress;
   } // end if
   // if the cell is going to store a phone number (1st section 3rd row)
   else if (indexPath.section == 0 && indexPath.row == 2)
   {
      // set the cell's keyboard to the phone pad keyboard
      cell.textField.keyboardType = UIKeyboardTypePhonePad;
   } // end else if
   cell.editing = NO; // cell is not in editing mode
   cell.delegate = self; // set this object as the cell's delegate
   
   // make the cell do nothing when it is selected
   cell.selectionStyle = UITableViewCellSelectionStyleNone;
   return cell; // return the customized cell
} // end method tableView:cellForRowAtIndexPath:

// called to determine what orientations our View allows
- (BOOL)shouldAutorotateToInterfaceOrientation:
   (UIInterfaceOrientation)interfaceOrientation
{
   // return YES for supported orientations
   return (interfaceOrientation == UIInterfaceOrientationPortrait);
} // end method shouldAutorotateToInterfaceOrientation:

// free AddViewController’s memory
- (void)dealloc
{
   [fields release]; // release the fields NSArray
   [data release]; // release the data NSMutableDictionary
   [table release]; // release the table UITableView
   [super dealloc]; // release the superclass
} // end method dealloc
@end // end AddViewController’s implementation


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

