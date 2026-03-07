page 72086 "Payroll Year Card"
{
    PageType = Card;
    SourceTable = "Payroll Year";
    ApplicationArea = All;
    Caption = 'Payroll Year';
    UsageCategory = Administration;
    Editable = true;

    layout
    {
        area(content)
        {
            group("General Info")
            {
                field("Location Code"; Rec."Location Code") { ApplicationArea = All; }
                field("Salary Plan Code"; Rec."Salary Plan Code") { ApplicationArea = All; }
                field("Year Code"; Rec."Year Code") { ApplicationArea = All; }
                field("Year Type"; Rec."Year Type") { ApplicationArea = All; }
                field("Year Start Date"; Rec."Year Start Date") { ApplicationArea = All; }
                field("Year End Date"; Rec."Year End Date") { ApplicationArea = All; }
                field(Closed; Rec.Closed) { ApplicationArea = All; }
                field(Created; Rec.Created) { ApplicationArea = All; }
            }

            group("Payroll Month Info")
            {
                field("Salary Cyclic Code Generated"; Rec."Salary Cyclic Code Generated") { ApplicationArea = All; }
            }

            group("Acknowledgements")
            {
                field("Acknowledgement No 1"; Rec."Acknowledgement No 1") { ApplicationArea = All; }
                field("Acknowledgement Date 1"; Rec."Acknowledgement Date 1") { ApplicationArea = All; }
                field("Acknowledgement No 2"; Rec."Acknowledgement No 2") { ApplicationArea = All; }
                field("Acknowledgement Date 2"; Rec."Acknowledgement Date 2") { ApplicationArea = All; }
                field("Acknowledgement No 3"; Rec."Acknowledgement No 3") { ApplicationArea = All; }
                field("Acknowledgement Date 3"; Rec."Acknowledgement Date 3") { ApplicationArea = All; }
                field("Acknowledgement No 4"; Rec."Acknowledgement No 4") { ApplicationArea = All; }
                field("Acknowledgement Date 4"; Rec."Acknowledgement Date 4") { ApplicationArea = All; }
            }
        }
    }

}