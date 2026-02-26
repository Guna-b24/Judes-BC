page 71161 "Withdrawal List"
{
    PageType = List;
    ApplicationArea = All;
    SourceTable = "Withdrawal";
    Caption = 'Withdrawal List';
    UsageCategory = Administration;
    CardPageId = "Withdrawal Card";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("No."; Rec."No.")
                {
                }
                field("Student No."; Rec."Student No.")
                {
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
                field("Academic Year"; Rec."Academic Year")
                {
                }
                field("Withdrawal date"; Rec."Withdrawal date")
                {
                }
                field("No. Series"; Rec."No. Series")
                {
                }
                field("TC Issued"; Rec."TC Issued")
                {
                }
                field("Class Code"; Rec."Class Code")
                {
                }
                field("Reason for Leaving"; Rec."Reason for Leaving")
                {
                }
                field("Portal ID"; Rec."Portal ID")
                {
                }
            }
        }
    }


}