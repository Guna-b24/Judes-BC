page 72064 "ESI Setup List"
{
    PageType = List;
    SourceTable = "ESI Setup";
    ApplicationArea = All;
    Caption = 'ESI Setup List';
    Editable = true;
    UsageCategory = Lists;

    layout
    {
        area(Content)
        {
            repeater(Group)
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