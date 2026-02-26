table 71040 "Academics Setup"
{
    Caption = 'Academics Setup';
    LookupPageId = "Academics Setup";

    fields
    {
        field(1; "Primary Key"; Code[10])
        {
            Caption = 'Primary Key';
            DataClassification = SystemMetadata;
        }
        field(2; "Marks No."; Code[20])
        {
            Caption = 'Marks No.';
            TableRelation = "No. Series";
            DataClassification = SystemMetadata;
            ToolTip = 'Specifies the number series used for marks.';
        }
        field(4; Attendance; Option)
        {
            Caption = 'Attendance';
            OptionMembers = Daily,Hourly;
            OptionCaption = 'Daily,Hourly';
            DataClassification = SystemMetadata;
            ToolTip = 'Specifies whether attendance is tracked daily or hourly.';
        }
        field(5; "Fore Noon Attendance Hour"; Integer)
        {
            Caption = 'Fore Noon Attendance Hour';
            BlankZero = true;
            MinValue = 0;
            DataClassification = SystemMetadata;
            ToolTip = 'Specifies the number of attendance hours in the forenoon.';
        }
        field(6; "After Noon Attendance Hour"; Integer)
        {
            Caption = 'After Noon Attendance Hour';
            BlankZero = true;
            MinValue = 0;
            DataClassification = SystemMetadata;
            ToolTip = 'Specifies the number of attendance hours in the afternoon.';
        }
        field(7; "Attendance No."; Code[20])
        {
            Caption = 'Attendance No.';
            TableRelation = "No. Series";
            DataClassification = SystemMetadata;
            ToolTip = 'Specifies the number series for attendance documents.';
        }
        field(8; "Withdrawl No."; Code[20])
        {
            Caption = 'Withdrawl No.';
            TableRelation = "No. Series";
            DataClassification = SystemMetadata;
            ToolTip = 'Specifies the number series for Withdrawl No.';
        }
        field(9; "TC No."; Code[20])
        {
            Caption = 'TC No.';
            TableRelation = "No. Series";
            DataClassification = SystemMetadata;
            ToolTip = 'Specifies the number series for Tc No.';
        }
        field(10; "Class Syllabus No."; Code[20])
        {
            Caption = 'Class Syllabus No.';
            TableRelation = "No. Series";
            DataClassification = SystemMetadata;
            ToolTip = 'Specifies the number series for "Class Syllabus No.';
        }
        field(11; "Faculty Class Plan No."; Code[20])
        {
            Caption = 'Faculty Class Plan No.';
            TableRelation = "No. Series";
            DataClassification = SystemMetadata;
            ToolTip = 'Specifies the number series for Faculty Class Plan No.';
        }
        field(12; "Exam Schedule No."; Code[20])
        {
            Caption = 'Exam Schedule No.';
            TableRelation = "No. Series";
            DataClassification = SystemMetadata;
            ToolTip = 'Specifies the number series for Exam Schedule No.';
        }
        field(13; "Student Leave Application No."; Code[20])
        {
            Caption = 'Student Leave Application No.';
            TableRelation = "No. Series";
            DataClassification = SystemMetadata;
            ToolTip = 'Specifies the number series for Student Leave Application No.';
        }
        field(14; "Mark Super User"; Code[20])
        {
            TableRelation = "Portal Users";
            DataClassification = EndUserIdentifiableInformation;
            ToolTip = 'Specifies the portal user who has super user rights for marks.';
        }
        field(20; "Prescription Nos."; Code[20])
        {
            Caption = 'Prescription Nos.';
            TableRelation = "No. Series";
            DataClassification = SystemMetadata;
            ToolTip = 'Specifies the number series for Prescription Nos.';
        }
        field(21; "Edu. Calender No."; Code[20])
        {
            Caption = 'Edu. Calender No.';
            TableRelation = "No. Series";
            DataClassification = SystemMetadata;
            ToolTip = 'Specifies the number series for Edu. Calender No.';
        }
        field(70121; "Portal ID"; Code[20])
        {
            Caption = 'Portal ID';
            DataClassification = SystemMetadata;
            ToolTip = 'Specifies the Portal ID for Academics Setup';
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

}

