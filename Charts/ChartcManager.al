codeunit 50137 "Charts Manager"
{
    trigger OnRun()
    begin

    end;


    procedure GenerateData(var buffer: Record "Business Chart Buffer"; chartsToShow: Record 50133)
    var
        item: Record 27;
        sales: Record "Sales Line";
        catogory: Text;
        totalProfit: Decimal;
        totalQuantity: Decimal;
        i: Integer;
    begin
        catogory := '';
        with buffer do begin
            Initialize();

            item.SetFilter("Item Category Code", catogory);
            sales.SetRange("Shipment Date", chartsToShow."Start Date", chartsToShow."End Date");

            if chartsToShow."Show Profit or Sales" = chartsToShow."Show Profit or Sales"::"Product by Profit" then
                AddMeasure('Product by Profit', 1, "Data Type"::Decimal, chartsToShow.Charts)
            else
                AddMeasure('Product by Sales', 1, "Data Type"::Decimal, chartsToShow.Charts);

            SetXAxis('Product', "Data Type"::String);

            if item.FindSet() then begin
                repeat
                    sales.SetFilter("No.", item."No.");
                    if sales.FindSet() then begin
                        repeat
                            totalProfit += sales.Quantity * item."Unit Price";
                            totalQuantity += sales.Quantity;

                        until sales.Next() = 0;
                    end;
                    if not (totalProfit = 0) then begin
                        AddColumn((item."No."));
                        if chartsToShow."Show Profit or Sales" = chartsToShow."Show Profit or Sales"::"Product by Profit" then
                            SetValueByIndex(0, i, totalProfit)
                        else
                            SetValueByIndex(0, i, totalQuantity);
                        i += 1;
                    end;
                    totalProfit := 0;
                    totalQuantity := 0;
                until (item.Next() = 0);
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