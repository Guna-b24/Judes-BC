page 71072 "Faculty Class Plan Card"
{
    PageType = Card;
    SourceTable = "Faculty Class Plan Header";
    ApplicationArea = All;
    Editable = true;
    UsageCategory = Administration;

    layout
    {
        area(content)
        {
            group(General)
            {
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Faculty Class Plan Number.';
                }
                field("No.Series"; Rec."No.Series")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Class Code"; Rec."Class Code")
                {
                    ApplicationArea = All;
                }
                field(Class; Rec.Class)
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field(Curriculum; Rec.Curriculum)
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Subject Code"; Rec."Subject Code")
                {
                    ApplicationArea = All;
                }
                field("Academic Year"; Rec."Academic Year")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Faculty Code"; Rec."Faculty Code")
                {
                    ApplicationArea = All;
                }
                field(Department; Rec.Department)
                {
                    ApplicationArea = All;
                }
                field("Plan Status"; Rec."Plan Status")
                {
                    ApplicationArea = All;
                }
                field("Total Week Hours"; Rec."Total Week Hours")
                {
                    ApplicationArea = All;
                }
                field("Perc Completed"; Rec."Perc Completed")
                {
                    ApplicationArea = All;
                }
                field(Comments; Rec.Comments)
                {
                    ApplicationArea = All;
                }
                field(Section; Rec.Section)
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Portal ID"; Rec."Portal ID")
                {
                    ApplicationArea = All;
                }
            }
            part(Lines; "Faculty Class Plan Subform")
            {
                ApplicationArea = All;
                SubPageLink = "Document No." = field("No.");
            }
        }
    }
}