table 72011 Agency
{
    // -----------------------------------------------------------------------------------------------
    // Firstware Sofware Solutions : Project Name : HR & PAYROLL
    // -----------------------------------------------------------------------------------------------
    // No.  Date          Developer     Spec/CU/CR      Description
    // -----------------------------------------------------------------------------------------------
    // 1    04.APR.2009   SENTHIL                       New Tables Added for HR Module.

    Caption = 'Agency';
    DataCaptionFields = "Indenting No";
    DrillDownPageID = 72016;
    LookupPageID = 72016;

    fields
    {
        field(1; "Indenting No"; Code[20])
        {
            Caption = 'Indenting No';
        }
        field(2; "Agency Code"; Code[10])
        {
            Caption = 'Agency Code';
            NotBlank = true;
        }
        field(3; "Agency Name"; Text[30])
        {
            Caption = 'Agency Name';
        }
        field(4; "Contact Person"; Text[30])
        {
            Caption = 'Contact Person';
        }
        field(5; "Address 1"; Text[30])
        {
            Caption = 'Address 1';
        }
        field(6; "Address 2"; Text[30])
        {
            Caption = 'Address 2';
        }
        field(7; "Address 3"; Text[30])
        {
            Caption = 'Address 3';
        }
        field(8; "Postal Code"; Code[10])
        {
            Caption = 'Postal Code';
            TableRelation = "Post Code";
            //This property is currently not supported
            //TestTableRelation = false;
            ValidateTableRelation = false;

            trigger OnLookup()
            begin
                //PostCode.LookUpPostCode(City,"Postal Code",TRUE);
            end;

            trigger OnValidate()
            begin
                //PostCode.ValidatePostCode(City,"Postal Code");
            end;
        }
        field(9; City; Text[30])
        {
            Caption = 'City';

            trigger OnLookup()
            begin
                //PostCode.LookUpCity(City,"Postal Code",TRUE);
            end;

            trigger OnValidate()
            begin
                //PostCode.ValidateCity(City,"Postal Code");
            end;
        }
        field(10; Country; Code[10])
        {
            Caption = 'Country';
            TableRelation = "Country/Region";
        }
        field(11; Phone; Text[30])
        {
            Caption = 'Phone';
        }
        field(12; Mobile; Text[30])
        {
            Caption = 'Mobile';
        }
        field(13; Fax; Text[30])
        {
            Caption = 'Fax';
        }
        field(14; "E-mail"; Text[50])
        {
            Caption = 'E-mail';
        }
        field(15; Attachment; Text[100])
        {
            Caption = 'Attachment';
        }
        field(16; Date; Date)
        {
            Caption = 'Date';
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
        PostCode: Record "Post Code";
}

