table 71011 "Application Optional Subjects"
{
    Caption = 'Application Optional Subjects';
    //LookupPageID = 71018;

    fields
    {
        field(1; "Application No"; Code[20])
        {
            Caption = 'Application No';
            ToolTip = 'Unique identifier for the application';
            DataClassification = CustomerContent;
        }
        field(2; "Subject Group"; Code[20])
        {
            Caption = 'Subject Group';
            TableRelation = "Subject Group";
            ToolTip = 'Group to which the subject belongs';
            DataClassification = CustomerContent;
        }
        field(3; Subject; Code[20])
        {
            Caption = 'Subject';
            TableRelation = Subject where("Subject Group" = field("Subject Group"));
            ToolTip = 'Subject selected by the applicant';
            DataClassification = CustomerContent;

            trigger OnValidate()
            begin
                if Subjectrec.Get(Subject) then
                    Description := Subjectrec.Description;
            end;
        }
        field(4; Description; Text[50])
        {
            Caption = 'Description';
            ToolTip = 'Name/Description of the subject';
            DataClassification = CustomerContent;
        }
        field(70121; "Portal ID"; Code[20])
        {
            Caption = 'Portal ID';
            ToolTip = 'Portal identifier for online tracking';
            DataClassification = CustomerContent;
        }
    }

    keys
    {
        key(Key1; "Application No", "Subject Group", Subject)
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    begin

    end;

    var
        Subjectrec: Record Subject;
}

