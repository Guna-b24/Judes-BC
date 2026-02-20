page 70026 "Application Mark Card"
{
    PageType = Card;
    SourceTable = "Application Mark";
    ApplicationArea = All;
    UsageCategory = Administration;
    Caption = 'Application Mark';

    layout
    {
        area(content)
        {
            group(General)
            {
                field("Application No"; Rec."Application No")
                {
                    ApplicationArea = All;
                }

                field("Academic Year"; Rec."Academic Year")
                {
                    ApplicationArea = All;
                }

                field("Subject Code"; Rec."Subject Code")
                {
                    ApplicationArea = All;
                }

                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                    Editable = false;
                }
            }

            group(Marks)
            {
                field("Mark Obtained"; Rec."Mark Obtained")
                {
                    ApplicationArea = All;
                }

                field(Maximum; Rec.Maximum)
                {
                    ApplicationArea = All;
                }

                field(Grade; Rec.Grade)
                {
                    ApplicationArea = All;
                }
            }

            group("Exam Details")
            {
                field(Month; Rec.Month)
                {
                    ApplicationArea = All;
                }

                field("Year of passing"; Rec."Year of passing")
                {
                    ApplicationArea = All;
                }

                field("Register Number"; Rec."Register Number")
                {
                    ApplicationArea = All;
                }

                field("Exam Code"; Rec."Exam Code")
                {
                    ApplicationArea = All;
                }
            }

            group(System)
            {
                field("Portal ID"; Rec."Portal ID")
                {
                    ApplicationArea = All;
                }
            }
        }
    }
}
