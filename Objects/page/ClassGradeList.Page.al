page 70061 "Class Grade List"
{
    Caption = 'Class Grade List';
    PageType = List;
    SourceTable = "Class Grade";
    ApplicationArea = All;
    UsageCategory = Lists;
    CardPageId = "Class Grade Card";

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
                field("Grade Code"; Rec."Grade Code")
                {
                    ApplicationArea = All;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                }
                field("Min Percentage"; Rec."Min Percentage")
                {
                    ApplicationArea = All;
                }
                field("Max Percentage"; Rec."Max Percentage")
                {
                    ApplicationArea = All;
                }
                field(Points; Rec.Points)
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    trigger OnOpenPage()
    begin
        Rec.SetCurrentKey(Class, Points);
    end;
}