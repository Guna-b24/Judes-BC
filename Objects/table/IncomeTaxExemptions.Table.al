table 72103 "Income Tax Exemptions"
{
    LookupPageId = "Income Tax Exemptions List";
    fields
    {
        field(1; "Employee No."; Code[20])
        {
            TableRelation = Employee."No.";

            trigger OnValidate()
            begin
                if EmplR.Get("Employee No.") then
                    Name := EmplR."First Name";
            end;
        }
        field(2; Name; Text[50])
        {
        }
        field(3; "Excemption Type"; Option)
        {
            OptionCaption = ' ,Rent Paid,Insurance,Medical Bill,Loan Principle,Loan Interest,Donation,Rent Received,Transport Conveyance';
            OptionMembers = " ","Rent Paid",Insurance,"Medical Bill","Loan Principle","Loan Interest",Donation,"Rent Received","Transport Conveyance";
        }
        field(4; "Line No."; Integer)
        {
        }
        field(5; "Exemption No."; Code[20])
        {
        }
        field(6; Details; Text[250])
        {
        }
        field(7; Amount; Decimal)
        {
        }
        field(8; "Metro/Non Metro"; Option)
        {
            OptionCaption = 'Metro,Non Metro';
            OptionMembers = Metro,"Non Metro";
        }
        field(9; "Location Code"; Code[20])
        {
        }
        field(10; "Salary Plan Code"; Code[20])
        {
            TableRelation = "Salary Plan";
        }
        field(11; "Salary Year Code"; Code[20])
        {
        }
        field(12; "Payroll Start Date"; Date)
        {
        }
        field(13; "Payroll End Date"; Date)
        {
        }
        field(14; Year; Integer)
        {
        }
        field(15; Month; Integer)
        {
        }
        field(16; "Created Date"; Date)
        {
        }
        field(18; "Effective Date"; Date)
        {
        }
    }

    keys
    {
        key(Key1; "Employee No.", "Location Code", "Salary Plan Code", "Salary Year Code", "Effective Date", "Line No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    var
        EmplR: Record Employee;
}

