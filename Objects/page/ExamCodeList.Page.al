page 71904 "Exam Code List"
{
    PageType = List;
    SourceTable = "Exam Code";
    ApplicationArea = All;
    Caption = 'Exam Code List';
    Editable = true;
    UsageCategory = Lists;
    CardPageId = "Exam Code Card";

    layout
    {
        area(Content)
        {
            repeater(Group)
            {
                field("Code"; Rec."Code") { }
                field(Description; Rec.Description) { }
                field("Exam Order"; Rec."Exam Order") { }
                field("Portal ID"; Rec."Portal ID") { }
            }
        }
    }

    actions
    {
        area(Navigation) { }
    }
}