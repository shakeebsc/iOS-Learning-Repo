// EditableCell.m
// EditcableCell’s class definition
#import "EditableCell.h"
@implementation EditableCell

@synthesize textField; // synthesize get and set methods for delegate
@synthesize label; // synthesize get and set methods for delegate
@synthesize delegate; // synthesize get and set methods for delegate

// initialize the cell
- (id)initWithStyle:(UITableViewCellStyle)style
    reuseIdentifier:(NSString *)reuseIdentifier
{
   // call the superclass
   if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])
   {
      // create the label on the left side
      label = [[UILabel alloc] initWithFrame:CGRectMake(20, 10, 0, 20)];
      
      // create the text field to the right of the label
      textField =
         [[UITextField alloc] initWithFrame:CGRectMake(0, 10, 0, 20)];
      
      [textField setDelegate:self]; // set the delegate to this object
      
      // call textFieldDidEndOnExit when the Done key is touched
      [textField addTarget:self action:@selector(textFieldDidEndOnExit)
          forControlEvents:UIControlEventEditingDidEndOnExit];
      [self.contentView addSubview:label]; // add label to the cell
      [self.contentView addSubview:textField]; // add textField to cell
   } // end if
   
   return self; // return this Editable cell
} // end method initWithFrame:reuseIdentifier:

// method is called when the user touches the Done button on the keyboard
- (void)textFieldDidEndOnExit
{
   [textField resignFirstResponder]; // make the keyboard go away
   [delegate editableCellDidEndOnExit:self]; // call the delegate method
} // end method textFieldDidEndOnExit

// set the text of the label
- (void)setLabelText:(NSString *)text
{
   label.text = text; // update the text
   
   // get the size of the passed text with the current font
   CGSize size = [text sizeWithFont:label.font];
   CGRect labelFrame = label.frame; // get the frame of the label
   labelFrame.size.width = size.width; // size the frame to fit the text
   label.frame = labelFrame; // update the label with the new frame
   
   CGRect textFieldFrame = textField.frame; // get the frame of textField
   
   // move textField to 30 pts to the right of label
   textFieldFrame.origin.x = size.width + 30;
   
   // set the width to fill the remainder of the screen
   textFieldFrame.size.width =
   self.frame.size.width - textFieldFrame.origin.x;
   textField.frame = textFieldFrame; // assign the new frame
} // end method setLabelText:

// clear the text in textField
- (void)clearText
{
   textField.text = @""; // update textField with an empty string
} // end method clearText

// delegate method of UITextField, called when a text field begins editing
- (void)textFieldDidBeginEditing:(UITextField *)textField
{
   [delegate editableCellDidBeginEditing:self]; // inform the delegate
} // end method textFieldDidBeginEditing:

// delegate method of UITextField, called when a text field ends editing
- (void)textFieldDidEndEditing:(UITextField *)textField
{
   [delegate editableCellDidEndEditing:self]; // inform the delegate
} // end method textFieldDidEndEditing:

// free EditableCell's memory
- (void)dealloc
{
  [textField release]; // release the textField UITextField
  [label release]; // release the label UILabel
  [super dealloc]; // call the superclass's dealloc method
} // end method dealloc
@end // end EditableCell class definition



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

