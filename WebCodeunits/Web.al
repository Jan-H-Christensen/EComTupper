/// <summary>
/// Communication to WooCommerce
/// </summary>
codeunit 50133 WebOut
{
    procedure NewItem(itemId: Code[20])
    var
        ItemTable: Record Item;
        Client: HttpClient;
        Response: HttpResponseMessage;
        Content: HttpContent;
        contentHeaders: HttpHeaders;
        MainObject: JsonObject;
        catagory: JsonArray;
        image: JsonArray;
        sender: Text;
        Base24Helper: Codeunit "Base64 Convert";
        authent: Text;
        test: Text;
    begin

        authent := StrSubstNo('ck_5b6a1f6ff1aadf23f3f2674036b81b33572266ed:cs_900edb7894eef43a5e7e332ba0b3a487d3becd0a');
        authent := Base24Helper.ToBase64(authent);
        authent := StrSubstNo('Basic %1', authent);

        ItemTable.SetFilter("No.", itemId);
        ItemTable.FindFirst();
        MainObject.Add('name', ItemTable.Description);
        MainObject.Add('regular_price', Format(ItemTable."Unit Price"));
        MainObject.Add('description', ItemTable.ItemDeskription);
        MainObject.Add('short_description', ItemTable.ItemDeskription);
        MainObject.WriteTo(sender);

        Message(sender);

        Content.WriteFrom(sender);
        content.GetHeaders(contentHeaders);
        contentHeaders.Clear();
        contentHeaders.Add('Content-Type', 'application/json');
        client.DefaultRequestHeaders.Add('Authorization', authent);
        Client.Post('http://192.168.96.1:80/wordpress/wp-json/wc/v2/products', Content, Response);

        Response.Content.ReadAs(test);

        Message(test);

        ItemTable.WoocommerceId := '';
        ItemTable.Modify();
    end;

    procedure ItemStock(Info: Text)
    var
        ItemTable: Record Item;
        Client: HttpClient;
        Response: HttpResponseMessage;
        Content: HttpContent;
        contentHeaders: HttpHeaders;
        Base24Helper: Codeunit "Base64 Convert";
        authent: Text;
    begin

        authent := StrSubstNo('ck_5b6a1f6ff1aadf23f3f2674036b81b33572266ed:cs_900edb7894eef43a5e7e332ba0b3a487d3becd0a');
        authent := Base24Helper.ToBase64(authent);
        authent := StrSubstNo('Basic %1', authent);
        /// Json

        Content.WriteFrom('Hello');
        content.GetHeaders(contentHeaders);
        contentHeaders.Clear();
        contentHeaders.Add('Content-Type', 'application/json');
        client.DefaultRequestHeaders.Add('Authorization', authent);
        Client.Post('http://192.168.96.1:80/wordpress/wp-json/wc/v2/products', Content, Response);
    end;
}
/// <summary>
/// Communication from WooCommerce
/// </summary>
codeunit 50134 WebIn
{
    local procedure NewCustomer(Info: Text)
    var
        CustTable: Record Customer;
        Email: Codeunit EmailController;
        Json: Codeunit JsonContoller;
        MainJsonObject: JsonObject;
        BillingJsonToken: JsonToken;
    begin
        MainJsonObject.ReadFrom(Info);

        CustTable.SetFilter("No.", json.getFileIdTextAsText(MainJsonObject, 'id'));

        if not CustTable.FindSet() then begin
            CustTable.Init();
            CustTable."No." := Json.getFileIdTextAsText(MainJsonObject, 'id');
            CustTable."E-Mail" := Json.getFileIdTextAsText(MainJsonObject, 'email');
            CustTable.Name := Json.getFileIdTextAsText(MainJsonObject, 'first_name') + ' ' + Json.getFileIdTextAsText(MainJsonObject, 'last_name');

            MainJsonObject.Get('billing', BillingJsonToken);

            CustTable.Address := Json.getFileIdTextAsText(BillingJsonToken.AsObject(), '"address_1');
            CustTable.County := Json.getFileIdTextAsText(BillingJsonToken.AsObject(), 'country');
            CustTable."Post Code" := Json.getFileIdTextAsText(BillingJsonToken.AsObject(), 'postcode');
            CustTable.City := Json.getFileIdTextAsText(BillingJsonToken.AsObject(), 'city');
            CustTable."Phone No." := json.getFileIdTextAsText(BillingJsonToken.AsObject(), 'phone');

            CustTable.Insert();

            Email.NewCusEmail(CustTable."No.");
        end else begin
            CustTable.SetFilter("No.", Json.getFileIdTextAsText(MainJsonObject, 'id'));
            CustTable.FindFirst();
            CustTable."E-Mail" := Json.getFileIdTextAsText(MainJsonObject, 'email');
            CustTable.Name := Json.getFileIdTextAsText(MainJsonObject, 'first_name') + ' ' + Json.getFileIdTextAsText(MainJsonObject, 'last_name');

            MainJsonObject.Get('billing', BillingJsonToken);

            CustTable.Address := Json.getFileIdTextAsText(BillingJsonToken.AsObject(), '"address_1');
            CustTable.County := Json.getFileIdTextAsText(BillingJsonToken.AsObject(), 'country');
            CustTable."Post Code" := Json.getFileIdTextAsText(BillingJsonToken.AsObject(), 'postcode');
            CustTable.City := Json.getFileIdTextAsText(BillingJsonToken.AsObject(), 'city');
            CustTable."Phone No." := json.getFileIdTextAsText(BillingJsonToken.AsObject(), 'phone');

            CustTable.Modify();
        end;
    end;

    procedure NewSalesOrder(Info: Text)
    var
        SalesHeaderRec: Record "Sales Header";
        SalesLineRec: Record "Sales Line";
        CustTable: Record Customer;
        ItemTable: Record Item;
        Email: Codeunit EmailController;
        Json: Codeunit JsonContoller;
        MainJsonObject: JsonObject;
        CostJsonToken: JsonToken;
        ShippJsonToken: JsonToken;
        JsonArryItem: JsonArray;
        ArryToken: JsonToken;
        OrderId: Integer;
        CusId: Text;
        TypeDate: Date;
        OrderDate: Text;
        ValQuant: Decimal;
        woocommerceID: code[20];
    begin
        MainJsonObject.ReadFrom(Info);
        MainJsonObject.Get('billing', CostJsonToken);

        SalesHeaderRec.Init();
        CusId := json.getFileIdTextAsText(MainJsonObject, 'customer_id');
        CustTable.SetFilter("No.", CusId);
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
            woocommerceID := Json.getFileIdTextAsText(ArryToken.AsObject(), 'product_id');
            ItemTable.SetFilter(WoocommerceId, woocommerceID);
            ItemTable.FindFirst();
            SalesLineRec."No." := ItemTable."No.";
            Evaluate(ValQuant, Json.getFileIdTextAsText(ArryToken.AsObject(), 'quantity'));
            SalesLineRec.Quantity := ValQuant;
            SalesLineRec.Insert();
        end;
        Email.NewOrderEmail(SalesHeaderRec."No.");
    end;
}