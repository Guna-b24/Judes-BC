table 71040 "Academics Setup"
{
    //   No   Date        Sign       Trigger          Description
    // -----------------------------------------------------------------------------------------------
    //   01   17/09/09    Kathir                      Table Created by Kathir
    //   02   19/10/09    VANDHANA  OnInsert          Code to assign User ID.

    Caption = 'Academics Setup';

    fields
    {
        field(1; "Primary Key"; Code[10])
        {
            Caption = 'Primary Key';
        }
        field(2; "Marks No."; Code[20])
        {
            Caption = 'Marks No.';
            TableRelation = "No. Series";
        }
        field(4; Attendance; Option)
        {
            Caption = 'Attendance';
            OptionCaption = 'Daily,Hourly';
            OptionMembers = Daily,Hourly;
        }
        field(5; "Fore Noon Attendance Hour"; Integer)
        {
            BlankZero = true;
            Caption = 'Fore Noon Attendance Hour';
        }
        field(6; "After Noon Attendance Hour"; Integer)
        {
            BlankZero = true;
            Caption = 'After Noon Attendance Hour';
        }
        field(7; "Attendance No."; Code[20])
        {
            Caption = 'Attendance No.';
            TableRelation = "No. Series";
        }
        field(8; "Withdrawl No."; Code[20])
        {
            Caption = 'Withdrawl No.';
            TableRelation = "No. Series";
        }
        field(9; "TC No."; Code[20])
        {
            Caption = 'TC No.';
            TableRelation = "No. Series";
        }
        field(10; "Class Syllabus No."; Code[20])
        {
            Caption = 'Class Syllabus No.';
            TableRelation = "No. Series";
        }
        field(11; "Faculty Class Plan No."; Code[20])
        {
            Caption = 'Faculty Class Plan No.';
            TableRelation = "No. Series";
        }
        field(12; "Exam Schedule No."; Code[20])
        {
            Caption = 'Exam Schedule No.';
            TableRelation = "No. Series";
        }
        field(13; "Student Leave Application No."; Code[20])
        {
            Caption = 'Student Leave Application No.';
            TableRelation = "No. Series";
        }
        field(14; "Mark Super User"; Code[20])
        {
            TableRelation = "Portal Users";
        }
        field(20; "Prescription Nos."; Code[20])
        {
            TableRelation = "No. Series";
        }
        field(21; "Edu. Calender No."; Code[20])
        {
            TableRelation = "No. Series";
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
        key(Key1; "Primary Key")
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
}

