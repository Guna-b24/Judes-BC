page 70229 "PF Setup"
{
    PageType = List;
    SourceTable = "PF Setup";
    ApplicationArea = All;
    UsageCategory = Administration;
    Caption = 'PF Setup';

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Effective Date"; Rec."Effective Date") { ApplicationArea = All; }
                field("Location Code"; Rec."Location Code") { ApplicationArea = All; }
                field("Salary Plan Code"; Rec."Salary Plan Code") { ApplicationArea = All; }
                field("PF Gross Salary Limit"; Rec."PF Gross Salary Limit") { ApplicationArea = All; }
                field("EPS Gross Salary Limit"; Rec."EPS Gross Salary Limit") { ApplicationArea = All; }
                field("Employee PF (Employee) %"; Rec."Employee PF (Employee) %") { ApplicationArea = All; }
                field("Employer PF (Company) %"; Rec."Employer PF (Company) %") { ApplicationArea = All; }
                field("Employer EPS (Company) %"; Rec."Employer EPS (Company) %") { ApplicationArea = All; }
                field("Employee VPF (Employee) %"; Rec."Employee VPF (Employee) %") { ApplicationArea = All; }
                field("PF Admin Charges %"; Rec."PF Admin Charges %") { ApplicationArea = All; }
                field("PF EDLI %"; Rec."PF EDLI %") { ApplicationArea = All; }
                field("PF RIFA %"; Rec."PF RIFA %") { ApplicationArea = All; }
                field("PF Rounding Amount"; Rec."PF Rounding Amount") { ApplicationArea = All; }
                field("PF Rounding Type"; Rec."PF Rounding Type") { ApplicationArea = All; }
            }
        }
    }
}