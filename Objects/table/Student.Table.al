table 71046 Student
{

    Caption = 'Student';
    DataPerCompany = false;
    DataClassification = CustomerContent;
    DrillDownPageID = "Student List";
    LookupPageID = "Student List";

    fields
    {
        field(1; "No."; Code[20])
        {
            Caption = 'No.';
            DataClassification = SystemMetadata;
            ToolTip = 'Specifies the unique student number.';

            trigger OnValidate()
            begin
                if "No." <> xRec."No." then begin
                    AdmissionSetup.Get();
                    NoSeriesMgt.TestManual(AdmissionSetup."Student No.");
                    "No. Series" := '';
                end;
            end;
        }
        field(2; Name; Text[30])
        {
            Caption = 'Name';
            DataClassification = EndUserIdentifiableInformation;
            ToolTip = 'Specifies the full name of the student.';
        }

        field(3; Gender; Option)
        {
            Caption = 'Gender';
            OptionCaption = ' ,Male,Female';
            OptionMembers = " ",Male,Female;
            DataClassification = EndUserIdentifiableInformation;
            ToolTip = 'Specifies the gender of the student.';
        }
        field(9; "Date Of Birth"; Date)
        {
            Caption = 'Date Of Birth';
            DataClassification = EndUserIdentifiableInformation;
            ToolTip = 'Specifies the date of birth of the student.';

            trigger OnValidate()
            begin
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
            end;
        }
        field(10; "Father's Name"; Text[100])
        {
            Caption = 'Father''s Name';
            DataClassification = EndUserIdentifiableInformation;
            ToolTip = 'Specifies the name of the father.';
        }

        field(11; "Mother's Name"; Text[100])
        {
            Caption = 'Mother''s Name';
            DataClassification = EndUserIdentifiableInformation;
            ToolTip = 'Specifies the name of the mother.';
        }

        field(12; Citizenship; Code[20])
        {
            Caption = 'Citizenship';
            TableRelation = Citizenship;
            DataClassification = EndUserIdentifiableInformation;
            ToolTip = 'Specifies the citizenship of the student.';
        }
        field(13; "Academic Year"; Code[10])
        {
            Caption = 'Academic Year';
            DataClassification = CustomerContent;
            ToolTip = 'Specifies the academic year of the student.';
        }

        field(15; Class; Code[10])
        {
            Caption = 'Class';
            DataClassification = CustomerContent;
            ToolTip = 'Specifies the class assigned to the student.';
        }

        field(16; "Hostel Acommodation"; Boolean)
        {
            Caption = 'Hostel Acommodation';
            DataClassification = CustomerContent;
            ToolTip = 'Specifies if hostel accommodation is required.';
        }

        field(17; "Previous School"; Text[150])
        {
            Caption = 'Previous School';
            DataClassification = EndUserIdentifiableInformation;
            ToolTip = 'Specifies the previous school attended by the student.';
        }

        field(18; "Medium of Instruction"; Code[10])
        {
            Caption = 'Medium of Instruction';
            TableRelation = "Medium of Instruction";
            DataClassification = CustomerContent;
            ToolTip = 'Specifies the medium of instruction followed by the student.';
        }

        field(19; "Presently Residing with"; Code[10])
        {
            Caption = 'Presently Residing with';
            TableRelation = Relative;
            DataClassification = EndUserIdentifiableInformation;
            ToolTip = 'Specifies with whom the student is currently residing.';
        }

        field(20; Curriculum; Code[10])
        {
            Caption = 'Curriculum';
            DataClassification = CustomerContent;
            ToolTip = 'Specifies the curriculum followed by the student.';
        }

        field(21; "Previous Class"; Code[10])
        {
            Caption = 'Previous Class';
            TableRelation = Class;
            DataClassification = CustomerContent;
            ToolTip = 'Specifies the previous class completed by the student.';
        }

        field(22; "Previous Curriculum"; Code[10])
        {
            Caption = 'Previous Curriculum';
            TableRelation = Curriculum;
            DataClassification = CustomerContent;
            ToolTip = 'Specifies the previous curriculum followed by the student.';
        }

        field(23; "Address To"; Code[20])
        {
            Caption = 'Address To';
            TableRelation = Relative;
            DataClassification = EndUserIdentifiableInformation;
            ToolTip = 'Specifies the person to whom correspondence is addressed.';
        }

        field(24; Addressee; Text[100])
        {
            Caption = 'Addressee';
            DataClassification = EndUserIdentifiableInformation;
            ToolTip = 'Specifies the name of the addressee for communication.';
        }

        field(25; Address1; Text[100])
        {
            Caption = 'Address1';
            DataClassification = EndUserIdentifiableInformation;
            ToolTip = 'Specifies the primary address of the student.';
        }

        field(26; Address2; Text[100])
        {
            Caption = 'Address2';
            DataClassification = EndUserIdentifiableInformation;
            ToolTip = 'Specifies additional address details.';
        }

        field(27; City; Text[30])
        {
            Caption = 'City';
            DataClassification = EndUserIdentifiableInformation;
            ToolTip = 'Specifies the city of residence.';
        }

        field(28; "Post Code"; Code[10])
        {
            Caption = 'Post Code';
            TableRelation = "Post Code";
            DataClassification = EndUserIdentifiableInformation;
            ToolTip = 'Specifies the postal code.';
        }

        field(29; Country; Code[20])
        {
            Caption = 'Country';
            TableRelation = "Country/Region";
            DataClassification = EndUserIdentifiableInformation;
            ToolTip = 'Specifies the country of residence.';
        }

        field(30; "E-Mail Address"; Text[100])
        {
            Caption = 'E-Mail Address';
            DataClassification = EndUserIdentifiableInformation;
            ToolTip = 'Specifies the email address of the student.';
        }

        field(31; "Mobile Number"; Text[30])
        {
            Caption = 'Mobile Number';
            DataClassification = EndUserIdentifiableInformation;
            ToolTip = 'Specifies the mobile phone number.';
        }

        field(32; "Phone Number"; Text[30])
        {
            Caption = 'Phone Number';
            DataClassification = EndUserIdentifiableInformation;
            ToolTip = 'Specifies the phone number.';
        }
        field(33; State; Code[20])
        {
            Caption = 'State';
            DataClassification = EndUserIdentifiableInformation;
            ToolTip = 'Specifies the state of residence.';
        }
        field(37; "Visa Exp Date"; Date)
        {
            Caption = 'Visa Exp Date';
            DataClassification = EndUserIdentifiableInformation;
            ToolTip = 'Specifies the visa expiry date.';
        }

        field(38; "Passport No."; Text[20])
        {
            Caption = 'Passport No.';
            DataClassification = EndUserIdentifiableInformation;
            ToolTip = 'Specifies the passport number.';
        }

        field(39; "Passport Exp Date"; Date)
        {
            Caption = 'Passport Exp Date';
            DataClassification = EndUserIdentifiableInformation;
            ToolTip = 'Specifies the passport expiry date.';
        }

        field(40; "Visa No."; Text[20])
        {
            Caption = 'Visa No.';
            DataClassification = EndUserIdentifiableInformation;
            ToolTip = 'Specifies the visa number.';
        }
        field(49; "Food Habits"; Option)
        {
            Caption = 'Food Habits';
            OptionCaption = ' ,Veg,Non Veg';
            OptionMembers = " ",Veg,"Non Veg";
            DataClassification = EndUserIdentifiableInformation;
            ToolTip = 'Specifies the food preference of the student.';
        }

        field(50; "Applicant Image"; BLOB)
        {
            Caption = 'Applicant Image';
            DataClassification = EndUserIdentifiableInformation;
            ToolTip = 'Specifies the photograph of the applicant.';
        }

        field(51; "Father Image"; BLOB)
        {
            Caption = 'Father Image';
            DataClassification = EndUserIdentifiableInformation;
            ToolTip = 'Specifies the photograph of the father.';
        }

        field(52; "Mother Image"; BLOB)
        {
            Caption = 'Mother Image';
            DataClassification = EndUserIdentifiableInformation;
            ToolTip = 'Specifies the photograph of the mother.';
        }

        field(53; "Guardian Image"; BLOB)
        {
            Caption = 'Guardian Image';
            DataClassification = EndUserIdentifiableInformation;
            ToolTip = 'Specifies the photograph of the guardian.';
        }
        field(54; "Mother's Qualification"; Text[30])
        {
            Caption = 'Mother''s Qualification';
            DataClassification = EndUserIdentifiableInformation;
            ToolTip = 'Specifies the qualification of the mother.';
        }

        field(55; "Mother's Occupation"; Text[30])
        {
            Caption = 'Mother''s Occupation';
            DataClassification = EndUserIdentifiableInformation;
            ToolTip = 'Specifies the occupation of the mother.';
        }

        field(56; "Guardian Name"; Text[100])
        {
            Caption = 'Guardian Name';
            DataClassification = EndUserIdentifiableInformation;
            ToolTip = 'Specifies the name of the guardian.';
        }

        field(60; "Promotion Granted"; Boolean)
        {
            Caption = 'Promotion Granted';
            DataClassification = CustomerContent;
            ToolTip = 'Specifies whether promotion has been granted to the student.';
        }
        field(70; "Father's Occupation"; Text[30])
        {
            Caption = 'Father''s Occupation';
            DataClassification = EndUserIdentifiableInformation;
            ToolTip = 'Specifies the occupation of the father.';
        }

        field(71; "Mother's Annual Income"; Decimal)
        {
            Caption = 'Mother''s Annual Income';
            DataClassification = EndUserIdentifiableInformation;
            ToolTip = 'Specifies the annual income of the mother.';
        }

        field(72; "Guardian Qualification"; Text[30])
        {
            Caption = 'Guardian Qualification';
            DataClassification = EndUserIdentifiableInformation;
            ToolTip = 'Specifies the qualification of the guardian.';
        }

        field(73; "Guardian Occupation"; Text[30])
        {
            Caption = 'Guardian Occupation';
            DataClassification = EndUserIdentifiableInformation;
            ToolTip = 'Specifies the occupation of the guardian.';
        }

        field(74; "Guardian Annual Income"; Decimal)
        {
            Caption = 'Guardian Annual Income';
            DataClassification = EndUserIdentifiableInformation;
            ToolTip = 'Specifies the annual income of the guardian.';
        }
        field(76; "Enquiry No."; Code[10])
        {
            Caption = 'Enquiry No.';
            TableRelation = Enquiry;
            DataClassification = CustomerContent;
            ToolTip = 'Specifies the enquiry number associated with the student.';


            trigger OnValidate()
            begin
                if Enquiry.Get("Enquiry No.") then begin
                    TransferFields(Enquiry);
                    Validate("Date Of Birth");
                    Validate(Class);
                    "No." := xRec."No.";
                end;
            end;
        }

        field(77; Religion; Code[20])
        {
            Caption = 'Religion';
            TableRelation = Religion.Code;
            DataClassification = EndUserIdentifiableInformation;
            ToolTip = 'Specifies the religion of the student.';
        }

        field(78; "Father's Qualification"; Text[30])
        {
            Caption = 'Father''s Qualification';
            DataClassification = EndUserIdentifiableInformation;
            ToolTip = 'Specifies the qualification of the father.';
        }
        field(79; Caste; Code[20])
        {
            Caption = 'Caste';
            DataClassification = EndUserIdentifiableInformation;
            ToolTip = 'Specifies the caste of the student.';
        }

        field(81; Age; Integer)
        {
            BlankZero = true;
            Caption = 'Age';
            Editable = false;
            DataClassification = EndUserIdentifiableInformation;
            ToolTip = 'Specifies the age of the student.';
        }

        field(82; Months; Integer)
        {
            BlankZero = true;
            Caption = 'Months';
            Editable = false;
            DataClassification = EndUserIdentifiableInformation;
            ToolTip = 'Specifies additional months beyond the completed age in years.';
        }
        field(96; "Father's Annual Income"; Decimal)
        {
            Caption = 'Father''s Annual Income';
            DataClassification = EndUserIdentifiableInformation;
            ToolTip = 'Specifies the annual income of the father.';
        }

        field(97; "Exam Code"; Code[10])
        {
            Caption = 'Exam Code';
            TableRelation = "Exam Code";
            DataClassification = CustomerContent;
            ToolTip = 'Specifies the entrance or qualifying exam code.';
        }

        field(98; Community; Code[10])
        {
            Caption = 'Community';
            TableRelation = Community;
            DataClassification = CustomerContent;
            ToolTip = 'Specifies the community classification.';
        }

        field(99; "Mother Tongue"; Code[10])
        {
            Caption = 'Mother Tongue';
            TableRelation = "Mother Tongue";
            DataClassification = EndUserIdentifiableInformation;
            ToolTip = 'Specifies the mother tongue of the student.';
        }

        field(100; "New Student"; Boolean)
        {
            Caption = 'New Student';
            Editable = true;
            DataClassification = CustomerContent;
            ToolTip = 'Specifies whether the student is newly admitted.';
        }

        field(1000; Section; Code[10])
        {
            Caption = 'Section';
            Editable = true;
            DataClassification = CustomerContent;
            ToolTip = 'Specifies the section assigned to the student.';
        }

        field(1001; "Student Status"; Option)
        {
            Caption = 'Student Status';
            OptionCaption = ' ,Student,Inactive,Alumni';
            OptionMembers = " ",Student,Inactive,Alumni;
            DataClassification = CustomerContent;
            ToolTip = 'Specifies the current status of the student.';

            trigger OnValidate()
            begin

                if "Student Status" = "Student Status"::Inactive then begin
                    Customer.Get("No.");
                    Customer.Blocked := Customer.Blocked::All;
                    Customer.Modify();
                end;

                if "Student Status" = "Student Status"::Student then begin
                    Customer.Get("No.");
                    Customer.Blocked := Customer.Blocked::" ";
                    Customer.Modify();
                end;


                if "Student Status" <> "Student Status"::Student then begin
                    if RecPortalUsers.Get("No.") then
                        RecPortalUsers.Delete();

                    if RecPortalUsers.Get("No." + 'P') then
                        RecPortalUsers.Delete();

                end;
            end;
        }
        field(1002; "Class Code"; Code[20])
        {
            Caption = 'Class Code';
            TableRelation = "Class Section";
            DataClassification = CustomerContent;
            ToolTip = 'Specifies the class section code.';
        }

        field(2000; "Address 3"; Text[100])
        {
            Caption = 'Address 3';
            DataClassification = EndUserIdentifiableInformation;
            ToolTip = 'Specifies additional address details.';
        }

        field(2001; House; Code[20])
        {
            Caption = 'House';
            TableRelation = House;
            DataClassification = CustomerContent;
            ToolTip = 'Specifies the house assigned to the student.';
        }
        field(2002; Points; Decimal)
        {
            CalcFormula = Sum("Participant Entry Line".Points WHERE("Student No." = FIELD("No."),
                                                                     "Academic Year" = FIELD("Academic Year"),
                                                                     "Update Results" = FILTER(true)));
            Caption = 'Points';
            Editable = false;
            FieldClass = FlowField;
        }
        field(10001; "Fee Classification"; Code[10])
        {
            Caption = 'Fee Classification';
            TableRelation = "Fee Classification";
            DataClassification = CustomerContent;
            ToolTip = 'Specifies the fee classification assigned to the student.';
        }

        field(10002; Quota; Code[10])
        {
            Caption = 'Quota';
            //TableRelation = Quota;
            DataClassification = CustomerContent;
            ToolTip = 'Specifies the admission quota of the student.';
        }
        field(10003; "Physically Challanged"; Boolean)
        {
            Caption = 'Physically Challanged';
            DataClassification = EndUserIdentifiableInformation;
            ToolTip = 'Specifies whether the student is physically challenged.';
        }

        field(10004; "Staff Child"; Boolean)
        {
            Caption = 'Staff Child';
            DataClassification = CustomerContent;
            ToolTip = 'Specifies whether the student is a staff member''s child.';
        }

        field(10005; "Staff Code"; Code[20])
        {
            Caption = 'Staff Code';
            DataClassification = CustomerContent;
            ToolTip = 'Specifies the staff member associated with the student.';

            trigger OnLookup()
            begin
                Emp.Reset();
                if Emp.FindFirst() then
                    if PAGE.RunModal(50058, Emp) = ACTION::LookupOK then
                        "Staff Code" := Emp."No.";
            end;
        }
        field(20000; "Application No."; Code[20])
        {
            Caption = 'Application No.';
            DataClassification = CustomerContent;
            ToolTip = 'Specifies the application number of the student.';
        }

        field(20001; "Date Joined"; Date)
        {
            Caption = 'Date Joined';
            DataClassification = CustomerContent;
            ToolTip = 'Specifies the date the student joined the institution.';
        }

        field(20002; "Room No."; Code[20])
        {
            Caption = 'Room No.';
            Editable = false;
            DataClassification = CustomerContent;
            ToolTip = 'Specifies the hostel room number assigned to the student.';
        }
        field(20003; "Hostel Code"; Code[20])
        {
            Caption = 'Hostel Code';
            DataClassification = CustomerContent;
            ToolTip = 'Specifies the hostel assigned to the student.';
        }

        field(20004; "Hostel Alloted"; Boolean)
        {
            Caption = 'Hostel Alloted';
            DataClassification = CustomerContent;
            ToolTip = 'Specifies whether hostel accommodation has been allotted.';
        }

        field(20005; "Hostel Vacated"; Boolean)
        {
            Caption = 'Hostel Vacated';
            DataClassification = CustomerContent;
            ToolTip = 'Specifies whether the student has vacated the hostel.';
        }
        field(20006; "Room Type"; Code[20])
        {
            Caption = 'Room Type';
            DataClassification = CustomerContent;
            ToolTip = 'Specifies the type of hostel room assigned.';
        }

        field(20007; Mess; Code[20])
        {
            Caption = 'Mess';
            DataClassification = CustomerContent;
            ToolTip = 'Specifies the mess facility assigned to the student.';
        }
        field(20009; CGPA; Decimal)
        {
            CalcFormula = Average("Marks Line".Points WHERE("Academic Year" = FIELD("Academic Year"),
                                                             Class = FIELD(Class),
                                                             Section = FIELD(Section),
                                                             Curriculum = FIELD(Curriculum),
                                                             "Student No." = FIELD("No.")));
            Caption = 'CGPA';
            Editable = false;
            FieldClass = FlowField;
        }
        field(20010; "CGPA Grade"; Code[20])
        {
            Caption = 'CGPA Grade';
            DataClassification = CustomerContent;
            ToolTip = 'Specifies the grade corresponding to the CGPA.';
        }

        field(20011; "Latest Rank"; Integer)
        {
            Caption = 'Latest Rank';
            DataClassification = CustomerContent;
            ToolTip = 'Specifies the latest academic rank of the student.';
        }
        field(20012; "Latest GPA"; Decimal)
        {
            Caption = 'Latest GPA';
            DataClassification = CustomerContent;
            ToolTip = 'Specifies the latest grade point average.';
        }

        field(20013; "Latest Grade"; Code[20])
        {
            Caption = 'Latest Grade';
            DataClassification = CustomerContent;
            ToolTip = 'Specifies the latest grade achieved.';
        }

        field(20014; "Student Image"; MediaSet)
        {
            Caption = 'Student Image';
            DataClassification = EndUserIdentifiableInformation;
            ToolTip = 'Specifies the file reference of the student image.';
        }

        field(20015; "Name 2"; Text[50])
        {
            DataClassification = EndUserIdentifiableInformation;
            ToolTip = 'Specifies an additional name of the student.';
        }
        field(20016; "Blood Group"; Code[20])
        {
            DataClassification = EndUserIdentifiableInformation;
            ToolTip = 'Specifies the blood group of the student.';
        }

        field(20017; "Medical History"; Text[100])
        {
            DataClassification = EndUserIdentifiableInformation;
            ToolTip = 'Specifies medical history details of the student.';
        }

        field(30000; "No. Series"; Code[20])
        {
            Caption = 'No. Series';
            DataClassification = SystemMetadata;
            ToolTip = 'Specifies the number series used to assign student numbers.';
        }
        field(60000; Height; Decimal)
        {
            Caption = 'Height';
            DataClassification = EndUserIdentifiableInformation;
            ToolTip = 'Specifies the height of the student.';
        }

        field(60001; Weight; Decimal)
        {
            Caption = 'Weight';
            DataClassification = EndUserIdentifiableInformation;
            ToolTip = 'Specifies the weight of the student.';
        }
        field(60002; Division; Code[20])
        {
            Caption = 'Division';
            Editable = false;
            // FieldClass = FlowField;          
            ToolTip = 'Specifies the academic division of the student.';
        }

        field(60003; "Date of Leaving"; Date)
        {
            Caption = 'Date of Leaving';
            DataClassification = CustomerContent;
            ToolTip = 'Specifies the date the student left the institution.';
        }
        field(60004; "Acad. Year"; Code[10])
        {
            DataClassification = CustomerContent;
            ToolTip = 'Specifies the academic year (alternate field).';

            trigger OnValidate()
            begin
                "Academic Year" := "Acad. Year";
            end;
        }
        field(70000; "Second Language"; Option)
        {
            DataClassification = CustomerContent;
            ToolTip = 'Specifies the second language chosen by the student.';
            OptionCaption = ' ,Tamil,Hindi,Telugu,Malayalam,Kannada,French,Thai';
            OptionMembers = " ",Tamil,Hindi,Telugu,Malayalam,Kannada,French,Thai;
        }

        field(70001; "Thai Student"; Boolean)
        {
            DataClassification = EndUserIdentifiableInformation;
            ToolTip = 'Specifies whether the student is identified as a Thai student.';
        }

        field(70008; Group; Option)
        {
            DataClassification = CustomerContent;
            ToolTip = 'Specifies the subject group assigned to the student.';
            OptionCaption = ' ,Group A,Group B,Group C,Group D,Group E,Group F';
            OptionMembers = " ","Group A","Group B","Group C","Group D","Group E","Group F";
        }
        field(70009; "Tour Code"; Code[20])
        {
            DataClassification = CustomerContent;
            ToolTip = 'Specifies the tour dimension assigned.';
        }

        field(70010; "Computer Opt. Course"; Code[20])
        {
            DataClassification = CustomerContent;
            ToolTip = 'Specifies the optional computer course selected.';
        }

        field(70015; "Subject Group"; Code[20])
        {
            DataClassification = CustomerContent;
            ToolTip = 'Specifies the subject group.';
        }
        field(70016; Certificate1; Text[100])
        {
            DataClassification = CustomerContent;
            ToolTip = 'Specifies certificate details.';
        }

        field(70017; Certificate2; Text[100])
        {
            DataClassification = CustomerContent;
            ToolTip = 'Specifies additional certificate details.';
        }

        field(70121; "Portal ID"; Code[20])
        {
            Caption = 'Portal ID';
            DataClassification = SystemMetadata;
            ToolTip = 'Specifies the portal identifier for the student.';
        }
        field(70785; "Family Code"; Code[20])
        {
            Caption = 'Family Code';
            DataClassification = CustomerContent;
            ToolTip = 'Specifies the family code associated with the student.';
        }

        field(70786; Campus_1; Option)
        {
            Caption = 'Campus';
            DataClassification = CustomerContent;
            ToolTip = 'Specifies the campus assigned to the student.';
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
            DataClassification = CustomerContent;
            ToolTip = 'Specifies the portfolio reference.';
        }

        field(70788; Campus; Code[10])
        {
            DataClassification = CustomerContent;
            ToolTip = 'Specifies the internal campus code.';
        }

        field(80000; "Orig Academic Year"; Code[10])
        {
            DataClassification = CustomerContent;
            ToolTip = 'Specifies the original academic year of admission.';
        }

        field(80001; "Orig Class Code"; Code[20])
        {
            DataClassification = CustomerContent;
            ToolTip = 'Specifies the original class code.';
        }

        field(80002; "Extra Tuition"; Boolean)
        {
            DataClassification = CustomerContent;
            ToolTip = 'Specifies whether the student attends extra tuition.';
        }

        field(80003; "Father's DOB"; Date)
        {
            DataClassification = EndUserIdentifiableInformation;
            ToolTip = 'Specifies the date of birth of the father.';
        }
        field(80004; "Mother's DOB"; Date)
        {
            DataClassification = EndUserIdentifiableInformation;
            ToolTip = 'Specifies the date of birth of the mother.';
        }

        field(80005; "Student email"; Text[30])
        {
            DataClassification = EndUserIdentifiableInformation;
            ToolTip = 'Specifies the email address of the student.';
        }
        field(80010; "Academic Points"; Decimal)
        {
            CalcFormula = Sum("Academic Points".Points WHERE("Student No." = FIELD("No."),
                                                              "Academic Year" = FIELD("Academic Year")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(80011; "Appraisal Point"; Decimal)
        {
            DataClassification = CustomerContent;
            ToolTip = 'Specifies appraisal points assigned to the student.';
        }

        field(80012; "Old Class Code"; Code[20])
        {
            DataClassification = CustomerContent;
            ToolTip = 'Specifies the previous class code.';
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

        if "No." = '' then begin
            AdmissionSetup.Get();
            AdmissionSetup.TestField("Student No.");
            "No. Series" := AdmissionSetup."Student No.";
            "No." := NoSeriesMgt.GetNextNo("No. Series");

        end;
    end;

    var

        AdmissionSetup: Record "Admission Setup";
        Enquiry: Record Enquiry;
        Emp: Record Employee;
        Customer: Record Customer;
        RecPortalUsers: Record "Portal Users";
        NoSeriesMgt: Codeunit "No. Series";
        Age2: Decimal;
        TempAge: Decimal;

    procedure Assistedit(OldStudent: Record Student): Boolean
    begin

        OldStudent := Rec;
        AdmissionSetup.Get();
        AdmissionSetup.TestField("Student No.");
        if NoSeriesMgt.LookupRelatedNoSeries(AdmissionSetup."Student No.", OldStudent."No. Series", "No. Series") then begin
            OldStudent."No." := NoSeriesMgt.GetNextNo(OldStudent."No. Series");
            Rec := OldStudent;
            exit(true);
        end;
    end;

}