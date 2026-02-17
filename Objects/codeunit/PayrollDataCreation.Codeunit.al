codeunit 72007 "Payroll Data Creation"
{
    trigger OnRun()
    begin
        "Pay HR Pay Setup"();
        "Pay Year"();
        "Pay Shift Master"();
        "Pay Weekly Off"();
        "Pay Holiday"();
        "Pay Grade"();
        "Pay Elements"();
        "Pay ESI Setup"();
        "Pay PF Setup"();
        "Pay PT Setup"();
        "Pay Leave Setup"();
        "Pay Business Posting Group"();
        "Pay Product Posting Group"();
        "Pay General Posting Group"();
        "Pay Employee Posting Group"();

        Message('%1', 'System Defined Data is Created..');
    end;


    procedure "Pay HR Pay Setup"()
    var
        HRPayrollSetup: Record "HR & Payroll Setup";
    begin
        with HRPayrollSetup do begin

            Init();
            "Location Code" := 'HO';
            "Location Name" := 'Head Office';
            if not Insert() then;

        end;
    end;


    procedure "Pay Year"()
    var
        PayrollYear: Record "Payroll Year";
    begin
        with PayrollYear do begin

            Init();
            "Year Code" := '2008-2008';
            "Year Type" := "Year Type"::"Salary Year";
            "Year Start Date" := 20080101D;
            "Year End Date" := 20081231D;
            if not Insert() then;

            Init();
            "Year Code" := '2008-2008';
            "Year Type" := "Year Type"::"PF Year";
            "Year Start Date" := 20080101D;
            "Year End Date" := 20081231D;
            if not Insert() then;

            Init();
            "Year Code" := '2008-2008';
            "Year Type" := "Year Type"::"ESI Year";
            "Year Start Date" := 20080101D;
            "Year End Date" := 20081231D;
            if not Insert() then;

            Init();
            "Year Code" := '2008-2008';
            "Year Type" := "Year Type"::"Income Tax Year";
            "Year Start Date" := 20080101D;
            "Year End Date" := 20081231D;
            if not Insert() then;

            Init();
            "Year Code" := '2008-2008';
            "Year Type" := "Year Type"::"Bonus Year";
            "Year Start Date" := 20080101D;
            "Year End Date" := 20081231D;
            if not Insert() then;

            Init();
            "Year Code" := '2008-2008';
            "Year Type" := "Year Type"::"Leave Year";
            "Year Start Date" := 20080101D;
            "Year End Date" := 20081231D;
            if not Insert() then;

            Init();
            "Year Code" := '2008-2008';
            // "Year Type" := "Year Type"::"6";
            "Year Start Date" := 20080101D;
            "Year End Date" := 20081231D;
            if not Insert() then;

            Init();
            "Year Code" := '2008-2009';
            //"Year Type" := "Year Type"::"7";
            "Year Start Date" := 20080104D;
            "Year End Date" := 20090103D;
            if not Insert() then;

        end;
    end;


    procedure "Pay Shift Master"()
    var
        Shift: Record Shift;
    begin
        with Shift do begin

            Init();
            Code := 'GEN';
            Description := 'General Shift';
            "First Half Starting Time" := 090000T;
            "First Half Ending Time" := 130000T;
            "Second Half Starting Time" := 140000T;
            "Second Half Ending Time" := 180000T;
            "Break Start Time" := 130000T;
            "Break End Time" := 140000T;
            Validate("First Half Starting Time");
            Validate("First Half Ending Time");
            Validate("Second Half Starting Time");
            Validate("Second Half Ending Time");
            Validate("Break Start Time");
            Validate("Break End Time");

            if not Insert() then;

            Init();
            Code := 'I';
            Description := 'First Shift';
            "First Half Starting Time" := 070000T;
            "First Half Ending Time" := 110000T;
            "Second Half Starting Time" := 110000T;
            "Second Half Ending Time" := 150000T;
            "Break Start Time" := 0T;
            "Break End Time" := 0T;
            Validate("First Half Starting Time");
            Validate("First Half Ending Time");
            Validate("Second Half Starting Time");
            Validate("Second Half Ending Time");
            Validate("Break Start Time");
            Validate("Break End Time");

            if not Insert() then;

            Init();
            Code := 'II';
            Description := 'Second Shift';
            "First Half Starting Time" := 150000T;
            "First Half Ending Time" := 190000T;
            "Second Half Starting Time" := 190000T;
            "Second Half Ending Time" := 230000T;
            "Break Start Time" := 0T;
            "Break End Time" := 0T;
            Validate("First Half Starting Time");
            Validate("First Half Ending Time");
            Validate("Second Half Starting Time");
            Validate("Second Half Ending Time");
            Validate("Break Start Time");
            Validate("Break End Time");

            if not Insert() then;

            Init();
            Code := 'III';
            Description := 'Third Shift';
            "First Half Starting Time" := 230000T;
            "First Half Ending Time" := 030000T;
            "Second Half Starting Time" := 030000T;
            "Second Half Ending Time" := 070000T;
            "Break Start Time" := 0T;
            "Break End Time" := 0T;
            Validate("First Half Starting Time");
            Validate("First Half Ending Time");
            Validate("Second Half Starting Time");
            Validate("Second Half Ending Time");
            Validate("Break Start Time");
            Validate("Break End Time");

            if not Insert() then;
        end;
    end;


    procedure "Pay Weekly Off"()
    var
        WeekOff: Record "Weekly Off";
    begin
        with WeekOff do begin
            Init();
            "Calendar Year" := '2008-2009';
            "Day No." := 6;
            Day := Day::Saturday;
            "Week Wise (Weekly Off)" := "Week Wise (Weekly Off)"::"All Week";
            "First Half (Weekly Off)" := false;
            "Second Half (Weekly Off)" := true;
            "Non Working Days" := true;
            if Insert() then;

            Init();
            "Calendar Year" := '2008-2009';
            "Day No." := 7;
            Day := Day::Sunday;
            "Week Wise (Weekly Off)" := "Week Wise (Weekly Off)"::"All Week";
            "First Half (Weekly Off)" := true;
            "Second Half (Weekly Off)" := true;
            "Non Working Days" := true;
            if Insert() then;
        end;
    end;


    procedure "Pay Holiday"()
    var
        Holidays: Record Holidays;
    begin
        with Holidays do begin
            Init();
            "Calendar Year" := '2008-2009';
            "Holiday Date" := CalcDate('CM', DMY2Date(26, 1, Date2DMY(Today, 3)));
            "Holiday Name" := 'Republic Day';
            "First Half (Holiday)" := true;
            "Second Half (Holiday)" := true;
            "Non Working Days" := true;
            if Insert() then;

            "Calendar Year" := '2008-2009';
            "Holiday Date" := CalcDate('CM', DMY2Date(6, 4, Date2DMY(Today, 3)));
            "Holiday Name" := 'Good Friday';
            "First Half (Holiday)" := true;
            "Second Half (Holiday)" := true;
            "Non Working Days" := true;
            if Insert() then;

            "Calendar Year" := '2008-2009';
            "Holiday Date" := CalcDate('CM', DMY2Date(14, 4, Date2DMY(Today, 3)));
            "Holiday Name" := 'Tamil New Year';
            "First Half (Holiday)" := true;
            "Second Half (Holiday)" := true;
            "Non Working Days" := true;
            if Insert() then;

            "Calendar Year" := '2008-2009';
            "Holiday Date" := CalcDate('CM', DMY2Date(15, 8, Date2DMY(Today, 3)));
            "Holiday Name" := 'Independance Day';
            "First Half (Holiday)" := true;
            "Second Half (Holiday)" := true;
            "Non Working Days" := true;
            if Insert() then;

            "Calendar Year" := '2008-2009';
            "Holiday Date" := CalcDate('CM', DMY2Date(9, 11, Date2DMY(Today, 3)));
            "Holiday Name" := 'Deepavali';
            "First Half (Holiday)" := true;
            "Second Half (Holiday)" := true;
            "Non Working Days" := true;
            if Insert() then;

            "Calendar Year" := '2008-2009';
            "Holiday Date" := CalcDate('CM', DMY2Date(28, 12, Date2DMY(Today, 3)));
            "Holiday Name" := 'Christmas';
            "First Half (Holiday)" := true;
            "Second Half (Holiday)" := true;
            "Non Working Days" := true;
            if Insert() then;
        end;
    end;


    procedure "Pay Grade"()
    var
        Grade: Record Grades;
    begin
        with Grade do begin

            Init();
            "Grade Code" := 'JR MGR';
            "Grade Name" := 'JR Manager';
            if not Insert() then;

            Init();
            "Grade Code" := 'MGR';
            "Grade Name" := 'Manager';
            if not Insert() then;

            Init();
            "Grade Code" := 'SR MGR';
            "Grade Name" := 'SR Manager';

            if not Insert() then;
        end;
    end;


    procedure "Pay Elements"()
    var
        PayElements: Record "Pay Elements";
    begin
        with PayElements do begin

            Init();
            "Pay Element Code" := 'BASIC';
            Description := 'Basic';
            "Pay Slip Printing Caption" := 'BASIC';
            "Paid Category" := "Paid Category"::Monthly;
            "Pay Type" := "Pay Type"::Addition;
            "Fixed/Percent" := "Fixed/Percent"::Fixed;
            "Amount Calculation Type" := "Amount Calculation Type"::"Pay Day";
            "Base Pay Elements" := '';
            "Base Amount ( For % )" := 0;
            Amount := 0;
            "Sorting Order" := 10;
            "Regular Element" := true;
            "Variable Element" := false;
            "Eligible for ESI Earnings" := true;
            "Eligible for PF" := true;
            "Eligible for PT" := true;
            "Eligible for OT" := true;
            "Eligible for Bonus" := true;
            "Eligible for Leave Encashment" := true;
            "Eligible for Gratuity" := true;
            "Eligible for Income Tax" := true;
            "Included In Pay Slip" := true;
            "Excluded In Pay Slip" := true;
            "All Grade" := true;
            "Predefined Code" := true;
            if not Insert() then;

            Init();
            "Pay Element Code" := 'DA';
            Description := 'Dearness Allowence';
            "Pay Slip Printing Caption" := 'DA';
            "Paid Category" := "Paid Category"::Monthly;
            "Pay Type" := "Pay Type"::Addition;
            "Fixed/Percent" := "Fixed/Percent"::Percent;
            "Amount Calculation Type" := "Amount Calculation Type"::"Pay Day";
            "Base Pay Elements" := 'BASIC';
            "Base Amount ( For % )" := 0;
            Amount := 0;
            "Sorting Order" := 20;
            "Regular Element" := true;
            "All Grade" := true;
            "Predefined Code" := true;
            if not Insert() then;

            Init();
            "Pay Element Code" := 'ALLOWANCE';
            Description := 'Allowance';
            "Pay Slip Printing Caption" := 'ALLOWANCE';
            "Paid Category" := "Paid Category"::Monthly;
            "Pay Type" := "Pay Type"::Addition;
            "Fixed/Percent" := "Fixed/Percent"::Fixed;
            "Amount Calculation Type" := "Amount Calculation Type"::"Pay Day";
            "Sorting Order" := 30;
            "Regular Element" := true;
            "All Grade" := true;
            "Predefined Code" := true;
            if not Insert() then;

            Init();
            "Pay Element Code" := 'OT';
            Description := 'Over Time';
            "Pay Slip Printing Caption" := 'OT';
            "Paid Category" := "Paid Category"::Monthly;
            "Pay Type" := "Pay Type"::Addition;
            "Fixed/Percent" := "Fixed/Percent"::Fixed;
            "Amount Calculation Type" := "Amount Calculation Type"::"Pay Day";
            "Base Pay Elements" := '';
            "Base Amount ( For % )" := 0;
            "Sorting Order" := 40;
            "Regular Element" := true;
            "All Grade" := true;
            "Predefined Code" := true;
            if not Insert() then;

            Init();
            "Pay Element Code" := 'MISC-EARN-01';
            Description := 'Misc Earnings-01';
            "Pay Slip Printing Caption" := 'MISC EARN-01';
            "Paid Category" := "Paid Category"::Monthly;
            "Pay Type" := "Pay Type"::Addition;
            "Fixed/Percent" := "Fixed/Percent"::Fixed;
            "Amount Calculation Type" := "Amount Calculation Type"::"Full Amount";
            "Sorting Order" := 50;
            "Regular Element" := false;
            "Variable Element" := true;
            "All Grade" := true;
            "Predefined Code" := true;
            if not Insert() then;

            Init();
            "Pay Element Code" := 'MISC-EARN-02';
            Description := 'Misc Earnings-02';
            "Pay Slip Printing Caption" := 'MISC EARN-02';
            "Paid Category" := "Paid Category"::Monthly;
            "Pay Type" := "Pay Type"::Addition;
            "Fixed/Percent" := "Fixed/Percent"::Fixed;
            "Amount Calculation Type" := "Amount Calculation Type"::"Full Amount";
            "Sorting Order" := 60;
            "Regular Element" := false;
            "Variable Element" := true;
            "All Grade" := true;
            "Predefined Code" := true;
            if not Insert() then;

            Init();
            "Pay Element Code" := 'BONUS';
            Description := 'Bonus Allowance';
            "Pay Slip Printing Caption" := 'BONUS';
            "Paid Category" := "Paid Category"::Yearly;
            "Pay Type" := "Pay Type"::Addition;
            "Fixed/Percent" := "Fixed/Percent"::Fixed;
            "Amount Calculation Type" := "Amount Calculation Type"::"Pay Day";
            "Sorting Order" := 100;
            "Regular Element" := true;
            "All Grade" := false;
            "Predefined Code" := false;
            if not Insert() then;

            Init();
            "Pay Element Code" := 'GRATUITY';
            Description := 'Gratuity';
            "Pay Slip Printing Caption" := 'GRATUITY';
            "Paid Category" := "Paid Category"::Yearly;
            "Pay Type" := "Pay Type"::Addition;
            "Fixed/Percent" := "Fixed/Percent"::Fixed;
            "Amount Calculation Type" := "Amount Calculation Type"::"Pay Day";
            "Sorting Order" := 110;
            "Regular Element" := true;
            "All Grade" := false;
            "Predefined Code" := false;
            if not Insert() then;

            Init();
            "Pay Element Code" := 'LTA';
            Description := 'Leave Travel Allowance';
            "Pay Slip Printing Caption" := 'LTA';
            "Paid Category" := "Paid Category"::Monthly;
            "Pay Type" := "Pay Type"::Reimbursement;
            "Fixed/Percent" := "Fixed/Percent"::Fixed;
            "Amount Calculation Type" := "Amount Calculation Type"::"Pay Day";
            "Sorting Order" := 200;
            "Regular Element" := true;
            "Variable Element" := true;
            "All Grade" := true;
            "Predefined Code" := true;
            if not Insert() then;

            Init();
            "Pay Element Code" := 'MEDICAL REIM';
            Description := 'Medical Reimbursement';
            "Pay Slip Printing Caption" := 'MEDICAL REIM';
            "Paid Category" := "Paid Category"::Monthly;
            "Pay Type" := "Pay Type"::Reimbursement;
            "Fixed/Percent" := "Fixed/Percent"::Fixed;
            "Amount Calculation Type" := "Amount Calculation Type"::"Pay Day";
            "Sorting Order" := 210;
            "Regular Element" := true;
            "Variable Element" := true;
            "All Grade" := true;
            "Predefined Code" := true;
            if not Insert() then;

            Init();
            "Pay Element Code" := 'ESI';
            Description := 'Employee State Insurance';
            "Pay Slip Printing Caption" := 'ESI';
            "Paid Category" := "Paid Category"::Monthly;
            "Pay Type" := "Pay Type"::Deduction;
            "Fixed/Percent" := "Fixed/Percent"::Fixed;
            "Amount Calculation Type" := "Amount Calculation Type"::"Pay Day";
            "Sorting Order" := 300;
            "Regular Element" := true;
            "All Grade" := true;
            "Predefined Code" := true;
            if not Insert() then;

            Init();
            "Pay Element Code" := 'PF';
            Description := 'Provident Fund';
            "Pay Slip Printing Caption" := 'PF';
            "Paid Category" := "Paid Category"::Monthly;
            "Pay Type" := "Pay Type"::Deduction;
            "Fixed/Percent" := "Fixed/Percent"::Fixed;
            "Amount Calculation Type" := "Amount Calculation Type"::"Pay Day";
            "Sorting Order" := 310;
            "Regular Element" := true;
            "All Grade" := true;
            "Predefined Code" := true;
            if not Insert() then;

            Init();
            "Pay Element Code" := 'PT';
            Description := 'Professional Tax';
            "Pay Slip Printing Caption" := 'PT';
            "Paid Category" := "Paid Category"::Monthly;
            "Pay Type" := "Pay Type"::Deduction;
            "Fixed/Percent" := "Fixed/Percent"::Fixed;
            "Amount Calculation Type" := "Amount Calculation Type"::"Pay Day";
            "Sorting Order" := 320;
            "Regular Element" := true;
            "All Grade" := true;
            "Predefined Code" := true;
            if not Insert() then;

            Init();
            "Pay Element Code" := 'TDS';
            Description := 'Tax Deducted at Source';
            "Pay Slip Printing Caption" := 'TDS';
            "Paid Category" := "Paid Category"::Monthly;
            "Pay Type" := "Pay Type"::Deduction;
            "Fixed/Percent" := "Fixed/Percent"::Fixed;
            "Amount Calculation Type" := "Amount Calculation Type"::"Pay Day";
            "Sorting Order" := 330;
            "Regular Element" := true;
            "All Grade" := true;
            "Predefined Code" := true;
            if not Insert() then;

            Init();
            "Pay Element Code" := 'LIC';
            Description := 'LIC';
            "Pay Slip Printing Caption" := 'LIC';
            "Paid Category" := "Paid Category"::Monthly;
            "Pay Type" := "Pay Type"::Deduction;
            "Fixed/Percent" := "Fixed/Percent"::Fixed;
            "Amount Calculation Type" := "Amount Calculation Type"::"Pay Day";
            "Sorting Order" := 340;
            "Regular Element" := true;
            "All Grade" := true;
            "Predefined Code" := true;
            if not Insert() then;

            Init();
            "Pay Element Code" := 'CANTEEN';
            Description := 'Canteen Deductions';
            "Pay Slip Printing Caption" := 'CANTEEN';
            "Paid Category" := "Paid Category"::Monthly;
            "Pay Type" := "Pay Type"::Deduction;
            "Fixed/Percent" := "Fixed/Percent"::Fixed;
            "Amount Calculation Type" := "Amount Calculation Type"::"Full Amount";
            "Sorting Order" := 400;
            "Regular Element" := false;
            "Variable Element" := true;
            "All Grade" := true;
            "Predefined Code" := true;
            if not Insert() then;

            Init();
            "Pay Element Code" := 'MISC-DEDU-01';
            Description := 'Misc Deduction-01';
            "Pay Slip Printing Caption" := 'MISC DEDU-01';
            "Paid Category" := "Paid Category"::Monthly;
            "Pay Type" := "Pay Type"::Deduction;
            "Fixed/Percent" := "Fixed/Percent"::Fixed;
            "Amount Calculation Type" := "Amount Calculation Type"::"Full Amount";
            "Sorting Order" := 410;
            "Regular Element" := false;
            "Variable Element" := true;
            "All Grade" := true;
            "Predefined Code" := true;
            if not Insert() then;

            Init();
            "Pay Element Code" := 'MISC-DEDU-02';
            Description := 'Misc Deduction-02';
            "Pay Slip Printing Caption" := 'MISC DEDU-02';
            "Paid Category" := "Paid Category"::Monthly;
            "Pay Type" := "Pay Type"::Deduction;
            "Fixed/Percent" := "Fixed/Percent"::Fixed;
            "Amount Calculation Type" := "Amount Calculation Type"::"Full Amount";
            "Sorting Order" := 420;
            "Regular Element" := false;
            "Variable Element" := true;
            "All Grade" := true;
            "Predefined Code" := true;
            if not Insert() then;

            Init();
            "Pay Element Code" := 'HLOAN';
            Description := 'Housing Loan';
            "Pay Slip Printing Caption" := 'HLOAN';
            "Paid Category" := "Paid Category"::Monthly;
            "Pay Type" := "Pay Type"::Deduction;
            "Fixed/Percent" := "Fixed/Percent"::Fixed;
            "Amount Calculation Type" := "Amount Calculation Type"::"Full Amount";
            "Base Pay Elements" := '';
            "Base Amount ( For % )" := 0;
            Amount := 50000.0;
            "Sorting Order" := 500;
            "Loan Element" := true;
            "All Grade" := true;
            "Predefined Code" := false;
            if not Insert() then;

            Init();
            "Pay Element Code" := 'VLOAN';
            Description := 'Vechicle Loan';
            "Pay Slip Printing Caption" := 'VEC LOAN';
            "Paid Category" := "Paid Category"::Monthly;
            "Pay Type" := "Pay Type"::Deduction;
            "Fixed/Percent" := "Fixed/Percent"::Fixed;
            "Amount Calculation Type" := "Amount Calculation Type"::"Full Amount";
            "Base Pay Elements" := '';
            "Base Amount ( For % )" := 0;
            Amount := 25000.0;
            "Sorting Order" := 510;
            "Loan Element" := true;
            "All Grade" := true;
            "Predefined Code" := false;
            if not Insert() then;
        end;
    end;


    procedure "Pay ESI Setup"()
    var
        ESISetup: Record "ESI Setup";
    begin
        with ESISetup do begin

            Init();
            "Effective Date" := 20080101D;
            "ESI Gross Salary Amount" := 10000;
            "ESI % ( Employee )" := 4.75;
            "ESI % ( Company )" := 1.75;
            "ESI Rounding Amount" := 0.5;
            "ESI Rounding Type" := "ESI Rounding Type"::Nearest;
            if not Insert() then;

        end
    end;


    procedure "Pay PF Setup"()
    var
        PFSetup: Record "PF Setup";
    begin
        with PFSetup do begin

            Init();
            "Effective Date" := 20080101D;
            "PF Gross Salary Limit" := 6500;
            "EPS Gross Salary Limit" := 6500;
            "Employee PF (Employee) %" := 12.0;
            "Employer PF (Company) %" := 3.67;
            "Employer EPS ( Company) %" := 8.33;
            "Employee VPF ( Employee) %" := 12.0;
            "PF Admin Charges %" := 1.1;
            "PF EDLI %" := 0.5;
            "PF RIFA %" := 0.01;
            "PF Rounding Amount" := 1.0;
            "PF Rounding Type" := "PF Rounding Type"::Nearest;

            if not Insert() then;

        end
    end;


    procedure "Pay PT Setup"()
    var
        PTSetup: Record "Professional Tax Header";
    begin
        with PTSetup do begin
            Init();
            "Effective Date" := 20080101D;
            "Branch Code" := 'TN';
            "Branch Name" := 'Tamil Nadu';
            if not Insert() then;
        end
    end;


    procedure "Pay Leave Setup"()
    var
        LVCode: Code[4];
    begin
        LVCode := '1M';

    end;

    procedure "Pay Business Posting Group"()
    var
        PayrollBusinessPostingGroup: Record "Payroll Business Posting Group";
    begin
        with PayrollBusinessPostingGroup do begin

            Init();
            Code := 'EMP';
            Description := 'Employee';

            if not Insert() then;
        end;
    end;


    procedure "Pay Product Posting Group"()
    var
        PayrollProductPostingGroup: Record "Payroll Product Posting Group";
    begin
        with PayrollProductPostingGroup do begin

            Init();
            Code := 'BASIC';
            Description := 'Basic';
            if not Insert() then;

            Init();
            Code := 'DA';
            Description := 'Dearness Allowance';
            if not Insert() then;

            Init();
            Code := 'ALLOWANCE';
            Description := 'Allowance';
            if not Insert() then;

            Init();
            Code := 'OT';
            Description := 'Over Time';
            if not Insert() then;

            Init();
            Code := 'BONUS';
            Description := 'Bonus';
            if not Insert() then;

            Init();
            Code := 'GRATUITY';
            Description := 'Gratuity';
            if not Insert() then;

            Init();
            Code := 'LTA';
            Description := 'Leave Travel Allowance';
            if not Insert() then;

            Init();
            Code := 'MEDICAL REIM';
            Description := 'Medical Reimburesment';
            if not Insert() then;

            Init();
            Code := 'ESI';
            Description := 'Employee State Insurance Corp.';
            if not Insert() then;

            Init();
            Code := 'PF';
            Description := 'Provident Fund';
            if not Insert() then;

            Init();
            Code := 'PT';
            Description := 'Professional Tax';
            if not Insert() then;

            Init();
            Code := 'TDS';
            Description := 'Tax Deducted at Source';
            if not Insert() then;

            Init();
            Code := 'LIC';
            Description := 'Life Insurance Co. Deduction';
            if not Insert() then;

            Init();
            Code := 'CANTEEN';
            Description := 'Canteen Deduction';
            if not Insert() then;

        end;
    end;


    procedure "Pay General Posting Group"()
    var
        PayrollGeneralPostingSetup: Record "Payroll General Posting Setup";
    begin
        with PayrollGeneralPostingSetup do begin

            Init();
            "Pay Bus.Posting Group" := 'EMP';
            "Pay Prod. Posting Group" := 'BASIC';
            "G/L Code" := '8720';

            if not Insert() then;

            Init();
            "Pay Bus.Posting Group" := 'EMP';
            "Pay Prod. Posting Group" := 'DA';
            "G/L Code" := '8720';

            if not Insert() then;

            Init();
            "Pay Bus.Posting Group" := 'EMP';
            "Pay Prod. Posting Group" := 'ALLOWANCE';
            "G/L Code" := '8720';

            if not Insert() then;

            Init();
            "Pay Bus.Posting Group" := 'EMP';
            "Pay Prod. Posting Group" := 'OT';
            "G/L Code" := '8720';

            if not Insert() then;

            Init();
            "Pay Bus.Posting Group" := 'EMP';
            "Pay Prod. Posting Group" := 'BONUS';
            "G/L Code" := '8720';

            if not Insert() then;

            Init();
            "Pay Bus.Posting Group" := 'EMP';
            "Pay Prod. Posting Group" := 'GRATUITY';
            "G/L Code" := '8720';

            if not Insert() then;

            Init();
            "Pay Bus.Posting Group" := 'EMP';
            "Pay Prod. Posting Group" := 'LTA';
            "G/L Code" := '8720';

            if not Insert() then;

            Init();
            "Pay Bus.Posting Group" := 'EMP';
            "Pay Prod. Posting Group" := 'MEDICAL REIM';
            "G/L Code" := '8720';

            if not Insert() then;

            Init();
            "Pay Bus.Posting Group" := 'EMP';
            "Pay Prod. Posting Group" := 'ESI';
            "G/L Code" := '8720';

            if not Insert() then;

            Init();
            "Pay Bus.Posting Group" := 'EMP';
            "Pay Prod. Posting Group" := 'PF';
            "G/L Code" := '8720';

            if not Insert() then;

            Init();
            "Pay Bus.Posting Group" := 'EMP';
            "Pay Prod. Posting Group" := 'PT';
            "G/L Code" := '8720';

            if not Insert() then;

            Init();
            "Pay Bus.Posting Group" := 'EMP';
            "Pay Prod. Posting Group" := 'TDS';
            "G/L Code" := '8720';

            if not Insert() then;

            Init();
            "Pay Bus.Posting Group" := 'EMP';
            "Pay Prod. Posting Group" := 'LIC';
            "G/L Code" := '8720';

            if not Insert() then;

            Init();
            "Pay Bus.Posting Group" := 'EMP';
            "Pay Prod. Posting Group" := 'CANTEEN';
            "G/L Code" := '8720';

            if not Insert() then;

        end;
    end;


    procedure "Pay Employee Posting Group"()
    var
        PayrollEmployeePostingGroup: Record "Payroll Employee Posting Group";
    begin
        with PayrollEmployeePostingGroup do begin

            Init();
            Code := 'STAFF';
            Description := 'Staff';
            "Salary Payable1 A/c" := '8720';
            "ESI Payable A/c" := '8720';
            "PF Payable A/c" := '8720';
            "EPS Payable A/c" := '8720';
            "PF Admin Charge Payable A/c" := '8720';
            "EDLI Payable A/c" := '8720';
            "RIFA Payable A/c" := '8720';
            "PT Payable A/c" := '8720';
            "TDS Payable A/c" := '8720';
            "Bonus Payable A/c" := '8720';
            "Arrear Salary Payable A/c" := '8720';
            "Loan Refundable A/c" := '8720';

            if not Insert() then;
        end;
    end;
}

