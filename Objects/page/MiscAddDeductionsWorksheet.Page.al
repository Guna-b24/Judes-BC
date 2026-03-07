page 72227 "Misc Add/Deductions Worksheet"
{
    PageType = Worksheet;
    SourceTable = "Misc Add/Deductions";
    ApplicationArea = All;
    Editable = true;
    UsageCategory = Tasks;

    layout
    {
        area(Content)
        {
            repeater(Group)
            {
                field("Location Code"; Rec."Location Code")
                {
                    Caption = 'Location Code';
                    ToolTip = 'Specifies the location code for the employee.';
                    ApplicationArea = All;
                }

                field("Salary Plan Code"; Rec."Salary Plan Code")
                {
                    Caption = 'Salary Plan Code';
                    ToolTip = 'Specifies the salary plan code applicable to this record.';
                    ApplicationArea = All;
                }

                field("Salary Cycle Code"; Rec."Salary Cycle Code")
                {
                    Caption = 'Salary Cycle Code';
                    ToolTip = 'Specifies the salary cycle for which this record is valid.';
                    ApplicationArea = All;
                }

                field("Employee No"; Rec."Employee No")
                {
                    Caption = 'Employee No';
                    ToolTip = 'Employee identifier.';
                    TableRelation = Employee;
                    ApplicationArea = All;
                }

                field("Pay Element Code"; Rec."Pay Element Code")
                {
                    Caption = 'Pay Element Code';
                    ToolTip = 'Pay element for this employee in the selected location and salary plan.';
                    TableRelation = "Pay Elements" WHERE("Location Code" = FIELD("Location Code"),
                                                         "Salary Plan Code" = FIELD("Salary Plan Code"));
                    ApplicationArea = All;
                }

                field(Name; Rec.Name)
                {
                    Caption = 'Name';
                    ToolTip = 'Name of the employee or pay element.';
                    ApplicationArea = All;
                }

                field("Employee Category"; Rec."Employee Category")
                {
                    Caption = 'Employee Category';
                    ToolTip = 'Category of the employee (Monthly/Yearly).';
                    ApplicationArea = All;
                }

                field("Pay Type"; Rec."Pay Type")
                {
                    Caption = 'Pay Type';
                    ToolTip = 'Type of payment (Addition, Deduction, Reimbursement).';
                    ApplicationArea = All;
                }

                field(Amount; Rec.Amount)
                {
                    Caption = 'Amount';
                    ToolTip = 'Amount for this add/deduction record.';
                    ApplicationArea = All;
                }

                field("Payroll Start Date"; Rec."Payroll Start Date")
                {
                    Caption = 'Payroll Start Date';
                    ToolTip = 'Start date of the payroll period.';
                    ApplicationArea = All;
                }

                field("Payroll End Date"; Rec."Payroll End Date")
                {
                    Caption = 'Payroll End Date';
                    ToolTip = 'End date of the payroll period.';
                    ApplicationArea = All;
                }

                field(Year; Rec.Year)
                {
                    Caption = 'Year';
                    ToolTip = 'Year of the payroll period.';
                    ApplicationArea = All;
                }

                field(Month; Rec.Month)
                {
                    Caption = 'Month';
                    ToolTip = 'Month of the payroll period.';
                    ApplicationArea = All;
                }

                field("Created Date"; Rec."Created Date")
                {
                    Caption = 'Created Date';
                    ToolTip = 'Date this record was created.';
                    ApplicationArea = All;
                }

                field("Element Type"; Rec."Element Type")
                {
                    Caption = 'Element Type';
                    ToolTip = 'Type of element, e.g., OT Calculation.';
                    ApplicationArea = All;
                }

                field("Total OT Hours"; Rec."Total OT Hours")
                {
                    Caption = 'Total OT Hours';
                    ToolTip = 'Total number of overtime hours.';
                    ApplicationArea = All;
                }

                field("OT Type"; Rec."OT Type")
                {
                    Caption = 'OT Type';
                    ToolTip = 'Type of overtime calculation.';
                    ApplicationArea = All;
                }

                field("OT Fixed Amount"; Rec."OT Fixed Amount")
                {
                    Caption = 'OT Fixed Amount';
                    ToolTip = 'Fixed amount for overtime, if applicable.';
                    ApplicationArea = All;
                }

                field("Paid Category"; Rec."Paid Category")
                {
                    Caption = 'Paid Category';
                    ToolTip = 'Category of payment (Monthly, Yearly, Daily).';
                    ApplicationArea = All;
                }

                field(Gender; Rec.Gender)
                {
                    Caption = 'Gender';
                    ToolTip = 'Gender of the employee.';
                    ApplicationArea = All;
                }

                field("Pay Category"; Rec."Pay Category")
                {
                    Caption = 'Pay Category';
                    ToolTip = 'Category of employee for payment purposes.';
                    ApplicationArea = All;
                }
                field(FixedYesNo; FixedYesNo)
                {
                    Caption = 'Fixed Amount?';
                    ApplicationArea = All;
                }

                field(FixedAmount; FixedAmount)
                {
                    Caption = 'Fixed Amount';
                    ApplicationArea = All;
                }

                field(OTYesNo; OTYesNo)
                {
                    Caption = 'Calculate OT?';
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
                ToolTip = 'Get the employee Details';
                Image = new;
                trigger OnAction()
                begin
                    CU_MiscAddDeductions.CalculateEmployees(
                        Rec."Payroll Start Date",
                        Rec."Payroll End Date",
                        Rec."Location Code",
                        Rec."Salary Plan Code",
                        Rec."Salary Cycle Code",
                        Rec."Pay Element Code",
                        FixedYesNo,
                        FixedAmount,
                        OTYesNo
                    );
                    CurrPage.Update();
                end;
            }
        }
    }
    var
        CU_MiscAddDeductions: Codeunit "Income Tax Creation / Posting";
        FixedYesNo: Boolean;
        FixedAmount: Decimal;
        OTYesNo: Boolean;
}