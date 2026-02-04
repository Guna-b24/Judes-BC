table 50012 Allocation
{
    fields
    {
        field(1; "Document No"; Code[20])
        {
            Editable = true;
            Caption = 'Document No';
            ToolTip = 'Specifies the document number for this allocation.';
            DataClassification = SystemMetadata;
        }
        field(2; "Line No."; Integer)
        {
            Caption = 'Line No.';
            Editable = false;
            ToolTip = 'Specifies the line number within the allocation document.';
            DataClassification = SystemMetadata;
        }
        field(3; Company; Text[30])
        {
            Caption = 'Company';
            Editable = true;
            TableRelation = Company;
            ToolTip = 'Specifies the company for which the allocation is created.';
            DataClassification = CustomerContent;
        }
        field(4; Balance; Decimal)
        {
            Caption = 'Balance';
            Editable = false;
            ToolTip = 'Specifies the balance amount available for allocation.';
            DataClassification = CustomerContent;
        }
        field(5; Amount; Decimal)
        {
            Caption = 'Amount';
            ToolTip = 'Specifies the amount to be allocated.';
            DataClassification = CustomerContent;
            trigger OnValidate()
            begin

                AllocationRec.Reset();
                AllocationRec.SetRange(AllocationRec."Document No", "Document No");
                AllocationRec.SetRange(AllocationRec."Line No.", "Line No.");
                AllocationRec.SetFilter(AllocationRec.Cnt, '<>%1', Cnt);

                if AllocationRec.FindSet() then
                    repeat
                        Tot := Tot + AllocationRec.Amount;
                    until AllocationRec.Next() = 0;

                GenJnlLineRec.Reset();
                GenJnlLineRec.SetRange(GenJnlLineRec."Document No.", "Document No");
                GenJnlLineRec.SetRange(GenJnlLineRec."Line No.", "Line No.");

                if GenJnlLineRec.FindFirst() then
                    if (Tot + Amount) > GenJnlLineRec."Credit Amount" then
                        Error('Total Value Exceeds the amount entered in Journal');

            end;

        }
        field(6; Cnt; Integer)
        {
            ToolTip = 'Specifies a counter or helper value for allocation processing.';
            DataClassification = SystemMetadata;
        }
        field(7; "Student No."; Code[20])
        {
            Caption = 'Student No.';
            TableRelation = Customer;
            ToolTip = 'Specifies the student/customer number associated with this allocation.';
            DataClassification = EndUserIdentifiableInformation;
        }
        field(8; "Type Of Payment"; Option)
        {
            Caption = 'Type Of Payment';
            OptionCaption = ' ,Cash,Cheque';
            OptionMembers = " ",Cash,Cheque;
            ToolTip = 'Specifies the type of payment used for this allocation.';
            DataClassification = CustomerContent;
        }
        field(9; "Posting Date"; Date)
        {
            Caption = 'Posting Date';
            ToolTip = 'Specifies the posting date for this allocation record.';
            DataClassification = SystemMetadata;
        }
    }

    keys
    {
        key(Key1; "Document No", "Line No.", Company)
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    var
        AllocationRec: Record Allocation;
        GenJnlLineRec: Record "Gen. Journal Line";
        Tot: Decimal;
}

