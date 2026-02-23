page 70055 "Class List"
{
    Caption = 'Class List';
    PageType = List;
    SourceTable = Class;
    ApplicationArea = All;
    UsageCategory = Lists;
    CardPageId = "Class Card";

    layout
    {
        area(content)
        {
            repeater(Group)
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

    trigger OnOpenPage()
    begin
        Rec.SetCurrentKey(Sequence);
    end;
}