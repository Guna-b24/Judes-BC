page 70054 "Citizenship Card"
{
    Caption = 'Citizenship Card';
    PageType = Card;
    SourceTable = Citizenship;
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
                    ToolTip = 'Specifies the unique code for the citizenship.';
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the description of the citizenship.';
                }
                field("Portal ID"; Rec."Portal ID")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the portal reference ID for the citizenship.';
                }
            }
        }
    }
}