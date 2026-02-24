page 70125 "HR & Payroll Setup Card"
{
    PageType = Card;
    SourceTable = "HR & Payroll Setup";
    ApplicationArea = All;
    Caption = 'HR & Payroll Setup';
    UsageCategory = Administration;

    layout
    {
        area(Content)
        {
            group(General)
            {
                field("User ID"; Rec."User ID")
                {
                    ApplicationArea = All;
                }
                field("Location Code"; Rec."Location Code")
                {
                    ApplicationArea = All;
                }
                field("Location Name"; Rec."Location Name")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
            }

            group("Salary Details")
            {
                field("Salary Plan Code"; Rec."Salary Plan Code")
                {
                    ApplicationArea = All;
                }
                field("Salary Cyclic Code"; Rec."Salary Cyclic Code")
                {
                    ApplicationArea = All;
                }
                field("Salary Year Code"; Rec."Salary Year Code")
                {
                    ApplicationArea = All;
                }
                field("Salary Start Date"; Rec."Salary Start Date")
                {
                    ApplicationArea = All;
                }
                field("Salary End Date"; Rec."Salary End Date")
                {
                    ApplicationArea = All;
                }
            }

            group("Payment Salary Details")
            {
                field("Payment Salary Plan Code"; Rec."Payment Salary Plan Code")
                {
                    ApplicationArea = All;
                }
                field("Payment Salary Cyclic Code"; Rec."Payment Salary Cyclic Code")
                {
                    ApplicationArea = All;
                }
                field("Payment Salary Year Code"; Rec."Payment Salary Year Code")
                {
                    ApplicationArea = All;
                }
                field("Payment Salary Start Date"; Rec."Payment Salary Start Date")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Payment Salary End Date"; Rec."Payment Salary End Date")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
            }
        }
    }
}