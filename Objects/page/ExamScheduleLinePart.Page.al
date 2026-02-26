page 71166 "Exam Schedule Line Part"
{
    PageType = ListPart;
    SourceTable = "Exam Schedule Line - SCH";
    ApplicationArea = All;
    Caption = 'Exam Schedule Lines';
    Editable = true;

    layout
    {
        area(Content)
        {
            repeater(Group)
            {
                field("Line No."; Rec."Line No.") { }
                field(Class; Rec.Class) { }
                field(Section; Rec.Section) { }
                field(Curriculum; Rec.Curriculum) { }
                field("Subject Code"; Rec."Subject Code") { }
                field("Hall Code"; Rec."Hall Code") { }
                field("No of Students"; Rec."No of Students") { }
                field("Examiner Type"; Rec."Examiner Type") { }
                field("Examiner Code"; Rec."Examiner Code") { }
                field("Start Time"; Rec."Start Time") { }
                field("End Time"; Rec."End Time") { }
                field("Exam Slot"; Rec."Exam Slot") { }
                field("Exam Date"; Rec."Exam Date") { }
                field("Exam Code"; Rec."Exam Code") { }
            }
        }
    }

    actions
    {

    }
}