page 72023 "Appraisal Line List"
{
    PageType = List;
    SourceTable = "Appraisal Line";
    ApplicationArea = All;
    UsageCategory = Lists;
    Caption = 'Appraisal Line List';
    Editable = true;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("App No."; Rec."App No.")
                {
                    ApplicationArea = All;
                }
                field("Employee No"; Rec."Employee No")
                {
                    ApplicationArea = All;
                }
                field("Objectives Code"; Rec."Objectives Code")
                {
                    ApplicationArea = All;
                }
                field("Objectives Description"; Rec."Objectives Description")
                {
                    ApplicationArea = All;
                }
                field("Self Rating %"; Rec."Self Rating %")
                {
                    ApplicationArea = All;
                }
                field(Performance; Rec.Performance)
                {
                    ApplicationArea = All;
                }
                field("Positive Attitude"; Rec."Positive Attitude")
                {
                    ApplicationArea = All;
                }
                field("Future Responsibility"; Rec."Future Responsibility")
                {
                    ApplicationArea = All;
                }
                field("Training Code"; Rec."Training Code")
                {
                    ApplicationArea = All;
                }
                field("Training Description"; Rec."Training Description")
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
        }
    }
}