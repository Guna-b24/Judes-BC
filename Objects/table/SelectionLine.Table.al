table 72015 "Selection Line"
{
    // -----------------------------------------------------------------------------------------------
    // Firstware Sofware Solutions : Project Name : HR & PAYROLL
    // -----------------------------------------------------------------------------------------------
    // No.  Date          Developer     Spec/CU/CR      Description
    // -----------------------------------------------------------------------------------------------
    // 1    04.APR.2009   SENTHIL                       New Tables Added for HR Module.

    Caption = 'Selection Line';

    fields
    {
        field(1; No; Code[20])
        {
            Caption = 'No';
        }
        field(2; "Indenting No."; Code[20])
        {
            Caption = 'Indenting No.';
        }
        field(3; "Indenting Dept Code"; Code[10])
        {
            Caption = 'Indenting DeptCode';
        }
        field(4; "Indenting Desig Code"; Code[10])
        {
            Caption = 'Indenting Desig Code';
        }
        field(5; "Resume No"; Code[20])
        {
            Caption = 'Resume No';
        }
        field(6; "Line No"; Integer)
        {
            Caption = 'Line No';
        }
        field(7; "First Name"; Text[30])
        {
            Caption = 'First Name';
        }
        field(8; "Middle Name"; Text[30])
        {
            Caption = 'Middle Name';
        }
        field(9; "Last Name"; Text[30])
        {
            Caption = 'Last Name';
        }
        field(10; "Address 1"; Text[30])
        {
            Caption = 'Address 1';
        }
        field(11; "Address 2"; Text[30])
        {
            Caption = 'Address 2';
        }
        field(12; "Post Code"; Code[10])
        {
            Caption = 'Post Code';
            TableRelation = "Post Code";
        }
        field(13; City; Text[30])
        {
            Caption = 'City';
        }
        field(14; State; Code[10])
        {
            Caption = 'State';
        }
        field(15; Country; Code[10])
        {
            Caption = 'Country';
            TableRelation = "Country/Region";
        }
        field(16; Nationality; Text[30])
        {
            Caption = 'Nationality';
        }
        field(17; Religion; Text[30])
        {
            Caption = 'Religion';
        }
        field(18; "Father Name"; Text[30])
        {
            Caption = 'Father Name';
        }
        field(19; "Date of Birth"; Date)
        {
            Caption = 'Date of Birth';
        }
        field(20; Age; Integer)
        {
            Caption = 'Age';
        }
        field(21; Gender; Option)
        {
            Caption = 'Gender';
            OptionCaption = ' ,Female,Male';
            OptionMembers = " ",Female,Male;
        }
        field(22; "Marital Status"; Option)
        {
            Caption = 'Marital Status';
            OptionCaption = ' ,Married,UnMarried';
            OptionMembers = " ",Married,UnMarried;
        }
        field(23; "Phone No"; Text[30])
        {
            Caption = 'Phone No';
        }
        field(24; "Mobile No"; Text[30])
        {
            Caption = 'Mobile No';
        }
        field(25; "E-Mail"; Text[50])
        {
            Caption = 'E-Mail';
        }
        field(26; "Previous Working Company"; Text[250])
        {
            Caption = 'Previous Working Company';
        }
        field(27; Designation; Text[250])
        {
            Caption = 'Designation';
            TableRelation = Designation;
        }
        field(28; "Experience(In Yrs)"; Text[50])
        {
            Caption = 'Experience(In Yrs)';
        }
        field(29; "From Date"; Date)
        {
            Caption = 'From Date';
        }
        field(30; "To Date"; Date)
        {
            Caption = 'To Date';
        }
        field(31; Description; Text[250])
        {
            Caption = 'Description';
        }
        field(32; "Current CTC"; Decimal)
        {
            Caption = 'Current CTC';
        }
        field(33; "Expected CTC"; Decimal)
        {
            Caption = 'Expected CTC';
        }
        field(34; Qualification; Text[200])
        {
            Caption = 'Qualification';
            TableRelation = Qualification;
        }
        field(35; University; Text[200])
        {
            Caption = 'University';
        }
        field(36; "From Year on Date"; Text[200])
        {
            Caption = 'From Year on Date';
        }
        field(37; "To Year on Date"; Text[200])
        {
            Caption = 'To Year on Date';
        }
        field(38; Reference; Text[100])
        {
            Caption = 'Reference';
        }
        field(39; "No. Series"; Code[10])
        {
            Caption = 'No. Series';
        }
        field(40; "Attachment 1"; Text[100])
        {
            Caption = 'Attachment 1';
        }
        field(41; "Attachment 2"; Text[100])
        {
            Caption = 'Attachment 2';
        }
        field(42; "Date of Entry"; Date)
        {
            Caption = 'Date of Entry';
            Editable = false;
        }
        field(43; "Tot_Experience(In Yrs)"; Decimal)
        {
            Caption = 'Tot_Experience(In Yrs)';
        }
        field(44; Skills; Text[250])
        {
            Caption = 'Skills';
        }
        field(45; Certifications; Text[250])
        {
            Caption = 'Certifications';
        }
        field(46; "Qualification Description"; Text[250])
        {
            Caption = 'Qualification Description';
        }
        field(47; "Qualification Course"; Text[250])
        {
            Caption = 'Qualification Course';
        }
        field(48; "Selected Candidate"; Boolean)
        {
            Caption = 'Selected Candidate';
        }
        field(49; "Notice Period"; Code[10])
        {
            Caption = 'Notice Period';
        }
    }

    keys
    {
        key(Key1; No, "Indenting No.", "Indenting Dept Code", "Indenting Desig Code", "Resume No")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

