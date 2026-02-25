table 71051 "Student Optional Subjects"
{
    Caption = 'Student Optional Subjects';
    DataClassification = CustomerContent;
    LookupPageID = "Student Optional Subjects";

    fields
    {
        field(1; "Student No"; Code[20])
        {
            Caption = 'Student No';
            DataClassification = CustomerContent;
            ToolTip = 'Specifies the unique number of the student.';
            TableRelation = Student;
        }
        field(2; "Subject Group"; Code[20])
        {
            Caption = 'Subject Group';
            DataClassification = CustomerContent;
            ToolTip = 'Specifies the subject group selected by the student.';
            TableRelation = "Subject Group";
        }
        field(3; Subject; Code[20])
        {
            Caption = 'Subject';
            DataClassification = CustomerContent;
            ToolTip = 'Specifies the optional subject chosen by the student.';
            TableRelation = "Class Section Subjects".Subject WHERE("Subject Group" = FIELD("Subject Group"),
                                                                    "Class Code" = FIELD("Class Code"));

            trigger OnValidate()
            begin
                Subjectrec.Reset();
                if Subjectrec.Get(Subject) then
                    Description := Subjectrec.Description
                else
                    Description := '';

                ClassSecSub.Reset();
                ClassSecSub.SetRange(ClassSecSub."Class Code", "Class Code");
                ClassSecSub.SetRange(ClassSecSub.Subject, Subject);
                if ClassSecSub.FindFirst() then
                    "Class 9 10 Group Code" := ClassSecSub."Class IX and  X Group";
            end;
        }
        field(4; Description; Text[50])
        {
            Caption = 'Description';
            DataClassification = CustomerContent;
            ToolTip = 'Specifies the description of the selected subject.';
        }
        field(5; "Class Code"; Code[20])
        {
            DataClassification = CustomerContent;
            ToolTip = 'Specifies the class code of the student.';
            TableRelation = "Class Section";
        }
        field(6; Group; Integer)
        {
            DataClassification = CustomerContent;
            ToolTip = 'Specifies the group number for the optional subject.';
            BlankZero = true;
        }
        field(10; "Class 9 10 Group Code"; Option)
        {
            DataClassification = CustomerContent;
            ToolTip = 'Specifies the Class IX and X group code.';
            OptionCaption = ' ,Group 2,Group 3';
            OptionMembers = " ","Group 2","Group 3";
        }
        field(70121; "Portal ID"; Code[20])
        {
            Caption = 'Portal ID';
            DataClassification = CustomerContent;
            ToolTip = 'Specifies the portal identifier associated with the record.';
        }
    }

    keys
    {
        key(Key1; "Student No", "Subject Group", "Class Code", Subject)
        {
            Clustered = true;
        }
        key(Key2; Group)
        {
        }
    }
    fieldgroups
    {
    }

    var
        Subjectrec: Record Subject;
        ClassSecSub: Record "Class Section Subjects";
}

