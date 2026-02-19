page 71000 "Admission Setup"
{
    PageType = Card;
    SourceTable = "Admission Setup";
    ApplicationArea = All;
    UsageCategory = Administration;
    Caption = 'Admission Setup';

    layout
    {
        area(Content)
        {
            group("General")
            {
                field("Academic Year"; Rec."Academic Year")
                {
                    ApplicationArea = All;
                }
                field("Admission Year"; Rec."Admission Year")
                {
                    ApplicationArea = All;
                }
                field("Student No."; Rec."Student No.")
                {
                    ApplicationArea = All;
                }
            }

            group("Number Series")
            {
                field("Enquiry No."; Rec."Enquiry No.")
                {
                    ApplicationArea = All;
                }
                field("Application No."; Rec."Application No.")
                {
                    ApplicationArea = All;
                }
                field("Application Sales Posting No."; Rec."Application Sales Posting No.")
                {
                    ApplicationArea = All;
                }
                field("Registration Posting No."; Rec."Registration Posting No.")
                {
                    ApplicationArea = All;
                }
                field("Evaluation No."; Rec."Evaluation No.")
                {
                    ApplicationArea = All;
                }
                field("Selection No."; Rec."Selection No.")
                {
                    ApplicationArea = All;
                }
            }

            group("Cost Setup")
            {
                field("Appl Cost Method"; Rec."Appl Cost Method")
                {
                    ApplicationArea = All;
                }
                field("Application Cost Needed"; Rec."Application Cost Needed")
                {
                    ApplicationArea = All;
                }
                field("Application Cost"; Rec."Application Cost")
                {
                    ApplicationArea = All;
                }
                field("Registration Cost Needed"; Rec."Registration Cost Needed")
                {
                    ApplicationArea = All;
                }
                field("Registration Cost"; Rec."Registration Cost")
                {
                    ApplicationArea = All;
                }
            }

            group("Posting Setup")
            {
                field("Journal Template Name"; Rec."Journal Template Name")
                {
                    ApplicationArea = All;
                }
                field("Application Sales Batch Name"; Rec."Application Sales Batch Name")
                {
                    ApplicationArea = All;
                }
                field("Registration Batch Name"; Rec."Registration Batch Name")
                {
                    ApplicationArea = All;
                }
                field("Application Cost Account No."; Rec."Application Cost Account No.")
                {
                    ApplicationArea = All;
                }
                field("Registration Cost Account No."; Rec."Registration Cost Account No.")
                {
                    ApplicationArea = All;
                }
                field("Gen. Bus. Posting Group"; Rec."Gen. Bus. Posting Group")
                {
                    ApplicationArea = All;
                }
                field("Customer Posting Group"; Rec."Customer Posting Group")
                {
                    ApplicationArea = All;
                }
            }

            group("Sales Period")
            {
                field("Application Sale Method"; Rec."Application Sale Method")
                {
                    ApplicationArea = All;
                }
                field("Application Sales From"; Rec."Application Sales From")
                {
                    ApplicationArea = All;
                }
                field("Application Sales To"; Rec."Application Sales To")
                {
                    ApplicationArea = All;
                }
            }

            group("Integration")
            {
                field("Portal ID"; Rec."Portal ID")
                {
                    ApplicationArea = All;
                }
            }
        }
    }
}
