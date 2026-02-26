table 71945 "Academic Points"
{
    LookupPageId = "Academic Points List";

    fields
    {
        field(1; "Student No."; Code[20])
        {
            Caption = 'Student No.';
            ToolTip = 'Specifies the student for whom the academic points are recorded.';
            DataClassification = CustomerContent;
            TableRelation = Student."No.";
            NotBlank = true;
        }
        field(2; "Academic Year"; Code[20])
        {
            Caption = 'Academic Year';
            ToolTip = 'Specifies the academic year.';
            DataClassification = SystemMetadata;
            TableRelation = "Academic Year".Code;
            NotBlank = true;
        }
        field(3; "Exam Code"; Code[20])
        {
            Caption = 'Exam';
            ToolTip = 'Specifies the examination.';
            DataClassification = SystemMetadata;
            TableRelation = "Exam Code".Code;
            NotBlank = true;
        }
        field(4; "Class Code"; Code[20])
        {
            Caption = 'Class';
            ToolTip = 'Specifies the class of the student during the academic year.';
            DataClassification = SystemMetadata;
            TableRelation = Class.Code;
        }
        field(5; Points; Decimal)
        {
            Caption = 'Points';
            ToolTip = 'Specifies the academic points obtained by the student.';
            DataClassification = SystemMetadata;

        }
    }

    keys
    {
        key(Key1; "Student No.", "Academic Year", "Exam Code")
        {
            Clustered = true;
            SumIndexFields = Points;
        }
    }

    fieldgroups
    {
    }
}

