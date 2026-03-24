page 70003 "Academic Year Card"
{
    PageType = Card;
    SourceTable = "Academic Year";
    ApplicationArea = All;
    Caption = 'Academic Year';
    UsageCategory = Administration;
    DataCaptionFields = Code, Description;



    layout
    {
        area(Content)
        {
            group(General)
            {
                field(Code; Rec.Code)
                {
                    ApplicationArea = All;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the description of the academic year.';
                }
                field(Sequence; Rec.Sequence)
                {
                    ApplicationArea = All;
                    Editable = false; // AutoIncrement field
                }
                field("Start Date"; Rec."Start Date")
                {
                    ApplicationArea = All;
                }
                field("End Date"; Rec."End Date")
                {
                    ApplicationArea = All;
                }
                field(Closed; Rec.Closed)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies whether the academic year is closed.';
                }
            }

            group(Integration)
            {
                field("Portal ID"; Rec."Portal ID")
                {
                    ApplicationArea = All;
                }
            }
        }
    }
}
