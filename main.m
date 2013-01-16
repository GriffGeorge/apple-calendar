#import <stdio.h>
#import <Foundation/NSString.h>
#import <Foundation/NSDate.h>
#import <Foundation/NSDateFormatter.h>
#import <Foundation/NSObjCRuntime.h>
#import <Foundation/NSCalendar.h>
#import <Foundation/NSFileHandle.h>
#import <EventKit/EventKit.h>
#import <EventKit/EKTypes.h>
#import <EventKit/EKCalendar.h>
#import <EventKit/EKCalendarItem.h>

#define SECONDS_IN_18_HOURS 64800
#define TIME_FORMAT         @"hh:mm"
#define ALL_DAY_STRING      @"All Day\n"

int main() {
    //get the EKEventStore, which is the OSX Calendar database.
    EKEventStore *store = [[EKEventStore alloc] initWithAccessToEntityTypes:EKEntityMaskEvent];

    //create start and end dates
    NSDate *startDate = [NSDate date];
    NSDate *endDate = [[NSDate alloc] initWithTimeIntervalSinceNow:SECONDS_IN_18_HOURS];

    //create a predicate that will match event between startDate and endDate
    NSPredicate *predicate = [store predicateForEventsWithStartDate:startDate endDate:endDate calendars:nil];

    //get the list of events matching that predicate
    NSArray *events = [store eventsMatchingPredicate:predicate];

    //sort the array according to start date
    events = [events sortedArrayUsingSelector:@selector(compareStartDateWithEvent:)];

    //set up a date formatter that outputs the time as we want it.
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    NSString *dateFormat = [NSDateFormatter dateFormatFromTemplate:TIME_FORMAT options:0 locale:[NSLocale currentLocale]];
    [formatter setDateFormat:dateFormat];

    //open file handle for stdout
    NSFileHandle *file = [NSFileHandle fileHandleWithStandardOutput];

    //print the events to a file
    NSString *timeString = @"";
    NSString *titleString = @"";
    NSString *lineString = @"";
    for (EKEvent *event in events) {

        //create the line to write to the file.
        if ([event isAllDay]) {
            timeString = ALL_DAY_STRING;
        } else {
            timeString = [formatter stringFromDate:[event startDate]];
        }
        titleString = [event title];
        lineString = [NSString stringWithFormat:@"%@ %@\n", timeString, titleString];

        //write that line to the file
        [file seekToEndOfFile];
        [file writeData:[lineString dataUsingEncoding:NSUTF8StringEncoding]];
    }

    //release the timeString memory
    [timeString release];
    [titleString release];
    [lineString release];

    //close the file
    [file closeFile];

    //release the file handle
    [file release];

    //release all the other memory
    [startDate release];
    [endDate release];
    [formatter release];
    [dateFormat release];
    [store release];
    return 0;
}
