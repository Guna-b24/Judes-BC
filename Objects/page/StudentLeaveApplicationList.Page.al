page 71134 "Student Leave Application List"
{
    PageType = List;
    SourceTable = "Student Leave Application";
    ApplicationArea = All;
    Caption = 'Student Leave Applications';
    UsageCategory = Lists;
    CardPageId = "Student Leave Application Card";

    layout
    {
        area(Content)
        {
            repeater(Group)
            {
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                }

                field("Academic Year"; Rec."Academic Year")
                {
                    ApplicationArea = All;
                }

                field("Student No."; Rec."Student No.")
                {
                    ApplicationArea = All;
                }

                field("Student Name"; Rec."Student Name")
                {
                    ApplicationArea = All;
                }

                field(Class; Rec.Class)
                {
                    ApplicationArea = All;
                }

                field("From Date"; Rec."From Date")
                {
                    ApplicationArea = All;
                }

                field("To Date"; Rec."To Date")
                {
                    ApplicationArea = All;
                }

                field("No. Of Days"; Rec."No. Of Days")
                {
                    ApplicationArea = All;
                }

                field("Leave Status"; Rec."Leave Status")
                {
                    ApplicationArea = All;
                }
            }
        }
    }
}