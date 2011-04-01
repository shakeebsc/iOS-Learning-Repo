//  RootViewController.m
//  Controller for the main table of the Address Book app.
#import "RootViewController.h"

@implementation RootViewController

// called when view finishes initializing
- (void)viewDidLoad
{
   // creates list of valid directories for saving a file
   NSArray *paths = NSSearchPathForDirectoriesInDomains(
      NSDocumentDirectory, NSUserDomainMask, YES);
   
   // get the first directory because we only care about one
   NSString *directory = [paths objectAtIndex:0];
   
   // concatenate the file name "contacts" to the end of the path
   filePath = [[NSString alloc] initWithString:
      [directory stringByAppendingPathComponent:@"contacts"]];
   
   // retrieve the default NSFileManager
   NSFileManager *fileManager = [NSFileManager defaultManager];
   
   // if the file exists, initialize contacts with its contents
   if ([fileManager fileExistsAtPath:filePath])
      contacts = [[NSMutableArray alloc] initWithContentsOfFile:filePath];
   else // else initialize contacts as empty NSMutableArray
      contacts = [[NSMutableArray alloc] init];
   
   // create the button to add a new contact
   UIBarButtonItem *plusButton = [[UIBarButtonItem alloc]             
      initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self
      action:@selector(addContact)];                                  
   
   // create the back UIBarButtonItem
   UIBarButtonItem *backButton = [[UIBarButtonItem alloc]initWithTitle:
      @"Back" style:UIBarButtonItemStylePlain target:nil action:nil];  
   
   // add the plus UIBarButtonItem to the top bar on the right
   self.navigationItem.rightBarButtonItem = plusButton;        
   self.navigationItem.leftBarButtonItem = self.editButtonItem;
   
   // set the back UIBarButtonItem to show if the user navigates away
   self.navigationItem.backBarButtonItem = backButton;
   [plusButton release]; // release the plusButton UIButton
   [backButton release]; // release the backButton UIButton
} // end method viewDidLoad

// called when the user touches the plus button
- (void)addContact
{
   // create new AddViewController
   AddViewController *controller = [[AddViewController alloc] init];
   controller.delegate = self; // set controller’s delegate to self
   
   // show the new controller
   [self presentModalViewController:controller animated:YES];
   [controller release]; // release the controller AddViewController
} // end method addContact

- (void)addViewControllerDidFinishAdding:(AddViewController *)controller
{
   // get the values for the new person to be added
   NSDictionary *person = [controller values];
   
   // if there is a person
   if (person != nil)
   {
     [contacts addObject:person]; // add person to contacts
     
     // sort the contacts array in alphabetical name by order
     [contacts sortUsingSelector:@selector(compareContactNames:)];
   } // end if
   
   // make the AddViewControler stop showing
   [self dismissModalViewControllerAnimated:YES];

   // write contacts to file
   [contacts writeToFile:filePath atomically:NO];
   
   [self.tableView reloadData]; // refresh the table view
} // end method finishedAdding

// called by the table view to determine the number of rows in a section
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:
   (NSInteger)section
{
   return contacts.count; //return the number of contacts
} // end method tableView:numberOfRowsInSection:

// returns tableView’s cell at specified indexPath
- (UITableViewCell *)tableView:(UITableView *)tableView
   cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
   // create cell identifier
   static NSString *MyIdentifier = @"StandardCell";
   UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:
      MyIdentifier]; // get a reusable cell
   
   // if no reusable cells are available
   if (cell == nil)
   {
      // create a new editable cell
      cell = [[[UITableViewCell alloc] initWithStyle: 
         UITableViewCellStyleDefault reuseIdentifier:MyIdentifier] 
         autorelease];
   } // end if
   
   // set up the cell
   NSString *name = [[contacts objectAtIndex:indexPath.row] valueForKey:
      @"Name"];
   UILabel *label = [cell textLabel]; // get the label for the cell
   label.text = name; // set the text of the label
   
   // make the cell display an arrow on the right side
   cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
   return cell; // return the updated cell
} // end method tableView:cellForRowAtIndexPath:

// called when the user touches one of the rows in the table
 - (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:
   (NSIndexPath *)indexPath
{
   // initialize a ContactViewController
   ContactViewController *controller = [[ContactViewController alloc]
      initWithNibName:@"ContactViewController" bundle:nil];
   
   // give controller the data to display
   [controller setPerson:[contacts objectAtIndex:[indexPath row]]];
   [controller updateTitle]; // update the title with the new data
   
   // show the ContactViewController
   [self.navigationController pushViewController:controller animated:YES];
   [controller release]; // release the controller ContactViewController
} // end method tableView:didSelectRowAtIndexPath:

// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:
   (UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:
   (NSIndexPath *)indexPath
{   
   // "delete" editing style is committed 
   if (editingStyle == UITableViewCellEditingStyleDelete)
   {
      // remove contact at indexPath.row
      [contacts removeObjectAtIndex:indexPath.row];

      // delete the row from the data source
      [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject: 
         indexPath] withRowAnimation:UITableViewRowAnimationFade];
      
      // write contacts to file
      [contacts writeToFile:filePath atomically:NO];
   } // end if
} // end method tableView:commitEditingStyle:forRowAtIndexPath:

/* // called to determine what orientations our View allows
- (BOOL)shouldAutorotateToInterfaceOrientation:
   (UIInterfaceOrientation)interfaceOrientation
{
   // return YES for supported orientations
   return (interfaceOrientation == UIInterfaceOrientationPortrait);
} // end method shouldAutorotateToInterfaceOrientation */

// release MainViewController’s memory
- (void)dealloc
{
   [contacts release]; // release the contacts NSMutableArray
   [super dealloc]; // call the superclass’s dealloc method
} // end method dealloc
@end // end RootViewController implementation

// define NSDictionary's sorting category method
@implementation NSDictionary (sorting)
- (NSComparisonResult)compareContactNames:(NSDictionary *)contact
{
   // compare this contact's title to that of the given contact
   return [[self valueForKey:@"Name"] 
      caseInsensitiveCompare:[contact valueForKey:@"Name"]];
} // end method compareContactNames
@end // end NSDictionary's sorting category

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

