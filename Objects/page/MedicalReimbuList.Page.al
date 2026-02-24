page 72193 "Medical Reimbu. List"
{
    PageType = List;
    SourceTable = "Medical Reimbu. Header";
    ApplicationArea = All;
    UsageCategory = Lists;
    CardPageId = "Medical Reimbu. Card";

    layout
    {
        area(Content)
        {
            repeater(Group)
            {
                field("Employee No."; Rec."Employee No.") { }
                field(Name; Rec.Name) { }
                field("Location Code"; Rec."Location Code") { }
                field("Salary Plan Code"; Rec."Salary Plan Code") { }
                field("Pay Element Code"; Rec."Pay Element Code") { }
                field("No of Bills"; Rec."No of Bills") { }
                field("Total Amount"; Rec."Total Amount") { }
                field("Claimed Amount"; Rec."Claimed Amount") { }
                field("Balance Amount"; Rec."Balance Amount") { }
                field(Blocked; Rec.Blocked) { }
            }
        }
    }
}