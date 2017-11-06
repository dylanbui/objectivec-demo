//
//  CanvasImageView.m
//  ObjcApp
//
//  Created by Dylan Bui on 11/6/17.
//  Copyright © 2017 Propzy Viet Nam. All rights reserved.
//

#import "CanvasImageView.h"

@interface CanvasImageView()

@property (nonatomic, assign) CGPoint location;

@property (nonatomic, strong) NSMutableArray *arrLocation;


@end

@implementation CanvasImageView
@synthesize location = _location;
@synthesize delegate = _delegate;

- (instancetype)init
{
    if (self = [super init]) {
        self.arrLocation = [[NSMutableArray alloc] init];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.arrLocation = [[NSMutableArray alloc] init];
    }
    return self;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    [self.delegate touchesBegan:touch];
    self.location = [touch locationInView:self];
    
    [self.arrLocation addObject:[NSValue valueWithCGPoint:self.location]];
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    CGPoint currentLocation = [touch locationInView:self];
    [self.delegate touchesMoved:touch];
    
    [self drawLineFrom:self.location endPoint:currentLocation];
    
    self.location = currentLocation;
    [self.arrLocation addObject:[NSValue valueWithCGPoint:self.location]];
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    CGPoint currentLocation = [touch locationInView:self];
    [self.delegate touchesEnded:touch];
    
//    [self drawLineFrom:self.location endPoint:currentLocation];
    
    self.location = currentLocation;
    [self.arrLocation addObject:[NSValue valueWithCGPoint:self.location]];
    
    
    // -- Clear touch path -- 
    self.image = nil;
    
    [self drawBezierPath];
    
//    CGPoint firstPoint = [[self.arrLocation firstObject] CGPointValue];
//    CGPoint lastPoint = [[self.arrLocation lastObject] CGPointValue];
//
//    [self drawLineFrom:firstPoint endPoint:lastPoint];
}

- (void)drawBezierPath
{
    // create the mask that will be applied to the layer on top of the
    // yellow background
    CAShapeLayer *maskLayer = [CAShapeLayer layer];
    maskLayer.fillRule = kCAFillRuleEvenOdd;
    maskLayer.frame = self.frame;
    
    CGPoint firstPoint = [[self.arrLocation firstObject] CGPointValue];
    UIBezierPath *choosePath = [UIBezierPath bezierPath];
    // Specify the point that the path should start get drawn.
    [choosePath moveToPoint:firstPoint];
    
    for (int i = 1; i < [self.arrLocation count]; i++) {
        CGPoint point = [[self.arrLocation objectAtIndex:i] CGPointValue];
        // Create the vertical line from the bottom-right to the top-right side.
        [choosePath addLineToPoint:point];
    }
    
    // Close the path. This will create the last line automatically.
    [choosePath closePath];
    
    UIBezierPath *maskLayerPath = [UIBezierPath bezierPath];
    [maskLayerPath appendPath:[UIBezierPath bezierPathWithRect:CGRectInset(self.frame, 0, 0)]];
    [maskLayerPath appendPath:choosePath];
    
    maskLayer.path = maskLayerPath.CGPath;
    
    // create the layer on top of the yellow background
    CALayer *imageLayer = [CALayer layer];
    imageLayer.frame = self.layer.bounds;
    imageLayer.backgroundColor = [[[UIColor grayColor] colorWithAlphaComponent:0.5] CGColor];
    
    // apply the mask to the layer
    imageLayer.mask = maskLayer;
    [self.layer addSublayer:imageLayer];
    
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    shapeLayer.path = [choosePath CGPath];
    shapeLayer.strokeColor = [[UIColor blueColor] CGColor];
    shapeLayer.lineWidth = 3.0;
    shapeLayer.fillColor = [[UIColor clearColor] CGColor];
//    shapeLayer.fillRule = kCAFillRuleEvenOdd;
//    shapeLayer.frame = self.frame;
    [self.layer addSublayer:shapeLayer];
    

    
//    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
//    shapeLayer.path = [path CGPath];
//    shapeLayer.strokeColor = [[UIColor blueColor] CGColor];
//    shapeLayer.lineWidth = 3.0;
//    shapeLayer.fillColor = [[UIColor yellowColor] CGColor];
//    //    shapeLayer.fillRule = kCAFillRuleEvenOdd;
//    //    shapeLayer.frame = self.frame;
//    //     [self.layer addSublayer:shapeLayer];
//
//    // create the layer on top of the yellow background
//    UIBezierPath *pathBg = [UIBezierPath bezierPathWithRect:self.frame];
//    CAShapeLayer *imageLayer = [CAShapeLayer layer];
//    imageLayer.frame = self.frame;
//    imageLayer.path = [pathBg CGPath];
//
//    //imageLayer.backgroundColor = [[[UIColor blueColor] colorWithAlphaComponent:0.5] CGColor];
//    //imageLayer.fillColor = [[UIColor orangeColor] CGColor];
//    imageLayer.fillRule = kCAFillRuleEvenOdd;
//    imageLayer.backgroundColor = [[UIColor redColor] CGColor];
//
//    imageLayer.mask = shapeLayer;
//    //    shapeLayer.mask = imageLayer;
//
//    [self.layer addSublayer:imageLayer];
//
//    //    [self.layer addSublayer:shapeLayer];
//
//    [self setNeedsDisplay];
    
}

