table 71003 "Application Mark"
{
    //   No   Date      Sign     Trigger                     Description
    // -----------------------------------------------------------------------------------------------
    //   01  21/09/09  KATHIR    PreQualification Code        Code Added to Get PreQualification description
    //                           OnValidate()
    //   02  22/09/09  KATHIR    Mark Obtained - OnValidate() Code Added to Validate Marks Obtained
    //   03  22/09/09  KATHIR    Maximum - OnValidate()       Code Added to Validate Marks Obtained
    //   04  19/10/09  VANDHANA  OnInsert                     Code to assign User ID.

    Caption = 'Application Mark';

    fields
    {
        field(1; "Application No"; Code[20])
        {
            Caption = 'Application No';
        }
        field(2; Description; Text[50])
        {
            Caption = 'Description';
        }
        field(3; "Mark Obtained"; Decimal)
        {
            BlankZero = true;
            Caption = 'Mark Obtained';

            trigger OnValidate()
            begin
                // Start 02.KATHIR
                if Maximum < "Mark Obtained" then begin
                    Message(Text000);
                    "Mark Obtained" := 0;
                end
                // Stop 02.KATHIR
            end;
        }
        field(4; Maximum; Decimal)
        {
            BlankZero = true;
            Caption = 'Maximum';

            trigger OnValidate()
            begin
                // Start 03.KATHIR
                if Maximum < "Mark Obtained" then begin
                    Message(Text000);
                    "Mark Obtained" := 0;
                end
                // Stop 03.KATHIR
            end;
        }
        field(5; Month; Option)
        {
            Caption = 'Month';
            OptionCaption = ' ,January,February,March,April,May,June,July,August,September,October,November,December';
            OptionMembers = " ",January,February,March,April,May,June,July,August,September,October,November,December;
        }
        field(6; "Year of passing"; Integer)
        {
            BlankZero = true;
            Caption = 'Year of passing';
        }
        field(7; "Register Number"; Code[20])
        {
            Caption = 'Register Number';
        }
        field(8; "Exam Code"; Code[20])
        {
            Caption = 'Exam Code';
            TableRelation = "Exam Code";
        }
        field(11; "Academic Year"; Code[20])
        {
            Caption = 'Academic Year';
            TableRelation = "Academic Year";
        }
        field(12; "Subject Code"; Code[10])
        {
            Caption = 'Subject Code';
            TableRelation = Subject;

            trigger OnValidate()
            begin
                // Start 01. KATHIR
                if PreQual.Get("Subject Code") then
                    Description := PreQual.Description
                else
                    Description := '';
                // Stop 01.KATHIR
            end;
        }
        field(13; Grade; Code[10])
        {
            TableRelation = "Admission Grade";

            trigger OnValidate()
            begin
                if Grade <> '' then begin
                    AdmissionGrade.Reset;
                    AdmissionGrade.SetRange(AdmissionGrade.Code, Grade);
                    AdmissionGrade.SetRange(AdmissionGrade."Academic Year", "Academic Year");
                    if AdmissionGrade.FindFirst then begin
                        "Mark Obtained" := AdmissionGrade."Obtained Mark";
                        Maximum := AdmissionGrade."Maximum Mark";
                    end;
                end;
            end;
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
        key(Key1; "Application No", "Subject Code")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    begin
        // Start 04. VANDHANA
        "User ID" := UserId;
        "Academic Year" := Eduvertical.GetAdmissionYear;
        // Stop 04. VANDHANA
    end;

    var
        PreQual: Record Subject;
        Text000: Label 'Please ener valid mark';
        AdmissionGrade: Record "Admission Grade";
        Eduvertical: Codeunit "Education Vertical";
}

