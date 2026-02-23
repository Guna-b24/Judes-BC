page 71936 "Employee All List"
{
    Caption = 'Employees';
    PageType = List;
    SourceTable = "Employee Alll";
    ApplicationArea = All;
    UsageCategory = Lists;
    CardPageId = "Employee All Card";

    layout
    {
        area(Content)
        {
            repeater(Group)
            {
                field("Employee No."; Rec."Employee No.")
                {
                    ApplicationArea = All;
                }

                field(Name; Rec.Name)
                {
                    ApplicationArea = All;
                }

                field("Company Name"; Rec."Company Name")
                {
                    ApplicationArea = All;
                }

                field("Employee Category"; Rec."Employee Category")
                {
                    ApplicationArea = All;
                }

                field("Employee Type"; Rec."Employee Type")
                {
                    ApplicationArea = All;
                }

                field(Gender; Rec.Gender)
                {
                    ApplicationArea = All;
                }
            }
        }
    }
}