//
//  FERMainCollectionView.h
//  DontRepeat
//
//  Created by Fernando Garcia Corrochano on 20/08/14.
//  Copyright (c) 2014 FernandoGarciaCorrochano. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <FirebaseSimpleLogin/FirebaseSimpleLogin.h>
#import "FERUser.h"
#import "MGTileMenuController.h"

@interface FERMainCollectionView : UIViewController

@property	(nonatomic,strong)FERUser *user;
@property (nonatomic,strong)FirebaseSimpleLogin *authClient;
@property (strong, nonatomic) MGTileMenuController *tileController;

@end
