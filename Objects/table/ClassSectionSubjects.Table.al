table 71016 "Class Section Subjects"
{
    Caption = 'Class Section Subjects';
    // DrillDownPageID = 71031;
    LookupPageID = "Class Section Subjects List";

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
            ToolTip = 'Specifies the subject group to which this subject belongs.';
            TableRelation = "Subject Group";
            DataClassification = CustomerContent;
        }
        field(9; "Maximum Mark"; Decimal)
        {
            Caption = 'Maximum Mark';
            ToolTip = 'Specifies the maximum marks that can be scored for this subject.';
            BlankZero = true;
            DataClassification = CustomerContent;
        }
        field(10; "Pass Mark"; Decimal)
        {
            Caption = 'Pass Mark';
            ToolTip = 'Specifies the minimum marks required to pass this subject.';
            BlankZero = true;
            DataClassification = CustomerContent;
        }
        field(11; "Group Code old"; Code[10])
        {
            Caption = 'Group Code';
            ToolTip = 'Specifies the old group code maintained for reference.';
            DataClassification = CustomerContent;
        }
        field(12; "Subject Teacher"; Code[10])
        {
            Caption = 'Subject Teacher';
            ToolTip = 'Specifies the employee code of the teacher handling this subject.';
            TableRelation = Employee;
            DataClassification = CustomerContent;
        }
        field(13; "Class Code"; Text[100])
        {
            Caption = 'Class Code';
            ToolTip = 'Specifies the class associated with this subject.';
            DataClassification = CustomerContent;
        }
        field(20; "Group Code"; Code[20])
        {
            Caption = 'Group Code';
            ToolTip = 'Specifies the class group assigned to this subject.';
            TableRelation = "Class Group";
            DataClassification = CustomerContent;
        }
        field(50; "II Lang Type"; Option)
        {
            Caption = 'Second Language Type';
            ToolTip = 'Specifies the second language selected for the subject.';
            OptionCaption = ' ,Tamil,Hindi,Telugu,Malayalam,Kannada,French,Thai';
            OptionMembers = " ",Tamil,Hindi,Telugu,Malayalam,Kannada,French,Thai;
            DataClassification = CustomerContent;
        }
        field(51; "Class IX and  X Group"; Option)
        {
            Caption = 'Class IX and X Group';
            ToolTip = 'Specifies the group classification applicable for Class IX and X.';
            OptionCaption = ' ,Group1,Group2,Group3,Group4,Group5,Group6';
            OptionMembers = " ",Group1,Group2,Group3,Group4,Group5,Group6;
            DataClassification = CustomerContent;
        }
        field(70121; "Portal ID"; Code[20])
        {
            Caption = 'Portal ID';
            ToolTip = 'Specifies the portal reference ID for this subject record.';
            DataClassification = CustomerContent;
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

