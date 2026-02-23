page 71062 "Class Subjects List"
{
    PageType = List;
    SourceTable = "Class Subjects";
    Caption = 'Class Subjects';
    ApplicationArea = All;
    UsageCategory = Lists;
    CardPageId = "Class Subjects Card";

    layout
    {
        area(Content)
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
                field(Subject; Rec.Subject)
                {
                    ApplicationArea = All;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                }
                field(Type; Rec.Type)
                {
                    ApplicationArea = All;
                }
                field("Subject Group"; Rec."Subject Group")
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
                field("Subject Order"; Rec."Subject Order")
                {
                    ApplicationArea = All;
                }
                field("Group Code"; Rec."Group Code")
                {
                    ApplicationArea = All;
                }
            }
        }
    }
}