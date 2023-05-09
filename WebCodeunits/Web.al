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

    procedure NewSalesOrder(test: Text)
    var
        Email: Codeunit EmailController;
        Json: Codeunit JsonContoller;
        OrderId: Integer;
    begin
        Email.NewOrderEmail(Format(OrderId));
    end;
}