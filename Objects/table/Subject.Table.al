table 71004 Subject
{
    Caption = 'Subject';
    DataClassification = CustomerContent;
    LookupPageID = "Subject List";
    DrillDownPageId = "Subject List";

    fields
    {
        field(1; "Code"; Code[20])
        {
            Caption = 'Code';
            DataClassification = CustomerContent;
            ToolTip = 'Specifies the unique code of the subject.';
            NotBlank = true;
        }
        field(2; Description; Text[50])
        {
            Caption = 'Description';
            DataClassification = CustomerContent;
            ToolTip = 'Specifies the description or name of the subject.';
        }
        field(3; Type; Option)
        {
            Caption = 'Type';
            DataClassification = CustomerContent;
            ToolTip = 'Specifies whether the subject is scholastic or non-scholastic.';
            OptionCaption = 'Scholastic,Non-Scholastic';
            OptionMembers = Scholastic,"Non-Scholastic";
        }
        field(4; "Subject Group"; Code[20])
        {
            Caption = 'Subject Group';
            DataClassification = CustomerContent;
            ToolTip = 'Specifies the subject group to which this subject belongs.';
            TableRelation = "Subject Group";
        }
        field(5; Compulsory; Boolean)
        {
            DataClassification = CustomerContent;
            ToolTip = 'Specifies whether the subject is compulsory.';
        }
        field(6; "Period Length"; Integer)
        {
            DataClassification = CustomerContent;
            ToolTip = 'Specifies the duration of one period for the subject.';
        }
        field(50; "II Lang Type"; Option)
        {
            DataClassification = CustomerContent;
            ToolTip = 'Specifies the second language type for the subject.';
            OptionCaption = ' ,Tamil,Hindi,Telugu,Malayalam,Kannada,French,Thai';
            OptionMembers = " ",Tamil,Hindi,Telugu,Malayalam,Kannada,French,Thai;
        }
        field(51; "Subject Order"; Decimal)
        {
            DataClassification = CustomerContent;
            ToolTip = 'Specifies the display or processing order of the subject.';
        }
        field(70121; "Portal ID"; Code[20])
        {
            Caption = 'Portal ID';
            DataClassification = CustomerContent;
            ToolTip = 'Specifies the portal identifier associated with the subject.';
        }
    }

    keys
    {
        key(Key1; "Code")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

}

