page 72287 "Professional Tax Subform"
{
    PageType = ListPart;
    SourceTable = "Professional Tax Line";
    ApplicationArea = All;
    AutoSplitKey = true;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Line No."; Rec."Line No.") { ApplicationArea = All; }
                field("Income From"; Rec."Income From") { ApplicationArea = All; }
                field("Income To"; Rec."Income To") { ApplicationArea = All; }
                field("Tax Amount"; Rec."Tax Amount") { ApplicationArea = All; }
            }
        }
    }
}