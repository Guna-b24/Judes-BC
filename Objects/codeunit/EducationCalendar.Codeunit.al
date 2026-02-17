codeunit 71884 "Education Calendar"
{


    trigger OnRun()
    begin
    end;

    //   procedure "Generate Calendar"(EduCode: Code[20]; AcaYear: Code[20])
    // var
    //     Date1: Record Date;
    //     EduCalendarEntry: Record Table71922;
    //     EduCalendarOffDaySetup: Record Table71923;
    //     IntDay: Integer;
    //     PeriodHeader: Record Table71510;
    //     EduCalendarHolidaySetup: Record Table71924;
    //     EduCalendar: Record Table71921;
    // begin
    //     EduCalendar.GET(EduCode);
    //     EduCalendarEntry.RESET;
    //     EduCalendarEntry.SETRANGE(EduCalendarEntry.Code, EduCode);
    //     IF EduCalendarEntry.FINDFIRST THEN BEGIN
    //         EduCalendarEntry.MODIFYALL("Off Day", FALSE);
    //         EduCalendarEntry.MODIFYALL(Holiday, FALSE);
    //         EduCalendarEntry.MODIFYALL("Description-1", '');
    //     END;

    //     Date1.RESET;
    //     Date1.SETFILTER("Period Type", '%1', Date1."Period Type"::Date);
    //     Date1.SETFILTER("Period Start", '%1..%2', EduCalendar."Start Date", EduCalendar."End Date");
    //     IF Date1.FINDFIRST THEN
    //         REPEAT
    //             EduCalendarEntry.SETFILTER(Code, '%1', EduCalendar.Code);
    //             EduCalendarEntry.SETFILTER(Date, '%1', Date1."Period Start");
    //             IF NOT EduCalendarEntry.FINDFIRST THEN BEGIN
    //                 EduCalendarEntry.Code := EduCalendar.Code;
    //                 EduCalendarEntry.Date := Date1."Period Start";
    //                 EduCalendarEntry.Day := Date1."Period No.";
    //                 EduCalendarEntry."Day Order" := 0;
    //                 EduCalendarEntry.INSERT;
    //             END;
    //         UNTIL Date1.NEXT = 0;

    //     EduCalendarOffDaySetup.RESET;
    //     EduCalendarOffDaySetup.SETFILTER(Code, '%1', EduCalendar.Code);
    //     IF EduCalendarOffDaySetup.FINDFIRST THEN
    //         REPEAT
    //             EduCalendarEntry.RESET;
    //             EduCalendarEntry.SETFILTER(Code, '%1', EduCalendarOffDaySetup.Code);
    //             EduCalendarEntry.SETFILTER(Day, '%1', EduCalendarOffDaySetup.WeekDay);
    //             IF EduCalendarEntry.FINDFIRST THEN
    //                 REPEAT
    //                     EduCalendarEntry."Off Day" := TRUE;
    //                     EduCalendarEntry.MODIFY;
    //                 UNTIL EduCalendarEntry.NEXT = 0;
    //         UNTIL EduCalendarOffDaySetup.NEXT = 0;

    //     EduCalendarHolidaySetup.RESET;
    //     EduCalendarHolidaySetup.SETRANGE(Code, EduCalendar.Code);
    //     IF EduCalendarHolidaySetup.FINDFIRST THEN
    //         REPEAT
    //             EduCalendarEntry.RESET;
    //             EduCalendarEntry.SETRANGE(Code, EduCalendarHolidaySetup.Code);
    //             EduCalendarEntry.SETRANGE(Date, EduCalendarHolidaySetup."Holiday Date");
    //             IF EduCalendarEntry.FINDFIRST THEN
    //                 REPEAT
    //                     EduCalendarEntry.Holiday := TRUE;
    //                     EduCalendarEntry."Description-1" := EduCalendarHolidaySetup.Description;
    //                     EduCalendarEntry.MODIFY;
    //                 UNTIL EduCalendarEntry.NEXT = 0;
    //         UNTIL EduCalendarHolidaySetup.NEXT = 0
    // end;


    // procedure AssignDayorder()
    // var
    //     PeriodHeader: Record Table71510;
    //     EduCalendarEntry: Record Table71922;
    //     IntDay: Integer;
    // begin
    //     PeriodHeader.FINDFIRST;
    //     IntDay := 1;
    //     EduCalendarEntry.RESET;
    //     EduCalendarEntry.SETRANGE("Off Day", FALSE);
    //     EduCalendarEntry.SETRANGE(Holiday, FALSE);
    //     IF EduCalendarEntry.FINDFIRST THEN
    //         REPEAT
    //             IF IntDay = PeriodHeader."Working Days Per Week" + 1 THEN
    //                 IntDay := 1;
    //             EduCalendarEntry."Day Order" := IntDay;
    //             EduCalendarEntry.MODIFY;
    //             IntDay += 1;
    //         UNTIL EduCalendarEntry.NEXT = 0;
    // end;
}

