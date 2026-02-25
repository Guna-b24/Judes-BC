page 71135 "Student Mark Card"
{
    PageType = Card;
    SourceTable = "Student Mark Header";
    ApplicationArea = All;
    Caption = 'Student Mark Card';
    UsageCategory = Documents;

    layout
    {
        area(Content)
        {
            group("Student Information")
            {
                field("Student No."; Rec."Student No.")
                {
                    ApplicationArea = All;
                }

                field(Name; Rec.Name)
                {
                    ApplicationArea = All;
                }

                field("Class Code"; Rec."Class Code")
                {
                    ApplicationArea = All;
                }

                field(Class; Rec.Class)
                {
                    ApplicationArea = All;
                }

                field(Section; Rec.Section)
                {
                    ApplicationArea = All;
                }

                field(Curriculum; Rec.Curriculum)
                {
                    ApplicationArea = All;
                }

                field("Academic Year"; Rec."Academic Year")
                {
                    ApplicationArea = All;
                }

                field("Exam Type"; Rec."Exam Type")
                {
                    ApplicationArea = All;
                }
            }

            group("Performance Summary")
            {
                field("Total Marks"; Rec."Total Marks")
                {
                    ApplicationArea = All;
                }

                field("Total Marks Conducted"; Rec."Total Marks Conducted")
                {
                    ApplicationArea = All;
                }

                field("Percentage Scored"; Rec."Percentage Scored")
                {
                    ApplicationArea = All;
                }

                field(Average; Rec.Average)
                {
                    ApplicationArea = All;
                }

                field(Rank; Rec.Rank)
                {
                    ApplicationArea = All;
                }

                field("GPA Points"; Rec."GPA Points")
                {
                    ApplicationArea = All;
                }

                field("GPA Grade"; Rec."GPA Grade")
                {
                    ApplicationArea = All;
                }

                field(Grade; Rec.Grade)
                {
                    ApplicationArea = All;
                }
            }

            group("Attendance & Status")
            {
                field("Average Attendance Percent"; Rec."Average Attendance Percent")
                {
                    ApplicationArea = All;
                }

                field("Maximum Working Days"; Rec."Maximum Working Days")
                {
                    ApplicationArea = All;
                }

                field("Total No of Subject Failed"; Rec."Total No of Subject Failed")
                {
                    ApplicationArea = All;
                }

                field("Total No of Subject Absent"; Rec."Total No of Subject Absent")
                {
                    ApplicationArea = All;
                }

                field(Failed; Rec.Failed)
                {
                    ApplicationArea = All;
                }

                field(Published; Rec.Published)
                {
                    ApplicationArea = All;
                }
            }

            group("Behavior Assessment")
            {
                field(Regularity; Rec.Regularity)
                {
                    ApplicationArea = All;
                }

                field(Effort; Rec.Effort)
                {
                    ApplicationArea = All;
                }

                field(Discipline; Rec.Discipline)
                {
                    ApplicationArea = All;
                }

                field("Etiquette Manners"; Rec."Etiquette Manners")
                {
                    ApplicationArea = All;
                }

                field(Leadership; Rec.Leadership)
                {
                    ApplicationArea = All;
                }

                field(Hospitability; Rec.Hospitability)
                {
                    ApplicationArea = All;
                }

                field("Social Movement"; Rec."Social Movement")
                {
                    ApplicationArea = All;
                }

                field("Extra Curr Excellence"; Rec."Extra Curr Excellence")
                {
                    ApplicationArea = All;
                }

                field("Personal Traits"; Rec."Personal Traits")
                {
                    ApplicationArea = All;
                }
            }

            group("Remark")
            {
                field(Remarks; Rec.Remarks)
                {
                    ApplicationArea = All;
                    MultiLine = true;
                }

                field("Principal Comment"; Rec."Principal Comment")
                {
                    ApplicationArea = All;
                    MultiLine = true;
                }

                field("Principal Comment2"; Rec."Principal Comment2")
                {
                    ApplicationArea = All;
                    MultiLine = true;
                }

                field("Class Teacher Comment"; Rec."Class Teacher Comment")
                {
                    ApplicationArea = All;
                    MultiLine = true;
                }

                field("Class Teacher Comment2"; Rec."Class Teacher Comment2")
                {
                    ApplicationArea = All;
                    MultiLine = true;
                }

                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                    MultiLine = true;
                }

                field("Portal ID"; Rec."Portal ID")
                {
                    ApplicationArea = All;
                }
            }
        }
    }
}