//
//  FERMomentLayout.m
//  DontRepeat
//
//  Created by Fernando Garcia Corrochano on 30/09/14.
//  Copyright (c) 2014 FernandoGarciaCorrochano. All rights reserved.
//

#import "FERMomentLayout.h"

@implementation FERMomentLayout

- (instancetype)init
{
	self = [super init];
	if (self) {
		CGSize iOSDeviceScreenSize = [[UIScreen mainScreen] bounds].size;
		self.scrollDirection=UICollectionViewScrollDirectionHorizontal;
		if (iOSDeviceScreenSize.height != 480){
			self.itemSize=CGSizeMake(200	, 200);
			self.sectionInset=UIEdgeInsetsMake(20, 20, 20, 20);
		}else{
			self.itemSize=CGSizeMake(100	, 100);
			self.sectionInset=UIEdgeInsetsMake(20, 20, 20, 20);
		}
		self.minimumLineSpacing=20;
		self.minimumInteritemSpacing=10;
	}
	return self;
}

-(BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds{
	return YES;
}

@end
