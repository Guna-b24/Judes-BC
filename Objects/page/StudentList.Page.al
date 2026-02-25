page 71026 "Student List"
{
    PageType = List;
    SourceTable = Student;
    ApplicationArea = All;
    Caption = 'Student List';
    UsageCategory = Lists;
    CardPageId = "Student Card";

    layout
    {
        area(Content)
        {
            repeater(Group)
            {
                field("No."; Rec."No.") { ApplicationArea = All; }
                field(Name; Rec.Name) { ApplicationArea = All; }
                field("Academic Year"; Rec."Academic Year") { ApplicationArea = All; }
                field(Class; Rec.Class) { ApplicationArea = All; }
                field(Section; Rec.Section) { ApplicationArea = All; }
                field("Student Status"; Rec."Student Status") { ApplicationArea = All; }
                field(Gender; Rec.Gender) { ApplicationArea = All; }
                field("Mobile Number"; Rec."Mobile Number") { ApplicationArea = All; }
                field("E-Mail Address"; Rec."E-Mail Address") { ApplicationArea = All; }
                field(CGPA; Rec.CGPA) { ApplicationArea = All; }
                field(Points; Rec.Points) { ApplicationArea = All; }
            }
        }
    }
}