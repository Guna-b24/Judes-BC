page 72010 "Faculty Subject Lookup"
{
    PageType = List;
    SourceTable = "Faculty Subject";

    ApplicationArea = All;
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Subject Code"; Rec."Subject Code")
                {
                    ApplicationArea = All;
                }
                field("Subject Type"; Rec."Subject Type")
                {
                    ApplicationArea = All;
                }
            }
        }
    }
}
