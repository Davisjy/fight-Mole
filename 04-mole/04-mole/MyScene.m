//
//  MyScene.m
//  04-mole
//
//  Created by qingyun on 16/1/3.
//  Copyright © 2016年 qingyun. All rights reserved.
//

#import "MyScene.h"

@implementation MyScene

- (void)setupMoles
{
    CGFloat offsetx = 310;
    CGPoint startPoint = CGPointMake(self.size.width * 0.5 - offsetx, self.size.height * 0.5 - 150);
    [self.moles enumerateObjectsUsingBlock:^(Mole  *mole, NSUInteger idx, BOOL * stop) {
        mole.position = CGPointMake(startPoint.x + offsetx * idx , startPoint.y);
        mole.hiddenY = startPoint.y;
        [self addChild:mole];
    }];
}

@end
