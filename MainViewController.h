//
//  MainViewController.h
//  DynamicAnimatorDemo
//
//  Created by Apptunix on 04/09/14.
//  Copyright (c) 2014 Apptunix. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MainViewController : UIViewController<UICollisionBehaviorDelegate>
{
    UIDynamicAnimator *animator;
    UIGravityBehavior *gravity;
    UICollisionBehavior *collision;
    BOOL firstContact;
    UIAttachmentBehavior *attachment;
    UIView *view;
    UIView* barrier;

}
@end
