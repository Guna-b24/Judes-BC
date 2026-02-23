page 70049 "Certification List"
{
    PageType = List;
    SourceTable = Certification;
    ApplicationArea = All;
    UsageCategory = Lists;
    Caption = 'Certifications';

    layout
    {
        area(Content)
        {
            repeater(Group)
            {
                field("Code"; Rec."Code")
                {
                    ApplicationArea = All;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                }
            }
        }
    }
}
