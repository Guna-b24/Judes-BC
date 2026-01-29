table 71154 "Time Table Generation"
{
    // 
    //   No   Date      Sign     Trigger                       Description
    // -----------------------------------------------------------------------------------------------
    //   01  19/10/09  VANDHANA  OnInsert                     Code to assign User ID.
    //   02  23/11/09   VIGNESH  Class - OnValidate()                Code added to get the Class Section & Curriculum
    //   03  23/11/09   VIGNESH  Class - OnLookup()                  Code added to get the Class Section & Curriculum
    //   04  23/11/09   VIGNESH  Curriculum - OnValidate()           Code added to get the Class Section & Curriculum
    //   05  23/11/09   VIGNESH  Curriculum - OnLookup()             Code added to get the Class Section & Curriculum
    //   06  23/11/09   VIGNESH  Section - OnValidate()              Code added to get the Class Section & Curriculum
    //   07  23/11/09   VIGNESH  Section - OnLookup()                Code added to get the Class Section & Curriculum

    Caption = 'Time Table Generation';

    fields
    {
        field(1; "Entry No."; Integer)
        {
            AutoIncrement = true;
            Caption = 'Entry No.';
        }
        field(2; Class; Code[10])
        {
            Caption = 'Class';
        }
        field(3; Section; Code[10])
        {
            Caption = 'Section';
        }
        field(4; Curriculum; Code[10])
        {
            Caption = 'Curriculum';
        }
        field(5; "Day No"; Integer)
        {
            Caption = 'Day No';
        }
        field(6; "Hour No"; Integer)
        {
            Caption = 'Hour No';
        }
        field(7; Subject; Code[20])
        {
            Caption = 'Subject';
        }
        field(8; "Employee Code"; Code[20])
        {
            Caption = 'Employee Code';
        }
        field(9; "Generate Date"; Date)
        {
            Description = 'Asc Time Table';
        }
        field(10; "Academic Year"; Code[20])
        {
        }
        field(11; Joint; Boolean)
        {
        }
        field(12; "Period Length"; Integer)
        {
            CalcFormula = Lookup (Subject."Period Length" WHERE (Code = FIELD (Subject)));
            FieldClass = FlowField;
        }
        field(13; Archived; Boolean)
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
        key(Key1; "Entry No.")
        {
            Clustered = true;
        }
        key(Key2; Class, Section)
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
        EduSetup.Get;
        "Academic Year" := EduSetup."Academic Year";
    end;

    var
        ClassSectionLook: Record "Class Section";
        EduSetup: Record "Education Setup";
}

