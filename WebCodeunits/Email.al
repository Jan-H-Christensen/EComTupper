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
        Receiver := 'rogengell@hotmail.com';

        Subject := 'Project Over Deadline';

        Body := '';

        cr := 13; //Line shift Format(cr);

        if not (Body = '') then begin
            EmailMessage.Create(Receiver, Subject, Body);
            Email.Send(EmailMessage, "Email Scenario"::Default);
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

        Receiver := 'rogengell@hotmail.com';

        Subject := 'Project Over Deadline';

        Body := '';

        cr := 13; //Line shift Format(cr);

        if not (Body = '') then begin
            EmailMessage.Create(Receiver, Subject, Body);
            Email.Send(EmailMessage, "Email Scenario"::Default);
        end;
    end;
}