table 71054 "Class Grade"
{
    //   No   Date      Sign     Trigger                       Description
    // -----------------------------------------------------------------------------------------------
    //   01   30/09/09  KATHIR   Grade Code - OnValidate()     code added to get grade description
    //   02  19/10/09  VANDHANA  OnInsert                     Code to assign User ID.
    //   03  23/11/09   VIGNESH  Class - OnValidate()                Code added to get the Class Section & Curriculum
    //   04  23/11/09   VIGNESH  Class - OnLookup()                  Code added to get the Class Section & Curriculum
    //   05  23/11/09   VIGNESH  Section - OnValidate()              Code added to get the Class Section & Curriculum
    //   06  23/11/09   VIGNESH  Section - OnLookup()                Code added to get the Class Section & Curriculum
    //   07  23/11/09   VIGNESH  Curriculum - OnValidate()           Code added to get the Class Section & Curriculum
    //   08  23/11/09   VIGNESH  Curriculum - OnLookup()             Code added to get the Class Section & Curriculum

    Caption = 'Class Grade';

    fields
    {
        field(1; Class; Code[10])
        {
            Caption = 'Class';
        }
        field(2; "Grade Code"; Code[20])
        {
            Caption = 'Grade Code';
            TableRelation = Grade;

            trigger OnValidate()
            begin
                // Start 01.KATHIR
                if Grade.Get("Grade Code") then begin
                    Description := Grade.Description;
                    "Max Percentage" := Grade."Max Percentage";
                    "Min Percentage" := Grade."Min Percentage";
                end else begin
                    Description := '';
                    "Max Percentage" := 0;
                    "Min Percentage" := 0;
                end;
                // Stop 01.KATHIR
            end;
        }
        field(3; Description; Text[50])
        {
            Caption = 'Description';
        }
        field(4; Section; Code[10])
        {
            Caption = 'Section';
        }
        field(5; Curriculum; Code[10])
        {
            Caption = 'Curriculum';
        }
        field(6; "Academic Year"; Code[10])
        {
            Caption = 'Academic Year';
        }
        field(7; "Max Percentage"; Decimal)
        {
            Caption = 'Max Percentage';
        }
        field(8; "Min Percentage"; Decimal)
        {
            Caption = 'Min Percentage';
        }
        field(9; Points; Decimal)
        {
            Caption = 'Points';
        }
        field(10; "Class Code"; Code[20])
        {
            Caption = 'Class Code';
            TableRelation = "Class Section";
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
        key(Key1; Class, Curriculum, "Academic Year", "Grade Code")
        {
            Clustered = true;
        }
        key(Key2; Points)
        {
        }
        key(Key3; Class, Points)
        {
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
        Grade: Record Grade;
        ClassSectionLook: Record "Class Section";
}

