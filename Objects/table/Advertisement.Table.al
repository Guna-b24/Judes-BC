table 72012 Advertisement
{
    // -----------------------------------------------------------------------------------------------
    // Firstware Sofware Solutions : Project Name : HR & PAYROLL
    // -----------------------------------------------------------------------------------------------
    // No.  Date          Developer     Spec/CU/CR      Description
    // -----------------------------------------------------------------------------------------------
    // 1    04.APR.2009   SENTHIL                       New Tables Added for HR Module.

    Caption = 'Advertisement';
    DataCaptionFields = "No.";
    DrillDownPageID = 72017;
    LookupPageID = 72017;

    fields
    {
        field(1; "No."; Code[20])
        {
            Caption = 'No.';
        }
        field(2; "Company Name"; Text[30])
        {
            Caption = 'Company Name';
        }
        field(3; "Address 1"; Text[30])
        {
            Caption = 'Address 1';
        }
        field(4; "Address 2"; Text[30])
        {
            Caption = 'Address 2';
        }
        field(5; "Address 3"; Text[30])
        {
            Caption = 'Address 3';
        }
        field(6; City; Text[30])
        {
            Caption = 'City';
        }
        field(7; "Postal Code"; Code[10])
        {
            Caption = 'Postal Code';
            TableRelation = "Post Code";
        }
        field(8; Country; Code[10])
        {
            Caption = 'Country';
            TableRelation = "Country/Region";
        }
        field(9; "Contact Person"; Text[30])
        {
            Caption = 'Contact Person';
        }
        field(10; Phone; Text[30])
        {
            Caption = 'Phone';
        }
        field(11; Mobile; Text[30])
        {
            Caption = 'Mobile';
        }
        field(12; "E-Mail"; Text[30])
        {
            Caption = 'E-Mail';
        }
        field(13; "No. Of Vacancy"; Integer)
        {
            Caption = 'No. Of Vacancy';
        }
        field(14; "Required Vacancy"; Code[10])
        {
            Caption = 'Required Vacancy';
        }
        field(15; "Vacancy Description"; Text[100])
        {
            Caption = 'Vacancy Description';
        }
        field(16; Gender; Option)
        {
            Caption = 'Gender';
            OptionCaption = ' ,Male,Female';
            OptionMembers = " ",Male,Female;
        }
        field(17; "Qualification Code"; Code[10])
        {
            Caption = 'Qualification Code';
        }
        field(18; "Qualification Description"; Text[100])
        {
            Caption = 'Qualification Description';
        }
        field(19; Prefrence; Text[250])
        {
            Caption = 'Prefrence';
        }
        field(20; Skill; Text[250])
        {
            Caption = 'Skill';
        }
        field(21; Certification; Text[250])
        {
            Caption = 'Certification';
        }
        field(22; "Experience(In Yrs)"; Decimal)
        {
            Caption = 'Experience(In Yrs)';
        }
        field(23; "Age From"; Integer)
        {
            Caption = 'Age From';
        }
        field(24; "Age To"; Integer)
        {
            Caption = 'Age To';
        }
        field(25; "Required Date"; Date)
        {
            Caption = 'Required Date';
        }
        field(26; "Advertisement Type"; Option)
        {
            Caption = 'Advertisement Type';
            OptionCaption = ' ,News Papper,Agency';
            OptionMembers = " ","News Papper",Agency;
        }
        field(27; "Age Ability"; Text[30])
        {
            Caption = 'Age Ability';
        }
    }

    keys
    {
        key(Key1; "No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

