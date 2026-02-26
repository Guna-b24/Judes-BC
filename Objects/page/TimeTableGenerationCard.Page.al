page 71155 "Time Table Generation Card"
{
    PageType = Card;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = "Time Table Generation";
    Caption = 'Time Table Generation';

    layout
    {
        area(Content)
        {
            group(General)
            {
                field("Entry No."; Rec."Entry No.")
                {
                    Editable = false;
                }
                field(Class; Rec.Class)
                {
                }
                field(Section; Rec.Section)
                {
                }
                field(Curriculum; Rec.Curriculum)
                {
                }
                field("Day No"; Rec."Day No")
                {
                }
                field("Hour No"; Rec."Hour No")
                {
                }
                field(Subject; Rec.Subject)
                {
                }
                field("Employee Code"; Rec."Employee Code")
                {
                }
                field("Generate Date"; Rec."Generate Date")
                {
                }
                field("Academic Year"; Rec."Academic Year")
                {
                    Editable = false;
                }
                field(Joint; Rec.Joint)
                {
                }
                field("Period Length"; Rec."Period Length")
                {
                    Editable = false;
                }
                field(Archived; Rec.Archived)
                {
                }
                field("Portal ID"; Rec."Portal ID")
                {
                }
            }
        }
    }
}