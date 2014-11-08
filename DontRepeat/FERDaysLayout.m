//
//  FERDaysLayout.m
//  DontRepeat
//
//  Created by Fernando Garcia Corrochano on 30/09/14.
//  Copyright (c) 2014 FernandoGarciaCorrochano. All rights reserved.
//

#import "FERDaysLayout.h"

@implementation FERDaysLayout

- (instancetype)init{
	self = [super init];
	if (self) {
		CGSize iOSDeviceScreenSize = [[UIScreen mainScreen] bounds].size;
		self.scrollDirection=UICollectionViewScrollDirectionHorizontal;
		if (iOSDeviceScreenSize.height != 480){
			self.itemSize=CGSizeMake(200	, 200);
			self.sectionInset=UIEdgeInsetsMake(20, 20, 20, 20);
		}else{
			self.itemSize=CGSizeMake(150, 150);
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
/*

-(NSArray *)layoutAttributesForElementsInRect:(CGRect)rect{
	NSArray *array=[super layoutAttributesForElementsInRect:rect];
	CGRect visibleRect;
	visibleRect.origin=self.collectionView.contentOffset;
	visibleRect.size =self.collectionView.bounds.size;
	
	for (UICollectionViewLayoutAttributes *attributes in array) {
		if (CGRectIntersectsRect(attributes.frame, rect)) {
			[self setCellAttibutes:attributes forVisibleRect:visibleRect];
		}
	}
	return array;
}

-(UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath{
	UICollectionViewLayoutAttributes *attributes =[super layoutAttributesForItemAtIndexPath:indexPath];
	CGRect visibleRect;
	visibleRect.origin=self.collectionView.contentOffset;
	visibleRect.size =self.collectionView.bounds.size;
	[self setCellAttibutes:attributes forVisibleRect:visibleRect];
	return attributes;
	
}

-(void)setCellAttibutes:(UICollectionViewLayoutAttributes *)attributes forVisibleRect:(CGRect)visibleRect{
	CGFloat distance=CGRectGetMidX(visibleRect)-attributes.center.x;
	CGFloat normalizedDistance=distance / (self.collectionView.frame.size.width/2.0);
	normalizedDistance=ABS(normalizedDistance);
	normalizedDistance=normalizedDistance>1?.5:normalizedDistance;
	attributes.transform3D=CATransform3DMakeScale(1-normalizedDistance, 1-normalizedDistance, -1);
}
*/

@end
