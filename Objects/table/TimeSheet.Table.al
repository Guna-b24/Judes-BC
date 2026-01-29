table 72081 "Time Sheet"
{
    // -----------------------------------------------------------------------------------------------
    // Firstware Sofware Solutions : Project Name : HR & PAYROLL
    // -----------------------------------------------------------------------------------------------
    // No.  Date          Developer     Spec/CU/CR      Description
    // -----------------------------------------------------------------------------------------------
    // 1    04.APR.2009   RAJAH.A                       New Tables Added for Payroll Module.
    // -----------------------------------------------------------------------------------------------

    Caption = 'Time Sheet';
    DataCaptionFields = "Location Code", "Salary Plan Code", "Employee No";
    DrillDownPageID = 72113;
    LookupPageID = 72113;

    fields
    {
        field(1; "Location Code"; Code[20])
        {
            Caption = 'Location Code';
            TableRelation = "Location HR & Payroll Setup";
        }
        field(2; "Salary Plan Code"; Code[20])
        {
            Caption = 'Salary Plan Code';
            TableRelation = "Salary Plan";
        }
        field(3; "Employee No"; Code[20])
        {
            Caption = 'Employee No';
            NotBlank = true;
            TableRelation = Employee;
        }
        field(4; "Attend Date"; Date)
        {
            Caption = 'Attend Date';
            NotBlank = true;
        }
        field(5; "Line No"; Integer)
        {
            Caption = 'Line No';
        }
        field(6; "Time From"; Time)
        {
            Caption = 'Time From';
            NotBlank = true;

            trigger OnValidate()
            begin
                if "Time From" = 0T then begin
                    "Time To" := 0T;
                    "Total Hours" := 0;
                end;
            end;
        }
        field(7; "Time To"; Time)
        {
            BlankNumbers = BlankZero;
            Caption = 'Time To';
            NotBlank = true;

            trigger OnValidate()
            begin
                "Total Hours" := TotalHours("Time From", "Time To");
            end;
        }
        field(8; "Total Hours"; Decimal)
        {
            Caption = 'Total Hours';
            Editable = false;
        }
        field(9; "Name of the Task"; Text[50])
        {
            Caption = 'Name of the Task';
        }
        field(10; Completed; Boolean)
        {
            Caption = 'Completed';
        }
    }

    keys
    {
        key(Key1; "Location Code", "Salary Plan Code", "Employee No", "Attend Date", "Line No")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    [Scope('Internal')]
    procedure TotalHours(InTime: Time; OutTime: Time) TotalHours: Decimal
    var
        StartDateTime: DateTime;
        EndDateTime: DateTime;
        Day: Date;
        CheckTime: Time;
    begin
        Clear(CheckTime);
        Clear(Day);
        Clear(StartDateTime);
        Clear(EndDateTime);

        if (InTime <> 0T) and (OutTime <> 0T) then begin
            CheckTime := 130000T;
            Day := Today;

            if (InTime > CheckTime) and (OutTime < CheckTime) then begin
                StartDateTime := CreateDateTime(Day, InTime);
                EndDateTime := CreateDateTime((Day + 1), OutTime);
                TotalHours := Abs((StartDateTime - EndDateTime) / 3600000);
            end else
                TotalHours := Abs((InTime - OutTime) / 3600000);
        end;

        if (InTime = 0T) and (OutTime = 0T) then
            TotalHours := 0;
    end;
}

