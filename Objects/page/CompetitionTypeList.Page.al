page 71084 "Competition Type List"
{
    PageType = List;
    SourceTable = "Competition Type";
    ApplicationArea = All;
    UsageCategory = Lists;
    Caption = 'Competition Types';

    layout
    {
        area(Content)
        {
            repeater(Group)
            {
                field(Code; Rec.Code)
                {
                    ApplicationArea = All;
                }

                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                }

                field("Entire Class"; Rec."Entire Class")
                {
                    ApplicationArea = All;
                }

                field(IsExternalType; Rec.IsExternalType)
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