page 72057 "Holidays List"
{
    PageType = List;
    SourceTable = Holidays;
    ApplicationArea = All;
    UsageCategory = Lists;
    Caption = 'Holidays';
    CardPageId = "Hostel Card";

    layout
    {
        area(Content)
        {
            repeater(Group)
            {
                field("Location Code"; Rec."Location Code") { ApplicationArea = All; }
                field("Salary Plan Code"; Rec."Salary Plan Code") { ApplicationArea = All; }
                field("Calendar Year"; Rec."Calendar Year") { ApplicationArea = All; }
                field("Holiday Date"; Rec."Holiday Date") { ApplicationArea = All; }
                field("Holiday Name"; Rec."Holiday Name") { ApplicationArea = All; }
                field("First Half (Holiday)"; Rec."First Half (Holiday)") { ApplicationArea = All; }
                field("Second Half (Holiday)"; Rec."Second Half (Holiday)") { ApplicationArea = All; }
                field("Non Working Days"; Rec."Non Working Days") { ApplicationArea = All; }
                field("OT Applicable for the Day"; Rec."OT Applicable for the Day") { ApplicationArea = All; }
            }
        }
    }
    actions
    {
        area(processing)
        {
            action("Update Holidays")
            {
                ApplicationArea = All;
                Caption = 'Update Holidays';

                trigger OnAction()
                begin
                    Updateholidays.UpdateHolidays();
                    SelectLocation();
                    SelectSalaryPlan();
                    SelectPayrollYear();
                end;
            }
        }
    }

    procedure SelectLocation()
    begin
        Rec.SetRange("Location Code", Rec."Location Code");
        CurrPage.Update(false);
    end;

    procedure SelectSalaryPlan()
    begin
        Rec.SetRange("Salary Plan Code", rec."Salary Plan Code");
        CurrPage.Update(false);
    end;

    procedure SelectPayrollYear()
    begin
        Rec.SetRange("Calendar Year", rec."Calendar Year");
        CurrPage.Update(false);
    end;

    var
        Updateholidays: Codeunit "Payroll Data Creation";

}
