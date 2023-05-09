codeunit 50137 "Charts Manager"
{
    trigger OnRun()
    begin

    end;


    procedure GenerateData(var buffer: Record "Business Chart Buffer"; chartsToShow: Record 50133)
    var
        item: Record 27;
        sales: Record "Sales Line";
        i: Integer;
    begin

        with buffer do begin
            Initialize();

            if chartsToShow."Show Profit or Sales" = chartsToShow."Show Profit or Sales"::"Product by Profit" then
                AddMeasure('Product by Profit', 1, "Data Type"::Decimal, chartsToShow.Charts)
            else
                AddMeasure('Product by Sales', 1, "Data Type"::Decimal, chartsToShow.Charts);

            SetXAxis('Product', "Data Type"::String);

            if item.FindSet() then begin
                repeat


                    AddColumn((item."No."));
                    if chartsToShow."Show Profit or Sales" = chartsToShow."Show Profit or Sales"::"Product by Profit" then
                        SetValueByIndex(0, i, item."Unit Price")
                    else
                        SetValueByIndex(0, i, item."Unit Cost");
                    i += 1;
                until (item.Next() = 0) OR (i >= 10);
            end;
        end;
    end;

    procedure DrillDown(itenNo: Text)
    var
        item: Record 27;
    begin
        item.SetRange("No.", itenNo);
        Page.Run(Page::"Item List", item);
    end;
}