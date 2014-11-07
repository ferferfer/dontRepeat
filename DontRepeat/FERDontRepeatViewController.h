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

@property (strong, nonatomic) UIBarButtonItem *saveButton;
@property (strong, nonatomic) UIButton *deleteButton;
@property	(nonatomic,strong)FERUser *user;
@property	(nonatomic,strong)DontRepeat *dontRepeat;
@property	(nonatomic, weak)	id<FERDontRepeatViewControllerDelegate> delegate;

@end
