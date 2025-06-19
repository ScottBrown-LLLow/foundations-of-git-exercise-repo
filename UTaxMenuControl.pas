unit UTaxMenuControl; //test1

interface

uses
  Forms, Controls, Dialogs, SysUtils, Classes, ULowConstants, UTaxConstants,
  System.UITypes, ULowMessageDlg;

type
  TLowOptionType = (lotNormal);

procedure ActivateOption(const ASecurityID: Integer); overload;
procedure ActivateOption(const ASecurityID: Integer; const ATaxType: TTaxType); overload;
procedure ShowMissingMessage(const ASecurityID: Integer);
function CheckForRestart: Boolean;

implementation

uses
  StrUtils, Variants, UObjSecurityRoutines, UFrmMainMenu, UFrmGovtOfficeLookup,
  UFrmEnterpriseZoneLookup, UFrmExemptionLookup, UFrmPropertyTypeLookup,
  UFrmMortgageCompLookup, UFrmZipCodeLookup, UFrmTIFAreaLookup,
  UFrmAssessSourceLookup, UFrmTaxUnitsRatesDetailLkp, UFrmReportMsgLookup,
  UFrmSystemControls, UFrmOtherAssessmentsRatesLkp, UFrmPropertyMasterLkp,
  UFrmPropertyClassLkp, UFrmSettlementPriorityMaint, UFrmPayMethodsLkp,
  UFrmSpecialReceiptTypesLkp, UFrmRcptDrawerBalanceWzd, UFrmRcptDailyRegisterWzd,
  UObjSystemParameters, UFrmChangeLastPostDate, UFrmChangeTransDate,
  UFrmCashSummaryWzd, UFrmReceiptAdjustment, UFrmTaxDupSumWzd,
  UFrmRptTaxAssessmentSumSpecs, UFrmTaxBillExtract,
  UFrmTaxBillExtractSummaryRptWzd, UFrmMortgageCoBillingExport,
  UFrmTaxBillsNotPrintedWzd, UFrmReprintTaxBill, UFrmMortgageCoProcessMedia,
  UFrmMortgageCoTemporaryReceipts, UFrmMortgageCoPrintReceipts,
  UFrmMortgageCoPostReceipts, UFrmFundLookup, UFrmLocationLookup,
  UFrmApportionmentLookup, UFrmAuditAaCeWzd, UFrmSurplusTransfer,
  UFrmAssessSourceMaint, UFrmAuditHistoryRptWzd,
  UFrmCertErrorRegLkp, UFrmCertErrorRegWzd, USngDataAccess,
  UFrmSecLocationLookup, UFrmSecLoginOptMaint, UFrmSecurityMaintenance,
  UFrmCertifiedSurplusLst, UFrmTaxAssessmentDtlWzd,
  UFrmTaxExemptionDetailWzd, UFrmStrdHomeExemptMassUpdWzd,
  UFrmTaxCalculationWzd, UFrmCreateFutureYear, UFrmLockBoxWzd,
  UObjLockBoxReceipts, UFrmReprintReceiptLkp, UFrmTaxSaleWzd, UFrmDemandWzd,
  UFrmDemandRegisterLst, UFrmLowSQLQuery,
  UFrmDelqGovtEmplWzd, UFrmDelqPropertyWzd, UFrmSurplusListWzd,
  UFrmCertToCourtWzd, UFrmGovtEmplPropLst, UFrmSecurityLoggedInUsers,
  UFrmClearGovtOfficeWzd,
  UFrmOtherAssessmentAcreSumWzd, UFrmFutureYrEditProjectionWzd,
  UFrmProjectLookup, UFrmOtherAssessmentAcreDetailWzd,
  UFrmOtherAssessmentBillDetailWzd, UFrmTaxDuplicateDetailWzd,
  UFrmOtherAssessmentBillSumWzd, UFrmOtherAssessmentProjectionWzd,
  UFrmTransferHistWzd, UFrmSplitHistoryWzd, UFrmPrintPropProjectBillsWzd,
  UFrmMtgCoPropVerifyExportWzd, UFrmProcessPropVerifyMediaWzd,
  UFrmSignatureLookup, UFrmMortgageCoPropertyWzd,
  UFrmProjectPropertiesWzd, UFrmActivateSecOptWzd,
  UFrmProjectSettlementWzd, UFrmProjectBalanceReceiptWzd,
  UFrmTaxSaleListUpdateWzd, UFrmTaxSettlementStreamWzd, UObjSettlementReports,
  UObjSettlementStreamParameters, UFrmTaxPreSettlementStreamWzd,
  UFrmTaxSettlementHistoryLkp, UFrmSettlementSectionA1Lkp,
  UFrmStateExemptionLkp, UFrmSettlement49TCLkp, UFrmSettlementApportionmentWzd,
  UFrmAnnexCombineHistoryWzd, UFrmAlternateAccessWzd, UObjAlternateAccess,
  UFrmTaxBillExport, UFrmAbstractHistoryLkp,
  UFrmAbstractWzd, UFrmApportionTIFLookup, UFrmUnCalculateTaxesWzd,
  UFrmAppealsMassUpdateWzd,
  UFrmClearTaxApportionmentRatesWzd,
  UFrmTaxRatesDetailsHistoryLkp, UFrmReprintTaxBillCompare,
  UFrmSecurityAuditHistoryWizard, UFrmExportBudgetOrderWzd,
  UFrmImportBudgetOrderWzd, UFrmSettlement49TCRptWzd, UFrmRefundLkp,
  UFrmMultipleExemptionEditWzd, UFrmCertOfDistributionLkp,
  UFrmCertOfNetAVHistoryLkp, UFrmCertOfTaxDistRptWzd,
  UFrmSettlementForm105Wzd, UFrmSettlementSectionCLkUp,
  UFrmMassPrintCompare, UFrmAdjustTIFBaseNetAVWzd,
  UFrmAbstractCompleteClear, UFrmTIFReallocateBaseNetAVWzd,
  UFrmTIFMasterLkp, UFrmAVAdjustmentsListingWzd, UFrmTabRateChartRptWzd,
  UFrmTIFReallocateBaseNetAVImportWzd, UFrmCycleCollectionsReport,
  UFrmAVExemptChangeFromAACEWzd, UFrmBillingDetailCycleReportWzd,
  UFrmAdjacentPropertiesWzd, UFrmApportionmentHistLkp,
  UFrmCompareExtractHistoryYears, UFrmTaxBill_2009Wzd,
  UObjTaxUnit, UFrmSettlementReconWorksheetLkp,
  UFrmSettlementLOITReconWSLkp, UFrmHistoryRateYearSelect,
  UFrmPropertyNAICSCodeLkp, UFrmInstrumentTypeLkp,
  UFrmBatchUpdateWizard, UFrmBatchImportWizard,
  UFrmReprintHomesteadCert, UFrmImportAssessmentFilesWzd,
  UFrmAssessCompareWzd, UFrmExemptScheduleLkp, UFrmMassUpdateAbatementWzd,
  UFrmTaxToCamaExport, UFrmTIFApportionHistLkp,
  UFrmTaxToCamaSyncExportWzd, UFrmLOITResPTRCAVMassUpdWzd, UFrmMassPrintPayPlan,
  UFrmReprintPayPlan, UFrmAVICompleteClear, UFrmPayPlanApplyPenaltyWzd,
  UFrmCalcLkp, UFrmCompareStatementNotPrintedWzd,
  UFrmUpdateEmailAddressesWzd, UFrmSupplementalAreasLkup,
  UFrmUpdateElecStatementReceivedWzd, UFrmSettlementOAReportsWzd,
  UFrmSettlementOAArchiveWzd, UFrmSettlementOAPenaltyStatusLkp,
  UFrmReceiptAnalysisWzd, UFrmAV2010AInterfaceWzd, UFrmRailUtilOilGasInter,
  UFrmMassPrintSurplusClaimForm, UFrmClearCertificateIssuedWzd,
  UFrmAuditorAssessorMismatchWzd, UFrmAVCertifiedvs2010ASubmissionWzd,
  UFrmApportionmentDistLkp, UFrmSingleExemptionEditWzd,
  UFrmOtherAssessmentsHistRatesLkp, UFrmJudgmentLkp,
  UFrmJudgeCertToCourtDateLkp, UFrmJudgmentReport,
  UFrmAV2010AInterfaceHistoryLkp, UFrmJudgeReprint18TJ, UFrmJudgeInterestRateLkp,
  UFrmAutoInactivatePropertiesWzd, UFrmDelinqTaxCollectWzd,
  UFrmSettlementQuietusWzd, UFrmSettlement49TCSupBalWzd,
  UFrmTaxSaleNoticesWzd, UFrmConserveAbstractWzd, UFrmConserveAbstractHistoryLkp,
  UFrmConserveAbstractLkp, UFrmBudgetOrderHistory, UFrmUserDefinedLkp,
  UFrmRecalcLkp, UFrmNAICSPropertyWzd,
  UFrmMassHmcrFiledRemovalWzd, UFrmRefundInterestRateLkp,
  UFrmRecalcThirdPartyFile, UFrmSalesDisclosureWzd, UFrmSalesDisclosureHistLkup,
  UFrmTIFDistrictLkp, UFrmJudgmentStatusCodeLkp, UFrmExemptAltScheduleLkp,
  UFrmJudgeLoadHistFromSSWzd, UFrmPrevFallDelqPropWzd, UFrmCalcOAWzd,
  UFrmOACalcStatusLkup, UFrmSettleApplyFallPenOnly, UFrmTIFDistrictStateExcelWzd,
  UFrmDemandHistory, UFrmCertToCourtHistoryLkp, UFrmImportApportCBRateAdjWzd,
  UFrmAmendedPPTaxReturnWzd,
  UFrmRestrictedAddrLkp, UFrmTaxCalcEditsLkp, UFrmTIFAreaHistoryLkp,
  UFrmSettlementOutOfBalanceWzd, UFrmNotForProfitMassUpdate,
  UFrmRecalcRefundOnlyWzd,
  UFrmAVIVerificationLst, UFrmChangeMobilePersonalTaxUnitWzd,
  UFrmLatePenaltyWzd, UFrmImportSpreadSheet, UFrmLogsViewer, UFrmJudgeOAReprint18TJ,
  UFrmLogSQLSteps, UFrmTaxSaleHistoryLkp,
  UFrmTIFAreaFAReportWzd, UFrmTaxBillAnalysisWzd, UFrmViewUserMachineSpecsLkp,
  UFrmApportionCleanupWzd, UFrmTIFTaxDupSumWzd, UFrmTIFCollectWzd, UFrmImportOAValuesWzd,
  UFrmPropertyMasterQuickLkp, UFrmLITPTRNetAVSummarySpecs, UFrmFeesReportWzd, UFrmSetOffRefundWzd,
  UFrmCertOfNetAVCreateWzd, UFrmTaxRecalWzd, UFrmTIFMasterFutureYearLkp,
  UFrmGatewayTIFSummaryLkp, UFrmGatewayAdjSummaryLkp, uFrmGatewayTaxSummaryLkp,
  UFrmExemptDistributionMassUpdate, UFrmAltAppealsMassUpdateWzd, UFrmExemptionMassUpdate,
  UFrmSettlementCreateDocketFileWzd, UFrmUnlockSectionA1, UFrmPropertyProjectHistoryLkp,
  UFrmGovtOfficeVerifyExportWzd, UFrmGovtOfficeVerifyImportWzd, UFrmLTEValidateAndApproveLookup,
  UFrmLTEFinalizeApplicationWzd, UFrmLTEMessagesLookup, UFrmLTEStatusLookup, UFrmLTESystemSpecs,
  UFrmGatewayTIFTaxSummaryLkp, UMdGatewayRptTIFTaxSummary, UFrmGatewayCirBrkrCountyWideLkp,
  UMdGatewayRptCirBrkrCountyWide, UFrmGatewayCirBrkrTIFDistrictTotalLkp, UMdGatewayRptCirBrkrTIFDistrictTotal,
  UObjApplicationSecurity, UFrmLETMaint, UFrmGatewayCirBrkrByTypeLocLkp, UMdGatewayRptCirBrkrByTypeLoc,
  UFrmTIFExport, UFrmMassAnnexWzd, UFrmPrivateInfoDescLkp, UFrmVeteranExciseEditWzd, UFrmLTIExtractWzd,
  // must be kept as the last unit listed
  ULowTypeHelpers;

