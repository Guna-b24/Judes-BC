table 71051 "Student Optional Subjects"
{
    //   No   Date      Sign     Trigger                       Description
    // -----------------------------------------------------------------------------------------------
    //   01  29/09/09   KATHIR   Subject - OnValidate()       Code added to get the Subject description
    //   02  19/10/09  VANDHANA  OnInsert                     Code to assign User ID.

    Caption = 'Student Optional Subjects';
    LookupPageID = 71052;

    fields
    {
        field(1; "Student No"; Code[20])
        {
            Caption = 'Student No';
            TableRelation = Student;
        }
        field(2; "Subject Group"; Code[20])
        {
            Caption = 'Subject Group';
            TableRelation = "Subject Group";
        }
        field(3; Subject; Code[20])
        {
            Caption = 'Subject';
            TableRelation = "Class Section Subjects".Subject WHERE ("Subject Group" = FIELD ("Subject Group"),
                                                                    "Class Code" = FIELD ("Class Code"));

            trigger OnValidate()
            begin
                // Start 01.KATHIR
                Subjectrec.Reset;
                if Subjectrec.Get(Subject) then
                    Description := Subjectrec.Description
                else
                    Description := '';

                ClassSecSub.Reset;
                ClassSecSub.SetRange(ClassSecSub."Class Code", "Class Code");
                ClassSecSub.SetRange(ClassSecSub.Subject, Subject);
                if ClassSecSub.FindFirst then
                    "Class 9 10 Group Code" := ClassSecSub."Class IX and  X Group";
                // Stop 01.KATHIR
            end;
        }
        field(4; Description; Text[50])
        {
            Caption = 'Description';
        }
        field(5; "Class Code"; Code[20])
        {
            TableRelation = "Class Section";
        }
        field(6; Group; Integer)
        {
            BlankZero = true;
        }
        field(10; "Class 9 10 Group Code"; Option)
        {
            OptionCaption = ' ,Group 2,Group 3';
            OptionMembers = " ","Group 2","Group 3";
        }
        field(70120; "User ID"; Code[20])
        {
            Caption = 'User ID';
        }
        field(70121; "Portal ID"; Code[20])
        {
            Caption = 'Portal ID';
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

    trigger OnInsert()
    begin
        // Start 02. VANDHANA

        "User ID" := UserId;

        // Stop 02. VANDHANA
    end;

    var
        Subjectrec: Record Subject;
        ClassSecSub: Record "Class Section Subjects";
}

