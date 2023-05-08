page 50133 "Tupper Sales Charts"
{

    Caption = 'Tupper Sales Charts';
    PageType = Card;
    SourceTable = "Tupper Sales Table";

    layout
    {
        area(Content)
        {
            group(General)
            {
                Caption = 'General';
                field("Charts"; Rec.Charts)
                {
                    ApplicationArea = All;

                    trigger OnValidate()
                    var
                        buffer: Record "Business Chart Buffer";
                    begin
                        ChartMgt.GenerateData(buffer, Rec);
                        buffer.Update(CurrPage.Chart);
                    end;
                }

                field("Show Profit or Sales"; Rec."Show Profit or Sales")
                {
                    ApplicationArea = All;

                    trigger OnValidate()
                    var
                        buffer: Record "Business Chart Buffer";
                    begin
                        ChartMgt.GenerateData(buffer, Rec);
                        buffer.Update(CurrPage.Chart);
                    end;
                }
            }
            group(ChartToShow)
            {
                Caption = 'Item Chart';
                usercontrol(Chart; "Microsoft.Dynamics.Nav.Client.BusinessChart")
                {
                    ApplicationArea = Basic, Suit;

                    trigger DataPointClicked(point: JsonObject)
                    var
                        JsonTokenItem: JsonToken;
                        JsonText: Text;
                    begin
                        if point.Get('XValueString', JsonTokenItem) then begin
                            JsonText := Format(JsonTokenItem);
                            JsonText := DelChr(JsonText, '=', '"');
                            ChartMgt.DrillDown(JsonText);
                        end;
                    end;

                    trigger AddInReady()
                    var
                        buffer: Record "Business Chart Buffer";
                        ChartMgt: Codeunit 50137;
                    begin
                        ChartMgt.GenerateData(buffer, Rec);
                        buffer.Update(CurrPage.Chart);
                    end;
                    // var
                    //     buffer: Record "Business Chart Buffer";
                    //     chartsToShow: Record 50133;
                    //     item: Record Customer;
                    //     sales: Record "Sales Line";
                    //     i: Integer;
                    // begin
                    //     with buffer do begin
                    //         Initialize();
                    //         //     buffer.AddMeasure('Qty', 1, buffer."Data Type"::Integer, buffer."Chart Type"::Column);
                    //         if chartsToShow."Show Profit or Sales" = chartsToShow."Show Profit or Sales"::"Product by Profit" then
                    //             AddMeasure('Product by Profit', 1, "Data Type"::Decimal, chartsToShow.Charts)
                    //         else
                    //             AddMeasure('Product by Sales', 1, "Data Type"::Decimal, chartsToShow.Charts);

                    //         SetXAxis('Product', "Data Type"::String);

                    //         if item.FindSet() then begin
                    //             repeat
                    //                 item.CalcFields("Balance (LCY)");
                    //                 item.CalcFields(Balance);

                    //                 AddColumn((item."No."));
                    //                 if chartsToShow."Show Profit or Sales" = chartsToShow."Show Profit or Sales"::"Product by Profit" then
                    //                     SetValueByIndex(0, i, item.Balance)
                    //                 else
                    //                     SetValueByIndex(0, i, item."Balance (LCY)");
                    //                 i += 1;
                    //             until (item.Next() = 0) OR (i >= 10);
                    //             Update(CurrPage.Chart);
                    //         end;
                    //     end;
                    // end;
                }
            }
        }
    }

    // trigger OnOpenPage()
    // begin
    //     if not GET(UserId) then begin
    //         "User ID" := UserId;
    //         Insert;
    //     end;
    //     FilterGroup(2);
    //     SetRange("UserID", UserId);
    //     FilterGroup(0);
    // end;
    var
        ChartMgt: Codeunit 50137;
        test: Record 27;
        testOrder: Record 37;
        chart: Record 760;
}