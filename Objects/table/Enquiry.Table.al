table 71001 Enquiry
{
    //    No     Date    Sign     Trigger                          Description
    // -----------------------------------------------------------------------------------------------
    //   01     17/09/09 KATHIR   OnInsert                             Code added for No.Series
    //   02     17/09/09 KATHIR   City-OnValidate                      Code added for Validate PostCode
    //   03     17/09/09 KATHIR   City-Onlookup                        Code added for Validate PostCode
    //   04     17/09/09 KATHIR   PostCode-OnValidate                  Code added for Validate PostCode
    //   05     17/09/09 KATHIR   PostCode-Onlookup                    Code added for Validate PostCode
    //   06     17/09/09 KATHIR   AssistEdit                           Code added for No.Series
    //   07     18/09/09 KATHIR   OnInsert                             Code added for Academic year from Setup
    //   08     21/09/09 KATHIR   DateOfBirth-OnValidate               Code added to Caluate Age
    //   09     22/09/09 KATHIR   OnInsert                             Code added to display Workdate in Enquiry date
    //   10     19/10/09 VANDHANA OnInsert()                           Code to assign the User ID.
    //   11     16/10/09 VIGNESH  Date of Birth - OnValidate()         Code modified to validate the age based on the setup
    //   12     23/11/09 VIGNESH  Class Applied - OnLookup()           Code added to get the Look up value for Class & Curriculum
    //   13     23/11/09 VIGNESH  Curriculum Intrested - OnLookup()    Code added to get the Look up value for Class & Curriculum
    //   16     23/11/09 VIGNESH  Class Applied - OnValidate()         Code added to get the validate value for Class & Curriculum
    //   18     23/11/09 VIGNESH  Curriculum Intrested - OnValidate()  Code added to get the Validat value for Class&Curriculum last attend
    //   19     09/06/10 Ankesh   Date of Birth - OnValidate()         Code modified because of Web Service 'Class Applied' Error.

    Caption = 'Enquiry';
    LookupPageID = 71002;

    fields
    {
        field(1; "No."; Code[10])
        {
            Caption = 'No.';
        }
        field(2; Name; Text[50])
        {
            Caption = 'Name';
        }
        field(3; "Enquiry Gender"; Option)
        {
            Caption = 'Gender';
            OptionCaption = ' ,Male,Female';
            OptionMembers = " ",Male,Female;
        }
        field(4; "Type Of Enquiry"; Code[10])
        {
            Caption = 'Type Of Enquiry';
            TableRelation = "Enquiry Type";
        }
        field(5; "Enquiry Source"; Code[10])
        {
            Caption = 'Enquiry Source';
            TableRelation = "Enquiry Source";
        }
        field(6; "Enquirer Name"; Text[50])
        {
            Caption = 'Enquirer Name';
        }
        field(7; "Relationship with Applicant"; Text[30])
        {
            Caption = 'Relationship with Applicant';
        }
        field(8; "Media Vehicle"; Code[20])
        {
            Caption = 'Media Vehicle';
            TableRelation = "Media Vehicle";
        }
        field(9; "Date of Birth"; Date)
        {
            Caption = 'Date of Birth';

            trigger OnValidate()
            begin
                // Stop 19.Ankesh
                if "Date of Birth" <> 0D then begin
                    Age := Today - "Date of Birth";
                    TempAge := Round(Age / 365, 1, '<');
                    Age2 := Age mod 365;
                    Months := Round(Age2 / 30, 1, '<');
                    Age := TempAge;
                end
                else begin
                    Clear(Age);
                    Clear(Months);
                end;
                // Stop 19.Ankesh
            end;
        }
        field(10; "Father's Name"; Text[50])
        {
            Caption = 'Father''s Name';
        }
        field(11; "Mother's Name"; Text[50])
        {
            Caption = 'Mother''s Name';
        }
        field(12; Citizenship; Code[10])
        {
            Caption = 'Citizenship';
            TableRelation = Citizenship;
        }
        field(13; "Academic Year"; Code[10])
        {
            Caption = 'Academic Year';
            TableRelation = "Academic Year";
        }
        field(14; "Enquiry Date"; Date)
        {
            Caption = 'Enquiry Date';
        }
        field(15; "Class Applied"; Code[10])
        {
            Caption = 'Class Applied';
            TableRelation = "Class Card";

            trigger OnLookup()
            begin
                // Start 12.VIGNESH
                ClassCardLook.LookUpClass("Class Applied", "Curriculum Intrested", "Academic Year");
                // Stop 12.VIGNESH
            end;

            trigger OnValidate()
            begin
                // Start 16.VIGNESH
                ClassCardLook.ValidateClass("Class Applied", "Curriculum Intrested", "Academic Year");
                // Stop 16.VIGNESH
            end;
        }
        field(16; "Hostel Accomodation"; Boolean)
        {
            Caption = 'Hostel Accomodation';
        }
        field(17; "Name Of The Previous Institute"; Text[80])
        {
            Caption = 'Name Of The Previous Institute';
        }
        field(18; "Medium Of Instruction"; Code[10])
        {
            Caption = 'Medium Of Instruction';
            TableRelation = "Medium of Instruction";
        }
        field(20; "Curriculum Intrested"; Code[10])
        {
            Caption = 'Curriculum Intrested';
            TableRelation = "Class Card".Curriculum;

            trigger OnLookup()
            begin
                // Start 13.VIGNESH
                ClassCardLook.LookUpCurriculum("Class Applied", "Curriculum Intrested", "Academic Year");
                // Stop 13.VIGNESH
            end;

            trigger OnValidate()
            begin
                // Start 18.VIGNESH
                ClassCardLook.ValidateCurriculum("Class Applied", "Curriculum Intrested", "Academic Year");
                // Stop 18.VIGNESH
            end;
        }
        field(21; "Class Last Attended"; Code[10])
        {
            Caption = 'Class Last Attended';
            TableRelation = Class;
        }
        field(22; "Curriculum Followed"; Code[10])
        {
            Caption = 'Curriculum Followed';
            TableRelation = Curriculum;
        }
        field(23; "Address To"; Code[10])
        {
            Caption = 'Address To';
            TableRelation = Relative;
        }
        field(24; Addressee; Text[50])
        {
            Caption = 'Addressee';
        }
        field(25; "Address 1"; Text[50])
        {
            Caption = 'Address 1';
        }
        field(26; "Address 2"; Text[50])
        {
            Caption = 'Address 2';
        }
        field(27; City; Text[30])
        {
            Caption = 'City';

            trigger OnLookup()
            begin
                // Start 03.KATHIR
                //Postcode.LookUpCity(City,"Post Code",TRUE);
                Postcode.LookupPostCode(City, "Post Code", State, "Country Code");
                // Stop 03.KATHIR
            end;

            trigger OnValidate()
            begin
                // Start 02.KATHIR
                //Postcode.ValidateCity(City,"Post Code");
                Postcode.ValidateCity(City, "Post Code", State, "Country Code", (CurrFieldNo <> 0) and GuiAllowed);
                // Stop 02.KATHIR
            end;
        }
        field(28; "Post Code"; Code[20])
        {
            Caption = 'Post Code';
            TableRelation = "Post Code";

            trigger OnLookup()
            begin
                // Start 05.KATHIR
                //Postcode.LookUpPostCode(City,"Post Code",TRUE);
                Postcode.LookupPostCode(City, "Post Code", State, "Country Code");
                // Stop 05.KATHIR
            end;

            trigger OnValidate()
            begin
                // Start 04.KATHIR
                //Postcode.ValidatePostCode(City,"Post Code");
                Postcode.ValidatePostCode(City, "Post Code", State, "Country Code", (CurrFieldNo <> 0) and GuiAllowed);
                // Stop 04.KATHIR
            end;
        }
        field(29; "Country Code"; Code[10])
        {
            Caption = 'Country Code';
            TableRelation = "Country/Region";
        }
        field(30; "E-Mail Address"; Text[50])
        {
            Caption = 'E-Mail Address';
            ExtendedDatatype = EMail;
        }
        field(31; "Mobile Number"; Text[30])
        {
            Caption = 'Mobile Number';
        }
        field(32; "Phone Number"; Text[30])
        {
            Caption = 'Phone Number';
            ExtendedDatatype = PhoneNo;
        }
        field(33; State; Text[30])
        {
            Caption = 'State';
        }
        field(34; "No Series"; Code[20])
        {
            Caption = 'No Series';
        }
        field(35; Age; Integer)
        {
            BlankZero = true;
            Caption = 'Age';
            Editable = false;
        }
        field(36; Months; Integer)
        {
            BlankZero = true;
            Caption = 'Months';
            Editable = false;
        }
        field(38; Campaign; Code[20])
        {
            Caption = 'Campaign';
            TableRelation = Campaign;
        }
        field(2000; "Address 3"; Text[100])
        {
            Caption = 'Address 3';
        }
        field(2001; "Enquiry Closed"; Boolean)
        {
            Caption = 'Enquiry Closed';
        }
        field(70120; "User ID"; Code[20])
        {
            Caption = 'User ID';
        }
        field(70121; "Portal ID"; Code[20])
        {
            Caption = 'Portal ID';
        }
    }

    keys
    {
        key(Key1; "No.")
        {
            Clustered = true;
        }
        key(Key2; "Class Applied", "Curriculum Intrested", "Academic Year")
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    begin
        // Start 01.KATHIR

        AdmSetup.Get;
        if "No Series" = '' then begin
            AdmSetup.TestField("Enquiry No.");
            NoSeriesMgt.InitSeries(AdmSetup."Enquiry No.", xRec."No Series", 0D, "No.", "No Series");
        end;

        // Stop 01.KATHIR

        // Start 07.KATHIR
        "Academic Year" := EduVert.GetAdmissionYear;
        // Stop 07.KATHIR

        // Start 09.KAHTHIR
        "Enquiry Date" := WorkDate;
        // Stop 09.KATHIR

        // Start 10.VANDHANA
        "User ID" := UserId;
        // Stop 10.VANDHANA
    end;

    var
        AdmSetup: Record "Admission Setup";
        NoSeriesMgt: Codeunit NoSeriesManagement;
        Enquiry: Record Enquiry;
        Postcode: Record "Post Code";
        EduVert: Codeunit "Education Vertical";
        Age2: Decimal;
        TempAge: Decimal;
        ClassCard: Record "Class Card";
        ClassCardLook: Record "Class Card";
        Text000: Label 'Age limit exceeded';

    [Scope('Internal')]
    procedure Assistedit(OldEnquiry: Record Enquiry): Boolean
    begin
        // Start 06.KATHIR
        with Enquiry do begin
            Enquiry := Rec;
            AdmSetup.Get;
            AdmSetup.TestField("Enquiry No.");
            if NoSeriesMgt.SelectSeries(AdmSetup."Enquiry No.", OldEnquiry."No Series", "No Series") then begin
                NoSeriesMgt.SetSeries("No.");
                Rec := Enquiry;
                exit(true);
            end;
        end;
        // Stop 06.KATHIR
    end;
}

