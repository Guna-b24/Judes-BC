page 72225 "Income Tax Exemptions"
{
    PageType = Worksheet;
    SourceTable = "Income Tax Exemptions";
    ApplicationArea = All;
    UsageCategory = Tasks;
    Caption = 'Income Tax Exemptions';

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Employee No."; Rec."Employee No.")
                {
                    ApplicationArea = All;
                    Caption = 'Employee No.';
                    ToolTip = 'Specifies the employee number for whom the tax exemption is recorded.';
                }

                field(Name; Rec.Name)
                {
                    ApplicationArea = All;
                    Caption = 'Name';
                    ToolTip = 'Specifies the name of the employee.';
                }

                field("Excemption Type"; Rec."Excemption Type")
                {
                    ApplicationArea = All;
                    Caption = 'Exemption Type';
                    ToolTip = 'Specifies the type of income tax exemption such as Rent Paid, Insurance, Medical Bill, etc.';
                }

                field("Exemption No."; Rec."Exemption No.")
                {
                    ApplicationArea = All;
                    Caption = 'Exemption No.';
                    ToolTip = 'Specifies the exemption document or reference number.';
                }

                field(Details; Rec.Details)
                {
                    ApplicationArea = All;
                    Caption = 'Details';
                    ToolTip = 'Specifies additional details about the exemption.';
                }

                field(Amount; Rec.Amount)
                {
                    ApplicationArea = All;
                    Caption = 'Amount';
                    ToolTip = 'Specifies the exemption amount applicable for the employee.';
                }

                field("Metro/Non Metro"; Rec."Metro/Non Metro")
                {
                    ApplicationArea = All;
                    Caption = 'Metro/Non Metro';
                    ToolTip = 'Specifies whether the employee resides in a metro or non-metro city for tax calculation.';
                }

                field("Location Code"; Rec."Location Code")
                {
                    ApplicationArea = All;
                    Caption = 'Location Code';
                    ToolTip = 'Specifies the location associated with the employee payroll.';
                }

                field("Salary Plan Code"; Rec."Salary Plan Code")
                {
                    ApplicationArea = All;
                    Caption = 'Salary Plan Code';
                    ToolTip = 'Specifies the salary plan applicable to the employee.';
                }

                field("Salary Year Code"; Rec."Salary Year Code")
                {
                    ApplicationArea = All;
                    Caption = 'Salary Year Code';
                    ToolTip = 'Specifies the salary year for which the exemption is applicable.';
                }

                field("Payroll Start Date"; Rec."Payroll Start Date")
                {
                    ApplicationArea = All;
                    Caption = 'Payroll Start Date';
                    ToolTip = 'Specifies the starting date of the payroll period.';
                }

                field("Payroll End Date"; Rec."Payroll End Date")
                {
                    ApplicationArea = All;
                    Caption = 'Payroll End Date';
                    ToolTip = 'Specifies the ending date of the payroll period.';
                }

                field(Year; Rec.Year)
                {
                    ApplicationArea = All;
                    Caption = 'Year';
                    ToolTip = 'Specifies the payroll year derived from the payroll start date.';
                }

                field(Month; Rec.Month)
                {
                    ApplicationArea = All;
                    Caption = 'Month';
                    ToolTip = 'Specifies the payroll month derived from the payroll start date.';
                }

                field("Effective Date"; Rec."Effective Date")
                {
                    ApplicationArea = All;
                    Caption = 'Effective Date';
                    ToolTip = 'Specifies the effective date of the tax exemption record.';
                }

                field("Created Date"; Rec."Created Date")
                {
                    ApplicationArea = All;
                    Caption = 'Created Date';
                    ToolTip = 'Specifies the date when the exemption record was created.';
                    Editable = false;
                }
                field(PayElementCode; PayElementCode)
                {
                    Caption = 'Pay Element Code';
                    ApplicationArea = All;
                    TableRelation = "Pay Elements";
                    ToolTip = 'Specifies the pay element to be applied for employee exemption.';
                }
                field(FixedYesNo; FixedYesNo)
                {
                    Caption = 'Fixed Amount Applicable';
                    ApplicationArea = All;
                    ToolTip = 'Specifies whether a fixed exemption amount should be applied.';
                }
                field(FixedAmount; FixedAmount)
                {
                    Caption = 'Fixed Amount';
                    ApplicationArea = All;
                    ToolTip = 'Specifies the fixed exemption amount to apply for employees.';
                }
            }
        }
    }
    actions
    {
        area(processing)
        {
            action(GetEmployees)
            {
                Caption = 'Get Employees';
                Image = GetEntries;
                ToolTip = 'Getting Emplyee Details';

                trigger OnAction()
                var
                    CUIncomeTax: Codeunit "Income Tax Creation / Posting";
                begin
                    CUIncomeTax.GetEmployeesForExemption(
                        Rec."Payroll Start Date",
                        rec."Payroll End Date",
                        rec."Location Code",
                        rec."Salary Plan Code",
                        Rec."Salary Year Code",
                        PayElementCode,
                        FixedYesNo,
                        FixedAmount);

                    Message('Employees Created Successfully');
                end;
            }
        }
    }
    var
        PayElementCode: code[20];
        FixedYesNo: Boolean;

        FixedAmount: Decimal;
}