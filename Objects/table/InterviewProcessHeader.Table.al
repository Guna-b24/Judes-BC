table 72016 "Interview Process Header"
{
    // -----------------------------------------------------------------------------------------------
    // Firstware Sofware Solutions : Project Name : HR & PAYROLL
    // -----------------------------------------------------------------------------------------------
    // No.  Date          Developer     Spec/CU/CR      Description
    // -----------------------------------------------------------------------------------------------
    // 1    04.APR.2009   SENTHIL                       New Tables Added for HR Module.

    Caption = 'Interview Process Header';
    DataCaptionFields = No;
    DrillDownPageID = 72025;
    LookupPageID = 72025;

    fields
    {
        field(1; No; Code[20])
        {
            Caption = 'No';

            trigger OnValidate()
            begin
                if No <> xRec.No then begin
                    HRSetup.Get;
                    NoSeriesMgt.TestManual(HRSetup."Interview SNo");
                    "No. Series" := '';
                end;
            end;
        }
        field(2; "Resume No"; Code[20])
        {
            Caption = 'Resume No';
        }
        field(3; Name; Text[30])
        {
            Caption = 'Name';
        }
        field(4; "Designation Code"; Code[10])
        {
            Caption = 'Designation Code';
        }
        field(5; "Designation Description"; Text[30])
        {
            Caption = 'Designation Description';
        }
        field(6; "Department Code"; Code[10])
        {
            Caption = 'Department Code';
        }
        field(7; "Department Description"; Text[30])
        {
            Caption = 'Department Description';
        }
        field(8; "Indenting No"; Code[20])
        {
            Caption = 'Indenting No';
        }
        field(9; "Schedule Date"; Date)
        {
            Caption = 'Schedule Date';
        }
        field(10; "Schedule Time From"; Time)
        {
            Caption = 'Schedule Time From';
        }
        field(11; "Schedule to Time"; Time)
        {
            Caption = 'Schedule to Time';

            trigger OnValidate()
            begin
                if "Schedule Time From" < "Schedule Time From" then
                    Error('enter the Proper Time');
            end;
        }
        field(12; "Actual Date"; Date)
        {
            Caption = 'Actual Date';

            trigger OnValidate()
            begin
                if "Actual Date" < "Schedule Date" then
                    Error('Enter the Proper Date');
            end;
        }
        field(13; "Actual Time From"; Time)
        {
            Caption = 'Actual Time From';
        }
        field(14; "Actual To Time"; Time)
        {
            Caption = 'Actual To Time';

            trigger OnValidate()
            begin
                if "Actual Time From" < "Actual To Time" then
                    Error('enter the Proper Time');
            end;
        }
        field(15; "Current CTC"; Decimal)
        {
            Caption = 'Current CTC';
        }
        field(16; "Expected CTC"; Decimal)
        {
            Caption = 'Expected CTC';
        }
        field(17; "CTC Offer"; Decimal)
        {
            Caption = 'CTC Offer';
        }
        field(18; "Current Status"; Text[30])
        {
            Caption = 'Current Status';
            Editable = false;
        }
        field(19; "Final Status"; Option)
        {
            Caption = 'Final Status';
            OptionCaption = 'Inprocess,Reject,On Hold,Offer,Joined';
            OptionMembers = Inprocess,Reject,"On Hold",Offer,Joined;
        }
        field(20; Remarks; Text[50])
        {
            Caption = 'Remarks';
        }
        field(21; "No. Series"; Code[10])
        {
            Caption = 'No. Series';
        }
        field(22; "Attachment 1"; Text[100])
        {
            Caption = 'Attachment 1';
        }
        field(23; "Attachment 2"; Text[100])
        {
            Caption = 'Attachment 2';
        }
        field(24; Comment; Boolean)
        {
            CalcFormula = Exist ("Human Resource Comment Line" WHERE ("Table Name" = CONST ("10"),
                                                                     "No." = FIELD (No)));
            Caption = 'Comment';
            Editable = false;
            FieldClass = FlowField;
        }
        field(25; Interview; Option)
        {
            Caption = 'Interview';
            OptionCaption = 'Phone,Letter';
            OptionMembers = Phone,Letter;
        }
    }

    keys
    {
        key(Key1; No)
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    begin
        if No = '' then begin
            HRSetup.Get;
            HRSetup.TestField("Interview SNo");
            NoSeriesMgt.InitSeries(HRSetup."Interview SNo", xRec."No. Series", 0D, No, "No. Series");
        end;
    end;

    var
        HRSetup: Record "HR Setup";
        NoSeriesMgt: Codeunit NoSeriesManagement;

    [Scope('Internal')]
    procedure AssistEdit(InterviewProcessHeader: Record "Interview Process Header"): Boolean
    begin
        with InterviewProcessHeader do begin
            InterviewProcessHeader := Rec;
            HRSetup.Get;
            HRSetup.TestField("Interview SNo");
            if NoSeriesMgt.SelectSeries(HRSetup."Interview SNo", "No. Series", "No. Series") then begin
                HRSetup.Get;
                HRSetup.TestField("Interview SNo");
                NoSeriesMgt.SetSeries(No);
                Rec := InterviewProcessHeader;
                exit(true);
            end;
        end;
    end;
}

