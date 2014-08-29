//
//  FERDontRepeatCell.m
//  DontRepeat
//
//  Created by Fernando Garcia Corrochano on 14/08/14.
//  Copyright (c) 2014 FernandoGarciaCorrochano. All rights reserved.
//

#import "FERDontRepeatCell.h"
@interface FERDontRepeatCell ()

@end

@implementation FERDontRepeatCell

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
			[self configura];
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

-(void)setSelected:(BOOL)selected{
	[super setSelected:selected];
	if (selected) {
    self.thumbnail.alpha=0.5;
	}else{
		self.thumbnail.alpha=1;
	}
}

-(void)configura{

	self.thumbnail.contentMode=UIViewContentModeScaleAspectFill;
	self.thumbnail.layer.borderColor=[UIColor whiteColor].CGColor;
	self.thumbnail.layer.borderWidth=5.0;
	[self.contentView addSubview:self.thumbnail];
	self.contentView.clipsToBounds=YES;
}

-(void)layoutSubviews{
	self.thumbnail.frame=self.bounds;
}



@end
