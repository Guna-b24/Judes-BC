table 71015 "Class Section"
{
    Caption = 'Class Section';
    DataPerCompany = false;
    // DrillDownPageID = 71027;
    LookupPageID = "Class Section List";

    fields
    {
        field(1; Class; Code[20])
        {
            Caption = 'Class';
            TableRelation = Class;
            ToolTip = 'Specifies the class.';
            DataClassification = CustomerContent;
        }
        field(2; Section; Code[10])
        {
            Caption = 'Section';
            TableRelation = Section;
            ToolTip = 'Specifies the section of the class.';
            DataClassification = CustomerContent;
        }
        field(3; Curriculum; Code[10])
        {
            Caption = 'Curriculum';
            TableRelation = Curriculum;
            ToolTip = 'Specifies the curriculum.';
            DataClassification = CustomerContent;
        }
        field(4; "Academic Year"; Code[10])
        {
            Caption = 'Academic Year';
            TableRelation = "Academic Year";
            ToolTip = 'Specifies the academic year.';
            DataClassification = CustomerContent;
        }
        field(5; "Class Code"; Code[20])
        {
            Caption = 'Class Code';
            ToolTip = 'Specifies the combined class and section code.';
            DataClassification = CustomerContent;
        }
        field(22; Capacity; Decimal)
        {
            Caption = 'Capacity';
            DecimalPlaces = 0 : 0;
            MinValue = 0;
            ToolTip = 'Specifies the maximum capacity of the class section.';
            DataClassification = CustomerContent;
        }
        field(23; "Present Strength"; Integer)
        {
            CalcFormula = Count(Student WHERE("Class Code" = FIELD("Class Code"),
                                               "Student Status" = FILTER(Student)));
            Caption = 'Present Strength';
            Editable = false;
            FieldClass = FlowField;
        }
        field(24; "Marks System"; Option)
        {
            Caption = 'Marks System';
            OptionCaption = 'Marks,Grade';
            OptionMembers = Marks,Grade;
            DataClassification = CustomerContent;
        }
        field(25; "Promotion Percentage"; Decimal)
        {
            Caption = 'Promotion Percentage';
            DataClassification = CustomerContent;
        }
        field(26; Promoted; Boolean)
        {
            Caption = 'Promoted';
            DataClassification = CustomerContent;
        }
        field(29; "Consolidated Grades"; Option)
        {
            Caption = 'Consolidated Grades';
            OptionCaption = ' ,Points,Marks';
            OptionMembers = " ",Points,Marks;
            DataClassification = CustomerContent;
        }
        field(30; "Class Teacher"; Code[20])
        {
            Caption = 'Class Teacher';
            TableRelation = Employee."No.";
            ToolTip = 'Specifies the class teacher.';
            DataClassification = CustomerContent;

            trigger OnLookup()
            begin
                if PAGE.RunModal(50058, Emp) = ACTION::LookupOK then
                    "Class Teacher" := Emp."No.";
            end;
        }
        field(31; "Home Work Duration"; Decimal)
        {
            Caption = 'Home Work Duration';
            ToolTip = 'Specifies the duration of homework.';
            DataClassification = CustomerContent;
        }
        field(40; "Max Group 2 Count"; Integer)
        {
            BlankZero = true;
            Description = 'For class 9 and 10';
            ToolTip = 'Specifies the maximum Group 2 count (for classes 9 and 10).';
            DataClassification = CustomerContent;
        }
        field(41; "Max Group 3 Count"; Integer)
        {
            BlankZero = true;
            Description = 'For class 9 and 10';
            ToolTip = 'Specifies the maximum Group 3 count (for classes 9 and 10).';
            DataClassification = CustomerContent;
        }
        field(70121; "Portal ID"; Code[20])
        {
            Caption = 'Portal ID';
            DataClassification = CustomerContent;
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
    end;

    var
        //  EducationSetup: Record "Education Setup";
        Emp: Record Employee;
}

