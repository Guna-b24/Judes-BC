page 72056 "Weekly Off List"
{
    PageType = List;
    SourceTable = "Weekly Off";
    Caption = 'Weekly Off';
    ApplicationArea = All;
    UsageCategory = Administration;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Location Code"; Rec."Location Code")
                {
                }
                field("Salary Plan Code"; Rec."Salary Plan Code")
                {
                }
                field("Calendar Year"; Rec."Calendar Year")
                {
                }
                field(Day; Rec.Day)
                {
                }
                field("Week Wise (Weekly Off)"; Rec."Week Wise (Weekly Off)")
                {
                }
                field("First Half (Weekly Off)"; Rec."First Half (Weekly Off)")
                {
                }
                field("Second Half (Weekly Off)"; Rec."Second Half (Weekly Off)")
                {
                }
                field("Non Working Days"; Rec."Non Working Days")
                {
                }
            }
        }
    }
    actions
    {
        area(Processing)
        {
            action(UpdateWeeklyOff)
            {
                Caption = 'Update Weekly Off';
                ApplicationArea = All;
                Image = Recalculate;
                ToolTip = 'Recreates the payroll calendar and weekly off details for the configured salary year.';

                trigger OnAction()
                var
                    PayrollYear: Record "Payroll Year";
                    HRPayrollSetup: Record "HR & Payroll Setup";
                    CalendarCreation: Codeunit "Calendar Creation";
                begin
                    HRPayrollSetup.Get();

                    PayrollYear.Reset();
                    PayrollYear.SetRange("Location Code", HRPayrollSetup."Location Code");
                    PayrollYear.SetRange("Salary Plan Code", HRPayrollSetup."Salary Plan Code");
                    PayrollYear.SetRange("Year Code", HRPayrollSetup."Salary Year Code");
                    PayrollYear.SetRange("Year Type", PayrollYear."Year Type"::"Salary Year");
                    PayrollYear.SetRange(Closed, false);

                    if PayrollYear.FindFirst() then begin
                        PayrollYear.Created := false;
                        PayrollYear.Modify(true);
                        CalendarCreation.Run();
                    end;

                    CurrPage.Update();
                end;
            }
        }
    }
}