page 70023 "Application Co-Curricular List"
{
    PageType = List;
    SourceTable = "Application Co-Curricular";
    ApplicationArea = All;
    UsageCategory = Lists;
    CardPageId = "Application Co-Curricular Card";
    Caption = 'Application Co-Curricular';

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

                field("Student No."; Rec."Student No.")
                {
                    ApplicationArea = All;
                }

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
                }

                field("Portal ID"; Rec."Portal ID")
                {
                    ApplicationArea = All;
                }
            }
        }
    }
}
