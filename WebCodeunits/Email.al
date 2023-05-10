codeunit 50135 EmailController
{
    procedure NewCusEmail(cusId: code[20])
    var
        Custable: Record Customer;
        Email: Codeunit Email;
        EmailMessage: Codeunit "Email Message";
        Subject: Text;
        Body: Text;
        Receiver: Text;
        cr: Char;
    begin
        Custable.SetFilter("No.", cusId);
        Receiver := 'j_h_christensen@t-online.de';

        Subject := 'Project Over Deadline';

        Body := '';

        cr := 13; //Line shift Format(cr);

        if not (Body = '') then begin
            EmailMessage.Create(Receiver, Subject, Body);
            Email.Send(EmailMessage, "Email Scenario"::"New Customer");
        end;
    end;

    procedure NewOrderEmail(orderId: Code[20])
    var
        OrderTable: Record "Sales Header";
        Email: Codeunit Email;
        EmailMessage: Codeunit "Email Message";
        Subject: Text;
        Body: Text;
        Receiver: Text;
        cr: Char;
    begin
        OrderTable.SetFilter("No.", orderId);
        //'rogengell@hotmail.com'
        Receiver := 'j_h_christensen@t-online.de';

        Subject := 'Project Over Deadline';

        Body := 'Test';

        cr := 13; //Line shift Format(cr);

        if not (Body = '') then begin
            EmailMessage.Create(Receiver, Subject, Body);
            Email.Send(EmailMessage, "Email Scenario"::"New Order");
        end;
    end;
}

enumextension 50133 "My Email Scenarios" extends "Email Scenario"
{
    value(50133; "New Order")
    {
        Caption = 'New Order';
    }

    value(50134; "New Customer")
    {
        Caption = 'New Customer';
    }
}