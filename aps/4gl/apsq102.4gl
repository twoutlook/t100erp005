#該程式已解開Section, 不再透過樣板產出!
{<section id="apsq102.description" >}
#應用 a00 樣板自動產生(Version:2)
#+ Version..: T100-ERP-1.01.00(SD版次:2,PR版次:2) Build-000021
#+ 
#+ Filename...: apsq102
#+ Description: APS模擬來源資料查詢
#+ Creator....: 05599(2015-12-24 14:04:37)
#+ Modifier...: 05599(2016-01-28 17:42:40) -SD/PR- 08993
 
{</section>}
 
{<section id="apsq102.global" >}
#應用 q01 樣板自動產生(Version:30)
#add-point:填寫註解說明 name="global.memo"
#160107-00020#1 16/07/11 By charles4m 新增CP頁籤及查詢功能
#160712-00012#1 16/07/15 By dorislai  修正超過32767筆後會報錯的問題，將變數l_idx,l_a,l_b,l_a_1,l_b_1的型態從num5改成num10
#160727-00019#15 2016/08/03 By 08742   系统中定义的临时表名称超过15码在执行时会出错,所以需要将系统中定义的临时表长度超过15码的全部改掉	 	
#                                      Mod   demand_order_tmp -->dem_ord_tmp01
#                                      Mod   stock_location_tmp -->sto_lct_tmp01
#161109-00085#12 2016/11/14 By 08993   整批調整系統星號寫法
#end add-point
 
IMPORT os
IMPORT util
#add-point:增加匯入項目 name="global.import"

#end add-point
 
SCHEMA ds
 
GLOBALS "../../cfg/top_global.inc"
 
#add-point:增加匯入變數檔 name="global.inc"

#end add-point
 
#單身 type 宣告
PRIVATE TYPE type_g_psca_d RECORD
       
       sel LIKE type_t.chr10, 
   l_xmdadocno LIKE type_t.chr100, 
   l_xmdd001 LIKE type_t.chr100, 
   l_xmdd006 LIKE type_t.chr100, 
   l_xmdd011 LIKE type_t.chr100, 
   l_xmda004 LIKE type_t.chr100, 
   l_type LIKE type_t.chr100, 
   l_xmdd014 LIKE type_t.chr100, 
   l_xmdd004 LIKE type_t.chr100, 
   l_delay LIKE type_t.chr100, 
   l_xmdd002 LIKE type_t.chr100, 
   l_scheduled LIKE type_t.chr100, 
   l_consume LIKE type_t.chr100, 
   l_priority LIKE type_t.chr100, 
   l_transfer LIKE type_t.chr100, 
   l_pseb007 LIKE type_t.chr100
       END RECORD
PRIVATE TYPE type_g_psca10_d RECORD
       psca001 LIKE psca_t.psca001, 
   l_inab001 LIKE type_t.chr100, 
   l_inab002 LIKE type_t.chr100, 
   l_inab005 LIKE type_t.chr100, 
   l_consigned LIKE type_t.chr100
       END RECORD
 
PRIVATE TYPE type_g_psca11_d RECORD
       psca001 LIKE psca_t.psca001, 
   l_bmca001 LIKE type_t.chr100, 
   l_bmca009 LIKE type_t.chr100, 
   l_bmca005 LIKE type_t.chr100, 
   l_bmca003 LIKE type_t.chr100, 
   l_bmcb011 LIKE type_t.chr100, 
   l_bmcb012 LIKE type_t.chr100
       END RECORD
 
PRIVATE TYPE type_g_psca12_d RECORD
       psca001 LIKE psca_t.psca001, 
   l_bmc001 LIKE type_t.chr100, 
   l_bmcc009 LIKE type_t.chr100, 
   l_bmcd010 LIKE type_t.chr100, 
   l_bmcc005 LIKE type_t.chr100, 
   l_bmcc003 LIKE type_t.chr100, 
   l_bmcd011 LIKE type_t.chr100, 
   l_bmcc010 LIKE type_t.chr100
       END RECORD
 
PRIVATE TYPE type_g_psca13_d RECORD
       psca001 LIKE psca_t.psca001, 
   l_imec001 LIKE type_t.chr100, 
   l_imec002 LIKE type_t.chr100, 
   l_imec003 LIKE type_t.chr100
       END RECORD
 
PRIVATE TYPE type_g_psca14_d RECORD
       psca001 LIKE psca_t.psca001, 
   l_bmce001 LIKE type_t.chr100, 
   l_bmce005 LIKE type_t.chr100, 
   l_bmce003 LIKE type_t.chr100, 
   l_bmce009 LIKE type_t.chr100, 
   l_bmce010 LIKE type_t.chr100
       END RECORD
 
PRIVATE TYPE type_g_psca15_d RECORD
       psca001 LIKE psca_t.psca001, 
   l_bmab001 LIKE type_t.chr100, 
   l_bmab003 LIKE type_t.chr100, 
   l_type_1 LIKE type_t.chr100, 
   l_bmab004 LIKE type_t.chr100
       END RECORD
 
PRIVATE TYPE type_g_psca16_d RECORD
       psca001 LIKE psca_t.psca001, 
   l_bmea001 LIKE type_t.chr100, 
   l_bmea003 LIKE type_t.chr100, 
   l_bmea008 LIKE type_t.chr100, 
   l_bmea015 LIKE type_t.chr100, 
   l_bmea011 LIKE type_t.chr100, 
   l_bmea009 LIKE type_t.chr100, 
   l_bmea010 LIKE type_t.chr100, 
   l_bmea012 LIKE type_t.chr100, 
   l_bmea007 LIKE type_t.chr100, 
   l_bmea017 LIKE type_t.chr100, 
   l_bmea016 LIKE type_t.chr100
       END RECORD
 
PRIVATE TYPE type_g_psca17_d RECORD
       psca001 LIKE psca_t.psca001, 
   l_bmea001_1 LIKE type_t.chr100, 
   l_bmea008_1 LIKE type_t.chr100, 
   l_bmea015_1 LIKE type_t.chr100, 
   l_bmea011_1 LIKE type_t.chr100, 
   l_bmea009_1 LIKE type_t.chr100, 
   l_bmea010_1 LIKE type_t.chr100, 
   l_bmea012_1 LIKE type_t.chr100, 
   l_bmea007_1 LIKE type_t.chr100, 
   l_bmea017_1 LIKE type_t.chr100, 
   l_bmea016_1 LIKE type_t.chr100
       END RECORD
 
PRIVATE TYPE type_g_psca18_d RECORD
       psca001 LIKE psca_t.psca001, 
   l_ecaa001 LIKE type_t.chr100
       END RECORD
 
PRIVATE TYPE type_g_psca19_d RECORD
       psca001 LIKE psca_t.psca001, 
   l_bmbb001 LIKE type_t.chr100, 
   l_bmbb003 LIKE type_t.chr100, 
   l_seq LIKE type_t.chr100, 
   l_seq1 LIKE type_t.chr100, 
   l_bmbb009 LIKE type_t.chr100, 
   l_bmbb010 LIKE type_t.chr100, 
   l_shrinkage_1 LIKE type_t.chr100, 
   l_bmbb011 LIKE type_t.chr100, 
   l_bmbb012 LIKE type_t.chr100
       END RECORD
 
PRIVATE TYPE type_g_psca2_d RECORD
       psca001 LIKE psca_t.psca001, 
   l_pmdodocno LIKE type_t.chr100, 
   l_pmdo001 LIKE type_t.chr100, 
   l_pmdb006 LIKE type_t.chr100, 
   l_new LIKE type_t.chr100, 
   l_pmdl004 LIKE type_t.chr100, 
   l_pmdo004 LIKE type_t.chr100, 
   l_pmdo019 LIKE type_t.chr100, 
   l_state LIKE type_t.chr100, 
   l_pmdo014 LIKE type_t.chr100, 
   l_pmdo002 LIKE type_t.chr100, 
   l_pmdo016 LIKE type_t.chr100, 
   l_pmdo015 LIKE type_t.chr100, 
   l_pmdldocdt LIKE type_t.chr100, 
   l_pmdo012 LIKE type_t.chr100, 
   l_pmdo013 LIKE type_t.chr100, 
   l_pmdo017 LIKE type_t.chr100, 
   l_pmdo015_1 LIKE type_t.chr100, 
   l_transfer_1 LIKE type_t.chr100, 
   l_hardpegging LIKE type_t.chr100
       END RECORD
 
PRIVATE TYPE type_g_psca20_d RECORD
       psca001 LIKE psca_t.psca001, 
   l_psoa003 LIKE type_t.chr100, 
   l_psoa004 LIKE type_t.chr100, 
   l_psoa005 LIKE type_t.chr100, 
   l_psoa006 LIKE type_t.chr100, 
   l_psoa007 LIKE type_t.chr100, 
   l_psoa008 LIKE type_t.chr100, 
   l_psoa009 LIKE type_t.chr100, 
   l_psoa010 LIKE type_t.chr100, 
   l_psoa011 LIKE type_t.chr100, 
   l_psoa012 LIKE type_t.chr100, 
   l_psoa013 LIKE type_t.chr100, 
   l_psoa014 LIKE type_t.chr100, 
   l_psoa015 LIKE type_t.chr100, 
   l_psoa016 LIKE type_t.chr100, 
   l_psoa017 LIKE type_t.chr100, 
   l_psoa018 LIKE type_t.chr100, 
   l_psoa019 LIKE type_t.chr100, 
   l_psoa020 LIKE type_t.chr100, 
   l_psoa021 LIKE type_t.chr100, 
   l_psoa022 LIKE type_t.chr100, 
   l_psoa023 LIKE type_t.chr100
       END RECORD
 
PRIVATE TYPE type_g_psca21_d RECORD
       psca001 LIKE psca_t.psca001, 
   l_psod003 LIKE type_t.chr100, 
   l_psod004 LIKE type_t.chr100, 
   l_psod005 LIKE type_t.chr100, 
   l_psod006 LIKE type_t.chr100, 
   l_psod007 LIKE type_t.chr100, 
   l_psod008 LIKE type_t.chr100, 
   l_psod009 LIKE type_t.chr100, 
   l_psod010 LIKE type_t.chr100, 
   l_psod011 LIKE type_t.chr100, 
   l_psod012 LIKE type_t.chr100, 
   l_psod013 LIKE type_t.chr100, 
   l_psod014 LIKE type_t.chr100, 
   l_psod015 LIKE type_t.chr100, 
   l_psod016 LIKE type_t.chr100, 
   l_psod017 LIKE type_t.chr100
       END RECORD
 
PRIVATE TYPE type_g_psca22_d RECORD
       psca001 LIKE psca_t.psca001, 
   l_psoc003 LIKE type_t.chr100, 
   l_psoc004 LIKE type_t.chr100, 
   l_psoc005 LIKE type_t.chr100, 
   l_psoc006 LIKE type_t.chr100, 
   l_psoc007 LIKE type_t.chr100, 
   l_psoc008_1 LIKE type_t.chr100, 
   l_psoc009 LIKE type_t.chr100, 
   l_psoc010 LIKE type_t.chr100, 
   l_psoc011 LIKE type_t.chr100, 
   l_psoc012 LIKE type_t.chr100, 
   l_psoc013 LIKE type_t.chr100, 
   l_psoc014 LIKE type_t.chr100, 
   l_psoc015 LIKE type_t.chr100, 
   l_psoc016 LIKE type_t.chr100, 
   l_psoc017 LIKE type_t.chr100, 
   l_psoc018 LIKE type_t.chr100, 
   l_psoc019 LIKE type_t.chr100, 
   l_psoc020 LIKE type_t.chr100, 
   l_psoc021 LIKE type_t.chr100, 
   l_psoc022 LIKE type_t.chr100, 
   l_psoc023 LIKE type_t.chr100, 
   l_psoc025 LIKE type_t.chr100, 
   l_psoc022_1 LIKE type_t.chr100, 
   l_psoc022_2 LIKE type_t.chr100, 
   l_psoc022_3 LIKE type_t.chr100
       END RECORD
 
PRIVATE TYPE type_g_psca23_d RECORD
       psca001 LIKE psca_t.psca001, 
   l_psoa003_1 LIKE type_t.chr100, 
   l_psoa004_1 LIKE type_t.chr100, 
   l_psoa005_1 LIKE type_t.chr100, 
   l_psoa006_1 LIKE type_t.chr100, 
   l_psoa007_1 LIKE type_t.chr100, 
   l_psoa008_1 LIKE type_t.chr100, 
   l_psoa009_1 LIKE type_t.chr100, 
   l_psoa010_1 LIKE type_t.chr100, 
   l_psoa011_1 LIKE type_t.chr100, 
   l_psoa012_1 LIKE type_t.chr100, 
   l_psoa013_1 LIKE type_t.chr100, 
   l_psoa014_1 LIKE type_t.chr100, 
   l_psoa015_1 LIKE type_t.chr100, 
   l_psoa016_1 LIKE type_t.chr100, 
   l_psoa017_1 LIKE type_t.chr100, 
   l_psoa018_1 LIKE type_t.chr100, 
   l_psoa019_1 LIKE type_t.chr100, 
   l_psoa020_1 LIKE type_t.chr100, 
   l_psoa021_1 LIKE type_t.chr100, 
   l_psoa023_1 LIKE type_t.chr100
       END RECORD
 
PRIVATE TYPE type_g_psca24_d RECORD
       psca001 LIKE psca_t.psca001, 
   l_sfbadocno_1 LIKE type_t.chr100, 
   l_sfba006_1 LIKE type_t.chr100, 
   l_sfbaseq_2 LIKE type_t.chr100, 
   l_sfbaseq_1_1 LIKE type_t.chr100, 
   l_release_2 LIKE type_t.chr100, 
   l_sfba019_1 LIKE type_t.chr100, 
   l_demand_1 LIKE type_t.chr100, 
   l_sfba020_1 LIKE type_t.chr100, 
   l_sfba028_1 LIKE type_t.chr100, 
   l_sfba003_1 LIKE type_t.chr100, 
   l_sfba009_1 LIKE type_t.chr100, 
   l_sfba007_1 LIKE type_t.chr100, 
   l_sfaa003_1 LIKE type_t.chr100, 
   l_sfba021_1 LIKE type_t.chr100
       END RECORD
 
PRIVATE TYPE type_g_psca25_d RECORD
       psca001 LIKE psca_t.psca001, 
   l_psob003 LIKE type_t.chr500, 
   l_psob004 LIKE type_t.chr500, 
   l_psob005 LIKE type_t.chr500, 
   l_psob006 LIKE type_t.chr500, 
   l_psob007 LIKE type_t.chr500, 
   l_psob008 LIKE type_t.chr500, 
   l_psob009 LIKE type_t.chr500, 
   l_psob010 LIKE type_t.chr500, 
   l_psob011 LIKE type_t.chr500, 
   l_psob012 LIKE type_t.chr500, 
   l_psob013 LIKE type_t.chr500, 
   l_psob016 LIKE type_t.chr500
       END RECORD
 
PRIVATE TYPE type_g_psca26_d RECORD
       psca001 LIKE psca_t.psca001, 
   l_equip_type LIKE type_t.chr500, 
   l_equip_id LIKE type_t.chr500, 
   l_ws_id LIKE type_t.chr500, 
   l_efficency LIKE type_t.chr500, 
   l_capacity_type LIKE type_t.chr500, 
   l_day_calendar_id LIKE type_t.chr500, 
   l_week_calendar_id LIKE type_t.chr500
       END RECORD
 
PRIVATE TYPE type_g_psca27_d RECORD
       psca001 LIKE psca_t.psca001, 
   l_equip_group_id LIKE type_t.chr500, 
   l_equip_type_1 LIKE type_t.chr500, 
   l_is_outsourcing LIKE type_t.chr500, 
   l_equip_id_1 LIKE type_t.chr500, 
   l_priority_1 LIKE type_t.chr500
       END RECORD
 
PRIVATE TYPE type_g_psca28_d RECORD
       psca001 LIKE psca_t.psca001, 
   l_mrbh001_1 LIKE type_t.chr500, 
   l_mrbh002 LIKE type_t.chr500, 
   l_mrbh003 LIKE type_t.chr500, 
   l_mrbh004 LIKE type_t.chr500, 
   l_mrbh005 LIKE type_t.chr500
       END RECORD
 
PRIVATE TYPE type_g_psca29_d RECORD
       psca001 LIKE psca_t.psca001, 
   l_week_calendar_id_1 LIKE type_t.chr500, 
   l_mom_wm_id LIKE type_t.chr500, 
   l_tue_wm_id LIKE type_t.chr500, 
   l_wed_wm_id LIKE type_t.chr500, 
   l_thu_wm_id LIKE type_t.chr500, 
   l_fri_wm_id LIKE type_t.chr500, 
   l_sat_wm_id LIKE type_t.chr500, 
   l_sun_wm_id LIKE type_t.chr500
       END RECORD
 
PRIVATE TYPE type_g_psca3_d RECORD
       psca001 LIKE psca_t.psca001, 
   l_sfaadocno LIKE type_t.chr100, 
   l_sfaa012 LIKE type_t.chr100, 
   l_sfaa020 LIKE type_t.chr100, 
   l_sfaa019 LIKE type_t.chr100, 
   l_sfaa010 LIKE type_t.chr100, 
   l_sfaadocno1 LIKE type_t.chr100, 
   l_sfaa013 LIKE type_t.chr100, 
   l_sfaa056 LIKE type_t.chr100, 
   l_new_1 LIKE type_t.chr100, 
   l_produced LIKE type_t.chr100, 
   l_sfaa022 LIKE type_t.chr100, 
   l_sfaa021 LIKE type_t.chr100, 
   l_feature LIKE type_t.chr100, 
   l_firm LIKE type_t.chr100, 
   l_exploration LIKE type_t.chr100, 
   l_material LIKE type_t.chr100, 
   l_hardpegging_1 LIKE type_t.chr100
       END RECORD
 
PRIVATE TYPE type_g_psca30_d RECORD
       psca001 LIKE psca_t.psca001, 
   l_wm_id LIKE type_t.chr500, 
   l_start_time LIKE type_t.chr500, 
   l_end_time LIKE type_t.chr500, 
   l_type_2 LIKE type_t.chr500
       END RECORD
 
PRIVATE TYPE type_g_psca31_d RECORD
       psca001 LIKE psca_t.psca001, 
   l_imaa001_1 LIKE type_t.chr500, 
   l_imaf026_1 LIKE type_t.chr500, 
   l_sizing_1 LIKE type_t.chr500, 
   l_used_2 LIKE type_t.chr500, 
   l_integer_1 LIKE type_t.chr500, 
   l_imaf013_1 LIKE type_t.chr500, 
   l_imaa006_1 LIKE type_t.chr500, 
   l_imae022_1 LIKE type_t.chr500, 
   l_imae018_1 LIKE type_t.chr500, 
   l_imae017_1 LIKE type_t.chr500, 
   l_imae080_1 LIKE type_t.chr500, 
   l_imaa004_1 LIKE type_t.chr500, 
   l_imae064_2 LIKE type_t.chr500, 
   l_mfg_2 LIKE type_t.chr500, 
   l_order_1 LIKE type_t.chr500, 
   l_feature_1_1 LIKE type_t.chr500, 
   l_imaf171_2 LIKE type_t.chr500, 
   l_imaf171_3 LIKE type_t.chr500, 
   l_consume_1_1 LIKE type_t.chr500, 
   l_release_1_1 LIKE type_t.chr500, 
   l_lastqty_1 LIKE type_t.chr500, 
   l_combine_1 LIKE type_t.chr500, 
   l_inspect_1 LIKE type_t.chr500, 
   l_consign_1 LIKE type_t.chr500, 
   l_imaf143_1 LIKE type_t.chr500, 
   l_purchase_1 LIKE type_t.chr500, 
   l_imae016_1 LIKE type_t.chr500, 
   l_mfg_1_1 LIKE type_t.chr500, 
   l_imaa105_1 LIKE type_t.chr500, 
   l_sales_1 LIKE type_t.chr500, 
   l_imae064_1_1 LIKE type_t.chr500, 
   l_alt_2 LIKE type_t.chr500, 
   l_break_1 LIKE type_t.chr500, 
   l_create_2 LIKE type_t.chr500, 
   l_supratio_1 LIKE type_t.chr500, 
   l_imaf153_1 LIKE type_t.chr500, 
   l_backward_1 LIKE type_t.chr500, 
   l_batch_1 LIKE type_t.chr500, 
   l_setup_1 LIKE type_t.chr500, 
   l_imae052_1 LIKE type_t.chr500, 
   l_imae077_1 LIKE type_t.chr500, 
   l_base_1 LIKE type_t.chr500, 
   l_max_batch_size_1 LIKE type_t.chr500, 
   l_imae032_1 LIKE type_t.chr500, 
   l_outsourcing_1 LIKE type_t.chr500, 
   l_imae072_1 LIKE type_t.chr500, 
   l_imae073_1 LIKE type_t.chr500, 
   l_var_1 LIKE type_t.chr500, 
   l_auto_1 LIKE type_t.chr500, 
   l_consolidate_1 LIKE type_t.chr500, 
   l_phase_1 LIKE type_t.chr500, 
   l_spare_1 LIKE type_t.chr500, 
   l_due_1 LIKE type_t.chr500, 
   l_imae015_1 LIKE type_t.chr500, 
   l_imaa005_1 LIKE type_t.chr500, 
   l_imae078_1 LIKE type_t.chr500, 
   l_imae079_1 LIKE type_t.chr500, 
   l_imae083_1 LIKE type_t.chr500, 
   l_imae082_1 LIKE type_t.chr500
       END RECORD
 
PRIVATE TYPE type_g_psca32_d RECORD
       psca001 LIKE psca_t.psca001, 
   l_bmba001_1 LIKE type_t.chr500, 
   l_bmba003_1 LIKE type_t.chr500, 
   l_ecba001 LIKE type_t.chr500, 
   l_ecbb003 LIKE type_t.chr500, 
   l_bmba007_1 LIKE type_t.chr500
       END RECORD
 
PRIVATE TYPE type_g_psca33_d RECORD
       psca001 LIKE psca_t.psca001, 
   l_part_id LIKE type_t.chr500, 
   l_imae033 LIKE type_t.chr500, 
   l_sequ_num LIKE type_t.chr500, 
   l_is_alt LIKE type_t.chr500
       END RECORD
 
PRIVATE TYPE type_g_psca34_d RECORD
       psca001 LIKE psca_t.psca001, 
   l_ecbb001 LIKE type_t.chr500, 
   l_ecbb002 LIKE type_t.chr500, 
   l_ecbb003_1 LIKE type_t.chr500, 
   l_ecbb004 LIKE type_t.chr500, 
   l_equip_type_2 LIKE type_t.chr500, 
   l_ecbb037 LIKE type_t.chr500, 
   l_is_batch LIKE type_t.chr500, 
   l_ecbb026 LIKE type_t.chr500, 
   l_ecbb027 LIKE type_t.chr500, 
   l_imae077_2 LIKE type_t.chr500, 
   l_imae077_3 LIKE type_t.chr500, 
   l_ecbb012 LIKE type_t.chr500
       END RECORD
 
PRIVATE TYPE type_g_psca35_d RECORD
       psca001 LIKE psca_t.psca001, 
   l_ecaa001_1 LIKE type_t.chr500
       END RECORD
 
PRIVATE TYPE type_g_psca36_d RECORD
       psca001 LIKE psca_t.psca001, 
   l_ecbe001 LIKE type_t.chr500, 
   l_ecbe005 LIKE type_t.chr500, 
   l_ecbe003 LIKE type_t.chr500
       END RECORD
 
PRIVATE TYPE type_g_psca4_d RECORD
       psca001 LIKE psca_t.psca001, 
   l_sfbadocno LIKE type_t.chr100, 
   l_sfba006 LIKE type_t.chr100, 
   l_sfbaseq LIKE type_t.chr100, 
   l_sfbaseq_1 LIKE type_t.chr100, 
   l_release LIKE type_t.chr100, 
   l_sfba019 LIKE type_t.chr100, 
   l_demand LIKE type_t.chr100, 
   l_sfba020 LIKE type_t.chr100, 
   l_sfba028 LIKE type_t.chr100, 
   l_sfba003 LIKE type_t.chr100, 
   l_sfba009 LIKE type_t.chr100, 
   l_sfba007 LIKE type_t.chr100, 
   l_sfaa003 LIKE type_t.chr100, 
   l_sfba021 LIKE type_t.chr100, 
   l_sfba001 LIKE type_t.chr100, 
   l_sfba005 LIKE type_t.chr100
       END RECORD
 
PRIVATE TYPE type_g_psca5_d RECORD
       psca001 LIKE psca_t.psca001, 
   l_imaa001 LIKE type_t.chr100, 
   l_imaf026 LIKE type_t.chr100, 
   l_sizing LIKE type_t.chr100, 
   l_used LIKE type_t.chr100, 
   l_integer LIKE type_t.chr100, 
   l_imaf013 LIKE type_t.chr100, 
   l_imaa006 LIKE type_t.chr100, 
   l_imae022 LIKE type_t.chr100, 
   l_imae018 LIKE type_t.chr100, 
   l_imae017 LIKE type_t.chr100, 
   l_imae080 LIKE type_t.chr100, 
   l_imaa004 LIKE type_t.chr100, 
   l_imae064 LIKE type_t.chr100, 
   l_mfg LIKE type_t.chr100, 
   l_order LIKE type_t.chr100, 
   l_feature_1 LIKE type_t.chr100, 
   l_imaf171 LIKE type_t.chr100, 
   l_imaf171_1 LIKE type_t.chr100, 
   l_consume_1 LIKE type_t.chr100, 
   l_release_1 LIKE type_t.chr100, 
   l_lastqty LIKE type_t.chr100, 
   l_combine LIKE type_t.chr100, 
   l_inspect LIKE type_t.chr100, 
   l_consign LIKE type_t.chr100, 
   l_imaf143 LIKE type_t.chr100, 
   l_purchase LIKE type_t.chr100, 
   l_imae016 LIKE type_t.chr100, 
   l_mfg_1 LIKE type_t.chr100, 
   l_imaa105 LIKE type_t.chr100, 
   l_sales LIKE type_t.chr100, 
   l_imae064_1 LIKE type_t.chr100, 
   l_alt LIKE type_t.chr100, 
   l_break LIKE type_t.chr100, 
   l_create LIKE type_t.chr100, 
   l_supratio LIKE type_t.chr100, 
   l_imaf153 LIKE type_t.chr100, 
   l_backward LIKE type_t.chr100, 
   l_batch LIKE type_t.chr100, 
   l_setup LIKE type_t.chr100, 
   l_imae052 LIKE type_t.chr100, 
   l_imae077 LIKE type_t.chr100, 
   l_base LIKE type_t.chr100, 
   l_max_batch_size LIKE type_t.chr100, 
   l_imae032 LIKE type_t.chr100, 
   l_outsourcing LIKE type_t.chr100, 
   l_imae072 LIKE type_t.chr100, 
   l_imae073 LIKE type_t.chr100, 
   l_var LIKE type_t.chr100, 
   l_auto LIKE type_t.chr100, 
   l_consolidate LIKE type_t.chr100, 
   l_phase LIKE type_t.chr100, 
   l_spare LIKE type_t.chr100, 
   l_due LIKE type_t.chr100, 
   l_imae015 LIKE type_t.chr100, 
   l_imaa005 LIKE type_t.chr100, 
   l_imae078 LIKE type_t.chr100, 
   l_imae079 LIKE type_t.chr100, 
   l_imae083 LIKE type_t.chr100, 
   l_imae082 LIKE type_t.chr100
       END RECORD
 
PRIVATE TYPE type_g_psca6_d RECORD
       psca001 LIKE psca_t.psca001, 
   l_imeb001 LIKE type_t.chr100, 
   l_imeb002 LIKE type_t.chr100, 
   l_imeb004 LIKE type_t.chr100, 
   l_imeb006 LIKE type_t.chr100, 
   l_imeb005 LIKE type_t.chr100, 
   l_imeb010 LIKE type_t.chr100, 
   l_imeb011 LIKE type_t.chr100, 
   l_imeb008 LIKE type_t.chr100, 
   l_imeb009 LIKE type_t.chr100
       END RECORD
 
PRIVATE TYPE type_g_psca7_d RECORD
       psca001 LIKE psca_t.psca001, 
   l_bmba001 LIKE type_t.chr100, 
   l_bmba012 LIKE type_t.chr100, 
   l_bmba003 LIKE type_t.chr100, 
   l_bmba009 LIKE type_t.chr100, 
   l_bmba011 LIKE type_t.chr100, 
   l_shrinkage LIKE type_t.chr100, 
   l_bmba013 LIKE type_t.chr100, 
   l_bmba031 LIKE type_t.chr100, 
   l_alt_1 LIKE type_t.chr100, 
   l_create_1 LIKE type_t.chr100, 
   l_ratio LIKE type_t.chr100, 
   l_bmba007 LIKE type_t.chr100, 
   l_bmba021 LIKE type_t.chr100, 
   l_used_1 LIKE type_t.chr100, 
   l_substitute LIKE type_t.chr100, 
   l_fixed LIKE type_t.chr100, 
   l_bmba023 LIKE type_t.chr100, 
   l_bmba004 LIKE type_t.chr100, 
   l_bmba008 LIKE type_t.chr100, 
   l_quantity LIKE type_t.chr100
       END RECORD
 
PRIVATE TYPE type_g_psca8_d RECORD
       psca001 LIKE psca_t.psca001, 
   l_inag001 LIKE type_t.chr100, 
   l_inag004 LIKE type_t.chr100, 
   l_inag005 LIKE type_t.chr100, 
   l_inag009 LIKE type_t.chr100, 
   l_inag002 LIKE type_t.chr100, 
   l_hard LIKE type_t.chr100
       END RECORD
 
PRIVATE TYPE type_g_psca9_d RECORD
       psca001 LIKE psca_t.psca001, 
   l_inaa001 LIKE type_t.chr100, 
   l_inaa006 LIKE type_t.chr100
       END RECORD
 
 
 
#add-point:自定義模組變數-標準(Module Variable)  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="global.variable"
 TYPE type_master RECORD 
   psca001 LIKE type_t.chr500, 
   psea002 LIKE type_t.chr500
       END RECORD
 
#模組變數(Module Variables)
DEFINE g_master   type_master
DEFINE g_master_t type_master
#end add-point
 
#模組變數(Module Variables)
DEFINE g_psca_d            DYNAMIC ARRAY OF type_g_psca_d
DEFINE g_psca_d_t          type_g_psca_d
DEFINE g_psca10_d     DYNAMIC ARRAY OF type_g_psca10_d
DEFINE g_psca10_d_t   type_g_psca10_d
 
DEFINE g_psca11_d     DYNAMIC ARRAY OF type_g_psca11_d
DEFINE g_psca11_d_t   type_g_psca11_d
 
DEFINE g_psca12_d     DYNAMIC ARRAY OF type_g_psca12_d
DEFINE g_psca12_d_t   type_g_psca12_d
 
DEFINE g_psca13_d     DYNAMIC ARRAY OF type_g_psca13_d
DEFINE g_psca13_d_t   type_g_psca13_d
 
DEFINE g_psca14_d     DYNAMIC ARRAY OF type_g_psca14_d
DEFINE g_psca14_d_t   type_g_psca14_d
 
DEFINE g_psca15_d     DYNAMIC ARRAY OF type_g_psca15_d
DEFINE g_psca15_d_t   type_g_psca15_d
 
DEFINE g_psca16_d     DYNAMIC ARRAY OF type_g_psca16_d
DEFINE g_psca16_d_t   type_g_psca16_d
 
DEFINE g_psca17_d     DYNAMIC ARRAY OF type_g_psca17_d
DEFINE g_psca17_d_t   type_g_psca17_d
 
DEFINE g_psca18_d     DYNAMIC ARRAY OF type_g_psca18_d
DEFINE g_psca18_d_t   type_g_psca18_d
 
DEFINE g_psca19_d     DYNAMIC ARRAY OF type_g_psca19_d
DEFINE g_psca19_d_t   type_g_psca19_d
 
DEFINE g_psca2_d     DYNAMIC ARRAY OF type_g_psca2_d
DEFINE g_psca2_d_t   type_g_psca2_d
 
DEFINE g_psca20_d     DYNAMIC ARRAY OF type_g_psca20_d
DEFINE g_psca20_d_t   type_g_psca20_d
 
DEFINE g_psca21_d     DYNAMIC ARRAY OF type_g_psca21_d
DEFINE g_psca21_d_t   type_g_psca21_d
 
DEFINE g_psca22_d     DYNAMIC ARRAY OF type_g_psca22_d
DEFINE g_psca22_d_t   type_g_psca22_d
 
DEFINE g_psca23_d     DYNAMIC ARRAY OF type_g_psca23_d
DEFINE g_psca23_d_t   type_g_psca23_d
 
DEFINE g_psca24_d     DYNAMIC ARRAY OF type_g_psca24_d
DEFINE g_psca24_d_t   type_g_psca24_d
 
DEFINE g_psca25_d     DYNAMIC ARRAY OF type_g_psca25_d
DEFINE g_psca25_d_t   type_g_psca25_d
 
DEFINE g_psca26_d     DYNAMIC ARRAY OF type_g_psca26_d
DEFINE g_psca26_d_t   type_g_psca26_d
 
DEFINE g_psca27_d     DYNAMIC ARRAY OF type_g_psca27_d
DEFINE g_psca27_d_t   type_g_psca27_d
 
DEFINE g_psca28_d     DYNAMIC ARRAY OF type_g_psca28_d
DEFINE g_psca28_d_t   type_g_psca28_d
 
DEFINE g_psca29_d     DYNAMIC ARRAY OF type_g_psca29_d
DEFINE g_psca29_d_t   type_g_psca29_d
 
DEFINE g_psca3_d     DYNAMIC ARRAY OF type_g_psca3_d
DEFINE g_psca3_d_t   type_g_psca3_d
 
DEFINE g_psca30_d     DYNAMIC ARRAY OF type_g_psca30_d
DEFINE g_psca30_d_t   type_g_psca30_d
 
DEFINE g_psca31_d     DYNAMIC ARRAY OF type_g_psca31_d
DEFINE g_psca31_d_t   type_g_psca31_d
 
DEFINE g_psca32_d     DYNAMIC ARRAY OF type_g_psca32_d
DEFINE g_psca32_d_t   type_g_psca32_d
 
DEFINE g_psca33_d     DYNAMIC ARRAY OF type_g_psca33_d
DEFINE g_psca33_d_t   type_g_psca33_d
 
DEFINE g_psca34_d     DYNAMIC ARRAY OF type_g_psca34_d
DEFINE g_psca34_d_t   type_g_psca34_d
 
DEFINE g_psca35_d     DYNAMIC ARRAY OF type_g_psca35_d
DEFINE g_psca35_d_t   type_g_psca35_d
 
DEFINE g_psca36_d     DYNAMIC ARRAY OF type_g_psca36_d
DEFINE g_psca36_d_t   type_g_psca36_d
 
DEFINE g_psca4_d     DYNAMIC ARRAY OF type_g_psca4_d
DEFINE g_psca4_d_t   type_g_psca4_d
 
DEFINE g_psca5_d     DYNAMIC ARRAY OF type_g_psca5_d
DEFINE g_psca5_d_t   type_g_psca5_d
 
DEFINE g_psca6_d     DYNAMIC ARRAY OF type_g_psca6_d
DEFINE g_psca6_d_t   type_g_psca6_d
 
DEFINE g_psca7_d     DYNAMIC ARRAY OF type_g_psca7_d
DEFINE g_psca7_d_t   type_g_psca7_d
 
DEFINE g_psca8_d     DYNAMIC ARRAY OF type_g_psca8_d
DEFINE g_psca8_d_t   type_g_psca8_d
 
DEFINE g_psca9_d     DYNAMIC ARRAY OF type_g_psca9_d
DEFINE g_psca9_d_t   type_g_psca9_d
 
 
 
 
 
DEFINE g_wc                  STRING                        #儲存 user 的查詢條件
DEFINE g_wc_t                STRING                        #儲存 user 的查詢條件
DEFINE g_wc_filter           STRING
DEFINE g_wc_filter_t         STRING
DEFINE g_sql                 STRING                        #組 sql 用 
DEFINE g_forupd_sql          STRING                        #SELECT ... FOR UPDATE  SQL    
DEFINE g_cnt                 LIKE type_t.num10              
DEFINE l_ac                  LIKE type_t.num10             #目前處理的ARRAY CNT 
DEFINE g_curr_diag           ui.Dialog                     #Current Dialog     
DEFINE gwin_curr             ui.Window                     #Current Window
DEFINE gfrm_curr             ui.Form                       #Current Form
DEFINE g_current_page        LIKE type_t.num5              #目前所在頁數
DEFINE g_current_row         LIKE type_t.num10             #目前所在筆數
DEFINE g_current_idx         LIKE type_t.num10
DEFINE g_detail_cnt          LIKE type_t.num10             #單身 總筆數(所有資料)
DEFINE g_page                STRING                        #第幾頁
DEFINE g_ch                  base.Channel                  #外串程式用
DEFINE g_ref_fields          DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
DEFINE g_ref_vars            DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
DEFINE g_rtn_fields          DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
DEFINE g_error_show          LIKE type_t.num5
DEFINE g_row_index           LIKE type_t.num10
DEFINE g_master_idx          LIKE type_t.num10
DEFINE g_detail_idx          LIKE type_t.num10             #單身 所在筆數(所有資料)
DEFINE g_detail_idx2         LIKE type_t.num10
DEFINE g_hyper_url           STRING                        #hyperlink的主要網址
DEFINE g_qbe_hidden          LIKE type_t.num5              #qbe頁籤折疊
DEFINE g_tot_cnt             LIKE type_t.num10             #計算總筆數
DEFINE g_num_in_page         LIKE type_t.num10             #每頁筆數
DEFINE g_page_act_list       STRING                        #分頁ACTION清單
DEFINE g_current_row_tot     LIKE type_t.num10             #目前所在總筆數
DEFINE g_page_start_num      LIKE type_t.num10             #目前頁面起始筆數
DEFINE g_page_end_num        LIKE type_t.num10             #目前頁面結束筆數
 
#多table用wc
DEFINE g_wc_table           STRING
DEFINE g_detail_page_action STRING
DEFINE g_pagestart          LIKE type_t.num10
#16010-00020#1 ---add (S)---
DEFINE g_flag               STRING
DEFINE g_wc1                STRING
DEFINE g_wc2                STRING
DEFINE g_wc3                STRING
DEFINE g_wc4                STRING
DEFINE g_wc5                STRING
DEFINE g_wc6                STRING
DEFINE g_wc7                STRING
DEFINE g_wc8                STRING
DEFINE g_wc9                STRING
DEFINE g_wc10               STRING
DEFINE g_wc11               STRING
DEFINE g_wc12               STRING
DEFINE g_wc13               STRING
DEFINE g_wc14               STRING
DEFINE g_wc15               STRING
DEFINE g_wc16               STRING
DEFINE g_wc17               STRING
DEFINE g_wc18               STRING
DEFINE g_wc19               STRING
DEFINE g_wc20               STRING
DEFINE g_wc21               STRING
DEFINE g_wc22               STRING
DEFINE g_wc23               STRING
DEFINE g_wc24               STRING
DEFINE g_wc25               STRING
DEFINE g_wc26               STRING
DEFINE g_wc27               STRING
DEFINE g_wc28               STRING
DEFINE g_wc29               STRING
DEFINE g_wc30               STRING
DEFINE g_wc31               STRING
DEFINE g_wc32               STRING
DEFINE g_wc33               STRING
DEFINE g_wc34               STRING
DEFINE g_wc35               STRING
DEFINE g_wc36               STRING
DEFINE g_wc_table1          STRING
DEFINE g_wc_table2          STRING
DEFINE g_wc_table3          STRING
DEFINE g_wc_table4          STRING
DEFINE g_wc_table5          STRING
DEFINE g_wc_table6          STRING
DEFINE g_wc_table7          STRING
DEFINE g_wc_table8          STRING
DEFINE g_wc_table9          STRING
DEFINE g_wc_table10         STRING
DEFINE g_wc_table11         STRING
DEFINE g_wc_table12         STRING
DEFINE g_wc_table13         STRING
DEFINE g_wc_table14         STRING
DEFINE g_wc_table15         STRING
DEFINE g_wc_table16         STRING
DEFINE g_wc_table17         STRING
DEFINE g_wc_table18         STRING
DEFINE g_wc_table19         STRING
DEFINE g_wc_table20         STRING
DEFINE g_wc_table21         STRING
DEFINE g_wc_table22         STRING
DEFINE g_wc_table23         STRING
DEFINE g_wc_table24         STRING
DEFINE g_wc_table25         STRING
DEFINE g_wc_table26         STRING
DEFINE g_wc_table27         STRING
DEFINE g_wc_table28         STRING
DEFINE g_wc_table29         STRING
DEFINE g_wc_table30         STRING
DEFINE g_wc_table31         STRING
DEFINE g_wc_table32         STRING
DEFINE g_wc_table33         STRING
DEFINE g_wc_table34         STRING
DEFINE g_wc_table35         STRING
DEFINE g_wc_table36         STRING
#16010-00020#1 ---add (E)---
 
 
DEFINE g_wc_filter_table           STRING
 
 
 
#add-point:自定義模組變數-客製(Module Variable) name="global.variable_customerization"

#end add-point
 
#add-point:傳入參數說明 name="global.argv"

#end add-point
 
{</section>}
 
{<section id="apsq102.main" >}
 #應用 a26 樣板自動產生(Version:7)
#+ 作業開始(主程式類型)
MAIN
   #add-point:main段define(客製用) name="main.define_customerization"
   
   #end add-point   
   #add-point:main段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="main.define"
   
   #end add-point   
   
   OPTIONS
   INPUT NO WRAP
   DEFER INTERRUPT
   
   #設定SQL錯誤記錄方式 (模組內定義有效)
   WHENEVER ERROR CALL cl_err_msg_log
       
   #依模組進行系統初始化設定(系統設定)
   CALL cl_ap_init("aps","")
 
   #add-point:作業初始化 name="main.init"
   
   #end add-point
   
   
 
   #LOCK CURSOR (identifier)
   #add-point:SQL_define name="main.define_sql"
   
   #end add-point
   LET g_forupd_sql = " ", 
                      " FROM ",
                      " "
   #add-point:SQL_define name="main.after_define_sql"
   
   #end add-point
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)                #轉換不同資料庫語法
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE apsq102_cl CURSOR FROM g_forupd_sql                 # LOCK CURSOR
 
   LET g_sql = " SELECT  ",
               " FROM  t0",
               
               " WHERE  "
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   #add-point:SQL_define name="main.after_refresh_sql"
   
   #end add-point
   PREPARE apsq102_master_referesh FROM g_sql
 
   #add-point:main段define_sql name="main.body.define_sql"
   
   #end add-point 
   LET g_forupd_sql = ""
   #add-point:main段define_sql name="main.body.after_define_sql"
   
   #end add-point 
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE apsq102_bcl CURSOR FROM g_forupd_sql
    
 
   
   IF g_bgjob = "Y" THEN
      #add-point:Service Call name="main.servicecall"
      
      #end add-point
   ELSE
      #畫面開啟 (identifier)
      OPEN WINDOW w_apsq102 WITH FORM cl_ap_formpath("aps",g_code)
   
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
   
      #程式初始化
      CALL apsq102_init()   
 
      #進入選單 Menu (="N")
      CALL apsq102_ui_dialog() 
      
      #add-point:畫面關閉前 name="main.before_close"
      
      #end add-point
 
      #畫面關閉
      CLOSE WINDOW w_apsq102
      
   END IF 
   
   CLOSE apsq102_cl
   
   
 
   #add-point:作業離開前 name="main.exit"
   
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
END MAIN
 
 
 
 
{</section>}
 
{<section id="apsq102.init" >}
#+ 瀏覽頁簽資料初始化
PRIVATE FUNCTION apsq102_init()
   #add-point:init段define-客製 name="init.define_customerization"
   
   #end add-point
   #add-point:init段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="init.define"
   
   #end add-point
 
   #add-point:FUNCTION前置處理 name="init.before_function"
   
   #end add-point
 
   LET g_wc_filter   = " 1=1"
   LET g_wc_filter_t = " 1=1" 
   LET g_error_show  = 1
   LET g_detail_idx  = 1
   LET g_detail_idx2 = 1
   
     
 
   #add-point:畫面資料初始化 name="init.init"
   
   #end add-point
 
   CALL apsq102_default_search()
END FUNCTION
 
{</section>}
 
{<section id="apsq102.default_search" >}
PRIVATE FUNCTION apsq102_default_search()
   #add-point:default_search段define-客製 name="default_search.define_customerization"

   #end add-point
   #add-point:default_search段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="default_search.define"

   #end add-point
 
 
   #add-point:default_search段開始前 name="default_search.before"

   #end add-point
 
   #應用 qs27 樣板自動產生(Version:3)
   #+ 組承接外部參數時資料庫欄位對應條件(單身)
   IF NOT cl_null(g_argv[01]) THEN
      LET g_wc = g_wc, " psca001 = '", g_argv[01], "' AND "
   END IF
 
   IF NOT cl_null(g_wc) THEN
      LET g_wc = g_wc.subString(1,g_wc.getLength()-5)
   ELSE
      #預設查詢條件
      LET g_wc = " 1=2"
   END IF
 
   #add-point:default_search段結束前 name="default_search.after"

   #end add-point
 
END FUNCTION
 
{</section>}
 
{<section id="apsq102.ui_dialog" >}
#+ 選單功能實際執行處
PRIVATE FUNCTION apsq102_ui_dialog() 
   #add-point:ui_dialog段define-客製 name="ui_dialog.define_customerization"

   #end add-point
   DEFINE li_exit   LIKE type_t.num5    #判別是否為離開作業
   DEFINE li_idx    LIKE type_t.num10
   DEFINE ls_result STRING
   DEFINE ls_wc     STRING
   DEFINE lc_action_choice_old   STRING
   DEFINE ls_js     STRING
   DEFINE la_param  RECORD
                    prog       STRING,
                    actionid   STRING,
                    background LIKE type_t.chr1,
                    param      DYNAMIC ARRAY OF STRING
                    END RECORD
   DEFINE li_redirect     BOOLEAN  
   DEFINE ldig_curr       ui.Dialog
   #add-point:ui_dialog段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="ui_dialog.define"

   #end add-point
   
 
   #add-point:FUNCTION前置處理 name="ui_dialog.before_function"

   #end add-point
 
   CALL cl_set_act_visible("accept,cancel", FALSE)
   CALL cl_get_num_in_page() RETURNING g_num_in_page
 
   LET li_exit = FALSE
   LET gwin_curr = ui.Window.getCurrent()
   LET gfrm_curr = gwin_curr.getForm()   
   LET g_current_idx = 1
   LET g_action_choice = " "
   LET lc_action_choice_old = ""
   LET g_current_row_tot = 1
   LET g_page_start_num = 1
   LET g_page_end_num = g_num_in_page
   LET g_detail_idx = 1
   LET g_detail_idx2 = 1
   LET l_ac = 1
 
   #add-point:ui_dialog段before dialog  name="ui_dialog.before_dialog"
   #160107-00020#1 ---add (S)---
   IF NOT cl_null(g_wc) AND g_wc != " 1=2" THEN
   LET g_detail_idx = 1
   LET g_detail_idx2 = 1
   #160107-000203#1 ---add (E)---
       CALL apsq102_b_fill()
   #160107-00020#1 ---add (S)---
   ELSE
       CALL apsq102_query()
   END IF
   #160107-00020#1 ---add (E)---
   #end add-point
 
   
   #CALL apsq102_b_fill() #160107-00020#1 mark
  
   WHILE li_exit = FALSE
 
      IF g_action_choice = "logistics" THEN
         #清除畫面及相關資料
         CLEAR FORM
         CALL g_psca_d.clear()
         CALL g_psca10_d.clear()
 
         CALL g_psca11_d.clear()
 
         CALL g_psca12_d.clear()
 
         CALL g_psca13_d.clear()
 
         CALL g_psca14_d.clear()
 
         CALL g_psca15_d.clear()
 
         CALL g_psca16_d.clear()
 
         CALL g_psca17_d.clear()
 
         CALL g_psca18_d.clear()
 
         CALL g_psca19_d.clear()
 
         CALL g_psca2_d.clear()
 
         CALL g_psca20_d.clear()
 
         CALL g_psca21_d.clear()
 
         CALL g_psca22_d.clear()
 
         CALL g_psca23_d.clear()
 
         CALL g_psca24_d.clear()
 
         CALL g_psca25_d.clear()
 
         CALL g_psca26_d.clear()
 
         CALL g_psca27_d.clear()
 
         CALL g_psca28_d.clear()
 
         CALL g_psca29_d.clear()
 
         CALL g_psca3_d.clear()
 
         CALL g_psca30_d.clear()
 
         CALL g_psca31_d.clear()
 
         CALL g_psca32_d.clear()
 
         CALL g_psca33_d.clear()
 
         CALL g_psca34_d.clear()
 
         CALL g_psca35_d.clear()
 
         CALL g_psca36_d.clear()
 
         CALL g_psca4_d.clear()
 
         CALL g_psca5_d.clear()
 
         CALL g_psca6_d.clear()
 
         CALL g_psca7_d.clear()
 
         CALL g_psca8_d.clear()
 
         CALL g_psca9_d.clear()
 
 
         LET g_wc  = " 1=2"
         LET g_wc2 = " 1=1"
         LET g_action_choice = ""
         LET g_detail_page_action = "detail_first"
         LET g_pagestart = 1
         LET g_current_row_tot = 1
         LET g_page_start_num = 1
         LET g_page_end_num = g_num_in_page
         LET g_detail_idx = 1
         LET g_detail_idx2 = 1
 
         CALL apsq102_init()
      END IF
 
      DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
         #add-point:input段落 name="ui_dialog.input"

         #end add-point
 
         #add-point:construct段落 name="ui_dialog.construct"
         #QBE查詢條件
         #160107-00020#1 ---mark (S)---
         #INPUT BY NAME g_master.psca001,g_master.psea002
         #   ATTRIBUTE(WITHOUT DEFAULTS)
         #   
         #   BEFORE INPUT
         #   
         #   AFTER FIELD psca001
         #      IF NOT cl_null(g_master.psca001) THEN
         #         IF g_master.psca001 <> g_master_t.psca001 THEN
         #            LET g_master.psea002 = ''
         #         END IF
         #         LET g_master_t.psca001 = g_master.psca001
         #      END IF
         #   
         #   AFTER FIELD psea002
         #   
         #   ON ACTION controlp INFIELD psca001
         #      INITIALIZE g_qryparam.* TO NULL
         #      LET g_qryparam.state = "i"
         #      LET g_qryparam.reqry = FALSE
         #      CALL q_psca001()
         #      LET g_master.psca001 = g_qryparam.return1             
         #      DISPLAY g_master.psca001  TO psca001
         #      NEXT FIELD psca001
         #   
         #   ON ACTION controlp INFIELD psea002
         #      INITIALIZE g_qryparam.* TO NULL
         #      LET g_qryparam.state = "i"
         #      LET g_qryparam.reqry = FALSE
         #      LET g_qryparam.arg1  = g_master.psca001
         #      CALL q_psea002()
         #      LET g_master.psea002 = g_qryparam.return1             
         #      DISPLAY g_master.psea002  TO psea002
         #      NEXT FIELD psea002
         #END INPUT
         #160107-00020#1 ---mark (E)---

         #end add-point
     
         DISPLAY ARRAY g_psca_d TO s_detail1.* ATTRIBUTE(COUNT=g_detail_cnt)
 
            BEFORE DISPLAY
               LET g_current_page = 1
 
            BEFORE ROW
               LET g_detail_idx = DIALOG.getCurrentRow("s_detail1")
               LET l_ac = g_detail_idx
               CALL apsq102_detail_action_trans()
 
               LET g_master_idx = l_ac
               #為避免按上下筆時影響執行效能，所以做一些處理
               LET lc_action_choice_old = g_action_choice
               LET g_action_choice = "fetch"
               CALL apsq102_b_fill2() 
               LET g_action_choice = lc_action_choice_old
 
               #add-point:input段before row name="input.body.before_row"

               #end add-point
 
            
 
            #自訂ACTION(detail_show,page_1)
            
 
            #add-point:page1自定義行為 name="ui_dialog.body.page1.action"

            #end add-point
 
         END DISPLAY
 
         #add-point:第一頁籤程式段mark結束用 name="ui_dialog.page1.mark.end"

         #end add-point
 
         DISPLAY ARRAY g_psca10_d TO s_detail10.*
            ATTRIBUTES(COUNT=g_detail_cnt)
 
            BEFORE DISPLAY
               LET g_current_page = 10
  
            BEFORE ROW
               LET g_detail_idx = DIALOG.getCurrentRow("s_detail10")
               LET l_ac = g_detail_idx
               LET g_detail_idx = l_ac
               DISPLAY g_detail_idx TO FORMONLY.idx
               #add-point:input段before row name="input.body10.before_row"
               LET g_detail_idx = DIALOG.getCurrentRow("s_detail10")
               LET l_ac = g_detail_idx
               CALL apsq102_detail_action_trans()
               #end add-point
 
            #自訂ACTION(detail_show,page_10)
            
 
            #add-point:page2自定義行為 name="ui_dialog.body10.action"

            #end add-point
 
         END DISPLAY
 
         DISPLAY ARRAY g_psca11_d TO s_detail11.*
            ATTRIBUTES(COUNT=g_detail_cnt)
 
            BEFORE DISPLAY
               LET g_current_page = 11
 
            BEFORE ROW
               LET g_detail_idx = DIALOG.getCurrentRow("s_detail11")
               LET l_ac = g_detail_idx
               LET g_detail_idx = l_ac
               DISPLAY g_detail_idx TO FORMONLY.idx
 
               #add-point:input段before row name="input.body11.before_row"
               LET g_detail_idx = DIALOG.getCurrentRow("s_detail11")
               LET l_ac = g_detail_idx
               CALL apsq102_detail_action_trans()
               #end add-point
 
            #自訂ACTION(detail_show,page_11)
            
 
            #add-point:page3自定義行為 name="ui_dialog.body11.action"

            #end add-point
 
         END DISPLAY
 
         DISPLAY ARRAY g_psca12_d TO s_detail12.*
            ATTRIBUTES(COUNT=g_detail_cnt)
 
            BEFORE DISPLAY
               LET g_current_page = 12
 
            BEFORE ROW
               LET g_detail_idx = DIALOG.getCurrentRow("s_detail12")
               LET l_ac = g_detail_idx
               LET g_detail_idx = l_ac
               DISPLAY g_detail_idx TO FORMONLY.idx
 
               #add-point:input段before row name="input.body12.before_row"
               LET g_detail_idx = DIALOG.getCurrentRow("s_detail12")
               LET l_ac = g_detail_idx
               CALL apsq102_detail_action_trans()
               #end add-point
 
            #自訂ACTION(detail_show,page_12)
            
 
            #add-point:page4自定義行為 name="ui_dialog.body12.action"

            #end add-point
 
         END DISPLAY
 
         DISPLAY ARRAY g_psca13_d TO s_detail13.*
            ATTRIBUTES(COUNT=g_detail_cnt)
 
            BEFORE DISPLAY
               LET g_current_page = 13
 
            BEFORE ROW
               LET g_detail_idx = DIALOG.getCurrentRow("s_detail13")
               LET l_ac = g_detail_idx
               LET g_detail_idx = l_ac
               DISPLAY g_detail_idx TO FORMONLY.idx
 
               #add-point:input段before row name="input.body13.before_row"
               LET g_detail_idx = DIALOG.getCurrentRow("s_detail13")
               LET l_ac = g_detail_idx
               CALL apsq102_detail_action_trans()
               #end add-point
 
            #自訂ACTION(detail_show,page_13)
            
 
            #add-point:page5自定義行為 name="ui_dialog.body13.action"

            #end add-point
 
         END DISPLAY
 
         DISPLAY ARRAY g_psca14_d TO s_detail14.*
            ATTRIBUTES(COUNT=g_detail_cnt)
 
            BEFORE DISPLAY
               LET g_current_page = 14
 
            BEFORE ROW
               LET g_detail_idx = DIALOG.getCurrentRow("s_detail14")
               LET l_ac = g_detail_idx
               LET g_detail_idx = l_ac
               DISPLAY g_detail_idx TO FORMONLY.idx
 
               #add-point:input段before row name="input.body14.before_row"
               LET g_detail_idx = DIALOG.getCurrentRow("s_detail14")
               LET l_ac = g_detail_idx
               CALL apsq102_detail_action_trans()
               #end add-point
 
            #自訂ACTION(detail_show,page_14)
            
 
            #add-point:page6自定義行為 name="ui_dialog.body14.action"

            #end add-point
 
         END DISPLAY
 
         DISPLAY ARRAY g_psca15_d TO s_detail15.*
            ATTRIBUTES(COUNT=g_detail_cnt)
 
            BEFORE DISPLAY
               LET g_current_page = 15
 
            BEFORE ROW
               LET g_detail_idx = DIALOG.getCurrentRow("s_detail15")
               LET l_ac = g_detail_idx
               LET g_detail_idx = l_ac
               DISPLAY g_detail_idx TO FORMONLY.idx
 
               #add-point:input段before row name="input.body15.before_row"
               LET g_detail_idx = DIALOG.getCurrentRow("s_detail15")
               LET l_ac = g_detail_idx
               CALL apsq102_detail_action_trans()
               #end add-point
 
            #自訂ACTION(detail_show,page_15)
            
 
            #add-point:page7自定義行為 name="ui_dialog.body15.action"

            #end add-point
 
         END DISPLAY
 
         DISPLAY ARRAY g_psca16_d TO s_detail16.*
            ATTRIBUTES(COUNT=g_detail_cnt)
 
            BEFORE DISPLAY
               LET g_current_page = 16
 
            BEFORE ROW
               LET g_detail_idx = DIALOG.getCurrentRow("s_detail16")
               LET l_ac = g_detail_idx
               LET g_detail_idx = l_ac
               DISPLAY g_detail_idx TO FORMONLY.idx
 
               #add-point:input段before row name="input.body16.before_row"
               LET g_detail_idx = DIALOG.getCurrentRow("s_detail16")
               LET l_ac = g_detail_idx
               CALL apsq102_detail_action_trans()
               #end add-point
 
            #自訂ACTION(detail_show,page_16)
            
 
            #add-point:page8自定義行為 name="ui_dialog.body16.action"

            #end add-point
 
         END DISPLAY
 
         DISPLAY ARRAY g_psca17_d TO s_detail17.*
            ATTRIBUTES(COUNT=g_detail_cnt)
 
            BEFORE DISPLAY
               LET g_current_page = 17
 
            BEFORE ROW
               LET g_detail_idx = DIALOG.getCurrentRow("s_detail17")
               LET l_ac = g_detail_idx
               LET g_detail_idx = l_ac
               DISPLAY g_detail_idx TO FORMONLY.idx
 
               #add-point:input段before row name="input.body17.before_row"
               LET g_detail_idx = DIALOG.getCurrentRow("s_detail17")
               LET l_ac = g_detail_idx
               CALL apsq102_detail_action_trans()
               #end add-point
 
            #自訂ACTION(detail_show,page_17)
            
 
            #add-point:page9自定義行為 name="ui_dialog.body17.action"

            #end add-point
 
         END DISPLAY
 
         DISPLAY ARRAY g_psca18_d TO s_detail18.*
            ATTRIBUTES(COUNT=g_detail_cnt)
 
            BEFORE DISPLAY
               LET g_current_page = 18
 
            BEFORE ROW
               LET g_detail_idx = DIALOG.getCurrentRow("s_detail18")
               LET l_ac = g_detail_idx
               LET g_detail_idx = l_ac
               DISPLAY g_detail_idx TO FORMONLY.idx
 
               #add-point:input段before row name="input.body18.before_row"
               LET g_detail_idx = DIALOG.getCurrentRow("s_detail18")
               LET l_ac = g_detail_idx
               CALL apsq102_detail_action_trans()
               #end add-point
 
            #自訂ACTION(detail_show,page_18)
            
 
            #add-point:page10自定義行為 name="ui_dialog.body18.action"

            #end add-point
 
         END DISPLAY
 
         DISPLAY ARRAY g_psca19_d TO s_detail19.*
            ATTRIBUTES(COUNT=g_detail_cnt)
 
            BEFORE DISPLAY
               LET g_current_page = 19
 
            BEFORE ROW
               LET g_detail_idx = DIALOG.getCurrentRow("s_detail19")
               LET l_ac = g_detail_idx
               LET g_detail_idx = l_ac
               DISPLAY g_detail_idx TO FORMONLY.idx
 
               #add-point:input段before row name="input.body19.before_row"
               LET g_detail_idx = DIALOG.getCurrentRow("s_detail19")
               LET l_ac = g_detail_idx
               CALL apsq102_detail_action_trans()
               #end add-point
 
            #自訂ACTION(detail_show,page_19)
            
 
            #add-point:page11自定義行為 name="ui_dialog.body19.action"

            #end add-point
 
         END DISPLAY
 
         DISPLAY ARRAY g_psca2_d TO s_detail2.*
            ATTRIBUTES(COUNT=g_detail_cnt)
 
            BEFORE DISPLAY
               LET g_current_page = 2
 
            BEFORE ROW
               LET g_detail_idx = DIALOG.getCurrentRow("s_detail2")
               LET l_ac = g_detail_idx
               LET g_detail_idx = l_ac
               DISPLAY g_detail_idx TO FORMONLY.idx
 
               #add-point:input段before row name="input.body2.before_row"
               LET g_detail_idx = DIALOG.getCurrentRow("s_detail2")
               LET l_ac = g_detail_idx
               CALL apsq102_detail_action_trans()
               #end add-point
 
            #自訂ACTION(detail_show,page_2)
            
 
            #add-point:page12自定義行為 name="ui_dialog.body2.action"

            #end add-point
 
         END DISPLAY
 
         DISPLAY ARRAY g_psca20_d TO s_detail20.*
            ATTRIBUTES(COUNT=g_detail_cnt)
 
            BEFORE DISPLAY
               LET g_current_page = 20
 
            BEFORE ROW
               LET g_detail_idx = DIALOG.getCurrentRow("s_detail20")
               LET l_ac = g_detail_idx
               LET g_detail_idx = l_ac
               DISPLAY g_detail_idx TO FORMONLY.idx
 
               #add-point:input段before row name="input.body20.before_row"
               LET g_detail_idx = DIALOG.getCurrentRow("s_detail20")
               LET l_ac = g_detail_idx
               CALL apsq102_detail_action_trans()
               #end add-point
 
            #自訂ACTION(detail_show,page_20)
            
 
            #add-point:page13自定義行為 name="ui_dialog.body20.action"

            #end add-point
 
         END DISPLAY
 
         DISPLAY ARRAY g_psca21_d TO s_detail21.*
            ATTRIBUTES(COUNT=g_detail_cnt)
 
            BEFORE DISPLAY
               LET g_current_page = 21
               LET g_detail_idx = 1
               LET g_current_row_tot = 1
               LET g_tot_cnt = g_psca21_d.getLength()
               CALL apsq102_detail_action_trans()
 
            BEFORE ROW
               LET g_detail_idx = DIALOG.getCurrentRow("s_detail21")
               LET l_ac = g_detail_idx
               LET g_detail_idx = l_ac
               CALL apsq102_detail_action_trans()
               DISPLAY g_detail_idx TO FORMONLY.idx
 
               #add-point:input段before row name="input.body21.before_row"
 
               #end add-point
 
            #自訂ACTION(detail_show,page_21)
            
 
            #add-point:page14自定義行為 name="ui_dialog.body21.action"

            #end add-point
 
         END DISPLAY
 
         DISPLAY ARRAY g_psca22_d TO s_detail22.*
            ATTRIBUTES(COUNT=g_detail_cnt)
 
            BEFORE DISPLAY
               LET g_current_page = 22
               LET g_detail_idx = 1
               LET g_current_row_tot = 1
               LET g_tot_cnt = g_psca22_d.getLength()
               CALL apsq102_detail_action_trans()
 
            BEFORE ROW
               LET g_detail_idx = DIALOG.getCurrentRow("s_detail22")
               LET l_ac = g_detail_idx
               LET g_detail_idx = l_ac
               CALL apsq102_detail_action_trans()
               DISPLAY g_detail_idx TO FORMONLY.idx
 
               #add-point:input段before row name="input.body22.before_row"
 
               #end add-point
 
            #自訂ACTION(detail_show,page_22)
            
 
            #add-point:page15自定義行為 name="ui_dialog.body22.action"

            #end add-point
 
         END DISPLAY
 
         DISPLAY ARRAY g_psca23_d TO s_detail23.*
            ATTRIBUTES(COUNT=g_detail_cnt)
 
            BEFORE DISPLAY
               LET g_current_page = 23
               LET g_detail_idx = 1
               LET g_current_row_tot = 1
               LET g_tot_cnt = g_psca23_d.getLength()
               CALL apsq102_detail_action_trans()
 
            BEFORE ROW
               LET g_detail_idx = DIALOG.getCurrentRow("s_detail23")
               LET l_ac = g_detail_idx
               LET g_detail_idx = l_ac
               CALL apsq102_detail_action_trans()
               DISPLAY g_detail_idx TO FORMONLY.idx
 
               #add-point:input段before row name="input.body23.before_row"
 
               #end add-point
 
            #自訂ACTION(detail_show,page_23)
            
 
            #add-point:page16自定義行為 name="ui_dialog.body23.action"

            #end add-point
 
         END DISPLAY
 
         DISPLAY ARRAY g_psca24_d TO s_detail24.*
            ATTRIBUTES(COUNT=g_detail_cnt)
 
            BEFORE DISPLAY
               LET g_current_page = 24
               LET g_detail_idx = 1
               LET g_current_row_tot = 1
               LET g_tot_cnt = g_psca24_d.getLength()
               CALL apsq102_detail_action_trans()
 
            BEFORE ROW
               LET g_detail_idx = DIALOG.getCurrentRow("s_detail24")
               LET l_ac = g_detail_idx
               LET g_detail_idx = l_ac
               CALL apsq102_detail_action_trans()
               DISPLAY g_detail_idx TO FORMONLY.idx
 
               #add-point:input段before row name="input.body24.before_row"
 
               #end add-point
 
            #自訂ACTION(detail_show,page_24)
            
 
            #add-point:page17自定義行為 name="ui_dialog.body24.action"

            #end add-point
 
         END DISPLAY
 
         DISPLAY ARRAY g_psca25_d TO s_detail25.*
            ATTRIBUTES(COUNT=g_detail_cnt)
 
            BEFORE DISPLAY
               LET g_current_page = 25
               LET g_detail_idx = 1
               LET g_current_row_tot = 1
               LET g_tot_cnt = g_psca25_d.getLength()
               CALL apsq102_detail_action_trans()
 
            BEFORE ROW
               LET g_detail_idx = DIALOG.getCurrentRow("s_detail25")
               LET l_ac = g_detail_idx
               LET g_detail_idx = l_ac
               CALL apsq102_detail_action_trans()
               DISPLAY g_detail_idx TO FORMONLY.idx
 
               #add-point:input段before row name="input.body25.before_row"
 
               #end add-point
 
            #自訂ACTION(detail_show,page_25)
            
 
            #add-point:page18自定義行為 name="ui_dialog.body25.action"

            #end add-point
 
         END DISPLAY
 
         DISPLAY ARRAY g_psca26_d TO s_detail26.*
            ATTRIBUTES(COUNT=g_detail_cnt)
 
            BEFORE DISPLAY
               LET g_current_page = 26
               LET g_detail_idx = 1
               LET g_current_row_tot = 1
               LET g_tot_cnt = g_psca26_d.getLength()
               CALL apsq102_detail_action_trans()
 
            BEFORE ROW
               LET g_detail_idx = DIALOG.getCurrentRow("s_detail26")
               LET l_ac = g_detail_idx
               LET g_detail_idx = l_ac
               CALL apsq102_detail_action_trans()
               DISPLAY g_detail_idx TO FORMONLY.idx
 
               #add-point:input段before row name="input.body26.before_row"
 
               #end add-point
 
            #自訂ACTION(detail_show,page_26)
            
 
            #add-point:page19自定義行為 name="ui_dialog.body26.action"

            #end add-point
 
         END DISPLAY
 
         DISPLAY ARRAY g_psca27_d TO s_detail27.*
            ATTRIBUTES(COUNT=g_detail_cnt)
 
            BEFORE DISPLAY
               LET g_current_page = 27
               LET g_detail_idx = 1
               LET g_current_row_tot = 1
               LET g_tot_cnt = g_psca27_d.getLength()
               CALL apsq102_detail_action_trans()
 
            BEFORE ROW
               LET g_detail_idx = DIALOG.getCurrentRow("s_detail27")
               LET l_ac = g_detail_idx
               LET g_detail_idx = l_ac
               CALL apsq102_detail_action_trans()
               DISPLAY g_detail_idx TO FORMONLY.idx
 
               #add-point:input段before row name="input.body27.before_row"
 
               #end add-point
 
            #自訂ACTION(detail_show,page_27)
            
 
            #add-point:page20自定義行為 name="ui_dialog.body27.action"

            #end add-point
 
         END DISPLAY
 
         DISPLAY ARRAY g_psca28_d TO s_detail28.*
            ATTRIBUTES(COUNT=g_detail_cnt)
 
            BEFORE DISPLAY
               LET g_current_page = 28
               LET g_detail_idx = 1
               LET g_current_row_tot = 1
               LET g_tot_cnt = g_psca28_d.getLength()
               CALL apsq102_detail_action_trans()
 
            BEFORE ROW
               LET g_detail_idx = DIALOG.getCurrentRow("s_detail28")
               LET l_ac = g_detail_idx
               LET g_detail_idx = l_ac
               CALL apsq102_detail_action_trans()
               DISPLAY g_detail_idx TO FORMONLY.idx
 
               #add-point:input段before row name="input.body28.before_row"
 
               #end add-point
 
            #自訂ACTION(detail_show,page_28)
            
 
            #add-point:page21自定義行為 name="ui_dialog.body28.action"

            #end add-point
 
         END DISPLAY
 
         DISPLAY ARRAY g_psca29_d TO s_detail29.*
            ATTRIBUTES(COUNT=g_detail_cnt)
 
            BEFORE DISPLAY
               LET g_current_page = 29
               LET g_detail_idx = 1
               LET g_current_row_tot = 1
               LET g_tot_cnt = g_psca29_d.getLength()
               CALL apsq102_detail_action_trans()
 
            BEFORE ROW
               LET g_detail_idx = DIALOG.getCurrentRow("s_detail29")
               LET l_ac = g_detail_idx
               LET g_detail_idx = l_ac
               CALL apsq102_detail_action_trans()
               DISPLAY g_detail_idx TO FORMONLY.idx
 
               #add-point:input段before row name="input.body29.before_row"
 
               #end add-point
 
            #自訂ACTION(detail_show,page_29)
            
 
            #add-point:page22自定義行為 name="ui_dialog.body29.action"

            #end add-point
 
         END DISPLAY
 
         DISPLAY ARRAY g_psca3_d TO s_detail3.*
            ATTRIBUTES(COUNT=g_detail_cnt)
 
            BEFORE DISPLAY
               LET g_current_page = 3
 
            BEFORE ROW
               LET g_detail_idx = DIALOG.getCurrentRow("s_detail3")
               LET l_ac = g_detail_idx
               LET g_detail_idx = l_ac
               DISPLAY g_detail_idx TO FORMONLY.idx
 
               #add-point:input段before row name="input.body3.before_row"
               LET g_detail_idx = DIALOG.getCurrentRow("s_detail3")
               LET l_ac = g_detail_idx
               CALL apsq102_detail_action_trans()
               #end add-point
 
            #自訂ACTION(detail_show,page_3)
            
 
            #add-point:page23自定義行為 name="ui_dialog.body3.action"

            #end add-point
 
         END DISPLAY
 
         DISPLAY ARRAY g_psca30_d TO s_detail30.*
            ATTRIBUTES(COUNT=g_detail_cnt)
 
            BEFORE DISPLAY
               LET g_current_page = 30
               LET g_detail_idx = 1
               LET g_current_row_tot = 1
               LET g_tot_cnt = g_psca30_d.getLength()
               CALL apsq102_detail_action_trans()
               
            BEFORE ROW
               LET g_detail_idx = DIALOG.getCurrentRow("s_detail30")
               LET l_ac = g_detail_idx
               LET g_detail_idx = l_ac
               CALL apsq102_detail_action_trans()
               DISPLAY g_detail_idx TO FORMONLY.idx
 
               #add-point:input段before row name="input.body30.before_row"
 
               #end add-point
 
            #自訂ACTION(detail_show,page_30)
            
 
            #add-point:page24自定義行為 name="ui_dialog.body30.action"

            #end add-point
 
         END DISPLAY
 
         DISPLAY ARRAY g_psca31_d TO s_detail31.*
            ATTRIBUTES(COUNT=g_detail_cnt)
 
            BEFORE DISPLAY
               LET g_current_page = 31
               LET g_detail_idx = 1
               LET g_current_row_tot = 1
               LET g_tot_cnt = g_psca31_d.getLength()
               CALL apsq102_detail_action_trans()               
 
            BEFORE ROW
               LET g_detail_idx = DIALOG.getCurrentRow("s_detail31")
               LET l_ac = g_detail_idx
               LET g_detail_idx = l_ac
               CALL apsq102_detail_action_trans()
               DISPLAY g_detail_idx TO FORMONLY.idx
 
               #add-point:input段before row name="input.body31.before_row"
 
               #end add-point
 
            #自訂ACTION(detail_show,page_31)
            
 
            #add-point:page25自定義行為 name="ui_dialog.body31.action"

            #end add-point
 
         END DISPLAY
 
         DISPLAY ARRAY g_psca32_d TO s_detail32.*
            ATTRIBUTES(COUNT=g_detail_cnt)
 
            BEFORE DISPLAY
               LET g_current_page = 32
               LET g_detail_idx = 1
               LET g_current_row_tot = 1
               LET g_tot_cnt = g_psca32_d.getLength()
               CALL apsq102_detail_action_trans()
 
            BEFORE ROW
               LET g_detail_idx = DIALOG.getCurrentRow("s_detail32")
               LET l_ac = g_detail_idx
               LET g_detail_idx = l_ac
               CALL apsq102_detail_action_trans()
               DISPLAY g_detail_idx TO FORMONLY.idx
 
               #add-point:input段before row name="input.body32.before_row"
 
               #end add-point
 
            #自訂ACTION(detail_show,page_32)
            
 
            #add-point:page26自定義行為 name="ui_dialog.body32.action"

            #end add-point
 
         END DISPLAY
 
         DISPLAY ARRAY g_psca33_d TO s_detail33.*
            ATTRIBUTES(COUNT=g_detail_cnt)
 
            BEFORE DISPLAY
               LET g_current_page = 33
               LET g_detail_idx = 1
               LET g_current_row_tot = 1
               LET g_tot_cnt = g_psca33_d.getLength()
               CALL apsq102_detail_action_trans()               
 
            BEFORE ROW
               LET g_detail_idx = DIALOG.getCurrentRow("s_detail33")
               LET l_ac = g_detail_idx
               LET g_detail_idx = l_ac
               CALL apsq102_detail_action_trans()
               DISPLAY g_detail_idx TO FORMONLY.idx
 
               #add-point:input段before row name="input.body33.before_row"
 
               #end add-point
 
            #自訂ACTION(detail_show,page_33)
            
 
            #add-point:page27自定義行為 name="ui_dialog.body33.action"

            #end add-point
 
         END DISPLAY
 
         DISPLAY ARRAY g_psca34_d TO s_detail34.*
            ATTRIBUTES(COUNT=g_detail_cnt)
 
            BEFORE DISPLAY
               LET g_current_page = 34
               LET g_detail_idx = 1
               LET g_current_row_tot = 1
               LET g_tot_cnt = g_psca34_d.getLength()
               CALL apsq102_detail_action_trans()               
 
            BEFORE ROW
               LET g_detail_idx = DIALOG.getCurrentRow("s_detail34")
               LET l_ac = g_detail_idx
               LET g_detail_idx = l_ac
               CALL apsq102_detail_action_trans()
               DISPLAY g_detail_idx TO FORMONLY.idx
 
               #add-point:input段before row name="input.body34.before_row"
 
               #end add-point
 
            #自訂ACTION(detail_show,page_34)
            
 
            #add-point:page28自定義行為 name="ui_dialog.body34.action"

            #end add-point
 
         END DISPLAY
 
         DISPLAY ARRAY g_psca35_d TO s_detail35.*
            ATTRIBUTES(COUNT=g_detail_cnt)
 
            BEFORE DISPLAY
               LET g_current_page = 35
               LET g_detail_idx = 1
               LET g_current_row_tot = 1
               LET g_tot_cnt = g_psca35_d.getLength()
               CALL apsq102_detail_action_trans()
 
            BEFORE ROW
               LET g_detail_idx = DIALOG.getCurrentRow("s_detail35")
               LET l_ac = g_detail_idx
               LET g_detail_idx = l_ac
               CALL apsq102_detail_action_trans()
               DISPLAY g_detail_idx TO FORMONLY.idx
 
               #add-point:input段before row name="input.body35.before_row"
 
               #end add-point
 
            #自訂ACTION(detail_show,page_35)
            
 
            #add-point:page29自定義行為 name="ui_dialog.body35.action"

            #end add-point
 
         END DISPLAY
 
         DISPLAY ARRAY g_psca36_d TO s_detail36.*
            ATTRIBUTES(COUNT=g_detail_cnt)
 
            BEFORE DISPLAY
               LET g_current_page = 36
               LET g_detail_idx = 1
               LET g_current_row_tot = 1
               LET g_tot_cnt = g_psca36_d.getLength()
               CALL apsq102_detail_action_trans()
 
            BEFORE ROW
               LET g_detail_idx = DIALOG.getCurrentRow("s_detail36")
               LET l_ac = g_detail_idx
               LET g_detail_idx = l_ac
               CALL apsq102_detail_action_trans()
               DISPLAY g_detail_idx TO FORMONLY.idx
 
               #add-point:input段before row name="input.body36.before_row"
 
               #end add-point
 
            #自訂ACTION(detail_show,page_36)
            
 
            #add-point:page30自定義行為 name="ui_dialog.body36.action"

            #end add-point
 
         END DISPLAY
 
         DISPLAY ARRAY g_psca4_d TO s_detail4.*
            ATTRIBUTES(COUNT=g_detail_cnt)
 
            BEFORE DISPLAY
               LET g_current_page = 4
 
            BEFORE ROW
               LET g_detail_idx = DIALOG.getCurrentRow("s_detail4")
               LET l_ac = g_detail_idx
               LET g_detail_idx = l_ac
               DISPLAY g_detail_idx TO FORMONLY.idx
 
               #add-point:input段before row name="input.body4.before_row"
               LET g_detail_idx = DIALOG.getCurrentRow("s_detail4")
               LET l_ac = g_detail_idx
               CALL apsq102_detail_action_trans()
               #end add-point
 
            #自訂ACTION(detail_show,page_4)
            
 
            #add-point:page31自定義行為 name="ui_dialog.body4.action"

            #end add-point
 
         END DISPLAY
 
         DISPLAY ARRAY g_psca5_d TO s_detail5.*
            ATTRIBUTES(COUNT=g_detail_cnt)
 
            BEFORE DISPLAY
               LET g_current_page = 5
 
            BEFORE ROW
               LET g_detail_idx = DIALOG.getCurrentRow("s_detail5")
               LET l_ac = g_detail_idx
               LET g_detail_idx = l_ac
               DISPLAY g_detail_idx TO FORMONLY.idx
 
               #add-point:input段before row name="input.body5.before_row"
               LET g_detail_idx = DIALOG.getCurrentRow("s_detail5")
               LET l_ac = g_detail_idx
               CALL apsq102_detail_action_trans()
               #end add-point
 
            #自訂ACTION(detail_show,page_5)
            
 
            #add-point:page32自定義行為 name="ui_dialog.body5.action"

            #end add-point
 
         END DISPLAY
 
         DISPLAY ARRAY g_psca6_d TO s_detail6.*
            ATTRIBUTES(COUNT=g_detail_cnt)
 
            BEFORE DISPLAY
               LET g_current_page = 6
 
            BEFORE ROW
               LET g_detail_idx = DIALOG.getCurrentRow("s_detail6")
               LET l_ac = g_detail_idx
               LET g_detail_idx = l_ac
               DISPLAY g_detail_idx TO FORMONLY.idx
 
               #add-point:input段before row name="input.body6.before_row"
               LET g_detail_idx = DIALOG.getCurrentRow("s_detail6")
               LET l_ac = g_detail_idx
               CALL apsq102_detail_action_trans()
               #end add-point
 
            #自訂ACTION(detail_show,page_6)
            
 
            #add-point:page33自定義行為 name="ui_dialog.body6.action"

            #end add-point
 
         END DISPLAY
 
         DISPLAY ARRAY g_psca7_d TO s_detail7.*
            ATTRIBUTES(COUNT=g_detail_cnt)
 
            BEFORE DISPLAY
               LET g_current_page = 7
 
            BEFORE ROW
               LET g_detail_idx = DIALOG.getCurrentRow("s_detail7")
               LET l_ac = g_detail_idx
               LET g_detail_idx = l_ac
               DISPLAY g_detail_idx TO FORMONLY.idx
 
               #add-point:input段before row name="input.body7.before_row"
               LET g_detail_idx = DIALOG.getCurrentRow("s_detail7")
               LET l_ac = g_detail_idx
               CALL apsq102_detail_action_trans()
               #end add-point
 
            #自訂ACTION(detail_show,page_7)
            
 
            #add-point:page34自定義行為 name="ui_dialog.body7.action"

            #end add-point
 
         END DISPLAY
 
         DISPLAY ARRAY g_psca8_d TO s_detail8.*
            ATTRIBUTES(COUNT=g_detail_cnt)
 
            BEFORE DISPLAY
               LET g_current_page = 8
 
            BEFORE ROW
               LET g_detail_idx = DIALOG.getCurrentRow("s_detail8")
               LET l_ac = g_detail_idx
               LET g_detail_idx = l_ac
               DISPLAY g_detail_idx TO FORMONLY.idx
 
               #add-point:input段before row name="input.body8.before_row"
               LET g_detail_idx = DIALOG.getCurrentRow("s_detail8")
               LET l_ac = g_detail_idx
               CALL apsq102_detail_action_trans()
               #end add-point
 
            #自訂ACTION(detail_show,page_8)
            
 
            #add-point:page35自定義行為 name="ui_dialog.body8.action"

            #end add-point
 
         END DISPLAY
 
         DISPLAY ARRAY g_psca9_d TO s_detail9.*
            ATTRIBUTES(COUNT=g_detail_cnt)
 
            BEFORE DISPLAY
               LET g_current_page = 9
 
            BEFORE ROW
               LET g_detail_idx = DIALOG.getCurrentRow("s_detail9")
               LET l_ac = g_detail_idx
               LET g_detail_idx = l_ac
               DISPLAY g_detail_idx TO FORMONLY.idx
 
               #add-point:input段before row name="input.body9.before_row"
               LET g_detail_idx = DIALOG.getCurrentRow("s_detail9")
               LET l_ac = g_detail_idx
               CALL apsq102_detail_action_trans()
               #end add-point
 
            #自訂ACTION(detail_show,page_9)
            
 
            #add-point:page36自定義行為 name="ui_dialog.body9.action"

            #end add-point
 
         END DISPLAY
 
 
 
         #add-point:ui_dialog段自定義display array name="ui_dialog.more_displayarray"

         #end add-point
 
         BEFORE DIALOG
            LET g_curr_diag = ui.DIALOG.getCurrent() 
            CALL DIALOG.setSelectionMode("s_detail1", 1)
           #LET g_detail_idx = DIALOG.getCurrentRow("s_detail1") #160107-00020#1 mark
            CALL apsq102_detail_action_trans()
 
            #add-point:ui_dialog段before dialog name="ui_dialog.bef_dialog"
            #160107-00020#1 ---add (S)---
            CALL cl_set_comp_visible("sel",FALSE)
            CALL DIALOG.setCurrentRow("s_detail1",g_detail_idx)
            #160107-00020#1 ---add (E)---
            #end add-point
            #NEXT FIELD psca001 #160107-00020#1 mark
 
         AFTER DIALOG
            #add-point:ui_dialog段 after dialog name="ui_dialog.after_dialog"
         ON ACTION Demand_Order
            LET g_detail_idx = 1 
            LET g_current_row_tot = 1
            LET g_tot_cnt = g_psca_d.getLength()
            CALL apsq102_detail_action_trans()
         ON ACTION Suggest_Purchase_Order
            LET g_detail_idx = 1 
            LET g_current_row_tot = 1
            LET g_tot_cnt = g_psca2_d.getLength()
            CALL apsq102_detail_action_trans()
         ON ACTION Suggest_Mfg_Order
            LET g_detail_idx = 1 
            LET g_current_row_tot = 1
            LET g_tot_cnt = g_psca3_d.getLength()
            CALL apsq102_detail_action_trans()
         ON ACTION Material_Release
            LET g_detail_idx = 1 
            LET g_current_row_tot = 1
            LET g_tot_cnt = g_psca4_d.getLength()
            CALL apsq102_detail_action_trans()
         ON ACTION Item_Master
            LET g_detail_idx = 1
            LET g_current_row_tot = 1
            LET g_tot_cnt = g_psca5_d.getLength()
            CALL apsq102_detail_action_trans()
         ON ACTION Feature_Group
            LET g_detail_idx = 1
            LET g_current_row_tot = 1
            LET g_tot_cnt = g_psca6_d.getLength()
            CALL apsq102_detail_action_trans()
         ON ACTION Bill_of_Material
            LET g_detail_idx = 1
            LET g_current_row_tot = 1
            LET g_tot_cnt = g_psca7_d.getLength()
            CALL apsq102_detail_action_trans()
         ON ACTION Unassigned_Inventory
            LET g_detail_idx = 1
            LET g_current_row_tot = 1
            LET g_tot_cnt = g_psca8_d.getLength()
            CALL apsq102_detail_action_trans()
         ON ACTION Warehouse
            LET g_detail_idx = 1
            LET g_current_row_tot = 1
            LET g_tot_cnt = g_psca9_d.getLength()
            CALL apsq102_detail_action_trans()
         ON ACTION Stock_Location
            LET g_detail_idx = 1
            LET g_current_row_tot = 1
            LET g_tot_cnt = g_psca10_d.getLength()
            CALL apsq102_detail_action_trans()
         ON ACTION BOM_Feature_Type1
            LET g_detail_idx = 1
            LET g_current_row_tot = 1
            LET g_tot_cnt = g_psca11_d.getLength()
            CALL apsq102_detail_action_trans()
         ON ACTION BOM_Feature_Type2
            LET g_detail_idx = 1
            LET g_current_row_tot = 1
            LET g_tot_cnt = g_psca12_d.getLength()
            CALL apsq102_detail_action_trans()
         ON ACTION Feature_Group_Line
            LET g_detail_idx = 1
            LET g_current_row_tot = 1
            LET g_tot_cnt = g_psca13_d.getLength()
            CALL apsq102_detail_action_trans()
         ON ACTION BOM_Feature_Type3
            LET g_detail_idx = 1
            LET g_current_row_tot = 1
            LET g_tot_cnt = g_psca14_d.getLength()
            CALL apsq102_detail_action_trans()
         ON ACTION Item_Joint_Product
            LET g_detail_idx = 1
            LET g_current_row_tot = 1
            LET g_tot_cnt = g_psca15_d.getLength()
            CALL apsq102_detail_action_trans()
         ON ACTION Alt_Part
            LET g_detail_idx = 1
            LET g_current_row_tot = 1
            LET g_tot_cnt = g_psca16_d.getLength()
            CALL apsq102_detail_action_trans()
         ON ACTION Alt_Part_Global
            LET g_detail_idx = 1
            LET g_current_row_tot = 1
            LET g_tot_cnt = g_psca17_d.getLength()
            CALL apsq102_detail_action_trans()
         ON ACTION WS
            LET g_detail_idx = 1
            LET g_current_row_tot = 1
            LET g_tot_cnt = g_psca18_d.getLength()
            CALL apsq102_detail_action_trans()
         ON ACTION Shrinkage_Range
            LET g_detail_idx = 1
            LET g_current_row_tot = 1
            LET g_tot_cnt = g_psca19_d.getLength()
            CALL apsq102_detail_action_trans()
         ON ACTION OMP_Suggest_Mfg_Order
            LET g_detail_idx = 1
            LET g_current_row_tot = 1
            LET g_tot_cnt = g_psca20_d.getLength()
            CALL apsq102_detail_action_trans()
         #160107-00020#1 ---add (S)---
         ON ACTION omp_demend_order
            LET g_detail_idx = 1
            LET g_current_row_tot = 1
            LET g_tot_cnt = g_psca21_d.getLength()
            CALL apsq102_detail_action_trans()
            #end add-point
         ON ACTION OMP_Suggest_Purchase_Order
            LET g_detail_idx = 1
            LET g_current_row_tot = 1
            LET g_tot_cnt = g_psca22_d.getLength()
            CALL apsq102_detail_action_trans()
            #end add-point
         ON ACTION OMP_Suggest_Mfg_Order1
            LET g_detail_idx = 1
            LET g_current_row_tot = 1
            LET g_tot_cnt = g_psca23_d.getLength()
            CALL apsq102_detail_action_trans()
            #end add-point
         ON ACTION Material_Release1
            LET g_detail_idx = 1
            LET g_current_row_tot = 1
            LET g_tot_cnt = g_psca24_d.getLength()
            CALL apsq102_detail_action_trans()
            #end add-point
         ON ACTION OMP_Mopeg
            LET g_detail_idx = 1
            LET g_current_row_tot = 1
            LET g_tot_cnt = g_psca25_d.getLength()
            CALL apsq102_detail_action_trans()
            #end add-point
         ON ACTION OMP_equipment
            LET g_detail_idx = 1
            LET g_current_row_tot = 1
            LET g_tot_cnt = g_psca26_d.getLength()
            CALL apsq102_detail_action_trans()
            #end add-point
         ON ACTION Equipment_group
            LET g_detail_idx = 1
            LET g_current_row_tot = 1
            LET g_tot_cnt = g_psca27_d.getLength()
            CALL apsq102_detail_action_trans()
            #end add-point
         ON ACTION OMP_Daycaln
            LET g_detail_idx = 1
            LET g_current_row_tot = 1
            LET g_tot_cnt = g_psca28_d.getLength()
            CALL apsq102_detail_action_trans()
            #end add-point
         ON ACTION OMP_Weekcaln
            LET g_detail_idx = 1
            LET g_current_row_tot = 1
            LET g_tot_cnt = g_psca29_d.getLength()
            CALL apsq102_detail_action_trans()
            #end add-point            
         ON ACTION OMP_Work_Model
            LET g_detail_idx = 1
            LET g_current_row_tot = 1
            LET g_tot_cnt = g_psca30_d.getLength()
            CALL apsq102_detail_action_trans()
            #end add-point
         ON ACTION Item_Masters1
            LET g_detail_idx = 1
            LET g_current_row_tot = 1
            LET g_tot_cnt = g_psca31_d.getLength()
            CALL apsq102_detail_action_trans()
            #end add-point
         ON ACTION BOM_Throw_Poing
            LET g_detail_idx = 1
            LET g_current_row_tot = 1
            LET g_tot_cnt = g_psca32_d.getLength()
            CALL apsq102_detail_action_trans()
            #end add-point
         ON ACTION Item_Route
            LET g_detail_idx = 1
            LET g_current_row_tot = 1
            LET g_tot_cnt = g_psca33_d.getLength()
            CALL apsq102_detail_action_trans()
            #end add-point
         ON ACTION Route
            LET g_detail_idx = 1
            LET g_current_row_tot = 1
            LET g_tot_cnt = g_psca34_d.getLength()
            CALL apsq102_detail_action_trans()
            #end add-point
         ON ACTION WS1
            LET g_detail_idx = 1
            LET g_current_row_tot = 1
            LET g_tot_cnt = g_psca35_d.getLength()
            CALL apsq102_detail_action_trans()
            #end add-point          
         ON ACTION Route_Relation
            LET g_detail_idx = 1
            LET g_current_row_tot = 1
            LET g_tot_cnt = g_psca36_d.getLength()
            CALL apsq102_detail_action_trans()
            #end add-point            
         #160107-00020#1 ---add (E)---
            #end add-point
 
            
         ON ACTION exit
            LET g_action_choice="exit"
            LET INT_FLAG = FALSE
            LET li_exit = TRUE
            EXIT DIALOG 
      
         ON ACTION close
            LET INT_FLAG=FALSE
            LET li_exit = TRUE
            EXIT DIALOG
 
         ON ACTION accept
            INITIALIZE g_wc_filter TO NULL
            IF cl_null(g_wc) THEN
               LET g_wc = " 1=1"
            END IF
 
 
         
            IF cl_null(g_wc2) THEN
               LET g_wc2 = " 1=1"
            END IF
 
 
 
            #add-point:ON ACTION accept name="ui_dialog.accept"
 
            #end add-point
 
            LET g_detail_idx = 1
            LET g_detail_idx2 = 1
            CALL apsq102_b_fill()
 
            IF g_detail_cnt = 0 AND NOT INT_FLAG THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.extend = ""
               LET g_errparam.code   = -100
               LET g_errparam.popup  = TRUE
               CALL cl_err()
            END IF
 
 
         ON ACTION agendum   # 待辦事項
            #add-point:ON ACTION agendum name="ui_dialog.agendum"

            #end add-point
            CALL cl_user_overview()
 
         ON ACTION exporttoexcel   #匯出excel
            LET g_action_choice="exporttoexcel"
            IF cl_auth_chk_act("exporttoexcel") THEN
               CALL g_export_node.clear()
               LET g_export_node[1] = base.typeInfo.create(g_psca_d)
               LET g_export_id[1]   = "s_detail1"
               LET g_export_node[2] = base.typeInfo.create(g_psca10_d)
               LET g_export_id[2]   = "s_detail10"
 
               LET g_export_node[3] = base.typeInfo.create(g_psca11_d)
               LET g_export_id[3]   = "s_detail11"
 
               LET g_export_node[4] = base.typeInfo.create(g_psca12_d)
               LET g_export_id[4]   = "s_detail12"
 
               LET g_export_node[5] = base.typeInfo.create(g_psca13_d)
               LET g_export_id[5]   = "s_detail13"
 
               LET g_export_node[6] = base.typeInfo.create(g_psca14_d)
               LET g_export_id[6]   = "s_detail14"
 
               LET g_export_node[7] = base.typeInfo.create(g_psca15_d)
               LET g_export_id[7]   = "s_detail15"
 
               LET g_export_node[8] = base.typeInfo.create(g_psca16_d)
               LET g_export_id[8]   = "s_detail16"
 
               LET g_export_node[9] = base.typeInfo.create(g_psca17_d)
               LET g_export_id[9]   = "s_detail17"
 
               LET g_export_node[10] = base.typeInfo.create(g_psca18_d)
               LET g_export_id[10]   = "s_detail18"
 
               LET g_export_node[11] = base.typeInfo.create(g_psca19_d)
               LET g_export_id[11]   = "s_detail19"
 
               LET g_export_node[12] = base.typeInfo.create(g_psca2_d)
               LET g_export_id[12]   = "s_detail2"
 
               LET g_export_node[13] = base.typeInfo.create(g_psca20_d)
               LET g_export_id[13]   = "s_detail20"
 
               LET g_export_node[14] = base.typeInfo.create(g_psca21_d)
               LET g_export_id[14]   = "s_detail21"
 
               LET g_export_node[15] = base.typeInfo.create(g_psca22_d)
               LET g_export_id[15]   = "s_detail22"
 
               LET g_export_node[16] = base.typeInfo.create(g_psca23_d)
               LET g_export_id[16]   = "s_detail23"
 
               LET g_export_node[17] = base.typeInfo.create(g_psca24_d)
               LET g_export_id[17]   = "s_detail24"
 
               LET g_export_node[18] = base.typeInfo.create(g_psca25_d)
               LET g_export_id[18]   = "s_detail25"
 
               LET g_export_node[19] = base.typeInfo.create(g_psca26_d)
               LET g_export_id[19]   = "s_detail26"
 
               LET g_export_node[20] = base.typeInfo.create(g_psca27_d)
               LET g_export_id[20]   = "s_detail27"
 
               LET g_export_node[21] = base.typeInfo.create(g_psca28_d)
               LET g_export_id[21]   = "s_detail28"
 
               LET g_export_node[22] = base.typeInfo.create(g_psca29_d)
               LET g_export_id[22]   = "s_detail29"
 
               LET g_export_node[23] = base.typeInfo.create(g_psca3_d)
               LET g_export_id[23]   = "s_detail3"
 
               LET g_export_node[24] = base.typeInfo.create(g_psca30_d)
               LET g_export_id[24]   = "s_detail30"
 
               LET g_export_node[25] = base.typeInfo.create(g_psca31_d)
               LET g_export_id[25]   = "s_detail31"
 
               LET g_export_node[26] = base.typeInfo.create(g_psca32_d)
               LET g_export_id[26]   = "s_detail32"
 
               LET g_export_node[27] = base.typeInfo.create(g_psca33_d)
               LET g_export_id[27]   = "s_detail33"
 
               LET g_export_node[28] = base.typeInfo.create(g_psca34_d)
               LET g_export_id[28]   = "s_detail34"
 
               LET g_export_node[29] = base.typeInfo.create(g_psca35_d)
               LET g_export_id[29]   = "s_detail35"
 
               LET g_export_node[30] = base.typeInfo.create(g_psca36_d)
               LET g_export_id[30]   = "s_detail36"
 
               LET g_export_node[31] = base.typeInfo.create(g_psca4_d)
               LET g_export_id[31]   = "s_detail4"
 
               LET g_export_node[32] = base.typeInfo.create(g_psca5_d)
               LET g_export_id[32]   = "s_detail5"
 
               LET g_export_node[33] = base.typeInfo.create(g_psca6_d)
               LET g_export_id[33]   = "s_detail6"
 
               LET g_export_node[34] = base.typeInfo.create(g_psca7_d)
               LET g_export_id[34]   = "s_detail7"
 
               LET g_export_node[35] = base.typeInfo.create(g_psca8_d)
               LET g_export_id[35]   = "s_detail8"
 
               LET g_export_node[36] = base.typeInfo.create(g_psca9_d)
               LET g_export_id[36]   = "s_detail9"
 
 
               #add-point:ON ACTION exporttoexcel name="menu.exporttoexcel"

               #END add-point
               CALL cl_export_to_excel_getpage()
               CALL cl_export_to_excel()
            END IF
 
         ON ACTION datarefresh   # 重新整理
            CALL apsq102_b_fill()
 
         ON ACTION qbehidden     #qbe頁籤折疊
            IF g_qbe_hidden THEN
               CALL gfrm_curr.setElementHidden("qbe",0)
               CALL gfrm_curr.setElementImage("qbehidden","16/mainhidden.png")
               LET g_qbe_hidden = 0     #visible
            ELSE
               CALL gfrm_curr.setElementHidden("qbe",1)
               CALL gfrm_curr.setElementImage("qbehidden","16/worksheethidden.png")
               LET g_qbe_hidden = 1     #hidden
            END IF
 
         ON ACTION detail_first               #page first
            LET g_action_choice = "detail_first"
            LET g_detail_page_action = "detail_first"
            CALL apsq102_b_fill()
 
         ON ACTION detail_previous                #page previous
            LET g_action_choice = "detail_previous"
            LET g_detail_page_action = "detail_previous"
            CALL apsq102_b_fill()
 
         ON ACTION detail_next               #page next
            LET g_action_choice = "detail_next"
            LET g_detail_page_action = "detail_next"
            CALL apsq102_b_fill()
 
         ON ACTION detail_last               #page last
            LET g_action_choice = "detail_last"
            LET g_detail_page_action = "detail_last"
            CALL apsq102_b_fill()
 
         #應用 qs19 樣板自動產生(Version:3)
         #有關於sel欄位選取的action段落
         #選擇全部
         ON ACTION selall
            CALL DIALOG.setSelectionRange("s_detail1", 1, -1, 1)
            FOR li_idx = 1 TO g_psca_d.getLength()
               LET g_psca_d[li_idx].sel = "Y"
            END FOR
 
            #add-point:ui_dialog段on action selall name="ui_dialog.onaction_selall"

            #end add-point
 
         #取消全部
         ON ACTION selnone
            CALL DIALOG.setSelectionRange("s_detail1", 1, -1, 0)
            FOR li_idx = 1 TO g_psca_d.getLength()
               LET g_psca_d[li_idx].sel = "N"
            END FOR
 
            #add-point:ui_dialog段on action selnone name="ui_dialog.onaction_selnone"

            #end add-point
 
         #勾選所選資料
         ON ACTION sel
            FOR li_idx = 1 TO g_psca_d.getLength()
               IF DIALOG.isRowSelected("s_detail1", li_idx) THEN
                  LET g_psca_d[li_idx].sel = "Y"
               END IF
            END FOR
 
            #add-point:ui_dialog段on action sel name="ui_dialog.onaction_sel"

            #end add-point
 
         #取消所選資料
         ON ACTION unsel
            FOR li_idx = 1 TO g_psca_d.getLength()
               IF DIALOG.isRowSelected("s_detail1", li_idx) THEN
                  LET g_psca_d[li_idx].sel = "N"
               END IF
            END FOR
 
            #add-point:ui_dialog段on action unsel name="ui_dialog.onaction_unsel"

            #end add-point
 
 
 
 
 
         #應用 qs16 樣板自動產生(Version:3)
         ON ACTION filter
            LET g_action_choice="filter"
            CALL apsq102_filter()
            #add-point:ON ACTION filter name="menu.filter"

            #END add-point
            EXIT DIALOG
 
 
 
 
         
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION insert
            LET g_action_choice="insert"
            IF cl_auth_chk_act("insert") THEN
               
               #add-point:ON ACTION insert name="menu.insert"

               #END add-point
               
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION output
            LET g_action_choice="output"
            IF cl_auth_chk_act("output") THEN
               
               #add-point:ON ACTION output name="menu.output"

               #END add-point
               
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION query
            LET g_action_choice="query"
            IF cl_auth_chk_act("query") THEN
               
               #add-point:ON ACTION query name="menu.query"
               CALL apsq102_query()                  #160107-00020#1 add
               CALL cl_set_comp_visible("sel",FALSE) #160107-00020#1 add

               #END add-point
               
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION datainfo
            LET g_action_choice="datainfo"
            IF cl_auth_chk_act("datainfo") THEN
               
               #add-point:ON ACTION datainfo name="menu.datainfo"

               #END add-point
               
               
            END IF
 
 
 
 
      
         #主選單用ACTION
         &include "main_menu_exit_dialog.4gl"
         &include "relating_action.4gl"
         #交談指令共用ACTION
         &include "common_action.4gl"
 
         #add-point:查詢方案相關ACTION設定前 name="ui_dialog.set_qbe_action_before"

         #end add-point
 
         ON ACTION qbeclear   # 條件清除
            CLEAR FORM
            #add-point:條件清除後 name="ui_dialog.qbeclear"

            #end add-point
 
         #add-point:查詢方案相關ACTION設定後 name="ui_dialog.set_qbe_action_after"

         #end add-point
 
      END DIALOG 
   
   END WHILE
 
END FUNCTION
 
{</section>}
 
{<section id="apsq102.b_fill" >}
#+ 單身陣列填充
PRIVATE FUNCTION apsq102_b_fill()
   #add-point:b_fill段define-客製 name="b_fill.define_customerization"

   #end add-point
   DEFINE ls_wc           STRING
   DEFINE l_pid           LIKE type_t.chr50
   DEFINE ls_sql_rank     STRING
   #add-point:b_fill段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="b_fill.define"
   DEFINE l_cnt           LIKE type_t.num5
   DEFINE g_fname         STRING
   DEFINE l_file         STRING
   DEFINE lc_end_file    STRING
   DEFINE l_specification DYNAMIC ARRAY OF RECORD 
          l_name         STRING
     
   END RECORD
   DEFINE   lc_createtb          base.Channel #讀檔案用
   DEFINE   lc_createtb1         base.Channel #讀檔案用
   DEFINE   lc_alterr            base.Channel #寫log用
   DEFINE   ls_alt_result     STRING 
   DEFINE tok       base.StringTokenizer
   #160712-00012#1-mod-(S)
#   DEFINE l_idx  LIKE type_t.num5
#   DEFINE l_a   LIKE type_t.num5
#   DEFINE l_b   LIKE type_t.num5
   DEFINE l_idx LIKE type_t.num10
   DEFINE l_a   LIKE type_t.num10
   DEFINE l_b   LIKE type_t.num10
   #160712-00012#1-mod-(E)
   DEFINE l_c   LIKE type_t.num10
   DEFINE i     LIKE type_t.num5
   DEFINE l_str STRING
   DEFINE l_str1 STRING
   #160107-00020#1 ---add (S)---
   DEFINE l_sql STRING
   DEFINE l_sql1 STRING
   DEFINE l_sql2 STRING
   DEFINE l_sql3 STRING
   DEFINE l_sql4 STRING
   DEFINE l_sql5 STRING
   DEFINE l_sql6 STRING
   DEFINE l_sql7 STRING
   DEFINE l_sql8 STRING
   DEFINE l_sql9 STRING
   DEFINE l_sql10 STRING
   DEFINE l_sql11 STRING
   DEFINE l_sql12 STRING
   DEFINE l_sql13 STRING
   DEFINE l_sql14 STRING
   DEFINE l_sql15 STRING
   DEFINE l_sql16 STRING
   DEFINE l_sql17 STRING
   DEFINE l_sql18 STRING
   DEFINE l_sql19 STRING
   DEFINE l_sql20 STRING
   DEFINE l_sql21 STRING
   DEFINE l_sql22 STRING
   DEFINE l_sql23 STRING
   DEFINE l_sql24 STRING
   DEFINE l_sql25 STRING
   DEFINE l_sql26 STRING
   DEFINE l_sql27 STRING
   DEFINE l_sql28 STRING
   DEFINE l_sql29 STRING
   DEFINE l_sql30 STRING
   DEFINE l_sql31 STRING
   DEFINE l_sql32 STRING
   DEFINE l_sql33 STRING
   DEFINE l_sql34 STRING
   DEFINE l_sql35 STRING
   DEFINE l_sql36 STRING
   DEFINE l_psca002 LIKE psca_t.psca002
   DEFINE l_file_1         STRING
   DEFINE lc_end_file_1    STRING
   DEFINE   lc_createtb_1          base.Channel #讀檔案用
   DEFINE   lc_createtb1_1         base.Channel #讀檔案用
   DEFINE   ls_alt_result_1     STRING 
   DEFINE l_d     LIKE type_t.num10
   #160712-00012#1-mod-(S)
#   DEFINE l_a_1   LIKE type_t.num5
#   DEFINE l_b_1   LIKE type_t.num5
   DEFINE l_a_1   LIKE type_t.num10
   DEFINE l_b_1   LIKE type_t.num10
   #160712-00012#1-mod-(E)
   DEFINE l_c_1   LIKE type_t.num10
   DEFINE l_d_1   LIKE type_t.num10
   #160107-00020#1 ---add (E)---
   #end add-point
 
   #add-point:b_fill段sql_before name="b_fill.sql_before"

   #end add-point
 
 
   IF cl_null(g_wc_filter) THEN
      LET g_wc_filter = " 1=1"
   END IF
   IF cl_null(g_wc) THEN
      LET g_wc = " 1=1"
   END IF
  #160107-00020#1 ---add (S)---
   IF cl_null(g_wc1) THEN
      LET g_wc1 = " 1=1"
   END IF
   IF cl_null(g_wc2) THEN
      LET g_wc2 = " 1=1"
   END IF
   IF cl_null(g_wc3) THEN
      LET g_wc3 = " 1=1"
   END IF
   IF cl_null(g_wc4) THEN
      LET g_wc4 = " 1=1"
   END IF
   IF cl_null(g_wc5) THEN
      LET g_wc5 = " 1=1"
   END IF
   IF cl_null(g_wc6) THEN
      LET g_wc6 = " 1=1"
   END IF
   IF cl_null(g_wc7) THEN
      LET g_wc7 = " 1=1"
   END IF
   IF cl_null(g_wc8) THEN
      LET g_wc8 = " 1=1"
   END IF
   IF cl_null(g_wc9) THEN
      LET g_wc9 = " 1=1"
   END IF
   IF cl_null(g_wc10) THEN
      LET g_wc10 = " 1=1"
   END IF
   IF cl_null(g_wc11) THEN
      LET g_wc11 = " 1=1"
   END IF
   IF cl_null(g_wc12) THEN
      LET g_wc12 = " 1=1"
   END IF
   IF cl_null(g_wc13) THEN
      LET g_wc13 = " 1=1"
   END IF
   IF cl_null(g_wc14) THEN
      LET g_wc14 = " 1=1"
   END IF
   IF cl_null(g_wc15) THEN
      LET g_wc15 = " 1=1"
   END IF
   IF cl_null(g_wc16) THEN
      LET g_wc16 = " 1=1"
   END IF
   IF cl_null(g_wc17) THEN
      LET g_wc17 = " 1=1"
   END IF
   IF cl_null(g_wc18) THEN
      LET g_wc18 = " 1=1"
   END IF
   IF cl_null(g_wc19) THEN
      LET g_wc19 = " 1=1"
   END IF
   IF cl_null(g_wc20) THEN
      LET g_wc20 = " 1=1"
   END IF
   IF cl_null(g_wc21) THEN
      LET g_wc21 = " 1=1"
   END IF
   IF cl_null(g_wc22) THEN
      LET g_wc22 = " 1=1"
   END IF
   IF cl_null(g_wc23) THEN
      LET g_wc23 = " 1=1"
   END IF
   IF cl_null(g_wc24) THEN
      LET g_wc24 = " 1=1"
   END IF
   IF cl_null(g_wc25) THEN
      LET g_wc25 = " 1=1"
   END IF
   IF cl_null(g_wc26) THEN
      LET g_wc26 = " 1=1"
   END IF
   IF cl_null(g_wc27) THEN
      LET g_wc27 = " 1=1"
   END IF
   IF cl_null(g_wc28) THEN
      LET g_wc28 = " 1=1"
   END IF
   IF cl_null(g_wc29) THEN
      LET g_wc29 = " 1=1"
   END IF
   IF cl_null(g_wc30) THEN
      LET g_wc30 = " 1=1"
   END IF
   IF cl_null(g_wc31) THEN
      LET g_wc31 = " 1=1"
   END IF
   IF cl_null(g_wc32) THEN
      LET g_wc32 = " 1=1"
   END IF
   IF cl_null(g_wc32) THEN
      LET g_wc32 = " 1=1"
   END IF
   IF cl_null(g_wc33) THEN
      LET g_wc33 = " 1=1"
   END IF
   IF cl_null(g_wc34) THEN
      LET g_wc34 = " 1=1"
   END IF
   IF cl_null(g_wc35) THEN
      LET g_wc35 = " 1=1"
   END IF
   IF cl_null(g_wc36) THEN
      LET g_wc36 = " 1=1"
   END IF
   #160107-00020#1 ---add (S)---
 
   LET ls_wc = g_wc, " AND ", g_wc2, " AND ", g_wc_filter
 
   CALL g_psca_d.clear()
   CALL g_psca10_d.clear()
 
   CALL g_psca11_d.clear()
 
   CALL g_psca12_d.clear()
 
   CALL g_psca13_d.clear()
 
   CALL g_psca14_d.clear()
 
   CALL g_psca15_d.clear()
 
   CALL g_psca16_d.clear()
 
   CALL g_psca17_d.clear()
 
   CALL g_psca18_d.clear()
 
   CALL g_psca19_d.clear()
 
   CALL g_psca2_d.clear()
 
   CALL g_psca20_d.clear()
 
   CALL g_psca21_d.clear()
 
   CALL g_psca22_d.clear()
 
   CALL g_psca23_d.clear()
 
   CALL g_psca24_d.clear()
 
   CALL g_psca25_d.clear()
 
   CALL g_psca26_d.clear()
 
   CALL g_psca27_d.clear()
 
   CALL g_psca28_d.clear()
 
   CALL g_psca29_d.clear()
 
   CALL g_psca3_d.clear()
 
   CALL g_psca30_d.clear()
 
   CALL g_psca31_d.clear()
 
   CALL g_psca32_d.clear()
 
   CALL g_psca33_d.clear()
 
   CALL g_psca34_d.clear()
 
   CALL g_psca35_d.clear()
 
   CALL g_psca36_d.clear()
 
   CALL g_psca4_d.clear()
 
   CALL g_psca5_d.clear()
 
   CALL g_psca6_d.clear()
 
   CALL g_psca7_d.clear()
 
   CALL g_psca8_d.clear()
 
   CALL g_psca9_d.clear()
 
 
   #add-point:陣列清空 name="b_fill.array_clear"

   #end add-point
 
   LET g_cnt = l_ac
   IF g_cnt = 0 THEN
      LET g_cnt = 1
   END IF
   LET l_ac = 1
 
#  # b_fill段sql組成及FOREACH撰寫
#  #應用 qs04 樣板自動產生(Version:9)
#  #+ b_fill段資料取得(包含sql組成及FOREACH段撰寫)
#  LET ls_sql_rank = "SELECT  UNIQUE '','','','','','','','','','','','','','','','',psca001,'','','', 
#      '',psca001,'','','','','','',psca001,'','','','','','','',psca001,'','','',psca001,'','','','', 
#      '',psca001,'','','','',psca001,'','','','','','','','','','','',psca001,'','','','','','','', 
#      '','','',psca001,'',psca001,'','','','','','','','','',psca001,'','','','','','','','','','', 
#      '','','','','','','','','',psca001,'','','','','','','','','','','','','','','','','','','','', 
#      '',psca001,'','','','','','','','','','','','','','','',psca001,'','','','','','','','','','', 
#      '','','','','','','','','','','','','','','',psca001,'','','','','','','','','','','','','','', 
#      '','','','','','',psca001,'','','','','','','','','','','','','','',psca001,'','','','','','', 
#      '','','','','','',psca001,'','','','','','','',psca001,'','','','','',psca001,'','','','','', 
#      psca001,'','','','','','','','',psca001,'','','','','','','','','','','','','','','','','',psca001, 
#      '','','','',psca001,'','','','','','','','','','','','','','','','','','','','','','','','','', 
#      '','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','', 
#      '','','',psca001,'','','','','',psca001,'','','','',psca001,'','','','','','','','','','','', 
#      '',psca001,'',psca001,'','','',psca001,'','','','','','','','','','','','','','','','',psca001, 
#      '','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','', 
#      '','','','','','','','','','','','','','','','','','','','','','','','','','','','',psca001,'', 
#      '','','','','','','','',psca001,'','','','','','','','','','','','','','','','','','','','',psca001, 
#      '','','','','','',psca001,'',''  ,DENSE_RANK() OVER( ORDER BY psca_t.psca001) AS RANK FROM psca_t", 
#
#
#
#                    "",
#                    " WHERE pscaent= ? AND pscasite= ? AND 1=1 AND ", ls_wc
#  LET ls_sql_rank = ls_sql_rank, cl_sql_add_filter("psca_t"),
#                    " ORDER BY psca_t.psca001"
#
#  #add-point:b_fill段rank_sql_after name="b_fill.rank_sql_after"

#  #end add-point
#
#  LET g_sql = "SELECT COUNT(1) FROM (",ls_sql_rank,")"
#
#  PREPARE b_fill_cnt_pre FROM g_sql  #總筆數
#  EXECUTE b_fill_cnt_pre USING g_enterprise, g_site INTO g_tot_cnt
#  FREE b_fill_cnt_pre
#
#  #add-point:b_fill段rank_sql_after_count name="b_fill.rank_sql_after_count"

#  #end add-point
#
#  CASE g_detail_page_action
#     WHEN "detail_first"
#         LET g_pagestart = 1
#
#     WHEN "detail_previous"
#         LET g_pagestart = g_pagestart - g_num_in_page
#         IF g_pagestart < 1 THEN
#             LET g_pagestart = 1
#         END IF
#
#     WHEN "detail_next"
#        LET g_pagestart = g_pagestart + g_num_in_page
#        IF g_pagestart > g_tot_cnt THEN
#           LET g_pagestart = g_tot_cnt - (g_tot_cnt mod g_num_in_page) + 1
#           WHILE g_pagestart > g_tot_cnt
#              LET g_pagestart = g_pagestart - g_num_in_page
#           END WHILE
#        END IF
#
#     WHEN "detail_last"
#        LET g_pagestart = g_tot_cnt - (g_tot_cnt mod g_num_in_page) + 1
#        WHILE g_pagestart > g_tot_cnt
#           LET g_pagestart = g_pagestart - g_num_in_page
#        END WHILE
#
#     OTHERWISE
#        LET g_pagestart = 1
#
#  END CASE
#
#  LET g_sql = "SELECT '','','','','','','','','','','','','','','','',psca001,'','','','',psca001,'', 
#      '','','','','',psca001,'','','','','','','',psca001,'','','',psca001,'','','','','',psca001,'', 
#      '','','',psca001,'','','','','','','','','','','',psca001,'','','','','','','','','','',psca001, 
#      '',psca001,'','','','','','','','','',psca001,'','','','','','','','','','','','','','','','', 
#      '','','',psca001,'','','','','','','','','','','','','','','','','','','','','',psca001,'','', 
#      '','','','','','','','','','','','','',psca001,'','','','','','','','','','','','','','','','', 
#      '','','','','','','','','',psca001,'','','','','','','','','','','','','','','','','','','','', 
#      psca001,'','','','','','','','','','','','','','',psca001,'','','','','','','','','','','','', 
#      psca001,'','','','','','','',psca001,'','','','','',psca001,'','','','','',psca001,'','','','', 
#      '','','','',psca001,'','','','','','','','','','','','','','','','','',psca001,'','','','',psca001, 
#      '','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','', 
#      '','','','','','','','','','','','','','','','','','','','','','','','','','','','',psca001,'', 
#      '','','','',psca001,'','','','',psca001,'','','','','','','','','','','','',psca001,'',psca001, 
#      '','','',psca001,'','','','','','','','','','','','','','','','',psca001,'','','','','','','', 
#      '','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','', 
#      '','','','','','','','','','','','','','','','','','','','','',psca001,'','','','','','','','', 
#      '',psca001,'','','','','','','','','','','','','','','','','','','','',psca001,'','','','','', 
#      '',psca001,'',''",
#              " FROM (",ls_sql_rank,")",
#             " WHERE RANK >= ",g_pagestart,
#               " AND RANK < ",g_pagestart + g_num_in_page
#
#  #add-point:b_fill段sql_after name="b_fill.sql_after"

#  #end add-point
#
#  LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
#  PREPARE apsq102_pb FROM g_sql
#  DECLARE b_fill_curs CURSOR FOR apsq102_pb
#
#  OPEN b_fill_curs USING g_enterprise, g_site
#
#  FOREACH b_fill_curs INTO g_psca_d[l_ac].sel,g_psca_d[l_ac].l_xmdadocno,g_psca_d[l_ac].l_xmdd001,g_psca_d[l_ac].l_xmdd006, 
#      g_psca_d[l_ac].l_xmdd011,g_psca_d[l_ac].l_xmda004,g_psca_d[l_ac].l_type,g_psca_d[l_ac].l_xmdd014, 
#      g_psca_d[l_ac].l_xmdd004,g_psca_d[l_ac].l_delay,g_psca_d[l_ac].l_xmdd002,g_psca_d[l_ac].l_scheduled, 
#      g_psca_d[l_ac].l_consume,g_psca_d[l_ac].l_priority,g_psca_d[l_ac].l_transfer,g_psca_d[l_ac].l_pseb007, 
#      g_psca10_d[l_ac].psca001,g_psca10_d[l_ac].l_inab001,g_psca10_d[l_ac].l_inab002,g_psca10_d[l_ac].l_inab005, 
#      g_psca10_d[l_ac].l_consigned,g_psca11_d[l_ac].psca001,g_psca11_d[l_ac].l_bmca001,g_psca11_d[l_ac].l_bmca009, 
#      g_psca11_d[l_ac].l_bmca005,g_psca11_d[l_ac].l_bmca003,g_psca11_d[l_ac].l_bmcb011,g_psca11_d[l_ac].l_bmcb012, 
#      g_psca12_d[l_ac].psca001,g_psca12_d[l_ac].l_bmc001,g_psca12_d[l_ac].l_bmcc009,g_psca12_d[l_ac].l_bmcd010, 
#      g_psca12_d[l_ac].l_bmcc005,g_psca12_d[l_ac].l_bmcc003,g_psca12_d[l_ac].l_bmcd011,g_psca12_d[l_ac].l_bmcc010, 
#      g_psca13_d[l_ac].psca001,g_psca13_d[l_ac].l_imec001,g_psca13_d[l_ac].l_imec002,g_psca13_d[l_ac].l_imec003, 
#      g_psca14_d[l_ac].psca001,g_psca14_d[l_ac].l_bmce001,g_psca14_d[l_ac].l_bmce005,g_psca14_d[l_ac].l_bmce003, 
#      g_psca14_d[l_ac].l_bmce009,g_psca14_d[l_ac].l_bmce010,g_psca15_d[l_ac].psca001,g_psca15_d[l_ac].l_bmab001, 
#      g_psca15_d[l_ac].l_bmab003,g_psca15_d[l_ac].l_type_1,g_psca15_d[l_ac].l_bmab004,g_psca16_d[l_ac].psca001, 
#      g_psca16_d[l_ac].l_bmea001,g_psca16_d[l_ac].l_bmea003,g_psca16_d[l_ac].l_bmea008,g_psca16_d[l_ac].l_bmea015, 
#      g_psca16_d[l_ac].l_bmea011,g_psca16_d[l_ac].l_bmea009,g_psca16_d[l_ac].l_bmea010,g_psca16_d[l_ac].l_bmea012, 
#      g_psca16_d[l_ac].l_bmea007,g_psca16_d[l_ac].l_bmea017,g_psca16_d[l_ac].l_bmea016,g_psca17_d[l_ac].psca001, 
#      g_psca17_d[l_ac].l_bmea001_1,g_psca17_d[l_ac].l_bmea008_1,g_psca17_d[l_ac].l_bmea015_1,g_psca17_d[l_ac].l_bmea011_1, 
#      g_psca17_d[l_ac].l_bmea009_1,g_psca17_d[l_ac].l_bmea010_1,g_psca17_d[l_ac].l_bmea012_1,g_psca17_d[l_ac].l_bmea007_1, 
#      g_psca17_d[l_ac].l_bmea017_1,g_psca17_d[l_ac].l_bmea016_1,g_psca18_d[l_ac].psca001,g_psca18_d[l_ac].l_ecaa001, 
#      g_psca19_d[l_ac].psca001,g_psca19_d[l_ac].l_bmbb001,g_psca19_d[l_ac].l_bmbb003,g_psca19_d[l_ac].l_seq, 
#      g_psca19_d[l_ac].l_seq1,g_psca19_d[l_ac].l_bmbb009,g_psca19_d[l_ac].l_bmbb010,g_psca19_d[l_ac].l_shrinkage_1, 
#      g_psca19_d[l_ac].l_bmbb011,g_psca19_d[l_ac].l_bmbb012,g_psca2_d[l_ac].psca001,g_psca2_d[l_ac].l_pmdodocno, 
#      g_psca2_d[l_ac].l_pmdo001,g_psca2_d[l_ac].l_pmdb006,g_psca2_d[l_ac].l_new,g_psca2_d[l_ac].l_pmdl004, 
#      g_psca2_d[l_ac].l_pmdo004,g_psca2_d[l_ac].l_pmdo019,g_psca2_d[l_ac].l_state,g_psca2_d[l_ac].l_pmdo014, 
#      g_psca2_d[l_ac].l_pmdo002,g_psca2_d[l_ac].l_pmdo016,g_psca2_d[l_ac].l_pmdo015,g_psca2_d[l_ac].l_pmdldocdt, 
#      g_psca2_d[l_ac].l_pmdo012,g_psca2_d[l_ac].l_pmdo013,g_psca2_d[l_ac].l_pmdo017,g_psca2_d[l_ac].l_pmdo015_1, 
#      g_psca2_d[l_ac].l_transfer_1,g_psca2_d[l_ac].l_hardpegging,g_psca20_d[l_ac].psca001,g_psca20_d[l_ac].l_psoa003, 
#      g_psca20_d[l_ac].l_psoa004,g_psca20_d[l_ac].l_psoa005,g_psca20_d[l_ac].l_psoa006,g_psca20_d[l_ac].l_psoa007, 
#      g_psca20_d[l_ac].l_psoa008,g_psca20_d[l_ac].l_psoa009,g_psca20_d[l_ac].l_psoa010,g_psca20_d[l_ac].l_psoa011, 
#      g_psca20_d[l_ac].l_psoa012,g_psca20_d[l_ac].l_psoa013,g_psca20_d[l_ac].l_psoa014,g_psca20_d[l_ac].l_psoa015, 
#      g_psca20_d[l_ac].l_psoa016,g_psca20_d[l_ac].l_psoa017,g_psca20_d[l_ac].l_psoa018,g_psca20_d[l_ac].l_psoa019, 
#      g_psca20_d[l_ac].l_psoa020,g_psca20_d[l_ac].l_psoa021,g_psca20_d[l_ac].l_psoa022,g_psca20_d[l_ac].l_psoa023, 
#      g_psca21_d[l_ac].psca001,g_psca21_d[l_ac].l_psod003,g_psca21_d[l_ac].l_psod004,g_psca21_d[l_ac].l_psod005, 
#      g_psca21_d[l_ac].l_psod006,g_psca21_d[l_ac].l_psod007,g_psca21_d[l_ac].l_psod008,g_psca21_d[l_ac].l_psod009, 
#      g_psca21_d[l_ac].l_psod010,g_psca21_d[l_ac].l_psod011,g_psca21_d[l_ac].l_psod012,g_psca21_d[l_ac].l_psod013, 
#      g_psca21_d[l_ac].l_psod014,g_psca21_d[l_ac].l_psod015,g_psca21_d[l_ac].l_psod016,g_psca21_d[l_ac].l_psod017, 
#      g_psca22_d[l_ac].psca001,g_psca22_d[l_ac].l_psoc003,g_psca22_d[l_ac].l_psoc004,g_psca22_d[l_ac].l_psoc005, 
#      g_psca22_d[l_ac].l_psoc006,g_psca22_d[l_ac].l_psoc007,g_psca22_d[l_ac].l_psoc008_1,g_psca22_d[l_ac].l_psoc009, 
#      g_psca22_d[l_ac].l_psoc010,g_psca22_d[l_ac].l_psoc011,g_psca22_d[l_ac].l_psoc012,g_psca22_d[l_ac].l_psoc013, 
#      g_psca22_d[l_ac].l_psoc014,g_psca22_d[l_ac].l_psoc015,g_psca22_d[l_ac].l_psoc016,g_psca22_d[l_ac].l_psoc017, 
#      g_psca22_d[l_ac].l_psoc018,g_psca22_d[l_ac].l_psoc019,g_psca22_d[l_ac].l_psoc020,g_psca22_d[l_ac].l_psoc021, 
#      g_psca22_d[l_ac].l_psoc022,g_psca22_d[l_ac].l_psoc023,g_psca22_d[l_ac].l_psoc025,g_psca22_d[l_ac].l_psoc022_1, 
#      g_psca22_d[l_ac].l_psoc022_2,g_psca22_d[l_ac].l_psoc022_3,g_psca23_d[l_ac].psca001,g_psca23_d[l_ac].l_psoa003_1, 
#      g_psca23_d[l_ac].l_psoa004_1,g_psca23_d[l_ac].l_psoa005_1,g_psca23_d[l_ac].l_psoa006_1,g_psca23_d[l_ac].l_psoa007_1, 
#      g_psca23_d[l_ac].l_psoa008_1,g_psca23_d[l_ac].l_psoa009_1,g_psca23_d[l_ac].l_psoa010_1,g_psca23_d[l_ac].l_psoa011_1, 
#      g_psca23_d[l_ac].l_psoa012_1,g_psca23_d[l_ac].l_psoa013_1,g_psca23_d[l_ac].l_psoa014_1,g_psca23_d[l_ac].l_psoa015_1, 
#      g_psca23_d[l_ac].l_psoa016_1,g_psca23_d[l_ac].l_psoa017_1,g_psca23_d[l_ac].l_psoa018_1,g_psca23_d[l_ac].l_psoa019_1, 
#      g_psca23_d[l_ac].l_psoa020_1,g_psca23_d[l_ac].l_psoa021_1,g_psca23_d[l_ac].l_psoa023_1,g_psca24_d[l_ac].psca001, 
#      g_psca24_d[l_ac].l_sfbadocno_1,g_psca24_d[l_ac].l_sfba006_1,g_psca24_d[l_ac].l_sfbaseq_2,g_psca24_d[l_ac].l_sfbaseq_1_1, 
#      g_psca24_d[l_ac].l_release_2,g_psca24_d[l_ac].l_sfba019_1,g_psca24_d[l_ac].l_demand_1,g_psca24_d[l_ac].l_sfba020_1, 
#      g_psca24_d[l_ac].l_sfba028_1,g_psca24_d[l_ac].l_sfba003_1,g_psca24_d[l_ac].l_sfba009_1,g_psca24_d[l_ac].l_sfba007_1, 
#      g_psca24_d[l_ac].l_sfaa003_1,g_psca24_d[l_ac].l_sfba021_1,g_psca25_d[l_ac].psca001,g_psca25_d[l_ac].l_psob003, 
#      g_psca25_d[l_ac].l_psob004,g_psca25_d[l_ac].l_psob005,g_psca25_d[l_ac].l_psob006,g_psca25_d[l_ac].l_psob007, 
#      g_psca25_d[l_ac].l_psob008,g_psca25_d[l_ac].l_psob009,g_psca25_d[l_ac].l_psob010,g_psca25_d[l_ac].l_psob011, 
#      g_psca25_d[l_ac].l_psob012,g_psca25_d[l_ac].l_psob013,g_psca25_d[l_ac].l_psob016,g_psca26_d[l_ac].psca001, 
#      g_psca26_d[l_ac].l_equip_type,g_psca26_d[l_ac].l_equip_id,g_psca26_d[l_ac].l_ws_id,g_psca26_d[l_ac].l_efficency, 
#      g_psca26_d[l_ac].l_capacity_type,g_psca26_d[l_ac].l_day_calendar_id,g_psca26_d[l_ac].l_week_calendar_id, 
#      g_psca27_d[l_ac].psca001,g_psca27_d[l_ac].l_equip_group_id,g_psca27_d[l_ac].l_equip_type_1,g_psca27_d[l_ac].l_is_outsourcing, 
#      g_psca27_d[l_ac].l_equip_id_1,g_psca27_d[l_ac].l_priority_1,g_psca28_d[l_ac].psca001,g_psca28_d[l_ac].l_mrbh001_1, 
#      g_psca28_d[l_ac].l_mrbh002,g_psca28_d[l_ac].l_mrbh003,g_psca28_d[l_ac].l_mrbh004,g_psca28_d[l_ac].l_mrbh005, 
#      g_psca29_d[l_ac].psca001,g_psca29_d[l_ac].l_week_calendar_id_1,g_psca29_d[l_ac].l_mom_wm_id,g_psca29_d[l_ac].l_tue_wm_id, 
#      g_psca29_d[l_ac].l_wed_wm_id,g_psca29_d[l_ac].l_thu_wm_id,g_psca29_d[l_ac].l_fri_wm_id,g_psca29_d[l_ac].l_sat_wm_id, 
#      g_psca29_d[l_ac].l_sun_wm_id,g_psca3_d[l_ac].psca001,g_psca3_d[l_ac].l_sfaadocno,g_psca3_d[l_ac].l_sfaa012, 
#      g_psca3_d[l_ac].l_sfaa020,g_psca3_d[l_ac].l_sfaa019,g_psca3_d[l_ac].l_sfaa010,g_psca3_d[l_ac].l_sfaadocno1, 
#      g_psca3_d[l_ac].l_sfaa013,g_psca3_d[l_ac].l_sfaa056,g_psca3_d[l_ac].l_new_1,g_psca3_d[l_ac].l_produced, 
#      g_psca3_d[l_ac].l_sfaa022,g_psca3_d[l_ac].l_sfaa021,g_psca3_d[l_ac].l_feature,g_psca3_d[l_ac].l_firm, 
#      g_psca3_d[l_ac].l_exploration,g_psca3_d[l_ac].l_material,g_psca3_d[l_ac].l_hardpegging_1,g_psca30_d[l_ac].psca001, 
#      g_psca30_d[l_ac].l_wm_id,g_psca30_d[l_ac].l_start_time,g_psca30_d[l_ac].l_end_time,g_psca30_d[l_ac].l_type_2, 
#      g_psca31_d[l_ac].psca001,g_psca31_d[l_ac].l_imaa001_1,g_psca31_d[l_ac].l_imaf026_1,g_psca31_d[l_ac].l_sizing_1, 
#      g_psca31_d[l_ac].l_used_2,g_psca31_d[l_ac].l_integer_1,g_psca31_d[l_ac].l_imaf013_1,g_psca31_d[l_ac].l_imaa006_1, 
#      g_psca31_d[l_ac].l_imae022_1,g_psca31_d[l_ac].l_imae018_1,g_psca31_d[l_ac].l_imae017_1,g_psca31_d[l_ac].l_imae080_1, 
#      g_psca31_d[l_ac].l_imaa004_1,g_psca31_d[l_ac].l_imae064_2,g_psca31_d[l_ac].l_mfg_2,g_psca31_d[l_ac].l_order_1, 
#      g_psca31_d[l_ac].l_feature_1_1,g_psca31_d[l_ac].l_imaf171_2,g_psca31_d[l_ac].l_imaf171_3,g_psca31_d[l_ac].l_consume_1_1, 
#      g_psca31_d[l_ac].l_release_1_1,g_psca31_d[l_ac].l_lastqty_1,g_psca31_d[l_ac].l_combine_1,g_psca31_d[l_ac].l_inspect_1, 
#      g_psca31_d[l_ac].l_consign_1,g_psca31_d[l_ac].l_imaf143_1,g_psca31_d[l_ac].l_purchase_1,g_psca31_d[l_ac].l_imae016_1, 
#      g_psca31_d[l_ac].l_mfg_1_1,g_psca31_d[l_ac].l_imaa105_1,g_psca31_d[l_ac].l_sales_1,g_psca31_d[l_ac].l_imae064_1_1, 
#      g_psca31_d[l_ac].l_alt_2,g_psca31_d[l_ac].l_break_1,g_psca31_d[l_ac].l_create_2,g_psca31_d[l_ac].l_supratio_1, 
#      g_psca31_d[l_ac].l_imaf153_1,g_psca31_d[l_ac].l_backward_1,g_psca31_d[l_ac].l_batch_1,g_psca31_d[l_ac].l_setup_1, 
#      g_psca31_d[l_ac].l_imae052_1,g_psca31_d[l_ac].l_imae077_1,g_psca31_d[l_ac].l_base_1,g_psca31_d[l_ac].l_max_batch_size_1, 
#      g_psca31_d[l_ac].l_imae032_1,g_psca31_d[l_ac].l_outsourcing_1,g_psca31_d[l_ac].l_imae072_1,g_psca31_d[l_ac].l_imae073_1, 
#      g_psca31_d[l_ac].l_var_1,g_psca31_d[l_ac].l_auto_1,g_psca31_d[l_ac].l_consolidate_1,g_psca31_d[l_ac].l_phase_1, 
#      g_psca31_d[l_ac].l_spare_1,g_psca31_d[l_ac].l_due_1,g_psca31_d[l_ac].l_imae015_1,g_psca31_d[l_ac].l_imaa005_1, 
#      g_psca31_d[l_ac].l_imae078_1,g_psca31_d[l_ac].l_imae079_1,g_psca31_d[l_ac].l_imae083_1,g_psca31_d[l_ac].l_imae082_1, 
#      g_psca32_d[l_ac].psca001,g_psca32_d[l_ac].l_bmba001_1,g_psca32_d[l_ac].l_bmba003_1,g_psca32_d[l_ac].l_ecba001, 
#      g_psca32_d[l_ac].l_ecbb003,g_psca32_d[l_ac].l_bmba007_1,g_psca33_d[l_ac].psca001,g_psca33_d[l_ac].l_part_id, 
#      g_psca33_d[l_ac].l_imae033,g_psca33_d[l_ac].l_sequ_num,g_psca33_d[l_ac].l_is_alt,g_psca34_d[l_ac].psca001, 
#      g_psca34_d[l_ac].l_ecbb001,g_psca34_d[l_ac].l_ecbb002,g_psca34_d[l_ac].l_ecbb003_1,g_psca34_d[l_ac].l_ecbb004, 
#      g_psca34_d[l_ac].l_equip_type_2,g_psca34_d[l_ac].l_ecbb037,g_psca34_d[l_ac].l_is_batch,g_psca34_d[l_ac].l_ecbb026, 
#      g_psca34_d[l_ac].l_ecbb027,g_psca34_d[l_ac].l_imae077_2,g_psca34_d[l_ac].l_imae077_3,g_psca34_d[l_ac].l_ecbb012, 
#      g_psca35_d[l_ac].psca001,g_psca35_d[l_ac].l_ecaa001_1,g_psca36_d[l_ac].psca001,g_psca36_d[l_ac].l_ecbe001, 
#      g_psca36_d[l_ac].l_ecbe005,g_psca36_d[l_ac].l_ecbe003,g_psca4_d[l_ac].psca001,g_psca4_d[l_ac].l_sfbadocno, 
#      g_psca4_d[l_ac].l_sfba006,g_psca4_d[l_ac].l_sfbaseq,g_psca4_d[l_ac].l_sfbaseq_1,g_psca4_d[l_ac].l_release, 
#      g_psca4_d[l_ac].l_sfba019,g_psca4_d[l_ac].l_demand,g_psca4_d[l_ac].l_sfba020,g_psca4_d[l_ac].l_sfba028, 
#      g_psca4_d[l_ac].l_sfba003,g_psca4_d[l_ac].l_sfba009,g_psca4_d[l_ac].l_sfba007,g_psca4_d[l_ac].l_sfaa003, 
#      g_psca4_d[l_ac].l_sfba021,g_psca4_d[l_ac].l_sfba001,g_psca4_d[l_ac].l_sfba005,g_psca5_d[l_ac].psca001, 
#      g_psca5_d[l_ac].l_imaa001,g_psca5_d[l_ac].l_imaf026,g_psca5_d[l_ac].l_sizing,g_psca5_d[l_ac].l_used, 
#      g_psca5_d[l_ac].l_integer,g_psca5_d[l_ac].l_imaf013,g_psca5_d[l_ac].l_imaa006,g_psca5_d[l_ac].l_imae022, 
#      g_psca5_d[l_ac].l_imae018,g_psca5_d[l_ac].l_imae017,g_psca5_d[l_ac].l_imae080,g_psca5_d[l_ac].l_imaa004, 
#      g_psca5_d[l_ac].l_imae064,g_psca5_d[l_ac].l_mfg,g_psca5_d[l_ac].l_order,g_psca5_d[l_ac].l_feature_1, 
#      g_psca5_d[l_ac].l_imaf171,g_psca5_d[l_ac].l_imaf171_1,g_psca5_d[l_ac].l_consume_1,g_psca5_d[l_ac].l_release_1, 
#      g_psca5_d[l_ac].l_lastqty,g_psca5_d[l_ac].l_combine,g_psca5_d[l_ac].l_inspect,g_psca5_d[l_ac].l_consign, 
#      g_psca5_d[l_ac].l_imaf143,g_psca5_d[l_ac].l_purchase,g_psca5_d[l_ac].l_imae016,g_psca5_d[l_ac].l_mfg_1, 
#      g_psca5_d[l_ac].l_imaa105,g_psca5_d[l_ac].l_sales,g_psca5_d[l_ac].l_imae064_1,g_psca5_d[l_ac].l_alt, 
#      g_psca5_d[l_ac].l_break,g_psca5_d[l_ac].l_create,g_psca5_d[l_ac].l_supratio,g_psca5_d[l_ac].l_imaf153, 
#      g_psca5_d[l_ac].l_backward,g_psca5_d[l_ac].l_batch,g_psca5_d[l_ac].l_setup,g_psca5_d[l_ac].l_imae052, 
#      g_psca5_d[l_ac].l_imae077,g_psca5_d[l_ac].l_base,g_psca5_d[l_ac].l_max_batch_size,g_psca5_d[l_ac].l_imae032, 
#      g_psca5_d[l_ac].l_outsourcing,g_psca5_d[l_ac].l_imae072,g_psca5_d[l_ac].l_imae073,g_psca5_d[l_ac].l_var, 
#      g_psca5_d[l_ac].l_auto,g_psca5_d[l_ac].l_consolidate,g_psca5_d[l_ac].l_phase,g_psca5_d[l_ac].l_spare, 
#      g_psca5_d[l_ac].l_due,g_psca5_d[l_ac].l_imae015,g_psca5_d[l_ac].l_imaa005,g_psca5_d[l_ac].l_imae078, 
#      g_psca5_d[l_ac].l_imae079,g_psca5_d[l_ac].l_imae083,g_psca5_d[l_ac].l_imae082,g_psca6_d[l_ac].psca001, 
#      g_psca6_d[l_ac].l_imeb001,g_psca6_d[l_ac].l_imeb002,g_psca6_d[l_ac].l_imeb004,g_psca6_d[l_ac].l_imeb006, 
#      g_psca6_d[l_ac].l_imeb005,g_psca6_d[l_ac].l_imeb010,g_psca6_d[l_ac].l_imeb011,g_psca6_d[l_ac].l_imeb008, 
#      g_psca6_d[l_ac].l_imeb009,g_psca7_d[l_ac].psca001,g_psca7_d[l_ac].l_bmba001,g_psca7_d[l_ac].l_bmba012, 
#      g_psca7_d[l_ac].l_bmba003,g_psca7_d[l_ac].l_bmba009,g_psca7_d[l_ac].l_bmba011,g_psca7_d[l_ac].l_shrinkage, 
#      g_psca7_d[l_ac].l_bmba013,g_psca7_d[l_ac].l_bmba031,g_psca7_d[l_ac].l_alt_1,g_psca7_d[l_ac].l_create_1, 
#      g_psca7_d[l_ac].l_ratio,g_psca7_d[l_ac].l_bmba007,g_psca7_d[l_ac].l_bmba021,g_psca7_d[l_ac].l_used_1, 
#      g_psca7_d[l_ac].l_substitute,g_psca7_d[l_ac].l_fixed,g_psca7_d[l_ac].l_bmba023,g_psca7_d[l_ac].l_bmba004, 
#      g_psca7_d[l_ac].l_bmba008,g_psca7_d[l_ac].l_quantity,g_psca8_d[l_ac].psca001,g_psca8_d[l_ac].l_inag001, 
#      g_psca8_d[l_ac].l_inag004,g_psca8_d[l_ac].l_inag005,g_psca8_d[l_ac].l_inag009,g_psca8_d[l_ac].l_inag002, 
#      g_psca8_d[l_ac].l_hard,g_psca9_d[l_ac].psca001,g_psca9_d[l_ac].l_inaa001,g_psca9_d[l_ac].l_inaa006 
#
#     IF SQLCA.sqlcode THEN
#        INITIALIZE g_errparam TO NULL 
#        LET g_errparam.extend = "FOREACH:" 
#        LET g_errparam.code   = SQLCA.sqlcode 
#        LET g_errparam.popup  = TRUE 
#        CALL cl_err()
#
#        EXIT FOREACH
#     END IF
#
#     
#
#     #add-point:b_fill段資料填充 name="b_fill.fill"

#     #end add-point
#
#     CALL apsq102_detail_show("'1'")
#
#     CALL apsq102_psca_t_mask()
#
#     IF l_ac > g_max_rec THEN
#        IF g_error_show = 1 THEN
#           INITIALIZE g_errparam TO NULL 
#           LET g_errparam.extend =  "" 
#           LET g_errparam.code   =  9035 
#           LET g_errparam.popup  = TRUE 
#           CALL cl_err()
#
#        END IF
#        EXIT FOREACH
#     END IF
#     LET l_ac = l_ac + 1
#
#  END FOREACH
#
#
#
#
#
#  #應用 qs05 樣板自動產生(Version:3)
#  #+ b_fill段其他table資料取得(包含sql組成及資料填充)
#
#
#
#
#
#
#  #add-point:b_fill段資料填充(其他單身) name="b_fill.others.fill"

#  #end add-point
#
#  CALL g_psca_d.deleteElement(g_psca_d.getLength())
#  CALL g_psca10_d.deleteElement(g_psca10_d.getLength())
#
#  CALL g_psca11_d.deleteElement(g_psca11_d.getLength())
#
#  CALL g_psca12_d.deleteElement(g_psca12_d.getLength())
#
#  CALL g_psca13_d.deleteElement(g_psca13_d.getLength())
#
#  CALL g_psca14_d.deleteElement(g_psca14_d.getLength())
#
#  CALL g_psca15_d.deleteElement(g_psca15_d.getLength())
#
#  CALL g_psca16_d.deleteElement(g_psca16_d.getLength())
#
#  CALL g_psca17_d.deleteElement(g_psca17_d.getLength())
#
#  CALL g_psca18_d.deleteElement(g_psca18_d.getLength())
#
#  CALL g_psca19_d.deleteElement(g_psca19_d.getLength())
#
#  CALL g_psca2_d.deleteElement(g_psca2_d.getLength())
#
#  CALL g_psca20_d.deleteElement(g_psca20_d.getLength())
#
#  CALL g_psca21_d.deleteElement(g_psca21_d.getLength())
#
#  CALL g_psca22_d.deleteElement(g_psca22_d.getLength())
#
#  CALL g_psca23_d.deleteElement(g_psca23_d.getLength())
#
#  CALL g_psca24_d.deleteElement(g_psca24_d.getLength())
#
#  CALL g_psca25_d.deleteElement(g_psca25_d.getLength())
#
#  CALL g_psca26_d.deleteElement(g_psca26_d.getLength())
#
#  CALL g_psca27_d.deleteElement(g_psca27_d.getLength())
#
#  CALL g_psca28_d.deleteElement(g_psca28_d.getLength())
#
#  CALL g_psca29_d.deleteElement(g_psca29_d.getLength())
#
#  CALL g_psca3_d.deleteElement(g_psca3_d.getLength())
#
#  CALL g_psca30_d.deleteElement(g_psca30_d.getLength())
#
#  CALL g_psca31_d.deleteElement(g_psca31_d.getLength())
#
#  CALL g_psca32_d.deleteElement(g_psca32_d.getLength())
#
#  CALL g_psca33_d.deleteElement(g_psca33_d.getLength())
#
#  CALL g_psca34_d.deleteElement(g_psca34_d.getLength())
#
#  CALL g_psca35_d.deleteElement(g_psca35_d.getLength())
#
#  CALL g_psca36_d.deleteElement(g_psca36_d.getLength())
#
#  CALL g_psca4_d.deleteElement(g_psca4_d.getLength())
#
#  CALL g_psca5_d.deleteElement(g_psca5_d.getLength())
#
#  CALL g_psca6_d.deleteElement(g_psca6_d.getLength())
#
#  CALL g_psca7_d.deleteElement(g_psca7_d.getLength())
#
#  CALL g_psca8_d.deleteElement(g_psca8_d.getLength())
#
#  CALL g_psca9_d.deleteElement(g_psca9_d.getLength())
 
 
   #add-point:陣列長度調整 name="b_fill.array_deleteElement"
   #151228 charles4m ---add (S)---   
   #指定路徑   
   LET lc_end_file = ''
   LET l_file  = g_enterprise,'_',g_site,'_',g_master.psca001,'_',g_master.psea002,'/','MP','/','import','/','spec','/','Specification.txt'
   #LET l_file  = g_enterprise,'_',g_site,'_',g_master.psca001,'_',g_master.psea002,'/','MP','/','import','/','spec','/','12345.txt'
   LET l_file  = l_file.trim()
   LET lc_end_file = os.Path.join(FGL_GETENV("APSLOG"),l_file)
   
   # 將一行一行讀出來執行
	LET lc_createtb = base.Channel.create()
	CALL lc_createtb.openFile(lc_end_file,"r") #lc_end_file txt 路徑(含檔名)
	
	WHILE lc_createtb.read(ls_alt_result) #ls_alt_result 儲存每行讀出的字串
    
      LET tok = base.StringTokenizer.create(ls_alt_result,',') #將文件的內容(一行)已,做區隔
     
      LET l_a = 0
  
      CALL l_specification.clear() 
   
      WHILE tok.hasMoreTokens()
         LET l_a = l_a + 1
         LET l_specification[l_a].l_name = tok.nextToken()
        #LET l_specification[l_a].l_name = "Demand_Order.txt"
        #LET g_imaa_r[l_idx].imaa001=tok.nextToken()
        #LET l_specification[l_idx] =
        #LET l_specification[l_i].l_name = tok.nextToken() 
      
       END WHILE     
   
      LET lc_end_file = ''
      LET l_file  = g_enterprise,'_',g_site,'_',g_master.psca001,'_',g_master.psea002,'/','MP','/','import','/'
      LET l_file  = l_file,l_specification[1].l_name #要用變數
      LET l_file  = l_file.trim()
      
      LET lc_end_file = os.Path.join(FGL_GETENV("APSLOG"),l_file)
      
      # 將一行一行讀出來執行
    	LET lc_createtb1 = base.Channel.create()
      CALL lc_createtb1.openFile(lc_end_file,"r") #lc_end_file txt 路徑(含檔名)
      LET l_c = 1 #要塞到畫面的筆數
      WHILE lc_createtb1.read(ls_alt_result) #ls_alt_result 儲存每行讀出的字串 #進到實際要抓取資料的TXT檔案
    
           LET l_str = ASCII 11   #^K的符號
           LET l_str1 = ' ',l_str #用來將空字串加上空白
           LET ls_alt_result = cl_str_replace(ls_alt_result, l_str, l_str1) #取代，後續遇到空白欄位才能順利擷取
           LET tok = base.StringTokenizer.create(ls_alt_result,l_str) #將文件的內容(一行)
         
           
           LET l_b = 3  #因文件第3個值開始才是欄位
          
           WHILE tok.hasMoreTokens()  #抓取每一行的分隔
              
              LET l_str = ' '     #先將資料清空，以防舊值殘留
              LET l_str = tok.nextToken()
              IF NOT cl_null(l_str) THEN LET l_str = l_str.trim() END IF
              CASE WHEN l_specification[1].l_name = "Demand_Order.txt" 
                       CALL apsq102_Demand_Order(l_str,l_c,l_specification[l_b].l_name)
                       
                   WHEN l_specification[1].l_name = "Suggest_Purchase_Order.txt"
                       CALL apsq102_Suggest_Purchase_Order(l_str,l_c,l_specification[l_b].l_name)
                       
                   WHEN l_specification[1].l_name = "Suggest_Mfg_Order.txt"
                       CALL apsq102_Suggest_Mfg_Order(l_str,l_c,l_specification[l_b].l_name)
                       
                   WHEN l_specification[1].l_name = "Material_Release.txt"
                       CALL apsq102_Material_Release(l_str,l_c,l_specification[l_b].l_name)
                       
                   WHEN l_specification[1].l_name = "Item_Master.txt"
                       CALL apsq102_Item_Master(l_str,l_c,l_specification[l_b].l_name)
                       
                   WHEN l_specification[1].l_name = "Feature_Group.txt"
                       CALL apsq102_Feature_Group(l_str,l_c,l_specification[l_b].l_name)
                       
                   WHEN l_specification[1].l_name = "Bill_of_Material.txt"
                       CALL apsq102_Bill_of_Material(l_str,l_c,l_specification[l_b].l_name)
                       
                   WHEN l_specification[1].l_name = "Unassigned_Inventory.txt"
                       CALL apsq102_Unassigned_Inventory(l_str,l_c,l_specification[l_b].l_name)
                       
                   WHEN l_specification[1].l_name = "Warehouse.txt"
                       CALL apsq102_Warehouse(l_str,l_c,l_specification[l_b].l_name)
                       
                   WHEN l_specification[1].l_name = "Stock_Location.txt"
                       CALL apsq102_Stock_Location(l_str,l_c,l_specification[l_b].l_name)
                       
                   WHEN l_specification[1].l_name = "BOM_Feature_Type1.txt"
                       CALL apsq102_BOM_Feature_Type1(l_str,l_c,l_specification[l_b].l_name)
                       
                   WHEN l_specification[1].l_name = "BOM_Feature_Type2.txt"
                       CALL apsq102_BOM_Feature_Type2(l_str,l_c,l_specification[l_b].l_name)
                       
                   WHEN l_specification[1].l_name = "Feature_Group_Line.txt"
                       CALL apsq102_Feature_Group_Line(l_str,l_c,l_specification[l_b].l_name)
                       
                   WHEN l_specification[1].l_name = "BOM_Feature_Type3.txt"
                       CALL apsq102_BOM_Feature_Type3(l_str,l_c,l_specification[l_b].l_name)
                       
                   WHEN l_specification[1].l_name = "Item_Joint_Product.txt"
                       CALL apsq102_Item_Joint_Product(l_str,l_c,l_specification[l_b].l_name)
                       
                   WHEN l_specification[1].l_name = "Alt_Part.txt"
                       CALL apsq102_Alt_Part(l_str,l_c,l_specification[l_b].l_name)
                       
                   WHEN l_specification[1].l_name = "Alt_Part_Global.txt"
                       CALL apsq102_Alt_Part_Global(l_str,l_c,l_specification[l_b].l_name)
                       
                   WHEN l_specification[1].l_name = "WS.txt"
                       CALL apsq102_WS(l_str,l_c,l_specification[l_b].l_name)
                       
                   WHEN l_specification[1].l_name = "Shrinkage_Range.txt"
                       CALL apsq102_Shrinkage_Range(l_str,l_c,l_specification[l_b].l_name)
                       
                   WHEN l_specification[1].l_name = "OMP_Suggest_Mfg_Order.txt"
                       CALL apsq102_OMP_Suggest_Mfg_Order(l_str,l_c,l_specification[l_b].l_name)
                       
              END CASE    
                  
              LET l_b = l_b + 1       
           END WHILE 

           LET l_c = l_c + 1
      END WHILE
     #160107-00020#1 ---add (S)--- 
      CASE WHEN l_specification[1].l_name = "Demand_Order.txt" 
                IF g_wc1 <> " 1=1" THEN
                   LET l_ac = 1
                   FOR l_d= 1 to l_c
                            #161109-00085#12-mod-s
#                            INSERT INTO dem_ord_tmp01 VALUES (g_psca_d[l_d].*)            #160727-00019#15 Mod   demand_order_tmp -->dem_ord_tmp01     #161109-00085#12   mark
                            INSERT INTO dem_ord_tmp01 (psca001,xmdadocno,xmdd001,xmdd006,xmdd011,xmda004,type,xmdd014,xmdd004,delay,xmdd002,scheduled,consume,priority,transfer,pseb007) 
                                               VALUES (g_psca_d[l_d].sel,g_psca_d[l_d].l_xmdadocno,g_psca_d[l_d].l_xmdd001,g_psca_d[l_d].l_xmdd006,
                                                       g_psca_d[l_d].l_xmdd011,g_psca_d[l_d].l_xmda004,g_psca_d[l_d].l_type,g_psca_d[l_d].l_xmdd014,g_psca_d[l_d].l_xmdd004,
                                                       g_psca_d[l_d].l_delay,g_psca_d[l_d].l_xmdd002,g_psca_d[l_d].l_scheduled,g_psca_d[l_d].l_consume,g_psca_d[l_d].l_priority,
                                                       g_psca_d[l_d].l_transfer,g_psca_d[l_d].l_pseb007)
                            #161109-00085#12-mod-e
                            #IF SQLCA.sqlcode OR SQLCA.sqlerrd[3] = 0 THEN
                            #   INITIALIZE g_errparam TO NULL
                            #   LET g_errparam.extend = 'ins demand_order',g_psca_d[l_d].l_xmdadocno
                            #   LET g_errparam.code   = SQLCA.sqlcode
                            #   LET g_errparam.popup  = TRUE
                            #   CALL cl_err()
                            #   EXIT WHILE
                            #END IF
                   END FOR
                   CALL g_psca_d.clear()
                   #161109-00085#12-mod-s
                   #LET l_sql1 = "SELECT * FROM dem_ord_tmp01 ",                 #160727-00019#15 Mod   demand_order_tmp -->dem_ord_tmp01
                   LET l_sql1 = "SELECT psca001,xmdadocno,xmdd001,xmdd006,xmdd011,
                                        xmda004,type,xmdd014,xmdd004,delay,
                                        xmdd002,scheduled,consume,priority,transfer,pseb007 
                                   FROM dem_ord_tmp01 ",
                   #161109-00085#12-mod-e
                                 " WHERE ",g_wc1 
                   PREPARE apsq102_tmp_wc1_pre FROM l_sql1
                   DECLARE apsq102_tmp_wc1_curs CURSOR FOR apsq102_tmp_wc1_pre
                   #161109-00085#12-mod-s
                   #FOREACH apsq102_tmp_wc1_curs INTO g_psca_d[l_ac].*
                   FOREACH apsq102_tmp_wc1_curs 
                   INTO g_psca_d[l_ac].sel,g_psca_d[l_ac].l_xmdadocno,g_psca_d[l_ac].l_xmdd001,g_psca_d[l_ac].l_xmdd006,
                        g_psca_d[l_ac].l_xmdd011,g_psca_d[l_ac].l_xmda004,g_psca_d[l_ac].l_type,g_psca_d[l_ac].l_xmdd014,g_psca_d[l_ac].l_xmdd004,
                        g_psca_d[l_ac].l_delay,g_psca_d[l_ac].l_xmdd002,g_psca_d[l_ac].l_scheduled,g_psca_d[l_ac].l_consume,g_psca_d[l_ac].l_priority,
                        g_psca_d[l_ac].l_transfer,g_psca_d[l_ac].l_pseb007
                   #161109-00085#12-mod-e
                      LET l_ac = l_ac + 1
                      IF SQLCA.sqlcode THEN
                         INITIALIZE g_errparam TO NULL 
                         LET g_errparam.extend = "FOREACH:" 
                         LET g_errparam.code   = SQLCA.sqlcode 
                         LET g_errparam.popup  = TRUE 
                         CALL cl_err()
                         
                         EXIT FOREACH
                      END IF
                   END FOREACH
                   CALL g_psca_d.deleteElement(g_psca_d.getLength())
                   LET g_tot_cnt = g_psca_d.getLength()
                END IF  
                  
           WHEN l_specification[1].l_name = "Suggest_Purchase_Order.txt"
                IF g_wc2 <> " 1=1" THEN
                   LET l_ac = 1
                   FOR l_d= 1 to l_c
                            #161109-00085#12-mod-s
#                            INSERT INTO s_p_o_tmp VALUES (g_psca2_d[l_d].*)   #161109-00085#12   mark
                            INSERT INTO s_p_o_tmp (psca001,pmdodocno,pmdo001,pmdo006,new,pmdl004,pmdo004,pmdo019,state,pmdo014,
                                                   pmdo002,pmdo016,pmdo015,pmdldocdt,pmdo012,pmdo013,pmdo017,pmdo015_1,transfer_1,hardpegging) 
                                           VALUES (g_psca2_d[l_d].psca001,g_psca2_d[l_d].l_pmdodocno,g_psca2_d[l_d].l_pmdo001,
                                                   g_psca2_d[l_d].l_pmdb006,g_psca2_d[l_d].l_new,g_psca2_d[l_d].l_pmdl004,g_psca2_d[l_d].l_pmdo004,
                                                   g_psca2_d[l_d].l_pmdo019,g_psca2_d[l_d].l_state,g_psca2_d[l_d].l_pmdo014,g_psca2_d[l_d].l_pmdo002,
                                                   g_psca2_d[l_d].l_pmdo016,g_psca2_d[l_d].l_pmdo015,g_psca2_d[l_d].l_pmdldocdt,g_psca2_d[l_d].l_pmdo012,
                                                   g_psca2_d[l_d].l_pmdo013,g_psca2_d[l_d].l_pmdo017,g_psca2_d[l_d].l_pmdo015_1,g_psca2_d[l_d].l_transfer_1,
                                                   g_psca2_d[l_d].l_hardpegging)
                            #161109-00085#12-mod-e
                            #IF SQLCA.sqlcode OR SQLCA.sqlerrd[3] = 0 THEN
                            #   INITIALIZE g_errparam TO NULL
                            #   LET g_errparam.extend = 'ins suggest_purchase_order',g_psca2_d[l_d].l_pmdodocno
                            #   LET g_errparam.code   = SQLCA.sqlcode
                            #   LET g_errparam.popup  = TRUE
                            #   CALL cl_err()
                            #   EXIT WHILE
                            #END IF
                   END FOR
                   CALL g_psca_d.clear()
                   #161109-00085#12-mod-s
                   #LET l_sql2 = "SELECT * FROM s_p_o_tmp ",
                   LET l_sql2 = "SELECT psca001,pmdodocno,pmdo001,pmdo006,new,pmdl004,pmdo004,pmdo019,state,pmdo014,
                                        pmdo002,pmdo016,pmdo015,pmdldocdt,pmdo012,pmdo013,pmdo017,pmdo015_1,transfer_1,hardpegging
                                   FROM s_p_o_tmp ",
                   #161109-00085#12-mod-e
                                 " WHERE ",g_wc2 
                   PREPARE apsq102_tmp_wc2_pre FROM l_sql2
                   DECLARE apsq102_tmp_wc2_curs CURSOR FOR apsq102_tmp_wc2_pre
                   #161109-00085#12-mod-s
                   #FOREACH apsq102_tmp_wc2_curs INTO g_psca2_d[l_ac].*
                   FOREACH apsq102_tmp_wc2_curs 
                   INTO g_psca2_d[l_ac].psca001,g_psca2_d[l_ac].l_pmdodocno,g_psca2_d[l_ac].l_pmdo001,
                        g_psca2_d[l_ac].l_pmdb006,g_psca2_d[l_ac].l_new,g_psca2_d[l_ac].l_pmdl004,g_psca2_d[l_ac].l_pmdo004,
                        g_psca2_d[l_ac].l_pmdo019,g_psca2_d[l_ac].l_state,g_psca2_d[l_ac].l_pmdo014,g_psca2_d[l_ac].l_pmdo002,
                        g_psca2_d[l_ac].l_pmdo016,g_psca2_d[l_ac].l_pmdo015,g_psca2_d[l_ac].l_pmdldocdt,g_psca2_d[l_ac].l_pmdo012,
                        g_psca2_d[l_ac].l_pmdo013,g_psca2_d[l_ac].l_pmdo017,g_psca2_d[l_ac].l_pmdo015_1,g_psca2_d[l_ac].l_transfer_1,
                        g_psca2_d[l_ac].l_hardpegging
                   #161109-00085#12-mod-e
                      LET l_ac = l_ac + 1
                      IF SQLCA.sqlcode THEN
                         INITIALIZE g_errparam TO NULL 
                         LET g_errparam.extend = "FOREACH:" 
                         LET g_errparam.code   = SQLCA.sqlcode 
                         LET g_errparam.popup  = TRUE 
                         CALL cl_err()
                         
                         EXIT FOREACH
                      END IF
                   END FOREACH
                   CALL g_psca2_d.deleteElement(g_psca2_d.getLength())
                   LET g_tot_cnt = g_psca2_d.getLength()
                END IF  
               
           WHEN l_specification[1].l_name = "Suggest_Mfg_Order.txt"
                IF g_wc3 <> " 1=1" THEN
                   LET l_ac = 1
                   FOR l_d= 1 to l_c
                            #161109-00085#12-mod-s
#                           INSERT INTO s_m_o_tmp VALUES (g_psca2_d[l_d].*)   #161109-00085#12   mark
                            INSERT INTO s_m_o_tmp (psca001,sfaadocno,sfaa012,sfaa020,sfaa019,sfaa010,sfaadocno1,sfaa011,sfaa056,new_1,produced,
                                                   sfaa016,sfaa015,sfaa022,sfaa021,feature,firm,exploration,materiral,hardpegging_1) 
                                           VALUES (g_psca2_d[l_d].psca001,g_psca2_d[l_d].l_pmdodocno,g_psca2_d[l_d].l_pmdo001,
                                                   g_psca2_d[l_d].l_pmdb006,g_psca2_d[l_d].l_new,g_psca2_d[l_d].l_pmdl004,g_psca2_d[l_d].l_pmdo004,
                                                   g_psca2_d[l_d].l_pmdo019,g_psca2_d[l_d].l_state,g_psca2_d[l_d].l_pmdo014,g_psca2_d[l_d].l_pmdo002,
                                                   g_psca2_d[l_d].l_pmdo016,g_psca2_d[l_d].l_pmdo015,g_psca2_d[l_d].l_pmdldocdt,g_psca2_d[l_d].l_pmdo012,
                                                   g_psca2_d[l_d].l_pmdo013,g_psca2_d[l_d].l_pmdo017,g_psca2_d[l_d].l_pmdo015_1,g_psca2_d[l_d].l_transfer_1,
                                                   g_psca2_d[l_d].l_hardpegging)
                            #161109-00085#12-mod-e
                            #IF SQLCA.sqlcode OR SQLCA.sqlerrd[3] = 0 THEN
                            #   INITIALIZE g_errparam TO NULL
                            #   LET g_errparam.extend = 'ins suggest_mfg_order',g_psca3_d[l_d].l_sfaadocno
                            #   LET g_errparam.code   = SQLCA.sqlcode
                            #   LET g_errparam.popup  = TRUE
                            #   CALL cl_err()
                            #   EXIT WHILE
                            #END IF
                   END FOR
                   CALL g_psca_d.clear()
                   #161109-00085#12-mod-s
                   #LET l_sql3 = "SELECT * FROM s_m_o_tmp ",
                   LET l_sql3 = "SELECT psca001,sfaadocno,sfaa012,sfaa020,sfaa019,sfaa010,sfaadocno1,sfaa011,sfaa056,new_1,produced,
                                        sfaa016,sfaa015,sfaa022,sfaa021,feature,firm,exploration,materiral,hardpegging_1
                                   FROM s_m_o_tmp ",
                   #161109-00085#12-mod-e
                                 " WHERE ",g_wc3 
                   PREPARE apsq102_tmp_wc3_pre FROM l_sql3
                   DECLARE apsq102_tmp_wc3_curs CURSOR FOR apsq102_tmp_wc3_pre
                   #161109-00085#12-mod-s
                   #FOREACH apsq102_tmp_wc3_curs INTO g_psca3_d[l_ac].*
                   FOREACH apsq102_tmp_wc3_curs 
                   INTO g_psca2_d[l_ac].psca001,g_psca2_d[l_ac].l_pmdodocno,g_psca2_d[l_ac].l_pmdo001,
                        g_psca2_d[l_ac].l_pmdb006,g_psca2_d[l_ac].l_new,g_psca2_d[l_ac].l_pmdl004,g_psca2_d[l_ac].l_pmdo004,
                        g_psca2_d[l_ac].l_pmdo019,g_psca2_d[l_ac].l_state,g_psca2_d[l_ac].l_pmdo014,g_psca2_d[l_ac].l_pmdo002,
                        g_psca2_d[l_ac].l_pmdo016,g_psca2_d[l_ac].l_pmdo015,g_psca2_d[l_ac].l_pmdldocdt,g_psca2_d[l_ac].l_pmdo012,
                        g_psca2_d[l_ac].l_pmdo013,g_psca2_d[l_ac].l_pmdo017,g_psca2_d[l_ac].l_pmdo015_1,g_psca2_d[l_ac].l_transfer_1,
                        g_psca2_d[l_ac].l_hardpegging
                   #161109-00085#12-mod-e
                      LET l_ac = l_ac + 1
                      IF SQLCA.sqlcode THEN
                         INITIALIZE g_errparam TO NULL 
                         LET g_errparam.extend = "FOREACH:" 
                         LET g_errparam.code   = SQLCA.sqlcode 
                         LET g_errparam.popup  = TRUE 
                         CALL cl_err()
                         
                         EXIT FOREACH
                      END IF
                   END FOREACH
                   CALL g_psca3_d.deleteElement(g_psca3_d.getLength())
                   LET g_tot_cnt = g_psca3_d.getLength()
                END IF
               
           WHEN l_specification[1].l_name = "Material_Release.txt"
                IF g_wc4 <> " 1=1" THEN
                   LET l_ac = 1
                   FOR l_d= 1 to l_c
                            #161109-00085#12-mod-s
#                            INSERT INTO m_r_tmp VALUES (g_psca4_d[l_d].*)   #161109-00085#12   mark
                            INSERT INTO m_r_tmp (psca001,sfbadocno,sfba006,sfbaseq,sfbaseq_1,release,sfba019,demand,sfba020,sfba028,
                                                 sfba003,sfba009,sfba007,sfaa003,sfba021,sfba001,sfba005  )
                                         VALUES (g_psca4_d[l_d].psca001,g_psca4_d[l_d].l_sfbadocno,g_psca4_d[l_d].l_sfba006,g_psca4_d[l_d].l_sfbaseq,
                                                 g_psca4_d[l_d].l_sfbaseq_1,g_psca4_d[l_d].l_release,g_psca4_d[l_d].l_sfba019,g_psca4_d[l_d].l_demand,
                                                 g_psca4_d[l_d].l_sfba020,g_psca4_d[l_d].l_sfba028,g_psca4_d[l_d].l_sfba003,g_psca4_d[l_d].l_sfba009,
                                                 g_psca4_d[l_d].l_sfba007,g_psca4_d[l_d].l_sfaa003,g_psca4_d[l_d].l_sfba021,g_psca4_d[l_d].l_sfba001,
                                                 g_psca4_d[l_d].l_sfba005 )
                            #161109-00085#12-mod-e
                            #IF SQLCA.sqlcode OR SQLCA.sqlerrd[3] = 0 THEN
                            #   INITIALIZE g_errparam TO NULL
                            #   LET g_errparam.extend = 'ins material_release',g_psca4_d[l_d].l_sfbadocno
                            #   LET g_errparam.code   = SQLCA.sqlcode
                            #   LET g_errparam.popup  = TRUE
                            #   CALL cl_err()
                            #   EXIT WHILE
                            #END IF
                   END FOR
                   CALL g_psca4_d.clear()
                   #161109-00085#12-mod-s
                   #LET l_sql4 = "SELECT * FROM m_r_tmp ",
                   LET l_sql4 = "SELECT psca001,sfbadocno,sfba006,sfbaseq,sfbaseq_1,release,sfba019,demand,sfba020,sfba028,
                                        sfba003,sfba009,sfba007,sfaa003,sfba021,sfba001,sfba005 
                                   FROM m_r_tmp ",
                   #161109-00085#12-mod-e
                                 " WHERE ",g_wc4 
                   PREPARE apsq102_tmp_wc4_pre FROM l_sql4
                   DECLARE apsq102_tmp_wc4_curs CURSOR FOR apsq102_tmp_wc4_pre
                   #161109-00085#12-mod-s
                   #FOREACH apsq102_tmp_wc4_curs INTO g_psca4_d[l_ac].*
                   FOREACH apsq102_tmp_wc4_curs 
                   INTO g_psca4_d[l_ac].psca001,g_psca4_d[l_ac].l_sfbadocno,g_psca4_d[l_ac].l_sfba006,g_psca4_d[l_ac].l_sfbaseq,
                        g_psca4_d[l_ac].l_sfbaseq_1,g_psca4_d[l_ac].l_release,g_psca4_d[l_ac].l_sfba019,g_psca4_d[l_ac].l_demand,
                        g_psca4_d[l_ac].l_sfba020,g_psca4_d[l_ac].l_sfba028,g_psca4_d[l_ac].l_sfba003,g_psca4_d[l_ac].l_sfba009,
                        g_psca4_d[l_ac].l_sfba007,g_psca4_d[l_ac].l_sfaa003,g_psca4_d[l_ac].l_sfba021,g_psca4_d[l_ac].l_sfba001,
                        g_psca4_d[l_ac].l_sfba005
                   #161109-00085#12-mod-e
                      LET l_ac = l_ac + 1
                      IF SQLCA.sqlcode THEN
                         INITIALIZE g_errparam TO NULL 
                         LET g_errparam.extend = "FOREACH:" 
                         LET g_errparam.code   = SQLCA.sqlcode 
                         LET g_errparam.popup  = TRUE 
                         CALL cl_err()
                         
                         EXIT FOREACH
                      END IF
                   END FOREACH
                   CALL g_psca4_d.deleteElement(g_psca4_d.getLength())
                   LET g_tot_cnt = g_psca4_d.getLength()
                END IF
               
           WHEN l_specification[1].l_name = "Item_Master.txt"
                IF g_wc5 <> " 1=1" THEN
                   LET l_ac = 1
                   FOR l_d= 1 to l_c
                            #161109-00085#12-mod-s
#                            INSERT INTO item_master_tmp VALUES (g_psca5_d[l_d].*)   #161109-00085#12   mark
                            INSERT INTO item_master_tmp (psca001,imaa001,imaf026,sizing,used,integer_1,imaf013,imaa006,imae022,imae018,
                                                         imae017,imae080,imaa004,imae064,mfg,order_1,feature_1,imaf171,imaf171_1,consume_1,release_1,     
                                                         lastqty,combine,inspect,consign,imaf143,purchase,imae016,mfg_1,imaa105,sales,imae064_1,alt,break,create_1,
                                                         supratio,imaf153,backward,batch,setup,imae052,imae077,base,max_batch_size,imae032,
                                                         outsourcing,imae072,imae073,var,auto_1,consolidate,phase,spare,due,imae015,imaa005,
                                                         imae078,imae079,imae083,imae082) 
                                                 VALUES (g_psca5_d[l_ac].psca001,g_psca5_d[l_ac].l_imaa001,g_psca5_d[l_ac].l_imaf026,g_psca5_d[l_ac].l_sizing,
                                                         g_psca5_d[l_ac].l_used,g_psca5_d[l_ac].l_integer,g_psca5_d[l_ac].l_imaf013,g_psca5_d[l_ac].l_imaa006,
                                                         g_psca5_d[l_ac].l_imae022,g_psca5_d[l_ac].l_imae018,g_psca5_d[l_ac].l_imae017,g_psca5_d[l_ac].l_imae080,
                                                         g_psca5_d[l_ac].l_imaa004,g_psca5_d[l_ac].l_imae064,g_psca5_d[l_ac].l_mfg,g_psca5_d[l_ac].l_order,
                                                         g_psca5_d[l_ac].l_feature_1,g_psca5_d[l_ac].l_imaf171,g_psca5_d[l_ac].l_imaf171_1,g_psca5_d[l_ac].l_consume_1,
                                                         g_psca5_d[l_ac].l_release_1,g_psca5_d[l_ac].l_lastqty,g_psca5_d[l_ac].l_combine,g_psca5_d[l_ac].l_inspect,
                                                         g_psca5_d[l_ac].l_consign,g_psca5_d[l_ac].l_imaf143,g_psca5_d[l_ac].l_purchase,g_psca5_d[l_ac].l_imae016,
                                                         g_psca5_d[l_ac].l_mfg_1,g_psca5_d[l_ac].l_imaa105,g_psca5_d[l_ac].l_sales,g_psca5_d[l_ac].l_imae064_1,
                                                         g_psca5_d[l_ac].l_alt,g_psca5_d[l_ac].l_break,g_psca5_d[l_ac].l_create,g_psca5_d[l_ac].l_supratio,
                                                         g_psca5_d[l_ac].l_imaf153,g_psca5_d[l_ac].l_backward,g_psca5_d[l_ac].l_batch,g_psca5_d[l_ac].l_setup,
                                                         g_psca5_d[l_ac].l_imae052,g_psca5_d[l_ac].l_imae077,g_psca5_d[l_ac].l_base,g_psca5_d[l_ac].l_max_batch_size,
                                                         g_psca5_d[l_ac].l_imae032,g_psca5_d[l_ac].l_outsourcing,g_psca5_d[l_ac].l_imae072,g_psca5_d[l_ac].l_imae073,
                                                         g_psca5_d[l_ac].l_var,g_psca5_d[l_ac].l_auto,g_psca5_d[l_ac].l_consolidate,g_psca5_d[l_ac].l_phase,
                                                         g_psca5_d[l_ac].l_spare,g_psca5_d[l_ac].l_due,g_psca5_d[l_ac].l_imae015,g_psca5_d[l_ac].l_imaa005,
                                                         g_psca5_d[l_ac].l_imae078,g_psca5_d[l_ac].l_imae079,g_psca5_d[l_ac].l_imae083,g_psca5_d[l_ac].l_imae082)
                            #161109-00085#12-mod-e
                            #IF SQLCA.sqlcode OR SQLCA.sqlerrd[3] = 0 THEN
                            #   INITIALIZE g_errparam TO NULL
                            #   LET g_errparam.extend = 'ins item_master',g_psca5_d[l_d].l_imaa001
                            #   LET g_errparam.code   = SQLCA.sqlcode
                            #   LET g_errparam.popup  = TRUE
                            #   CALL cl_err()
                            #   EXIT WHILE
                            #END IF
                   END FOR
                   CALL g_psca5_d.clear()
                   #161109-00085#12-mod-s
                   #LET l_sql5 = "SELECT * FROM item_master_tmp ",
                   LET l_sql5 = "SELECT psca001,imaa001,imaf026,sizing,used,integer_1,imaf013,imaa006,imae022,imae018,
                                        imae017,imae080,imaa004,imae064,mfg,order_1,feature_1,imaf171,imaf171_1,consume_1,release_1,     
                                        lastqty,combine,inspect,consign,imaf143,purchase,imae016,mfg_1,imaa105,sales,imae064_1,alt,break,create_1,
                                        supratio,imaf153,backward,batch,setup,imae052,imae077,base,max_batch_size,imae032,
                                        outsourcing,imae072,imae073,var,auto_1,consolidate,phase,spare,due,imae015,imaa005,
                                        imae078,imae079,imae083,imae082 
                                   FROM item_master_tmp ",
                   #161109-00085#12-mod-e
                                 " WHERE ",g_wc5 
                   PREPARE apsq102_tmp_wc5_pre FROM l_sql5
                   DECLARE apsq102_tmp_wc5_curs CURSOR FOR apsq102_tmp_wc5_pre
                   #161109-00085#12-mod-s
                   #FOREACH apsq102_tmp_wc5_curs INTO g_psca5_d[l_ac].*
                   FOREACH apsq102_tmp_wc5_curs 
                   INTO g_psca5_d[l_ac].psca001,g_psca5_d[l_ac].l_imaa001,g_psca5_d[l_ac].l_imaf026,g_psca5_d[l_ac].l_sizing,
                        g_psca5_d[l_ac].l_used,g_psca5_d[l_ac].l_integer,g_psca5_d[l_ac].l_imaf013,g_psca5_d[l_ac].l_imaa006,
                        g_psca5_d[l_ac].l_imae022,g_psca5_d[l_ac].l_imae018,g_psca5_d[l_ac].l_imae017,g_psca5_d[l_ac].l_imae080,
                        g_psca5_d[l_ac].l_imaa004,g_psca5_d[l_ac].l_imae064,g_psca5_d[l_ac].l_mfg,g_psca5_d[l_ac].l_order,
                        g_psca5_d[l_ac].l_feature_1,g_psca5_d[l_ac].l_imaf171,g_psca5_d[l_ac].l_imaf171_1,g_psca5_d[l_ac].l_consume_1,
                        g_psca5_d[l_ac].l_release_1,g_psca5_d[l_ac].l_lastqty,g_psca5_d[l_ac].l_combine,g_psca5_d[l_ac].l_inspect,
                        g_psca5_d[l_ac].l_consign,g_psca5_d[l_ac].l_imaf143,g_psca5_d[l_ac].l_purchase,g_psca5_d[l_ac].l_imae016,
                        g_psca5_d[l_ac].l_mfg_1,g_psca5_d[l_ac].l_imaa105,g_psca5_d[l_ac].l_sales,g_psca5_d[l_ac].l_imae064_1,
                        g_psca5_d[l_ac].l_alt,g_psca5_d[l_ac].l_break,g_psca5_d[l_ac].l_create,g_psca5_d[l_ac].l_supratio,
                        g_psca5_d[l_ac].l_imaf153,g_psca5_d[l_ac].l_backward,g_psca5_d[l_ac].l_batch,g_psca5_d[l_ac].l_setup,
                        g_psca5_d[l_ac].l_imae052,g_psca5_d[l_ac].l_imae077,g_psca5_d[l_ac].l_base,g_psca5_d[l_ac].l_max_batch_size,
                        g_psca5_d[l_ac].l_imae032,g_psca5_d[l_ac].l_outsourcing,g_psca5_d[l_ac].l_imae072,g_psca5_d[l_ac].l_imae073,
                        g_psca5_d[l_ac].l_var,g_psca5_d[l_ac].l_auto,g_psca5_d[l_ac].l_consolidate,g_psca5_d[l_ac].l_phase,
                        g_psca5_d[l_ac].l_spare,g_psca5_d[l_ac].l_due,g_psca5_d[l_ac].l_imae015,g_psca5_d[l_ac].l_imaa005,
                        g_psca5_d[l_ac].l_imae078,g_psca5_d[l_ac].l_imae079,g_psca5_d[l_ac].l_imae083,g_psca5_d[l_ac].l_imae082
                   #161109-00085#12-mod-e
                      LET l_ac = l_ac + 1
                      IF SQLCA.sqlcode THEN
                         INITIALIZE g_errparam TO NULL 
                         LET g_errparam.extend = "FOREACH:" 
                         LET g_errparam.code   = SQLCA.sqlcode 
                         LET g_errparam.popup  = TRUE 
                         CALL cl_err()
                         
                         EXIT FOREACH
                      END IF
                   END FOREACH
                   CALL g_psca5_d.deleteElement(g_psca5_d.getLength())
                   LET g_tot_cnt = g_psca5_d.getLength()
                END IF
               
           WHEN l_specification[1].l_name = "Feature_Group.txt"
                IF g_wc6 <> " 1=1" THEN
                   LET l_ac = 1
                   FOR l_d= 1 to l_c
                            #mod--161109-00085#12 By 08993--(s)
#                            INSERT INTO feature_group_tmp VALUES (g_psca6_d[l_d].*)   #mark--161109-00085#12 By 08993--(s)
                            INSERT INTO feature_group_tmp (psca001,imeb001,imeb002,imeb004,imeb006,imeb005,imeb010,imeb011,imeb008,imeb009) 
                                                   VALUES (g_psca6_d[l_d].psca001,g_psca6_d[l_d].l_imeb001,g_psca6_d[l_d].l_imeb002,
                                                           g_psca6_d[l_d].l_imeb004,g_psca6_d[l_d].l_imeb006,g_psca6_d[l_d].l_imeb005,
                                                           g_psca6_d[l_d].l_imeb010,g_psca6_d[l_d].l_imeb011,g_psca6_d[l_d].l_imeb008,
                                                           g_psca6_d[l_d].l_imeb009 )
                            #mod--161109-00085#12 By 08993--(s)
                            #IF SQLCA.sqlcode OR SQLCA.sqlerrd[3] = 0 THEN
                            #   INITIALIZE g_errparam TO NULL
                            #   LET g_errparam.extend = 'ins feature_group',g_psca6_d[l_d].l_imeb001
                            #   LET g_errparam.code   = SQLCA.sqlcode
                            #   LET g_errparam.popup  = TRUE
                            #   CALL cl_err()
                            #   EXIT WHILE
                            #END IF
                   END FOR
                   CALL g_psca6_d.clear()
                   #mod--161109-00085#12 By 08993--(s)
                   #LET l_sql6 = "SELECT * FROM feature_group_tmp ",
                   LET l_sql6 = "SELECT psca001,imeb001,imeb002,imeb004,imeb006,imeb005,imeb010,imeb011,imeb008,imeb009 
                                   FROM feature_group_tmp ",
                   #mod--161109-00085#12 By 08993--(e)
                                 " WHERE ",g_wc6 
                   PREPARE apsq102_tmp_wc6_pre FROM l_sql6
                   DECLARE apsq102_tmp_wc6_curs CURSOR FOR apsq102_tmp_wc6_pre
                   #mod--161109-00085#12 By 08993--(s)
                   #FOREACH apsq102_tmp_wc6_curs INTO g_psca6_d[l_ac].*
                   FOREACH apsq102_tmp_wc6_curs 
                   INTO g_psca6_d[l_ac].psca001,g_psca6_d[l_ac].l_imeb001,g_psca6_d[l_ac].l_imeb002,
                        g_psca6_d[l_ac].l_imeb004,g_psca6_d[l_ac].l_imeb006,g_psca6_d[l_ac].l_imeb005,
                        g_psca6_d[l_ac].l_imeb010,g_psca6_d[l_ac].l_imeb011,g_psca6_d[l_ac].l_imeb008,
                        g_psca6_d[l_ac].l_imeb009
                   #mod--161109-00085#12 By 08993--(e)
                      LET l_ac = l_ac + 1
                      IF SQLCA.sqlcode THEN
                         INITIALIZE g_errparam TO NULL 
                         LET g_errparam.extend = "FOREACH:" 
                         LET g_errparam.code   = SQLCA.sqlcode 
                         LET g_errparam.popup  = TRUE 
                         CALL cl_err()
                         
                         EXIT FOREACH
                      END IF
                   END FOREACH
                   CALL g_psca6_d.deleteElement(g_psca6_d.getLength())
                   LET g_tot_cnt = g_psca6_d.getLength()
                END IF
               
           WHEN l_specification[1].l_name = "Bill_of_Material.txt"
                IF g_wc7 <> " 1=1" THEN
                   LET l_ac = 1
                   FOR l_d= 1 to l_c
                            #mod--161109-00085#12 By 08993--(s)
#                            INSERT INTO b_o_m_tmp VALUES (g_psca7_d[l_d].*)   #mark--161109-00085#12 By 08993--(s)
                            INSERT INTO b_o_m_tmp (psca001,bmba001,bmba012,bmba003,bmba009,bmba011,shrinkage,
                                                   bmba013,bmba031,alt_1,create_1,ratio,bmba007,bmba021,used_1,
                                                   substitute,fixed,bmba023,bmba004,bmba008,quantity)
                                           VALUES (g_psca7_d[l_d].psca001,g_psca7_d[l_d].l_bmba001,g_psca7_d[l_d].l_bmba012,
                                                   g_psca7_d[l_d].l_bmba003,g_psca7_d[l_d].l_bmba009,g_psca7_d[l_d].l_bmba011,
                                                   g_psca7_d[l_d].l_shrinkage,g_psca7_d[l_d].l_bmba013,g_psca7_d[l_d].l_bmba031,
                                                   g_psca7_d[l_d].l_alt_1,g_psca7_d[l_d].l_create_1,g_psca7_d[l_d].l_ratio,
                                                   g_psca7_d[l_d].l_bmba007,g_psca7_d[l_d].l_bmba021,g_psca7_d[l_d].l_used_1,
                                                   g_psca7_d[l_d].l_substitute,g_psca7_d[l_d].l_fixed,g_psca7_d[l_d].l_bmba023,
                                                   g_psca7_d[l_d].l_bmba004,g_psca7_d[l_d].l_bmba008,g_psca7_d[l_d].l_quantity)
                            #mod--161109-00085#12 By 08993--(e)
                            #IF SQLCA.sqlcode OR SQLCA.sqlerrd[3] = 0 THEN
                            #   INITIALIZE g_errparam TO NULL
                            #   LET g_errparam.extend = 'ins bill_of_material',g_psca7_d[l_d].l_bmba001
                            #   LET g_errparam.code   = SQLCA.sqlcode
                            #   LET g_errparam.popup  = TRUE
                            #   CALL cl_err()
                            #   EXIT WHILE
                            #END IF
                   END FOR
                   CALL g_psca7_d.clear()
                   #mod--161109-00085#12 By 08993--(s)
                   #LET l_sql7 = "SELECT * FROM b_o_m_tmp ",
                   LET l_sql7 = "SELECT psca001,bmba001,bmba012,bmba003,bmba009,bmba011,shrinkage,
                                        bmba013,bmba031,alt_1,create_1,ratio,bmba007,bmba021,used_1,
                                        substitute,fixed,bmba023,bmba004,bmba008,quantity 
                                   FROM b_o_m_tmp ",
                   #mod--161109-00085#12 By 08993--(e)
                                 " WHERE ",g_wc7 
                   PREPARE apsq102_tmp_wc7_pre FROM l_sql7
                   DECLARE apsq102_tmp_wc7_curs CURSOR FOR apsq102_tmp_wc7_pre
                   #mod--161109-00085#12 By 08993--(s)
                   #FOREACH apsq102_tmp_wc7_curs INTO g_psca7_d[l_ac].*
                   FOREACH apsq102_tmp_wc7_curs 
                   INTO g_psca7_d[l_ac].psca001,g_psca7_d[l_ac].l_bmba001,g_psca7_d[l_ac].l_bmba012,
                        g_psca7_d[l_ac].l_bmba003,g_psca7_d[l_ac].l_bmba009,g_psca7_d[l_ac].l_bmba011,
                        g_psca7_d[l_ac].l_shrinkage,g_psca7_d[l_ac].l_bmba013,g_psca7_d[l_ac].l_bmba031,
                        g_psca7_d[l_ac].l_alt_1,g_psca7_d[l_ac].l_create_1,g_psca7_d[l_ac].l_ratio,
                        g_psca7_d[l_ac].l_bmba007,g_psca7_d[l_ac].l_bmba021,g_psca7_d[l_ac].l_used_1,
                        g_psca7_d[l_ac].l_substitute,g_psca7_d[l_ac].l_fixed,g_psca7_d[l_ac].l_bmba023,
                        g_psca7_d[l_ac].l_bmba004,g_psca7_d[l_ac].l_bmba008,g_psca7_d[l_ac].l_quantity
                   #mod--161109-00085#12 By 08993--(e)
                      LET l_ac = l_ac + 1
                      IF SQLCA.sqlcode THEN
                         INITIALIZE g_errparam TO NULL 
                         LET g_errparam.extend = "FOREACH:" 
                         LET g_errparam.code   = SQLCA.sqlcode 
                         LET g_errparam.popup  = TRUE 
                         CALL cl_err()
                         
                         EXIT FOREACH
                      END IF
                   END FOREACH
                   CALL g_psca7_d.deleteElement(g_psca7_d.getLength())
                   LET g_tot_cnt = g_psca7_d.getLength()
                END IF
               
           WHEN l_specification[1].l_name = "Unassigned_Inventory.txt"
                IF g_wc8 <> " 1=1" THEN
                   LET l_ac = 1
                   FOR l_d= 1 to l_c
                            #mod--161109-00085#12 By 08993--(s)
#                            INSERT INTO u_i_tmp VALUES (g_psca8_d[l_d].*)   #mark--161109-00085#12 By 08993--(s)
                            INSERT INTO u_i_tmp (psca001,inag001,inag004,inag005,inag009,inag002,hard)
                                         VALUES (g_psca8_d[l_d].psca001,g_psca8_d[l_d].l_inag001,g_psca8_d[l_d].l_inag004,
                                                 g_psca8_d[l_d].l_inag005,g_psca8_d[l_d].l_inag009,g_psca8_d[l_d].l_inag002,g_psca8_d[l_d].l_hard)
                            #mod--161109-00085#12 By 08993--(e)
                            #IF SQLCA.sqlcode OR SQLCA.sqlerrd[3] = 0 THEN
                            #   INITIALIZE g_errparam TO NULL
                            #   LET g_errparam.extend = 'ins unassigned_inventory',g_psca8_d[l_d].l_inag001
                            #   LET g_errparam.code   = SQLCA.sqlcode
                            #   LET g_errparam.popup  = TRUE
                            #   CALL cl_err()
                            #   EXIT WHILE
                            #END IF
                   END FOR
                   CALL g_psca8_d.clear()
                   #mod--161109-00085#12 By 08993--(s)
                   #LET l_sql8 = "SELECT * FROM u_i_tmp ",
                   LET l_sql8 = "SELECT psca001,inag001,inag004,inag005,inag009,inag002,hard 
                                   FROM u_i_tmp ",
                   #mod--161109-00085#12 By 08993--(e)
                                 " WHERE ",g_wc8 
                   PREPARE apsq102_tmp_wc8_pre FROM l_sql8
                   DECLARE apsq102_tmp_wc8_curs CURSOR FOR apsq102_tmp_wc8_pre
                   #mod--161109-00085#12 By 08993--(s)
                   #FOREACH apsq102_tmp_wc8_curs INTO g_psca8_d[l_ac].*
                   FOREACH apsq102_tmp_wc8_curs 
                   INTO g_psca8_d[l_ac].psca001,g_psca8_d[l_ac].l_inag001,g_psca8_d[l_ac].l_inag004,
                        g_psca8_d[l_ac].l_inag005,g_psca8_d[l_ac].l_inag009,g_psca8_d[l_ac].l_inag002,g_psca8_d[l_ac].l_hard
                   #mod--161109-00085#12 By 08993--(e)
                      LET l_ac = l_ac + 1
                      IF SQLCA.sqlcode THEN
                         INITIALIZE g_errparam TO NULL 
                         LET g_errparam.extend = "FOREACH:" 
                         LET g_errparam.code   = SQLCA.sqlcode 
                         LET g_errparam.popup  = TRUE 
                         CALL cl_err()
                         
                         EXIT FOREACH
                      END IF
                   END FOREACH
                   CALL g_psca8_d.deleteElement(g_psca8_d.getLength())
                   LET g_tot_cnt = g_psca8_d.getLength()
                END IF
               
           WHEN l_specification[1].l_name = "Warehouse.txt"
                IF g_wc9 <> " 1=1" THEN
                   LET l_ac = 1
                   FOR l_d= 1 to l_c
                            #mod--161109-00085#12 By 08993--(s)
#                            INSERT INTO warehouse_tmp VALUES (g_psca9_d[l_d].*)   #mark--161109-00085#12 By 08993--(s)
                            INSERT INTO warehouse_tmp (psca001,inaa001,inaa006)
                                               VALUES (g_psca9_d[l_d].psca001,g_psca9_d[l_d].l_inaa001,g_psca9_d[l_d].l_inaa006)
                            #mod--161109-00085#12 By 08993--(e)
                            #IF SQLCA.sqlcode OR SQLCA.sqlerrd[3] = 0 THEN
                            #   INITIALIZE g_errparam TO NULL
                            #   LET g_errparam.extend = 'ins warehouse',g_psca9_d[l_d].l_inaa001
                            #   LET g_errparam.code   = SQLCA.sqlcode
                            #   LET g_errparam.popup  = TRUE
                            #   CALL cl_err()
                            #   EXIT WHILE
                            #END IF
                   END FOR
                   CALL g_psca9_d.clear()
                   #mod--161109-00085#12 By 08993--(s)
                   #LET l_sql9 = "SELECT * FROM warehouse_tmp ",
                   LET l_sql9 = "SELECT psca001,inaa001,inaa006 
                                   FROM warehouse_tmp ",
                   #mod--161109-00085#12 By 08993--(e)
                                 " WHERE ",g_wc9 
                   PREPARE apsq102_tmp_wc9_pre FROM l_sql9
                   DECLARE apsq102_tmp_wc9_curs CURSOR FOR apsq102_tmp_wc9_pre
                   #mod--161109-00085#12 By 08993--(s)
                   #FOREACH apsq102_tmp_wc9_curs INTO g_psca9_d[l_ac].*
                   FOREACH apsq102_tmp_wc9_curs 
                   INTO g_psca9_d[l_ac].psca001,g_psca9_d[l_ac].l_inaa001,g_psca9_d[l_ac].l_inaa006
                   #mod--161109-00085#12 By 08993--(e)
                      LET l_ac = l_ac + 1
                      IF SQLCA.sqlcode THEN
                         INITIALIZE g_errparam TO NULL 
                         LET g_errparam.extend = "FOREACH:" 
                         LET g_errparam.code   = SQLCA.sqlcode 
                         LET g_errparam.popup  = TRUE 
                         CALL cl_err()
                         
                         EXIT FOREACH
                      END IF
                   END FOREACH
                   CALL g_psca9_d.deleteElement(g_psca9_d.getLength())
                   LET g_tot_cnt = g_psca9_d.getLength()
                END IF
               
           WHEN l_specification[1].l_name = "Stock_Location.txt"
                IF g_wc10 <> " 1=1" THEN
                   LET l_ac = 1
                   FOR l_d= 1 to l_c
                            #mod--161109-00085#12 By 08993--(s)
#                            INSERT INTO sto_lct_tmp01 VALUES (g_psca10_d[l_d].*)           #160727-00019#15 Mod   stock_location_tmp -->sto_lct_tmp01    #mark--161109-00085#12 By 08993--(s)
                            INSERT INTO sto_lct_tmp01 (psca001,inab001,inab002,inab005,consigned)
                                               VALUES (g_psca10_d[l_d].psca001,g_psca10_d[l_d].l_inab001,g_psca10_d[l_d].l_inab002,
                                                       g_psca10_d[l_d].l_inab005,g_psca10_d[l_d].l_consigned)
                            #mod--161109-00085#12 By 08993--(e)
                            #IF SQLCA.sqlcode OR SQLCA.sqlerrd[3] = 0 THEN
                            #   INITIALIZE g_errparam TO NULL
                            #   LET g_errparam.extend = 'ins stock_location',g_psca10_d[l_d].l_inab001
                            #   LET g_errparam.code   = SQLCA.sqlcode
                            #   LET g_errparam.popup  = TRUE
                            #   CALL cl_err()
                            #   EXIT WHILE
                            #END IF
                   END FOR
                   CALL g_psca10_d.clear()
                   #mod--161109-00085#12 By 08993--(s)
                   #LET l_sql10 = "SELECT * FROM sto_lct_tmp01 ",       #160727-00019#15 Mod   stock_location_tmp -->sto_lct_tmp01
                   LET l_sql10 = "SELECT psca001,inab001,inab002,inab005,consigned 
                                    FROM sto_lct_tmp01 ",
                   #mod--161109-00085#12 By 08993--(e)
                                 " WHERE ",g_wc10 
                   PREPARE apsq102_tmp_wc10_pre FROM l_sql10
                   DECLARE apsq102_tmp_wc10_curs CURSOR FOR apsq102_tmp_wc10_pre
                   #mod--161109-00085#12 By 08993--(s)
                   #FOREACH apsq102_tmp_wc10_curs INTO g_psca10_d[l_ac].*
                   FOREACH apsq102_tmp_wc10_curs 
                   INTO g_psca10_d[l_ac].psca001,g_psca10_d[l_ac].l_inab001,g_psca10_d[l_ac].l_inab002,
                        g_psca10_d[l_ac].l_inab005,g_psca10_d[l_ac].l_consigned
                   #mod--161109-00085#12 By 08993--(e)
                      LET l_ac = l_ac + 1
                      IF SQLCA.sqlcode THEN
                         INITIALIZE g_errparam TO NULL 
                         LET g_errparam.extend = "FOREACH:" 
                         LET g_errparam.code   = SQLCA.sqlcode 
                         LET g_errparam.popup  = TRUE 
                         CALL cl_err()
                         
                         EXIT FOREACH
                      END IF
                   END FOREACH
                   CALL g_psca10_d.deleteElement(g_psca10_d.getLength())
                   LET g_tot_cnt = g_psca10_d.getLength()
                END IF
            
           WHEN l_specification[1].l_name = "BOM_Feature_Type1.txt"
                IF g_wc11 <> " 1=1" THEN
                   LET l_ac = 1
                   FOR l_d= 1 to l_c
                            #mod--161109-00085#12 By 08993--(s)
#                            INSERT INTO b_f_t1_tmp VALUES (g_psca11_d[l_d].*)   #mark--161109-00085#12 By 08993--(s)
                            INSERT INTO b_f_t1_tmp (psca001,bmca001,bmca009,bmca005,bmca003,bmcb011,bmcb012)
                                            VALUES (g_psca11_d[l_d].psca001,g_psca11_d[l_d].l_bmca001,g_psca11_d[l_d].l_bmca009,
                                                    g_psca11_d[l_d].l_bmca005,g_psca11_d[l_d].l_bmca003,g_psca11_d[l_d].l_bmcb011,
                                                    g_psca11_d[l_d].l_bmcb012)
                            #mod--161109-00085#12 By 08993--(e)
                            #IF SQLCA.sqlcode OR SQLCA.sqlerrd[3] = 0 THEN
                            #   INITIALIZE g_errparam TO NULL
                            #   LET g_errparam.extend = 'ins bom_feature_type1',g_psca11_d[l_d].l_bmca001
                            #   LET g_errparam.code   = SQLCA.sqlcode
                            #   LET g_errparam.popup  = TRUE
                            #   CALL cl_err()
                            #   EXIT WHILE
                            #END IF
                   END FOR
                   CALL g_psca11_d.clear()
                   #mod--161109-00085#12 By 08993--(s)
                   #LET l_sql11 = "SELECT * FROM b_f_t1_tmp ",
                   LET l_sql11 = "SELECT psca001,bmca001,bmca009,bmca005,bmca003,bmcb011,bmcb012 
                                    FROM b_f_t1_tmp ",
                   #mod--161109-00085#12 By 08993--(e)
                                 " WHERE ",g_wc11 
                   PREPARE apsq102_tmp_wc11_pre FROM l_sql11
                   DECLARE apsq102_tmp_wc11_curs CURSOR FOR apsq102_tmp_wc11_pre
                   #mod--161109-00085#12 By 08993--(s)
                   #FOREACH apsq102_tmp_wc11_curs INTO g_psca11_d[l_ac].*
                   FOREACH apsq102_tmp_wc11_curs 
                   INTO g_psca11_d[l_ac].psca001,g_psca11_d[l_ac].l_bmca001,g_psca11_d[l_ac].l_bmca009,
                        g_psca11_d[l_ac].l_bmca005,g_psca11_d[l_ac].l_bmca003,g_psca11_d[l_ac].l_bmcb011,
                        g_psca11_d[l_ac].l_bmcb012
                   #mod--161109-00085#12 By 08993--(e)
                      LET l_ac = l_ac + 1
                      IF SQLCA.sqlcode THEN
                         INITIALIZE g_errparam TO NULL 
                         LET g_errparam.extend = "FOREACH:" 
                         LET g_errparam.code   = SQLCA.sqlcode 
                         LET g_errparam.popup  = TRUE 
                         CALL cl_err()
                         
                         EXIT FOREACH
                      END IF
                   END FOREACH
                   CALL g_psca11_d.deleteElement(g_psca11_d.getLength())
                   LET g_tot_cnt = g_psca11_d.getLength()
                END IF
               
           WHEN l_specification[1].l_name = "BOM_Feature_Type2.txt"
                IF g_wc12 <> " 1=1" THEN
                   LET l_ac = 1
                   FOR l_d= 1 to l_c
                            #mod--161109-00085#12 By 08993--(s)
#                            INSERT INTO b_f_t2_tmp VALUES (g_psca12_d[l_d].*)  #mark--161109-00085#12 By 08993--(s)
                            INSERT INTO b_f_t2_tmp (psca001,bmc001,bmcc009,bmcd010,bmcc005,bmcc003,bmcd011,bmcc010)
                                            VALUES (g_psca12_d[l_d].psca001,g_psca12_d[l_d].l_bmc001,g_psca12_d[l_d].l_bmcc009,
                                                    g_psca12_d[l_d].l_bmcd010,g_psca12_d[l_d].l_bmcc005,g_psca12_d[l_d].l_bmcc003,
                                                    g_psca12_d[l_d].l_bmcd011,g_psca12_d[l_d].l_bmcc010)
                            #mod--161109-00085#12 By 08993--(e)
                            #IF SQLCA.sqlcode OR SQLCA.sqlerrd[3] = 0 THEN
                            #   INITIALIZE g_errparam TO NULL
                            #   LET g_errparam.extend = 'ins bom_feature_type2',g_psca12_d[l_d].l_bmc001
                            #   LET g_errparam.code   = SQLCA.sqlcode
                            #   LET g_errparam.popup  = TRUE
                            #   CALL cl_err()
                            #   EXIT WHILE
                            #END IF
                   END FOR
                   CALL g_psca12_d.clear()
                   #mod--161109-00085#12 By 08993--(s)
                   #LET l_sql12 = "SELECT * FROM b_f_t2_tmp ",
                   LET l_sql12 = "SELECT psca001,bmc001,bmcc009,bmcd010,bmcc005,bmcc003,bmcd011,bmcc010
                                    FROM b_f_t2_tmp ",
                   #mod--161109-00085#12 By 08993--(e)
                                 " WHERE ",g_wc12 
                   PREPARE apsq102_tmp_wc12_pre FROM l_sql12
                   DECLARE apsq102_tmp_wc12_curs CURSOR FOR apsq102_tmp_wc12_pre
                   #mod--161109-00085#12 By 08993--(s)
                   #FOREACH apsq102_tmp_wc12_curs INTO g_psca12_d[l_ac].*
                   FOREACH apsq102_tmp_wc12_curs 
                   INTO g_psca12_d[l_ac].psca001,g_psca12_d[l_ac].l_bmc001,g_psca12_d[l_ac].l_bmcc009,
                        g_psca12_d[l_ac].l_bmcd010,g_psca12_d[l_ac].l_bmcc005,g_psca12_d[l_ac].l_bmcc003,
                        g_psca12_d[l_ac].l_bmcd011,g_psca12_d[l_ac].l_bmcc010
                   #mod--161109-00085#12 By 08993--(e)
                      LET l_ac = l_ac + 1
                      IF SQLCA.sqlcode THEN
                         INITIALIZE g_errparam TO NULL 
                         LET g_errparam.extend = "FOREACH:" 
                         LET g_errparam.code   = SQLCA.sqlcode 
                         LET g_errparam.popup  = TRUE 
                         CALL cl_err()
                         
                         EXIT FOREACH
                      END IF
                   END FOREACH
                   CALL g_psca12_d.deleteElement(g_psca12_d.getLength())
                   LET g_tot_cnt = g_psca12_d.getLength()
                END IF
               
           WHEN l_specification[1].l_name = "Feature_Group_Line.txt"
                IF g_wc13 <> " 1=1" THEN
                   LET l_ac = 1
                   FOR l_d= 1 to l_c
                            #mod--161109-00085#12 By 08993--(s)
#                            INSERT INTO f_g_l_tmp VALUES (g_psca13_d[l_d].*)   #mark--161109-00085#12 By 08993--(s)
                            INSERT INTO f_g_l_tmp (psca001,imec001,imec002,imec003)
                                           VALUES (g_psca13_d[l_d].psca001,g_psca13_d[l_d].l_imec001,g_psca13_d[l_d].l_imec002,
                                                   g_psca13_d[l_d].l_imec003)
                            #mod--161109-00085#12 By 08993--(e)
                            #IF SQLCA.sqlcode OR SQLCA.sqlerrd[3] = 0 THEN
                            #   INITIALIZE g_errparam TO NULL
                            #   LET g_errparam.extend = 'ins feature_group_line',g_psca13_d[l_d].l_imec001
                            #   LET g_errparam.code   = SQLCA.sqlcode
                            #   LET g_errparam.popup  = TRUE
                            #   CALL cl_err()
                            #   EXIT WHILE
                            #END IF
                   END FOR
                   CALL g_psca13_d.clear()
                   #mod--161109-00085#12 By 08993--(s)
                   #LET l_sql13 = "SELECT * FROM f_g_l_tmp ",
                   LET l_sql13 = "SELECT psca001,imec001,imec002,imec003 
                                    FROM f_g_l_tmp ",
                   #mod--161109-00085#12 By 08993--(e)
                                 " WHERE ",g_wc13 
                   PREPARE apsq102_tmp_wc13_pre FROM l_sql13
                   DECLARE apsq102_tmp_wc13_curs CURSOR FOR apsq102_tmp_wc13_pre
                   #mod--161109-00085#12 By 08993--(s)
                   #FOREACH apsq102_tmp_wc13_curs INTO g_psca13_d[l_ac].*
                   FOREACH apsq102_tmp_wc13_curs 
                   INTO g_psca13_d[l_ac].psca001,g_psca13_d[l_ac].l_imec001,g_psca13_d[l_ac].l_imec002,
                        g_psca13_d[l_ac].l_imec003
                   #mod--161109-00085#12 By 08993--(e)
                      LET l_ac = l_ac + 1
                      IF SQLCA.sqlcode THEN
                         INITIALIZE g_errparam TO NULL 
                         LET g_errparam.extend = "FOREACH:" 
                         LET g_errparam.code   = SQLCA.sqlcode 
                         LET g_errparam.popup  = TRUE 
                         CALL cl_err()
                         
                         EXIT FOREACH
                      END IF
                   END FOREACH
                   CALL g_psca13_d.deleteElement(g_psca13_d.getLength())
                   LET g_tot_cnt = g_psca13_d.getLength()
                END IF
               
           WHEN l_specification[1].l_name = "BOM_Feature_Type3.txt"
                IF g_wc14 <> " 1=1" THEN
                   LET l_ac = 1
                   FOR l_d= 1 to l_c
                            #mod--161109-00085#12 By 08993--(s)
#                            INSERT INTO b_f_t3_tmp VALUES (g_psca14_d[l_d].*)   #mark--161109-00085#12 By 08993--(s)
                            INSERT INTO b_f_t3_tmp (psca001,bmce001,bmce005,bmce003,bmce009,bmce010) 
                                            VALUES (g_psca14_d[l_d].psca001,g_psca14_d[l_d].l_bmce001,g_psca14_d[l_d].l_bmce005,
                                                    g_psca14_d[l_d].l_bmce003,g_psca14_d[l_d].l_bmce009,g_psca14_d[l_d].l_bmce010)
                            #mod--161109-00085#12 By 08993--(e)
                            #IF SQLCA.sqlcode OR SQLCA.sqlerrd[3] = 0 THEN
                            #   INITIALIZE g_errparam TO NULL
                            #   LET g_errparam.extend = 'ins bom_feature_type3',g_psca14_d[l_d].l_bmce001
                            #   LET g_errparam.code   = SQLCA.sqlcode
                            #   LET g_errparam.popup  = TRUE
                            #   CALL cl_err()
                            #   EXIT WHILE
                            #END IF
                   END FOR
                   CALL g_psca14_d.clear()
                   #mod--161109-00085#12 By 08993--(s)
                   #LET l_sql14 = "SELECT * FROM b_f_t3_tmp ",
                   LET l_sql14 = "SELECT psca001,bmce001,bmce005,bmce003,bmce009,bmce010 
                                    FROM b_f_t3_tmp ",
                   #mod--161109-00085#12 By 08993--(e)
                                 " WHERE ",g_wc14 
                   PREPARE apsq102_tmp_wc14_pre FROM l_sql14
                   DECLARE apsq102_tmp_wc14_curs CURSOR FOR apsq102_tmp_wc14_pre
                   #mod--161109-00085#12 By 08993--(s)
                   #FOREACH apsq102_tmp_wc14_curs INTO g_psca14_d[l_ac].*
                   FOREACH apsq102_tmp_wc14_curs 
                   INTO g_psca14_d[l_ac].psca001,g_psca14_d[l_ac].l_bmce001,g_psca14_d[l_ac].l_bmce005,
                        g_psca14_d[l_ac].l_bmce003,g_psca14_d[l_ac].l_bmce009,g_psca14_d[l_ac].l_bmce010
                   #mod--161109-00085#12 By 08993--(e)
                      LET l_ac = l_ac + 1
                      IF SQLCA.sqlcode THEN
                         INITIALIZE g_errparam TO NULL 
                         LET g_errparam.extend = "FOREACH:" 
                         LET g_errparam.code   = SQLCA.sqlcode 
                         LET g_errparam.popup  = TRUE 
                         CALL cl_err()
                         
                         EXIT FOREACH
                      END IF
                   END FOREACH
                   CALL g_psca14_d.deleteElement(g_psca14_d.getLength())
                   LET g_tot_cnt = g_psca14_d.getLength()
                END IF
               
           WHEN l_specification[1].l_name = "Item_Joint_Product.txt"
                IF g_wc15 <> " 1=1" THEN
                   LET l_ac = 1
                   FOR l_d= 1 to l_c
                            #mod--161109-00085#12 By 08993--(s)
#                            INSERT INTO i_j_p_tmp VALUES (g_psca15_d[l_d].*)   #mark--161109-00085#12 By 08993--(s)
                            INSERT INTO i_j_p_tmp (psca001,bmab001,bmab003,type_1,bmab004)
                                           VALUES (g_psca15_d[l_d].psca001,g_psca15_d[l_d].l_bmab001,g_psca15_d[l_d].l_bmab003,
                                                   g_psca15_d[l_d].l_type_1,g_psca15_d[l_d].l_bmab004)
                            #mod--161109-00085#12 By 08993--(e)
                            #IF SQLCA.sqlcode OR SQLCA.sqlerrd[3] = 0 THEN
                            #   INITIALIZE g_errparam TO NULL
                            #   LET g_errparam.extend = 'ins item_joint_product',g_psca15_d[l_d].l_bmab001
                            #   LET g_errparam.code   = SQLCA.sqlcode
                            #   LET g_errparam.popup  = TRUE
                            #   CALL cl_err()
                            #   EXIT WHILE
                            #END IF
                   END FOR
                   CALL g_psca15_d.clear()
                   #mod--161109-00085#12 By 08993--(s)
                   #LET l_sql15 = "SELECT * FROM i_j_p_tmp ",
                   LET l_sql15 = "SELECT psca001,bmab001,bmab003,type_1,bmab004 
                                    FROM i_j_p_tmp ",
                   #mod--161109-00085#12 By 08993--(e)
                                 " WHERE ",g_wc15 
                   PREPARE apsq102_tmp_wc15_pre FROM l_sql15
                   DECLARE apsq102_tmp_wc15_curs CURSOR FOR apsq102_tmp_wc15_pre
                   #mod--161109-00085#12 By 08993--(s)
                   #FOREACH apsq102_tmp_wc15_curs INTO g_psca15_d[l_ac].*
                   FOREACH apsq102_tmp_wc15_curs 
                   INTO g_psca15_d[l_ac].psca001,g_psca15_d[l_ac].l_bmab001,g_psca15_d[l_ac].l_bmab003,
                        g_psca15_d[l_ac].l_type_1,g_psca15_d[l_ac].l_bmab004
                   #mod--161109-00085#12 By 08993--(e)
                      LET l_ac = l_ac + 1
                      IF SQLCA.sqlcode THEN
                         INITIALIZE g_errparam TO NULL 
                         LET g_errparam.extend = "FOREACH:" 
                         LET g_errparam.code   = SQLCA.sqlcode 
                         LET g_errparam.popup  = TRUE 
                         CALL cl_err()
                         
                         EXIT FOREACH
                      END IF
                   END FOREACH
                   CALL g_psca15_d.deleteElement(g_psca15_d.getLength())
                   LET g_tot_cnt = g_psca15_d.getLength()
                END IF
               
           WHEN l_specification[1].l_name = "Alt_Part.txt"
                IF g_wc16 <> " 1=1" THEN
                   LET l_ac = 1
                   FOR l_d= 1 to l_c
                            #mod--161109-00085#12 By 08993--(s)
#                            INSERT INTO alt_part_tmp VALUES (g_psca16_d[l_d].*)   #mod--161109-00085#12 By 08993--(s)
                            INSERT INTO alt_part_tmp (psca001,bmea001,bmea003,bmea008,bmea015,bmea011,
                                                      bmea009,bmea010,bmea012,bmea007,bmea017,bmea016)
                                              VALUES (g_psca16_d[l_d].psca001,g_psca16_d[l_d].l_bmea001,g_psca16_d[l_d].l_bmea003,
                                                      g_psca16_d[l_d].l_bmea008,g_psca16_d[l_d].l_bmea015,g_psca16_d[l_d].l_bmea011,
                                                      g_psca16_d[l_d].l_bmea009,g_psca16_d[l_d].l_bmea010,g_psca16_d[l_d].l_bmea012,
                                                      g_psca16_d[l_d].l_bmea007,g_psca16_d[l_d].l_bmea017,g_psca16_d[l_d].l_bmea016)
                            #mod--161109-00085#12 By 08993--(e)
                           #IF SQLCA.sqlcode OR SQLCA.sqlerrd[3] = 0 THEN
                           #   INITIALIZE g_errparam TO NULL
                           #   LET g_errparam.extend = 'ins alt_part',g_psca16_d[l_d].l_bmea001
                           #   LET g_errparam.code   = SQLCA.sqlcode
                           #   LET g_errparam.popup  = TRUE
                           #   CALL cl_err()
                           #   EXIT WHILE
                           #END IF
                   END FOR
                   CALL g_psca16_d.clear()
                   #mod--161109-00085#12 By 08993--(s)
                   #LET l_sql16 = "SELECT * FROM alt_part_tmp ",
                   LET l_sql16 = "SELECT psca001,bmea001,bmea003,bmea008,bmea015,bmea011,
                                         bmea009,bmea010,bmea012,bmea007,bmea017,bmea016 
                                    FROM alt_part_tmp ",
                   #mod--161109-00085#12 By 08993--(e)
                                 " WHERE ",g_wc16 
                   PREPARE apsq102_tmp_wc16_pre FROM l_sql16
                   DECLARE apsq102_tmp_wc16_curs CURSOR FOR apsq102_tmp_wc16_pre
                   #mod--161109-00085#12 By 08993--(s)
                   #FOREACH apsq102_tmp_wc16_curs INTO g_psca16_d[l_ac].*
                   FOREACH apsq102_tmp_wc16_curs 
                   INTO g_psca16_d[l_ac].psca001,g_psca16_d[l_ac].l_bmea001,g_psca16_d[l_ac].l_bmea003,
                        g_psca16_d[l_ac].l_bmea008,g_psca16_d[l_ac].l_bmea015,g_psca16_d[l_ac].l_bmea011,
                        g_psca16_d[l_ac].l_bmea009,g_psca16_d[l_ac].l_bmea010,g_psca16_d[l_ac].l_bmea012,
                        g_psca16_d[l_ac].l_bmea007,g_psca16_d[l_ac].l_bmea017,g_psca16_d[l_ac].l_bmea016
                   #mod--161109-00085#12 By 08993--(e)
                      LET l_ac = l_ac + 1
                      IF SQLCA.sqlcode THEN
                         INITIALIZE g_errparam TO NULL 
                         LET g_errparam.extend = "FOREACH:" 
                         LET g_errparam.code   = SQLCA.sqlcode 
                         LET g_errparam.popup  = TRUE 
                         CALL cl_err()
                         
                         EXIT FOREACH
                      END IF
                   END FOREACH
                   CALL g_psca16_d.deleteElement(g_psca16_d.getLength())
                   LET g_tot_cnt = g_psca16_d.getLength()
                END IF
               
           WHEN l_specification[1].l_name = "Alt_Part_Global.txt"
                IF g_wc17 <> " 1=1" THEN
                   LET l_ac = 1
                   FOR l_d= 1 to l_c
                            #mod--161109-00085#12 By 08993--(s)
#                            INSERT INTO a_p_g_tmp VALUES (g_psca17_d[l_d].*)   #mark--161109-00085#12 By 08993--(s)
                            INSERT INTO a_p_g_tmp (psca001,bmea001_1,bmea008_1,bmea015_1,bmea011_1,bmea009_1,bmea010_1,
                                                   bmea012_1,bmea007_1,bmea017_1,bmea016_1)
                                           VALUES (g_psca17_d[l_d].psca001,g_psca17_d[l_d].l_bmea001_1,g_psca17_d[l_d].l_bmea008_1,
                                                   g_psca17_d[l_d].l_bmea015_1,g_psca17_d[l_d].l_bmea011_1,g_psca17_d[l_d].l_bmea009_1,
                                                   g_psca17_d[l_d].l_bmea010_1,g_psca17_d[l_d].l_bmea012_1,g_psca17_d[l_d].l_bmea007_1,
                                                   g_psca17_d[l_d].l_bmea017_1,g_psca17_d[l_d].l_bmea016_1)
                            #mod--161109-00085#12 By 08993--(e)
                            IF SQLCA.sqlcode OR SQLCA.sqlerrd[3] = 0 THEN
                            #   INITIALIZE g_errparam TO NULL
                            #   LET g_errparam.extend = 'ins alt_part_global',g_psca17_d[l_d].l_bmea001_1
                            #   LET g_errparam.code   = SQLCA.sqlcode
                            #   LET g_errparam.popup  = TRUE
                            #   CALL cl_err()
                            #   EXIT WHILE
                            END IF
                   END FOR
                   CALL g_psca17_d.clear()
                   #mod--161109-00085#12 By 08993--(s)
                   #LET l_sql17 = "SELECT * FROM a_p_g_tmp ",
                   LET l_sql17 = "SELECT psca001,bmea001_1,bmea008_1,bmea015_1,bmea011_1,bmea009_1,bmea010_1,
                                         bmea012_1,bmea007_1,bmea017_1,bmea016_1 
                                    FROM a_p_g_tmp ",
                   #mod--161109-00085#12 By 08993--(e)
                                 " WHERE ",g_wc17 
                   PREPARE apsq102_tmp_wc17_pre FROM l_sql17
                   DECLARE apsq102_tmp_wc17_curs CURSOR FOR apsq102_tmp_wc17_pre
                   #mod--161109-00085#12 By 08993--(s)
                   #FOREACH apsq102_tmp_wc17_curs INTO g_psca17_d[l_ac].*
                   FOREACH apsq102_tmp_wc17_curs 
                   INTO g_psca17_d[l_ac].psca001,g_psca17_d[l_ac].l_bmea001_1,g_psca17_d[l_ac].l_bmea008_1,
                        g_psca17_d[l_ac].l_bmea015_1,g_psca17_d[l_ac].l_bmea011_1,g_psca17_d[l_ac].l_bmea009_1,
                        g_psca17_d[l_ac].l_bmea010_1,g_psca17_d[l_ac].l_bmea012_1,g_psca17_d[l_ac].l_bmea007_1,
                        g_psca17_d[l_ac].l_bmea017_1,g_psca17_d[l_ac].l_bmea016_1
                   #mod--161109-00085#12 By 08993--(e)
                      LET l_ac = l_ac + 1
                      IF SQLCA.sqlcode THEN
                         INITIALIZE g_errparam TO NULL 
                         LET g_errparam.extend = "FOREACH:" 
                         LET g_errparam.code   = SQLCA.sqlcode 
                         LET g_errparam.popup  = TRUE 
                         CALL cl_err()
                         
                         EXIT FOREACH
                      END IF
                   END FOREACH
                   CALL g_psca17_d.deleteElement(g_psca17_d.getLength())
                   LET g_tot_cnt = g_psca17_d.getLength()
                END IF
               
           WHEN l_specification[1].l_name = "WS.txt"
                IF g_wc18 <> " 1=1" THEN
                   LET l_ac = 1
                   FOR l_d= 1 to l_c
                            #mod--161109-00085#12 By 08993--(s)
#                            INSERT INTO ws_tmp VALUES (g_psca18_d[l_d].*)   #mark--161109-00085#12 By 08993--(s)
                            INSERT INTO ws_tmp (psca001,ecaa001)
                                        VALUES (g_psca18_d[l_d].psca001,g_psca18_d[l_d].l_ecaa001)
                            #mod--161109-00085#12 By 08993--(e)
                            #IF SQLCA.sqlcode OR SQLCA.sqlerrd[3] = 0 THEN
                            #   INITIALIZE g_errparam TO NULL
                            #   LET g_errparam.extend = 'ins WS',g_psca18_d[l_d].l_ecaa001
                            #   LET g_errparam.code   = SQLCA.sqlcode
                            #   LET g_errparam.popup  = TRUE
                            #   CALL cl_err()
                            #   EXIT WHILE
                            #END IF
                   END FOR
                   CALL g_psca18_d.clear()
                   #mod--161109-00085#12 By 08993--(s)
                   #LET l_sql18 = "SELECT * FROM ws_tmp ",
                   LET l_sql18 = "SELECT psca001,ecaa001 FROM ws_tmp ",
                   #mod--161109-00085#12 By 08993--(e)
                                 " WHERE ",g_wc18 
                   PREPARE apsq102_tmp_wc18_pre FROM l_sql18
                   DECLARE apsq102_tmp_wc18_curs CURSOR FOR apsq102_tmp_wc18_pre
                   #mod--161109-00085#12 By 08993--(s)
                   #FOREACH apsq102_tmp_wc18_curs INTO g_psca18_d[l_ac].*
                   FOREACH apsq102_tmp_wc18_curs 
                   INTO g_psca18_d[l_ac].psca001,g_psca18_d[l_ac].l_ecaa001
                   #mod--161109-00085#12 By 08993--(e)
                      LET l_ac = l_ac + 1
                      IF SQLCA.sqlcode THEN
                         INITIALIZE g_errparam TO NULL 
                         LET g_errparam.extend = "FOREACH:" 
                         LET g_errparam.code   = SQLCA.sqlcode 
                         LET g_errparam.popup  = TRUE 
                         CALL cl_err()
                         
                         EXIT FOREACH
                      END IF
                   END FOREACH
                   CALL g_psca18_d.deleteElement(g_psca18_d.getLength())
                   LET g_tot_cnt = g_psca18_d.getLength()
                END IF
               
           WHEN l_specification[1].l_name = "Shrinkage_Range.txt"
                IF g_wc19 <> " 1=1" THEN
                   LET l_ac = 1
                   FOR l_d= 1 to l_c
                            #mod--161109-00085#12 By 08993--(s)
#                            INSERT INTO s_r_tmp VALUES (g_psca19_d[l_d].*)   #mark--161109-00085#12 By 08993--(s)
                            INSERT INTO s_r_tmp (psca001,bmbb001,bmbb003,seq,seq1,bmbb009,bmbb010,shrinkage_1,bmbb011,bmbb012)
                                         VALUES (g_psca19_d[l_d].psca001,g_psca19_d[l_d].l_bmbb001,g_psca19_d[l_d].l_bmbb003,
                                                 g_psca19_d[l_d].l_seq,g_psca19_d[l_d].l_seq1,g_psca19_d[l_d].l_bmbb009,
                                                 g_psca19_d[l_d].l_bmbb010,g_psca19_d[l_d].l_shrinkage_1,g_psca19_d[l_d].l_bmbb011,
                                                 g_psca19_d[l_d].l_bmbb012) 
                            #mod--161109-00085#12 By 08993--(e)
                            #IF SQLCA.sqlcode OR SQLCA.sqlerrd[3] = 0 THEN
                            #   INITIALIZE g_errparam TO NULL
                            #   LET g_errparam.extend = 'ins shrinkage_range',g_psca19_d[l_d].l_bmbb001
                            #   LET g_errparam.code   = SQLCA.sqlcode
                            #   LET g_errparam.popup  = TRUE
                            #   CALL cl_err()
                            #   EXIT WHILE
                            #END IF
                   END FOR
                   CALL g_psca19_d.clear()
                   #mod--161109-00085#12 By 08993--(s)
                   #LET l_sql19 = "SELECT * FROM s_r_tmp ",
                   LET l_sql19 = "SELECT psca001,bmbb001,bmbb003,seq,seq1,bmbb009,bmbb010,shrinkage_1,bmbb011,bmbb012 
                                    FROM s_r_tmp ",
                   #mod--161109-00085#12 By 08993--(e)
                                 " WHERE ",g_wc19 
                   PREPARE apsq102_tmp_wc19_pre FROM l_sql19
                   DECLARE apsq102_tmp_wc19_curs CURSOR FOR apsq102_tmp_wc19_pre
                   #mod--161109-00085#12 By 08993--(s)
                   #FOREACH apsq102_tmp_wc19_curs INTO g_psca19_d[l_ac].*
                   FOREACH apsq102_tmp_wc19_curs 
                   INTO g_psca19_d[l_ac].psca001,g_psca19_d[l_ac].l_bmbb001,g_psca19_d[l_ac].l_bmbb003,
                        g_psca19_d[l_ac].l_seq,g_psca19_d[l_ac].l_seq1,g_psca19_d[l_ac].l_bmbb009,
                        g_psca19_d[l_ac].l_bmbb010,g_psca19_d[l_ac].l_shrinkage_1,g_psca19_d[l_ac].l_bmbb011,
                        g_psca19_d[l_ac].l_bmbb012
                   #mod--161109-00085#12 By 08993--(e)
                      LET l_ac = l_ac + 1
                      IF SQLCA.sqlcode THEN
                         INITIALIZE g_errparam TO NULL 
                         LET g_errparam.extend = "FOREACH:" 
                         LET g_errparam.code   = SQLCA.sqlcode 
                         LET g_errparam.popup  = TRUE 
                         CALL cl_err()
                         
                         EXIT FOREACH
                      END IF
                   END FOREACH
                   CALL g_psca19_d.deleteElement(g_psca19_d.getLength())
                   LET g_tot_cnt = g_psca19_d.getLength()
                END IF
               
           WHEN l_specification[1].l_name = "OMP_Suggest_Mfg_Order.txt"
                IF g_wc20 <> " 1=1" THEN
                   LET l_ac = 1
                   FOR l_d= 1 to l_c
                            #mod--161109-00085#12 By 08993--(s)
#                            INSERT INTO o_s_m_o_tmp VALUES (g_psca20_d[l_d].*)   #mark--161109-00085#12 By 08993--(s)
                            INSERT INTO o_s_m_o_tmp (psca001,psoa003,psoa004,psoa005,psoa006,psoa007,psoa008,psoa009,psoa010,
                                                     psoa011,psoa012,psoa013,psoa014,psoa015,psoa016,psoa017,psoa018,psoa019,
                                                     psoa020,psoa021,psoa022,psoa023)
                                             VALUES (g_psca20_d[l_d].psca001,g_psca20_d[l_d].l_psoa003,g_psca20_d[l_d].l_psoa004,
                                                     g_psca20_d[l_d].l_psoa005,g_psca20_d[l_d].l_psoa006,g_psca20_d[l_d].l_psoa007,
                                                     g_psca20_d[l_d].l_psoa008,g_psca20_d[l_d].l_psoa009,g_psca20_d[l_d].l_psoa010,
                                                     g_psca20_d[l_d].l_psoa011,g_psca20_d[l_d].l_psoa012,g_psca20_d[l_d].l_psoa013,
                                                     g_psca20_d[l_d].l_psoa014,g_psca20_d[l_d].l_psoa015,g_psca20_d[l_d].l_psoa016,
                                                     g_psca20_d[l_d].l_psoa017,g_psca20_d[l_d].l_psoa018,g_psca20_d[l_d].l_psoa019,
                                                     g_psca20_d[l_d].l_psoa020,g_psca20_d[l_d].l_psoa021,g_psca20_d[l_d].l_psoa022,
                                                     g_psca20_d[l_d].l_psoa023)
                            #mod--161109-00085#12 By 08993--(e)
                            #IF SQLCA.sqlcode OR SQLCA.sqlerrd[3] = 0 THEN
                            #   INITIALIZE g_errparam TO NULL
                            #   LET g_errparam.extend = 'ins omp_suggest_mfg_order',g_psca20_d[l_d].l_psoa003
                            #   LET g_errparam.code   = SQLCA.sqlcode
                            #   LET g_errparam.popup  = TRUE
                            #   CALL cl_err()
                            #   EXIT WHILE
                            #END IF
                   END FOR
                   CALL g_psca20_d.clear()
                   #mod--161109-00085#12 By 08993--(s)
                   #LET l_sql20 = "SELECT * FROM o_s_m_o_tmp ",
                   LET l_sql20 = "SELECT psca001,psoa003,psoa004,psoa005,psoa006,psoa007,psoa008,psoa009,psoa010,
                                         psoa011,psoa012,psoa013,psoa014,psoa015,psoa016,psoa017,psoa018,psoa019,
                                         psoa020,psoa021,psoa022,psoa023 
                                    FROM o_s_m_o_tmp ",
                   #mod--161109-00085#12 By 08993--(e)
                                 " WHERE ",g_wc20 
                   PREPARE apsq102_tmp_wc20_pre FROM l_sql20
                   DECLARE apsq102_tmp_wc20_curs CURSOR FOR apsq102_tmp_wc20_pre
                   #mod--161109-00085#12 By 08993--(s)
                   #FOREACH apsq102_tmp_wc20_curs INTO g_psca20_d[l_ac].*
                   FOREACH apsq102_tmp_wc20_curs 
                   INTO g_psca20_d[l_ac].psca001,g_psca20_d[l_ac].l_psoa003,g_psca20_d[l_ac].l_psoa004,
                        g_psca20_d[l_ac].l_psoa005,g_psca20_d[l_ac].l_psoa006,g_psca20_d[l_ac].l_psoa007,
                        g_psca20_d[l_ac].l_psoa008,g_psca20_d[l_ac].l_psoa009,g_psca20_d[l_ac].l_psoa010,
                        g_psca20_d[l_ac].l_psoa011,g_psca20_d[l_ac].l_psoa012,g_psca20_d[l_ac].l_psoa013,
                        g_psca20_d[l_ac].l_psoa014,g_psca20_d[l_ac].l_psoa015,g_psca20_d[l_ac].l_psoa016,
                        g_psca20_d[l_ac].l_psoa017,g_psca20_d[l_ac].l_psoa018,g_psca20_d[l_ac].l_psoa019,
                        g_psca20_d[l_ac].l_psoa020,g_psca20_d[l_ac].l_psoa021,g_psca20_d[l_ac].l_psoa022,
                        g_psca20_d[l_ac].l_psoa023
                   #mod--161109-00085#12 By 08993--(e)
                      LET l_ac = l_ac + 1
                      IF SQLCA.sqlcode THEN
                         INITIALIZE g_errparam TO NULL 
                         LET g_errparam.extend = "FOREACH:" 
                         LET g_errparam.code   = SQLCA.sqlcode 
                         LET g_errparam.popup  = TRUE 
                         CALL cl_err()
                         
                         EXIT FOREACH
                      END IF
                   END FOREACH
                   CALL g_psca20_d.deleteElement(g_psca20_d.getLength())
                   LET g_tot_cnt = g_psca20_d.getLength()
                END IF
               
      END CASE      
     #160107-00020#1 ---add (E)---
	END WHILE
	
  #160107-00020#1 ---add (S)---
	LET l_sql = "SELECT psca002 FROM psca_t",
               " WHERE psca001 = '",g_master.psca001,"'"
   PREPARE q102_check_CP FROM l_sql
   EXECUTE q102_check_CP INTO l_psca002
   IF l_psca002 = '2' THEN
	   #指定路徑   
      LET lc_end_file_1 = ''
      LET l_file_1  = g_enterprise,'_',g_site,'_',g_master.psca001,'_',g_master.psea002,'/','ezCP','/','import','/','spec','/','Specification.txt'
      LET l_file_1  = l_file_1.trim()
      LET lc_end_file_1 = os.Path.join(FGL_GETENV("APSLOG"),l_file_1)
      
      # 將一行一行讀出來執行
	   LET lc_createtb_1 = base.Channel.create()
	   CALL lc_createtb_1.openFile(lc_end_file_1,"r") #lc_end_file_1 txt 路徑(含檔名)
	   
	   WHILE lc_createtb_1.read(ls_alt_result_1) #ls_alt_result 儲存每行讀出的字串
       
         LET tok = base.StringTokenizer.create(ls_alt_result_1,',') #將文件的內容(一行)已,做區隔
        
         LET l_a_1 = 0
      
         CALL l_specification.clear() 
      
         WHILE tok.hasMoreTokens()
            LET l_a_1 = l_a_1 + 1
            LET l_specification[l_a_1].l_name = tok.nextToken() 
         
          END WHILE     
      
         LET lc_end_file_1 = ''
         LET l_file_1  = g_enterprise,'_',g_site,'_',g_master.psca001,'_',g_master.psea002,'/','ezCP','/','import','/'
         LET l_file_1  = l_file_1,l_specification[1].l_name #要用變數
         LET l_file_1  = l_file_1.trim()
         
         LET lc_end_file_1 = os.Path.join(FGL_GETENV("APSLOG"),l_file_1)
         
         # 將一行一行讀出來執行
       	LET lc_createtb1_1 = base.Channel.create()
         CALL lc_createtb1_1.openFile(lc_end_file_1,"r") #lc_end_file txt 路徑(含檔名)
         LET l_c_1 = 1 #要塞到畫面的筆數
         WHILE lc_createtb1_1.read(ls_alt_result) #ls_alt_result 儲存每行讀出的字串 #進到實際要抓取資料的TXT檔案
       
              LET l_str = ASCII 11   #^K的符號
              LET l_str1 = ' ',l_str #用來將空字串加上空白
              LET ls_alt_result = cl_str_replace(ls_alt_result, l_str, l_str1) #取代，後續遇到空白欄位才能順利擷取
              LET tok = base.StringTokenizer.create(ls_alt_result,l_str) #將文件的內容(一行)
            
              
              LET l_b_1 = 3  #因文件第3個值開始才是欄位
             
              WHILE tok.hasMoreTokens()  #抓取每一行的分隔
                 
                 LET l_str = ' '     #先將資料清空，以防舊值殘留
                 LET l_str = tok.nextToken()
                 IF NOT cl_null(l_str) THEN LET l_str = l_str.trim() END IF
                 CASE WHEN l_specification[1].l_name = "OMP_Demand_Order.txt"
                          CALL apsq102_omp_demand_order(l_str,l_c_1,l_specification[l_b_1].l_name)
                          
                      WHEN l_specification[1].l_name = "OMP_Suggest_Purchase_Order.txt"
                          CALL apsq102_omp_suggest_purchase_order(l_str,l_c_1,l_specification[l_b_1].l_name)
                          
                      WHEN l_specification[1].l_name = "OMP_Suggest_Mfg_Order.txt"
                          CALL apsq102_omp_suggest_mfg_order1(l_str,l_c_1,l_specification[l_b_1].l_name)
                          
                      WHEN l_specification[1].l_name = "Material_Release.txt"
                          CALL apsq102_material_release1(l_str,l_c_1,l_specification[l_b_1].l_name)
                          
                      WHEN l_specification[1].l_name = "OMP_MOPeg.txt"
                          CALL apsq102_omp_mopeg(l_str,l_c_1,l_specification[l_b_1].l_name)
                          
                      WHEN l_specification[1].l_name = "OMP_Equipment.txt"
                          CALL apsq102_omp_equipment(l_str,l_c_1,l_specification[l_b_1].l_name)
                          
                      WHEN l_specification[1].l_name = "Equipment_Group.txt"
                          CALL apsq102_equipment_group(l_str,l_c_1,l_specification[l_b_1].l_name)
                          
                      WHEN l_specification[1].l_name = "OMP_Daycaln.txt"
                          CALL apsq102_omp_daycaln(l_str,l_c_1,l_specification[l_b_1].l_name)
                          
                      WHEN l_specification[1].l_name = "OMP_Weekcaln.txt"
                          CALL apsq102_omp_weekcaln(l_str,l_c_1,l_specification[l_b_1].l_name)
                          
                      WHEN l_specification[1].l_name = "OMP_Work_Model.txt"
                          CALL apsq102_omp_work_model(l_str,l_c_1,l_specification[l_b_1].l_name)
                          
                      WHEN l_specification[1].l_name = "Item_Masters.txt"
                          CALL apsq102_item_masters1(l_str,l_c_1,l_specification[l_b_1].l_name)
                          
                      WHEN l_specification[1].l_name = "BOM_Throw_Point.txt"
                          CALL apsq102_bom_throw_point(l_str,l_c_1,l_specification[l_b_1].l_name)
                          
                      WHEN l_specification[1].l_name = "Item_Route.txt"
                          CALL apsq102_item_route(l_str,l_c_1,l_specification[l_b_1].l_name)
                          
                      WHEN l_specification[1].l_name = "Route.txt"
                          CALL apsq102_route(l_str,l_c_1,l_specification[l_b_1].l_name)
                          
                      WHEN l_specification[1].l_name = "WS.txt"
                          CALL apsq102_ws1(l_str,l_c_1,l_specification[l_b_1].l_name)
                          
                      WHEN l_specification[1].l_name = "Route_Relation.txt"
                          CALL apsq102_route_relation(l_str,l_c_1,l_specification[l_b_1].l_name)
                       
                 END CASE    
                     
                 LET l_b_1 = l_b_1 + 1       
              END WHILE 
      
              LET l_c_1 = l_c_1 + 1
         END WHILE
         CASE WHEN l_specification[1].l_name = "OMP_Demand_Order.txt"
                   IF g_wc21 <> " 1=1" THEN
                      LET l_ac = 1
                      FOR l_d_1= 1 to l_c_1
                               #mod--161109-00085#12 By 08993--(s)
#                               INSERT INTO o_d_o_tmp VALUES (g_psca21_d[l_d_1].*)   #mark--161109-00085#12 By 08993--(s)
                               INSERT INTO o_d_o_tmp (psca001,psod003,psod004,psod005,psod006,psod007,psod008,psod009,
                                                      psod010,psod011,psod012,psod013,psod014,psod015,psod016,psod017)
                                              VALUES (g_psca21_d[l_d_1].psca001,g_psca21_d[l_d_1].l_psod003,g_psca21_d[l_d_1].l_psod004,
                                                      g_psca21_d[l_d_1].l_psod005,g_psca21_d[l_d_1].l_psod006,g_psca21_d[l_d_1].l_psod007,
                                                      g_psca21_d[l_d_1].l_psod008,g_psca21_d[l_d_1].l_psod009,g_psca21_d[l_d_1].l_psod010,
                                                      g_psca21_d[l_d_1].l_psod011,g_psca21_d[l_d_1].l_psod012,g_psca21_d[l_d_1].l_psod013,
                                                      g_psca21_d[l_d_1].l_psod014,g_psca21_d[l_d_1].l_psod015,g_psca21_d[l_d_1].l_psod016,
                                                      g_psca21_d[l_d_1].l_psod017)
                               #mod--161109-00085#12 By 08993--(e)
                               #IF SQLCA.sqlcode OR SQLCA.sqlerrd[3] = 0 THEN
                               #   INITIALIZE g_errparam TO NULL
                               #   LET g_errparam.extend = 'ins omp_demand_order',g_psca21_d[l_d].l_psod003
                               #   LET g_errparam.code   = SQLCA.sqlcode
                               #   LET g_errparam.popup  = TRUE
                               #   CALL cl_err()
                               #   EXIT WHILE
                               #END IF
                      END FOR
                      CALL g_psca21_d.clear()
                      #mod--161109-00085#12 By 08993--(s)
                      #LET l_sql21 = "SELECT * FROM o_d_o_tmp ",
                      LET l_sql21 = "SELECT psca001,psod003,psod004,psod005,psod006,psod007,psod008,psod009,
                                            psod010,psod011,psod012,psod013,psod014,psod015,psod016,psod017 
                                       FROM o_d_o_tmp ",
                      #mod--161109-00085#12 By 08993--(e)
                                    " WHERE ",g_wc21 
                      PREPARE apsq102_tmp_wc21_pre FROM l_sql21
                      DECLARE apsq102_tmp_wc21_curs CURSOR FOR apsq102_tmp_wc21_pre
                      #mod--161109-00085#12 By 08993--(s)
                      #FOREACH apsq102_tmp_wc21_curs INTO g_psca21_d[l_ac].*
                      FOREACH apsq102_tmp_wc21_curs 
                      INTO g_psca21_d[l_ac].psca001,g_psca21_d[l_ac].l_psod003,g_psca21_d[l_ac].l_psod004,
                           g_psca21_d[l_ac].l_psod005,g_psca21_d[l_ac].l_psod006,g_psca21_d[l_ac].l_psod007,
                           g_psca21_d[l_ac].l_psod008,g_psca21_d[l_ac].l_psod009,g_psca21_d[l_ac].l_psod010,
                           g_psca21_d[l_ac].l_psod011,g_psca21_d[l_ac].l_psod012,g_psca21_d[l_ac].l_psod013,
                           g_psca21_d[l_ac].l_psod014,g_psca21_d[l_ac].l_psod015,g_psca21_d[l_ac].l_psod016,
                           g_psca21_d[l_ac].l_psod017
                      #mod--161109-00085#12 By 08993--(e)
                         LET l_ac = l_ac + 1
                         IF SQLCA.sqlcode THEN
                            INITIALIZE g_errparam TO NULL 
                            LET g_errparam.extend = "FOREACH:" 
                            LET g_errparam.code   = SQLCA.sqlcode 
                            LET g_errparam.popup  = TRUE 
                            CALL cl_err()
                            
                            EXIT FOREACH
                         END IF
                      END FOREACH
                      CALL g_psca21_d.deleteElement(g_psca21_d.getLength())
                      LET g_tot_cnt = g_psca21_d.getLength()
                   END IF  
                     
              WHEN l_specification[1].l_name = "OMP_Suggest_Purchase_Order.txt"
                   IF g_wc22 <> " 1=1" THEN
                      LET l_ac = 1
                      FOR l_d_1= 1 to l_c_1
                               #mod--161109-00085#12 By 08993--(s)
#                               INSERT INTO o_s_p_o_tmp VALUES (g_psca22_d[l_d_1].*)   #mark--161109-00085#12 By 08993--(s)
                               INSERT INTO o_s_p_o_tmp (psca001,psoc003,psoc004,psoc005,psoc006,psoc007,psoc008_1,
                                                        psoc009,psoc010,psoc011,psoc012,psoc013,psoc014,psoc015,psoc016,
                                                        psoc017,psoc018,psoc019,psoc020,psoc021,psoc022,psoc023,psoc025,
                                                        psoc022_1,psoc022_2,psoc022_3)
                                                VALUES (g_psca22_d[l_d_1].psca001,g_psca22_d[l_d_1].l_psoc003,g_psca22_d[l_d_1].l_psoc004,
                                                        g_psca22_d[l_d_1].l_psoc005,g_psca22_d[l_d_1].l_psoc006,g_psca22_d[l_d_1].l_psoc007,
                                                        g_psca22_d[l_d_1].l_psoc008_1,g_psca22_d[l_d_1].l_psoc009,g_psca22_d[l_d_1].l_psoc010,
                                                        g_psca22_d[l_d_1].l_psoc011,g_psca22_d[l_d_1].l_psoc012,g_psca22_d[l_d_1].l_psoc013,
                                                        g_psca22_d[l_d_1].l_psoc014,g_psca22_d[l_d_1].l_psoc015,g_psca22_d[l_d_1].l_psoc016,
                                                        g_psca22_d[l_d_1].l_psoc017,g_psca22_d[l_d_1].l_psoc018,g_psca22_d[l_d_1].l_psoc019,
                                                        g_psca22_d[l_d_1].l_psoc020,g_psca22_d[l_d_1].l_psoc021,g_psca22_d[l_d_1].l_psoc022,
                                                        g_psca22_d[l_d_1].l_psoc023,g_psca22_d[l_d_1].l_psoc025,g_psca22_d[l_d_1].l_psoc022_1,
                                                        g_psca22_d[l_d_1].l_psoc022_2,g_psca22_d[l_d_1].l_psoc022_3)
                               #mod--161109-00085#12 By 08993--(e)
                               #IF SQLCA.sqlcode OR SQLCA.sqlerrd[3] = 0 THEN
                               #   INITIALIZE g_errparam TO NULL
                               #   LET g_errparam.extend = 'ins omp_suggest_purchase_order',g_psca22_d[l_d].l_psoc003
                               #   LET g_errparam.code   = SQLCA.sqlcode
                               #   LET g_errparam.popup  = TRUE
                               #   CALL cl_err()
                               #   EXIT WHILE
                               #END IF
                      END FOR
                      CALL g_psca22_d.clear()
                      #mod--161109-00085#12 By 08993--(s)
                      #LET l_sql22 = "SELECT * FROM o_s_p_o_tmp ",
                      LET l_sql22 = "SELECT psca001,psoc003,psoc004,psoc005,psoc006,psoc007,psoc008_1,
                                            psoc009,psoc010,psoc011,psoc012,psoc013,psoc014,psoc015,psoc016,
                                            psoc017,psoc018,psoc019,psoc020,psoc021,psoc022,psoc023,psoc025,
                                            psoc022_1,psoc022_2,psoc022_3 
                                       FROM o_s_p_o_tmp ",
                      #mod--161109-00085#12 By 08993--(e)
                                    " WHERE ",g_wc22 
                      PREPARE apsq102_tmp_wc22_pre FROM l_sql22
                      DECLARE apsq102_tmp_wc22_curs CURSOR FOR apsq102_tmp_wc22_pre
                      #mod--161109-00085#12 By 08993--(s)
                      #FOREACH apsq102_tmp_wc22_curs INTO g_psca22_d[l_ac].*
                      FOREACH apsq102_tmp_wc22_curs 
                      INTO g_psca22_d[l_ac].psca001,g_psca22_d[l_ac].l_psoc003,g_psca22_d[l_ac].l_psoc004,
                           g_psca22_d[l_ac].l_psoc005,g_psca22_d[l_ac].l_psoc006,g_psca22_d[l_ac].l_psoc007,
                           g_psca22_d[l_ac].l_psoc008_1,g_psca22_d[l_ac].l_psoc009,g_psca22_d[l_ac].l_psoc010,
                           g_psca22_d[l_ac].l_psoc011,g_psca22_d[l_ac].l_psoc012,g_psca22_d[l_ac].l_psoc013,
                           g_psca22_d[l_ac].l_psoc014,g_psca22_d[l_ac].l_psoc015,g_psca22_d[l_ac].l_psoc016,
                           g_psca22_d[l_ac].l_psoc017,g_psca22_d[l_ac].l_psoc018,g_psca22_d[l_ac].l_psoc019,
                           g_psca22_d[l_ac].l_psoc020,g_psca22_d[l_ac].l_psoc021,g_psca22_d[l_ac].l_psoc022,
                           g_psca22_d[l_ac].l_psoc023,g_psca22_d[l_ac].l_psoc025,g_psca22_d[l_ac].l_psoc022_1,
                           g_psca22_d[l_ac].l_psoc022_2,g_psca22_d[l_ac].l_psoc022_3
                      #mod--161109-00085#12 By 08993--(e)
                         LET l_ac = l_ac + 1
                         IF SQLCA.sqlcode THEN
                            INITIALIZE g_errparam TO NULL 
                            LET g_errparam.extend = "FOREACH:" 
                            LET g_errparam.code   = SQLCA.sqlcode 
                            LET g_errparam.popup  = TRUE 
                            CALL cl_err()
                            
                            EXIT FOREACH
                         END IF
                      END FOREACH
                      CALL g_psca22_d.deleteElement(g_psca22_d.getLength())
                      LET g_tot_cnt = g_psca22_d.getLength()
                   END IF  
                  
              WHEN l_specification[1].l_name = "OMP_Suggest_Mfg_Order.txt"
                   IF g_wc23 <> " 1=1" THEN
                      LET l_ac = 1
                      FOR l_d_1= 1 to l_c_1
                               #mod--161109-00085#12 By 08993--(s)
#                               INSERT INTO o_s_m_o_tmp VALUES (g_psca23_d[l_d_1].*)    #mark--161109-00085#12 By 08993--(s)
                               INSERT INTO o_s_m_o_tmp (psca001,psoa003,psoa004,psoa005,psoa006,psoa007,psoa008,psoa009,psoa010,
                                                        psoa011,psoa012,psoa013,psoa014,psoa015,psoa016,psoa017,psoa018,psoa019,
                                                        psoa020,psoa021,psoa023)
                                                VALUES (g_psca23_d[l_d_1].psca001,g_psca23_d[l_d_1].l_psoa003_1,g_psca23_d[l_d_1].l_psoa004_1,
                                                        g_psca23_d[l_d_1].l_psoa005_1,g_psca23_d[l_d_1].l_psoa006_1,g_psca23_d[l_d_1].l_psoa007_1,
                                                        g_psca23_d[l_d_1].l_psoa008_1,g_psca23_d[l_d_1].l_psoa009_1,g_psca23_d[l_d_1].l_psoa010_1,
                                                        g_psca23_d[l_d_1].l_psoa011_1,g_psca23_d[l_d_1].l_psoa012_1,g_psca23_d[l_d_1].l_psoa013_1,
                                                        g_psca23_d[l_d_1].l_psoa014_1,g_psca23_d[l_d_1].l_psoa015_1,g_psca23_d[l_d_1].l_psoa016_1,
                                                        g_psca23_d[l_d_1].l_psoa017_1,g_psca23_d[l_d_1].l_psoa018_1,g_psca23_d[l_d_1].l_psoa019_1,
                                                        g_psca23_d[l_d_1].l_psoa020_1,g_psca23_d[l_d_1].l_psoa021_1,g_psca23_d[l_d_1].l_psoa023_1)
                               #mod--161109-00085#12 By 08993--(e)
                               #IF SQLCA.sqlcode OR SQLCA.sqlerrd[3] = 0 THEN
                               #   INITIALIZE g_errparam TO NULL
                               #   LET g_errparam.extend = 'ins omp_suggest_mfg_order',g_psca23_d[l_d].l_psoa003
                               #   LET g_errparam.code   = SQLCA.sqlcode
                               #   LET g_errparam.popup  = TRUE
                               #   CALL cl_err()
                               #   EXIT WHILE
                               #END IF
                      END FOR
                      CALL g_psca23_d.clear()
                      #mod--161109-00085#12 By 08993--(s)
                      #LET l_sql23 = "SELECT * FROM o_s_m_o_tmp ",
                      LET l_sql23 = "SELECT psca001,psoa003,psoa004,psoa005,psoa006,psoa007,psoa008,psoa009,psoa010,
                                            psoa011,psoa012,psoa013,psoa014,psoa015,psoa016,psoa017,psoa018,psoa019,
                                            psoa020,psoa021,psoa022,psoa023 
                                       FROM o_s_m_o_tmp ",
                      #mod--161109-00085#12 By 08993--(e)
                                    " WHERE ",g_wc23 
                      PREPARE apsq102_tmp_wc23_pre FROM l_sql23
                      DECLARE apsq102_tmp_wc23_curs CURSOR FOR apsq102_tmp_wc23_pre
                      #mod--161109-00085#12 By 08993--(s)
                      #FOREACH apsq102_tmp_wc23_curs INTO g_psca23_d[l_ac].*
                      FOREACH apsq102_tmp_wc23_curs 
                      INTO g_psca23_d[l_ac].psca001,g_psca23_d[l_ac].l_psoa003_1,g_psca23_d[l_ac].l_psoa004_1,
                           g_psca23_d[l_ac].l_psoa005_1,g_psca23_d[l_ac].l_psoa006_1,g_psca23_d[l_ac].l_psoa007_1,
                           g_psca23_d[l_ac].l_psoa008_1,g_psca23_d[l_ac].l_psoa009_1,g_psca23_d[l_ac].l_psoa010_1,
                           g_psca23_d[l_ac].l_psoa011_1,g_psca23_d[l_ac].l_psoa012_1,g_psca23_d[l_ac].l_psoa013_1,
                           g_psca23_d[l_ac].l_psoa014_1,g_psca23_d[l_ac].l_psoa015_1,g_psca23_d[l_ac].l_psoa016_1,
                           g_psca23_d[l_ac].l_psoa017_1,g_psca23_d[l_ac].l_psoa018_1,g_psca23_d[l_ac].l_psoa019_1,
                           g_psca23_d[l_ac].l_psoa020_1,g_psca23_d[l_ac].l_psoa021_1,g_psca23_d[l_ac].l_psoa023_1
                      #mod--161109-00085#12 By 08993--(e)
                         LET l_ac = l_ac + 1
                         IF SQLCA.sqlcode THEN
                            INITIALIZE g_errparam TO NULL 
                            LET g_errparam.extend = "FOREACH:" 
                            LET g_errparam.code   = SQLCA.sqlcode 
                            LET g_errparam.popup  = TRUE 
                            CALL cl_err()
                            
                            EXIT FOREACH
                         END IF
                      END FOREACH
                      CALL g_psca23_d.deleteElement(g_psca23_d.getLength())
                      LET g_tot_cnt = g_psca23_d.getLength()
                   END IF
                  
              WHEN l_specification[1].l_name = "Material_Release.txt"
                   IF g_wc24 <> " 1=1" THEN
                      LET l_ac = 1
                      FOR l_d_1= 1 to l_c_1
                               #mod--161109-00085#12 By 08993--(s)
#                               INSERT INTO m_r1_tmp VALUES (g_psca24_d[l_d_1].*)   #mark--161109-00085#12 By 08993--(s)
                               INSERT INTO m_r1_tmp (psca001,sfbadocno_1,sfba006_1,sfbaseq_2,sfbaseq_1_1,release_2,sfba019_1,
                                                     demand_1,sfba020_1,sfba028_1,sfba003_1,sfba009_1,sfba007_1,sfaa003_1,sfba021_1  )
                                             VALUES (g_psca24_d[l_d_1].psca001,g_psca24_d[l_d_1].l_sfbadocno_1,g_psca24_d[l_d_1].l_sfba006_1,
                                                     g_psca24_d[l_d_1].l_sfbaseq_2,g_psca24_d[l_d_1].l_sfbaseq_1_1,g_psca24_d[l_d_1].l_release_2,
                                                     g_psca24_d[l_d_1].l_sfba019_1,g_psca24_d[l_d_1].l_demand_1,g_psca24_d[l_d_1].l_sfba020_1,
                                                     g_psca24_d[l_d_1].l_sfba028_1,g_psca24_d[l_d_1].l_sfba003_1,g_psca24_d[l_d_1].l_sfba009_1,
                                                     g_psca24_d[l_d_1].l_sfba007_1,g_psca24_d[l_d_1].l_sfaa003_1,g_psca24_d[l_d_1].l_sfba021_1)
                               #mod--161109-00085#12 By 08993--(e)
                               #IF SQLCA.sqlcode OR SQLCA.sqlerrd[3] = 0 THEN
                               #   INITIALIZE g_errparam TO NULL
                               #   LET g_errparam.extend = 'ins material_release',g_psca24_d[l_d].l_sfbadocno
                               #   LET g_errparam.code   = SQLCA.sqlcode
                               #   LET g_errparam.popup  = TRUE
                               #   CALL cl_err()
                               #   EXIT WHILE
                               #END IF
                      END FOR
                      CALL g_psca24_d.clear()
                      #mod--161109-00085#12 By 08993--(s)
                      #LET l_sql24 = "SELECT * FROM m_r1_tmp ",
                      LET l_sql24 = "SELECT psca001,sfbadocno_1,sfba006_1,sfbaseq_2,sfbaseq_1_1,release_2,sfba019_1,
                                            demand_1,sfba020_1,sfba028_1,sfba003_1,sfba009_1,sfba007_1,sfaa003_1,sfba021_1 
                                       FROM m_r1_tmp ",
                      #mod--161109-00085#12 By 08993--(e)
                                    " WHERE ",g_wc24 
                      PREPARE apsq102_tmp_wc24_pre FROM l_sql24
                      DECLARE apsq102_tmp_wc24_curs CURSOR FOR apsq102_tmp_wc24_pre
                      #mod--161109-00085#12 By 08993--(s)
                      #FOREACH apsq102_tmp_wc24_curs INTO g_psca24_d[l_ac].*
                      FOREACH apsq102_tmp_wc24_curs 
                      INTO g_psca24_d[l_ac].psca001,g_psca24_d[l_ac].l_sfbadocno_1,g_psca24_d[l_ac].l_sfba006_1,
                           g_psca24_d[l_ac].l_sfbaseq_2,g_psca24_d[l_ac].l_sfbaseq_1_1,g_psca24_d[l_ac].l_release_2,
                           g_psca24_d[l_ac].l_sfba019_1,g_psca24_d[l_ac].l_demand_1,g_psca24_d[l_ac].l_sfba020_1,
                           g_psca24_d[l_ac].l_sfba028_1,g_psca24_d[l_ac].l_sfba003_1,g_psca24_d[l_ac].l_sfba009_1,
                           g_psca24_d[l_ac].l_sfba007_1,g_psca24_d[l_ac].l_sfaa003_1,g_psca24_d[l_ac].l_sfba021_1
                      #mod--161109-00085#12 By 08993--(e)
                         LET l_ac = l_ac + 1
                         IF SQLCA.sqlcode THEN
                            INITIALIZE g_errparam TO NULL 
                            LET g_errparam.extend = "FOREACH:" 
                            LET g_errparam.code   = SQLCA.sqlcode 
                            LET g_errparam.popup  = TRUE 
                            CALL cl_err()
                            
                            EXIT FOREACH
                         END IF
                      END FOREACH
                      CALL g_psca24_d.deleteElement(g_psca24_d.getLength())
                      LET g_tot_cnt = g_psca24_d.getLength()
                   END IF
                  
              WHEN l_specification[1].l_name = "OMP_MOPeg.txt"
                   IF g_wc25 <> " 1=1" THEN
                      LET l_ac = 1
                      FOR l_d_1= 1 to l_c_1
                               #mod--161109-00085#12 By 08993--(s)
#                               INSERT INTO omp_mopeg_tmp VALUES (g_psca25_d[l_d_1].*)   #mark--161109-00085#12 By 08993--(s)
                               INSERT INTO omp_mopeg_tmp (psca001,psob003,psob004,psob005,psob006,psob007,psob008,
                                                          psob009,psob010,psob011,psob012,psob013,psob016)
                                                  VALUES (g_psca25_d[l_d_1].psca001,g_psca25_d[l_d_1].l_psob003,g_psca25_d[l_d_1].l_psob004,
                                                          g_psca25_d[l_d_1].l_psob005,g_psca25_d[l_d_1].l_psob006,g_psca25_d[l_d_1].l_psob007,
                                                          g_psca25_d[l_d_1].l_psob008,g_psca25_d[l_d_1].l_psob009,g_psca25_d[l_d_1].l_psob010,
                                                          g_psca25_d[l_d_1].l_psob011,g_psca25_d[l_d_1].l_psob012,g_psca25_d[l_d_1].l_psob013,
                                                          g_psca25_d[l_d_1].l_psob016)
                               #mod--161109-00085#12 By 08993--(e)
                               #IF SQLCA.sqlcode OR SQLCA.sqlerrd[3] = 0 THEN
                               #   INITIALIZE g_errparam TO NULL
                               #   LET g_errparam.extend = 'ins omp_mopeg',g_psca25_d[l_d].l_psob003
                               #   LET g_errparam.code   = SQLCA.sqlcode
                               #   LET g_errparam.popup  = TRUE
                               #   CALL cl_err()
                               #   EXIT WHILE
                               #END IF
                      END FOR
                      CALL g_psca25_d.clear()
                      #mod--161109-00085#12 By 08993--(s)
                      #LET l_sql25 = "SELECT * FROM omp_mopeg_tmp ",
                      LET l_sql25 = "SELECT psca001,psob003,psob004,psob005,psob006,psob007,psob008,
                                            psob009,psob010,psob011,psob012,psob013,psob016 
                                       FROM omp_mopeg_tmp ",
                      #mod--161109-00085#12 By 08993--(e)
                                    " WHERE ",g_wc25 
                      PREPARE apsq102_tmp_wc25_pre FROM l_sql25
                      DECLARE apsq102_tmp_wc25_curs CURSOR FOR apsq102_tmp_wc25_pre
                      #mod--161109-00085#12 By 08993--(s)
                      #FOREACH apsq102_tmp_wc25_curs INTO g_psca25_d[l_ac].*
                      FOREACH apsq102_tmp_wc25_curs 
                      INTO g_psca25_d[l_ac].psca001,g_psca25_d[l_ac].l_psob003,g_psca25_d[l_ac].l_psob004,
                           g_psca25_d[l_ac].l_psob005,g_psca25_d[l_ac].l_psob006,g_psca25_d[l_ac].l_psob007,
                           g_psca25_d[l_ac].l_psob008,g_psca25_d[l_ac].l_psob009,g_psca25_d[l_ac].l_psob010,
                           g_psca25_d[l_ac].l_psob011,g_psca25_d[l_ac].l_psob012,g_psca25_d[l_ac].l_psob013,
                           g_psca25_d[l_ac].l_psob016
                      #mod--161109-00085#12 By 08993--(e)
                         LET l_ac = l_ac + 1
                         IF SQLCA.sqlcode THEN
                            INITIALIZE g_errparam TO NULL 
                            LET g_errparam.extend = "FOREACH:" 
                            LET g_errparam.code   = SQLCA.sqlcode 
                            LET g_errparam.popup  = TRUE 
                            CALL cl_err()
                            
                            EXIT FOREACH
                         END IF
                      END FOREACH
                      CALL g_psca25_d.deleteElement(g_psca25_d.getLength())
                      LET g_tot_cnt = g_psca25_d.getLength()
                   END IF
                  
              WHEN l_specification[1].l_name = "OMP_Equipment.txt"
                   IF g_wc26 <> " 1=1" THEN
                      LET l_ac = 1
                      FOR l_d_1= 1 to l_c_1
                               #mod--161109-00085#12 By 08993--(s)
#                               INSERT INTO omp_equipment_tmp VALUES (g_psca26_d[l_d_1].*)   #mark--161109-00085#12 By 08993--(s)
                               INSERT INTO omp_equipment_tmp (psca001,equip_type,equip_id,ws_id,efficency,
                                                              capacity_type,day_calendar_id,week_calendar_id) 
                                                      VALUES (g_psca26_d[l_d_1].psca001,g_psca26_d[l_d_1].l_equip_type,
                                                              g_psca26_d[l_d_1].l_equip_id,g_psca26_d[l_d_1].l_ws_id,
                                                              g_psca26_d[l_d_1].l_efficency,g_psca26_d[l_d_1].l_capacity_type,
                                                              g_psca26_d[l_d_1].l_day_calendar_id,g_psca26_d[l_d_1].l_week_calendar_id)
                               #mod--161109-00085#12 By 08993--(e)
                               #IF SQLCA.sqlcode OR SQLCA.sqlerrd[3] = 0 THEN
                               #   INITIALIZE g_errparam TO NULL
                               #   LET g_errparam.extend = 'ins omp_equipment',g_psca26_d[l_d].l_equip_type
                               #   LET g_errparam.code   = SQLCA.sqlcode
                               #   LET g_errparam.popup  = TRUE
                               #   CALL cl_err()
                               #   EXIT WHILE
                               #END IF
                      END FOR
                      CALL g_psca26_d.clear()
                      #mod--161109-00085#12 By 08993--(s)
                      #LET l_sql26 = "SELECT * FROM omp_equipment_tmp ",
                      LET l_sql26 = "SELECT psca001,equip_type,equip_id,ws_id,efficency,
                                            capacity_type,day_calendar_id,week_calendar_id 
                                       FROM omp_equipment_tmp ",
                      #mod--161109-00085#12 By 08993--(e)
                                    " WHERE ",g_wc26 
                      PREPARE apsq102_tmp_wc26_pre FROM l_sql26
                      DECLARE apsq102_tmp_wc26_curs CURSOR FOR apsq102_tmp_wc26_pre
                      #mod--161109-00085#12 By 08993--(s)
                      #FOREACH apsq102_tmp_wc26_curs INTO g_psca26_d[l_ac].*
                      FOREACH apsq102_tmp_wc26_curs 
                      INTO g_psca26_d[l_ac].psca001,g_psca26_d[l_ac].l_equip_type,
                           g_psca26_d[l_ac].l_equip_id,g_psca26_d[l_ac].l_ws_id,
                           g_psca26_d[l_ac].l_efficency,g_psca26_d[l_ac].l_capacity_type,
                           g_psca26_d[l_ac].l_day_calendar_id,g_psca26_d[l_ac].l_week_calendar_id
                      #mod--161109-00085#12 By 08993--(e)
                         LET l_ac = l_ac + 1
                         IF SQLCA.sqlcode THEN
                            INITIALIZE g_errparam TO NULL 
                            LET g_errparam.extend = "FOREACH:" 
                            LET g_errparam.code   = SQLCA.sqlcode 
                            LET g_errparam.popup  = TRUE 
                            CALL cl_err()
                            
                            EXIT FOREACH
                         END IF
                      END FOREACH
                      CALL g_psca26_d.deleteElement(g_psca26_d.getLength())
                      LET g_tot_cnt = g_psca26_d.getLength()
                   END IF
                  
              WHEN l_specification[1].l_name = "Equipment_Group.txt"
                   IF g_wc27 <> " 1=1" THEN
                      LET l_ac = 1
                      FOR l_d_1= 1 to l_c_1
                               #mod--161109-00085#12 By 08993--(s)
#                               INSERT INTO e_g_tmp VALUES (g_psca27_d[l_d_1].*)   #mod--161109-00085#12 By 08993--(s)
                               INSERT INTO e_g_tmp (psca001,equip_group_id,equip_type_1,is_outsourcing,equip_id_1,priority_1)
                                            VALUES (g_psca27_d[l_d_1].psca001,g_psca27_d[l_d_1].l_equip_group_id,
                                                    g_psca27_d[l_d_1].l_equip_type_1,g_psca27_d[l_d_1].l_is_outsourcing,
                                                    g_psca27_d[l_d_1].l_equip_id_1,g_psca27_d[l_d_1].l_priority_1)
                              #mod--161109-00085#12 By 08993--(e)
                               #IF SQLCA.sqlcode OR SQLCA.sqlerrd[3] = 0 THEN
                               #   INITIALIZE g_errparam TO NULL
                               #   LET g_errparam.extend = 'ins equipment_group',g_psca27_d[l_d].l_equit_type_id
                               #   LET g_errparam.code   = SQLCA.sqlcode
                               #   LET g_errparam.popup  = TRUE
                               #   CALL cl_err()
                               #   EXIT WHILE
                               #END IF
                      END FOR
                      CALL g_psca27_d.clear()
                      #mod--161109-00085#12 By 08993--(s)
                      #LET l_sql27 = "SELECT * FROM e_g_tmp ",
                      LET l_sql27 = "SELECT psca001,equip_group_id,equip_type_1,is_outsourcing,equip_id_1,priority_1 
                                       FROM e_g_tmp ",
                      #mod--161109-00085#12 By 08993--(e)
                                    " WHERE ",g_wc27 
                      PREPARE apsq102_tmp_wc27_pre FROM l_sql27
                      DECLARE apsq102_tmp_wc27_curs CURSOR FOR apsq102_tmp_wc27_pre
                      #mod--161109-00085#12 By 08993--(s)
                      #FOREACH apsq102_tmp_wc27_curs INTO g_psca27_d[l_ac].*
                      FOREACH apsq102_tmp_wc27_curs 
                      INTO g_psca27_d[l_ac].psca001,g_psca27_d[l_ac].l_equip_group_id,
                           g_psca27_d[l_ac].l_equip_type_1,g_psca27_d[l_ac].l_is_outsourcing,
                           g_psca27_d[l_ac].l_equip_id_1,g_psca27_d[l_ac].l_priority_1
                      #mod--161109-00085#12 By 08993--(e)
                         LET l_ac = l_ac + 1
                         IF SQLCA.sqlcode THEN
                            INITIALIZE g_errparam TO NULL 
                            LET g_errparam.extend = "FOREACH:" 
                            LET g_errparam.code   = SQLCA.sqlcode 
                            LET g_errparam.popup  = TRUE 
                            CALL cl_err()
                            
                            EXIT FOREACH
                         END IF
                      END FOREACH
                      CALL g_psca27_d.deleteElement(g_psca27_d.getLength())
                      LET g_tot_cnt = g_psca27_d.getLength()
                   END IF
                  
              WHEN l_specification[1].l_name = "OMP_Daycaln.txt"
                   IF g_wc28 <> " 1=1" THEN
                      LET l_ac = 1
                      FOR l_d_1= 1 to l_c_1
                               #mod--161109-00085#12 By 08993--(s)
#                               INSERT INTO omp_daycaln_tmp VALUES (g_psca28_d[l_d_1].*)   #mark--161109-00085#12 By 08993--(s)
                               INSERT INTO omp_daycaln_tmp (psca001,mrbh001_1,mrbh002,mrbh003,mrbh004,mrbh005)
                                                    VALUES (g_psca28_d[l_d_1].psca001,g_psca28_d[l_d_1].l_mrbh001_1,
                                                            g_psca28_d[l_d_1].l_mrbh002,g_psca28_d[l_d_1].l_mrbh003,
                                                            g_psca28_d[l_d_1].l_mrbh004,g_psca28_d[l_d_1].l_mrbh005)
                               #mod--161109-00085#12 By 08993--(e)
                               #IF SQLCA.sqlcode OR SQLCA.sqlerrd[3] = 0 THEN
                               #   INITIALIZE g_errparam TO NULL
                               #   LET g_errparam.extend = 'ins omp_daycaln',g_psca28_d[l_d].l_mrbh001
                               #   LET g_errparam.code   = SQLCA.sqlcode
                               #   LET g_errparam.popup  = TRUE
                               #   CALL cl_err()
                               #   EXIT WHILE
                               #END IF
                      END FOR
                      CALL g_psca28_d.clear()
                      #mod--161109-00085#12 By 08993--(s)
                      #LET l_sql28 = "SELECT * FROM omp_daycaln_tmp ",
                      LET l_sql28 = "SELECT psca001,mrbh001_1,mrbh002,mrbh003,mrbh004,mrbh005 
                                       FROM omp_daycaln_tmp ",
                      #mod--161109-00085#12 By 08993--(e)
                                    " WHERE ",g_wc28 
                      PREPARE apsq102_tmp_wc28_pre FROM l_sql28
                      DECLARE apsq102_tmp_wc28_curs CURSOR FOR apsq102_tmp_wc28_pre
                      #mod--161109-00085#12 By 08993--(s)
                      #FOREACH apsq102_tmp_wc28_curs INTO g_psca28_d[l_ac].*
                      FOREACH apsq102_tmp_wc28_curs 
                      INTO g_psca28_d[l_ac].psca001,g_psca28_d[l_ac].l_mrbh001_1,
                           g_psca28_d[l_ac].l_mrbh002,g_psca28_d[l_ac].l_mrbh003,
                           g_psca28_d[l_ac].l_mrbh004,g_psca28_d[l_ac].l_mrbh005
                      #mod--161109-00085#12 By 08993--(e)
                         LET l_ac = l_ac + 1
                         IF SQLCA.sqlcode THEN
                            INITIALIZE g_errparam TO NULL 
                            LET g_errparam.extend = "FOREACH:" 
                            LET g_errparam.code   = SQLCA.sqlcode 
                            LET g_errparam.popup  = TRUE 
                            CALL cl_err()
                            
                            EXIT FOREACH
                         END IF
                      END FOREACH
                      CALL g_psca28_d.deleteElement(g_psca28_d.getLength())
                      LET g_tot_cnt = g_psca28_d.getLength()
                   END IF
                  
              WHEN l_specification[1].l_name = "OMP_Weekcaln.txt"
                   IF g_wc29 <> " 1=1" THEN
                      LET l_ac = 1
                      FOR l_d_1= 1 to l_c_1
                               #mod--161109-00085#12 By 08993--(s)
#                               INSERT INTO omp_weekcaln_tmp VALUES (g_psca29_d[l_d_1].*)    #mark--161109-00085#12 By 08993--(s)
                               INSERT INTO omp_weekcaln_tmp (psca001,week_calendar_id_1,mom_wm_id,tue_wm_id,
                                                             wed_wm_id,thu_wm_id,fri_wm_id,sat_wm_id,sun_wm_id)
                                                     VALUES (g_psca29_d[l_d_1].psca001,g_psca29_d[l_d_1].l_week_calendar_id_1,
                                                             g_psca29_d[l_d_1].l_mom_wm_id,g_psca29_d[l_d_1].l_tue_wm_id,
                                                             g_psca29_d[l_d_1].l_wed_wm_id,g_psca29_d[l_d_1].l_thu_wm_id,
                                                             g_psca29_d[l_d_1].l_fri_wm_id,g_psca29_d[l_d_1].l_sat_wm_id,
                                                             g_psca29_d[l_d_1].l_sun_wm_id)
                               #mod--161109-00085#12 By 08993--(e)
                               #IF SQLCA.sqlcode OR SQLCA.sqlerrd[3] = 0 THEN
                               #   INITIALIZE g_errparam TO NULL
                               #   LET g_errparam.extend = 'ins omp_weekcaln',g_psca29_d[l_d].l_week_calendar_id_1
                               #   LET g_errparam.code   = SQLCA.sqlcode
                               #   LET g_errparam.popup  = TRUE
                               #   CALL cl_err()
                               #   EXIT WHILE
                               #END IF
                      END FOR
                      CALL g_psca29_d.clear()
                      #mod--161109-00085#12 By 08993--(s)
                      #LET l_sql29 = "SELECT * FROM omp_weekcaln_tmp ",
                      LET l_sql29 = "SELECT psca001,week_calendar_id_1,mom_wm_id,tue_wm_id,
                                            wed_wm_id,thu_wm_id,fri_wm_id,sat_wm_id,sun_wm_id 
                                       FROM omp_weekcaln_tmp ",
                      #mod--161109-00085#12 By 08993--(e)
                                    " WHERE ",g_wc29 
                      PREPARE apsq102_tmp_wc29_pre FROM l_sql29
                      DECLARE apsq102_tmp_wc29_curs CURSOR FOR apsq102_tmp_wc29_pre
                      #mod--161109-00085#12 By 08993--(s)
                      #FOREACH apsq102_tmp_wc29_curs INTO g_psca29_d[l_ac].*
                      FOREACH apsq102_tmp_wc29_curs 
                      INTO g_psca29_d[l_ac].psca001,g_psca29_d[l_ac].l_week_calendar_id_1,
                           g_psca29_d[l_ac].l_mom_wm_id,g_psca29_d[l_ac].l_tue_wm_id,
                           g_psca29_d[l_ac].l_wed_wm_id,g_psca29_d[l_ac].l_thu_wm_id,
                           g_psca29_d[l_ac].l_fri_wm_id,g_psca29_d[l_ac].l_sat_wm_id,
                           g_psca29_d[l_ac].l_sun_wm_id
                      #mod--161109-00085#12 By 08993--(e)
                         LET l_ac = l_ac + 1
                         IF SQLCA.sqlcode THEN
                            INITIALIZE g_errparam TO NULL 
                            LET g_errparam.extend = "FOREACH:" 
                            LET g_errparam.code   = SQLCA.sqlcode 
                            LET g_errparam.popup  = TRUE 
                            CALL cl_err()
                            
                            EXIT FOREACH
                         END IF
                      END FOREACH
                      CALL g_psca29_d.deleteElement(g_psca29_d.getLength())
                      LET g_tot_cnt = g_psca29_d.getLength()
                   END IF
                  
              WHEN l_specification[1].l_name = "OMP_Work_Model.txt"
                   IF g_wc30 <> " 1=1" THEN
                      LET l_ac = 1
                      FOR l_d_1= 1 to l_c_1
                               #mod--161109-00085#12 By 08993--(s)
#                               INSERT INTO omp_work_model_tmp VALUES (g_psca30_d[l_d_1].*)   #mark--161109-00085#12 By 08993--(s)
                               INSERT INTO omp_work_model_tmp (psca001,wm_id,start_time,end_time,type_2)
                                                       VALUES (g_psca30_d[l_d_1].psca001,g_psca30_d[l_d_1].l_wm_id,
                                                               g_psca30_d[l_d_1].l_start_time,g_psca30_d[l_d_1].l_end_time,
                                                               g_psca30_d[l_d_1].l_type_2)
                               #mod--161109-00085#12 By 08993--(e)
                               #IF SQLCA.sqlcode OR SQLCA.sqlerrd[3] = 0 THEN
                               #   INITIALIZE g_errparam TO NULL
                               #   LET g_errparam.extend = 'ins omp_work_model',g_psca30_d[l_d].l_l_wm_id
                               #   LET g_errparam.code   = SQLCA.sqlcode
                               #   LET g_errparam.popup  = TRUE
                               #   CALL cl_err()
                               #   EXIT WHILE
                               #END IF
                      END FOR
                      CALL g_psca30_d.clear()
                      #mod--161109-00085#12 By 08993--(s)
                      #LET l_sql30 = "SELECT * FROM omp_work_model_tmp ",
                      LET l_sql30 = "SELECT psca001,wm_id,start_time,end_time,type_2 
                                       FROM omp_work_model_tmp ",
                      #mod--161109-00085#12 By 08993--(e)
                                    " WHERE ",g_wc30 
                      PREPARE apsq102_tmp_wc30_pre FROM l_sql30
                      DECLARE apsq102_tmp_wc30_curs CURSOR FOR apsq102_tmp_wc30_pre
                      #mod--161109-00085#12 By 08993--(s)
                      #FOREACH apsq102_tmp_wc30_curs INTO g_psca30_d[l_ac].*
                      FOREACH apsq102_tmp_wc30_curs 
                      INTO g_psca30_d[l_ac].psca001,g_psca30_d[l_ac].l_wm_id,
                           g_psca30_d[l_ac].l_start_time,g_psca30_d[l_ac].l_end_time,
                           g_psca30_d[l_ac].l_type_2
                      #mod--161109-00085#12 By 08993--(e)
                         LET l_ac = l_ac + 1
                         IF SQLCA.sqlcode THEN
                            INITIALIZE g_errparam TO NULL 
                            LET g_errparam.extend = "FOREACH:" 
                            LET g_errparam.code   = SQLCA.sqlcode 
                            LET g_errparam.popup  = TRUE 
                            CALL cl_err()
                            
                            EXIT FOREACH
                         END IF
                      END FOREACH
                      CALL g_psca30_d.deleteElement(g_psca30_d.getLength())
                      LET g_tot_cnt = g_psca30_d.getLength()
                   END IF
               
              WHEN l_specification[1].l_name = "Item_Masters1.txt"
                   IF g_wc31 <> " 1=1" THEN
                      LET l_ac = 1
                      FOR l_d_1= 1 to l_c_1
                               #mod--161109-00085#12 By 08993--(s)
#                               INSERT INTO item_masters1_tmp VALUES (g_psca31_d[l_d_1].*)   #mark--161109-00085#12 By 08993--(s)
                               INSERT INTO item_masters1_tmp (psca001,imaa001_1,imaf026_1,sizing_1,used_2,integer_1,imaf013_1,
                                                              imaa006_1,imae022_1,imae018_1,imae017_1,imae080_1,imaa004_1,
                                                              imae064_2,mfg_2,order_1,feature_1_1,imaf171_2,imaf171_3,consume_1_1,
                                                              release_1_1,lastqty_1,combine_1,inspect_1,consign_1,imaf143_1,
                                                              purchase_1,imae016_1,mfg_1_1,imaa105_1,sales_1,imae064_1_1,alt_2,
                                                              break_1,create_2,supratio_1,imaf153_1,backward_1,batch_1,setup_1,
                                                              imae052_1,imae077_1,base_1,max_batch_size_1,imae032_1,outsourcing_1,
                                                              imae072_1,imae073_1,var_1,auto_1,consolidate_1,phase_1,spare_1,due_1,
                                                              imae015_1,imaa005_1,imae078_1,imae079_1,imae083_1,imae082_1)
                                                      VALUES (g_psca31_d[l_d_1].psca001,g_psca31_d[l_d_1].l_imaa001_1,g_psca31_d[l_d_1].l_imaf026_1,
                                                              g_psca31_d[l_d_1].l_sizing_1,g_psca31_d[l_d_1].l_used_2,g_psca31_d[l_d_1].l_integer_1,
                                                              g_psca31_d[l_d_1].l_imaf013_1,g_psca31_d[l_d_1].l_imaa006_1,g_psca31_d[l_d_1].l_imae022_1,
                                                              g_psca31_d[l_d_1].l_imae018_1,g_psca31_d[l_d_1].l_imae017_1,g_psca31_d[l_d_1].l_imae080_1,
                                                              g_psca31_d[l_d_1].l_imaa004_1,g_psca31_d[l_d_1].l_imae064_2,g_psca31_d[l_d_1].l_mfg_2,
                                                              g_psca31_d[l_d_1].l_order_1,g_psca31_d[l_d_1].l_feature_1_1,g_psca31_d[l_d_1].l_imaf171_2,
                                                              g_psca31_d[l_d_1].l_imaf171_3,g_psca31_d[l_d_1].l_consume_1_1,g_psca31_d[l_d_1].l_release_1_1,
                                                              g_psca31_d[l_d_1].l_lastqty_1,g_psca31_d[l_d_1].l_combine_1,g_psca31_d[l_d_1].l_inspect_1,
                                                              g_psca31_d[l_d_1].l_consign_1,g_psca31_d[l_d_1].l_imaf143_1,g_psca31_d[l_d_1].l_purchase_1,
                                                              g_psca31_d[l_d_1].l_imae016_1,g_psca31_d[l_d_1].l_mfg_1_1,g_psca31_d[l_d_1].l_imaa105_1,
                                                              g_psca31_d[l_d_1].l_sales_1,g_psca31_d[l_d_1].l_imae064_1_1,g_psca31_d[l_d_1].l_alt_2,
                                                              g_psca31_d[l_d_1].l_break_1,g_psca31_d[l_d_1].l_create_2,g_psca31_d[l_d_1].l_supratio_1,
                                                              g_psca31_d[l_d_1].l_imaf153_1,g_psca31_d[l_d_1].l_backward_1,g_psca31_d[l_d_1].l_batch_1,
                                                              g_psca31_d[l_d_1].l_setup_1,g_psca31_d[l_d_1].l_imae052_1,g_psca31_d[l_d_1].l_imae077_1,
                                                              g_psca31_d[l_d_1].l_base_1,g_psca31_d[l_d_1].l_max_batch_size_1,g_psca31_d[l_d_1].l_imae032_1,
                                                              g_psca31_d[l_d_1].l_outsourcing_1,g_psca31_d[l_d_1].l_imae072_1,g_psca31_d[l_d_1].l_imae073_1,
                                                              g_psca31_d[l_d_1].l_var_1,g_psca31_d[l_d_1].l_auto_1,g_psca31_d[l_d_1].l_consolidate_1,
                                                              g_psca31_d[l_d_1].l_phase_1,g_psca31_d[l_d_1].l_spare_1,g_psca31_d[l_d_1].l_due_1,g_psca31_d[l_d_1].l_imae015_1,
                                                              g_psca31_d[l_d_1].l_imaa005_1,g_psca31_d[l_d_1].l_imae078_1,g_psca31_d[l_d_1].l_imae079_1,
                                                              g_psca31_d[l_d_1].l_imae083_1,g_psca31_d[l_d_1].l_imae082_1)
                               #mod--161109-00085#12 By 08993--(e)
                               #IF SQLCA.sqlcode OR SQLCA.sqlerrd[3] = 0 THEN
                               #   INITIALIZE g_errparam TO NULL
                               #   LET g_errparam.extend = 'ins item_masters1',g_psca31_d[l_d].l_imaa001_1
                               #   LET g_errparam.code   = SQLCA.sqlcode
                               #   LET g_errparam.popup  = TRUE
                               #   CALL cl_err()
                               #   EXIT WHILE
                               #END IF
                      END FOR
                      CALL g_psca31_d.clear()
                      #mod--161109-00085#12 By 08993--(s)
                      #LET l_sql31 = "SELECT * FROM item_masters1_tmp ",
                      LET l_sql31 = "SELECT psca001,imaa001_1,imaf026_1,sizing_1,used_2,integer_1,imaf013_1,
                                            imaa006_1,imae022_1,imae018_1,imae017_1,imae080_1,imaa004_1,
                                            imae064_2,mfg_2,order_1,feature_1_1,imaf171_2,imaf171_3,consume_1_1,
                                            release_1_1,lastqty_1,combine_1,inspect_1,consign_1,imaf143_1,
                                            purchase_1,imae016_1,mfg_1_1,imaa105_1,sales_1,imae064_1_1,alt_2,
                                            break_1,create_2,supratio_1,imaf153_1,backward_1,batch_1,setup_1,
                                            imae052_1,imae077_1,base_1,max_batch_size_1,imae032_1,outsourcing_1,
                                            imae072_1,imae073_1,var_1,auto_1,consolidate_1,phase_1,spare_1,due_1,
                                            imae015_1,imaa005_1,imae078_1,imae079_1,imae083_1,imae082_1 
                                       FROM item_masters1_tmp ",
                      #mod--161109-00085#12 By 08993--(e)
                                    " WHERE ",g_wc31 
                      PREPARE apsq102_tmp_wc31_pre FROM l_sql31
                      DECLARE apsq102_tmp_wc31_curs CURSOR FOR apsq102_tmp_wc31_pre
                      #mod--161109-00085#12 By 08993--(s)
                      #FOREACH apsq102_tmp_wc31_curs INTO g_psca31_d[l_ac].*
                      FOREACH apsq102_tmp_wc31_curs 
                      INTO 
                      g_psca31_d[l_ac].psca001,g_psca31_d[l_ac].l_imaa001_1,g_psca31_d[l_ac].l_imaf026_1,
                      g_psca31_d[l_ac].l_sizing_1,g_psca31_d[l_ac].l_used_2,g_psca31_d[l_ac].l_integer_1,
                      g_psca31_d[l_ac].l_imaf013_1,g_psca31_d[l_ac].l_imaa006_1,g_psca31_d[l_ac].l_imae022_1,
                      g_psca31_d[l_ac].l_imae018_1,g_psca31_d[l_ac].l_imae017_1,g_psca31_d[l_ac].l_imae080_1,
                      g_psca31_d[l_ac].l_imaa004_1,g_psca31_d[l_ac].l_imae064_2,g_psca31_d[l_ac].l_mfg_2,
                      g_psca31_d[l_ac].l_order_1,g_psca31_d[l_ac].l_feature_1_1,g_psca31_d[l_ac].l_imaf171_2,
                      g_psca31_d[l_ac].l_imaf171_3,g_psca31_d[l_ac].l_consume_1_1,g_psca31_d[l_ac].l_release_1_1,
                      g_psca31_d[l_ac].l_lastqty_1,g_psca31_d[l_ac].l_combine_1,g_psca31_d[l_ac].l_inspect_1,
                      g_psca31_d[l_ac].l_consign_1,g_psca31_d[l_ac].l_imaf143_1,g_psca31_d[l_ac].l_purchase_1,
                      g_psca31_d[l_ac].l_imae016_1,g_psca31_d[l_ac].l_mfg_1_1,g_psca31_d[l_ac].l_imaa105_1,
                      g_psca31_d[l_ac].l_sales_1,g_psca31_d[l_ac].l_imae064_1_1,g_psca31_d[l_ac].l_alt_2,
                      g_psca31_d[l_ac].l_break_1,g_psca31_d[l_ac].l_create_2,g_psca31_d[l_ac].l_supratio_1,
                      g_psca31_d[l_ac].l_imaf153_1,g_psca31_d[l_ac].l_backward_1,g_psca31_d[l_ac].l_batch_1,
                      g_psca31_d[l_ac].l_setup_1,g_psca31_d[l_ac].l_imae052_1,g_psca31_d[l_ac].l_imae077_1,
                      g_psca31_d[l_ac].l_base_1,g_psca31_d[l_ac].l_max_batch_size_1,g_psca31_d[l_ac].l_imae032_1,
                      g_psca31_d[l_ac].l_outsourcing_1,g_psca31_d[l_ac].l_imae072_1,g_psca31_d[l_ac].l_imae073_1,
                      g_psca31_d[l_ac].l_var_1,g_psca31_d[l_ac].l_auto_1,g_psca31_d[l_ac].l_consolidate_1,
                      g_psca31_d[l_ac].l_phase_1,g_psca31_d[l_ac].l_spare_1,g_psca31_d[l_ac].l_due_1,g_psca31_d[l_ac].l_imae015_1,
                      g_psca31_d[l_ac].l_imaa005_1,g_psca31_d[l_ac].l_imae078_1,g_psca31_d[l_ac].l_imae079_1,
                      g_psca31_d[l_ac].l_imae083_1,g_psca31_d[l_ac].l_imae082_1
                      #mod--161109-00085#12 By 08993--(e)
                         LET l_ac = l_ac + 1
                         IF SQLCA.sqlcode THEN
                            INITIALIZE g_errparam TO NULL 
                            LET g_errparam.extend = "FOREACH:" 
                            LET g_errparam.code   = SQLCA.sqlcode 
                            LET g_errparam.popup  = TRUE 
                            CALL cl_err()
                            
                            EXIT FOREACH
                         END IF
                      END FOREACH
                      CALL g_psca31_d.deleteElement(g_psca31_d.getLength())
                      LET g_tot_cnt = g_psca31_d.getLength()
                   END IF
                  
              WHEN l_specification[1].l_name = "BOM_Throw_Point.txt"
                   IF g_wc32 <> " 1=1" THEN
                      LET l_ac = 1
                      FOR l_d_1= 1 to l_c_1
                               #mod--161109-00085#12 By 08993--(s)
#                               INSERT INTO b_t_p_tmp VALUES (g_psca32_d[l_d_1].*)   #mark--161109-00085#12 By 08993--(s)
                               INSERT INTO b_t_p_tmp (psca001,bmba001_1,bmba003_1,ecba001,ecbb003,bmba007_1)
                                              VALUES (g_psca32_d[l_d_1].psca001,g_psca32_d[l_d_1].l_bmba001_1,
                                                      g_psca32_d[l_d_1].l_bmba003_1,g_psca32_d[l_d_1].l_ecba001,
                                                      g_psca32_d[l_d_1].l_ecbb003,g_psca32_d[l_d_1].l_bmba007_1)
                               #mod--161109-00085#12 By 08993--(e)
                               #IF SQLCA.sqlcode OR SQLCA.sqlerrd[3] = 0 THEN
                               #   INITIALIZE g_errparam TO NULL
                               #   LET g_errparam.extend = 'ins bom_throw_point',g_psca32_d[l_d].l_bmba001_1
                               #   LET g_errparam.code   = SQLCA.sqlcode
                               #   LET g_errparam.popup  = TRUE
                               #   CALL cl_err()
                               #   EXIT WHILE
                               #END IF
                      END FOR
                      CALL g_psca32_d.clear()
                      #mod--161109-00085#12 By 08993--(s)
                      #LET l_sql32 = "SELECT * FROM b_t_p_tmp ",
                      LET l_sql32 = "SELECT psca001,bmba001_1,bmba003_1,ecba001,ecbb003,bmba007_1 FROM b_t_p_tmp ",
                      #mod--161109-00085#12 By 08993--(e)
                                    " WHERE ",g_wc32 
                      PREPARE apsq102_tmp_wc32_pre FROM l_sql32
                      DECLARE apsq102_tmp_wc32_curs CURSOR FOR apsq102_tmp_wc32_pre
                      #mod--161109-00085#12 By 08993--(s)
                      #FOREACH apsq102_tmp_wc32_curs INTO g_psca32_d[l_ac].*
                      FOREACH apsq102_tmp_wc32_curs 
                      INTO g_psca32_d[l_ac].psca001,g_psca32_d[l_ac].l_bmba001_1,
                           g_psca32_d[l_ac].l_bmba003_1,g_psca32_d[l_ac].l_ecba001,g_psca32_d[l_ac].l_ecbb003,
                           g_psca32_d[l_ac].l_bmba007_1
                      #mod--161109-00085#12 By 08993--(e)
                         LET l_ac = l_ac + 1
                         IF SQLCA.sqlcode THEN
                            INITIALIZE g_errparam TO NULL 
                            LET g_errparam.extend = "FOREACH:" 
                            LET g_errparam.code   = SQLCA.sqlcode 
                            LET g_errparam.popup  = TRUE 
                            CALL cl_err()
                            
                            EXIT FOREACH
                         END IF
                      END FOREACH
                      CALL g_psca32_d.deleteElement(g_psca32_d.getLength())
                      LET g_tot_cnt = g_psca32_d.getLength()
                   END IF
                  
              WHEN l_specification[1].l_name = "Item_Route.txt"
                   IF g_wc33 <> " 1=1" THEN
                      LET l_ac = 1
                      FOR l_d_1= 1 to l_c_1
                               #mod--161109-00085#12 By 08993--(s)
#                               INSERT INTO item_route_tmp VALUES (g_psca33_d[l_d_1].*)   #mark--161109-00085#12 By 08993--(s)
                               INSERT INTO item_route_tmp (psca001,part_id,imae033,sequ_num,is_alt)
                                                   VALUES (g_psca33_d[l_d_1].psca001,g_psca33_d[l_d_1].l_part_id,
                                                           g_psca33_d[l_d_1].l_imae033,g_psca33_d[l_d_1].l_sequ_num,
                                                           g_psca33_d[l_d_1].l_is_alt)
                               #mod--161109-00085#12 By 08993--(e)
                               #IF SQLCA.sqlcode OR SQLCA.sqlerrd[3] = 0 THEN
                               #   INITIALIZE g_errparam TO NULL
                               #   LET g_errparam.extend = 'ins item_route',g_psca33_d[l_d].l_part_id
                               #   LET g_errparam.code   = SQLCA.sqlcode
                               #   LET g_errparam.popup  = TRUE
                               #   CALL cl_err()
                               #   EXIT WHILE
                               #END IF
                      END FOR
                      CALL g_psca33_d.clear()
                      #mod--161109-00085#12 By 08993--(s)
                      #LET l_sql33 = "SELECT * FROM item_route_tmp ",
                      LET l_sql33 = "SELECT psca001,part_id,imae033,sequ_num,is_alt FROM item_route_tmp ",
                      #mod--161109-00085#12 By 08993--(e)
                                    " WHERE ",g_wc33 
                      PREPARE apsq102_tmp_wc33_pre FROM l_sql33
                      DECLARE apsq102_tmp_wc33_curs CURSOR FOR apsq102_tmp_wc33_pre
                      #mod--161109-00085#12 By 08993--(s)
                      #FOREACH apsq102_tmp_wc33_curs INTO g_psca33_d[l_ac].*
                      FOREACH apsq102_tmp_wc33_curs 
                      INTO g_psca33_d[l_ac].psca001,g_psca33_d[l_ac].l_part_id,
                           g_psca33_d[l_ac].l_imae033,g_psca33_d[l_ac].l_sequ_num,g_psca33_d[l_ac].l_is_alt                                      
                      #mod--161109-00085#12 By 08993--(s)
                         LET l_ac = l_ac + 1
                         IF SQLCA.sqlcode THEN
                            INITIALIZE g_errparam TO NULL 
                            LET g_errparam.extend = "FOREACH:" 
                            LET g_errparam.code   = SQLCA.sqlcode 
                            LET g_errparam.popup  = TRUE 
                            CALL cl_err()
                            
                            EXIT FOREACH
                         END IF
                      END FOREACH
                      CALL g_psca33_d.deleteElement(g_psca33_d.getLength())
                      LET g_tot_cnt = g_psca33_d.getLength()
                   END IF
                  
              WHEN l_specification[1].l_name = "Route.txt"
                   IF g_wc34 <> " 1=1" THEN
                      LET l_ac = 1
                      FOR l_d_1= 1 to l_c_1
                               #mod--161109-00085#12 By 08993--(s)
#                               INSERT INTO route_tmp VALUES (g_psca34_d[l_d_1].*)   #mark--161109-00085#12 By 08993--(s)
                               INSERT INTO route_tmp (psca001,ecbb001,ecbb002,ecbb003_1,ecbb004,equip_type_2,
                                                      ecbb037,is_batch,ecbb026,ecbb027,imae077_2,imae077_3,ecbb012)
                                              VALUES (g_psca34_d[l_d_1].psca001,g_psca34_d[l_d_1].l_ecbb001,
                                                      g_psca34_d[l_d_1].l_ecbb002,g_psca34_d[l_d_1].l_ecbb003_1,
                                                      g_psca34_d[l_d_1].l_ecbb004,g_psca34_d[l_d_1].l_equip_type_2,
                                                      g_psca34_d[l_d_1].l_ecbb037,g_psca34_d[l_d_1].l_is_batch,
                                                      g_psca34_d[l_d_1].l_ecbb026,g_psca34_d[l_d_1].l_ecbb027,
                                                      g_psca34_d[l_d_1].l_imae077_2,g_psca34_d[l_d_1].l_imae077_3,
                                                      g_psca34_d[l_d_1].l_ecbb012 )     
                               #mod--161109-00085#12 By 08993--(e)
                               #IF SQLCA.sqlcode OR SQLCA.sqlerrd[3] = 0 THEN
                               #   INITIALIZE g_errparam TO NULL
                               #   LET g_errparam.extend = 'ins route',g_psca34_d[l_d].l_ecbb001
                               #   LET g_errparam.code   = SQLCA.sqlcode
                               #   LET g_errparam.popup  = TRUE
                               #   CALL cl_err()
                               #   EXIT WHILE
                               #END IF
                      END FOR
                      CALL g_psca34_d.clear()
                      #mod--161109-00085#12 By 08993--(s)
                      #LET l_sql34 = "SELECT * FROM route_tmp ",
                      LET l_sql34 = "SELECT psca001,ecbb001,ecbb002,ecbb003_1,ecbb004,equip_type_2,
                                            ecbb037,is_batch,ecbb026,ecbb027,imae077_2,imae077_3,ecbb012 FROM route_tmp ",
                      #mod--161109-00085#12 By 08993--(s)
                                    " WHERE ",g_wc34 
                      PREPARE apsq102_tmp_wc34_pre FROM l_sql34
                      DECLARE apsq102_tmp_wc34_curs CURSOR FOR apsq102_tmp_wc34_pre
                      #mod--161109-00085#12 By 08993--(s)
                      #FOREACH apsq102_tmp_wc34_curs INTO g_psca34_d[l_ac].*
                      FOREACH apsq102_tmp_wc34_curs 
                      INTO 
                      g_psca34_d[l_ac].psca001,g_psca34_d[l_ac].l_ecbb001,
                      g_psca34_d[l_ac].l_ecbb002,g_psca34_d[l_ac].l_ecbb003_1,
                      g_psca34_d[l_ac].l_ecbb004,
                      g_psca34_d[l_ac].l_equip_type_2,g_psca34_d[l_ac].l_ecbb037,
                      g_psca34_d[l_ac].l_is_batch,g_psca34_d[l_ac].l_ecbb026,g_psca34_d[l_ac].l_ecbb027,
                      g_psca34_d[l_ac].l_imae077_2,g_psca34_d[l_ac].l_imae077_3,g_psca34_d[l_ac].l_ecbb012
                      #mod--161109-00085#12 By 08993--(e)
                         LET l_ac = l_ac + 1
                         IF SQLCA.sqlcode THEN
                            INITIALIZE g_errparam TO NULL 
                            LET g_errparam.extend = "FOREACH:" 
                            LET g_errparam.code   = SQLCA.sqlcode 
                            LET g_errparam.popup  = TRUE 
                            CALL cl_err()
                            
                            EXIT FOREACH
                         END IF
                      END FOREACH
                      CALL g_psca34_d.deleteElement(g_psca34_d.getLength())
                      LET g_tot_cnt = g_psca34_d.getLength()
                   END IF
                  
              WHEN l_specification[1].l_name = "WS.txt"
                   IF g_wc35 <> " 1=1" THEN
                      LET l_ac = 1
                      FOR l_d_1= 1 to l_c_1
                               #mod--161109-00085#12 By 08993--(s)
#                               INSERT INTO ws1_tmp VALUES (g_psca35_d[l_d_1].*)   #mark--161109-00085#12 By 08993--(s)
                               INSERT INTO ws1_tmp (psca001,ecaa001)
                                            VALUES (g_psca35_d[l_d_1].psca001,g_psca35_d[l_d_1].l_ecaa001_1)
                               #mod--161109-00085#12 By 08993--(e)
                               #IF SQLCA.sqlcode OR SQLCA.sqlerrd[3] = 0 THEN
                               #   INITIALIZE g_errparam TO NULL
                               #   LET g_errparam.extend = 'ins ws',g_psca35_d[l_d].l_ecaa001_1
                               #   LET g_errparam.code   = SQLCA.sqlcode
                               #   LET g_errparam.popup  = TRUE
                               #   CALL cl_err()
                               #   EXIT WHILE
                               #END IF
                      END FOR
                      CALL g_psca35_d.clear()
                      #mod--161109-00085#12 By 08993--(s)
                      #LET l_sql35 = "SELECT * FROM ws1_tmp ",
                      LET l_sql35 = "SELECT psca001,ecaa001 FROM ws1_tmp ",
                      #mod--161109-00085#12 By 08993--(s)
                                    " WHERE ",g_wc35 
                      PREPARE apsq102_tmp_wc35_pre FROM l_sql35
                      DECLARE apsq102_tmp_wc35_curs CURSOR FOR apsq102_tmp_wc35_pre
                      #mod--161109-00085#12 By 08993--(s)
                      #FOREACH apsq102_tmp_wc35_curs INTO g_psca35_d[l_ac].*
                      FOREACH apsq102_tmp_wc35_curs 
                      INTO g_psca35_d[l_ac].psca001,g_psca35_d[l_ac].l_ecaa001_1
                      #mod--161109-00085#12 By 08993--(e)
                         LET l_ac = l_ac + 1
                         IF SQLCA.sqlcode THEN
                            INITIALIZE g_errparam TO NULL 
                            LET g_errparam.extend = "FOREACH:" 
                            LET g_errparam.code   = SQLCA.sqlcode 
                            LET g_errparam.popup  = TRUE 
                            CALL cl_err()
                            
                            EXIT FOREACH
                         END IF
                      END FOREACH
                      CALL g_psca35_d.deleteElement(g_psca35_d.getLength())
                      LET g_tot_cnt = g_psca35_d.getLength()
                   END IF
                  
              WHEN l_specification[1].l_name = "Route_Relation.txt"
                   IF g_wc36 <> " 1=1" THEN
                      LET l_ac = 1
                      FOR l_d_1= 1 to l_c_1
                               #mod--161109-00085#12 By 08993--(s)
#                               INSERT INTO route_relation_tmp VALUES (g_psca36_d[l_d_1].*)   #mark--161109-00085#12 By 08993--(s)
                               INSERT INTO route_relation_tmp (psca001,ecbe001,ecbe005,ecbe003)
                                                       VALUES (g_psca36_d[l_d_1].psca001,g_psca36_d[l_d_1].l_ecbe001,
                                                               g_psca36_d[l_d_1].l_ecbe005,g_psca36_d[l_d_1].l_ecbe003)
                               #mod--161109-00085#12 By 08993--(e)
                              #IF SQLCA.sqlcode OR SQLCA.sqlerrd[3] = 0 THEN
                              #   INITIALIZE g_errparam TO NULL
                              #   LET g_errparam.extend = 'ins alt_part',g_psca36_d[l_d].l_ecbe001
                              #   LET g_errparam.code   = SQLCA.sqlcode
                              #   LET g_errparam.popup  = TRUE
                              #   CALL cl_err()
                              #   EXIT WHILE
                              #END IF
                      END FOR
                      CALL g_psca36_d.clear()
                      #mod--161109-00085#12 By 08993--(s)
                      #LET l_sql36 = "SELECT * FROM route_relation_tmp ",
                      LET l_sql36 = "SELECT psca001,ecbe001,ecbe005,ecbe003 FROM route_relation_tmp ",
                      #mod--161109-00085#12 By 08993--(s)
                                    " WHERE ",g_wc36 
                      PREPARE apsq102_tmp_wc36_pre FROM l_sql36
                      DECLARE apsq102_tmp_wc36_curs CURSOR FOR apsq102_tmp_wc36_pre
                      #mod--161109-00085#12 By 08993--(s)
                      #FOREACH apsq102_tmp_wc36_curs INTO g_psca36_d[l_ac].*
                      FOREACH apsq102_tmp_wc36_curs 
                      INTO g_psca36_d[l_ac].psca001,g_psca36_d[l_ac].l_ecbe001,g_psca36_d[l_ac].l_ecbe005,g_psca36_d[l_ac].l_ecbe003                                                                  
                      #mod--161109-00085#12 By 08993--(e)
                         LET l_ac = l_ac + 1
                         IF SQLCA.sqlcode THEN
                            INITIALIZE g_errparam TO NULL 
                            LET g_errparam.extend = "FOREACH:" 
                            LET g_errparam.code   = SQLCA.sqlcode 
                            LET g_errparam.popup  = TRUE 
                            CALL cl_err()
                            
                            EXIT FOREACH
                         END IF
                      END FOREACH
                      CALL g_psca36_d.deleteElement(g_psca36_d.getLength())
                      LET g_tot_cnt = g_psca36_d.getLength()
                   END IF
         END CASE                   
	   END WHILE
	END IF
	#160107-00020#1 ---add (E)---
	
	CALL lc_createtb.close()
	CALL lc_createtb1.close()
	#LET g_tot_cnt = g_psca_d.getLength() #160107-00020#1 mark
   #end add-point
 
   LET g_error_show = 0
 
   LET g_detail_cnt = g_psca_d.getLength()
   LET l_ac = g_cnt
   LET g_cnt = 0
 
   #應用 qs06 樣板自動產生(Version:3)
   #+ b_fill段CURSOR釋放
   #CLOSE b_fill_curs
   #FREE apsq102_pb
 
 
 
 
 
 
   #調整單身index指標，避免翻頁後指到空白筆數
   CALL apsq102_detail_index_setting()
 
   #重新計算單身筆數並呈現
   IF g_flag <> 1 THEN
      LET g_tot_cnt = g_psca_d.getLength()
   END IF   
   CALL apsq102_detail_action_trans()
 
   LET l_ac = 1
 
   IF g_psca_d.getLength() > 0 THEN
      CALL apsq102_b_fill2()
   END IF
 
 
   CALL apsq102_filter_show('psca001_9','b_psca001_9')
   CALL apsq102_filter_show('psca001_10','b_psca001_10')
   CALL apsq102_filter_show('psca001_11','b_psca001_11')
   CALL apsq102_filter_show('psca001_12','b_psca001_12')
   CALL apsq102_filter_show('psca001_13','b_psca001_13')
   CALL apsq102_filter_show('psca001_14','b_psca001_14')
   CALL apsq102_filter_show('psca001_15','b_psca001_15')
   CALL apsq102_filter_show('psca001_16','b_psca001_16')
   CALL apsq102_filter_show('psca001_17','b_psca001_17')
   CALL apsq102_filter_show('psca001_18','b_psca001_18')
   CALL apsq102_filter_show('psca001_1','b_psca001_1')
   CALL apsq102_filter_show('psca001_19','b_psca001_19')
   CALL apsq102_filter_show('psca001_20','b_psca001_20')
   CALL apsq102_filter_show('psca001_21','b_psca001_21')
   CALL apsq102_filter_show('psca001_22','b_psca001_22')
   CALL apsq102_filter_show('psca001_23','b_psca001_23')
   CALL apsq102_filter_show('psca001_24','b_psca001_24')
   CALL apsq102_filter_show('psca001_25','b_psca001_25')
   CALL apsq102_filter_show('psca001_26','b_psca001_26')
   CALL apsq102_filter_show('psca001_27','b_psca001_27')
   CALL apsq102_filter_show('psca001_28','b_psca001_28')
   CALL apsq102_filter_show('psca001_2','b_psca001_2')
   CALL apsq102_filter_show('psca001_29','b_psca001_29')
   CALL apsq102_filter_show('psca001_30','b_psca001_30')
   CALL apsq102_filter_show('psca001_31','b_psca001_31')
   CALL apsq102_filter_show('psca001_32','b_psca001_32')
   CALL apsq102_filter_show('psca001_33','b_psca001_33')
   CALL apsq102_filter_show('psca001_34','b_psca001_34')
   CALL apsq102_filter_show('psca001_35','b_psca001_35')
   CALL apsq102_filter_show('psca001_3','b_psca001_3')
   CALL apsq102_filter_show('psca001_4','b_psca001_4')
   CALL apsq102_filter_show('psca001_5','b_psca001_5')
   CALL apsq102_filter_show('psca001_6','b_psca001_6')
   CALL apsq102_filter_show('psca001_7','b_psca001_7')
   CALL apsq102_filter_show('psca001_8','b_psca001_8')
 
 
END FUNCTION
 
{</section>}
 
{<section id="apsq102.b_fill2" >}
#+ 單身陣列填充2
PRIVATE FUNCTION apsq102_b_fill2()
   #add-point:b_fill2段define-客製 name="b_fill2.define_customerization"
   
   #end add-point
   DEFINE li_ac           LIKE type_t.num10
   #add-point:b_fill2段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="b_fill2.define"
   
   #end add-point
 
   #add-point:FUNCTION前置處理 name="b_fill2.before_function"
   
   #end add-point
 
   LET li_ac = l_ac
 
   #單身組成
   #應用 qs07 樣板自動產生(Version:6)
   #+ b_fill2段table資料取得(包含sql組成及資料填充)
 
   #add-point:陣列清空 name="b_fill2.array_clear"
   
   #end add-point
 
 
 
 
   #add-point:陣列長度調整 name="b_fill2.array_deleteElement"
   
   #end add-point
 
 
   DISPLAY li_ac TO FORMONLY.cnt
   LET g_detail_idx2 = 1
   DISPLAY g_detail_idx2 TO FORMONLY.idx
 
 
 
 
 
   #add-point:單身填充後 name="b_fill2.after_fill"
   
   #end add-point
 
   LET l_ac = li_ac
 
END FUNCTION
 
{</section>}
 
{<section id="apsq102.detail_show" >}
#+ 顯示相關資料
PRIVATE FUNCTION apsq102_detail_show(ps_page)
   #add-point:show段define-客製 name="detail_show.define_customerization"
   
   #end add-point
   DEFINE ps_page    STRING
   DEFINE ls_sql     STRING
   #add-point:show段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="detail_show.define"
   
   #end add-point
 
   #add-point:detail_show段之前 name="detail_show.before"
   
   #end add-point
 
   
 
   #讀入ref值
   IF ps_page.getIndexOf("'1'",1) > 0 THEN
      #帶出公用欄位reference值page1
      
 
      #add-point:show段單身reference name="detail_show.body.reference"
      
      #end add-point
   END IF
 
   IF ps_page.getIndexOf("'2'",1) > 0 THEN
      #帶出公用欄位reference值page2
      
 
      #add-point:show段單身reference name="detail_show.body10.reference"
      
      #end add-point
   END IF
 
   IF ps_page.getIndexOf("'3'",1) > 0 THEN
      #帶出公用欄位reference值page3
      
 
      #add-point:show段單身reference name="detail_show.body11.reference"
      
      #end add-point
   END IF
 
   IF ps_page.getIndexOf("'4'",1) > 0 THEN
      #帶出公用欄位reference值page4
      
 
      #add-point:show段單身reference name="detail_show.body12.reference"
      
      #end add-point
   END IF
 
   IF ps_page.getIndexOf("'5'",1) > 0 THEN
      #帶出公用欄位reference值page5
      
 
      #add-point:show段單身reference name="detail_show.body13.reference"
      
      #end add-point
   END IF
 
   IF ps_page.getIndexOf("'6'",1) > 0 THEN
      #帶出公用欄位reference值page6
      
 
      #add-point:show段單身reference name="detail_show.body14.reference"
      
      #end add-point
   END IF
 
   IF ps_page.getIndexOf("'7'",1) > 0 THEN
      #帶出公用欄位reference值page7
      
 
      #add-point:show段單身reference name="detail_show.body15.reference"
      
      #end add-point
   END IF
 
   IF ps_page.getIndexOf("'8'",1) > 0 THEN
      #帶出公用欄位reference值page8
      
 
      #add-point:show段單身reference name="detail_show.body16.reference"
      
      #end add-point
   END IF
 
   IF ps_page.getIndexOf("'9'",1) > 0 THEN
      #帶出公用欄位reference值page9
      
 
      #add-point:show段單身reference name="detail_show.body17.reference"
      
      #end add-point
   END IF
 
   IF ps_page.getIndexOf("'10'",1) > 0 THEN
      #帶出公用欄位reference值page10
      
 
      #add-point:show段單身reference name="detail_show.body18.reference"
      
      #end add-point
   END IF
 
   IF ps_page.getIndexOf("'11'",1) > 0 THEN
      #帶出公用欄位reference值page11
      
 
      #add-point:show段單身reference name="detail_show.body19.reference"
      
      #end add-point
   END IF
 
   IF ps_page.getIndexOf("'12'",1) > 0 THEN
      #帶出公用欄位reference值page12
      
 
      #add-point:show段單身reference name="detail_show.body2.reference"
      
      #end add-point
   END IF
 
   IF ps_page.getIndexOf("'13'",1) > 0 THEN
      #帶出公用欄位reference值page13
      
 
      #add-point:show段單身reference name="detail_show.body20.reference"
      
      #end add-point
   END IF
 
   IF ps_page.getIndexOf("'14'",1) > 0 THEN
      #帶出公用欄位reference值page14
      
 
      #add-point:show段單身reference name="detail_show.body21.reference"
      
      #end add-point
   END IF
 
   IF ps_page.getIndexOf("'15'",1) > 0 THEN
      #帶出公用欄位reference值page15
      
 
      #add-point:show段單身reference name="detail_show.body22.reference"
      
      #end add-point
   END IF
 
   IF ps_page.getIndexOf("'16'",1) > 0 THEN
      #帶出公用欄位reference值page16
      
 
      #add-point:show段單身reference name="detail_show.body23.reference"
      
      #end add-point
   END IF
 
   IF ps_page.getIndexOf("'17'",1) > 0 THEN
      #帶出公用欄位reference值page17
      
 
      #add-point:show段單身reference name="detail_show.body24.reference"
      
      #end add-point
   END IF
 
   IF ps_page.getIndexOf("'18'",1) > 0 THEN
      #帶出公用欄位reference值page18
      
 
      #add-point:show段單身reference name="detail_show.body25.reference"
      
      #end add-point
   END IF
 
   IF ps_page.getIndexOf("'19'",1) > 0 THEN
      #帶出公用欄位reference值page19
      
 
      #add-point:show段單身reference name="detail_show.body26.reference"
      
      #end add-point
   END IF
 
   IF ps_page.getIndexOf("'20'",1) > 0 THEN
      #帶出公用欄位reference值page20
      
 
      #add-point:show段單身reference name="detail_show.body27.reference"
      
      #end add-point
   END IF
 
   IF ps_page.getIndexOf("'21'",1) > 0 THEN
      #帶出公用欄位reference值page21
      
 
      #add-point:show段單身reference name="detail_show.body28.reference"
      
      #end add-point
   END IF
 
   IF ps_page.getIndexOf("'22'",1) > 0 THEN
      #帶出公用欄位reference值page22
      
 
      #add-point:show段單身reference name="detail_show.body29.reference"
      
      #end add-point
   END IF
 
   IF ps_page.getIndexOf("'23'",1) > 0 THEN
      #帶出公用欄位reference值page23
      
 
      #add-point:show段單身reference name="detail_show.body3.reference"
      
      #end add-point
   END IF
 
   IF ps_page.getIndexOf("'24'",1) > 0 THEN
      #帶出公用欄位reference值page24
      
 
      #add-point:show段單身reference name="detail_show.body30.reference"
      
      #end add-point
   END IF
 
   IF ps_page.getIndexOf("'25'",1) > 0 THEN
      #帶出公用欄位reference值page25
      
 
      #add-point:show段單身reference name="detail_show.body31.reference"
      
      #end add-point
   END IF
 
   IF ps_page.getIndexOf("'26'",1) > 0 THEN
      #帶出公用欄位reference值page26
      
 
      #add-point:show段單身reference name="detail_show.body32.reference"
      
      #end add-point
   END IF
 
   IF ps_page.getIndexOf("'27'",1) > 0 THEN
      #帶出公用欄位reference值page27
      
 
      #add-point:show段單身reference name="detail_show.body33.reference"
      
      #end add-point
   END IF
 
   IF ps_page.getIndexOf("'28'",1) > 0 THEN
      #帶出公用欄位reference值page28
      
 
      #add-point:show段單身reference name="detail_show.body34.reference"
      
      #end add-point
   END IF
 
   IF ps_page.getIndexOf("'29'",1) > 0 THEN
      #帶出公用欄位reference值page29
      
 
      #add-point:show段單身reference name="detail_show.body35.reference"
      
      #end add-point
   END IF
 
   IF ps_page.getIndexOf("'30'",1) > 0 THEN
      #帶出公用欄位reference值page30
      
 
      #add-point:show段單身reference name="detail_show.body36.reference"
      
      #end add-point
   END IF
 
   IF ps_page.getIndexOf("'31'",1) > 0 THEN
      #帶出公用欄位reference值page31
      
 
      #add-point:show段單身reference name="detail_show.body4.reference"
      
      #end add-point
   END IF
 
   IF ps_page.getIndexOf("'32'",1) > 0 THEN
      #帶出公用欄位reference值page32
      
 
      #add-point:show段單身reference name="detail_show.body5.reference"
      
      #end add-point
   END IF
 
   IF ps_page.getIndexOf("'33'",1) > 0 THEN
      #帶出公用欄位reference值page33
      
 
      #add-point:show段單身reference name="detail_show.body6.reference"
      
      #end add-point
   END IF
 
   IF ps_page.getIndexOf("'34'",1) > 0 THEN
      #帶出公用欄位reference值page34
      
 
      #add-point:show段單身reference name="detail_show.body7.reference"
      
      #end add-point
   END IF
 
   IF ps_page.getIndexOf("'35'",1) > 0 THEN
      #帶出公用欄位reference值page35
      
 
      #add-point:show段單身reference name="detail_show.body8.reference"
      
      #end add-point
   END IF
 
   IF ps_page.getIndexOf("'36'",1) > 0 THEN
      #帶出公用欄位reference值page36
      
 
      #add-point:show段單身reference name="detail_show.body9.reference"
      
      #end add-point
   END IF
 
 
 
   #add-point:detail_show段之後 name="detail_show.after"
   
   #end add-point
 
END FUNCTION
 
{</section>}
 
{<section id="apsq102.filter" >}
#應用 qs13 樣板自動產生(Version:8)
#+ filter段相關程式段
#+ filter過濾功能
PRIVATE FUNCTION apsq102_filter()
   #add-point:filter段define-客製 name="filter.define_customerization"
   
   #end add-point
   DEFINE  ls_result   STRING
   #add-point:filter段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="filter.define"
   
   #end add-point
 
   #add-point:FUNCTION前置處理 name="filter.before_function"
   
   #end add-point
 
   LET INT_FLAG = 0
 
   LET g_qryparam.state = 'c'
   LET g_detail_idx  = 1
   LET g_detail_idx2 = 1
 
   LET g_wc_filter_t = g_wc_filter
   LET g_wc_t = g_wc
 
   CALL gfrm_curr.setFieldHidden("formonly.sel", TRUE)
   CALL gfrm_curr.setFieldHidden("formonly.b_statepic", TRUE)
 
   
 
   LET g_wc = cl_replace_str(g_wc, g_wc_filter, '')
 
   #使用DIALOG包住 單頭CONSTRUCT及單身CONSTRUCT
   #應用 qs08 樣板自動產生(Version:5)
   #+ filter段DIALOG段的組成
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
 
      #單頭
      CONSTRUCT g_wc_filter ON psca001_9,psca001_10,psca001_11,psca001_12,psca001_13,psca001_14,psca001_15, 
          psca001_16,psca001_17,psca001_18,psca001_1,psca001_19,psca001_20,psca001_21,psca001_22,psca001_23, 
          psca001_24,psca001_25,psca001_26,psca001_27,psca001_28,psca001_2,psca001_29,psca001_30,psca001_31, 
          psca001_32,psca001_33,psca001_34,psca001_35,psca001_3,psca001_4,psca001_5,psca001_6,psca001_7, 
          psca001_8
                          FROM s_detail10[1].b_psca001_9,s_detail11[1].b_psca001_10,s_detail12[1].b_psca001_11, 
                              s_detail13[1].b_psca001_12,s_detail14[1].b_psca001_13,s_detail15[1].b_psca001_14, 
                              s_detail16[1].b_psca001_15,s_detail17[1].b_psca001_16,s_detail18[1].b_psca001_17, 
                              s_detail19[1].b_psca001_18,s_detail2[1].b_psca001_1,s_detail20[1].b_psca001_19, 
                              s_detail21[1].b_psca001_20,s_detail22[1].b_psca001_21,s_detail23[1].b_psca001_22, 
                              s_detail24[1].b_psca001_23,s_detail25[1].b_psca001_24,s_detail26[1].b_psca001_25, 
                              s_detail27[1].b_psca001_26,s_detail28[1].b_psca001_27,s_detail29[1].b_psca001_28, 
                              s_detail3[1].b_psca001_2,s_detail30[1].b_psca001_29,s_detail31[1].b_psca001_30, 
                              s_detail32[1].b_psca001_31,s_detail33[1].b_psca001_32,s_detail34[1].b_psca001_33, 
                              s_detail35[1].b_psca001_34,s_detail36[1].b_psca001_35,s_detail4[1].b_psca001_3, 
                              s_detail5[1].b_psca001_4,s_detail6[1].b_psca001_5,s_detail7[1].b_psca001_6, 
                              s_detail8[1].b_psca001_7,s_detail9[1].b_psca001_8
 
         BEFORE CONSTRUCT
                     DISPLAY apsq102_filter_parser('psca001_9') TO s_detail10[1].b_psca001_9
            DISPLAY apsq102_filter_parser('psca001_10') TO s_detail11[1].b_psca001_10
            DISPLAY apsq102_filter_parser('psca001_11') TO s_detail12[1].b_psca001_11
            DISPLAY apsq102_filter_parser('psca001_12') TO s_detail13[1].b_psca001_12
            DISPLAY apsq102_filter_parser('psca001_13') TO s_detail14[1].b_psca001_13
            DISPLAY apsq102_filter_parser('psca001_14') TO s_detail15[1].b_psca001_14
            DISPLAY apsq102_filter_parser('psca001_15') TO s_detail16[1].b_psca001_15
            DISPLAY apsq102_filter_parser('psca001_16') TO s_detail17[1].b_psca001_16
            DISPLAY apsq102_filter_parser('psca001_17') TO s_detail18[1].b_psca001_17
            DISPLAY apsq102_filter_parser('psca001_18') TO s_detail19[1].b_psca001_18
            DISPLAY apsq102_filter_parser('psca001_1') TO s_detail2[1].b_psca001_1
            DISPLAY apsq102_filter_parser('psca001_19') TO s_detail20[1].b_psca001_19
            DISPLAY apsq102_filter_parser('psca001_20') TO s_detail21[1].b_psca001_20
            DISPLAY apsq102_filter_parser('psca001_21') TO s_detail22[1].b_psca001_21
            DISPLAY apsq102_filter_parser('psca001_22') TO s_detail23[1].b_psca001_22
            DISPLAY apsq102_filter_parser('psca001_23') TO s_detail24[1].b_psca001_23
            DISPLAY apsq102_filter_parser('psca001_24') TO s_detail25[1].b_psca001_24
            DISPLAY apsq102_filter_parser('psca001_25') TO s_detail26[1].b_psca001_25
            DISPLAY apsq102_filter_parser('psca001_26') TO s_detail27[1].b_psca001_26
            DISPLAY apsq102_filter_parser('psca001_27') TO s_detail28[1].b_psca001_27
            DISPLAY apsq102_filter_parser('psca001_28') TO s_detail29[1].b_psca001_28
            DISPLAY apsq102_filter_parser('psca001_2') TO s_detail3[1].b_psca001_2
            DISPLAY apsq102_filter_parser('psca001_29') TO s_detail30[1].b_psca001_29
            DISPLAY apsq102_filter_parser('psca001_30') TO s_detail31[1].b_psca001_30
            DISPLAY apsq102_filter_parser('psca001_31') TO s_detail32[1].b_psca001_31
            DISPLAY apsq102_filter_parser('psca001_32') TO s_detail33[1].b_psca001_32
            DISPLAY apsq102_filter_parser('psca001_33') TO s_detail34[1].b_psca001_33
            DISPLAY apsq102_filter_parser('psca001_34') TO s_detail35[1].b_psca001_34
            DISPLAY apsq102_filter_parser('psca001_35') TO s_detail36[1].b_psca001_35
            DISPLAY apsq102_filter_parser('psca001_3') TO s_detail4[1].b_psca001_3
            DISPLAY apsq102_filter_parser('psca001_4') TO s_detail5[1].b_psca001_4
            DISPLAY apsq102_filter_parser('psca001_5') TO s_detail6[1].b_psca001_5
            DISPLAY apsq102_filter_parser('psca001_6') TO s_detail7[1].b_psca001_6
            DISPLAY apsq102_filter_parser('psca001_7') TO s_detail8[1].b_psca001_7
            DISPLAY apsq102_filter_parser('psca001_8') TO s_detail9[1].b_psca001_8
 
 
         #單身公用欄位開窗相關處理
         
 
         #單身一般欄位開窗相關處理
                  #----<<sel>>----
         #----<<l_xmdadocno>>----
         #----<<l_xmdd001>>----
         #----<<l_xmdd006>>----
         #----<<l_xmdd011>>----
         #----<<l_xmda004>>----
         #----<<l_type>>----
         #----<<l_xmdd014>>----
         #----<<l_xmdd004>>----
         #----<<l_delay>>----
         #----<<l_xmdd002>>----
         #----<<l_scheduled>>----
         #----<<l_consume>>----
         #----<<l_priority>>----
         #----<<l_transfer>>----
         #----<<l_pseb007>>----
         #----<<b_psca001_9>>----
         #Ctrlp:construct.c.filter.page10.b_psca001_9
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_psca001_9
            #add-point:ON ACTION controlp INFIELD b_psca001_9 name="construct.c.filter.page10.b_psca001_9"
            
            #END add-point
 
 
         #----<<l_inab001>>----
         #----<<l_inab002>>----
         #----<<l_inab005>>----
         #----<<l_consigned>>----
         #----<<b_psca001_10>>----
         #Ctrlp:construct.c.filter.page11.b_psca001_10
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_psca001_10
            #add-point:ON ACTION controlp INFIELD b_psca001_10 name="construct.c.filter.page11.b_psca001_10"
            
            #END add-point
 
 
         #----<<l_bmca001>>----
         #----<<l_bmca009>>----
         #----<<l_bmca005>>----
         #----<<l_bmca003>>----
         #----<<l_bmcb011>>----
         #----<<l_bmcb012>>----
         #----<<b_psca001_11>>----
         #Ctrlp:construct.c.filter.page12.b_psca001_11
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_psca001_11
            #add-point:ON ACTION controlp INFIELD b_psca001_11 name="construct.c.filter.page12.b_psca001_11"
            
            #END add-point
 
 
         #----<<l_bmc001>>----
         #----<<l_bmcc009>>----
         #----<<l_bmcd010>>----
         #----<<l_bmcc005>>----
         #----<<l_bmcc003>>----
         #----<<l_bmcd011>>----
         #----<<l_bmcc010>>----
         #----<<b_psca001_12>>----
         #Ctrlp:construct.c.page13.b_psca001_12
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_psca001_12
            #add-point:ON ACTION controlp INFIELD b_psca001_12 name="construct.c.filter.page13.b_psca001_12"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_psca001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_psca001_12  #顯示到畫面上
            NEXT FIELD b_psca001_12                     #返回原欄位
    


            #END add-point
 
 
         #----<<l_imec001>>----
         #----<<l_imec002>>----
         #----<<l_imec003>>----
         #----<<b_psca001_13>>----
         #Ctrlp:construct.c.filter.page14.b_psca001_13
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_psca001_13
            #add-point:ON ACTION controlp INFIELD b_psca001_13 name="construct.c.filter.page14.b_psca001_13"
            
            #END add-point
 
 
         #----<<l_bmce001>>----
         #----<<l_bmce005>>----
         #----<<l_bmce003>>----
         #----<<l_bmce009>>----
         #----<<l_bmce010>>----
         #----<<b_psca001_14>>----
         #Ctrlp:construct.c.page15.b_psca001_14
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_psca001_14
            #add-point:ON ACTION controlp INFIELD b_psca001_14 name="construct.c.filter.page15.b_psca001_14"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_psca001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_psca001_14  #顯示到畫面上
            NEXT FIELD b_psca001_14                     #返回原欄位
    


            #END add-point
 
 
         #----<<l_bmab001>>----
         #----<<l_bmab003>>----
         #----<<l_type_1>>----
         #----<<l_bmab004>>----
         #----<<b_psca001_15>>----
         #Ctrlp:construct.c.page16.b_psca001_15
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_psca001_15
            #add-point:ON ACTION controlp INFIELD b_psca001_15 name="construct.c.filter.page16.b_psca001_15"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_psca001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_psca001_15  #顯示到畫面上
            NEXT FIELD b_psca001_15                     #返回原欄位
    


            #END add-point
 
 
         #----<<l_bmea001>>----
         #----<<l_bmea003>>----
         #----<<l_bmea008>>----
         #----<<l_bmea015>>----
         #----<<l_bmea011>>----
         #----<<l_bmea009>>----
         #----<<l_bmea010>>----
         #----<<l_bmea012>>----
         #----<<l_bmea007>>----
         #----<<l_bmea017>>----
         #----<<l_bmea016>>----
         #----<<b_psca001_16>>----
         #Ctrlp:construct.c.filter.page17.b_psca001_16
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_psca001_16
            #add-point:ON ACTION controlp INFIELD b_psca001_16 name="construct.c.filter.page17.b_psca001_16"
            
            #END add-point
 
 
         #----<<l_bmea001_1>>----
         #----<<l_bmea008_1>>----
         #----<<l_bmea015_1>>----
         #----<<l_bmea011_1>>----
         #----<<l_bmea009_1>>----
         #----<<l_bmea010_1>>----
         #----<<l_bmea012_1>>----
         #----<<l_bmea007_1>>----
         #----<<l_bmea017_1>>----
         #----<<l_bmea016_1>>----
         #----<<b_psca001_17>>----
         #Ctrlp:construct.c.filter.page18.b_psca001_17
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_psca001_17
            #add-point:ON ACTION controlp INFIELD b_psca001_17 name="construct.c.filter.page18.b_psca001_17"
            
            #END add-point
 
 
         #----<<l_ecaa001>>----
         #----<<b_psca001_18>>----
         #Ctrlp:construct.c.filter.page19.b_psca001_18
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_psca001_18
            #add-point:ON ACTION controlp INFIELD b_psca001_18 name="construct.c.filter.page19.b_psca001_18"
            
            #END add-point
 
 
         #----<<l_bmbb001>>----
         #----<<l_bmbb003>>----
         #----<<l_seq>>----
         #----<<l_seq1>>----
         #----<<l_bmbb009>>----
         #----<<l_bmbb010>>----
         #----<<l_shrinkage_1>>----
         #----<<l_bmbb011>>----
         #----<<l_bmbb012>>----
         #----<<b_psca001_1>>----
         #Ctrlp:construct.c.filter.page2.b_psca001_1
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_psca001_1
            #add-point:ON ACTION controlp INFIELD b_psca001_1 name="construct.c.filter.page2.b_psca001_1"
            
            #END add-point
 
 
         #----<<l_pmdodocno>>----
         #----<<l_pmdo001>>----
         #----<<l_pmdb006>>----
         #----<<l_new>>----
         #----<<l_pmdl004>>----
         #----<<l_pmdo004>>----
         #----<<l_pmdo019>>----
         #----<<l_state>>----
         #----<<l_pmdo014>>----
         #----<<l_pmdo002>>----
         #----<<l_pmdo016>>----
         #----<<l_pmdo015>>----
         #----<<l_pmdldocdt>>----
         #----<<l_pmdo012>>----
         #----<<l_pmdo013>>----
         #----<<l_pmdo017>>----
         #----<<l_pmdo015_1>>----
         #----<<l_transfer_1>>----
         #----<<l_hardpegging>>----
         #----<<b_psca001_19>>----
         #Ctrlp:construct.c.page20.b_psca001_19
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_psca001_19
            #add-point:ON ACTION controlp INFIELD b_psca001_19 name="construct.c.filter.page20.b_psca001_19"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_psca001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_psca001_19  #顯示到畫面上
            NEXT FIELD b_psca001_19                     #返回原欄位
    


            #END add-point
 
 
         #----<<l_psoa003>>----
         #----<<l_psoa004>>----
         #----<<l_psoa005>>----
         #----<<l_psoa006>>----
         #----<<l_psoa007>>----
         #----<<l_psoa008>>----
         #----<<l_psoa009>>----
         #----<<l_psoa010>>----
         #----<<l_psoa011>>----
         #----<<l_psoa012>>----
         #----<<l_psoa013>>----
         #----<<l_psoa014>>----
         #----<<l_psoa015>>----
         #----<<l_psoa016>>----
         #----<<l_psoa017>>----
         #----<<l_psoa018>>----
         #----<<l_psoa019>>----
         #----<<l_psoa020>>----
         #----<<l_psoa021>>----
         #----<<l_psoa022>>----
         #----<<l_psoa023>>----
         #----<<b_psca001_20>>----
         #Ctrlp:construct.c.page21.b_psca001_20
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_psca001_20
            #add-point:ON ACTION controlp INFIELD b_psca001_20 name="construct.c.filter.page21.b_psca001_20"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_psca001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_psca001_20  #顯示到畫面上
            NEXT FIELD b_psca001_20                     #返回原欄位
    


            #END add-point
 
 
         #----<<l_psod003>>----
         #----<<l_psod004>>----
         #----<<l_psod005>>----
         #----<<l_psod006>>----
         #----<<l_psod007>>----
         #----<<l_psod008>>----
         #----<<l_psod009>>----
         #----<<l_psod010>>----
         #----<<l_psod011>>----
         #----<<l_psod012>>----
         #----<<l_psod013>>----
         #----<<l_psod014>>----
         #----<<l_psod015>>----
         #----<<l_psod016>>----
         #----<<l_psod017>>----
         #----<<b_psca001_21>>----
         #Ctrlp:construct.c.page22.b_psca001_21
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_psca001_21
            #add-point:ON ACTION controlp INFIELD b_psca001_21 name="construct.c.filter.page22.b_psca001_21"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_psca001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_psca001_21  #顯示到畫面上
            NEXT FIELD b_psca001_21                     #返回原欄位
    


            #END add-point
 
 
         #----<<l_psoc003>>----
         #----<<l_psoc004>>----
         #----<<l_psoc005>>----
         #----<<l_psoc006>>----
         #----<<l_psoc007>>----
         #----<<l_psoc008_1>>----
         #----<<l_psoc009>>----
         #----<<l_psoc010>>----
         #----<<l_psoc011>>----
         #----<<l_psoc012>>----
         #----<<l_psoc013>>----
         #----<<l_psoc014>>----
         #----<<l_psoc015>>----
         #----<<l_psoc016>>----
         #----<<l_psoc017>>----
         #----<<l_psoc018>>----
         #----<<l_psoc019>>----
         #----<<l_psoc020>>----
         #----<<l_psoc021>>----
         #----<<l_psoc022>>----
         #----<<l_psoc023>>----
         #----<<l_psoc025>>----
         #----<<l_psoc022_1>>----
         #----<<l_psoc022_2>>----
         #----<<l_psoc022_3>>----
         #----<<b_psca001_22>>----
         #Ctrlp:construct.c.page23.b_psca001_22
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_psca001_22
            #add-point:ON ACTION controlp INFIELD b_psca001_22 name="construct.c.filter.page23.b_psca001_22"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_psca001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_psca001_22  #顯示到畫面上
            NEXT FIELD b_psca001_22                     #返回原欄位
    


            #END add-point
 
 
         #----<<l_psoa003_1>>----
         #----<<l_psoa004_1>>----
         #----<<l_psoa005_1>>----
         #----<<l_psoa006_1>>----
         #----<<l_psoa007_1>>----
         #----<<l_psoa008_1>>----
         #----<<l_psoa009_1>>----
         #----<<l_psoa010_1>>----
         #----<<l_psoa011_1>>----
         #----<<l_psoa012_1>>----
         #----<<l_psoa013_1>>----
         #----<<l_psoa014_1>>----
         #----<<l_psoa015_1>>----
         #----<<l_psoa016_1>>----
         #----<<l_psoa017_1>>----
         #----<<l_psoa018_1>>----
         #----<<l_psoa019_1>>----
         #----<<l_psoa020_1>>----
         #----<<l_psoa021_1>>----
         #----<<l_psoa023_1>>----
         #----<<b_psca001_23>>----
         #Ctrlp:construct.c.page24.b_psca001_23
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_psca001_23
            #add-point:ON ACTION controlp INFIELD b_psca001_23 name="construct.c.filter.page24.b_psca001_23"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_psca001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_psca001_23  #顯示到畫面上
            NEXT FIELD b_psca001_23                     #返回原欄位
    



            #END add-point
 
 
         #----<<l_sfbadocno_1>>----
         #----<<l_sfba006_1>>----
         #----<<l_sfbaseq_2>>----
         #----<<l_sfbaseq_1_1>>----
         #----<<l_release_2>>----
         #----<<l_sfba019_1>>----
         #----<<l_demand_1>>----
         #----<<l_sfba020_1>>----
         #----<<l_sfba028_1>>----
         #----<<l_sfba003_1>>----
         #----<<l_sfba009_1>>----
         #----<<l_sfba007_1>>----
         #----<<l_sfaa003_1>>----
         #----<<l_sfba021_1>>----
         #----<<b_psca001_24>>----
         #Ctrlp:construct.c.filter.page25.b_psca001_24
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_psca001_24
            #add-point:ON ACTION controlp INFIELD b_psca001_24 name="construct.c.filter.page25.b_psca001_24"
            
            #END add-point
 
 
         #----<<l_psob003>>----
         #----<<l_psob004>>----
         #----<<l_psob005>>----
         #----<<l_psob006>>----
         #----<<l_psob007>>----
         #----<<l_psob008>>----
         #----<<l_psob009>>----
         #----<<l_psob010>>----
         #----<<l_psob011>>----
         #----<<l_psob012>>----
         #----<<l_psob013>>----
         #----<<l_psob016>>----
         #----<<b_psca001_25>>----
         #Ctrlp:construct.c.filter.page26.b_psca001_25
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_psca001_25
            #add-point:ON ACTION controlp INFIELD b_psca001_25 name="construct.c.filter.page26.b_psca001_25"
            
            #END add-point
 
 
         #----<<l_equip_type>>----
         #----<<l_equip_id>>----
         #----<<l_ws_id>>----
         #----<<l_efficency>>----
         #----<<l_capacity_type>>----
         #----<<l_day_calendar_id>>----
         #----<<l_week_calendar_id>>----
         #----<<b_psca001_26>>----
         #Ctrlp:construct.c.filter.page27.b_psca001_26
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_psca001_26
            #add-point:ON ACTION controlp INFIELD b_psca001_26 name="construct.c.filter.page27.b_psca001_26"
            
            #END add-point
 
 
         #----<<l_equip_group_id>>----
         #----<<l_equip_type_1>>----
         #----<<l_is_outsourcing>>----
         #----<<l_equip_id_1>>----
         #----<<l_priority_1>>----
         #----<<b_psca001_27>>----
         #Ctrlp:construct.c.filter.page28.b_psca001_27
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_psca001_27
            #add-point:ON ACTION controlp INFIELD b_psca001_27 name="construct.c.filter.page28.b_psca001_27"
            
            #END add-point
 
 
         #----<<l_mrbh001_1>>----
         #----<<l_mrbh002>>----
         #----<<l_mrbh003>>----
         #----<<l_mrbh004>>----
         #----<<l_mrbh005>>----
         #----<<b_psca001_28>>----
         #Ctrlp:construct.c.filter.page29.b_psca001_28
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_psca001_28
            #add-point:ON ACTION controlp INFIELD b_psca001_28 name="construct.c.filter.page29.b_psca001_28"
            
            #END add-point
 
 
         #----<<l_week_calendar_id_1>>----
         #----<<l_mom_wm_id>>----
         #----<<l_tue_wm_id>>----
         #----<<l_wed_wm_id>>----
         #----<<l_thu_wm_id>>----
         #----<<l_fri_wm_id>>----
         #----<<l_sat_wm_id>>----
         #----<<l_sun_wm_id>>----
         #----<<b_psca001_2>>----
         #Ctrlp:construct.c.filter.page3.b_psca001_2
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_psca001_2
            #add-point:ON ACTION controlp INFIELD b_psca001_2 name="construct.c.filter.page3.b_psca001_2"
            
            #END add-point
 
 
         #----<<l_sfaadocno>>----
         #----<<l_sfaa012>>----
         #----<<l_sfaa020>>----
         #----<<l_sfaa019>>----
         #----<<l_sfaa010>>----
         #----<<l_sfaadocno1>>----
         #----<<l_sfaa013>>----
         #----<<l_sfaa056>>----
         #----<<l_new_1>>----
         #----<<l_produced>>----
         #----<<l_sfaa022>>----
         #----<<l_sfaa021>>----
         #----<<l_feature>>----
         #----<<l_firm>>----
         #----<<l_exploration>>----
         #----<<l_material>>----
         #----<<l_hardpegging_1>>----
         #----<<b_psca001_29>>----
         #Ctrlp:construct.c.filter.page30.b_psca001_29
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_psca001_29
            #add-point:ON ACTION controlp INFIELD b_psca001_29 name="construct.c.filter.page30.b_psca001_29"
            
            #END add-point
 
 
         #----<<l_wm_id>>----
         #----<<l_start_time>>----
         #----<<l_end_time>>----
         #----<<l_type_2>>----
         #----<<b_psca001_30>>----
         #Ctrlp:construct.c.filter.page31.b_psca001_30
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_psca001_30
            #add-point:ON ACTION controlp INFIELD b_psca001_30 name="construct.c.filter.page31.b_psca001_30"
            
            #END add-point
 
 
         #----<<l_imaa001_1>>----
         #----<<l_imaf026_1>>----
         #----<<l_sizing_1>>----
         #----<<l_used_2>>----
         #----<<l_integer_1>>----
         #----<<l_imaf013_1>>----
         #----<<l_imaa006_1>>----
         #----<<l_imae022_1>>----
         #----<<l_imae018_1>>----
         #----<<l_imae017_1>>----
         #----<<l_imae080_1>>----
         #----<<l_imaa004_1>>----
         #----<<l_imae064_2>>----
         #----<<l_mfg_2>>----
         #----<<l_order_1>>----
         #----<<l_feature_1_1>>----
         #----<<l_imaf171_2>>----
         #----<<l_imaf171_3>>----
         #----<<l_consume_1_1>>----
         #----<<l_release_1_1>>----
         #----<<l_lastqty_1>>----
         #----<<l_combine_1>>----
         #----<<l_inspect_1>>----
         #----<<l_consign_1>>----
         #----<<l_imaf143_1>>----
         #----<<l_purchase_1>>----
         #----<<l_imae016_1>>----
         #----<<l_mfg_1_1>>----
         #----<<l_imaa105_1>>----
         #----<<l_sales_1>>----
         #----<<l_imae064_1_1>>----
         #----<<l_alt_2>>----
         #----<<l_break_1>>----
         #----<<l_create_2>>----
         #----<<l_supratio_1>>----
         #----<<l_imaf153_1>>----
         #----<<l_backward_1>>----
         #----<<l_batch_1>>----
         #----<<l_setup_1>>----
         #----<<l_imae052_1>>----
         #----<<l_imae077_1>>----
         #----<<l_base_1>>----
         #----<<l_max_batch_size_1>>----
         #----<<l_imae032_1>>----
         #----<<l_outsourcing_1>>----
         #----<<l_imae072_1>>----
         #----<<l_imae073_1>>----
         #----<<l_var_1>>----
         #----<<l_auto_1>>----
         #----<<l_consolidate_1>>----
         #----<<l_phase_1>>----
         #----<<l_spare_1>>----
         #----<<l_due_1>>----
         #----<<l_imae015_1>>----
         #----<<l_imaa005_1>>----
         #----<<l_imae078_1>>----
         #----<<l_imae079_1>>----
         #----<<l_imae083_1>>----
         #----<<l_imae082_1>>----
         #----<<b_psca001_31>>----
         #Ctrlp:construct.c.filter.page32.b_psca001_31
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_psca001_31
            #add-point:ON ACTION controlp INFIELD b_psca001_31 name="construct.c.filter.page32.b_psca001_31"
            
            #END add-point
 
 
         #----<<l_bmba001_1>>----
         #----<<l_bmba003_1>>----
         #----<<l_ecba001>>----
         #----<<l_ecbb003>>----
         #----<<l_bmba007_1>>----
         #----<<b_psca001_32>>----
         #Ctrlp:construct.c.filter.page33.b_psca001_32
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_psca001_32
            #add-point:ON ACTION controlp INFIELD b_psca001_32 name="construct.c.filter.page33.b_psca001_32"
            
            #END add-point
 
 
         #----<<l_part_id>>----
         #----<<l_imae033>>----
         #----<<l_sequ_num>>----
         #----<<l_is_alt>>----
         #----<<b_psca001_33>>----
         #Ctrlp:construct.c.filter.page34.b_psca001_33
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_psca001_33
            #add-point:ON ACTION controlp INFIELD b_psca001_33 name="construct.c.filter.page34.b_psca001_33"
            
            #END add-point
 
 
         #----<<l_ecbb001>>----
         #----<<l_ecbb002>>----
         #----<<l_ecbb003_1>>----
         #----<<l_ecbb004>>----
         #----<<l_equip_type_2>>----
         #----<<l_ecbb037>>----
         #----<<l_is_batch>>----
         #----<<l_ecbb026>>----
         #----<<l_ecbb027>>----
         #----<<l_imae077_2>>----
         #----<<l_imae077_3>>----
         #----<<l_ecbb012>>----
         #----<<b_psca001_34>>----
         #Ctrlp:construct.c.filter.page35.b_psca001_34
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_psca001_34
            #add-point:ON ACTION controlp INFIELD b_psca001_34 name="construct.c.filter.page35.b_psca001_34"
            
            #END add-point
 
 
         #----<<l_ecaa001_1>>----
         #----<<b_psca001_35>>----
         #Ctrlp:construct.c.filter.page36.b_psca001_35
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_psca001_35
            #add-point:ON ACTION controlp INFIELD b_psca001_35 name="construct.c.filter.page36.b_psca001_35"
            
            #END add-point
 
 
         #----<<l_ecbe001>>----
         #----<<l_ecbe005>>----
         #----<<l_ecbe003>>----
         #----<<b_psca001_3>>----
         #Ctrlp:construct.c.filter.page4.b_psca001_3
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_psca001_3
            #add-point:ON ACTION controlp INFIELD b_psca001_3 name="construct.c.filter.page4.b_psca001_3"
            
            #END add-point
 
 
         #----<<l_sfbadocno>>----
         #----<<l_sfba006>>----
         #----<<l_sfbaseq>>----
         #----<<l_sfbaseq_1>>----
         #----<<l_release>>----
         #----<<l_sfba019>>----
         #----<<l_demand>>----
         #----<<l_sfba020>>----
         #----<<l_sfba028>>----
         #----<<l_sfba003>>----
         #----<<l_sfba009>>----
         #----<<l_sfba007>>----
         #----<<l_sfaa003>>----
         #----<<l_sfba021>>----
         #----<<l_sfba001>>----
         #----<<l_sfba005>>----
         #----<<b_psca001_4>>----
         #Ctrlp:construct.c.filter.page5.b_psca001_4
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_psca001_4
            #add-point:ON ACTION controlp INFIELD b_psca001_4 name="construct.c.filter.page5.b_psca001_4"
            
            #END add-point
 
 
         #----<<l_imaa001>>----
         #----<<l_imaf026>>----
         #----<<l_sizing>>----
         #----<<l_used>>----
         #----<<l_integer>>----
         #----<<l_imaf013>>----
         #----<<l_imaa006>>----
         #----<<l_imae022>>----
         #----<<l_imae018>>----
         #----<<l_imae017>>----
         #----<<l_imae080>>----
         #----<<l_imaa004>>----
         #----<<l_imae064>>----
         #----<<l_mfg>>----
         #----<<l_order>>----
         #----<<l_feature_1>>----
         #----<<l_imaf171>>----
         #----<<l_imaf171_1>>----
         #----<<l_consume_1>>----
         #----<<l_release_1>>----
         #----<<l_lastqty>>----
         #----<<l_combine>>----
         #----<<l_inspect>>----
         #----<<l_consign>>----
         #----<<l_imaf143>>----
         #----<<l_purchase>>----
         #----<<l_imae016>>----
         #----<<l_mfg_1>>----
         #----<<l_imaa105>>----
         #----<<l_sales>>----
         #----<<l_imae064_1>>----
         #----<<l_alt>>----
         #----<<l_break>>----
         #----<<l_create>>----
         #----<<l_supratio>>----
         #----<<l_imaf153>>----
         #----<<l_backward>>----
         #----<<l_batch>>----
         #----<<l_setup>>----
         #----<<l_imae052>>----
         #----<<l_imae077>>----
         #----<<l_base>>----
         #----<<l_max_batch_size>>----
         #----<<l_imae032>>----
         #----<<l_outsourcing>>----
         #----<<l_imae072>>----
         #----<<l_imae073>>----
         #----<<l_var>>----
         #----<<l_auto>>----
         #----<<l_consolidate>>----
         #----<<l_phase>>----
         #----<<l_spare>>----
         #----<<l_due>>----
         #----<<l_imae015>>----
         #----<<l_imaa005>>----
         #----<<l_imae078>>----
         #----<<l_imae079>>----
         #----<<l_imae083>>----
         #----<<l_imae082>>----
         #----<<b_psca001_5>>----
         #Ctrlp:construct.c.filter.page6.b_psca001_5
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_psca001_5
            #add-point:ON ACTION controlp INFIELD b_psca001_5 name="construct.c.filter.page6.b_psca001_5"
            
            #END add-point
 
 
         #----<<l_imeb001>>----
         #----<<l_imeb002>>----
         #----<<l_imeb004>>----
         #----<<l_imeb006>>----
         #----<<l_imeb005>>----
         #----<<l_imeb010>>----
         #----<<l_imeb011>>----
         #----<<l_imeb008>>----
         #----<<l_imeb009>>----
         #----<<b_psca001_6>>----
         #Ctrlp:construct.c.filter.page7.b_psca001_6
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_psca001_6
            #add-point:ON ACTION controlp INFIELD b_psca001_6 name="construct.c.filter.page7.b_psca001_6"
            
            #END add-point
 
 
         #----<<l_bmba001>>----
         #----<<l_bmba012>>----
         #----<<l_bmba003>>----
         #----<<l_bmba009>>----
         #----<<l_bmba011>>----
         #----<<l_shrinkage>>----
         #----<<l_bmba013>>----
         #----<<l_bmba031>>----
         #----<<l_alt_1>>----
         #----<<l_create_1>>----
         #----<<l_ratio>>----
         #----<<l_bmba007>>----
         #----<<l_bmba021>>----
         #----<<l_used_1>>----
         #----<<l_substitute>>----
         #----<<l_fixed>>----
         #----<<l_bmba023>>----
         #----<<l_bmba004>>----
         #----<<l_bmba008>>----
         #----<<l_quantity>>----
         #----<<b_psca001_7>>----
         #Ctrlp:construct.c.filter.page8.b_psca001_7
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_psca001_7
            #add-point:ON ACTION controlp INFIELD b_psca001_7 name="construct.c.filter.page8.b_psca001_7"
            
            #END add-point
 
 
         #----<<l_inag001>>----
         #----<<l_inag004>>----
         #----<<l_inag005>>----
         #----<<l_inag009>>----
         #----<<l_inag002>>----
         #----<<l_hard>>----
         #----<<b_psca001_8>>----
         #Ctrlp:construct.c.page9.b_psca001_8
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_psca001_8
            #add-point:ON ACTION controlp INFIELD b_psca001_8 name="construct.c.filter.page9.b_psca001_8"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_psca001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_psca001_8  #顯示到畫面上
            NEXT FIELD b_psca001_8                     #返回原欄位
    


            #END add-point
 
 
         #----<<l_inaa001>>----
         #----<<l_inaa006>>----
 
 
      END CONSTRUCT
 
      #add-point:filter段add_cs name="filter.add_cs"
      
      #end add-point
 
      BEFORE DIALOG
         #add-point:filter段b_dialog name="filter.b_dialog"
         
         #end add-point
 
      ON ACTION accept
         ACCEPT DIALOG
 
      ON ACTION cancel
         LET INT_FLAG = 1
         EXIT DIALOG
 
      #交談指令共用ACTION
      &include "common_action.4gl"
         CONTINUE DIALOG
 
   END DIALOG
 
 
 
 
 
   
 
   #add-point:離開DIALOG後相關處理 name="filter.after_dialog"
   
   #end add-point
 
   IF NOT INT_FLAG THEN
      LET g_wc_filter = g_wc_filter, " "
   ELSE
      LET g_wc_filter = g_wc_filter_t
   END IF
 
      CALL apsq102_filter_show('psca001_9','b_psca001_9')
   CALL apsq102_filter_show('psca001_10','b_psca001_10')
   CALL apsq102_filter_show('psca001_11','b_psca001_11')
   CALL apsq102_filter_show('psca001_12','b_psca001_12')
   CALL apsq102_filter_show('psca001_13','b_psca001_13')
   CALL apsq102_filter_show('psca001_14','b_psca001_14')
   CALL apsq102_filter_show('psca001_15','b_psca001_15')
   CALL apsq102_filter_show('psca001_16','b_psca001_16')
   CALL apsq102_filter_show('psca001_17','b_psca001_17')
   CALL apsq102_filter_show('psca001_18','b_psca001_18')
   CALL apsq102_filter_show('psca001_1','b_psca001_1')
   CALL apsq102_filter_show('psca001_19','b_psca001_19')
   CALL apsq102_filter_show('psca001_20','b_psca001_20')
   CALL apsq102_filter_show('psca001_21','b_psca001_21')
   CALL apsq102_filter_show('psca001_22','b_psca001_22')
   CALL apsq102_filter_show('psca001_23','b_psca001_23')
   CALL apsq102_filter_show('psca001_24','b_psca001_24')
   CALL apsq102_filter_show('psca001_25','b_psca001_25')
   CALL apsq102_filter_show('psca001_26','b_psca001_26')
   CALL apsq102_filter_show('psca001_27','b_psca001_27')
   CALL apsq102_filter_show('psca001_28','b_psca001_28')
   CALL apsq102_filter_show('psca001_2','b_psca001_2')
   CALL apsq102_filter_show('psca001_29','b_psca001_29')
   CALL apsq102_filter_show('psca001_30','b_psca001_30')
   CALL apsq102_filter_show('psca001_31','b_psca001_31')
   CALL apsq102_filter_show('psca001_32','b_psca001_32')
   CALL apsq102_filter_show('psca001_33','b_psca001_33')
   CALL apsq102_filter_show('psca001_34','b_psca001_34')
   CALL apsq102_filter_show('psca001_35','b_psca001_35')
   CALL apsq102_filter_show('psca001_3','b_psca001_3')
   CALL apsq102_filter_show('psca001_4','b_psca001_4')
   CALL apsq102_filter_show('psca001_5','b_psca001_5')
   CALL apsq102_filter_show('psca001_6','b_psca001_6')
   CALL apsq102_filter_show('psca001_7','b_psca001_7')
   CALL apsq102_filter_show('psca001_8','b_psca001_8')
 
 
   CALL apsq102_b_fill()
 
   CALL gfrm_curr.setFieldHidden("formonly.sel", FALSE)
   CALL gfrm_curr.setFieldHidden("formonly.b_statepic", FALSE)
 
END FUNCTION
 
{</section>}
 
{<section id="apsq102.filter_parser" >}
#應用 qs14 樣板自動產生(Version:6)
#+ filter pasara段
#+ filter欄位解析
PRIVATE FUNCTION apsq102_filter_parser(ps_field)
   #add-point:filter段define-客製 name="filter_parser.define_customerization"
   
   #end add-point
   {<Local define>}
   DEFINE ps_field   STRING
   DEFINE ls_tmp     STRING
   DEFINE li_tmp     LIKE type_t.num5
   DEFINE li_tmp2    LIKE type_t.num5
   DEFINE ls_var     STRING
   {</Local define>}
   #add-point:filter段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="filter_parser.define"
   
   #end add-point
 
   #add-point:FUNCTION前置處理 name="filter_parser.before_function"
   
   #end add-point
 
   #一般條件解析
   LET ls_tmp = ps_field, "='"
   LET li_tmp = g_wc_filter.getIndexOf(ls_tmp,1)
   IF li_tmp > 0 THEN
      LET li_tmp = ls_tmp.getLength() + li_tmp
      LET li_tmp2 = g_wc_filter.getIndexOf("'",li_tmp + 1) - 1
      LET ls_var = g_wc_filter.subString(li_tmp,li_tmp2)
   END IF
 
   #模糊條件解析
   LET ls_tmp = ps_field, " like '"
   LET li_tmp = g_wc_filter.getIndexOf(ls_tmp,1)
   IF li_tmp > 0 THEN
      LET li_tmp = ls_tmp.getLength() + li_tmp
      LET li_tmp2 = g_wc_filter.getIndexOf("'",li_tmp + 1) - 1
      LET ls_var = g_wc_filter.subString(li_tmp,li_tmp2)
      LET ls_var = cl_replace_str(ls_var,'%','*')
   END IF
 
   RETURN ls_var
 
END FUNCTION
 
 
{</section>}
 
{<section id="apsq102.filter_show" >}
#應用 qs15 樣板自動產生(Version:6)
#+ filter標題欄位顯示搜尋條件
PRIVATE FUNCTION apsq102_filter_show(ps_field,ps_object)
   #add-point:filter_show段define-客製 name="filter_show.define_customerization"
   
   #end add-point
   DEFINE ps_field         STRING
   DEFINE ps_object        STRING
   DEFINE lnode_item       om.DomNode
   DEFINE ls_title         STRING
   DEFINE ls_name          STRING
   DEFINE ls_condition     STRING
   #add-point:filter_show段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="filter_show.define"
   
   #end add-point
 
   #add-point:FUNCTION前置處理 name="filter_show.before_function"
   
   #end add-point
 
   LET ls_name = "formonly.", ps_object
 
 
   LET lnode_item = gfrm_curr.findNode("TableColumn", ls_name)
   LET ls_title = lnode_item.getAttribute("text")
   IF ls_title.getIndexOf('※',1) > 0 THEN
      LET ls_title = ls_title.subString(1,ls_title.getIndexOf('※',1)-1)
   END IF
 
   #顯示資料組合
   LET ls_condition = apsq102_filter_parser(ps_field)
   IF NOT cl_null(ls_condition) THEN
      LET ls_title = ls_title, '※', ls_condition, '※'
   END IF
 
   #將資料顯示回去
   CALL lnode_item.setAttribute("text",ls_title)
 
END FUNCTION
 
 
{</section>}
 
{<section id="apsq102.detail_action_trans" >}
#+ 單身分頁筆數顯示及action圖片顯示切換功能
PRIVATE FUNCTION apsq102_detail_action_trans()
   #add-point:detail_action_trans段define-客製 name="detail_action_trans.define_customerization"

   #end add-point
   #add-point:detail_action_trans段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="detail_action_trans.define"

   #end add-point
 
 
   #add-point:FUNCTION前置處理 name="detail_action_trans.before_function"

   #end add-point
 
   #因應單身切頁功能，筆數計算方式調整
   LET g_current_row_tot = g_pagestart + g_detail_idx - 1
   DISPLAY g_current_row_tot TO FORMONLY.h_index
   DISPLAY g_tot_cnt TO FORMONLY.h_count
 
   #顯示單身頁面的起始與結束筆數
   LET g_page_start_num = g_pagestart
   LET g_page_end_num = g_pagestart + g_num_in_page - 1
   DISPLAY g_page_start_num TO FORMONLY.p_start
   DISPLAY g_page_end_num TO FORMONLY.p_end
 
   #目前不支援跳頁功能
   LET g_page_act_list = "detail_first,detail_previous,'',detail_next,detail_last"
   CALL cl_navigator_detail_page_setting(g_page_act_list,g_current_row_tot,g_pagestart,g_num_in_page,g_tot_cnt)
 
END FUNCTION
 
{</section>}
 
{<section id="apsq102.detail_index_setting" >}
#+ 單身切頁後，index重新調整，避免翻頁後指到空白筆數
PRIVATE FUNCTION apsq102_detail_index_setting()
   #add-point:detail_index_setting段define-客製 name="detail_index_setting.define_customerization"

   #end add-point
   DEFINE li_redirect     BOOLEAN
   DEFINE ldig_curr       ui.Dialog
   #add-point:detail_index_setting段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="detail_index_setting.define"

   #end add-point
 
   #add-point:FUNCTION前置處理 name="detail_index_setting.before_function"

   #end add-point
 
   IF g_curr_diag IS NOT NULL THEN
      CASE
         WHEN g_curr_diag.getCurrentRow("s_detail1") <= "0"
            LET g_detail_idx = 1
            IF g_psca_d.getLength() > 0 THEN
               LET li_redirect = TRUE
            END IF
         WHEN g_curr_diag.getCurrentRow("s_detail1") > g_psca_d.getLength() AND g_psca_d.getLength() > 0
            LET g_detail_idx = g_psca_d.getLength()
            LET li_redirect = TRUE
         WHEN g_curr_diag.getCurrentRow("s_detail1") != g_detail_idx
            IF g_detail_idx > g_psca_d.getLength() THEN
               LET g_detail_idx = g_psca_d.getLength()
            END IF
            LET li_redirect = TRUE
      END CASE
   END IF
 
   IF li_redirect THEN
      LET ldig_curr = ui.Dialog.getCurrent()
      CALL ldig_curr.setCurrentRow("s_detail1", g_detail_idx)
   END IF
 
END FUNCTION
 
{</section>}
 
{<section id="apsq102.mask_functions" >}
 &include "erp/aps/apsq102_mask.4gl"
 
{</section>}
 
{<section id="apsq102.other_function" readonly="Y" >}

################################################################################
# Descriptions...: 需求訂單
# Memo...........:
# Usage..........: CALL apsq102_demand_order_id(p_str,p_c,p_name)
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 15/12/28 By Charles4m
# Modify.........:
################################################################################
PRIVATE FUNCTION apsq102_Demand_Order(p_str,p_c,p_name)
DEFINE p_str   STRING
DEFINE p_c     LIKE type_t.num10
DEFINE p_name  STRING

   CASE WHEN p_name = "demand_order_id"
           LET g_psca_d[p_c].l_xmdadocno = p_str
        WHEN p_name = "part_id"
           LET g_psca_d[p_c].l_xmdd001   = p_str
        WHEN p_name = "order_qty"
           LET g_psca_d[p_c].l_xmdd006   = p_str
        WHEN p_name = "due_date"
           LET g_psca_d[p_c].l_xmdd011   = p_str
        WHEN p_name = "customer_id"
           LET g_psca_d[p_c].l_xmda004   = p_str
        WHEN p_name = "order_type"
           LET g_psca_d[p_c].l_type      = p_str
        WHEN p_name = "shipped_qty"
           LET g_psca_d[p_c].l_xmdd014   = p_str
        WHEN p_name = "unit_id"
           LET g_psca_d[p_c].l_xmdd004   = p_str
        WHEN p_name = "is_non_delayed"
           LET g_psca_d[p_c].l_delay     = p_str
        WHEN p_name = "feature_code"
           LET g_psca_d[p_c].l_xmdd002   = p_str
        WHEN p_name = "is_scheduled"
           LET g_psca_d[p_c].l_scheduled = p_str
        WHEN p_name = "can_consume"
           LET g_psca_d[p_c].l_consume   = p_str
        WHEN p_name = "priority"
           LET g_psca_d[p_c].l_priority  = p_str
        WHEN p_name = "transfer_rate"
           LET g_psca_d[p_c].l_transfer  = p_str
        WHEN p_name = "alloc_rule_id"
           LET g_psca_d[p_c].l_pseb007   = p_str
   END CASE
END FUNCTION

################################################################################
# Descriptions...: 請採購單
# Memo...........:
# Usage..........: CALL apsq102_Suggest_Purchase_Order(p_str,p_c,p_name)
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 15/12/30 By Charles4m
# Modify.........:
################################################################################
PRIVATE FUNCTION apsq102_Suggest_Purchase_Order(p_str,p_c,p_name)
DEFINE p_str   STRING
DEFINE p_c     LIKE type_t.num10
DEFINE p_name  STRING

   CASE WHEN p_name = "purchase_order_id"
           LET g_psca2_d[p_c].l_pmdodocno = p_str
        WHEN p_name = "part_id"
           LET g_psca2_d[p_c].l_pmdo001   = p_str
        WHEN p_name = "purchase_qty"
           LET g_psca2_d[p_c].l_pmdb006   = p_str
        WHEN p_name = "is_new"
           LET g_psca2_d[p_c].l_new       = p_str
        WHEN p_name = "supplier_id"
           LET g_psca2_d[p_c].l_pmdl004   = p_str
        WHEN p_name = "unit_id"
           LET g_psca2_d[p_c].l_pmdo004   = p_str
        WHEN p_name = "stocked_qty"
           LET g_psca2_d[p_c].l_pmdo019   = p_str
        WHEN p_name = "state"
           LET g_psca2_d[p_c].l_state     = p_str
        WHEN p_name = "is_firm"
           LET g_psca2_d[p_c].l_pmdo014   = p_str
        WHEN p_name = "feature_code"
           LET g_psca2_d[p_c].l_pmdo002   = p_str
        WHEN p_name = "return_qty"
           LET g_psca2_d[p_c].l_pmdo016   = p_str
        WHEN p_name = "inspecting_qty"
           LET g_psca2_d[p_c].l_pmdo015   = p_str
        WHEN p_name = "firm_release_date"
           LET g_psca2_d[p_c].l_pmdldocdt = p_str
        WHEN p_name = "firm_available_date"
           LET g_psca2_d[p_c].l_pmdo012   = p_str
        WHEN p_name = "firm_supply_date"
           LET g_psca2_d[p_c].l_pmdo013   = p_str
        WHEN p_name = "exchange_qty"
           LET g_psca2_d[p_c].l_pmdo017   = p_str
        WHEN p_name = "received_qty"
           LET g_psca2_d[p_c].l_pmdo015_1 = p_str
        WHEN p_name = "transfer_rate"
           LET g_psca2_d[p_c].l_transfer_1  = p_str
        WHEN p_name = "hardpegging_type"
           LET g_psca2_d[p_c].l_hardpegging = p_str

   END CASE
END FUNCTION

################################################################################
# Descriptions...: 工單
# Memo...........:
# Usage..........: CALL apsq102_Suggest_Mfg_Order(p_str,p_c,p_name)
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 15/12/30 By Charles4m
# Modify.........:
################################################################################
PRIVATE FUNCTION apsq102_Suggest_Mfg_Order(p_str,p_c,p_name)
DEFINE p_str   STRING
DEFINE p_c     LIKE type_t.num10
DEFINE p_name  STRING

   CASE WHEN p_name = "mfg_order_id"
           LET g_psca3_d[p_c].l_sfaadocno = p_str
        WHEN p_name = "demand_qty"
           LET g_psca3_d[p_c].l_sfaa012   = p_str
        WHEN p_name = "firm_complete_date"
           LET g_psca3_d[p_c].l_sfaa020   = p_str
        WHEN p_name = "firm_release_date"
           LET g_psca3_d[p_c].l_sfaa019   = p_str
        WHEN p_name = "part_id"
           LET g_psca3_d[p_c].l_sfaa010   = p_str
        WHEN p_name = "route_id"
           LET g_psca3_d[p_c].l_sfaadocno1 = p_str
        WHEN p_name = "unit_id"
           LET g_psca3_d[p_c].l_sfaa013   = p_str
        WHEN p_name = "scrap_qty"
           LET g_psca3_d[p_c].l_sfaa056   = p_str
        WHEN p_name = "is_new"
           LET g_psca3_d[p_c].l_new_1     = p_str
        WHEN p_name = "produced_qty"
           LET g_psca3_d[p_c].l_produced  = p_str
        WHEN p_name = "source_do_id"
           LET g_psca3_d[p_c].l_sfaa022   = p_str
        WHEN p_name = "source_mo_id"
           LET g_psca3_d[p_c].l_sfaa021   = p_str
        WHEN p_name = "feature_code"
           LET g_psca3_d[p_c].l_feature   = p_str
        WHEN p_name = "is_firm"
           LET g_psca3_d[p_c].l_firm      = p_str
        WHEN p_name = "exploration_type"
           LET g_psca3_d[p_c].l_exploration = p_str
        WHEN p_name = "material_released"
           LET g_psca3_d[p_c].l_material  = p_str
        WHEN p_name = "hardpegging_type"
           LET g_psca3_d[p_c].l_hardpegging_1 = p_str

   END CASE
END FUNCTION

################################################################################
# Descriptions...: 工單領料狀況
# Memo...........:
# Usage..........: CALL apsq102_Material_Release(p_str,p_c,p_name)
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 15/12/30 By Charles4m
# Modify.........:
################################################################################
PRIVATE FUNCTION apsq102_Material_Release(p_str,p_c,p_name)
DEFINE p_str   STRING
DEFINE p_c     LIKE type_t.num10
DEFINE p_name  STRING

   CASE WHEN p_name = "mfg_order_id"
           LET g_psca4_d[p_c].l_sfbadocno = p_str
        WHEN p_name = "input_part_id"
           LET g_psca4_d[p_c].l_sfba006   = p_str
        WHEN p_name = "sequence_txt"
           LET g_psca4_d[p_c].l_sfbaseq   = p_str
        WHEN p_name = "sequ_num"
           LET g_psca4_d[p_c].l_sfbaseq_1 = p_str
        WHEN p_name = "input_part_release_qty"
           LET g_psca4_d[p_c].l_release   = p_str
        WHEN p_name = "warehouse_id"
           LET g_psca4_d[p_c].l_sfba019   = p_str
        WHEN p_name = "input_part_demand_qty"
           LET g_psca4_d[p_c].l_demand    = p_str
        WHEN p_name = "stock_location"
           LET g_psca4_d[p_c].l_sfba020   = p_str
        WHEN p_name = "is_consigned"
           LET g_psca4_d[p_c].l_sfba028   = p_str
        WHEN p_name = "operation_id"
           LET g_psca4_d[p_c].l_sfba003   = p_str
        WHEN p_name = "is_back_flush"
           LET g_psca4_d[p_c].l_sfba009   = p_str
        WHEN p_name = "issue_material_period"
           LET g_psca4_d[p_c].l_sfba007   = p_str
        WHEN p_name = "is_rework"
           LET g_psca4_d[p_c].l_sfaa003   = p_str
        WHEN p_name = "feature_code"
           LET g_psca4_d[p_c].l_sfba021   = p_str
        WHEN p_name = "source_part_id"
           LET g_psca4_d[p_c].l_sfba001   = p_str
        WHEN p_name = "orig_input_part_id"
           LET g_psca4_d[p_c].l_sfba005   = p_str

   END CASE
END FUNCTION

################################################################################
# Descriptions...: 料件總表
# Memo...........:
# Usage..........: CALL apsq102_Item_Master(p_str,p_c,p_name)
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 15/12/30 By Charles4m
# Modify.........:
################################################################################
PRIVATE FUNCTION apsq102_Item_Master(p_str,p_c,p_name)
DEFINE p_str   STRING
DEFINE p_c     LIKE type_t.num10
DEFINE p_name  STRING

   CASE WHEN p_name = "part_id"
           LET g_psca5_d[p_c].l_imaa001  = p_str
        WHEN p_name = "safety_stock_qty"
           LET g_psca5_d[p_c].l_imaf026  = p_str
        WHEN p_name = "lot_sizing_rule"
           LET g_psca5_d[p_c].l_sizing   = p_str
        WHEN p_name = "is_used_up_part"
           LET g_psca5_d[p_c].l_used     = p_str
        WHEN p_name = "is_integer"
           LET g_psca5_d[p_c].l_integer   = p_str
        WHEN p_name = "part_type"
           LET g_psca5_d[p_c].l_imaf013   = p_str
        WHEN p_name = "unit_id"
           LET g_psca5_d[p_c].l_imaa006   = p_str
        WHEN p_name = "max_lot_size"
           LET g_psca5_d[p_c].l_imae022   = p_str
        WHEN p_name = "min_lot_size"
           LET g_psca5_d[p_c].l_imae018   = p_str
        WHEN p_name = "inc_lot_size"
           LET g_psca5_d[p_c].l_imae017   = p_str
        WHEN p_name = "is_critical_part"
           LET g_psca5_d[p_c].l_imae080   = p_str
        WHEN p_name = "is_phantom_part"
           LET g_psca5_d[p_c].l_imaa004   = p_str
        WHEN p_name = "is_consolidated"
           LET g_psca5_d[p_c].l_imae064   = p_str
        WHEN p_name = "mfg_order_late_tolerance"
           LET g_psca5_d[p_c].l_mfg       = p_str
        WHEN p_name = "pur_order_late_tolerance"
           LET g_psca5_d[p_c].l_order     = p_str
        WHEN p_name = "is_feature_part"
           LET g_psca5_d[p_c].l_feature_1   = p_str
        WHEN p_name = "fixed_lead_time"
           LET g_psca5_d[p_c].l_imaf171 = p_str
        WHEN p_name = "sfixed_lead_time"
           LET g_psca5_d[p_c].l_imaf171_1   = p_str
        WHEN p_name = "consume_type"
           LET g_psca5_d[p_c].l_consume_1     = p_str
        WHEN p_name = "release_remain_forecast"
           LET g_psca5_d[p_c].l_release_1   = p_str
        WHEN p_name = "is_lastqty_combine"
           LET g_psca5_d[p_c].l_lastqty   = p_str
        WHEN p_name = "lastqty_combine_limit"
           LET g_psca5_d[p_c].l_combine   = p_str
        WHEN p_name = "inspect_day"
           LET g_psca5_d[p_c].l_inspect  = p_str
        WHEN p_name = "is_consigned"
           LET g_psca5_d[p_c].l_consign   = p_str
        WHEN p_name = "purchase_unit"
           LET g_psca5_d[p_c].l_imaf143   = p_str
        WHEN p_name = "purchase_transfer_rate"
           LET g_psca5_d[p_c].l_purchase  = p_str
        WHEN p_name = "mfg_unit"
           LET g_psca5_d[p_c].l_imae016   = p_str
        WHEN p_name = "mfg_transfer_rate"
           LET g_psca5_d[p_c].l_mfg_1   = p_str
        WHEN p_name = "sales_unit"
           LET g_psca5_d[p_c].l_imaa105       = p_str
        WHEN p_name = "sales_transfer_rate"
           LET g_psca5_d[p_c].l_sales     = p_str
        WHEN p_name = "consolidate_day"
           LET g_psca5_d[p_c].l_imae064_1   = p_str
        WHEN p_name = "alt_ratio"
           LET g_psca5_d[p_c].l_alt       = p_str
        WHEN p_name = "is_break_point"
           LET g_psca5_d[p_c].l_break   = p_str
        WHEN p_name = "po_create_type"
           LET g_psca5_d[p_c].l_create   = p_str
        WHEN p_name = "supplier_ratio_threshold"
           LET g_psca5_d[p_c].l_supratio   = p_str
        WHEN p_name = "supplier_id"
           LET g_psca5_d[p_c].l_imaf153   = p_str
        WHEN p_name = "is_backward_first"
           LET g_psca5_d[p_c].l_backward   = p_str
        WHEN p_name = "is_batch"
           LET g_psca5_d[p_c].l_batch   = p_str
        WHEN p_name = "setup_time"
           LET g_psca5_d[p_c].l_setup   = p_str
        WHEN p_name = "process_time"
           LET g_psca5_d[p_c].l_imae052   = p_str
        WHEN p_name = "transfer_batch_size"
           LET g_psca5_d[p_c].l_imae077   = p_str
        WHEN p_name = "base_qty"
           LET g_psca5_d[p_c].l_base   = p_str
        WHEN p_name = "max_batch_size"
           LET g_psca5_d[p_c].l_max_batch_size   = p_str
        WHEN p_name = "route_id"
           LET g_psca5_d[p_c].l_imae032   = p_str
        WHEN p_name = "is_outsourcing"
           LET g_psca5_d[p_c].l_outsourcing   = p_str
        WHEN p_name = "var_lead_time"
           LET g_psca5_d[p_c].l_imae072   = p_str
        WHEN p_name = "lead_time_qty"
           LET g_psca5_d[p_c].l_imae073   = p_str
        WHEN p_name = "var_t_cycle_time"
           LET g_psca5_d[p_c].l_var   = p_str
        WHEN p_name = "is_autoissue"
           LET g_psca5_d[p_c].l_auto   = p_str
        WHEN p_name = "consolidate_unit"
           LET g_psca5_d[p_c].l_consolidate   = p_str
        WHEN p_name = "is_phase_out"
           LET g_psca5_d[p_c].l_phase   = p_str
        WHEN p_name = "part_spare_rate"
           LET g_psca5_d[p_c].l_spare   = p_str
        WHEN p_name = "due_date_ahead"
           LET g_psca5_d[p_c].l_due   = p_str
        WHEN p_name = "shrinkage"
           LET g_psca5_d[p_c].l_imae015   = p_str
        WHEN p_name = "feature_group"
           LET g_psca5_d[p_c].l_imaa005   = p_str
        WHEN p_name = "lot_mo_lead_time"
           LET g_psca5_d[p_c].l_imae078   = p_str
        WHEN p_name = "main_mat_reserve_range"
           LET g_psca5_d[p_c].l_imae079   = p_str
        WHEN p_name = "min_use_qty"
           LET g_psca5_d[p_c].l_imae083   = p_str
        WHEN p_name = "use_qty"
           LET g_psca5_d[p_c].l_imae082   = p_str

   END CASE
END FUNCTION

################################################################################
# Descriptions...: 料件特徵
# Memo...........:
# Usage..........: CALL apsq102_Feature_Group(p_str,p_c,p_name)
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 15/12/30 By Charles4m
# Modify.........:
################################################################################
PRIVATE FUNCTION apsq102_Feature_Group(p_str,p_c,p_name)
DEFINE p_str   STRING
DEFINE p_c     LIKE type_t.num10
DEFINE p_name  STRING

   CASE WHEN p_name = "feature_group"
           LET g_psca6_d[p_c].l_imeb001 = p_str
        WHEN p_name = "sequence_txt"
           LET g_psca6_d[p_c].l_imeb002   = p_str
        WHEN p_name = "feature_category"
           LET g_psca6_d[p_c].l_imeb004   = p_str
        WHEN p_name = "feature_type"
           LET g_psca6_d[p_c].l_imeb006 = p_str
        WHEN p_name = "value_type"
           LET g_psca6_d[p_c].l_imeb005   = p_str
        WHEN p_name = "code_start"
           LET g_psca6_d[p_c].l_imeb010   = p_str
        WHEN p_name = "code_end"
           LET g_psca6_d[p_c].l_imeb011    = p_str
        WHEN p_name = "digit_size"
           LET g_psca6_d[p_c].l_imeb008   = p_str
        WHEN p_name = "default_value"
           LET g_psca6_d[p_c].l_imeb009   = p_str

   END CASE
END FUNCTION

################################################################################
# Descriptions...: BOM表
# Memo...........:
# Usage..........: CALL apsq102_Bill_of_Material(p_str,p_c,p_name)
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 15/12/30 By Charles4m
# Modify.........:
################################################################################
PRIVATE FUNCTION apsq102_Bill_of_Material(p_str,p_c,p_name)
DEFINE p_str   STRING
DEFINE p_c     LIKE type_t.num10
DEFINE p_name  STRING
   CASE WHEN p_name = "output_part_id"
           LET g_psca7_d[p_c].l_bmba001 = p_str
        WHEN p_name = "output_part_qty"
           LET g_psca7_d[p_c].l_bmba012   = p_str
        WHEN p_name = "input_part_id"
           LET g_psca7_d[p_c].l_bmba003   = p_str
        WHEN p_name = "sequence_txt"
           LET g_psca7_d[p_c].l_bmba009   = p_str
        WHEN p_name = "input_part_qty"
           LET g_psca7_d[p_c].l_bmba011   = p_str
        WHEN p_name = "shrinkage"
           LET g_psca7_d[p_c].l_shrinkage   = p_str
        WHEN p_name = "is_autoissue"
           LET g_psca7_d[p_c].l_bmba013   = p_str
        WHEN p_name = "is_consigned"
           LET g_psca7_d[p_c].l_bmba031   = p_str
        WHEN p_name = "is_alt_order"
           LET g_psca7_d[p_c].l_alt_1   = p_str
        WHEN p_name = "create_type"
           LET g_psca7_d[p_c].l_create_1   = p_str
        WHEN p_name = "alt_ratio"
           LET g_psca7_d[p_c].l_ratio   = p_str
        WHEN p_name = "operation_id"
           LET g_psca7_d[p_c].l_bmba007   = p_str
        WHEN p_name = "is_phantom"
           LET g_psca7_d[p_c].l_bmba021   = p_str
        WHEN p_name = "is_used_up_part"
           LET g_psca7_d[p_c].l_used_1   = p_str
        WHEN p_name = "is_substitute_part"
           LET g_psca7_d[p_c].l_substitute   = p_str
        WHEN p_name = "fixed_shrinkage"
           LET g_psca7_d[p_c].l_fixed   = p_str
        WHEN p_name = "issue_material_period"
           LET g_psca7_d[p_c].l_bmba023   = p_str
        WHEN p_name = "position"
           LET g_psca7_d[p_c].l_bmba004   = p_str
        WHEN p_name = "sequ_num"
           LET g_psca7_d[p_c].l_bmba008   = p_str
        WHEN p_name = "quantity_per_formula"
           LET g_psca7_d[p_c].l_quantity   = p_str

   END CASE
END FUNCTION

################################################################################
# Descriptions...: 庫存
# Memo...........:
# Usage..........: CALL apsq102_Unassigned_Inventory(p_str,p_c,p_name)
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 15/12/30 By Charles4m
# Modify.........:
################################################################################
PRIVATE FUNCTION apsq102_Unassigned_Inventory(p_str,p_c,p_name)
DEFINE p_str   STRING
DEFINE p_c     LIKE type_t.num10
DEFINE p_name  STRING

   CASE WHEN p_name = "part_id"
           LET g_psca8_d[p_c].l_inag001  = p_str
        WHEN p_name = "warehouse_id"
           LET g_psca8_d[p_c].l_inag004   = p_str
        WHEN p_name = "stock_location"
           LET g_psca8_d[p_c].l_inag005   = p_str
        WHEN p_name = "unallocate_qty"
           LET g_psca8_d[p_c].l_inag009   = p_str
        WHEN p_name = "feature_code"
           LET g_psca8_d[p_c].l_inag002   = p_str
        WHEN p_name = "hardpegging_type"
           LET g_psca8_d[p_c].l_hard      = p_str

   END CASE
END FUNCTION

################################################################################
# Descriptions...: Warehouse
# Memo...........:
# Usage..........: CALL apsq102_Warehouse(p_str,p_c,p_name)
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 15/12/30 By Charles4m
# Modify.........:
################################################################################
PRIVATE FUNCTION apsq102_Warehouse(p_str,p_c,p_name)
DEFINE p_str   STRING
DEFINE p_c     LIKE type_t.num10
DEFINE p_name  STRING
   CASE WHEN p_name = "warehouse_id"
           LET g_psca9_d[p_c].l_inaa001  = p_str
        WHEN p_name = "priority"
           LET g_psca9_d[p_c].l_inaa006   = p_str

   END CASE
END FUNCTION

################################################################################
# Descriptions...: 儲位
# Memo...........:
# Usage..........: CALL apsq102_Stock_Location(p_str,p_c,p_name)
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 15/12/30 By Charles4m
# Modify.........:
################################################################################
PRIVATE FUNCTION apsq102_Stock_Location(p_str,p_c,p_name)
DEFINE p_str   STRING
DEFINE p_c     LIKE type_t.num10
DEFINE p_name  STRING
   CASE WHEN p_name = "warehouse_id"
           LET g_psca10_d[p_c].l_inab001   = p_str
        WHEN p_name = "stock_location"
           LET g_psca10_d[p_c].l_inab002   = p_str
        WHEN p_name = "priority"
           LET g_psca10_d[p_c].l_inab005   = p_str
        WHEN p_name = "is_consigned"
           LET g_psca10_d[p_c].l_consigned = p_str

   END CASE
END FUNCTION

################################################################################
# Descriptions...: 特徵限定用料
# Memo...........:
# Usage..........: CALL apsq102_BOM_Feature_Type1(p_str,p_c,p_name)
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 15/12/30 By Charles4m
# Modify.........:
################################################################################
PRIVATE FUNCTION apsq102_BOM_Feature_Type1(p_str,p_c,p_name)
DEFINE p_str   STRING
DEFINE p_c     LIKE type_t.num10
DEFINE p_name  STRING
   CASE WHEN p_name = "output_part_id"
           LET g_psca11_d[p_c].l_bmca001  = p_str
        WHEN p_name = "feature_category"
           LET g_psca11_d[p_c].l_bmca009  = p_str
        WHEN p_name = "sequence_txt"
           LET g_psca11_d[p_c].l_bmca005  = p_str
        WHEN p_name = "input_part_id"
           LET g_psca11_d[p_c].l_bmca003  = p_str
        WHEN p_name = "code_start"
           LET g_psca11_d[p_c].l_bmcb011  = p_str
        WHEN p_name = "code_end" 
           LET g_psca11_d[p_c].l_bmcb012  = p_str
         
   END CASE
END FUNCTION

################################################################################
# Descriptions...: 特徵對應
# Memo...........:
# Usage..........: CALL apsq102_BOM_Feature_Type2(p_str,p_c,p_name)
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 15/12/30 By Charles4m
# Modify.........:
################################################################################
PRIVATE FUNCTION apsq102_BOM_Feature_Type2(p_str,p_c,p_name)
DEFINE p_str   STRING
DEFINE p_c     LIKE type_t.num10
DEFINE p_name  STRING
   CASE WHEN p_name = "output_part_id"
           LET g_psca12_d[p_c].l_bmc001   = p_str
        WHEN p_name = "feature_category"
           LET g_psca12_d[p_c].l_bmcc009  = p_str
        WHEN p_name = "output_feature" 
           LET g_psca12_d[p_c].l_bmcd010  = p_str
        WHEN p_name = "sequence_txt"
           LET g_psca12_d[p_c].l_bmcc005  = p_str
        WHEN p_name = "input_part_id"
           LET g_psca12_d[p_c].l_bmcc003  = p_str
        WHEN p_name = "input_feature"
           LET g_psca12_d[p_c].l_bmcd011  = p_str
        WHEN p_name = "mapping_method" 
           LET g_psca12_d[p_c].l_bmcc010  = p_str
         
   END CASE
END FUNCTION

################################################################################
# Descriptions...: 料件特徵群組
# Memo...........:
# Usage..........: CALL apsq102_Feature_Group_Line(p_str,p_c,p_name)
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 15/12/30 By Charles4m
# Modify.........:
################################################################################
PRIVATE FUNCTION apsq102_Feature_Group_Line(p_str,p_c,p_name)
DEFINE p_str   STRING
DEFINE p_c     LIKE type_t.num10
DEFINE p_name  STRING
   CASE WHEN p_name = "feature_group"
           LET g_psca13_d[p_c].l_imec001  = p_str
        WHEN p_name = "feature_category"
           LET g_psca13_d[p_c].l_imec002   = p_str
        WHEN p_name = "code_value"
           LET g_psca13_d[p_c].l_imec003   = p_str

   END CASE
END FUNCTION

################################################################################
# Descriptions...: 元件限定特徵
# Memo...........:
# Usage..........: CALL apsq102_BOM_Feature_Type3(p_str,p_c,p_name)
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 15/12/30 By Charles4m
# Modify.........:
################################################################################
PRIVATE FUNCTION apsq102_BOM_Feature_Type3(p_str,p_c,p_name)
DEFINE p_str   STRING
DEFINE p_c     LIKE type_t.num10
DEFINE p_name  STRING
   CASE WHEN p_name = "output_part_id"
           LET g_psca14_d[p_c].l_bmce001  = p_str
        WHEN p_name = "sequence_txt"
           LET g_psca14_d[p_c].l_bmce005   = p_str
        WHEN p_name = "input_part_id"
           LET g_psca14_d[p_c].l_bmce003   = p_str
        WHEN p_name = "feature_category"
           LET g_psca14_d[p_c].l_bmce009   = p_str
        WHEN p_name = "input_feature"
           LET g_psca14_d[p_c].l_bmce010   = p_str

   END CASE
END FUNCTION

################################################################################
# Descriptions...: 聯產品資料
# Memo...........:
# Usage..........: CALL apsq102_Item_Joint_Product(p_str,p_c,p_name)
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 15/12/30 By Charles4m
# Modify.........:
################################################################################
PRIVATE FUNCTION apsq102_Item_Joint_Product(p_str,p_c,p_name)
DEFINE p_str   STRING
DEFINE p_c     LIKE type_t.num10
DEFINE p_name  STRING
   CASE WHEN p_name = "part_id"
           LET g_psca15_d[p_c].l_bmab001   = p_str
        WHEN p_name = "joint_part_id"
           LET g_psca15_d[p_c].l_bmab003   = p_str
        WHEN p_name = "product_type"
           LET g_psca15_d[p_c].l_type_1    = p_str
        WHEN p_name = "product_ratio"
           LET g_psca15_d[p_c].l_bmab004   = p_str
        WHEN p_name = "input_feature"

   END CASE
END FUNCTION

################################################################################
# Descriptions...: BOM取替代
# Memo...........:
# Usage..........: CALL apsq102_Alt_Part(p_str,p_c,p_name)
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 15/12/30 By Charles4m
# Modify.........:
################################################################################
PRIVATE FUNCTION apsq102_Alt_Part(p_str,p_c,p_name)
DEFINE p_str   STRING
DEFINE p_c     LIKE type_t.num10
DEFINE p_name  STRING
   CASE WHEN p_name = "output_part_id"
           LET g_psca16_d[p_c].l_bmea001   = p_str
        WHEN p_name = "input_part_id"
           LET g_psca16_d[p_c].l_bmea003   = p_str
        WHEN p_name = "sub_part_id"
           LET g_psca16_d[p_c].l_bmea008    = p_str
        WHEN p_name = "sub_altpriority"
           LET g_psca16_d[p_c].l_bmea015    = p_str
        WHEN p_name = "input_qty"
           LET g_psca16_d[p_c].l_bmea011   = p_str
        WHEN p_name = "effective_start_date"
           LET g_psca16_d[p_c].l_bmea009    = p_str
        WHEN p_name = "effective_end_date"
           LET g_psca16_d[p_c].l_bmea010    = p_str
        WHEN p_name = "output_qty"
           LET g_psca16_d[p_c].l_bmea012   = p_str
        WHEN p_name = "sub_type"
           LET g_psca16_d[p_c].l_bmea007    = p_str
        WHEN p_name = "supply_limit_ratio"
           LET g_psca16_d[p_c].l_bmea017    = p_str
        WHEN p_name = "is_substitute_part"
           LET g_psca16_d[p_c].l_bmea016   = p_str
   END CASE
   
END FUNCTION

################################################################################
# Descriptions...: 品號取替代
# Memo...........:
# Usage..........: CALL apsq102_Alt_Part_Global(p_str,p_c,p_name)
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 15/12/30 By Charles4m
# Modify.........:
################################################################################
PRIVATE FUNCTION apsq102_Alt_Part_Global(p_str,p_c,p_name)
DEFINE p_str   STRING
DEFINE p_c     LIKE type_t.num10
DEFINE p_name  STRING
   CASE WHEN p_name = "part_id"
           LET g_psca17_d[p_c].l_bmea001_1   = p_str
        WHEN p_name = "sub_part_id"
           LET g_psca17_d[p_c].l_bmea008_1   = p_str
        WHEN p_name = "sub_altpriority"
           LET g_psca17_d[p_c].l_bmea015_1    = p_str
        WHEN p_name = "input_qty"
           LET g_psca17_d[p_c].l_bmea011_1    = p_str
        WHEN p_name = "effective_start_date"
           LET g_psca17_d[p_c].l_bmea009_1   = p_str
        WHEN p_name = "effective_end_date"
           LET g_psca17_d[p_c].l_bmea010_1    = p_str
        WHEN p_name = "output_qty"
           LET g_psca17_d[p_c].l_bmea012_1    = p_str
        WHEN p_name = "sub_type"
           LET g_psca17_d[p_c].l_bmea007_1   = p_str
        WHEN p_name = "supply_limit_ratio"
           LET g_psca17_d[p_c].l_bmea017_1    = p_str
        WHEN p_name = "is_substitute_part"
           LET g_psca17_d[p_c].l_bmea016_1    = p_str

   END CASE
END FUNCTION

################################################################################
# Descriptions...: 工作站
# Memo...........:
# Usage..........: CALL apsq102_WS(p_str,p_c,p_name)
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 15/12/30 By Charles4m
# Modify.........:
################################################################################
PRIVATE FUNCTION apsq102_WS(p_str,p_c,p_name)
DEFINE p_str   STRING
DEFINE p_c     LIKE type_t.num10
DEFINE p_name  STRING
   CASE WHEN p_name = "WS"
           LET g_psca18_d[p_c].l_ecaa001   = p_str

   END CASE
END FUNCTION

################################################################################
# Descriptions...: 損耗區間
# Memo...........:
# Usage..........: CALL apsq102_Shrinkage_Range(p_str,p_c,p_name)
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 15/12/30 By Charles4m
# Modify.........:
################################################################################
PRIVATE FUNCTION apsq102_Shrinkage_Range(p_str,p_c,p_name)
DEFINE p_str   STRING
DEFINE p_c     LIKE type_t.num10
DEFINE p_name  STRING
   CASE WHEN p_name = "output_part_id"
           LET g_psca19_d[p_c].l_bmbb001   = p_str
        WHEN p_name = "input_part_id"
           LET g_psca19_d[p_c].l_bmbb003   = p_str
        WHEN p_name = "sequence_txt"
           LET g_psca19_d[p_c].l_seq    = p_str
        WHEN p_name = "seq"
           LET g_psca19_d[p_c].l_seq1    = p_str
        WHEN p_name = "l_bound"
           LET g_psca19_d[p_c].l_bmbb009   = p_str
        WHEN p_name = "u_bound"
           LET g_psca19_d[p_c].l_bmbb010    = p_str
        WHEN p_name = "shrinkage"
           LET g_psca19_d[p_c].l_shrinkage_1    = p_str
        WHEN p_name = "var_shrinkage_ratio"
           LET g_psca19_d[p_c].l_bmbb011   = p_str
        WHEN p_name = "fixed_shrinkage_ratio"
           LET g_psca19_d[p_c].l_bmbb012    = p_str

   END CASE
END FUNCTION

################################################################################
# Descriptions...: MPS工單中介檔
# Memo...........:
# Usage..........: CALL apsq102_OMP_Suggest_Mfg_Order(p_str,p_c,p_name)
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 15/12/30 By Charles4m
# Modify.........:
################################################################################
PRIVATE FUNCTION apsq102_OMP_Suggest_Mfg_Order(p_str,p_c,p_name)
DEFINE p_str   STRING
DEFINE p_c     LIKE type_t.num10
DEFINE p_name  STRING
   CASE WHEN p_name = "mfg_order_id"
           LET g_psca20_d[p_c].l_psoa003   = p_str
        WHEN p_name = "demand_qty"
           LET g_psca20_d[p_c].l_psoa004   = p_str
        WHEN p_name = "produced_qty"
           LET g_psca20_d[p_c].l_psoa005    = p_str
        WHEN p_name = "erp_order_id"
           LET g_psca20_d[p_c].l_psoa006    = p_str
        WHEN p_name = "firm_complete_date"
           LET g_psca20_d[p_c].l_psoa007   = p_str
        WHEN p_name = "firm_release_date"
           LET g_psca20_d[p_c].l_psoa008    = p_str
        WHEN p_name = "part_id"
           LET g_psca20_d[p_c].l_psoa009    = p_str
        WHEN p_name = "route_id"
           LET g_psca20_d[p_c].l_psoa010   = p_str
        WHEN p_name = "scrap_qty"
           LET g_psca20_d[p_c].l_psoa011    = p_str
        WHEN p_name = "state"
           LET g_psca20_d[p_c].l_psoa012   = p_str
        WHEN p_name = "po_constraint_date"
           LET g_psca20_d[p_c].l_psoa013    = p_str
        WHEN p_name = "is_new"
           LET g_psca20_d[p_c].l_psoa014    = p_str
        WHEN p_name = "plan_complete_date"
           LET g_psca20_d[p_c].l_psoa015   = p_str
        WHEN p_name = "plan_release_date"
           LET g_psca20_d[p_c].l_psoa016    = p_str
        WHEN p_name = "has_route"
           LET g_psca20_d[p_c].l_psoa017    = p_str
        WHEN p_name = "is_outsourcing"
           LET g_psca20_d[p_c].l_psoa018   = p_str
        WHEN p_name = "outsource_id"
           LET g_psca20_d[p_c].l_psoa019   = p_str
         WHEN p_name = "unit_id"
           LET g_psca20_d[p_c].l_psoa020    = p_str
        WHEN p_name = "is_firm"
           LET g_psca20_d[p_c].l_psoa021    = p_str
        WHEN p_name = "item_code"
           LET g_psca20_d[p_c].l_psoa022   = p_str
        WHEN p_name = "feature_code"
           LET g_psca20_d[p_c].l_psoa023   = p_str

   END CASE
END FUNCTION

################################################################################
# Descriptions...: 描述说明
# Memo...........:
# Usage..........: CALL apsq102_omp_demand_order(p_str,p_c,p_name)
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 16/05/09 By Charles4m
# Modify.........:
################################################################################
PRIVATE FUNCTION apsq102_omp_demand_order(p_str,p_c,p_name)
DEFINE p_str   STRING
DEFINE p_c     LIKE type_t.num10
DEFINE p_name  STRING

   CASE WHEN p_name = "demand_order_id"
           LET g_psca21_d[p_c].l_psod003 = p_str
        WHEN p_name = "part_id"
           LET g_psca21_d[p_c].l_psod004   = p_str
        WHEN p_name = "order_qty"
           LET g_psca21_d[p_c].l_psod005   = p_str
        WHEN p_name = "due_date"
           LET g_psca21_d[p_c].l_psod006   = p_str
        WHEN p_name = "customer_id"
           LET g_psca21_d[p_c].l_psod007   = p_str
        WHEN p_name = "is_scheduled"
           LET g_psca21_d[p_c].l_psod008   = p_str
        WHEN p_name = "order_type"
           LET g_psca21_d[p_c].l_psod009   = p_str
        WHEN p_name = "priority"
           LET g_psca21_d[p_c].l_psod010   = p_str
        WHEN p_name = "sale_order_id"
           LET g_psca21_d[p_c].l_psod011   = p_str   
        WHEN p_name = "customer_order_id"
           LET g_psca21_d[p_c].l_psod012   = p_str   
        WHEN p_name = "shipped_qty"
           LET g_psca21_d[p_c].l_psod013   = p_str
        WHEN p_name = "order_date"
           LET g_psca21_d[p_c].l_psod014   = p_str
        WHEN p_name = "is_non_delayed"
           LET g_psca21_d[p_c].l_psod015   = p_str
        WHEN p_name = "unit_id"
           LET g_psca21_d[p_c].l_psod016   = p_str
        WHEN p_name = "real_due_date"
           LET g_psca21_d[p_c].l_psod017   = p_str
   END CASE
END FUNCTION

################################################################################
# Descriptions...: 描述说明
# Memo...........:
# Usage..........: CALL apsq102_omp_suggest_purchase_order(p_str,p_c,p_name)
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 16/05/09 By Charles4m
# Modify.........:
################################################################################
PRIVATE FUNCTION apsq102_omp_suggest_purchase_order(p_str,p_c,p_name)
DEFINE p_str   STRING
DEFINE p_c     LIKE type_t.num10
DEFINE p_name  STRING

   CASE WHEN p_name = "purchase_order_id"
           LET g_psca22_d[p_c].l_psoc003   = p_str
        WHEN p_name = "part_id"
           LET g_psca22_d[p_c].l_psoc004   = p_str
        WHEN p_name = "purchase_qty"
           LET g_psca22_d[p_c].l_psoc005   = p_str
        WHEN p_name = "is_new"
           LET g_psca22_d[p_c].l_psoc006   = p_str
        WHEN p_name = "firm_release_date"
           LET g_psca22_d[p_c].l_psoc007   = p_str
        WHEN p_name = "firm_available_date"
           LET g_psca22_d[p_c].l_psoc008_1   = p_str
        WHEN p_name = "plan_release_date"
           LET g_psca22_d[p_c].l_psoc009   = p_str
        WHEN p_name = "plan_available_date"
           LET g_psca22_d[p_c].l_psoc010   = p_str
        WHEN p_name = "supplier_id"
           LET g_psca22_d[p_c].l_psoc011   = p_str
        WHEN p_name = "erp_order_id"
           LET g_psca22_d[p_c].l_psoc012   = p_str
        WHEN p_name = "stocked_qty"
           LET g_psca22_d[p_c].l_psoc013   = p_str
        WHEN p_name = "state"
           LET g_psca22_d[p_c].l_psoc014   = p_str
        WHEN p_name = "is_firm"
           LET g_psca22_d[p_c].l_psoc015   = p_str
        WHEN p_name = "uninspect_qty"
           LET g_psca22_d[p_c].l_psoc016   = p_str
        WHEN p_name = "unstocked_qty"
           LET g_psca22_d[p_c].l_psoc017   = p_str
        WHEN p_name = "return_qty"
           LET g_psca22_d[p_c].l_psoc018   = p_str
        WHEN p_name = "location"
           LET g_psca22_d[p_c].l_psoc019   = p_str
        WHEN p_name = "unit_id"
           LET g_psca22_d[p_c].l_psoc020   = p_str
        WHEN p_name = "lead_time"
           LET g_psca22_d[p_c].l_psoc021   = p_str
        WHEN p_name = "firm_supply_date"
           LET g_psca22_d[p_c].l_psoc022   = p_str
        WHEN p_name = "plan_supply_date"
           LET g_psca22_d[p_c].l_psoc023   = p_str
        WHEN p_name = "part_feature"
           LET g_psca22_d[p_c].l_psoc025   = p_str
        WHEN p_name = "firm_release"
           LET g_psca22_d[p_c].l_psoc022_1 = p_str
        WHEN p_name = "firm_available"
           LET g_psca22_d[p_c].l_psoc022_2 = p_str
        WHEN p_name = "part_feature"
           LET g_psca22_d[p_c].l_psoc022_3 = p_str

   END CASE
END FUNCTION

################################################################################
# Descriptions...: 描述说明
# Memo...........:
# Usage..........: CALL apsq102_omp_suggest_mfg_order1(p_str,p_c,p_name)
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 16/05/10 By Charles4m
# Modify.........:
################################################################################
PRIVATE FUNCTION apsq102_omp_suggest_mfg_order1(p_str,p_c,p_name)
DEFINE p_str   STRING
DEFINE p_c     LIKE type_t.num10
DEFINE p_name  STRING

   CASE WHEN p_name = "mfg_order_id"
           LET g_psca23_d[p_c].l_psoa003_1 = p_str
        WHEN p_name = "demand_qty"
           LET g_psca23_d[p_c].l_psoa004_1   = p_str
        WHEN p_name = "produced_qty"
           LET g_psca23_d[p_c].l_psoa005_1  = p_str
        WHEN p_name = "erp_order_id"
           LET g_psca23_d[p_c].l_psoa006_1  = p_str
        WHEN p_name = "firm_complete_date"
           LET g_psca23_d[p_c].l_psoa007_1   = p_str
        WHEN p_name = "firm_release_date"
           LET g_psca23_d[p_c].l_psoa008_1   = p_str
        WHEN p_name = "part_id"
           LET g_psca23_d[p_c].l_psoa009_1   = p_str
        WHEN p_name = "route_id"
           LET g_psca23_d[p_c].l_psoa010_1   = p_str
        WHEN p_name = "scrap_qty"
           LET g_psca23_d[p_c].l_psoa011_1   = p_str
        WHEN p_name = "state"
           LET g_psca23_d[p_c].l_psoa012_1   = p_str
        WHEN p_name = "po_constraint_date"
           LET g_psca23_d[p_c].l_psoa013_1   = p_str
        WHEN p_name = "is_new"
           LET g_psca23_d[p_c].l_psoa014_1   = p_str
        WHEN p_name = "plan_complete_date"
           LET g_psca23_d[p_c].l_psoa015_1   = p_str
        WHEN p_name = "plan_release_date"
           LET g_psca23_d[p_c].l_psoa016_1   = p_str
        WHEN p_name = "has_route"
           LET g_psca23_d[p_c].l_psoa017_1   = p_str
        WHEN p_name = "is_outsourcing"
           LET g_psca23_d[p_c].l_psoa018_1   = p_str
        WHEN p_name = "outsource_id"
           LET g_psca23_d[p_c].l_psoa019_1   = p_str
        WHEN p_name = "unit_id"
           LET g_psca23_d[p_c].l_psoa020_1   = p_str
        WHEN p_name = "is_firm"
           LET g_psca23_d[p_c].l_psoa021_1   = p_str
        WHEN p_name = "part_feature"
           LET g_psca23_d[p_c].l_psoa023_1   = p_str

   END CASE
END FUNCTION

################################################################################
# Descriptions...: 描述说明
# Memo...........:
# Usage..........: CALL apsq102_material_release1(p_str,p_c,p_name)
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 16/05/10 By Charles4m
# Modify.........:
################################################################################
PRIVATE FUNCTION apsq102_material_release1(p_str,p_c,p_name)
DEFINE p_str   STRING
DEFINE p_c     LIKE type_t.num10
DEFINE p_name  STRING

   CASE WHEN p_name = "mfg_order_id"
           LET g_psca24_d[p_c].l_sfbadocno_1 = p_str
        WHEN p_name = "input_part_id"
           LET g_psca24_d[p_c].l_sfba006_1   = p_str
        WHEN p_name = "sequence_txt"
           LET g_psca24_d[p_c].l_sfbaseq_2   = p_str
        WHEN p_name = "sequ_num"
           LET g_psca24_d[p_c].l_sfbaseq_1_1 = p_str
        WHEN p_name = "input_part_release_qty"
           LET g_psca24_d[p_c].l_release_2   = p_str
        WHEN p_name = "warehouse_id"
           LET g_psca24_d[p_c].l_sfba019_1   = p_str
        WHEN p_name = "input_part_demand_qty"
           LET g_psca24_d[p_c].l_demand_1    = p_str
        WHEN p_name = "stock_location"
           LET g_psca24_d[p_c].l_sfba020_1   = p_str
        WHEN p_name = "is_consigned"
           LET g_psca24_d[p_c].l_sfba028_1   = p_str
        WHEN p_name = "operation_id"
           LET g_psca24_d[p_c].l_sfba003_1   = p_str
        WHEN p_name = "is_back_flush"
           LET g_psca24_d[p_c].l_sfba009_1   = p_str
        WHEN p_name = "issue_material_period"
           LET g_psca24_d[p_c].l_sfba007_1   = p_str
        WHEN p_name = "is_rework"
           LET g_psca24_d[p_c].l_sfaa003_1   = p_str
        WHEN p_name = "feature_code"
           LET g_psca24_d[p_c].l_sfba021_1   = p_str

   END CASE
END FUNCTION

################################################################################
# Descriptions...: 描述说明
# Memo...........:
# Usage..........: CALL apsq102_omp_mopeg(p_str,p_c,p_name)
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 16/05/10 By Charles4m
# Modify.........:
################################################################################
PRIVATE FUNCTION apsq102_omp_mopeg(p_str,p_c,p_name)
DEFINE p_str   STRING
DEFINE p_c     LIKE type_t.num10
DEFINE p_name  STRING

   CASE WHEN p_name = "fed_order_id"
           LET g_psca25_d[p_c].l_psob003 = p_str
        WHEN p_name = "demand_qty"
           LET g_psca25_d[p_c].l_psob004   = p_str
        WHEN p_name = "feded_order_id"
           LET g_psca25_d[p_c].l_psob005   = p_str
        WHEN p_name = "is_demand"
           LET g_psca25_d[p_c].l_psob006   = p_str
        WHEN p_name = "fed_qty"
           LET g_psca25_d[p_c].l_psob007   = p_str
        WHEN p_name = "is_stock"
           LET g_psca25_d[p_c].l_psob008   = p_str
        WHEN p_name = "supply_qty"
           LET g_psca25_d[p_c].l_psob009   = p_str
        WHEN p_name = "is_lock"
           LET g_psca25_d[p_c].l_psob010   = p_str
        WHEN p_name = "part_id"
           LET g_psca25_d[p_c].l_psob011   = p_str   
        WHEN p_name = "require_time"
           LET g_psca25_d[p_c].l_psob012   = p_str   
        WHEN p_name = "peg_seq"
           LET g_psca25_d[p_c].l_psob013   = p_str
        WHEN p_name = "part_feature"
           LET g_psca25_d[p_c].l_psob016   = p_str

   END CASE
END FUNCTION

################################################################################
# Descriptions...: 描述说明
# Memo...........:
# Usage..........: CALL apsq102_omp_equipment(p_str,p_c,p_name)
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 16/05/10 By Charles4m
# Modify.........:
################################################################################
PRIVATE FUNCTION apsq102_omp_equipment(p_str,p_c,p_name)
DEFINE p_str   STRING
DEFINE p_c     LIKE type_t.num10
DEFINE p_name  STRING

   CASE WHEN p_name = "equip_type"
           LET g_psca26_d[p_c].l_equip_type        = p_str
        WHEN p_name = "equip_id"
           LET g_psca26_d[p_c].l_equip_id          = p_str
        WHEN p_name = "ws_id"
           LET g_psca26_d[p_c].l_ws_id             = p_str
        WHEN p_name = "efficency"
           LET g_psca26_d[p_c].l_efficency         = p_str
        WHEN p_name = "capacity_type"
           LET g_psca26_d[p_c].l_capacity_type     = p_str
        WHEN p_name = "day_calendar_id" 
           LET g_psca26_d[p_c].l_day_calendar_id   = p_str
        WHEN p_name = "week_calendar_id"
           LET g_psca26_d[p_c].l_week_calendar_id  = p_str


   END CASE
END FUNCTION

################################################################################
# Descriptions...: 描述说明
# Memo...........:
# Usage..........: CALL apsq102_equipment_group(p_str,p_c,p_name)
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 16/05/10 By Charles4m
# Modify.........:
################################################################################
PRIVATE FUNCTION apsq102_equipment_group(p_str,p_c,p_name)
DEFINE p_str   STRING
DEFINE p_c     LIKE type_t.num10
DEFINE p_name  STRING

   CASE WHEN p_name = "equip_group_id"
           LET g_psca27_d[p_c].l_equip_group_id     = p_str
        WHEN p_name = "equip_type"
           LET g_psca27_d[p_c].l_equip_type_1       = p_str
        WHEN p_name = "is_outsourcing"
           LET g_psca27_d[p_c].l_is_outsourcing       = p_str
        WHEN p_name = "equip_id"
           LET g_psca27_d[p_c].l_equip_id_1         = p_str
        WHEN p_name = "priority"
           LET g_psca27_d[p_c].l_priority_1         = p_str

   END CASE
END FUNCTION

################################################################################
# Descriptions...: 描述说明
# Memo...........:
# Usage..........: CALL apsq102_omp_daycaln(p_str,p_c,p_name)
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 16/05/10 By Charles4m
# Modify.........:
################################################################################
PRIVATE FUNCTION apsq102_omp_daycaln(p_str,p_c,p_name)
DEFINE p_str   STRING
DEFINE p_c     LIKE type_t.num10
DEFINE p_name  STRING

   CASE WHEN p_name = "day_calendar_id"
           LET g_psca28_d[p_c].l_mrbh001_1     = p_str
        WHEN p_name = "calendar_date"
           LET g_psca28_d[p_c].l_mrbh002       = p_str
        WHEN p_name = "start_time"
           LET g_psca28_d[p_c].l_mrbh003  = p_str
        WHEN p_name = "end_time"                
           LET g_psca28_d[p_c].l_mrbh004    = p_str
        WHEN p_name = "work_type"               
           LET g_psca28_d[p_c].l_mrbh005    = p_str

   END CASE
END FUNCTION

################################################################################
# Descriptions...: 描述说明
# Memo...........:
# Usage..........: CALL apsq102_omp_weekcaln(p_str,p_c,p_name)
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 16/05/11 By Charles4m
# Modify.........:
################################################################################
PRIVATE FUNCTION apsq102_omp_weekcaln(p_str,p_c,p_name)
DEFINE p_str   STRING
DEFINE p_c     LIKE type_t.num10
DEFINE p_name  STRING

   CASE WHEN p_name = "week_calendar_id"
           LET g_psca29_d[p_c].l_week_calendar_id_1     = p_str
        WHEN p_name = "mon_wm_id"
           LET g_psca29_d[p_c].l_mom_wm_id              = p_str
        WHEN p_name = "tue_wm_id"                      
           LET g_psca29_d[p_c].l_tue_wm_id              = p_str
        WHEN p_name = "wed_wm_id"                          
           LET g_psca29_d[p_c].l_wed_wm_id              = p_str
        WHEN p_name = "thu_wm_id"                         
           LET g_psca29_d[p_c].l_thu_wm_id              = p_str
        WHEN p_name = "fri_wm_id"                      
           LET g_psca29_d[p_c].l_fri_wm_id              = p_str
        WHEN p_name = "sat_wm_id"                          
           LET g_psca29_d[p_c].l_sat_wm_id              = p_str
        WHEN p_name = "sun_wm_id"                         
           LET g_psca29_d[p_c].l_sun_wm_id              = p_str

   END CASE
END FUNCTION

################################################################################
# Descriptions...: 描述说明
# Memo...........:
# Usage..........: CALL apsq102_omp_work_model(p_str,p_c,p_name)
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 16/05/11 By Charles4m
# Modify.........:
################################################################################
PRIVATE FUNCTION apsq102_omp_work_model(p_str,p_c,p_name)
DEFINE p_str   STRING
DEFINE p_c     LIKE type_t.num10
DEFINE p_name  STRING

   CASE WHEN p_name = "wm_id"
           LET g_psca30_d[p_c].l_wm_id        = p_str
        WHEN p_name = "start_time"
           LET g_psca30_d[p_c].l_start_time   = p_str
        WHEN p_name = "end_time"                      
           LET g_psca30_d[p_c].l_end_time     = p_str
        WHEN p_name = "type"                          
           LET g_psca30_d[p_c].l_type_2       = p_str

   END CASE
END FUNCTION

################################################################################
# Descriptions...: 描述说明
# Memo...........:
# Usage..........: CALL apsq102_item_masters1(p_str,p_c,p_name)
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 16/05/11 By Charles4m
# Modify.........:
################################################################################
PRIVATE FUNCTION apsq102_item_masters1(p_str,p_c,p_name)
DEFINE p_str   STRING
DEFINE p_c     LIKE type_t.num10
DEFINE p_name  STRING

   CASE WHEN p_name = "part_id"
           LET g_psca31_d[p_c].l_imaa001_1        = p_str
        WHEN p_name = "safety_stock_qty"
           LET g_psca31_d[p_c].l_imaf026_1   = p_str
        WHEN p_name = "lot_sizing_rule"                      
           LET g_psca31_d[p_c].l_sizing_1     = p_str
        WHEN p_name = "is_used_up_part"                          
           LET g_psca31_d[p_c].l_used_2       = p_str
        WHEN p_name = "is_integer"
           LET g_psca31_d[p_c].l_integer_1   = p_str
        WHEN p_name = "part_type"                      
           LET g_psca31_d[p_c].l_imaf013_1     = p_str
        WHEN p_name = "unit_id"                          
           LET g_psca31_d[p_c].l_imaa006_1       = p_str
        WHEN p_name = "max_lot_size"
           LET g_psca31_d[p_c].l_imae022_1   = p_str
        WHEN p_name = "min_lot_size"                      
           LET g_psca31_d[p_c].l_imae018_1     = p_str
        WHEN p_name = "inc_lot_size"                          
           LET g_psca31_d[p_c].l_imae017_1       = p_str
        WHEN p_name = "is_critical_part"
           LET g_psca31_d[p_c].l_imae080_1   = p_str
        WHEN p_name = "is_phantom_part"                      
           LET g_psca31_d[p_c].l_imaa004_1     = p_str
        WHEN p_name = "is_consolidated"                          
           LET g_psca31_d[p_c].l_imae064_2       = p_str
        WHEN p_name = "mfg_order_late_tolerance"
           LET g_psca31_d[p_c].l_mfg_2   = p_str
        WHEN p_name = "pur_order_late_tolerance"                      
           LET g_psca31_d[p_c].l_order_1     = p_str
        WHEN p_name = "is_feature_part"                          
           LET g_psca31_d[p_c].l_feature_1_1       = p_str
        WHEN p_name = "fixed_lead_time"
           LET g_psca31_d[p_c].l_imaf171_2   = p_str
        WHEN p_name = "sfixed_lead_time"                      
           LET g_psca31_d[p_c].l_imaf171_3     = p_str
        WHEN p_name = "consume_type"                          
           LET g_psca31_d[p_c].l_consume_1_1       = p_str
        WHEN p_name = "release_remain_forecast"
           LET g_psca31_d[p_c].l_release_1_1   = p_str
        WHEN p_name = "is_lastqty_combine"                      
           LET g_psca31_d[p_c].l_lastqty_1     = p_str
        WHEN p_name = "lastqty_combine_limit"                          
           LET g_psca31_d[p_c].l_combine_1       = p_str
        WHEN p_name = "inspect_day"                      
           LET g_psca31_d[p_c].l_inspect_1     = p_str
        WHEN p_name = "is_consigned"                          
           LET g_psca31_d[p_c].l_consign_1       = p_str
        WHEN p_name = "purchase_unit"
           LET g_psca31_d[p_c].l_imaf143_1   = p_str
        WHEN p_name = "purchase_transfer_rate"                      
           LET g_psca31_d[p_c].l_purchase_1     = p_str
        WHEN p_name = "mfg_unit"                          
           LET g_psca31_d[p_c].l_imae016_1       = p_str
        WHEN p_name = "mfg_transfer_rate"
           LET g_psca31_d[p_c].l_mfg_1_1   = p_str
        WHEN p_name = "sales_unit"                      
           LET g_psca31_d[p_c].l_imaa105_1     = p_str
        WHEN p_name = "sales_transfer_rate"                          
           LET g_psca31_d[p_c].l_sales_1       = p_str
        WHEN p_name = "consolidate_day"
           LET g_psca31_d[p_c].l_imae064_1_1   = p_str
        WHEN p_name = "alt_ratio"                      
           LET g_psca31_d[p_c].l_alt_2     = p_str
        WHEN p_name = "is_break_point"                          
           LET g_psca31_d[p_c].l_break_1       = p_str
        WHEN p_name = "po_create_type"
           LET g_psca31_d[p_c].l_create_2   = p_str
        WHEN p_name = "supplier_ratio_threshold"                      
           LET g_psca31_d[p_c].l_supratio_1     = p_str
        WHEN p_name = "supplier_id"                          
           LET g_psca31_d[p_c].l_imaf153_1       = p_str
        WHEN p_name = "is_backward_first"
           LET g_psca31_d[p_c].l_backward_1   = p_str
        WHEN p_name = "is_batch"                      
           LET g_psca31_d[p_c].l_batch_1     = p_str
        WHEN p_name = "setup_time"                          
           LET g_psca31_d[p_c].l_setup_1       = p_str
        WHEN p_name = "process_time"
           LET g_psca31_d[p_c].l_imae052_1   = p_str
        WHEN p_name = "transfer_batch_size"                      
           LET g_psca31_d[p_c].l_imae077_1     = p_str
        WHEN p_name = "base_qty"                          
           LET g_psca31_d[p_c].l_base_1       = p_str
        WHEN p_name = "max_batch_size"
           LET g_psca31_d[p_c].l_max_batch_size_1   = p_str
        WHEN p_name = "route_id"                      
           LET g_psca31_d[p_c].l_imae032_1     = p_str
        WHEN p_name = "is_outsourcing"                          
           LET g_psca31_d[p_c].l_outsourcing_1       = p_str
        WHEN p_name = "var_lead_time"
           LET g_psca31_d[p_c].l_imae072_1   = p_str
        WHEN p_name = "lead_time_qty"                      
           LET g_psca31_d[p_c].l_imae073_1     = p_str
        WHEN p_name = "var_t_cycle_time"                          
           LET g_psca31_d[p_c].l_var_1       = p_str
        WHEN p_name = "is_autoissue"                      
           LET g_psca31_d[p_c].l_auto_1     = p_str
        WHEN p_name = "consolidate_unit"                          
           LET g_psca31_d[p_c].l_consolidate_1       = p_str
        WHEN p_name = "is_phase_out"
           LET g_psca31_d[p_c].l_phase_1   = p_str
        WHEN p_name = "part_spare_rate"                      
           LET g_psca31_d[p_c].l_spare_1     = p_str
        WHEN p_name = "due_date_ahead"                          
           LET g_psca31_d[p_c].l_due_1       = p_str
        WHEN p_name = "shrinkage"
           LET g_psca31_d[p_c].l_imae015_1   = p_str
        WHEN p_name = "feature_group"                      
           LET g_psca31_d[p_c].l_imaa005_1     = p_str
        WHEN p_name = "lot_mo_lead_time"                          
           LET g_psca31_d[p_c].l_imae078_1       = p_str
        WHEN p_name = "main_mat_reserve_range"
           LET g_psca31_d[p_c].l_imae079_1   = p_str
        WHEN p_name = "min_use_qty"                      
           LET g_psca31_d[p_c].l_imae083_1     = p_str
        WHEN p_name = "use_qty"                          
           LET g_psca31_d[p_c].l_imae082_1       = p_str

   END CASE
END FUNCTION

################################################################################
# Descriptions...: 描述说明
# Memo...........:
# Usage..........: CALL apsq102_bom_throw_point(p_str,p_c,p_name)
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 16/05/11 By Charles4m
# Modify.........:
################################################################################
PRIVATE FUNCTION apsq102_bom_throw_point(p_str,p_c,p_name)
DEFINE p_str   STRING
DEFINE p_c     LIKE type_t.num10
DEFINE p_name  STRING

   CASE WHEN p_name = "output_part_id"
           LET g_psca32_d[p_c].l_bmba001_1        = p_str
        WHEN p_name = "input_part_id"
           LET g_psca32_d[p_c].l_bmba003_1        = p_str
        WHEN p_name = "route_id"                      
           LET g_psca32_d[p_c].l_ecba001          = p_str
        WHEN p_name = "sequ_num"                          
           LET g_psca32_d[p_c].l_ecbb003          = p_str
        WHEN p_name = "operation_id"                          
           LET g_psca32_d[p_c].l_bmba007_1        = p_str

   END CASE
END FUNCTION

################################################################################
# Descriptions...: 描述说明
# Memo...........:
# Usage..........: CALL apsq102_item_route(p_str,p_c,p_name)
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 16/05/11 By Charles4m
# Modify.........:
################################################################################
PRIVATE FUNCTION apsq102_item_route(p_str,p_c,p_name)
DEFINE p_str   STRING
DEFINE p_c     LIKE type_t.num10
DEFINE p_name  STRING

   CASE WHEN p_name = "part_id"
           LET g_psca33_d[p_c].l_part_id        = p_str
        WHEN p_name = "route_id"
           LET g_psca33_d[p_c].l_imae033        = p_str
        WHEN p_name = "sequ_num"                      
           LET g_psca33_d[p_c].l_sequ_num          = p_str
        WHEN p_name = "is_alt"                          
           LET g_psca33_d[p_c].l_is_alt          = p_str

   END CASE
END FUNCTION

################################################################################
# Descriptions...: 描述说明
# Memo...........:
# Usage..........: CALL apsq102_route(p_str,p_c,p_name)
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 16/05/11 By Charles4m
# Modify.........:
################################################################################
PRIVATE FUNCTION apsq102_route(p_str,p_c,p_name)
DEFINE p_str   STRING
DEFINE p_c     LIKE type_t.num10
DEFINE p_name  STRING

   CASE WHEN p_name = "part_id"
           LET g_psca34_d[p_c].l_ecbb001        = p_str
        WHEN p_name = "route_id"
           LET g_psca34_d[p_c].l_ecbb002        = p_str
        WHEN p_name = "sequ_num"                      
           LET g_psca34_d[p_c].l_ecbb003_1          = p_str
        WHEN p_name = "operation_id"                          
           LET g_psca34_d[p_c].l_ecbb004          = p_str
        WHEN p_name = "equip_type"
           LET g_psca34_d[p_c].l_equip_type_2        = p_str
        WHEN p_name = "equip_group_id"
           LET g_psca34_d[p_c].l_ecbb037        = p_str
        WHEN p_name = "is_batch"                      
           LET g_psca34_d[p_c].l_is_batch          = p_str
        WHEN p_name = "setup_time"                          
           LET g_psca34_d[p_c].l_ecbb026          = p_str
        WHEN p_name = "process_time"
           LET g_psca34_d[p_c].l_ecbb027        = p_str
        WHEN p_name = "transfer_batch_size"
           LET g_psca34_d[p_c].l_imae077_2        = p_str
        WHEN p_name = "base_qty"                      
           LET g_psca34_d[p_c].l_imae077_3          = p_str
        WHEN p_name = "ws_id"                          
           LET g_psca34_d[p_c].l_ecbb012          = p_str   
         
   END CASE
END FUNCTION

################################################################################
# Descriptions...: 描述说明
# Memo...........:
# Usage..........: CALL apsq102_ws1(p_str,p_c,p_name)
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 16/05/11 By Charles4m
# Modify.........:
################################################################################
PRIVATE FUNCTION apsq102_ws1(p_str,p_c,p_name)
DEFINE p_str   STRING
DEFINE p_c     LIKE type_t.num10
DEFINE p_name  STRING

   CASE WHEN p_name = "ws_id"
           LET g_psca35_d[p_c].l_ecaa001_1        = p_str

   END CASE
END FUNCTION

################################################################################
# Descriptions...: 描述说明
# Memo...........:
# Usage..........: CALL apsq102_route_relation(p_str,p_c,p_name)
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 16/05/11 By Charles4m
# Modify.........:
################################################################################
PRIVATE FUNCTION apsq102_route_relation(p_str,p_c,p_name)
DEFINE p_str   STRING
DEFINE p_c     LIKE type_t.num10
DEFINE p_name  STRING

   CASE WHEN p_name = "route_id"
           LET g_psca36_d[p_c].l_ecbe001        = p_str
        WHEN p_name = "source_sequ_num"
           LET g_psca36_d[p_c].l_ecbe005        = p_str
        WHEN p_name = "target_sequ_num"                      
           LET g_psca36_d[p_c].l_ecbe003        = p_str

   END CASE
END FUNCTION

################################################################################
# Descriptions...: 描述说明
# Memo...........:
# Usage..........: CALL apsq102_query()
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 16/07/01 By Charles4m
# Modify.........:
################################################################################
PRIVATE FUNCTION apsq102_query()
   #add-point:query段define-客製

   #end add-point 
   DEFINE ls_wc      LIKE type_t.chr500
   DEFINE ls_wc2     LIKE type_t.chr500
   DEFINE ls_return  STRING
   DEFINE ls_result  STRING 
   #add-point:query段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理)
   DEFINE l_page_sql STRING   #組單頭sql
      
   DISPLAY ' ' TO FORMONLY.page
   DISPLAY ' ' TO FORMONLY.tot_page
   #end add-point 
   
   #add-point:FUNCTION前置處理

   #end add-point
 
   LET INT_FLAG = 0
   LET g_master.psca001 = ''
   LET g_master.psea002 = ''
   CLEAR FORM
   CALL g_psca_d.clear()
   CALL g_psca10_d.clear()   
   CALL g_psca11_d.clear()    
   CALL g_psca12_d.clear()
   CALL g_psca13_d.clear()
   CALL g_psca14_d.clear()
   CALL g_psca15_d.clear()
   CALL g_psca16_d.clear()
   CALL g_psca17_d.clear()
   CALL g_psca18_d.clear()
   CALL g_psca19_d.clear()
   CALL g_psca2_d.clear()
   CALL g_psca20_d.clear()
   CALL g_psca21_d.clear()
   CALL g_psca22_d.clear()
   CALL g_psca23_d.clear()
   CALL g_psca24_d.clear()
   CALL g_psca25_d.clear()
   CALL g_psca26_d.clear()
   CALL g_psca27_d.clear()
   CALL g_psca28_d.clear()
   CALL g_psca29_d.clear()
   CALL g_psca3_d.clear()
   CALL g_psca30_d.clear()
   CALL g_psca31_d.clear()
   CALL g_psca32_d.clear()
   CALL g_psca33_d.clear()
   CALL g_psca34_d.clear()
   CALL g_psca35_d.clear()
   CALL g_psca36_d.clear()
   CALL g_psca4_d.clear()
   CALL g_psca5_d.clear()
   CALL g_psca6_d.clear()
   CALL g_psca7_d.clear()
   CALL g_psca8_d.clear()
   CALL g_psca9_d.clear()
   #160107-00020#1 ---add (S)---
   IF NOT apsp102_create_temptable() THEN
      RETURN
   END IF
   #160107-00020#1 ---add (E)---
 
   
   CALL gfrm_curr.setFieldHidden("formonly.sel", TRUE)
   CALL gfrm_curr.setFieldHidden("formonly.statepic", TRUE)
   
   LET g_qryparam.state = "c"
   LET g_detail_idx  = 1
   LET g_detail_idx2 = 1
   LET g_wc_filter = " 1=1"
   LET g_current_page = 1
   LET g_detail_page_action = ""
   LET g_pagestart = 1
   LET g_flag = 0
   
   #wc備份
   LET ls_wc = g_wc
   LET ls_wc2 = g_wc2
   LET g_master_idx = l_ac
 
   
 
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
      ##add-point:query段more_construct                      
       INPUT BY NAME g_master.psca001,g_master.psea002
            ATTRIBUTE(WITHOUT DEFAULTS)
            
          BEFORE INPUT
          
          AFTER FIELD psca001
             IF NOT cl_null(g_master.psca001) THEN
                IF g_master.psca001 <> g_master_t.psca001 THEN
                   LET g_master.psea002 = ''
                END IF
                LET g_master_t.psca001 = g_master.psca001
             END IF
            
          AFTER FIELD psea002
          
          ON ACTION controlp INFIELD psca001
             INITIALIZE g_qryparam.* TO NULL
             LET g_qryparam.state = "i"
             LET g_qryparam.reqry = FALSE
             CALL q_psca001()
             LET g_master.psca001 = g_qryparam.return1             
             DISPLAY g_master.psca001  TO psca001
             NEXT FIELD psca001
          
          ON ACTION controlp INFIELD psea002
             INITIALIZE g_qryparam.* TO NULL
             LET g_qryparam.state = "i"
             LET g_qryparam.reqry = FALSE
             LET g_qryparam.arg1  = g_master.psca001
             CALL q_psea002()
             LET g_master.psea002 = g_qryparam.return1             
             DISPLAY g_master.psea002  TO psea002
             NEXT FIELD psea002

       END INPUT
      #end add-point 
   
     #單身根據table分拆construct
     #---------物料需求(MP)-----------
     #需求訂單CONSTRUCT 
      CONSTRUCT g_wc_table1 ON xmdadocno,xmdd001
           FROM s_detail1[1].l_xmdadocno,s_detail1[1].l_xmdd001
                      
         BEFORE CONSTRUCT
            #add-point:cs段more_construct

            #end add-point 
            
       #單身公用欄位開窗相關處理
       
         
       #單身一般欄位開窗相關處理
         #----<<sel>>----
         #----<<xmdadocno>>----
         #----<<xmdd001>>----
         #應用 a01 樣板自動產生(Version:1)
         BEFORE FIELD xmdadocno
            #add-point:BEFORE FIELD xmdadocno

            #END add-point
 
         #應用 a02 樣板自動產生(Version:1)
         AFTER FIELD xmdadocno
            
            #add-point:AFTER FIELD xmdadocno

            #END add-point
            
 
         #Ctrlp:construct.c.page1.xmdadocno
         #應用 a03 樣板自動產生(Version:2)
         ON ACTION controlp INFIELD xmdadocno
            #add-point:ON ACTION controlp INFIELD xmdadocno

            #END add-point
 
         #----<<xmdd001>>----
         #應用 a01 樣板自動產生(Version:1)
         BEFORE FIELD xmdd001
            #add-point:BEFORE FIELD xmdd001

            #END add-point
 
         #應用 a02 樣板自動產生(Version:1)
         AFTER FIELD xmdd001
            
            #add-point:AFTER FIELD xmdd001

            #END add-point
            
 
         #Ctrlp:construct.c.page1.xmdd001
         #應用 a03 樣板自動產生(Version:2)
         ON ACTION controlp INFIELD xmdd001
            #add-point:ON ACTION controlp INFIELD xmdd001

            #END add-point
      END CONSTRUCT
      
      #請採購單CONSTRUCT 
      CONSTRUCT g_wc_table2 ON pmdodocno,pmdo001
           FROM s_detail2[1].l_pmdodocno,s_detail2[1].l_pmdo001
                      
         BEFORE CONSTRUCT
            #add-point:cs段more_construct

            #end add-point 
            
       #單身公用欄位開窗相關處理
       
         
       #單身一般欄位開窗相關處理
         #----<<sel>>----
         #----<<pmdodocno>>----
         #----<<pmdo001>>----
         #應用 a01 樣板自動產生(Version:1)
         BEFORE FIELD pmdodocno
            #add-point:BEFORE FIELD pmdodocno

            #END add-point
 
         #應用 a02 樣板自動產生(Version:1)
         AFTER FIELD pmdodocno
            
            #add-point:AFTER FIELD pmdodocno

            #END add-point
            
 
         #Ctrlp:construct.c.page1.pmdodocno
         #應用 a03 樣板自動產生(Version:2)
         ON ACTION controlp INFIELD pmdodocno
            #add-point:ON ACTION controlp INFIELD pmdodocno

            #END add-point
 
         #----<<xmdd001>>----
         #應用 a01 樣板自動產生(Version:1)
         BEFORE FIELD pmdo001
            #add-point:BEFORE FIELD pmdo001

            #END add-point
 
         #應用 a02 樣板自動產生(Version:1)
         AFTER FIELD pmdo001
            
            #add-point:AFTER FIELD pmdo001

            #END add-point
            
 
         #Ctrlp:construct.c.page1.pmdo001
         #應用 a03 樣板自動產生(Version:2)
         ON ACTION controlp INFIELD pmdo001
            #add-point:ON ACTION controlp INFIELD pmdo001

            #END add-point
      END CONSTRUCT
      
      #工單CONSTRUCT 
      CONSTRUCT g_wc_table3 ON sfaadocno,sfaa010
           FROM s_detail3[1].l_sfaadocno,s_detail3[1].l_sfaa010
                      
         BEFORE CONSTRUCT
            #add-point:cs段more_construct

            #end add-point 
            
       #單身公用欄位開窗相關處理
       
         
       #單身一般欄位開窗相關處理
         #----<<sel>>----
         #----<<sfaadocno>>----
         #----<<sfaa010>>----
         #應用 a01 樣板自動產生(Version:1)
         BEFORE FIELD sfaadocno
            #add-point:BEFORE FIELD sfaadocno

            #END add-point
 
         #應用 a02 樣板自動產生(Version:1)
         AFTER FIELD sfaadocno
            
            #add-point:AFTER FIELD sfaadocno

            #END add-point
            
 
         #Ctrlp:construct.c.page1.sfaadocno
         #應用 a03 樣板自動產生(Version:2)
         ON ACTION controlp INFIELD sfaadocno
            #add-point:ON ACTION controlp INFIELD sfaadocno

            #END add-point
 
         #----<<xmdd001>>----
         #應用 a01 樣板自動產生(Version:1)
         BEFORE FIELD sfaa010
            #add-point:BEFORE FIELD sfaa010

            #END add-point
 
         #應用 a02 樣板自動產生(Version:1)
         AFTER FIELD sfaa010
            
            #add-point:AFTER FIELD sfaa010

            #END add-point
            
 
         #Ctrlp:construct.c.page1.sfaa010
         #應用 a03 樣板自動產生(Version:2)
         ON ACTION controlp INFIELD sfaa010
            #add-point:ON ACTION controlp INFIELD sfaa010

            #END add-point
      END CONSTRUCT
      
      
     #工單領料狀況CONSTRUCT
      CONSTRUCT g_wc_table4 ON sfbadocno,sfba006
           FROM s_detail4[1].l_sfbadocno,s_detail4[1].l_sfba006
                      
         BEFORE CONSTRUCT
            #add-point:cs段more_construct
            
            #end add-point 
            
       #單身公用欄位開窗相關處理
       
         
       #單身一般欄位開窗相關處理
         #----<<sel>>----
         #----<<sfbadocno>>----
         #----<<sfba006>>----
         #應用 a01 樣板自動產生(Version:1)
         BEFORE FIELD sfbadocno
            #add-point:BEFORE FIELD sfbadocno

            #END add-point
 
         #應用 a02 樣板自動產生(Version:1)
         AFTER FIELD sfbadocno
            
            #add-point:AFTER FIELD sfbadocno

            #END add-point
            
 
         #Ctrlp:construct.c.page1.sfbadocno
         #應用 a03 樣板自動產生(Version:2)
         ON ACTION controlp INFIELD sfbadocno
            #add-point:ON ACTION controlp INFIELD sfbadocno

            #END add-point
 
         #----<<sfba006>>----
         #應用 a01 樣板自動產生(Version:1)
         BEFORE FIELD sfba006
            #add-point:BEFORE FIELD sfba006

            #END add-point
 
         #應用 a02 樣板自動產生(Version:1)
         AFTER FIELD sfba006
            
            #add-point:AFTER FIELD sfba006

            #END add-point
            
 
         #Ctrlp:construct.c.page1.xmdd001
         #應用 a03 樣板自動產生(Version:2)
         ON ACTION controlp INFIELD sfba006
            #add-point:ON ACTION controlp INFIELD sfba006

            #END add-point
      END CONSTRUCT
      
      #料件總表CONSTRUCT
      CONSTRUCT g_wc_table5 ON imaa001
           FROM s_detail5[1].l_imaa001
                      
         BEFORE CONSTRUCT
            #add-point:cs段more_construct

            #end add-point 
            
       #單身公用欄位開窗相關處理
       
         
       #單身一般欄位開窗相關處理
         #----<<sel>>----
         #----<<imaa001>>----
         #應用 a01 樣板自動產生(Version:1)
         BEFORE FIELD imaa001
            #add-point:BEFORE FIELD imaa001

            #END add-point
 
         #應用 a02 樣板自動產生(Version:1)
         AFTER FIELD imaa001
            
            #add-point:AFTER FIELD imaa001

            #END add-point
            
 
         #Ctrlp:construct.c.page1.imaa001
         #應用 a03 樣板自動產生(Version:2)
         ON ACTION controlp INFIELD imaa001
            #add-point:ON ACTION controlp INFIELD imaa001

            #END add-point
      END CONSTRUCT
      
      #料件特徵CONSTRUCT
      CONSTRUCT g_wc_table6 ON imeb001
           FROM s_detail6[1].l_imeb001
                      
         BEFORE CONSTRUCT
            #add-point:cs段more_construct

            #end add-point 
            
       #單身公用欄位開窗相關處理
       
         
       #單身一般欄位開窗相關處理
         #----<<sel>>----
         #----<<imeb001>>----
         #應用 a01 樣板自動產生(Version:1)
         BEFORE FIELD imeb001
            #add-point:BEFORE FIELD imeb001

            #END add-point
 
         #應用 a02 樣板自動產生(Version:1)
         AFTER FIELD imeb001
            
            #add-point:AFTER FIELD imeb001

            #END add-point
            
 
         #Ctrlp:construct.c.page1.imeb001
         #應用 a03 樣板自動產生(Version:2)
         ON ACTION controlp INFIELD imeb001
            #add-point:ON ACTION controlp INFIELD imeb001

            #END add-point
      END CONSTRUCT
      
      #BOM表CONSTRUCT
      CONSTRUCT g_wc_table7 ON bmba001,bmba003
           FROM s_detail7[1].l_bmba001,s_detail7[1].l_bmba003
                      
         BEFORE CONSTRUCT
            #add-point:cs段more_construct

            #end add-point 
            
       #單身公用欄位開窗相關處理
       
         
       #單身一般欄位開窗相關處理
         #----<<sel>>----
         #----<<bmba001>>----
         #----<<bmba003>>----
         #應用 a01 樣板自動產生(Version:1)
         BEFORE FIELD bmba001
            #add-point:BEFORE FIELD bmba001

            #END add-point
 
         #應用 a02 樣板自動產生(Version:1)
         AFTER FIELD bmba001
            
            #add-point:AFTER FIELD bmba001

            #END add-point
            
 
         #Ctrlp:construct.c.page1.bmba001
         #應用 a03 樣板自動產生(Version:2)
         ON ACTION controlp INFIELD bmba001
            #add-point:ON ACTION controlp INFIELD bmba001

            #END add-point
 
         #----<<bmba003>>----
         #應用 a01 樣板自動產生(Version:1)
         BEFORE FIELD bmba003
            #add-point:BEFORE FIELD bmba003

            #END add-point
 
         #應用 a02 樣板自動產生(Version:1)
         AFTER FIELD bmba003
            
            #add-point:AFTER FIELD bmba003

            #END add-point
            
 
         #Ctrlp:construct.c.page1.bmba003
         #應用 a03 樣板自動產生(Version:2)
         ON ACTION controlp INFIELD bmba003
            #add-point:ON ACTION controlp INFIELD bmba003

            #END add-point
      END CONSTRUCT
      
      #庫存CONSTRUCT
      CONSTRUCT g_wc_table8 ON inag001
           FROM s_detail8[1].l_inag001
                      
         BEFORE CONSTRUCT
            #add-point:cs段more_construct

            #end add-point 
            
       #單身公用欄位開窗相關處理
       
         
       #單身一般欄位開窗相關處理
         #----<<sel>>----
         #----<<inag001>>----
         #應用 a01 樣板自動產生(Version:1)
         BEFORE FIELD inag001
            #add-point:BEFORE FIELD inag001

            #END add-point
 
         #應用 a02 樣板自動產生(Version:1)
         AFTER FIELD inag001
            
            #add-point:AFTER FIELD inag001

            #END add-point
            
 
         #Ctrlp:construct.c.page1.inag001
         #應用 a03 樣板自動產生(Version:2)
         ON ACTION controlp INFIELD inag001
            #add-point:ON ACTION controlp INFIELD inag001

            #END add-point
      END CONSTRUCT
      
      #倉庫CONSTRUCT
      CONSTRUCT g_wc_table9 ON inaa001
           FROM s_detail9[1].l_inaa001
                      
         BEFORE CONSTRUCT
            #add-point:cs段more_construct

            #end add-point 
            
       #單身公用欄位開窗相關處理
       
         
       #單身一般欄位開窗相關處理
         #----<<sel>>----
         #----<<inaa001>>----
         #應用 a01 樣板自動產生(Version:1)
         BEFORE FIELD inaa001
            #add-point:BEFORE FIELD inaa001

            #END add-point
 
         #應用 a02 樣板自動產生(Version:1)
         AFTER FIELD inaa001
            
            #add-point:AFTER FIELD inaa001

            #END add-point
            
 
         #Ctrlp:construct.c.page1.inaa001
         #應用 a03 樣板自動產生(Version:2)
         ON ACTION controlp INFIELD inaa001
            #add-point:ON ACTION controlp INFIELD inaa001

            #END add-point
      END CONSTRUCT
      
     #儲位CONSTRUCT 
      CONSTRUCT g_wc_table10 ON inab001,inab002
           FROM s_detail10[1].l_inab001,s_detail10[1].l_inab002
                      
         BEFORE CONSTRUCT
            #add-point:cs段more_construct

            #end add-point 
            
       #單身公用欄位開窗相關處理
       
         
       #單身一般欄位開窗相關處理
         #----<<sel>>----
         #----<<inab001>>----
         #----<<inab002>>----
         #應用 a01 樣板自動產生(Version:1)
         BEFORE FIELD inab001
            #add-point:BEFORE FIELD inab001

            #END add-point
 
         #應用 a02 樣板自動產生(Version:1)
         AFTER FIELD inab001
            
            #add-point:AFTER FIELD inab001

            #END add-point
            
 
         #Ctrlp:construct.c.page1.inab001
         #應用 a03 樣板自動產生(Version:2)
         ON ACTION controlp INFIELD inab001
            #add-point:ON ACTION controlp INFIELD inab001

            #END add-point
 
         #----<<inab002>>----
         #應用 a01 樣板自動產生(Version:1)
         BEFORE FIELD inab002
            #add-point:BEFORE FIELD inab002

            #END add-point
 
         #應用 a02 樣板自動產生(Version:1)
         AFTER FIELD inab002
            
            #add-point:AFTER FIELD inab002

            #END add-point
            
 
         #Ctrlp:construct.c.page1.inab002
         #應用 a03 樣板自動產生(Version:2)
         ON ACTION controlp INFIELD inab002
            #add-point:ON ACTION controlp INFIELD inab002

            #END add-point
      END CONSTRUCT
      
      #特徵限定用料CONSTRUCT 
      CONSTRUCT g_wc_table11 ON bmca001,bmca003
           FROM s_detail11[1].l_bmca001,s_detail11[1].l_bmca003
                      
         BEFORE CONSTRUCT
            #add-point:cs段more_construct

            #end add-point 
            
       #單身公用欄位開窗相關處理
       
         
       #單身一般欄位開窗相關處理
         #----<<sel>>----
         #----<<bmca001>>----
         #----<<bmca003>>----
         #應用 a01 樣板自動產生(Version:1)
         BEFORE FIELD bmca001
            #add-point:BEFORE FIELD bmca001

            #END add-point
 
         #應用 a02 樣板自動產生(Version:1)
         AFTER FIELD bmca001
            
            #add-point:AFTER FIELD bmca001

            #END add-point
            
 
         #Ctrlp:construct.c.page1.bmca001
         #應用 a03 樣板自動產生(Version:2)
         ON ACTION controlp INFIELD bmca001
            #add-point:ON ACTION controlp INFIELD bmca001

            #END add-point
 
         #----<<bmca003>>----
         #應用 a01 樣板自動產生(Version:1)
         BEFORE FIELD bmca003
            #add-point:BEFORE FIELD bmca003

            #END add-point
 
         #應用 a02 樣板自動產生(Version:1)
         AFTER FIELD bmca003
            
            #add-point:AFTER FIELD bmca003

            #END add-point
            
 
         #Ctrlp:construct.c.page1.bmca003
         #應用 a03 樣板自動產生(Version:2)
         ON ACTION controlp INFIELD bmca003
            #add-point:ON ACTION controlp INFIELD bmca003

            #END add-point
      END CONSTRUCT
      
      #特徵對應CONSTRUCT 
      CONSTRUCT g_wc_table12 ON bmc001,bmcc003
           FROM s_detail12[1].l_bmc001,s_detail12[1].l_bmcc003
                      
         BEFORE CONSTRUCT
            #add-point:cs段more_construct

            #end add-point 
            
       #單身公用欄位開窗相關處理
       
         
       #單身一般欄位開窗相關處理
         #----<<sel>>----
         #----<<bmc001>>----
         #----<<bmcc003>>----
         #應用 a01 樣板自動產生(Version:1)
         BEFORE FIELD bmc001
            #add-point:BEFORE FIELD bmc001

            #END add-point
 
         #應用 a02 樣板自動產生(Version:1)
         AFTER FIELD bmc001
            
            #add-point:AFTER FIELD bmc001

            #END add-point
            
 
         #Ctrlp:construct.c.page1.bmc001
         #應用 a03 樣板自動產生(Version:2)
         ON ACTION controlp INFIELD bmc001
            #add-point:ON ACTION controlp INFIELD bmc001

            #END add-point
 
         #----<<bmcc003>>----
         #應用 a01 樣板自動產生(Version:1)
         BEFORE FIELD bmcc003
            #add-point:BEFORE FIELD bmcc003

            #END add-point
 
         #應用 a02 樣板自動產生(Version:1)
         AFTER FIELD bmcc003
            
            #add-point:AFTER FIELD bmcc003

            #END add-point
            
 
         #Ctrlp:construct.c.page1.bmcc003
         #應用 a03 樣板自動產生(Version:2)
         ON ACTION controlp INFIELD bmcc003
            #add-point:ON ACTION controlp INFIELD bmcc003

            #END add-point
      END CONSTRUCT
      
      #料件特徵群組CONSTRUCT 
      CONSTRUCT g_wc_table13 ON imec001
           FROM s_detail13[1].l_imec001
                      
         BEFORE CONSTRUCT
            #add-point:cs段more_construct

            #end add-point 
            
       #單身公用欄位開窗相關處理
       
         
       #單身一般欄位開窗相關處理
         #----<<sel>>----
         #----<<imec001>>----
         #應用 a01 樣板自動產生(Version:1)
         BEFORE FIELD imec001
            #add-point:BEFORE FIELD imec001

            #END add-point
 
         #應用 a02 樣板自動產生(Version:1)
         AFTER FIELD imec001
            
            #add-point:AFTER FIELD imec001

            #END add-point
            
 
         #Ctrlp:construct.c.page1.imec001
         #應用 a03 樣板自動產生(Version:2)
         ON ACTION controlp INFIELD imec001
            #add-point:ON ACTION controlp INFIELD imec001

            #END add-point
      END CONSTRUCT
      
      #元件限定特徵CONSTRUCT 
      CONSTRUCT g_wc_table14 ON bmce001,bmce003
           FROM s_detail14[1].l_bmce001,s_detail14[1].l_bmce003
                      
         BEFORE CONSTRUCT
            #add-point:cs段more_construct

            #end add-point 
            
       #單身公用欄位開窗相關處理
       
         
       #單身一般欄位開窗相關處理
         #----<<sel>>----
         #----<<bmce001>>----
         #----<<bmce003>>----
         #應用 a01 樣板自動產生(Version:1)
         BEFORE FIELD bmce001
            #add-point:BEFORE FIELD bmce001

            #END add-point
 
         #應用 a02 樣板自動產生(Version:1)
         AFTER FIELD bmce001
            
            #add-point:AFTER FIELD bmce001

            #END add-point
            
 
         #Ctrlp:construct.c.page1.bmce001
         #應用 a03 樣板自動產生(Version:2)
         ON ACTION controlp INFIELD bmce001
            #add-point:ON ACTION controlp INFIELD bmce001

            #END add-point
 
         #----<<bmce003>>----
         #應用 a01 樣板自動產生(Version:1)
         BEFORE FIELD bmce003
            #add-point:BEFORE FIELD bmce003

            #END add-point
 
         #應用 a02 樣板自動產生(Version:1)
         AFTER FIELD bmce003
            
            #add-point:AFTER FIELD bmce003

            #END add-point
            
 
         #Ctrlp:construct.c.page1.bmce003
         #應用 a03 樣板自動產生(Version:2)
         ON ACTION controlp INFIELD bmce003
            #add-point:ON ACTION controlp INFIELD bmce003

            #END add-point
      END CONSTRUCT
      
      #聯產品資料CONSTRUCT 
      CONSTRUCT g_wc_table15 ON bmab001,bmab003
           FROM s_detail15[1].l_bmab001,s_detail15[1].l_bmab003
                      
         BEFORE CONSTRUCT
            #add-point:cs段more_construct

            #end add-point 
            
       #單身公用欄位開窗相關處理
       
         
       #單身一般欄位開窗相關處理
         #----<<sel>>----
         #----<<bmab001>>----
         #----<<bmab003>>----
         #應用 a01 樣板自動產生(Version:1)
         BEFORE FIELD bmab001
            #add-point:BEFORE FIELD bmab001

            #END add-point
 
         #應用 a02 樣板自動產生(Version:1)
         AFTER FIELD bmab001
            
            #add-point:AFTER FIELD bmab001

            #END add-point
            
 
         #Ctrlp:construct.c.page1.bmab001
         #應用 a03 樣板自動產生(Version:2)
         ON ACTION controlp INFIELD bmab001
            #add-point:ON ACTION controlp INFIELD bmab001

            #END add-point
 
         #----<<bmab003>>----
         #應用 a01 樣板自動產生(Version:1)
         BEFORE FIELD bmab003
            #add-point:BEFORE FIELD bmab003

            #END add-point
 
         #應用 a02 樣板自動產生(Version:1)
         AFTER FIELD bmab003
            
            #add-point:AFTER FIELD bmab003

            #END add-point
            
 
         #Ctrlp:construct.c.page1.bmab003
         #應用 a03 樣板自動產生(Version:2)
         ON ACTION controlp INFIELD bmab003
            #add-point:ON ACTION controlp INFIELD bmab003

            #END add-point
      END CONSTRUCT
      
      #BOM取替代CONSTRUCT 
      CONSTRUCT g_wc_table16 ON bmea001,bmea003
           FROM s_detail16[1].l_bmea001,s_detail16[1].l_bmea003
                      
         BEFORE CONSTRUCT
            #add-point:cs段more_construct

            #end add-point 
            
       #單身公用欄位開窗相關處理
       
         
       #單身一般欄位開窗相關處理
         #----<<sel>>----
         #----<<bmea001>>----
         #----<<bmea003>>----
         #應用 a01 樣板自動產生(Version:1)
         BEFORE FIELD bmea001
            #add-point:BEFORE FIELD bmea001

            #END add-point
 
         #應用 a02 樣板自動產生(Version:1)
         AFTER FIELD bmea001
            
            #add-point:AFTER FIELD bmea001

            #END add-point
            
 
         #Ctrlp:construct.c.page1.bmea001
         #應用 a03 樣板自動產生(Version:2)
         ON ACTION controlp INFIELD bmea001
            #add-point:ON ACTION controlp INFIELD bmea001

            #END add-point
 
         #----<<bmab003>>----
         #應用 a01 樣板自動產生(Version:1)
         BEFORE FIELD bmea003
            #add-point:BEFORE FIELD bmea003

            #END add-point
 
         #應用 a02 樣板自動產生(Version:1)
         AFTER FIELD bmea003
            
            #add-point:AFTER FIELD bmea003

            #END add-point
            
 
         #Ctrlp:construct.c.page1.bmea003
         #應用 a03 樣板自動產生(Version:2)
         ON ACTION controlp INFIELD bmea003
            #add-point:ON ACTION controlp INFIELD bmea003

            #END add-point
      END CONSTRUCT
      
      #品號取替代CONSTRUCT 
      CONSTRUCT g_wc_table17 ON bmea001_1,bmea008_1
           FROM s_detail17[1].l_bmea001_1,s_detail17[1].l_bmea008_1
                      
         BEFORE CONSTRUCT
            #add-point:cs段more_construct

            #end add-point 
            
       #單身公用欄位開窗相關處理
       
         
       #單身一般欄位開窗相關處理
         #----<<sel>>----
         #----<<bmea001_1>>----
         #----<<bmea008_1>>----
         #應用 a01 樣板自動產生(Version:1)
         BEFORE FIELD bmea001_1
            #add-point:BEFORE FIELD bmea001_1

            #END add-point
 
         #應用 a02 樣板自動產生(Version:1)
         AFTER FIELD bmea001_1
            
            #add-point:AFTER FIELD bmea001_1

            #END add-point
            
 
         #Ctrlp:construct.c.page1.bmea001_1
         #應用 a03 樣板自動產生(Version:2)
         ON ACTION controlp INFIELD bmea001_1
            #add-point:ON ACTION controlp INFIELD bmea001_1

            #END add-point
 
         #----<<bmea008_1>>----
         #應用 a01 樣板自動產生(Version:1)
         BEFORE FIELD bmea008_1
            #add-point:BEFORE FIELD bmea008_1

            #END add-point
 
         #應用 a02 樣板自動產生(Version:1)
         AFTER FIELD bmea008_1
            
            #add-point:AFTER FIELD bmea008_1

            #END add-point
            
 
         #Ctrlp:construct.c.page1.bmea008_1
         #應用 a03 樣板自動產生(Version:2)
         ON ACTION controlp INFIELD bmea008_1
            #add-point:ON ACTION controlp INFIELD bmea008_1

            #END add-point
      END CONSTRUCT
      
      #工作站CONSTRUCT 
      CONSTRUCT g_wc_table18 ON ecaa001
           FROM s_detail18[1].l_ecaa001
                      
         BEFORE CONSTRUCT
            #add-point:cs段more_construct

            #end add-point 
            
       #單身公用欄位開窗相關處理
       
         
       #單身一般欄位開窗相關處理
         #----<<sel>>----
         #----<<ecaa001>>----
         #應用 a01 樣板自動產生(Version:1)
         BEFORE FIELD ecaa001
            #add-point:BEFORE FIELD ecaa001

            #END add-point
 
         #應用 a02 樣板自動產生(Version:1)
         AFTER FIELD ecaa001
            
            #add-point:AFTER FIELD ecaa001

            #END add-point
            
 
         #Ctrlp:construct.c.page1.ecaa001
         #應用 a03 樣板自動產生(Version:2)
         ON ACTION controlp INFIELD ecaa001
            #add-point:ON ACTION controlp INFIELD ecaa001

            #END add-point
      END CONSTRUCT
      
      #損耗區間CONSTRUCT 
      CONSTRUCT g_wc_table19 ON bmbb001,bmbb003
           FROM s_detail19[1].l_bmbb001,s_detail19[1].l_bmbb003
                      
         BEFORE CONSTRUCT
            #add-point:cs段more_construct

            #end add-point 
            
       #單身公用欄位開窗相關處理
       
         
       #單身一般欄位開窗相關處理
         #----<<sel>>----
         #----<<bmbb001>>----
         #----<<bmbb003>>----
         #應用 a01 樣板自動產生(Version:1)
         BEFORE FIELD bmbb001
            #add-point:BEFORE FIELD bmbb001

            #END add-point
 
         #應用 a02 樣板自動產生(Version:1)
         AFTER FIELD bmbb001
            
            #add-point:AFTER FIELD bmbb001

            #END add-point
            
 
         #Ctrlp:construct.c.page1.bmbb001
         #應用 a03 樣板自動產生(Version:2)
         ON ACTION controlp INFIELD bmbb001
            #add-point:ON ACTION controlp INFIELD bmbb001

            #END add-point
 
         #----<<bmbb003>>----
         #應用 a01 樣板自動產生(Version:1)
         BEFORE FIELD bmbb003
            #add-point:BEFORE FIELD bmbb003

            #END add-point
 
         #應用 a02 樣板自動產生(Version:1)
         AFTER FIELD bmbb003
            
            #add-point:AFTER FIELD bmbb003

            #END add-point
            
 
         #Ctrlp:construct.c.page1.bmbb003
         #應用 a03 樣板自動產生(Version:2)
         ON ACTION controlp INFIELD bmbb003
            #add-point:ON ACTION controlp INFIELD bmbb003

            #END add-point
      END CONSTRUCT
      
      #MPS工單中介檔CONSTRUCT 
      CONSTRUCT g_wc_table20 ON psoa003,psoa009
           FROM s_detail20[1].l_psoa003,s_detail20[1].l_psoa009
                      
         BEFORE CONSTRUCT
            #add-point:cs段more_construct

            #end add-point 
            
       #單身公用欄位開窗相關處理
       
         
       #單身一般欄位開窗相關處理
         #----<<sel>>----
         #----<<psoa003>>----
         #----<<psoa009>>----
         #應用 a01 樣板自動產生(Version:1)
         BEFORE FIELD psoa003
            #add-point:BEFORE FIELD psoa003

            #END add-point
 
         #應用 a02 樣板自動產生(Version:1)
         AFTER FIELD psoa003
            
            #add-point:AFTER FIELD psoa003

            #END add-point
            
 
         #Ctrlp:construct.c.page1.psoa003
         #應用 a03 樣板自動產生(Version:2)
         ON ACTION controlp INFIELD psoa003
            #add-point:ON ACTION controlp INFIELD psoa003

            #END add-point
 
         #----<<psoa009>>----
         #應用 a01 樣板自動產生(Version:1)
         BEFORE FIELD psoa009
            #add-point:BEFORE FIELD psoa009

            #END add-point
 
         #應用 a02 樣板自動產生(Version:1)
         AFTER FIELD psoa009
            
            #add-point:AFTER FIELD psoa009

            #END add-point
            
 
         #Ctrlp:construct.c.page1.psoa009
         #應用 a03 樣板自動產生(Version:2)
         ON ACTION controlp INFIELD psoa009
            #add-point:ON ACTION controlp INFIELD psoa009

            #END add-point
      END CONSTRUCT
      
      #---------產能規劃(CP)-----------
      #需求訂單CONSTRUCT 
      CONSTRUCT g_wc_table21 ON psod003,psod004
           FROM s_detail21[1].l_psod003,s_detail21[1].l_psod004
                      
         BEFORE CONSTRUCT
            #add-point:cs段more_construct
             LET g_flag = 1
            #end add-point 
            
       #單身公用欄位開窗相關處理
       
         
       #單身一般欄位開窗相關處理
         #----<<sel>>----
         #----<<psod003>>----
         #----<<psod004>>----
         #應用 a01 樣板自動產生(Version:1)
         BEFORE FIELD psod003
            #add-point:BEFORE FIELD psod003

            #END add-point
 
         #應用 a02 樣板自動產生(Version:1)
         AFTER FIELD psod003
            
            #add-point:AFTER FIELD psod003

            #END add-point
            
 
         #Ctrlp:construct.c.page1.psod003
         #應用 a03 樣板自動產生(Version:2)
         ON ACTION controlp INFIELD psod003
            #add-point:ON ACTION controlp INFIELD psod003

            #END add-point
 
         #----<<psod004>>----
         #應用 a01 樣板自動產生(Version:1)
         BEFORE FIELD psod004
            #add-point:BEFORE FIELD psod004

            #END add-point
 
         #應用 a02 樣板自動產生(Version:1)
         AFTER FIELD psod004
            
            #add-point:AFTER FIELD psod004

            #END add-point
            
 
         #Ctrlp:construct.c.page1.psod004
         #應用 a03 樣板自動產生(Version:2)
         ON ACTION controlp INFIELD psod004
            #add-point:ON ACTION controlp INFIELD psod004

            #END add-point
      END CONSTRUCT
 
      #採購單CONSTRUCT 
      CONSTRUCT g_wc_table22 ON psoc003,psoc004
           FROM s_detail22[1].l_psoc003,s_detail22[1].l_psoc004
                      
         BEFORE CONSTRUCT
            #add-point:cs段more_construct
             LET g_flag = 1
            #end add-point 
            
       #單身公用欄位開窗相關處理
       
         
       #單身一般欄位開窗相關處理
         #----<<sel>>----
         #----<<psoc003>>----
         #----<<psoc004>>----
         #應用 a01 樣板自動產生(Version:1)
         BEFORE FIELD psoc003
            #add-point:BEFORE FIELD psoc003

            #END add-point
 
         #應用 a02 樣板自動產生(Version:1)
         AFTER FIELD psoc003
            
            #add-point:AFTER FIELD psoc003

            #END add-point
            
 
         #Ctrlp:construct.c.page1.psoc003
         #應用 a03 樣板自動產生(Version:2)
         ON ACTION controlp INFIELD psoc003
            #add-point:ON ACTION controlp INFIELD psoc003

            #END add-point
 
         #----<<psoc004>>----
         #應用 a01 樣板自動產生(Version:1)
         BEFORE FIELD psoc004
            #add-point:BEFORE FIELD psoc004

            #END add-point
 
         #應用 a02 樣板自動產生(Version:1)
         AFTER FIELD psoc004
            
            #add-point:AFTER FIELD psoc004

            #END add-point
            
 
         #Ctrlp:construct.c.page1.psoc004
         #應用 a03 樣板自動產生(Version:2)
         ON ACTION controlp INFIELD psoc004
            #add-point:ON ACTION controlp INFIELD psoc004

            #END add-point
      END CONSTRUCT
 
      #工單CONSTRUCT 
      CONSTRUCT g_wc_table23 ON psoa003,psoa009
           FROM s_detail23[1].l_psoa003_1,s_detail23[1].l_psoa009_1
                      
         BEFORE CONSTRUCT
            #add-point:cs段more_construct
             LET g_flag = 1
            #end add-point 
            
       #單身公用欄位開窗相關處理
       
         
       #單身一般欄位開窗相關處理
         #----<<sel>>----
         #----<<psoa003>>----
         #----<<psoa009>>----
         #應用 a01 樣板自動產生(Version:1)
         BEFORE FIELD psoa003
            #add-point:BEFORE FIELD psoa003

            #END add-point
 
         #應用 a02 樣板自動產生(Version:1)
         AFTER FIELD psoa003
            
            #add-point:AFTER FIELD psoa003

            #END add-point
            
 
         #Ctrlp:construct.c.page1.psoa003
         #應用 a03 樣板自動產生(Version:2)
         ON ACTION controlp INFIELD psoa003
            #add-point:ON ACTION controlp INFIELD psoa003

            #END add-point
 
         #----<<psoa009>>----
         #應用 a01 樣板自動產生(Version:1)
         BEFORE FIELD psoa009
            #add-point:BEFORE FIELD psoa009

            #END add-point
 
         #應用 a02 樣板自動產生(Version:1)
         AFTER FIELD psoa009
            
            #add-point:AFTER FIELD psoc004

            #END add-point
            
 
         #Ctrlp:construct.c.page1.psoa009
         #應用 a03 樣板自動產生(Version:2)
         ON ACTION controlp INFIELD psoa009
            #add-point:ON ACTION controlp INFIELD psoa009

            #END add-point
      END CONSTRUCT
 
      #工單領料狀況CONSTRUCT 
      CONSTRUCT g_wc_table24 ON sfbadocno_1,sfba006_1
           FROM s_detail24[1].l_sfbadocno_1,s_detail24[1].l_sfba006_1
                      
         BEFORE CONSTRUCT
            #add-point:cs段more_construct
             LET g_flag = 1
            #end add-point 
            
       #單身公用欄位開窗相關處理
       
         
       #單身一般欄位開窗相關處理
         #----<<sel>>----
         #----<<sfbadocno>>----
         #----<<sfba006>>----
         #應用 a01 樣板自動產生(Version:1)
         BEFORE FIELD sfbadocno
            #add-point:BEFORE FIELD sfbadocno

            #END add-point
 
         #應用 a02 樣板自動產生(Version:1)
         AFTER FIELD sfbadocno
            
            #add-point:AFTER FIELD sfbadocno

            #END add-point
            
 
         #Ctrlp:construct.c.page1.sfbadocno
         #應用 a03 樣板自動產生(Version:2)
         ON ACTION controlp INFIELD sfbadocno
            #add-point:ON ACTION controlp INFIELD sfbadocno

            #END add-point
 
         #----<<sfba006>>----
         #應用 a01 樣板自動產生(Version:1)
         BEFORE FIELD sfba006
            #add-point:BEFORE FIELD sfba006

            #END add-point
 
         #應用 a02 樣板自動產生(Version:1)
         AFTER FIELD sfba006
            
            #add-point:AFTER FIELD sfba006

            #END add-point
            
 
         #Ctrlp:construct.c.page1.sfba006
         #應用 a03 樣板自動產生(Version:2)
         ON ACTION controlp INFIELD sfba006
            #add-point:ON ACTION controlp INFIELD sfba006

            #END add-point
      END CONSTRUCT
 
      #MPS單據關連中介檔CONSTRUCT 
      CONSTRUCT g_wc_table25 ON psob003,psob005
           FROM s_detail25[1].l_psob003,s_detail25[1].l_psob005
                      
         BEFORE CONSTRUCT
            #add-point:cs段more_construct
             LET g_flag = 1
            #end add-point 
            
       #單身公用欄位開窗相關處理
       
         
       #單身一般欄位開窗相關處理
         #----<<sel>>----
         #----<<psob003>>----
         #----<<psob005>>----
         #應用 a01 樣板自動產生(Version:1)
         BEFORE FIELD psob003
            #add-point:BEFORE FIELD psob003

            #END add-point
 
         #應用 a02 樣板自動產生(Version:1)
         AFTER FIELD psob003
            
            #add-point:AFTER FIELD psob003

            #END add-point
            
 
         #Ctrlp:construct.c.page1.psob003
         #應用 a03 樣板自動產生(Version:2)
         ON ACTION controlp INFIELD psob003
            #add-point:ON ACTION controlp INFIELD psob003

            #END add-point
 
         #----<<psob005>>----
         #應用 a01 樣板自動產生(Version:1)
         BEFORE FIELD psob005
            #add-point:BEFORE FIELD psob005

            #END add-point
 
         #應用 a02 樣板自動產生(Version:1)
         AFTER FIELD psob005
            
            #add-point:AFTER FIELD psob005

            #END add-point
            
 
         #Ctrlp:construct.c.page1.psob005
         #應用 a03 樣板自動產生(Version:2)
         ON ACTION controlp INFIELD psob005
            #add-point:ON ACTION controlp INFIELD psob005

            #END add-point
      END CONSTRUCT
 
      #設備CONSTRUCT 
      CONSTRUCT g_wc_table26 ON equip_type,equip_id
           FROM s_detail26[1].l_equip_type,s_detail26[1].l_equip_id
                      
         BEFORE CONSTRUCT
            #add-point:cs段more_construct
             LET g_flag = 1
            #end add-point 
            
       #單身公用欄位開窗相關處理
       
         
       #單身一般欄位開窗相關處理
         #----<<sel>>----
         #----<<equip_type>>----
         #----<<equip_id>>----
         #應用 a01 樣板自動產生(Version:1)
         BEFORE FIELD equip_type
            #add-point:BEFORE FIELD equip_type

            #END add-point
 
         #應用 a02 樣板自動產生(Version:1)
         AFTER FIELD equip_type
            
            #add-point:AFTER FIELD equip_type

            #END add-point
            
 
         #Ctrlp:construct.c.page1.equip_type
         #應用 a03 樣板自動產生(Version:2)
         ON ACTION controlp INFIELD equip_type
            #add-point:ON ACTION controlp INFIELD equip_type

            #END add-point
 
         #----<<psob005>>----
         #應用 a01 樣板自動產生(Version:1)
         BEFORE FIELD equip_id
            #add-point:BEFORE FIELD equip_id

            #END add-point
 
         #應用 a02 樣板自動產生(Version:1)
         AFTER FIELD equip_id
            
            #add-point:AFTER FIELD equip_id

            #END add-point
            
 
         #Ctrlp:construct.c.page1.equip_id
         #應用 a03 樣板自動產生(Version:2)
         ON ACTION controlp INFIELD equip_id
            #add-point:ON ACTION controlp INFIELD equip_id

            #END add-point
      END CONSTRUCT
 
      #設備群組CONSTRUCT 
      CONSTRUCT g_wc_table27 ON equip_group_id,equip_type
           FROM s_detail27[1].l_equip_group_id,s_detail27[1].l_equip_type_1
                      
         BEFORE CONSTRUCT
            #add-point:cs段more_construct
             LET g_flag = 1
            #end add-point 
            
       #單身公用欄位開窗相關處理
       
         
       #單身一般欄位開窗相關處理
         #----<<sel>>----
         #----<<equip_group_id>>----
         #----<<equip_type_1>>----
         #應用 a01 樣板自動產生(Version:1)
         BEFORE FIELD equip_group_id
            #add-point:BEFORE FIELD equip_group_id

            #END add-point
 
         #應用 a02 樣板自動產生(Version:1)
         AFTER FIELD equip_group_id
            
            #add-point:AFTER FIELD equip_group_id

            #END add-point
            
 
         #Ctrlp:construct.c.page1.equip_group_id
         #應用 a03 樣板自動產生(Version:2)
         ON ACTION controlp INFIELD equip_group_id
            #add-point:ON ACTION controlp INFIELD equip_group_id

            #END add-point
 
         #----<<equip_type_1>>----
         #應用 a01 樣板自動產生(Version:1)
         BEFORE FIELD equip_type_1
            #add-point:BEFORE FIELD equip_type_1

            #END add-point
 
         #應用 a02 樣板自動產生(Version:1)
         AFTER FIELD equip_type_1
            
            #add-point:AFTER FIELD equip_type_1

            #END add-point
            
 
         #Ctrlp:construct.c.page1.equip_id
         #應用 a03 樣板自動產生(Version:2)
         ON ACTION controlp INFIELD equip_type_1
            #add-point:ON ACTION controlp INFIELD equip_type_1

            #END add-point
      END CONSTRUCT
 
      #日行事曆CONSTRUCT 
      CONSTRUCT g_wc_table28 ON mrbh001,mrbh002
           FROM s_detail28[1].l_mrbh001_1,s_detail28[1].l_mrbh002
                      
         BEFORE CONSTRUCT
            #add-point:cs段more_construct
             LET g_flag = 1
            #end add-point 
            
       #單身公用欄位開窗相關處理
       
         
       #單身一般欄位開窗相關處理
         #----<<sel>>----
         #----<<mrbh001>>----
         #----<<mrbh002>>----
         #應用 a01 樣板自動產生(Version:1)
         BEFORE FIELD mrbh001
            #add-point:BEFORE FIELD mrbh001

            #END add-point
 
         #應用 a02 樣板自動產生(Version:1)
         AFTER FIELD mrbh001
            
            #add-point:AFTER FIELD mrbh001

            #END add-point
            
 
         #Ctrlp:construct.c.page1.mrbh001
         #應用 a03 樣板自動產生(Version:2)
         ON ACTION controlp INFIELD mrbh001
            #add-point:ON ACTION controlp INFIELD mrbh001

            #END add-point
 
         #----<<mrbh002>>----
         #應用 a01 樣板自動產生(Version:1)
         BEFORE FIELD mrbh002
            #add-point:BEFORE FIELD mrbh002

            #END add-point
 
         #應用 a02 樣板自動產生(Version:1)
         AFTER FIELD mrbh002
            
            #add-point:AFTER FIELD mrbh002

            #END add-point
            
 
         #Ctrlp:construct.c.page1.equip_id
         #應用 a03 樣板自動產生(Version:2)
         ON ACTION controlp INFIELD mrbh002
            #add-point:ON ACTION controlp INFIELD mrbh002

            #END add-point
      END CONSTRUCT
      
      #週行事曆CONSTRUCT 

      #工作時段CONSTRUCT 
      CONSTRUCT g_wc_table30 ON wm_id,type
           FROM s_detail30[1].l_wm_id,s_detail30[1].l_type_2
                      
         BEFORE CONSTRUCT
            #add-point:cs段more_construct
             LET g_flag = 1
            #end add-point 
            
       #單身公用欄位開窗相關處理
       
         
       #單身一般欄位開窗相關處理
         #----<<sel>>----
         #----<<wm_id>>----
         #----<<type>>----
         #應用 a01 樣板自動產生(Version:1)
         BEFORE FIELD wm_id
            #add-point:BEFORE FIELD wm_id

            #END add-point
 
         #應用 a02 樣板自動產生(Version:1)
         AFTER FIELD wm_id
            
            #add-point:AFTER FIELD wm_id

            #END add-point
            
 
         #Ctrlp:construct.c.page1.wm_id
         #應用 a03 樣板自動產生(Version:2)
         ON ACTION controlp INFIELD wm_id
            #add-point:ON ACTION controlp INFIELD wm_id

            #END add-point
 
         #----<<mrbh002>>----
         #應用 a01 樣板自動產生(Version:1)
         BEFORE FIELD type
            #add-point:BEFORE FIELD type

            #END add-point
 
         #應用 a02 樣板自動產生(Version:1)
         AFTER FIELD type
            
            #add-point:AFTER FIELD type

            #END add-point
            
 
         #Ctrlp:construct.c.page1.type
         #應用 a03 樣板自動產生(Version:2)
         ON ACTION controlp INFIELD type
            #add-point:ON ACTION controlp INFIELD type

            #END add-point
      END CONSTRUCT
      
      #料件總表CONSTRUCT 
      CONSTRUCT g_wc_table31 ON imaa001
           FROM s_detail31[1].l_imaa001_1
                      
         BEFORE CONSTRUCT
            #add-point:cs段more_construct
             LET g_flag = 1
            #end add-point 
            
       #單身公用欄位開窗相關處理
       
         
       #單身一般欄位開窗相關處理
         #----<<sel>>----
         #----<<imaa001>>----
         #應用 a01 樣板自動產生(Version:1)
         BEFORE FIELD imaa001
            #add-point:BEFORE FIELD imaa001

            #END add-point
 
         #應用 a02 樣板自動產生(Version:1)
         AFTER FIELD imaa001
            
            #add-point:AFTER FIELD imaa001

            #END add-point
            
 
         #Ctrlp:construct.c.page1.imaa001
         #應用 a03 樣板自動產生(Version:2)
         ON ACTION controlp INFIELD imaa001
            #add-point:ON ACTION controlp INFIELD imaa001

            #END add-point

      END CONSTRUCT
 
      #料件製程CONSTRUCT 
      CONSTRUCT g_wc_table32 ON bmba001_1,bmba003_1
           FROM s_detail32[1].l_bmba001_1,s_detail32[1].l_bmba003_1
                      
         BEFORE CONSTRUCT
            #add-point:cs段more_construct
             LET g_flag = 1
            #end add-point 
            
       #單身公用欄位開窗相關處理
       
         
       #單身一般欄位開窗相關處理
         #----<<sel>>----
         #----<<bmba001>>----
         #----<<bmba003>>----
         #應用 a01 樣板自動產生(Version:1)
         BEFORE FIELD bmba001
            #add-point:BEFORE FIELD bmba001

            #END add-point
 
         #應用 a02 樣板自動產生(Version:1)
         AFTER FIELD bmba001
            
            #add-point:AFTER FIELD bmba001

            #END add-point
            
 
         #Ctrlp:construct.c.page1.bmba001
         #應用 a03 樣板自動產生(Version:2)
         ON ACTION controlp INFIELD bmba001
            #add-point:ON ACTION controlp INFIELD bmba001

            #END add-point
 
         #----<<bmba003>>----
         #應用 a01 樣板自動產生(Version:1)
         BEFORE FIELD bmba003
            #add-point:BEFORE FIELD bmba003

            #END add-point
 
         #應用 a02 樣板自動產生(Version:1)
         AFTER FIELD bmba003
            
            #add-point:AFTER FIELD bmba003

            #END add-point
            
 
         #Ctrlp:construct.c.page1.bmba003
         #應用 a03 樣板自動產生(Version:2)
         ON ACTION controlp INFIELD bmba003
            #add-point:ON ACTION controlp INFIELD bmba003

            #END add-point
      END CONSTRUCT 
 
      #料件途程CONSTRUCT 
      CONSTRUCT g_wc_table33 ON part_id
           FROM s_detail33[1].l_part_id
         BEFORE CONSTRUCT
            #add-point:cs段more_construct
             LET g_flag = 1
            #end add-point 
            
       #單身公用欄位開窗相關處理
       
         
       #單身一般欄位開窗相關處理
         #----<<sel>>----
         #----<<part_id>>----
         #應用 a01 樣板自動產生(Version:1)
         BEFORE FIELD part_id
            #add-point:BEFORE FIELD part_id

            #END add-point
 
         #應用 a02 樣板自動產生(Version:1)
         AFTER FIELD part_id
            
            #add-point:AFTER FIELD part_id

            #END add-point
            
 
         #Ctrlp:construct.c.page1.part_id
         #應用 a03 樣板自動產生(Version:2)
         ON ACTION controlp INFIELD part_id
            #add-point:ON ACTION controlp INFIELD part_id

            #END add-point

      END CONSTRUCT 
 
      #途程CONSTRUCT 
      CONSTRUCT g_wc_table34 ON ecbb001,ecbb002
           FROM s_detail34[1].l_ecbb001,s_detail34[1].l_ecbb002
                      
         BEFORE CONSTRUCT
            #add-point:cs段more_construct
             LET g_flag = 1
            #end add-point 
            
       #單身公用欄位開窗相關處理
       
         
       #單身一般欄位開窗相關處理
         #----<<sel>>----
         #----<<ecbb001>>----
         #----<<ecbb002>>----
         #應用 a01 樣板自動產生(Version:1)
         BEFORE FIELD ecbb001
            #add-point:BEFORE FIELD ecbb001

            #END add-point
 
         #應用 a02 樣板自動產生(Version:1)
         AFTER FIELD ecbb001
            
            #add-point:AFTER FIELD ecbb001

            #END add-point
            
 
         #Ctrlp:construct.c.page1.ecbb001
         #應用 a03 樣板自動產生(Version:2)
         ON ACTION controlp INFIELD ecbb001
            #add-point:ON ACTION controlp INFIELD ecbb001

            #END add-point
 
         #----<<ecbb002>>----
         #應用 a01 樣板自動產生(Version:1)
         BEFORE FIELD ecbb002
            #add-point:BEFORE FIELD ecbb002

            #END add-point
 
         #應用 a02 樣板自動產生(Version:1)
         AFTER FIELD ecbb002
            
            #add-point:AFTER FIELD ecbb002

            #END add-point
            
 
         #Ctrlp:construct.c.page1.ecbb002
         #應用 a03 樣板自動產生(Version:2)
         ON ACTION controlp INFIELD ecbb002
            #add-point:ON ACTION controlp INFIELD ecbb002

            #END add-point
      END CONSTRUCT 
 
      #工作站CONSTRUCT 
      CONSTRUCT g_wc_table35 ON l_ecaa001_1
           FROM s_detail35[1].l_ecaa001_1
         BEFORE CONSTRUCT
            #add-point:cs段more_construct
             LET g_flag = 1
            #end add-point 
            
       #單身公用欄位開窗相關處理
       
         
       #單身一般欄位開窗相關處理
         #----<<sel>>----
         #----<<l_ecaa001>>----
         #應用 a01 樣板自動產生(Version:1)
         BEFORE FIELD l_ecaa001
            #add-point:BEFORE FIELD l_ecaa001

            #END add-point
 
         #應用 a02 樣板自動產生(Version:1)
         AFTER FIELD l_ecaa001
            
            #add-point:AFTER FIELD l_ecaa001

            #END add-point
            
 
         #Ctrlp:construct.c.page1.l_ecaa001
         #應用 a03 樣板自動產生(Version:2)
         ON ACTION controlp INFIELD l_ecaa001
            #add-point:ON ACTION controlp INFIELD l_ecaa001

            #END add-point

      END CONSTRUCT 

      #網狀途程製程CONSTRUCT 
      CONSTRUCT g_wc_table36 ON ecbe001
           FROM s_detail36[1].l_ecbe001
         BEFORE CONSTRUCT
            #add-point:cs段more_construct
             LET g_flag = 1
            #end add-point 
            
       #單身公用欄位開窗相關處理
       
         
       #單身一般欄位開窗相關處理
         #----<<sel>>----
         #----<<ecbe001>>----
         #應用 a01 樣板自動產生(Version:1)
         BEFORE FIELD ecbe001
            #add-point:BEFORE FIELD ecbe001

            #END add-point
 
         #應用 a02 樣板自動產生(Version:1)
         AFTER FIELD ecbe001
            
            #add-point:AFTER FIELD ecbe001

            #END add-point
            
 
         #Ctrlp:construct.c.page1.ecbe001
         #應用 a03 樣板自動產生(Version:2)
         ON ACTION controlp INFIELD ecbe001
            #add-point:ON ACTION controlp INFIELD ecbe001

            #END add-point

      END CONSTRUCT
 
 
 
 
      ON ACTION accept
         #add-point:ON ACTION accept

         #end add-point
 
         ACCEPT DIALOG
         
      ON ACTION cancel
         LET INT_FLAG = 1
         EXIT DIALOG
      
      #交談指令共用ACTION
      &include "common_action.4gl"
         CONTINUE DIALOG 
 
      #add-point:query段查詢方案相關ACTION設定前

      #end add-point 
 
      ON ACTION qbeclear   # 條件清除
         CLEAR FORM
         #add-point:條件清除後

         #end add-point 
 
      #add-point:query段查詢方案相關ACTION設定後

      #end add-point 
 
   END DIALOG
 
   
 
   LET g_wc = g_wc
   LET g_wc1 = g_wc_table1
   LET g_wc2 = g_wc_table2
   LET g_wc3 = g_wc_table3
   LET g_wc4 = g_wc_table4
   LET g_wc5 = g_wc_table5
   LET g_wc6 = g_wc_table6
   LET g_wc7 = g_wc_table7
   LET g_wc8 = g_wc_table8
   LET g_wc9 = g_wc_table9
   LET g_wc10 = g_wc_table10
   LET g_wc11 = g_wc_table11
   LET g_wc12 = g_wc_table12
   LET g_wc13 = g_wc_table13
   LET g_wc14 = g_wc_table14
   LET g_wc15 = g_wc_table15
   LET g_wc16 = g_wc_table16
   LET g_wc17 = g_wc_table17
   LET g_wc18 = g_wc_table18
   LET g_wc19 = g_wc_table19
   LET g_wc20 = g_wc_table20
   LET g_wc21 = g_wc_table21
   LET g_wc22 = g_wc_table22
   LET g_wc23 = g_wc_table23
   LET g_wc24 = g_wc_table24
   LET g_wc25 = g_wc_table25
   LET g_wc26 = g_wc_table26
   LET g_wc27 = g_wc_table27
   LET g_wc28 = g_wc_table28
   LET g_wc29 = g_wc_table29
   LET g_wc30 = g_wc_table30
   LET g_wc31 = g_wc_table31
   LET g_wc32 = g_wc_table32
   LET g_wc33 = g_wc_table33
   LET g_wc34 = g_wc_table34
   LET g_wc35 = g_wc_table35
   LET g_wc36 = g_wc_table36
 
 
   IF INT_FLAG THEN
      LET INT_FLAG = 0
      #還原
      LET g_wc   = " 1=2"
      LET g_wc1  = " 1=2"
      LET g_wc2  = " 1=2"
      LET g_wc3  = " 1=2"
      LET g_wc4  = " 1=2"
      LET g_wc5  = " 1=2"
      LET g_wc6  = " 1=2"
      LET g_wc7  = " 1=2"
      LET g_wc8  = " 1=2"
      LET g_wc9  = " 1=2"
      LET g_wc10 = " 1=2"
      LET g_wc11 = " 1=2"
      LET g_wc12 = " 1=2"
      LET g_wc13 = " 1=2"
      LET g_wc14 = " 1=2"
      LET g_wc15 = " 1=2"
      LET g_wc16 = " 1=2"
      LET g_wc17 = " 1=2"
      LET g_wc18 = " 1=2"
      LET g_wc19 = " 1=2"
      LET g_wc20 = " 1=2"
      LET g_wc21 = " 1=2"
      LET g_wc22 = " 1=2"
      LET g_wc23 = " 1=2"
      LET g_wc24 = " 1=2"
      LET g_wc25 = " 1=2"
      LET g_wc26 = " 1=2"
      LET g_wc27 = " 1=2"
      LET g_wc28 = " 1=2"
      LET g_wc29 = " 1=2"
      LET g_wc30 = " 1=2"
      LET g_wc31 = " 1=2"
      LET g_wc32 = " 1=2"
      LET g_wc33 = " 1=2"
      LET g_wc34 = " 1=2"
      LET g_wc35 = " 1=2"
      LET g_wc36 = " 1=2"
      LET g_wc_filter = g_wc_filter_t
      RETURN
   ELSE
      LET g_master_idx = 1
   END IF
 
   CALL apsq102_b_fill()
   
   CALL gfrm_curr.setFieldHidden("formonly.sel", FALSE)
   CALL gfrm_curr.setFieldHidden("formonly.statepic", FALSE)
END FUNCTION

################################################################################
# Descriptions...: 描述说明
# Memo...........:
# Usage..........: CALL apsp102_create_temptable()
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 16/07/04 By Charles4m
# Modify.........:
################################################################################
PRIVATE FUNCTION apsp102_create_temptable()
DEFINE r_success         LIKE type_t.num5

   LET r_success = TRUE
   
#--------------物料需求(MP)--------------
  #需求訂單
   DROP TABLE dem_ord_tmp01            #160727-00019#15 Mod   demand_order_tmp -->dem_ord_tmp01
   CREATE TEMP TABLE dem_ord_tmp01(    #160727-00019#15 Mod   demand_order_tmp -->dem_ord_tmp01
      psca001        LIKE type_t.chr100,
      xmdadocno      LIKE type_t.chr100,
      xmdd001        LIKE type_t.chr100,
      xmdd006        LIKE type_t.chr100,
      xmdd011        LIKE type_t.chr100,
      xmda004        LIKE type_t.chr100,
      type           LIKE type_t.chr100,
      xmdd014        LIKE type_t.chr100,
      xmdd004        LIKE type_t.chr100,
      delay          LIKE type_t.chr100,
      xmdd002        LIKE type_t.chr100,
      scheduled      LIKE type_t.chr100,
      consume        LIKE type_t.chr100,
      priority       LIKE type_t.chr100,
      transfer       LIKE type_t.chr100,
      pseb007        LIKE type_t.chr100)
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = 'create dem_ord_tmp01'          #160727-00019#15 Mod   demand_order_tmp -->dem_ord_tmp01
      LET g_errparam.popup = TRUE
      CALL cl_err()

      LET r_success = FALSE
   END IF
  
  #請採購單
   DROP TABLE s_p_o_tmp
   CREATE TEMP TABLE s_p_o_tmp(
      psca001        LIKE type_t.chr100,
      pmdodocno      LIKE type_t.chr100,
      pmdo001        LIKE type_t.chr100,
      pmdo006        LIKE type_t.chr100,
      new            LIKE type_t.chr100,
      pmdl004        LIKE type_t.chr100,
      pmdo004        LIKE type_t.chr100,
      pmdo019        LIKE type_t.chr100,
      state          LIKE type_t.chr100,
      pmdo014        LIKE type_t.chr100,
      pmdo002        LIKE type_t.chr100,
      pmdo016        LIKE type_t.chr100,
      pmdo015        LIKE type_t.chr100,
      pmdldocdt      LIKE type_t.chr100,
      pmdo012        LIKE type_t.chr100,
      pmdo013        LIKE type_t.chr100,
      pmdo017        LIKE type_t.chr100,
      pmdo015_1      LIKE type_t.chr100,
      transfer_1     LIKE type_t.chr100,
      hardpegging    LIKE type_t.chr100)
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = 'create s_p_o_tmp'
      LET g_errparam.popup = TRUE
      CALL cl_err()
   
      LET r_success = FALSE
   END IF
   
  #工單
   DROP TABLE s_m_o_tmp
   CREATE TEMP TABLE s_m_o_tmp(
      psca001        LIKE type_t.chr100,
      sfaadocno      LIKE type_t.chr100,
      sfaa012        LIKE type_t.chr100,
      sfaa020        LIKE type_t.chr100,
      sfaa019        LIKE type_t.chr100,
      sfaa010        LIKE type_t.chr100,
      sfaadocno1     LIKE type_t.chr100,
      sfaa011        LIKE type_t.chr100,
      sfaa056        LIKE type_t.chr100,
      new_1          LIKE type_t.chr100,
      produced       LIKE type_t.chr100,
      sfaa016        LIKE type_t.chr100,
      sfaa015        LIKE type_t.chr100,
      sfaa022        LIKE type_t.chr100,
      sfaa021        LIKE type_t.chr100,
      feature        LIKE type_t.chr100,
      firm           LIKE type_t.chr100,
      exploration    LIKE type_t.chr100,
      materiral      LIKE type_t.chr100,
      hardpegging_1  LIKE type_t.chr100)
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = 'create s_m_o_tmp'
      LET g_errparam.popup = TRUE
      CALL cl_err()
   
      LET r_success = FALSE
   END IF
   
  #工單領料狀況
   DROP TABLE m_r_tmp
   CREATE TEMP TABLE m_r_tmp(
      psca001        LIKE type_t.chr100,
      sfbadocno      LIKE type_t.chr100,
      sfba006        LIKE type_t.chr100,
      sfbaseq        LIKE type_t.chr100,
      sfbaseq_1      LIKE type_t.chr100,
      release        LIKE type_t.chr100,
      sfba019        LIKE type_t.chr100,
      demand         LIKE type_t.chr100,
      sfba020        LIKE type_t.chr100,
      sfba028        LIKE type_t.chr100,
      sfba003        LIKE type_t.chr100,
      sfba009        LIKE type_t.chr100,
      sfba007        LIKE type_t.chr100,
      sfaa003        LIKE type_t.chr100,
      sfba021        LIKE type_t.chr100,
      sfba001        LIKE type_t.chr100,
      sfba005        LIKE type_t.chr100)
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = 'create m_r_tmp'
      LET g_errparam.popup = TRUE
      CALL cl_err()

      LET r_success = FALSE
   END IF
   
  #料件總表
   DROP TABLE item_master_tmp
   CREATE TEMP TABLE item_master_tmp(
      psca001        LIKE type_t.chr100,
      imaa001        LIKE type_t.chr100, 
      imaf026        LIKE type_t.chr100, 
      sizing         LIKE type_t.chr100,
      used           LIKE type_t.chr100,   
      integer_1      LIKE type_t.chr100,
      imaf013        LIKE type_t.chr100, 
      imaa006        LIKE type_t.chr100, 
      imae022        LIKE type_t.chr100, 
      imae018        LIKE type_t.chr100, 
      imae017        LIKE type_t.chr100, 
      imae080        LIKE type_t.chr100, 
      imaa004        LIKE type_t.chr100, 
      imae064        LIKE type_t.chr100, 
      mfg            LIKE type_t.chr100,    
      order_1        LIKE type_t.chr100,   
      feature_1      LIKE type_t.chr100,
      imaf171        LIKE type_t.chr100,
      imaf171_1      LIKE type_t.chr100,
      consume_1      LIKE type_t.chr100,
      release_1      LIKE type_t.chr100,
      lastqty        LIKE type_t.chr100,
      combine        LIKE type_t.chr100,
      inspect        LIKE type_t.chr100,
      consign        LIKE type_t.chr100,
      imaf143        LIKE type_t.chr100,  
      purchase       LIKE type_t.chr100, 
      imae016        LIKE type_t.chr100,  
      mfg_1          LIKE type_t.chr100, 
      imaa105        LIKE type_t.chr100, 
      sales          LIKE type_t.chr100,
      imae064_1      LIKE type_t.chr100, 
      alt            LIKE type_t.chr100,    
      break          LIKE type_t.chr100, 
      create_1       LIKE type_t.chr100,  
      supratio       LIKE type_t.chr100,
      imaf153        LIKE type_t.chr100, 
      backward       LIKE type_t.chr100,
      batch          LIKE type_t.chr100, 
      setup          LIKE type_t.chr100,
      imae052        LIKE type_t.chr100,
      imae077        LIKE type_t.chr100,
      base           LIKE type_t.chr100,
      max_batch_size LIKE type_t.chr100,
      imae032        LIKE type_t.chr100,  
      outsourcing    LIKE type_t.chr100,
      imae072        LIKE type_t.chr100,  
      imae073        LIKE type_t.chr100,  
      var            LIKE type_t.chr100,  
      auto_1         LIKE type_t.chr100,
      consolidate    LIKE type_t.chr100,  
      phase          LIKE type_t.chr100,
      spare          LIKE type_t.chr100,
      due            LIKE type_t.chr100,
      imae015        LIKE type_t.chr100,  
      imaa005        LIKE type_t.chr100,  
      imae078        LIKE type_t.chr100,  
      imae079        LIKE type_t.chr100,  
      imae083        LIKE type_t.chr100,  
      imae082        LIKE type_t.chr100)
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = 'create item_master_tmp'
      LET g_errparam.popup = TRUE
      CALL cl_err()
   
      LET r_success = FALSE
   END IF
   
  #料件特徵
   DROP TABLE feature_group_tmp
   CREATE TEMP TABLE feature_group_tmp(
      psca001  LIKE type_t.chr100,
      imeb001  LIKE type_t.chr100,
      imeb002  LIKE type_t.chr100,
      imeb004  LIKE type_t.chr100,
      imeb006  LIKE type_t.chr100,
      imeb005  LIKE type_t.chr100,
      imeb010  LIKE type_t.chr100,
      imeb011  LIKE type_t.chr100,
      imeb008  LIKE type_t.chr100,
      imeb009  LIKE type_t.chr100)
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = 'create feature_group_tmp'
      LET g_errparam.popup = TRUE
      CALL cl_err()

      LET r_success = FALSE
   END IF
  
  #BOM表
   DROP TABLE b_o_m_tmp
   CREATE TEMP TABLE b_o_m_tmp(
      psca001      LIKE type_t.chr100,
      bmba001      LIKE type_t.chr100,
      bmba012      LIKE type_t.chr100,
      bmba003      LIKE type_t.chr100,
      bmba009      LIKE type_t.chr100,
      bmba011      LIKE type_t.chr100,
      shrinkage    LIKE type_t.chr100,
      bmba013      LIKE type_t.chr100,
      bmba031      LIKE type_t.chr100,
      alt_1        LIKE type_t.chr100,
      create_1     LIKE type_t.chr100,
      ratio        LIKE type_t.chr100,
      bmba007      LIKE type_t.chr100,
      bmba021      LIKE type_t.chr100,
      used_1       LIKE type_t.chr100,
      substitute   LIKE type_t.chr100,
      fixed        LIKE type_t.chr100,
      bmba023      LIKE type_t.chr100,
      bmba004      LIKE type_t.chr100,
      bmba008      LIKE type_t.chr100,
      quantity     LIKE type_t.chr100)
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = 'create b_o_m_tmp'
      LET g_errparam.popup = TRUE
      CALL cl_err()

      LET r_success = FALSE
   END IF
   
  #庫存
   DROP TABLE u_i_tmp
   CREATE TEMP TABLE u_i_tmp(
      psca001     LIKE type_t.chr100,
      inag001     LIKE type_t.chr100,
      inag004     LIKE type_t.chr100,
      inag005     LIKE type_t.chr100,
      inag009     LIKE type_t.chr100,
      inag002     LIKE type_t.chr100,
      hard        LIKE type_t.chr100)
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = 'create u_i_tmp'
      LET g_errparam.popup = TRUE
      CALL cl_err()

      LET r_success = FALSE
   END IF
  
  #倉庫
   DROP TABLE warehouse_tmp
   CREATE TEMP TABLE warehouse_tmp(
      psca001     LIKE type_t.chr100,
      inaa001     LIKE type_t.chr100,
      inaa006     LIKE type_t.chr100)
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = 'create warehouse_tmp'
      LET g_errparam.popup = TRUE
      CALL cl_err()

      LET r_success = FALSE
   END IF
  
  #儲位  
   DROP TABLE sto_lct_tmp01           #160727-00019#15 Mod   stock_location_tmp -->sto_lct_tmp01
   CREATE TEMP TABLE sto_lct_tmp01(   #160727-00019#15 Mod   stock_location_tmp -->sto_lct_tmp01
      psca001        LIKE type_t.chr100,
      inab001        LIKE type_t.chr100,
      inab002        LIKE type_t.chr100,
      inab005        LIKE type_t.chr100,
      consigned      LIKE type_t.chr100)
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = 'create sto_lct_tmp01'       #160727-00019#15 Mod   stock_location_tmp -->sto_lct_tmp01
      LET g_errparam.popup = TRUE
      CALL cl_err()

      LET r_success = FALSE
   END IF

  #特徵限定用料
   DROP TABLE b_f_t1_tmp
   CREATE TEMP TABLE b_f_t1_tmp(
      psca001     LIKE type_t.chr100,
      bmca001     LIKE type_t.chr100,
      bmca009     LIKE type_t.chr100,
      bmca005     LIKE type_t.chr100,
      bmca003     LIKE type_t.chr100,
      bmcb011     LIKE type_t.chr100,
      bmcb012     LIKE type_t.chr100)
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = 'create b_f_t1_tmp'
      LET g_errparam.popup = TRUE
      CALL cl_err()

      LET r_success = FALSE
   END IF
   
  #特徵對應
   DROP TABLE b_f_t2_tmp
   CREATE TEMP TABLE b_f_t2_tmp(
      psca001      LIKE type_t.chr100,
      bmc001       LIKE type_t.chr100,
      bmcc009      LIKE type_t.chr100,
      bmcd010      LIKE type_t.chr100,
      bmcc005      LIKE type_t.chr100,
      bmcc003      LIKE type_t.chr100,
      bmcd011      LIKE type_t.chr100,
      bmcc010      LIKE type_t.chr100)
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = 'create b_f_t2_tmp'
      LET g_errparam.popup = TRUE
      CALL cl_err()

      LET r_success = FALSE
   END IF
   
  #料件特徵群組
   DROP TABLE f_g_l_tmp
   CREATE TEMP TABLE f_g_l_tmp(
      psca001      LIKE type_t.chr100,
      imec001      LIKE type_t.chr100,
      imec002      LIKE type_t.chr100,
      imec003      LIKE type_t.chr100)
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = 'create f_g_l_tmp'
      LET g_errparam.popup = TRUE
      CALL cl_err()

      LET r_success = FALSE
   END IF
   
  #元件限定特徵
   DROP TABLE b_f_t3_tmp
   CREATE TEMP TABLE b_f_t3_tmp(
      psca001      LIKE type_t.chr100,
      bmce001      LIKE type_t.chr100,
      bmce005      LIKE type_t.chr100,
      bmce003      LIKE type_t.chr100,
      bmce009      LIKE type_t.chr100,
      bmce010      LIKE type_t.chr100)
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = 'create b_f_t3_tmp'
      LET g_errparam.popup = TRUE
      CALL cl_err()

      LET r_success = FALSE
   END IF
   
  #聯產品資料
   DROP TABLE i_j_p_tmp
   CREATE TEMP TABLE i_j_p_tmp(
      psca001     LIKE type_t.chr100,
      bmab001     LIKE type_t.chr100,
      bmab003     LIKE type_t.chr100,
      type_1      LIKE type_t.chr100,
      bmab004     LIKE type_t.chr100)
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = 'create i_j_p_tmp'
      LET g_errparam.popup = TRUE
      CALL cl_err()

      LET r_success = FALSE
   END IF
   
  #BOM取替代
   DROP TABLE alt_part_tmp
   CREATE TEMP TABLE alt_part_tmp(
      psca001     LIKE type_t.chr100,
      bmea001     LIKE type_t.chr100,
      bmea003     LIKE type_t.chr100,
      bmea008     LIKE type_t.chr100,
      bmea015     LIKE type_t.chr100,
      bmea011     LIKE type_t.chr100,
      bmea009     LIKE type_t.chr100,
      bmea010     LIKE type_t.chr100,
      bmea012     LIKE type_t.chr100,
      bmea007     LIKE type_t.chr100,
      bmea017     LIKE type_t.chr100,
      bmea016     LIKE type_t.chr100) 
      IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = 'create alt_part_tmp'
      LET g_errparam.popup = TRUE
      CALL cl_err()

      LET r_success = FALSE
   END IF
   
  #品號取替代
   DROP TABLE a_p_g_tmp
   CREATE TEMP TABLE a_p_g_tmp(
      psca001        LIKE type_t.chr100,
      bmea001_1      LIKE type_t.chr100,
      bmea008_1      LIKE type_t.chr100,
      bmea015_1      LIKE type_t.chr100,
      bmea011_1      LIKE type_t.chr100,
      bmea009_1      LIKE type_t.chr100,
      bmea010_1      LIKE type_t.chr100,
      bmea012_1      LIKE type_t.chr100,
      bmea007_1      LIKE type_t.chr100,
      bmea017_1      LIKE type_t.chr100,
      bmea016_1      LIKE type_t.chr100)
      IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = 'create a_p_g_tmp'
      LET g_errparam.popup = TRUE
      CALL cl_err()

      LET r_success = FALSE
   END IF
   
  #工作站
   DROP TABLE ws_tmp
   CREATE TEMP TABLE ws_tmp(
  #psca001      LIKE psca_t.psca001,
  #ecaa001      LIKE ecaa_t.ecaa001)
   psca001      LIKE type_t.chr100,
   ecaa001      LIKE type_t.chr100)
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = 'create ws_tmp'
      LET g_errparam.popup = TRUE
      CALL cl_err()

      LET r_success = FALSE
   END IF
   
  #損耗區間
   DROP TABLE s_r_tmp
   CREATE TEMP TABLE s_r_tmp(
      psca001        LIKE type_t.chr100,
      bmbb001        LIKE type_t.chr100,
      bmbb003        LIKE type_t.chr100,
      seq            LIKE type_t.chr100,
      seq1           LIKE type_t.chr100,
      bmbb009        LIKE type_t.chr100,
      bmbb010        LIKE type_t.chr100,
      shrinkage_1    LIKE type_t.chr100,
      bmbb011        LIKE type_t.chr100,
      bmbb012        LIKE type_t.chr100)
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = 'create s_r_tmp'
      LET g_errparam.popup = TRUE
      CALL cl_err()

      LET r_success = FALSE
   END IF
   
  #MPS工單中介檔
   DROP TABLE o_s_m_o_tmp
   CREATE TEMP TABLE o_s_m_o_tmp(
      psca001     LIKE type_t.chr100,
      psoa003     LIKE type_t.chr100,
      psoa004     LIKE type_t.chr100,
      psoa005     LIKE type_t.chr100,
      psoa006     LIKE type_t.chr100,
      psoa007     LIKE type_t.chr100,
      psoa008     LIKE type_t.chr100,
      psoa009     LIKE type_t.chr100,
      psoa010     LIKE type_t.chr100,
      psoa011     LIKE type_t.chr100,
      psoa012     LIKE type_t.chr100,
      psoa013     LIKE type_t.chr100,
      psoa014     LIKE type_t.chr100,
      psoa015     LIKE type_t.chr100,
      psoa016     LIKE type_t.chr100,
      psoa017     LIKE type_t.chr100,
      psoa018     LIKE type_t.chr100,
      psoa019     LIKE type_t.chr100,
      psoa020     LIKE type_t.chr100,
      psoa021     LIKE type_t.chr100,
      psoa022     LIKE type_t.chr100,
      psoa023     LIKE type_t.chr100)
      
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = 'create o_s_m_o_tmp'
      LET g_errparam.popup = TRUE
      CALL cl_err()

      LET r_success = FALSE
   END IF
#--------------產能規劃(CP)--------------
  #需求訂單
   DROP TABLE o_d_o_tmp
   CREATE TEMP TABLE o_d_o_tmp(
      psca001      LIKE type_t.chr100,
      psod003      LIKE type_t.chr100,
      psod004      LIKE type_t.chr100,
      psod005      LIKE type_t.chr100,
      psod006      LIKE type_t.chr100,
      psod007      LIKE type_t.chr100,
      psod008      LIKE type_t.chr100,
      psod009      LIKE type_t.chr100,
      psod010      LIKE type_t.chr100,
      psod011      LIKE type_t.chr100,
      psod012      LIKE type_t.chr100,
      psod013      LIKE type_t.chr100,
      psod014      LIKE type_t.chr100,
      psod015      LIKE type_t.chr100,
      psod016      LIKE type_t.chr100,
      psod017      LIKE type_t.chr100)
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = 'create o_d_o_tmp'
      LET g_errparam.popup = TRUE
      CALL cl_err()

      LET r_success = FALSE
   END IF
   
  #採購單
   DROP TABLE o_s_p_o_tmp
   CREATE TEMP TABLE o_s_p_o_tmp(
      psca001        LIKE type_t.chr100,
      psoc003        LIKE type_t.chr100,
      psoc004        LIKE type_t.chr100,
      psoc005        LIKE type_t.chr100,
      psoc006        LIKE type_t.chr100,
      psoc007        LIKE type_t.chr100,
      psoc008_1      LIKE type_t.chr100,
      psoc009        LIKE type_t.chr100,
      psoc010        LIKE type_t.chr100,
      psoc011        LIKE type_t.chr100,
      psoc012        LIKE type_t.chr100,
      psoc013        LIKE type_t.chr100,
      psoc014        LIKE type_t.chr100,
      psoc015        LIKE type_t.chr100,
      psoc016        LIKE type_t.chr100,
      psoc017        LIKE type_t.chr100,
      psoc018        LIKE type_t.chr100,
      psoc019        LIKE type_t.chr100,
      psoc020        LIKE type_t.chr100,
      psoc021        LIKE type_t.chr100,
      psoc022        LIKE type_t.chr100,
      psoc023        LIKE type_t.chr100,
      psoc025        LIKE type_t.chr100,
      psoc022_1      LIKE type_t.chr100,
      psoc022_2      LIKE type_t.chr100,
      psoc022_3      LIKE type_t.chr100)
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = 'create o_s_p_o_tmp'
      LET g_errparam.popup = TRUE
      CALL cl_err()

      LET r_success = FALSE
   END IF
   
  #工單
   DROP TABLE o_s_m_o_tmp
   CREATE TEMP TABLE o_s_m_o_tmp(
      psca001       LIKE type_t.chr100,
      psoa003_1     LIKE type_t.chr100,
      psoa004_1     LIKE type_t.chr100,
      psoa005_1     LIKE type_t.chr100,
      psoa006_1     LIKE type_t.chr100,
      psoa007_1     LIKE type_t.chr100,
      psoa008_1     LIKE type_t.chr100,
      psoa009_1     LIKE type_t.chr100,
      psoa010_1     LIKE type_t.chr100,
      psoa011_1     LIKE type_t.chr100,
      psoa012_1     LIKE type_t.chr100,
      psoa013_1     LIKE type_t.chr100,
      psoa014_1     LIKE type_t.chr100,
      psoa015_1     LIKE type_t.chr100,
      psoa016_1     LIKE type_t.chr100,
      psoa017_1     LIKE type_t.chr100,
      psoa018_1     LIKE type_t.chr100,
      psoa019_1     LIKE type_t.chr100,
      psoa020_1     LIKE type_t.chr100,
      psoa021_1     LIKE type_t.chr100,
      psoa023_1     LIKE type_t.chr100)
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = 'create o_s_m_o_tmp'
      LET g_errparam.popup = TRUE
      CALL cl_err()

      LET r_success = FALSE
   END IF
   
  #工單領料狀況
   DROP TABLE m_r1_tmp
   CREATE TEMP TABLE m_r1_tmp(
      psca001         LIKE type_t.chr100,
      sfbadocno_1     LIKE type_t.chr100,
      sfba006_1       LIKE type_t.chr100,
      sfbaseq_2       LIKE type_t.chr100,
      sfbaseq_1_1     LIKE type_t.chr100,
      release_2       LIKE type_t.chr100,
      sfba019_1       LIKE type_t.chr100,
      demand_1        LIKE type_t.chr100,
      sfba020_1       LIKE type_t.chr100,
      sfba028_1       LIKE type_t.chr100,
      sfba003_1       LIKE type_t.chr100,
      sfba009_1       LIKE type_t.chr100,
      sfba007_1       LIKE type_t.chr100,
      sfaa003_1       LIKE type_t.chr100,
      sfba021_1       LIKE type_t.chr100)
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = 'create m_r1_tmp'
      LET g_errparam.popup = TRUE
      CALL cl_err()

      LET r_success = FALSE
   END IF
   
  #MPS單據關聯中介檔
   DROP TABLE omp_mopeg_tmp
   CREATE TEMP TABLE omp_mopeg_tmp(
      psca001      LIKE type_t.chr100,
      psob003      LIKE type_t.chr100,
      psob004      LIKE type_t.chr100,
      psob005      LIKE type_t.chr100,
      psob006      LIKE type_t.chr100,
      psob007      LIKE type_t.chr100,
      psob008      LIKE type_t.chr100,
      psob009      LIKE type_t.chr100,
      psob010      LIKE type_t.chr100,
      psob011      LIKE type_t.chr100,
      psob012      LIKE type_t.chr100,
      psob013      LIKE type_t.chr100,
      psob016      LIKE type_t.chr100)
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = 'create omp_mopeg_tmp'
      LET g_errparam.popup = TRUE
      CALL cl_err()

      LET r_success = FALSE
   END IF
   
  #設備
   DROP TABLE omp_equipment_tmp
   CREATE TEMP TABLE omp_equipment_tmp(
      psca001              LIKE type_t.chr100,
      equip_type           LIKE type_t.chr100,
      equip_id             LIKE type_t.chr100,
      ws_id                LIKE type_t.chr100,
      efficency            LIKE type_t.chr100,
      capacity_type        LIKE type_t.chr100,
      day_calendar_id      LIKE type_t.chr100,
      week_calendar_id     LIKE type_t.chr100)
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = 'create omp_equipment_tmp'
      LET g_errparam.popup = TRUE
      CALL cl_err()

      LET r_success = FALSE
   END IF
   
   #設備群組
   DROP TABLE e_g_tmp
   CREATE TEMP TABLE e_g_tmp(
      psca001            LIKE type_t.chr100,
      equip_group_id     LIKE type_t.chr100,
      equip_type_1       LIKE type_t.chr100,
      is_outsourcing     LIKE type_t.chr100,
      equip_id_1         LIKE type_t.chr100,
      priority_1         LIKE type_t.chr100)
   IF SQLCA.sqlcode THEN      
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = 'create e_g_tmp'
      LET g_errparam.popup = TRUE
      CALL cl_err()

      LET r_success = FALSE
   END IF
   
   #日行事曆
   DROP TABLE omp_daycaln_tmp
   CREATE TEMP TABLE omp_daycaln_tmp(
      psca001        LIKE type_t.chr100,
      mrbh001_1      LIKE type_t.chr100,
      mrbh002        LIKE type_t.chr100,
      mrbh003        LIKE type_t.chr100,
      mrbh004        LIKE type_t.chr100,
      mrbh005        LIKE type_t.chr100)
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = 'create omp_daycaln_tmp'
      LET g_errparam.popup = TRUE
      CALL cl_err()

      LET r_success = FALSE
   END IF
   
  #週行事曆
   DROP TABLE omp_weekcaln_tmp
   CREATE TEMP TABLE omp_weekcaln_tmp(
      psca001               LIKE type_t.chr100,
      week_calendar_id_1    LIKE type_t.chr100,
      mom_wm_id             LIKE type_t.chr100,
      tue_wm_id             LIKE type_t.chr100,
      wed_wm_id             LIKE type_t.chr100,
      thu_wm_id             LIKE type_t.chr100,
      fri_wm_id             LIKE type_t.chr100,
      sat_wm_id             LIKE type_t.chr100,
      sun_wm_id             LIKE type_t.chr100)
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = 'create omp_weekcaln_tmp'
      LET g_errparam.popup = TRUE
      CALL cl_err()

      LET r_success = FALSE
   END IF
   
  #工作時段
   DROP TABLE omp_work_model_tmp
   CREATE TEMP TABLE omp_work_model_tmp(
      psca001      LIKE type_t.chr100,
      wm_id        LIKE type_t.chr100,
      start_time   LIKE type_t.chr100,
      end_time     LIKE type_t.chr100,
      type_2       LIKE type_t.chr100)
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = 'create omp_work_model_tmp'
      LET g_errparam.popup = TRUE
      CALL cl_err()

      LET r_success = FALSE
   END IF
   
  #料件總表
   DROP TABLE item_masters1_tmp
   CREATE TEMP TABLE item_masters1_tmp(
      psca001              LIKE type_t.chr100,
      imaa001_1            LIKE type_t.chr100,
      imaf026_1            LIKE type_t.chr100,
      sizing_1             LIKE type_t.chr100,
      used_2               LIKE type_t.chr100,
      integer_1            LIKE type_t.chr100,
      imaf013_1            LIKE type_t.chr100,
      imaa006_1            LIKE type_t.chr100,
      imae022_1            LIKE type_t.chr100,
      imae018_1            LIKE type_t.chr100,
      imae017_1            LIKE type_t.chr100,
      imae080_1            LIKE type_t.chr100,
      imaa004_1            LIKE type_t.chr100,
      imae064_2            LIKE type_t.chr100,
      mfg_2                LIKE type_t.chr100,
      order_1              LIKE type_t.chr100,
      feature_1_1          LIKE type_t.chr100,
      imaf171_2            LIKE type_t.chr100,
      imaf171_3            LIKE type_t.chr100,
      consume_1_1          LIKE type_t.chr100,
      release_1_1          LIKE type_t.chr100,
      lastqty_1            LIKE type_t.chr100,
      combine_1            LIKE type_t.chr100,
      inspect_1            LIKE type_t.chr100,
      consign_1            LIKE type_t.chr100,
      imaf143_1            LIKE type_t.chr100,
      purchase_1           LIKE type_t.chr100,
      imae016_1            LIKE type_t.chr100,
      mfg_1_1              LIKE type_t.chr100,
      imaa105_1            LIKE type_t.chr100,
      sales_1              LIKE type_t.chr100,
      imae064_1_1          LIKE type_t.chr100,
      alt_2                LIKE type_t.chr100,
      break_1              LIKE type_t.chr100,
      create_2             LIKE type_t.chr100,
      supratio_1           LIKE type_t.chr100,
      imaf153_1            LIKE type_t.chr100,
      backward_1           LIKE type_t.chr100,
      batch_1              LIKE type_t.chr100,
      setup_1              LIKE type_t.chr100,
      imae052_1            LIKE type_t.chr100,
      imae077_1            LIKE type_t.chr100,
      base_1               LIKE type_t.chr100,
      max_batch_size_1     LIKE type_t.chr100,
      imae032_1            LIKE type_t.chr100,
      outsourcing_1        LIKE type_t.chr100,
      imae072_1            LIKE type_t.chr100,
      imae073_1            LIKE type_t.chr100,
      var_1                LIKE type_t.chr100,
      auto_1               LIKE type_t.chr100,
      consolidate_1        LIKE type_t.chr100,
      phase_1              LIKE type_t.chr100,
      spare_1              LIKE type_t.chr100,
      due_1                LIKE type_t.chr100,
      imae015_1            LIKE type_t.chr100,
      imaa005_1            LIKE type_t.chr100,
      imae078_1            LIKE type_t.chr100,
      imae079_1            LIKE type_t.chr100,
      imae083_1            LIKE type_t.chr100,
      imae082_1            LIKE type_t.chr100)
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = 'create item_masters1_tmp'
      LET g_errparam.popup = TRUE
      CALL cl_err()

      LET r_success = FALSE
   END IF
      
  #料件製程
   DROP TABLE b_t_p_tmp
   CREATE TEMP TABLE b_t_p_tmp(
      psca001      LIKE type_t.chr100,
      bmba001_1    LIKE type_t.chr100,
      bmba003_1    LIKE type_t.chr100,
      ecba001      LIKE type_t.chr100,
      ecbb003      LIKE type_t.chr100,
      bmba007_1    LIKE type_t.chr100)
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = 'create b_t_p_tmp'
      LET g_errparam.popup = TRUE
      CALL cl_err()

      LET r_success = FALSE
   END IF
   
  #料件途程
   DROP TABLE item_route_tmp
   CREATE TEMP TABLE item_route_tmp(
      psca001       LIKE type_t.chr100,
      part_id       LIKE type_t.chr100,
      imae033       LIKE type_t.chr100,
      sequ_num      LIKE type_t.chr100,
      is_alt        LIKE type_t.chr100)
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = 'create item_route_tmp'
      LET g_errparam.popup = TRUE
      CALL cl_err()

      LET r_success = FALSE
   END IF
   
  #途程
   DROP TABLE route_tmp
   CREATE TEMP TABLE route_tmp(
      psca001        LIKE type_t.chr100,
      ecbb001        LIKE type_t.chr100,
      ecbb002        LIKE type_t.chr100,
      ecbb003_1      LIKE type_t.chr100,
      ecbb004        LIKE type_t.chr100,
      equip_type_2   LIKE type_t.chr100,
      ecbb037        LIKE type_t.chr100,
      is_batch       LIKE type_t.chr100,
      ecbb026        LIKE type_t.chr100,
      ecbb027        LIKE type_t.chr100,
      imae077_2      LIKE type_t.chr100,
      imae077_3      LIKE type_t.chr100,
      ecbb012        LIKE type_t.chr100)
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = 'create route_tmp'
      LET g_errparam.popup = TRUE
      CALL cl_err()

      LET r_success = FALSE
   END IF
   
  #工作站
   DROP TABLE ws1_tmp
   CREATE TEMP TABLE ws1_tmp(
      psca001       LIKE type_t.chr100,
      ecaa001       LIKE type_t.chr100)
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = 'create ws1_tmp'
      LET g_errparam.popup = TRUE
      CALL cl_err()

      LET r_success = FALSE
   END IF
   
  #網狀途程製程
   DROP TABLE route_relation_tmp
   CREATE TEMP TABLE route_relation_tmp(
      psca001        LIKE type_t.chr100,
      ecbe001        LIKE type_t.chr100,
      ecbe005        LIKE type_t.chr100,
      ecbe003        LIKE type_t.chr100)
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = 'create route_relation_tmp'
      LET g_errparam.popup = TRUE
      CALL cl_err()

      LET r_success = FALSE
   END IF
   
   
   
   
   RETURN r_success
  

END FUNCTION

 
{</section>}
 
