table 72052 "Location HR & Payroll Setup"
{
    Caption = 'Location HR & Payroll Setup';
    DataCaptionFields = "Location Code", "Location Name";
    DataClassification = CustomerContent;
    // DrillDownPageID = 72063;
    // LookupPageID = 72063;

    fields
    {
        field(2; "Location Code"; Code[20])
        {
            Caption = 'Location Code';
            ToolTip = 'Specifies the unique code for the location.';
            DataClassification = CustomerContent;
        }
        field(3; "Location Name"; Text[50])
        {
            Caption = 'Location Name';
            ToolTip = 'Specifies the name of the location.';
            DataClassification = CustomerContent;
        }
        field(4; "Salary Plan Code"; Code[20])
        {
            Caption = 'Salary Plan Code';
            ToolTip = 'Specifies the salary plan used for this location.';
            TableRelation = "Salary Plan";
            DataClassification = CustomerContent;
        }
        field(5; "Salary Cyclic Code"; Code[20])
        {
            Caption = 'Salary Cyclic Code';
            ToolTip = 'Specifies the payroll cycle for salary processing.';
            TableRelation = "Payroll Month & Year";
            DataClassification = CustomerContent;
        }
        field(6; "Salary Date Interval"; DateFormula)
        {
            Caption = 'Salary Date Interval';
            ToolTip = 'Specifies the interval used to calculate salary dates.';
            DataClassification = CustomerContent;
        }
        field(7; "Salary Start Date"; Date)
        {
            Caption = 'Salary Start Date';
            ToolTip = 'Specifies the start date of the salary period.';
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(8; "Salary End Date"; Date)
        {
            Caption = 'Salary End Date';
            ToolTip = 'Specifies the end date of the salary period.';
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(9; "Processing Payroll Date"; Date)
        {
            Caption = 'Processing Payroll Date';
            ToolTip = 'Specifies the date on which payroll is processed.';
            DataClassification = CustomerContent;
        }
        field(10; "Current Salary Process Month"; Integer)
        {
            Caption = 'Current Salary Process Month';
            ToolTip = 'Specifies the current salary processing month.';
            MaxValue = 12;
            MinValue = 0;
            DataClassification = CustomerContent;
        }
        field(11; "Current Salary Process Year"; Integer)
        {
            Caption = 'Current Salary Process Year';
            ToolTip = 'Specifies the current salary processing year.';
            MaxValue = 9999;
            MinValue = 1900;
            DataClassification = CustomerContent;
        }
        field(12; "Last Posted Month"; Integer)
        {
            Caption = 'Last Posted Month';
            ToolTip = 'Specifies the last posted payroll month.';
            MaxValue = 12;
            MinValue = 0;
            DataClassification = CustomerContent;
        }
        field(13; "Last Posted Year"; Integer)
        {
            Caption = 'Last Posted Year';
            ToolTip = 'Specifies the last posted payroll year.';
            MaxValue = 9999;
            MinValue = 1900;
            DataClassification = CustomerContent;
        }
        field(14; "Default Attendance Type"; Option)
        {
            Caption = 'Default Attendance Type';
            ToolTip = 'Specifies the default attendance status.';
            OptionCaption = ' ,Present,Absent';
            OptionMembers = " ",Present,Absent;
            DataClassification = CustomerContent;
        }
        field(15; "No of Hours Per Day"; Decimal)
        {
            Caption = 'No of Hours Per Day';
            ToolTip = 'Specifies the number of working hours per day.';
            MaxValue = 12;
            MinValue = 0;
            DataClassification = CustomerContent;
        }
        field(16; "No of Hours in Half Day"; Decimal)
        {
            Caption = 'No of Hours in Half Day';
            ToolTip = 'Specifies the number of working hours in a half day.';
            MaxValue = 6;
            MinValue = 0;
            DataClassification = CustomerContent;
        }
        field(17; "Over Time Applicable"; Boolean)
        {
            Caption = 'Over Time Applicable';
            ToolTip = 'Specifies whether overtime is applicable.';
            DataClassification = CustomerContent;
        }
        field(18; "Over Time Approval Check"; Boolean)
        {
            Caption = 'Over Time Approval Check';
            ToolTip = 'Specifies whether overtime requires approval.';
            DataClassification = CustomerContent;
        }
        field(19; "Over Time Min Minutes"; Decimal)
        {
            Caption = 'Over Time Min Minutes';
            ToolTip = 'Specifies the minimum overtime minutes.';
            DataClassification = CustomerContent;
        }
        field(20; "Over Time Max Minutes"; Decimal)
        {
            Caption = 'Over Time Max Minutes';
            ToolTip = 'Specifies the maximum overtime minutes.';
            DataClassification = CustomerContent;
        }
        field(21; "Over Time Multiplier"; Decimal)
        {
            Caption = 'Over Time Multiplier';
            ToolTip = 'Specifies the overtime calculation multiplier.';
            MaxValue = 5;
            MinValue = 0;
            DataClassification = CustomerContent;
        }
        field(22; "Bonus Applicable"; Boolean)
        {
            Caption = 'Bonus Applicable';
            DataClassification = CustomerContent;
        }

        field(23; "Bonus Declare Date"; Date)
        {
            Caption = 'Bonus Declare Date';
            DataClassification = CustomerContent;
        }

        field(24; "Bonus Min. No of Years"; Integer)
        {
            Caption = 'Bonus Min. No of Years';
            DataClassification = CustomerContent;
        }

        field(25; "Bonus Max No of Years"; Integer)
        {
            Caption = 'Bonus Max No of Years';
            DataClassification = CustomerContent;
        }
        field(26; "Bonusable Earning Min Limit"; Decimal)
        {
            Caption = 'Bonusable Earning Min Limit';
            DataClassification = CustomerContent;
        }

        field(27; "Bonusable Earning Max Limit"; Decimal)
        {
            Caption = 'Bonusable Earning Max Limit';
            DataClassification = CustomerContent;
        }

        field(28; "Bonus (%)"; Decimal)
        {
            Caption = 'Bonus (%)';
            MinValue = 0;
            MaxValue = 100;
            DataClassification = CustomerContent;
        }

        field(29; "Ex-Gratia (%)"; Decimal)
        {
            Caption = 'Ex-Gratia (%)';
            MinValue = 0;
            MaxValue = 100;
            DataClassification = CustomerContent;
        }

        field(30; "Gratuity Applicable"; Boolean)
        {
            Caption = 'Gratuity Applicable';
            DataClassification = CustomerContent;
        }

        field(31; "Gratuity Min. No of Years"; Integer)
        {
            Caption = 'Gratuity Min. No of Years';
            DataClassification = CustomerContent;
        }

        field(32; "Gratuity Max. No of Years"; Integer)
        {
            Caption = 'Gratuity Max. No of Years';
            DataClassification = CustomerContent;
        }

        field(33; "Gratuity No. of Days Salary"; Integer)
        {
            Caption = 'Gratuity No. of Days Salary';
            MinValue = 0;
            MaxValue = 31;
            DataClassification = CustomerContent;
        }

        field(34; "Gratuity No. of Days in Month"; Integer)
        {
            Caption = 'Gratuity No. of Days in Month';
            MinValue = 0;
            MaxValue = 31;
            DataClassification = CustomerContent;
        }

        field(35; "ESI to All"; Boolean)
        {
            Caption = 'ESI to All';
            DataClassification = CustomerContent;
        }

        field(36; "PF to All"; Boolean)
        {
            Caption = 'PF to All';
            DataClassification = CustomerContent;
        }

        field(37; "EPS to All"; Boolean)
        {
            Caption = 'EPS to All';
            DataClassification = CustomerContent;
        }

        field(38; "VPF to All"; Boolean)
        {
            Caption = 'VPF to All';
            DataClassification = CustomerContent;
        }

        field(39; "PT to All"; Boolean)
        {
            Caption = 'PT to All';
            DataClassification = CustomerContent;
        }

        field(40; "LWF to All"; Boolean)
        {
            Caption = 'LWF to All';
            DataClassification = CustomerContent;
        }
        field(41; "Leave Encashment to All"; Boolean)
        {
            Caption = 'Leave Encashment to All';
            DataClassification = CustomerContent;
        }

        field(42; "General Rounding Amount"; Decimal)
        {
            Caption = 'General Rounding Amount';
            DataClassification = CustomerContent;
        }

        field(43; "General Rounding Type"; Option)
        {
            Caption = 'General Rounding Type';
            OptionMembers = Nearest,Up,Down;
            OptionCaption = 'Nearest,Up,Down';
            DataClassification = CustomerContent;
        }

        field(44; "Net Salary Rounding Amount"; Decimal)
        {
            Caption = 'Net Salary Rounding Amount';
            DataClassification = CustomerContent;
        }

        field(45; "Net Salary Rounding Type"; Option)
        {
            Caption = 'Net Salary Rounding Type';
            OptionMembers = Nearest,Up,Down;
            OptionCaption = 'Nearest,Up,Down';
            DataClassification = CustomerContent;
        }
        field(46; "VDA Rate"; Decimal)
        {
            Caption = 'VDA Rate';
            DataClassification = CustomerContent;
        }

        field(47; "FDA Amount"; Decimal)
        {
            Caption = 'FDA Amount';
            DataClassification = CustomerContent;
        }

        field(48; "Employee No."; Code[20])
        {
            Caption = 'Employee No.';
            TableRelation = "No. Series";
            DataClassification = CustomerContent;
        }

        field(49; "Loan No."; Code[20])
        {
            Caption = 'Loan No.';
            TableRelation = "No. Series";
            DataClassification = CustomerContent;
        }

        field(50; "Pay Revision No."; Code[20])
        {
            Caption = 'Pay Revision No.';
            TableRelation = "No. Series";
            DataClassification = CustomerContent;
        }
        field(51; "Pay Arrear No."; Code[20])
        {
            Caption = 'Pay Arrear No.';
            TableRelation = "No. Series";
            DataClassification = CustomerContent;
        }

        field(52; "Employer PF GL Code"; Code[20])
        {
            Caption = 'Employer PF GL Code';
            TableRelation = "G/L Account";
            DataClassification = CustomerContent;
        }

        field(53; "Employer EPS GL Code"; Code[20])
        {
            Caption = 'Employer EPS GL Code';
            TableRelation = "G/L Account";
            DataClassification = CustomerContent;
        }

        field(54; "PF Admin Charges GL Code"; Code[20])
        {
            Caption = 'PF Admin Charges GL Code';
            TableRelation = "G/L Account";
            DataClassification = CustomerContent;
        }

        field(55; "EDLI Charges GLCode"; Code[20])
        {
            Caption = 'EDLI Charges GLCode';
            TableRelation = "G/L Account";
            DataClassification = CustomerContent;
        }
        field(56; "RIFA Charges GL Code"; Code[20])
        {
            Caption = 'RIFA Charges GL Code';
            TableRelation = "G/L Account";
            DataClassification = CustomerContent;
        }

        field(57; "Employer ESI GL Code"; Code[20])
        {
            Caption = 'Employer ESI GL Code';
            TableRelation = "G/L Account";
            DataClassification = CustomerContent;
        }

        field(58; "LWF GL Code"; Code[20])
        {
            Caption = 'LWF GL Code';
            TableRelation = "G/L Account";
            DataClassification = CustomerContent;
        }

        field(59; "Cash Account GL Code"; Code[20])
        {
            Caption = 'Cash Account GL Code';
            TableRelation = "G/L Account";
            DataClassification = CustomerContent;
        }

        field(60; "Bank Account GL Code"; Code[20])
        {
            Caption = 'Bank Account GL Code';
            TableRelation = "Bank Account";
            DataClassification = CustomerContent;
        }

        field(61; "Year Code"; Code[20])
        {
            Caption = 'Year Code';
            DataClassification = CustomerContent;
        }

        field(62; "Bonus No."; Code[20])
        {
            Caption = 'Bonus No.';
            TableRelation = "No. Series";
            DataClassification = CustomerContent;
        }

        field(63; "Leave No."; Code[20])
        {
            Caption = 'Leave No.';
            TableRelation = "No. Series";
            DataClassification = CustomerContent;
        }

        field(64; "Minimum Attendance Credit Days"; Integer)
        {
            Caption = 'Minimum Attendance Credit Days';
            MinValue = 0;
            MaxValue = 31;
            DataClassification = CustomerContent;
        }

        field(65; "Eligible Days for Credit Days"; Integer)
        {
            Caption = 'Eligible Days for Credit Days';
            MinValue = 0;
            MaxValue = 31;
            DataClassification = CustomerContent;
        }
        field(66; "Attendance Bonus (%)"; Integer)
        {
            Caption = 'Attendance Bonus (%)';
            MinValue = 0;
            MaxValue = 100;
            DataClassification = CustomerContent;
        }

        field(67; "Atte. Bonus Permission Limit"; Decimal)
        {
            Caption = 'Atte. Bonus Permission Limit';
            DataClassification = CustomerContent;
        }

        field(68; "Piece Rate No."; Code[20])
        {
            Caption = 'Piece Rate No.';
            TableRelation = "No. Series";
            DataClassification = CustomerContent;
        }

        field(69; "Employee Gate Pass No"; Code[20])
        {
            Caption = 'Employee Gate Pass No';
            TableRelation = "No. Series";
            DataClassification = CustomerContent;
        }

        field(70; Name; Text[50])
        {
            Caption = 'Name';
            DataClassification = CustomerContent;
        }
        field(71; "Name 2"; Text[50])
        {
            Caption = 'Name 2';
            DataClassification = CustomerContent;
        }

        field(72; Address; Text[50])
        {
            Caption = 'Address';
            DataClassification = CustomerContent;
        }

        field(73; "Address 2"; Text[50])
        {
            Caption = 'Address 2';
            DataClassification = CustomerContent;
        }

        field(74; City; Text[30])
        {
            Caption = 'City';
            DataClassification = CustomerContent;
        }

        field(75; "Pin Code"; Text[30])
        {
            Caption = 'Pin Code';
            DataClassification = CustomerContent;
        }
        field(76; "Phone No."; Text[30])
        {
            Caption = 'Phone No.';
            DataClassification = CustomerContent;
        }

        field(77; "Telex No."; Text[30])
        {
            Caption = 'Telex No.';
            DataClassification = CustomerContent;
        }

        field(78; "Fax No."; Text[30])
        {
            Caption = 'Fax No.';
            DataClassification = CustomerContent;
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
                Connect();
            end;
        }
        field(80; Provider; Text[50])
        {
            Caption = 'Provider';
            ToolTip = 'Specifies the database provider.';
            DataClassification = SystemMetadata;

            trigger OnValidate()
            begin
                Connect();
            end;
        }
        field(81; "Presist Security Info"; Text[10])
        {
            Caption = 'Presist Security Info';
            ToolTip = 'Specifies whether security information is persisted.';
            DataClassification = SystemMetadata;

            trigger OnValidate()
            begin
                Connect();
            end;
        }
        field(82; "User ID"; Text[20])
        {
            Caption = 'User ID';
            ToolTip = 'Specifies the database user ID.';

            trigger OnValidate()
            begin
                Connect();
            end;
        }
        field(83; Password; Text[20])
        {
            Caption = 'Password';
            ToolTip = 'Specifies the database password.';


            trigger OnValidate()
            begin
                Connect();
            end;
        }
        field(84; "Initial Catalog"; Text[20])
        {
            Caption = 'Initial Catalog';
            ToolTip = 'Specifies the database name.';
            DataClassification = SystemMetadata;

            trigger OnValidate()
            begin
                Connect();
            end;
        }
        field(85; "Data Source"; Text[50])
        {
            Caption = 'Data Source';
            ToolTip = 'Specifies the database server or file path.';
            DataClassification = SystemMetadata;

            trigger OnValidate()
            begin
                Connect();
            end;
        }
        field(86; "Extended Properties"; Text[20])
        {
            Caption = 'Extended Properties';
            ToolTip = 'Specifies additional database properties.';
            DataClassification = SystemMetadata;

            trigger OnValidate()
            begin
                Connect();
            end;
        }
        field(87; "Connection String"; Text[1024])
        {
            Caption = 'Connection String';
            ToolTip = 'Specifies the generated connection string used to connect to the external database.';

        }
        field(88; "Hourly Rate No."; Code[20])
        {
            Caption = 'Hourly Rate No.';
            ToolTip = 'Specifies the number series used for hourly rate calculations.';
            TableRelation = "No. Series";
            DataClassification = CustomerContent;
        }
        field(89; "Table Name"; Text[30])
        {
            Caption = 'Table Name';
            ToolTip = 'Specifies the external table name used for integration.';
            DataClassification = SystemMetadata;
        }
        field(90; "Late Coming Permission Limit"; Decimal)
        {
            Caption = 'Late Coming Permission Limit';
            ToolTip = 'Specifies the allowed late coming limit for employees.';
            DataClassification = CustomerContent;
        }
        field(91; "Early Going Permission Limit"; Decimal)
        {
            Caption = 'Early Going Permission Limit';
            ToolTip = 'Specifies the allowed early leaving limit for employees.';
            DataClassification = CustomerContent;
        }
        field(92; "Weekly Off Full Days Limit"; Decimal)
        {
            Caption = 'Weekly Off Full Days Limit';
            ToolTip = 'Specifies the limit for weekly off full days.';
            DataClassification = CustomerContent;
        }
        field(94; "Absent Hours Limit"; Decimal)
        {
            Caption = 'Absent Hours Limit';
            ToolTip = 'Specifies the maximum allowed absent hours.';
            DataClassification = CustomerContent;
        }
        field(95; "Weekly Off Half Days Limit"; Decimal)
        {
            Caption = 'Weekly Off Half Days Limit';
            ToolTip = 'Specifies the limit for weekly off half days.';
            DataClassification = CustomerContent;
        }
        field(96; "Extra Wages Min Hours"; Decimal)
        {
            Caption = 'Extra Wages Min Hours';
            ToolTip = 'Specifies the minimum hours required to calculate extra wages.';
            DataClassification = CustomerContent;
        }
        field(97; "Extra Wages Max Hours"; Decimal)
        {
            Caption = 'Extra Wages Max Hours';
            ToolTip = 'Specifies the maximum hours allowed for extra wages.';
            DataClassification = CustomerContent;
        }
        field(98; "Ex.Wages Days Min 3 To 6 Hours"; Decimal)
        {
            Caption = 'Ex. Wages Days Min 3 To 6 Hours';
            ToolTip = 'Specifies extra wage days for work between 3 to 6 hours.';
            DataClassification = CustomerContent;
        }
        field(99; "Ex.Wages Days 6 Hours Above"; Decimal)
        {
            Caption = 'Ex. Wages Days 6 Hours Above';
            ToolTip = 'Specifies extra wage days for work above 6 hours.';
            DataClassification = CustomerContent;
        }
        field(100; "PF Establishment No"; Code[50])
        {
            Caption = 'PF Establishment No.';
            ToolTip = 'Specifies the Provident Fund establishment number.';
            DataClassification = CustomerContent;
        }
        field(101; "ESI Establishment No"; Code[50])
        {
            Caption = 'ESI Establishment No.';
            ToolTip = 'Specifies the Employee State Insurance establishment number.';
            DataClassification = CustomerContent;
        }
        field(102; "Factory Establishment No"; Code[50])
        {
            Caption = 'Factory Establishment No.';
            ToolTip = 'Specifies the factory establishment registration number.';
            DataClassification = CustomerContent;
        }
        field(103; "Over Time Hours Round Off"; Boolean)
        {
            Caption = 'Over Time Hours Round Off';
            ToolTip = 'Specifies whether overtime hours should be rounded off.';
            DataClassification = CustomerContent;
        }
        field(104; "Location Pictures"; BLOB)
        {
            Caption = 'Location Pictures';
            ToolTip = 'Stores pictures related to the location.';
            DataClassification = CustomerContent;
        }
        field(105; "PF Pictures"; BLOB)
        {
            Caption = 'PF Pictures';
            ToolTip = 'Stores PF-related document images.';
            DataClassification = CustomerContent;
        }
        field(106; "ESI Pictures"; BLOB)
        {
            Caption = 'ESI Pictures';
            ToolTip = 'Stores ESI-related document images.';
            DataClassification = CustomerContent;
        }
        field(107; "Total No Pieces Per Day"; Decimal)
        {
            Caption = 'Total No. of Pieces Per Day';
            ToolTip = 'Specifies the total number of pieces expected per day.';
            DataClassification = CustomerContent;
        }
        field(108; "Worker Base Calc. Not Required"; Boolean)
        {
            Caption = 'Worker Base Calc. Not Required';
            ToolTip = 'Specifies whether worker-based calculation is not required.';
            DataClassification = CustomerContent;
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

