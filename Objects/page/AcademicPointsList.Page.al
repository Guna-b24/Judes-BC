page 70000 "Academic Points List"
{
    PageType = List;
    SourceTable = "Academic Points";
    ApplicationArea = All;
    UsageCategory = Lists;
    Caption = 'Academic Points';

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("Student No."; Rec."Student No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the student for whom the academic points are recorded.';
                }
                field("Academic Year"; Rec."Academic Year")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the academic year.';
                }
                field("Exam Code"; Rec."Exam Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the examination.';
                }
                field("Class Code"; Rec."Class Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the class of the student during the academic year.';
                }
                field(Points; Rec.Points)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the academic points obtained by the student.';
                }
            }
        }
    }
}
