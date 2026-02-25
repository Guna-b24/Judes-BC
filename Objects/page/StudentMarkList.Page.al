page 71136 "Student Mark List"
{
    PageType = List;
    SourceTable = "Student Mark Header";
    ApplicationArea = All;
    Caption = 'Student Mark List';
    UsageCategory = Lists;
    CardPageId = "Student Mark Card";

    layout
    {
        area(Content)
        {
            repeater(Group)
            {
                field("Student No."; Rec."Student No.")
                {
                    ApplicationArea = All;
                }

                field(Name; Rec.Name)
                {
                    ApplicationArea = All;
                }

                field(Class; Rec.Class)
                {
                    ApplicationArea = All;
                }

                field(Section; Rec.Section)
                {
                    ApplicationArea = All;
                }

                field("Academic Year"; Rec."Academic Year")
                {
                    ApplicationArea = All;
                }

                field("Exam Type"; Rec."Exam Type")
                {
                    ApplicationArea = All;
                }

                field("Total Marks"; Rec."Total Marks")
                {
                    ApplicationArea = All;
                }

                field(Average; Rec.Average)
                {
                    ApplicationArea = All;
                }

                field(Rank; Rec.Rank)
                {
                    ApplicationArea = All;
                }

                field(Grade; Rec.Grade)
                {
                    ApplicationArea = All;
                }

                field(Published; Rec.Published)
                {
                    ApplicationArea = All;
                }
            }
        }
    }
}