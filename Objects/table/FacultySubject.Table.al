table 71150 "Faculty Subject"
{
    //   No   Date      Sign     Trigger                       Description
    // -----------------------------------------------------------------------------------------------
    //   01  19/10/09  VANDHANA  OnInsert                     Code to assign User ID.

    Caption = 'Faculty Subject';
    DrillDownPageID = 71150;
    LookupPageID = 71150;

    fields
    {
        field(1; "Faculty Code"; Code[20])
        {
            Caption = 'Faculty Code';
            TableRelation = "Employee Alll";

            trigger OnValidate()
            begin
                if "Faculty Code" <> '' then
                    if RecEmployee.Get("Faculty Code") then
                        "Faculty Name" := RecEmployee."First Name" + ' ' + RecEmployee."Last Name" + ' ' + RecEmployee."Middle Name";
            end;
        }
        field(2; Class; Code[20])
        {
            Caption = 'Class ';
            TableRelation = Class;
        }
        field(3; Curriculum; Code[10])
        {
            Caption = 'Curriculum';
            TableRelation = Curriculum;
        }
        field(4; "Subject Code"; Code[20])
        {
            Caption = 'Subject Code';
            TableRelation = Subject;

            trigger OnValidate()
            begin
                if RecSubject.Get("Subject Code") then begin
                    "Subject Description" := RecSubject.Description;
                end else begin
                    // Description := '';
                end;
            end;
        }
        field(5; "Class Master"; Boolean)
        {
            Caption = 'Class Master';
        }
        field(6; "Alloted Hours"; Integer)
        {
            Caption = 'Alloted Hours';
        }
        field(7; "Weekly Hours"; Integer)
        {
            Caption = 'Weekly Hours';
        }
        field(8; "Section Code"; Code[10])
        {
            Caption = 'Section Code';
        }
        field(9; "Academic Year"; Code[10])
        {
            Caption = 'Academic Year';
        }
        field(10; Available; Boolean)
        {
            Caption = 'Available';
        }
        field(11; "Subject Type"; Code[20])
        {
            Caption = 'Subject Type';
            TableRelation = "Subject Type";
        }
        field(12; "Faculty Name"; Text[50])
        {
            Caption = 'Faculty Name';
        }
        field(13; "Subject Description"; Text[30])
        {
            Caption = 'Subject Description';
        }
        field(14; "Class Code"; Code[20])
        {
            TableRelation = "Class Section";

            trigger OnValidate()
            begin
                if ClassSection.Get("Class Code") then begin
                    Class := ClassSection.Class;
                    "Section Code" := ClassSection.Section;
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
        key(Key1; "Faculty Code", Class, Curriculum, "Section Code", "Subject Code", "Academic Year")
        {
            Clustered = true;
        }
        key(Key2; Class, Curriculum, "Subject Code", Available)
        {
        }
        key(Key3; Class, Curriculum, "Section Code", "Subject Code", "Academic Year")
        {
        }
        key(Key4; "Faculty Code", Class, "Academic Year")
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
        RecEmployee: Record Employee;
        ClassSection: Record "Class Section";
        RecSubject: Record Subject;
}

