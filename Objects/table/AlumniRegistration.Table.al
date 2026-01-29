table 71180 "Alumni Registration"
{
    //   No   Date      Sign     Trigger                      Description
    // -----------------------------------------------------------------------------------------------
    //   01  29.09.09  VANDHANA  Student No. - OnValidate()   Code to get the Student details
    //   02  16.10.09  VANDHANA  City-OnValidate              Code added for Validate PostCode
    //   03  16.10.09  VANDHANA  City-Onlookup                Code added for Validate PostCode
    //   04  16.10.09  VANDHANA  PostCode-OnValidate          Code added for Validate PostCode
    //   05  16.10.09  VANDHANA  PostCode-Onlookup            Code added for Validate PostCode
    //   06  19/10/09  VANDHANA  OnInsert                     Code to assign User ID.

    Caption = 'Alumni Registration';
    DrillDownPageID = 71181;
    LookupPageID = 71181;

    fields
    {
        field(1; "Student No."; Code[20])
        {
            Caption = 'Student No.';
        }
        field(2; Name; Text[50])
        {
            Caption = 'Name';
        }
        field(3; Gender; Option)
        {
            OptionCaption = ' ,Male,Female';
            OptionMembers = " ",Male,Female;
        }
        field(4; "Date of Birth"; Date)
        {
        }
        field(5; "Year Of Joining"; Integer)
        {
            Caption = 'Year Of Joining';
        }
        field(6; "Year Of Graduation"; Integer)
        {
            Caption = 'Year Of Graduation';
        }
        field(7; "Class Of Graduation"; Option)
        {
            Caption = 'Class Of Graduation';
            OptionCaption = ' ,10,12';
            OptionMembers = " ","10","12";
        }
        field(8; "Present Occupation"; Option)
        {
            OptionCaption = ' ,Student,Employed,Self-Employed';
            OptionMembers = " ",Student,Employed,"Self-Employed";
        }
        field(9; "Bachelor Degree"; Text[80])
        {
            TableRelation = "Course and Stream".Course WHERE ("Course Stream" = CONST ('Bachelor Degree'));
        }
        field(11; "Master Degree"; Text[80])
        {
            TableRelation = "Course and Stream".Course WHERE ("Course Stream" = CONST ('Master Degree'));
        }
        field(12; PhD; Text[80])
        {
            TableRelation = "Course and Stream".Course WHERE ("Course Stream" = CONST ('Doctoral degrees'));
        }
        field(13; "Medical Courses"; Option)
        {
            OptionCaption = ' ,MBBS,BDS,MDS';
            OptionMembers = " ",MBBS,BDS,MDS;
        }
        field(14; "Doctor of Medicine"; Text[80])
        {
            TableRelation = "Course and Stream".Course WHERE ("Course Stream" = CONST ('MD'));
        }
        field(15; "Name of the Institution"; Text[30])
        {
        }
        field(16; Qualification; Text[30])
        {
        }
        field(17; "Name of the Company"; Text[30])
        {
            Caption = 'Name Of the  Company';
        }
        field(18; Designation; Text[30])
        {
            Caption = 'Designation';
        }
        field(19; "Type of Business"; Text[30])
        {
        }
        field(20; "Mobile Number"; Code[15])
        {
            Caption = 'Mobile Number';
        }
        field(21; Telephone; Code[15])
        {
        }
        field(22; "E-mail"; Text[80])
        {
            Caption = 'E-mail';
        }
        field(23; "Present-Address"; Text[250])
        {
            Caption = 'Present-Address1';
        }
        field(25; "Persent-City"; Code[20])
        {
            //The property 'ValidateTableRelation' can only be set if the property 'TableRelation' is set
            //ValidateTableRelation = true;
        }
        field(26; "Present-PostCode"; Code[20])
        {
            Caption = 'Present-PostCode';
        }
        field(27; "Present-State"; Code[20])
        {
            Caption = 'Present-State';
        }
        field(28; "Present-Country"; Code[20])
        {
            Caption = 'Present-Country';
        }
        field(29; "Permanent-Address"; Text[250])
        {
        }
        field(31; "Permanent-City"; Code[20])
        {
        }
        field(32; "Permanent-PostCode"; Code[20])
        {
        }
        field(33; "Permanent-State"; Code[20])
        {
        }
        field(34; "Permanent-Country"; Code[20])
        {
        }
        field(35; Achievements; Text[250])
        {
        }
        field(36; Hobbies; Text[100])
        {
        }
        field(37; Comments; Text[250])
        {
        }
        field(70120; "User ID"; Code[20])
        {
            Caption = 'User ID';
        }
        field(70121; "Portal ID"; Code[20])
        {
            Caption = 'Portal ID';
        }
        field(70122; Mobile2; Code[15])
        {
        }
        field(70123; QualificationName; Text[100])
        {
        }
        field(70124; BachelorInstitute; Text[50])
        {
        }
        field(70125; MasterInstitute; Text[50])
        {
        }
        field(70126; PhDInstitute; Text[50])
        {
        }
        field(70127; MedicalInstitute; Text[50])
        {
        }
        field(70128; MDInstitute; Text[50])
        {
        }
        field(70129; MS; Text[50])
        {
        }
        field(70130; MSInstitute; Text[50])
        {
        }
        field(70131; AgreeToUseComment; Boolean)
        {
        }
        field(70132; IsRegistered; Boolean)
        {
        }
        field(70133; Event1; Boolean)
        {
        }
        field(70134; Event1Desc; Text[150])
        {
        }
        field(70135; Event2; Boolean)
        {
        }
        field(70136; Event2Desc; Text[150])
        {
        }
    }

    keys
    {
        key(Key1; "Student No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    begin
        // Start 06. VANDHANA
        "User ID" := UserId;
        // Stop 06. VANDHANA
    end;

    var
        Student: Record Student;
        PostCode1: Record "Post Code";
}

