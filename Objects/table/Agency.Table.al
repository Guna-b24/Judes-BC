table 72011 Agency
{
    Caption = 'Agency';
    DataCaptionFields = "Indenting No";
    // DrillDownPageID = 72016;
    // LookupPageID = 72016;

    fields
    {
        field(1; "Indenting No"; Code[20])
        {
            Caption = 'Indenting No';
            ToolTip = 'Specifies the unique indenting number for the agency record.';
            DataClassification = SystemMetadata;
        }

        field(2; "Agency Code"; Code[10])
        {
            Caption = 'Agency Code';
            NotBlank = true;
            ToolTip = 'Specifies the code assigned to the agency.';
            DataClassification = CustomerContent;
        }

        field(3; "Agency Name"; Text[30])
        {
            Caption = 'Agency Name';
            ToolTip = 'Specifies the name of the agency.';
            DataClassification = CustomerContent;
        }

        field(4; "Contact Person"; Text[30])
        {
            Caption = 'Contact Person';
            ToolTip = 'Specifies the contact person for the agency.';
            DataClassification = EndUserIdentifiableInformation;
        }

        field(5; "Address 1"; Text[30])
        {
            Caption = 'Address 1';
            ToolTip = 'Specifies the first line of the agency address.';
            DataClassification = CustomerContent;
        }

        field(6; "Address 2"; Text[30])
        {
            Caption = 'Address 2';
            ToolTip = 'Specifies the second line of the agency address.';
            DataClassification = CustomerContent;
        }

        field(7; "Address 3"; Text[30])
        {
            Caption = 'Address 3';
            ToolTip = 'Specifies the third line of the agency address.';
            DataClassification = CustomerContent;
        }

        field(8; "Postal Code"; Code[10])
        {
            Caption = 'Postal Code';
            ToolTip = 'Specifies the postal code of the agency address.';
            DataClassification = CustomerContent;
            TableRelation = "Post Code";
            ValidateTableRelation = false;

        }

        field(9; City; Text[30])
        {
            Caption = 'City';
            ToolTip = 'Specifies the city of the agency address.';
            DataClassification = CustomerContent;
        }

        field(10; Country; Code[10])
        {
            Caption = 'Country';
            ToolTip = 'Specifies the country of the agency.';
            TableRelation = "Country/Region";
            DataClassification = CustomerContent;
        }

        field(11; Phone; Text[30])
        {
            Caption = 'Phone';
            ToolTip = 'Specifies the phone number of the agency contact.';
            DataClassification = EndUserIdentifiableInformation;
        }

        field(12; Mobile; Text[30])
        {
            Caption = 'Mobile';
            ToolTip = 'Specifies the mobile number of the agency contact.';
            DataClassification = EndUserIdentifiableInformation;
        }

        field(13; Fax; Text[30])
        {
            Caption = 'Fax';
            ToolTip = 'Specifies the fax number of the agency.';
            DataClassification = CustomerContent;
        }

        field(14; "E-mail"; Text[50])
        {
            Caption = 'E-mail';
            ToolTip = 'Specifies the email address of the agency contact.';
            DataClassification = EndUserIdentifiableInformation;
        }

        field(15; Attachment; Text[100])
        {
            Caption = 'Attachment';
            ToolTip = 'Specifies the file attachment related to the agency.';
            DataClassification = CustomerContent;
        }

        field(16; Date; Date)
        {
            Caption = 'Date';
            ToolTip = 'Specifies the date associated with the agency record.';
            DataClassification = SystemMetadata;
        }
    }

    keys
    {
        key(Key1; "Indenting No", "Agency Code")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    var
}
