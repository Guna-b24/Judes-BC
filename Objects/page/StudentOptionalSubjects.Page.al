page 71139 "Student Optional Subjects"
{
    PageType = List;
    SourceTable = "Student Optional Subjects";
    ApplicationArea = All;
    Caption = 'Student Optional Subjects';
    UsageCategory = Lists;

    layout
    {
        area(Content)
        {
            repeater(Groups)
            {
                field("Student No"; Rec."Student No")
                {
                    ApplicationArea = All;
                }

                field("Class Code"; Rec."Class Code")
                {
                    ApplicationArea = All;
                }

                field("Subject Group"; Rec."Subject Group")
                {
                    ApplicationArea = All;
                }

                field(Subject; Rec.Subject)
                {
                    ApplicationArea = All;
                }

                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                    Editable = false;
                }

                field(Group; Rec.Group)
                {
                    ApplicationArea = All;
                }

                field("Class 9 10 Group Code"; Rec."Class 9 10 Group Code")
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