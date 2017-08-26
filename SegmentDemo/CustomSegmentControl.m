//
//  AppDelegate.m
//  SegmentDemo
//
//  Created by aiijim on 2017/8/25.
//  Copyright © 2017年 aiijim. All rights reserved.
//

#import "CustomSegmentControl.h"

#define BASE_BUTTON_TAG 6000

@interface CustomSegmentControl()

@property (nonatomic, strong) NSArray<UIButton*>* subBtnArr;
@property (nonatomic, strong) UIImageView* slide;
@property (nonatomic, assign) BOOL needMove;

@end

@implementation CustomSegmentControl

- (instancetype) initWithCoder:(NSCoder *)aDecoder
{
    NSAssert(false, @"Don't invoke initWithCoder instead of initWithItems");
    return [self initWithItems:@[]];
}

- (instancetype) initWithFrame:(CGRect)frame
{
    NSAssert(false, @"Don't invoke initWithFrame instead of initWithItems");
    return [self initWithItems:@[]];
}

- (id)initWithItems:(NSArray *)items
{
    self = [super initWithFrame:CGRectZero];
    if (self)
    {
        _items = items;
        _selectedIndex = NSIntegerMax;
        _txtColor = [UIColor colorWithRed:0x33/255.0f green:0x33/255.0f blue:0x33/255.0f alpha:1.0];
        _selectedColor = [UIColor blueColor];
        _titleFont = [UIFont systemFontOfSize:17.0f];
        UIImage *image = [UIImage imageNamed:@"mySegCtrl-normal-bkgd"];
        _normalImage = [image resizableImageWithCapInsets:UIEdgeInsetsMake(2, 20, 2, 20) resizingMode:UIImageResizingModeStretch];
        image = [UIImage imageNamed:@"mySegCtrl-selected-bkgd"];
        _selectedImage = [image resizableImageWithCapInsets:UIEdgeInsetsMake(2, 20, 2, 20) resizingMode:UIImageResizingModeStretch];
        
        [self setBackgroundImage:_normalImage forState:UIControlStateNormal];
        [self buildSubviews:items];
    }
    return self;
}

- (void) layoutSubviews
{
    [super layoutSubviews];
    [self resetButtonPosition];
}

- (void) touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    CGPoint pt = [[[event allTouches] anyObject] locationInView:self];
    
    self.needMove = CGRectContainsPoint(self.slide.bounds, [self convertPoint:pt toView:self.slide]);
}

- (void) touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    if (self.needMove)
    {
        CGPoint currentPt = [[[event allTouches] anyObject] locationInView:self];
        CGPoint previousPt = [[[event allTouches] anyObject] previousLocationInView:self];
        CGFloat deltaX = currentPt.x - previousPt.x;
        if (self.slide.frame.origin.x + deltaX <= 0)
        {
            self.slide.frame = CGRectMake(0, 0, self.slide.bounds.size.width, self.slide.bounds.size.height);
        }
        else if(self.slide.frame.origin.x + deltaX >= self.bounds.size.width - self.slide.bounds.size.width)
        {
            self.slide.frame = CGRectMake(self.bounds.size.width - self.slide.bounds.size.width, 0, self.slide.bounds.size.width, self.slide.bounds.size.height);
        }
        else
        {
            self.slide.frame = CGRectMake(self.slide.frame.origin.x + deltaX, 0, self.slide.bounds.size.width, self.slide.bounds.size.height);
        }
    }
}

- (void) touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    CGPoint pt = [[[event allTouches] anyObject] locationInView:self];
    for (UIButton* btn in self.subBtnArr)
    {
        CGPoint realPt = [self convertPoint:pt toView:btn];
        BOOL inside = CGRectContainsPoint(btn.bounds, realPt);
        if(inside)
        {
            [self btnClicked:btn];
            self.needMove = NO;
            break;
        }
    }
    
    if (self.needMove)
    {
        for (UIButton* btn in self.subBtnArr)
        {
            if(CGRectContainsPoint(btn.frame, self.slide.center))
            {
                [self btnClicked:btn];
                break;
            }
        }
        self.needMove = NO;
    }
}

- (void) setTxtColor:(UIColor *)txtColor
{
    if(_txtColor == txtColor)
        return;
    
    _txtColor = txtColor;
    for (int i = 0; i < [self.subBtnArr count]; i++)
    {
        if (i != self.selectedIndex)
        {
            [self.subBtnArr[i] setTitleColor:txtColor forState:UIControlStateNormal];
        }
    }
}

