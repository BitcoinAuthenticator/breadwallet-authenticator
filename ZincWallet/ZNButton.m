//
//  ZNButton.m
//  ZincWallet
//
//  Created by Aaron Voisine on 6/14/13.
//  Copyright (c) 2013 zinc. All rights reserved.
//

#import "ZNButton.h"

@implementation ZNButton

- (id)init
{
    if (! (self = [super init])) return nil;
    
    [self keepUpAppearances];
    
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    if (! (self = [super initWithCoder:aDecoder])) return nil;
    
    [self keepUpAppearances];
    
    return self;
}

- (id)initWithFrame:(CGRect)frame
{
    if (! (self = [super initWithFrame:frame])) return nil;

    [self keepUpAppearances];

    return self;
}

- (void)keepUpAppearances
{
    static UIImage *bg = nil, *pressed = nil, *disabled = nil;
    
    if (! bg) {
        bg = [[UIImage imageNamed:@"button-bg.png"]
              resizableImageWithCapInsets:UIEdgeInsetsMake(12.5, 3.5, 12.5, 3.5)];
    }
    if (! pressed) {
        pressed = [[UIImage imageNamed:@"button-bg-pressed.png"]
                   resizableImageWithCapInsets:UIEdgeInsetsMake(12.5, 3.5, 12.5, 3.5)];
    }
    if (! disabled) {
        disabled = [[UIImage imageNamed:@"button-bg-disabled.png"]
                    resizableImageWithCapInsets:UIEdgeInsetsMake(12.5, 3.5, 12.5, 3.5)];
    }
    
    [self setBackgroundImage:bg forState:UIControlStateNormal];
    [self setBackgroundImage:pressed forState:UIControlStateHighlighted];
    [self setBackgroundImage:disabled forState:UIControlStateDisabled];
    
    [self setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
    [self setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
    [self setTitleColor:[UIColor lightGrayColor] forState:UIControlStateDisabled];
    
    [self setTitleShadowColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self setTitleShadowColor:[UIColor lightGrayColor] forState:UIControlStateHighlighted];
    [self setTitleShadowColor:[UIColor whiteColor] forState:UIControlStateDisabled];
    
    self.titleLabel.font = [UIFont fontWithName:@"HelveticaNeue-Medium" size:15];
    self.titleLabel.shadowOffset = CGSizeMake(0.0, 1.0);
    
    self.titleLabel.adjustsFontSizeToFitWidth = YES;
    self.titleLabel.numberOfLines = 1;
    self.titleLabel.lineBreakMode = NSLineBreakByClipping;
    
    [self setTitleEdgeInsets:UIEdgeInsetsMake(0, 3, 0, 3)];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
