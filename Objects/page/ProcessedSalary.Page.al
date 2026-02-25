page 70232 "Processed Salary"
{
    PageType = List;
    SourceTable = "Processed Salary";
    ApplicationArea = All;
    UsageCategory = Lists;
    Caption = 'Processed Salary';
    Editable = false;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Location Code"; Rec."Location Code") { ApplicationArea = All; }
                field("Salary Plan Code"; Rec."Salary Plan Code") { ApplicationArea = All; }
                field("Salary Cycle Code"; Rec."Salary Cycle Code") { ApplicationArea = All; }
                field("Employee No"; Rec."Employee No") { ApplicationArea = All; }
                field("Pay Element Code"; Rec."Pay Element Code") { ApplicationArea = All; }
                field("Pay Type"; Rec."Pay Type") { ApplicationArea = All; }
                field("Actual Amount"; Rec."Actual Amount") { ApplicationArea = All; }
                field("Payable Amount"; Rec."Payable Amount") { ApplicationArea = All; }
                field("Salary Processed"; Rec."Salary Processed") { ApplicationArea = All; }
                field("Salary Posted"; Rec."Salary Posted") { ApplicationArea = All; }
            }
        }
    }
}