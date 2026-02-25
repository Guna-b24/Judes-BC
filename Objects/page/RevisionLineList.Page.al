page 72133 "Revision Line List"
{
    PageType = List;
    SourceTable = "Revision Line";
    ApplicationArea = All;
    UsageCategory = Lists;
    Caption = 'Revision Lines';

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Pay Revision Id"; Rec."Pay Revision Id")
                {
                    ApplicationArea = All;
                }
                field("Employee No"; Rec."Employee No")
                {
                    ApplicationArea = All;
                }
                field(Name; Rec.Name)
                {
                    ApplicationArea = All;
                }
                field("Pay Element Code"; Rec."Pay Element Code")
                {
                    ApplicationArea = All;
                }
                field("Last Drawn Amount"; Rec."Last Drawn Amount")
                {
                    ApplicationArea = All;
                }
                field("Revised Amount"; Rec."Revised Amount")
                {
                    ApplicationArea = All;
                }
                field("Difference Amount"; Rec."Difference Amount")
                {
                    ApplicationArea = All;
                }
                field(Posted; Rec.Posted)
                {
                    ApplicationArea = All;
                }
            }
        }
    }
}