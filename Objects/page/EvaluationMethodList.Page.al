page 71008 "Evaluation Method List"
{
    PageType = List;
    SourceTable = "Evaluation Method";
    ApplicationArea = All;
    Caption = 'Evaluation Method List';
    Editable = true;
    UsageCategory = Lists;

    layout
    {
        area(Content)
        {
            repeater(Group)
            {
                field("Code"; Rec."Code") { }
                field(Description; Rec.Description) { }
                field("Prequalification Mark"; Rec."Prequalification Mark") { }
                field("Portal ID"; Rec."Portal ID") { }
            }
        }
    }

    actions
    {
        area(Navigation) { }
    }
}