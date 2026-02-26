page 70140 "Pay Elements List"
{
    PageType = List;
    SourceTable = "Pay Elements";
    ApplicationArea = All;
    UsageCategory = Administration;
    Caption = 'Pay Elements List';
    Editable = true;
    CardPageId = "Pay Elements Card";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Location Code"; Rec."Location Code")
                {
                    Caption = 'Location Code';
                }
                field("Salary Plan Code"; Rec."Salary Plan Code")
                {
                    Caption = 'Salary Plan Code';
                }
                field("Pay Element Code"; Rec."Pay Element Code")
                {
                    Caption = 'Pay Element Code';
                }
                field(Description; Rec.Description)
                {
                    Caption = 'Description';
                }
                field("Paid Category"; Rec."Paid Category")
                {
                    Caption = 'Paid Category';
                }
                field("Pay Type"; Rec."Pay Type")
                {
                    Caption = 'Pay Type';
                }
            }
        }
    }
}