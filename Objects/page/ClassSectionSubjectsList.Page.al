page 71031 "Class Section Subjects List"
{
    PageType = List;
    SourceTable = "Class Section Subjects";
    Caption = 'Class Section Subjects';
    ApplicationArea = All;
    UsageCategory = Lists;
    CardPageId = "Class Section Subjects Card";

    layout
    {
        area(Content)
        {
            repeater(Group)
            {
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
                field("Subject Teacher"; Rec."Subject Teacher")
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