page 50133 "Tupper Sales Charts"
{
    ApplicationArea = All;
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
                    begin
                        UpdateChart();
                    end;
                }

                field("Show Profit or Sales"; Rec."Show Profit or Sales")
                {
                    ApplicationArea = All;

                    trigger OnValidate()
                    begin
                        UpdateChart();
                    end;
                }

                field("Start Date"; rec."Start Date")
                {
                    ApplicationArea = All;

                    trigger OnValidate()
                    begin
                        UpdateChart();
                    end;
                }

                field("End Date"; rec."End Date")
                {
                    ApplicationArea = All;

                    trigger OnValidate()
                    begin
                        UpdateChart();
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
                    begin
                        UpdateChart();
                    end;
                }
            }
        }
    }

    actions
    {
        area(Navigation)
        {
            action("My Action")
            {
                ApplicationArea = All;

                trigger OnAction()
                var
                    salesOrder: Record "Sales Header";
                    codeunitss: Codeunit 50134;
                begin
                    codeunitss.NewSalesOrder('{\r\n  \"id\": 57,\r\n  \"parent_id\": 0,\r\n  \"status\": \"processing\",\r\n  \"currency\": \"EUR\",\r\n  \"version\": \"7.5.1\",\r\n  \"prices_include_tax\": false,\r\n  \"date_created\": \"2023-05-11T21:22:16\",\r\n  \"date_modified\": \"2023-05-11T21:22:16\",\r\n  \"discount_total\": \"0.00\",\r\n  \"discount_tax\": \"0.00\",\r\n  \"shipping_total\": \"0.00\",\r\n  \"shipping_tax\": \"0.00\",\r\n  \"cart_tax\": \"0.00\",\r\n  \"total\": \"8000.00\",\r\n  \"total_tax\": \"0.00\",\r\n  \"customer_id\": 1,\r\n  \"order_key\": \"wc_order_KAiPHhm82bhwv\",\r\n  \"billing\": {\r\n    \"first_name\": \"Jan\",\r\n    \"last_name\": \"Christensen\",\r\n    \"company\": \"\",\r\n    \"address_1\": \"Am Sandberg 6\",\r\n    \"address_2\": \"\",\r\n    \"city\": \"Medelby\",\r\n    \"state\": \"DE-SH\",\r\n    \"postcode\": \"24994\",\r\n    \"country\": \"DE\",\r\n    \"email\": \"janx802y@easv365.dk\",\r\n    \"phone\": \"5556665555\"\r\n  },\r\n  \"shipping\": {\r\n    \"first_name\": \"\",\r\n    \"last_name\": \"\",\r\n    \"company\": \"\",\r\n    \"address_1\": \"\",\r\n    \"address_2\": \"\",\r\n    \"city\": \"\",\r\n    \"state\": \"\",\r\n    \"postcode\": \"\",\r\n    \"country\": \"\",\r\n    \"phone\": \"\"\r\n  },\r\n  \"payment_method\": \"cod\",\r\n  \"payment_method_title\": \"Cash on delivery\",\r\n  \"transaction_id\": \"\",\r\n  \"customer_ip_address\": \"::1\",\r\n  \"customer_user_agent\": \"Mozilla/5.0 (Windows NT 10.0;Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/113.0.0.0 Safari/537.36\",\r\n  \" created_via\": \" checkout\",\r\n  \" customer_note\": \"\",\r\n  \" date_completed\": null,\r\n  \" date_paid\": null,\r\n  \" cart_hash\": \"642ace3e7dd80194f1066022314ff8d5\",\r\n  \" number\": \"57\",\r\n  \" meta_data\": [\r\n    {\r\n      \" id\": 584,\r\n      \" key\": \" is_vat_exempt\",\r\n      \" value\": \" no\"\r\n    }\r\n  ],\r\n  \" line_items\": [\r\n    {\r\n      \" id\": 11,\r\n      \" name\": \" Cykel\",\r\n      \" product_id\": 49,\r\n      \" variation_id\": 0,\r\n      \" quantity\": 2,\r\n      \" tax_class\": \"\",\r\n      \" subtotal\": \"8000.00\",\r\n      \" subtotal_tax\": \"0.00\",\r\n      \" total\": \"8000.00\",\r\n      \" total_tax\": \"0.00\",\r\n      \" taxes\": [],\r\n      \" meta_data\": [\r\n        {\r\n          \" id\": 105,\r\n          \" key\": \" _reduced_stock\",\r\n          \" value\": \"2\",\r\n          \" display_key\": \" _reduced_stock\",\r\n          \" display_value\": \"2\"\r\n        }\r\n      ],\r\n      \" sku\": \"\",\r\n      \" price\": 4000,\r\n      \" image\": {\r\n        \" id\": \"\",\r\n        \" src\": \"\"\r\n      },\r\n      \" parent_name\": null\r\n    }\r\n  ],\r\n  \" tax_lines\": [],\r\n  \" shipping_lines\": [],\r\n  \" fee_lines\": [],\r\n  \" coupon_lines\": [],\r\n  \" refunds\": [],\r\n  \" payment_url\": \" http://localhost/wordpress/checkout/order-pay/57/?pay_for_order=true&key=wc_order_KAiPHhm82bhwv\",\r\n  \"is_editable\": false,\r\n  \"needs_payment\": false,\r\n  \"needs_processing\": true,\r\n  \"date_created_gmt\": \"2023-05-11T21:22:16\",\r\n  \"date_modified_gmt\": \"2023-05-11T21:22:16\",\r\n  \"date_completed_gmt\": null,\r\n  \"date_paid_gmt\": null,\r\n  \"currency_symbol\": \"€\",\r\n  \"_links\": {\r\n    \"self\": [\r\n      {\r\n        \"href\": \"http://localhost/wordpress/wp-json/wc/v3/orders/57\"\r\n      }\r\n    ],\r\n    \"collection\": [\r\n      {\r\n        \"href\": \"http://localhost/wordpress/wp-json/wc/v3/orders\"\r\n      }\r\n    ],\r\n    \"customer\": [\r\n      {\r\n        \"href\": \"http://localhost/wordpress/wp-json/wc/v3/customers/1\"\r\n      }\r\n    ]\r\n  }\r\n}"}');

                end;
            }
        }
    }


    var
        buffer: Record "Business Chart Buffer";
        ChartMgt: Codeunit 50137;
        // test: Record 27;
        // testOrder: Record 37;
        // chart: Record 760;
        // charts: Record 770;
        // chartss: Record 1382;
        pageesss: Page "Sales Order";

    local procedure UpdateChart()
    begin
        ChartMgt.GenerateData(buffer, Rec);
        buffer.Update(CurrPage.Chart);
    end;
}