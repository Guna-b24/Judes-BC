table 72020 "Candidate Joining"
{
    Caption = 'Candidate Joining';
    DataCaptionFields = "No.", "First Name";
    // DrillDownPageID = 72030;
    // LookupPageID = 72030;

    fields
    {
        field(1; "No."; Code[20])
        {
            Caption = 'No.';
            DataClassification = CustomerContent;
        }
        field(2; "First Name"; Text[30])
        {
            Caption = 'First Name';
            DataClassification = CustomerContent;

            trigger OnValidate()
            begin
                "Search Name" := "First Name";
            end;
        }
        field(3; "Middle Name"; Text[30])
        {
            Caption = 'Middle Name';
            DataClassification = CustomerContent;
        }
        field(4; "Last Name"; Text[30])
        {
            Caption = 'Last Name';
            DataClassification = CustomerContent;
        }
        field(5; Initials; Text[30])
        {
            Caption = 'Initials';
            DataClassification = CustomerContent;

            trigger OnValidate()
            begin
                if ("Search Name" = UpperCase(xRec.Initials)) or ("Search Name" = '') then
                    "Search Name" := Initials;
            end;
        }
        field(6; "Job Title"; Text[30])
        {
            Caption = 'Job Title';
            DataClassification = CustomerContent;

            trigger OnValidate()
            begin
                Designation := "Job Title";
            end;
        }
        field(7; "Search Name"; Code[30])
        {
            Caption = 'Search Name';
            DataClassification = CustomerContent;
        }
        field(8; Address; Text[30])
        {
            Caption = 'Address';
            DataClassification = CustomerContent;
        }
        field(9; "Address 2"; Text[30])
        {
            Caption = 'Address 2';
            DataClassification = CustomerContent;
        }
        field(10; City; Text[30])
        {
            Caption = 'City';
            DataClassification = CustomerContent;

        }
        field(11; "Post Code"; Code[20])
        {
            Caption = 'Post Code';
            DataClassification = CustomerContent;
            TableRelation = "Post Code";
            ValidateTableRelation = false;

        }
        field(12; County; Text[30])
        {
            Caption = 'County';
            DataClassification = CustomerContent;
        }
        field(13; "Phone No."; Text[30])
        {
            Caption = 'Phone No.';
            DataClassification = CustomerContent;
        }
        field(14; "Mobile Phone No."; Text[30])
        {
            Caption = 'Mobile Phone No.';
            DataClassification = CustomerContent;
        }
        field(15; "E-Mail"; Text[80])
        {
            Caption = 'E-Mail';
            DataClassification = CustomerContent;
        }
        field(16; "Alt. Address Code"; Code[10])
        {
            Caption = 'Alt. Address Code';
            DataClassification = CustomerContent;
            TableRelation = "Alternative Address".Code WHERE("Employee No." = FIELD("No."));
        }
        field(17; "Alt. Address Start Date"; Date)
        {
            Caption = 'Alt. Address Start Date';
            DataClassification = CustomerContent;
        }
        field(18; "Alt. Address End Date"; Date)
        {
            Caption = 'Alt. Address End Date';
            DataClassification = CustomerContent;
        }
        field(19; Picture; BLOB)
        {
            Caption = 'Picture';
            DataClassification = CustomerContent;
            SubType = Bitmap;
        }
        field(20; "Birth Date"; Date)
        {
            Caption = 'Birth Date';
            DataClassification = CustomerContent;
        }
        field(21; "Social Security No."; Text[30])
        {
            Caption = 'Social Security No.';
            DataClassification = CustomerContent;
        }
        field(22; "Union Code"; Code[10])
        {
            Caption = 'Union Code';
            DataClassification = CustomerContent;
            TableRelation = Union;
        }
        field(23; "Union Membership No."; Text[30])
        {
            Caption = 'Union Membership No.';
            DataClassification = CustomerContent;
        }
        field(24; Sex; Option)
        {
            Caption = 'Sex';
            DataClassification = CustomerContent;
            OptionCaption = ' ,Female,Male';
            OptionMembers = " ",Female,Male;
        }
        field(25; "Country Code"; Code[10])
        {
            Caption = 'Country Code';
            DataClassification = CustomerContent;
            TableRelation = "Country/Region";
        }
        field(26; "Manager No."; Code[20])
        {
            Caption = 'Manager No.';
            DataClassification = CustomerContent;
            TableRelation = Employee;
        }
        field(27; "Emplymt. Contract Code"; Code[10])
        {
            Caption = 'Emplymt. Contract Code';
            DataClassification = CustomerContent;
            TableRelation = "Employment Contract";
        }
        field(28; "Statistics Group Code"; Code[10])
        {
            Caption = 'Statistics Group Code';
            DataClassification = CustomerContent;
            TableRelation = "Employee Statistics Group";
        }
        field(29; "Employment Date"; Date)
        {
            Caption = 'Employment Date';
            DataClassification = CustomerContent;
        }
        field(31; Status; Option)
        {
            Caption = 'Status';
            DataClassification = CustomerContent;
            OptionCaption = 'Active,Inactive';
            OptionMembers = Active,Inactive;

        }
        field(32; "Inactive Date"; Date)
        {
            Caption = 'Inactive Date';
            DataClassification = CustomerContent;
        }
        field(33; "Cause of Inactivity Code"; Code[10])
        {
            Caption = 'Cause of Inactivity Code';
            DataClassification = CustomerContent;
            TableRelation = "Cause of Inactivity";
        }
        field(34; "Termination Date"; Date)
        {
            Caption = 'Termination Date';
            DataClassification = CustomerContent;
        }
        field(35; "Grounds for Term. Code"; Code[10])
        {
            Caption = 'Grounds for Term. Code';
            DataClassification = CustomerContent;
            TableRelation = "Grounds for Termination";
        }
        field(36; "Global Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,1,1';
            Caption = 'Global Dimension 1 Code';
            DataClassification = CustomerContent;
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1));

        }
        field(37; "Global Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,1,2';
            DataClassification = CustomerContent;
            Caption = 'Global Dimension 2 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2));

        }
        field(38; "Resource No."; Code[20])
        {
            Caption = 'Resource No.';
            DataClassification = CustomerContent;
            TableRelation = Resource WHERE(Type = CONST(Person));

        }
        field(39; Comment; Boolean)
        {
            CalcFormula = Exist("Human Resource Comment Line" WHERE("Table Name" = CONST(Employee),
                                                                     "No." = FIELD("No.")));
            Caption = 'Comment';
            Editable = false;
            FieldClass = FlowField;
        }
        field(40; "Last Date Modified"; Date)
        {
            Caption = 'Last Date Modified';
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(41; "Date Filter"; Date)
        {
            Caption = 'Date Filter';
            FieldClass = FlowFilter;
        }
        field(42; "Global Dimension 1 Filter"; Code[20])
        {
            CaptionClass = '1,3,1';
            Caption = 'Global Dimension 1 Filter';
            FieldClass = FlowFilter;
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1));
        }
        field(43; "Global Dimension 2 Filter"; Code[20])
        {
            CaptionClass = '1,3,2';
            Caption = 'Global Dimension 2 Filter';
            FieldClass = FlowFilter;
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2));
        }
        field(44; "Cause of Absence Filter"; Code[10])
        {
            Caption = 'Cause of Absence Filter';
            FieldClass = FlowFilter;
            TableRelation = "Cause of Absence";
        }
        field(45; "Total Absence"; Decimal)
        {
            AutoFormatType = 1;
            CalcFormula = Sum("Employee Absence".Quantity WHERE("Employee No." = FIELD("No."),
                                                                 "Cause of Absence Code" = FIELD("Cause of Absence Filter"),
                                                                 "From Date" = FIELD("Date Filter")));
            Caption = 'Total Absence';
            Editable = false;
            FieldClass = FlowField;
        }
        field(46; Extension; Text[30])
        {
            Caption = 'Extension';
            DataClassification = CustomerContent;
        }
        field(47; "Employee No. Filter"; Code[20])
        {
            Caption = 'Employee No. Filter';
            FieldClass = FlowFilter;
            TableRelation = Employee;
        }
        field(48; Pager; Text[30])
        {
            Caption = 'Pager';
            DataClassification = CustomerContent;
        }
        field(49; "Fax No."; Text[30])
        {
            Caption = 'Fax No.';
            DataClassification = CustomerContent;
        }
        field(50; "Company E-Mail"; Text[80])
        {
            Caption = 'Company E-Mail';
            DataClassification = CustomerContent;
        }
        field(51; Title; Text[30])
        {
            Caption = 'Title';
            DataClassification = CustomerContent;
        }
        field(52; "Salespers./Purch. Code"; Code[10])
        {
            Caption = 'Salespers./Purch. Code';
            DataClassification = CustomerContent;
            TableRelation = "Salesperson/Purchaser";
        }
        field(53; "No. Series"; Code[10])
        {
            Caption = 'No. Series';
            Editable = false;
            TableRelation = "No. Series";
        }
        field(71120; "Working Shift Code"; Code[20])
        {
            Caption = 'Working Shift Code';
            DataClassification = CustomerContent;
            TableRelation = Shift;
        }
        field(71121; "Driving Licence No"; Code[20])
        {
            Caption = 'Driving Licence No';
            DataClassification = CustomerContent;
        }
        field(71122; "Driving Expiry Date"; Date)
        {
            Caption = 'Driving Expiry Date';
            DataClassification = CustomerContent;
        }
        field(71123; "Passport No"; Code[20])
        {
            Caption = 'Passport No';
            DataClassification = CustomerContent;
        }
        field(71124; "Passport Expiry Date"; Date)
        {
            Caption = 'Passport Expiry Date';
            DataClassification = CustomerContent;
        }
        field(71125; "Voter ID No"; Code[20])
        {
            Caption = 'Voter ID No';
            DataClassification = CustomerContent;
        }
        field(71126; "PAN No"; Code[20])
        {
            Caption = 'PAN No';
            DataClassification = CustomerContent;
        }
        field(71127; "PF No"; Code[20])
        {
            Caption = 'PF No';
            DataClassification = CustomerContent;
        }
        field(71128; "ESI No"; Code[20])
        {
            Caption = 'ESI No';
            DataClassification = CustomerContent;
        }
        field(71129; "ESI Dispensary Location"; Text[50])
        {
            Caption = 'ESI Dispensary Location';
            DataClassification = CustomerContent;
        }
        field(71130; "Payment Method"; Option)
        {
            Caption = 'Payment Method';
            DataClassification = CustomerContent;
            OptionCaption = 'Cash,Cheque,Bank Transfer';
            OptionMembers = Cash,Cheque,"Bank Transfer";
        }
        field(71131; "Bank Code"; Code[10])
        {
            Caption = 'Bank Code';
            DataClassification = CustomerContent;
        }
        field(71132; "Bank Name"; Code[50])
        {
            Caption = 'Bank Name';
            DataClassification = CustomerContent;
        }
        field(71133; "Bank Branch"; Code[50])
        {
            Caption = 'Bank Branch';
            DataClassification = CustomerContent;
        }
        field(71134; "Account Type"; Text[30])
        {
            Caption = 'Account Type';
            DataClassification = CustomerContent;
        }
        field(71135; "Account No"; Code[20])
        {
            Caption = 'Account No';
            DataClassification = CustomerContent;
        }
        field(71136; "Father's Name"; Text[50])
        {
            Caption = 'Father''s Name';
            DataClassification = CustomerContent;
        }
        field(71137; "Spouse Name"; Text[50])
        {
            Caption = 'Spouse Name';
            DataClassification = CustomerContent;
        }
        field(71138; "Spouse Education"; Text[50])
        {
            Caption = 'Spouse Education';
            DataClassification = CustomerContent;
        }
        field(71139; "Marital Status"; Boolean)
        {
            Caption = 'Marital Status';
            DataClassification = CustomerContent;
        }
        field(71140; "Marriage Date"; Date)
        {
            Caption = 'Marriage Date';
            DataClassification = CustomerContent;
        }
        field(71141; "No of Children"; Integer)
        {
            Caption = 'No of Children';
            DataClassification = CustomerContent;
        }
        field(71142; "Blood Donar"; Boolean)
        {
            Caption = 'Blood Donar';
            DataClassification = CustomerContent;
        }
        field(71143; "Blood Group"; Option)
        {
            Caption = 'Blood Group';
            DataClassification = CustomerContent;
            OptionCaption = ' ,A+,A-,B+,B-,AB+,AB-,O+,O-,A1+,A1-';
            OptionMembers = " ","A+","A-","B+","B-","AB+","AB-","O+","O-","A1+","A1-";
        }
        field(71144; Nationality; Text[50])
        {
            Caption = 'Nationality';
            DataClassification = CustomerContent;
        }
        field(71145; Religion; Text[50])
        {
            Caption = 'Religion';
            DataClassification = CustomerContent;
        }
        field(71146; Caste; Text[50])
        {
            Caption = 'Caste';
            DataClassification = CustomerContent;
        }
        field(71147; "Date of Joining"; Date)
        {
            Caption = 'Date of Joining';
            DataClassification = CustomerContent;
        }
        field(71148; "Date of Confirmation"; Date)
        {
            Caption = 'Date of Confirmation';
            DataClassification = CustomerContent;
        }
        field(71149; "Retirement Type"; Option)
        {
            Caption = 'Retirement Type';
            DataClassification = CustomerContent;
            OptionCaption = ' ,VRS,Family Pension,Pension';
            OptionMembers = " ",VRS,"Family Pension",Pension;
        }
        field(71150; Accommodation; Boolean)
        {
            Caption = 'Accommodation';
            DataClassification = CustomerContent;
        }
        field(71151; "Accommodation Type"; Option)
        {
            Caption = 'Accommodation Type';
            DataClassification = CustomerContent;
            OptionCaption = ' ,Residential,Company Quaters';
            OptionMembers = " ",Residential,"Company Quaters";
        }
        field(71152; "Quarter No"; Code[20])
        {
            Caption = 'Quarter No';
            DataClassification = CustomerContent;
        }
        field(71153; "Grade Code"; Code[20])
        {
            Caption = 'Grade Code';
            DataClassification = CustomerContent;
            TableRelation = Grades;
        }
        field(71154; "PF Applicable"; Boolean)
        {
            Caption = 'PF Applicable';
            DataClassification = CustomerContent;
        }
        field(71155; "EPS Applicable"; Boolean)
        {
            Caption = 'EPS Applicable';
            DataClassification = CustomerContent;
        }
        field(71156; "VPF Applicable"; Boolean)
        {
            Caption = 'VPF Applicable';
            DataClassification = CustomerContent;
        }
        field(71157; "ESI Applicable"; Boolean)
        {
            Caption = 'ESI Applicable';
            DataClassification = CustomerContent;
        }
        field(71158; "PT Applicable"; Boolean)
        {
            Caption = 'PT Applicable';
            DataClassification = CustomerContent;
        }
        field(71159; "LWF Applicable"; Boolean)
        {
            Caption = 'LWF Applicable';
            DataClassification = CustomerContent;
        }
        field(71160; "OT Applicable"; Boolean)
        {
            Caption = 'OT Applicable';
            DataClassification = CustomerContent;
        }
        field(71161; "Leave Encashment Applicable"; Boolean)
        {
            Caption = 'Leave Encashment Applicable';
            DataClassification = CustomerContent;
        }
        field(71162; "Bonus Applicable"; Boolean)
        {
            Caption = 'Bonus Applicable';
            DataClassification = CustomerContent;
        }
        field(71163; "Gratuity Applicable"; Boolean)
        {
            Caption = 'Gratuity Applicable';
            DataClassification = CustomerContent;
        }
        field(71164; Probationary; Boolean)
        {
            Caption = 'Probationary';
            DataClassification = CustomerContent;
        }
        field(71165; "Emp Posting Group"; Code[20])
        {
            Caption = 'Emp Posting Group';
            DataClassification = CustomerContent;
            TableRelation = "Payroll Employee Posting Group";
        }
        field(71166; "Pay Bus. Posting Group"; Code[20])
        {
            Caption = 'Pay Bus. Posting Group';
            DataClassification = CustomerContent;
            TableRelation = "Payroll Business Posting Group";
        }
        field(71167; "PT Branch Code"; Code[20])
        {
            Caption = 'PT Branch Code';
            DataClassification = CustomerContent;
            TableRelation = "Professional Tax Header"."Branch Code" WHERE("Location Code" = FIELD("Location Code"),
                                                                           "Salary Plan Code" = FIELD("Salary Plan Code"));
        }
        field(71168; "Stop Payment"; Boolean)
        {
            Caption = 'Stop Payment';
            DataClassification = CustomerContent;
        }
        field(71169; Blocked; Boolean)
        {
            Caption = 'Blocked';
            DataClassification = CustomerContent;
        }
        field(71170; "Mail Send To HR"; Boolean)
        {
            Caption = 'Mail Send To HR';
            DataClassification = CustomerContent;
        }
        field(71171; "Current Status"; Option)
        {
            Caption = 'Current Status';
            DataClassification = CustomerContent;
            OptionCaption = 'Current Employee,Retirement,Resigned,Terminated,Death';
            OptionMembers = "Current Employee",Retirement,Resigned,Terminated,Death;
        }
        field(71172; "Date of Relieving"; Date)
        {
            Caption = 'Date of Relieving';
            DataClassification = CustomerContent;
        }
        field(71173; "Final Settlement Over"; Boolean)
        {
            Caption = 'Final Settlement Over';
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(71174; Designation; Code[30])
        {
            Caption = 'Designation';
            TableRelation = Designation;
            DataClassification = CustomerContent;

            trigger OnValidate()
            begin
                if DesignationRec.Get(Designation) then
                    "Job Title" := DesignationRec.Description;
            end;
        }
        field(71175; "Salary Plan Code"; Code[20])
        {
            Caption = 'Salary Plan Code';
            TableRelation = "Salary Plan";
            DataClassification = CustomerContent;
        }
        field(71176; "Location Code"; Code[20])
        {
            Caption = 'Location Code';
            TableRelation = "Location HR & Payroll Setup";
            DataClassification = CustomerContent;
        }
        field(71177; "Over Time Multiplier"; Integer)
        {
            Caption = 'Over Time Multiplier';
            DataClassification = CustomerContent;
        }
        field(71178; "PF Enrollment Date"; Date)
        {
            Caption = 'PF Enrollment Date';
            DataClassification = CustomerContent;
        }
        field(71179; "Employee VPF ( Employee) %"; Decimal)
        {
            Caption = 'Employee VPF ( Employee) %';
            DataClassification = CustomerContent;
        }
        field(71180; "Attendance Generated"; Boolean)
        {
            Caption = 'Attendance Generated';
            DataClassification = CustomerContent;
        }
        field(71181; "Leave Generated"; Boolean)
        {
            Caption = 'Leave Generated';
            DataClassification = CustomerContent;
        }
        field(71182; "Scale of Pay"; Text[50])
        {
            Caption = 'Scale of Pay';
            DataClassification = CustomerContent;
        }
        field(71183; "Non Teaching / Teaching"; Option)
        {
            Caption = 'Non Teaching / Teaching';
            DataClassification = CustomerContent;
            OptionCaption = ' ,Non Teaching,Teaching';
            OptionMembers = " ","Non Teaching",Teaching;
        }
        field(71184; CVAttachment1; Text[50])
        {
            Caption = 'CVAttachment1';
            DataClassification = CustomerContent;
        }
        field(71185; CVAttachment2; Text[50])
        {
            Caption = 'CVAttachment2';
            DataClassification = CustomerContent;
        }
        field(71186; "Employee Convert"; Boolean)
        {
            Caption = 'Employee Convert';
            DataClassification = CustomerContent;
            Editable = false;
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

    var
        //PostCode: Record "Post Code";
        DesignationRec: Record Designation;
}

