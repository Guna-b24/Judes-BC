table 71048 "Class Subjects"
{
    //  No   Date      Sign     Trigger                         Description
    // -----------------------------------------------------------------------------------------------
    //  01  28/09/09  KATHIR    Subject Code - OnValidate()     Code added to Get the subject description and Subject Type
    //  02  19/10/09  VANDHANA  OnInsert                     Code to assign User ID.

    Caption = 'Class Subjects';
    LookupPageID = 71062;

    fields
    {
        field(1; Class; Code[10])
        {
            Caption = 'Class Code';
            TableRelation = Class;
        }
        field(3; Curriculum; Code[10])
        {
            Caption = 'Curriculum';
            TableRelation = Curriculum;
        }
        field(4; "Academic Year"; Code[10])
        {
            Caption = 'Academic Year';
            TableRelation = "Academic Year";
        }
        field(5; Subject; Code[10])
        {
            Caption = 'Subject';
            TableRelation = Subject;

            trigger OnValidate()
            begin
                // Start 01.KATHIR
                if RecSubject.Get(Subject) then begin
                    Description := RecSubject.Description;
                    Type := RecSubject.Type;
                    "Subject Group" := RecSubject."Subject Group";
                end else begin
                    Description := '';
                    "Subject Group" := '';
                end;
                // Stop 01.KATHIR
            end;
        }
        field(6; Description; Text[50])
        {
            Caption = 'Description';
        }
        field(7; Type; Option)
        {
            Caption = 'Type';
            OptionCaption = 'Scholastic,Non-Scholastic';
            OptionMembers = Scholastic,"Non-Scholastic";
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
        field(11; "Group Code"; Code[10])
        {
            Caption = 'Group Code';
        }
        field(12; "Subject Order"; Decimal)
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
        // Start 02. VANDHANA
        "User ID" := UserId;
        // Stop 02. VANDHANA
    end;

    var
        RecSubject: Record Subject;
}

