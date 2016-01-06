//
//  Mole.m
//  04-mole
//
//  Created by qingyun on 16/1/3.
//  Copyright © 2016年 qingyun. All rights reserved.
//

#import "Mole.h"

@interface Mole ()
{
    BOOL _isThuped;
}
@property (nonatomic, strong) SKAction *laughAction;
@property (nonatomic, strong) SKAction *thumpAction;
@end

@implementation Mole

+ (instancetype)moleWithTexture:(SKTexture *)texture laughArr:(NSArray *)laughArr andThumpArr:(NSArray *)thumpArr
{
    Mole *mole = [Mole spriteNodeWithTexture:texture];
    mole.zPosition = 1;
    mole.name = @"mole";
    
    SKAction *laugh = [SKAction animateWithNormalTextures:laughArr timePerFrame:0.1f];
    SKAction *laughSound = [SKAction playSoundFileNamed:@"laugh.caf" waitForCompletion:NO];
    mole.laughAction = [SKAction group:@[laugh, laughSound]];
    
    
    SKAction *thump = [SKAction animateWithNormalTextures:thumpArr timePerFrame:0.1f];
    SKAction *thumpSound = [SKAction playSoundFileNamed:@"ow.caf" waitForCompletion:NO];
    mole.thumpAction = [SKAction group:@[thump, thumpSound]];
    
    return mole;
}

#pragma mark - 鼹鼠动画
- (void)moveUp
{
    if ([self hasActions]) return;
    // 1. 鼹鼠出来
    SKAction *moveUp = [SKAction moveToY:_hiddenY + self.size.height duration:0.2f];
    moveUp.timingMode = SKActionTimingEaseOut;
    // 2. 停止0.5秒
    SKAction *wait = [SKAction waitForDuration:0.5];
    
    // 3. 鼹鼠下去
    SKAction *moveDown = [SKAction moveToY:_hiddenY duration:0.2];
    moveDown.timingMode = SKActionTimingEaseIn;
    SKAction *sequence = [SKAction sequence:@[moveUp, self.laughAction, wait, moveDown]];
    [self runAction:sequence];
}

#pragma mark - 鼹鼠被打了
- (void)beThumped
{
    if (_isThuped) return;
    
    _isThuped = YES;
    
    // 1. 移除之前所有动画
    [self removeAllActions];
    
    // 2. 创建新的动画
    SKAction *moveDown = [SKAction moveToY:_hiddenY duration:0.2];
    moveDown.timingMode = SKActionTimingEaseIn;
    
    SKAction *sequence = [SKAction sequence:@[self.thumpAction, moveDown]];
    [self runAction:sequence completion:^{
        _isThuped = NO;
    }];
}

@end
