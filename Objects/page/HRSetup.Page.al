page 70127 "HR Setup"
{
    PageType = Card;
    SourceTable = "HR Setup";
    ApplicationArea = All;
    Caption = 'HR Setup';
    UsageCategory = Administration;

    layout
    {
        area(Content)
        {
            group("General Setup")
            {
                field("Primary Key"; Rec."Primary Key")
                {
                    ApplicationArea = All;
                    Editable = false;
                }

                field("File Directory"; Rec."File Directory")
                {
                    ApplicationArea = All;
                }

                field(MsWordPath; Rec.MsWordPath)
                {
                    ApplicationArea = All;
                }
            }

            group("No. Series Setup")
            {
                field("Indenting SNo"; Rec."Indenting SNo")
                {
                    ApplicationArea = All;
                }

                field("ResumeDB SNo"; Rec."ResumeDB SNo")
                {
                    ApplicationArea = All;
                }

                field("Appraisal SNo"; Rec."Appraisal SNo")
                {
                    ApplicationArea = All;
                }

                field("Training SNo"; Rec."Training SNo")
                {
                    ApplicationArea = All;
                }

                field("Interview SNo"; Rec."Interview SNo")
                {
                    ApplicationArea = All;
                }

                field("Selection SNo"; Rec."Selection SNo")
                {
                    ApplicationArea = All;
                }
            }

            group("Appraisal & Email Setup")
            {
                field(Appraisal; Rec.Appraisal)
                {
                    ApplicationArea = All;
                }

                field("Send to HR Mail"; Rec."Send to HR Mail")
                {
                    ApplicationArea = All;
                }

                field("Send to HR Mail CC"; Rec."Send to HR Mail CC")
                {
                    ApplicationArea = All;
                }
            }
        }
    }


}