page 72017 "Advertisement List"
{
    PageType = List;
    SourceTable = Advertisement;
    ApplicationArea = All;
    UsageCategory = Lists;
    CardPageId = "Advertisement Card";
    Caption = 'Advertisements';

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                }
                field("Company Name"; Rec."Company Name")
                {
                    ApplicationArea = All;
                }
                field("Required Vacancy"; Rec."Required Vacancy")
                {
                    ApplicationArea = All;
                }
                field("No. Of Vacancy"; Rec."No. Of Vacancy")
                {
                    ApplicationArea = All;
                }
                field("Required Date"; Rec."Required Date")
                {
                    ApplicationArea = All;
                }
            }
        }
    }
}
