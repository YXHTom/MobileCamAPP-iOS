//
//  PanCamViewController.m
//  panCamTest
//
//  Created by ZJ on 2016/10/18.
//  Copyright © 2016年 ZJ. All rights reserved.
//

#import "PanCamViewController.h"

static const NSInteger HJGLKDefaultFramesPerSecond = 30;

@interface PanCamViewController () <GLKViewDelegate>

@property (nonatomic, strong) GLKView       *glkView;
@property (nonatomic, strong) CADisplayLink *displayLink;

@end

@implementation PanCamViewController

- (void)dealloc {
    self.paused = YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.glkView = [[GLKView alloc] initWithFrame:self.view.frame];
    self.glkView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    self.glkView.delegate = self;
    [self.view addSubview:self.glkView];
    NSLog(@"----> view: %@", self.glkView);
    
    self.preferredFramesPerSecond = HJGLKDefaultFramesPerSecond;
    self.displayLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(drawView)];
    self.displayLink.paused = YES;
    self.displayLink.frameInterval = MAX(1, 60.0f / _preferredFramesPerSecond);
    [self.displayLink addToRunLoop:[NSRunLoop currentRunLoop] forMode:NSRunLoopCommonModes];
}

#pragma mark -
- (void)setPreferredFramesPerSecond:(NSInteger)preferredFramesPerSecond {
    _preferredFramesPerSecond = preferredFramesPerSecond;
    self.displayLink.frameInterval = MAX(1, 60.0f / _preferredFramesPerSecond);
}

- (BOOL)isPaused {
    return self.displayLink.paused;
}

- (void)setPaused:(BOOL)paused {
    self.displayLink.paused = paused;
}

- (void)drawView {
    if (!self.paused) {
        [self update];
        [self.glkView display];
    }
}

- (void)update {
    
}

- (void)glkView:(GLKView *)view drawInRect:(CGRect)rect {
    
}

- (void)startGLKAnimation {
    self.displayLink.paused = NO;
}

- (void)stopGLKAnimation {
    self.displayLink.paused = YES;
    [self.displayLink invalidate];
    self.displayLink = nil;
}

@end
