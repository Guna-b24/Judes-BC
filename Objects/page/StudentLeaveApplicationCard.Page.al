page 71133 "Student Leave Application Card"
{
    PageType = Card;
    SourceTable = "Student Leave Application";
    ApplicationArea = All;
    Caption = 'Student Leave Application';
    UsageCategory = Documents;

    layout
    {
        area(Content)
        {
            group(General)
            {
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;

                    trigger OnAssistEdit()
                    begin
                        if Rec.AssistEdit(xRec) then
                            CurrPage.Update();
                    end;
                }

                field("Academic Year"; Rec."Academic Year")
                {
                    ApplicationArea = All;
                }

                field("Student No."; Rec."Student No.")
                {
                    ApplicationArea = All;
                }

                field("Student Name"; Rec."Student Name")
                {
                    ApplicationArea = All;
                    Editable = false;
                }

                field(Class; Rec.Class)
                {
                    ApplicationArea = All;
                }

                field(Curriculum; Rec.Curriculum)
                {
                    ApplicationArea = All;
                }

                field(Section; Rec.Section)
                {
                    ApplicationArea = All;
                }
            }

            group("Leave Details")
            {
                field("From Date"; Rec."From Date")
                {
                    ApplicationArea = All;
                }

                field("To Date"; Rec."To Date")
                {
                    ApplicationArea = All;
                }

                field("No. Of Days"; Rec."No. Of Days")
                {
                    ApplicationArea = All;
                }

                field("Leave Status"; Rec."Leave Status")
                {
                    ApplicationArea = All;
                }

                field("Applicant Type"; Rec."Applicant Type")
                {
                    ApplicationArea = All;
                }

                field("Leave Taken"; Rec."Leave Taken")
                {
                    ApplicationArea = All;
                }
            }

            group(Communication)
            {
                field("Applicant E-Mail ID"; Rec."Applicant E-Mail ID")
                {
                    ApplicationArea = All;
                }

                field(Reason; Rec.Reason)
                {
                    ApplicationArea = All;
                    MultiLine = true;
                }

                field("Class Code"; Rec."Class Code")
                {
                    ApplicationArea = All;
                }

                field("Portal ID"; Rec."Portal ID")
                {
                    ApplicationArea = All;
                }
            }
        }
    }
}