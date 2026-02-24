page 71044 "KeyStages List"
{
    PageType = List;
    SourceTable = KeyStages;
    ApplicationArea = All;
    UsageCategory = Lists;
    Caption = 'Key Stages';
    CardPageId = "KeyStages Card";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Divison Code"; Rec."Divison Code")
                {
                    ApplicationArea = All;
                }
                field(Code; Rec.Code)
                {
                    ApplicationArea = All;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                }
                field("Portal ID"; Rec."Portal ID")
                {
                    ApplicationArea = All;
                }
            }
        }
    }
}