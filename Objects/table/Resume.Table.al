table 72013 Resume
{
    // -----------------------------------------------------------------------------------------------
    // Firstware Sofware Solutions : Project Name : HR & PAYROLL
    // -----------------------------------------------------------------------------------------------
    // No.  Date          Developer     Spec/CU/CR      Description
    // -----------------------------------------------------------------------------------------------
    // 1    04.APR.2009   SENTHIL                       New Tables Added for HR Module.

    Caption = 'Resume';
    DataCaptionFields = No, Name;
    DrillDownPageID = 72019;
    LookupPageID = 72019;

    fields
    {
        field(1; No; Code[20])
        {
            Caption = 'No';

            trigger OnValidate()
            begin
                if No <> xRec.No then begin
                    HRSetup.Get;
                    NoSeriesMgt.TestManual(HRSetup."ResumeDB SNo");
                    "No. Series" := '';
                end;
            end;
        }
        field(2; Name; Text[30])
        {
            Caption = 'Name';
        }
        field(7; "Post Code"; Code[10])
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
        field(8; City; Text[30])
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
        field(9; State; Code[10])
        {
            Caption = 'State';
        }
        field(10; Country; Code[10])
        {
            Caption = 'Country';
            TableRelation = "Country/Region";
        }
        field(14; "Date of Birth"; Date)
        {
            Caption = 'Date of Birth';

            trigger OnValidate()
            begin
                if "Date of Birth" <> 0D then begin
                    Age := Today - "Date of Birth";
                    TempAge := Round(Age / 365, 1, '=');
                    AgeCalculation := Age mod 365;
                    Months := Round(AgeCalculation / 30, 1, '=');
                    Age := TempAge;
                end;

                if Age <= 19 then
                    Error('Enter the Valid Date of Birth\Because should not accept the below age of 19');
            end;
        }
        field(15; Age; Integer)
        {
            Caption = 'Age';
            Editable = false;
        }
        field(16; Gender; Option)
        {
            Caption = 'Gender';
            OptionCaption = ' ,Female,Male';
            OptionMembers = " ",Female,Male;
        }
        field(18; "Phone No"; Text[30])
        {
            Caption = 'Phone No';
        }
        field(19; "Mobile No"; Text[30])
        {
            Caption = 'Mobile No';
        }
        field(20; "E-Mail"; Text[50])
        {
            Caption = 'E-Mail';
        }
        field(21; "Current CTC"; Decimal)
        {
            Caption = 'Current CTC';
        }
        field(22; "Expected CTC"; Decimal)
        {
            Caption = 'Expected CTC';
        }
        field(24; "No. Series"; Code[10])
        {
            Caption = 'No. Series';
        }
        field(25; "Attachment 1"; Text[100])
        {
            Caption = 'Attachment 1';
        }
        field(26; "Attachment 2"; Text[100])
        {
            Caption = 'Attachment 2';
        }
        field(27; "Submitted Date"; Date)
        {
            Caption = 'Submitted Date';
            Editable = false;
        }
        field(28; "Tot Experience(In Yrs)"; Decimal)
        {
            Caption = 'Tot Experience(In Yrs)';
        }
        field(29; Blocked; Boolean)
        {
            Caption = 'Blocked';
            Editable = false;
        }
        field(30; "Current Employer"; Text[50])
        {
            Caption = 'Current Employer';
        }
        field(31; "Current Experience(In Yrs)"; Decimal)
        {
            Caption = 'Current Experience(In Yrs)';
        }
        field(32; Skills; Code[250])
        {
            Caption = 'Skills';
            TableRelation = Skill;
            ValidateTableRelation = false;
        }
        field(33; Certifications; Code[250])
        {
            Caption = 'Certifications';
            TableRelation = Certification;
            ValidateTableRelation = false;
        }
        field(34; Qualifications; Code[100])
        {
            Caption = 'Qualifications';
            TableRelation = Qualification;
            ValidateTableRelation = false;
        }
        field(35; Comment; Boolean)
        {
            CalcFormula = Exist ("Human Resource Comment Line" WHERE ("Table Name" = CONST ("12"),
                                                                     "No." = FIELD (No)));
            Caption = 'Comment';
            Editable = false;
            FieldClass = FlowField;
        }
        field(36; "Notice Period"; Code[10])
        {
            Caption = 'Notice Period';
        }
    }

    keys
    {
        key(Key1; No)
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    begin
        if No = '' then begin
            HRSetup.Get;
            HRSetup.TestField("ResumeDB SNo");
            NoSeriesMgt.InitSeries(HRSetup."ResumeDB SNo", xRec."No. Series", 0D, No, "No. Series");
        end;

        "Submitted Date" := Today;
    end;

    var
        HRSetup: Record "HR Setup";
        NoSeriesMgt: Codeunit NoSeriesManagement;
        PostCode: Record "Post Code";
        TempAge: Decimal;
        AgeCalculation: Decimal;
        Months: Integer;
        Resume: Record Resume;

    [Scope('Internal')]
    procedure AssistEdit(Resume: Record Resume): Boolean
    begin
        with Resume do begin
            Resume := Rec;
            HRSetup.Get;
            HRSetup.TestField("ResumeDB SNo");
            if NoSeriesMgt.SelectSeries(HRSetup."ResumeDB SNo", "No. Series", "No. Series") then begin
                HRSetup.Get;
                HRSetup.TestField("ResumeDB SNo");
                NoSeriesMgt.SetSeries(No);
                Rec := Resume;
                exit(true);
            end;
        end;
    end;
}

