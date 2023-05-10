/// <summary>
/// Communication to WooCommerce
/// </summary>
codeunit 50133 WebOut
{
    procedure NewItem(ItemId: Code[20])
    var
        ItemTable: Record Item;
        Client: HttpClient;
        Response: HttpResponseMessage;
        Content: HttpContent;
        contentHeaders: HttpHeaders;
    begin
        ItemTable.SetFilter("No.", ItemId);

        /// Json
        Content.WriteFrom('Hello');
        content.GetHeaders(contentHeaders);
        contentHeaders.Clear();
        contentHeaders.Add('Content-Type', 'application/json');
        client.DefaultRequestHeaders.Add('User-Agent', 'Dynamics 365');
        Client.Post('API Number', Content, Response)
    end;

    procedure ItenStock(ItemId: Code[20])
    var
        ItemTable: Record Item;
        Client: HttpClient;
        Response: HttpResponseMessage;
        Content: HttpContent;
        contentHeaders: HttpHeaders;
    begin
        ItemTable.SetFilter("No.", ItemId);

        /// Json

        Content.WriteFrom('Hello');
        content.GetHeaders(contentHeaders);
        contentHeaders.Clear();
        contentHeaders.Add('Content-Type', 'application/json');
        client.DefaultRequestHeaders.Add('User-Agent', 'Dynamics 365');
        Client.Post('API Number', Content, Response)
    end;
}
/// <summary>
/// Communication from WooCommerce
/// </summary>
codeunit 50134 WebIn
{
    local procedure NewCustomer(Id: Text)
    var
        Email: Codeunit EmailController;
        Json: Codeunit JsonContoller;
        CusId: Code[20];
    begin
        CusId := format(Id);

        Email.NewCusEmail(CusId);
    end;

    procedure NewSalesOrder(OrderInfo: Text)
    var
        SalesHeaderRec: Record "Sales Header";
        SalesLineRec: Record "Sales Line";
        CustTable: Record Customer;
        Email: Codeunit EmailController;
        Json: Codeunit JsonContoller;
        MainJsonObject: JsonObject;
        CostJsonToken: JsonToken;
        ShippJsonToken: JsonToken;
        JsonArryItem: JsonArray;
        ArryToken: JsonToken;
        OrderId: Integer;
        CusId: Text;
        CustEmail: Text;
        TypeDate: Date;
        OrderDate: Text;
        ValQuant: Decimal;
    begin
        MainJsonObject.ReadFrom(OrderInfo);
        MainJsonObject.Get('billing', CostJsonToken);
        CustEmail := Json.getFileIdTextAsText(CostJsonToken.AsObject(), 'email');

        CustTable.SetFilter("E-Mail", CustEmail);
        if NOT CustTable.FindSet() then begin
            NewCustomer(CusId);
            Email.NewOrderEmail(Format(OrderId));
        end;

        SalesHeaderRec.Init();
        CustTable.SetFilter("E-Mail", CustEmail);
        CustTable.FindFirst();
        SalesHeaderRec."Sell-to Customer Name" := CustTable.Name;
        SalesHeaderRec."Bill-to Customer No." := CustTable."No.";
        SalesHeaderRec."Bill-to Name" := CustTable.Name;
        SalesHeaderRec."Bill-to Address" := CustTable.Address;
        SalesHeaderRec."Bill-to City" := CustTable.City;
        SalesHeaderRec."Bill-to Post Code" := CustTable."Post Code";

        MainJsonObject.Get('shipping', ShippJsonToken);

        SalesHeaderRec."Ship-to Name" := Json.getFileIdTextAsText(ShippJsonToken.AsObject(), 'first_name');
        SalesHeaderRec."Ship-to Address" := Json.getFileIdTextAsText(ShippJsonToken.AsObject(), 'address_1');
        SalesHeaderRec."Ship-to City" := Json.getFileIdTextAsText(ShippJsonToken.AsObject(), 'city');
        SalesHeaderRec."Ship-to Post Code" := Json.getFileIdTextAsText(ShippJsonToken.AsObject(), 'postcode');

        OrderDate := Json.getFileIdTextAsText(MainJsonObject, 'date_created');
        OrderDate := CopyStr(OrderDate, 9, 2) + CopyStr(OrderDate, 6, 2) + CopyStr(OrderDate, 1, 4);
        Evaluate(TypeDate, OrderDate);

        SalesHeaderRec."Order Date" := TypeDate;
        SalesHeaderRec."Posting Date" := TypeDate;
        SalesHeaderRec."Shipment Date" := TypeDate;

        SalesHeaderRec."Payment Method Code" := 'KONTANT';
        SalesHeaderRec.Status := "Sales Document Status".FromInteger(0);

        SalesHeaderRec.Insert();

        SalesLineRec.Init();

        JsonArryItem := Json.getFileIdTextAsJSArray(MainJsonObject, 'line_items');

        foreach ArryToken in JsonArryItem do begin
            SalesLineRec."Document No." := SalesHeaderRec."No.";
            SalesLineRec.Type := "Sales Line Type".FromInteger(2);
            SalesLineRec."No." := Json.getFileIdTextAsText(ArryToken.AsObject(), 'product_id');
            Evaluate(ValQuant, Json.getFileIdTextAsText(ArryToken.AsObject(), 'quantity'));
            SalesLineRec.Quantity := ValQuant;
            SalesLineRec.Insert();
        end;
        Email.NewOrderEmail(OrderInfo);
    end;
}