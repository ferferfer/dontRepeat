//
//  FERDontRepeatCell.h
//  DontRepeat
//
//  Created by Fernando Garcia Corrochano on 14/08/14.
//  Copyright (c) 2014 FernandoGarciaCorrochano. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FERDontRepeatCell : UICollectionViewCell
@property (strong, nonatomic) UIImageView *thumbnail;
@property (strong, nonatomic) UIView *cell;
@property (strong, nonatomic) UILabel *title;
@property (strong, nonatomic) UILabel *dateLabel;
@property (strong, nonatomic) NSString *ID;
@end
