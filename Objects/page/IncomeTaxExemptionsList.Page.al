page 72103 "Income Tax Exemptions List"
{
    PageType = List;
    SourceTable = "Income Tax Exemptions";
    ApplicationArea = All;
    UsageCategory = Lists;
    Caption = 'Income Tax Exemptions';
    CardPageId = "Income Tax Exemptions";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Employee No."; Rec."Employee No.")
                {
                    ApplicationArea = All;
                }
                field(Name; Rec.Name)
                {
                    ApplicationArea = All;
                }
                field("Excemption Type"; Rec."Excemption Type")
                {
                    ApplicationArea = All;
                }
                field("Exemption No."; Rec."Exemption No.")
                {
                    ApplicationArea = All;
                }
                field(Details; Rec.Details)
                {
                    ApplicationArea = All;
                }
                field(Amount; Rec.Amount)
                {
                    ApplicationArea = All;
                }
                field("Metro/Non Metro"; Rec."Metro/Non Metro")
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
                field("Salary Year Code"; Rec."Salary Year Code")
                {
                    ApplicationArea = All;
                }
                field("Effective Date"; Rec."Effective Date")
                {
                    ApplicationArea = All;
                }
                field(Year; Rec.Year)
                {
                    ApplicationArea = All;
                }
                field(Month; Rec.Month)
                {
                    ApplicationArea = All;
                }
            }
        }
    }
}