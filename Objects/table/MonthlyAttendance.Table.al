table 72082 "Monthly Attendance"
{

    Caption = 'Monthly Attendance';
    DataClassification = CustomerContent;
    DataCaptionFields = "Location Code", "Salary Plan Code", "Salary Cycle Code", Name;
    DrillDownPageId = "Monthly Attendance List";
    LookupPageId = "Monthly Attendance List";

    fields
    {
        field(1; "Location Code"; Code[20])
        {
            Caption = 'Location Code';
            DataClassification = CustomerContent;
            ToolTip = 'Specifies the location for this attendance record.';
            TableRelation = "Location HR & Payroll Setup";
        }
        field(2; "Salary Plan Code"; Code[20])
        {
            Caption = 'Salary Plan Code';
            DataClassification = CustomerContent;
            ToolTip = 'Salary plan applicable to the employee.';
            TableRelation = "Salary Plan";
        }
        field(3; "Salary Cycle Code"; Code[20])
        {
            Caption = 'Salary Cycle Code';
            DataClassification = CustomerContent;
            TableRelation = "Payroll Month & Year"."Salary Cyclic Code" WHERE("Location Code" = FIELD("Location Code"),
                                                                               "Salary Plan Code" = FIELD("Salary Plan Code"));
        }
        field(4; "Payroll Start Date"; Date)
        {
            Caption = 'Payroll Start Date';
            DataClassification = CustomerContent;
            ToolTip = 'Start date of the payroll period.';
        }
        field(5; "Payroll End Date"; Date)
        {
            Caption = 'Payroll End Date';
            DataClassification = CustomerContent;
            ToolTip = 'End date of the payroll period.';
        }
        field(6; Year; Integer)
        {
            Caption = 'Year';
            DataClassification = CustomerContent;
            ToolTip = 'Year of the payroll period.';
        }
        field(7; Month; Integer)
        {
            Caption = 'Month';
            DataClassification = CustomerContent;
            ToolTip = 'Month of the payroll period (1-12).';
            ValuesAllowed = 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12;
        }
        field(8; "Employee No"; Code[20])
        {
            Caption = 'Employee No';
            DataClassification = CustomerContent;
            ToolTip = 'Employee identifier.';
            TableRelation = Employee;
        }
        field(9; Name; Text[50])
        {
            Caption = 'Name';
            DataClassification = CustomerContent;
            ToolTip = 'Name of the employee.';
        }
        field(10; Present; Decimal)
        {
            CalcFormula = Sum("Daily Attendance".Present WHERE("Location Code" = FIELD("Location Code"),
                                                                "Salary Plan Code" = FIELD("Salary Plan Code"),
                                                                "Salary Cyclic Code" = FIELD("Salary Cycle Code"),
                                                                "Employee No" = FIELD("Employee No"),
                                                                Present = FILTER(<> 0)));
            Caption = 'Present';
            Editable = false;
            FieldClass = FlowField;
        }
        field(11; Absent; Decimal)
        {
            CalcFormula = Sum("Daily Attendance".Absent WHERE("Location Code" = FIELD("Location Code"),
                                                               "Salary Plan Code" = FIELD("Salary Plan Code"),
                                                               "Salary Cyclic Code" = FIELD("Salary Cycle Code"),
                                                               "Employee No" = FIELD("Employee No"),
                                                               Absent = FILTER(<> 0)));
            Caption = 'Absent';
            Editable = false;
            FieldClass = FlowField;
        }
        field(12; Leave; Decimal)
        {
            CalcFormula = Sum("Daily Attendance".Leave WHERE("Location Code" = FIELD("Location Code"),
                                                              "Salary Plan Code" = FIELD("Salary Plan Code"),
                                                              "Salary Cyclic Code" = FIELD("Salary Cycle Code"),
                                                              "Employee No" = FIELD("Employee No"),
                                                              Leave = FILTER(<> 0)));
            Caption = 'Leave';
            Editable = false;
            FieldClass = FlowField;
        }
        field(13; "Weekly Off"; Decimal)
        {
            CalcFormula = Sum("Daily Attendance"."Weekly Off" WHERE("Location Code" = FIELD("Location Code"),
                                                                     "Salary Plan Code" = FIELD("Salary Plan Code"),
                                                                     "Salary Cyclic Code" = FIELD("Salary Cycle Code"),
                                                                     "Employee No" = FIELD("Employee No"),
                                                                     "Weekly Off" = FILTER(<> 0)));
            Caption = 'Weekly Off';
            Editable = false;
            FieldClass = FlowField;
        }
        field(14; Holiday; Decimal)
        {
            CalcFormula = Sum("Daily Attendance".Holiday WHERE("Location Code" = FIELD("Location Code"),
                                                                "Salary Plan Code" = FIELD("Salary Plan Code"),
                                                                "Salary Cyclic Code" = FIELD("Salary Cycle Code"),
                                                                "Employee No" = FIELD("Employee No"),
                                                                Holiday = FILTER(<> 0)));
            Caption = 'Holiday';
            Editable = false;
            FieldClass = FlowField;
        }
        field(15; "On-Duty"; Decimal)
        {
            CalcFormula = Sum("Daily Attendance"."On-Duty" WHERE("Location Code" = FIELD("Location Code"),
                                                                  "Salary Plan Code" = FIELD("Salary Plan Code"),
                                                                  "Salary Cyclic Code" = FIELD("Salary Cycle Code"),
                                                                  "Employee No" = FIELD("Employee No"),
                                                                  "On-Duty" = FILTER(<> 0)));
            Caption = 'On-Duty';
            Editable = false;
            FieldClass = FlowField;
        }
        field(16; "Not Joined"; Decimal)
        {
            CalcFormula = Sum("Daily Attendance".Relieved WHERE("Location Code" = FIELD("Location Code"),
                                                                 "Salary Plan Code" = FIELD("Salary Plan Code"),
                                                                 "Salary Cyclic Code" = FIELD("Salary Cycle Code"),
                                                                 "Employee No" = FIELD("Employee No"),
                                                                 "Not Joined" = FILTER(<> 0)));
            Caption = 'Not Joined';
            Editable = false;
            FieldClass = FlowField;
        }
        field(17; Relieved; Decimal)
        {
            CalcFormula = Sum("Daily Attendance".Relieved WHERE("Location Code" = FIELD("Location Code"),
                                                                 "Salary Plan Code" = FIELD("Salary Plan Code"),
                                                                 "Salary Cyclic Code" = FIELD("Salary Cycle Code"),
                                                                 "Employee No" = FIELD("Employee No"),
                                                                 Relieved = FILTER(<> 0)));
            Caption = 'Relieved';
            Editable = false;
            FieldClass = FlowField;
        }
        field(18; "Over Time In Mins"; Decimal)
        {
            CalcFormula = Sum("Daily Attendance"."Total OT In Mins" WHERE("Location Code" = FIELD("Location Code"),
                                                                           "Salary Plan Code" = FIELD("Salary Plan Code"),
                                                                           "Salary Cyclic Code" = FIELD("Salary Cycle Code"),
                                                                           "Employee No" = FIELD("Employee No"),
                                                                           "Total OT In Mins" = FILTER(<> 0)));
            Caption = 'Over Time In Mins';
            Editable = false;
            FieldClass = FlowField;
        }
        field(19; "Total Payable Days"; Decimal)
        {
            CalcFormula = Sum("Daily Attendance"."Payable Days" WHERE("Location Code" = FIELD("Location Code"),
                                                                       "Salary Plan Code" = FIELD("Salary Plan Code"),
                                                                       "Salary Cyclic Code" = FIELD("Salary Cycle Code"),
                                                                       "Employee No" = FIELD("Employee No"),
                                                                       "Payable Days" = FILTER(<> 0)));
            Caption = 'Total Payable Days';
            Editable = false;
            FieldClass = FlowField;
        }
        field(20; "Actual Gross Amount"; Decimal)
        {
            CalcFormula = Sum("Processed Salary"."Actual Amount" WHERE("Location Code" = FIELD("Location Code"),
                                                                        "Salary Plan Code" = FIELD("Salary Plan Code"),
                                                                        "Salary Cycle Code" = FIELD("Salary Cycle Code"),
                                                                        "Employee No" = FIELD("Employee No"),
                                                                        "Pay Type" = CONST(Addition)));
            Caption = 'Actual Gross Amount';
            Editable = true;
            FieldClass = FlowField;
        }
        field(21; "Payable Gross Amount"; Decimal)
        {
            CalcFormula = Sum("Processed Salary"."Payable Amount" WHERE("Location Code" = FIELD("Location Code"),
                                                                         "Salary Plan Code" = FIELD("Salary Plan Code"),
                                                                         "Salary Cycle Code" = FIELD("Salary Cycle Code"),
                                                                         "Employee No" = FIELD("Employee No"),
                                                                         "Pay Type" = CONST(Addition)));
            Caption = 'Payable Gross Amount';
            Editable = true;
            FieldClass = FlowField;
        }
        field(22; "Actual Reimburesment Amount"; Decimal)
        {
            CalcFormula = Sum("Processed Salary"."Actual Amount" WHERE("Location Code" = FIELD("Location Code"),
                                                                        "Salary Plan Code" = FIELD("Salary Plan Code"),
                                                                        "Salary Cycle Code" = FIELD("Salary Cycle Code"),
                                                                        "Employee No" = FIELD("Employee No"),
                                                                        "Pay Type" = CONST(Reimbursement)));
            Caption = 'Actual Reimburesment Amount';
            Editable = false;
            FieldClass = FlowField;
        }
        field(23; "Payable Reimburesment Amount"; Decimal)
        {
            CalcFormula = Sum("Processed Salary"."Payable Amount" WHERE("Location Code" = FIELD("Location Code"),
                                                                         "Salary Plan Code" = FIELD("Salary Plan Code"),
                                                                         "Salary Cycle Code" = FIELD("Salary Cycle Code"),
                                                                         "Employee No" = FIELD("Employee No"),
                                                                         "Pay Type" = CONST(Reimbursement)));
            Caption = 'Payable Reimburesment Amount';
            Editable = false;
            FieldClass = FlowField;
        }
        field(24; "Actual Deduction Amount"; Decimal)
        {
            CalcFormula = Sum("Processed Salary"."Actual Amount" WHERE("Location Code" = FIELD("Location Code"),
                                                                        "Salary Plan Code" = FIELD("Salary Plan Code"),
                                                                        "Salary Cycle Code" = FIELD("Salary Cycle Code"),
                                                                        "Employee No" = FIELD("Employee No"),
                                                                        "Pay Type" = CONST(Deduction)));
            Caption = 'Actual Deduction Amount';
            Editable = true;
            FieldClass = FlowField;
        }
        field(25; "Payable Deduction Amount"; Decimal)
        {
            CalcFormula = Sum("Processed Salary"."Payable Amount" WHERE("Location Code" = FIELD("Location Code"),
                                                                         "Salary Plan Code" = FIELD("Salary Plan Code"),
                                                                         "Salary Cycle Code" = FIELD("Salary Cycle Code"),
                                                                         "Employee No" = FIELD("Employee No"),
                                                                         "Pay Type" = CONST(Deduction)));
            Caption = 'Payable Deduction Amount';
            Editable = true;
            FieldClass = FlowField;
        }
        field(26; "Actual Net Amount"; Decimal)
        {
            Caption = 'Actual Net Amount';
            DataClassification = CustomerContent;
            ToolTip = 'Net salary amount (actual).';
        }
        field(27; "Payable Net Amount"; Decimal)
        {
            Caption = 'Payable Net Amount';
            DataClassification = CustomerContent;
            ToolTip = 'Net salary amount (payable).';
        }
        field(28; "Pay Amount"; Decimal)
        {
            Caption = 'Pay Amount';
            DataClassification = CustomerContent;
            ToolTip = 'Amount to be paid.';
        }
        field(29; "Paid Amount"; Decimal)
        {
            Caption = 'Paid Amount';
            DataClassification = CustomerContent;
            ToolTip = 'Amount already paid.';
        }
        field(30; "Salary Processed"; Boolean)
        {
            Caption = 'Processed';
            DataClassification = CustomerContent;
            ToolTip = 'Indicates if the salary is processed.';
        }
        field(31; "Processed Date"; Date)
        {
            Caption = 'Processed Date';
            DataClassification = CustomerContent;
            ToolTip = 'Date when salary was processed.';
        }
        field(32; "Journal Batch Name"; Code[20])
        {
            Caption = 'Journal Batch Name';
            DataClassification = CustomerContent;
            ToolTip = 'Name of the journal batch used.';
        }
        field(33; "Journal Template Name"; Code[20])
        {
            Caption = 'Journal Template Name';
            DataClassification = CustomerContent;
            ToolTip = 'Name of the journal template used.';
        }
        field(34; "Posted Document No"; Code[20])
        {
            Caption = 'Posted Document No';
            DataClassification = CustomerContent;
            ToolTip = 'Document number after posting.';
        }
        field(35; "Posted Date"; Date)
        {
            Caption = 'Posted Date';
            DataClassification = CustomerContent;
            ToolTip = 'Date when document was posted.';
        }
        field(36; Posted; Boolean)
        {
            Caption = 'Posted';
            DataClassification = CustomerContent;
            ToolTip = 'Indicates if the document is posted.';
        }
        field(37; Paid; Boolean)
        {
            Caption = 'Paid';
            DataClassification = CustomerContent;
            ToolTip = 'Indicates if payment is made.';
        }
        field(38; "Account Type"; Option)
        {
            Caption = 'Account Type';
            DataClassification = CustomerContent;
            ToolTip = 'Type of account used for payment.';
            OptionCaption = 'G/L Account,Customer,Vendor,Bank Account,Fixed Asset,IC Partner';
            OptionMembers = "G/L Account",Customer,Vendor,"Bank Account","Fixed Asset","IC Partner";
        }
        field(39; "Pay Method"; Option)
        {
            Caption = 'Pay Method';
            DataClassification = CustomerContent;
            ToolTip = 'Method of payment.';
            OptionCaption = 'Cash,Cheque,Bank Transfer';
            OptionMembers = Cash,Cheque,"Bank Transfer";
        }
        field(40; "Cheque No."; Code[20])
        {
            Caption = 'Cheque No.';
            DataClassification = CustomerContent;
            ToolTip = 'Cheque number if payment is by cheque.';
        }
        field(41; "Cheque Date"; Date)
        {
            Caption = 'Cheque Date';
            DataClassification = CustomerContent;
            ToolTip = 'Date of the cheque.';
        }
        field(42; "Account No."; Code[20])
        {
            Caption = 'Account No.';
            DataClassification = CustomerContent;
            TableRelation = IF ("Account Type" = CONST("G/L Account")) "G/L Account"
            ELSE
            IF ("Account Type" = CONST(Customer)) Customer
            ELSE
            IF ("Account Type" = CONST(Vendor)) Vendor
            ELSE
            IF ("Account Type" = CONST("Bank Account")) "Bank Account"
            ELSE
            IF ("Account Type" = CONST("Fixed Asset")) "Fixed Asset"
            ELSE
            IF ("Account Type" = CONST("IC Partner")) "IC Partner";
        }
        field(43; Blocked; Boolean)
        {
            Caption = 'Blocked';
            DataClassification = CustomerContent;
            ToolTip = 'Indicates if record is blocked.';
        }
        field(44; "I Payment Document No."; Code[20])
        {
            Caption = 'I Payment Document No.';
            DataClassification = CustomerContent;
            ToolTip = 'First payment document number.';
        }
        field(45; "I Payment Date"; Date)
        {
            Caption = 'I Payment Date';
            DataClassification = CustomerContent;
            ToolTip = 'Date of first payment.';
        }
        field(46; "Stop Payment"; Boolean)
        {
            Caption = 'Stop Payment';
            DataClassification = CustomerContent;
            ToolTip = 'Indicates if payment is stopped.';
        }
        field(47; "Date Filter"; Date)
        {
            Caption = 'Date Filter';
            ToolTip = 'Filter date for the record.';
            FieldClass = FlowFilter;
        }
        field(48; "Total Permission In Mins"; Decimal)
        {
            CalcFormula = Sum("Daily Attendance"."Total Permission In Mins" WHERE("Location Code" = FIELD("Location Code"),
                                                                                   "Salary Plan Code" = FIELD("Salary Plan Code"),
                                                                                   "Salary Cyclic Code" = FIELD("Salary Cycle Code"),
                                                                                   "Employee No" = FIELD("Employee No"),
                                                                                   "Total Permission In Mins" = FILTER(<> 0)));
            Caption = 'Total Permission In Mins';
            Editable = false;
            FieldClass = FlowField;
        }
        field(49; "Credit Days"; Decimal)
        {
            Caption = 'Credit Days';
            DataClassification = CustomerContent;
            ToolTip = 'Number of credited days.';
        }
        field(50; "First Net Amount"; Decimal)
        {
            Caption = 'First Net Amount';
            DataClassification = CustomerContent;
            ToolTip = 'First net salary amount.';
        }
        field(51; "Second Net Amount"; Decimal)
        {
            Caption = 'Second Net Amount';
            DataClassification = CustomerContent;
            ToolTip = 'Second net salary amount.';
        }
        field(52; "Payment Type"; Option)
        {
            Caption = 'Payment Type';
            DataClassification = CustomerContent;
            ToolTip = 'Type of payment.';
            OptionCaption = 'Full Payment,First Payment,Second Payment';
            OptionMembers = "Full Payment","First Payment","Second Payment";
        }
        field(53; "Employee Category"; Option)
        {
            Caption = 'Employee Category';
            DataClassification = CustomerContent;
            ToolTip = 'Category of employee.';
            OptionCaption = ' ,Staff Permanent,Staff Temporary,Class IV Permanent,Class IV Temporary,Class III Permanent,Class III Temporary';
            OptionMembers = " ","Staff Permanent","Staff Temporary","Class IV Permanent","Class IV Temporary","Class III Permanent","Class III Temporary";
        }
        field(54; "Lay Off"; Decimal)
        {
            CalcFormula = Sum("Daily Attendance"."Lay Off" WHERE("Location Code" = FIELD("Location Code"),
                                                                  "Salary Plan Code" = FIELD("Salary Plan Code"),
                                                                  "Salary Cyclic Code" = FIELD("Salary Cycle Code"),
                                                                  "Employee No" = FIELD("Employee No"),
                                                                  "Lay Off" = FILTER(<> 0)));
            Caption = 'Lay Off';
            Editable = false;
            FieldClass = FlowField;
        }
        field(55; "Total Perm. Hours"; Decimal)
        {
            Caption = 'Total Perm. Hours';
            DataClassification = CustomerContent;
            ToolTip = 'Total permission hours.';
        }
        field(56; "Total Over Time Hours"; Decimal)
        {
            Caption = 'Total Over Time Hours';
            DataClassification = CustomerContent;
            ToolTip = 'Total overtime hours.';
        }
        field(57; "Manual LOP Days"; Decimal)
        {
            Caption = 'Manual LOP Days';
            DataClassification = CustomerContent;
            ToolTip = 'Manual loss of pay days.';
            MaxValue = 31;
            MinValue = 0;
        }
        field(58; "Total Days Count"; Integer)
        {
            CalcFormula = Count("Daily Attendance" WHERE("Location Code" = FIELD("Location Code"),
                                                          "Salary Plan Code" = FIELD("Salary Plan Code"),
                                                          "Salary Cyclic Code" = FIELD("Salary Cycle Code"),
                                                          "Employee No" = FIELD("Employee No")));
            Caption = 'Total Days Count';
            Editable = false;
            FieldClass = FlowField;
        }
        field(59; "II Payment Document No."; Code[20])
        {
            Caption = 'II Payment Document No.';
            DataClassification = CustomerContent;
            ToolTip = 'Second payment document number.';
        }
        field(60; "II Payment Date"; Date)
        {
            Caption = 'II Payment Date';
            DataClassification = CustomerContent;
            ToolTip = 'Date of second payment.';
        }
        field(61; "Branch Code"; Code[10])
        {
            Caption = 'Branch Code';
            DataClassification = CustomerContent;
            ToolTip = 'Branch code for the employee.';
        }
        field(62; "Manual Total Days Worked"; Decimal)
        {
            Caption = 'Manual Total Days Worked';
            DataClassification = CustomerContent;
            ToolTip = 'Manual total days worked by employee.';
        }
        field(63; "Negative Pay"; Boolean)
        {
            Caption = 'Negative Pay';
            DataClassification = CustomerContent;
            ToolTip = 'Indicates negative pay status.';
        }
    }

    keys
    {
        key(Key1; "Employee No", "Salary Cycle Code", "Payroll Start Date", "Payroll End Date", Month, Year, "Location Code", "Salary Plan Code")
        {
            Clustered = true;
        }
        key(Key2; "Employee No", "Payroll End Date")
        {
        }
    }

    fieldgroups
    {
    }
}

