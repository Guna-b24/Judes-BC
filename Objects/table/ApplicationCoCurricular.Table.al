table 71005 "Application Co-Curricular"
{
    Caption = 'Application Co-Curricular';
    DataClassification = CustomerContent;
    LookupPageId = "Application Co-Curricular List";

    fields
    {
        field(1; "Application No."; Code[10])
        {
            Caption = 'Application No.';
            ToolTip = 'Specifies the application number to which the co-curricular activity is linked.';
            DataClassification = CustomerContent;
        }
        field(2; "Co-Curricular Code"; Code[20])
        {
            Caption = 'Co-Curricular Code';
            ToolTip = 'Specifies the co-curricular activity selected by the student.';
            TableRelation = "Co-Curricular Activities";
            DataClassification = CustomerContent;
        }
        field(3; Description; Text[100])
        {
            Caption = 'Description';
            ToolTip = 'Specifies the description of the selected co-curricular classification.';
            DataClassification = CustomerContent;
        }
        field(4; "Classification Code"; Code[20])
        {
            Caption = 'Classification Code';
            ToolTip = 'Specifies the classification under the selected co-curricular  activity.';
            TableRelation = "Co-Curricular Classification"."Classification Code" where("Co-Curricular Code" = field("Co-Curricular Code"));

            trigger OnValidate()
            begin
                if "Co-CurricularClassification".Get("Co-Curricular Code", "Classification Code") then begin
                    Description := "Co-CurricularClassification".Description;
                    "Student No." := Stud."No.";
                end
                else
                    Description := '';
            end;
        }
        field(5; "Student No."; Code[20])
        {
            Caption = 'Student No.';
            ToolTip = 'Specifies the student associated with the co-curricular activity.';
            TableRelation = Student;
            DataClassification = CustomerContent;
        }
        field(70121; "Portal ID"; Code[20])
        {
            Caption = 'Portal ID';
            ToolTip = 'Specifies the portal identifier for integration or external reference.';
            DataClassification = SystemMetadata;
        }
    }

    keys
    {
        key(Key1; "Application No.", "Co-Curricular Code")
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
        //"Co-CurricularActivities": Record "Co-Curricular Activities";
        "Co-CurricularClassification": Record "Co-Curricular Classification";
        Stud: Record Student;
}

