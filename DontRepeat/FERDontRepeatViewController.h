//
//  FERDontRepeatViewController.h
//  DontRepeat
//
//  Created by Fernando Garcia Corrochano on 03/09/14.
//  Copyright (c) 2014 FernandoGarciaCorrochano. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FERUser.h"
#import "DontRepeat.h"

@protocol FERDontRepeatViewControllerDelegate <NSObject>

-(void)addDontRepeat:(DontRepeat *)dontRepeat;
-(void)removeDontRepeat:(DontRepeat *)dontRepeat;
-(void)updateDontRepeat:(DontRepeat *)dontRepeat with:(DontRepeat *)newDontRepeat;

@end


@interface FERDontRepeatViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIButton *titleButton;
@property (weak, nonatomic) IBOutlet UITextField *titleTextField;
@property (weak, nonatomic) IBOutlet UIButton *dateButton;
@property (weak, nonatomic) IBOutlet UIDatePicker *datePicker;
@property (weak, nonatomic) IBOutlet UIButton *descriptionButton;
@property (weak, nonatomic) IBOutlet UITextView *descriptionTextView;
@property (weak, nonatomic) IBOutlet UIButton *pictureButton;
@property (weak, nonatomic) IBOutlet UIImageView *pictureImageView;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *saveButton;
@property (weak, nonatomic) IBOutlet UIButton *deleteButton;
@property	(nonatomic,strong)FERUser *user;
@property	(nonatomic,strong)DontRepeat *dontRepeat;
@property	(nonatomic, weak)	id<FERDontRepeatViewControllerDelegate> delegate;

@end
