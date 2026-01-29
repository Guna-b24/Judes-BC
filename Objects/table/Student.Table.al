table 71046 Student
{
    // No   Date      Sign     Trigger                       Description
    // -----------------------------------------------------------------------------------------------
    // 01  26/09/09   KATHIR   OnInsert()                          Code added to generate number series
    // 02  26/09/09   KATHIR   DateOfBirth-OnValidate()            Code added to Calculate the Age
    // 03  26/09/09   KATHIR   City - OnValidate()                 Code added to Validate CIty
    // 04  26/06/09   KATHIR   City - OnLookup()                   Code added to Lookup City
    // 05  26/09/09   KATHIR   Post Code - OnValidate()            Code added to Validate PostCode
    // 06  26/09/09   KATHIR   Post Code - Onlookup()              Code added to Lookup Post Code
    // 07  26/09/09   KATHIR   Enquiry No. - OnValidate()          Code added to Transfer all fields from enquiry to application
    // 08  26/09/09   KATHIR   Assistedit()                        Code added to generate number series
    // 09  26/09/09   KATHIR   No. - OnValidate()                  Code added to generate number series
    // 10  19/10/09   VANDHANA OnInsert                            Code to assign User ID.
    // 11  16/11/09   VIGNESH                                      New fields Dimensions & Date of Leaving is added
    // 12  23/11/09   VIGNESH  Class - OnValidate()                Code added to get the Class Section & Curriculum
    // 13  23/11/09   VIGNESH  Class - OnLookup()                  Code added to get the Class Section & Curriculum
    // 14  23/11/09   VIGNESH  Curriculum - OnValidate()           Code added to get the Class Section & Curriculum
    // 15  23/11/09   VIGNESH  Curriculum - OnLookup()             Code added to get the Class Section & Curriculum
    // 16  23/11/09   VIGNESH  Section - OnValidate()              Code added to get the Class Section & Curriculum
    // 17  23/11/09   VIGNESH  Section - OnLookup()                Code added to get the Class Section & Curriculum
    // 18  14/12/19   VIGNESH                                      New Fields "Room Type" and "Mess" is added for Hostel & Mess Mng
    // 19  13/1/10    KAVITHA                                      Added new fields CGPA and CGPA Grade .
    // 20  20/1/10    Ankesh                                       Added new fields Latest GPA and Latest Grade And Latest Rank.

    Caption = 'Student';
    DataPerCompany = false;
    DrillDownPageID = 71047;
    LookupPageID = 71047;

    fields
    {
        field(1; "No."; Code[20])
        {
            Caption = 'No.';

            trigger OnValidate()
            begin
                // Start 09.KATHIR
                if "No." <> xRec."No." then begin
                    AdmissionSetup.Get;
                    NoSeriesMgt.TestManual(AdmissionSetup."Student No.");
                    "No. Series" := '';
                end;
                // Start 09.KATHIR
            end;
        }
        field(2; Name; Text[30])
        {
            Caption = 'Name';
            Editable = true;

            trigger OnValidate()
            var
                ContBusRel: Record "Contact Business Relation";
                Cust: Record Customer;
                Vend: Record Vendor;
            begin
            end;
        }
        field(3; Gender; Option)
        {
            Caption = 'Gender';
            OptionCaption = ' ,Male,Female';
            OptionMembers = " ",Male,Female;
        }
        field(9; "Date Of Birth"; Date)
        {
            Caption = 'Date Of Birth';

            trigger OnValidate()
            begin
                // Start 02.KATHIR
                if "Date Of Birth" <> 0D then begin
                    Age := Today - "Date Of Birth";
                    TempAge := Round(Age / 365, 1, '=');
                    Age2 := Age mod 365;
                    Months := Round(Age2 / 30, 1, '=');
                    Age := TempAge - 1;
                end else begin
                    Clear(Age);
                    Clear(Months);
                end;
                // Stop 02.KATHIR
            end;
        }
        field(10; "Father's Name"; Text[100])
        {
            Caption = 'Father''s Name';
        }
        field(11; "Mother's Name"; Text[100])
        {
            Caption = 'Mother''s Name';
        }
        field(12; Citizenship; Code[20])
        {
            Caption = 'Citizenship';
            TableRelation = Citizenship;
        }
        field(13; "Academic Year"; Code[10])
        {
            Caption = 'Academic Year';
            Editable = true;
        }
        field(15; Class; Code[10])
        {
            Caption = 'Class';
            Editable = true;
        }
        field(16; "Hostel Acommodation"; Boolean)
        {
            Caption = 'Hostel Acommodation';
        }
        field(17; "Previous School"; Text[150])
        {
            Caption = 'Previous School';
        }
        field(18; "Medium of Instruction"; Code[10])
        {
            Caption = 'Medium of Instruction';
            TableRelation = "Medium of Instruction";
        }
        field(19; "Presently Residing with"; Code[10])
        {
            Caption = 'Presently Residing with';
            TableRelation = Relative;
        }
        field(20; Curriculum; Code[10])
        {
            Caption = 'Curriculum';
            Editable = true;
        }
        field(21; "Previous Class"; Code[10])
        {
            Caption = 'Previous Class';
            TableRelation = Class;
        }
        field(22; "Previous Curriculum"; Code[10])
        {
            Caption = 'Previous Curriculum';
            TableRelation = Curriculum;
        }
        field(23; "Address To"; Code[20])
        {
            Caption = 'Address To';
            TableRelation = Relative;
        }
        field(24; Addressee; Text[100])
        {
            Caption = 'Addressee';
        }
        field(25; Address1; Text[100])
        {
            Caption = 'Address1';
        }
        field(26; Address2; Text[100])
        {
            Caption = 'Address2';
        }
        field(27; City; Text[30])
        {
            Caption = 'City';

            trigger OnLookup()
            begin
                // Start 04.KATHIR
                //Postcode.LookUpCity(City,"Post Code",TRUE);
                // Stop 04.KATHIR
            end;

            trigger OnValidate()
            begin
                // Start 03.KATHIR
                //Postcode.ValidateCity(City,"Post Code");
                // Stop 03.KATHIR
            end;
        }
        field(28; "Post Code"; Code[10])
        {
            Caption = 'Post Code';
            TableRelation = "Post Code";

            trigger OnLookup()
            begin
                // Start 06 .KATHIR
                //Postcode.LookUpPostCode(City,"Post Code",TRUE);
                // Stop 06.KATHIR
            end;

            trigger OnValidate()
            begin
                // Start 05.KATHIR
                //Postcode.ValidatePostCode(City,"Post Code");
                // Stop 05.KATHIR
            end;
        }
        field(29; Country; Code[20])
        {
            Caption = 'Country';
            TableRelation = "Country/Region";
        }
        field(30; "E-Mail Address"; Text[100])
        {
            Caption = 'E-Mail Address';
        }
        field(31; "Mobile Number"; Text[30])
        {
            Caption = 'Mobile Number';
        }
        field(32; "Phone Number"; Text[30])
        {
            Caption = 'Phone Number';
        }
        field(33; State; Code[20])
        {
            Caption = 'State';
        }
        field(37; "Visa Exp Date"; Date)
        {
            Caption = 'Visa Exp Date';
        }
        field(38; "Passport No."; Text[20])
        {
            Caption = 'Passport No.';
        }
        field(39; "Passport Exp Date"; Date)
        {
            Caption = 'Passport Exp Date';
        }
        field(40; "Visa No."; Text[20])
        {
            Caption = 'Visa No.';
        }
        field(49; "Food Habits"; Option)
        {
            Caption = 'Food Habits';
            OptionCaption = ' ,Veg,Non Veg';
            OptionMembers = " ",Veg,"Non Veg";
        }
        field(50; "Applicant Image"; BLOB)
        {
            Caption = 'Applicant Image';
        }
        field(51; "Father Image"; BLOB)
        {
            Caption = 'Father Image';
        }
        field(52; "Mother Image"; BLOB)
        {
            Caption = 'Mother Image';
        }
        field(53; "Guardian Image"; BLOB)
        {
            Caption = 'Guardian Image';
        }
        field(54; "Mother's Qualification"; Text[30])
        {
            Caption = 'Mother''s Qualification';
        }
        field(55; "Mother's Occupation"; Text[30])
        {
            Caption = 'Mother''s Occupation';
        }
        field(56; "Guardian Name"; Text[100])
        {
            Caption = 'Guardian Name';
        }
        field(60; "Promotion Granted"; Boolean)
        {
            Caption = 'Promotion Granted';
        }
        field(70; "Father's Occupation"; Text[30])
        {
            Caption = 'Father''s Occupation';
        }
        field(71; "Mother's Annual Income"; Decimal)
        {
            Caption = 'Mother''s Annual Income';
        }
        field(72; "Guardian Qualification"; Text[30])
        {
            Caption = 'Guardian Qualification';
        }
        field(73; "Guardian Occupation"; Text[30])
        {
            Caption = 'Guardian Occupation';
        }
        field(74; "Guardian Annual Income"; Decimal)
        {
            Caption = 'Guardian Annual Income';
        }
        field(76; "Enquiry No."; Code[10])
        {
            Caption = 'Enquiry No.';
            TableRelation = Enquiry;

            trigger OnValidate()
            begin
                // Start 07.KATHIR
                if Enquiry.Get("Enquiry No.") then begin
                    TransferFields(Enquiry);
                    Validate("Date Of Birth");
                    Validate(Class);
                    "No." := xRec."No.";
                end;
                // Stop 07.KATHIR
            end;
        }
        field(77; Religion; Code[20])
        {
            Caption = 'Religion';
            TableRelation = Religion.Code;
        }
        field(78; "Father's Qualification"; Text[30])
        {
            Caption = 'Father''s Qualification';
        }
        field(79; Caste; Code[20])
        {
            Caption = 'Caste';
        }
        field(81; Age; Integer)
        {
            BlankZero = true;
            Caption = 'Age';
            Editable = false;
        }
        field(82; Months; Integer)
        {
            BlankZero = true;
            Caption = 'Months';
            Editable = false;
        }
        field(96; "Father's Annual Income"; Decimal)
        {
            Caption = 'Father''s Annual Income';
        }
        field(97; "Exam Code"; Code[10])
        {
            Caption = 'Exam Code';
            TableRelation = "Exam Code";
        }
        field(98; Community; Code[10])
        {
            Caption = 'Community';
            TableRelation = Community;
        }
        field(99; "Mother Tongue"; Code[10])
        {
            Caption = 'Mother Tongue';
            TableRelation = "Mother Tongue";
        }
        field(100; "New Student"; Boolean)
        {
            Caption = 'New Student';
            Editable = true;
        }
        field(1000; Section; Code[10])
        {
            Caption = 'Section';
            Editable = true;
        }
        field(1001; "Student Status"; Option)
        {
            Caption = 'Student Status';
            OptionCaption = ' ,Student,Inactive,Alumni';
            OptionMembers = " ",Student,Inactive,Alumni;

            trigger OnValidate()
            begin
                //mani - Start
                if "Student Status" = "Student Status"::Inactive then begin
                    Customer.Get("No.");
                    Customer.Blocked := Customer.Blocked::All;
                    Customer.Modify;
                end;

                if "Student Status" = "Student Status"::Student then begin
                    Customer.Get("No.");
                    Customer.Blocked := Customer.Blocked::" ";
                    Customer.Modify;
                end;
                //Mani - Stop

                //Muthu
                if "Student Status" <> "Student Status"::Student then begin
                    if RecPortalUsers.Get("No.") then
                        RecPortalUsers.Delete;

                    if RecPortalUsers.Get("No." + 'P') then
                        RecPortalUsers.Delete;

                end;
                //Muthu
            end;
        }
        field(1002; "Class Code"; Code[20])
        {
            Caption = 'Class Code';
            TableRelation = "Class Section";
        }
        field(2000; "Address 3"; Text[100])
        {
            Caption = 'Address 3';
        }
        field(2001; House; Code[20])
        {
            Caption = 'House';
            TableRelation = House;
        }
        field(2002; Points; Decimal)
        {
            CalcFormula = Sum ("Participant Entry Line".Points WHERE ("Student No." = FIELD ("No."),
                                                                     "Academic Year" = FIELD ("Academic Year"),
                                                                     "Update Results" = FILTER (true)));
            Caption = 'Points';
            Editable = false;
            FieldClass = FlowField;
        }
        field(10001; "Fee Classification"; Code[10])
        {
            Caption = 'Fee Classification';
            TableRelation = "Fee Classification";
        }
        field(10002; Quota; Code[10])
        {
            Caption = 'Quota';
            TableRelation = Quota;
        }
        field(10003; "Physically Challanged"; Boolean)
        {
            Caption = 'Physically Challanged';
        }
        field(10004; "Staff Child"; Boolean)
        {
            Caption = 'Staff Child';
        }
        field(10005; "Staff Code"; Code[20])
        {
            Caption = 'Staff Code';

            trigger OnLookup()
            begin
                Emp.Reset;
                if Emp.FindFirst then
                    if PAGE.RunModal(50058, Emp) = ACTION::LookupOK then begin
                        "Staff Code" := Emp."No.";
                    end;
            end;
        }
        field(20000; "Application No."; Code[20])
        {
            Caption = 'Application No.';
        }
        field(20001; "Date Joined"; Date)
        {
            Caption = 'Date Joined';
        }
        field(20002; "Room No."; Code[20])
        {
            Caption = 'Room No.';
            Editable = false;
        }
        field(20003; "Hostel Code"; Code[20])
        {
            Caption = 'Hostel Code';
            Editable = true;
        }
        field(20004; "Hostel Alloted"; Boolean)
        {
            Caption = 'Hostel Alloted';
        }
        field(20005; "Hostel Vacated"; Boolean)
        {
            Caption = 'Hostel Vacated';
        }
        field(20006; "Room Type"; Code[20])
        {
            Caption = 'Room Type';
            Editable = false;
        }
        field(20007; Mess; Code[20])
        {
            Caption = 'Mess';
            Editable = false;
        }
        field(20009; CGPA; Decimal)
        {
            CalcFormula = Average ("Marks Line".Points WHERE ("Academic Year" = FIELD ("Academic Year"),
                                                             Class = FIELD (Class),
                                                             Section = FIELD (Section),
                                                             Curriculum = FIELD (Curriculum),
                                                             "Student No." = FIELD ("No.")));
            Caption = 'CGPA';
            Editable = false;
            FieldClass = FlowField;
        }
        field(20010; "CGPA Grade"; Code[10])
        {
            Caption = 'CGPA Grade';
        }
        field(20011; "Latest Rank"; Integer)
        {
            Caption = 'Latest Rank';
        }
        field(20012; "Latest GPA"; Decimal)
        {
            Caption = 'Latest GPA';
        }
        field(20013; "Latest Grade"; Code[20])
        {
            Caption = 'Latest Grade';
        }
        field(20014; "Student Image"; Text[100])
        {
            Caption = 'Student Image';
        }
        field(20015; "Name 2"; Text[50])
        {
        }
        field(20016; "Blood Group"; Code[20])
        {
        }
        field(20017; "Medical History"; Text[100])
        {
        }
        field(30000; "No. Series"; Code[20])
        {
            Caption = 'No. Series';
        }
        field(60000; Height; Decimal)
        {
            BlankZero = true;
            Caption = 'Height';
        }
        field(60001; Weight; Decimal)
        {
            BlankZero = true;
            Caption = 'Weight';
        }
        field(60002; Division; Code[20])
        {
            CalcFormula = Lookup (KeyStages."Divison Code" WHERE (Code = FIELD (Class)));
            Caption = 'Division';
            Editable = false;
            FieldClass = FlowField;
        }
        field(60003; "Date of Leaving"; Date)
        {
            Caption = 'Date of Leaving';
        }
        field(60004; "Acad. Year"; Code[10])
        {

            trigger OnValidate()
            begin
                "Academic Year" := "Acad. Year";
            end;
        }
        field(70000; "Second Language"; Option)
        {
            OptionCaption = ' ,Tamil,Hindi,Telugu,Malayalam,Kannada,French,Thai';
            OptionMembers = " ",Tamil,Hindi,Telugu,Malayalam,Kannada,French,Thai;
        }
        field(70001; "Thai Student"; Boolean)
        {
        }
        field(70008; Group; Option)
        {
            OptionCaption = ' ,Group A,Group B,Group C,Group D,Group E,Group F';
            OptionMembers = " ","Group A","Group B","Group C","Group D","Group E","Group F";
        }
        field(70009; "Tour Code"; Code[20])
        {
            TableRelation = "Dimension Value".Code WHERE ("Dimension Code" = FILTER ('TOUR'));
        }
        field(70010; "Computer Opt. Course"; Code[20])
        {
            TableRelation = "Dimension Value".Code WHERE ("Dimension Code" = FILTER ('OPCOURSE'));
        }
        field(70015; "Subject Group"; Code[20])
        {
            TableRelation = "Class Group";
        }
        field(70016; Certificate1; Text[100])
        {
        }
        field(70017; Certificate2; Text[100])
        {
        }
        field(70120; "User ID"; Code[20])
        {
            Caption = 'User ID';
        }
        field(70121; "Portal ID"; Code[20])
        {
            Caption = 'Portal ID';
        }
        field(70785; "Family Code"; Code[20])
        {
            Caption = 'Family Code';
            TableRelation = "Family Code";
        }
        field(70786; Campus_1; Option)
        {
            Caption = 'Campus';
            OptionCaption = ' ,MontFord,West Brooke';
            OptionMembers = " ",MontFord,"West Brooke";

            trigger OnValidate()
            begin
                if Campus_1 = Campus_1::MontFord then
                    Campus := 'MF';
                if Campus_1 = Campus_1::"West Brooke" then
                    Campus := 'WB';
                if Campus_1 = 0 then
                    Campus := ' ';
            end;
        }
        field(70787; Portfolio; Code[50])
        {
            TableRelation = "Piece Rate Header";
        }
        field(70788; Campus; Code[10])
        {
        }
        field(80000; "Orig Academic Year"; Code[10])
        {
        }
        field(80001; "Orig Class Code"; Code[20])
        {
        }
        field(80002; "Extra Tuition"; Boolean)
        {
        }
        field(80003; "Father's DOB"; Date)
        {
        }
        field(80004; "Mother's DOB"; Date)
        {
        }
        field(80005; "Student email"; Text[30])
        {
        }
        field(80010; "Academic Points"; Decimal)
        {
            CalcFormula = Sum ("Academic Points".Points WHERE ("Student No." = FIELD ("No."),
                                                              "Academic Year" = FIELD ("Academic Year")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(80011; "Appraisal Point"; Decimal)
        {
            Editable = false;
        }
        field(80012; "Old Class Code"; Code[20])
        {
        }
    }

    keys
    {
        key(Key1; "No.")
        {
            Clustered = true;
        }
        key(Key2; Class, Curriculum, "Academic Year")
        {
        }
        key(Key3; Class, Section, Curriculum, "Academic Year")
        {
        }
        key(Key4; "Academic Year", "Student Status")
        {
        }
        key(Key5; House)
        {
        }
        key(Key6; "Class Code")
        {
        }
        key(Key7; Gender, Name)
        {
        }
        key(Key8; Gender, Class, Section)
        {
        }
        key(Key9; Name)
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    begin
        // Start 01.KATHIR
        AdmissionSetup.Get;
        if "No. Series" = '' then begin
            AdmissionSetup.TestField("Student No.");
            NoSeriesMgt.InitSeries(AdmissionSetup."Student No.", xRec."No. Series", 0D, "No.", "No. Series");
        end;
        // Stop 01.KATHIR
        // Start 10. VANDHANA
        "User ID" := UserId;
        // Stop 10. VANDHANA
    end;

    var
        Postcode: Record "Post Code";
        EduVertical: Codeunit "Education Vertical";
        AdmissionSetup: Record "Admission Setup";
        NoSeriesMgt: Codeunit NoSeriesManagement;
        Enquiry: Record Enquiry;
        RecApp: Record Application;
        Age2: Decimal;
        TempAge: Decimal;
        AdmSetup: Record "Admission Setup";
        Classrec: Record Class;
        Student: Record Student;
        ClassSectionLook: Record "Class Section";
        ClassCardLook: Record "Class Card";
        Emp: Record Employee;
        Customer: Record Customer;
        RecPortalUsers: Record "Portal Users";

    [Scope('Internal')]
    procedure Assistedit(OldStudent: Record Student): Boolean
    begin
        // Start 08.KATHIR
        with OldStudent do begin
            OldStudent := Rec;
            AdmissionSetup.Get;
            AdmissionSetup.TestField("Student No.");
            if NoSeriesMgt.SelectSeries(AdmissionSetup."Student No.", OldStudent."No. Series", "No. Series") then begin
                NoSeriesMgt.SetSeries("No.");
                Rec := OldStudent;
                exit(true);
            end;
        end;
        // Stop 08.KATHIR
    end;
}

