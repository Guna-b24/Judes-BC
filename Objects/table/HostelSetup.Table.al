table 71683 "Hostel Setup"
{
    Caption = 'Hostel Setup';
    DataClassification = CustomerContent;
    LookupPageId = "Hostel Setup";

    fields
    {
        field(1; "Primary Key"; Code[10])
        {
            Caption = 'Primary Key';
            DataClassification = SystemMetadata;
            ToolTip = 'Specifies the primary key for the hostel setup record.';
        }
        field(2; "Hostel Allocation"; Code[20])
        {
            Caption = 'Hostel Allocation';
            DataClassification = CustomerContent;
            ToolTip = 'Specifies the hostel allocation number series or reference.';
        }
        field(3; "Hostel Fee No."; Code[20])
        {
            Caption = 'Hostel Fee No.';
            DataClassification = CustomerContent;
            ToolTip = 'Specifies the hostel fee document number series.';
        }
        field(4; "Hostel Fee Code"; Code[20])
        {
            Caption = 'Hostel Fee Code';
            DataClassification = CustomerContent;
            ToolTip = 'Specifies the code for hostel fee configuration.';
        }
        field(5; Company; Option)
        {
            Caption = 'Company';
            OptionMembers = " ",MontFord,WestBrook;
            OptionCaption = ' ,MontFord,WestBrook';
            DataClassification = OrganizationIdentifiableInformation;
            ToolTip = 'Specifies the company to which the hostel setup applies.';
        }
        field(6; "Consumption Code"; Code[20])
        {
            Caption = 'Consumption Code';
            DataClassification = CustomerContent;
            ToolTip = 'Specifies the consumption-related configuration code.';
        }
        field(7; "Room Change No."; Code[20])
        {
            Caption = 'Room Change No.';
            DataClassification = CustomerContent;
            ToolTip = 'Specifies the number series used for room change transactions.';
        }
        field(8; "Hostel Attendance No."; Code[20])
        {
            Caption = 'Hostel Attendance No.';
            DataClassification = CustomerContent;
            ToolTip = 'Specifies the number series used for hostel attendance entries.';
        }
        field(9; "Mess Fee"; Option)
        {
            Caption = 'Mess Fee';
            OptionMembers = " ",Fixed,Variable;
            OptionCaption = ' ,Fixed,Variable';
            DataClassification = CustomerContent;
            ToolTip = 'Specifies the mess fee calculation type.';
        }
        field(10; "Mess Fee Code"; Code[20])
        {
            Caption = 'Mess Fee Code';
            DataClassification = CustomerContent;
            ToolTip = 'Specifies the mess fee configuration code.';
        }
        field(11; "Room Rent Charging"; Option)
        {
            Caption = 'Room Rent Charging';
            OptionMembers = " ",Monthly,Daily;
            OptionCaption = ' ,Monthly,Daily';
            DataClassification = CustomerContent;
            ToolTip = 'Specifies the room rent charging method.';
        }
        field(12; "Room Rent"; Decimal)
        {
            Caption = 'Room Rent';
            DataClassification = CustomerContent;
            ToolTip = 'Specifies the default room rent amount.';
        }
        field(13; "Electricity Expense Code"; Code[20])
        {
            Caption = 'Electricity Expense Code';
            DataClassification = CustomerContent;
            ToolTip = 'Specifies the electricity expense configuration code.';
        }
        field(20; "MontFord Issue Batch"; Code[20])
        {
            Caption = 'MontFord Issue Batch';
            DataClassification = CustomerContent;
            ToolTip = 'Specifies the issue batch code for MontFord company.';
        }
        field(21; "WestBrook Issue Batch"; Code[20])
        {
            Caption = 'WestBrook Issue Batch';
            DataClassification = CustomerContent;
            ToolTip = 'Specifies the issue batch code for WestBrook company.';
        }
        field(70120; "User ID"; Code[20])
        {
            Caption = 'User ID';
            DataClassification = EndUserIdentifiableInformation;
            ToolTip = 'Specifies the user ID associated with the hostel setup.';
        }
        field(70121; "Portal ID"; Code[20])
        {
            Caption = 'Portal ID';
            DataClassification = CustomerContent;
            ToolTip = 'Specifies the portal ID linked to the hostel setup.';
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
