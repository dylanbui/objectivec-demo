DucBui : 18/04/2018
Lop DbZoomTransitionAnimator duoc xay dung dua tren
    https://github.com/recruit-mp/RMPZoomTransitionAnimator

Dung de mo 1 modal uiviewcontroller (vd: detailviewcontroller) voi zoom animation, detailviewcontroller thuong la du lieu tinh (demo zoom tu 1 tam anh)

khi su dung UIImageView hien thi cua ca 2 (detail, parent), nen la
    imageView.contentMode = UIViewContentModeScaleAspectFill; // Hinh anh chi hien thi fill khung hinh
    imageView.clipsToBounds = YES; // Nhung phan ben ngoai khung hinh thi cat bo


Huong dan :
    - Trong lop detailviewcontroller.h => #import "DbZoomTransitionAnimator.h", override 2 class <DbZoomTransitionAnimating, DbZoomTransitionDelegate>

#pragma mark - <DbZoomTransitionAnimating>

- (UIView *)transitionSourceView
{
// Day la uiview ket thuc zoom animation thay duoc

    UIImageView *imageView = [[UIImageView alloc] initWithImage:self.mainImageView.image];
    imageView.contentMode = self.mainImageView.contentMode;
    // imageView.contentMode = UIViewContentModeScaleAspectFill;
    imageView.clipsToBounds = YES;
    imageView.userInteractionEnabled = NO;
    imageView.frame = self.mainImageView.frame;
    return imageView;
}

- (UIColor *)transitionSourceBackgroundColor
{
// Khong yeu cau, set color background animation
    return self.view.backgroundColor;
}

- (CGRect)transitionDestinationViewFrame
{
// Day la frame ket thuc zoom animation

    CGFloat width = CGRectGetWidth(self.view.frame);
    CGRect frame = self.mainImageView.frame;
    frame.size.width = width;
    // -- 0 - 110 - 248 - 375 --
    // NSLog(@"NSStringFromCGRect(frame) = %@", NSStringFromCGRect(frame));
    return frame;
}

#pragma mark - <RMPZoomTransitionDelegate>

- (void)zoomTransitionAnimator:(DbZoomTransitionAnimator *)animator
didCompleteTransition:(BOOL)didComplete
animatingSourceView:(UIView *)view
{
// Sau khi hoan tat zoom animation
    UIImageView *imageView = (UIImageView *) view;
    self.mainImageView.image = imageView.image;
}



    - Trong lop parentviewcontroller.h => #import "detailviewcontroller.h", override 1 class <DbZoomTransitionAnimating>

#pragma mark - <RMPZoomTransitionAnimating>

- (UIView *)transitionSourceView
{
// Day la uivew bat dau chay zoom animation

    NSIndexPath *selectedIndexPath = [[self.collectionView indexPathsForSelectedItems] firstObject];
    RMPImageCollectionViewCell *cell = (RMPImageCollectionViewCell *)[self.collectionView cellForItemAtIndexPath:selectedIndexPath];
    UIImageView *imageView = [[UIImageView alloc] initWithImage:cell.imageView.image];
    imageView.contentMode = cell.imageView.contentMode;
    //    imageView.contentMode = UIViewContentModeScaleAspectFill;
    imageView.clipsToBounds = YES;
    imageView.userInteractionEnabled = NO;
    imageView.frame = [cell.imageView convertRect:cell.imageView.frame toView:self.collectionView.superview];
    return imageView;
}

- (UIColor *)transitionSourceBackgroundColor
{
// Khong yeu cau, set color background animation
    return self.collectionView.backgroundColor;
}

- (CGRect)transitionDestinationViewFrame
{
// Day la frame bat dau vi tri zoom animation

    NSIndexPath *selectedIndexPath = [[self.collectionView indexPathsForSelectedItems] firstObject];
    RMPImageCollectionViewCell *cell = (RMPImageCollectionViewCell *)[self.collectionView cellForItemAtIndexPath:selectedIndexPath];
    CGRect cellFrameInSuperview = [cell.imageView convertRect:cell.imageView.frame toView:self.collectionView.superview];
    return cellFrameInSuperview;
}
