page 71263 "Transfer Certificate List"
{
    PageType = List;
    SourceTable = "Transfer Certificate";
    Caption = 'Transfer Certificate List';
    ApplicationArea = All;
    UsageCategory = Administration;
    CardPageID = "Transfer Certificate Card";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("TC No."; Rec."TC No.")
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
                field("TC Issued"; Rec."TC Issued")
                {
                }
                field("Date of Issue"; Rec."Date of Issue")
                {
                }
            }
        }
    }
}