table 72020 "Candidate Joining"
{
    // -----------------------------------------------------------------------------------------------
    // Firstware Sofware Solutions : Project Name : HR & PAYROLL
    // -----------------------------------------------------------------------------------------------
    // No.  Date          Developer     Spec/CU/CR      Description
    // -----------------------------------------------------------------------------------------------
    // 1    04.APR.2009   SENTHIL                       New Tables Added for HR Module.

    Caption = 'Candidate Joining';
    DataCaptionFields = "No.", "First Name";
    DrillDownPageID = 72030;
    LookupPageID = 72030;

    fields
    {
        field(1; "No."; Code[20])
        {
            Caption = 'No.';
        }
        field(2; "First Name"; Text[30])
        {
            Caption = 'First Name';

            trigger OnValidate()
            begin
                "Search Name" := "First Name";
            end;
        }
        field(3; "Middle Name"; Text[30])
        {
            Caption = 'Middle Name';
        }
        field(4; "Last Name"; Text[30])
        {
            Caption = 'Last Name';
        }
        field(5; Initials; Text[30])
        {
            Caption = 'Initials';

            trigger OnValidate()
            begin
                if ("Search Name" = UpperCase(xRec.Initials)) or ("Search Name" = '') then
                    "Search Name" := Initials;
            end;
        }
        field(6; "Job Title"; Text[30])
        {
            Caption = 'Job Title';

            trigger OnValidate()
            begin
                Designation := "Job Title";
            end;
        }
        field(7; "Search Name"; Code[30])
        {
            Caption = 'Search Name';
        }
        field(8; Address; Text[30])
        {
            Caption = 'Address';
        }
        field(9; "Address 2"; Text[30])
        {
            Caption = 'Address 2';
        }
        field(10; City; Text[30])
        {
            Caption = 'City';

            trigger OnLookup()
            begin
                //PostCode.LookUpCity(City,"Post Code",TRUE);
            end;

            trigger OnValidate()
            begin
                //PostCode.ValidateCity(City,"Post Code");
            end;
        }
        field(11; "Post Code"; Code[20])
        {
            Caption = 'Post Code';
            TableRelation = "Post Code";
            //This property is currently not supported
            //TestTableRelation = false;
            ValidateTableRelation = false;

            trigger OnLookup()
            begin
                //PostCode.LookUpPostCode(City,"Post Code",TRUE);
            end;

            trigger OnValidate()
            begin
                //PostCode.ValidatePostCode(City,"Post Code");
            end;
        }
        field(12; County; Text[30])
        {
            Caption = 'County';
        }
        field(13; "Phone No."; Text[30])
        {
            Caption = 'Phone No.';
        }
        field(14; "Mobile Phone No."; Text[30])
        {
            Caption = 'Mobile Phone No.';
        }
        field(15; "E-Mail"; Text[80])
        {
            Caption = 'E-Mail';
        }
        field(16; "Alt. Address Code"; Code[10])
        {
            Caption = 'Alt. Address Code';
            TableRelation = "Alternative Address".Code WHERE ("Employee No." = FIELD ("No."));
        }
        field(17; "Alt. Address Start Date"; Date)
        {
            Caption = 'Alt. Address Start Date';
        }
        field(18; "Alt. Address End Date"; Date)
        {
            Caption = 'Alt. Address End Date';
        }
        field(19; Picture; BLOB)
        {
            Caption = 'Picture';
            SubType = Bitmap;
        }
        field(20; "Birth Date"; Date)
        {
            Caption = 'Birth Date';
        }
        field(21; "Social Security No."; Text[30])
        {
            Caption = 'Social Security No.';
        }
        field(22; "Union Code"; Code[10])
        {
            Caption = 'Union Code';
            TableRelation = Union;
        }
        field(23; "Union Membership No."; Text[30])
        {
            Caption = 'Union Membership No.';
        }
        field(24; Sex; Option)
        {
            Caption = 'Sex';
            OptionCaption = ' ,Female,Male';
            OptionMembers = " ",Female,Male;
        }
        field(25; "Country Code"; Code[10])
        {
            Caption = 'Country Code';
            TableRelation = "Country/Region";
        }
        field(26; "Manager No."; Code[20])
        {
            Caption = 'Manager No.';
            TableRelation = Employee;
        }
        field(27; "Emplymt. Contract Code"; Code[10])
        {
            Caption = 'Emplymt. Contract Code';
            TableRelation = "Employment Contract";
        }
        field(28; "Statistics Group Code"; Code[10])
        {
            Caption = 'Statistics Group Code';
            TableRelation = "Employee Statistics Group";
        }
        field(29; "Employment Date"; Date)
        {
            Caption = 'Employment Date';
        }
        field(31; Status; Option)
        {
            Caption = 'Status';
            OptionCaption = 'Active,Inactive';
            OptionMembers = Active,Inactive;

            trigger OnValidate()
            begin
                /*EmployeeQualification.SETRANGE("Employee No.","No.");
                EmployeeQualification.MODIFYALL("Employee Status",Status);
                MODIFY;
                */

            end;
        }
        field(32; "Inactive Date"; Date)
        {
            Caption = 'Inactive Date';
        }
        field(33; "Cause of Inactivity Code"; Code[10])
        {
            Caption = 'Cause of Inactivity Code';
            TableRelation = "Cause of Inactivity";
        }
        field(34; "Termination Date"; Date)
        {
            Caption = 'Termination Date';
        }
        field(35; "Grounds for Term. Code"; Code[10])
        {
            Caption = 'Grounds for Term. Code';
            TableRelation = "Grounds for Termination";
        }
        field(36; "Global Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,1,1';
            Caption = 'Global Dimension 1 Code';
            TableRelation = "Dimension Value".Code WHERE ("Global Dimension No." = CONST (1));

            trigger OnValidate()
            begin
                /*ValidateShortcutDimCode(1,"Global Dimension 1 Code");
                MODIFY;
                */

            end;
        }
        field(37; "Global Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,1,2';
            Caption = 'Global Dimension 2 Code';
            TableRelation = "Dimension Value".Code WHERE ("Global Dimension No." = CONST (2));

            trigger OnValidate()
            begin
                /*ValidateShortcutDimCode(2,"Global Dimension 2 Code");
                MODIFY;
                */

            end;
        }
        field(38; "Resource No."; Code[20])
        {
            Caption = 'Resource No.';
            TableRelation = Resource WHERE (Type = CONST (Person));

            trigger OnValidate()
            begin
                /*IF ("Resource No." <> '') AND Res.WRITEPERMISSION THEN
                EmployeeResUpdate.ResUpdate(Rec)
                */

            end;
        }
        field(39; Comment; Boolean)
        {
            CalcFormula = Exist ("Human Resource Comment Line" WHERE ("Table Name" = CONST (Employee),
                                                                     "No." = FIELD ("No.")));
            Caption = 'Comment';
            Editable = false;
            FieldClass = FlowField;
        }
        field(40; "Last Date Modified"; Date)
        {
            Caption = 'Last Date Modified';
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
            TableRelation = "Dimension Value".Code WHERE ("Global Dimension No." = CONST (1));
        }
        field(43; "Global Dimension 2 Filter"; Code[20])
        {
            CaptionClass = '1,3,2';
            Caption = 'Global Dimension 2 Filter';
            FieldClass = FlowFilter;
            TableRelation = "Dimension Value".Code WHERE ("Global Dimension No." = CONST (2));
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
            CalcFormula = Sum ("Employee Absence".Quantity WHERE ("Employee No." = FIELD ("No."),
                                                                 "Cause of Absence Code" = FIELD ("Cause of Absence Filter"),
                                                                 "From Date" = FIELD ("Date Filter")));
            Caption = 'Total Absence';
            Editable = false;
            FieldClass = FlowField;
        }
        field(46; Extension; Text[30])
        {
            Caption = 'Extension';
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
        }
        field(49; "Fax No."; Text[30])
        {
            Caption = 'Fax No.';
        }
        field(50; "Company E-Mail"; Text[80])
        {
            Caption = 'Company E-Mail';
        }
        field(51; Title; Text[30])
        {
            Caption = 'Title';
        }
        field(52; "Salespers./Purch. Code"; Code[10])
        {
            Caption = 'Salespers./Purch. Code';
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
            TableRelation = Shift;
        }
        field(71121; "Driving Licence No"; Code[20])
        {
            Caption = 'Driving Licence No';
        }
        field(71122; "Driving Expiry Date"; Date)
        {
            Caption = 'Driving Expiry Date';
        }
        field(71123; "Passport No"; Code[20])
        {
            Caption = 'Passport No';
        }
        field(71124; "Passport Expiry Date"; Date)
        {
            Caption = 'Passport Expiry Date';
        }
        field(71125; "Voter ID No"; Code[20])
        {
            Caption = 'Voter ID No';
        }
        field(71126; "PAN No"; Code[20])
        {
            Caption = 'PAN No';
        }
        field(71127; "PF No"; Code[20])
        {
            Caption = 'PF No';
        }
        field(71128; "ESI No"; Code[20])
        {
            Caption = 'ESI No';
        }
        field(71129; "ESI Dispensary Location"; Text[50])
        {
            Caption = 'ESI Dispensary Location';
        }
        field(71130; "Payment Method"; Option)
        {
            Caption = 'Payment Method';
            OptionCaption = 'Cash,Cheque,Bank Transfer';
            OptionMembers = Cash,Cheque,"Bank Transfer";
        }
        field(71131; "Bank Code"; Code[10])
        {
            Caption = 'Bank Code';
        }
        field(71132; "Bank Name"; Code[50])
        {
            Caption = 'Bank Name';
        }
        field(71133; "Bank Branch"; Code[50])
        {
            Caption = 'Bank Branch';
        }
        field(71134; "Account Type"; Text[30])
        {
            Caption = 'Account Type';
        }
        field(71135; "Account No"; Code[20])
        {
            Caption = 'Account No';
        }
        field(71136; "Father's Name"; Text[50])
        {
            Caption = 'Father''s Name';
        }
        field(71137; "Spouse Name"; Text[50])
        {
            Caption = 'Spouse Name';
        }
        field(71138; "Spouse Education"; Text[50])
        {
            Caption = 'Spouse Education';
        }
        field(71139; "Marital Status"; Boolean)
        {
            Caption = 'Marital Status';
        }
        field(71140; "Marriage Date"; Date)
        {
            Caption = 'Marriage Date';
        }
        field(71141; "No of Children"; Integer)
        {
            Caption = 'No of Children';
        }
        field(71142; "Blood Donar"; Boolean)
        {
            Caption = 'Blood Donar';
        }
        field(71143; "Blood Group"; Option)
        {
            Caption = 'Blood Group';
            OptionCaption = ' ,A+,A-,B+,B-,AB+,AB-,O+,O-,A1+,A1-';
            OptionMembers = " ","A+","A-","B+","B-","AB+","AB-","O+","O-","A1+","A1-";
        }
        field(71144; Nationality; Text[50])
        {
            Caption = 'Nationality';
        }
        field(71145; Religion; Text[50])
        {
            Caption = 'Religion';
        }
        field(71146; Caste; Text[50])
        {
            Caption = 'Caste';
        }
        field(71147; "Date of Joining"; Date)
        {
            Caption = 'Date of Joining';
        }
        field(71148; "Date of Confirmation"; Date)
        {
            Caption = 'Date of Confirmation';
        }
        field(71149; "Retirement Type"; Option)
        {
            Caption = 'Retirement Type';
            OptionCaption = ' ,VRS,Family Pension,Pension';
            OptionMembers = " ",VRS,"Family Pension",Pension;
        }
        field(71150; Accommodation; Boolean)
        {
            Caption = 'Accommodation';
        }
        field(71151; "Accommodation Type"; Option)
        {
            Caption = 'Accommodation Type';
            OptionCaption = ' ,Residential,Company Quaters';
            OptionMembers = " ",Residential,"Company Quaters";
        }
        field(71152; "Quarter No"; Code[20])
        {
            Caption = 'Quarter No';
        }
        field(71153; "Grade Code"; Code[20])
        {
            Caption = 'Grade Code';
            TableRelation = Grades;
        }
        field(71154; "PF Applicable"; Boolean)
        {
            Caption = 'PF Applicable';
        }
        field(71155; "EPS Applicable"; Boolean)
        {
            Caption = 'EPS Applicable';
        }
        field(71156; "VPF Applicable"; Boolean)
        {
            Caption = 'VPF Applicable';
        }
        field(71157; "ESI Applicable"; Boolean)
        {
            Caption = 'ESI Applicable';
        }
        field(71158; "PT Applicable"; Boolean)
        {
            Caption = 'PT Applicable';
        }
        field(71159; "LWF Applicable"; Boolean)
        {
            Caption = 'LWF Applicable';
        }
        field(71160; "OT Applicable"; Boolean)
        {
            Caption = 'OT Applicable';
        }
        field(71161; "Leave Encashment Applicable"; Boolean)
        {
            Caption = 'Leave Encashment Applicable';
        }
        field(71162; "Bonus Applicable"; Boolean)
        {
            Caption = 'Bonus Applicable';
        }
        field(71163; "Gratuity Applicable"; Boolean)
        {
            Caption = 'Gratuity Applicable';
        }
        field(71164; Probationary; Boolean)
        {
            Caption = 'Probationary';
        }
        field(71165; "Emp Posting Group"; Code[20])
        {
            Caption = 'Emp Posting Group';
            TableRelation = "Payroll Employee Posting Group";
        }
        field(71166; "Pay Bus. Posting Group"; Code[20])
        {
            Caption = 'Pay Bus. Posting Group';
            TableRelation = "Payroll Business Posting Group";
        }
        field(71167; "PT Branch Code"; Code[20])
        {
            Caption = 'PT Branch Code';
            TableRelation = "Professional Tax Header"."Branch Code" WHERE ("Location Code" = FIELD ("Location Code"),
                                                                           "Salary Plan Code" = FIELD ("Salary Plan Code"));
        }
        field(71168; "Stop Payment"; Boolean)
        {
            Caption = 'Stop Payment';
        }
        field(71169; Blocked; Boolean)
        {
            Caption = 'Blocked';
        }
        field(71170; "Mail Send To HR"; Boolean)
        {
            Caption = 'Mail Send To HR';
        }
        field(71171; "Current Status"; Option)
        {
            Caption = 'Current Status';
            OptionCaption = 'Current Employee,Retirement,Resigned,Terminated,Death';
            OptionMembers = "Current Employee",Retirement,Resigned,Terminated,Death;
        }
        field(71172; "Date of Relieving"; Date)
        {
            Caption = 'Date of Relieving';
        }
        field(71173; "Final Settlement Over"; Boolean)
        {
            Caption = 'Final Settlement Over';
            Editable = false;
        }
        field(71174; Designation; Code[20])
        {
            Caption = 'Designation';
            TableRelation = Designation;

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
        }
        field(71176; "Location Code"; Code[20])
        {
            Caption = 'Location Code';
            TableRelation = "Location HR & Payroll Setup";
        }
        field(71177; "Over Time Multiplier"; Integer)
        {
            Caption = 'Over Time Multiplier';
        }
        field(71178; "PF Enrollment Date"; Date)
        {
            Caption = 'PF Enrollment Date';
        }
        field(71179; "Employee VPF ( Employee) %"; Decimal)
        {
            Caption = 'Employee VPF ( Employee) %';
        }
        field(71180; "Attendance Generated"; Boolean)
        {
            Caption = 'Attendance Generated';
        }
        field(71181; "Leave Generated"; Boolean)
        {
            Caption = 'Leave Generated';
        }
        field(71182; "Scale of Pay"; Text[50])
        {
            Caption = 'Scale of Pay';
        }
        field(71183; "Non Teaching / Teaching"; Option)
        {
            Caption = 'Non Teaching / Teaching';
            OptionCaption = ' ,Non Teaching,Teaching';
            OptionMembers = " ","Non Teaching",Teaching;
        }
        field(71184; CVAttachment1; Text[50])
        {
            Caption = 'CVAttachment1';
        }
        field(71185; CVAttachment2; Text[50])
        {
            Caption = 'CVAttachment2';
        }
        field(71186; "Employee Convert"; Boolean)
        {
            Caption = 'Employee Convert';
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
        PostCode: Record "Post Code";
        DesignationRec: Record Designation;
}

