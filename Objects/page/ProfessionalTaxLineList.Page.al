page 72289 "Professional Tax Line List"
{
    PageType = List;
    SourceTable = "Professional Tax Line";
    ApplicationArea = All;
    UsageCategory = Lists;
    Caption = 'Professional Tax Slabs';

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Effective Date"; Rec."Effective Date") { ApplicationArea = All; }
                field("Location Code"; Rec."Location Code") { ApplicationArea = All; }
                field("Salary Plan Code"; Rec."Salary Plan Code") { ApplicationArea = All; }
                field("Branch Code"; Rec."Branch Code") { ApplicationArea = All; }
                field("Line No."; Rec."Line No.") { ApplicationArea = All; }
                field("Income From"; Rec."Income From") { ApplicationArea = All; }
                field("Income To"; Rec."Income To") { ApplicationArea = All; }
                field("Tax Amount"; Rec."Tax Amount") { ApplicationArea = All; }
            }
        }
    }
}