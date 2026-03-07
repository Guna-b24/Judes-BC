page 70044 "Bonus Misc Add/Deductions"
{
    PageType = List;
    SourceTable = "Bonus Misc Add/Deductions";
    ApplicationArea = All;
    UsageCategory = Lists;
    Caption = 'Bonus Misc Add/Deductions';

    layout
    {
        area(Content)
        {
            repeater(Group)
            {
                field("Location Code"; Rec."Location Code")
                {
                    ApplicationArea = All;
                }

                field("Salary Plan Code"; Rec."Salary Plan Code")
                {
                    ApplicationArea = All;
                }

                field("Bonus ID."; Rec."Bonus ID.")
                {
                    ApplicationArea = All;
                }

                field("Bonus Year Code"; Rec."Bonus Year Code")
                {
                    ApplicationArea = All;
                }

                field("Employee No."; Rec."Employee No.")
                {
                    ApplicationArea = All;
                }

                field(Name; Rec.Name)
                {
                    ApplicationArea = All;
                }

                field("Pay Element Code"; Rec."Pay Element Code")
                {
                    ApplicationArea = All;
                }

                field("Paid Category"; Rec."Paid Category")
                {
                    ApplicationArea = All;
                }

                field("Pay Type"; Rec."Pay Type")
                {
                    ApplicationArea = All;
                }

                field(Amount; Rec.Amount)
                {
                    ApplicationArea = All;
                }

                field("CL / EL Paid Days"; Rec."CL / EL Paid Days")
                {
                    ApplicationArea = All;
                }

                field(Month; Rec.Month)
                {
                    ApplicationArea = All;
                }

                field(Year; Rec.Year)
                {
                    ApplicationArea = All;
                }

                field("Bonus Start Date"; Rec."Bonus Start Date")
                {
                    ApplicationArea = All;
                }

                field("Bonus End Date"; Rec."Bonus End Date")
                {
                    ApplicationArea = All;
                }

                field("System Generated"; Rec."System Generated")
                {
                    ApplicationArea = All;
                }

                field("Created Date"; Rec."Created Date")
                {
                    ApplicationArea = All;
                }
            }
        }
    }
    actions
    {
        area(Processing)
        {
            action(GetEmployees)
            {
                Caption = 'Get Employees';
                ApplicationArea = All;
                Image = Process;

                trigger OnAction()
                var
                    BonusMgmt: Codeunit "Bonus Creation";
                begin
                    BonusMgmt.GetEmployees(Rec);
                    CurrPage.Update();
                end;
            }
        }
    }
}
