page 71060 "Student Subjects List"
{
    PageType = List;
    ApplicationArea = All;
    Caption = 'Student Subjects';
    SourceTable = "Student Subjects";
    CardPageID = "Student Subjects Card";
    UsageCategory = Administration;

    layout
    {
        area(Content)
        {
            repeater(Group)
            {
                field("Student No."; Rec."Student No.")
                {
                }
                field("Student Name"; Rec."Student Name")
                {
                }
                field("Academic Year"; Rec."Academic Year")
                {
                }
                field(Class; Rec.Class)
                {
                }
                field(Section; Rec.Section)
                {
                }
                field(Subject; Rec.Subject)
                {
                }
                field("Subject Type"; Rec."Subject Type")
                {
                }
                field("Subject Group"; Rec."Subject Group")
                {
                }
                field(Mark; Rec.Mark)
                {
                }
                field(Grade; Rec.Grade)
                {
                }
            }
        }
    }
}