- (void) setSelectedColor:(UIColor *)selectedColor
{
    if(_selectedColor == selectedColor)
        return;
    
    _selectedColor = selectedColor;
    if (self.selectedIndex < [self.subBtnArr count])
    {
        [self.subBtnArr[self.selectedIndex] setTitleColor:selectedColor forState:UIControlStateNormal];
    }
    
}

- (void) setSelectedIndex:(NSInteger)selectedIndex
{
    if(_selectedIndex == selectedIndex)
        return;
    
    if (selectedIndex >= [self.subBtnArr count])
        return;
    
    _selectedIndex = selectedIndex;
    for (int i = 0; i < [self.subBtnArr count]; i++)
    {
        if (i == selectedIndex)
        {
            if (!self.slide)
            {
                self.slide = [[UIImageView alloc] initWithFrame:self.subBtnArr[i].frame];
                self.slide.image = self.selectedImage;
                [self insertSubview:self.slide belowSubview:self.subBtnArr[0]];
                [self.subBtnArr[i] setTitleColor:self.selectedColor forState:UIControlStateNormal];
            }
            else
            {
                [UIView animateWithDuration:0.15 animations:^{
                    self.slide.frame = self.subBtnArr[i].frame;
                    [self.subBtnArr[i] setTitleColor:self.selectedColor forState:UIControlStateNormal];
                }];
            }
        }
        else
        {
            [self.subBtnArr[i] setTitleColor:self.txtColor forState:UIControlStateNormal];
        }
    }
}

- (void) setTitleFont:(UIFont *)titleFont
{
    if (_titleFont == titleFont)
        return;
    
    _titleFont = titleFont;
    for (UIButton* btn in self.subBtnArr)
    {
        btn.titleLabel.font = titleFont;
    }
}

- (void) setSelectedImage:(UIImage *)selectedImage
{
    if (_selectedImage == selectedImage)
        return;
    
    _selectedImage = selectedImage;
    self.slide.image = selectedImage;
}

- (void) setNormalImage:(UIImage *)normalImage
{
    if (_normalImage == normalImage)
        return;
    
    _normalImage = normalImage;
    [self setBackgroundImage:_normalImage forState:UIControlStateNormal];
}

- (void) setItems:(NSArray<NSString *> *)items
{
    if ([_items isEqualToArray:items])
        return;
    
    _items = items;
    for (UIView* view in [self subviews])
    {
        [view removeFromSuperview];
    }
    
    [self buildSubviews:items];
    [self resetButtonPosition];
}

- (void) resetButtonPosition
{
    CGFloat width = self.bounds.size.width / [self.subBtnArr count];
    for (UIButton* btn in self.subBtnArr)
    {
        NSInteger index = btn.tag - BASE_BUTTON_TAG;
        btn.frame = CGRectMake(width*index, 0, width, self.bounds.size.height);
    }
    
    if (self.selectedIndex < [self.subBtnArr count])
    {
        self.slide.frame = self.subBtnArr[self.selectedIndex].frame;
    }
}

- (void) buildSubviews:(NSArray*) items
{
    NSMutableArray* subBtn = [NSMutableArray array];
    for (int i = 0; i< (int)[items count]; i++)
    {
        NSString* item = [items objectAtIndex:i];
        UIButton* buttton = [UIButton buttonWithType:UIButtonTypeCustom];
        buttton.tag = BASE_BUTTON_TAG + i;
        buttton.titleLabel.font = self.titleFont;
        [buttton setTitle:item forState:UIControlStateNormal];
        [buttton setTitleColor:self.txtColor forState:UIControlStateNormal];
        buttton.userInteractionEnabled = NO;
        [self addSubview:buttton];
        [subBtn addObject:buttton];
    }
    self.subBtnArr = [subBtn copy];
}

- (void) btnClicked:(id) sender
{
    NSInteger index = [(UIButton*)sender tag] - BASE_BUTTON_TAG;
    if (self.selectedIndex == index)
    {
        self.slide.frame = [(UIButton*)sender frame];
        return;
    }
    
    self.selectedIndex = index;
    [self sendActionsForControlEvents:UIControlEventValueChanged];
}

- (NSString*) titleOfSegmentIndex:(NSInteger)index
{
    if (index >= [self.subBtnArr count])
        return @"";
    
    return self.subBtnArr[index].titleLabel.text;
}

@end
