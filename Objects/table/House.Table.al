table 71073 House
{
    // No   Date      Sign     Trigger                     Description
    // -----------------------------------------------------------------------------------------------
    // 01   15.12.09  VIGNESH  OnInsert()                 Code added to update the User id

    Caption = 'House';
    DrillDownPageID = 71082;
    LookupPageID = 71082;

    fields
    {
        field(1; "Code"; Code[20])
        {
            Caption = 'Code';
            NotBlank = true;
        }
        field(2; "House Name"; Text[50])
        {
            Caption = 'House Name';
        }
        field(3; Color; Option)
        {
            Caption = 'Color';
            OptionCaption = ' ,Green,Yellow,Blue,Red';
            OptionMembers = " ",Green,Yellow,Blue,Red;
        }
        field(4; Points; Decimal)
        {
            CalcFormula = Sum ("Participant Entry Line".Points WHERE (House = FIELD (Code),
                                                                     "Academic Year" = FIELD (FILTER ("Academic Year")),
                                                                     "Event Code" = FILTER ('ATHLETICS')));
            Caption = 'Points';
            Editable = false;
            FieldClass = FlowField;
        }
        field(5; "No. of Students Allotted"; Integer)
        {
            CalcFormula = Count (Student WHERE (House = FIELD (Code),
                                               "Academic Year" = FIELD (FILTER ("Academic Year")),
                                               "Student Status" = FILTER (Student)));
            Caption = 'No. of Students Allotted';
            Editable = false;
            FieldClass = FlowField;
        }
        field(6; "Academic Year"; Code[10])
        {
            CalcFormula = Lookup ("Education Setup"."Academic Year");
            Caption = 'Academic Year';
            Editable = false;
            FieldClass = FlowField;
        }
        field(7; "No Incharge"; Integer)
        {
            Caption = 'No Incharge';
        }
        field(50000; "Orig. Point"; Decimal)
        {
            CalcFormula = Sum ("Participant Entry Line".Points WHERE (House = FIELD (Code),
                                                                     "Academic Year" = FIELD ("Academic Year"),
                                                                     "Update Results" = CONST (true)));
            FieldClass = FlowField;
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
        key(Key1; "Code")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    begin
        // Start 01.VIGNESH
        "User ID" := UserId;
        // Stop 01.VIGNESH
    end;
}

