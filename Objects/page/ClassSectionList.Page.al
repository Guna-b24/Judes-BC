page 70065 "Class Section List"
{
    Caption = 'Class Section List';
    PageType = List;
    SourceTable = "Class Section";
    ApplicationArea = All;
    UsageCategory = Lists;
    CardPageId = "Class Section Card";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Class Code"; Rec."Class Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the combined class and section code.';
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
                field(Capacity; Rec.Capacity)
                {
                    ApplicationArea = All;
                }
                field("Present Strength"; Rec."Present Strength")
                {
                    ApplicationArea = All;
                }
                field("Class Teacher"; Rec."Class Teacher")
                {
                    ApplicationArea = All;
                }
                field(Promoted; Rec.Promoted)
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    trigger OnOpenPage()
    begin
        Rec.SetCurrentKey(Class, Curriculum, "Academic Year");
    end;
}