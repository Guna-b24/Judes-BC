page 71255 "Time Table Ledger List"
{
    PageType = List;
    ApplicationArea = All;
    SourceTable = "Time Table Ledger";
    Caption = 'Time Table Ledger';
    UsageCategory = Administration;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Entry No."; Rec."Entry No.")
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
                field("Day No"; Rec."Day No")
                {
                }
                field("Hour No"; Rec."Hour No")
                {
                }
                field(Subject; Rec.Subject)
                {
                }
                field("Subject Description"; Rec."Subject Description")
                {
                }
                field("Employee Code"; Rec."Employee Code")
                {
                }
                field("Faculty Name"; Rec."Faculty Name")
                {
                }
                field("Time Table Date"; Rec."Time Table Date")
                {
                }
                field("Start Time"; Rec."Start Time")
                {
                }
                field("End Time"; Rec."End Time")
                {
                }
                field("Period Type"; Rec."Period Type")
                {
                }
                field("Class Code"; Rec."Class Code")
                {
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            // action(Refresh)
            // {
            //     Caption = 'Refresh';
            //     Image = Refresh;
            //     ApplicationArea = All;
            //     trigger OnAction()
            //     begin
            //         CurrPage.Update();
            //     end;
            // }
        }
    }
}