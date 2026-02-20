page 70027 "Application Mark List"
{
    PageType = List;
    SourceTable = "Application Mark";
    ApplicationArea = All;
    UsageCategory = Lists;
    CardPageId = "Application Mark Card";
    Caption = 'Application Marks';

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Application No"; Rec."Application No")
                {
                    ApplicationArea = All;
                }

                field("Subject Code"; Rec."Subject Code")
                {
                    ApplicationArea = All;
                }

                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                }

                field("Mark Obtained"; Rec."Mark Obtained")
                {
                    ApplicationArea = All;
                }

                field(Maximum; Rec.Maximum)
                {
                    ApplicationArea = All;
                }

                field(Grade; Rec.Grade)
                {
                    ApplicationArea = All;
                }

                field("Academic Year"; Rec."Academic Year")
                {
                    ApplicationArea = All;
                }
            }
        }
    }
}
