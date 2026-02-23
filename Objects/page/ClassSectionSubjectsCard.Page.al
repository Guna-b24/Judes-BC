page 71032 "Class Section Subjects Card"
{
    PageType = Card;
    SourceTable = "Class Section Subjects";
    Caption = 'Class Section Subject Card';
    ApplicationArea = All;
    UsageCategory = Lists;

    layout
    {
        area(Content)
        {
            group(General)
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
            }

            group(SubjectDetails)
            {
                field(Subject; Rec.Subject)
                {
                    ApplicationArea = All;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field(Type; Rec.Type)
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Subject Group"; Rec."Subject Group")
                {
                    ApplicationArea = All;
                }
                field("II Lang Type"; Rec."II Lang Type")
                {
                    ApplicationArea = All;
                }
                field("Class IX and  X Group"; Rec."Class IX and  X Group")
                {
                    ApplicationArea = All;
                }
            }

            group(Marks)
            {
                field("Maximum Mark"; Rec."Maximum Mark")
                {
                    ApplicationArea = All;
                }
                field("Pass Mark"; Rec."Pass Mark")
                {
                    ApplicationArea = All;
                }
            }

            group(Assignment)
            {
                field("Subject Teacher"; Rec."Subject Teacher")
                {
                    ApplicationArea = All;
                }
                field("Group Code"; Rec."Group Code")
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
}