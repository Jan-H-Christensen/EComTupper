page 50134 "Tupper Sales Chart"
{
    Caption = 'Tupper Sales Chart';
    PageType = CardPart;
    SourceTable = "Business Chart Buffer";

    layout
    {
        area(Content)
        {
            usercontrol(TupperCharts; "Microsoft.Dynamics.Nav.Client.BusinessChart")
            {
                ApplicationArea = Basic, Suite;
                trigger AddInReady()
                begin
                    UpdateChart();
                end;

                trigger Refresh()
                begin
                    UpdateChart();
                end;

            }
        }
    }

    actions
    {
        area(Processing)
        {
            action("chart setup")
            {
                Promoted = true;
                PromotedCategory = Process;
                ApplicationArea = All;
                Caption = 'Chart setup';
                Image = Setup;

                trigger OnAction()
                begin
                    Page.RunModal(Page::"Tupper Sales Charts");
                    UpdateChart();
                end;
            }

            action("Setup")
            {
                Promoted = true;
                PromotedCategory = Process;
                ApplicationArea = All;
                Caption = 'Setup';
                Image = ServiceOrderSetup;

                trigger OnAction()
                begin
                    Page.RunModal(Page::"Sales Order");
                    UpdateChart();
                end;
            }
        }
    }
    var
        ChartMgt: Codeunit 50137;
        tupper: Record 50133;

    local procedure UpdateChart()
    begin
        ChartMgt.GenerateData(Rec, tupper);
        Rec.Update(CurrPage.TupperCharts);
    end;

    trigger OnOpenPage()
    begin
        UpdateChart();
    end;
}