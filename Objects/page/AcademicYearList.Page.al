page 70004 "Academic Year List"
{
    PageType = List;
    SourceTable = "Academic Year";
    ApplicationArea = All;
    UsageCategory = Lists;
    CardPageId = "Academic Year Card";
    Caption = 'Academic Years';



    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field(Code; Rec.Code)
                {
                    ApplicationArea = All;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                }
                field("Start Date"; Rec."Start Date")
                {
                    ApplicationArea = All;
                }
                field("End Date"; Rec."End Date")
                {
                    ApplicationArea = All;
                }
                field(Closed; Rec.Closed)
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
            action(CloseYear)
            {
                Caption = 'Close Year';
                Image = CloseYear;
                ApplicationArea = All;
                ToolTip = 'Closes the selected academic year. After closing, no further entries or modifications can be made for this year.';

                trigger OnAction()
                var
                    EducationVertical: Codeunit "Education Vertical";
                begin
                    EducationVertical.CloseAcademicYear(Rec.Code);
                    CurrPage.Update();
                end;
            }

            action(AssignYear)
            {
                Caption = 'Assign Year';
                Image = Change;
                ApplicationArea = All;
                ToolTip = 'Assigns the selected academic year as the current active year.';

                trigger OnAction()
                var
                    EducationVertical: Codeunit "Education Vertical";
                begin
                    EducationVertical.AssignAcademicYear(Rec.Code);
                    CurrPage.Update();
                end;
            }
        }
    }
}
