table 71058 "Promotion Weightage"
{
    //   No   Date      Sign     Trigger                     Description
    // -----------------------------------------------------------------------------------------------
    //   01  06/10/09  KATHIR   Weightage - OnValidate()      Code added to Check the Overall weightage not to exceed 100.
    //   02  19/10/09  VANDHANA  OnInsert                     Code to assign User ID.
    //   03  23/11/09 VIGNESH  Class Code - OnValidate()      Code added to get the Look up value for Class & Curriculum
    //   04  23/11/09 VIGNESH  Class Code - OnLookup()        Code added to get the Look up value for Class & Curriculum
    //   05  23/11/09 VIGNESH  Curriculum Code - OnValidate() Code added to get the Look up value for Class&Curriculum last attend
    //   06  23/11/09 VIGNESH  Curriculum Code - OnLookup()   Code added to get the Look up value for Class&Curriculum last attend

    Caption = 'Promotion Weightage';

    fields
    {
        field(1; "Class Code"; Code[10])
        {
            Caption = 'Class Code';
            TableRelation = "Class Card".Class;
        }
        field(2; "Curriculum Code"; Code[10])
        {
            Caption = 'Curriculum Code';
            TableRelation = "Class Card".Curriculum;
        }
        field(3; "Academic Year Code"; Code[10])
        {
            Caption = 'Academic Year Code';
            TableRelation = "Academic Year";
        }
        field(4; "Exam Type Code"; Code[10])
        {
            Caption = 'Exam Type Code';
            TableRelation = "Exam Code";
        }
        field(5; Weightage; Decimal)
        {
            Caption = 'Weightage';

            trigger OnValidate()
            begin
                // Start 01.KATHIR
                WeigAge := 0;
                PromotionWeight.Reset;
                PromotionWeight.SetCurrentKey("Class Code", "Curriculum Code", "Academic Year Code", "Exam Type Code");
                PromotionWeight.SetRange("Class Code", "Class Code");
                PromotionWeight.SetRange("Curriculum Code", "Curriculum Code");
                PromotionWeight.SetRange("Academic Year Code", "Academic Year Code");
                if PromotionWeight.FindSet then
                    repeat
                        WeigAge += PromotionWeight.Weightage;
                    until PromotionWeight.Next = 0;

                if (WeigAge + Weightage - xRec.Weightage) > 100 then
                    Error(Text000);
                // Stop 01.KATHIR
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
        key(Key1; "Class Code", "Curriculum Code", "Academic Year Code", "Exam Type Code")
        {
            Clustered = true;
            SumIndexFields = Weightage;
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
        PromotionWeight: Record "Promotion Weightage";
        WeigAge: Decimal;
        Text000: Label 'Weightage cannot be more than 100.';
}

