page 70057 "Class Card List"
{
    Caption = 'Class Card List';
    PageType = List;
    SourceTable = "Class Card";
    ApplicationArea = All;
    UsageCategory = Lists;
    CardPageId = "Class Card Card";

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
                field("Application Cost"; Rec."Application Cost")
                {
                    ApplicationArea = All;
                }
                field("Registration Cost"; Rec."Registration Cost")
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
                field(Closed; Rec.Closed)
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    trigger OnOpenPage()
    begin
        Rec.SetCurrentKey(Sequence);
    end;
}