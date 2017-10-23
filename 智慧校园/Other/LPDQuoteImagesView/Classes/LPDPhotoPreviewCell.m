//
//  LPDPhotoPreviewCell.m
//  LPDQuoteSystemImagesController
//
//  Created by Assuner on 2016/12/18.
//  Copyright © 2016年 Assuner. All rights reserved.
//

#import "LPDPhotoPreviewCell.h"
#import "LPDAssetModel.h"
#import "UIView+HandyValue.h"
#import "LPDImageManager.h"
#import "LPDProgressView.h"

@interface LPDPhotoPreviewCell ()<UIGestureRecognizerDelegate,UIScrollViewDelegate> {
    CGFloat _aspectRatio;
}
@end

@implementation LPDPhotoPreviewCell

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor blackColor];
        _scrollView = [[UIScrollView alloc] init];
        _scrollView.frame = CGRectMake(10, 0, self.lpd_width - 20, self.lpd_height);
        _scrollView.bouncesZoom = YES;
        _scrollView.maximumZoomScale = 2.5;
        _scrollView.minimumZoomScale = 1.0;
        _scrollView.multipleTouchEnabled = YES;
        _scrollView.delegate = self;
        _scrollView.scrollsToTop = NO;
        _scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.showsVerticalScrollIndicator = NO;
        _scrollView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        _scrollView.delaysContentTouches = NO;
        _scrollView.canCancelContentTouches = YES;
        _scrollView.alwaysBounceVertical = NO;
        [self addSubview:_scrollView];
        
        _imageContainerView = [[UIView alloc] init];
        _imageContainerView.clipsToBounds = YES;
        _imageContainerView.contentMode = UIViewContentModeScaleAspectFill;
        [_scrollView addSubview:_imageContainerView];
        
        _imageView = [[UIImageView alloc] init];
        _imageView.backgroundColor = [UIColor colorWithWhite:1.000 alpha:0.500];
        _imageView.contentMode = UIViewContentModeScaleAspectFill;
        _imageView.clipsToBounds = YES;
        [_imageContainerView addSubview:_imageView];
        
        UITapGestureRecognizer *tap1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(singleTap:)];
        [self addGestureRecognizer:tap1];
        UITapGestureRecognizer *tap2 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(doubleTap:)];
        tap2.numberOfTapsRequired = 2;
        [tap1 requireGestureRecognizerToFail:tap2];
        [self addGestureRecognizer:tap2];
        
        [self configProgressView];
    }
    return self;
}


- (void)configProgressView {
    _progressView = [[LPDProgressView alloc] init];
    static CGFloat progressWH = 40;
    CGFloat progressX = (self.lpd_width - progressWH) / 2;
    CGFloat progressY = (self.lpd_height - progressWH) / 2;
    _progressView.frame = CGRectMake(progressX, progressY, progressWH, progressWH);
    _progressView.hidden = YES;
    [self addSubview:_progressView];
}

- (void)setModel:(LPDAssetModel *)model {
    _model = model;
    [_scrollView setZoomScale:1.0 animated:NO];
    [[LPDImageManager manager] getPhotoWithAsset:model.asset completion:^(UIImage *photo, NSDictionary *info, BOOL isDegraded) {
        self.imageView.image = photo;
        [self resizeSubviews];
        _progressView.hidden = YES;
        if (self.imageProgressUpdateBlock) {
            self.imageProgressUpdateBlock(1);
        }
    } progressHandler:^(double progress, NSError *error, BOOL *stop, NSDictionary *info) {
        _progressView.hidden = NO;
        [self bringSubviewToFront:_progressView];
        progress = progress > 0.02 ? progress : 0.02;;
        _progressView.progress = progress;
        if (self.imageProgressUpdateBlock) {
            self.imageProgressUpdateBlock(progress);
        }
    } networkAccessAllowed:YES];
}

- (void)recoverSubviews {
    [_scrollView setZoomScale:1.0 animated:NO];
    [self resizeSubviews];
}

- (void)resizeSubviews {
    _imageContainerView.lpd_origin = CGPointZero;
    _imageContainerView.lpd_width = self.scrollView.lpd_width;
    
    UIImage *image = _imageView.image;
    if (image.size.height / image.size.width > self.lpd_height / self.scrollView.lpd_width) {
        _imageContainerView.lpd_height = floor(image.size.height / (image.size.width / self.scrollView.lpd_width));
    } else {
        CGFloat height = image.size.height / image.size.width * self.scrollView.lpd_width;
        if (height < 1 || isnan(height)) height = self.lpd_height;
        height = floor(height);
        _imageContainerView.lpd_height = height;
        _imageContainerView.lpd_centerY = self.lpd_height / 2;
    }
    if (_imageContainerView.lpd_height > self.lpd_height && _imageContainerView.lpd_height - self.lpd_height <= 1) {
        _imageContainerView.lpd_height = self.lpd_height;
    }
    CGFloat contentSizeH = MAX(_imageContainerView.lpd_height, self.lpd_height);
    _scrollView.contentSize = CGSizeMake(self.scrollView.lpd_width, contentSizeH);
    [_scrollView scrollRectToVisible:self.bounds animated:NO];
    _scrollView.alwaysBounceVertical = _imageContainerView.lpd_height <= self.lpd_height ? NO : YES;
    _imageView.frame = _imageContainerView.bounds;
    
    
}



#pragma mark - UITapGestureRecognizer Event

- (void)doubleTap:(UITapGestureRecognizer *)tap {
    if (_scrollView.zoomScale > 1.0) {
        _scrollView.contentInset = UIEdgeInsetsZero;
        [_scrollView setZoomScale:1.0 animated:YES];
    } else {
        CGPoint touchPoint = [tap locationInView:self.imageView];
        CGFloat newZoomScale = _scrollView.maximumZoomScale;
        CGFloat xsize = self.frame.size.width / newZoomScale;
        CGFloat ysize = self.frame.size.height / newZoomScale;
        [_scrollView zoomToRect:CGRectMake(touchPoint.x - xsize/2, touchPoint.y - ysize/2, xsize, ysize) animated:YES];
    }
}

- (void)singleTap:(UITapGestureRecognizer *)tap {
    if (self.singleTapGestureBlock) {
        self.singleTapGestureBlock();
    }
}

#pragma mark - UIScrollViewDelegate

- (nullable UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView {
    return _imageContainerView;
}

- (void)scrollViewWillBeginZooming:(UIScrollView *)scrollView withView:(UIView *)view {
    scrollView.contentInset = UIEdgeInsetsZero;
}

- (void)scrollViewDidZoom:(UIScrollView *)scrollView {
    [self refreshImageContainerViewCenter];
}



#pragma mark - Private

- (void)refreshImageContainerViewCenter {
    CGFloat offsetX = (_scrollView.lpd_width > _scrollView.contentSize.width) ? ((_scrollView.lpd_width - _scrollView.contentSize.width) * 0.5) : 0.0;
    CGFloat offsetY = (_scrollView.lpd_height > _scrollView.contentSize.height) ? ((_scrollView.lpd_height - _scrollView.contentSize.height) * 0.5) : 0.0;
    self.imageContainerView.center = CGPointMake(_scrollView.contentSize.width * 0.5 + offsetX, _scrollView.contentSize.height * 0.5 + offsetY);
}

@end
