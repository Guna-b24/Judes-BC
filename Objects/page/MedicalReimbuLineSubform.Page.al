page 72095 "Medical Reimbu. Line Subform"
{
    PageType = ListPart;
    SourceTable = "Medical Reimbu. Line";
    ApplicationArea = All;
    AutoSplitKey = true;
    UsageCategory = Lists;

    layout
    {
        area(Content)
        {
            repeater(Group)
            {
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