//- (void)drawBezierPath
//{
//    CGPoint firstPoint = [[self.arrLocation firstObject] CGPointValue];
//    UIBezierPath *path = [UIBezierPath bezierPath];
//    // Specify the point that the path should start get drawn.
//    [path moveToPoint:firstPoint];
//
//    for (int i = 1; i < [self.arrLocation count]; i++) {
//        CGPoint point = [[self.arrLocation objectAtIndex:i] CGPointValue];
//        // Create the vertical line from the bottom-right to the top-right side.
//        [path addLineToPoint:point];
//    }
//
//    // Close the path. This will create the last line automatically.
//    [path closePath];
//
//    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
//    shapeLayer.path = [path CGPath];
//    shapeLayer.strokeColor = [[UIColor blueColor] CGColor];
//    shapeLayer.lineWidth = 3.0;
//    shapeLayer.fillColor = [[UIColor yellowColor] CGColor];
////    shapeLayer.fillRule = kCAFillRuleEvenOdd;
////    shapeLayer.frame = self.frame;
////     [self.layer addSublayer:shapeLayer];
//
//    // create the layer on top of the yellow background
//    UIBezierPath *pathBg = [UIBezierPath bezierPathWithRect:self.frame];
//    CAShapeLayer *imageLayer = [CAShapeLayer layer];
//    imageLayer.frame = self.frame;
//    imageLayer.path = [pathBg CGPath];
//
//    //imageLayer.backgroundColor = [[[UIColor blueColor] colorWithAlphaComponent:0.5] CGColor];
//    //imageLayer.fillColor = [[UIColor orangeColor] CGColor];
//    imageLayer.fillRule = kCAFillRuleEvenOdd;
//    imageLayer.backgroundColor = [[UIColor redColor] CGColor];
//
//    imageLayer.mask = shapeLayer;
////    shapeLayer.mask = imageLayer;
//
//    [self.layer addSublayer:imageLayer];
//
////    [self.layer addSublayer:shapeLayer];
//
//    [self setNeedsDisplay];
//
//}


- (void)drawLineFrom:(CGPoint)from endPoint:(CGPoint)to
{
    UIGraphicsBeginImageContext(self.frame.size);
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    [self.image drawInRect:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
    CGContextSetLineCap(ctx, kCGLineCapRound);
    CGContextSetLineWidth(ctx, 2.0);
    CGContextSetStrokeColorWithColor(ctx, [[UIColor blueColor] colorWithAlphaComponent:0.7].CGColor);
    CGContextBeginPath(ctx);
    CGContextMoveToPoint(ctx, from.x, from.y);
    CGContextAddLineToPoint(ctx, to.x, to.y);
    CGContextStrokePath(ctx);
    self.image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();    
}


@end

