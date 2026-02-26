page 71013 "Evaluation Header List"
{
    PageType = List;
    SourceTable = "Evaluation Header";
    ApplicationArea = All;
    Caption = 'Evaluation Header List';
    Editable = true;
    UsageCategory = Lists;
    CardPageId = "Evaluation Header Card";

    layout
    {
        area(Content)
        {
            repeater(Group)
            {
                field("Evaluation No."; Rec."Evaluation No.") { }
                field(Class; Rec.Class) { }
                field(Curriculum; Rec.Curriculum) { }
                field("Academic Year"; Rec."Academic Year") { }
                field("Evaluation Code"; Rec."Evaluation Code") { }
                field("No Series"; Rec."No Series") { }
            }
        }
    }

    actions
    {
        area(Navigation) { }
    }
}