table 71003 "Application Mark"
{
    Caption = 'Application Mark';
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Application No"; Code[20])
        {
            Caption = 'Application No';
            ToolTip = 'Specifies the application number to which the mark details belong.';
            DataClassification = CustomerContent;
        }
        field(2; Description; Text[50])
        {
            Caption = 'Description';
            ToolTip = 'Specifies the description of the subject or qualification.';
            DataClassification = CustomerContent;
        }
        field(3; "Mark Obtained"; Decimal)
        {
            BlankZero = true;
            Caption = 'Mark Obtained';
            ToolTip = 'Specifies the mark obtained by the applicant for the subject.';
            DataClassification = CustomerContent;

            trigger OnValidate()
            begin
                if Maximum < "Mark Obtained" then begin
                    Message(Text000);
                    "Mark Obtained" := 0;
                end
            end;
        }
        field(4; Maximum; Decimal)
        {
            BlankZero = true;
            Caption = 'Maximum';
            ToolTip = 'Specifies the maximum possible mark for the subject.';
            DataClassification = CustomerContent;

            trigger OnValidate()
            begin
                if Maximum < "Mark Obtained" then begin
                    Message(Text000);
                    "Mark Obtained" := 0;
                end
            end;
        }
        field(5; Month; Option)
        {
            Caption = 'Month';
            ToolTip = 'Specifies the month in which the examination was conducted.';
            OptionCaption = ' ,January,February,March,April,May,June,July,August,September,October,November,December';
            OptionMembers = " ",January,February,March,April,May,June,July,August,September,October,November,December;
            DataClassification = CustomerContent;
        }
        field(6; "Year of passing"; Integer)
        {
            BlankZero = true;
            Caption = 'Year of passing';
            ToolTip = 'Specifies the year in which the applicant passed the examination.';
            DataClassification = CustomerContent;
        }
        field(7; "Register Number"; Code[20])
        {
            Caption = 'Register Number';
            ToolTip = 'Specifies the examination register number of the applicant.';
            DataClassification = CustomerContent;
        }
        field(8; "Exam Code"; Code[20])
        {
            Caption = 'Register Number';
            ToolTip = 'Specifies the examination register number of the applicant.';
            DataClassification = CustomerContent;
        }
        field(11; "Academic Year"; Code[20])
        {
            Caption = 'Academic Year';
            ToolTip = 'Specifies the academic year for which the marks are recorded.';
            TableRelation = "Academic Year";
            DataClassification = CustomerContent;
        }
        field(12; "Subject Code"; Code[10])
        {
            Caption = 'Subject Code';
            ToolTip = 'Specifies the subject code for which the mark is entered.';
            TableRelation = Subject;
            DataClassification = CustomerContent;

            trigger OnValidate()
            begin
                if PreQual.Get("Subject Code") then
                    Description := PreQual.Description
                else
                    Description := '';
            end;
        }
        field(13; Grade; Code[10])
        {
            Caption = 'Grade';
            ToolTip = 'Specifies the grade assigned to the applicant for the subject.';
            TableRelation = "Admission Grade";
            DataClassification = CustomerContent;
            trigger OnValidate()
            begin
                if Grade <> '' then begin
                    AdmissionGrade.Reset();
                    AdmissionGrade.SetRange(AdmissionGrade.Code, Grade);
                    AdmissionGrade.SetRange(AdmissionGrade."Academic Year", "Academic Year");
                    if AdmissionGrade.FindFirst() then begin
                        "Mark Obtained" := AdmissionGrade."Obtained Mark";
                        Maximum := AdmissionGrade."Maximum Mark";
                    end;
                end;
            end;
        }
        field(70121; "Portal ID"; Code[20])
        {
            Caption = 'Portal ID';
            ToolTip = 'Specifies the portal identifier used for external or online integration.';
            DataClassification = SystemMetadata;
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
        "Academic Year" := Eduvertical.GetAdmissionYear();
    end;

    var
        PreQual: Record Subject;

        AdmissionGrade: Record "Admission Grade";
        Eduvertical: Codeunit "Education Vertical";
        Text000: Label 'Please ener valid mark';

}