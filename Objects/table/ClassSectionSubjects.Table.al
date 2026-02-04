table 71016 "Class Section Subjects"
{
    Caption = 'Class Section Subjects';
    // DrillDownPageID = 71031;
    // LookupPageID = 71031;

    fields
    {
        field(1; Class; Code[20])
        {
            Caption = 'Class';
            TableRelation = Class.Code;
            DataClassification = CustomerContent;
            ToolTip = 'Specifies the class.';
        }
        field(2; Section; Code[20])
        {
            Caption = 'Section';
            DataClassification = CustomerContent;
            ToolTip = 'Specifies the section of the class.';
        }
        field(3; Curriculum; Code[10])
        {
            Caption = 'Curriculum';
            DataClassification = CustomerContent;
            ToolTip = 'Specifies the curriculum.';
        }
        field(4; "Academic Year"; Code[10])
        {
            Caption = 'Academic Year';
            TableRelation = "Academic Year";
            DataClassification = CustomerContent;
            ToolTip = 'Specifies the academic year.';
        }
        field(5; Subject; Code[10])
        {
            Caption = 'Subject';
            TableRelation = Subject;
            DataClassification = CustomerContent;
            ToolTip = 'Specifies the subject code.';

            trigger OnValidate()
            begin
                if RecSubject.Get(Subject) then begin
                    Description := RecSubject.Description;
                    Type := RecSubject.Type;
                    "Subject Group" := RecSubject."Subject Group";
                    "II Lang Type" := RecSubject."II Lang Type";

                end else begin
                    Description := '';
                    "Subject Group" := '';
                    "II Lang Type" := 0;
                end;

                if ClassSection.Get("Class Code") then begin
                    Class := ClassSection.Class;
                    Section := ClassSection.Section;
                    Curriculum := ClassSection.Curriculum;
                    "Academic Year" := ClassSection."Academic Year";
                end;
            end;
        }
        field(6; Description; Text[50])
        {
            Caption = 'Description';
            DataClassification = CustomerContent;
            ToolTip = 'Specifies the subject description.';
        }
        field(7; Type; Option)
        {
            Caption = 'Type';
            OptionMembers = Scholastic,"Non-Scholastic";
            OptionCaption = 'Scholastic,Non-Scholastic';
            DataClassification = CustomerContent;
            ToolTip = 'Specifies whether the subject is scholastic or non-scholastic.';
        }
        field(8; "Subject Group"; Code[20])
        {
            Caption = 'Subject Group';
            TableRelation = "Subject Group";
        }
        field(9; "Maximum Mark"; Decimal)
        {
            BlankZero = true;
            Caption = 'Maximum Mark';
        }
        field(10; "Pass Mark"; Decimal)
        {
            BlankZero = true;
            Caption = 'Pass Mark';
        }
        field(11; "Group Code old"; Code[10])
        {
            Caption = 'Group Code';
        }
        field(12; "Subject Teacher"; Code[10])
        {
            Caption = 'Subject Teacher';
            TableRelation = Employee;
        }
        field(13; "Class Code"; Code[20])
        {
            Caption = 'Class Code';
        }
        field(20; "Group Code"; Code[20])
        {
            TableRelation = "Class Group";
        }
        field(50; "II Lang Type"; Option)
        {
            OptionCaption = ' ,Tamil,Hindi,Telugu,Malayalam,Kannada,French,Thai';
            OptionMembers = " ",Tamil,Hindi,Telugu,Malayalam,Kannada,French,Thai;
        }
        field(51; "Class IX and  X Group"; Option)
        {
            OptionCaption = ' ,Group1,Group2,Group3,Group4,Group5,Group6';
            OptionMembers = " ",Group1,Group2,Group3,Group4,Group5,Group6;
        }
        field(70121; "Portal ID"; Code[20])
        {
            Caption = 'Portal ID';
        }
    }

    keys
    {
        key(Key1; "Class Code", "Group Code", Subject)
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    var
        RecSubject: Record Subject;
        ClassSection: Record "Class Section";
}

