table 71073 House
{
    Caption = 'House';
    DataClassification = CustomerContent;
    // DrillDownPageID = 71082;
    // LookupPageID = 71082;

    fields
    {
        field(1; "Code"; Code[20])
        {
            Caption = 'Code';
            DataClassification = CustomerContent;
            NotBlank = true;
        }
        field(2; "House Name"; Text[50])
        {
            Caption = 'House Name';
            DataClassification = CustomerContent;
        }
        field(3; Color; Option)
        {
            Caption = 'Color';
            DataClassification = CustomerContent;
            OptionCaption = ' ,Green,Yellow,Blue,Red';
            OptionMembers = " ",Green,Yellow,Blue,Red;
        }
        field(4; Points; Decimal)
        {
            CalcFormula = Sum("Participant Entry Line".Points WHERE(House = FIELD(Code),
                                                                     "Academic Year" = FIELD(FILTER("Academic Year")),
                                                                     "Event Code" = FILTER('ATHLETICS')));
            Caption = 'Points';
            Editable = false;
            FieldClass = FlowField;
        }
        field(5; "No. of Students Allotted"; Integer)
        {
            CalcFormula = Count(Student WHERE(House = FIELD(Code),
                                               "Academic Year" = FIELD(FILTER("Academic Year")),
                                               "Student Status" = FILTER(Student)));
            Caption = 'No. of Students Allotted';
            Editable = false;
            FieldClass = FlowField;
        }
        field(6; "Academic Year"; Code[10])
        {
            CalcFormula = Lookup("Education Setup"."Academic Year");
            Caption = 'Academic Year';
            Editable = false;
            FieldClass = FlowField;
        }
        field(7; "No Incharge"; Integer)
        {
            Caption = 'No Incharge';
            DataClassification = CustomerContent;
        }
        field(50000; "Orig. Point"; Decimal)
        {
            CalcFormula = Sum("Participant Entry Line".Points WHERE(House = FIELD(Code),
                                                                     "Academic Year" = FIELD("Academic Year"),
                                                                     "Update Results" = CONST(true)));
            FieldClass = FlowField;
        }
        field(70121; "Portal ID"; Code[20])
        {
            Caption = 'Portal ID';
            DataClassification = CustomerContent;
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

}

