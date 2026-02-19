page 71114 "Admission Grade List"
{
    PageType = List;
    SourceTable = "Admission Grade";
    ApplicationArea = All;
    UsageCategory = Lists;
    CardPageId = "Admission Grade Card";
    Caption = 'Admission Grades';

    SourceTableView = sorting("Academic Year", Code);

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("Academic Year"; Rec."Academic Year")
                {
                    ApplicationArea = All;
                }
                field(Code; Rec.Code)
                {
                    ApplicationArea = All;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                }
                field("Obtained Mark"; Rec."Obtained Mark")
                {
                    ApplicationArea = All;
                }
                field("Maximum Mark"; Rec."Maximum Mark")
                {
                    ApplicationArea = All;
                }
            }
        }
    }
}
