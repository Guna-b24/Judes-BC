page 71860 "Stores Setup"
{
    PageType = Card;
    SourceTable = "Stores Setup";
    ApplicationArea = All;
    UsageCategory = Administration;

    layout
    {
        area(Content)
        {
            group(General)
            {
                field("Bulk Issues No."; Rec."Bulk Issues No.") { }
                field("Fee Code"; Rec."Fee Code") { }
                field("Portal ID"; Rec."Portal ID") { }
            }
        }
    }

    trigger OnOpenPage()
    begin
        if not Rec.Get('SETUP') then begin
            Rec.Init();
            Rec."Primary Key" := 'SETUP';
            Rec.Insert();
        end;
    end;
}