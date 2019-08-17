USE [OutcomesFirst]
GO
/****** Object:  StoredProcedure [dbo].[Rep_MonthlyReferralStatus]    Script Date: 28/07/2019 15:52:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Jan
-- Create date: 27/07/2019
-- Description: Stored procedure to provide dataset for Monthly Referral Status Report
-- =============================================
ALTER PROCEDURE [dbo].[Rep_MonthlyReferralStatus]

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	with services_cte AS
	(
	Select ServiceId, ServiceName from Service
	),

	reasons_cte AS
	(
	select StatusId as ID ,StatusName as reasonName from Status 
	)

 
	Select cte.ServiceId,cte.ServiceName, st.StatusName, st.OffersActivityReportOrder, COUNT(sub.SubmissionId) as count 
	
	from services_cte cte
	
	left outer join Submission sub on cte.ServiceId = sub.SubmissionServiceId
	left outer join Status st on st.StatusId = sub.SubmissionStatusId and OffersActivityReportOrder < 5 and st.StatusName <> 'Archive'
	group by cte.ServiceId,cte.ServiceName, st.StatusName,st.OffersActivityReportOrder 


	END
