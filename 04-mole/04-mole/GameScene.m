//
//  GameScene.m
//  04-mole
//
//  Created by qingyun on 16/1/3.
//  Copyright (c) 2016年 qingyun. All rights reserved.
//

#import "GameScene.h"
#import "SKTextureAtlas+JY.h"
#import "Common.h"

#define kFontSize  (IS_IPAD ? 40 : 20)

@interface GameScene ()
{
    
    SKLabelNode *_scoreLabel;
    NSInteger _score;
    
    SKLabelNode *_timerLabel;
    
    NSDate *_startTime;
}
@end

static long step;

@implementation GameScene

static SKTexture *sSharedDirtTexture = nil;
static SKTexture *sSharedUpperTexture = nil;
static SKTexture *sSharedLowerTexture = nil;
static SKTexture *sSharedMoleTexture = nil;
static NSArray   *sSharedMoleLaughArr = nil;
static NSArray   *sSharedMoleThumpArr = nil;

#pragma mark 设置界面UI
- (void)setupUI
{
    CGPoint center = CGPointMake(self.size.width * 0.5, self.size.height * 0.5);
    // 1. 加载背景图片
    // 设置节点
    SKSpriteNode *dirt = [SKSpriteNode spriteNodeWithTexture:sSharedDirtTexture];
    dirt.position = center;
    [dirt setScale:2.0f];
    [self addChild:dirt];
    
    // 2. 加载上部的小草
    // 设置节点
    SKSpriteNode *upper = [SKSpriteNode spriteNodeWithTexture:sSharedUpperTexture];
    upper.anchorPoint = CGPointMake(0.5, 0);
    upper.position = center;
//    upper.zPosition = 1;
    
    [self addChild:upper];
    
    // 3. 加载下部的小草
    // 设置节点
    SKSpriteNode *lower = [SKSpriteNode spriteNodeWithTexture:sSharedLowerTexture];
    lower.anchorPoint = CGPointMake(0.5, 1);
    lower.position = center;
    lower.zPosition = 2;
    [self addChild:lower];
    
    // 4. 加载分数
    SKLabelNode *scoreLabel = [SKLabelNode labelNodeWithFontNamed:@"Chalkduster"];
    NSString *score = NSLocalizedString(@"Score", nil);
    NSString *all = [NSString stringWithFormat:@"%@: 0", score];
    scoreLabel.text = all;
    scoreLabel.position = CGPointMake(20, 20);
    scoreLabel.fontSize = kFontSize;
    scoreLabel.horizontalAlignmentMode = SKLabelHorizontalAlignmentModeLeft;
    scoreLabel.zPosition = 3;
    _scoreLabel = scoreLabel;
    [self addChild:scoreLabel];
    
    // 5. 加载时间界面
    SKLabelNode *timerLabel = [SKLabelNode labelNodeWithFontNamed:@"Chalkduster"];
    timerLabel.text = @"00:00:00";
    timerLabel.position = CGPointMake(self.size.width - 20, self.size.height - kFontSize - 20);
    timerLabel.fontSize = kFontSize;
    timerLabel.horizontalAlignmentMode = SKLabelHorizontalAlignmentModeRight;
    timerLabel.zPosition = 3;
    _timerLabel = timerLabel;
    [self addChild:timerLabel];
}

#pragma mark - 加载鼹鼠到数组
- (void)loadMoles
{
    NSMutableArray *tem = [NSMutableArray array];
    for (int i = 0; i < 3; i++) {
        Mole *sp = [Mole moleWithTexture:sSharedMoleTexture laughArr:sSharedMoleLaughArr andThumpArr:sSharedMoleThumpArr];
        [tem addObject:sp];
    }
    _moles = tem;
}

#pragma mark - 设置鼹鼠的位置
- (void)setupMoles
{
    CGFloat offsetx = 155;
    CGPoint startPoint = CGPointMake(self.size.width * 0.5 - offsetx, self.size.height * 0.5 - 80);
    [_moles enumerateObjectsUsingBlock:^(Mole  *mole, NSUInteger idx, BOOL * stop) {
        mole.position = CGPointMake(startPoint.x + offsetx * idx , startPoint.y);
        mole.hiddenY = startPoint.y;
        [self addChild:mole];
    }];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    CGPoint location = [touch locationInNode:self];
    
    SKNode *node = [self nodeAtPoint:location];
    if ([node.name isEqualToString:@"mole"]) {
        Mole *mole = (Mole *)node;
        [mole beThumped];
        _score += 10;
        NSString *score = NSLocalizedString(@"Score", nil);
        _scoreLabel.text = [NSString stringWithFormat:@"%@: %d",score, _score];
    }
}

- (instancetype)initWithSize:(CGSize)size
{
    if (self = [super initWithSize:size]) {
        [self setupUI];
        [self loadMoles];
        [self setupMoles];
        _startTime = [NSDate date];
    }
    return self;
}

- (void)update:(NSTimeInterval)currentTime
{
    step ++;
    
    NSInteger dt = [[NSDate date] timeIntervalSinceDate:_startTime];
   _timerLabel.text = [NSString stringWithFormat:@"%02d:%02d:%02d", dt / 3600, (dt % 3600) / 60, dt % 60];
    
    NSInteger seed = _score / 50;
    seed = (seed > 15) ? 15 : seed;
    
    if (step % (20 - seed) == 0) {
        NSInteger index = arc4random_uniform(3);
        Mole *mole = _moles[index];
        [mole moveUp];
    }
}

#pragma mark - 加载材质
+ (void)loadSceneAssets
{
    // 1. 加载背景
    SKTextureAtlas *bgAtlas = [SKTextureAtlas atlasWithName:@"background"];
    sSharedDirtTexture = [bgAtlas textureNamed:@"bg_dirt"];
    
    // 2. 加载上部图片
    SKTextureAtlas *foreAtlas = [SKTextureAtlas atlasWithName:@"foreground"];
    sSharedUpperTexture = [foreAtlas textureNamed:@"grass_upper"];
    
    // 3. 加载下部图片
    sSharedLowerTexture = [foreAtlas textureNamed:@"grass_lower"];
    
    // 4. 加载鼹鼠
    SKTextureAtlas *atlas = [SKTextureAtlas atlasWithName:@"sprites"];
    sSharedMoleTexture = [atlas textureNamed:@"mole_1"];
    
    // 5. 加载鼹鼠笑数组
    sSharedMoleLaughArr = @[[atlas textureNamed:@"mole_laugh1"],
                            [atlas textureNamed:@"mole_laugh2"],
                            [atlas textureNamed:@"mole_laugh3"]];
    
    // 6. 加载鼹鼠挨打数组
    sSharedMoleThumpArr = @[[atlas textureNamed:@"mole_thump1"],
                            [atlas textureNamed:@"mole_thump2"],
                            [atlas textureNamed:@"mole_thump3"],
                            [atlas textureNamed:@"mole_thump4"]];
}

+ (void)loadSceneAssetsWithCompletionHandler:(AssetLoadCompletionHandler)callback
{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [self loadSceneAssets];
        
        if (callback) {
            dispatch_async(dispatch_get_main_queue(), ^{
                callback();
            });
        }
    });
}

@end
