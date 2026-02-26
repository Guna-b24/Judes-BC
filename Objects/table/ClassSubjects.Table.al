table 71048 "Class Subjects"
{
    Caption = 'Class Subjects';
    DataClassification = CustomerContent;
    LookupPageID = "Class Subjects List";

    fields
    {
        field(1; Class; Code[10])
        {
            Caption = 'Class Code';
            ToolTip = 'Specifies the class for which the subject is defined.';
            TableRelation = Class;
            DataClassification = CustomerContent;
        }
        field(3; Curriculum; Code[10])
        {
            Caption = 'Curriculum';
            ToolTip = 'Specifies the curriculum applicable to the class subject.';
            TableRelation = Curriculum;
            DataClassification = CustomerContent;
        }

        field(4; "Academic Year"; Code[10])
        {
            Caption = 'Academic Year';
            ToolTip = 'Specifies the academic year for which the subject is applicable.';
            TableRelation = "Academic Year";
            DataClassification = CustomerContent;
        }
        field(5; Subject; Code[10])
        {
            Caption = 'Subject';
            ToolTip = 'Specifies the subject assigned to the class.';
            TableRelation = Subject;
            DataClassification = CustomerContent;

            trigger OnValidate()
            begin
                if RecSubject.Get(Subject) then begin
                    Description := RecSubject.Description;
                    Type := RecSubject.Type;
                    "Subject Group" := RecSubject."Subject Group";
                end else begin
                    Description := '';
                    "Subject Group" := '';
                end;
            end;
        }
        field(6; Description; Text[50])
        {
            Caption = 'Description';
            ToolTip = 'Specifies the description of the selected subject.';
            Editable = false;
            DataClassification = CustomerContent;
        }

        field(7; Type; Option)
        {
            Caption = 'Type';
            ToolTip = 'Specifies whether the subject is scholastic or non-scholastic.';
            OptionCaption = 'Scholastic,Non-Scholastic';
            OptionMembers = Scholastic,"Non-Scholastic";
            DataClassification = CustomerContent;
        }
        field(8; "Subject Group"; Code[20])
        {
            Caption = 'Subject Group';
            ToolTip = 'Specifies the subject group classification.';
            TableRelation = "Subject Group";
            DataClassification = CustomerContent;
        }

        field(9; "Maximum Mark"; Decimal)
        {
            Caption = 'Maximum Mark';
            ToolTip = 'Specifies the maximum marks for the subject.';
            BlankZero = true;
            DataClassification = CustomerContent;
        }

        field(10; "Pass Mark"; Decimal)
        {
            Caption = 'Pass Mark';
            ToolTip = 'Specifies the minimum marks required to pass the subject.';
            BlankZero = true;
            DataClassification = CustomerContent;
        }
        field(11; "Group Code"; Code[10])
        {
            Caption = 'Group Code';
            ToolTip = 'Specifies the group code associated with the subject.';
            DataClassification = CustomerContent;
        }

        field(12; "Subject Order"; Decimal)
        {
            Caption = 'Subject Order';
            ToolTip = 'Specifies the display or evaluation order of the subject.';
            DataClassification = CustomerContent;
        }

        field(70121; "Portal ID"; Code[20])
        {
            Caption = 'Portal ID';
            ToolTip = 'Specifies the portal reference ID for this class subject.';
            DataClassification = CustomerContent;
        }
    }

    keys
    {
        key(Key1; Class, Curriculum, "Academic Year", Subject)
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    begin

    end;

    var
        RecSubject: Record Subject;
}

