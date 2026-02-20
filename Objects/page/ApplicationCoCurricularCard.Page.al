page 70022 "Application Co-Curricular Card"
{
    PageType = Card;
    SourceTable = "Application Co-Curricular";
    ApplicationArea = All;
    UsageCategory = Administration;
    Caption = 'Application Co-Curricular';

    layout
    {
        area(content)
        {
            group(General)
            {
                field("Application No."; Rec."Application No.")
                {
                    ApplicationArea = All;
                }

                field("Student No."; Rec."Student No.")
                {
                    ApplicationArea = All;
                }
            }

            group(Activity)
            {
                field("Co-Curricular Code"; Rec."Co-Curricular Code")
                {
                    ApplicationArea = All;
                }

                field("Classification Code"; Rec."Classification Code")
                {
                    ApplicationArea = All;
                }

                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                    Editable = false;
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
