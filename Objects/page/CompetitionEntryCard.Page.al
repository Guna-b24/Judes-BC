page 71093 "Competition Entry Card"
{
    PageType = Document;
    SourceTable = "Competition Entry Header";
    Caption = 'Competition Entry';
    ApplicationArea = All;
    UsageCategory = None;

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

                field("Competition Name"; Rec."Competition Name")
                {
                    ApplicationArea = All;
                }

                field("Competition Type"; Rec."Competition Type")
                {
                    ApplicationArea = All;
                }

                field("Event Code"; Rec."Event Code")
                {
                    ApplicationArea = All;
                }

                field("Event Type"; Rec."Event Type")
                {
                    ApplicationArea = All;
                }

                field(Gender; Rec.Gender)
                {
                    ApplicationArea = All;
                }
            }

            group(Dates)
            {
                field("Competition Date"; Rec."Competition Date")
                {
                    ApplicationArea = All;
                }

                field("Participant Entry From"; Rec."Participant Entry From")
                {
                    ApplicationArea = All;
                }

                field("Participant Entry Till"; Rec."Participant Entry Till")
                {
                    ApplicationArea = All;
                }
            }

            group(Status)
            {
                field("Competition Status"; Rec."Competition Status")
                {
                    ApplicationArea = All;
                }
            }

            group(Administration)
            {
                field("Academic Year"; Rec."Academic Year")
                {
                    ApplicationArea = All;
                    Editable = false;
                }

                field("No.Series"; Rec."No.Series")
                {
                    ApplicationArea = All;
                    Editable = false;
                }

                field("Portal ID"; Rec."Portal ID")
                {
                    ApplicationArea = All;
                }

                field(ChampionShip; Rec.ChampionShip)
                {
                    ApplicationArea = All;
                }

                field(ParticipantEntryUsers; Rec.ParticipantEntryUsers)
                {
                    ApplicationArea = All;
                }
            }
            part(Lines; "Competition Entry Subform")
            {
                SubPageLink = "Document No." = field("No.");
            }
        }
    }
}