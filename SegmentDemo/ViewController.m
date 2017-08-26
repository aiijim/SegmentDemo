//
//  ViewController.m
//  SegmentDemo
//
//  Created by aiijim on 2017/8/25.
//  Copyright © 2017年 aiijim. All rights reserved.
//

#import "ViewController.h"
#import "CustomSegmentControl.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    CustomSegmentControl* segment = [[CustomSegmentControl alloc] initWithItems:@[@"日", @"周", @"月", @"年"]];
    segment.frame = CGRectMake(80, 100, 200, 40);
    [segment addTarget:self action:@selector(segmentValueChanged:) forControlEvents:UIControlEventValueChanged];
    segment.selectedIndex = 0;
    /*
     * 自定义背景图片
    segment.normalImage = [[UIImage imageNamed:@"mySegCtrl-normal-bkgd"] resizableImageWithCapInsets:UIEdgeInsetsMake(2, 20, 2, 20) resizingMode:UIImageResizingModeStretch];
    segment.selectedImage = [[UIImage imageNamed:@"mySegCtrl-selected-bkgd"] resizableImageWithCapInsets:UIEdgeInsetsMake(2, 20, 2, 20) resizingMode:UIImageResizingModeStretch];
     */
    [self.view addSubview:segment];
    
    segment = [[CustomSegmentControl alloc] initWithItems:@[@"资料库", @"更新"]];
    segment.frame = CGRectMake(80, 200, 200, 40);
    segment.selectedIndex = 0;
    [self.view addSubview:segment];
}

- (void) segmentValueChanged:(id) segmentControl
{
    if ([segmentControl isKindOfClass:[CustomSegmentControl class]])
    {
        CustomSegmentControl* segment = (CustomSegmentControl*)segmentControl;
        NSLog(@"selected:: %@", [segment titleOfSegmentIndex:segment.selectedIndex]);
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
