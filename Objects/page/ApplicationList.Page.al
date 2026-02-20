page 70024 "Application List"
{
    PageType = List;
    SourceTable = Application;
    ApplicationArea = All;
    UsageCategory = Lists;
    CardPageId = "Application Card";
    Caption = 'Applications';

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                }

                field("Name of the pupil"; Rec."Name of the pupil")
                {
                    ApplicationArea = All;
                }

                field(Class; Rec.Class)
                {
                    ApplicationArea = All;
                }

                field("Curriculum Intrested"; Rec."Curriculum Intrested")
                {
                    ApplicationArea = All;
                }

                field("Academic Year"; Rec."Academic Year")
                {
                    ApplicationArea = All;
                }

                field("Application Status"; Rec."Application Status")
                {
                    ApplicationArea = All;
                }

                field("Mobile Number"; Rec."Mobile Number")
                {
                    ApplicationArea = All;
                }

                field("Registration Date"; Rec."Registration Date")
                {
                    ApplicationArea = All;
                }
            }
        }
    }
}
