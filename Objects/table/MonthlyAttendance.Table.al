table 72082 "Monthly Attendance"
{
    // -----------------------------------------------------------------------------------------------
    // Firstware Sofware Solutions : Project Name : HR & PAYROLL
    // -----------------------------------------------------------------------------------------------
    // No.  Date          Developer     Spec/CU/CR      Description
    // -----------------------------------------------------------------------------------------------
    // 1    04.APR.2009   RAJAH.A                       New Tables Added for Payroll Module.
    // -----------------------------------------------------------------------------------------------

    Caption = 'Monthly Attendance';
    DataCaptionFields = "Location Code", "Salary Plan Code", "Salary Cycle Code", Name;

    fields
    {
        field(1; "Location Code"; Code[20])
        {
            Caption = 'Location Code';
            TableRelation = "Location HR & Payroll Setup";
        }
        field(2; "Salary Plan Code"; Code[20])
        {
            Caption = 'Salary Plan Code';
            TableRelation = "Salary Plan";
        }
        field(3; "Salary Cycle Code"; Code[20])
        {
            Caption = 'Salary Cycle Code';
            TableRelation = "Payroll Month & Year"."Salary Cyclic Code" WHERE ("Location Code" = FIELD ("Location Code"),
                                                                               "Salary Plan Code" = FIELD ("Salary Plan Code"));
        }
        field(4; "Payroll Start Date"; Date)
        {
            Caption = 'Payroll Start Date';
        }
        field(5; "Payroll End Date"; Date)
        {
            Caption = 'Payroll End Date';
        }
        field(6; Year; Integer)
        {
            Caption = 'Year';
        }
        field(7; Month; Integer)
        {
            Caption = 'Month';
            ValuesAllowed = 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12;
        }
        field(8; "Employee No"; Code[20])
        {
            Caption = 'Employee No';
            Editable = false;
            TableRelation = Employee;
        }
        field(9; Name; Text[50])
        {
            Caption = 'Name';
            Editable = false;
        }
        field(10; Present; Decimal)
        {
            CalcFormula = Sum ("Daily Attendance".Present WHERE ("Location Code" = FIELD ("Location Code"),
                                                                "Salary Plan Code" = FIELD ("Salary Plan Code"),
                                                                "Salary Cyclic Code" = FIELD ("Salary Cycle Code"),
                                                                "Employee No" = FIELD ("Employee No"),
                                                                Present = FILTER (<> 0)));
            Caption = 'Present';
            Editable = false;
            FieldClass = FlowField;
        }
        field(11; Absent; Decimal)
        {
            CalcFormula = Sum ("Daily Attendance".Absent WHERE ("Location Code" = FIELD ("Location Code"),
                                                               "Salary Plan Code" = FIELD ("Salary Plan Code"),
                                                               "Salary Cyclic Code" = FIELD ("Salary Cycle Code"),
                                                               "Employee No" = FIELD ("Employee No"),
                                                               Absent = FILTER (<> 0)));
            Caption = 'Absent';
            Editable = false;
            FieldClass = FlowField;
        }
        field(12; Leave; Decimal)
        {
            CalcFormula = Sum ("Daily Attendance".Leave WHERE ("Location Code" = FIELD ("Location Code"),
                                                              "Salary Plan Code" = FIELD ("Salary Plan Code"),
                                                              "Salary Cyclic Code" = FIELD ("Salary Cycle Code"),
                                                              "Employee No" = FIELD ("Employee No"),
                                                              Leave = FILTER (<> 0)));
            Caption = 'Leave';
            Editable = false;
            FieldClass = FlowField;
        }
        field(13; "Weekly Off"; Decimal)
        {
            CalcFormula = Sum ("Daily Attendance"."Weekly Off" WHERE ("Location Code" = FIELD ("Location Code"),
                                                                     "Salary Plan Code" = FIELD ("Salary Plan Code"),
                                                                     "Salary Cyclic Code" = FIELD ("Salary Cycle Code"),
                                                                     "Employee No" = FIELD ("Employee No"),
                                                                     "Weekly Off" = FILTER (<> 0)));
            Caption = 'Weekly Off';
            Editable = false;
            FieldClass = FlowField;
        }
        field(14; Holiday; Decimal)
        {
            CalcFormula = Sum ("Daily Attendance".Holiday WHERE ("Location Code" = FIELD ("Location Code"),
                                                                "Salary Plan Code" = FIELD ("Salary Plan Code"),
                                                                "Salary Cyclic Code" = FIELD ("Salary Cycle Code"),
                                                                "Employee No" = FIELD ("Employee No"),
                                                                Holiday = FILTER (<> 0)));
            Caption = 'Holiday';
            Editable = false;
            FieldClass = FlowField;
        }
        field(15; "On-Duty"; Decimal)
        {
            CalcFormula = Sum ("Daily Attendance"."On-Duty" WHERE ("Location Code" = FIELD ("Location Code"),
                                                                  "Salary Plan Code" = FIELD ("Salary Plan Code"),
                                                                  "Salary Cyclic Code" = FIELD ("Salary Cycle Code"),
                                                                  "Employee No" = FIELD ("Employee No"),
                                                                  "On-Duty" = FILTER (<> 0)));
            Caption = 'On-Duty';
            Editable = false;
            FieldClass = FlowField;
        }
        field(16; "Not Joined"; Decimal)
        {
            CalcFormula = Sum ("Daily Attendance".Relieved WHERE ("Location Code" = FIELD ("Location Code"),
                                                                 "Salary Plan Code" = FIELD ("Salary Plan Code"),
                                                                 "Salary Cyclic Code" = FIELD ("Salary Cycle Code"),
                                                                 "Employee No" = FIELD ("Employee No"),
                                                                 "Not Joined" = FILTER (<> 0)));
            Caption = 'Not Joined';
            Editable = false;
            FieldClass = FlowField;
        }
        field(17; Relieved; Decimal)
        {
            CalcFormula = Sum ("Daily Attendance".Relieved WHERE ("Location Code" = FIELD ("Location Code"),
                                                                 "Salary Plan Code" = FIELD ("Salary Plan Code"),
                                                                 "Salary Cyclic Code" = FIELD ("Salary Cycle Code"),
                                                                 "Employee No" = FIELD ("Employee No"),
                                                                 Relieved = FILTER (<> 0)));
            Caption = 'Relieved';
            Editable = false;
            FieldClass = FlowField;
        }
        field(18; "Over Time In Mins"; Decimal)
        {
            CalcFormula = Sum ("Daily Attendance"."Total OT In Mins" WHERE ("Location Code" = FIELD ("Location Code"),
                                                                           "Salary Plan Code" = FIELD ("Salary Plan Code"),
                                                                           "Salary Cyclic Code" = FIELD ("Salary Cycle Code"),
                                                                           "Employee No" = FIELD ("Employee No"),
                                                                           "Total OT In Mins" = FILTER (<> 0)));
            Caption = 'Over Time In Mins';
            Editable = false;
            FieldClass = FlowField;
        }
        field(19; "Total Payable Days"; Decimal)
        {
            CalcFormula = Sum ("Daily Attendance"."Payable Days" WHERE ("Location Code" = FIELD ("Location Code"),
                                                                       "Salary Plan Code" = FIELD ("Salary Plan Code"),
                                                                       "Salary Cyclic Code" = FIELD ("Salary Cycle Code"),
                                                                       "Employee No" = FIELD ("Employee No"),
                                                                       "Payable Days" = FILTER (<> 0)));
            Caption = 'Total Payable Days';
            Editable = false;
            FieldClass = FlowField;
        }
        field(20; "Actual Gross Amount"; Decimal)
        {
            CalcFormula = Sum ("Processed Salary"."Actual Amount" WHERE ("Location Code" = FIELD ("Location Code"),
                                                                        "Salary Plan Code" = FIELD ("Salary Plan Code"),
                                                                        "Salary Cycle Code" = FIELD ("Salary Cycle Code"),
                                                                        "Employee No" = FIELD ("Employee No"),
                                                                        "Pay Type" = CONST (Addition)));
            Caption = 'Actual Gross Amount';
            Editable = true;
            FieldClass = FlowField;
        }
        field(21; "Payable Gross Amount"; Decimal)
        {
            CalcFormula = Sum ("Processed Salary"."Payable Amount" WHERE ("Location Code" = FIELD ("Location Code"),
                                                                         "Salary Plan Code" = FIELD ("Salary Plan Code"),
                                                                         "Salary Cycle Code" = FIELD ("Salary Cycle Code"),
                                                                         "Employee No" = FIELD ("Employee No"),
                                                                         "Pay Type" = CONST (Addition)));
            Caption = 'Payable Gross Amount';
            Editable = true;
            FieldClass = FlowField;
        }
        field(22; "Actual Reimburesment Amount"; Decimal)
        {
            CalcFormula = Sum ("Processed Salary"."Actual Amount" WHERE ("Location Code" = FIELD ("Location Code"),
                                                                        "Salary Plan Code" = FIELD ("Salary Plan Code"),
                                                                        "Salary Cycle Code" = FIELD ("Salary Cycle Code"),
                                                                        "Employee No" = FIELD ("Employee No"),
                                                                        "Pay Type" = CONST (Reimbursement)));
            Caption = 'Actual Reimburesment Amount';
            Editable = false;
            FieldClass = FlowField;
        }
        field(23; "Payable Reimburesment Amount"; Decimal)
        {
            CalcFormula = Sum ("Processed Salary"."Payable Amount" WHERE ("Location Code" = FIELD ("Location Code"),
                                                                         "Salary Plan Code" = FIELD ("Salary Plan Code"),
                                                                         "Salary Cycle Code" = FIELD ("Salary Cycle Code"),
                                                                         "Employee No" = FIELD ("Employee No"),
                                                                         "Pay Type" = CONST (Reimbursement)));
            Caption = 'Payable Reimburesment Amount';
            Editable = false;
            FieldClass = FlowField;
        }
        field(24; "Actual Deduction Amount"; Decimal)
        {
            CalcFormula = Sum ("Processed Salary"."Actual Amount" WHERE ("Location Code" = FIELD ("Location Code"),
                                                                        "Salary Plan Code" = FIELD ("Salary Plan Code"),
                                                                        "Salary Cycle Code" = FIELD ("Salary Cycle Code"),
                                                                        "Employee No" = FIELD ("Employee No"),
                                                                        "Pay Type" = CONST (Deduction)));
            Caption = 'Actual Deduction Amount';
            Editable = true;
            FieldClass = FlowField;
        }
        field(25; "Payable Deduction Amount"; Decimal)
        {
            CalcFormula = Sum ("Processed Salary"."Payable Amount" WHERE ("Location Code" = FIELD ("Location Code"),
                                                                         "Salary Plan Code" = FIELD ("Salary Plan Code"),
                                                                         "Salary Cycle Code" = FIELD ("Salary Cycle Code"),
                                                                         "Employee No" = FIELD ("Employee No"),
                                                                         "Pay Type" = CONST (Deduction)));
            Caption = 'Payable Deduction Amount';
            Editable = true;
            FieldClass = FlowField;
        }
        field(26; "Actual Net Amount"; Decimal)
        {
            Caption = 'Actual Net Amount';
            Editable = true;
        }
        field(27; "Payable Net Amount"; Decimal)
        {
            Caption = 'Payable Net Amount';
            Editable = true;
        }
        field(28; "Pay Amount"; Decimal)
        {
            Caption = 'Pay Amount';
            Editable = false;
        }
        field(29; "Paid Amount"; Decimal)
        {
            Caption = 'Paid Amount';
            Editable = false;
        }
        field(30; "Salary Processed"; Boolean)
        {
            Caption = 'Processed';
        }
        field(31; "Processed Date"; Date)
        {
            Caption = 'Processed Date';
        }
        field(32; "Journal Batch Name"; Code[20])
        {
            Caption = 'Journal Batch Name';
        }
        field(33; "Journal Template Name"; Code[20])
        {
            Caption = 'Journal Template Name';
        }
        field(34; "Posted Document No"; Code[20])
        {
            Caption = 'Posted Document No';
        }
        field(35; "Posted Date"; Date)
        {
            Caption = 'Posted Date';
        }
        field(36; Posted; Boolean)
        {
            Caption = 'Posted';
        }
        field(37; Paid; Boolean)
        {
            Caption = 'Paid';
        }
        field(38; "Account Type"; Option)
        {
            Caption = 'Account Type';
            OptionCaption = 'G/L Account,Customer,Vendor,Bank Account,Fixed Asset,IC Partner';
            OptionMembers = "G/L Account",Customer,Vendor,"Bank Account","Fixed Asset","IC Partner";
        }
        field(39; "Pay Method"; Option)
        {
            Caption = 'Pay Method';
            OptionCaption = 'Cash,Cheque,Bank Transfer';
            OptionMembers = Cash,Cheque,"Bank Transfer";
        }
        field(40; "Cheque No."; Code[20])
        {
            Caption = 'Cheque No.';
        }
        field(41; "Cheque Date"; Date)
        {
            Caption = 'Cheque Date';
        }
        field(42; "Account No."; Code[20])
        {
            Caption = 'Account No.';
            TableRelation = IF ("Account Type" = CONST ("G/L Account")) "G/L Account"
            ELSE
            IF ("Account Type" = CONST (Customer)) Customer
            ELSE
            IF ("Account Type" = CONST (Vendor)) Vendor
            ELSE
            IF ("Account Type" = CONST ("Bank Account")) "Bank Account"
            ELSE
            IF ("Account Type" = CONST ("Fixed Asset")) "Fixed Asset"
            ELSE
            IF ("Account Type" = CONST ("IC Partner")) "IC Partner";
        }
        field(43; Blocked; Boolean)
        {
            Caption = 'Blocked';
        }
        field(44; "I Payment Document No."; Code[20])
        {
            Caption = 'I Payment Document No.';
        }
        field(45; "I Payment Date"; Date)
        {
            Caption = 'I Payment Date';
        }
        field(46; "Stop Payment"; Boolean)
        {
            Caption = 'Stop Payment';
        }
        field(47; "Date Filter"; Date)
        {
            Caption = 'Date Filter';
            FieldClass = FlowFilter;
        }
        field(48; "Total Permission In Mins"; Decimal)
        {
            CalcFormula = Sum ("Daily Attendance"."Total Permission In Mins" WHERE ("Location Code" = FIELD ("Location Code"),
                                                                                   "Salary Plan Code" = FIELD ("Salary Plan Code"),
                                                                                   "Salary Cyclic Code" = FIELD ("Salary Cycle Code"),
                                                                                   "Employee No" = FIELD ("Employee No"),
                                                                                   "Total Permission In Mins" = FILTER (<> 0)));
            Caption = 'Total Permission In Mins';
            Editable = false;
            FieldClass = FlowField;
        }
        field(49; "Credit Days"; Decimal)
        {
            Caption = 'Credit Days';
        }
        field(50; "First Net Amount"; Decimal)
        {
            Caption = 'First Net Amount';
            Editable = false;
        }
        field(51; "Second Net Amount"; Decimal)
        {
            Caption = 'Second Net Amount';
            Editable = false;
        }
        field(52; "Payment Type"; Option)
        {
            Caption = 'Payment Type';
            OptionCaption = 'Full Payment,First Payment,Second Payment';
            OptionMembers = "Full Payment","First Payment","Second Payment";
        }
        field(53; "Employee Category"; Option)
        {
            Caption = 'Employee Category';
            OptionCaption = ' ,Staff Permanent,Staff Temporary,Class IV Permanent,Class IV Temporary,Class III Permanent,Class III Temporary';
            OptionMembers = " ","Staff Permanent","Staff Temporary","Class IV Permanent","Class IV Temporary","Class III Permanent","Class III Temporary";
        }
        field(54; "Lay Off"; Decimal)
        {
            CalcFormula = Sum ("Daily Attendance"."Lay Off" WHERE ("Location Code" = FIELD ("Location Code"),
                                                                  "Salary Plan Code" = FIELD ("Salary Plan Code"),
                                                                  "Salary Cyclic Code" = FIELD ("Salary Cycle Code"),
                                                                  "Employee No" = FIELD ("Employee No"),
                                                                  "Lay Off" = FILTER (<> 0)));
            Caption = 'Lay Off';
            Editable = false;
            FieldClass = FlowField;
        }
        field(55; "Total Perm. Hours"; Decimal)
        {
            Caption = 'Total Perm. Hours';
            Editable = false;
        }
        field(56; "Total Over Time Hours"; Decimal)
        {
            Caption = 'Total Over Time Hours';
            Editable = false;
        }
        field(57; "Manual LOP Days"; Decimal)
        {
            MaxValue = 31;
            MinValue = 0;
        }
        field(58; "Total Days Count"; Integer)
        {
            CalcFormula = Count ("Daily Attendance" WHERE ("Location Code" = FIELD ("Location Code"),
                                                          "Salary Plan Code" = FIELD ("Salary Plan Code"),
                                                          "Salary Cyclic Code" = FIELD ("Salary Cycle Code"),
                                                          "Employee No" = FIELD ("Employee No")));
            Caption = 'Total Days Count';
            Editable = false;
            FieldClass = FlowField;
        }
        field(59; "II Payment Document No."; Code[20])
        {
            Caption = 'II Payment Document No.';
        }
        field(60; "II Payment Date"; Date)
        {
            Caption = 'II Payment Date';
        }
        field(61; "Branch Code"; Code[10])
        {
            Caption = 'Branch Code';
        }
        field(62; "Manual Total Days Worked"; Decimal)
        {
            Caption = 'Manual Total Days Worked';
            Editable = false;
        }
        field(63; "Negative Pay"; Boolean)
        {
            Caption = 'Negative Pay';
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

