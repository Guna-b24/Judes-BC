page 71067 "Exam Schedule Line List - SCH"
{
    PageType = List;
    SourceTable = "Exam Schedule Line - SCH";
    ApplicationArea = All;
    UsageCategory = Lists;
    Caption = 'Exam Schedule Lines';
    Editable = true;
    CardPageId = "Exam Schedule Line Part";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Document No."; Rec."Document No.")
                {
                    ApplicationArea = All;
                }
                field("Line No."; Rec."Line No.")
                {
                    ApplicationArea = All;
                }
                field("Class Code"; Rec."Class Code")
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
                field(Curriculum; Rec.Curriculum)
                {
                    ApplicationArea = All;
                }
                field("Subject Code"; Rec."Subject Code")
                {
                    ApplicationArea = All;
                }
                field("Exam Code"; Rec."Exam Code")
                {
                    ApplicationArea = All;
                }
                field("Exam Date"; Rec."Exam Date")
                {
                    ApplicationArea = All;
                }
                field("Exam Slot"; Rec."Exam Slot")
                {
                    ApplicationArea = All;
                }
                field("Start Time"; Rec."Start Time")
                {
                    ApplicationArea = All;
                }
                field("End Time"; Rec."End Time")
                {
                    ApplicationArea = All;
                }
                field("Hall Code"; Rec."Hall Code")
                {
                    ApplicationArea = All;
                }
                field("No of Students"; Rec."No of Students")
                {
                    ApplicationArea = All;
                }
                field("Examiner Type"; Rec."Examiner Type")
                {
                    ApplicationArea = All;
                }
                field("Examiner Code"; Rec."Examiner Code")
                {
                    ApplicationArea = All;
                }
                field("Academic Year"; Rec."Academic Year")
                {
                    ApplicationArea = All;
                }
                field("Mark Header Code"; Rec."Mark Header Code")
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

    actions
    {
        area(processing)
        {
        }
    }
}