page 71017 "Admission Grade Card"
{
    PageType = Card;
    SourceTable = "Admission Grade";
    ApplicationArea = All;
    Caption = 'Admission Grade';

    layout
    {
        area(Content)
        {
            group(General)
            {
                field(Code; Rec.Code)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the unique code for the admission grade.';
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the description of the admission grade.';
                }
                field("Academic Year"; Rec."Academic Year")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the academic year for which the admission grade applies.';
                }
            }

            group("Marks Setup")
            {
                field("Obtained Mark"; Rec."Obtained Mark")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the marks obtained for the admission criteria.';
                }
                field("Maximum Mark"; Rec."Maximum Mark")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the maximum marks possible for the admission criteria.';
                }
            }

            group(Integration)
            {
                field("Portal ID"; Rec."Portal ID")
                {
                    ApplicationArea = All;
                }
            }
        }
    }
}
