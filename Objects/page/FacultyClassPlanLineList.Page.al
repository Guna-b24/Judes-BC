page 71073 "Faculty Class Plan Line List"
{
    PageType = List;
    SourceTable = "Faculty Class Plan Line";
    ApplicationArea = All;
    UsageCategory = Lists;
    CardPageId = "Faculty Class Plan Subform";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Document No."; rec."Document No.") { ApplicationArea = All; }
                field("Line No."; rec."Line No.") { ApplicationArea = All; }
                field("Class Code"; rec."Class Code") { ApplicationArea = All; }
                field("Curriculam Code"; rec."Curriculam Code") { ApplicationArea = All; }
                field("Subject Code"; rec."Subject Code") { ApplicationArea = All; }
                field("Unit Code"; rec."Unit Code") { ApplicationArea = All; }
                field("Chapter Code"; rec."Chapter Code") { ApplicationArea = All; }
                field(Week; rec.Week) { ApplicationArea = All; }
                field(Period; rec.Period) { ApplicationArea = All; }
                field("Work Status"; rec."Work Status") { ApplicationArea = All; }
                field("Scheduled Date"; rec."Scheduled Date") { ApplicationArea = All; }
                field("Actual Date"; rec."Actual Date") { ApplicationArea = All; }
            }
        }
    }
}
