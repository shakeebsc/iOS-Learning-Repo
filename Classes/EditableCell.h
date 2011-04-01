// EditableCell.h
// Interface for UITableViewCell that contains a label and a text field.
// Implementation in EditableCell.m

#import <UIKit/UIKit.h>

@protocol EditableCellDelegate; // declare EditableCellDelegate Protocol

@interface EditableCell : UITableViewCell <UITextFieldDelegate>
{
   id <EditableCellDelegate> delegate; // this class's delegate
   UITextField *textField; // text field the user edits
   UILabel *label; // label on the left side of the cell
} // end instance variables declaration

// declare textField as a property
@property (nonatomic, retain) UITextField *textField;

// declare label as a property
@property (readonly, retain) UILabel *label;

//declare delegate as a property
@property (nonatomic, assign) id <EditableCellDelegate> delegate;

- (void)setLabelText:(NSString *)text; // set the text of label
- (void)clearText; // clear all the text out of textField
@end // end interface EditableCell

@protocol EditableCellDelegate // protocol for the delegate

// called when the user begins editing a cell
- (void)editableCellDidBeginEditing:(EditableCell *)cell;

// called when the user stops editing a cell
- (void)editableCellDidEndEditing:(EditableCell *)cell;

// called when the user touches the Done button on the keyboard
- (void)editableCellDidEndOnExit:(EditableCell *)cell;
@end // end protocol EditableCellDelegate



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

