page 50133 "Tupper Sales Charts"
{
    PageType = Card;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = "Sales Line";
    Caption = 'Tupper Sales Charts';
    DeleteAllowed = false;
    InsertAllowed = false;

    layout
    {
        area(Content)
        {
            group(General)
            {
                Caption = 'General';
                field(Product; Rec."No.")
                {
                    ApplicationArea = All;
                }

                field(ProdúctName; Rec.Description)
                {
                    ApplicationArea = All;
                }
            }
            group(ChartToShow)
            {
                Caption = 'Item Chart';
                usercontrol(Chart; "Microsoft.Dynamics.Nav.Client.BusinessChart")
                {
                    ApplicationArea = All;
                    trigger AddInReady()
                    var
                        buffer: Record "Business Chart Buffer";
                        item: Record Item;
                        sales: Record "Sales Line";
                        i: Integer;
                    begin
                        buffer.Initialize();
                        // index 0
                        buffer.AddMeasure('Qty', 1, buffer."Data Type"::Integer, buffer."Chart Type"::Column);
                        buffer.SetXAxis('Description', buffer."Data Type"::String);

                        if sales.FindFirst() then
                            repeat

                                if sales."Quantity Shipped" <> 0 then begin
                                    buffer.AddColumn(sales.Description);
                                    buffer.SetValueByIndex(0, i, sales."Amount Including VAT");
                                    buffer.SetValueByIndex(0, i, sales."Quantity Shipped"); // 0 based not 1 like normal in AL 
                                    i += 1
                                end;
                            until sales.Next() = 0;
                        buffer.Update(CurrPage.Chart);
                    end;
                }
            }
        }
    }

    var
        test: Record 27;
        testOrder: Record 37;
}