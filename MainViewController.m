//
//  MainViewController.m
//  DynamicAnimatorDemo
//
//  Created by Apptunix on 04/09/14.
//  Copyright (c) 2014 Apptunix. All rights reserved.
//

#import "MainViewController.h"

@interface MainViewController ()

@end

@implementation MainViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    firstContact = YES;
    [self methodForDynamicBehaviour2];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)methodForDynamicBehaviour2
{
    if (firstContact)
    {
        view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 50, 50)];
        [view setBackgroundColor:[UIColor blackColor]];
        [self.view addSubview:view];
        barrier = [[UIView alloc] initWithFrame:CGRectMake(0, 300, 130, 20)];
        barrier.backgroundColor = [UIColor grayColor];
        [self.view addSubview:barrier];

    }
    else
    [view setBackgroundColor:[UIColor blackColor]];
    [self.view addSubview:view];

    barrier.backgroundColor = [UIColor grayColor];
    [self.view addSubview:barrier];
    animator = [[UIDynamicAnimator alloc]initWithReferenceView:self.view];
    gravity = [[UIGravityBehavior alloc]initWithItems:@[view]];
    [animator addBehavior:gravity];
    CGVector vector = CGVectorMake(1,0);
    [gravity setGravityDirection:vector];
    [self performSelector:@selector(method1) withObject:nil afterDelay:1.0];
    collision = [[UICollisionBehavior alloc]initWithItems:@[view,barrier]];
    collision.translatesReferenceBoundsIntoBoundary = YES;
//    CGPoint rightEdge = CGPointMake(barrier.frame.origin.x +
//                                    barrier.frame.size.width, barrier.frame.origin.y);
//    [collision addBoundaryWithIdentifier:@"barrier"
//                               fromPoint:barrier.frame.origin
//                                 toPoint:rightEdge];
    collision.collisionDelegate = self;
    [animator addBehavior:collision];
    UIDynamicItemBehavior* itemBehaviour = [[UIDynamicItemBehavior alloc] initWithItems:@[barrier,view]];
    itemBehaviour.elasticity = 1.1;
    itemBehaviour.allowsRotation = YES;
    [animator addBehavior:itemBehaviour];
}

-(void)method1
{
    CGVector vector = CGVectorMake(1,1);
    [gravity setGravityDirection:vector];
    [self performSelector:@selector(method2) withObject:nil afterDelay:1.5];
}

-(void)method2
{
    CGVector vector = CGVectorMake(-1,1);
    [gravity setGravityDirection:vector];
    [self performSelector:@selector(method3) withObject:nil afterDelay:1.5];
}

-(void)method3
{
    CGVector vector = CGVectorMake(0,-1);
    [gravity setGravityDirection:vector];
    firstContact = NO;
    [self performSelector:@selector(methodForDynamicBehaviour2) withObject:nil afterDelay:1.5];
}

-(void)methodForDynamicBehaviour
{
    view = [[UIView alloc]initWithFrame:CGRectMake(107, 0, 50, 50)];
    [view setBackgroundColor:[UIColor blackColor]];
    [self.view addSubview:view];
    barrier = [[UIView alloc] initWithFrame:CGRectMake(0, 300, 130, 20)];
    barrier.backgroundColor = [UIColor grayColor];
    [self.view addSubview:barrier];
    animator = [[UIDynamicAnimator alloc]initWithReferenceView:self.view];
    gravity = [[UIGravityBehavior alloc]initWithItems:@[view]];
    [animator addBehavior:gravity];
    collision = [[UICollisionBehavior alloc]initWithItems:@[view]];
    collision.translatesReferenceBoundsIntoBoundary = YES;
    CGPoint rightEdge = CGPointMake(barrier.frame.origin.x +
                                    barrier.frame.size.width, barrier.frame.origin.y);
    [collision addBoundaryWithIdentifier:@"barrier"
                                fromPoint:barrier.frame.origin
                                  toPoint:rightEdge];
    collision.collisionDelegate = self;
    [animator addBehavior:collision];
    UIDynamicItemBehavior* itemBehaviour = [[UIDynamicItemBehavior alloc] initWithItems:@[view]];
    itemBehaviour.elasticity = 0.6;
    itemBehaviour.allowsRotation = YES;
    [animator addBehavior:itemBehaviour];
   
}
- (void)collisionBehavior:(UICollisionBehavior *)behavior beganContactForItem:(id<UIDynamicItem>)item
   withBoundaryIdentifier:(id<NSCopying>)identifier atPoint:(CGPoint)p {
    NSLog(@"Boundary contact occurred - %@", identifier);
    UIView* view1 = (UIView*)item;
    view1.backgroundColor = [UIColor redColor];
    [UIView animateWithDuration:0.3 animations:^{
        view1.backgroundColor = [UIColor grayColor];
    }];
}

@end
