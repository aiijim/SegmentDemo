//
//  AppDelegate.m
//  SegmentDemo
//
//  Created by aiijim on 2017/8/25.
//  Copyright © 2017年 aiijim. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomSegmentControl : UIButton

@property (nonatomic, assign) NSInteger selectedIndex;

@property (nonatomic, strong) UIColor* txtColor;

@property (nonatomic, strong) UIColor* selectedColor;

@property (nonatomic, strong) UIImage* selectedImage;

@property (nonatomic, strong) UIImage* normalImage;

@property (nonatomic, strong) UIFont* titleFont;

@property (nonatomic, strong) NSArray<NSString*> * items;

- (id)initWithItems:(NSArray<NSString*> *)items NS_DESIGNATED_INITIALIZER;

- (NSString*) titleOfSegmentIndex:(NSInteger)index;

@end
