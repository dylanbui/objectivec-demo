//
//  BALabel.m
//  ObjcApp
//
//  Created by Dylan Bui on 9/8/17.
//  Copyright © 2017 Propzy Viet Nam. All rights reserved.
//

#import "BALabel.h"


CGPathRef CGPathCreateRoundBezel(CGRect bounds, CGFloat lineWidth);

CGPathRef CGPathCreateRoundBezel(CGRect bounds, CGFloat lineWidth) {
    CGRect b = CGRectInset(bounds, lineWidth, lineWidth);
    const CGFloat w = b.size.width;
    const CGFloat h = b.size.height;
    if (w <= h) {
        UIBezierPath *bpath = [UIBezierPath bezierPathWithOvalInRect:b];
        CGPathRef path = bpath.CGPath;
        CGPathRetain(path);
        return path;
    }
    const CGFloat x = b.origin.x;
    const CGFloat y = b.origin.y;
    CGMutablePathRef path = CGPathCreateMutable();
    const CGFloat r = h / 2;
    CGPathMoveToPoint(path, NULL, x + r, y);
    CGPathAddLineToPoint(path, NULL, x + w - r, y);
    CGPathAddArc(path, NULL, x + w - r, y + r, r, -M_PI_2, M_PI_2, NO);
    CGPathAddLineToPoint(path, NULL, x + r, y + h);
    CGPathAddArc(path, NULL, x + r, y + r, r, M_PI_2, -M_PI_2, NO);
    return path;
}

@implementation BALabel {
@private
    UIEdgeInsets _textInsets;
    BAVerticalAlignment _verticalAlignment;
    BALabelBezel _bezel;
    CGFloat _bezelLineWidth;
    UIColor *_bezelColor;
    
    CGFloat _fitMaxWidth;
    CGFloat _fitMaxHeight;
    int _fit;
}


- (UIEdgeInsets)textInsets {
    return _textInsets;
}

- (void)setTextInsets:(UIEdgeInsets)textInsets {
    if (UIEdgeInsetsEqualToEdgeInsets(_textInsets, textInsets)) {
        return;
    }
    _textInsets = textInsets;
    [self setNeedsDisplay];
}

- (BAVerticalAlignment)verticalAlignment {
    return _verticalAlignment;
}

- (void)setVerticalAlignment:(BAVerticalAlignment)verticalAlignment {
    if (_verticalAlignment == verticalAlignment) {
        return;
    }
    _verticalAlignment = verticalAlignment;
    [self setNeedsDisplay];
}

- (BALabelBezel)bezel {
    return _bezel;
}

- (void)setBezel:(BALabelBezel)bezel {
    if (_bezel == bezel) {
        return;
    }
    _bezel = bezel;
    [self setNeedsDisplay];
}

- (CGFloat)bezelLineWidth {
    return _bezelLineWidth;
}

- (void)setBezelLineWidth:(CGFloat)bezelLineWidth {
    if (_bezelLineWidth == bezelLineWidth) {
        return;
    }
    _bezelLineWidth = bezelLineWidth;
    [self setNeedsDisplay];
}

- (UIColor *)bezelColor {
    return _bezelColor;
}

- (void)setBezelColor:(UIColor *)bezelColor {
    if (_bezelColor == bezelColor) {
        return;
    }
    _bezelColor = bezelColor;
    [self setNeedsDisplay];
}

- (CGRect)textRectForBounds:(CGRect)bounds limitedToNumberOfLines:(NSInteger)numberOfLines {
    CGRect r = bounds;
    if (_fit > 0) {
        r.size.width = _fitMaxWidth;
        r.size.height = _fitMaxHeight;
    }
    const CGFloat wd = self.textInsets.left + self.textInsets.right;
    const CGFloat hd = self.textInsets.top + self.textInsets.bottom;
    r.size.width -= wd;
    r.size.height -= hd;
    r = [super textRectForBounds:r limitedToNumberOfLines:numberOfLines];
    r.size.width += wd;
    r.size.height += hd;
    return r;
}

- (void)drawTextInRect:(CGRect)rect {
    CGRect tr = [self textRectForBounds:self.bounds limitedToNumberOfLines:self.numberOfLines];
    const CGFloat hd = self.bounds.size.height - tr.size.height;
    if (self.verticalAlignment == BAVerticalAlignmentCenter) {
        tr.origin.y += rint(hd / 2);
    } else if (self.verticalAlignment == BAVerticalAlignmentBottom) {
        tr.origin.y += rint(hd);
    }
    tr = UIEdgeInsetsInsetRect(tr, self.textInsets);
    [super drawTextInRect:tr];
}

- (void)drawBezel {
    switch (self.bezel) {
        case BALabelBezelNone:
            break;
        case BALabelBezelRound: {
            CGContextRef ctx = UIGraphicsGetCurrentContext();
            CGContextSaveGState(ctx);
            CGContextSetLineWidth(ctx, MAX(1, self.bezelLineWidth));
            if (self.bezelColor) {
                [self.bezelColor setStroke];
            }
            CGPathRef path = CGPathCreateRoundBezel(self.bounds, self.bezelLineWidth);
            CGContextAddPath(ctx, path);
            CGPathRelease(path);
            CGContextStrokePath(ctx);
            CGContextRestoreGState(ctx);
            break;
        }
        case BALabelBezelRoundSolid: {
            CGContextRef ctx = UIGraphicsGetCurrentContext();
            CGContextSaveGState(ctx);
            if (self.bezelColor) {
                [self.bezelColor setFill];
            }
            CGPathRef path = CGPathCreateRoundBezel(self.bounds, self.bezelLineWidth);
            CGContextAddPath(ctx, path);
            CGPathRelease(path);
            CGContextFillPath(ctx);
            CGContextRestoreGState(ctx);
            break;
        }
    }
}

- (void)drawRect:(CGRect)rect {
    [self drawBezel];
    [super drawRect:rect];
}

- (void)sizeToFitInWidth {
    [self sizeToFitInWidthMaxHeight:CGFLOAT_MAX];
}

- (void)sizeToFitInWidthMaxHeight:(CGFloat)maxHeight {
    const CGFloat w = self.bounds.size.width;
    
    _fit++;
    _fitMaxWidth = w;
    _fitMaxHeight = maxHeight;
    
    CGSize s = [self sizeThatFits:CGSizeMake(w, maxHeight)];
    
    _fit--;
    
    CGRect frame = self.frame;
    frame.size.height = s.height;
    self.frame = frame;
}

@end
