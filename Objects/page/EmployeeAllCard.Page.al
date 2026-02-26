page 71937 "Employee All Card"
{
    Caption = 'Employee Card';
    PageType = Card;
    SourceTable = "Employee Alll";
    ApplicationArea = All;
    UsageCategory = Administration;

    layout
    {
        area(Content)
        {
            group(General)
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

                field(Gender; Rec.Gender)
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
            }

            group("Class Assignment")
            {
                field("Class From"; Rec."Class From")
                {
                    ApplicationArea = All;
                }

                field("Class To"; Rec."Class To")
                {
                    ApplicationArea = All;
                }
            }

            group("Dates")
            {
                field("Employment Date"; Rec."Employment Date")
                {
                    ApplicationArea = All;
                }

                field("Date of Birth"; Rec."Date of Birth")
                {
                    ApplicationArea = All;
                }
            }

            group("Integration")
            {
                field("Employee Image File"; Rec."Employee Image File")
                {
                    ApplicationArea = All;
                }
            }
            // group("Leave Assignment")
            // {
            //     part("Employee Leaves"; "Employee Leave Attachment")
            //     {
            //         ApplicationArea = All;
            //         SubPageLink = "Employee No" = FIELD("Employee No.");
            //     }
            // }
        }
    }
}