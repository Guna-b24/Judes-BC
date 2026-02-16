table 71633 "Library Setup Table"
{
    Caption = 'Library Setup Table';
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Primary Key"; Code[10])
        {
            Caption = 'Primary Key';
            DataClassification = SystemMetadata;
            ToolTip = 'Specifies the primary key for the library setup record.';
        }
        field(3; "No. of Books - Staffs"; Integer)
        {
            Caption = 'No. of Books - Staffs';
            DataClassification = CustomerContent;
            ToolTip = 'Specifies the maximum number of books that can be issued to staff.';
        }
        field(5; "No. of Days - Staffs"; Integer)
        {
            Caption = 'No. of Days - Staffs';
            DataClassification = CustomerContent;
            ToolTip = 'Specifies the number of days books can be retained by staff.';
        }
        field(6; "Fine - Students"; Decimal)
        {
            Caption = 'Fine - Students';
            DataClassification = CustomerContent;
            ToolTip = 'Specifies the fine amount applicable to students per day.';
        }
        field(7; "Fine - Staffs"; Decimal)
        {
            Caption = 'Fine - Staffs';
            DataClassification = CustomerContent;
            ToolTip = 'Specifies the fine amount applicable to staff per day.';
        }
        field(8; "Base Unit of Measure"; Code[10])
        {
            Caption = 'Base Unit of Measure';
            DataClassification = CustomerContent;
            ToolTip = 'Specifies the base unit of measure for library items.';
        }
        field(9; "Item Category Code"; Code[10])
        {
            Caption = 'Item Category Code';
            DataClassification = CustomerContent;
            ToolTip = 'Specifies the item category code for books.';
        }
        field(10; "Book No"; Code[10])
        {
            Caption = 'Book No';
            DataClassification = CustomerContent;
            ToolTip = 'Specifies the number series for book records.';
        }
        field(11; "Advance Booking No."; Code[10])
        {
            Caption = 'Advance Booking No.';
            DataClassification = CustomerContent;
            ToolTip = 'Specifies the number series for advance booking.';
        }
        field(12; "Fine Code"; Code[20])
        {
            Caption = 'Fine Code';
            DataClassification = CustomerContent;
            ToolTip = 'Specifies the fine code used for penalty postings.';
        }
        field(13; Company; Option)
        {
            Caption = 'Company';
            OptionMembers = " ",MontFord,WestBrook;
            OptionCaption = ' ,MontFord,WestBrook';
            DataClassification = OrganizationIdentifiableInformation;
            ToolTip = 'Specifies the company for which the library setup applies.';
        }
        field(14; "Location Code"; Code[10])
        {
            Caption = 'Location Code';
            DataClassification = OrganizationIdentifiableInformation;
            ToolTip = 'Specifies the location of the library.';
        }
        field(15; "Book Purch Req No."; Code[20])
        {
            Caption = 'Book Purch Req No.';
            DataClassification = CustomerContent;
            ToolTip = 'Specifies the number series for book purchase requisitions.';
        }
        field(16; "No. of Renewal - Staffs"; Integer)
        {
            Caption = 'No. of Renewal - Staffs';
            DataClassification = CustomerContent;
            ToolTip = 'Specifies the number of renewals allowed for staff.';
        }
        field(17; "G/L Account"; Code[20])
        {
            Caption = 'G/L Account';
            DataClassification = CustomerContent;
            ToolTip = 'Specifies the general ledger account used for library transactions.';
        }
        field(18; "No. of Books - Student"; Integer)
        {
            Caption = 'No. of Books - Student';
            DataClassification = CustomerContent;
            ToolTip = 'Specifies the maximum number of books that can be issued to students.';
        }
        field(19; "No. of Days - Student"; Integer)
        {
            Caption = 'No. of Days - Student';
            DataClassification = CustomerContent;
            ToolTip = 'Specifies the number of days books can be retained by students.';
        }
        field(20; "Journal Template Name"; Code[20])
        {
            Caption = 'Journal Template Name';
            DataClassification = CustomerContent;
            ToolTip = 'Specifies the journal template name used for postings.';
        }
        field(21; "Journal Batch Name"; Code[20])
        {
            Caption = 'Journal Batch Name';
            DataClassification = CustomerContent;
            ToolTip = 'Specifies the journal batch name used for postings.';
        }
        field(22; "Fee Invoice No."; Code[20])
        {
            Caption = 'Fee Invoice No.';
            DataClassification = CustomerContent;
            ToolTip = 'Specifies the number series for fee invoices.';
        }
        field(23; "Library MF User ID"; Code[20])
        {
            Caption = 'Library MF User ID';
            DataClassification = EndUserIdentifiableInformation;
            ToolTip = 'Specifies the user ID for MontFord library operations.';
        }
        field(24; "Library WB User ID"; Code[10])
        {
            Caption = 'Library WB User ID';
            DataClassification = EndUserIdentifiableInformation;
            ToolTip = 'Specifies the user ID for WestBrook library operations.';
        }
        field(25; "No Of Renewal"; Integer)
        {
            Caption = 'No Of Renewal';
            DataClassification = CustomerContent;
            ToolTip = 'Specifies the default number of renewals allowed.';
        }
        field(26; "Accession No. - MF"; Code[20])
        {
            Caption = 'Accession No. - MF';
            DataClassification = CustomerContent;
            ToolTip = 'Specifies the accession number series for MontFord.';
        }
        field(27; "Accession No. - WB"; Code[20])
        {
            Caption = 'Accession No. - WB';
            DataClassification = CustomerContent;
            ToolTip = 'Specifies the accession number series for WestBrook.';
        }
        field(28; "Book No. - WB"; Code[20])
        {
            Caption = 'Book No. - WB';
            DataClassification = CustomerContent;
            ToolTip = 'Specifies the book number series for WestBrook.';
        }
        field(70121; "Portal ID"; Code[20])
        {
            Caption = 'Portal ID';
            DataClassification = CustomerContent;
            ToolTip = 'Specifies the portal ID linked to the library setup.';
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
