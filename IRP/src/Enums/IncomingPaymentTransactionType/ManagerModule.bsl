
Procedure ChoiceDataGetProcessing(ChoiceData, Parameters, StandardProcessing)
	If Parameters.Filter.Property("Ref") Then
		StandardProcessing = False;
		ChoiceData = New ValueList();
		
		IsBankReceipt = TypeOf(Parameters.Filter.Ref) = Type("DocumentRef.BankReceipt");
		IsCashReceipt = TypeOf(Parameters.Filter.Ref) = Type("DocumentRef.CashReceipt");
		IsIncomingPaymentOrder = TypeOf(Parameters.Filter.Ref) = Type("DocumentRef.IncomingPaymentOrder");
	EndIf;
	
	If IsBankReceipt Or IsCashReceipt Then
		ChoiceData.Add(PaymentFromCustomer);
		ChoiceData.Add(CurrencyExchange);
		ChoiceData.Add(CashTransferOrder);
		ChoiceData.Add(TransferFromPOS);
		ChoiceData.Add(ReturnFromVendor);
		ChoiceData.Add(CustomerAdvance);
		ChoiceData.Add(EmployeeCashAdvance);
	EndIf;
		
	If IsBankReceipt Then
		ChoiceData.Add(PaymentFromCustomerByPOS);
		ChoiceData.Add(ReceiptByCheque);
	EndIf;
	
	If IsCashReceipt Then
		If FOServer.IsUseConsolidatedRetailSales() Then
			ChoiceData.Add(CashIn);
		EndIf;	
	EndIf;
	
	If IsIncomingPaymentOrder Then
		ChoiceData.Add(PaymentFromCustomer);
	EndIf;
EndProcedure
