//
//  Mole.h
//  04-mole
//
//  Created by qingyun on 16/1/3.
//  Copyright © 2016年 qingyun. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

@interface Mole : SKSpriteNode

@property (nonatomic, assign) CGFloat hiddenY;

+ (instancetype)moleWithTexture:(SKTexture *)texture laughArr:(NSArray *)laughArr andThumpArr:(NSArray *)thumpArr;

/**
 *  鼹鼠动起来
 */
- (void)moveUp;

/**
 *  鼹鼠被打了
 */
- (void)beThumped;
@end
