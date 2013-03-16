//
//  UTPathFinderModel.m
//  UndevTour
//
//  Created by Иван Ушаков on 16.03.13.
//  Copyright (c) 2013 Chebulaev Oleg. All rights reserved.
//

#import "UTPathFinderModel.h"
#import "AStar.h"
#import "UTExhibit.h"

@interface UTPathFinderModel ()
@property (strong, nonatomic) UTBlockService* blockService;
@end

@implementation UTPathFinderModel

- (id)initWithBlockService:(UTBlockService*)blockService
{
    self = [super init];
    if (self) {
        self.blockService = blockService;
    }
    return self;
}

- (NSArray*)findPathForObjects:(NSArray*)objects startOn:(UTExhibit*)startObject
{
    NSMutableArray *objectsForPathFinding = [NSMutableArray arrayWithArray:objects];
    [objectsForPathFinding insertObject:startObject atIndex:0];
    
    NSMutableArray *path = [NSMutableArray arrayWithCapacity:objectsForPathFinding.count];
    for (NSUInteger i = 0; i < objectsForPathFinding.count; i++) {
        NSMutableArray *array = [NSMutableArray arrayWithCapacity:objectsForPathFinding.count];
        [path addObject:array];
        for (NSUInteger j = 0; j < objectsForPathFinding.count; j++) {
            path[i][j] = [NSNull null];
        }
    }
    
    for (NSUInteger i = 0; i < objectsForPathFinding.count; i++) {
        for (NSUInteger j = i + 1; j < objectsForPathFinding.count; j++) {
            UTExhibit *startObject = objectsForPathFinding[i];
            UTExhibit *finishObject = objectsForPathFinding[j];
            
            CGPoint start = [[startObject coordinate] CGPointValue];
            CGPoint finish = [[finishObject coordinate] CGPointValue];
            
            AStarFinder* finder = [[AStarFinder alloc] initWithCapacity:1000];
            FindingTracer *tracer = [[FindingTracer alloc] init];
            
            [finder find:self.blockService
                    from:[IntPoint pointWithX:start.x withY:start.y]
                      to:[IntPoint pointWithX:finish.x withY:finish.y]
              withTracer:tracer];
            
            path[i][j] = tracer.path;
            path[j][i] = [tracer.path reverseArray];
        }
    }
    
    NSMutableArray *resultPath = [NSMutableArray array];
    NSInteger currentPos = 0;
    while (true) {
        NSInteger minDistanceTo = -1;
        for (NSInteger j = 0; j < path.count; j++) {
            if([path[currentPos][j] isKindOfClass:[NSArray class]]) {
                if (minDistanceTo < 0 || [path[currentPos][minDistanceTo] count] > [path[currentPos][j] count]) {
                    minDistanceTo = j;
                }
            }
        }
        if (minDistanceTo == -1) {
            break;
        }
        else {
            [resultPath addObject:path[currentPos][minDistanceTo]];
            path[currentPos][minDistanceTo] = path[minDistanceTo][currentPos] = [NSNull null];
        }
    }
    
    return resultPath;
}

@end
