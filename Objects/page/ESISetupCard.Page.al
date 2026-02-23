page 72063 "ESI Setup Card"
{
    PageType = Card;
    SourceTable = "ESI Setup";
    ApplicationArea = All;
    Caption = 'ESI Setup Card';
    Editable = true;
    UsageCategory = Administration;

    layout
    {
        area(Content)
        {
            group(General)
            {
                field("Effective Date"; Rec."Effective Date") { }
                field("Location Code"; Rec."Location Code") { }
                field("Salary Plan Code"; Rec."Salary Plan Code") { }
                field("ESI Gross Salary Amount"; Rec."ESI Gross Salary Amount") { }
                field("ESI % ( Employee )"; Rec."ESI % ( Employee )") { }
                field("ESI % ( Company )"; Rec."ESI % ( Company )") { }
                field("ESI Rounding Amount"; Rec."ESI Rounding Amount") { }
                field("ESI Rounding Type"; Rec."ESI Rounding Type") { }
            }
        }
    }

    actions
    {
        area(Navigation) { }
    }
}