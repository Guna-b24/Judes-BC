table 72061 Grades
{
    Caption = 'Grades';
    DataCaptionFields = "Location Code", "Salary Plan Code", "Grade Code", "Grade Name";
    DataClassification = SystemMetadata;
    DrillDownPageID = "Grades List";
    LookupPageID = "Grades List";

    fields
    {
        field(1; "Location Code"; Code[20])
        {
            Caption = 'Location Code';
            TableRelation = "Location HR & Payroll Setup";
            DataClassification = SystemMetadata;
            ToolTip = 'Specifies the location code for which the grade is defined.';
        }
        field(2; "Salary Plan Code"; Code[20])
        {
            Caption = 'Salary Plan Code';
            TableRelation = "Salary Plan";
            DataClassification = SystemMetadata;
            ToolTip = 'Specifies the salary plan associated with this grade.';
        }
        field(3; "Grade Code"; Code[20])
        {
            Caption = 'Grade Code';
            DataClassification = SystemMetadata;
            ToolTip = 'Specifies the unique code of the grade.';
        }
        field(4; "Grade Name"; Text[50])
        {
            Caption = 'Grade Name';
            DataClassification = SystemMetadata;
            ToolTip = 'Specifies the descriptive name of the grade.';
        }
        field(5; "PF Applicable"; Boolean)
        {
            Caption = 'PF Applicable';
            DataClassification = CustomerContent;
            ToolTip = 'Specifies whether Provident Fund is applicable for this grade.';
        }
        field(6; "EPS Applicable"; Boolean)
        {
            Caption = 'EPS Applicable';
            DataClassification = CustomerContent;
            ToolTip = 'Specifies whether Employee Pension Scheme is applicable for this grade.';
        }
        field(7; "VPF Applicable"; Boolean)
        {
            Caption = 'VPF Applicable';
            DataClassification = CustomerContent;
            ToolTip = 'Specifies whether Voluntary Provident Fund is applicable for this grade.';
        }
        field(8; "ESI Applicable"; Boolean)
        {
            Caption = 'ESI Applicable';
            DataClassification = CustomerContent;
            ToolTip = 'Specifies whether Employee State Insurance is applicable for this grade.';
        }
        field(9; "PT Applicable"; Boolean)
        {
            Caption = 'PT Applicable';
            DataClassification = CustomerContent;
            ToolTip = 'Specifies whether Professional Tax is applicable for this grade.';
        }
        field(10; "LWF Applicable"; Boolean)
        {
            Caption = 'LWF Applicable';
            DataClassification = CustomerContent;
            ToolTip = 'Specifies whether Labour Welfare Fund is applicable for this grade.';
        }
        field(11; "OT Applicable"; Boolean)
        {
            Caption = 'OT Applicable';
            DataClassification = CustomerContent;
            ToolTip = 'Specifies whether overtime is applicable for this grade.';
        }
        field(12; "Leave Encashment Applicable"; Boolean)
        {
            Caption = 'Leave Encashment Applicable';
            DataClassification = CustomerContent;
            ToolTip = 'Specifies whether leave encashment is applicable for this grade.';
        }
        field(13; "Bonus Applicable"; Boolean)
        {
            Caption = 'Bonus Applicable';
            DataClassification = CustomerContent;
            ToolTip = 'Specifies whether bonus is applicable for this grade.';
        }
        field(14; "Gratuity Applicable"; Boolean)
        {
            Caption = 'Gratuity Applicable';
            DataClassification = CustomerContent;
            ToolTip = 'Specifies whether gratuity is applicable for this grade.';
        }
        field(15; Probationary; Boolean)
        {
            Caption = 'Probationary';
            DataClassification = CustomerContent;
            ToolTip = 'Specifies whether this grade is probationary.';
        }
        field(16; "PT Branch Code"; Code[20])
        {
            Caption = 'PT Branch Code';
            TableRelation = "Professional Tax Header";
            DataClassification = SystemMetadata;
            ToolTip = 'Specifies the professional tax branch code applicable for this grade.';
        }
        field(17; "Over Time Multiplier"; Decimal)
        {
            Caption = 'Over Time Multiplier';
            DataClassification = CustomerContent;
            ToolTip = 'Specifies the overtime calculation multiplier for this grade.';
        }
        field(18; "Employee VPF ( Employee) %"; Decimal)
        {
            Caption = 'Employee VPF ( Employee) %';
            DataClassification = CustomerContent;
            ToolTip = 'Specifies the employee voluntary provident fund percentage.';
        }
        field(19; "Scale of Pay"; Text[50])
        {
            Caption = 'Scale of Pay';
            DataClassification = CustomerContent;
            ToolTip = 'Specifies the scale of pay for this grade.';
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
            GradesElements.Reset();
            GradesElements.SetRange("Location Code", "Location Code");
            GradesElements.SetRange("Salary Plan Code", "Salary Plan Code");
            GradesElements.SetRange("Grade Code", "Grade Code");
            if GradesElements.FindFirst() then begin
                GradesElements.LockTable();
                GradesElements.DeleteAll();
            end;
        end;
    end;

    var
        GradesElements: Record "Grades Elements";
}

