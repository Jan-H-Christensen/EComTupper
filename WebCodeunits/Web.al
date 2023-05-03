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

codeunit 50134 WebIn
{
    procedure NewCustomer()
    var
        myInt: Integer;
    begin

    end;

    procedure NewSalesOrder()
    var
        myInt: Integer;
    begin

    end;
}