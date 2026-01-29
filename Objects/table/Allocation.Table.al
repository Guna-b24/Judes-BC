table 50012 Allocation
{

    fields
    {
        field(1; "Document No"; Code[20])
        {
            Editable = true;
        }
        field(2; "Line No."; Integer)
        {
            Editable = false;
        }
        field(3; Company; Text[30])
        {
            Editable = true;
            TableRelation = Company;
        }
        field(4; Balance; Decimal)
        {
            Editable = false;
        }
        field(5; Amount; Decimal)
        {

            trigger OnValidate()
            begin

                AllocationRec.Reset;
                AllocationRec.SetRange(AllocationRec."Document No", "Document No");
                AllocationRec.SetRange(AllocationRec."Line No.", "Line No.");
                AllocationRec.SetFilter(AllocationRec.Cnt, '<>%1', Cnt);
                if AllocationRec.FindSet then
                    repeat
                        Tot := Tot + AllocationRec.Amount;
                    until AllocationRec.Next = 0;

                GenJnlLineRec.Reset;
                GenJnlLineRec.SetRange(GenJnlLineRec."Document No.", "Document No");
                GenJnlLineRec.SetRange(GenJnlLineRec."Line No.", "Line No.");
                if GenJnlLineRec.FindFirst then begin
                    if (Tot + Amount) > GenJnlLineRec."Credit Amount" then
                        Error('Total Value Exeeds the amount entered in Journal');
                end;


                /*
                CASE Cnt OF


                1  :  BEGIN
                        CLEAR(Tot);
                        AllocationRec.RESET;
                        AllocationRec.SETRANGE(AllocationRec."Document No","Document No");
                        AllocationRec.SETRANGE(AllocationRec."Line No.","Line No.");
                        AllocationRec.SETFILTER(AllocationRec.Cnt,'<>%1',Cnt);
                        IF AllocationRec.FINDSET THEN
                        REPEAT
                          Tot:=Tot+AllocationRec.Amount;
                        UNTIL AllocationRec.NEXT = 0;
                       // IF Tot+Amount- > GenJnlLineRec."Credit Amount" THEN
                        //  ERROR('Total Value Exeeds the amount entered in Journal')
                      //  ELSE
                        BEGIN
                          AllocationRec.RESET;
                          AllocationRec.SETRANGE(AllocationRec."Document No","Document No");
                          AllocationRec.SETRANGE(AllocationRec."Line No.","Line No.");
                          AllocationRec.SETRANGE(AllocationRec.Cnt,2);
                          IF AllocationRec.FINDFIRST THEN
                          BEGIN
                             Temp:=Tot-AllocationRec.Amount-xRec.Amount;


                           // MESSAGE('%1',GenJnlLineRec."Credit Amount" - Tot);
                          //  EXIT;
                           // MESSAGE('%1',AllocationRec.Amount);
                            AllocationRec.Amount:=  GenJnlLineRec."Credit Amount" - (Temp + Amount) ;
               //             MESSAGE('%1',AllocationRec.Amount);
                            AllocationRec.MODIFY;
                          END;

                        END;

                      END;

                2  :  BEGIN
                        AllocationRec.RESET;
                        AllocationRec.SETRANGE(AllocationRec."Document No","Document No");
                        AllocationRec.SETRANGE(AllocationRec."Line No.","Line No.");
                        AllocationRec.SETFILTER(AllocationRec.Cnt,'<>%1',Cnt);
                        IF AllocationRec.FINDSET THEN
                        REPEAT
                          Tot:=Tot+AllocationRec.Amount;
                        UNTIL AllocationRec.NEXT = 0;
                        IF Tot+Amount > GenJnlLineRec."Credit Amount" THEN
                          ERROR('Total Value Exeeds the amount entered in Journal')
                        ELSE
                        BEGIN
                          AllocationRec.RESET;
                          AllocationRec.SETRANGE(AllocationRec."Document No","Document No");
                          AllocationRec.SETRANGE(AllocationRec."Line No.","Line No.");
                          AllocationRec.SETRANGE(AllocationRec.Cnt,3);
                          IF AllocationRec.FINDFIRST THEN
                          BEGIN
                            AllocationRec.Amount:=  GenJnlLineRec."Credit Amount" - Tot;
                            AllocationRec.MODIFY;
                          END;

                        END;


                      END;

                3  :  BEGIN
                        AllocationRec.RESET;
                        AllocationRec.SETRANGE(AllocationRec."Document No","Document No");
                        AllocationRec.SETRANGE(AllocationRec."Line No.","Line No.");
                        AllocationRec.SETFILTER(AllocationRec.Cnt,'<>%1',Cnt);
                        IF AllocationRec.FINDSET THEN
                        REPEAT
                          Tot:=Tot+AllocationRec.Amount;
                        UNTIL AllocationRec.NEXT = 0;
                        IF Tot+Amount > GenJnlLineRec."Credit Amount" THEN
                          ERROR('Total Value Exeeds the amount entered in Journal')
                        ELSE
                        BEGIN
                          AllocationRec.RESET;
                          AllocationRec.SETRANGE(AllocationRec."Document No","Document No");
                          AllocationRec.SETRANGE(AllocationRec."Line No.","Line No.");
                          AllocationRec.SETRANGE(AllocationRec.Cnt,4);
                          IF AllocationRec.FINDFIRST THEN
                          BEGIN
                            AllocationRec.Amount:=  GenJnlLineRec."Credit Amount" - Tot;
                            AllocationRec.MODIFY;
                          END;

                        END;

                       END;

                4  :  BEGIN
                        AllocationRec.RESET;
                        AllocationRec.SETRANGE(AllocationRec."Document No","Document No");
                        AllocationRec.SETRANGE(AllocationRec."Line No.","Line No.");
                        AllocationRec.SETFILTER(AllocationRec.Cnt,'<>%1',Cnt);
                        IF AllocationRec.FINDSET THEN
                        REPEAT
                          Tot:=Tot+AllocationRec.Amount;
                        UNTIL AllocationRec.NEXT = 0;
                        IF Tot+Amount > GenJnlLineRec."Credit Amount" THEN
                          ERROR('Total Value Exeeds the amount entered in Journal')
                        ELSE
                        BEGIN
                          AllocationRec.RESET;
                          AllocationRec.SETRANGE(AllocationRec."Document No","Document No");
                          AllocationRec.SETRANGE(AllocationRec."Line No.","Line No.");
                          AllocationRec.SETRANGE(AllocationRec.Cnt,3);
                          IF AllocationRec.FINDFIRST THEN
                          BEGIN
                            AllocationRec.Amount:=  GenJnlLineRec."Credit Amount" - Tot;
                            AllocationRec.MODIFY;
                          END;

                        END;

                      END;

                END; // Case




             */







                /*
                AllocationRec.RESET;
                AllocationRec.SETRANGE(AllocationRec."Document No","Document No");
                AllocationRec.SETRANGE(AllocationRec."Line No.","Line No.");
                AllocationRec.SETFILTER(AllocationRec.Cnt,'<>%1',Cnt);
                IF AllocationRec.FINDSET THEN
                REPEAT
                  Tot:=Tot+AllocationRec.Amount;
                UNTIL AllocationRec.NEXT = 0;




                GenJnlLineRec.RESET;
                GenJnlLineRec.SETRANGE(GenJnlLineRec."Document No.","Document No");
                GenJnlLineRec.SETRANGE(GenJnlLineRec."Line No.","Line No.");
                IF GenJnlLineRec.FINDFIRST THEN
                BEGIN
                  IF (Tot + Amount-xRec.Amount) > GenJnlLineRec."Credit Amount" THEN
                    ERROR('Total Value Exeeds the amount entered in Journal');
                END;

                {GenJnlLineRec.RESET;
                GenJnlLineRec.SETRANGE(GenJnlLineRec."Document No.","Document No");
                GenJnlLineRec.SETRANGE(GenJnlLineRec."Line No.","Line No.");
                IF GenJnlLineRec.FINDFIRST THEN
                BEGIN
                  IF (Tot + Amount-xRec.Amount) < GenJnlLineRec."Credit Amount" THEN

                END;

                 }
                 */

            end;
        }
        field(6; Cnt; Integer)
        {
        }
        field(7; "Student No."; Code[20])
        {
            TableRelation = Customer;
        }
        field(8; "Type Of Payment"; Option)
        {
            OptionCaption = ' ,Cash,Cheque';
            OptionMembers = " ",Cash,Cheque;
        }
        field(9; "Posting Date"; Date)
        {
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
        Tot: Decimal;
        GenJnlLineRec: Record "Gen. Journal Line";
        Temp: Decimal;
}

