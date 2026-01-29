table 71014 "Selection Process Line"
{
    //    No     Date    Sign       Trigger                 Description
    // -----------------------------------------------------------------------------------------------
    //   01     07/10/09 VANDHANA   OnValidate()          Code to update name & Gender

    Caption = 'Selection Process Line';

    fields
    {
        field(1; "Selection No."; Code[10])
        {
            Caption = 'Selection No.';
        }
        field(2; "Application No"; Code[20])
        {
            Caption = 'Application No';
            TableRelation = Application;

            trigger OnValidate()
            begin
                // Start 01. VANDHANA
                if Application.Get("Application No") then begin
                    Name := Application."Name of the pupil";
                    Gender := Application."Applicant Gender";
                end;
                // Stop 01. VANDHANA
            end;
        }
        field(3; Name; Text[30])
        {
            Caption = 'Name';
        }
        field(4; Gender; Option)
        {
            Caption = 'Gender';
            OptionCaption = ' ,Male,Female';
            OptionMembers = " ",Male,Female;
        }
        field(5; "Evaluation Total"; Decimal)
        {
            Caption = 'Evaluation Total';
        }
        field(6; Rank; Integer)
        {
            Caption = 'Rank';
        }
        field(7; Select; Boolean)
        {
            Caption = 'Select';
        }
    }

    keys
    {
        key(Key1; "Selection No.", "Application No")
        {
            Clustered = true;
        }
        key(Key2; Rank)
        {
        }
    }

    fieldgroups
    {
    }

    var
        Application: Record Application;
}

