table 71011 "Application Optional Subjects"
{
    //   No   Date      Sign     Trigger                       Description
    // -----------------------------------------------------------------------------------------------
    //   01   29/09/09  KATHIR   Subject - OnValidate()        Code added to get the Subject description
    //   02   19/10/09  VANDHANA OnInsert                     Code to assign User ID.

    Caption = 'Application Optional Subjects';
    LookupPageID = 71018;

    fields
    {
        field(1; "Application No"; Code[20])
        {
            Caption = 'Application No';
        }
        field(2; "Subject Group"; Code[20])
        {
            Caption = 'Subject Group';
            TableRelation = "Subject Group";
        }
        field(3; Subject; Code[20])
        {
            Caption = 'Subject';
            TableRelation = Subject WHERE ("Subject Group" = FIELD ("Subject Group"));

            trigger OnValidate()
            begin
                // Start 01.KATHIR
                if Subjectrec.Get(Subject) then
                    Description := Subjectrec.Description;
                // Stop 01.KATHIR
            end;
        }
        field(4; Description; Text[50])
        {
            Caption = 'Description';
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
        key(Key1; "Application No", "Subject Group", Subject)
        {
            Clustered = true;
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
}

