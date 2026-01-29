table 72052 "Location HR & Payroll Setup"
{
    // -----------------------------------------------------------------------------------------------
    // Firstware Sofware Solutions : Project Name : HR & PAYROLL
    // -----------------------------------------------------------------------------------------------
    // No.  Date          Developer     Spec/CU/CR      Description
    // -----------------------------------------------------------------------------------------------
    // 1    04.APR.2009   RAJAH.A                       New Tables Added for Payroll Module.

    Caption = 'Location HR & Payroll Setup';
    DataCaptionFields = "Location Code", "Location Name";
    DrillDownPageID = 72063;
    LookupPageID = 72063;

    fields
    {
        field(2; "Location Code"; Code[20])
        {
            Caption = 'Location Code';
        }
        field(3; "Location Name"; Text[50])
        {
            Caption = 'Location Name';
        }
        field(4; "Salary Plan Code"; Code[20])
        {
            Caption = 'Salary Plan Code';
            TableRelation = "Salary Plan";
        }
        field(5; "Salary Cyclic Code"; Code[20])
        {
            Caption = 'Salary Cyclic Code';
            TableRelation = "Payroll Month & Year";
        }
        field(6; "Salary Date Interval"; DateFormula)
        {
            Caption = 'Salary Date Interval';
        }
        field(7; "Salary Start Date"; Date)
        {
            Caption = 'Salary Start Date';
            Editable = false;
        }
        field(8; "Salary End Date"; Date)
        {
            Caption = 'Salary End Date';
            Editable = false;
        }
        field(9; "Processing Payroll Date"; Date)
        {
            Caption = 'Processing Payroll Date';
        }
        field(10; "Current Salary Process Month"; Integer)
        {
            Caption = 'Current Salary Process Month';
            MaxValue = 12;
            MinValue = 0;
        }
        field(11; "Current Salary Process Year"; Integer)
        {
            Caption = 'Current Salary Process Year';
            MaxValue = 9999;
            MinValue = 1900;
        }
        field(12; "Last Posted Month"; Integer)
        {
            Caption = 'Last Posted Month';
            MaxValue = 12;
            MinValue = 0;
        }
        field(13; "Last Posted Year"; Integer)
        {
            Caption = 'Last Posted Year';
            MaxValue = 9999;
            MinValue = 1900;
        }
        field(14; "Default Attendance Type"; Option)
        {
            Caption = 'Default Attendance Type';
            OptionCaption = ' ,Present,Absent';
            OptionMembers = " ",Present,Absent;
        }
        field(15; "No of Hours Per Day"; Decimal)
        {
            Caption = 'No of Hours Per Day';
            MaxValue = 12;
            MinValue = 0;
        }
        field(16; "No of Hours in Half Day"; Decimal)
        {
            Caption = 'No of Hours in Half Day';
            MaxValue = 6;
            MinValue = 0;
        }
        field(17; "Over Time Applicable"; Boolean)
        {
            Caption = 'Over Time Applicable';
        }
        field(18; "Over Time Approval Check"; Boolean)
        {
            Caption = 'Over Time Approval Check';
        }
        field(19; "Over Time Min Minutes"; Decimal)
        {
            Caption = 'Over Time Min Minutes';
        }
        field(20; "Over Time Max Minutes"; Decimal)
        {
            Caption = 'Over Time Max Minutes';
        }
        field(21; "Over Time Multiplier"; Decimal)
        {
            Caption = 'Over Time Multiplier';
            MaxValue = 5;
            MinValue = 0;
        }
        field(22; "Bonus Applicable"; Boolean)
        {
            Caption = 'Bonus Applicable';
        }
        field(23; "Bonus Declare Date"; Date)
        {
            Caption = 'Bonus Declare Date';
        }
        field(24; "Bonus Min. No of Years"; Integer)
        {
            Caption = 'Bonus Min. No of Years';
        }
        field(25; "Bonus Max No of Years"; Integer)
        {
            Caption = 'Bonus Max No of Years';
        }
        field(26; "Bonusable Earning Min Limit"; Decimal)
        {
            Caption = 'Bonusable Earning Min Limit';
        }
        field(27; "Bonusable Earning Max Limit"; Decimal)
        {
            Caption = 'Bonusable Earning Max Limit';
        }
        field(28; "Bonus (%)"; Decimal)
        {
            Caption = 'Bonus (%)';
            MaxValue = 100;
            MinValue = 0;
        }
        field(29; "Ex-Gratia (%)"; Decimal)
        {
            Caption = 'Ex-Gratia (%)';
            MaxValue = 100;
            MinValue = 0;
        }
        field(30; "Gratuity Applicable"; Boolean)
        {
            Caption = 'Gratuity Applicable';
        }
        field(31; "Gratuity Min. No of Years"; Integer)
        {
            Caption = 'Gratuity Min. No of Years';
        }
        field(32; "Gratuity Max. No of Years"; Integer)
        {
            Caption = 'Gratuity Max. No of Years';
        }
        field(33; "Gratuity No. of Days Salary"; Integer)
        {
            Caption = 'Gratuity No. of Days Salary';
            MaxValue = 31;
            MinValue = 0;
        }
        field(34; "Gratuity No. of Days in Month"; Integer)
        {
            Caption = 'Gratuity No. of Days in Month';
            MaxValue = 31;
            MinValue = 0;
        }
        field(35; "ESI to All"; Boolean)
        {
            Caption = 'ESI to All';
        }
        field(36; "PF to All"; Boolean)
        {
            Caption = 'PF to All';
        }
        field(37; "EPS to All"; Boolean)
        {
            Caption = 'EPS to All';
        }
        field(38; "VPF to All"; Boolean)
        {
            Caption = 'VPF to All';
        }
        field(39; "PT to All"; Boolean)
        {
            Caption = 'PT to All';
        }
        field(40; "LWF to All"; Boolean)
        {
            Caption = 'LWF to All';
        }
        field(41; "Leave Encashment to All"; Boolean)
        {
            Caption = 'Leave Encashment to All';
        }
        field(42; "General Rounding Amount"; Decimal)
        {
            Caption = 'General Rounding Amount';
        }
        field(43; "General Rounding Type"; Option)
        {
            Caption = 'General Rounding Type';
            OptionCaption = 'Nearest,Up,Down';
            OptionMembers = Nearest,Up,Down;
        }
        field(44; "Net Salary Rounding Amount"; Decimal)
        {
            Caption = 'Net Salary Rounding Amount';
        }
        field(45; "Net Salary Rounding Type"; Option)
        {
            Caption = 'Net Salary Rounding Type';
            OptionCaption = 'Nearest,Up,Down';
            OptionMembers = Nearest,Up,Down;
        }
        field(46; "VDA Rate"; Decimal)
        {
            Caption = 'VDA Rate';
        }
        field(47; "FDA Amount"; Decimal)
        {
            Caption = 'FDA Amount';
        }
        field(48; "Employee No."; Code[20])
        {
            Caption = 'Employee No.';
            TableRelation = "No. Series";
        }
        field(49; "Loan No."; Code[20])
        {
            Caption = 'Loan No.';
            TableRelation = "No. Series";
        }
        field(50; "Pay Revision No."; Code[20])
        {
            Caption = 'Pay Revision No.';
            TableRelation = "No. Series";
        }
        field(51; "Pay Arrear No."; Code[20])
        {
            Caption = 'Pay Arrear No.';
            TableRelation = "No. Series";
        }
        field(52; "Employer PF GL Code"; Code[20])
        {
            Caption = 'Employer PF GL Code';
            TableRelation = "G/L Account";
        }
        field(53; "Employer EPS GL Code"; Code[20])
        {
            Caption = 'Employer EPS GL Code';
            TableRelation = "G/L Account";
        }
        field(54; "PF Admin Charges GL Code"; Code[20])
        {
            Caption = 'PF Admin Charges GL Code';
            TableRelation = "G/L Account";
        }
        field(55; "EDLI Charges GLCode"; Code[20])
        {
            Caption = 'EDLI Charges GLCode';
            TableRelation = "G/L Account";
        }
        field(56; "RIFA Charges GL Code"; Code[20])
        {
            Caption = 'RIFA Charges GL Code';
            TableRelation = "G/L Account";
        }
        field(57; "Employer ESI GL Code"; Code[20])
        {
            Caption = 'Employer ESI GL Code';
            TableRelation = "G/L Account";
        }
        field(58; "LWF GL Code"; Code[20])
        {
            Caption = 'LWF GL Code';
            TableRelation = "G/L Account";
        }
        field(59; "Cash Account GL Code"; Code[20])
        {
            Caption = 'Cash Account GL Code';
            TableRelation = "G/L Account";
        }
        field(60; "Bank Account GL Code"; Code[20])
        {
            Caption = 'Bank Account GL Code';
            TableRelation = "Bank Account";
        }
        field(61; "Year Code"; Code[20])
        {
            Caption = 'Year Code';
        }
        field(62; "Bonus No."; Code[20])
        {
            Caption = 'Bonus No.';
            TableRelation = "No. Series";
        }
        field(63; "Leave No."; Code[20])
        {
            Caption = 'Leave No.';
            TableRelation = "No. Series";
        }
        field(64; "Minimum Attendance Credit Days"; Integer)
        {
            Caption = 'Minimum Attendance Credit Days';
            MaxValue = 31;
            MinValue = 0;
        }
        field(65; "Eligible Days for Credit Days"; Integer)
        {
            Caption = 'Eligible Days for Credit Days';
            MaxValue = 31;
            MinValue = 0;
        }
        field(66; "Attendance Bonus (%)"; Integer)
        {
            Caption = 'Attendance Bonus (%)';
            MaxValue = 100;
            MinValue = 0;
        }
        field(67; "Atte. Bonus Permission Limit"; Decimal)
        {
            Caption = 'Atte. Bonus Permission Limit';
        }
        field(68; "Piece Rate No."; Code[20])
        {
            Caption = 'Piece Rate No.';
            TableRelation = "No. Series";
        }
        field(69; "Employee Gate Pass No"; Code[20])
        {
            Caption = 'Employee Gate Pass No';
            TableRelation = "No. Series";
        }
        field(70; Name; Text[50])
        {
            Caption = 'Name';
        }
        field(71; "Name 2"; Text[50])
        {
            Caption = 'Name 2';
        }
        field(72; Address; Text[50])
        {
            Caption = 'Address';
        }
        field(73; "Address 2"; Text[50])
        {
            Caption = 'Address 2';
        }
        field(74; City; Text[30])
        {
            Caption = 'City';
        }
        field(75; "Pin Code"; Text[30])
        {
            Caption = 'Pin Code';
        }
        field(76; "Phone No."; Text[30])
        {
            Caption = 'Phone No.';
        }
        field(77; "Telex No."; Text[30])
        {
            Caption = 'Telex No.';
        }
        field(78; "Fax No."; Text[30])
        {
            Caption = 'Fax No.';
        }
        field(79; "Database Type"; Option)
        {
            Caption = 'Database';
            OptionCaption = ' ,Sql Server 2005,Access Database,Fox Pro';
            OptionMembers = " ","Sql Server 2005","Access Database","Fox Pro";

            trigger OnValidate()
            begin
                Provider := '';
                "Presist Security Info" := '';
                "User ID" := '';
                Password := '';
                "Initial Catalog" := '';
                "Data Source" := '';
                "Extended Properties" := '';

                if "Database Type" = "Database Type"::"Sql Server 2005" then begin
                    Provider := 'SQLOLEDB.1';
                    "Presist Security Info" := 'False';
                    "User ID" := 'DB User Id';
                    Password := 'DB Password';
                    "Initial Catalog" := 'Database Name';
                    "Data Source" := 'Database Server Name';
                end;

                if "Database Type" = "Database Type"::"Access Database" then begin
                    Provider := 'Microsoft.Jet.OLEDB.4.0';
                    "Presist Security Info" := 'False';
                    "Data Source" := 'C:\PATHNAME\FILENAME.MDB';
                end;

                if "Database Type" = "Database Type"::"Fox Pro" then begin
                    Provider := 'Microsoft.Jet.OLEDB.4.0';
                    "Presist Security Info" := 'False';
                    "Data Source" := 'C:\PATHNAME\FILENAME.DBF';
                    "Extended Properties" := 'DBASE III';
                end;
                Connect;
            end;
        }
        field(80; Provider; Text[50])
        {
            Caption = 'Provider';

            trigger OnValidate()
            begin
                Connect;
            end;
        }
        field(81; "Presist Security Info"; Text[10])
        {
            Caption = 'Presist Security Info';

            trigger OnValidate()
            begin
                Connect;
            end;
        }
        field(82; "User ID"; Text[20])
        {
            Caption = 'User ID';

            trigger OnValidate()
            begin
                Connect;
            end;
        }
        field(83; Password; Text[20])
        {
            Caption = 'Password';

            trigger OnValidate()
            begin
                Connect;
            end;
        }
        field(84; "Initial Catalog"; Text[20])
        {
            Caption = 'Initial Catalog';

            trigger OnValidate()
            begin
                Connect;
            end;
        }
        field(85; "Data Source"; Text[50])
        {
            Caption = 'Data Source';

            trigger OnValidate()
            begin
                Connect;
            end;
        }
        field(86; "Extended Properties"; Text[20])
        {
            Caption = 'Extended Properties';

            trigger OnValidate()
            begin
                Connect;
            end;
        }
        field(87; "Connection String"; Text[250])
        {
            Caption = 'Connection String';
        }
        field(88; "Hourly Rate No."; Code[20])
        {
            Caption = 'Hourly Rate No.';
            TableRelation = "No. Series";
        }
        field(89; "Table Name"; Text[30])
        {
            Caption = 'Table Name';
        }
        field(90; "Late Coming Permission Limit"; Decimal)
        {
            Caption = 'Late Coming Permission Limit';
        }
        field(91; "Early Going Permission Limit"; Decimal)
        {
            Caption = 'Early Going Permission Limit';
        }
        field(92; "Weekly Off Full Days Limit"; Decimal)
        {
            Caption = 'Weekly Off Full Days Limit';
        }
        field(94; "Absent Hours Limit"; Decimal)
        {
            Caption = 'Absent Hours Limit';
        }
        field(95; "Weekly Off Half Days Limit"; Decimal)
        {
            Caption = 'Weekly Off Half Days Limit';
        }
        field(96; "Extra Wages Min Hours"; Decimal)
        {
            Caption = 'Extra Wages Min Hours';
        }
        field(97; "Extra Wages Max Hours"; Decimal)
        {
            Caption = 'Extra Wages Max Hours';
        }
        field(98; "Ex.Wages Days Min 3 To 6 Hours"; Decimal)
        {
            Caption = 'Ex.Wages Days Min 3 To 6 Hours';
        }
        field(99; "Ex.Wages Days 6 Hours Above"; Decimal)
        {
            Caption = 'Ex.Wages Days 6 Hours Above';
        }
        field(100; "PF Establishment No"; Code[50])
        {
            Caption = 'PF Establishment No';
        }
        field(101; "ESI Establishment No"; Code[50])
        {
            Caption = 'ESI Establishment No';
        }
        field(102; "Factory Establishment No"; Code[50])
        {
            Caption = 'Factory Establishment No';
        }
        field(103; "Over Time Hours Round Off"; Boolean)
        {
            Caption = 'Over Time Hours Round Off';
        }
        field(104; "Location Pictures"; BLOB)
        {
            Caption = 'Location Pictures';
        }
        field(105; "PF Pictures"; BLOB)
        {
            Caption = 'PF Pictures';
        }
        field(106; "ESI Pictures"; BLOB)
        {
            Caption = 'ESI Pictures';
        }
        field(107; "Total No Pieces Per Day"; Decimal)
        {
            Caption = 'Total No Pieces Per Day';
        }
        field(108; "Worker Base Calc. Not Required"; Boolean)
        {
            Caption = 'Worker Base Calc. Not Required';
        }
    }

    keys
    {
        key(Key1; "Location Code")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    var
        Quote: Char;
        Quote1: Text[1];

    [Scope('Internal')]
    procedure Connect()
    begin
        Quote := 39;
        Quote1 := Format(Quote);
        if "Database Type" = "Database Type"::"Sql Server 2005" then
            "Connection String" := Quote1 + 'Provider=' + Provider + ';' +
            'Presist Security Info=' + "Presist Security Info" + ';' +
            'User ID=' + "User ID" + ';' +
            'Password=' + Password + ';' +
            'Initial Catalog=' + "Initial Catalog" + ';' +
            'Data Source=' + "Data Source" + Quote1;

        if "Database Type" = "Database Type"::"Access Database" then
            "Connection String" := 'Provider=' + Provider + ';' +
            //'Data Source=' + "Data Source" + ';' +
            'Presist Security Info=' + "Presist Security Info";

        if "Database Type" = "Database Type"::"Fox Pro" then
            "Connection String" := Quote1 + 'Provider=' + Provider + ';' +
            'Presist Security Info=' + "Presist Security Info" + ';' +
            'Data Source=' + "Data Source" + ';' +
            'Extended Properties=' + "Extended Properties" + Quote1;
    end;
}

