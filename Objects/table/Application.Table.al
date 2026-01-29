table 71002 Application
{
    // No   Date      Sign     Trigger                                 Description
    // -----------------------------------------------------------------------------------------------
    // 01  19/09/09   KATHIR   OnInsert                            Code added for inserting the "Academic Year" field
    // 02  19/09/09   KATHIR   OnInsert                            Code added for No series generation
    // 03  19/09/09   KATHIR   OnInsert                            Code added for inserting the "Date of Sale" field
    // 05  19/09/09   KATHIR   No.- Onvalidate()                   Code added for No series generation
    // 06  19/09/09   KATHIR   City - OnValidate()                 Code added to validate city
    // 07  19/09/09   KATHIR   City - OnLookup()                   Code added to look up the city
    // 08  19/09/09   KATHIR   Post Code - OnValidate()            Code added to validate Post code
    // 09  19/09/09   KATHIR   Post Code - OnLookup()              Code added to look up the Post Code
    // 10  19/09/09   KATHIR   OnAssistEdit()                      Code added for No series generation
    // 11  19/09/09   KATHIR   DateOfBirth-OnValidate()            Code added to Calculate the Age
    // 13  22/09/09   KATHIR   Enquiry No. -OnValidate             Code added to Transfer values from Enquiry to admission
    // 14  19/10/09   VANDHANA OnInsert()                          Code to assign the User ID.
    // 15  16/11/09   VIGNESH  Curriculum Intrested - OnValidate() Code added to validate the sale based on the setup date
    // 16  23/11/09 VIGNESH  Class - OnLookup()                    Code added to get the Look up value for Class & Curriculum
    // 17  23/11/09 VIGNESH  Curriculum Intrested - OnLookup()     Code added to get the Look up value for Class & Curriculum
    // 18  23/11/09 VIGNESH  Class - OnLookup()                    Code added to get the Look up value for Class&Curriculum last attend
    // 19  23/11/09 VIGNESH  Curriculum intrested - OnLookup()      Code added to get the Look up value for Class&Curriculum last attend

    Caption = 'Application';
    DrillDownPageID = 71004;
    LookupPageID = 71004;

    fields
    {
        field(1; "No."; Code[20])
        {
            Caption = 'No.';

            trigger OnValidate()
            begin
                // Start 05.KATHIR
                if "No." <> xRec."No." then begin
                    AdmissionSetup.Get;
                    NoSeriesMgt.TestManual(AdmissionSetup."Application No.");
                    "No.Series" := '';
                end;
                // Stop 05.KATHIR
            end;
        }
        field(2; "Name of the pupil"; Text[30])
        {
            Caption = 'Name';

            trigger OnValidate()
            var
                ContBusRel: Record "Contact Business Relation";
                Cust: Record Customer;
                Vend: Record Vendor;
            begin
            end;
        }
        field(3; "Applicant Gender"; Option)
        {
            Caption = 'Gender';
            OptionCaption = ' ,Male,Female';
            OptionMembers = " ",Male,Female;
        }
        field(9; "Date of Birth"; Date)
        {
            Caption = 'Date of Birth';

            trigger OnValidate()
            begin
                // Start 11.VIGNESH
                if GuiAllowed then begin
                    TestField(Class);
                    TestField("Curriculum Intrested");

                    ClassCard.Reset;
                    ClassCard.SetRange(Class, Class);
                    ClassCard.SetRange(Curriculum, "Curriculum Intrested");
                    ClassCard.SetRange(ClassCard."Academic Year", "Academic Year");
                    if ClassCard.FindFirst then begin
                        if ClassCard."Cut Off Age as on" <> 0D then begin
                            if "Date of Birth" <> 0D then begin
                                Age := ClassCard."Cut Off Age as on" - "Date of Birth";
                                TempAge := Round(Age / 365, 1, '=');
                                Age2 := Age mod 365;
                                Months := Round(Age2 / 30, 1, '=');
                                Age := TempAge - 1;
                            end else begin
                                Clear(Age);
                                Clear(Months);
                            end;
                        end;
                    end;
                end;
                // Stop 11.VIGNESH
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
            TableRelation = "Academic Year";
        }
        field(15; Class; Code[10])
        {
            Caption = 'Class';
            TableRelation = "Class Card".Class;

            trigger OnLookup()
            begin
                // Start 17.VIGNESH
                ClassCardLook.LookUpClass(Class, "Curriculum Intrested", "Academic Year");
                AdmSetup.Get;
                ClassCard.Get(Class, "Curriculum Intrested", "Academic Year");
                if AdmSetup."Application Sale Method" = AdmSetup."Application Sale Method"::Common then begin
                    if (AdmSetup."Application Sales From" <> 0D) and (AdmSetup."Application Sales To" <> 0D) then
                        if (AdmSetup."Application Sales From" > Today) or (AdmSetup."Application Sales To" < Today) then
                            Error(Text001);
                end else
                    if AdmSetup."Application Sale Method" = AdmSetup."Application Sale Method"::Classwise then begin
                        ClassCard.Get(Class, "Curriculum Intrested", "Academic Year");
                        if (ClassCard."Application Sale From" <> 0D) and (ClassCard."Application Sale Till" <> 0D) then
                            if (ClassCard."Application Sale From" > Today) and (ClassCard."Application Sale Till" < Today) then
                                Message(Text002);
                    end;

                if AdmSetup."Appl Cost Method" = AdmSetup."Appl Cost Method"::Common then begin
                    "Application Cost" := AdmSetup."Application Cost";
                    "Registration Cost" := AdmSetup."Registration Cost";
                end else
                    if AdmSetup."Appl Cost Method" = AdmSetup."Appl Cost Method"::Classwise then begin
                        "Application Cost" := ClassCard."Application Cost";
                        "Registration Cost" := ClassCard."Registration Cost";
                    end;

                // Stop 17.VIGNESH
            end;

            trigger OnValidate()
            begin
                if GuiAllowed then begin
                    // Start 16.VIGNESH

                    ClassCardLook.ValidateClass(Class, "Curriculum Intrested", "Academic Year");
                    AdmSetup.Get;
                    ClassCard.Get(Class, "Curriculum Intrested", "Academic Year");
                    // Start 15.VIGNESH
                    if AdmSetup."Application Sale Method" = AdmSetup."Application Sale Method"::Common then begin
                        if (AdmSetup."Application Sales From" <> 0D) and (AdmSetup."Application Sales To" <> 0D) then
                            if (AdmSetup."Application Sales From" > Today) or (AdmSetup."Application Sales To" < Today) then
                                Error(Text001);
                    end else
                        if AdmSetup."Application Sale Method" = AdmSetup."Application Sale Method"::Classwise then begin
                            ClassCard.Get(Class, "Curriculum Intrested", "Academic Year");
                            if (ClassCard."Application Sale From" <> 0D) and (ClassCard."Application Sale Till" <> 0D) then
                                if (ClassCard."Application Sale From" > Today) and (ClassCard."Application Sale Till" < Today) then
                                    Message(Text002);
                        end;

                    if AdmSetup."Appl Cost Method" = AdmSetup."Appl Cost Method"::Common then begin
                        "Application Cost" := AdmSetup."Application Cost";
                        "Registration Cost" := AdmSetup."Registration Cost";
                    end else
                        if AdmSetup."Appl Cost Method" = AdmSetup."Appl Cost Method"::Classwise then begin
                            "Application Cost" := ClassCard."Application Cost";
                            "Registration Cost" := ClassCard."Registration Cost";
                        end;

                    // Stop 15.VIGNESH
                    // Stop 12.KATHIR

                    // Stop 16.VIGNESH
                end;
            end;
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
        field(20; "Curriculum Intrested"; Code[10])
        {
            Caption = 'Curriculum Intrested';
            TableRelation = "Class Card".Curriculum;

            trigger OnLookup()
            begin
                // Start 19.VIGNESH
                ClassCardLook.LookUpCurriculum(Class, "Curriculum Intrested", "Academic Year");
                // Stop 19.VIGNESH
            end;

            trigger OnValidate()
            begin
                // Start 18.VIGNESH
                ClassCardLook.ValidateCurriculum(Class, "Curriculum Intrested", "Academic Year");
                // Stop 18.VIGNESH
            end;
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
                // Start 07.KATHIR
                //Postcode.LookUpCity(City,"Post Code",TRUE);
                Postcode.LookupPostCode(City, "Post Code", State, Country);
                // Stop 07.KATHIR
            end;

            trigger OnValidate()
            begin
                // Start 06.KATHIR
                //Postcode.ValidateCity(City,"Post Code");
                Postcode.ValidateCity(City, "Post Code", State, Country, (CurrFieldNo <> 0) and GuiAllowed);
                // Stop 06.KATHIR
            end;
        }
        field(28; "Post Code"; Code[10])
        {
            Caption = 'Post Code';
            TableRelation = "Post Code";

            trigger OnLookup()
            begin
                // Start 09.KATHIR
                //Postcode.LookUpPostCode(City,"Post Code",TRUE);
                Postcode.LookupPostCode(City, "Post Code", State, Country);
                // Stop 09.KATHIR
            end;

            trigger OnValidate()
            begin
                // Start 08.KATHIR
                //Postcode.ValidatePostCode(City,"Post Code");
                Postcode.ValidatePostCode(City, "Post Code", State, Country, (CurrFieldNo <> 0) and GuiAllowed);
                // Stop 08.KATHIR
            end;
        }
        field(29; Country; Code[20])
        {
            Caption = 'Country';
            TableRelation = "Country/Region";
        }
        field(30; "E-Mail Address"; Text[30])
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
        field(33; State; Text[30])
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
        field(58; "Application Status"; Option)
        {
            Caption = 'Application Status';
            Editable = true;
            OptionCaption = ' ,Sold,Received,Selected,Admitted';
            OptionMembers = " ",Sold,Received,Selected,Admitted;
        }
        field(59; "No.Series"; Code[20])
        {
            Caption = 'No.Series';
        }
        field(60; "Promotion Granted"; Boolean)
        {
            Caption = 'Promotion Granted';
        }
        field(61; "Cheque / DD Date"; Date)
        {
            Caption = 'Cheque / DD Date';
        }
        field(62; "Bank Name"; Text[50])
        {
            Caption = 'Bank Name';
        }
        field(63; "Date of Sale"; Date)
        {
            Caption = 'Date of Sale';
        }
        field(64; "Date of Receive"; Date)
        {
            Caption = 'Date of Receive';
        }
        field(70; "Father's Occupation"; Text[30])
        {
            Caption = 'Father''s Occupation';
        }
        field(71; "Mother's Annual Income"; Decimal)
        {
            BlankZero = true;
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
        field(75; "Applicant Relationship"; Code[20])
        {
            Caption = 'Applicant Relationship';
            TableRelation = Relative;
        }
        field(76; "Enquiry No."; Code[10])
        {
            Caption = 'Enquiry No.';
            TableRelation = Enquiry WHERE ("Enquiry Closed" = CONST (false));

            trigger OnValidate()
            begin
                // Start 13.KATHIR
                AdmSetup.Get;
                if Enquiry.Get("Enquiry No.") then begin
                    TransferFields(Enquiry);
                    Validate("Date of Birth");
                    //  VALIDATE("Curriculum Intrested");
                    "No." := xRec."No.";
                end;

                // Start 15.VIGNESH
                AdmSetup.Get;
                if AdmSetup."Application Sale Method" = AdmSetup."Application Sale Method"::Common then begin
                    if (AdmSetup."Application Sales From" <> 0D) and (AdmSetup."Application Sales To" <> 0D) then
                        if (AdmSetup."Application Sales From" > Today) or (AdmSetup."Application Sales To" < Today) then
                            Error(Text001);
                end else
                    if AdmSetup."Application Sale Method" = AdmSetup."Application Sale Method"::Classwise then begin
                        ClassCard.Get(Class, "Curriculum Intrested", "Academic Year");
                        if (ClassCard."Application Sale From" <> 0D) and (ClassCard."Application Sale Till" <> 0D) then
                            if (ClassCard."Application Sale From" > Today) and (ClassCard."Application Sale Till" < Today) then
                                Message(Text002);
                    end;

                if AdmSetup."Appl Cost Method" = AdmSetup."Appl Cost Method"::Common then begin
                    "Application Cost" := AdmSetup."Application Cost";
                    "Registration Cost" := AdmSetup."Registration Cost";
                end else
                    if AdmSetup."Appl Cost Method" = AdmSetup."Appl Cost Method"::Classwise then begin
                        "Application Cost" := ClassCard."Application Cost";
                        "Registration Cost" := ClassCard."Registration Cost";
                    end;
                // Stop 15.VIGNESH
                // Stop 12.KATHIR
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
        field(83; "Registration Cost"; Decimal)
        {
            Caption = 'Registration Cost';
        }
        field(90; "Mode of Sale"; Code[10])
        {
            Caption = 'Mode of Sale';
            TableRelation = "Enquiry Type";
        }
        field(91; "Application Cost"; Decimal)
        {
            BlankZero = true;
            Caption = 'Application Cost';
            Editable = true;
        }
        field(92; "Mode of Payment"; Code[10])
        {
            Caption = 'Mode of Payment';
            TableRelation = "Payment Method";
        }
        field(93; "Cheque / DD No."; Text[30])
        {
            Caption = 'Cheque / DD No.';
        }
        field(94; Prospectus; Boolean)
        {
            Caption = 'Prospectus';
        }
        field(95; "Prospectus No."; Text[30])
        {
            Caption = 'Prospectus No.';
        }
        field(96; "Father's Annual Income"; Decimal)
        {
            BlankZero = true;
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
        field(500; Spot; Boolean)
        {
            Caption = 'Spot';
        }
        field(501; "Recommender Designation"; Text[50])
        {
            Caption = 'Recommender Designation';
        }
        field(502; "Recommended By"; Text[50])
        {
            Caption = 'Recommended By';
        }
        field(503; "Recommended List No"; Text[50])
        {
            Caption = 'Recommended List No';
        }
        field(504; "Check Age Limit"; Boolean)
        {
            Caption = 'Check Age Limit';
        }
        field(505; Recommendation; Boolean)
        {
            Caption = 'Recommendation';
        }
        field(1000; Section; Code[10])
        {
            Caption = 'Section';
            TableRelation = Section;
        }
        field(1017; "Student No."; Code[20])
        {
            Caption = 'Student No.';
        }
        field(2000; "Address 3"; Text[100])
        {
            Caption = 'Address 3';
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
            TableRelation = Employee;
        }
        field(50000; "Bank Fees"; Decimal)
        {
        }
        field(51000; Rank; Integer)
        {
            Caption = 'Rank';
        }
        field(51001; "Evaluation Total"; Decimal)
        {
            Caption = 'Evaluation Total';
        }
        field(51002; "Selection Number"; Code[10])
        {
            Caption = 'Selection Number';
        }
        field(51100; "Reg DD / Cheque No"; Text[30])
        {
        }
        field(51101; "Reg DD / Cheque Date"; Date)
        {
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
        field(70000; "Second Language"; Option)
        {
            OptionCaption = ' ,Tamil,Hindi,Telugu,Malayalam,Kannada,French,Thai';
            OptionMembers = " ",Tamil,Hindi,Telugu,Malayalam,Kannada,French,Thai;
        }
        field(70001; "Thai Student"; Boolean)
        {
        }
        field(70003; "Sibling No."; Code[20])
        {
            TableRelation = Student;
        }
        field(70004; "Previous Percentage"; Integer)
        {
        }
        field(70005; Vaccinated; Boolean)
        {
        }
        field(70006; "Roll No Allotted Date"; Date)
        {
        }
        field(70007; "Registration Date"; Date)
        {
        }
        field(70008; Group; Option)
        {
            OptionCaption = ' ,Group A,Group B,Group C,Group D';
            OptionMembers = " ","Group A","Group B","Group C","Group D";
        }
        field(70120; "User ID"; Code[20])
        {
            Caption = 'User ID';
        }
        field(70121; "Portal ID"; Code[20])
        {
            Caption = 'Portal ID';
        }
        field(71000; "Free Prospectus"; Boolean)
        {

            trigger OnValidate()
            begin
                "Application Cost" := 0;
            end;
        }
        field(71001; Reason; Text[250])
        {

            trigger OnValidate()
            begin
                "Application Cost" := 0;
            end;
        }
        field(71002; StateDesc; Text[50])
        {
        }
        field(71003; "Send Prospectus"; Boolean)
        {
        }
    }

    keys
    {
        key(Key1; "No.")
        {
            Clustered = true;
        }
        key(Key2; Class, "Curriculum Intrested", "Academic Year")
        {
        }
        key(Key3; Rank)
        {
        }
        key(Key4; "Selection Number", "Application Status")
        {
        }
        key(Key5; Class, "Curriculum Intrested", "Academic Year", "Application Status")
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    begin
        // Start 01.KATHIR
        "Academic Year" := EduVertical.GetAdmissionYear;
        //"Academic Year" := EduVertical.GetAdmissionYear;
        // Stop 01.KATHIR

        // Start 02.KATHIR
        AdmissionSetup.Get;
        if "No.Series" = '' then begin
            AdmissionSetup.TestField("Application No.");
            NoSeriesMgt.InitSeries(AdmissionSetup."Application No.", xRec."No.Series", 0D, "No.", "No.Series");
        end;
        // Stop 02.KATHIR

        // Start 03.KATHIR
        "Date of Sale" := Today;
        // Stop 03.KATHIR

        // Start 14. VANDHANA
        "User ID" := UserId;
        // Stop 14. VANDHANA


        "Registration Date" := Today;
    end;

    var
        Postcode: Record "Post Code";
        EduVertical: Codeunit "Education Vertical";
        AdmissionSetup: Record "Admission Setup";
        NoSeriesMgt: Codeunit NoSeriesManagement;
        Enquiry: Record Enquiry;
        Application: Record Application;
        Age2: Decimal;
        TempAge: Decimal;
        AdmSetup: Record "Admission Setup";
        Classrec: Record Class;
        ClassCard: Record "Class Card";
        ClassCardLook: Record "Class Card";
        ClassSection: Record "Class Section";
        Text000: Label 'Age limit exceeded';
        Text001: Label 'Sale of Application Closed';
        Text002: Label 'Sale of Application Closed';

    [Scope('Internal')]
    procedure Assistedit(OldApplication: Record Application): Boolean
    begin
        // Start 10.KATHIR
        with Application do begin
            Application := Rec;
            AdmissionSetup.Get;
            AdmissionSetup.TestField("Application No.");
            if NoSeriesMgt.SelectSeries(AdmissionSetup."Application No.", OldApplication."No.Series", "No.Series") then begin
                NoSeriesMgt.SetSeries("No.");
                Rec := Application;
                exit(true);
            end;
        end;
        // Stop 10.KATHIR
    end;
}

