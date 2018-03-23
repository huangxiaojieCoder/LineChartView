//
//  ViewController.m
//  LineChartView
//
//  Created by yiai_xiaojie on 2018/3/12.
//  Copyright © 2018年 yiai_xiaojie. All rights reserved.
//

#import "ViewController.h"
#import "OTLineChartView.h"
#import "OTBallonMarker.h"

@interface ViewController ()

/** <#name#> */
@property (nonatomic, strong) OTLineChartView *lineChartView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    OTLineChartView *lineChartView = [[OTLineChartView alloc] initWithFrame:CGRectMake(0, 100, [UIScreen mainScreen].bounds.size.width, 400)];
    
    lineChartView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:lineChartView];

    lineChartView.marginX = 50;
    lineChartView.marginY = 50;
    lineChartView.labelCountX = 6;
    lineChartView.labelCountY = 5;
    lineChartView.maxY = 70;

    
    
    OTBallonMarker *ballonMarker = [[OTBallonMarker alloc] init];
    ballonMarker.charViewSize = CGSizeMake( [UIScreen mainScreen].bounds.size.width - 100, 400 - 100);
    ballonMarker.marginY = 50;
    ballonMarker.marginX = 50;
    lineChartView.markerImage = ballonMarker;
    
    
    NSMutableArray *datas = [NSMutableArray array];
    
    OTChatData *chatData = [[OTChatData alloc] init];
    chatData.xValue = 1;
    chatData.yValue = 20;
    chatData.markerText = @"20";
    [datas addObject:chatData];
    
    OTChatData *chatData2 = [[OTChatData alloc] init];
    chatData2.xValue = 2;
    chatData2.yValue = 50;
    chatData2.markerText = @"50";
    [datas addObject:chatData2];
    
    OTChatData *chatData3 = [[OTChatData alloc] init];
    chatData3.xValue = 3;
    chatData3.yValue = 70;
    chatData3.markerText = @"70";
    [datas addObject:chatData3];
    
    OTChatData *chatData4 = [[OTChatData alloc] init];
    chatData4.xValue = 4;
    chatData4.yValue = 10;
    chatData4.markerText = @"10";
    [datas addObject:chatData4];
    
    OTChatData *chatData5 = [[OTChatData alloc] init];
    chatData5.xValue = 5;
    chatData5.yValue = 40;
    chatData5.markerText = @"40";
    [datas addObject:chatData5];
    
    lineChartView.datas = datas;
    [lineChartView refreshData];
    
    lineChartView.backgroundColor = [UIColor whiteColor];
    
    self.lineChartView = lineChartView;
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{

}
- (IBAction)clickMe:(id)sender {
    
    NSMutableArray *arryM = [NSMutableArray array];
    NSInteger count = arc4random_uniform(3) + 2;
    
    for (NSInteger i = 0; i < count; i ++) {
        OTChatData *chatData = [[OTChatData alloc] init];
        chatData.xValue = i;
        chatData.yValue = arc4random_uniform(70);
        chatData.markerText = [NSString stringWithFormat:@"%.0f",chatData.yValue];
        [arryM addObject:chatData];
    }

    self.lineChartView.datas = arryM;
    [self.lineChartView refreshData];
}


@end
