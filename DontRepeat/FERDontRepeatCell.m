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

-(void)configura{
	
	self.contentView.backgroundColor=[UIColor clearColor];
	
	self.thumbnail=[[UIImageView alloc]initWithFrame:self.bounds];
	self.thumbnail.contentMode=UIViewContentModeScaleAspectFill;
	self.thumbnail.layer.cornerRadius=25.0;
	[self.thumbnail setClipsToBounds:YES];
	[self.contentView addSubview:self.thumbnail];

	self.title=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, self.bounds.size.width, 25)];
	[self.title setFont:[UIFont fontWithName:@"Arial-BoldMT" size:24]];
	self.title.adjustsFontSizeToFitWidth = YES;
	[self.title setTextAlignment:NSTextAlignmentCenter];
	self.title.textColor = [UIColor blackColor];
	[self.thumbnail addSubview:self.title];
	
	self.dateLabel=[[UILabel alloc]initWithFrame:CGRectMake(0, self.bounds.size.height-20, self.bounds.size.width, 20)];
	[self.dateLabel setFont:[UIFont fontWithName:@"Arial-BoldMT" size:24]];
	self.dateLabel.adjustsFontSizeToFitWidth = YES;
	[self.dateLabel setTextAlignment:NSTextAlignmentCenter];
	self.dateLabel.textColor = [UIColor blackColor];
	[self.thumbnail addSubview:self.dateLabel];
	
	self.contentView.clipsToBounds=YES;
	
}

-(void)layoutSubviews{
	self.thumbnail.frame=self.bounds;
}



@end
