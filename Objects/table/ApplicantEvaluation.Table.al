table 71009 "Applicant Evaluation"
{
    Caption = 'Applicant Evaluation';
    DataClassification = CustomerContent;
    LookupPageId = "Applicant Evaluation List";

    fields
    {
        field(1; "Application No."; Code[20])
        {
            Caption = 'Application No.';
            ToolTip = 'Specifies the application number of the applicant.';
            DataClassification = CustomerContent;
        }

        field(2; "Evaluation Method Code"; Code[20])
        {
            Caption = 'Evaluation Method Code';
            ToolTip = 'Specifies the evaluation method used for the applicant.';
            TableRelation = "Evaluation Method";
            DataClassification = CustomerContent;
        }

        field(3; Desription; Text[30])
        {
            Caption = 'Desription';
            ToolTip = 'Specifies the description of the evaluation method.';
            DataClassification = CustomerContent;
        }

        field(4; "Mark Obtained"; Decimal)
        {
            Caption = 'Mark Obtained';
            ToolTip = 'Specifies the marks obtained by the applicant.';
            DataClassification = CustomerContent;

            trigger OnValidate()
            begin

                if "Maximum Mark" <> 0 then begin
                    if "Mark Obtained" > "Maximum Mark" then
                        Error(Text000, "Maximum Mark")
                    else
                        "Attendance Status" := "Attendance Status"::Present;
                end else
                    Error(Text001);

            end;
        }

        field(5; "Attendance Status"; Option)
        {
            Caption = 'Attendance Status';
            ToolTip = 'Specifies whether the applicant was present or absent for evaluation.';
            OptionCaption = ' ,Present,Absent';
            OptionMembers = " ",Present,Absent;
            DataClassification = CustomerContent;
        }

        field(6; "Maximum Mark"; Decimal)
        {
            Caption = 'Maximum Mark';
            ToolTip = 'Specifies the maximum mark that can be scored in the evaluation.';
            DataClassification = CustomerContent;
        }

        field(7; "Pass Mark"; Decimal)
        {
            Caption = 'Pass Mark';
            ToolTip = 'Specifies the minimum mark required to pass the evaluation.';
            DataClassification = CustomerContent;
        }

        field(8; "Evaluation No."; Code[10])
        {
            Caption = 'Evaluation No.';
            ToolTip = 'Specifies the unique evaluation number.';
            DataClassification = CustomerContent;
        }

        field(9; Weightage; Decimal)
        {
            Caption = 'Weightage';
            ToolTip = 'Specifies the weightage percentage for this evaluation.';
            DataClassification = CustomerContent;
        }

        field(10; "Applicant Name"; Text[80])
        {
            Caption = 'Applicant Name';
            ToolTip = 'Specifies the name of the applicant.';
            DataClassification = CustomerContent;
        }

        field(11; Class; Code[10])
        {
            Caption = 'Class';
            ToolTip = 'Specifies the class or category of the applicant.';
            DataClassification = CustomerContent;
        }

        field(70121; "Portal ID"; Code[20])
        {
            Caption = 'Portal ID';
            ToolTip = 'Specifies the portal reference ID associated with the applicant.';
            DataClassification = CustomerContent;
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
    end;

    var
        Text000: Label 'Maximum mark that you can enter is %1.';
        Text001: Label 'Maximum mark is zero.';
}
