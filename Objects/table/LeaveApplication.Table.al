table 72083 "Leave Application"
{
    // -----------------------------------------------------------------------------------------------
    // Firstware Sofware Solutions : Project Name : HR & PAYROLL
    // -----------------------------------------------------------------------------------------------
    // No.  Date          Developer     Spec/CU/CR      Description
    // -----------------------------------------------------------------------------------------------
    // 1    04.APR.2009   RAJAH.A                       New Tables Added for Payroll Module.
    // -----------------------------------------------------------------------------------------------

    Caption = 'Leave Application';
    DataCaptionFields = "Leave Requsition No.", "Application Date", "Employee No.", Name;
    DrillDownPageID = 72149;
    LookupPageID = 72149;

    fields
    {
        field(1; "Leave Requsition No."; Code[20])
        {
            Caption = 'Leave Requsition No.';

            trigger OnValidate()
            begin
                if "Leave Requsition No." <> xRec."Leave Requsition No." then begin
                    HRPayrollSetup.Get(UserId);
                    LocationHRPayrollSetup.Get(HRPayrollSetup."Location Code");
                    NoSeriesMgt.TestManual(LocationHRPayrollSetup."Leave No.");
                    "No. Series" := '';
                end;
            end;
        }
        field(2; "Application Date"; Date)
        {
            Caption = 'Application Date';
            Editable = false;
        }
        field(3; "No. Series"; Code[20])
        {
            Caption = 'No. Series';
        }
        field(4; "Application Type"; Option)
        {
            Caption = 'Application Type';
            OptionCaption = 'Leave Application,Cancellation Application';
            OptionMembers = "Leave Application","Cancellation Application";
        }
        field(5; "Employee No."; Code[20])
        {
            Caption = 'Employee No.';
            TableRelation = Employee;

            trigger OnValidate()
            begin
                Employee.Get("Employee No.");
                Name := Employee."First Name" + ' ' + Employee.Initials;
                Designation := Employee."Job Title";
            end;
        }
        field(6; Name; Text[50])
        {
            Caption = 'Name';
            Editable = false;
        }
        field(7; Designation; Text[50])
        {
            Caption = 'Designation';
            Editable = false;
        }
        field(8; "From Date"; Date)
        {
            Caption = 'From Date';
            NotBlank = true;

            trigger OnValidate()
            begin
                "To Date" := "From Date";
                Validate("To Date");
                "Application Date" := "From Date";
                "Recommending Date" := "From Date";
                "Sanctioning Date" := "From Date";
                Reason := 'Personal Work';
                //"Recommending Authority" := 'AANAND.M';
                //"Sanctioning Authority" := 'AANAND.M';
            end;
        }
        field(9; "To Date"; Date)
        {
            Caption = 'To Date';
            NotBlank = true;

            trigger OnValidate()
            begin
                if "To Date" < "From Date" then
                    Error(Text0004);

                "No.of.Days" := ("To Date" - "From Date") + 1;

                if "No.of.Days" > 1 then begin
                    "First Half Day" := false;
                    "Second Half Day" := false;
                end;

                if "No.of.Days" >= 1 then
                    "Full Day" := true;

                if "No.of.Days" = 1 then
                    if "First Half Day" or "Second Half Day" then
                        "No.of.Days" := 1 - 0.5;
            end;
        }
        field(10; "Leave Code"; Code[20])
        {
            Caption = 'Leave Code';
        }
        field(11; "Full Day"; Boolean)
        {
            Caption = 'Full Day';

            trigger OnValidate()
            begin
                if "No.of.Days" > 1 then begin
                    "First Half Day" := false;
                    "Second Half Day" := false;
                end;

                if "Full Day" then begin
                    "First Half Day" := false;
                    "Second Half Day" := false;
                end;

                Validate("From Date");
                Validate("To Date");
            end;
        }
        field(12; "First Half Day"; Boolean)
        {
            Caption = 'First Half Day';

            trigger OnValidate()
            begin
                Validate("From Date");
                Validate("To Date");

                if "No.of.Days" > 1 then begin
                    "First Half Day" := false;
                    "Second Half Day" := false;
                end;

                if "First Half Day" then begin
                    "Full Day" := false;
                    "Second Half Day" := false;
                end;
            end;
        }
        field(13; "Second Half Day"; Boolean)
        {
            Caption = 'Second Half Day';

            trigger OnValidate()
            begin
                Validate("From Date");
                Validate("To Date");

                if "No.of.Days" > 1 then begin
                    "First Half Day" := false;
                    "Second Half Day" := false;
                end;

                if "Second Half Day" then begin
                    "First Half Day" := false;
                    "Full Day" := false;
                end;
            end;
        }
        field(14; "Leave Balance"; Decimal)
        {
            Caption = 'Leave Balance';
            Editable = false;
        }
        field(15; "No.of.Days"; Decimal)
        {
            Caption = 'No.of.Days';
            Editable = false;
        }
        field(16; Reason; Text[50])
        {
            Caption = 'Reason';
        }
        field(17; Status; Option)
        {
            Caption = 'Status';
            OptionCaption = 'Created,Request,Open,Canceled,Rejected,Approved,Closed';
            OptionMembers = Created,Request,Open,Canceled,Rejected,Approved,Closed;
        }
        field(18; "Recommending Authority"; Text[50])
        {
            Caption = 'Recommending Authority';
            TableRelation = Employee;

            trigger OnLookup()
            begin
                if PAGE.RunModal(0, Employee) = ACTION::LookupOK then
                    "Recommending Authority" := Employee."First Name";
            end;
        }
        field(19; "Recommending Date"; Date)
        {
            Caption = 'Recommending Date';

            trigger OnValidate()
            begin
                if "Recommending Date" < "Application Date" then
                    Error(Text0005);
            end;
        }
        field(20; "Recommending Status"; Option)
        {
            Caption = 'Recommending Status';
            OptionCaption = 'Recommended,Not Recommended';
            OptionMembers = Recommended,"Not Recommended";
        }
        field(21; "Sanctioning Authority"; Text[50])
        {
            Caption = 'Sanctioning Authority';
            TableRelation = Employee;

            trigger OnLookup()
            begin
                if PAGE.RunModal(0, Employee) = ACTION::LookupOK then
                    "Sanctioning Authority" := Employee."First Name";
            end;
        }
        field(22; "Sanctioning Date"; Date)
        {
            Caption = 'Sanctioning Date';

            trigger OnValidate()
            begin
                //IF "Sanctioning Date" < "Application Date" THEN
                //  ERROR(Text0005);
            end;
        }
        field(23; "Sanctioning Status"; Option)
        {
            Caption = 'Sanctioning Status';
            OptionCaption = 'Sanctioned,Not Sanctioned';
            OptionMembers = Sanctioned,"Not Sanctioned";
        }
        field(24; "Cancellation Date"; Date)
        {
            Caption = 'Cancellation Date';
        }
        field(25; "Creator User ID"; Code[20])
        {
            Caption = 'Creator User ID';
            Editable = false;
        }
        field(26; "Creator Date Time"; DateTime)
        {
            Caption = 'Creator Date Time';
            Editable = false;
        }
        field(27; Processed; Boolean)
        {
            Caption = 'Processed';
            Editable = false;
        }
        field(28; "Location Code"; Code[20])
        {
            Caption = 'Location Code';
            TableRelation = "Location HR & Payroll Setup";
        }
        field(29; "Salary Plan Code"; Code[20])
        {
            Caption = 'Salary Plan Code';
            TableRelation = "Salary Plan";
        }
        field(30; "Leave Year Code"; Code[20])
        {
            TableRelation = "Payroll Year"."Year Code" WHERE ("Location Code" = FIELD ("Location Code"),
                                                              "Salary Plan Code" = FIELD ("Salary Plan Code"),
                                                              "Year Code" = FIELD ("Leave Year Code"));
        }
        field(31; "Academic Year"; Code[20])
        {
        }
    }

    keys
    {
        key(Key1; "Leave Requsition No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    trigger OnDelete()
    begin
        //IF (Status <> Status::Created) THEN
        //    ERROR('You cannot delete Leave Application');
    end;

    trigger OnInsert()
    begin
        if "Leave Requsition No." = '' then begin
            HRPayrollSetup.Get(UserId);
            LocationHRPayrollSetup.Get(HRPayrollSetup."Location Code");
            LocationHRPayrollSetup.TestField("Leave No.");
            NoSeriesMgt.InitSeries(LocationHRPayrollSetup."Leave No.", xRec."No. Series", 0D, "Leave Requsition No.", "No. Series");
        end;

        "Application Date" := Today;
        "Creator User ID" := UserId;
        "Creator Date Time" := CurrentDateTime;
    end;

    trigger OnRename()
    begin
        Error('You cannot Rename the Leave Application');
    end;

    var
        HRPayrollSetup: Record "HR & Payroll Setup";
        LocationHRPayrollSetup: Record "Location HR & Payroll Setup";
        Employee: Record Employee;
        NoSeriesMgt: Codeunit NoSeriesManagement;
        Text0001: Label 'Sanction Incharge Should not Same Person';
        Text0002: Label 'This Leave is cancelled, You can not do any modifications.';
        Text0003: Label 'Processing is done, You cannot cancel these leaves.';
        Text0004: Label 'The Leave End Date Should not Lesserthan the Leave Start Date';
        Text0005: Label 'Leave Approval Date Should not Lesserthan the Leave Application Date';
        LeaveBalance: Record "Leave Entitlement";
        LeaveApplication: Record "Leave Application";

    [Scope('Internal')]
    procedure AssistEdit(OldLeaveApplication: Record "Leave Application"): Boolean
    var
        LeaveApplication: Record "Leave Application";
    begin
        with LeaveApplication do begin
            LeaveApplication := Rec;
            HRPayrollSetup.Get(UserId);
            LocationHRPayrollSetup.Get(HRPayrollSetup."Location Code");
            LocationHRPayrollSetup.TestField("Leave No.");
            if NoSeriesMgt.SelectSeries(LocationHRPayrollSetup."Leave No.", OldLeaveApplication."No. Series", "No. Series") then begin
                NoSeriesMgt.SetSeries("Leave Requsition No.");
                Rec := LeaveApplication;
                exit(true);
            end;
        end;
    end;

    [Scope('Internal')]
    procedure "Leave Batch Posting"(LeaveRequestNo: Code[20])
    begin
        LeaveApplication.Reset;

        if LeaveRequestNo <> 'ALL' then
            LeaveApplication.SetRange("Leave Requsition No.", LeaveRequestNo);
        LeaveApplication.SetRange(Status, LeaveApplication.Status::Created);
        if LeaveApplication.FindFirst then begin
            repeat
                "Daily Attendance Update"(LeaveApplication);
            until LeaveApplication.Next = 0;
        end;
    end;

    [Scope('Internal')]
    procedure "Daily Attendance Update"(LeaveApplication1: Record "Leave Application")
    var
        DailyAttendance: Record "Daily Attendance";
        LeaveMaster: Record "Leave Master";
    begin
        DailyAttendance.Reset;
        DailyAttendance.SetRange("Location Code", LeaveApplication1."Location Code");
        DailyAttendance.SetRange("Salary Plan Code", LeaveApplication1."Salary Plan Code");
        DailyAttendance.SetRange("Employee No", LeaveApplication1."Employee No.");
        DailyAttendance.SetRange("Attendance Date", LeaveApplication1."From Date", LeaveApplication1."To Date");
        if DailyAttendance.Find('-') then begin
            repeat

                //     IF (DailyAttendance."Leave Code" = '') AND (DailyAttendance."Non Working Day" = FALSE) THEN
                if (DailyAttendance."Leave Code" = '') then
                    if LeaveApplication1."Application Type" = LeaveApplication1."Application Type"::"Leave Application" then begin
                        DailyAttendance."In Time" := 0T;
                        DailyAttendance."Out Time" := 0T;
                        DailyAttendance."Hours Worked" := 0;
                        LeaveApplication1.TestField("Leave Code");
                        LeaveMaster.Get(LeaveApplication1."Leave Code", LeaveApplication1."Location Code",
                                        LeaveApplication1."Salary Plan Code");

                        if LeaveApplication1."Full Day" then begin
                            DailyAttendance."First Half Attendance Type" := LeaveMaster."Mark As Full Day First Half";
                            DailyAttendance."Second Half Attendance Type" := LeaveMaster."Mark As Full Day Secod Half";
                            DailyAttendance."Leave Type" := DailyAttendance."Leave Type"::"Full Day";
                        end;

                        if LeaveApplication1."First Half Day" then begin
                            DailyAttendance."First Half Attendance Type" := LeaveMaster."I'st Mark As First Half Day";
                            DailyAttendance."Second Half Attendance Type" := LeaveMaster."I'st Mark As Second Half Day";
                            DailyAttendance."Leave Type" := DailyAttendance."Leave Type"::"First Half Day";
                        end;

                        if LeaveApplication1."Second Half Day" then begin
                            DailyAttendance."First Half Attendance Type" := LeaveMaster."II'nd Mark As First Half Day";
                            DailyAttendance."Second Half Attendance Type" := LeaveMaster."II'nd Mark As Second Half Day";
                            DailyAttendance."Leave Type" := DailyAttendance."Leave Type"::"Second Half Day";
                        end;
                        DailyAttendance."Leave Code" := LeaveApplication1."Leave Code";
                        DailyAttendance."Manual Entry" := true;
                    end;

                if DailyAttendance."Leave Code" <> '' then
                    if LeaveApplication1."Application Type" = LeaveApplication1."Application Type"::"Cancellation Application" then begin
                        if LocationHRPayrollSetup."Default Attendance Type" in [LocationHRPayrollSetup."Default Attendance Type"::" ",
                                                                                LocationHRPayrollSetup."Default Attendance Type"::Absent] then begin
                            DailyAttendance."In Time" := 0T;
                            DailyAttendance."Out Time" := 0T;
                        end;

                        if LocationHRPayrollSetup."Default Attendance Type" = LocationHRPayrollSetup."Default Attendance Type"::Present then begin
                            DailyAttendance."In Time" := DailyAttendance."Actual Time In";
                            DailyAttendance."Out Time" := DailyAttendance."Actual Time Out";
                        end;

                        DailyAttendance."Leave Code" := '';
                        DailyAttendance."Manual Entry" := false;
                        DailyAttendance."Leave Type" := DailyAttendance."Leave Type"::" ";
                        DailyAttendance.Validate("In Time");
                        DailyAttendance.Validate("Out Time");
                    end;

                DailyAttendance."Leave Application No" := LeaveApplication1."Leave Requsition No.";
                DailyAttendance.Validate("Leave Type");
                DailyAttendance.Validate("First Half Attendance Type");
                DailyAttendance.Validate("Second Half Attendance Type");

                DailyAttendance.Modify;

            until DailyAttendance.Next = 0;

            LeaveApplication1.Status := LeaveApplication1.Status::Approved;
            LeaveApplication1.Processed := true;
            LeaveApplication1.Modify;

            LeaveBalance.Reset;
            LeaveBalance.SetRange("Location Code", LeaveApplication1."Location Code");
            LeaveBalance.SetRange("Salary Plan Code", LeaveApplication1."Salary Plan Code");
            LeaveBalance.SetRange("Leave Code", LeaveApplication1."Leave Code");
            LeaveBalance.SetRange("Employee No", LeaveApplication1."Employee No.");
            if LeaveBalance.Find('-') then
                repeat
                    LeaveBalance.Validate("Leave Opening Balance");
                    LeaveBalance.Modify;
                until LeaveBalance.Next = 0;

        end;
    end;
}

