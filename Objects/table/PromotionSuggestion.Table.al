table 71059 "Promotion Suggestion"
{
    // 
    //   No   Date      Sign     Trigger                       Description
    // -----------------------------------------------------------------------------------------------
    //   01  19/10/09  VANDHANA  OnInsert                      Code to assign User ID.
    //   02  23/11/09   VIGNESH  Class - OnValidate()          Code added to get the Class Section & Curriculum
    //   03  23/11/09   VIGNESH  Class - OnLookup()            Code added to get the Class Section & Curriculum
    //   04  23/11/09   VIGNESH  Curriculum - OnValidate()     Code added to get the Class Section & Curriculum
    //   05  23/11/09   VIGNESH  Curriculum - OnLookup()       Code added to get the Class Section & Curriculum
    //   06  23/11/09   VIGNESH  Section - OnValidate()        Code added to get the Class Section & Curriculum
    //   07  23/11/09   VIGNESH  Section - OnLookup()          Code added to get the Class Section & Curriculum

    Caption = 'Promotion Suggestion';

    fields
    {
        field(1; "Student No."; Code[20])
        {
            Caption = 'Student No.';
            Editable = false;
        }
        field(2; Class; Code[10])
        {
            Caption = 'Class';
            Editable = false;
        }
        field(3; Section; Code[10])
        {
            Caption = 'Section';
            Editable = false;
        }
        field(4; Curriculum; Code[20])
        {
            Caption = 'Curriculum';
            Editable = false;
        }
        field(5; "Pass %"; Decimal)
        {
            BlankZero = true;
            Caption = 'Pass %';
            Editable = false;
        }
        field(6; "Marks Obtained"; Decimal)
        {
            BlankZero = true;
            Caption = 'Marks Obtained';
            Editable = false;
        }
        field(7; Result; Option)
        {
            Caption = 'Result';
            OptionCaption = 'Promoted,Detained,Withheld';
            OptionMembers = Promoted,Detained,Withheld;
        }
        field(8; "Student Name"; Text[50])
        {
            Caption = 'Student Name';
            Editable = false;
        }
        field(9; "Academic Year"; Code[10])
        {
            Caption = 'Academic Year';
            Editable = false;
        }
        field(12; "Class Code"; Code[20])
        {
            Caption = 'Class Code';
            TableRelation = "Class Section";

            trigger OnValidate()
            begin
                if ClassSection.Get("Class Code") then begin
                    Class := ClassSection.Class;
                    Section := ClassSection.Section;
                    Curriculum := ClassSection.Curriculum;
                    "Academic Year" := ClassSection."Academic Year";
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
        key(Key1; "Student No.", "Class Code")
        {
            Clustered = true;
        }
        key(Key2; Class, Section, Curriculum, "Academic Year")
        {
        }
        key(Key3; "Class Code")
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
        ClassSection: Record "Class Section";
}

