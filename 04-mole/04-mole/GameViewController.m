//
//  GameViewController.m
//  04-mole
//
//  Created by qingyun on 16/1/3.
//  Copyright (c) 2016年 qingyun. All rights reserved.
//

#import "GameViewController.h"
#import "GameScene.h"
#import "Common.h"
#import "MyScene.h"

@implementation SKScene (Unarchive)

+ (instancetype)unarchiveFromFile:(NSString *)file {
    /* Retrieve scene file path from the application bundle */
    NSString *nodePath = [[NSBundle mainBundle] pathForResource:file ofType:@"sks"];
    /* Unarchive the file to an SKScene object */
    NSData *data = [NSData dataWithContentsOfFile:nodePath
                                          options:NSDataReadingMappedIfSafe
                                            error:nil];
    NSKeyedUnarchiver *arch = [[NSKeyedUnarchiver alloc] initForReadingWithData:data];
    [arch setClass:self forClassName:@"SKScene"];
    SKScene *scene = [arch decodeObjectForKey:NSKeyedArchiveRootObjectKey];
    [arch finishDecoding];
    
    return scene;
}

@end

@implementation GameViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    
}

- (void)viewWillLayoutSubviews
{
    [super viewWillLayoutSubviews];
    
    // Configure the view.
    SKView * skView = (SKView *)self.view;
    if (!skView.scene) {
        
        // 加载游戏资源
        [GameScene loadSceneAssetsWithCompletionHandler:^{
            // 加载完成显示场景
            // 关闭提示框
            skView.ignoresSiblingOrder = YES;
            
            // Create and configure the scene.
            SKScene *scene = nil;
            if (IS_IPAD) {
                scene = [[MyScene alloc] initWithSize:self.view.bounds.size];
            } else {
                scene = [[GameScene alloc] initWithSize:self.view.bounds.size];
            }
            scene.scaleMode = SKSceneScaleModeAspectFill;
            
            // Present the scene.
            [skView presentScene:scene];
        }];
        
        // 下面可以添加一个提示框，正在加载请稍后
        skView.showsFPS = YES;
        skView.showsNodeCount = YES;
        
    }
}

- (BOOL)shouldAutorotate
{
    return YES;
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations
{
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        return UIInterfaceOrientationMaskAllButUpsideDown;
    } else {
        return UIInterfaceOrientationMaskAll;
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

- (BOOL)prefersStatusBarHidden {
    return YES;
}

@end