procedure ActivateOption(const ASecurityID: Integer); overload;
var
  locObjLstSysParams: TObjLstSystemParameters;
begin
  if CheckForRestart then
  begin
    Exit;
  end;

  case ASecurityID of
    1001: {Property Master Records}
      begin
        TFrmPropertyMasterLkp.ExecuteLookup(nil, ASecurityID);
      end;
    (1001 * cAAMaxOptionDiv + cAABankruptcy)..(1001 * cAAMaxOptionDiv + cAAMaxOption):
      begin
        TFrmAlternateAccessWzd.ExecuteShow(nil, nil, 1001, ASecurityID mod 100, True);
      end;
    1004: {Government Offices}
      begin
        TFrmGovtOfficeLookup.ExecuteLookup(nil, ASecurityID);
      end;
    1005: {Mortgage Companies}
      begin
        TFrmMortgageCompLookup.ExecuteLookup(nil, ASecurityID);
      end;
    1006: {Tax Units/Rates/Details}
      begin
        TFrmTaxUnitsRatesDetailLkp.ExecuteLookup(nil, ASecurityID);
      end;
    1007: {TIF Areas}
      begin
        TFrmTIFAreaLookup.ExecuteLookup(nil, ASecurityID);
      end;
    1008: {Zip Codes}
      begin
        TFrmZipCodeLookup.ExecuteLookup(nil, ASecurityID);
      end;
    1009: {Report Footer Messages}
      begin
        TFrmReportMsgLookup.ExecuteLookup(nil, ASecurityID);
      end;
    1010: {Other Assessments/Rates}
      begin
        TFrmOtherAssessmentsRatesLkp.ExecuteLookup(nil, ASecurityID);
      end;
    1013: {System Controls}
      begin
        TFrmSystemControls.InitSystemParameters(nil, ASecurityID);
        if (Application.MainForm is TFrmMainMenu) then
        begin
          (Application.MainForm as TFrmMainMenu).SetupStatusBar;
        end;
      end;
    1018: {Property Class}
      begin
        TFrmPropertyClassLkp.ExecuteLookup(nil, ASecurityID);
      end;
    1020: {Settlement Priority}
      begin
        TFrmSettlementPriorityMaint.ExecuteModal(nil, nil, ASecurityID, 0, True);
      end;
    1022: {Pay Method}
      begin
        TFrmPayMethodslkp.ExecuteLookup(nil, ASecurityID);
      end;
    1023: {Special Receipt Type}
      begin
        TFrmSpecialReceiptTypesLkp.ExecuteLookup(nil, ASecurityID);
      end;
    1027: {Funds}
      begin
        TFrmFundLookup.ExecuteLookup(nil, ASecurityID);
      end;
    1028: {Apportionments - Tax Units}
      begin
        TFrmApportionmentLookup.ExecuteLookup(nil, ASecurityID);
      end;
    1029: {User Defined}
      begin
        TFrmUserDefinedLkp.ExecuteLookup(nil, ASecurityID);
      end;
    1030: {Locations}
      begin
        TFrmLocationLookup.ExecuteLookup(nil, ASecurityID);
      end;
    1041: {Clear Government Employees}
      begin
        TFrmClearGovtOfficeWzd.ExecuteModal(nil, nil, ASecurityID, 0, True);
      end;
    1042: {Projects}
      begin
        TFrmProjectLookup.ExecuteLookup(nil, ASecurityID);
      end;
    1051: {State Exemptions}
      begin
        TFrmStateExemptionLkp.ExecuteLookup(nil, ASecurityID);
      end;
    1052: {Import Appeals}
      begin
        TFrmAltAppealsMassUpdateWzd.ExecuteModal(nil, nil, ASecurityID, 0, True);
      end;
    1057: {Apportionments - TIF Areas}
      begin
        TFrmApportionTIFLookup.ExecuteLookup(nil, ASecurityID);
      end;
    1058: {Appeals Mass Update}
      begin
        TFrmAppealsMassUpdateWzd.ExecuteModal(nil, nil, ASecurityID, 0, True);
      end;
      1060: {Mass Annex}
      begin
        TFrmMassAnnexWzd.ExecuteModal(nil, nil, ASecurityID, 0, True);
      end;
    1062: {Tax Rates/Details History}
      begin
        TFrmTaxRatesDetailsHistLkp.ExecuteLookup(nil, ASecurityID);
      end;
    1066: {Export County Budget Orders}
      begin
        TFrmExportBudgetOrderWzd.ExecuteModal(nil, nil, ASecurityID, 0, True);
      end;
    1067: {Import County Budget Orders}
      begin
        TFrmImportBudgetOrderWzd.ExecuteModal(nil, nil, ASecurityID, 0, True);
      end;
    1069: {Other Assessments/Rates History}
      begin
        TFrmOtherAssessmentsHistRatesLkp.ExecuteLookup(nil, ASecurityID);
      end;
    1071: {TIF Masters Future Year}
      begin
        TFrmTIFMasterFutureYearLkp.ExecuteLookup(nil, ASecurityID);
      end;
    1074: {Adjust TIF Base Net AV}
      begin
        TFrmAdjustTIFBaseNetAVWzd.ExecuteModal(nil, nil, ASecurityID, 0, True);
      end;
    1075: {TIF Masters}
      begin
        TFrmTIFMasterLkp.ExecuteLookup(nil, ASecurityID);
      end;
    1076: {Reallocate Base Net AV}
      begin
        TFrmTIFReallocateBaseNetAVWzd.ExecuteModal(nil, nil, ASecurityID, 0, True, bsSizeable);
      end;
    1077: {Interface Base Net AV}
      begin
        TFrmTIFReallocateBaseNetAVImportWzd.ExecuteModal(nil, nil, ASecurityID, 0, True);
      end;
    1079: {Apportionment History - Tax Units}
      begin
        TFrmApportionmentHistLkp.ExecuteLookup(nil, ASecurityID);
      end;
    1080: {TIF Export File}
      begin
        TFrmTIFExport.ExecuteModal(nil, nil, ASecurityID, 0, True, bsSizeable);
      end;
    1083: {Instrument Types}
      begin
        TFrmInstrumentTypeLkp.ExecuteLookup(nil, ASecurityID);
      end;
    1084: {NAICS Codes}
      begin
        TFrmPropertyNAICSCodeLkp.ExecuteLookup(nil, ASecurityID);
      end;
    1086: {Tax-to-CAMA ASCII Update File}
      begin
        TFrmTaxToCamaExport.ExecuteModal(nil, nil, ASecurityID, 0, True);
      end;
    1087: {Apportionment History - TIF Area}
      begin
        TFrmTIFApportionHistLkp.ExecuteLookup(nil, ASecurityID);
      end;
    1089: {Supplemental Areas}
      begin
        TFrmSupplementalAreasLkup.ExecuteLookup(nil, ASecurityID);
      end;
    1090: {Apportionment Distribution}
      begin
        TFrmApportionmentDistLkp.ExecuteLookup(nil, ASecurityID);
      end;
    1091: {Assessment 2010A Interface - Mobile Home}
      begin
        TFrmAV2010AInterfaceWzd.ExecuteModal(nil, nil, ASecurityID, ord(lttMobileHome), True);
      end;
    1092: {Assessment 2010A Interface - Personal}
      begin
        TFrmAV2010AInterfaceWzd.ExecuteModal(nil, nil, ASecurityID, ord(lttPersonal), True);
      end;
    1093: {Assessment 2010A Interface - Real}
      begin
        TFrmAV2010AInterfaceWzd.ExecuteModal(nil, nil, ASecurityID, ord(lttReal), True);
      end;
    1094: {Assessment 2010A Interface - Rail}
      begin
        TFrmRailUtilOilGasInter.ExecuteModal(nil, nil, ASecurityID, 0, True);
      end;
    1095: {Assessment 2010A Interface - Utility}
      begin
        TFrmRailUtilOilGasInter.ExecuteModal(nil, nil, ASecurityID, 0, True);
      end;
    1096: {Assessment 2010A Interface - Oil & Gas}
      begin
        TFrmRailUtilOilGasInter.ExecuteModal(nil, nil, ASecurityID, 0, True);
      end;
    1098: {Assessment 2010A Interface - Auditor/Assessor Mismatch Listing}
      begin
        TFrmAuditorAssessorMismatchWzd.ExecuteShow(nil, nil, ASecurityID, 0, True);
      end;
    1099: {AV Certified vs. 2010A Submission List}
      begin
        TFrmAVCertifiedvs2010ASubmissionWzd.ExecuteShow(nil, nil, ASecurityID, 0, True);
      end;
    1100: {Judgment Interest Rate}
      begin
        TFrmJudgeInterestRateLkp.ExecuteLookup(nil, ASecurityID);
      end;
    1101: {Judgment Cert to Court Date}
      begin
        TFrmJudgeCertToCourtDateLkp.ExecuteLookup(nil, ASecurityID);
      end;
    1102: {Assessment 2010A Interface - History}
      begin
        TFrmAV2010AInterfaceHistoryLkp.ExecuteLookup(nil, ASecurityID);
      end;
    1103: {Assessment 2010A Interface - Auto Inactivate Properties}
      begin
        TFrmAutoInactivatePropertiesWzd.ExecuteShow(nil, nil, ASecurityID, 0, True);
      end;
    1104: {Budget Order History}
      begin
        TFrmBudgetOrderHistory.ExecuteLookup(nil, ASecurityID);
      end;
    1105: {Assessment 2010A Interface Edit - Mobile Home}
      begin
        TFrmAV2010AInterfaceWzd.ExecuteModal(nil, nil, ASecurityID, ord(lttMobileHome), True);
      end;
    1106: {Assessment 2010A Interface Edit - Personal}
      begin
        TFrmAV2010AInterfaceWzd.ExecuteModal(nil, nil, ASecurityID, ord(lttPersonal), True);
      end;
    1107: {Assessment 2010A Interface Edit - Real}
      begin
        TFrmAV2010AInterfaceWzd.ExecuteModal(nil, nil, ASecurityID, ord(lttReal), True);
      end;
    1108: {TIF Districts}
      begin
        TFrmTIFDistrictLkp.ExecuteLookup(nil, ASecurityID);
      end;
    1109: {Judgment Status Codes}
      begin
        TFrmJudgmentStatusCodeLkp.ExecuteLookup(nil, ASecurityID);
      end;
    1115: {Import Apportionment CB Rate Adjustments}
      begin
        TFrmImportApportCBRateAdjWzd.ExecuteModal(nil, nil, ASecurityID, 0, True, bsSizeable);
      end;
    1116: {TIF Area History}
      begin
        TFrmTIFAreaHistoryLkp.ExecuteLookup(nil, ASecurityID);
      end;
    1119: {Reference Tax E-Forms Status}
      begin
        TFrmLTEStatusLookup.ExecuteLookup;
      end;
    1120: {TIF District FA Report}
      begin
        TFrmTIFAreaFAReportWzd.ExecuteModal(nil, nil, ASecurityID, 0, True, bsSizeable);
      end;
    1121: {Tax E-Forms Validate and Approve}
      begin
        TFrmLTEValidateAndApproveLookup.ExecuteLookup(nil, ASecurityID);
      end;
    1123:
      begin
        TFrmPropertyProjectHistoryLkp.ExecuteLookup(nil, ASecurityID);
      end;
    1124: {Tax E-Forms Finalize Application}
      begin
        TFrmLTEFinalizeApplicationWzd.ExecuteModal(nil, nil, ASecurityID);
      end;
    1126: {Reference Tax E-Forms Specifications}
      begin
        TFrmLTESystemSpecs.ExecuteModal(ASecurityID);
      end;
    1127: {Reference Tax E-Forms Approval Messages}
      begin
        TFrmLTEMessagesLookup.ExecuteLookup;
      end;
    1128: {Tax E-Forms Search}
      begin
        TFrmLTEValidateAndApproveLookup.ExecuteLookup(nil, ASecurityID);
      end;
    1134: {Tax E-Forms}
      begin
        TFrmAlternateAccessWzd.ExecuteShow(nil, nil, ASecurityID, 34, True);
      end;
    1135: {Private Info Reference}
      begin
        TFrmPrivateInfoDescLkp.ExecuteLookup(nil, ASecurityID);
      end;
    1600: {Set Restricted Addresses}
      begin
        TFrmRestrictedAddrLkp.ExecuteSelect(nil, ASecurityID);
      end;
    2001: {Mass Extract Billing Info}
      begin
        TFrmTaxBillExtract.ExecuteModal(nil, nil, ASecurityID, 0, True);
      end;
    2002: {Mass Print Remittance Coupons}
      begin
        TFrmTaxBill_2009Wzd.ExecuteModal(nil, nil, ASecurityID, 0, True)
      end;
    2003: {Billing Media Creation}
      begin
        TFrmMortgageCoBillingExport.ExecuteModal(nil, nil, ASecurityID, 0, True);
      end;
    2004: {Reprint Remittance Coupon}
      begin
        TFrmReprintTaxBill.ExecuteShow(nil, nil, ASecurityID, 0, True, True, bsDialog);
      end;
    2007: {Property Verification Media Creation}
      begin
        TFrmMtgCoPropVerifyExportWzd.ExecuteModal(nil, nil, ASecurityID, 0, True);
      end;
    2008: {Process Property Verification Media}
      begin
        TFrmProcessPropVerifyMediaWzd.ExecuteModal(nil, nil, ASecurityID, 0, True);
      end;
    2009: {Tax Bill OCR Printing}
      begin

      end;
    2010: // Main Menu | Misc | Government Employees | Import Verification File
      begin
        TFrmGovtOfficeVerifyImportWzd.ExecuteShow(nil, nil, ASecurityID, 0, True);
      end;
    2011: {Property Project Mass Print Bills}
      begin
        TFrmPrintPropProjectBillsWzd.ExecuteModal(nil, nil, ASecurityID, 0, True);
      end;
    2013: {Export ASCII Billing/Comparison}
      begin
        TFrmTaxBillExport.ExecuteModal(nil, nil, ASecurityID, 0, True);
      end;
    2014: {Mass Print Tax Comparisons}
      begin
        TFrmMassPrintCompare.ExecuteModal(nil, nil, ASecurityID, 0, True);
      end;
    2015: {Reprint Tax Comparison}
      begin
        TFrmReprintTaxBillCompare.ExecuteShow(nil, nil, ASecurityID, 0, True, True, bsDialog);
      end;
    2016: {Mass Extract Comparison History Years}
      begin
        TFrmCompareExtractHistoryYears.ExecuteModal(nil, nil, ASecurityID, 0, True);
      end;
    2018: {Reprint Homestead Certification}
      begin
        TFrmReprintHomesteadCert.ExecuteShow(nil, nil, ASecurityID, 0, True, True, bsDialog);
      end;
    2019: {Mass Print Installment Payment Plan}
      begin
        TFrmMassPrintPayPlan.ExecuteModal(nil, nil, ASecurityID, 0, True);
      end;
    2020: {Reprint Installment Payment Plan}
      begin
        TFrmReprintPayPlan.ExecuteShow(nil, nil, ASecurityID, 0, True, True, bsDialog);
      end;
    2021: {Update E-mail Addresses}
      begin
        TFrmUpdateEmailAddressesWzd.ExecuteModal(nil, nil, ASecurityID, 0, True);
      end;
    2022: {Update Electronic Statement Received}
      begin
        TFrmUpdateElecStatementReceivedWzd.ExecuteModal(nil, nil, ASecurityID, 0, True);
      end;
    2024: {Export ASCII Billing}
      begin
        TFrmTaxBillExport.ExecuteModal(nil, nil, ASecurityID, 0, True);
      end;
    2026: {Sales Disclosure Update Email}
      begin
        TFrmSalesDisclosureWzd.ExecuteModal(nil, nil, ASecurityID, 0, True);
      end;
    2027: {Sales Disclosure Update History}
      begin
        TFrmSalesDisclosureHistLkup.ExecuteLookup(nil, ASecurityID);
      end;
    2028: // Main Menu | Misc | Government Employees | Create Verification Files
      begin
        TFrmGovtOfficeVerifyExportWzd.ExecuteShow(nil, nil, ASecurityID, 0, True);
      end;

    4001: {Pre-Settlement Edit}
      begin
        TFrmTaxPreSettlementStreamWzd.ExecuteModal(nil, nil, ASecurityID, 0, True);
      end;
    4002: {Create Future Year}
      begin
        TFrmCreateFutureYear.ExecuteModal(nil, nil, ASecurityID, 0, True);
      end;
    4003: {Settlement Processing}
      begin
        TFrmTaxSettlementStreamWzd.ExecuteModal(nil, nil, ASecurityID, 2, True);
      end;
    4004: {Report Archive}
      begin
        TFrmTaxSettlementHistoryLkp.ExecuteLookup(nil, ASecurityID);
      end;
    4005: {Advance Draw}
      begin
        TFrmTaxSettlementStreamWzd.ExecuteModal(nil, nil, ASecurityID, 1, True);
      end;
    4006: {Section A1 Details}
      begin
        TFrmSettlementSectionA1Lkp.ExecuteLookup(nil, ASecurityID);
      end;
    4007: {49TC Worksheet - Certificate of Tax Collections | Auditor}
      begin
        TFrmSettlement49TCLkp.ExecuteLookup(nil, ASecurityID);
      end;
    4008: {49TC Report - Certificate of Tax Collections | Auditor}
      begin
        TFrmSettlement49TCRptWzd.ExecuteShow(nil, nil, ASecurityID, 1, True, True, bsDialog);
      end;
    4009: {49TC Worksheet - Certificate of Tax Collections | Treasurer}
      begin
        TFrmSettlement49TCLkp.ExecuteLookup(nil, ASecurityID, 1);
      end;
    4010: {49TC Report - Certificate of Tax Collections | Treasurer}
      begin
        TFrmSettlement49TCRptWzd.ExecuteShow(nil, nil, ASecurityID, 2, True, True, bsDialog);
      end;
    4011: {Settlement Apportionment Report}
      begin
        TFrmSettlementApportionmentWzd.ExecuteModal(nil, nil, ASecurityID, 0, True);
      end;
    4012: {Process Additional 5% Penalty}
      begin
        TFrmTaxSettlementStreamWzd.ExecuteModal(nil, nil, ASecurityID, 3, True);
      end;
    4013: {17TC Refund - Certificate of Tax Refunds}
      begin
        TFrmRefundLkp.ExecuteLookup(nil, ASecurityID);
      end;
    4014: {Form 22 - Certificate of Tax Distribution | Worksheet}
      begin
        TFrmCertOfDistributionLkp.ExecuteModal(nil, ASecurityID, 0, True);
      end;
    4015: {Form 22 - Certificate of Tax Distribution | Report}
      begin
        TFrmCertOfTaxDistRptWzd.ExecuteModal(nil, nil, ASecurityID, 0, True, bsSizeable);
      end;
    4016: {Form 105 Section C Worksheet}
      begin
        TFrmSettlementSectionCLkUp.ExecuteLookup(nil, ASecurityID);
      end;
    4017: {Form 105 Report}
      begin
        TFrmSettlementForm105Wzd.ExecuteShow(nil, nil, ASecurityID, 0, True);
      end;
    4018: {HMCR Replacement Worksheet}
      begin
        TFrmSettlementReconWorksheetLkp.ExecuteLookup(nil, ASecurityID);
      end;
    4019: {LOIT Replacement Worksheet}
      begin
        TFrmSettlementLOITReconWSLkp.ExecuteLookup(nil, ASecurityID);
      end;
    4021: {Apply Penalties on Installment Pay Plan Properties}
      begin
        TFrmPayPlanApplyPenaltyWzd.ExecuteModal(nil, nil, ASecurityID, 0, True);
      end;
    4022: {Settlement Other Assessment Reports}
      begin
        TFrmSettlementOAReportsWzd.ExecuteModal(nil, nil, ASecurityID, 0, True, bsSizeable);
      end;
    4023: {Archive Other Assessment Reports}
      begin
        TFrmSettlementOAArchiveWzd.ExecuteModal(nil, nil, ASecurityID, 0, True);
      end;
    4024: {OA Distribute Penalty to Tax Unit}
      begin
        TFrmSettlementOAPenaltyStatusLkp.ExecuteLookup(nil, ASecurityID);
      end;
    4026: {Quietus Worksheet}
      begin
        TFrmSettlementQuietusWzd.ExecuteShow(nil, nil, ASecurityID, 0, True);
      end;
    4027: {49TC Supplemental Balance}
      begin
        TFrmSettlement49TCSupBalWzd.ExecuteShow(nil, nil, ASecurityID, 0, True);
      end;
    4028: {Apply Fall Penalty Only}
      begin
        TFrmSettleApplyFallPenOnly.ExecuteModal(nil, nil, ASecurityID, 0, True);
      end;
    4030: {TIF Area Tax Duplicate Report}
      begin
        TFrmTIFTaxDupSumWzd.ExecuteShow(nil, nil, ASecurityID, 0, True, True, bsSizeable);
      end;
    4031: {TIF Area Collection Report}
      begin
        TFrmTIFCollectWzd.ExecuteShow(nil, nil, ASecurityID, 0, True, True, bsSizeable);
      end;
    4032: {Create Docket Export File}
      begin
        TFrmSettlementCreateDocketFileWzd.ExecuteShow(nil, nil, ASecurityID, 0, True, True, bsDialog);
      end;
    4033: {License Excise Tax Worksheet}
      begin
        TFrmLETMaint.ExecuteModal(nil, nil, ASecurityID, 0, True, bsSizeable);
      end;
    5001: {Mass Calculate Taxes (Final)}
      begin
        TFrmTaxCalculationWzd.ExecuteModal(nil, nil, ASecurityID, 2, True);
      end;
    5003: {Property Project Calculate Int/Pen}
      begin
        TFrmProjectSettlementWzd.ExecuteModal(nil, nil, ASecurityID, 0, True);
      end;
    5004: {Future Year Edit / Projection}
      begin
        TFrmFutureYrEditProjectionWzd.ExecuteModal(nil, nil, ASecurityID, 0, True);
      end;
    5005: {Create Abstract}
      begin
        TFrmAbstractWzd.ExecuteModal(nil, nil, ASecurityID, 0, True);
      end;
    5006: {Abstract History}
      begin
        TFrmAbstractHistoryLkp.ExecuteLookup(nil, ASecurityID);
      end;
    5009: {Clear Tax/Apportionment Rates}
      begin
        TFrmClearTaxApportionmentRatesWzd.ExecuteModal(nil, nil, ASecurityID, 0, True);
      end;
    5010: {Mass Calculate Taxes (Edit)}
      begin
        TFrmTaxCalculationWzd.ExecuteModal(nil, nil, ASecurityID, 1, True);
      end;
    5002: {Review / Correct Tax Calc Edits}
      begin
        TFrmTaxCalcEditsLkp.ExecuteSelect(nil, ASecurityID, 0, True);
      end;
    5011: {Abatement Mass Adjustments}
      begin
        TFrmMassUpdateAbatementWzd.ExecuteModal(nil, nil, ASecurityID, 0, True, bsSizeable);
      end;
    5012: {Calculation History}
      begin
        TFrmCalcLkp.ExecuteLookup(nil, ASecurityID);
      end;
    5013: {Create Conservancy Abstract}
      begin
        TFrmConserveAbstractWzd.ExecuteModal(nil, nil, ASecurityID, 0, True);
      end;
    5014: {Conservancy Abstract History}
      begin
        TFrmConserveAbstractHistoryLkp.ExecuteLookup(nil, ASecurityID);
      end;
    5015: {Conservancy Abstract Report}
      begin
        TFrmConserveAbstractLkp.ExecuteLookup(nil, ASecurityID, 1);
      end;
    5016: {Conservancy Abstract Worksheet}
      begin
        TFrmConserveAbstractLkp.ExecuteLookup(nil, ASecurityID);
      end;
    5017: {Recalculation History}
      begin
        TFrmRecalcLkp.ExecuteLookup(nil, ASecurityID);
      end;
    5018: {Other Assessment Only Calculation}
      begin
        TFrmCalcOAWzd.ExecuteModal(nil, nil, ASecurityID, 0, True);
      end;
    5019: {Other Assessment Calc Status}
      begin
        TFrmOACalcStatusLkup.ExecuteLookup(nil, ASecurityID);
      end;
    5020: {Non Profit Exemption Mass Update}
      begin
        TFrmNonProfitExemptMassUpdate.ExecuteModal(nil, nil, ASecurityID, 0, True);
      end;
    5021: {Update Deduction Distribution}
      begin
        TFrmExemptBreakdownMassUpdate.ExecuteModal(nil, nil, ASecurityID, 0, True);
      end;
    5022: {Update Deduction Amounts}
      begin
        TFrmExemptMassUpdate.ExecuteModal(nil, nil, ASecurityID, 0, True);
      end;
    5034: {Gateway Property Tax Report}
      begin
        TfrmGatewayTaxSummary.ExecuteLookup(nil, ASecurityID, 1, True);
      end;
    5033: {Gateway Adj Report}
      begin
        TfrmGatewayAdjSummary.ExecuteLookup(nil, ASecurityID, 1, True);
      end;
    5035: {Gateway TIF Report}
      begin
        TfrmGatewayTIFSummary.ExecuteLookup(nil, ASecurityID, 1, True);
      end;
    5036: {Gateway TIF Total Taxes Summary Report}
      begin
        TFrmGatewayTIFTaxSummaryLkp.ExecuteLookup(TMdGatewayRptTIFTaxSummary.Create, [],
          'Abstract Report', False, nil, ASecurityID, 1, True, False, True);
      end;
    5030: {Gateway Circuit Breaker County Wide Totals Report}
      begin
        TFrmGatewayCirBrkrCountyWideLkp.ExecuteLookup(TMdGatewayRptCirBrkrCountyWide.Create, [],
          'Circuit Breaker County Wide Totals', False, nil, ASecurityID, 1, True, False, True);
      end;
    5032: {Gateway Circuit Breaker Totals By Unit Type (Location) Report}
      begin
        TFrmGatewayCirBrkrByTypeLocLkp.ExecuteLookup(TMdGatewayRptCirBrkrByTypeLoc.Create, [],
          'Circuit Breaker Totals By Unit Type (Location)', False, nil, ASecurityID, 1, True, False, True);
      end;
    5031: {Gateway Circuit Breaker TIF District Totals Report}
      begin
        TFrmGatewayCirBrkrTIFDistrictTotalLkp.ExecuteLookup(TMdGatewayRptCirBrkrTIFDistrictTotal.Create, [],
          'Circuit Breaker TIF District Totals', False, nil, ASecurityID, 1, True, False, True);
      end;
    6001: {Tax Sale List / Certification}
      begin
        TFrmTaxSaleWzd.ExecuteModal(nil, nil, ASecurityID, 0, True);
      end;
    6002: {Demand Notice Extract}
      begin
        TFrmDemandWzd.ExecuteModal(nil, nil, ASecurityID, 0, True, bsSizeable);
      end;
    6003: {Print Demand Notices}
      begin
        TFrmDemandWzd.ExecuteModal(nil, nil, ASecurityID, 0, True);
      end;
    6004: {Demand Notice Register}
      begin
        TFrmDemandRegisterLst.ExecuteLookup(nil, ASecurityID);
      end;
    6005: {Certified To Court Register}
      begin
        TFrmCertToCourtWzd.ExecuteModal(nil, nil, ASecurityID, 0, True, bsSizeable);
      end;
    6006: {Sold / Certificate Issued Properties List / Update}
      begin
        TFrmTaxSaleListUpdateWzd.ExecuteModal(nil, nil, ASecurityID, 0, True);
      end;
    6007: {Tax Sale Notices}
      begin
        TFrmTaxSaleNoticesWzd.ExecuteModal(nil, nil, ASecurityID, 0, True);
      end;
    6008: {Clear Certificate Issued Properties}
      begin
        TFrmClearCertificateIssuedWzd.ExecuteModal(nil, nil, ASecurityID, 0, True);
      end;
    6009: {Demand Notice History}
      begin
        TFrmDemandHistory.ExecuteLookup(nil, ASecurityID);
      end;
    6010: {Certified to Court History}
      begin
        TFrmCertToCourtHistoryLkp.ExecuteLookup(nil, ASecurityID);
      end;
    6012: {Tax Sale History}
      begin
        TFrmTaxSaleHistoryLkp.ExecuteLookup(nil, ASecurityID);
      end;
    7001: {Government Employee Listing}
      begin
        TFrmGovtEmplPropLst.ExecuteLookup(nil, ASecurityID);
      end;
    7002: {Delinquent Government Employee Listing}
      begin
        TFrmDelqGovtEmplWzd.ExecuteModal(nil, nil, ASecurityID, 0, True, bsSizeable);
      end;
    7003: {Tax Duplicate Summary Report}
      begin
        TFrmTaxDupSumWzd.ExecuteShow(nil, nil, ASecurityID, 0, True, True);
      end;
    7004: {Tax Assessment Summary Report}
      begin
        TFrmRptTaxAssessmentSumSpecs.ExecuteShow(nil, nil, ASecurityID, 0, True, True, bsDialog);
      end;
    7005: {Tax Assessment Detail Report}
      begin
        TFrmTaxAssessmentDtlWzd.ExecuteShow(nil, nil, ASecurityID, 0, True)
      end;
    7006: {Tax Exemption/Deduction Detail Report}
      begin
        TFrmTaxExemptionDetailWzd.ExecuteShow(nil, nil, ASecurityID, 0, True);
      end;
    7007: {Certified Surplus Listing}
      begin
        TFrmCertifiedSurplusLst.ExecuteLookup(nil, ASecurityID);
      end;
    7008: {Surplus Listing Daily & YTD}
      begin
        TFrmSurplusListWzd.ExecuteModal(nil, nil, ASecurityID, 0, True, bsSizeable);
      end;
    7009: {Other Assessment Acreage Summary}
      begin
        TFrmOtherAssessmentAcreSumWzd.ExecuteShow(nil, nil, ASecurityID, 0, True);
      end;
    7010: {Other Assessment Projection}
      begin
        TFrmOtherAssessmentProjectionWzd.ExecuteShow(nil, nil, ASecurityID, 0, True);
      end;
    7012: {Other Assessment Acreage Detail}
      begin
        TFrmOtherAssessmentAcreDetailWzd.ExecuteShow(nil, nil, ASecurityID, 0, True);
      end;
    7013: {Other Assessment Bill Summary}
      begin
        TFrmOtherAssessmentBillSumWzd.ExecuteShow(nil, nil, ASecurityID, 0, True);
      end;
    7014: {Other Assessment Bill Detail}
      begin
        TFrmOtherAssessmentBillDetailWzd.ExecuteShow(nil, nil, ASecurityID, 0, True);
      end;
    7015: {Remittance Coupon Analysis Report}
      begin
        TFrmTaxBillAnalysisWzd.ExecuteShow(nil, nil, ASecurityID, 0, True);
      end;
    7016: {Remittance Coupons Not Printed Report}
      begin
        TFrmTaxBillsNotPrintedWzd.ExecuteShow(nil, nil, ASecurityID, 0, True);
      end;
    7017: {Extract Summary Report}
      begin
        TFrmTaxBillExtractSummaryRptWzd.ExecuteShow(nil, nil, ASecurityID, 0, True);
      end;
    7018: {AA/CE Audit}
      begin
        TFrmAuditAaCeWzd.ExecuteShow(nil, nil, ASecurityID, 0, True);
      end;
    7019: {Audit History of Changes}
      begin
        TFrmAuditHistoryRptWzd.ExecuteShow(nil, nil, ASecurityID, 0, True);
      end;
    7020: {Certificate of Error Register}
      begin
        TFrmCertErrorRegWzd.ExecuteShow(nil, nil, ASecurityID, 0, True);
      end;
    7021: {Delinquent Property List}
      begin
        TFrmDelqPropertyWzd.ExecuteModal(nil, nil, ASecurityID, 0, True, bsSizeable);
      end;
    7022: {Mortgage Company Property List}
      begin
        TFrmMortgageCoPropertyWzd.ExecuteShow(nil, nil, ASecurityID, 0, True);
      end;
    7023: {Tax Duplicate Detail Report}
      begin
        TFrmTaxDuplicateDetail.ExecuteShow(nil, nil, ASecurityID, 0, True, True, bsDialog);
      end;
    7024: {Split History Report}
      begin
        TFrmSplitHistoryWzd.ExecuteShow(nil, nil, ASecurityID, 0, True);
      end;
    7025: {Transfer History Report}
      begin
        TFrmTransferHistWzd.ExecuteShow(nil, nil, ASecurityID, 0, True);
      end;
    7026: {Project Properties List}
      begin
        TFrmProjectPropertiesWzd.ExecuteShow(nil, nil, ASecurityID, 0, True);
      end;
    7027: {Project Balances & Receipts}
      begin
        TFrmProjectBalanceReceiptWzd.ExecuteShow(nil, nil, ASecurityID, 0, True);
      end;
    7028: {Annexation History Report}
      begin
        TFrmAnnexCombineHistoryWzd.ExecuteShow(nil, nil, ASecurityID, 0, True, True);
      end;
    7029: {Combine History Report}
      begin
        TFrmAnnexCombineHistoryWzd.ExecuteShow(nil, nil, ASecurityID, 1, True);
      end;
    7030: {Other Assessment Combined Minimum Projection}
      begin
        TFrmOtherAssessmentProjectionWzd.ExecuteShow(nil, nil, ASecurityID, 0, True);
      end;
    7034: {History | Certificate of Net Assessed Valuations}
      begin
        TFrmCertOfNetAVHistoryLkp.ExecuteLookup(nil, ASecurityID);
      end;
    7035: {Exemption/Deduction Validation Report}
      begin
        TFrmSingleExemptionEditWzd.ExecuteShow(nil, nil, ASecurityID, 0, True);
      end;
    7036: {Sheriff Sale Detail}
      begin
        TFrmAlternateAccessWzd.ExecuteShow(nil, nil, ASecurityID, 13, True);
      end;
    7037: {AV Adjustments Listing}
      begin
        TFrmAVAdjustmentsListingWzd.ExecuteShow(nil, nil, ASecurityID, 0, True);
      end;
    7039: {Bankruptcy Listing}
      begin
        TFrmAlternateAccessWzd.ExecuteShow(nil, nil, ASecurityID, 14, True);
      end;
    7040: {Appeals Listing}
      begin
        TFrmAlternateAccessWzd.ExecuteShow(nil, nil, ASecurityID, 15, True);
      end;
    7041: {Tab Rate Chart}
      begin
        TFrmTabRateChartRptWzd.ExecuteShow(nil, nil, ASecurityID, 0, True);
      end;
    7042: {Adjacent Properties Report}
      begin
        TFrmAdjacentPropertiesWzd.ExecuteShow(nil, nil, ASecurityID, 0, True);
      end;
    7043: {Cycle Collections Report}
      begin
        TFrmCycleCollectionsReport.ExecuteShow(nil, nil, ASecurityID, 0, True);
      end;
    7044: {Billing Comparison Report}
      begin
        TFrmBillingDetailCycleReportWzd.ExecuteShow(nil, nil, ASecurityID, 0, True);
      end;
    7045: {AV & Exemption Changes from CE's}
      begin
        TFrmAVExemptChangeFromAACEWzd.ExecuteShow(nil, nil, ASecurityID, 0, True);
      end;
    7046: {State Cross-System Comparison | Import Assessment Files}
      begin
        TFrmImportAssessmentFilesWzd.ExecuteModal(nil, nil, ASecurityID, 0, True);
      end;
    7047: {State Cross-System Comparison | User Defined Reports}
      begin
        TFrmAssessCompareWzd.ExecuteModal(nil, nil, ASecurityID, 0, True, bsSizeable);
      end;
    7049: {Comparison Statements Not Printed Report}
      begin
        TFrmCompareStatementNotPrintedWzd.ExecuteModal(nil, nil, ASecurityID, 0, True);
      end;
    7051: {Multiple Address Exemption/Deduction Validation Report}
      begin
        TFrmMultipleExemptionEditWzd.ExecuteShow(nil, nil, ASecurityID, 0, True);
      end;
    7052: {Judgment Report}
      begin
        TFrmJudgmentReport.ExecuteModal(nil, nil, ASecurityID, 0, True, bsSizeable);
      end;
    7053: {Delinquent Tax Collection Report}
      begin
        TFrmDelinqTaxCollectWzd.ExecuteShow(nil, nil, ASecurityID, 0, True);
      end;
    7054: {NAICS Personal Property List}
      begin
        TFrmNAICSPropertyWzd.ExecuteShow(nil, nil, ASecurityID, 0, True);
      end;
    7055: {Refund Interest Rate}
      begin
        TFrmRefundInterestRateLkp.ExecuteLookup(nil, ASecurityID);
      end;
    7056: {Previous Fall Delinquent Property List}
      begin
        TFrmPrevFallDelqPropWzd.ExecuteModal(nil, nil, ASecurityID, 0, True, bsSizeable);
      end;
    7057: {TIF District State Excel Files}
      begin
        TFrmTIFDistrictStateExcelWzd.ExecuteModal(nil, nil, ASecurityID, 0, True);
      end;
    7058: {Amended Personal Property Tax Return Report}
      begin
        TFrmAmendedPPTaxReturnWzd.ExecuteModal(nil, nil, ASecurityID, 0, True);
      end;
    7059: {AVI Verification Listing}
      begin
        TFrmAVIVerificationLst.ExecuteLookup(nil, ASecurityID);
      end;
    7060: {Late Fine/Late 20% Penalty Breakdown}
      begin
        TFrmLatePenaltyWzd.ExecuteShow(nil, nil, ASecurityID, 0, True, True, bsSizeable);
      end;
    7061: {LIT Property Tax Relief Net AV Summary}
      begin
        TFrmLITPTRNetAVSummarySpecs.ExecuteShow(nil, nil, ASecurityID, 0, True, True, bsDialog);
      end;
    7062: {Specified Fees Collection Report}
      begin
        TFrmFeesReportWzd.ExecuteShow(nil, nil, ASecurityID, 0, True, True, bsDialog);
      end;
    7063: {Set Off of Refunds Report}
      begin
        TFrmSetOffRefundWzd.ExecuteShow(nil, nil, ASecurityID, 0, True, True, bsDialog);
      end;
    7064: {Create Cert of net Assess & Valueations}
      begin
        TFrmCertOfNetAVCreateWzd.ExecuteModal(nil, nil, ASecurityID, 0, True, bsSizeable);
      end;
    7065: { Reports | Exemption/Deduction | Veterans Excise Report }
      begin
        TFrmVeteranExciseEditWzd.ExecuteShow(nil, nil, ASecurityID, 0, True);
      end;

    8002: {Drawer Balance Listing}
      begin
        TFrmRcptDrawerBalanceWzd.ExecuteShow(nil, nil, ASecurityID, 0, True);
      end;
    8003: {Daily Payment Register}
      begin
        TFrmRcptDailyRegisterWzd.ExecuteShow(nil, nil, ASecurityID, 0, True);
      end;
    8004: {Change Transaction Date}
      begin
        locObjLstSysParams := TObjLstSystemParameters.Create;
        try
          if locObjLstSysParams.GetObjectCount > 0 then
          begin
            locObjLstSysParams.Edit;
            TFrmChangeTransDate.ExecuteModal(nil, locObjLstSysParams, ASecurityID, 0, True);
          end;
        finally
          FreeAndNil(locObjLstSysParams);
        end;
      end;
    8005: {Change Last Posted Date}
      begin
        locObjLstSysParams := TObjLstSystemParameters.Create;
        try
          if locObjLstSysParams.GetObjectCount > 0 then
          begin
            locObjLstSysParams.Edit;
            TFrmChangeLastPostDate.ExecuteModal(nil, locObjLstSysParams, ASecurityID, 0, True);
          end;
        finally
          FreeAndNil(locObjLstSysParams);
        end;
      end;
    8016: {Daily Cash Summary Report}
      begin
        TFrmCashSummaryWzd.ExecuteShow(nil, nil, ASecurityID, 1, True);
      end;
    8019: {Year Through Date Cash Summary Report}
      begin
        TFrmCashSummaryWzd.ExecuteShow(nil, nil, ASecurityID, 2, True);
      end;
    8007: {Adjust Receipt}
      begin
        TFrmReceiptAdjustment.ExecuteModal(nil, nil, ASecurityID, 0, True);
      end;
    8008: {Mortgage Company Receipting Process Media}
      begin
        TFrmMortgageCoProcessMedia.ExecuteShow(nil, nil, ASecurityID, 0, True);
      end;
    8009: {View Mortgage Company Outstanding Receipts}
      begin
        TFrmMortgageCoTemporaryReceipts.ExecuteLookup(nil, ASecurityID, 0, True);
      end;
    8010: {View Mortgage Company Pending Receipts}
      begin
        TFrmMortgageCoTemporaryReceipts.ExecuteLookup(nil, ASecurityID, 1, True);
      end;
    8011: {Post Pending Mortgage Company Receipts}
      begin
        TFrmMortgageCoPostReceipts.ExecuteModal(nil, nil, ASecurityID, 0, True);
      end;
    8012: {Print Pending Mortgage Company Receipts}
      begin
        TFrmMortgageCoPrintReceipts.ExecuteModal(nil, nil, ASecurityID, 0, True);
      end;
    8013: {Surplus Transfer}
      begin
        TFrmSurplusTransfer.ExecuteModal(nil, nil, ASecurityID, 0, True, bsSizeable);
      end;
    8014: {Lock Box Processing}
      begin
        TFrmLockBoxWzd.ExecuteModal(nil, nil, ASecurityID, 0, True);
      end;
    8015: {Receipt Reprints}
      begin
        TFrmReprintReceiptLkp.ExecuteLookup(nil, ASecurityID);
      end;
    8017: {Receipt Analysis Grid}
      begin
        TFrmReceiptAnalysisWzd.ExecuteModal(nil, nil, ASecurityID, 0, True, bsSizeable);
      end;
    8020: {Surplus Claims}
      begin
        TFrmCertifiedSurplusLst.ExecuteLookup(nil, ASecurityID);
      end;
    8022: {Mass Print Surplus Claims}
      begin
        TFrmMassPrintSurplusClaimForm.ExecuteModal(nil, nil, ASecurityID, 0, True);
      end;
    8024: {Judgment Reprint 18TJ}
      begin
        TFrmJudgeReprint18TJ.ExecuteShow(nil, nil, ASecurityID, 0, True, True, bsDialog);
      end;
    8117: {Judgment Search}
      begin
        TFrmJudgmentLkp.ExecuteLookup(nil, ASecurityID);
      end;
    8118: {Judgment Reprint Other Assessment 18TJ}
      begin
        TFrmJudgeOAReprint18TJ.ExecuteShow(nil, nil, ASecurityID, 0, True, True, bsDialog);
      end;
    8500: {Stand Homeowner Deduction Mass Update}
      begin
        TFrmStrdHomeExemptMassUpdWzd.ExecuteModal(nil, nil, ASecurityID, 0, True);
      end;
    9800: {SQL Query}
      begin
        TFrmLowSQLQuery.ExecuteShow(nil, ASecurityID);
      end;
    9801: {Import Other Assessments}
      begin
        TFrmImportOAValuesWzd.ExecuteModal(nil, nil, ASecurityID, 0, True);
      end;
    9900: {User/Group Maintenance}
      begin
        TFrmSecurityMaintenance.ExecuteShow(nil, ASecurityID, 0, True);
      end;
    9901: {Tax Bill Export}
      begin
        TFrmTaxBillExport.ExecuteModal(nil, nil, ASecurityID, 0, True);
      end;
    9920: {Signature Maintenance}
      begin
        TFrmSignatureLookup.ExecuteLookup(nil, ASecurityID);
      end;
    9922: {Export Annual Tax-to-CAMA Synchronization File}
      begin
        TFrmTaxToCamaSyncExportWzd.ExecuteModal(nil, nil, ASecurityID, 1, True);
      end;
    9923: {Clear AV Interface Completed Flags}
      begin
        TFrmAVICompleteClear.ExecuteModal(nil, nil, ASecurityID, 0, True);
      end;
    9924: {Export Tax-to-CAMA Synchronization File}
      begin
        TFrmTaxToCamaSyncExportWzd.ExecuteModal(nil, nil, ASecurityID, 0, True);
      end;
    9927: {Insert History Tax Rate Year}
      begin
        TFrmHistoryRateYearSelect.ExecuteModal(nil, nil, ASecurityID, 0, True);
      end;
    9928: {Clear Abstract Completed Flag}
      begin
        TFrmAbstractCompleteClear.ExecuteModal(nil, nil, ASecurityID, 0, True);
      end;
    9929: {Un-Calculate Taxes}
      begin
        TFrmUnCalculateTaxesWzd.ExecuteModal(nil, nil, ASecurityID, 0, True);
      end;
    9931: {ASCII Batch Update}
      begin
        TFrmBatchImportWizard.ExecuteModal(nil, nil, ASecurityID, 0, True);
      end;
    9932: {Install Additional Charge Options}
      begin
        TFrmActivateSecOptWzd.ExecuteModal(nil, nil, ASecurityID, 0, True);
      end;
    9933: {ASCII Batch Rollback}
      begin
        TFrmBatchUpdateWizard.ExecuteModal(nil, nil, ASecurityID, 0, True);
      end;
    9934: {SQL Script Update}
      begin
        TFrmLogSQLSteps.ExecuteModal(nil, nil, ASecurityID, 0, True);
      end;
    9938: {Change Mobile/Personal Property Tax Unit}
      begin
        TFrmChangeMobilePersonalTaxUnitWzd.ExecuteModal(nil, nil, ASecurityID, 0, True);
      end;
    9939: {Tax Recalculation}
      begin
        TFrmTaxRecalWzd.ExecuteModal(nil, nil, ASecurityID, 0, True, bsSizeable);
      end;
    9940: {Logged In Users}
      begin
        TFrmSecurityLoggedInUsers.ExecuteLookup(nil, ASecurityID);
      end;
    9941: {Mass Homestead Credit Filed Removal}
      begin
        TFrmMassHmcrFiledRemovalWzd.ExecuteModal(nil, nil, ASecurityID, 0, True);
      end;
    9943: {Create Recalculation Billing File}
      begin
        TFrmRecalcThirdPartyFile.ExecuteModal(nil, nil, ASecurityID, 0, True);
      end;
    9944: {Judgment History from Spreadsheets}
      begin
        TFrmJudgeLoadHistFromSSWzd.ExecuteModal(nil, nil, ASecurityID, 0, True, bsSizeable);
      end;
    9946: {Settlemnt Out Of Balance Investigator}
      begin
        TFrmSettlementOutOfBalanceWzd.ExecuteModal(nil, nil, ASecurityID, 0, True);
      end;
    9947: {Refund Only Recalculation Property}
      begin
        TFrmRecalcRefundOnlyWzd.ExecuteModal(nil, nil, ASecurityID, 0, True);
      end;
    9948: {Import Spreadsheet}
      begin
        TFrmImportSpreadSheet.ExecuteModal(nil, nil, ASecurityID, 0, True, bsSizeable);
      end;
    9949: {Logs Viewer}
      begin
        TFrmLogsViewer.ExecuteShow(nil, nil, ASecurityID, 0, True, True, bsSizeable);
      end;
    9952: {Security Audit History of Changes}
      begin
        TFrmSecurityAuditHistoryWizard.ExecuteModal(nil, nil, ASecurityID, 0, True);
      end;
    9954: {View Workstation Info}
      begin
        TFrmViewUserMachineSpecsLkp.ExecuteLookup(nil, ASecurityID);
      end;
    9960: {Apportionment Cleanup}
      begin
        TFrmApportionCleanupWzd.ExecuteModal(nil, nil, ASecurityID, 0, True);
      end;
    9961: {Unlock Section A/A1}
      begin
        TFrmUnlockSectionA1.ExecuteModal(nil, nil, ASecurityID, 0, True);
      end;
    9962: {LTI Custom Extract}
      begin
        TFrmLTIExtractWzd.ExecuteModal(nil, nil, ASecurityID, 0, True);
      end;
    100199: {Quick Search}
      begin
        TFrmPropertyMasterQuickLkp.ExecuteLookup(nil, ASecurityID div 100, 99);
      end;
  else
    ShowMissingMessage(ASecurityID);
  end;
  // Update user security and available menu options
  TApplicationSecurity.GetSingleton(lsroRefreshIfNecessary);
end;

procedure ActivateOption(const ASecurityID: Integer; const ATaxType: TTaxType); overload;
begin
  if CheckForRestart then
  begin
    Exit;
  end;

  case ASecurityID of
    1002: {Enterprise Zones}
      begin
        TFrmEnterpriseZoneLookup.ExecuteLookup(nil, ATaxType, ASecurityID, ord(ATaxType));
      end;
    1003: {Exemptions/Deductions}
      begin
        TFrmExemptionLookup.ExecuteLookup(nil, ATaxType, ASecurityID, ord(ATaxType));
      end;
    1011: {Property Type}
      begin
        TFrmPropertyTypeLookup.ExecuteLookup(nil, ASecurityID, ord(ATaxType));
      end;
    1012: {Reason for Change}
      begin
        TFrmAssessSourceLookup.ExecuteLookup(nil, ATaxType, ASecurityID, ord(ATaxType));
      end;
    1085: {Abatement Schedule}
      begin
        TFrmExemptScheduleLkp.ExecuteLookup(nil, ATaxType, ASecurityID, ord(ATaxType));
      end;
    1110: {Abatement Schedule - Alternate}
      begin
        TFrmExemptAltScheduleLkp.ExecuteLookup(nil, ASecurityID, ord(ATaxType));
      end;
  else
    ShowMissingMessage(ASecurityID);
  end;
end;

function CheckForOtherRestart(const AsecurityID: string): Boolean;
begin
  Result := False;
  case StrToInt(AsecurityID) of
    8117: // Check  Judgement Search - 8117
      begin
        TFrmJudgmentLkp.CheckInterruptedJudgement;
      end;
  end;
end;

function CheckForRestart: Boolean;

  procedure MsgCancel(const ATmpCTL_ID: TCTL_ID);
  begin
    LowMessageDlg('The following option was started but did not complete successfully:'
      + CrLf + CrLf
      + ATmpCTL_ID.OptionDescription
      + CrLf + CrLf
      + 'The option will be canceled. If the option must be completed, select it again from the menu.',
      mtInformation, [mbOk], 0);
  end;

  function MsgRestart(const ATmpCTL_ID: TCTL_ID): Boolean;
  begin
    if LowMessageDlg('The following option was started but did not complete successfully:'
      + CrLf + CrLf
      + ATmpCTL_ID.OptionDescription
      + CrLf + CrLf
      + 'The option abnormally terminated at the following step:'
      + CrLf + CrLf
      + ATmpCTL_ID.Restart_Step_Desc
      + CrLf + CrLf
      + 'This option must be completed. Do you wish to restart the option now?',
      mtInformation, [mbYes, mbNo], 0) = mrYes then
      Result := True
    else
      Result := False;
  end;

  procedure MsgException(const ATmpCTL_ID: TCTL_ID; ExceptMsg: string);
  begin
    LowMessageDlg(
      ATmpCTL_ID.OptionDescription
      + CrLf + CrLf
      + 'CheckForRestart Error: ' + CrLf + ExceptMsg + CrLf + CrLf
      + 'Notify your support representative for assistance.',
      mtError, [mbOk], 0);
  end;

  procedure ReleaseOption(const ATmpCTL_ID: TCTL_ID);
  begin
    TObjSecurityRoutines.returnOption(IntToStr(ATmpCTL_ID.Option_ID));
  end;

var
  tmpCTL_ID: TCTL_ID;
begin
  Result := False;
  tmpCTL_ID := TObjSecurityRoutines.CheckForRestart;
  try
    try
      if tmpCTL_ID.NumOfRestart > 0 then
      begin
        Result := True;
        case tmpCTL_ID.Option_ID of
          8014: {Lock Box Processing}
            begin
              if tmpCTL_ID.Restart_Step_No < 2 then
              begin
                MsgCancel(tmpCTL_ID);
                TObjLstLockBoxReceipts.DeleteReceipts;
                ReleaseOption(tmpCTL_ID);
              end
              else if MsgRestart(tmpCTL_ID) then
              begin
                TFrmLockBoxWzd.ExecuteModal(nil, nil, tmpCTL_ID.Option_ID, 0, True);
              end;
            end;
        else
          begin
            MsgCancel(tmpCTL_ID);
            ReleaseOption(tmpCTL_ID);
          end;
        end;
      end
      else
      begin
        Result := CheckForOtherRestart('8117'); // Check  Judgement Search - 8117
      end;
    except
      on e: Exception do
      begin
        MsgException(tmpCTL_ID, e.Message);
        Application.Terminate;
      end;
    end;
  finally
    FreeAndNil(tmpCTL_ID);
  end;
end;

procedure ShowMissingMessage(const ASecurityID: Integer);
begin
  LowMessageDlg('Missing: Menu Control Handling'
    + CrLf + 'Security Option: ' + ASecurityID.ToString, mtError, [mbOk], 0);
end;

end.
