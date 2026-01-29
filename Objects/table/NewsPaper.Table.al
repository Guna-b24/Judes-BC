table 72010 "News Paper"
{
    // -----------------------------------------------------------------------------------------------
    // Firstware Sofware Solutions : Project Name : HR & PAYROLL
    // -----------------------------------------------------------------------------------------------
    // No.  Date          Developer     Spec/CU/CR      Description
    // -----------------------------------------------------------------------------------------------
    // 1    04.APR.2009   SENTHIL                       New Tables Added for HR Module.

    Caption = 'News Paper';
    DataCaptionFields = "Indenting No.";
    DrillDownPageID = 72014;
    LookupPageID = 72014;

    fields
    {
        field(1; "Indenting No."; Code[20])
        {
            Caption = 'Indenting No.';
        }
        field(2; "News Paper Code"; Code[10])
        {
            Caption = 'News Paper Code';
        }
        field(3; "News Paper Name"; Text[30])
        {
            Caption = 'News Paper Name';
        }
        field(4; "Contact Person"; Text[30])
        {
            Caption = 'Contact Person';
        }
        field(5; "Address 1"; Text[30])
        {
            Caption = 'Address1';
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
        field(17; "Page No."; Integer)
        {
            Caption = 'Page No.';
        }
        field(18; Size; Text[30])
        {
            Caption = 'Size';
        }
        field(19; Amount; Decimal)
        {
            Caption = 'Amount';
        }
        field(20; "Payment Method"; Option)
        {
            Caption = 'Payment Method';
            OptionCaption = 'Cash,Cheque,Bank Transfer';
            OptionMembers = Cash,Cheque,"Bank Transfer";
        }
        field(21; "Bank Code"; Code[10])
        {
            Caption = 'Bank Code';
        }
        field(22; "Bank Name"; Code[30])
        {
            Caption = 'Bank Name';
        }
        field(23; "Bank Branch"; Code[30])
        {
            Caption = 'Bank Branch';
        }
        field(24; "Account Type"; Text[30])
        {
            Caption = 'Account Type';
        }
        field(25; "Account No"; Code[20])
        {
            Caption = 'Account No';
        }
    }

    keys
    {
        key(Key1; "Indenting No.", "News Paper Code")
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

