page 71080 "House Incharge Line List"
{
    PageType = List;
    SourceTable = "House Incharge Line";
    ApplicationArea = All;
    UsageCategory = Administration;
    Editable = true;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("House Code"; Rec."House Code")
                {
                    ApplicationArea = All;
                }
                field("Staff Code"; Rec."Staff Code")
                {
                    ApplicationArea = All;
                }
                field("Staff Name"; Rec."Staff Name")
                {
                    ApplicationArea = All;
                }
                field("Is Incharge"; Rec."Is Incharge")
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
    }
}
