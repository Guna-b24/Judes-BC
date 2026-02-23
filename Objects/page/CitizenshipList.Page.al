page 70053 "Citizenship List"
{
    Caption = 'Citizenship List';
    PageType = List;
    SourceTable = Citizenship;
    ApplicationArea = All;
    UsageCategory = Lists;
    CardPageId = "Citizenship Card";

    layout
    {
        area(content)
        {
            repeater(Group)
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