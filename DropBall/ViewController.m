//
//  ViewController.m
//  DropBall
//
//  Created by student on 24/12/2015.
//  Copyright © 2015 dungdang. All rights reserved.
//

#import "ViewController.h"
#import <AudioToolbox/AudioToolbox.h>
#import <AVFoundation/AVFoundation.h>
@interface ViewController ()
@property(nonatomic,strong) AVAudioPlayer *backgroundMusic;
@end

@implementation ViewController
{
    UIImageView *ball;
    CGFloat balRaidus,x,y,vellocityY,accellerateY,maxHeight;
    NSTimer *timer;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"background.jpg"]];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    [self addBall];
    timer = [NSTimer scheduledTimerWithTimeInterval:0.016
                                             target:self
                                           selector:@selector(dropBall)
                                           userInfo:nil
                                            repeats:true];
    [self onMusic];
}

- (void)addBall{
    CGSize mainViewSize= self.view.bounds.size;
    ball = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"basketball.png"]];
    balRaidus= 40.0;
    x= mainViewSize.width *0.5;
    y= balRaidus+60;
    vellocityY= 3.0;
    accellerateY= 1.6;
    CGFloat statusNavigationBarHeight= [UIApplication sharedApplication].statusBarFrame.size.height +self.navigationController.navigationBar.bounds.size.height;
    maxHeight = mainViewSize.height - balRaidus- statusNavigationBarHeight;
    ball.center = CGPointMake(x, y);
    [self.view addSubview:ball];
    
}


-(void)dropBall{
    vellocityY += accellerateY;
    y += vellocityY;
    if (y>maxHeight) {
        vellocityY=-vellocityY*0.88;
        y=maxHeight;
    }
    ball.center = CGPointMake(x, y);
}
-(void)onMusic{
    NSString *soundFilPath = [[NSBundle mainBundle] pathForResource:@"basketballdrop" ofType:@"mp3"];
    NSURL *soundFileURL = [NSURL fileURLWithPath:soundFilPath];
    self.backgroundMusic = [[AVAudioPlayer alloc] initWithContentsOfURL:soundFileURL error:nil];
    self.backgroundMusic.numberOfLoops = 0;
    self.backgroundMusic.currentTime = 0;
    [self.backgroundMusic play];}
@end
