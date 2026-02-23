page 70059 "Class Evaluation List"
{
    Caption = 'Class Evaluation List';
    PageType = List;
    SourceTable = "Class Evaluation";
    ApplicationArea = All;
    UsageCategory = Lists;
    CardPageId = "Class Evaluation Card";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(Class; Rec.Class)
                {
                    ApplicationArea = All;
                }
                field(Curriculum; Rec.Curriculum)
                {
                    ApplicationArea = All;
                }
                field("Academic Year"; Rec."Academic Year")
                {
                    ApplicationArea = All;
                }
                field("Evaluation Method Code"; Rec."Evaluation Method Code")
                {
                    ApplicationArea = All;
                }
                field("Maximum Mark"; Rec."Maximum Mark")
                {
                    ApplicationArea = All;
                }
                field("Pass Mark"; Rec."Pass Mark")
                {
                    ApplicationArea = All;
                }
                field(Weightage; Rec.Weightage)
                {
                    ApplicationArea = All;
                }
                field(Compulsory; Rec.Compulsory)
                {
                    ApplicationArea = All;
                }
            }
        }
    }
}