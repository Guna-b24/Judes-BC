page 70034 "Appraisal Line SubPage"
{
    PageType = ListPart;
    SourceTable = "Appraisal Line";
    ApplicationArea = All;
    Caption = 'Appraisal Lines';
    AutoSplitKey = true;

    layout
    {
        area(Content)
        {
            repeater(Group)
            {
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
}
