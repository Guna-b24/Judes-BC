table 72017 "Interview Process Line"
{
    // -----------------------------------------------------------------------------------------------
    // Firstware Sofware Solutions : Project Name : HR & PAYROLL
    // -----------------------------------------------------------------------------------------------
    // No.  Date          Developer     Spec/CU/CR      Description
    // -----------------------------------------------------------------------------------------------
    // 1    04.APR.2009   SENTHIL                       New Tables Added for HR Module.

    Caption = 'Interview Process Line';

    fields
    {
        field(1; No; Code[20])
        {
            Caption = 'No';
        }
        field(2; "Interview Round Code"; Code[10])
        {
            Caption = 'Interview Round Code';
            TableRelation = "Interview Round";

            trigger OnValidate()
            begin
                if InterviewRound.Get("Interview Round Code") then
                    Description := InterviewRound.Description;
            end;
        }
        field(3; Description; Text[100])
        {
            Caption = 'Description';
            Editable = false;
        }
        field(4; "Test Taken"; Boolean)
        {
            Caption = 'Test Taken';
        }
        field(5; "Test Result"; Option)
        {
            Caption = 'Test Result';
            OptionCaption = ' ,Pass,Fail';
            OptionMembers = " ",Pass,Fail;
        }
        field(6; Remarks; Text[100])
        {
            Caption = 'Remarks';
        }
        field(7; "Interview Date"; Date)
        {
            Caption = 'Interview Date';
        }
        field(8; "Interview Time"; Time)
        {
            Caption = 'Interview Time';
        }
        field(9; Select; Boolean)
        {
            Caption = 'Select';
        }
    }

    keys
    {
        key(Key1; No, "Interview Round Code")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    var
        InterviewRound: Record "Interview Round";
}

