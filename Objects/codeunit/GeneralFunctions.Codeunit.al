codeunit 72008 "General Functions"
{
    // -----------------------------------------------------------------------------------------------
    // Firstware Sofware Solutions : Project Name : HR & PAYROLL
    // -----------------------------------------------------------------------------------------------
    // No.  Date          Developer     Spec/CU/CR      Description
    // -----------------------------------------------------------------------------------------------
    // 1    04.APR.2009   RAJAH.A                       New Codeunit Created for PAYROLL Module
    // -----------------------------------------------------------------------------------------------


    trigger OnRun()
    begin
    end;

    var
        ProgressWindow: Dialog;
        Counter: Integer;
        CounterOK: Integer;
        NoofRecordsNew: Integer;
        Indentation: Integer;

    [Scope('Internal')]
    procedure OpenWindow(TextMessage1: Text[50]; TextMessage2: Text[50])
    begin
        Counter := 0;
        CounterOK := 0;
        Indentation := StrLen(TextMessage2);

        if StrLen('Employee No') > Indentation then
            Indentation := StrLen('Employee No');

        if StrLen('Record No') > Indentation then
            Indentation := StrLen('Record No');

        ProgressWindow.Open(
          TextMessage1 +
          PadStr(TextMessage2, Indentation) + ' @1@@@@@@@@@@@@@@@@@@@@\' +
          PadStr('Employee No', Indentation) + ' #2######\' +
          PadStr('Record No', Indentation) + ' #3######');
    end;

    [Scope('Internal')]
    procedure UpdateWindow(LEmployeeNo: Code[20]; NoofRecordsNew: Integer)
    begin
        Counter := Counter + 1;
        if NoofRecordsNew > 0 then begin
            ProgressWindow.Update(1, Round(Counter / NoofRecordsNew * 10000, 1));
            ProgressWindow.Update(2, LEmployeeNo);
            ProgressWindow.Update(3, Counter);
        end;
    end;

    [Scope('Internal')]
    procedure CloseWindow()
    begin
        ProgressWindow.Close;
    end;
}

