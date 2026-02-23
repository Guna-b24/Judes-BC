page 70060 "Class Evaluation Card"
{
    Caption = 'Class Evaluation Card';
    PageType = Card;
    SourceTable = "Class Evaluation";
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            group(General)
            {
                field(Class; Rec.Class)
                {
                    ApplicationArea = All;
                }
                field(Curriculum; Rec.Curriculum)
                {
                    ApplicationArea = All;
                }
                field("Academic Year"; Rec."Academic Year")
                {
                    ApplicationArea = All;
                }
                field("Evaluation Method Code"; Rec."Evaluation Method Code")
                {
                    ApplicationArea = All;
                }
            }

            group(Marks)
            {
                field("Maximum Mark"; Rec."Maximum Mark")
                {
                    ApplicationArea = All;
                }
                field("Pass Mark"; Rec."Pass Mark")
                {
                    ApplicationArea = All;
                }
                field(Weightage; Rec.Weightage)
                {
                    ApplicationArea = All;
                }
                field("Prequalification Mark"; Rec."Prequalification Mark")
                {
                    ApplicationArea = All;
                }
            }

            group(Settings)
            {
                field(Compulsory; Rec.Compulsory)
                {
                    ApplicationArea = All;
                }
                field("Portal ID"; Rec."Portal ID")
                {
                    ApplicationArea = All;
                }
            }
        }
    }
}