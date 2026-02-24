table 71680 "Hostel1"
{
    Caption = 'Hostel1';
    DataClassification = CustomerContent;
    DrillDownPageId = "Hostel List";
    LookupPageId = "Hostel List";

    fields
    {
        field(1; Code; Code[20])
        {
            Caption = 'Code';
            DataClassification = SystemMetadata;
            ToolTip = 'Specifies the unique code of the hostel.';
        }
        field(2; Name; Text[100])
        {
            Caption = 'Name';
            DataClassification = CustomerContent;
            ToolTip = 'Specifies the name of the hostel.';
        }
        field(3; Address; Text[150])
        {
            Caption = 'Address';
            DataClassification = CustomerContent;
            ToolTip = 'Specifies the address of the hostel.';
        }
        field(4; City; Text[30])
        {
            Caption = 'City';
            DataClassification = CustomerContent;
            ToolTip = 'Specifies the city where the hostel is located.';
        }
        field(5; "No. of Floors"; Integer)
        {
            Caption = 'No. of Floors';
            DataClassification = CustomerContent;
            ToolTip = 'Specifies the total number of floors in the hostel.';
        }
        field(6; "Total Rooms"; Integer)
        {
            Caption = 'Total Rooms';
            DataClassification = CustomerContent;
            ToolTip = 'Specifies the total number of rooms available in the hostel.';
        }
        field(7; "No. of Accomodation"; Decimal)
        {
            Caption = 'No. of Accomodation';
            DataClassification = CustomerContent;
            ToolTip = 'Specifies the total accommodation capacity of the hostel.';
        }
        field(8; "No. of Occupied"; Integer)
        {
            Caption = 'No. of Occupied';
            DataClassification = CustomerContent;
            ToolTip = 'Specifies the number of currently occupied rooms or beds.';
        }
        field(9; Mess; Code[20])
        {
            Caption = 'Mess';
            DataClassification = CustomerContent;
            ToolTip = 'Specifies the mess facility code associated with the hostel.';
        }
        field(10; "Per Day Amount"; Decimal)
        {
            Caption = 'Per Day Amount';
            DataClassification = CustomerContent;
            ToolTip = 'Specifies the per day accommodation or mess charge.';
        }
        field(11; "Academic Year"; Code[10])
        {
            Caption = 'Academic Year';
            DataClassification = CustomerContent;
            ToolTip = 'Specifies the academic year applicable to the hostel record.';
        }
        field(12; "Total No. Of Students"; Integer)
        {
            Caption = 'Total No. Of Students';
            DataClassification = CustomerContent;
            ToolTip = 'Specifies the total number of students staying in the hostel.';
        }
        field(13; Company; Option)
        {
            Caption = 'Company';
            OptionMembers = " ",MontFord,WestBrook;
            OptionCaption = ' ,MontFord,WestBrook';
            DataClassification = OrganizationIdentifiableInformation;
            ToolTip = 'Specifies the company associated with the hostel.';
        }
        field(14; "Alloted Nos Of Bed"; Integer)
        {
            Caption = 'Alloted Nos Of Bed';
            DataClassification = CustomerContent;
            ToolTip = 'Specifies the total number of allotted beds.';
        }
        field(15; Warden; Code[20])
        {
            Caption = 'Warden';
            DataClassification = EndUserIdentifiableInformation;
            ToolTip = 'Specifies the code of the hostel warden.';
        }
        field(16; Matron1; Text[75])
        {
            Caption = 'Matron1';
            DataClassification = EndUserIdentifiableInformation;
            ToolTip = 'Specifies the name of the first matron.';
        }
        field(17; Matorn2; Text[75])
        {
            Caption = 'Matorn2';
            DataClassification = EndUserIdentifiableInformation;
            ToolTip = 'Specifies the name of the second matron.';
        }
        field(18; "Dorm Assistant1"; Text[75])
        {
            Caption = 'Dorm Assistant1';
            DataClassification = EndUserIdentifiableInformation;
            ToolTip = 'Specifies the name of the first dorm assistant.';
        }
        field(19; "Dorm Assistant2"; Text[75])
        {
            Caption = 'Dorm Assistant2';
            DataClassification = EndUserIdentifiableInformation;
            ToolTip = 'Specifies the name of the second dorm assistant.';
        }
        field(20; "Dorm Assistant3"; Text[75])
        {
            Caption = 'Dorm Assistant3';
            DataClassification = EndUserIdentifiableInformation;
            ToolTip = 'Specifies the name of the third dorm assistant.';
        }
        field(21; Campus; Option)
        {
            Caption = 'Campus';
            OptionMembers = " ",Main,City;
            OptionCaption = ' ,Main,City';
            DataClassification = CustomerContent;
            ToolTip = 'Specifies the campus to which the hostel belongs.';
        }
        field(22; "Dorm Mistress/Master"; Text[75])
        {
            Caption = 'Dorm Mistress/Master';
            DataClassification = EndUserIdentifiableInformation;
            ToolTip = 'Specifies the dorm mistress or master.';
        }
        field(23; Matron3; Text[75])
        {
            Caption = 'Matron3';
            DataClassification = EndUserIdentifiableInformation;
            ToolTip = 'Specifies the name of the third matron.';
        }
        field(70121; "Portal ID"; Code[20])
        {
            Caption = 'Portal ID';
            DataClassification = CustomerContent;
            ToolTip = 'Specifies the portal ID associated with this hostel record.';
        }
    }

    keys
    {
        key(Key1; Code)
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}
