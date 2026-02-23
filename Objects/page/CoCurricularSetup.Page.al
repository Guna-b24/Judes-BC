page 71081 "Co-Curricular Setup"
{
    PageType = Card;
    SourceTable = "Co-Curricular Setup";
    Caption = 'Co-Curricular Setup';
    ApplicationArea = All;
    UsageCategory = Administration;

    layout
    {
        area(Content)
        {
            group(NumberSeries)
            {
                Caption = 'Number Series';

                field("Competition Entry No."; Rec."Competition Entry No.")
                {
                    ApplicationArea = All;
                }

                field("Participant Entry No."; Rec."Participant Entry No.")
                {
                    ApplicationArea = All;
                }

                field("Result Individual Entry No."; Rec."Result Individual Entry No.")
                {
                    ApplicationArea = All;
                }

                field("Result Team Entry No."; Rec."Result Team Entry No.")
                {
                    ApplicationArea = All;
                }
            }

            group(Internal)
            {
                Caption = 'Internal';

                field("Last Used Team No"; Rec."Last Used Team No")
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

    trigger OnOpenPage()
    begin
        if not Rec.Get('SETUP') then begin
            Rec.Init();
            Rec."Primary Key" := 'SETUP';
            Rec.Insert();
        end;
    end;
}