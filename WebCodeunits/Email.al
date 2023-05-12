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
        Custable.FindFirst();
        Receiver := Custable."E-Mail";

        Subject := 'Welcome to our shop';

        cr := 13; //Line shift Format(cr);

        Body := 'Hello ' + Custable.Name + Format(cr) + Format(cr)
        + 'we are heppy to welcome you at JansShop' + Format(cr)
        + 'we hope you will spend alot of MONEY' + Format(cr)
        + 'looking forwart to your futur transactions' + Format(cr)
        + 'With best regarts' + Format(cr)
        + 'JansShop Team' + Format(cr)
        + 'P.S. we know it is expensiv so you dont have to mention it';


        if not (Body = '') then begin
            EmailMessage.Create(Receiver, Subject, Body);
            Email.Send(EmailMessage, "Email Scenario"::"New Customer");
        end;
    end;

    procedure NewOrderEmail(orderId: Code[20])
    var
        OrderTable: Record "Sales Header";
        custable: Record Customer;
        linetable: Record "Sales Line";
        Email: Codeunit Email;
        EmailMessage: Codeunit "Email Message";
        Subject: Text;
        Body: Text;
        Receiver: Text;
        cr: Char;
    begin
        OrderTable.SetFilter("No.", orderId);
        OrderTable.FindFirst();
        linetable.SetFilter("Document No.", OrderTable."No.");
        custable.SetFilter("No.", OrderTable."Bill-to Customer No.");
        custable.FindFirst();
        //'rogengell@hotmail.com'
        cr := 13; //Line shift Format(cr);
        Receiver := custable."E-Mail";

        Subject := 'Thx for your purges';

        Body := 'Hello ' + Custable.Name + Format(cr) + Format(cr)
        + 'thank you for your trust in JansShop' + Format(cr)
        + 'your order:' + Format(cr);

        if linetable.FindSet() then
            repeat
                Body += 'Item: ' + linetable.Description + ' | Amount: ' + Format(linetable.Quantity) + ' | Price: ' + Format(linetable."Line Amount") + Format(cr);
            until linetable.Next() = 0;

        Body += 'looking forwart to your futur transactions' + Format(cr)
        + 'With best regarts' + Format(cr)
        + 'JansShop Team' + Format(cr)
        + 'P.S. we know it is expensiv so you dont have to mention it';


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