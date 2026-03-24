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
                field("Evaluation No."; Rec."Evaluation No.")
                {
                    ToolTip = 'Specifies the unique number assigned to the evaluation.';
                }
                field(Class; Rec.Class)
                {
                    ToolTip = 'Specifies the class associated with the evaluation.';
                }
                field(Curriculum; Rec.Curriculum)
                {
                    ToolTip = 'Specifies the curriculum for the evaluation.';
                }
                field("Academic Year"; Rec."Academic Year")
                {
                    ToolTip = 'Specifies the academic year for the evaluation.';
                }
                field("Evaluation Code"; Rec."Evaluation Code")
                {
                    ToolTip = 'Specifies the code that identifies the evaluation type.';
                }
                field("No Series"; Rec."No Series")
                {
                    ToolTip = 'Specifies the number series used to assign evaluation numbers.';
                }
                field("Portal ID"; Rec."Portal ID")
                {
                    ToolTip = 'Specifies the portal identifier linked to the evaluation.';
                }
            }
        }
    }

    actions
    {
        area(Navigation) { }
    }
}