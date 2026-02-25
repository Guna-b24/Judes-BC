page 72183 "Payroll Month & Year List"
{
    PageType = List;
    SourceTable = "Payroll Month & Year";
    ApplicationArea = All;
    Caption = 'Payroll Month & Year';
    UsageCategory = Administration;
    CardPageID = "Payroll Month & Year Card";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Location Code"; Rec."Location Code") { ApplicationArea = All; }
                field("Salary Plan Code"; Rec."Salary Plan Code") { ApplicationArea = All; }
                field("Salary Year Code"; Rec."Salary Year Code") { ApplicationArea = All; }
                field("Salary Cyclic Code"; Rec."Salary Cyclic Code") { ApplicationArea = All; }
                field("Salary Start Date"; Rec."Salary Start Date") { ApplicationArea = All; }
                field("Salary End Date"; Rec."Salary End Date") { ApplicationArea = All; }
                field("Salary Month"; Rec."Salary Month") { ApplicationArea = All; }
                field("Salary Year"; Rec."Salary Year") { ApplicationArea = All; }
                field(Closed; Rec.Closed) { ApplicationArea = All; }
            }
        }
    }
}