table 71001 Enquiry
{
    Caption = 'Enquiry';
    DataClassification = CustomerContent;
    //LookupPageID = 71002;

    fields
    {
        field(1; "No."; Code[20])
        {
            Caption = 'No.';
            DataClassification = CustomerContent;
        }
        field(2; Name; Text[50])
        {
            Caption = 'Name';
            DataClassification = CustomerContent;
        }
        field(3; "Enquiry Gender"; Option)
        {
            Caption = 'Gender';
            DataClassification = CustomerContent;
            OptionCaption = ' ,Male,Female';
            OptionMembers = " ",Male,Female;
        }
        field(4; "Type Of Enquiry"; Code[10])
        {
            Caption = 'Type Of Enquiry';
            DataClassification = CustomerContent;
            TableRelation = "Enquiry Type";
        }
        field(5; "Enquiry Source"; Code[10])
        {
            Caption = 'Enquiry Source';
            DataClassification = CustomerContent;
            TableRelation = "Enquiry Source";
        }
        field(6; "Enquirer Name"; Text[50])
        {
            Caption = 'Enquirer Name';
            DataClassification = CustomerContent;
        }
        field(7; "Relationship with Applicant"; Text[30])
        {
            Caption = 'Relationship with Applicant';
            DataClassification = CustomerContent;
        }
        field(8; "Media Vehicle"; Code[20])
        {
            Caption = 'Media Vehicle';
            TableRelation = "Media Vehicle";
            DataClassification = CustomerContent;
        }
        field(9; "Date of Birth"; Date)
        {
            Caption = 'Date of Birth';
            DataClassification = CustomerContent;

            trigger OnValidate()
            begin
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
            end;
        }
        field(10; "Father's Name"; Text[50])
        {
            Caption = 'Father''s Name';
            DataClassification = CustomerContent;
        }
        field(11; "Mother's Name"; Text[50])
        {
            Caption = 'Mother''s Name';
            DataClassification = CustomerContent;
        }
        field(12; Citizenship; Code[10])
        {
            Caption = 'Citizenship';
            DataClassification = CustomerContent;
            TableRelation = Citizenship;
        }
        field(13; "Academic Year"; Code[20])
        {
            Caption = 'Academic Year';
            DataClassification = CustomerContent;
            TableRelation = "Academic Year";
        }
        field(14; "Enquiry Date"; Date)
        {
            Caption = 'Enquiry Date';
            DataClassification = CustomerContent;
        }
        field(15; "Class Applied"; Code[10])
        {
            Caption = 'Class Applied';
            DataClassification = CustomerContent;
            TableRelation = "Class Card";

            trigger OnLookup()
            begin
                ClassCardLook.LookUpClass("Class Applied", "Curriculum Intrested", "Academic Year");

            end;

            trigger OnValidate()
            begin

                ClassCardLook.ValidateClass("Class Applied", "Curriculum Intrested", "Academic Year");

            end;
        }
        field(16; "Hostel Accomodation"; Boolean)
        {
            Caption = 'Hostel Accomodation';
            DataClassification = CustomerContent;
        }
        field(17; "Name Of The Previous Institute"; Text[80])
        {
            Caption = 'Name Of The Previous Institute';
            DataClassification = CustomerContent;
        }
        field(18; "Medium Of Instruction"; Code[10])
        {
            Caption = 'Medium Of Instruction';
            DataClassification = CustomerContent;
            TableRelation = "Medium of Instruction";
        }
        field(20; "Curriculum Intrested"; Code[20])
        {
            Caption = 'Curriculum Intrested';
            DataClassification = CustomerContent;
            TableRelation = "Class Card".Curriculum;

            trigger OnLookup()
            begin
                ClassCardLook.LookUpCurriculum("Class Applied", "Curriculum Intrested", "Academic Year");
            end;

            trigger OnValidate()
            begin

                ClassCardLook.ValidateCurriculum("Class Applied", "Curriculum Intrested", "Academic Year");

            end;
        }
        field(21; "Class Last Attended"; Code[10])
        {
            Caption = 'Class Last Attended';
            DataClassification = CustomerContent;
            TableRelation = Class;
        }
        field(22; "Curriculum Followed"; Code[10])
        {
            Caption = 'Curriculum Followed';
            DataClassification = CustomerContent;
            TableRelation = Curriculum;
        }
        field(23; "Address To"; Code[10])
        {
            Caption = 'Address To';
            DataClassification = CustomerContent;
            TableRelation = Relative;
        }
        field(24; Addressee; Text[50])
        {
            Caption = 'Addressee';
            DataClassification = CustomerContent;
        }
        field(25; "Address 1"; Text[50])
        {
            Caption = 'Address 1';
            DataClassification = CustomerContent;
        }
        field(26; "Address 2"; Text[50])
        {
            Caption = 'Address 2';
            DataClassification = CustomerContent;
        }
        field(27; City; Text[30])
        {
            Caption = 'City';
            DataClassification = CustomerContent;

            trigger OnLookup()
            begin
                Postcode.LookupPostCode(City, "Post Code", State, "Country Code");
            end;

            trigger OnValidate()
            begin

                Postcode.ValidateCity(City, "Post Code", State, "Country Code", (CurrFieldNo <> 0) and GuiAllowed);
            end;
        }
        field(28; "Post Code"; Code[20])
        {
            Caption = 'Post Code';
            DataClassification = CustomerContent;
            TableRelation = "Post Code";

            trigger OnLookup()
            var
                Citytxt: Text;
                Statetxt: Text;

            begin
                Postcode.LookupPostCode(citytxt, "Post Code", statetxt, "Country Code");
                Validate(city, Citytxt);
                Validate(State, statetxt);
            end;

            trigger OnValidate()
            begin
                Postcode.ValidatePostCode(City, "Post Code", State, "Country Code", (CurrFieldNo <> 0) and GuiAllowed);

            end;
        }
        field(29; "Country Code"; Code[10])
        {
            Caption = 'Country Code';
            DataClassification = CustomerContent;
            TableRelation = "Country/Region";
        }
        field(30; "E-Mail Address"; Text[50])
        {
            Caption = 'E-Mail Address';
            DataClassification = CustomerContent;
            ExtendedDatatype = EMail;
        }
        field(31; "Mobile Number"; Text[30])
        {
            Caption = 'Mobile Number';
            DataClassification = CustomerContent;
        }
        field(32; "Phone Number"; Text[30])
        {
            Caption = 'Phone Number';
            DataClassification = CustomerContent;
            ExtendedDatatype = PhoneNo;
        }
        field(33; State; Text[30])
        {
            Caption = 'State';
            DataClassification = CustomerContent;
        }
        field(34; "Enquiry No Series"; Code[20])
        {
            Caption = 'No Series';
            DataClassification = CustomerContent;
        }
        field(35; Age; Integer)
        {
            BlankZero = true;
            Caption = 'Age';
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(36; Months; Integer)
        {
            BlankZero = true;
            Caption = 'Months';
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(38; Campaign; Code[20])
        {
            Caption = 'Campaign';
            DataClassification = CustomerContent;
            TableRelation = Campaign;
        }
        field(2000; "Address 3"; Text[100])
        {
            Caption = 'Address 3';
            DataClassification = CustomerContent;
        }
        field(2001; "Enquiry Closed"; Boolean)
        {
            Caption = 'Enquiry Closed';
            DataClassification = CustomerContent;
        }
        field(70121; "Portal ID"; Code[20])
        {
            Caption = 'Portal ID';
            DataClassification = CustomerContent;
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


        if "No." = '' then begin
            AdmSetup.Get();
            AdmSetup.TestField("Enquiry No.");
            "Enquiry No Series" := AdmSetup."Enquiry No.";
            "No." := NoSeriesMgt.GetNextNo("Enquiry No Series");
        end;

        "Academic Year" := EduVert.GetAdmissionYear();
        "Enquiry Date" := WorkDate();
    end;

    var
        AdmSetup: Record "Admission Setup";
        Enquiry: Record Enquiry;
        Postcode: Record "Post Code";
        ClassCardLook: Record "Class Card";
        EduVert: Codeunit "Education Vertical";
        NoSeriesMgt: Codeunit "No. Series";
        Age2: Decimal;
        TempAge: Decimal;

        Text000: Label 'Age limit exceeded';


    procedure Assistedit(OldEnquiry: Record Enquiry): Boolean
    begin
        Enquiry := Rec;
        AdmSetup.Get();
        AdmSetup.TestField("Enquiry No.");
        if NoSeriesMgt.LookupRelatedNoSeries(AdmSetup."Enquiry No.", OldEnquiry."Enquiry No Series", "Enquiry No Series") then begin
            Enquiry."No." := NoSeriesMgt.GetNextNo(Enquiry."Enquiry No Series");
            Rec := Enquiry;
            exit(true);
        end;
    end;

}

