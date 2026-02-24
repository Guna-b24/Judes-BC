page 72263 "LocationHR & PayrollSetup List"
{
    PageType = List;
    SourceTable = "Location HR & Payroll Setup";
    ApplicationArea = All;
    UsageCategory = Lists;
    CardPageId = "LocationHR & PayrollSetup Card";

    layout
    {
        area(Content)
        {
            repeater(Group)
            {
                field("Location Code"; Rec."Location Code") { }
                field("Location Name"; Rec."Location Name") { }
                field("Salary Plan Code"; Rec."Salary Plan Code") { }
                field("Salary Cyclic Code"; Rec."Salary Cyclic Code") { }
                field("Processing Payroll Date"; Rec."Processing Payroll Date") { }
                field("Over Time Applicable"; Rec."Over Time Applicable") { }
                field("Bonus Applicable"; Rec."Bonus Applicable") { }
                field("Gratuity Applicable"; Rec."Gratuity Applicable") { }
                field("PF Establishment No"; Rec."PF Establishment No") { }
                field("ESI Establishment No"; Rec."ESI Establishment No") { }
            }
        }
    }
}