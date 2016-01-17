//
//  ShakeViewController.m
//  I-22-QQ框架
//
//  Created by bininc on 16/1/14.
//  Copyright © 2016年 Bininc. All rights reserved.
//

#import "ShakeViewController.h"
#import <AVFoundation/AVFoundation.h>

@interface ShakeViewController () <AVAudioPlayerDelegate, UINavigationControllerDelegate>
{
    AVAudioPlayer * _audioPlayer;
    NSMutableArray * _musicArray;
    NSMutableDictionary * _infoDict;

    NSInteger _songIndex;
    BOOL _isPlay;
}

@property (weak, nonatomic) IBOutlet UIImageView *backGroundImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *infoLabel;
- (IBAction)buttonClicked:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet UIImageView *bgImageView;

@end

@implementation ShakeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self dataInit];
    
    [self loadMusic:_musicArray[_songIndex] type:@"mp3"];
    
    self.navigationController.delegate = self;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
     self.bgImageView.image = [UIImage imageNamed:@"music_bg.jpg"];
}

- (void)dataInit{

    _musicArray = [@[@"在他乡",
                     @"千古",
                     @"睡在我上铺的兄弟",
                     @"千里之外"] mutableCopy];
    _infoDict = [@{ @"千里之外":@"周杰伦&费玉清",
                    @"在他乡":@"水木年华",
                    @"睡在我上铺的兄弟":@"老狼",
                    @"千古":@"许嵩"} mutableCopy];
//    srand(time(0));
//    _songIndex = rand() % 4;
    _songIndex = arc4random() % 4;
    //NSLog(@"%d",_songIndex);
    _isPlay = NO;
}


/*加载音乐和音乐信息*/
-(void)loadMusic:(NSString*)name type:(NSString*)type {
    //No.1
    //开始写代码，播放器预加载音乐，默认音量0.5
    
    NSURL *path = [[NSBundle mainBundle] URLForResource:name withExtension:type];
    
    if (_audioPlayer != nil) {
        [_audioPlayer stop];
        _audioPlayer = nil;
    }
    
    NSError *error;
    _audioPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:path error:&error];
    _audioPlayer.delegate = self;
    [_audioPlayer prepareToPlay];
    [_audioPlayer play];
    if (error == nil)
        _isPlay = YES;
    //end_code
    _nameLabel.text = name;
    _infoLabel.text = _infoDict[name];
    
    //切换歌曲时添加动画效果
    CATransition *transition = [CATransition animation];
    transition.duration = 1.0f;
    //transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
    transition.type = kCATransitionReveal;
    [_backGroundImageView.layer addAnimation:transition forKey:nil];
    _backGroundImageView.image = [UIImage imageNamed:[name stringByAppendingString:@".jpg"]];
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}


/*播放按钮的点击事件*/
- (IBAction)buttonClicked:(UIButton *)sender {
    if (_isPlay) {
        [_audioPlayer pause];
        [sender setTitle:@"播放" forState:UIControlStateNormal];
        _isPlay = NO;
    } else {
        [_audioPlayer play];
        [sender setTitle:@"暂停" forState:UIControlStateNormal];
        _isPlay = YES;
    }
}

#pragma mark - AVAudioPlayerDelegate

- (void)audioPlayerDidFinishPlaying:(AVAudioPlayer *)player successfully:(BOOL)flag {

    [self updatePlayerSetting];
}

- (void)updatePlayerSetting {
    
    _songIndex++;
    if(_songIndex == _musicArray.count) {
        _songIndex = 0;
    }
    
    [self loadMusic:_musicArray[_songIndex] type:@"mp3"];
    
    if (_isPlay) {
        [_audioPlayer play];
    }
}

#pragma mark - Motion Action
//No.2
//开始写代码，通过运动事件MotionEvent实现摇一摇切歌
- (void) motionEnded:(UIEventSubtype)motion withEvent:(UIEvent *)event
{
    [self updatePlayerSetting];
}

//end_code


- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    if (viewController == self) {
        navigationController.navigationBar.alpha = 0.5;
        navigationController.navigationBar.translucent = YES;
    }
    else
    {
        navigationController.navigationBar.alpha = 1;
        navigationController.navigationBar.translucent = NO;
    }
}

@end
