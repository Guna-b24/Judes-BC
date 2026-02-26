table 72012 Advertisement
{
    Caption = 'Advertisement';
    DataCaptionFields = "No.";
    // DrillDownPageID = 72017; 
    LookupPageID = "Advertisement List";

    fields
    {
        field(1; "No."; Code[20])
        {
            Caption = 'No.';
            ToolTip = 'Specifies the unique number of the advertisement.';
            DataClassification = SystemMetadata;
        }

        field(2; "Company Name"; Text[30])
        {
            Caption = 'Company Name';
            ToolTip = 'Specifies the name of the company advertising the vacancy.';
            DataClassification = CustomerContent;
        }

        field(3; "Address 1"; Text[30])
        {
            Caption = 'Address 1';
            ToolTip = 'Specifies the first line of the company address.';
            DataClassification = CustomerContent;
        }

        field(4; "Address 2"; Text[30])
        {
            Caption = 'Address 2';
            ToolTip = 'Specifies the second line of the company address.';
            DataClassification = CustomerContent;
        }

        field(5; "Address 3"; Text[30])
        {
            Caption = 'Address 3';
            ToolTip = 'Specifies the third line of the company address.';
            DataClassification = CustomerContent;
        }

        field(6; City; Text[30])
        {
            Caption = 'City';
            ToolTip = 'Specifies the city of the company.';
            DataClassification = CustomerContent;
        }

        field(7; "Postal Code"; Code[10])
        {
            Caption = 'Postal Code';
            ToolTip = 'Specifies the postal code of the company address.';
            TableRelation = "Post Code";
            DataClassification = CustomerContent;
        }

        field(8; Country; Code[10])
        {
            Caption = 'Country';
            ToolTip = 'Specifies the country or region of the company.';
            TableRelation = "Country/Region";
            DataClassification = CustomerContent;
        }

        field(9; "Contact Person"; Text[30])
        {
            Caption = 'Contact Person';
            ToolTip = 'Specifies the contact person for the advertisement.';
            DataClassification = EndUserIdentifiableInformation;
        }

        field(10; Phone; Text[30])
        {
            Caption = 'Phone';
            ToolTip = 'Specifies the phone number of the contact person.';
            DataClassification = EndUserIdentifiableInformation;
        }

        field(11; Mobile; Text[30])
        {
            Caption = 'Mobile';
            ToolTip = 'Specifies the mobile number of the contact person.';
            DataClassification = EndUserIdentifiableInformation;
        }

        field(12; "E-Mail"; Text[30])
        {
            Caption = 'E-Mail';
            ToolTip = 'Specifies the email address of the contact person.';
            DataClassification = EndUserIdentifiableInformation;
        }

        field(13; "No. Of Vacancy"; Integer)
        {
            Caption = 'No. Of Vacancy';
            ToolTip = 'Specifies the number of vacancies available.';
            DataClassification = CustomerContent;
        }

        field(14; "Required Vacancy"; Code[10])
        {
            Caption = 'Required Vacancy';
            ToolTip = 'Specifies the type or category of vacancy required.';
            DataClassification = CustomerContent;
        }

        field(15; "Vacancy Description"; Text[100])
        {
            Caption = 'Vacancy Description';
            ToolTip = 'Specifies the description of the vacancy.';
            DataClassification = CustomerContent;
        }

        field(16; Gender; Option)
        {
            Caption = 'Gender';
            ToolTip = 'Specifies the preferred gender for the vacancy.';
            OptionCaption = ' ,Male,Female';
            OptionMembers = " ",Male,Female;
            DataClassification = CustomerContent;
        }

        field(17; "Qualification Code"; Code[10])
        {
            Caption = 'Qualification Code';
            ToolTip = 'Specifies the qualification code required for the vacancy.';
            DataClassification = CustomerContent;
        }

        field(18; "Qualification Description"; Text[100])
        {
            Caption = 'Qualification Description';
            ToolTip = 'Specifies the qualification details required for the vacancy.';
            DataClassification = CustomerContent;
        }

        field(19; Prefrence; Text[250])
        {
            Caption = 'Prefrence';
            ToolTip = 'Specifies additional preferences for the vacancy.';
            DataClassification = CustomerContent;
        }

        field(20; Skill; Text[250])
        {
            Caption = 'Skill';
            ToolTip = 'Specifies the skills required for the vacancy.';
            DataClassification = CustomerContent;
        }

        field(21; Certification; Text[250])
        {
            Caption = 'Certification';
            ToolTip = 'Specifies the certifications required for the vacancy.';
            DataClassification = CustomerContent;
        }

        field(22; "Experience(In Yrs)"; Decimal)
        {
            Caption = 'Experience(In Yrs)';
            ToolTip = 'Specifies the required experience in years.';
            DataClassification = CustomerContent;
        }

        field(23; "Age From"; Integer)
        {
            Caption = 'Age From';
            ToolTip = 'Specifies the minimum age requirement.';
            DataClassification = CustomerContent;
        }

        field(24; "Age To"; Integer)
        {
            Caption = 'Age To';
            ToolTip = 'Specifies the maximum age requirement.';
            DataClassification = CustomerContent;
        }

        field(25; "Required Date"; Date)
        {
            Caption = 'Required Date';
            ToolTip = 'Specifies the date by which the vacancy is required.';
            DataClassification = CustomerContent;
        }

        field(26; "Advertisement Type"; Option)
        {
            Caption = 'Advertisement Type';
            ToolTip = 'Specifies the medium through which the advertisement is published.';
            OptionCaption = ' ,News Papper,Agency';
            OptionMembers = " ","News Papper",Agency;
            DataClassification = CustomerContent;
        }

        field(27; "Age Ability"; Text[30])
        {
            Caption = 'Age Ability';
            ToolTip = 'Specifies age-related eligibility or flexibility.';
            DataClassification = CustomerContent;
        }
    }

    keys
    {
        key(Key1; "No.")
        {
            Clustered = true;
        }
    }
}
