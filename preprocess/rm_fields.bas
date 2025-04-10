Attribute VB_Name = "Module1"
Sub rm_fields()
Attribute rm_fields.VB_ProcData.VB_Invoke_Func = " \n14"
    Range("C:C,D:D,I:I,J:J,K:K,M:M,N:N,O:O,P:P,Q:Q").Select
    Range("Q1").Activate
    Selection.Delete Shift:=xlToLeft
End Sub
