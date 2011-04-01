// ContactViewController.m
// ContactViewController class displays information for a contact. 
#import "ContactViewController.h"
#import "EditableCell.h"

@implementation ContactViewController

@synthesize person; // generate get and set methods for person

// update the title in the navigation bar
- (void)updateTitle
{
   // set the title to the name of the contact
   [self.navigationItem setTitle:[person valueForKey:@"Name"]];
} // end method updateTitle

// determines how many rows are in a given section
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:
   (NSInteger)section
{
   return person.count; // return the number of total rows
} // end method tableView:numberOfRowsInSection:

// retrieve tableView’s cell at the given index path
- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath
{   
   // used to identify cell as a normal cell
   static NSString *MyIdentifier = @"NormalCell";                
   
   // get a reusable cell
   UITableViewCell *cell =                                       
      [tableView dequeueReusableCellWithIdentifier:MyIdentifier];

   // if there are no cells to be reused, create one
   if (cell == nil)
   {
      // create a new cell
      cell = [[UITableViewCell alloc] initWithStyle:
         UITableViewCellStyleDefault reuseIdentifier:MyIdentifier];
      [cell autorelease]; // autorelease the cell UITableViewCell
   } // end if
   
   // get the key at the appropriate index in the dictionary
   NSString *key = [[person allKeys] objectAtIndex:indexPath.row];
   NSString *value = [person valueForKey:key]; // get the value
   UILabel *label = [cell textLabel]; // get the label for the cell
   
   // update the text of the label
   label.text = [NSString stringWithFormat:@"%@: %@", key, value];
   return cell; // return the customized cell
} // end method tableView:cellForRowAtIndexPath:

// called to determine what orientations our View allows
- (BOOL)shouldAutorotateToInterfaceOrientation:
(UIInterfaceOrientation)interfaceOrientation
{
   // allow only the portrait orientation
   return (interfaceOrientation == UIInterfaceOrientationPortrait);
} // end method shouldAutorotateToInterfaceOrientation:

// free ContactViewController’s memory
- (void)dealloc
{
   [person release]; // release the person NSDictionary
   [super dealloc]; // call the superclass’s dealloc method
} // end method dealloc
@end // end implementation of ContactViewController

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

