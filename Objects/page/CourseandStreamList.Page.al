page 73000 "Course and Stream List"
{
    PageType = List;
    SourceTable = "Course and Stream";
    ApplicationArea = All;
    UsageCategory = Lists;
    Caption = 'Course and Stream';

    layout
    {
        area(Content)
        {
            repeater(Group)
            {
                field(primarykey; Rec.primarykey)
                {
                    ApplicationArea = All;
                    Editable = false;
                }

                field(Course; Rec.Course)
                {
                    ApplicationArea = All;
                }

                field("Course Stream"; Rec."Course Stream")
                {
                    ApplicationArea = All;
                }
            }
        }
    }
}