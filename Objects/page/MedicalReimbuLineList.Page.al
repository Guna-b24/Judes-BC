page 72296 "Medical Reimbu. Line List"
{
    PageType = List;
    SourceTable = "Medical Reimbu. Line";
    ApplicationArea = All;
    UsageCategory = Lists;

    layout
    {
        area(Content)
        {
            repeater(Group)
            {
                field("Employee No."; Rec."Employee No.") { }
                field("Location Code"; Rec."Location Code") { }
                field("Salary Plan Code"; Rec."Salary Plan Code") { }
                field("Pay Element Code"; Rec."Pay Element Code") { }
                field("Line No."; Rec."Line No.") { }
                field("Reimburesment Date"; Rec."Reimburesment Date") { }
                field("Bill No."; Rec."Bill No.") { }
                field("Bill Date"; Rec."Bill Date") { }
                field(Description; Rec.Description) { }
                field("Bill Amount"; Rec."Bill Amount") { }
                field(Blocked; Rec.Blocked) { }
            }
        }
    }
}