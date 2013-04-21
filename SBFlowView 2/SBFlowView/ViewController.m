//
//  ViewController.m
//  SBFlowView
//
//  Created by JK.Peng on 13-1-30.
//  Copyright (c) 2013年 njut. All rights reserved.
//

#import "ViewController.h"
#import "SBPageFlowView.h"

@interface ViewController ()<SBPageFlowViewDelegate,SBPageFlowViewDataSource>{
    NSArray *_imageArray;
    
    NSInteger    _currentPage;
    
    SBPageFlowView  *_flowView;
}

@end

@implementation ViewController

- (void)dealloc{
    [_imageArray release], _imageArray = nil;
    [_flowView release], _flowView = nil;
    [super dealloc];
}

- (id)init {
    self = [super init];
    if (self) {
    }
    
    return self;
}


- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    _imageArray = [[NSArray alloc] initWithObjects:@"1.jpg",@"2.jpg",@"3.jpg",@"4.jpg",@"5.jpg",@"6.jpg",nil];
    
    _currentPage = 0;
        
    _flowView = [[SBPageFlowView alloc] initWithFrame:CGRectMake(0, 20, self.view.frame.size.width, self.view.frame.size.height)];
    _flowView.delegate = self;
    _flowView.dataSource = self;
    _flowView.minimumPageAlpha = 0.6;
    _flowView.minimumPageScale = 0.96;
    _flowView.defaultImageView = [[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"1.jpg"]] autorelease];
    [self.view addSubview:_flowView];
    [_flowView reloadData];
    
    [NSTimer scheduledTimerWithTimeInterval:0.8 target:self selector:@selector(scropTo:) userInfo:nil repeats:YES];
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"background.jpg"]] ;
    NSString* path = [[NSBundle mainBundle] pathForResource:@"music" ofType:@"mp3"];
    NSData* data = [NSData dataWithContentsOfFile:path];
    self.player = [[AVAudioPlayer alloc] initWithData:data error:nil];
    [self.player play];
    
}

- (void)scropTo:(id)sender{
    [_flowView scrollToNextPage];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}


#pragma mark - PagedFlowView Datasource

- (NSInteger)numberOfPagesInFlowView:(SBPageFlowView *)flowView{
    return [_imageArray count];
}

- (CGSize)sizeForPageInFlowView:(SBPageFlowView *)flowView;{
    return CGSizeMake(220, 265);
}

- (UIView *)flowView:(SBPageFlowView *)flowView cellForPageAtIndex:(NSInteger)index{
    UIImageView *imageView = (UIImageView *)[flowView dequeueReusableCell];
    if (!imageView) {
        imageView = [[[UIImageView alloc] init] autorelease];
        imageView.layer.masksToBounds = YES;
    }
    
    imageView.image = [UIImage imageNamed:[_imageArray objectAtIndex:index]];
    return imageView;
}

#pragma mark - PagedFlowView Delegate
- (void)didReloadData:(UIView *)cell cellForPageAtIndex:(NSInteger)index
{
    UIImageView *imageView = (UIImageView *)cell;
    imageView.image = [UIImage imageNamed:[_imageArray objectAtIndex:index]];
}

- (void)didScrollToPage:(NSInteger)pageNumber inFlowView:(SBPageFlowView *)flowView {
    _currentPage = pageNumber;
}

@end
