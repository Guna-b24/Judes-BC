page 71012 "Evaluation Header Card"
{
    PageType = Card;
    SourceTable = "Evaluation Header";
    ApplicationArea = All;
    Caption = 'Evaluation Header Card';
    Editable = true;
    UsageCategory = Administration;

    layout
    {
        area(Content)
        {
            group(General)
            {
                field("Evaluation No."; Rec."Evaluation No.") { }
                field(Class; Rec.Class) { }
                field(Curriculum; Rec.Curriculum) { }
                field("Academic Year"; Rec."Academic Year") { }
                field("Evaluation Code"; Rec."Evaluation Code") { }
                field("No Series"; Rec."No Series") { }
                field("Portal ID"; Rec."Portal ID") { }
            }
        }
    }

    actions
    {
        area(Navigation) { }
    }
}