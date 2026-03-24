page 70042 "Bonus Header Card"
{
    PageType = Document;
    SourceTable = "Bonus Header";
    ApplicationArea = All;
    Caption = 'Bonus Header';
    UsageCategory = Administration;

    layout
    {
        area(Content)
        {
            group(General)
            {
                field("Bonus Id."; Rec."Bonus Id.")
                {
                    ApplicationArea = All;
                    trigger OnAssistEdit()
                    begin
                        if Rec.AssistEdit(xRec) then
                            CurrPage.Update();
                    end;


                }
                field("Location Code"; Rec."Location Code")
                {
                    ApplicationArea = All;
                }
                field("Salary Plan Code"; Rec."Salary Plan Code")
                {
                    ApplicationArea = All;
                }
                field("Bonus Year"; Rec."Bonus Year")
                {
                    ApplicationArea = All;
                }
                field("Employee Category"; Rec."Employee Category")
                {
                    ApplicationArea = All;
                }
            }

            group("Bonus Period")
            {
                field("Bonus Start Date"; Rec."Bonus Start Date")
                {
                    ApplicationArea = All;
                }
                field("Bonus End Date"; Rec."Bonus End Date")
                {
                    ApplicationArea = All;
                }
                field("Bonus Declare Date"; Rec."Bonus Declare Date")
                {
                    ApplicationArea = All;
                }
            }

            group("Eligibility Setup")
            {
                field("Bonus Min No of Years"; Rec."Bonus Min No of Years")
                {
                    ApplicationArea = All;
                }
                field("Bonus Max No of Years"; Rec."Bonus Max No of Years")
                {
                    ApplicationArea = All;
                }
                field("Bonusable Earnings Min Limit"; Rec."Bonusable Earnings Min Limit")
                {
                    ApplicationArea = All;
                }
                field("Bonusable Earnings Max Limit"; Rec."Bonusable Earnings Max Limit")
                {
                    ApplicationArea = All;
                }
            }

            group("Bonus Calculation")
            {
                field("Bonus (%)"; Rec."Bonus (%)")
                {
                    ApplicationArea = All;
                }
                field("Ex-Gratia (%)"; Rec."Ex-Gratia (%)")
                {
                    ApplicationArea = All;
                }
                field("Total Days In a Year"; Rec."Total Days In a Year")
                {
                    ApplicationArea = All;
                }
            }

            group("Leave Days Setup")
            {
                field("Staff Total EL Days"; Rec."Staff Total EL Days")
                {
                    ApplicationArea = All;
                }
                field("Staff Total CL Days"; Rec."Staff Total CL Days")
                {
                    ApplicationArea = All;
                }
                field("Worker Total EL Days"; Rec."Worker Total EL Days")
                {
                    ApplicationArea = All;
                }
                field("Worker Total CL Days"; Rec."Worker Total CL Days")
                {
                    ApplicationArea = All;
                }
            }
            part(BonusLines; "Bonus Line Subform")
            {
                SubPageLink =
        "Bonus Id." = FIELD("Bonus Id."),
        "Location Code" = FIELD("Location Code"),
        "Salary Plan Code" = FIELD("Salary Plan Code"),
        "Bonus Year" = FIELD("Bonus Year");
            }
        }
    }
    actions
    {
        area(Processing)
        {
            action(AllEmployees)
            {
                Caption = 'All Employees';
                ApplicationArea = All;
                Image = New;
                ToolTip = 'Creates bonus records for all eligible employees.';

                trigger OnAction()
                var
                    BonusProcess: Codeunit "Bonus Creation";
                begin
                    BonusProcess."Create Bonus Records"(Rec."Bonus Id.", 'ALL');
                    CurrPage.Update();
                end;
            }
            action(BonusCreation)
            {
                Caption = 'Bonus Creation';
                ApplicationArea = All;
                Image = New;
                ToolTip = 'Creates bonus records for all eligible employees for this bonus.';

                trigger OnAction()
                var
                    BonusProcess: Codeunit "Bonus Creation";
                begin
                    if Confirm('Do you want to create bonus records for all employees?', false) then begin
                        BonusProcess."Create Bonus Records"(Rec."Bonus Id.", 'ALL');
                        CurrPage.Update();
                        Message('Bonus records created successfully.');
                    end;
                end;
            }
            action(UpdateServiceMonth)
            {
                Caption = 'Service Month Updation';
                ApplicationArea = All;
                Image = Calculate;
                ToolTip = 'Calculates and updates service years and service months for all bonus lines.';

                trigger OnAction()
                var
                    BonusLine: Record "Bonus Line";
                    Employee: Record Employee;
                begin
                    BonusLine.SetRange("Bonus Id.", Rec."Bonus Id.");

                    if BonusLine.FindSet() then
                        repeat
                            if Employee.Get(BonusLine."Employee No") then begin

                                BonusLine."Service Year" :=
                                    Round((Today - Employee."Employment Date") / 365.2364, 1, '=');

                                BonusLine."Service Month" :=
                                    Round((Today - Employee."Employment Date") / 30.41, 1, '=');

                                if BonusLine."Service Month" <= 11 then
                                    BonusLine."Service Year" := 0;

                                BonusLine.Modify();
                            end;
                        until BonusLine.Next() = 0;

                    Message('Updated Successfully.');
                    CurrPage.Update();
                end;
            }
            action(UpdateBonusPercent)
            {
                Caption = 'Update Bonus %';
                ApplicationArea = All;
                Image = Calculate;
                ToolTip = 'Updates bonus and ex-gratia percentages for all bonus lines.';

                trigger OnAction()
                var
                    BonusLine: Record "Bonus Line";
                begin
                    BonusLine.SetRange("Bonus Id.", Rec."Bonus Id.");

                    if BonusLine.FindSet() then
                        repeat
                            BonusLine."Bonus %" := Rec."Bonus (%)";
                            BonusLine."Ex-Gratia %" := Rec."Ex-Gratia (%)";
                            BonusLine.Modify();
                        until BonusLine.Next() = 0;

                    Message('Updated Successfully.');
                    CurrPage.Update();
                end;
            }
            action(UpdateYear)
            {
                Caption = 'Update Year';
                ApplicationArea = All;
                Image = Update;
                ToolTip = 'Updates total days in a year for all bonus lines.';

                trigger OnAction()
                var
                    BonusLine: Record "Bonus Line";
                begin
                    BonusLine.SetRange("Bonus Id.", Rec."Bonus Id.");

                    if BonusLine.FindSet() then
                        repeat
                            BonusLine."Total Days In a Year" := Rec."Total Days In a Year";
                            BonusLine.Modify();
                        until BonusLine.Next() = 0;

                    Message('Updated Successfully.');
                    CurrPage.Update();
                end;
            }

        }
    }
}
