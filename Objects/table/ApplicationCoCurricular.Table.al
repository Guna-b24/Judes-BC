table 71005 "Application Co-Curricular"
{
    //   No   Date      Sign     Trigger                             Description
    // -----------------------------------------------------------------------------------------------
    //   01  19/10/09  VANDHANA  OnInsert                            Code to assign User ID.
    //   02  16.11.09  VIGNESH   Co-Curricular Code - OnValidate()   Code added to validate the Description field
    //   03  16.11.09  Vignesh                                       added new filed classification CODE

    Caption = 'Application Co-Curricular';

    fields
    {
        field(1; "Application No."; Code[10])
        {
            Caption = 'Application No.';
        }
        field(2; "Co-Curricular Code"; Code[20])
        {
            Caption = 'Co-Curricular Code';
            TableRelation = "Co-Curricular Activities";
        }
        field(3; Description; Text[100])
        {
            Caption = 'Description';
        }
        field(4; "Classification Code"; Code[20])
        {
            Caption = 'Classification Code';
            TableRelation = "Co-Curricular Classification"."Classification Code" WHERE ("Co-Curricular Code" = FIELD ("Co-Curricular Code"));

            trigger OnValidate()
            begin
                // Start 02.VIGNESH
                if "Co-CurricularClassification".Get("Co-Curricular Code", "Classification Code") then begin
                    Description := "Co-CurricularClassification".Description;
                    "Student No." := Stud."No.";
                end
                else begin
                    Description := '';
                end;
                // Stop 02.VIGNESH
            end;
        }
        field(5; "Student No."; Code[20])
        {
            TableRelation = Student;
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
        key(Key1; "Student No.", "Co-Curricular Code")
        {
            Clustered = true;
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
        "Co-CurricularActivities": Record "Co-Curricular Activities";
        "Co-CurricularClassification": Record "Co-Curricular Classification";
        Stud: Record Student;
}

