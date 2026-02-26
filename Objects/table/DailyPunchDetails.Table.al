table 72028 "Daily Punch Details"
{
    Caption = 'Daily Punch Details';
    DataClassification = CustomerContent;
    LookupPageId = "Daily Punch Details List";

    fields
    {
        field(1; "Location Code"; Code[20])
        {
            Caption = 'Location Code';
            TableRelation = "Location HR & Payroll Setup";
            DataClassification = CustomerContent;
        }
        field(2; "Salary Plan Code"; Code[20])
        {
            Caption = 'Salary Plan Code';
            DataClassification = CustomerContent;
            TableRelation = "Salary Plan";
        }
        field(3; "Salary Cyclic Code"; Code[20])
        {
            Caption = 'Salary Cyclic Code';
            DataClassification = CustomerContent;
            TableRelation = "Payroll Month & Year"."Salary Cyclic Code" WHERE("Location Code" = FIELD("Location Code"),
                                                                               "Salary Plan Code" = FIELD("Salary Plan Code"));
        }
        field(4; "Employee No."; Code[20])
        {
            Caption = 'Employee No.';
            TableRelation = Employee;
            DataClassification = CustomerContent;

            trigger OnValidate()
            begin
                if Employee.Get("Employee No.") then begin
                    Name := Employee."First Name" + ' ' + Employee.Initials;
                    "Department Code" := Employee."Department Code";
                    "Department Name" := Employee."Department Name";
                end;
            end;
        }
        field(5; "Attendance Date"; Date)
        {
            Caption = 'Attendance Date';
            DataClassification = CustomerContent;
        }
        field(6; "Line No."; Integer)
        {
            Caption = 'Line No.';
            DataClassification = CustomerContent;
        }
        field(7; Name; Text[100])
        {
            Caption = 'Name';
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(8; "In Punch DateTime"; DateTime)
        {
            Caption = 'In Punch DateTime';
            DataClassification = CustomerContent;

            trigger OnValidate()
            begin
                Validate("Out Punch DateTime");
            end;
        }
        field(9; "Out Punch DateTime"; DateTime)
        {
            Caption = 'Out Punch DateTime';
            DataClassification = CustomerContent;

            trigger OnValidate()
            begin
                if "Out Punch DateTime" <> 0DT then begin
                    "Total Hours In Mins" := ("Out Punch DateTime" - "In Punch DateTime") / 60000;
                    "Total Hours" := "Convert Mins To Hours"("Total Hours In Mins");
                end;
            end;
        }
        field(10; "Total Hours In Mins"; Decimal)
        {
            Caption = 'Total Hours In Mins';
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(11; "Total Hours"; Decimal)
        {
            Caption = 'Total Hours';
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(12; "No of Pieces"; Decimal)
        {
            Caption = 'No of Pieces';
            DataClassification = CustomerContent;
        }
        field(13; "Department Code"; Code[10])
        {
            Caption = 'Department Code';
            TableRelation = Departments;
            DataClassification = CustomerContent;

            trigger OnValidate()
            begin
                if Departments.Get("Department Code") then
                    "Department Name" := Departments.Description
                else
                    "Department Name" := '';
            end;
        }
        field(14; "Department Name"; Text[50])
        {
            Caption = 'Department Name';
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(15; "Attendance Verified"; Boolean)
        {
            Caption = 'Attendance Verified';
            DataClassification = CustomerContent;
        }
    }

    keys
    {
        key(Key1; "Location Code", "Salary Plan Code", "Salary Cyclic Code", "Employee No.", "Attendance Date", "Line No.")
        {
            Clustered = true;
            SumIndexFields = "Total Hours In Mins";
        }
    }

    fieldgroups
    {
    }

    var
        Employee: Record Employee;
        Departments: Record Departments;


    procedure "Convert Mins To Hours"(TotalHrsMins: Decimal): Decimal
    var
        ConvertHours: Decimal;
        DecimalPart: Decimal;
        IntegerPart: Integer;
    begin
        Clear(ConvertHours);
        Clear(DecimalPart);
        Clear(IntegerPart);
        DecimalPart := TotalHrsMins mod 60;
        IntegerPart := TotalHrsMins - DecimalPart;
        IntegerPart := IntegerPart / 60;
        ConvertHours := IntegerPart + (DecimalPart / 100);
        exit(ConvertHours);
    end;

    procedure "Convert Hours To Mins"(TotalHrsMins: Decimal): Decimal
    var
        ConvertHours: Decimal;
        DecimalPart: Decimal;
        IntegerPart: Integer;
    begin
        Clear(ConvertHours);
        Clear(DecimalPart);
        Clear(IntegerPart);
        ConvertHours := TotalHrsMins * 100;
        DecimalPart := ConvertHours mod 100;
        DecimalPart := DecimalPart / 100;
        IntegerPart := TotalHrsMins - DecimalPart;
        ConvertHours := (IntegerPart * 60) + (DecimalPart * 100);
        exit(ConvertHours);
    end;
}

