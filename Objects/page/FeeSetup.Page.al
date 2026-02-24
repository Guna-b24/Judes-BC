page 70072 "Fee Setup"
{
    PageType = Card;
    SourceTable = "Fee Setup";
    ApplicationArea = All;
    UsageCategory = Administration;


    layout
    {
        area(content)
        {
            group("Fee Numbering")
            {
                field("Class Fee No."; rec."Class Fee No.")
                {
                    ApplicationArea = All;
                }
                field("Fee Number"; rec."Fee Number")
                {
                    ApplicationArea = All;
                }
            }

            group("Fee Journal Setup")
            {
                field("Journal Template Name"; rec."Journal Template Name")
                {
                    ApplicationArea = All;
                }
                field("Journal Batch Name"; rec."Journal Batch Name")
                {
                    ApplicationArea = All;
                }
            }

            group("Caution Deposit Setup")
            {
                field("Caution Deposit Template"; rec."Caution Deposit Template")
                {
                    ApplicationArea = All;
                }
                field("Caution Deposit Batch"; rec."Caution Deposit Batch")
                {
                    ApplicationArea = All;
                }
                field("Caution Deposit Number"; rec."Caution Deposit Number")
                {
                    ApplicationArea = All;
                }
            }

            group("Fee Receipt Setup")
            {
                field("Fee Receipt Template"; rec."Fee Receipt Template")
                {
                    ApplicationArea = All;
                }
                field("Fee Receipt Batch"; rec."Fee Receipt Batch")
                {
                    ApplicationArea = All;
                }
            }

            group("Integration")
            {
                field("Portal ID"; rec."Portal ID")
                {
                    ApplicationArea = All;
                }
            }
        }
    }


}
