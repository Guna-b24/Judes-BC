page 70037 "Arrears Header Line SubPage"
{
    PageType = ListPart;
    SourceTable = "Arrears Header Line";
    ApplicationArea = All;
    Caption = 'Arrears Employees';
    AutoSplitKey = true;

    layout
    {
        area(Content)
        {
            repeater(Group)
            {
                field("Employee No"; Rec."Employee No")
                {
                    ApplicationArea = All;
                }
                field(Name; Rec.Name)
                {
                    ApplicationArea = All;
                }
                field("Location Code"; Rec."Location Code")
                {
                    ApplicationArea = All;
                }
                field("Salary Plan Code"; Rec."Salary Plan Code")
                {
                    ApplicationArea = All;
                }
                field("Total Arrear Amount"; Rec."Total Arrear Amount")
                {
                    ApplicationArea = All;
                }
            }
        }
    }
}
