page 71174 "Faculty Class Plan Subform"
{
    PageType = ListPart;
    SourceTable = "Faculty Class Plan Line";
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(Lines)
            {
                field("Line No."; rec."Line No.") { ApplicationArea = All; }
                field("Class Code"; rec."Class Code") { ApplicationArea = All; }
                field("Curriculam Code"; rec."Curriculam Code") { ApplicationArea = All; }
                field("Subject Code"; rec."Subject Code") { ApplicationArea = All; }
                field("Section Code"; rec."Section Code") { ApplicationArea = All; }
                field("Unit Code"; rec."Unit Code") { ApplicationArea = All; }
                field("Unit Name"; rec."Unit Name") { ApplicationArea = All; }
                field("Chapter Code"; rec."Chapter Code") { ApplicationArea = All; }
                field("Chapter Name"; rec."Chapter Name") { ApplicationArea = All; }
                field(Week; rec.Week) { ApplicationArea = All; }
                field(Period; rec.Period) { ApplicationArea = All; }
                field("No of Minuites"; rec."No of Minuites") { ApplicationArea = All; }
                field("Learning OutCome"; rec."Learning OutCome") { ApplicationArea = All; }
                field(Assesment; rec.Assesment) { ApplicationArea = All; }
                field("Work Status"; rec."Work Status") { ApplicationArea = All; }
                field("Scheduled Date"; rec."Scheduled Date") { ApplicationArea = All; }
                field("Actual Date"; rec."Actual Date") { ApplicationArea = All; }
            }
        }
    }
}
