page 72288 "Professional Tax List"
{
    PageType = List;
    SourceTable = "Professional Tax Header";
    ApplicationArea = All;
    UsageCategory = Lists;
    Caption = 'Professional Tax Setup List';
    CardPageId = "Professional Tax Card";

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
                field("Branch Name"; Rec."Branch Name") { ApplicationArea = All; }
                field("Calculation Type"; Rec."Calculation Type") { ApplicationArea = All; }
                field("Salary Starting Date"; Rec."Salary Starting Date") { ApplicationArea = All; }
                field("Salary Ending Date"; Rec."Salary Ending Date") { ApplicationArea = All; }
            }
        }
    }
}