codeunit 72008 "General Functions"
{
    trigger OnRun()
    begin
    end;

    var
        ProgressWindow: Dialog;
        Counter: Integer;
        Indentation: Integer;


    procedure OpenWindow(TextMessage1: Text[50]; TextMessage2: Text[50])
    begin
        Counter := 0;
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


    procedure UpdateWindow(LEmployeeNo: Code[20]; NoofRecordsNew: Integer)
    begin
        Counter := Counter + 1;
        if NoofRecordsNew > 0 then begin
            ProgressWindow.Update(1, Round(Counter / NoofRecordsNew * 10000, 1));
            ProgressWindow.Update(2, LEmployeeNo);
            ProgressWindow.Update(3, Counter);
        end;
    end;


    procedure CloseWindow()
    begin
        ProgressWindow.Close();
    end;
}

