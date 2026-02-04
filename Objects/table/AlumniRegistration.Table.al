table 71180 "Alumni Registration"
{
    Caption = 'Alumni Registration';
    // DrillDownPageID = 71181;
    // LookupPageID = 71181;

    fields
    {
        field(1; "Student No."; Code[20])
        {
            Caption = 'Student No.';
            ToolTip = 'Specifies the student number of the alumni.';
            DataClassification = EndUserIdentifiableInformation;
        }
        field(2; Name; Text[50])
        {
            Caption = 'Name';
            ToolTip = 'Specifies the name of the alumni.';
            DataClassification = EndUserIdentifiableInformation;
        }
        field(3; Gender; Option)
        {
            Caption = 'Gender';
            OptionCaption = ' ,Male,Female';
            OptionMembers = " ",Male,Female;
            ToolTip = 'Specifies the gender of the alumni.';
            DataClassification = CustomerContent;
        }
        field(4; "Date of Birth"; Date)
        {
            Caption = 'Date of Birth';
            ToolTip = 'Specifies the date of birth.';
            DataClassification = EndUserIdentifiableInformation;
        }
        field(5; "Year Of Joining"; Integer)
        {
            Caption = 'Year Of Joining';
            ToolTip = 'Specifies the year of joining.';
            DataClassification = SystemMetadata;
        }
        field(6; "Year Of Graduation"; Integer)
        {
            Caption = 'Year Of Graduation';
            ToolTip = 'Specifies the year of graduation.';
            DataClassification = SystemMetadata;
        }
        field(7; "Class Of Graduation"; Option)
        {
            Caption = 'Class Of Graduation';
            OptionCaption = ' ,10,12';
            OptionMembers = " ","10","12";
            ToolTip = 'Specifies the class of graduation.';
            DataClassification = CustomerContent;
        }
        field(8; "Present Occupation"; Option)
        {
            Caption = 'Present Occupation';
            OptionCaption = ' ,Student,Employed,Self-Employed';
            OptionMembers = " ",Student,Employed,"Self-Employed";
            ToolTip = 'Specifies the present occupation.';
            DataClassification = CustomerContent;
        }
        field(9; "Bachelor Degree"; Text[80])
        {
            Caption = 'Bachelor Degree';
            TableRelation = "Course and Stream".Course where("Course Stream" = const('Bachelor Degree'));
            ToolTip = 'Specifies the bachelor degree.';
            DataClassification = CustomerContent;
        }
        field(11; "Master Degree"; Text[80])
        {
            Caption = 'Master Degree';
            TableRelation = "Course and Stream".Course where("Course Stream" = const('Master Degree'));
            ToolTip = 'Specifies the master degree.';
            DataClassification = CustomerContent;
        }
        field(12; PhD; Text[80])
        {
            Caption = 'PhD';
            TableRelation = "Course and Stream".Course where("Course Stream" = const('Doctoral degrees'));
            ToolTip = 'Specifies the doctoral degree.';
            DataClassification = CustomerContent;
        }
        field(13; "Medical Courses"; Option)
        {
            Caption = 'Medical Courses';
            OptionCaption = ' ,MBBS,BDS,MDS';
            OptionMembers = " ",MBBS,BDS,MDS;
            ToolTip = 'Specifies the medical course.';
            DataClassification = CustomerContent;
        }
        field(14; "Doctor of Medicine"; Text[80])
        {
            Caption = 'Doctor of Medicine';
            TableRelation = "Course and Stream".Course where("Course Stream" = const('MD'));
            ToolTip = 'Specifies the Doctor of Medicine qualification.';
            DataClassification = CustomerContent;
        }
        field(15; "Name of the Institution"; Text[30])
        {
            Caption = 'Name of the Institution';
            ToolTip = 'Specifies the institution name.';
            DataClassification = CustomerContent;
        }
        field(16; Qualification; Text[30])
        {
            Caption = 'Qualification';
            ToolTip = 'Specifies the qualification.';
            DataClassification = CustomerContent;
        }
        field(17; "Name of the Company"; Text[30])
        {
            Caption = 'Name of the Company';
            ToolTip = 'Specifies the company name.';
            DataClassification = CustomerContent;
        }
        field(18; Designation; Text[30])
        {
            Caption = 'Designation';
            ToolTip = 'Specifies the designation.';
            DataClassification = CustomerContent;
        }
        field(19; "Type of Business"; Text[30])
        {
            Caption = 'Type of Business';
            ToolTip = 'Specifies the type of business.';
            DataClassification = CustomerContent;
        }
        field(20; "Mobile Number"; Code[15])
        {
            Caption = 'Mobile Number';
            ExtendedDatatype = PhoneNo;
            ToolTip = 'Specifies the mobile number.';
            DataClassification = EndUserIdentifiableInformation;
        }
        field(21; Telephone; Code[15])
        {
            Caption = 'Telephone';
            ExtendedDatatype = PhoneNo;
            ToolTip = 'Specifies the telephone number.';
            DataClassification = EndUserIdentifiableInformation;
        }
        field(22; "E-mail"; Text[80])
        {
            Caption = 'E-mail';
            ExtendedDatatype = EMail;
            ToolTip = 'Specifies the email address.';
            DataClassification = EndUserIdentifiableInformation;
        }
        field(23; "Present-Address"; Text[250])
        {
            Caption = 'Present Address';
            ToolTip = 'Specifies the present address.';
            DataClassification = CustomerContent;
        }
        field(25; "Persent-City"; Code[20])
        {
            Caption = 'Present City';
            ToolTip = 'Specifies the present city.';
            DataClassification = CustomerContent;
        }
        field(26; "Present-PostCode"; Code[20])
        {
            Caption = 'Present Post Code';
            ToolTip = 'Specifies the present post code.';
            DataClassification = CustomerContent;
        }
        field(27; "Present-State"; Code[20])
        {
            Caption = 'Present State';
            ToolTip = 'Specifies the present state.';
            DataClassification = CustomerContent;
        }
        field(28; "Present-Country"; Code[20])
        {
            Caption = 'Present Country';
            ToolTip = 'Specifies the present country.';
            DataClassification = CustomerContent;
        }
        field(29; "Permanent-Address"; Text[250])
        {
            Caption = 'Permanent Address';
            ToolTip = 'Specifies the permanent address.';
            DataClassification = CustomerContent;
        }
        field(31; "Permanent-City"; Code[20])
        {
            Caption = 'Permanent City';
            ToolTip = 'Specifies the permanent city.';
            DataClassification = CustomerContent;
        }
        field(32; "Permanent-PostCode"; Code[20])
        {
            Caption = 'Permanent Post Code';
            ToolTip = 'Specifies the permanent post code.';
            DataClassification = CustomerContent;
        }
        field(33; "Permanent-State"; Code[20])
        {
            Caption = 'Permanent State';
            ToolTip = 'Specifies the permanent state.';
            DataClassification = CustomerContent;
        }
        field(34; "Permanent-Country"; Code[20])
        {
            Caption = 'Permanent Country';
            ToolTip = 'Specifies the permanent country.';
            DataClassification = CustomerContent;
        }
        field(35; Achievements; Text[250])
        {
            Caption = 'Achievements';
            ToolTip = 'Specifies achievements.';
            DataClassification = CustomerContent;
        }
        field(36; Hobbies; Text[100])
        {
            Caption = 'Hobbies';
            ToolTip = 'Specifies hobbies.';
            DataClassification = CustomerContent;
        }
        field(37; Comments; Text[250])
        {
            Caption = 'Comments';
            ToolTip = 'Specifies comments.';
            DataClassification = CustomerContent;
        }
        field(70121; "Portal ID"; Code[20])
        {
            Caption = 'Portal ID';
            ToolTip = 'Specifies the portal ID.';
            DataClassification = SystemMetadata;
        }
        field(70122; Mobile2; Code[15])
        {
            Caption = 'Alternate Mobile Number';
            ExtendedDatatype = PhoneNo;
            ToolTip = 'Specifies alternate mobile number.';
            DataClassification = EndUserIdentifiableInformation;
        }
        field(70123; QualificationName; Text[100])
        {
            Caption = 'Qualification Name';
            ToolTip = 'Specifies qualification name.';
            DataClassification = CustomerContent;
        }
        field(70124; BachelorInstitute; Text[50])
        {
            Caption = 'Bachelor Institute';
            ToolTip = 'Specifies bachelor institute.';
            DataClassification = CustomerContent;
        }
        field(70125; MasterInstitute; Text[50])
        {
            Caption = 'Master Institute';
            ToolTip = 'Specifies master institute.';
            DataClassification = CustomerContent;
        }
        field(70126; PhDInstitute; Text[50])
        {
            Caption = 'PhD Institute';
            ToolTip = 'Specifies PhD institute.';
            DataClassification = CustomerContent;
        }
        field(70127; MedicalInstitute; Text[50])
        {
            Caption = 'Medical Institute';
            ToolTip = 'Specifies medical institute.';
            DataClassification = CustomerContent;
        }
        field(70128; MDInstitute; Text[50])
        {
            Caption = 'MD Institute';
            ToolTip = 'Specifies MD institute.';
            DataClassification = CustomerContent;
        }
        field(70129; MS; Text[50])
        {
            Caption = 'MS';
            ToolTip = 'Specifies MS qualification.';
            DataClassification = CustomerContent;
        }
        field(70130; MSInstitute; Text[50])
        {
            Caption = 'MS Institute';
            ToolTip = 'Specifies MS institute.';
            DataClassification = CustomerContent;
        }
        field(70131; AgreeToUseComment; Boolean)
        {
            Caption = 'Agree To Use Comment';
            ToolTip = 'Specifies consent to use comments.';
            DataClassification = SystemMetadata;
        }
        field(70132; IsRegistered; Boolean)
        {
            Caption = 'Is Registered';
            ToolTip = 'Specifies whether alumni is registered.';
            DataClassification = SystemMetadata;
        }
        field(70133; Event1; Boolean)
        {
            Caption = 'Event 1';
            ToolTip = 'Specifies event 1 participation.';
            DataClassification = SystemMetadata;
        }
        field(70134; Event1Desc; Text[150])
        {
            Caption = 'Event 1 Description';
            ToolTip = 'Specifies event 1 description.';
            DataClassification = CustomerContent;
        }
        field(70135; Event2; Boolean)
        {
            Caption = 'Event 2';
            ToolTip = 'Specifies event 2 participation.';
            DataClassification = SystemMetadata;
        }
        field(70136; Event2Desc; Text[150])
        {
            Caption = 'Event 2 Description';
            ToolTip = 'Specifies event 2 description.';
            DataClassification = CustomerContent;
        }
    }

    keys
    {
        key(Key1; "Student No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
    var
}
