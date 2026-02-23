page 70063 "Class Group List"
{
    Caption = 'Class Group List';
    PageType = List;
    SourceTable = "Class Group";
    ApplicationArea = All;
    UsageCategory = Lists;
    CardPageId = "Class Group Card";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Code"; Rec."Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the unique code for the class group.';
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the description of the class group.';
                }
                field("Portal ID"; Rec."Portal ID")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the portal reference ID for the class group.';
                }
            }
        }
    }
}