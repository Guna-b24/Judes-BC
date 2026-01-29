table 72061 Grades
{
    // -----------------------------------------------------------------------------------------------
    // Firstware Sofware Solutions : Project Name : HR & PAYROLL
    // -----------------------------------------------------------------------------------------------
    // No.  Date          Developer     Spec/CU/CR      Description
    // -----------------------------------------------------------------------------------------------
    // 1    04.APR.2009   RAJAH.A                       New Tables Added for Payroll Module.
    // -----------------------------------------------------------------------------------------------

    Caption = 'Grades';
    DataCaptionFields = "Location Code", "Salary Plan Code", "Grade Code", "Grade Name";
    DrillDownPageID = 72079;
    LookupPageID = 72079;

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
        field(3; "Grade Code"; Code[20])
        {
            Caption = 'Grade Code';
        }
        field(4; "Grade Name"; Text[50])
        {
            Caption = 'Grade Name';
        }
        field(5; "PF Applicable"; Boolean)
        {
            Caption = 'PF Applicable';
        }
        field(6; "EPS Applicable"; Boolean)
        {
            Caption = 'EPS Applicable';
        }
        field(7; "VPF Applicable"; Boolean)
        {
            Caption = 'VPF Applicable';
        }
        field(8; "ESI Applicable"; Boolean)
        {
            Caption = 'ESI Applicable';
        }
        field(9; "PT Applicable"; Boolean)
        {
            Caption = 'PT Applicable';
        }
        field(10; "LWF Applicable"; Boolean)
        {
            Caption = 'LWF Applicable';
        }
        field(11; "OT Applicable"; Boolean)
        {
            Caption = 'OT Applicable';
        }
        field(12; "Leave Encashment Applicable"; Boolean)
        {
            Caption = 'Leave Encashment Applicable';
        }
        field(13; "Bonus Applicable"; Boolean)
        {
            Caption = 'Bonus Applicable';
        }
        field(14; "Gratuity Applicable"; Boolean)
        {
            Caption = 'Gratuity Applicable';
        }
        field(15; Probationary; Boolean)
        {
            Caption = 'Probationary';
        }
        field(16; "PT Branch Code"; Code[20])
        {
            Caption = 'PT Branch Code';
            TableRelation = "Professional Tax Header";
        }
        field(17; "Over Time Multiplier"; Decimal)
        {
            Caption = 'Over Time Multiplier';
        }
        field(18; "Employee VPF ( Employee) %"; Decimal)
        {
            Caption = 'Employee VPF ( Employee) %';
        }
        field(19; "Scale of Pay"; Text[50])
        {
            Caption = 'Scale of Pay';
        }
    }

    keys
    {
        key(Key1; "Grade Code", "Location Code", "Salary Plan Code")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    trigger OnDelete()
    begin
        if Confirm('Are Sure to Delete the Records <Yes/No> Delete All Lines..!!') then begin
            GradesElements.Reset;
            GradesElements.SetRange("Location Code", "Location Code");
            GradesElements.SetRange("Salary Plan Code", "Salary Plan Code");
            GradesElements.SetRange("Grade Code", "Grade Code");
            if GradesElements.FindFirst then begin
                GradesElements.LockTable;
                GradesElements.DeleteAll;
            end;
        end;
    end;

    var
        GradesElements: Record "Grades Elements";
}

