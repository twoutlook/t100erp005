#該程式未解開Section, 採用最新樣板產出!
{<section id="aapt510.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0016(2016-09-07 17:51:02), PR版次:0016(2017-01-09 15:41:51)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000050
#+ Filename...: aapt510
#+ Description: 進口信用狀申請作業
#+ Creator....: 03080(2016-02-16 10:20:54)
#+ Modifier...: 03080 -SD/PR- 06821
 
{</section>}
 
{<section id="aapt510.global" >}
#應用 t01 樣板自動產生(Version:79)
#add-point:填寫註解說明 name="global.memo" 
#160321-00016#22 2016/03/24 By Jessy     修正azzi920重複定義之錯誤訊息
#160318-00025#24 2016/04/25 By 07900     校验代码重复错误讯息的修改
#160428-00001#1  2016/05/23 By Hans      aapt510規格修改
#160428-00001#14 2016/06/16 By albireo   1.修正單身增加幣別匯率後,單身與單頭金額不平時進行單頭更新的原則
#                                        2.單價反推時不取位
#160614-00010#1  2016/06/17 By albireo   補上來源組織與採購單勾稽實現權限控卡
#160627無單      2016/06/27 By albireo   1.修正問題:本幣幣別錯 agli010 法人主帳套設TWD , 冒出CNY  ,這部份會影響到金額取位 
#                                        2.修正問題:單身開窗自動產生無法選到本幣幣別的採購單產生
#                                        3.修正問題:是採購單含稅價不用再重推單價
#                                        4.修正問題:單頭查詢時現金變動碼說明未重新取
#                                        5.畫面依aapt520調整
#160622-00006#1  2016/08/01 By albireo   單頭本幣,單身可多幣別;單頭不等於本幣,單身不可多幣別
#160818-00017#1  2016/08/23 By 07900     删除修改未重新判断状态码
#160822-00008#5  2016/08/23 By 06821     欄位新舊值調整
#160824-00049#1  2016/08/25 By albireo   配合SA整測修改
#160726-00020#16 2016/08/25 By 08729     複製時清空特定欄位
#160428-00001#15 2016/08/26 By albireo   費用單身優化
##160905-00002#3 2016/09/05 By albireo   SQL補串ENT
#161006-00005#5  2016/10/12 By 08732     組織類型與職能開窗調整
#161014-00053#3  2016/10/21 By 08171     增加控制組
#161104-00024#4  2016/11/09 By 08729     處理DEFINE有星號
#161108-00017#4  2016/11/10 By Reanna    程式中INSERT INTO 有星號作整批調整
#161115-00042#5  2016/11/17 By 08729     開窗增加過濾據點
#161226-00048#1  2016/12/28 By 06948     支付帳戶開窗(q_nmas_01)增加部門設限資料(nmlm_t)的where條件
#161104-00046#7  2016/12/30 By 08171     單別預設值;資料依照單別user dept權限過濾單號
#161229-00047#51 2017/01/09 By 06821     財務用供應商對象控制組,法人條件改為用 IN (site...)的方式,QBE時,傳入符合權限的法人；INPUT時傳入目前法人據點
#end add-point
#add-point:填寫註解說明(客製用) name="global.memo_customerization"

#end add-point
 
IMPORT os
IMPORT util
IMPORT FGL lib_cl_dlg
#add-point:增加匯入項目 name="global.import"

#end add-point 
 
SCHEMA ds 
 
GLOBALS "../../cfg/top_global.inc"
 
#add-point:增加匯入變數檔 name="global.inc"

#end add-point
 
#單頭 type 宣告
PRIVATE type type_g_apga_m        RECORD
       apgacomp LIKE apga_t.apgacomp, 
   apgacomp_desc LIKE type_t.chr80, 
   apga005 LIKE apga_t.apga005, 
   apga005_desc LIKE type_t.chr80, 
   apga006 LIKE apga_t.apga006, 
   apgadocno LIKE apga_t.apgadocno, 
   apga002 LIKE apga_t.apga002, 
   apgadocdt LIKE apga_t.apgadocdt, 
   apga003 LIKE apga_t.apga003, 
   apga004 LIKE apga_t.apga004, 
   apga004_desc LIKE type_t.chr80, 
   apga001 LIKE apga_t.apga001, 
   apga028 LIKE apga_t.apga028, 
   apga029 LIKE apga_t.apga029, 
   apgastus LIKE apga_t.apgastus, 
   apgaownid LIKE apga_t.apgaownid, 
   apgaownid_desc LIKE type_t.chr80, 
   apgaowndp LIKE apga_t.apgaowndp, 
   apgaowndp_desc LIKE type_t.chr80, 
   apgacrtid LIKE apga_t.apgacrtid, 
   apgacrtid_desc LIKE type_t.chr80, 
   apgacrtdp LIKE apga_t.apgacrtdp, 
   apgacrtdp_desc LIKE type_t.chr80, 
   apgacrtdt LIKE apga_t.apgacrtdt, 
   apgamodid LIKE apga_t.apgamodid, 
   apgamodid_desc LIKE type_t.chr80, 
   apgamoddt LIKE apga_t.apgamoddt, 
   apgacnfid LIKE apga_t.apgacnfid, 
   apgacnfid_desc LIKE type_t.chr80, 
   apgacnfdt LIKE apga_t.apgacnfdt, 
   apgapstid LIKE apga_t.apgapstid, 
   apgapstid_desc LIKE type_t.chr80, 
   apgapstdt LIKE apga_t.apgapstdt, 
   apga007 LIKE apga_t.apga007, 
   apga007_desc LIKE type_t.chr80, 
   apga030 LIKE apga_t.apga030, 
   apga030_desc LIKE type_t.chr80, 
   apga008 LIKE apga_t.apga008, 
   apga009 LIKE apga_t.apga009, 
   apga013 LIKE apga_t.apga013, 
   apga012 LIKE apga_t.apga012, 
   apga010 LIKE apga_t.apga010, 
   apga014 LIKE apga_t.apga014, 
   apga011 LIKE apga_t.apga011, 
   apga100 LIKE apga_t.apga100, 
   apga015 LIKE apga_t.apga015, 
   apga103 LIKE apga_t.apga103, 
   apga104 LIKE apga_t.apga104, 
   apga108 LIKE apga_t.apga108, 
   apga102 LIKE apga_t.apga102, 
   apga026 LIKE apga_t.apga026, 
   apga040 LIKE apga_t.apga040, 
   apga109 LIKE apga_t.apga109, 
   glaa001 LIKE type_t.chr500, 
   apga101 LIKE apga_t.apga101, 
   apga113 LIKE apga_t.apga113, 
   apga114 LIKE apga_t.apga114, 
   apga118 LIKE apga_t.apga118, 
   apga112 LIKE apga_t.apga112, 
   apga105 LIKE apga_t.apga105, 
   apga016 LIKE apga_t.apga016, 
   apga017 LIKE apga_t.apga017, 
   apga018 LIKE apga_t.apga018, 
   apga115 LIKE apga_t.apga115, 
   apga106 LIKE apga_t.apga106, 
   apga107 LIKE apga_t.apga107, 
   apga019 LIKE apga_t.apga019, 
   apga020 LIKE apga_t.apga020, 
   apga020_desc LIKE type_t.chr80, 
   apga021 LIKE apga_t.apga021, 
   apga022 LIKE apga_t.apga022, 
   apga023 LIKE apga_t.apga023, 
   apga024 LIKE apga_t.apga024, 
   apga025 LIKE apga_t.apga025, 
   l_apga1041 LIKE type_t.num20_6, 
   apga036 LIKE apga_t.apga036, 
   apga036_desc LIKE type_t.chr80, 
   apga037 LIKE apga_t.apga037, 
   apga037_desc LIKE type_t.chr80, 
   apga032 LIKE apga_t.apga032, 
   l_apga1081 LIKE type_t.num20_6, 
   apga034 LIKE apga_t.apga034, 
   apga034_desc LIKE type_t.chr80, 
   apga035 LIKE apga_t.apga035, 
   apga035_desc LIKE type_t.chr80, 
   apga031 LIKE apga_t.apga031, 
   l_apga1021 LIKE type_t.num20_6, 
   apga038 LIKE apga_t.apga038, 
   apga038_desc LIKE type_t.chr80, 
   apga039 LIKE apga_t.apga039, 
   apga039_desc LIKE type_t.chr80, 
   apga033 LIKE apga_t.apga033, 
   apga027 LIKE apga_t.apga027
       END RECORD
 
#單身 type 宣告
PRIVATE TYPE type_g_apgb_d        RECORD
       apgbseq LIKE apgb_t.apgbseq, 
   apgborga LIKE apgb_t.apgborga, 
   apgborga_desc LIKE type_t.chr500, 
   apgb001 LIKE apgb_t.apgb001, 
   apgb002 LIKE apgb_t.apgb002, 
   apgb003 LIKE apgb_t.apgb003, 
   apgb004 LIKE apgb_t.apgb004, 
   apgb005 LIKE apgb_t.apgb005, 
   apgb008 LIKE apgb_t.apgb008, 
   apgb006 LIKE apgb_t.apgb006, 
   apgb007 LIKE apgb_t.apgb007, 
   apgb100 LIKE apgb_t.apgb100, 
   apgb101 LIKE apgb_t.apgb101, 
   apgb009 LIKE apgb_t.apgb009, 
   apgb105 LIKE apgb_t.apgb105, 
   apgb115 LIKE apgb_t.apgb115, 
   apgb010 LIKE apgb_t.apgb010, 
   apgb011 LIKE apgb_t.apgb011
       END RECORD
PRIVATE TYPE type_g_apgb2_d RECORD
       apgc900 LIKE apgc_t.apgc900, 
   apgcseq LIKE apgc_t.apgcseq, 
   apgcorga LIKE apgc_t.apgcorga, 
   apgc001 LIKE apgc_t.apgc001, 
   apgc001_desc LIKE type_t.chr500, 
   apgc002 LIKE apgc_t.apgc002, 
   apgc003 LIKE apgc_t.apgc003, 
   apgc005 LIKE apgc_t.apgc005, 
   apgc014 LIKE apgc_t.apgc014, 
   apgc100 LIKE apgc_t.apgc100, 
   apgc101 LIKE apgc_t.apgc101, 
   apgc006 LIKE apgc_t.apgc006, 
   apgc007 LIKE apgc_t.apgc007, 
   apgc008 LIKE apgc_t.apgc008, 
   apgc009 LIKE apgc_t.apgc009, 
   apgc010 LIKE apgc_t.apgc010, 
   apgc011 LIKE apgc_t.apgc011, 
   apgc103 LIKE apgc_t.apgc103, 
   apgc104 LIKE apgc_t.apgc104, 
   apgc105 LIKE apgc_t.apgc105, 
   apgc113 LIKE apgc_t.apgc113, 
   apgc114 LIKE apgc_t.apgc114, 
   apgc115 LIKE apgc_t.apgc115, 
   apgc004 LIKE apgc_t.apgc004, 
   apgc004_desc LIKE type_t.chr100, 
   apgc015 LIKE apgc_t.apgc015, 
   apgc015_desc LIKE type_t.chr100, 
   apgc016 LIKE apgc_t.apgc016, 
   apgc016_desc LIKE type_t.chr100, 
   apgc012 LIKE apgc_t.apgc012, 
   apgc013 LIKE apgc_t.apgc013
       END RECORD
PRIVATE TYPE type_g_apgb3_d RECORD
       xrcdseq LIKE xrcd_t.xrcdseq, 
   xrcdseq2 LIKE xrcd_t.xrcdseq2, 
   xrcd007 LIKE xrcd_t.xrcd007, 
   xrcdld LIKE xrcd_t.xrcdld, 
   xrcd002 LIKE xrcd_t.xrcd002, 
   xrcd002_desc LIKE type_t.chr500, 
   xrcd003 LIKE xrcd_t.xrcd003, 
   xrcd006 LIKE xrcd_t.xrcd006, 
   xrcd005 LIKE xrcd_t.xrcd005, 
   xrcd102 LIKE xrcd_t.xrcd102, 
   xrcd103 LIKE xrcd_t.xrcd103, 
   xrcd104 LIKE xrcd_t.xrcd104, 
   xrcd105 LIKE xrcd_t.xrcd105, 
   xrcd113 LIKE xrcd_t.xrcd113, 
   xrcd114 LIKE xrcd_t.xrcd114, 
   xrcd115 LIKE xrcd_t.xrcd115, 
   xrcd123 LIKE xrcd_t.xrcd123, 
   xrcd124 LIKE xrcd_t.xrcd124, 
   xrcd125 LIKE xrcd_t.xrcd125, 
   xrcd133 LIKE xrcd_t.xrcd133, 
   xrcd134 LIKE xrcd_t.xrcd134, 
   xrcd135 LIKE xrcd_t.xrcd135, 
   xrcdorga LIKE xrcd_t.xrcdorga, 
   xrcd009 LIKE xrcd_t.xrcd009, 
   xrcd009_desc LIKE type_t.chr500, 
   xrcd001 LIKE xrcd_t.xrcd001, 
   xrcd004 LIKE xrcd_t.xrcd004, 
   xrcd100 LIKE xrcd_t.xrcd100, 
   xrcd101 LIKE xrcd_t.xrcd101, 
   xrcd106 LIKE xrcd_t.xrcd106, 
   xrcd112 LIKE xrcd_t.xrcd112, 
   xrcd116 LIKE xrcd_t.xrcd116, 
   xrcd117 LIKE xrcd_t.xrcd117, 
   xrcd118 LIKE xrcd_t.xrcd118, 
   xrcd121 LIKE xrcd_t.xrcd121, 
   xrcd131 LIKE xrcd_t.xrcd131, 
   xrcdsite LIKE xrcd_t.xrcdsite
       END RECORD
 
 
PRIVATE TYPE type_browser RECORD
         b_statepic     LIKE type_t.chr50,
            b_apgacomp LIKE apga_t.apgacomp,
      b_apgadocno LIKE apga_t.apgadocno
       END RECORD
       
#add-point:自定義模組變數(Module Variable) (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="global.variable"
DEFINE g_wc_cs_comp    STRING    #azzi800的權限可看的資料範圍
DEFINE g_wc_apgborga   STRING
DEFINE g_sql_ctrl      STRING
DEFINE g_site_str      STRING              #161115-00042#5-add
DEFINE g_ld            LIKE glaa_t.glaald  #161115-00042#5-add
#161104-00046#7 --s add
DEFINE g_user_dept_wc      STRING
DEFINE g_user_dept_wc_q    STRING
DEFINE g_user_slip_wc      STRING
DEFINE g_ap_slip           LIKE ooba_t.ooba002
#161104-00046#7 --e add
DEFINE g_comp_str          STRING  #161229-00047#51 add 
#end add-point
       
#模組變數(Module Variables)
DEFINE g_apga_m          type_g_apga_m
DEFINE g_apga_m_t        type_g_apga_m
DEFINE g_apga_m_o        type_g_apga_m
DEFINE g_apga_m_mask_o   type_g_apga_m #轉換遮罩前資料
DEFINE g_apga_m_mask_n   type_g_apga_m #轉換遮罩後資料
 
   DEFINE g_apgacomp_t LIKE apga_t.apgacomp
DEFINE g_apgadocno_t LIKE apga_t.apgadocno
 
 
DEFINE g_apgb_d          DYNAMIC ARRAY OF type_g_apgb_d
DEFINE g_apgb_d_t        type_g_apgb_d
DEFINE g_apgb_d_o        type_g_apgb_d
DEFINE g_apgb_d_mask_o   DYNAMIC ARRAY OF type_g_apgb_d #轉換遮罩前資料
DEFINE g_apgb_d_mask_n   DYNAMIC ARRAY OF type_g_apgb_d #轉換遮罩後資料
DEFINE g_apgb2_d          DYNAMIC ARRAY OF type_g_apgb2_d
DEFINE g_apgb2_d_t        type_g_apgb2_d
DEFINE g_apgb2_d_o        type_g_apgb2_d
DEFINE g_apgb2_d_mask_o   DYNAMIC ARRAY OF type_g_apgb2_d #轉換遮罩前資料
DEFINE g_apgb2_d_mask_n   DYNAMIC ARRAY OF type_g_apgb2_d #轉換遮罩後資料
DEFINE g_apgb3_d          DYNAMIC ARRAY OF type_g_apgb3_d
DEFINE g_apgb3_d_t        type_g_apgb3_d
DEFINE g_apgb3_d_o        type_g_apgb3_d
DEFINE g_apgb3_d_mask_o   DYNAMIC ARRAY OF type_g_apgb3_d #轉換遮罩前資料
DEFINE g_apgb3_d_mask_n   DYNAMIC ARRAY OF type_g_apgb3_d #轉換遮罩後資料
 
 
DEFINE g_browser         DYNAMIC ARRAY OF type_browser
DEFINE g_browser_f       DYNAMIC ARRAY OF type_browser
 
 
DEFINE g_wc                  STRING
DEFINE g_wc_t                STRING
DEFINE g_wc2                 STRING                          #單身CONSTRUCT結果
DEFINE g_wc2_table1          STRING
DEFINE g_wc2_table2   STRING
 
DEFINE g_wc2_table3   STRING
 
 
 
DEFINE g_wc2_extend          STRING
DEFINE g_wc_filter           STRING
DEFINE g_wc_filter_t         STRING
 
DEFINE g_sql                 STRING
DEFINE g_forupd_sql          STRING
DEFINE g_cnt                 LIKE type_t.num10
DEFINE g_current_idx         LIKE type_t.num10     
DEFINE g_jump                LIKE type_t.num10        
DEFINE g_no_ask              LIKE type_t.num5        
DEFINE g_rec_b               LIKE type_t.num10           
DEFINE l_ac                  LIKE type_t.num10    
DEFINE g_curr_diag           ui.Dialog                         #Current Dialog
                                                               
DEFINE g_pagestart           LIKE type_t.num10                 
DEFINE gwin_curr             ui.Window                         #Current Window
DEFINE gfrm_curr             ui.Form                           #Current Form
DEFINE g_page_action         STRING                            #page action
DEFINE g_header_hidden       LIKE type_t.num5                  #隱藏單頭
DEFINE g_worksheet_hidden    LIKE type_t.num5                  #隱藏工作Panel
DEFINE g_page                STRING                            #第幾頁
DEFINE g_state               STRING       
DEFINE g_header_cnt          LIKE type_t.num10
DEFINE g_detail_cnt          LIKE type_t.num10                  #單身總筆數
DEFINE g_detail_idx          LIKE type_t.num10                  #單身目前所在筆數
DEFINE g_detail_idx_tmp      LIKE type_t.num10                  #單身目前所在筆數
DEFINE g_detail_idx2         LIKE type_t.num10                  #單身2目前所在筆數
DEFINE g_detail_idx_list     DYNAMIC ARRAY OF LIKE type_t.num10 #單身2目前所在筆數
DEFINE g_browser_cnt         LIKE type_t.num10                  #Browser總筆數
DEFINE g_browser_idx         LIKE type_t.num10                  #Browser目前所在筆數
DEFINE g_temp_idx            LIKE type_t.num10                  #Browser目前所在筆數(暫存用)
DEFINE g_order               STRING                             #查詢排序欄位
                                                        
DEFINE g_current_row         LIKE type_t.num10                  #Browser所在筆數
DEFINE g_current_sw          BOOLEAN                            #Browser所在筆數用開關
DEFINE g_current_page        LIKE type_t.num10                  #目前所在頁數
DEFINE g_insert              LIKE type_t.chr5                   #是否導到其他page
 
DEFINE g_ref_fields          DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
DEFINE g_ref_vars            DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
DEFINE g_rtn_fields          DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
DEFINE gs_keys               DYNAMIC ARRAY OF VARCHAR(500) #同步資料用陣列
DEFINE gs_keys_bak           DYNAMIC ARRAY OF VARCHAR(500) #同步資料用陣列
DEFINE g_bfill               LIKE type_t.chr5              #是否刷新單身
DEFINE g_error_show          LIKE type_t.num5              #是否顯示筆數提示訊息
DEFINE g_master_insert       BOOLEAN                       #確認單頭資料是否寫入
 
DEFINE g_wc_frozen           STRING                        #凍結欄位使用
DEFINE g_chk                 BOOLEAN                       #助記碼判斷用
DEFINE g_aw                  STRING                        #確定當下點擊的單身
DEFINE g_default             BOOLEAN                       #是否有外部參數查詢
DEFINE g_log1                STRING                        #log用
DEFINE g_log2                STRING                        #log用
DEFINE g_loc                 LIKE type_t.chr5              #判斷游標所在位置
DEFINE g_add_browse          STRING                        #新增填充用WC
DEFINE g_update              BOOLEAN                       #確定單頭/身是否異動過
DEFINE g_idx_group           om.SaxAttributes              #頁籤群組
DEFINE g_master_commit       LIKE type_t.chr1              #確認單頭是否修改過
 
#add-point:自定義客戶專用模組變數(Module Variable) name="global.variable_customerization"

#end add-point
 
#add-point:傳入參數說明(global.argv) name="global.argv"

#end add-point
 
{</section>}
 
{<section id="aapt510.main" >}
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
   CALL cl_ap_init("aap","")
 
   #add-point:作業初始化 name="main.init"
   LET g_sql_ctrl = NULL
   #CALL s_control_get_supplier_sql('4',g_site,g_user,g_dept,'') RETURNING g_sub_success,g_sql_ctrl #161115-00042#5 mark
   #161115-00042#5-add(s)
   SELECT ooef017 INTO g_apga_m.apgacomp
     FROM ooef_t
    WHERE ooefent = g_enterprise
      AND ooef001 = g_site
      AND ooefstus = 'Y'
   #CALL s_control_get_supplier_sql_pmab('4',g_site,g_user,g_dept,'',g_apga_m.apgacomp) RETURNING g_sub_success,g_sql_ctrl  #161229-00047#51 mark
   #161115-00042#5-add(e)
   #161104-00046#7 --s add
   #建立與單頭array相同的temptable
   CALL s_aooi200def_create('','g_apga_m','','','','','','')RETURNING g_sub_success
   
   #單別控制組
   LET g_user_dept_wc = ''
   CALL s_fin_get_user_dept_control('apgacomp','','apgaent','apgadocno') RETURNING g_user_dept_wc
   #開窗使用
   LET g_user_dept_wc_q = g_user_dept_wc
   
   CALL s_control_get_docno_sql(g_user,g_dept) RETURNING g_sub_success,g_user_slip_wc  
   #161104-00046#7 --e add
   #end add-point
   
   
 
   #LOCK CURSOR (identifier)
   #add-point:SQL_define name="main.define_sql"
   
   #end add-point
   LET g_forupd_sql = " SELECT apgacomp,'',apga005,'',apga006,apgadocno,apga002,apgadocdt,apga003,apga004, 
       '',apga001,apga028,apga029,apgastus,apgaownid,'',apgaowndp,'',apgacrtid,'',apgacrtdp,'',apgacrtdt, 
       apgamodid,'',apgamoddt,apgacnfid,'',apgacnfdt,apgapstid,'',apgapstdt,apga007,'',apga030,'',apga008, 
       apga009,apga013,apga012,apga010,apga014,apga011,apga100,apga015,apga103,apga104,apga108,apga102, 
       apga026,apga040,apga109,'',apga101,apga113,apga114,apga118,apga112,apga105,apga016,apga017,apga018, 
       apga115,apga106,apga107,apga019,apga020,'',apga021,apga022,apga023,apga024,apga025,'',apga036, 
       '',apga037,'',apga032,'',apga034,'',apga035,'',apga031,'',apga038,'',apga039,'',apga033,apga027", 
        
                      " FROM apga_t",
                      " WHERE apgaent= ? AND apgacomp=? AND apgadocno=? FOR UPDATE"
   #add-point:SQL_define name="main.after_define_sql"
   
   #end add-point
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)                #轉換不同資料庫語法
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE aapt510_cl CURSOR FROM g_forupd_sql                 # LOCK CURSOR
 
   LET g_sql = " SELECT DISTINCT t0.apgacomp,t0.apga005,t0.apga006,t0.apgadocno,t0.apga002,t0.apgadocdt, 
       t0.apga003,t0.apga004,t0.apga001,t0.apga028,t0.apga029,t0.apgastus,t0.apgaownid,t0.apgaowndp, 
       t0.apgacrtid,t0.apgacrtdp,t0.apgacrtdt,t0.apgamodid,t0.apgamoddt,t0.apgacnfid,t0.apgacnfdt,t0.apgapstid, 
       t0.apgapstdt,t0.apga007,t0.apga030,t0.apga008,t0.apga009,t0.apga013,t0.apga012,t0.apga010,t0.apga014, 
       t0.apga011,t0.apga100,t0.apga015,t0.apga103,t0.apga104,t0.apga108,t0.apga102,t0.apga026,t0.apga040, 
       t0.apga109,t0.apga101,t0.apga113,t0.apga114,t0.apga118,t0.apga112,t0.apga105,t0.apga016,t0.apga017, 
       t0.apga018,t0.apga115,t0.apga106,t0.apga107,t0.apga019,t0.apga020,t0.apga021,t0.apga022,t0.apga023, 
       t0.apga024,t0.apga025,t0.apga036,t0.apga037,t0.apga032,t0.apga034,t0.apga035,t0.apga031,t0.apga038, 
       t0.apga039,t0.apga033,t0.apga027,t1.ooefl003 ,t2.ooag011 ,t3.pmaal004 ,t4.ooag011 ,t5.ooefl003 , 
       t6.ooag011 ,t7.ooefl003 ,t8.ooag011 ,t9.ooag011 ,t10.ooag011 ,t11.nmabl003 ,t12.nmabl003 ,t13.oocql004 , 
       t14.nmajl003 ,t15.nmail004 ,t16.nmajl003 ,t17.nmail004 ,t18.nmajl003 ,t19.nmail004",
               " FROM apga_t t0",
                              " LEFT JOIN ooefl_t t1 ON t1.ooeflent="||g_enterprise||" AND t1.ooefl001=t0.apgacomp AND t1.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t2 ON t2.ooagent="||g_enterprise||" AND t2.ooag001=t0.apga005  ",
               " LEFT JOIN pmaal_t t3 ON t3.pmaalent="||g_enterprise||" AND t3.pmaal001=t0.apga004 AND t3.pmaal002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t4 ON t4.ooagent="||g_enterprise||" AND t4.ooag001=t0.apgaownid  ",
               " LEFT JOIN ooefl_t t5 ON t5.ooeflent="||g_enterprise||" AND t5.ooefl001=t0.apgaowndp AND t5.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t6 ON t6.ooagent="||g_enterprise||" AND t6.ooag001=t0.apgacrtid  ",
               " LEFT JOIN ooefl_t t7 ON t7.ooeflent="||g_enterprise||" AND t7.ooefl001=t0.apgacrtdp AND t7.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t8 ON t8.ooagent="||g_enterprise||" AND t8.ooag001=t0.apgamodid  ",
               " LEFT JOIN ooag_t t9 ON t9.ooagent="||g_enterprise||" AND t9.ooag001=t0.apgacnfid  ",
               " LEFT JOIN ooag_t t10 ON t10.ooagent="||g_enterprise||" AND t10.ooag001=t0.apgapstid  ",
               " LEFT JOIN nmabl_t t11 ON t11.nmablent="||g_enterprise||" AND t11.nmabl001=t0.apga007 AND t11.nmabl002='"||g_dlang||"' ",
               " LEFT JOIN nmabl_t t12 ON t12.nmablent="||g_enterprise||" AND t12.nmabl001=t0.apga030 AND t12.nmabl002='"||g_dlang||"' ",
               " LEFT JOIN oocql_t t13 ON t13.oocqlent="||g_enterprise||" AND t13.oocql001='263' AND t13.oocql002=t0.apga020 AND t13.oocql003='"||g_dlang||"' ",
               " LEFT JOIN nmajl_t t14 ON t14.nmajlent="||g_enterprise||" AND t14.nmajl001=t0.apga036 AND t14.nmajl002='"||g_dlang||"' ",
               " LEFT JOIN nmail_t t15 ON t15.nmailent="||g_enterprise||" AND t15.nmail001=t0.apga037 AND t15.nmail002='"||g_dlang||"' ",
               " LEFT JOIN nmajl_t t16 ON t16.nmajlent="||g_enterprise||" AND t16.nmajl001=t0.apga034 AND t16.nmajl002='"||g_dlang||"' ",
               " LEFT JOIN nmail_t t17 ON t17.nmailent="||g_enterprise||" AND t17.nmail001=t0.apga035 AND t17.nmail002='"||g_dlang||"' ",
               " LEFT JOIN nmajl_t t18 ON t18.nmajlent="||g_enterprise||" AND t18.nmajl001=t0.apga038 AND t18.nmajl002='"||g_dlang||"' ",
               " LEFT JOIN nmail_t t19 ON t19.nmailent="||g_enterprise||" AND t19.nmail001=t0.apga039 AND t19.nmail002='"||g_dlang||"' ",
 
               " WHERE t0.apgaent = " ||g_enterprise|| " AND t0.apgacomp = ? AND t0.apgadocno = ?"
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   #add-point:SQL_define name="main.after_refresh_sql"
   
   #end add-point
   PREPARE aapt510_master_referesh FROM g_sql
 
    
 
   
   IF g_bgjob = "Y" THEN
      #add-point:Service Call name="main.servicecall"
      
      #end add-point
   ELSE
      #畫面開啟 (identifier)
      OPEN WINDOW w_aapt510 WITH FORM cl_ap_formpath("aap",g_code)
   
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
   
      #程式初始化
      CALL aapt510_init()   
 
      #進入選單 Menu (="N")
      CALL aapt510_ui_dialog() 
      
      #add-point:畫面關閉前 name="main.before_close"
      
      #end add-point
 
      #畫面關閉
      CLOSE WINDOW w_aapt510
      
   END IF 
   
   CLOSE aapt510_cl
   
   
 
   #add-point:作業離開前 name="main.exit"
   
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
END MAIN
 
 
 
 
{</section>}
 
{<section id="aapt510.init" >}
#+ 瀏覽頁簽資料初始化
PRIVATE FUNCTION aapt510_init()
   #add-point:init段define(客製用) name="init.define_customerization"
   
   #end add-point    
   #add-point:init段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="init.define"
   
   #end add-point   
   
   #add-point:Function前置處理  name="init.pre_function"
   
   #end add-point
   
   LET g_bfill       = "Y"
   LET g_detail_idx  = 1 #第一層單身指標
   LET g_detail_idx2 = 1 #第二層單身指標
   
   #各個page指標
   LET g_detail_idx_list[1] = 1 
   LET g_detail_idx_list[2] = 1
   LET g_detail_idx_list[3] = 1
 
   LET g_error_show  = 1
   LET l_ac = 1 #單身指標
      CALL cl_set_combo_scc_part('apgastus','13','N,Y,A,D,R,W,X')
 
      CALL cl_set_combo_scc('apga006','8517') 
   CALL cl_set_combo_scc('apga013','8516') 
 
   LET gwin_curr = ui.Window.getCurrent()  #取得現行畫面
   LET gfrm_curr = gwin_curr.getForm()     #取出物件化後的畫面物件
   
   #page群組
   LET g_idx_group = om.SaxAttributes.create()
   CALL g_idx_group.addAttribute("'1',","1")
   CALL g_idx_group.addAttribute("'2',","1")
   CALL g_idx_group.addAttribute("'3',","1")
 
 
   #add-point:畫面資料初始化 name="init.init"
   CALL cl_set_combo_scc('apga006','8517')
   CALL cl_set_combo_scc('apga008','8515')
   CALL cl_set_combo_scc('apga013','8516')
   CALL cl_set_combo_scc('apgc011','9719')
   CALL s_fin_create_account_center_tmp()    #8營運中心
   
   #160824-00049#1-----s
   CALL s_fin_azzi800_sons_query(g_today)
   CALL s_fin_account_center_comp_str() RETURNING g_wc_cs_comp   
   CALL s_fin_get_wc_str(g_wc_cs_comp) RETURNING g_wc_cs_comp
   CALL s_control_get_supplier_sql_pmab('4',g_site,g_user,g_dept,'',g_wc_cs_comp) RETURNING g_sub_success,g_sql_ctrl #161229-00047#51 add
   
   #CALL s_axrt300_get_site(g_user,'','3') RETURNING g_wc_cs_comp 
   #160824-00049#1-----e
   CALL s_aapp330_cre_tmp() RETURNING g_sub_success            #不走分錄時使用
   CALL s_pre_voucher_cre_tmp_table() RETURNING g_sub_success  #走分錄時使用
   CALL s_fin_continue_no_tmp()
   CALL s_aap_create_multi_bill_perod_tmp()
   #end add-point
   
   #初始化搜尋條件
   CALL aapt510_default_search()
    
END FUNCTION
 
{</section>}
 
{<section id="aapt510.ui_dialog" >}
#+ 功能選單
PRIVATE FUNCTION aapt510_ui_dialog()
   #add-point:ui_dialog段define(客製用) name="ui_dialog.define_customerization"
   
   #end add-point
   DEFINE li_idx     LIKE type_t.num10
   DEFINE ls_wc      STRING
   DEFINE lb_first   BOOLEAN
   DEFINE la_wc      DYNAMIC ARRAY OF RECORD
          tableid    STRING,
          wc         STRING
          END RECORD
   DEFINE la_param   RECORD
          prog       STRING,
          actionid   STRING,
          background LIKE type_t.chr1,
          param      DYNAMIC ARRAY OF STRING
          END RECORD
   DEFINE ls_js      STRING
   DEFINE la_output  DYNAMIC ARRAY OF STRING   #報表元件鬆耦合使用
   DEFINE  l_cmd_token           base.StringTokenizer   #報表作業cmdrun使用 
   DEFINE  l_cmd_next            STRING                 #報表作業cmdrun使用
   DEFINE  l_cmd_cnt             LIKE type_t.num5       #報表作業cmdrun使用
   DEFINE  l_cmd_prog_arg        STRING                 #報表作業cmdrun使用
   DEFINE  l_cmd_arg             STRING                 #報表作業cmdrun使用
   #add-point:ui_dialog段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="ui_dialog.define"
   DEFINE l_count530             LIKE type_t.num10
   DEFINE l_count540             LIKE type_t.num10
   DEFINE l_count550             LIKE type_t.num10
   #end add-point
   
   #add-point:Function前置處理  name="ui_dialog.pre_function"
   
   #end add-point
   
   CALL cl_set_act_visible("accept,cancel", FALSE)
 
   #因應查詢方案進行處理
   IF g_default THEN
      CALL gfrm_curr.setElementHidden("mainlayout",0)
      CALL gfrm_curr.setElementHidden("worksheet",1)
      LET g_main_hidden = 0
   ELSE
      CALL gfrm_curr.setElementHidden("mainlayout",1)
      CALL gfrm_curr.setElementHidden("worksheet",0)
      LET g_main_hidden = 1
   END IF
   
   #action default動作
   #應用 a42 樣板自動產生(Version:3)
   #進入程式時預設執行的動作
   CASE g_actdefault
      WHEN "insert"
         LET g_action_choice="insert"
         LET g_actdefault = ""
         IF cl_auth_chk_act("insert") THEN
            CALL aapt510_insert()
            #add-point:ON ACTION insert name="menu.default.insert"
            
            #END add-point
         END IF
 
      #add-point:action default自訂 name="ui_dialog.action_default"
      
      #end add-point
      OTHERWISE
   END CASE
 
 
 
   
   LET lb_first = TRUE
   
   #add-point:ui_dialog段before dialog  name="ui_dialog.before_dialog"
   
   #end add-point
   
   WHILE TRUE 
   
      IF g_action_choice = "logistics" THEN
         #清除畫面及相關資料
         CLEAR FORM
         CALL g_browser.clear()       
         INITIALIZE g_apga_m.* TO NULL
         CALL g_apgb_d.clear()
         CALL g_apgb2_d.clear()
         CALL g_apgb3_d.clear()
 
         LET g_wc  = ' 1=2'
         LET g_wc2 = ' 1=1'
         LET g_action_choice = ""
         CALL aapt510_init()
      END IF
   
      CALL lib_cl_dlg.cl_dlg_before_display()
            
      DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
 
         #左側瀏覽頁簽
         DISPLAY ARRAY g_browser TO s_browse.* ATTRIBUTES(COUNT=g_header_cnt)
            BEFORE ROW
               #回歸舊筆數位置 (回到當時異動的筆數)
               LET g_current_idx = DIALOG.getCurrentRow("s_browse")
               IF g_current_row > 1 AND g_current_idx = 1 AND g_current_sw = FALSE THEN
                  CALL DIALOG.setCurrentRow("s_browse",g_current_row)
                  LET g_current_idx = g_current_row
               END IF
               LET g_current_row = g_current_idx #目前指標
               LET g_current_sw = TRUE
         
               IF g_current_idx > g_browser.getLength() THEN
                  LET g_current_idx = g_browser.getLength()
               END IF 
               
               CALL aapt510_fetch('') # reload data
               LET l_ac = 1
               CALL aapt510_ui_detailshow() #Setting the current row 
         
               CALL aapt510_idx_chk()
               #NEXT FIELD apgbseq
         
               ON ACTION qbefield_user   #欄位隱藏設定 
                  LET g_action_choice="qbefield_user"
                  CALL cl_ui_qbefield_user()
         END DISPLAY
    
         DISPLAY ARRAY g_apgb_d TO s_detail1.* ATTRIBUTES(COUNT=g_rec_b) #page1  
    
            BEFORE ROW
               #顯示單身筆數
               CALL aapt510_idx_chk()
               #確定當下選擇的筆數
               LET l_ac = DIALOG.getCurrentRow("s_detail1")
               LET g_detail_idx = l_ac
               LET g_detail_idx_list[1] = l_ac
               CALL g_idx_group.addAttribute("'1',",l_ac)
               
               #add-point:page1, before row動作 name="ui_dialog.page1.before_row"
               
               #end add-point
               
            BEFORE DISPLAY
               #如果一直都在單身1則控制筆數位置
               IF g_loc = 'm' THEN
                  CALL FGL_SET_ARR_CURR(g_idx_group.getValue("'1',"))
               END IF
               LET g_loc = 'm'
               LET l_ac = DIALOG.getCurrentRow("s_detail1")
               LET g_current_page = 1
               #顯示單身筆數
               CALL aapt510_idx_chk()
               #add-point:page1自定義行為 name="ui_dialog.page1.before_display"
               
               #end add-point
               
            #自訂ACTION(detail_show,page_1)
            
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION detail_qrystr
               MENU "" ATTRIBUTE(STYLE="popup")
                  #add-point:ON ACTION detail_qrystr相關動作 name="menu.detail_show.page1_sub.detail_qrystr"
                  
                  #END add-point
                                 #應用 a43 樣板自動產生(Version:4)
               ON ACTION prog_apmt500
                  LET g_action_choice="prog_apmt500"
                  IF cl_auth_chk_act("prog_apmt500") THEN
                     
                     #add-point:ON ACTION prog_apmt500 name="menu.detail_show.page1_sub.prog_apmt500"
               #應用 a41 樣板自動產生(Version:3)
               #使用JSON格式組合參數與作業編號(串查)
               IF NOT cl_null(g_apgb_d[l_ac].apgb001) THEN
                  INITIALIZE la_param.* TO NULL
                  LET la_param.prog     = 'apmt500'
                  LET la_param.param[1] = g_apgb_d[l_ac].apgb001
                  
                  LET ls_js = util.JSON.stringify(la_param)
                  CALL cl_cmdrun_wait(ls_js)
               END IF
 



                     #END add-point
                     
                  END IF
 
 
 
 
               END MENU
 
 
 
               #add-point:ON ACTION detail_qrystr name="menu.detail_show.page1.detail_qrystr"
               
               #END add-point
 
 
 
 
               
            #add-point:page1自定義行為 name="ui_dialog.page1.action"
            
            #end add-point
               
         END DISPLAY
        
         #第一階單身段落
         DISPLAY ARRAY g_apgb2_d TO s_detail2.* ATTRIBUTES(COUNT=g_rec_b)  
    
            BEFORE ROW
               #顯示單身筆數
               CALL aapt510_idx_chk()
               LET l_ac = DIALOG.getCurrentRow("s_detail2")
               LET g_detail_idx = l_ac
               LET g_detail_idx_list[2] = l_ac
               CALL g_idx_group.addAttribute("'2',",l_ac)
               
               #add-point:page2, before row動作 name="ui_dialog.body2.before_row"
               
               #end add-point
               
            BEFORE DISPLAY
               #如果一直都在單身1則控制筆數位置
               IF g_loc = 'm' THEN
                  CALL FGL_SET_ARR_CURR(g_idx_group.getValue("'2',"))
               END IF
               LET g_loc = 'm'
               LET l_ac = DIALOG.getCurrentRow("s_detail2")
               LET g_current_page = 2
               #顯示單身筆數
               CALL aapt510_idx_chk()
               #add-point:page2自定義行為 name="ui_dialog.body2.before_display"
               
               #end add-point
      
            #自訂ACTION(detail_show,page_2)
            
         
            #add-point:page2自定義行為 name="ui_dialog.body2.action"
            
            #end add-point
         
         END DISPLAY
         #第一階單身段落
         DISPLAY ARRAY g_apgb3_d TO s_detail3.* ATTRIBUTES(COUNT=g_rec_b)  
    
            BEFORE ROW
               #顯示單身筆數
               CALL aapt510_idx_chk()
               LET l_ac = DIALOG.getCurrentRow("s_detail3")
               LET g_detail_idx = l_ac
               LET g_detail_idx_list[3] = l_ac
               CALL g_idx_group.addAttribute("'3',",l_ac)
               
               #add-point:page3, before row動作 name="ui_dialog.body3.before_row"
               
               #end add-point
               
            BEFORE DISPLAY
               #如果一直都在單身1則控制筆數位置
               IF g_loc = 'm' THEN
                  CALL FGL_SET_ARR_CURR(g_idx_group.getValue("'3',"))
               END IF
               LET g_loc = 'm'
               LET l_ac = DIALOG.getCurrentRow("s_detail3")
               LET g_current_page = 3
               #顯示單身筆數
               CALL aapt510_idx_chk()
               #add-point:page3自定義行為 name="ui_dialog.body3.before_display"
               
               #end add-point
      
            #自訂ACTION(detail_show,page_3)
            
         
            #add-point:page3自定義行為 name="ui_dialog.body3.action"
            
            #end add-point
         
         END DISPLAY
 
         
 
         
         #add-point:ui_dialog段自定義display array name="ui_dialog.more_displayarray"
         
         #end add-point
         
         SUBDIALOG lib_cl_dlg.cl_dlg_qryplan
         SUBDIALOG lib_cl_dlg.cl_dlg_relateapps
      
         BEFORE DIALOG
            #先填充browser資料
            CALL aapt510_browser_fill("")
            CALL cl_notice()
            CALL cl_navigator_setting(g_current_idx, g_detail_cnt)
            LET g_curr_diag = ui.DIALOG.getCurrent()
            LET g_current_sw = FALSE
            #回歸舊筆數位置 (回到當時異動的筆數)
            LET g_current_idx = DIALOG.getCurrentRow("s_browse")
            IF g_current_row > 1 AND g_current_idx = 1 AND g_current_sw = FALSE THEN
               CALL DIALOG.setCurrentRow("s_browse",g_current_row)
               LET g_current_idx = g_current_row
            END IF
            
            #確保g_current_idx位於正常區間內
            #小於,等於0則指到第1筆
            IF g_current_idx <= 0 THEN
               LET g_current_idx = 1
            END IF
            #超過最大筆數則指到最後1筆
            IF g_current_idx > g_browser.getLength() THEN
               LEt g_current_idx = g_browser.getLength()
            END IF 
            
            LET g_current_sw = TRUE
            LET g_current_row = g_current_idx #目前指標
            
            #有資料才進行fetch
            IF g_current_idx <> 0 THEN
               CALL aapt510_fetch('') # reload data
            END IF
            #LET g_detail_idx = 1
            CALL aapt510_ui_detailshow() #Setting the current row 
            
            #筆數顯示
            LET g_current_page = 1
            CALL aapt510_idx_chk()
            CALL cl_ap_performance_cal()
            #add-point:ui_dialog段before_dialog2 name="ui_dialog.before_dialog2"
            
            #end add-point
 
         #add-point:ui_dialog段more_action name="ui_dialog.more_action"
         
         #end add-point
 
         #狀態碼切換
         ON ACTION statechange
            LET g_action_choice = "statechange"
            CALL aapt510_statechange()
            #根據資料狀態切換action狀態
            CALL cl_set_act_visible("statechange,modify,modify_detail,delete,reproduce", TRUE)
            CALL aapt510_set_act_visible()   
            CALL aapt510_set_act_no_visible()
            IF NOT (g_apga_m.apgacomp IS NULL
              OR g_apga_m.apgadocno IS NULL
 
              ) THEN
               #組合條件
               LET g_add_browse = " apgaent = " ||g_enterprise|| " AND",
                                  " apgacomp = '", g_apga_m.apgacomp, "' "
                                  ," AND apgadocno = '", g_apga_m.apgadocno, "' "
 
               #填到對應位置
               CALL aapt510_browser_fill("")
            END IF
         #應用 a32 樣板自動產生(Version:3)
         #簽核狀況
         ON ACTION bpm_status
            #查詢簽核狀況, 統一建立HyperLink
            CALL cl_bpm_status()
            #add-point:ON ACTION bpm_status name="menu.bpm_status"
            
            #END add-point
 
 
 
          
         #查詢方案選擇 
         ON ACTION queryplansel
            CALL cl_dlg_qryplan_select() RETURNING ls_wc
            #不是空條件才寫入g_wc跟重新找資料
            IF NOT cl_null(ls_wc) THEN
               CALL util.JSON.parse(ls_wc, la_wc)
               INITIALIZE g_wc, g_wc2,g_wc2_table1,g_wc2_extend TO NULL
               INITIALIZE g_wc2_table2 TO NULL
 
               INITIALIZE g_wc2_table3 TO NULL
 
 
               FOR li_idx = 1 TO la_wc.getLength()
                  CASE
                     WHEN la_wc[li_idx].tableid = "apga_t" 
                        LET g_wc = la_wc[li_idx].wc
                     WHEN la_wc[li_idx].tableid = "apgb_t" 
                        LET g_wc2_table1 = la_wc[li_idx].wc
                     WHEN la_wc[li_idx].tableid = "apgc_t" 
                        LET g_wc2_table2 = la_wc[li_idx].wc
 
                     WHEN la_wc[li_idx].tableid = "xrcd_t" 
                        LET g_wc2_table3 = la_wc[li_idx].wc
 
 
                     WHEN la_wc[li_idx].tableid = "EXTENDWC"
                        LET g_wc2_extend = la_wc[li_idx].wc
                  END CASE
               END FOR
               IF NOT cl_null(g_wc) OR NOT cl_null(g_wc2_table1) 
                  OR NOT cl_null(g_wc2_table2)
 
                  OR NOT cl_null(g_wc2_table3)
 
 
                  OR NOT cl_null(g_wc2_extend)
                  THEN
                  #組合g_wc2
                  IF g_wc2_table1 <> " 1=1" AND NOT cl_null(g_wc2_table1) THEN
                     LET g_wc2 = g_wc2_table1
                  END IF
                  IF g_wc2_table2 <> " 1=1" AND NOT cl_null(g_wc2_table2) THEN
                     LET g_wc2 = g_wc2 ," AND ", g_wc2_table2
                  END IF
 
                  IF g_wc2_table3 <> " 1=1" AND NOT cl_null(g_wc2_table3) THEN
                     LET g_wc2 = g_wc2 ," AND ", g_wc2_table3
                  END IF
 
 
                  IF g_wc2_extend <> " 1=1" AND NOT cl_null(g_wc2_extend) THEN
                     LET g_wc2 = g_wc2 ," AND ", g_wc2_extend
                  END IF
 
                  IF g_wc2.subString(1,5) = " AND " THEN
                     LET g_wc2 = g_wc2.subString(6,g_wc2.getLength())
                  END IF
               END IF
               CALL aapt510_browser_fill("F")   #browser_fill()會將notice區塊清空
               CALL cl_notice()   #重新顯示,此處不可用EXIT DIALOG, SUBDIALOG重讀會導致部分變數消失
            END IF
         
         #查詢方案選擇
         ON ACTION qbe_select
            CALL cl_qbe_list("m") RETURNING ls_wc
            IF NOT cl_null(ls_wc) THEN
               CALL util.JSON.parse(ls_wc, la_wc)
               INITIALIZE g_wc, g_wc2,g_wc2_table1,g_wc2_extend TO NULL
               INITIALIZE g_wc2_table2 TO NULL
 
               INITIALIZE g_wc2_table3 TO NULL
 
 
               FOR li_idx = 1 TO la_wc.getLength()
                  CASE
                     WHEN la_wc[li_idx].tableid = "apga_t" 
                        LET g_wc = la_wc[li_idx].wc
                     WHEN la_wc[li_idx].tableid = "apgb_t" 
                        LET g_wc2_table1 = la_wc[li_idx].wc
                     WHEN la_wc[li_idx].tableid = "apgc_t" 
                        LET g_wc2_table2 = la_wc[li_idx].wc
 
                     WHEN la_wc[li_idx].tableid = "xrcd_t" 
                        LET g_wc2_table3 = la_wc[li_idx].wc
 
 
                     WHEN la_wc[li_idx].tableid = "EXTENDWC"
                        LET g_wc2_extend = la_wc[li_idx].wc
                  END CASE
               END FOR
               IF NOT cl_null(g_wc) OR NOT cl_null(g_wc2_table1)
                  OR NOT cl_null(g_wc2_table2)
 
                  OR NOT cl_null(g_wc2_table3)
 
 
                  OR NOT cl_null(g_wc2_extend)
                  THEN
                  IF g_wc2_table1 <> " 1=1" AND NOT cl_null(g_wc2_table1) THEN
                     LET g_wc2 = g_wc2_table1
                  END IF
                  IF g_wc2_table2 <> " 1=1" AND NOT cl_null(g_wc2_table2) THEN
                     LET g_wc2 = g_wc2 ," AND ", g_wc2_table2
                  END IF
 
                  IF g_wc2_table3 <> " 1=1" AND NOT cl_null(g_wc2_table3) THEN
                     LET g_wc2 = g_wc2 ," AND ", g_wc2_table3
                  END IF
 
 
                  IF g_wc2_extend <> " 1=1" AND NOT cl_null(g_wc2_extend) THEN
                     LET g_wc2 = g_wc2 ," AND ", g_wc2_extend
                  END IF
                  IF g_wc2.subString(1,5) = " AND " THEN
                     LET g_wc2 = g_wc2.subString(6,g_wc2.getLength())
                  END IF
                  #取得條件後需要重查、跳到結果第一筆資料的功能程式段
                  CALL aapt510_browser_fill("F")
                  IF g_browser_cnt = 0 THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "" 
                     LET g_errparam.code = "-100" 
                     LET g_errparam.popup = TRUE 
                     CALL cl_err()
                     CLEAR FORM
                  ELSE
                     CALL aapt510_fetch("F")
                  END IF
               END IF
            END IF
            #重新搜尋會將notice區塊清空,此處不可用EXIT DIALOG, SUBDIALOG重讀會導致部分變數消失
            CALL cl_notice()
          
         #應用 a49 樣板自動產生(Version:4)
            #過濾瀏覽頁資料
            ON ACTION filter
               LET g_action_choice = "fetch"
               #add-point:filter action name="ui_dialog.action.filter"
               
               #end add-point
               CALL aapt510_filter()
               EXIT DIALOG
 
 
 
         
         ON ACTION first
            LET g_action_choice = "fetch"
            CALL aapt510_fetch('F')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL aapt510_idx_chk()
            
         ON ACTION previous
            LET g_action_choice = "fetch"
            CALL aapt510_fetch('P')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL aapt510_idx_chk()
            
         ON ACTION jump
            LET g_action_choice = "fetch"
            CALL aapt510_fetch('/')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL aapt510_idx_chk()
            
         ON ACTION next
            LET g_action_choice = "fetch"
            CALL aapt510_fetch('N')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL aapt510_idx_chk()
            
         ON ACTION last
            LET g_action_choice = "fetch"
            CALL aapt510_fetch('L')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL aapt510_idx_chk()
          
         #excel匯出功能          
         ON ACTION exporttoexcel
            LET g_action_choice="exporttoexcel"
            IF cl_auth_chk_act("exporttoexcel") THEN
               #browser
               CALL g_export_node.clear()
               IF g_main_hidden = 1 THEN
                  LET g_export_node[1] = base.typeInfo.create(g_browser)
                  LET g_export_id[1]   = "s_browse"
                  CALL cl_export_to_excel()
               #非browser
               ELSE
                  LET g_export_node[1] = base.typeInfo.create(g_apgb_d)
                  LET g_export_id[1]   = "s_detail1"
                  LET g_export_node[2] = base.typeInfo.create(g_apgb2_d)
                  LET g_export_id[2]   = "s_detail2"
                  LET g_export_node[3] = base.typeInfo.create(g_apgb3_d)
                  LET g_export_id[3]   = "s_detail3"
 
                  #add-point:ON ACTION exporttoexcel name="menu.exporttoexcel"
                  
                  #END add-point
                  CALL cl_export_to_excel_getpage()
                  CALL cl_export_to_excel()
               END IF
            END IF
        
         ON ACTION close
            LET INT_FLAG = FALSE
            LET g_action_choice = "exit"
            EXIT DIALOG
          
         ON ACTION exit
            LET g_action_choice = "exit"
            EXIT DIALOG
    
         #主頁摺疊
         ON ACTION mainhidden       
            IF g_main_hidden THEN
               CALL gfrm_curr.setElementHidden("mainlayout",0)
               CALL gfrm_curr.setElementHidden("worksheet",1)
               LET g_main_hidden = 0
            ELSE
               CALL gfrm_curr.setElementHidden("mainlayout",1)
               CALL gfrm_curr.setElementHidden("worksheet",0)
               LET g_main_hidden = 1
               CALL cl_notice()
            END IF
            
         #瀏覽頁折疊
         ON ACTION worksheethidden   
            IF g_main_hidden THEN
               CALL gfrm_curr.setElementHidden("mainlayout",0)
               CALL gfrm_curr.setElementHidden("worksheet",1)
               LET g_main_hidden = 0
            ELSE
               CALL gfrm_curr.setElementHidden("mainlayout",1)
               CALL gfrm_curr.setElementHidden("worksheet",0)
               LET g_main_hidden = 1
            END IF
            IF lb_first THEN
               LET lb_first = FALSE
               NEXT FIELD apgbseq
            END IF
       
         #單頭摺疊，可利用hot key "Alt-s"開啟/關閉單頭
         ON ACTION controls     
            IF g_header_hidden THEN
               CALL gfrm_curr.setElementHidden("vb_master",0)
               CALL gfrm_curr.setElementImage("controls","small/arr-u.png")
               LET g_header_hidden = 0     #visible
            ELSE
               CALL gfrm_curr.setElementHidden("vb_master",1)
               CALL gfrm_curr.setElementImage("controls","small/arr-d.png")
               LET g_header_hidden = 1     #hidden     
            END IF
    
         
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION modify
            LET g_action_choice="modify"
            IF cl_auth_chk_act("modify") THEN
               LET g_aw = ''
               CALL aapt510_modify()
               #add-point:ON ACTION modify name="menu.modify"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION modify_detail
            LET g_action_choice="modify_detail"
            IF cl_auth_chk_act("modify") THEN
               LET g_aw = g_curr_diag.getCurrentItem()
               CALL aapt510_modify()
               #add-point:ON ACTION modify_detail name="menu.modify_detail"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION delete
            LET g_action_choice="delete"
            IF cl_auth_chk_act("delete") THEN
               CALL aapt510_delete()
               #add-point:ON ACTION delete name="menu.delete"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION insert
            LET g_action_choice="insert"
            IF cl_auth_chk_act("insert") THEN
               CALL aapt510_insert()
               #add-point:ON ACTION insert name="menu.insert"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION output
            LET g_action_choice="output"
            IF cl_auth_chk_act("output") THEN
               
               #add-point:ON ACTION output name="menu.output"
               LET g_rep_wc = " apgaent = '",g_enterprise,"' AND apgacomp = '",g_apga_m.apgacomp,"' AND apgadocno = '",g_apga_m.apgadocno,"' "
               #END add-point
               &include "erp/aap/aapt510_rep.4gl"
               #add-point:ON ACTION output.after name="menu.after_output"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION quickprint
            LET g_action_choice="quickprint"
            IF cl_auth_chk_act("quickprint") THEN
               
               #add-point:ON ACTION quickprint name="menu.quickprint"
               LET g_rep_wc = " apgaent = '",g_enterprise,"' AND apgacomp = '",g_apga_m.apgacomp,"' AND apgadocno = '",g_apga_m.apgadocno,"' "
               #END add-point
               &include "erp/aap/aapt510_rep.4gl"
               #add-point:ON ACTION quickprint.after name="menu.after_quickprint"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION reproduce
            LET g_action_choice="reproduce"
            IF cl_auth_chk_act("reproduce") THEN
               CALL aapt510_reproduce()
               #add-point:ON ACTION reproduce name="menu.reproduce"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION query
            LET g_action_choice="query"
            IF cl_auth_chk_act("query") THEN
               CALL aapt510_query()
               #add-point:ON ACTION query name="menu.query"
               
               #END add-point
               #應用 a59 樣板自動產生(Version:3)  
               CALL g_curr_diag.setCurrentRow("s_detail1",1)
               CALL g_curr_diag.setCurrentRow("s_detail2",1)
               CALL g_curr_diag.setCurrentRow("s_detail3",1)
 
 
 
 
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION reinput
            LET g_action_choice="reinput"
            IF cl_auth_chk_act("reinput") THEN
               
               #add-point:ON ACTION reinput name="menu.reinput"
               IF NOT cl_null(g_apga_m.apgadocno) AND NOT cl_null(g_apga_m.apgacomp)THEN
               
                  LET l_count530 = NULL
                  SELECT COUNT(*) INTO l_count530 FROM apgi_t
                   WHERE apgient = g_enterprise
                     AND apgicomp = g_apga_m.apgacomp
                     AND apgi002  = g_apga_m.apgadocno
                     AND apgistus <> 'X'
                  IF cl_null(l_count530) THEN LET l_count530 = 0 END IF
                  
                  LET l_count540 = NULL
                  SELECT COUNT(*) INTO l_count540 FROM apgk_t
                   WHERE apgkent = g_enterprise
                     AND apgkcomp = g_apga_m.apgacomp
                     AND apgk005  = g_apga_m.apgadocno
                     AND apgkstus <> 'X'
                  IF cl_null(l_count540) THEN LET l_count540 = 0 END IF
                  
                  LET l_count550 = NULL
                  SELECT COUNT(*) INTO l_count550 FROM apgl_t
                   WHERE apglent = g_enterprise
                     AND apglcomp = g_apga_m.apgacomp
                     AND apgl004  = g_apga_m.apgadocno
                     AND apglstus <> 'X'
                  IF cl_null(l_count550) THEN LET l_count550 = 0 END IF
                  
                  IF (l_count530+l_count540+l_count550) = 0 THEN
                     IF g_apga_m.apga002 = '0' AND g_apga_m.apga029 = 'N' THEN
                        CALL aapt510_reinput()
                     ELSE
                        INITIALIZE g_errparam.* TO NULL
                        LET g_errparam.code = 'aap-00447'
                        LET g_errparam.extend = ''
                        LET g_errparam.popup = TRUE
                        CALL cl_err()
                     END IF
                  ELSE
                  
                  END IF
               END IF
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION prog_apga028
            LET g_action_choice="prog_apga028"
            IF cl_auth_chk_act("prog_apga028") THEN
               
               #add-point:ON ACTION prog_apga028 name="menu.prog_apga028"
               #應用 a41 樣板自動產生(Version:3)
               #使用JSON格式組合參數與作業編號(串查)
               IF NOT cl_null(g_apga_m.apga028)THEN
                  INITIALIZE la_param.* TO NULL
                  LET la_param.prog     = 'aapt560'
                  LET la_param.param[3] = g_apga_m.apga028
                  LET ls_js = util.JSON.stringify(la_param)
                  CALL cl_cmdrun_wait(ls_js)
               END IF
               #END add-point
               
            END IF
 
 
 
 
         
         #應用 a46 樣板自動產生(Version:3)
         #新增相關文件
         ON ACTION related_document
            CALL aapt510_set_pk_array()
            IF cl_auth_chk_act("related_document") THEN
               #add-point:ON ACTION related_document name="ui_dialog.dialog.related_document"
               
               #END add-point
               CALL cl_doc()
            END IF
            
         ON ACTION agendum
            CALL aapt510_set_pk_array()
            #add-point:ON ACTION agendum name="ui_dialog.dialog.agendum"
            
            #END add-point
            CALL cl_user_overview()
            CALL cl_user_overview_set_follow_pic()
         
         ON ACTION followup
            CALL aapt510_set_pk_array()
            #add-point:ON ACTION followup name="ui_dialog.dialog.followup"
            
            #END add-point
            CALL cl_user_overview_follow(g_apga_m.apgadocdt)
 
 
 
         
         #主選單用ACTION
         &include "main_menu_exit_dialog.4gl"
         &include "relating_action.4gl"
    
         #交談指令共用ACTION
         &include "common_action.4gl" 
            CONTINUE DIALOG
      END DIALOG
 
      #(ver:79) ---add start---
      #add-point:ui_dialog段 after dialog name="ui_dialog.exit_dialog"
      
      #end add-point
      #(ver:79) --- add end ---
    
      IF g_action_choice = "exit" AND NOT cl_null(g_action_choice) THEN
         #add-point:ui_dialog段離開dialog前 name="ui_dialog.b_exit"
         
         #end add-point
         EXIT WHILE
      END IF
    
   END WHILE    
      
   CALL cl_set_act_visible("accept,cancel", TRUE)
    
END FUNCTION
 
{</section>}
 
{<section id="aapt510.browser_fill" >}
#+ 瀏覽頁簽資料填充
PRIVATE FUNCTION aapt510_browser_fill(ps_page_action)
   #add-point:browser_fill段define(客製用) name="browser_fill.define_customerization"
   
   #end add-point  
   DEFINE ps_page_action    STRING
   DEFINE l_wc              STRING
   DEFINE l_wc2             STRING
   DEFINE l_sql             STRING
   DEFINE l_sub_sql         STRING
   DEFINE l_sql_rank        STRING
   #add-point:browser_fill段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="browser_fill.define"
   
   #end add-point    
   
   #add-point:Function前置處理 name="browser_fill.before_browser_fill"
   
   #end add-point
   
   IF cl_null(g_wc) THEN
      LET g_wc = " 1=1"
   END IF
   IF cl_null(g_wc2) THEN
      LET g_wc2 = " 1=1"
   END IF
   LET l_wc  = g_wc.trim() 
   LET l_wc2 = g_wc2.trim()
 
   #add-point:browser_fill,foreach前 name="browser_fill.before_foreach"
   
   #end add-point
   
   IF g_wc2 <> " 1=1" THEN
      #單身有輸入搜尋條件                      
      LET l_sub_sql = " SELECT DISTINCT apgacomp,apgadocno ",
                      " FROM apga_t ",
                      " ",
                      " LEFT JOIN apgb_t ON apgbent = apgaent AND apgacomp = apgbcomp AND apgadocno = apgbdocno ", "  ",
                      #add-point:browser_fill段sql(apgb_t1) name="browser_fill.cnt.join.}"
                      
                      #end add-point
                      " LEFT JOIN apgc_t ON apgcent = apgaent AND apgacomp = apgccomp AND apgadocno = apgcdocno", "  ",
                      #add-point:browser_fill段sql(apgc_t1) name="browser_fill.cnt.join.apgc_t1"
                      
                      #end add-point
 
                      " LEFT JOIN xrcd_t ON xrcdent = apgaent AND apgacomp = xrcdcomp AND apgadocno = xrcddocno", "  ",
                      #add-point:browser_fill段sql(xrcd_t1) name="browser_fill.cnt.join.xrcd_t1"
                      
                      #end add-point
 
 
 
                      " ", 
                      " ", 
                      " ",                      
 
                      " ",                      
 
 
 
                      " WHERE apgaent = " ||g_enterprise|| " AND apgbent = " ||g_enterprise|| " AND ",l_wc, " AND ", l_wc2, cl_sql_add_filter("apga_t")
   ELSE
      #單身未輸入搜尋條件
      LET l_sub_sql = " SELECT DISTINCT apgacomp,apgadocno ",
                      " FROM apga_t ", 
                      "  ",
                      "  ",
                      " WHERE apgaent = " ||g_enterprise|| " AND ",l_wc CLIPPED, cl_sql_add_filter("apga_t")
   END IF
   
   #add-point:browser_fill,cnt wc name="browser_fill.cnt_sqlwc"
   
   #end add-point
   
   LET g_sql = " SELECT COUNT(1) FROM (",l_sub_sql,")"
   
   #add-point:browser_fill,count前 name="browser_fill.before_count"
   
   #end add-point
   
   IF g_sql.getIndexOf(" 1=2",1) THEN
      DISPLAY "INFO: 1=2 jumped!"
   ELSE
      PREPARE header_cnt_pre FROM g_sql
      EXECUTE header_cnt_pre INTO g_browser_cnt   #總筆數
      FREE header_cnt_pre
   END IF
    
   IF g_browser_cnt > g_max_browse THEN
      IF g_error_show = 1 THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = g_browser_cnt
         LET g_errparam.code = 9035 
         LET g_errparam.popup = TRUE 
         CALL cl_err()
      END IF
      LET g_browser_cnt = g_max_browse
   END IF
   
   DISPLAY g_browser_cnt TO FORMONLY.b_count   #總筆數的顯示
   DISPLAY g_browser_cnt TO FORMONLY.h_count   #總筆數的顯示
 
   #根據行為確定資料填充位置及WC
   IF cl_null(g_add_browse) THEN
      #清除畫面
      CLEAR FORM                
      INITIALIZE g_apga_m.* TO NULL
      CALL g_apgb_d.clear()        
      CALL g_apgb2_d.clear() 
      CALL g_apgb3_d.clear() 
 
      #add-point:browser_fill g_add_browse段額外處理 name="browser_fill.add_browse.other"
      
      #end add-point   
      CALL g_browser.clear()
      LET g_cnt = 1
   ELSE
      LET l_wc  = g_add_browse
      LET l_wc2 = " 1=1" 
      LET g_cnt = g_current_idx
   END IF
 
   #依照t0.apgacomp,t0.apgadocno Browser欄位定義(取代原本bs_sql功能)
   #考量到單身可能下條件, 所以此處需join單身所有table
   #DISTINCT是為了避免在join時出現重複的資料(如果不加DISTINCT則須在程式中過濾)
   IF g_wc2 <> " 1=1" THEN
      #單身有輸入搜尋條件   
      LET g_sql = " SELECT DISTINCT t0.apgastus,t0.apgacomp,t0.apgadocno ",
                  " FROM apga_t t0",
                  "  ",
                  "  LEFT JOIN apgb_t ON apgbent = apgaent AND apgacomp = apgbcomp AND apgadocno = apgbdocno ", "  ", 
                  #add-point:browser_fill段sql(apgb_t1) name="browser_fill.join.apgb_t1"
                  
                  #end add-point
                  "  LEFT JOIN apgc_t ON apgcent = apgaent AND apgacomp = apgccomp AND apgadocno = apgcdocno", "  ", 
                  #add-point:browser_fill段sql(apgc_t1) name="browser_fill.join.apgc_t1"
                  
                  #end add-point
 
                  "  LEFT JOIN xrcd_t ON xrcdent = apgaent AND apgacomp = xrcdcomp AND apgadocno = xrcddocno", "  ", 
                  #add-point:browser_fill段sql(xrcd_t1) name="browser_fill.join.xrcd_t1"
                  
                  #end add-point
 
 
 
                  " ", 
                  " ",                      
 
                  " ",                      
 
 
 
                  
                  " WHERE t0.apgaent = " ||g_enterprise|| " AND ",l_wc," AND ",l_wc2, cl_sql_add_filter("apga_t")
   ELSE
      #單身無輸入搜尋條件   
      LET g_sql = " SELECT DISTINCT t0.apgastus,t0.apgacomp,t0.apgadocno ",
                  " FROM apga_t t0",
                  "  ",
                  
                  " WHERE t0.apgaent = " ||g_enterprise|| " AND ",l_wc, cl_sql_add_filter("apga_t")
   END IF
   #add-point:browser_fill,sql wc name="browser_fill.fill_sqlwc"
   #161115-00042#5-add(s)
   IF NOT cl_null(g_sql_ctrl) AND NOT g_sql_ctrl = ' 1=1'  THEN
      LET g_sql = g_sql," AND EXISTS (SELECT 1 FROM pmaa_t ",
                        "              WHERE pmaaent = ",g_enterprise,
                        "                AND ",g_sql_ctrl,
                        "                AND pmaaent = apgaent ",
                        "                AND pmaa001 = apga004 )"
   END IF
   #161115-00042#5-add(e)
   #end add-point
   LET g_sql = g_sql, " ORDER BY apgacomp,apgadocno ",g_order
 
   #add-point:browser_fill,before_prepare name="browser_fill.before_prepare"
   
   #end add-point
        
   #LET g_sql = cl_sql_add_tabid(g_sql,"apga_t") #WC重組
   LET g_sql = cl_sql_add_mask(g_sql) #遮蔽特定資料
   
   IF g_sql.getIndexOf(" 1=2",1) THEN
      DISPLAY "INFO: 1=2 jumped!"
   ELSE
      PREPARE browse_pre FROM g_sql
      DECLARE browse_cur CURSOR FOR browse_pre
      
      #add-point:browser_fill段open cursor name="browser_fill.open"
      
      #end add-point
      
      FOREACH browse_cur INTO g_browser[g_cnt].b_statepic,g_browser[g_cnt].b_apgacomp,g_browser[g_cnt].b_apgadocno 
 
         IF SQLCA.SQLCODE THEN
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "Foreach:",SQLERRMESSAGE 
            LET g_errparam.code = SQLCA.SQLCODE 
            LET g_errparam.popup = TRUE 
            CALL cl_err()
            EXIT FOREACH
         END IF
      
         #add-point:browser_fill段reference name="browser_fill.reference"
         
         #end add-point
      
         #遮罩相關處理
         CALL aapt510_browser_mask()
      
               #應用 a24 樣板自動產生(Version:3)
      #browser顯示圖片
      CASE g_browser[g_cnt].b_statepic
         WHEN "N"
            LET g_browser[g_cnt].b_statepic = "stus/16/unconfirmed.png"
         WHEN "Y"
            LET g_browser[g_cnt].b_statepic = "stus/16/confirmed.png"
         WHEN "A"
            LET g_browser[g_cnt].b_statepic = "stus/16/approved.png"
         WHEN "D"
            LET g_browser[g_cnt].b_statepic = "stus/16/withdraw.png"
         WHEN "R"
            LET g_browser[g_cnt].b_statepic = "stus/16/rejection.png"
         WHEN "W"
            LET g_browser[g_cnt].b_statepic = "stus/16/signing.png"
         WHEN "X"
            LET g_browser[g_cnt].b_statepic = "stus/16/invalid.png"
         
      END CASE
 
 
 
         LET g_cnt = g_cnt + 1
         IF g_cnt > g_max_browse THEN
            EXIT FOREACH
         END IF
         
      END FOREACH
      FREE browse_pre
   END IF
   
   #清空g_add_browse, 並指定指標位置
   IF NOT cl_null(g_add_browse) THEN
      LET g_add_browse = ""
      CALL g_curr_diag.setCurrentRow("s_browse",g_current_idx)
   END IF
   
   IF cl_null(g_browser[g_cnt].b_apgacomp) THEN
      CALL g_browser.deleteElement(g_cnt)
   END IF
   
   LET g_header_cnt  = g_browser.getLength()
   LET g_browser_cnt = g_browser.getLength()
   
   #筆數顯示
   IF g_browser_cnt > 0 THEN
      DISPLAY g_browser_idx TO FORMONLY.b_index #當下筆數
      DISPLAY g_browser_cnt TO FORMONLY.b_count #總筆數
      DISPLAY g_browser_idx TO FORMONLY.h_index #當下筆數
      DISPLAY g_browser_cnt TO FORMONLY.h_count #總筆數
      DISPLAY g_detail_idx  TO FORMONLY.idx     #單身當下筆數
      DISPLAY g_detail_cnt  TO FORMONLY.cnt     #單身總筆數
   ELSE
      DISPLAY '' TO FORMONLY.b_index #當下筆數
      DISPLAY '' TO FORMONLY.b_count #總筆數
      DISPLAY '' TO FORMONLY.h_index #當下筆數
      DISPLAY '' TO FORMONLY.h_count #總筆數
      DISPLAY '' TO FORMONLY.idx     #單身當下筆數
      DISPLAY '' TO FORMONLY.cnt     #單身總筆數
   END IF
 
   LET g_rec_b = g_cnt - 1
   LET g_detail_cnt = g_rec_b
   LET g_cnt = 0
 
   #若無資料則關閉相關功能
   IF g_browser_cnt = 0 THEN
      CALL cl_set_act_visible("statechange,modify,modify_detail,delete,reproduce,mainhidden", FALSE)
      CALL cl_navigator_setting(0,0)
   ELSE
      CALL cl_set_act_visible("mainhidden", TRUE)
   END IF
                  
   
   #add-point:browser_fill段結束前 name="browser_fill.after"
   
   #end add-point   
 
END FUNCTION
 
{</section>}
 
{<section id="aapt510.ui_headershow" >}
#+ 單頭資料重新顯示
PRIVATE FUNCTION aapt510_ui_headershow()
   #add-point:ui_headershow段define(客製用) name="ui_headershow.define_customerization"
   
   #end add-point  
   #add-point:ui_headershow段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="ui_headershow.define"
   
   #end add-point      
   
   #add-point:Function前置處理  name="ui_headershow.pre_function"
   
   #end add-point
   
   LET g_apga_m.apgacomp = g_browser[g_current_idx].b_apgacomp   
   LET g_apga_m.apgadocno = g_browser[g_current_idx].b_apgadocno   
 
   EXECUTE aapt510_master_referesh USING g_apga_m.apgacomp,g_apga_m.apgadocno INTO g_apga_m.apgacomp, 
       g_apga_m.apga005,g_apga_m.apga006,g_apga_m.apgadocno,g_apga_m.apga002,g_apga_m.apgadocdt,g_apga_m.apga003, 
       g_apga_m.apga004,g_apga_m.apga001,g_apga_m.apga028,g_apga_m.apga029,g_apga_m.apgastus,g_apga_m.apgaownid, 
       g_apga_m.apgaowndp,g_apga_m.apgacrtid,g_apga_m.apgacrtdp,g_apga_m.apgacrtdt,g_apga_m.apgamodid, 
       g_apga_m.apgamoddt,g_apga_m.apgacnfid,g_apga_m.apgacnfdt,g_apga_m.apgapstid,g_apga_m.apgapstdt, 
       g_apga_m.apga007,g_apga_m.apga030,g_apga_m.apga008,g_apga_m.apga009,g_apga_m.apga013,g_apga_m.apga012, 
       g_apga_m.apga010,g_apga_m.apga014,g_apga_m.apga011,g_apga_m.apga100,g_apga_m.apga015,g_apga_m.apga103, 
       g_apga_m.apga104,g_apga_m.apga108,g_apga_m.apga102,g_apga_m.apga026,g_apga_m.apga040,g_apga_m.apga109, 
       g_apga_m.apga101,g_apga_m.apga113,g_apga_m.apga114,g_apga_m.apga118,g_apga_m.apga112,g_apga_m.apga105, 
       g_apga_m.apga016,g_apga_m.apga017,g_apga_m.apga018,g_apga_m.apga115,g_apga_m.apga106,g_apga_m.apga107, 
       g_apga_m.apga019,g_apga_m.apga020,g_apga_m.apga021,g_apga_m.apga022,g_apga_m.apga023,g_apga_m.apga024, 
       g_apga_m.apga025,g_apga_m.apga036,g_apga_m.apga037,g_apga_m.apga032,g_apga_m.apga034,g_apga_m.apga035, 
       g_apga_m.apga031,g_apga_m.apga038,g_apga_m.apga039,g_apga_m.apga033,g_apga_m.apga027,g_apga_m.apgacomp_desc, 
       g_apga_m.apga005_desc,g_apga_m.apga004_desc,g_apga_m.apgaownid_desc,g_apga_m.apgaowndp_desc,g_apga_m.apgacrtid_desc, 
       g_apga_m.apgacrtdp_desc,g_apga_m.apgamodid_desc,g_apga_m.apgacnfid_desc,g_apga_m.apgapstid_desc, 
       g_apga_m.apga007_desc,g_apga_m.apga030_desc,g_apga_m.apga020_desc,g_apga_m.apga036_desc,g_apga_m.apga037_desc, 
       g_apga_m.apga034_desc,g_apga_m.apga035_desc,g_apga_m.apga038_desc,g_apga_m.apga039_desc
   
   CALL aapt510_apga_t_mask()
   CALL aapt510_show()
      
END FUNCTION
 
{</section>}
 
{<section id="aapt510.ui_detailshow" >}
#+ 單身資料重新顯示
PRIVATE FUNCTION aapt510_ui_detailshow()
   #add-point:ui_detailshow段define(客製用) name="ui_detailshow.define_customerization"
   
   #end add-point    
   #add-point:ui_detailshow段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="ui_detailshow.define"
   
   #end add-point    
 
   #add-point:Function前置處理 name="ui_detailshow.before"
   
   #end add-point    
   
   IF g_curr_diag IS NOT NULL THEN
      CALL g_curr_diag.setCurrentRow("s_detail1",g_detail_idx)      
      CALL g_curr_diag.setCurrentRow("s_detail2",g_detail_idx)
      CALL g_curr_diag.setCurrentRow("s_detail3",g_detail_idx)
 
   END IF
   
   #add-point:ui_detailshow段after name="ui_detailshow.after"
   
   #end add-point    
   
END FUNCTION
 
{</section>}
 
{<section id="aapt510.ui_browser_refresh" >}
#+ 瀏覽頁簽資料重新顯示
PRIVATE FUNCTION aapt510_ui_browser_refresh()
   #add-point:ui_browser_refresh段define(客製用) name="ui_browser_refresh.define_customerization"
   
   #end add-point    
   DEFINE l_i  LIKE type_t.num10
   #add-point:ui_browser_refresh段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="ui_browser_refresh.define"
   
   #end add-point    
   
   #add-point:Function前置處理  name="ui_browser_refresh.pre_function"
   
   #end add-point
   
   LET g_browser_cnt = g_browser.getLength()
   LET g_header_cnt  = g_browser.getLength()
   FOR l_i =1 TO g_browser.getLength()
      IF g_browser[l_i].b_apgacomp = g_apga_m.apgacomp 
         AND g_browser[l_i].b_apgadocno = g_apga_m.apgadocno 
 
         THEN
         CALL g_browser.deleteElement(l_i)
         EXIT FOR
      END IF
   END FOR
   LET g_browser_cnt = g_browser_cnt - 1
   LET g_header_cnt = g_header_cnt - 1
    
   #若無資料則關閉相關功能
   IF g_browser_cnt = 0 THEN
      CALL cl_set_act_visible("statechange,modify,modify_detail,delete,reproduce,mainhidden", FALSE)
      CALL cl_navigator_setting(0,0)
      CLEAR FORM
   ELSE
      CALL cl_set_act_visible("mainhidden", TRUE)
   END IF
   
   #add-point:ui_browser_refresh段after name="ui_browser_refresh.after"
   
   #end add-point    
   
END FUNCTION
 
{</section>}
 
{<section id="aapt510.construct" >}
#+ QBE資料查詢
PRIVATE FUNCTION aapt510_construct()
   #add-point:cs段define(客製用) name="cs.define_customerization"
   
   #end add-point    
   DEFINE ls_return   STRING
   DEFINE ls_result   STRING 
   DEFINE ls_wc       STRING 
   DEFINE la_wc       DYNAMIC ARRAY OF RECORD
          tableid     STRING,
          wc          STRING
          END RECORD
   DEFINE li_idx      LIKE type_t.num10
   #add-point:cs段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="cs.define"
   DEFINE l_ooef019   LIKE ooef_t.ooef019
   DEFINE l_ld_str    STRING #161115-00042#5-add
   #end add-point    
   
   #add-point:Function前置處理  name="cs.pre_function"
   
   #end add-point
    
   #清除畫面
   CLEAR FORM                
   INITIALIZE g_apga_m.* TO NULL
   CALL g_apgb_d.clear()        
   CALL g_apgb2_d.clear() 
   CALL g_apgb3_d.clear() 
 
   
   LET g_action_choice = ""
    
   INITIALIZE g_wc TO NULL
   INITIALIZE g_wc2 TO NULL
   
   INITIALIZE g_wc2_table1 TO NULL
   INITIALIZE g_wc2_table2 TO NULL
 
   INITIALIZE g_wc2_table3 TO NULL
 
 
    
   LET g_qryparam.state = 'c'
   
   #add-point:cs段開始前 name="cs.before_construct"
   
   #end add-point 
   
   #使用DIALOG包住 單頭CONSTRUCT及單身CONSTRUCT
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
      
      #單頭
      CONSTRUCT BY NAME g_wc ON apgacomp,apga005,apga006,apgadocno,apga002,apgadocdt,apga003,apga004, 
          apga001,apga028,apga029,apgastus,apgaownid,apgaowndp,apgacrtid,apgacrtdp,apgacrtdt,apgamodid, 
          apgamoddt,apgacnfid,apgacnfdt,apgapstid,apgapstdt,apga007,apga030,apga008,apga009,apga013, 
          apga012,apga010,apga014,apga011,apga100,apga015,apga103,apga104,apga108,apga102,apga026,apga040, 
          apga109,glaa001,apga101,apga113,apga114,apga118,apga112,apga105,apga016,apga017,apga018,apga115, 
          apga106,apga107,apga019,apga020,apga021,apga022,apga023,apga024,apga025,l_apga1041,apga036, 
          apga037,apga032,l_apga1081,apga034,apga035,apga031,l_apga1021,apga038,apga039,apga033,apga027 
 
 
         BEFORE CONSTRUCT
            #add-point:cs段before_construct name="cs.head.before_construct"
            
            #end add-point 
            
         #公用欄位開窗相關處理
         #應用 a11 樣板自動產生(Version:3)
         #共用欄位查詢處理  
         ##----<<apgacrtdt>>----
         AFTER FIELD apgacrtdt
            CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
            IF NOT cl_null(ls_result) THEN
               IF NOT cl_chk_date_symbol(ls_result) THEN
                  LET ls_result = cl_add_date_extra_cond(ls_result)
               END IF
            END IF
            CALL FGL_DIALOG_SETBUFFER(ls_result)
 
         #----<<apgamoddt>>----
         AFTER FIELD apgamoddt
            CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
            IF NOT cl_null(ls_result) THEN
               IF NOT cl_chk_date_symbol(ls_result) THEN
                  LET ls_result = cl_add_date_extra_cond(ls_result)
               END IF
            END IF
            CALL FGL_DIALOG_SETBUFFER(ls_result)
         
         #----<<apgacnfdt>>----
         AFTER FIELD apgacnfdt
            CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
            IF NOT cl_null(ls_result) THEN
               IF NOT cl_chk_date_symbol(ls_result) THEN
                  LET ls_result = cl_add_date_extra_cond(ls_result)
               END IF
            END IF
            CALL FGL_DIALOG_SETBUFFER(ls_result)
         
         #----<<apgapstdt>>----
         AFTER FIELD apgapstdt
            CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
            IF NOT cl_null(ls_result) THEN
               IF NOT cl_chk_date_symbol(ls_result) THEN
                  LET ls_result = cl_add_date_extra_cond(ls_result)
               END IF
            END IF
            CALL FGL_DIALOG_SETBUFFER(ls_result)
 
 
 
            
         #一般欄位開窗相關處理    
                  #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apgacomp
            #add-point:BEFORE FIELD apgacomp name="construct.b.apgacomp"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apgacomp
            
            #add-point:AFTER FIELD apgacomp name="construct.a.apgacomp"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.apgacomp
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apgacomp
            #add-point:ON ACTION controlp INFIELD apgacomp name="construct.c.apgacomp"
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.where = " ooef003 = 'Y' "  #160824-00049#1
            IF NOT cl_null(g_wc_cs_comp)THEN
               #LET g_qryparam.where = " ooef001 IN ",g_wc_cs_comp   #160824-00049#1 mark
               LET g_qryparam.where = g_qryparam.where CLIPPED," AND ooef001 IN ",g_wc_cs_comp                   #160824-00049#1 add
            END IF
            CALL q_ooef001()
            DISPLAY g_qryparam.return1 TO apgacomp
            NEXT FIELD apgacomp
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apga005
            #add-point:BEFORE FIELD apga005 name="construct.b.apga005"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apga005
            
            #add-point:AFTER FIELD apga005 name="construct.a.apga005"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.apga005
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apga005
            #add-point:ON ACTION controlp INFIELD apga005 name="construct.c.apga005"
            #業務員
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001_8()
            DISPLAY g_qryparam.return1 TO apga005
            NEXT FIELD apga005
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apga006
            #add-point:BEFORE FIELD apga006 name="construct.b.apga006"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apga006
            
            #add-point:AFTER FIELD apga006 name="construct.a.apga006"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.apga006
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apga006
            #add-point:ON ACTION controlp INFIELD apga006 name="construct.c.apga006"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apgadocno
            #add-point:BEFORE FIELD apgadocno name="construct.b.apgadocno"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apgadocno
            
            #add-point:AFTER FIELD apgadocno name="construct.a.apgadocno"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.apgadocno
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apgadocno
            #add-point:ON ACTION controlp INFIELD apgadocno name="construct.c.apgadocno"
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.where = " apgacomp IN ",g_wc_cs_comp   #160824-00049#1
            #161115-00042#5-add(S)
            IF NOT cl_null(g_sql_ctrl) AND NOT g_sql_ctrl = ' 1=1'  THEN
               LET g_qryparam.where = g_qryparam.where," AND EXISTS (SELECT 1 FROM pmaa_t ",
                                                       "              WHERE pmaaent = ",g_enterprise,
                                                       "                AND ",g_sql_ctrl,
                                                       "                AND pmaaent = apgaent ",
                                                       "                AND pmaa001 = apga004 )"
            END IF
            #161115-00042#5-add(E)
            #161104-00046#7 --s add
            #單別權限控管
            IF NOT cl_null(g_user_dept_wc_q) AND NOT g_user_dept_wc_q = ' 1=1'  THEN
               LET g_qryparam.where = g_qryparam.where," AND ",g_user_dept_wc_q CLIPPED
            END IF
            #161104-00046#7 --e add 
            CALL q_apgadocno()
            DISPLAY g_qryparam.return1 TO apgadocno
            NEXT FIELD apgadocno
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apga002
            #add-point:BEFORE FIELD apga002 name="construct.b.apga002"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apga002
            
            #add-point:AFTER FIELD apga002 name="construct.a.apga002"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.apga002
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apga002
            #add-point:ON ACTION controlp INFIELD apga002 name="construct.c.apga002"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apgadocdt
            #add-point:BEFORE FIELD apgadocdt name="construct.b.apgadocdt"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apgadocdt
            
            #add-point:AFTER FIELD apgadocdt name="construct.a.apgadocdt"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.apgadocdt
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apgadocdt
            #add-point:ON ACTION controlp INFIELD apgadocdt name="construct.c.apgadocdt"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apga003
            #add-point:BEFORE FIELD apga003 name="construct.b.apga003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apga003
            
            #add-point:AFTER FIELD apga003 name="construct.a.apga003"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.apga003
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apga003
            #add-point:ON ACTION controlp INFIELD apga003 name="construct.c.apga003"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apga004
            #add-point:BEFORE FIELD apga004 name="construct.b.apga004"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apga004
            
            #add-point:AFTER FIELD apga004 name="construct.a.apga004"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.apga004
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apga004
            #add-point:ON ACTION controlp INFIELD apga004 name="construct.c.apga004"
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.arg1 = "('1','3')"
            IF NOT cl_null(g_sql_ctrl) AND NOT g_sql_ctrl = ' 1=1'  THEN
               LET g_qryparam.where = g_sql_ctrl
            END IF
            CALL q_pmaa001_1()
            DISPLAY g_qryparam.return1 TO apga004      #顯示到畫面上
            NEXT FIELD apga004
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apga001
            #add-point:BEFORE FIELD apga001 name="construct.b.apga001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apga001
            
            #add-point:AFTER FIELD apga001 name="construct.a.apga001"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.apga001
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apga001
            #add-point:ON ACTION controlp INFIELD apga001 name="construct.c.apga001"
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.where = "apga001 IS NOT NULL "
            CALL q_apga001()
            DISPLAY g_qryparam.return1 TO apga001
            NEXT FIELD apga001
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apga028
            #add-point:BEFORE FIELD apga028 name="construct.b.apga028"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apga028
            
            #add-point:AFTER FIELD apga028 name="construct.a.apga028"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.apga028
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apga028
            #add-point:ON ACTION controlp INFIELD apga028 name="construct.c.apga028"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apga029
            #add-point:BEFORE FIELD apga029 name="construct.b.apga029"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apga029
            
            #add-point:AFTER FIELD apga029 name="construct.a.apga029"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.apga029
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apga029
            #add-point:ON ACTION controlp INFIELD apga029 name="construct.c.apga029"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apgastus
            #add-point:BEFORE FIELD apgastus name="construct.b.apgastus"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apgastus
            
            #add-point:AFTER FIELD apgastus name="construct.a.apgastus"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.apgastus
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apgastus
            #add-point:ON ACTION controlp INFIELD apgastus name="construct.c.apgastus"
            
            #END add-point
 
 
         #Ctrlp:construct.c.apgaownid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apgaownid
            #add-point:ON ACTION controlp INFIELD apgaownid name="construct.c.apgaownid"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO apgaownid  #顯示到畫面上
            NEXT FIELD apgaownid                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apgaownid
            #add-point:BEFORE FIELD apgaownid name="construct.b.apgaownid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apgaownid
            
            #add-point:AFTER FIELD apgaownid name="construct.a.apgaownid"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.apgaowndp
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apgaowndp
            #add-point:ON ACTION controlp INFIELD apgaowndp name="construct.c.apgaowndp"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooeg001_9()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO apgaowndp  #顯示到畫面上
            NEXT FIELD apgaowndp                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apgaowndp
            #add-point:BEFORE FIELD apgaowndp name="construct.b.apgaowndp"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apgaowndp
            
            #add-point:AFTER FIELD apgaowndp name="construct.a.apgaowndp"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.apgacrtid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apgacrtid
            #add-point:ON ACTION controlp INFIELD apgacrtid name="construct.c.apgacrtid"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO apgacrtid  #顯示到畫面上
            NEXT FIELD apgacrtid                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apgacrtid
            #add-point:BEFORE FIELD apgacrtid name="construct.b.apgacrtid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apgacrtid
            
            #add-point:AFTER FIELD apgacrtid name="construct.a.apgacrtid"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.apgacrtdp
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apgacrtdp
            #add-point:ON ACTION controlp INFIELD apgacrtdp name="construct.c.apgacrtdp"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooeg001_9()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO apgacrtdp  #顯示到畫面上
            NEXT FIELD apgacrtdp                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apgacrtdp
            #add-point:BEFORE FIELD apgacrtdp name="construct.b.apgacrtdp"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apgacrtdp
            
            #add-point:AFTER FIELD apgacrtdp name="construct.a.apgacrtdp"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apgacrtdt
            #add-point:BEFORE FIELD apgacrtdt name="construct.b.apgacrtdt"
            
            #END add-point
 
 
         #Ctrlp:construct.c.apgamodid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apgamodid
            #add-point:ON ACTION controlp INFIELD apgamodid name="construct.c.apgamodid"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO apgamodid  #顯示到畫面上
            NEXT FIELD apgamodid                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apgamodid
            #add-point:BEFORE FIELD apgamodid name="construct.b.apgamodid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apgamodid
            
            #add-point:AFTER FIELD apgamodid name="construct.a.apgamodid"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apgamoddt
            #add-point:BEFORE FIELD apgamoddt name="construct.b.apgamoddt"
            
            #END add-point
 
 
         #Ctrlp:construct.c.apgacnfid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apgacnfid
            #add-point:ON ACTION controlp INFIELD apgacnfid name="construct.c.apgacnfid"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO apgacnfid  #顯示到畫面上
            NEXT FIELD apgacnfid                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apgacnfid
            #add-point:BEFORE FIELD apgacnfid name="construct.b.apgacnfid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apgacnfid
            
            #add-point:AFTER FIELD apgacnfid name="construct.a.apgacnfid"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apgacnfdt
            #add-point:BEFORE FIELD apgacnfdt name="construct.b.apgacnfdt"
            
            #END add-point
 
 
         #Ctrlp:construct.c.apgapstid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apgapstid
            #add-point:ON ACTION controlp INFIELD apgapstid name="construct.c.apgapstid"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO apgapstid  #顯示到畫面上
            NEXT FIELD apgapstid                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apgapstid
            #add-point:BEFORE FIELD apgapstid name="construct.b.apgapstid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apgapstid
            
            #add-point:AFTER FIELD apgapstid name="construct.a.apgapstid"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apgapstdt
            #add-point:BEFORE FIELD apgapstdt name="construct.b.apgapstdt"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apga007
            #add-point:BEFORE FIELD apga007 name="construct.b.apga007"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apga007
            
            #add-point:AFTER FIELD apga007 name="construct.a.apga007"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.apga007
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apga007
            #add-point:ON ACTION controlp INFIELD apga007 name="construct.c.apga007"
            #銀行
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_nmab001()                      
            DISPLAY g_qryparam.return1 TO apga007
            NEXT FIELD apga007 
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apga030
            #add-point:BEFORE FIELD apga030 name="construct.b.apga030"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apga030
            
            #add-point:AFTER FIELD apga030 name="construct.a.apga030"
 
            #END add-point
            
 
 
         #Ctrlp:construct.c.apga030
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apga030
            #add-point:ON ACTION controlp INFIELD apga030 name="construct.c.apga030"
            #銀行
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_nmab001()                      
            DISPLAY g_qryparam.return1 TO apga030
            NEXT FIELD apga030
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apga008
            #add-point:BEFORE FIELD apga008 name="construct.b.apga008"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apga008
            
            #add-point:AFTER FIELD apga008 name="construct.a.apga008"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.apga008
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apga008
            #add-point:ON ACTION controlp INFIELD apga008 name="construct.c.apga008"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apga009
            #add-point:BEFORE FIELD apga009 name="construct.b.apga009"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apga009
            
            #add-point:AFTER FIELD apga009 name="construct.a.apga009"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.apga009
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apga009
            #add-point:ON ACTION controlp INFIELD apga009 name="construct.c.apga009"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apga013
            #add-point:BEFORE FIELD apga013 name="construct.b.apga013"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apga013
            
            #add-point:AFTER FIELD apga013 name="construct.a.apga013"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.apga013
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apga013
            #add-point:ON ACTION controlp INFIELD apga013 name="construct.c.apga013"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apga012
            #add-point:BEFORE FIELD apga012 name="construct.b.apga012"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apga012
            
            #add-point:AFTER FIELD apga012 name="construct.a.apga012"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.apga012
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apga012
            #add-point:ON ACTION controlp INFIELD apga012 name="construct.c.apga012"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apga010
            #add-point:BEFORE FIELD apga010 name="construct.b.apga010"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apga010
            
            #add-point:AFTER FIELD apga010 name="construct.a.apga010"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.apga010
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apga010
            #add-point:ON ACTION controlp INFIELD apga010 name="construct.c.apga010"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apga014
            #add-point:BEFORE FIELD apga014 name="construct.b.apga014"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apga014
            
            #add-point:AFTER FIELD apga014 name="construct.a.apga014"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.apga014
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apga014
            #add-point:ON ACTION controlp INFIELD apga014 name="construct.c.apga014"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apga011
            #add-point:BEFORE FIELD apga011 name="construct.b.apga011"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apga011
            
            #add-point:AFTER FIELD apga011 name="construct.a.apga011"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.apga011
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apga011
            #add-point:ON ACTION controlp INFIELD apga011 name="construct.c.apga011"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apga100
            #add-point:BEFORE FIELD apga100 name="construct.b.apga100"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apga100
            
            #add-point:AFTER FIELD apga100 name="construct.a.apga100"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.apga100
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apga100
            #add-point:ON ACTION controlp INFIELD apga100 name="construct.c.apga100"
		      INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			   LET g_qryparam.reqry = FALSE
            CALL q_ooai001()                     
            DISPLAY g_qryparam.return1 TO apga100  #顯示到畫面上
            NEXT FIELD apga100 
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apga015
            #add-point:BEFORE FIELD apga015 name="construct.b.apga015"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apga015
            
            #add-point:AFTER FIELD apga015 name="construct.a.apga015"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.apga015
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apga015
            #add-point:ON ACTION controlp INFIELD apga015 name="construct.c.apga015"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apga103
            #add-point:BEFORE FIELD apga103 name="construct.b.apga103"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apga103
            
            #add-point:AFTER FIELD apga103 name="construct.a.apga103"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.apga103
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apga103
            #add-point:ON ACTION controlp INFIELD apga103 name="construct.c.apga103"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apga104
            #add-point:BEFORE FIELD apga104 name="construct.b.apga104"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apga104
            
            #add-point:AFTER FIELD apga104 name="construct.a.apga104"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.apga104
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apga104
            #add-point:ON ACTION controlp INFIELD apga104 name="construct.c.apga104"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apga108
            #add-point:BEFORE FIELD apga108 name="construct.b.apga108"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apga108
            
            #add-point:AFTER FIELD apga108 name="construct.a.apga108"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.apga108
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apga108
            #add-point:ON ACTION controlp INFIELD apga108 name="construct.c.apga108"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apga102
            #add-point:BEFORE FIELD apga102 name="construct.b.apga102"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apga102
            
            #add-point:AFTER FIELD apga102 name="construct.a.apga102"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.apga102
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apga102
            #add-point:ON ACTION controlp INFIELD apga102 name="construct.c.apga102"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apga026
            #add-point:BEFORE FIELD apga026 name="construct.b.apga026"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apga026
            
            #add-point:AFTER FIELD apga026 name="construct.a.apga026"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.apga026
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apga026
            #add-point:ON ACTION controlp INFIELD apga026 name="construct.c.apga026"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apga040
            #add-point:BEFORE FIELD apga040 name="construct.b.apga040"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apga040
            
            #add-point:AFTER FIELD apga040 name="construct.a.apga040"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.apga040
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apga040
            #add-point:ON ACTION controlp INFIELD apga040 name="construct.c.apga040"
            #160428-00001#1 ---s---
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_nmas001()                       
            DISPLAY g_qryparam.return1 TO apga040
            NEXT FIELD apga040
            #160428-00001#1 ---e---
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apga109
            #add-point:BEFORE FIELD apga109 name="construct.b.apga109"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apga109
            
            #add-point:AFTER FIELD apga109 name="construct.a.apga109"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.apga109
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apga109
            #add-point:ON ACTION controlp INFIELD apga109 name="construct.c.apga109"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glaa001
            #add-point:BEFORE FIELD glaa001 name="construct.b.glaa001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glaa001
            
            #add-point:AFTER FIELD glaa001 name="construct.a.glaa001"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.glaa001
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glaa001
            #add-point:ON ACTION controlp INFIELD glaa001 name="construct.c.glaa001"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apga101
            #add-point:BEFORE FIELD apga101 name="construct.b.apga101"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apga101
            
            #add-point:AFTER FIELD apga101 name="construct.a.apga101"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.apga101
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apga101
            #add-point:ON ACTION controlp INFIELD apga101 name="construct.c.apga101"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apga113
            #add-point:BEFORE FIELD apga113 name="construct.b.apga113"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apga113
            
            #add-point:AFTER FIELD apga113 name="construct.a.apga113"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.apga113
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apga113
            #add-point:ON ACTION controlp INFIELD apga113 name="construct.c.apga113"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apga114
            #add-point:BEFORE FIELD apga114 name="construct.b.apga114"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apga114
            
            #add-point:AFTER FIELD apga114 name="construct.a.apga114"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.apga114
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apga114
            #add-point:ON ACTION controlp INFIELD apga114 name="construct.c.apga114"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apga118
            #add-point:BEFORE FIELD apga118 name="construct.b.apga118"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apga118
            
            #add-point:AFTER FIELD apga118 name="construct.a.apga118"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.apga118
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apga118
            #add-point:ON ACTION controlp INFIELD apga118 name="construct.c.apga118"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apga112
            #add-point:BEFORE FIELD apga112 name="construct.b.apga112"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apga112
            
            #add-point:AFTER FIELD apga112 name="construct.a.apga112"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.apga112
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apga112
            #add-point:ON ACTION controlp INFIELD apga112 name="construct.c.apga112"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apga105
            #add-point:BEFORE FIELD apga105 name="construct.b.apga105"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apga105
            
            #add-point:AFTER FIELD apga105 name="construct.a.apga105"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.apga105
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apga105
            #add-point:ON ACTION controlp INFIELD apga105 name="construct.c.apga105"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apga016
            #add-point:BEFORE FIELD apga016 name="construct.b.apga016"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apga016
            
            #add-point:AFTER FIELD apga016 name="construct.a.apga016"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.apga016
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apga016
            #add-point:ON ACTION controlp INFIELD apga016 name="construct.c.apga016"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apga017
            #add-point:BEFORE FIELD apga017 name="construct.b.apga017"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apga017
            
            #add-point:AFTER FIELD apga017 name="construct.a.apga017"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.apga017
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apga017
            #add-point:ON ACTION controlp INFIELD apga017 name="construct.c.apga017"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apga018
            #add-point:BEFORE FIELD apga018 name="construct.b.apga018"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apga018
            
            #add-point:AFTER FIELD apga018 name="construct.a.apga018"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.apga018
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apga018
            #add-point:ON ACTION controlp INFIELD apga018 name="construct.c.apga018"
            #融資合約
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_fmac001()                      
            DISPLAY g_qryparam.return1 TO apga018
            NEXT FIELD apga018            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apga115
            #add-point:BEFORE FIELD apga115 name="construct.b.apga115"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apga115
            
            #add-point:AFTER FIELD apga115 name="construct.a.apga115"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.apga115
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apga115
            #add-point:ON ACTION controlp INFIELD apga115 name="construct.c.apga115"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apga106
            #add-point:BEFORE FIELD apga106 name="construct.b.apga106"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apga106
            
            #add-point:AFTER FIELD apga106 name="construct.a.apga106"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.apga106
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apga106
            #add-point:ON ACTION controlp INFIELD apga106 name="construct.c.apga106"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apga107
            #add-point:BEFORE FIELD apga107 name="construct.b.apga107"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apga107
            
            #add-point:AFTER FIELD apga107 name="construct.a.apga107"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.apga107
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apga107
            #add-point:ON ACTION controlp INFIELD apga107 name="construct.c.apga107"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apga019
            #add-point:BEFORE FIELD apga019 name="construct.b.apga019"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apga019
            
            #add-point:AFTER FIELD apga019 name="construct.a.apga019"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.apga019
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apga019
            #add-point:ON ACTION controlp INFIELD apga019 name="construct.c.apga019"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apga020
            #add-point:BEFORE FIELD apga020 name="construct.b.apga020"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apga020
            
            #add-point:AFTER FIELD apga020 name="construct.a.apga020"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.apga020
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apga020
            #add-point:ON ACTION controlp INFIELD apga020 name="construct.c.apga020"
      		INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
		   	LET g_qryparam.reqry = FALSE
		   	LET g_qryparam.arg1  = '263'
            CALL q_oocq002()                 
            DISPLAY g_qryparam.return1 TO apga020
            NEXT FIELD apga020
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apga021
            #add-point:BEFORE FIELD apga021 name="construct.b.apga021"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apga021
            
            #add-point:AFTER FIELD apga021 name="construct.a.apga021"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.apga021
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apga021
            #add-point:ON ACTION controlp INFIELD apga021 name="construct.c.apga021"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apga022
            #add-point:BEFORE FIELD apga022 name="construct.b.apga022"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apga022
            
            #add-point:AFTER FIELD apga022 name="construct.a.apga022"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.apga022
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apga022
            #add-point:ON ACTION controlp INFIELD apga022 name="construct.c.apga022"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apga023
            #add-point:BEFORE FIELD apga023 name="construct.b.apga023"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apga023
            
            #add-point:AFTER FIELD apga023 name="construct.a.apga023"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.apga023
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apga023
            #add-point:ON ACTION controlp INFIELD apga023 name="construct.c.apga023"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apga024
            #add-point:BEFORE FIELD apga024 name="construct.b.apga024"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apga024
            
            #add-point:AFTER FIELD apga024 name="construct.a.apga024"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.apga024
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apga024
            #add-point:ON ACTION controlp INFIELD apga024 name="construct.c.apga024"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apga025
            #add-point:BEFORE FIELD apga025 name="construct.b.apga025"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apga025
            
            #add-point:AFTER FIELD apga025 name="construct.a.apga025"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.apga025
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apga025
            #add-point:ON ACTION controlp INFIELD apga025 name="construct.c.apga025"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_apga1041
            #add-point:BEFORE FIELD l_apga1041 name="construct.b.l_apga1041"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_apga1041
            
            #add-point:AFTER FIELD l_apga1041 name="construct.a.l_apga1041"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.l_apga1041
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_apga1041
            #add-point:ON ACTION controlp INFIELD l_apga1041 name="construct.c.l_apga1041"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apga036
            #add-point:BEFORE FIELD apga036 name="construct.b.apga036"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apga036
            
            #add-point:AFTER FIELD apga036 name="construct.a.apga036"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.apga036
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apga036
            #add-point:ON ACTION controlp INFIELD apga036 name="construct.c.apga036"
            #160428-00001#1 ---s---
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.where = " nmad002 IN (SELECT nmaj001 FROM nmaj_t WHERE nmaj002='2'AND nmajstus='Y' AND nmajent = ",g_enterprise," )"
            CALL q_nmad002()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO apga036  #顯示到畫面上
            NEXT FIELD apga036  
            #160428-00001#1 ---e---
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apga037
            #add-point:BEFORE FIELD apga037 name="construct.b.apga037"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apga037
            
            #add-point:AFTER FIELD apga037 name="construct.a.apga037"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.apga037
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apga037
            #add-point:ON ACTION controlp INFIELD apga037 name="construct.c.apga037"
            #160428-00001#1 ---s---
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_nmai002()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO apga037  #顯示到畫面上
            NEXT FIELD apga037     
            #160428-00001#1 ---e---
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apga032
            #add-point:BEFORE FIELD apga032 name="construct.b.apga032"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apga032
            
            #add-point:AFTER FIELD apga032 name="construct.a.apga032"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.apga032
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apga032
            #add-point:ON ACTION controlp INFIELD apga032 name="construct.c.apga032"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_apga1081
            #add-point:BEFORE FIELD l_apga1081 name="construct.b.l_apga1081"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_apga1081
            
            #add-point:AFTER FIELD l_apga1081 name="construct.a.l_apga1081"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.l_apga1081
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_apga1081
            #add-point:ON ACTION controlp INFIELD l_apga1081 name="construct.c.l_apga1081"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apga034
            #add-point:BEFORE FIELD apga034 name="construct.b.apga034"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apga034
            
            #add-point:AFTER FIELD apga034 name="construct.a.apga034"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.apga034
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apga034
            #add-point:ON ACTION controlp INFIELD apga034 name="construct.c.apga034"
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.where = " nmad002 IN (SELECT nmaj001 FROM nmaj_t WHERE nmaj002='2'AND nmajstus='Y' AND nmajent = ",g_enterprise," )"
            CALL q_nmad002()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO apga034  #顯示到畫面上
            NEXT FIELD apga034     
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apga035
            #add-point:BEFORE FIELD apga035 name="construct.b.apga035"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apga035
            
            #add-point:AFTER FIELD apga035 name="construct.a.apga035"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.apga035
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apga035
            #add-point:ON ACTION controlp INFIELD apga035 name="construct.c.apga035"
            #160428-00001#1 ---s---
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_nmai002()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO apga035  #顯示到畫面上
            NEXT FIELD apga035                 
            #160428-00001#1 ---e---
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apga031
            #add-point:BEFORE FIELD apga031 name="construct.b.apga031"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apga031
            
            #add-point:AFTER FIELD apga031 name="construct.a.apga031"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.apga031
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apga031
            #add-point:ON ACTION controlp INFIELD apga031 name="construct.c.apga031"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_apga1021
            #add-point:BEFORE FIELD l_apga1021 name="construct.b.l_apga1021"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_apga1021
            
            #add-point:AFTER FIELD l_apga1021 name="construct.a.l_apga1021"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.l_apga1021
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_apga1021
            #add-point:ON ACTION controlp INFIELD l_apga1021 name="construct.c.l_apga1021"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apga038
            #add-point:BEFORE FIELD apga038 name="construct.b.apga038"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apga038
            
            #add-point:AFTER FIELD apga038 name="construct.a.apga038"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.apga038
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apga038
            #add-point:ON ACTION controlp INFIELD apga038 name="construct.c.apga038"
            #160428-00001#1 ---s---
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.where = " nmad002 IN (SELECT nmaj001 FROM nmaj_t WHERE nmaj002='2'AND nmajstus='Y' AND nmajent = ",g_enterprise," )"
            CALL q_nmad002()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO apga038      #顯示到畫面上
            NEXT FIELD apga038  
            #160428-00001#1 ---e---
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apga039
            #add-point:BEFORE FIELD apga039 name="construct.b.apga039"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apga039
            
            #add-point:AFTER FIELD apga039 name="construct.a.apga039"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.apga039
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apga039
            #add-point:ON ACTION controlp INFIELD apga039 name="construct.c.apga039"
            #160428-00001#1 ---s---
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_nmai002()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO apga039  #顯示到畫面上
            NEXT FIELD apga039  
            #160428-00001#1 ---e---            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apga033
            #add-point:BEFORE FIELD apga033 name="construct.b.apga033"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apga033
            
            #add-point:AFTER FIELD apga033 name="construct.a.apga033"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.apga033
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apga033
            #add-point:ON ACTION controlp INFIELD apga033 name="construct.c.apga033"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apga027
            #add-point:BEFORE FIELD apga027 name="construct.b.apga027"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apga027
            
            #add-point:AFTER FIELD apga027 name="construct.a.apga027"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.apga027
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apga027
            #add-point:ON ACTION controlp INFIELD apga027 name="construct.c.apga027"
            
            #END add-point
 
 
 
         
      END CONSTRUCT
 
      #單身根據table分拆construct
      CONSTRUCT g_wc2_table1 ON apgbseq,apgborga,apgb001,apgb002,apgb003,apgb004,apgb005,apgb008,apgb006, 
          apgb007,apgb100,apgb101,apgb009,apgb105,apgb115,apgb010,apgb011
           FROM s_detail1[1].apgbseq,s_detail1[1].apgborga,s_detail1[1].apgb001,s_detail1[1].apgb002, 
               s_detail1[1].apgb003,s_detail1[1].apgb004,s_detail1[1].apgb005,s_detail1[1].apgb008,s_detail1[1].apgb006, 
               s_detail1[1].apgb007,s_detail1[1].apgb100,s_detail1[1].apgb101,s_detail1[1].apgb009,s_detail1[1].apgb105, 
               s_detail1[1].apgb115,s_detail1[1].apgb010,s_detail1[1].apgb011
                      
         BEFORE CONSTRUCT
            #add-point:cs段before_construct name="cs.body.before_construct"
            
            #end add-point 
            
       #單身公用欄位開窗相關處理
       
         
       #單身一般欄位開窗相關處理
                #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apgbseq
            #add-point:BEFORE FIELD apgbseq name="construct.b.page1.apgbseq"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apgbseq
            
            #add-point:AFTER FIELD apgbseq name="construct.a.page1.apgbseq"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.apgbseq
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apgbseq
            #add-point:ON ACTION controlp INFIELD apgbseq name="construct.c.page1.apgbseq"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apgborga
            #add-point:BEFORE FIELD apgborga name="construct.b.page1.apgborga"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apgborga
            
            #add-point:AFTER FIELD apgborga name="construct.a.page1.apgborga"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.apgborga
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apgborga
            #add-point:ON ACTION controlp INFIELD apgborga name="construct.c.page1.apgborga"
      		INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
		   	LET g_qryparam.reqry = FALSE
		   	#161006-00005#5   add---s
		   	LET g_qryparam.where    = "ooef001 IN ",g_wc_cs_comp, 
                                      " AND ooef201 = 'Y'"   
            #161006-00005#5   add---e
            CALL q_ooef001()                 
            DISPLAY g_qryparam.return1 TO apgborga
            NEXT FIELD apgborga
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apgb001
            #add-point:BEFORE FIELD apgb001 name="construct.b.page1.apgb001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apgb001
            
            #add-point:AFTER FIELD apgb001 name="construct.a.page1.apgb001"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.apgb001
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apgb001
            #add-point:ON ACTION controlp INFIELD apgb001 name="construct.c.page1.apgb001"
      		INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
		   	LET g_qryparam.reqry = FALSE
            CALL  q_pmdldocno_7()                 
            DISPLAY g_qryparam.return1 TO apgb001
            NEXT FIELD apgb001
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apgb002
            #add-point:BEFORE FIELD apgb002 name="construct.b.page1.apgb002"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apgb002
            
            #add-point:AFTER FIELD apgb002 name="construct.a.page1.apgb002"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.apgb002
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apgb002
            #add-point:ON ACTION controlp INFIELD apgb002 name="construct.c.page1.apgb002"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apgb003
            #add-point:BEFORE FIELD apgb003 name="construct.b.page1.apgb003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apgb003
            
            #add-point:AFTER FIELD apgb003 name="construct.a.page1.apgb003"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.apgb003
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apgb003
            #add-point:ON ACTION controlp INFIELD apgb003 name="construct.c.page1.apgb003"
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            #CALL q_imaf001()      #161115-00042#5 mark     
            #161115-00042#5-add(s)
            SELECT ooef017 INTO g_apga_m.apgacomp FROM ooef_t WHERE ooefent = g_enterprise AND ooef001 = g_site
            LET g_qryparam.arg1 = g_apga_m.apgacomp
            CALL q_imaf001_21()
            #161115-00042#5-add(e)            
            DISPLAY g_qryparam.return1 TO apgb003 
            NEXT FIELD apgb003
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apgb004
            #add-point:BEFORE FIELD apgb004 name="construct.b.page1.apgb004"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apgb004
            
            #add-point:AFTER FIELD apgb004 name="construct.a.page1.apgb004"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.apgb004
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apgb004
            #add-point:ON ACTION controlp INFIELD apgb004 name="construct.c.page1.apgb004"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apgb005
            #add-point:BEFORE FIELD apgb005 name="construct.b.page1.apgb005"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apgb005
            
            #add-point:AFTER FIELD apgb005 name="construct.a.page1.apgb005"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.apgb005
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apgb005
            #add-point:ON ACTION controlp INFIELD apgb005 name="construct.c.page1.apgb005"
            #單位
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooca001_1()                   
            DISPLAY g_qryparam.return1 TO apgb005
            NEXT FIELD apgb005                
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apgb008
            #add-point:BEFORE FIELD apgb008 name="construct.b.page1.apgb008"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apgb008
            
            #add-point:AFTER FIELD apgb008 name="construct.a.page1.apgb008"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.apgb008
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apgb008
            #add-point:ON ACTION controlp INFIELD apgb008 name="construct.c.page1.apgb008"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apgb006
            #add-point:BEFORE FIELD apgb006 name="construct.b.page1.apgb006"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apgb006
            
            #add-point:AFTER FIELD apgb006 name="construct.a.page1.apgb006"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.apgb006
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apgb006
            #add-point:ON ACTION controlp INFIELD apgb006 name="construct.c.page1.apgb006"
            #稅別
            SELECT ooef019 INTO l_ooef019 FROM ooef_t
             WHERE ooefent = g_enterprise
               AND ooef001 = g_site
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.arg1 = l_ooef019       
            CALL q_oodb002_5()
            DISPLAY g_qryparam.return1 TO apgb006
            NEXT FIELD apgb006
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apgb007
            #add-point:BEFORE FIELD apgb007 name="construct.b.page1.apgb007"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apgb007
            
            #add-point:AFTER FIELD apgb007 name="construct.a.page1.apgb007"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.apgb007
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apgb007
            #add-point:ON ACTION controlp INFIELD apgb007 name="construct.c.page1.apgb007"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apgb100
            #add-point:BEFORE FIELD apgb100 name="construct.b.page1.apgb100"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apgb100
            
            #add-point:AFTER FIELD apgb100 name="construct.a.page1.apgb100"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.apgb100
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apgb100
            #add-point:ON ACTION controlp INFIELD apgb100 name="construct.c.page1.apgb100"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apgb101
            #add-point:BEFORE FIELD apgb101 name="construct.b.page1.apgb101"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apgb101
            
            #add-point:AFTER FIELD apgb101 name="construct.a.page1.apgb101"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.apgb101
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apgb101
            #add-point:ON ACTION controlp INFIELD apgb101 name="construct.c.page1.apgb101"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apgb009
            #add-point:BEFORE FIELD apgb009 name="construct.b.page1.apgb009"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apgb009
            
            #add-point:AFTER FIELD apgb009 name="construct.a.page1.apgb009"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.apgb009
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apgb009
            #add-point:ON ACTION controlp INFIELD apgb009 name="construct.c.page1.apgb009"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apgb105
            #add-point:BEFORE FIELD apgb105 name="construct.b.page1.apgb105"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apgb105
            
            #add-point:AFTER FIELD apgb105 name="construct.a.page1.apgb105"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.apgb105
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apgb105
            #add-point:ON ACTION controlp INFIELD apgb105 name="construct.c.page1.apgb105"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apgb115
            #add-point:BEFORE FIELD apgb115 name="construct.b.page1.apgb115"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apgb115
            
            #add-point:AFTER FIELD apgb115 name="construct.a.page1.apgb115"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.apgb115
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apgb115
            #add-point:ON ACTION controlp INFIELD apgb115 name="construct.c.page1.apgb115"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apgb010
            #add-point:BEFORE FIELD apgb010 name="construct.b.page1.apgb010"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apgb010
            
            #add-point:AFTER FIELD apgb010 name="construct.a.page1.apgb010"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.apgb010
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apgb010
            #add-point:ON ACTION controlp INFIELD apgb010 name="construct.c.page1.apgb010"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apgb011
            #add-point:BEFORE FIELD apgb011 name="construct.b.page1.apgb011"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apgb011
            
            #add-point:AFTER FIELD apgb011 name="construct.a.page1.apgb011"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.apgb011
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apgb011
            #add-point:ON ACTION controlp INFIELD apgb011 name="construct.c.page1.apgb011"
            
            #END add-point
 
 
   
       
      END CONSTRUCT
      
      CONSTRUCT g_wc2_table2 ON apgc900,apgcseq,apgcorga,apgc001,apgc002,apgc003,apgc005,apgc014,apgc100, 
          apgc101,apgc006,apgc007,apgc008,apgc009,apgc010,apgc103,apgc104,apgc105,apgc113,apgc114,apgc115, 
          apgc004,apgc004_desc,apgc015,apgc015_desc,apgc016,apgc016_desc,apgc012,apgc013
           FROM s_detail2[1].apgc900,s_detail2[1].apgcseq,s_detail2[1].apgcorga,s_detail2[1].apgc001, 
               s_detail2[1].apgc002,s_detail2[1].apgc003,s_detail2[1].apgc005,s_detail2[1].apgc014,s_detail2[1].apgc100, 
               s_detail2[1].apgc101,s_detail2[1].apgc006,s_detail2[1].apgc007,s_detail2[1].apgc008,s_detail2[1].apgc009, 
               s_detail2[1].apgc010,s_detail2[1].apgc103,s_detail2[1].apgc104,s_detail2[1].apgc105,s_detail2[1].apgc113, 
               s_detail2[1].apgc114,s_detail2[1].apgc115,s_detail2[1].apgc004,s_detail2[1].apgc004_desc, 
               s_detail2[1].apgc015,s_detail2[1].apgc015_desc,s_detail2[1].apgc016,s_detail2[1].apgc016_desc, 
               s_detail2[1].apgc012,s_detail2[1].apgc013
                      
         BEFORE CONSTRUCT
            #add-point:cs段before_construct name="cs.body2.before_construct"
            
            #end add-point 
            
       #單身公用欄位開窗相關處理(table 2)
       
       
       #單身一般欄位開窗相關處理       
                #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apgc900
            #add-point:BEFORE FIELD apgc900 name="construct.b.page2.apgc900"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apgc900
            
            #add-point:AFTER FIELD apgc900 name="construct.a.page2.apgc900"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.apgc900
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apgc900
            #add-point:ON ACTION controlp INFIELD apgc900 name="construct.c.page2.apgc900"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apgcseq
            #add-point:BEFORE FIELD apgcseq name="construct.b.page2.apgcseq"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apgcseq
            
            #add-point:AFTER FIELD apgcseq name="construct.a.page2.apgcseq"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.apgcseq
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apgcseq
            #add-point:ON ACTION controlp INFIELD apgcseq name="construct.c.page2.apgcseq"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apgcorga
            #add-point:BEFORE FIELD apgcorga name="construct.b.page2.apgcorga"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apgcorga
            
            #add-point:AFTER FIELD apgcorga name="construct.a.page2.apgcorga"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.apgcorga
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apgcorga
            #add-point:ON ACTION controlp INFIELD apgcorga name="construct.c.page2.apgcorga"
      		INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
		   	LET g_qryparam.reqry = FALSE
		   	#161006-00005#5   add---s
		   	LET g_qryparam.where    = "ooef001 IN ",g_wc_cs_comp, 
                                      " AND ooef201 = 'Y'"   
            #161006-00005#5   add---e
            CALL q_ooef001()                 
            DISPLAY g_qryparam.return1 TO apgcorga
            NEXT FIELD apgcorga
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apgc001
            #add-point:BEFORE FIELD apgc001 name="construct.b.page2.apgc001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apgc001
            
            #add-point:AFTER FIELD apgc001 name="construct.a.page2.apgc001"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.apgc001
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apgc001
            #add-point:ON ACTION controlp INFIELD apgc001 name="construct.c.page2.apgc001"
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.arg1 = '3117'
            CALL q_oocq002()
            DISPLAY g_qryparam.return1 TO apgc001
            NEXT FIELD apgc001
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apgc002
            #add-point:BEFORE FIELD apgc002 name="construct.b.page2.apgc002"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apgc002
            
            #add-point:AFTER FIELD apgc002 name="construct.a.page2.apgc002"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.apgc002
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apgc002
            #add-point:ON ACTION controlp INFIELD apgc002 name="construct.c.page2.apgc002"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apgc003
            #add-point:BEFORE FIELD apgc003 name="construct.b.page2.apgc003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apgc003
            
            #add-point:AFTER FIELD apgc003 name="construct.a.page2.apgc003"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.apgc003
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apgc003
            #add-point:ON ACTION controlp INFIELD apgc003 name="construct.c.page2.apgc003"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apgc005
            #add-point:BEFORE FIELD apgc005 name="construct.b.page2.apgc005"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apgc005
            
            #add-point:AFTER FIELD apgc005 name="construct.a.page2.apgc005"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.apgc005
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apgc005
            #add-point:ON ACTION controlp INFIELD apgc005 name="construct.c.page2.apgc005"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apgc014
            #add-point:BEFORE FIELD apgc014 name="construct.b.page2.apgc014"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apgc014
            
            #add-point:AFTER FIELD apgc014 name="construct.a.page2.apgc014"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.apgc014
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apgc014
            #add-point:ON ACTION controlp INFIELD apgc014 name="construct.c.page2.apgc014"
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_nmas001()                       
            DISPLAY g_qryparam.return1 TO apgc014
            NEXT FIELD apgc014
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apgc100
            #add-point:BEFORE FIELD apgc100 name="construct.b.page2.apgc100"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apgc100
            
            #add-point:AFTER FIELD apgc100 name="construct.a.page2.apgc100"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.apgc100
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apgc100
            #add-point:ON ACTION controlp INFIELD apgc100 name="construct.c.page2.apgc100"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apgc101
            #add-point:BEFORE FIELD apgc101 name="construct.b.page2.apgc101"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apgc101
            
            #add-point:AFTER FIELD apgc101 name="construct.a.page2.apgc101"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.apgc101
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apgc101
            #add-point:ON ACTION controlp INFIELD apgc101 name="construct.c.page2.apgc101"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apgc006
            #add-point:BEFORE FIELD apgc006 name="construct.b.page2.apgc006"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apgc006
            
            #add-point:AFTER FIELD apgc006 name="construct.a.page2.apgc006"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.apgc006
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apgc006
            #add-point:ON ACTION controlp INFIELD apgc006 name="construct.c.page2.apgc006"
            #稅別
            SELECT ooef019 INTO l_ooef019 FROM ooef_t
             WHERE ooefent = g_enterprise
               AND ooef001 = g_site
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.arg1 = l_ooef019       
            CALL q_oodb002_5()
            DISPLAY g_qryparam.return1 TO apgc006
            NEXT FIELD apgc006
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apgc007
            #add-point:BEFORE FIELD apgc007 name="construct.b.page2.apgc007"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apgc007
            
            #add-point:AFTER FIELD apgc007 name="construct.a.page2.apgc007"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.apgc007
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apgc007
            #add-point:ON ACTION controlp INFIELD apgc007 name="construct.c.page2.apgc007"
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_isac002()                     
            DISPLAY g_qryparam.return1 TO apgc007
            NEXT FIELD apgc007
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apgc008
            #add-point:BEFORE FIELD apgc008 name="construct.b.page2.apgc008"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apgc008
            
            #add-point:AFTER FIELD apgc008 name="construct.a.page2.apgc008"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.apgc008
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apgc008
            #add-point:ON ACTION controlp INFIELD apgc008 name="construct.c.page2.apgc008"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apgc009
            #add-point:BEFORE FIELD apgc009 name="construct.b.page2.apgc009"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apgc009
            
            #add-point:AFTER FIELD apgc009 name="construct.a.page2.apgc009"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.apgc009
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apgc009
            #add-point:ON ACTION controlp INFIELD apgc009 name="construct.c.page2.apgc009"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apgc010
            #add-point:BEFORE FIELD apgc010 name="construct.b.page2.apgc010"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apgc010
            
            #add-point:AFTER FIELD apgc010 name="construct.a.page2.apgc010"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.apgc010
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apgc010
            #add-point:ON ACTION controlp INFIELD apgc010 name="construct.c.page2.apgc010"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apgc103
            #add-point:BEFORE FIELD apgc103 name="construct.b.page2.apgc103"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apgc103
            
            #add-point:AFTER FIELD apgc103 name="construct.a.page2.apgc103"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.apgc103
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apgc103
            #add-point:ON ACTION controlp INFIELD apgc103 name="construct.c.page2.apgc103"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apgc104
            #add-point:BEFORE FIELD apgc104 name="construct.b.page2.apgc104"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apgc104
            
            #add-point:AFTER FIELD apgc104 name="construct.a.page2.apgc104"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.apgc104
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apgc104
            #add-point:ON ACTION controlp INFIELD apgc104 name="construct.c.page2.apgc104"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apgc105
            #add-point:BEFORE FIELD apgc105 name="construct.b.page2.apgc105"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apgc105
            
            #add-point:AFTER FIELD apgc105 name="construct.a.page2.apgc105"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.apgc105
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apgc105
            #add-point:ON ACTION controlp INFIELD apgc105 name="construct.c.page2.apgc105"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apgc113
            #add-point:BEFORE FIELD apgc113 name="construct.b.page2.apgc113"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apgc113
            
            #add-point:AFTER FIELD apgc113 name="construct.a.page2.apgc113"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.apgc113
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apgc113
            #add-point:ON ACTION controlp INFIELD apgc113 name="construct.c.page2.apgc113"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apgc114
            #add-point:BEFORE FIELD apgc114 name="construct.b.page2.apgc114"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apgc114
            
            #add-point:AFTER FIELD apgc114 name="construct.a.page2.apgc114"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.apgc114
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apgc114
            #add-point:ON ACTION controlp INFIELD apgc114 name="construct.c.page2.apgc114"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apgc115
            #add-point:BEFORE FIELD apgc115 name="construct.b.page2.apgc115"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apgc115
            
            #add-point:AFTER FIELD apgc115 name="construct.a.page2.apgc115"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.apgc115
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apgc115
            #add-point:ON ACTION controlp INFIELD apgc115 name="construct.c.page2.apgc115"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apgc004
            #add-point:BEFORE FIELD apgc004 name="construct.b.page2.apgc004"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apgc004
            
            #add-point:AFTER FIELD apgc004 name="construct.a.page2.apgc004"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.apgc004
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apgc004
            #add-point:ON ACTION controlp INFIELD apgc004 name="construct.c.page2.apgc004"
		      INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			   LET g_qryparam.reqry = FALSE
			   LET g_qryparam.where = "glac003 <>'1' " #非統制科目
			   #161115-00042#5-add(s)
            SELECT ooef017 INTO g_apga_m.apgacomp FROM ooef_t WHERE ooefent = g_enterprise AND ooef001 = g_site
            SELECT glaald INTO g_ld FROM glaa_t WHERE glaaent = g_enterprise AND glaacomp = g_apga_m.apgacomp
               AND glaa014 = 'Y' 
            LET g_qryparam.where = g_qryparam.where,
                                   " AND glac002 IN (SELECT glad001 FROM glad_t,glac_t WHERE glad001= glac002 ",
                                   " AND glacent = gladent ",
                                   " AND gladld='",g_ld,"' AND gladent=",g_enterprise,
                                   " AND gladstus = 'Y' )"
            #161115-00042#5-add(e)
            CALL aglt310_04()                 
            DISPLAY g_qryparam.return1 TO apgc004   #顯示到畫面上
            NEXT FIELD apgc004
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apgc004_desc
            #add-point:BEFORE FIELD apgc004_desc name="construct.b.page2.apgc004_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apgc004_desc
            
            #add-point:AFTER FIELD apgc004_desc name="construct.a.page2.apgc004_desc"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.apgc004_desc
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apgc004_desc
            #add-point:ON ACTION controlp INFIELD apgc004_desc name="construct.c.page2.apgc004_desc"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apgc015
            #add-point:BEFORE FIELD apgc015 name="construct.b.page2.apgc015"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apgc015
            
            #add-point:AFTER FIELD apgc015 name="construct.a.page2.apgc015"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.apgc015
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apgc015
            #add-point:ON ACTION controlp INFIELD apgc015 name="construct.c.page2.apgc015"
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_nmaj001()
            DISPLAY g_qryparam.return1 TO apgc015
            NEXT FIELD apgc015
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apgc015_desc
            #add-point:BEFORE FIELD apgc015_desc name="construct.b.page2.apgc015_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apgc015_desc
            
            #add-point:AFTER FIELD apgc015_desc name="construct.a.page2.apgc015_desc"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.apgc015_desc
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apgc015_desc
            #add-point:ON ACTION controlp INFIELD apgc015_desc name="construct.c.page2.apgc015_desc"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apgc016
            #add-point:BEFORE FIELD apgc016 name="construct.b.page2.apgc016"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apgc016
            
            #add-point:AFTER FIELD apgc016 name="construct.a.page2.apgc016"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.apgc016
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apgc016
            #add-point:ON ACTION controlp INFIELD apgc016 name="construct.c.page2.apgc016"
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_nmai002()                     
            DISPLAY g_qryparam.return1 TO apgc016
            NEXT FIELD apgc016  
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apgc016_desc
            #add-point:BEFORE FIELD apgc016_desc name="construct.b.page2.apgc016_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apgc016_desc
            
            #add-point:AFTER FIELD apgc016_desc name="construct.a.page2.apgc016_desc"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.apgc016_desc
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apgc016_desc
            #add-point:ON ACTION controlp INFIELD apgc016_desc name="construct.c.page2.apgc016_desc"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apgc012
            #add-point:BEFORE FIELD apgc012 name="construct.b.page2.apgc012"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apgc012
            
            #add-point:AFTER FIELD apgc012 name="construct.a.page2.apgc012"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.apgc012
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apgc012
            #add-point:ON ACTION controlp INFIELD apgc012 name="construct.c.page2.apgc012"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apgc013
            #add-point:BEFORE FIELD apgc013 name="construct.b.page2.apgc013"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apgc013
            
            #add-point:AFTER FIELD apgc013 name="construct.a.page2.apgc013"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.apgc013
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apgc013
            #add-point:ON ACTION controlp INFIELD apgc013 name="construct.c.page2.apgc013"
            
            #END add-point
 
 
   
       
      END CONSTRUCT
 
      CONSTRUCT g_wc2_table3 ON xrcdseq,xrcdseq2,xrcd007,xrcdld,xrcd003,xrcd006,xrcd005,xrcd102,xrcd103, 
          xrcd104,xrcd105,xrcd113,xrcd114,xrcd115,xrcd123,xrcd124,xrcd125,xrcd133,xrcd134,xrcd135,xrcdorga, 
          xrcd009,xrcd001,xrcd004,xrcd100,xrcd101,xrcd106,xrcd112,xrcd116,xrcd117,xrcd118,xrcd121,xrcd131, 
          xrcdsite
           FROM s_detail3[1].xrcdseq,s_detail3[1].xrcdseq2,s_detail3[1].xrcd007,s_detail3[1].xrcdld, 
               s_detail3[1].xrcd003,s_detail3[1].xrcd006,s_detail3[1].xrcd005,s_detail3[1].xrcd102,s_detail3[1].xrcd103, 
               s_detail3[1].xrcd104,s_detail3[1].xrcd105,s_detail3[1].xrcd113,s_detail3[1].xrcd114,s_detail3[1].xrcd115, 
               s_detail3[1].xrcd123,s_detail3[1].xrcd124,s_detail3[1].xrcd125,s_detail3[1].xrcd133,s_detail3[1].xrcd134, 
               s_detail3[1].xrcd135,s_detail3[1].xrcdorga,s_detail3[1].xrcd009,s_detail3[1].xrcd001, 
               s_detail3[1].xrcd004,s_detail3[1].xrcd100,s_detail3[1].xrcd101,s_detail3[1].xrcd106,s_detail3[1].xrcd112, 
               s_detail3[1].xrcd116,s_detail3[1].xrcd117,s_detail3[1].xrcd118,s_detail3[1].xrcd121,s_detail3[1].xrcd131, 
               s_detail3[1].xrcdsite
                      
         BEFORE CONSTRUCT
            #add-point:cs段before_construct name="cs.body3.before_construct"
            
            #end add-point 
            
       #單身公用欄位開窗相關處理(table 3)
       
       
       #單身一般欄位開窗相關處理       
                #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrcdseq
            #add-point:BEFORE FIELD xrcdseq name="construct.b.page3.xrcdseq"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrcdseq
            
            #add-point:AFTER FIELD xrcdseq name="construct.a.page3.xrcdseq"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page3.xrcdseq
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrcdseq
            #add-point:ON ACTION controlp INFIELD xrcdseq name="construct.c.page3.xrcdseq"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrcdseq2
            #add-point:BEFORE FIELD xrcdseq2 name="construct.b.page3.xrcdseq2"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrcdseq2
            
            #add-point:AFTER FIELD xrcdseq2 name="construct.a.page3.xrcdseq2"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page3.xrcdseq2
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrcdseq2
            #add-point:ON ACTION controlp INFIELD xrcdseq2 name="construct.c.page3.xrcdseq2"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrcd007
            #add-point:BEFORE FIELD xrcd007 name="construct.b.page3.xrcd007"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrcd007
            
            #add-point:AFTER FIELD xrcd007 name="construct.a.page3.xrcd007"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page3.xrcd007
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrcd007
            #add-point:ON ACTION controlp INFIELD xrcd007 name="construct.c.page3.xrcd007"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrcdld
            #add-point:BEFORE FIELD xrcdld name="construct.b.page3.xrcdld"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrcdld
            
            #add-point:AFTER FIELD xrcdld name="construct.a.page3.xrcdld"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page3.xrcdld
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrcdld
            #add-point:ON ACTION controlp INFIELD xrcdld name="construct.c.page3.xrcdld"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrcd003
            #add-point:BEFORE FIELD xrcd003 name="construct.b.page3.xrcd003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrcd003
            
            #add-point:AFTER FIELD xrcd003 name="construct.a.page3.xrcd003"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page3.xrcd003
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrcd003
            #add-point:ON ACTION controlp INFIELD xrcd003 name="construct.c.page3.xrcd003"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrcd006
            #add-point:BEFORE FIELD xrcd006 name="construct.b.page3.xrcd006"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrcd006
            
            #add-point:AFTER FIELD xrcd006 name="construct.a.page3.xrcd006"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page3.xrcd006
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrcd006
            #add-point:ON ACTION controlp INFIELD xrcd006 name="construct.c.page3.xrcd006"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrcd005
            #add-point:BEFORE FIELD xrcd005 name="construct.b.page3.xrcd005"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrcd005
            
            #add-point:AFTER FIELD xrcd005 name="construct.a.page3.xrcd005"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page3.xrcd005
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrcd005
            #add-point:ON ACTION controlp INFIELD xrcd005 name="construct.c.page3.xrcd005"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrcd102
            #add-point:BEFORE FIELD xrcd102 name="construct.b.page3.xrcd102"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrcd102
            
            #add-point:AFTER FIELD xrcd102 name="construct.a.page3.xrcd102"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page3.xrcd102
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrcd102
            #add-point:ON ACTION controlp INFIELD xrcd102 name="construct.c.page3.xrcd102"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrcd103
            #add-point:BEFORE FIELD xrcd103 name="construct.b.page3.xrcd103"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrcd103
            
            #add-point:AFTER FIELD xrcd103 name="construct.a.page3.xrcd103"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page3.xrcd103
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrcd103
            #add-point:ON ACTION controlp INFIELD xrcd103 name="construct.c.page3.xrcd103"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrcd104
            #add-point:BEFORE FIELD xrcd104 name="construct.b.page3.xrcd104"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrcd104
            
            #add-point:AFTER FIELD xrcd104 name="construct.a.page3.xrcd104"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page3.xrcd104
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrcd104
            #add-point:ON ACTION controlp INFIELD xrcd104 name="construct.c.page3.xrcd104"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrcd105
            #add-point:BEFORE FIELD xrcd105 name="construct.b.page3.xrcd105"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrcd105
            
            #add-point:AFTER FIELD xrcd105 name="construct.a.page3.xrcd105"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page3.xrcd105
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrcd105
            #add-point:ON ACTION controlp INFIELD xrcd105 name="construct.c.page3.xrcd105"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrcd113
            #add-point:BEFORE FIELD xrcd113 name="construct.b.page3.xrcd113"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrcd113
            
            #add-point:AFTER FIELD xrcd113 name="construct.a.page3.xrcd113"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page3.xrcd113
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrcd113
            #add-point:ON ACTION controlp INFIELD xrcd113 name="construct.c.page3.xrcd113"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrcd114
            #add-point:BEFORE FIELD xrcd114 name="construct.b.page3.xrcd114"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrcd114
            
            #add-point:AFTER FIELD xrcd114 name="construct.a.page3.xrcd114"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page3.xrcd114
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrcd114
            #add-point:ON ACTION controlp INFIELD xrcd114 name="construct.c.page3.xrcd114"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrcd115
            #add-point:BEFORE FIELD xrcd115 name="construct.b.page3.xrcd115"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrcd115
            
            #add-point:AFTER FIELD xrcd115 name="construct.a.page3.xrcd115"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page3.xrcd115
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrcd115
            #add-point:ON ACTION controlp INFIELD xrcd115 name="construct.c.page3.xrcd115"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrcd123
            #add-point:BEFORE FIELD xrcd123 name="construct.b.page3.xrcd123"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrcd123
            
            #add-point:AFTER FIELD xrcd123 name="construct.a.page3.xrcd123"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page3.xrcd123
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrcd123
            #add-point:ON ACTION controlp INFIELD xrcd123 name="construct.c.page3.xrcd123"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrcd124
            #add-point:BEFORE FIELD xrcd124 name="construct.b.page3.xrcd124"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrcd124
            
            #add-point:AFTER FIELD xrcd124 name="construct.a.page3.xrcd124"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page3.xrcd124
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrcd124
            #add-point:ON ACTION controlp INFIELD xrcd124 name="construct.c.page3.xrcd124"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrcd125
            #add-point:BEFORE FIELD xrcd125 name="construct.b.page3.xrcd125"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrcd125
            
            #add-point:AFTER FIELD xrcd125 name="construct.a.page3.xrcd125"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page3.xrcd125
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrcd125
            #add-point:ON ACTION controlp INFIELD xrcd125 name="construct.c.page3.xrcd125"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrcd133
            #add-point:BEFORE FIELD xrcd133 name="construct.b.page3.xrcd133"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrcd133
            
            #add-point:AFTER FIELD xrcd133 name="construct.a.page3.xrcd133"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page3.xrcd133
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrcd133
            #add-point:ON ACTION controlp INFIELD xrcd133 name="construct.c.page3.xrcd133"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrcd134
            #add-point:BEFORE FIELD xrcd134 name="construct.b.page3.xrcd134"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrcd134
            
            #add-point:AFTER FIELD xrcd134 name="construct.a.page3.xrcd134"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page3.xrcd134
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrcd134
            #add-point:ON ACTION controlp INFIELD xrcd134 name="construct.c.page3.xrcd134"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrcd135
            #add-point:BEFORE FIELD xrcd135 name="construct.b.page3.xrcd135"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrcd135
            
            #add-point:AFTER FIELD xrcd135 name="construct.a.page3.xrcd135"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page3.xrcd135
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrcd135
            #add-point:ON ACTION controlp INFIELD xrcd135 name="construct.c.page3.xrcd135"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrcdorga
            #add-point:BEFORE FIELD xrcdorga name="construct.b.page3.xrcdorga"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrcdorga
            
            #add-point:AFTER FIELD xrcdorga name="construct.a.page3.xrcdorga"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page3.xrcdorga
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrcdorga
            #add-point:ON ACTION controlp INFIELD xrcdorga name="construct.c.page3.xrcdorga"
            
            #END add-point
 
 
         #Ctrlp:construct.c.page3.xrcd009
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrcd009
            #add-point:ON ACTION controlp INFIELD xrcd009 name="construct.c.page3.xrcd009"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_glac002()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO xrcd009  #顯示到畫面上
            NEXT FIELD xrcd009                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrcd009
            #add-point:BEFORE FIELD xrcd009 name="construct.b.page3.xrcd009"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrcd009
            
            #add-point:AFTER FIELD xrcd009 name="construct.a.page3.xrcd009"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrcd001
            #add-point:BEFORE FIELD xrcd001 name="construct.b.page3.xrcd001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrcd001
            
            #add-point:AFTER FIELD xrcd001 name="construct.a.page3.xrcd001"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page3.xrcd001
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrcd001
            #add-point:ON ACTION controlp INFIELD xrcd001 name="construct.c.page3.xrcd001"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrcd004
            #add-point:BEFORE FIELD xrcd004 name="construct.b.page3.xrcd004"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrcd004
            
            #add-point:AFTER FIELD xrcd004 name="construct.a.page3.xrcd004"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page3.xrcd004
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrcd004
            #add-point:ON ACTION controlp INFIELD xrcd004 name="construct.c.page3.xrcd004"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrcd100
            #add-point:BEFORE FIELD xrcd100 name="construct.b.page3.xrcd100"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrcd100
            
            #add-point:AFTER FIELD xrcd100 name="construct.a.page3.xrcd100"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page3.xrcd100
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrcd100
            #add-point:ON ACTION controlp INFIELD xrcd100 name="construct.c.page3.xrcd100"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrcd101
            #add-point:BEFORE FIELD xrcd101 name="construct.b.page3.xrcd101"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrcd101
            
            #add-point:AFTER FIELD xrcd101 name="construct.a.page3.xrcd101"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page3.xrcd101
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrcd101
            #add-point:ON ACTION controlp INFIELD xrcd101 name="construct.c.page3.xrcd101"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrcd106
            #add-point:BEFORE FIELD xrcd106 name="construct.b.page3.xrcd106"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrcd106
            
            #add-point:AFTER FIELD xrcd106 name="construct.a.page3.xrcd106"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page3.xrcd106
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrcd106
            #add-point:ON ACTION controlp INFIELD xrcd106 name="construct.c.page3.xrcd106"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrcd112
            #add-point:BEFORE FIELD xrcd112 name="construct.b.page3.xrcd112"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrcd112
            
            #add-point:AFTER FIELD xrcd112 name="construct.a.page3.xrcd112"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page3.xrcd112
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrcd112
            #add-point:ON ACTION controlp INFIELD xrcd112 name="construct.c.page3.xrcd112"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrcd116
            #add-point:BEFORE FIELD xrcd116 name="construct.b.page3.xrcd116"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrcd116
            
            #add-point:AFTER FIELD xrcd116 name="construct.a.page3.xrcd116"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page3.xrcd116
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrcd116
            #add-point:ON ACTION controlp INFIELD xrcd116 name="construct.c.page3.xrcd116"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrcd117
            #add-point:BEFORE FIELD xrcd117 name="construct.b.page3.xrcd117"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrcd117
            
            #add-point:AFTER FIELD xrcd117 name="construct.a.page3.xrcd117"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page3.xrcd117
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrcd117
            #add-point:ON ACTION controlp INFIELD xrcd117 name="construct.c.page3.xrcd117"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrcd118
            #add-point:BEFORE FIELD xrcd118 name="construct.b.page3.xrcd118"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrcd118
            
            #add-point:AFTER FIELD xrcd118 name="construct.a.page3.xrcd118"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page3.xrcd118
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrcd118
            #add-point:ON ACTION controlp INFIELD xrcd118 name="construct.c.page3.xrcd118"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrcd121
            #add-point:BEFORE FIELD xrcd121 name="construct.b.page3.xrcd121"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrcd121
            
            #add-point:AFTER FIELD xrcd121 name="construct.a.page3.xrcd121"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page3.xrcd121
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrcd121
            #add-point:ON ACTION controlp INFIELD xrcd121 name="construct.c.page3.xrcd121"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrcd131
            #add-point:BEFORE FIELD xrcd131 name="construct.b.page3.xrcd131"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrcd131
            
            #add-point:AFTER FIELD xrcd131 name="construct.a.page3.xrcd131"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page3.xrcd131
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrcd131
            #add-point:ON ACTION controlp INFIELD xrcd131 name="construct.c.page3.xrcd131"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrcdsite
            #add-point:BEFORE FIELD xrcdsite name="construct.b.page3.xrcdsite"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrcdsite
            
            #add-point:AFTER FIELD xrcdsite name="construct.a.page3.xrcdsite"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page3.xrcdsite
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrcdsite
            #add-point:ON ACTION controlp INFIELD xrcdsite name="construct.c.page3.xrcdsite"
            
            #END add-point
 
 
   
       
      END CONSTRUCT
 
 
      
 
      
      #add-point:cs段add_cs(本段內只能出現新的CONSTRUCT指令) name="cs.add_cs"
      
      #end add-point
 
      BEFORE DIALOG
         CALL cl_qbe_init()
         #add-point:cs段b_dialog name="cs.b_dialog"
         CALL s_control_get_supplier_sql_pmab('4',g_site,g_user,g_dept,'',g_wc_cs_comp) RETURNING g_sub_success,g_sql_ctrl #161229-00047#51 add
         #end add-point  
 
      #查詢方案列表
      ON ACTION qbe_select
         LET ls_wc = ""
         CALL cl_qbe_list("c") RETURNING ls_wc
         IF NOT cl_null(ls_wc) THEN
            CALL util.JSON.parse(ls_wc, la_wc)
            INITIALIZE g_wc, g_wc2, g_wc2_table1, g_wc2_extend TO NULL
            INITIALIZE g_wc2_table2 TO NULL
 
            INITIALIZE g_wc2_table3 TO NULL
 
 
            FOR li_idx = 1 TO la_wc.getLength()
               CASE
                  WHEN la_wc[li_idx].tableid = "apga_t" 
                     LET g_wc = la_wc[li_idx].wc
                  WHEN la_wc[li_idx].tableid = "apgb_t" 
                     LET g_wc2_table1 = la_wc[li_idx].wc
                  WHEN la_wc[li_idx].tableid = "apgc_t" 
                     LET g_wc2_table2 = la_wc[li_idx].wc
 
                  WHEN la_wc[li_idx].tableid = "xrcd_t" 
                     LET g_wc2_table3 = la_wc[li_idx].wc
 
 
               END CASE
            END FOR
         END IF
    
      #條件儲存為方案
      ON ACTION qbe_save
         CALL cl_qbe_save()
 
      ON ACTION accept
         ACCEPT DIALOG
 
      ON ACTION cancel
         LET INT_FLAG = 1
         EXIT DIALOG 
 
      #交談指令共用ACTION
      &include "common_action.4gl" 
         CONTINUE DIALOG
   END DIALOG
   
   #組合g_wc2
   LET g_wc2 = g_wc2_table1
   IF g_wc2_table2 <> " 1=1" THEN
      LET g_wc2 = g_wc2 ," AND ", g_wc2_table2
   END IF
 
   IF g_wc2_table3 <> " 1=1" THEN
      LET g_wc2 = g_wc2 ," AND ", g_wc2_table3
   END IF
 
 
 
 
   
   #add-point:cs段結束前 name="cs.after_construct"
   IF cl_null(g_wc)THEN
      LET g_wc = " apgacomp IN ",g_wc_cs_comp    #160824-00049#1
   ELSE
      LET g_wc = g_wc," AND apgacomp IN ",g_wc_cs_comp    #160824-00049#1
   END IF
   #161104-00046#7 --s add
   IF cl_null(g_user_dept_wc)THEN
      LET g_user_dept_wc = ' 1=1'
   END IF
   IF g_user_dept_wc <>  " 1=1" THEN
      LET g_wc = g_wc ," AND ", g_user_dept_wc CLIPPED
   END IF   
   #161104-00046#7 --e add
   #end add-point    
 
   IF INT_FLAG THEN
      RETURN
   END IF
 
END FUNCTION
 
{</section>}
 
{<section id="aapt510.filter" >}
#應用 a50 樣板自動產生(Version:8)
#+ filter過濾功能
PRIVATE FUNCTION aapt510_filter()
   #add-point:filter段define name="filter.define_customerization"
   
   #end add-point   
   #add-point:filter段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="filter.define"
   
   #end add-point   
   
   #add-point:Function前置處理  name="filter.pre_function"
   
   #end add-point
   
   #切換畫面
   IF NOT g_main_hidden THEN
      CALL gfrm_curr.setElementHidden("mainlayout",1)
      CALL gfrm_curr.setElementHidden("worksheet",0)
      LET g_main_hidden = 1
   END IF   
 
   LET INT_FLAG = 0
 
   LET g_qryparam.state = 'c'
 
   LET g_wc_filter_t = g_wc_filter.trim()
   LET g_wc_t = g_wc
 
   LET g_wc = cl_replace_str(g_wc, g_wc_filter_t, '')
 
   #使用DIALOG包住 單頭CONSTRUCT及單身CONSTRUCT
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
 
      #單頭
      CONSTRUCT g_wc_filter ON apgacomp,apgadocno
                          FROM s_browse[1].b_apgacomp,s_browse[1].b_apgadocno
 
         BEFORE CONSTRUCT
               DISPLAY aapt510_filter_parser('apgacomp') TO s_browse[1].b_apgacomp
            DISPLAY aapt510_filter_parser('apgadocno') TO s_browse[1].b_apgadocno
      
         #add-point:filter段cs_ctrl name="filter.cs_ctrl"
         
         #end add-point
      
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
 
   IF NOT INT_FLAG THEN
      LET g_wc_filter = "   AND   ", g_wc_filter, "   "
      LET g_wc = g_wc , g_wc_filter
   ELSE
      LET g_wc_filter = g_wc_filter_t
      LET g_wc = g_wc_t
   END IF
 
      CALL aapt510_filter_show('apgacomp')
   CALL aapt510_filter_show('apgadocno')
 
END FUNCTION
 
{</section>}
 
{<section id="aapt510.filter_parser" >}
#+ filter過濾功能
PRIVATE FUNCTION aapt510_filter_parser(ps_field)
   #add-point:filter段define name="filter_parser.define_customerization"
   
   #end add-point    
   DEFINE ps_field   STRING
   DEFINE ls_tmp     STRING
   DEFINE li_tmp     LIKE type_t.num10
   DEFINE li_tmp2    LIKE type_t.num10
   DEFINE ls_var     STRING
   #add-point:filter段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="filter_parser.define"
   
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
 
{<section id="aapt510.filter_show" >}
#+ 顯示過濾條件
PRIVATE FUNCTION aapt510_filter_show(ps_field)
   DEFINE ps_field         STRING
   DEFINE lnode_item       om.DomNode
   DEFINE ls_title         STRING
   DEFINE ls_name          STRING
   DEFINE ls_condition     STRING
 
   LET ls_name = "formonly.b_", ps_field
   LET lnode_item = gfrm_curr.findNode("TableColumn", ls_name)
   LET ls_title = lnode_item.getAttribute("text")
   IF ls_title.getIndexOf('※',1) > 0 THEN
      LEt ls_title = ls_title.subString(1,ls_title.getIndexOf('※',1)-1)
   END IF
 
   #顯示資料組合
   LET ls_condition = aapt510_filter_parser(ps_field)
   IF NOT cl_null(ls_condition) THEN
      LET ls_title = ls_title, '※', ls_condition, '※'
   END IF
 
   #將資料顯示回去
   CALL lnode_item.setAttribute("text",ls_title)
 
END FUNCTION
 
{</section>}
 
{<section id="aapt510.query" >}
#+ 資料查詢QBE功能準備
PRIVATE FUNCTION aapt510_query()
   #add-point:query段define(客製用) name="query.define_customerization"
   
   #end add-point   
   DEFINE ls_wc STRING
   #add-point:query段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="query.define"
   
   #end add-point   
   
   #add-point:Function前置處理  name="query.pre_function"
   
   #end add-point
   
   #切換畫面
   IF g_main_hidden THEN
      CALL gfrm_curr.setElementHidden("mainlayout",0)
      CALL gfrm_curr.setElementHidden("worksheet",1)
      LET g_main_hidden = 0
   END IF   
   
   LET ls_wc = g_wc
   
   LET INT_FLAG = 0
   CALL cl_navigator_setting( g_current_idx, g_detail_cnt )
   ERROR ""
   
   #清除畫面及相關資料
   CLEAR FORM
   CALL g_browser.clear()       
   CALL g_apgb_d.clear()
   CALL g_apgb2_d.clear()
   CALL g_apgb3_d.clear()
 
   
   #add-point:query段other name="query.other"
   
   #end add-point   
   
   DISPLAY '' TO FORMONLY.idx
   DISPLAY '' TO FORMONLY.cnt
   DISPLAY '' TO FORMONLY.b_index
   DISPLAY '' TO FORMONLY.b_count
   DISPLAY '' TO FORMONLY.h_index
   DISPLAY '' TO FORMONLY.h_count
   
   CALL aapt510_construct()
 
   IF INT_FLAG THEN
      #取消查詢
      LET INT_FLAG = 0
      #LET g_wc = ls_wc
      LET g_wc = " 1=2"
      CALL aapt510_browser_fill("")
      CALL aapt510_fetch("")
      RETURN
   END IF
   
   #儲存WC資訊
   CALL cl_dlg_save_user_latestqry("("||g_wc||") AND ("||g_wc2||")")
   
   #搜尋後資料初始化 
   LET g_detail_cnt  = 0
   LET g_current_idx = 1
   LET g_current_row = 0
   LET g_detail_idx  = 1
   LET g_detail_idx2 = 1
   LET g_detail_idx_list[1] = 1
   LET g_detail_idx_list[2] = 1
   LET g_detail_idx_list[3] = 1
 
   LET g_error_show  = 1
   LET g_wc_filter   = ""
   LET l_ac = 1
   CALL FGL_SET_ARR_CURR(1)
      CALL aapt510_filter_show('apgacomp')
   CALL aapt510_filter_show('apgadocno')
   CALL aapt510_browser_fill("F")
         
   IF g_browser_cnt = 0 THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code = "-100" 
      LET g_errparam.popup = TRUE 
      CALL cl_err()
   ELSE
      CALL aapt510_fetch("F") 
      #顯示單身筆數
      CALL aapt510_idx_chk()
   END IF
 
END FUNCTION
 
{</section>}
 
{<section id="aapt510.fetch" >}
#+ 指定PK後抓取單頭其他資料
PRIVATE FUNCTION aapt510_fetch(p_flag)
   #add-point:fetch段define(客製用) name="fetch.define_customerization"
   
   #end add-point    
   DEFINE p_flag     LIKE type_t.chr1
   DEFINE ls_msg     STRING
   #add-point:fetch段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="fetch.define"
   
   #end add-point    
   
   #add-point:Function前置處理  name="fetch.pre_function"
   
   #end add-point
   
   IF g_browser_cnt = 0 THEN
      RETURN
   END IF
 
   #清空第二階單身
 
   
   CALL cl_ap_performance_next_start()
   CASE p_flag
      WHEN 'F' 
         LET g_current_idx = 1
      WHEN 'L'  
         LET g_current_idx = g_browser.getLength()              
      WHEN 'P'
         IF g_current_idx > 1 THEN               
            LET g_current_idx = g_current_idx - 1
         END IF 
      WHEN 'N'
         IF g_current_idx < g_header_cnt THEN
            LET g_current_idx =  g_current_idx + 1
         END IF        
      WHEN '/'
         IF (NOT g_no_ask) THEN    
            CALL cl_set_act_visible("accept,cancel", TRUE)    
            CALL cl_getmsg('fetch',g_lang) RETURNING ls_msg
            LET INT_FLAG = 0
 
            PROMPT ls_msg CLIPPED,':' FOR g_jump
               #交談指令共用ACTION
               &include "common_action.4gl" 
            END PROMPT
 
            CALL cl_set_act_visible("accept,cancel", FALSE)    
            IF INT_FLAG THEN
                LET INT_FLAG = 0
                EXIT CASE  
            END IF           
         END IF
         
         IF g_jump > 0 AND g_jump <= g_browser.getLength() THEN
             LET g_current_idx = g_jump
         END IF
         LET g_no_ask = FALSE  
   END CASE 
 
   CALL g_curr_diag.setCurrentRow("s_browse", g_current_idx) #設定browse 索引
   
   LET g_current_row = g_current_idx
   LET g_detail_cnt = g_header_cnt                  
   
   #單身總筆數顯示
   IF g_detail_cnt > 0 THEN
      #若單身有資料時, idx至少為1
      IF g_detail_idx <= 0 THEN
         LET g_detail_idx = 1
      END IF
      DISPLAY g_detail_idx TO FORMONLY.idx  
   ELSE
      LET g_detail_idx = 0
      DISPLAY '' TO FORMONLY.idx    
   END IF
   
   #瀏覽頁筆數顯示
   LET g_browser_idx = g_pagestart+g_current_idx-1
   DISPLAY g_browser_idx TO FORMONLY.b_index   #當下筆數
   DISPLAY g_browser_idx TO FORMONLY.h_index   #當下筆數
   
   CALL cl_navigator_setting( g_current_idx, g_browser_cnt )
 
   #代表沒有資料
   IF g_current_idx = 0 OR g_browser.getLength() = 0 THEN
      RETURN
   END IF
   
   #避免超出browser資料筆數上限
   IF g_current_idx > g_browser.getLength() THEN
      LET g_browser_idx = g_browser.getLength()
      LET g_current_idx = g_browser.getLength()
   END IF
   
   LET g_apga_m.apgacomp = g_browser[g_current_idx].b_apgacomp
   LET g_apga_m.apgadocno = g_browser[g_current_idx].b_apgadocno
 
   
   #重讀DB,因TEMP有不被更新特性
   EXECUTE aapt510_master_referesh USING g_apga_m.apgacomp,g_apga_m.apgadocno INTO g_apga_m.apgacomp, 
       g_apga_m.apga005,g_apga_m.apga006,g_apga_m.apgadocno,g_apga_m.apga002,g_apga_m.apgadocdt,g_apga_m.apga003, 
       g_apga_m.apga004,g_apga_m.apga001,g_apga_m.apga028,g_apga_m.apga029,g_apga_m.apgastus,g_apga_m.apgaownid, 
       g_apga_m.apgaowndp,g_apga_m.apgacrtid,g_apga_m.apgacrtdp,g_apga_m.apgacrtdt,g_apga_m.apgamodid, 
       g_apga_m.apgamoddt,g_apga_m.apgacnfid,g_apga_m.apgacnfdt,g_apga_m.apgapstid,g_apga_m.apgapstdt, 
       g_apga_m.apga007,g_apga_m.apga030,g_apga_m.apga008,g_apga_m.apga009,g_apga_m.apga013,g_apga_m.apga012, 
       g_apga_m.apga010,g_apga_m.apga014,g_apga_m.apga011,g_apga_m.apga100,g_apga_m.apga015,g_apga_m.apga103, 
       g_apga_m.apga104,g_apga_m.apga108,g_apga_m.apga102,g_apga_m.apga026,g_apga_m.apga040,g_apga_m.apga109, 
       g_apga_m.apga101,g_apga_m.apga113,g_apga_m.apga114,g_apga_m.apga118,g_apga_m.apga112,g_apga_m.apga105, 
       g_apga_m.apga016,g_apga_m.apga017,g_apga_m.apga018,g_apga_m.apga115,g_apga_m.apga106,g_apga_m.apga107, 
       g_apga_m.apga019,g_apga_m.apga020,g_apga_m.apga021,g_apga_m.apga022,g_apga_m.apga023,g_apga_m.apga024, 
       g_apga_m.apga025,g_apga_m.apga036,g_apga_m.apga037,g_apga_m.apga032,g_apga_m.apga034,g_apga_m.apga035, 
       g_apga_m.apga031,g_apga_m.apga038,g_apga_m.apga039,g_apga_m.apga033,g_apga_m.apga027,g_apga_m.apgacomp_desc, 
       g_apga_m.apga005_desc,g_apga_m.apga004_desc,g_apga_m.apgaownid_desc,g_apga_m.apgaowndp_desc,g_apga_m.apgacrtid_desc, 
       g_apga_m.apgacrtdp_desc,g_apga_m.apgamodid_desc,g_apga_m.apgacnfid_desc,g_apga_m.apgapstid_desc, 
       g_apga_m.apga007_desc,g_apga_m.apga030_desc,g_apga_m.apga020_desc,g_apga_m.apga036_desc,g_apga_m.apga037_desc, 
       g_apga_m.apga034_desc,g_apga_m.apga035_desc,g_apga_m.apga038_desc,g_apga_m.apga039_desc
   
   #遮罩相關處理
   LET g_apga_m_mask_o.* =  g_apga_m.*
   CALL aapt510_apga_t_mask()
   LET g_apga_m_mask_n.* =  g_apga_m.*
   
   #根據資料狀態切換action狀態
   CALL cl_set_act_visible("statechange,modify,modify_detail,delete,reproduce", TRUE)
   CALL aapt510_set_act_visible()   
   CALL aapt510_set_act_no_visible()
   
   #add-point:fetch段action控制 name="fetch.action_control"
   #160428-00001#1 ---s---
   LET g_apga_m.l_apga1041 = g_apga_m.apga104
   LET g_apga_m.l_apga1081 = g_apga_m.apga108
   LET g_apga_m.l_apga1021 = g_apga_m.apga102
   SELECT glaa001 INTO g_apga_m.glaa001 FROM glaa_t
    WHERE glaaent = g_enterprise AND glaacomp = g_apga_m.apgacomp
      AND glaa014 = 'Y'   #albireo 160627 add
   DISPLAY BY NAME g_apga_m.glaa001
   #160428-00001#1 ---s--
   
   
   CALL aapt510_set_visible('')
   CALL aapt510_set_no_visible('')
   #end add-point  
   
   
   
   #add-point:fetch結束前 name="fetch.after"
   
   #end add-point
   
   #保存單頭舊值
   LET g_apga_m_t.* = g_apga_m.*
   LET g_apga_m_o.* = g_apga_m.*
   
   LET g_data_owner = g_apga_m.apgaownid      
   LET g_data_dept  = g_apga_m.apgaowndp
   
   #重新顯示   
   CALL aapt510_show()
 
   #應用 a56 樣板自動產生(Version:3)
   #檢查此單據是否需顯示BPM簽核狀況按鈕 
   IF cl_bpm_chk() THEN
      CALL cl_set_act_visible("bpm_status",TRUE)
   ELSE
      CALL cl_set_act_visible("bpm_status",FALSE)
   END IF
 
 
 
 
 
END FUNCTION
 
{</section>}
 
{<section id="aapt510.insert" >}
#+ 資料新增
PRIVATE FUNCTION aapt510_insert()
   #add-point:insert段define(客製用) name="insert.define_customerization"
   
   #end add-point    
   #add-point:insert段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="insert.define"
   DEFINE l_count   LIKE type_t.num10
   DEFINE l_ld      LIKE apca_t.apcald
   #end add-point    
   
   #add-point:Function前置處理  name="insert.pre_function"
   DEFINE l_glaa005     LIKE glaa_t.glaa005
   #end add-point
   
   #清畫面欄位內容
   CLEAR FORM                    
   CALL g_apgb_d.clear()   
   CALL g_apgb2_d.clear()  
   CALL g_apgb3_d.clear()  
 
 
   INITIALIZE g_apga_m.* TO NULL             #DEFAULT 設定
   
   LET g_apgacomp_t = NULL
   LET g_apgadocno_t = NULL
 
   
   LET g_master_insert = FALSE
   
   #add-point:insert段before name="insert.before"
   
   #end add-point    
   
   CALL s_transaction_begin()
   WHILE TRUE
      #公用欄位給值(單頭)
      #應用 a14 樣板自動產生(Version:5)    
      #公用欄位新增給值  
      LET g_apga_m.apgaownid = g_user
      LET g_apga_m.apgaowndp = g_dept
      LET g_apga_m.apgacrtid = g_user
      LET g_apga_m.apgacrtdp = g_dept 
      LET g_apga_m.apgacrtdt = cl_get_current()
      LET g_apga_m.apgamodid = g_user
      LET g_apga_m.apgamoddt = cl_get_current()
      LET g_apga_m.apgastus = 'N'
 
 
 
 
      #append欄位給值
      
     
      #一般欄位給值
            LET g_apga_m.apga002 = "0"
      LET g_apga_m.apga015 = "0"
      LET g_apga_m.apga103 = "0"
      LET g_apga_m.apga104 = "0"
      LET g_apga_m.apga108 = "0"
      LET g_apga_m.apga102 = "0"
      LET g_apga_m.apga109 = "0"
      LET g_apga_m.apga101 = "0"
      LET g_apga_m.apga113 = "0"
      LET g_apga_m.apga114 = "0"
      LET g_apga_m.apga118 = "0"
      LET g_apga_m.apga112 = "0"
      LET g_apga_m.apga105 = "0"
      LET g_apga_m.apga016 = "0"
      LET g_apga_m.apga017 = "0"
      LET g_apga_m.apga115 = "0"
      LET g_apga_m.apga106 = "0"
      LET g_apga_m.apga107 = "0"
      LET g_apga_m.l_apga1041 = "0"
      LET g_apga_m.l_apga1081 = "0"
      LET g_apga_m.l_apga1021 = "0"
 
  
      #add-point:單頭預設值 name="insert.default"
      SELECT ooef017 INTO g_apga_m.apgacomp FROM ooef_t
       WHERE ooefent = g_enterprise
         AND ooef001 = g_site
      
      #kris提示法人控卡若不存在azzi800設定則不可使用
      #此時不需展組織
      #orga才需展組織
      LET l_count = NULL      
      SELECT COUNT(*) INTO l_count
        FROM gzxc_t 
       WHERE gzxcent  = g_enterprise AND gzxc001 = g_user
         AND gzxcstus = 'Y'
         AND gzxc004  = g_apga_m.apgacomp
      IF cl_null(l_count)THEN LET l_count = 0 END IF
      
      IF l_count = 0 THEN
         LET g_apga_m.apgacomp = ''
      ELSE
         LET g_apga_m.apgacomp_desc = s_desc_get_department_desc(g_apga_m.apgacomp)
      END IF
      DISPLAY BY NAME g_apga_m.apgacomp_desc
      
      LET g_apga_m.apgadocdt = g_today
      LET g_apga_m.apga002   = '0'
      LET g_apga_m.apga003   = g_today
      LET g_apga_m.apga005   = g_user
      LET g_apga_m.apga005_desc = s_desc_get_person_desc(g_apga_m.apga005)
      DISPLAY BY NAME g_apga_m.apga005_desc
      
      LET g_apga_m.apga006 = '1'
      LET g_apga_m.apga008 = '2'
      LET g_apga_m.apga009 = 'N'
      LET g_apga_m.apga010 = g_apga_m.apgadocdt
      LET g_apga_m.apga012 = g_apga_m.apgadocdt
      LET g_apga_m.apga014 = 'Y'
      LET g_apga_m.apga015 = 0
      LET g_apga_m.apga016 = 0
      LET g_apga_m.apga017 = 0
      LET g_apga_m.apga026 = 'N'
      LET g_apga_m.apga029 = 'N'
      LET g_apga_m.apga108 = 0
      #160428-00001#1---s---
      LET l_ld = NULL
      SELECT glaald,glaa005 INTO l_ld,l_glaa005 FROM glaa_t
       WHERE glaaent = g_enterprise
         AND glaacomp = g_apga_m.apgacomp
         AND glaa014 = 'Y'
      #自備款
      SELECT glab006,glab007 INTO g_apga_m.apga036,g_apga_m.apga037
        FROM glab_t
       WHERE glab002 = '3117' AND glab001 = '15' AND glab003 = '8504_32' AND glabld = l_ld
         AND glabent = g_enterprise
      #保證金
      SELECT glab006,glab007 INTO g_apga_m.apga034,g_apga_m.apga035
        FROM glab_t
       WHERE glab002 = '3117' AND glab001 = '15' AND glab003 = '8504_31' AND glabld = l_ld  
         AND glabent = g_enterprise
       #保證金
      SELECT glab006,glab007 INTO g_apga_m.apga038,g_apga_m.apga039
        FROM glab_t
       WHERE glab002 = '3117' AND glab001 = '15' AND glab003 = '8504_33' AND glabld = l_ld 
         AND glabent = g_enterprise
       #160428-00001#1---e---
      
      CALL s_desc_get_nmajl003_desc(g_apga_m.apga036) RETURNING g_apga_m.apga036_desc
      CALL s_desc_get_nmail004_desc(l_glaa005,g_apga_m.apga037) RETURNING g_apga_m.apga037_desc                                     
      CALL s_desc_get_nmajl003_desc(g_apga_m.apga034) RETURNING g_apga_m.apga034_desc
      CALL s_desc_get_nmail004_desc(l_glaa005,g_apga_m.apga035) RETURNING g_apga_m.apga035_desc
      CALL s_desc_get_nmajl003_desc(g_apga_m.apga038) RETURNING g_apga_m.apga038_desc
      CALL s_desc_get_nmail004_desc(l_glaa005,g_apga_m.apga039) RETURNING g_apga_m.apga039_desc

      DISPLAY BY NAME g_apga_m.apga034_desc,g_apga_m.apga035_desc,g_apga_m.apga036_desc,
                      g_apga_m.apga037_desc,g_apga_m.apga038_desc,g_apga_m.apga039_desc
                      
      #albireo 160627-----s
      SELECT glaa001 INTO g_apga_m.glaa001 FROM glaa_t
       WHERE glaaent = g_enterprise AND glaacomp = g_apga_m.apgacomp
         AND glaa014 = 'Y'   
      DISPLAY BY NAME g_apga_m.glaa001
      #albireo 160627-----e
      
      #160824-00049#1-----s
      CALL s_fin_account_center_sons_query('8',g_apga_m.apgacomp,g_apga_m.apgadocdt,'1')
      CALL s_fin_account_center_sons_str() RETURNING g_wc_apgborga
      CALL s_fin_get_wc_str(g_wc_apgborga) RETURNING g_wc_apgborga
      
      CALL aapt510_set_visible('')
      CALL aapt510_set_no_visible('')
      #160824-00049#1-----e
      #CALL s_control_get_supplier_sql_pmab('4',g_site,g_user,g_dept,'',g_apga_m.apgacomp) RETURNING g_sub_success,g_sql_ctrl #161115-00042#5-add #161229-00047#51 mark
      CALL s_fin_get_wc_str(g_apga_m.apgacomp) RETURNING g_comp_str  #161229-00047#51 add 
      CALL s_control_get_supplier_sql_pmab('4',g_site,g_user,g_dept,'',g_comp_str) RETURNING g_sub_success,g_sql_ctrl #161229-00047#51 add 
      #end add-point 
      
      #保存單頭舊值(用於資料輸入錯誤還原預設值時使用)
      LET g_apga_m_t.* = g_apga_m.*
      LET g_apga_m_o.* = g_apga_m.*
      
      #顯示狀態(stus)圖片
            #應用 a21 樣板自動產生(Version:3)
	  #根據當下狀態碼顯示圖片
      CASE g_apga_m.apgastus 
         WHEN "N"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/unconfirmed.png")
         WHEN "Y"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/confirmed.png")
         WHEN "A"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/approved.png")
         WHEN "D"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/withdraw.png")
         WHEN "R"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/rejection.png")
         WHEN "W"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/signing.png")
         WHEN "X"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/invalid.png")
         
      END CASE
 
 
 
    
      CALL aapt510_input("a")
      
      #add-point:單頭輸入後 name="insert.after_insert"
      
      #end add-point
      
      IF INT_FLAG THEN
         LET INT_FLAG = 0
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = '' 
         LET g_errparam.code = 9001 
         LET g_errparam.popup = FALSE 
         CALL s_transaction_end('N','0')
         CALL cl_err()
      END IF
      
      IF NOT g_master_insert THEN
         DISPLAY g_detail_cnt  TO FORMONLY.h_count    #總筆數
         DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
         INITIALIZE g_apga_m.* TO NULL
         INITIALIZE g_apgb_d TO NULL
         INITIALIZE g_apgb2_d TO NULL
         INITIALIZE g_apgb3_d TO NULL
 
         #add-point:取消新增後 name="insert.cancel"
         
         #end add-point 
         CALL aapt510_show()
         RETURN
      END IF
      
      LET INT_FLAG = 0
      #CALL g_apgb_d.clear()
      #CALL g_apgb2_d.clear()
      #CALL g_apgb3_d.clear()
 
 
      LET g_rec_b = 0
      CALL s_transaction_end('Y','0')
      EXIT WHILE
        
   END WHILE
   
   #根據資料狀態切換action狀態
   CALL cl_set_act_visible("statechange,modify,modify_detail,delete,reproduce", TRUE)
   CALL aapt510_set_act_visible()   
   CALL aapt510_set_act_no_visible()
   
   #將新增的資料併入搜尋條件中
   LET g_apgacomp_t = g_apga_m.apgacomp
   LET g_apgadocno_t = g_apga_m.apgadocno
 
   
   #組合新增資料的條件
   LET g_add_browse = " apgaent = " ||g_enterprise|| " AND",
                      " apgacomp = '", g_apga_m.apgacomp, "' "
                      ," AND apgadocno = '", g_apga_m.apgadocno, "' "
 
                      
   #add-point:組合新增資料的條件後 name="insert.after.add_browse"
   
   #end add-point
      
   #填到最後面
   LET g_current_idx = g_browser.getLength() + 1
   CALL aapt510_browser_fill("")
   
   DISPLAY g_browser_cnt TO FORMONLY.h_count    #總筆數
   DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
   CALL cl_navigator_setting(g_current_idx, g_browser_cnt)
   
   CLOSE aapt510_cl
   
   CALL aapt510_idx_chk()
   
   #撈取異動後的資料(主要是帶出reference)
   EXECUTE aapt510_master_referesh USING g_apga_m.apgacomp,g_apga_m.apgadocno INTO g_apga_m.apgacomp, 
       g_apga_m.apga005,g_apga_m.apga006,g_apga_m.apgadocno,g_apga_m.apga002,g_apga_m.apgadocdt,g_apga_m.apga003, 
       g_apga_m.apga004,g_apga_m.apga001,g_apga_m.apga028,g_apga_m.apga029,g_apga_m.apgastus,g_apga_m.apgaownid, 
       g_apga_m.apgaowndp,g_apga_m.apgacrtid,g_apga_m.apgacrtdp,g_apga_m.apgacrtdt,g_apga_m.apgamodid, 
       g_apga_m.apgamoddt,g_apga_m.apgacnfid,g_apga_m.apgacnfdt,g_apga_m.apgapstid,g_apga_m.apgapstdt, 
       g_apga_m.apga007,g_apga_m.apga030,g_apga_m.apga008,g_apga_m.apga009,g_apga_m.apga013,g_apga_m.apga012, 
       g_apga_m.apga010,g_apga_m.apga014,g_apga_m.apga011,g_apga_m.apga100,g_apga_m.apga015,g_apga_m.apga103, 
       g_apga_m.apga104,g_apga_m.apga108,g_apga_m.apga102,g_apga_m.apga026,g_apga_m.apga040,g_apga_m.apga109, 
       g_apga_m.apga101,g_apga_m.apga113,g_apga_m.apga114,g_apga_m.apga118,g_apga_m.apga112,g_apga_m.apga105, 
       g_apga_m.apga016,g_apga_m.apga017,g_apga_m.apga018,g_apga_m.apga115,g_apga_m.apga106,g_apga_m.apga107, 
       g_apga_m.apga019,g_apga_m.apga020,g_apga_m.apga021,g_apga_m.apga022,g_apga_m.apga023,g_apga_m.apga024, 
       g_apga_m.apga025,g_apga_m.apga036,g_apga_m.apga037,g_apga_m.apga032,g_apga_m.apga034,g_apga_m.apga035, 
       g_apga_m.apga031,g_apga_m.apga038,g_apga_m.apga039,g_apga_m.apga033,g_apga_m.apga027,g_apga_m.apgacomp_desc, 
       g_apga_m.apga005_desc,g_apga_m.apga004_desc,g_apga_m.apgaownid_desc,g_apga_m.apgaowndp_desc,g_apga_m.apgacrtid_desc, 
       g_apga_m.apgacrtdp_desc,g_apga_m.apgamodid_desc,g_apga_m.apgacnfid_desc,g_apga_m.apgapstid_desc, 
       g_apga_m.apga007_desc,g_apga_m.apga030_desc,g_apga_m.apga020_desc,g_apga_m.apga036_desc,g_apga_m.apga037_desc, 
       g_apga_m.apga034_desc,g_apga_m.apga035_desc,g_apga_m.apga038_desc,g_apga_m.apga039_desc
   
   
   #遮罩相關處理
   LET g_apga_m_mask_o.* =  g_apga_m.*
   CALL aapt510_apga_t_mask()
   LET g_apga_m_mask_n.* =  g_apga_m.*
   
   #將資料顯示到畫面上
   DISPLAY BY NAME g_apga_m.apgacomp,g_apga_m.apgacomp_desc,g_apga_m.apga005,g_apga_m.apga005_desc,g_apga_m.apga006, 
       g_apga_m.apgadocno,g_apga_m.apga002,g_apga_m.apgadocdt,g_apga_m.apga003,g_apga_m.apga004,g_apga_m.apga004_desc, 
       g_apga_m.apga001,g_apga_m.apga028,g_apga_m.apga029,g_apga_m.apgastus,g_apga_m.apgaownid,g_apga_m.apgaownid_desc, 
       g_apga_m.apgaowndp,g_apga_m.apgaowndp_desc,g_apga_m.apgacrtid,g_apga_m.apgacrtid_desc,g_apga_m.apgacrtdp, 
       g_apga_m.apgacrtdp_desc,g_apga_m.apgacrtdt,g_apga_m.apgamodid,g_apga_m.apgamodid_desc,g_apga_m.apgamoddt, 
       g_apga_m.apgacnfid,g_apga_m.apgacnfid_desc,g_apga_m.apgacnfdt,g_apga_m.apgapstid,g_apga_m.apgapstid_desc, 
       g_apga_m.apgapstdt,g_apga_m.apga007,g_apga_m.apga007_desc,g_apga_m.apga030,g_apga_m.apga030_desc, 
       g_apga_m.apga008,g_apga_m.apga009,g_apga_m.apga013,g_apga_m.apga012,g_apga_m.apga010,g_apga_m.apga014, 
       g_apga_m.apga011,g_apga_m.apga100,g_apga_m.apga015,g_apga_m.apga103,g_apga_m.apga104,g_apga_m.apga108, 
       g_apga_m.apga102,g_apga_m.apga026,g_apga_m.apga040,g_apga_m.apga109,g_apga_m.glaa001,g_apga_m.apga101, 
       g_apga_m.apga113,g_apga_m.apga114,g_apga_m.apga118,g_apga_m.apga112,g_apga_m.apga105,g_apga_m.apga016, 
       g_apga_m.apga017,g_apga_m.apga018,g_apga_m.apga115,g_apga_m.apga106,g_apga_m.apga107,g_apga_m.apga019, 
       g_apga_m.apga020,g_apga_m.apga020_desc,g_apga_m.apga021,g_apga_m.apga022,g_apga_m.apga023,g_apga_m.apga024, 
       g_apga_m.apga025,g_apga_m.l_apga1041,g_apga_m.apga036,g_apga_m.apga036_desc,g_apga_m.apga037, 
       g_apga_m.apga037_desc,g_apga_m.apga032,g_apga_m.l_apga1081,g_apga_m.apga034,g_apga_m.apga034_desc, 
       g_apga_m.apga035,g_apga_m.apga035_desc,g_apga_m.apga031,g_apga_m.l_apga1021,g_apga_m.apga038, 
       g_apga_m.apga038_desc,g_apga_m.apga039,g_apga_m.apga039_desc,g_apga_m.apga033,g_apga_m.apga027 
 
   
   #add-point:新增結束後 name="insert.after"
   
   #end add-point 
   
   LET g_data_owner = g_apga_m.apgaownid      
   LET g_data_dept  = g_apga_m.apgaowndp
   
   #功能已完成,通報訊息中心
   CALL aapt510_msgcentre_notify('insert')
   
END FUNCTION
 
{</section>}
 
{<section id="aapt510.modify" >}
#+ 資料修改
PRIVATE FUNCTION aapt510_modify()
   #add-point:modify段define(客製用) name="modify.define_customerization"
   
   #end add-point    
   DEFINE l_new_key    DYNAMIC ARRAY OF STRING
   DEFINE l_old_key    DYNAMIC ARRAY OF STRING
   DEFINE l_field_key  DYNAMIC ARRAY OF STRING
   DEFINE l_wc2_table1          STRING
   DEFINE l_wc2_table2   STRING
 
   DEFINE l_wc2_table3   STRING
 
 
 
   #add-point:modify段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="modify.define"
   
   #end add-point    
   
   #add-point:Function前置處理  name="modify.pre_function"
   
   #end add-point
   
   #保存單頭舊值
   LET g_apga_m_t.* = g_apga_m.*
   LET g_apga_m_o.* = g_apga_m.*
   
   IF g_apga_m.apgacomp IS NULL
   OR g_apga_m.apgadocno IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code = "std-00003" 
      LET g_errparam.popup = FALSE 
      CALL cl_err()
      RETURN
   END IF
 
   ERROR ""
  
   LET g_apgacomp_t = g_apga_m.apgacomp
   LET g_apgadocno_t = g_apga_m.apgadocno
 
   CALL s_transaction_begin()
   
   OPEN aapt510_cl USING g_enterprise,g_apga_m.apgacomp,g_apga_m.apgadocno
   IF SQLCA.SQLCODE THEN   #(ver:78)
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "OPEN aapt510_cl:",SQLERRMESSAGE 
      LET g_errparam.code = SQLCA.SQLCODE   #(ver:78)
      LET g_errparam.popup = TRUE 
      CLOSE aapt510_cl
      CALL s_transaction_end('N','0')
      CALL cl_err()
      RETURN
   END IF
 
   #顯示最新的資料
   EXECUTE aapt510_master_referesh USING g_apga_m.apgacomp,g_apga_m.apgadocno INTO g_apga_m.apgacomp, 
       g_apga_m.apga005,g_apga_m.apga006,g_apga_m.apgadocno,g_apga_m.apga002,g_apga_m.apgadocdt,g_apga_m.apga003, 
       g_apga_m.apga004,g_apga_m.apga001,g_apga_m.apga028,g_apga_m.apga029,g_apga_m.apgastus,g_apga_m.apgaownid, 
       g_apga_m.apgaowndp,g_apga_m.apgacrtid,g_apga_m.apgacrtdp,g_apga_m.apgacrtdt,g_apga_m.apgamodid, 
       g_apga_m.apgamoddt,g_apga_m.apgacnfid,g_apga_m.apgacnfdt,g_apga_m.apgapstid,g_apga_m.apgapstdt, 
       g_apga_m.apga007,g_apga_m.apga030,g_apga_m.apga008,g_apga_m.apga009,g_apga_m.apga013,g_apga_m.apga012, 
       g_apga_m.apga010,g_apga_m.apga014,g_apga_m.apga011,g_apga_m.apga100,g_apga_m.apga015,g_apga_m.apga103, 
       g_apga_m.apga104,g_apga_m.apga108,g_apga_m.apga102,g_apga_m.apga026,g_apga_m.apga040,g_apga_m.apga109, 
       g_apga_m.apga101,g_apga_m.apga113,g_apga_m.apga114,g_apga_m.apga118,g_apga_m.apga112,g_apga_m.apga105, 
       g_apga_m.apga016,g_apga_m.apga017,g_apga_m.apga018,g_apga_m.apga115,g_apga_m.apga106,g_apga_m.apga107, 
       g_apga_m.apga019,g_apga_m.apga020,g_apga_m.apga021,g_apga_m.apga022,g_apga_m.apga023,g_apga_m.apga024, 
       g_apga_m.apga025,g_apga_m.apga036,g_apga_m.apga037,g_apga_m.apga032,g_apga_m.apga034,g_apga_m.apga035, 
       g_apga_m.apga031,g_apga_m.apga038,g_apga_m.apga039,g_apga_m.apga033,g_apga_m.apga027,g_apga_m.apgacomp_desc, 
       g_apga_m.apga005_desc,g_apga_m.apga004_desc,g_apga_m.apgaownid_desc,g_apga_m.apgaowndp_desc,g_apga_m.apgacrtid_desc, 
       g_apga_m.apgacrtdp_desc,g_apga_m.apgamodid_desc,g_apga_m.apgacnfid_desc,g_apga_m.apgapstid_desc, 
       g_apga_m.apga007_desc,g_apga_m.apga030_desc,g_apga_m.apga020_desc,g_apga_m.apga036_desc,g_apga_m.apga037_desc, 
       g_apga_m.apga034_desc,g_apga_m.apga035_desc,g_apga_m.apga038_desc,g_apga_m.apga039_desc
   
   #檢查是否允許此動作
   IF NOT aapt510_action_chk() THEN
      CALL s_transaction_end('N','0')
      RETURN
   END IF
   
   #遮罩相關處理
   LET g_apga_m_mask_o.* =  g_apga_m.*
   CALL aapt510_apga_t_mask()
   LET g_apga_m_mask_n.* =  g_apga_m.*
   
   
   
   #add-point:modify段show之前 name="modify.before_show"
   CALL s_fin_account_center_sons_query('8',g_apga_m.apgacomp,g_apga_m.apgadocdt,'1')
   CALL s_fin_account_center_sons_str() RETURNING g_wc_apgborga
   CALL s_fin_get_wc_str(g_wc_apgborga) RETURNING g_wc_apgborga
   #end add-point  
   
   #LET l_wc2_table1 = g_wc2_table1
   #LET g_wc2_table1 = " 1=1"
   #LET l_wc2_table2 = g_wc2_table2
   #LET l_wc2_table2 = " 1=1"
 
   #LET l_wc2_table3 = g_wc2_table3
   #LET l_wc2_table3 = " 1=1"
 
 
 
   
   CALL aapt510_show()
   #add-point:modify段show之後 name="modify.after_show"
   
   #end add-point
   
   #LET g_wc2_table1 = l_wc2_table1
   #LET  g_wc2_table2 = l_wc2_table2 
 
   #LET  g_wc2_table3 = l_wc2_table3 
 
 
 
    
   WHILE TRUE
      LET g_apgacomp_t = g_apga_m.apgacomp
      LET g_apgadocno_t = g_apga_m.apgadocno
 
      
      #寫入修改者/修改日期資訊(單頭)
      LET g_apga_m.apgamodid = g_user 
LET g_apga_m.apgamoddt = cl_get_current()
LET g_apga_m.apgamodid_desc = cl_get_username(g_apga_m.apgamodid)
      
      #add-point:modify段修改前 name="modify.before_input"
      
      #end add-point
      
      #欄位更改
      LET g_loc = 'n'
      LET g_update = FALSE
      LET g_master_commit = "N"
      CALL aapt510_input("u")
      LET g_loc = 'n'
 
      #add-point:modify段修改後 name="modify.after_input"
      
      #end add-point
      
      IF g_update OR NOT INT_FLAG THEN
         #若有modid跟moddt則進行update
         UPDATE apga_t SET (apgamodid,apgamoddt) = (g_apga_m.apgamodid,g_apga_m.apgamoddt)
          WHERE apgaent = g_enterprise AND apgacomp = g_apgacomp_t
            AND apgadocno = g_apgadocno_t
 
      END IF
    
      IF INT_FLAG THEN
         CALL s_transaction_end('N','0')
         LET INT_FLAG = 0
         #若單頭無commit則還原
         IF g_master_commit = "N" THEN
            LET g_apga_m.* = g_apga_m_t.*
            CALL aapt510_show()
         END IF
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = '' 
         LET g_errparam.code = 9001 
         LET g_errparam.popup = FALSE 
         CALL cl_err()
         RETURN
      END IF 
                  
      #若單頭key欄位有變更
      IF g_apga_m.apgacomp != g_apga_m_t.apgacomp
      OR g_apga_m.apgadocno != g_apga_m_t.apgadocno
 
      THEN
         CALL s_transaction_begin()
         
         #add-point:單身fk修改前 name="modify.body.b_fk_update"
         
         #end add-point
         
         #更新單身key值
         UPDATE apgb_t SET apgbcomp = g_apga_m.apgacomp
                                       ,apgbdocno = g_apga_m.apgadocno
 
          WHERE apgbent = g_enterprise AND apgbcomp = g_apga_m_t.apgacomp
            AND apgbdocno = g_apga_m_t.apgadocno
 
            
         #add-point:單身fk修改中 name="modify.body.m_fk_update"
         
         #end add-point
 
         CASE
            WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
            #   INITIALIZE g_errparam TO NULL 
            #   LET g_errparam.extend = "apgb_t" 
            #   LET g_errparam.code = "std-00009" 
            #   LET g_errparam.popup = TRUE 
            #   CALL cl_err()
            #   CALL s_transaction_end('N','0')
            #   CONTINUE WHILE
            WHEN SQLCA.SQLCODE #其他錯誤
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "apgb_t:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE 
               LET g_errparam.popup = TRUE 
               CALL s_transaction_end('N','0')
               CALL cl_err()
               CONTINUE WHILE
         END CASE
         
         #add-point:單身fk修改後 name="modify.body.a_fk_update"
         
         #end add-point
         
         #更新單身key值
         #add-point:單身fk修改前 name="modify.body.b_fk_update2"
         
         #end add-point
         
         UPDATE apgc_t
            SET apgccomp = g_apga_m.apgacomp
               ,apgcdocno = g_apga_m.apgadocno
 
          WHERE apgcent = g_enterprise AND
                apgccomp = g_apgacomp_t
            AND apgcdocno = g_apgadocno_t
 
         #add-point:單身fk修改中 name="modify.body.m_fk_update2"
         
         #end add-point
         CASE
            WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
            #   INITIALIZE g_errparam TO NULL 
            #   LET g_errparam.extend = "apgc_t" 
            #   LET g_errparam.code = "std-00009" 
            #   LET g_errparam.popup = TRUE 
            #   CALL cl_err()
            #   CALL s_transaction_end('N','0')
            #   CONTINUE WHILE
            WHEN SQLCA.SQLCODE #其他錯誤
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "apgc_t:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE 
               LET g_errparam.popup = TRUE 
               CALL s_transaction_end('N','0')
               CALL cl_err()
               CONTINUE WHILE
         END CASE
         #add-point:單身fk修改後 name="modify.body.a_fk_update2"
         
         #end add-point
 
         #更新單身key值
         #add-point:單身fk修改前 name="modify.body.b_fk_update3"
         
         #end add-point
         
         UPDATE xrcd_t
            SET xrcdcomp = g_apga_m.apgacomp
               ,xrcddocno = g_apga_m.apgadocno
 
          WHERE xrcdent = g_enterprise AND
                xrcdcomp = g_apgacomp_t
            AND xrcddocno = g_apgadocno_t
 
         #add-point:單身fk修改中 name="modify.body.m_fk_update3"
         
         #end add-point
         CASE
            WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
            #   INITIALIZE g_errparam TO NULL 
            #   LET g_errparam.extend = "xrcd_t" 
            #   LET g_errparam.code = "std-00009" 
            #   LET g_errparam.popup = TRUE 
            #   CALL cl_err()
            #   CALL s_transaction_end('N','0')
            #   CONTINUE WHILE
            WHEN SQLCA.SQLCODE #其他錯誤
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "xrcd_t:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE 
               LET g_errparam.popup = TRUE 
               CALL s_transaction_end('N','0')
               CALL cl_err()
               CONTINUE WHILE
         END CASE
         #add-point:單身fk修改後 name="modify.body.a_fk_update3"
         
         #end add-point
 
 
         
 
         
         #UPDATE 多語言table key值
         
         
         
 
         CALL s_transaction_end('Y','0')
      END IF
    
      EXIT WHILE
   END WHILE
 
   #根據資料狀態切換action狀態
   CALL cl_set_act_visible("statechange,modify,modify_detail,delete,reproduce", TRUE)
   CALL aapt510_set_act_visible()   
   CALL aapt510_set_act_no_visible()
 
   #組合新增資料的條件
   LET g_add_browse = " apgaent = " ||g_enterprise|| " AND",
                      " apgacomp = '", g_apga_m.apgacomp, "' "
                      ," AND apgadocno = '", g_apga_m.apgadocno, "' "
 
   #填到對應位置
   CALL aapt510_browser_fill("")
 
   CLOSE aapt510_cl
   
   CALL s_transaction_end('Y','0')
 
   #功能已完成,通報訊息中心
   CALL aapt510_msgcentre_notify('modify')
 
END FUNCTION 
 
{</section>}
 
{<section id="aapt510.input" >}
#+ 資料輸入
PRIVATE FUNCTION aapt510_input(p_cmd)
   #add-point:input段define(客製用) name="input.define_customerization"
   
   #end add-point  
   DEFINE  p_cmd                 LIKE type_t.chr1
   DEFINE  l_cmd_t               LIKE type_t.chr1
   DEFINE  l_cmd                 LIKE type_t.chr1
   DEFINE  l_n                   LIKE type_t.num10                #檢查重複用  
   DEFINE  l_cnt                 LIKE type_t.num10                #檢查重複用  
   DEFINE  l_lock_sw             LIKE type_t.chr1                #單身鎖住否  
   DEFINE  l_allow_insert        LIKE type_t.num5                #可新增否 
   DEFINE  l_allow_delete        LIKE type_t.num5                #可刪除否  
   DEFINE  l_count               LIKE type_t.num10
   DEFINE  l_i                   LIKE type_t.num10
   DEFINE  l_ac_t                LIKE type_t.num10
   DEFINE  l_insert              BOOLEAN
   DEFINE  ls_return             STRING
   DEFINE  l_var_keys            DYNAMIC ARRAY OF STRING
   DEFINE  l_field_keys          DYNAMIC ARRAY OF STRING
   DEFINE  l_vars                DYNAMIC ARRAY OF STRING
   DEFINE  l_fields              DYNAMIC ARRAY OF STRING
   DEFINE  l_var_keys_bak        DYNAMIC ARRAY OF STRING
   DEFINE  lb_reproduce          BOOLEAN
   DEFINE  li_reproduce          LIKE type_t.num10
   DEFINE  li_reproduce_target   LIKE type_t.num10
   DEFINE  ls_keys               DYNAMIC ARRAY OF VARCHAR(500)
   #add-point:input段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="input.define"
   DEFINE l_ooef006   LIKE ooef_t.ooef006
   DEFINE l_ld        LIKE glaa_t.glaald
   DEFINE l_glaa024   LIKE glaa_t.glaa024
   DEFINE lc_param      RECORD
            apca004     LIKE apca_t.apca004,
            ooib001     LIKE ooib_t.ooib001        
                    END RECORD
   DEFINE l_glaa001     LIKE glaa_t.glaa001
   DEFINE l_dummy1      LIKE type_t.num20_6
   DEFINE l_dummy2      LIKE type_t.num20_6
   DEFINE l_dummy3      LIKE type_t.num20_6
   DEFINE l_using       LIKE type_t.num5
   DEFINE ls_js         STRING
   DEFINE l_sql         STRING
   DEFINE l_imaal003    LIKE imaal_t.imaal003
   DEFINE l_imaal004    LIKE imaal_t.imaal004
   DEFINE l_oodb004     LIKE oodb_t.oodb004
   DEFINE l_apca013     LIKE apca_t.apca013
   DEFINE l_apca012     LIKE apca_t.apca012
   DEFINE l_oodb011     LIKE oodb_t.oodb011
   DEFINE l_ooef019     LIKE ooef_t.ooef019
   
   DEFINE l_pmab037     LIKE pmab_t.pmab037
   DEFINE l_pmab055     LIKE pmab_t.pmab055
   DEFINE l_pmab034     LIKE pmab_t.pmab034 
   DEFINE l_pmab056     LIKE pmab_t.pmab056
   DEFINE l_glab005     LIKE glab_t.glab005
   DEFINE l_glab006     LIKE glab_t.glab006
   DEFINE l_glab007     LIKE glab_t.glab007
   DEFINE l_glaa005     LIKE glaa_t.glaa005
   DEFINE l_glaa004     LIKE glaa_t.glaa004
   DEFINE l_isac004     LIKE isac_t.isac004
   DEFINE l_glaa015     LIKE glaa_t.glaa015
   DEFINE l_glaa019     LIKE glaa_t.glaa019
   DEFINE l_glaa017     LIKE glaa_t.glaa017
   DEFINE l_glaa021     LIKE glaa_t.glaa021
   DEFINE l_xrcd        RECORD
                        xrcd103 LIKE xrcd_t.xrcd103,
                        xrcd104 LIKE xrcd_t.xrcd104,
                        xrcd105 LIKE xrcd_t.xrcd105,
                        xrcd113 LIKE xrcd_t.xrcd113,
                        xrcd114 LIKE xrcd_t.xrcd114,
                        xrcd115 LIKE xrcd_t.xrcd115,                        
                        xrcd123 LIKE xrcd_t.xrcd123,
                        xrcd124 LIKE xrcd_t.xrcd124,
                        xrcd125 LIKE xrcd_t.xrcd125,
                        xrcd133 LIKE xrcd_t.xrcd133,
                        xrcd134 LIKE xrcd_t.xrcd134,
                        xrcd135 LIKE xrcd_t.xrcd135
                        END RECORD
   DEFINE l_comp        LIKE ooef_t.ooef001
   DEFINE l_pmdn007     LIKE pmdn_t.pmdn007
   DEFINE l_apgb008     LIKE apgb_t.apgb008
   DEFINE l_autoins     LIKE type_t.num5
   DEFINE l_wc          STRING
   DEFINE l_apgasum     LIKE type_t.num20_6
   DEFINE l_apgbsum     LIKE type_t.num20_6
   DEFINE l_chr         LIKE type_t.chr1
   DEFINE l_nmas003     LIKE nmas_t.nmas003
   #160428-00001#14-----s
   DEFINE l_apgbseq     LIKE apgb_t.apgbseq
   DEFINE l_apgb105     LIKE apgb_t.apgb105
   DEFINE l_apgb115     LIKE apgb_t.apgb115
   DEFINE l_apgb101     LIKE apgb_t.apgb101
   #160428-00001#14-----e
   
   #160824-00049#1-----s
   DEFINE l_apgc103     LIKE apgc_t.apgc103
   DEFINE l_apgc104     LIKE apgc_t.apgc104
   DEFINE l_apgc105     LIKE apgc_t.apgc105
   DEFINE l_apgc113     LIKE apgc_t.apgc113
   DEFINE l_apgc114     LIKE apgc_t.apgc114
   DEFINE l_apgc115     LIKE apgc_t.apgc115
   DEFINE l_apgcseq     LIKE apgc_t.apgcseq
   #160824-00049#1-----e
   DEFINE l_flag        LIKE type_t.num5      #161104-00046#7
   #end add-point  
   
   #add-point:Function前置處理  name="input.pre_function"
   
   #end add-point
   
   #先做狀態判定
   IF p_cmd = 'r' THEN
      LET l_cmd_t = 'r'
      LET p_cmd   = 'a'
   ELSE
      LET l_cmd_t = p_cmd
   END IF   
   
   #將資料輸出到畫面上
   DISPLAY BY NAME g_apga_m.apgacomp,g_apga_m.apgacomp_desc,g_apga_m.apga005,g_apga_m.apga005_desc,g_apga_m.apga006, 
       g_apga_m.apgadocno,g_apga_m.apga002,g_apga_m.apgadocdt,g_apga_m.apga003,g_apga_m.apga004,g_apga_m.apga004_desc, 
       g_apga_m.apga001,g_apga_m.apga028,g_apga_m.apga029,g_apga_m.apgastus,g_apga_m.apgaownid,g_apga_m.apgaownid_desc, 
       g_apga_m.apgaowndp,g_apga_m.apgaowndp_desc,g_apga_m.apgacrtid,g_apga_m.apgacrtid_desc,g_apga_m.apgacrtdp, 
       g_apga_m.apgacrtdp_desc,g_apga_m.apgacrtdt,g_apga_m.apgamodid,g_apga_m.apgamodid_desc,g_apga_m.apgamoddt, 
       g_apga_m.apgacnfid,g_apga_m.apgacnfid_desc,g_apga_m.apgacnfdt,g_apga_m.apgapstid,g_apga_m.apgapstid_desc, 
       g_apga_m.apgapstdt,g_apga_m.apga007,g_apga_m.apga007_desc,g_apga_m.apga030,g_apga_m.apga030_desc, 
       g_apga_m.apga008,g_apga_m.apga009,g_apga_m.apga013,g_apga_m.apga012,g_apga_m.apga010,g_apga_m.apga014, 
       g_apga_m.apga011,g_apga_m.apga100,g_apga_m.apga015,g_apga_m.apga103,g_apga_m.apga104,g_apga_m.apga108, 
       g_apga_m.apga102,g_apga_m.apga026,g_apga_m.apga040,g_apga_m.apga109,g_apga_m.glaa001,g_apga_m.apga101, 
       g_apga_m.apga113,g_apga_m.apga114,g_apga_m.apga118,g_apga_m.apga112,g_apga_m.apga105,g_apga_m.apga016, 
       g_apga_m.apga017,g_apga_m.apga018,g_apga_m.apga115,g_apga_m.apga106,g_apga_m.apga107,g_apga_m.apga019, 
       g_apga_m.apga020,g_apga_m.apga020_desc,g_apga_m.apga021,g_apga_m.apga022,g_apga_m.apga023,g_apga_m.apga024, 
       g_apga_m.apga025,g_apga_m.l_apga1041,g_apga_m.apga036,g_apga_m.apga036_desc,g_apga_m.apga037, 
       g_apga_m.apga037_desc,g_apga_m.apga032,g_apga_m.l_apga1081,g_apga_m.apga034,g_apga_m.apga034_desc, 
       g_apga_m.apga035,g_apga_m.apga035_desc,g_apga_m.apga031,g_apga_m.l_apga1021,g_apga_m.apga038, 
       g_apga_m.apga038_desc,g_apga_m.apga039,g_apga_m.apga039_desc,g_apga_m.apga033,g_apga_m.apga027 
 
   
   #切換畫面
   IF g_main_hidden THEN
      CALL gfrm_curr.setElementHidden("mainlayout",0)
      CALL gfrm_curr.setElementHidden("worksheet",1)
      LET g_main_hidden = 0
   END IF
 
   CALL cl_set_head_visible("","YES")  
 
   LET l_insert = FALSE
   LET g_action_choice = ""
 
   #add-point:input段define_sql name="input.define_sql"
   
   #end add-point 
   LET g_forupd_sql = "SELECT apgbseq,apgborga,apgb001,apgb002,apgb003,apgb004,apgb005,apgb008,apgb006, 
       apgb007,apgb100,apgb101,apgb009,apgb105,apgb115,apgb010,apgb011 FROM apgb_t WHERE apgbent=? AND  
       apgbcomp=? AND apgbdocno=? AND apgbseq=? FOR UPDATE"
   #add-point:input段define_sql name="input.after_define_sql"
   
   #end add-point 
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE aapt510_bcl CURSOR FROM g_forupd_sql
   
   #add-point:input段define_sql name="input.define_sql2"
   
   #end add-point    
   LET g_forupd_sql = "SELECT apgc900,apgcseq,apgcorga,apgc001,apgc002,apgc003,apgc005,apgc014,apgc100, 
       apgc101,apgc006,apgc007,apgc008,apgc009,apgc010,apgc011,apgc103,apgc104,apgc105,apgc113,apgc114, 
       apgc115,apgc004,apgc015,apgc016,apgc012,apgc013 FROM apgc_t WHERE apgcent=? AND apgccomp=? AND  
       apgcdocno=? AND apgcseq=? AND apgc900=? FOR UPDATE"
   #add-point:input段define_sql name="input.after_define_sql2"
   
   #end add-point
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE aapt510_bcl2 CURSOR FROM g_forupd_sql
 
   #add-point:input段define_sql name="input.define_sql3"
   
   #end add-point    
   LET g_forupd_sql = "SELECT xrcdseq,xrcdseq2,xrcd007,xrcdld,xrcd002,xrcd003,xrcd006,xrcd005,xrcd102, 
       xrcd103,xrcd104,xrcd105,xrcd113,xrcd114,xrcd115,xrcd123,xrcd124,xrcd125,xrcd133,xrcd134,xrcd135, 
       xrcdorga,xrcd009,xrcd001,xrcd004,xrcd100,xrcd101,xrcd106,xrcd112,xrcd116,xrcd117,xrcd118,xrcd121, 
       xrcd131,xrcdsite FROM xrcd_t WHERE xrcdent=? AND xrcdcomp=? AND xrcddocno=? AND xrcdld=? AND  
       xrcdseq=? AND xrcdseq2=? AND xrcd007=? FOR UPDATE"
   #add-point:input段define_sql name="input.after_define_sql3"
   
   #end add-point
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE aapt510_bcl3 CURSOR FROM g_forupd_sql
 
 
   
 
 
   #add-point:input段define_sql name="input.other_sql"
   
   #end add-point 
 
   LET l_allow_insert = cl_auth_detail_input("insert")
   LET l_allow_delete = cl_auth_detail_input("delete")
   LET g_qryparam.state = 'i'
   
   #控制key欄位可否輸入
   CALL aapt510_set_entry(p_cmd)
   #add-point:set_entry後 name="input.after_set_entry"
   CALL aapt510_set_no_required(p_cmd)
   CALL aapt510_set_required(p_cmd)
   #end add-point
   CALL aapt510_set_no_entry(p_cmd)
 
   DISPLAY BY NAME g_apga_m.apgacomp,g_apga_m.apga005,g_apga_m.apga006,g_apga_m.apgadocno,g_apga_m.apga002, 
       g_apga_m.apgadocdt,g_apga_m.apga003,g_apga_m.apga004,g_apga_m.apga001,g_apga_m.apga028,g_apga_m.apga029, 
       g_apga_m.apgastus,g_apga_m.apga007,g_apga_m.apga030,g_apga_m.apga008,g_apga_m.apga009,g_apga_m.apga013, 
       g_apga_m.apga012,g_apga_m.apga010,g_apga_m.apga014,g_apga_m.apga011,g_apga_m.apga100,g_apga_m.apga015, 
       g_apga_m.apga103,g_apga_m.apga104,g_apga_m.apga108,g_apga_m.apga102,g_apga_m.apga026,g_apga_m.apga040, 
       g_apga_m.apga109,g_apga_m.glaa001,g_apga_m.apga101,g_apga_m.apga113,g_apga_m.apga114,g_apga_m.apga118, 
       g_apga_m.apga112,g_apga_m.apga105,g_apga_m.apga016,g_apga_m.apga017,g_apga_m.apga018,g_apga_m.apga115, 
       g_apga_m.apga106,g_apga_m.apga107,g_apga_m.apga019,g_apga_m.apga020,g_apga_m.apga021,g_apga_m.apga022, 
       g_apga_m.apga023,g_apga_m.apga024,g_apga_m.apga025,g_apga_m.l_apga1041,g_apga_m.apga036,g_apga_m.apga037, 
       g_apga_m.apga032,g_apga_m.l_apga1081,g_apga_m.apga034,g_apga_m.apga035,g_apga_m.apga031,g_apga_m.l_apga1021, 
       g_apga_m.apga038,g_apga_m.apga039,g_apga_m.apga033,g_apga_m.apga027
   
   LET lb_reproduce = FALSE
   LET l_ac_t = 1
   
   #關閉被遮罩相關欄位輸入, 無法確定USER是否會需要輸入此欄位
   #因此先行關閉, 若有需要可於下方add-point中自行開啟
   CALL cl_mask_set_no_entry()
   
   #add-point:資料輸入前 name="input.before_input"
WHILE TRUE
   LET l_autoins = FALSE
   #end add-point
   
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
 
{</section>}
 
{<section id="aapt510.input.head" >}
      #單頭段
      INPUT BY NAME g_apga_m.apgacomp,g_apga_m.apga005,g_apga_m.apga006,g_apga_m.apgadocno,g_apga_m.apga002, 
          g_apga_m.apgadocdt,g_apga_m.apga003,g_apga_m.apga004,g_apga_m.apga001,g_apga_m.apga028,g_apga_m.apga029, 
          g_apga_m.apgastus,g_apga_m.apga007,g_apga_m.apga030,g_apga_m.apga008,g_apga_m.apga009,g_apga_m.apga013, 
          g_apga_m.apga012,g_apga_m.apga010,g_apga_m.apga014,g_apga_m.apga011,g_apga_m.apga100,g_apga_m.apga015, 
          g_apga_m.apga103,g_apga_m.apga104,g_apga_m.apga108,g_apga_m.apga102,g_apga_m.apga026,g_apga_m.apga040, 
          g_apga_m.apga109,g_apga_m.glaa001,g_apga_m.apga101,g_apga_m.apga113,g_apga_m.apga114,g_apga_m.apga118, 
          g_apga_m.apga112,g_apga_m.apga105,g_apga_m.apga016,g_apga_m.apga017,g_apga_m.apga018,g_apga_m.apga115, 
          g_apga_m.apga106,g_apga_m.apga107,g_apga_m.apga019,g_apga_m.apga020,g_apga_m.apga021,g_apga_m.apga022, 
          g_apga_m.apga023,g_apga_m.apga024,g_apga_m.apga025,g_apga_m.l_apga1041,g_apga_m.apga036,g_apga_m.apga037, 
          g_apga_m.apga032,g_apga_m.l_apga1081,g_apga_m.apga034,g_apga_m.apga035,g_apga_m.apga031,g_apga_m.l_apga1021, 
          g_apga_m.apga038,g_apga_m.apga039,g_apga_m.apga033,g_apga_m.apga027 
         ATTRIBUTE(WITHOUT DEFAULTS)
         
         #自訂ACTION(master_input)
         
     
         BEFORE INPUT
            IF s_transaction_chk("N",0) THEN
               CALL s_transaction_begin()
            END IF
            OPEN aapt510_cl USING g_enterprise,g_apga_m.apgacomp,g_apga_m.apgadocno
            IF SQLCA.SQLCODE THEN   #(ver:78)
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "OPEN aapt510_cl:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE   #(ver:78)
               LET g_errparam.popup = TRUE 
               CLOSE aapt510_cl
               CALL s_transaction_end('N','0')
               CALL cl_err()
               RETURN
            END IF
            
            IF l_cmd_t = 'r' THEN
               
            END IF
            #因應離開單頭後已寫入資料庫, 若重新回到單頭則視為修改
            #因此需於此處開啟/關閉欄位
            CALL aapt510_set_entry(p_cmd)
            #add-point:資料輸入前 name="input.m.before_input"
            CALL aapt510_set_no_required(p_cmd)
            CALL aapt510_set_required(p_cmd)
            #end add-point
            CALL aapt510_set_no_entry(p_cmd)
    
                  #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apgacomp
            
            #add-point:AFTER FIELD apgacomp name="input.a.apgacomp"
            #確認資料無重複
            IF  NOT cl_null(g_apga_m.apgacomp) AND NOT cl_null(g_apga_m.apgadocno) THEN 
               IF p_cmd = 'a' OR ( p_cmd = 'u' AND (g_apga_m.apgacomp != g_apgacomp_t  OR g_apga_m.apgadocno != g_apgadocno_t )) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM apga_t WHERE "||"apgaent = '" ||g_enterprise|| "' AND "||"apgacomp = '"||g_apga_m.apgacomp ||"' AND "|| "apgadocno = '"||g_apga_m.apgadocno ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF

            LET g_apga_m.apgacomp_desc = ' '
            DISPLAY BY NAME g_apga_m.apgacomp_desc
            IF NOT cl_null(g_apga_m.apgacomp) THEN
               IF g_apga_m.apgacomp != g_apga_m_o.apgacomp OR cl_null(g_apga_m_o.apgacomp) THEN                                        #160822-00008#5 add
               #IF p_cmd = 'a' OR (p_cmd = 'u' AND (g_apga_m.apgacomp != g_apga_m_t.apgacomp OR g_apga_m_t.apgacomp IS NULL )) THEN    #160822-00008#5 mark
                  CALL aapt510_apgacomp_chk(g_apga_m.apgacomp)RETURNING g_sub_success,g_errno
                  IF NOT g_sub_success THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = g_errno
                     LET g_errparam.extend = ''
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                     #LET g_apga_m.apgacomp = g_apga_m_t.apgacomp  #160822-00008#5 mark
                     LET g_apga_m.apgacomp = g_apga_m_o.apgacomp   #160822-00008#5 add
                     LET g_apga_m.glaa001 = g_apga_m_o.glaa001     #160822-00008#5 add
                     DISPLAY BY NAME g_apga_m.glaa001              #160822-00008#5 add
                     CALL s_desc_get_department_desc(g_apga_m.apgacomp) RETURNING g_apga_m.apgacomp_desc
                     DISPLAY BY NAME g_apga_m.apgacomp_desc
                     NEXT FIELD CURRENT
                  END IF
                  CALL s_fin_account_center_sons_query('8',g_apga_m.apgacomp,g_apga_m.apgadocdt,'1')
                  CALL s_fin_account_center_sons_str() RETURNING g_wc_apgborga
                  CALL s_fin_get_wc_str(g_wc_apgborga) RETURNING g_wc_apgborga
                  CALL aapt510_set_visible('')
                  CALL aapt510_set_no_visible('')
                  #160824-00049#1-----s
                  LET l_ld = NULL    LET l_glaa005 = NULL
                  SELECT glaald,glaa005  INTO l_ld,l_glaa005 FROM glaa_t
                   WHERE glaaent = g_enterprise
                     AND glaacomp = g_apga_m.apgacomp
                     AND glaa014 = 'Y'
                  #自備款
                  SELECT glab006,glab007 INTO g_apga_m.apga036,g_apga_m.apga037
                    FROM glab_t
                   WHERE glab002 = '3117' AND glab001 = '15' AND glab003 = '8504_32' AND glabld = l_ld
                     AND glabent = g_enterprise
                  #保證金
                  SELECT glab006,glab007 INTO g_apga_m.apga034,g_apga_m.apga035
                    FROM glab_t
                   WHERE glab002 = '3117' AND glab001 = '15' AND glab003 = '8504_31' AND glabld = l_ld  
                     AND glabent = g_enterprise
                   #保證金
                  SELECT glab006,glab007 INTO g_apga_m.apga038,g_apga_m.apga039
                    FROM glab_t
                   WHERE glab002 = '3117' AND glab001 = '15' AND glab003 = '8504_33' AND glabld = l_ld
                     AND glabent = g_enterprise
                  CALL s_desc_get_nmajl003_desc(g_apga_m.apga036) RETURNING g_apga_m.apga036_desc
                  CALL s_desc_get_nmail004_desc(l_glaa005,g_apga_m.apga037) RETURNING g_apga_m.apga037_desc                                     
                  CALL s_desc_get_nmajl003_desc(g_apga_m.apga034) RETURNING g_apga_m.apga034_desc
                  CALL s_desc_get_nmail004_desc(l_glaa005,g_apga_m.apga035) RETURNING g_apga_m.apga035_desc
                  CALL s_desc_get_nmajl003_desc(g_apga_m.apga038) RETURNING g_apga_m.apga038_desc
                  CALL s_desc_get_nmail004_desc(l_glaa005,g_apga_m.apga039) RETURNING g_apga_m.apga039_desc
                  DISPLAY BY NAME g_apga_m.apga036_desc,g_apga_m.apga037_desc,g_apga_m.apga034_desc,g_apga_m.apga035_desc,g_apga_m.apga038_desc,g_apga_m.apga039_desc
                  #160824-00049#1-----e
                  #CALL s_control_get_supplier_sql_pmab('4',g_site,g_user,g_dept,'',g_apga_m.apgacomp) RETURNING g_sub_success,g_sql_ctrl #161115-00042#5-add #161229-00047#51 mark
                  CALL s_fin_get_wc_str(g_apga_m.apgacomp) RETURNING g_comp_str  #161229-00047#51 add 
                  CALL s_control_get_supplier_sql_pmab('4',g_site,g_user,g_dept,'',g_comp_str) RETURNING g_sub_success,g_sql_ctrl #161229-00047#51 add 
               END IF
            END IF
            LET g_apga_m.glaa001 = ''       #160822-00008#5 add
            #160428-00001#1 ---s---
            SELECT glaa001 INTO g_apga_m.glaa001 FROM glaa_t
             WHERE glaaent = g_enterprise AND glaacomp = g_apga_m.apgacomp
               AND glaa014 = 'Y'   #albireo 160627 add
            DISPLAY BY NAME g_apga_m.glaa001
            #160428-00001#1 ---s--
            CALL s_desc_get_department_desc(g_apga_m.apgacomp) RETURNING g_apga_m.apgacomp_desc
            DISPLAY BY NAME g_apga_m.apgacomp_desc
            
            
            LET g_apga_m_o.* = g_apga_m.*   #160822-00008#5 add
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apgacomp
            #add-point:BEFORE FIELD apgacomp name="input.b.apgacomp"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apgacomp
            #add-point:ON CHANGE apgacomp name="input.g.apgacomp"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apga005
            
            #add-point:AFTER FIELD apga005 name="input.a.apga005"
            #業務人員
            LET g_apga_m.apga005_desc = ''
            IF NOT cl_null(g_apga_m.apga005) THEN
               IF p_cmd = 'a' OR (p_cmd = 'u' AND (g_apga_m.apga005 != g_apga_m_t.apga005 OR g_apga_m_t.apga005 IS NULL )) THEN
                  LET g_errno = ''
                  CALL s_employee_chk(g_apga_m.apga005) RETURNING g_sub_success
                  IF NOT g_sub_success THEN
                     LET g_apga_m.apga005 = g_apga_m_t.apga005
                     CALL s_desc_get_person_desc(g_apga_m.apga005) RETURNING g_apga_m.apga005_desc
                     DISPLAY BY NAME g_apga_m.apga005_desc
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF
            CALL s_desc_get_person_desc(g_apga_m.apga005) RETURNING g_apga_m.apga005_desc
            DISPLAY BY NAME g_apga_m.apga005_desc
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apga005
            #add-point:BEFORE FIELD apga005 name="input.b.apga005"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apga005
            #add-point:ON CHANGE apga005 name="input.g.apga005"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apga006
            #add-point:BEFORE FIELD apga006 name="input.b.apga006"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apga006
            
            #add-point:AFTER FIELD apga006 name="input.a.apga006"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apga006
            #add-point:ON CHANGE apga006 name="input.g.apga006"
            IF NOT cl_null(g_apga_m.apga006)THEN
               CALL aapt510_set_no_required(p_cmd)
               CALL aapt510_set_entry(p_cmd)
               CALL aapt510_set_no_entry(p_cmd)
               CALL aapt510_set_required(p_cmd)
               
               IF g_apga_m.apga006 = '1' THEN
               ELSE
                  LET g_apga_m.apga003 = g_apga_m.apgadocdt
                  LET g_apga_m.apga001 = ''
                  IF p_cmd = 'u' THEN LET g_apga_m.apga001 = g_apga_m.apgadocno END IF
                  LET g_apga_m.apga008 = ''
                  LET g_apga_m.apga010 = ''
                  LET g_apga_m.apga012 = ''
                  LET g_apga_m.apga009 = 'N'
                  LET g_apga_m.apga015 = 100
                  LET g_apga_m.apga104 = g_apga_m.apga103
                  CALL aapt510_fomula_h('A')
                  CALL aapt510_fomula_h('B')
                  CALL aapt510_fomula_h('C')
                  CALL aapt510_fomula_h('D')
                  CALL aapt510_fomula_h('E')
                  LET g_apga_m.apga016 = ''
                  LET g_apga_m.apga017 = 0
                  LET g_apga_m.apga018 = ''
                  DISPLAY BY NAME g_apga_m.apga008,g_apga_m.apga009,g_apga_m.apga010,
                                  g_apga_m.apga012,g_apga_m.apga015,g_apga_m.apga104,
                                  g_apga_m.apga103,g_apga_m.apga105,g_apga_m.apga113,
                                  g_apga_m.apga114,g_apga_m.apga115,g_apga_m.apga016,
                                  g_apga_m.apga017,g_apga_m.apga018
               END IF
            END IF
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apgadocno
            #add-point:BEFORE FIELD apgadocno name="input.b.apgadocno"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apgadocno
            
            #add-point:AFTER FIELD apgadocno name="input.a.apgadocno"
            LET l_ld = NULL
            SELECT glaald INTO l_ld FROM glaa_t
             WHERE glaaent = g_enterprise
               AND glaacomp = g_apga_m.apgacomp
               AND glaa014 = 'Y'
            IF NOT cl_null(g_apga_m.apgadocno) THEN 
               IF p_cmd = 'a' OR ( p_cmd = 'u' AND (cl_null(g_apga_m_t.apgadocno) OR g_apga_m.apgadocno != g_apga_m_t.apgadocno)) THEN 
                  #檢查是否有重複的單據編號(企業代碼/帳別/單號)
                  #現系統有提供直接打單號所以要檢查
                  IF NOT cl_null(g_apga_m.apgacomp) AND NOT cl_null(g_apga_m.apgadocno) THEN 
                     IF p_cmd = 'a' OR ( p_cmd = 'u' AND (g_apga_m.apgacomp != g_apgacomp_t  OR g_apga_m.apgadocno != g_apgadocno_t )) THEN 
                        IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM apga_t WHERE "||"apgaent = '" ||g_enterprise|| "' AND "||"apgacomp = '"||g_apga_m.apgacomp ||"' AND "|| "apgadocno = '"||g_apga_m.apgadocno ||"'",'std-00004',0) THEN 
                           LET g_apga_m.apgadocno = g_apga_m_t.apgadocno
                           NEXT FIELD CURRENT
                        END IF
                        #161104-00046#7 --s add
                        CALL s_control_chk_doc('1',g_apga_m.apgadocno,'4',g_user,g_dept,'','') RETURNING g_sub_success,l_flag
                        IF g_sub_success AND l_flag THEN             
                        ELSE
                           LET g_apga_m.apgadocno = g_apga_m_t.apgadocno
                           NEXT FIELD CURRENT                  
                        END IF
                        CALL s_aooi200_fin_get_slip(g_apga_m.apgadocno) RETURNING g_sub_success,g_ap_slip
                        #刪除單別預設temptable
                        DELETE FROM s_aooi200def1
                        #以目前畫面資訊新增temp資料   #請勿調整.*
                        INSERT INTO s_aooi200def1 VALUES(g_apga_m.*)
                        #依單別預設取用資訊
                        CALL s_aooi200def_get('','',g_apga_m.apgacomp,'2',g_ap_slip,'','',l_ld)
                        #依單別預設值TEMP內容 給予到畫面上   #請勿調整.*
                        SELECT * INTO g_apga_m.* FROM s_aooi200def1
                        #161104-00046#7 --e add
                     END IF
                  END IF
                  IF NOT s_aooi200_fin_chk_docno(l_ld,'','',g_apga_m.apgadocno,g_apga_m.apgadocdt,g_prog) THEN
                     LET g_apga_m.apgadocno = g_apga_m_t.apgadocno
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF

            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apgadocno
            #add-point:ON CHANGE apgadocno name="input.g.apgadocno"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apga002
            #add-point:BEFORE FIELD apga002 name="input.b.apga002"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apga002
            
            #add-point:AFTER FIELD apga002 name="input.a.apga002"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apga002
            #add-point:ON CHANGE apga002 name="input.g.apga002"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apgadocdt
            #add-point:BEFORE FIELD apgadocdt name="input.b.apgadocdt"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apgadocdt
            
            #add-point:AFTER FIELD apgadocdt name="input.a.apgadocdt"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apgadocdt
            #add-point:ON CHANGE apgadocdt name="input.g.apgadocdt"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apga003
            #add-point:BEFORE FIELD apga003 name="input.b.apga003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apga003
            
            #add-point:AFTER FIELD apga003 name="input.a.apga003"
            IF NOT cl_null(g_apga_m.apga003)THEN
               IF cl_null(g_apga_m_t.apga003) OR (g_apga_m_t.apga003 <> g_apga_m.apga003)THEN
                  #預設 有效-開狀
                  IF NOT cl_null(g_apga_m.apga010)THEN
                     LET g_apga_m.apga017 = g_apga_m.apga010 - g_apga_m.apga003
                     DISPLAY BY NAME g_apga_m.apga017
                  END IF
               END IF
            END IF
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apga003
            #add-point:ON CHANGE apga003 name="input.g.apga003"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apga004
            
            #add-point:AFTER FIELD apga004 name="input.a.apga004"
            #受益人
            LET g_apga_m.apga004_desc = ''
            IF NOT cl_null(g_apga_m.apga004) THEN
               IF g_apga_m.apga004 != g_apga_m_o.apga004 OR cl_null(g_apga_m_o.apga004) THEN                                        #160822-00008#5 add
               #IF p_cmd = 'a' OR (p_cmd = 'u' AND (g_apga_m.apga004 != g_apga_m_t.apga004 OR g_apga_m_t.apga004 IS NULL )) THEN    #160822-00008#5 mark
                  CALL s_aap_apca004_chk(g_apga_m.apga004) RETURNING g_sub_success,g_errno
                  IF NOT g_sub_success THEN
                     IF NOT cl_null(g_errno) THEN
                        INITIALIZE g_errparam TO NULL
                        LET g_errparam.code = g_errno
                        #160321-00016#22 --s add
                        LET g_errparam.replace[1] = 'apmm100'
                        LET g_errparam.replace[2] = cl_get_progname('apmm100',g_lang,"2")
                        LET g_errparam.exeprog = 'apmm100'
                        #160321-00016#22 --e add
                        LET g_errparam.extend = ''
                        LET g_errparam.popup = TRUE
                        CALL cl_err()
                     END IF  

                     #LET g_apga_m.apga004 = g_apga_m_t.apga004 #160822-00008#5 mark
                     LET g_apga_m.apga004 = g_apga_m_o.apga004   #160822-00008#5 add
                     CALL s_desc_get_trading_partner_abbr_desc(g_apga_m.apga004) RETURNING g_apga_m.apga004_desc
                     DISPLAY BY NAME g_apga_m.apga004_desc
                     NEXT FIELD CURRENT
                  END IF
                  #161014-00053#3 --s add
                  #檢核供應商在控制組與單據別控制內是否可使用(整合)
                  CALL s_control_check_supplier(g_apga_m.apga004,'4','',g_user,g_dept,'')
                  RETURNING g_sub_success
                  IF NOT g_sub_success THEN
                     #檢查失敗時後續處理
                     LET g_apga_m.apga004 = g_apga_m_o.apga004
                     #發票客戶說明
                     CALL s_desc_get_trading_partner_abbr_desc(g_apga_m.apga004) RETURNING g_apga_m.apga004_desc
                     DISPLAY BY NAME g_apga_m.apga004_desc
                     NEXT FIELD CURRENT
                  END IF
                  #161014-00053#3 --e add
               END IF
            END IF
            CALL s_desc_get_trading_partner_abbr_desc(g_apga_m.apga004) RETURNING g_apga_m.apga004_desc
            DISPLAY BY NAME g_apga_m.apga004_desc
            LET g_apga_m_o.* = g_apga_m.*   #160822-00008#5 add
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apga004
            #add-point:BEFORE FIELD apga004 name="input.b.apga004"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apga004
            #add-point:ON CHANGE apga004 name="input.g.apga004"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apga001
            #add-point:BEFORE FIELD apga001 name="input.b.apga001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apga001
            
            #add-point:AFTER FIELD apga001 name="input.a.apga001"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apga001
            #add-point:ON CHANGE apga001 name="input.g.apga001"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apga028
            #add-point:BEFORE FIELD apga028 name="input.b.apga028"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apga028
            
            #add-point:AFTER FIELD apga028 name="input.a.apga028"
            LET l_ld = NULL
            SELECT glaald INTO l_ld FROM glaa_t
             WHERE glaaent = g_enterprise
               AND glaacomp = g_apga_m.apgacomp
               AND glaa014 = 'Y'
            IF NOT cl_null(g_apga_m.apga028) THEN 
               IF p_cmd = 'a' OR ( p_cmd = 'u' AND (cl_null(g_apga_m_t.apga028) OR g_apga_m.apga028 != g_apga_m_t.apga028)) THEN 
                  #檢查是否有重複的單據編號(企業代碼/帳別/單號)
                  #現系統有提供直接打單號所以要檢查
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM apca_t WHERE "||"apcaent = '" ||g_enterprise|| "' AND "||"apcadocno = '"||g_apga_m.apga028||"'  AND "||"apcald = '"||l_ld ||"' ",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
                  LET g_prog = 'aapt301'
                  IF NOT s_aooi200_fin_chk_docno(l_ld,'','',g_apga_m.apga028,g_apga_m.apga003,g_prog) THEN
                     LET g_apga_m.apga028 = g_apga_m_t.apga028
                     LET g_prog = 'aapt510'
                     NEXT FIELD CURRENT
                  END IF
                  LET g_prog = 'aapt510'
                  CALL s_fin_get_doc_para(l_ld,g_apga_m.apgacomp,g_apga_m.apga028,'D-FIN-0030') RETURNING l_chr
                  IF l_chr = 'N' THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = 'aap-00532'
                     LET g_errparam.extend = ''
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                     LET g_apga_m.apga028 = g_apga_m_t.apga028
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apga028
            #add-point:ON CHANGE apga028 name="input.g.apga028"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apga029
            #add-point:BEFORE FIELD apga029 name="input.b.apga029"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apga029
            
            #add-point:AFTER FIELD apga029 name="input.a.apga029"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apga029
            #add-point:ON CHANGE apga029 name="input.g.apga029"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apgastus
            #add-point:BEFORE FIELD apgastus name="input.b.apgastus"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apgastus
            
            #add-point:AFTER FIELD apgastus name="input.a.apgastus"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apgastus
            #add-point:ON CHANGE apgastus name="input.g.apgastus"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apga007
            
            #add-point:AFTER FIELD apga007 name="input.a.apga007"
            LET g_apga_m.apga007_desc = ''
            DISPLAY BY NAME g_apga_m.apga007_desc
            IF NOT cl_null(g_apga_m.apga007) THEN
               INITIALIZE g_chkparam.* TO NULL
               LET g_chkparam.arg1 = g_apga_m.apga007
               #160318-00025#24  by 07900 --add-str
               LET g_errshow = TRUE #是否開窗                   
               LET g_chkparam.err_str[1] ="anm-00012:sub-01302|anmi100|",cl_get_progname("anmi100",g_lang,"2"),"|:EXEPROGanmi100"
               #160318-00025#24  by 07900 --add-end 
               IF cl_chk_exist("v_nmab001") THEN
                  LET l_count = NULL
                  SELECT COUNT(*) INTO l_count
                    FROM nmab_t,ooef_t
                   WHERE nmabent = g_enterprise
                     AND nmab001 = g_apga_m.apga007
                     AND nmabent = ooefent
                     AND ooef001 = g_apga_m.apgacomp
                     AND nmab008 = ooef006
                  IF cl_null(l_count) THEN LET l_count = 0 END IF
                  IF l_count = 0 THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = 'anm-00128'
                     LET g_errparam.extend = g_apga_m.apga007
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                     LET g_apga_m.apga007 = g_apga_m_t.apga007
                     CALL aapt510_apga007_desc()
                     DISPLAY BY NAME g_apga_m.apga007,g_apga_m.apga007_desc
                     NEXT FIELD CURRENT
                  END IF
               ELSE
                  #檢查失敗時後續處理
                  LET g_apga_m.apga007 = g_apga_m_t.apga007
                  CALL aapt510_apga007_desc()
                  DISPLAY BY NAME g_apga_m.apga007,g_apga_m.apga007_desc
                  NEXT FIELD CURRENT
               END IF
            END IF
            CALL aapt510_apga007_desc()
            DISPLAY BY NAME g_apga_m.apga007_desc
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apga007
            #add-point:BEFORE FIELD apga007 name="input.b.apga007"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apga007
            #add-point:ON CHANGE apga007 name="input.g.apga007"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apga030
            
            #add-point:AFTER FIELD apga030 name="input.a.apga030"
            LET g_apga_m.apga030_desc = ''
            DISPLAY BY NAME g_apga_m.apga030_desc
            IF NOT cl_null(g_apga_m.apga030) THEN
               INITIALIZE g_chkparam.* TO NULL
               LET g_chkparam.arg1 = g_apga_m.apga030
               #160318-00025#24  by 07900 --add-str
               LET g_errshow = TRUE #是否開窗                   
               LET g_chkparam.err_str[1] ="anm-00012:sub-01302|anmi100|",cl_get_progname("anmi100",g_lang,"2"),"|:EXEPROGanmi100"
               #160318-00025#24  by 07900 --add-end 
               IF cl_chk_exist("v_nmab001") THEN
                  #160824-00049#1 mark----- #通知銀行不必考慮國別 因為是與收狀人有關的,不一定為開狀人同國別的銀行s
                  #LET l_count = NULL
                  #SELECT COUNT(*) INTO l_count
                  #  FROM nmab_t,ooef_t
                  # WHERE nmabent = g_enterprise
                  #   AND nmab001 = g_apga_m.apga030
                  #   AND nmabent = ooefent
                  #   AND ooef001 = g_apga_m.apgacomp
                  #   AND nmab008 = ooef006
                  #IF cl_null(l_count) THEN LET l_count = 0 END IF
                  #IF l_count = 0 THEN
                  #   INITIALIZE g_errparam TO NULL
                  #   LET g_errparam.code = 'anm-00128'
                  #   LET g_errparam.extend = g_apga_m.apga030
                  #   LET g_errparam.popup = TRUE
                  #   CALL cl_err()
                  #   LET g_apga_m.apga030 = g_apga_m_t.apga030
                  #   CALL aapt510_apga030_desc()
                  #   DISPLAY BY NAME g_apga_m.apga030,g_apga_m.apga030_desc
                  #   NEXT FIELD CURRENT
                  #END IF
                  
                  #160824-00049#1 mark----- #通知銀行不必考慮國別 因為是與收狀人有關的,不一定為開狀人同國別的銀行e
               ELSE
                  #檢查失敗時後續處理
                  LET g_apga_m.apga030 = g_apga_m_t.apga030
                  CALL aapt510_apga030_desc()
                  DISPLAY BY NAME g_apga_m.apga030,g_apga_m.apga030_desc
                  NEXT FIELD CURRENT
               END IF
            END IF
            CALL aapt510_apga030_desc()
            DISPLAY BY NAME g_apga_m.apga030_desc
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apga030
            #add-point:BEFORE FIELD apga030 name="input.b.apga030"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apga030
            #add-point:ON CHANGE apga030 name="input.g.apga030"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apga008
            #add-point:BEFORE FIELD apga008 name="input.b.apga008"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apga008
            
            #add-point:AFTER FIELD apga008 name="input.a.apga008"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apga008
            #add-point:ON CHANGE apga008 name="input.g.apga008"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apga009
            #add-point:BEFORE FIELD apga009 name="input.b.apga009"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apga009
            
            #add-point:AFTER FIELD apga009 name="input.a.apga009"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apga009
            #add-point:ON CHANGE apga009 name="input.g.apga009"
            CALL aapt510_set_no_required(p_cmd)
            CALL aapt510_set_required(p_cmd)
            IF g_apga_m.apga009 = 'Y' THEN
               LET g_apga_m.apga013 = '1'
               DISPLAY BY NAME g_apga_m.apga013
            END IF
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apga013
            #add-point:BEFORE FIELD apga013 name="input.b.apga013"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apga013
            
            #add-point:AFTER FIELD apga013 name="input.a.apga013"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apga013
            #add-point:ON CHANGE apga013 name="input.g.apga013"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apga012
            #add-point:BEFORE FIELD apga012 name="input.b.apga012"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apga012
            
            #add-point:AFTER FIELD apga012 name="input.a.apga012"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apga012
            #add-point:ON CHANGE apga012 name="input.g.apga012"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apga010
            #add-point:BEFORE FIELD apga010 name="input.b.apga010"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apga010
            
            #add-point:AFTER FIELD apga010 name="input.a.apga010"
            IF NOT cl_null(g_apga_m.apga010)THEN
               IF cl_null(g_apga_m_t.apga010) OR (g_apga_m_t.apga010 <> g_apga_m.apga010)THEN
                  #預設 有效-開狀
                  IF NOT cl_null(g_apga_m.apga003)THEN
                     LET g_apga_m.apga017 = g_apga_m.apga010 - g_apga_m.apga003
                     DISPLAY BY NAME g_apga_m.apga017
                  END IF
               END IF
            END IF
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apga010
            #add-point:ON CHANGE apga010 name="input.g.apga010"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apga014
            #add-point:BEFORE FIELD apga014 name="input.b.apga014"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apga014
            
            #add-point:AFTER FIELD apga014 name="input.a.apga014"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apga014
            #add-point:ON CHANGE apga014 name="input.g.apga014"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apga011
            #add-point:BEFORE FIELD apga011 name="input.b.apga011"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apga011
            
            #add-point:AFTER FIELD apga011 name="input.a.apga011"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apga011
            #add-point:ON CHANGE apga011 name="input.g.apga011"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apga100
            #add-point:BEFORE FIELD apga100 name="input.b.apga100"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apga100
            
            #add-point:AFTER FIELD apga100 name="input.a.apga100"
            #幣別
            LET l_ld = NULL
            LET l_glaa001 = NULL
            SELECT glaald,glaa001 INTO l_ld,l_glaa001 FROM glaa_t
             WHERE glaaent = g_enterprise
               AND glaacomp = g_apga_m.apgacomp
               AND glaa014 = 'Y'
            IF NOT cl_null(g_apga_m.apga100) THEN
               IF g_apga_m.apga100 != g_apga_m_o.apga100 OR cl_null(g_apga_m_o.apga100) THEN                                        #160822-00008#5 add
               #IF p_cmd = 'a' OR (p_cmd = 'u' AND (g_apga_m.apga100 != g_apga_m_t.apga100 OR g_apga_m_t.apga100 IS NULL )) THEN    #160822-00008#5 mark
                  CALL s_aap_ooaj001_chk(l_ld,g_apga_m.apga100) RETURNING g_sub_success,g_errno
                  IF NOT g_sub_success THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = g_errno
                     LET g_errparam.extend = ''
                     #160321-00016#22 --s add
                     LET g_errparam.replace[1] = 'aooi150'
                     LET g_errparam.replace[2] = cl_get_progname('aooi150',g_lang,"2")
                     LET g_errparam.exeprog = 'aooi150'
                     #160321-00016#22 --e add
                     LET g_errparam.popup = TRUE
                     CALL cl_err()

                     #LET g_apga_m.apga100 = g_apga_m_t.apga100  #160822-00008#5 mark
                     LET g_apga_m.apga100 = g_apga_m_o.apga100   #160822-00008#5 add
                     NEXT FIELD CURRENT
                  END IF
                  LET lc_param.apca004 = ''                      #160822-00008#5 add
                  IF NOT cl_null(g_apga_m.apga003) AND NOT cl_null(g_apga_m.apga004) THEN
                     LET lc_param.apca004 = g_apga_m.apga004
                     LET ls_js = util.JSON.stringify(lc_param)
                     LET g_apga_m.apga101 = ''                   #160822-00008#5 add
                     CALL s_fin_get_curr_rate(g_apga_m.apgacomp,l_ld,g_apga_m.apga003,g_apga_m.apga100,ls_js)
                          RETURNING g_apga_m.apga101,l_dummy2,l_dummy3
                     IF g_apga_m.apga100 = l_glaa001 THEN    #交易幣與本幣相同時
                        LET l_using = FALSE
                     ELSE
                        LET l_using = TRUE
                     END IF
                     CALL cl_set_comp_entry("apga101",l_using)
                     DISPLAY BY NAME g_apga_m.apga101
                     
                     #計算新匯率的結果
                     CALL aapt510_fomula_h('C')
                     CALL aapt510_fomula_h('D')
                     CALL aapt510_fomula_h('E')
                     CALL aapt510_fomula_h('F')
                     CALL aapt510_fomula_h('G') #160428-00001#1 
                  END IF
                  LET g_apga_m.apga040 = ''  #160428-00001#1 
               END IF
            END IF
            LET g_apga_m_o.* = g_apga_m.*   #160822-00008#5 add
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apga100
            #add-point:ON CHANGE apga100 name="input.g.apga100"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apga015
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_apga_m.apga015,"0","1","100","1","azz-00087",1) THEN
               NEXT FIELD apga015
            END IF 
 
 
 
            #add-point:AFTER FIELD apga015 name="input.a.apga015"
            #自備款比率
            IF NOT cl_null(g_apga_m.apga015)THEN
               IF cl_null(g_apga_m_o.apga015) OR (g_apga_m_o.apga015 <> g_apga_m.apga015)THEN
                  CALL aapt510_fomula_h('A')
                  CALL aapt510_fomula_h('B')
                  CALL aapt510_fomula_h('D')
                  CALL aapt510_fomula_h('E')
               END IF
            END IF
            CALL aapt510_to_o_h()
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apga015
            #add-point:BEFORE FIELD apga015 name="input.b.apga015"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apga015
            #add-point:ON CHANGE apga015 name="input.g.apga015"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apga103
            #add-point:BEFORE FIELD apga103 name="input.b.apga103"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apga103
            
            #add-point:AFTER FIELD apga103 name="input.a.apga103"
            #開狀金額          
            IF NOT cl_null(g_apga_m.apga103)THEN
               IF cl_null(g_apga_m_o.apga103) OR (g_apga_m_o.apga103 <> g_apga_m.apga103)THEN
                  CALL aapt510_fomula_h('A')
                  CALL aapt510_fomula_h('B')
                  CALL aapt510_fomula_h('C')
                  CALL aapt510_fomula_h('D')
                  CALL aapt510_fomula_h('E')
               END IF
            END IF
            CALL aapt510_to_o_h()
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apga103
            #add-point:ON CHANGE apga103 name="input.g.apga103"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apga104
            #add-point:BEFORE FIELD apga104 name="input.b.apga104"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apga104
            
            #add-point:AFTER FIELD apga104 name="input.a.apga104"
            #自備款原幣金額          
            IF NOT cl_null(g_apga_m.apga104)THEN
               IF cl_null(g_apga_m_o.apga104) OR (g_apga_m_o.apga104 <> g_apga_m.apga104)THEN
                  CALL aapt510_fomula_h('B')
                  CALL aapt510_fomula_h('D')
                  CALL aapt510_fomula_h('E')
               END IF
               #160428-00001#1 ---s---
               LET g_apga_m.l_apga1041 = g_apga_m.apga104 
               CALL aapt510_set_entry('')
               CALL aapt510_set_no_entry('')
               DISPLAY BY NAME  g_apga_m.l_apga1041 
               #160428-00001#1 ---e---
            END IF
            CALL aapt510_to_o_h()
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apga104
            #add-point:ON CHANGE apga104 name="input.g.apga104"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apga108
            #add-point:BEFORE FIELD apga108 name="input.b.apga108"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apga108
            
            #add-point:AFTER FIELD apga108 name="input.a.apga108"
            #160428-00001#1 ---s---
            #保證金原幣金額          
            IF NOT cl_null(g_apga_m.apga108)THEN
               IF cl_null(g_apga_m_o.apga108) OR (g_apga_m_o.apga108 <> g_apga_m.apga108)THEN
                  CALL aapt510_fomula_h('F')
               END IF               
               LET g_apga_m.l_apga1081 = g_apga_m.apga108
               CALL aapt510_set_entry('')
               CALL aapt510_set_no_entry('')
               DISPLAY BY NAME  g_apga_m.l_apga1041                
            END IF
            CALL aapt510_to_o_h()
            #160428-00001#1 ---e---
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apga108
            #add-point:ON CHANGE apga108 name="input.g.apga108"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apga102
            #add-point:BEFORE FIELD apga102 name="input.b.apga102"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apga102
            
            #add-point:AFTER FIELD apga102 name="input.a.apga102"
            #自備款原幣金額          
            IF NOT cl_null(g_apga_m.apga102)THEN
               IF cl_null(g_apga_m_o.apga102) OR (g_apga_m_o.apga102 <> g_apga_m.apga102)THEN
                  CALL aapt510_fomula_h('B')
                  CALL aapt510_fomula_h('D')
                  CALL aapt510_fomula_h('E')
                  CALL aapt510_fomula_h('G') ##160428-00001#1
               END IF
               #160428-00001#1 ---s---
               LET g_apga_m.l_apga1021 = g_apga_m.apga102 
               CALL aapt510_set_entry('')
               CALL aapt510_set_no_entry('')
               DISPLAY BY NAME  g_apga_m.l_apga1021 
               #160428-00001#1 ---e---
            END IF
            CALL aapt510_to_o_h()
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apga102
            #add-point:ON CHANGE apga102 name="input.g.apga102"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apga026
            #add-point:BEFORE FIELD apga026 name="input.b.apga026"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apga026
            
            #add-point:AFTER FIELD apga026 name="input.a.apga026"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apga026
            #add-point:ON CHANGE apga026 name="input.g.apga026"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apga040
            #add-point:BEFORE FIELD apga040 name="input.b.apga040"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apga040
            
            #add-point:AFTER FIELD apga040 name="input.a.apga040"
            #160428-00001#1 ---s---
            IF NOT cl_null(g_apga_m.apga040) THEN
               IF p_cmd = 'a' OR (p_cmd = 'u' AND (g_apga_m.apga040 != g_apga_m_t.apga040 OR g_apga_m_t.apga040 IS NULL )) THEN
                  LET g_chkparam.arg1 = g_apga_m.apga040
                  LET g_chkparam.arg2 = g_apga_m.apgacomp
                  LET g_chkparam.arg3 = '5'    #kris  aapt5系列皆付現  所以帳戶為零用金類型(比照aapt420現金類處理)
                  LET g_errshow = TRUE #是否開窗                   
                  LET g_chkparam.err_str[1] ="ade-00010:sub-01302|anmi120|",cl_get_progname("anmi20",g_lang,"2"),"|:EXEPROGanmi120"
                  IF cl_chk_exist("v_nmas002_4") THEN
                     IF NOT s_anmi120_nmll002_chk(g_apga_m.apga040,g_user) THEN
                        INITIALIZE g_errparam TO NULL
                        LET g_errparam.extend = g_apga_m.apga040
                        LET g_errparam.code   = 'aap-00551'
                        LET g_errparam.popup  = TRUE
                        CALL cl_err()
                        LET g_apga_m.apga040 = g_apga_m_t.apga040
                        NEXT FIELD CURRENT
                     END IF
                     IF NOT cl_null(g_apga_m.apga100) THEN #帳戶幣別應該與原幣幣別相等
                        SELECT nmas003 INTO l_nmas003
                          FROM nmas_t
                         WHERE nmas002 = g_apga_m.apga040
                           AND nmasent = g_enterprise
                        IF l_nmas003 <> g_apga_m.apga100 THEN
                           INITIALIZE g_errparam TO NULL
                           LET g_errparam.extend = g_apga_m.apga040
                           LET g_errparam.code   = 'anm-00574'
                           LET g_errparam.popup  = TRUE
                           CALL cl_err()
                           LET g_apga_m.apga040 = g_apga_m_t.apga040
                           NEXT FIELD CURRENT
                        END IF                                          
                     END IF
                  ELSE
                     NEXT FIELD CURRENT
                  END IF        
                  
               END IF
            END IF
            #160428-00001#1 ---e---
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apga040
            #add-point:ON CHANGE apga040 name="input.g.apga040"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apga109
            #add-point:BEFORE FIELD apga109 name="input.b.apga109"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apga109
            
            #add-point:AFTER FIELD apga109 name="input.a.apga109"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apga109
            #add-point:ON CHANGE apga109 name="input.g.apga109"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glaa001
            #add-point:BEFORE FIELD glaa001 name="input.b.glaa001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glaa001
            
            #add-point:AFTER FIELD glaa001 name="input.a.glaa001"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE glaa001
            #add-point:ON CHANGE glaa001 name="input.g.glaa001"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apga101
            #add-point:BEFORE FIELD apga101 name="input.b.apga101"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apga101
            
            #add-point:AFTER FIELD apga101 name="input.a.apga101"
            LET l_ld = NULL
            LET l_glaa001 = NULL
            SELECT glaald,glaa001 INTO l_ld,l_glaa001 FROM glaa_t
             WHERE glaaent = g_enterprise
               AND glaacomp = g_apga_m.apgacomp
               AND glaa014 = 'Y'           
            IF NOT cl_null(g_apga_m.apga101)THEN
               IF cl_null(g_apga_m_o.apga101) OR (g_apga_m_o.apga101<> g_apga_m.apga101)THEN
                   CALL s_curr_round_ld('1',l_ld,l_glaa001,g_apga_m.apga101,3) RETURNING g_sub_success,g_errno,g_apga_m.apga101
                  #計算新匯率的結果
                  CALL aapt510_fomula_h('C')
                  CALL aapt510_fomula_h('D')
                  CALL aapt510_fomula_h('E')
                  #160428-00001#14-----s
                  CALL aapt510_fomula_h('F')
                  CALL aapt510_fomula_h('G')                  
                  #160428-00001#14-----e
                  
                  #160428-00001#14-----s
                  #同步單身同幣別的匯率
                  LET l_count = NULL
                  SELECT COUNT(*) INTO l_count FROM apgb_t
                   WHERE apgbent = g_enterprise
                     AND apgbcomp = g_apga_m.apgacomp
                     AND apgbdocno = g_apga_m.apgadocno
                     AND apgb100   = g_apga_m.apga100
                  IF l_count > 0 THEN
                     LET l_sql = "SELECT apgbseq,apgb105 FROM apgb_t ",
                                 " WHERE apgbent = ",g_enterprise," ",
                                 "   AND apgbcomp = '",g_apga_m.apgacomp,"' ",
                                 "   AND apgbdocno = '",g_apga_m.apgadocno,"' ",
                                 "   AND apgb100 = '",g_apga_m.apga100,"' "
                     PREPARE sel_apgbp1 FROM l_sql
                     DECLARE sel_apgbc1 CURSOR FOR sel_apgbp1
                     FOREACH sel_apgbc1 INTO l_apgbseq,l_apgb105
                        IF SQLCA.SQLCODE THEN EXIT FOREACH END IF
                        LET l_apgb115 = l_apgb105 * g_apga_m.apga101
                        CALL s_curr_round(g_apga_m.apgacomp,g_apga_m.glaa001,l_apgb115,2)
                           RETURNING l_apgb115
                        UPDATE apgb_t SET apgb101 = g_apga_m.apga101,
                                          apgb115 = l_apgb115
                         WHERE apgbent   = g_enterprise
                           AND apgbcomp  = g_apga_m.apgacomp
                           AND apgbdocno = g_apga_m.apgadocno
                           AND apgbseq   = l_apgbseq
                     END FOREACH
                     
                  ##########
                     #計算是否有非開狀幣的單身
                     LET l_count = NULL
                     SELECT COUNT(*) INTO l_count FROM apgb_t
                      WHERE apgbent = g_enterprise
                        AND apgbcomp = g_apga_m.apgacomp
                        AND apgbdocno = g_apga_m.apgadocno
                        AND apgb100   = g_apga_m.glaa001
                     IF cl_null(l_count)THEN LET l_count = 0 END IF
                     
                     IF l_count = 0 THEN
                        LET l_apgasum = NULL   LET l_apgbsum = NULL
                        SELECT (apga103+apga102) INTO l_apgasum FROM apga_t
                         WHERE apgaent = g_enterprise
                           AND apgacomp = g_apga_m.apgacomp
                           AND apgadocno = g_apga_m.apgadocno
                        IF cl_null(l_apgasum)THEN LET l_apgasum = 0 END IF
                        
                        SELECT SUM(apgb105)INTO l_apgbsum FROM apgb_t
                         WHERE apgbent = g_enterprise
                           AND apgbcomp = g_apga_m.apgacomp
                           AND apgbdocno = g_apga_m.apgadocno
                        IF cl_null(l_apgbsum)THEN LET l_apgbsum = 0 END IF
                        
                        IF l_apgbsum <> l_apgasum THEN
                           IF cl_ask_confirm('aap-00528')THEN
                              LET g_apga_m.apga103 = l_apgbsum - g_apga_m.apga102         
                              IF g_apga_m.apga103 < 0 THEN LET g_apga_m.apga103 = 0 END IF
                              CALL aapt510_fomula_h('A') 
                              CALL aapt510_fomula_h('B')
                              CALL aapt510_fomula_h('C')
                              CALL aapt510_fomula_h('D')
                              CALL aapt510_fomula_h('E')
                              CALL aapt510_fomula_h('F')
                              CALL aapt510_fomula_h('G')
                              IF g_apga_m.apga002 = 0 THEN
                                 LET g_apga_m.apga109 = g_apga_m.apga103
                              END IF
                              UPDATE apga_t SET apga104 = g_apga_m.apga104,
                                                apga105 = g_apga_m.apga105,
                                                apga113 = g_apga_m.apga113,
                                                apga114 = g_apga_m.apga114,
                                                apga115 = g_apga_m.apga115,
                                                apga103 = g_apga_m.apga103,
                                                apga118 = g_apga_m.apga118, 
                                                apga112 = g_apga_m.apga112,
                                                apga109 = g_apga_m.apga109
                               WHERE apgaent = g_enterprise
                                 AND apgacomp = g_apga_m.apgacomp
                                 AND apgadocno = g_apga_m.apgadocno
                           END IF
                        END IF            
                        
                     ELSE
                        LET l_apgasum = NULL   LET l_apgbsum = NULL
                        SELECT (apga113+apga112) INTO l_apgasum FROM apga_t
                         WHERE apgaent = g_enterprise
                           AND apgacomp = g_apga_m.apgacomp
                           AND apgadocno = g_apga_m.apgadocno
                        IF cl_null(l_apgasum)THEN LET l_apgasum = 0 END IF
                        
                        SELECT SUM(apgb115)INTO l_apgbsum FROM apgb_t
                         WHERE apgbent = g_enterprise
                           AND apgbcomp = g_apga_m.apgacomp
                           AND apgbdocno = g_apga_m.apgadocno
                        IF cl_null(l_apgbsum)THEN LET l_apgbsum = 0 END IF
                        
                        IF l_apgbsum <> l_apgasum THEN
                           IF cl_ask_confirm('aap-00559')THEN
                              LET l_sql = "SELECT SUM(apgb115),apgb101 FROM apgb_t ",
                                          " WHERE apgbent = ",g_enterprise," ",
                                          "   AND apgbcomp = '",g_apga_m.apgacomp,"' ",
                                          "   AND apgbdocno = '",g_apga_m.apgadocno,"' ",
                                          " GROUP BY apgb101 "
                              PREPARE sel_apgbp2 FROM l_sql
                              DECLARE sel_apgbc2 CURSOR FOR sel_apgbp2
                              LET g_apga_m.apga103 = 0    LET g_apga_m.apga113 = 0
                              FOREACH sel_apgbc2 INTO l_apgbsum,l_apgb101
                                 LET g_apga_m.apga113 = g_apga_m.apga113 + l_apgbsum
                                 LET g_apga_m.apga103 = g_apga_m.apga103 + (l_apgbsum / g_apga_m.apga101)
                              END FOREACH
                              LET g_apga_m.apga113 = g_apga_m.apga113 - g_apga_m.apga112
                              LET g_apga_m.apga103 = g_apga_m.apga103 - g_apga_m.apga102
                              CALL s_curr_round(g_apga_m.apgacomp,g_apga_m.apga100,g_apga_m.apga103,2)
                                 RETURNING g_apga_m.apga103
                              CALL aapt510_fomula_h('A') 
                              CALL aapt510_fomula_h('B')
                              CALL aapt510_fomula_h('D')
                              CALL aapt510_fomula_h('E')
                              IF g_apga_m.apga002 = 0 THEN
                                 LET g_apga_m.apga109 = g_apga_m.apga103
                              END IF
                              UPDATE apga_t SET apga104 = g_apga_m.apga104,
                                                apga105 = g_apga_m.apga105,
                                                apga113 = g_apga_m.apga113,
                                                apga114 = g_apga_m.apga114,
                                                apga115 = g_apga_m.apga115,
                                                apga103 = g_apga_m.apga103,
                                                apga118 = g_apga_m.apga118, 
                                                apga112 = g_apga_m.apga112,
                                                apga109 = g_apga_m.apga109
                               WHERE apgaent = g_enterprise
                                 AND apgacomp = g_apga_m.apgacomp
                                 AND apgadocno = g_apga_m.apgadocno
                           END IF
                        END IF               
                     END IF
                  ##########                  
                  END IF
                  
                  #160824-00049#1-----s
                  LET l_count = NULL
                  SELECT COUNT(*) INTO l_count FROM apgc_t
                   WHERE apgcent = g_enterprise
                     AND apgccomp = g_apga_m.apgacomp
                     AND apgcdocno = g_apga_m.apgadocno
                     AND apgc100   = g_apga_m.apga100                  
                  IF cl_null(l_count)THEN LET l_count = 0 END IF
                  IF l_count > 0 THEN
                     LET l_sql = "SELECT apgcseq,apgc105 FROM apgc_t ",
                                 " WHERE apgcent = ",g_enterprise," ",
                                 "   AND apgccomp = '",g_apga_m.apgacomp,"' ",
                                 "   AND apgcdocno = '",g_apga_m.apgadocno,"' ",
                                 "   AND apgc100 = '",g_apga_m.apga100,"' ",
                                 "   AND apgc900 = '0' "
                     PREPARE sel_apgcp1 FROM l_sql
                     DECLARE sel_apgcc1 CURSOR FOR sel_apgcp1
                     FOREACH sel_apgcc1 INTO l_apgcseq,l_apgc103,l_apgc104,l_apgc105
                        IF SQLCA.SQLCODE THEN EXIT FOREACH END IF
                        LET l_apgc115 = l_apgc105 * g_apga_m.apga101
                        CALL s_curr_round(g_apga_m.apgacomp,g_apga_m.glaa001,l_apgc115,2)
                           RETURNING l_apgc115
                        LET l_apgc114 = l_apgc104 * g_apga_m.apga101
                        CALL s_curr_round(g_apga_m.apgacomp,g_apga_m.glaa001,l_apgc114,2)
                           RETURNING l_apgc114
                        LET l_apgc113 = l_apgc103 * g_apga_m.apga101
                        CALL s_curr_round(g_apga_m.apgacomp,g_apga_m.glaa001,l_apgc113,2)
                           RETURNING l_apgc113
                        UPDATE apgc_t SET apgc101 = g_apga_m.apga101,
                                          apgc115 = l_apgc115,
                                          apgc114 = l_apgc114,
                                          apgc113 = l_apgc113
                         WHERE apgcent   = g_enterprise
                           AND apgccomp  = g_apga_m.apgacomp
                           AND apgcdocno = g_apga_m.apgadocno
                           AND apgcseq   = l_apgcseq
                           AND apgc900   = 0
                     END FOREACH                  
                  END IF
                  #160824-00049#1-----e
                  
                  CALL aapt510_b_fill()
                  #160428-00001#14-----e
               END IF
            END IF
            CALL aapt510_to_o_h()
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apga101
            #add-point:ON CHANGE apga101 name="input.g.apga101"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apga113
            #add-point:BEFORE FIELD apga113 name="input.b.apga113"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apga113
            
            #add-point:AFTER FIELD apga113 name="input.a.apga113"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apga113
            #add-point:ON CHANGE apga113 name="input.g.apga113"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apga114
            #add-point:BEFORE FIELD apga114 name="input.b.apga114"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apga114
            
            #add-point:AFTER FIELD apga114 name="input.a.apga114"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apga114
            #add-point:ON CHANGE apga114 name="input.g.apga114"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apga118
            #add-point:BEFORE FIELD apga118 name="input.b.apga118"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apga118
            
            #add-point:AFTER FIELD apga118 name="input.a.apga118"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apga118
            #add-point:ON CHANGE apga118 name="input.g.apga118"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apga112
            #add-point:BEFORE FIELD apga112 name="input.b.apga112"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apga112
            
            #add-point:AFTER FIELD apga112 name="input.a.apga112"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apga112
            #add-point:ON CHANGE apga112 name="input.g.apga112"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apga105
            #add-point:BEFORE FIELD apga105 name="input.b.apga105"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apga105
            
            #add-point:AFTER FIELD apga105 name="input.a.apga105"
            #融資原幣金額         
            IF NOT cl_null(g_apga_m.apga105)THEN
               IF cl_null(g_apga_m_o.apga105) OR (g_apga_m_o.apga105 <> g_apga_m.apga105)THEN
                  CALL aapt510_fomula_h('E')
               END IF
            END IF
            CALL aapt510_to_o_h()
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apga105
            #add-point:ON CHANGE apga105 name="input.g.apga105"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apga016
            #add-point:BEFORE FIELD apga016 name="input.b.apga016"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apga016
            
            #add-point:AFTER FIELD apga016 name="input.a.apga016"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apga016
            #add-point:ON CHANGE apga016 name="input.g.apga016"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apga017
            #add-point:BEFORE FIELD apga017 name="input.b.apga017"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apga017
            
            #add-point:AFTER FIELD apga017 name="input.a.apga017"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apga017
            #add-point:ON CHANGE apga017 name="input.g.apga017"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apga018
            #add-point:BEFORE FIELD apga018 name="input.b.apga018"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apga018
            
            #add-point:AFTER FIELD apga018 name="input.a.apga018"
            IF NOT cl_null(g_apga_m.apga018) THEN
               IF p_cmd = 'a' OR (p_cmd = 'u' AND (g_apga_m.apga018 != g_apga_m_t.apga018 OR g_apga_m_t.apga018 IS NULL )) THEN
                  CALL aapt510_apga018_chk(g_apga_m.apga018,g_apga_m.apga003,g_apga_m.apgacomp)
                     RETURNING g_sub_success,g_errno
                  IF NOT g_sub_success THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = g_errno
                     LET g_errparam.extend = ''
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                     LET g_apga_m.apga018 = g_apga_m_t.apga018
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apga018
            #add-point:ON CHANGE apga018 name="input.g.apga018"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apga115
            #add-point:BEFORE FIELD apga115 name="input.b.apga115"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apga115
            
            #add-point:AFTER FIELD apga115 name="input.a.apga115"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apga115
            #add-point:ON CHANGE apga115 name="input.g.apga115"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apga106
            #add-point:BEFORE FIELD apga106 name="input.b.apga106"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apga106
            
            #add-point:AFTER FIELD apga106 name="input.a.apga106"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apga106
            #add-point:ON CHANGE apga106 name="input.g.apga106"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apga107
            #add-point:BEFORE FIELD apga107 name="input.b.apga107"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apga107
            
            #add-point:AFTER FIELD apga107 name="input.a.apga107"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apga107
            #add-point:ON CHANGE apga107 name="input.g.apga107"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apga019
            #add-point:BEFORE FIELD apga019 name="input.b.apga019"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apga019
            
            #add-point:AFTER FIELD apga019 name="input.a.apga019"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apga019
            #add-point:ON CHANGE apga019 name="input.g.apga019"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apga020
            
            #add-point:AFTER FIELD apga020 name="input.a.apga020"
            LET g_apga_m.apga020_desc = ' '
            IF NOT cl_null(g_apga_m.apga020) THEN
               IF p_cmd = 'a' OR (p_cmd = 'u' AND (g_apga_m.apga020 != g_apga_m_t.apga020 OR g_apga_m_t.apga020 IS NULL )) THEN
                  IF NOT s_azzi650_chk_exist('263',g_apga_m.apga020) THEN
                     LET g_apga_m.apga020  = g_apga_m_t.apga020
                     CALL s_desc_get_acc_desc('263',g_apga_m.apga020) RETURNING g_apga_m.apga020_desc
                     DISPLAY BY NAME g_apga_m.apga020_desc
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF   
            CALL s_desc_get_acc_desc('263',g_apga_m.apga020) RETURNING g_apga_m.apga020_desc
            DISPLAY BY NAME g_apga_m.apga020_desc
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apga020
            #add-point:BEFORE FIELD apga020 name="input.b.apga020"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apga020
            #add-point:ON CHANGE apga020 name="input.g.apga020"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apga021
            #add-point:BEFORE FIELD apga021 name="input.b.apga021"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apga021
            
            #add-point:AFTER FIELD apga021 name="input.a.apga021"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apga021
            #add-point:ON CHANGE apga021 name="input.g.apga021"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apga022
            #add-point:BEFORE FIELD apga022 name="input.b.apga022"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apga022
            
            #add-point:AFTER FIELD apga022 name="input.a.apga022"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apga022
            #add-point:ON CHANGE apga022 name="input.g.apga022"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apga023
            #add-point:BEFORE FIELD apga023 name="input.b.apga023"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apga023
            
            #add-point:AFTER FIELD apga023 name="input.a.apga023"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apga023
            #add-point:ON CHANGE apga023 name="input.g.apga023"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apga024
            #add-point:BEFORE FIELD apga024 name="input.b.apga024"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apga024
            
            #add-point:AFTER FIELD apga024 name="input.a.apga024"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apga024
            #add-point:ON CHANGE apga024 name="input.g.apga024"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apga025
            #add-point:BEFORE FIELD apga025 name="input.b.apga025"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apga025
            
            #add-point:AFTER FIELD apga025 name="input.a.apga025"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apga025
            #add-point:ON CHANGE apga025 name="input.g.apga025"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_apga1041
            #add-point:BEFORE FIELD l_apga1041 name="input.b.l_apga1041"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_apga1041
            
            #add-point:AFTER FIELD l_apga1041 name="input.a.l_apga1041"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE l_apga1041
            #add-point:ON CHANGE l_apga1041 name="input.g.l_apga1041"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apga036
            
            #add-point:AFTER FIELD apga036 name="input.a.apga036"
            #160428-00001#1 ---s---
            LET g_apga_m.apga036_desc = ''
            IF NOT cl_null(g_apga_m.apga036) THEN
               IF g_apga_m.apga036 != g_apga_m_o.apga036 OR cl_null(g_apga_m_o.apga036) THEN                                        #160822-00008#5 add
               #IF p_cmd = 'a' OR (p_cmd = 'u' AND (g_apga_m.apga036 != g_apga_m_t.apga036 OR g_apga_m_t.apga036 IS NULL )) THEN    #160822-00008#5 mark            
                  LET l_glaa005 = NULL
                  SELECT glaa005 INTO l_glaa005 FROM glaa_t
                   WHERE glaaent  = g_enterprise
                     AND glaacomp = g_apga_m.apgacomp
                     AND glaa014  = 'Y'
                 INITIALIZE g_chkparam.* TO NULL
                 LET g_chkparam.arg1 = l_glaa005
                 LET g_chkparam.arg2 = g_apga_m.apga036
                 LET g_errshow = TRUE
                 LET g_chkparam.err_str[1] = "agl-00149:sub-01302|anmi172|",cl_get_progname("anmi172",g_lang,"2"),"|:EXEPROGanmi172"
                 IF cl_chk_exist("v_nmad002") THEN
                    IF cl_null(g_apga_m.apga037) THEN
                       SELECT nmad003 INTO g_apga_m.apga037
                         FROM nmad_t
                        WHERE nmadent = g_enterprise
                          AND nmad001 = l_glaa005
                          AND nmad002 = g_apga_m.apga036
                       CALL s_desc_get_nmail004_desc(l_glaa005,g_apga_m.apga037) RETURNING g_apga_m.apga037_desc
                       DISPLAY BY NAME g_apga_m.apga037,g_apga_m.apga037_desc
                    END IF
                 ELSE                    
                    #LET g_apga_m.apga036 = g_apga_m.apga036  #160822-00008#5 mark 應須給回舊值
                    LET g_apga_m.apga036 = g_apga_m_o.apga036 #160822-00008#5 add
                    CALL s_desc_get_nmajl003_desc(g_apga_m.apga036) RETURNING g_apga_m.apga036_desc
                    NEXT FIELD CURRENT
                 END IF
               END IF
            END IF                                               
            CALL s_desc_get_nmajl003_desc(g_apga_m.apga036) RETURNING g_apga_m.apga036_desc
            DISPLAY BY NAME g_apga_m.apga036_desc
            #160428-00001#1 ---e---
            LET g_apga_m_o.* = g_apga_m.*   #160822-00008#5 add
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apga036
            #add-point:BEFORE FIELD apga036 name="input.b.apga036"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apga036
            #add-point:ON CHANGE apga036 name="input.g.apga036"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apga037
            
            #add-point:AFTER FIELD apga037 name="input.a.apga037"
            #160428-00001#1 ---s---
            IF NOT cl_null(g_apga_m.apga037) THEN
               IF g_apga_m.apga037 != g_apga_m_o.apga037 OR cl_null(g_apga_m_o.apga037) THEN                                        #160822-00008#5 add
               #IF p_cmd = 'a' OR (p_cmd = 'u' AND (g_apga_m.apga037 != g_apga_m_t.apga037 OR g_apga_m_t.apga037 IS NULL )) THEN    #160822-00008#5 mark
                  LET l_glaa005 = NULL
                  SELECT glaa005 INTO l_glaa005 FROM glaa_t
                   WHERE glaaent  = g_enterprise
                     AND glaacomp = g_apga_m.apgacomp
                     AND glaa014  = 'Y'
                  INITIALIZE g_chkparam.* TO NULL
                  LET g_chkparam.arg1 = g_apga_m.apga037
                  LET g_chkparam.arg2 = l_glaa005
                  IF cl_chk_exist("v_nmai002") THEN
                  ELSE
                     #檢查失敗時後續處理
                     #LET g_apga_m.apga037 = g_apga_m_t.apga037 #160822-00008#5 mark
                     LET g_apga_m.apga037 = g_apga_m_o.apga037  #160822-00008#5 add
                     CALL s_desc_get_nmail004_desc(l_glaa005,g_apga_m.apga037 ) RETURNING g_apga_m.apga037_desc
                     DISPLAY BY NAME g_apga_m.apga037_desc
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF                        
            INITIALIZE g_ref_fields TO NULL
            CALL s_desc_get_nmail004_desc(l_glaa005,g_apga_m.apga037 ) RETURNING g_apga_m.apga037_desc
            DISPLAY BY NAME g_apga_m.apga037_desc
            #160428-00001#1 ---e---
            LET g_apga_m_o.* = g_apga_m.*   #160822-00008#5 add
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apga037
            #add-point:BEFORE FIELD apga037 name="input.b.apga037"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apga037
            #add-point:ON CHANGE apga037 name="input.g.apga037"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apga032
            #add-point:BEFORE FIELD apga032 name="input.b.apga032"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apga032
            
            #add-point:AFTER FIELD apga032 name="input.a.apga032"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apga032
            #add-point:ON CHANGE apga032 name="input.g.apga032"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_apga1081
            #add-point:BEFORE FIELD l_apga1081 name="input.b.l_apga1081"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_apga1081
            
            #add-point:AFTER FIELD l_apga1081 name="input.a.l_apga1081"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE l_apga1081
            #add-point:ON CHANGE l_apga1081 name="input.g.l_apga1081"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apga034
            
            #add-point:AFTER FIELD apga034 name="input.a.apga034"
            #160428-00001#1 ---s---
            LET g_apga_m.apga034_desc = ''
            IF NOT cl_null(g_apga_m.apga034) THEN
               IF g_apga_m.apga034 != g_apga_m_o.apga034 OR cl_null(g_apga_m_o.apga034) THEN                                        #160822-00008#5 add
               #IF p_cmd = 'a' OR (p_cmd = 'u' AND (g_apga_m.apga034 != g_apga_m_t.apga034 OR g_apga_m_t.apga034 IS NULL )) THEN    #160822-00008#5 mark
                  LET l_glaa005 = NULL
                  SELECT glaa005 INTO l_glaa005 FROM glaa_t
                   WHERE glaaent  = g_enterprise
                     AND glaacomp = g_apga_m.apgacomp
                     AND glaa014  = 'Y'
                 INITIALIZE g_chkparam.* TO NULL
                 LET g_chkparam.arg1 = l_glaa005
                 LET g_chkparam.arg2 = g_apga_m.apga034
                 LET g_errshow = TRUE
                 LET g_chkparam.err_str[1] = "agl-00149:sub-01302|anmi172|",cl_get_progname("anmi172",g_lang,"2"),"|:EXEPROGanmi172"
                 IF cl_chk_exist("v_nmad002") THEN
                    IF cl_null(g_apga_m.apga035) THEN
                       SELECT nmad003 INTO g_apga_m.apga035
                         FROM nmad_t
                        WHERE nmadent = g_enterprise
                          AND nmad001 = l_glaa005
                          AND nmad002 = g_apga_m.apga034
                       CALL s_desc_get_nmail004_desc(l_glaa005,g_apga_m.apga034) RETURNING g_apga_m.apga035_desc
                       DISPLAY BY NAME g_apga_m.apga035,g_apga_m.apga035_desc
                    END IF
                 ELSE                    
                    #LET g_apga_m.apga034 = g_apga_m.apga034  #160822-00008#5 mark 應給回舊值
                    LET g_apga_m.apga034 = g_apga_m_o.apga034 #160822-00008#5 add
                    CALL s_desc_get_nmajl003_desc(g_apga_m.apga034) RETURNING g_apga_m.apga034_desc
                    NEXT FIELD CURRENT
                 END IF
               END IF
            END IF                                               
            CALL s_desc_get_nmajl003_desc(g_apga_m.apga034) RETURNING g_apga_m.apga034_desc
            DISPLAY BY NAME g_apga_m.apga034_desc
            #160428-00001#1 ---e---
            LET g_apga_m_o.* = g_apga_m.*   #160822-00008#5 add
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apga034
            #add-point:BEFORE FIELD apga034 name="input.b.apga034"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apga034
            #add-point:ON CHANGE apga034 name="input.g.apga034"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apga035
            
            #add-point:AFTER FIELD apga035 name="input.a.apga035"
            #160428-00001#1 ---s---
            IF NOT cl_null(g_apga_m.apga035) THEN
               IF p_cmd = 'a' OR (p_cmd = 'u' AND (g_apga_m.apga035 != g_apga_m_t.apga035 OR g_apga_m_t.apga035 IS NULL )) THEN
                  LET l_glaa005 = NULL
                  SELECT glaa005 INTO l_glaa005 FROM glaa_t
                   WHERE glaaent  = g_enterprise
                     AND glaacomp = g_apga_m.apgacomp
                     AND glaa014  = 'Y'
                  INITIALIZE g_chkparam.* TO NULL
                  LET g_chkparam.arg1 = g_apga_m.apga035
                  LET g_chkparam.arg2 = l_glaa005
                  IF cl_chk_exist("v_nmai002") THEN
                  ELSE
                     #檢查失敗時後續處理
                     LET g_apga_m.apga035 = g_apga_m_t.apga035
                     CALL s_desc_get_nmail004_desc(l_glaa005,g_apga_m.apga035) RETURNING g_apga_m.apga035_desc
                     DISPLAY BY NAME g_apga_m.apga035_desc
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF                                     
            CALL s_desc_get_nmail004_desc(l_glaa005,g_apga_m.apga035) RETURNING g_apga_m.apga035_desc
            DISPLAY BY NAME g_apga_m.apga035_desc
            #160428-00001#1 ---e---
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apga035
            #add-point:BEFORE FIELD apga035 name="input.b.apga035"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apga035
            #add-point:ON CHANGE apga035 name="input.g.apga035"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apga031
            #add-point:BEFORE FIELD apga031 name="input.b.apga031"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apga031
            
            #add-point:AFTER FIELD apga031 name="input.a.apga031"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apga031
            #add-point:ON CHANGE apga031 name="input.g.apga031"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_apga1021
            #add-point:BEFORE FIELD l_apga1021 name="input.b.l_apga1021"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_apga1021
            
            #add-point:AFTER FIELD l_apga1021 name="input.a.l_apga1021"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE l_apga1021
            #add-point:ON CHANGE l_apga1021 name="input.g.l_apga1021"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apga038
            
            #add-point:AFTER FIELD apga038 name="input.a.apga038"
            #160428-00001#1 ---s---
            LET g_apga_m.apga038_desc = ''
            IF NOT cl_null(g_apga_m.apga038) THEN
               IF g_apga_m.apga038 != g_apga_m_o.apga038 OR cl_null(g_apga_m_o.apga038) THEN                                        #160822-00008#5 add
               #IF p_cmd = 'a' OR (p_cmd = 'u' AND (g_apga_m.apga038 != g_apga_m_t.apga038 OR g_apga_m_t.apga038 IS NULL )) THEN    #160822-00008#5 mark
                  LET l_glaa005 = NULL
                  SELECT glaa005 INTO l_glaa005 FROM glaa_t
                   WHERE glaaent  = g_enterprise
                     AND glaacomp = g_apga_m.apgacomp
                     AND glaa014  = 'Y'
                 INITIALIZE g_chkparam.* TO NULL
                 LET g_chkparam.arg1 = l_glaa005
                 LET g_chkparam.arg2 = g_apga_m.apga038
                 LET g_errshow = TRUE
                 LET g_chkparam.err_str[1] = "agl-00149:sub-01302|anmi172|",cl_get_progname("anmi172",g_lang,"2"),"|:EXEPROGanmi172"
                 IF cl_chk_exist("v_nmad002") THEN
                    IF cl_null(g_apga_m.apga039) THEN
                       SELECT nmad003 INTO g_apga_m.apga039
                         FROM nmad_t
                        WHERE nmadent = g_enterprise
                          AND nmad001 = l_glaa005
                          AND nmad002 = g_apga_m.apga038
                       CALL s_desc_get_nmail004_desc(l_glaa005,g_apga_m.apga039) RETURNING g_apga_m.apga039_desc
                       DISPLAY BY NAME g_apga_m.apga039,g_apga_m.apga039_desc
                    END IF
                 ELSE                    
                    #LET g_apga_m.apga038 = g_apga_m.apga038  #160822-00008#5 mark 應給回舊值
                    LET g_apga_m.apga038 = g_apga_m_o.apga038 #160822-00008#5 add
                    CALL s_desc_get_nmajl003_desc(g_apga_m.apga038) RETURNING g_apga_m.apga038_desc
                    NEXT FIELD CURRENT
                 END IF
               END IF
            END IF                                               
            CALL s_desc_get_nmajl003_desc(g_apga_m.apga038) RETURNING g_apga_m.apga038_desc
            DISPLAY BY NAME g_apga_m.apga038_desc
            #160428-00001#1 ---e---
            LET g_apga_m_o.* = g_apga_m.*   #160822-00008#5 add
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apga038
            #add-point:BEFORE FIELD apga038 name="input.b.apga038"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apga038
            #add-point:ON CHANGE apga038 name="input.g.apga038"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apga039
            
            #add-point:AFTER FIELD apga039 name="input.a.apga039"
            #160428-00001#1 ---s---
            IF NOT cl_null(g_apga_m.apga039) THEN
               IF g_apga_m.apga039 != g_apga_m_o.apga039 OR cl_null(g_apga_m_o.apga039) THEN                                        #160822-00008#5 add
               #IF p_cmd = 'a' OR (p_cmd = 'u' AND (g_apga_m.apga039 != g_apga_m_t.apga039 OR g_apga_m_t.apga039 IS NULL )) THEN    #160822-00008#5 mark
                  LET l_glaa005 = NULL
                  SELECT glaa005 INTO l_glaa005 FROM glaa_t
                   WHERE glaaent  = g_enterprise
                     AND glaacomp = g_apga_m.apgacomp
                     AND glaa014  = 'Y'
                  INITIALIZE g_chkparam.* TO NULL
                  LET g_chkparam.arg1 = g_apga_m.apga039
                  LET g_chkparam.arg2 = l_glaa005
                  IF cl_chk_exist("v_nmai002") THEN
                  ELSE
                     #檢查失敗時後續處理
                     #LET g_apga_m.apga039 = g_apga_m_t.apga039 #160822-00008#5 mark
                     LET g_apga_m.apga039 = g_apga_m_o.apga039  #160822-00008#5 add
                     CALL s_desc_get_nmail004_desc(l_glaa005,g_apga_m.apga039 ) RETURNING g_apga_m.apga039_desc
                     DISPLAY BY NAME g_apga_m.apga039_desc
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF                          
            CALL s_desc_get_nmail004_desc(l_glaa005,g_apga_m.apga039 ) RETURNING g_apga_m.apga039_desc
            DISPLAY BY NAME g_apga_m.apga039_desc
            #160428-00001#1 ---e---
            LET g_apga_m_o.* = g_apga_m.*   #160822-00008#5 add
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apga039
            #add-point:BEFORE FIELD apga039 name="input.b.apga039"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apga039
            #add-point:ON CHANGE apga039 name="input.g.apga039"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apga033
            #add-point:BEFORE FIELD apga033 name="input.b.apga033"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apga033
            
            #add-point:AFTER FIELD apga033 name="input.a.apga033"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apga033
            #add-point:ON CHANGE apga033 name="input.g.apga033"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apga027
            #add-point:BEFORE FIELD apga027 name="input.b.apga027"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apga027
            
            #add-point:AFTER FIELD apga027 name="input.a.apga027"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apga027
            #add-point:ON CHANGE apga027 name="input.g.apga027"
            
            #END add-point 
 
 
 #欄位檢查
                  #Ctrlp:input.c.apgacomp
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apgacomp
            #add-point:ON ACTION controlp INFIELD apgacomp name="input.c.apgacomp"
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_apga_m.apgacomp
            LET g_qryparam.where = " ooef003 = 'Y' "
            #160811 albireo 補入法人權限-----s
            IF NOT cl_null(g_wc_cs_comp)THEN
               #LET g_qryparam.where = " ooef001 IN ",g_wc_cs_comp    #160824-00049#1 mark
               LET g_qryparam.where = g_qryparam.where CLIPPED," AND ooef001 IN ",g_wc_cs_comp                    #160824-00049#1 add
            END IF
            #160811 albireo 補入法人權限-----e
            CALL q_ooef001()
            LET g_apga_m.apgacomp = g_qryparam.return1
            CALL s_desc_get_department_desc(g_apga_m.apgacomp) RETURNING g_apga_m.apgacomp_desc
            DISPLAY BY NAME g_apga_m.apgacomp,g_apga_m.apgacomp_desc
            NEXT FIELD apgacomp
            #END add-point
 
 
         #Ctrlp:input.c.apga005
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apga005
            #add-point:ON ACTION controlp INFIELD apga005 name="input.c.apga005"
            #業務員
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_apga_m.apga005
            CALL q_ooag001_8()
            LET g_apga_m.apga005 = g_qryparam.return1
            CALL s_desc_get_person_desc(g_apga_m.apga005) RETURNING g_apga_m.apga005_desc
            DISPLAY BY NAME g_apga_m.apga005,g_apga_m.apga005_desc
            NEXT FIELD apga005
            #END add-point
 
 
         #Ctrlp:input.c.apga006
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apga006
            #add-point:ON ACTION controlp INFIELD apga006 name="input.c.apga006"
            
            #END add-point
 
 
         #Ctrlp:input.c.apgadocno
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apgadocno
            #add-point:ON ACTION controlp INFIELD apgadocno name="input.c.apgadocno"
           INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_apga_m.apgadocno
            LET l_glaa024 = NULL
            SELECT glaa024 INTO l_glaa024 FROM glaa_t
             WHERE glaaent = g_enterprise
               AND glaacomp = g_apga_m.apgacomp
               AND glaa014 = 'Y'
            LET g_qryparam.arg1 = l_glaa024
            LET g_qryparam.arg2 = g_prog
            #161104-00046#7 --s add
            IF NOT cl_null(g_user_slip_wc)THEN
               LET g_qryparam.where = g_user_slip_wc
            END IF
            #161104-00046#7 --e add
            CALL q_ooba002_1()
            LET g_apga_m.apgadocno = g_qryparam.return1
            DISPLAY BY NAME g_apga_m.apgadocno
            NEXT FIELD apgadocno
            #END add-point
 
 
         #Ctrlp:input.c.apga002
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apga002
            #add-point:ON ACTION controlp INFIELD apga002 name="input.c.apga002"
            
            #END add-point
 
 
         #Ctrlp:input.c.apgadocdt
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apgadocdt
            #add-point:ON ACTION controlp INFIELD apgadocdt name="input.c.apgadocdt"
            
            #END add-point
 
 
         #Ctrlp:input.c.apga003
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apga003
            #add-point:ON ACTION controlp INFIELD apga003 name="input.c.apga003"
            
            #END add-point
 
 
         #Ctrlp:input.c.apga004
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apga004
            #add-point:ON ACTION controlp INFIELD apga004 name="input.c.apga004"
            #受益人編號
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_apga_m.apga004
            LET g_qryparam.arg1 = "('1','3')"

            IF NOT cl_null(g_sql_ctrl) AND NOT g_sql_ctrl = ' 1=1'  THEN
               LET g_qryparam.where = g_sql_ctrl
            END IF

            CALL q_pmaa001_1()
            LET g_apga_m.apga004 = g_qryparam.return1
            CALL s_desc_get_trading_partner_abbr_desc(g_apga_m.apga004) RETURNING g_apga_m.apga004_desc
            DISPLAY BY NAME g_apga_m.apga004,g_apga_m.apga004_desc
            NEXT FIELD apga004
            #END add-point
 
 
         #Ctrlp:input.c.apga001
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apga001
            #add-point:ON ACTION controlp INFIELD apga001 name="input.c.apga001"
            
            #END add-point
 
 
         #Ctrlp:input.c.apga028
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apga028
            #add-point:ON ACTION controlp INFIELD apga028 name="input.c.apga028"
            #費用轉aapt301的單號
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_apga_m.apga028
            LET l_glaa024 = NULL
            SELECT glaa024 INTO l_glaa024 FROM glaa_t
             WHERE glaaent = g_enterprise
               AND glaacomp = g_apga_m.apgacomp
               AND glaa014 = 'Y'
            LET g_qryparam.arg1 = l_glaa024
            LET g_qryparam.arg2 = 'aapt301'
            LET g_qryparam.where = "      EXISTS (SELECT 1 FROM ooac_t ",
                                   "               WHERE ooacent = oobaent ",
                                   "                 AND ooac001 = '",l_glaa024,"' ",
                                   "                 AND ooac002 = ooba002 ",
                                   "                 AND ooac003 = 'D-FIN-0030' ",
                                   "                 AND ooac004 ='Y') "
            CALL q_ooba002_1()
            LET g_apga_m.apga028 = g_qryparam.return1
            DISPLAY BY NAME g_apga_m.apga028
            NEXT FIELD apga028
            #END add-point
 
 
         #Ctrlp:input.c.apga029
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apga029
            #add-point:ON ACTION controlp INFIELD apga029 name="input.c.apga029"
            
            #END add-point
 
 
         #Ctrlp:input.c.apgastus
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apgastus
            #add-point:ON ACTION controlp INFIELD apgastus name="input.c.apgastus"
            
            #END add-point
 
 
         #Ctrlp:input.c.apga007
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apga007
            #add-point:ON ACTION controlp INFIELD apga007 name="input.c.apga007"
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_apga_m.apga007
            LET l_ooef006 = NULL
            SELECT ooef006 INTO l_ooef006 FROM ooef_t
             WHERE ooefent = g_enterprise
               AND ooef001 = g_apga_m.apgacomp
            LET g_qryparam.where = " nmab008 = '",l_ooef006,"'" 
            CALL q_nmab001()
            LET g_apga_m.apga007 = g_qryparam.return1
            CALL aapt510_apga007_desc()
            DISPLAY BY NAME g_apga_m.apga007,g_apga_m.apga007_desc
            NEXT FIELD apga007
            #END add-point
 
 
         #Ctrlp:input.c.apga030
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apga030
            #add-point:ON ACTION controlp INFIELD apga030 name="input.c.apga030"
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_apga_m.apga030
            #160824-00049#1 mark-----s
            #LET l_ooef006 = NULL
            #SELECT ooef006 INTO l_ooef006 FROM ooef_t
            # WHERE ooefent = g_enterprise
            #   AND ooef001 = g_apga_m.apgacomp
            #LET g_qryparam.where = " nmab008 = '",l_ooef006,"'" 
            #160824-00049#1 mark-----e
            CALL q_nmab001()
            LET g_apga_m.apga030 = g_qryparam.return1
            CALL aapt510_apga030_desc()
            DISPLAY BY NAME g_apga_m.apga030,g_apga_m.apga030_desc
            NEXT FIELD apga030
            #END add-point
 
 
         #Ctrlp:input.c.apga008
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apga008
            #add-point:ON ACTION controlp INFIELD apga008 name="input.c.apga008"
            
            #END add-point
 
 
         #Ctrlp:input.c.apga009
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apga009
            #add-point:ON ACTION controlp INFIELD apga009 name="input.c.apga009"
            
            #END add-point
 
 
         #Ctrlp:input.c.apga013
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apga013
            #add-point:ON ACTION controlp INFIELD apga013 name="input.c.apga013"
            
            #END add-point
 
 
         #Ctrlp:input.c.apga012
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apga012
            #add-point:ON ACTION controlp INFIELD apga012 name="input.c.apga012"
            
            #END add-point
 
 
         #Ctrlp:input.c.apga010
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apga010
            #add-point:ON ACTION controlp INFIELD apga010 name="input.c.apga010"
            
            #END add-point
 
 
         #Ctrlp:input.c.apga014
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apga014
            #add-point:ON ACTION controlp INFIELD apga014 name="input.c.apga014"
            
            #END add-point
 
 
         #Ctrlp:input.c.apga011
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apga011
            #add-point:ON ACTION controlp INFIELD apga011 name="input.c.apga011"
            
            #END add-point
 
 
         #Ctrlp:input.c.apga100
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apga100
            #add-point:ON ACTION controlp INFIELD apga100 name="input.c.apga100"
		      INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
			   LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_apga_m.apga100
            LET g_qryparam.arg1 = g_apga_m.apgacomp 
            CALL q_ooaj002_1()                           
            LET g_apga_m.apga100 = g_qryparam.return1       
            DISPLAY BY NAME g_apga_m.apga100
            NEXT FIELD apga100       
            #END add-point
 
 
         #Ctrlp:input.c.apga015
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apga015
            #add-point:ON ACTION controlp INFIELD apga015 name="input.c.apga015"
            
            #END add-point
 
 
         #Ctrlp:input.c.apga103
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apga103
            #add-point:ON ACTION controlp INFIELD apga103 name="input.c.apga103"
            
            #END add-point
 
 
         #Ctrlp:input.c.apga104
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apga104
            #add-point:ON ACTION controlp INFIELD apga104 name="input.c.apga104"
            
            #END add-point
 
 
         #Ctrlp:input.c.apga108
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apga108
            #add-point:ON ACTION controlp INFIELD apga108 name="input.c.apga108"
            
            #END add-point
 
 
         #Ctrlp:input.c.apga102
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apga102
            #add-point:ON ACTION controlp INFIELD apga102 name="input.c.apga102"
            
            #END add-point
 
 
         #Ctrlp:input.c.apga026
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apga026
            #add-point:ON ACTION controlp INFIELD apga026 name="input.c.apga026"
            
            #END add-point
 
 
         #Ctrlp:input.c.apga040
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apga040
            #add-point:ON ACTION controlp INFIELD apga040 name="input.c.apga040"
            #160428-00001#1---s---
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_apga_m.apga040
            LET g_qryparam.where = " nmaa002 IN (SELECT ooef001 FROM ooef_t WHERE ooefent = ",g_enterprise," ",
                                   "              AND ooef017 = '",g_apga_m.apgacomp,"')",
                                   " AND EXISTS(SELECT 1 FROM nmag_t WHERE nmag001 = nmaa003 ",
                                   " AND nmag002 IN ('1','5') AND nmagent = nmaaent) ",    #160905-00002#3  
                                  #" AND nmas002 IN (SELECT nmll001 FROM nmll_t WHERE nmllent=",g_enterprise, " AND nmll002 = '",g_user,"')"   #161226-00048#1 mark
                                   #161226-00048#1 add (S)
                                   " AND ( nmas002 IN (SELECT nmll001 FROM nmll_t WHERE nmllent=",g_enterprise, " AND nmll002 = '",g_user,"')",
                                   "  OR nmas002 IN (SELECT nmlm001 FROM nmlm_t WHERE nmlment=",g_enterprise, " AND nmlm002 = '",g_dept,"') )"
                                   #161226-00048#1 add (E)
            IF NOT cl_null(g_apga_m.apga100) THEN
               LET g_qryparam.where = g_qryparam.where," AND nmas003 = '",g_apga_m.apga100,"' "
            END IF            
            CALL q_nmas_01()                             
            LET g_apga_m.apga040 = g_qryparam.return1
            DISPLAY BY NAME g_apga_m.apga040
            NEXT FIELD apga040    
            #160428-00001#1---e---            
            #END add-point
 
 
         #Ctrlp:input.c.apga109
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apga109
            #add-point:ON ACTION controlp INFIELD apga109 name="input.c.apga109"
            
            #END add-point
 
 
         #Ctrlp:input.c.glaa001
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glaa001
            #add-point:ON ACTION controlp INFIELD glaa001 name="input.c.glaa001"
            
            #END add-point
 
 
         #Ctrlp:input.c.apga101
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apga101
            #add-point:ON ACTION controlp INFIELD apga101 name="input.c.apga101"
            
            #END add-point
 
 
         #Ctrlp:input.c.apga113
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apga113
            #add-point:ON ACTION controlp INFIELD apga113 name="input.c.apga113"
            
            #END add-point
 
 
         #Ctrlp:input.c.apga114
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apga114
            #add-point:ON ACTION controlp INFIELD apga114 name="input.c.apga114"
            
            #END add-point
 
 
         #Ctrlp:input.c.apga118
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apga118
            #add-point:ON ACTION controlp INFIELD apga118 name="input.c.apga118"
            
            #END add-point
 
 
         #Ctrlp:input.c.apga112
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apga112
            #add-point:ON ACTION controlp INFIELD apga112 name="input.c.apga112"
            
            #END add-point
 
 
         #Ctrlp:input.c.apga105
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apga105
            #add-point:ON ACTION controlp INFIELD apga105 name="input.c.apga105"
            
            #END add-point
 
 
         #Ctrlp:input.c.apga016
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apga016
            #add-point:ON ACTION controlp INFIELD apga016 name="input.c.apga016"
            
            #END add-point
 
 
         #Ctrlp:input.c.apga017
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apga017
            #add-point:ON ACTION controlp INFIELD apga017 name="input.c.apga017"
            
            #END add-point
 
 
         #Ctrlp:input.c.apga018
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apga018
            #add-point:ON ACTION controlp INFIELD apga018 name="input.c.apga018"
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_apga_m.apga018
            LET g_qryparam.where = " fmacstus = 'Y' ",
                                   " AND fmac004 <= '",g_apga_m.apga003,"' ",
                                   " AND fmac005 >= '",g_apga_m.apga003,"' ",
                                   " AND fmac003 = '",g_apga_m.apga007,"' ",
                                   " AND EXISTS (SELECT 1 FROM ooef_t WHERE ooefent = fmacent AND ooef001 = fmac002 AND ooef017 = '",g_apga_m.apgacomp,"')"                                   
            CALL q_fmac001()
            LET g_apga_m.apga018 = g_qryparam.return1
            DISPLAY BY NAME g_apga_m.apga018
            NEXT FIELD apga018
            #END add-point
 
 
         #Ctrlp:input.c.apga115
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apga115
            #add-point:ON ACTION controlp INFIELD apga115 name="input.c.apga115"
            
            #END add-point
 
 
         #Ctrlp:input.c.apga106
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apga106
            #add-point:ON ACTION controlp INFIELD apga106 name="input.c.apga106"
            
            #END add-point
 
 
         #Ctrlp:input.c.apga107
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apga107
            #add-point:ON ACTION controlp INFIELD apga107 name="input.c.apga107"
            
            #END add-point
 
 
         #Ctrlp:input.c.apga019
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apga019
            #add-point:ON ACTION controlp INFIELD apga019 name="input.c.apga019"
            
            #END add-point
 
 
         #Ctrlp:input.c.apga020
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apga020
            #add-point:ON ACTION controlp INFIELD apga020 name="input.c.apga020"
            #運輸方式
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
			   LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_apga_m.apga020     
            LET g_qryparam.arg1 = "263"
            CALL q_oocq002()                          
            LET g_apga_m.apga020 = g_qryparam.return1    
            CALL s_desc_get_acc_desc('263',g_apga_m.apga020) RETURNING g_apga_m.apga020_desc
            DISPLAY BY NAME g_apga_m.apga020,g_apga_m.apga020_desc
            NEXT FIELD apga020                
            #END add-point
 
 
         #Ctrlp:input.c.apga021
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apga021
            #add-point:ON ACTION controlp INFIELD apga021 name="input.c.apga021"
            
            #END add-point
 
 
         #Ctrlp:input.c.apga022
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apga022
            #add-point:ON ACTION controlp INFIELD apga022 name="input.c.apga022"
            
            #END add-point
 
 
         #Ctrlp:input.c.apga023
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apga023
            #add-point:ON ACTION controlp INFIELD apga023 name="input.c.apga023"
            
            #END add-point
 
 
         #Ctrlp:input.c.apga024
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apga024
            #add-point:ON ACTION controlp INFIELD apga024 name="input.c.apga024"
            
            #END add-point
 
 
         #Ctrlp:input.c.apga025
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apga025
            #add-point:ON ACTION controlp INFIELD apga025 name="input.c.apga025"
            
            #END add-point
 
 
         #Ctrlp:input.c.l_apga1041
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_apga1041
            #add-point:ON ACTION controlp INFIELD l_apga1041 name="input.c.l_apga1041"
            
            #END add-point
 
 
         #Ctrlp:input.c.apga036
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apga036
            #add-point:ON ACTION controlp INFIELD apga036 name="input.c.apga036"
            #160428-00001#1 ---s---
            LET l_glaa005 = NULL
            SELECT glaa005 INTO l_glaa005 FROM glaa_t
             WHERE glaaent  = g_enterprise
               AND glaacomp = g_apga_m.apgacomp
               AND glaa014  = 'Y'
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_apga_m.apga036             #給予default值
            LET g_qryparam.arg1 = l_glaa005
            LET g_qryparam.where = " nmad002 IN (SELECT nmaj001 FROM nmaj_t WHERE nmaj002='2'AND nmajstus='Y' AND nmajent = ",g_enterprise," )"
            CALL q_nmad002()                               
            LET g_apga_m.apga036 = g_qryparam.return1
            DISPLAY BY NAME g_apga_m.apga036
            NEXT FIELD apga036
            #160428-00001#1 ---e---
            #END add-point
 
 
         #Ctrlp:input.c.apga037
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apga037
            #add-point:ON ACTION controlp INFIELD apga037 name="input.c.apga037"
            #160428-00001#1 ---s---
            #開窗i段
            LET l_glaa005 = NULL
            SELECT glaa005 INTO l_glaa005 FROM glaa_t
             WHERE glaaent  = g_enterprise
               AND glaacomp = g_apga_m.apgacomp
               AND glaa014  = 'Y'
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_apga_m.apga037             
            LET g_qryparam.arg1 = "" 
            LET g_qryparam.where = " nmai001='",l_glaa005,"' "   
            CALL q_nmai002()                                
            LET g_apga_m.apga037 = g_qryparam.return1
            DISPLAY g_apga_m.apga037 TO apga037              
            NEXT FIELD apga037     
            #160428-00001#1 ---e---
            #END add-point
 
 
         #Ctrlp:input.c.apga032
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apga032
            #add-point:ON ACTION controlp INFIELD apga032 name="input.c.apga032"
            
            #END add-point
 
 
         #Ctrlp:input.c.l_apga1081
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_apga1081
            #add-point:ON ACTION controlp INFIELD l_apga1081 name="input.c.l_apga1081"
            
            #END add-point
 
 
         #Ctrlp:input.c.apga034
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apga034
            #add-point:ON ACTION controlp INFIELD apga034 name="input.c.apga034"
            LET l_glaa005 = NULL
            SELECT glaa005 INTO l_glaa005 FROM glaa_t
             WHERE glaaent  = g_enterprise
               AND glaacomp = g_apga_m.apgacomp
               AND glaa014  = 'Y'
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_apga_m.apga034             #給予default值
            LET g_qryparam.arg1 = l_glaa005
            LET g_qryparam.where = " nmad002 IN (SELECT nmaj001 FROM nmaj_t WHERE nmaj002='2'AND nmajstus='Y' AND nmajent = ",g_enterprise," )"
            CALL q_nmad002()                               
            LET g_apga_m.apga034 = g_qryparam.return1
            DISPLAY BY NAME g_apga_m.apga034
            NEXT FIELD apga034 
            #END add-point
 
 
         #Ctrlp:input.c.apga035
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apga035
            #add-point:ON ACTION controlp INFIELD apga035 name="input.c.apga035"
            #160428-00001#1 ---s---
            #開窗i段
            LET l_glaa005 = NULL
            SELECT glaa005 INTO l_glaa005 FROM glaa_t
             WHERE glaaent  = g_enterprise
               AND glaacomp = g_apga_m.apgacomp
               AND glaa014  = 'Y'
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_apga_m.apga035             
            LET g_qryparam.arg1 = "" 
            LET g_qryparam.where = " nmai001='",l_glaa005,"' "   
            CALL q_nmai002()                                
            LET g_apga_m.apga035 = g_qryparam.return1
            DISPLAY g_apga_m.apga035 TO apga035              
            NEXT FIELD apga035           
            #160428-00001#1 ---e---
            #END add-point
 
 
         #Ctrlp:input.c.apga031
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apga031
            #add-point:ON ACTION controlp INFIELD apga031 name="input.c.apga031"
            
            #END add-point
 
 
         #Ctrlp:input.c.l_apga1021
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_apga1021
            #add-point:ON ACTION controlp INFIELD l_apga1021 name="input.c.l_apga1021"
            
            #END add-point
 
 
         #Ctrlp:input.c.apga038
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apga038
            #add-point:ON ACTION controlp INFIELD apga038 name="input.c.apga038"
            #160428-00001#1 ---s---
            LET l_glaa005 = NULL
            SELECT glaa005 INTO l_glaa005 FROM glaa_t
             WHERE glaaent  = g_enterprise
               AND glaacomp = g_apga_m.apgacomp
               AND glaa014  = 'Y'
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_apga_m.apga038             #給予default值
            LET g_qryparam.arg1 = l_glaa005
            LET g_qryparam.where = " nmad002 IN (SELECT nmaj001 FROM nmaj_t WHERE nmaj002='2'AND nmajstus='Y' AND nmajent = ",g_enterprise," )"
            CALL q_nmad002()                               
            LET g_apga_m.apga038 = g_qryparam.return1
            DISPLAY BY NAME g_apga_m.apga038
            NEXT FIELD apga038 
            #160428-00001#1 ---e---
            #END add-point
 
 
         #Ctrlp:input.c.apga039
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apga039
            #add-point:ON ACTION controlp INFIELD apga039 name="input.c.apga039"
            #160428-00001#1 ---s---
            #開窗i段
            LET l_glaa005 = NULL
            SELECT glaa005 INTO l_glaa005 FROM glaa_t
             WHERE glaaent  = g_enterprise
               AND glaacomp = g_apga_m.apgacomp
               AND glaa014  = 'Y'
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_apga_m.apga039             
            LET g_qryparam.arg1 = "" 
            LET g_qryparam.where = " nmai001='",l_glaa005,"' "   
            CALL q_nmai002()                                
            LET g_apga_m.apga039 = g_qryparam.return1
            DISPLAY g_apga_m.apga039 TO apga039              
            NEXT FIELD apga039    
            #160428-00001#1 ---e---
            #END add-point
 
 
         #Ctrlp:input.c.apga033
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apga033
            #add-point:ON ACTION controlp INFIELD apga033 name="input.c.apga033"
            
            #END add-point
 
 
         #Ctrlp:input.c.apga027
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apga027
            #add-point:ON ACTION controlp INFIELD apga027 name="input.c.apga027"
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_apgadocno()
            DISPLAY g_qryparam.return1 TO apga027
            NEXT FIELD apga027
            #END add-point
 
 
 #欄位開窗
            
         AFTER INPUT
            IF INT_FLAG THEN
               EXIT DIALOG
            END IF
 
            #CALL cl_err_collect_show()      #錯誤訊息統整顯示
            #CALL cl_showmsg()
            DISPLAY BY NAME g_apga_m.apgacomp,g_apga_m.apgadocno
                        
            #add-point:單頭INPUT後 name="input.head.after_input"
            
            #end add-point
                        
            IF p_cmd <> 'u' THEN
    
               CALL s_transaction_begin()
               
               #add-point:單頭新增前 name="input.head.b_insert"
               #新增前才取單號
               LET l_ld = NULL
               SELECT glaald INTO l_ld FROM glaa_t
                WHERE glaaent = g_enterprise
                  AND glaacomp = g_apga_m.apgacomp
                  AND glaa014 = 'Y'
               CALL s_aooi200_fin_gen_docno(l_ld,'','',g_apga_m.apgadocno,g_apga_m.apgadocdt,g_prog)
                    RETURNING g_sub_success,g_apga_m.apgadocno
               IF NOT g_sub_success THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'apm-00003'
                  LET g_errparam.extend = g_apga_m.apgadocno
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
                  CALL s_transaction_end('N','0')
                  NEXT FIELD apgadocno
               END IF
               DISPLAY BY NAME g_apga_m.apgadocno
               IF g_apga_m.apga002 = '0' THEN LET g_apga_m.apga109 = g_apga_m.apga103 END IF #160428-00001#1 
               #end add-point
               
               INSERT INTO apga_t (apgaent,apgacomp,apga005,apga006,apgadocno,apga002,apgadocdt,apga003, 
                   apga004,apga001,apga028,apga029,apgastus,apgaownid,apgaowndp,apgacrtid,apgacrtdp, 
                   apgacrtdt,apgamodid,apgamoddt,apgacnfid,apgacnfdt,apgapstid,apgapstdt,apga007,apga030, 
                   apga008,apga009,apga013,apga012,apga010,apga014,apga011,apga100,apga015,apga103,apga104, 
                   apga108,apga102,apga026,apga040,apga109,apga101,apga113,apga114,apga118,apga112,apga105, 
                   apga016,apga017,apga018,apga115,apga106,apga107,apga019,apga020,apga021,apga022,apga023, 
                   apga024,apga025,apga036,apga037,apga032,apga034,apga035,apga031,apga038,apga039,apga033, 
                   apga027)
               VALUES (g_enterprise,g_apga_m.apgacomp,g_apga_m.apga005,g_apga_m.apga006,g_apga_m.apgadocno, 
                   g_apga_m.apga002,g_apga_m.apgadocdt,g_apga_m.apga003,g_apga_m.apga004,g_apga_m.apga001, 
                   g_apga_m.apga028,g_apga_m.apga029,g_apga_m.apgastus,g_apga_m.apgaownid,g_apga_m.apgaowndp, 
                   g_apga_m.apgacrtid,g_apga_m.apgacrtdp,g_apga_m.apgacrtdt,g_apga_m.apgamodid,g_apga_m.apgamoddt, 
                   g_apga_m.apgacnfid,g_apga_m.apgacnfdt,g_apga_m.apgapstid,g_apga_m.apgapstdt,g_apga_m.apga007, 
                   g_apga_m.apga030,g_apga_m.apga008,g_apga_m.apga009,g_apga_m.apga013,g_apga_m.apga012, 
                   g_apga_m.apga010,g_apga_m.apga014,g_apga_m.apga011,g_apga_m.apga100,g_apga_m.apga015, 
                   g_apga_m.apga103,g_apga_m.apga104,g_apga_m.apga108,g_apga_m.apga102,g_apga_m.apga026, 
                   g_apga_m.apga040,g_apga_m.apga109,g_apga_m.apga101,g_apga_m.apga113,g_apga_m.apga114, 
                   g_apga_m.apga118,g_apga_m.apga112,g_apga_m.apga105,g_apga_m.apga016,g_apga_m.apga017, 
                   g_apga_m.apga018,g_apga_m.apga115,g_apga_m.apga106,g_apga_m.apga107,g_apga_m.apga019, 
                   g_apga_m.apga020,g_apga_m.apga021,g_apga_m.apga022,g_apga_m.apga023,g_apga_m.apga024, 
                   g_apga_m.apga025,g_apga_m.apga036,g_apga_m.apga037,g_apga_m.apga032,g_apga_m.apga034, 
                   g_apga_m.apga035,g_apga_m.apga031,g_apga_m.apga038,g_apga_m.apga039,g_apga_m.apga033, 
                   g_apga_m.apga027) 
               IF SQLCA.SQLCODE THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "g_apga_m:",SQLERRMESSAGE 
                  LET g_errparam.code = SQLCA.SQLCODE 
                  LET g_errparam.popup = TRUE 
                  CALL s_transaction_end('N','0')
                  CALL cl_err()
                  NEXT FIELD CURRENT
               END IF
               
               #add-point:單頭新增中 name="input.head.m_insert"
               
               #end add-point
               
               
               
               
               #add-point:單頭新增後 name="input.head.a_insert"
               
               #end add-point
               CALL s_transaction_end('Y','0') 
               
               IF l_cmd_t = 'r' AND p_cmd = 'a' THEN
                  CALL aapt510_detail_reproduce()
                  #因應特定程式需求, 重新刷新單身資料
                  CALL aapt510_b_fill()
                  CALL aapt510_b_fill2('0')
               END IF
               
               #add-point:單頭新增後 name="input.head.a_insert2"
               
               #end add-point
               
               LET g_master_insert = TRUE
               
               LET p_cmd = 'u'
            ELSE
               CALL s_transaction_begin()
            
               #add-point:單頭修改前 name="input.head.b_update"
               IF g_apga_m.apga002 = '0' THEN LET g_apga_m.apga109 = g_apga_m.apga103 END IF #160428-00001#1
               #end add-point
               
               #將遮罩欄位還原
               CALL aapt510_apga_t_mask_restore('restore_mask_o')
               
               UPDATE apga_t SET (apgacomp,apga005,apga006,apgadocno,apga002,apgadocdt,apga003,apga004, 
                   apga001,apga028,apga029,apgastus,apgaownid,apgaowndp,apgacrtid,apgacrtdp,apgacrtdt, 
                   apgamodid,apgamoddt,apgacnfid,apgacnfdt,apgapstid,apgapstdt,apga007,apga030,apga008, 
                   apga009,apga013,apga012,apga010,apga014,apga011,apga100,apga015,apga103,apga104,apga108, 
                   apga102,apga026,apga040,apga109,apga101,apga113,apga114,apga118,apga112,apga105,apga016, 
                   apga017,apga018,apga115,apga106,apga107,apga019,apga020,apga021,apga022,apga023,apga024, 
                   apga025,apga036,apga037,apga032,apga034,apga035,apga031,apga038,apga039,apga033,apga027) = (g_apga_m.apgacomp, 
                   g_apga_m.apga005,g_apga_m.apga006,g_apga_m.apgadocno,g_apga_m.apga002,g_apga_m.apgadocdt, 
                   g_apga_m.apga003,g_apga_m.apga004,g_apga_m.apga001,g_apga_m.apga028,g_apga_m.apga029, 
                   g_apga_m.apgastus,g_apga_m.apgaownid,g_apga_m.apgaowndp,g_apga_m.apgacrtid,g_apga_m.apgacrtdp, 
                   g_apga_m.apgacrtdt,g_apga_m.apgamodid,g_apga_m.apgamoddt,g_apga_m.apgacnfid,g_apga_m.apgacnfdt, 
                   g_apga_m.apgapstid,g_apga_m.apgapstdt,g_apga_m.apga007,g_apga_m.apga030,g_apga_m.apga008, 
                   g_apga_m.apga009,g_apga_m.apga013,g_apga_m.apga012,g_apga_m.apga010,g_apga_m.apga014, 
                   g_apga_m.apga011,g_apga_m.apga100,g_apga_m.apga015,g_apga_m.apga103,g_apga_m.apga104, 
                   g_apga_m.apga108,g_apga_m.apga102,g_apga_m.apga026,g_apga_m.apga040,g_apga_m.apga109, 
                   g_apga_m.apga101,g_apga_m.apga113,g_apga_m.apga114,g_apga_m.apga118,g_apga_m.apga112, 
                   g_apga_m.apga105,g_apga_m.apga016,g_apga_m.apga017,g_apga_m.apga018,g_apga_m.apga115, 
                   g_apga_m.apga106,g_apga_m.apga107,g_apga_m.apga019,g_apga_m.apga020,g_apga_m.apga021, 
                   g_apga_m.apga022,g_apga_m.apga023,g_apga_m.apga024,g_apga_m.apga025,g_apga_m.apga036, 
                   g_apga_m.apga037,g_apga_m.apga032,g_apga_m.apga034,g_apga_m.apga035,g_apga_m.apga031, 
                   g_apga_m.apga038,g_apga_m.apga039,g_apga_m.apga033,g_apga_m.apga027)
                WHERE apgaent = g_enterprise AND apgacomp = g_apgacomp_t
                  AND apgadocno = g_apgadocno_t
 
               IF SQLCA.SQLCODE THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "apga_t:",SQLERRMESSAGE 
                  LET g_errparam.code = SQLCA.SQLCODE 
                  LET g_errparam.popup = TRUE 
                  CALL s_transaction_end('N','0')
                  CALL cl_err()
                  NEXT FIELD CURRENT
               END IF
               
               #add-point:單頭修改中 name="input.head.m_update"
               
               #end add-point
               
               
               
               
               #將遮罩欄位進行遮蔽
               CALL aapt510_apga_t_mask_restore('restore_mask_n')
               
               #修改歷程記錄(單頭修改)
               LET g_log1 = util.JSON.stringify(g_apga_m_t)
               LET g_log2 = util.JSON.stringify(g_apga_m)
               IF NOT cl_log_modified_record(g_log1,g_log2) THEN 
                  CALL s_transaction_end('N','0')
               ELSE
                  CALL s_transaction_end('Y','0')
               END IF
               
               #add-point:單頭修改後 name="input.head.a_update"
               
               #end add-point
            END IF
            
            LET g_master_commit = "Y"
            LET g_apgacomp_t = g_apga_m.apgacomp
            LET g_apgadocno_t = g_apga_m.apgadocno
 
            
      END INPUT
   
 
{</section>}
 
{<section id="aapt510.input.body" >}
   
      #Page1 預設值產生於此處
      INPUT ARRAY g_apgb_d FROM s_detail1.*
          ATTRIBUTE(COUNT = g_rec_b,WITHOUT DEFAULTS, #MAXCOUNT = g_max_rec,
                  INSERT ROW = l_allow_insert, 
                  DELETE ROW = l_allow_delete,
                  APPEND ROW = l_allow_insert)
 
         #自訂ACTION(detail_input,page_1)
         
         
         BEFORE INPUT
            #add-point:資料輸入前 name="input.body.before_input2"
            
            #end add-point
            IF g_insert = 'Y' AND NOT cl_null(g_insert) THEN 
              CALL FGL_SET_ARR_CURR(g_apgb_d.getLength()+1) 
              LET g_insert = 'N' 
           END IF 
 
            CALL aapt510_b_fill()
            #如果一直都在單身1則控制筆數位置
            IF g_loc = 'm' AND g_rec_b != 0 THEN
               CALL FGL_SET_ARR_CURR(g_idx_group.getValue("'1',"))
            END IF
            LET g_loc = 'm'
            LET g_rec_b = g_apgb_d.getLength()
            #add-point:資料輸入前 name="input.d.before_input"
            
            #end add-point
         
         BEFORE ROW
            #add-point:modify段before row2 name="input.body.before_row2"
            
            #end add-point  
            LET l_insert = FALSE
            LET l_cmd = ''
            LET l_ac_t = l_ac 
            LET l_ac = ARR_CURR()
            LET g_detail_idx = l_ac
            LET g_detail_idx_list[1] = l_ac
            LET g_current_page = 1
            
            LET l_lock_sw = 'N'            #DEFAULT
            LET l_n = ARR_COUNT()
            DISPLAY l_ac TO FORMONLY.idx
         
            CALL s_transaction_begin()
            OPEN aapt510_cl USING g_enterprise,g_apga_m.apgacomp,g_apga_m.apgadocno
            IF SQLCA.SQLCODE THEN   #(ver:78)
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "OPEN aapt510_cl:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE   #(ver:78)
               LET g_errparam.popup = TRUE 
               CLOSE aapt510_cl
               CALL s_transaction_end('N','0')
               CALL cl_err()
               RETURN
            END IF
            
            LET g_rec_b = g_apgb_d.getLength()
            
            IF g_rec_b >= l_ac 
               AND g_apgb_d[l_ac].apgbseq IS NOT NULL
 
            THEN
               LET l_cmd='u'
               LET g_apgb_d_t.* = g_apgb_d[l_ac].*  #BACKUP
               LET g_apgb_d_o.* = g_apgb_d[l_ac].*  #BACKUP
               CALL aapt510_set_entry_b(l_cmd)
               #add-point:modify段after_set_entry_b name="input.body.after_set_entry_b"
 
               #end add-point  
               CALL aapt510_set_no_entry_b(l_cmd)
               IF NOT aapt510_lock_b("apgb_t","'1'") THEN
                  LET l_lock_sw='Y'
               ELSE
                  FETCH aapt510_bcl INTO g_apgb_d[l_ac].apgbseq,g_apgb_d[l_ac].apgborga,g_apgb_d[l_ac].apgb001, 
                      g_apgb_d[l_ac].apgb002,g_apgb_d[l_ac].apgb003,g_apgb_d[l_ac].apgb004,g_apgb_d[l_ac].apgb005, 
                      g_apgb_d[l_ac].apgb008,g_apgb_d[l_ac].apgb006,g_apgb_d[l_ac].apgb007,g_apgb_d[l_ac].apgb100, 
                      g_apgb_d[l_ac].apgb101,g_apgb_d[l_ac].apgb009,g_apgb_d[l_ac].apgb105,g_apgb_d[l_ac].apgb115, 
                      g_apgb_d[l_ac].apgb010,g_apgb_d[l_ac].apgb011
                  IF SQLCA.SQLCODE THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = g_apgb_d_t.apgbseq,":",SQLERRMESSAGE 
                     LET g_errparam.code = SQLCA.SQLCODE 
                     LET g_errparam.popup = TRUE 
                     CALL cl_err()
                     LET l_lock_sw = "Y"
                  END IF
                  
                  #遮罩相關處理
                  LET g_apgb_d_mask_o[l_ac].* =  g_apgb_d[l_ac].*
                  CALL aapt510_apgb_t_mask()
                  LET g_apgb_d_mask_n[l_ac].* =  g_apgb_d[l_ac].*
                  
                  LET g_bfill = "N"
                  CALL aapt510_show()
                  LET g_bfill = "Y"
                  
                  CALL cl_show_fld_cont()
               END IF
            ELSE
               LET l_cmd='a'
            END IF
            #add-point:modify段before row name="input.body.before_row"
            
            #end add-point  
            #其他table資料備份(確定是否更改用)
            
 
            #其他table進行lock
            
 
        
         BEFORE INSERT  
            
            IF s_transaction_chk("N",0) THEN
               CALL s_transaction_begin()
            END IF
            LET l_insert = TRUE
            LET l_n = ARR_COUNT()
            LET l_cmd = 'a'
            INITIALIZE g_apgb_d[l_ac].* TO NULL 
            INITIALIZE g_apgb_d_t.* TO NULL 
            INITIALIZE g_apgb_d_o.* TO NULL 
            #公用欄位給值(單身)
            
            #自定義預設值
                  LET g_apgb_d[l_ac].apgbseq = "0"
      LET g_apgb_d[l_ac].apgb002 = "0"
      LET g_apgb_d[l_ac].apgb008 = "0"
      LET g_apgb_d[l_ac].apgb101 = "0"
      LET g_apgb_d[l_ac].apgb009 = "0"
      LET g_apgb_d[l_ac].apgb105 = "0"
      LET g_apgb_d[l_ac].apgb115 = "0"
      LET g_apgb_d[l_ac].apgb010 = "0"
      LET g_apgb_d[l_ac].apgb011 = "0"
 
            #add-point:modify段before備份 name="input.body.insert.before_bak"
            LET g_apgb_d[l_ac].apgbseq = NULL
            SELECT MAX(apgbseq)+1 INTO g_apgb_d[l_ac].apgbseq
              FROM apgb_t
             WHERE apgbent = g_enterprise
               AND apgbcomp = g_apga_m.apgacomp
               AND apgbdocno = g_apga_m.apgadocno
            IF cl_null(g_apgb_d[l_ac].apgbseq)THEN
               LET g_apgb_d[l_ac].apgbseq = 1 
            END IF
              
            #預設g_site
            #法人比對單頭法人
            #檢核是否為法人下組織   #用8營運中心展
            #下展組織與權限也要符合才可帶出
            LET g_apgb_d[l_ac].apgborga = g_site
            LET l_sql = "SELECT COUNT(*) FROM ooef_t ",
                        " WHERE ooefent = ",g_enterprise," ",
                        "   AND ooef001 = '",g_apgb_d[l_ac].apgborga,"' ",
                        "   AND ooef017 = '",g_apga_m.apgacomp,"' ",
                        "   AND ooef001 IN ",g_wc_apgborga,
                        "   AND ooefstus = 'Y' "
            PREPARE sel_ooefp1 FROM l_sql
            LET l_count = NULL
            EXECUTE sel_ooefp1 INTO l_count 
            IF cl_null(l_count)THEN LET l_count = 0 END IF
            IF l_count = 0 THEN
               LET g_apgb_d[l_ac].apgborga = ''
            END IF
            LET g_apgb_d[l_ac].apgb002 = ''
            
            LET g_apgb_d[l_ac].apgborga_desc = s_desc_get_department_desc(g_apgb_d[l_ac].apgborga)
            DISPLAY BY NAME g_apgb_d[l_ac].apgborga_desc
            
            IF l_ac > 1 THEN
               LET g_apgb_d[l_ac].apgb006 = g_apgb_d[l_ac-1].apgb006
            END IF
            IF NOT cl_null(g_apgb_d[l_ac].apgb006)THEN   #albireo 160624 add
               CALL s_tax_chk(g_apga_m.apgacomp,g_apgb_d[l_ac].apgb006) RETURNING g_sub_success,l_oodb004,l_apca013,l_apca012,l_oodb011
            END IF                                       #albireo 160624 add
            LET g_apgb_d[l_ac].apgb007 = l_apca013
            #end add-point
            LET g_apgb_d_t.* = g_apgb_d[l_ac].*     #新輸入資料
            LET g_apgb_d_o.* = g_apgb_d[l_ac].*     #新輸入資料
            CALL cl_show_fld_cont()
            CALL aapt510_set_entry_b(l_cmd)
            #add-point:modify段after_set_entry_b name="input.body.insert.after_set_entry_b"
            
            #end add-point
            CALL aapt510_set_no_entry_b(l_cmd)
            IF lb_reproduce THEN
               LET lb_reproduce = FALSE
               LET g_apgb_d[li_reproduce_target].* = g_apgb_d[li_reproduce].*
 
               LET g_apgb_d[li_reproduce_target].apgbseq = NULL
 
            END IF
            
 
            #add-point:modify段before insert name="input.body.before_insert"
            
            #end add-point  
  
         AFTER INSERT
            LET l_insert = FALSE
            IF INT_FLAG THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code = 9001 
               LET g_errparam.popup = FALSE 
               CALL cl_err()
               LET INT_FLAG = 0
               CANCEL INSERT
            END IF
               
            #add-point:單身新增 name="input.body.b_a_insert"
            
            #end add-point
               
            LET l_count = 1  
            SELECT COUNT(1) INTO l_count FROM apgb_t 
             WHERE apgbent = g_enterprise AND apgbcomp = g_apga_m.apgacomp
               AND apgbdocno = g_apga_m.apgadocno
 
               AND apgbseq = g_apgb_d[l_ac].apgbseq
 
                
            #資料未重複, 插入新增資料
            IF l_count = 0 THEN 
               #add-point:單身新增前 name="input.body.b_insert"
               
               #end add-point
            
               #同步新增到同層的table
                              INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_apga_m.apgacomp
               LET gs_keys[2] = g_apga_m.apgadocno
               LET gs_keys[3] = g_apgb_d[g_detail_idx].apgbseq
               CALL aapt510_insert_b('apgb_t',gs_keys,"'1'")
                           
               #add-point:單身新增後 name="input.body.a_insert"
               
               #end add-point
            ELSE    
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = 'INSERT' 
               LET g_errparam.code = "std-00006" 
               LET g_errparam.popup = TRUE 
               INITIALIZE g_apgb_d[l_ac].* TO NULL
               CALL s_transaction_end('N','0')
               CALL cl_err()
               CANCEL INSERT
            END IF
 
            IF SQLCA.SQLCODE THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "apgb_t:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE 
               LET g_errparam.popup = TRUE 
               CALL s_transaction_end('N','0')                    
               CALL cl_err()
               CANCEL INSERT
            ELSE
               #先刷新資料
               #CALL aapt510_b_fill()
               #資料多語言用-增/改
               
               #add-point:input段-after_insert name="input.body.a_insert2"
               
               #end add-point
               CALL s_transaction_end('Y','0')
               #ERROR 'INSERT O.K'
               LET g_rec_b = g_rec_b + 1
            END IF
              
         BEFORE DELETE                            #是否取消單身
            IF l_cmd = 'a' THEN
               LET l_cmd='d'
               #add-point:單身刪除後(=d) name="input.body.after_delete_d"
               
               #end add-point
            ELSE
               #add-point:單身刪除前 name="input.body.b_delete_ask"
               
               #end add-point 
               IF NOT cl_ask_del_detail() THEN
                  CANCEL DELETE
               END IF
               IF l_lock_sw = "Y" THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "" 
                  LET g_errparam.code = -263 
                  LET g_errparam.popup = TRUE 
                  CALL cl_err()
                  CANCEL DELETE
               END IF
               
               #add-point:單身刪除前 name="input.body.b_delete"
               
               #end add-point 
               
               #取得該筆資料key值
               INITIALIZE gs_keys TO NULL
               LET gs_keys[01] = g_apga_m.apgacomp
               LET gs_keys[gs_keys.getLength()+1] = g_apga_m.apgadocno
 
               LET gs_keys[gs_keys.getLength()+1] = g_apgb_d_t.apgbseq
 
            
               #刪除同層單身
               IF NOT aapt510_delete_b('apgb_t',gs_keys,"'1'") THEN
                  CALL s_transaction_end('N','0')
                  CLOSE aapt510_bcl
                  CANCEL DELETE
               END IF
    
               #刪除下層單身
               IF NOT aapt510_key_delete_b(gs_keys,'apgb_t') THEN
                  CALL s_transaction_end('N','0')
                  CLOSE aapt510_bcl
                  CANCEL DELETE
               END IF
               
               #刪除多語言
               
 
               
               #add-point:單身刪除中 name="input.body.m_delete"
               
               #end add-point 
               
               CALL s_transaction_end('Y','0')
               CLOSE aapt510_bcl
            
               LET g_rec_b = g_rec_b-1
               #add-point:單身刪除後 name="input.body.a_delete"
               
               #end add-point
               LET l_count = g_apgb_d.getLength()
               
               #add-point:單身刪除後(<>d) name="input.body.after_delete"
               
               #end add-point
            END IF
 
         AFTER DELETE
            #如果是最後一筆
            IF l_ac = (g_apgb_d.getLength() + 1) THEN
               CALL FGL_SET_ARR_CURR(l_ac-1)
            END IF
 
                  #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apgbseq
            #add-point:BEFORE FIELD apgbseq name="input.b.page1.apgbseq"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apgbseq
            
            #add-point:AFTER FIELD apgbseq name="input.a.page1.apgbseq"
            #應用 a05 樣板自動產生(Version:2)
            #確認資料無重複
            IF  g_apga_m.apgacomp IS NOT NULL AND g_apga_m.apgadocno IS NOT NULL AND g_apgb_d[g_detail_idx].apgbseq IS NOT NULL THEN 
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_apga_m.apgacomp != g_apgacomp_t OR g_apga_m.apgadocno != g_apgadocno_t OR g_apgb_d[g_detail_idx].apgbseq != g_apgb_d_t.apgbseq)) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM apgb_t WHERE "||"apgbent = '" ||g_enterprise|| "' AND "||"apgbcomp = '"||g_apga_m.apgacomp ||"' AND "|| "apgbdocno = '"||g_apga_m.apgadocno ||"' AND "|| "apgbseq = '"||g_apgb_d[g_detail_idx].apgbseq ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF


            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apgbseq
            #add-point:ON CHANGE apgbseq name="input.g.page1.apgbseq"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apgborga
            
            #add-point:AFTER FIELD apgborga name="input.a.page1.apgborga"
            LET g_apgb_d[l_ac].apgborga_desc = ''
            DISPLAY BY NAME g_apgb_d[l_ac].apgborga_desc
            LET l_ld = NULL
            SELECT glaald INTO l_ld FROM glaa_t
             WHERE glaaent = g_enterprise
               AND glaacomp = g_apga_m.apgacomp
               AND glaa014 = 'Y'
            #來源組織
            IF NOT cl_null(g_apgb_d[l_ac].apgborga) THEN
               IF l_cmd = 'a' OR (l_cmd = 'u' AND (g_apgb_d[l_ac].apgborga != g_apgb_d_t.apgborga OR g_apgb_d_t.apgborga IS NULL )) THEN            
                  INITIALIZE g_chkparam.* TO NULL
                  LET g_chkparam.arg1 = g_apgb_d[l_ac].apgborga
                  #160318-00025#24  by 07900 --add-str
                  LET g_errshow = TRUE #是否開窗                   
                  LET g_chkparam.err_str[1] ="aoo-00095:sub-01302|aooi125|",cl_get_progname("aooi125",g_lang,"2"),"|:EXEPROGaooi125"
                  #160318-00025#24  by 07900 --add-end
                  IF NOT cl_chk_exist("v_ooef001") THEN
                     LET g_apgb_d[l_ac].apgborga = g_apgb_d_t.apgborga
                     LET g_apgb_d[l_ac].apgborga_desc = s_desc_get_department_desc(g_apgb_d[l_ac].apgborga)
                     DISPLAY BY NAME g_apgb_d[l_ac].apgborga_desc
                     NEXT FIELD CURRENT
                  END IF
                  CALL s_aap_apcborga_chk(l_ld,g_apga_m.apgadocno,g_apgb_d[l_ac].apgborga,g_wc_apgborga) 
                       RETURNING g_sub_success,g_errno
                  IF NOT g_sub_success THEN
                     LET g_errparam.code = g_errno
                     LET g_errparam.extend = ''
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                     LET g_apgb_d[l_ac].apgborga = g_apgb_d_t.apgborga
                     LET g_apgb_d[l_ac].apgborga_desc = s_desc_get_department_desc(g_apgb_d[l_ac].apgborga)
                     DISPLAY BY NAME g_apgb_d[l_ac].apgborga_desc
                     NEXT FIELD CURRENT
                  END IF
                  
                   CALL s_fin_orga_get_comp_ld(g_apgb_d[l_ac].apgborga) RETURNING g_sub_success,g_errno,l_comp,l_ld
                   IF l_comp <> g_apga_m.apgacomp THEN
                      LET g_errparam.code = 'axc-00112'
                      LET g_errparam.extend = ''
                      LET g_errparam.popup = TRUE
                      CALL cl_err()
                      LET g_apgb_d[l_ac].apgborga = g_apgb_d_t.apgborga
                      LET g_apgb_d[l_ac].apgborga_desc = s_desc_get_department_desc(g_apgb_d[l_ac].apgborga)
                      DISPLAY BY NAME g_apgb_d[l_ac].apgborga_desc
                      NEXT FIELD CURRENT
                   END IF
                  
               END IF  
            END IF  
            LET g_apgb_d[l_ac].apgborga_desc = s_desc_get_department_desc(g_apgb_d[l_ac].apgborga)
            DISPLAY BY NAME g_apgb_d[l_ac].apgborga_desc            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apgborga
            #add-point:BEFORE FIELD apgborga name="input.b.page1.apgborga"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apgborga
            #add-point:ON CHANGE apgborga name="input.g.page1.apgborga"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apgb001
            #add-point:BEFORE FIELD apgb001 name="input.b.page1.apgb001"
            CALL aapt510_set_entry_b(p_cmd)
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apgb001
            
            #add-point:AFTER FIELD apgb001 name="input.a.page1.apgb001"
            LET l_ld = NULL
            SELECT glaald INTO l_ld
              FROM glaa_t
             WHERE glaaent = g_enterprise
               AND glaacomp = g_apga_m.apgacomp
               AND glaa014 = 'Y'
            IF NOT cl_null(g_apgb_d[l_ac].apgb001) THEN
               IF g_apgb_d[l_ac].apgb001 != g_apgb_d_o.apgb001 OR cl_null(g_apgb_d_o.apgb001) THEN                                        #160822-00008#5 add
               #IF p_cmd = 'a' OR (p_cmd = 'u' AND (g_apgb_d[l_ac].apgb001 != g_apgb_d_t.apgb001 OR g_apgb_d_t.apgb001 IS NULL )) THEN    #160822-00008#5 mark
                  CALL aapt510_apgb001_002_chk(g_apgb_d[l_ac].apgborga,g_apga_m.apga004,g_apgb_d[l_ac].apgb001,g_apgb_d[l_ac].apgb002)
                     RETURNING g_sub_success,g_errno
                  IF NOT g_sub_success THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = g_errno
                     LET g_errparam.extend = ''
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                     #LET g_apgb_d[l_ac].apgb001 = g_apgb_d_t.apgb001 #160822-00008#5 mark
                     #LET g_apgb_d[l_ac].apgb002 = g_apgb_d_t.apgb002 #160822-00008#5 mark
                     LET g_apgb_d[l_ac].apgb001 = g_apgb_d_o.apgb001  #160822-00008#5 add
                     LET g_apgb_d[l_ac].apgb002 = g_apgb_d_o.apgb002  #160822-00008#5 add
                     CALL aapt510_set_no_entry_b(p_cmd)
                     NEXT FIELD CURRENT
                  END IF
                  
                  IF NOT cl_null(g_apgb_d[l_ac].apgb002)THEN
                     #160428-00001#1 ---s---
                     #CALL aapt510_apgb001_002_carry(l_ac)
                      CALL aapt510_apgb001_002_carry(l_ac) RETURNING g_sub_success,g_errno
                      IF NOT g_sub_success THEN
                         INITIALIZE g_errparam TO NULL
                         LET g_errparam.code = g_errno
                         LET g_errparam.extend = ''
                         LET g_errparam.popup = TRUE
                         CALL cl_err()
                         #LET g_apgb_d[l_ac].apgb001 = g_apgb_d_t.apgb001 #160822-00008#5 mark
                         #LET g_apgb_d[l_ac].apgb002 = g_apgb_d_t.apgb002 #160822-00008#5 mark
                         LET g_apgb_d[l_ac].apgb001 = g_apgb_d_o.apgb001  #160822-00008#5 add
                         LET g_apgb_d[l_ac].apgb002 = g_apgb_d_o.apgb002  #160822-00008#5 add
                         CALL aapt510_set_no_entry_b(p_cmd)
                         NEXT FIELD CURRENT
                     END IF                      
                     #160428-00001#1 ---e---
                  END IF
               END IF
            END IF
            CALL aapt510_set_no_entry_b(p_cmd)
            
            LET g_apgb_d_o.* = g_apgb_d[l_ac].*  #160822-00008#5 add
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apgb001
            #add-point:ON CHANGE apgb001 name="input.g.page1.apgb001"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apgb002
            #add-point:BEFORE FIELD apgb002 name="input.b.page1.apgb002"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apgb002
            
            #add-point:AFTER FIELD apgb002 name="input.a.page1.apgb002"
            LET l_ld = NULL
            SELECT glaald INTO l_ld
              FROM glaa_t
             WHERE glaaent = g_enterprise
               AND glaacomp = g_apga_m.apgacomp
               AND glaa014 = 'Y'
            IF NOT cl_null(g_apgb_d[l_ac].apgb002) THEN
               IF g_apgb_d[l_ac].apgb002 != g_apgb_d_o.apgb002 OR cl_null(g_apgb_d_o.apgb002) THEN                                        #160822-00008#5 add
               #IF p_cmd = 'a' OR (p_cmd = 'u' AND (g_apgb_d[l_ac].apgb002 != g_apgb_d_t.apgb002 OR g_apgb_d_t.apgb002 IS NULL )) THEN    #160822-00008#5 mark
                  CALL aapt510_apgb001_002_chk(g_apgb_d[l_ac].apgborga,g_apga_m.apga004,g_apgb_d[l_ac].apgb001,g_apgb_d[l_ac].apgb002)
                     RETURNING g_sub_success,g_errno
                  IF NOT g_sub_success THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = g_errno
                     LET g_errparam.extend = ''
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                     #LET g_apgb_d[l_ac].apgb002 = g_apgb_d_t.apgb002 #160822-00008#5 mark
                     #LET g_apgb_d[l_ac].apgb001 = g_apgb_d_t.apgb001 #160822-00008#5 mark
                     LET g_apgb_d[l_ac].apgb002 = g_apgb_d_o.apgb002  #160822-00008#5 add
                     LET g_apgb_d[l_ac].apgb001 = g_apgb_d_o.apgb001  #160822-00008#5 add
                     CALL aapt510_set_no_entry(p_cmd)
                     NEXT FIELD CURRENT
                  END IF
                  IF NOT cl_null(g_apgb_d[l_ac].apgb001)THEN
                     #160428-00001#1 ---s---
                     #CALL aapt510_apgb001_002_carry(l_ac)
                     CALL aapt510_apgb001_002_carry(l_ac) RETURNING g_sub_success,g_errno
                     IF NOT g_sub_success THEN
                        INITIALIZE g_errparam TO NULL
                        LET g_errparam.code = g_errno
                        LET g_errparam.extend = ''
                        LET g_errparam.popup = TRUE
                        CALL cl_err()
                        #LET g_apgb_d[l_ac].apgb001 = g_apgb_d_t.apgb001 #160822-00008#5 mark
                        #LET g_apgb_d[l_ac].apgb002 = g_apgb_d_t.apgb002 #160822-00008#5 mark
                        LET g_apgb_d[l_ac].apgb001 = g_apgb_d_o.apgb001  #160822-00008#5 add
                        LET g_apgb_d[l_ac].apgb002 = g_apgb_d_o.apgb002  #160822-00008#5 add
                        CALL aapt510_set_no_entry_b(p_cmd)
                        NEXT FIELD CURRENT
                     END IF    
                     #160428-00001#1 ---e---
                  END IF
               END IF
            END IF
            CALL aapt510_set_no_entry(p_cmd)
            
            LET g_apgb_d_o.* = g_apgb_d[l_ac].*  #160822-00008#5 add
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apgb002
            #add-point:ON CHANGE apgb002 name="input.g.page1.apgb002"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apgb003
            #add-point:BEFORE FIELD apgb003 name="input.b.page1.apgb003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apgb003
            
            #add-point:AFTER FIELD apgb003 name="input.a.page1.apgb003"
            #albireo 160815-----s
            IF NOT cl_null(g_apgb_d[l_ac].apgb003)THEN
               IF cl_null(g_apgb_d_t.apgb003) OR (g_apgb_d[l_ac].apgb003 <> g_apgb_d_t.apgb003)THEN
                  INITIALIZE g_chkparam.* TO NULL
                  LET g_errshow = TRUE #是否開窗
                  LET g_chkparam.arg1 = g_apgb_d[l_ac].apgb003              
                  #LET g_chkparam.err_str[1] ="aim-00002:sub-01302|aimm200|",cl_get_progname("aimm200",g_lang,"2"),"|:EXEPROGaimm200" #161115-00042#5 mark                  
                  #呼叫檢查存在並帶值的library
                  IF cl_chk_exist("v_imaa001") THEN
                  #IF cl_chk_exist("v_imaf001_14") THEN  #161115-00042#5 mark
                     #161115-00042#5-add(s)
                     LET g_chkparam.arg1 = g_apga_m.apgacomp
                     LET g_chkparam.arg2 = g_apgb_d[l_ac].apgb003
                     IF cl_chk_exist("v_imaf001_3") THEN
                     #161115-00042#5-add(e)
                        #檢查成功時後續處理
                     ELSE
                        #檢查失敗時後續處理
                        LET g_apgb_d[l_ac].apgb003 = g_apgb_d_t.apgb003
                        #160824-00049#1-----s
                        CALL s_desc_get_item_desc(g_apgb_d[l_ac].apgb003) RETURNING l_imaal003,l_imaal004
                        LET g_apgb_d[l_ac].apgb004 = l_imaal003,l_imaal004
                        DISPLAY BY NAME g_apgb_d[l_ac].apgb004
                        #160824-00049#1-----e
                        NEXT FIELD CURRENT
                     END IF
                  ELSE
                     #檢查失敗時後續處理
                     LET g_apgb_d[l_ac].apgb003 = g_apgb_d_t.apgb003
                     #160824-00049#1-----s
                     CALL s_desc_get_item_desc(g_apgb_d[l_ac].apgb003) RETURNING l_imaal003,l_imaal004
                     LET g_apgb_d[l_ac].apgb004 = l_imaal003,l_imaal004
                     DISPLAY BY NAME g_apgb_d[l_ac].apgb004
                     #160824-00049#1-----e
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF
            #albireo 160815-----e
            #albireo 160624-----s
            CALL s_desc_get_item_desc(g_apgb_d[l_ac].apgb003) RETURNING l_imaal003,l_imaal004
            LET g_apgb_d[l_ac].apgb004 = l_imaal003,l_imaal004
            DISPLAY BY NAME g_apgb_d[l_ac].apgb004
            #albireo 160624-----e
           
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apgb003
            #add-point:ON CHANGE apgb003 name="input.g.page1.apgb003"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apgb004
            #add-point:BEFORE FIELD apgb004 name="input.b.page1.apgb004"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apgb004
            
            #add-point:AFTER FIELD apgb004 name="input.a.page1.apgb004"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apgb004
            #add-point:ON CHANGE apgb004 name="input.g.page1.apgb004"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apgb005
            #add-point:BEFORE FIELD apgb005 name="input.b.page1.apgb005"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apgb005
            
            #add-point:AFTER FIELD apgb005 name="input.a.page1.apgb005"
             IF NOT cl_null(g_apgb_d[l_ac].apgb005) THEN
                IF p_cmd = 'a' OR (p_cmd = 'u' AND (g_apgb_d[l_ac].apgb005 != g_apgb_d_t.apgb005 OR g_apgb_d_t.apgb005 IS NULL )) THEN                  
                   INITIALIZE g_chkparam.* TO NULL
             
                   #設定g_chkparam.*的參數
                   LET g_chkparam.arg1 = g_apgb_d[l_ac].apgb003
                   LET g_chkparam.arg2 = g_apgb_d[l_ac].apgb005
                    
                   #呼叫檢查存在並帶值的library
                   IF NOT cl_chk_exist("v_imao002") THEN
                      LET g_apgb_d[l_ac].apgb005 = g_apgb_d_t.apgb005
                      DISPLAY BY NAME g_apgb_d[l_ac].apgb005
                      NEXT FIELD apgb005
                   END IF
                   
                   #160824-00049#1-----s
                   IF NOT cl_null(g_apgb_d[l_ac].apgb005) AND NOT cl_null(g_apgb_d[l_ac].apgb008)THEN
                      CALL s_aooi250_take_decimals(g_apgb_d[l_ac].apgb005,g_apgb_d[l_ac].apgb008)
                         RETURNING g_sub_success,g_apgb_d[l_ac].apgb008
                      IF cl_null(g_apgb_d_o.apgb008) OR (g_apgb_d_o.apgb008 <> g_apgb_d[l_ac].apgb008)THEN   
                         #原幣含稅金額
                         LET g_apgb_d[l_ac].apgb105 = g_apgb_d[l_ac].apgb008 * g_apgb_d[l_ac].apgb009
                         #取位(原幣)
                         CALL s_curr_round_ld('1',l_ld,g_apga_m.apga100,g_apgb_d[l_ac].apgb105,2) RETURNING g_sub_success,g_errno,g_apgb_d[l_ac].apgb105                         
                         #本幣含稅金額
                         LET g_apgb_d[l_ac].apgb115 = g_apgb_d[l_ac].apgb105 * g_apgb_d[l_ac].apgb101
                         #取位(本幣)
                         CALL s_curr_round_ld('1',l_ld,l_glaa001,g_apgb_d[l_ac].apgb115,2) RETURNING g_sub_success,g_errno,g_apgb_d[l_ac].apgb115                           
                         DISPLAY BY NAME g_apgb_d[l_ac].apgb105,g_apgb_d[l_ac].apgb008,g_apgb_d[l_ac].apgb115                         
                      END IF
                   END IF
                   #160824-00049#1-----e
                END IF
             END IF
             DISPLAY BY NAME g_apgb_d[l_ac].apgb005
             CALL aapt510_to_o_b1(l_ac)    #160824-00049#1
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apgb005
            #add-point:ON CHANGE apgb005 name="input.g.page1.apgb005"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apgb008
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_apgb_d[l_ac].apgb008,"0","0","","","azz-00079",1) THEN
               NEXT FIELD apgb008
            END IF 
 
 
 
            #add-point:AFTER FIELD apgb008 name="input.a.page1.apgb008"
            LET l_ld = NULL   LET l_glaa001 = NULL
            SELECT glaald ,glaa001
              INTO l_ld ,l_glaa001
              FROM glaa_t
             WHERE glaaent = g_enterprise
               AND glaacomp = g_apga_m.apgacomp
               AND glaa014  = 'Y'
            IF NOT cl_null(g_apgb_d[l_ac].apgb008)THEN
               IF cl_null(g_apgb_d_o.apgb008) OR (g_apgb_d_o.apgb008 <> g_apgb_d[l_ac].apgb008)THEN
                  #160824-00049#1-----s
                  IF NOT cl_null(g_apgb_d[l_ac].apgb005) AND NOT cl_null(g_apgb_d[l_ac].apgb008)THEN
                     CALL s_aooi250_take_decimals(g_apgb_d[l_ac].apgb005,g_apgb_d[l_ac].apgb008)
                        RETURNING g_sub_success,g_apgb_d[l_ac].apgb008
                  END IF
                  #160824-00049#1-----e
                  IF NOT cl_null(g_apgb_d[l_ac].apgb001) AND NOT cl_null(g_apgb_d[l_ac].apgb002)THEN
                     LET l_pmdn007 = NULL    LET l_apgb008 =NULL
                     SELECT pmdn007 INTO l_pmdn007 FROM pmdn_t
                      WHERE pmdnent = g_enterprise
                        AND pmdndocno = g_apgb_d[l_ac].apgb001
                        AND pmdnseq   = g_apgb_d[l_ac].apgb002
                     IF cl_null(l_pmdn007)THEN LET l_pmdn007 = 0 END IF
                     
                     SELECT SUM(apgb008) INTO l_apgb008 FROM apgb_t,apga_t
                      WHERE apgbent = g_enterprise
                        AND apgbdocno <> g_apgb_m.apgbdocno
                        AND apgbcomp <> g_apgb_m.apgbcomp
                        AND apgb001 = g_apgb_d[l_ac].apgb001
                        AND apgb002 = g_apgb_d[l_ac].apgb002
                        AND apgbent = apgaent
                        AND apgbdocno = apgadocno
                        AND apgbcomp = apgacomp
                        AND apgastus <> 'X'
                     
                     IF cl_null(l_apgb008)THEN LET l_apgb008 = 0 END IF
                     
                     IF (l_pmdn007 - l_apgb008 - g_apgb_d[l_ac].apgb008) < 0 THEN
                        INITIALIZE g_errparam.* TO NULL
                        LET g_errparam.code = ''
                        LET g_errparam.popup = TRUE
                        LET g_errparam.extend = ''
                        CALL cl_err()
                        LET g_apgb_d[l_ac].apgb008 = g_apgb_d_o.apgb008
                        DISPLAY BY NAME g_apgb_d[l_ac].apgb008
                        NEXT FIELD apgb008
                     END IF
                  END IF  
                  
                  #原幣含稅金額
                  LET g_apgb_d[l_ac].apgb105 = g_apgb_d[l_ac].apgb008 * g_apgb_d[l_ac].apgb009
                  #取位(原幣)
                  CALL s_curr_round_ld('1',l_ld,g_apga_m.apga100,g_apgb_d[l_ac].apgb105,2) RETURNING g_sub_success,g_errno,g_apgb_d[l_ac].apgb105
                  
                  #本幣含稅金額
                  #LET g_apgb_d[l_ac].apgb115 = g_apgb_d[l_ac].apgb105 * g_apga_m.apga101         #160824-00049#1
                  LET g_apgb_d[l_ac].apgb115 = g_apgb_d[l_ac].apgb105 * g_apgb_d[l_ac].apgb101    #160824-00049#1
                  #取位(本幣)
                  CALL s_curr_round_ld('1',l_ld,l_glaa001,g_apgb_d[l_ac].apgb115,2) RETURNING g_sub_success,g_errno,g_apgb_d[l_ac].apgb115
                    
                  DISPLAY BY NAME g_apgb_d[l_ac].apgb105,g_apgb_d[l_ac].apgb008,g_apgb_d[l_ac].apgb115                    
               END IF
            END IF
            
            CALL aapt510_to_o_b1(l_ac)
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apgb008
            #add-point:BEFORE FIELD apgb008 name="input.b.page1.apgb008"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apgb008
            #add-point:ON CHANGE apgb008 name="input.g.page1.apgb008"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apgb006
            #add-point:BEFORE FIELD apgb006 name="input.b.page1.apgb006"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apgb006
            
            #add-point:AFTER FIELD apgb006 name="input.a.page1.apgb006"
            IF NOT cl_null(g_apgb_d[l_ac].apgb006) THEN
               IF g_apgb_d[l_ac].apgb006 != g_apgb_d_o.apgb006 OR cl_null(g_apgb_d_o.apgb006) THEN                                        #160822-00008#5 add
               #IF p_cmd = 'a' OR (p_cmd = 'u' AND ((g_apgb_d[l_ac].apgb006 != g_apgb_d_t.apgb006 OR g_apgb_d_t.apgb006 IS NULL ) )) THEN #160822-00008#5 mark
                  CALL s_tax_chk(g_apga_m.apgacomp,g_apgb_d[l_ac].apgb006) RETURNING g_sub_success,l_oodb004,l_apca013,l_apca012,l_oodb011
                  IF NOT g_sub_success THEN
                     #LET g_apgb_d[l_ac].apgb006 = g_apgb_d_t.apgb006 #160822-00008#5 mark
                     LET g_apgb_d[l_ac].apgb006 = g_apgb_d_o.apgb006  #160822-00008#5 add
                     NEXT FIELD CURRENT
                  END IF
                  LET g_apgb_d[l_ac].apgb007 = ''                     #160822-00008#5 add
                  LET g_apgb_d[l_ac].apgb007 = l_apca013
                  DISPLAY BY NAME g_apgb_d[l_ac].apgb006,g_apgb_d[l_ac].apgb007
               END IF
            END IF
            DISPLAY BY NAME g_apgb_d[l_ac].apgb006,g_apgb_d[l_ac].apgb007
            LET g_apgb_d_o.* = g_apgb_d[l_ac].*                       #160822-00008#5 add
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apgb006
            #add-point:ON CHANGE apgb006 name="input.g.page1.apgb006"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apgb007
            #add-point:BEFORE FIELD apgb007 name="input.b.page1.apgb007"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apgb007
            
            #add-point:AFTER FIELD apgb007 name="input.a.page1.apgb007"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apgb007
            #add-point:ON CHANGE apgb007 name="input.g.page1.apgb007"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apgb100
            #add-point:BEFORE FIELD apgb100 name="input.b.page1.apgb100"
            CALL aapt510_set_entry_b(p_cmd)   #albireo 160614 add
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apgb100
            
            #add-point:AFTER FIELD apgb100 name="input.a.page1.apgb100"
            #160428-00001#1---s---
            #幣別
            LET l_ld = NULL
            LET l_glaa001 = NULL
            SELECT glaald,glaa001 INTO l_ld,l_glaa001 FROM glaa_t
             WHERE glaaent = g_enterprise
               AND glaacomp = g_apga_m.apgacomp
               AND glaa014 = 'Y'
            IF NOT cl_null(g_apgb_d[l_ac].apgb100) THEN
               IF g_apgb_d[l_ac].apgb100 != g_apgb_d_o.apgb100 OR cl_null(g_apgb_d_o.apgb100) THEN                                        #160822-00008#5 add
               #IF p_cmd = 'a' OR (p_cmd = 'u' AND ((g_apgb_d[l_ac].apgb100 != g_apgb_d_t.apgb100 OR g_apgb_d_t.apgb100 IS NULL ) )) THEN #160822-00008#5 mark
                  CALL s_aap_ooaj001_chk(l_ld,g_apgb_d[l_ac].apgb100) RETURNING g_sub_success,g_errno
                  IF NOT g_sub_success THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = g_errno
                     LET g_errparam.extend = ''
                     LET g_errparam.replace[1] = 'aooi150'
                     LET g_errparam.replace[2] = cl_get_progname('aooi150',g_lang,"2")
                     LET g_errparam.exeprog = 'aooi150'
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                     #LET g_apgb_d[l_ac].apgb100 = g_apgb_d_t.apgb100  #160822-00008#5 mark
                     LET g_apgb_d[l_ac].apgb100 = g_apgb_d_o.apgb100   #160822-00008#5 add
                     NEXT FIELD CURRENT
                  END IF
                  CALL aapt510_curry_chk(g_apgb_d[l_ac].apgb100)RETURNING g_sub_success,g_errno
                  IF NOT g_sub_success THEN                    
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = g_errno
                     LET g_errparam.extend = ''
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                     #LET g_apgb_d[l_ac].apgb100 = g_apgb_d_t.apgb100 #160822-00008#5 mark
                     LET g_apgb_d[l_ac].apgb100 = g_apgb_d_o.apgb100  #160822-00008#5 add
                     NEXT FIELD CURRENT
                  END IF
                  
                  IF NOT cl_null(g_apga_m.apga003) AND NOT cl_null(g_apga_m.apga004) THEN
                     IF g_apgb_d[l_ac].apgb100 <> g_apga_m.apga100 THEN   #160824-00049#1
                        LET lc_param.apca004 = g_apga_m.apga004
                        LET ls_js = util.JSON.stringify(lc_param)
                        LET g_apgb_d[l_ac].apgb101 = ''                  #160822-00008#5 add
                        CALL s_fin_get_curr_rate(g_apga_m.apgacomp,l_ld,g_apga_m.apga003,g_apgb_d[l_ac].apgb100,ls_js)
                             RETURNING g_apgb_d[l_ac].apgb101,l_dummy2,l_dummy3    
                     #160824-00049#1-----s
                     ELSE
                        LET g_apgb_d[l_ac].apgb101 = g_apga_m.apga101                 
                     END IF   
                     #160824-00049#1-----e
                     #計算新匯率的結果
                     LET g_apgb_d[l_ac].apgb115 = 0                   #160822-00008#5 add
                     LET g_apgb_d[l_ac].apgb115 = g_apgb_d[l_ac].apgb101 * g_apgb_d[l_ac].apgb105
                     CALL s_curr_round_ld('1',l_ld,l_glaa001,g_apgb_d[l_ac].apgb115,2) RETURNING g_sub_success,g_errno,g_apgb_d[l_ac].apgb115   #160824-00049#1
                  END IF
               END IF
            END IF
            #160428-00001#1---e---
            CALL aapt510_set_no_entry_b(p_cmd)   #albireo 160614 add
            LET g_apgb_d_o.* = g_apgb_d[l_ac].*  #160822-00008#5 add
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apgb100
            #add-point:ON CHANGE apgb100 name="input.g.page1.apgb100"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apgb101
            #add-point:BEFORE FIELD apgb101 name="input.b.page1.apgb101"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apgb101
            
            #add-point:AFTER FIELD apgb101 name="input.a.page1.apgb101"
            #albireo 160815-----s
            LET l_ld = NULL   LET l_glaa001 = NULL
            SELECT glaald ,glaa001
              INTO l_ld ,l_glaa001
              FROM glaa_t
             WHERE glaaent = g_enterprise
               AND glaacomp = g_apga_m.apgacomp
               AND glaa014  = 'Y'
          
            IF NOT cl_null(g_apgb_d[l_ac].apgb101)THEN
               IF cl_null(g_apgb_d_o.apgb101) OR (g_apgb_d[l_ac].apgb101 <> g_apgb_d_o.apgb101)THEN
            #albireo 160815-----e
                  #160824-00049#1-----s
                  #匯率取位
                  CALL s_curr_round_ld('1',l_ld,g_apgb_d[l_ac].apgb100,g_apgb_d[l_ac].apgb101,3) RETURNING g_sub_success,g_errno,g_apgb_d[l_ac].apgb101
                  #160824-00049#1-----e
                  #160428-00001#1---s---
                  IF NOT cl_null(g_apgb_d[l_ac].apgb101) AND NOT cl_null(g_apgb_d[l_ac].apgb105) THEN          
                    #計算新匯率的結果
                     LET g_apgb_d[l_ac].apgb115 = '' #160822-00008#5 add
                     LET g_apgb_d[l_ac].apgb115 = g_apgb_d[l_ac].apgb101 * g_apgb_d[l_ac].apgb105
                     #albireo 160815 本幣取位-----s
                     #取位(本幣)
                     CALL s_curr_round_ld('1',l_ld,l_glaa001,g_apgb_d[l_ac].apgb115,2) RETURNING g_sub_success,g_errno,g_apgb_d[l_ac].apgb115
                     #albireo 160815 本幣取位-----e
                  END IF           
                  #160428-00001#1---e---
            #albireo 160815-----s
               END IF
            END IF
            CALL aapt510_to_o_b1(l_ac)   
            #albireo 160815-----e
            LET g_apgb_d_o.* = g_apgb_d[l_ac].*  #160822-00008#5 add
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apgb101
            #add-point:ON CHANGE apgb101 name="input.g.page1.apgb101"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apgb009
            #add-point:BEFORE FIELD apgb009 name="input.b.page1.apgb009"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apgb009
            
            #add-point:AFTER FIELD apgb009 name="input.a.page1.apgb009"
            LET l_ld = NULL   LET l_glaa001 = NULL
            SELECT glaald ,glaa001
              INTO l_ld ,l_glaa001
              FROM glaa_t
             WHERE glaaent = g_enterprise
               AND glaacomp = g_apga_m.apgacomp
               AND glaa014  = 'Y'
            IF NOT cl_null(g_apgb_d[l_ac].apgb009)THEN
               IF cl_null(g_apgb_d_o.apgb009) OR (g_apgb_d_o.apgb009 <> g_apgb_d[l_ac].apgb009)THEN
                  CALL s_curr_round_ld('1',l_ld,g_apgb_d[l_ac].apgb100,g_apgb_d[l_ac].apgb009,1) RETURNING g_sub_success,g_errno,g_apgb_d[l_ac].apgb009   #160824-00049#1
                  #原幣含稅金額
                  LET g_apgb_d[l_ac].apgb105 = g_apgb_d[l_ac].apgb008 * g_apgb_d[l_ac].apgb009
                  #取位(原幣)
                  #CALL s_curr_round_ld('1',l_ld,g_apga_m.apga100,g_apgb_d[l_ac].apgb105,2) RETURNING g_sub_success,g_errno,g_apgb_d[l_ac].apgb105       #160428-00001#1
                  CALL s_curr_round_ld('1',l_ld,g_apgb_d[l_ac].apgb100,g_apgb_d[l_ac].apgb105,2) RETURNING g_sub_success,g_errno,g_apgb_d[l_ac].apgb105 #160428-00001#1
                  
                  #本幣含稅金額
                  #LET g_apgb_d[l_ac].apgb115 = g_apgb_d[l_ac].apgb105 * g_apga_m.apga101       #160428-00001#1 
                  LET g_apgb_d[l_ac].apgb115 = g_apgb_d[l_ac].apgb105 * g_apgb_d[l_ac].apgb101  #160428-00001#1
                  #取位(本幣)
                  CALL s_curr_round_ld('1',l_ld,l_glaa001,g_apgb_d[l_ac].apgb115,2) RETURNING g_sub_success,g_errno,g_apgb_d[l_ac].apgb115
                    
                  DISPLAY BY NAME g_apgb_d[l_ac].apgb105,g_apgb_d[l_ac].apgb008,g_apgb_d[l_ac].apgb115                    
               END IF
            END IF
            CALL aapt510_to_o_b1(l_ac)
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apgb009
            #add-point:ON CHANGE apgb009 name="input.g.page1.apgb009"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apgb105
            #add-point:BEFORE FIELD apgb105 name="input.b.page1.apgb105"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apgb105
            
            #add-point:AFTER FIELD apgb105 name="input.a.page1.apgb105"
            LET l_ld = NULL   LET l_glaa001 = NULL
            SELECT glaald ,glaa001
              INTO l_ld ,l_glaa001
              FROM glaa_t
             WHERE glaaent = g_enterprise
               AND glaacomp = g_apga_m.apgacomp
               AND glaa014  = 'Y'
            IF NOT cl_null(g_apgb_d[l_ac].apgb105)THEN
               IF cl_null(g_apgb_d_o.apgb105) OR (g_apgb_d_o.apgb105 <> g_apgb_d[l_ac].apgb105)THEN
                  CALL s_curr_round_ld('1',l_ld,g_apgb_d[l_ac].apgb100,g_apgb_d[l_ac].apgb105,2) RETURNING g_sub_success,g_errno,g_apgb_d[l_ac].apgb105   #160824-00049#1
                  #本幣含稅金額
                  #LET g_apgb_d[l_ac].apgb115 = g_apgb_d[l_ac].apgb105 * g_apga_m.apga101
                  LET g_apgb_d[l_ac].apgb115 = g_apgb_d[l_ac].apgb105 * g_apgb_d[l_ac].apgb101 ##160428-00001#1
                  #取位(本幣)
                  CALL s_curr_round_ld('1',l_ld,l_glaa001,g_apgb_d[l_ac].apgb115,2) RETURNING g_sub_success,g_errno,g_apgb_d[l_ac].apgb115
                    
                  DISPLAY BY NAME g_apgb_d[l_ac].apgb105,g_apgb_d[l_ac].apgb008,g_apgb_d[l_ac].apgb115                    
               END IF
            END IF
            CALL aapt510_to_o_b1(l_ac)
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apgb105
            #add-point:ON CHANGE apgb105 name="input.g.page1.apgb105"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apgb115
            #add-point:BEFORE FIELD apgb115 name="input.b.page1.apgb115"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apgb115
            
            #add-point:AFTER FIELD apgb115 name="input.a.page1.apgb115"
            #160824-00049#1-----s
            LET l_ld = NULL   LET l_glaa001 = NULL
            SELECT glaald ,glaa001
              INTO l_ld ,l_glaa001
              FROM glaa_t
             WHERE glaaent = g_enterprise
               AND glaacomp = g_apga_m.apgacomp
               AND glaa014  = 'Y'
            IF NOT cl_null(g_apgb_d[l_ac].apgb115)THEN
               IF cl_null(g_apgb_d_o.apgb115) OR (g_apgb_d_o.apgb115 <> g_apgb_d[l_ac].apgb115)THEN
                  CALL s_curr_round_ld('1',l_ld,l_glaa001,g_apgb_d[l_ac].apgb115,2) RETURNING g_sub_success,g_errno,g_apgb_d[l_ac].apgb115
               END IF
            END IF
            #160824-00049#1-----e
            CALL aapt510_to_o_b1(l_ac)
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apgb115
            #add-point:ON CHANGE apgb115 name="input.g.page1.apgb115"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apgb010
            #add-point:BEFORE FIELD apgb010 name="input.b.page1.apgb010"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apgb010
            
            #add-point:AFTER FIELD apgb010 name="input.a.page1.apgb010"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apgb010
            #add-point:ON CHANGE apgb010 name="input.g.page1.apgb010"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apgb011
            #add-point:BEFORE FIELD apgb011 name="input.b.page1.apgb011"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apgb011
            
            #add-point:AFTER FIELD apgb011 name="input.a.page1.apgb011"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apgb011
            #add-point:ON CHANGE apgb011 name="input.g.page1.apgb011"
            
            #END add-point 
 
 
 
                  #Ctrlp:input.c.page1.apgbseq
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apgbseq
            #add-point:ON ACTION controlp INFIELD apgbseq name="input.c.page1.apgbseq"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.apgborga
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apgborga
            #add-point:ON ACTION controlp INFIELD apgborga name="input.c.page1.apgborga"
            #來源組織
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
		      LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_apgb_d[l_ac].apgborga
            LET g_qryparam.where    = "ooef001 IN ",g_wc_apgborga, 
                                      " AND ooef017 ='",g_apga_m.apgacomp,"' ",
                                      " AND ooef201 = 'Y'"   #161006-00005#5   add
            CALL q_ooef001()                                 
            LET g_apgb_d[l_ac].apgborga = g_qryparam.return1       
            LET g_apgb_d[l_ac].apgborga_desc = s_desc_get_department_desc(g_apgb_d[l_ac].apgborga)
            DISPLAY BY NAME g_apgb_d[l_ac].apgborga,g_apgb_d[l_ac].apgborga_desc
            NEXT FIELD apgborga
            #END add-point
 
 
         #Ctrlp:input.c.page1.apgb001
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apgb001
            #add-point:ON ACTION controlp INFIELD apgb001 name="input.c.page1.apgb001"
            LET l_count = 0
            #項次存在修改    項次不存在INSERT
            SELECT COUNT(*) INTO l_count FROM apgb_t
             WHERE apgbent = g_enterprise
               AND apgbcomp = g_apga_m.apgacomp
               AND apgbdocno = g_apga_m.apgadocno
               AND apgbseq = g_apgb_d[l_ac].apgbseq
            IF cl_null(l_count)THEN LET l_count = 0 END IF
            IF l_count > 0 THEN
               #採購單號+項次
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'i'
		         LET g_qryparam.reqry = FALSE
               LET g_qryparam.default1 = g_apgb_d[l_ac].apgb001
               LET g_qryparam.default2 = g_apgb_d[l_ac].apgb002
               LET g_qryparam.where    = " pmdl004 = '",g_apga_m.apga004,"' AND pmdosite = '",g_apgb_d[l_ac].apgborga,"' "
               IF g_apga_m.apga100 <> g_apga_m.glaa001 THEN
                  LET g_qryparam.where = g_qryparam.where, " AND pmdl015 IN ('",g_apga_m.apga100,"','",g_apga_m.glaa001,"') " 
               END IF
               
               LET g_qryparam.where = g_qryparam.where,
                   " AND NOT EXISTS(SELECT 1 FROM apgb_t,apga_t WHERE apgbent = apgaent AND apgbcomp = apgacomp AND apgadocno = apgbdocno ",
                                    " AND apgastus <> 'X' AND apgb001 = '",g_apgb_d[l_ac].apgb001,"' AND apgb002 = '",g_apgb_d[l_ac].apgb002,"' ",
                   ")"
               CALL q_pmdldocno_7()                                 
               LET g_apgb_d[l_ac].apgb001 = g_qryparam.return1       
               LET g_apgb_d[l_ac].apgb002 = g_qryparam.return2
               DISPLAY BY NAME g_apgb_d[l_ac].apgb001,g_apgb_d[l_ac].apgb002
               NEXT FIELD apgb001
            ELSE
               #採購單號+項次
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'm'
		         LET g_qryparam.reqry = FALSE
               LET g_qryparam.where    = "pmdl004 = '",g_apga_m.apga004,"' AND pmdosite = '",g_apgb_d[l_ac].apgborga,"' "
               #160428-00001#1---s---
               IF g_apga_m.apga100 <> g_apga_m.glaa001 THEN
                  LET g_qryparam.where = g_qryparam.where, " AND pmdl015 IN ('",g_apga_m.apga100,"','",g_apga_m.glaa001,"') " 
               END IF
               #160428-00001#1---e---
               LET g_qryparam.where = g_qryparam.where,
                   " AND NOT EXISTS(SELECT 1 FROM apgb_t,apga_t WHERE apgbent = apgaent AND apgbcomp = apgacomp AND apgadocno = apgbdocno ",
                                    " AND apgastus <> 'X' AND apgb001 = '",g_apgb_d[l_ac].apgb001,"' AND apgb002 = '",g_apgb_d[l_ac].apgb002,"' ",
                   ")"
               CALL q_pmdldocno_7()        
               IF g_qryparam.str_array.getLength() = 0 THEN
                  NEXT FIELD apgb001
               END IF               
               CALL s_aapt510_get_controlp_wc(g_qryparam.str_array) RETURNING l_wc
               #160428-00001#1---s--- 單身幣別+單頭幣別不可大於兩種
               #IF g_apga_m.apga100 = g_apga_m.glaa001 THEN    #160622-00006#1 mark
               IF g_apga_m.apga100 <> g_apga_m.glaa001 THEN    #160622-00006#1
                  LET l_sql = " SELECT COUNT(DISTINCT pmdl015) FROM pmdl_t,pmdn_t         ",
                              "  WHERE pmdlent = pmdnent AND pmdlent = '",g_enterprise,"' ",
                              "    AND pmdldocno = pmdndocno   ",
                              "    AND ", l_wc 
                   IF cl_null(l_cnt) THEN LET l_cnt = 0 END IF
                   PREPARE aapt510_apgb001_prep02 FROM l_sql
                   EXECUTE aapt510_apgb001_prep02 INTO l_cnt
                   IF l_cnt > 2 THEN #幣別超過兩種
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = 'aap-00550'
                     LET g_errparam.extend = ''
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                     NEXT FIELD apgb001
                   END IF
               END　IF                                                             
               CALL aapt510_auto_ins_b1(l_wc)RETURNING g_sub_success
               IF NOT g_sub_success THEN
                  #CALL cl_err_collect_show()
                  CALL s_transaction_end('N','0')
               ELSE
                  #CALL cl_err_collect_show()
                  CALL s_transaction_end('Y','0')
               END IF
               LET l_autoins = TRUE
               LET p_cmd = 'u'
               LET g_aw = 's_detail1'
               CALL aapt510_show()
               EXIT DIALOG
               
            END IF
            #END add-point
 
 
         #Ctrlp:input.c.page1.apgb002
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apgb002
            #add-point:ON ACTION controlp INFIELD apgb002 name="input.c.page1.apgb002"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.apgb003
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apgb003
            #add-point:ON ACTION controlp INFIELD apgb003 name="input.c.page1.apgb003"
            #貨號
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            #LET g_qryparam.default1 = g_apgb_d[l_ac].apgb003 #161115-00042#5 mark
            #CALL q_imaf001_15()                              #161115-00042#5 mark
            #161115-00042#5-add(s)
            LET g_qryparam.arg1 = g_apga_m.apgacomp
            CALL q_imaf001_21()
            #161115-00042#5-add(e)  
            LET g_apgb_d[l_ac].apgb003 = g_qryparam.return1 
            DISPLAY BY NAME g_apgb_d[l_ac].apgb003
            CALL s_desc_get_item_desc(g_apgb_d[l_ac].apgb003) RETURNING l_imaal003,l_imaal004
            LET g_apgb_d[l_ac].apgb004 = l_imaal003,l_imaal004
            DISPLAY BY NAME g_apgb_d[l_ac].apgb004
            NEXT FIELD apgb003
            #END add-point
 
 
         #Ctrlp:input.c.page1.apgb004
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apgb004
            #add-point:ON ACTION controlp INFIELD apgb004 name="input.c.page1.apgb004"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.apgb005
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apgb005
            #add-point:ON ACTION controlp INFIELD apgb005 name="input.c.page1.apgb005"
            #單位
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_apgb_d[l_ac].apgb005
            LET g_qryparam.arg1 = g_apgb_d[l_ac].apgb003
            CALL q_imao002()                            
            LET g_apgb_d[l_ac].apgb005 = g_qryparam.return1       
            DISPLAY BY NAME g_apgb_d[l_ac].apgb005
            NEXT FIELD apgb005
            #END add-point
 
 
         #Ctrlp:input.c.page1.apgb008
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apgb008
            #add-point:ON ACTION controlp INFIELD apgb008 name="input.c.page1.apgb008"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.apgb006
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apgb006
            #add-point:ON ACTION controlp INFIELD apgb006 name="input.c.page1.apgb006"
            LET l_ooef019 = NULL
            SELECT ooef019 INTO l_ooef019 FROM ooef_t
             WHERE ooefent = g_enterprise
               AND ooef001 = g_apga_m.apgacomp
            #稅別
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_apgb_d[l_ac].apgb006
            LET g_qryparam.arg1 = l_ooef019   
            CALL q_oodb002_5()
            LET g_apgb_d[l_ac].apgb006 = g_qryparam.return1
#            CALL s_tax_chk(g_apga_m.apgacomp,g_apgb_d[l_ac].apgb006) RETURNING g_sub_success,l_oodb004,g_apca_m.apca013,g_apca_m.apca012,l_oodb011
#            DISPLAY BY NAME g_apca_m.apca011,g_apca_m.apca012,g_apca_m.apca013
            NEXT FIELD apgb006
            #END add-point
 
 
         #Ctrlp:input.c.page1.apgb007
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apgb007
            #add-point:ON ACTION controlp INFIELD apgb007 name="input.c.page1.apgb007"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.apgb100
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apgb100
            #add-point:ON ACTION controlp INFIELD apgb100 name="input.c.page1.apgb100"
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
			   LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_apgb_d[l_ac].apgb100
            LET g_qryparam.arg1 = g_apga_m.apgacomp 
            CALL q_ooaj002_1()                           
            LET g_apgb_d[l_ac].apgb100 = g_qryparam.return1       
            DISPLAY BY NAME g_apgb_d[l_ac].apgb100
            NEXT FIELD apgb100       
            #END add-point
 
 
         #Ctrlp:input.c.page1.apgb101
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apgb101
            #add-point:ON ACTION controlp INFIELD apgb101 name="input.c.page1.apgb101"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.apgb009
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apgb009
            #add-point:ON ACTION controlp INFIELD apgb009 name="input.c.page1.apgb009"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.apgb105
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apgb105
            #add-point:ON ACTION controlp INFIELD apgb105 name="input.c.page1.apgb105"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.apgb115
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apgb115
            #add-point:ON ACTION controlp INFIELD apgb115 name="input.c.page1.apgb115"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.apgb010
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apgb010
            #add-point:ON ACTION controlp INFIELD apgb010 name="input.c.page1.apgb010"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.apgb011
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apgb011
            #add-point:ON ACTION controlp INFIELD apgb011 name="input.c.page1.apgb011"
            
            #END add-point
 
 
 
 
         ON ROW CHANGE
            IF INT_FLAG THEN
               LET INT_FLAG = 0
               LET g_apgb_d[l_ac].* = g_apgb_d_t.*
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code = 9001 
               LET g_errparam.popup = FALSE 
               CLOSE aapt510_bcl
               CALL s_transaction_end('N','0')
               CALL cl_err()
               EXIT DIALOG 
            END IF
              
            IF l_lock_sw = 'Y' THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = g_apgb_d[l_ac].apgbseq 
               LET g_errparam.code = -263 
               LET g_errparam.popup = TRUE 
               CALL cl_err()
               LET g_apgb_d[l_ac].* = g_apgb_d_t.*
            ELSE
            
               #add-point:單身修改前 name="input.body.b_update"
               LET g_apgb_d[l_ac].apgb011 = 0 
               #end add-point
               
               #寫入修改者/修改日期資訊(單身)
               
      
               #將遮罩欄位還原
               CALL aapt510_apgb_t_mask_restore('restore_mask_o')
      
               UPDATE apgb_t SET (apgbcomp,apgbdocno,apgbseq,apgborga,apgb001,apgb002,apgb003,apgb004, 
                   apgb005,apgb008,apgb006,apgb007,apgb100,apgb101,apgb009,apgb105,apgb115,apgb010,apgb011) = (g_apga_m.apgacomp, 
                   g_apga_m.apgadocno,g_apgb_d[l_ac].apgbseq,g_apgb_d[l_ac].apgborga,g_apgb_d[l_ac].apgb001, 
                   g_apgb_d[l_ac].apgb002,g_apgb_d[l_ac].apgb003,g_apgb_d[l_ac].apgb004,g_apgb_d[l_ac].apgb005, 
                   g_apgb_d[l_ac].apgb008,g_apgb_d[l_ac].apgb006,g_apgb_d[l_ac].apgb007,g_apgb_d[l_ac].apgb100, 
                   g_apgb_d[l_ac].apgb101,g_apgb_d[l_ac].apgb009,g_apgb_d[l_ac].apgb105,g_apgb_d[l_ac].apgb115, 
                   g_apgb_d[l_ac].apgb010,g_apgb_d[l_ac].apgb011)
                WHERE apgbent = g_enterprise AND apgbcomp = g_apga_m.apgacomp 
                  AND apgbdocno = g_apga_m.apgadocno 
 
                  AND apgbseq = g_apgb_d_t.apgbseq #項次   
 
                  
               #add-point:單身修改中 name="input.body.m_update"
               
               #end add-point
               CASE
                  WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
                     LET g_apgb_d[l_ac].* = g_apgb_d_t.*
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "apgb_t" 
                     LET g_errparam.code = "std-00009" 
                     LET g_errparam.popup = TRUE 
                     CALL s_transaction_end('N','0')
                     CALL cl_err()
                     
                  WHEN SQLCA.SQLCODE #其他錯誤
                     LET g_apgb_d[l_ac].* = g_apgb_d_t.*  
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "apgb_t:",SQLERRMESSAGE 
                     LET g_errparam.code = SQLCA.SQLCODE 
                     LET g_errparam.popup = TRUE 
                     CALL s_transaction_end('N','0')
                     CALL cl_err()                   
                     
                  OTHERWISE
                     #資料多語言用-增/改
                     
                                    INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_apga_m.apgacomp
               LET gs_keys_bak[1] = g_apgacomp_t
               LET gs_keys[2] = g_apga_m.apgadocno
               LET gs_keys_bak[2] = g_apgadocno_t
               LET gs_keys[3] = g_apgb_d[g_detail_idx].apgbseq
               LET gs_keys_bak[3] = g_apgb_d_t.apgbseq
               CALL aapt510_update_b('apgb_t',gs_keys,gs_keys_bak,"'1'")
               END CASE
 
               #將遮罩欄位進行遮蔽
               CALL aapt510_apgb_t_mask_restore('restore_mask_n')
               
               #判斷key是否有改變
               INITIALIZE gs_keys TO NULL
               IF NOT(g_apgb_d[g_detail_idx].apgbseq = g_apgb_d_t.apgbseq 
 
                  ) THEN
                  LET gs_keys[01] = g_apga_m.apgacomp
                  LET gs_keys[gs_keys.getLength()+1] = g_apga_m.apgadocno
 
                  LET gs_keys[gs_keys.getLength()+1] = g_apgb_d_t.apgbseq
 
                  CALL aapt510_key_update_b(gs_keys,'apgb_t')
               END IF
               
               #修改歷程記錄(單身修改)
               LET g_log1 = util.JSON.stringify(g_apga_m),util.JSON.stringify(g_apgb_d_t)
               LET g_log2 = util.JSON.stringify(g_apga_m),util.JSON.stringify(g_apgb_d[l_ac])
               IF NOT cl_log_modified_record_d(g_log1,g_log2) THEN 
                  CALL s_transaction_end('N','0')
               END IF
               
               #add-point:單身修改後 name="input.body.a_update"
               
               #end add-point
 
            END IF
            
         AFTER ROW
            #add-point:單身after_row name="input.body.after_row"
            
            #end add-point
            CALL aapt510_unlock_b("apgb_t","'1'")
            CALL s_transaction_end('Y','0')
            #其他table進行unlock
            #add-point:單身after_row2 name="input.body.after_row2"
            
            #end add-point
              
         AFTER INPUT
            #add-point:input段after input  name="input.body.after_input"
            #160428-00001#14-----s
            #計算是否有非開狀幣的單身
            LET l_count = NULL
            SELECT COUNT(*) INTO l_count FROM apgb_t
             WHERE apgbent = g_enterprise
               AND apgbcomp = g_apga_m.apgacomp
               AND apgbdocno = g_apga_m.apgadocno
               AND apgb100   = g_apga_m.glaa001
            IF cl_null(l_count)THEN LET l_count = 0 END IF
            
            IF l_count = 0 THEN
               LET l_apgasum = NULL   LET l_apgbsum = NULL
               SELECT (apga103+apga102) INTO l_apgasum FROM apga_t
                WHERE apgaent = g_enterprise
                  AND apgacomp = g_apga_m.apgacomp
                  AND apgadocno = g_apga_m.apgadocno
               IF cl_null(l_apgasum)THEN LET l_apgasum = 0 END IF
               
               SELECT SUM(apgb105)INTO l_apgbsum FROM apgb_t
                WHERE apgbent = g_enterprise
                  AND apgbcomp = g_apga_m.apgacomp
                  AND apgbdocno = g_apga_m.apgadocno
               IF cl_null(l_apgbsum)THEN LET l_apgbsum = 0 END IF
               
               IF l_apgbsum <> l_apgasum THEN
                  IF cl_ask_confirm('aap-00528')THEN
                     LET g_apga_m.apga103 = l_apgbsum - g_apga_m.apga102         
                     IF g_apga_m.apga103 < 0 THEN LET g_apga_m.apga103 = 0 END IF
                     CALL aapt510_fomula_h('A') 
                     CALL aapt510_fomula_h('B')
                     CALL aapt510_fomula_h('C')
                     CALL aapt510_fomula_h('D')
                     CALL aapt510_fomula_h('E')
                     CALL aapt510_fomula_h('F')
                     CALL aapt510_fomula_h('G')
                     IF g_apga_m.apga002 = 0 THEN
                        LET g_apga_m.apga109 = g_apga_m.apga103
                     END IF
                     UPDATE apga_t SET apga104 = g_apga_m.apga104,
                                       apga105 = g_apga_m.apga105,
                                       apga113 = g_apga_m.apga113,
                                       apga114 = g_apga_m.apga114,
                                       apga115 = g_apga_m.apga115,
                                       apga103 = g_apga_m.apga103,
                                       apga118 = g_apga_m.apga118, 
                                       apga112 = g_apga_m.apga112,
                                       apga109 = g_apga_m.apga109
                      WHERE apgaent = g_enterprise
                        AND apgacomp = g_apga_m.apgacomp
                        AND apgadocno = g_apga_m.apgadocno
                  END IF
               END IF            
               
            ELSE
               LET l_apgasum = NULL   LET l_apgbsum = NULL
               SELECT (apga113+apga112) INTO l_apgasum FROM apga_t
                WHERE apgaent = g_enterprise
                  AND apgacomp = g_apga_m.apgacomp
                  AND apgadocno = g_apga_m.apgadocno
               IF cl_null(l_apgasum)THEN LET l_apgasum = 0 END IF
               
               SELECT SUM(apgb115)INTO l_apgbsum FROM apgb_t
                WHERE apgbent = g_enterprise
                  AND apgbcomp = g_apga_m.apgacomp
                  AND apgbdocno = g_apga_m.apgadocno
               IF cl_null(l_apgbsum)THEN LET l_apgbsum = 0 END IF
               
               IF l_apgbsum <> l_apgasum THEN
                  IF cl_ask_confirm('aap-00559')THEN
                     LET g_apga_m.apga113 = l_apgbsum - g_apga_m.apga112 
                     LET g_apga_m.apga103 = g_apga_m.apga113 / g_apga_m.apga101
                     CALL s_curr_round(g_apga_m.apgacomp,g_apga_m.apga100,g_apga_m.apga103,2)
                        RETURNING g_apga_m.apga103
                     CALL aapt510_fomula_h('A') 
                     CALL aapt510_fomula_h('B')
                     CALL aapt510_fomula_h('D')
                     CALL aapt510_fomula_h('E')
                     IF g_apga_m.apga002 = 0 THEN
                        LET g_apga_m.apga109 = g_apga_m.apga103
                     END IF
                     UPDATE apga_t SET apga104 = g_apga_m.apga104,
                                       apga105 = g_apga_m.apga105,
                                       apga113 = g_apga_m.apga113,
                                       apga114 = g_apga_m.apga114,
                                       apga115 = g_apga_m.apga115,
                                       apga103 = g_apga_m.apga103,
                                       apga118 = g_apga_m.apga118, 
                                       apga112 = g_apga_m.apga112,
                                       apga109 = g_apga_m.apga109
                      WHERE apgaent = g_enterprise
                        AND apgacomp = g_apga_m.apgacomp
                        AND apgadocno = g_apga_m.apgadocno
                  END IF
               END IF               
            END IF
            LET g_apga_m.l_apga1041 = g_apga_m.apga104
            LET g_apga_m.l_apga1081 = g_apga_m.apga108
            LET g_apga_m.l_apga1021 = g_apga_m.apga102
            DISPLAY BY NAME g_apga_m.l_apga1041,g_apga_m.l_apga1081,g_apga_m.l_apga1021
            #160428-00001#14-----e
            #160428-00001#14 mark-----s
            #LET l_apgasum = NULL   LET l_apgbsum = NULL
            #SELECT apga103 INTO l_apgasum FROM apga_t
            # WHERE apgaent = g_enterprise
            #   AND apgacomp = g_apga_m.apgacomp
            #   AND apgadocno = g_apga_m.apgadocno
            #IF cl_null(l_apgasum)THEN LET l_apgasum = 0 END IF
            #
            #SELECT SUM(apgb105)INTO l_apgbsum FROM apgb_t
            # WHERE apgbent = g_enterprise
            #   AND apgbcomp = g_apga_m.apgacomp
            #   AND apgbdocno = g_apga_m.apgadocno
            #IF cl_null(l_apgbsum)THEN LET l_apgbsum = 0 END IF
            #
            #IF l_apgbsum <> l_apgasum THEN
            #   IF cl_ask_confirm('aap-00528')THEN
            #      #LET g_apga_m.apga103 = l_apgbsum                            #160428-00001#1
            #      LET g_apga_m.apga103 = l_apgbsum - g_apga_m.apga102          #160428-00001#1
            #      IF g_apga_m.apga103 < 0 THEN LET g_apga_m.apga103 = 0 END IF #160428-00001#1
            #      CALL aapt510_fomula_h('A') 
            #      CALL aapt510_fomula_h('B')
            #      CALL aapt510_fomula_h('C')
            #      CALL aapt510_fomula_h('D')
            #      CALL aapt510_fomula_h('E')
            #      CALL aapt510_fomula_h('F') #160428-00001#1
            #      CALL aapt510_fomula_h('G') #160428-00001#1
            #      UPDATE apga_t SET apga104 = g_apga_m.apga104,
            #                        apga105 = g_apga_m.apga105,
            #                        apga113 = g_apga_m.apga113,
            #                        apga114 = g_apga_m.apga114,
            #                        apga115 = g_apga_m.apga115,
            #                        apga103 = g_apga_m.apga103,
            #                        apga118 = g_apga_m.apga118, #160428-00001#1
            #                        apga112 = g_apga_m.apga112  #160428-00001#1
            #       WHERE apgaent = g_enterprise
            #         AND apgacomp = g_apga_m.apgacomp
            #         AND apgadocno = g_apga_m.apgadocno
            #   END IF
            #END IF
            #160428-00001#14 mark-----e
            #end add-point 
    
         ON ACTION controlo    
            IF l_insert THEN
               LET li_reproduce = l_ac_t
               LET li_reproduce_target = l_ac
               LET g_apgb_d[li_reproduce_target].* = g_apgb_d[li_reproduce].*
 
               LET g_apgb_d[li_reproduce_target].apgbseq = NULL
 
            ELSE
               CALL FGL_SET_ARR_CURR(g_apgb_d.getLength()+1)
               LET lb_reproduce = TRUE
               LET li_reproduce = l_ac
               LET li_reproduce_target = g_apgb_d.getLength()+1
            END IF
            
         #ON ACTION cancel
         #   LET INT_FLAG = 1
         #   LET g_detail_idx = 1
         #   EXIT DIALOG 
 
      END INPUT
      
      INPUT ARRAY g_apgb2_d FROM s_detail2.*
         ATTRIBUTE(COUNT = g_rec_b,WITHOUT DEFAULTS, #MAXCOUNT = g_max_rec,
                 INSERT ROW = l_allow_insert, #此頁面insert功能由產生器控制, 手動之設定無效! 
 
                 DELETE ROW = l_allow_delete,
                 APPEND ROW = l_allow_insert)
                 
         #自訂ACTION(detail_input,page_2)
         
         
         BEFORE INPUT
            #add-point:資料輸入前 name="input.body2.before_input2"
            
            #end add-point
            IF g_insert = 'Y' AND NOT cl_null(g_insert) THEN 
              CALL FGL_SET_ARR_CURR(g_apgb2_d.getLength()+1) 
              LET g_insert = 'N' 
           END IF 
 
            CALL aapt510_b_fill()
            #如果一直都在單身1則控制筆數位置
            IF g_loc = 'd' AND g_rec_b != 0 THEN
               CALL FGL_SET_ARR_CURR(g_idx_group.getValue("'2',"))
            END IF
            LET g_loc = 'd'
            LET g_rec_b = g_apgb2_d.getLength()
            #add-point:資料輸入前 name="input.body2.before_input"
            
            #end add-point
            
         BEFORE INSERT
            IF s_transaction_chk("N",0) THEN
               CALL s_transaction_begin()
            END IF
            LET l_insert = TRUE
            LET l_n = ARR_COUNT()
            LET l_cmd = 'a'
            INITIALIZE g_apgb2_d[l_ac].* TO NULL 
            INITIALIZE g_apgb2_d_t.* TO NULL 
            INITIALIZE g_apgb2_d_o.* TO NULL 
            #公用欄位給值(單身2)
            
            #自定義預設值(單身2)
                  LET g_apgb2_d[l_ac].apgc900 = "0"
      LET g_apgb2_d[l_ac].apgcseq = "0"
      LET g_apgb2_d[l_ac].apgc101 = "0"
      LET g_apgb2_d[l_ac].apgc103 = "0"
      LET g_apgb2_d[l_ac].apgc104 = "0"
      LET g_apgb2_d[l_ac].apgc105 = "0"
      LET g_apgb2_d[l_ac].apgc113 = "0"
      LET g_apgb2_d[l_ac].apgc114 = "0"
      LET g_apgb2_d[l_ac].apgc115 = "0"
 
            #add-point:modify段before備份 name="input.body2.insert.before_bak"
            LET g_apgb2_d[l_ac].apgc900 = '0'   #aapt510變更序固定給0
            SELECT MAX(apgcseq)+1 INTO g_apgb2_d[l_ac].apgcseq 
              FROM apgc_t
             WHERE apgcent = g_enterprise
               AND apgccomp = g_apga_m.apgacomp
               AND apgcdocno = g_apga_m.apgadocno
               AND apgc900 = '0'
            IF cl_null(g_apgb2_d[l_ac].apgcseq)THEN LET g_apgb2_d[l_ac].apgcseq = 1 END IF
            
            #預設g_site
            #法人比對單頭法人
            #檢核是否為法人下組織   #用8營運中心展
            #下展組織與權限也要符合才可帶出
            LET g_apgb2_d[l_ac].apgcorga = g_site
            LET l_sql = "SELECT COUNT(*) FROM ooef_t ",
                        " WHERE ooefent = ",g_enterprise," ",
                        "   AND ooef001 = '",g_apgb2_d[l_ac].apgcorga,"' ",
                        "   AND ooef017 = '",g_apga_m.apgacomp,"' ",
                        "   AND ooef001 IN ",g_wc_apgborga,
                        "   AND ooefstus = 'Y' "
            PREPARE sel_ooefp3 FROM l_sql
            LET l_count = NULL
            EXECUTE sel_ooefp3 INTO l_count 
            IF cl_null(l_count)THEN LET l_count = 0 END IF
            IF l_count = 0 THEN
               LET g_apgb2_d[l_ac].apgcorga = ''
            END IF            
            
            LET l_pmab037 = NULL LET l_pmab055 = NULL
            LET l_pmab034 = NULL LET l_pmab056 = NULL
            #SELECT pmab037,pmab055,pmab034,pmab056
            #  INTO l_pmab037,l_pmab055,l_pmab034,l_pmab056
            #  FROM pmab_t
            # WHERE pmabent = g_enterprise
            #   AND pmabsite = g_apga_m.apgacomp
            #   AND pmab001 = g_apga_m.apga004
            CALL s_apmm101_sel_pmab(g_apga_m.apgacomp,g_apga_m.apga004,'pmab037|pmab055|pmab034|pmab056')
               RETURNING g_sub_success,g_errno,l_pmab037,l_pmab055,l_pmab034,l_pmab056
            LET g_apgb2_d[l_ac].apgc002 = g_apga_m.apga004
            LET g_apgb2_d[l_ac].apgc003 = l_pmab037   #預帶對象主要付款條件 pmab037
            LET g_apgb2_d[l_ac].apgc005 = l_pmab055   #慣用帳款類別 pmab055
            LET g_apgb2_d[l_ac].apgc006 = l_pmab034   #預帶交易對象慣用稅別  pmab034
            LET g_apgb2_d[l_ac].apgc007 = l_pmab056   #慣用發票類型 pmab056
            

            
            LET g_apgb2_d[l_ac].apgc100 = g_apga_m.apga100
            LET g_apgb2_d[l_ac].apgc101 = g_apga_m.apga101
            LET g_apgb2_d[l_ac].apgc013 = 'aapt510'
            #end add-point
            LET g_apgb2_d_t.* = g_apgb2_d[l_ac].*     #新輸入資料
            LET g_apgb2_d_o.* = g_apgb2_d[l_ac].*     #新輸入資料
            CALL cl_show_fld_cont()
            CALL aapt510_set_entry_b(l_cmd)
            #add-point:modify段after_set_entry_b name="input.body2.insert.after_set_entry_b"
            
            #end add-point
            CALL aapt510_set_no_entry_b(l_cmd)
            IF lb_reproduce THEN
               LET lb_reproduce = FALSE
               LET g_apgb2_d[li_reproduce_target].* = g_apgb2_d[li_reproduce].*
 
               LET g_apgb2_d[li_reproduce_target].apgcseq = NULL
               LET g_apgb2_d[li_reproduce_target].apgc900 = NULL
            END IF
            
 
            #add-point:modify段before insert name="input.body2.before_insert"
            
            #end add-point  
 
         BEFORE ROW     
            #add-point:modify段before row2 name="input.body2.before_row2"
            
            #end add-point  
            LET l_insert = FALSE
            LET l_cmd = ''
            LET l_ac_t = l_ac 
            LET g_detail_idx_list[2] = l_ac
            LET l_ac = ARR_CURR()
            LET g_detail_idx = l_ac
            LET g_current_page = 2
              
            LET l_lock_sw = 'N'            #DEFAULT
            LET l_n = ARR_COUNT()
            DISPLAY l_ac TO FORMONLY.idx
         
            CALL s_transaction_begin()
            OPEN aapt510_cl USING g_enterprise,g_apga_m.apgacomp,g_apga_m.apgadocno
            IF SQLCA.SQLCODE THEN   #(ver:78)
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "OPEN aapt510_cl:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE   #(ver:78)
               LET g_errparam.popup = TRUE 
               CLOSE aapt510_cl
               CALL s_transaction_end('N','0')
               CALL cl_err()
               RETURN
            END IF
            
            LET g_rec_b = g_apgb2_d.getLength()
            
            IF g_rec_b >= l_ac 
               AND g_apgb2_d[l_ac].apgcseq IS NOT NULL
               AND g_apgb2_d[l_ac].apgc900 IS NOT NULL
            THEN 
               LET l_cmd='u'
               LET g_apgb2_d_t.* = g_apgb2_d[l_ac].*  #BACKUP
               LET g_apgb2_d_o.* = g_apgb2_d[l_ac].*  #BACKUP
               CALL aapt510_set_entry_b(l_cmd)
               #add-point:modify段after_set_entry_b name="input.body2.after_set_entry_b"
               
               #end add-point  
               CALL aapt510_set_no_entry_b(l_cmd)
               IF NOT aapt510_lock_b("apgc_t","'2'") THEN
                  LET l_lock_sw='Y'
               ELSE
                  FETCH aapt510_bcl2 INTO g_apgb2_d[l_ac].apgc900,g_apgb2_d[l_ac].apgcseq,g_apgb2_d[l_ac].apgcorga, 
                      g_apgb2_d[l_ac].apgc001,g_apgb2_d[l_ac].apgc002,g_apgb2_d[l_ac].apgc003,g_apgb2_d[l_ac].apgc005, 
                      g_apgb2_d[l_ac].apgc014,g_apgb2_d[l_ac].apgc100,g_apgb2_d[l_ac].apgc101,g_apgb2_d[l_ac].apgc006, 
                      g_apgb2_d[l_ac].apgc007,g_apgb2_d[l_ac].apgc008,g_apgb2_d[l_ac].apgc009,g_apgb2_d[l_ac].apgc010, 
                      g_apgb2_d[l_ac].apgc011,g_apgb2_d[l_ac].apgc103,g_apgb2_d[l_ac].apgc104,g_apgb2_d[l_ac].apgc105, 
                      g_apgb2_d[l_ac].apgc113,g_apgb2_d[l_ac].apgc114,g_apgb2_d[l_ac].apgc115,g_apgb2_d[l_ac].apgc004, 
                      g_apgb2_d[l_ac].apgc015,g_apgb2_d[l_ac].apgc016,g_apgb2_d[l_ac].apgc012,g_apgb2_d[l_ac].apgc013 
 
                  IF SQLCA.SQLCODE THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = SQLERRMESSAGE  
                     LET g_errparam.code = SQLCA.SQLCODE 
                     LET g_errparam.popup = TRUE 
                     CALL cl_err()
                     LET l_lock_sw = "Y"
                  END IF
                  
                  #遮罩相關處理
                  LET g_apgb2_d_mask_o[l_ac].* =  g_apgb2_d[l_ac].*
                  CALL aapt510_apgc_t_mask()
                  LET g_apgb2_d_mask_n[l_ac].* =  g_apgb2_d[l_ac].*
                  
                  LET g_bfill = "N"
                  CALL aapt510_show()
                  LET g_bfill = "Y"
                  
                  CALL cl_show_fld_cont()
               END IF
            ELSE
               LET l_cmd='a'
            END IF
            #add-point:modify段before row name="input.body2.before_row"
            #160428-00001#1---s---
            CALL cl_set_comp_entry('apgc010',TRUE)
            LET l_cnt = 0
            SELECT COUNT(*) INTO l_cnt FROM apgc_t
             WHERE apgcent = g_enterprise AND apgcdocno = g_apga_m.apgadocno
               AND apgc009 = g_apgb2_d[l_ac].apgc009
            IF l_cnt > 1 THEN 
               CALL cl_set_comp_entry('apgc010',FALSE)
            END IF
            CALL aapt510_apgc009_chk(l_ac)RETURNING g_sub_success,g_errno         
            #160428-00001#1---e---
            #end add-point  
            #其他table資料備份(確定是否更改用)
            
 
            #其他table進行lock
            
 
            
         BEFORE DELETE                            #是否取消單身
            IF l_cmd = 'a' THEN
               LET l_cmd='d'
               #add-point:單身AFTER DELETE (=d) name="input.body2.after_delete_d"
               
               #end add-point
            ELSE
               #add-point:單身刪除前 name="input.body2.b_delete_ask"
               
               #end add-point 
               IF NOT cl_ask_del_detail() THEN
                  CANCEL DELETE
               END IF
               IF l_lock_sw = "Y" THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "" 
                  LET g_errparam.code = -263 
                  LET g_errparam.popup = TRUE 
                  CALL cl_err()
                  CANCEL DELETE
               END IF
               
               #add-point:單身2刪除前 name="input.body2.b_delete"
               
               #end add-point    
                  
               #取得該筆資料key值
               INITIALIZE gs_keys TO NULL
               LET gs_keys[01] = g_apga_m.apgacomp
               LET gs_keys[gs_keys.getLength()+1] = g_apga_m.apgadocno
               LET gs_keys[gs_keys.getLength()+1] = g_apgb2_d_t.apgcseq
               LET gs_keys[gs_keys.getLength()+1] = g_apgb2_d_t.apgc900
            
               #刪除同層單身
               IF NOT aapt510_delete_b('apgc_t',gs_keys,"'2'") THEN
                  CALL s_transaction_end('N','0')
                  CLOSE aapt510_bcl
                  CANCEL DELETE
               END IF
    
               #刪除下層單身
               IF NOT aapt510_key_delete_b(gs_keys,'apgc_t') THEN
                  CALL s_transaction_end('N','0')
                  CLOSE aapt510_bcl
                  CANCEL DELETE
               END IF
               
               #刪除多語言
               
 
               
               #add-point:單身2刪除中 name="input.body2.m_delete"
               
               #end add-point    
               
               CALL s_transaction_end('Y','0')
               CLOSE aapt510_bcl
 
               LET g_rec_b = g_rec_b-1
               #add-point:單身2刪除後 name="input.body2.a_delete"
               
               #end add-point
               LET l_count = g_apgb_d.getLength()
               
               #add-point:單身刪除後(<>d) name="input.body2.after_delete"
               
               #end add-point
            END IF 
 
         AFTER DELETE
            #如果是最後一筆
            IF l_ac = (g_apgb2_d.getLength() + 1) THEN
               CALL FGL_SET_ARR_CURR(l_ac-1)
            END IF
 
         AFTER INSERT    
            LET l_insert = FALSE
            IF INT_FLAG THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code = 9001 
               LET g_errparam.popup = FALSE 
               CALL cl_err()
               LET INT_FLAG = 0
               CANCEL INSERT
            END IF
               
            #add-point:單身2新增前 name="input.body2.b_a_insert"
            
            #end add-point
               
            LET l_count = 1  
            SELECT COUNT(1) INTO l_count FROM apgc_t 
             WHERE apgcent = g_enterprise AND apgccomp = g_apga_m.apgacomp
               AND apgcdocno = g_apga_m.apgadocno
               AND apgcseq = g_apgb2_d[l_ac].apgcseq
               AND apgc900 = g_apgb2_d[l_ac].apgc900
                
            #資料未重複, 插入新增資料
            IF l_count = 0 THEN 
               #add-point:單身2新增前 name="input.body2.b_insert"
               
               #end add-point
            
                              INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_apga_m.apgacomp
               LET gs_keys[2] = g_apga_m.apgadocno
               LET gs_keys[3] = g_apgb2_d[g_detail_idx].apgcseq
               LET gs_keys[4] = g_apgb2_d[g_detail_idx].apgc900
               CALL aapt510_insert_b('apgc_t',gs_keys,"'2'")
                           
               #add-point:單身新增後2 name="input.body2.a_insert"
               
               #end add-point
            ELSE    
               INITIALIZE g_apgb_d[l_ac].* TO NULL
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = 'INSERT' 
               LET g_errparam.code = "std-00006" 
               LET g_errparam.popup = TRUE 
               CALL s_transaction_end('N','0')
               CALL cl_err()
               CANCEL INSERT
            END IF
 
            IF SQLCA.SQLCODE THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "apgc_t:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE 
               LET g_errparam.popup = TRUE 
               CALL s_transaction_end('N','0')                    
               CALL cl_err()
               CANCEL INSERT
            ELSE
               #先刷新資料
               #CALL aapt510_b_fill()
               #資料多語言用-增/改
               
               #add-point:單身新增後 name="input.body2.after_insert"
               
               #end add-point
               CALL s_transaction_end('Y','0')
               #ERROR 'INSERT O.K'
               LET g_rec_b = g_rec_b + 1
            END IF
            
         ON ROW CHANGE 
            IF INT_FLAG THEN
               LET INT_FLAG = 0
               LET g_apgb2_d[l_ac].* = g_apgb2_d_t.*
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code = 9001 
               LET g_errparam.popup = FALSE 
               CLOSE aapt510_bcl2
               CALL s_transaction_end('N','0')
               CALL cl_err()
               EXIT DIALOG 
            END IF
            
            IF l_lock_sw = 'Y' THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code = -263 
               LET g_errparam.popup = TRUE 
               CALL cl_err()
               LET g_apgb2_d[l_ac].* = g_apgb2_d_t.*
            ELSE
               #add-point:單身page2修改前 name="input.body2.b_update"
               
               #end add-point
               
               #寫入修改者/修改日期資訊(單身2)
               
               
               #將遮罩欄位還原
               CALL aapt510_apgc_t_mask_restore('restore_mask_o')
                              
               UPDATE apgc_t SET (apgccomp,apgcdocno,apgc900,apgcseq,apgcorga,apgc001,apgc002,apgc003, 
                   apgc005,apgc014,apgc100,apgc101,apgc006,apgc007,apgc008,apgc009,apgc010,apgc011,apgc103, 
                   apgc104,apgc105,apgc113,apgc114,apgc115,apgc004,apgc015,apgc016,apgc012,apgc013) = (g_apga_m.apgacomp, 
                   g_apga_m.apgadocno,g_apgb2_d[l_ac].apgc900,g_apgb2_d[l_ac].apgcseq,g_apgb2_d[l_ac].apgcorga, 
                   g_apgb2_d[l_ac].apgc001,g_apgb2_d[l_ac].apgc002,g_apgb2_d[l_ac].apgc003,g_apgb2_d[l_ac].apgc005, 
                   g_apgb2_d[l_ac].apgc014,g_apgb2_d[l_ac].apgc100,g_apgb2_d[l_ac].apgc101,g_apgb2_d[l_ac].apgc006, 
                   g_apgb2_d[l_ac].apgc007,g_apgb2_d[l_ac].apgc008,g_apgb2_d[l_ac].apgc009,g_apgb2_d[l_ac].apgc010, 
                   g_apgb2_d[l_ac].apgc011,g_apgb2_d[l_ac].apgc103,g_apgb2_d[l_ac].apgc104,g_apgb2_d[l_ac].apgc105, 
                   g_apgb2_d[l_ac].apgc113,g_apgb2_d[l_ac].apgc114,g_apgb2_d[l_ac].apgc115,g_apgb2_d[l_ac].apgc004, 
                   g_apgb2_d[l_ac].apgc015,g_apgb2_d[l_ac].apgc016,g_apgb2_d[l_ac].apgc012,g_apgb2_d[l_ac].apgc013)  
                   #自訂欄位頁簽
                WHERE apgcent = g_enterprise AND apgccomp = g_apga_m.apgacomp
                  AND apgcdocno = g_apga_m.apgadocno
                  AND apgcseq = g_apgb2_d_t.apgcseq #項次 
                  AND apgc900 = g_apgb2_d_t.apgc900
                  
               #add-point:單身page2修改中 name="input.body2.m_update"
               
               #end add-point
                  
               CASE
                  WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
                     LET g_apgb2_d[l_ac].* = g_apgb2_d_t.*
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "apgc_t" 
                     LET g_errparam.code = "std-00009" 
                     LET g_errparam.popup = TRUE 
                     CALL s_transaction_end('N','0')
                     CALL cl_err()
                     
                  WHEN SQLCA.SQLCODE #其他錯誤
                     LET g_apgb2_d[l_ac].* = g_apgb2_d_t.*
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "apgc_t:",SQLERRMESSAGE 
                     LET g_errparam.code = SQLCA.SQLCODE 
                     LET g_errparam.popup = TRUE 
                     CALL s_transaction_end('N','0')
                     CALL cl_err()
                     
                  OTHERWISE
                     #資料多語言用-增/改
                     
                                    INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_apga_m.apgacomp
               LET gs_keys_bak[1] = g_apgacomp_t
               LET gs_keys[2] = g_apga_m.apgadocno
               LET gs_keys_bak[2] = g_apgadocno_t
               LET gs_keys[3] = g_apgb2_d[g_detail_idx].apgcseq
               LET gs_keys_bak[3] = g_apgb2_d_t.apgcseq
               LET gs_keys[4] = g_apgb2_d[g_detail_idx].apgc900
               LET gs_keys_bak[4] = g_apgb2_d_t.apgc900
               CALL aapt510_update_b('apgc_t',gs_keys,gs_keys_bak,"'2'")
               END CASE
               
               #將遮罩欄位進行遮蔽
               CALL aapt510_apgc_t_mask_restore('restore_mask_n')
               
               #判斷key是否有改變
               INITIALIZE gs_keys TO NULL
               IF NOT (g_apgb2_d[g_detail_idx].apgcseq = g_apgb2_d_t.apgcseq 
                  AND g_apgb2_d[g_detail_idx].apgc900 = g_apgb2_d_t.apgc900 
                  ) THEN
                  LET gs_keys[01] = g_apga_m.apgacomp
                  LET gs_keys[gs_keys.getLength()+1] = g_apga_m.apgadocno
                  LET gs_keys[gs_keys.getLength()+1] = g_apgb2_d_t.apgcseq
                  LET gs_keys[gs_keys.getLength()+1] = g_apgb2_d_t.apgc900
                  CALL aapt510_key_update_b(gs_keys,'apgc_t')
               END IF
               
               #修改歷程記錄(單身修改)
               LET g_log1 = util.JSON.stringify(g_apga_m),util.JSON.stringify(g_apgb2_d_t)
               LET g_log2 = util.JSON.stringify(g_apga_m),util.JSON.stringify(g_apgb2_d[l_ac])
               IF NOT cl_log_modified_record_d(g_log1,g_log2) THEN 
                  CALL s_transaction_end('N','0')
               END IF
               
               #add-point:單身page2修改後 name="input.body2.a_update"
               
               #end add-point
            END IF
         
                  #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apgc900
            #add-point:BEFORE FIELD apgc900 name="input.b.page2.apgc900"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apgc900
            
            #add-point:AFTER FIELD apgc900 name="input.a.page2.apgc900"
            #應用 a05 樣板自動產生(Version:2)
            #確認資料無重複
            IF  g_apga_m.apgacomp IS NOT NULL AND g_apga_m.apgadocno IS NOT NULL AND g_apgb2_d[g_detail_idx].apgcseq IS NOT NULL AND g_apgb2_d[g_detail_idx].apgc900 IS NOT NULL THEN 
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_apga_m.apgacomp != g_apgacomp_t OR g_apga_m.apgadocno != g_apgadocno_t OR g_apgb2_d[g_detail_idx].apgcseq != g_apgb2_d_t.apgcseq OR g_apgb2_d[g_detail_idx].apgc900 != g_apgb2_d_t.apgc900)) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM apgc_t WHERE "||"apgcent = '" ||g_enterprise|| "' AND "||"apgccomp = '"||g_apga_m.apgacomp ||"' AND "|| "apgcdocno = '"||g_apga_m.apgadocno ||"' AND "|| "apgcseq = '"||g_apgb2_d[g_detail_idx].apgcseq ||"' AND "|| "apgc900 = '"||g_apgb2_d[g_detail_idx].apgc900 ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF


            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apgc900
            #add-point:ON CHANGE apgc900 name="input.g.page2.apgc900"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apgcseq
            #add-point:BEFORE FIELD apgcseq name="input.b.page2.apgcseq"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apgcseq
            
            #add-point:AFTER FIELD apgcseq name="input.a.page2.apgcseq"
            #應用 a05 樣板自動產生(Version:2)
            #確認資料無重複
            IF  g_apga_m.apgacomp IS NOT NULL AND g_apga_m.apgadocno IS NOT NULL AND g_apgb2_d[g_detail_idx].apgcseq IS NOT NULL AND g_apgb2_d[g_detail_idx].apgc900 IS NOT NULL THEN 
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_apga_m.apgacomp != g_apgacomp_t OR g_apga_m.apgadocno != g_apgadocno_t OR g_apgb2_d[g_detail_idx].apgcseq != g_apgb2_d_t.apgcseq OR g_apgb2_d[g_detail_idx].apgc900 != g_apgb2_d_t.apgc900)) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM apgc_t WHERE "||"apgcent = '" ||g_enterprise|| "' AND "||"apgccomp = '"||g_apga_m.apgacomp ||"' AND "|| "apgcdocno = '"||g_apga_m.apgadocno ||"' AND "|| "apgcseq = '"||g_apgb2_d[g_detail_idx].apgcseq ||"' AND "|| "apgc900 = '"||g_apgb2_d[g_detail_idx].apgc900 ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF


            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apgcseq
            #add-point:ON CHANGE apgcseq name="input.g.page2.apgcseq"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apgcorga
            #add-point:BEFORE FIELD apgcorga name="input.b.page2.apgcorga"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apgcorga
            
            #add-point:AFTER FIELD apgcorga name="input.a.page2.apgcorga"
            LET l_ld = NULL
            SELECT glaald INTO l_ld FROM glaa_t
             WHERE glaaent = g_enterprise
               AND glaacomp = g_apga_m.apgacomp
               AND glaa014 = 'Y'
            #來源組織
            IF NOT cl_null(g_apgb2_d[l_ac].apgcorga) THEN
               IF l_cmd = 'a' OR (l_cmd = 'u' AND (g_apgb_d[l_ac].apgborga != g_apgb2_d_t.apgcorga OR g_apgb2_d_t.apgcorga IS NULL )) THEN            
                  INITIALIZE g_chkparam.* TO NULL
                  LET g_chkparam.arg1 = g_apgb2_d[l_ac].apgcorga
                  #160318-00025#24  by 07900 --add-str
                  LET g_errshow = TRUE #是否開窗                   
                  LET g_chkparam.err_str[1] ="aoo-00095:sub-01302|aooi125|",cl_get_progname("aooi125",g_lang,"2"),"|:EXEPROGaooi125"
                  #160318-00025#24  by 07900 --add-end
                  IF NOT cl_chk_exist("v_ooef001") THEN
                     LET g_apgb2_d[l_ac].apgcorga = g_apgb2_d_t.apgcorga
                     DISPLAY BY NAME g_apgb2_d[l_ac].apgcorga
                     NEXT FIELD CURRENT
                  END IF
                  CALL s_aap_apcborga_chk(l_ld,g_apga_m.apgadocno,g_apgb2_d[l_ac].apgcorga,g_wc_apgborga) 
                       RETURNING g_sub_success,g_errno
                  IF NOT g_sub_success THEN
                     LET g_errparam.code = g_errno
                     LET g_errparam.extend = ''
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                     LET g_apgb2_d[l_ac].apgcorga = g_apgb2_d_t.apgcorga
                     DISPLAY BY NAME g_apgb2_d[l_ac].apgcorga
                     NEXT FIELD CURRENT
                  END IF
                  
                   CALL s_fin_orga_get_comp_ld(g_apgb2_d[l_ac].apgcorga) RETURNING g_sub_success,g_errno,l_comp,l_ld
                   IF l_comp <> g_apga_m.apgacomp THEN
                      LET g_errparam.code = 'axc-00112'
                      LET g_errparam.extend = ''
                      LET g_errparam.popup = TRUE
                      CALL cl_err()
                      LET g_apgb2_d[l_ac].apgcorga = g_apgb2_d_t.apgcorga
                      DISPLAY BY NAME g_apgb2_d[l_ac].apgcorga
                      NEXT FIELD CURRENT
                   END IF
               END IF  
            END IF
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apgcorga
            #add-point:ON CHANGE apgcorga name="input.g.page2.apgcorga"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apgc001
            
            #add-point:AFTER FIELD apgc001 name="input.a.page2.apgc001"
#            INITIALIZE g_ref_fields TO NULL
#            LET g_ref_fields[1] = g_apgb2_d[l_ac].apgc001
#            CALL ap_ref_array2(g_ref_fields,"SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001='3117' AND oocql002=? AND oocql003='"||g_dlang||"'","") RETURNING g_rtn_fields
#            LET g_apgb2_d[l_ac].apgc001_desc = '', g_rtn_fields[1] , ''
#            DISPLAY BY NAME g_apgb2_d[l_ac].apgc001_desc

            LET l_ld = NULL   LET l_glaa005 = NULL
            SELECT glaald ,glaa005
              INTO l_ld ,l_glaa005
              FROM glaa_t
             WHERE glaaent = g_enterprise
               AND glaacomp = g_apga_m.apgacomp
               AND glaa014 = 'Y'               
            LET g_apgb2_d[l_ac].apgc001_desc = ' '
            IF NOT cl_null(g_apgb2_d[l_ac].apgc001) THEN
               IF g_apgb2_d[l_ac].apgc001 != g_apgb2_d_o.apgc001 OR cl_null(g_apgb2_d_o.apgc001) THEN                                        #160822-00008#5 add
               #IF p_cmd = 'a' OR (p_cmd = 'u' AND (g_apgb2_d[l_ac].apgc001 != g_apgb2_d_t.apgc001 OR g_apgb2_d_t.apgc001 IS NULL )) THEN #160822-00008#5 mark
                  IF NOT s_azzi650_chk_exist('3117',g_apgb2_d[l_ac].apgc001) THEN
                     #LET g_apgb2_d[l_ac].apgc001  = g_apgb2_d_t.apgc001 #160822-00008#5 mark
                     LET g_apgb2_d[l_ac].apgc001  = g_apgb2_d_o.apgc001  #160822-00008#5 add 
                     CALL s_desc_get_acc_desc('3117',g_apgb2_d[l_ac].apgc001) RETURNING g_apgb2_d[l_ac].apgc001_desc
                     DISPLAY BY NAME g_apgb2_d[l_ac].apgc001_desc
                     NEXT FIELD CURRENT
                  END IF
                  
                  LET l_glab005 = NULL LET l_glab006 = NULL LET l_glab007 = NULL
                  SELECT glab005,glab006,glab007
                    INTO l_glab005,l_glab006,l_glab007
                    FROM glab_t
                   WHERE glabent = g_enterprise
                     AND glabld  = l_ld
                     AND glab001 = '15'
                     AND glab002 = '3117'                     
                     AND glab003 = g_apgb2_d[l_ac].apgc001
                    
                  #160822-00008#5 --s add                    
                  LET g_apgb2_d[l_ac].apgc004 = ''
                  LET g_apgb2_d[l_ac].apgc015 = ''
                  LET g_apgb2_d[l_ac].apgc016 = ''
                  #160822-00008#5 --e add
                  
                  LET g_apgb2_d[l_ac].apgc004 = l_glab005
                  LET g_apgb2_d[l_ac].apgc015 = l_glab006
                  LET g_apgb2_d[l_ac].apgc016 = l_glab007
                  LET g_apgb2_d[l_ac].apgc004_desc = s_desc_get_account_desc(l_ld,g_apgb2_d[l_ac].apgc004)
                  LET g_apgb2_d[l_ac].apgc015_desc = s_desc_get_nmajl003_desc(g_apgb2_d[l_ac].apgc015)                
                  LET g_apgb2_d[l_ac].apgc016_desc =s_desc_get_nmail004_desc(l_glaa005,g_apgb2_d[l_ac].apgc016)
                  DISPLAY BY NAME g_apgb2_d[l_ac].apgc004,g_apgb2_d[l_ac].apgc015,g_apgb2_d[l_ac].apgc016
                  
                  
               END IF
            END IF
            CALL s_desc_get_acc_desc('3117',g_apgb2_d[l_ac].apgc001) RETURNING g_apgb2_d[l_ac].apgc001_desc
            DISPLAY BY NAME g_apgb2_d[l_ac].apgc001_desc
            LET g_apgb2_d_o.* = g_apgb2_d[l_ac].*  #160822-00008#5 add
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apgc001
            #add-point:BEFORE FIELD apgc001 name="input.b.page2.apgc001"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apgc001
            #add-point:ON CHANGE apgc001 name="input.g.page2.apgc001"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apgc002
            #add-point:BEFORE FIELD apgc002 name="input.b.page2.apgc002"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apgc002
            
            #add-point:AFTER FIELD apgc002 name="input.a.page2.apgc002"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apgc002
            #add-point:ON CHANGE apgc002 name="input.g.page2.apgc002"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apgc003
            #add-point:BEFORE FIELD apgc003 name="input.b.page2.apgc003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apgc003
            
            #add-point:AFTER FIELD apgc003 name="input.a.page2.apgc003"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apgc003
            #add-point:ON CHANGE apgc003 name="input.g.page2.apgc003"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apgc005
            #add-point:BEFORE FIELD apgc005 name="input.b.page2.apgc005"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apgc005
            
            #add-point:AFTER FIELD apgc005 name="input.a.page2.apgc005"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apgc005
            #add-point:ON CHANGE apgc005 name="input.g.page2.apgc005"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apgc014
            #add-point:BEFORE FIELD apgc014 name="input.b.page2.apgc014"
            CALL aapt510_set_entry_b(p_cmd)   #160824-00049#1
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apgc014
            
            #add-point:AFTER FIELD apgc014 name="input.a.page2.apgc014"
            IF NOT cl_null(g_apgb2_d[l_ac].apgc014) THEN
               IF g_apgb2_d[l_ac].apgc014 != g_apgb2_d_o.apgc014 OR cl_null(g_apgb2_d_o.apgc014) THEN                                     #160822-00008#5 add
               #IF p_cmd = 'a' OR (p_cmd = 'u' AND (g_apgb2_d[l_ac].apgc014 != g_apgb2_d_t.apgc014 OR g_apgb2_d_t.apgc014 IS NULL )) THEN #160822-00008#5 mark
                  LET g_chkparam.arg1 = g_apgb2_d[l_ac].apgc014
                  LET g_chkparam.arg2 = g_apga_m.apgacomp
                  LET g_chkparam.arg3 = '5'    #kris  aapt5系列皆付現  所以帳戶為零用金類型(比照aapt420現金類處理)
                  #160318-00025#24  by 07900 --add-str
                  LET g_errshow = TRUE #是否開窗                   
                  LET g_chkparam.err_str[1] ="ade-00010:sub-01302|anmi120|",cl_get_progname("anmi20",g_lang,"2"),"|:EXEPROGanmi120"
                  #160318-00025#24  by 07900 --add-end 
                  IF cl_chk_exist("v_nmas002_4") THEN
                     IF NOT s_anmi120_nmll002_chk(g_apgb2_d[l_ac].apgc014,g_user) THEN
                        INITIALIZE g_errparam TO NULL
                        LET g_errparam.extend = g_apgb2_d[l_ac].apgc014
                        LET g_errparam.code   = 'anm-00574'
                        LET g_errparam.popup  = TRUE
                        CALL cl_err()
                        #LET g_apgb2_d[l_ac].apgc014 = g_apgb2_d_t.apgc014  #160822-00008#5 mark
                        LET g_apgb2_d[l_ac].apgc014 = g_apgb2_d_o.apgc014   #160822-00008#5 add
                        NEXT FIELD CURRENT
                     END IF
                  ELSE
                     NEXT FIELD CURRENT
                  END IF
                  
                  LET g_apgb2_d[l_ac].apgc100 = ''  #160822-00008#5 add
                  LET g_apgb2_d[l_ac].apgc100 = s_anm_get_nmas003(g_apgb2_d[l_ac].apgc014)
                  DISPLAY BY NAME g_apgb2_d[l_ac].apgc014
                  CALL aapt510_curr_recount_b2(l_ac)
                  CALL aapt510_to_o_b2(l_ac)
                  LET g_apgb2_d[l_ac].apgc009 = '' #160428-00001#1 #改變幣別清空發票號碼日期
                  LET g_apgb2_d[l_ac].apgc010 = '' #160428-00001#1
               END IF
            END IF
            CALL aapt510_set_no_entry_b(p_cmd)          #160824-00049#1
            LET g_apgb2_d_o.* = g_apgb2_d[l_ac].*  #160822-00008#5 add
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apgc014
            #add-point:ON CHANGE apgc014 name="input.g.page2.apgc014"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apgc100
            #add-point:BEFORE FIELD apgc100 name="input.b.page2.apgc100"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apgc100
            
            #add-point:AFTER FIELD apgc100 name="input.a.page2.apgc100"
            LET g_apgb2_d_o.* = g_apgb2_d[l_ac].*  #160822-00008#5 add
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apgc100
            #add-point:ON CHANGE apgc100 name="input.g.page2.apgc100"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apgc101
            #add-point:BEFORE FIELD apgc101 name="input.b.page2.apgc101"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apgc101
            
            #add-point:AFTER FIELD apgc101 name="input.a.page2.apgc101"
            IF NOT cl_null(g_apgb2_d[l_ac].apgc101)THEN
               IF cl_null(g_apgb2_d_o.apgc101) OR (g_apgb2_d_o.apgc101 <> g_apgb2_d[l_ac].apgc101)THEN  
                  #160824-00049#1-----s
                  CALL s_curr_round_ld('1',l_ld,g_apgb2_d[l_ac].apgc100,g_apgb2_d[l_ac].apgc101,3) 
                     RETURNING g_sub_success,g_errno,g_apgb2_d[l_ac].apgc101               
                  #160824-00049#1-----e
                  CALL aapt510_tax_ins_b2(l_ac)
                  CALL aapt510_to_o_b2(l_ac)
                  DISPLAY BY NAME g_apgb2_d[l_ac].apgc101
               END IF
            END IF
            CALL aapt510_to_o_b2(l_ac)
            DISPLAY BY NAME g_apgb2_d[l_ac].apgc101            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apgc101
            #add-point:ON CHANGE apgc101 name="input.g.page2.apgc101"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apgc006
            #add-point:BEFORE FIELD apgc006 name="input.b.page2.apgc006"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apgc006
            
            #add-point:AFTER FIELD apgc006 name="input.a.page2.apgc006"
            IF NOT cl_null(g_apgb2_d[l_ac].apgc006) THEN
               IF g_apgb2_d[l_ac].apgc006 != g_apgb2_d_o.apgc006 OR cl_null(g_apgb2_d_o.apgc006) THEN                                          #160822-00008#5 add
               #IF p_cmd = 'a' OR (p_cmd = 'u' AND ((g_apgb2_d[l_ac].apgc006 != g_apgb2_d_t.apgc006 OR g_apgb2_d_t.apgc006 IS NULL ) )) THEN   #160822-00008#5 mark
                  CALL s_tax_chk(g_apga_m.apgacomp,g_apgb2_d[l_ac].apgc006) RETURNING g_sub_success,l_oodb004,l_apca013,l_apca012,l_oodb011
                  IF NOT g_sub_success THEN
                     #LET g_apgb2_d[l_ac].apgc006 = g_apgb2_d_t.apgc006  #160822-00008#5 mark
                     LET g_apgb2_d[l_ac].apgc006 = g_apgb2_d_o.apgc006   #160822-00008#5 add
                     DISPLAY BY NAME g_apgb2_d[l_ac].apgc006
                     NEXT FIELD CURRENT
                  END IF
                  CALL aapt510_tax_ins_b2(l_ac)
                  CALL aapt510_to_o_b2(l_ac)
                  DISPLAY BY NAME g_apgb2_d[l_ac].apgc006
               END IF
            END IF
            
            LET g_apgb2_d_o.* = g_apgb2_d[l_ac].*  #160822-00008#5 add
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apgc006
            #add-point:ON CHANGE apgc006 name="input.g.page2.apgc006"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apgc007
            #add-point:BEFORE FIELD apgc007 name="input.b.page2.apgc007"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apgc007
            
            #add-point:AFTER FIELD apgc007 name="input.a.page2.apgc007"
            IF NOT cl_null(g_apgb2_d[l_ac].apgc007)THEN
               IF cl_null(g_apgb2_d_t.apgc007) OR (g_apgb2_d_t.apgc007 <> g_apgb2_d[l_ac].apgc007)THEN
                  LET l_ooef019 = NULL
                  SELECT ooef019 INTO l_ooef019 FROM ooef_t
                   WHERE ooefent = g_enterprise
                     AND ooef001 = g_apga_m.apgacomp                   
                  INITIALIZE g_chkparam.* TO NULL
                  LET g_chkparam.arg1 = l_ooef019
                  LET g_chkparam.arg2 = g_apgb2_d[l_ac].apgc007
                  IF NOT cl_chk_exist("v_isac002_3") THEN
                     LET g_apgb2_d[l_ac].apgc007 = g_apgb2_d_t.apgc007
                     DISPLAY BY NAME g_apgb2_d[l_ac].apgc007
                     NEXT FIELD CURRENT
                  END IF
                  
                  LET l_isac004 = ''
                  SELECT isac004 INTO l_isac004 FROM isac_t
                   WHERE isacent = g_enterprise 
                     AND isac002 = g_apgb2_d[l_ac].apgc007
                     AND isac001 = l_ooef019
                  LET g_apgb2_d[l_ac].apgc011 = '1' 
                  IF cl_null(l_isac004) THEN LET g_apgb2_d[l_ac].apgc011 = '3' END IF
                  DISPLAY BY NAME g_apgb2_d[l_ac].apgc011
               END IF
            END IF
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apgc007
            #add-point:ON CHANGE apgc007 name="input.g.page2.apgc007"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apgc008
            #add-point:BEFORE FIELD apgc008 name="input.b.page2.apgc008"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apgc008
            
            #add-point:AFTER FIELD apgc008 name="input.a.page2.apgc008"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apgc008
            #add-point:ON CHANGE apgc008 name="input.g.page2.apgc008"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apgc009
            #add-point:BEFORE FIELD apgc009 name="input.b.page2.apgc009"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apgc009
            
            #add-point:AFTER FIELD apgc009 name="input.a.page2.apgc009"
            #160428-00001#1 ---s---費用單身同一發票出現在不同項次時, 發票日期不可異動以第一筆為主,相同幣別才可以開同一張發票號..　
            IF NOT cl_null(g_apgb2_d[l_ac].apgc009)THEN
               IF g_apgb2_d[l_ac].apgc009 != g_apgb2_d_o.apgc009 OR cl_null(g_apgb2_d_o.apgc009) THEN                                        #160822-00008#5 add
               #IF l_cmd = 'a' OR (l_cmd = 'u' AND (g_apgb2_d[l_ac].apgc009 !=  g_apgb2_d_t.apgc009 OR  g_apgb2_d_t.apgc009 IS NULL)) THEN   #160822-00008#5 mark
                  CALL aapt510_apgc009_chk(l_ac)RETURNING g_sub_success,g_errno
                  IF NOT g_sub_success THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.extend = g_apgb2_d[l_ac].apgc009
                     LET g_errparam.code   = g_errno
                     LET g_errparam.popup  = TRUE
                     CALL cl_err()
                     #LET g_apgb2_d[l_ac].apgc009 = g_apgb2_d_t.apgc009  #160822-00008#5 mark
                     LET g_apgb2_d[l_ac].apgc009 = g_apgb2_d_o.apgc009   #160822-00008#5 add
                     NEXT FIELD CURRENT           
                  END IF
               END IF
               ELSE
               CALL cl_set_comp_entry('apgc010',TRUE)
            END IF
            
            #160428-00001#1 ---s---
            
            LET g_apgb2_d_o.* = g_apgb2_d[l_ac].*  #160822-00008#5 add
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apgc009
            #add-point:ON CHANGE apgc009 name="input.g.page2.apgc009"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apgc010
            #add-point:BEFORE FIELD apgc010 name="input.b.page2.apgc010"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apgc010
            
            #add-point:AFTER FIELD apgc010 name="input.a.page2.apgc010"
            LET g_apgb2_d_o.* = g_apgb2_d[l_ac].*  #160822-00008#5 add
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apgc010
            #add-point:ON CHANGE apgc010 name="input.g.page2.apgc010"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apgc103
            #add-point:BEFORE FIELD apgc103 name="input.b.page2.apgc103"
            #160428-00001#15-----s
            CALL s_tax_chk(g_apga_m.apgacomp,g_apgb2_d[l_ac].apgc006) RETURNING g_sub_success,l_oodb004,l_apca013,l_apca012,l_oodb011
            IF l_apca013 = 'Y' AND g_apgb2_d[l_ac].apgc103 = 0 AND g_apgb2_d[l_ac].apgc105 = 0 THEN
               NEXT FIELD apgc105
            END IF
            #160428-00001#15-----e
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apgc103
            
            #add-point:AFTER FIELD apgc103 name="input.a.page2.apgc103"
            LET l_ld = NULL   LET l_glaa001 = NULL
            SELECT glaald ,glaa001
              INTO l_ld,l_glaa001
              FROM glaa_t
             WHERE glaaent = g_enterprise
               AND glaacomp = g_apga_m.apgacomp
               AND glaa014 = 'Y'
                         
            #原幣未稅金額
            IF NOT cl_null(g_apgb2_d[l_ac].apgc103) THEN 
               IF g_apgb2_d[l_ac].apgc103 != g_apgb2_d_o.apgc103 OR g_apgb2_d_o.apgc103 IS NULL THEN  
                  CALL s_tax_chk(g_apga_m.apgacomp,g_apgb2_d[l_ac].apgc006) RETURNING g_sub_success,l_oodb004,l_apca013,l_apca012,l_oodb011
 
                  IF l_apca013 = 'N' THEN   #稅別未稅時修改未稅金額使用s_tax_ins   #seq2存變更序
                     CALL s_tax_ins(g_apga_m.apgadocno,g_apgb2_d[l_ac].apgcseq,'0',g_apgb2_d[l_ac].apgcorga,g_apgb2_d[l_ac].apgc103,
                                    g_apgb2_d[l_ac].apgc006,1,g_apgb2_d[l_ac].apgc100,g_apgb2_d[l_ac].apgc101,l_ld,1,1)
                          RETURNING g_apgb2_d[l_ac].apgc103,g_apgb2_d[l_ac].apgc104,g_apgb2_d[l_ac].apgc105,
                                    g_apgb2_d[l_ac].apgc113,g_apgb2_d[l_ac].apgc114,g_apgb2_d[l_ac].apgc115,
                                    l_dummy2,l_dummy2,l_dummy2,
                                    l_dummy3,l_dummy3,l_dummy3
                  #稅別含稅,修改未稅金额后使用公式反推稅額、計算本幣金額
                   ELSE
                      LET g_apgb2_d[l_ac].apgc104 = g_apgb2_d[l_ac].apgc105 - g_apgb2_d[l_ac].apgc103
                      LET g_apgb2_d[l_ac].apgc113 = g_apgb2_d[l_ac].apgc103 * g_apgb2_d[l_ac].apgc101
                      LET g_apgb2_d[l_ac].apgc113 = s_curr_round(g_apga_m.apgacomp,l_glaa001,g_apgb2_d[l_ac].apgc113,2)
                      LET g_apgb2_d[l_ac].apgc114 = g_apgb2_d[l_ac].apgc115 - g_apgb2_d[l_ac].apgc113   
                      UPDATE xrcd_t SET xrcd103 = g_apgb2_d[l_ac].apgc103,
                                        xrcd104 = g_apgb2_d[l_ac].apgc104,
                                        xrcd105 = g_apgb2_d[l_ac].apgc105,
                                        xrcd113 = g_apgb2_d[l_ac].apgc113,
                                        xrcd114 = g_apgb2_d[l_ac].apgc114,
                                        xrcd115 = g_apgb2_d[l_ac].apgc115
                       WHERE xrcdent   = g_enterprise
                         AND xrcddocno = g_apga_m.apgadocno
                         AND xrcdseq   = g_apgb2_d[l_ac].apgcseq
                         AND xrcdseq2  = 0
                         AND xrcdcomp  = g_apga_m.apgacomp                     
                  END IF
                  CALL aapt510_to_o_b2(l_ac)
                  DISPLAY BY NAME g_apgb2_d[l_ac].apgc103
               END IF
            END IF
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apgc103
            #add-point:ON CHANGE apgc103 name="input.g.page2.apgc103"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apgc104
            #add-point:BEFORE FIELD apgc104 name="input.b.page2.apgc104"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apgc104
            
            #add-point:AFTER FIELD apgc104 name="input.a.page2.apgc104"
            IF NOT cl_null(g_apgb2_d[l_ac].apgc104) THEN
               IF g_apgb2_d[l_ac].apgc104 != g_apgb2_d_o.apgc104 OR g_apgb2_d_o.apgc104 IS NULL THEN 
                  CALL s_tax_chk(g_apga_m.apgacomp,g_apgb2_d[l_ac].apgc006) RETURNING g_sub_success,l_oodb004,l_apca013,l_apca012,l_oodb011
                  IF l_apca013 = 'Y' THEN
                     LET g_apgb2_d[l_ac].apgc103 = g_apgb2_d[l_ac].apgc105 - g_apgb2_d[l_ac].apgc104
                     LET g_apgb2_d[l_ac].apgc114 = g_apgb2_d[l_ac].apgc104 * g_apgb2_d[l_ac].apgc101  
                     LET g_apgb2_d[l_ac].apgc114 = s_curr_round(g_apga_m.apgacomp,l_glaa001,g_apgb2_d[l_ac].apgc114,2)
                     LET g_apgb2_d[l_ac].apgc113 = g_apgb2_d[l_ac].apgc115 - g_apgb2_d[l_ac].apgc114
                  ELSE
                     LET g_apgb2_d[l_ac].apgc105 = g_apgb2_d[l_ac].apgc103 + g_apgb2_d[l_ac].apgc104
                     LET g_apgb2_d[l_ac].apgc114 = g_apgb2_d[l_ac].apgc104 * g_apgb2_d[l_ac].apgc101  
                     LET g_apgb2_d[l_ac].apgc114 = s_curr_round(g_apga_m.apgacomp,l_glaa001,g_apgb2_d[l_ac].apgc114,2)
                     LET g_apgb2_d[l_ac].apgc115 = g_apgb2_d[l_ac].apgc113 + g_apgb2_d[l_ac].apgc114
                  END IF
                  UPDATE xrcd_t SET xrcd103 = g_apgb2_d[l_ac].apgc103,
                                    xrcd104 = g_apgb2_d[l_ac].apgc104,
                                    xrcd105 = g_apgb2_d[l_ac].apgc105,
                                    xrcd113 = g_apgb2_d[l_ac].apgc113,
                                    xrcd114 = g_apgb2_d[l_ac].apgc114,
                                    xrcd115 = g_apgb2_d[l_ac].apgc115
                   WHERE xrcdent   = g_enterprise
                     AND xrcddocno = g_apga_m.apgadocno
                     AND xrcdseq   = g_apgb2_d[l_ac].apgcseq
                     AND xrcdseq2  = 0
                     AND xrcdcomp  = g_apga_m.apgacomp
                  CALL aapt510_to_o_b2(l_ac) 
                  DISPLAY BY NAME g_apgb2_d[l_ac].apgc104                  
               END IF
            END IF
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apgc104
            #add-point:ON CHANGE apgc104 name="input.g.page2.apgc104"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apgc105
            #add-point:BEFORE FIELD apgc105 name="input.b.page2.apgc105"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apgc105
            
            #add-point:AFTER FIELD apgc105 name="input.a.page2.apgc105"
            IF NOT cl_null(g_apgb2_d[l_ac].apgc105) THEN 
               IF g_apgb2_d[l_ac].apgc105 != g_apgb2_d_o.apgc105 OR g_apgb2_d_o.apgc105 IS NULL THEN
                  CALL s_tax_chk(g_apga_m.apgacomp,g_apgb2_d[l_ac].apgc006) RETURNING g_sub_success,l_oodb004,l_apca013,l_apca012,l_oodb011
                  IF l_apca013 = 'Y' THEN   
                     CALL s_tax_ins(g_apga_m.apgadocno,g_apgb2_d[l_ac].apgcseq,'0',g_apgb2_d[l_ac].apgcorga,g_apgb2_d[l_ac].apgc105,
                                    g_apgb2_d[l_ac].apgc006,1,g_apgb2_d[l_ac].apgc100,g_apgb2_d[l_ac].apgc101,l_ld,1,1)
                          RETURNING g_apgb2_d[l_ac].apgc103,g_apgb2_d[l_ac].apgc104,g_apgb2_d[l_ac].apgc105,
                                    g_apgb2_d[l_ac].apgc113,g_apgb2_d[l_ac].apgc114,g_apgb2_d[l_ac].apgc115,
                                    l_dummy2,l_dummy2,l_dummy2,
                                    l_dummy3,l_dummy3,l_dummy3
                  ELSE
                     LET g_apgb2_d[l_ac].apgc104 = g_apgb2_d[l_ac].apgc105 - g_apgb2_d[l_ac].apgc103
                     LET g_apgb2_d[l_ac].apgc115 = g_apgb2_d[l_ac].apgc105 * g_apgb2_d[l_ac].apgc101
                     LET g_apgb2_d[l_ac].apgc115 = s_curr_round(g_apga_m.apgacomp,l_glaa001,g_apgb2_d[l_ac].apgc115,2)
                     LET g_apgb2_d[l_ac].apgc114 = g_apgb2_d[l_ac].apgc115 - g_apgb2_d[l_ac].apgc113                       

                     UPDATE xrcd_t SET xrcd103 = g_apgb2_d[l_ac].apgc103,
                                       xrcd104 = g_apgb2_d[l_ac].apgc104,
                                       xrcd105 = g_apgb2_d[l_ac].apgc105,
                                       xrcd113 = g_apgb2_d[l_ac].apgc113,
                                       xrcd114 = g_apgb2_d[l_ac].apgc114,
                                       xrcd115 = g_apgb2_d[l_ac].apgc115
                      WHERE xrcdent   = g_enterprise
                        AND xrcddocno = g_apga_m.apgadocno
                        AND xrcdseq   = g_apgb2_d[l_ac].apgcseq
                        AND xrcdseq2  = 0
                        AND xrcdcomp  = g_apga_m.apgacomp 
                  END IF
                  CALL aapt510_to_o_b2(l_ac)
                  DISPLAY BY NAME g_apgb2_d[l_ac].apgc105
               END IF
            END IF
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apgc105
            #add-point:ON CHANGE apgc105 name="input.g.page2.apgc105"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apgc113
            #add-point:BEFORE FIELD apgc113 name="input.b.page2.apgc113"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apgc113
            
            #add-point:AFTER FIELD apgc113 name="input.a.page2.apgc113"
            IF NOT cl_null(g_apgb2_d[l_ac].apgc113) THEN
               IF g_apgb2_d[l_ac].apgc113 != g_apgb2_d_o.apgc113 OR g_apgb2_d_o.apgc113 IS NULL THEN  
                  CALL s_tax_chk(g_apga_m.apgacomp,g_apgb2_d[l_ac].apgc006) RETURNING g_sub_success,l_oodb004,l_apca013,l_apca012,l_oodb011
                  IF g_apgb2_d[l_ac].apgc113 = 0 THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = 'axr-00047'
                     LET g_errparam.extend = g_apgb2_d[l_ac].apgc113
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                     NEXT FIELD CURRENT
                  END IF
                  IF l_apca013 = 'Y' THEN
                     LET g_apgb2_d[l_ac].apgc114 = g_apgb2_d[l_ac].apgc115 - g_apgb2_d[l_ac].apgc113
                  ELSE
                     LET g_apgb2_d[l_ac].apgc115 = g_apgb2_d[l_ac].apgc113 + g_apgb2_d[l_ac].apgc114
                  END IF
                  UPDATE xrcd_t SET xrcd113 = g_apgb2_d[l_ac].apgc113,
                                    xrcd114 = g_apgb2_d[l_ac].apgc114,
                                    xrcd115 = g_apgb2_d[l_ac].apgc115
                   WHERE xrcdent   = g_enterprise
                     AND xrcddocno = g_apga_m.apgadocno
                     AND xrcdseq   = g_apgb2_d[l_ac].apgcseq
                     AND xrcdcomp  = g_apga_m.apgacomp
                     AND xrcdseq2  = 0
                     
                   CALL aapt510_to_o_b2(l_ac)
                   DISPLAY BY NAME g_apgb2_d[l_ac].apgc113
                     
#                  #稅別為含稅則可維護含稅金額, 反之可維護未稅金額
#
#                  #2.以含稅金額重計匯率 
#                  LET g_apcb_d[l_ac].apcb115 = g_apcb_d[l_ac].apcb113 + g_apcb_d[l_ac].apcb114  #本幣含稅金額
#                  LET g_apcb_d[l_ac].apcb102 = g_apcb_d[l_ac].apcb115 / g_apcb_d[l_ac].apcb105  #匯率        
               END IF
            END IF
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apgc113
            #add-point:ON CHANGE apgc113 name="input.g.page2.apgc113"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apgc114
            #add-point:BEFORE FIELD apgc114 name="input.b.page2.apgc114"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apgc114
            
            #add-point:AFTER FIELD apgc114 name="input.a.page2.apgc114"
            IF NOT cl_null(g_apgb2_d[l_ac].apgc114) THEN
               IF g_apgb2_d[l_ac].apgc114 != g_apgb2_d_o.apgc114 OR g_apgb2_d_o.apgc114 IS NULL THEN  
                  CALL s_tax_chk(g_apga_m.apgacomp,g_apgb2_d[l_ac].apgc006) RETURNING g_sub_success,l_oodb004,l_apca013,l_apca012,l_oodb011               
                  IF l_apca013 = 'Y' THEN
                     LET g_apgb2_d[l_ac].apgc113 = g_apgb2_d[l_ac].apgc115 - g_apgb2_d[l_ac].apgc114
                  ELSE
                     LET g_apgb2_d[l_ac].apgc115 = g_apgb2_d[l_ac].apgc113 + g_apgb2_d[l_ac].apgc114
                  END IF
                  UPDATE xrcd_t SET xrcd113 = g_apgb2_d[l_ac].apgc113,
                                    xrcd114 = g_apgb2_d[l_ac].apgc114,
                                    xrcd115 = g_apgb2_d[l_ac].apgc115
                   WHERE xrcdent   = g_enterprise
                     AND xrcddocno = g_apga_m.apgadocno
                     AND xrcdseq   = g_apgb2_d[l_ac].apgcseq
                     AND xrcdcomp  = g_apga_m.apgacomp
                     AND xrcdseq2  = 0
                  CALL aapt510_to_o_b2(l_ac)
                  DISPLAY BY NAME g_apgb2_d[l_ac].apgc114                  
               END IF
            END IF
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apgc114
            #add-point:ON CHANGE apgc114 name="input.g.page2.apgc114"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apgc115
            #add-point:BEFORE FIELD apgc115 name="input.b.page2.apgc115"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apgc115
            
            #add-point:AFTER FIELD apgc115 name="input.a.page2.apgc115"
            IF NOT cl_null(g_apgb2_d[l_ac].apgc115) THEN
               IF g_apgb2_d[l_ac].apgc115 != g_apgb2_d_o.apgc115 OR g_apgb2_d_o.apgc115 IS NULL THEN 
                  CALL s_tax_chk(g_apga_m.apgacomp,g_apgb2_d[l_ac].apgc006) RETURNING g_sub_success,l_oodb004,l_apca013,l_apca012,l_oodb011                              
                  IF g_apgb2_d[l_ac].apgc115 = 0 THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = 'axr-00047'
                     LET g_errparam.extend = g_apgb2_d[l_ac].apgc115
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                     NEXT FIELD CURRENT
                  END IF
                  IF l_apca013 = 'Y' THEN
                     LET g_apgb2_d[l_ac].apgc113 = g_apgb2_d[l_ac].apgc115 - g_apgb2_d[l_ac].apgc114  
                  ELSE
                     LET g_apgb2_d[l_ac].apgc114 = g_apgb2_d[l_ac].apgc115 - g_apgb2_d[l_ac].apgc113  
                  END IF
                  UPDATE xrcd_t SET xrcd113 = g_apgb2_d[l_ac].apgc113,
                                    xrcd114 = g_apgb2_d[l_ac].apgc114,
                                    xrcd115 = g_apgb2_d[l_ac].apgc115
                   WHERE xrcdent   = g_enterprise
                     AND xrcddocno = g_apga_m.apgadocno
                     AND xrcdseq   = g_apgb2_d[l_ac].apgcseq
                     AND xrcdseq2  = 0
                     AND xrcdcomp  = g_apga_m.apgacomp
                     
                   CALL aapt510_to_o_b2(l_ac)
                   DISPLAY BY NAME g_apgb2_d[l_ac].apgc115
#                  #稅別為含稅則可維護含稅金額, 反之可維護未稅金額
#                  #1.本幣單價=本幣金額(視含稅未稅否) /數量
#                  #2.以含稅金額重計匯率 
#                  LET g_apcb_d[l_ac].apcb113 = g_apcb_d[l_ac].apcb115 - g_apcb_d[l_ac].apcb114          #本幣未稅金額
#                  LET g_apcb_d[l_ac].apcb102 = g_apcb_d[l_ac].apcb115 / g_apcb_d[l_ac].apcb105          #匯率
               END IF       
            END IF
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apgc115
            #add-point:ON CHANGE apgc115 name="input.g.page2.apgc115"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apgc004
            
            #add-point:AFTER FIELD apgc004 name="input.a.page2.apgc004"
            LET l_ld = NULL
            SELECT glaald INTO l_ld FROM glaa_t
             WHERE glaaent = g_enterprise
               AND glaacomp = g_apga_m.apgacomp
               AND glaa014 = 'Y'
            IF NOT cl_null(g_apgb2_d[l_ac].apgc004)THEN
               IF g_apgb2_d[l_ac].apgc004 != g_apgb2_d_o.apgc004 OR cl_null(g_apgb2_d_o.apgc004) THEN       #160822-00008#5 add
               #IF g_apgb2_d[l_ac].apgc004 != g_apgb2_d_t.apgc004 OR g_apgb2_d_t.apgc004 IS NULL THEN       #160822-00008#5 mark
                  CALL s_aap_glac002_chk(g_apgb2_d[l_ac].apgc004,l_ld) RETURNING g_sub_success,g_errno
                  IF NOT g_sub_success THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = g_errno
                     #160321-00016#22 --s add
                     LET g_errparam.replace[1] = 'agli020'
                     LET g_errparam.replace[2] = cl_get_progname('agli020',g_lang,"2")
                     LET g_errparam.exeprog = 'agli020'
                     #160321-00016#22 --e add
                     LET g_errparam.extend = ''
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                
                     #LET g_apgb2_d[l_ac].apgc004 = g_apgb2_d_t.apgc004  #160822-00008#5 mark
                     LET g_apgb2_d[l_ac].apgc004 = g_apgb2_d_o.apgc004   #160822-00008#5 add
                     CALL s_desc_get_account_desc(l_ld,g_apgb2_d[l_ac].apgc004) RETURNING g_apgb2_d[l_ac].apgc004_desc
                     DISPLAY BY NAME g_apgb2_d[l_ac].apgc004_desc
                     NEXT FIELD CURRENT
                  END IF                
               END IF
            END IF
            CALL s_desc_get_account_desc(l_ld,g_apgb2_d[l_ac].apgc004) RETURNING g_apgb2_d[l_ac].apgc004_desc
            DISPLAY BY NAME g_apgb2_d[l_ac].apgc004_desc
            
            LET g_apgb2_d_o.* = g_apgb2_d[l_ac].*  #160822-00008#5 add
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apgc004
            #add-point:BEFORE FIELD apgc004 name="input.b.page2.apgc004"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apgc004
            #add-point:ON CHANGE apgc004 name="input.g.page2.apgc004"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apgc004_desc
            #add-point:BEFORE FIELD apgc004_desc name="input.b.page2.apgc004_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apgc004_desc
            
            #add-point:AFTER FIELD apgc004_desc name="input.a.page2.apgc004_desc"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apgc004_desc
            #add-point:ON CHANGE apgc004_desc name="input.g.page2.apgc004_desc"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apgc015
            
            #add-point:AFTER FIELD apgc015 name="input.a.page2.apgc015"
            LET g_apgb2_d[l_ac].apgc015_desc = ''
            LET g_apgb2_d[l_ac].apgc016_desc = ''
            DISPLAY BY NAME g_apgb2_d[l_ac].apgc015_desc,g_apgb2_d[l_ac].apgc016_desc
            IF NOT cl_null(g_apgb2_d[l_ac].apgc015) THEN
               IF g_apgb2_d[l_ac].apgc015 != g_apgb2_d_o.apgc015 OR cl_null(g_apgb2_d_o.apgc015) THEN                                       #160822-00008#5 add
               #IF l_cmd = 'a' OR (l_cmd = 'u' AND (g_apgb2_d[l_ac].apgc015 !=  g_apgb2_d_t.apgc015 OR  g_apgb2_d_t.apgc015 IS NULL)) THEN  #160822-00008#5 mark
                  INITIALIZE g_chkparam.* TO NULL
                  LET g_chkparam.arg1 = g_apgb2_d[l_ac].apgc015
                  LET g_chkparam.arg2 = 2
                  LET g_errshow = TRUE
                  #160318-00025#24  by 07900 --add-str
                  LET g_errshow = TRUE #是否開窗                   
                  LET g_chkparam.err_str[1] ="aap-00002:sub-01302|aapi010|",cl_get_progname("aapi010",g_lang,"2"),"|:EXEPROGaapi010"
                  #160318-00025#24  by 07900 --add-end
                  IF NOT cl_chk_exist("v_nmaj001_1") THEN
                     LET l_glaa005 = NULL
                     SELECT glaa005 INTO l_glaa005 FROM glaa_t
                      WHERE glaaent = g_enterprise
                        AND glaacomp = g_agpa_m.apgacomp
                        AND glaa014  = 'Y'
                     #檢查失敗時後續處理
                     #LET g_apgb2_d[l_ac].apgc015 = g_apgb2_d_t.apgc015   #160822-00008#5 mark
                     LET g_apgb2_d[l_ac].apgc015 = g_apgb2_d_o.apgc015    #160822-00008#5 add
                     LET g_apgb2_d[l_ac].apgc016 = s_anm_get_nmad003(l_glaa005,g_apgb2_d[l_ac].apgc015)
                     DISPLAY BY NAME g_apgb2_d[l_ac].apgc015,g_apgb2_d[l_ac].apgc016
                     LET g_apgb2_d[l_ac].apgc015_desc = s_desc_get_nmajl003_desc(g_apgb2_d[l_ac].apgc015)
                     LET g_apgb2_d[l_ac].apgc016_desc = s_desc_get_nmail004_desc(l_glaa005,g_apgb2_d[l_ac].apgc016)
                     DISPLAY BY NAME g_apgb2_d[l_ac].apgc016_desc,g_apgb2_d[l_ac].apgc015_desc
                     NEXT FIELD CURRENT
                  END IF
               END IF
               LET l_glaa005 = NULL
               SELECT glaa005 INTO l_glaa005 FROM glaa_t
                WHERE glaaent = g_enterprise
                  AND glaacomp = g_apga_m.apgacomp
                  AND glaa014 = 'Y'
               LET g_apgb2_d[l_ac].apgc016 = s_anm_get_nmad003(l_glaa005,g_apgb2_d[l_ac].apgc015)
               DISPLAY BY NAME g_apgb2_d[l_ac].apgc016
               LET g_apgb2_d[l_ac].apgc015_desc = s_desc_get_nmajl003_desc(g_apgb2_d[l_ac].apgc015)
               LET g_apgb2_d[l_ac].apgc016_desc = s_desc_get_nmail004_desc(l_glaa005,g_apgb2_d[l_ac].apgc016)
               DISPLAY BY NAME g_apgb2_d[l_ac].apgc016_desc,g_apgb2_d[l_ac].apgc015_desc
            END IF
            LET g_apgb2_d_o.* = g_apgb2_d[l_ac].*  #160822-00008#5 add
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apgc015
            #add-point:BEFORE FIELD apgc015 name="input.b.page2.apgc015"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apgc015
            #add-point:ON CHANGE apgc015 name="input.g.page2.apgc015"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apgc015_desc
            #add-point:BEFORE FIELD apgc015_desc name="input.b.page2.apgc015_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apgc015_desc
            
            #add-point:AFTER FIELD apgc015_desc name="input.a.page2.apgc015_desc"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apgc015_desc
            #add-point:ON CHANGE apgc015_desc name="input.g.page2.apgc015_desc"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apgc016
            
            #add-point:AFTER FIELD apgc016 name="input.a.page2.apgc016"
            LET g_apgb2_d[l_ac].apgc016_desc =''
            DISPLAY BY NAME g_apgb2_d[l_ac].apgc016_desc
            IF NOT cl_null(g_apgb2_d[l_ac].apgc016) THEN
               IF g_apgb2_d[l_ac].apgc016 != g_apgb2_d_o.apgc016 OR cl_null(g_apgb2_d_o.apgc016) THEN                                       #160822-00008#5 add
               #IF l_cmd = 'a' OR (l_cmd = 'u' AND (g_apgb2_d[l_ac].apgc016 != g_apgb2_d_t.apgc016 OR g_apgb2_d_t.apgc016 IS NULL )) THEN   #160822-00008#5 mark
                  LET l_glaa005 = NULL
                  SELECT glaa005 INTO l_glaa005 FROM glaa_t
                   WHERE glaaent = g_enterprise
                     AND glaacomp = g_apga_m.apgacomp
                     AND glaa014 = 'Y'
                  #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
                  INITIALIZE g_chkparam.* TO NULL
                  #設定g_chkparam.*的參數
                  LET g_chkparam.arg1 = g_apgb2_d[l_ac].apgc016
                  LET g_chkparam.arg2 = l_glaa005
                  LET g_errshow = TRUE
                  #呼叫檢查存在並帶值的library
                  IF NOT cl_chk_exist("v_nmai002") THEN
                     #檢查失敗時後續處
                     #LET g_apgb2_d[l_ac].apgc016 = g_apgb2_d_t.apgc016 #160822-00008#5 mark
                     LET g_apgb2_d[l_ac].apgc016 = g_apgb2_d_o.apgc016  #160822-00008#5 add
                     LET g_apgb2_d[l_ac].apgc016_desc = s_desc_get_nmail004_desc(l_glaa005,g_apgb2_d[l_ac].apgc016)
                     DISPLAY BY NAME g_apgb2_d[l_ac].apgc016_desc
                     NEXT FIELD CURRENT
                  END IF
               END IF
    
               LET l_glaa005 = NULL
               SELECT glaa005 INTO l_glaa005 FROM glaa_t
                WHERE glaaent = g_enterprise
                  AND glaacomp  = g_apga_m.apgacomp
                  AND glaa014   = 'Y'
               LET g_apgb2_d[l_ac].apgc016_desc = s_desc_get_nmail004_desc(l_glaa005,g_apgb2_d[l_ac].apgc016)
               DISPLAY BY NAME g_apgb2_d[l_ac].apgc016_desc
            END IF
            LET l_glaa005 = NULL
            SELECT glaa005 INTO l_glaa005 FROM glaa_t
             WHERE glaaent = g_enterprise
               AND glaacomp  = g_apga_m.apgacomp
               AND glaa014   = 'Y'
            LET g_apgb2_d[l_ac].apgc016_desc = s_desc_get_nmail004_desc(l_glaa005,g_apgb2_d[l_ac].apgc016)
            DISPLAY BY NAME g_apgb2_d[l_ac].apgc016_desc
            LET g_apgb2_d_o.* = g_apgb2_d[l_ac].*  #160822-00008#5 add
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apgc016
            #add-point:BEFORE FIELD apgc016 name="input.b.page2.apgc016"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apgc016
            #add-point:ON CHANGE apgc016 name="input.g.page2.apgc016"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apgc016_desc
            #add-point:BEFORE FIELD apgc016_desc name="input.b.page2.apgc016_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apgc016_desc
            
            #add-point:AFTER FIELD apgc016_desc name="input.a.page2.apgc016_desc"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apgc016_desc
            #add-point:ON CHANGE apgc016_desc name="input.g.page2.apgc016_desc"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apgc012
            #add-point:BEFORE FIELD apgc012 name="input.b.page2.apgc012"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apgc012
            
            #add-point:AFTER FIELD apgc012 name="input.a.page2.apgc012"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apgc012
            #add-point:ON CHANGE apgc012 name="input.g.page2.apgc012"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apgc013
            #add-point:BEFORE FIELD apgc013 name="input.b.page2.apgc013"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apgc013
            
            #add-point:AFTER FIELD apgc013 name="input.a.page2.apgc013"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apgc013
            #add-point:ON CHANGE apgc013 name="input.g.page2.apgc013"
            
            #END add-point 
 
 
 
                  #Ctrlp:input.c.page2.apgc900
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apgc900
            #add-point:ON ACTION controlp INFIELD apgc900 name="input.c.page2.apgc900"
            
            #END add-point
 
 
         #Ctrlp:input.c.page2.apgcseq
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apgcseq
            #add-point:ON ACTION controlp INFIELD apgcseq name="input.c.page2.apgcseq"
            
            #END add-point
 
 
         #Ctrlp:input.c.page2.apgcorga
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apgcorga
            #add-point:ON ACTION controlp INFIELD apgcorga name="input.c.page2.apgcorga"
            #來源組織
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
		      LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_apgb2_d[l_ac].apgcorga
            LET g_qryparam.where    = "ooef001 IN ",g_wc_apgborga, 
                                      " AND ooef017 ='",g_apga_m.apgacomp,"' ",
                                      " AND ooef201 = 'Y'"   #161006-00005#5   add
            CALL q_ooef001()                                 
            LET g_apgb2_d[l_ac].apgcorga = g_qryparam.return1            
            DISPLAY BY NAME g_apgb2_d[l_ac].apgcorga
            NEXT FIELD apgcorga
            #END add-point
 
 
         #Ctrlp:input.c.page2.apgc001
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apgc001
            #add-point:ON ACTION controlp INFIELD apgc001 name="input.c.page2.apgc001"
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.arg1 = '3117'
            LET g_qryparam.default1 = g_apgb2_d[l_ac].apgc001
            CALL q_oocq002()
            LET g_apgb2_d[l_ac].apgc001 = g_qryparam.return1
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_apgb2_d[l_ac].apgc001
            CALL ap_ref_array2(g_ref_fields,"SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001='3117' AND oocql002=? AND oocql003='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_apgb2_d[l_ac].apgc001_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_apgb2_d[l_ac].apgc001_desc
            DISPLAY BY NAME g_apgb2_d[l_ac].apgc001
            NEXT FIELD apgc001
            #END add-point
 
 
         #Ctrlp:input.c.page2.apgc002
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apgc002
            #add-point:ON ACTION controlp INFIELD apgc002 name="input.c.page2.apgc002"
            
            #END add-point
 
 
         #Ctrlp:input.c.page2.apgc003
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apgc003
            #add-point:ON ACTION controlp INFIELD apgc003 name="input.c.page2.apgc003"
            
            #END add-point
 
 
         #Ctrlp:input.c.page2.apgc005
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apgc005
            #add-point:ON ACTION controlp INFIELD apgc005 name="input.c.page2.apgc005"
            
            #END add-point
 
 
         #Ctrlp:input.c.page2.apgc014
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apgc014
            #add-point:ON ACTION controlp INFIELD apgc014 name="input.c.page2.apgc014"
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_apgb2_d[l_ac].apgc014
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_apgb2_d[l_ac].apgc014
            LET g_qryparam.where = " nmaa002 IN (SELECT ooef001 FROM ooef_t WHERE ooefent = ",g_enterprise," ",
                                   "              AND ooef017 = '",g_apga_m.apgacomp,"')",
                                   " AND EXISTS(SELECT 1 FROM nmag_t WHERE nmag001 = nmaa003 ",
                                   " AND nmagent = nmaaent ",   #160905-00002#3 add
                                   " AND nmag002 IN ('1','5'))",
                                  #" AND nmas002 IN (SELECT nmll001 FROM nmll_t WHERE nmllent=",g_enterprise, " AND nmll002 = '",g_user,"')"  #161226-00048#1 mark
                                   #161226-00048#1 add (S)
                                   " AND ( nmas002 IN (SELECT nmll001 FROM nmll_t WHERE nmllent=",g_enterprise, " AND nmll002 = '",g_user,"')",
                                   "  OR nmas002 IN (SELECT nmlm001 FROM nmlm_t WHERE nmlment=",g_enterprise, " AND nmlm002 = '",g_dept,"') )"
                                   #161226-00048#1 add (E)
            CALL q_nmas_01()                             
            LET g_apgb2_d[l_ac].apgc014 = g_qryparam.return1
            LET g_apgb2_d[l_ac].apgc100 = s_anm_get_nmas003(g_apgb2_d[l_ac].apgc014)
            DISPLAY BY NAME g_apgb2_d[l_ac].apgc100,g_apgb2_d[l_ac].apgc014
            NEXT FIELD apgc014              
            #END add-point
 
 
         #Ctrlp:input.c.page2.apgc100
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apgc100
            #add-point:ON ACTION controlp INFIELD apgc100 name="input.c.page2.apgc100"
            
            #END add-point
 
 
         #Ctrlp:input.c.page2.apgc101
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apgc101
            #add-point:ON ACTION controlp INFIELD apgc101 name="input.c.page2.apgc101"
            
            #END add-point
 
 
         #Ctrlp:input.c.page2.apgc006
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apgc006
            #add-point:ON ACTION controlp INFIELD apgc006 name="input.c.page2.apgc006"
            LET l_ooef019 = NULL
            SELECT ooef019 INTO l_ooef019 FROM ooef_t
             WHERE ooefent = g_enterprise
               AND ooef001 = g_apga_m.apgacomp
            #稅別
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_apgb2_d[l_ac].apgc006
            LET g_qryparam.arg1 = l_ooef019   
            CALL q_oodb002_5()
            LET g_apgb2_d[l_ac].apgc006 = g_qryparam.return1
            NEXT FIELD apgc006
            #END add-point
 
 
         #Ctrlp:input.c.page2.apgc007
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apgc007
            #add-point:ON ACTION controlp INFIELD apgc007 name="input.c.page2.apgc007"
            LET l_ooef019 = NULL
            SELECT ooef019 INTO l_ooef019 FROM ooef_t
             WHERE ooefent = g_enterprise
               AND ooef001 = g_apga_m.apgacomp   
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_apgb2_d[l_ac].apgc007
            LET g_qryparam.where = " isac003 IN ('1','3') AND isac001 = '",l_ooef019,"' "
            CALL q_isac002()
            LET g_apgb2_d[l_ac].apgc007 = g_qryparam.return1
            DISPLAY BY NAME g_apgb2_d[l_ac].apgc007
            NEXT FIELD apgc007
            #END add-point
 
 
         #Ctrlp:input.c.page2.apgc008
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apgc008
            #add-point:ON ACTION controlp INFIELD apgc008 name="input.c.page2.apgc008"
            
            #END add-point
 
 
         #Ctrlp:input.c.page2.apgc009
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apgc009
            #add-point:ON ACTION controlp INFIELD apgc009 name="input.c.page2.apgc009"
            
            #END add-point
 
 
         #Ctrlp:input.c.page2.apgc010
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apgc010
            #add-point:ON ACTION controlp INFIELD apgc010 name="input.c.page2.apgc010"
            
            #END add-point
 
 
         #Ctrlp:input.c.page2.apgc103
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apgc103
            #add-point:ON ACTION controlp INFIELD apgc103 name="input.c.page2.apgc103"
            
            #END add-point
 
 
         #Ctrlp:input.c.page2.apgc104
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apgc104
            #add-point:ON ACTION controlp INFIELD apgc104 name="input.c.page2.apgc104"
            
            #END add-point
 
 
         #Ctrlp:input.c.page2.apgc105
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apgc105
            #add-point:ON ACTION controlp INFIELD apgc105 name="input.c.page2.apgc105"
            
            #END add-point
 
 
         #Ctrlp:input.c.page2.apgc113
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apgc113
            #add-point:ON ACTION controlp INFIELD apgc113 name="input.c.page2.apgc113"
            
            #END add-point
 
 
         #Ctrlp:input.c.page2.apgc114
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apgc114
            #add-point:ON ACTION controlp INFIELD apgc114 name="input.c.page2.apgc114"
            
            #END add-point
 
 
         #Ctrlp:input.c.page2.apgc115
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apgc115
            #add-point:ON ACTION controlp INFIELD apgc115 name="input.c.page2.apgc115"
            
            #END add-point
 
 
         #Ctrlp:input.c.page2.apgc004
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apgc004
            #add-point:ON ACTION controlp INFIELD apgc004 name="input.c.page2.apgc004"
    			LET l_ld = NULL   LET l_glaa004 = NULL
    			SELECT glaald,glaa004
    			  INTO l_ld,l_glaa004
    			  FROM glaa_t
    			 WHERE glaaent  = g_enterprise
    			   AND glaacomp = g_apga_m.apgacomp
    			   AND glaa014 = 'Y'
    			
    			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
			   LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_apgb2_d[l_ac].apgc004       
            LET g_qryparam.where = "glac001 = '",l_glaa004,"' AND  glac003 <>'1' ",
                                   " AND glac002 IN (SELECT glad001 FROM glad_t,glac_t WHERE glad001= glac002 ",
                                   "AND gladld='",l_ld,"' AND gladent='",g_enterprise,"'",
                                   " AND gladstus = 'Y' )" 
            CALL aglt310_04()                          
            LET g_apgb2_d[l_ac].apgc004 = g_qryparam.return1     
            CALL s_desc_get_account_desc(l_ld,g_apgb2_d[l_ac].apgc004) RETURNING g_apgb2_d[l_ac].apgc004_desc
            DISPLAY BY NAME g_apgb2_d[l_ac].apgc004_desc,g_apgb2_d[l_ac].apgc004
            NEXT FIELD apgc004                        
            #END add-point
 
 
         #Ctrlp:input.c.page2.apgc004_desc
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apgc004_desc
            #add-point:ON ACTION controlp INFIELD apgc004_desc name="input.c.page2.apgc004_desc"
            
            #END add-point
 
 
         #Ctrlp:input.c.page2.apgc015
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apgc015
            #add-point:ON ACTION controlp INFIELD apgc015 name="input.c.page2.apgc015"
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.where = " nmaj002 = '2' "   #提出
            LET g_qryparam.default1 = g_apgb2_d[l_ac].apgc015
            CALL q_nmaj001()                                       
            LET g_apgb2_d[l_ac].apgc015   = g_qryparam.return1

            LET l_glaa005 = NULL
            SELECT glaa005 INTO l_glaa005 FROM glaa_t
             WHERE glaaent  = g_enterprise
               AND glaacomp = g_apga_m.apgacomp
               AND glaa014  = 'Y'
            LET g_apgb2_d[l_ac].apgc016   = s_anm_get_nmad003(l_glaa005,g_apgb2_d[l_ac].apgc015)
            DISPLAY BY NAME g_apgb2_d[l_ac].apgc016 ,g_apgb2_d[l_ac].apgc015
            LET g_apgb2_d[l_ac].apgc015_desc = s_desc_get_nmajl003_desc(g_apgb2_d[l_ac].apgc015)
            LET g_apgb2_d[l_ac].apgc016_desc = s_desc_get_nmail004_desc(l_glaa005,g_apgb2_d[l_ac].apgc016)
            DISPLAY BY NAME g_apgb2_d[l_ac].apgc015_desc,g_apgb2_d[l_ac].apgc016_desc
            NEXT FIELD apgc015
            #END add-point
 
 
         #Ctrlp:input.c.page2.apgc015_desc
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apgc015_desc
            #add-point:ON ACTION controlp INFIELD apgc015_desc name="input.c.page2.apgc015_desc"
            
            #END add-point
 
 
         #Ctrlp:input.c.page2.apgc016
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apgc016
            #add-point:ON ACTION controlp INFIELD apgc016 name="input.c.page2.apgc016"
            LET l_glaa005 = NULL
            SELECT glaa005 INTO l_glaa005 FROM glaa_t
             WHERE glaaent  = g_enterprise
               AND glaacomp = g_apga_m.apgacomp
               AND glaa014  = 'Y'
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.where = " nmai001 = '",l_glaa005,"' "
            LET g_qryparam.default1 = g_apgb2_d[l_ac].apgc016
            CALL q_nmai002()                                  #呼叫開窗
            LET g_apgb2_d[l_ac].apgc016 = g_qryparam.return1
            DISPLAY BY NAME g_apgb2_d[l_ac].apgc016
            LET g_apgb2_d[l_ac].apgc016_desc = s_desc_get_nmail004_desc(l_glaa005,g_apgb2_d[l_ac].apgc016)
            DISPLAY BY NAME g_apgb2_d[l_ac].apgc016_desc
            NEXT FIELD apgc016
            #END add-point
 
 
         #Ctrlp:input.c.page2.apgc016_desc
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apgc016_desc
            #add-point:ON ACTION controlp INFIELD apgc016_desc name="input.c.page2.apgc016_desc"
            
            #END add-point
 
 
         #Ctrlp:input.c.page2.apgc012
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apgc012
            #add-point:ON ACTION controlp INFIELD apgc012 name="input.c.page2.apgc012"
            
            #END add-point
 
 
         #Ctrlp:input.c.page2.apgc013
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apgc013
            #add-point:ON ACTION controlp INFIELD apgc013 name="input.c.page2.apgc013"
            
            #END add-point
 
 
 
 
         AFTER ROW
            #add-point:單身page2 after_row name="input.body2.after_row"
            
            #end add-point
            LET l_ac = ARR_CURR()
            IF INT_FLAG THEN
               LET INT_FLAG = 0
               IF l_cmd = 'u' THEN
                  LET g_apgb2_d[l_ac].* = g_apgb2_d_t.*
               END IF
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code = 9001 
               LET g_errparam.popup = FALSE 
               CLOSE aapt510_bcl2
               CALL s_transaction_end('N','0')
               CALL cl_err()
               EXIT DIALOG 
            END IF
            
            #其他table進行unlock
            
            CALL aapt510_unlock_b("apgc_t","'2'")
            CALL s_transaction_end('Y','0')
            #add-point:單身page2 after_row2 name="input.body2.after_row2"
            
            #end add-point
 
         AFTER INPUT
            #add-point:input段after input  name="input.body2.after_input"
            
            #end add-point   
    
         ON ACTION controlo
            IF l_insert THEN
               LET li_reproduce = l_ac_t
               LET li_reproduce_target = l_ac
               LET g_apgb2_d[li_reproduce_target].* = g_apgb2_d[li_reproduce].*
 
               LET g_apgb2_d[li_reproduce_target].apgcseq = NULL
               LET g_apgb2_d[li_reproduce_target].apgc900 = NULL
            ELSE
               CALL FGL_SET_ARR_CURR(g_apgb2_d.getLength()+1)
               LET lb_reproduce = TRUE
               LET li_reproduce = l_ac
               LET li_reproduce_target = g_apgb2_d.getLength()+1
            END IF
            
      END INPUT
      INPUT ARRAY g_apgb3_d FROM s_detail3.*
         ATTRIBUTE(COUNT = g_rec_b,WITHOUT DEFAULTS, #MAXCOUNT = g_max_rec,
                 INSERT ROW = l_allow_insert, #此頁面insert功能由產生器控制, 手動之設定無效! 
 
                 DELETE ROW = l_allow_delete,
                 APPEND ROW = l_allow_insert)
                 
         #自訂ACTION(detail_input,page_3)
         
         
         BEFORE INPUT
            #add-point:資料輸入前 name="input.body3.before_input2"
            
            #end add-point
            IF g_insert = 'Y' AND NOT cl_null(g_insert) THEN 
              CALL FGL_SET_ARR_CURR(g_apgb3_d.getLength()+1) 
              LET g_insert = 'N' 
           END IF 
 
            CALL aapt510_b_fill()
            #如果一直都在單身1則控制筆數位置
            IF g_loc = 'd' AND g_rec_b != 0 THEN
               CALL FGL_SET_ARR_CURR(g_idx_group.getValue("'3',"))
            END IF
            LET g_loc = 'd'
            LET g_rec_b = g_apgb3_d.getLength()
            #add-point:資料輸入前 name="input.body3.before_input"
            
            #end add-point
            
         BEFORE INSERT
            IF s_transaction_chk("N",0) THEN
               CALL s_transaction_begin()
            END IF
            LET l_insert = TRUE
            LET l_n = ARR_COUNT()
            LET l_cmd = 'a'
            INITIALIZE g_apgb3_d[l_ac].* TO NULL 
            INITIALIZE g_apgb3_d_t.* TO NULL 
            INITIALIZE g_apgb3_d_o.* TO NULL 
            #公用欄位給值(單身3)
            
            #自定義預設值(單身3)
                  LET g_apgb3_d[l_ac].xrcd006 = "N"
      LET g_apgb3_d[l_ac].xrcd005 = "1"
 
            #add-point:modify段before備份 name="input.body3.insert.before_bak"
            
            #end add-point
            LET g_apgb3_d_t.* = g_apgb3_d[l_ac].*     #新輸入資料
            LET g_apgb3_d_o.* = g_apgb3_d[l_ac].*     #新輸入資料
            CALL cl_show_fld_cont()
            CALL aapt510_set_entry_b(l_cmd)
            #add-point:modify段after_set_entry_b name="input.body3.insert.after_set_entry_b"
            
            #end add-point
            CALL aapt510_set_no_entry_b(l_cmd)
            IF lb_reproduce THEN
               LET lb_reproduce = FALSE
               LET g_apgb3_d[li_reproduce_target].* = g_apgb3_d[li_reproduce].*
 
               LET g_apgb3_d[li_reproduce_target].xrcdld = NULL
               LET g_apgb3_d[li_reproduce_target].xrcdseq = NULL
               LET g_apgb3_d[li_reproduce_target].xrcdseq2 = NULL
               LET g_apgb3_d[li_reproduce_target].xrcd007 = NULL
            END IF
            
 
            #add-point:modify段before insert name="input.body3.before_insert"
            
            #end add-point  
 
         BEFORE ROW     
            #add-point:modify段before row2 name="input.body3.before_row2"
            
            #end add-point  
            LET l_insert = FALSE
            LET l_cmd = ''
            LET l_ac_t = l_ac 
            LET g_detail_idx_list[3] = l_ac
            LET l_ac = ARR_CURR()
            LET g_detail_idx = l_ac
            LET g_current_page = 3
              
            LET l_lock_sw = 'N'            #DEFAULT
            LET l_n = ARR_COUNT()
            DISPLAY l_ac TO FORMONLY.idx
         
            CALL s_transaction_begin()
            OPEN aapt510_cl USING g_enterprise,g_apga_m.apgacomp,g_apga_m.apgadocno
            IF SQLCA.SQLCODE THEN   #(ver:78)
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "OPEN aapt510_cl:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE   #(ver:78)
               LET g_errparam.popup = TRUE 
               CLOSE aapt510_cl
               CALL s_transaction_end('N','0')
               CALL cl_err()
               RETURN
            END IF
            
            LET g_rec_b = g_apgb3_d.getLength()
            
            IF g_rec_b >= l_ac 
               AND g_apgb3_d[l_ac].xrcdld IS NOT NULL
               AND g_apgb3_d[l_ac].xrcdseq IS NOT NULL
               AND g_apgb3_d[l_ac].xrcdseq2 IS NOT NULL
               AND g_apgb3_d[l_ac].xrcd007 IS NOT NULL
            THEN 
               LET l_cmd='u'
               LET g_apgb3_d_t.* = g_apgb3_d[l_ac].*  #BACKUP
               LET g_apgb3_d_o.* = g_apgb3_d[l_ac].*  #BACKUP
               CALL aapt510_set_entry_b(l_cmd)
               #add-point:modify段after_set_entry_b name="input.body3.after_set_entry_b"
               
               #end add-point  
               CALL aapt510_set_no_entry_b(l_cmd)
               IF NOT aapt510_lock_b("xrcd_t","'3'") THEN
                  LET l_lock_sw='Y'
               ELSE
                  FETCH aapt510_bcl3 INTO g_apgb3_d[l_ac].xrcdseq,g_apgb3_d[l_ac].xrcdseq2,g_apgb3_d[l_ac].xrcd007, 
                      g_apgb3_d[l_ac].xrcdld,g_apgb3_d[l_ac].xrcd002,g_apgb3_d[l_ac].xrcd003,g_apgb3_d[l_ac].xrcd006, 
                      g_apgb3_d[l_ac].xrcd005,g_apgb3_d[l_ac].xrcd102,g_apgb3_d[l_ac].xrcd103,g_apgb3_d[l_ac].xrcd104, 
                      g_apgb3_d[l_ac].xrcd105,g_apgb3_d[l_ac].xrcd113,g_apgb3_d[l_ac].xrcd114,g_apgb3_d[l_ac].xrcd115, 
                      g_apgb3_d[l_ac].xrcd123,g_apgb3_d[l_ac].xrcd124,g_apgb3_d[l_ac].xrcd125,g_apgb3_d[l_ac].xrcd133, 
                      g_apgb3_d[l_ac].xrcd134,g_apgb3_d[l_ac].xrcd135,g_apgb3_d[l_ac].xrcdorga,g_apgb3_d[l_ac].xrcd009, 
                      g_apgb3_d[l_ac].xrcd001,g_apgb3_d[l_ac].xrcd004,g_apgb3_d[l_ac].xrcd100,g_apgb3_d[l_ac].xrcd101, 
                      g_apgb3_d[l_ac].xrcd106,g_apgb3_d[l_ac].xrcd112,g_apgb3_d[l_ac].xrcd116,g_apgb3_d[l_ac].xrcd117, 
                      g_apgb3_d[l_ac].xrcd118,g_apgb3_d[l_ac].xrcd121,g_apgb3_d[l_ac].xrcd131,g_apgb3_d[l_ac].xrcdsite 
 
                  IF SQLCA.SQLCODE THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = SQLERRMESSAGE  
                     LET g_errparam.code = SQLCA.SQLCODE 
                     LET g_errparam.popup = TRUE 
                     CALL cl_err()
                     LET l_lock_sw = "Y"
                  END IF
                  
                  #遮罩相關處理
                  LET g_apgb3_d_mask_o[l_ac].* =  g_apgb3_d[l_ac].*
                  CALL aapt510_xrcd_t_mask()
                  LET g_apgb3_d_mask_n[l_ac].* =  g_apgb3_d[l_ac].*
                  
                  LET g_bfill = "N"
                  CALL aapt510_show()
                  LET g_bfill = "Y"
                  
                  CALL cl_show_fld_cont()
               END IF
            ELSE
               LET l_cmd='a'
            END IF
            #add-point:modify段before row name="input.body3.before_row"
           
            #end add-point  
            #其他table資料備份(確定是否更改用)
            
 
            #其他table進行lock
            
 
            
         BEFORE DELETE                            #是否取消單身
            IF l_cmd = 'a' THEN
               LET l_cmd='d'
               #add-point:單身AFTER DELETE (=d) name="input.body3.after_delete_d"
               
               #end add-point
            ELSE
               #add-point:單身刪除前 name="input.body3.b_delete_ask"
               
               #end add-point 
               IF NOT cl_ask_del_detail() THEN
                  CANCEL DELETE
               END IF
               IF l_lock_sw = "Y" THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "" 
                  LET g_errparam.code = -263 
                  LET g_errparam.popup = TRUE 
                  CALL cl_err()
                  CANCEL DELETE
               END IF
               
               #add-point:單身3刪除前 name="input.body3.b_delete"
               
               #end add-point    
                  
               #取得該筆資料key值
               INITIALIZE gs_keys TO NULL
               LET gs_keys[01] = g_apga_m.apgacomp
               LET gs_keys[gs_keys.getLength()+1] = g_apga_m.apgadocno
               LET gs_keys[gs_keys.getLength()+1] = g_apgb3_d_t.xrcdld
               LET gs_keys[gs_keys.getLength()+1] = g_apgb3_d_t.xrcdseq
               LET gs_keys[gs_keys.getLength()+1] = g_apgb3_d_t.xrcdseq2
               LET gs_keys[gs_keys.getLength()+1] = g_apgb3_d_t.xrcd007
            
               #刪除同層單身
               IF NOT aapt510_delete_b('xrcd_t',gs_keys,"'3'") THEN
                  CALL s_transaction_end('N','0')
                  CLOSE aapt510_bcl
                  CANCEL DELETE
               END IF
    
               #刪除下層單身
               IF NOT aapt510_key_delete_b(gs_keys,'xrcd_t') THEN
                  CALL s_transaction_end('N','0')
                  CLOSE aapt510_bcl
                  CANCEL DELETE
               END IF
               
               #刪除多語言
               
 
               
               #add-point:單身3刪除中 name="input.body3.m_delete"
               
               #end add-point    
               
               CALL s_transaction_end('Y','0')
               CLOSE aapt510_bcl
 
               LET g_rec_b = g_rec_b-1
               #add-point:單身3刪除後 name="input.body3.a_delete"
               
               #end add-point
               LET l_count = g_apgb_d.getLength()
               
               #add-point:單身刪除後(<>d) name="input.body3.after_delete"
               
               #end add-point
            END IF 
 
         AFTER DELETE
            #如果是最後一筆
            IF l_ac = (g_apgb3_d.getLength() + 1) THEN
               CALL FGL_SET_ARR_CURR(l_ac-1)
            END IF
 
         AFTER INSERT    
            LET l_insert = FALSE
            IF INT_FLAG THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code = 9001 
               LET g_errparam.popup = FALSE 
               CALL cl_err()
               LET INT_FLAG = 0
               CANCEL INSERT
            END IF
               
            #add-point:單身3新增前 name="input.body3.b_a_insert"
            
            #end add-point
               
            LET l_count = 1  
            SELECT COUNT(1) INTO l_count FROM xrcd_t 
             WHERE xrcdent = g_enterprise AND xrcdcomp = g_apga_m.apgacomp
               AND xrcddocno = g_apga_m.apgadocno
               AND xrcdld = g_apgb3_d[l_ac].xrcdld
               AND xrcdseq = g_apgb3_d[l_ac].xrcdseq
               AND xrcdseq2 = g_apgb3_d[l_ac].xrcdseq2
               AND xrcd007 = g_apgb3_d[l_ac].xrcd007
                
            #資料未重複, 插入新增資料
            IF l_count = 0 THEN 
               #add-point:單身3新增前 name="input.body3.b_insert"
               
               #end add-point
            
                              INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_apga_m.apgacomp
               LET gs_keys[2] = g_apga_m.apgadocno
               LET gs_keys[3] = g_apgb3_d[g_detail_idx].xrcdld
               LET gs_keys[4] = g_apgb3_d[g_detail_idx].xrcdseq
               LET gs_keys[5] = g_apgb3_d[g_detail_idx].xrcdseq2
               LET gs_keys[6] = g_apgb3_d[g_detail_idx].xrcd007
               CALL aapt510_insert_b('xrcd_t',gs_keys,"'3'")
                           
               #add-point:單身新增後3 name="input.body3.a_insert"
               
               #end add-point
            ELSE    
               INITIALIZE g_apgb_d[l_ac].* TO NULL
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = 'INSERT' 
               LET g_errparam.code = "std-00006" 
               LET g_errparam.popup = TRUE 
               CALL s_transaction_end('N','0')
               CALL cl_err()
               CANCEL INSERT
            END IF
 
            IF SQLCA.SQLCODE THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "xrcd_t:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE 
               LET g_errparam.popup = TRUE 
               CALL s_transaction_end('N','0')                    
               CALL cl_err()
               CANCEL INSERT
            ELSE
               #先刷新資料
               #CALL aapt510_b_fill()
               #資料多語言用-增/改
               
               #add-point:單身新增後 name="input.body3.after_insert"
               
               #end add-point
               CALL s_transaction_end('Y','0')
               #ERROR 'INSERT O.K'
               LET g_rec_b = g_rec_b + 1
            END IF
            
         ON ROW CHANGE 
            IF INT_FLAG THEN
               LET INT_FLAG = 0
               LET g_apgb3_d[l_ac].* = g_apgb3_d_t.*
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code = 9001 
               LET g_errparam.popup = FALSE 
               CLOSE aapt510_bcl3
               CALL s_transaction_end('N','0')
               CALL cl_err()
               EXIT DIALOG 
            END IF
            
            IF l_lock_sw = 'Y' THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code = -263 
               LET g_errparam.popup = TRUE 
               CALL cl_err()
               LET g_apgb3_d[l_ac].* = g_apgb3_d_t.*
            ELSE
               #add-point:單身page3修改前 name="input.body3.b_update"
               
               #end add-point
               
               #寫入修改者/修改日期資訊(單身3)
               
               
               #將遮罩欄位還原
               CALL aapt510_xrcd_t_mask_restore('restore_mask_o')
                              
               UPDATE xrcd_t SET (xrcdcomp,xrcddocno,xrcdseq,xrcdseq2,xrcd007,xrcdld,xrcd002,xrcd003, 
                   xrcd006,xrcd005,xrcd102,xrcd103,xrcd104,xrcd105,xrcd113,xrcd114,xrcd115,xrcd123,xrcd124, 
                   xrcd125,xrcd133,xrcd134,xrcd135,xrcdorga,xrcd009,xrcd001,xrcd004,xrcd100,xrcd101, 
                   xrcd106,xrcd112,xrcd116,xrcd117,xrcd118,xrcd121,xrcd131,xrcdsite) = (g_apga_m.apgacomp, 
                   g_apga_m.apgadocno,g_apgb3_d[l_ac].xrcdseq,g_apgb3_d[l_ac].xrcdseq2,g_apgb3_d[l_ac].xrcd007, 
                   g_apgb3_d[l_ac].xrcdld,g_apgb3_d[l_ac].xrcd002,g_apgb3_d[l_ac].xrcd003,g_apgb3_d[l_ac].xrcd006, 
                   g_apgb3_d[l_ac].xrcd005,g_apgb3_d[l_ac].xrcd102,g_apgb3_d[l_ac].xrcd103,g_apgb3_d[l_ac].xrcd104, 
                   g_apgb3_d[l_ac].xrcd105,g_apgb3_d[l_ac].xrcd113,g_apgb3_d[l_ac].xrcd114,g_apgb3_d[l_ac].xrcd115, 
                   g_apgb3_d[l_ac].xrcd123,g_apgb3_d[l_ac].xrcd124,g_apgb3_d[l_ac].xrcd125,g_apgb3_d[l_ac].xrcd133, 
                   g_apgb3_d[l_ac].xrcd134,g_apgb3_d[l_ac].xrcd135,g_apgb3_d[l_ac].xrcdorga,g_apgb3_d[l_ac].xrcd009, 
                   g_apgb3_d[l_ac].xrcd001,g_apgb3_d[l_ac].xrcd004,g_apgb3_d[l_ac].xrcd100,g_apgb3_d[l_ac].xrcd101, 
                   g_apgb3_d[l_ac].xrcd106,g_apgb3_d[l_ac].xrcd112,g_apgb3_d[l_ac].xrcd116,g_apgb3_d[l_ac].xrcd117, 
                   g_apgb3_d[l_ac].xrcd118,g_apgb3_d[l_ac].xrcd121,g_apgb3_d[l_ac].xrcd131,g_apgb3_d[l_ac].xrcdsite)  
                   #自訂欄位頁簽
                WHERE xrcdent = g_enterprise AND xrcdcomp = g_apga_m.apgacomp
                  AND xrcddocno = g_apga_m.apgadocno
                  AND xrcdld = g_apgb3_d_t.xrcdld #項次 
                  AND xrcdseq = g_apgb3_d_t.xrcdseq
                  AND xrcdseq2 = g_apgb3_d_t.xrcdseq2
                  AND xrcd007 = g_apgb3_d_t.xrcd007
                  
               #add-point:單身page3修改中 name="input.body3.m_update"
               
               #end add-point
                  
               CASE
                  WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
                     LET g_apgb3_d[l_ac].* = g_apgb3_d_t.*
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "xrcd_t" 
                     LET g_errparam.code = "std-00009" 
                     LET g_errparam.popup = TRUE 
                     CALL s_transaction_end('N','0')
                     CALL cl_err()
                     
                  WHEN SQLCA.SQLCODE #其他錯誤
                     LET g_apgb3_d[l_ac].* = g_apgb3_d_t.*
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "xrcd_t:",SQLERRMESSAGE 
                     LET g_errparam.code = SQLCA.SQLCODE 
                     LET g_errparam.popup = TRUE 
                     CALL s_transaction_end('N','0')
                     CALL cl_err()
                     
                  OTHERWISE
                     #資料多語言用-增/改
                     
                                    INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_apga_m.apgacomp
               LET gs_keys_bak[1] = g_apgacomp_t
               LET gs_keys[2] = g_apga_m.apgadocno
               LET gs_keys_bak[2] = g_apgadocno_t
               LET gs_keys[3] = g_apgb3_d[g_detail_idx].xrcdld
               LET gs_keys_bak[3] = g_apgb3_d_t.xrcdld
               LET gs_keys[4] = g_apgb3_d[g_detail_idx].xrcdseq
               LET gs_keys_bak[4] = g_apgb3_d_t.xrcdseq
               LET gs_keys[5] = g_apgb3_d[g_detail_idx].xrcdseq2
               LET gs_keys_bak[5] = g_apgb3_d_t.xrcdseq2
               LET gs_keys[6] = g_apgb3_d[g_detail_idx].xrcd007
               LET gs_keys_bak[6] = g_apgb3_d_t.xrcd007
               CALL aapt510_update_b('xrcd_t',gs_keys,gs_keys_bak,"'3'")
               END CASE
               
               #將遮罩欄位進行遮蔽
               CALL aapt510_xrcd_t_mask_restore('restore_mask_n')
               
               #判斷key是否有改變
               INITIALIZE gs_keys TO NULL
               IF NOT (g_apgb3_d[g_detail_idx].xrcdld = g_apgb3_d_t.xrcdld 
                  AND g_apgb3_d[g_detail_idx].xrcdseq = g_apgb3_d_t.xrcdseq 
                  AND g_apgb3_d[g_detail_idx].xrcdseq2 = g_apgb3_d_t.xrcdseq2 
                  AND g_apgb3_d[g_detail_idx].xrcd007 = g_apgb3_d_t.xrcd007 
                  ) THEN
                  LET gs_keys[01] = g_apga_m.apgacomp
                  LET gs_keys[gs_keys.getLength()+1] = g_apga_m.apgadocno
                  LET gs_keys[gs_keys.getLength()+1] = g_apgb3_d_t.xrcdld
                  LET gs_keys[gs_keys.getLength()+1] = g_apgb3_d_t.xrcdseq
                  LET gs_keys[gs_keys.getLength()+1] = g_apgb3_d_t.xrcdseq2
                  LET gs_keys[gs_keys.getLength()+1] = g_apgb3_d_t.xrcd007
                  CALL aapt510_key_update_b(gs_keys,'xrcd_t')
               END IF
               
               #修改歷程記錄(單身修改)
               LET g_log1 = util.JSON.stringify(g_apga_m),util.JSON.stringify(g_apgb3_d_t)
               LET g_log2 = util.JSON.stringify(g_apga_m),util.JSON.stringify(g_apgb3_d[l_ac])
               IF NOT cl_log_modified_record_d(g_log1,g_log2) THEN 
                  CALL s_transaction_end('N','0')
               END IF
               
               #add-point:單身page3修改後 name="input.body3.a_update"
               
               #end add-point
            END IF
         
                  #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrcdseq
            #add-point:BEFORE FIELD xrcdseq name="input.b.page3.xrcdseq"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrcdseq
            
            #add-point:AFTER FIELD xrcdseq name="input.a.page3.xrcdseq"
            #應用 a05 樣板自動產生(Version:2)
            #確認資料無重複
            IF  g_apga_m.apgacomp IS NOT NULL AND g_apga_m.apgadocno IS NOT NULL AND g_apgb3_d[g_detail_idx].xrcdld IS NOT NULL AND g_apgb3_d[g_detail_idx].xrcdseq IS NOT NULL AND g_apgb3_d[g_detail_idx].xrcdseq2 IS NOT NULL AND g_apgb3_d[g_detail_idx].xrcd007 IS NOT NULL THEN 
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_apga_m.apgacomp != g_apgacomp_t OR g_apga_m.apgadocno != g_apgadocno_t OR g_apgb3_d[g_detail_idx].xrcdld != g_apgb3_d_t.xrcdld OR g_apgb3_d[g_detail_idx].xrcdseq != g_apgb3_d_t.xrcdseq OR g_apgb3_d[g_detail_idx].xrcdseq2 != g_apgb3_d_t.xrcdseq2 OR g_apgb3_d[g_detail_idx].xrcd007 != g_apgb3_d_t.xrcd007)) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM xrcd_t WHERE "||"xrcdent = '" ||g_enterprise|| "' AND "||"xrcddocno = '"||g_apga_m.apgacomp ||"' AND "|| "xrcdld = '"||g_apga_m.apgadocno ||"' AND "|| "xrcdseq = '"||g_apgb3_d[g_detail_idx].xrcdld ||"' AND "|| "xrcdseq2 = '"||g_apgb3_d[g_detail_idx].xrcdseq ||"' AND "|| "xrcd007 = '"||g_apgb3_d[g_detail_idx].xrcdseq2 ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF


            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xrcdseq
            #add-point:ON CHANGE xrcdseq name="input.g.page3.xrcdseq"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrcdseq2
            #add-point:BEFORE FIELD xrcdseq2 name="input.b.page3.xrcdseq2"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrcdseq2
            
            #add-point:AFTER FIELD xrcdseq2 name="input.a.page3.xrcdseq2"
            #應用 a05 樣板自動產生(Version:2)
            #確認資料無重複
            IF  g_apga_m.apgacomp IS NOT NULL AND g_apga_m.apgadocno IS NOT NULL AND g_apgb3_d[g_detail_idx].xrcdld IS NOT NULL AND g_apgb3_d[g_detail_idx].xrcdseq IS NOT NULL AND g_apgb3_d[g_detail_idx].xrcdseq2 IS NOT NULL AND g_apgb3_d[g_detail_idx].xrcd007 IS NOT NULL THEN 
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_apga_m.apgacomp != g_apgacomp_t OR g_apga_m.apgadocno != g_apgadocno_t OR g_apgb3_d[g_detail_idx].xrcdld != g_apgb3_d_t.xrcdld OR g_apgb3_d[g_detail_idx].xrcdseq != g_apgb3_d_t.xrcdseq OR g_apgb3_d[g_detail_idx].xrcdseq2 != g_apgb3_d_t.xrcdseq2 OR g_apgb3_d[g_detail_idx].xrcd007 != g_apgb3_d_t.xrcd007)) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM xrcd_t WHERE "||"xrcdent = '" ||g_enterprise|| "' AND "||"xrcddocno = '"||g_apga_m.apgacomp ||"' AND "|| "xrcdld = '"||g_apga_m.apgadocno ||"' AND "|| "xrcdseq = '"||g_apgb3_d[g_detail_idx].xrcdld ||"' AND "|| "xrcdseq2 = '"||g_apgb3_d[g_detail_idx].xrcdseq ||"' AND "|| "xrcd007 = '"||g_apgb3_d[g_detail_idx].xrcdseq2 ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF


            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xrcdseq2
            #add-point:ON CHANGE xrcdseq2 name="input.g.page3.xrcdseq2"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrcd007
            #add-point:BEFORE FIELD xrcd007 name="input.b.page3.xrcd007"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrcd007
            
            #add-point:AFTER FIELD xrcd007 name="input.a.page3.xrcd007"
            #應用 a05 樣板自動產生(Version:2)
            #確認資料無重複
            IF  g_apga_m.apgacomp IS NOT NULL AND g_apga_m.apgadocno IS NOT NULL AND g_apgb3_d[g_detail_idx].xrcdld IS NOT NULL AND g_apgb3_d[g_detail_idx].xrcdseq IS NOT NULL AND g_apgb3_d[g_detail_idx].xrcdseq2 IS NOT NULL AND g_apgb3_d[g_detail_idx].xrcd007 IS NOT NULL THEN 
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_apga_m.apgacomp != g_apgacomp_t OR g_apga_m.apgadocno != g_apgadocno_t OR g_apgb3_d[g_detail_idx].xrcdld != g_apgb3_d_t.xrcdld OR g_apgb3_d[g_detail_idx].xrcdseq != g_apgb3_d_t.xrcdseq OR g_apgb3_d[g_detail_idx].xrcdseq2 != g_apgb3_d_t.xrcdseq2 OR g_apgb3_d[g_detail_idx].xrcd007 != g_apgb3_d_t.xrcd007)) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM xrcd_t WHERE "||"xrcdent = '" ||g_enterprise|| "' AND "||"xrcddocno = '"||g_apga_m.apgacomp ||"' AND "|| "xrcdld = '"||g_apga_m.apgadocno ||"' AND "|| "xrcdseq = '"||g_apgb3_d[g_detail_idx].xrcdld ||"' AND "|| "xrcdseq2 = '"||g_apgb3_d[g_detail_idx].xrcdseq ||"' AND "|| "xrcd007 = '"||g_apgb3_d[g_detail_idx].xrcdseq2 ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF


            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xrcd007
            #add-point:ON CHANGE xrcd007 name="input.g.page3.xrcd007"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrcdld
            #add-point:BEFORE FIELD xrcdld name="input.b.page3.xrcdld"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrcdld
            
            #add-point:AFTER FIELD xrcdld name="input.a.page3.xrcdld"
            #應用 a05 樣板自動產生(Version:2)
            #確認資料無重複
            IF  g_apga_m.apgacomp IS NOT NULL AND g_apga_m.apgadocno IS NOT NULL AND g_apgb3_d[g_detail_idx].xrcdld IS NOT NULL AND g_apgb3_d[g_detail_idx].xrcdseq IS NOT NULL AND g_apgb3_d[g_detail_idx].xrcdseq2 IS NOT NULL AND g_apgb3_d[g_detail_idx].xrcd007 IS NOT NULL THEN 
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_apga_m.apgacomp != g_apgacomp_t OR g_apga_m.apgadocno != g_apgadocno_t OR g_apgb3_d[g_detail_idx].xrcdld != g_apgb3_d_t.xrcdld OR g_apgb3_d[g_detail_idx].xrcdseq != g_apgb3_d_t.xrcdseq OR g_apgb3_d[g_detail_idx].xrcdseq2 != g_apgb3_d_t.xrcdseq2 OR g_apgb3_d[g_detail_idx].xrcd007 != g_apgb3_d_t.xrcd007)) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM xrcd_t WHERE "||"xrcdent = '" ||g_enterprise|| "' AND "||"xrcddocno = '"||g_apga_m.apgacomp ||"' AND "|| "xrcdld = '"||g_apga_m.apgadocno ||"' AND "|| "xrcdseq = '"||g_apgb3_d[g_detail_idx].xrcdld ||"' AND "|| "xrcdseq2 = '"||g_apgb3_d[g_detail_idx].xrcdseq ||"' AND "|| "xrcd007 = '"||g_apgb3_d[g_detail_idx].xrcdseq2 ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF


            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xrcdld
            #add-point:ON CHANGE xrcdld name="input.g.page3.xrcdld"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrcd003
            #add-point:BEFORE FIELD xrcd003 name="input.b.page3.xrcd003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrcd003
            
            #add-point:AFTER FIELD xrcd003 name="input.a.page3.xrcd003"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xrcd003
            #add-point:ON CHANGE xrcd003 name="input.g.page3.xrcd003"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrcd006
            #add-point:BEFORE FIELD xrcd006 name="input.b.page3.xrcd006"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrcd006
            
            #add-point:AFTER FIELD xrcd006 name="input.a.page3.xrcd006"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xrcd006
            #add-point:ON CHANGE xrcd006 name="input.g.page3.xrcd006"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrcd005
            #add-point:BEFORE FIELD xrcd005 name="input.b.page3.xrcd005"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrcd005
            
            #add-point:AFTER FIELD xrcd005 name="input.a.page3.xrcd005"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xrcd005
            #add-point:ON CHANGE xrcd005 name="input.g.page3.xrcd005"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrcd102
            #add-point:BEFORE FIELD xrcd102 name="input.b.page3.xrcd102"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrcd102
            
            #add-point:AFTER FIELD xrcd102 name="input.a.page3.xrcd102"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xrcd102
            #add-point:ON CHANGE xrcd102 name="input.g.page3.xrcd102"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrcd103
            #add-point:BEFORE FIELD xrcd103 name="input.b.page3.xrcd103"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrcd103
            
            #add-point:AFTER FIELD xrcd103 name="input.a.page3.xrcd103"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xrcd103
            #add-point:ON CHANGE xrcd103 name="input.g.page3.xrcd103"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrcd104
            #add-point:BEFORE FIELD xrcd104 name="input.b.page3.xrcd104"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrcd104
            
            #add-point:AFTER FIELD xrcd104 name="input.a.page3.xrcd104"
            LET l_ld = NULL  LET l_glaa015 = NULL LET l_glaa019 = NULL
            SELECT glaald,glaa015,glaa019 
              INTO l_ld,l_glaa015,l_glaa019
              FROM glaa_t
             WHERE glaaent = g_enterprise
               AND glaacomp = g_apga_m.apgacomp
               AND glaa014 = 'Y'
             
            #交易幣稅額
            IF NOT cl_null(g_apgb3_d[l_ac].xrcd104) THEN
               IF p_cmd = 'u' AND (g_apgb3_d[l_ac].xrcd104 != g_apgb3_d_o.xrcd104 OR g_apgb3_d_o.xrcd104 IS NULL ) THEN
                  INITIALIZE l_xrcd.* TO NULL
                  CALL s_tax_calc_curr_tax_amount(l_ld,g_apga_m.apgadocno,g_apgb3_d[l_ac].xrcdseq,0,g_apgb3_d[l_ac].xrcd104,'')
                       RETURNING g_apgb3_d[l_ac].xrcd103,l_xrcd.xrcd104         ,g_apgb3_d[l_ac].xrcd105,
                                 g_apgb3_d[l_ac].xrcd113,g_apgb3_d[l_ac].xrcd114,g_apgb3_d[l_ac].xrcd115,
                                 l_xrcd.xrcd123        ,l_xrcd.xrcd124        ,l_xrcd.xrcd125,
                                 l_xrcd.xrcd133        ,l_xrcd.xrcd134        ,l_xrcd.xrcd135
                  IF l_glaa015 = 'Y' THEN
                     LET g_apgb3_d[l_ac].xrcd123 = l_xrcd.xrcd123
                     LET g_apgb3_d[l_ac].xrcd124 = l_xrcd.xrcd124
                     LET g_apgb3_d[l_ac].xrcd125 = l_xrcd.xrcd125
                  END IF
                  IF l_glaa019 = 'Y' THEN
                     LET g_apgb3_d[l_ac].xrcd133 = l_xrcd.xrcd133
                     LET g_apgb3_d[l_ac].xrcd134 = l_xrcd.xrcd134
                     LET g_apgb3_d[l_ac].xrcd135 = l_xrcd.xrcd135
                  END IF
               END IF
               CALL aapt510_to_o_b3(l_ac)
            END IF
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xrcd104
            #add-point:ON CHANGE xrcd104 name="input.g.page3.xrcd104"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrcd105
            #add-point:BEFORE FIELD xrcd105 name="input.b.page3.xrcd105"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrcd105
            
            #add-point:AFTER FIELD xrcd105 name="input.a.page3.xrcd105"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xrcd105
            #add-point:ON CHANGE xrcd105 name="input.g.page3.xrcd105"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrcd113
            #add-point:BEFORE FIELD xrcd113 name="input.b.page3.xrcd113"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrcd113
            
            #add-point:AFTER FIELD xrcd113 name="input.a.page3.xrcd113"
            LET g_apgb3_d_o.* = g_apgb3_d[l_ac].*  #160822-00008#5 add
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xrcd113
            #add-point:ON CHANGE xrcd113 name="input.g.page3.xrcd113"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrcd114
            #add-point:BEFORE FIELD xrcd114 name="input.b.page3.xrcd114"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrcd114
            
            #add-point:AFTER FIELD xrcd114 name="input.a.page3.xrcd114"
            LET l_ld = NULL LET l_glaa015 = NULL  LET l_glaa017 = NULL
            LET l_glaa019 = NULL LET l_glaa021 = NULL
            
            SELECT glaald,glaa015,glaa017,
                   glaa019,glaa021
              INTO l_ld,l_glaa015,l_glaa017,
                   l_glaa019,l_glaa021
              FROM glaa_t
             WHERE glaaent = g_enterprise
               AND glaacomp = g_apga_m.apgacomp
               AND glaa014 = 'Y'
            
            #本幣稅額
            IF NOT cl_null(g_apgb3_d[l_ac].xrcd114) THEN
               IF g_apgb3_d[l_ac].xrcd114 != g_apgb3_d_o.xrcd114 OR cl_null(g_apgb3_d_o.xrcd114) THEN                     #160822-00008#5 add
               #IF p_cmd = 'u' AND (g_apgb3_d[l_ac].xrcd114 != g_apgb3_d_t.xrcd114 OR g_apgb3_d_t.xrcd114 IS NULL ) THEN  #160822-00008#5 mark
               
                  #160822-00008#5 --s add
                  LET g_apgb3_d[l_ac].xrcd113 = ''
                  LET g_apgb3_d[l_ac].xrcd115 = ''
                  #160822-00008#5 --e add
               
                  INITIALIZE l_xrcd.* TO NULL
                  CALL s_tax_calc_curr_tax_amount(l_ld,g_apga_m.apgadocno,g_apgb3_d[l_ac].xrcdseq,0,'',g_apgb3_d[l_ac].xrcd114)
                       RETURNING l_xrcd.xrcd103        ,l_xrcd.xrcd104        ,l_xrcd.xrcd105,
                                 g_apgb3_d[l_ac].xrcd113,g_apgb3_d[l_ac].xrcd114,g_apgb3_d[l_ac].xrcd115,
                                 l_xrcd.xrcd123        ,l_xrcd.xrcd124        ,l_xrcd.xrcd125,
                                 l_xrcd.xrcd133        ,l_xrcd.xrcd134        ,l_xrcd.xrcd135
                  #只變更以帳簿幣別為換算基準的幣別
                  IF l_glaa015 = 'Y' AND l_glaa017 = '2' THEN
                     #160822-00008#5 --s add
                     LET g_apgb3_d[l_ac].xrcd123 = ''
                     LET g_apgb3_d[l_ac].xrcd124 = ''
                     LET g_apgb3_d[l_ac].xrcd125 = ''
                     #160822-00008#5 --e add

                     LET g_apgb3_d[l_ac].xrcd123 = l_xrcd.xrcd123
                     LET g_apgb3_d[l_ac].xrcd124 = l_xrcd.xrcd124
                     LET g_apgb3_d[l_ac].xrcd125 = l_xrcd.xrcd125
                  END IF
                  IF l_glaa019 = 'Y' AND l_glaa021 = '2' THEN
                     #160822-00008#5 --s add
                     LET g_apgb3_d[l_ac].xrcd133 = ''
                     LET g_apgb3_d[l_ac].xrcd134 = ''
                     LET g_apgb3_d[l_ac].xrcd135 = ''
                     #160822-00008#5 --e add
                  
                     LET g_apgb3_d[l_ac].xrcd133 = l_xrcd.xrcd133
                     LET g_apgb3_d[l_ac].xrcd134 = l_xrcd.xrcd134
                     LET g_apgb3_d[l_ac].xrcd135 = l_xrcd.xrcd135
                  END IF
                  CALL aapt510_to_o_b3(l_ac)
               END IF
            END IF
            LET g_apgb3_d_o.* = g_apgb3_d[l_ac].*  #160822-00008#5 add
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xrcd114
            #add-point:ON CHANGE xrcd114 name="input.g.page3.xrcd114"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrcd115
            #add-point:BEFORE FIELD xrcd115 name="input.b.page3.xrcd115"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrcd115
            
            #add-point:AFTER FIELD xrcd115 name="input.a.page3.xrcd115"
            LET g_apgb3_d_o.* = g_apgb3_d[l_ac].*  #160822-00008#5 add
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xrcd115
            #add-point:ON CHANGE xrcd115 name="input.g.page3.xrcd115"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrcd123
            #add-point:BEFORE FIELD xrcd123 name="input.b.page3.xrcd123"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrcd123
            
            #add-point:AFTER FIELD xrcd123 name="input.a.page3.xrcd123"
            LET g_apgb3_d_o.* = g_apgb3_d[l_ac].*  #160822-00008#5 add
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xrcd123
            #add-point:ON CHANGE xrcd123 name="input.g.page3.xrcd123"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrcd124
            #add-point:BEFORE FIELD xrcd124 name="input.b.page3.xrcd124"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrcd124
            
            #add-point:AFTER FIELD xrcd124 name="input.a.page3.xrcd124"
            #本位幣二稅額
            IF NOT cl_null(g_apgb3_d[l_ac].xrcd124) THEN
               IF g_apgb3_d[l_ac].xrcd124 != g_apgb3_d_o.xrcd124 OR cl_null(g_apgb3_d_o.xrcd124) THEN                        #160822-00008#5 add
               #IF p_cmd = 'u' AND (g_apgb3_d[l_ac].xrcd124 != g_apgb3_d_o.xrcd124 OR g_apgb3_d_o.xrcd124 IS NULL ) THEN     #160822-00008#5 mark
                  CALL s_tax_chk(g_apga_m.apgacomp,g_apgb3_d[l_ac].xrcd002) RETURNING g_sub_success,l_oodb004,l_apca013,l_apca012,l_oodb011
                  
                  #160822-00008#5 --s add
                  LET g_apgb3_d[l_ac].xrcd123 = ''
                  LET g_apgb3_d[l_ac].xrcd125 = ''
                  #160822-00008#5 --e add
                  
                  CALL s_tax_calc_tax_amount(l_apca013,g_apgb3_d[l_ac].xrcd123,g_apgb3_d[l_ac].xrcd124,g_apgb3_d[l_ac].xrcd125)
                       RETURNING g_apgb3_d[l_ac].xrcd123,l_xrcd.xrcd124,g_apgb3_d[l_ac].xrcd125
                  CALL aapt510_to_o_b3(l_ac)
               END IF
            END IF
            LET g_apgb3_d_o.* = g_apgb3_d[l_ac].*  #160822-00008#5 add            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xrcd124
            #add-point:ON CHANGE xrcd124 name="input.g.page3.xrcd124"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrcd125
            #add-point:BEFORE FIELD xrcd125 name="input.b.page3.xrcd125"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrcd125
            
            #add-point:AFTER FIELD xrcd125 name="input.a.page3.xrcd125"
            LET g_apgb3_d_o.* = g_apgb3_d[l_ac].*  #160822-00008#5 add
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xrcd125
            #add-point:ON CHANGE xrcd125 name="input.g.page3.xrcd125"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrcd133
            #add-point:BEFORE FIELD xrcd133 name="input.b.page3.xrcd133"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrcd133
            
            #add-point:AFTER FIELD xrcd133 name="input.a.page3.xrcd133"
            LET g_apgb3_d_o.* = g_apgb3_d[l_ac].*  #160822-00008#5 add
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xrcd133
            #add-point:ON CHANGE xrcd133 name="input.g.page3.xrcd133"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrcd134
            #add-point:BEFORE FIELD xrcd134 name="input.b.page3.xrcd134"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrcd134
            
            #add-point:AFTER FIELD xrcd134 name="input.a.page3.xrcd134"
            #本位幣三稅額
            IF NOT cl_null(g_apgb3_d[l_ac].xrcd134) THEN
               IF g_apgb3_d[l_ac].xrcd134 != g_apgb3_d_o.xrcd134 OR cl_null(g_apgb3_d_o.xrcd134) THEN                     #160822-00008#5 add
               #IF p_cmd = 'u' AND (g_apgb3_d[l_ac].xrcd134 != g_apgb3_d_t.xrcd134 OR g_apgb3_d_t.xrcd134 IS NULL ) THEN  #160822-00008#5 mark
               
                  LET g_apgb3_d[l_ac].xrcd133 = '' #160822-00008#5 add
                  LET g_apgb3_d[l_ac].xrcd135 = '' #160822-00008#5 add
               
                  CALL s_tax_chk(g_apga_m.apgacomp,g_apgb3_d[l_ac].xrcd002) RETURNING g_sub_success,l_oodb004,l_apca013,l_apca012,l_oodb011
                  CALL s_tax_calc_tax_amount(l_apca013,g_apgb3_d[l_ac].xrcd133,g_apgb3_d[l_ac].xrcd134,g_apgb3_d[l_ac].xrcd135)
                       RETURNING g_apgb3_d[l_ac].xrcd133,l_xrcd.xrcd134,g_apgb3_d[l_ac].xrcd135
                  CALL aapt510_to_o_b3(l_ac)
               END IF
            END IF
            LET g_apgb3_d_o.* = g_apgb3_d[l_ac].*  #160822-00008#5 add
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xrcd134
            #add-point:ON CHANGE xrcd134 name="input.g.page3.xrcd134"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrcd135
            #add-point:BEFORE FIELD xrcd135 name="input.b.page3.xrcd135"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrcd135
            
            #add-point:AFTER FIELD xrcd135 name="input.a.page3.xrcd135"
            LET g_apgb3_d_o.* = g_apgb3_d[l_ac].*  #160822-00008#5 add
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xrcd135
            #add-point:ON CHANGE xrcd135 name="input.g.page3.xrcd135"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrcdorga
            #add-point:BEFORE FIELD xrcdorga name="input.b.page3.xrcdorga"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrcdorga
            
            #add-point:AFTER FIELD xrcdorga name="input.a.page3.xrcdorga"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xrcdorga
            #add-point:ON CHANGE xrcdorga name="input.g.page3.xrcdorga"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrcd009
            
            #add-point:AFTER FIELD xrcd009 name="input.a.page3.xrcd009"
            LET l_ld = NULL
            SELECT glaald INTO l_ld FROM glaa_t
             WHERE glaaent = g_enterprise
               AND glaacomp = g_apga_m.apgacomp
               AND glaa014 = 'Y'
            IF NOT cl_null(g_apgb3_d[l_ac].xrcd009) THEN
               IF p_cmd = 'u' AND (g_apgb3_d[l_ac].xrcd009 != g_apgb3_d_t.xrcd009 OR g_apgb3_d_t.xrcd009 IS NULL ) THEN
                  CALL s_aap_glac002_chk(g_apgb3_d[l_ac].xrcd009,l_ld) RETURNING g_sub_success,g_errno
                  IF NOT g_sub_success THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = g_errno
                     #160321-00016#22 --s add
                     LET g_errparam.replace[1] = 'agli020'
                     LET g_errparam.replace[2] = cl_get_progname('agli020',g_lang,"2")
                     LET g_errparam.exeprog = 'agli020'
                     #160321-00016#22 --e add
                     LET g_errparam.extend = ''
                     LET g_errparam.popup = TRUE
                     CALL cl_err()

                     LET g_apgb3_d[l_ac].xrcd009 = g_apgb3_d_t.xrcd009
                     CALL s_desc_get_account_desc(l_ld,g_apgb3_d[l_ac].xrcd009) RETURNING g_apgb3_d[l_ac].xrcd009_desc
                     DISPLAY BY NAME g_apgb3_d[l_ac].xrcd009_desc
                     NEXT FIELD CURRENT
                  END IF
                END IF
            END IF
            CALL s_desc_get_account_desc(l_ld,g_apgb3_d[l_ac].xrcd009) RETURNING g_apgb3_d[l_ac].xrcd009_desc
            DISPLAY BY NAME g_apgb3_d[l_ac].xrcd009_desc


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrcd009
            #add-point:BEFORE FIELD xrcd009 name="input.b.page3.xrcd009"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xrcd009
            #add-point:ON CHANGE xrcd009 name="input.g.page3.xrcd009"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrcd001
            #add-point:BEFORE FIELD xrcd001 name="input.b.page3.xrcd001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrcd001
            
            #add-point:AFTER FIELD xrcd001 name="input.a.page3.xrcd001"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xrcd001
            #add-point:ON CHANGE xrcd001 name="input.g.page3.xrcd001"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrcd004
            #add-point:BEFORE FIELD xrcd004 name="input.b.page3.xrcd004"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrcd004
            
            #add-point:AFTER FIELD xrcd004 name="input.a.page3.xrcd004"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xrcd004
            #add-point:ON CHANGE xrcd004 name="input.g.page3.xrcd004"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrcd100
            #add-point:BEFORE FIELD xrcd100 name="input.b.page3.xrcd100"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrcd100
            
            #add-point:AFTER FIELD xrcd100 name="input.a.page3.xrcd100"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xrcd100
            #add-point:ON CHANGE xrcd100 name="input.g.page3.xrcd100"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrcd101
            #add-point:BEFORE FIELD xrcd101 name="input.b.page3.xrcd101"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrcd101
            
            #add-point:AFTER FIELD xrcd101 name="input.a.page3.xrcd101"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xrcd101
            #add-point:ON CHANGE xrcd101 name="input.g.page3.xrcd101"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrcd106
            #add-point:BEFORE FIELD xrcd106 name="input.b.page3.xrcd106"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrcd106
            
            #add-point:AFTER FIELD xrcd106 name="input.a.page3.xrcd106"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xrcd106
            #add-point:ON CHANGE xrcd106 name="input.g.page3.xrcd106"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrcd112
            #add-point:BEFORE FIELD xrcd112 name="input.b.page3.xrcd112"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrcd112
            
            #add-point:AFTER FIELD xrcd112 name="input.a.page3.xrcd112"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xrcd112
            #add-point:ON CHANGE xrcd112 name="input.g.page3.xrcd112"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrcd116
            #add-point:BEFORE FIELD xrcd116 name="input.b.page3.xrcd116"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrcd116
            
            #add-point:AFTER FIELD xrcd116 name="input.a.page3.xrcd116"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xrcd116
            #add-point:ON CHANGE xrcd116 name="input.g.page3.xrcd116"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrcd117
            #add-point:BEFORE FIELD xrcd117 name="input.b.page3.xrcd117"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrcd117
            
            #add-point:AFTER FIELD xrcd117 name="input.a.page3.xrcd117"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xrcd117
            #add-point:ON CHANGE xrcd117 name="input.g.page3.xrcd117"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrcd118
            #add-point:BEFORE FIELD xrcd118 name="input.b.page3.xrcd118"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrcd118
            
            #add-point:AFTER FIELD xrcd118 name="input.a.page3.xrcd118"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xrcd118
            #add-point:ON CHANGE xrcd118 name="input.g.page3.xrcd118"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrcd121
            #add-point:BEFORE FIELD xrcd121 name="input.b.page3.xrcd121"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrcd121
            
            #add-point:AFTER FIELD xrcd121 name="input.a.page3.xrcd121"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xrcd121
            #add-point:ON CHANGE xrcd121 name="input.g.page3.xrcd121"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrcd131
            #add-point:BEFORE FIELD xrcd131 name="input.b.page3.xrcd131"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrcd131
            
            #add-point:AFTER FIELD xrcd131 name="input.a.page3.xrcd131"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xrcd131
            #add-point:ON CHANGE xrcd131 name="input.g.page3.xrcd131"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrcdsite
            #add-point:BEFORE FIELD xrcdsite name="input.b.page3.xrcdsite"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrcdsite
            
            #add-point:AFTER FIELD xrcdsite name="input.a.page3.xrcdsite"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xrcdsite
            #add-point:ON CHANGE xrcdsite name="input.g.page3.xrcdsite"
            
            #END add-point 
 
 
 
                  #Ctrlp:input.c.page3.xrcdseq
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrcdseq
            #add-point:ON ACTION controlp INFIELD xrcdseq name="input.c.page3.xrcdseq"
            
            #END add-point
 
 
         #Ctrlp:input.c.page3.xrcdseq2
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrcdseq2
            #add-point:ON ACTION controlp INFIELD xrcdseq2 name="input.c.page3.xrcdseq2"
            
            #END add-point
 
 
         #Ctrlp:input.c.page3.xrcd007
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrcd007
            #add-point:ON ACTION controlp INFIELD xrcd007 name="input.c.page3.xrcd007"
            
            #END add-point
 
 
         #Ctrlp:input.c.page3.xrcdld
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrcdld
            #add-point:ON ACTION controlp INFIELD xrcdld name="input.c.page3.xrcdld"
            
            #END add-point
 
 
         #Ctrlp:input.c.page3.xrcd003
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrcd003
            #add-point:ON ACTION controlp INFIELD xrcd003 name="input.c.page3.xrcd003"
            
            #END add-point
 
 
         #Ctrlp:input.c.page3.xrcd006
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrcd006
            #add-point:ON ACTION controlp INFIELD xrcd006 name="input.c.page3.xrcd006"
            
            #END add-point
 
 
         #Ctrlp:input.c.page3.xrcd005
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrcd005
            #add-point:ON ACTION controlp INFIELD xrcd005 name="input.c.page3.xrcd005"
            
            #END add-point
 
 
         #Ctrlp:input.c.page3.xrcd102
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrcd102
            #add-point:ON ACTION controlp INFIELD xrcd102 name="input.c.page3.xrcd102"
            
            #END add-point
 
 
         #Ctrlp:input.c.page3.xrcd103
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrcd103
            #add-point:ON ACTION controlp INFIELD xrcd103 name="input.c.page3.xrcd103"
            
            #END add-point
 
 
         #Ctrlp:input.c.page3.xrcd104
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrcd104
            #add-point:ON ACTION controlp INFIELD xrcd104 name="input.c.page3.xrcd104"
            
            #END add-point
 
 
         #Ctrlp:input.c.page3.xrcd105
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrcd105
            #add-point:ON ACTION controlp INFIELD xrcd105 name="input.c.page3.xrcd105"
            
            #END add-point
 
 
         #Ctrlp:input.c.page3.xrcd113
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrcd113
            #add-point:ON ACTION controlp INFIELD xrcd113 name="input.c.page3.xrcd113"
            
            #END add-point
 
 
         #Ctrlp:input.c.page3.xrcd114
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrcd114
            #add-point:ON ACTION controlp INFIELD xrcd114 name="input.c.page3.xrcd114"
            
            #END add-point
 
 
         #Ctrlp:input.c.page3.xrcd115
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrcd115
            #add-point:ON ACTION controlp INFIELD xrcd115 name="input.c.page3.xrcd115"
            
            #END add-point
 
 
         #Ctrlp:input.c.page3.xrcd123
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrcd123
            #add-point:ON ACTION controlp INFIELD xrcd123 name="input.c.page3.xrcd123"
            
            #END add-point
 
 
         #Ctrlp:input.c.page3.xrcd124
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrcd124
            #add-point:ON ACTION controlp INFIELD xrcd124 name="input.c.page3.xrcd124"
            
            #END add-point
 
 
         #Ctrlp:input.c.page3.xrcd125
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrcd125
            #add-point:ON ACTION controlp INFIELD xrcd125 name="input.c.page3.xrcd125"
            
            #END add-point
 
 
         #Ctrlp:input.c.page3.xrcd133
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrcd133
            #add-point:ON ACTION controlp INFIELD xrcd133 name="input.c.page3.xrcd133"
            
            #END add-point
 
 
         #Ctrlp:input.c.page3.xrcd134
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrcd134
            #add-point:ON ACTION controlp INFIELD xrcd134 name="input.c.page3.xrcd134"
            
            #END add-point
 
 
         #Ctrlp:input.c.page3.xrcd135
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrcd135
            #add-point:ON ACTION controlp INFIELD xrcd135 name="input.c.page3.xrcd135"
            
            #END add-point
 
 
         #Ctrlp:input.c.page3.xrcdorga
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrcdorga
            #add-point:ON ACTION controlp INFIELD xrcdorga name="input.c.page3.xrcdorga"
            
            #END add-point
 
 
         #Ctrlp:input.c.page3.xrcd009
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrcd009
            #add-point:ON ACTION controlp INFIELD xrcd009 name="input.c.page3.xrcd009"
            #應用 a07 樣板自動產生(Version:2)   
            LET l_glaa004 = NULL LET l_ld = NULL
            SELECT glaa004,glaald INTO l_glaa004,l_ld
              FROM glaa_t
             WHERE glaaent = g_enterprise
               AND glaacomp = g_apga_m.apgacomp
               AND glaa014 = 'Y'

            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_apgb3_d[l_ac].xrcd009
            LET g_qryparam.where = "glac001 = '",l_glaa004,"' AND  glac003 <>'1' ",
                                   " AND glac002 IN (SELECT glad001 FROM glad_t,glac_t WHERE glad001= glac002 ",
                                   "AND gladld='",l_ld,"' AND gladent='",g_enterprise,"'",
                                   " AND gladstus = 'Y' )" 
            CALL aglt310_04()
            LET g_apgb3_d[l_ac].xrcd009 = g_qryparam.return1   
            CALL s_desc_get_account_desc(l_ld,g_apgb3_d[l_ac].xrcd009) RETURNING g_apgb3_d[l_ac].xrcd009_desc
            DISPLAY BY NAME g_apgb3_d[l_ac].xrcd009,g_apgb3_d[l_ac].xrcd009_desc
            NEXT FIELD xrcd009
            #END add-point
 
 
         #Ctrlp:input.c.page3.xrcd001
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrcd001
            #add-point:ON ACTION controlp INFIELD xrcd001 name="input.c.page3.xrcd001"
            
            #END add-point
 
 
         #Ctrlp:input.c.page3.xrcd004
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrcd004
            #add-point:ON ACTION controlp INFIELD xrcd004 name="input.c.page3.xrcd004"
            
            #END add-point
 
 
         #Ctrlp:input.c.page3.xrcd100
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrcd100
            #add-point:ON ACTION controlp INFIELD xrcd100 name="input.c.page3.xrcd100"
            
            #END add-point
 
 
         #Ctrlp:input.c.page3.xrcd101
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrcd101
            #add-point:ON ACTION controlp INFIELD xrcd101 name="input.c.page3.xrcd101"
            
            #END add-point
 
 
         #Ctrlp:input.c.page3.xrcd106
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrcd106
            #add-point:ON ACTION controlp INFIELD xrcd106 name="input.c.page3.xrcd106"
            
            #END add-point
 
 
         #Ctrlp:input.c.page3.xrcd112
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrcd112
            #add-point:ON ACTION controlp INFIELD xrcd112 name="input.c.page3.xrcd112"
            
            #END add-point
 
 
         #Ctrlp:input.c.page3.xrcd116
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrcd116
            #add-point:ON ACTION controlp INFIELD xrcd116 name="input.c.page3.xrcd116"
            
            #END add-point
 
 
         #Ctrlp:input.c.page3.xrcd117
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrcd117
            #add-point:ON ACTION controlp INFIELD xrcd117 name="input.c.page3.xrcd117"
            
            #END add-point
 
 
         #Ctrlp:input.c.page3.xrcd118
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrcd118
            #add-point:ON ACTION controlp INFIELD xrcd118 name="input.c.page3.xrcd118"
            
            #END add-point
 
 
         #Ctrlp:input.c.page3.xrcd121
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrcd121
            #add-point:ON ACTION controlp INFIELD xrcd121 name="input.c.page3.xrcd121"
            
            #END add-point
 
 
         #Ctrlp:input.c.page3.xrcd131
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrcd131
            #add-point:ON ACTION controlp INFIELD xrcd131 name="input.c.page3.xrcd131"
            
            #END add-point
 
 
         #Ctrlp:input.c.page3.xrcdsite
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrcdsite
            #add-point:ON ACTION controlp INFIELD xrcdsite name="input.c.page3.xrcdsite"
            
            #END add-point
 
 
 
 
         AFTER ROW
            #add-point:單身page3 after_row name="input.body3.after_row"
            
            #end add-point
            LET l_ac = ARR_CURR()
            IF INT_FLAG THEN
               LET INT_FLAG = 0
               IF l_cmd = 'u' THEN
                  LET g_apgb3_d[l_ac].* = g_apgb3_d_t.*
               END IF
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code = 9001 
               LET g_errparam.popup = FALSE 
               CLOSE aapt510_bcl3
               CALL s_transaction_end('N','0')
               CALL cl_err()
               EXIT DIALOG 
            END IF
            
            #其他table進行unlock
            
            CALL aapt510_unlock_b("xrcd_t","'3'")
            CALL s_transaction_end('Y','0')
            #add-point:單身page3 after_row2 name="input.body3.after_row2"
            
            #end add-point
 
         AFTER INPUT
            #add-point:input段after input  name="input.body3.after_input"
            
            #end add-point   
    
         ON ACTION controlo
            IF l_insert THEN
               LET li_reproduce = l_ac_t
               LET li_reproduce_target = l_ac
               LET g_apgb3_d[li_reproduce_target].* = g_apgb3_d[li_reproduce].*
 
               LET g_apgb3_d[li_reproduce_target].xrcdld = NULL
               LET g_apgb3_d[li_reproduce_target].xrcdseq = NULL
               LET g_apgb3_d[li_reproduce_target].xrcdseq2 = NULL
               LET g_apgb3_d[li_reproduce_target].xrcd007 = NULL
            ELSE
               CALL FGL_SET_ARR_CURR(g_apgb3_d.getLength()+1)
               LET lb_reproduce = TRUE
               LET li_reproduce = l_ac
               LET li_reproduce_target = g_apgb3_d.getLength()+1
            END IF
            
      END INPUT
 
      
 
 
 
 
{</section>}
 
{<section id="aapt510.input.other" >}
      
      #add-point:自定義input name="input.more_input"
      
      #end add-point
    
      BEFORE DIALOG 
         #CALL cl_err_collect_init()    
         #add-point:input段before dialog name="input.before_dialog"
         
         #end add-point    
         #重新導回資料到正確位置上
         CALL DIALOG.setCurrentRow("s_detail1",g_idx_group.getValue("'1',"))      
         CALL DIALOG.setCurrentRow("s_detail2",g_idx_group.getValue("'2',"))
         CALL DIALOG.setCurrentRow("s_detail3",g_idx_group.getValue("'3',"))
 
         #新增時強制從單頭開始填
         IF p_cmd = 'a' THEN
            #add-point:input段next_field name="input.next_field"
            
            #end add-point  
            NEXT FIELD apgacomp
         ELSE
            CASE g_aw
               WHEN "s_detail1"
                  NEXT FIELD apgbseq
               WHEN "s_detail2"
                  NEXT FIELD apgc900
               WHEN "s_detail3"
                  NEXT FIELD xrcdseq
 
               #add-point:input段modify_detail  name="input.modify_detail.other"
               
               #end add-point  
            END CASE
         END IF
      
      AFTER DIALOG
         #add-point:input段after_dialog name="input.after_dialog"
         
         #end add-point    
         
      ON ACTION controlf
         CALL cl_set_focus_form(ui.Interface.getRootNode()) RETURNING g_fld_name,g_frm_name
         CALL cl_fldhelp(g_frm_name,g_fld_name,g_lang)
 
      ON ACTION controlr
         CALL cl_show_req_fields()
 
      ON ACTION controls
         IF g_header_hidden THEN
            CALL gfrm_curr.setElementHidden("vb_master",0)
            CALL gfrm_curr.setElementImage("controls","small/arr-u.png")
            LET g_header_hidden = 0     #visible
         ELSE
            CALL gfrm_curr.setElementHidden("vb_master",1)
            CALL gfrm_curr.setElementImage("controls","small/arr-d.png")
            LET g_header_hidden = 1     #hidden     
         END IF
 
      ON ACTION accept
         #add-point:input段accept  name="input.accept"
         
         #end add-point    
         ACCEPT DIALOG
        
      ON ACTION cancel      #在dialog button (放棄)
         #add-point:input段cancel name="input.cancel"
         
         #end add-point  
         LET INT_FLAG = TRUE 
         LET g_detail_idx  = 1
         LET g_detail_idx2 = 1
         #各個page指標
         LET g_detail_idx_list[1] = 1 
         LET g_detail_idx_list[2] = 1
         LET g_detail_idx_list[3] = 1
 
         CALL g_curr_diag.setCurrentRow("s_detail1",1)    
         CALL g_curr_diag.setCurrentRow("s_detail2",1)
         CALL g_curr_diag.setCurrentRow("s_detail3",1)
 
         EXIT DIALOG
 
      ON ACTION close       #在dialog 右上角 (X)
         #add-point:input段close name="input.close"
         
         #end add-point  
         LET INT_FLAG = TRUE 
         EXIT DIALOG
 
      ON ACTION exit        #toolbar 離開
         #add-point:input段exit name="input.exit"
         
         #end add-point
         LET INT_FLAG = TRUE 
         LET g_detail_idx  = 1
         LET g_detail_idx2 = 1
         #各個page指標
         LET g_detail_idx_list[1] = 1 
         LET g_detail_idx_list[2] = 1
         LET g_detail_idx_list[3] = 1
 
         CALL g_curr_diag.setCurrentRow("s_detail1",1)    
         CALL g_curr_diag.setCurrentRow("s_detail2",1)
         CALL g_curr_diag.setCurrentRow("s_detail3",1)
 
         EXIT DIALOG
 
      #交談指令共用ACTION
      &include "common_action.4gl" 
         CONTINUE DIALOG 
   END DIALOG
    
   #add-point:input段after input  name="input.after_input"
   IF l_autoins THEN
      CONTINUE WHILE
   ELSE
      EXIT WHILE
   END IF

END WHILE
   #end add-point    
 
END FUNCTION
 
{</section>}
 
{<section id="aapt510.show" >}
#+ 單頭資料重新顯示及單身資料重抓
PRIVATE FUNCTION aapt510_show()
   #add-point:show段define(客製用) name="show.define_customerization"
   
   #end add-point  
   DEFINE l_ac_t    LIKE type_t.num10
   #add-point:show段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="show.define"
   DEFINE l_glaa005   LIKE glaa_t.glaa005  #albireo 160627 add
   #end add-point  
   
   #add-point:Function前置處理 name="show.before"
   
   #end add-point
   
   
   
   IF g_bfill = "Y" THEN
      CALL aapt510_b_fill() #單身填充
      CALL aapt510_b_fill2('0') #單身填充
   END IF
     
   #帶出公用欄位reference值
   #應用 a12 樣板自動產生(Version:4)
 
 
 
   
   #顯示followup圖示
   #應用 a48 樣板自動產生(Version:3)
   CALL aapt510_set_pk_array()
   #add-point:ON ACTION agendum name="show.follow_pic"
   #albireo 160627-----s
   LET l_glaa005 = NULL
   SELECT glaa005 INTO l_glaa005 FROM glaa_t
    WHERE glaaent  = g_enterprise
      AND glaacomp = g_apga_m.apgacomp
      AND glaa014  = 'Y'
   CALL s_desc_get_nmail004_desc(l_glaa005,g_apga_m.apga037) RETURNING g_apga_m.apga037_desc
   CALL s_desc_get_nmail004_desc(l_glaa005,g_apga_m.apga035) RETURNING g_apga_m.apga035_desc
   CALL s_desc_get_nmail004_desc(l_glaa005,g_apga_m.apga039) RETURNING g_apga_m.apga039_desc
   #albireo 160627-----e
   #END add-point
   CALL cl_user_overview_set_follow_pic()
  
 
 
 
   
   LET l_ac_t = l_ac
   
   #讀入ref值(單頭)
   #add-point:show段reference name="show.head.reference"
   
   #end add-point
   
   #遮罩相關處理
   LET g_apga_m_mask_o.* =  g_apga_m.*
   CALL aapt510_apga_t_mask()
   LET g_apga_m_mask_n.* =  g_apga_m.*
   
   #將資料輸出到畫面上
   DISPLAY BY NAME g_apga_m.apgacomp,g_apga_m.apgacomp_desc,g_apga_m.apga005,g_apga_m.apga005_desc,g_apga_m.apga006, 
       g_apga_m.apgadocno,g_apga_m.apga002,g_apga_m.apgadocdt,g_apga_m.apga003,g_apga_m.apga004,g_apga_m.apga004_desc, 
       g_apga_m.apga001,g_apga_m.apga028,g_apga_m.apga029,g_apga_m.apgastus,g_apga_m.apgaownid,g_apga_m.apgaownid_desc, 
       g_apga_m.apgaowndp,g_apga_m.apgaowndp_desc,g_apga_m.apgacrtid,g_apga_m.apgacrtid_desc,g_apga_m.apgacrtdp, 
       g_apga_m.apgacrtdp_desc,g_apga_m.apgacrtdt,g_apga_m.apgamodid,g_apga_m.apgamodid_desc,g_apga_m.apgamoddt, 
       g_apga_m.apgacnfid,g_apga_m.apgacnfid_desc,g_apga_m.apgacnfdt,g_apga_m.apgapstid,g_apga_m.apgapstid_desc, 
       g_apga_m.apgapstdt,g_apga_m.apga007,g_apga_m.apga007_desc,g_apga_m.apga030,g_apga_m.apga030_desc, 
       g_apga_m.apga008,g_apga_m.apga009,g_apga_m.apga013,g_apga_m.apga012,g_apga_m.apga010,g_apga_m.apga014, 
       g_apga_m.apga011,g_apga_m.apga100,g_apga_m.apga015,g_apga_m.apga103,g_apga_m.apga104,g_apga_m.apga108, 
       g_apga_m.apga102,g_apga_m.apga026,g_apga_m.apga040,g_apga_m.apga109,g_apga_m.glaa001,g_apga_m.apga101, 
       g_apga_m.apga113,g_apga_m.apga114,g_apga_m.apga118,g_apga_m.apga112,g_apga_m.apga105,g_apga_m.apga016, 
       g_apga_m.apga017,g_apga_m.apga018,g_apga_m.apga115,g_apga_m.apga106,g_apga_m.apga107,g_apga_m.apga019, 
       g_apga_m.apga020,g_apga_m.apga020_desc,g_apga_m.apga021,g_apga_m.apga022,g_apga_m.apga023,g_apga_m.apga024, 
       g_apga_m.apga025,g_apga_m.l_apga1041,g_apga_m.apga036,g_apga_m.apga036_desc,g_apga_m.apga037, 
       g_apga_m.apga037_desc,g_apga_m.apga032,g_apga_m.l_apga1081,g_apga_m.apga034,g_apga_m.apga034_desc, 
       g_apga_m.apga035,g_apga_m.apga035_desc,g_apga_m.apga031,g_apga_m.l_apga1021,g_apga_m.apga038, 
       g_apga_m.apga038_desc,g_apga_m.apga039,g_apga_m.apga039_desc,g_apga_m.apga033,g_apga_m.apga027 
 
   
   #顯示狀態(stus)圖片
         #應用 a21 樣板自動產生(Version:3)
	  #根據當下狀態碼顯示圖片
      CASE g_apga_m.apgastus 
         WHEN "N"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/unconfirmed.png")
         WHEN "Y"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/confirmed.png")
         WHEN "A"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/approved.png")
         WHEN "D"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/withdraw.png")
         WHEN "R"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/rejection.png")
         WHEN "W"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/signing.png")
         WHEN "X"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/invalid.png")
         
      END CASE
 
 
 
   
   #讀入ref值(單身)
   FOR l_ac = 1 TO g_apgb_d.getLength()
      #add-point:show段單身reference name="show.body.reference"
      
      #end add-point
   END FOR
   
   FOR l_ac = 1 TO g_apgb2_d.getLength()
      #add-point:show段單身reference name="show.body2.reference"
      
      #end add-point
   END FOR
   FOR l_ac = 1 TO g_apgb3_d.getLength()
      #add-point:show段單身reference name="show.body3.reference"
      
      #end add-point
   END FOR
 
   
    
   
   #add-point:show段other name="show.other"
   
   #end add-point  
   
   LET l_ac = l_ac_t
   
   #移動上下筆可以連動切換資料
   CALL cl_show_fld_cont()     
 
   CALL aapt510_detail_show()
 
   #add-point:show段之後 name="show.after"
   
   #end add-point
   
END FUNCTION
 
{</section>}
 
{<section id="aapt510.detail_show" >}
#+ 第二階單身reference
PRIVATE FUNCTION aapt510_detail_show()
   #add-point:detail_show段define(客製用) name="detail_show.define_customerization"
   
   #end add-point  
   #add-point:detail_show段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="detail_show.define"
   
   #end add-point  
   
   #add-point:Function前置處理 name="detail_show.before"
   
   #end add-point
   
   #add-point:detail_show段之後 name="detail_show.after"
   
   #end add-point
   
END FUNCTION
 
{</section>}
 
{<section id="aapt510.reproduce" >}
#+ 資料複製
PRIVATE FUNCTION aapt510_reproduce()
   #add-point:reproduce段define(客製用) name="reproduce.define_customerization"
   
   #end add-point   
   DEFINE l_newno     LIKE apga_t.apgacomp 
   DEFINE l_oldno     LIKE apga_t.apgacomp 
   DEFINE l_newno02     LIKE apga_t.apgadocno 
   DEFINE l_oldno02     LIKE apga_t.apgadocno 
 
   DEFINE l_master    RECORD LIKE apga_t.* #此變數樣板目前無使用
   DEFINE l_detail    RECORD LIKE apgb_t.* #此變數樣板目前無使用
   DEFINE l_detail2    RECORD LIKE apgc_t.* #此變數樣板目前無使用
 
   DEFINE l_detail3    RECORD LIKE xrcd_t.* #此變數樣板目前無使用
 
 
 
   DEFINE l_cnt       LIKE type_t.num10
   #add-point:reproduce段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="reproduce.define"
   
   #end add-point   
   
   #add-point:Function前置處理  name="reproduce.pre_function"
   
   #end add-point
   
   #切換畫面
   IF g_main_hidden THEN
      CALL gfrm_curr.setElementHidden("mainlayout",0)
      CALL gfrm_curr.setElementHidden("worksheet",1)
      LET g_main_hidden = 0
   END IF
   
   LET g_master_insert = FALSE
   
   IF g_apga_m.apgacomp IS NULL
   OR g_apga_m.apgadocno IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code = "std-00003" 
      LET g_errparam.popup = FALSE 
      CALL cl_err()
      RETURN
   END IF
    
   LET g_apgacomp_t = g_apga_m.apgacomp
   LET g_apgadocno_t = g_apga_m.apgadocno
 
    
   LET g_apga_m.apgacomp = ""
   LET g_apga_m.apgadocno = ""
 
 
   CALL cl_set_head_visible("","YES")
 
   #公用欄位給予預設值
   #應用 a14 樣板自動產生(Version:5)    
      #公用欄位新增給值  
      LET g_apga_m.apgaownid = g_user
      LET g_apga_m.apgaowndp = g_dept
      LET g_apga_m.apgacrtid = g_user
      LET g_apga_m.apgacrtdp = g_dept 
      LET g_apga_m.apgacrtdt = cl_get_current()
      LET g_apga_m.apgamodid = g_user
      LET g_apga_m.apgamoddt = cl_get_current()
      LET g_apga_m.apgastus = 'N'
 
 
 
   
   CALL s_transaction_begin()
   
   #add-point:複製輸入前 name="reproduce.head.b_input"
   LET g_apga_m.apga028 = ''     #160726-00020#16
   #end add-point
   
   #顯示狀態(stus)圖片
         #應用 a21 樣板自動產生(Version:3)
	  #根據當下狀態碼顯示圖片
      CASE g_apga_m.apgastus 
         WHEN "N"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/unconfirmed.png")
         WHEN "Y"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/confirmed.png")
         WHEN "A"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/approved.png")
         WHEN "D"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/withdraw.png")
         WHEN "R"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/rejection.png")
         WHEN "W"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/signing.png")
         WHEN "X"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/invalid.png")
         
      END CASE
 
 
 
   
   #清空key欄位的desc
      LET g_apga_m.apgacomp_desc = ''
   DISPLAY BY NAME g_apga_m.apgacomp_desc
 
   
   CALL aapt510_input("r")
   
   IF INT_FLAG AND NOT g_master_insert THEN
      LET INT_FLAG = 0
      DISPLAY g_detail_cnt  TO FORMONLY.h_count    #總筆數
      DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
      LET INT_FLAG = 0
      INITIALIZE g_apga_m.* TO NULL
      INITIALIZE g_apgb_d TO NULL
      INITIALIZE g_apgb2_d TO NULL
      INITIALIZE g_apgb3_d TO NULL
 
      #add-point:複製取消後 name="reproduce.cancel"
      
      #end add-point
      CALL aapt510_show()
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = '' 
      LET g_errparam.code = 9001 
      LET g_errparam.popup = FALSE 
      CALL s_transaction_end('N','0')
      CALL cl_err()
      RETURN
   END IF
   
   #根據資料狀態切換action狀態
   CALL cl_set_act_visible("statechange,modify,modify_detail,delete,reproduce", TRUE)
   CALL aapt510_set_act_visible()   
   CALL aapt510_set_act_no_visible()
   
   #將新增的資料併入搜尋條件中
   LET g_apgacomp_t = g_apga_m.apgacomp
   LET g_apgadocno_t = g_apga_m.apgadocno
 
   
   #組合新增資料的條件
   LET g_add_browse = " apgaent = " ||g_enterprise|| " AND",
                      " apgacomp = '", g_apga_m.apgacomp, "' "
                      ," AND apgadocno = '", g_apga_m.apgadocno, "' "
 
   #填到最後面
   LET g_current_idx = g_browser.getLength() + 1
   CALL aapt510_browser_fill("")
   
   DISPLAY g_browser_cnt TO FORMONLY.h_count    #總筆數
   DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
   CALL cl_navigator_setting(g_current_idx, g_browser_cnt)
   
   #add-point:完成複製段落後 name="reproduce.after_reproduce"
   
   #end add-point
   
   CALL aapt510_idx_chk()
   
   LET g_data_owner = g_apga_m.apgaownid      
   LET g_data_dept  = g_apga_m.apgaowndp
   
   #功能已完成,通報訊息中心
   CALL aapt510_msgcentre_notify('reproduce')
 
END FUNCTION
 
{</section>}
 
{<section id="aapt510.detail_reproduce" >}
#+ 單身自動複製
PRIVATE FUNCTION aapt510_detail_reproduce()
   #add-point:delete段define(客製用) name="detail_reproduce.define_customerization"
   
   #end add-point    
   DEFINE ls_sql      STRING
   DEFINE ld_date     DATETIME YEAR TO SECOND
   DEFINE l_detail    RECORD LIKE apgb_t.* #此變數樣板目前無使用
   DEFINE l_detail2    RECORD LIKE apgc_t.* #此變數樣板目前無使用
 
   DEFINE l_detail3    RECORD LIKE xrcd_t.* #此變數樣板目前無使用
 
 
 
   #add-point:delete段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="detail_reproduce.define"
   
   #end add-point    
   
   #add-point:Function前置處理  name="detail_reproduce.pre_function"
   
   #end add-point
   
   CALL s_transaction_begin()
   
   LET ld_date = cl_get_current()
   
   DROP TABLE aapt510_detail
   
   #add-point:單身複製前1 name="detail_reproduce.body.table1.b_insert"
   
   #end add-point
   
   #CREATE TEMP TABLE
   SELECT * FROM apgb_t
    WHERE apgbent = g_enterprise AND apgbcomp = g_apgacomp_t
     AND apgbdocno = g_apgadocno_t
 
    INTO TEMP aapt510_detail
 
   #將key修正為調整後   
   UPDATE aapt510_detail 
      #更新key欄位
      SET apgbcomp = g_apga_m.apgacomp
          , apgbdocno = g_apga_m.apgadocno
 
      #更新共用欄位
      
 
   #add-point:單身修改前 name="detail_reproduce.body.table1.b_update"
   
   #end add-point                                       
  
   #將資料塞回原table   
   INSERT INTO apgb_t SELECT * FROM aapt510_detail
   
   IF SQLCA.SQLCODE THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "reproduce:",SQLERRMESSAGE 
      LET g_errparam.code = SQLCA.SQLCODE 
      LET g_errparam.popup = TRUE 
      CALL cl_err()
      RETURN
   END IF
   
   #add-point:單身複製中1 name="detail_reproduce.body.table1.m_insert"
   
   #end add-point
   
   #刪除TEMP TABLE
   DROP TABLE aapt510_detail
   
   #add-point:單身複製後1 name="detail_reproduce.body.table1.a_insert"
   
   #end add-point
 
   #add-point:單身複製前 name="detail_reproduce.body.table2.b_insert"
   
   #end add-point
   
   #CREATE TEMP TABLE
   SELECT * FROM apgc_t 
    WHERE apgcent = g_enterprise AND apgccomp = g_apgacomp_t
      AND apgcdocno = g_apgadocno_t   
 
    INTO TEMP aapt510_detail
 
   #將key修正為調整後   
   UPDATE aapt510_detail SET apgccomp = g_apga_m.apgacomp
                                       , apgcdocno = g_apga_m.apgadocno
 
  
   #add-point:單身修改前 name="detail_reproduce.body.table2.b_update"
   
   #end add-point    
 
   #將資料塞回原table   
   INSERT INTO apgc_t SELECT * FROM aapt510_detail
   
   #add-point:單身複製中 name="detail_reproduce.body.table2.m_insert"
   
   #end add-point
   
   #刪除TEMP TABLE
   DROP TABLE aapt510_detail
   
   #add-point:單身複製後 name="detail_reproduce.body.table2.a_insert"
   
   #end add-point
 
   #add-point:單身複製前 name="detail_reproduce.body.table3.b_insert"
   
   #end add-point
   
   #CREATE TEMP TABLE
   SELECT * FROM xrcd_t 
    WHERE xrcdent = g_enterprise AND xrcdcomp = g_apgacomp_t
      AND xrcddocno = g_apgadocno_t   
 
    INTO TEMP aapt510_detail
 
   #將key修正為調整後   
   UPDATE aapt510_detail SET xrcdcomp = g_apga_m.apgacomp
                                       , xrcddocno = g_apga_m.apgadocno
 
  
   #add-point:單身修改前 name="detail_reproduce.body.table3.b_update"
   
   #end add-point    
 
   #將資料塞回原table   
   INSERT INTO xrcd_t SELECT * FROM aapt510_detail
   
   #add-point:單身複製中 name="detail_reproduce.body.table3.m_insert"
   
   #end add-point
   
   #刪除TEMP TABLE
   DROP TABLE aapt510_detail
   
   #add-point:單身複製後 name="detail_reproduce.body.table3.a_insert"
   
   #end add-point
 
 
   
 
   
   #多語言複製段落
   
   
   CALL s_transaction_end('Y','0')
   
   #已新增完, 調整資料內容(修改時使用)
   LET g_apgacomp_t = g_apga_m.apgacomp
   LET g_apgadocno_t = g_apga_m.apgadocno
 
   
END FUNCTION
 
{</section>}
 
{<section id="aapt510.delete" >}
#+ 資料刪除
PRIVATE FUNCTION aapt510_delete()
   #add-point:delete段define(客製用) name="delete.define_customerization"
   
   #end add-point     
   DEFINE  l_var_keys      DYNAMIC ARRAY OF STRING
   DEFINE  l_field_keys    DYNAMIC ARRAY OF STRING
   DEFINE  l_vars          DYNAMIC ARRAY OF STRING
   DEFINE  l_fields        DYNAMIC ARRAY OF STRING
   DEFINE  l_var_keys_bak  DYNAMIC ARRAY OF STRING
   #add-point:delete段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="delete.define"
   DEFINE l_ld    LIKE glaa_t.glaald
   #end add-point     
   
   #add-point:Function前置處理  name="delete.pre_function"
   
   #end add-point
   
   IF g_apga_m.apgacomp IS NULL
   OR g_apga_m.apgadocno IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code = "std-00003" 
      LET g_errparam.popup = FALSE 
      CALL cl_err()
      RETURN
   END IF
   
   
   
   CALL s_transaction_begin()
 
   OPEN aapt510_cl USING g_enterprise,g_apga_m.apgacomp,g_apga_m.apgadocno
   IF SQLCA.SQLCODE THEN   #(ver:78)
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "OPEN aapt510_cl:",SQLERRMESSAGE 
      LET g_errparam.code = SQLCA.SQLCODE   #(ver:78)
      LET g_errparam.popup = TRUE 
      CLOSE aapt510_cl
      CALL s_transaction_end('N','0')
      CALL cl_err()
      RETURN
   END IF
 
   #顯示最新的資料
   EXECUTE aapt510_master_referesh USING g_apga_m.apgacomp,g_apga_m.apgadocno INTO g_apga_m.apgacomp, 
       g_apga_m.apga005,g_apga_m.apga006,g_apga_m.apgadocno,g_apga_m.apga002,g_apga_m.apgadocdt,g_apga_m.apga003, 
       g_apga_m.apga004,g_apga_m.apga001,g_apga_m.apga028,g_apga_m.apga029,g_apga_m.apgastus,g_apga_m.apgaownid, 
       g_apga_m.apgaowndp,g_apga_m.apgacrtid,g_apga_m.apgacrtdp,g_apga_m.apgacrtdt,g_apga_m.apgamodid, 
       g_apga_m.apgamoddt,g_apga_m.apgacnfid,g_apga_m.apgacnfdt,g_apga_m.apgapstid,g_apga_m.apgapstdt, 
       g_apga_m.apga007,g_apga_m.apga030,g_apga_m.apga008,g_apga_m.apga009,g_apga_m.apga013,g_apga_m.apga012, 
       g_apga_m.apga010,g_apga_m.apga014,g_apga_m.apga011,g_apga_m.apga100,g_apga_m.apga015,g_apga_m.apga103, 
       g_apga_m.apga104,g_apga_m.apga108,g_apga_m.apga102,g_apga_m.apga026,g_apga_m.apga040,g_apga_m.apga109, 
       g_apga_m.apga101,g_apga_m.apga113,g_apga_m.apga114,g_apga_m.apga118,g_apga_m.apga112,g_apga_m.apga105, 
       g_apga_m.apga016,g_apga_m.apga017,g_apga_m.apga018,g_apga_m.apga115,g_apga_m.apga106,g_apga_m.apga107, 
       g_apga_m.apga019,g_apga_m.apga020,g_apga_m.apga021,g_apga_m.apga022,g_apga_m.apga023,g_apga_m.apga024, 
       g_apga_m.apga025,g_apga_m.apga036,g_apga_m.apga037,g_apga_m.apga032,g_apga_m.apga034,g_apga_m.apga035, 
       g_apga_m.apga031,g_apga_m.apga038,g_apga_m.apga039,g_apga_m.apga033,g_apga_m.apga027,g_apga_m.apgacomp_desc, 
       g_apga_m.apga005_desc,g_apga_m.apga004_desc,g_apga_m.apgaownid_desc,g_apga_m.apgaowndp_desc,g_apga_m.apgacrtid_desc, 
       g_apga_m.apgacrtdp_desc,g_apga_m.apgamodid_desc,g_apga_m.apgacnfid_desc,g_apga_m.apgapstid_desc, 
       g_apga_m.apga007_desc,g_apga_m.apga030_desc,g_apga_m.apga020_desc,g_apga_m.apga036_desc,g_apga_m.apga037_desc, 
       g_apga_m.apga034_desc,g_apga_m.apga035_desc,g_apga_m.apga038_desc,g_apga_m.apga039_desc
   
   
   #檢查是否允許此動作
   IF NOT aapt510_action_chk() THEN
      CALL s_transaction_end('N','0')
      RETURN
   END IF
   
   #遮罩相關處理
   LET g_apga_m_mask_o.* =  g_apga_m.*
   CALL aapt510_apga_t_mask()
   LET g_apga_m_mask_n.* =  g_apga_m.*
   
   CALL aapt510_show()
   
   #add-point:delete段before ask name="delete.before_ask"
   
   #end add-point 
 
   IF cl_ask_del_master() THEN              #確認一下
   
      #add-point:單頭刪除前 name="delete.head.b_delete"
      
      #end add-point   
      
      #應用 a47 樣板自動產生(Version:4)
      #刪除相關文件
      CALL aapt510_set_pk_array()
      #add-point:相關文件刪除前 name="delete.befroe.related_document_remove"
      
      #end add-point   
      CALL cl_doc_remove()  
 
 
 
  
  
      #資料備份
      LET g_apgacomp_t = g_apga_m.apgacomp
      LET g_apgadocno_t = g_apga_m.apgadocno
 
 
      DELETE FROM apga_t
       WHERE apgaent = g_enterprise AND apgacomp = g_apga_m.apgacomp
         AND apgadocno = g_apga_m.apgadocno
 
       
      #add-point:單頭刪除中 name="delete.head.m_delete"
      
      #end add-point
       
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = g_apga_m.apgacomp,":",SQLERRMESSAGE  
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = FALSE 
         CALL s_transaction_end('N','0')
         CALL cl_err()
         RETURN
      END IF
      
      #add-point:單頭刪除後 name="delete.head.a_delete"
      LET l_ld = NULL
      SELECT glaald INTO l_ld FROM glaa_t
       WHERE glaaent = g_enterprise
         AND glaacomp = g_apga_m.apgacomp
         AND glaa014 = 'Y'
      IF NOT s_aooi200_fin_del_docno(l_ld,g_apga_m.apgadocno,g_apga_m.apgadocdt) THEN
         CALL s_transaction_end('N','0')
         RETURN
      END IF
      #end add-point
  
      #add-point:單身刪除前 name="delete.body.b_delete"
      
      #end add-point
      
      DELETE FROM apgb_t
       WHERE apgbent = g_enterprise AND apgbcomp = g_apga_m.apgacomp
         AND apgbdocno = g_apga_m.apgadocno
 
 
      #add-point:單身刪除中 name="delete.body.m_delete"
      
      #end add-point
         
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "apgb_t:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = FALSE 
         CALL s_transaction_end('N','0')
         CALL cl_err()
         RETURN
      END IF    
 
      #add-point:單身刪除後 name="delete.body.a_delete"
      
      #end add-point
      
            
                                                               
      #add-point:單身刪除前 name="delete.body.b_delete2"
      
      #end add-point
      DELETE FROM apgc_t
       WHERE apgcent = g_enterprise AND
             apgccomp = g_apga_m.apgacomp AND apgcdocno = g_apga_m.apgadocno
      #add-point:單身刪除中 name="delete.body.m_delete2"
      
      #end add-point
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "apgc_t:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = FALSE 
         CALL s_transaction_end('N','0')
         CALL cl_err()
         RETURN
      END IF      
 
      #add-point:單身刪除後 name="delete.body.a_delete2"
      
      #end add-point
 
      #add-point:單身刪除前 name="delete.body.b_delete3"
      
      #end add-point
      DELETE FROM xrcd_t
       WHERE xrcdent = g_enterprise AND
             xrcdcomp = g_apga_m.apgacomp AND xrcddocno = g_apga_m.apgadocno
      #add-point:單身刪除中 name="delete.body.m_delete3"
      
      #end add-point
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "xrcd_t:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = FALSE 
         CALL s_transaction_end('N','0')
         CALL cl_err()
         RETURN
      END IF      
 
      #add-point:單身刪除後 name="delete.body.a_delete3"
      
      #end add-point
 
 
 
 
      
      #修改歷程記錄(刪除)
      LET g_log1 = util.JSON.stringify(g_apga_m)   #(ver:78)
      IF NOT cl_log_modified_record(g_log1,'') THEN    #(ver:78)
         CLOSE aapt510_cl
         CALL s_transaction_end('N','0')
         RETURN
      END IF
             
      CLEAR FORM
      CALL g_apgb_d.clear() 
      CALL g_apgb2_d.clear()       
      CALL g_apgb3_d.clear()       
 
     
      CALL aapt510_ui_browser_refresh()  
      #CALL aapt510_ui_headershow()  
      #CALL aapt510_ui_detailshow()
 
      #add-point:多語言刪除 name="delete.lang.before_delete"
      
      #end add-point
      
      #單頭多語言刪除
      
      
      #單身多語言刪除
      
      
      
 
   
      #add-point:多語言刪除 name="delete.lang.delete"
      
      #end add-point
      
      IF g_browser_cnt > 0 THEN 
         #CALL aapt510_browser_fill("")
         CALL aapt510_fetch('P')
         DISPLAY g_browser_cnt TO FORMONLY.h_count   #總筆數的顯示
         DISPLAY g_browser_cnt TO FORMONLY.b_count   #總筆數的顯示
      ELSE
         CLEAR FORM
      END IF
      
      CALL s_transaction_end('Y','0')
   ELSE
      CALL s_transaction_end('N','0')
   END IF
 
   CLOSE aapt510_cl
 
   #功能已完成,通報訊息中心
   CALL aapt510_msgcentre_notify('delete')
    
END FUNCTION
 
{</section>}
 
{<section id="aapt510.b_fill" >}
#+ 單身陣列填充
PRIVATE FUNCTION aapt510_b_fill()
   #add-point:b_fill段define(客製用) name="b_fill.define_customerization"
   
   #end add-point     
   DEFINE p_wc2      STRING
   DEFINE li_idx     LIKE type_t.num10
   #add-point:b_fill段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="b_fill.define"
   DEFINE l_ld       LIKE glaa_t.glaald
   DEFINE l_glaa005  LIKE glaa_t.glaa005
   DEFINE l_ooef019  LIKE ooef_t.ooef019
   #end add-point     
   
   #add-point:Function前置處理  name="b_fill.pre_function"
   LET l_ld = NULL    LET l_glaa005 = NULL
   SELECT glaald ,glaa005 INTO l_ld,l_glaa005
     FROM glaa_t
    WHERE glaaent = g_enterprise
      AND glaacomp = g_apga_m.apgacomp
      AND glaa014 = 'Y'
   
   LET l_ooef019 = NULL
   SELECT ooef019 INTO l_ooef019 FROM ooef_t
    WHERE ooefent = g_enterprise
      AND ooef001 = g_apga_m.apgacomp
   #end add-point
   
   #清空第一階單身
   CALL g_apgb_d.clear()
   CALL g_apgb2_d.clear()
   CALL g_apgb3_d.clear()
 
 
   #add-point:b_fill段sql_before name="b_fill.sql_before"
   
   #end add-point
   
   #判斷是否填充
   IF aapt510_fill_chk(1) THEN
      #切換上下筆時不重組SQL
      IF (g_action_choice = "query" OR cl_null(g_action_choice))
      #add-point:b_fill段long_sql_if name="b_fill.long_sql_if"
      
      #end add-point
      THEN
         LET g_sql = "SELECT  DISTINCT apgbseq,apgborga,apgb001,apgb002,apgb003,apgb004,apgb005,apgb008, 
             apgb006,apgb007,apgb100,apgb101,apgb009,apgb105,apgb115,apgb010,apgb011 ,t1.ooefl003 FROM apgb_t", 
                
                     " INNER JOIN apga_t ON apgaent = " ||g_enterprise|| " AND apgacomp = apgbcomp ",
                     " AND apgadocno = apgbdocno ",
 
                     #"",
                     
                     "",
                     #下層單身所需的join條件
 
                                    " LEFT JOIN ooefl_t t1 ON t1.ooeflent="||g_enterprise||" AND t1.ooefl001=apgborga AND t1.ooefl002='"||g_dlang||"' ",
 
                     " WHERE apgbent=? AND apgbcomp=? AND apgbdocno=?"
         LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
         #add-point:b_fill段sql_before name="b_fill.body.fill_sql"
         
         #end add-point
         IF NOT cl_null(g_wc2_table1) THEN
            LET g_sql = g_sql CLIPPED, " AND ", g_wc2_table1 CLIPPED
         END IF
         
         #子單身的WC
         
         
         LET g_sql = g_sql, " ORDER BY apgb_t.apgbseq"
         
         #add-point:單身填充控制 name="b_fill.sql"
         
         #end add-point
         
         LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
         PREPARE aapt510_pb FROM g_sql
         DECLARE b_fill_cs CURSOR FOR aapt510_pb
      END IF
      
      LET g_cnt = l_ac
      LET l_ac = 1
      
   #  OPEN b_fill_cs USING g_enterprise,g_apga_m.apgacomp,g_apga_m.apgadocno   #(ver:78)
                                               
      FOREACH b_fill_cs USING g_enterprise,g_apga_m.apgacomp,g_apga_m.apgadocno INTO g_apgb_d[l_ac].apgbseq, 
          g_apgb_d[l_ac].apgborga,g_apgb_d[l_ac].apgb001,g_apgb_d[l_ac].apgb002,g_apgb_d[l_ac].apgb003, 
          g_apgb_d[l_ac].apgb004,g_apgb_d[l_ac].apgb005,g_apgb_d[l_ac].apgb008,g_apgb_d[l_ac].apgb006, 
          g_apgb_d[l_ac].apgb007,g_apgb_d[l_ac].apgb100,g_apgb_d[l_ac].apgb101,g_apgb_d[l_ac].apgb009, 
          g_apgb_d[l_ac].apgb105,g_apgb_d[l_ac].apgb115,g_apgb_d[l_ac].apgb010,g_apgb_d[l_ac].apgb011, 
          g_apgb_d[l_ac].apgborga_desc   #(ver:78)
         IF SQLCA.SQLCODE THEN
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "FOREACH:",SQLERRMESSAGE 
            LET g_errparam.code = SQLCA.SQLCODE 
            LET g_errparam.popup = TRUE 
            CALL cl_err()
            EXIT FOREACH
         END IF
        
         #add-point:b_fill段資料填充 name="b_fill.fill"
         
         #end add-point
      
         IF l_ac > g_max_rec THEN
            IF g_error_show = 1 THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = l_ac
               LET g_errparam.code = 9035 
               LET g_errparam.popup = TRUE 
               CALL cl_err()
            END IF
            EXIT FOREACH
         END IF
         
         LET l_ac = l_ac + 1
      END FOREACH
      LET g_error_show = 0
   
   END IF
    
   #判斷是否填充
   IF aapt510_fill_chk(2) THEN
      IF (g_action_choice = "query" OR cl_null(g_action_choice))
         #add-point:b_fill段long_sql_if name="b_fill.body2.long_sql_if"
         
         #end add-point
      THEN
         LET g_sql = "SELECT  DISTINCT apgc900,apgcseq,apgcorga,apgc001,apgc002,apgc003,apgc005,apgc014, 
             apgc100,apgc101,apgc006,apgc007,apgc008,apgc009,apgc010,apgc011,apgc103,apgc104,apgc105, 
             apgc113,apgc114,apgc115,apgc004,apgc015,apgc016,apgc012,apgc013 ,t2.oocql004 FROM apgc_t", 
                
                     " INNER JOIN  apga_t ON apgaent = " ||g_enterprise|| " AND apgacomp = apgccomp ",
                     " AND apgadocno = apgcdocno ",
 
                     "",
                     
                                    " LEFT JOIN oocql_t t2 ON t2.oocqlent="||g_enterprise||" AND t2.oocql001='3117' AND t2.oocql002=apgc001 AND t2.oocql003='"||g_dlang||"' ",
 
                     " WHERE apgcent=? AND apgccomp=? AND apgcdocno=?"   
         LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
         #add-point:b_fill段fill_sql name="b_fill.body2.fill_sql"
         LET g_sql = g_sql," AND apgc900 = 0 "
         #end add-point
         IF NOT cl_null(g_wc2_table2) THEN
            LET g_sql = g_sql CLIPPED," AND ",g_wc2_table2 CLIPPED
         END IF
         
         #子單身的WC
         
         
         LET g_sql = g_sql, " ORDER BY apgc_t.apgcseq,apgc_t.apgc900"
         
         #add-point:單身填充控制 name="b_fill.sql2"
         
         #end add-point
         
         LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
         PREPARE aapt510_pb2 FROM g_sql
         DECLARE b_fill_cs2 CURSOR FOR aapt510_pb2
      END IF
    
      LET l_ac = 1
      
   #  OPEN b_fill_cs2 USING g_enterprise,g_apga_m.apgacomp,g_apga_m.apgadocno   #(ver:78)
                                               
      FOREACH b_fill_cs2 USING g_enterprise,g_apga_m.apgacomp,g_apga_m.apgadocno INTO g_apgb2_d[l_ac].apgc900, 
          g_apgb2_d[l_ac].apgcseq,g_apgb2_d[l_ac].apgcorga,g_apgb2_d[l_ac].apgc001,g_apgb2_d[l_ac].apgc002, 
          g_apgb2_d[l_ac].apgc003,g_apgb2_d[l_ac].apgc005,g_apgb2_d[l_ac].apgc014,g_apgb2_d[l_ac].apgc100, 
          g_apgb2_d[l_ac].apgc101,g_apgb2_d[l_ac].apgc006,g_apgb2_d[l_ac].apgc007,g_apgb2_d[l_ac].apgc008, 
          g_apgb2_d[l_ac].apgc009,g_apgb2_d[l_ac].apgc010,g_apgb2_d[l_ac].apgc011,g_apgb2_d[l_ac].apgc103, 
          g_apgb2_d[l_ac].apgc104,g_apgb2_d[l_ac].apgc105,g_apgb2_d[l_ac].apgc113,g_apgb2_d[l_ac].apgc114, 
          g_apgb2_d[l_ac].apgc115,g_apgb2_d[l_ac].apgc004,g_apgb2_d[l_ac].apgc015,g_apgb2_d[l_ac].apgc016, 
          g_apgb2_d[l_ac].apgc012,g_apgb2_d[l_ac].apgc013,g_apgb2_d[l_ac].apgc001_desc   #(ver:78)
         IF SQLCA.SQLCODE THEN
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "FOREACH:",SQLERRMESSAGE 
            LET g_errparam.code = SQLCA.SQLCODE 
            LET g_errparam.popup = TRUE 
            CALL cl_err()
            EXIT FOREACH
         END IF
        
         #add-point:b_fill段資料填充 name="b_fill2.fill"
         CALL s_desc_get_account_desc(l_ld,g_apgb2_d[l_ac].apgc004) RETURNING g_apgb2_d[l_ac].apgc004_desc
         LET g_apgb2_d[l_ac].apgc015_desc = s_desc_get_nmajl003_desc(g_apgb2_d[l_ac].apgc015)
         LET g_apgb2_d[l_ac].apgc016_desc = s_desc_get_nmail004_desc(l_glaa005,g_apgb2_d[l_ac].apgc016)         
         #end add-point
      
         LET l_ac = l_ac + 1
         IF l_ac > g_max_rec THEN
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = l_ac
            LET g_errparam.code = 9035 
            LET g_errparam.popup = TRUE 
            CALL cl_err()
            EXIT FOREACH
         END IF
         
      END FOREACH
   END IF
 
   #判斷是否填充
   IF aapt510_fill_chk(3) THEN
      IF (g_action_choice = "query" OR cl_null(g_action_choice))
         #add-point:b_fill段long_sql_if name="b_fill.body3.long_sql_if"
         
         #end add-point
      THEN
         LET g_sql = "SELECT  DISTINCT xrcdseq,xrcdseq2,xrcd007,xrcdld,xrcd002,xrcd003,xrcd006,xrcd005, 
             xrcd102,xrcd103,xrcd104,xrcd105,xrcd113,xrcd114,xrcd115,xrcd123,xrcd124,xrcd125,xrcd133, 
             xrcd134,xrcd135,xrcdorga,xrcd009,xrcd001,xrcd004,xrcd100,xrcd101,xrcd106,xrcd112,xrcd116, 
             xrcd117,xrcd118,xrcd121,xrcd131,xrcdsite ,t3.oodbl004 ,t4.glacl004 FROM xrcd_t",   
                     " INNER JOIN  apga_t ON apgaent = " ||g_enterprise|| " AND apgacomp = xrcdcomp ",
                     " AND apgadocno = xrcddocno ",
 
                     "",
                     
                                    " LEFT JOIN oodbl_t t3 ON t3.oodblent="||g_enterprise||" AND t3.oodbl001='2' AND t3.oodbl002=xrcd002 AND t3.oodbl003='"||g_dlang||"' ",
               " LEFT JOIN glacl_t t4 ON t4.glaclent="||g_enterprise||" AND t4.glacl001='' AND t4.glacl002=xrcd009 AND t4.glacl003='"||g_dlang||"' ",
 
                     " WHERE xrcdent=? AND xrcdcomp=? AND xrcddocno=?"   
         LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
         #add-point:b_fill段fill_sql name="b_fill.body3.fill_sql"
         LET g_sql = g_sql," AND xrcdseq2 = 0 "
         #end add-point
         IF NOT cl_null(g_wc2_table3) THEN
            LET g_sql = g_sql CLIPPED," AND ",g_wc2_table3 CLIPPED
         END IF
         
         #子單身的WC
         
         
         LET g_sql = g_sql, " ORDER BY xrcd_t.xrcdld,xrcd_t.xrcdseq,xrcd_t.xrcdseq2,xrcd_t.xrcd007"
         
         #add-point:單身填充控制 name="b_fill.sql3"
         
         #end add-point
         
         LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
         PREPARE aapt510_pb3 FROM g_sql
         DECLARE b_fill_cs3 CURSOR FOR aapt510_pb3
      END IF
    
      LET l_ac = 1
      
   #  OPEN b_fill_cs3 USING g_enterprise,g_apga_m.apgacomp,g_apga_m.apgadocno   #(ver:78)
                                               
      FOREACH b_fill_cs3 USING g_enterprise,g_apga_m.apgacomp,g_apga_m.apgadocno INTO g_apgb3_d[l_ac].xrcdseq, 
          g_apgb3_d[l_ac].xrcdseq2,g_apgb3_d[l_ac].xrcd007,g_apgb3_d[l_ac].xrcdld,g_apgb3_d[l_ac].xrcd002, 
          g_apgb3_d[l_ac].xrcd003,g_apgb3_d[l_ac].xrcd006,g_apgb3_d[l_ac].xrcd005,g_apgb3_d[l_ac].xrcd102, 
          g_apgb3_d[l_ac].xrcd103,g_apgb3_d[l_ac].xrcd104,g_apgb3_d[l_ac].xrcd105,g_apgb3_d[l_ac].xrcd113, 
          g_apgb3_d[l_ac].xrcd114,g_apgb3_d[l_ac].xrcd115,g_apgb3_d[l_ac].xrcd123,g_apgb3_d[l_ac].xrcd124, 
          g_apgb3_d[l_ac].xrcd125,g_apgb3_d[l_ac].xrcd133,g_apgb3_d[l_ac].xrcd134,g_apgb3_d[l_ac].xrcd135, 
          g_apgb3_d[l_ac].xrcdorga,g_apgb3_d[l_ac].xrcd009,g_apgb3_d[l_ac].xrcd001,g_apgb3_d[l_ac].xrcd004, 
          g_apgb3_d[l_ac].xrcd100,g_apgb3_d[l_ac].xrcd101,g_apgb3_d[l_ac].xrcd106,g_apgb3_d[l_ac].xrcd112, 
          g_apgb3_d[l_ac].xrcd116,g_apgb3_d[l_ac].xrcd117,g_apgb3_d[l_ac].xrcd118,g_apgb3_d[l_ac].xrcd121, 
          g_apgb3_d[l_ac].xrcd131,g_apgb3_d[l_ac].xrcdsite,g_apgb3_d[l_ac].xrcd002_desc,g_apgb3_d[l_ac].xrcd009_desc  
            #(ver:78)
         IF SQLCA.SQLCODE THEN
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "FOREACH:",SQLERRMESSAGE 
            LET g_errparam.code = SQLCA.SQLCODE 
            LET g_errparam.popup = TRUE 
            CALL cl_err()
            EXIT FOREACH
         END IF
        
         #add-point:b_fill段資料填充 name="b_fill3.fill"
         LET g_apgb3_d[l_ac].xrcd002_desc = s_desc_get_tax_desc(l_ooef019,g_apgb3_d[l_ac].xrcd002)
         LET g_apgb3_d[l_ac].xrcd009_desc = s_desc_get_account_desc(l_ld,g_apgb3_d[l_ac].xrcd009)
         #end add-point
      
         LET l_ac = l_ac + 1
         IF l_ac > g_max_rec THEN
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = l_ac
            LET g_errparam.code = 9035 
            LET g_errparam.popup = TRUE 
            CALL cl_err()
            EXIT FOREACH
         END IF
         
      END FOREACH
   END IF
 
 
   
   #add-point:browser_fill段其他table處理 name="browser_fill.other_fill"
   
   #end add-point
   
   CALL g_apgb_d.deleteElement(g_apgb_d.getLength())
   CALL g_apgb2_d.deleteElement(g_apgb2_d.getLength())
   CALL g_apgb3_d.deleteElement(g_apgb3_d.getLength())
 
   
 
   LET l_ac = g_cnt
   LET g_cnt = 0  
   
   FREE aapt510_pb
   FREE aapt510_pb2
 
   FREE aapt510_pb3
 
 
   
   LET li_idx = l_ac
   
   #遮罩相關處理
   FOR l_ac = 1 TO g_apgb_d.getLength()
      LET g_apgb_d_mask_o[l_ac].* =  g_apgb_d[l_ac].*
      CALL aapt510_apgb_t_mask()
      LET g_apgb_d_mask_n[l_ac].* =  g_apgb_d[l_ac].*
   END FOR
   
   LET g_apgb2_d_mask_o.* =  g_apgb2_d.*
   FOR l_ac = 1 TO g_apgb2_d.getLength()
      LET g_apgb2_d_mask_o[l_ac].* =  g_apgb2_d[l_ac].*
      CALL aapt510_apgc_t_mask()
      LET g_apgb2_d_mask_n[l_ac].* =  g_apgb2_d[l_ac].*
   END FOR
   LET g_apgb3_d_mask_o.* =  g_apgb3_d.*
   FOR l_ac = 1 TO g_apgb3_d.getLength()
      LET g_apgb3_d_mask_o[l_ac].* =  g_apgb3_d[l_ac].*
      CALL aapt510_xrcd_t_mask()
      LET g_apgb3_d_mask_n[l_ac].* =  g_apgb3_d[l_ac].*
   END FOR
 
   
   LET l_ac = li_idx
   
   CALL cl_ap_performance_next_end()
 
END FUNCTION
 
{</section>}
 
{<section id="aapt510.delete_b" >}
#+ 刪除單身後其他table連動
PRIVATE FUNCTION aapt510_delete_b(ps_table,ps_keys_bak,ps_page)
   #add-point:delete_b段define(客製用) name="delete_b.define_customerization"
   
   #end add-point     
   DEFINE ps_table    STRING
   DEFINE ps_page     STRING
   DEFINE ps_keys_bak DYNAMIC ARRAY OF VARCHAR(500)
   DEFINE ls_group    STRING
   DEFINE li_idx      LIKE type_t.num10
   #add-point:delete_b段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="delete_b.define"
   
   #end add-point     
   
   #add-point:Function前置處理  name="delete_b.pre_function"
   
   #end add-point
   
   LET g_update = TRUE  
   
   #判斷是否是同一群組的table
   LET ls_group = "'1',"
   IF ls_group.getIndexOf(ps_page,1) > 0 THEN
      #add-point:delete_b段刪除前 name="delete_b.b_delete"
      
      #end add-point    
      DELETE FROM apgb_t
       WHERE apgbent = g_enterprise AND
         apgbcomp = ps_keys_bak[1] AND apgbdocno = ps_keys_bak[2] AND apgbseq = ps_keys_bak[3]
      #add-point:delete_b段刪除中 name="delete_b.m_delete"
      
      #end add-point    
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = ":",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = FALSE 
         CALL cl_err()
         RETURN FALSE
      END IF
      LET li_idx = g_detail_idx
      IF ps_page <> "'1'" THEN 
         CALL g_apgb_d.deleteElement(li_idx) 
      END IF 
 
   END IF
   
   LET ls_group = "'2',"
   #判斷是否是同一群組的table
   IF ls_group.getIndexOf(ps_page,1) > 0 THEN
      #add-point:delete_b段刪除前 name="delete_b.b_delete2"
      
      #end add-point    
      DELETE FROM apgc_t
       WHERE apgcent = g_enterprise AND
             apgccomp = ps_keys_bak[1] AND apgcdocno = ps_keys_bak[2] AND apgcseq = ps_keys_bak[3] AND apgc900 = ps_keys_bak[4]
      #add-point:delete_b段刪除中 name="delete_b.m_delete2"
      
      #end add-point    
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "apgc_t:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = FALSE 
         CALL cl_err()
         RETURN FALSE
      END IF
      
      LET li_idx = g_detail_idx
      IF ps_page <> "'2'" THEN 
         CALL g_apgb2_d.deleteElement(li_idx) 
      END IF 
 
      #add-point:delete_b段刪除後 name="delete_b.a_delete2"
      
      #end add-point    
   END IF
 
   LET ls_group = "'3',"
   #判斷是否是同一群組的table
   IF ls_group.getIndexOf(ps_page,1) > 0 THEN
      #add-point:delete_b段刪除前 name="delete_b.b_delete3"
      
      #end add-point    
      DELETE FROM xrcd_t
       WHERE xrcdent = g_enterprise AND
             xrcdcomp = ps_keys_bak[1] AND xrcddocno = ps_keys_bak[2] AND xrcdld = ps_keys_bak[3] AND xrcdseq = ps_keys_bak[4] AND xrcdseq2 = ps_keys_bak[5] AND xrcd007 = ps_keys_bak[6]
      #add-point:delete_b段刪除中 name="delete_b.m_delete3"
      
      #end add-point    
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "xrcd_t:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = FALSE 
         CALL cl_err()
         RETURN FALSE
      END IF
      
      LET li_idx = g_detail_idx
      IF ps_page <> "'3'" THEN 
         CALL g_apgb3_d.deleteElement(li_idx) 
      END IF 
 
      #add-point:delete_b段刪除後 name="delete_b.a_delete3"
      
      #end add-point    
   END IF
 
 
   
 
   
   #add-point:delete_b段other name="delete_b.other"
   
   #end add-point  
   
   RETURN TRUE
   
END FUNCTION
 
{</section>}
 
{<section id="aapt510.insert_b" >}
#+ 新增單身後其他table連動
PRIVATE FUNCTION aapt510_insert_b(ps_table,ps_keys,ps_page)
   #add-point:insert_b段define(客製用) name="insert_b.define_customerization"
   
   #end add-point     
   DEFINE ps_table    STRING
   DEFINE ps_page     STRING
   DEFINE ps_keys     DYNAMIC ARRAY OF VARCHAR(500)
   DEFINE ls_group    STRING
   DEFINE ls_page     STRING
   DEFINE li_idx      LIKE type_t.num10
   #add-point:insert_b段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="insert_b.define"
   
   #end add-point     
   
   #add-point:Function前置處理  name="insert_b.pre_function"
   
   #end add-point
   
   LET g_update = TRUE  
   
   #判斷是否是同一群組的table
   LET ls_group = "'1',"
   IF ls_group.getIndexOf(ps_page,1) > 0 THEN
      #add-point:insert_b段資料新增前 name="insert_b.before_insert"
      LET g_apgb_d[g_detail_idx].apgb011 = 0 
      #end add-point 
      INSERT INTO apgb_t
                  (apgbent,
                   apgbcomp,apgbdocno,
                   apgbseq
                   ,apgborga,apgb001,apgb002,apgb003,apgb004,apgb005,apgb008,apgb006,apgb007,apgb100,apgb101,apgb009,apgb105,apgb115,apgb010,apgb011) 
            VALUES(g_enterprise,
                   ps_keys[1],ps_keys[2],ps_keys[3]
                   ,g_apgb_d[g_detail_idx].apgborga,g_apgb_d[g_detail_idx].apgb001,g_apgb_d[g_detail_idx].apgb002, 
                       g_apgb_d[g_detail_idx].apgb003,g_apgb_d[g_detail_idx].apgb004,g_apgb_d[g_detail_idx].apgb005, 
                       g_apgb_d[g_detail_idx].apgb008,g_apgb_d[g_detail_idx].apgb006,g_apgb_d[g_detail_idx].apgb007, 
                       g_apgb_d[g_detail_idx].apgb100,g_apgb_d[g_detail_idx].apgb101,g_apgb_d[g_detail_idx].apgb009, 
                       g_apgb_d[g_detail_idx].apgb105,g_apgb_d[g_detail_idx].apgb115,g_apgb_d[g_detail_idx].apgb010, 
                       g_apgb_d[g_detail_idx].apgb011)
      #add-point:insert_b段資料新增中 name="insert_b.m_insert"
      
      #end add-point 
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "apgb_t:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = FALSE 
         CALL cl_err()
      END IF
      
      LET li_idx = g_detail_idx
      IF ps_page <> "'1'" THEN 
         CALL g_apgb_d.insertElement(li_idx) 
      END IF 
 
      #add-point:insert_b段資料新增後 name="insert_b.after_insert"
      
      #end add-point 
   END IF
   
   LET ls_group = "'2',"
   #判斷是否是同一群組的table
   IF ls_group.getIndexOf(ps_page,1) > 0 THEN
      #add-point:insert_b段資料新增前 name="insert_b.before_insert2"
      
      #end add-point 
      INSERT INTO apgc_t
                  (apgcent,
                   apgccomp,apgcdocno,
                   apgcseq,apgc900
                   ,apgcorga,apgc001,apgc002,apgc003,apgc005,apgc014,apgc100,apgc101,apgc006,apgc007,apgc008,apgc009,apgc010,apgc011,apgc103,apgc104,apgc105,apgc113,apgc114,apgc115,apgc004,apgc015,apgc016,apgc012,apgc013) 
            VALUES(g_enterprise,
                   ps_keys[1],ps_keys[2],ps_keys[3],ps_keys[4]
                   ,g_apgb2_d[g_detail_idx].apgcorga,g_apgb2_d[g_detail_idx].apgc001,g_apgb2_d[g_detail_idx].apgc002, 
                       g_apgb2_d[g_detail_idx].apgc003,g_apgb2_d[g_detail_idx].apgc005,g_apgb2_d[g_detail_idx].apgc014, 
                       g_apgb2_d[g_detail_idx].apgc100,g_apgb2_d[g_detail_idx].apgc101,g_apgb2_d[g_detail_idx].apgc006, 
                       g_apgb2_d[g_detail_idx].apgc007,g_apgb2_d[g_detail_idx].apgc008,g_apgb2_d[g_detail_idx].apgc009, 
                       g_apgb2_d[g_detail_idx].apgc010,g_apgb2_d[g_detail_idx].apgc011,g_apgb2_d[g_detail_idx].apgc103, 
                       g_apgb2_d[g_detail_idx].apgc104,g_apgb2_d[g_detail_idx].apgc105,g_apgb2_d[g_detail_idx].apgc113, 
                       g_apgb2_d[g_detail_idx].apgc114,g_apgb2_d[g_detail_idx].apgc115,g_apgb2_d[g_detail_idx].apgc004, 
                       g_apgb2_d[g_detail_idx].apgc015,g_apgb2_d[g_detail_idx].apgc016,g_apgb2_d[g_detail_idx].apgc012, 
                       g_apgb2_d[g_detail_idx].apgc013)
      #add-point:insert_b段資料新增中 name="insert_b.m_insert2"
      
      #end add-point
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "apgc_t:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = FALSE 
         CALL cl_err()
      END IF
      
      LET li_idx = g_detail_idx
      IF ps_page <> "'2'" THEN 
         CALL g_apgb2_d.insertElement(li_idx) 
      END IF 
 
      #add-point:insert_b段資料新增後 name="insert_b.after_insert2"
      
      #end add-point
   END IF
 
   LET ls_group = "'3',"
   #判斷是否是同一群組的table
   IF ls_group.getIndexOf(ps_page,1) > 0 THEN
      #add-point:insert_b段資料新增前 name="insert_b.before_insert3"
      
      #end add-point 
      INSERT INTO xrcd_t
                  (xrcdent,
                   xrcdcomp,xrcddocno,
                   xrcdld,xrcdseq,xrcdseq2,xrcd007
                   ,xrcd002,xrcd003,xrcd006,xrcd005,xrcd102,xrcd103,xrcd104,xrcd105,xrcd113,xrcd114,xrcd115,xrcd123,xrcd124,xrcd125,xrcd133,xrcd134,xrcd135,xrcdorga,xrcd009,xrcd001,xrcd004,xrcd100,xrcd101,xrcd106,xrcd112,xrcd116,xrcd117,xrcd118,xrcd121,xrcd131,xrcdsite) 
            VALUES(g_enterprise,
                   ps_keys[1],ps_keys[2],ps_keys[3],ps_keys[4],ps_keys[5],ps_keys[6]
                   ,g_apgb3_d[g_detail_idx].xrcd002,g_apgb3_d[g_detail_idx].xrcd003,g_apgb3_d[g_detail_idx].xrcd006, 
                       g_apgb3_d[g_detail_idx].xrcd005,g_apgb3_d[g_detail_idx].xrcd102,g_apgb3_d[g_detail_idx].xrcd103, 
                       g_apgb3_d[g_detail_idx].xrcd104,g_apgb3_d[g_detail_idx].xrcd105,g_apgb3_d[g_detail_idx].xrcd113, 
                       g_apgb3_d[g_detail_idx].xrcd114,g_apgb3_d[g_detail_idx].xrcd115,g_apgb3_d[g_detail_idx].xrcd123, 
                       g_apgb3_d[g_detail_idx].xrcd124,g_apgb3_d[g_detail_idx].xrcd125,g_apgb3_d[g_detail_idx].xrcd133, 
                       g_apgb3_d[g_detail_idx].xrcd134,g_apgb3_d[g_detail_idx].xrcd135,g_apgb3_d[g_detail_idx].xrcdorga, 
                       g_apgb3_d[g_detail_idx].xrcd009,g_apgb3_d[g_detail_idx].xrcd001,g_apgb3_d[g_detail_idx].xrcd004, 
                       g_apgb3_d[g_detail_idx].xrcd100,g_apgb3_d[g_detail_idx].xrcd101,g_apgb3_d[g_detail_idx].xrcd106, 
                       g_apgb3_d[g_detail_idx].xrcd112,g_apgb3_d[g_detail_idx].xrcd116,g_apgb3_d[g_detail_idx].xrcd117, 
                       g_apgb3_d[g_detail_idx].xrcd118,g_apgb3_d[g_detail_idx].xrcd121,g_apgb3_d[g_detail_idx].xrcd131, 
                       g_apgb3_d[g_detail_idx].xrcdsite)
      #add-point:insert_b段資料新增中 name="insert_b.m_insert3"
      
      #end add-point
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "xrcd_t:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = FALSE 
         CALL cl_err()
      END IF
      
      LET li_idx = g_detail_idx
      IF ps_page <> "'3'" THEN 
         CALL g_apgb3_d.insertElement(li_idx) 
      END IF 
 
      #add-point:insert_b段資料新增後 name="insert_b.after_insert3"
      
      #end add-point
   END IF
 
 
   
 
   
   #add-point:insert_b段other name="insert_b.other"
   
   #end add-point     
   
END FUNCTION
 
{</section>}
 
{<section id="aapt510.update_b" >}
#+ 修改單身後其他table連動
PRIVATE FUNCTION aapt510_update_b(ps_table,ps_keys,ps_keys_bak,ps_page)
   #add-point:update_b段define(客製用) name="update_b.define_customerization"
   
   #end add-point   
   DEFINE ps_table         STRING
   DEFINE ps_page          STRING
   DEFINE ps_keys          DYNAMIC ARRAY OF VARCHAR(500)
   DEFINE ps_keys_bak      DYNAMIC ARRAY OF VARCHAR(500)
   DEFINE ls_group         STRING
   DEFINE li_idx           LIKE type_t.num10 
   DEFINE lb_chk           BOOLEAN
   DEFINE l_new_key        DYNAMIC ARRAY OF STRING
   DEFINE l_old_key        DYNAMIC ARRAY OF STRING
   DEFINE l_field_key      DYNAMIC ARRAY OF STRING
   #add-point:update_b段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="update_b.define"
   
   #end add-point   
   
   #add-point:Function前置處理  name="update_b.pre_function"
   
   #end add-point
   
   LET g_update = TRUE   
   
   #判斷key是否有改變
   LET lb_chk = TRUE
   FOR li_idx = 1 TO ps_keys.getLength()
      IF ps_keys[li_idx] <> ps_keys_bak[li_idx] THEN
         LET lb_chk = FALSE
         EXIT FOR
      END IF
   END FOR
   
   #不需要做處理
   IF lb_chk THEN
      RETURN
   END IF
   
   #判斷是否是同一群組的table
   LET ls_group = "'1',"
   IF ls_group.getIndexOf(ps_page,1) > 0 AND ps_table <> "apgb_t" THEN
      #add-point:update_b段修改前 name="update_b.before_update"
      LET g_apgb_d[g_detail_idx].apgb011 = 0 
      #end add-point 
      
      #將遮罩欄位還原
      CALL aapt510_apgb_t_mask_restore('restore_mask_o')
               
      UPDATE apgb_t 
         SET (apgbcomp,apgbdocno,
              apgbseq
              ,apgborga,apgb001,apgb002,apgb003,apgb004,apgb005,apgb008,apgb006,apgb007,apgb100,apgb101,apgb009,apgb105,apgb115,apgb010,apgb011) 
              = 
             (ps_keys[1],ps_keys[2],ps_keys[3]
              ,g_apgb_d[g_detail_idx].apgborga,g_apgb_d[g_detail_idx].apgb001,g_apgb_d[g_detail_idx].apgb002, 
                  g_apgb_d[g_detail_idx].apgb003,g_apgb_d[g_detail_idx].apgb004,g_apgb_d[g_detail_idx].apgb005, 
                  g_apgb_d[g_detail_idx].apgb008,g_apgb_d[g_detail_idx].apgb006,g_apgb_d[g_detail_idx].apgb007, 
                  g_apgb_d[g_detail_idx].apgb100,g_apgb_d[g_detail_idx].apgb101,g_apgb_d[g_detail_idx].apgb009, 
                  g_apgb_d[g_detail_idx].apgb105,g_apgb_d[g_detail_idx].apgb115,g_apgb_d[g_detail_idx].apgb010, 
                  g_apgb_d[g_detail_idx].apgb011) 
         WHERE apgbent = g_enterprise AND apgbcomp = ps_keys_bak[1] AND apgbdocno = ps_keys_bak[2] AND apgbseq = ps_keys_bak[3]
      #add-point:update_b段修改中 name="update_b.m_update"
      
      #end add-point   
      CASE
         WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "apgb_t" 
            LET g_errparam.code = "std-00009" 
            LET g_errparam.popup = TRUE 
            CALL s_transaction_end('N','0')
            CALL cl_err()
            
         WHEN SQLCA.SQLCODE #其他錯誤
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "apgb_t:",SQLERRMESSAGE 
            LET g_errparam.code = SQLCA.SQLCODE 
            LET g_errparam.popup = TRUE 
            CALL s_transaction_end('N','0')
            CALL cl_err()
            
         OTHERWISE
 
      END CASE
      
      #將遮罩欄位進行遮蔽
      CALL aapt510_apgb_t_mask_restore('restore_mask_n')
               
      #add-point:update_b段修改後 name="update_b.after_update"
      
      #end add-point  
   END IF
   
   #子表處理
   IF ls_group.getIndexOf(ps_page,1) > 0 THEN
      
   END IF
   
   
   LET ls_group = "'2',"
   #判斷是否是同一群組的table
   IF ls_group.getIndexOf(ps_page,1) > 0 AND ps_table <> "apgc_t" THEN
      #add-point:update_b段修改前 name="update_b.before_update2"
      
      #end add-point  
      
      #將遮罩欄位還原
      CALL aapt510_apgc_t_mask_restore('restore_mask_o')
               
      UPDATE apgc_t 
         SET (apgccomp,apgcdocno,
              apgcseq,apgc900
              ,apgcorga,apgc001,apgc002,apgc003,apgc005,apgc014,apgc100,apgc101,apgc006,apgc007,apgc008,apgc009,apgc010,apgc011,apgc103,apgc104,apgc105,apgc113,apgc114,apgc115,apgc004,apgc015,apgc016,apgc012,apgc013) 
              = 
             (ps_keys[1],ps_keys[2],ps_keys[3],ps_keys[4]
              ,g_apgb2_d[g_detail_idx].apgcorga,g_apgb2_d[g_detail_idx].apgc001,g_apgb2_d[g_detail_idx].apgc002, 
                  g_apgb2_d[g_detail_idx].apgc003,g_apgb2_d[g_detail_idx].apgc005,g_apgb2_d[g_detail_idx].apgc014, 
                  g_apgb2_d[g_detail_idx].apgc100,g_apgb2_d[g_detail_idx].apgc101,g_apgb2_d[g_detail_idx].apgc006, 
                  g_apgb2_d[g_detail_idx].apgc007,g_apgb2_d[g_detail_idx].apgc008,g_apgb2_d[g_detail_idx].apgc009, 
                  g_apgb2_d[g_detail_idx].apgc010,g_apgb2_d[g_detail_idx].apgc011,g_apgb2_d[g_detail_idx].apgc103, 
                  g_apgb2_d[g_detail_idx].apgc104,g_apgb2_d[g_detail_idx].apgc105,g_apgb2_d[g_detail_idx].apgc113, 
                  g_apgb2_d[g_detail_idx].apgc114,g_apgb2_d[g_detail_idx].apgc115,g_apgb2_d[g_detail_idx].apgc004, 
                  g_apgb2_d[g_detail_idx].apgc015,g_apgb2_d[g_detail_idx].apgc016,g_apgb2_d[g_detail_idx].apgc012, 
                  g_apgb2_d[g_detail_idx].apgc013) 
         WHERE apgcent = g_enterprise AND apgccomp = ps_keys_bak[1] AND apgcdocno = ps_keys_bak[2] AND apgcseq = ps_keys_bak[3] AND apgc900 = ps_keys_bak[4]
      #add-point:update_b段修改中 name="update_b.m_update2"
      
      #end add-point  
      CASE
         WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "apgc_t" 
            LET g_errparam.code = "std-00009" 
            LET g_errparam.popup = TRUE 
            CALL s_transaction_end('N','0')
            CALL cl_err()
            
         WHEN SQLCA.SQLCODE #其他錯誤
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "apgc_t:",SQLERRMESSAGE 
            LET g_errparam.code = SQLCA.SQLCODE 
            LET g_errparam.popup = TRUE 
            CALL s_transaction_end('N','0')
            CALL cl_err()
            
         OTHERWISE
          
      END CASE
      
      #將遮罩欄位進行遮蔽
      CALL aapt510_apgc_t_mask_restore('restore_mask_n')
 
      #add-point:update_b段修改後 name="update_b.after_update2"
      
      #end add-point  
   END IF
 
   #子表處理
   IF ls_group.getIndexOf(ps_page,1) > 0 THEN
      
   END IF
 
   LET ls_group = "'3',"
   #判斷是否是同一群組的table
   IF ls_group.getIndexOf(ps_page,1) > 0 AND ps_table <> "xrcd_t" THEN
      #add-point:update_b段修改前 name="update_b.before_update3"
      
      #end add-point  
      
      #將遮罩欄位還原
      CALL aapt510_xrcd_t_mask_restore('restore_mask_o')
               
      UPDATE xrcd_t 
         SET (xrcdcomp,xrcddocno,
              xrcdld,xrcdseq,xrcdseq2,xrcd007
              ,xrcd002,xrcd003,xrcd006,xrcd005,xrcd102,xrcd103,xrcd104,xrcd105,xrcd113,xrcd114,xrcd115,xrcd123,xrcd124,xrcd125,xrcd133,xrcd134,xrcd135,xrcdorga,xrcd009,xrcd001,xrcd004,xrcd100,xrcd101,xrcd106,xrcd112,xrcd116,xrcd117,xrcd118,xrcd121,xrcd131,xrcdsite) 
              = 
             (ps_keys[1],ps_keys[2],ps_keys[3],ps_keys[4],ps_keys[5],ps_keys[6]
              ,g_apgb3_d[g_detail_idx].xrcd002,g_apgb3_d[g_detail_idx].xrcd003,g_apgb3_d[g_detail_idx].xrcd006, 
                  g_apgb3_d[g_detail_idx].xrcd005,g_apgb3_d[g_detail_idx].xrcd102,g_apgb3_d[g_detail_idx].xrcd103, 
                  g_apgb3_d[g_detail_idx].xrcd104,g_apgb3_d[g_detail_idx].xrcd105,g_apgb3_d[g_detail_idx].xrcd113, 
                  g_apgb3_d[g_detail_idx].xrcd114,g_apgb3_d[g_detail_idx].xrcd115,g_apgb3_d[g_detail_idx].xrcd123, 
                  g_apgb3_d[g_detail_idx].xrcd124,g_apgb3_d[g_detail_idx].xrcd125,g_apgb3_d[g_detail_idx].xrcd133, 
                  g_apgb3_d[g_detail_idx].xrcd134,g_apgb3_d[g_detail_idx].xrcd135,g_apgb3_d[g_detail_idx].xrcdorga, 
                  g_apgb3_d[g_detail_idx].xrcd009,g_apgb3_d[g_detail_idx].xrcd001,g_apgb3_d[g_detail_idx].xrcd004, 
                  g_apgb3_d[g_detail_idx].xrcd100,g_apgb3_d[g_detail_idx].xrcd101,g_apgb3_d[g_detail_idx].xrcd106, 
                  g_apgb3_d[g_detail_idx].xrcd112,g_apgb3_d[g_detail_idx].xrcd116,g_apgb3_d[g_detail_idx].xrcd117, 
                  g_apgb3_d[g_detail_idx].xrcd118,g_apgb3_d[g_detail_idx].xrcd121,g_apgb3_d[g_detail_idx].xrcd131, 
                  g_apgb3_d[g_detail_idx].xrcdsite) 
         WHERE xrcdent = g_enterprise AND xrcdcomp = ps_keys_bak[1] AND xrcddocno = ps_keys_bak[2] AND xrcdld = ps_keys_bak[3] AND xrcdseq = ps_keys_bak[4] AND xrcdseq2 = ps_keys_bak[5] AND xrcd007 = ps_keys_bak[6]
      #add-point:update_b段修改中 name="update_b.m_update3"
      
      #end add-point  
      CASE
         WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "xrcd_t" 
            LET g_errparam.code = "std-00009" 
            LET g_errparam.popup = TRUE 
            CALL s_transaction_end('N','0')
            CALL cl_err()
            
         WHEN SQLCA.SQLCODE #其他錯誤
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "xrcd_t:",SQLERRMESSAGE 
            LET g_errparam.code = SQLCA.SQLCODE 
            LET g_errparam.popup = TRUE 
            CALL s_transaction_end('N','0')
            CALL cl_err()
            
         OTHERWISE
          
      END CASE
      
      #將遮罩欄位進行遮蔽
      CALL aapt510_xrcd_t_mask_restore('restore_mask_n')
 
      #add-point:update_b段修改後 name="update_b.after_update3"
      
      #end add-point  
   END IF
 
   #子表處理
   IF ls_group.getIndexOf(ps_page,1) > 0 THEN
      
   END IF
 
 
   
 
   
   #add-point:update_b段other name="update_b.other"
   
   #end add-point  
   
END FUNCTION
 
{</section>}
 
{<section id="aapt510.key_update_b" >}
#+ 上層單身key欄位變動後, 連帶修正下層單身key欄位
PRIVATE FUNCTION aapt510_key_update_b(ps_keys_bak,ps_table)
   #add-point:update_b段define(客製用) name="key_update_b.define_customerization"
   
   #end add-point
   DEFINE ps_keys_bak       DYNAMIC ARRAY OF VARCHAR(500)
   DEFINE ps_table          STRING
   DEFINE l_field_key       DYNAMIC ARRAY OF STRING
   DEFINE l_var_keys_bak    DYNAMIC ARRAY OF STRING
   DEFINE l_new_key         DYNAMIC ARRAY OF STRING
   DEFINE l_old_key         DYNAMIC ARRAY OF STRING
   #add-point:update_b段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="key_update_b.define"
   
   #end add-point
   
   #add-point:Function前置處理  name="key_update_b.pre_function"
   
   #end add-point
   
 
   
END FUNCTION
 
{</section>}
 
{<section id="aapt510.key_delete_b" >}
#+ 上層單身刪除後, 連帶刪除下層單身key欄位
PRIVATE FUNCTION aapt510_key_delete_b(ps_keys_bak,ps_table)
   #add-point:delete_b段define(客製用) name="key_delete_b.define_customerization"
   
   #end add-point
   DEFINE ps_keys_bak       DYNAMIC ARRAY OF VARCHAR(500)
   DEFINE ps_table          STRING
   DEFINE l_field_keys      DYNAMIC ARRAY OF STRING
   DEFINE l_var_keys_bak    DYNAMIC ARRAY OF STRING
   DEFINE l_new_key         DYNAMIC ARRAY OF STRING
   DEFINE l_old_key         DYNAMIC ARRAY OF STRING
   #add-point:delete_b段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="key_delete_b.define"
   
   #end add-point
   
   #add-point:Function前置處理  name="key_delete_b.pre_function"
   
   #end add-point
   
 
   
   RETURN TRUE
   
END FUNCTION
 
{</section>}
 
{<section id="aapt510.lock_b" >}
#+ 連動lock其他單身table資料
PRIVATE FUNCTION aapt510_lock_b(ps_table,ps_page)
   #add-point:lock_b段define(客製用) name="lock_b.define_customerization"
   
   #end add-point   
   DEFINE ps_page     STRING
   DEFINE ps_table    STRING
   DEFINE ls_group    STRING
   #add-point:lock_b段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="lock_b.define"
   
   #end add-point   
   
   #add-point:Function前置處理  name="lock_b.pre_function"
   
   #end add-point
    
   #先刷新資料
   #CALL aapt510_b_fill()
   
   #鎖定整組table
   #LET ls_group = "'1',"
   #僅鎖定自身table
   LET ls_group = "apgb_t"
   
   IF ls_group.getIndexOf(ps_table,1) THEN
      OPEN aapt510_bcl USING g_enterprise,
                                       g_apga_m.apgacomp,g_apga_m.apgadocno,g_apgb_d[g_detail_idx].apgbseq  
                                               
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "aapt510_bcl:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = TRUE 
         CALL cl_err()
         RETURN FALSE
      END IF
   END IF
                                    
   #鎖定整組table
   #LET ls_group = "'2',"
   #僅鎖定自身table
   LET ls_group = "apgc_t"
   IF ls_group.getIndexOf(ps_table,1) THEN
   
      OPEN aapt510_bcl2 USING g_enterprise,
                                             g_apga_m.apgacomp,g_apga_m.apgadocno,g_apgb2_d[g_detail_idx].apgcseq, 
                                                 g_apgb2_d[g_detail_idx].apgc900
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "aapt510_bcl2:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = TRUE 
         CALL cl_err()
         RETURN FALSE
      END IF
   END IF
 
   #鎖定整組table
   #LET ls_group = "'3',"
   #僅鎖定自身table
   LET ls_group = "xrcd_t"
   IF ls_group.getIndexOf(ps_table,1) THEN
   
      OPEN aapt510_bcl3 USING g_enterprise,
                                             g_apga_m.apgacomp,g_apga_m.apgadocno,g_apgb3_d[g_detail_idx].xrcdld, 
                                                 g_apgb3_d[g_detail_idx].xrcdseq,g_apgb3_d[g_detail_idx].xrcdseq2, 
                                                 g_apgb3_d[g_detail_idx].xrcd007
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "aapt510_bcl3:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = TRUE 
         CALL cl_err()
         RETURN FALSE
      END IF
   END IF
 
 
   
 
   
   #add-point:lock_b段other name="lock_b.other"
   
   #end add-point  
   
   RETURN TRUE
 
END FUNCTION
 
{</section>}
 
{<section id="aapt510.unlock_b" >}
#+ 連動unlock其他單身table資料
PRIVATE FUNCTION aapt510_unlock_b(ps_table,ps_page)
   #add-point:unlock_b段define(客製用) name="unlock_b.define_customerization"
   
   #end add-point  
   DEFINE ps_page     STRING
   DEFINE ps_table    STRING
   DEFINE ls_group    STRING
   #add-point:unlock_b段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="unlock_b.define"
   
   #end add-point  
   
   #add-point:Function前置處理  name="unlock_b.pre_function"
   
   #end add-point
    
   LET ls_group = "'1',"
   
   IF ls_group.getIndexOf(ps_page,1) THEN
      CLOSE aapt510_bcl
   END IF
   
   LET ls_group = "'2',"
   
   IF ls_group.getIndexOf(ps_page,1) THEN
      CLOSE aapt510_bcl2
   END IF
 
   LET ls_group = "'3',"
   
   IF ls_group.getIndexOf(ps_page,1) THEN
      CLOSE aapt510_bcl3
   END IF
 
 
   
 
 
   #add-point:unlock_b段other name="unlock_b.other"
   
   #end add-point  
 
END FUNCTION
 
{</section>}
 
{<section id="aapt510.set_entry" >}
#+ 單頭欄位開啟設定
PRIVATE FUNCTION aapt510_set_entry(p_cmd)
   #add-point:set_entry段define(客製用) name="set_entry.define_customerization"
   
   #end add-point       
   DEFINE p_cmd   LIKE type_t.chr1  
   #add-point:set_entry段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_entry.define"
   
   #end add-point       
   
   #add-point:Function前置處理  name="set_entry.pre_function"
   
   #end add-point
   
   CALL cl_set_comp_entry("apgadocno",TRUE)
   
   IF p_cmd = 'a' THEN
      CALL cl_set_comp_entry("apgacomp,apgadocno",TRUE)
      CALL cl_set_comp_entry("apgadocdt",TRUE)
      #根據azzi850使用者身分開關特定欄位
      IF NOT cl_null(g_no_entry) THEN
         CALL cl_set_comp_entry(g_no_entry,TRUE)
      END IF
      #add-point:set_entry段欄位控制 name="set_entry.field_control"
      
      #end add-point  
   END IF
   
   #add-point:set_entry段欄位控制後 name="set_entry.after_control"
   CALL cl_set_comp_entry('apga003,apga008,apga010,apga012,apga009,apga015,apga104,apga016,apga017,apga018',TRUE)
   CALL cl_set_comp_required('apga034,apga035,apga036,apga037,apga038,apga039,apga040',TRUE) #160428-00001#1 
   #160824-00049#1-----s
   
   #160824-00049#1-----e
   #end add-point 
 
END FUNCTION
 
{</section>}
 
{<section id="aapt510.set_no_entry" >}
#+ 單頭欄位關閉設定
PRIVATE FUNCTION aapt510_set_no_entry(p_cmd)
   #add-point:set_no_entry段define(客製用) name="set_no_entry.define_customerization"
   
   #end add-point     
   DEFINE p_cmd   LIKE type_t.chr1   
   #add-point:set_no_entry段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_no_entry.define"
   
   #end add-point     
   
   #add-point:Function前置處理  name="set_no_entry.pre_function"
   
   #end add-point
   
   IF p_cmd = 'u' AND g_chkey = 'N' THEN
      CALL cl_set_comp_entry("apgacomp,apgadocno",FALSE)
      #根據azzi850使用者身分開關特定欄位
      IF NOT cl_null(g_no_entry) THEN
         CALL cl_set_comp_entry(g_no_entry,FALSE)
      END IF
      #add-point:set_no_entry段欄位控制 name="set_no_entry.field_control"
      
      #end add-point 
   END IF 
   
   IF p_cmd = 'u' THEN  #docno,ld欄位確認是絕對關閉
      CALL cl_set_comp_entry("apgadocno",FALSE)
   END IF 
 
#  IF p_cmd = 'u' THEN  #docdt欄位依照設定關閉(FALSE則為設定不同意修正) #(ver:78)
      IF NOT cl_chk_update_docdt() THEN
         CALL cl_set_comp_entry("apgadocdt",FALSE)
      END IF
#  END IF 
   
   #add-point:set_no_entry段欄位控制後 name="set_no_entry.after_control"
   IF NOT cl_null(g_apga_m.apga006)THEN
      IF g_apga_m.apga006 = '1' THEN
      ELSE
         CALL cl_set_comp_entry('apga003,apga008,apga010,apga012,apga009,apga015,apga104,apga016,apga017,apga018',FALSE)
      END IF
   END IF
   #160428-00001#1---s---
   IF g_apga_m.apga104 = 0 THEN CALL cl_set_comp_required('apga036,apga037',FALSE) END IF
   IF g_apga_m.apga108 = 0 THEN CALL cl_set_comp_required('apga034,apga035',FALSE) END IF
   IF g_apga_m.apga102 = 0 THEN CALL cl_set_comp_required('apga038,apga039',FALSE) END IF
   IF g_apga_m.apga104 = 0 AND g_apga_m.apga108 = 0 AND g_apga_m.apga102 = 0 THEN
      CALL cl_set_comp_required('apga040',FALSE)
   END IF
   #160428-00001#1---e---
   #160824-00049#1-----s
   
   #160824-00049#1-----e
   #end add-point 
 
END FUNCTION
 
{</section>}
 
{<section id="aapt510.set_entry_b" >}
#+ 單身欄位開啟設定
PRIVATE FUNCTION aapt510_set_entry_b(p_cmd)
   #add-point:set_entry_b段define(客製用) name="set_entry_b.define_customerization"
   
   #end add-point     
   DEFINE p_cmd   LIKE type_t.chr1   
   #add-point:set_entry_b段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_entry_b.define"
   
   #end add-point     
   
   #add-point:Function前置處理  name="set_entry_b.pre_function"
   
   #end add-point
    
   IF p_cmd = 'a' THEN
      CALL cl_set_comp_entry("",TRUE)
      #add-point:set_entry段欄位控制 name="set_entry_b.field_control"
      
      #end add-point  
   END IF
   
   #add-point:set_entry_b段 name="set_entry_b.set_entry_b"
   CALL cl_set_comp_entry("apgb003,apgb005,apgb006,apgb008,apgb009,apgb105,apgb115",TRUE)
   CALL cl_set_comp_entry("apgb101",TRUE)   #albireo 160614 add
   CALL cl_set_comp_entry("apgc101",TRUE)   #160824-00049#1  
   #end add-point  
END FUNCTION
 
{</section>}
 
{<section id="aapt510.set_no_entry_b" >}
#+ 單身欄位關閉設定
PRIVATE FUNCTION aapt510_set_no_entry_b(p_cmd)
   #add-point:set_no_entry_b段define(客製用) name="set_no_entry_b.define_customerization"
   
   #end add-point    
   DEFINE p_cmd   LIKE type_t.chr1   
   #add-point:set_no_entry_b段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_no_entry_b.define"
   
   #end add-point    
   
   #add-point:Function前置處理  name="set_no_entry_b.pre_function"
   
   #end add-point
   
   IF p_cmd = 'u' AND g_chkey = 'N' THEN
      CALL cl_set_comp_entry("",FALSE)
      #add-point:set_no_entry_b段欄位控制 name="set_no_entry_b.field_control"
      
      #end add-point 
   END IF 
   
   #add-point:set_no_entry_b段 name="set_no_entry_b.set_no_entry_b"
   IF NOT cl_null(g_apgb_d[l_ac].apgb001) OR NOT cl_null(g_apgb_d[l_ac].apgb002)THEN
      CALL cl_set_comp_entry("apgb003,apgb005,apgb006,apgb008,apgb009,apgb105,apgb115",FALSE)
   END IF
   
   #albireo 160614-----s
   IF g_apgb_d[l_ac].apgb100 = g_apga_m.apga100 THEN
      CALL cl_set_comp_entry("apgb101",FALSE) 
   END IF
   
   IF g_apgb_d[l_ac].apgb100 = g_apga_m.glaa001 THEN
      CALL cl_set_comp_entry("apgb101",FALSE) 
   END IF  
   #albireo 160614-----e
   
   #160824-00049#1-----s
   IF g_apgb2_d[l_ac].apgc100 = g_apga_m.apga100 THEN
      CALL cl_set_comp_entry("apgc101",FALSE) 
   END IF   
   
   IF g_apgb2_d[l_ac].apgc100 = g_apga_m.glaa001 THEN
      CALL cl_set_comp_entry("apgc101",FALSE) 
   END IF   
   #160824-00049#1-----e
   #end add-point     
END FUNCTION
 
{</section>}
 
{<section id="aapt510.set_act_visible" >}
#+ 單頭權限開啟
PRIVATE FUNCTION aapt510_set_act_visible()
   #add-point:set_act_visible段define(客製用) name="set_act_visible.define_customerization"
   
   #end add-point   
   #add-point:set_act_visible段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_visible.define"
   
   #end add-point   
   #add-point:set_act_visible段 name="set_act_visible.set_act_visible"
   CALL cl_set_act_visible("modify,delete,modify_detail", TRUE)
   #end add-point   
END FUNCTION
 
{</section>}
 
{<section id="aapt510.set_act_no_visible" >}
#+ 單頭權限關閉
PRIVATE FUNCTION aapt510_set_act_no_visible()
   #add-point:set_act_no_visible段define(客製用) name="set_act_no_visible.define_customerization"
   
   #end add-point   
   #add-point:set_act_no_visible段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_no_visible.define"
   
   #end add-point   
   #add-point:set_act_no_visible段 name="set_act_no_visible.set_act_no_visible"
   #應用 a63 樣板自動產生(Version:1)
   IF g_apga_m.apgastus NOT MATCHES "[NDR]" THEN   # N未確認/D抽單/R已拒絕允許修改
      CALL cl_set_act_visible("modify,delete,modify_detail", FALSE)
   END IF
   #end add-point   
END FUNCTION
 
{</section>}
 
{<section id="aapt510.set_act_visible_b" >}
#+ 單身權限開啟
PRIVATE FUNCTION aapt510_set_act_visible_b()
   #add-point:set_act_visible_b段define(客製用) name="set_act_visible_b.define_customerization"
   
   #end add-point   
   #add-point:set_act_visible_b段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_visible_b.define"
   
   #end add-point   
   #add-point:set_act_visible_b段 name="set_act_visible_b.set_act_visible_b"
   
   #end add-point   
END FUNCTION
 
{</section>}
 
{<section id="aapt510.set_act_no_visible_b" >}
#+ 單身權限關閉
PRIVATE FUNCTION aapt510_set_act_no_visible_b()
   #add-point:set_act_no_visible_b段define(客製用) name="set_act_no_visible_b.define_customerization"
   
   #end add-point   
   #add-point:set_act_no_visible_b段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_no_visible_b.define"
   
   #end add-point   
   #add-point:set_act_no_visible_b段 name="set_act_no_visible_b.set_act_no_visible_b"
   
   #end add-point   
END FUNCTION
 
{</section>}
 
{<section id="aapt510.default_search" >}
#+ 外部參數搜尋
PRIVATE FUNCTION aapt510_default_search()
   #add-point:default_search段define(客製用) name="default_search.define_customerization"
   
   #end add-point  
   DEFINE li_idx     LIKE type_t.num10
   DEFINE li_cnt     LIKE type_t.num10
   DEFINE ls_wc      STRING
   DEFINE la_wc      DYNAMIC ARRAY OF RECORD
          tableid    STRING,
          wc         STRING
          END RECORD
   DEFINE ls_where   STRING
   #add-point:default_search段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="default_search.define"
   
   #end add-point  
   
   #add-point:Function前置處理 name="default_search.before"
   
   #end add-point  
   
   LET g_pagestart = 1
   
   IF cl_null(g_order) THEN
      LET g_order = "ASC"
   END IF
   
   IF NOT cl_null(g_argv[01]) THEN
      LET ls_wc = ls_wc, " apgacomp = '", g_argv[01], "' AND "
   END IF
   
   IF NOT cl_null(g_argv[02]) THEN
      LET ls_wc = ls_wc, " apgadocno = '", g_argv[02], "' AND "
   END IF
 
   
   #add-point:default_search段after sql name="default_search.after_sql"
   
   #end add-point  
   
   IF NOT cl_null(ls_wc) THEN
      LET g_wc = ls_wc.subString(1,ls_wc.getLength()-5)
      LET g_default = TRUE
   ELSE
      #若無外部參數則預設為1=2
      LET g_default = FALSE
      
      #預設查詢條件
      CALL cl_qbe_get_default_qryplan() RETURNING ls_where
      IF NOT cl_null(ls_where) THEN
         CALL util.JSON.parse(ls_where, la_wc)
         INITIALIZE g_wc, g_wc2,g_wc2_table1,g_wc2_extend TO NULL
         INITIALIZE g_wc2_table2 TO NULL
 
         INITIALIZE g_wc2_table3 TO NULL
 
 
         FOR li_idx = 1 TO la_wc.getLength()
            CASE
               WHEN la_wc[li_idx].tableid = "apga_t" 
                  LET g_wc = la_wc[li_idx].wc
               WHEN la_wc[li_idx].tableid = "apgb_t" 
                  LET g_wc2_table1 = la_wc[li_idx].wc
               WHEN la_wc[li_idx].tableid = "apgc_t" 
                  LET g_wc2_table2 = la_wc[li_idx].wc
 
               WHEN la_wc[li_idx].tableid = "xrcd_t" 
                  LET g_wc2_table3 = la_wc[li_idx].wc
 
 
               WHEN la_wc[li_idx].tableid = "EXTENDWC"
                  LET g_wc2_extend = la_wc[li_idx].wc
            END CASE
         END FOR
         IF NOT cl_null(g_wc) OR NOT cl_null(g_wc2_table1) 
            OR NOT cl_null(g_wc2_table2)
 
            OR NOT cl_null(g_wc2_table3)
 
 
            OR NOT cl_null(g_wc2_extend)
            THEN
            #組合g_wc2
            IF g_wc2_table1 <> " 1=1" AND NOT cl_null(g_wc2_table1) THEN
               LET g_wc2 = g_wc2_table1
            END IF
            IF g_wc2_table2 <> " 1=1" AND NOT cl_null(g_wc2_table2) THEN
               LET g_wc2 = g_wc2 ," AND ", g_wc2_table2
            END IF
 
            IF g_wc2_table3 <> " 1=1" AND NOT cl_null(g_wc2_table3) THEN
               LET g_wc2 = g_wc2 ," AND ", g_wc2_table3
            END IF
 
 
            IF g_wc2_extend <> " 1=1" AND NOT cl_null(g_wc2_extend) THEN
               LET g_wc2 = g_wc2 ," AND ", g_wc2_extend
            END IF
         
            IF g_wc2.subString(1,5) = " AND " THEN
               LET g_wc2 = g_wc2.subString(6,g_wc2.getLength())
            END IF
         END IF
      END IF
    
      IF cl_null(g_wc) AND cl_null(g_wc2) THEN
         LET g_wc = " 1=2"
      END IF
   END IF
   
   #add-point:default_search段結束前 name="default_search.after"
   
   #end add-point  
 
   IF g_wc.getIndexOf(" 1=2", 1) THEN
      LET g_default = TRUE
   END IF
 
 
END FUNCTION
 
{</section>}
 
{<section id="aapt510.state_change" >}
   #應用 a09 樣板自動產生(Version:17)
#+ 確認碼變更 
PRIVATE FUNCTION aapt510_statechange()
   #add-point:statechange段define(客製用) name="statechange.define_customerization"
   
   #end add-point  
   DEFINE lc_state LIKE type_t.chr5
   #add-point:statechange段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="statechange.define"
   DEFINE l_str  STRING #160428-00001#1
   #end add-point  
   
   #add-point:Function前置處理 name="statechange.before"
   
   #end add-point  
   
   ERROR ""     #清空畫面右下側ERROR區塊
 
   IF g_apga_m.apgacomp IS NULL
      OR g_apga_m.apgadocno IS NULL
   THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code   = "std-00003" 
      LET g_errparam.popup  = FALSE 
      CALL cl_err()
      RETURN
   END IF
 
   CALL s_transaction_begin()
   
   OPEN aapt510_cl USING g_enterprise,g_apga_m.apgacomp,g_apga_m.apgadocno
   IF STATUS THEN
      CLOSE aapt510_cl
      CALL s_transaction_end('N','0')
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "OPEN aapt510_cl:" 
      LET g_errparam.code   = STATUS 
      LET g_errparam.popup  = TRUE 
      CALL cl_err()
      RETURN
   END IF
   
   #顯示最新的資料
   EXECUTE aapt510_master_referesh USING g_apga_m.apgacomp,g_apga_m.apgadocno INTO g_apga_m.apgacomp, 
       g_apga_m.apga005,g_apga_m.apga006,g_apga_m.apgadocno,g_apga_m.apga002,g_apga_m.apgadocdt,g_apga_m.apga003, 
       g_apga_m.apga004,g_apga_m.apga001,g_apga_m.apga028,g_apga_m.apga029,g_apga_m.apgastus,g_apga_m.apgaownid, 
       g_apga_m.apgaowndp,g_apga_m.apgacrtid,g_apga_m.apgacrtdp,g_apga_m.apgacrtdt,g_apga_m.apgamodid, 
       g_apga_m.apgamoddt,g_apga_m.apgacnfid,g_apga_m.apgacnfdt,g_apga_m.apgapstid,g_apga_m.apgapstdt, 
       g_apga_m.apga007,g_apga_m.apga030,g_apga_m.apga008,g_apga_m.apga009,g_apga_m.apga013,g_apga_m.apga012, 
       g_apga_m.apga010,g_apga_m.apga014,g_apga_m.apga011,g_apga_m.apga100,g_apga_m.apga015,g_apga_m.apga103, 
       g_apga_m.apga104,g_apga_m.apga108,g_apga_m.apga102,g_apga_m.apga026,g_apga_m.apga040,g_apga_m.apga109, 
       g_apga_m.apga101,g_apga_m.apga113,g_apga_m.apga114,g_apga_m.apga118,g_apga_m.apga112,g_apga_m.apga105, 
       g_apga_m.apga016,g_apga_m.apga017,g_apga_m.apga018,g_apga_m.apga115,g_apga_m.apga106,g_apga_m.apga107, 
       g_apga_m.apga019,g_apga_m.apga020,g_apga_m.apga021,g_apga_m.apga022,g_apga_m.apga023,g_apga_m.apga024, 
       g_apga_m.apga025,g_apga_m.apga036,g_apga_m.apga037,g_apga_m.apga032,g_apga_m.apga034,g_apga_m.apga035, 
       g_apga_m.apga031,g_apga_m.apga038,g_apga_m.apga039,g_apga_m.apga033,g_apga_m.apga027,g_apga_m.apgacomp_desc, 
       g_apga_m.apga005_desc,g_apga_m.apga004_desc,g_apga_m.apgaownid_desc,g_apga_m.apgaowndp_desc,g_apga_m.apgacrtid_desc, 
       g_apga_m.apgacrtdp_desc,g_apga_m.apgamodid_desc,g_apga_m.apgacnfid_desc,g_apga_m.apgapstid_desc, 
       g_apga_m.apga007_desc,g_apga_m.apga030_desc,g_apga_m.apga020_desc,g_apga_m.apga036_desc,g_apga_m.apga037_desc, 
       g_apga_m.apga034_desc,g_apga_m.apga035_desc,g_apga_m.apga038_desc,g_apga_m.apga039_desc
   
 
   #檢查是否允許此動作
   IF NOT aapt510_action_chk() THEN
      CLOSE aapt510_cl
      CALL s_transaction_end('N','0')
      RETURN
   END IF
 
   #將資料顯示到畫面上
   DISPLAY BY NAME g_apga_m.apgacomp,g_apga_m.apgacomp_desc,g_apga_m.apga005,g_apga_m.apga005_desc,g_apga_m.apga006, 
       g_apga_m.apgadocno,g_apga_m.apga002,g_apga_m.apgadocdt,g_apga_m.apga003,g_apga_m.apga004,g_apga_m.apga004_desc, 
       g_apga_m.apga001,g_apga_m.apga028,g_apga_m.apga029,g_apga_m.apgastus,g_apga_m.apgaownid,g_apga_m.apgaownid_desc, 
       g_apga_m.apgaowndp,g_apga_m.apgaowndp_desc,g_apga_m.apgacrtid,g_apga_m.apgacrtid_desc,g_apga_m.apgacrtdp, 
       g_apga_m.apgacrtdp_desc,g_apga_m.apgacrtdt,g_apga_m.apgamodid,g_apga_m.apgamodid_desc,g_apga_m.apgamoddt, 
       g_apga_m.apgacnfid,g_apga_m.apgacnfid_desc,g_apga_m.apgacnfdt,g_apga_m.apgapstid,g_apga_m.apgapstid_desc, 
       g_apga_m.apgapstdt,g_apga_m.apga007,g_apga_m.apga007_desc,g_apga_m.apga030,g_apga_m.apga030_desc, 
       g_apga_m.apga008,g_apga_m.apga009,g_apga_m.apga013,g_apga_m.apga012,g_apga_m.apga010,g_apga_m.apga014, 
       g_apga_m.apga011,g_apga_m.apga100,g_apga_m.apga015,g_apga_m.apga103,g_apga_m.apga104,g_apga_m.apga108, 
       g_apga_m.apga102,g_apga_m.apga026,g_apga_m.apga040,g_apga_m.apga109,g_apga_m.glaa001,g_apga_m.apga101, 
       g_apga_m.apga113,g_apga_m.apga114,g_apga_m.apga118,g_apga_m.apga112,g_apga_m.apga105,g_apga_m.apga016, 
       g_apga_m.apga017,g_apga_m.apga018,g_apga_m.apga115,g_apga_m.apga106,g_apga_m.apga107,g_apga_m.apga019, 
       g_apga_m.apga020,g_apga_m.apga020_desc,g_apga_m.apga021,g_apga_m.apga022,g_apga_m.apga023,g_apga_m.apga024, 
       g_apga_m.apga025,g_apga_m.l_apga1041,g_apga_m.apga036,g_apga_m.apga036_desc,g_apga_m.apga037, 
       g_apga_m.apga037_desc,g_apga_m.apga032,g_apga_m.l_apga1081,g_apga_m.apga034,g_apga_m.apga034_desc, 
       g_apga_m.apga035,g_apga_m.apga035_desc,g_apga_m.apga031,g_apga_m.l_apga1021,g_apga_m.apga038, 
       g_apga_m.apga038_desc,g_apga_m.apga039,g_apga_m.apga039_desc,g_apga_m.apga033,g_apga_m.apga027 
 
 
   CASE g_apga_m.apgastus
      WHEN "N"
         CALL gfrm_curr.setElementImage("statechange", "stus/32/unconfirmed.png")
      WHEN "Y"
         CALL gfrm_curr.setElementImage("statechange", "stus/32/confirmed.png")
      WHEN "A"
         CALL gfrm_curr.setElementImage("statechange", "stus/32/approved.png")
      WHEN "D"
         CALL gfrm_curr.setElementImage("statechange", "stus/32/withdraw.png")
      WHEN "R"
         CALL gfrm_curr.setElementImage("statechange", "stus/32/rejection.png")
      WHEN "W"
         CALL gfrm_curr.setElementImage("statechange", "stus/32/signing.png")
      WHEN "X"
         CALL gfrm_curr.setElementImage("statechange", "stus/32/invalid.png")
      
   END CASE
 
   #add-point:資料刷新後 name="statechange.after_refresh"
   
   #end add-point
 
   MENU "" ATTRIBUTES (STYLE="popup")
      BEFORE MENU
         HIDE OPTION "approved"
         HIDE OPTION "rejection"
         CASE g_apga_m.apgastus
            
            WHEN "N"
               HIDE OPTION "unconfirmed"
            WHEN "Y"
               HIDE OPTION "confirmed"
            WHEN "A"
               HIDE OPTION "approved"
            WHEN "D"
               HIDE OPTION "withdraw"
            WHEN "R"
               HIDE OPTION "rejection"
            WHEN "W"
               HIDE OPTION "signing"
            WHEN "X"
               HIDE OPTION "invalid"
         END CASE
     
      #add-point:menu前 name="statechange.before_menu"
      CALL cl_set_act_visible("signing,withdraw",FALSE)
      CALL cl_set_act_visible("unconfirmed,invalid,confirmed",TRUE)
      CALL cl_set_act_visible("closed",FALSE)
      
      CASE g_apga_m.apgastus
         WHEN "N"
            CALL cl_set_act_visible("unconfirmed,hold",FALSE)
            #需提交至BPM時，則顯示「提交」功能並隱藏「確認」功能
            IF cl_bpm_chk() THEN
                CALL cl_set_act_visible("signing",TRUE)
                CALL cl_set_act_visible("confirmed",FALSE)
            END IF

         WHEN "R"   #保留修改的功能(如作廢)，隱藏其他應用功能(如: 確認、未確認、留置、過帳…)
            CALL cl_set_act_visible("confirmed,unconfirmed",FALSE)

         WHEN "D"   #保留修改的功能(如作廢)，隱藏其他應用功能(如: 確認、未確認、留置、過帳…)
            CALL cl_set_act_visible("confirmed,unconfirmed",FALSE)

         WHEN "X"
            CALL s_transaction_end('N','0')      #150401-00001#13
            RETURN

         WHEN "Y"
            CALL cl_set_act_visible("invalid,confirmed",FALSE)

         WHEN "W"    #只能顯示抽單;其餘應用功能皆隱藏
             CALL cl_set_act_visible("withdraw",TRUE)
             CALL cl_set_act_visible("unconfirmed,invalid,confirmed",FALSE)

         WHEN "A"     #只能顯示確認; 其餘應用功能皆隱藏
             CALL cl_set_act_visible("confirmed ",TRUE)
             CALL cl_set_act_visible("unconfirmed,invalid",FALSE)
      END CASE
      #end add-point
      
      #應用 a36 樣板自動產生(Version:5)
      #提交
      ON ACTION signing
         IF cl_auth_chk_act("signing") THEN
            IF NOT aapt510_send() THEN
               CALL s_transaction_end('N','0')
            ELSE
               CALL s_transaction_end('Y','0')
            END IF
            #因應簽核行為, 該動作完成後不再進行後續處理
            #於此處直接返回
            CLOSE aapt510_cl
            RETURN
         END IF
    
      #抽單
      ON ACTION withdraw
         IF cl_auth_chk_act("withdraw") THEN
            IF NOT aapt510_draw_out() THEN
               CALL s_transaction_end('N','0')
            ELSE
               CALL s_transaction_end('Y','0')
            END IF
            #因應簽核行為, 該動作完成後不再進行後續處理
            #於此處直接返回
            CLOSE aapt510_cl
            RETURN
         END IF
 
 
 
	  
      ON ACTION unconfirmed
         IF cl_auth_chk_act("unconfirmed") THEN
            LET lc_state = "N"
            #add-point:action控制 name="statechange.unconfirmed"
            
            #end add-point
         END IF
         EXIT MENU
      ON ACTION confirmed
         IF cl_auth_chk_act("confirmed") THEN
            LET lc_state = "Y"
            #add-point:action控制 name="statechange.confirmed"
            
            #end add-point
         END IF
         EXIT MENU
      ON ACTION approved
         IF cl_auth_chk_act("approved") THEN
            LET lc_state = "A"
            #add-point:action控制 name="statechange.approved"
            
            #end add-point
         END IF
         EXIT MENU
      #ON ACTION withdraw
      #   IF cl_auth_chk_act("withdraw") THEN
      #      LET lc_state = "D"
      #      #add-point:action控制 name="statechange.withdraw"
      #      
      #      #end add-point
      #   END IF
      #   EXIT MENU
      ON ACTION rejection
         IF cl_auth_chk_act("rejection") THEN
            LET lc_state = "R"
            #add-point:action控制 name="statechange.rejection"
            
            #end add-point
         END IF
         EXIT MENU
      #ON ACTION signing
      #   IF cl_auth_chk_act("signing") THEN
      #      LET lc_state = "W"
      #      #add-point:action控制 name="statechange.signing"
      #      
      #      #end add-point
      #   END IF
      #   EXIT MENU
      ON ACTION invalid
         IF cl_auth_chk_act("invalid") THEN
            LET lc_state = "X"
            #add-point:action控制 name="statechange.invalid"
            
            #end add-point
         END IF
         EXIT MENU
 
      #add-point:stus控制 name="statechange.more_control"
      
      #end add-point
      
   END MENU
   
   #確認被選取的狀態碼在清單中
   IF (lc_state <> "N" 
      AND lc_state <> "Y"
      AND lc_state <> "A"
      AND lc_state <> "D"
      AND lc_state <> "R"
      AND lc_state <> "W"
      AND lc_state <> "X"
      ) OR 
      g_apga_m.apgastus = lc_state OR cl_null(lc_state) THEN
      CLOSE aapt510_cl
      CALL s_transaction_end('N','0')
      RETURN
   END IF
   
   #add-point:stus修改前 name="statechange.b_update"
   #確認
   IF lc_state = 'Y' THEN
      CALL cl_err_collect_init()
      IF NOT s_aapt510_conf_chk(g_apga_m.apgacomp,g_apga_m.apgadocno) THEN
         CALL s_transaction_end('N','0')
         CALL cl_err_collect_show()
         RETURN
      ELSE         
         #IF NOT cl_ask_confirm('aim-00108') THEN   #是否執行確認？  #160428-00001#1 mark
         CALL aapt510_bsum_chk() RETURNING l_str #160428-00001#1    #單身金額與單頭是否相等
         IF NOT cl_ask_confirm(l_str) THEN
            CALL s_transaction_end('N','0')
            CALL cl_err_collect_show()
            RETURN
         ELSE
            CALL s_transaction_begin()
            IF NOT s_aapt510_conf_upd(g_apga_m.apgacomp,g_apga_m.apgadocno) THEN
               CALL s_transaction_end('N','0')
               CALL cl_err_collect_show()
               RETURN
            ELSE
               CALL s_transaction_end('Y','0')
               CALL cl_err_collect_show()
            END IF

         END IF
      END IF
   END IF
   
   #作廢
   IF lc_state = 'X' THEN
      CALL cl_err_collect_init()
      IF NOT s_aapt510_void_chk(g_apga_m.apgacomp,g_apga_m.apgadocno)  THEN
        CALL s_transaction_end('N','0')      
        CALL cl_err_collect_show()
         RETURN
      ELSE
         IF NOT cl_ask_confirm('aim-00109') THEN
            CALL s_transaction_end('N','0')     
            CALL cl_err_collect_show()
            RETURN
         ELSE
            CALL s_transaction_begin()
            IF NOT s_aapt510_void_upd(g_apga_m.apgacomp,g_apga_m.apgadocno) THEN
               CALL s_transaction_end('N','0')
               CALL cl_err_collect_show()
               RETURN
            ELSE
               CALL s_transaction_end('Y','0')
               CALL cl_err_collect_show()
            END IF
         END IF
      END IF
   END IF
   
   #取消確認
   IF lc_state = 'N' THEN
      CALL cl_err_collect_init()
      IF NOT s_aapt510_unconf_chk(g_apga_m.apgacomp,g_apga_m.apgadocno) THEN
         CALL s_transaction_end('N','0')
         CALL cl_err_collect_show()
         RETURN
      ELSE
         IF NOT cl_ask_confirm('aim-00110') THEN   #是否執行取消確認？
            CALL s_transaction_end('N','0')
            CALL cl_err_collect_show()
            RETURN
         ELSE
            CALL s_transaction_begin()
            IF NOT s_aapt510_unconf_upd(g_apga_m.apgacomp,g_apga_m.apgadocno) THEN
               CALL s_transaction_end('N','0')
               CALL cl_err_collect_show()
               RETURN
            ELSE
               CALL s_transaction_end('Y','0')
               CALL cl_err_collect_show()
            END IF
         END IF
      END IF
   END IF
   #end add-point
   
   LET g_apga_m.apgamodid = g_user
   LET g_apga_m.apgamoddt = cl_get_current()
   LET g_apga_m.apgastus = lc_state
   
   #異動狀態碼欄位/修改人/修改日期
   UPDATE apga_t 
      SET (apgastus,apgamodid,apgamoddt) 
        = (g_apga_m.apgastus,g_apga_m.apgamodid,g_apga_m.apgamoddt)     
    WHERE apgaent = g_enterprise AND apgacomp = g_apga_m.apgacomp
      AND apgadocno = g_apga_m.apgadocno
    
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code   = SQLCA.sqlcode 
      LET g_errparam.popup  = FALSE 
      CALL cl_err()
   ELSE
      CASE lc_state
         WHEN "N"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/unconfirmed.png")
         WHEN "Y"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/confirmed.png")
         WHEN "A"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/approved.png")
         WHEN "D"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/withdraw.png")
         WHEN "R"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/rejection.png")
         WHEN "W"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/signing.png")
         WHEN "X"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/invalid.png")
         
      END CASE
    
      #撈取異動後的資料
      EXECUTE aapt510_master_referesh USING g_apga_m.apgacomp,g_apga_m.apgadocno INTO g_apga_m.apgacomp, 
          g_apga_m.apga005,g_apga_m.apga006,g_apga_m.apgadocno,g_apga_m.apga002,g_apga_m.apgadocdt,g_apga_m.apga003, 
          g_apga_m.apga004,g_apga_m.apga001,g_apga_m.apga028,g_apga_m.apga029,g_apga_m.apgastus,g_apga_m.apgaownid, 
          g_apga_m.apgaowndp,g_apga_m.apgacrtid,g_apga_m.apgacrtdp,g_apga_m.apgacrtdt,g_apga_m.apgamodid, 
          g_apga_m.apgamoddt,g_apga_m.apgacnfid,g_apga_m.apgacnfdt,g_apga_m.apgapstid,g_apga_m.apgapstdt, 
          g_apga_m.apga007,g_apga_m.apga030,g_apga_m.apga008,g_apga_m.apga009,g_apga_m.apga013,g_apga_m.apga012, 
          g_apga_m.apga010,g_apga_m.apga014,g_apga_m.apga011,g_apga_m.apga100,g_apga_m.apga015,g_apga_m.apga103, 
          g_apga_m.apga104,g_apga_m.apga108,g_apga_m.apga102,g_apga_m.apga026,g_apga_m.apga040,g_apga_m.apga109, 
          g_apga_m.apga101,g_apga_m.apga113,g_apga_m.apga114,g_apga_m.apga118,g_apga_m.apga112,g_apga_m.apga105, 
          g_apga_m.apga016,g_apga_m.apga017,g_apga_m.apga018,g_apga_m.apga115,g_apga_m.apga106,g_apga_m.apga107, 
          g_apga_m.apga019,g_apga_m.apga020,g_apga_m.apga021,g_apga_m.apga022,g_apga_m.apga023,g_apga_m.apga024, 
          g_apga_m.apga025,g_apga_m.apga036,g_apga_m.apga037,g_apga_m.apga032,g_apga_m.apga034,g_apga_m.apga035, 
          g_apga_m.apga031,g_apga_m.apga038,g_apga_m.apga039,g_apga_m.apga033,g_apga_m.apga027,g_apga_m.apgacomp_desc, 
          g_apga_m.apga005_desc,g_apga_m.apga004_desc,g_apga_m.apgaownid_desc,g_apga_m.apgaowndp_desc, 
          g_apga_m.apgacrtid_desc,g_apga_m.apgacrtdp_desc,g_apga_m.apgamodid_desc,g_apga_m.apgacnfid_desc, 
          g_apga_m.apgapstid_desc,g_apga_m.apga007_desc,g_apga_m.apga030_desc,g_apga_m.apga020_desc, 
          g_apga_m.apga036_desc,g_apga_m.apga037_desc,g_apga_m.apga034_desc,g_apga_m.apga035_desc,g_apga_m.apga038_desc, 
          g_apga_m.apga039_desc
      
      #將資料顯示到畫面上
      DISPLAY BY NAME g_apga_m.apgacomp,g_apga_m.apgacomp_desc,g_apga_m.apga005,g_apga_m.apga005_desc, 
          g_apga_m.apga006,g_apga_m.apgadocno,g_apga_m.apga002,g_apga_m.apgadocdt,g_apga_m.apga003,g_apga_m.apga004, 
          g_apga_m.apga004_desc,g_apga_m.apga001,g_apga_m.apga028,g_apga_m.apga029,g_apga_m.apgastus, 
          g_apga_m.apgaownid,g_apga_m.apgaownid_desc,g_apga_m.apgaowndp,g_apga_m.apgaowndp_desc,g_apga_m.apgacrtid, 
          g_apga_m.apgacrtid_desc,g_apga_m.apgacrtdp,g_apga_m.apgacrtdp_desc,g_apga_m.apgacrtdt,g_apga_m.apgamodid, 
          g_apga_m.apgamodid_desc,g_apga_m.apgamoddt,g_apga_m.apgacnfid,g_apga_m.apgacnfid_desc,g_apga_m.apgacnfdt, 
          g_apga_m.apgapstid,g_apga_m.apgapstid_desc,g_apga_m.apgapstdt,g_apga_m.apga007,g_apga_m.apga007_desc, 
          g_apga_m.apga030,g_apga_m.apga030_desc,g_apga_m.apga008,g_apga_m.apga009,g_apga_m.apga013, 
          g_apga_m.apga012,g_apga_m.apga010,g_apga_m.apga014,g_apga_m.apga011,g_apga_m.apga100,g_apga_m.apga015, 
          g_apga_m.apga103,g_apga_m.apga104,g_apga_m.apga108,g_apga_m.apga102,g_apga_m.apga026,g_apga_m.apga040, 
          g_apga_m.apga109,g_apga_m.glaa001,g_apga_m.apga101,g_apga_m.apga113,g_apga_m.apga114,g_apga_m.apga118, 
          g_apga_m.apga112,g_apga_m.apga105,g_apga_m.apga016,g_apga_m.apga017,g_apga_m.apga018,g_apga_m.apga115, 
          g_apga_m.apga106,g_apga_m.apga107,g_apga_m.apga019,g_apga_m.apga020,g_apga_m.apga020_desc, 
          g_apga_m.apga021,g_apga_m.apga022,g_apga_m.apga023,g_apga_m.apga024,g_apga_m.apga025,g_apga_m.l_apga1041, 
          g_apga_m.apga036,g_apga_m.apga036_desc,g_apga_m.apga037,g_apga_m.apga037_desc,g_apga_m.apga032, 
          g_apga_m.l_apga1081,g_apga_m.apga034,g_apga_m.apga034_desc,g_apga_m.apga035,g_apga_m.apga035_desc, 
          g_apga_m.apga031,g_apga_m.l_apga1021,g_apga_m.apga038,g_apga_m.apga038_desc,g_apga_m.apga039, 
          g_apga_m.apga039_desc,g_apga_m.apga033,g_apga_m.apga027
   END IF
 
   #add-point:stus修改後 name="statechange.a_update"
   
   #end add-point
 
   #add-point:statechange段結束前 name="statechange.after"
   
   #end add-point  
 
   CLOSE aapt510_cl
   CALL s_transaction_end('Y','0')
 
   #功能已完成,通報訊息中心
   CALL aapt510_msgcentre_notify('statechange:'||lc_state)
   
END FUNCTION
 
 
 
 
{</section>}
 
{<section id="aapt510.idx_chk" >}
#+ 顯示正確的單身資料筆數
PRIVATE FUNCTION aapt510_idx_chk()
   #add-point:idx_chk段define(客製用) name="idx_chk.define_customerization"
   
   #end add-point  
   #add-point:idx_chk段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="idx_chk.define"
   
   #end add-point  
   
   #add-point:Function前置處理  name="idx_chk.pre_function"
   
   #end add-point
   
   IF g_current_page = 1 THEN
      LET g_detail_idx = g_curr_diag.getCurrentRow("s_detail1")
      IF g_detail_idx > g_apgb_d.getLength() THEN
         LET g_detail_idx = g_apgb_d.getLength()
      END IF
      IF g_detail_idx = 0 AND g_apgb_d.getLength() <> 0 THEN
         LET g_detail_idx = 1
      END IF
      DISPLAY g_detail_idx TO FORMONLY.idx
      DISPLAY g_apgb_d.getLength() TO FORMONLY.cnt
   END IF
   
   IF g_current_page = 2 THEN
      LET g_detail_idx = g_curr_diag.getCurrentRow("s_detail2")
      IF g_detail_idx > g_apgb2_d.getLength() THEN
         LET g_detail_idx = g_apgb2_d.getLength()
      END IF
      IF g_detail_idx = 0 AND g_apgb2_d.getLength() <> 0 THEN
         LET g_detail_idx = 1
      END IF
      DISPLAY g_detail_idx TO FORMONLY.idx
      DISPLAY g_apgb2_d.getLength() TO FORMONLY.cnt
   END IF
   IF g_current_page = 3 THEN
      LET g_detail_idx = g_curr_diag.getCurrentRow("s_detail3")
      IF g_detail_idx > g_apgb3_d.getLength() THEN
         LET g_detail_idx = g_apgb3_d.getLength()
      END IF
      IF g_detail_idx = 0 AND g_apgb3_d.getLength() <> 0 THEN
         LET g_detail_idx = 1
      END IF
      DISPLAY g_detail_idx TO FORMONLY.idx
      DISPLAY g_apgb3_d.getLength() TO FORMONLY.cnt
   END IF
 
   
   #add-point:idx_chk段other name="idx_chk.other"
   
   #end add-point  
   
END FUNCTION
 
{</section>}
 
{<section id="aapt510.b_fill2" >}
#+ 單身陣列填充2
PRIVATE FUNCTION aapt510_b_fill2(pi_idx)
   #add-point:b_fill2段define(客製用) name="b_fill2.define_customerization"
   
   #end add-point
   DEFINE pi_idx                 LIKE type_t.num10
   DEFINE li_ac                  LIKE type_t.num10
   DEFINE li_detail_idx_tmp      LIKE type_t.num10
   DEFINE ls_chk                 LIKE type_t.chr1
   #add-point:b_fill2段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="b_fill2.define"
   
   #end add-point
   
   #add-point:Function前置處理  name="b_fill2.pre_function"
   
   #end add-point
   
   LET li_ac = l_ac 
   
   IF g_detail_idx <= 0 THEN
      RETURN
   END IF
   
   LET li_detail_idx_tmp = g_detail_idx
   
 
      
 
      
   #add-point:單身填充後 name="b_fill2.after_fill"
   
   #end add-point
    
   LET l_ac = li_ac
   
   CALL aapt510_detail_show()
   
   LET g_detail_idx = li_detail_idx_tmp
   
END FUNCTION
 
{</section>}
 
{<section id="aapt510.fill_chk" >}
#+ 單身填充確認
PRIVATE FUNCTION aapt510_fill_chk(ps_idx)
   #add-point:fill_chk段define(客製用) name="fill_chk.define_customerization"
   
   #end add-point
   DEFINE ps_idx        LIKE type_t.chr10
   #add-point:fill_chk段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="fill_chk.define"
   
   #end add-point
   
   #add-point:Function前置處理 name="fill_chk.before_chk"
   
   #end add-point
   
   #此funtion功能暫時停用(2015/1/12)
   #無論傳入值為何皆回傳true(代表要填充該單身)
 
   #全部為1=1 or null時回傳true
   IF (cl_null(g_wc2_table1) OR g_wc2_table1.trim() = '1=1')  AND 
      (cl_null(g_wc2_table2) OR g_wc2_table2.trim() = '1=1')  AND 
      (cl_null(g_wc2_table3) OR g_wc2_table3.trim() = '1=1') THEN
      #add-point:fill_chk段other_chk name="fill_chk.other_chk"
      
      #end add-point
      RETURN TRUE
   END IF
   
   #add-point:fill_chk段after_chk name="fill_chk.after_chk"
   
   #end add-point
   
   RETURN TRUE
 
END FUNCTION
 
{</section>}
 
{<section id="aapt510.status_show" >}
PRIVATE FUNCTION aapt510_status_show()
   #add-point:status_show段define(客製用) name="status_show.define_customerization"
   
   #end add-point
   #add-point:status_show段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="status_show.define"
   
   #end add-point
   
   #add-point:status_show段status_show name="status_show.status_show"
   
   #end add-point
END FUNCTION
 
{</section>}
 
{<section id="aapt510.mask_functions" >}
&include "erp/aap/aapt510_mask.4gl"
 
{</section>}
 
{<section id="aapt510.signature" >}
   #應用 a39 樣板自動產生(Version:10)
#+ BPM提交
PRIVATE FUNCTION aapt510_send()
   #add-point:send段define(客製用) name="send.define_customerization"
   
   #end add-point 
   #add-point:send段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="send.define"
   
   #end add-point 
   
   #add-point:Function前置處理  name="send.pre_function"
   
   #end add-point
   
   #依據單據個數，需要指定所有單身條件為" 1=1"  (單身有幾個就要設幾個)
   LET g_wc2_table1 = " 1=1"
   LET g_wc2_table2 = " 1=1"
   LET g_wc2_table3 = " 1=1"
 
 
   CALL aapt510_show()
   CALL aapt510_set_pk_array()
   
   #add-point: 初始化的ADP name="send.before_send"
   
   #end add-point
   
   #公用變數初始化
   CALL cl_bpm_data_init()
                  
   #依照主檔/單身個數產生 CALL cl_bpm_set_master_data() / cl_bpm_set_detail_data() 
   #單頭固定為 CALL cl_bpm_set_master_data(util.JSONObject.fromFGL(xxxx)) 傳入參數: (1)單頭陣列  ; 回傳值: 無
   CALL cl_bpm_set_master_data(util.JSONObject.fromFGL(g_apga_m))
                              
   #單身固定為 CALL cl_bpm_set_detail_data(s_detailX, util.JSONArray.fromFGL(xxxx)) 傳入參數: (1)單身SR名稱  (2)單身陣列  ; 回傳值: 無
   CALL cl_bpm_set_detail_data("s_detail1", util.JSONArray.fromFGL(g_apgb_d))
   CALL cl_bpm_set_detail_data("s_detail2", util.JSONArray.fromFGL(g_apgb2_d))
   CALL cl_bpm_set_detail_data("s_detail3", util.JSONArray.fromFGL(g_apgb3_d))
 
 
   # cl_bpm_cli() 裡有包含以前的aws_condition()=>送簽資料檢核和更新單據狀況碼為'W'
   # cl_bpm_cli() 傳入參數:無  ;  回傳值: 0 開單失敗; 1 開單成功
 
   #add-point: 提交前的ADP name="send.before_cli"
   
   #end add-point
 
   #開單失敗
   IF NOT cl_bpm_cli() THEN 
      RETURN FALSE
   END IF
 
   #add-point: 提交後的ADP name="send.after_send"
   
   #end add-point
 
   #此段落不需要刪除資料,但是否需要refresh圖片樣式???
   #CALL aapt510_ui_browser_refresh()
 
   #重新指定此筆單據資料狀態圖片=>送簽中
   LET g_browser[g_current_idx].b_statepic = "stus/16/signing.png"
 
   #重新取得單頭/單身資料,DISPLAY在畫面上
   CALL aapt510_ui_headershow()
   CALL aapt510_ui_detailshow()
 
   RETURN TRUE
   
END FUNCTION
 
 
 
#應用 a40 樣板自動產生(Version:9)
#+ BPM抽單
PRIVATE FUNCTION aapt510_draw_out()
   #add-point:draw段define name="draw.define_customerization"
   
   #end add-point
   #add-point:draw段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="draw.define"
   
   #end add-point
   
   #add-point:Function前置處理  name="draw.pre_function"
   
   #end add-point
   
   #抽單失敗
   IF NOT cl_bpm_draw_out() THEN 
      RETURN FALSE
   END IF    
          
   #重新指定此筆單據資料狀態圖片=>抽單
   LET g_browser[g_current_idx].b_statepic = "stus/16/draw_out.png"
 
   #重新取得單頭/單身資料,DISPLAY在畫面上
   CALL aapt510_ui_headershow()  
   CALL aapt510_ui_detailshow()
 
   #add-point:Function後置處理  name="draw.after_function"
   
   #end add-point
 
   RETURN TRUE
   
END FUNCTION
 
 
 
 
 
{</section>}
 
{<section id="aapt510.set_pk_array" >}
   #應用 a51 樣板自動產生(Version:8)
#+ 給予pk_array內容
PRIVATE FUNCTION aapt510_set_pk_array()
   #add-point:set_pk_array段define name="set_pk_array.define_customerization"
   
   #end add-point
   #add-point:set_pk_array段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_pk_array.define"
   
   #end add-point
   
   #add-point:Function前置處理 name="set_pk_array.before"
   
   #end add-point  
   
   #若l_ac<=0代表沒有資料
   IF l_ac <= 0 THEN
      RETURN
   END IF
   
   CALL g_pk_array.clear()
   LET g_pk_array[1].values = g_apga_m.apgacomp
   LET g_pk_array[1].column = 'apgacomp'
   LET g_pk_array[2].values = g_apga_m.apgadocno
   LET g_pk_array[2].column = 'apgadocno'
   
   #add-point:set_pk_array段之後 name="set_pk_array.after"
   
   #end add-point  
   
END FUNCTION
 
 
 
 
{</section>}
 
{<section id="aapt510.other_dialog" readonly="Y" >}
   
 
{</section>}
 
{<section id="aapt510.msgcentre_notify" >}
#應用 a66 樣板自動產生(Version:6)
PRIVATE FUNCTION aapt510_msgcentre_notify(lc_state)
   #add-point:msgcentre_notify段define name="msgcentre_notify.define_customerization"
   
   #end add-point   
   DEFINE lc_state LIKE type_t.chr80
   #add-point:msgcentre_notify段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="msgcentre_notify.define"
   
   #end add-point
   
   #add-point:Function前置處理  name="msgcentre_notify.pre_function"
   
   #end add-point
   
   INITIALIZE g_msgparam TO NULL
 
   #action-id與狀態填寫
   LET g_msgparam.state = lc_state
 
   #PK資料填寫
   CALL aapt510_set_pk_array()
   #單頭資料填寫
   LET g_msgparam.data[1] = util.JSON.stringify(g_apga_m)
 
   #add-point:msgcentre其他通知 name="msgcentre_notify.process"
   
   #end add-point
 
   #呼叫訊息中心傳遞本關完成訊息
   CALL cl_msgcentre_notify()
 
END FUNCTION
 
 
 
 
{</section>}
 
{<section id="aapt510.action_chk" >}
#+ 修改/刪除前行為檢查(是否可允許此動作), 若有其他行為須管控也可透過此段落
PRIVATE FUNCTION aapt510_action_chk()
   #add-point:action_chk段define(客製用) name="action_chk.define_customerization"
   
   #end add-point
   #add-point:action_chk段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="action_chk.define"
   
   #end add-point
   
   #add-point:action_chk段action_chk name="action_chk.action_chk"
   #160818-00017#1   2016/08/23  By 07900 --add-s-
   SELECT apgastus INTO g_apga_m.apgastus
     FROM apga_t
    WHERE apgaent = g_enterprise
      AND apgadocno= g_apga_m.apgadocno
      AND apgacomp = g_apga_m.apgacomp
         
   IF (g_action_choice="modify" OR g_action_choice="delete" OR g_action_choice="modify_detail") THEN
      LET g_errno = NULL
      CASE g_apga_m.apgastus
         WHEN 'A'
            LET g_errno = 'sub-00180'
         WHEN 'W'
            LET g_errno = 'sub-00180'
         WHEN 'X'
            LET g_errno = 'sub-00229'
         WHEN 'Y'
            LET g_errno = 'sub-00178'
         WHEN 'S'
            LET g_errno = 'sub-00230'
      END CASE
      
      IF NOT cl_null(g_errno) THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = g_errno
         LET g_errparam.extend =  g_apga_m.apgadocno
         LET g_errparam.popup = TRUE
         CALL cl_err()
         LET g_errno = NULL
         CALL aapt510_set_act_visible()
         CALL aapt510_set_act_no_visible()
         CALL aapt510_show()
         RETURN FALSE
      END IF
   END IF   
   #160818-00017#1   2016/08/23  By 07900 --add-e-
   #end add-point
      
   RETURN TRUE
   
END FUNCTION
 
{</section>}
 
{<section id="aapt510.other_function" readonly="Y" >}

################################################################################
# Descriptions...: 法人欄位檢核
# Memo...........: 檢核存在有效;檢核是否為法人組織;user有無權限使用此組織
# Usage..........: CALL aapt510_apgacomp_chk(apgacomp)
#                  RETURNING g_sub_success,g_errno
# Input parameter: p_apgacomp     法人
# Return code....: r_success
#                : r_errno
# Date & Author..: 160217 By albireo
# Modify.........:
################################################################################
PRIVATE FUNCTION aapt510_apgacomp_chk(p_apgacomp)
   DEFINE p_apgacomp   LIKE apga_t.apgacomp
   DEFINE r_success    LIKE type_t.num5
   DEFINE r_errno      LIKE gzze_t.gzze001
   DEFINE l_ooef       RECORD
                       ooef003   LIKE ooef_t.ooef003,
                       ooefstus  LIKE ooef_t.ooefstus
                       END RECORD
   DEFINE l_count      LIKE type_t.num10
   DEFINE l_sql        STRING
   
   LET r_success = TRUE
   LET r_errno   = ''
   
   INITIALIZE l_ooef.* TO NULL
   SELECT ooef003,ooefstus 
     INTO l_ooef.*
     FROM ooef_t
    WHERE ooefent = g_enterprise
      AND ooef001 = p_apgacomp
      
   CASE
      WHEN SQLCA.SQLCODE = 100
         LET r_success = FALSE
         LET r_errno   = 'wss-00231'
      WHEN l_ooef.ooefstus <> 'Y'
         LET r_success = FALSE
         LET r_errno   = 'wss-00231'
      WHEN l_ooef.ooef003  <> 'Y'
         LET r_success = FALSE
         LET r_errno   = 'aap-00011'
   END CASE
   IF NOT r_success THEN RETURN r_success,r_errno END IF
   
   #USER azzi800權限
   #kris提示法人控卡若不存在azzi800設定則不可使用
   #此時不需展組織
   #orga才需展組織
   #albireo 160909 mark-----s
   #LET l_count = NULL      
   #SELECT COUNT(*) INTO l_count
   #  FROM gzxc_t 
   # WHERE gzxcent  = g_enterprise AND gzxc001 = g_user
   #   AND gzxcstus = 'Y'
   #   AND gzxc004  = p_apgacomp
   #IF cl_null(l_count)THEN LET l_count = 0 END IF
   #albireo 160909 mark-----e
   
   #albireo 160909 #160824-00049#1-----s
   LET l_count = NULL
   LET l_sql = "SELECT COUNT(*) FROM ooef_t WHERE ooefent = ",g_enterprise," ",
               "   AND ooef001 = '",p_apgacomp,"' ",
               "   AND ooef001 IN ",g_wc_cs_comp CLIPPED
   PREPARE sel_ooefp11 FROM l_sql
   EXECUTE sel_ooefp11 INTO l_count
   IF cl_null(l_count)THEN LET l_count = 0 END IF
   #albireo 160909 #160824-00049#1-----e
   
   IF l_count = 0 THEN
      LET r_success = FALSE
      LET r_errno   = 'ais-00228'
   END IF
   
   RETURN r_success,r_errno
END FUNCTION

################################################################################
# Descriptions...: 融資合約編號檢核
# Memo...........: (afmi030)存在有效
# Usage..........: CALL aapt510_apga018_chk(g_apga_m.apga018,g_apga_m.apga003,g_apga_m.apgacomp)
#                  RETURNING g_sub_success,g_errno
# Input parameter: p_apga018      合約
#                : p_dat          基準日期
#                : p_comp         法人
# Return code....: r_success
#                : r_errno
# Date & Author..: 160217  By albireo 
# Modify.........:
################################################################################
PRIVATE FUNCTION aapt510_apga018_chk(p_apga018,p_dat,p_comp)
   DEFINE p_apga018   LIKE apga_t.apga018
   DEFINE p_dat       LIKE apga_t.apga003
   DEFINE p_comp      LIKE apga_t.apgacomp
   DEFINE r_success   LIKE type_t.num5
   DEFINE r_errno     LIKE gzze_t.gzze001
   DEFINE l_fmac      RECORD
                      fmac004   LIKE fmac_t.fmac004,
                      fmac005   LIKE fmac_t.fmac005,
                      fmacstus  LIKE fmac_t.fmacstus,
                      ooef017   LIKE ooef_t.ooef017,
                      fmac003   LIKE fmac_t.fmac003
                      END RECORD
   
   LET r_success = TRUE
   LET r_errno   = ''
   
   INITIALIZE l_fmac.* TO NULL
   SELECT fmac004,fmac005,fmacstus,ooef017,fmac003
     INTO l_fmac.*
     FROM fmac_t 
          LEFT OUTER JOIN ooef_t ON ooefent = fmacent AND ooef001 = fmac002
    WHERE fmacent = g_enterprise
      AND fmac001 = p_apga018
   
   CASE
      WHEN SQLCA.SQLCODE = 100
         LET r_errno   = 'afm-00144'
         LET r_success = FALSE
      WHEN l_fmac.fmacstus <> 'Y'
         LET r_errno   = 'afm-00145'
         LET r_success = FALSE
      WHEN l_fmac.fmac004 > p_dat OR l_fmac.fmac005 < p_dat
         #開狀日不在合約有效期間內
         LET r_errno = 'aap-00446'
         LET r_success = FALSE
      WHEN l_fmac.ooef017 <> p_comp
         #合約法人不相同
         LET r_errno = 'afm-00041'
         LET r_success = FALSE
      WHEN l_fmac.fmac003 <> g_apga_m.apga007
         LET r_errno = 'aap-00531'
         LET r_success = FALSE
        
   END CASE
   
   RETURN r_success,r_errno
END FUNCTION

################################################################################
# Descriptions...: 單頭輸入計算公式
# Memo...........:
# Usage..........: CALL aapt510_fomula_h('A')
# Input parameter: p_fomula     公式
# Return code....: 
# Date & Author..: 160217 By albireo
# Modify.........:
################################################################################
PRIVATE FUNCTION aapt510_fomula_h(p_fomula)
   DEFINE p_fomula   LIKE type_t.chr10
   DEFINE l_ld       LIKE glaa_t.glaald
   DEFINE l_glaa001  LIKE glaa_t.glaa001
   
   LET l_ld = NULL
   LET l_glaa001 = NULL
   SELECT glaald,glaa001 INTO l_ld,l_glaa001
     FROM glaa_t
    WHERE glaaent = g_enterprise
      AND glaacomp = g_apga_m.apgacomp
      AND glaa014 = 'Y'
   
   CASE
      WHEN p_fomula = 'A'     
         #104=103*015/100
         IF cl_null(g_apga_m.apga103)THEN LET g_apga_m.apga103 = 0 END IF
         IF cl_null(g_apga_m.apga015)THEN LET g_apga_m.apga015 = 0 END IF         
         LET g_apga_m.apga104 = g_apga_m.apga103 * g_apga_m.apga015 / 100
         #原幣取位
         CALL s_curr_round_ld('1',l_ld,g_apga_m.apga100,g_apga_m.apga104,2) RETURNING g_sub_success,g_errno,g_apga_m.apga104
         
      WHEN p_fomula = 'B'
         #105=103-104
         IF cl_null(g_apga_m.apga103)THEN LET g_apga_m.apga103 = 0 END IF
         IF cl_null(g_apga_m.apga104)THEN LET g_apga_m.apga104 = 0 END IF           
         LET g_apga_m.apga105 = g_apga_m.apga103 - g_apga_m.apga104
      WHEN p_fomula = 'C'
         #113=103*101
         IF cl_null(g_apga_m.apga103)THEN LET g_apga_m.apga103 = 0 END IF
         IF cl_null(g_apga_m.apga101)THEN LET g_apga_m.apga101 = 0 END IF  
         LET g_apga_m.apga113 = g_apga_m.apga103 * g_apga_m.apga101
         #本幣取位
         CALL s_curr_round_ld('1',l_ld,l_glaa001,g_apga_m.apga113,2) RETURNING g_sub_success,g_errno,g_apga_m.apga113
      WHEN p_fomula = 'D'
         #114=104*101
         IF cl_null(g_apga_m.apga104)THEN LET g_apga_m.apga104 = 0 END IF
         IF cl_null(g_apga_m.apga101)THEN LET g_apga_m.apga101 = 0 END IF  
         LET g_apga_m.apga114 = g_apga_m.apga104 * g_apga_m.apga101
         #本幣取位
         CALL s_curr_round_ld('1',l_ld,l_glaa001,g_apga_m.apga114,2) RETURNING g_sub_success,g_errno,g_apga_m.apga114
      WHEN p_fomula = 'E'
         #115=105*101
         IF cl_null(g_apga_m.apga105)THEN LET g_apga_m.apga105 = 0 END IF
         IF cl_null(g_apga_m.apga101)THEN LET g_apga_m.apga101 = 0 END IF  
         LET g_apga_m.apga115 = g_apga_m.apga105 * g_apga_m.apga101
         #本幣取位
         CALL s_curr_round_ld('1',l_ld,l_glaa001,g_apga_m.apga115,2) RETURNING g_sub_success,g_errno,g_apga_m.apga115
      WHEN p_fomula = 'F'#160428-00001#1---s---
        #118=108*101
         IF cl_null(g_apga_m.apga108)THEN LET g_apga_m.apga108 = 0 END IF
         IF cl_null(g_apga_m.apga101)THEN LET g_apga_m.apga101 = 0 END IF  
         LET g_apga_m.apga118 = g_apga_m.apga108 * g_apga_m.apga101
         #本幣取位
         CALL s_curr_round_ld('1',l_ld,l_glaa001,g_apga_m.apga118,2) RETURNING g_sub_success,g_errno,g_apga_m.apga118
      WHEN p_fomula = 'G'
        #112=102*101
         IF cl_null(g_apga_m.apga102)THEN LET g_apga_m.apga102 = 0 END IF
         IF cl_null(g_apga_m.apga101)THEN LET g_apga_m.apga101 = 0 END IF  
         LET g_apga_m.apga112 = g_apga_m.apga102 * g_apga_m.apga101
         #本幣取位
         CALL s_curr_round_ld('1',l_ld,l_glaa001,g_apga_m.apga112,2) RETURNING g_sub_success,g_errno,g_apga_m.apga112
                           #160428-00001#1---e---
   END CASE
   CALL aapt510_to_o_h()
END FUNCTION

################################################################################
# Descriptions...: 數字存入_o處理(單頭)
# Memo...........:
# Usage..........: CALL aapt510_to_o_h()                
# Date & Author..: 160217   By albireo
# Modify.........:
################################################################################
PRIVATE FUNCTION aapt510_to_o_h()
   LET g_apga_m_o.apga101 = g_apga_m.apga101
   LET g_apga_m_o.apga015 = g_apga_m.apga015
   LET g_apga_m_o.apga103 = g_apga_m.apga103
   LET g_apga_m_o.apga104 = g_apga_m.apga104
   LET g_apga_m_o.apga105 = g_apga_m.apga105
   LET g_apga_m_o.apga113 = g_apga_m.apga113
   LET g_apga_m_o.apga114 = g_apga_m.apga114
   LET g_apga_m_o.apga115 = g_apga_m.apga115
   LET g_apga_m_o.apga102 = g_apga_m.apga102 #160428-00001#1
   LET g_apga_m_o.apga108 = g_apga_m.apga108 #160428-00001#1
END FUNCTION

################################################################################
# Descriptions...: 必要輸入控制(非必輸)
# Memo...........:
# Date & Author..: 160217 By albireo
# Modify.........:
################################################################################
PRIVATE FUNCTION aapt510_set_no_required(p_cmd)
   DEFINE p_cmd   LIKE type_t.chr1
   #CALL cl_set_comp_required('apga001',FALSE)     #160824-00049#1
   CALL cl_set_comp_required('apga010,apga012,apga013,apga008',FALSE)
END FUNCTION

################################################################################
# Descriptions...: 必要輸入控制(必輸)
# Memo...........:
# Usage..........: 
# Date & Author..: 160217 By albireo
# Modify.........:
################################################################################
PRIVATE FUNCTION aapt510_set_required(p_cmd)
   DEFINE p_cmd   LIKE type_t.chr1
   
   IF g_apga_m.apga006 = '1' THEN
      CALL cl_set_comp_required('apga010,apga008',TRUE)
      #CALL cl_set_comp_required('apga001',TRUE)     #160824-00049#1
   ELSE
      CALL cl_set_comp_required('apga012',TRUE)
   END IF
   
   IF g_apga_m.apga009 = 'Y' THEN
      CALL cl_set_comp_required('apga013',TRUE)
   END IF
END FUNCTION

PRIVATE FUNCTION aapt510_apga007_desc()
   LET g_apga_m.apga007_desc = ''
   SELECT nmabl003 INTO g_apga_m.apga007_desc
     FROM nmabl_t
    WHERE nmablent = g_enterprise
      AND nmabl001 = g_apga_m.apga007
      AND nmabl002 = g_dlang
   DISPLAY BY NAME g_apga_m.apga007_desc
END FUNCTION

################################################################################
# Descriptions...: 數字存入_o處理(採購單資訊)
# Memo...........:
# Usage..........: CALL aapt510_to_o_h()                
# Date & Author..: 160217   By albireo
# Modify.........:
################################################################################
PRIVATE FUNCTION aapt510_to_o_b1(p_ac)
   DEFINE p_ac   LIKE type_t.num10
   
   LET g_apgb_d_o.* = g_apgb_d[p_ac].*
END FUNCTION

################################################################################
# Descriptions...: 採購單檢核
# Memo...........:
# Date & Author..: 160222  By albireo
# Modify.........:
################################################################################
PRIVATE FUNCTION aapt510_apgb001_002_chk(p_orga,p_apga004,p_docno,p_seq)
   DEFINE p_orga   LIKE ooef_t.ooef001
   DEFINE p_apga004 LIKE apga_t.apga004
   DEFINE p_docno   LIKE apgb_t.apgb001
   DEFINE p_seq     LIKE apgb_t.apgb002
   
   DEFINE r_success LIKE type_t.num5
   DEFINE r_errno   LIKE gzze_t.gzze001
   DEFINE l_site    LIKE ooef_t.ooef001
   DEFINE l_stus    LIKE pmdl_t.pmdlstus 
   DEFINE l_cust    LIKE pmdl_t.pmdl021
   DEFINE l_docdt   LIKE pmdl_t.pmdldocdt
   DEFINE l_count   LIKE type_t.num10   #160719-00020#1
   
   LET r_success = TRUE
   LET r_errno = ''
   
   
   LET l_site = NULL LET l_stus = NULL
   LET l_cust = NULL LET l_docdt = NULL
   IF cl_null(p_seq) THEN
      SELECT pmdlstus,pmdlsite,pmdl021,pmdldocdt
        INTO l_stus,l_site,l_cust,l_docdt
        FROM pmdl_t
       WHERE pmdlent   = g_enterprise
         AND pmdldocno = p_docno
   ELSE
      SELECT DISTINCT pmdlstus,pmdlsite,pmdl021,pmdldocdt
        INTO l_stus,l_site,l_cust,l_docdt
        FROM pmdl_t,pmdo_t
       WHERE pmdlent   = g_enterprise
         AND pmdldocno = p_docno AND pmdoseq = p_seq
         AND pmdlent = pmdoent AND pmdldocno = pmdodocno
   END IF   
   
   CASE
      WHEN SQLCA.SQLCODE = 100
         LET r_errno = 'aap-00051'#無此單據
         LET r_success = FALSE
      WHEN l_stus <> 'Y'          #不為已確認
         LET r_errno = 'aap-00074'
      WHEN NOT cl_null(p_apga004) AND (l_cust <> p_apga004)   #160614-00010#1 add
         #IF l_cust <> p_apga004 THEN   #160614-00010#1 mark
            LET r_errno = 'aap-00067'
            LET r_success = FALSE
         #END IF #160614-00010#1 mark
      #WHEN NOT cl_null(p_orga) OR (p_orga <> l_site)    #160614-00010#1 mark
      WHEN cl_null(p_orga) OR (p_orga <> l_site)         #160614-00010#1 
         LET r_errno   ='aap-00274'
         LET r_success = FALSE
      OTHERWISE 
      #160719-00020#1-----s
         #存在有效申請單中不可輸入
         LET l_count = NULL
         SELECT COUNT(*) INTO l_count FROM apga_t,apgb_t
          WHERE apgaent = apgbent
            AND apgacomp = apgbcomp
            AND apgadocno = apgbdocno
            AND apgastus <> 'X'
            AND apgb001 = p_docno
            AND apgb002 = p_seq
         IF cl_null(l_count)THEN LET l_count = 0 END IF
         
         IF l_count > 0 THEN
            LET r_success = FALSE
            LET r_errno = 'aap-00572'
         END IF
      #160719-00020#1-----e
   END CASE   
   
   
   RETURN r_success, r_errno
END FUNCTION

################################################################################
# Descriptions...: 採購單資訊帶出
# Memo...........:
# Usage..........: aapt510_apgb001_002_carry(p_ac)
# Input parameter: p_ac   單身項次
# Date & Author..: 160222 By albireo
# Modify.........:
################################################################################
PRIVATE FUNCTION aapt510_apgb001_002_carry(p_ac)
   DEFINE p_ac   LIKE type_t.num10
   DEFINE l_source      DYNAMIC ARRAY OF RECORD
         chr         LIKE type_t.chr500,
         dat         LIKE type_t.dat
                 END RECORD
   DEFINE l_ld   LIKE glaa_t.glaald
   DEFINE l_pmdn047   LIKE pmdn_t.pmdn047
   DEFINE l_pmdn007   LIKE pmdn_t.pmdn007
   DEFINE l_glaa001   LIKE glaa_t.glaa001
   DEFINE l_oodb004   LIKE oodb_t.oodb004
   DEFINE l_apca013   LIKE apca_t.apca013
   DEFINE l_apca012   LIKE apca_t.apca012
   DEFINE l_oodb011   LIKE oodb_t.oodb011
   DEFINE l_pmdl015   LIKE pmdl_t.pmdl015
   DEFINE l_pmdl016   LIKE pmdl_t.pmdl016   
   DEFINE r_success  LIKE type_t.num5         #160428-00001#1 
   DEFINE r_errno    LIKE gzze_t.gzze001      #160428-00001#1 

# 貨號           apgb003   不可空白  
# 品名規格       apgb004   不可空白,依貨號帶出預設值       
# 單位           apgb005   不可空白，檢核同採購單 apmt500    
# 稅別           apgb006   若有採購單則帶採購單稅別,不可輸入 else 可稅入含稅稅別 and 下一筆帶上一筆稅別當預設 
# 含稅否         apgb007   串 oodb                                  
# 採購數量       apgb008   >0                                                
# 原幣含稅單價   apgb009   若有採購單 and 含稅單價則帶出採購單之單價, 不可修改,
#                           採購單為未稅單價, 則轉換成含稅單價, 採購單含稅金額/數量= 含稅單價, 若無採購單則可input
# 原幣含稅金額   apgb105   若有採購單則帶出採購單之原幣含稅金額, 不可修改, 若無則採購數量　*　單價                                 
# 本幣含稅金額   apgb115   原幣金額*匯率 

      LET l_ld = NULL   LET l_glaa001 = NULL LET r_success = TRUE
      SELECT glaald ,glaa001
        INTO l_ld ,l_glaa001
        FROM glaa_t
       WHERE glaaent = g_enterprise
         AND glaacomp = g_apga_m.apgacomp
         AND glaa014 = 'Y'

      LET l_pmdn047 = NULL
      LET l_pmdn007 = NULL
      SELECT pmdn047 ,pmdn007
        INTO l_pmdn047 ,l_pmdn007
        FROM pmdn_t
       WHERE pmdnent = g_enterprise
         AND pmdndocno = g_apgb_d[p_ac].apgb001
         AND pmdnseq   = g_apgb_d[p_ac].apgb002
       
      IF cl_null(l_pmdn047)THEN LET l_pmdn047 = 0 END IF
      #160428-00001#1 ---s---
      LET l_pmdl015 = NULL
      LET l_pmdl016 = NULL
      SELECT pmdl015,pmdl016 
        INTO l_pmdl015,l_pmdl016
        FROM pmdl_t 
       WHERE pmdlent = g_enterprise
         AND pmdldocno = g_apgb_d[p_ac].apgb001  
       #檢查幣別是大於兩種
      CALL aapt510_curry_chk(l_pmdl015) RETURNING r_success,r_errno
      IF NOT r_success THEN     
         RETURN r_success,r_errno       
      END IF      
      #160428-00001#1 ---e---      
   
      
      CALL l_source.clear()
      CALL s_aapt300_source_doc_carry_b('10',g_apgb_d[p_ac].apgb001,g_apgb_d[p_ac].apgb002,'','')
           RETURNING g_sub_success,g_errno,l_source
      LET g_apgb_d[p_ac].apgb100  = l_pmdl015         #幣別       #160428-00001#1   
      LET g_apgb_d[p_ac].apgb101  = l_pmdl016         #匯率       #160428-00001#1 
      LET g_apgb_d[p_ac].apgb003  = l_source[4].chr   #產品編號
      LET g_apgb_d[p_ac].apgb004  = l_source[5].chr   #品名規格
      LET g_apgb_d[p_ac].apgb005  = l_source[6].chr   #單位
      LET g_apgb_d[p_ac].apgb006  = l_source[20].chr  #稅別
                                                      #含稅否
      LET g_apgb_d[p_ac].apgb008  = l_pmdn007         #數量
      LET g_apgb_d[p_ac].apgb105  = l_pmdn047         #pmdn047   #原幣含稅金額
      LET g_apgb_d[p_ac].apgb009  = l_pmdn047 / g_apgb_d[p_ac].apgb008   #pmdn047 / 數量 =原幣含稅單價
      
    
      #160428-00001#14 mark 因走裝運通知推至到貨時單價反推金額會造成大誤差 所以不取位-----s    
      ##取位(原幣)
      #CALL s_curr_round_ld('1',l_ld,g_apga_m.apga100,g_apgb_d[p_ac].apgb009,1) RETURNING g_sub_success,g_errno,g_apgb_d[l_ac].apgb009
      #160428-00001#14 mark 因走裝運通知推至到貨時單價反推金額會造成大誤差 所以不取位-----e            
      #本幣含稅金額
      #LET g_apgb_d[p_ac].apgb115 = g_apgb_d[p_ac].apgb105 * g_apga_m.apga101   #160824-00049#1 mark
      LET g_apgb_d[p_ac].apgb115 = g_apgb_d[p_ac].apgb105 * g_apgb_d[p_ac].apgb101 #160824-00049#1  add
      
      #取位(本幣)
      CALL s_curr_round_ld('1',l_ld,l_glaa001,g_apgb_d[p_ac].apgb115,2) RETURNING g_sub_success,g_errno,g_apgb_d[l_ac].apgb115 
      CALL s_tax_chk(g_apga_m.apgacomp,g_apgb_d[p_ac].apgb006) RETURNING g_sub_success,l_oodb004,l_apca013,l_apca012,l_oodb011
      LET g_apgb_d[p_ac].apgb007 = l_apca013
      
      RETURN r_success,r_errno   #160428-00001#1 
END FUNCTION

################################################################################
# Descriptions...: 費用單身匯率重計算
# Memo...........:
# Usage..........: CALL aapt510_curr_recount_b2(l_ac)
# Date & Author..: 160223 By albireo
# Modify.........:
################################################################################
PRIVATE FUNCTION aapt510_curr_recount_b2(p_ac)
   DEFINE p_ac         LIKE type_t.num10
   DEFINE l_sfin4012   LIKE type_t.chr80
   DEFINE l_ld         LIKE glaa_t.glaald
   DEFINE l_dummy2     LIKE type_t.num20_6
   DEFINE l_dummy3     LIKE type_t.num20_6
   DEFINE l_glaa001    LIKE glaa_t.glaa001
   DEFINE l_oodb004    LIKE oodb_t.oodb004
   DEFINE l_oodb005    LIKE oodb_t.oodb005
   DEFINE l_oodb006    LIKE oodb_t.oodb006
   DEFINE l_oodb011    LIKE oodb_t.oodb011
   DEFINE l_apcb105    LIKE apcb_t.apcb105
   DEFINE ls_js         STRING
   DEFINE lc_param      RECORD
            apca004     LIKE apca_t.apca004
                    END RECORD
   
   
   LET l_ld = NULL LET l_glaa001 = NULL
   SELECT glaald ,glaa001
     INTO l_ld ,l_glaa001
     FROM glaa_t
    WHERE glaaent = g_enterprise
      AND glaacomp = g_apga_m.apgacomp
      AND glaa014 = 'Y'
   IF cl_null(p_ac) OR p_ac <=0 THEN RETURN END IF
   
   #有輸入交易帳戶時,取銀存支出匯率來源
   IF NOT cl_null(g_apgb2_d[l_ac].apgc014) THEN
      CALL cl_get_para(g_enterprise,g_apga_m.apgacomp,'S-FIN-4012') RETURNING l_sfin4012
   ELSE
      LET l_sfin4012 = ''
   END IF
   
   #160824-00049#1-----s
   IF g_apgb2_d[l_ac].apgc100 = l_glaa001 THEN
      LET g_apgb2_d[l_ac].apgc101 = 1
   ELSE
      IF g_apgb2_d[l_ac].apgc100 <> g_apga_m.apga100 THEN   
   #160824-00049#1-----e
         IF l_sfin4012  = '23' THEN
            #銀行日平均匯率
            CALL s_anm_get_exrate(l_ld,g_apga_m.apgacomp,g_apgb2_d[l_ac].apgc014,g_apgb2_d[l_ac].apgc100,l_glaa001,g_apga_m.apga003) RETURNING g_apgb2_d[l_ac].apgc101
            #160824-00049#1-----s
            IF cl_null(g_apgb2_d[l_ac].apgc101)THEN
               LET g_apgb2_d[l_ac].apgc101 = 1
               INITIALIZE g_errparam.* TO NULL
               LET g_errparam.extend = ''
               LET g_errparam.code = 'aap-00587'
               LET g_errparam.popup = TRUE
               CALL cl_err()              
            END IF
            #160824-00049#1-----e
         ELSE
            LET lc_param.apca004 = g_apga_m.apga004
            LET ls_js = util.JSON.stringify(lc_param)
            CALL s_fin_get_curr_rate(g_apga_m.apgacomp,l_ld,g_apga_m.apga003,g_apgb2_d[l_ac].apgc100,ls_js)
                 RETURNING g_apgb2_d[l_ac].apgc101,l_dummy2,l_dummy3
         END IF   
   #160824-00049#1-----s
      ELSE
         LET g_apgb2_d[l_ac].apgc101 = g_apga_m.apga101
      END IF
   END IF
   #160824-00049#1-----e
   
   CALL aapt510_tax_ins_b2(p_ac)
END FUNCTION

################################################################################
# Descriptions...: 數字存入_o處理(費用資訊)
# Memo...........:
# Usage..........: CALL aapt510_to_o_b2(p_ac)                
# Date & Author..: 160217   By albireo
# Modify.........:
################################################################################
PRIVATE FUNCTION aapt510_to_o_b2(p_ac)
   DEFINE p_ac   LIKE type_t.num10
   
   LET g_apgb2_d_o.* = g_apgb2_d[p_ac].*
END FUNCTION

PRIVATE FUNCTION aapt510_tax_ins_b2(p_ac)
   DEFINE p_ac         LIKE type_t.num10
   DEFINE l_sfin4012   LIKE type_t.chr80
   DEFINE l_ld         LIKE glaa_t.glaald
   DEFINE l_dummy2     LIKE type_t.num20_6
   DEFINE l_dummy3     LIKE type_t.num20_6
   DEFINE l_glaa001    LIKE glaa_t.glaa001
   DEFINE l_oodb004    LIKE oodb_t.oodb004
   DEFINE l_oodb005    LIKE oodb_t.oodb005
   DEFINE l_oodb006    LIKE oodb_t.oodb006
   DEFINE l_oodb011    LIKE oodb_t.oodb011
   DEFINE l_apcb105    LIKE apcb_t.apcb105
   DEFINE ls_js         STRING
   DEFINE lc_param      RECORD
            apca004     LIKE apca_t.apca004
                    END RECORD  

   LET l_ld = NULL
   SELECT glaald INTO l_ld FROM glaa_t
    WHERE glaaent = g_enterprise
      AND glaacomp = g_apga_m.apgacomp
      AND glaa014 = 'Y'
   
   #匯率修改產生s_tax
   IF NOT cl_null(g_apgb2_d[p_ac].apgc006) AND NOT cl_null(g_apgb2_d[p_ac].apgc100)
      AND NOT cl_null(g_apgb2_d[p_ac].apgc101) AND NOT cl_null(l_ld)
      THEN
      CALL s_tax_chk(g_apgb2_d[p_ac].apgcorga, g_apgb2_d[p_ac].apgc006) RETURNING g_sub_success,l_oodb004,l_oodb005,l_oodb006,l_oodb011
      IF l_oodb005 = 'Y' THEN
         LET l_apcb105 = g_apgb2_d[p_ac].apgc105
      ELSE
         LET l_apcb105 = g_apgb2_d[p_ac].apgc103
      END IF
      CALL s_tax_ins(g_apga_m.apgadocno,g_apgb2_d[p_ac].apgcseq,'0',g_apgb2_d[p_ac].apgcorga,l_apcb105,
                     g_apgb2_d[p_ac].apgc006,1,g_apgb2_d[p_ac].apgc100,g_apgb2_d[p_ac].apgc101,l_ld,1,1)
           RETURNING g_apgb2_d[p_ac].apgc103,g_apgb2_d[p_ac].apgc104,g_apgb2_d[p_ac].apgc105,
                     g_apgb2_d[p_ac].apgc113,g_apgb2_d[p_ac].apgc114,g_apgb2_d[p_ac].apgc115,
                     l_dummy2,l_dummy2,l_dummy2,
                     l_dummy3,l_dummy3,l_dummy3
   END IF
   DISPLAY BY NAME g_apgb2_d[p_ac].apgc006
END FUNCTION

PRIVATE FUNCTION aapt510_to_o_b3(p_ac)
   DEFINE p_ac   LIKE type_t.num10
   
   LET g_apgb3_d_o.* = g_apgb3_d[p_ac].*
END FUNCTION

PRIVATE FUNCTION aapt510_set_visible(p_cmd)
   DEFINE p_cmd   LIKE type_t.chr1
   
   CALL cl_set_comp_visible('xrcd123,xrcd124,xrcd125,xrcd133,xrcd134,xrcd135',TRUE)
   CALL cl_set_comp_visible('apgc008',TRUE)
END FUNCTION

PRIVATE FUNCTION aapt510_set_no_visible(p_cmd)
   DEFINE l_glaa015 LIKE glaa_t.glaa015
   DEFINE l_glaa019 LIKE glaa_t.glaa019
   DEFINE p_cmd     LIKE type_t.chr1
   DEFINE l_isai002 LIKE isai_t.isai002
   LET l_glaa015 = NULL LET l_glaa019 = NULL
   SELECT glaa015,glaa019 
     INTO l_glaa015,l_glaa019
     FROM glaa_t
    WHERE glaaent = g_enterprise
      AND glaacomp = g_apga_m.apgacomp
      AND glaa014 = 'Y'
   
   SELECT isai002 INTO l_isai002
     FROM ooef_t
     LEFT JOIN isai_t ON ooefent = isaient AND ooef019 = isai001
    WHERE ooefent = g_enterprise
      AND ooef001 = g_apga_m.apgacomp
      
   IF l_glaa015 = 'N' THEN
      CALL cl_set_comp_visible('xrcd123,xrcd124,xrcd125',FALSE)
   END IF
   
   IF l_glaa019 = 'N' THEN
      CALL cl_set_comp_visible('xrcd133,xrcd134,xrcd135',FALSE)
   END IF
   
   IF l_isai002 = '1' THEN
      CALL cl_set_comp_visible('apgc008',FALSE)
   END IF
   

   
END FUNCTION

################################################################################
# Descriptions...: 補登證號(整單操作)
# Memo...........:
# Usage..........: CALL aapt510_reinput()
# Date & Author..: 160224 By albireo
# Modify.........:
################################################################################
PRIVATE FUNCTION aapt510_reinput()
   DEFINE l_count   LIKE type_t.num10

   #保存單頭舊值
   LET g_apga_m_t.* = g_apga_m.*
   LET g_apga_m_o.* = g_apga_m.*

   CALL s_transaction_begin()
   
   OPEN aapt510_cl USING g_enterprise,g_apga_m.apgacomp,g_apga_m.apgadocno
   IF STATUS THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "OPEN aapt510_cl:" 
      LET g_errparam.code   = STATUS 
      LET g_errparam.popup  = TRUE 
      CALL cl_err()
      CLOSE aapt510_cl
      CALL s_transaction_end('N','0')
      RETURN
   END IF
 
   #albireo 160623mark-----s
   ##顯示最新的資料
   #EXECUTE aapt510_master_referesh USING g_apga_m.apgacomp,g_apga_m.apgadocno INTO g_apga_m.apgacomp, 
   #    g_apga_m.apga005,g_apga_m.apga006,g_apga_m.apgadocno,g_apga_m.apgadocdt,g_apga_m.apga003,g_apga_m.apga002, 
   #    g_apga_m.apga029,g_apga_m.apga004,g_apga_m.apga001,g_apga_m.apgastus,g_apga_m.apgaownid,g_apga_m.apgaowndp, 
   #    g_apga_m.apgacrtid,g_apga_m.apgacrtdp,g_apga_m.apgacrtdt,g_apga_m.apgamodid,g_apga_m.apgamoddt, 
   #    g_apga_m.apgacnfid,g_apga_m.apgacnfdt,g_apga_m.apgapstid,g_apga_m.apgapstdt,g_apga_m.apga007, 
   #    g_apga_m.apga008,g_apga_m.apga012,g_apga_m.apga009,g_apga_m.apga013,g_apga_m.apga010,g_apga_m.apga011, 
   #    g_apga_m.apga014,g_apga_m.apga100,g_apga_m.apga103,g_apga_m.apga015,g_apga_m.apga104,g_apga_m.apga026, 
   #    g_apga_m.apga101,g_apga_m.apga113,g_apga_m.apga114,g_apga_m.apga027,g_apga_m.apga105,g_apga_m.apga016, 
   #    g_apga_m.apga017,g_apga_m.apga018,g_apga_m.apga028,g_apga_m.apga115,g_apga_m.apga106,g_apga_m.apga107, 
   #    g_apga_m.apga019,g_apga_m.apga020,g_apga_m.apga021,g_apga_m.apga022,g_apga_m.apga023,g_apga_m.apga024, 
   #    g_apga_m.apga025,g_apga_m.apgacomp_desc,g_apga_m.apga005_desc,g_apga_m.apga004_desc,g_apga_m.apgaownid_desc, 
   #    g_apga_m.apgaowndp_desc,g_apga_m.apgacrtid_desc,g_apga_m.apgacrtdp_desc,g_apga_m.apgamodid_desc, 
   #    g_apga_m.apgacnfid_desc,g_apga_m.apgapstid_desc,g_apga_m.apga007_desc,g_apga_m.apga020_desc
   #albireo 160623mark-----e
   #albireo 160623-----s
   EXECUTE aapt510_master_referesh USING g_apga_m.apgacomp,g_apga_m.apgadocno INTO g_apga_m.apgacomp, 
       g_apga_m.apga005,g_apga_m.apga006,g_apga_m.apgadocno,g_apga_m.apga002,g_apga_m.apgadocdt,g_apga_m.apga003, 
       g_apga_m.apga004,g_apga_m.apga001,g_apga_m.apga028,g_apga_m.apga029,g_apga_m.apgastus,g_apga_m.apgaownid, 
       g_apga_m.apgaowndp,g_apga_m.apgacrtid,g_apga_m.apgacrtdp,g_apga_m.apgacrtdt,g_apga_m.apgamodid, 
       g_apga_m.apgamoddt,g_apga_m.apgacnfid,g_apga_m.apgacnfdt,g_apga_m.apgapstid,g_apga_m.apgapstdt, 
       g_apga_m.apga007,g_apga_m.apga030,g_apga_m.apga008,g_apga_m.apga009,g_apga_m.apga013,g_apga_m.apga012, 
       g_apga_m.apga010,g_apga_m.apga014,g_apga_m.apga011,g_apga_m.apga100,g_apga_m.apga015,g_apga_m.apga103, 
       g_apga_m.apga104,g_apga_m.apga108,g_apga_m.apga102,g_apga_m.apga026,g_apga_m.apga040,g_apga_m.apga109, 
       g_apga_m.apga101,g_apga_m.apga113,g_apga_m.apga114,g_apga_m.apga118,g_apga_m.apga112,g_apga_m.apga105, 
       g_apga_m.apga016,g_apga_m.apga017,g_apga_m.apga018,g_apga_m.apga115,g_apga_m.apga106,g_apga_m.apga107, 
       g_apga_m.apga019,g_apga_m.apga020,g_apga_m.apga021,g_apga_m.apga022,g_apga_m.apga023,g_apga_m.apga024, 
       g_apga_m.apga025,g_apga_m.apga036,g_apga_m.apga037,g_apga_m.apga032,g_apga_m.apga034,g_apga_m.apga035, 
       g_apga_m.apga031,g_apga_m.apga038,g_apga_m.apga039,g_apga_m.apga033,g_apga_m.apga027,g_apga_m.apgacomp_desc, 
       g_apga_m.apga005_desc,g_apga_m.apga004_desc,g_apga_m.apgaownid_desc,g_apga_m.apgaowndp_desc,g_apga_m.apgacrtid_desc, 
       g_apga_m.apgacrtdp_desc,g_apga_m.apgamodid_desc,g_apga_m.apgacnfid_desc,g_apga_m.apgapstid_desc, 
       g_apga_m.apga007_desc,g_apga_m.apga030_desc,g_apga_m.apga020_desc,g_apga_m.apga036_desc,g_apga_m.apga037_desc, 
       g_apga_m.apga034_desc,g_apga_m.apga035_desc,g_apga_m.apga038_desc,g_apga_m.apga039_desc
   #albireo 160623-----e
   
   #160824-00049#1-----s
   CALL cl_set_comp_required('apga001',TRUE)
   #160824-00049#1-----e
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
   
      INPUT BY NAME g_apga_m.apga001,g_apga_m.apga003,g_apga_m.apga010,
                    g_apga_m.apga011,g_apga_m.apga012
            ATTRIBUTE(WITHOUT DEFAULTS)
         #160824-00049#1-----s
         AFTER FIELD apga001
            IF NOT cl_null(g_apga_m.apga001) THEN
               IF g_apga_m.apga001 != g_apga_m_t.apga001 OR g_apga_m_t.apga001 IS NULL  THEN
                  LET l_count = NULL
                  SELECT COUNT(*) INTO l_count FROM apga_t
                   WHERE apgacomp = g_apga_m.apgacomp
                     AND apga001 = g_apga_m.apga001
                     AND apgaent = g_enterprise
                  IF cl_null(l_count)THEN LET l_count = 0 END IF
                  
                  IF l_count > 1 THEN   #同一法人中LC NO不可重複
                     INITIALIZE g_errparam.* TO NULL
                     LET g_errparam.code = 'aap-00529'
                     LET g_errparam.extend = ''
                     LET g_errparam.popup = FALSE
                     CALL cl_err()      
                     LET g_apga_m.apga001 = g_apga_m_t.apga001
                     NEXT FIELD CURRENT      
                  END IF                  
               END IF
            END IF
         #160824-00049#1-----e
            
         AFTER INPUT
            IF INT_FLAG THEN
               EXIT DIALOG
            END IF
            CALL s_transaction_begin()
            UPDATE apga_t SET apga001 = g_apga_m.apga001,
                              apga003 = g_apga_m.apga003,
                              apga010 = g_apga_m.apga010,
                              apga011 = g_apga_m.apga011,
                              apga012 = g_apga_m.apga012      
             WHERE apgaent = g_enterprise 
               AND apgacomp = g_apga_m.apgacomp
               AND apgadocno = g_apga_m.apgadocno
            IF SQLCA.sqlcode THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "apga_t" 
               LET g_errparam.code   = SQLCA.sqlcode 
               LET g_errparam.popup  = TRUE 
               CALL cl_err()
               CALL s_transaction_end('N','0')
               NEXT FIELD CURRENT
            END IF
            
      END INPUT
      ON ACTION accept
         ACCEPT DIALOG
        
      ON ACTION cancel      #在dialog button (放棄)
         LET INT_FLAG = TRUE 
         LET g_detail_idx  = 1
         LET g_detail_idx2 = 1
         EXIT DIALOG
 
      ON ACTION close       #在dialog 右上角 (X)
         LET INT_FLAG = TRUE 
         EXIT DIALOG
 
      ON ACTION exit        #toolbar 離開
         LET INT_FLAG = TRUE 
         LET g_detail_idx  = 1
         LET g_detail_idx2 = 1
         EXIT DIALOG
   END DIALOG
   #160824-00049#1-----s
   CALL cl_set_comp_required('apga001',FALSE)
   #160824-00049#1-----e
   IF INT_FLAG THEN
      LET INT_FLAG = 0
      LET g_apga_m.* = g_apga_m_t.*
      CALL aapt510_show()
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = '' 
      LET g_errparam.code   = 9001 
      LET g_errparam.popup  = FALSE 
      CALL cl_err()
      CALL s_transaction_end('N','0')
      RETURN
   END IF 
   
   CALL s_transaction_end('Y','0')
END FUNCTION

PRIVATE FUNCTION aapt510_apga030_desc()
   LET g_apga_m.apga030_desc = ''
   SELECT nmabl003 INTO g_apga_m.apga030_desc
     FROM nmabl_t
    WHERE nmablent = g_enterprise
      AND nmabl001 = g_apga_m.apga030
      AND nmabl002 = g_dlang
   DISPLAY BY NAME g_apga_m.apga030_desc
END FUNCTION

################################################################################
# Descriptions...: 描述说明
# Memo...........:
# Usage..........: CALL s_aooi150_ins (传入参数)
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 日期 By 作者
# Modify.........:
################################################################################
PRIVATE FUNCTION aapt510_auto_ins_b1(p_wc)
   DEFINE p_wc   STRING
   DEFINE l_sql  STRING
   DEFINE l_apgb001   LIKE apgb_t.apgb001
   DEFINE l_apgb002   LIKE apgb_t.apgb002
   
   DEFINE l_source      DYNAMIC ARRAY OF RECORD
         chr         LIKE type_t.chr500,
         dat         LIKE type_t.dat
                 END RECORD
   DEFINE l_ld   LIKE glaa_t.glaald
   DEFINE l_pmdn047   LIKE pmdn_t.pmdn047
   DEFINE l_pmdn007   LIKE pmdn_t.pmdn007
   DEFINE l_glaa001   LIKE glaa_t.glaa001
   DEFINE l_oodb004   LIKE oodb_t.oodb004
   DEFINE l_apca013   LIKE apca_t.apca013
   DEFINE l_apca012   LIKE apca_t.apca012
   DEFINE l_oodb011   LIKE oodb_t.oodb011
   #DEFINE l_apgb      RECORD LIKE apgb_t.* #161104-00024#4 mark
   #161104-00024#4-add(s)
   DEFINE l_apgb  RECORD  #信用狀申請明細檔
          apgbent   LIKE apgb_t.apgbent, #企業編號
          apgbcomp  LIKE apgb_t.apgbcomp, #法人
          apgbdocno LIKE apgb_t.apgbdocno, #申請單號
          apgbseq   LIKE apgb_t.apgbseq, #項次
          apgborga  LIKE apgb_t.apgborga, #來源組織
          apgb001   LIKE apgb_t.apgb001, #採購單號
          apgb002   LIKE apgb_t.apgb002, #採購單號項次
          apgb003   LIKE apgb_t.apgb003, #產品編號
          apgb004   LIKE apgb_t.apgb004, #品名規格
          apgb005   LIKE apgb_t.apgb005, #單位
          apgb006   LIKE apgb_t.apgb006, #稅別
          apgb007   LIKE apgb_t.apgb007, #含稅否
          apgb008   LIKE apgb_t.apgb008, #採購數量
          apgb009   LIKE apgb_t.apgb009, #原幣含稅單價
          apgb010   LIKE apgb_t.apgb010, #到貨數量
          apgb011   LIKE apgb_t.apgb011, #在途數量
          apgb105   LIKE apgb_t.apgb105, #原幣含稅金額
          apgb115   LIKE apgb_t.apgb115, #本幣含稅金額
          apgbud001 LIKE apgb_t.apgbud001, #自定義欄位(文字)001
          apgbud002 LIKE apgb_t.apgbud002, #自定義欄位(文字)002
          apgbud003 LIKE apgb_t.apgbud003, #自定義欄位(文字)003
          apgbud004 LIKE apgb_t.apgbud004, #自定義欄位(文字)004
          apgbud005 LIKE apgb_t.apgbud005, #自定義欄位(文字)005
          apgbud006 LIKE apgb_t.apgbud006, #自定義欄位(文字)006
          apgbud007 LIKE apgb_t.apgbud007, #自定義欄位(文字)007
          apgbud008 LIKE apgb_t.apgbud008, #自定義欄位(文字)008
          apgbud009 LIKE apgb_t.apgbud009, #自定義欄位(文字)009
          apgbud010 LIKE apgb_t.apgbud010, #自定義欄位(文字)010
          apgbud011 LIKE apgb_t.apgbud011, #自定義欄位(數字)011
          apgbud012 LIKE apgb_t.apgbud012, #自定義欄位(數字)012
          apgbud013 LIKE apgb_t.apgbud013, #自定義欄位(數字)013
          apgbud014 LIKE apgb_t.apgbud014, #自定義欄位(數字)014
          apgbud015 LIKE apgb_t.apgbud015, #自定義欄位(數字)015
          apgbud016 LIKE apgb_t.apgbud016, #自定義欄位(數字)016
          apgbud017 LIKE apgb_t.apgbud017, #自定義欄位(數字)017
          apgbud018 LIKE apgb_t.apgbud018, #自定義欄位(數字)018
          apgbud019 LIKE apgb_t.apgbud019, #自定義欄位(數字)019
          apgbud020 LIKE apgb_t.apgbud020, #自定義欄位(數字)020
          apgbud021 LIKE apgb_t.apgbud021, #自定義欄位(日期時間)021
          apgbud022 LIKE apgb_t.apgbud022, #自定義欄位(日期時間)022
          apgbud023 LIKE apgb_t.apgbud023, #自定義欄位(日期時間)023
          apgbud024 LIKE apgb_t.apgbud024, #自定義欄位(日期時間)024
          apgbud025 LIKE apgb_t.apgbud025, #自定義欄位(日期時間)025
          apgbud026 LIKE apgb_t.apgbud026, #自定義欄位(日期時間)026
          apgbud027 LIKE apgb_t.apgbud027, #自定義欄位(日期時間)027
          apgbud028 LIKE apgb_t.apgbud028, #自定義欄位(日期時間)028
          apgbud029 LIKE apgb_t.apgbud029, #自定義欄位(日期時間)029
          apgbud030 LIKE apgb_t.apgbud030, #自定義欄位(日期時間)030
          apgb100   LIKE apgb_t.apgb100, #幣別
          apgb101   LIKE apgb_t.apgb101  #匯率
              END RECORD
   #161104-00024#4-add(e)
   DEFINE r_success   LIKE type_t.num5
   DEFINE l_count     LIKE type_t.num10
   DEFINE l_pmdl015   LIKE pmdl_t.pmdl015   #160428-00001#1
   DEFINE l_pmdl016   LIKE pmdl_t.pmdl016   #160428-00001#1
   #160627 albireo-----s
   DEFINE l_oodb005   LIKE oodb_t.oodb005
   DEFINE l_oodbl004  LIKE type_t.chr1000
   DEFINE l_oodb006   LIKE oodb_t.oodb006
   #160627 albireo-----e
   
   LET r_success  = TRUE
   
   LET l_ld = NULL   LET l_glaa001 = NULL
   SELECT glaald ,glaa001
     INTO l_ld ,l_glaa001
     FROM glaa_t
    WHERE glaaent = g_enterprise
      AND glaacomp = g_apga_m.apgacomp
      AND glaa014 = 'Y'              
      
   LET l_sql = "SELECT pmdndocno,pmdnseq FROM pmdn_t ",
               " WHERE pmdnent = ",g_enterprise," ",
               "   AND ",p_wc CLIPPED
   PREPARE sel_pmdnp1 FROM l_sql
   DECLARE sel_pmdnc1 CURSOR FOR sel_pmdnp1
   
   FOREACH sel_pmdnc1 INTO l_apgb001,l_apgb002
      IF SQLCA.SQLCODE THEN EXIT FOREACH END IF
      
      #160428-00001#1 ---s---
      LET l_pmdl015 = NULL
      LET l_pmdl016 = NULL
      SELECT pmdl015,pmdl016 
        INTO l_pmdl015,l_pmdl016
        FROM pmdl_t 
       WHERE pmdlent = g_enterprise
         AND pmdldocno = l_apgb001 
      #160428-00001#1 ---e---
      CALL aapt510_apgb001_002_chk(g_apga_m.apgacomp,g_apga_m.apga004,l_apgb001,l_apgb002)
         RETURNING g_sub_success,g_errno
         
      IF NOT g_sub_success THEN CONTINUE FOREACH END IF
      
      LET l_count = NULL
      SELECT COUNT(*) INTO l_count FROM apgb_t
       WHERE apgbent = g_enterprise
         AND apgbcomp = g_apga_m.apgacomp
         #AND apgbdocno = g_apga_m.apgadocno
         AND apgb001 = l_apgb001
         AND apgb002 = l_apgb002
      IF cl_null(l_count)THEN LET l_count = 0 END IF
      IF l_count > 0 THEN CONTINUE FOREACH END IF
      
      LET l_pmdn047 = NULL
      LET l_pmdn007 = NULL
      SELECT pmdn047 ,pmdn007 
        INTO l_pmdn047 ,l_pmdn007
        FROM pmdn_t
       WHERE pmdnent = g_enterprise
         AND pmdndocno = l_apgb001
         AND pmdnseq   = l_apgb002
      IF cl_null(l_pmdn047)THEN LET l_pmdn047 = 0 END IF
      
      
      INITIALIZE l_apgb.* TO NULL
      LET l_apgb.apgbent = g_enterprise
      LET l_apgb.apgbcomp = g_apga_m.apgacomp
      LET l_apgb.apgbdocno = g_apga_m.apgadocno
      LET l_apgb.apgborga  = g_apga_m.apgacomp
      LET l_apgb.apgb001 = l_apgb001
      LET l_apgb.apgb002 = l_apgb002
      LET l_apgb.apgbseq = NULL
      SELECT MAX(apgbseq) + 1 INTO l_apgb.apgbseq FROM apgb_t
       WHERE apgbent = g_enterprise
         AND apgbcomp = g_apga_m.apgacomp
         AND apgbdocno = g_apga_m.apgadocno
      IF cl_null(l_apgb.apgbseq)THEN LET l_apgb.apgbseq = 1 END IF
           
      CALL l_source.clear()
      CALL s_aapt300_source_doc_carry_b('10',l_apgb001,l_apgb002,'','')
           RETURNING g_sub_success,g_errno,l_source
           
      LET l_apgb.apgb003  = l_source[4].chr   #產品編號
      LET l_apgb.apgb004  = l_source[5].chr   #品名規格
      LET l_apgb.apgb005  = l_source[6].chr   #單位
      LET l_apgb.apgb006  = l_source[20].chr  #稅別
      CALL s_tax_chk(g_apga_m.apgacomp,l_apgb.apgb006) RETURNING r_success,l_oodbl004,l_oodb005,l_oodb006,l_oodb011           #含稅否   #albireo 160627
      LET l_apgb.apgb008  = l_pmdn007         #數量
      LET l_apgb.apgb105  = l_pmdn047         #pmdn047   #原幣含稅金額
      IF l_oodb005 = 'N' THEN   #albireo 160627 add
         LET l_apgb.apgb009  = l_pmdn047 / l_apgb.apgb008   #pmdn047 / 數量 =原幣含稅單價
      ELSE
         LET l_apgb.apgb009  = l_source[31].chr   #albireo 160627 add
      END IF
      LET l_apgb.apgb010  = 0                 #到貨數量   #160428-00001#1 
      LET l_apgb.apgb100 = l_pmdl015          #幣別
      LET l_apgb.apgb101 = l_pmdl016          #匯率            
      #取位(原幣)
      #CALL s_curr_round_ld('1',l_ld,g_apga_m.apga100,l_apgb.apgb009,1) RETURNING g_sub_success,g_errno,g_apgb_d[l_ac].apgb009
       CALL s_curr_round_ld('1',l_ld,l_pmdl015,l_apgb.apgb009,1) RETURNING g_sub_success,g_errno,g_apgb_d[l_ac].apgb009                   
      #本幣含稅金額
      #LET l_apgb.apgb115 = l_apgb.apgb105 * g_apga_m.apga101
       LET l_apgb.apgb115 = l_apgb.apgb105 * l_apgb.apgb101
      #取位(本幣)
      CALL s_curr_round_ld('1',l_ld,l_glaa001,l_apgb.apgb115,2) RETURNING g_sub_success,g_errno,g_apgb_d[l_ac].apgb115 
      CALL s_tax_chk(g_apga_m.apgacomp,l_apgb.apgb006) RETURNING g_sub_success,l_oodb004,l_apca013,l_apca012,l_oodb011
      LET l_apgb.apgb007 = l_apca013
      LET l_apgb.apgb011 = 0
      #INSERT INTO apgb_t VALUES(l_apgb.*) #161108-00017#4 mark
      #161108-00017#4 add ------
      INSERT INTO apgb_t (apgbent,apgbcomp,apgbdocno,apgbseq,apgborga,
                          apgb001,apgb002,apgb003,apgb004,apgb005,
                          apgb006,apgb007,apgb008,apgb009,apgb010,
                          apgb011,apgb105,apgb115,
                          apgbud001,apgbud002,apgbud003,apgbud004,apgbud005,
                          apgbud006,apgbud007,apgbud008,apgbud009,apgbud010,
                          apgbud011,apgbud012,apgbud013,apgbud014,apgbud015,
                          apgbud016,apgbud017,apgbud018,apgbud019,apgbud020,
                          apgbud021,apgbud022,apgbud023,apgbud024,apgbud025,
                          apgbud026,apgbud027,apgbud028,apgbud029,apgbud030,
                          apgb100,apgb101
                         )
      VALUES (l_apgb.apgbent,l_apgb.apgbcomp,l_apgb.apgbdocno,l_apgb.apgbseq,l_apgb.apgborga,
              l_apgb.apgb001,l_apgb.apgb002,l_apgb.apgb003,l_apgb.apgb004,l_apgb.apgb005,
              l_apgb.apgb006,l_apgb.apgb007,l_apgb.apgb008,l_apgb.apgb009,l_apgb.apgb010,
              l_apgb.apgb011,l_apgb.apgb105,l_apgb.apgb115,
              l_apgb.apgbud001,l_apgb.apgbud002,l_apgb.apgbud003,l_apgb.apgbud004,l_apgb.apgbud005,
              l_apgb.apgbud006,l_apgb.apgbud007,l_apgb.apgbud008,l_apgb.apgbud009,l_apgb.apgbud010,
              l_apgb.apgbud011,l_apgb.apgbud012,l_apgb.apgbud013,l_apgb.apgbud014,l_apgb.apgbud015,
              l_apgb.apgbud016,l_apgb.apgbud017,l_apgb.apgbud018,l_apgb.apgbud019,l_apgb.apgbud020,
              l_apgb.apgbud021,l_apgb.apgbud022,l_apgb.apgbud023,l_apgb.apgbud024,l_apgb.apgbud025,
              l_apgb.apgbud026,l_apgb.apgbud027,l_apgb.apgbud028,l_apgb.apgbud029,l_apgb.apgbud030,
              l_apgb.apgb100,l_apgb.apgb101
             )
      #161108-00017#4 add end---
   END FOREACH
   
   RETURN r_success
END FUNCTION

################################################################################
# Descriptions...: 單身貨幣檢核(畫面上只能允許出現兩種不同貨幣)
# Memo...........:
# Usage..........: CALL aapt510_curry_chk(p_curry)
# Date & Author..: 2016/06/03 By Hans
# Modify.........: #160428-00001#1
################################################################################
PRIVATE FUNCTION aapt510_curry_chk(p_curry)
DEFINE p_curry    LIKE apga_t.apga100
DEFINE l_sql      STRING
DEFINE l_apgb100  LIKE apgb_t.apgb100
DEFINE r_success  LIKE type_t.num5
DEFINE r_errno    LIKE gzze_t.gzze001
DEFINE l_cnt      LIKE type_t.num5


   LET r_success = TRUE LET r_errno = NULL LET l_cnt = 0
   
   
   LET l_sql =" SELECT DISTINCT apgb100                                ",
              " FROM apgb_t WHERE apgbdocno = '",g_apga_m.apgadocno,"' ",
              "  AND apgbent = '",g_enterprise,"' ORDER BY apgb100     "
   
   PREPARE aapt510_curry_chk_prep FROM l_sql
   DECLARE aapt510_curry_chk_curs CURSOR FOR aapt510_curry_chk_prep
   
 
   #單頭本幣與原幣相等   
   IF g_apga_m.apga100 = g_apga_m.glaa001 THEN 
      #160622-00006#1 modify-----s
      #IF p_curry <> g_apga_m.apga100 THEN     
      #   FOREACH aapt510_curry_chk_curs INTO l_apgb100 #搜索單身之幣別
      #      IF l_apgb100 = p_curry THEN                
      #         LET l_apgb100 = NULL
      #         CONTINUE FOREACH
      #      ELSE
      #         IF p_curry <> g_apga_m.apga100 THEN 
      #            IF l_apgb100 <> p_curry THEN #找到的幣別跟輸入幣別不同
      #               LET r_success = FALSE
      #               LET r_errno = 'aap-00550'
      #               RETURN r_success,r_errno 
      #            END IF
      #         END IF
      #      END IF
      #   END FOREACH
      #   #找不到不同幣別
      #   IF cl_null(l_apgb100) THEN
      #      RETURN r_success,r_errno   
      #   END IF
      #END IF
      RETURN r_success,r_errno
      #160622-00006#1 modify-----e
   END IF  
   
   #單頭本幣與原幣不同
   IF g_apga_m.apga100 <> g_apga_m.glaa001 THEN
      IF g_apga_m.apga100 <> p_curry THEN
         IF g_apga_m.glaa001 <> p_curry THEN
            LET r_success = FALSE
            LET r_errno = 'aap-00550'
            RETURN r_success,r_errno  
         END IF
      END IF     
   END IF
   
   RETURN r_success,r_errno  

END FUNCTION

################################################################################
# Descriptions...: 費用單身發票號碼檢核
# Memo...........:
# Usage..........: CALL aapt510_apgc009_chk(p_ac)
# Date & Author..: 2016/06/03 By Hans
# Modify.........:
################################################################################
PRIVATE FUNCTION aapt510_apgc009_chk(p_ac)
DEFINE r_success LIKE type_t.num5
DEFINE r_errno   LIKE gzze_t.gzze001
DEFINE l_apgc009 LIKE apgc_t.apgc009
DEFINE l_apgc010 LIKE apgc_t.apgc010
DEFINE l_apgc100 LIKE apgc_t.apgc100
DEFINE p_ac      LIKE type_t.num5
DEFINE l_sql     STRING
   
   LET r_success = TRUE
   LET r_errno = ''
   CALL cl_set_comp_entry('apgc010',TRUE)
   #不同幣別不可輸入相同的發票號碼
   LET l_sql = "  SELECT apgc009,apgc010,apgc100 FROM apgc_t  ",
               "   WHERE apgcent = '",g_enterprise,"'  AND apgcdocno = '",g_apga_m.apgadocno,"'  ",
               "   ORDER BY apgcseq "
   PREPARE aapt510_apgc009_chk_prep FROM l_sql 
   DECLARE aapt510_apgc009_chk_curs CURSOR FOR aapt510_apgc009_chk_prep
   FOREACH aapt510_apgc009_chk_curs INTO l_apgc009,l_apgc010,l_apgc100
      IF cl_null(l_apgc009) THEN CONTINUE FOREACH END IF
      CASE 
         WHEN l_apgc100 <> g_apgb2_d[p_ac].apgc100        #不同幣別發票號碼相同報錯
            IF l_apgc009 = g_apgb2_d[p_ac].apgc009 THEN          
               LET r_success = FALSE 
               LET r_errno = 'aap-00552'
               RETURN r_success,r_errno
            END IF                     
            
         WHEN l_apgc100 = g_apgb2_d[p_ac].apgc100       #相同幣別發票號碼也相同.發票日期不可異動以第一筆為主,
            IF l_apgc009 = g_apgb2_d[p_ac].apgc009 THEN 
               LET g_apgb2_d[p_ac].apgc010 = l_apgc010
               CALL cl_set_comp_entry('apgc010',FALSE)
               RETURN r_success,r_errno
            END IF                          
      END CASE         
   END FOREACH   
   

   RETURN r_success,r_errno








END FUNCTION

################################################################################
# Descriptions...: 單身合計檢核
# Memo...........:
# Usage..........: CALL aapt510_bsum_chk()
# Date & Author..: 2016/06/04 By Hans
# Modify.........:
################################################################################
PRIVATE FUNCTION aapt510_bsum_chk()
DEFINE l_flag         LIKE type_t.chr1
DEFINE l_cnt          LIKE type_t.num5
DEFINE l_apgb115sum   LIKE type_t.num20_6
DEFINE l_apgb105sum   LIKE type_t.num20_6
DEFINE l_ld           LIKE apca_t.apcald
DEFINE r_str          STRING
DEFINE l_sql          STRING
DEFINE l_cnt2         LIKE type_t.num5   #albireo 160623 add

   
   LET r_str = 'aim-00108' LET l_cnt = 0
   #  IF 多幣別採購單  =Y  檢核單身本幣合計是否等於單頭開狀本幣+預付款本幣
   #  ELSE                檢核原幣金額 
   LET l_cnt = NULL   
   SELECT COUNT(DISTINCT apgb100) INTO l_cnt
     FROM apgb_t 
    WHERE apgbdocno = g_apga_m.apgadocno 
      AND apgbent = g_enterprise
   IF cl_null(l_cnt) THEN LET l_cnt = 0 ENd IF      
   
   #albireo 160623-----s
   LET l_cnt2 = NULL
   SELECT COUNT(DISTINCT apgb100) INTO l_cnt2
     FROM apgb_t
    WHERE apgbent = g_enterprise
      AND apgbdocno = g_apga_m.apgadocno
      AND apgbcomp  = g_apga_m.apgacomp
      AND apgb100 = g_apga_m.apga100
   IF cl_null(l_cnt2)THEN LET l_cnt2 = 0 END IF
   #albireo 160623-----e
   
   SELECT SUM(apgb105),SUM(apgb115) 
     INTO l_apgb105sum,l_apgb115sum FROM apgb_t
    WHERE apgbent = g_enterprise
      AND apgbdocno = g_apga_m.apgadocno   
      
   
   #IF l_cnt > 1 THEN #單身存在兩種以上的幣別，不合時給予訊息詢問是否確定要審核?         #albireo 160623 用存在兩種幣別這種判斷方式會錯 因為可能單身只存在一種幣別但是是交易原幣
   #albireo 160623-----s
   IF l_cnt2 > 0 AND l_cnt = l_cnt2 THEN
       IF l_apgb105sum <> g_apga_m.apga102 + g_apga_m.apga103 THEN  
          LET r_str = 'aap-00553'
          RETURN r_str   
       END IF        
   ELSE
      IF l_apgb115sum <> g_apga_m.apga112 + g_apga_m.apga113 THEN
         LET r_str = 'aap-00553'
         RETURN r_str              
      END IF       
   END IF
   #albireo 160623-----e
   #albireo 160623 mark-----s
   #ELSE
   #   #檢核原幣金額, 不合時給予訊息詢問是否確定要審核? 
   #   IF l_apgb105sum <> g_apga_m.apga112 + g_apga_m.apga113 THEN  
   #      LET r_str = 'aap-00553'                  
   #   END IF        
   #END IF
   #albireo 160623 mark-----e
   
   RETURN r_str
     

END FUNCTION

################################################################################
# Descriptions...: 改匯率重推單身
# Memo...........:
# Date & Author..: 160627 By albireo
# Modify.........: NO USE
################################################################################
PRIVATE FUNCTION aapt510_auto_recount_b()
   DEFINE l_sql    STRING
   
   LET l_sql = "SELECT apgb101,apgb105 FROM apgb_t ",
               " WHERE apgbent = ",g_enterprise," ",
               "   AND apgbcomp = '",g_apga_m.apgacomp,"' ",
               "   AND apgbdocno ='",g_apga_m.apgadocno,"' ",
               "   AND apgb100 = '",g_apga_m.apga100,"' "
   PREPARE sel_apgbp4 FROM l_sql
   DECLARE sel_apgbc4 CURSOR FOR sel_apgbp4
   
   
               
END FUNCTION

 
{</section>}
 
