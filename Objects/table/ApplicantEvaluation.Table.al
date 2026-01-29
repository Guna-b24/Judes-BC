table 71009 "Applicant Evaluation"
{
    //   No   Date      Sign     Trigger                       Description
    // -----------------------------------------------------------------------------------------------
    //   01  19/10/09  VANDHANA  OnInsert                     Code to assign User ID.
    //   02  24/11/09  VIGNESH   Mark Obtained - OnValidate()  Code added to validate mark Obtained

    Caption = 'Applicant Evaluation';

    fields
    {
        field(1; "Application No."; Code[20])
        {
            Caption = 'Application No.';
        }
        field(2; "Evaluation Method Code"; Code[20])
        {
            Caption = 'Evaluation Method Code';
            TableRelation = "Evaluation Method";
        }
        field(3; Desription; Text[30])
        {
            Caption = 'Desription';
        }
        field(4; "Mark Obtained"; Decimal)
        {
            Caption = 'Mark Obtained';

            trigger OnValidate()
            begin
                // Start 02.VIGNESH
                if "Maximum Mark" <> 0 then begin
                    if "Mark Obtained" > "Maximum Mark" then
                        Error(Text000, "Maximum Mark")
                    else
                        "Attendance Status" := "Attendance Status"::Present;
                end else
                    Error(Text001);
                // Stop 02.VIGNESH
            end;
        }
        field(5; "Attendance Status"; Option)
        {
            Caption = 'Attendance Status';
            OptionCaption = ' ,Present,Absent';
            OptionMembers = " ",Present,Absent;
        }
        field(6; "Maximum Mark"; Decimal)
        {
            Caption = 'Maximum Mark';
        }
        field(7; "Pass Mark"; Decimal)
        {
            Caption = 'Pass Mark';
        }
        field(8; "Evaluation No."; Code[10])
        {
            Caption = 'Evaluation No.';
        }
        field(9; Weightage; Decimal)
        {
            Caption = 'Weightage';
        }
        field(10; "Applicant Name"; Text[80])
        {
            Caption = 'Applicant Name';
        }
        field(11; Class; Code[10])
        {
        }
        field(70120; "User ID"; Code[20])
        {
            Caption = 'User ID';
        }
        field(70121; "Portal ID"; Code[20])
        {
            Caption = 'Portal ID';
        }
    }

    keys
    {
        key(Key1; "Application No.", "Evaluation Method Code")
        {
            Clustered = true;
        }
        key(Key2; "Evaluation No.")
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    begin
        // Start 01. VANDHANA

        "User ID" := UserId;

        // Stop 01. VANDHANA
    end;

    var
        Text000: Label 'Maximum mark that you can enter is %1.';
        Text001: Label 'Maximum mark is zero.';
}

