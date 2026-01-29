table 71015 "Class Section"
{
    // No   Date      Sign     Trigger                     Description
    // -----------------------------------------------------------------------------------------------
    // 01  21.11.09  VIGNESH   OnInsert()              Code added to get the Userid
    // 02  22.11.09  VIGNESH   LookupSection()         Function Added to lookup the section as well as to select the Class & Curriculum
    // 03  22.11.09  VIGNESH   Lookupclass()           Function Added to lookup the Class as well as to select the Section & Curriculum
    // 04  22.11.09  VIGNESH   LookupCuriculum()       Function Added to lookup the Curriculum as well as to select the Class & Section
    // 05  22.11.09  VIGNESH   ValidateClass()         Function Added to validate the Class as well as to select the Section & Curriculum
    // 06  22.11.09  VIGNESH   ValidateCurriculum()    Function Added to validate the Curriculum as well as to select the Class & Section
    // 07  22.11.09  VIGNESH   ValidateSection()       Function Added to validate the section as well as to select the Class & Curriculum
    // 08  16.04.10  GUNA                              New Field added "Home Work Duration"

    Caption = 'Class Section';
    DataPerCompany = false;
    DrillDownPageID = 71027;
    LookupPageID = 71027;

    fields
    {
        field(1; Class; Code[20])
        {
            Caption = 'Class';
            SQLDataType = Integer;
            TableRelation = Class;
        }
        field(2; Section; Code[10])
        {
            Caption = 'Section';
            TableRelation = Section;
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
        field(5; "Class Code"; Code[20])
        {
            Caption = 'Class Code';
        }
        field(22; Capacity; Decimal)
        {
            Caption = 'Capacity';
            DecimalPlaces = 0 : 0;
        }
        field(23; "Present Strength"; Integer)
        {
            CalcFormula = Count (Student WHERE ("Class Code" = FIELD ("Class Code"),
                                               "Student Status" = FILTER (Student)));
            Caption = 'Present Strength';
            Editable = false;
            FieldClass = FlowField;
        }
        field(24; "Marks System"; Option)
        {
            Caption = 'Marks System';
            OptionCaption = 'Marks,Grade';
            OptionMembers = Marks,Grade;
        }
        field(25; "Promotion Percentage"; Decimal)
        {
            Caption = 'Promotion Percentage';
        }
        field(26; Promoted; Boolean)
        {
            Caption = 'Promoted';
        }
        field(29; "Consolidated Grades"; Option)
        {
            Caption = 'Consolidated Grades';
            OptionCaption = ' ,Points,Marks';
            OptionMembers = " ",Points,Marks;
        }
        field(30; "Class Teacher"; Code[20])
        {
            Caption = 'Class Teacher';

            trigger OnLookup()
            begin

                if PAGE.RunModal(50058, Emp) = ACTION::LookupOK then begin
                    "Class Teacher" := Emp."No.";
                end;
            end;
        }
        field(31; "Home Work Duration"; Decimal)
        {
            Caption = 'Home Work Duration';
        }
        field(40; "Max Group 2 Count"; Integer)
        {
            BlankZero = true;
            Description = 'For class 9 and 10';
        }
        field(41; "Max Group 3 Count"; Integer)
        {
            BlankZero = true;
            Description = 'For class 9 and 10';
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
        key(Key1; "Class Code", Class)
        {
            Clustered = true;
        }
        key(Key2; Class, Curriculum, "Academic Year")
        {
            SumIndexFields = Capacity;
        }
        key(Key3; Class)
        {
        }
        key(Key4; Class, Section, Curriculum, "Academic Year")
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    begin
        // Start 01.VIGNESH
        "User ID" := UserId;
        /*
        "Education Setup".GET;
        "Education Setup".TESTFIELD("Academic Year");
        "Academic Year" := "Education Setup"."Academic Year";
        */
        // Stop 01.VIGNESH

    end;

    var
        EducationSetup: Record "Education Setup";
        Emp: Record Employee;
}

