//
//  GameScene.h
//  04-mole
//

//  Copyright (c) 2016年 qingyun. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>
#import "Mole.h"

typedef void(^AssetLoadCompletionHandler)();

@interface GameScene : SKScene

@property (nonatomic, strong) NSArray *moles;

/**
 *  统一加载游戏资源
 *
 *  @param callback 回调
 */
+ (void)loadSceneAssetsWithCompletionHandler:(AssetLoadCompletionHandler)callback;

/**
 *  设置鼹鼠基本位置
 */
- (void)setupMoles;

@end
