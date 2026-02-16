table 71002 Application
{
    Caption = 'Application';
    // DrillDownPageID = 71004;
    // LookupPageID = 71004;

    fields
    {
        field(1; "No."; Code[20])
        {
            Caption = 'No.';
            ToolTip = 'Specifies the unique application number.';
            DataClassification = SystemMetadata;

            trigger OnValidate()
            begin
                if "No." <> xRec."No." then begin
                    AdmissionSetup.Get();
                    NoSeriesMgt.TestManual(AdmissionSetup."Application No.");
                    "No.Series" := '';
                end;
            end;
        }
        field(2; "Name of the pupil"; Text[30])
        {
            Caption = 'Name';
            ToolTip = 'Specifies the name of the applicant.';
            DataClassification = CustomerContent;

        }
        field(3; "Applicant Gender"; Option)
        {
            Caption = 'Gender';
            ToolTip = 'Specifies the gender of the applicant.';
            OptionCaption = ' ,Male,Female';
            OptionMembers = " ",Male,Female;
            DataClassification = CustomerContent;
        }
        field(9; "Date of Birth"; Date)
        {
            Caption = 'Date of Birth';
            ToolTip = 'Specifies the date of birth of the applicant.';
            DataClassification = CustomerContent;

            trigger OnValidate()
            begin

                if GuiAllowed then begin
                    TestField(Class);
                    TestField("Curriculum Intrested");

                    ClassCard.Reset();
                    ClassCard.SetRange(Class, Class);
                    ClassCard.SetRange(Curriculum, "Curriculum Intrested");
                    ClassCard.SetRange(ClassCard."Academic Year", "Academic Year");
                    if ClassCard.FindFirst() then
                        if ClassCard."Cut Off Age as on" <> 0D then
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
        }
        field(10; "Father's Name"; Text[100])
        {
            Caption = 'Father''s Name';
            ToolTip = 'Specifies the name of the applicant’s father.';
            DataClassification = CustomerContent;
        }
        field(11; "Mother's Name"; Text[100])
        {
            Caption = 'Mother''s Name';
            ToolTip = 'Specifies the name of the applicant’s mother.';
            DataClassification = CustomerContent;
        }

        field(12; Citizenship; Code[20])
        {
            Caption = 'Citizenship';
            ToolTip = 'Specifies the citizenship of the applicant.';
            TableRelation = Citizenship;
            DataClassification = CustomerContent;
        }

        field(13; "Academic Year"; Code[20])
        {
            Caption = 'Academic Year';
            ToolTip = 'Specifies the academic year of admission.';
            TableRelation = "Academic Year";
            DataClassification = CustomerContent;
        }
        field(15; Class; Code[10])
        {
            Caption = 'Class';
            ToolTip = 'Specifies the class applied for.';
            TableRelation = "Class Card".Class;
            DataClassification = CustomerContent;


            trigger OnLookup()
            begin
                ClassCardLook.LookUpClass(Class, "Curriculum Intrested", "Academic Year");
                AdmSetup.Get();
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

            end;

            trigger OnValidate()
            begin
                if GuiAllowed then begin


                    ClassCardLook.ValidateClass(Class, "Curriculum Intrested", "Academic Year");
                    AdmSetup.Get();
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

                end;
            end;
        }
        field(16; "Hostel Acommodation"; Boolean)
        {
            Caption = 'Hostel Acommodation';
            ToolTip = 'Specifies whether hostel accommodation is required.';
            DataClassification = CustomerContent;
        }

        field(17; "Previous School"; Text[150])
        {
            Caption = 'Previous School';
            ToolTip = 'Specifies the previous school attended by the applicant.';
            DataClassification = CustomerContent;
        }
        field(18; "Medium of Instruction"; Code[10])
        {
            Caption = 'Medium of Instruction';
            ToolTip = 'Specifies the medium of instruction.';
            TableRelation = "Medium of Instruction";
            DataClassification = CustomerContent;
        }

        field(19; "Presently Residing with"; Code[10])
        {
            Caption = 'Presently Residing with';
            ToolTip = 'Specifies whom the applicant is currently residing with.';
            TableRelation = Relative;
            DataClassification = CustomerContent;
        }
        field(20; "Curriculum Intrested"; Code[20])
        {
            Caption = 'Curriculum Intrested';
            ToolTip = 'Specifies the curriculum selected by the applicant.';
            TableRelation = "Class Card".Curriculum;
            DataClassification = CustomerContent;

            trigger OnLookup()
            begin

                ClassCardLook.LookUpCurriculum(Class, "Curriculum Intrested", "Academic Year");

            end;

            trigger OnValidate()
            begin

                ClassCardLook.ValidateCurriculum(Class, "Curriculum Intrested", "Academic Year");

            end;
        }
        field(21; "Previous Class"; Code[10])
        {
            Caption = 'Previous Class';
            ToolTip = 'Specifies the previously completed class.';
            TableRelation = Class;
            DataClassification = CustomerContent;
        }

        field(22; "Previous Curriculum"; Code[10])
        {
            Caption = 'Previous Curriculum';
            ToolTip = 'Specifies the previous curriculum studied.';
            TableRelation = Curriculum;
            DataClassification = CustomerContent;
        }
        field(23; "Address To"; Code[20])
        {
            Caption = 'Address To';
            ToolTip = 'Specifies the person to whom correspondence is addressed.';
            TableRelation = Relative;
            DataClassification = CustomerContent;
        }

        field(24; Addressee; Text[100])
        {
            Caption = 'Addressee';
            ToolTip = 'Specifies the addressee name.';
            DataClassification = CustomerContent;
        }
        field(25; Address1; Text[100])
        {
            Caption = 'Address1';
            ToolTip = 'Specifies the first line of the address.';
            DataClassification = CustomerContent;
        }

        field(26; Address2; Text[100])
        {
            Caption = 'Address2';
            ToolTip = 'Specifies the second line of the address.';
            DataClassification = CustomerContent;
        }

        field(27; City; Text[30])
        {
            Caption = 'City';
            ToolTip = 'Specifies the city of the applicant.';
            DataClassification = CustomerContent;

            trigger OnLookup()
            var
                Citytxt: Text;
                Statetxt: Text;

            begin
                Postcode.LookupPostCode(Citytxt, "Post Code", Statetxt, Country);
                Validate(City, Citytxt);
                Validate(State, Statetxt);
                //Validate(field,value);
            end;

            trigger OnValidate()
            begin
                Postcode.ValidateCity(City, "Post Code", State, Country, (CurrFieldNo <> 0) and GuiAllowed);
            end;
        }
        field(28; "Post Code"; Code[20])
        {
            Caption = 'Post Code';
            ToolTip = 'Specifies the postal code.';
            TableRelation = "Post Code";
            DataClassification = CustomerContent;

            trigger OnLookup()
            var
                Citytxt: Text;
                Statetxt: Text;
            begin
                Postcode.LookupPostCode(Citytxt, "Post Code", Statetxt, Country);
                Validate(City, Citytxt);
                Validate(State, Statetxt);

            end;

            trigger OnValidate()
            begin
                Postcode.ValidatePostCode(City, "Post Code", State, Country, (CurrFieldNo <> 0) and GuiAllowed);

            end;
        }
        field(29; Country; Code[10])
        {
            Caption = 'Country';
            ToolTip = 'Specifies the country of residence.';
            TableRelation = "Country/Region";
            DataClassification = CustomerContent;
        }

        field(30; "E-Mail Address"; Text[30])
        {
            Caption = 'E-Mail Address';
            ToolTip = 'Specifies the email address of the applicant.';
            DataClassification = CustomerContent;
        }

        field(31; "Mobile Number"; Text[30])
        {
            Caption = 'Mobile Number';
            ToolTip = 'Specifies the mobile phone number.';
            DataClassification = CustomerContent;
        }
        field(32; "Phone Number"; Text[30])
        {
            Caption = 'Phone Number';
            ToolTip = 'Specifies the landline phone number.';
            DataClassification = CustomerContent;
        }

        field(33; State; Text[30])
        {
            Caption = 'State';
            ToolTip = 'Specifies the state or region.';
            DataClassification = CustomerContent;
        }
        field(37; "Visa Exp Date"; Date)
        {
            Caption = 'Visa Exp Date';
            ToolTip = 'Specifies the expiry date of the visa.';
            DataClassification = CustomerContent;
        }
        field(38; "Passport No."; Text[20])
        {
            Caption = 'Passport No.';
            ToolTip = 'Specifies the passport number of the applicant.';
            DataClassification = CustomerContent;
        }
        field(39; "Passport Exp Date"; Date)
        {
            Caption = 'Passport Exp Date';
            ToolTip = 'Specifies the expiry date of the passport.';
            DataClassification = CustomerContent;
        }
        field(40; "Visa No."; Text[20])
        {
            Caption = 'Visa No.';
            ToolTip = 'Specifies the visa number issued to the applicant.';
            DataClassification = CustomerContent;
        }
        field(49; "Food Habits"; Option)
        {
            Caption = 'Food Habits';
            OptionCaption = ' ,Veg,Non Veg';
            OptionMembers = " ",Veg,"Non Veg";
            ToolTip = 'Specifies the food preference of the applicant.';
            DataClassification = CustomerContent;
        }
        field(50; "Applicant Image"; BLOB)
        {
            Caption = 'Applicant Image';
            ToolTip = 'Stores the photograph of the applicant.';
            DataClassification = CustomerContent;
        }
        field(51; "Father Image"; BLOB)
        {
            Caption = 'Father Image';
            ToolTip = 'Stores the photograph of the applicant’s father.';
            DataClassification = CustomerContent;
        }
        field(52; "Mother Image"; BLOB)
        {
            Caption = 'Mother Image';
            ToolTip = 'Stores the photograph of the applicant’s mother.';
            DataClassification = CustomerContent;
        }
        field(53; "Guardian Image"; BLOB)
        {
            Caption = 'Guardian Image';
            ToolTip = 'Stores the photograph of the applicant’s guardian.';
            DataClassification = CustomerContent;
        }
        field(54; "Mother's Qualification"; Text[30])
        {
            Caption = 'Mother''s Qualification';
            ToolTip = 'Specifies the educational qualification of the applicant’s mother.';
            DataClassification = CustomerContent;
        }
        field(55; "Mother's Occupation"; Text[30])
        {
            Caption = 'Mother''s Occupation';
            ToolTip = 'Specifies the occupation of the applicant’s mother.';
            DataClassification = CustomerContent;
        }
        field(56; "Guardian Name"; Text[100])
        {
            Caption = 'Guardian Name';
            ToolTip = 'Specifies the name of the applicant’s guardian.';
            DataClassification = CustomerContent;
        }
        field(58; "Application Status"; Option)
        {
            Caption = 'Application Status';
            Editable = true;
            OptionCaption = ' ,Sold,Received,Selected,Admitted';
            OptionMembers = " ",Sold,Received,Selected,Admitted;
            ToolTip = 'Specifies the current status of the application.';
            DataClassification = CustomerContent;
        }
        field(59; "No.Series"; Code[20])
        {
            Caption = 'No. Series';
            ToolTip = 'Specifies the number series used for the application.';
            DataClassification = SystemMetadata;
        }
        field(60; "Promotion Granted"; Boolean)
        {
            Caption = 'Promotion Granted';
            ToolTip = 'Specifies whether promotion has been granted.';
            DataClassification = CustomerContent;
        }
        field(61; "Cheque / DD Date"; Date)
        {
            Caption = 'Cheque / DD Date';
            ToolTip = 'Specifies the date of the cheque or demand draft.';
            DataClassification = CustomerContent;
        }
        field(62; "Bank Name"; Text[50])
        {
            Caption = 'Bank Name';
            ToolTip = 'Specifies the name of the bank.';
            DataClassification = CustomerContent;
        }
        field(63; "Date of Sale"; Date)
        {
            Caption = 'Date of Sale';
            ToolTip = 'Specifies the date on which the application was sold.';
            DataClassification = CustomerContent;
        }
        field(64; "Date of Receive"; Date)
        {
            Caption = 'Date of Receive';
            ToolTip = 'Specifies the date on which the application was received.';
            DataClassification = CustomerContent;
        }
        field(70; "Father's Occupation"; Text[30])
        {
            Caption = 'Father''s Occupation';
            ToolTip = 'Specifies the occupation of the applicant’s father.';
            DataClassification = CustomerContent;
        }
        field(71; "Mother's Annual Income"; Decimal)
        {
            Caption = 'Mother''s Annual Income';
            BlankZero = true;
            ToolTip = 'Specifies the annual income of the applicant’s mother.';
            DataClassification = CustomerContent;
        }
        field(72; "Guardian Qualification"; Text[30])
        {
            Caption = 'Guardian Qualification';
            ToolTip = 'Specifies the educational qualification of the guardian.';
            DataClassification = CustomerContent;
        }
        field(73; "Guardian Occupation"; Text[30])
        {
            Caption = 'Guardian Occupation';
            ToolTip = 'Specifies the occupation of the guardian.';
            DataClassification = CustomerContent;
        }
        field(74; "Guardian Annual Income"; Decimal)
        {
            Caption = 'Guardian Annual Income';
            ToolTip = 'Specifies the annual income of the guardian.';
            DataClassification = CustomerContent;
        }
        field(75; "Applicant Relationship"; Code[20])
        {
            Caption = 'Applicant Relationship';
            TableRelation = Relative;
            ToolTip = 'Specifies the relationship between the applicant and guardian.';
            DataClassification = CustomerContent;
        }
        field(76; "Enquiry No."; Code[10])
        {
            Caption = 'Enquiry No.';
            TableRelation = Enquiry where("Enquiry Closed" = const(false));
            ToolTip = 'Specifies the enquiry number linked to the application.';
            DataClassification = CustomerContent;
            trigger OnValidate()
            begin
                AdmSetup.Get();
                if Enquiry.Get("Enquiry No.") then begin
                    TransferFields(Enquiry);
                    Validate("Date of Birth");
                    "No." := xRec."No.";
                end;

                // Start 15.VIGNESH
                AdmSetup.Get();
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
            end;
        }
        field(77; Religion; Code[20])
        {
            Caption = 'Religion';
            TableRelation = Religion.Code;
            ToolTip = 'Specifies the religion of the applicant.';
            DataClassification = CustomerContent;
        }
        field(78; "Father's Qualification"; Text[30])
        {
            Caption = 'Father''s Qualification';
            ToolTip = 'Specifies the educational qualification of the applicant’s father.';
            DataClassification = CustomerContent;
        }
        field(79; Caste; Code[20])
        {
            Caption = 'Caste';
            ToolTip = 'Specifies the caste of the applicant.';
            DataClassification = CustomerContent;
        }
        field(81; Age; Integer)
        {
            Caption = 'Age';
            Editable = false;
            BlankZero = true;
            ToolTip = 'Specifies the age of the applicant.';
            DataClassification = CustomerContent;
        }
        field(82; Months; Integer)
        {
            Caption = 'Months';
            Editable = false;
            BlankZero = true;
            ToolTip = 'Specifies the age of the applicant in months.';
            DataClassification = CustomerContent;
        }
        field(83; "Registration Cost"; Decimal)
        {
            Caption = 'Registration Cost';
            ToolTip = 'Specifies the registration fee amount.';
            DataClassification = CustomerContent;
        }
        field(90; "Mode of Sale"; Code[10])
        {
            Caption = 'Mode of Sale';
            TableRelation = "Enquiry Type";
            ToolTip = 'Specifies the mode of sale of the application.';
            DataClassification = CustomerContent;
        }
        field(91; "Application Cost"; Decimal)
        {
            Caption = 'Application Cost';
            BlankZero = true;
            Editable = true;
            ToolTip = 'Specifies the cost of the application.';
            DataClassification = CustomerContent;
        }
        field(92; "Mode of Payment"; Code[10])
        {
            Caption = 'Mode of Payment';
            TableRelation = "Payment Method";
            ToolTip = 'Specifies the mode of payment.';
            DataClassification = CustomerContent;
        }
        field(93; "Cheque / DD No."; Text[30])
        {
            Caption = 'Cheque / DD No.';
            ToolTip = 'Specifies the cheque or demand draft number.';
            DataClassification = CustomerContent;
        }
        field(94; Prospectus; Boolean)
        {
            Caption = 'Prospectus';
            ToolTip = 'Specifies whether prospectus is issued.';
            DataClassification = CustomerContent;
        }
        field(95; "Prospectus No."; Text[30])
        {
            Caption = 'Prospectus No.';
            ToolTip = 'Specifies the prospectus number.';
            DataClassification = CustomerContent;
        }
        field(96; "Father's Annual Income"; Decimal)
        {
            Caption = 'Father''s Annual Income';
            BlankZero = true;
            ToolTip = 'Specifies the annual income of the applicant’s father.';
            DataClassification = CustomerContent;
        }
        field(97; "Exam Code"; Code[10])
        {
            Caption = 'Exam Code';
            TableRelation = "Exam Code";
            ToolTip = 'Specifies the entrance exam code.';
            DataClassification = CustomerContent;
        }
        field(98; Community; Code[10])
        {
            Caption = 'Community';
            TableRelation = Community;
            ToolTip = 'Specifies the community of the applicant.';
            DataClassification = CustomerContent;
        }
        field(99; "Mother Tongue"; Code[10])
        {
            Caption = 'Mother Tongue';
            TableRelation = "Mother Tongue";
            ToolTip = 'Specifies the mother tongue of the applicant.';
            DataClassification = CustomerContent;
        }
        field(500; Spot; Boolean)
        {
            Caption = 'Spot';
            ToolTip = 'Specifies whether the admission is spot admission.';
            DataClassification = CustomerContent;
        }
        field(501; "Recommender Designation"; Text[50])
        {
            Caption = 'Recommender Designation';
            ToolTip = 'Specifies the designation of the recommender.';
            DataClassification = CustomerContent;
        }
        field(502; "Recommended By"; Text[50])
        {
            Caption = 'Recommended By';
            ToolTip = 'Specifies the person who recommended the applicant.';
            DataClassification = CustomerContent;
        }
        field(503; "Recommended List No"; Text[50])
        {
            Caption = 'Recommended List No';
            ToolTip = 'Specifies the recommendation list number.';
            DataClassification = CustomerContent;
        }
        field(504; "Check Age Limit"; Boolean)
        {
            Caption = 'Check Age Limit';
            ToolTip = 'Specifies whether age limit validation is required.';
            DataClassification = CustomerContent;
        }
        field(505; Recommendation; Boolean)
        {
            Caption = 'Recommendation';
            ToolTip = 'Specifies whether the applicant is recommended.';
            DataClassification = CustomerContent;
        }
        field(1000; Section; Code[10])
        {
            Caption = 'Section';
            TableRelation = Section;
            ToolTip = 'Specifies the section allotted to the applicant.';
            DataClassification = CustomerContent;
        }
        field(1017; "Student No."; Code[20])
        {
            Caption = 'Student No.';
            ToolTip = 'Specifies the student number generated after admission.';
            DataClassification = CustomerContent;
        }
        field(2000; "Address 3"; Text[100])
        {
            Caption = 'Address 3';
            ToolTip = 'Specifies the third line of the address.';
            DataClassification = CustomerContent;
        }
        field(10001; "Fee Classification"; Code[10])
        {
            Caption = 'Fee Classification';
            ToolTip = 'Specifies the fee classification assigned to the applicant.';
            TableRelation = "Fee Classification";
            DataClassification = CustomerContent;
        }
        field(10002; Quota; Code[10])
        {
            Caption = 'Quota';
            ToolTip = 'Specifies the quota under which the applicant is admitted.';
            TableRelation = Quota;
            DataClassification = CustomerContent;
        }
        field(10003; "Physically Challanged"; Boolean)
        {
            Caption = 'Physically Challenged';
            ToolTip = 'Specifies whether the applicant is physically challenged.';
            DataClassification = CustomerContent;
        }
        field(10004; "Staff Child"; Boolean)
        {
            Caption = 'Staff Child';
            ToolTip = 'Specifies whether the applicant is a child of staff.';
            DataClassification = CustomerContent;
        }
        field(10005; "Staff Code"; Code[20])
        {
            Caption = 'Staff Code';
            ToolTip = 'Specifies the staff code if the applicant is a staff child.';
            TableRelation = Employee;
            DataClassification = CustomerContent;
        }
        field(50000; "Bank Fees"; Decimal)
        {
            Caption = 'Bank Fees';
            ToolTip = 'Specifies the bank charges applicable for the transaction.';
            DataClassification = CustomerContent;
        }
        field(51000; Rank; Integer)
        {
            Caption = 'Rank';
            ToolTip = 'Specifies the rank obtained by the applicant.';
            DataClassification = CustomerContent;
        }
        field(51001; "Evaluation Total"; Decimal)
        {
            Caption = 'Evaluation Total';
            ToolTip = 'Specifies the total marks obtained during evaluation.';
            DataClassification = CustomerContent;
        }
        field(51002; "Selection Number"; Code[10])
        {
            Caption = 'Selection Number';
            ToolTip = 'Specifies the selection number assigned to the applicant.';
            DataClassification = CustomerContent;
        }
        field(51100; "Reg DD / Cheque No"; Text[30])
        {
            Caption = 'Registration DD / Cheque No.';
            ToolTip = 'Specifies the DD or cheque number for registration payment.';
            DataClassification = CustomerContent;
        }
        field(51101; "Reg DD / Cheque Date"; Date)
        {
            Caption = 'Registration DD / Cheque Date';
            ToolTip = 'Specifies the DD or cheque date for registration payment.';
            DataClassification = CustomerContent;
        }
        field(60000; Height; Decimal)
        {
            Caption = 'Height';
            ToolTip = 'Specifies the height of the applicant.';
            BlankZero = true;
            DataClassification = CustomerContent;
        }
        field(60001; Weight; Decimal)
        {
            Caption = 'Weight';
            ToolTip = 'Specifies the weight of the applicant.';
            BlankZero = true;
            DataClassification = CustomerContent;
        }
        field(70000; "Second Language"; Option)
        {
            Caption = 'Second Language';
            ToolTip = 'Specifies the second language opted by the applicant.';
            OptionCaption = ' ,Tamil,Hindi,Telugu,Malayalam,Kannada,French,Thai';
            OptionMembers = " ",Tamil,Hindi,Telugu,Malayalam,Kannada,French,Thai;
            DataClassification = CustomerContent;
        }
        field(70001; "Thai Student"; Boolean)
        {
            Caption = 'Thai Student';
            ToolTip = 'Specifies whether the applicant is a Thai student.';
            DataClassification = CustomerContent;
        }
        field(70003; "Sibling No."; Code[20])
        {
            Caption = 'Sibling No.';
            ToolTip = 'Specifies the sibling student number, if applicable.';
            TableRelation = Student;
            DataClassification = CustomerContent;
        }
        field(70004; "Previous Percentage"; Integer)
        {
            Caption = 'Previous Percentage';
            ToolTip = 'Specifies the percentage obtained in the previous academic year.';
            DataClassification = CustomerContent;
        }
        field(70005; Vaccinated; Boolean)
        {
            Caption = 'Vaccinated';
            ToolTip = 'Specifies whether the applicant is vaccinated.';
            DataClassification = CustomerContent;
        }
        field(70006; "Roll No Allotted Date"; Date)
        {
            Caption = 'Roll No Allotted Date';
            ToolTip = 'Specifies the date on which the roll number was allotted.';
            DataClassification = CustomerContent;
        }
        field(70007; "Registration Date"; Date)
        {
            Caption = 'Registration Date';
            ToolTip = 'Specifies the date on which the application was registered.';
            DataClassification = CustomerContent;
        }
        field(70008; Group; Option)
        {
            Caption = 'Group';
            ToolTip = 'Specifies the group allotted to the applicant.';
            OptionCaption = ' ,Group A,Group B,Group C,Group D';
            OptionMembers = " ","Group A","Group B","Group C","Group D";
            DataClassification = CustomerContent;
        }
        field(70121; "Portal ID"; Code[20])
        {
            Caption = 'Portal ID';
            ToolTip = 'Specifies the portal login identifier for the applicant.';
            DataClassification = CustomerContent;
        }
        field(71001; Reason; Text[250])
        {
            Caption = 'Reason';
            ToolTip = 'Specifies the reason for providing a free prospectus or waiving the application cost.';
            DataClassification = CustomerContent;

            trigger OnValidate()
            begin
                "Application Cost" := 0;
            end;
        }
        field(71002; StateDesc; Text[50])
        {
            Caption = 'State Description';
            ToolTip = 'Specifies the description of the state entered for the applicant.';
            DataClassification = CustomerContent;
        }
        field(71003; "Send Prospectus"; Boolean)
        {
            Caption = 'Send Prospectus';
            ToolTip = 'Specifies whether the prospectus should be sent to the applicant.';
            DataClassification = CustomerContent;
        }
        field(71004; "No. Series"; Code[20])
        {
            Caption = 'No. Series';
            ToolTip = 'Specifies the number series used to assign the announcement number.';
            Editable = false;
            TableRelation = "No. Series";
            DataClassification = SystemMetadata;
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
        if AdmissionSetup."Application No." = '' then begin
            AdmissionSetup.Get();
            AdmissionSetup.TestField("Application No.");
            "No. Series" := AdmissionSetup."Application No.";
            AdmissionSetup."Application No." := NoSeriesMgt.GetNextNo("No. Series");
        end;
    end;

    var
        Postcode: Record "Post Code";
        AdmissionSetup: Record "Admission Setup";
        Enquiry: Record Enquiry;
        Application: Record Application;
        AdmSetup: Record "Admission Setup";
        ClassCard: Record "Class Card";
        ClassCardLook: Record "Class Card";
        //   ClassSection: Record "Class Section";
        //   EduVertical: Codeunit "Education Vertical";
        NoSeriesMgt: Codeunit "No. Series";

        Age2: Decimal;
        TempAge: Decimal;

        Text000: Label 'Age limit exceeded';
        Text001: Label 'Sale of Application Closed';
        Text002: Label 'Sale of Application Closed';

    procedure Assistedit(OldApplication: Record Application): Boolean
    begin
        Application := Rec;
        AdmissionSetup.Get();
        AdmissionSetup.TestField("Application No.");
        if NoSeriesMgt.LookupRelatedNoSeries(AdmissionSetup."Application No.", OldApplication."No.Series", "No.Series") then begin
            Application."No." := NoSeriesMgt.GetNextNo(Application."No. Series");
            Rec := Application;
            exit(true);
        end;
    end;

}

