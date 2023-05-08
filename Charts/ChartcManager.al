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
        // chartsToShow.SetRange("User ID", UserId);
        // if not chartsToShow.FindFirst() then
        //     Page.RunModal(Page::"Tupper Sales Charts");

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

}

// var
//     buffer: Record "Business Chart Buffer" temporary;
//     item: Record Item;
//     sales: Record "Sales Line";
//     i: Integer;
// begin
//     buffer.Initialize();
//     i := 0;
//     buffer.AddMeasure('Qty', 1, buffer."Data Type"::Integer, buffer."Chart Type"::Column);
//     buffer.SetXAxis('Description', buffer."Data Type"::String);

//     if sales.FindFirst() then
//         repeat

//             if sales."Quantity Shipped" <> 0 then begin
//                 buffer.AddColumn(sales."No.");
//                 buffer.SetValueByIndex(0, i, sales."Quantity Shipped"); // 0 based not 1 like normal in AL 
//                 i += 1
//             end;
//         until (sales.Next() = 0) OR (i >= 10);
//     buffer.Update(CurrPage.Chart);
// end;