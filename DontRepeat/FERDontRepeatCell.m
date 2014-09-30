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
			[self configuraPolaroid];
    }
    return self;
}

-(void)configura{
	
	self.contentView.backgroundColor=[UIColor clearColor];
	
	self.cell=[[UIView alloc]initWithFrame:self.bounds];
	self.cell.contentMode=UIViewContentModeScaleAspectFill;
	self.cell.backgroundColor=[[UIColor whiteColor] colorWithAlphaComponent:0.65f];
	self.cell.layer.cornerRadius=15.0;
	[self.cell setClipsToBounds:YES];
	[self.contentView addSubview:self.cell];

	self.thumbnail=[[UIImageView alloc]initWithFrame:CGRectMake(10, 25, self.bounds.size.width-20,self.bounds.size.height-50)];
	self.thumbnail.contentMode=UIViewContentModeScaleAspectFill;
	[self.thumbnail setClipsToBounds:YES];
	[self.cell addSubview:self.thumbnail];
	
	self.title=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, self.bounds.size.width, 25)];
	[self.title setFont:[UIFont fontWithName:@"Arial-BoldMT" size:24]];
	self.title.adjustsFontSizeToFitWidth = YES;
	[self.title setTextAlignment:NSTextAlignmentCenter];
	self.title.textColor = [UIColor blackColor];
	[self.cell addSubview:self.title];
	
	self.dateLabel=[[UILabel alloc]initWithFrame:CGRectMake(0, self.bounds.size.height-20, self.bounds.size.width, 20)];
	[self.dateLabel setFont:[UIFont fontWithName:@"Arial-BoldMT" size:24]];
	self.dateLabel.adjustsFontSizeToFitWidth = YES;
	[self.dateLabel setTextAlignment:NSTextAlignmentCenter];
	self.dateLabel.textColor = [UIColor blackColor];
	[self.cell addSubview:self.dateLabel];
	
	self.contentView.clipsToBounds=YES;
	
}

-(void)configuraPolaroid{
	
	self.contentView.backgroundColor=[UIColor clearColor];
	
	self.cell=[[UIView alloc]initWithFrame:self.bounds];
	self.cell.contentMode=UIViewContentModeScaleAspectFill;
	self.cell.backgroundColor=[UIColor whiteColor];
//	self.cell.layer.cornerRadius=15.0;
	[self.cell setClipsToBounds:YES];
	[self.contentView addSubview:self.cell];
	
	self.thumbnail=[[UIImageView alloc]initWithFrame:CGRectMake(10, 10, self.bounds.size.width-20,self.bounds.size.height-50)];
	self.thumbnail.contentMode=UIViewContentModeScaleAspectFill;
	[self.thumbnail setClipsToBounds:YES];
	[self.cell addSubview:self.thumbnail];
	
	self.title=[[UILabel alloc]initWithFrame:CGRectMake(0, self.thumbnail.bounds.size.height+10, self.bounds.size.width, 25)];
	[self.title setFont:[UIFont fontWithName:@"Bradley Hand" size:20]];
	self.title.adjustsFontSizeToFitWidth = YES;
	[self.title setTextAlignment:NSTextAlignmentCenter];
	self.title.textColor = [UIColor blackColor];
	[self.cell addSubview:self.title];
	
	self.dateLabel=[[UILabel alloc]initWithFrame:CGRectMake(0, self.thumbnail.bounds.size.height+35, self.bounds.size.width, 10)];
	[self.dateLabel setFont:[UIFont fontWithName:@"Bradley Hand" size:12]];
	self.dateLabel.adjustsFontSizeToFitWidth = YES;
	[self.dateLabel setTextAlignment:NSTextAlignmentCenter];
	self.dateLabel.textColor = [UIColor blackColor];
	[self.cell addSubview:self.dateLabel];
	
	self.contentView.clipsToBounds=YES;
	
}



-(void)layoutSubviews{
	self.cell.frame=self.bounds;
}



@end
