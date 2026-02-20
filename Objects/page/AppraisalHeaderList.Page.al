page 70032 "Appraisal Header List"
{
    PageType = List;
    SourceTable = "Appraisal Header";
    ApplicationArea = All;
    UsageCategory = Lists;
    Caption = 'Appraisal List';
    CardPageId = "Appraisal Header Card";

    layout
    {
        area(Content)
        {
            repeater(Group)
            {
                field("App No."; Rec."App No.")
                {
                    ApplicationArea = All;
                }
                field("Employee No"; Rec."Employee No")
                {
                    ApplicationArea = All;
                }
                field("Employee Name"; Rec."Employee Name")
                {
                    ApplicationArea = All;
                }
                field("Department Description"; Rec."Department Description")
                {
                    ApplicationArea = All;
                }
                field("Designation Description"; Rec."Designation Description")
                {
                    ApplicationArea = All;
                }
                field(Year; Rec.Year)
                {
                    ApplicationArea = All;
                }
                field("Review Type"; Rec."Review Type")
                {
                    ApplicationArea = All;
                }
                field("Review Status"; Rec."Review Status")
                {
                    ApplicationArea = All;
                }
                field(Post; Rec.Post)
                {
                    ApplicationArea = All;
                }
            }
        }
    }
}
