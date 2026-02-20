page 70019 "Applicant Evaluation List"
{
    PageType = List;
    SourceTable = "Applicant Evaluation";
    ApplicationArea = All;
    UsageCategory = Lists;
    Caption = 'Applicant Evaluations';

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Application No."; Rec."Application No.")
                {
                    ApplicationArea = All;
                }

                field("Applicant Name"; Rec."Applicant Name")
                {
                    ApplicationArea = All;
                }

                field(Class; Rec.Class)
                {
                    ApplicationArea = All;
                }

                field("Evaluation Method Code"; Rec."Evaluation Method Code")
                {
                    ApplicationArea = All;
                }

                field(Desription; Rec.Desription)
                {
                    ApplicationArea = All;
                }

                field("Maximum Mark"; Rec."Maximum Mark")
                {
                    ApplicationArea = All;
                }

                field("Mark Obtained"; Rec."Mark Obtained")
                {
                    ApplicationArea = All;
                }

                field("Pass Mark"; Rec."Pass Mark")
                {
                    ApplicationArea = All;
                }

                field("Attendance Status"; Rec."Attendance Status")
                {
                    ApplicationArea = All;
                }

                field(Weightage; Rec.Weightage)
                {
                    ApplicationArea = All;
                }

                field("Evaluation No."; Rec."Evaluation No.")
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
