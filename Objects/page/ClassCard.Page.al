page 70056 "Class Card"
{
    Caption = 'Class Card';
    PageType = Card;
    SourceTable = Class;
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            group(General)
            {
                field("Code"; Rec."Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the unique code for the class.';
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the description of the class.';
                }
                field(Sequence; Rec.Sequence)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the display or processing order of the class.';
                }
                field("Portal ID"; Rec."Portal ID")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the portal reference ID for the class.';
                }
            }
        }
    }
}