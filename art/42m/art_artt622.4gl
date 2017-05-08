#該程式未解開Section, 採用最新樣板產出!
{<section id="artt622.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0014(2016-07-04 11:09:17), PR版次:0014(2016-11-14 17:30:39)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000034
#+ Filename...: artt622
#+ Description: 積分超市兌換作業
#+ Creator....: 06189(2016-06-17 22:09:14)
#+ Modifier...: 08172 -SD/PR- 02481
 
{</section>}
 
{<section id="artt622.global" >}
#應用 t01 樣板自動產生(Version:79)
#add-point:填寫註解說明 name="global.memo" 
#+ Modifier...: 08172(2016-04-12) -SD/PR- #160406-00029#1 画面调整
#+ Modifier...: 160419-00044#2  2016/04/20 By dongsz 【批号】栏位根据单据别参数控制，自动冲减时不允许维护
#+ Modifier...: 160318-00025#49 2016/04/26 By 07673   將重複內容的錯誤訊息置換為公用錯誤訊息
#+ Modfifer···: 150429-00007#9  2015/05/09 By dongsz  新增作業aprt280
#+ Modfifer···: 160604-00009#85 2016/06/20 By dongsz  增加退货逻辑(来源单号为当前作业单号)
#+ Modfifer···: 160604-00009#86 2016/06/20 By zn      增加條碼槍的邏輯
#+ Modfifer···: 160604-00009#79 2016/06/20 By zn      加字段~
#  Modify.....: 160701-00025#1  2016/07/04 by 08172   过账按钮显示
#  Modify.....: 160816-00068#09 2016/08/17 By 08209   調整transaction
#  Modify.....: 160905-00007#15 2016/09/05 by 08172   调整系统中无ENT的SQL条件增加ent
#  Modfifer...: 160913-00034#7  2016/09/19 by 08742   修改q_pmaa001或者q_pmaa001_8的开窗对应的栏位检查时候是不是判断pmaa002 IN('1','3')
#161024-00025#1 2016/10/24 By dongsz   rtia018,rtia024编辑开窗改为q_ooef001_24,条件：ooef201='Y'；对应栏位检查同步修改
# Modify......: 160824-00007#172 2016/11/07 By 06137  修正舊值備份寫法
#  Modify.....: 161111-00028#3   2016/11/07  By 02481  标准程式定义采用宣告模式,弃用.*写法
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
PRIVATE type type_g_rtia_m        RECORD
       rtiasite LIKE rtia_t.rtiasite, 
   rtiasite_desc LIKE type_t.chr80, 
   rtiadocdt LIKE rtia_t.rtiadocdt, 
   rtiadocno LIKE rtia_t.rtiadocno, 
   rtia002 LIKE rtia_t.rtia002, 
   rtia002_desc LIKE type_t.chr80, 
   rtia001 LIKE rtia_t.rtia001, 
   rtia001_desc LIKE type_t.chr80, 
   rtia059 LIKE rtia_t.rtia059, 
   rtia060 LIKE rtia_t.rtia060, 
   mmaf003 LIKE mmaf_t.mmaf003, 
   mmaf004 LIKE mmaf_t.mmaf004, 
   rtia004 LIKE rtia_t.rtia004, 
   rtia004_desc LIKE type_t.chr80, 
   rtia005 LIKE rtia_t.rtia005, 
   rtia005_desc LIKE type_t.chr80, 
   rtia006 LIKE rtia_t.rtia006, 
   rtia048 LIKE type_t.chr1, 
   rtia053 LIKE rtia_t.rtia053, 
   rtiastus LIKE rtia_t.rtiastus, 
   rtia007 LIKE rtia_t.rtia007, 
   rtia008 LIKE rtia_t.rtia008, 
   rtia009 LIKE rtia_t.rtia009, 
   rtia009_desc LIKE type_t.chr80, 
   rtia043 LIKE rtia_t.rtia043, 
   rtia047 LIKE rtia_t.rtia047, 
   l_rtia047 LIKE type_t.chr500, 
   rtia013 LIKE rtia_t.rtia013, 
   rtia014 LIKE rtia_t.rtia014, 
   rtia015 LIKE rtia_t.rtia015, 
   rtia016 LIKE rtia_t.rtia016, 
   rtia051 LIKE rtia_t.rtia051, 
   rtia010 LIKE rtia_t.rtia010, 
   rtia010_desc LIKE type_t.chr80, 
   rtia011 LIKE rtia_t.rtia011, 
   rtia011_desc LIKE type_t.chr80, 
   rtia012 LIKE rtia_t.rtia012, 
   rtia012_desc LIKE type_t.chr80, 
   chantype LIKE type_t.chr10, 
   barcode LIKE type_t.chr500, 
   rtia041 LIKE rtia_t.rtia041, 
   rtia017 LIKE rtia_t.rtia017, 
   rtia018 LIKE rtia_t.rtia018, 
   rtia018_desc LIKE type_t.chr80, 
   rtia019 LIKE rtia_t.rtia019, 
   rtia020 LIKE rtia_t.rtia020, 
   rtia021 LIKE rtia_t.rtia021, 
   rtia022 LIKE rtia_t.rtia022, 
   rtia023 LIKE rtia_t.rtia023, 
   rtia024 LIKE rtia_t.rtia024, 
   rtia024_desc LIKE type_t.chr80, 
   rtia025 LIKE rtia_t.rtia025, 
   rtia025_desc LIKE type_t.chr80, 
   rtia026 LIKE rtia_t.rtia026, 
   rtia027 LIKE rtia_t.rtia027, 
   rtia028 LIKE rtia_t.rtia028, 
   rtia029 LIKE rtia_t.rtia029, 
   rtia030 LIKE rtia_t.rtia030, 
   rtia032 LIKE rtia_t.rtia032, 
   rtia033 LIKE rtia_t.rtia033, 
   rtia034 LIKE rtia_t.rtia034, 
   rtia035 LIKE rtia_t.rtia035, 
   rtia036 LIKE rtia_t.rtia036, 
   rtia036_desc LIKE type_t.chr80, 
   rtia037 LIKE rtia_t.rtia037, 
   rtia037_desc LIKE type_t.chr80, 
   rtia038 LIKE rtia_t.rtia038, 
   rtia038_desc LIKE type_t.chr80, 
   rtia039 LIKE rtia_t.rtia039, 
   rtia107 LIKE rtia_t.rtia107, 
   isaf009 LIKE isaf_t.isaf009, 
   isaf010 LIKE isaf_t.isaf010, 
   isaf044 LIKE isaf_t.isaf044, 
   isaf202 LIKE isaf_t.isaf202, 
   isaf203 LIKE isaf_t.isaf203, 
   isaf204 LIKE isaf_t.isaf204, 
   isaf201 LIKE isaf_t.isaf201, 
   isaf207 LIKE isaf_t.isaf207, 
   rtiaownid LIKE rtia_t.rtiaownid, 
   rtiaownid_desc LIKE type_t.chr80, 
   rtiacrtid LIKE rtia_t.rtiacrtid, 
   rtiacrtid_desc LIKE type_t.chr80, 
   rtiaowndp LIKE rtia_t.rtiaowndp, 
   rtiaowndp_desc LIKE type_t.chr80, 
   rtiacrtdp LIKE rtia_t.rtiacrtdp, 
   rtiacrtdp_desc LIKE type_t.chr80, 
   rtiacrtdt LIKE rtia_t.rtiacrtdt, 
   rtiamodid LIKE rtia_t.rtiamodid, 
   rtiamodid_desc LIKE type_t.chr80, 
   rtiamoddt LIKE rtia_t.rtiamoddt, 
   rtiacnfid LIKE rtia_t.rtiacnfid, 
   rtiacnfid_desc LIKE type_t.chr80, 
   rtiacnfdt LIKE rtia_t.rtiacnfdt, 
   rtiapstid LIKE rtia_t.rtiapstid, 
   rtiapstid_desc LIKE type_t.chr80, 
   rtiapstdt LIKE rtia_t.rtiapstdt, 
   snum LIKE type_t.chr500, 
   amount LIKE type_t.chr500, 
   amount2 LIKE type_t.chr500, 
   amount3 LIKE type_t.chr500
       END RECORD
 
#單身 type 宣告
PRIVATE TYPE type_g_rtib_d        RECORD
       rtibsite LIKE rtib_t.rtibsite, 
   rtibunit LIKE rtib_t.rtibunit, 
   rtiborga LIKE rtib_t.rtiborga, 
   rtibseq LIKE rtib_t.rtibseq, 
   rtib035 LIKE rtib_t.rtib035, 
   rtib042 LIKE rtib_t.rtib042, 
   rtib001 LIKE rtib_t.rtib001, 
   xmda001 LIKE type_t.chr500, 
   rtib002 LIKE rtib_t.rtib002, 
   rtib003 LIKE rtib_t.rtib003, 
   rtib004 LIKE rtib_t.rtib004, 
   rtib005 LIKE rtib_t.rtib005, 
   rtib004_desc LIKE type_t.chr500, 
   rtib106 LIKE rtib_t.rtib106, 
   rtib012 LIKE rtib_t.rtib012, 
   rtib108 LIKE rtib_t.rtib108, 
   rtib004_desc_desc LIKE type_t.chr500, 
   inag008 LIKE type_t.chr500, 
   rtib013 LIKE rtib_t.rtib013, 
   rtib013_desc LIKE type_t.chr500, 
   rtib107 LIKE rtib_t.rtib107, 
   rtib008 LIKE rtib_t.rtib008, 
   rtib009 LIKE rtib_t.rtib009, 
   rtib010 LIKE rtib_t.rtib010, 
   rtib014 LIKE rtib_t.rtib014, 
   rtib015 LIKE rtib_t.rtib015, 
   rtib016 LIKE rtib_t.rtib016, 
   rtib018 LIKE rtib_t.rtib018, 
   rtib018_desc LIKE type_t.chr500, 
   rtib017 LIKE rtib_t.rtib017, 
   rtib019 LIKE rtib_t.rtib019, 
   rtib020 LIKE rtib_t.rtib020, 
   rtib021 LIKE rtib_t.rtib021, 
   rtib031 LIKE rtib_t.rtib031, 
   rtib022 LIKE rtib_t.rtib022, 
   rtib024 LIKE rtib_t.rtib024, 
   rtib024_desc LIKE type_t.chr500, 
   rtib025 LIKE rtib_t.rtib025, 
   rtib025_desc LIKE type_t.chr500, 
   rtib026 LIKE rtib_t.rtib026, 
   rtib027 LIKE rtib_t.rtib027, 
   rtib032 LIKE rtib_t.rtib032, 
   rtib033 LIKE rtib_t.rtib033, 
   rtib033_desc LIKE type_t.chr500, 
   rtib028 LIKE rtib_t.rtib028, 
   rtib030 LIKE rtib_t.rtib030, 
   rtib039 LIKE rtib_t.rtib039, 
   rtib006 LIKE rtib_t.rtib006, 
   rtib006_desc LIKE type_t.chr500
       END RECORD
PRIVATE TYPE type_g_rtib2_d RECORD
       rticseq LIKE rtic_t.rticseq, 
   rtib003 LIKE rtib_t.rtib003, 
   rtib004 LIKE rtib_t.rtib004, 
   imaal003 LIKE imaal_t.imaal003, 
   imaal004 LIKE imaal_t.imaal004, 
   rtib013 LIKE rtib_t.rtib013, 
   rtib013_01_desc LIKE type_t.chr500, 
   rtib012 LIKE rtib_t.rtib012, 
   rtib008 LIKE rtib_t.rtib008, 
   rtib010 LIKE rtib_t.rtib010, 
   rtib021 LIKE rtib_t.rtib021, 
   rticseq1 LIKE rtic_t.rticseq1, 
   rtic001 LIKE rtic_t.rtic001, 
   rtic002 LIKE rtic_t.rtic002, 
   rtic003 LIKE rtic_t.rtic003, 
   rtic004 LIKE rtic_t.rtic004, 
   rtic005 LIKE rtic_t.rtic005, 
   rtic006 LIKE rtic_t.rtic006, 
   rtic007 LIKE rtic_t.rtic007, 
   rtic008 LIKE rtic_t.rtic008, 
   rtic009 LIKE rtic_t.rtic009, 
   rtic010 LIKE rtic_t.rtic010, 
   rtic011 LIKE rtic_t.rtic011, 
   rtic012 LIKE rtic_t.rtic012, 
   rtic013 LIKE rtic_t.rtic013, 
   rtic014 LIKE rtic_t.rtic014, 
   rtic015 LIKE rtic_t.rtic015, 
   rtic016 LIKE rtic_t.rtic016, 
   rtic017 LIKE rtic_t.rtic017, 
   rtic018 LIKE rtic_t.rtic018, 
   rtic020 LIKE rtic_t.rtic020
       END RECORD
PRIVATE TYPE type_g_rtib3_d RECORD
       xrcd007 LIKE xrcd_t.xrcd007, 
   xrcdld LIKE xrcd_t.xrcdld, 
   xrcdseq LIKE xrcd_t.xrcdseq, 
   rtib003 LIKE rtib_t.rtib003, 
   rtib004 LIKE rtib_t.rtib004, 
   rtib006 LIKE rtib_t.rtib006, 
   rtib006_02_desc LIKE type_t.chr500, 
   xrcdseq2 LIKE xrcd_t.xrcdseq2, 
   xrcd002 LIKE xrcd_t.xrcd002, 
   xrcd002_desc LIKE type_t.chr500, 
   xrcd003 LIKE xrcd_t.xrcd003, 
   xrcd006 LIKE xrcd_t.xrcd006, 
   xrcd004 LIKE xrcd_t.xrcd004, 
   xrcd104 LIKE xrcd_t.xrcd104
       END RECORD
PRIVATE TYPE type_g_rtib4_d RECORD
       rtieseq LIKE rtie_t.rtieseq, 
   rtib003 LIKE rtib_t.rtib003, 
   rtib004 LIKE rtib_t.rtib004, 
   rtieseq1 LIKE rtie_t.rtieseq1, 
   rtie001 LIKE rtie_t.rtie001, 
   rtie002 LIKE rtie_t.rtie002, 
   rtie002_desc LIKE type_t.chr500, 
   rtie006 LIKE rtie_t.rtie006
       END RECORD
PRIVATE TYPE type_g_rtib5_d RECORD
       rtiksite LIKE type_t.chr10, 
   rtikunit LIKE type_t.chr10, 
   rtikorg LIKE type_t.chr10, 
   rtikseq LIKE type_t.num10, 
   rtik001 LIKE type_t.chr20, 
   rtik002 LIKE type_t.num10, 
   rtik003 LIKE type_t.chr500, 
   rtik003_desc LIKE type_t.chr500, 
   rtik004 LIKE type_t.chr500, 
   rtik005 LIKE type_t.chr500, 
   rtik006 LIKE type_t.chr10, 
   rtik006_desc LIKE type_t.chr500, 
   rtik007 LIKE type_t.chr1, 
   rtik013 LIKE type_t.chr10, 
   rtik013_desc LIKE type_t.chr500, 
   rtik012 LIKE type_t.num20_6, 
   rtik008 LIKE type_t.num20_6, 
   rtik009 LIKE type_t.num20_6, 
   rtik010 LIKE type_t.num20_6, 
   rtik011 LIKE type_t.num20_6, 
   rtik014 LIKE type_t.num20_6, 
   rtik015 LIKE type_t.num20_6, 
   rtik016 LIKE type_t.num20_6, 
   rtik017 LIKE type_t.num20_6, 
   rtik018 LIKE type_t.chr10, 
   rtik019 LIKE type_t.chr10, 
   rtik019_desc LIKE type_t.chr500, 
   rtik020 LIKE type_t.chr10, 
   rtik020_desc LIKE type_t.chr500, 
   rtik021 LIKE type_t.chr30, 
   rtik022 LIKE type_t.chr20, 
   rtik023 LIKE type_t.num15_3
       END RECORD
PRIVATE TYPE type_g_rtib6_d RECORD
       rtinsite LIKE rtin_t.rtinsite, 
   rtinseq LIKE rtin_t.rtinseq, 
   rtinseq1 LIKE rtin_t.rtinseq1, 
   rtin001 LIKE rtin_t.rtin001, 
   rtin002 LIKE rtin_t.rtin002, 
   rtin003 LIKE rtin_t.rtin003, 
   rtin004 LIKE rtin_t.rtin004, 
   rtin005 LIKE rtin_t.rtin005, 
   rtin006 LIKE rtin_t.rtin006, 
   rtin007 LIKE rtin_t.rtin007, 
   rtin008 LIKE rtin_t.rtin008, 
   rtin009 LIKE rtin_t.rtin009, 
   rtin010 LIKE rtin_t.rtin010
       END RECORD
PRIVATE TYPE type_g_rtib7_d RECORD
       preksite LIKE type_t.chr10, 
   prekunit LIKE type_t.chr10, 
   prekseq LIKE type_t.num10, 
   prek001 LIKE type_t.dat, 
   prek002 LIKE type_t.chr20, 
   prek003 LIKE type_t.chr20, 
   prek004 LIKE type_t.num20_6
       END RECORD
 
 
PRIVATE TYPE type_browser RECORD
         b_statepic     LIKE type_t.chr50,
            b_rtiasite LIKE rtia_t.rtiasite,
   b_rtiasite_desc LIKE type_t.chr80,
      b_rtiadocdt LIKE rtia_t.rtiadocdt,
      b_rtiadocno LIKE rtia_t.rtiadocno,
      b_rtia002 LIKE rtia_t.rtia002,
   b_rtia002_desc LIKE type_t.chr80,
      b_rtia006 LIKE rtia_t.rtia006
       END RECORD
       
#add-point:自定義模組變數(Module Variable) (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="global.variable"
DEFINE g_type   LIKE type_t.chr5
DEFINE g_errno  LIKE type_t.chr50
define g_barcode like rtib_t.rtib003
define g_chantype like rtib_t.rtib035
DEFINE g_rate   LIKE ooan_t.ooan005  
DEFINE g_sign   LIKE type_t.chr1
DEFINE g_site_flag   LIKE type_t.num5
#end add-point
       
#模組變數(Module Variables)
DEFINE g_rtia_m          type_g_rtia_m
DEFINE g_rtia_m_t        type_g_rtia_m
DEFINE g_rtia_m_o        type_g_rtia_m
DEFINE g_rtia_m_mask_o   type_g_rtia_m #轉換遮罩前資料
DEFINE g_rtia_m_mask_n   type_g_rtia_m #轉換遮罩後資料
 
   DEFINE g_rtiadocno_t LIKE rtia_t.rtiadocno
 
 
DEFINE g_rtib_d          DYNAMIC ARRAY OF type_g_rtib_d
DEFINE g_rtib_d_t        type_g_rtib_d
DEFINE g_rtib_d_o        type_g_rtib_d
DEFINE g_rtib_d_mask_o   DYNAMIC ARRAY OF type_g_rtib_d #轉換遮罩前資料
DEFINE g_rtib_d_mask_n   DYNAMIC ARRAY OF type_g_rtib_d #轉換遮罩後資料
DEFINE g_rtib2_d          DYNAMIC ARRAY OF type_g_rtib2_d
DEFINE g_rtib2_d_t        type_g_rtib2_d
DEFINE g_rtib2_d_o        type_g_rtib2_d
DEFINE g_rtib2_d_mask_o   DYNAMIC ARRAY OF type_g_rtib2_d #轉換遮罩前資料
DEFINE g_rtib2_d_mask_n   DYNAMIC ARRAY OF type_g_rtib2_d #轉換遮罩後資料
DEFINE g_rtib3_d          DYNAMIC ARRAY OF type_g_rtib3_d
DEFINE g_rtib3_d_t        type_g_rtib3_d
DEFINE g_rtib3_d_o        type_g_rtib3_d
DEFINE g_rtib3_d_mask_o   DYNAMIC ARRAY OF type_g_rtib3_d #轉換遮罩前資料
DEFINE g_rtib3_d_mask_n   DYNAMIC ARRAY OF type_g_rtib3_d #轉換遮罩後資料
DEFINE g_rtib4_d          DYNAMIC ARRAY OF type_g_rtib4_d
DEFINE g_rtib4_d_t        type_g_rtib4_d
DEFINE g_rtib4_d_o        type_g_rtib4_d
DEFINE g_rtib4_d_mask_o   DYNAMIC ARRAY OF type_g_rtib4_d #轉換遮罩前資料
DEFINE g_rtib4_d_mask_n   DYNAMIC ARRAY OF type_g_rtib4_d #轉換遮罩後資料
DEFINE g_rtib5_d          DYNAMIC ARRAY OF type_g_rtib5_d
DEFINE g_rtib5_d_t        type_g_rtib5_d
DEFINE g_rtib5_d_o        type_g_rtib5_d
DEFINE g_rtib5_d_mask_o   DYNAMIC ARRAY OF type_g_rtib5_d #轉換遮罩前資料
DEFINE g_rtib5_d_mask_n   DYNAMIC ARRAY OF type_g_rtib5_d #轉換遮罩後資料
DEFINE g_rtib6_d          DYNAMIC ARRAY OF type_g_rtib6_d
DEFINE g_rtib6_d_t        type_g_rtib6_d
DEFINE g_rtib6_d_o        type_g_rtib6_d
DEFINE g_rtib6_d_mask_o   DYNAMIC ARRAY OF type_g_rtib6_d #轉換遮罩前資料
DEFINE g_rtib6_d_mask_n   DYNAMIC ARRAY OF type_g_rtib6_d #轉換遮罩後資料
DEFINE g_rtib7_d          DYNAMIC ARRAY OF type_g_rtib7_d
DEFINE g_rtib7_d_t        type_g_rtib7_d
DEFINE g_rtib7_d_o        type_g_rtib7_d
DEFINE g_rtib7_d_mask_o   DYNAMIC ARRAY OF type_g_rtib7_d #轉換遮罩前資料
DEFINE g_rtib7_d_mask_n   DYNAMIC ARRAY OF type_g_rtib7_d #轉換遮罩後資料
 
 
DEFINE g_browser         DYNAMIC ARRAY OF type_browser
DEFINE g_browser_f       DYNAMIC ARRAY OF type_browser
 
 
DEFINE g_wc                  STRING
DEFINE g_wc_t                STRING
DEFINE g_wc2                 STRING                          #單身CONSTRUCT結果
DEFINE g_wc2_table1          STRING
DEFINE g_wc2_table2   STRING
 
DEFINE g_wc2_table3   STRING
 
DEFINE g_wc2_table4   STRING
 
DEFINE g_wc2_table5   STRING
 
DEFINE g_wc2_table6   STRING
 
DEFINE g_wc2_table7   STRING
 
 
 
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
 
{<section id="artt622.main" >}
#應用 a26 樣板自動產生(Version:7)
#+ 作業開始(主程式類型)
MAIN
   #add-point:main段define(客製用) name="main.define_customerization"
   
   #end add-point   
   #add-point:main段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="main.define"
   DEFINE l_success LIKE type_t.num5      #150308-00001#5  By benson 150309
   #end add-point   
   
   OPTIONS
   INPUT NO WRAP
   DEFER INTERRUPT
   
   #設定SQL錯誤記錄方式 (模組內定義有效)
   WHENEVER ERROR CALL cl_err_msg_log
       
   #依模組進行系統初始化設定(系統設定)
   CALL cl_ap_init("art","")
 
   #add-point:作業初始化 name="main.init"
         LET g_sign = 't'
   #end add-point
   
   
 
   #LOCK CURSOR (identifier)
   #add-point:SQL_define name="main.define_sql"
      
   #end add-point
   LET g_forupd_sql = " SELECT rtiasite,'',rtiadocdt,rtiadocno,rtia002,'',rtia001,'',rtia059,rtia060, 
       '','',rtia004,'',rtia005,'',rtia006,'',rtia053,rtiastus,rtia007,rtia008,rtia009,'',rtia043,rtia047, 
       '',rtia013,rtia014,rtia015,rtia016,rtia051,rtia010,'',rtia011,'',rtia012,'','','',rtia041,rtia017, 
       rtia018,'',rtia019,rtia020,rtia021,rtia022,rtia023,rtia024,'',rtia025,'',rtia026,rtia027,rtia028, 
       rtia029,rtia030,rtia032,rtia033,rtia034,rtia035,rtia036,'',rtia037,'',rtia038,'',rtia039,rtia107, 
       '','','','','','','','',rtiaownid,'',rtiacrtid,'',rtiaowndp,'',rtiacrtdp,'',rtiacrtdt,rtiamodid, 
       '',rtiamoddt,rtiacnfid,'',rtiacnfdt,rtiapstid,'',rtiapstdt,'','','',''", 
                      " FROM rtia_t",
                      " WHERE rtiaent= ? AND rtiadocno=? FOR UPDATE"
   #add-point:SQL_define name="main.after_define_sql"
   LET g_forupd_sql = "SELECT rtiasite,'',rtiadocdt,rtiadocno,rtia001,'',rtia002,'',rtia004,'',rtia005, 
       '',rtia006,rtia048,rtiastus,rtia007,rtia008,rtia009,'',rtia041,rtia013,rtia014,rtia015,rtia016,rtia010, 
       '',rtia011,'',rtia012,'',rtia017,rtia018,'',rtia019,rtia020,rtia021,rtia022,rtia023,rtia024,'', 
       rtia025,'',rtia026,rtia027,rtia028,rtia029,rtia030,rtia032,rtia033,rtia034,rtia035,rtia036,'', 
       rtia037,'',rtia038,'',rtia039,'','','','','','','','',rtiaownid,'',rtiaowndp,'',rtiacrtid,'', 
       rtiacrtdp,'',rtiacrtdt,rtiamodid,'',rtiamoddt,rtiacnfid,'',rtiacnfdt,rtiapstid,'',rtiapstdt,'', 
       '','','' FROM rtia_t WHERE rtiaent= ? AND rtiadocno=? FOR UPDATE"
   LET g_type = g_argv[1]
   IF g_type = '1' THEN 
      LET g_prog = 'artt610'
   END IF 
   #add by yangxf ---start---
   IF g_type = '2' THEN 
      LET g_prog = 'artt700'
   END IF 
   IF g_type = '3' THEN 
      LET g_prog = 'artt800'
   END IF 
   IF g_type = '0' THEN 
      LET g_prog = 'artt622'
   END IF 
   #add by yangxf ----end----
   #add by yangxf 20151127 ---start---
   IF g_type = '4' THEN 
      LET g_prog = 'artt620'
   END IF 
   #add by yangxf 20151127----ned-----
   #150429-00007#9--dongsz add--str
   IF g_type = '5' THEN 
      LET g_prog = 'aprt280'
   END IF 
   #150429-00007#7--dongsz add--end
   #end add-point
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)                #轉換不同資料庫語法
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE artt622_cl CURSOR FROM g_forupd_sql                 # LOCK CURSOR
 
   LET g_sql = " SELECT DISTINCT t0.rtiasite,t0.rtiadocdt,t0.rtiadocno,t0.rtia002,t0.rtia001,t0.rtia059, 
       t0.rtia060,t0.rtia004,t0.rtia005,t0.rtia006,t0.rtia048,t0.rtia053,t0.rtiastus,t0.rtia007,t0.rtia008, 
       t0.rtia009,t0.rtia043,t0.rtia047,t0.rtia013,t0.rtia014,t0.rtia015,t0.rtia016,t0.rtia051,t0.rtia010, 
       t0.rtia011,t0.rtia012,t0.rtia041,t0.rtia017,t0.rtia018,t0.rtia019,t0.rtia020,t0.rtia021,t0.rtia022, 
       t0.rtia023,t0.rtia024,t0.rtia025,t0.rtia026,t0.rtia027,t0.rtia028,t0.rtia029,t0.rtia030,t0.rtia032, 
       t0.rtia033,t0.rtia034,t0.rtia035,t0.rtia036,t0.rtia037,t0.rtia038,t0.rtia039,t0.rtia107,t0.rtiaownid, 
       t0.rtiacrtid,t0.rtiaowndp,t0.rtiacrtdp,t0.rtiacrtdt,t0.rtiamodid,t0.rtiamoddt,t0.rtiacnfid,t0.rtiacnfdt, 
       t0.rtiapstid,t0.rtiapstdt,t1.ooefl003 ,t2.pmaal004 ,t3.ooag011 ,t4.ooefl003 ,t5.oocql004 ,t6.pmaal004 , 
       t7.pmaal004 ,t8.pmaal004 ,t9.ooefl003 ,t10.ooefl003 ,t11.ooibl004 ,t12.pcaal003 ,t13.pcab003 , 
       t14.oogd002 ,t15.ooag011 ,t16.ooag011 ,t17.ooefl003 ,t18.ooefl003 ,t19.ooag011 ,t20.ooag011 , 
       t21.ooag011",
               " FROM rtia_t t0",
                              " LEFT JOIN ooefl_t t1 ON t1.ooeflent="||g_enterprise||" AND t1.ooefl001=t0.rtiasite AND t1.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN pmaal_t t2 ON t2.pmaalent="||g_enterprise||" AND t2.pmaal001=t0.rtia002 AND t2.pmaal002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t3 ON t3.ooagent="||g_enterprise||" AND t3.ooag001=t0.rtia004  ",
               " LEFT JOIN ooefl_t t4 ON t4.ooeflent="||g_enterprise||" AND t4.ooefl001=t0.rtia005 AND t4.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN oocql_t t5 ON t5.oocqlent="||g_enterprise||" AND t5.oocql001='295' AND t5.oocql002=t0.rtia009 AND t5.oocql003='"||g_dlang||"' ",
               " LEFT JOIN pmaal_t t6 ON t6.pmaalent="||g_enterprise||" AND t6.pmaal001=t0.rtia010 AND t6.pmaal002='"||g_dlang||"' ",
               " LEFT JOIN pmaal_t t7 ON t7.pmaalent="||g_enterprise||" AND t7.pmaal001=t0.rtia011 AND t7.pmaal002='"||g_dlang||"' ",
               " LEFT JOIN pmaal_t t8 ON t8.pmaalent="||g_enterprise||" AND t8.pmaal001=t0.rtia012 AND t8.pmaal002='"||g_dlang||"' ",
               " LEFT JOIN ooefl_t t9 ON t9.ooeflent="||g_enterprise||" AND t9.ooefl001=t0.rtia018 AND t9.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooefl_t t10 ON t10.ooeflent="||g_enterprise||" AND t10.ooefl001=t0.rtia024 AND t10.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooibl_t t11 ON t11.ooiblent="||g_enterprise||" AND t11.ooibl002=t0.rtia025 AND t11.ooibl003='"||g_dlang||"' ",
               " LEFT JOIN pcaal_t t12 ON t12.pcaalent="||g_enterprise||" AND t12.pcaalsite=t0.rtiasite AND t12.pcaal001=t0.rtia036 AND t12.pcaal002='"||g_dlang||"' ",
               " LEFT JOIN pcab_t t13 ON t13.pcabent="||g_enterprise||" AND t13.pcab001=t0.rtia037  ",
               " LEFT JOIN oogd_t t14 ON t14.oogdent="||g_enterprise||" AND t14.oogd001=t0.rtia038 AND t14.oogdsite=t0.rtiasite  ",
               " LEFT JOIN ooag_t t15 ON t15.ooagent="||g_enterprise||" AND t15.ooag001=t0.rtiaownid  ",
               " LEFT JOIN ooag_t t16 ON t16.ooagent="||g_enterprise||" AND t16.ooag001=t0.rtiacrtid  ",
               " LEFT JOIN ooefl_t t17 ON t17.ooeflent="||g_enterprise||" AND t17.ooefl001=t0.rtiaowndp AND t17.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooefl_t t18 ON t18.ooeflent="||g_enterprise||" AND t18.ooefl001=t0.rtiacrtdp AND t18.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t19 ON t19.ooagent="||g_enterprise||" AND t19.ooag001=t0.rtiamodid  ",
               " LEFT JOIN ooag_t t20 ON t20.ooagent="||g_enterprise||" AND t20.ooag001=t0.rtiacnfid  ",
               " LEFT JOIN ooag_t t21 ON t21.ooagent="||g_enterprise||" AND t21.ooag001=t0.rtiapstid  ",
 
               " WHERE t0.rtiaent = " ||g_enterprise|| " AND t0.rtiadocno = ?"
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   #add-point:SQL_define name="main.after_refresh_sql"
   
   #end add-point
   PREPARE artt622_master_referesh FROM g_sql
 
    
 
   
   IF g_bgjob = "Y" THEN
      #add-point:Service Call name="main.servicecall"
            
      #end add-point
   ELSE
      #畫面開啟 (identifier)
      OPEN WINDOW w_artt622 WITH FORM cl_ap_formpath("art",g_code)
   
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
   
      #程式初始化
      CALL artt622_init()   
 
      #進入選單 Menu (="N")
      CALL artt622_ui_dialog() 
      
      #add-point:畫面關閉前 name="main.before_close"
      ##150427-00001#9 150603 By pomelo add(S)
      IF g_prog = 'artt600' OR g_prog = 'artt610' THEN
         CALL s_lot_auto_drop_tmp(g_prog)
         CALL s_aooi390_drop_tmp_table()
      END IF
      #add by yangxf 20151127 ---start---
      IF g_prog = 'artt622' THEN
         CALL s_lot_auto_drop_tmp('artt610')
         CALL s_aooi390_drop_tmp_table()
      END IF 
      #add by yangxf 20151127 ---end---
      #150429-00007#9--dongsz add--s
      IF g_prog = 'aprt280' THEN
         CALL s_lot_auto_drop_tmp('artt610')
         CALL s_aooi390_drop_tmp_table()
      END IF
      #150429-00007#9--dongsz add--e
      ##150427-00001#9 150603 By pomelo add(E)
      #end add-point
 
      #畫面關閉
      CLOSE WINDOW w_artt622
      
   END IF 
   
   CLOSE artt622_cl
   
   
 
   #add-point:作業離開前 name="main.exit"
   CALL s_aooi500_drop_temp() RETURNING l_success      #150308-00001#5  By benson 150309
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
END MAIN
 
 
 
 
{</section>}
 
{<section id="artt622.init" >}
#+ 瀏覽頁簽資料初始化
PRIVATE FUNCTION artt622_init()
   #add-point:init段define(客製用) name="init.define_customerization"
   
   #end add-point    
   #add-point:init段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="init.define"
   DEFINE l_success LIKE type_t.num5      #150308-00001#5  By benson 150309
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
   LET g_detail_idx_list[4] = 1
   LET g_detail_idx_list[5] = 1
   LET g_detail_idx_list[6] = 1
   LET g_detail_idx_list[7] = 1
 
   LET g_error_show  = 1
   LET l_ac = 1 #單身指標
      CALL cl_set_combo_scc_part('rtiastus','13','N,Y,S,Z,A,D,R,W,X')
 
      CALL cl_set_combo_scc('mmaf003','6501') 
   CALL cl_set_combo_scc('rtia017','6545') 
   CALL cl_set_combo_scc('rtia023','6546') 
   CALL cl_set_combo_scc('rtia032','6544') 
   CALL cl_set_combo_scc('rtia039','6202') 
   CALL cl_set_combo_scc('rtib035','6819') 
   CALL cl_set_combo_scc('rtib042','6944') 
   CALL cl_set_combo_scc('rtic001','6707') 
   CALL cl_set_combo_scc('rtic002','6708') 
   CALL cl_set_combo_scc('rtic006','6564') 
   CALL cl_set_combo_scc('rtic007','6565') 
   CALL cl_set_combo_scc('rtie001','8310') 
 
   LET gwin_curr = ui.Window.getCurrent()  #取得現行畫面
   LET gfrm_curr = gwin_curr.getForm()     #取出物件化後的畫面物件
   
   #page群組
   LET g_idx_group = om.SaxAttributes.create()
   CALL g_idx_group.addAttribute("'1',","1")
   CALL g_idx_group.addAttribute("'2',","1")
   CALL g_idx_group.addAttribute("'3',","1")
   CALL g_idx_group.addAttribute("'4',","1")
   CALL g_idx_group.addAttribute("'5',","1")
   CALL g_idx_group.addAttribute("'6',","1")
   CALL g_idx_group.addAttribute("'7',","1")
 
 
   #add-point:畫面資料初始化 name="init.init"
   CALL cl_set_combo_scc('rtib035','6819')
   CALL cl_set_combo_scc('isaf202','')
   CALL cl_set_combo_scc('isaf207','')
   CALL cl_set_combo_scc('chantype','6819')
   CALL cl_set_act_visible("delete", FALSE)
   
   CALL cl_set_combo_scc_part('rtia032','6544','1,3,4')    #150630-00005#1 150630 by lori add
   
  #IF g_prog = 'artt610' THEN                           #mark by yangxf 20151127
   IF g_prog = 'artt610' OR g_prog = 'artt620' THEN     #add by yangxf 20151127
      CALL cl_set_comp_visible("rtia009,rtia010,rtia011,rtia012,
      rtib004_desc_desc,rtib030,rtia010_desc,rtia011_desc,rtia012_desc",FALSE)
      CALL cl_set_comp_visible("rtib014",FALSE)
   END IF 
   IF g_prog = 'artt600' THEN 
      CALL cl_set_comp_entry("rtib004",FALSE)
      CALL cl_set_comp_visible("rtib035",FALSE)
      #CALL cl_set_comp_required("rtia007",TRUE)
      CALL cl_set_comp_visible("rtib014",FALSE)    #20150707-mark by dongsz
   END IF 
   IF g_prog = 'artt700' THEN 
      CALL cl_set_comp_visible("rtib035",FALSE)
      CALL cl_set_comp_visible("rtib014",FALSE)    #20150707-mark by dongsz
   END IF 
   CALL cl_set_comp_visible("page_11,page_12,page_13",FALSE)
   CALL s_aooi500_create_temp() RETURNING l_success    #150308-00001#5  By benson 150309
   ##150427-00001#9 150603 By pomelo add(S)
   IF g_prog = 'artt600' OR g_prog = 'artt610' THEN
      LET l_success = ''
      CALL s_lot_auto_create_tmp(g_prog) RETURNING l_success
      LET l_success = ''
      CALL s_aooi390_cre_tmp_table() RETURNING l_success
      CALL cl_set_toolbaritem_visible("artt622_discount",TRUE)
   ELSE
      CALL cl_set_toolbaritem_visible("artt622_discount",FALSE) 
   END IF
   ##150427-00001#9 150603 By pomelo add(E)
   #add by yangxf ---start---
   IF g_prog = 'artt800' THEN 
      CALL cl_set_comp_required("rtia007",TRUE)
      CALL cl_set_comp_visible("rtia051",TRUE)
      CALL cl_set_comp_visible("rtib014",FALSE)    #20150707-mark by dongsz
   ELSE
      CALL cl_set_comp_visible("rtia051",FALSE)
   END IF
   
   #add by yangxf ---end----
   #add by yangxf 20151127 ---start---
   IF g_prog = 'artt622' THEN
      CALL s_lot_auto_create_tmp('artt610') RETURNING l_success
      LET l_success = ''
      CALL s_aooi390_cre_tmp_table() RETURNING l_success
      CALL cl_set_comp_visible("inag008",TRUE)
   ELSE
      CALL cl_set_comp_visible("inag008",FALSE)
   END IF 
   IF NOT g_prog = 'artt620' THEN
      CALL cl_set_comp_visible("rtia053",FALSE) 
      CALL cl_set_toolbaritem_visible("pay_money",FALSE) 
   END IF
   #add by yangxf 20151127----ned-----
   #150429-00007#9--dongsz add--str
   IF g_prog = 'aprt280' THEN
      CALL s_lot_auto_create_tmp('artt610') RETURNING l_success
      LET l_success = ''
      CALL s_aooi390_cre_tmp_table() RETURNING l_success
      CALL cl_set_comp_visible("rtia002",FALSE)
      CALL cl_set_comp_visible("master_Folder_page,page_3,page_4,page_5,page_2,page_9",FALSE)
   ELSE
     #CALL cl_set_comp_visible("rtia059,rtia060",FALSE)
      CALL cl_set_comp_visible("bpage_2",FALSE)
      CALL cl_set_toolbaritem_visible("sel_gift",FALSE) 
   END IF
   #150429-00007#9--dongsz add--end
   #end add-point
   
   #初始化搜尋條件
   CALL artt622_default_search()
    
END FUNCTION
 
{</section>}
 
{<section id="artt622.ui_dialog" >}
#+ 功能選單
PRIVATE FUNCTION artt622_ui_dialog()
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
   DEFINE l_success      LIKE type_t.num5
   DEFINE l_rtia031      LIKE rtia_t.rtia031
   DEFINE l_ooib007      LIKE ooib_t.ooib007
   DEFINE l_rtia051      LIKE rtia_t.rtia051
   #add by geza 20160318(S)
   DEFINE l_cnt          LIKE type_t.num5
   DEFINE l_rtia053      LIKE rtia_t.rtia053
   #add by geza 20160318(E)
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
            CALL artt622_insert()
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
         INITIALIZE g_rtia_m.* TO NULL
         CALL g_rtib_d.clear()
         CALL g_rtib2_d.clear()
         CALL g_rtib3_d.clear()
         CALL g_rtib4_d.clear()
         CALL g_rtib5_d.clear()
         CALL g_rtib6_d.clear()
         CALL g_rtib7_d.clear()
 
         LET g_wc  = ' 1=2'
         LET g_wc2 = ' 1=1'
         LET g_action_choice = ""
         CALL artt622_init()
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
               
               CALL artt622_fetch('') # reload data
               LET l_ac = 1
               CALL artt622_ui_detailshow() #Setting the current row 
         
               CALL artt622_idx_chk()
               #NEXT FIELD rtibseq
         
               ON ACTION qbefield_user   #欄位隱藏設定 
                  LET g_action_choice="qbefield_user"
                  CALL cl_ui_qbefield_user()
         END DISPLAY
    
         DISPLAY ARRAY g_rtib_d TO s_detail1.* ATTRIBUTES(COUNT=g_rec_b) #page1  
    
            BEFORE ROW
               #顯示單身筆數
               CALL artt622_idx_chk()
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
               CALL artt622_idx_chk()
               #add-point:page1自定義行為 name="ui_dialog.page1.before_display"
                              
               #end add-point
               
            #自訂ACTION(detail_show,page_1)
            
               
            #add-point:page1自定義行為 name="ui_dialog.page1.action"
                        
            #end add-point
               
         END DISPLAY
        
         #第一階單身段落
         DISPLAY ARRAY g_rtib2_d TO s_detail2.* ATTRIBUTES(COUNT=g_rec_b)  
    
            BEFORE ROW
               #顯示單身筆數
               CALL artt622_idx_chk()
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
               CALL artt622_idx_chk()
               #add-point:page2自定義行為 name="ui_dialog.body2.before_display"
                              
               #end add-point
      
            #自訂ACTION(detail_show,page_2)
            
         
            #add-point:page2自定義行為 name="ui_dialog.body2.action"
                        
            #end add-point
         
         END DISPLAY
         #第一階單身段落
         DISPLAY ARRAY g_rtib3_d TO s_detail3.* ATTRIBUTES(COUNT=g_rec_b)  
    
            BEFORE ROW
               #顯示單身筆數
               CALL artt622_idx_chk()
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
               CALL artt622_idx_chk()
               #add-point:page3自定義行為 name="ui_dialog.body3.before_display"
                              
               #end add-point
      
            #自訂ACTION(detail_show,page_3)
            
         
            #add-point:page3自定義行為 name="ui_dialog.body3.action"
                        
            #end add-point
         
         END DISPLAY
         #第一階單身段落
         DISPLAY ARRAY g_rtib4_d TO s_detail4.* ATTRIBUTES(COUNT=g_rec_b)  
    
            BEFORE ROW
               #顯示單身筆數
               CALL artt622_idx_chk()
               LET l_ac = DIALOG.getCurrentRow("s_detail4")
               LET g_detail_idx = l_ac
               LET g_detail_idx_list[4] = l_ac
               CALL g_idx_group.addAttribute("'4',",l_ac)
               
               #add-point:page4, before row動作 name="ui_dialog.body4.before_row"
                              
               #end add-point
               
            BEFORE DISPLAY
               #如果一直都在單身1則控制筆數位置
               IF g_loc = 'm' THEN
                  CALL FGL_SET_ARR_CURR(g_idx_group.getValue("'4',"))
               END IF
               LET g_loc = 'm'
               LET l_ac = DIALOG.getCurrentRow("s_detail4")
               LET g_current_page = 4
               #顯示單身筆數
               CALL artt622_idx_chk()
               #add-point:page4自定義行為 name="ui_dialog.body4.before_display"
                              
               #end add-point
      
            #自訂ACTION(detail_show,page_4)
            
         
            #add-point:page4自定義行為 name="ui_dialog.body4.action"
                        
            #end add-point
         
         END DISPLAY
         #第一階單身段落
         DISPLAY ARRAY g_rtib5_d TO s_detail5.* ATTRIBUTES(COUNT=g_rec_b)  
    
            BEFORE ROW
               #顯示單身筆數
               CALL artt622_idx_chk()
               LET l_ac = DIALOG.getCurrentRow("s_detail5")
               LET g_detail_idx = l_ac
               LET g_detail_idx_list[5] = l_ac
               CALL g_idx_group.addAttribute("'5',",l_ac)
               
               #add-point:page5, before row動作 name="ui_dialog.body5.before_row"
                              
               #end add-point
               
            BEFORE DISPLAY
               #如果一直都在單身1則控制筆數位置
               IF g_loc = 'm' THEN
                  CALL FGL_SET_ARR_CURR(g_idx_group.getValue("'5',"))
               END IF
               LET g_loc = 'm'
               LET l_ac = DIALOG.getCurrentRow("s_detail5")
               LET g_current_page = 5
               #顯示單身筆數
               CALL artt622_idx_chk()
               #add-point:page5自定義行為 name="ui_dialog.body5.before_display"
                              
               #end add-point
      
            #自訂ACTION(detail_show,page_5)
            
         
            #add-point:page5自定義行為 name="ui_dialog.body5.action"
                        
            #end add-point
         
         END DISPLAY
         #第一階單身段落
         DISPLAY ARRAY g_rtib6_d TO s_detail6.* ATTRIBUTES(COUNT=g_rec_b)  
    
            BEFORE ROW
               #顯示單身筆數
               CALL artt622_idx_chk()
               LET l_ac = DIALOG.getCurrentRow("s_detail6")
               LET g_detail_idx = l_ac
               LET g_detail_idx_list[6] = l_ac
               CALL g_idx_group.addAttribute("'6',",l_ac)
               
               #add-point:page6, before row動作 name="ui_dialog.body6.before_row"
                              
               #end add-point
               
            BEFORE DISPLAY
               #如果一直都在單身1則控制筆數位置
               IF g_loc = 'm' THEN
                  CALL FGL_SET_ARR_CURR(g_idx_group.getValue("'6',"))
               END IF
               LET g_loc = 'm'
               LET l_ac = DIALOG.getCurrentRow("s_detail6")
               LET g_current_page = 6
               #顯示單身筆數
               CALL artt622_idx_chk()
               #add-point:page6自定義行為 name="ui_dialog.body6.before_display"
                              
               #end add-point
      
            #自訂ACTION(detail_show,page_6)
            
         
            #add-point:page6自定義行為 name="ui_dialog.body6.action"
                        
            #end add-point
         
         END DISPLAY
         #第一階單身段落
         DISPLAY ARRAY g_rtib7_d TO s_detail7.* ATTRIBUTES(COUNT=g_rec_b)  
    
            BEFORE ROW
               #顯示單身筆數
               CALL artt622_idx_chk()
               LET l_ac = DIALOG.getCurrentRow("s_detail7")
               LET g_detail_idx = l_ac
               LET g_detail_idx_list[7] = l_ac
               CALL g_idx_group.addAttribute("'7',",l_ac)
               
               #add-point:page7, before row動作 name="ui_dialog.body7.before_row"
                              
               #end add-point
               
            BEFORE DISPLAY
               #如果一直都在單身1則控制筆數位置
               IF g_loc = 'm' THEN
                  CALL FGL_SET_ARR_CURR(g_idx_group.getValue("'7',"))
               END IF
               LET g_loc = 'm'
               LET l_ac = DIALOG.getCurrentRow("s_detail7")
               LET g_current_page = 7
               #顯示單身筆數
               CALL artt622_idx_chk()
               #add-point:page7自定義行為 name="ui_dialog.body7.before_display"
                              
               #end add-point
      
            #自訂ACTION(detail_show,page_7)
            
         
            #add-point:page7自定義行為 name="ui_dialog.body7.action"
                        
            #end add-point
         
         END DISPLAY
 
         
 
         
         #add-point:ui_dialog段自定義display array name="ui_dialog.more_displayarray"
                  
         #end add-point
         
         SUBDIALOG lib_cl_dlg.cl_dlg_qryplan
         SUBDIALOG lib_cl_dlg.cl_dlg_relateapps
      
         BEFORE DIALOG
            #先填充browser資料
            CALL artt622_browser_fill("")
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
               CALL artt622_fetch('') # reload data
            END IF
            #LET g_detail_idx = 1
            CALL artt622_ui_detailshow() #Setting the current row 
            
            #筆數顯示
            LET g_current_page = 1
            CALL artt622_idx_chk()
            CALL cl_ap_performance_cal()
            #add-point:ui_dialog段before_dialog2 name="ui_dialog.before_dialog2"
 
            #end add-point
 
         #add-point:ui_dialog段more_action name="ui_dialog.more_action"
         
         #end add-point
 
         #狀態碼切換
         ON ACTION statechange
            LET g_action_choice = "statechange"
            CALL artt622_statechange()
            #根據資料狀態切換action狀態
            CALL cl_set_act_visible("statechange,modify,modify_detail,delete,reproduce", TRUE)
            CALL artt622_set_act_visible()   
            CALL artt622_set_act_no_visible()
            IF NOT (g_rtia_m.rtiadocno IS NULL
 
              ) THEN
               #組合條件
               LET g_add_browse = " rtiaent = " ||g_enterprise|| " AND",
                                  " rtiadocno = '", g_rtia_m.rtiadocno, "' "
 
               #填到對應位置
               CALL artt622_browser_fill("")
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
 
               INITIALIZE g_wc2_table4 TO NULL
 
               INITIALIZE g_wc2_table5 TO NULL
 
               INITIALIZE g_wc2_table6 TO NULL
 
               INITIALIZE g_wc2_table7 TO NULL
 
 
               FOR li_idx = 1 TO la_wc.getLength()
                  CASE
                     WHEN la_wc[li_idx].tableid = "rtia_t" 
                        LET g_wc = la_wc[li_idx].wc
                     WHEN la_wc[li_idx].tableid = "rtib_t" 
                        LET g_wc2_table1 = la_wc[li_idx].wc
                     WHEN la_wc[li_idx].tableid = "rtic_t" 
                        LET g_wc2_table2 = la_wc[li_idx].wc
 
                     WHEN la_wc[li_idx].tableid = "xrcd_t" 
                        LET g_wc2_table3 = la_wc[li_idx].wc
 
                     WHEN la_wc[li_idx].tableid = "rtie_t" 
                        LET g_wc2_table4 = la_wc[li_idx].wc
 
                     WHEN la_wc[li_idx].tableid = "rtik_t" 
                        LET g_wc2_table5 = la_wc[li_idx].wc
 
                     WHEN la_wc[li_idx].tableid = "rtin_t" 
                        LET g_wc2_table6 = la_wc[li_idx].wc
 
                     WHEN la_wc[li_idx].tableid = "prek_t" 
                        LET g_wc2_table7 = la_wc[li_idx].wc
 
 
                     WHEN la_wc[li_idx].tableid = "EXTENDWC"
                        LET g_wc2_extend = la_wc[li_idx].wc
                  END CASE
               END FOR
               IF NOT cl_null(g_wc) OR NOT cl_null(g_wc2_table1) 
                  OR NOT cl_null(g_wc2_table2)
 
                  OR NOT cl_null(g_wc2_table3)
 
                  OR NOT cl_null(g_wc2_table4)
 
                  OR NOT cl_null(g_wc2_table5)
 
                  OR NOT cl_null(g_wc2_table6)
 
                  OR NOT cl_null(g_wc2_table7)
 
 
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
 
                  IF g_wc2_table4 <> " 1=1" AND NOT cl_null(g_wc2_table4) THEN
                     LET g_wc2 = g_wc2 ," AND ", g_wc2_table4
                  END IF
 
                  IF g_wc2_table5 <> " 1=1" AND NOT cl_null(g_wc2_table5) THEN
                     LET g_wc2 = g_wc2 ," AND ", g_wc2_table5
                  END IF
 
                  IF g_wc2_table6 <> " 1=1" AND NOT cl_null(g_wc2_table6) THEN
                     LET g_wc2 = g_wc2 ," AND ", g_wc2_table6
                  END IF
 
                  IF g_wc2_table7 <> " 1=1" AND NOT cl_null(g_wc2_table7) THEN
                     LET g_wc2 = g_wc2 ," AND ", g_wc2_table7
                  END IF
 
 
                  IF g_wc2_extend <> " 1=1" AND NOT cl_null(g_wc2_extend) THEN
                     LET g_wc2 = g_wc2 ," AND ", g_wc2_extend
                  END IF
 
                  IF g_wc2.subString(1,5) = " AND " THEN
                     LET g_wc2 = g_wc2.subString(6,g_wc2.getLength())
                  END IF
               END IF
               CALL artt622_browser_fill("F")   #browser_fill()會將notice區塊清空
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
 
               INITIALIZE g_wc2_table4 TO NULL
 
               INITIALIZE g_wc2_table5 TO NULL
 
               INITIALIZE g_wc2_table6 TO NULL
 
               INITIALIZE g_wc2_table7 TO NULL
 
 
               FOR li_idx = 1 TO la_wc.getLength()
                  CASE
                     WHEN la_wc[li_idx].tableid = "rtia_t" 
                        LET g_wc = la_wc[li_idx].wc
                     WHEN la_wc[li_idx].tableid = "rtib_t" 
                        LET g_wc2_table1 = la_wc[li_idx].wc
                     WHEN la_wc[li_idx].tableid = "rtic_t" 
                        LET g_wc2_table2 = la_wc[li_idx].wc
 
                     WHEN la_wc[li_idx].tableid = "xrcd_t" 
                        LET g_wc2_table3 = la_wc[li_idx].wc
 
                     WHEN la_wc[li_idx].tableid = "rtie_t" 
                        LET g_wc2_table4 = la_wc[li_idx].wc
 
                     WHEN la_wc[li_idx].tableid = "rtik_t" 
                        LET g_wc2_table5 = la_wc[li_idx].wc
 
                     WHEN la_wc[li_idx].tableid = "rtin_t" 
                        LET g_wc2_table6 = la_wc[li_idx].wc
 
                     WHEN la_wc[li_idx].tableid = "prek_t" 
                        LET g_wc2_table7 = la_wc[li_idx].wc
 
 
                     WHEN la_wc[li_idx].tableid = "EXTENDWC"
                        LET g_wc2_extend = la_wc[li_idx].wc
                  END CASE
               END FOR
               IF NOT cl_null(g_wc) OR NOT cl_null(g_wc2_table1)
                  OR NOT cl_null(g_wc2_table2)
 
                  OR NOT cl_null(g_wc2_table3)
 
                  OR NOT cl_null(g_wc2_table4)
 
                  OR NOT cl_null(g_wc2_table5)
 
                  OR NOT cl_null(g_wc2_table6)
 
                  OR NOT cl_null(g_wc2_table7)
 
 
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
 
                  IF g_wc2_table4 <> " 1=1" AND NOT cl_null(g_wc2_table4) THEN
                     LET g_wc2 = g_wc2 ," AND ", g_wc2_table4
                  END IF
 
                  IF g_wc2_table5 <> " 1=1" AND NOT cl_null(g_wc2_table5) THEN
                     LET g_wc2 = g_wc2 ," AND ", g_wc2_table5
                  END IF
 
                  IF g_wc2_table6 <> " 1=1" AND NOT cl_null(g_wc2_table6) THEN
                     LET g_wc2 = g_wc2 ," AND ", g_wc2_table6
                  END IF
 
                  IF g_wc2_table7 <> " 1=1" AND NOT cl_null(g_wc2_table7) THEN
                     LET g_wc2 = g_wc2 ," AND ", g_wc2_table7
                  END IF
 
 
                  IF g_wc2_extend <> " 1=1" AND NOT cl_null(g_wc2_extend) THEN
                     LET g_wc2 = g_wc2 ," AND ", g_wc2_extend
                  END IF
                  IF g_wc2.subString(1,5) = " AND " THEN
                     LET g_wc2 = g_wc2.subString(6,g_wc2.getLength())
                  END IF
                  #取得條件後需要重查、跳到結果第一筆資料的功能程式段
                  CALL artt622_browser_fill("F")
                  IF g_browser_cnt = 0 THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "" 
                     LET g_errparam.code = "-100" 
                     LET g_errparam.popup = TRUE 
                     CALL cl_err()
                     CLEAR FORM
                  ELSE
                     CALL artt622_fetch("F")
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
               CALL artt622_filter()
               EXIT DIALOG
 
 
 
         
         ON ACTION first
            LET g_action_choice = "fetch"
            CALL artt622_fetch('F')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL artt622_idx_chk()
            
         ON ACTION previous
            LET g_action_choice = "fetch"
            CALL artt622_fetch('P')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL artt622_idx_chk()
            
         ON ACTION jump
            LET g_action_choice = "fetch"
            CALL artt622_fetch('/')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL artt622_idx_chk()
            
         ON ACTION next
            LET g_action_choice = "fetch"
            CALL artt622_fetch('N')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL artt622_idx_chk()
            
         ON ACTION last
            LET g_action_choice = "fetch"
            CALL artt622_fetch('L')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL artt622_idx_chk()
          
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
                  LET g_export_node[1] = base.typeInfo.create(g_rtib_d)
                  LET g_export_id[1]   = "s_detail1"
                  LET g_export_node[2] = base.typeInfo.create(g_rtib2_d)
                  LET g_export_id[2]   = "s_detail2"
                  LET g_export_node[3] = base.typeInfo.create(g_rtib3_d)
                  LET g_export_id[3]   = "s_detail3"
                  LET g_export_node[4] = base.typeInfo.create(g_rtib4_d)
                  LET g_export_id[4]   = "s_detail4"
                  LET g_export_node[5] = base.typeInfo.create(g_rtib5_d)
                  LET g_export_id[5]   = "s_detail5"
                  LET g_export_node[6] = base.typeInfo.create(g_rtib6_d)
                  LET g_export_id[6]   = "s_detail6"
                  LET g_export_node[7] = base.typeInfo.create(g_rtib7_d)
                  LET g_export_id[7]   = "s_detail7"
 
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
               NEXT FIELD rtibseq
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
         ON ACTION artt600_discount
            LET g_action_choice="artt600_discount"
            IF cl_auth_chk_act("artt600_discount") THEN
               
               #add-point:ON ACTION artt600_discount name="menu.artt600_discount"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION artt600_gift
            LET g_action_choice="artt600_gift"
            IF cl_auth_chk_act("artt600_gift") THEN
               
               #add-point:ON ACTION artt600_gift name="menu.artt600_gift"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION modify
            LET g_action_choice="modify"
            IF cl_auth_chk_act("modify") THEN
               LET g_aw = ''
               CALL artt622_modify()
               #add-point:ON ACTION modify name="menu.modify"
                              
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION modify_detail
            LET g_action_choice="modify_detail"
            IF cl_auth_chk_act("modify") THEN
               LET g_aw = g_curr_diag.getCurrentItem()
               CALL artt622_modify()
               #add-point:ON ACTION modify_detail name="menu.modify_detail"
                              
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION note_create
            LET g_action_choice="note_create"
            IF cl_auth_chk_act("note_create") THEN
               
               #add-point:ON ACTION note_create name="menu.note_create"
                              
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION ship_addr_input
            LET g_action_choice="ship_addr_input"
            IF cl_auth_chk_act("ship_addr_input") THEN
               
               #add-point:ON ACTION ship_addr_input name="menu.ship_addr_input"
               CALL artt622_adress(g_sign)
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION artt600_pay_detail
            LET g_action_choice="artt600_pay_detail"
            IF cl_auth_chk_act("artt600_pay_detail") THEN
               
               #add-point:ON ACTION artt600_pay_detail name="menu.artt600_pay_detail"
               #160604-00009#85--dongsz add--s
               CALL s_pay_09(g_rtia_m.rtiadocno)
               LET g_action_choice= ""
               #160604-00009#85--dongsz add--e
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION delete
            LET g_action_choice="delete"
            IF cl_auth_chk_act("delete") THEN
               CALL artt622_delete()
               #add-point:ON ACTION delete name="menu.delete"
                              
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION insert
            LET g_action_choice="insert"
            IF cl_auth_chk_act("insert") THEN
               CALL artt622_insert()
               #add-point:ON ACTION insert name="menu.insert"
                              
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION note
            LET g_action_choice="note"
            IF cl_auth_chk_act("note") THEN
               
               #add-point:ON ACTION note name="menu.note"
               CALL aooi360_02('6','artt622',g_rtia_m.rtiadocno,'','','','','','','','','')
               CALL s_aooi360_sel('6','artt622',g_rtia_m.rtiadocno,'','','','','','','','','4') RETURNING l_success,g_rtia_m.rtia041
               DISPLAY BY NAME g_rtia_m.rtia041
               CALL s_transaction_begin()
               OPEN artt622_cl USING g_enterprise,g_rtia_m.rtiadocno
               IF STATUS THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code =  STATUS
                  LET g_errparam.extend = "OPEN artt622_cl:"
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  CLOSE artt622_cl
                  CALL s_transaction_end('N','0')
               ELSE
                  UPDATE rtia_t SET rtia041 = g_rtia_m.rtia041
                   WHERE rtiaent = g_enterprise
                     AND rtiadocno = g_rtia_m.rtiadocno
                  IF SQLCA.sqlcode THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = SQLCA.sqlcode
                     LET g_errparam.extend = ''
                     LET g_errparam.popup = TRUE
                     CALL cl_err()

                     CLOSE artt622_cl
                     CALL s_transaction_end('N','0')
                  ELSE
                     CLOSE artt622_cl
                     CALL s_transaction_end('Y','0')
                  END IF
               END IF    
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION pay_money
            LET g_action_choice="pay_money"
            IF cl_auth_chk_act("pay_money") THEN
               
               #add-point:ON ACTION pay_money name="menu.pay_money"
               #add by geza 20160318(S)
               #增加出纳收款
               IF NOT cl_null(g_rtia_m.rtiadocno) THEN
                  IF g_rtia_m.rtiastus  = 'N' THEN
                     LET l_cnt = 0
                     SELECT COUNT(rtifdocno) INTO l_cnt
                       FROM rtif_t
                      WHERE rtifent = g_enterprise
                        AND rtifdocno = g_rtia_m.rtiadocno
                     IF l_cnt >= 1 THEN
                        INITIALIZE g_errparam TO NULL
                        LET g_errparam.code = 'amm-00484'
                        LET g_errparam.extend = g_rtia_m.rtiadocno
                        LET g_errparam.popup = TRUE
                        CALL cl_err()
                        CONTINUE DIALOG
                     ELSE
                        CALL s_transaction_begin()
                        IF g_rtia_m.rtia053 = 'N' THEN
                           LET l_rtia053 = 'Y'
                        ELSE
                           LET l_rtia053 = 'N'
                        END IF
                        
                        UPDATE rtia_t
                           SET rtia053 = l_rtia053
                         WHERE rtiaent = g_enterprise
                           AND rtiadocno = g_rtia_m.rtiadocno
                        IF SQLCA.sqlcode THEN
                           INITIALIZE g_errparam TO NULL
                           LET g_errparam.code = SQLCA.sqlcode
                           LET g_errparam.extend = "update rtia_t"
                           LET g_errparam.popup = TRUE
                           CALL cl_err()
                           CALL s_transaction_end("N","0")
                           CONTINUE DIALOG
                        END IF
                        CALL s_transaction_end("Y","0")
                     END IF
                  ELSE
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.extend = ""
                     LET g_errparam.code   = "art-00608"
                     LET g_errparam.popup  = TRUE
                     CALL cl_err()
                     CONTINUE DIALOG
                  END IF
               ELSE
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.extend = ""
                  LET g_errparam.code   = "std-00003"
                  LET g_errparam.popup  = TRUE
                  CALL cl_err()
                  CONTINUE DIALOG
               END IF
               CALL artt622_fetch("")
               #add by geza 20160318(E)
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION output
            LET g_action_choice="output"
            IF cl_auth_chk_act("output") THEN
               
               #add-point:ON ACTION output name="menu.output"
               LET g_rep_wc = " rtiaent = ",g_enterprise," AND rtiadocno = '",g_rtia_m.rtiadocno,"' AND rtiasite = '",g_rtia_m.rtiasite,"' "       
               #END add-point
               &include "erp/art/artt622_rep.4gl"
               #add-point:ON ACTION output.after name="menu.after_output"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION quickprint
            LET g_action_choice="quickprint"
            IF cl_auth_chk_act("quickprint") THEN
               
               #add-point:ON ACTION quickprint name="menu.quickprint"
               LET g_rep_wc = " rtiaent = ",g_enterprise," AND rtiadocno = '",g_rtia_m.rtiadocno,"' AND rtiasite = '",g_rtia_m.rtiasite,"' "       
               #END add-point
               &include "erp/art/artt622_rep.4gl"
               #add-point:ON ACTION quickprint.after name="menu.after_quickprint"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION reproduce
            LET g_action_choice="reproduce"
            IF cl_auth_chk_act("reproduce") THEN
               CALL artt622_reproduce()
               #add-point:ON ACTION reproduce name="menu.reproduce"
                              
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION artt600_pay
            LET g_action_choice="artt600_pay"
            IF cl_auth_chk_act("artt600_pay") THEN
               
               #add-point:ON ACTION artt600_pay name="menu.artt600_pay"
               #160604-00009#85--dongsz add--s
               IF g_rtia_m.rtiastus = 'X' THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'art-00398'
                  LET g_errparam.extend = g_rtia_m.rtiadocno
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

               ELSE
                  SELECT rtia031,rtia051 INTO l_rtia031,l_rtia051
                    FROM rtia_t
                   WHERE rtiaent = g_enterprise
                     AND rtiadocno = g_rtia_m.rtiadocno
                  IF l_rtia031 >= 0 THEN
                     CALL s_pay('rtia_t',1,g_rtia_m.rtiadocno)
                  ELSE
                     CALL s_pay('rtia_t',-1,g_rtia_m.rtiadocno)
                  END IF
                  CALL artt622_refresh()
                  SELECT rtia037 INTO g_rtia_m.rtia037
                    FROM rtia_t
                   WHERE rtiaent = g_enterprise
                     AND rtiadocno = g_rtia_m.rtiadocno
                  DISPLAY BY NAME g_rtia_m.rtia037
               END IF
               LET g_action_choice= ""
               #160604-00009#85--dongsz add--e
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION note_void
            LET g_action_choice="note_void"
            IF cl_auth_chk_act("note_void") THEN
               
               #add-point:ON ACTION note_void name="menu.note_void"
                              
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION query
            LET g_action_choice="query"
            IF cl_auth_chk_act("query") THEN
               CALL artt622_query()
               #add-point:ON ACTION query name="menu.query"
                              
               #END add-point
               #應用 a59 樣板自動產生(Version:3)  
               CALL g_curr_diag.setCurrentRow("s_detail1",1)
               CALL g_curr_diag.setCurrentRow("s_detail2",1)
               CALL g_curr_diag.setCurrentRow("s_detail3",1)
               CALL g_curr_diag.setCurrentRow("s_detail4",1)
               CALL g_curr_diag.setCurrentRow("s_detail5",1)
               CALL g_curr_diag.setCurrentRow("s_detail6",1)
               CALL g_curr_diag.setCurrentRow("s_detail7",1)
 
 
 
 
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION sel_gift
            LET g_action_choice="sel_gift"
            IF cl_auth_chk_act("sel_gift") THEN
               
               #add-point:ON ACTION sel_gift name="menu.sel_gift"
               #150429-00007#9--dongsz add--s
               CALL s_gift('2',g_rtia_m.rtiadocno,g_rtia_m.rtiasite," 1=1")
               CALL artt622_b_fill()
               SELECT SUM(rtib012),SUM(rtib008*rtib017),SUM(rtib020),SUM(rtib021)
                 INTO g_rtia_m.snum,g_rtia_m.amount,g_rtia_m.amount2,g_rtia_m.amount3
                 FROM rtib_t
                WHERE rtibent = g_enterprise
                  AND rtibdocno = g_rtia_m.rtiadocno
               DISPLAY g_rtia_m.snum TO FORMONLY.snum  
               DISPLAY g_rtia_m.amount TO FORMONLY.amount
               DISPLAY g_rtia_m.amount2 TO FORMONLY.amount2
               DISPLAY g_rtia_m.amount3 TO FORMONLY.amount3
               #更新单头本币应收金额
               #更新单头含税金额
               UPDATE rtia_t SET rtia031 = (SELECT SUM(rtib021)
                                              FROM rtib_t
                                             WHERE rtibent = g_enterprise
                                               AND rtibdocno = g_rtia_m.rtiadocno),
                                 rtia049 = (SELECT SUM(rtib031)
                                              FROM rtib_t
                                             WHERE rtibent = g_enterprise
                                               AND rtibdocno = g_rtia_m.rtiadocno)              
                WHERE rtiaent = g_enterprise
                  AND rtiadocno = g_rtia_m.rtiadocno  
               IF SQLCA.sqlcode THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = SQLCA.sqlcode
                  LET g_errparam.extend = "upd rtia_t"
                  LET g_errparam.popup = FALSE
                  CALL cl_err()
               
                  CONTINUE DIALOG
               END IF     
               #150429-00007#9--dongsz add--e
               #END add-point
               
            END IF
 
 
 
 
         
         #應用 a46 樣板自動產生(Version:3)
         #新增相關文件
         ON ACTION related_document
            CALL artt622_set_pk_array()
            IF cl_auth_chk_act("related_document") THEN
               #add-point:ON ACTION related_document name="ui_dialog.dialog.related_document"
               
               #END add-point
               CALL cl_doc()
            END IF
            
         ON ACTION agendum
            CALL artt622_set_pk_array()
            #add-point:ON ACTION agendum name="ui_dialog.dialog.agendum"
            
            #END add-point
            CALL cl_user_overview()
            CALL cl_user_overview_set_follow_pic()
         
         ON ACTION followup
            CALL artt622_set_pk_array()
            #add-point:ON ACTION followup name="ui_dialog.dialog.followup"
            
            #END add-point
            CALL cl_user_overview_follow(g_rtia_m.rtiadocdt)
 
 
 
         
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
 
{<section id="artt622.browser_fill" >}
#+ 瀏覽頁簽資料填充
PRIVATE FUNCTION artt622_browser_fill(ps_page_action)
   #add-point:browser_fill段define(客製用) name="browser_fill.define_customerization"
   
   #end add-point  
   DEFINE ps_page_action    STRING
   DEFINE l_wc              STRING
   DEFINE l_wc2             STRING
   DEFINE l_sql             STRING
   DEFINE l_sub_sql         STRING
   DEFINE l_sql_rank        STRING
   #add-point:browser_fill段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="browser_fill.define"
   DEFINE l_where           STRING
   #end add-point    
   
   #add-point:Function前置處理 name="browser_fill.before_browser_fill"
   IF g_prog = 'artt622' THEN 
      LET g_wc = g_wc CLIPPED," AND rtia000 = 'artt622' "
   END IF
   IF g_prog = 'artt610' THEN 
      LET g_wc = g_wc CLIPPED," AND rtia000 = 'artt610' "
   END IF 
   IF g_prog = 'artt622' THEN 
      LET g_wc = g_wc CLIPPED," AND rtia000 = 'artt622' "
   END IF 
   IF g_prog = 'artt700' THEN 
      LET g_wc = g_wc CLIPPED," AND rtia000 = 'artt700' "
   END IF 
   #add by yangxf ---start---
   IF g_prog = 'artt800' THEN 
      LET g_wc = g_wc CLIPPED," AND rtia000 = 'artt800' "
   END IF 
   #add by yangxf 20151127 ---start---
   IF g_prog = 'artt620' THEN 
      LET g_wc = g_wc CLIPPED," AND rtia000 = 'artt620' "
   END IF    
   #add by yangxf 20151127 ---end---
   #add by yangxf ----end----
   #150429-00007#9--dongsz add--str
   IF g_prog = 'aprt280' THEN 
      LET g_wc = g_wc CLIPPED," AND rtia000 = 'aprt280' "
   END IF
   #150429-00007#9--dongsz add--end
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
   CALL s_aooi500_sql_where(g_prog,'rtiasite') RETURNING l_where
   LET g_wc = g_wc," AND ",l_where
   LET l_wc  = g_wc.trim() 
   #end add-point
   
   IF g_wc2 <> " 1=1" THEN
      #單身有輸入搜尋條件                      
      LET l_sub_sql = " SELECT DISTINCT rtiadocno ",
                      " FROM rtia_t ",
                      " ",
                      " LEFT JOIN rtib_t ON rtibent = rtiaent AND rtiadocno = rtibdocno ", "  ",
                      #add-point:browser_fill段sql(rtib_t1) name="browser_fill.cnt.join.}"
                      
                      #end add-point
                      " LEFT JOIN rtic_t ON rticent = rtiaent AND rtiadocno = rticdocno", "  ",
                      #add-point:browser_fill段sql(rtic_t1) name="browser_fill.cnt.join.rtic_t1"
                      
                      #end add-point
 
                      " LEFT JOIN xrcd_t ON xrcdent = rtiaent AND rtiadocno = xrcddocno", "  ",
                      #add-point:browser_fill段sql(xrcd_t1) name="browser_fill.cnt.join.xrcd_t1"
                      
                      #end add-point
 
                      " LEFT JOIN rtie_t ON rtieent = rtiaent AND rtiadocno = rtiedocno", "  ",
                      #add-point:browser_fill段sql(rtie_t1) name="browser_fill.cnt.join.rtie_t1"
                      
                      #end add-point
 
                      " LEFT JOIN rtik_t ON rtikent = rtiaent AND rtiadocno = rtikdocno", "  ",
                      #add-point:browser_fill段sql(rtik_t1) name="browser_fill.cnt.join.rtik_t1"
                      
                      #end add-point
 
                      " LEFT JOIN rtin_t ON rtinent = rtiaent AND rtiadocno = rtindocno", "  ",
                      #add-point:browser_fill段sql(rtin_t1) name="browser_fill.cnt.join.rtin_t1"
#add by yangxf ---start---
      ""
      LET l_sub_sql = " SELECT UNIQUE rtiadocno FROM rtia_t "
      IF g_wc2_table1 <> ' 1=1' THEN 
         LET l_sub_sql = l_sub_sql," LEFT JOIN rtib_t ON rtibent = rtiaent AND rtiadocno = rtibdocno "
      END IF 
      IF g_wc2_table2 <> ' 1=1' THEN 
         LET l_sub_sql = l_sub_sql,"  LEFT JOIN rtic_t ON rticent = rtiaent AND rtiadocno = rticdocno"
      END IF 
      IF g_wc2_table3 <> ' 1=1' THEN 
         LET l_sub_sql = l_sub_sql,"  LEFT JOIN xrcd_t ON xrcdent = rtiaent AND rtiadocno = xrcddocno"
      END IF 
      IF g_wc2_table4 <> ' 1=1' THEN 
         LET l_sub_sql = l_sub_sql,"  LEFT JOIN rtie_t ON rtieent = rtiaent AND rtiadocno = rtiedocno"
      END IF 
      IF g_wc2_table5 <> ' 1=1' THEN 
         LET l_sub_sql = l_sub_sql,"  LEFT JOIN rtik_t ON rtikent = rtiaent AND rtiadocno = rtikdocno"
      END IF 
      IF g_wc2_table6 <> ' 1=1' THEN 
         LET l_sub_sql = l_sub_sql,"  LEFT JOIN rtin_t ON rtinent = rtiaent AND rtiadocno = rtindocno"
      END IF 
      LET l_sub_sql = l_sub_sql,
#add by yangxf ---end-----
                      #end add-point
 
                      " LEFT JOIN prek_t ON prekent = rtiaent AND rtiadocno = prekdocno", "  ",
                      #add-point:browser_fill段sql(prek_t1) name="browser_fill.cnt.join.prek_t1"
                      
                      #end add-point
 
 
 
                      " ", 
                      " ", 
                      " ",                      
 
                      " ",                      
 
                      " ",                      
 
                      " ",                      
 
                      " ",                      
 
                      " ",                      
 
 
 
                      " WHERE rtiaent = " ||g_enterprise|| " AND rtibent = " ||g_enterprise|| " AND ",l_wc, " AND ", l_wc2, cl_sql_add_filter("rtia_t")
   ELSE
      #單身未輸入搜尋條件
      LET l_sub_sql = " SELECT DISTINCT rtiadocno ",
                      " FROM rtia_t ", 
                      "  ",
                      "  ",
                      " WHERE rtiaent = " ||g_enterprise|| " AND ",l_wc CLIPPED, cl_sql_add_filter("rtia_t")
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
      INITIALIZE g_rtia_m.* TO NULL
      CALL g_rtib_d.clear()        
      CALL g_rtib2_d.clear() 
      CALL g_rtib3_d.clear() 
      CALL g_rtib4_d.clear() 
      CALL g_rtib5_d.clear() 
      CALL g_rtib6_d.clear() 
      CALL g_rtib7_d.clear() 
 
      #add-point:browser_fill g_add_browse段額外處理 name="browser_fill.add_browse.other"
      
      #end add-point   
      CALL g_browser.clear()
      LET g_cnt = 1
   ELSE
      LET l_wc  = g_add_browse
      LET l_wc2 = " 1=1" 
      LET g_cnt = g_current_idx
   END IF
 
   #依照t0.rtiasite,t0.rtiadocdt,t0.rtiadocno,t0.rtia002,t0.rtia006 Browser欄位定義(取代原本bs_sql功能)
   #考量到單身可能下條件, 所以此處需join單身所有table
   #DISTINCT是為了避免在join時出現重複的資料(如果不加DISTINCT則須在程式中過濾)
   IF g_wc2 <> " 1=1" THEN
      #單身有輸入搜尋條件   
      LET g_sql = " SELECT DISTINCT t0.rtiastus,t0.rtiasite,t0.rtiadocdt,t0.rtiadocno,t0.rtia002,t0.rtia006, 
          t1.ooefl003 ",
                  " FROM rtia_t t0",
                  "  ",
                  "  LEFT JOIN rtib_t ON rtibent = rtiaent AND rtiadocno = rtibdocno ", "  ", 
                  #add-point:browser_fill段sql(rtib_t1) name="browser_fill.join.rtib_t1"
                  
                  #end add-point
                  "  LEFT JOIN rtic_t ON rticent = rtiaent AND rtiadocno = rticdocno", "  ", 
                  #add-point:browser_fill段sql(rtic_t1) name="browser_fill.join.rtic_t1"
                  
                  #end add-point
 
                  "  LEFT JOIN xrcd_t ON xrcdent = rtiaent AND rtiadocno = xrcddocno", "  ", 
                  #add-point:browser_fill段sql(xrcd_t1) name="browser_fill.join.xrcd_t1"
                  
                  #end add-point
 
                  "  LEFT JOIN rtie_t ON rtieent = rtiaent AND rtiadocno = rtiedocno", "  ", 
                  #add-point:browser_fill段sql(rtie_t1) name="browser_fill.join.rtie_t1"
                  
                  #end add-point
 
                  "  LEFT JOIN rtik_t ON rtikent = rtiaent AND rtiadocno = rtikdocno", "  ", 
                  #add-point:browser_fill段sql(rtik_t1) name="browser_fill.join.rtik_t1"
                  
                  #end add-point
 
                  "  LEFT JOIN rtin_t ON rtinent = rtiaent AND rtiadocno = rtindocno", "  ", 
                  #add-point:browser_fill段sql(rtin_t1) name="browser_fill.join.rtin_t1"
                  
                  #end add-point
 
                  "  LEFT JOIN prek_t ON prekent = rtiaent AND rtiadocno = prekdocno", "  ", 
                  #add-point:browser_fill段sql(prek_t1) name="browser_fill.join.prek_t1"
                  
                  #end add-point
 
 
 
                  " ", 
                  " ",                      
 
                  " ",                      
 
                  " ",                      
 
                  " ",                      
 
                  " ",                      
 
                  " ",                      
 
 
 
                                 " LEFT JOIN ooefl_t t1 ON t1.ooeflent="||g_enterprise||" AND t1.ooefl001=t0.rtiasite AND t1.ooefl002='"||g_dlang||"' ",
 
                  " WHERE t0.rtiaent = " ||g_enterprise|| " AND ",l_wc," AND ",l_wc2, cl_sql_add_filter("rtia_t")
   ELSE
      #單身無輸入搜尋條件   
      LET g_sql = " SELECT DISTINCT t0.rtiastus,t0.rtiasite,t0.rtiadocdt,t0.rtiadocno,t0.rtia002,t0.rtia006, 
          t1.ooefl003 ",
                  " FROM rtia_t t0",
                  "  ",
                                 " LEFT JOIN ooefl_t t1 ON t1.ooeflent="||g_enterprise||" AND t1.ooefl001=t0.rtiasite AND t1.ooefl002='"||g_dlang||"' ",
 
                  " WHERE t0.rtiaent = " ||g_enterprise|| " AND ",l_wc, cl_sql_add_filter("rtia_t")
   END IF
   #add-point:browser_fill,sql wc name="browser_fill.fill_sqlwc"
   
   #end add-point
   LET g_sql = g_sql, " ORDER BY rtiadocno ",g_order
 
   #add-point:browser_fill,before_prepare name="browser_fill.before_prepare"
   #add by yangxf ---start---
   LET g_sql = " SELECT DISTINCT t0.rtiastus,t0.rtiasite,t0.rtiadocdt,t0.rtiadocno,t0.rtia002,t0.rtia006,t1.ooefl003 ",
               " FROM rtia_t t0 "
   IF g_wc2_table1 <> ' 1=1' THEN 
      LET g_sql = g_sql," LEFT JOIN rtib_t ON rtibent = rtiaent AND rtiadocno = rtibdocno "
   END IF 
   IF g_wc2_table2 <> ' 1=1' THEN 
      LET g_sql = g_sql,"  LEFT JOIN rtic_t ON rticent = rtiaent AND rtiadocno = rticdocno"
   END IF 
   IF g_wc2_table3 <> ' 1=1' THEN 
      LET g_sql = g_sql,"  LEFT JOIN xrcd_t ON xrcdent = rtiaent AND rtiadocno = xrcddocno"
   END IF 
   IF g_wc2_table4 <> ' 1=1' THEN 
      LET g_sql = g_sql,"  LEFT JOIN rtie_t ON rtieent = rtiaent AND rtiadocno = rtiedocno"
   END IF 
   IF g_wc2_table5 <> ' 1=1' THEN 
      LET g_sql = g_sql,"  LEFT JOIN rtik_t ON rtikent = rtiaent AND rtiadocno = rtikdocno"
   END IF 
   IF g_wc2_table6 <> ' 1=1' THEN 
      LET g_sql = g_sql,"  LEFT JOIN rtin_t ON rtinent = rtiaent AND rtiadocno = rtindocno"
   END IF 
   LET g_sql = g_sql," LEFT JOIN ooefl_t t1 ON t1.ooeflent='"||g_enterprise||"' AND t1.ooefl001=t0.rtiasite AND t1.ooefl002='"||g_lang||"' ",
                     " WHERE t0.rtiaent = '" ||g_enterprise|| "' AND ",l_wc," AND ",l_wc2, cl_sql_add_filter("rtia_t")
   LET g_sql = g_sql, " ORDER BY rtiadocno ",g_order
   #add by yangxf ----end-----
   #end add-point
        
   #LET g_sql = cl_sql_add_tabid(g_sql,"rtia_t") #WC重組
   LET g_sql = cl_sql_add_mask(g_sql) #遮蔽特定資料
   
   IF g_sql.getIndexOf(" 1=2",1) THEN
      DISPLAY "INFO: 1=2 jumped!"
   ELSE
      PREPARE browse_pre FROM g_sql
      DECLARE browse_cur CURSOR FOR browse_pre
      
      #add-point:browser_fill段open cursor name="browser_fill.open"
      
      #end add-point
      
      FOREACH browse_cur INTO g_browser[g_cnt].b_statepic,g_browser[g_cnt].b_rtiasite,g_browser[g_cnt].b_rtiadocdt, 
          g_browser[g_cnt].b_rtiadocno,g_browser[g_cnt].b_rtia002,g_browser[g_cnt].b_rtia006,g_browser[g_cnt].b_rtiasite_desc 
 
         IF SQLCA.SQLCODE THEN
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "Foreach:",SQLERRMESSAGE 
            LET g_errparam.code = SQLCA.SQLCODE 
            LET g_errparam.popup = TRUE 
            CALL cl_err()
            EXIT FOREACH
         END IF
      
         #add-point:browser_fill段reference name="browser_fill.reference"
      INITIALIZE g_ref_fields TO NULL
      LET g_ref_fields[1] = g_browser[g_cnt].b_rtia002
      CALL ap_ref_array2(g_ref_fields,"SELECT pmaal004 FROM pmaal_t WHERE pmaalent='"||g_enterprise||"' AND pmaal001=? AND pmaal002='"||g_lang||"'", "") RETURNING g_rtn_fields
      LET g_browser[g_cnt].b_rtia002_desc = '', g_rtn_fields[1] , ''
      DISPLAY BY NAME g_browser[g_cnt].b_rtia002_desc
         #end add-point
      
         #遮罩相關處理
         CALL artt622_browser_mask()
      
               #應用 a24 樣板自動產生(Version:3)
      #browser顯示圖片
      CASE g_browser[g_cnt].b_statepic
         WHEN "N"
            LET g_browser[g_cnt].b_statepic = "stus/16/unconfirmed.png"
         WHEN "Y"
            LET g_browser[g_cnt].b_statepic = "stus/16/confirmed.png"
         WHEN "S"
            LET g_browser[g_cnt].b_statepic = "stus/16/posted.png"
         WHEN "Z"
            LET g_browser[g_cnt].b_statepic = "stus/16/unposted.png"
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
   
   IF cl_null(g_browser[g_cnt].b_rtiadocno) THEN
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
 
{<section id="artt622.ui_headershow" >}
#+ 單頭資料重新顯示
PRIVATE FUNCTION artt622_ui_headershow()
   #add-point:ui_headershow段define(客製用) name="ui_headershow.define_customerization"
   
   #end add-point  
   #add-point:ui_headershow段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="ui_headershow.define"
      
   #end add-point      
   
   #add-point:Function前置處理  name="ui_headershow.pre_function"
   
   #end add-point
   
   LET g_rtia_m.rtiadocno = g_browser[g_current_idx].b_rtiadocno   
 
   EXECUTE artt622_master_referesh USING g_rtia_m.rtiadocno INTO g_rtia_m.rtiasite,g_rtia_m.rtiadocdt, 
       g_rtia_m.rtiadocno,g_rtia_m.rtia002,g_rtia_m.rtia001,g_rtia_m.rtia059,g_rtia_m.rtia060,g_rtia_m.rtia004, 
       g_rtia_m.rtia005,g_rtia_m.rtia006,g_rtia_m.rtia048,g_rtia_m.rtia053,g_rtia_m.rtiastus,g_rtia_m.rtia007, 
       g_rtia_m.rtia008,g_rtia_m.rtia009,g_rtia_m.rtia043,g_rtia_m.rtia047,g_rtia_m.rtia013,g_rtia_m.rtia014, 
       g_rtia_m.rtia015,g_rtia_m.rtia016,g_rtia_m.rtia051,g_rtia_m.rtia010,g_rtia_m.rtia011,g_rtia_m.rtia012, 
       g_rtia_m.rtia041,g_rtia_m.rtia017,g_rtia_m.rtia018,g_rtia_m.rtia019,g_rtia_m.rtia020,g_rtia_m.rtia021, 
       g_rtia_m.rtia022,g_rtia_m.rtia023,g_rtia_m.rtia024,g_rtia_m.rtia025,g_rtia_m.rtia026,g_rtia_m.rtia027, 
       g_rtia_m.rtia028,g_rtia_m.rtia029,g_rtia_m.rtia030,g_rtia_m.rtia032,g_rtia_m.rtia033,g_rtia_m.rtia034, 
       g_rtia_m.rtia035,g_rtia_m.rtia036,g_rtia_m.rtia037,g_rtia_m.rtia038,g_rtia_m.rtia039,g_rtia_m.rtia107, 
       g_rtia_m.rtiaownid,g_rtia_m.rtiacrtid,g_rtia_m.rtiaowndp,g_rtia_m.rtiacrtdp,g_rtia_m.rtiacrtdt, 
       g_rtia_m.rtiamodid,g_rtia_m.rtiamoddt,g_rtia_m.rtiacnfid,g_rtia_m.rtiacnfdt,g_rtia_m.rtiapstid, 
       g_rtia_m.rtiapstdt,g_rtia_m.rtiasite_desc,g_rtia_m.rtia002_desc,g_rtia_m.rtia004_desc,g_rtia_m.rtia005_desc, 
       g_rtia_m.rtia009_desc,g_rtia_m.rtia010_desc,g_rtia_m.rtia011_desc,g_rtia_m.rtia012_desc,g_rtia_m.rtia018_desc, 
       g_rtia_m.rtia024_desc,g_rtia_m.rtia025_desc,g_rtia_m.rtia036_desc,g_rtia_m.rtia037_desc,g_rtia_m.rtia038_desc, 
       g_rtia_m.rtiaownid_desc,g_rtia_m.rtiacrtid_desc,g_rtia_m.rtiaowndp_desc,g_rtia_m.rtiacrtdp_desc, 
       g_rtia_m.rtiamodid_desc,g_rtia_m.rtiacnfid_desc,g_rtia_m.rtiapstid_desc
   
   CALL artt622_rtia_t_mask()
   CALL artt622_show()
      
END FUNCTION
 
{</section>}
 
{<section id="artt622.ui_detailshow" >}
#+ 單身資料重新顯示
PRIVATE FUNCTION artt622_ui_detailshow()
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
      CALL g_curr_diag.setCurrentRow("s_detail4",g_detail_idx)
      CALL g_curr_diag.setCurrentRow("s_detail5",g_detail_idx)
      CALL g_curr_diag.setCurrentRow("s_detail6",g_detail_idx)
      CALL g_curr_diag.setCurrentRow("s_detail7",g_detail_idx)
 
   END IF
   
   #add-point:ui_detailshow段after name="ui_detailshow.after"
      
   #end add-point    
   
END FUNCTION
 
{</section>}
 
{<section id="artt622.ui_browser_refresh" >}
#+ 瀏覽頁簽資料重新顯示
PRIVATE FUNCTION artt622_ui_browser_refresh()
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
      IF g_browser[l_i].b_rtiadocno = g_rtia_m.rtiadocno 
 
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
 
{<section id="artt622.construct" >}
#+ QBE資料查詢
PRIVATE FUNCTION artt622_construct()
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
   #end add-point    
   
   #add-point:Function前置處理  name="cs.pre_function"
   
   #end add-point
    
   #清除畫面
   CLEAR FORM                
   INITIALIZE g_rtia_m.* TO NULL
   CALL g_rtib_d.clear()        
   CALL g_rtib2_d.clear() 
   CALL g_rtib3_d.clear() 
   CALL g_rtib4_d.clear() 
   CALL g_rtib5_d.clear() 
   CALL g_rtib6_d.clear() 
   CALL g_rtib7_d.clear() 
 
   
   LET g_action_choice = ""
    
   INITIALIZE g_wc TO NULL
   INITIALIZE g_wc2 TO NULL
   
   INITIALIZE g_wc2_table1 TO NULL
   INITIALIZE g_wc2_table2 TO NULL
 
   INITIALIZE g_wc2_table3 TO NULL
 
   INITIALIZE g_wc2_table4 TO NULL
 
   INITIALIZE g_wc2_table5 TO NULL
 
   INITIALIZE g_wc2_table6 TO NULL
 
   INITIALIZE g_wc2_table7 TO NULL
 
 
    
   LET g_qryparam.state = 'c'
   
   #add-point:cs段開始前 name="cs.before_construct"
        
   #end add-point 
   
   #使用DIALOG包住 單頭CONSTRUCT及單身CONSTRUCT
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
      
      #單頭
      CONSTRUCT BY NAME g_wc ON rtiasite,rtiadocdt,rtiadocno,rtia002,rtia001,rtia059,rtia060,mmaf003, 
          mmaf004,rtia004,rtia005,rtia006,rtia048,rtia053,rtiastus,rtia007,rtia008,rtia009,rtia043,rtia047, 
          rtia013,rtia014,rtia015,rtia016,rtia051,rtia010,rtia011,rtia012,chantype,barcode,rtia041,rtia017, 
          rtia018,rtia019,rtia020,rtia021,rtia022,rtia023,rtia024,rtia025,rtia026,rtia027,rtia028,rtia029, 
          rtia030,rtia032,rtia033,rtia034,rtia035,rtia036,rtia037,rtia038,rtia039,rtia107,isaf009,isaf010, 
          isaf044,isaf202,isaf203,isaf204,isaf201,isaf207,rtiaownid,rtiacrtid,rtiaowndp,rtiacrtdp,rtiacrtdt, 
          rtiamodid,rtiamoddt,rtiacnfid,rtiacnfdt,rtiapstid,rtiapstdt
 
         BEFORE CONSTRUCT
            #add-point:cs段before_construct name="cs.head.before_construct"
                        
            #end add-point 
            
         #公用欄位開窗相關處理
         #應用 a11 樣板自動產生(Version:3)
         #共用欄位查詢處理  
         ##----<<rtiacrtdt>>----
         AFTER FIELD rtiacrtdt
            CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
            IF NOT cl_null(ls_result) THEN
               IF NOT cl_chk_date_symbol(ls_result) THEN
                  LET ls_result = cl_add_date_extra_cond(ls_result)
               END IF
            END IF
            CALL FGL_DIALOG_SETBUFFER(ls_result)
 
         #----<<rtiamoddt>>----
         AFTER FIELD rtiamoddt
            CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
            IF NOT cl_null(ls_result) THEN
               IF NOT cl_chk_date_symbol(ls_result) THEN
                  LET ls_result = cl_add_date_extra_cond(ls_result)
               END IF
            END IF
            CALL FGL_DIALOG_SETBUFFER(ls_result)
         
         #----<<rtiacnfdt>>----
         AFTER FIELD rtiacnfdt
            CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
            IF NOT cl_null(ls_result) THEN
               IF NOT cl_chk_date_symbol(ls_result) THEN
                  LET ls_result = cl_add_date_extra_cond(ls_result)
               END IF
            END IF
            CALL FGL_DIALOG_SETBUFFER(ls_result)
         
         #----<<rtiapstdt>>----
         AFTER FIELD rtiapstdt
            CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
            IF NOT cl_null(ls_result) THEN
               IF NOT cl_chk_date_symbol(ls_result) THEN
                  LET ls_result = cl_add_date_extra_cond(ls_result)
               END IF
            END IF
            CALL FGL_DIALOG_SETBUFFER(ls_result)
 
 
 
            
         #一般欄位開窗相關處理    
                  #Ctrlp:construct.c.rtiasite
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtiasite
            #add-point:ON ACTION controlp INFIELD rtiasite name="construct.c.rtiasite"
                                    #此段落由子樣板a08產生
            #開窗c段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			   LET g_qryparam.reqry = FALSE
#            LET g_qryparam.arg1 = g_site
#            LET g_qryparam.arg2 = "8" 
#            CALL q_ooed004()                           #呼叫開窗
            LET g_qryparam.where = s_aooi500_q_where(g_prog,'rtiasite',g_site,'c')   #150308-00001#5  By benson add 'c'
            CALL q_ooef001_24()
            DISPLAY g_qryparam.return1 TO rtiasite  #顯示到畫面上

            NEXT FIELD rtiasite                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtiasite
            #add-point:BEFORE FIELD rtiasite name="construct.b.rtiasite"
                        
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtiasite
            
            #add-point:AFTER FIELD rtiasite name="construct.a.rtiasite"
                        
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtiadocdt
            #add-point:BEFORE FIELD rtiadocdt name="construct.b.rtiadocdt"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtiadocdt
            
            #add-point:AFTER FIELD rtiadocdt name="construct.a.rtiadocdt"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.rtiadocdt
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtiadocdt
            #add-point:ON ACTION controlp INFIELD rtiadocdt name="construct.c.rtiadocdt"
            
            #END add-point
 
 
         #Ctrlp:construct.c.rtiadocno
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtiadocno
            #add-point:ON ACTION controlp INFIELD rtiadocno name="construct.c.rtiadocno"
                                    #此段落由子樣板a08產生
            #開窗c段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			LET g_qryparam.reqry = FALSE
			LET g_qryparam.where = " rtia000 = '",g_prog,"'"
            CALL q_rtiadocno()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO rtiadocno  #顯示到畫面上

            NEXT FIELD rtiadocno                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtiadocno
            #add-point:BEFORE FIELD rtiadocno name="construct.b.rtiadocno"
                        
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtiadocno
            
            #add-point:AFTER FIELD rtiadocno name="construct.a.rtiadocno"
                        
            #END add-point
            
 
 
         #Ctrlp:construct.c.rtia002
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtia002
            #add-point:ON ACTION controlp INFIELD rtia002 name="construct.c.rtia002"
                                    #此段落由子樣板a08產生
            #開窗c段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			LET g_qryparam.reqry = FALSE
            CALL q_pmaa001_7()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO rtia002  #顯示到畫面上

            NEXT FIELD rtia002                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtia002
            #add-point:BEFORE FIELD rtia002 name="construct.b.rtia002"
                        
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtia002
            
            #add-point:AFTER FIELD rtia002 name="construct.a.rtia002"
                        
            #END add-point
            
 
 
         #Ctrlp:construct.c.rtia001
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtia001
            #add-point:ON ACTION controlp INFIELD rtia001 name="construct.c.rtia001"
                                    #此段落由子樣板a08產生
            #開窗c段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			LET g_qryparam.reqry = FALSE
            CALL q_mmaq001_3()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO rtia001  #顯示到畫面上
               #DISPLAY g_qryparam.return2 TO mmaf014 #會員手機號碼 
               #DISPLAY g_qryparam.return3 TO mmaf015 #會員出生日期 
               #DISPLAY g_qryparam.return4 TO mmaf008 #會員姓名 

            NEXT FIELD rtia001                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtia001
            #add-point:BEFORE FIELD rtia001 name="construct.b.rtia001"
                        
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtia001
            
            #add-point:AFTER FIELD rtia001 name="construct.a.rtia001"
                        
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtia059
            #add-point:BEFORE FIELD rtia059 name="construct.b.rtia059"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtia059
            
            #add-point:AFTER FIELD rtia059 name="construct.a.rtia059"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.rtia059
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtia059
            #add-point:ON ACTION controlp INFIELD rtia059 name="construct.c.rtia059"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtia060
            #add-point:BEFORE FIELD rtia060 name="construct.b.rtia060"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtia060
            
            #add-point:AFTER FIELD rtia060 name="construct.a.rtia060"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.rtia060
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtia060
            #add-point:ON ACTION controlp INFIELD rtia060 name="construct.c.rtia060"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mmaf003
            #add-point:BEFORE FIELD mmaf003 name="construct.b.mmaf003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mmaf003
            
            #add-point:AFTER FIELD mmaf003 name="construct.a.mmaf003"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.mmaf003
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mmaf003
            #add-point:ON ACTION controlp INFIELD mmaf003 name="construct.c.mmaf003"
            
            #END add-point
 
 
         #Ctrlp:construct.c.mmaf004
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mmaf004
            #add-point:ON ACTION controlp INFIELD mmaf004 name="construct.c.mmaf004"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_mmaf004()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO mmaf004  #顯示到畫面上
            NEXT FIELD mmaf004                     #返回原欄位
    



            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mmaf004
            #add-point:BEFORE FIELD mmaf004 name="construct.b.mmaf004"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mmaf004
            
            #add-point:AFTER FIELD mmaf004 name="construct.a.mmaf004"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.rtia004
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtia004
            #add-point:ON ACTION controlp INFIELD rtia004 name="construct.c.rtia004"
                                    #此段落由子樣板a08產生
            #開窗c段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO rtia004  #顯示到畫面上

            NEXT FIELD rtia004                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtia004
            #add-point:BEFORE FIELD rtia004 name="construct.b.rtia004"
                        
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtia004
            
            #add-point:AFTER FIELD rtia004 name="construct.a.rtia004"
                        
            #END add-point
            
 
 
         #Ctrlp:construct.c.rtia005
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtia005
            #add-point:ON ACTION controlp INFIELD rtia005 name="construct.c.rtia005"
                                    #此段落由子樣板a08產生
            #開窗c段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			LET g_qryparam.reqry = FALSE
			LET g_qryparam.arg1 = g_today
            CALL q_ooeg001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO rtia005  #顯示到畫面上

            NEXT FIELD rtia005                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtia005
            #add-point:BEFORE FIELD rtia005 name="construct.b.rtia005"
                        
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtia005
            
            #add-point:AFTER FIELD rtia005 name="construct.a.rtia005"
                        
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtia006
            #add-point:BEFORE FIELD rtia006 name="construct.b.rtia006"
                        
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtia006
            
            #add-point:AFTER FIELD rtia006 name="construct.a.rtia006"
            CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
            IF NOT cl_null(ls_result) THEN
               IF NOT cl_chk_date_symbol(ls_result) THEN
                  LET ls_result = cl_add_date_extra_cond(ls_result)
               END IF
            END IF
            CALL FGL_DIALOG_SETBUFFER(ls_result)
            #END add-point
            
 
 
         #Ctrlp:construct.c.rtia006
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtia006
            #add-point:ON ACTION controlp INFIELD rtia006 name="construct.c.rtia006"
                        
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtia048
            #add-point:BEFORE FIELD rtia048 name="construct.b.rtia048"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtia048
            
            #add-point:AFTER FIELD rtia048 name="construct.a.rtia048"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.rtia048
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtia048
            #add-point:ON ACTION controlp INFIELD rtia048 name="construct.c.rtia048"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtia053
            #add-point:BEFORE FIELD rtia053 name="construct.b.rtia053"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtia053
            
            #add-point:AFTER FIELD rtia053 name="construct.a.rtia053"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.rtia053
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtia053
            #add-point:ON ACTION controlp INFIELD rtia053 name="construct.c.rtia053"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtiastus
            #add-point:BEFORE FIELD rtiastus name="construct.b.rtiastus"
                        
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtiastus
            
            #add-point:AFTER FIELD rtiastus name="construct.a.rtiastus"
                        
            #END add-point
            
 
 
         #Ctrlp:construct.c.rtiastus
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtiastus
            #add-point:ON ACTION controlp INFIELD rtiastus name="construct.c.rtiastus"
                        
            #END add-point
 
 
         #Ctrlp:construct.c.rtia007
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtia007
            #add-point:ON ACTION controlp INFIELD rtia007 name="construct.c.rtia007"
            ### 來源單號查詢### start ###
            INITIALIZE g_qryparam.* TO NULL 
            LET g_qryparam.state = "c"
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.where = " rtia000 = '",g_prog,"'"
            CALL q_rtia007()
            DISPLAY g_qryparam.return1 TO rtia007
            ### 來源單號查詢### end ###

            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtia007
            #add-point:BEFORE FIELD rtia007 name="construct.b.rtia007"
                        
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtia007
            
            #add-point:AFTER FIELD rtia007 name="construct.a.rtia007"
                        
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtia008
            #add-point:BEFORE FIELD rtia008 name="construct.b.rtia008"
                        
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtia008
            
            #add-point:AFTER FIELD rtia008 name="construct.a.rtia008"
                        
            #END add-point
            
 
 
         #Ctrlp:construct.c.rtia008
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtia008
            #add-point:ON ACTION controlp INFIELD rtia008 name="construct.c.rtia008"
                        
            #END add-point
 
 
         #Ctrlp:construct.c.rtia009
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtia009
            #add-point:ON ACTION controlp INFIELD rtia009 name="construct.c.rtia009"
                                    #此段落由子樣板a08產生
            #開窗c段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			LET g_qryparam.reqry = FALSE
			LET g_qryparam.arg1 = '295'
            CALL q_oocq002()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO rtia009  #顯示到畫面上

            NEXT FIELD rtia009                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtia009
            #add-point:BEFORE FIELD rtia009 name="construct.b.rtia009"
                        
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtia009
            
            #add-point:AFTER FIELD rtia009 name="construct.a.rtia009"
                                    IF NOT cl_null(g_rtia_m.rtia009) THEN 
               CALL artt622_rtia009_chk()
               IF NOT cl_null(g_errno) THEN 
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = g_errno
                  LET g_errparam.extend = ''
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  #LET g_rtia_m.rtia009 = g_rtia_m_t.rtia009  #160824-00007#172 Mark By Ken 161107
                  LET g_rtia_m.rtia009 = g_rtia_m_o.rtia009   #160824-00007#172 Add By Ken 161107
                  NEXT FIELD rtia009
               END IF 
            END IF 
            LET g_rtia_m_o.* = g_rtia_m.*    #160824-00007#172 Add By Ken 161107
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtia043
            #add-point:BEFORE FIELD rtia043 name="construct.b.rtia043"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtia043
            
            #add-point:AFTER FIELD rtia043 name="construct.a.rtia043"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.rtia043
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtia043
            #add-point:ON ACTION controlp INFIELD rtia043 name="construct.c.rtia043"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtia047
            #add-point:BEFORE FIELD rtia047 name="construct.b.rtia047"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtia047
            
            #add-point:AFTER FIELD rtia047 name="construct.a.rtia047"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.rtia047
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtia047
            #add-point:ON ACTION controlp INFIELD rtia047 name="construct.c.rtia047"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtia013
            #add-point:BEFORE FIELD rtia013 name="construct.b.rtia013"
                        
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtia013
            
            #add-point:AFTER FIELD rtia013 name="construct.a.rtia013"
                        
            #END add-point
            
 
 
         #Ctrlp:construct.c.rtia013
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtia013
            #add-point:ON ACTION controlp INFIELD rtia013 name="construct.c.rtia013"
                        
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtia014
            #add-point:BEFORE FIELD rtia014 name="construct.b.rtia014"
                        
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtia014
            
            #add-point:AFTER FIELD rtia014 name="construct.a.rtia014"
                        
            #END add-point
            
 
 
         #Ctrlp:construct.c.rtia014
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtia014
            #add-point:ON ACTION controlp INFIELD rtia014 name="construct.c.rtia014"
                        
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtia015
            #add-point:BEFORE FIELD rtia015 name="construct.b.rtia015"
                        
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtia015
            
            #add-point:AFTER FIELD rtia015 name="construct.a.rtia015"
                        
            #END add-point
            
 
 
         #Ctrlp:construct.c.rtia015
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtia015
            #add-point:ON ACTION controlp INFIELD rtia015 name="construct.c.rtia015"
                        
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtia016
            #add-point:BEFORE FIELD rtia016 name="construct.b.rtia016"
                        
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtia016
            
            #add-point:AFTER FIELD rtia016 name="construct.a.rtia016"
                        
            #END add-point
            
 
 
         #Ctrlp:construct.c.rtia016
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtia016
            #add-point:ON ACTION controlp INFIELD rtia016 name="construct.c.rtia016"
                        
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtia051
            #add-point:BEFORE FIELD rtia051 name="construct.b.rtia051"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtia051
            
            #add-point:AFTER FIELD rtia051 name="construct.a.rtia051"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.rtia051
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtia051
            #add-point:ON ACTION controlp INFIELD rtia051 name="construct.c.rtia051"
            
            #END add-point
 
 
         #Ctrlp:construct.c.rtia010
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtia010
            #add-point:ON ACTION controlp INFIELD rtia010 name="construct.c.rtia010"
                                    #此段落由子樣板a08產生
            #開窗c段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			LET g_qryparam.reqry = FALSE
			LET g_qryparam.arg1 = "2"
            CALL q_pmaa001_9()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO rtia010  #顯示到畫面上

            NEXT FIELD rtia010                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtia010
            #add-point:BEFORE FIELD rtia010 name="construct.b.rtia010"
                        
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtia010
            
            #add-point:AFTER FIELD rtia010 name="construct.a.rtia010"
                        
            #END add-point
            
 
 
         #Ctrlp:construct.c.rtia011
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtia011
            #add-point:ON ACTION controlp INFIELD rtia011 name="construct.c.rtia011"
                                    #此段落由子樣板a08產生
            #開窗c段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			LET g_qryparam.reqry = FALSE
			LET g_qryparam.arg1 = "1"
            CALL q_pmaa001_9()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO rtia011  #顯示到畫面上

            NEXT FIELD rtia011                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtia011
            #add-point:BEFORE FIELD rtia011 name="construct.b.rtia011"
                        
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtia011
            
            #add-point:AFTER FIELD rtia011 name="construct.a.rtia011"
                        
            #END add-point
            
 
 
         #Ctrlp:construct.c.rtia012
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtia012
            #add-point:ON ACTION controlp INFIELD rtia012 name="construct.c.rtia012"
                                    #此段落由子樣板a08產生
            #開窗c段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.arg1 = "3"
			LET g_qryparam.reqry = FALSE
            CALL q_pmaa001_9()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO rtia012  #顯示到畫面上

            NEXT FIELD rtia012                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtia012
            #add-point:BEFORE FIELD rtia012 name="construct.b.rtia012"
                        
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtia012
            
            #add-point:AFTER FIELD rtia012 name="construct.a.rtia012"
                        
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD chantype
            #add-point:BEFORE FIELD chantype name="construct.b.chantype"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD chantype
            
            #add-point:AFTER FIELD chantype name="construct.a.chantype"
          
            #END add-point
            
 
 
         #Ctrlp:construct.c.chantype
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD chantype
            #add-point:ON ACTION controlp INFIELD chantype name="construct.c.chantype"
            
            #END add-point
 
 
         #Ctrlp:construct.c.barcode
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD barcode
            #add-point:ON ACTION controlp INFIELD barcode name="construct.c.barcode"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_imay003_2()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO barcode  #顯示到畫面上
            NEXT FIELD barcode                     #返回原欄位
    



            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD barcode
            #add-point:BEFORE FIELD barcode name="construct.b.barcode"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD barcode
            
            #add-point:AFTER FIELD barcode name="construct.a.barcode"
         
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtia041
            #add-point:BEFORE FIELD rtia041 name="construct.b.rtia041"
                        
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtia041
            
            #add-point:AFTER FIELD rtia041 name="construct.a.rtia041"
                        
            #END add-point
            
 
 
         #Ctrlp:construct.c.rtia041
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtia041
            #add-point:ON ACTION controlp INFIELD rtia041 name="construct.c.rtia041"
                        
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtia017
            #add-point:BEFORE FIELD rtia017 name="construct.b.rtia017"
                        
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtia017
            
            #add-point:AFTER FIELD rtia017 name="construct.a.rtia017"
                        
            #END add-point
            
 
 
         #Ctrlp:construct.c.rtia017
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtia017
            #add-point:ON ACTION controlp INFIELD rtia017 name="construct.c.rtia017"
                        
            #END add-point
 
 
         #Ctrlp:construct.c.rtia018
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtia018
            #add-point:ON ACTION controlp INFIELD rtia018 name="construct.c.rtia018"
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			   LET g_qryparam.reqry = FALSE
#            CALL q_ooef001()
            IF s_aooi500_setpoint(g_prog,'rtia018') THEN
               LET g_qryparam.where = s_aooi500_q_where(g_prog,'rtia018',g_site,'c')   #150308-00001#5  By benson add 'c'
               CALL q_ooef001_24()
            ELSE
               CALL q_ooef001()  
            END IF
            DISPLAY g_qryparam.return1 TO rtia018      
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtia018
            #add-point:BEFORE FIELD rtia018 name="construct.b.rtia018"
                        
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtia018
            
            #add-point:AFTER FIELD rtia018 name="construct.a.rtia018"
                        
            #END add-point
            
 
 
         #Ctrlp:construct.c.rtia019
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtia019
            #add-point:ON ACTION controlp INFIELD rtia019 name="construct.c.rtia019"
                        	        INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_oocn002()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO rtia019      #顯示到畫面上
            NEXT FIELD rtia019
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtia019
            #add-point:BEFORE FIELD rtia019 name="construct.b.rtia019"
                        
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtia019
            
            #add-point:AFTER FIELD rtia019 name="construct.a.rtia019"
                        
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtia020
            #add-point:BEFORE FIELD rtia020 name="construct.b.rtia020"
                        
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtia020
            
            #add-point:AFTER FIELD rtia020 name="construct.a.rtia020"
                        
            #END add-point
            
 
 
         #Ctrlp:construct.c.rtia020
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtia020
            #add-point:ON ACTION controlp INFIELD rtia020 name="construct.c.rtia020"
                        
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtia021
            #add-point:BEFORE FIELD rtia021 name="construct.b.rtia021"
                        
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtia021
            
            #add-point:AFTER FIELD rtia021 name="construct.a.rtia021"
                        
            #END add-point
            
 
 
         #Ctrlp:construct.c.rtia021
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtia021
            #add-point:ON ACTION controlp INFIELD rtia021 name="construct.c.rtia021"
                        
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtia022
            #add-point:BEFORE FIELD rtia022 name="construct.b.rtia022"
                        
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtia022
            
            #add-point:AFTER FIELD rtia022 name="construct.a.rtia022"
                        
            #END add-point
            
 
 
         #Ctrlp:construct.c.rtia022
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtia022
            #add-point:ON ACTION controlp INFIELD rtia022 name="construct.c.rtia022"
                        
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtia023
            #add-point:BEFORE FIELD rtia023 name="construct.b.rtia023"
                        
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtia023
            
            #add-point:AFTER FIELD rtia023 name="construct.a.rtia023"
                        
            #END add-point
            
 
 
         #Ctrlp:construct.c.rtia023
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtia023
            #add-point:ON ACTION controlp INFIELD rtia023 name="construct.c.rtia023"
                        
            #END add-point
 
 
         #Ctrlp:construct.c.rtia024
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtia024
            #add-point:ON ACTION controlp INFIELD rtia024 name="construct.c.rtia024"
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			   LET g_qryparam.reqry = FALSE
#            CALL q_ooef001()
            IF s_aooi500_setpoint(g_prog,'rtia024') THEN
               LET g_qryparam.where = s_aooi500_q_where(g_prog,'rtia024',g_site,'c')   #150308-00001#5  By benson add 'c'
               CALL q_ooef001_24()
            ELSE
               CALL q_ooef001()  
            END IF
            DISPLAY g_qryparam.return1 TO rtia024      
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtia024
            #add-point:BEFORE FIELD rtia024 name="construct.b.rtia024"
                        
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtia024
            
            #add-point:AFTER FIELD rtia024 name="construct.a.rtia024"
                        
            #END add-point
            
 
 
         #Ctrlp:construct.c.rtia025
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtia025
            #add-point:ON ACTION controlp INFIELD rtia025 name="construct.c.rtia025"
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			LET g_qryparam.reqry = FALSE
            CALL q_rtia025()
            DISPLAY g_qryparam.return1 TO rtia025 
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtia025
            #add-point:BEFORE FIELD rtia025 name="construct.b.rtia025"
                        
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtia025
            
            #add-point:AFTER FIELD rtia025 name="construct.a.rtia025"
                        
            #END add-point
            
 
 
         #Ctrlp:construct.c.rtia026
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtia026
            #add-point:ON ACTION controlp INFIELD rtia026 name="construct.c.rtia026"
                        			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			LET g_qryparam.reqry = FALSE
            CALL q_ooaj002_2()                       #呼叫開窗
            DISPLAY g_qryparam.return1 TO rtia026  #顯示到畫面上
            NEXT FIELD rtia026   
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtia026
            #add-point:BEFORE FIELD rtia026 name="construct.b.rtia026"
                        
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtia026
            
            #add-point:AFTER FIELD rtia026 name="construct.a.rtia026"
                        
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtia027
            #add-point:BEFORE FIELD rtia027 name="construct.b.rtia027"
                        
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtia027
            
            #add-point:AFTER FIELD rtia027 name="construct.a.rtia027"
                        
            #END add-point
            
 
 
         #Ctrlp:construct.c.rtia027
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtia027
            #add-point:ON ACTION controlp INFIELD rtia027 name="construct.c.rtia027"
                        
            #END add-point
 
 
         #Ctrlp:construct.c.rtia028
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtia028
            #add-point:ON ACTION controlp INFIELD rtia028 name="construct.c.rtia028"
            ### 客戶對象慣用交易稅別### start ###
            INITIALIZE g_qryparam.* TO NULL 
            LET g_qryparam.state = "c"
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.where = "1=1"
            LET g_qryparam.arg1 = g_site
            CALL q_oodb002_10()
            DISPLAY g_qryparam.return1  TO rtia028
            ### 客戶對象慣用交易稅別### end ###
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtia028
            #add-point:BEFORE FIELD rtia028 name="construct.b.rtia028"
                        
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtia028
            
            #add-point:AFTER FIELD rtia028 name="construct.a.rtia028"
                        
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtia029
            #add-point:BEFORE FIELD rtia029 name="construct.b.rtia029"
                        
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtia029
            
            #add-point:AFTER FIELD rtia029 name="construct.a.rtia029"
                        
            #END add-point
            
 
 
         #Ctrlp:construct.c.rtia029
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtia029
            #add-point:ON ACTION controlp INFIELD rtia029 name="construct.c.rtia029"
                        
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtia030
            #add-point:BEFORE FIELD rtia030 name="construct.b.rtia030"
                        
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtia030
            
            #add-point:AFTER FIELD rtia030 name="construct.a.rtia030"
                        
            #END add-point
            
 
 
         #Ctrlp:construct.c.rtia030
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtia030
            #add-point:ON ACTION controlp INFIELD rtia030 name="construct.c.rtia030"
                        
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtia032
            #add-point:BEFORE FIELD rtia032 name="construct.b.rtia032"
                        
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtia032
            
            #add-point:AFTER FIELD rtia032 name="construct.a.rtia032"
                        
            #END add-point
            
 
 
         #Ctrlp:construct.c.rtia032
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtia032
            #add-point:ON ACTION controlp INFIELD rtia032 name="construct.c.rtia032"
                        
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtia033
            #add-point:BEFORE FIELD rtia033 name="construct.b.rtia033"
                        
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtia033
            
            #add-point:AFTER FIELD rtia033 name="construct.a.rtia033"
                        
            #END add-point
            
 
 
         #Ctrlp:construct.c.rtia033
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtia033
            #add-point:ON ACTION controlp INFIELD rtia033 name="construct.c.rtia033"
                                    #開窗c段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			LET g_qryparam.reqry = FALSE
			LET g_qryparam.where = " rtia000 = '",g_prog,"'"
            CALL q_rtia033()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO rtia033      #顯示到畫面上
            NEXT FIELD rtia033
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtia034
            #add-point:BEFORE FIELD rtia034 name="construct.b.rtia034"
                        
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtia034
            
            #add-point:AFTER FIELD rtia034 name="construct.a.rtia034"
                        
            #END add-point
            
 
 
         #Ctrlp:construct.c.rtia034
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtia034
            #add-point:ON ACTION controlp INFIELD rtia034 name="construct.c.rtia034"
                        
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtia035
            #add-point:BEFORE FIELD rtia035 name="construct.b.rtia035"
                        
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtia035
            
            #add-point:AFTER FIELD rtia035 name="construct.a.rtia035"
                        
            #END add-point
            
 
 
         #Ctrlp:construct.c.rtia035
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtia035
            #add-point:ON ACTION controlp INFIELD rtia035 name="construct.c.rtia035"
                        
            #END add-point
 
 
         #Ctrlp:construct.c.rtia036
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtia036
            #add-point:ON ACTION controlp INFIELD rtia036 name="construct.c.rtia036"
                                    ### 收銀機號開窗### start ###
            INITIALIZE g_qryparam.* TO NULL 
            LET g_qryparam.state = "c"
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.where = "1=1"
            CALL q_pcaa001_1()
            DISPLAY g_qryparam.return1 TO rtia036
            ### 收銀機號開窗### end ###

            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtia036
            #add-point:BEFORE FIELD rtia036 name="construct.b.rtia036"
                        
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtia036
            
            #add-point:AFTER FIELD rtia036 name="construct.a.rtia036"
                        
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtia037
            #add-point:BEFORE FIELD rtia037 name="construct.b.rtia037"
                        
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtia037
            
            #add-point:AFTER FIELD rtia037 name="construct.a.rtia037"
                        
            #END add-point
            
 
 
         #Ctrlp:construct.c.rtia037
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtia037
            #add-point:ON ACTION controlp INFIELD rtia037 name="construct.c.rtia037"
                                    #此段落由子樣板a08產生
            #開窗c段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			   LET g_qryparam.reqry = FALSE
            CALL q_pcab001_1()                            #呼叫開窗
            DISPLAY g_qryparam.return1 TO rtia037  #顯示到畫面上

            NEXT FIELD rtia037    
            #END add-point
 
 
         #Ctrlp:construct.c.rtia038
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtia038
            #add-point:ON ACTION controlp INFIELD rtia038 name="construct.c.rtia038"
            ### 班別編號開窗### start ###
            INITIALIZE g_qryparam.* TO NULL 
            LET g_qryparam.state = "c"
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.where = "1=1"
            CALL q_oogd001_01()
            DISPLAY g_qryparam.return1 TO rtia038
            ### 班別編號開窗### end ###
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtia038
            #add-point:BEFORE FIELD rtia038 name="construct.b.rtia038"
 
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtia038
            
            #add-point:AFTER FIELD rtia038 name="construct.a.rtia038"
                        
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtia039
            #add-point:BEFORE FIELD rtia039 name="construct.b.rtia039"
                        
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtia039
            
            #add-point:AFTER FIELD rtia039 name="construct.a.rtia039"
                        
            #END add-point
            
 
 
         #Ctrlp:construct.c.rtia039
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtia039
            #add-point:ON ACTION controlp INFIELD rtia039 name="construct.c.rtia039"
                        
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtia107
            #add-point:BEFORE FIELD rtia107 name="construct.b.rtia107"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtia107
            
            #add-point:AFTER FIELD rtia107 name="construct.a.rtia107"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.rtia107
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtia107
            #add-point:ON ACTION controlp INFIELD rtia107 name="construct.c.rtia107"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD isaf009
            #add-point:BEFORE FIELD isaf009 name="construct.b.isaf009"
                        
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD isaf009
            
            #add-point:AFTER FIELD isaf009 name="construct.a.isaf009"
                        
            #END add-point
            
 
 
         #Ctrlp:construct.c.isaf009
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD isaf009
            #add-point:ON ACTION controlp INFIELD isaf009 name="construct.c.isaf009"
                        
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD isaf010
            #add-point:BEFORE FIELD isaf010 name="construct.b.isaf010"
                        
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD isaf010
            
            #add-point:AFTER FIELD isaf010 name="construct.a.isaf010"
                        
            #END add-point
            
 
 
         #Ctrlp:construct.c.isaf010
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD isaf010
            #add-point:ON ACTION controlp INFIELD isaf010 name="construct.c.isaf010"
                        
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD isaf044
            #add-point:BEFORE FIELD isaf044 name="construct.b.isaf044"
                        
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD isaf044
            
            #add-point:AFTER FIELD isaf044 name="construct.a.isaf044"
                        
            #END add-point
            
 
 
         #Ctrlp:construct.c.isaf044
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD isaf044
            #add-point:ON ACTION controlp INFIELD isaf044 name="construct.c.isaf044"
                        
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD isaf202
            #add-point:BEFORE FIELD isaf202 name="construct.b.isaf202"
                        
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD isaf202
            
            #add-point:AFTER FIELD isaf202 name="construct.a.isaf202"
                        
            #END add-point
            
 
 
         #Ctrlp:construct.c.isaf202
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD isaf202
            #add-point:ON ACTION controlp INFIELD isaf202 name="construct.c.isaf202"
                        
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD isaf203
            #add-point:BEFORE FIELD isaf203 name="construct.b.isaf203"
                        
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD isaf203
            
            #add-point:AFTER FIELD isaf203 name="construct.a.isaf203"
                        
            #END add-point
            
 
 
         #Ctrlp:construct.c.isaf203
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD isaf203
            #add-point:ON ACTION controlp INFIELD isaf203 name="construct.c.isaf203"
                        
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD isaf204
            #add-point:BEFORE FIELD isaf204 name="construct.b.isaf204"
                        
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD isaf204
            
            #add-point:AFTER FIELD isaf204 name="construct.a.isaf204"
                        
            #END add-point
            
 
 
         #Ctrlp:construct.c.isaf204
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD isaf204
            #add-point:ON ACTION controlp INFIELD isaf204 name="construct.c.isaf204"
                        
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD isaf201
            #add-point:BEFORE FIELD isaf201 name="construct.b.isaf201"
                        
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD isaf201
            
            #add-point:AFTER FIELD isaf201 name="construct.a.isaf201"
                        
            #END add-point
            
 
 
         #Ctrlp:construct.c.isaf201
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD isaf201
            #add-point:ON ACTION controlp INFIELD isaf201 name="construct.c.isaf201"
                        
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD isaf207
            #add-point:BEFORE FIELD isaf207 name="construct.b.isaf207"
                        
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD isaf207
            
            #add-point:AFTER FIELD isaf207 name="construct.a.isaf207"
                        
            #END add-point
            
 
 
         #Ctrlp:construct.c.isaf207
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD isaf207
            #add-point:ON ACTION controlp INFIELD isaf207 name="construct.c.isaf207"
                        
            #END add-point
 
 
         #Ctrlp:construct.c.rtiaownid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtiaownid
            #add-point:ON ACTION controlp INFIELD rtiaownid name="construct.c.rtiaownid"
                                    #此段落由子樣板a08產生
            #開窗c段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO rtiaownid  #顯示到畫面上

            NEXT FIELD rtiaownid                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtiaownid
            #add-point:BEFORE FIELD rtiaownid name="construct.b.rtiaownid"
                        
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtiaownid
            
            #add-point:AFTER FIELD rtiaownid name="construct.a.rtiaownid"
                        
            #END add-point
            
 
 
         #Ctrlp:construct.c.rtiacrtid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtiacrtid
            #add-point:ON ACTION controlp INFIELD rtiacrtid name="construct.c.rtiacrtid"
                                    #此段落由子樣板a08產生
            #開窗c段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO rtiacrtid  #顯示到畫面上

            NEXT FIELD rtiacrtid                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtiacrtid
            #add-point:BEFORE FIELD rtiacrtid name="construct.b.rtiacrtid"
                        
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtiacrtid
            
            #add-point:AFTER FIELD rtiacrtid name="construct.a.rtiacrtid"
                        
            #END add-point
            
 
 
         #Ctrlp:construct.c.rtiaowndp
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtiaowndp
            #add-point:ON ACTION controlp INFIELD rtiaowndp name="construct.c.rtiaowndp"
                                    #此段落由子樣板a08產生
            #開窗c段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			LET g_qryparam.reqry = FALSE
            CALL q_ooeg001_9()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO rtiaowndp  #顯示到畫面上

            NEXT FIELD rtiaowndp                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtiaowndp
            #add-point:BEFORE FIELD rtiaowndp name="construct.b.rtiaowndp"
                        
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtiaowndp
            
            #add-point:AFTER FIELD rtiaowndp name="construct.a.rtiaowndp"
                        
            #END add-point
            
 
 
         #Ctrlp:construct.c.rtiacrtdp
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtiacrtdp
            #add-point:ON ACTION controlp INFIELD rtiacrtdp name="construct.c.rtiacrtdp"
                                    #此段落由子樣板a08產生
            #開窗c段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			LET g_qryparam.reqry = FALSE
            CALL q_ooeg001_9()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO rtiacrtdp  #顯示到畫面上

            NEXT FIELD rtiacrtdp                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtiacrtdp
            #add-point:BEFORE FIELD rtiacrtdp name="construct.b.rtiacrtdp"
                        
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtiacrtdp
            
            #add-point:AFTER FIELD rtiacrtdp name="construct.a.rtiacrtdp"
                        
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtiacrtdt
            #add-point:BEFORE FIELD rtiacrtdt name="construct.b.rtiacrtdt"
                        
            #END add-point
 
 
         #Ctrlp:construct.c.rtiamodid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtiamodid
            #add-point:ON ACTION controlp INFIELD rtiamodid name="construct.c.rtiamodid"
                                    #此段落由子樣板a08產生
            #開窗c段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO rtiamodid  #顯示到畫面上

            NEXT FIELD rtiamodid                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtiamodid
            #add-point:BEFORE FIELD rtiamodid name="construct.b.rtiamodid"
                        
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtiamodid
            
            #add-point:AFTER FIELD rtiamodid name="construct.a.rtiamodid"
                        
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtiamoddt
            #add-point:BEFORE FIELD rtiamoddt name="construct.b.rtiamoddt"
                        
            #END add-point
 
 
         #Ctrlp:construct.c.rtiacnfid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtiacnfid
            #add-point:ON ACTION controlp INFIELD rtiacnfid name="construct.c.rtiacnfid"
                                    #此段落由子樣板a08產生
            #開窗c段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO rtiacnfid  #顯示到畫面上

            NEXT FIELD rtiacnfid                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtiacnfid
            #add-point:BEFORE FIELD rtiacnfid name="construct.b.rtiacnfid"
                        
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtiacnfid
            
            #add-point:AFTER FIELD rtiacnfid name="construct.a.rtiacnfid"
                        
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtiacnfdt
            #add-point:BEFORE FIELD rtiacnfdt name="construct.b.rtiacnfdt"
                        
            #END add-point
 
 
         #Ctrlp:construct.c.rtiapstid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtiapstid
            #add-point:ON ACTION controlp INFIELD rtiapstid name="construct.c.rtiapstid"
                                    #此段落由子樣板a08產生
            #開窗c段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO rtiapstid  #顯示到畫面上

            NEXT FIELD rtiapstid                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtiapstid
            #add-point:BEFORE FIELD rtiapstid name="construct.b.rtiapstid"
                        
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtiapstid
            
            #add-point:AFTER FIELD rtiapstid name="construct.a.rtiapstid"
                        
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtiapstdt
            #add-point:BEFORE FIELD rtiapstdt name="construct.b.rtiapstdt"
                        
            #END add-point
 
 
 
         
      END CONSTRUCT
 
      #單身根據table分拆construct
      CONSTRUCT g_wc2_table1 ON rtibsite,rtibunit,rtiborga,rtibseq,rtib035,rtib042,rtib001,rtib002,rtib003, 
          rtib004,rtib005,rtib106,rtib012,rtib108,rtib013,rtib107,rtib008,rtib009,rtib010,rtib014,rtib015, 
          rtib016,rtib018,rtib017,rtib019,rtib020,rtib021,rtib022,rtib024,rtib025,rtib026,rtib027,rtib032, 
          rtib033,rtib028,rtib030,rtib039,rtib006
           FROM s_detail1[1].rtibsite,s_detail1[1].rtibunit,s_detail1[1].rtiborga,s_detail1[1].rtibseq, 
               s_detail1[1].rtib035,s_detail1[1].rtib042,s_detail1[1].rtib001,s_detail1[1].rtib002,s_detail1[1].rtib003, 
               s_detail1[1].rtib004,s_detail1[1].rtib005,s_detail1[1].rtib106,s_detail1[1].rtib012,s_detail1[1].rtib108, 
               s_detail1[1].rtib013,s_detail1[1].rtib107,s_detail1[1].rtib008,s_detail1[1].rtib009,s_detail1[1].rtib010, 
               s_detail1[1].rtib014,s_detail1[1].rtib015,s_detail1[1].rtib016,s_detail1[1].rtib018,s_detail1[1].rtib017, 
               s_detail1[1].rtib019,s_detail1[1].rtib020,s_detail1[1].rtib021,s_detail1[1].rtib022,s_detail1[1].rtib024, 
               s_detail1[1].rtib025,s_detail1[1].rtib026,s_detail1[1].rtib027,s_detail1[1].rtib032,s_detail1[1].rtib033, 
               s_detail1[1].rtib028,s_detail1[1].rtib030,s_detail1[1].rtib039,s_detail1[1].rtib006
                      
         BEFORE CONSTRUCT
            #add-point:cs段before_construct name="cs.body.before_construct"
                        
            #end add-point 
            
       #單身公用欄位開窗相關處理
       
         
       #單身一般欄位開窗相關處理
                #Ctrlp:construct.c.page1.rtibsite
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtibsite
            #add-point:ON ACTION controlp INFIELD rtibsite name="construct.c.page1.rtibsite"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooed004_3()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO rtibsite  #顯示到畫面上
            NEXT FIELD rtibsite                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtibsite
            #add-point:BEFORE FIELD rtibsite name="construct.b.page1.rtibsite"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtibsite
            
            #add-point:AFTER FIELD rtibsite name="construct.a.page1.rtibsite"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtibunit
            #add-point:BEFORE FIELD rtibunit name="construct.b.page1.rtibunit"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtibunit
            
            #add-point:AFTER FIELD rtibunit name="construct.a.page1.rtibunit"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.rtibunit
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtibunit
            #add-point:ON ACTION controlp INFIELD rtibunit name="construct.c.page1.rtibunit"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtiborga
            #add-point:BEFORE FIELD rtiborga name="construct.b.page1.rtiborga"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtiborga
            
            #add-point:AFTER FIELD rtiborga name="construct.a.page1.rtiborga"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.rtiborga
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtiborga
            #add-point:ON ACTION controlp INFIELD rtiborga name="construct.c.page1.rtiborga"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtibseq
            #add-point:BEFORE FIELD rtibseq name="construct.b.page1.rtibseq"
                        
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtibseq
            
            #add-point:AFTER FIELD rtibseq name="construct.a.page1.rtibseq"
                        
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.rtibseq
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtibseq
            #add-point:ON ACTION controlp INFIELD rtibseq name="construct.c.page1.rtibseq"
                        
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtib035
            #add-point:BEFORE FIELD rtib035 name="construct.b.page1.rtib035"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtib035
            
            #add-point:AFTER FIELD rtib035 name="construct.a.page1.rtib035"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.rtib035
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtib035
            #add-point:ON ACTION controlp INFIELD rtib035 name="construct.c.page1.rtib035"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtib042
            #add-point:BEFORE FIELD rtib042 name="construct.b.page1.rtib042"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtib042
            
            #add-point:AFTER FIELD rtib042 name="construct.a.page1.rtib042"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.rtib042
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtib042
            #add-point:ON ACTION controlp INFIELD rtib042 name="construct.c.page1.rtib042"
            
            #END add-point
 
 
         #Ctrlp:construct.c.page1.rtib001
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtib001
            #add-point:ON ACTION controlp INFIELD rtib001 name="construct.c.page1.rtib001"
#            INITIALIZE g_qryparam.* TO NULL 
#            LET g_qryparam.state = "c"
#            LET g_qryparam.reqry = FALSE
#            LET g_qryparam.where = "1=1"
#            CALL q_rtib001()
#            DISPLAY g_qryparam.return1 TO rtib001
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtib001
            #add-point:BEFORE FIELD rtib001 name="construct.b.page1.rtib001"
                        
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtib001
            
            #add-point:AFTER FIELD rtib001 name="construct.a.page1.rtib001"
                        
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtib002
            #add-point:BEFORE FIELD rtib002 name="construct.b.page1.rtib002"
                        
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtib002
            
            #add-point:AFTER FIELD rtib002 name="construct.a.page1.rtib002"
                        
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.rtib002
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtib002
            #add-point:ON ACTION controlp INFIELD rtib002 name="construct.c.page1.rtib002"
                        
            #END add-point
 
 
         #Ctrlp:construct.c.page1.rtib003
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtib003
            #add-point:ON ACTION controlp INFIELD rtib003 name="construct.c.page1.rtib003"
                        ### 商品條碼### start ###
            INITIALIZE g_qryparam.* TO NULL 
            LET g_qryparam.state = "c"
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.where = "1=1"
            CALL q_imay003_8()
            DISPLAY g_qryparam.return1 TO rtib003
            ### 商品條碼### end ###

            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtib003
            #add-point:BEFORE FIELD rtib003 name="construct.b.page1.rtib003"
                        
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtib003
            
            #add-point:AFTER FIELD rtib003 name="construct.a.page1.rtib003"
                        
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.rtib004
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtib004
            #add-point:ON ACTION controlp INFIELD rtib004 name="construct.c.page1.rtib004"
                                    ### 商品編號### start ###
            INITIALIZE g_qryparam.* TO NULL 
            LET g_qryparam.state = "c"
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.where = "1=1"
            LET g_qryparam.arg1 = g_rtia_m.rtiasite
            CALL q_rtdx001_1()
            DISPLAY g_qryparam.return1 TO rtib004
            ### 商品編號### end ###

            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtib004
            #add-point:BEFORE FIELD rtib004 name="construct.b.page1.rtib004"
                        
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtib004
            
            #add-point:AFTER FIELD rtib004 name="construct.a.page1.rtib004"
                        
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtib005
            #add-point:BEFORE FIELD rtib005 name="construct.b.page1.rtib005"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtib005
            
            #add-point:AFTER FIELD rtib005 name="construct.a.page1.rtib005"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.rtib005
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtib005
            #add-point:ON ACTION controlp INFIELD rtib005 name="construct.c.page1.rtib005"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtib106
            #add-point:BEFORE FIELD rtib106 name="construct.b.page1.rtib106"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtib106
            
            #add-point:AFTER FIELD rtib106 name="construct.a.page1.rtib106"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.rtib106
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtib106
            #add-point:ON ACTION controlp INFIELD rtib106 name="construct.c.page1.rtib106"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtib012
            #add-point:BEFORE FIELD rtib012 name="construct.b.page1.rtib012"
                        
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtib012
            
            #add-point:AFTER FIELD rtib012 name="construct.a.page1.rtib012"
                        
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.rtib012
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtib012
            #add-point:ON ACTION controlp INFIELD rtib012 name="construct.c.page1.rtib012"
                        
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtib108
            #add-point:BEFORE FIELD rtib108 name="construct.b.page1.rtib108"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtib108
            
            #add-point:AFTER FIELD rtib108 name="construct.a.page1.rtib108"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.rtib108
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtib108
            #add-point:ON ACTION controlp INFIELD rtib108 name="construct.c.page1.rtib108"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtib013
            #add-point:BEFORE FIELD rtib013 name="construct.b.page1.rtib013"
                        
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtib013
            
            #add-point:AFTER FIELD rtib013 name="construct.a.page1.rtib013"
                        
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.rtib013
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtib013
            #add-point:ON ACTION controlp INFIELD rtib013 name="construct.c.page1.rtib013"
                        
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtib107
            #add-point:BEFORE FIELD rtib107 name="construct.b.page1.rtib107"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtib107
            
            #add-point:AFTER FIELD rtib107 name="construct.a.page1.rtib107"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.rtib107
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtib107
            #add-point:ON ACTION controlp INFIELD rtib107 name="construct.c.page1.rtib107"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtib008
            #add-point:BEFORE FIELD rtib008 name="construct.b.page1.rtib008"
                        
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtib008
            
            #add-point:AFTER FIELD rtib008 name="construct.a.page1.rtib008"
                        
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.rtib008
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtib008
            #add-point:ON ACTION controlp INFIELD rtib008 name="construct.c.page1.rtib008"
                        
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtib009
            #add-point:BEFORE FIELD rtib009 name="construct.b.page1.rtib009"
                        
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtib009
            
            #add-point:AFTER FIELD rtib009 name="construct.a.page1.rtib009"
                        
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.rtib009
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtib009
            #add-point:ON ACTION controlp INFIELD rtib009 name="construct.c.page1.rtib009"
                        
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtib010
            #add-point:BEFORE FIELD rtib010 name="construct.b.page1.rtib010"
                        
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtib010
            
            #add-point:AFTER FIELD rtib010 name="construct.a.page1.rtib010"
                        
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.rtib010
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtib010
            #add-point:ON ACTION controlp INFIELD rtib010 name="construct.c.page1.rtib010"
                        
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtib014
            #add-point:BEFORE FIELD rtib014 name="construct.b.page1.rtib014"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtib014
            
            #add-point:AFTER FIELD rtib014 name="construct.a.page1.rtib014"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.rtib014
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtib014
            #add-point:ON ACTION controlp INFIELD rtib014 name="construct.c.page1.rtib014"
            
            #END add-point
 
 
         #Ctrlp:construct.c.page1.rtib015
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtib015
            #add-point:ON ACTION controlp INFIELD rtib015 name="construct.c.page1.rtib015"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooca001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO rtib015  #顯示到畫面上
            NEXT FIELD rtib015                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtib015
            #add-point:BEFORE FIELD rtib015 name="construct.b.page1.rtib015"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtib015
            
            #add-point:AFTER FIELD rtib015 name="construct.a.page1.rtib015"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtib016
            #add-point:BEFORE FIELD rtib016 name="construct.b.page1.rtib016"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtib016
            
            #add-point:AFTER FIELD rtib016 name="construct.a.page1.rtib016"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.rtib016
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtib016
            #add-point:ON ACTION controlp INFIELD rtib016 name="construct.c.page1.rtib016"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtib018
            #add-point:BEFORE FIELD rtib018 name="construct.b.page1.rtib018"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtib018
            
            #add-point:AFTER FIELD rtib018 name="construct.a.page1.rtib018"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.rtib018
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtib018
            #add-point:ON ACTION controlp INFIELD rtib018 name="construct.c.page1.rtib018"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtib017
            #add-point:BEFORE FIELD rtib017 name="construct.b.page1.rtib017"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtib017
            
            #add-point:AFTER FIELD rtib017 name="construct.a.page1.rtib017"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.rtib017
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtib017
            #add-point:ON ACTION controlp INFIELD rtib017 name="construct.c.page1.rtib017"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtib019
            #add-point:BEFORE FIELD rtib019 name="construct.b.page1.rtib019"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtib019
            
            #add-point:AFTER FIELD rtib019 name="construct.a.page1.rtib019"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.rtib019
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtib019
            #add-point:ON ACTION controlp INFIELD rtib019 name="construct.c.page1.rtib019"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtib020
            #add-point:BEFORE FIELD rtib020 name="construct.b.page1.rtib020"
                        
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtib020
            
            #add-point:AFTER FIELD rtib020 name="construct.a.page1.rtib020"
                        
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.rtib020
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtib020
            #add-point:ON ACTION controlp INFIELD rtib020 name="construct.c.page1.rtib020"
                        
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtib021
            #add-point:BEFORE FIELD rtib021 name="construct.b.page1.rtib021"
                        
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtib021
            
            #add-point:AFTER FIELD rtib021 name="construct.a.page1.rtib021"
                        
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.rtib021
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtib021
            #add-point:ON ACTION controlp INFIELD rtib021 name="construct.c.page1.rtib021"
                        
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtib022
            #add-point:BEFORE FIELD rtib022 name="construct.b.page1.rtib022"
                        
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtib022
            
            #add-point:AFTER FIELD rtib022 name="construct.a.page1.rtib022"
                        
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.rtib022
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtib022
            #add-point:ON ACTION controlp INFIELD rtib022 name="construct.c.page1.rtib022"
                        
            #END add-point
 
 
         #Ctrlp:construct.c.page1.rtib024
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtib024
            #add-point:ON ACTION controlp INFIELD rtib024 name="construct.c.page1.rtib024"
                                    ### 應用分類碼開窗### start ###
            INITIALIZE g_qryparam.* TO NULL 
            LET g_qryparam.state = "c"
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.where = "1=1"
            LET g_qryparam.arg1 = "278"
            CALL q_oocq002()
            DISPLAY g_qryparam.return1 TO rtib024
            ### 應用分類碼開窗### end ###
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtib024
            #add-point:BEFORE FIELD rtib024 name="construct.b.page1.rtib024"
                        
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtib024
            
            #add-point:AFTER FIELD rtib024 name="construct.a.page1.rtib024"
                        
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.rtib025
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtib025
            #add-point:ON ACTION controlp INFIELD rtib025 name="construct.c.page1.rtib025"
            INITIALIZE g_qryparam.* TO NULL 
            LET g_qryparam.state = "c"
            LET g_qryparam.reqry = FALSE
            #150324-00007#7 150507 by sakura modify---STR
            #LET g_qryparam.where = "1=1"
            #CALL q_inag004()
            CALL q_inaa001_2()
            #150324-00007#7 150507 by sakura modify---END
            DISPLAY g_qryparam.return1 TO rtib025
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtib025
            #add-point:BEFORE FIELD rtib025 name="construct.b.page1.rtib025"
                        
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtib025
            
            #add-point:AFTER FIELD rtib025 name="construct.a.page1.rtib025"
                        
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.rtib026
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtib026
            #add-point:ON ACTION controlp INFIELD rtib026 name="construct.c.page1.rtib026"
            INITIALIZE g_qryparam.* TO NULL 
            LET g_qryparam.state = "c"
            LET g_qryparam.reqry = FALSE
            #150324-00007#7 150507 by sakura modify---STR
            #LET g_qryparam.where = "1=1"
            #CALL q_inag005_3()
            CALL q_inab002_3()
            #150324-00007#7 150507 by sakura modify---END
            DISPLAY g_qryparam.return1 TO rtib026
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtib026
            #add-point:BEFORE FIELD rtib026 name="construct.b.page1.rtib026"
                        
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtib026
            
            #add-point:AFTER FIELD rtib026 name="construct.a.page1.rtib026"
                        
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtib027
            #add-point:BEFORE FIELD rtib027 name="construct.b.page1.rtib027"
                        
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtib027
            
            #add-point:AFTER FIELD rtib027 name="construct.a.page1.rtib027"
                        
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.rtib027
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtib027
            #add-point:ON ACTION controlp INFIELD rtib027 name="construct.c.page1.rtib027"
            #150324-00007#7 150507 by sakura modify---STR
            #INITIALIZE g_qryparam.* TO NULL 
            #LET g_qryparam.state = "c"
            #LET g_qryparam.reqry = FALSE
            #LET g_qryparam.where = "1=1"
            #CALL q_inag006()
            #DISPLAY g_qryparam.return1 TO rtib027
            #150324-00007#7 150507 by sakura modify---END
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtib032
            #add-point:BEFORE FIELD rtib032 name="construct.b.page1.rtib032"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtib032
            
            #add-point:AFTER FIELD rtib032 name="construct.a.page1.rtib032"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.rtib032
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtib032
            #add-point:ON ACTION controlp INFIELD rtib032 name="construct.c.page1.rtib032"
            
            #END add-point
 
 
         #Ctrlp:construct.c.page1.rtib033
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtib033
            #add-point:ON ACTION controlp INFIELD rtib033 name="construct.c.page1.rtib033"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.where = "pcab006 = '2' "
            CALL q_pcab001_2()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO rtib033  #顯示到畫面上
            NEXT FIELD rtib033                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtib033
            #add-point:BEFORE FIELD rtib033 name="construct.b.page1.rtib033"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtib033
            
            #add-point:AFTER FIELD rtib033 name="construct.a.page1.rtib033"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.rtib028
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtib028
            #add-point:ON ACTION controlp INFIELD rtib028 name="construct.c.page1.rtib028"
            ### 專櫃編號### start ###
            INITIALIZE g_qryparam.* TO NULL 
            LET g_qryparam.state = "c"
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.where = "1=1"
            CALL q_inaa120()
            DISPLAY g_qryparam.return1 TO rtib028
            ### 專櫃編號### end ###

            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtib028
            #add-point:BEFORE FIELD rtib028 name="construct.b.page1.rtib028"
                        
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtib028
            
            #add-point:AFTER FIELD rtib028 name="construct.a.page1.rtib028"
                        
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtib030
            #add-point:BEFORE FIELD rtib030 name="construct.b.page1.rtib030"
                        
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtib030
            
            #add-point:AFTER FIELD rtib030 name="construct.a.page1.rtib030"
                        
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.rtib030
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtib030
            #add-point:ON ACTION controlp INFIELD rtib030 name="construct.c.page1.rtib030"
                        
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtib039
            #add-point:BEFORE FIELD rtib039 name="construct.b.page1.rtib039"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtib039
            
            #add-point:AFTER FIELD rtib039 name="construct.a.page1.rtib039"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.rtib039
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtib039
            #add-point:ON ACTION controlp INFIELD rtib039 name="construct.c.page1.rtib039"
            
            #END add-point
 
 
         #Ctrlp:construct.c.page1.rtib006
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtib006
            #add-point:ON ACTION controlp INFIELD rtib006 name="construct.c.page1.rtib006"
                                    ### 銷項稅目### start ###
            INITIALIZE g_qryparam.* TO NULL 
            LET g_qryparam.state = "c"
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.where = "1=1"
            SELECT ooef019 INTO l_ooef019
              FROM ooef_t
             WHERE ooefent = g_enterprise
               AND ooef001 = g_rtia_m.rtiasite
            LET g_qryparam.arg1 = l_ooef019
            CALL q_rtdx014()
            DISPLAY g_qryparam.return1 TO rtib006
            ### 銷項稅目### end ###

            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtib006
            #add-point:BEFORE FIELD rtib006 name="construct.b.page1.rtib006"
                        
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtib006
            
            #add-point:AFTER FIELD rtib006 name="construct.a.page1.rtib006"
                        
            #END add-point
            
 
 
   
       
      END CONSTRUCT
      
      CONSTRUCT g_wc2_table2 ON rticseq,rticseq1,rtic001,rtic002,rtic003,rtic004,rtic005,rtic006,rtic007, 
          rtic008,rtic009,rtic010,rtic011,rtic012,rtic013,rtic014,rtic015,rtic016,rtic017,rtic018,rtic020 
 
           FROM s_detail2[1].rticseq,s_detail2[1].rticseq1,s_detail2[1].rtic001,s_detail2[1].rtic002, 
               s_detail2[1].rtic003,s_detail2[1].rtic004,s_detail2[1].rtic005,s_detail2[1].rtic006,s_detail2[1].rtic007, 
               s_detail2[1].rtic008,s_detail2[1].rtic009,s_detail2[1].rtic010,s_detail2[1].rtic011,s_detail2[1].rtic012, 
               s_detail2[1].rtic013,s_detail2[1].rtic014,s_detail2[1].rtic015,s_detail2[1].rtic016,s_detail2[1].rtic017, 
               s_detail2[1].rtic018,s_detail2[1].rtic020
                      
         BEFORE CONSTRUCT
            #add-point:cs段before_construct name="cs.body2.before_construct"
 
            #end add-point 
            
       #單身公用欄位開窗相關處理(table 2)
       
       
       #單身一般欄位開窗相關處理       
                #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rticseq
            #add-point:BEFORE FIELD rticseq name="construct.b.page2.rticseq"
                        
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rticseq
            
            #add-point:AFTER FIELD rticseq name="construct.a.page2.rticseq"
                        
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.rticseq
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rticseq
            #add-point:ON ACTION controlp INFIELD rticseq name="construct.c.page2.rticseq"
                        
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rticseq1
            #add-point:BEFORE FIELD rticseq1 name="construct.b.page2.rticseq1"
                        
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rticseq1
            
            #add-point:AFTER FIELD rticseq1 name="construct.a.page2.rticseq1"
                        
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.rticseq1
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rticseq1
            #add-point:ON ACTION controlp INFIELD rticseq1 name="construct.c.page2.rticseq1"
                        
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtic001
            #add-point:BEFORE FIELD rtic001 name="construct.b.page2.rtic001"
                        
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtic001
            
            #add-point:AFTER FIELD rtic001 name="construct.a.page2.rtic001"
                        
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.rtic001
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtic001
            #add-point:ON ACTION controlp INFIELD rtic001 name="construct.c.page2.rtic001"
                INITIALIZE g_qryparam.* TO NULL 
                LET g_qryparam.state = "c"
                LET g_qryparam.reqry = FALSE
                LET g_qryparam.where = "1=1"
                CALL q_rtic001()
                DISPLAY g_qryparam.return1 TO rtic001
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtic002
            #add-point:BEFORE FIELD rtic002 name="construct.b.page2.rtic002"
                        
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtic002
            
            #add-point:AFTER FIELD rtic002 name="construct.a.page2.rtic002"
                        
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.rtic002
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtic002
            #add-point:ON ACTION controlp INFIELD rtic002 name="construct.c.page2.rtic002"
                INITIALIZE g_qryparam.* TO NULL 
                LET g_qryparam.state = "c"
                LET g_qryparam.reqry = FALSE
                LET g_qryparam.where = "1=1"
                CALL q_rtic002()
                DISPLAY g_qryparam.return1 TO rtic002
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtic003
            #add-point:BEFORE FIELD rtic003 name="construct.b.page2.rtic003"
                        
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtic003
            
            #add-point:AFTER FIELD rtic003 name="construct.a.page2.rtic003"
                        
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.rtic003
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtic003
            #add-point:ON ACTION controlp INFIELD rtic003 name="construct.c.page2.rtic003"
                INITIALIZE g_qryparam.* TO NULL 
                LET g_qryparam.state = "c"
                LET g_qryparam.reqry = FALSE
                LET g_qryparam.where = "1=1"
                CALL q_rtic003()
                DISPLAY g_qryparam.return1 TO rtic003
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtic004
            #add-point:BEFORE FIELD rtic004 name="construct.b.page2.rtic004"
                        
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtic004
            
            #add-point:AFTER FIELD rtic004 name="construct.a.page2.rtic004"
                        
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.rtic004
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtic004
            #add-point:ON ACTION controlp INFIELD rtic004 name="construct.c.page2.rtic004"
                        
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtic005
            #add-point:BEFORE FIELD rtic005 name="construct.b.page2.rtic005"
                        
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtic005
            
            #add-point:AFTER FIELD rtic005 name="construct.a.page2.rtic005"
                        
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.rtic005
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtic005
            #add-point:ON ACTION controlp INFIELD rtic005 name="construct.c.page2.rtic005"
                        
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtic006
            #add-point:BEFORE FIELD rtic006 name="construct.b.page2.rtic006"
                        
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtic006
            
            #add-point:AFTER FIELD rtic006 name="construct.a.page2.rtic006"
                        
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.rtic006
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtic006
            #add-point:ON ACTION controlp INFIELD rtic006 name="construct.c.page2.rtic006"
                        
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtic007
            #add-point:BEFORE FIELD rtic007 name="construct.b.page2.rtic007"
                        
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtic007
            
            #add-point:AFTER FIELD rtic007 name="construct.a.page2.rtic007"
                        
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.rtic007
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtic007
            #add-point:ON ACTION controlp INFIELD rtic007 name="construct.c.page2.rtic007"
                        
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtic008
            #add-point:BEFORE FIELD rtic008 name="construct.b.page2.rtic008"
                        
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtic008
            
            #add-point:AFTER FIELD rtic008 name="construct.a.page2.rtic008"
                        
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.rtic008
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtic008
            #add-point:ON ACTION controlp INFIELD rtic008 name="construct.c.page2.rtic008"
                        
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtic009
            #add-point:BEFORE FIELD rtic009 name="construct.b.page2.rtic009"
                        
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtic009
            
            #add-point:AFTER FIELD rtic009 name="construct.a.page2.rtic009"
                        
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.rtic009
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtic009
            #add-point:ON ACTION controlp INFIELD rtic009 name="construct.c.page2.rtic009"
                        
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtic010
            #add-point:BEFORE FIELD rtic010 name="construct.b.page2.rtic010"
                        
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtic010
            
            #add-point:AFTER FIELD rtic010 name="construct.a.page2.rtic010"
                        
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.rtic010
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtic010
            #add-point:ON ACTION controlp INFIELD rtic010 name="construct.c.page2.rtic010"
                        
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtic011
            #add-point:BEFORE FIELD rtic011 name="construct.b.page2.rtic011"
                        
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtic011
            
            #add-point:AFTER FIELD rtic011 name="construct.a.page2.rtic011"
                        
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.rtic011
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtic011
            #add-point:ON ACTION controlp INFIELD rtic011 name="construct.c.page2.rtic011"
                        
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtic012
            #add-point:BEFORE FIELD rtic012 name="construct.b.page2.rtic012"
                        
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtic012
            
            #add-point:AFTER FIELD rtic012 name="construct.a.page2.rtic012"
                        
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.rtic012
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtic012
            #add-point:ON ACTION controlp INFIELD rtic012 name="construct.c.page2.rtic012"
                        
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtic013
            #add-point:BEFORE FIELD rtic013 name="construct.b.page2.rtic013"
                        
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtic013
            
            #add-point:AFTER FIELD rtic013 name="construct.a.page2.rtic013"
                        
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.rtic013
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtic013
            #add-point:ON ACTION controlp INFIELD rtic013 name="construct.c.page2.rtic013"
                        
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtic014
            #add-point:BEFORE FIELD rtic014 name="construct.b.page2.rtic014"
                        
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtic014
            
            #add-point:AFTER FIELD rtic014 name="construct.a.page2.rtic014"
                        
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.rtic014
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtic014
            #add-point:ON ACTION controlp INFIELD rtic014 name="construct.c.page2.rtic014"
                        
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtic015
            #add-point:BEFORE FIELD rtic015 name="construct.b.page2.rtic015"
                        
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtic015
            
            #add-point:AFTER FIELD rtic015 name="construct.a.page2.rtic015"
                        
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.rtic015
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtic015
            #add-point:ON ACTION controlp INFIELD rtic015 name="construct.c.page2.rtic015"
                        
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtic016
            #add-point:BEFORE FIELD rtic016 name="construct.b.page2.rtic016"
                        
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtic016
            
            #add-point:AFTER FIELD rtic016 name="construct.a.page2.rtic016"
                        
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.rtic016
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtic016
            #add-point:ON ACTION controlp INFIELD rtic016 name="construct.c.page2.rtic016"
                        
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtic017
            #add-point:BEFORE FIELD rtic017 name="construct.b.page2.rtic017"
                        
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtic017
            
            #add-point:AFTER FIELD rtic017 name="construct.a.page2.rtic017"
                        
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.rtic017
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtic017
            #add-point:ON ACTION controlp INFIELD rtic017 name="construct.c.page2.rtic017"
                        
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtic018
            #add-point:BEFORE FIELD rtic018 name="construct.b.page2.rtic018"
                        
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtic018
            
            #add-point:AFTER FIELD rtic018 name="construct.a.page2.rtic018"
                        
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.rtic018
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtic018
            #add-point:ON ACTION controlp INFIELD rtic018 name="construct.c.page2.rtic018"
                        
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtic020
            #add-point:BEFORE FIELD rtic020 name="construct.b.page2.rtic020"
                        
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtic020
            
            #add-point:AFTER FIELD rtic020 name="construct.a.page2.rtic020"
                        
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.rtic020
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtic020
            #add-point:ON ACTION controlp INFIELD rtic020 name="construct.c.page2.rtic020"
                        
            #END add-point
 
 
   
       
      END CONSTRUCT
 
      CONSTRUCT g_wc2_table3 ON xrcd007,xrcdld,xrcdseq,xrcdseq2,xrcd002,xrcd003,xrcd006,xrcd004,xrcd104 
 
           FROM s_detail3[1].xrcd007,s_detail3[1].xrcdld,s_detail3[1].xrcdseq,s_detail3[1].xrcdseq2, 
               s_detail3[1].xrcd002,s_detail3[1].xrcd003,s_detail3[1].xrcd006,s_detail3[1].xrcd004,s_detail3[1].xrcd104 
 
                      
         BEFORE CONSTRUCT
            #add-point:cs段before_construct name="cs.body3.before_construct"
 
            #end add-point 
            
       #單身公用欄位開窗相關處理(table 3)
       
       
       #單身一般欄位開窗相關處理       
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
         BEFORE FIELD xrcd002
            #add-point:BEFORE FIELD xrcd002 name="construct.b.page3.xrcd002"
                        
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrcd002
            
            #add-point:AFTER FIELD xrcd002 name="construct.a.page3.xrcd002"
                        
            #END add-point
            
 
 
         #Ctrlp:construct.c.page3.xrcd002
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrcd002
            #add-point:ON ACTION controlp INFIELD xrcd002 name="construct.c.page3.xrcd002"

                INITIALIZE g_qryparam.* TO NULL 
                LET g_qryparam.state = "c"
                LET g_qryparam.reqry = FALSE
                LET g_qryparam.where = "1=1"
                CALL q_xrcd002()
                DISPLAY g_qryparam.return1 TO xrcd002 
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
 
 
   
       
      END CONSTRUCT
 
      CONSTRUCT g_wc2_table4 ON rtieseq,rtieseq1,rtie001,rtie002,rtie006
           FROM s_detail4[1].rtieseq,s_detail4[1].rtieseq1,s_detail4[1].rtie001,s_detail4[1].rtie002, 
               s_detail4[1].rtie006
                      
         BEFORE CONSTRUCT
            #add-point:cs段before_construct name="cs.body4.before_construct"
 
            #end add-point 
            
       #單身公用欄位開窗相關處理(table 4)
       
       
       #單身一般欄位開窗相關處理       
                #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtieseq
            #add-point:BEFORE FIELD rtieseq name="construct.b.page4.rtieseq"
                        
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtieseq
            
            #add-point:AFTER FIELD rtieseq name="construct.a.page4.rtieseq"
                        
            #END add-point
            
 
 
         #Ctrlp:construct.c.page4.rtieseq
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtieseq
            #add-point:ON ACTION controlp INFIELD rtieseq name="construct.c.page4.rtieseq"
                        
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtieseq1
            #add-point:BEFORE FIELD rtieseq1 name="construct.b.page4.rtieseq1"
                        
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtieseq1
            
            #add-point:AFTER FIELD rtieseq1 name="construct.a.page4.rtieseq1"
                        
            #END add-point
            
 
 
         #Ctrlp:construct.c.page4.rtieseq1
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtieseq1
            #add-point:ON ACTION controlp INFIELD rtieseq1 name="construct.c.page4.rtieseq1"
                        
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtie001
            #add-point:BEFORE FIELD rtie001 name="construct.b.page4.rtie001"
                        
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtie001
            
            #add-point:AFTER FIELD rtie001 name="construct.a.page4.rtie001"
                        
            #END add-point
            
 
 
         #Ctrlp:construct.c.page4.rtie001
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtie001
            #add-point:ON ACTION controlp INFIELD rtie001 name="construct.c.page4.rtie001"
                        
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtie002
            #add-point:BEFORE FIELD rtie002 name="construct.b.page4.rtie002"
                        
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtie002
            
            #add-point:AFTER FIELD rtie002 name="construct.a.page4.rtie002"
                        
            #END add-point
            
 
 
         #Ctrlp:construct.c.page4.rtie002
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtie002
            #add-point:ON ACTION controlp INFIELD rtie002 name="construct.c.page4.rtie002"

                INITIALIZE g_qryparam.* TO NULL 
                LET g_qryparam.state = "c"
                LET g_qryparam.reqry = FALSE
                LET g_qryparam.where = "1=1"
                CALL q_rtie002()
                DISPLAY g_qryparam.return1 TO rtie002 
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtie006
            #add-point:BEFORE FIELD rtie006 name="construct.b.page4.rtie006"
                        
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtie006
            
            #add-point:AFTER FIELD rtie006 name="construct.a.page4.rtie006"
                        
            #END add-point
            
 
 
         #Ctrlp:construct.c.page4.rtie006
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtie006
            #add-point:ON ACTION controlp INFIELD rtie006 name="construct.c.page4.rtie006"
                        
            #END add-point
 
 
   
       
      END CONSTRUCT
 
      CONSTRUCT g_wc2_table5 ON rtiksite,rtikunit,rtikorg,rtikseq,rtik001,rtik002,rtik003,rtik004,rtik005, 
          rtik006,rtik006_desc,rtik007,rtik013,rtik012,rtik008,rtik009,rtik010,rtik011,rtik014,rtik015, 
          rtik016,rtik017,rtik018,rtik019,rtik020,rtik021,rtik022,rtik023
           FROM s_detail5[1].rtiksite,s_detail5[1].rtikunit,s_detail5[1].rtikorg,s_detail5[1].rtikseq, 
               s_detail5[1].rtik001,s_detail5[1].rtik002,s_detail5[1].rtik003,s_detail5[1].rtik004,s_detail5[1].rtik005, 
               s_detail5[1].rtik006,s_detail5[1].rtik006_desc,s_detail5[1].rtik007,s_detail5[1].rtik013, 
               s_detail5[1].rtik012,s_detail5[1].rtik008,s_detail5[1].rtik009,s_detail5[1].rtik010,s_detail5[1].rtik011, 
               s_detail5[1].rtik014,s_detail5[1].rtik015,s_detail5[1].rtik016,s_detail5[1].rtik017,s_detail5[1].rtik018, 
               s_detail5[1].rtik019,s_detail5[1].rtik020,s_detail5[1].rtik021,s_detail5[1].rtik022,s_detail5[1].rtik023 
 
                      
         BEFORE CONSTRUCT
            #add-point:cs段before_construct name="cs.body5.before_construct"
                        
            #end add-point 
            
       #單身公用欄位開窗相關處理(table 5)
       
       
       #單身一般欄位開窗相關處理       
                #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtiksite
            #add-point:BEFORE FIELD rtiksite name="construct.b.page5.rtiksite"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtiksite
            
            #add-point:AFTER FIELD rtiksite name="construct.a.page5.rtiksite"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page5.rtiksite
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtiksite
            #add-point:ON ACTION controlp INFIELD rtiksite name="construct.c.page5.rtiksite"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtikunit
            #add-point:BEFORE FIELD rtikunit name="construct.b.page5.rtikunit"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtikunit
            
            #add-point:AFTER FIELD rtikunit name="construct.a.page5.rtikunit"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page5.rtikunit
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtikunit
            #add-point:ON ACTION controlp INFIELD rtikunit name="construct.c.page5.rtikunit"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtikorg
            #add-point:BEFORE FIELD rtikorg name="construct.b.page5.rtikorg"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtikorg
            
            #add-point:AFTER FIELD rtikorg name="construct.a.page5.rtikorg"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page5.rtikorg
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtikorg
            #add-point:ON ACTION controlp INFIELD rtikorg name="construct.c.page5.rtikorg"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtikseq
            #add-point:BEFORE FIELD rtikseq name="construct.b.page5.rtikseq"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtikseq
            
            #add-point:AFTER FIELD rtikseq name="construct.a.page5.rtikseq"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page5.rtikseq
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtikseq
            #add-point:ON ACTION controlp INFIELD rtikseq name="construct.c.page5.rtikseq"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtik001
            #add-point:BEFORE FIELD rtik001 name="construct.b.page5.rtik001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtik001
            
            #add-point:AFTER FIELD rtik001 name="construct.a.page5.rtik001"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page5.rtik001
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtik001
            #add-point:ON ACTION controlp INFIELD rtik001 name="construct.c.page5.rtik001"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtik002
            #add-point:BEFORE FIELD rtik002 name="construct.b.page5.rtik002"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtik002
            
            #add-point:AFTER FIELD rtik002 name="construct.a.page5.rtik002"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page5.rtik002
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtik002
            #add-point:ON ACTION controlp INFIELD rtik002 name="construct.c.page5.rtik002"
            
            #END add-point
 
 
         #Ctrlp:construct.c.page5.rtik003
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtik003
            #add-point:ON ACTION controlp INFIELD rtik003 name="construct.c.page5.rtik003"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_rtik003()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO rtik003  #顯示到畫面上
            NEXT FIELD rtik003                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtik003
            #add-point:BEFORE FIELD rtik003 name="construct.b.page5.rtik003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtik003
            
            #add-point:AFTER FIELD rtik003 name="construct.a.page5.rtik003"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtik004
            #add-point:BEFORE FIELD rtik004 name="construct.b.page5.rtik004"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtik004
            
            #add-point:AFTER FIELD rtik004 name="construct.a.page5.rtik004"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page5.rtik004
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtik004
            #add-point:ON ACTION controlp INFIELD rtik004 name="construct.c.page5.rtik004"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtik005
            #add-point:BEFORE FIELD rtik005 name="construct.b.page5.rtik005"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtik005
            
            #add-point:AFTER FIELD rtik005 name="construct.a.page5.rtik005"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page5.rtik005
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtik005
            #add-point:ON ACTION controlp INFIELD rtik005 name="construct.c.page5.rtik005"
            
            #END add-point
 
 
         #Ctrlp:construct.c.page5.rtik006
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtik006
            #add-point:ON ACTION controlp INFIELD rtik006 name="construct.c.page5.rtik006"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            SELECT ooef019 INTO l_ooef019
              FROM ooef_t
             WHERE ooefent = g_enterprise
               AND ooef001 = g_rtia_m.rtiasite
            LET g_qryparam.arg1 = l_ooef019
            CALL q_rtdx014()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO rtik006  #顯示到畫面上
            NEXT FIELD rtik006                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtik006
            #add-point:BEFORE FIELD rtik006 name="construct.b.page5.rtik006"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtik006
            
            #add-point:AFTER FIELD rtik006 name="construct.a.page5.rtik006"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtik006_desc
            #add-point:BEFORE FIELD rtik006_desc name="construct.b.page5.rtik006_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtik006_desc
            
            #add-point:AFTER FIELD rtik006_desc name="construct.a.page5.rtik006_desc"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page5.rtik006_desc
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtik006_desc
            #add-point:ON ACTION controlp INFIELD rtik006_desc name="construct.c.page5.rtik006_desc"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtik007
            #add-point:BEFORE FIELD rtik007 name="construct.b.page5.rtik007"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtik007
            
            #add-point:AFTER FIELD rtik007 name="construct.a.page5.rtik007"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page5.rtik007
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtik007
            #add-point:ON ACTION controlp INFIELD rtik007 name="construct.c.page5.rtik007"
            
            #END add-point
 
 
         #Ctrlp:construct.c.page5.rtik013
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtik013
            #add-point:ON ACTION controlp INFIELD rtik013 name="construct.c.page5.rtik013"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooca001_1()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO rtik013  #顯示到畫面上
            NEXT FIELD rtik013                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtik013
            #add-point:BEFORE FIELD rtik013 name="construct.b.page5.rtik013"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtik013
            
            #add-point:AFTER FIELD rtik013 name="construct.a.page5.rtik013"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtik012
            #add-point:BEFORE FIELD rtik012 name="construct.b.page5.rtik012"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtik012
            
            #add-point:AFTER FIELD rtik012 name="construct.a.page5.rtik012"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page5.rtik012
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtik012
            #add-point:ON ACTION controlp INFIELD rtik012 name="construct.c.page5.rtik012"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtik008
            #add-point:BEFORE FIELD rtik008 name="construct.b.page5.rtik008"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtik008
            
            #add-point:AFTER FIELD rtik008 name="construct.a.page5.rtik008"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page5.rtik008
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtik008
            #add-point:ON ACTION controlp INFIELD rtik008 name="construct.c.page5.rtik008"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtik009
            #add-point:BEFORE FIELD rtik009 name="construct.b.page5.rtik009"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtik009
            
            #add-point:AFTER FIELD rtik009 name="construct.a.page5.rtik009"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page5.rtik009
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtik009
            #add-point:ON ACTION controlp INFIELD rtik009 name="construct.c.page5.rtik009"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtik010
            #add-point:BEFORE FIELD rtik010 name="construct.b.page5.rtik010"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtik010
            
            #add-point:AFTER FIELD rtik010 name="construct.a.page5.rtik010"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page5.rtik010
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtik010
            #add-point:ON ACTION controlp INFIELD rtik010 name="construct.c.page5.rtik010"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtik011
            #add-point:BEFORE FIELD rtik011 name="construct.b.page5.rtik011"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtik011
            
            #add-point:AFTER FIELD rtik011 name="construct.a.page5.rtik011"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page5.rtik011
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtik011
            #add-point:ON ACTION controlp INFIELD rtik011 name="construct.c.page5.rtik011"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtik014
            #add-point:BEFORE FIELD rtik014 name="construct.b.page5.rtik014"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtik014
            
            #add-point:AFTER FIELD rtik014 name="construct.a.page5.rtik014"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page5.rtik014
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtik014
            #add-point:ON ACTION controlp INFIELD rtik014 name="construct.c.page5.rtik014"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtik015
            #add-point:BEFORE FIELD rtik015 name="construct.b.page5.rtik015"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtik015
            
            #add-point:AFTER FIELD rtik015 name="construct.a.page5.rtik015"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page5.rtik015
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtik015
            #add-point:ON ACTION controlp INFIELD rtik015 name="construct.c.page5.rtik015"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtik016
            #add-point:BEFORE FIELD rtik016 name="construct.b.page5.rtik016"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtik016
            
            #add-point:AFTER FIELD rtik016 name="construct.a.page5.rtik016"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page5.rtik016
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtik016
            #add-point:ON ACTION controlp INFIELD rtik016 name="construct.c.page5.rtik016"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtik017
            #add-point:BEFORE FIELD rtik017 name="construct.b.page5.rtik017"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtik017
            
            #add-point:AFTER FIELD rtik017 name="construct.a.page5.rtik017"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page5.rtik017
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtik017
            #add-point:ON ACTION controlp INFIELD rtik017 name="construct.c.page5.rtik017"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtik018
            #add-point:BEFORE FIELD rtik018 name="construct.b.page5.rtik018"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtik018
            
            #add-point:AFTER FIELD rtik018 name="construct.a.page5.rtik018"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page5.rtik018
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtik018
            #add-point:ON ACTION controlp INFIELD rtik018 name="construct.c.page5.rtik018"
            
            #END add-point
 
 
         #Ctrlp:construct.c.page5.rtik019
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtik019
            #add-point:ON ACTION controlp INFIELD rtik019 name="construct.c.page5.rtik019"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_inag004()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO rtik019  #顯示到畫面上
            NEXT FIELD rtik019                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtik019
            #add-point:BEFORE FIELD rtik019 name="construct.b.page5.rtik019"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtik019
            
            #add-point:AFTER FIELD rtik019 name="construct.a.page5.rtik019"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page5.rtik020
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtik020
            #add-point:ON ACTION controlp INFIELD rtik020 name="construct.c.page5.rtik020"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_inag005_3()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO rtik020  #顯示到畫面上
            NEXT FIELD rtik020                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtik020
            #add-point:BEFORE FIELD rtik020 name="construct.b.page5.rtik020"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtik020
            
            #add-point:AFTER FIELD rtik020 name="construct.a.page5.rtik020"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page5.rtik021
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtik021
            #add-point:ON ACTION controlp INFIELD rtik021 name="construct.c.page5.rtik021"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_inag006()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO rtik021  #顯示到畫面上
            NEXT FIELD rtik021                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtik021
            #add-point:BEFORE FIELD rtik021 name="construct.b.page5.rtik021"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtik021
            
            #add-point:AFTER FIELD rtik021 name="construct.a.page5.rtik021"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page5.rtik022
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtik022
            #add-point:ON ACTION controlp INFIELD rtik022 name="construct.c.page5.rtik022"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_inaa120()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO rtik022  #顯示到畫面上
            NEXT FIELD rtik022                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtik022
            #add-point:BEFORE FIELD rtik022 name="construct.b.page5.rtik022"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtik022
            
            #add-point:AFTER FIELD rtik022 name="construct.a.page5.rtik022"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtik023
            #add-point:BEFORE FIELD rtik023 name="construct.b.page5.rtik023"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtik023
            
            #add-point:AFTER FIELD rtik023 name="construct.a.page5.rtik023"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page5.rtik023
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtik023
            #add-point:ON ACTION controlp INFIELD rtik023 name="construct.c.page5.rtik023"
            
            #END add-point
 
 
   
       
      END CONSTRUCT
 
      CONSTRUCT g_wc2_table6 ON rtinsite,rtinseq,rtinseq1,rtin001,rtin002,rtin003,rtin004,rtin005,rtin006, 
          rtin007,rtin008,rtin009,rtin010
           FROM s_detail6[1].rtinsite,s_detail6[1].rtinseq,s_detail6[1].rtinseq1,s_detail6[1].rtin001, 
               s_detail6[1].rtin002,s_detail6[1].rtin003,s_detail6[1].rtin004,s_detail6[1].rtin005,s_detail6[1].rtin006, 
               s_detail6[1].rtin007,s_detail6[1].rtin008,s_detail6[1].rtin009,s_detail6[1].rtin010
                      
         BEFORE CONSTRUCT
            #add-point:cs段before_construct name="cs.body6.before_construct"
                        
            #end add-point 
            
       #單身公用欄位開窗相關處理(table 6)
       
       
       #單身一般欄位開窗相關處理       
                #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtinsite
            #add-point:BEFORE FIELD rtinsite name="construct.b.page6.rtinsite"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtinsite
            
            #add-point:AFTER FIELD rtinsite name="construct.a.page6.rtinsite"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page6.rtinsite
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtinsite
            #add-point:ON ACTION controlp INFIELD rtinsite name="construct.c.page6.rtinsite"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtinseq
            #add-point:BEFORE FIELD rtinseq name="construct.b.page6.rtinseq"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtinseq
            
            #add-point:AFTER FIELD rtinseq name="construct.a.page6.rtinseq"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page6.rtinseq
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtinseq
            #add-point:ON ACTION controlp INFIELD rtinseq name="construct.c.page6.rtinseq"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtinseq1
            #add-point:BEFORE FIELD rtinseq1 name="construct.b.page6.rtinseq1"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtinseq1
            
            #add-point:AFTER FIELD rtinseq1 name="construct.a.page6.rtinseq1"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page6.rtinseq1
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtinseq1
            #add-point:ON ACTION controlp INFIELD rtinseq1 name="construct.c.page6.rtinseq1"
            
            #END add-point
 
 
         #Ctrlp:construct.c.page6.rtin001
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtin001
            #add-point:ON ACTION controlp INFIELD rtin001 name="construct.c.page6.rtin001"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_imaa001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO rtin001  #顯示到畫面上
            NEXT FIELD rtin001                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtin001
            #add-point:BEFORE FIELD rtin001 name="construct.b.page6.rtin001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtin001
            
            #add-point:AFTER FIELD rtin001 name="construct.a.page6.rtin001"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page6.rtin002
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtin002
            #add-point:ON ACTION controlp INFIELD rtin002 name="construct.c.page6.rtin002"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_xmdm002()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO rtin002  #顯示到畫面上
            NEXT FIELD rtin002                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtin002
            #add-point:BEFORE FIELD rtin002 name="construct.b.page6.rtin002"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtin002
            
            #add-point:AFTER FIELD rtin002 name="construct.a.page6.rtin002"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page6.rtin003
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtin003
            #add-point:ON ACTION controlp INFIELD rtin003 name="construct.c.page6.rtin003"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_oocq002()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO rtin003  #顯示到畫面上
            NEXT FIELD rtin003                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtin003
            #add-point:BEFORE FIELD rtin003 name="construct.b.page6.rtin003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtin003
            
            #add-point:AFTER FIELD rtin003 name="construct.a.page6.rtin003"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtin004
            #add-point:BEFORE FIELD rtin004 name="construct.b.page6.rtin004"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtin004
            
            #add-point:AFTER FIELD rtin004 name="construct.a.page6.rtin004"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page6.rtin004
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtin004
            #add-point:ON ACTION controlp INFIELD rtin004 name="construct.c.page6.rtin004"
            
            #END add-point
 
 
         #Ctrlp:construct.c.page6.rtin005
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtin005
            #add-point:ON ACTION controlp INFIELD rtin005 name="construct.c.page6.rtin005"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_inag004_2()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO rtin005  #顯示到畫面上
            NEXT FIELD rtin005                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtin005
            #add-point:BEFORE FIELD rtin005 name="construct.b.page6.rtin005"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtin005
            
            #add-point:AFTER FIELD rtin005 name="construct.a.page6.rtin005"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page6.rtin006
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtin006
            #add-point:ON ACTION controlp INFIELD rtin006 name="construct.c.page6.rtin006"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_inag004_1()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO rtin006  #顯示到畫面上
            NEXT FIELD rtin006                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtin006
            #add-point:BEFORE FIELD rtin006 name="construct.b.page6.rtin006"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtin006
            
            #add-point:AFTER FIELD rtin006 name="construct.a.page6.rtin006"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page6.rtin007
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtin007
            #add-point:ON ACTION controlp INFIELD rtin007 name="construct.c.page6.rtin007"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_inag004_1()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO rtin007  #顯示到畫面上
            NEXT FIELD rtin007                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtin007
            #add-point:BEFORE FIELD rtin007 name="construct.b.page6.rtin007"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtin007
            
            #add-point:AFTER FIELD rtin007 name="construct.a.page6.rtin007"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page6.rtin008
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtin008
            #add-point:ON ACTION controlp INFIELD rtin008 name="construct.c.page6.rtin008"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooca001_1()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO rtin008  #顯示到畫面上
            NEXT FIELD rtin008                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtin008
            #add-point:BEFORE FIELD rtin008 name="construct.b.page6.rtin008"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtin008
            
            #add-point:AFTER FIELD rtin008 name="construct.a.page6.rtin008"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtin009
            #add-point:BEFORE FIELD rtin009 name="construct.b.page6.rtin009"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtin009
            
            #add-point:AFTER FIELD rtin009 name="construct.a.page6.rtin009"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page6.rtin009
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtin009
            #add-point:ON ACTION controlp INFIELD rtin009 name="construct.c.page6.rtin009"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtin010
            #add-point:BEFORE FIELD rtin010 name="construct.b.page6.rtin010"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtin010
            
            #add-point:AFTER FIELD rtin010 name="construct.a.page6.rtin010"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page6.rtin010
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtin010
            #add-point:ON ACTION controlp INFIELD rtin010 name="construct.c.page6.rtin010"
            
            #END add-point
 
 
   
       
      END CONSTRUCT
 
      CONSTRUCT g_wc2_table7 ON preksite,prekunit,prekseq,prek001,prek002,prek003,prek004
           FROM s_detail7[1].preksite,s_detail7[1].prekunit,s_detail7[1].prekseq,s_detail7[1].prek001, 
               s_detail7[1].prek002,s_detail7[1].prek003,s_detail7[1].prek004
                      
         BEFORE CONSTRUCT
            #add-point:cs段before_construct name="cs.body7.before_construct"
                        
            #end add-point 
            
       #單身公用欄位開窗相關處理(table 7)
       
       
       #單身一般欄位開窗相關處理       
                #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD preksite
            #add-point:BEFORE FIELD preksite name="construct.b.page7.preksite"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD preksite
            
            #add-point:AFTER FIELD preksite name="construct.a.page7.preksite"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page7.preksite
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD preksite
            #add-point:ON ACTION controlp INFIELD preksite name="construct.c.page7.preksite"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prekunit
            #add-point:BEFORE FIELD prekunit name="construct.b.page7.prekunit"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prekunit
            
            #add-point:AFTER FIELD prekunit name="construct.a.page7.prekunit"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page7.prekunit
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prekunit
            #add-point:ON ACTION controlp INFIELD prekunit name="construct.c.page7.prekunit"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prekseq
            #add-point:BEFORE FIELD prekseq name="construct.b.page7.prekseq"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prekseq
            
            #add-point:AFTER FIELD prekseq name="construct.a.page7.prekseq"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page7.prekseq
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prekseq
            #add-point:ON ACTION controlp INFIELD prekseq name="construct.c.page7.prekseq"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prek001
            #add-point:BEFORE FIELD prek001 name="construct.b.page7.prek001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prek001
            
            #add-point:AFTER FIELD prek001 name="construct.a.page7.prek001"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page7.prek001
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prek001
            #add-point:ON ACTION controlp INFIELD prek001 name="construct.c.page7.prek001"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prek002
            #add-point:BEFORE FIELD prek002 name="construct.b.page7.prek002"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prek002
            
            #add-point:AFTER FIELD prek002 name="construct.a.page7.prek002"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page7.prek002
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prek002
            #add-point:ON ACTION controlp INFIELD prek002 name="construct.c.page7.prek002"
            #開窗c段
			   INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			   LET g_qryparam.reqry = FALSE
			   LET g_qryparam.where = " rtja000 IN ('artt622','artt610','artt620') AND rtja033 IS NOT NULL "
            CALL q_rtja033_1()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO prek002  #顯示到畫面上

            NEXT FIELD prek002                     #返回原欄位
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prek003
            #add-point:BEFORE FIELD prek003 name="construct.b.page7.prek003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prek003
            
            #add-point:AFTER FIELD prek003 name="construct.a.page7.prek003"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page7.prek003
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prek003
            #add-point:ON ACTION controlp INFIELD prek003 name="construct.c.page7.prek003"
            #開窗c段
			   INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			   LET g_qryparam.reqry = FALSE
			   LET g_qryparam.where = " rtja000 IN ('artt622','artt610','artt620') "
            CALL q_rtjadocno()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO prek003  #顯示到畫面上

            NEXT FIELD prek003                     #返回原欄位
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prek004
            #add-point:BEFORE FIELD prek004 name="construct.b.page7.prek004"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prek004
            
            #add-point:AFTER FIELD prek004 name="construct.a.page7.prek004"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page7.prek004
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prek004
            #add-point:ON ACTION controlp INFIELD prek004 name="construct.c.page7.prek004"
            
            #END add-point
 
 
   
       
      END CONSTRUCT
 
 
      
 
      
      #add-point:cs段add_cs(本段內只能出現新的CONSTRUCT指令) name="cs.add_cs"
            
      #end add-point
 
      BEFORE DIALOG
         CALL cl_qbe_init()
         #add-point:cs段b_dialog name="cs.b_dialog"
                  
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
 
            INITIALIZE g_wc2_table4 TO NULL
 
            INITIALIZE g_wc2_table5 TO NULL
 
            INITIALIZE g_wc2_table6 TO NULL
 
            INITIALIZE g_wc2_table7 TO NULL
 
 
            FOR li_idx = 1 TO la_wc.getLength()
               CASE
                  WHEN la_wc[li_idx].tableid = "rtia_t" 
                     LET g_wc = la_wc[li_idx].wc
                  WHEN la_wc[li_idx].tableid = "rtib_t" 
                     LET g_wc2_table1 = la_wc[li_idx].wc
                  WHEN la_wc[li_idx].tableid = "rtic_t" 
                     LET g_wc2_table2 = la_wc[li_idx].wc
 
                  WHEN la_wc[li_idx].tableid = "xrcd_t" 
                     LET g_wc2_table3 = la_wc[li_idx].wc
 
                  WHEN la_wc[li_idx].tableid = "rtie_t" 
                     LET g_wc2_table4 = la_wc[li_idx].wc
 
                  WHEN la_wc[li_idx].tableid = "rtik_t" 
                     LET g_wc2_table5 = la_wc[li_idx].wc
 
                  WHEN la_wc[li_idx].tableid = "rtin_t" 
                     LET g_wc2_table6 = la_wc[li_idx].wc
 
                  WHEN la_wc[li_idx].tableid = "prek_t" 
                     LET g_wc2_table7 = la_wc[li_idx].wc
 
 
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
 
   IF g_wc2_table4 <> " 1=1" THEN
      LET g_wc2 = g_wc2 ," AND ", g_wc2_table4
   END IF
 
   IF g_wc2_table5 <> " 1=1" THEN
      LET g_wc2 = g_wc2 ," AND ", g_wc2_table5
   END IF
 
   IF g_wc2_table6 <> " 1=1" THEN
      LET g_wc2 = g_wc2 ," AND ", g_wc2_table6
   END IF
 
   IF g_wc2_table7 <> " 1=1" THEN
      LET g_wc2 = g_wc2 ," AND ", g_wc2_table7
   END IF
 
 
 
 
   
   #add-point:cs段結束前 name="cs.after_construct"
      
   #end add-point    
 
   IF INT_FLAG THEN
      RETURN
   END IF
 
END FUNCTION
 
{</section>}
 
{<section id="artt622.filter" >}
#應用 a50 樣板自動產生(Version:8)
#+ filter過濾功能
PRIVATE FUNCTION artt622_filter()
   #add-point:filter段define name="filter.define_customerization"
   
   #end add-point   
   #add-point:filter段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="filter.define"
   DEFINE ls_result   STRING
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
      CONSTRUCT g_wc_filter ON rtiasite,rtiadocdt,rtiadocno,rtia002,rtia006
                          FROM s_browse[1].b_rtiasite,s_browse[1].b_rtiadocdt,s_browse[1].b_rtiadocno, 
                              s_browse[1].b_rtia002,s_browse[1].b_rtia006
 
         BEFORE CONSTRUCT
               DISPLAY artt622_filter_parser('rtiasite') TO s_browse[1].b_rtiasite
            DISPLAY artt622_filter_parser('rtiadocdt') TO s_browse[1].b_rtiadocdt
            DISPLAY artt622_filter_parser('rtiadocno') TO s_browse[1].b_rtiadocno
            DISPLAY artt622_filter_parser('rtia002') TO s_browse[1].b_rtia002
            DISPLAY artt622_filter_parser('rtia006') TO s_browse[1].b_rtia006
      
         #add-point:filter段cs_ctrl name="filter.cs_ctrl"
         DISPLAY '' TO s_browse[1].b_rtia002_desc
         DISPLAY '' TO s_browse[1].b_rtiasite_desc       
         AFTER FIELD b_rtia006
            CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
            IF NOT cl_null(ls_result) THEN
               IF NOT cl_chk_date_symbol(ls_result) THEN
                  LET ls_result = cl_add_date_extra_cond(ls_result)
               END IF
            END IF
            CALL FGL_DIALOG_SETBUFFER(ls_result)
            
         ON ACTION controlp INFIELD b_rtiasite
	         INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
	         LET g_qryparam.reqry = FALSE
            LET g_qryparam.arg1 = g_site
            LET g_qryparam.arg2 = "8" 
            CALL q_ooed004()                           
            DISPLAY g_qryparam.return1 TO b_rtiasite  
            NEXT FIELD b_rtiasite            

         ON ACTION controlp INFIELD b_rtiadocno
	         INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
	         LET g_qryparam.reqry = FALSE
	         LET g_qryparam.where = " rtia000 = '",g_prog,"'"
            CALL q_rtiadocno()             
            DISPLAY g_qryparam.return1 TO b_rtiadocno 
            NEXT FIELD b_rtiadocno            

         ON ACTION controlp INFIELD b_rtia002
	         INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
	         LET g_qryparam.reqry = FALSE
            CALL q_pmaa001_7()                     
            DISPLAY g_qryparam.return1 TO b_rtia002  
            NEXT FIELD b_rtia002   
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
 
      CALL artt622_filter_show('rtiasite')
   CALL artt622_filter_show('rtiadocdt')
   CALL artt622_filter_show('rtiadocno')
   CALL artt622_filter_show('rtia002')
   CALL artt622_filter_show('rtia006')
 
END FUNCTION
 
{</section>}
 
{<section id="artt622.filter_parser" >}
#+ filter過濾功能
PRIVATE FUNCTION artt622_filter_parser(ps_field)
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
 
{<section id="artt622.filter_show" >}
#+ 顯示過濾條件
PRIVATE FUNCTION artt622_filter_show(ps_field)
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
   LET ls_condition = artt622_filter_parser(ps_field)
   IF NOT cl_null(ls_condition) THEN
      LET ls_title = ls_title, '※', ls_condition, '※'
   END IF
 
   #將資料顯示回去
   CALL lnode_item.setAttribute("text",ls_title)
 
END FUNCTION
 
{</section>}
 
{<section id="artt622.query" >}
#+ 資料查詢QBE功能準備
PRIVATE FUNCTION artt622_query()
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
   CALL g_rtib_d.clear()
   CALL g_rtib2_d.clear()
   CALL g_rtib3_d.clear()
   CALL g_rtib4_d.clear()
   CALL g_rtib5_d.clear()
   CALL g_rtib6_d.clear()
   CALL g_rtib7_d.clear()
 
   
   #add-point:query段other name="query.other"
      
   #end add-point   
   
   DISPLAY '' TO FORMONLY.idx
   DISPLAY '' TO FORMONLY.cnt
   DISPLAY '' TO FORMONLY.b_index
   DISPLAY '' TO FORMONLY.b_count
   DISPLAY '' TO FORMONLY.h_index
   DISPLAY '' TO FORMONLY.h_count
   
   CALL artt622_construct()
 
   IF INT_FLAG THEN
      #取消查詢
      LET INT_FLAG = 0
      #LET g_wc = ls_wc
      LET g_wc = " 1=2"
      CALL artt622_browser_fill("")
      CALL artt622_fetch("")
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
   LET g_detail_idx_list[4] = 1
   LET g_detail_idx_list[5] = 1
   LET g_detail_idx_list[6] = 1
   LET g_detail_idx_list[7] = 1
 
   LET g_error_show  = 1
   LET g_wc_filter   = ""
   LET l_ac = 1
   CALL FGL_SET_ARR_CURR(1)
      CALL artt622_filter_show('rtiasite')
   CALL artt622_filter_show('rtiadocdt')
   CALL artt622_filter_show('rtiadocno')
   CALL artt622_filter_show('rtia002')
   CALL artt622_filter_show('rtia006')
   CALL artt622_browser_fill("F")
         
   IF g_browser_cnt = 0 THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code = "-100" 
      LET g_errparam.popup = TRUE 
      CALL cl_err()
   ELSE
      CALL artt622_fetch("F") 
      #顯示單身筆數
      CALL artt622_idx_chk()
   END IF
 
END FUNCTION
 
{</section>}
 
{<section id="artt622.fetch" >}
#+ 指定PK後抓取單頭其他資料
PRIVATE FUNCTION artt622_fetch(p_flag)
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
   
   LET g_rtia_m.rtiadocno = g_browser[g_current_idx].b_rtiadocno
 
   
   #重讀DB,因TEMP有不被更新特性
   EXECUTE artt622_master_referesh USING g_rtia_m.rtiadocno INTO g_rtia_m.rtiasite,g_rtia_m.rtiadocdt, 
       g_rtia_m.rtiadocno,g_rtia_m.rtia002,g_rtia_m.rtia001,g_rtia_m.rtia059,g_rtia_m.rtia060,g_rtia_m.rtia004, 
       g_rtia_m.rtia005,g_rtia_m.rtia006,g_rtia_m.rtia048,g_rtia_m.rtia053,g_rtia_m.rtiastus,g_rtia_m.rtia007, 
       g_rtia_m.rtia008,g_rtia_m.rtia009,g_rtia_m.rtia043,g_rtia_m.rtia047,g_rtia_m.rtia013,g_rtia_m.rtia014, 
       g_rtia_m.rtia015,g_rtia_m.rtia016,g_rtia_m.rtia051,g_rtia_m.rtia010,g_rtia_m.rtia011,g_rtia_m.rtia012, 
       g_rtia_m.rtia041,g_rtia_m.rtia017,g_rtia_m.rtia018,g_rtia_m.rtia019,g_rtia_m.rtia020,g_rtia_m.rtia021, 
       g_rtia_m.rtia022,g_rtia_m.rtia023,g_rtia_m.rtia024,g_rtia_m.rtia025,g_rtia_m.rtia026,g_rtia_m.rtia027, 
       g_rtia_m.rtia028,g_rtia_m.rtia029,g_rtia_m.rtia030,g_rtia_m.rtia032,g_rtia_m.rtia033,g_rtia_m.rtia034, 
       g_rtia_m.rtia035,g_rtia_m.rtia036,g_rtia_m.rtia037,g_rtia_m.rtia038,g_rtia_m.rtia039,g_rtia_m.rtia107, 
       g_rtia_m.rtiaownid,g_rtia_m.rtiacrtid,g_rtia_m.rtiaowndp,g_rtia_m.rtiacrtdp,g_rtia_m.rtiacrtdt, 
       g_rtia_m.rtiamodid,g_rtia_m.rtiamoddt,g_rtia_m.rtiacnfid,g_rtia_m.rtiacnfdt,g_rtia_m.rtiapstid, 
       g_rtia_m.rtiapstdt,g_rtia_m.rtiasite_desc,g_rtia_m.rtia002_desc,g_rtia_m.rtia004_desc,g_rtia_m.rtia005_desc, 
       g_rtia_m.rtia009_desc,g_rtia_m.rtia010_desc,g_rtia_m.rtia011_desc,g_rtia_m.rtia012_desc,g_rtia_m.rtia018_desc, 
       g_rtia_m.rtia024_desc,g_rtia_m.rtia025_desc,g_rtia_m.rtia036_desc,g_rtia_m.rtia037_desc,g_rtia_m.rtia038_desc, 
       g_rtia_m.rtiaownid_desc,g_rtia_m.rtiacrtid_desc,g_rtia_m.rtiaowndp_desc,g_rtia_m.rtiacrtdp_desc, 
       g_rtia_m.rtiamodid_desc,g_rtia_m.rtiacnfid_desc,g_rtia_m.rtiapstid_desc
   
   #遮罩相關處理
   LET g_rtia_m_mask_o.* =  g_rtia_m.*
   CALL artt622_rtia_t_mask()
   LET g_rtia_m_mask_n.* =  g_rtia_m.*
   
   #根據資料狀態切換action狀態
   CALL cl_set_act_visible("statechange,modify,modify_detail,delete,reproduce", TRUE)
   CALL artt622_set_act_visible()   
   CALL artt622_set_act_no_visible()
   
   #add-point:fetch段action控制 name="fetch.action_control"
   #CALL cl_set_act_visible("modify,delete,insert,modify_detail", TRUE)  #mark by zn 
   CALL cl_set_act_visible("delete", FALSE)
   CALL cl_set_act_visible("modify,insert,modify_detail", TRUE)
   IF g_rtia_m.rtiastus NOT MATCHES "[NDR]" THEN   # N未確認/D抽單/R已拒絕允許修改
      CALL cl_set_act_visible("modify,delete,modify_detail", FALSE)
   END IF
   IF g_rtia_m.rtiastus = 'X' THEN 
      CALL cl_set_act_visible("statechange",FALSE)
   ELSE
      CALL cl_set_act_visible("statechange",TRUE)
   END IF 
   IF NOT cl_bpm_chk() THEN    #此單據不需提交至BPM，則隱藏按鈕 
       CALL cl_set_act_visible("bpm_status",FALSE)
   END IF
   #end add-point  
   
   
   
   #add-point:fetch結束前 name="fetch.after"
      
   #end add-point
   
   #保存單頭舊值
   LET g_rtia_m_t.* = g_rtia_m.*
   LET g_rtia_m_o.* = g_rtia_m.*
   
   LET g_data_owner = g_rtia_m.rtiaownid      
   LET g_data_dept  = g_rtia_m.rtiaowndp
   
   #重新顯示   
   CALL artt622_show()
 
   #應用 a56 樣板自動產生(Version:3)
   #檢查此單據是否需顯示BPM簽核狀況按鈕 
   IF cl_bpm_chk() THEN
      CALL cl_set_act_visible("bpm_status",TRUE)
   ELSE
      CALL cl_set_act_visible("bpm_status",FALSE)
   END IF
 
 
 
 
 
END FUNCTION
 
{</section>}
 
{<section id="artt622.insert" >}
#+ 資料新增
PRIVATE FUNCTION artt622_insert()
   #add-point:insert段define(客製用) name="insert.define_customerization"
   
   #end add-point    
   #add-point:insert段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="insert.define"
   DEFINE l_insert      LIKE type_t.num5
   DEFINE l_success     LIKE type_t.num5
   DEFINE l_doctype     LIKE rtai_t.rtai004  
   #end add-point    
   
   #add-point:Function前置處理  name="insert.pre_function"
   
   #end add-point
   
   #清畫面欄位內容
   CLEAR FORM                    
   CALL g_rtib_d.clear()   
   CALL g_rtib2_d.clear()  
   CALL g_rtib3_d.clear()  
   CALL g_rtib4_d.clear()  
   CALL g_rtib5_d.clear()  
   CALL g_rtib6_d.clear()  
   CALL g_rtib7_d.clear()  
 
 
   INITIALIZE g_rtia_m.* TO NULL             #DEFAULT 設定
   
   LET g_rtiadocno_t = NULL
 
   
   LET g_master_insert = FALSE
   
   #add-point:insert段before name="insert.before"
   
   #end add-point    
   
   CALL s_transaction_begin()
   WHILE TRUE
      #公用欄位給值(單頭)
      #應用 a14 樣板自動產生(Version:5)    
      #公用欄位新增給值  
      LET g_rtia_m.rtiaownid = g_user
      LET g_rtia_m.rtiaowndp = g_dept
      LET g_rtia_m.rtiacrtid = g_user
      LET g_rtia_m.rtiacrtdp = g_dept 
      LET g_rtia_m.rtiacrtdt = cl_get_current()
      LET g_rtia_m.rtiamodid = g_user
      LET g_rtia_m.rtiamoddt = cl_get_current()
      LET g_rtia_m.rtiastus = 'N'
 
 
 
 
      #append欄位給值
      
     
      #一般欄位給值
            LET g_rtia_m.rtia048 = "N"
      LET g_rtia_m.rtia053 = "N"
      LET g_rtia_m.rtiastus = "N"
      LET g_rtia_m.rtia013 = "100"
      LET g_rtia_m.rtia016 = "0"
      LET g_rtia_m.rtia051 = "0"
      LET g_rtia_m.rtia017 = "1"
      LET g_rtia_m.rtia023 = "1"
      LET g_rtia_m.rtia030 = "N"
      LET g_rtia_m.rtia032 = "1"
      LET g_rtia_m.rtia039 = "1"
      LET g_rtia_m.isaf009 = "N"
 
  
      #add-point:單頭預設值 name="insert.default"
      LET g_rtia_m.rtiadocdt = g_today
#      LET g_rtia_m.rtiasite = g_site
      #let g_chantype='1'
      #display g_chantype to formonly.chantype
      let g_rtia_m.chantype='1' 
      LET g_rtia_m.rtia107 = "N"
      LET g_site_flag = FALSE
      CALL s_aooi500_default(g_prog,'rtiasite',g_rtia_m.rtiasite)
         RETURNING l_insert,g_rtia_m.rtiasite
      IF NOT l_insert THEN
         RETURN
      END IF
      LET g_sign = 'a'
      LET g_rtia_m.rtia004 = g_user
      #预设arti100中散客
      SELECT ooef108 INTO g_rtia_m.rtia002
        FROM ooef_t
       WHERE ooefent = g_enterprise
         AND ooef001 = g_rtia_m.rtiasite
         AND ooefstus = 'Y'
      #add by geza 20160307 #160304-00025#1(S)   
      #带出散客对应资料
      CALL artt622_rtia002_display()   
      #add by geza 20160307 #160304-00025#1(E)   
      SELECT ooag003 INTO g_rtia_m.rtia005
        FROM ooag_t
       WHERE ooagent = g_enterprise
         AND ooag001 = g_rtia_m.rtia004
      INITIALIZE g_ref_fields TO NULL
      LET g_ref_fields[1] = g_rtia_m.rtia004
      CALL ap_ref_array2(g_ref_fields,"SELECT ooag011 FROM ooag_t WHERE ooagent='"||g_enterprise||"' AND ooag001=? ","") RETURNING g_rtn_fields
      LET g_rtia_m.rtia004_desc = '', g_rtn_fields[1] , ''
      DISPLAY BY NAME g_rtia_m.rtia004_desc

      INITIALIZE g_ref_fields TO NULL
      LET g_ref_fields[1] = g_rtia_m.rtia005
      CALL ap_ref_array2(g_ref_fields,"SELECT ooeal003 FROM ooeal_t WHERE ooealent='"||g_enterprise||"' AND ooeal001=? AND ooeal002='"||g_dlang||"'","") RETURNING g_rtn_fields
      LET g_rtia_m.rtia005_desc = '', g_rtn_fields[1] , ''
      DISPLAY BY NAME g_rtia_m.rtia005_desc

      INITIALIZE g_ref_fields TO NULL
      LET g_ref_fields[1] = g_rtia_m.rtiasite
      CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002 = '"||g_dlang||"'","") RETURNING g_rtn_fields
      LET g_rtia_m.rtiasite_desc = '', g_rtn_fields[1] , ''
      DISPLAY BY NAME g_rtia_m.rtiasite_desc
      LET g_rtia_m_t.* = g_rtia_m.*
      
      #預設單據的單別 
      LET l_success = ''
      LET l_doctype = ''
      CALL s_arti200_get_def_doc_type(g_rtia_m.rtiasite,g_prog,'1')
           RETURNING l_success, l_doctype
      LET g_rtia_m.rtiadocno = l_doctype
      #預設收銀員
      SELECT pcab001,pcab003 INTO g_rtia_m.rtia037,g_rtia_m.rtia037_desc
        FROM pcab_t,pcac_t
       WHERE pcabent = g_enterprise
         AND pcab002 = g_user
         AND pcacent = pcabent
         AND pcac001 = pcab001
         AND pcac002 = g_rtia_m.rtiasite
         AND pcacstus = 'Y'
         AND pcabstus = 'Y'
      DISPLAY BY NAME g_rtia_m.rtia037,g_rtia_m.rtia037_desc
      #end add-point 
      
      #保存單頭舊值(用於資料輸入錯誤還原預設值時使用)
      LET g_rtia_m_t.* = g_rtia_m.*
      LET g_rtia_m_o.* = g_rtia_m.*
      
      #顯示狀態(stus)圖片
            #應用 a21 樣板自動產生(Version:3)
	  #根據當下狀態碼顯示圖片
      CASE g_rtia_m.rtiastus 
         WHEN "N"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/unconfirmed.png")
         WHEN "Y"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/confirmed.png")
         WHEN "S"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/posted.png")
         WHEN "Z"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/unposted.png")
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
 
 
 
    
      CALL artt622_input("a")
      
      #add-point:單頭輸入後 name="insert.after_insert"
      LET g_sign = 't'
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
         INITIALIZE g_rtia_m.* TO NULL
         INITIALIZE g_rtib_d TO NULL
         INITIALIZE g_rtib2_d TO NULL
         INITIALIZE g_rtib3_d TO NULL
         INITIALIZE g_rtib4_d TO NULL
         INITIALIZE g_rtib5_d TO NULL
         INITIALIZE g_rtib6_d TO NULL
         INITIALIZE g_rtib7_d TO NULL
 
         #add-point:取消新增後 name="insert.cancel"
         
         #end add-point 
         CALL artt622_show()
         RETURN
      END IF
      
      LET INT_FLAG = 0
      #CALL g_rtib_d.clear()
      #CALL g_rtib2_d.clear()
      #CALL g_rtib3_d.clear()
      #CALL g_rtib4_d.clear()
      #CALL g_rtib5_d.clear()
      #CALL g_rtib6_d.clear()
      #CALL g_rtib7_d.clear()
 
 
      LET g_rec_b = 0
      CALL s_transaction_end('Y','0')
      EXIT WHILE
        
   END WHILE
   
   #根據資料狀態切換action狀態
   CALL cl_set_act_visible("statechange,modify,modify_detail,delete,reproduce", TRUE)
   CALL artt622_set_act_visible()   
   CALL artt622_set_act_no_visible()
   
   #將新增的資料併入搜尋條件中
   LET g_rtiadocno_t = g_rtia_m.rtiadocno
 
   
   #組合新增資料的條件
   LET g_add_browse = " rtiaent = " ||g_enterprise|| " AND",
                      " rtiadocno = '", g_rtia_m.rtiadocno, "' "
 
                      
   #add-point:組合新增資料的條件後 name="insert.after.add_browse"
   
   #end add-point
      
   #填到最後面
   LET g_current_idx = g_browser.getLength() + 1
   CALL artt622_browser_fill("")
   
   DISPLAY g_browser_cnt TO FORMONLY.h_count    #總筆數
   DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
   CALL cl_navigator_setting(g_current_idx, g_browser_cnt)
   
   CLOSE artt622_cl
   
   CALL artt622_idx_chk()
   
   #撈取異動後的資料(主要是帶出reference)
   EXECUTE artt622_master_referesh USING g_rtia_m.rtiadocno INTO g_rtia_m.rtiasite,g_rtia_m.rtiadocdt, 
       g_rtia_m.rtiadocno,g_rtia_m.rtia002,g_rtia_m.rtia001,g_rtia_m.rtia059,g_rtia_m.rtia060,g_rtia_m.rtia004, 
       g_rtia_m.rtia005,g_rtia_m.rtia006,g_rtia_m.rtia048,g_rtia_m.rtia053,g_rtia_m.rtiastus,g_rtia_m.rtia007, 
       g_rtia_m.rtia008,g_rtia_m.rtia009,g_rtia_m.rtia043,g_rtia_m.rtia047,g_rtia_m.rtia013,g_rtia_m.rtia014, 
       g_rtia_m.rtia015,g_rtia_m.rtia016,g_rtia_m.rtia051,g_rtia_m.rtia010,g_rtia_m.rtia011,g_rtia_m.rtia012, 
       g_rtia_m.rtia041,g_rtia_m.rtia017,g_rtia_m.rtia018,g_rtia_m.rtia019,g_rtia_m.rtia020,g_rtia_m.rtia021, 
       g_rtia_m.rtia022,g_rtia_m.rtia023,g_rtia_m.rtia024,g_rtia_m.rtia025,g_rtia_m.rtia026,g_rtia_m.rtia027, 
       g_rtia_m.rtia028,g_rtia_m.rtia029,g_rtia_m.rtia030,g_rtia_m.rtia032,g_rtia_m.rtia033,g_rtia_m.rtia034, 
       g_rtia_m.rtia035,g_rtia_m.rtia036,g_rtia_m.rtia037,g_rtia_m.rtia038,g_rtia_m.rtia039,g_rtia_m.rtia107, 
       g_rtia_m.rtiaownid,g_rtia_m.rtiacrtid,g_rtia_m.rtiaowndp,g_rtia_m.rtiacrtdp,g_rtia_m.rtiacrtdt, 
       g_rtia_m.rtiamodid,g_rtia_m.rtiamoddt,g_rtia_m.rtiacnfid,g_rtia_m.rtiacnfdt,g_rtia_m.rtiapstid, 
       g_rtia_m.rtiapstdt,g_rtia_m.rtiasite_desc,g_rtia_m.rtia002_desc,g_rtia_m.rtia004_desc,g_rtia_m.rtia005_desc, 
       g_rtia_m.rtia009_desc,g_rtia_m.rtia010_desc,g_rtia_m.rtia011_desc,g_rtia_m.rtia012_desc,g_rtia_m.rtia018_desc, 
       g_rtia_m.rtia024_desc,g_rtia_m.rtia025_desc,g_rtia_m.rtia036_desc,g_rtia_m.rtia037_desc,g_rtia_m.rtia038_desc, 
       g_rtia_m.rtiaownid_desc,g_rtia_m.rtiacrtid_desc,g_rtia_m.rtiaowndp_desc,g_rtia_m.rtiacrtdp_desc, 
       g_rtia_m.rtiamodid_desc,g_rtia_m.rtiacnfid_desc,g_rtia_m.rtiapstid_desc
   
   
   #遮罩相關處理
   LET g_rtia_m_mask_o.* =  g_rtia_m.*
   CALL artt622_rtia_t_mask()
   LET g_rtia_m_mask_n.* =  g_rtia_m.*
   
   #將資料顯示到畫面上
   DISPLAY BY NAME g_rtia_m.rtiasite,g_rtia_m.rtiasite_desc,g_rtia_m.rtiadocdt,g_rtia_m.rtiadocno,g_rtia_m.rtia002, 
       g_rtia_m.rtia002_desc,g_rtia_m.rtia001,g_rtia_m.rtia001_desc,g_rtia_m.rtia059,g_rtia_m.rtia060, 
       g_rtia_m.mmaf003,g_rtia_m.mmaf004,g_rtia_m.rtia004,g_rtia_m.rtia004_desc,g_rtia_m.rtia005,g_rtia_m.rtia005_desc, 
       g_rtia_m.rtia006,g_rtia_m.rtia048,g_rtia_m.rtia053,g_rtia_m.rtiastus,g_rtia_m.rtia007,g_rtia_m.rtia008, 
       g_rtia_m.rtia009,g_rtia_m.rtia009_desc,g_rtia_m.rtia043,g_rtia_m.rtia047,g_rtia_m.l_rtia047,g_rtia_m.rtia013, 
       g_rtia_m.rtia014,g_rtia_m.rtia015,g_rtia_m.rtia016,g_rtia_m.rtia051,g_rtia_m.rtia010,g_rtia_m.rtia010_desc, 
       g_rtia_m.rtia011,g_rtia_m.rtia011_desc,g_rtia_m.rtia012,g_rtia_m.rtia012_desc,g_rtia_m.chantype, 
       g_rtia_m.barcode,g_rtia_m.rtia041,g_rtia_m.rtia017,g_rtia_m.rtia018,g_rtia_m.rtia018_desc,g_rtia_m.rtia019, 
       g_rtia_m.rtia020,g_rtia_m.rtia021,g_rtia_m.rtia022,g_rtia_m.rtia023,g_rtia_m.rtia024,g_rtia_m.rtia024_desc, 
       g_rtia_m.rtia025,g_rtia_m.rtia025_desc,g_rtia_m.rtia026,g_rtia_m.rtia027,g_rtia_m.rtia028,g_rtia_m.rtia029, 
       g_rtia_m.rtia030,g_rtia_m.rtia032,g_rtia_m.rtia033,g_rtia_m.rtia034,g_rtia_m.rtia035,g_rtia_m.rtia036, 
       g_rtia_m.rtia036_desc,g_rtia_m.rtia037,g_rtia_m.rtia037_desc,g_rtia_m.rtia038,g_rtia_m.rtia038_desc, 
       g_rtia_m.rtia039,g_rtia_m.rtia107,g_rtia_m.isaf009,g_rtia_m.isaf010,g_rtia_m.isaf044,g_rtia_m.isaf202, 
       g_rtia_m.isaf203,g_rtia_m.isaf204,g_rtia_m.isaf201,g_rtia_m.isaf207,g_rtia_m.rtiaownid,g_rtia_m.rtiaownid_desc, 
       g_rtia_m.rtiacrtid,g_rtia_m.rtiacrtid_desc,g_rtia_m.rtiaowndp,g_rtia_m.rtiaowndp_desc,g_rtia_m.rtiacrtdp, 
       g_rtia_m.rtiacrtdp_desc,g_rtia_m.rtiacrtdt,g_rtia_m.rtiamodid,g_rtia_m.rtiamodid_desc,g_rtia_m.rtiamoddt, 
       g_rtia_m.rtiacnfid,g_rtia_m.rtiacnfid_desc,g_rtia_m.rtiacnfdt,g_rtia_m.rtiapstid,g_rtia_m.rtiapstid_desc, 
       g_rtia_m.rtiapstdt,g_rtia_m.snum,g_rtia_m.amount,g_rtia_m.amount2,g_rtia_m.amount3
   
   #add-point:新增結束後 name="insert.after"
   
   #end add-point 
   
   LET g_data_owner = g_rtia_m.rtiaownid      
   LET g_data_dept  = g_rtia_m.rtiaowndp
   
   #功能已完成,通報訊息中心
   CALL artt622_msgcentre_notify('insert')
   
END FUNCTION
 
{</section>}
 
{<section id="artt622.modify" >}
#+ 資料修改
PRIVATE FUNCTION artt622_modify()
   #add-point:modify段define(客製用) name="modify.define_customerization"
   
   #end add-point    
   DEFINE l_new_key    DYNAMIC ARRAY OF STRING
   DEFINE l_old_key    DYNAMIC ARRAY OF STRING
   DEFINE l_field_key  DYNAMIC ARRAY OF STRING
   DEFINE l_wc2_table1          STRING
   DEFINE l_wc2_table2   STRING
 
   DEFINE l_wc2_table3   STRING
 
   DEFINE l_wc2_table4   STRING
 
   DEFINE l_wc2_table5   STRING
 
   DEFINE l_wc2_table6   STRING
 
   DEFINE l_wc2_table7   STRING
 
 
 
   #add-point:modify段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="modify.define"
   DEFINE l_n          LIKE type_t.num5

   #end add-point    
   
   #add-point:Function前置處理  name="modify.pre_function"
   
   #end add-point
   
   #保存單頭舊值
   LET g_rtia_m_t.* = g_rtia_m.*
   LET g_rtia_m_o.* = g_rtia_m.*
   
   IF g_rtia_m.rtiadocno IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code = "std-00003" 
      LET g_errparam.popup = FALSE 
      CALL cl_err()
      RETURN
   END IF
 
   ERROR ""
  
   LET g_rtiadocno_t = g_rtia_m.rtiadocno
 
   CALL s_transaction_begin()
   
   OPEN artt622_cl USING g_enterprise,g_rtia_m.rtiadocno
   IF SQLCA.SQLCODE THEN   #(ver:78)
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "OPEN artt622_cl:",SQLERRMESSAGE 
      LET g_errparam.code = SQLCA.SQLCODE   #(ver:78)
      LET g_errparam.popup = TRUE 
      CLOSE artt622_cl
      CALL s_transaction_end('N','0')
      CALL cl_err()
      RETURN
   END IF
 
   #顯示最新的資料
   EXECUTE artt622_master_referesh USING g_rtia_m.rtiadocno INTO g_rtia_m.rtiasite,g_rtia_m.rtiadocdt, 
       g_rtia_m.rtiadocno,g_rtia_m.rtia002,g_rtia_m.rtia001,g_rtia_m.rtia059,g_rtia_m.rtia060,g_rtia_m.rtia004, 
       g_rtia_m.rtia005,g_rtia_m.rtia006,g_rtia_m.rtia048,g_rtia_m.rtia053,g_rtia_m.rtiastus,g_rtia_m.rtia007, 
       g_rtia_m.rtia008,g_rtia_m.rtia009,g_rtia_m.rtia043,g_rtia_m.rtia047,g_rtia_m.rtia013,g_rtia_m.rtia014, 
       g_rtia_m.rtia015,g_rtia_m.rtia016,g_rtia_m.rtia051,g_rtia_m.rtia010,g_rtia_m.rtia011,g_rtia_m.rtia012, 
       g_rtia_m.rtia041,g_rtia_m.rtia017,g_rtia_m.rtia018,g_rtia_m.rtia019,g_rtia_m.rtia020,g_rtia_m.rtia021, 
       g_rtia_m.rtia022,g_rtia_m.rtia023,g_rtia_m.rtia024,g_rtia_m.rtia025,g_rtia_m.rtia026,g_rtia_m.rtia027, 
       g_rtia_m.rtia028,g_rtia_m.rtia029,g_rtia_m.rtia030,g_rtia_m.rtia032,g_rtia_m.rtia033,g_rtia_m.rtia034, 
       g_rtia_m.rtia035,g_rtia_m.rtia036,g_rtia_m.rtia037,g_rtia_m.rtia038,g_rtia_m.rtia039,g_rtia_m.rtia107, 
       g_rtia_m.rtiaownid,g_rtia_m.rtiacrtid,g_rtia_m.rtiaowndp,g_rtia_m.rtiacrtdp,g_rtia_m.rtiacrtdt, 
       g_rtia_m.rtiamodid,g_rtia_m.rtiamoddt,g_rtia_m.rtiacnfid,g_rtia_m.rtiacnfdt,g_rtia_m.rtiapstid, 
       g_rtia_m.rtiapstdt,g_rtia_m.rtiasite_desc,g_rtia_m.rtia002_desc,g_rtia_m.rtia004_desc,g_rtia_m.rtia005_desc, 
       g_rtia_m.rtia009_desc,g_rtia_m.rtia010_desc,g_rtia_m.rtia011_desc,g_rtia_m.rtia012_desc,g_rtia_m.rtia018_desc, 
       g_rtia_m.rtia024_desc,g_rtia_m.rtia025_desc,g_rtia_m.rtia036_desc,g_rtia_m.rtia037_desc,g_rtia_m.rtia038_desc, 
       g_rtia_m.rtiaownid_desc,g_rtia_m.rtiacrtid_desc,g_rtia_m.rtiaowndp_desc,g_rtia_m.rtiacrtdp_desc, 
       g_rtia_m.rtiamodid_desc,g_rtia_m.rtiacnfid_desc,g_rtia_m.rtiapstid_desc
   
   #檢查是否允許此動作
   IF NOT artt622_action_chk() THEN
      CALL s_transaction_end('N','0')
      RETURN
   END IF
   
   #遮罩相關處理
   LET g_rtia_m_mask_o.* =  g_rtia_m.*
   CALL artt622_rtia_t_mask()
   LET g_rtia_m_mask_n.* =  g_rtia_m.*
   
   
   
   #add-point:modify段show之前 name="modify.before_show"
   IF g_rtia_m.rtiastus = 'A' OR g_rtia_m.rtiastus = 'W'THEN 
      RETURN 
   END IF 
   IF g_rtia_m.rtia048 = 'Y' THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = "art-00374"
      LET g_errparam.extend = ""
      LET g_errparam.popup = FALSE
      CALL cl_err()
      CLOSE artt622_cl
      CALL s_transaction_end('N','0')
      RETURN 
   END IF 
   LET l_n = 0
   #检查是否有付款资料
   SELECT COUNT(*) INTO l_n
     FROM rtif_t
    WHERE rtifent = g_enterprise
      AND rtifdocno = g_rtia_m.rtiadocno
   IF l_n > 0 THEN 
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'amm-00411'
      LET g_errparam.extend = ''
      LET g_errparam.popup = TRUE
      CALL cl_err()
      CLOSE artt622_cl
      CALL s_transaction_end('N','0')
      RETURN 
   END IF 
   #检查是否有收款资料
   LET l_n = 0
   SELECT COUNT(*) INTO l_n
     FROM rtif_t
    WHERE rtifent = g_enterprise
      AND rtifdocno = g_rtia_m.rtiadocno   
   IF l_n > 0 THEN 
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = "art-00397"
      LET g_errparam.extend = ""
      LET g_errparam.popup = FALSE
      CALL cl_err()
      CLOSE artt622_cl
      CALL s_transaction_end('N','0')
      RETURN
   END IF     
   #add by yangxf 20151127 ---start---   
   LET l_n = 0
   #检查折扣明细是否存在人工折价
   SELECT COUNT(*) INTO l_n
     FROM rtic_t,rtib_t
    WHERE rticent = rtibent
      AND rticseq = rtibseq
      AND rticdocno = rtibdocno
      AND rtic002 = '10'
      AND rtibdocno = g_rtia_m.rtiadocno
   IF l_n > 0 AND g_prog <> 'artt620' THEN 
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'art-00609'
      LET g_errparam.extend = ''
      LET g_errparam.popup = TRUE
      CALL cl_err()
      CLOSE artt622_cl
      CALL s_transaction_end('N','0')
      RETURN 
   END IF 
   #add by yangxf 20151127 ---end---
   #end add-point  
   
   #LET l_wc2_table1 = g_wc2_table1
   #LET g_wc2_table1 = " 1=1"
   #LET l_wc2_table2 = g_wc2_table2
   #LET l_wc2_table2 = " 1=1"
 
   #LET l_wc2_table3 = g_wc2_table3
   #LET l_wc2_table3 = " 1=1"
 
   #LET l_wc2_table4 = g_wc2_table4
   #LET l_wc2_table4 = " 1=1"
 
   #LET l_wc2_table5 = g_wc2_table5
   #LET l_wc2_table5 = " 1=1"
 
   #LET l_wc2_table6 = g_wc2_table6
   #LET l_wc2_table6 = " 1=1"
 
   #LET l_wc2_table7 = g_wc2_table7
   #LET l_wc2_table7 = " 1=1"
 
 
 
   
   CALL artt622_show()
   #add-point:modify段show之後 name="modify.after_show"
    let g_rtia_m.chantype='1'
    let g_chantype='1'
   #end add-point
   
   #LET g_wc2_table1 = l_wc2_table1
   #LET  g_wc2_table2 = l_wc2_table2 
 
   #LET  g_wc2_table3 = l_wc2_table3 
 
   #LET  g_wc2_table4 = l_wc2_table4 
 
   #LET  g_wc2_table5 = l_wc2_table5 
 
   #LET  g_wc2_table6 = l_wc2_table6 
 
   #LET  g_wc2_table7 = l_wc2_table7 
 
 
 
    
   WHILE TRUE
      LET g_rtiadocno_t = g_rtia_m.rtiadocno
 
      
      #寫入修改者/修改日期資訊(單頭)
      LET g_rtia_m.rtiamodid = g_user 
LET g_rtia_m.rtiamoddt = cl_get_current()
LET g_rtia_m.rtiamodid_desc = cl_get_username(g_rtia_m.rtiamodid)
      
      #add-point:modify段修改前 name="modify.before_input"
      LET g_sign = 'u'
      IF g_rtia_m.rtiastus  MATCHES "[DR]" THEN 
         LET g_rtia_m.rtiastus = 'N'
      END IF 
      #end add-point
      
      #欄位更改
      LET g_loc = 'n'
      LET g_update = FALSE
      LET g_master_commit = "N"
      CALL artt622_input("u")
      LET g_loc = 'n'
 
      #add-point:modify段修改後 name="modify.after_input"
                  LET g_sign = 't'
      #end add-point
      
      IF g_update OR NOT INT_FLAG THEN
         #若有modid跟moddt則進行update
         UPDATE rtia_t SET (rtiamodid,rtiamoddt) = (g_rtia_m.rtiamodid,g_rtia_m.rtiamoddt)
          WHERE rtiaent = g_enterprise AND rtiadocno = g_rtiadocno_t
 
      END IF
    
      IF INT_FLAG THEN
         CALL s_transaction_end('N','0')
         LET INT_FLAG = 0
         #若單頭無commit則還原
         IF g_master_commit = "N" THEN
            LET g_rtia_m.* = g_rtia_m_t.*
            CALL artt622_show()
         END IF
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = '' 
         LET g_errparam.code = 9001 
         LET g_errparam.popup = FALSE 
         CALL cl_err()
         RETURN
      END IF 
                  
      #若單頭key欄位有變更
      IF g_rtia_m.rtiadocno != g_rtia_m_t.rtiadocno
 
      THEN
         CALL s_transaction_begin()
         
         #add-point:單身fk修改前 name="modify.body.b_fk_update"
                  
         #end add-point
         
         #更新單身key值
         UPDATE rtib_t SET rtibdocno = g_rtia_m.rtiadocno
 
          WHERE rtibent = g_enterprise AND rtibdocno = g_rtia_m_t.rtiadocno
 
            
         #add-point:單身fk修改中 name="modify.body.m_fk_update"
                  
         #end add-point
 
         CASE
            WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
            #   INITIALIZE g_errparam TO NULL 
            #   LET g_errparam.extend = "rtib_t" 
            #   LET g_errparam.code = "std-00009" 
            #   LET g_errparam.popup = TRUE 
            #   CALL cl_err()
            #   CALL s_transaction_end('N','0')
            #   CONTINUE WHILE
            WHEN SQLCA.SQLCODE #其他錯誤
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "rtib_t:",SQLERRMESSAGE 
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
         
         UPDATE rtic_t
            SET rticdocno = g_rtia_m.rtiadocno
 
          WHERE rticent = g_enterprise AND
                rticdocno = g_rtiadocno_t
 
         #add-point:單身fk修改中 name="modify.body.m_fk_update2"
                  
         #end add-point
         CASE
            WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
            #   INITIALIZE g_errparam TO NULL 
            #   LET g_errparam.extend = "rtic_t" 
            #   LET g_errparam.code = "std-00009" 
            #   LET g_errparam.popup = TRUE 
            #   CALL cl_err()
            #   CALL s_transaction_end('N','0')
            #   CONTINUE WHILE
            WHEN SQLCA.SQLCODE #其他錯誤
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "rtic_t:",SQLERRMESSAGE 
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
            SET xrcddocno = g_rtia_m.rtiadocno
 
          WHERE xrcdent = g_enterprise AND
                xrcddocno = g_rtiadocno_t
 
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
 
         #更新單身key值
         #add-point:單身fk修改前 name="modify.body.b_fk_update4"
                  
         #end add-point
         
         UPDATE rtie_t
            SET rtiedocno = g_rtia_m.rtiadocno
 
          WHERE rtieent = g_enterprise AND
                rtiedocno = g_rtiadocno_t
 
         #add-point:單身fk修改中 name="modify.body.m_fk_update4"
                  
         #end add-point
         CASE
            WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
            #   INITIALIZE g_errparam TO NULL 
            #   LET g_errparam.extend = "rtie_t" 
            #   LET g_errparam.code = "std-00009" 
            #   LET g_errparam.popup = TRUE 
            #   CALL cl_err()
            #   CALL s_transaction_end('N','0')
            #   CONTINUE WHILE
            WHEN SQLCA.SQLCODE #其他錯誤
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "rtie_t:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE 
               LET g_errparam.popup = TRUE 
               CALL s_transaction_end('N','0')
               CALL cl_err()
               CONTINUE WHILE
         END CASE
         #add-point:單身fk修改後 name="modify.body.a_fk_update4"
                  
         #end add-point
 
         #更新單身key值
         #add-point:單身fk修改前 name="modify.body.b_fk_update5"
                  
         #end add-point
         
         UPDATE rtik_t
            SET rtikdocno = g_rtia_m.rtiadocno
 
          WHERE rtikent = g_enterprise AND
                rtikdocno = g_rtiadocno_t
 
         #add-point:單身fk修改中 name="modify.body.m_fk_update5"
                  
         #end add-point
         CASE
            WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
            #   INITIALIZE g_errparam TO NULL 
            #   LET g_errparam.extend = "rtik_t" 
            #   LET g_errparam.code = "std-00009" 
            #   LET g_errparam.popup = TRUE 
            #   CALL cl_err()
            #   CALL s_transaction_end('N','0')
            #   CONTINUE WHILE
            WHEN SQLCA.SQLCODE #其他錯誤
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "rtik_t:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE 
               LET g_errparam.popup = TRUE 
               CALL s_transaction_end('N','0')
               CALL cl_err()
               CONTINUE WHILE
         END CASE
         #add-point:單身fk修改後 name="modify.body.a_fk_update5"
                  
         #end add-point
 
         #更新單身key值
         #add-point:單身fk修改前 name="modify.body.b_fk_update6"
                  
         #end add-point
         
         UPDATE rtin_t
            SET rtindocno = g_rtia_m.rtiadocno
 
          WHERE rtinent = g_enterprise AND
                rtindocno = g_rtiadocno_t
 
         #add-point:單身fk修改中 name="modify.body.m_fk_update6"
                  
         #end add-point
         CASE
            WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
            #   INITIALIZE g_errparam TO NULL 
            #   LET g_errparam.extend = "rtin_t" 
            #   LET g_errparam.code = "std-00009" 
            #   LET g_errparam.popup = TRUE 
            #   CALL cl_err()
            #   CALL s_transaction_end('N','0')
            #   CONTINUE WHILE
            WHEN SQLCA.SQLCODE #其他錯誤
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "rtin_t:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE 
               LET g_errparam.popup = TRUE 
               CALL s_transaction_end('N','0')
               CALL cl_err()
               CONTINUE WHILE
         END CASE
         #add-point:單身fk修改後 name="modify.body.a_fk_update6"
                  
         #end add-point
 
         #更新單身key值
         #add-point:單身fk修改前 name="modify.body.b_fk_update7"
                  
         #end add-point
         
         UPDATE prek_t
            SET prekdocno = g_rtia_m.rtiadocno
 
          WHERE prekent = g_enterprise AND
                prekdocno = g_rtiadocno_t
 
         #add-point:單身fk修改中 name="modify.body.m_fk_update7"
                  
         #end add-point
         CASE
            WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
            #   INITIALIZE g_errparam TO NULL 
            #   LET g_errparam.extend = "prek_t" 
            #   LET g_errparam.code = "std-00009" 
            #   LET g_errparam.popup = TRUE 
            #   CALL cl_err()
            #   CALL s_transaction_end('N','0')
            #   CONTINUE WHILE
            WHEN SQLCA.SQLCODE #其他錯誤
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "prek_t:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE 
               LET g_errparam.popup = TRUE 
               CALL s_transaction_end('N','0')
               CALL cl_err()
               CONTINUE WHILE
         END CASE
         #add-point:單身fk修改後 name="modify.body.a_fk_update7"
                  
         #end add-point
 
 
         
 
         
         #UPDATE 多語言table key值
         
         
         
         
         
         
         
 
         CALL s_transaction_end('Y','0')
      END IF
    
      EXIT WHILE
   END WHILE
 
   #根據資料狀態切換action狀態
   CALL cl_set_act_visible("statechange,modify,modify_detail,delete,reproduce", TRUE)
   CALL artt622_set_act_visible()   
   CALL artt622_set_act_no_visible()
 
   #組合新增資料的條件
   LET g_add_browse = " rtiaent = " ||g_enterprise|| " AND",
                      " rtiadocno = '", g_rtia_m.rtiadocno, "' "
 
   #填到對應位置
   CALL artt622_browser_fill("")
 
   CLOSE artt622_cl
   
   CALL s_transaction_end('Y','0')
 
   #功能已完成,通報訊息中心
   CALL artt622_msgcentre_notify('modify')
 
END FUNCTION 
 
{</section>}
 
{<section id="artt622.input" >}
#+ 資料輸入
PRIVATE FUNCTION artt622_input(p_cmd)
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
         DEFINE l_sql            STRING
   DEFINE l_ooef004              LIKE ooef_t.ooef004
   DEFINE l_success              LIKE type_t.num5
   DEFINE l_ooef019              LIKE ooef_t.ooef019
   DEFINE l_xrcd103              LIKE xrcd_t.xrcd103,
          l_xrcd104              LIKE xrcd_t.xrcd104,
          l_xrcd105              LIKE xrcd_t.xrcd105,
          l_xrcd113              LIKE xrcd_t.xrcd113,
          l_xrcd114              LIKE xrcd_t.xrcd114,
          l_xrcd115              LIKE xrcd_t.xrcd115,
          l_imaa005              LIKE imaa_t.imaa005,
          l_xrcd123              LIKE xrcd_t.xrcd113,
          l_xrcd124              LIKE xrcd_t.xrcd114,
          l_xrcd125              LIKE xrcd_t.xrcd115,
          l_xrcd133              LIKE xrcd_t.xrcd113,
          l_xrcd134              LIKE xrcd_t.xrcd114,
          l_xrcd135              LIKE xrcd_t.xrcd115
   DEFINE l_mmaq003              LIKE mmaq_t.mmaq003
   DEFINE l_mmaq002              LIKE mmaq_t.mmaq002
   DEFINE l_card_point           LIKE rtia_t.rtia016
   DEFINE r_success              LIKE type_t.num5
   DEFINE l_oodb011              LIKE oodb_t.oodb011
   DEFINE l_rtib021              LIKE rtib_t.rtib021
   define l_l   int 
   DEFINE l_errno                LIKE type_t.chr10
   DEFINE l_price                LIKE rtib_t.rtib008
   DEFINE l_price1               LIKE rtib_t.rtib008
   DEFINE l_price2               LIKE rtib_t.rtib008
   DEFINE l_price3               LIKE rtib_t.rtib008
   DEFINE l_set_entry            LIKE type_t.num5       #add by yangxf 
   DEFINE l_rtia051_sum          LIKE rtia_t.rtia051    #add by yangxf 
   DEFINE l_rtif031_sum          LIKE rtif_t.rtif031    #add by yangxf
   DEFINE l_rtiasite             LIKE rtia_t.rtia001
   DEFINE l_rtiadocno            LIKE rtia_t.rtiadocno
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
   DISPLAY BY NAME g_rtia_m.rtiasite,g_rtia_m.rtiasite_desc,g_rtia_m.rtiadocdt,g_rtia_m.rtiadocno,g_rtia_m.rtia002, 
       g_rtia_m.rtia002_desc,g_rtia_m.rtia001,g_rtia_m.rtia001_desc,g_rtia_m.rtia059,g_rtia_m.rtia060, 
       g_rtia_m.mmaf003,g_rtia_m.mmaf004,g_rtia_m.rtia004,g_rtia_m.rtia004_desc,g_rtia_m.rtia005,g_rtia_m.rtia005_desc, 
       g_rtia_m.rtia006,g_rtia_m.rtia048,g_rtia_m.rtia053,g_rtia_m.rtiastus,g_rtia_m.rtia007,g_rtia_m.rtia008, 
       g_rtia_m.rtia009,g_rtia_m.rtia009_desc,g_rtia_m.rtia043,g_rtia_m.rtia047,g_rtia_m.l_rtia047,g_rtia_m.rtia013, 
       g_rtia_m.rtia014,g_rtia_m.rtia015,g_rtia_m.rtia016,g_rtia_m.rtia051,g_rtia_m.rtia010,g_rtia_m.rtia010_desc, 
       g_rtia_m.rtia011,g_rtia_m.rtia011_desc,g_rtia_m.rtia012,g_rtia_m.rtia012_desc,g_rtia_m.chantype, 
       g_rtia_m.barcode,g_rtia_m.rtia041,g_rtia_m.rtia017,g_rtia_m.rtia018,g_rtia_m.rtia018_desc,g_rtia_m.rtia019, 
       g_rtia_m.rtia020,g_rtia_m.rtia021,g_rtia_m.rtia022,g_rtia_m.rtia023,g_rtia_m.rtia024,g_rtia_m.rtia024_desc, 
       g_rtia_m.rtia025,g_rtia_m.rtia025_desc,g_rtia_m.rtia026,g_rtia_m.rtia027,g_rtia_m.rtia028,g_rtia_m.rtia029, 
       g_rtia_m.rtia030,g_rtia_m.rtia032,g_rtia_m.rtia033,g_rtia_m.rtia034,g_rtia_m.rtia035,g_rtia_m.rtia036, 
       g_rtia_m.rtia036_desc,g_rtia_m.rtia037,g_rtia_m.rtia037_desc,g_rtia_m.rtia038,g_rtia_m.rtia038_desc, 
       g_rtia_m.rtia039,g_rtia_m.rtia107,g_rtia_m.isaf009,g_rtia_m.isaf010,g_rtia_m.isaf044,g_rtia_m.isaf202, 
       g_rtia_m.isaf203,g_rtia_m.isaf204,g_rtia_m.isaf201,g_rtia_m.isaf207,g_rtia_m.rtiaownid,g_rtia_m.rtiaownid_desc, 
       g_rtia_m.rtiacrtid,g_rtia_m.rtiacrtid_desc,g_rtia_m.rtiaowndp,g_rtia_m.rtiaowndp_desc,g_rtia_m.rtiacrtdp, 
       g_rtia_m.rtiacrtdp_desc,g_rtia_m.rtiacrtdt,g_rtia_m.rtiamodid,g_rtia_m.rtiamodid_desc,g_rtia_m.rtiamoddt, 
       g_rtia_m.rtiacnfid,g_rtia_m.rtiacnfid_desc,g_rtia_m.rtiacnfdt,g_rtia_m.rtiapstid,g_rtia_m.rtiapstid_desc, 
       g_rtia_m.rtiapstdt,g_rtia_m.snum,g_rtia_m.amount,g_rtia_m.amount2,g_rtia_m.amount3
   
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
   LET g_forupd_sql = "SELECT rtibsite,rtibunit,rtiborga,rtibseq,rtib035,rtib042,rtib001,rtib002,rtib003, 
       rtib004,rtib005,rtib106,rtib012,rtib108,rtib013,rtib107,rtib008,rtib009,rtib010,rtib014,rtib015, 
       rtib016,rtib018,rtib017,rtib019,rtib020,rtib021,rtib031,rtib022,rtib024,rtib025,rtib026,rtib027, 
       rtib032,rtib033,rtib028,rtib030,rtib039,rtib006 FROM rtib_t WHERE rtibent=? AND rtibdocno=? AND  
       rtibseq=? FOR UPDATE"
   #add-point:input段define_sql name="input.after_define_sql"
      
   #end add-point 
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE artt622_bcl CURSOR FROM g_forupd_sql
   
   #add-point:input段define_sql name="input.define_sql2"
      
   #end add-point    
   LET g_forupd_sql = "SELECT rticseq,rticseq1,rtic001,rtic002,rtic003,rtic004,rtic005,rtic006,rtic007, 
       rtic008,rtic009,rtic010,rtic011,rtic012,rtic013,rtic014,rtic015,rtic016,rtic017,rtic018,rtic020  
       FROM rtic_t WHERE rticent=? AND rticdocno=? AND rticseq=? AND rticseq1=? FOR UPDATE"
   #add-point:input段define_sql name="input.after_define_sql2"
      
   #end add-point
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE artt622_bcl2 CURSOR FROM g_forupd_sql
 
   #add-point:input段define_sql name="input.define_sql3"
      
   #end add-point    
   LET g_forupd_sql = "SELECT xrcd007,xrcdld,xrcdseq,xrcdseq2,xrcd002,xrcd003,xrcd006,xrcd004,xrcd104  
       FROM xrcd_t WHERE xrcdent=? AND xrcddocno=? AND xrcdld=? AND xrcdseq=? AND xrcdseq2=? AND xrcd007=?  
       FOR UPDATE"
   #add-point:input段define_sql name="input.after_define_sql3"
      
   #end add-point
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE artt622_bcl3 CURSOR FROM g_forupd_sql
 
   #add-point:input段define_sql name="input.define_sql4"
      
   #end add-point    
   LET g_forupd_sql = "SELECT rtieseq,rtieseq1,rtie001,rtie002,rtie006 FROM rtie_t WHERE rtieent=? AND  
       rtiedocno=? AND rtieseq=? AND rtieseq1=? FOR UPDATE"
   #add-point:input段define_sql name="input.after_define_sql4"
      
   #end add-point
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE artt622_bcl4 CURSOR FROM g_forupd_sql
 
   #add-point:input段define_sql name="input.define_sql5"
      
   #end add-point    
   LET g_forupd_sql = "SELECT rtiksite,rtikunit,rtikorg,rtikseq,rtik001,rtik002,rtik003,rtik004,rtik005, 
       rtik006,rtik007,rtik013,rtik012,rtik008,rtik009,rtik010,rtik011,rtik014,rtik015,rtik016,rtik017, 
       rtik018,rtik019,rtik020,rtik021,rtik022,rtik023 FROM rtik_t WHERE rtikent=? AND rtikdocno=? AND  
       rtikseq=? FOR UPDATE"
   #add-point:input段define_sql name="input.after_define_sql5"
      
   #end add-point
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE artt622_bcl5 CURSOR FROM g_forupd_sql
 
   #add-point:input段define_sql name="input.define_sql6"
      
   #end add-point    
   LET g_forupd_sql = "SELECT rtinsite,rtinseq,rtinseq1,rtin001,rtin002,rtin003,rtin004,rtin005,rtin006, 
       rtin007,rtin008,rtin009,rtin010 FROM rtin_t WHERE rtinent=? AND rtindocno=? AND rtinseq=? AND  
       rtinseq1=? FOR UPDATE"
   #add-point:input段define_sql name="input.after_define_sql6"
      
   #end add-point
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE artt622_bcl6 CURSOR FROM g_forupd_sql
 
   #add-point:input段define_sql name="input.define_sql7"
      
   #end add-point    
   LET g_forupd_sql = "SELECT preksite,prekunit,prekseq,prek001,prek002,prek003,prek004 FROM prek_t  
       WHERE prekent=? AND prekdocno=? AND prekseq=? FOR UPDATE"
   #add-point:input段define_sql name="input.after_define_sql7"
      
   #end add-point
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE artt622_bcl7 CURSOR FROM g_forupd_sql
 
 
   
 
 
   #add-point:input段define_sql name="input.other_sql"
      
   #end add-point 
 
   LET l_allow_insert = cl_auth_detail_input("insert")
   LET l_allow_delete = cl_auth_detail_input("delete")
   LET g_qryparam.state = 'i'
   
   #控制key欄位可否輸入
   CALL artt622_set_entry(p_cmd)
   #add-point:set_entry後 name="input.after_set_entry"
   #add by yangxf ---start---
   IF NOT cl_null(g_rtia_m.rtia025) THEN 
      CALL artt622_set_required()   
   END IF 
   #add by yangxf ---end----
   #end add-point
   CALL artt622_set_no_entry(p_cmd)
 
   DISPLAY BY NAME g_rtia_m.rtiasite,g_rtia_m.rtiadocdt,g_rtia_m.rtiadocno,g_rtia_m.rtia001,g_rtia_m.rtia059, 
       g_rtia_m.rtia060,g_rtia_m.rtia004,g_rtia_m.rtia005,g_rtia_m.rtia006,g_rtia_m.rtia053,g_rtia_m.rtiastus, 
       g_rtia_m.rtia007,g_rtia_m.rtia009,g_rtia_m.rtia043,g_rtia_m.rtia047,g_rtia_m.rtia051,g_rtia_m.rtia010, 
       g_rtia_m.rtia011,g_rtia_m.rtia012,g_rtia_m.chantype,g_rtia_m.barcode,g_rtia_m.rtia041,g_rtia_m.rtia017, 
       g_rtia_m.rtia018,g_rtia_m.rtia019,g_rtia_m.rtia020,g_rtia_m.rtia021,g_rtia_m.rtia022,g_rtia_m.rtia023, 
       g_rtia_m.rtia024,g_rtia_m.rtia025,g_rtia_m.rtia026,g_rtia_m.rtia027,g_rtia_m.rtia028,g_rtia_m.rtia029, 
       g_rtia_m.rtia030,g_rtia_m.rtia032,g_rtia_m.rtia033,g_rtia_m.rtia034,g_rtia_m.rtia035,g_rtia_m.rtia036, 
       g_rtia_m.rtia037,g_rtia_m.rtia038,g_rtia_m.rtia107
   
   LET lb_reproduce = FALSE
   LET l_ac_t = 1
   
   #關閉被遮罩相關欄位輸入, 無法確定USER是否會需要輸入此欄位
   #因此先行關閉, 若有需要可於下方add-point中自行開啟
   CALL cl_mask_set_no_entry()
   
   #add-point:資料輸入前 name="input.before_input"
   DISPLAY BY NAME g_rtia_m.rtiaownid,g_rtia_m.rtiaowndp,g_rtia_m.rtiacrtid,g_rtia_m.rtiacrtdp,g_rtia_m.rtiacrtdt,
                   g_rtia_m.rtia048,g_rtia_m.rtia016,g_rtia_m.rtia039
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_rtia_m.rtiaownid
   CALL ap_ref_array2(g_ref_fields,"SELECT ooag011 FROM ooag_t WHERE ooagent='"||g_enterprise||"' AND ooag001=? ","") RETURNING g_rtn_fields
   LET g_rtia_m.rtiaownid_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_rtia_m.rtiaownid_desc

   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_rtia_m.rtiaowndp
   CALL ap_ref_array2(g_ref_fields,"SELECT ooeal003 FROM ooeal_t WHERE ooealent='"||g_enterprise||"' AND ooeal001=? AND ooeal002='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_rtia_m.rtiaowndp_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_rtia_m.rtiaowndp_desc

   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_rtia_m.rtiacrtid
   CALL ap_ref_array2(g_ref_fields,"SELECT ooag011 FROM ooag_t WHERE ooagent='"||g_enterprise||"' AND ooag001=? ","") RETURNING g_rtn_fields
   LET g_rtia_m.rtiacrtid_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_rtia_m.rtiacrtid_desc

   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_rtia_m.rtiacrtdp
   CALL ap_ref_array2(g_ref_fields,"SELECT ooeal003 FROM ooeal_t WHERE ooealent='"||g_enterprise||"' AND ooeal001=? AND ooeal002='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_rtia_m.rtiacrtdp_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_rtia_m.rtiacrtdp_desc
   #end add-point
   
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
 
{</section>}
 
{<section id="artt622.input.head" >}
      #單頭段
      INPUT BY NAME g_rtia_m.rtiasite,g_rtia_m.rtiadocdt,g_rtia_m.rtiadocno,g_rtia_m.rtia001,g_rtia_m.rtia059, 
          g_rtia_m.rtia060,g_rtia_m.rtia004,g_rtia_m.rtia005,g_rtia_m.rtia006,g_rtia_m.rtia053,g_rtia_m.rtiastus, 
          g_rtia_m.rtia007,g_rtia_m.rtia009,g_rtia_m.rtia043,g_rtia_m.rtia047,g_rtia_m.rtia051,g_rtia_m.rtia010, 
          g_rtia_m.rtia011,g_rtia_m.rtia012,g_rtia_m.chantype,g_rtia_m.barcode,g_rtia_m.rtia041,g_rtia_m.rtia017, 
          g_rtia_m.rtia018,g_rtia_m.rtia019,g_rtia_m.rtia020,g_rtia_m.rtia021,g_rtia_m.rtia022,g_rtia_m.rtia023, 
          g_rtia_m.rtia024,g_rtia_m.rtia025,g_rtia_m.rtia026,g_rtia_m.rtia027,g_rtia_m.rtia028,g_rtia_m.rtia029, 
          g_rtia_m.rtia030,g_rtia_m.rtia032,g_rtia_m.rtia033,g_rtia_m.rtia034,g_rtia_m.rtia035,g_rtia_m.rtia036, 
          g_rtia_m.rtia037,g_rtia_m.rtia038,g_rtia_m.rtia107 
         ATTRIBUTE(WITHOUT DEFAULTS)
         
         #自訂ACTION(master_input)
         
     
         BEFORE INPUT
            IF s_transaction_chk("N",0) THEN
               CALL s_transaction_begin()
            END IF
            OPEN artt622_cl USING g_enterprise,g_rtia_m.rtiadocno
            IF SQLCA.SQLCODE THEN   #(ver:78)
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "OPEN artt622_cl:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE   #(ver:78)
               LET g_errparam.popup = TRUE 
               CLOSE artt622_cl
               CALL s_transaction_end('N','0')
               CALL cl_err()
               RETURN
            END IF
            
            IF l_cmd_t = 'r' THEN
               
            END IF
            #因應離開單頭後已寫入資料庫, 若重新回到單頭則視為修改
            #因此需於此處開啟/關閉欄位
            CALL artt622_set_entry(p_cmd)
            #add-point:資料輸入前 name="input.m.before_input"
            IF NOT cl_null(g_rtia_m.rtia017) THEN 
               CALL artt622_rtia017_set()
            END IF 
            
            #end add-point
            CALL artt622_set_no_entry(p_cmd)
    
                  #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtiasite
            
            #add-point:AFTER FIELD rtiasite name="input.a.rtiasite"
            IF NOT cl_null(g_rtia_m.rtiasite) THEN
#               CALL artt622_rtiasite_chk()
#               IF NOT cl_null(g_errno) THEN
#                  INITIALIZE g_errparam TO NULL
#                  LET g_errparam.code = g_errno
#                  LET g_errparam.extend = ''
#                  LET g_errparam.popup = TRUE
#                  CALL cl_err()
#
#                  LET g_rtia_m.rtiasite = g_rtia_m_t.rtiasite
#                  NEXT FIELD rtiasite
#               END IF 
#               CALL cl_set_comp_entry("rtiasite",FALSE)
               CALL s_aooi500_chk(g_prog,'rtiasite',g_rtia_m.rtiasite,g_rtia_m.rtiasite) RETURNING l_success,l_errno
               IF NOT l_success THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.extend = g_rtia_m.rtiasite
                  LET g_errparam.code   = l_errno
                  LET g_errparam.popup  = TRUE
                  CALL cl_err()

                  LET g_rtia_m.rtiasite = g_rtia_m_t.rtiasite
                  CALL s_desc_get_department_desc(g_rtia_m.rtiasite) RETURNING g_rtia_m.rtiasite_desc
                  DISPLAY BY NAME g_rtia_m.rtiasite,g_rtia_m.rtiasite_desc
                  NEXT FIELD CURRENT
               END IF
               CALL artt622_rtia002_display()
               LET g_site_flag = TRUE
               CALL artt622_set_entry(p_cmd)
               CALL artt622_set_no_entry(p_cmd)
            ELSE 
               NEXT FIELD rtiasite           
            END IF
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_rtia_m.rtiasite
            CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002 = '"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_rtia_m.rtiasite_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_rtia_m.rtiasite_desc
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtiasite
            #add-point:BEFORE FIELD rtiasite name="input.b.rtiasite"
                        
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE rtiasite
            #add-point:ON CHANGE rtiasite name="input.g.rtiasite"
                        
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtiadocdt
            #add-point:BEFORE FIELD rtiadocdt name="input.b.rtiadocdt"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtiadocdt
            
            #add-point:AFTER FIELD rtiadocdt name="input.a.rtiadocdt"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE rtiadocdt
            #add-point:ON CHANGE rtiadocdt name="input.g.rtiadocdt"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtiadocno
            #add-point:BEFORE FIELD rtiadocno name="input.b.rtiadocno"
                        
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtiadocno
            
            #add-point:AFTER FIELD rtiadocno name="input.a.rtiadocno"
                                    #此段落由子樣板a05產生
            IF  NOT cl_null(g_rtia_m.rtiadocno) THEN 
                LET l_ooef004 = ""
                SELECT ooef004 INTO l_ooef004
                  FROM ooef_t
                 WHERE ooef001 = g_rtia_m.rtiasite
                   AND ooefent = g_enterprise
               CALL s_aooi200_chk_slip(g_rtia_m.rtiasite,l_ooef004,g_rtia_m.rtiadocno,g_prog) RETURNING l_success
               IF NOT l_success THEN
                  LET g_rtia_m.rtiadocno = g_rtiadocno_t
                  NEXT FIELD CURRENT
               END IF
               IF p_cmd = 'a' OR ( p_cmd = 'u' AND (g_rtia_m.rtiadocno != g_rtiadocno_t )) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM rtia_t WHERE "||"rtiaent = '" ||g_enterprise|| "' AND "||"rtiadocno = '"||g_rtia_m.rtiadocno ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF

            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE rtiadocno
            #add-point:ON CHANGE rtiadocno name="input.g.rtiadocno"
                        
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtia001
            
            #add-point:AFTER FIELD rtia001 name="input.a.rtia001"
            IF NOT cl_null(g_rtia_m.rtia001) THEN
               LET l_n = 0            
               SELECT COUNT(*) INTO l_n
                 FROM mmaq_t LEFT OUTER JOIN mmaf_t ON mmaq003 = mmaf001 AND mmafent = mmaqent
                WHERE mmaqent = g_enterprise 
                  AND mmaq006 = '3'
                  AND mmaq001 =  g_rtia_m.rtia001                 
               IF l_n = 0 THEN 
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'art-00222'
                  LET g_errparam.extend = ''
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  NEXT FIELD rtia001
               END IF
               if g_prog='artt622'  then 
                  let l_rtiadocno=''
                  let l_rtiasite=''
                  SELECT rtiasite,rtiadocno INTO l_rtiasite,l_rtiadocno
                  FROM rtia_t
                  WHERE rtia001=g_rtia_m.rtia001
                    AND rtiastus='N'
                    AND rtia000='artt622'
                    AND rtiaent=g_enterprise #160905-00007#15 by 08172
                  IF NOT cl_null(l_rtiadocno) AND l_rtiadocno<>g_rtia_m.rtiadocno THEN 
                     INITIALIZE g_errparam TO NULL     
                     LET g_errparam.extend = l_rtiadocno
                     LET g_errparam.code = 'art-00795'
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                     NEXT FIELD rtia001
                  END IF
               end if                
               SELECT mmaq003,mmaq018 INTO l_mmaq003,g_rtia_m.rtia043
                 FROM mmaq_t
                WHERE mmaq001 = g_rtia_m.rtia001
                  AND mmaqent = g_enterprise
               IF g_rtia_m.rtia043 - g_rtia_m.rtia047 < 0 THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'wss-00130'
                  LET g_errparam.extend = ''
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  NEXT FIELD rtia001
               END IF   
               LET g_rtia_m.l_rtia047 = g_rtia_m.rtia043 - g_rtia_m.rtia047
               DISPLAY BY NAME g_rtia_m.rtia043,g_rtia_m.rtia047,g_rtia_m.l_rtia047
               #获取会员姓名及大宗客户编号
               INITIALIZE g_ref_fields TO NULL
               LET g_ref_fields[1] = l_mmaq003
               CALL ap_ref_array2(g_ref_fields,"SELECT mmaf008,mmaf016,mmaf010,mmaf011,mmaf014 FROM mmaf_t WHERE mmafent='"||g_enterprise||"' AND mmaf001=? ","") RETURNING g_rtn_fields
               LET g_rtia_m.rtia001_desc = g_rtn_fields[1]
               LET g_rtia_m.rtia002 = g_rtn_fields[2]
               LET g_rtia_m.rtia019 = g_rtn_fields[3]
               LET g_rtia_m.rtia020 = g_rtn_fields[4]
               LET g_rtia_m.rtia021 = g_rtn_fields[1]
               LET g_rtia_m.rtia022 = g_rtn_fields[5]
               
               DISPLAY BY NAME g_rtia_m.rtia001_desc,g_rtia_m.rtia019,g_rtia_m.rtia020,g_rtia_m.rtia021,g_rtia_m.rtia022
               IF cl_null(g_rtia_m.rtia002) THEN 
                  #抓取销售据点对应的散客
                  SELECT ooef108 INTO g_rtia_m.rtia002
                    FROM ooef_t
                   WHERE ooefent = g_enterprise
                     AND ooef001 = g_rtia_m.rtiasite
               END IF 
               IF cl_null(g_rtia_m.rtia002) THEN 
                  LET g_rtia_m.rtia001 = g_rtia_m_t.rtia001
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'art-00223'
                  LET g_errparam.extend = ''
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  NEXT FIELD rtia001
               ELSE
                  #客户带值
                  CALL artt622_rtia002_display()
               END IF 
               #抓取客户名称
               INITIALIZE g_ref_fields TO NULL
               LET g_ref_fields[1] = g_rtia_m.rtia002
               CALL ap_ref_array2(g_ref_fields,"SELECT pmaal004 FROM pmaal_t WHERE pmaalent='"||g_enterprise||"' AND pmaal001=? AND pmaal002='"||g_dlang||"'","") RETURNING g_rtn_fields
               LET g_rtia_m.rtia002_desc = '', g_rtn_fields[1] , ''
               DISPLAY BY NAME g_rtia_m.rtia001_desc,g_rtia_m.rtia002,g_rtia_m.rtia002_desc
               CALL cl_set_comp_entry("rtia002",FALSE)
               #150429-00007#9--dongsz add--s
               #带出顾客姓名和电话
               SELECT mmaf008,mmaf014,mmaf003,mmaf004 INTO g_rtia_m.rtia059,g_rtia_m.rtia060,g_rtia_m.mmaf003,g_rtia_m.mmaf004
                 FROM mmaf_t,mmaq_t
                WHERE mmafent = mmaqent
                  AND mmaf001 = mmaq003
                  AND mmaqent = g_enterprise
                  AND mmaq001 = g_rtia_m.rtia001
                display by name g_rtia_m.rtia059,g_rtia_m.rtia060,g_rtia_m.mmaf003,g_rtia_m.mmaf004
               #150429-00007#9--dongsz add--e
            ELSE
               LET g_rtia_m.rtia001_desc =  ''
               DISPLAY BY NAME g_rtia_m.rtia001_desc
               CALL cl_set_comp_entry("rtia002",TRUE)
            END IF
            LET g_rtia_m_o.* = g_rtia_m.*    #160824-00007#172 Add By Ken 161107
            NEXT FIELD barcode            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtia001
            #add-point:BEFORE FIELD rtia001 name="input.b.rtia001"
                                    IF cl_null(g_rtia_m.rtiasite) THEN            
               NEXT FIELD rtiasite
            END IF 
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE rtia001
            #add-point:ON CHANGE rtia001 name="input.g.rtia001"
                        
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtia059
            #add-point:BEFORE FIELD rtia059 name="input.b.rtia059"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtia059
            
            #add-point:AFTER FIELD rtia059 name="input.a.rtia059"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE rtia059
            #add-point:ON CHANGE rtia059 name="input.g.rtia059"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtia060
            #add-point:BEFORE FIELD rtia060 name="input.b.rtia060"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtia060
            
            #add-point:AFTER FIELD rtia060 name="input.a.rtia060"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE rtia060
            #add-point:ON CHANGE rtia060 name="input.g.rtia060"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtia004
            
            #add-point:AFTER FIELD rtia004 name="input.a.rtia004"
            IF NOT cl_null(g_rtia_m.rtia004) THEN 
               CALL artt622_rtia004_chk()
               IF NOT cl_null(g_errno) THEN 
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = g_errno
                  LET g_errparam.extend = ''
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  LET g_rtia_m.rtia004 = g_rtia_m_t.rtia004
                  NEXT FIELD rtia004
               END IF 
            END IF 
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_rtia_m.rtia004
            CALL ap_ref_array2(g_ref_fields,"SELECT ooag011 FROM ooag_t WHERE ooagent='"||g_enterprise||"' AND ooag001=? ","") RETURNING g_rtn_fields
            LET g_rtia_m.rtia004_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_rtia_m.rtia004_desc
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtia004
            #add-point:BEFORE FIELD rtia004 name="input.b.rtia004"
                        
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE rtia004
            #add-point:ON CHANGE rtia004 name="input.g.rtia004"
                        
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtia005
            
            #add-point:AFTER FIELD rtia005 name="input.a.rtia005"
            IF NOT cl_null(g_rtia_m.rtia005) THEN 
               CALL artt622_rtia005_chk()
               IF NOT cl_null(g_errno) THEN 
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = g_errno
                  LET g_errparam.extend = ''
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  LET g_rtia_m.rtia005 = g_rtia_m_t.rtia005
                  NEXT FIELD rtia005
               END IF 
            END IF 
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_rtia_m.rtia005
            CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_rtia_m.rtia005_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_rtia_m.rtia005_desc
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtia005
            #add-point:BEFORE FIELD rtia005 name="input.b.rtia005"
                        
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE rtia005
            #add-point:ON CHANGE rtia005 name="input.g.rtia005"
                        
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtia006
            #add-point:BEFORE FIELD rtia006 name="input.b.rtia006"
                        
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtia006
            
            #add-point:AFTER FIELD rtia006 name="input.a.rtia006"
                        
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE rtia006
            #add-point:ON CHANGE rtia006 name="input.g.rtia006"
                        
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtia053
            #add-point:BEFORE FIELD rtia053 name="input.b.rtia053"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtia053
            
            #add-point:AFTER FIELD rtia053 name="input.a.rtia053"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE rtia053
            #add-point:ON CHANGE rtia053 name="input.g.rtia053"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtiastus
            #add-point:BEFORE FIELD rtiastus name="input.b.rtiastus"
                        
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtiastus
            
            #add-point:AFTER FIELD rtiastus name="input.a.rtiastus"
                        
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE rtiastus
            #add-point:ON CHANGE rtiastus name="input.g.rtiastus"
                        
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtia007
            #add-point:BEFORE FIELD rtia007 name="input.b.rtia007"
 
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtia007
            
            #add-point:AFTER FIELD rtia007 name="input.a.rtia007"
            IF NOT cl_null(g_rtia_m.rtia007) THEN 
               CALL artt622_rtia007_chk()
               IF NOT cl_null(g_errno) THEN 
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = g_errno
                  LET g_errparam.extend = ''
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  #LET g_rtia_m.rtia007 = g_rtia_m_t.rtia007  #160824-00007#172 Mark By Ken 161107
                  LET g_rtia_m.rtia007 = g_rtia_m_o.rtia007   #160824-00007#172 Add By Ken 161107
                  NEXT FIELD rtia007
               END IF 
               
               #150424-00020#2--add by dongsz--str---
               #IF p_cmd = 'a' OR (p_cmd = 'u' AND (g_rtia_m.rtia007 != g_rtia_m_t.rtia007 OR cl_null(g_rtia_m_t.rtia007))) THEN    #160824-00007#172 Mark By Ken 161107
               IF (g_rtia_m.rtia007 != g_rtia_m_o.rtia007 OR cl_null(g_rtia_m_o.rtia007)) THEN    #160824-00007#172 Add By Ken 161107
                  CALL artt622_rtia007_ref()
               END IF
               #150424-00020#2--add by dongsz--end---
            END IF 
            #20150630--add by yangxf--str---
            IF NOT cl_null(g_rtia_m.rtia007) THEN 
               CALL cl_set_comp_entry("rtia001,rtia002",FALSE)
            ELSE
               CALL cl_set_comp_entry("rtia001,rtia002",TRUE)
               IF NOT cl_null(g_rtia_m.rtia001) THEN 
                  CALL cl_set_comp_entry("rtia002",FALSE)
               END IF 
            END IF 
            #20150630--add by yangxf--end---
            LET g_rtia_m_o.* = g_rtia_m.*    #160824-00007#172 Add By Ken 161107
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE rtia007
            #add-point:ON CHANGE rtia007 name="input.g.rtia007"
                        
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtia009
            
            #add-point:AFTER FIELD rtia009 name="input.a.rtia009"
            IF NOT cl_null(g_rtia_m.rtia009) THEN 
               CALL artt622_rtia009_chk()
               IF NOT cl_null(g_errno) THEN 
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = g_errno
                  LET g_errparam.extend = ''
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  LET g_rtia_m.rtia009 = g_rtia_m_t.rtia009
                  NEXT FIELD rtia009
               END IF 
            END IF 
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_rtia_m.rtia009
            CALL ap_ref_array2(g_ref_fields,"SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001='295' AND oocql002=? AND oocql003='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_rtia_m.rtia009_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_rtia_m.rtia009_desc

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtia009
            #add-point:BEFORE FIELD rtia009 name="input.b.rtia009"
                        
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE rtia009
            #add-point:ON CHANGE rtia009 name="input.g.rtia009"
                        
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtia043
            #add-point:BEFORE FIELD rtia043 name="input.b.rtia043"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtia043
            
            #add-point:AFTER FIELD rtia043 name="input.a.rtia043"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE rtia043
            #add-point:ON CHANGE rtia043 name="input.g.rtia043"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtia047
            #add-point:BEFORE FIELD rtia047 name="input.b.rtia047"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtia047
            
            #add-point:AFTER FIELD rtia047 name="input.a.rtia047"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE rtia047
            #add-point:ON CHANGE rtia047 name="input.g.rtia047"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtia051
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_rtia_m.rtia051,"0","1","","","azz-00079",1) THEN
               NEXT FIELD rtia051
            END IF 
 
 
 
            #add-point:AFTER FIELD rtia051 name="input.a.rtia051"
            IF NOT cl_null(g_rtia_m.rtia051) THEN 
               IF NOT cl_null(g_rtia_m.rtia007) THEN
                  LET l_rtia051_sum = ''
                  LET l_rtif031_sum = ''
                  SELECT SUM(rtif031) INTO l_rtif031_sum
                    FROM rtif_t
                   WHERE rtifent = g_enterprise
                     AND rtif001 = '91'
                     AND rtifdocno = g_rtia_m.rtia007
                  IF cl_null(l_rtif031_sum) THEN 
                     LET l_rtif031_sum = 0
                  END IF 
                  IF NOT cl_null(g_rtia_m.rtiadocno) THEN 
                     #已回款金额
                     SELECT SUM(rtia051) INTO l_rtia051_sum
                       FROM rtia_t
                      WHERE rtiaent = g_enterprise
                        AND rtia007 = g_rtia_m.rtia007
                        AND rtia000 = 'artt800'
                        AND rtiastus <> 'X'
                        AND rtiadocno <> g_rtia_m.rtiadocno
                  ELSE
                     #已回款金额
                     SELECT SUM(rtia051) INTO l_rtia051_sum
                       FROM rtia_t
                      WHERE rtiaent = g_enterprise
                        AND rtia007 = g_rtia_m.rtia007
                        AND rtia000 = 'artt800'
                        AND rtiastus <> 'X'
                  END IF 
                  IF cl_null(l_rtia051_sum) THEN 
                     LET l_rtia051_sum = 0
                  END IF 
                  IF l_rtif031_sum - l_rtia051_sum < g_rtia_m.rtia051 THEN 
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = 'art-00600'
                     LET g_errparam.extend = ''
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                     LET g_rtia_m.rtia051 = g_rtia_m_t.rtia051
                     NEXT FIELD rtia051
                  END IF 
               END IF 
            END IF 


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtia051
            #add-point:BEFORE FIELD rtia051 name="input.b.rtia051"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE rtia051
            #add-point:ON CHANGE rtia051 name="input.g.rtia051"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtia010
            
            #add-point:AFTER FIELD rtia010 name="input.a.rtia010"
            IF NOT cl_null(g_rtia_m.rtia010) THEN 
               CALL artt622_rtia010_chk()
               IF NOT cl_null(g_errno) THEN 
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = g_errno
                  LET g_errparam.extend = ''
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  #LET g_rtia_m.rtia010 = g_rtia_m_t.rtia010   #160824-00007#172 Mark By Ken 161107
                  LET g_rtia_m.rtia010 = g_rtia_m_o.rtia010    #160824-00007#172 Add By Ken 161107
                  NEXT FIELD rtia010
               END IF
            END IF                
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_rtia_m.rtia010
            CALL ap_ref_array2(g_ref_fields,"SELECT pmaal004 FROM pmaal_t WHERE pmaalent='"||g_enterprise||"' AND pmaal001=? AND pmaal002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_rtia_m.rtia010_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_rtia_m.rtia010_desc
            LET g_rtia_m_o.* = g_rtia_m.*    #160824-00007#172 Add By Ken 161107
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtia010
            #add-point:BEFORE FIELD rtia010 name="input.b.rtia010"
                        
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE rtia010
            #add-point:ON CHANGE rtia010 name="input.g.rtia010"
                        
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtia011
            
            #add-point:AFTER FIELD rtia011 name="input.a.rtia011"
            IF NOT cl_null(g_rtia_m.rtia011) THEN 
               CALL artt622_rtia011_chk() 
               IF NOT cl_null(g_errno) THEN 
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = g_errno
                  LET g_errparam.extend = ''
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  #LET g_rtia_m.rtia011 = g_rtia_m_t.rtia011   #160824-00007#172 Mark By Ken 161107
                  LET g_rtia_m.rtia011 = g_rtia_m_o.rtia011    #160824-00007#172 Add By Ken 161107 
                  NEXT FIELD rtia011
               END IF 
            END IF 
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_rtia_m.rtia011
            CALL ap_ref_array2(g_ref_fields,"SELECT pmaal004 FROM pmaal_t WHERE pmaalent='"||g_enterprise||"' AND pmaal001=? AND pmaal002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_rtia_m.rtia011_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_rtia_m.rtia011_desc
            LET g_rtia_m_o.* = g_rtia_m.*    #160824-00007#172 Add By Ken 161107
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtia011
            #add-point:BEFORE FIELD rtia011 name="input.b.rtia011"
                        
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE rtia011
            #add-point:ON CHANGE rtia011 name="input.g.rtia011"
                        
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtia012
            
            #add-point:AFTER FIELD rtia012 name="input.a.rtia012"
            IF NOT cl_null(g_rtia_m.rtia012) THEN 
               CALL artt622_rtia012_chk()
               IF NOT cl_null(g_errno) THEN 
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = g_errno
                  LET g_errparam.extend = ''
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  #LET g_rtia_m.rtia012 = g_rtia_m_t.rtia012   #160824-00007#172 Mark By Ken 161107
                  LET g_rtia_m.rtia012 = g_rtia_m_o.rtia012    #160824-00007#172 Add By Ken 161107
                  NEXT FIELD rtia012
               END IF
            END IF             
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_rtia_m.rtia012
            CALL ap_ref_array2(g_ref_fields,"SELECT pmaal004 FROM pmaal_t WHERE pmaalent='"||g_enterprise||"' AND pmaal001=? AND pmaal002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_rtia_m.rtia012_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_rtia_m.rtia012_desc
            LET g_rtia_m_o.* = g_rtia_m.*    #160824-00007#172 Add By Ken 161107
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtia012
            #add-point:BEFORE FIELD rtia012 name="input.b.rtia012"
                        
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE rtia012
            #add-point:ON CHANGE rtia012 name="input.g.rtia012"
                        
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD chantype
            #add-point:BEFORE FIELD chantype name="input.b.chantype"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD chantype
            
            #add-point:AFTER FIELD chantype name="input.a.chantype"
         let g_chantype = g_rtia_m.chantype
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE chantype
            #add-point:ON CHANGE chantype name="input.g.chantype"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD barcode
            #add-point:BEFORE FIELD barcode name="input.b.barcode"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD barcode
            
            #add-point:AFTER FIELD barcode name="input.a.barcode"
        let g_barcode = g_rtia_m.barcode
       
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE barcode
            #add-point:ON CHANGE barcode name="input.g.barcode"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtia041
            #add-point:BEFORE FIELD rtia041 name="input.b.rtia041"
                        
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtia041
            
            #add-point:AFTER FIELD rtia041 name="input.a.rtia041"
                        
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE rtia041
            #add-point:ON CHANGE rtia041 name="input.g.rtia041"
                        
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtia017
            #add-point:BEFORE FIELD rtia017 name="input.b.rtia017"
                        
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtia017
            
            #add-point:AFTER FIELD rtia017 name="input.a.rtia017"
                                    
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE rtia017
            #add-point:ON CHANGE rtia017 name="input.g.rtia017"
            IF NOT cl_null(g_rtia_m.rtia017) THEN 
               CALL artt622_rtia017_set()
               LET g_rtia_m.rtia018 = ''
               LET g_rtia_m.rtia018_desc = ''
               DISPLAY BY NAME g_rtia_m.rtia018,g_rtia_m.rtia018_desc
            END IF 
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtia018
            
            #add-point:AFTER FIELD rtia018 name="input.a.rtia018"
            IF NOT cl_null(g_rtia_m.rtia018) THEN 
                IF s_aooi500_setpoint(g_prog,'rtia018') THEN
                   CALL s_aooi500_chk(g_prog,'rtia018',g_rtia_m.rtia018,g_rtia_m.rtiasite) RETURNING l_success,l_errno
                   IF NOT l_success THEN
                      INITIALIZE g_errparam TO NULL
                      LET g_errparam.extend = g_rtia_m.rtia018
                      LET g_errparam.code   = l_errno
                      LET g_errparam.popup  = TRUE
                      CALL cl_err()
                   
                      #LET g_rtia_m.rtia018 = g_rtia_m_t.rtia018  #160824-00007#172 Mark By Ken 161107
                      LET g_rtia_m.rtia018 = g_rtia_m_o.rtia018   #160824-00007#172 Add By Ken 161107
                      CALL s_desc_get_department_desc(g_rtia_m.rtia018) RETURNING g_rtia_m.rtia018_desc
                      DISPLAY BY NAME g_rtia_m.rtia018,g_rtia_m.rtia018_desc
                      NEXT FIELD CURRENT
                   END IF
                   
                   LET g_site_flag = TRUE
                   CALL artt622_set_entry(p_cmd)
                   CALL artt622_set_no_entry(p_cmd)
                ELSE
                   CALL artt622_rtia018_chk()
                   IF NOT cl_null(g_errno) THEN 
                      INITIALIZE g_errparam TO NULL
                      LET g_errparam.code = g_errno
                      LET g_errparam.extend = ''
                      LET g_errparam.popup = TRUE
                      CALL cl_err()
                   
                      #LET g_rtia_m.rtia018 = g_rtia_m_t.rtia018  #160824-00007#172 Mark By Ken 161107
                      LET g_rtia_m.rtia018 = g_rtia_m_o.rtia018   #160824-00007#172 Add By Ken 161107
                      NEXT FIELD rtia018
                   END IF 
                END IF
            END IF 
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_rtia_m.rtia018
            IF g_rtia_m.rtia017 = '4' THEN 
               CALL ap_ref_array2(g_ref_fields,"SELECT pmaal004 FROM pmaal_t WHERE pmaalent='"||g_enterprise||"' AND pmaal001=? AND pmaal002='"||g_dlang||"'","") RETURNING g_rtn_fields
            #160913-00034#7 -S
            INITIALIZE g_chkparam.* TO NULL
            LET g_chkparam.arg1 = g_rtia_m.rtia018
            IF  cl_chk_exist("v_pmaa001_1") THEN
                  #檢查成功時後續處理 
               ELSE
                  #檢查失敗時後續處理
                  NEXT FIELD CURRENT
            END IF
            #160913-00034#7 -E
            ELSE          
               CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
            END IF
            LET g_rtia_m.rtia018_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_rtia_m.rtia018_desc
            LET g_rtia_m_o.* = g_rtia_m.*    #160824-00007#172 Add By Ken 161107
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtia018
            #add-point:BEFORE FIELD rtia018 name="input.b.rtia018"
                        
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE rtia018
            #add-point:ON CHANGE rtia018 name="input.g.rtia018"
                        
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtia019
            #add-point:BEFORE FIELD rtia019 name="input.b.rtia019"
                        
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtia019
            
            #add-point:AFTER FIELD rtia019 name="input.a.rtia019"
            IF NOT cl_null(g_rtia_m.rtia019) THEN 
               #IF p_cmd = 'a' OR ( p_cmd = 'u' AND g_rtia_m.rtia019 != g_rtia_m_t.rtia019) THEN   #160824-00007#172 Mark By Ken 161107
               IF g_rtia_m.rtia019 != g_rtia_m_o.rtia019 THEN    #160824-00007#172 Add By Ken 161107
                  CALL artt622_rtia019_chk()
                  IF NOT cl_null(g_errno) THEN 
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = g_errno
                     LET g_errparam.extend = ''
                     LET g_errparam.popup = TRUE
                     CALL cl_err()

                     #LET g_rtia_m.rtia019 = g_rtia_m_t.rtia019   #160824-00007#172 Mark By Ken 161107
                     LET g_rtia_m.rtia019 = g_rtia_m_o.rtia019    #160824-00007#172 Add By Ken 161107
                     NEXT FIELD rtia019
                  END IF 
               END IF 
            END IF 
            LET g_rtia_m_o.* = g_rtia_m.*    #160824-00007#172 Add By Ken 161107
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE rtia019
            #add-point:ON CHANGE rtia019 name="input.g.rtia019"
                        
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtia020
            #add-point:BEFORE FIELD rtia020 name="input.b.rtia020"
                        
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtia020
            
            #add-point:AFTER FIELD rtia020 name="input.a.rtia020"
                        
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE rtia020
            #add-point:ON CHANGE rtia020 name="input.g.rtia020"
                        
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtia021
            #add-point:BEFORE FIELD rtia021 name="input.b.rtia021"
                        
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtia021
            
            #add-point:AFTER FIELD rtia021 name="input.a.rtia021"
                        
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE rtia021
            #add-point:ON CHANGE rtia021 name="input.g.rtia021"
                        
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtia022
            #add-point:BEFORE FIELD rtia022 name="input.b.rtia022"
                        
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtia022
            
            #add-point:AFTER FIELD rtia022 name="input.a.rtia022"
                        
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE rtia022
            #add-point:ON CHANGE rtia022 name="input.g.rtia022"
                        
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtia023
            #add-point:BEFORE FIELD rtia023 name="input.b.rtia023"
                        
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtia023
            
            #add-point:AFTER FIELD rtia023 name="input.a.rtia023"
                        
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE rtia023
            #add-point:ON CHANGE rtia023 name="input.g.rtia023"
                        
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtia024
            
            #add-point:AFTER FIELD rtia024 name="input.a.rtia024"
            IF NOT cl_null(g_rtia_m.rtia024) THEN 
               IF s_aooi500_setpoint(g_prog,'rtia024') THEN
                  CALL s_aooi500_chk(g_prog,'rtia024',g_rtia_m.rtia024,g_rtia_m.rtiasite) RETURNING l_success,l_errno
                  IF NOT l_success THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.extend = g_rtia_m.rtia024
                     LET g_errparam.code   = l_errno
                     LET g_errparam.popup  = TRUE
                     CALL cl_err()
                  
                     #LET g_rtia_m.rtia024 = g_rtia_m_t.rtia024  #160824-00007#172 Mark By Ken 161107
                     LET g_rtia_m.rtia024 = g_rtia_m_o.rtia024   #160824-00007#172 Add By Ken 161107
                     CALL s_desc_get_department_desc(g_rtia_m.rtia024) RETURNING g_rtia_m.rtia024_desc
                     DISPLAY BY NAME g_rtia_m.rtia024,g_rtia_m.rtia024_desc
                     NEXT FIELD CURRENT
                  END IF
                  
                  LET g_site_flag = TRUE
                  CALL artt622_set_entry(p_cmd)
                  CALL artt622_set_no_entry(p_cmd)
               ELSE
                  CALL artt622_rtia024_chk()
                  IF NOT cl_null(g_errno) THEN 
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = g_errno
                     LET g_errparam.extend = ''
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                  
                     #LET g_rtia_m.rtia024 = g_rtia_m_t.rtia024  #160824-00007#172 Mark By Ken 161107
                     LET g_rtia_m.rtia024 = g_rtia_m_o.rtia024   #160824-00007#172 Add By Ken 161107
                     NEXT FIELD rtia024
                  END IF 
               END IF    
            END IF 
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_rtia_m.rtia024
            CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_rtia_m.rtia024_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_rtia_m.rtia024_desc
            LET g_rtia_m_o.* = g_rtia_m.*    #160824-00007#172 Add By Ken 161107
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtia024
            #add-point:BEFORE FIELD rtia024 name="input.b.rtia024"
                        
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE rtia024
            #add-point:ON CHANGE rtia024 name="input.g.rtia024"
                        
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtia025
            
            #add-point:AFTER FIELD rtia025 name="input.a.rtia025"
            IF NOT cl_null(g_rtia_m.rtia025) THEN 
               CALL artt622_rtia025_chk()
               IF NOT cl_null(g_errno) THEN 
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = g_errno
                  LET g_errparam.extend = ''
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  #LET g_rtia_m.rtia025 = g_rtia_m_t.rtia025  #160824-00007#172 Mark By Ken 161107
                  LET g_rtia_m.rtia025 = g_rtia_m_o.rtia025   #160824-00007#172 Add By Ken 161107
                  NEXT FIELD rtia025
               END IF 
               #开启关闭必录栏位
               CALL artt622_set_required()    #add by yangxf 根据收款条件是否为现付判断收银员栏位是否必录
            END IF 
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_rtia_m.rtia025
            CALL ap_ref_array2(g_ref_fields,"SELECT ooibl004 FROM ooibl_t WHERE ooiblent='"||g_enterprise||"' AND ooibl002=? AND ooibl003='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_rtia_m.rtia025_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_rtia_m.rtia025_desc
            LET g_rtia_m_o.* = g_rtia_m.*    #160824-00007#172 Add By Ken 161107
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtia025
            #add-point:BEFORE FIELD rtia025 name="input.b.rtia025"
                        
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE rtia025
            #add-point:ON CHANGE rtia025 name="input.g.rtia025"
                        
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtia026
            #add-point:BEFORE FIELD rtia026 name="input.b.rtia026"
                        
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtia026
            
            #add-point:AFTER FIELD rtia026 name="input.a.rtia026"
            IF NOT cl_null(g_rtia_m.rtia026) THEN 
               CALL artt622_rtia026_chk()
               IF NOT cl_null(g_errno) THEN 
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = g_errno
                  LET g_errparam.extend = ''
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  #LET g_rtia_m.rtia026 = g_rtia_m_t.rtia026   #160824-00007#172 Mark By Ken 161107
                  LET g_rtia_m.rtia026 = g_rtia_m_o.rtia026    #160824-00007#172 Add By Ken 161107
                  NEXT FIELD rtia026
               END IF
               LET l_n = 0
               SELECT COUNT(*) INTO l_n
                 FROM rtib_t
                WHERE rtibent = g_enterprise
                  AND rtibdocno = g_rtia_m.rtiadocno
               IF l_n > 0 THEN 
                  #重新计算本币金额
                  UPDATE rtib_t SET rtib031 = rtib021 * g_rtia_m.rtia027
                   WHERE rtibent = g_enterprise
                     AND rtibdocno = g_rtia_m.rtiadocno
                  IF SQLCA.sqlcode THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = SQLCA.sqlcode
                     LET g_errparam.extend = "rtib_t"
                     LET g_errparam.popup = FALSE
                     CALL cl_err()

                     #LET g_rtia_m.rtia026 = g_rtia_m_t.rtia026   #160824-00007#172 Mark By Ken 161107
                     LET g_rtia_m.rtia026 = g_rtia_m_o.rtia026    #160824-00007#172 Add By Ken 161107
                     NEXT FIELD rtia026
                  END IF    
                  #更新单头本币应收金额
                  UPDATE rtia_t SET rtia049 = (SELECT SUM(rtib031)
                                                 FROM rtib_t
                                                WHERE rtibent = g_enterprise
                                                  AND rtibdocno = g_rtia_m.rtiadocno)              
                   WHERE rtiaent = g_enterprise
                     AND rtiadocno = g_rtia_m.rtiadocno  
                  IF SQLCA.sqlcode THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = SQLCA.sqlcode
                     LET g_errparam.extend = "rtia_t"
                     LET g_errparam.popup = FALSE
                     CALL cl_err()

                     #LET g_rtia_m.rtia026 = g_rtia_m_t.rtia026   #160824-00007#172 Mark By Ken 161107
                     LET g_rtia_m.rtia026 = g_rtia_m_o.rtia026    #160824-00007#172 Add By Ken 161107
                     NEXT FIELD rtia026
                  END IF                     
               END IF 
            END IF 
            LET g_rtia_m_o.* = g_rtia_m.*    #160824-00007#172 Add By Ken 161107
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE rtia026
            #add-point:ON CHANGE rtia026 name="input.g.rtia026"
                        
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtia027
            #add-point:BEFORE FIELD rtia027 name="input.b.rtia027"
                        
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtia027
            
            #add-point:AFTER FIELD rtia027 name="input.a.rtia027"
            IF NOT cl_null(g_rtia_m.rtia027) THEN 
               LET l_n = 0
               SELECT COUNT(*) INTO l_n
                 FROM rtib_t
                WHERE rtibent = g_enterprise
                  AND rtibdocno = g_rtia_m.rtiadocno
               IF l_n > 0 THEN 
                  #重新计算本币金额
                  UPDATE rtib_t SET rtib031 = rtib021 * g_rtia_m.rtia027
                   WHERE rtibent = g_enterprise
                     AND rtibdocno = g_rtia_m.rtiadocno
                  IF SQLCA.sqlcode THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = SQLCA.sqlcode
                     LET g_errparam.extend = "rtib_t"
                     LET g_errparam.popup = FALSE
                     CALL cl_err()

                     #LET g_rtia_m.rtia027 = g_rtia_m_t.rtia027   #160824-00007#172 Mark By Ken 161107
                     LET g_rtia_m.rtia027 = g_rtia_m_o.rtia027    #160824-00007#172 Add By Ken 161107
                     NEXT FIELD rtia027
                  END IF    
                  #更新单头本币应收金额
                  UPDATE rtia_t SET rtia049 = (SELECT SUM(rtib031)
                                                 FROM rtib_t
                                                WHERE rtibent = g_enterprise
                                                  AND rtibdocno = g_rtia_m.rtiadocno)              
                   WHERE rtiaent = g_enterprise
                     AND rtiadocno = g_rtia_m.rtiadocno  
                  IF SQLCA.sqlcode THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = SQLCA.sqlcode
                     LET g_errparam.extend = "rtia_t"
                     LET g_errparam.popup = FALSE
                     CALL cl_err()

                     #LET g_rtia_m.rtia027 = g_rtia_m_t.rtia027   #160824-00007#172 Mark By Ken 161107
                     LET g_rtia_m.rtia027 = g_rtia_m_o.rtia027    #160824-00007#172 Add By Ken 161107
                     NEXT FIELD rtia027
                  END IF                     
               END IF 
            END IF 
            LET g_rtia_m_o.* = g_rtia_m.*    #160824-00007#172 Add By Ken 161107
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE rtia027
            #add-point:ON CHANGE rtia027 name="input.g.rtia027"
                        
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtia028
            #add-point:BEFORE FIELD rtia028 name="input.b.rtia028"
                        
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtia028
            
            #add-point:AFTER FIELD rtia028 name="input.a.rtia028"
            IF NOT cl_null(g_rtia_m.rtia028) THEN 
               CALL artt622_rtia028_chk()
               IF NOT cl_null(g_errno) THEN 
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = g_errno
                  LET g_errparam.extend = ''
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  #LET g_rtia_m.rtia028 = g_rtia_m_t.rtia028  #160824-00007#172 Mark By Ken 161107
                  LET g_rtia_m.rtia028 = g_rtia_m_o.rtia028   #160824-00007#172 Add By Ken 161107
                  NEXT FIELD rtia028
               END IF
               IF g_rtia_m.rtia028 != g_rtia_m_t.rtia028 THEN
                  LET l_n = 0               
                  SELECT COUNT(*) INTO l_n
                    FROM rtib_t
                   WHERE rtibent = g_enterprise
                     AND rtibdocno = g_rtia_m.rtiadocno
                  IF l_n > 0 THEN 
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = 'art-00395'
                     LET g_errparam.extend = ''
                     LET g_errparam.popup = TRUE
                     CALL cl_err()

                     #LET g_rtia_m.rtia028 = g_rtia_m_t.rtia028  #160824-00007#172 Mark By Ken 161107
                     LET g_rtia_m.rtia028 = g_rtia_m_o.rtia028   #160824-00007#172 Add By Ken 161107
                     NEXT FIELD rtia028
                  END IF 
               END IF 
            END IF
            LET g_rtia_m_o.* = g_rtia_m.*    #160824-00007#172 Add By Ken 161107
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE rtia028
            #add-point:ON CHANGE rtia028 name="input.g.rtia028"
                        
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtia029
            #add-point:BEFORE FIELD rtia029 name="input.b.rtia029"
                        
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtia029
            
            #add-point:AFTER FIELD rtia029 name="input.a.rtia029"
            IF NOT cl_null(g_rtia_m.rtia029) THEN 
               CALL artt622_rtia029_chk()
               IF NOT cl_null(g_errno) THEN 
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = g_errno
                  LET g_errparam.extend = ''
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  #LET g_rtia_m.rtia029 = g_rtia_m_t.rtia029  #160824-00007#172 Mark By Ken 161107 
                  LET g_rtia_m.rtia029 = g_rtia_m_o.rtia029   #160824-00007#172 Add By Ken 161107
                  NEXT FIELD rtia029
               END IF 
            END IF 
            LET g_rtia_m_o.* = g_rtia_m.*    #160824-00007#172 Add By Ken 161107
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE rtia029
            #add-point:ON CHANGE rtia029 name="input.g.rtia029"
                        
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtia030
            #add-point:BEFORE FIELD rtia030 name="input.b.rtia030"
                        
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtia030
            
            #add-point:AFTER FIELD rtia030 name="input.a.rtia030"
                        
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE rtia030
            #add-point:ON CHANGE rtia030 name="input.g.rtia030"
                        
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtia032
            #add-point:BEFORE FIELD rtia032 name="input.b.rtia032"
                        
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtia032
            
            #add-point:AFTER FIELD rtia032 name="input.a.rtia032"
                        
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE rtia032
            #add-point:ON CHANGE rtia032 name="input.g.rtia032"
                        
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtia033
            #add-point:BEFORE FIELD rtia033 name="input.b.rtia033"
                        
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtia033
            
            #add-point:AFTER FIELD rtia033 name="input.a.rtia033"
                        
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE rtia033
            #add-point:ON CHANGE rtia033 name="input.g.rtia033"
                        
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtia034
            #add-point:BEFORE FIELD rtia034 name="input.b.rtia034"
                        
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtia034
            
            #add-point:AFTER FIELD rtia034 name="input.a.rtia034"
                        
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE rtia034
            #add-point:ON CHANGE rtia034 name="input.g.rtia034"
                        
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtia035
            #add-point:BEFORE FIELD rtia035 name="input.b.rtia035"
                        
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtia035
            
            #add-point:AFTER FIELD rtia035 name="input.a.rtia035"
                        
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE rtia035
            #add-point:ON CHANGE rtia035 name="input.g.rtia035"
                        
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtia036
            
            #add-point:AFTER FIELD rtia036 name="input.a.rtia036"
            IF NOT cl_null(g_rtia_m.rtia036) THEN 
               CALL artt622_rtia036_chk()
               IF NOT cl_null(g_errno) THEN 
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = g_errno
                  LET g_errparam.extend = ''
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  LET g_rtia_m.rtia036 = g_rtia_m_t.rtia036
                  NEXT FIELD rtia036
               END IF 
            END IF 
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_rtia_m.rtia036
            CALL ap_ref_array2(g_ref_fields,"SELECT pcaal003 FROM pcaal_t WHERE pcaalent='"||g_enterprise||"' AND pcaalsite = '"||g_rtia_m.rtiasite||"' AND pcaal001=? AND pcaal002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_rtia_m.rtia036_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_rtia_m.rtia036_desc                
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtia036
            #add-point:BEFORE FIELD rtia036 name="input.b.rtia036"
                        
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE rtia036
            #add-point:ON CHANGE rtia036 name="input.g.rtia036"
                        
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtia037
            
            #add-point:AFTER FIELD rtia037 name="input.a.rtia037"
            IF NOT cl_null(g_rtia_m.rtia037) THEN 
               CALL artt622_rtia037_chk()
               IF NOT cl_null(g_errno) THEN 
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = g_errno
                  LET g_errparam.extend = ''
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  LET g_rtia_m.rtia037 = g_rtia_m_t.rtia037
                  NEXT FIELD rtia037
               END IF 
               SELECT pcab003 INTO g_rtia_m.rtia037_desc
                 FROM pcab_t
                WHERE pcabent = g_enterprise
                  AND pcab001 = g_rtia_m.rtia037
            ELSE
               LET g_rtia_m.rtia037_desc = ''
            END IF
            DISPLAY BY NAME g_rtia_m.rtia037_desc
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtia037
            #add-point:BEFORE FIELD rtia037 name="input.b.rtia037"
                        
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE rtia037
            #add-point:ON CHANGE rtia037 name="input.g.rtia037"
                        
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtia038
            
            #add-point:AFTER FIELD rtia038 name="input.a.rtia038"
            IF NOT cl_null(g_rtia_m.rtia038) THEN 
               CALL artt622_rtia038_chk()
               IF NOT cl_null(g_errno) THEN 
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = g_errno
                  LET g_errparam.extend = g_rtia_m.rtia038
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  LET g_rtia_m.rtia038 = g_rtia_m_t.rtia038 
                  NEXT FIELD rtia038
               END IF 
            END IF 
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_rtia_m.rtia038
            LET g_ref_fields[2] = g_rtia_m.rtiasite
            CALL ap_ref_array2(g_ref_fields,"SELECT oogd002 FROM oogd_t WHERE oogdent='"||g_enterprise||"' AND oogd001=? AND oogdsite=? ","") RETURNING g_rtn_fields
            LET g_rtia_m.rtia038_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_rtia_m.rtia038_desc

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtia038
            #add-point:BEFORE FIELD rtia038 name="input.b.rtia038"
                        
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE rtia038
            #add-point:ON CHANGE rtia038 name="input.g.rtia038"
                        
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtia107
            #add-point:BEFORE FIELD rtia107 name="input.b.rtia107"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtia107
            
            #add-point:AFTER FIELD rtia107 name="input.a.rtia107"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE rtia107
            #add-point:ON CHANGE rtia107 name="input.g.rtia107"
            
            #END add-point 
 
 
 #欄位檢查
                  #Ctrlp:input.c.rtiasite
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtiasite
            #add-point:ON ACTION controlp INFIELD rtiasite name="input.c.rtiasite"
                        #此段落由子樣板a07產生            
            #開窗i段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
			LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_rtia_m.rtiasite             #給予default值
#            LET g_qryparam.arg1 = g_site
#            LET g_qryparam.arg2 = '8'
#            CALL q_ooed004()                                #呼叫開窗
            LET g_qryparam.where = s_aooi500_q_where(g_prog,'rtiasite',g_rtia_m.rtiasite,'i')   #150308-00001#5  By benson add 'i'
            CALL q_ooef001_24()
            LET g_rtia_m.rtiasite = g_qryparam.return1      #將開窗取得的值回傳到變數
            DISPLAY g_rtia_m.rtiasite TO rtiasite           #顯示到畫面上
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_rtia_m.rtiasite
            CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002 = '"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_rtia_m.rtiasite_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_rtia_m.rtiasite_desc
            NEXT FIELD rtiasite                             #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.rtiadocdt
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtiadocdt
            #add-point:ON ACTION controlp INFIELD rtiadocdt name="input.c.rtiadocdt"
            
            #END add-point
 
 
         #Ctrlp:input.c.rtiadocno
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtiadocno
            #add-point:ON ACTION controlp INFIELD rtiadocno name="input.c.rtiadocno"
                        #此段落由子樣板a07產生            
            #開窗i段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
			LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_rtia_m.rtiadocno             #給予default值
            LET l_ooef004 = ""
            SELECT ooef004 INTO l_ooef004
              FROM ooef_t
             WHERE ooef001 = g_rtia_m.rtiasite
               AND ooefent = g_enterprise
            #給予arg
            LET g_qryparam.arg1 = l_ooef004 #
            LET g_qryparam.arg2 = g_prog #
            CALL q_ooba002_1()                            #呼叫開窗
            LET g_rtia_m.rtiadocno = g_qryparam.return1   #將開窗取得的值回傳到變數
            DISPLAY g_rtia_m.rtiadocno TO rtiadocno       #顯示到畫面上
            NEXT FIELD rtiadocno                          #返回原欄位
            #END add-point
 
 
         #Ctrlp:input.c.rtia001
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtia001
            #add-point:ON ACTION controlp INFIELD rtia001 name="input.c.rtia001"
                        #此段落由子樣板a07產生            
            #開窗i段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
			LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_rtia_m.rtia001             #給予default值
            #給予arg
            CALL q_mmaq001_3()                                #呼叫開窗
            LET g_rtia_m.rtia001 = g_qryparam.return1              #將開窗取得的值回傳到變數
            LET g_rtia_m.rtia059 = g_qryparam.return2      #150429-00007#9 dongsz add
            LET g_rtia_m.rtia060 = g_qryparam.return3      #150429-00007#9 dongsz add
            DISPLAY g_rtia_m.rtia001 TO rtia001  #顯示到畫面上
            SELECT mmaq003 INTO l_mmaq003 
              FROM mmaq_t
             WHERE mmaq001 = g_rtia_m.rtia001
               AND mmaqent = g_enterprise
            #获取会员姓名及大宗客户编号
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = l_mmaq003
            CALL ap_ref_array2(g_ref_fields,"SELECT mmaf008,mmaf016,mmaf010,mmaf011,mmaf014 FROM mmaf_t WHERE mmafent='"||g_enterprise||"' AND mmaf001=? ","") RETURNING g_rtn_fields
            LET g_rtia_m.rtia001_desc = '', g_rtn_fields[1] , ''
            LET g_rtia_m.rtia002 = '',g_rtn_fields[2] , ''
            LET g_rtia_m.rtia019 = '',g_rtn_fields[3] , ''
            LET g_rtia_m.rtia020 = '',g_rtn_fields[4] , ''
            LET g_rtia_m.rtia021 = '',g_rtn_fields[1] , ''
            LET g_rtia_m.rtia022 = '',g_rtn_fields[5] , ''
            DISPLAY BY NAME g_rtia_m.rtia001_desc,g_rtia_m.rtia019,g_rtia_m.rtia020,g_rtia_m.rtia021,g_rtia_m.rtia022
            NEXT FIELD rtia001                   #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.rtia059
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtia059
            #add-point:ON ACTION controlp INFIELD rtia059 name="input.c.rtia059"
            
            #END add-point
 
 
         #Ctrlp:input.c.rtia060
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtia060
            #add-point:ON ACTION controlp INFIELD rtia060 name="input.c.rtia060"
            
            #END add-point
 
 
         #Ctrlp:input.c.rtia004
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtia004
            #add-point:ON ACTION controlp INFIELD rtia004 name="input.c.rtia004"
                        #此段落由子樣板a07產生            
            #開窗i段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
			LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_rtia_m.rtia004             #給予default值
            #給予arg
            CALL q_ooag001()                                #呼叫開窗
            LET g_rtia_m.rtia004 = g_qryparam.return1              #將開窗取得的值回傳到變數
            DISPLAY g_rtia_m.rtia004 TO rtia004              #顯示到畫面上
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_rtia_m.rtia004
            CALL ap_ref_array2(g_ref_fields,"SELECT ooag011 FROM ooag_t WHERE ooagent='"||g_enterprise||"' AND ooag001=? ","") RETURNING g_rtn_fields
            LET g_rtia_m.rtia004_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_rtia_m.rtia004_desc
            NEXT FIELD rtia004                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.rtia005
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtia005
            #add-point:ON ACTION controlp INFIELD rtia005 name="input.c.rtia005"
                        #此段落由子樣板a07產生            
            #開窗i段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
			LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_rtia_m.rtia005             #給予default值

            #給予arg
            LET g_qryparam.arg1 = g_today
            CALL q_ooeg001()                                #呼叫開窗

            LET g_rtia_m.rtia005 = g_qryparam.return1              #將開窗取得的值回傳到變數
            DISPLAY g_rtia_m.rtia005 TO rtia005              #顯示到畫面上
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_rtia_m.rtia005
            CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_rtia_m.rtia005_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_rtia_m.rtia005_desc
            NEXT FIELD rtia005                              #返回原欄位

            #END add-point
 
 
         #Ctrlp:input.c.rtia006
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtia006
            #add-point:ON ACTION controlp INFIELD rtia006 name="input.c.rtia006"
                        
            #END add-point
 
 
         #Ctrlp:input.c.rtia053
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtia053
            #add-point:ON ACTION controlp INFIELD rtia053 name="input.c.rtia053"
            
            #END add-point
 
 
         #Ctrlp:input.c.rtiastus
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtiastus
            #add-point:ON ACTION controlp INFIELD rtiastus name="input.c.rtiastus"
                        
            #END add-point
 
 
         #Ctrlp:input.c.rtia007
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtia007
            #add-point:ON ACTION controlp INFIELD rtia007 name="input.c.rtia007"
                                    #開窗i段
	        INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
	        LET g_qryparam.reqry = FALSE
	        #160604-00009#85--dongsz mark--s
#	        IF g_prog = 'artt622' THEN    #add by yangxf  
#	           #LET g_qryparam.where = " xmdastus = 'Y' "       #150424-00020#2--mark by dongsz
##	            LET g_qryparam.where = " rtilsite = '",g_rtia_m.rtiasite,"' AND rtilstus = 'Y' "  #150424-00020#2--add by dongsz   #mark by yangxf 
#               LET g_qryparam.where = " rtilsite = '",g_rtia_m.rtiasite,"' AND rtilstus = 'Y' ",                                  #add by yangxf
#                                      " AND NOT exists (SELECT 1 FROM rtia_t WHERE rtiaent = rtilent AND rtiaent = '",g_enterprise,"' AND rtiastus <> 'X' AND rtildocno = rtia007)"  #add by yangxf
#               LET g_qryparam.default1 = g_rtia_m.rtia007      #給予default值
#               #CALL q_xmdadocno()                              #呼叫開窗     #150424-00020#2--mark by dongsz
#               CALL q_rtildocno()                              #150424-00020#2--add by dongsz
#               LET g_rtia_m.rtia007 = g_qryparam.return1       #將開窗取得的值回傳到變數
#               DISPLAY g_rtia_m.rtia007 TO rtia007             #顯示到畫面上
#               NEXT FIELD rtia007                              #返回原欄位
#            #add by yangxf ----start----
#            END IF  
#            IF g_prog = 'artt610' OR g_prog = 'artt620' THEN        #add by yangxf 20151127  add g_prog = 'artt620'    
#               LET g_qryparam.where = " rtiastus = 'S' AND rtiasite = '",g_rtia_m.rtiasite,"' AND rtia000 = '",g_prog,"'"
#            END IF 
#            IF g_prog = 'artt700' THEN 
#               LET g_qryparam.where = " rtiastus = 'S' AND rtiasite = '",g_rtia_m.rtiasite,"' AND (rtia000 ='artt622' OR rtia000 = 'artt610') "
#            END IF 
#            IF g_prog = 'artt800' THEN 
#                LET g_qryparam.where = " rtiastus = 'S' AND rtiasite = '",g_rtia_m.rtiasite,"'",
#                                       "  AND rtiadocno IN(SELECT rtifdocno FROM rtif_t WHERE rtifent = '",g_enterprise,"'",
#                                       "                                                  AND rtif001 = '91' ",
#                                       "                                                  AND rtif034 = '",g_rtia_m.rtia002,"')"
#            END IF 
            #160604-00009#85--dongsz mark--e
            #160604-00009#85--dongsz add--s
            IF g_prog = 'artt622' THEN
               LET g_qryparam.where = " rtiasite = '",g_rtia_m.rtiasite,"' AND rtiastus = 'S' ",                          
                                      " AND rtia000 = 'artt622' "  
               LET g_qryparam.default1 = g_rtia_m.rtia007      #給予default值
               CALL q_rtiadocno()                            
               LET g_rtia_m.rtia007 = g_qryparam.return1       #將開窗取得的值回傳到變數
               DISPLAY g_rtia_m.rtia007 TO rtia007             #顯示到畫面上
               NEXT FIELD rtia007                              #返回原欄位
            #add by yangxf ----start----
            END IF
            #160604-00009#85--dongsz add--e
            LET g_qryparam.default1 = g_rtia_m.rtia007
            CALL q_rtiadocno()
            LET g_rtia_m.rtia007 = g_qryparam.return1
            #add by yangxf ---end----
            DISPLAY g_rtia_m.rtia007 TO rtia007             #顯示到畫面上
            NEXT FIELD rtia007                              #返回原欄位
            #END add-point
 
 
         #Ctrlp:input.c.rtia009
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtia009
            #add-point:ON ACTION controlp INFIELD rtia009 name="input.c.rtia009"
                        #此段落由子樣板a07產生            
            #開窗i段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
			LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_rtia_m.rtia009             #給予default值
            #給予arg
            LET g_qryparam.arg1 = '295'
            CALL q_oocq002()                                #呼叫開窗
            LET g_rtia_m.rtia009 = g_qryparam.return1              #將開窗取得的值回傳到變數
            DISPLAY g_rtia_m.rtia009 TO rtia009              #顯示到畫面上
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_rtia_m.rtia009
            CALL ap_ref_array2(g_ref_fields,"SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001='295' AND oocql002=? AND oocql003='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_rtia_m.rtia009_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_rtia_m.rtia009_desc
            NEXT FIELD rtia009                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.rtia043
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtia043
            #add-point:ON ACTION controlp INFIELD rtia043 name="input.c.rtia043"
            
            #END add-point
 
 
         #Ctrlp:input.c.rtia047
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtia047
            #add-point:ON ACTION controlp INFIELD rtia047 name="input.c.rtia047"
            
            #END add-point
 
 
         #Ctrlp:input.c.rtia051
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtia051
            #add-point:ON ACTION controlp INFIELD rtia051 name="input.c.rtia051"
            
            #END add-point
 
 
         #Ctrlp:input.c.rtia010
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtia010
            #add-point:ON ACTION controlp INFIELD rtia010 name="input.c.rtia010"
                        #此段落由子樣板a07產生            
            #開窗i段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
			LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_rtia_m.rtia010             #給予default值
            #給予arg
            LET g_qryparam.arg1 = "2" #
            IF NOT cl_null(g_rtia_m.rtia002) THEN 
               LET g_qryparam.where = " pmac001 = '",g_rtia_m.rtia002,"'"
            END IF 
            CALL q_pmaa001_9()                                #呼叫開窗
            LET g_rtia_m.rtia010 = g_qryparam.return1              #將開窗取得的值回傳到變數
            DISPLAY g_rtia_m.rtia010 TO rtia010              #顯示到畫面上
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_rtia_m.rtia010
            CALL ap_ref_array2(g_ref_fields,"SELECT pmaal004 FROM pmaal_t WHERE pmaalent='"||g_enterprise||"' AND pmaal001=? AND pmaal002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_rtia_m.rtia010_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_rtia_m.rtia010_desc
            NEXT FIELD rtia010                          #返回原欄位

            #END add-point
 
 
         #Ctrlp:input.c.rtia011
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtia011
            #add-point:ON ACTION controlp INFIELD rtia011 name="input.c.rtia011"
                        #此段落由子樣板a07產生            
            #開窗i段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
			LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_rtia_m.rtia011             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "1" #
            IF NOT cl_null(g_rtia_m.rtia002) THEN 
               LET g_qryparam.where = " pmac001 = '",g_rtia_m.rtia002,"'"
            END IF 
            CALL q_pmaa001_9()                                #呼叫開窗

            LET g_rtia_m.rtia011 = g_qryparam.return1              #將開窗取得的值回傳到變數

            DISPLAY g_rtia_m.rtia011 TO rtia011              #顯示到畫面上
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_rtia_m.rtia011
            CALL ap_ref_array2(g_ref_fields,"SELECT pmaal004 FROM pmaal_t WHERE pmaalent='"||g_enterprise||"' AND pmaal001=? AND pmaal002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_rtia_m.rtia011_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_rtia_m.rtia011_desc
            NEXT FIELD rtia011                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.rtia012
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtia012
            #add-point:ON ACTION controlp INFIELD rtia012 name="input.c.rtia012"
                        #此段落由子樣板a07產生            
            #開窗i段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
			LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_rtia_m.rtia012             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "3" #
            IF NOT cl_null(g_rtia_m.rtia002) THEN 
               LET g_qryparam.where = " pmac001 = '",g_rtia_m.rtia002,"'"
            END IF 
            CALL q_pmaa001_9()                                #呼叫開窗
            LET g_rtia_m.rtia012 = g_qryparam.return1              #將開窗取得的值回傳到變數
            DISPLAY g_rtia_m.rtia012 TO rtia012              #顯示到畫面上
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_rtia_m.rtia012
            CALL ap_ref_array2(g_ref_fields,"SELECT pmaal004 FROM pmaal_t WHERE pmaalent='"||g_enterprise||"' AND pmaal001=? AND pmaal002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_rtia_m.rtia012_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_rtia_m.rtia012_desc
            NEXT FIELD rtia012                          #返回原欄位
            #END add-point
 
 
         #Ctrlp:input.c.chantype
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD chantype
            #add-point:ON ACTION controlp INFIELD chantype name="input.c.chantype"
            
            #END add-point
 
 
         #Ctrlp:input.c.barcode
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD barcode
            #add-point:ON ACTION controlp INFIELD barcode name="input.c.barcode"
            #應用 a07 樣板自動產生(Version:3)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
 
            LET g_qryparam.default1 = g_rtia_m.barcode             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "" #s

 
            CALL q_imay003_2()                                #呼叫開窗
 
            LET g_rtia_m.barcode = g_qryparam.return1              

            DISPLAY g_rtia_m.barcode TO barcode              #

            NEXT FIELD barcode                          #返回原欄位



            #END add-point
 
 
         #Ctrlp:input.c.rtia041
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtia041
            #add-point:ON ACTION controlp INFIELD rtia041 name="input.c.rtia041"
                        
            #END add-point
 
 
         #Ctrlp:input.c.rtia017
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtia017
            #add-point:ON ACTION controlp INFIELD rtia017 name="input.c.rtia017"
                        
            #END add-point
 
 
         #Ctrlp:input.c.rtia018
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtia018
            #add-point:ON ACTION controlp INFIELD rtia018 name="input.c.rtia018"
                        			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
			   LET g_qryparam.reqry = FALSE
			   LET g_qryparam.default1 = g_rtia_m.rtia018
            IF g_rtia_m.rtia017 = '1' OR g_rtia_m.rtia017 = '2' OR g_rtia_m.rtia017 = '3' THEN 
               IF s_aooi500_setpoint(g_prog,'rtia018') THEN
                  LET g_qryparam.where = s_aooi500_q_where(g_prog,'rtia018',g_rtia_m.rtiasite,'i')   #150308-00001#5  By benson add 'i'
                  CALL q_ooef001_24()
               ELSE
                  #CALL q_ooef001()           #161024-00025#1 mark
                  LET g_qryparam.where = " ooef201 = 'Y' "   #161024-00025#1 add
                  CALL q_ooef001_24()         #161024-00025#1 add
               END IF       
#               CALL q_ooef001()
            END IF 
            IF g_rtia_m.rtia017 = '4' THEN 
               CALL q_pmaa001_8()
            END IF 
            LET g_rtia_m.rtia018 = g_qryparam.return1              #將開窗取得的值回傳到變數
            DISPLAY g_rtia_m.rtia018 TO rtia018              #顯示到畫面上
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_rtia_m.rtia018
            IF g_rtia_m.rtia017 = '4' THEN 
               CALL ap_ref_array2(g_ref_fields,"SELECT pmaal004 FROM pmaal_t WHERE pmaalent='"||g_enterprise||"' AND pmaal001=? AND pmaal002='"||g_dlang||"'","") RETURNING g_rtn_fields
            ELSE          
               CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
            END IF
            LET g_rtia_m.rtia018_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_rtia_m.rtia018_desc
            #END add-point
 
 
         #Ctrlp:input.c.rtia019
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtia019
            #add-point:ON ACTION controlp INFIELD rtia019 name="input.c.rtia019"
                                    #開窗i段
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_rtia_m.rtia019             #給予default值
            #給予arg
            CALL q_oocn002()                                #呼叫開窗
            LET g_rtia_m.rtia019 = g_qryparam.return1       #將開窗取得的值回傳到變數
            DISPLAY g_rtia_m.rtia019 TO rtia019             #顯示到畫面上
            NEXT FIELD rtia019
            #END add-point
 
 
         #Ctrlp:input.c.rtia020
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtia020
            #add-point:ON ACTION controlp INFIELD rtia020 name="input.c.rtia020"
                        
            #END add-point
 
 
         #Ctrlp:input.c.rtia021
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtia021
            #add-point:ON ACTION controlp INFIELD rtia021 name="input.c.rtia021"
                        
            #END add-point
 
 
         #Ctrlp:input.c.rtia022
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtia022
            #add-point:ON ACTION controlp INFIELD rtia022 name="input.c.rtia022"
                        
            #END add-point
 
 
         #Ctrlp:input.c.rtia023
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtia023
            #add-point:ON ACTION controlp INFIELD rtia023 name="input.c.rtia023"
                        
            #END add-point
 
 
         #Ctrlp:input.c.rtia024
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtia024
            #add-point:ON ACTION controlp INFIELD rtia024 name="input.c.rtia024"
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
			   LET g_qryparam.reqry = FALSE
			   LET g_qryparam.default1 = g_rtia_m.rtia024
#            CALL q_ooef001()
            IF s_aooi500_setpoint(g_prog,'rtia024') THEN
               LET g_qryparam.where = s_aooi500_q_where(g_prog,'rtia024',g_rtia_m.rtiasite,'i')    #150308-00001#5  By benson add 'i'
               CALL q_ooef001_24()
            ELSE
               #CALL q_ooef001()              #161024-00025#1 mark
                  LET g_qryparam.where = " ooef201 = 'Y' "   #161024-00025#1 add
                  CALL q_ooef001_24()         #161024-00025#1 add
            END IF       
            LET g_rtia_m.rtia024 = g_qryparam.return1              #將開窗取得的值回傳到變數
            DISPLAY g_rtia_m.rtia024 TO rtia024              #顯示到畫面上
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_rtia_m.rtia024
            CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_rtia_m.rtia024_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_rtia_m.rtia024_desc
            #END add-point
 
 
         #Ctrlp:input.c.rtia025
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtia025
            #add-point:ON ACTION controlp INFIELD rtia025 name="input.c.rtia025"
                        			
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
			LET g_qryparam.reqry = FALSE
			LET g_qryparam.default1 = g_rtia_m.rtia025
			LET g_qryparam.arg1 = g_rtia_m.rtia002
			LET g_qryparam.arg2 = '2'
            CALL q_pmad002()
            LET g_rtia_m.rtia025 = g_qryparam.return1              #將開窗取得的值回傳到變數
            DISPLAY g_rtia_m.rtia025 TO rtia025 
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_rtia_m.rtia025
            CALL ap_ref_array2(g_ref_fields,"SELECT ooibl004 FROM ooibl_t WHERE ooiblent='"||g_enterprise||"' AND ooibl002=? AND ooibl003='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_rtia_m.rtia025_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_rtia_m.rtia025_desc
            #END add-point
 
 
         #Ctrlp:input.c.rtia026
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtia026
            #add-point:ON ACTION controlp INFIELD rtia026 name="input.c.rtia026"
                        			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
			LET g_qryparam.reqry = FALSE
			LET g_qryparam.default1 = g_rtia_m.rtia026
			LET g_qryparam.arg1 = g_rtia_m.rtiasite
            CALL q_ooaj002_2()
            LET g_rtia_m.rtia026 = g_qryparam.return1              #將開窗取得的值回傳到變數
            DISPLAY g_rtia_m.rtia026 TO rtia026
            #END add-point
 
 
         #Ctrlp:input.c.rtia027
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtia027
            #add-point:ON ACTION controlp INFIELD rtia027 name="input.c.rtia027"
                        
            #END add-point
 
 
         #Ctrlp:input.c.rtia028
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtia028
            #add-point:ON ACTION controlp INFIELD rtia028 name="input.c.rtia028"

            INITIALIZE g_qryparam.* TO NULL 
            LET g_qryparam.state = "i"
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_rtia_m.rtia028
            LET g_qryparam.arg1 = g_rtia_m.rtiasite
            CALL q_oodb002_10()
            LET g_rtia_m.rtia028 = g_qryparam.return1
            LET g_rtia_m.rtia029 = g_qryparam.return2
            LET g_rtia_m.rtia030 = g_qryparam.return3
            DISPLAY BY NAME g_rtia_m.rtia028,g_rtia_m.rtia029,g_rtia_m.rtia030
            ### 客戶對象慣用交易稅別### end ###

            #END add-point
 
 
         #Ctrlp:input.c.rtia029
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtia029
            #add-point:ON ACTION controlp INFIELD rtia029 name="input.c.rtia029"
                        
            #END add-point
 
 
         #Ctrlp:input.c.rtia030
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtia030
            #add-point:ON ACTION controlp INFIELD rtia030 name="input.c.rtia030"
                        
            #END add-point
 
 
         #Ctrlp:input.c.rtia032
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtia032
            #add-point:ON ACTION controlp INFIELD rtia032 name="input.c.rtia032"
                        
            #END add-point
 
 
         #Ctrlp:input.c.rtia033
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtia033
            #add-point:ON ACTION controlp INFIELD rtia033 name="input.c.rtia033"
                        
            #END add-point
 
 
         #Ctrlp:input.c.rtia034
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtia034
            #add-point:ON ACTION controlp INFIELD rtia034 name="input.c.rtia034"
                        
            #END add-point
 
 
         #Ctrlp:input.c.rtia035
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtia035
            #add-point:ON ACTION controlp INFIELD rtia035 name="input.c.rtia035"
                        
            #END add-point
 
 
         #Ctrlp:input.c.rtia036
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtia036
            #add-point:ON ACTION controlp INFIELD rtia036 name="input.c.rtia036"
                                    ### 收銀機號開窗### start ###
            INITIALIZE g_qryparam.* TO NULL 
            LET g_qryparam.state = "i"
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_rtia_m.rtia036
            LET g_qryparam.where = "1=1 AND pcaastus = 'Y' "
            LET g_qryparam.arg1 = g_rtia_m.rtiasite
            CALL q_pcaa001_1()
            LET g_rtia_m.rtia036 = g_qryparam.return1
            DISPLAY g_rtia_m.rtia036 TO rtia036
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_rtia_m.rtia036
            CALL ap_ref_array2(g_ref_fields,"SELECT pcaal003 FROM pcaal_t WHERE pcaalent='"||g_enterprise||"' AND pcaalsite = '"||g_rtia_m.rtiasite||"' AND pcaal001=? AND pcaal002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_rtia_m.rtia036_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_rtia_m.rtia036_desc
            ### 收銀機號開窗### end ###
            #END add-point
 
 
         #Ctrlp:input.c.rtia037
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtia037
            #add-point:ON ACTION controlp INFIELD rtia037 name="input.c.rtia037"
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
			   LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_rtia_m.rtia037             #給予default值
            LET g_qryparam.arg1 = g_rtia_m.rtiasite 
            LET g_qryparam.arg2 = g_rtia_m.rtia036
            CALL q_pcab001_1()                                #呼叫開窗
            LET g_rtia_m.rtia037 = g_qryparam.return1         #將開窗取得的值回傳到變數
            LET g_rtia_m.rtia037_desc = g_qryparam.return2    #呼叫開窗
            DISPLAY g_rtia_m.rtia037 TO rtia037               #顯示到畫面上
            NEXT FIELD rtia037   
            #END add-point
 
 
         #Ctrlp:input.c.rtia038
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtia038
            #add-point:ON ACTION controlp INFIELD rtia038 name="input.c.rtia038"
            ### 班別編號開窗### start ###
            INITIALIZE g_qryparam.* TO NULL 
            LET g_qryparam.state = "i"
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = ""
            LET g_qryparam.where = "1=1"
            LET g_qryparam.arg1 = g_rtia_m.rtiasite
            CALL q_oogd001_02()
            LET g_rtia_m.rtia038 = g_qryparam.return1
            DISPLAY g_rtia_m.rtia038 TO rtia038
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_rtia_m.rtia038
            LET g_ref_fields[2] = g_rtia_m.rtiasite
            CALL ap_ref_array2(g_ref_fields,"SELECT oogd002 FROM oogd_t WHERE oogdent='"||g_enterprise||"' AND oogd001=? AND oogdsite=? ","") RETURNING g_rtn_fields
            LET g_rtia_m.rtia038_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_rtia_m.rtia038_desc
            ### 班別編號開窗### end ###

            #END add-point
 
 
         #Ctrlp:input.c.rtia107
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtia107
            #add-point:ON ACTION controlp INFIELD rtia107 name="input.c.rtia107"
            
            #END add-point
 
 
 #欄位開窗
            
         AFTER INPUT
            IF INT_FLAG THEN
               EXIT DIALOG
            END IF
 
            #CALL cl_err_collect_show()      #錯誤訊息統整顯示
            #CALL cl_showmsg()
            DISPLAY BY NAME g_rtia_m.rtiadocno
                        
            #add-point:單頭INPUT後 name="input.head.after_input"
            
            #end add-point
                        
            IF p_cmd <> 'u' THEN
    
               CALL s_transaction_begin()
               
               #add-point:單頭新增前 name="input.head.b_insert"
               CALL s_aooi200_gen_docno(g_rtia_m.rtiasite,g_rtia_m.rtiadocno,g_rtia_m.rtiadocdt,g_prog) RETURNING l_success,g_rtia_m.rtiadocno
               IF NOT l_success THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'apm-00003'
                  LET g_errparam.extend = g_rtia_m.rtiadocno
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  NEXT FIELD rtiadocno
               END IF
                
               LET g_rtia_m.rtia033 = g_rtia_m.rtiadocno
               LET g_rtia_m.rtia034 = g_today
               LET g_rtia_m.rtia035 = cl_get_time()
               LET g_rtia_m.rtia048 = "N"
               #end add-point
               
               INSERT INTO rtia_t (rtiaent,rtiasite,rtiadocdt,rtiadocno,rtia002,rtia001,rtia059,rtia060, 
                   rtia004,rtia005,rtia006,rtia048,rtia053,rtiastus,rtia007,rtia008,rtia009,rtia043, 
                   rtia047,rtia013,rtia014,rtia015,rtia016,rtia051,rtia010,rtia011,rtia012,rtia041,rtia017, 
                   rtia018,rtia019,rtia020,rtia021,rtia022,rtia023,rtia024,rtia025,rtia026,rtia027,rtia028, 
                   rtia029,rtia030,rtia032,rtia033,rtia034,rtia035,rtia036,rtia037,rtia038,rtia039,rtia107, 
                   rtiaownid,rtiacrtid,rtiaowndp,rtiacrtdp,rtiacrtdt,rtiamodid,rtiamoddt,rtiacnfid,rtiacnfdt, 
                   rtiapstid,rtiapstdt)
               VALUES (g_enterprise,g_rtia_m.rtiasite,g_rtia_m.rtiadocdt,g_rtia_m.rtiadocno,g_rtia_m.rtia002, 
                   g_rtia_m.rtia001,g_rtia_m.rtia059,g_rtia_m.rtia060,g_rtia_m.rtia004,g_rtia_m.rtia005, 
                   g_rtia_m.rtia006,g_rtia_m.rtia048,g_rtia_m.rtia053,g_rtia_m.rtiastus,g_rtia_m.rtia007, 
                   g_rtia_m.rtia008,g_rtia_m.rtia009,g_rtia_m.rtia043,g_rtia_m.rtia047,g_rtia_m.rtia013, 
                   g_rtia_m.rtia014,g_rtia_m.rtia015,g_rtia_m.rtia016,g_rtia_m.rtia051,g_rtia_m.rtia010, 
                   g_rtia_m.rtia011,g_rtia_m.rtia012,g_rtia_m.rtia041,g_rtia_m.rtia017,g_rtia_m.rtia018, 
                   g_rtia_m.rtia019,g_rtia_m.rtia020,g_rtia_m.rtia021,g_rtia_m.rtia022,g_rtia_m.rtia023, 
                   g_rtia_m.rtia024,g_rtia_m.rtia025,g_rtia_m.rtia026,g_rtia_m.rtia027,g_rtia_m.rtia028, 
                   g_rtia_m.rtia029,g_rtia_m.rtia030,g_rtia_m.rtia032,g_rtia_m.rtia033,g_rtia_m.rtia034, 
                   g_rtia_m.rtia035,g_rtia_m.rtia036,g_rtia_m.rtia037,g_rtia_m.rtia038,g_rtia_m.rtia039, 
                   g_rtia_m.rtia107,g_rtia_m.rtiaownid,g_rtia_m.rtiacrtid,g_rtia_m.rtiaowndp,g_rtia_m.rtiacrtdp, 
                   g_rtia_m.rtiacrtdt,g_rtia_m.rtiamodid,g_rtia_m.rtiamoddt,g_rtia_m.rtiacnfid,g_rtia_m.rtiacnfdt, 
                   g_rtia_m.rtiapstid,g_rtia_m.rtiapstdt) 
               IF SQLCA.SQLCODE THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "g_rtia_m:",SQLERRMESSAGE 
                  LET g_errparam.code = SQLCA.SQLCODE 
                  LET g_errparam.popup = TRUE 
                  CALL s_transaction_end('N','0')
                  CALL cl_err()
                  NEXT FIELD CURRENT
               END IF
               
               #add-point:單頭新增中 name="input.head.m_insert"
               UPDATE rtia_t SET rtia000 = g_prog,
                                 rtiaunit = g_rtia_m.rtiasite
                WHERE rtiadocno = g_rtia_m.rtiadocno
                  AND rtiaent = g_enterprise
               IF SQLCA.sqlcode THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = SQLCA.sqlcode
                  LET g_errparam.extend = "g_rtia_m"
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
               
                  CALL s_transaction_end('N','0')
                  CONTINUE DIALOG
               END IF
               IF NOT cl_null(g_rtia_m.rtia007) THEN
                  #150424-00020#2--mark by dongsz--str---
#                  #是否依订单产出资料？(Y/N)
#                  IF cl_ask_confirm('art-00307') THEN 
#                     CALL artt622_ins_rtib()
#                  END IF 
                  #150424-00020#2--mark by dongsz--end---
                  IF g_prog = 'artt622' THEN 
                     #CALL artt622_ins_rtib()         #150424-00020#2--add by dongsz  #160604-00009#85 dongsz mark
                  #add by yangxf ----start----
                  END IF 
                  #IF g_prog = 'artt610' OR g_prog = 'artt700' OR g_prog = 'artt620' THEN   #add by yangxf 20151127  add g_prog = 'artt620'  #160604-00009#85 dongsz mark
                  IF g_prog = 'artt610' OR g_prog = 'artt700' OR g_prog = 'artt620' OR g_prog = 'artt622' THEN     #160604-00009#85 dongsz add
                     CALL artt622_ins_rtib_1()      
                  END IF 
                  IF g_prog = 'artt800' THEN 
                     CALL artt622_ins_rtib_2()
                  END IF 
                  #add by yangxf ---end-----
               END IF
          
               #end add-point
               
               
               
               
               #add-point:單頭新增後 name="input.head.a_insert"
               #160604-00009#85--dongsz add--s
               #更新单头含税金额
               UPDATE rtia_t SET rtia031 = (SELECT SUM(rtib021)
                                              FROM rtib_t
                                             WHERE rtibent = g_enterprise
                                               AND rtibdocno = g_rtia_m.rtiadocno),
                                 rtia049 = (SELECT SUM(rtib031)
                                              FROM rtib_t
                                             WHERE rtibent = g_enterprise
                                               AND rtibdocno = g_rtia_m.rtiadocno),
                                 rtia047 = (SELECT SUM(rtib108)
                                              FROM rtib_t
                                             WHERE rtibent = g_enterprise
                                               AND rtibdocno = g_rtia_m.rtiadocno)
                WHERE rtiaent = g_enterprise
                  AND rtiadocno = g_rtia_m.rtiadocno
               SELECT rtia047,rtia043 - rtia047 INTO  g_rtia_m.rtia047,g_rtia_m.l_rtia047
                 FROM rtia_t
                WHERE rtiaent = g_enterprise
                  AND rtiadocno = g_rtia_m.rtiadocno   
               DISPLAY BY NAME g_rtia_m.rtia047,g_rtia_m.l_rtia047  
               #160604-00009#85--dongsz add--e               
               #end add-point
               CALL s_transaction_end('Y','0') 
               
               IF l_cmd_t = 'r' AND p_cmd = 'a' THEN
                  CALL artt622_detail_reproduce()
                  #因應特定程式需求, 重新刷新單身資料
                  CALL artt622_b_fill()
                  CALL artt622_b_fill2('0')
               END IF
               
               #add-point:單頭新增後 name="input.head.a_insert2"
               IF NOT cl_null(g_barcode) THEN
              LET g_master_insert = TRUE
              IF s_transaction_chk("N",0) THEN
               CALL s_transaction_begin()
              END IF
              # SELECT COUNT (*) INTO l_l FROM rtib_t WHERE rtibent=g_enterprise  AND rtibdocno=g_rtia_m.rtiadocno AND rtib003=g_barcode             
               CALL artt622_tmq()  RETURNING l_success                  
                 IF  l_success THEN 
                     CALL s_transaction_end('Y','O')
                     UPDATE rtia_t SET rtia031 = (SELECT SUM(rtib021)
                                              FROM rtib_t
                                             WHERE rtibent = g_enterprise
                                               AND rtibdocno = g_rtia_m.rtiadocno),
                                 rtia049 = (SELECT SUM(rtib031)
                                              FROM rtib_t
                                             WHERE rtibent = g_enterprise
                                               AND rtibdocno = g_rtia_m.rtiadocno),
                                 rtia047 = (SELECT SUM(rtib108)
                                              FROM rtib_t
                                             WHERE rtibent = g_enterprise
                                               AND rtibdocno = g_rtia_m.rtiadocno)
                WHERE rtiaent = g_enterprise
                  AND rtiadocno = g_rtia_m.rtiadocno
               SELECT rtia047,rtia043 - rtia047 INTO  g_rtia_m.rtia047,g_rtia_m.l_rtia047
                 FROM rtia_t
                WHERE rtiaent = g_enterprise
                  AND rtiadocno = g_rtia_m.rtiadocno   
               DISPLAY BY NAME g_rtia_m.rtia047,g_rtia_m.l_rtia047
               SELECT SUM(rtib012),SUM(rtib008*rtib017),SUM(rtib020),SUM(rtib021)
                  INTO g_rtia_m.snum,g_rtia_m.amount,g_rtia_m.amount2,g_rtia_m.amount3
                  FROM rtib_t
                  WHERE rtibent = g_enterprise
                  AND rtibdocno = g_rtia_m.rtiadocno
                  DISPLAY g_rtia_m.snum TO FORMONLY.snum  
                  DISPLAY g_rtia_m.amount TO FORMONLY.amount
                  DISPLAY g_rtia_m.amount2 TO FORMONLY.amount2
                  DISPLAY g_rtia_m.amount3 TO FORMONLY.amount3
                 ELSE
                     CALL s_transaction_end('N','O')
                 END IF                 
                  CALL artt622_b_fill()
                  CALL artt622_b_fill2('0')
                  LET g_rtia_m.barcode=''
                  let p_cmd='u'
                  #DISPLAY '' TO formonly.barcode
                  NEXT FIELD barcode              
            ELSE 
                         
            END IF                       
               #end add-point
               
               LET g_master_insert = TRUE
               
               LET p_cmd = 'u'
            ELSE
               CALL s_transaction_begin()
            
               #add-point:單頭修改前 name="input.head.b_update"
            IF NOT cl_null(g_barcode) THEN
             IF s_transaction_chk("N",0) THEN
               CALL s_transaction_begin()
              END IF
              # SELECT COUNT (*) INTO l_l FROM rtib_t WHERE rtibent=g_enterprise  AND rtibdocno=g_rtia_m.rtiadocno AND rtib003=g_barcode
               #IF l_l=0 THEN                
                  CALL artt622_tmq()  RETURNING l_success                  
               # ELSE 
               ##   UPDATE rtib_t  SET rtib012=rtib012+1
                #  WHERE rtibent=g_enterprise  AND rtibdocno=g_rtia_m.rtiadocno AND rtib003=g_barcode
               # END IF
                IF  l_success THEN 
                     CALL s_transaction_end('Y','O')
                     UPDATE rtia_t SET rtia031 = (SELECT SUM(rtib021)
                                              FROM rtib_t
                                             WHERE rtibent = g_enterprise
                                               AND rtibdocno = g_rtia_m.rtiadocno),
                                 rtia049 = (SELECT SUM(rtib031)
                                              FROM rtib_t
                                             WHERE rtibent = g_enterprise
                                               AND rtibdocno = g_rtia_m.rtiadocno),
                                 rtia047 = (SELECT SUM(rtib108)
                                              FROM rtib_t
                                             WHERE rtibent = g_enterprise
                                               AND rtibdocno = g_rtia_m.rtiadocno)
                WHERE rtiaent = g_enterprise
                  AND rtiadocno = g_rtia_m.rtiadocno
               SELECT rtia047,rtia043 - rtia047 INTO  g_rtia_m.rtia047,g_rtia_m.l_rtia047
                 FROM rtia_t
                WHERE rtiaent = g_enterprise
                  AND rtiadocno = g_rtia_m.rtiadocno   
               DISPLAY BY NAME g_rtia_m.rtia047,g_rtia_m.l_rtia047
               SELECT SUM(rtib012),SUM(rtib008*rtib017),SUM(rtib020),SUM(rtib021)
                  INTO g_rtia_m.snum,g_rtia_m.amount,g_rtia_m.amount2,g_rtia_m.amount3
                  FROM rtib_t
                  WHERE rtibent = g_enterprise
                  AND rtibdocno = g_rtia_m.rtiadocno
                  DISPLAY g_rtia_m.snum TO FORMONLY.snum  
                  DISPLAY g_rtia_m.amount TO FORMONLY.amount
                  DISPLAY g_rtia_m.amount2 TO FORMONLY.amount2
                  DISPLAY g_rtia_m.amount3 TO FORMONLY.amount3
                 ELSE
                     CALL s_transaction_end('N','O')
                 END IF                 
                  CALL artt622_b_fill()
                  CALL artt622_b_fill2('0')
                  LET g_rtia_m.barcode=''
                  #DISPLAY '' TO formonly.barcode
                  NEXT FIELD barcode              
            ELSE 
                         
            END IF                       
               #end add-point
               
               #將遮罩欄位還原
               CALL artt622_rtia_t_mask_restore('restore_mask_o')
               
               UPDATE rtia_t SET (rtiasite,rtiadocdt,rtiadocno,rtia002,rtia001,rtia059,rtia060,rtia004, 
                   rtia005,rtia006,rtia048,rtia053,rtiastus,rtia007,rtia008,rtia009,rtia043,rtia047, 
                   rtia013,rtia014,rtia015,rtia016,rtia051,rtia010,rtia011,rtia012,rtia041,rtia017,rtia018, 
                   rtia019,rtia020,rtia021,rtia022,rtia023,rtia024,rtia025,rtia026,rtia027,rtia028,rtia029, 
                   rtia030,rtia032,rtia033,rtia034,rtia035,rtia036,rtia037,rtia038,rtia039,rtia107,rtiaownid, 
                   rtiacrtid,rtiaowndp,rtiacrtdp,rtiacrtdt,rtiamodid,rtiamoddt,rtiacnfid,rtiacnfdt,rtiapstid, 
                   rtiapstdt) = (g_rtia_m.rtiasite,g_rtia_m.rtiadocdt,g_rtia_m.rtiadocno,g_rtia_m.rtia002, 
                   g_rtia_m.rtia001,g_rtia_m.rtia059,g_rtia_m.rtia060,g_rtia_m.rtia004,g_rtia_m.rtia005, 
                   g_rtia_m.rtia006,g_rtia_m.rtia048,g_rtia_m.rtia053,g_rtia_m.rtiastus,g_rtia_m.rtia007, 
                   g_rtia_m.rtia008,g_rtia_m.rtia009,g_rtia_m.rtia043,g_rtia_m.rtia047,g_rtia_m.rtia013, 
                   g_rtia_m.rtia014,g_rtia_m.rtia015,g_rtia_m.rtia016,g_rtia_m.rtia051,g_rtia_m.rtia010, 
                   g_rtia_m.rtia011,g_rtia_m.rtia012,g_rtia_m.rtia041,g_rtia_m.rtia017,g_rtia_m.rtia018, 
                   g_rtia_m.rtia019,g_rtia_m.rtia020,g_rtia_m.rtia021,g_rtia_m.rtia022,g_rtia_m.rtia023, 
                   g_rtia_m.rtia024,g_rtia_m.rtia025,g_rtia_m.rtia026,g_rtia_m.rtia027,g_rtia_m.rtia028, 
                   g_rtia_m.rtia029,g_rtia_m.rtia030,g_rtia_m.rtia032,g_rtia_m.rtia033,g_rtia_m.rtia034, 
                   g_rtia_m.rtia035,g_rtia_m.rtia036,g_rtia_m.rtia037,g_rtia_m.rtia038,g_rtia_m.rtia039, 
                   g_rtia_m.rtia107,g_rtia_m.rtiaownid,g_rtia_m.rtiacrtid,g_rtia_m.rtiaowndp,g_rtia_m.rtiacrtdp, 
                   g_rtia_m.rtiacrtdt,g_rtia_m.rtiamodid,g_rtia_m.rtiamoddt,g_rtia_m.rtiacnfid,g_rtia_m.rtiacnfdt, 
                   g_rtia_m.rtiapstid,g_rtia_m.rtiapstdt)
                WHERE rtiaent = g_enterprise AND rtiadocno = g_rtiadocno_t
 
               IF SQLCA.SQLCODE THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "rtia_t:",SQLERRMESSAGE 
                  LET g_errparam.code = SQLCA.SQLCODE 
                  LET g_errparam.popup = TRUE 
                  CALL s_transaction_end('N','0')
                  CALL cl_err()
                  NEXT FIELD CURRENT
               END IF
               
               #add-point:單頭修改中 name="input.head.m_update"
 
               #end add-point
               
               
               
               
               #將遮罩欄位進行遮蔽
               CALL artt622_rtia_t_mask_restore('restore_mask_n')
               
               #修改歷程記錄(單頭修改)
               LET g_log1 = util.JSON.stringify(g_rtia_m_t)
               LET g_log2 = util.JSON.stringify(g_rtia_m)
               IF NOT cl_log_modified_record(g_log1,g_log2) THEN 
                  CALL s_transaction_end('N','0')
               ELSE
                  CALL s_transaction_end('Y','0')
               END IF
               
               #add-point:單頭修改後 name="input.head.a_update"
              
            
               #end add-point
            END IF
            
            LET g_master_commit = "Y"
            LET g_rtiadocno_t = g_rtia_m.rtiadocno
 
            
      END INPUT
   
 
{</section>}
 
{<section id="artt622.input.body" >}
   
      #Page1 預設值產生於此處
      INPUT ARRAY g_rtib_d FROM s_detail1.*
          ATTRIBUTE(COUNT = g_rec_b,WITHOUT DEFAULTS, #MAXCOUNT = g_max_rec,
                  INSERT ROW = l_allow_insert, 
                  DELETE ROW = l_allow_delete,
                  APPEND ROW = l_allow_insert)
 
         #自訂ACTION(detail_input,page_1)
         
         
         BEFORE INPUT
            #add-point:資料輸入前 name="input.body.before_input2"
            IF g_prog = 'artt800' THEN 
               EXIT DIALOG
            END IF 
            #150429-00007#9--dongsz add--str
            IF g_prog = 'aprt280' THEN 
               EXIT DIALOG
            END IF 
            #150429-00007#9--dongsz add--end
            #end add-point
            IF g_insert = 'Y' AND NOT cl_null(g_insert) THEN 
              CALL FGL_SET_ARR_CURR(g_rtib_d.getLength()+1) 
              LET g_insert = 'N' 
           END IF 
 
            CALL artt622_b_fill()
            #如果一直都在單身1則控制筆數位置
            IF g_loc = 'm' AND g_rec_b != 0 THEN
               CALL FGL_SET_ARR_CURR(g_idx_group.getValue("'1',"))
            END IF
            LET g_loc = 'm'
            LET g_rec_b = g_rtib_d.getLength()
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
            OPEN artt622_cl USING g_enterprise,g_rtia_m.rtiadocno
            IF SQLCA.SQLCODE THEN   #(ver:78)
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "OPEN artt622_cl:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE   #(ver:78)
               LET g_errparam.popup = TRUE 
               CLOSE artt622_cl
               CALL s_transaction_end('N','0')
               CALL cl_err()
               RETURN
            END IF
            
            LET g_rec_b = g_rtib_d.getLength()
            
            IF g_rec_b >= l_ac 
               AND g_rtib_d[l_ac].rtibseq IS NOT NULL
 
            THEN
               LET l_cmd='u'
               LET g_rtib_d_t.* = g_rtib_d[l_ac].*  #BACKUP
               LET g_rtib_d_o.* = g_rtib_d[l_ac].*  #BACKUP
               CALL artt622_set_entry_b(l_cmd)
               #add-point:modify段after_set_entry_b name="input.body.after_set_entry_b"
                                             
               #end add-point  
               CALL artt622_set_no_entry_b(l_cmd)
               IF NOT artt622_lock_b("rtib_t","'1'") THEN
                  LET l_lock_sw='Y'
               ELSE
                  FETCH artt622_bcl INTO g_rtib_d[l_ac].rtibsite,g_rtib_d[l_ac].rtibunit,g_rtib_d[l_ac].rtiborga, 
                      g_rtib_d[l_ac].rtibseq,g_rtib_d[l_ac].rtib035,g_rtib_d[l_ac].rtib042,g_rtib_d[l_ac].rtib001, 
                      g_rtib_d[l_ac].rtib002,g_rtib_d[l_ac].rtib003,g_rtib_d[l_ac].rtib004,g_rtib_d[l_ac].rtib005, 
                      g_rtib_d[l_ac].rtib106,g_rtib_d[l_ac].rtib012,g_rtib_d[l_ac].rtib108,g_rtib_d[l_ac].rtib013, 
                      g_rtib_d[l_ac].rtib107,g_rtib_d[l_ac].rtib008,g_rtib_d[l_ac].rtib009,g_rtib_d[l_ac].rtib010, 
                      g_rtib_d[l_ac].rtib014,g_rtib_d[l_ac].rtib015,g_rtib_d[l_ac].rtib016,g_rtib_d[l_ac].rtib018, 
                      g_rtib_d[l_ac].rtib017,g_rtib_d[l_ac].rtib019,g_rtib_d[l_ac].rtib020,g_rtib_d[l_ac].rtib021, 
                      g_rtib_d[l_ac].rtib031,g_rtib_d[l_ac].rtib022,g_rtib_d[l_ac].rtib024,g_rtib_d[l_ac].rtib025, 
                      g_rtib_d[l_ac].rtib026,g_rtib_d[l_ac].rtib027,g_rtib_d[l_ac].rtib032,g_rtib_d[l_ac].rtib033, 
                      g_rtib_d[l_ac].rtib028,g_rtib_d[l_ac].rtib030,g_rtib_d[l_ac].rtib039,g_rtib_d[l_ac].rtib006 
 
                  IF SQLCA.SQLCODE THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = g_rtib_d_t.rtibseq,":",SQLERRMESSAGE 
                     LET g_errparam.code = SQLCA.SQLCODE 
                     LET g_errparam.popup = TRUE 
                     CALL cl_err()
                     LET l_lock_sw = "Y"
                  END IF
                  
                  #遮罩相關處理
                  LET g_rtib_d_mask_o[l_ac].* =  g_rtib_d[l_ac].*
                  CALL artt622_rtib_t_mask()
                  LET g_rtib_d_mask_n[l_ac].* =  g_rtib_d[l_ac].*
                  
                  LET g_bfill = "N"
                  CALL artt622_show()
                  LET g_bfill = "Y"
                  
                  CALL cl_show_fld_cont()
               END IF
            ELSE
               LET l_cmd='a'
            END IF
            #add-point:modify段before row name="input.body.before_row"
            #150424-00020#2--mark by dongsz--str---
#            SELECT xmda001 INTO g_rtib_d[l_ac].xmda001
#              FROM xmda_t
#             WHERE xmdaent = g_enterprise
#               AND xmdadocno = g_rtib_d[l_ac].rtib001
            #150424-00020#2--mark by dongsz--end---
            #150424-00020#2--add by dongsz--str---
            IF l_cmd = 'a' AND g_prog = 'artt600' THEN
               CALL FGL_SET_ARR_CURR(l_ac-1)
            END IF
            #150424-00020#2--add by dongsz--end---
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_rtib_d[l_ac].rtib004
            CALL ap_ref_array2(g_ref_fields,"SELECT imaal003,imaal004 FROM imaal_t WHERE imaalent='"||g_enterprise||"' AND imaal001=? AND imaal002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_rtib_d[l_ac].rtib004_desc = '', g_rtn_fields[1] , ''
            LET g_rtib_d[l_ac].rtib004_desc_desc = '', g_rtn_fields[2] , ''
            DISPLAY BY NAME g_rtib_d[l_ac].rtib004_desc,g_rtib_d[l_ac].rtib004_desc_desc
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_rtib_d[l_ac].rtib013
            CALL ap_ref_array2(g_ref_fields,"SELECT oocal003 FROM oocal_t WHERE oocalent='"||g_enterprise||"' AND oocal001=? AND oocal002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_rtib_d[l_ac].rtib013_desc = '', g_rtn_fields[1] , ''
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_rtib_d[l_ac].rtib018
            CALL ap_ref_array2(g_ref_fields,"SELECT oocal003 FROM oocal_t WHERE oocalent='"||g_enterprise||"' AND oocal001=? AND oocal002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_rtib_d[l_ac].rtib018_desc = '', g_rtn_fields[1] , ''            
            #单头税别不为空且
            IF NOT cl_null(g_rtia_m.rtia028) THEN
               SELECT oodb011 INTO l_oodb011
                 FROM oodb_t,ooef_t
                WHERE oodbent = g_enterprise
                  AND oodb001 = ooef019
                  AND oodb002 = g_rtia_m.rtia028
                  AND oodbent = ooefent
                  AND ooef001 = g_rtia_m.rtiasite
            END IF 
            SELECT oodbl004 INTO g_rtib_d[l_ac].rtib006_desc 
              FROM oodbl_t,ooef_t
             WHERE oodblent = ooefent
              AND ooefent = g_enterprise
              AND ooef001 = g_rtia_m.rtiasite
              AND oodbl001 = ooef019
              AND oodbl002 = g_rtib_d[l_ac].rtib006
            #add by yangxf ---start---              
            IF g_prog = 'artt700' AND l_cmd ='u' THEN 
               LET g_rtib_d[l_ac].rtib012 = g_rtib_d[l_ac].rtib012*(-1)
               LET g_rtib_d[l_ac].rtib017 = g_rtib_d[l_ac].rtib017*(-1)
               LET g_rtib_d[l_ac].rtib020 = g_rtib_d[l_ac].rtib020*(-1)
               LET g_rtib_d[l_ac].rtib021 = g_rtib_d[l_ac].rtib021*(-1)
               LET g_rtib_d[l_ac].rtib022 = g_rtib_d[l_ac].rtib022*(-1)
               LET g_rtib_d[l_ac].rtib031 = g_rtib_d[l_ac].rtib031*(-1)
            END IF 
            IF l_cmd = 'u' AND (g_prog = 'artt610' OR g_prog = 'artt620') THEN  #add by yangxf 20151127  add g_prog = 'artt620' 
               NEXT FIELD rtib004
            END IF 
            #add by yangxf ----end----
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
            INITIALIZE g_rtib_d[l_ac].* TO NULL 
            INITIALIZE g_rtib_d_t.* TO NULL 
            INITIALIZE g_rtib_d_o.* TO NULL 
            #公用欄位給值(單身)
            
            #自定義預設值
                  LET g_rtib_d[l_ac].rtib108 = "0"
      LET g_rtib_d[l_ac].rtib107 = "0"
      LET g_rtib_d[l_ac].rtib020 = "0"
      LET g_rtib_d[l_ac].rtib039 = "N"
 
            #add-point:modify段before備份 name="input.body.insert.before_bak"
            LET g_rtib_d[l_ac].rtib012 = 1           #add by yangxf 新增预设数量为1
            #预设项次
            SELECT MAX(rtibseq) + 1
              INTO g_rtib_d[l_ac].rtibseq
              FROM rtib_t
             WHERE rtibent = g_enterprise
               AND rtibdocno = g_rtia_m.rtiadocno
            IF cl_null(g_rtib_d[l_ac].rtibseq) THEN 
               LET g_rtib_d[l_ac].rtibseq = 1
            END IF
            IF l_oodb011 = '1' THEN 
               LET g_rtib_d[l_ac].rtib006 = g_rtia_m.rtia028
               SELECT oodbl004 INTO g_rtib_d[l_ac].rtib006_desc 
                 FROM oodbl_t,ooef_t
                WHERE oodblent = ooefent
                 AND ooefent = g_enterprise
                 AND ooef001 = g_rtia_m.rtiasite
                 AND oodbl001 = ooef019
                 AND oodbl002 = g_rtib_d[l_ac].rtib006
            END IF
            #add by yangxf ---start----预设销售类型
            IF g_prog = 'artt622' THEN 
               LET g_rtib_d[l_ac].rtib035 = '1' 
               #160604-00009#85--dongsz add--s
               IF NOT cl_null(g_rtia_m.rtia007) THEN
                  LET g_rtib_d[l_ac].rtib035 = '2'
                  LET g_rtib_d[l_ac].rtib042 = '1'
               END IF
               #160604-00009#85--dongsz add--e
            END IF 
            IF g_prog = 'artt610' OR g_prog = 'artt620' THEN   #add by yangxf 20151127  add g_prog = 'artt620' 
               IF NOT cl_null(g_rtia_m.rtia007) THEN 
                  LET g_rtib_d[l_ac].rtib035 = '2' 
                  LET g_rtib_d[l_ac].rtib001 = g_rtia_m.rtia007
               ELSE 
                  LET g_rtib_d[l_ac].rtib035 = '1' 
               END IF 
            END IF 
            IF g_prog = 'artt700' THEN 
               LET g_rtib_d[l_ac].rtib035 = '2' 
               IF NOT cl_null(g_rtia_m.rtia007) THEN 
                  LET g_rtib_d[l_ac].rtib001 = g_rtia_m.rtia007
               END IF 
            END IF
            #add by yangxf ---end-----
            LET g_rtib_d[l_ac].rtibsite = g_rtia_m.rtiasite
            LET g_rtib_d[l_ac].rtibunit = g_rtia_m.rtiasite
            LET g_rtib_d[l_ac].rtiborga = g_rtia_m.rtiasite
            #end add-point
            LET g_rtib_d_t.* = g_rtib_d[l_ac].*     #新輸入資料
            LET g_rtib_d_o.* = g_rtib_d[l_ac].*     #新輸入資料
            CALL cl_show_fld_cont()
            CALL artt622_set_entry_b(l_cmd)
            #add-point:modify段after_set_entry_b name="input.body.insert.after_set_entry_b"
                                    
            #end add-point
            CALL artt622_set_no_entry_b(l_cmd)
            IF lb_reproduce THEN
               LET lb_reproduce = FALSE
               LET g_rtib_d[li_reproduce_target].* = g_rtib_d[li_reproduce].*
 
               LET g_rtib_d[li_reproduce_target].rtibseq = NULL
 
            END IF
            
 
            #add-point:modify段before insert name="input.body.before_insert"
            IF g_prog = 'artt610' OR g_prog = 'artt620' THEN   #add by yangxf 20151127  add g_prog = 'artt620' 
               NEXT FIELD rtib004
            END IF 
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
            IF g_prog = 'artt700' THEN
               #更新多库儲批明細
               CALL s_artt622_rtin_modify('a',g_rtib_d[l_ac].rtibsite,g_rtia_m.rtiadocno,g_rtib_d[l_ac].rtibseq,'',g_rtib_d[l_ac].rtib004,g_rtib_d[l_ac].rtib005,
                                          g_prog,'',g_rtib_d[l_ac].rtib025,g_rtib_d[l_ac].rtib026,g_rtib_d[l_ac].rtib027,g_rtib_d[l_ac].rtib013,g_rtib_d[l_ac].rtib012*(-1),g_rtib_d[l_ac].rtib032) RETURNING l_success
            ELSE
               #150819-00004#1 150819 By pomelo add(S)
               #當數量為正數表示入項
               IF g_rtib_d[l_ac].rtib012 < 0 AND cl_null(g_rtib_d[l_ac].rtib027) THEN
                  LET l_success = ''
                  CALL s_lot_out_get_batch_no(g_rtib_d[l_ac].rtib004)
                     RETURNING l_success,g_rtib_d[l_ac].rtib027
                  IF l_success = FALSE THEN
                     CALL s_transaction_end('N','0')
                        CANCEL INSERT
                  END IF
               END IF
               #150819-00004#1 150819 By pomelo add(E)
               #更新多库儲批明細
               CALL s_artt622_rtin_modify('a',g_rtib_d[l_ac].rtibsite,g_rtia_m.rtiadocno,g_rtib_d[l_ac].rtibseq,'',g_rtib_d[l_ac].rtib004,g_rtib_d[l_ac].rtib005,
                                          g_prog,'',g_rtib_d[l_ac].rtib025,g_rtib_d[l_ac].rtib026,g_rtib_d[l_ac].rtib027,g_rtib_d[l_ac].rtib013,g_rtib_d[l_ac].rtib012,g_rtib_d[l_ac].rtib032) RETURNING l_success
            END IF 
            IF NOT l_success THEN
               CALL s_transaction_end('N','0')                    
               CANCEL INSERT
            END IF
            #end add-point
               
            LET l_count = 1  
            SELECT COUNT(1) INTO l_count FROM rtib_t 
             WHERE rtibent = g_enterprise AND rtibdocno = g_rtia_m.rtiadocno
 
               AND rtibseq = g_rtib_d[l_ac].rtibseq
 
                
            #資料未重複, 插入新增資料
            IF l_count = 0 THEN 
               #add-point:單身新增前 name="input.body.b_insert"
                              
               #end add-point
            
               #同步新增到同層的table
                              INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_rtia_m.rtiadocno
               LET gs_keys[2] = g_rtib_d[g_detail_idx].rtibseq
               CALL artt622_insert_b('rtib_t',gs_keys,"'1'")
                           
               #add-point:單身新增後 name="input.body.a_insert"
               #add by yangxf 20151127 ---start---
               IF g_prog = 'artt620' THEN    
                  #标准价 
                  LET l_rtib021 = g_rtib_d[l_ac].rtib017 * g_rtib_d[l_ac].rtib008
                  #先删除对应折价明细
                  DELETE FROM rtic_t
                   WHERE rticent = g_enterprise
                     AND rticdocno = g_rtia_m.rtiadocno
                     AND rticseq = g_rtib_d[l_ac].rtibseq
                  IF l_rtib021 != g_rtib_d[l_ac].rtib021 THEN 
                     #寫折價
                     IF NOT artt622_ins_rtic2(g_rtib_d[l_ac].rtibseq,g_rtib_d[l_ac].rtib021,l_rtib021,g_rtib_d[l_ac].rtib017) THEN
                        CALL s_transaction_end('N','0')
                        CANCEL INSERT
                     END IF
                     #更新折扣金额                  
                     UPDATE rtib_t SET rtib020 = l_rtib021 - g_rtib_d[l_ac].rtib021
                      WHERE rtibent = g_enterprise
                        AND rtibdocno = g_rtia_m.rtiadocno
                        AND rtibseq = g_rtib_d[l_ac].rtibseq
                     IF SQLCA.SQLcode  THEN
                        INITIALIZE g_errparam TO NULL 
                        LET g_errparam.extend = "rtib_t" 
                        LET g_errparam.code   = SQLCA.sqlcode 
                        LET g_errparam.popup  = TRUE 
                        CALL cl_err()
                        CALL s_transaction_end('N','0')                    
                        CANCEL INSERT
                     END IF 
                  END IF 
               END IF 
               #add by yangxf 20151127----end-----
               #end add-point
            ELSE    
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = 'INSERT' 
               LET g_errparam.code = "std-00006" 
               LET g_errparam.popup = TRUE 
               INITIALIZE g_rtib_d[l_ac].* TO NULL
               CALL s_transaction_end('N','0')
               CALL cl_err()
               CANCEL INSERT
            END IF
 
            IF SQLCA.SQLCODE THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "rtib_t:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE 
               LET g_errparam.popup = TRUE 
               CALL s_transaction_end('N','0')                    
               CALL cl_err()
               CANCEL INSERT
            ELSE
               #先刷新資料
               #CALL artt622_b_fill()
               #資料多語言用-增/改
               
               #add-point:input段-after_insert name="input.body.a_insert2"

               CALL artt622_b_fill()
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
               #add by yangxf ----start---artt622不支持单身删除
               IF g_prog = 'artt600' THEN 
                  CANCEL DELETE 
               END IF 
               #add by yangxf ----end----
               #150819-00004#1 150819 By pomelo add(S)
               #更新自動編碼最大流水號檔
               IF NOT cl_null(g_rtib_d[l_ac].rtib027) THEN
                  IF NOT s_aooi390_oofi_del('6',g_rtib_d[l_ac].rtib027) THEN
                     CANCEL DELETE
                  END IF
               END IF
               #150819-00004#1 150819 By pomelo add(E)
               #刪除多库储批明細資料
               CALL s_artt622_rtin_del(g_rtia_m.rtiadocno,g_rtib_d_t.rtibseq) RETURNING l_success
               IF NOT l_success THEN 
                  CALL s_transaction_end('N','0')
                  CANCEL DELETE   
               END IF 
                DELETE FROM xrcd_t
                 WHERE xrcdseq2 = '0'
                   AND xrcdseq = g_rtib_d_t.rtibseq
                   AND xrcddocno = g_rtia_m.rtiadocno
                   AND xrcdent = g_enterprise
               IF SQLCA.sqlcode THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = SQLCA.sqlcode
                  LET g_errparam.extend = "rtib_t"
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  CALL s_transaction_end('N','0')
                  CANCEL DELETE   
               END IF 
               #end add-point 
               
               #取得該筆資料key值
               INITIALIZE gs_keys TO NULL
               LET gs_keys[01] = g_rtia_m.rtiadocno
 
               LET gs_keys[gs_keys.getLength()+1] = g_rtib_d_t.rtibseq
 
            
               #刪除同層單身
               IF NOT artt622_delete_b('rtib_t',gs_keys,"'1'") THEN
                  CALL s_transaction_end('N','0')
                  CLOSE artt622_bcl
                  CANCEL DELETE
               END IF
    
               #刪除下層單身
               IF NOT artt622_key_delete_b(gs_keys,'rtib_t') THEN
                  CALL s_transaction_end('N','0')
                  CLOSE artt622_bcl
                  CANCEL DELETE
               END IF
               
               #刪除多語言
               
 
               
               #add-point:單身刪除中 name="input.body.m_delete"
                              
               #end add-point 
               
               CALL s_transaction_end('Y','0')
               CLOSE artt622_bcl
            
               LET g_rec_b = g_rec_b-1
               #add-point:單身刪除後 name="input.body.a_delete"
               
               #end add-point
               LET l_count = g_rtib_d.getLength()
               
               #add-point:單身刪除後(<>d) name="input.body.after_delete"
                        
               #end add-point
            END IF
 
         AFTER DELETE
            #如果是最後一筆
            IF l_ac = (g_rtib_d.getLength() + 1) THEN
               CALL FGL_SET_ARR_CURR(l_ac-1)
            END IF
 
                  #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtibsite
            #add-point:BEFORE FIELD rtibsite name="input.b.page1.rtibsite"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtibsite
            
            #add-point:AFTER FIELD rtibsite name="input.a.page1.rtibsite"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE rtibsite
            #add-point:ON CHANGE rtibsite name="input.g.page1.rtibsite"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtibunit
            #add-point:BEFORE FIELD rtibunit name="input.b.page1.rtibunit"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtibunit
            
            #add-point:AFTER FIELD rtibunit name="input.a.page1.rtibunit"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE rtibunit
            #add-point:ON CHANGE rtibunit name="input.g.page1.rtibunit"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtiborga
            #add-point:BEFORE FIELD rtiborga name="input.b.page1.rtiborga"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtiborga
            
            #add-point:AFTER FIELD rtiborga name="input.a.page1.rtiborga"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE rtiborga
            #add-point:ON CHANGE rtiborga name="input.g.page1.rtiborga"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtibseq
            #add-point:BEFORE FIELD rtibseq name="input.b.page1.rtibseq"
                        
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtibseq
            
            #add-point:AFTER FIELD rtibseq name="input.a.page1.rtibseq"
                                    #此段落由子樣板a05產生
            IF  g_rtia_m.rtiadocno IS NOT NULL AND g_rtib_d[g_detail_idx].rtibseq IS NOT NULL THEN 
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_rtia_m.rtiadocno != g_rtiadocno_t OR g_rtib_d[g_detail_idx].rtibseq != g_rtib_d_t.rtibseq)) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM rtib_t WHERE "||"rtibent = '" ||g_enterprise|| "' AND "||"rtibdocno = '"||g_rtia_m.rtiadocno ||"' AND "|| "rtibseq = '"||g_rtib_d[g_detail_idx].rtibseq ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
#                  CALL artt622_get_price()   #add by yangxf  取价
               END IF
            END IF
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE rtibseq
            #add-point:ON CHANGE rtibseq name="input.g.page1.rtibseq"
                        
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtib035
            #add-point:BEFORE FIELD rtib035 name="input.b.page1.rtib035"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtib035
            
            #add-point:AFTER FIELD rtib035 name="input.a.page1.rtib035"
 
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE rtib035
            #add-point:ON CHANGE rtib035 name="input.g.page1.rtib035"
            IF g_rtib_d[l_ac].rtib035 = '1' THEN 
               LET g_rtib_d[l_ac].rtib001 = ''
               LET g_rtib_d[l_ac].rtib002 = ''
               LET g_rtib_d[l_ac].rtib003 = ''
               LET g_rtib_d[l_ac].rtib004 = ''
               LET g_rtib_d[l_ac].rtib004_desc = ''
               LET g_rtib_d[l_ac].rtib006 = ''
               LET g_rtib_d[l_ac].rtib006_desc = ''
               LET g_rtib_d[l_ac].rtib008 = ''
               LET g_rtib_d[l_ac].rtib009 = ''
               LET g_rtib_d[l_ac].rtib010 = ''
               LET g_rtib_d[l_ac].rtib013 = ''
               LET g_rtib_d[l_ac].rtib013_desc = ''
               LET g_rtib_d[l_ac].rtib018 = ''
               LET g_rtib_d[l_ac].rtib018_desc = ''
               LET g_rtib_d[l_ac].rtib017 = ''
               LET g_rtib_d[l_ac].rtib020 = 0
               LET g_rtib_d[l_ac].rtib021 = ''
               LET g_rtib_d[l_ac].rtib012 = 1
               CALL cl_set_comp_entry("rtib001,rtib002",FALSE)
               CALL cl_set_comp_entry("rtib003,rtib004",TRUE)
            ELSE 
               LET g_rtib_d[l_ac].rtib001 = ''
               LET g_rtib_d[l_ac].rtib002 = ''
               LET g_rtib_d[l_ac].rtib003 = ''
               LET g_rtib_d[l_ac].rtib004 = ''
               LET g_rtib_d[l_ac].rtib004_desc = ''
               LET g_rtib_d[l_ac].rtib006 = ''
               LET g_rtib_d[l_ac].rtib006_desc = ''
               LET g_rtib_d[l_ac].rtib008 = ''
               LET g_rtib_d[l_ac].rtib009 = ''
               LET g_rtib_d[l_ac].rtib010 = ''
               LET g_rtib_d[l_ac].rtib013 = ''
               LET g_rtib_d[l_ac].rtib013_desc = ''
               LET g_rtib_d[l_ac].rtib018 = ''
               LET g_rtib_d[l_ac].rtib018_desc = ''
               LET g_rtib_d[l_ac].rtib017 = ''
               LET g_rtib_d[l_ac].rtib020 = 0
               LET g_rtib_d[l_ac].rtib021 = ''
               LET g_rtib_d[l_ac].rtib012 = -1
               IF NOT cl_null(g_rtia_m.rtia007) THEN
                  LET g_rtib_d[l_ac].rtib001 = g_rtia_m.rtia007
                  CALL cl_set_comp_entry("rtib001",FALSE)
                  CALL cl_set_comp_entry("rtib002",TRUE)
                  CALL cl_set_comp_entry("rtib003,rtib004",FALSE)
               ELSE                  
                  CALL cl_set_comp_entry("rtib001,rtib002",TRUE)
               END IF 
            END IF 
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtib042
            #add-point:BEFORE FIELD rtib042 name="input.b.page1.rtib042"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtib042
            
            #add-point:AFTER FIELD rtib042 name="input.a.page1.rtib042"
            CALL artt622_set_entry_b(l_cmd)       #160604-00009#85 dongsz add
            CALL artt622_set_no_entry_b(l_cmd)    #160604-00009#85 dongsz add
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE rtib042
            #add-point:ON CHANGE rtib042 name="input.g.page1.rtib042"
            LET g_rtib_d[l_ac].rtib012 = g_rtib_d[l_ac].rtib012*(-1)     #160604-00009#85 dongsz add
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtib001
            #add-point:BEFORE FIELD rtib001 name="input.b.page1.rtib001"
                        
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtib001
            
            #add-point:AFTER FIELD rtib001 name="input.a.page1.rtib001"
            #150424-00020#2--remark by dongsz--str---
            IF NOT cl_null(g_rtib_d[l_ac].rtib001) THEN 
               CALL artt622_rtib001_chk()
               IF NOT cl_null(g_errno) THEN 
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = g_errno
                  LET g_errparam.extend = ''
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
                  #LET g_rtib_d[l_ac].rtib001 = g_rtib_d_t.rtib001  #160824-00007#172 Mark By Ken 161107
                  LET g_rtib_d[l_ac].rtib001 = g_rtib_d_o.rtib001   #160824-00007#172 Add By Ken 161107
                  NEXT FIELD rtib001
               END IF
               #IF l_cmd = 'a' OR (l_cmd = 'u' AND g_rtib_d[l_ac].rtib001 != g_rtib_d_t.rtib001) THEN   #160824-00007#172 Mark By Ken 161107
               IF g_rtib_d[l_ac].rtib001 != g_rtib_d_o.rtib001 THEN    #160824-00007#172 Add By Ken 161107
                  #检查单号+项次是否重复
                  CALL artt622_rtib001_rtib002_chk()
                  IF NOT cl_null(g_errno) THEN 
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = g_errno
                     LET g_errparam.extend = ''
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                     #LET g_rtib_d[l_ac].rtib001 = g_rtib_d_t.rtib001  #160824-00007#172 Mark By Ken 161107
                     LET g_rtib_d[l_ac].rtib001 = g_rtib_d_o.rtib001   #160824-00007#172 Add By Ken 161107
                     NEXT FIELD rtib001
                  END IF
                  CALL artt622_rtib001_rtib002_desc()
                  IF NOT cl_null(g_errno) THEN 
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = g_errno
                     LET g_errparam.extend = ''
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                     #LET g_rtib_d[l_ac].rtib001 = g_rtib_d_t.rtib001  #160824-00007#172 Mark By Ken 161107
                     LET g_rtib_d[l_ac].rtib001 = g_rtib_d_o.rtib001   #160824-00007#172 Add By Ken 161107                      
                     NEXT FIELD rtib001
                  END IF 
               END IF
               #带出订单数量
               CALL artt622_rtib012(l_cmd)
               #计算计价数量
               CALL artt622_rtib021()
            END IF
            #add by yangxf ---start----
            IF g_prog = 'artt700' OR g_prog = 'artt610' OR g_prog = 'artt620' THEN  #add by yangxf  g_prog = 'artt620'
               IF NOT cl_null(g_rtib_d[l_ac].rtib001) THEN 
                  CALL cl_set_comp_entry("rtib003,rtib004",FALSE)
               ELSE
                  CALL cl_set_comp_entry("rtib003,rtib004",TRUE)
               END IF 
            END IF 
            #add by yangxf ---end---
            #150424-00020#2--remark by dongsz--end---
            LET g_rtib_d_o.* = g_rtib_d[l_ac].*     #160824-00007#172 Add By Ken 161107                     
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE rtib001
            #add-point:ON CHANGE rtib001 name="input.g.page1.rtib001"
                        
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtib002
            #add-point:BEFORE FIELD rtib002 name="input.b.page1.rtib002"
                        
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtib002
            
            #add-point:AFTER FIELD rtib002 name="input.a.page1.rtib002"
            #150424-00020#2--remark by dongsz--str---
            IF NOT cl_null(g_rtib_d[l_ac].rtib002) THEN 
               CALL artt622_rtib001_chk()
               IF NOT cl_null(g_errno) THEN 
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = g_errno
                  LET g_errparam.extend = ''
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  #LET g_rtib_d[l_ac].rtib002 = g_rtib_d_t.rtib002   #160824-00007#172 Mark By Ken 161107
                  LET g_rtib_d[l_ac].rtib002 = g_rtib_d_o.rtib002    #160824-00007#172 Add By Ken 161107
                  NEXT FIELD rtib002
               END IF
               IF l_cmd = 'a' OR (l_cmd = 'u' AND g_rtib_d[l_ac].rtib002 != g_rtib_d_t.rtib002) THEN 
                  #检查单号+项次是否重复
                  CALL artt622_rtib001_rtib002_chk()
                  IF NOT cl_null(g_errno) THEN 
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = g_errno
                     LET g_errparam.extend = ''
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                     #LET g_rtib_d[l_ac].rtib002 = g_rtib_d_t.rtib002   #160824-00007#172 Mark By Ken 161107
                     LET g_rtib_d[l_ac].rtib002 = g_rtib_d_o.rtib002    #160824-00007#172 Add By Ken 161107                     
                     NEXT FIELD rtib002
                  END IF
                  CALL artt622_rtib001_rtib002_desc()
                  IF NOT cl_null(g_errno) THEN 
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = g_errno
                     LET g_errparam.extend = ''
                     LET g_errparam.popup = TRUE
                     CALL cl_err()

                     #LET g_rtib_d[l_ac].rtib002 = g_rtib_d_t.rtib002   #160824-00007#172 Mark By Ken 161107
                     LET g_rtib_d[l_ac].rtib002 = g_rtib_d_o.rtib002    #160824-00007#172 Add By Ken 161107                     
                     NEXT FIELD rtib002
                  END IF 
               END IF 
               #带出订单数量
               CALL artt622_rtib012(l_cmd)
               #计算计价数量
               CALL artt622_rtib021()
            END IF
            #150424-00020#2--remark by dongsz--end---
            LET g_rtib_d_o.* = g_rtib_d[l_ac].*   #160824-00007#172 Add By Ken 161107                     
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE rtib002
            #add-point:ON CHANGE rtib002 name="input.g.page1.rtib002"
                        
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtib003
            #add-point:BEFORE FIELD rtib003 name="input.b.page1.rtib003"
                        
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtib003
            
            #add-point:AFTER FIELD rtib003 name="input.a.page1.rtib003"
            IF NOT cl_null(g_rtib_d[l_ac].rtib003) THEN 
               IF g_rtib_d[l_ac].rtib003 != g_rtib_d_o.rtib003 OR g_rtib_d_o.rtib003 IS NULL THEN    #150427-00001#8 150527 by lori522612 add 應加上新舊值判斷
                  CALL artt622_rtib003_chk()
                  IF NOT cl_null(g_errno) THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = g_errno
                     LET g_errparam.extend = ''
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                  
                     #LET g_rtib_d[l_ac].rtib003 = g_rtib_d_t.rtib003  #160824-00007#172 Mark By Ken 161107
                     LET g_rtib_d[l_ac].rtib003 = g_rtib_d_o.rtib003   #160824-00007#172 Add By Ken 161107
                     NEXT FIELD rtib003
                  END IF
                  CALL artt622_rtib003_display()
                  #检查生命周期有效性
                  #CALL s_life_cycle_chk(g_prog,g_rtia_m.rtiasite,'1',g_rtib_d[l_ac].rtib004) RETURNING r_success    #150616-00035#78-mark by dongsz
                  CALL s_life_cycle_chk(g_prog,g_rtia_m.rtiasite,'1',g_rtib_d[l_ac].rtib004,'','') RETURNING r_success    #150616-00035#78-add by dongsz                  
                  IF r_success = FALSE THEN 
                     NEXT FIELD CURRENT
                  END IF               
                  CALL artt622_rtib021()
                  CALL artt622_get_price()   #add by yangxf  取价
                  IF NOT artt622_point_chk() THEN
                     NEXT FIELD CURRENT
                  END IF
               END IF   #150427-00001#8 150527 by lori522612 add
            END IF 
            
            #150427-00001#8 150527 by lori522612 add---(S)
#mark by yangxf ---start---
#            CALL artt622_set_entry_b(l_cmd)
#            CALL artt622_set_no_required_b()
#            CALL artt622_set_required_b()
#            CALL artt622_set_no_entry_b(l_cmd)
#mark by yangxf ----end----
#add by yangxf ---start----
            CALL cl_set_comp_entry("rtib027",TRUE) 
            CALL artt622_set_no_required_b()
            CALL artt622_set_required_b()
            LET l_success = ''  
            LET l_set_entry = ''
            CALL s_lot_out_entry(-1,g_rtia_m.rtiadocno,g_rtia_m.rtiasite,g_rtib_d[l_ac].rtib004)   
               RETURNING l_success,l_set_entry
            IF l_success THEN
               CALL cl_set_comp_entry("rtib027",l_set_entry) 
            END IF  
#add by yangxf ---end------
            #有帶值時,應使用 _o 進行備份            
            LET g_rtib_d_o.rtib003 = g_rtib_d[l_ac].rtib003   
            LET g_rtib_d_o.rtib004 = g_rtib_d[l_ac].rtib004
            #150427-00001#8 150527 by lori522612 add---(E) 
            #160419-00044#2--dongsz add--str
            CALL artt622_set_entry_b(l_cmd)
            CALL artt622_set_no_entry_b(l_cmd)
            #160419-00044#2--dongsz add--end     
            LET g_rtib_d_o.* = g_rtib_d[l_ac].*   #160824-00007#172 Add By Ken 161107
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE rtib003
            #add-point:ON CHANGE rtib003 name="input.g.page1.rtib003"
                        
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtib004
            
            #add-point:AFTER FIELD rtib004 name="input.a.page1.rtib004"
            IF NOT cl_null(g_rtib_d[l_ac].rtib004) THEN 
               IF g_rtib_d[l_ac].rtib004 != g_rtib_d_o.rtib004 OR g_rtib_d_o.rtib004 IS NULL THEN    #150427-00001#8 150527 by lori522612 add 應加上新舊值判斷
                  CALL artt622_rtib004_chk()
                  IF NOT cl_null(g_errno) THEN 
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = g_errno
                     LET g_errparam.extend = ''
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                  
                     #LET g_rtib_d[l_ac].rtib004 = g_rtib_d_t.rtib004  #160824-00007#172 Mark By Ken 161107
                     LET g_rtib_d[l_ac].rtib004 = g_rtib_d_o.rtib004   #160824-00007#172 Add By Ken 161107
                     NEXT FIELD rtib004
                  END IF
                  CALL artt622_rtib004_display()
                  CALL artt622_rtib021()
                  #检查生命周期有效性
                  #CALL s_life_cycle_chk(g_prog,g_rtia_m.rtiasite,'1',g_rtib_d[l_ac].rtib004) RETURNING r_success   #150616-00035#78-mark by dongsz
                  CALL s_life_cycle_chk(g_prog,g_rtia_m.rtiasite,'1',g_rtib_d[l_ac].rtib004,'','') RETURNING r_success   #150616-00035#78-add by dongsz                  
                  IF r_success = FALSE THEN 
                     NEXT FIELD CURRENT
                  END IF 
                  CALL artt622_get_price()   #add by yangxf  取价
                  IF NOT artt622_point_chk() THEN
                     NEXT FIELD CURRENT
                  END IF
               END IF   #150427-00001#8 150527 by lori522612 add
            END IF
            
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_rtib_d[l_ac].rtib004
            CALL ap_ref_array2(g_ref_fields,"SELECT imaal003,imaal004 FROM imaal_t WHERE imaalent='"||g_enterprise||"' AND imaal001=? AND imaal002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_rtib_d[l_ac].rtib004_desc = '', g_rtn_fields[1] , ''
            LET g_rtib_d[l_ac].rtib004_desc_desc = '', g_rtn_fields[2] , ''
            DISPLAY BY NAME g_rtib_d[l_ac].rtib004_desc,g_rtib_d[l_ac].rtib004_desc_desc
            
            #150427-00001#8 150527 by lori522612 add---(S)
#mark by yangxf ---start---
#            CALL artt622_set_entry_b(l_cmd)
#            CALL artt622_set_no_required_b()
#            CALL artt622_set_required_b()
#            CALL artt622_set_no_entry_b(l_cmd)
#mark by yangxf ----end----
#add by yangxf ---start----
            CALL cl_set_comp_entry("rtib027",TRUE) 
            CALL artt622_set_no_required_b()
            CALL artt622_set_required_b()
            LET l_success = ''  
            LET l_set_entry = ''
            CALL s_lot_out_entry(-1,g_rtia_m.rtiadocno,g_rtia_m.rtiasite,g_rtib_d[l_ac].rtib004)   
               RETURNING l_success,l_set_entry
            IF l_success THEN
               CALL cl_set_comp_entry("rtib027",l_set_entry) 
            END IF  
#add by yangxf ---end------
            #有帶值時,應使用 _o 進行備份            
            LET g_rtib_d_o.rtib003 = g_rtib_d[l_ac].rtib003   
            LET g_rtib_d_o.rtib004 = g_rtib_d[l_ac].rtib004
            #150427-00001#8 150527 by lori522612 add---(E)
            #160419-00044#2--dongsz add--str
            CALL artt622_set_entry_b(l_cmd)
            CALL artt622_set_no_entry_b(l_cmd)
            #160419-00044#2--dongsz add--end 
            LET g_rtib_d_o.* = g_rtib_d[l_ac].*   #160824-00007#172 Add By Ken 161107            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtib004
            #add-point:BEFORE FIELD rtib004 name="input.b.page1.rtib004"
                        
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE rtib004
            #add-point:ON CHANGE rtib004 name="input.g.page1.rtib004"
                        
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtib005
            #add-point:BEFORE FIELD rtib005 name="input.b.page1.rtib005"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtib005
            
            #add-point:AFTER FIELD rtib005 name="input.a.page1.rtib005"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE rtib005
            #add-point:ON CHANGE rtib005 name="input.g.page1.rtib005"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtib106
            #add-point:BEFORE FIELD rtib106 name="input.b.page1.rtib106"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtib106
            
            #add-point:AFTER FIELD rtib106 name="input.a.page1.rtib106"
          if not cl_null(g_rtib_d[l_ac].rtib012) and not cl_null(g_rtib_d[l_ac].rtib106) then 
              let g_rtib_d[l_ac].rtib108=g_rtib_d[l_ac].rtib012*g_rtib_d[l_ac].rtib106
              display by name g_rtib_d[l_ac].rtib108
          end if 
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE rtib106
            #add-point:ON CHANGE rtib106 name="input.g.page1.rtib106"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtib012
            #add-point:BEFORE FIELD rtib012 name="input.b.page1.rtib012"
                        
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtib012
            
            #add-point:AFTER FIELD rtib012 name="input.a.page1.rtib012"
            IF NOT cl_null(g_rtib_d[l_ac].rtib012) THEN 
               IF g_rtib_d[l_ac].rtib012 = 0 THEN 
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'art-00287'
                  LET g_errparam.extend = ''
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  #LET g_rtib_d[l_ac].rtib012 = g_rtib_d_t.rtib012   #160824-00007#172 Mark By Ken 161107
                  LET g_rtib_d[l_ac].rtib012 = g_rtib_d_o.rtib012    #160824-00007#172 Add By Ken 161107
                  NEXT FIELD rtib012
               END IF 
               #add by yangxf ---start---
               IF g_prog = 'artt610' OR g_prog = 'artt622' THEN   #add by yangxf  g_prog = 'artt620'
                  #160604-00009#85--dongsz mark--s
#                  IF g_rtib_d[l_ac].rtib012 > 0 AND g_rtib_d[l_ac].rtib035 = '2' THEN 
#                     INITIALIZE g_errparam TO NULL
#                     LET g_errparam.code = 'art-00587'
#                     LET g_errparam.extend = ''
#                     LET g_errparam.popup = TRUE
#                     CALL cl_err()
#                     LET g_rtib_d[l_ac].rtib012 = g_rtib_d_t.rtib012
#                     NEXT FIELD rtib012
#                  END IF 
                  #160604-00009#85--dongsz mark--e
                  #160604-00009#85--dongsz add--s
                  IF g_rtib_d[l_ac].rtib012 > 0 AND g_rtib_d[l_ac].rtib042 = '1' THEN 
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = 'art-00787'
                     LET g_errparam.extend = ''
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                     #LET g_rtib_d[l_ac].rtib012 = g_rtib_d_t.rtib012   #160824-00007#172 Mark By Ken 161107
                     LET g_rtib_d[l_ac].rtib012 = g_rtib_d_o.rtib012    #160824-00007#172 Add By Ken 161107
                     NEXT FIELD rtib012
                  END IF 
                  IF g_rtib_d[l_ac].rtib012 < 0 AND g_rtib_d[l_ac].rtib042 = '2' THEN 
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = 'art-00788'
                     LET g_errparam.extend = ''
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                     #LET g_rtib_d[l_ac].rtib012 = g_rtib_d_t.rtib012   #160824-00007#172 Mark By Ken 161107
                     LET g_rtib_d[l_ac].rtib012 = g_rtib_d_o.rtib012    #160824-00007#172 Add By Ken 161107                     
                     NEXT FIELD rtib012
                  END IF 
                  #160604-00009#85--dongsz add--e
                  IF g_rtib_d[l_ac].rtib012 < 0 AND g_rtib_d[l_ac].rtib035 = '1' THEN 
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = 'art-00588'
                     LET g_errparam.extend = ''
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                     #LET g_rtib_d[l_ac].rtib012 = g_rtib_d_t.rtib012   #160824-00007#172 Mark By Ken 161107
                     LET g_rtib_d[l_ac].rtib012 = g_rtib_d_o.rtib012    #160824-00007#172 Add By Ken 161107                     
                     NEXT FIELD rtib012
                  END IF
               END IF 
               IF g_prog = 'artt700' THEN 
                  IF g_rtib_d[l_ac].rtib012 < 0 THEN 
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = 'aoo-00006'
                     LET g_errparam.extend = ''
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                     #LET g_rtib_d[l_ac].rtib012 = g_rtib_d_t.rtib012   #160824-00007#172 Mark By Ken 161107
                     LET g_rtib_d[l_ac].rtib012 = g_rtib_d_o.rtib012    #160824-00007#172 Add By Ken 161107                     
                     NEXT FIELD rtib012
                  END IF 
               END IF 
               #add by yangxf ----end-----
               #150424-00020#2--remark by dongsz--str---
               #检查订单数量
               CALL artt622_rtib012(l_cmd)
               IF NOT cl_null(g_errno) THEN 
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = g_errno
                  LET g_errparam.extend = ''
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  #LET g_rtib_d[l_ac].rtib012 = g_rtib_d_t.rtib012   #160824-00007#172 Mark By Ken 161107
                  LET g_rtib_d[l_ac].rtib012 = g_rtib_d_o.rtib012    #160824-00007#172 Add By Ken 161107                  
                  NEXT FIELD rtib012
               END IF 
               #150424-00020#2--remark by dongsz--end---
               CALL artt622_rtib021()
               IF g_prog = 'artt620' THEN    #add by yangxf  g_prog = 'artt620'
                  IF cl_null(g_rtib_d[l_ac].rtib010) THEN 
                     CALL artt622_get_price()   #add by yangxf  取价
                     IF NOT artt622_point_chk() THEN
                        NEXT FIELD CURRENT
                     END IF
                  END IF 
               ELSE
                  CALL artt622_get_price()   #add by yangxf  取价
                  IF NOT artt622_point_chk() THEN
                     NEXT FIELD CURRENT
                  END IF
               END IF 
            END IF 
            LET g_rtib_d_o.* = g_rtib_d[l_ac].*    #160824-00007#172 Add By Ken 161107                  
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE rtib012
            #add-point:ON CHANGE rtib012 name="input.g.page1.rtib012"
                        
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtib108
            #add-point:BEFORE FIELD rtib108 name="input.b.page1.rtib108"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtib108
            
            #add-point:AFTER FIELD rtib108 name="input.a.page1.rtib108"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE rtib108
            #add-point:ON CHANGE rtib108 name="input.g.page1.rtib108"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtib013
            
            #add-point:AFTER FIELD rtib013 name="input.a.page1.rtib013"
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_rtib_d[l_ac].rtib013
            CALL ap_ref_array2(g_ref_fields,"SELECT oocal003 FROM oocal_t WHERE oocalent='"||g_enterprise||"' AND oocal001=? AND oocal002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_rtib_d[l_ac].rtib013_desc = '', g_rtn_fields[1] , ''
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtib013
            #add-point:BEFORE FIELD rtib013 name="input.b.page1.rtib013"
                        
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE rtib013
            #add-point:ON CHANGE rtib013 name="input.g.page1.rtib013"
                        
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtib107
            #add-point:BEFORE FIELD rtib107 name="input.b.page1.rtib107"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtib107
            
            #add-point:AFTER FIELD rtib107 name="input.a.page1.rtib107"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE rtib107
            #add-point:ON CHANGE rtib107 name="input.g.page1.rtib107"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtib008
            #add-point:BEFORE FIELD rtib008 name="input.b.page1.rtib008"
                        
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtib008
            
            #add-point:AFTER FIELD rtib008 name="input.a.page1.rtib008"
             IF NOT cl_null(g_rtib_d[l_ac].rtib008) THEN 
                IF g_rtib_d[l_ac].rtib008 < 0 THEN 
                   INITIALIZE g_errparam TO NULL
                   LET g_errparam.code = 'art-00394'
                   LET g_errparam.extend = ''
                   LET g_errparam.popup = TRUE
                   CALL cl_err()

                   #LET g_rtib_d[l_ac].rtib008 = g_rtib_d_t.rtib008  #160824-00007#172 Mark By Ken 161107
                   LET g_rtib_d[l_ac].rtib008 = g_rtib_d_o.rtib008   #160824-00007#172 Add By Ken 161107
                   NEXT FIELD rtib008
                END IF 
                LET g_rtib_d[l_ac].rtib008 = s_curr_round(g_rtia_m.rtiasite,g_rtia_m.rtia026,g_rtib_d[l_ac].rtib008,'1')
             END IF 
             LET g_rtib_d_o.* = g_rtib_d[l_ac].*   #160824-00007#172 Add By Ken 161107
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE rtib008
            #add-point:ON CHANGE rtib008 name="input.g.page1.rtib008"
                        
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtib009
            #add-point:BEFORE FIELD rtib009 name="input.b.page1.rtib009"
                        
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtib009
            
            #add-point:AFTER FIELD rtib009 name="input.a.page1.rtib009"
            IF NOT cl_null(g_rtib_d[l_ac].rtib009) THEN  
               IF g_rtib_d[l_ac].rtib009 < 0 THEN 
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'art-00394'
                  LET g_errparam.extend = ''
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  #LET g_rtib_d[l_ac].rtib009 = g_rtib_d_t.rtib009   #160824-00007#172 Mark By Ken 161107
                  LET g_rtib_d[l_ac].rtib009 = g_rtib_d_o.rtib009    #160824-00007#172 Add By Ken 161107
                  NEXT FIELD rtib009
               END IF 
               LET g_rtib_d[l_ac].rtib009 = s_curr_round(g_rtia_m.rtiasite,g_rtia_m.rtia026,g_rtib_d[l_ac].rtib009,'1')
            END IF 
            LET g_rtib_d_o.* = g_rtib_d[l_ac].*   #160824-00007#172 Add By Ken 161107
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE rtib009
            #add-point:ON CHANGE rtib009 name="input.g.page1.rtib009"
                        
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtib010
            #add-point:BEFORE FIELD rtib010 name="input.b.page1.rtib010"
                        
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtib010
            
            #add-point:AFTER FIELD rtib010 name="input.a.page1.rtib010"
            IF NOT cl_null(g_rtib_d[l_ac].rtib010) THEN 
               IF g_rtib_d[l_ac].rtib010 < 0 THEN 
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'art-00394'
                  LET g_errparam.extend = ''
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  #LET g_rtib_d[l_ac].rtib010 = g_rtib_d_t.rtib010   #160824-00007#172 Mark By Ken 161107
                  LET g_rtib_d[l_ac].rtib010 = g_rtib_d_o.rtib010    #160824-00007#172 Add By Ken 161107
                  NEXT FIELD rtib010
               END IF 
               CALL artt622_rtib021()
               LET g_rtib_d[l_ac].rtib010 = s_curr_round(g_rtia_m.rtiasite,g_rtia_m.rtia026,g_rtib_d[l_ac].rtib010,'1')
            END IF 
            #160604-00009#85--dongsz add--s
            IF g_prog = 'artt622' THEN
               LET g_rtib_d[l_ac].rtib008 = g_rtib_d[l_ac].rtib010
               LET g_rtib_d[l_ac].rtib009 = g_rtib_d[l_ac].rtib010
            END IF
            #160604-00009#85--dongsz add--e
            LET g_rtib_d_o.* = g_rtib_d[l_ac].*   #160824-00007#172 Add By Ken 161107
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE rtib010
            #add-point:ON CHANGE rtib010 name="input.g.page1.rtib010"
                        
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtib015
            #add-point:BEFORE FIELD rtib015 name="input.b.page1.rtib015"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtib015
            
            #add-point:AFTER FIELD rtib015 name="input.a.page1.rtib015"


            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE rtib015
            #add-point:ON CHANGE rtib015 name="input.g.page1.rtib015"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtib016
            #add-point:BEFORE FIELD rtib016 name="input.b.page1.rtib016"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtib016
            
            #add-point:AFTER FIELD rtib016 name="input.a.page1.rtib016"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE rtib016
            #add-point:ON CHANGE rtib016 name="input.g.page1.rtib016"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtib019
            #add-point:BEFORE FIELD rtib019 name="input.b.page1.rtib019"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtib019
            
            #add-point:AFTER FIELD rtib019 name="input.a.page1.rtib019"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE rtib019
            #add-point:ON CHANGE rtib019 name="input.g.page1.rtib019"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtib020
            #add-point:BEFORE FIELD rtib020 name="input.b.page1.rtib020"
                        
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtib020
            
            #add-point:AFTER FIELD rtib020 name="input.a.page1.rtib020"
            IF NOT cl_null(g_rtib_d[l_ac].rtib020) THEN 
               LET g_rtib_d[l_ac].rtib020 = s_curr_round(g_rtia_m.rtiasite,g_rtia_m.rtia026,g_rtib_d[l_ac].rtib020,'2')
            END IF 
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE rtib020
            #add-point:ON CHANGE rtib020 name="input.g.page1.rtib020"
                        
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtib021
            #add-point:BEFORE FIELD rtib021 name="input.b.page1.rtib021"
                        
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtib021
            
            #add-point:AFTER FIELD rtib021 name="input.a.page1.rtib021"
            IF NOT cl_null(g_rtib_d[l_ac].rtib021) THEN 
               LET g_rtib_d[l_ac].rtib021 = s_curr_round(g_rtia_m.rtiasite,g_rtia_m.rtia026,g_rtib_d[l_ac].rtib021,'2')
            END IF 
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE rtib021
            #add-point:ON CHANGE rtib021 name="input.g.page1.rtib021"
                        
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtib022
            #add-point:BEFORE FIELD rtib022 name="input.b.page1.rtib022"
                        
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtib022
            
            #add-point:AFTER FIELD rtib022 name="input.a.page1.rtib022"
                        
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE rtib022
            #add-point:ON CHANGE rtib022 name="input.g.page1.rtib022"
                        
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtib024
            
            #add-point:AFTER FIELD rtib024 name="input.a.page1.rtib024"
            IF NOT cl_null(g_rtib_d[l_ac].rtib024) THEN 
               CALL artt622_rtib024_chk()
               IF NOT cl_null(g_errno) THEN 
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = g_errno
                  LET g_errparam.extend = ''
                  #160318-00005#43 --s add
                  CASE g_errno
                     WHEN 'sub-01303'
                        LET g_errparam.replace[1] = 'axmi051'
                        LET g_errparam.replace[2] = cl_get_progname('axmi051',g_lang,"2")
                        LET g_errparam.exeprog = 'axmi051'
                  END CASE
                  #160318-00005#43 --e add
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  #LET g_rtib_d[l_ac].rtib024 = g_rtib_d_t.rtib024   #160824-00007#172 Mark By Ken 161107
                  LET g_rtib_d[l_ac].rtib024 = g_rtib_d_o.rtib024    #160824-00007#172 Add By Ken 161107
                  NEXT FIELD rtib024
               END IF 
               INITIALIZE g_ref_fields TO NULL
               LET g_ref_fields[1] = g_rtib_d[l_ac].rtib024
               CALL ap_ref_array2(g_ref_fields,"SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001='278' AND oocql002 = ? AND oocql003 ='"||g_dlang||"'","") RETURNING g_rtn_fields
               LET g_rtib_d[l_ac].rtib024_desc = '', g_rtn_fields[1] , ''
               DISPLAY BY NAME g_rtib_d[l_ac].rtib024_desc
            END IF 
            LET g_rtib_d_o.* = g_rtib_d[l_ac].*   #160824-00007#172 Add By Ken 161107
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtib024
            #add-point:BEFORE FIELD rtib024 name="input.b.page1.rtib024"
                        
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE rtib024
            #add-point:ON CHANGE rtib024 name="input.g.page1.rtib024"
                        
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtib025
            
            #add-point:AFTER FIELD rtib025 name="input.a.page1.rtib025"
            #150324-00007#5 2015/04/10 By sakura modify ---- S
            IF NOT cl_null(g_rtib_d[l_ac].rtib025) THEN 
               IF g_rtib_d[l_ac].rtib025 != g_rtib_d_o.rtib025 OR cl_null(g_rtib_d_o.rtib025) THEN            
                  CALL artt622_rtib025_chk()
                  IF NOT cl_null(g_errno) THEN 
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = g_errno
                     LET g_errparam.extend = ''
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                  
                     #LET g_rtib_d[l_ac].rtib025 = g_rtib_d_t.rtib025
                     LET g_rtib_d[l_ac].rtib025 = g_rtib_d_o.rtib025
                     LET g_rtib_d[l_ac].rtib026 = g_rtib_d_o.rtib026
                     LET g_rtib_d[l_ac].rtib027 = g_rtib_d_o.rtib027
                     LET g_rtib_d[l_ac].rtib032 = g_rtib_d_o.rtib032                     
                     NEXT FIELD rtib025
                  END IF
               END IF
            ELSE
               LET g_rtib_d[l_ac].rtib026 = ' '
            END IF
            LET g_rtib_d_o.rtib025 = g_rtib_d[l_ac].rtib025             
            LET g_rtib_d_o.rtib026 = g_rtib_d[l_ac].rtib026
            LET g_rtib_d_o.rtib027 = g_rtib_d[l_ac].rtib027
            LET g_rtib_d_o.rtib032 = g_rtib_d[l_ac].rtib032
            #150324-00007#5 2015/04/10 By sakura modify ---- E
            #add by yangxf ---start---
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_rtib_d[l_ac].rtib025
            CALL ap_ref_array2(g_ref_fields,"SELECT inayl003 FROM inayl_t WHERE inaylent='"||g_enterprise||"' AND inayl001 = ? AND inayl002 ='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_rtib_d[l_ac].rtib025_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_rtib_d[l_ac].rtib025_desc
            #add by yangxf -----end----
            LET g_rtib_d_o.* = g_rtib_d[l_ac].*   #160824-00007#172 Add By Ken 161107
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtib025
            #add-point:BEFORE FIELD rtib025 name="input.b.page1.rtib025"
                        
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE rtib025
            #add-point:ON CHANGE rtib025 name="input.g.page1.rtib025"
                        
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtib026
            #add-point:BEFORE FIELD rtib026 name="input.b.page1.rtib026"
 
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtib026
            
            #add-point:AFTER FIELD rtib026 name="input.a.page1.rtib026"
            IF NOT cl_null(g_rtib_d[l_ac].rtib026) THEN 
               CALL artt622_rtib026_chk()
               IF NOT cl_null(g_errno) THEN 
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = g_errno
                  LET g_errparam.extend = ''
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  #LET g_rtib_d[l_ac].rtib026 = g_rtib_d_t.rtib026   #160824-00007#172 Mark By Ken 161107
                  LET g_rtib_d[l_ac].rtib026 = g_rtib_d_o.rtib026    #160824-00007#172 Add By Ken 161107
                  NEXT FIELD rtib026
               END IF 
            END IF 
            LET g_rtib_d_o.* = g_rtib_d[l_ac].*   #160824-00007#172 Add By Ken 161107
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE rtib026
            #add-point:ON CHANGE rtib026 name="input.g.page1.rtib026"
                        
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtib027
            #add-point:BEFORE FIELD rtib027 name="input.b.page1.rtib027"
 
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtib027
            
            #add-point:AFTER FIELD rtib027 name="input.a.page1.rtib027"
            #150324-00007#7 150507 by sakura modify---STR
            #批號不做任何控卡
            #IF NOT cl_null(g_rtib_d[l_ac].rtib027) THEN 
            #   CALL artt622_rtib027_chk()
            #   IF NOT cl_null(g_errno) THEN 
            #      INITIALIZE g_errparam TO NULL
            #      LET g_errparam.code = g_errno
            #      LET g_errparam.extend = ''
            #      LET g_errparam.popup = TRUE
            #      CALL cl_err()
            #
            #      LET g_rtib_d[l_ac].rtib027 = g_rtib_d_t.rtib027
            #      NEXT FIELD rtib027
            #   END IF 
            #END IF 
            #150324-00007#7 150507 by sakura modify---END
            
            #150427-00001#8 150527 by lori522612 add---(S)
            IF NOT cl_null(g_rtib_d[l_ac].rtib027) THEN
               IF g_rtib_d[l_ac].rtib027 != g_rtib_d_o.rtib027 OR g_rtib_d_o.rtib027 IS NULL THEN
                  IF NOT cl_null(g_rtib_d[l_ac].rtib004) THEN
                     IF NOT s_lot_out_chk(g_rtia_m.rtiasite,g_rtia_m.rtiadocno,
                                          g_rtib_d[l_ac].rtib004,g_rtib_d[l_ac].rtib005,g_rtib_d[l_ac].rtib027) THEN
                        LET g_rtib_d[l_ac].rtib027 = g_rtib_d_o.rtib027 
                        NEXT FIELD CURRENT
                     END IF
                  END IF
               END IF
            END IF
            
            LET g_rtib_d_o.rtib027 = g_rtib_d[l_ac].rtib027
            #150427-00001#8 150527 by lori522612 add---(E)
            LET g_rtib_d_o.* = g_rtib_d[l_ac].*   #160824-00007#172 Add By Ken 161107
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE rtib027
            #add-point:ON CHANGE rtib027 name="input.g.page1.rtib027"
                        
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtib032
            #add-point:BEFORE FIELD rtib032 name="input.b.page1.rtib032"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtib032
            
            #add-point:AFTER FIELD rtib032 name="input.a.page1.rtib032"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE rtib032
            #add-point:ON CHANGE rtib032 name="input.g.page1.rtib032"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtib033
            
            #add-point:AFTER FIELD rtib033 name="input.a.page1.rtib033"
            IF NOT cl_null(g_rtib_d[l_ac].rtib033) THEN 
               CALL artt622_rtib033_chk()
               IF NOT cl_null(g_errno) THEN 
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = g_errno
                  LET g_errparam.extend = ''
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
                  #LET g_rtib_d[l_ac].rtib033 = g_rtib_d_t.rtib033   #160824-00007#172 Mark By Ken 161107
                  LET g_rtib_d[l_ac].rtib033 = g_rtib_d_o.rtib033    #160824-00007#172 Add By Ken 161107
                  NEXT FIELD rtib033
               END IF 
            END IF 
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_rtib_d[l_ac].rtib033
            CALL ap_ref_array2(g_ref_fields,"SELECT pcab003 FROM pcab_t WHERE pcabent='"||g_enterprise||"' AND pcab001=? ","") RETURNING g_rtn_fields
            LET g_rtib_d[l_ac].rtib033_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_rtib_d[l_ac].rtib033_desc
            LET g_rtib_d_o.* = g_rtib_d[l_ac].*   #160824-00007#172 Add By Ken 161107

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtib033
            #add-point:BEFORE FIELD rtib033 name="input.b.page1.rtib033"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE rtib033
            #add-point:ON CHANGE rtib033 name="input.g.page1.rtib033"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtib028
            #add-point:BEFORE FIELD rtib028 name="input.b.page1.rtib028"
            IF cl_null(g_rtib_d[l_ac].rtib025) THEN 
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = 'art-00280'
               LET g_errparam.extend = ''
               LET g_errparam.popup = TRUE
               CALL cl_err()

               NEXT FIELD rtib025
            END IF 
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtib028
            
            #add-point:AFTER FIELD rtib028 name="input.a.page1.rtib028"
            IF NOT cl_null(g_rtib_d[l_ac].rtib028) THEN 
               CALL artt622_rtib028_chk()
               IF NOT cl_null(g_errno) THEN 
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = g_errno
                  LET g_errparam.extend = ''
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  #LET g_rtib_d[l_ac].rtib028 = g_rtib_d_t.rtib028  #160824-00007#172 Mark By Ken 161107
                  LET g_rtib_d[l_ac].rtib028 = g_rtib_d_o.rtib028   #160824-00007#172 Add By Ken 161107
                  NEXT FIELD rtib028
               END IF 
            END IF 
            LET g_rtib_d_o.* = g_rtib_d[l_ac].*   #160824-00007#172 Add By Ken 161107
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE rtib028
            #add-point:ON CHANGE rtib028 name="input.g.page1.rtib028"
                        
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtib030
            #add-point:BEFORE FIELD rtib030 name="input.b.page1.rtib030"
                        
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtib030
            
            #add-point:AFTER FIELD rtib030 name="input.a.page1.rtib030"
                        
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE rtib030
            #add-point:ON CHANGE rtib030 name="input.g.page1.rtib030"
                        
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtib039
            #add-point:BEFORE FIELD rtib039 name="input.b.page1.rtib039"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtib039
            
            #add-point:AFTER FIELD rtib039 name="input.a.page1.rtib039"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE rtib039
            #add-point:ON CHANGE rtib039 name="input.g.page1.rtib039"
            
            #END add-point 
 
 
 
                  #Ctrlp:input.c.page1.rtibsite
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtibsite
            #add-point:ON ACTION controlp INFIELD rtibsite name="input.c.page1.rtibsite"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.rtibunit
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtibunit
            #add-point:ON ACTION controlp INFIELD rtibunit name="input.c.page1.rtibunit"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.rtiborga
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtiborga
            #add-point:ON ACTION controlp INFIELD rtiborga name="input.c.page1.rtiborga"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.rtibseq
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtibseq
            #add-point:ON ACTION controlp INFIELD rtibseq name="input.c.page1.rtibseq"
                        
            #END add-point
 
 
         #Ctrlp:input.c.page1.rtib035
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtib035
            #add-point:ON ACTION controlp INFIELD rtib035 name="input.c.page1.rtib035"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.rtib042
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtib042
            #add-point:ON ACTION controlp INFIELD rtib042 name="input.c.page1.rtib042"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.rtib001
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtib001
            #add-point:ON ACTION controlp INFIELD rtib001 name="input.c.page1.rtib001"
                                    ### 訂購單查詢### start ###
#            INITIALIZE g_qryparam.* TO NULL 
#            LET g_qryparam.state = "i"
#            LET g_qryparam.reqry = FALSE
#            LET g_qryparam.default1 = ""
#            LET g_qryparam.where = " xmdastus = 'Y' "
#            CALL q_xmdadocno()
#            LET g_rtib_d[l_ac].rtib001 = g_qryparam.return1
#            DISPLAY g_rtib_d[l_ac].rtib001 TO rtib001
            ### 訂購單查詢### end ###
            #150424-00020#2--add by dongsz--str---
            INITIALIZE g_qryparam.* TO NULL 
            LET g_qryparam.state = "i"
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = ""
            IF g_prog = 'artt622' THEN    #add by yangxf 
               LET g_qryparam.where = " rtilsite = '",g_rtia_m.rtiasite,"' AND rtilstus = 'Y' "
               CALL q_rtildocno()
            #add by yangxf ---start----
            ELSE
               IF g_prog = 'artt610' OR g_prog = 'artt620' THEN           #add by yangxf  g_prog = 'artt620'  
                  LET g_qryparam.where = " rtiastus = 'S' AND rtiasite = '",g_rtia_m.rtiasite,"' AND rtia000 = '",g_prog,"'"
               ELSE
                  LET g_qryparam.where = " rtiastus = 'S' AND rtiasite = '",g_rtia_m.rtiasite,"' AND rtia000 <> '",g_prog,"'"
               END IF 
               CALL q_rtiadocno()
            END IF 
            #add by yangxf ---end----
            LET g_rtib_d[l_ac].rtib001 = g_qryparam.return1
            DISPLAY g_rtib_d[l_ac].rtib001 TO rtib001
            #150424-00020#2--add by dongsz--end---
            #END add-point
 
 
         #Ctrlp:input.c.page1.rtib002
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtib002
            #add-point:ON ACTION controlp INFIELD rtib002 name="input.c.page1.rtib002"
                        
            #END add-point
 
 
         #Ctrlp:input.c.page1.rtib003
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtib003
            #add-point:ON ACTION controlp INFIELD rtib003 name="input.c.page1.rtib003"
                        ### 商品條碼### start ###
            INITIALIZE g_qryparam.* TO NULL 
            LET g_qryparam.state = "i"
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.arg1 = g_rtia_m.rtiasite
            LET g_qryparam.where = "1=1"
            CALL q_imay003_8()
            LET g_rtib_d[l_ac].rtib003 = g_qryparam.return1
            CALL artt622_rtib003_display()
            DISPLAY g_rtib_d[l_ac].rtib003 TO rtib003
            ### 商品條碼### end ###

            #END add-point
 
 
         #Ctrlp:input.c.page1.rtib004
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtib004
            #add-point:ON ACTION controlp INFIELD rtib004 name="input.c.page1.rtib004"
                                    ### 商品編號### start ###
            INITIALIZE g_qryparam.* TO NULL 
            LET g_qryparam.state = "i"
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_rtib_d[l_ac].rtib004
            LET g_qryparam.where = "1=1"
            LET g_qryparam.arg1 = g_rtia_m.rtiasite
            CALL q_rtdx001_1()
            LET g_rtib_d[l_ac].rtib004 = g_qryparam.return1
            DISPLAY g_rtib_d[l_ac].rtib004 TO rtib004
           ### 商品編號### end ###
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_rtib_d[l_ac].rtib004
            CALL ap_ref_array2(g_ref_fields,"SELECT imaal003,imaal004 FROM imaal_t WHERE imaalent='"||g_enterprise||"' AND imaal001=? AND imaal002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_rtib_d[l_ac].rtib004_desc = '', g_rtn_fields[1] , ''
            LET g_rtib_d[l_ac].rtib004_desc_desc = '', g_rtn_fields[2] , ''
            DISPLAY BY NAME g_rtib_d[l_ac].rtib004_desc,g_rtib_d[l_ac].rtib004_desc_desc
            #END add-point
 
 
         #Ctrlp:input.c.page1.rtib005
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtib005
            #add-point:ON ACTION controlp INFIELD rtib005 name="input.c.page1.rtib005"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.rtib106
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtib106
            #add-point:ON ACTION controlp INFIELD rtib106 name="input.c.page1.rtib106"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.rtib012
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtib012
            #add-point:ON ACTION controlp INFIELD rtib012 name="input.c.page1.rtib012"
                        
            #END add-point
 
 
         #Ctrlp:input.c.page1.rtib108
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtib108
            #add-point:ON ACTION controlp INFIELD rtib108 name="input.c.page1.rtib108"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.rtib013
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtib013
            #add-point:ON ACTION controlp INFIELD rtib013 name="input.c.page1.rtib013"
                        
            #END add-point
 
 
         #Ctrlp:input.c.page1.rtib107
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtib107
            #add-point:ON ACTION controlp INFIELD rtib107 name="input.c.page1.rtib107"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.rtib008
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtib008
            #add-point:ON ACTION controlp INFIELD rtib008 name="input.c.page1.rtib008"
                        
            #END add-point
 
 
         #Ctrlp:input.c.page1.rtib009
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtib009
            #add-point:ON ACTION controlp INFIELD rtib009 name="input.c.page1.rtib009"
                        
            #END add-point
 
 
         #Ctrlp:input.c.page1.rtib010
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtib010
            #add-point:ON ACTION controlp INFIELD rtib010 name="input.c.page1.rtib010"
                        
            #END add-point
 
 
         #Ctrlp:input.c.page1.rtib015
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtib015
            #add-point:ON ACTION controlp INFIELD rtib015 name="input.c.page1.rtib015"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.rtib016
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtib016
            #add-point:ON ACTION controlp INFIELD rtib016 name="input.c.page1.rtib016"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.rtib019
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtib019
            #add-point:ON ACTION controlp INFIELD rtib019 name="input.c.page1.rtib019"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.rtib020
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtib020
            #add-point:ON ACTION controlp INFIELD rtib020 name="input.c.page1.rtib020"
                        
            #END add-point
 
 
         #Ctrlp:input.c.page1.rtib021
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtib021
            #add-point:ON ACTION controlp INFIELD rtib021 name="input.c.page1.rtib021"
                        
            #END add-point
 
 
         #Ctrlp:input.c.page1.rtib022
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtib022
            #add-point:ON ACTION controlp INFIELD rtib022 name="input.c.page1.rtib022"
                        
            #END add-point
 
 
         #Ctrlp:input.c.page1.rtib024
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtib024
            #add-point:ON ACTION controlp INFIELD rtib024 name="input.c.page1.rtib024"
                                    ### 應用分類碼開窗### start ###
            INITIALIZE g_qryparam.* TO NULL 
            LET g_qryparam.state = "i"
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = ""
            LET g_qryparam.where = "1=1"
            LET g_qryparam.arg1 = "278"
            CALL q_oocq002()
            LET g_rtib_d[l_ac].rtib024 = g_qryparam.return1
            DISPLAY g_rtib_d[l_ac].rtib024 TO rtib024
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_rtib_d[l_ac].rtib024
            CALL ap_ref_array2(g_ref_fields,"SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001='278' AND oocql002 = ? AND oocql003 ='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_rtib_d[l_ac].rtib024_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_rtib_d[l_ac].rtib024_desc
            ### 應用分類碼開窗### end ###

            #END add-point
 
 
         #Ctrlp:input.c.page1.rtib025
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtib025
            #add-point:ON ACTION controlp INFIELD rtib025 name="input.c.page1.rtib025"
            #150324-00007#5 2015/04/10 By sakura modify ---- S
            #### 庫位編號### start ###
            #INITIALIZE g_qryparam.* TO NULL 
            #LET g_qryparam.state = "i"
            #LET g_qryparam.reqry = FALSE
            #LET g_qryparam.default1 = ""
            #LET g_qryparam.where = " inagsite = '",g_rtia_m.rtiasite,"'"
            #IF NOT cl_null(g_rtib_d[l_ac].rtib004) THEN 
            #   LET g_qryparam.where = g_qryparam.where," AND inag001 = '",g_rtib_d[l_ac].rtib004,"'"
            #END IF
            #CALL q_inag005_4()
            #LET g_rtib_d[l_ac].rtib025 = g_qryparam.return1
            #LET g_rtib_d[l_ac].rtib026 = g_qryparam.return2
            #LET g_rtib_d[l_ac].rtib027 = g_qryparam.return3
            #DISPLAY g_rtib_d[l_ac].rtib025 TO rtib025
            #DISPLAY g_rtib_d[l_ac].rtib026 TO rtib026
            #DISPLAY g_rtib_d[l_ac].rtib027 TO rtib027
            #### 庫位編號### end ###
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_rtib_d[l_ac].rtib025
            LET g_qryparam.default2 = g_rtib_d[l_ac].rtib026
            LET g_qryparam.default3 = g_rtib_d[l_ac].rtib027
            LET g_qryparam.default4 = g_rtib_d[l_ac].rtib032
            LET g_qryparam.arg1 = g_rtia_m.rtiasite       #組織
            LET g_qryparam.arg2 = g_rtib_d[l_ac].rtib004  #商品編號
            #產品特徵
            IF cl_null(g_rtib_d[l_ac].rtib005) THEN
               LET g_rtib_d[l_ac].rtib005 = ' '
            END IF
            LET g_qryparam.arg3 = g_rtib_d[l_ac].rtib005
            #庫存管理特徵
            IF cl_null(g_rtib_d[l_ac].rtib032) THEN
               LET g_qryparam.arg4 = ''
            ELSE
               LET g_qryparam.arg4 = g_rtib_d[l_ac].rtib032
            END IF
            #庫位/庫區
            LET g_qryparam.arg5 = ''                        
			   #儲位
            IF cl_null(g_rtib_d[l_ac].rtib026) THEN
               LET g_qryparam.arg6 = ''
            ELSE
               LET g_qryparam.arg6 = g_rtib_d[l_ac].rtib026
            END IF
            #批號
            IF cl_null(g_rtib_d[l_ac].rtib027) THEN
               LET g_qryparam.arg7 = ''
            ELSE
               LET g_qryparam.arg7 = g_rtib_d[l_ac].rtib027
            END IF
            CALL q_inag004_18()
            LET g_rtib_d[l_ac].rtib025 = g_qryparam.return1   #庫位/庫區
            LET g_rtib_d[l_ac].rtib026 = g_qryparam.return2   #儲位
            LET g_rtib_d[l_ac].rtib027 = g_qryparam.return3   #批號
            LET g_rtib_d[l_ac].rtib032 = g_qryparam.return4   #庫存管理特徵
            DISPLAY g_rtib_d[l_ac].rtib025 TO rtib025
            DISPLAY g_rtib_d[l_ac].rtib026 TO rtib026
            DISPLAY g_rtib_d[l_ac].rtib027 TO rtib027
            DISPLAY g_rtib_d[l_ac].rtib032 TO rtib032
            #add by yangxf ---start---
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_rtib_d[l_ac].rtib025
            CALL ap_ref_array2(g_ref_fields,"SELECT inayl003 FROM inayl_t WHERE inaylent='"||g_enterprise||"' AND inayl001 = ? AND inayl002 ='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_rtib_d[l_ac].rtib025_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_rtib_d[l_ac].rtib025_desc
            #add by yangxf -----end----
			   NEXT FIELD rtib025
            #150324-00007#5 2015/04/10 By sakura modify ---- E            
            #END add-point
 
 
         #Ctrlp:input.c.page1.rtib026
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtib026
            #add-point:ON ACTION controlp INFIELD rtib026 name="input.c.page1.rtib026"
            #150324-00007#5 2015/04/10 By sakura modify ---- E
            #INITIALIZE g_qryparam.* TO NULL 
            #LET g_qryparam.state = "i"
            #LET g_qryparam.reqry = FALSE
            #LET g_qryparam.default1 = ""
            #LET g_qryparam.where = " inagsite = '",g_rtia_m.rtiasite,"'"
            #IF NOT cl_null(g_rtib_d[l_ac].rtib025) THEN 
            #   LET g_qryparam.where = " inag004 = '",g_rtib_d[l_ac].rtib025,"'"
            #END IF 
            #IF NOT cl_null(g_rtib_d[l_ac].rtib004) THEN 
            #   LET g_qryparam.where = g_qryparam.where," AND inag001 = '",g_rtib_d[l_ac].rtib004,"'"
            #END IF
            #CALL q_inag005_3()
            #LET g_rtib_d[l_ac].rtib026 = g_qryparam.return1
            #DISPLAY g_rtib_d[l_ac].rtib026 TO rtib026
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_rtib_d[l_ac].rtib025
            LET g_qryparam.default2 = g_rtib_d[l_ac].rtib026
            LET g_qryparam.default3 = g_rtib_d[l_ac].rtib027
            LET g_qryparam.default4 = g_rtib_d[l_ac].rtib032
            LET g_qryparam.arg1 = g_rtia_m.rtiasite       #組織
            LET g_qryparam.arg2 = g_rtib_d[l_ac].rtib004  #商品編號
            #產品特徵
            IF cl_null(g_rtib_d[l_ac].rtib005) THEN
               LET g_rtib_d[l_ac].rtib005 = ' '
            END IF
            LET g_qryparam.arg3 = g_rtib_d[l_ac].rtib005
            #庫存管理特徵
            IF cl_null(g_rtib_d[l_ac].rtib032) THEN
               LET g_qryparam.arg4 = ''
            ELSE
               LET g_qryparam.arg4 = g_rtib_d[l_ac].rtib032
            END IF
            #庫位/庫區
            LET g_qryparam.arg5 = g_rtib_d[l_ac].rtib025                        
			   #儲位
            LET g_qryparam.arg6 = ''
            #批號
            IF cl_null(g_rtib_d[l_ac].rtib027) THEN
               LET g_qryparam.arg7 = ''
            ELSE
               LET g_qryparam.arg7 = g_rtib_d[l_ac].rtib027
            END IF
            CALL q_inag004_18()
            LET g_rtib_d[l_ac].rtib025 = g_qryparam.return1   #庫位/庫區
            LET g_rtib_d[l_ac].rtib026 = g_qryparam.return2   #儲位
            LET g_rtib_d[l_ac].rtib027 = g_qryparam.return3   #批號
            LET g_rtib_d[l_ac].rtib032 = g_qryparam.return4   #庫存管理特徵
            DISPLAY g_rtib_d[l_ac].rtib025 TO rtib025
            DISPLAY g_rtib_d[l_ac].rtib026 TO rtib026
            DISPLAY g_rtib_d[l_ac].rtib027 TO rtib027
            DISPLAY g_rtib_d[l_ac].rtib032 TO rtib032
			   NEXT FIELD rtib026
            #150324-00007#5 2015/04/10 By sakura modify ---- E            
            #END add-point
 
 
         #Ctrlp:input.c.page1.rtib027
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtib027
            #add-point:ON ACTION controlp INFIELD rtib027 name="input.c.page1.rtib027"
            #150324-00007#7 150507 by sakura modify---STR
            #INITIALIZE g_qryparam.* TO NULL 
            #LET g_qryparam.state = "i"
            #LET g_qryparam.reqry = FALSE
            #LET g_qryparam.default1 = ""
            #LET g_qryparam.where = "1=1"
            #IF NOT cl_null(g_rtib_d[l_ac].rtib025) THEN
            #   LET g_qryparam.where = g_qryparam.where," AND inag004 = '",g_rtib_d[l_ac].rtib025,"'"
            #END IF 
            #IF NOT cl_null(g_rtib_d[l_ac].rtib026) THEN
            #   LET g_qryparam.where = g_qryparam.where," AND inag005 = '",g_rtib_d[l_ac].rtib026,"'"
            #END IF 
            #CALL q_inag006()
            #LET g_rtib_d[l_ac].rtib027 = g_qryparam.return1
            #DISPLAY g_rtib_d[l_ac].rtib027 TO rtib027
            #150324-00007#7 150507 by sakura modify---END
            #END add-point
 
 
         #Ctrlp:input.c.page1.rtib032
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtib032
            #add-point:ON ACTION controlp INFIELD rtib032 name="input.c.page1.rtib032"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.rtib033
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtib033
            #add-point:ON ACTION controlp INFIELD rtib033 name="input.c.page1.rtib033"
            #應用 a07 樣板自動產生(Version:2)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_rtib_d[l_ac].rtib033             #給予default值
            LET g_qryparam.default2 = "" #g_rtib_d[l_ac].pcab001 #收銀人員編號
            #給予arg
            LET g_qryparam.arg1 = g_rtia_m.rtiasite
            LET g_qryparam.where = "pcab006 = '2' "

            CALL q_pcab001_2()                                #呼叫開窗

            LET g_rtib_d[l_ac].rtib033 = g_qryparam.return1              
            #LET g_rtib_d[l_ac].pcab001 = g_qryparam.return2 
            DISPLAY g_rtib_d[l_ac].rtib033 TO rtib033              #
            #DISPLAY g_rtib_d[l_ac].pcab001 TO pcab001 #收銀人員編號
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_rtib_d[l_ac].rtib033
            CALL ap_ref_array2(g_ref_fields,"SELECT pcab003 FROM pcab_t WHERE pcabent='"||g_enterprise||"' AND pcab001=? ","") RETURNING g_rtn_fields
            LET g_rtib_d[l_ac].rtib033_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_rtib_d[l_ac].rtib033_desc
            NEXT FIELD rtib033                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.page1.rtib028
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtib028
            #add-point:ON ACTION controlp INFIELD rtib028 name="input.c.page1.rtib028"
            ### 專櫃編號### start ###
            INITIALIZE g_qryparam.* TO NULL 
            LET g_qryparam.state = "i"
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = ""
            IF NOT cl_null(g_rtib_d[l_ac].rtib025) THEN 
               LET g_qryparam.where = "1=1 AND inaasite = '",g_rtia_m.rtiasite,"' AND inaa001 = '",g_rtib_d[l_ac].rtib025,"'"
            END IF 
            CALL q_inaa120()
            LET g_rtib_d[l_ac].rtib028 = g_qryparam.return1
            DISPLAY g_rtib_d[l_ac].rtib028 TO rtib028
            ### 專櫃編號### end ###
  
            #END add-point
 
 
         #Ctrlp:input.c.page1.rtib030
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtib030
            #add-point:ON ACTION controlp INFIELD rtib030 name="input.c.page1.rtib030"
                        
            #END add-point
 
 
         #Ctrlp:input.c.page1.rtib039
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtib039
            #add-point:ON ACTION controlp INFIELD rtib039 name="input.c.page1.rtib039"
            
            #END add-point
 
 
 
 
         ON ROW CHANGE
            IF INT_FLAG THEN
               LET INT_FLAG = 0
               LET g_rtib_d[l_ac].* = g_rtib_d_t.*
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code = 9001 
               LET g_errparam.popup = FALSE 
               CLOSE artt622_bcl
               CALL s_transaction_end('N','0')
               CALL cl_err()
               EXIT DIALOG 
            END IF
              
            IF l_lock_sw = 'Y' THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = g_rtib_d[l_ac].rtibseq 
               LET g_errparam.code = -263 
               LET g_errparam.popup = TRUE 
               CALL cl_err()
               LET g_rtib_d[l_ac].* = g_rtib_d_t.*
            ELSE
            
               #add-point:單身修改前 name="input.body.b_update"
               #add by yangxf ----start----
               IF g_prog = 'artt700' THEN 
                  LET g_rtib_d[l_ac].rtib012 = g_rtib_d[l_ac].rtib012*(-1)
                  LET g_rtib_d[l_ac].rtib017 = g_rtib_d[l_ac].rtib017*(-1)
                  LET g_rtib_d[l_ac].rtib020 = g_rtib_d[l_ac].rtib020*(-1)
                  LET g_rtib_d[l_ac].rtib021 = g_rtib_d[l_ac].rtib021*(-1)
                  LET g_rtib_d[l_ac].rtib022 = g_rtib_d[l_ac].rtib022*(-1)
                  LET g_rtib_d[l_ac].rtib031 = g_rtib_d[l_ac].rtib031*(-1)
               #150819-00004#1 150819 By pomelo add(S)
               ELSE
                  #當數量為正數表示入項
                  IF cl_null(g_rtib_d_t.rtib027) AND g_rtib_d[l_ac].rtib012 < 0 THEN
                     LET l_success = ''
                     CALL s_lot_out_get_batch_no(g_rtib_d[l_ac].rtib004)
                        RETURNING l_success,g_rtib_d[l_ac].rtib027
                     IF l_success = FALSE THEN
                        CALL s_transaction_end('N','0')
                        EXIT DIALOG
                     END IF
                  END IF
               #150819-00004#1 150819 By pomelo add(E)
               END IF 
               #add by yangxf -----end-----
               
               
               #更新多库儲批明細
               CALL s_artt622_rtin_modify('u',g_rtib_d[l_ac].rtibsite,g_rtia_m.rtiadocno,g_rtib_d[l_ac].rtibseq,g_rtib_d_t.rtibseq,g_rtib_d[l_ac].rtib004,g_rtib_d[l_ac].rtib005,
                                             g_prog,'',g_rtib_d[l_ac].rtib025,g_rtib_d[l_ac].rtib026,g_rtib_d[l_ac].rtib027,g_rtib_d[l_ac].rtib013,g_rtib_d[l_ac].rtib012,g_rtib_d[l_ac].rtib032) RETURNING l_success
               IF NOT l_success THEN
                  CALL s_transaction_end('N','0')                    
                  EXIT DIALOG 
               END IF
               #end add-point
               
               #寫入修改者/修改日期資訊(單身)
               
      
               #將遮罩欄位還原
               CALL artt622_rtib_t_mask_restore('restore_mask_o')
      
               UPDATE rtib_t SET (rtibdocno,rtibsite,rtibunit,rtiborga,rtibseq,rtib035,rtib042,rtib001, 
                   rtib002,rtib003,rtib004,rtib005,rtib106,rtib012,rtib108,rtib013,rtib107,rtib008,rtib009, 
                   rtib010,rtib014,rtib015,rtib016,rtib018,rtib017,rtib019,rtib020,rtib021,rtib031,rtib022, 
                   rtib024,rtib025,rtib026,rtib027,rtib032,rtib033,rtib028,rtib030,rtib039,rtib006) = (g_rtia_m.rtiadocno, 
                   g_rtib_d[l_ac].rtibsite,g_rtib_d[l_ac].rtibunit,g_rtib_d[l_ac].rtiborga,g_rtib_d[l_ac].rtibseq, 
                   g_rtib_d[l_ac].rtib035,g_rtib_d[l_ac].rtib042,g_rtib_d[l_ac].rtib001,g_rtib_d[l_ac].rtib002, 
                   g_rtib_d[l_ac].rtib003,g_rtib_d[l_ac].rtib004,g_rtib_d[l_ac].rtib005,g_rtib_d[l_ac].rtib106, 
                   g_rtib_d[l_ac].rtib012,g_rtib_d[l_ac].rtib108,g_rtib_d[l_ac].rtib013,g_rtib_d[l_ac].rtib107, 
                   g_rtib_d[l_ac].rtib008,g_rtib_d[l_ac].rtib009,g_rtib_d[l_ac].rtib010,g_rtib_d[l_ac].rtib014, 
                   g_rtib_d[l_ac].rtib015,g_rtib_d[l_ac].rtib016,g_rtib_d[l_ac].rtib018,g_rtib_d[l_ac].rtib017, 
                   g_rtib_d[l_ac].rtib019,g_rtib_d[l_ac].rtib020,g_rtib_d[l_ac].rtib021,g_rtib_d[l_ac].rtib031, 
                   g_rtib_d[l_ac].rtib022,g_rtib_d[l_ac].rtib024,g_rtib_d[l_ac].rtib025,g_rtib_d[l_ac].rtib026, 
                   g_rtib_d[l_ac].rtib027,g_rtib_d[l_ac].rtib032,g_rtib_d[l_ac].rtib033,g_rtib_d[l_ac].rtib028, 
                   g_rtib_d[l_ac].rtib030,g_rtib_d[l_ac].rtib039,g_rtib_d[l_ac].rtib006)
                WHERE rtibent = g_enterprise AND rtibdocno = g_rtia_m.rtiadocno 
 
                  AND rtibseq = g_rtib_d_t.rtibseq #項次   
 
                  
               #add-point:單身修改中 name="input.body.m_update"
 
               #end add-point
               CASE
                  WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
                     LET g_rtib_d[l_ac].* = g_rtib_d_t.*
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "rtib_t" 
                     LET g_errparam.code = "std-00009" 
                     LET g_errparam.popup = TRUE 
                     CALL s_transaction_end('N','0')
                     CALL cl_err()
                     
                  WHEN SQLCA.SQLCODE #其他錯誤
                     LET g_rtib_d[l_ac].* = g_rtib_d_t.*  
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "rtib_t:",SQLERRMESSAGE 
                     LET g_errparam.code = SQLCA.SQLCODE 
                     LET g_errparam.popup = TRUE 
                     CALL s_transaction_end('N','0')
                     CALL cl_err()                   
                     
                  OTHERWISE
                     #資料多語言用-增/改
                     
                                    INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_rtia_m.rtiadocno
               LET gs_keys_bak[1] = g_rtiadocno_t
               LET gs_keys[2] = g_rtib_d[g_detail_idx].rtibseq
               LET gs_keys_bak[2] = g_rtib_d_t.rtibseq
               CALL artt622_update_b('rtib_t',gs_keys,gs_keys_bak,"'1'")
               END CASE
 
               #將遮罩欄位進行遮蔽
               CALL artt622_rtib_t_mask_restore('restore_mask_n')
               
               #判斷key是否有改變
               INITIALIZE gs_keys TO NULL
               IF NOT(g_rtib_d[g_detail_idx].rtibseq = g_rtib_d_t.rtibseq 
 
                  ) THEN
                  LET gs_keys[01] = g_rtia_m.rtiadocno
 
                  LET gs_keys[gs_keys.getLength()+1] = g_rtib_d_t.rtibseq
 
                  CALL artt622_key_update_b(gs_keys,'rtib_t')
               END IF
               
               #修改歷程記錄(單身修改)
               LET g_log1 = util.JSON.stringify(g_rtia_m),util.JSON.stringify(g_rtib_d_t)
               LET g_log2 = util.JSON.stringify(g_rtia_m),util.JSON.stringify(g_rtib_d[l_ac])
               IF NOT cl_log_modified_record_d(g_log1,g_log2) THEN 
                  CALL s_transaction_end('N','0')
               END IF
               
               #add-point:單身修改後 name="input.body.a_update"
                              #單號      項次       項次2   營運據點           應收金額
               CALL s_tax_ins(g_rtia_m.rtiadocno,g_rtib_d[l_ac].rtibseq,'0',   g_rtia_m.rtiasite,g_rtib_d[l_ac].rtib021,
                              #稅別                   计价數量                   幣別             匯率             帳套 匯率2 匯率3
                              g_rtib_d[l_ac].rtib006,g_rtib_d[l_ac].rtib017,g_rtia_m.rtia026,g_rtia_m.rtia027,' ',' ',  ' ')
                         #原幣未稅金額 原幣稅額   原幣含稅金額 本幣未稅金額(AR/AP使用) 本幣稅額(AR/AP使用) 本幣含稅金額(AR/AP使用)
               RETURNING l_xrcd103,    l_xrcd104, l_xrcd105,   l_xrcd113,              l_xrcd114,          l_xrcd115,
                         l_xrcd123,l_xrcd124,l_xrcd125,l_xrcd133,l_xrcd134,l_xrcd135
               IF g_rtib_d[l_ac].rtib004 != g_rtib_d_t.rtib004 
               OR g_rtib_d[l_ac].rtib010 != g_rtib_d_t.rtib010 
               OR g_rtib_d[l_ac].rtib012 != g_rtib_d_t.rtib012 THEN 
                  LET l_xrcd103 = s_curr_round(g_rtia_m.rtiasite,g_rtia_m.rtia026,l_xrcd103,'2')
                  UPDATE rtib_t SET rtib022 = l_xrcd103
                   WHERE rtibent = g_enterprise
                     AND rtibdocno = g_rtia_m.rtiadocno
                     AND rtibseq = g_rtib_d[l_ac].rtibseq
                  CASE
                     WHEN SQLCA.sqlcode #其他錯誤
                        INITIALIZE g_errparam TO NULL
                        LET g_errparam.code = SQLCA.sqlcode
                        LET g_errparam.extend = "rtib_t"
                        LET g_errparam.popup = TRUE
                        CALL cl_err()
  
                        CALL s_transaction_end('N','0')
                     OTHERWISE
                  END CASE
               END IF 
               #add by yangxf 20151127 ---start---
               IF g_prog = 'artt620' THEN   
                  #标准价 
                  LET l_rtib021 = g_rtib_d[l_ac].rtib017 * g_rtib_d[l_ac].rtib008
                  #先删除对应折价明细
                  DELETE FROM rtic_t
                   WHERE rticent = g_enterprise
                     AND rticdocno = g_rtia_m.rtiadocno
                     AND rticseq = g_rtib_d[l_ac].rtibseq
                  IF l_rtib021 != g_rtib_d[l_ac].rtib021 THEN 
                     #寫折價
                     IF NOT artt622_ins_rtic2(g_rtib_d[l_ac].rtibseq,g_rtib_d[l_ac].rtib021,l_rtib021,g_rtib_d[l_ac].rtib017) THEN
                        CALL s_transaction_end('N','0')
                     END IF
                     #更新折扣金额                  
                     UPDATE rtib_t SET rtib020 = l_rtib021 - g_rtib_d[l_ac].rtib021
                      WHERE rtibent = g_enterprise
                        AND rtibdocno = g_rtia_m.rtiadocno
                        AND rtibseq = g_rtib_d[l_ac].rtibseq
                     IF SQLCA.SQLcode  THEN
                        INITIALIZE g_errparam TO NULL 
                        LET g_errparam.extend = "rtib_t" 
                        LET g_errparam.code   = SQLCA.sqlcode 
                        LET g_errparam.popup  = TRUE 
                        CALL cl_err()
                        CALL s_transaction_end('N','0')              
                     END IF 
                  END IF 
               END IF 
               #add by yangxf 20151127----end-----
               #add by yangxf ----start----
               IF g_prog = 'artt700' THEN 
                  LET g_rtib_d[l_ac].rtib012 = g_rtib_d[l_ac].rtib012*(-1)
                  LET g_rtib_d[l_ac].rtib017 = g_rtib_d[l_ac].rtib017*(-1)
                  LET g_rtib_d[l_ac].rtib020 = g_rtib_d[l_ac].rtib020*(-1)
                  LET g_rtib_d[l_ac].rtib021 = g_rtib_d[l_ac].rtib021*(-1)
                  LET g_rtib_d[l_ac].rtib022 = g_rtib_d[l_ac].rtib022*(-1)
                  LET g_rtib_d[l_ac].rtib031 = g_rtib_d[l_ac].rtib031*(-1)
               END IF 
               #add by yangxf -----end-----
               #end add-point
 
            END IF
            
         AFTER ROW
            #add-point:單身after_row name="input.body.after_row"
            #更新单头含税金额
            UPDATE rtia_t SET rtia031 = (SELECT SUM(rtib021)
                                           FROM rtib_t
                                          WHERE rtibent = g_enterprise
                                            AND rtibdocno = g_rtia_m.rtiadocno),
                              rtia049 = (SELECT SUM(rtib031)
                                           FROM rtib_t
                                          WHERE rtibent = g_enterprise
                                            AND rtibdocno = g_rtia_m.rtiadocno),
                              rtia047 = (SELECT SUM(rtib108)
                                           FROM rtib_t
                                          WHERE rtibent = g_enterprise
                                            AND rtibdocno = g_rtia_m.rtiadocno)
             WHERE rtiaent = g_enterprise
               AND rtiadocno = g_rtia_m.rtiadocno
            SELECT rtia047,rtia043 - rtia047 INTO  g_rtia_m.rtia047,g_rtia_m.l_rtia047
              FROM rtia_t
             WHERE rtiaent = g_enterprise
               AND rtiadocno = g_rtia_m.rtiadocno   
            DISPLAY BY NAME g_rtia_m.rtia047,g_rtia_m.l_rtia047
            SELECT SUM(rtib012),SUM(rtib008*rtib017),SUM(rtib020),SUM(rtib021)
                  INTO g_rtia_m.snum,g_rtia_m.amount,g_rtia_m.amount2,g_rtia_m.amount3
                  FROM rtib_t
                  WHERE rtibent = g_enterprise
                  AND rtibdocno = g_rtia_m.rtiadocno
                  DISPLAY g_rtia_m.snum TO FORMONLY.snum  
                  DISPLAY g_rtia_m.amount TO FORMONLY.amount
                  DISPLAY g_rtia_m.amount2 TO FORMONLY.amount2
                  DISPLAY g_rtia_m.amount3 TO FORMONLY.amount3            
            #end add-point
            CALL artt622_unlock_b("rtib_t","'1'")
            CALL s_transaction_end('Y','0')
            #其他table進行unlock
            #add-point:單身after_row2 name="input.body.after_row2"
            
            #end add-point
              
         AFTER INPUT
            #add-point:input段after input  name="input.body.after_input"

#           #add by yangxf 20151127 ---start---
#            IF g_prog != 'artt620' THEN 
#               CALL s_get_price('2',g_rtia_m.rtiadocno,g_rtia_m.rtiadocdt,'',g_rtia_m.rtia002,g_rtia_m.rtia001,'','','','','2')
#                  RETURNING l_success,l_price,l_price1,l_price2,l_price3
#            END IF 
#            #add by yangxf 20151127----end-----
            CALL artt622_set_rtic()
            #add by yangxf ---start----
            UPDATE rtia_t SET rtia031 = (SELECT SUM(rtib021)
                                           FROM rtib_t
                                          WHERE rtibent = g_enterprise
                                            AND rtibdocno = g_rtia_m.rtiadocno),
                              rtia049 = (SELECT SUM(rtib031)
                                           FROM rtib_t
                                          WHERE rtibent = g_enterprise
                                            AND rtibdocno = g_rtia_m.rtiadocno)
             WHERE rtiaent = g_enterprise
               AND rtiadocno = g_rtia_m.rtiadocno
            #add by yangxf ---end----
            #end add-point 
    
         ON ACTION controlo    
            IF l_insert THEN
               LET li_reproduce = l_ac_t
               LET li_reproduce_target = l_ac
               LET g_rtib_d[li_reproduce_target].* = g_rtib_d[li_reproduce].*
 
               LET g_rtib_d[li_reproduce_target].rtibseq = NULL
 
            ELSE
               CALL FGL_SET_ARR_CURR(g_rtib_d.getLength()+1)
               LET lb_reproduce = TRUE
               LET li_reproduce = l_ac
               LET li_reproduce_target = g_rtib_d.getLength()+1
            END IF
            
         #ON ACTION cancel
         #   LET INT_FLAG = 1
         #   LET g_detail_idx = 1
         #   EXIT DIALOG 
 
      END INPUT
      
      INPUT ARRAY g_rtib7_d FROM s_detail7.*
         ATTRIBUTE(COUNT = g_rec_b,WITHOUT DEFAULTS, #MAXCOUNT = g_max_rec,
                 INSERT ROW = l_allow_insert, #此頁面insert功能由產生器控制, 手動之設定無效! 
 
                 DELETE ROW = l_allow_delete,
                 APPEND ROW = l_allow_insert)
                 
         #自訂ACTION(detail_input,page_7)
         
         
         BEFORE INPUT
            #add-point:資料輸入前 name="input.body7.before_input2"
            #150429-00007#9--dongsz add-s
            #判断是否存在换赠商品资料
            LET l_n = 0
            SELECT COUNT(*) INTO l_n
              FROM rtib_t
             WHERE rtibent = g_enterprise 
               AND rtibdocno = g_rtia_m.rtiadocno 
               AND rtib039 = 'Y'
            IF l_n > 0 THEN
               IF NOT cl_ask_confirm('art-00772') THEN #已存在换赠信息,异动将删除对应资料,是否异动(Y/N)?
                  #LET l_flag = 'N'
                  EXIT DIALOG
               ELSE
                  #换赠资料初始化
                  CALL s_transaction_begin()
                  CALL s_gift_init('2',g_rtia_m.rtiadocno,g_rtia_m.rtiasite," 1=1") RETURNING l_success
                  IF NOT l_success THEN
                     #LET l_flag = 'N'
                     CALL s_transaction_end('N','0')
                     EXIT DIALOG
                  END IF
                  CALL s_transaction_end('Y','0')
               END IF
            END IF
            #150429-00007#9--dongsz add-e
            #end add-point
            IF g_insert = 'Y' AND NOT cl_null(g_insert) THEN 
              CALL FGL_SET_ARR_CURR(g_rtib7_d.getLength()+1) 
              LET g_insert = 'N' 
           END IF 
 
            CALL artt622_b_fill()
            #如果一直都在單身1則控制筆數位置
            IF g_loc = 'd' AND g_rec_b != 0 THEN
               CALL FGL_SET_ARR_CURR(g_idx_group.getValue("'7',"))
            END IF
            LET g_loc = 'd'
            LET g_rec_b = g_rtib7_d.getLength()
            #add-point:資料輸入前 name="input.body7.before_input"
                        
            #end add-point
            
         BEFORE INSERT
            IF s_transaction_chk("N",0) THEN
               CALL s_transaction_begin()
            END IF
            LET l_insert = TRUE
            LET l_n = ARR_COUNT()
            LET l_cmd = 'a'
            INITIALIZE g_rtib7_d[l_ac].* TO NULL 
            INITIALIZE g_rtib7_d_t.* TO NULL 
            INITIALIZE g_rtib7_d_o.* TO NULL 
            #公用欄位給值(單身7)
            
            #自定義預設值(單身7)
            
            #add-point:modify段before備份 name="input.body7.insert.before_bak"
            
            #end add-point
            LET g_rtib7_d_t.* = g_rtib7_d[l_ac].*     #新輸入資料
            LET g_rtib7_d_o.* = g_rtib7_d[l_ac].*     #新輸入資料
            CALL cl_show_fld_cont()
            CALL artt622_set_entry_b(l_cmd)
            #add-point:modify段after_set_entry_b name="input.body7.insert.after_set_entry_b"
                        
            #end add-point
            CALL artt622_set_no_entry_b(l_cmd)
            IF lb_reproduce THEN
               LET lb_reproduce = FALSE
               LET g_rtib7_d[li_reproduce_target].* = g_rtib7_d[li_reproduce].*
 
               LET g_rtib7_d[li_reproduce_target].prekseq = NULL
            END IF
            
 
            #add-point:modify段before insert name="input.body7.before_insert"
            LET g_rtib7_d[l_ac].prekunit = g_rtia_m.rtiasite
            LET g_rtib7_d[l_ac].preksite = g_rtia_m.rtiasite
            #预设项次
            SELECT MAX(prekseq) + 1
              INTO g_rtib7_d[l_ac].prekseq
              FROM prek_t
             WHERE prekent = g_enterprise
               AND prekdocno = g_rtia_m.rtiadocno
            IF cl_null(g_rtib7_d[l_ac].prekseq) THEN 
               LET g_rtib7_d[l_ac].prekseq = 1
            END IF
            #end add-point  
 
         BEFORE ROW     
            #add-point:modify段before row2 name="input.body7.before_row2"
            
            #end add-point  
            LET l_insert = FALSE
            LET l_cmd = ''
            LET l_ac_t = l_ac 
            LET g_detail_idx_list[7] = l_ac
            LET l_ac = ARR_CURR()
            LET g_detail_idx = l_ac
            LET g_current_page = 7
              
            LET l_lock_sw = 'N'            #DEFAULT
            LET l_n = ARR_COUNT()
            DISPLAY l_ac TO FORMONLY.idx
         
            CALL s_transaction_begin()
            OPEN artt622_cl USING g_enterprise,g_rtia_m.rtiadocno
            IF SQLCA.SQLCODE THEN   #(ver:78)
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "OPEN artt622_cl:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE   #(ver:78)
               LET g_errparam.popup = TRUE 
               CLOSE artt622_cl
               CALL s_transaction_end('N','0')
               CALL cl_err()
               RETURN
            END IF
            
            LET g_rec_b = g_rtib7_d.getLength()
            
            IF g_rec_b >= l_ac 
               AND g_rtib7_d[l_ac].prekseq IS NOT NULL
            THEN 
               LET l_cmd='u'
               LET g_rtib7_d_t.* = g_rtib7_d[l_ac].*  #BACKUP
               LET g_rtib7_d_o.* = g_rtib7_d[l_ac].*  #BACKUP
               CALL artt622_set_entry_b(l_cmd)
               #add-point:modify段after_set_entry_b name="input.body7.after_set_entry_b"
                              
               #end add-point  
               CALL artt622_set_no_entry_b(l_cmd)
               IF NOT artt622_lock_b("prek_t","'7'") THEN
                  LET l_lock_sw='Y'
               ELSE
                  FETCH artt622_bcl7 INTO g_rtib7_d[l_ac].preksite,g_rtib7_d[l_ac].prekunit,g_rtib7_d[l_ac].prekseq, 
                      g_rtib7_d[l_ac].prek001,g_rtib7_d[l_ac].prek002,g_rtib7_d[l_ac].prek003,g_rtib7_d[l_ac].prek004 
 
                  IF SQLCA.SQLCODE THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = SQLERRMESSAGE  
                     LET g_errparam.code = SQLCA.SQLCODE 
                     LET g_errparam.popup = TRUE 
                     CALL cl_err()
                     LET l_lock_sw = "Y"
                  END IF
                  
                  #遮罩相關處理
                  LET g_rtib7_d_mask_o[l_ac].* =  g_rtib7_d[l_ac].*
                  CALL artt622_prek_t_mask()
                  LET g_rtib7_d_mask_n[l_ac].* =  g_rtib7_d[l_ac].*
                  
                  LET g_bfill = "N"
                  CALL artt622_show()
                  LET g_bfill = "Y"
                  
                  CALL cl_show_fld_cont()
               END IF
            ELSE
               LET l_cmd='a'
            END IF
            #add-point:modify段before row name="input.body7.before_row"
                        
            #end add-point  
            #其他table資料備份(確定是否更改用)
            
 
            #其他table進行lock
            
 
            
         BEFORE DELETE                            #是否取消單身
            IF l_cmd = 'a' THEN
               LET l_cmd='d'
               #add-point:單身AFTER DELETE (=d) name="input.body7.after_delete_d"
               
               #end add-point
            ELSE
               #add-point:單身刪除前 name="input.body7.b_delete_ask"
               
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
               
               #add-point:單身7刪除前 name="input.body7.b_delete"
                              
               #end add-point    
                  
               #取得該筆資料key值
               INITIALIZE gs_keys TO NULL
               LET gs_keys[01] = g_rtia_m.rtiadocno
               LET gs_keys[gs_keys.getLength()+1] = g_rtib7_d_t.prekseq
            
               #刪除同層單身
               IF NOT artt622_delete_b('prek_t',gs_keys,"'7'") THEN
                  CALL s_transaction_end('N','0')
                  CLOSE artt622_bcl
                  CANCEL DELETE
               END IF
    
               #刪除下層單身
               IF NOT artt622_key_delete_b(gs_keys,'prek_t') THEN
                  CALL s_transaction_end('N','0')
                  CLOSE artt622_bcl
                  CANCEL DELETE
               END IF
               
               #刪除多語言
               
 
               
               #add-point:單身7刪除中 name="input.body7.m_delete"
                              
               #end add-point    
               
               CALL s_transaction_end('Y','0')
               CLOSE artt622_bcl
 
               LET g_rec_b = g_rec_b-1
               #add-point:單身7刪除後 name="input.body7.a_delete"
                                    
               #end add-point
               LET l_count = g_rtib_d.getLength()
               
               #add-point:單身刪除後(<>d) name="input.body7.after_delete"
                        
               #end add-point
            END IF 
 
         AFTER DELETE
            #如果是最後一筆
            IF l_ac = (g_rtib7_d.getLength() + 1) THEN
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
               
            #add-point:單身7新增前 name="input.body7.b_a_insert"
                        
            #end add-point
               
            LET l_count = 1  
            SELECT COUNT(1) INTO l_count FROM prek_t 
             WHERE prekent = g_enterprise AND prekdocno = g_rtia_m.rtiadocno
               AND prekseq = g_rtib7_d[l_ac].prekseq
                
            #資料未重複, 插入新增資料
            IF l_count = 0 THEN 
               #add-point:單身7新增前 name="input.body7.b_insert"
                              
               #end add-point
            
                              INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_rtia_m.rtiadocno
               LET gs_keys[2] = g_rtib7_d[g_detail_idx].prekseq
               CALL artt622_insert_b('prek_t',gs_keys,"'7'")
                           
               #add-point:單身新增後7 name="input.body7.a_insert"
                              
               #end add-point
            ELSE    
               INITIALIZE g_rtib_d[l_ac].* TO NULL
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
               LET g_errparam.extend = "prek_t:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE 
               LET g_errparam.popup = TRUE 
               CALL s_transaction_end('N','0')                    
               CALL cl_err()
               CANCEL INSERT
            ELSE
               #先刷新資料
               #CALL artt622_b_fill()
               #資料多語言用-增/改
               
               #add-point:單身新增後 name="input.body7.after_insert"
                              
               #end add-point
               CALL s_transaction_end('Y','0')
               #ERROR 'INSERT O.K'
               LET g_rec_b = g_rec_b + 1
            END IF
            
         ON ROW CHANGE 
            IF INT_FLAG THEN
               LET INT_FLAG = 0
               LET g_rtib7_d[l_ac].* = g_rtib7_d_t.*
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code = 9001 
               LET g_errparam.popup = FALSE 
               CLOSE artt622_bcl7
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
               LET g_rtib7_d[l_ac].* = g_rtib7_d_t.*
            ELSE
               #add-point:單身page7修改前 name="input.body7.b_update"
                              
               #end add-point
               
               #寫入修改者/修改日期資訊(單身7)
               
               
               #將遮罩欄位還原
               CALL artt622_prek_t_mask_restore('restore_mask_o')
                              
               UPDATE prek_t SET (prekdocno,preksite,prekunit,prekseq,prek001,prek002,prek003,prek004) = (g_rtia_m.rtiadocno, 
                   g_rtib7_d[l_ac].preksite,g_rtib7_d[l_ac].prekunit,g_rtib7_d[l_ac].prekseq,g_rtib7_d[l_ac].prek001, 
                   g_rtib7_d[l_ac].prek002,g_rtib7_d[l_ac].prek003,g_rtib7_d[l_ac].prek004) #自訂欄位頁簽 
 
                WHERE prekent = g_enterprise AND prekdocno = g_rtia_m.rtiadocno
                  AND prekseq = g_rtib7_d_t.prekseq #項次 
                  
               #add-point:單身page7修改中 name="input.body7.m_update"
                              
               #end add-point
                  
               CASE
                  WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
                     LET g_rtib7_d[l_ac].* = g_rtib7_d_t.*
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "prek_t" 
                     LET g_errparam.code = "std-00009" 
                     LET g_errparam.popup = TRUE 
                     CALL s_transaction_end('N','0')
                     CALL cl_err()
                     
                  WHEN SQLCA.SQLCODE #其他錯誤
                     LET g_rtib7_d[l_ac].* = g_rtib7_d_t.*
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "prek_t:",SQLERRMESSAGE 
                     LET g_errparam.code = SQLCA.SQLCODE 
                     LET g_errparam.popup = TRUE 
                     CALL s_transaction_end('N','0')
                     CALL cl_err()
                     
                  OTHERWISE
                     #資料多語言用-增/改
                     
                                    INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_rtia_m.rtiadocno
               LET gs_keys_bak[1] = g_rtiadocno_t
               LET gs_keys[2] = g_rtib7_d[g_detail_idx].prekseq
               LET gs_keys_bak[2] = g_rtib7_d_t.prekseq
               CALL artt622_update_b('prek_t',gs_keys,gs_keys_bak,"'7'")
               END CASE
               
               #將遮罩欄位進行遮蔽
               CALL artt622_prek_t_mask_restore('restore_mask_n')
               
               #判斷key是否有改變
               INITIALIZE gs_keys TO NULL
               IF NOT (g_rtib7_d[g_detail_idx].prekseq = g_rtib7_d_t.prekseq 
                  ) THEN
                  LET gs_keys[01] = g_rtia_m.rtiadocno
                  LET gs_keys[gs_keys.getLength()+1] = g_rtib7_d_t.prekseq
                  CALL artt622_key_update_b(gs_keys,'prek_t')
               END IF
               
               #修改歷程記錄(單身修改)
               LET g_log1 = util.JSON.stringify(g_rtia_m),util.JSON.stringify(g_rtib7_d_t)
               LET g_log2 = util.JSON.stringify(g_rtia_m),util.JSON.stringify(g_rtib7_d[l_ac])
               IF NOT cl_log_modified_record_d(g_log1,g_log2) THEN 
                  CALL s_transaction_end('N','0')
               END IF
               
               #add-point:單身page7修改後 name="input.body7.a_update"
                              
               #end add-point
            END IF
         
                  #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD preksite
            #add-point:BEFORE FIELD preksite name="input.b.page7.preksite"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD preksite
            
            #add-point:AFTER FIELD preksite name="input.a.page7.preksite"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE preksite
            #add-point:ON CHANGE preksite name="input.g.page7.preksite"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prekunit
            #add-point:BEFORE FIELD prekunit name="input.b.page7.prekunit"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prekunit
            
            #add-point:AFTER FIELD prekunit name="input.a.page7.prekunit"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE prekunit
            #add-point:ON CHANGE prekunit name="input.g.page7.prekunit"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prekseq
            #add-point:BEFORE FIELD prekseq name="input.b.page7.prekseq"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prekseq
            
            #add-point:AFTER FIELD prekseq name="input.a.page7.prekseq"
            #應用 a05 樣板自動產生(Version:3)
            #確認資料無重複
            IF  g_rtia_m.rtiadocno IS NOT NULL AND g_rtib7_d[g_detail_idx].prekseq IS NOT NULL THEN 
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_rtia_m.rtiadocno != g_rtiadocno_t OR g_rtib7_d[g_detail_idx].prekseq != g_rtib7_d_t.prekseq)) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM prek_t WHERE "||"prekent = '" ||g_enterprise|| "' AND "||"prekdocno = '"||g_rtia_m.rtiadocno ||"' AND "|| "prekseq = '"||g_rtib7_d[g_detail_idx].prekseq ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF



            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE prekseq
            #add-point:ON CHANGE prekseq name="input.g.page7.prekseq"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prek001
            #add-point:BEFORE FIELD prek001 name="input.b.page7.prek001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prek001
            
            #add-point:AFTER FIELD prek001 name="input.a.page7.prek001"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE prek001
            #add-point:ON CHANGE prek001 name="input.g.page7.prek001"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prek002
            #add-point:BEFORE FIELD prek002 name="input.b.page7.prek002"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prek002
            
            #add-point:AFTER FIELD prek002 name="input.a.page7.prek002"
            IF NOT cl_null(g_rtib7_d[l_ac].prek002) THEN
               LET l_n = 0
               SELECT COUNT(*) INTO l_n
                 FROM rtja_t
                WHERE rtjaent = g_enterprise
                  AND rtjasite = g_rtia_m.rtiasite
                  AND rtjastus = 'S'
                  AND rtja033 = g_rtib7_d[l_ac].prek002
                  AND rtja000 IN ('artt622','artt610','artt620')
                  AND rtja032 <> '4'    #日结类型
               IF l_n < 1 THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = ""
                  LET g_errparam.code   = 'art-00764'
                  LET g_errparam.popup  = TRUE 
                  CALL cl_err()
                  LET g_rtib7_d[l_ac].prek002 = g_rtib7_d_t.prek002
                  DISPLAY BY NAME g_rtib7_d[l_ac].prek002
                  NEXT FIELD prek002
               END IF
               #判断销售单对应单头卡号
               IF NOT cl_null(g_rtia_m.rtia001) THEN
                  LET l_n = 0
                  SELECT COUNT(*) INTO l_n
                    FROM rtja_t
                   WHERE rtjaent = g_enterprise
                     AND rtja033 = g_rtib7_d[l_ac].prek002
                     AND rtja001 = g_rtia_m.rtia001
                  IF l_n < 1 THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = ""
                     LET g_errparam.code   = 'art-00779'
                     LET g_errparam.popup  = TRUE 
                     CALL cl_err()
                     LET g_rtib7_d[l_ac].prek002 = g_rtib7_d_t.prek002
                     DISPLAY BY NAME g_rtib7_d[l_ac].prek002
                     NEXT FIELD prek002
                  END IF
               END IF
               #判断小票号不存在于其他单据资料中
               LET l_n = 0
               SELECT COUNT(*) INTO l_n
                 FROM prek_t
                WHERE prekent = g_enterprise
                  AND prekdocno <> g_rtia_m.rtiadocno
                  AND prek002 = g_rtib7_d[l_ac].prek002
               IF l_n > 0 THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = ""
                  LET g_errparam.code   = 'art-00778'
                  LET g_errparam.popup  = TRUE 
                  CALL cl_err()
                  LET g_rtib7_d[l_ac].prek002 = g_rtib7_d_t.prek002
                  DISPLAY BY NAME g_rtib7_d[l_ac].prek002
                  NEXT FIELD prek002
               END IF
               #带出销售日期、单号和销售金额
               SELECT rtjadocdt,rtjadocno,rtja049 
                 INTO g_rtib7_d[l_ac].prek001,g_rtib7_d[l_ac].prek003,g_rtib7_d[l_ac].prek004
                 FROM rtja_t
                WHERE rtjaent = g_enterprise
                  AND rtja033 = g_rtib7_d[l_ac].prek002
            END IF
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE prek002
            #add-point:ON CHANGE prek002 name="input.g.page7.prek002"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prek003
            #add-point:BEFORE FIELD prek003 name="input.b.page7.prek003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prek003
            
            #add-point:AFTER FIELD prek003 name="input.a.page7.prek003"
            IF NOT cl_null(g_rtib7_d[l_ac].prek003) THEN
               LET l_n = 0
               SELECT COUNT(*) INTO l_n
                 FROM rtja_t
                WHERE rtjaent = g_enterprise
                  AND rtjasite = g_rtia_m.rtiasite
                  AND rtjastus = 'S'
                  AND rtjadocno = g_rtib7_d[l_ac].prek003
                  AND rtja000 IN ('artt622','artt610','artt620')
                  AND rtja032 <> '4'
               IF l_n < 1 THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = ""
                  LET g_errparam.code   = 'art-00764'
                  LET g_errparam.popup  = TRUE 
                  CALL cl_err()
                  LET g_rtib7_d[l_ac].prek003 = g_rtib7_d_t.prek003
                  DISPLAY BY NAME g_rtib7_d[l_ac].prek003
                  NEXT FIELD prek003
               END IF
               #判断销售单对应单头卡号
               IF NOT cl_null(g_rtia_m.rtia001) THEN
                  LET l_n = 0
                  SELECT COUNT(*) INTO l_n
                    FROM rtja_t
                   WHERE rtjaent = g_enterprise
                     AND rtjadocno = g_rtib7_d[l_ac].prek003
                     AND rtja001 = g_rtia_m.rtia001
                  IF l_n < 1 THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = ""
                     LET g_errparam.code   = 'art-00779'
                     LET g_errparam.popup  = TRUE 
                     CALL cl_err()
                     LET g_rtib7_d[l_ac].prek003 = g_rtib7_d_t.prek003
                     DISPLAY BY NAME g_rtib7_d[l_ac].prek003
                     NEXT FIELD prek003
                  END IF
               END IF
               #判断销售单号不存在于其他单据资料中
               LET l_n = 0
               SELECT COUNT(*) INTO l_n
                 FROM prek_t
                WHERE prekent = g_enterprise
                  AND prekdocno <> g_rtia_m.rtiadocno
                  AND prek003 = g_rtib7_d[l_ac].prek003
               IF l_n > 0 THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = ""
                  LET g_errparam.code   = 'art-00778'
                  LET g_errparam.popup  = TRUE 
                  CALL cl_err()
                  LET g_rtib7_d[l_ac].prek003 = g_rtib7_d_t.prek003
                  DISPLAY BY NAME g_rtib7_d[l_ac].prek003
                  NEXT FIELD prek003
               END IF
               #带出小票号和销售日期、金额
               SELECT rtjadocdt,rtja033,rtja049 
                 INTO g_rtib7_d[l_ac].prek001,g_rtib7_d[l_ac].prek002,g_rtib7_d[l_ac].prek004
                 FROM rtja_t
                WHERE rtjaent = g_enterprise
                  AND rtjadocno = g_rtib7_d[l_ac].prek003
            END IF
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE prek003
            #add-point:ON CHANGE prek003 name="input.g.page7.prek003"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prek004
            #add-point:BEFORE FIELD prek004 name="input.b.page7.prek004"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prek004
            
            #add-point:AFTER FIELD prek004 name="input.a.page7.prek004"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE prek004
            #add-point:ON CHANGE prek004 name="input.g.page7.prek004"
            
            #END add-point 
 
 
 
                  #Ctrlp:input.c.page7.preksite
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD preksite
            #add-point:ON ACTION controlp INFIELD preksite name="input.c.page7.preksite"
            
            #END add-point
 
 
         #Ctrlp:input.c.page7.prekunit
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prekunit
            #add-point:ON ACTION controlp INFIELD prekunit name="input.c.page7.prekunit"
            
            #END add-point
 
 
         #Ctrlp:input.c.page7.prekseq
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prekseq
            #add-point:ON ACTION controlp INFIELD prekseq name="input.c.page7.prekseq"
            
            #END add-point
 
 
         #Ctrlp:input.c.page7.prek001
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prek001
            #add-point:ON ACTION controlp INFIELD prek001 name="input.c.page7.prek001"
            
            #END add-point
 
 
         #Ctrlp:input.c.page7.prek002
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prek002
            #add-point:ON ACTION controlp INFIELD prek002 name="input.c.page7.prek002"
            #開窗i段
	         INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
	         LET g_qryparam.reqry = FALSE
	         LET g_qryparam.where = " rtjastus = 'S' AND rtjasite = '",g_rtia_m.rtiasite,"' ",
                                   " AND rtja000 IN ('artt622','artt610','artt620') AND rtja033 IS NOT NULL ",
                                   " AND rtja032 <> '4' "
            IF NOT cl_null(g_rtib7_d[l_ac].prek001) THEN
               LET g_qryparam.where = g_qryparam.where," AND rtjadocdt = '",g_rtib7_d[l_ac].prek001,"' "
            END IF
            IF NOT cl_null(g_rtia_m.rtia001) THEN
               LET g_qryparam.where = g_qryparam.where," AND rtja001 = '",g_rtia_m.rtia001,"' "
            END IF
            LET g_qryparam.default1 = g_rtib7_d[l_ac].prek002
            LET g_qryparam.default2 = g_rtib7_d[l_ac].prek003
            CALL q_rtja033_1()
            LET g_rtib7_d[l_ac].prek002 = g_qryparam.return1
            LET g_rtib7_d[l_ac].prek003 = g_qryparam.return2
            DISPLAY g_rtib7_d[l_ac].prek002 TO prek002             #顯示到畫面上
            DISPLAY g_rtib7_d[l_ac].prek003 TO prek003
            NEXT FIELD prek002                              #返回原欄位
            #END add-point
 
 
         #Ctrlp:input.c.page7.prek003
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prek003
            #add-point:ON ACTION controlp INFIELD prek003 name="input.c.page7.prek003"
            #開窗i段
	         INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
	         LET g_qryparam.reqry = FALSE
	         LET g_qryparam.where = " rtjastus = 'S' AND rtjasite = '",g_rtia_m.rtiasite,"' ",
                                   " AND rtja000 IN ('artt622','artt610','artt620') AND rtja032 <> '4' "
            IF NOT cl_null(g_rtib7_d[l_ac].prek001) THEN
               LET g_qryparam.where = g_qryparam.where," AND rtjadocdt = '",g_rtib7_d[l_ac].prek001,"' "
            END IF
            IF NOT cl_null(g_rtia_m.rtia001) THEN
               LET g_qryparam.where = g_qryparam.where," AND rtja001 = '",g_rtia_m.rtia001,"' "
            END IF
            LET g_qryparam.default1 = g_rtib7_d[l_ac].prek003
            CALL q_rtjadocno()
            LET g_rtib7_d[l_ac].prek003 = g_qryparam.return1
            DISPLAY g_rtib7_d[l_ac].prek003 TO prek003             #顯示到畫面上
            NEXT FIELD prek003                              #返回原欄位
            #END add-point
 
 
         #Ctrlp:input.c.page7.prek004
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prek004
            #add-point:ON ACTION controlp INFIELD prek004 name="input.c.page7.prek004"
            
            #END add-point
 
 
 
 
         AFTER ROW
            #add-point:單身page7 after_row name="input.body7.after_row"
                        
            #end add-point
            LET l_ac = ARR_CURR()
            IF INT_FLAG THEN
               LET INT_FLAG = 0
               IF l_cmd = 'u' THEN
                  LET g_rtib7_d[l_ac].* = g_rtib7_d_t.*
               END IF
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code = 9001 
               LET g_errparam.popup = FALSE 
               CLOSE artt622_bcl7
               CALL s_transaction_end('N','0')
               CALL cl_err()
               EXIT DIALOG 
            END IF
            
            #其他table進行unlock
            
            CALL artt622_unlock_b("prek_t","'7'")
            CALL s_transaction_end('Y','0')
            #add-point:單身page7 after_row2 name="input.body7.after_row2"
            
            #end add-point
 
         AFTER INPUT
            #add-point:input段after input  name="input.body7.after_input"
            #150429-00007#9--dongsz add--s
            CALL s_gift('2',g_rtia_m.rtiadocno,g_rtia_m.rtiasite," 1=1")
            CALL artt622_b_fill()
            SELECT SUM(rtib012),SUM(rtib008*rtib017),SUM(rtib020),SUM(rtib021)
              INTO g_rtia_m.snum,g_rtia_m.amount,g_rtia_m.amount2,g_rtia_m.amount3
              FROM rtib_t
             WHERE rtibent = g_enterprise
               AND rtibdocno = g_rtia_m.rtiadocno
            DISPLAY g_rtia_m.snum TO FORMONLY.snum  
            DISPLAY g_rtia_m.amount TO FORMONLY.amount
            DISPLAY g_rtia_m.amount2 TO FORMONLY.amount2
            DISPLAY g_rtia_m.amount3 TO FORMONLY.amount3
            #更新单头本币应收金额
            #更新单头含税金额
            UPDATE rtia_t SET rtia031 = (SELECT SUM(rtib021)
                                           FROM rtib_t
                                          WHERE rtibent = g_enterprise
                                            AND rtibdocno = g_rtia_m.rtiadocno),
                              rtia049 = (SELECT SUM(rtib031)
                                           FROM rtib_t
                                          WHERE rtibent = g_enterprise
                                            AND rtibdocno = g_rtia_m.rtiadocno)              
             WHERE rtiaent = g_enterprise
               AND rtiadocno = g_rtia_m.rtiadocno  
            IF SQLCA.sqlcode THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = SQLCA.sqlcode
               LET g_errparam.extend = "upd rtia_t"
               LET g_errparam.popup = FALSE
               CALL cl_err()
            
               CONTINUE DIALOG
            END IF     
            #150429-00007#9--dongsz add--e
            #end add-point   
    
         ON ACTION controlo
            IF l_insert THEN
               LET li_reproduce = l_ac_t
               LET li_reproduce_target = l_ac
               LET g_rtib7_d[li_reproduce_target].* = g_rtib7_d[li_reproduce].*
 
               LET g_rtib7_d[li_reproduce_target].prekseq = NULL
            ELSE
               CALL FGL_SET_ARR_CURR(g_rtib7_d.getLength()+1)
               LET lb_reproduce = TRUE
               LET li_reproduce = l_ac
               LET li_reproduce_target = g_rtib7_d.getLength()+1
            END IF
            
      END INPUT
 
      
 
      DISPLAY ARRAY g_rtib2_d TO s_detail2.* ATTRIBUTES(COUNT=g_rec_b)  
    
         BEFORE ROW
            CALL artt622_idx_chk()
            LET l_ac = DIALOG.getCurrentRow("s_detail2")
            LET g_detail_idx = l_ac
            
            #add-point:page2, before row動作 name="input.body2.before_row"
            
            #end add-point
            
         BEFORE DISPLAY
            #如果一直都在單身1則控制筆數位置
            IF g_loc = 'm' THEN
               CALL FGL_SET_ARR_CURR(g_idx_group.getValue("'2',"))
            END IF
            LET g_loc = 'm'
            LET l_ac = DIALOG.getCurrentRow("s_detail2")
            CALL artt622_idx_chk()
            LET g_current_page = 2
      
         #add-point:page2自定義行為 name="input.body2.action"
         CALL artt622_refresh()
         #end add-point
      
      END DISPLAY
      DISPLAY ARRAY g_rtib3_d TO s_detail3.* ATTRIBUTES(COUNT=g_rec_b)  
    
         BEFORE ROW
            CALL artt622_idx_chk()
            LET l_ac = DIALOG.getCurrentRow("s_detail3")
            LET g_detail_idx = l_ac
            
            #add-point:page3, before row動作 name="input.body3.before_row"
                                    IF l_cmd = 'u' THEN            
               CALL artt622_xrcd002_chk()
               
            END IF 
            #end add-point
            
         BEFORE DISPLAY
            #如果一直都在單身1則控制筆數位置
            IF g_loc = 'm' THEN
               CALL FGL_SET_ARR_CURR(g_idx_group.getValue("'3',"))
            END IF
            LET g_loc = 'm'
            LET l_ac = DIALOG.getCurrentRow("s_detail3")
            CALL artt622_idx_chk()
            LET g_current_page = 3
      
         #add-point:page3自定義行為 name="input.body3.action"
         CALL artt622_refresh()
         #end add-point
      
      END DISPLAY
      DISPLAY ARRAY g_rtib4_d TO s_detail4.* ATTRIBUTES(COUNT=g_rec_b)  
    
         BEFORE ROW
            CALL artt622_idx_chk()
            LET l_ac = DIALOG.getCurrentRow("s_detail4")
            LET g_detail_idx = l_ac
            
            #add-point:page4, before row動作 name="input.body4.before_row"
                        
            #end add-point
            
         BEFORE DISPLAY
            #如果一直都在單身1則控制筆數位置
            IF g_loc = 'm' THEN
               CALL FGL_SET_ARR_CURR(g_idx_group.getValue("'4',"))
            END IF
            LET g_loc = 'm'
            LET l_ac = DIALOG.getCurrentRow("s_detail4")
            CALL artt622_idx_chk()
            LET g_current_page = 4
      
         #add-point:page4自定義行為 name="input.body4.action"
         CALL artt622_refresh()
         #end add-point
      
      END DISPLAY
      DISPLAY ARRAY g_rtib5_d TO s_detail5.* ATTRIBUTES(COUNT=g_rec_b)  
    
         BEFORE ROW
            CALL artt622_idx_chk()
            LET l_ac = DIALOG.getCurrentRow("s_detail5")
            LET g_detail_idx = l_ac
            
            #add-point:page5, before row動作 name="input.body5.before_row"
                        
            #end add-point
            
         BEFORE DISPLAY
            #如果一直都在單身1則控制筆數位置
            IF g_loc = 'm' THEN
               CALL FGL_SET_ARR_CURR(g_idx_group.getValue("'5',"))
            END IF
            LET g_loc = 'm'
            LET l_ac = DIALOG.getCurrentRow("s_detail5")
            CALL artt622_idx_chk()
            LET g_current_page = 5
      
         #add-point:page5自定義行為 name="input.body5.action"
         
         #end add-point
      
      END DISPLAY
      DISPLAY ARRAY g_rtib6_d TO s_detail6.* ATTRIBUTES(COUNT=g_rec_b)  
    
         BEFORE ROW
            CALL artt622_idx_chk()
            LET l_ac = DIALOG.getCurrentRow("s_detail6")
            LET g_detail_idx = l_ac
            
            #add-point:page6, before row動作 name="input.body6.before_row"
                        
            #end add-point
            
         BEFORE DISPLAY
            #如果一直都在單身1則控制筆數位置
            IF g_loc = 'm' THEN
               CALL FGL_SET_ARR_CURR(g_idx_group.getValue("'6',"))
            END IF
            LET g_loc = 'm'
            LET l_ac = DIALOG.getCurrentRow("s_detail6")
            CALL artt622_idx_chk()
            LET g_current_page = 6
      
         #add-point:page6自定義行為 name="input.body6.action"
         CALL artt622_refresh()
         #end add-point
      
      END DISPLAY
 
 
 
{</section>}
 
{<section id="artt622.input.other" >}
      
      #add-point:自定義input name="input.more_input"
      
#      INPUT  g_chantype FROM  chantype
#         
#         #自訂ACTION(master_input)
#         
#     
#         BEFORE INPUT
#            let g_chantype='1'
#         on change chantype
#         if g_chantype is null then 
#            let g_chantype='1'
#         end if 
#         END INPUT
#      INPUT  g_chantype,g_barcode  FROM  chantype,barcode
#         ATTRIBUTE(WITHOUT DEFAULTS)
#         
#         #自訂ACTION(master_input)
#         
#     
#         BEFORE INPUT
#            IF s_transaction_chk("N",0) THEN
#               CALL s_transaction_begin()
#            END IF 
#            let g_chantype='1'            
#            IF l_cmd_t = 'r' THEN
#               
#            END IF
#            #因應離開單頭後已寫入資料庫, 若重新回到單頭則視為修改
#            #因此需於此處開啟/關閉欄位
#            #add-point:資料輸入前 name="input.m.before_input"
#            AFTER FIELD barcode
#            IF NOT cl_null(g_barcode) THEN
#               SELECT COUNT (*) INTO l_l FROM rtib_t WHERE rtibent=g_enterprise  AND rtibdocno=g_rtia_m.rtiadocno AND rtib003=g_barcode
#               IF l_l=0 THEN                
#                  CALL artt622_tmq()  RETURNING l_success                  
#                ELSE 
#                  UPDATE rtib_t  SET rtib012=rtib012+1
#                  WHERE rtibent=g_enterprise  AND rtibdocno=g_rtia_m.rtiadocno AND rtib003=g_barcode
#                END IF
#                 #if  l_success THEN 
#                 #    CALL s_transaction_end('Y','O')
#                 #ELSE
#                 #    CALL s_transaction_end('N','O')
#                 #END IF                 
#                  CALL artt622_b_fill()
#                  LET g_barcode=''
#                  DISPLAY '' TO formonly.barcode
#                  NEXT FIELD barcode              
#            ELSE 
#               IF  l_success THEN 
#                     CALL s_transaction_end('Y','O')
#                 ELSE
#                     CALL s_transaction_end('N','O')
#                 END IF           
#            END IF 
#       END INPUT
      #end add-point
    
      BEFORE DIALOG 
         #CALL cl_err_collect_init()    
         #add-point:input段before dialog name="input.before_dialog"
          IF p_cmd = 'a' THEN 
            let g_chantype='1'
            display g_chantype to formonly.chantype 
            NEXT FIELD rtia001 
         END IF
                 
         
         #end add-point    
         #重新導回資料到正確位置上
         CALL DIALOG.setCurrentRow("s_detail1",g_idx_group.getValue("'1',"))      
         CALL DIALOG.setCurrentRow("s_detail2",g_idx_group.getValue("'2',"))
         CALL DIALOG.setCurrentRow("s_detail3",g_idx_group.getValue("'3',"))
         CALL DIALOG.setCurrentRow("s_detail4",g_idx_group.getValue("'4',"))
         CALL DIALOG.setCurrentRow("s_detail5",g_idx_group.getValue("'5',"))
         CALL DIALOG.setCurrentRow("s_detail6",g_idx_group.getValue("'6',"))
         CALL DIALOG.setCurrentRow("s_detail7",g_idx_group.getValue("'7',"))
 
         #新增時強制從單頭開始填
         IF p_cmd = 'a' THEN
            #add-point:input段next_field name="input.next_field"
            NEXT FIELD rtia001 
            #end add-point  
            NEXT FIELD rtiadocno
         ELSE
            CASE g_aw
               WHEN "s_detail1"
                  NEXT FIELD rtibsite
               WHEN "s_detail2"
                  NEXT FIELD rticseq
               WHEN "s_detail3"
                  NEXT FIELD xrcd007
               WHEN "s_detail4"
                  NEXT FIELD rtieseq
               WHEN "s_detail5"
                  NEXT FIELD rtiksite
               WHEN "s_detail6"
                  NEXT FIELD rtinsite
               WHEN "s_detail7"
                  NEXT FIELD preksite
 
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
         LET g_detail_idx_list[4] = 1
         LET g_detail_idx_list[5] = 1
         LET g_detail_idx_list[6] = 1
         LET g_detail_idx_list[7] = 1
 
         CALL g_curr_diag.setCurrentRow("s_detail1",1)    
         CALL g_curr_diag.setCurrentRow("s_detail2",1)
         CALL g_curr_diag.setCurrentRow("s_detail3",1)
         CALL g_curr_diag.setCurrentRow("s_detail4",1)
         CALL g_curr_diag.setCurrentRow("s_detail5",1)
         CALL g_curr_diag.setCurrentRow("s_detail6",1)
         CALL g_curr_diag.setCurrentRow("s_detail7",1)
 
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
         LET g_detail_idx_list[4] = 1
         LET g_detail_idx_list[5] = 1
         LET g_detail_idx_list[6] = 1
         LET g_detail_idx_list[7] = 1
 
         CALL g_curr_diag.setCurrentRow("s_detail1",1)    
         CALL g_curr_diag.setCurrentRow("s_detail2",1)
         CALL g_curr_diag.setCurrentRow("s_detail3",1)
         CALL g_curr_diag.setCurrentRow("s_detail4",1)
         CALL g_curr_diag.setCurrentRow("s_detail5",1)
         CALL g_curr_diag.setCurrentRow("s_detail6",1)
         CALL g_curr_diag.setCurrentRow("s_detail7",1)
 
         EXIT DIALOG
 
      #交談指令共用ACTION
      &include "common_action.4gl" 
         CONTINUE DIALOG 
   END DIALOG
    
   #add-point:input段after input  name="input.after_input"
   CALL artt622_b_fill()
   SELECT SUM(rtib012),SUM(rtib008*rtib017),SUM(rtib020),SUM(rtib021)
     INTO g_rtia_m.snum,g_rtia_m.amount,g_rtia_m.amount2,g_rtia_m.amount3
     FROM rtib_t
    WHERE rtibent = g_enterprise
      AND rtibdocno = g_rtia_m.rtiadocno
   DISPLAY g_rtia_m.snum TO FORMONLY.snum  
   DISPLAY g_rtia_m.amount TO FORMONLY.amount
   DISPLAY g_rtia_m.amount2 TO FORMONLY.amount2
   DISPLAY g_rtia_m.amount3 TO FORMONLY.amount3
   #更新单头本币应收金额
   UPDATE rtia_t SET rtia049 = (SELECT SUM(rtib031)
                                  FROM rtib_t
                                 WHERE rtibent = g_enterprise
                                   AND rtibdocno = g_rtia_m.rtiadocno)              
    WHERE rtiaent = g_enterprise
      AND rtiadocno = g_rtia_m.rtiadocno  
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = "rtia_t"
      LET g_errparam.popup = FALSE
      CALL cl_err()
   END IF  
call artt622_show()   
   #end add-point    
 
END FUNCTION
 
{</section>}
 
{<section id="artt622.show" >}
#+ 單頭資料重新顯示及單身資料重抓
PRIVATE FUNCTION artt622_show()
   #add-point:show段define(客製用) name="show.define_customerization"
   
   #end add-point  
   DEFINE l_ac_t    LIKE type_t.num10
   #add-point:show段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="show.define"
   DEFINE l_mmaq003 LIKE mmaq_t.mmaq003
   #end add-point  
   
   #add-point:Function前置處理 name="show.before"
      
   #end add-point
   
   
   
   IF g_bfill = "Y" THEN
      CALL artt622_b_fill() #單身填充
      CALL artt622_b_fill2('0') #單身填充
   END IF
     
   #帶出公用欄位reference值
   #應用 a12 樣板自動產生(Version:4)
 
 
 
   
   #顯示followup圖示
   #應用 a48 樣板自動產生(Version:3)
   CALL artt622_set_pk_array()
   #add-point:ON ACTION agendum name="show.follow_pic"
   
   #END add-point
   CALL cl_user_overview_set_follow_pic()
  
 
 
 
   
   LET l_ac_t = l_ac
   
   #讀入ref值(單頭)
   #add-point:show段reference name="show.head.reference"
   select mmaf003,mmaf004 into g_rtia_m.mmaf003,g_rtia_m.mmaf004
    FROM mmaf_t,mmaq_t
    WHERE mmafent = mmaqent
    AND mmaf001 = mmaq003
    AND mmaqent = g_enterprise
    AND mmaq001 = g_rtia_m.rtia001   
   
   SELECT mmaq003 INTO l_mmaq003 
     FROM mmaq_t
    WHERE mmaq001 = g_rtia_m.rtia001
      AND mmaqent = g_enterprise
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = l_mmaq003
   CALL ap_ref_array2(g_ref_fields,"SELECT mmaf008 FROM mmaf_t WHERE mmafent='"||g_enterprise||"' AND mmaf001=? ","") RETURNING g_rtn_fields
   LET g_rtia_m.rtia001_desc = '', g_rtn_fields[1] , ''
   LET g_rtia_m.l_rtia047 = g_rtia_m.rtia043 - g_rtia_m.rtia047
   #end add-point
   
   #遮罩相關處理
   LET g_rtia_m_mask_o.* =  g_rtia_m.*
   CALL artt622_rtia_t_mask()
   LET g_rtia_m_mask_n.* =  g_rtia_m.*
   
   #將資料輸出到畫面上
   DISPLAY BY NAME g_rtia_m.rtiasite,g_rtia_m.rtiasite_desc,g_rtia_m.rtiadocdt,g_rtia_m.rtiadocno,g_rtia_m.rtia002, 
       g_rtia_m.rtia002_desc,g_rtia_m.rtia001,g_rtia_m.rtia001_desc,g_rtia_m.rtia059,g_rtia_m.rtia060, 
       g_rtia_m.mmaf003,g_rtia_m.mmaf004,g_rtia_m.rtia004,g_rtia_m.rtia004_desc,g_rtia_m.rtia005,g_rtia_m.rtia005_desc, 
       g_rtia_m.rtia006,g_rtia_m.rtia048,g_rtia_m.rtia053,g_rtia_m.rtiastus,g_rtia_m.rtia007,g_rtia_m.rtia008, 
       g_rtia_m.rtia009,g_rtia_m.rtia009_desc,g_rtia_m.rtia043,g_rtia_m.rtia047,g_rtia_m.l_rtia047,g_rtia_m.rtia013, 
       g_rtia_m.rtia014,g_rtia_m.rtia015,g_rtia_m.rtia016,g_rtia_m.rtia051,g_rtia_m.rtia010,g_rtia_m.rtia010_desc, 
       g_rtia_m.rtia011,g_rtia_m.rtia011_desc,g_rtia_m.rtia012,g_rtia_m.rtia012_desc,g_rtia_m.chantype, 
       g_rtia_m.barcode,g_rtia_m.rtia041,g_rtia_m.rtia017,g_rtia_m.rtia018,g_rtia_m.rtia018_desc,g_rtia_m.rtia019, 
       g_rtia_m.rtia020,g_rtia_m.rtia021,g_rtia_m.rtia022,g_rtia_m.rtia023,g_rtia_m.rtia024,g_rtia_m.rtia024_desc, 
       g_rtia_m.rtia025,g_rtia_m.rtia025_desc,g_rtia_m.rtia026,g_rtia_m.rtia027,g_rtia_m.rtia028,g_rtia_m.rtia029, 
       g_rtia_m.rtia030,g_rtia_m.rtia032,g_rtia_m.rtia033,g_rtia_m.rtia034,g_rtia_m.rtia035,g_rtia_m.rtia036, 
       g_rtia_m.rtia036_desc,g_rtia_m.rtia037,g_rtia_m.rtia037_desc,g_rtia_m.rtia038,g_rtia_m.rtia038_desc, 
       g_rtia_m.rtia039,g_rtia_m.rtia107,g_rtia_m.isaf009,g_rtia_m.isaf010,g_rtia_m.isaf044,g_rtia_m.isaf202, 
       g_rtia_m.isaf203,g_rtia_m.isaf204,g_rtia_m.isaf201,g_rtia_m.isaf207,g_rtia_m.rtiaownid,g_rtia_m.rtiaownid_desc, 
       g_rtia_m.rtiacrtid,g_rtia_m.rtiacrtid_desc,g_rtia_m.rtiaowndp,g_rtia_m.rtiaowndp_desc,g_rtia_m.rtiacrtdp, 
       g_rtia_m.rtiacrtdp_desc,g_rtia_m.rtiacrtdt,g_rtia_m.rtiamodid,g_rtia_m.rtiamodid_desc,g_rtia_m.rtiamoddt, 
       g_rtia_m.rtiacnfid,g_rtia_m.rtiacnfid_desc,g_rtia_m.rtiacnfdt,g_rtia_m.rtiapstid,g_rtia_m.rtiapstid_desc, 
       g_rtia_m.rtiapstdt,g_rtia_m.snum,g_rtia_m.amount,g_rtia_m.amount2,g_rtia_m.amount3
   
   #顯示狀態(stus)圖片
         #應用 a21 樣板自動產生(Version:3)
	  #根據當下狀態碼顯示圖片
      CASE g_rtia_m.rtiastus 
         WHEN "N"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/unconfirmed.png")
         WHEN "Y"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/confirmed.png")
         WHEN "S"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/posted.png")
         WHEN "Z"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/unposted.png")
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
   FOR l_ac = 1 TO g_rtib_d.getLength()
      #add-point:show段單身reference name="show.body.reference"
 
      #end add-point
   END FOR
   
   FOR l_ac = 1 TO g_rtib2_d.getLength()
      #add-point:show段單身reference name="show.body2.reference"
            
      #end add-point
   END FOR
   FOR l_ac = 1 TO g_rtib3_d.getLength()
      #add-point:show段單身reference name="show.body3.reference"
            
      #end add-point
   END FOR
   FOR l_ac = 1 TO g_rtib4_d.getLength()
      #add-point:show段單身reference name="show.body4.reference"


      #end add-point
   END FOR
   FOR l_ac = 1 TO g_rtib5_d.getLength()
      #add-point:show段單身reference name="show.body5.reference"
            
      #end add-point
   END FOR
   FOR l_ac = 1 TO g_rtib6_d.getLength()
      #add-point:show段單身reference name="show.body6.reference"
            
      #end add-point
   END FOR
   FOR l_ac = 1 TO g_rtib7_d.getLength()
      #add-point:show段單身reference name="show.body7.reference"
            
      #end add-point
   END FOR
 
   
    
   
   #add-point:show段other name="show.other"
      
   #end add-point  
   
   LET l_ac = l_ac_t
   
   #移動上下筆可以連動切換資料
   CALL cl_show_fld_cont()     
 
   CALL artt622_detail_show()
 
   #add-point:show段之後 name="show.after"
   SELECT SUM(rtib012),SUM(rtib008*rtib017),SUM(rtib020),SUM(rtib021)
     INTO g_rtia_m.snum,g_rtia_m.amount,g_rtia_m.amount2,g_rtia_m.amount3
     FROM rtib_t
    WHERE rtibent = g_enterprise
      AND rtibdocno = g_rtia_m.rtiadocno
   DISPLAY g_rtia_m.snum TO FORMONLY.snum  
   DISPLAY g_rtia_m.amount TO FORMONLY.amount
   DISPLAY g_rtia_m.amount2 TO FORMONLY.amount2
   DISPLAY g_rtia_m.amount3 TO FORMONLY.amount3
   #end add-point
   
END FUNCTION
 
{</section>}
 
{<section id="artt622.detail_show" >}
#+ 第二階單身reference
PRIVATE FUNCTION artt622_detail_show()
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
 
{<section id="artt622.reproduce" >}
#+ 資料複製
PRIVATE FUNCTION artt622_reproduce()
   #add-point:reproduce段define(客製用) name="reproduce.define_customerization"
   
   #end add-point   
   DEFINE l_newno     LIKE rtia_t.rtiadocno 
   DEFINE l_oldno     LIKE rtia_t.rtiadocno 
 
   DEFINE l_master    RECORD LIKE rtia_t.* #此變數樣板目前無使用
   DEFINE l_detail    RECORD LIKE rtib_t.* #此變數樣板目前無使用
   DEFINE l_detail2    RECORD LIKE rtic_t.* #此變數樣板目前無使用
 
   DEFINE l_detail3    RECORD LIKE xrcd_t.* #此變數樣板目前無使用
 
   DEFINE l_detail4    RECORD LIKE rtie_t.* #此變數樣板目前無使用
 
   DEFINE l_detail5    RECORD LIKE rtik_t.* #此變數樣板目前無使用
 
   DEFINE l_detail6    RECORD LIKE rtin_t.* #此變數樣板目前無使用
 
   DEFINE l_detail7    RECORD LIKE prek_t.* #此變數樣板目前無使用
 
 
 
   DEFINE l_cnt       LIKE type_t.num10
   #add-point:reproduce段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="reproduce.define"
 
   #end add-point   
   
   #add-point:Function前置處理  name="reproduce.pre_function"
    #160514-00002#1   add(S)
   #复制已过帐单据时，单头中过账日期，异动资料页签中 资料确认者、资料确认日期、资料过账者、资料过账日期不要复制
   IF g_rtia_m.rtiastus = 'S' THEN
      LET g_rtia_m.rtia006 = ""        #过账日前
      LET g_rtia_m.rtiacnfid = ""      #资料确认者
      LET g_rtia_m.rtiacnfid_desc = "" #资料确认者带值
      LET g_rtia_m.rtiacnfdt = ""      #资料确认日期
      LET g_rtia_m.rtiapstid = ""      #资料过账者
      LET g_rtia_m.rtiapstid_desc = "" #资料过账者带值
      LET g_rtia_m.rtiapstdt = ""      #资料过账日期
   END IF
   #160514-00002#1   add(E)   
   CALL g_rtib4_d.clear()  #160519-00041#1   add   单身收款明细页签数组清空
   LET g_rtib_d[l_ac].rtib027 = ""  #160519-00041#1   add   单身商品明细页签批号清空
   CALL g_rtib6_d.clear()  #160519-00041#1   add   单身多库储批明细页签数组清空
   
   #end add-point
   
   #切換畫面
   IF g_main_hidden THEN
      CALL gfrm_curr.setElementHidden("mainlayout",0)
      CALL gfrm_curr.setElementHidden("worksheet",1)
      LET g_main_hidden = 0
   END IF
   
   LET g_master_insert = FALSE
   
   IF g_rtia_m.rtiadocno IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code = "std-00003" 
      LET g_errparam.popup = FALSE 
      CALL cl_err()
      RETURN
   END IF
    
   LET g_rtiadocno_t = g_rtia_m.rtiadocno
 
    
   LET g_rtia_m.rtiadocno = ""
 
 
   CALL cl_set_head_visible("","YES")
 
   #公用欄位給予預設值
   #應用 a14 樣板自動產生(Version:5)    
      #公用欄位新增給值  
      LET g_rtia_m.rtiaownid = g_user
      LET g_rtia_m.rtiaowndp = g_dept
      LET g_rtia_m.rtiacrtid = g_user
      LET g_rtia_m.rtiacrtdp = g_dept 
      LET g_rtia_m.rtiacrtdt = cl_get_current()
      LET g_rtia_m.rtiamodid = g_user
      LET g_rtia_m.rtiamoddt = cl_get_current()
      LET g_rtia_m.rtiastus = 'N'
 
 
 
   
   CALL s_transaction_begin()
   
   #add-point:複製輸入前 name="reproduce.head.b_input"
   LET g_rtia_m.rtiastus = 'N'
   LET g_rtia_m.rtia048 = 'N'
   LET g_rtia_m.rtia016 = 0
   LET g_rtia_m.rtiadocdt = g_today
   #end add-point
   
   #顯示狀態(stus)圖片
         #應用 a21 樣板自動產生(Version:3)
	  #根據當下狀態碼顯示圖片
      CASE g_rtia_m.rtiastus 
         WHEN "N"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/unconfirmed.png")
         WHEN "Y"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/confirmed.png")
         WHEN "S"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/posted.png")
         WHEN "Z"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/unposted.png")
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
   
   
   CALL artt622_input("r")
   
   IF INT_FLAG AND NOT g_master_insert THEN
      LET INT_FLAG = 0
      DISPLAY g_detail_cnt  TO FORMONLY.h_count    #總筆數
      DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
      LET INT_FLAG = 0
      INITIALIZE g_rtia_m.* TO NULL
      INITIALIZE g_rtib_d TO NULL
      INITIALIZE g_rtib2_d TO NULL
      INITIALIZE g_rtib3_d TO NULL
      INITIALIZE g_rtib4_d TO NULL
      INITIALIZE g_rtib5_d TO NULL
      INITIALIZE g_rtib6_d TO NULL
      INITIALIZE g_rtib7_d TO NULL
 
      #add-point:複製取消後 name="reproduce.cancel"
      
      #end add-point
      CALL artt622_show()
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
   CALL artt622_set_act_visible()   
   CALL artt622_set_act_no_visible()
   
   #將新增的資料併入搜尋條件中
   LET g_rtiadocno_t = g_rtia_m.rtiadocno
 
   
   #組合新增資料的條件
   LET g_add_browse = " rtiaent = " ||g_enterprise|| " AND",
                      " rtiadocno = '", g_rtia_m.rtiadocno, "' "
 
   #填到最後面
   LET g_current_idx = g_browser.getLength() + 1
   CALL artt622_browser_fill("")
   
   DISPLAY g_browser_cnt TO FORMONLY.h_count    #總筆數
   DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
   CALL cl_navigator_setting(g_current_idx, g_browser_cnt)
   
   #add-point:完成複製段落後 name="reproduce.after_reproduce"
   
   #end add-point
   
   CALL artt622_idx_chk()
   
   LET g_data_owner = g_rtia_m.rtiaownid      
   LET g_data_dept  = g_rtia_m.rtiaowndp
   
   #功能已完成,通報訊息中心
   CALL artt622_msgcentre_notify('reproduce')
 
END FUNCTION
 
{</section>}
 
{<section id="artt622.detail_reproduce" >}
#+ 單身自動複製
PRIVATE FUNCTION artt622_detail_reproduce()
   #add-point:delete段define(客製用) name="detail_reproduce.define_customerization"
   
   #end add-point    
   DEFINE ls_sql      STRING
   DEFINE ld_date     DATETIME YEAR TO SECOND
   DEFINE l_detail    RECORD LIKE rtib_t.* #此變數樣板目前無使用
   DEFINE l_detail2    RECORD LIKE rtic_t.* #此變數樣板目前無使用
 
   DEFINE l_detail3    RECORD LIKE xrcd_t.* #此變數樣板目前無使用
 
   DEFINE l_detail4    RECORD LIKE rtie_t.* #此變數樣板目前無使用
 
   DEFINE l_detail5    RECORD LIKE rtik_t.* #此變數樣板目前無使用
 
   DEFINE l_detail6    RECORD LIKE rtin_t.* #此變數樣板目前無使用
 
   DEFINE l_detail7    RECORD LIKE prek_t.* #此變數樣板目前無使用
 
 
 
   #add-point:delete段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="detail_reproduce.define"
   DEFINE l_rtibsite LIKE rtib_t.rtibsite
   DEFINE l_rtibdocno LIKE rtib_t.rtibdocno
   DEFINE l_rtibseq LIKE rtib_t.rtibseq
   DEFINE l_rtib004 LIKE rtib_t.rtib004 
   DEFINE l_rtib005 LIKE rtib_t.rtib005
   DEFINE l_rtib025 LIKE rtib_t.rtib025
   DEFINE l_rtib026 LIKE rtib_t.rtib026
   DEFINE l_rtib027 LIKE rtib_t.rtib027
   DEFINE l_rtib013 LIKE rtib_t.rtib013
   DEFINE l_rtib012 LIKE rtib_t.rtib012
   DEFINE l_rtib032 LIKE rtib_t.rtib032
   DEFINE l_success LIKE type_t.num5
   #end add-point    
   
   #add-point:Function前置處理  name="detail_reproduce.pre_function"
   
   #end add-point
   
   CALL s_transaction_begin()
   
   LET ld_date = cl_get_current()
   
   DROP TABLE artt622_detail
   
   #add-point:單身複製前1 name="detail_reproduce.body.table1.b_insert"
      
   #end add-point
   
   #CREATE TEMP TABLE
   SELECT * FROM rtib_t
    WHERE rtibent = g_enterprise AND rtibdocno = g_rtiadocno_t
 
    INTO TEMP artt622_detail
 
   #將key修正為調整後   
   UPDATE artt622_detail 
      #更新key欄位
      SET rtibdocno = g_rtia_m.rtiadocno
 
      #更新共用欄位
      
 
   #add-point:單身修改前 name="detail_reproduce.body.table1.b_update"
   #160519-00041#1   add(S)
   #清空临时表中商品明细页签中的批号字段
   UPDATE artt622_detail 
      SET rtib027=""
   WHERE  rtibdocno = g_rtia_m.rtiadocno
   #160519-00041#1   add(E)
   #end add-point                                       
  
   #將資料塞回原table   
   INSERT INTO rtib_t SELECT * FROM artt622_detail
   
   IF SQLCA.SQLCODE THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "reproduce:",SQLERRMESSAGE 
      LET g_errparam.code = SQLCA.SQLCODE 
      LET g_errparam.popup = TRUE 
      CALL cl_err()
      RETURN
   END IF
   
   #add-point:單身複製中1 name="detail_reproduce.body.table1.m_insert"
   #160519-00041#1   add(S)
   #更新多库儲批明細
   
      LET g_sql = " SELECT rtibsite,rtibdocno,rtibseq,rtib004,rtib005,rtib025,rtib026,rtib027,rtib013,rtib012, ",
                         " rtib032 ",
                  " FROM rtib_t ",
                  " WHERE rtibent='",g_enterprise,"' AND rtibdocno='",g_rtia_m.rtiadocno,"' "
      PREPARE artt622_sql FROM g_sql
      DECLARE b_fill_sql CURSOR FOR artt622_sql
                                               
      FOREACH b_fill_sql INTO l_rtibsite,l_rtibdocno,l_rtibseq,l_rtib004, 
          l_rtib005,l_rtib025,l_rtib026,l_rtib027,l_rtib013,l_rtib012,l_rtib032
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "FOREACH:",SQLERRMESSAGE 
            LET g_errparam.code   = SQLCA.sqlcode 
            LET g_errparam.popup  = TRUE 
            CALL cl_err()
            EXIT FOREACH
         END IF
         #调用元件更新多库儲批明細
         CALL s_artt622_rtin_modify('a',l_rtibsite,l_rtibdocno,l_rtibseq,'',l_rtib004,l_rtib005,
                                 g_prog,'',l_rtib025,l_rtib026,l_rtib027,l_rtib013,l_rtib012,l_rtib032) RETURNING l_success
         IF NOT l_success THEN            
            RETURN
         END IF
      END FOREACH
      
   #160519-00041#1   add(E)
   #end add-point
   
   #刪除TEMP TABLE
   DROP TABLE artt622_detail
   
   #add-point:單身複製後1 name="detail_reproduce.body.table1.a_insert"
      
   #end add-point
 
   #add-point:單身複製前 name="detail_reproduce.body.table2.b_insert"
      
   #end add-point
   
   #CREATE TEMP TABLE
   SELECT * FROM rtic_t 
    WHERE rticent = g_enterprise AND rticdocno = g_rtiadocno_t
 
    INTO TEMP artt622_detail
 
   #將key修正為調整後   
   UPDATE artt622_detail SET rticdocno = g_rtia_m.rtiadocno
 
  
   #add-point:單身修改前 name="detail_reproduce.body.table2.b_update"
   
   #end add-point    
 
   #將資料塞回原table   
   INSERT INTO rtic_t SELECT * FROM artt622_detail
   
   #add-point:單身複製中 name="detail_reproduce.body.table2.m_insert"
      
   #end add-point
   
   #刪除TEMP TABLE
   DROP TABLE artt622_detail
   
   #add-point:單身複製後 name="detail_reproduce.body.table2.a_insert"
      
   #end add-point
 
   #add-point:單身複製前 name="detail_reproduce.body.table3.b_insert"
      
   #end add-point
   
   #CREATE TEMP TABLE
   SELECT * FROM xrcd_t 
    WHERE xrcdent = g_enterprise AND xrcddocno = g_rtiadocno_t
 
    INTO TEMP artt622_detail
 
   #將key修正為調整後   
   UPDATE artt622_detail SET xrcddocno = g_rtia_m.rtiadocno
 
  
   #add-point:單身修改前 name="detail_reproduce.body.table3.b_update"
   
   #end add-point    
 
   #將資料塞回原table   
   INSERT INTO xrcd_t SELECT * FROM artt622_detail
   
   #add-point:單身複製中 name="detail_reproduce.body.table3.m_insert"
      
   #end add-point
   
   #刪除TEMP TABLE
   DROP TABLE artt622_detail
   
   #add-point:單身複製後 name="detail_reproduce.body.table3.a_insert"
      
   #end add-point
 
   #add-point:單身複製前 name="detail_reproduce.body.table4.b_insert"
      
   #end add-point
   
   #CREATE TEMP TABLE
   SELECT * FROM rtie_t 
    WHERE rtieent = g_enterprise AND rtiedocno = g_rtiadocno_t
 
    INTO TEMP artt622_detail
 
   #將key修正為調整後   
   UPDATE artt622_detail SET rtiedocno = g_rtia_m.rtiadocno
 
  
   #add-point:單身修改前 name="detail_reproduce.body.table4.b_update"
   DELETE FROM artt622_detail #清空临时表      #160519-00041#1   add   收款明细页签不复制
   #end add-point    
 
   #將資料塞回原table   
   INSERT INTO rtie_t SELECT * FROM artt622_detail
   
   #add-point:單身複製中 name="detail_reproduce.body.table4.m_insert"
      
   #end add-point
   
   #刪除TEMP TABLE
   DROP TABLE artt622_detail
   
   #add-point:單身複製後 name="detail_reproduce.body.table4.a_insert"

   UPDATE rtia_t SET rtia031 = (SELECT SUM(rtib021)
                                  FROM rtib_t
                                 WHERE rtibent = g_enterprise
                                   AND rtibdocno = g_rtia_m.rtiadocno),
                     rtia049 = (SELECT SUM(rtib031)
                                  FROM rtib_t
                                 WHERE rtibent = g_enterprise
                                   AND rtibdocno = g_rtia_m.rtiadocno)              
    WHERE rtiaent = g_enterprise
      AND rtiadocno = g_rtia_m.rtiadocno
    IF SQLCA.sqlcode THEN
       INITIALIZE g_errparam TO NULL
       LET g_errparam.code = SQLCA.sqlcode
       LET g_errparam.extend = "UPD rtia_t"
       LET g_errparam.popup = TRUE
       CALL cl_err()
 
       RETURN
    END IF

   #end add-point
 
   #add-point:單身複製前 name="detail_reproduce.body.table5.b_insert"
      
   #end add-point
   
   #CREATE TEMP TABLE
   SELECT * FROM rtik_t 
    WHERE rtikent = g_enterprise AND rtikdocno = g_rtiadocno_t
 
    INTO TEMP artt622_detail
 
   #將key修正為調整後   
   UPDATE artt622_detail SET rtikdocno = g_rtia_m.rtiadocno
 
  
   #add-point:單身修改前 name="detail_reproduce.body.table5.b_update"
   
   #end add-point    
 
   #將資料塞回原table   
   INSERT INTO rtik_t SELECT * FROM artt622_detail
   
   #add-point:單身複製中 name="detail_reproduce.body.table5.m_insert"
      
   #end add-point
   
   #刪除TEMP TABLE
   DROP TABLE artt622_detail
   
   #add-point:單身複製後 name="detail_reproduce.body.table5.a_insert"
      
   #end add-point
 
   #add-point:單身複製前 name="detail_reproduce.body.table6.b_insert"
      
   #end add-point
   
   #CREATE TEMP TABLE
   SELECT * FROM rtin_t 
    WHERE rtinent = g_enterprise AND rtindocno = g_rtiadocno_t
 
    INTO TEMP artt622_detail
 
   #將key修正為調整後   
   UPDATE artt622_detail SET rtindocno = g_rtia_m.rtiadocno
 
  
   #add-point:單身修改前 name="detail_reproduce.body.table6.b_update"
   DELETE FROM artt622_detail #清空临时表      #160519-00041#1   add
   #end add-point    
 
   #將資料塞回原table   
   INSERT INTO rtin_t SELECT * FROM artt622_detail
   
   #add-point:單身複製中 name="detail_reproduce.body.table6.m_insert"
      
   #end add-point
   
   #刪除TEMP TABLE
   DROP TABLE artt622_detail
   
   #add-point:單身複製後 name="detail_reproduce.body.table6.a_insert"
      
   #end add-point
 
   #add-point:單身複製前 name="detail_reproduce.body.table7.b_insert"
      
   #end add-point
   
   #CREATE TEMP TABLE
   SELECT * FROM prek_t 
    WHERE prekent = g_enterprise AND prekdocno = g_rtiadocno_t
 
    INTO TEMP artt622_detail
 
   #將key修正為調整後   
   UPDATE artt622_detail SET prekdocno = g_rtia_m.rtiadocno
 
  
   #add-point:單身修改前 name="detail_reproduce.body.table7.b_update"
   
   #end add-point    
 
   #將資料塞回原table   
   INSERT INTO prek_t SELECT * FROM artt622_detail
   
   #add-point:單身複製中 name="detail_reproduce.body.table7.m_insert"
      
   #end add-point
   
   #刪除TEMP TABLE
   DROP TABLE artt622_detail
   
   #add-point:單身複製後 name="detail_reproduce.body.table7.a_insert"
      
   #end add-point
 
 
   
 
   
   #多語言複製段落
   
   
   CALL s_transaction_end('Y','0')
   
   #已新增完, 調整資料內容(修改時使用)
   LET g_rtiadocno_t = g_rtia_m.rtiadocno
 
   
END FUNCTION
 
{</section>}
 
{<section id="artt622.delete" >}
#+ 資料刪除
PRIVATE FUNCTION artt622_delete()
   #add-point:delete段define(客製用) name="delete.define_customerization"
   
   #end add-point     
   DEFINE  l_var_keys      DYNAMIC ARRAY OF STRING
   DEFINE  l_field_keys    DYNAMIC ARRAY OF STRING
   DEFINE  l_vars          DYNAMIC ARRAY OF STRING
   DEFINE  l_fields        DYNAMIC ARRAY OF STRING
   DEFINE  l_var_keys_bak  DYNAMIC ARRAY OF STRING
   #add-point:delete段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="delete.define"
   IF g_rtia_m.rtia048 = 'Y' THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = "art-00374"
      LET g_errparam.extend = ""
      LET g_errparam.popup = FALSE
      CALL cl_err()

      RETURN 
   END IF 
   #end add-point     
   
   #add-point:Function前置處理  name="delete.pre_function"
   
   #end add-point
   
   IF g_rtia_m.rtiadocno IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code = "std-00003" 
      LET g_errparam.popup = FALSE 
      CALL cl_err()
      RETURN
   END IF
   
   
   
   CALL s_transaction_begin()
 
   OPEN artt622_cl USING g_enterprise,g_rtia_m.rtiadocno
   IF SQLCA.SQLCODE THEN   #(ver:78)
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "OPEN artt622_cl:",SQLERRMESSAGE 
      LET g_errparam.code = SQLCA.SQLCODE   #(ver:78)
      LET g_errparam.popup = TRUE 
      CLOSE artt622_cl
      CALL s_transaction_end('N','0')
      CALL cl_err()
      RETURN
   END IF
 
   #顯示最新的資料
   EXECUTE artt622_master_referesh USING g_rtia_m.rtiadocno INTO g_rtia_m.rtiasite,g_rtia_m.rtiadocdt, 
       g_rtia_m.rtiadocno,g_rtia_m.rtia002,g_rtia_m.rtia001,g_rtia_m.rtia059,g_rtia_m.rtia060,g_rtia_m.rtia004, 
       g_rtia_m.rtia005,g_rtia_m.rtia006,g_rtia_m.rtia048,g_rtia_m.rtia053,g_rtia_m.rtiastus,g_rtia_m.rtia007, 
       g_rtia_m.rtia008,g_rtia_m.rtia009,g_rtia_m.rtia043,g_rtia_m.rtia047,g_rtia_m.rtia013,g_rtia_m.rtia014, 
       g_rtia_m.rtia015,g_rtia_m.rtia016,g_rtia_m.rtia051,g_rtia_m.rtia010,g_rtia_m.rtia011,g_rtia_m.rtia012, 
       g_rtia_m.rtia041,g_rtia_m.rtia017,g_rtia_m.rtia018,g_rtia_m.rtia019,g_rtia_m.rtia020,g_rtia_m.rtia021, 
       g_rtia_m.rtia022,g_rtia_m.rtia023,g_rtia_m.rtia024,g_rtia_m.rtia025,g_rtia_m.rtia026,g_rtia_m.rtia027, 
       g_rtia_m.rtia028,g_rtia_m.rtia029,g_rtia_m.rtia030,g_rtia_m.rtia032,g_rtia_m.rtia033,g_rtia_m.rtia034, 
       g_rtia_m.rtia035,g_rtia_m.rtia036,g_rtia_m.rtia037,g_rtia_m.rtia038,g_rtia_m.rtia039,g_rtia_m.rtia107, 
       g_rtia_m.rtiaownid,g_rtia_m.rtiacrtid,g_rtia_m.rtiaowndp,g_rtia_m.rtiacrtdp,g_rtia_m.rtiacrtdt, 
       g_rtia_m.rtiamodid,g_rtia_m.rtiamoddt,g_rtia_m.rtiacnfid,g_rtia_m.rtiacnfdt,g_rtia_m.rtiapstid, 
       g_rtia_m.rtiapstdt,g_rtia_m.rtiasite_desc,g_rtia_m.rtia002_desc,g_rtia_m.rtia004_desc,g_rtia_m.rtia005_desc, 
       g_rtia_m.rtia009_desc,g_rtia_m.rtia010_desc,g_rtia_m.rtia011_desc,g_rtia_m.rtia012_desc,g_rtia_m.rtia018_desc, 
       g_rtia_m.rtia024_desc,g_rtia_m.rtia025_desc,g_rtia_m.rtia036_desc,g_rtia_m.rtia037_desc,g_rtia_m.rtia038_desc, 
       g_rtia_m.rtiaownid_desc,g_rtia_m.rtiacrtid_desc,g_rtia_m.rtiaowndp_desc,g_rtia_m.rtiacrtdp_desc, 
       g_rtia_m.rtiamodid_desc,g_rtia_m.rtiacnfid_desc,g_rtia_m.rtiapstid_desc
   
   
   #檢查是否允許此動作
   IF NOT artt622_action_chk() THEN
      CALL s_transaction_end('N','0')
      RETURN
   END IF
   
   #遮罩相關處理
   LET g_rtia_m_mask_o.* =  g_rtia_m.*
   CALL artt622_rtia_t_mask()
   LET g_rtia_m_mask_n.* =  g_rtia_m.*
   
   CALL artt622_show()
   
   #add-point:delete段before ask name="delete.before_ask"
   
   #end add-point 
 
   IF cl_ask_del_master() THEN              #確認一下
   
      #add-point:單頭刪除前 name="delete.head.b_delete"
            
      #end add-point   
      
      #應用 a47 樣板自動產生(Version:4)
      #刪除相關文件
      CALL artt622_set_pk_array()
      #add-point:相關文件刪除前 name="delete.befroe.related_document_remove"
      
      #end add-point   
      CALL cl_doc_remove()  
 
 
 
  
  
      #資料備份
      LET g_rtiadocno_t = g_rtia_m.rtiadocno
 
 
      DELETE FROM rtia_t
       WHERE rtiaent = g_enterprise AND rtiadocno = g_rtia_m.rtiadocno
 
       
      #add-point:單頭刪除中 name="delete.head.m_delete"
            
      #end add-point
       
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = g_rtia_m.rtiadocno,":",SQLERRMESSAGE  
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = FALSE 
         CALL s_transaction_end('N','0')
         CALL cl_err()
         RETURN
      END IF
      
      #add-point:單頭刪除後 name="delete.head.a_delete"
#add by yangxf ---start----
      IF NOT s_aooi200_del_docno(g_rtia_m.rtiadocno,g_rtia_m.rtiadocdt) THEN
         CALL s_transaction_end('N','0')
         RETURN
      END IF
#add by yangxf ----end-----
      #end add-point
  
      #add-point:單身刪除前 name="delete.body.b_delete"
      #删除收款资料
      DELETE FROM rtif_t
       WHERE rtifent = g_enterprise
         AND rtifdocno = g_rtia_m.rtiadocno
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = g_rtia_m.rtiadocno
         LET g_errparam.popup = FALSE
         CALL cl_err()
 
         CALL s_transaction_end('N','0')
         RETURN
      END IF      
      #end add-point
      
      DELETE FROM rtib_t
       WHERE rtibent = g_enterprise AND rtibdocno = g_rtia_m.rtiadocno
 
 
      #add-point:單身刪除中 name="delete.body.m_delete"
      let g_chantype='1'       
      #end add-point
         
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "rtib_t:",SQLERRMESSAGE 
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
      DELETE FROM rtic_t
       WHERE rticent = g_enterprise AND
             rticdocno = g_rtia_m.rtiadocno
      #add-point:單身刪除中 name="delete.body.m_delete2"
            
      #end add-point
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "rtic_t:",SQLERRMESSAGE 
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
             xrcddocno = g_rtia_m.rtiadocno
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
 
      #add-point:單身刪除前 name="delete.body.b_delete4"
            
      #end add-point
      DELETE FROM rtie_t
       WHERE rtieent = g_enterprise AND
             rtiedocno = g_rtia_m.rtiadocno
      #add-point:單身刪除中 name="delete.body.m_delete4"
            
      #end add-point
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "rtie_t:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = FALSE 
         CALL s_transaction_end('N','0')
         CALL cl_err()
         RETURN
      END IF      
 
      #add-point:單身刪除後 name="delete.body.a_delete4"
            
      #end add-point
 
      #add-point:單身刪除前 name="delete.body.b_delete5"
            
      #end add-point
      DELETE FROM rtik_t
       WHERE rtikent = g_enterprise AND
             rtikdocno = g_rtia_m.rtiadocno
      #add-point:單身刪除中 name="delete.body.m_delete5"
            
      #end add-point
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "rtik_t:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = FALSE 
         CALL s_transaction_end('N','0')
         CALL cl_err()
         RETURN
      END IF      
 
      #add-point:單身刪除後 name="delete.body.a_delete5"
            
      #end add-point
 
      #add-point:單身刪除前 name="delete.body.b_delete6"
            
      #end add-point
      DELETE FROM rtin_t
       WHERE rtinent = g_enterprise AND
             rtindocno = g_rtia_m.rtiadocno
      #add-point:單身刪除中 name="delete.body.m_delete6"
            
      #end add-point
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "rtin_t:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = FALSE 
         CALL s_transaction_end('N','0')
         CALL cl_err()
         RETURN
      END IF      
 
      #add-point:單身刪除後 name="delete.body.a_delete6"
            
      #end add-point
 
      #add-point:單身刪除前 name="delete.body.b_delete7"
            
      #end add-point
      DELETE FROM prek_t
       WHERE prekent = g_enterprise AND
             prekdocno = g_rtia_m.rtiadocno
      #add-point:單身刪除中 name="delete.body.m_delete7"
            
      #end add-point
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "prek_t:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = FALSE 
         CALL s_transaction_end('N','0')
         CALL cl_err()
         RETURN
      END IF      
 
      #add-point:單身刪除後 name="delete.body.a_delete7"
            
      #end add-point
 
 
 
 
      
      #修改歷程記錄(刪除)
      LET g_log1 = util.JSON.stringify(g_rtia_m)   #(ver:78)
      IF NOT cl_log_modified_record(g_log1,'') THEN    #(ver:78)
         CLOSE artt622_cl
         CALL s_transaction_end('N','0')
         RETURN
      END IF
             
      CLEAR FORM
      CALL g_rtib_d.clear() 
      CALL g_rtib2_d.clear()       
      CALL g_rtib3_d.clear()       
      CALL g_rtib4_d.clear()       
      CALL g_rtib5_d.clear()       
      CALL g_rtib6_d.clear()       
      CALL g_rtib7_d.clear()       
 
     
      CALL artt622_ui_browser_refresh()  
      #CALL artt622_ui_headershow()  
      #CALL artt622_ui_detailshow()
 
      #add-point:多語言刪除 name="delete.lang.before_delete"
      
      #end add-point
      
      #單頭多語言刪除
      
      
      #單身多語言刪除
      
      
      
      
      
      
      
 
   
      #add-point:多語言刪除 name="delete.lang.delete"
      
      #end add-point
      
      IF g_browser_cnt > 0 THEN 
         #CALL artt622_browser_fill("")
         CALL artt622_fetch('P')
         DISPLAY g_browser_cnt TO FORMONLY.h_count   #總筆數的顯示
         DISPLAY g_browser_cnt TO FORMONLY.b_count   #總筆數的顯示
      ELSE
         CLEAR FORM
      END IF
      
      CALL s_transaction_end('Y','0')
   ELSE
      CALL s_transaction_end('N','0')
   END IF
 
   CLOSE artt622_cl
 
   #功能已完成,通報訊息中心
   CALL artt622_msgcentre_notify('delete')
    
END FUNCTION
 
{</section>}
 
{<section id="artt622.b_fill" >}
#+ 單身陣列填充
PRIVATE FUNCTION artt622_b_fill()
   #add-point:b_fill段define(客製用) name="b_fill.define_customerization"
   
   #end add-point     
   DEFINE p_wc2      STRING
   DEFINE li_idx     LIKE type_t.num10
   #add-point:b_fill段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="b_fill.define"
      
   #end add-point     
   
   #add-point:Function前置處理  name="b_fill.pre_function"
   
   #end add-point
   
   #清空第一階單身
   CALL g_rtib_d.clear()
   CALL g_rtib2_d.clear()
   CALL g_rtib3_d.clear()
   CALL g_rtib4_d.clear()
   CALL g_rtib5_d.clear()
   CALL g_rtib6_d.clear()
   CALL g_rtib7_d.clear()
 
 
   #add-point:b_fill段sql_before name="b_fill.sql_before"
      
   #end add-point
   
   #判斷是否填充
   IF artt622_fill_chk(1) THEN
      #切換上下筆時不重組SQL
      IF (g_action_choice = "query" OR cl_null(g_action_choice))
      #add-point:b_fill段long_sql_if name="b_fill.long_sql_if"
      
      #end add-point
      THEN
         LET g_sql = "SELECT  DISTINCT rtibsite,rtibunit,rtiborga,rtibseq,rtib035,rtib042,rtib001,rtib002, 
             rtib003,rtib004,rtib005,rtib106,rtib012,rtib108,rtib013,rtib107,rtib008,rtib009,rtib010, 
             rtib014,rtib015,rtib016,rtib018,rtib017,rtib019,rtib020,rtib021,rtib031,rtib022,rtib024, 
             rtib025,rtib026,rtib027,rtib032,rtib033,rtib028,rtib030,rtib039,rtib006 ,t1.imaal003 ,t2.imaal004 , 
             t3.oocal003 ,t4.oocal003 ,t5.oocql004 ,t6.inayl003 ,t7.pcab003 FROM rtib_t",   
                     " INNER JOIN rtia_t ON rtiaent = " ||g_enterprise|| " AND rtiadocno = rtibdocno ",
 
                     #"",
                     
                     "",
                     #下層單身所需的join條件
 
                                    " LEFT JOIN imaal_t t1 ON t1.imaalent="||g_enterprise||" AND t1.imaal001=rtib004 AND t1.imaal002='"||g_dlang||"' ",
               " LEFT JOIN imaal_t t2 ON t2.imaalent="||g_enterprise||" AND t2.imaal001=rtib004 AND t2.imaal002='"||g_dlang||"' ",
               " LEFT JOIN oocal_t t3 ON t3.oocalent="||g_enterprise||" AND t3.oocal001=rtib013 AND t3.oocal002='"||g_dlang||"' ",
               " LEFT JOIN oocal_t t4 ON t4.oocalent="||g_enterprise||" AND t4.oocal001=rtib018 AND t4.oocal002='"||g_dlang||"' ",
               " LEFT JOIN oocql_t t5 ON t5.oocqlent="||g_enterprise||" AND t5.oocql001='295' AND t5.oocql002=rtib024 AND t5.oocql003='"||g_dlang||"' ",
               " LEFT JOIN inayl_t t6 ON t6.inaylent="||g_enterprise||" AND t6.inayl001=rtib025 AND t6.inayl002='"||g_dlang||"' ",
               " LEFT JOIN pcab_t t7 ON t7.pcabent="||g_enterprise||" AND t7.pcab001=rtib033  ",
 
                     " WHERE rtibent=? AND rtibdocno=?"
         LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
         #add-point:b_fill段sql_before name="b_fill.body.fill_sql"
 
         #end add-point
         IF NOT cl_null(g_wc2_table1) THEN
            LET g_sql = g_sql CLIPPED, " AND ", g_wc2_table1 CLIPPED
         END IF
         
         #子單身的WC
         
         
         LET g_sql = g_sql, " ORDER BY rtib_t.rtibseq"
         
         #add-point:單身填充控制 name="b_fill.sql"
 
         #end add-point
         
         LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
         PREPARE artt622_pb FROM g_sql
         DECLARE b_fill_cs CURSOR FOR artt622_pb
      END IF
      
      LET g_cnt = l_ac
      LET l_ac = 1
      
   #  OPEN b_fill_cs USING g_enterprise,g_rtia_m.rtiadocno   #(ver:78)
                                               
      FOREACH b_fill_cs USING g_enterprise,g_rtia_m.rtiadocno INTO g_rtib_d[l_ac].rtibsite,g_rtib_d[l_ac].rtibunit, 
          g_rtib_d[l_ac].rtiborga,g_rtib_d[l_ac].rtibseq,g_rtib_d[l_ac].rtib035,g_rtib_d[l_ac].rtib042, 
          g_rtib_d[l_ac].rtib001,g_rtib_d[l_ac].rtib002,g_rtib_d[l_ac].rtib003,g_rtib_d[l_ac].rtib004, 
          g_rtib_d[l_ac].rtib005,g_rtib_d[l_ac].rtib106,g_rtib_d[l_ac].rtib012,g_rtib_d[l_ac].rtib108, 
          g_rtib_d[l_ac].rtib013,g_rtib_d[l_ac].rtib107,g_rtib_d[l_ac].rtib008,g_rtib_d[l_ac].rtib009, 
          g_rtib_d[l_ac].rtib010,g_rtib_d[l_ac].rtib014,g_rtib_d[l_ac].rtib015,g_rtib_d[l_ac].rtib016, 
          g_rtib_d[l_ac].rtib018,g_rtib_d[l_ac].rtib017,g_rtib_d[l_ac].rtib019,g_rtib_d[l_ac].rtib020, 
          g_rtib_d[l_ac].rtib021,g_rtib_d[l_ac].rtib031,g_rtib_d[l_ac].rtib022,g_rtib_d[l_ac].rtib024, 
          g_rtib_d[l_ac].rtib025,g_rtib_d[l_ac].rtib026,g_rtib_d[l_ac].rtib027,g_rtib_d[l_ac].rtib032, 
          g_rtib_d[l_ac].rtib033,g_rtib_d[l_ac].rtib028,g_rtib_d[l_ac].rtib030,g_rtib_d[l_ac].rtib039, 
          g_rtib_d[l_ac].rtib006,g_rtib_d[l_ac].rtib004_desc,g_rtib_d[l_ac].rtib004_desc_desc,g_rtib_d[l_ac].rtib013_desc, 
          g_rtib_d[l_ac].rtib018_desc,g_rtib_d[l_ac].rtib024_desc,g_rtib_d[l_ac].rtib025_desc,g_rtib_d[l_ac].rtib033_desc  
            #(ver:78)
         IF SQLCA.SQLCODE THEN
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "FOREACH:",SQLERRMESSAGE 
            LET g_errparam.code = SQLCA.SQLCODE 
            LET g_errparam.popup = TRUE 
            CALL cl_err()
            EXIT FOREACH
         END IF
        
         #add-point:b_fill段資料填充 name="b_fill.fill"
         #150424-00020#2--mark by dongsz--str---
#         SELECT xmda001 INTO g_rtib_d[l_ac].xmda001
#           FROM xmda_t
#          WHERE xmdaent = g_enterprise
#            AND xmdadocno = g_rtib_d[l_ac].rtib001
         #150424-00020#2--mark by dongsz--end---
        #add by yangxf ----start----
        IF g_prog = 'artt700' THEN 
           LET g_rtib_d[l_ac].rtib012 = g_rtib_d[l_ac].rtib012*(-1)
           LET g_rtib_d[l_ac].rtib017 = g_rtib_d[l_ac].rtib017*(-1)
           LET g_rtib_d[l_ac].rtib020 = g_rtib_d[l_ac].rtib020*(-1)
           LET g_rtib_d[l_ac].rtib021 = g_rtib_d[l_ac].rtib021*(-1)
           LET g_rtib_d[l_ac].rtib022 = g_rtib_d[l_ac].rtib022*(-1)
           LET g_rtib_d[l_ac].rtib031 = g_rtib_d[l_ac].rtib031*(-1)
        END IF 
        IF g_prog = 'artt620' or g_prog = 'artt622' THEN 
           SELECT SUM(inag008) INTO g_rtib_d[l_ac].inag008
             FROM inag_t
            WHERE inagent = g_enterprise
              AND inagsite = g_rtia_m.rtiasite
              AND inag001 = g_rtib_d[l_ac].rtib004
        END IF 
        #add by yangxf -----end-----
         SELECT oodbl004 INTO g_rtib_d[l_ac].rtib006_desc 
           FROM oodbl_t,ooef_t
          WHERE oodblent = ooefent
           AND ooefent = g_enterprise
           AND ooef001 = g_rtia_m.rtiasite
           AND oodbl001 = ooef019
           AND oodbl002 = g_rtib_d[l_ac].rtib006
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
   IF artt622_fill_chk(2) THEN
      IF (g_action_choice = "query" OR cl_null(g_action_choice))
         #add-point:b_fill段long_sql_if name="b_fill.body2.long_sql_if"
         
         #end add-point
      THEN
         LET g_sql = "SELECT  DISTINCT rticseq,rticseq1,rtic001,rtic002,rtic003,rtic004,rtic005,rtic006, 
             rtic007,rtic008,rtic009,rtic010,rtic011,rtic012,rtic013,rtic014,rtic015,rtic016,rtic017, 
             rtic018,rtic020  FROM rtic_t",   
                     " INNER JOIN  rtia_t ON rtiaent = " ||g_enterprise|| " AND rtiadocno = rticdocno ",
 
                     "",
                     
                     
                     " WHERE rticent=? AND rticdocno=?"   
         LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
         #add-point:b_fill段fill_sql name="b_fill.body2.fill_sql"
            
         #end add-point
         IF NOT cl_null(g_wc2_table2) THEN
            LET g_sql = g_sql CLIPPED," AND ",g_wc2_table2 CLIPPED
         END IF
         
         #子單身的WC
         
         
         LET g_sql = g_sql, " ORDER BY rtic_t.rticseq,rtic_t.rticseq1"
         
         #add-point:單身填充控制 name="b_fill.sql2"
            
         #end add-point
         
         LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
         PREPARE artt622_pb2 FROM g_sql
         DECLARE b_fill_cs2 CURSOR FOR artt622_pb2
      END IF
    
      LET l_ac = 1
      
   #  OPEN b_fill_cs2 USING g_enterprise,g_rtia_m.rtiadocno   #(ver:78)
                                               
      FOREACH b_fill_cs2 USING g_enterprise,g_rtia_m.rtiadocno INTO g_rtib2_d[l_ac].rticseq,g_rtib2_d[l_ac].rticseq1, 
          g_rtib2_d[l_ac].rtic001,g_rtib2_d[l_ac].rtic002,g_rtib2_d[l_ac].rtic003,g_rtib2_d[l_ac].rtic004, 
          g_rtib2_d[l_ac].rtic005,g_rtib2_d[l_ac].rtic006,g_rtib2_d[l_ac].rtic007,g_rtib2_d[l_ac].rtic008, 
          g_rtib2_d[l_ac].rtic009,g_rtib2_d[l_ac].rtic010,g_rtib2_d[l_ac].rtic011,g_rtib2_d[l_ac].rtic012, 
          g_rtib2_d[l_ac].rtic013,g_rtib2_d[l_ac].rtic014,g_rtib2_d[l_ac].rtic015,g_rtib2_d[l_ac].rtic016, 
          g_rtib2_d[l_ac].rtic017,g_rtib2_d[l_ac].rtic018,g_rtib2_d[l_ac].rtic020   #(ver:78)
         IF SQLCA.SQLCODE THEN
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "FOREACH:",SQLERRMESSAGE 
            LET g_errparam.code = SQLCA.SQLCODE 
            LET g_errparam.popup = TRUE 
            CALL cl_err()
            EXIT FOREACH
         END IF
        
         #add-point:b_fill段資料填充 name="b_fill2.fill"
         SELECT rtib003,rtib004,imaal003,imaal004,rtib013,rtib012,rtib008,rtib010,rtib021
           INTO g_rtib2_d[l_ac].rtib003,g_rtib2_d[l_ac].rtib004,g_rtib2_d[l_ac].imaal003,
                g_rtib2_d[l_ac].imaal004,g_rtib2_d[l_ac].rtib013,g_rtib2_d[l_ac].rtib012, 
                g_rtib2_d[l_ac].rtib008,g_rtib2_d[l_ac].rtib010,g_rtib2_d[l_ac].rtib021
           FROM rtib_t LEFT JOIN imaal_t ON imaalent = g_enterprise AND imaal001 = rtib004 AND imaal002 = g_dlang
          WHERE rtibseq = g_rtib2_d[l_ac].rticseq
            AND rtibent = g_enterprise
            AND rtibdocno = g_rtia_m.rtiadocno
         INITIALIZE g_ref_fields TO NULL
         LET g_ref_fields[1] = g_rtib2_d[l_ac].rtib013
         CALL ap_ref_array2(g_ref_fields,"SELECT oocal003 FROM oocal_t WHERE oocalent='"||g_enterprise||"' AND oocal001=? AND oocal002='"||g_dlang||"'","") RETURNING g_rtn_fields
         LET g_rtib2_d[l_ac].rtib013_01_desc = '', g_rtn_fields[1] , ''
        #add by yangxf ----start----
        IF g_prog = 'artt700' THEN 
           LET g_rtib2_d[l_ac].rtic008 = g_rtib2_d[l_ac].rtic008*(-1)
           LET g_rtib2_d[l_ac].rtic009 = g_rtib2_d[l_ac].rtic009*(-1)
           LET g_rtib2_d[l_ac].rtic013 = g_rtib2_d[l_ac].rtic013*(-1)
           LET g_rtib2_d[l_ac].rtib012 = g_rtib2_d[l_ac].rtib012*(-1)
           LET g_rtib2_d[l_ac].rtib021 = g_rtib2_d[l_ac].rtib021*(-1)
        END IF 
        #add by yangxf -----end-----
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
   IF artt622_fill_chk(3) THEN
      IF (g_action_choice = "query" OR cl_null(g_action_choice))
         #add-point:b_fill段long_sql_if name="b_fill.body3.long_sql_if"
         
         #end add-point
      THEN
         LET g_sql = "SELECT  DISTINCT xrcd007,xrcdld,xrcdseq,xrcdseq2,xrcd002,xrcd003,xrcd006,xrcd004, 
             xrcd104  FROM xrcd_t",   
                     " INNER JOIN  rtia_t ON rtiaent = " ||g_enterprise|| " AND rtiadocno = xrcddocno ",
 
                     "",
                     
                     
                     " WHERE xrcdent=? AND xrcddocno=?"   
         LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
         #add-point:b_fill段fill_sql name="b_fill.body3.fill_sql"
            
         #end add-point
         IF NOT cl_null(g_wc2_table3) THEN
            LET g_sql = g_sql CLIPPED," AND ",g_wc2_table3 CLIPPED
         END IF
         
         #子單身的WC
         
         
         LET g_sql = g_sql, " ORDER BY xrcd_t.xrcdld,xrcd_t.xrcdseq,xrcd_t.xrcdseq2,xrcd_t.xrcd007"
         
         #add-point:單身填充控制 name="b_fill.sql3"
            
         #end add-point
         
         LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
         PREPARE artt622_pb3 FROM g_sql
         DECLARE b_fill_cs3 CURSOR FOR artt622_pb3
      END IF
    
      LET l_ac = 1
      
   #  OPEN b_fill_cs3 USING g_enterprise,g_rtia_m.rtiadocno   #(ver:78)
                                               
      FOREACH b_fill_cs3 USING g_enterprise,g_rtia_m.rtiadocno INTO g_rtib3_d[l_ac].xrcd007,g_rtib3_d[l_ac].xrcdld, 
          g_rtib3_d[l_ac].xrcdseq,g_rtib3_d[l_ac].xrcdseq2,g_rtib3_d[l_ac].xrcd002,g_rtib3_d[l_ac].xrcd003, 
          g_rtib3_d[l_ac].xrcd006,g_rtib3_d[l_ac].xrcd004,g_rtib3_d[l_ac].xrcd104   #(ver:78)
         IF SQLCA.SQLCODE THEN
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "FOREACH:",SQLERRMESSAGE 
            LET g_errparam.code = SQLCA.SQLCODE 
            LET g_errparam.popup = TRUE 
            CALL cl_err()
            EXIT FOREACH
         END IF
        
         #add-point:b_fill段資料填充 name="b_fill3.fill"
         SELECT rtib003,rtib004,rtib006
           INTO g_rtib3_d[l_ac].rtib003,g_rtib3_d[l_ac].rtib004,g_rtib3_d[l_ac].rtib006
           FROM rtib_t
          WHERE rtibseq = g_rtib3_d[l_ac].xrcdseq
            AND rtibent = g_enterprise
            AND rtibdocno = g_rtia_m.rtiadocno

         SELECT oodbl004 INTO g_rtib3_d[l_ac].xrcd002_desc 
           FROM oodbl_t,ooef_t
          WHERE oodblent = ooefent
           AND ooefent = g_enterprise
           AND ooef001 = g_rtia_m.rtiasite
           AND oodbl001 = ooef019
           AND oodbl002 = g_rtib3_d[l_ac].xrcd002
           
         SELECT oodbl004 INTO g_rtib3_d[l_ac].rtib006_02_desc 
           FROM oodbl_t,ooef_t
          WHERE oodblent = ooefent
           AND ooefent = g_enterprise
           AND ooef001 = g_rtia_m.rtiasite
           AND oodbl001 = ooef019
           AND oodbl002 = g_rtib3_d[l_ac].rtib006
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
   IF artt622_fill_chk(4) THEN
      IF (g_action_choice = "query" OR cl_null(g_action_choice))
         #add-point:b_fill段long_sql_if name="b_fill.body4.long_sql_if"
         
         #end add-point
      THEN
         LET g_sql = "SELECT  DISTINCT rtieseq,rtieseq1,rtie001,rtie002,rtie006 ,t8.ooial003 FROM rtie_t", 
                
                     " INNER JOIN  rtia_t ON rtiaent = " ||g_enterprise|| " AND rtiadocno = rtiedocno ",
 
                     "",
                     
                                    " LEFT JOIN ooial_t t8 ON t8.ooialent="||g_enterprise||" AND t8.ooial001=rtie002 AND t8.ooial002='"||g_dlang||"' ",
 
                     " WHERE rtieent=? AND rtiedocno=?"   
         LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
         #add-point:b_fill段fill_sql name="b_fill.body4.fill_sql"
            
         #end add-point
         IF NOT cl_null(g_wc2_table4) THEN
            LET g_sql = g_sql CLIPPED," AND ",g_wc2_table4 CLIPPED
         END IF
         
         #子單身的WC
         
         
         LET g_sql = g_sql, " ORDER BY rtie_t.rtieseq,rtie_t.rtieseq1"
         
         #add-point:單身填充控制 name="b_fill.sql4"
            
         #end add-point
         
         LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
         PREPARE artt622_pb4 FROM g_sql
         DECLARE b_fill_cs4 CURSOR FOR artt622_pb4
      END IF
    
      LET l_ac = 1
      
   #  OPEN b_fill_cs4 USING g_enterprise,g_rtia_m.rtiadocno   #(ver:78)
                                               
      FOREACH b_fill_cs4 USING g_enterprise,g_rtia_m.rtiadocno INTO g_rtib4_d[l_ac].rtieseq,g_rtib4_d[l_ac].rtieseq1, 
          g_rtib4_d[l_ac].rtie001,g_rtib4_d[l_ac].rtie002,g_rtib4_d[l_ac].rtie006,g_rtib4_d[l_ac].rtie002_desc  
            #(ver:78)
         IF SQLCA.SQLCODE THEN
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "FOREACH:",SQLERRMESSAGE 
            LET g_errparam.code = SQLCA.SQLCODE 
            LET g_errparam.popup = TRUE 
            CALL cl_err()
            EXIT FOREACH
         END IF
        
         #add-point:b_fill段資料填充 name="b_fill4.fill"
                           SELECT rtib003,rtib004
           INTO g_rtib4_d[l_ac].rtib003,g_rtib4_d[l_ac].rtib004
           FROM rtib_t
          WHERE rtibseq = g_rtib4_d[l_ac].rtieseq
            AND rtibent = g_enterprise
            AND rtibdocno = g_rtia_m.rtiadocno
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
   IF artt622_fill_chk(5) THEN
      IF (g_action_choice = "query" OR cl_null(g_action_choice))
         #add-point:b_fill段long_sql_if name="b_fill.body5.long_sql_if"
         
         #end add-point
      THEN
         LET g_sql = "SELECT  DISTINCT rtiksite,rtikunit,rtikorg,rtikseq,rtik001,rtik002,rtik003,rtik004, 
             rtik005,rtik006,rtik007,rtik013,rtik012,rtik008,rtik009,rtik010,rtik011,rtik014,rtik015, 
             rtik016,rtik017,rtik018,rtik019,rtik020,rtik021,rtik022,rtik023 ,t9.prbo005 ,t10.oocal003 , 
             t11.inayl003 ,t12.inab003 FROM rtik_t",   
                     " INNER JOIN  rtia_t ON rtiaent = " ||g_enterprise|| " AND rtiadocno = rtikdocno ",
 
                     "",
                     
                                    " LEFT JOIN prbo_t t9 ON t9.prboent="||g_enterprise||" AND t9.prbo004=rtik003  ",
               " LEFT JOIN oocal_t t10 ON t10.oocalent="||g_enterprise||" AND t10.oocal001=rtik013 AND t10.oocal002='"||g_dlang||"' ",
               " LEFT JOIN inayl_t t11 ON t11.inaylent="||g_enterprise||" AND t11.inayl001=rtik019 AND t11.inayl002='"||g_dlang||"' ",
               " LEFT JOIN inab_t t12 ON t12.inabent="||g_enterprise||" AND t12.inabsite=rtiksite AND t12.inab001=rtik019 AND t12.inab002=rtik020  ",
 
                     " WHERE rtikent=? AND rtikdocno=?"   
         LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
         #add-point:b_fill段fill_sql name="b_fill.body5.fill_sql"
            
         #end add-point
         IF NOT cl_null(g_wc2_table5) THEN
            LET g_sql = g_sql CLIPPED," AND ",g_wc2_table5 CLIPPED
         END IF
         
         #子單身的WC
         
         
         LET g_sql = g_sql, " ORDER BY rtik_t.rtikseq"
         
         #add-point:單身填充控制 name="b_fill.sql5"
            
         #end add-point
         
         LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
         PREPARE artt622_pb5 FROM g_sql
         DECLARE b_fill_cs5 CURSOR FOR artt622_pb5
      END IF
    
      LET l_ac = 1
      
   #  OPEN b_fill_cs5 USING g_enterprise,g_rtia_m.rtiadocno   #(ver:78)
                                               
      FOREACH b_fill_cs5 USING g_enterprise,g_rtia_m.rtiadocno INTO g_rtib5_d[l_ac].rtiksite,g_rtib5_d[l_ac].rtikunit, 
          g_rtib5_d[l_ac].rtikorg,g_rtib5_d[l_ac].rtikseq,g_rtib5_d[l_ac].rtik001,g_rtib5_d[l_ac].rtik002, 
          g_rtib5_d[l_ac].rtik003,g_rtib5_d[l_ac].rtik004,g_rtib5_d[l_ac].rtik005,g_rtib5_d[l_ac].rtik006, 
          g_rtib5_d[l_ac].rtik007,g_rtib5_d[l_ac].rtik013,g_rtib5_d[l_ac].rtik012,g_rtib5_d[l_ac].rtik008, 
          g_rtib5_d[l_ac].rtik009,g_rtib5_d[l_ac].rtik010,g_rtib5_d[l_ac].rtik011,g_rtib5_d[l_ac].rtik014, 
          g_rtib5_d[l_ac].rtik015,g_rtib5_d[l_ac].rtik016,g_rtib5_d[l_ac].rtik017,g_rtib5_d[l_ac].rtik018, 
          g_rtib5_d[l_ac].rtik019,g_rtib5_d[l_ac].rtik020,g_rtib5_d[l_ac].rtik021,g_rtib5_d[l_ac].rtik022, 
          g_rtib5_d[l_ac].rtik023,g_rtib5_d[l_ac].rtik003_desc,g_rtib5_d[l_ac].rtik013_desc,g_rtib5_d[l_ac].rtik019_desc, 
          g_rtib5_d[l_ac].rtik020_desc   #(ver:78)
         IF SQLCA.SQLCODE THEN
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "FOREACH:",SQLERRMESSAGE 
            LET g_errparam.code = SQLCA.SQLCODE 
            LET g_errparam.popup = TRUE 
            CALL cl_err()
            EXIT FOREACH
         END IF
        
         #add-point:b_fill段資料填充 name="b_fill5.fill"
         IF cl_null(g_rtib5_d[l_ac].rtik003_desc) THEN
            SELECT prbr009 INTO g_rtib5_d[l_ac].rtik003_desc
              FROM prbr_t
             WHERE prbrent = g_enterprise
               AND prbrdocno = g_rtib5_d[l_ac].rtik001
               AND prbrseq = g_rtib5_d[l_ac].rtik002
         END IF
         SELECT oodbl004 INTO g_rtib5_d[l_ac].rtik006_desc 
           FROM oodbl_t,ooef_t
          WHERE oodblent = ooefent
            AND ooefent = g_enterprise
            AND ooef001 = g_rtia_m.rtiasite
            AND oodbl001 = ooef019
            AND oodbl002 = g_rtib5_d[l_ac].rtik006
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
   IF artt622_fill_chk(6) THEN
      IF (g_action_choice = "query" OR cl_null(g_action_choice))
         #add-point:b_fill段long_sql_if name="b_fill.body6.long_sql_if"
         
         #end add-point
      THEN
         LET g_sql = "SELECT  DISTINCT rtinsite,rtinseq,rtinseq1,rtin001,rtin002,rtin003,rtin004,rtin005, 
             rtin006,rtin007,rtin008,rtin009,rtin010  FROM rtin_t",   
                     " INNER JOIN  rtia_t ON rtiaent = " ||g_enterprise|| " AND rtiadocno = rtindocno ",
 
                     "",
                     
                     
                     " WHERE rtinent=? AND rtindocno=?"   
         LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
         #add-point:b_fill段fill_sql name="b_fill.body6.fill_sql"
            
         #end add-point
         IF NOT cl_null(g_wc2_table6) THEN
            LET g_sql = g_sql CLIPPED," AND ",g_wc2_table6 CLIPPED
         END IF
         
         #子單身的WC
         
         
         LET g_sql = g_sql, " ORDER BY rtin_t.rtinseq,rtin_t.rtinseq1"
         
         #add-point:單身填充控制 name="b_fill.sql6"
            
         #end add-point
         
         LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
         PREPARE artt622_pb6 FROM g_sql
         DECLARE b_fill_cs6 CURSOR FOR artt622_pb6
      END IF
    
      LET l_ac = 1
      
   #  OPEN b_fill_cs6 USING g_enterprise,g_rtia_m.rtiadocno   #(ver:78)
                                               
      FOREACH b_fill_cs6 USING g_enterprise,g_rtia_m.rtiadocno INTO g_rtib6_d[l_ac].rtinsite,g_rtib6_d[l_ac].rtinseq, 
          g_rtib6_d[l_ac].rtinseq1,g_rtib6_d[l_ac].rtin001,g_rtib6_d[l_ac].rtin002,g_rtib6_d[l_ac].rtin003, 
          g_rtib6_d[l_ac].rtin004,g_rtib6_d[l_ac].rtin005,g_rtib6_d[l_ac].rtin006,g_rtib6_d[l_ac].rtin007, 
          g_rtib6_d[l_ac].rtin008,g_rtib6_d[l_ac].rtin009,g_rtib6_d[l_ac].rtin010   #(ver:78)
         IF SQLCA.SQLCODE THEN
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "FOREACH:",SQLERRMESSAGE 
            LET g_errparam.code = SQLCA.SQLCODE 
            LET g_errparam.popup = TRUE 
            CALL cl_err()
            EXIT FOREACH
         END IF
        
         #add-point:b_fill段資料填充 name="b_fill6.fill"
        #add by yangxf ----start----
        IF g_prog = 'artt700' THEN 
           LET g_rtib6_d[l_ac].rtin009 = g_rtib6_d[l_ac].rtin009*(-1)
        END IF 
        #add by yangxf -----end-----
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
   IF artt622_fill_chk(7) THEN
      IF (g_action_choice = "query" OR cl_null(g_action_choice))
         #add-point:b_fill段long_sql_if name="b_fill.body7.long_sql_if"
         
         #end add-point
      THEN
         LET g_sql = "SELECT  DISTINCT preksite,prekunit,prekseq,prek001,prek002,prek003,prek004  FROM prek_t", 
                
                     " INNER JOIN  rtia_t ON rtiaent = " ||g_enterprise|| " AND rtiadocno = prekdocno ",
 
                     "",
                     
                     
                     " WHERE prekent=? AND prekdocno=?"   
         LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
         #add-point:b_fill段fill_sql name="b_fill.body7.fill_sql"
            
         #end add-point
         IF NOT cl_null(g_wc2_table7) THEN
            LET g_sql = g_sql CLIPPED," AND ",g_wc2_table7 CLIPPED
         END IF
         
         #子單身的WC
         
         
         LET g_sql = g_sql, " ORDER BY prek_t.prekseq"
         
         #add-point:單身填充控制 name="b_fill.sql7"
            
         #end add-point
         
         LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
         PREPARE artt622_pb7 FROM g_sql
         DECLARE b_fill_cs7 CURSOR FOR artt622_pb7
      END IF
    
      LET l_ac = 1
      
   #  OPEN b_fill_cs7 USING g_enterprise,g_rtia_m.rtiadocno   #(ver:78)
                                               
      FOREACH b_fill_cs7 USING g_enterprise,g_rtia_m.rtiadocno INTO g_rtib7_d[l_ac].preksite,g_rtib7_d[l_ac].prekunit, 
          g_rtib7_d[l_ac].prekseq,g_rtib7_d[l_ac].prek001,g_rtib7_d[l_ac].prek002,g_rtib7_d[l_ac].prek003, 
          g_rtib7_d[l_ac].prek004   #(ver:78)
         IF SQLCA.SQLCODE THEN
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "FOREACH:",SQLERRMESSAGE 
            LET g_errparam.code = SQLCA.SQLCODE 
            LET g_errparam.popup = TRUE 
            CALL cl_err()
            EXIT FOREACH
         END IF
        
         #add-point:b_fill段資料填充 name="b_fill7.fill"
                  
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
   
   CALL g_rtib_d.deleteElement(g_rtib_d.getLength())
   CALL g_rtib2_d.deleteElement(g_rtib2_d.getLength())
   CALL g_rtib3_d.deleteElement(g_rtib3_d.getLength())
   CALL g_rtib4_d.deleteElement(g_rtib4_d.getLength())
   CALL g_rtib5_d.deleteElement(g_rtib5_d.getLength())
   CALL g_rtib6_d.deleteElement(g_rtib6_d.getLength())
   CALL g_rtib7_d.deleteElement(g_rtib7_d.getLength())
 
   
 
   LET l_ac = g_cnt
   LET g_cnt = 0  
   
   FREE artt622_pb
   FREE artt622_pb2
 
   FREE artt622_pb3
 
   FREE artt622_pb4
 
   FREE artt622_pb5
 
   FREE artt622_pb6
 
   FREE artt622_pb7
 
 
   
   LET li_idx = l_ac
   
   #遮罩相關處理
   FOR l_ac = 1 TO g_rtib_d.getLength()
      LET g_rtib_d_mask_o[l_ac].* =  g_rtib_d[l_ac].*
      CALL artt622_rtib_t_mask()
      LET g_rtib_d_mask_n[l_ac].* =  g_rtib_d[l_ac].*
   END FOR
   
   LET g_rtib2_d_mask_o.* =  g_rtib2_d.*
   FOR l_ac = 1 TO g_rtib2_d.getLength()
      LET g_rtib2_d_mask_o[l_ac].* =  g_rtib2_d[l_ac].*
      CALL artt622_rtic_t_mask()
      LET g_rtib2_d_mask_n[l_ac].* =  g_rtib2_d[l_ac].*
   END FOR
   LET g_rtib3_d_mask_o.* =  g_rtib3_d.*
   FOR l_ac = 1 TO g_rtib3_d.getLength()
      LET g_rtib3_d_mask_o[l_ac].* =  g_rtib3_d[l_ac].*
      CALL artt622_xrcd_t_mask()
      LET g_rtib3_d_mask_n[l_ac].* =  g_rtib3_d[l_ac].*
   END FOR
   LET g_rtib4_d_mask_o.* =  g_rtib4_d.*
   FOR l_ac = 1 TO g_rtib4_d.getLength()
      LET g_rtib4_d_mask_o[l_ac].* =  g_rtib4_d[l_ac].*
      CALL artt622_rtie_t_mask()
      LET g_rtib4_d_mask_n[l_ac].* =  g_rtib4_d[l_ac].*
   END FOR
   LET g_rtib5_d_mask_o.* =  g_rtib5_d.*
   FOR l_ac = 1 TO g_rtib5_d.getLength()
      LET g_rtib5_d_mask_o[l_ac].* =  g_rtib5_d[l_ac].*
      CALL artt622_rtik_t_mask()
      LET g_rtib5_d_mask_n[l_ac].* =  g_rtib5_d[l_ac].*
   END FOR
   LET g_rtib6_d_mask_o.* =  g_rtib6_d.*
   FOR l_ac = 1 TO g_rtib6_d.getLength()
      LET g_rtib6_d_mask_o[l_ac].* =  g_rtib6_d[l_ac].*
      CALL artt622_rtin_t_mask()
      LET g_rtib6_d_mask_n[l_ac].* =  g_rtib6_d[l_ac].*
   END FOR
   LET g_rtib7_d_mask_o.* =  g_rtib7_d.*
   FOR l_ac = 1 TO g_rtib7_d.getLength()
      LET g_rtib7_d_mask_o[l_ac].* =  g_rtib7_d[l_ac].*
      CALL artt622_prek_t_mask()
      LET g_rtib7_d_mask_n[l_ac].* =  g_rtib7_d[l_ac].*
   END FOR
 
   
   LET l_ac = li_idx
   
   CALL cl_ap_performance_next_end()
 
END FUNCTION
 
{</section>}
 
{<section id="artt622.delete_b" >}
#+ 刪除單身後其他table連動
PRIVATE FUNCTION artt622_delete_b(ps_table,ps_keys_bak,ps_page)
   #add-point:delete_b段define(客製用) name="delete_b.define_customerization"
   
   #end add-point     
   DEFINE ps_table    STRING
   DEFINE ps_page     STRING
   DEFINE ps_keys_bak DYNAMIC ARRAY OF VARCHAR(500)
   DEFINE ls_group    STRING
   DEFINE li_idx      LIKE type_t.num10
   #add-point:delete_b段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="delete_b.define"
    let g_rtia_m.chantype='1'
    let g_chantype='1'   
   #end add-point     
   
   #add-point:Function前置處理  name="delete_b.pre_function"
   
   #end add-point
   
   LET g_update = TRUE  
   
   #判斷是否是同一群組的table
   LET ls_group = "'1',"
   IF ls_group.getIndexOf(ps_page,1) > 0 THEN
      #add-point:delete_b段刪除前 name="delete_b.b_delete"
            
      #end add-point    
      DELETE FROM rtib_t
       WHERE rtibent = g_enterprise AND
         rtibdocno = ps_keys_bak[1] AND rtibseq = ps_keys_bak[2]
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
         CALL g_rtib_d.deleteElement(li_idx) 
      END IF 
 
   END IF
   
   LET ls_group = "'2',"
   #判斷是否是同一群組的table
   IF ls_group.getIndexOf(ps_page,1) > 0 THEN
      #add-point:delete_b段刪除前 name="delete_b.b_delete2"
            
      #end add-point    
      DELETE FROM rtic_t
       WHERE rticent = g_enterprise AND
             rticdocno = ps_keys_bak[1] AND rticseq = ps_keys_bak[2] AND rticseq1 = ps_keys_bak[3]
      #add-point:delete_b段刪除中 name="delete_b.m_delete2"
            
      #end add-point    
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "rtic_t:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = FALSE 
         CALL cl_err()
         RETURN FALSE
      END IF
      
      LET li_idx = g_detail_idx
      IF ps_page <> "'2'" THEN 
         CALL g_rtib2_d.deleteElement(li_idx) 
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
             xrcddocno = ps_keys_bak[1] AND xrcdld = ps_keys_bak[2] AND xrcdseq = ps_keys_bak[3] AND xrcdseq2 = ps_keys_bak[4] AND xrcd007 = ps_keys_bak[5]
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
         CALL g_rtib3_d.deleteElement(li_idx) 
      END IF 
 
      #add-point:delete_b段刪除後 name="delete_b.a_delete3"
            
      #end add-point    
   END IF
 
   LET ls_group = "'4',"
   #判斷是否是同一群組的table
   IF ls_group.getIndexOf(ps_page,1) > 0 THEN
      #add-point:delete_b段刪除前 name="delete_b.b_delete4"
            
      #end add-point    
      DELETE FROM rtie_t
       WHERE rtieent = g_enterprise AND
             rtiedocno = ps_keys_bak[1] AND rtieseq = ps_keys_bak[2] AND rtieseq1 = ps_keys_bak[3]
      #add-point:delete_b段刪除中 name="delete_b.m_delete4"
            
      #end add-point    
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "rtie_t:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = FALSE 
         CALL cl_err()
         RETURN FALSE
      END IF
      
      LET li_idx = g_detail_idx
      IF ps_page <> "'4'" THEN 
         CALL g_rtib4_d.deleteElement(li_idx) 
      END IF 
 
      #add-point:delete_b段刪除後 name="delete_b.a_delete4"
            
      #end add-point    
   END IF
 
   LET ls_group = "'5',"
   #判斷是否是同一群組的table
   IF ls_group.getIndexOf(ps_page,1) > 0 THEN
      #add-point:delete_b段刪除前 name="delete_b.b_delete5"
            
      #end add-point    
      DELETE FROM rtik_t
       WHERE rtikent = g_enterprise AND
             rtikdocno = ps_keys_bak[1] AND rtikseq = ps_keys_bak[2]
      #add-point:delete_b段刪除中 name="delete_b.m_delete5"
            
      #end add-point    
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "rtik_t:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = FALSE 
         CALL cl_err()
         RETURN FALSE
      END IF
      
      LET li_idx = g_detail_idx
      IF ps_page <> "'5'" THEN 
         CALL g_rtib5_d.deleteElement(li_idx) 
      END IF 
 
      #add-point:delete_b段刪除後 name="delete_b.a_delete5"
            
      #end add-point    
   END IF
 
   LET ls_group = "'6',"
   #判斷是否是同一群組的table
   IF ls_group.getIndexOf(ps_page,1) > 0 THEN
      #add-point:delete_b段刪除前 name="delete_b.b_delete6"
            
      #end add-point    
      DELETE FROM rtin_t
       WHERE rtinent = g_enterprise AND
             rtindocno = ps_keys_bak[1] AND rtinseq = ps_keys_bak[2] AND rtinseq1 = ps_keys_bak[3]
      #add-point:delete_b段刪除中 name="delete_b.m_delete6"
            
      #end add-point    
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "rtin_t:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = FALSE 
         CALL cl_err()
         RETURN FALSE
      END IF
      
      LET li_idx = g_detail_idx
      IF ps_page <> "'6'" THEN 
         CALL g_rtib6_d.deleteElement(li_idx) 
      END IF 
 
      #add-point:delete_b段刪除後 name="delete_b.a_delete6"
            
      #end add-point    
   END IF
 
   LET ls_group = "'7',"
   #判斷是否是同一群組的table
   IF ls_group.getIndexOf(ps_page,1) > 0 THEN
      #add-point:delete_b段刪除前 name="delete_b.b_delete7"
            
      #end add-point    
      DELETE FROM prek_t
       WHERE prekent = g_enterprise AND
             prekdocno = ps_keys_bak[1] AND prekseq = ps_keys_bak[2]
      #add-point:delete_b段刪除中 name="delete_b.m_delete7"
            
      #end add-point    
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "prek_t:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = FALSE 
         CALL cl_err()
         RETURN FALSE
      END IF
      
      LET li_idx = g_detail_idx
      IF ps_page <> "'7'" THEN 
         CALL g_rtib7_d.deleteElement(li_idx) 
      END IF 
 
      #add-point:delete_b段刪除後 name="delete_b.a_delete7"
            
      #end add-point    
   END IF
 
 
   
 
   
   #add-point:delete_b段other name="delete_b.other"
      
   #end add-point  
   
   RETURN TRUE
   
END FUNCTION
 
{</section>}
 
{<section id="artt622.insert_b" >}
#+ 新增單身後其他table連動
PRIVATE FUNCTION artt622_insert_b(ps_table,ps_keys,ps_page)
   #add-point:insert_b段define(客製用) name="insert_b.define_customerization"
   
   #end add-point     
   DEFINE ps_table    STRING
   DEFINE ps_page     STRING
   DEFINE ps_keys     DYNAMIC ARRAY OF VARCHAR(500)
   DEFINE ls_group    STRING
   DEFINE ls_page     STRING
   DEFINE li_idx      LIKE type_t.num10
   #add-point:insert_b段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="insert_b.define"
   DEFINE l_xrcd103   LIKE xrcd_t.xrcd103,
          l_xrcd104   LIKE xrcd_t.xrcd104,
          l_xrcd105   LIKE xrcd_t.xrcd105,
          l_xrcd113   LIKE xrcd_t.xrcd113,
          l_xrcd114   LIKE xrcd_t.xrcd114,
          l_xrcd115   LIKE xrcd_t.xrcd115,
          l_imaa005   LIKE imaa_t.imaa005,
          l_xrcd123   LIKE xrcd_t.xrcd113,
          l_xrcd124   LIKE xrcd_t.xrcd114,
          l_xrcd125   LIKE xrcd_t.xrcd115,
          l_xrcd133   LIKE xrcd_t.xrcd113,
          l_xrcd134   LIKE xrcd_t.xrcd114,
          l_xrcd135   LIKE xrcd_t.xrcd115
   #end add-point     
   
   #add-point:Function前置處理  name="insert_b.pre_function"
   
   #end add-point
   
   LET g_update = TRUE  
   
   #判斷是否是同一群組的table
   LET ls_group = "'1',"
   IF ls_group.getIndexOf(ps_page,1) > 0 THEN
      #add-point:insert_b段資料新增前 name="insert_b.before_insert"
      #add by yangxf ----start----
      IF g_prog = 'artt700' THEN 
         LET g_rtib_d[g_detail_idx].rtib012 = g_rtib_d[g_detail_idx].rtib012*(-1)
         LET g_rtib_d[g_detail_idx].rtib017 = g_rtib_d[g_detail_idx].rtib017*(-1)
         LET g_rtib_d[g_detail_idx].rtib020 = g_rtib_d[g_detail_idx].rtib020*(-1)
         LET g_rtib_d[g_detail_idx].rtib021 = g_rtib_d[g_detail_idx].rtib021*(-1)
         LET g_rtib_d[g_detail_idx].rtib022 = g_rtib_d[g_detail_idx].rtib022*(-1)
         LET g_rtib_d[g_detail_idx].rtib031 = g_rtib_d[g_detail_idx].rtib031*(-1)
      END IF 
      #add by yangxf -----end-----
      #end add-point 
      INSERT INTO rtib_t
                  (rtibent,
                   rtibdocno,
                   rtibseq
                   ,rtibsite,rtibunit,rtiborga,rtib035,rtib042,rtib001,rtib002,rtib003,rtib004,rtib005,rtib106,rtib012,rtib108,rtib013,rtib107,rtib008,rtib009,rtib010,rtib014,rtib015,rtib016,rtib018,rtib017,rtib019,rtib020,rtib021,rtib031,rtib022,rtib024,rtib025,rtib026,rtib027,rtib032,rtib033,rtib028,rtib030,rtib039,rtib006) 
            VALUES(g_enterprise,
                   ps_keys[1],ps_keys[2]
                   ,g_rtib_d[g_detail_idx].rtibsite,g_rtib_d[g_detail_idx].rtibunit,g_rtib_d[g_detail_idx].rtiborga, 
                       g_rtib_d[g_detail_idx].rtib035,g_rtib_d[g_detail_idx].rtib042,g_rtib_d[g_detail_idx].rtib001, 
                       g_rtib_d[g_detail_idx].rtib002,g_rtib_d[g_detail_idx].rtib003,g_rtib_d[g_detail_idx].rtib004, 
                       g_rtib_d[g_detail_idx].rtib005,g_rtib_d[g_detail_idx].rtib106,g_rtib_d[g_detail_idx].rtib012, 
                       g_rtib_d[g_detail_idx].rtib108,g_rtib_d[g_detail_idx].rtib013,g_rtib_d[g_detail_idx].rtib107, 
                       g_rtib_d[g_detail_idx].rtib008,g_rtib_d[g_detail_idx].rtib009,g_rtib_d[g_detail_idx].rtib010, 
                       g_rtib_d[g_detail_idx].rtib014,g_rtib_d[g_detail_idx].rtib015,g_rtib_d[g_detail_idx].rtib016, 
                       g_rtib_d[g_detail_idx].rtib018,g_rtib_d[g_detail_idx].rtib017,g_rtib_d[g_detail_idx].rtib019, 
                       g_rtib_d[g_detail_idx].rtib020,g_rtib_d[g_detail_idx].rtib021,g_rtib_d[g_detail_idx].rtib031, 
                       g_rtib_d[g_detail_idx].rtib022,g_rtib_d[g_detail_idx].rtib024,g_rtib_d[g_detail_idx].rtib025, 
                       g_rtib_d[g_detail_idx].rtib026,g_rtib_d[g_detail_idx].rtib027,g_rtib_d[g_detail_idx].rtib032, 
                       g_rtib_d[g_detail_idx].rtib033,g_rtib_d[g_detail_idx].rtib028,g_rtib_d[g_detail_idx].rtib030, 
                       g_rtib_d[g_detail_idx].rtib039,g_rtib_d[g_detail_idx].rtib006)
      #add-point:insert_b段資料新增中 name="insert_b.m_insert"
            
      #end add-point 
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "rtib_t:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = FALSE 
         CALL cl_err()
      END IF
      
      LET li_idx = g_detail_idx
      IF ps_page <> "'1'" THEN 
         CALL g_rtib_d.insertElement(li_idx) 
      END IF 
 
      #add-point:insert_b段資料新增後 name="insert_b.after_insert"
                     #單號      項次       項次2   營運據點           應收金額
      CALL s_tax_ins(ps_keys[1],ps_keys[2],'0',   g_rtia_m.rtiasite,g_rtib_d[g_detail_idx].rtib021,
                     #稅別                          數量                           幣別             匯率             帳套  匯率2 匯率3
                     g_rtib_d[g_detail_idx].rtib006,g_rtib_d[g_detail_idx].rtib017,g_rtia_m.rtia026,g_rtia_m.rtia027,' ',' ',  ' ')
                #原幣未稅金額 原幣稅額   原幣含稅金額 本幣未稅金額(AR/AP使用) 本幣稅額(AR/AP使用) 本幣含稅金額(AR/AP使用)
      RETURNING l_xrcd103,    l_xrcd104, l_xrcd105,   l_xrcd113,              l_xrcd114,          l_xrcd115,
                l_xrcd123,l_xrcd124,l_xrcd125,l_xrcd133,l_xrcd134,l_xrcd135

      UPDATE rtib_t SET rtib022 = l_xrcd103
       WHERE rtibent = g_enterprise
         AND rtibdocno = ps_keys[1]
         AND rtibseq = ps_keys[2]
      CASE
         WHEN SQLCA.sqlcode #其他錯誤
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = SQLCA.sqlcode
            LET g_errparam.extend = "rtib_t"
            LET g_errparam.popup = TRUE
            CALL cl_err()
  
            CALL s_transaction_end('N','0')
         OTHERWISE
      END CASE
      #end add-point 
   END IF
   
   LET ls_group = "'2',"
   #判斷是否是同一群組的table
   IF ls_group.getIndexOf(ps_page,1) > 0 THEN
      #add-point:insert_b段資料新增前 name="insert_b.before_insert2"
            
      #end add-point 
      INSERT INTO rtic_t
                  (rticent,
                   rticdocno,
                   rticseq,rticseq1
                   ,rtic001,rtic002,rtic003,rtic004,rtic005,rtic006,rtic007,rtic008,rtic009,rtic010,rtic011,rtic012,rtic013,rtic014,rtic015,rtic016,rtic017,rtic018,rtic020) 
            VALUES(g_enterprise,
                   ps_keys[1],ps_keys[2],ps_keys[3]
                   ,g_rtib2_d[g_detail_idx].rtic001,g_rtib2_d[g_detail_idx].rtic002,g_rtib2_d[g_detail_idx].rtic003, 
                       g_rtib2_d[g_detail_idx].rtic004,g_rtib2_d[g_detail_idx].rtic005,g_rtib2_d[g_detail_idx].rtic006, 
                       g_rtib2_d[g_detail_idx].rtic007,g_rtib2_d[g_detail_idx].rtic008,g_rtib2_d[g_detail_idx].rtic009, 
                       g_rtib2_d[g_detail_idx].rtic010,g_rtib2_d[g_detail_idx].rtic011,g_rtib2_d[g_detail_idx].rtic012, 
                       g_rtib2_d[g_detail_idx].rtic013,g_rtib2_d[g_detail_idx].rtic014,g_rtib2_d[g_detail_idx].rtic015, 
                       g_rtib2_d[g_detail_idx].rtic016,g_rtib2_d[g_detail_idx].rtic017,g_rtib2_d[g_detail_idx].rtic018, 
                       g_rtib2_d[g_detail_idx].rtic020)
      #add-point:insert_b段資料新增中 name="insert_b.m_insert2"
            
      #end add-point
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "rtic_t:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = FALSE 
         CALL cl_err()
      END IF
      
      LET li_idx = g_detail_idx
      IF ps_page <> "'2'" THEN 
         CALL g_rtib2_d.insertElement(li_idx) 
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
                   xrcddocno,
                   xrcdld,xrcdseq,xrcdseq2,xrcd007
                   ,xrcd002,xrcd003,xrcd006,xrcd004,xrcd104) 
            VALUES(g_enterprise,
                   ps_keys[1],ps_keys[2],ps_keys[3],ps_keys[4],ps_keys[5]
                   ,g_rtib3_d[g_detail_idx].xrcd002,g_rtib3_d[g_detail_idx].xrcd003,g_rtib3_d[g_detail_idx].xrcd006, 
                       g_rtib3_d[g_detail_idx].xrcd004,g_rtib3_d[g_detail_idx].xrcd104)
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
         CALL g_rtib3_d.insertElement(li_idx) 
      END IF 
 
      #add-point:insert_b段資料新增後 name="insert_b.after_insert3"
            
      #end add-point
   END IF
 
   LET ls_group = "'4',"
   #判斷是否是同一群組的table
   IF ls_group.getIndexOf(ps_page,1) > 0 THEN
      #add-point:insert_b段資料新增前 name="insert_b.before_insert4"
            
      #end add-point 
      INSERT INTO rtie_t
                  (rtieent,
                   rtiedocno,
                   rtieseq,rtieseq1
                   ,rtie001,rtie002,rtie006) 
            VALUES(g_enterprise,
                   ps_keys[1],ps_keys[2],ps_keys[3]
                   ,g_rtib4_d[g_detail_idx].rtie001,g_rtib4_d[g_detail_idx].rtie002,g_rtib4_d[g_detail_idx].rtie006) 
 
      #add-point:insert_b段資料新增中 name="insert_b.m_insert4"
            
      #end add-point
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "rtie_t:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = FALSE 
         CALL cl_err()
      END IF
      
      LET li_idx = g_detail_idx
      IF ps_page <> "'4'" THEN 
         CALL g_rtib4_d.insertElement(li_idx) 
      END IF 
 
      #add-point:insert_b段資料新增後 name="insert_b.after_insert4"
            
      #end add-point
   END IF
 
   LET ls_group = "'5',"
   #判斷是否是同一群組的table
   IF ls_group.getIndexOf(ps_page,1) > 0 THEN
      #add-point:insert_b段資料新增前 name="insert_b.before_insert5"
            
      #end add-point 
      INSERT INTO rtik_t
                  (rtikent,
                   rtikdocno,
                   rtikseq
                   ,rtiksite,rtikunit,rtikorg,rtik001,rtik002,rtik003,rtik004,rtik005,rtik006,rtik007,rtik013,rtik012,rtik008,rtik009,rtik010,rtik011,rtik014,rtik015,rtik016,rtik017,rtik018,rtik019,rtik020,rtik021,rtik022,rtik023) 
            VALUES(g_enterprise,
                   ps_keys[1],ps_keys[2]
                   ,g_rtib5_d[g_detail_idx].rtiksite,g_rtib5_d[g_detail_idx].rtikunit,g_rtib5_d[g_detail_idx].rtikorg, 
                       g_rtib5_d[g_detail_idx].rtik001,g_rtib5_d[g_detail_idx].rtik002,g_rtib5_d[g_detail_idx].rtik003, 
                       g_rtib5_d[g_detail_idx].rtik004,g_rtib5_d[g_detail_idx].rtik005,g_rtib5_d[g_detail_idx].rtik006, 
                       g_rtib5_d[g_detail_idx].rtik007,g_rtib5_d[g_detail_idx].rtik013,g_rtib5_d[g_detail_idx].rtik012, 
                       g_rtib5_d[g_detail_idx].rtik008,g_rtib5_d[g_detail_idx].rtik009,g_rtib5_d[g_detail_idx].rtik010, 
                       g_rtib5_d[g_detail_idx].rtik011,g_rtib5_d[g_detail_idx].rtik014,g_rtib5_d[g_detail_idx].rtik015, 
                       g_rtib5_d[g_detail_idx].rtik016,g_rtib5_d[g_detail_idx].rtik017,g_rtib5_d[g_detail_idx].rtik018, 
                       g_rtib5_d[g_detail_idx].rtik019,g_rtib5_d[g_detail_idx].rtik020,g_rtib5_d[g_detail_idx].rtik021, 
                       g_rtib5_d[g_detail_idx].rtik022,g_rtib5_d[g_detail_idx].rtik023)
      #add-point:insert_b段資料新增中 name="insert_b.m_insert5"
            
      #end add-point
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "rtik_t:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = FALSE 
         CALL cl_err()
      END IF
      
      LET li_idx = g_detail_idx
      IF ps_page <> "'5'" THEN 
         CALL g_rtib5_d.insertElement(li_idx) 
      END IF 
 
      #add-point:insert_b段資料新增後 name="insert_b.after_insert5"
            
      #end add-point
   END IF
 
   LET ls_group = "'6',"
   #判斷是否是同一群組的table
   IF ls_group.getIndexOf(ps_page,1) > 0 THEN
      #add-point:insert_b段資料新增前 name="insert_b.before_insert6"
            
      #end add-point 
      INSERT INTO rtin_t
                  (rtinent,
                   rtindocno,
                   rtinseq,rtinseq1
                   ,rtinsite,rtin001,rtin002,rtin003,rtin004,rtin005,rtin006,rtin007,rtin008,rtin009,rtin010) 
            VALUES(g_enterprise,
                   ps_keys[1],ps_keys[2],ps_keys[3]
                   ,g_rtib6_d[g_detail_idx].rtinsite,g_rtib6_d[g_detail_idx].rtin001,g_rtib6_d[g_detail_idx].rtin002, 
                       g_rtib6_d[g_detail_idx].rtin003,g_rtib6_d[g_detail_idx].rtin004,g_rtib6_d[g_detail_idx].rtin005, 
                       g_rtib6_d[g_detail_idx].rtin006,g_rtib6_d[g_detail_idx].rtin007,g_rtib6_d[g_detail_idx].rtin008, 
                       g_rtib6_d[g_detail_idx].rtin009,g_rtib6_d[g_detail_idx].rtin010)
      #add-point:insert_b段資料新增中 name="insert_b.m_insert6"
            
      #end add-point
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "rtin_t:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = FALSE 
         CALL cl_err()
      END IF
      
      LET li_idx = g_detail_idx
      IF ps_page <> "'6'" THEN 
         CALL g_rtib6_d.insertElement(li_idx) 
      END IF 
 
      #add-point:insert_b段資料新增後 name="insert_b.after_insert6"
            
      #end add-point
   END IF
 
   LET ls_group = "'7',"
   #判斷是否是同一群組的table
   IF ls_group.getIndexOf(ps_page,1) > 0 THEN
      #add-point:insert_b段資料新增前 name="insert_b.before_insert7"
            
      #end add-point 
      INSERT INTO prek_t
                  (prekent,
                   prekdocno,
                   prekseq
                   ,preksite,prekunit,prek001,prek002,prek003,prek004) 
            VALUES(g_enterprise,
                   ps_keys[1],ps_keys[2]
                   ,g_rtib7_d[g_detail_idx].preksite,g_rtib7_d[g_detail_idx].prekunit,g_rtib7_d[g_detail_idx].prek001, 
                       g_rtib7_d[g_detail_idx].prek002,g_rtib7_d[g_detail_idx].prek003,g_rtib7_d[g_detail_idx].prek004) 
 
      #add-point:insert_b段資料新增中 name="insert_b.m_insert7"
            
      #end add-point
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "prek_t:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = FALSE 
         CALL cl_err()
      END IF
      
      LET li_idx = g_detail_idx
      IF ps_page <> "'7'" THEN 
         CALL g_rtib7_d.insertElement(li_idx) 
      END IF 
 
      #add-point:insert_b段資料新增後 name="insert_b.after_insert7"
            
      #end add-point
   END IF
 
 
   
 
   
   #add-point:insert_b段other name="insert_b.other"
   #add by yangxf ----start----
   #IF g_prog = 'artt700' THEN 
   #   LET g_rtib_d[g_detail_idx].rtib012 = g_rtib_d[g_detail_idx].rtib012*(-1)
   #   LET g_rtib_d[g_detail_idx].rtib017 = g_rtib_d[g_detail_idx].rtib017*(-1)
   #   LET g_rtib_d[g_detail_idx].rtib020 = g_rtib_d[g_detail_idx].rtib020*(-1)
   #   LET g_rtib_d[g_detail_idx].rtib021 = g_rtib_d[g_detail_idx].rtib021*(-1)
   #   LET g_rtib_d[g_detail_idx].rtib022 = g_rtib_d[g_detail_idx].rtib022*(-1)
   #   LET g_rtib_d[g_detail_idx].rtib031 = g_rtib_d[g_detail_idx].rtib031*(-1)
   #END IF 
   #add by yangxf -----end-----
   #end add-point     
   
END FUNCTION
 
{</section>}
 
{<section id="artt622.update_b" >}
#+ 修改單身後其他table連動
PRIVATE FUNCTION artt622_update_b(ps_table,ps_keys,ps_keys_bak,ps_page)
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
   IF ls_group.getIndexOf(ps_page,1) > 0 AND ps_table <> "rtib_t" THEN
      #add-point:update_b段修改前 name="update_b.before_update"
      #add by yangxf ----start----
      IF g_prog = 'artt700' THEN 
         LET g_rtib_d[g_detail_idx].rtib012 = g_rtib_d[g_detail_idx].rtib012*(-1)
         LET g_rtib_d[g_detail_idx].rtib017 = g_rtib_d[g_detail_idx].rtib017*(-1)
         LET g_rtib_d[g_detail_idx].rtib020 = g_rtib_d[g_detail_idx].rtib020*(-1)
         LET g_rtib_d[g_detail_idx].rtib021 = g_rtib_d[g_detail_idx].rtib021*(-1)
         LET g_rtib_d[g_detail_idx].rtib022 = g_rtib_d[g_detail_idx].rtib022*(-1)
         LET g_rtib_d[g_detail_idx].rtib031 = g_rtib_d[g_detail_idx].rtib031*(-1)
      END IF 
      #add by yangxf -----end-----
      #end add-point 
      
      #將遮罩欄位還原
      CALL artt622_rtib_t_mask_restore('restore_mask_o')
               
      UPDATE rtib_t 
         SET (rtibdocno,
              rtibseq
              ,rtibsite,rtibunit,rtiborga,rtib035,rtib042,rtib001,rtib002,rtib003,rtib004,rtib005,rtib106,rtib012,rtib108,rtib013,rtib107,rtib008,rtib009,rtib010,rtib014,rtib015,rtib016,rtib018,rtib017,rtib019,rtib020,rtib021,rtib031,rtib022,rtib024,rtib025,rtib026,rtib027,rtib032,rtib033,rtib028,rtib030,rtib039,rtib006) 
              = 
             (ps_keys[1],ps_keys[2]
              ,g_rtib_d[g_detail_idx].rtibsite,g_rtib_d[g_detail_idx].rtibunit,g_rtib_d[g_detail_idx].rtiborga, 
                  g_rtib_d[g_detail_idx].rtib035,g_rtib_d[g_detail_idx].rtib042,g_rtib_d[g_detail_idx].rtib001, 
                  g_rtib_d[g_detail_idx].rtib002,g_rtib_d[g_detail_idx].rtib003,g_rtib_d[g_detail_idx].rtib004, 
                  g_rtib_d[g_detail_idx].rtib005,g_rtib_d[g_detail_idx].rtib106,g_rtib_d[g_detail_idx].rtib012, 
                  g_rtib_d[g_detail_idx].rtib108,g_rtib_d[g_detail_idx].rtib013,g_rtib_d[g_detail_idx].rtib107, 
                  g_rtib_d[g_detail_idx].rtib008,g_rtib_d[g_detail_idx].rtib009,g_rtib_d[g_detail_idx].rtib010, 
                  g_rtib_d[g_detail_idx].rtib014,g_rtib_d[g_detail_idx].rtib015,g_rtib_d[g_detail_idx].rtib016, 
                  g_rtib_d[g_detail_idx].rtib018,g_rtib_d[g_detail_idx].rtib017,g_rtib_d[g_detail_idx].rtib019, 
                  g_rtib_d[g_detail_idx].rtib020,g_rtib_d[g_detail_idx].rtib021,g_rtib_d[g_detail_idx].rtib031, 
                  g_rtib_d[g_detail_idx].rtib022,g_rtib_d[g_detail_idx].rtib024,g_rtib_d[g_detail_idx].rtib025, 
                  g_rtib_d[g_detail_idx].rtib026,g_rtib_d[g_detail_idx].rtib027,g_rtib_d[g_detail_idx].rtib032, 
                  g_rtib_d[g_detail_idx].rtib033,g_rtib_d[g_detail_idx].rtib028,g_rtib_d[g_detail_idx].rtib030, 
                  g_rtib_d[g_detail_idx].rtib039,g_rtib_d[g_detail_idx].rtib006) 
         WHERE rtibent = g_enterprise AND rtibdocno = ps_keys_bak[1] AND rtibseq = ps_keys_bak[2]
      #add-point:update_b段修改中 name="update_b.m_update"
 
      #end add-point   
      CASE
         WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "rtib_t" 
            LET g_errparam.code = "std-00009" 
            LET g_errparam.popup = TRUE 
            CALL s_transaction_end('N','0')
            CALL cl_err()
            
         WHEN SQLCA.SQLCODE #其他錯誤
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "rtib_t:",SQLERRMESSAGE 
            LET g_errparam.code = SQLCA.SQLCODE 
            LET g_errparam.popup = TRUE 
            CALL s_transaction_end('N','0')
            CALL cl_err()
            
         OTHERWISE
 
      END CASE
      
      #將遮罩欄位進行遮蔽
      CALL artt622_rtib_t_mask_restore('restore_mask_n')
               
      #add-point:update_b段修改後 name="update_b.after_update"
 
      #end add-point  
   END IF
   
   #子表處理
   IF ls_group.getIndexOf(ps_page,1) > 0 THEN
      
   END IF
   
   
   LET ls_group = "'2',"
   #判斷是否是同一群組的table
   IF ls_group.getIndexOf(ps_page,1) > 0 AND ps_table <> "rtic_t" THEN
      #add-point:update_b段修改前 name="update_b.before_update2"
            
      #end add-point  
      
      #將遮罩欄位還原
      CALL artt622_rtic_t_mask_restore('restore_mask_o')
               
      UPDATE rtic_t 
         SET (rticdocno,
              rticseq,rticseq1
              ,rtic001,rtic002,rtic003,rtic004,rtic005,rtic006,rtic007,rtic008,rtic009,rtic010,rtic011,rtic012,rtic013,rtic014,rtic015,rtic016,rtic017,rtic018,rtic020) 
              = 
             (ps_keys[1],ps_keys[2],ps_keys[3]
              ,g_rtib2_d[g_detail_idx].rtic001,g_rtib2_d[g_detail_idx].rtic002,g_rtib2_d[g_detail_idx].rtic003, 
                  g_rtib2_d[g_detail_idx].rtic004,g_rtib2_d[g_detail_idx].rtic005,g_rtib2_d[g_detail_idx].rtic006, 
                  g_rtib2_d[g_detail_idx].rtic007,g_rtib2_d[g_detail_idx].rtic008,g_rtib2_d[g_detail_idx].rtic009, 
                  g_rtib2_d[g_detail_idx].rtic010,g_rtib2_d[g_detail_idx].rtic011,g_rtib2_d[g_detail_idx].rtic012, 
                  g_rtib2_d[g_detail_idx].rtic013,g_rtib2_d[g_detail_idx].rtic014,g_rtib2_d[g_detail_idx].rtic015, 
                  g_rtib2_d[g_detail_idx].rtic016,g_rtib2_d[g_detail_idx].rtic017,g_rtib2_d[g_detail_idx].rtic018, 
                  g_rtib2_d[g_detail_idx].rtic020) 
         WHERE rticent = g_enterprise AND rticdocno = ps_keys_bak[1] AND rticseq = ps_keys_bak[2] AND rticseq1 = ps_keys_bak[3]
      #add-point:update_b段修改中 name="update_b.m_update2"
            
      #end add-point  
      CASE
         WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "rtic_t" 
            LET g_errparam.code = "std-00009" 
            LET g_errparam.popup = TRUE 
            CALL s_transaction_end('N','0')
            CALL cl_err()
            
         WHEN SQLCA.SQLCODE #其他錯誤
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "rtic_t:",SQLERRMESSAGE 
            LET g_errparam.code = SQLCA.SQLCODE 
            LET g_errparam.popup = TRUE 
            CALL s_transaction_end('N','0')
            CALL cl_err()
            
         OTHERWISE
          
      END CASE
      
      #將遮罩欄位進行遮蔽
      CALL artt622_rtic_t_mask_restore('restore_mask_n')
 
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
      CALL artt622_xrcd_t_mask_restore('restore_mask_o')
               
      UPDATE xrcd_t 
         SET (xrcddocno,
              xrcdld,xrcdseq,xrcdseq2,xrcd007
              ,xrcd002,xrcd003,xrcd006,xrcd004,xrcd104) 
              = 
             (ps_keys[1],ps_keys[2],ps_keys[3],ps_keys[4],ps_keys[5]
              ,g_rtib3_d[g_detail_idx].xrcd002,g_rtib3_d[g_detail_idx].xrcd003,g_rtib3_d[g_detail_idx].xrcd006, 
                  g_rtib3_d[g_detail_idx].xrcd004,g_rtib3_d[g_detail_idx].xrcd104) 
         WHERE xrcdent = g_enterprise AND xrcddocno = ps_keys_bak[1] AND xrcdld = ps_keys_bak[2] AND xrcdseq = ps_keys_bak[3] AND xrcdseq2 = ps_keys_bak[4] AND xrcd007 = ps_keys_bak[5]
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
      CALL artt622_xrcd_t_mask_restore('restore_mask_n')
 
      #add-point:update_b段修改後 name="update_b.after_update3"
            
      #end add-point  
   END IF
 
   #子表處理
   IF ls_group.getIndexOf(ps_page,1) > 0 THEN
      
   END IF
 
   LET ls_group = "'4',"
   #判斷是否是同一群組的table
   IF ls_group.getIndexOf(ps_page,1) > 0 AND ps_table <> "rtie_t" THEN
      #add-point:update_b段修改前 name="update_b.before_update4"
            
      #end add-point  
      
      #將遮罩欄位還原
      CALL artt622_rtie_t_mask_restore('restore_mask_o')
               
      UPDATE rtie_t 
         SET (rtiedocno,
              rtieseq,rtieseq1
              ,rtie001,rtie002,rtie006) 
              = 
             (ps_keys[1],ps_keys[2],ps_keys[3]
              ,g_rtib4_d[g_detail_idx].rtie001,g_rtib4_d[g_detail_idx].rtie002,g_rtib4_d[g_detail_idx].rtie006)  
 
         WHERE rtieent = g_enterprise AND rtiedocno = ps_keys_bak[1] AND rtieseq = ps_keys_bak[2] AND rtieseq1 = ps_keys_bak[3]
      #add-point:update_b段修改中 name="update_b.m_update4"
            
      #end add-point  
      CASE
         WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "rtie_t" 
            LET g_errparam.code = "std-00009" 
            LET g_errparam.popup = TRUE 
            CALL s_transaction_end('N','0')
            CALL cl_err()
            
         WHEN SQLCA.SQLCODE #其他錯誤
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "rtie_t:",SQLERRMESSAGE 
            LET g_errparam.code = SQLCA.SQLCODE 
            LET g_errparam.popup = TRUE 
            CALL s_transaction_end('N','0')
            CALL cl_err()
            
         OTHERWISE
          
      END CASE
      
      #將遮罩欄位進行遮蔽
      CALL artt622_rtie_t_mask_restore('restore_mask_n')
 
      #add-point:update_b段修改後 name="update_b.after_update4"
            
      #end add-point  
   END IF
 
   #子表處理
   IF ls_group.getIndexOf(ps_page,1) > 0 THEN
      
   END IF
 
   LET ls_group = "'5',"
   #判斷是否是同一群組的table
   IF ls_group.getIndexOf(ps_page,1) > 0 AND ps_table <> "rtik_t" THEN
      #add-point:update_b段修改前 name="update_b.before_update5"
            
      #end add-point  
      
      #將遮罩欄位還原
      CALL artt622_rtik_t_mask_restore('restore_mask_o')
               
      UPDATE rtik_t 
         SET (rtikdocno,
              rtikseq
              ,rtiksite,rtikunit,rtikorg,rtik001,rtik002,rtik003,rtik004,rtik005,rtik006,rtik007,rtik013,rtik012,rtik008,rtik009,rtik010,rtik011,rtik014,rtik015,rtik016,rtik017,rtik018,rtik019,rtik020,rtik021,rtik022,rtik023) 
              = 
             (ps_keys[1],ps_keys[2]
              ,g_rtib5_d[g_detail_idx].rtiksite,g_rtib5_d[g_detail_idx].rtikunit,g_rtib5_d[g_detail_idx].rtikorg, 
                  g_rtib5_d[g_detail_idx].rtik001,g_rtib5_d[g_detail_idx].rtik002,g_rtib5_d[g_detail_idx].rtik003, 
                  g_rtib5_d[g_detail_idx].rtik004,g_rtib5_d[g_detail_idx].rtik005,g_rtib5_d[g_detail_idx].rtik006, 
                  g_rtib5_d[g_detail_idx].rtik007,g_rtib5_d[g_detail_idx].rtik013,g_rtib5_d[g_detail_idx].rtik012, 
                  g_rtib5_d[g_detail_idx].rtik008,g_rtib5_d[g_detail_idx].rtik009,g_rtib5_d[g_detail_idx].rtik010, 
                  g_rtib5_d[g_detail_idx].rtik011,g_rtib5_d[g_detail_idx].rtik014,g_rtib5_d[g_detail_idx].rtik015, 
                  g_rtib5_d[g_detail_idx].rtik016,g_rtib5_d[g_detail_idx].rtik017,g_rtib5_d[g_detail_idx].rtik018, 
                  g_rtib5_d[g_detail_idx].rtik019,g_rtib5_d[g_detail_idx].rtik020,g_rtib5_d[g_detail_idx].rtik021, 
                  g_rtib5_d[g_detail_idx].rtik022,g_rtib5_d[g_detail_idx].rtik023) 
         WHERE rtikent = g_enterprise AND rtikdocno = ps_keys_bak[1] AND rtikseq = ps_keys_bak[2]
      #add-point:update_b段修改中 name="update_b.m_update5"
            
      #end add-point  
      CASE
         WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "rtik_t" 
            LET g_errparam.code = "std-00009" 
            LET g_errparam.popup = TRUE 
            CALL s_transaction_end('N','0')
            CALL cl_err()
            
         WHEN SQLCA.SQLCODE #其他錯誤
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "rtik_t:",SQLERRMESSAGE 
            LET g_errparam.code = SQLCA.SQLCODE 
            LET g_errparam.popup = TRUE 
            CALL s_transaction_end('N','0')
            CALL cl_err()
            
         OTHERWISE
          
      END CASE
      
      #將遮罩欄位進行遮蔽
      CALL artt622_rtik_t_mask_restore('restore_mask_n')
 
      #add-point:update_b段修改後 name="update_b.after_update5"
            
      #end add-point  
   END IF
 
   #子表處理
   IF ls_group.getIndexOf(ps_page,1) > 0 THEN
      
   END IF
 
   LET ls_group = "'6',"
   #判斷是否是同一群組的table
   IF ls_group.getIndexOf(ps_page,1) > 0 AND ps_table <> "rtin_t" THEN
      #add-point:update_b段修改前 name="update_b.before_update6"
            
      #end add-point  
      
      #將遮罩欄位還原
      CALL artt622_rtin_t_mask_restore('restore_mask_o')
               
      UPDATE rtin_t 
         SET (rtindocno,
              rtinseq,rtinseq1
              ,rtinsite,rtin001,rtin002,rtin003,rtin004,rtin005,rtin006,rtin007,rtin008,rtin009,rtin010) 
              = 
             (ps_keys[1],ps_keys[2],ps_keys[3]
              ,g_rtib6_d[g_detail_idx].rtinsite,g_rtib6_d[g_detail_idx].rtin001,g_rtib6_d[g_detail_idx].rtin002, 
                  g_rtib6_d[g_detail_idx].rtin003,g_rtib6_d[g_detail_idx].rtin004,g_rtib6_d[g_detail_idx].rtin005, 
                  g_rtib6_d[g_detail_idx].rtin006,g_rtib6_d[g_detail_idx].rtin007,g_rtib6_d[g_detail_idx].rtin008, 
                  g_rtib6_d[g_detail_idx].rtin009,g_rtib6_d[g_detail_idx].rtin010) 
         WHERE rtinent = g_enterprise AND rtindocno = ps_keys_bak[1] AND rtinseq = ps_keys_bak[2] AND rtinseq1 = ps_keys_bak[3]
      #add-point:update_b段修改中 name="update_b.m_update6"
            
      #end add-point  
      CASE
         WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "rtin_t" 
            LET g_errparam.code = "std-00009" 
            LET g_errparam.popup = TRUE 
            CALL s_transaction_end('N','0')
            CALL cl_err()
            
         WHEN SQLCA.SQLCODE #其他錯誤
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "rtin_t:",SQLERRMESSAGE 
            LET g_errparam.code = SQLCA.SQLCODE 
            LET g_errparam.popup = TRUE 
            CALL s_transaction_end('N','0')
            CALL cl_err()
            
         OTHERWISE
          
      END CASE
      
      #將遮罩欄位進行遮蔽
      CALL artt622_rtin_t_mask_restore('restore_mask_n')
 
      #add-point:update_b段修改後 name="update_b.after_update6"
            
      #end add-point  
   END IF
 
   #子表處理
   IF ls_group.getIndexOf(ps_page,1) > 0 THEN
      
   END IF
 
   LET ls_group = "'7',"
   #判斷是否是同一群組的table
   IF ls_group.getIndexOf(ps_page,1) > 0 AND ps_table <> "prek_t" THEN
      #add-point:update_b段修改前 name="update_b.before_update7"
            
      #end add-point  
      
      #將遮罩欄位還原
      CALL artt622_prek_t_mask_restore('restore_mask_o')
               
      UPDATE prek_t 
         SET (prekdocno,
              prekseq
              ,preksite,prekunit,prek001,prek002,prek003,prek004) 
              = 
             (ps_keys[1],ps_keys[2]
              ,g_rtib7_d[g_detail_idx].preksite,g_rtib7_d[g_detail_idx].prekunit,g_rtib7_d[g_detail_idx].prek001, 
                  g_rtib7_d[g_detail_idx].prek002,g_rtib7_d[g_detail_idx].prek003,g_rtib7_d[g_detail_idx].prek004)  
 
         WHERE prekent = g_enterprise AND prekdocno = ps_keys_bak[1] AND prekseq = ps_keys_bak[2]
      #add-point:update_b段修改中 name="update_b.m_update7"
            
      #end add-point  
      CASE
         WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "prek_t" 
            LET g_errparam.code = "std-00009" 
            LET g_errparam.popup = TRUE 
            CALL s_transaction_end('N','0')
            CALL cl_err()
            
         WHEN SQLCA.SQLCODE #其他錯誤
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "prek_t:",SQLERRMESSAGE 
            LET g_errparam.code = SQLCA.SQLCODE 
            LET g_errparam.popup = TRUE 
            CALL s_transaction_end('N','0')
            CALL cl_err()
            
         OTHERWISE
          
      END CASE
      
      #將遮罩欄位進行遮蔽
      CALL artt622_prek_t_mask_restore('restore_mask_n')
 
      #add-point:update_b段修改後 name="update_b.after_update7"
            
      #end add-point  
   END IF
 
   #子表處理
   IF ls_group.getIndexOf(ps_page,1) > 0 THEN
      
   END IF
 
 
   
 
   
   #add-point:update_b段other name="update_b.other"
   #add by yangxf ----start----
   IF g_prog = 'artt700' THEN 
      LET g_rtib_d[g_detail_idx].rtib012 = g_rtib_d[g_detail_idx].rtib012*(-1)
      LET g_rtib_d[g_detail_idx].rtib017 = g_rtib_d[g_detail_idx].rtib017*(-1)
      LET g_rtib_d[g_detail_idx].rtib020 = g_rtib_d[g_detail_idx].rtib020*(-1)
      LET g_rtib_d[g_detail_idx].rtib021 = g_rtib_d[g_detail_idx].rtib021*(-1)
      LET g_rtib_d[g_detail_idx].rtib022 = g_rtib_d[g_detail_idx].rtib022*(-1)
      LET g_rtib_d[g_detail_idx].rtib031 = g_rtib_d[g_detail_idx].rtib031*(-1)
   END IF 
   #add by yangxf -----end-----
   #end add-point  
   
END FUNCTION
 
{</section>}
 
{<section id="artt622.key_update_b" >}
#+ 上層單身key欄位變動後, 連帶修正下層單身key欄位
PRIVATE FUNCTION artt622_key_update_b(ps_keys_bak,ps_table)
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
 
{<section id="artt622.key_delete_b" >}
#+ 上層單身刪除後, 連帶刪除下層單身key欄位
PRIVATE FUNCTION artt622_key_delete_b(ps_keys_bak,ps_table)
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
 
{<section id="artt622.lock_b" >}
#+ 連動lock其他單身table資料
PRIVATE FUNCTION artt622_lock_b(ps_table,ps_page)
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
   #CALL artt622_b_fill()
   
   #鎖定整組table
   #LET ls_group = "'1',"
   #僅鎖定自身table
   LET ls_group = "rtib_t"
   
   IF ls_group.getIndexOf(ps_table,1) THEN
      OPEN artt622_bcl USING g_enterprise,
                                       g_rtia_m.rtiadocno,g_rtib_d[g_detail_idx].rtibseq     
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "artt622_bcl:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = TRUE 
         CALL cl_err()
         RETURN FALSE
      END IF
   END IF
                                    
   #鎖定整組table
   #LET ls_group = "'2',"
   #僅鎖定自身table
   LET ls_group = "rtic_t"
   IF ls_group.getIndexOf(ps_table,1) THEN
   
      OPEN artt622_bcl2 USING g_enterprise,
                                             g_rtia_m.rtiadocno,g_rtib2_d[g_detail_idx].rticseq,g_rtib2_d[g_detail_idx].rticseq1 
 
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "artt622_bcl2:",SQLERRMESSAGE 
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
   
      OPEN artt622_bcl3 USING g_enterprise,
                                             g_rtia_m.rtiadocno,g_rtib3_d[g_detail_idx].xrcdld,g_rtib3_d[g_detail_idx].xrcdseq, 
                                                 g_rtib3_d[g_detail_idx].xrcdseq2,g_rtib3_d[g_detail_idx].xrcd007 
 
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "artt622_bcl3:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = TRUE 
         CALL cl_err()
         RETURN FALSE
      END IF
   END IF
 
   #鎖定整組table
   #LET ls_group = "'4',"
   #僅鎖定自身table
   LET ls_group = "rtie_t"
   IF ls_group.getIndexOf(ps_table,1) THEN
   
      OPEN artt622_bcl4 USING g_enterprise,
                                             g_rtia_m.rtiadocno,g_rtib4_d[g_detail_idx].rtieseq,g_rtib4_d[g_detail_idx].rtieseq1 
 
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "artt622_bcl4:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = TRUE 
         CALL cl_err()
         RETURN FALSE
      END IF
   END IF
 
   #鎖定整組table
   #LET ls_group = "'5',"
   #僅鎖定自身table
   LET ls_group = "rtik_t"
   IF ls_group.getIndexOf(ps_table,1) THEN
   
      OPEN artt622_bcl5 USING g_enterprise,
                                             g_rtia_m.rtiadocno,g_rtib5_d[g_detail_idx].rtikseq
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "artt622_bcl5:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = TRUE 
         CALL cl_err()
         RETURN FALSE
      END IF
   END IF
 
   #鎖定整組table
   #LET ls_group = "'6',"
   #僅鎖定自身table
   LET ls_group = "rtin_t"
   IF ls_group.getIndexOf(ps_table,1) THEN
   
      OPEN artt622_bcl6 USING g_enterprise,
                                             g_rtia_m.rtiadocno,g_rtib6_d[g_detail_idx].rtinseq,g_rtib6_d[g_detail_idx].rtinseq1 
 
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "artt622_bcl6:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = TRUE 
         CALL cl_err()
         RETURN FALSE
      END IF
   END IF
 
   #鎖定整組table
   #LET ls_group = "'7',"
   #僅鎖定自身table
   LET ls_group = "prek_t"
   IF ls_group.getIndexOf(ps_table,1) THEN
   
      OPEN artt622_bcl7 USING g_enterprise,
                                             g_rtia_m.rtiadocno,g_rtib7_d[g_detail_idx].prekseq
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "artt622_bcl7:",SQLERRMESSAGE 
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
 
{<section id="artt622.unlock_b" >}
#+ 連動unlock其他單身table資料
PRIVATE FUNCTION artt622_unlock_b(ps_table,ps_page)
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
      CLOSE artt622_bcl
   END IF
   
   LET ls_group = "'2',"
   
   IF ls_group.getIndexOf(ps_page,1) THEN
      CLOSE artt622_bcl2
   END IF
 
   LET ls_group = "'3',"
   
   IF ls_group.getIndexOf(ps_page,1) THEN
      CLOSE artt622_bcl3
   END IF
 
   LET ls_group = "'4',"
   
   IF ls_group.getIndexOf(ps_page,1) THEN
      CLOSE artt622_bcl4
   END IF
 
   LET ls_group = "'5',"
   
   IF ls_group.getIndexOf(ps_page,1) THEN
      CLOSE artt622_bcl5
   END IF
 
   LET ls_group = "'6',"
   
   IF ls_group.getIndexOf(ps_page,1) THEN
      CLOSE artt622_bcl6
   END IF
 
   LET ls_group = "'7',"
   
   IF ls_group.getIndexOf(ps_page,1) THEN
      CLOSE artt622_bcl7
   END IF
 
 
   
 
 
   #add-point:unlock_b段other name="unlock_b.other"
      
   #end add-point  
 
END FUNCTION
 
{</section>}
 
{<section id="artt622.set_entry" >}
#+ 單頭欄位開啟設定
PRIVATE FUNCTION artt622_set_entry(p_cmd)
   #add-point:set_entry段define(客製用) name="set_entry.define_customerization"
   
   #end add-point       
   DEFINE p_cmd   LIKE type_t.chr1  
   #add-point:set_entry段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_entry.define"
   DEFINE l_n     LIKE type_t.num5   #add by yangxf
   #end add-point       
   
   #add-point:Function前置處理  name="set_entry.pre_function"
   
   #end add-point
   
   CALL cl_set_comp_entry("rtiadocno",TRUE)
   
   IF p_cmd = 'a' THEN
      CALL cl_set_comp_entry("rtiadocno",TRUE)
      CALL cl_set_comp_entry("rtiadocdt",TRUE)
      #根據azzi850使用者身分開關特定欄位
      IF NOT cl_null(g_no_entry) THEN
         CALL cl_set_comp_entry(g_no_entry,TRUE)
      END IF
      #add-point:set_entry段欄位控制 name="set_entry.field_control"
                  CALL cl_set_comp_entry("rtiasite",TRUE)
                  CALL cl_set_comp_entry("rtia007",TRUE)
      #end add-point  
   END IF
   
   #add-point:set_entry段欄位控制後 name="set_entry.after_control"
   IF cl_null(g_rtia_m.rtia001) THEN 
      CALL cl_set_comp_entry("rtia002",TRUE)
   ELSE
      CALL cl_set_comp_entry("rtia002",FALSE)
   END IF 
   IF g_rtia_m.rtia032 = '1' THEN 
      CALL cl_set_comp_entry("rtia036,rtia037,rtia038",TRUE)
   ELSE
      CALL cl_set_comp_entry("rtia036,rtia037,rtia038",FALSE)   
   END IF 
   #add by yangxf ---start----检查单身是否有资料，有资料则关闭来源单号栏位
   IF NOT cl_null(g_rtia_m.rtiadocno) THEN 
      LET l_n = 0
      SELECT COUNT(*) INTO l_n
        FROM rtib_t
       WHERE rtibent = g_enterprise
         AND rtibdocno  = g_rtia_m.rtiadocno
      IF l_n > 0 THEN 
         CALL cl_set_comp_entry("rtia007",FALSE)
      ELSE
         CALL cl_set_comp_entry("rtia007",TRUE)
      END IF 
   END IF 
   #add by yangxf ---end------
   #end add-point 
 
END FUNCTION
 
{</section>}
 
{<section id="artt622.set_no_entry" >}
#+ 單頭欄位關閉設定
PRIVATE FUNCTION artt622_set_no_entry(p_cmd)
   #add-point:set_no_entry段define(客製用) name="set_no_entry.define_customerization"
   
   #end add-point     
   DEFINE p_cmd   LIKE type_t.chr1   
   #add-point:set_no_entry段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_no_entry.define"
      
   #end add-point     
   
   #add-point:Function前置處理  name="set_no_entry.pre_function"
   
   #end add-point
   
   IF p_cmd = 'u' AND g_chkey = 'N' THEN
      CALL cl_set_comp_entry("rtiadocno",FALSE)
      #根據azzi850使用者身分開關特定欄位
      IF NOT cl_null(g_no_entry) THEN
         CALL cl_set_comp_entry(g_no_entry,FALSE)
      END IF
      #add-point:set_no_entry段欄位控制 name="set_no_entry.field_control"
                  CALL cl_set_comp_entry("rtiasite",FALSE)
      #end add-point 
   END IF 
   
   IF p_cmd = 'u' THEN  #docno,ld欄位確認是絕對關閉
      CALL cl_set_comp_entry("rtiadocno",FALSE)
   END IF 
 
#  IF p_cmd = 'u' THEN  #docdt欄位依照設定關閉(FALSE則為設定不同意修正) #(ver:78)
      IF NOT cl_chk_update_docdt() THEN
         CALL cl_set_comp_entry("rtiadocdt",FALSE)
      END IF
#  END IF 
   
   #add-point:set_no_entry段欄位控制後 name="set_no_entry.after_control"
   IF NOT s_aooi500_comp_entry(g_prog,'rtiasite') OR g_site_flag THEN
      CALL cl_set_comp_entry("rtiasite",FALSE)
   END IF 
   #20150630--add by yangxf--str---
   IF NOT cl_null(g_rtia_m.rtia007) THEN 
      CALL cl_set_comp_entry("rtia001,rtia002",FALSE)
   ELSE
      CALL cl_set_comp_entry("rtia001,rtia002",TRUE)
      IF NOT cl_null(g_rtia_m.rtia001) THEN 
         CALL cl_set_comp_entry("rtia002",FALSE)
      END IF 
   END IF 
   #20150630--add by yangxf--end---
   #end add-point 
 
END FUNCTION
 
{</section>}
 
{<section id="artt622.set_entry_b" >}
#+ 單身欄位開啟設定
PRIVATE FUNCTION artt622_set_entry_b(p_cmd)
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
#mark by yangxf ----start---
#   IF g_aw = "s_detail1" THEN                  #150427-00001#8 150527 by lori522612 add
#      IF cl_null(g_rtia_m.rtia007) THEN 
#         CALL cl_set_comp_entry("rtib001",TRUE)
#      END IF 
#      #150424-00020#2--add by dongsz--str---
#      CALL cl_set_comp_entry("rtibseq,rtib003,rtib008,rtib009,rtib010,rtib012,rtib024,rtib028",TRUE)  
#      #150424-00020#2--add by dongsz--end---
#      
#      CALL cl_set_comp_entry("rtib027",TRUE)   #150427-00001#8 150527 by lori522612 add
#   END IF                                      #150427-00001#8 150527 by lori522612 add
#mark by yangxf ----end-----
   #add by yagnxf ---start---
   IF g_prog = 'artt800' THEN
      CALL cl_set_comp_entry("rtib001,rtib002,rtib003,rtib004,rtib012,rtib024,rtib025,rtib026,rtib027,rtib028,rtib024,rtib032,rtib033,rtib035",FALSE)  
   ELSE
      CALL cl_set_comp_entry("rtib001,rtib002,rtib003,rtib004,rtib012,rtib035",TRUE)  
   END IF 
   #add by yangxf 20151127----start-----
   IF g_prog = 'artt620' THEN 
      CALL cl_set_comp_entry('rtib010',TRUE)
      CALL cl_set_comp_required('rtib010',TRUE)
   END IF 
   #add by yangxf 20151127----end-----
   #add by yagnxf ---end-----
   #160419-00044#2--dongsz add--str
   IF g_prog = 'artt622' OR g_prog = 'artt610' OR g_prog = 'artt620' THEN
      CALL cl_set_comp_entry('rtib027',TRUE)
   END IF
   #160419-00044#2--dongsz add--end
   CALL cl_set_comp_entry('rtib010',TRUE)    #160604-00009#85 dongsz add
   CALL cl_set_comp_entry('rtib042',TRUE)    #160604-00009#85 dongsz add
   #end add-point  
END FUNCTION
 
{</section>}
 
{<section id="artt622.set_no_entry_b" >}
#+ 單身欄位關閉設定
PRIVATE FUNCTION artt622_set_no_entry_b(p_cmd)
   #add-point:set_no_entry_b段define(客製用) name="set_no_entry_b.define_customerization"
   
   #end add-point    
   DEFINE p_cmd   LIKE type_t.chr1   
   #add-point:set_no_entry_b段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_no_entry_b.define"
   DEFINE l_success         LIKE type_t.num5       #150427-00001#8 150527 by lori522612 add
   DEFINE l_set_entry       LIKE type_t.num5       #150427-00001#8 150527 by lori522612 add      
   DEFINE l_slip            LIKE ooba_t.ooba002    #單據別  #160419-00044#2 dongsz add
   DEFINE l_gzcb002         LIKE gzcb_t.gzcb002    #批號沖減方式  #160419-00044#2 dongsz add
   #end add-point    
   
   #add-point:Function前置處理  name="set_no_entry_b.pre_function"
   
   #end add-point
   
   IF p_cmd = 'u' AND g_chkey = 'N' THEN
      CALL cl_set_comp_entry("",FALSE)
      #add-point:set_no_entry_b段欄位控制 name="set_no_entry_b.field_control"
      
      #end add-point 
   END IF 
   
   #add-point:set_no_entry_b段 name="set_no_entry_b.set_no_entry_b"
   IF g_aw = "s_detail1" THEN                  #150427-00001#8 150527 by lori522612 add
      IF NOT cl_null(g_rtia_m.rtia007) THEN 
         CALL cl_set_comp_entry("rtib001",FALSE)
      END IF
      #150424-00020#2--add by dongsz--str---
      IF g_prog = 'artt600' THEN
         CALL cl_set_comp_entry("rtibseq,rtib001,rtib002,rtib003,rtib008,rtib009,rtib010,rtib012,rtib024,rtib028",FALSE)
      END IF
      #150424-00020#2--add by dongsz--end---
      
      #150427-00001#8 150527 by lori522612 add---(S)
#mark by yagnxf ----start----      
#      IF l_ac > 0 THEN
#         LET l_success = ''  
#         LET l_set_entry = ''
#         
#         CALL s_lot_out_entry(-1,g_rtia_m.rtiadocno,g_rtia_m.rtiasite,g_rtib_d[l_ac].rtib004)   
#            RETURNING l_success,l_set_entry
#         IF l_success THEN
#            CALL cl_set_comp_entry("rtib027",l_set_entry) 
#         END IF     
#      END IF
#mark by yangxf ---end----
      #150427-00001#8 150527 by lori522612 add---(E)
   END IF   #150427-00001#8 150527 by lori522612 add
   #150424-00020#2--add by dongsz--str---
   IF g_prog = 'artt600' THEN
      CALL cl_set_comp_entry("rtibseq,rtib001,rtib002,rtib003,rtib008,rtib009,rtib010,rtib012,rtib024,rtib028",FALSE)
   END IF
   #150424-00020#2--add by dongsz--end---
   #add by yangxf ---start---
   IF g_prog = 'artt610' OR g_prog = 'artt622' THEN 
      IF NOT cl_null(g_rtia_m.rtia007) THEN 
         #CALL cl_set_comp_entry("rtib035,rtib001,rtib003,rtib004",FALSE)   #160604-00009#85--dongsz mark
         CALL cl_set_comp_entry("rtib035,rtib001",FALSE)    #160604-00009#85--dongsz add
      END IF 
      IF NOT cl_null(g_rtib_d[l_ac].rtib035) THEN 
         IF g_rtib_d[l_ac].rtib035 = '1' THEN 
            CALL cl_set_comp_entry("rtib001,rtib002",FALSE)
            CALL cl_set_comp_entry("rtib003,rtib004",TRUE)
         ELSE
            #160604-00009#85--dongsz mark--s
#            IF NOT cl_null(g_rtia_m.rtia007) THEN 
#               CALL cl_set_comp_entry("rtib001,rtib003,rtib004",FALSE)
#            END IF 
            #160604-00009#85--dongsz mark--e
         END IF
      END IF 
      IF NOT cl_null(g_rtib_d[l_ac].rtib001) THEN 
         CALL cl_set_comp_entry("rtib003,rtib004",FALSE)
      END IF 
   END IF 
   if g_rtib_d[l_ac].rtib035='2' and  g_rtib_d[l_ac].rtib042='2' then 
       CALL cl_set_comp_entry("rtib010,rtib106",true)
   else
       CALL cl_set_comp_entry("rtib010,rtib106",false)
   end if 
   IF g_prog = 'artt700' THEN 
      IF NOT cl_null(g_rtia_m.rtia007) THEN 
         CALL cl_set_comp_entry("rtib001,rtib003,rtib004",FALSE)
      END IF 
      IF NOT cl_null(g_rtib_d[l_ac].rtib001) THEN 
         CALL cl_set_comp_entry("rtib003,rtib004",FALSE)
      END IF 
   END IF 
   #add by yangxf ---end----
   #160604-00009#85--dongsz add--s
   IF g_prog = 'artt622' THEN
      IF g_rtib_d[l_ac].rtib035 = '1' THEN
         CALL cl_set_comp_entry("rtib042",FALSE)
      END IF
      IF g_rtib_d[l_ac].rtib042 = '1' THEN
         CALL cl_set_comp_entry("rtib010",FALSE)
      END IF
   END IF
   #160604-00009#85--dongsz add--e
   #160419-00044#2--dongsz add--str
   IF g_prog = 'artt622' OR g_prog = 'artt610' OR g_prog = 'artt620' THEN
      #取单据别
      LET l_slip = ''
      LET l_success = ''
      CALL s_aooi200_get_slip(g_rtia_m.rtiadocno)
         RETURNING l_success,l_slip
      #取單別參數 批號沖減方式
      LET l_gzcb002 = ''
      CALL cl_get_doc_para(g_enterprise,g_rtia_m.rtiasite,l_slip,'D-CIR-0001')
         RETURNING l_gzcb002
      #當單別參數為空,取集團參數 批號沖減方式
      IF cl_null(l_gzcb002) THEN
         LET l_gzcb002 = ''
         CALL cl_get_para(g_enterprise,g_rtia_m.rtiasite,'E-CIR-0029')
            RETURNING l_gzcb002
      END IF
      IF l_gzcb002 <> '1' THEN
         CALL cl_set_comp_entry('rtib027',FALSE)
      END IF
   END IF
   #160419-00044#2--dongsz add--end
   #end add-point     
END FUNCTION
 
{</section>}
 
{<section id="artt622.set_act_visible" >}
#+ 單頭權限開啟
PRIVATE FUNCTION artt622_set_act_visible()
   #add-point:set_act_visible段define(客製用) name="set_act_visible.define_customerization"
   
   #end add-point   
   #add-point:set_act_visible段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_visible.define"
   
   #end add-point   
   #add-point:set_act_visible段 name="set_act_visible.set_act_visible"
   
   #end add-point   
END FUNCTION
 
{</section>}
 
{<section id="artt622.set_act_no_visible" >}
#+ 單頭權限關閉
PRIVATE FUNCTION artt622_set_act_no_visible()
   #add-point:set_act_no_visible段define(客製用) name="set_act_no_visible.define_customerization"
   
   #end add-point   
   #add-point:set_act_no_visible段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_no_visible.define"
   
   #end add-point   
   #add-point:set_act_no_visible段 name="set_act_no_visible.set_act_no_visible"
   #應用 a63 樣板自動產生(Version:1)
   IF g_rtia_m.rtiastus NOT MATCHES "[NDR]" THEN   # N未確認/D抽單/R已拒絕允許修改
      CALL cl_set_act_visible("modify,delete,modify_detail", FALSE)
   END IF
   CALL cl_set_act_visible("delete", FALSE)

   #end add-point   
END FUNCTION
 
{</section>}
 
{<section id="artt622.set_act_visible_b" >}
#+ 單身權限開啟
PRIVATE FUNCTION artt622_set_act_visible_b()
   #add-point:set_act_visible_b段define(客製用) name="set_act_visible_b.define_customerization"
   
   #end add-point   
   #add-point:set_act_visible_b段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_visible_b.define"
   
   #end add-point   
   #add-point:set_act_visible_b段 name="set_act_visible_b.set_act_visible_b"
   
   #end add-point   
END FUNCTION
 
{</section>}
 
{<section id="artt622.set_act_no_visible_b" >}
#+ 單身權限關閉
PRIVATE FUNCTION artt622_set_act_no_visible_b()
   #add-point:set_act_no_visible_b段define(客製用) name="set_act_no_visible_b.define_customerization"
   
   #end add-point   
   #add-point:set_act_no_visible_b段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_no_visible_b.define"
   
   #end add-point   
   #add-point:set_act_no_visible_b段 name="set_act_no_visible_b.set_act_no_visible_b"
   
   #end add-point   
END FUNCTION
 
{</section>}
 
{<section id="artt622.default_search" >}
#+ 外部參數搜尋
PRIVATE FUNCTION artt622_default_search()
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
   
   IF NOT cl_null(g_argv[02]) THEN
      LET ls_wc = ls_wc, " rtiadocno = '", g_argv[02], "' AND "
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
 
         INITIALIZE g_wc2_table4 TO NULL
 
         INITIALIZE g_wc2_table5 TO NULL
 
         INITIALIZE g_wc2_table6 TO NULL
 
         INITIALIZE g_wc2_table7 TO NULL
 
 
         FOR li_idx = 1 TO la_wc.getLength()
            CASE
               WHEN la_wc[li_idx].tableid = "rtia_t" 
                  LET g_wc = la_wc[li_idx].wc
               WHEN la_wc[li_idx].tableid = "rtib_t" 
                  LET g_wc2_table1 = la_wc[li_idx].wc
               WHEN la_wc[li_idx].tableid = "rtic_t" 
                  LET g_wc2_table2 = la_wc[li_idx].wc
 
               WHEN la_wc[li_idx].tableid = "xrcd_t" 
                  LET g_wc2_table3 = la_wc[li_idx].wc
 
               WHEN la_wc[li_idx].tableid = "rtie_t" 
                  LET g_wc2_table4 = la_wc[li_idx].wc
 
               WHEN la_wc[li_idx].tableid = "rtik_t" 
                  LET g_wc2_table5 = la_wc[li_idx].wc
 
               WHEN la_wc[li_idx].tableid = "rtin_t" 
                  LET g_wc2_table6 = la_wc[li_idx].wc
 
               WHEN la_wc[li_idx].tableid = "prek_t" 
                  LET g_wc2_table7 = la_wc[li_idx].wc
 
 
               WHEN la_wc[li_idx].tableid = "EXTENDWC"
                  LET g_wc2_extend = la_wc[li_idx].wc
            END CASE
         END FOR
         IF NOT cl_null(g_wc) OR NOT cl_null(g_wc2_table1) 
            OR NOT cl_null(g_wc2_table2)
 
            OR NOT cl_null(g_wc2_table3)
 
            OR NOT cl_null(g_wc2_table4)
 
            OR NOT cl_null(g_wc2_table5)
 
            OR NOT cl_null(g_wc2_table6)
 
            OR NOT cl_null(g_wc2_table7)
 
 
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
 
            IF g_wc2_table4 <> " 1=1" AND NOT cl_null(g_wc2_table4) THEN
               LET g_wc2 = g_wc2 ," AND ", g_wc2_table4
            END IF
 
            IF g_wc2_table5 <> " 1=1" AND NOT cl_null(g_wc2_table5) THEN
               LET g_wc2 = g_wc2 ," AND ", g_wc2_table5
            END IF
 
            IF g_wc2_table6 <> " 1=1" AND NOT cl_null(g_wc2_table6) THEN
               LET g_wc2 = g_wc2 ," AND ", g_wc2_table6
            END IF
 
            IF g_wc2_table7 <> " 1=1" AND NOT cl_null(g_wc2_table7) THEN
               LET g_wc2 = g_wc2 ," AND ", g_wc2_table7
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

   LET g_default = FALSE
#   #預設查詢條件
#   LET g_wc = cl_qbe_get_default_qryplan()
   IF cl_null(g_wc) THEN
      LET g_wc = " 1=1"
   END IF
   IF g_prog = 'artt610' THEN 
      LET g_wc = g_wc CLIPPED," AND rtia000 = 'artt610' "
   END IF 
   IF g_prog = 'artt622' THEN 
      LET g_wc = g_wc CLIPPED," AND rtia000 = 'artt622' "
   END IF 
   IF g_prog = 'artt700' THEN 
      LET g_wc = g_wc CLIPPED," AND rtia000 = 'artt700' "
   END IF 
   IF g_prog = 'artt800' THEN 
      LET g_wc = g_wc CLIPPED," AND rtia000 = 'artt800' "
   END IF 
   #end add-point  
 
   IF g_wc.getIndexOf(" 1=2", 1) THEN
      LET g_default = TRUE
   END IF
 
 
END FUNCTION
 
{</section>}
 
{<section id="artt622.state_change" >}
   #應用 a09 樣板自動產生(Version:17)
#+ 確認碼變更 
PRIVATE FUNCTION artt622_statechange()
   #add-point:statechange段define(客製用) name="statechange.define_customerization"
   
   #end add-point  
   DEFINE lc_state LIKE type_t.chr5
   #add-point:statechange段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="statechange.define"
   DEFINE l_success              LIKE type_t.num5
   DEFINE l_bl              varchar(1) 
   DEFINE l_sql             STRING
   DEFINE l_rtib004         LIKE rtib_t.rtib004
   DEFINE l_rtin001         LIKE rtin_t.rtin001
   DEFINE l_rtib012        LIKE rtib_t.rtib012
   DEFINE l_rtin009        LIKE rtin_t.rtin009   
   DEFINE l_mmaq003              LIKE mmaq_t.mmaq003
   DEFINE l_mmaq002              LIKE mmaq_t.mmaq002
   DEFINE l_card_point           LIKE rtia_t.rtia016
   DEFINE r_success              LIKE type_t.num5
   DEFINE l_oodb011              LIKE oodb_t.oodb011
   DEFINE l_rtia031              LIKE rtia_t.rtia031
   #end add-point  
   
   #add-point:Function前置處理 name="statechange.before"
   DEFINE l_date                 DATETIME YEAR TO SECOND
   DEFINE l_msg                  STRING
   DEFINE   l_ooac002      LIKE ooac_t.ooac002
   DEFINE   l_ooac004      LIKE ooac_t.ooac004
   DEFINE   l_flag1        LIKE type_t.num5  
   #end add-point  
   
   ERROR ""     #清空畫面右下側ERROR區塊
 
   IF g_rtia_m.rtiadocno IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code   = "std-00003" 
      LET g_errparam.popup  = FALSE 
      CALL cl_err()
      RETURN
   END IF
 
   CALL s_transaction_begin()
   
   OPEN artt622_cl USING g_enterprise,g_rtia_m.rtiadocno
   IF STATUS THEN
      CLOSE artt622_cl
      CALL s_transaction_end('N','0')
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "OPEN artt622_cl:" 
      LET g_errparam.code   = STATUS 
      LET g_errparam.popup  = TRUE 
      CALL cl_err()
      RETURN
   END IF
   
   #顯示最新的資料
   EXECUTE artt622_master_referesh USING g_rtia_m.rtiadocno INTO g_rtia_m.rtiasite,g_rtia_m.rtiadocdt, 
       g_rtia_m.rtiadocno,g_rtia_m.rtia002,g_rtia_m.rtia001,g_rtia_m.rtia059,g_rtia_m.rtia060,g_rtia_m.rtia004, 
       g_rtia_m.rtia005,g_rtia_m.rtia006,g_rtia_m.rtia048,g_rtia_m.rtia053,g_rtia_m.rtiastus,g_rtia_m.rtia007, 
       g_rtia_m.rtia008,g_rtia_m.rtia009,g_rtia_m.rtia043,g_rtia_m.rtia047,g_rtia_m.rtia013,g_rtia_m.rtia014, 
       g_rtia_m.rtia015,g_rtia_m.rtia016,g_rtia_m.rtia051,g_rtia_m.rtia010,g_rtia_m.rtia011,g_rtia_m.rtia012, 
       g_rtia_m.rtia041,g_rtia_m.rtia017,g_rtia_m.rtia018,g_rtia_m.rtia019,g_rtia_m.rtia020,g_rtia_m.rtia021, 
       g_rtia_m.rtia022,g_rtia_m.rtia023,g_rtia_m.rtia024,g_rtia_m.rtia025,g_rtia_m.rtia026,g_rtia_m.rtia027, 
       g_rtia_m.rtia028,g_rtia_m.rtia029,g_rtia_m.rtia030,g_rtia_m.rtia032,g_rtia_m.rtia033,g_rtia_m.rtia034, 
       g_rtia_m.rtia035,g_rtia_m.rtia036,g_rtia_m.rtia037,g_rtia_m.rtia038,g_rtia_m.rtia039,g_rtia_m.rtia107, 
       g_rtia_m.rtiaownid,g_rtia_m.rtiacrtid,g_rtia_m.rtiaowndp,g_rtia_m.rtiacrtdp,g_rtia_m.rtiacrtdt, 
       g_rtia_m.rtiamodid,g_rtia_m.rtiamoddt,g_rtia_m.rtiacnfid,g_rtia_m.rtiacnfdt,g_rtia_m.rtiapstid, 
       g_rtia_m.rtiapstdt,g_rtia_m.rtiasite_desc,g_rtia_m.rtia002_desc,g_rtia_m.rtia004_desc,g_rtia_m.rtia005_desc, 
       g_rtia_m.rtia009_desc,g_rtia_m.rtia010_desc,g_rtia_m.rtia011_desc,g_rtia_m.rtia012_desc,g_rtia_m.rtia018_desc, 
       g_rtia_m.rtia024_desc,g_rtia_m.rtia025_desc,g_rtia_m.rtia036_desc,g_rtia_m.rtia037_desc,g_rtia_m.rtia038_desc, 
       g_rtia_m.rtiaownid_desc,g_rtia_m.rtiacrtid_desc,g_rtia_m.rtiaowndp_desc,g_rtia_m.rtiacrtdp_desc, 
       g_rtia_m.rtiamodid_desc,g_rtia_m.rtiacnfid_desc,g_rtia_m.rtiapstid_desc
   
 
   #檢查是否允許此動作
   IF NOT artt622_action_chk() THEN
      CLOSE artt622_cl
      CALL s_transaction_end('N','0')
      RETURN
   END IF
 
   #將資料顯示到畫面上
   DISPLAY BY NAME g_rtia_m.rtiasite,g_rtia_m.rtiasite_desc,g_rtia_m.rtiadocdt,g_rtia_m.rtiadocno,g_rtia_m.rtia002, 
       g_rtia_m.rtia002_desc,g_rtia_m.rtia001,g_rtia_m.rtia001_desc,g_rtia_m.rtia059,g_rtia_m.rtia060, 
       g_rtia_m.mmaf003,g_rtia_m.mmaf004,g_rtia_m.rtia004,g_rtia_m.rtia004_desc,g_rtia_m.rtia005,g_rtia_m.rtia005_desc, 
       g_rtia_m.rtia006,g_rtia_m.rtia048,g_rtia_m.rtia053,g_rtia_m.rtiastus,g_rtia_m.rtia007,g_rtia_m.rtia008, 
       g_rtia_m.rtia009,g_rtia_m.rtia009_desc,g_rtia_m.rtia043,g_rtia_m.rtia047,g_rtia_m.l_rtia047,g_rtia_m.rtia013, 
       g_rtia_m.rtia014,g_rtia_m.rtia015,g_rtia_m.rtia016,g_rtia_m.rtia051,g_rtia_m.rtia010,g_rtia_m.rtia010_desc, 
       g_rtia_m.rtia011,g_rtia_m.rtia011_desc,g_rtia_m.rtia012,g_rtia_m.rtia012_desc,g_rtia_m.chantype, 
       g_rtia_m.barcode,g_rtia_m.rtia041,g_rtia_m.rtia017,g_rtia_m.rtia018,g_rtia_m.rtia018_desc,g_rtia_m.rtia019, 
       g_rtia_m.rtia020,g_rtia_m.rtia021,g_rtia_m.rtia022,g_rtia_m.rtia023,g_rtia_m.rtia024,g_rtia_m.rtia024_desc, 
       g_rtia_m.rtia025,g_rtia_m.rtia025_desc,g_rtia_m.rtia026,g_rtia_m.rtia027,g_rtia_m.rtia028,g_rtia_m.rtia029, 
       g_rtia_m.rtia030,g_rtia_m.rtia032,g_rtia_m.rtia033,g_rtia_m.rtia034,g_rtia_m.rtia035,g_rtia_m.rtia036, 
       g_rtia_m.rtia036_desc,g_rtia_m.rtia037,g_rtia_m.rtia037_desc,g_rtia_m.rtia038,g_rtia_m.rtia038_desc, 
       g_rtia_m.rtia039,g_rtia_m.rtia107,g_rtia_m.isaf009,g_rtia_m.isaf010,g_rtia_m.isaf044,g_rtia_m.isaf202, 
       g_rtia_m.isaf203,g_rtia_m.isaf204,g_rtia_m.isaf201,g_rtia_m.isaf207,g_rtia_m.rtiaownid,g_rtia_m.rtiaownid_desc, 
       g_rtia_m.rtiacrtid,g_rtia_m.rtiacrtid_desc,g_rtia_m.rtiaowndp,g_rtia_m.rtiaowndp_desc,g_rtia_m.rtiacrtdp, 
       g_rtia_m.rtiacrtdp_desc,g_rtia_m.rtiacrtdt,g_rtia_m.rtiamodid,g_rtia_m.rtiamodid_desc,g_rtia_m.rtiamoddt, 
       g_rtia_m.rtiacnfid,g_rtia_m.rtiacnfid_desc,g_rtia_m.rtiacnfdt,g_rtia_m.rtiapstid,g_rtia_m.rtiapstid_desc, 
       g_rtia_m.rtiapstdt,g_rtia_m.snum,g_rtia_m.amount,g_rtia_m.amount2,g_rtia_m.amount3
 
   CASE g_rtia_m.rtiastus
      WHEN "N"
         CALL gfrm_curr.setElementImage("statechange", "stus/32/unconfirmed.png")
      WHEN "Y"
         CALL gfrm_curr.setElementImage("statechange", "stus/32/confirmed.png")
      WHEN "S"
         CALL gfrm_curr.setElementImage("statechange", "stus/32/posted.png")
      WHEN "Z"
         CALL gfrm_curr.setElementImage("statechange", "stus/32/unposted.png")
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
         CASE g_rtia_m.rtiastus
            
            WHEN "N"
               HIDE OPTION "unconfirmed"
            WHEN "Y"
               HIDE OPTION "confirmed"
            WHEN "S"
               HIDE OPTION "posted"
            WHEN "Z"
               HIDE OPTION "unposted"
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
         CALL cl_set_act_visible("unconfirmed,invalid,confirmed,posted,approved,withdraw,rejection,signing,unposted",TRUE)
         CALL cl_set_act_visible("reconciliate,unreconciliate",FALSE)
         CASE g_rtia_m.rtiastus
            WHEN "N"
               #HIDE OPTION "open"
               CALL cl_set_act_visible("unconfirmed,posted,approved,withdraw,rejection,signing,unposted",FALSE)
               #需提交至BPM時，則顯示「提交」功能並隱藏「確認」功能
               IF cl_bpm_chk() THEN
                   CALL cl_set_act_visible("signing",TRUE)
               END IF

            WHEN "S"
               #HIDE OPTION "posted"
               CALL cl_set_act_visible("unconfirmed,invalid,confirmed,posted,approved,withdraw,rejection,signing",FALSE)

            WHEN "X"
               #HIDE OPTION "invalid"
               CALL cl_set_act_visible("invalid,unconfirmed,confirmed,posted,unposted,approved,withdraw,rejection,signing",FALSE)

            WHEN "Y"
               #HIDE OPTION "confirmed"
#               CALL cl_set_act_visible("invalid,confirmed,posted,unposted,approved,withdraw,rejection,signing",FALSE)   #160701-00025
               CALL cl_set_act_visible("invalid,confirmed,unposted,approved,withdraw,rejection,signing",FALSE)   #160701-00025

            WHEN "A"
               CALL cl_set_act_visible("invalid,unconfirmed,posted,approved,withdraw,rejection,signing",FALSE)
               
            WHEN "D"
               CALL cl_set_act_visible("linvaid,unconfirmed,confirmed,posted,approved,withdraw,rejection,signing",FALSE)
               
            WHEN "R"
               CALL cl_set_act_visible("unconfirmed,confirmed,posted,approved,withdraw,rejection,signing",FALSE)
               
            WHEN "W"
               CALL cl_set_act_visible("invalid,unconfirmed,confirmed,posted,approved,rejection,signing",FALSE)
         END CASE
      #end add-point
      
      #應用 a36 樣板自動產生(Version:5)
      #提交
      ON ACTION signing
         IF cl_auth_chk_act("signing") THEN
            IF NOT artt622_send() THEN
               CALL s_transaction_end('N','0')
            ELSE
               CALL s_transaction_end('Y','0')
            END IF
            #因應簽核行為, 該動作完成後不再進行後續處理
            #於此處直接返回
            CLOSE artt622_cl
            RETURN
         END IF
    
      #抽單
      ON ACTION withdraw
         IF cl_auth_chk_act("withdraw") THEN
            IF NOT artt622_draw_out() THEN
               CALL s_transaction_end('N','0')
            ELSE
               CALL s_transaction_end('Y','0')
            END IF
            #因應簽核行為, 該動作完成後不再進行後續處理
            #於此處直接返回
            CLOSE artt622_cl
            RETURN
         END IF
 
 
 
	  
      ON ACTION unconfirmed
         IF cl_auth_chk_act("unconfirmed") THEN
            LET lc_state = "N"
            #add-point:action控制 name="statechange.unconfirmed"
         IF NOT cl_ask_confirm('aim-00110') THEN
            CALL s_transaction_end('N','0')   #160816-00068#09 by 08209 add
            RETURN
         END IF 
         CALL s_artt622_unconf_chk(g_rtia_m.rtiadocno,g_rtia_m.rtiastus) RETURNING l_success,g_errno
         IF l_success THEN 
            CALL s_transaction_begin()
#            IF NOT cl_null(g_rtia_m.rtia001) THEN 
#               CALL s_card_point_del(g_rtia_m.rtia001,'A',g_rtia_m.rtiadocno,g_rtia_m.rtia016,'','')  #150505-00002#1 add '',''
#                    RETURNING l_success
#               IF NOT l_success THEN
#                  CALL s_transaction_end('N','0')
#                  RETURN
#               ELSE
#                  CALL s_transaction_end('Y','0')
#               END IF
#               CALL s_transaction_begin()
#            END IF 
            CALL s_artt622_unconf_upd(g_rtia_m.rtiadocno) RETURNING l_success
            IF NOT l_success THEN
               CALL s_transaction_end('N','0')
               RETURN
            ELSE
               CALL s_transaction_end('Y','0')
               CALL artt622_b_fill()              #150427-00001#9 150603 By pomelo add
            END IF
         ELSE
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = g_errno
            LET g_errparam.extend = g_rtia_m.rtiadocno
            LET g_errparam.popup = TRUE
            CALL cl_err()
            CALL s_transaction_end('N','0')   #160816-00068#09 by 08209 add
            RETURN 
         END IF 
            #end add-point
         END IF
         EXIT MENU
      ON ACTION confirmed
         IF cl_auth_chk_act("confirmed") THEN
            LET lc_state = "Y"
            #add-point:action控制 name="statechange.confirmed"

            IF NOT cl_ask_confirm('art-00791') THEN
               CALL s_transaction_end('N','0')   #160816-00068#09 by 08209 add
               RETURN
            END IF 
            CALL s_artt622_conf_chk(g_rtia_m.rtiadocno,g_rtia_m.rtiastus) RETURNING l_success,g_errno
            IF l_success THEN 
#               CALL s_transaction_begin()   #mark by yangxf
               
               
#               IF NOT cl_null(g_rtia_m.rtia001) THEN 
#                  #计算积点
#                  CALL s_card_point_create_tmp() RETURNING r_success
#                  IF NOT r_success THEN
#                     CALL s_transaction_end('N','0')
#                     RETURN
#                  END IF 
#                  SELECT rtia031 INTO l_rtia031
#                    FROM rtia_t
#                   WHERE rtiaent = g_enterprise
#                     AND rtiadocno = g_rtia_m.rtiadocno
#                  CALL s_transaction_begin()   
#                  LET l_date = cl_get_current()
#                  #                    程式編號  單據編號           會員卡號          營運據點          交易日期          交易時間
#                  CALL s_card_point_cal(g_prog, g_rtia_m.rtiadocno,g_rtia_m.rtia001,g_rtia_m.rtiasite,g_rtia_m.rtia034,g_rtia_m.rtia035) 
#                       RETURNING r_success,l_card_point
#                  IF r_success THEN
#                     #                     會員卡號          異動來源          異動類別          異動單據編號   
#                     CALL s_card_point_add(g_rtia_m.rtia001,'1'              ,'A'             ,g_rtia_m.rtiadocno,
#                     #                     異動日期   異動組織           消費金額          本次異動積點   需求組織
#                                           l_date,   g_rtia_m.rtiasite,l_rtia031,l_card_point,g_rtia_m.rtiasite,'','') RETURNING r_success  #150505-00002#1 add '',''
#                     IF r_success THEN 
#                        CALL s_transaction_end('Y','0')
#                     ELSE
#                        CALL s_transaction_end('N','0')
#                        RETURN 
#                     END IF 
#                  ELSE
#                     CALL s_transaction_end('N','0')
#                     RETURN 
#                  END IF 
#                  CALL s_card_point_drop_tmp() RETURNING r_success
#                  IF NOT r_success THEN
#                     CALL s_transaction_end('N','0')
#                     RETURN
#                  END IF 
##                  CALL s_transaction_begin()   #mark by  yangxf
#               END IF
               #add by zn str--检查商品明细和多库储批资料
               CALL cl_err_collect_init()
               LET l_bl='Y'               
               LET l_sql = "SELECT rtib004,rtin001 FROM",
               "(SELECT DISTINCT rtib004 FROM rtib_t",
               " WHERE rtibent   = '",g_enterprise,"'",
               "   AND rtibdocno = '",g_rtia_m.rtiadocno,"')",
               "   LEFT JOIN ",
               "(SELECT DISTINCT rtin001 FROM rtin_t ",
               " WHERE rtinent = '",g_enterprise,"'",
               "   AND rtindocno = '",g_rtia_m.rtiadocno,"')",
               " ON rtib004 = rtin001"
                 PREPARE artt622_rtib001 FROM l_sql
                 DECLARE b_fill_rtib001 CURSOR FOR artt622_rtib001
                 FOREACH b_fill_rtib001 INTO l_rtib004,l_rtin001
                 IF cl_null(l_rtin001)  THEN 
         	       INITIALIZE g_errparam TO NULL
                   LET g_errparam.extend = ""
                   LET g_errparam.code   = "art-00792"
                   LET g_errparam.popup  = TRUE
                   CALL cl_err()
                   let  l_bl='N'
                   END IF
                   SELECT SUM(rtib012) INTO l_rtib012  FROM rtib_t 
                   WHERE rtibent=g_enterprise  AND rtibdocno=g_rtia_m.rtiadocno  AND rtib004=l_rtib004
                   SELECT SUM(rtin009) INTO l_rtin009 FROM rtin_t 
                   WHERE rtinent=g_enterprise  AND rtindocno=g_rtia_m.rtiadocno  AND rtin001=l_rtin001
         
                      IF l_rtib012<>l_rtin009 THEN 
                         INITIALIZE g_errparam TO NULL
                         LET g_errparam.extend = l_rtib004
                         LET g_errparam.code   = "art-00793"
                         LET g_errparam.popup  = TRUE
                         CALL cl_err()
                         let  l_bl='N'
                       END IF
                   END FOREACH
                   IF l_bl='N' THEN 
                     CALL cl_err_collect_show()
                     CALL s_transaction_end('N','0')
                     RETURN
                   END IF 
               #add by zn end 
               CALL s_transaction_begin()   
               CALL s_artt622_conf_upd(g_rtia_m.rtiadocno) RETURNING l_success
               IF NOT l_success THEN
                  CALL cl_err_collect_show()
                  CALL s_transaction_end('N','0')
                  RETURN
               ELSE
               CALL s_aooi200_get_slip(g_rtia_m.rtiadocno) RETURNING l_flag1,l_ooac002
                  CALL cl_get_doc_para(g_enterprise,g_site,l_ooac002,'D-BAS-0083') RETURNING l_ooac004
                  IF l_ooac004='Y' THEN
                        LET lc_state = 'S'
                        LET g_rtia_m.rtiastus='Y'
                        CALL s_artt622_post_chk(g_rtia_m.rtiadocno,g_rtia_m.rtiastus) RETURNING l_success,g_errno
                     IF l_success THEN             
                        CALL s_artt622_post_upd(g_rtia_m.rtiadocno) RETURNING l_success
                        IF NOT l_success THEN
                          CALL cl_err_collect_show()
                          CALL s_transaction_end('N','0')
                          RETURN
                        ELSE
                          CALL s_transaction_end('Y','0')
                          CALL artt622_b_fill() 
                        END IF
                     ELSE
                        INITIALIZE g_errparam TO NULL
                        LET g_errparam.code = g_errno
                        LET g_errparam.extend = g_rtia_m.rtiadocno
                        LET g_errparam.popup = TRUE
                        CALL cl_err()
                        CALL s_transaction_end('N','0')   #160816-00068#09 by 08209 add
                        RETURN 
                     END IF 
                  ELSE
                     CALL s_transaction_end('Y','1') 
                  END IF
                END IF
            ELSE
                INITIALIZE g_errparam TO NULL
                LET g_errparam.code = g_errno
                LET g_errparam.extend = g_rtia_m.rtiadocno
                LET g_errparam.popup = TRUE
                CALL cl_err()
                CALL s_transaction_end('N','0')   #160816-00068#09 by 08209 add
                RETURN   
            END IF
            #end add-point
         END IF
         EXIT MENU
      ON ACTION posted
         IF cl_auth_chk_act("posted") THEN
            LET lc_state = "S"
            #add-point:action控制 name="statechange.posted"
         #IF NOT cl_ask_confirm('sub-00232') THEN
         #   CALL s_transaction_end('N','0')
         #   RETURN
         #END IF 
#         CALL s_artt622_post_chk(g_rtia_m.rtiadocno,g_rtia_m.rtiastus) RETURNING l_success,g_errno
#         IF l_success THEN 
#            CALL s_transaction_begin()
#            
#            CALL s_artt622_post_upd(g_rtia_m.rtiadocno) RETURNING l_success
#            IF NOT l_success THEN
#               CALL s_transaction_end('N','0')
#               RETURN
#            ELSE
#               CALL s_transaction_end('Y','0')
#            END IF
#         ELSE
#            INITIALIZE g_errparam TO NULL
#            LET g_errparam.code = g_errno
#            LET g_errparam.extend = g_rtia_m.rtiadocno
#            LET g_errparam.popup = TRUE
#            CALL cl_err()
#            CALL s_transaction_end('N','0')
#            RETURN 
#         END IF 
                  LET lc_state = "S"
                  IF NOT cl_ask_confirm('sub-00232') THEN
                     CALL s_transaction_end('N','0')   #160816-00068#09 by 08209 add
                     RETURN
                  END IF 
                  CALL s_artt622_post_chk(g_rtia_m.rtiadocno,g_rtia_m.rtiastus) RETURNING l_success,g_errno
                  IF l_success THEN             
                     CALL s_artt622_post_upd(g_rtia_m.rtiadocno) RETURNING l_success
                     IF NOT l_success THEN
                        CALL s_transaction_end('N','0')
                        RETURN
                     ELSE
                        CALL s_transaction_end('Y','0')
                         CALL artt622_b_fill() 
                     END IF
                  ELSE
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = g_errno
                     LET g_errparam.extend = g_rtia_m.rtiadocno
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                     CALL s_transaction_end('N','0')   #160816-00068#09 by 08209 add
                     RETURN 
                  END IF 
            #end add-point
            #end add-point
         END IF
         EXIT MENU
      ON ACTION unposted
         IF cl_auth_chk_act("unposted") THEN
            LET lc_state = "Z"
            #add-point:action控制 name="statechange.unposted"
            IF NOT cl_ask_confirm('sub-00233') THEN
               CALL s_transaction_end('N','0')   #160816-00068#09 by 08209 add
               RETURN
            END IF 
            LET lc_state = 'Y'
            CALL s_artt622_unpost_chk(g_rtia_m.rtiadocno,g_rtia_m.rtiastus) RETURNING l_success,g_errno
            IF l_success THEN 
               #檢查是為實時成本模式，不可進行過帳還原 
               #150603-00018#1 15/06/15 s983961---add(s)                
                IF NOT s_cost_realtime_chk_unpost(g_rtia_m.rtiasite) THEN
                   CALL s_transaction_end('N','0')   #160816-00068#09 by 08209 add
                   RETURN 
                END IF
               #150603-00018#1 15/06/15 s983961---add(e) 
               CALL s_transaction_begin()
               CALL s_artt622_unpost_upd(g_rtia_m.rtiadocno) RETURNING l_success
               IF NOT l_success THEN
                  CALL s_transaction_end('N','0')
                  RETURN
               ELSE
                  CALL s_transaction_end('Y','0')
                END IF
            ELSE
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = g_errno
               LET g_errparam.extend = g_rtia_m.rtiadocno
               LET g_errparam.popup = TRUE
               CALL cl_err()
               CALL s_transaction_end('N','0')   #160816-00068#09 by 08209 add
               RETURN
            END IF
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
         IF NOT cl_ask_confirm('aim-00109') THEN
            CALL s_transaction_end('N','0')   #160816-00068#09 by 08209 add
            RETURN
         END IF 
         CALL s_artt622_void_chk(g_rtia_m.rtiadocno,g_rtia_m.rtiastus) RETURNING l_success,g_errno
         IF l_success THEN 
            CALL s_transaction_begin()
            CALL s_artt622_void_upd(g_rtia_m.rtiadocno) RETURNING l_success
            IF NOT l_success THEN
               CALL s_transaction_end('N','0')
               RETURN
            ELSE
               CALL s_transaction_end('Y','0')
            END IF
         ELSE
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = g_errno
            LET g_errparam.extend = g_rtia_m.rtiadocno
            LET g_errparam.popup = TRUE
            CALL cl_err()
            CALL s_transaction_end('N','0')   #160816-00068#09 by 08209 add
            RETURN
         END IF 
            #end add-point
         END IF
         EXIT MENU
 
      #add-point:stus控制 name="statechange.more_control"
            
      #end add-point
      
   END MENU
   
   #確認被選取的狀態碼在清單中
   IF (lc_state <> "N" 
      AND lc_state <> "Y"
      AND lc_state <> "S"
      AND lc_state <> "Z"
      AND lc_state <> "A"
      AND lc_state <> "D"
      AND lc_state <> "R"
      AND lc_state <> "W"
      AND lc_state <> "X"
      ) OR 
      g_rtia_m.rtiastus = lc_state OR cl_null(lc_state) THEN
      CLOSE artt622_cl
      CALL s_transaction_end('N','0')
      RETURN
   END IF
   
   #add-point:stus修改前 name="statechange.b_update"
      
   #end add-point
   
   LET g_rtia_m.rtiamodid = g_user
   LET g_rtia_m.rtiamoddt = cl_get_current()
   LET g_rtia_m.rtiastus = lc_state
   
   #異動狀態碼欄位/修改人/修改日期
   UPDATE rtia_t 
      SET (rtiastus,rtiamodid,rtiamoddt) 
        = (g_rtia_m.rtiastus,g_rtia_m.rtiamodid,g_rtia_m.rtiamoddt)     
    WHERE rtiaent = g_enterprise AND rtiadocno = g_rtia_m.rtiadocno
 
    
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
         WHEN "S"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/posted.png")
         WHEN "Z"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/unposted.png")
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
      EXECUTE artt622_master_referesh USING g_rtia_m.rtiadocno INTO g_rtia_m.rtiasite,g_rtia_m.rtiadocdt, 
          g_rtia_m.rtiadocno,g_rtia_m.rtia002,g_rtia_m.rtia001,g_rtia_m.rtia059,g_rtia_m.rtia060,g_rtia_m.rtia004, 
          g_rtia_m.rtia005,g_rtia_m.rtia006,g_rtia_m.rtia048,g_rtia_m.rtia053,g_rtia_m.rtiastus,g_rtia_m.rtia007, 
          g_rtia_m.rtia008,g_rtia_m.rtia009,g_rtia_m.rtia043,g_rtia_m.rtia047,g_rtia_m.rtia013,g_rtia_m.rtia014, 
          g_rtia_m.rtia015,g_rtia_m.rtia016,g_rtia_m.rtia051,g_rtia_m.rtia010,g_rtia_m.rtia011,g_rtia_m.rtia012, 
          g_rtia_m.rtia041,g_rtia_m.rtia017,g_rtia_m.rtia018,g_rtia_m.rtia019,g_rtia_m.rtia020,g_rtia_m.rtia021, 
          g_rtia_m.rtia022,g_rtia_m.rtia023,g_rtia_m.rtia024,g_rtia_m.rtia025,g_rtia_m.rtia026,g_rtia_m.rtia027, 
          g_rtia_m.rtia028,g_rtia_m.rtia029,g_rtia_m.rtia030,g_rtia_m.rtia032,g_rtia_m.rtia033,g_rtia_m.rtia034, 
          g_rtia_m.rtia035,g_rtia_m.rtia036,g_rtia_m.rtia037,g_rtia_m.rtia038,g_rtia_m.rtia039,g_rtia_m.rtia107, 
          g_rtia_m.rtiaownid,g_rtia_m.rtiacrtid,g_rtia_m.rtiaowndp,g_rtia_m.rtiacrtdp,g_rtia_m.rtiacrtdt, 
          g_rtia_m.rtiamodid,g_rtia_m.rtiamoddt,g_rtia_m.rtiacnfid,g_rtia_m.rtiacnfdt,g_rtia_m.rtiapstid, 
          g_rtia_m.rtiapstdt,g_rtia_m.rtiasite_desc,g_rtia_m.rtia002_desc,g_rtia_m.rtia004_desc,g_rtia_m.rtia005_desc, 
          g_rtia_m.rtia009_desc,g_rtia_m.rtia010_desc,g_rtia_m.rtia011_desc,g_rtia_m.rtia012_desc,g_rtia_m.rtia018_desc, 
          g_rtia_m.rtia024_desc,g_rtia_m.rtia025_desc,g_rtia_m.rtia036_desc,g_rtia_m.rtia037_desc,g_rtia_m.rtia038_desc, 
          g_rtia_m.rtiaownid_desc,g_rtia_m.rtiacrtid_desc,g_rtia_m.rtiaowndp_desc,g_rtia_m.rtiacrtdp_desc, 
          g_rtia_m.rtiamodid_desc,g_rtia_m.rtiacnfid_desc,g_rtia_m.rtiapstid_desc
      
      #將資料顯示到畫面上
      DISPLAY BY NAME g_rtia_m.rtiasite,g_rtia_m.rtiasite_desc,g_rtia_m.rtiadocdt,g_rtia_m.rtiadocno, 
          g_rtia_m.rtia002,g_rtia_m.rtia002_desc,g_rtia_m.rtia001,g_rtia_m.rtia001_desc,g_rtia_m.rtia059, 
          g_rtia_m.rtia060,g_rtia_m.mmaf003,g_rtia_m.mmaf004,g_rtia_m.rtia004,g_rtia_m.rtia004_desc, 
          g_rtia_m.rtia005,g_rtia_m.rtia005_desc,g_rtia_m.rtia006,g_rtia_m.rtia048,g_rtia_m.rtia053, 
          g_rtia_m.rtiastus,g_rtia_m.rtia007,g_rtia_m.rtia008,g_rtia_m.rtia009,g_rtia_m.rtia009_desc, 
          g_rtia_m.rtia043,g_rtia_m.rtia047,g_rtia_m.l_rtia047,g_rtia_m.rtia013,g_rtia_m.rtia014,g_rtia_m.rtia015, 
          g_rtia_m.rtia016,g_rtia_m.rtia051,g_rtia_m.rtia010,g_rtia_m.rtia010_desc,g_rtia_m.rtia011, 
          g_rtia_m.rtia011_desc,g_rtia_m.rtia012,g_rtia_m.rtia012_desc,g_rtia_m.chantype,g_rtia_m.barcode, 
          g_rtia_m.rtia041,g_rtia_m.rtia017,g_rtia_m.rtia018,g_rtia_m.rtia018_desc,g_rtia_m.rtia019, 
          g_rtia_m.rtia020,g_rtia_m.rtia021,g_rtia_m.rtia022,g_rtia_m.rtia023,g_rtia_m.rtia024,g_rtia_m.rtia024_desc, 
          g_rtia_m.rtia025,g_rtia_m.rtia025_desc,g_rtia_m.rtia026,g_rtia_m.rtia027,g_rtia_m.rtia028, 
          g_rtia_m.rtia029,g_rtia_m.rtia030,g_rtia_m.rtia032,g_rtia_m.rtia033,g_rtia_m.rtia034,g_rtia_m.rtia035, 
          g_rtia_m.rtia036,g_rtia_m.rtia036_desc,g_rtia_m.rtia037,g_rtia_m.rtia037_desc,g_rtia_m.rtia038, 
          g_rtia_m.rtia038_desc,g_rtia_m.rtia039,g_rtia_m.rtia107,g_rtia_m.isaf009,g_rtia_m.isaf010, 
          g_rtia_m.isaf044,g_rtia_m.isaf202,g_rtia_m.isaf203,g_rtia_m.isaf204,g_rtia_m.isaf201,g_rtia_m.isaf207, 
          g_rtia_m.rtiaownid,g_rtia_m.rtiaownid_desc,g_rtia_m.rtiacrtid,g_rtia_m.rtiacrtid_desc,g_rtia_m.rtiaowndp, 
          g_rtia_m.rtiaowndp_desc,g_rtia_m.rtiacrtdp,g_rtia_m.rtiacrtdp_desc,g_rtia_m.rtiacrtdt,g_rtia_m.rtiamodid, 
          g_rtia_m.rtiamodid_desc,g_rtia_m.rtiamoddt,g_rtia_m.rtiacnfid,g_rtia_m.rtiacnfid_desc,g_rtia_m.rtiacnfdt, 
          g_rtia_m.rtiapstid,g_rtia_m.rtiapstid_desc,g_rtia_m.rtiapstdt,g_rtia_m.snum,g_rtia_m.amount, 
          g_rtia_m.amount2,g_rtia_m.amount3
   END IF
 
   #add-point:stus修改後 name="statechange.a_update"
   #CALL cl_set_act_visible("modify,delete,insert,modify_detail", TRUE)
   CALL cl_set_act_visible("modify,insert,modify_detail", TRUE)
   IF g_rtia_m.rtiastus NOT MATCHES "[NDR]" THEN   # N未確認/D抽單/R已拒絕允許修改
      CALL cl_set_act_visible("modify,delete,modify_detail", FALSE)
   END IF
   CALL cl_set_act_visible("delete", FALSE)
   IF NOT cl_bpm_chk() THEN    #此單據不需提交至BPM，則隱藏按鈕 
       CALL cl_set_act_visible("bpm_status",FALSE)
   END IF 
   #end add-point
 
   #add-point:statechange段結束前 name="statechange.after"
      
   #end add-point  
 
   CLOSE artt622_cl
   CALL s_transaction_end('Y','0')
 
   #功能已完成,通報訊息中心
   CALL artt622_msgcentre_notify('statechange:'||lc_state)
   
END FUNCTION
 
 
 
 
{</section>}
 
{<section id="artt622.idx_chk" >}
#+ 顯示正確的單身資料筆數
PRIVATE FUNCTION artt622_idx_chk()
   #add-point:idx_chk段define(客製用) name="idx_chk.define_customerization"
   
   #end add-point  
   #add-point:idx_chk段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="idx_chk.define"
      
   #end add-point  
   
   #add-point:Function前置處理  name="idx_chk.pre_function"
   
   #end add-point
   
   IF g_current_page = 1 THEN
      LET g_detail_idx = g_curr_diag.getCurrentRow("s_detail1")
      IF g_detail_idx > g_rtib_d.getLength() THEN
         LET g_detail_idx = g_rtib_d.getLength()
      END IF
      IF g_detail_idx = 0 AND g_rtib_d.getLength() <> 0 THEN
         LET g_detail_idx = 1
      END IF
      DISPLAY g_detail_idx TO FORMONLY.idx
      DISPLAY g_rtib_d.getLength() TO FORMONLY.cnt
   END IF
   
   IF g_current_page = 2 THEN
      LET g_detail_idx = g_curr_diag.getCurrentRow("s_detail2")
      IF g_detail_idx > g_rtib2_d.getLength() THEN
         LET g_detail_idx = g_rtib2_d.getLength()
      END IF
      IF g_detail_idx = 0 AND g_rtib2_d.getLength() <> 0 THEN
         LET g_detail_idx = 1
      END IF
      DISPLAY g_detail_idx TO FORMONLY.idx
      DISPLAY g_rtib2_d.getLength() TO FORMONLY.cnt
   END IF
   IF g_current_page = 3 THEN
      LET g_detail_idx = g_curr_diag.getCurrentRow("s_detail3")
      IF g_detail_idx > g_rtib3_d.getLength() THEN
         LET g_detail_idx = g_rtib3_d.getLength()
      END IF
      IF g_detail_idx = 0 AND g_rtib3_d.getLength() <> 0 THEN
         LET g_detail_idx = 1
      END IF
      DISPLAY g_detail_idx TO FORMONLY.idx
      DISPLAY g_rtib3_d.getLength() TO FORMONLY.cnt
   END IF
   IF g_current_page = 4 THEN
      LET g_detail_idx = g_curr_diag.getCurrentRow("s_detail4")
      IF g_detail_idx > g_rtib4_d.getLength() THEN
         LET g_detail_idx = g_rtib4_d.getLength()
      END IF
      IF g_detail_idx = 0 AND g_rtib4_d.getLength() <> 0 THEN
         LET g_detail_idx = 1
      END IF
      DISPLAY g_detail_idx TO FORMONLY.idx
      DISPLAY g_rtib4_d.getLength() TO FORMONLY.cnt
   END IF
   IF g_current_page = 5 THEN
      LET g_detail_idx = g_curr_diag.getCurrentRow("s_detail5")
      IF g_detail_idx > g_rtib5_d.getLength() THEN
         LET g_detail_idx = g_rtib5_d.getLength()
      END IF
      IF g_detail_idx = 0 AND g_rtib5_d.getLength() <> 0 THEN
         LET g_detail_idx = 1
      END IF
      DISPLAY g_detail_idx TO FORMONLY.idx
      DISPLAY g_rtib5_d.getLength() TO FORMONLY.cnt
   END IF
   IF g_current_page = 6 THEN
      LET g_detail_idx = g_curr_diag.getCurrentRow("s_detail6")
      IF g_detail_idx > g_rtib6_d.getLength() THEN
         LET g_detail_idx = g_rtib6_d.getLength()
      END IF
      IF g_detail_idx = 0 AND g_rtib6_d.getLength() <> 0 THEN
         LET g_detail_idx = 1
      END IF
      DISPLAY g_detail_idx TO FORMONLY.idx
      DISPLAY g_rtib6_d.getLength() TO FORMONLY.cnt
   END IF
   IF g_current_page = 7 THEN
      LET g_detail_idx = g_curr_diag.getCurrentRow("s_detail7")
      IF g_detail_idx > g_rtib7_d.getLength() THEN
         LET g_detail_idx = g_rtib7_d.getLength()
      END IF
      IF g_detail_idx = 0 AND g_rtib7_d.getLength() <> 0 THEN
         LET g_detail_idx = 1
      END IF
      DISPLAY g_detail_idx TO FORMONLY.idx
      DISPLAY g_rtib7_d.getLength() TO FORMONLY.cnt
   END IF
 
   
   #add-point:idx_chk段other name="idx_chk.other"
      
   #end add-point  
   
END FUNCTION
 
{</section>}
 
{<section id="artt622.b_fill2" >}
#+ 單身陣列填充2
PRIVATE FUNCTION artt622_b_fill2(pi_idx)
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
   
   CALL artt622_detail_show()
   
   LET g_detail_idx = li_detail_idx_tmp
   
END FUNCTION
 
{</section>}
 
{<section id="artt622.fill_chk" >}
#+ 單身填充確認
PRIVATE FUNCTION artt622_fill_chk(ps_idx)
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
      (cl_null(g_wc2_table3) OR g_wc2_table3.trim() = '1=1')  AND 
      (cl_null(g_wc2_table4) OR g_wc2_table4.trim() = '1=1')  AND 
      (cl_null(g_wc2_table5) OR g_wc2_table5.trim() = '1=1')  AND 
      (cl_null(g_wc2_table6) OR g_wc2_table6.trim() = '1=1')  AND 
      (cl_null(g_wc2_table7) OR g_wc2_table7.trim() = '1=1') THEN
      #add-point:fill_chk段other_chk name="fill_chk.other_chk"
            
      #end add-point
      RETURN TRUE
   END IF
   
   #add-point:fill_chk段after_chk name="fill_chk.after_chk"
   
   #end add-point
   
   RETURN TRUE
 
END FUNCTION
 
{</section>}
 
{<section id="artt622.status_show" >}
PRIVATE FUNCTION artt622_status_show()
   #add-point:status_show段define(客製用) name="status_show.define_customerization"
   
   #end add-point
   #add-point:status_show段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="status_show.define"
   
   #end add-point
   
   #add-point:status_show段status_show name="status_show.status_show"
   
   #end add-point
END FUNCTION
 
{</section>}
 
{<section id="artt622.mask_functions" >}
&include "erp/art/artt622_mask.4gl"
 
{</section>}
 
{<section id="artt622.signature" >}
   #應用 a39 樣板自動產生(Version:10)
#+ BPM提交
PRIVATE FUNCTION artt622_send()
   #add-point:send段define(客製用) name="send.define_customerization"
   
   #end add-point 
   #add-point:send段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="send.define"
   DEFINE r_success    LIKE type_t.num5
   DEFINE l_errno      STRING 
   #end add-point 
   
   #add-point:Function前置處理  name="send.pre_function"
   
   #end add-point
   
   #依據單據個數，需要指定所有單身條件為" 1=1"  (單身有幾個就要設幾個)
   LET g_wc2_table1 = " 1=1"
   LET g_wc2_table2 = " 1=1"
   LET g_wc2_table3 = " 1=1"
   LET g_wc2_table4 = " 1=1"
   LET g_wc2_table5 = " 1=1"
   LET g_wc2_table6 = " 1=1"
   LET g_wc2_table7 = " 1=1"
 
 
   CALL artt622_show()
   CALL artt622_set_pk_array()
   
   #add-point: 初始化的ADP name="send.before_send"
   CALL s_artt622_conf_chk(g_rtia_m.rtiadocno,g_rtia_m.rtiastus) RETURNING  r_success,l_errno
   IF NOT r_success THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = l_errno
      LET g_errparam.extend = ''
      LET g_errparam.popup = TRUE
      CALL cl_err()
   
      CLOSE artt622_cl
      CALL s_transaction_end('N','0')
      RETURN
   END IF
   #end add-point
   
   #公用變數初始化
   CALL cl_bpm_data_init()
                  
   #依照主檔/單身個數產生 CALL cl_bpm_set_master_data() / cl_bpm_set_detail_data() 
   #單頭固定為 CALL cl_bpm_set_master_data(util.JSONObject.fromFGL(xxxx)) 傳入參數: (1)單頭陣列  ; 回傳值: 無
   CALL cl_bpm_set_master_data(util.JSONObject.fromFGL(g_rtia_m))
                              
   #單身固定為 CALL cl_bpm_set_detail_data(s_detailX, util.JSONArray.fromFGL(xxxx)) 傳入參數: (1)單身SR名稱  (2)單身陣列  ; 回傳值: 無
   CALL cl_bpm_set_detail_data("s_detail1", util.JSONArray.fromFGL(g_rtib_d))
   CALL cl_bpm_set_detail_data("s_detail2", util.JSONArray.fromFGL(g_rtib2_d))
   CALL cl_bpm_set_detail_data("s_detail3", util.JSONArray.fromFGL(g_rtib3_d))
   CALL cl_bpm_set_detail_data("s_detail4", util.JSONArray.fromFGL(g_rtib4_d))
   CALL cl_bpm_set_detail_data("s_detail5", util.JSONArray.fromFGL(g_rtib5_d))
   CALL cl_bpm_set_detail_data("s_detail6", util.JSONArray.fromFGL(g_rtib6_d))
   CALL cl_bpm_set_detail_data("s_detail7", util.JSONArray.fromFGL(g_rtib7_d))
 
 
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
   #CALL artt622_ui_browser_refresh()
 
   #重新指定此筆單據資料狀態圖片=>送簽中
   LET g_browser[g_current_idx].b_statepic = "stus/16/signing.png"
 
   #重新取得單頭/單身資料,DISPLAY在畫面上
   CALL artt622_ui_headershow()
   CALL artt622_ui_detailshow()
 
   RETURN TRUE
   
END FUNCTION
 
 
 
#應用 a40 樣板自動產生(Version:9)
#+ BPM抽單
PRIVATE FUNCTION artt622_draw_out()
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
   CALL artt622_ui_headershow()  
   CALL artt622_ui_detailshow()
 
   #add-point:Function後置處理  name="draw.after_function"
   
   #end add-point
 
   RETURN TRUE
   
END FUNCTION
 
 
 
 
 
{</section>}
 
{<section id="artt622.set_pk_array" >}
   #應用 a51 樣板自動產生(Version:8)
#+ 給予pk_array內容
PRIVATE FUNCTION artt622_set_pk_array()
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
   LET g_pk_array[1].values = g_rtia_m.rtiadocno
   LET g_pk_array[1].column = 'rtiadocno'
 
   
   #add-point:set_pk_array段之後 name="set_pk_array.after"
   
   #end add-point  
   
END FUNCTION
 
 
 
 
{</section>}
 
{<section id="artt622.other_dialog" readonly="Y" >}
   
 
{</section>}
 
{<section id="artt622.msgcentre_notify" >}
#應用 a66 樣板自動產生(Version:6)
PRIVATE FUNCTION artt622_msgcentre_notify(lc_state)
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
   CALL artt622_set_pk_array()
   #單頭資料填寫
   LET g_msgparam.data[1] = util.JSON.stringify(g_rtia_m)
 
   #add-point:msgcentre其他通知 name="msgcentre_notify.process"
   
   #end add-point
 
   #呼叫訊息中心傳遞本關完成訊息
   CALL cl_msgcentre_notify()
 
END FUNCTION
 
 
 
 
{</section>}
 
{<section id="artt622.action_chk" >}
#+ 修改/刪除前行為檢查(是否可允許此動作), 若有其他行為須管控也可透過此段落
PRIVATE FUNCTION artt622_action_chk()
   #add-point:action_chk段define(客製用) name="action_chk.define_customerization"
   
   #end add-point
   #add-point:action_chk段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="action_chk.define"
   
   #end add-point
   
   #add-point:action_chk段action_chk name="action_chk.action_chk"
   
   #end add-point
      
   RETURN TRUE
   
END FUNCTION
 
{</section>}
 
{<section id="artt622.other_function" readonly="Y" >}
################################################################################
# Descriptions...: 检查业务人员
# Memo...........:
# Usage..........: 
# Input parameter: 无
# Return code....: 无
# Date & Author..: 2014/02/12 By yangxf
# Modify.........:
################################################################################
PRIVATE FUNCTION artt622_rtia004_chk()
DEFINE l_ooag003   LIKE ooag_t.ooag003
DEFINE l_ooagstus  LIKE ooag_t.ooagstus

   LET g_errno = ''
   SELECT ooag003,ooagstus INTO l_ooag003,l_ooagstus
     FROM ooag_t
    WHERE ooagent = g_enterprise
      AND ooag001 = g_rtia_m.rtia004
   CASE 
      WHEN SQLCA.SQLCODE = 100 LET g_errno = 'aim-00069'
      WHEN l_ooagstus <> 'Y'   LET g_errno = 'ais-00018'
      OTHERWISE                LET g_errno = SQLCA.SQLCODE USING '-------'
   END CASE
   IF cl_null(g_errno) THEN 
      LET g_rtia_m.rtia005 = l_ooag003
      INITIALIZE g_ref_fields TO NULL
      LET g_ref_fields[1] = g_rtia_m.rtia005
      CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
      LET g_rtia_m.rtia005_desc = '', g_rtn_fields[1] , ''
   ELSE
      LET g_rtia_m.rtia005 = ''  
      LET g_rtia_m.rtia005_desc = ''
   END IF
   DISPLAY BY NAME g_rtia_m.rtia005,g_rtia_m.rtia005_desc
END FUNCTION
################################################################################
# Descriptions...: 业务部门检查
# Memo...........:
# Usage..........: 
# Input parameter: 无
# Return code....: 无
# Date & Author..: 2014/02/12 By yangxf
# Modify.........:
################################################################################
PRIVATE FUNCTION artt622_rtia005_chk()
DEFINE l_ooegstus  LIKE ooag_t.ooagstus
DEFINE l_n         LIKE type_t.num5
   LET g_errno = ''
   SELECT ooegstus INTO l_ooegstus
     FROM ooeg_t
    WHERE ooegent = g_enterprise
      AND ooeg001 = g_rtia_m.rtia005
   CASE 
      WHEN SQLCA.SQLCODE = 100 LET g_errno = 'art-00352'
      WHEN l_ooegstus <> 'Y'   LET g_errno = 'art-00353'
      OTHERWISE                LET g_errno = SQLCA.SQLCODE USING '-------'
   END CASE
   IF cl_null(g_errno) THEN 
      IF NOT cl_null(g_rtia_m.rtia004) THEN
         LET l_n = 0      
         SELECT COUNT(*) INTO l_n
           FROM ooag_t
          WHERE ooagent = g_enterprise
            AND ooag001 = g_rtia_m.rtia004 
            AND ooag003 = g_rtia_m.rtia005
         IF l_n = 0 THEN 
            LET g_errno = 'art-00224'
         END IF 
      END IF 
   END IF
END FUNCTION
################################################################################
# Descriptions...: 订单单号检查
# Memo...........:
# Usage..........: 
# Input parameter: 无
# Return code....: 无
# Date & Author..: 2014/02/13 By yangxf
# Modify.........: 2015/05/05 By dongsz #150424-00020#2
################################################################################
PRIVATE FUNCTION artt622_rtia007_chk()
#150424-00020#2--mark by dongsz--str---
#DEFINE l_xmda001   LIKE xmda_t.xmda001
#DEFINE l_xmdastus  LIKE xmda_t.xmdastus
#
#   LET g_errno = ''
#   SELECT xmda001,xmdastus INTO l_xmda001,l_xmdastus
#     FROM xmda_t
#    WHERE xmdaent = g_enterprise
#      AND xmdadocno = g_rtia_m.rtia007
#   CASE 
#      WHEN SQLCA.SQLCODE = 100 LET g_errno = 'art-00226'
#      WHEN l_xmdastus <> 'Y'   LET g_errno = 'art-00226'
#      OTHERWISE                LET g_errno = SQLCA.SQLCODE USING '-------'
#   END CASE
#   IF cl_null(g_errno) THEN 
#      LET g_rtia_m.rtia008 = l_xmda001
#   ELSE 
#      LET g_rtia_m.rtia008 = ''
#   END IF
#   DISPLAY BY NAME g_rtia_m.rtia008
#150424-00020#2--mark by dongsz--end---
#150424-00020#2--add by dongsz--str---
DEFINE l_rtilstus  LIKE rtil_t.rtilstus
DEFINE l_n         LIKE type_t.num5

   LET g_errno = ''
   #add by yangxf ---start----添加销退来源单号检查
   IF g_prog = 'artt610' OR g_prog = 'artt620' THEN   
      SELECT rtiastus INTO l_rtilstus
        FROM rtia_t
       WHERE rtiaent = g_enterprise
         AND rtiadocno = g_rtia_m.rtia007
         AND rtia000 = 'artt610'
      CASE 
         WHEN SQLCA.SQLCODE = 100 LET g_errno = 'art-00583'
         WHEN l_rtilstus <> 'S'   LET g_errno = 'art-00584'
         OTHERWISE                LET g_errno = SQLCA.SQLCODE USING '-------'
      END CASE
   END IF 
   IF g_prog = 'artt700' OR g_prog = 'artt800' THEN
      SELECT rtiastus INTO l_rtilstus
        FROM rtia_t
       WHERE rtiaent = g_enterprise
         AND rtiadocno = g_rtia_m.rtia007
         AND (rtia000 = 'artt622'
          OR rtia000 = 'artt610'
          OR rtia000 = 'artt620')
      CASE 
         WHEN SQLCA.SQLCODE = 100 LET g_errno = 'art-00583'
         WHEN l_rtilstus <> 'S'   LET g_errno = 'art-00584'
         OTHERWISE                LET g_errno = SQLCA.SQLCODE USING '-------'
      END CASE
   END IF 
   IF g_prog = 'artt622' THEN 
   #add by yangxf ---end----
   #160604-00009#85--dongsz add--s
      SELECT rtiastus INTO l_rtilstus
        FROM rtia_t
       WHERE rtiaent = g_enterprise
         AND rtiadocno = g_rtia_m.rtia007
         AND rtia000 = 'artt622'
      CASE 
         WHEN SQLCA.SQLCODE = 100 LET g_errno = 'art-00583'
         WHEN l_rtilstus <> 'S'   LET g_errno = 'art-00584'
         OTHERWISE                LET g_errno = SQLCA.SQLCODE USING '-------'
      END CASE
   #160604-00009#85--dongsz add--e
   #160604-00009#85--dongsz mark--s
#      SELECT rtilstus INTO l_rtilstus
#        FROM rtil_t
#       WHERE rtilent = g_enterprise
#         AND rtildocno = g_rtia_m.rtia007
#      CASE 
#         WHEN SQLCA.SQLCODE = 100 LET g_errno = 'art-00226'
#         WHEN l_rtilstus <> 'Y'   LET g_errno = 'art-00226'
#         OTHERWISE                LET g_errno = SQLCA.SQLCODE USING '-------'
#      END CASE
#      IF cl_null(g_errno) THEN 
#         LET l_n = 0
#         #检查此订单是否已被使用
#         SELECT COUNT(*) INTO l_n
#           FROM rtia_t
#          WHERE rtiaent = g_enterprise
#            AND rtia007 = g_rtia_m.rtia007
#            AND rtiastus <> 'X'
#         IF l_n > 0 THEN 
#            LET g_errno = 'art-00586'
#            RETURN 
#         END IF 
#         #检查此订单是否已被退订
#         SELECT COUNT(*) INTO l_n
#           FROM rtil_t
#          WHERE rtilent = g_enterprise
#            AND rtil041 = g_rtia_m.rtia007
#            AND rtilstus <> 'X'
#         IF l_n > 0 THEN 
#            LET g_errno = 'art-00627'
#            RETURN 
#         END IF 
#      END IF 
   #160604-00009#85--dongsz mark--e
   END IF    #add by yangxf
   
   LET g_rtia_m.rtia008 = ''
   DISPLAY BY NAME g_rtia_m.rtia008
#150424-00020#2--add by dongsz--end---
END FUNCTION
################################################################################
# Descriptions...: 稅別檢查
# Memo...........:
# Usage..........: 
# Input parameter: 無
# Return code....: 無
# Date & Author..: 2014/02/13 By yangxf
# Modify.........:
################################################################################
PRIVATE FUNCTION artt622_xrcd002_chk()
DEFINE l_oodbl004   LIKE oodbl_t.oodbl004
DEFINE l_oodbstus   LIKE oodb_t.oodbstus

   LET g_errno = ''
   SELECT oodbstus,oodbl004 INTO l_oodbstus,l_oodbl004
     FROM oodb_t LEFT JOIN oodbl_t ON oodbent = oodblent AND oodbl001 = oodb001 AND oodbl002 = oodb002 AND oodbl003 = g_dlang,ooef_t
    WHERE oodbent = ooefent
      AND ooefent = g_enterprise
      AND ooef001 = g_rtia_m.rtiasite
      AND oodb001 = ooef019
      AND oodb002 = g_rtib3_d[g_detail_idx].xrcd002
   CASE 
      WHEN SQLCA.SQLCODE = 100 LET g_errno = 'ais-00024'
      WHEN l_oodbstus <> 'Y'   LET g_errno = 'ais-00025'
      OTHERWISE                LET g_errno = SQLCA.SQLCODE USING '-------'
   END CASE
   IF cl_null(g_errno) THEN 
      LET g_rtib3_d[g_detail_idx].xrcd002_desc = l_oodbl004
   END IF
      
END FUNCTION
################################################################################
# Descriptions...: 應用分類碼檢查
# Memo...........:
# Usage..........: 
# Input parameter: 無
# Return code....: 無
# Date & Author..: 2014/02/13 By yangxf
# Modify.........:
################################################################################
PRIVATE FUNCTION artt622_rtia009_chk()
DEFINE l_oocqstus   LIKE oocq_t.oocqstus
DEFINE l_oocql004   LIKE oocql_t.oocql004

   LET g_errno = ''
   SELECT oocqstus,oocql004 INTO l_oocqstus,l_oocql004
     FROM oocq_t LEFT JOIN oocql_t ON oocqent = oocqlent AND oocql001 = oocq001 AND oocql002 = oocq002 AND oocql003 = g_dlang
    WHERE oocqent = g_enterprise
      AND oocq001 = '295'
      AND oocq002 = g_rtia_m.rtia009
   CASE 
      WHEN SQLCA.SQLCODE = 100 LET g_errno = 'art-00227'
      WHEN l_oocqstus <> 'Y'   LET g_errno = 'art-00228'
      OTHERWISE                LET g_errno = SQLCA.SQLCODE USING '-------'
   END CASE
   IF cl_null(g_errno) THEN 
      LET g_rtia_m.rtia009_desc = l_oocql004
      DISPLAY BY NAME g_rtia_m.rtia009_desc
   END IF 
END FUNCTION
################################################################################
# Descriptions...: 送货客户检查
# Memo...........:
# Usage..........: 无
# Input parameter: 无
# Return code....: 无
# Date & Author..: 2014/02/14 By yangxf
# Modify.........:
################################################################################
PRIVATE FUNCTION artt622_rtia010_chk()
DEFINE l_pmacstus   LIKE pmac_t.pmacstus

   LET g_errno = ''
   SELECT pmacstus INTO l_pmacstus
     FROM pmac_t
    WHERE pmacent = g_enterprise 
      AND pmac001 = g_rtia_m.rtia002
      AND pmac002 = g_rtia_m.rtia010
      AND pmac003 = '2'
   CASE 
      WHEN SQLCA.SQLCODE = 100 LET g_errno = 'art-00229'
      WHEN l_pmacstus <> 'Y'   LET g_errno = 'art-00230'
      OTHERWISE                LET g_errno = SQLCA.SQLCODE USING '-------'
   END CASE
   
END FUNCTION
################################################################################
# Descriptions...: 帐款客户检查
# Memo...........:
# Usage..........: 无
# Input parameter: 无
# Return code....: 无
# Date & Author..: 2014/02/14 By yangxf
# Modify.........:
################################################################################
PRIVATE FUNCTION artt622_rtia011_chk()
DEFINE l_pmacstus   LIKE pmac_t.pmacstus

   LET g_errno = ''
   SELECT pmacstus INTO l_pmacstus
     FROM pmac_t
    WHERE pmacent = g_enterprise 
      AND pmac001 = g_rtia_m.rtia002
      AND pmac002 = g_rtia_m.rtia011
      AND pmac003 = '1'
   CASE 
      WHEN SQLCA.SQLCODE = 100 LET g_errno = 'art-00231'
      WHEN l_pmacstus <> 'Y'   LET g_errno = 'art-00232'
      OTHERWISE                LET g_errno = SQLCA.SQLCODE USING '-------'
   END CASE
END FUNCTION
################################################################################
# Descriptions...: 发票客户检查
# Memo...........:
# Usage..........: 
# Input parameter: 无
# Return code....: 无
# Date & Author..: 2014/02/14 By yangxf
# Modify.........:
################################################################################
PRIVATE FUNCTION artt622_rtia012_chk()
DEFINE l_pmacstus   LIKE pmac_t.pmacstus

   LET g_errno = ''
   SELECT pmacstus INTO l_pmacstus
     FROM pmac_t
    WHERE pmacent = g_enterprise 
      AND pmac001 = g_rtia_m.rtia002
      AND pmac002 = g_rtia_m.rtia012
      AND pmac003 = '3'
   CASE 
      WHEN SQLCA.SQLCODE = 100 LET g_errno = 'art-00233'
      WHEN l_pmacstus <> 'Y'   LET g_errno = 'art-00234'
      OTHERWISE                LET g_errno = SQLCA.SQLCODE USING '-------'
   END CASE
END FUNCTION
################################################################################
# Descriptions...: 更新栏位是否必须录入
# Memo...........:
# Usage..........: 无
# Input parameter: 无
# Return code....: 无
# Date & Author..: 2014/02/17 By yangxf
# Modify.........:
################################################################################
PRIVATE FUNCTION artt622_rtia017_set()
   IF g_rtia_m.rtia017 = '1' THEN 
      CALL cl_set_comp_required("rtia018,rtia019,rtia020,rtia021,rtia022",FALSE)
   ELSE
      CALL cl_set_comp_required("rtia018,rtia019,rtia020,rtia021,rtia022",TRUE)
   END IF
END FUNCTION
################################################################################
# Descriptions...: 送货组织检查
# Memo...........:
# Usage..........: 无
# Input parameter: 无
# Return code....: 无
# Date & Author..: 2014/02/17 By yangxf
# Modify.........:
################################################################################
PRIVATE FUNCTION artt622_rtia018_chk()
DEFINE l_ooefstus   LIKE ooef_t.ooefstus

   LET g_errno = ''
   IF g_rtia_m.rtia017 = '1' OR g_rtia_m.rtia017 = '2' OR g_rtia_m.rtia017 = '3' THEN 
      SELECT ooefstus INTO l_ooefstus
        FROM ooef_t
       WHERE ooefent = g_enterprise
         AND ooef001 = g_rtia_m.rtia018
         AND ooef201 = 'Y'           #161024-00025#1 add
      CASE 
         WHEN SQLCA.SQLCODE = 100 LET g_errno = 'amm-00083'
         WHEN l_ooefstus <> 'Y'   LET g_errno = 'amm-00202'
         OTHERWISE                LET g_errno = SQLCA.SQLCODE USING '-------'
      END CASE
   END IF 
   IF g_rtia_m.rtia017 = '4' THEN 
      SELECT pmaastus INTO l_ooefstus
        FROM pmaa_t
       WHERE pmaaent = g_enterprise
         AND pmaa001 = g_rtia_m.rtia018
      CASE 
         WHEN SQLCA.SQLCODE = 100 LET g_errno = 'ais-00019'
         WHEN l_ooefstus <> 'Y'   LET g_errno = 'ais-00020'
         OTHERWISE                LET g_errno = SQLCA.SQLCODE USING '-------'
      END CASE
   END IF 
END FUNCTION
################################################################################
# Descriptions...: 收货组织检查
# Memo...........:
# Usage..........: 无
# Input parameter: 无
# Return code....: 无
# Date & Author..: 2014/02/17 By yangxf
# Modify.........:
################################################################################
PRIVATE FUNCTION artt622_rtia024_chk()
DEFINE l_ooefstus   LIKE ooef_t.ooefstus

   LET g_errno = ''
   SELECT ooefstus INTO l_ooefstus
     FROM ooef_t
    WHERE ooefent = g_enterprise
      AND ooef001 = g_rtia_m.rtia024
      AND ooef201 = 'Y'           #161024-00025#1 add
   CASE 
      WHEN SQLCA.SQLCODE = 100 LET g_errno = 'amm-00083'
      WHEN l_ooefstus <> 'Y'   LET g_errno = 'amm-00202'
      OTHERWISE                LET g_errno = SQLCA.SQLCODE USING '-------'
   END CASE
END FUNCTION
################################################################################
# Descriptions...: 收款条件检查
# Usage..........: 
# Input parameter: 无
# Return code....: 无
# Date & Author..: 2014/02/17 By yangxf
# Modify.........:
################################################################################
PRIVATE FUNCTION artt622_rtia025_chk()
DEFINE l_pmadstus   LIKE pmad_t.pmadstus

   LET g_errno = ''
   SELECT pmadstus INTO l_pmadstus
     FROM pmad_t
    WHERE pmadent = g_enterprise
      AND pmad001 = g_rtia_m.rtia002
      AND pmad002 = g_rtia_m.rtia025
      AND pmad003 = '2'
   CASE 
      WHEN SQLCA.SQLCODE = 100 LET g_errno = 'art-00235'
      WHEN l_pmadstus <> 'Y'   LET g_errno = 'art-00236'
      OTHERWISE                LET g_errno = SQLCA.SQLCODE USING '-------'
   END CASE

END FUNCTION
################################################################################
# Descriptions...: 币别检查
# Memo...........:
# Usage..........: 无
# Input parameter: 无
# Return code....: 无
# Date & Author..: 2014/02/17 By yangxf
# Modify.........:
################################################################################
PRIVATE FUNCTION artt622_rtia026_chk()
DEFINE l_ooajstus   LIKE ooaj_t.ooajstus
DEFINE l_ooef015    LIKE ooef_t.ooef015
DEFINE l_ooef016    LIKE ooef_t.ooef016
DEFINE l_ooam005    LIKE ooam_t.ooam005
DEFINE l_gzsz008    LIKE gzsz_t.gzsz008

   LET g_errno = ''
   SELECT ooajstus INTO l_ooajstus
     FROM ooaj_t,ooef_t
    WHERE ooajent = ooefent
      AND ooaj001 = ooef014
      AND ooefent = g_enterprise
      AND ooef001 = g_rtia_m.rtiasite
      AND ooaj002 = g_rtia_m.rtia026
   CASE 
      WHEN SQLCA.SQLCODE = 100 LET g_errno = 'art-00237'
      WHEN l_ooajstus <> 'Y'   LET g_errno = 'art-00238'
      OTHERWISE                LET g_errno = SQLCA.SQLCODE USING '-------'
   END CASE
   IF cl_null(g_errno) THEN
      LET g_rate = NULL
      #取匯率參照表號、主幣別
      SELECT ooef015,ooef016 INTO l_ooef015,l_ooef016 FROM ooef_t  
       WHERE ooefent = g_enterprise AND ooef001 = g_rtia_m.rtiasite

      #取交易貨幣批量
      SELECT ooam005 INTO l_ooam005 FROM ooam_t
       WHERE ooament = g_enterprise AND ooam001 = l_ooef015
         AND ooam003 = g_rtia_m.rtia026 AND ooam004 = g_rtia_m.rtiadocdt

      #取匯率類型   
      CALL cl_get_para(g_enterprise,g_rtia_m.rtiasite,'S-BAS-0010') RETURNING l_gzsz008
 
      CALL s_aooi160_get_exrate('1',g_rtia_m.rtiasite,g_rtia_m.rtiadocdt,g_rtia_m.rtia026,l_ooef016,l_ooam005,l_gzsz008)
         RETURNING g_rtia_m.rtia027
      DISPLAY BY NAME g_rtia_m.rtia027
   END IF 
END FUNCTION
################################################################################
# Descriptions...: 检查税种
# Memo...........:
# Usage..........: 无
# Input parameter: 无
# Return code....: 无
# Date & Author..: 2014/02/18 By yangxf
# Modify.........:
################################################################################
PRIVATE FUNCTION artt622_rtia028_chk()
DEFINE l_pmabstus   LIKE pmab_t.pmabstus
DEFINE l_oodb005    LIKE oodb_t.oodb005
DEFINE l_oodb006    LIKE oodb_t.oodb006
DEFINE l_oodbstus   LIKE oodb_t.oodbstus

   LET g_errno = ''
   SELECT oodb005,oodb006,oodbstus INTO l_oodb005,l_oodb006,l_oodbstus
     FROM oodb_t,ooef_t
    WHERE oodbent = g_enterprise
      AND ooef019 = oodb001
      AND ooefent = oodbent
      AND oodb002 = g_rtia_m.rtia028
      AND ooef001 = g_rtia_m.rtiasite
   CASE 
      WHEN SQLCA.SQLCODE = 100 LET g_errno = 'amm-00419'
      WHEN l_oodbstus <> 'Y'   LET g_errno = 'amm-00420'
      OTHERWISE                LET g_errno = SQLCA.SQLCODE USING '-------'
   END CASE
   IF cl_null(g_errno) THEN 
      LET g_rtia_m.rtia029 = l_oodb006
      LET g_rtia_m.rtia030 = l_oodb005
      DISPLAY BY NAME g_rtia_m.rtia029,g_rtia_m.rtia030
   END IF 
END FUNCTION
################################################################################
# Descriptions...: 税率检查
# Memo...........:
# Usage..........: 无
# Input parameter: 无
# Return code....: 无
# Date & Author..: 2014/02/18 By yangxf
# Modify.........:
################################################################################
PRIVATE FUNCTION artt622_rtia029_chk()
DEFINE l_n   LIKE type_t.num5

   LET g_errno = ''
   IF cl_null(g_rtia_m.rtia028) THEN 
      RETURN
   END IF 
   LET l_n = 0
   SELECT COUNT(*) INTO l_n
     FROM ooef_t,oodb_t 
     WHERE oodbent = g_enterprise
       AND ooef019 = oodb001
       AND ooefent = oodbent
       AND oodb002 = g_rtia_m.rtia028
       AND ooef001 = g_rtia_m.rtiasite
       AND oodb006 = g_rtia_m.rtia029
       AND oodbstus = 'Y'
   IF l_n = 0 THEN 
      LET g_errno = 'art-00250'
   END IF 
END FUNCTION
################################################################################
# Descriptions...: 收银机编号检查
# Memo...........:
# Usage..........: 无
# Input parameter: 无
# Return code....: 无
# Date & Author..: 2014/02/18 By yangxf
# Modify.........:
################################################################################
PRIVATE FUNCTION artt622_rtia036_chk()
DEFINE l_n          LIKE type_t.num5
DEFINE l_n1         LIKE type_t.num5
DEFINE l_pcaastus   LIKE pcaa_t.pcaastus
DEFINE l_pcacstus   LIKE pcac_t.pcacstus

   LET g_errno = ''
   SELECT pcaastus INTO l_pcaastus
     FROM pcaa_t
    WHERE pcaaent = g_enterprise
      AND pcaa001 = g_rtia_m.rtia036
      AND pcaasite = g_rtia_m.rtiasite
   CASE 
      WHEN SQLCA.SQLCODE = 100 LET g_errno = 'art-00251'
      WHEN l_pcaastus <> 'Y'   LET g_errno = 'art-00252'
      OTHERWISE                LET g_errno = SQLCA.SQLCODE USING '-------'
   END CASE
   IF NOT cl_null(g_rtia_m.rtia037) AND cl_null(g_errno) THEN 
      SELECT pcacstus INTO l_pcacstus
        FROM pcac_t,pcab_t
       WHERE pcacent = g_enterprise
         AND pcabent = pcacent
         AND pcac001 = pcab001
         AND pcac001 = g_rtia_m.rtia037
         AND pcac002 = g_rtia_m.rtiasite
         AND (pcac003 = g_rtia_m.rtia036
          OR pcac003 = ' ')
      CASE 
         WHEN SQLCA.SQLCODE = 100 LET g_errno = 'amm-00441'
         WHEN l_pcacstus <> 'Y'   LET g_errno = 'amm-00441'
         OTHERWISE                LET g_errno = SQLCA.SQLCODE USING '-------'
      END CASE
   END IF 
   IF NOT cl_null(g_errno) THEN 
      RETURN
   END IF 
   LET l_n = 0
   #判断收银机是否有维护对应的库区
   SELECT COUNT(*) INTO l_n
     FROM pcao_t
    WHERE pcaoent = g_enterprise
      AND pcao001 = g_rtia_m.rtia036
      AND pcaosite = g_rtia_m.rtiasite
   IF l_n = 0 THEN 
      RETURN 
   END IF 
   LET l_n = 0
   SELECT COUNT(*) INTO l_n
     FROM rtib_t
    WHERE rtibent = g_enterprise 
      AND rtibdocno = g_rtia_m.rtiadocno
   #检查单身库区是否与收银机号对应
   LET l_n1 = 0
   SELECT COUNT(*) INTO l_n1
     FROM pcao_t,rtib_t 
    WHERE pcaoent = rtibent
      AND pcao001 = g_rtia_m.rtia036
      AND pcaosite = g_rtia_m.rtiasite
      AND rtibent = g_enterprise
      AND rtibdocno = g_rtia_m.rtiadocno
      AND pcao002 = rtib025
      AND pcaostus = 'Y'       
   IF l_n <> l_n1 THEN
      LET g_errno = 'art-00351'
   END IF
END FUNCTION
################################################################################
# Descriptions...: 收银员检查
# Memo...........:
# Usage..........: 无
# Input parameter: 无
# Return code....: 无
# Date & Author..: 2014/02/18 By yangxf
# Modify.........:
################################################################################
PRIVATE FUNCTION artt622_rtia037_chk()
DEFINE l_pcabstus LIKE pcab_t.pcabstus
DEFINE l_pcacstus LIKE pcac_t.pcacstus

   LET g_errno = ''
   SELECT pcabstus INTO l_pcabstus
     FROM pcab_t
    WHERE pcabent = g_enterprise
      AND pcab001 = g_rtia_m.rtia037
   CASE 
      WHEN SQLCA.SQLCODE = 100 LET g_errno = 'ade-00024'
      WHEN l_pcabstus <> 'Y'   LET g_errno = 'ade-00025'
      OTHERWISE                LET g_errno = SQLCA.SQLCODE USING '-------'
   END CASE
   IF cl_null(g_errno) THEN 
      IF cl_null(g_rtia_m.rtia036) THEN 
         SELECT DISTINCT pcacstus INTO l_pcacstus
           FROM pcac_t,pcab_t
          WHERE pcacent = g_enterprise
            AND pcabent = pcacent
            AND pcac001 = pcab001
            AND pcac001 = g_rtia_m.rtia037
            AND pcac002 = g_rtia_m.rtiasite
            AND pcacstus = 'Y'
         CASE 
            WHEN SQLCA.SQLCODE = 100 LET g_errno = 'amm-00440'
            WHEN l_pcacstus <> 'Y'   LET g_errno = 'amm-00440'
            OTHERWISE                LET g_errno = SQLCA.SQLCODE USING '-------'
         END CASE
      ELSE
         SELECT pcacstus INTO l_pcacstus
           FROM pcac_t,pcab_t
          WHERE pcacent = g_enterprise
            AND pcabent = pcacent
            AND pcac001 = pcab001
            AND pcac001 = g_rtia_m.rtia037
            AND pcac002 = g_rtia_m.rtiasite
            AND (pcac003 = g_rtia_m.rtia036
             OR pcac003 = ' ')
         CASE 
            WHEN SQLCA.SQLCODE = 100 LET g_errno = 'amm-00441'
            WHEN l_pcacstus <> 'Y'   LET g_errno = 'amm-00441'
            OTHERWISE                LET g_errno = SQLCA.SQLCODE USING '-------'
         END CASE
      END IF 
   END IF
   IF cl_null(g_errno) THEN 
      IF cl_null(g_rtia_m.rtia036) THEN 
         SELECT pcac003 INTO g_rtia_m.rtia036 
           FROM pcac_t
          WHERE pcacent = g_enterprise
            AND pcac001 = g_rtia_m.rtia037
            AND pcac002 = g_rtia_m.rtiasite
            AND pcacstus = 'Y'
         IF NOT cl_null(g_rtia_m.rtia036) THEN 
            CALL artt622_rtia036_chk()
            IF NOT cl_null(g_errno) THEN 
               RETURN 
            END IF 
         END IF 
         IF cl_null(g_rtia_m.rtia036) THEN 
            LET g_rtia_m.rtia036 = ''
         END IF 
         INITIALIZE g_ref_fields TO NULL
         LET g_ref_fields[1] = g_rtia_m.rtia036
         CALL ap_ref_array2(g_ref_fields,"SELECT pcaal003 FROM pcaal_t WHERE pcaalent='"||g_enterprise||"' AND pcaalsite = '"||g_rtia_m.rtiasite||"' AND pcaal001=? AND pcaal002='"||g_dlang||"'","") RETURNING g_rtn_fields
         LET g_rtia_m.rtia036_desc = '', g_rtn_fields[1] , ''
         DISPLAY BY NAME g_rtia_m.rtia036_desc         
      END IF 
   END IF 
   
END FUNCTION
################################################################################
# Descriptions...: 来源单号检查
# Memo...........:
# Usage..........: 无
# Input parameter: 无
# Return code....: 无
# Date & Author..: 2014/02/19 By yangxf
# Modify.........: 2015/05/05 By dongsz #150424-00020#2
################################################################################
PRIVATE FUNCTION artt622_rtib001_chk()
#150424-00020#2--mark by dongsz--str---
#DEFINE l_xmdastus   LIKE xmda_t.xmdastus
#DEFINE l_xmda001    LIKE xmda_t.xmda001
#
#   LET g_errno = ''
#   IF cl_null(g_rtib_d[l_ac].rtib001) THEN 
#      RETURN 
#   END IF 
#   IF cl_null(g_rtib_d[l_ac].rtib002) THEN 
#      SELECT xmdastus,xmda001 INTO l_xmdastus,l_xmda001
#        FROM xmda_t
#       WHERE xmdaent = g_enterprise
#         AND xmdadocno = g_rtib_d[l_ac].rtib001
#      CASE 
#         WHEN SQLCA.SQLCODE = 100 LET g_errno = 'art-00226'
#         WHEN l_xmdastus <> 'Y'   LET g_errno = 'art-00226'
#         OTHERWISE                LET g_errno = SQLCA.SQLCODE USING '-------'
#      END CASE
#      IF cl_null(g_errno) THEN 
#         LET g_rtib_d[l_ac].xmda001 = l_xmda001
#      END IF
#   ELSE
#      SELECT DISTINCT xmdastus,xmda001 INTO l_xmdastus,l_xmda001
#        FROM xmda_t,xmdc_t
#       WHERE xmdaent = g_enterprise
#         AND xmdadocno = xmdcdocno
#         AND xmdcent = xmdaent 
#         AND xmdcdocno = g_rtib_d[l_ac].rtib001
#         AND xmdcseq = g_rtib_d[l_ac].rtib002
#      CASE 
#         WHEN SQLCA.SQLCODE = 100 LET g_errno = 'art-00253'
#         WHEN l_xmdastus <> 'Y'   LET g_errno = 'art-00293'
#         OTHERWISE                LET g_errno = SQLCA.SQLCODE USING '-------'
#      END CASE
#      IF cl_null(g_errno) THEN 
#         LET g_rtib_d[l_ac].xmda001 = l_xmda001
#      END IF
#   END IF       
#150424-00020#2--mark by dongsz--end---
#150424-00020#2--add by dongsz--str---
DEFINE l_rtilstus   LIKE rtil_t.rtilstus
DEFINE l_rtib035    LIKE rtib_t.rtib035

   LET g_errno = ''
   IF cl_null(g_rtib_d[l_ac].rtib001) THEN 
      RETURN 
   END IF 
   IF cl_null(g_rtib_d[l_ac].rtib002) THEN 
      IF g_prog = 'artt622' THEN   #add by yangxf
         SELECT rtilstus INTO l_rtilstus
           FROM rtil_t
          WHERE rtilent = g_enterprise
            AND rtildocno = g_rtib_d[l_ac].rtib001
         CASE 
            WHEN SQLCA.SQLCODE = 100 LET g_errno = 'art-00226'
            WHEN l_rtilstus <> 'Y'   LET g_errno = 'art-00226'
            OTHERWISE                LET g_errno = SQLCA.SQLCODE USING '-------'
         END CASE
      #add by yangxf ---start----
      END IF 
      IF g_prog = 'artt610' OR g_prog = 'artt620' THEN 
         SELECT rtiastus INTO l_rtilstus
           FROM rtia_t
          WHERE rtiaent = g_enterprise
            AND rtiadocno = g_rtib_d[l_ac].rtib001
            AND rtia000 = 'artt610'
         CASE 
            WHEN SQLCA.SQLCODE = 100 LET g_errno = 'art-00583'
            WHEN l_rtilstus <> 'S'   LET g_errno = 'art-00584'
            OTHERWISE                LET g_errno = SQLCA.SQLCODE USING '-------'
         END CASE
      END IF 
      IF g_prog = 'artt700' THEN 
         SELECT rtiastus INTO l_rtilstus
           FROM rtia_t
          WHERE rtiaent = g_enterprise
            AND rtiadocno = g_rtib_d[l_ac].rtib001
            AND (rtia000 = 'artt622'
             OR rtia000 = 'artt610'
             OR rtia000 = 'artt620')
         CASE 
            WHEN SQLCA.SQLCODE = 100 LET g_errno = 'art-00583'
            WHEN l_rtilstus <> 'S'   LET g_errno = 'art-00584'
            OTHERWISE                LET g_errno = SQLCA.SQLCODE USING '-------'
         END CASE
      END IF 
      #add by yangxf ---end----
   ELSE
      IF g_prog = 'artt622' THEN 
         SELECT DISTINCT rtilstus INTO l_rtilstus
           FROM rtil_t,rtim_t
          WHERE rtilent = g_enterprise
            AND rtildocno = rtimdocno
            AND rtiment = rtilent 
            AND rtimdocno = g_rtib_d[l_ac].rtib001
            AND rtimseq = g_rtib_d[l_ac].rtib002
         CASE 
            WHEN SQLCA.SQLCODE = 100 LET g_errno = 'art-00253'
            WHEN l_rtilstus <> 'Y'   LET g_errno = 'art-00293'
            OTHERWISE                LET g_errno = SQLCA.SQLCODE USING '-------'
         END CASE
      #add by yangxf ---start---
      END IF 
      IF g_prog = 'artt610' OR g_prog = 'artt620' THEN 
         SELECT DISTINCT rtiastus,rtib035 INTO l_rtilstus,l_rtib035
           FROM rtia_t,rtib_t
          WHERE rtiaent = g_enterprise
            AND rtiadocno = rtibdocno
            AND rtibent = rtiaent 
            AND rtibdocno = g_rtib_d[l_ac].rtib001
            AND rtibseq = g_rtib_d[l_ac].rtib002
            AND rtia000 = 'artt610'
         CASE 
            WHEN SQLCA.SQLCODE = 100 LET g_errno = 'art-00583'
            WHEN l_rtilstus <> 'S'   LET g_errno = 'art-00584'
            WHEN l_rtib035 <> '1'    LET g_errno = 'art-00585'
            OTHERWISE                LET g_errno = SQLCA.SQLCODE USING '-------'
         END CASE 
      END IF
      IF g_prog = 'artt700' THEN 
         SELECT DISTINCT rtiastus,rtib035 INTO l_rtilstus,l_rtib035
           FROM rtia_t,rtib_t
          WHERE rtiaent = g_enterprise
            AND rtiadocno = rtibdocno
            AND rtibent = rtiaent 
            AND rtibdocno = g_rtib_d[l_ac].rtib001
            AND rtibseq = g_rtib_d[l_ac].rtib002
            AND (rtia000 = 'artt622'
             OR rtia000 = 'artt610'
             OR rtia000 = 'artt620')
         CASE 
            WHEN SQLCA.SQLCODE = 100 LET g_errno = 'art-00583'
            WHEN l_rtilstus <> 'S'   LET g_errno = 'art-00584'
            WHEN l_rtib035 <> '1'    LET g_errno = 'art-00585'
            OTHERWISE                LET g_errno = SQLCA.SQLCODE USING '-------'
         END CASE 
      END IF
      #add by yangxf ---end----      
   END IF    
#150424-00020#2--add by dongsz--end---
END FUNCTION
################################################################################
# Descriptions...: 条码检查
# Memo...........:
# Usage..........: 无
# Input parameter: 无
# Return code....: 无
# Date & Author..: 2014/02/20 By yangxf
# Modify.........:
################################################################################
PRIVATE FUNCTION artt622_rtib003_chk()
DEFINE l_imaystus   LIKE imay_t.imaystus
   LET g_errno = ''
   IF NOT cl_null(g_rtib_d[l_ac].rtib004) THEN 
      SELECT imaystus INTO l_imaystus
        FROM imay_t
       WHERE imayent = g_enterprise
         AND imay001 = g_rtib_d[l_ac].rtib004
         AND imay003 = g_rtib_d[l_ac].rtib003
     CASE 
        WHEN SQLCA.SQLCODE = 100 LET g_errno = 'art-00295'
        WHEN l_imaystus <> 'Y'   LET g_errno = 'art-00047'
        OTHERWISE                LET g_errno = SQLCA.SQLCODE USING '-------'
      END CASE
   ELSE
      SELECT imaystus INTO l_imaystus
        FROM imay_t
       WHERE imayent = g_enterprise
         AND imay003 = g_rtib_d[l_ac].rtib003
      CASE 
         WHEN SQLCA.SQLCODE = 100 LET g_errno = 'art-00046'
         WHEN l_imaystus <> 'Y'   LET g_errno = 'art-00047'
         OTHERWISE                LET g_errno = SQLCA.SQLCODE USING '-------'
      END CASE
   END IF 
   
END FUNCTION
################################################################################
# Descriptions...: 来源单号+来源项次带出对应商品信息
# Memo...........:
# Usage..........: 无
# Input parameter: 无
# Return code....: 无
# Date & Author..: 2014/02/20 By yangxf
# Modify.........:
################################################################################
PRIVATE FUNCTION artt622_rtib001_rtib002_desc()
DEFINE l_rtdxstus   LIKE rtdx_t.rtdxstus
DEFINE l_oodb011       LIKE oodb_t.oodb011
   
   LET g_errno = ''
   IF cl_null(g_rtib_d[l_ac].rtib001)
   OR cl_null(g_rtib_d[l_ac].rtib002) THEN
      RETURN 
   END IF 
   IF g_prog = 'artt622' THEN   #add by yangxf
      SELECT oodb011 INTO l_oodb011
        FROM oodb_t,ooef_t
       WHERE oodbent = ooefent
         AND oodb001 = ooef019
         AND oodb002 = g_rtia_m.rtia028
         AND ooef001 = g_rtia_m.rtiasite   
         
      #商品编号,单位,税别
      #150424-00020#2--mark by dongsz--str---
#      SELECT xmdc001,xmdc006,xmdc016
#        INTO g_rtib_d[l_ac].rtib004,g_rtib_d[l_ac].rtib013,g_rtib_d[l_ac].rtib006
#        FROM xmdc_t
#       WHERE xmdcent = g_enterprise
#         AND xmdcdocno = g_rtib_d[l_ac].rtib001
#         AND xmdcseq = g_rtib_d[l_ac].rtib002
      #150424-00020#2--mark by dongsz--end---
      #150424-00020#2--add by dongsz--str---
      SELECT rtim003,rtim004,rtim013,rtim006
        INTO g_rtib_d[l_ac].rtib003,g_rtib_d[l_ac].rtib004,g_rtib_d[l_ac].rtib013,g_rtib_d[l_ac].rtib006
        FROM rtim_t
       WHERE rtiment = g_enterprise
         AND rtimdocno = g_rtib_d[l_ac].rtib001
         AND rtimseq = g_rtib_d[l_ac].rtib002
      #150424-00020#2--add by dongsz--end---
         
      #150424-00020#2--mark by dongsz--str---
#      SELECT imay003 INTO g_rtib_d[l_ac].rtib003
#        FROM imay_t
#       WHERE imayent = g_enterprise
#         AND imay001 = g_rtib_d[l_ac].rtib004
      #150424-00020#2--mark by dongsz--end---
      
      IF NOT cl_null(g_rtib_d[l_ac].rtib004) THEN
         IF l_oodb011 = '1' THEN 
            LET g_rtib_d[l_ac].rtib006 = g_rtia_m.rtia028
#         ELSE      #mark by yangxf
#add by yangxf ---start---
         END IF 
         IF l_oodb011 <> '1' OR cl_null(g_rtia_m.rtia028) THEN
#add by yangxf ----end----
            #带出税别
            SELECT rtdx014 INTO g_rtib_d[l_ac].rtib006
              FROM rtdx_t
             WHERE rtdxent = g_enterprise 
               AND rtdxsite = g_rtia_m.rtiasite
               AND rtdx001 = g_rtib_d[l_ac].rtib004         
         END IF 
        
         SELECT oodbl004 INTO g_rtib_d[l_ac].rtib006_desc 
           FROM oodbl_t,ooef_t
          WHERE oodblent = ooefent
           AND ooefent = g_enterprise
           AND ooef001 = g_rtia_m.rtiasite
           AND oodbl001 = ooef019
           AND oodbl002 = g_rtib_d[l_ac].rtib006
           
         #获取商品特征码,带出销售单位
         SELECT imaa005,imaa105,imaa106
           INTO g_rtib_d[l_ac].rtib005,g_rtib_d[l_ac].rtib013,g_rtib_d[l_ac].rtib018 
           FROM imaa_t
          WHERE imaaent = g_enterprise
            AND imaa001 = g_rtib_d[l_ac].rtib004
          INITIALIZE g_ref_fields TO NULL
          LET g_ref_fields[1] = g_rtib_d[l_ac].rtib004
          CALL ap_ref_array2(g_ref_fields,"SELECT imaal003,imaal004 FROM imaal_t WHERE imaalent='"||g_enterprise||"' AND imaal001=? AND imaal002='"||g_dlang||"'","") RETURNING g_rtn_fields
          LET g_rtib_d[l_ac].rtib004_desc = '', g_rtn_fields[1] , ''
          LET g_rtib_d[l_ac].rtib004_desc_desc = '', g_rtn_fields[2] , ''
          DISPLAY BY NAME g_rtib_d[l_ac].rtib004_desc,g_rtib_d[l_ac].rtib004_desc_desc
          INITIALIZE g_ref_fields TO NULL
          LET g_ref_fields[1] = g_rtib_d[l_ac].rtib013
          CALL ap_ref_array2(g_ref_fields,"SELECT oocal003 FROM oocal_t WHERE oocalent='"||g_enterprise||"' AND oocal001=? AND oocal002='"||g_dlang||"'","") RETURNING g_rtn_fields
          LET g_rtib_d[l_ac].rtib013_desc = '', g_rtn_fields[1] , ''
          INITIALIZE g_ref_fields TO NULL
          LET g_ref_fields[1] = g_rtib_d[l_ac].rtib018
          CALL ap_ref_array2(g_ref_fields,"SELECT oocal003 FROM oocal_t WHERE oocalent='"||g_enterprise||"' AND oocal001=? AND oocal002='"||g_dlang||"'","") RETURNING g_rtn_fields
          LET g_rtib_d[l_ac].rtib018_desc = '', g_rtn_fields[1] , ''
         #收银机不为空预设库区，储位，批号
         IF NOT cl_null(g_rtia_m.rtia036) THEN 
            SELECT inag004,inag005,inag006
              INTO g_rtib_d[l_ac].rtib025,g_rtib_d[l_ac].rtib026,g_rtib_d[l_ac].rtib027
              FROM pcao_t,inag_t
             WHERE pcaoent = g_enterprise
               AND pcaosite = g_rtia_m.rtiasite
               AND pcao001 = g_rtia_m.rtia036
               AND pcaoent = inagent
               AND inagsite = pcaosite
               AND inag001 = g_rtib_d[l_ac].rtib004
             ORDER BY inag004
         ELSE
            SELECT inag004,inag005,inag006
              INTO g_rtib_d[l_ac].rtib025,g_rtib_d[l_ac].rtib026,g_rtib_d[l_ac].rtib027
              FROM inag_t
             WHERE inagent = g_enterprise
               AND inagsite = g_rtia_m.rtiasite
               AND inag001 = g_rtib_d[l_ac].rtib004
             ORDER BY inag004
         END IF 
      END IF 
      SELECT rtdxstus INTO l_rtdxstus
        FROM rtdx_t
       WHERE rtdxent = g_enterprise
         AND rtdxsite = g_rtia_m.rtiasite
         AND rtdx001 = g_rtib_d[l_ac].rtib004
      CASE 
         WHEN SQLCA.SQLCODE = 100 LET g_errno = 'art-00296'
         WHEN l_rtdxstus <> 'Y'   LET g_errno = 'art-00297'
         OTHERWISE                LET g_errno = SQLCA.SQLCODE USING '-------'
      END CASE
      IF NOT cl_null(g_errno) THEN 
         LET g_rtib_d[l_ac].rtib003 = ''
         LET g_rtib_d[l_ac].rtib004 = ''
         LET g_rtib_d[l_ac].rtib013 = ''
         LET g_rtib_d[l_ac].rtib006 = ''
         RETURN 
      END IF
      IF l_oodb011 = '1' THEN 
      LET g_rtib_d[l_ac].rtib006 = g_rtia_m.rtia028
#      ELSE      #mark by yangxf
#add by yangxf ---start---
      END IF 
      IF l_oodb011 <> '1' OR cl_null(g_rtia_m.rtia028) THEN
#add by yangxf ----end----
         #带出税别
         SELECT rtdx014 INTO g_rtib_d[l_ac].rtib006
           FROM rtdx_t
          WHERE rtdxent = g_enterprise 
            AND rtdxsite = g_rtia_m.rtiasite
            AND rtdx001 = g_rtib_d[l_ac].rtib004         
      END IF 
   END IF   #add by yangxf 
   #add by yangxf ---start----
   IF g_prog = 'artt610' OR g_prog = 'artt700' OR g_prog = 'artt620' THEN 
      SELECT rtib003,rtib004,rtib005,rtib006,rtib008,rtib009,rtib010,
             rtib012,rtib013,rtib014,rtib015,rtib017,rtib018,rtib019,
             rtib020,rtib021,rtib031,rtib022,rtib024,rtib025,rtib026,
             rtib027,rtib032,rtib033,rtib028,rtib030
        INTO g_rtib_d[l_ac].rtib003,g_rtib_d[l_ac].rtib004,g_rtib_d[l_ac].rtib005,g_rtib_d[l_ac].rtib006,g_rtib_d[l_ac].rtib008,g_rtib_d[l_ac].rtib009,g_rtib_d[l_ac].rtib010,
             g_rtib_d[l_ac].rtib012,g_rtib_d[l_ac].rtib013,g_rtib_d[l_ac].rtib014,g_rtib_d[l_ac].rtib015,g_rtib_d[l_ac].rtib017,g_rtib_d[l_ac].rtib018,g_rtib_d[l_ac].rtib019,
             g_rtib_d[l_ac].rtib020,g_rtib_d[l_ac].rtib021,g_rtib_d[l_ac].rtib031,g_rtib_d[l_ac].rtib022,g_rtib_d[l_ac].rtib024,g_rtib_d[l_ac].rtib025,g_rtib_d[l_ac].rtib026,
             g_rtib_d[l_ac].rtib027,g_rtib_d[l_ac].rtib032,g_rtib_d[l_ac].rtib033,g_rtib_d[l_ac].rtib028,g_rtib_d[l_ac].rtib030
        FROM rtib_t
       WHERE rtibent = g_enterprise
         AND rtibdocno = g_rtib_d[l_ac].rtib001
         AND rtibseq = g_rtib_d[l_ac].rtib002
  
      SELECT oodbl004 INTO g_rtib_d[l_ac].rtib006_desc 
        FROM oodbl_t,ooef_t
       WHERE oodblent = ooefent
        AND ooefent = g_enterprise
        AND ooef001 = g_rtia_m.rtiasite
        AND oodbl001 = ooef019
        AND oodbl002 = g_rtib_d[l_ac].rtib006    
       INITIALIZE g_ref_fields TO NULL
       LET g_ref_fields[1] = g_rtib_d[l_ac].rtib004
       CALL ap_ref_array2(g_ref_fields,"SELECT imaal003,imaal004 FROM imaal_t WHERE imaalent='"||g_enterprise||"' AND imaal001=? AND imaal002='"||g_dlang||"'","") RETURNING g_rtn_fields
       LET g_rtib_d[l_ac].rtib004_desc = '', g_rtn_fields[1] , ''
       LET g_rtib_d[l_ac].rtib004_desc_desc = '', g_rtn_fields[2] , ''
       DISPLAY BY NAME g_rtib_d[l_ac].rtib004_desc,g_rtib_d[l_ac].rtib004_desc_desc
       INITIALIZE g_ref_fields TO NULL
       LET g_ref_fields[1] = g_rtib_d[l_ac].rtib013
       CALL ap_ref_array2(g_ref_fields,"SELECT oocal003 FROM oocal_t WHERE oocalent='"||g_enterprise||"' AND oocal001=? AND oocal002='"||g_dlang||"'","") RETURNING g_rtn_fields
       LET g_rtib_d[l_ac].rtib013_desc = '', g_rtn_fields[1] , ''
       INITIALIZE g_ref_fields TO NULL
       LET g_ref_fields[1] = g_rtib_d[l_ac].rtib018
       CALL ap_ref_array2(g_ref_fields,"SELECT oocal003 FROM oocal_t WHERE oocalent='"||g_enterprise||"' AND oocal001=? AND oocal002='"||g_dlang||"'","") RETURNING g_rtn_fields
       LET g_rtib_d[l_ac].rtib018_desc = '', g_rtn_fields[1] , ''         
   END IF 
   #add by yangxf ----end-----
END FUNCTION
################################################################################
# Descriptions...: 商品检查
# Memo...........:
# Usage..........: 无
# Input parameter: 无
# Return code....: 无
# Date & Author..: 2014/02/20 By yangxf
# Modify.........: 2015/05/05 By dongsz #150424-00020#2
################################################################################
PRIVATE FUNCTION artt622_rtib004_chk()
DEFINE l_rtdxstus   LIKE rtdx_t.rtdxstus
#DEFINE l_xmdastus   LIKE xmda_t.xmdastus   #150424-00020#2--mark by dongsz
#DEFINE l_xmda001    LIKE xmda_t.xmda001    #150424-00020#2--mark by dongsz
DEFINE l_rtilstus   LIKE rtil_t.rtilstus    #150424-00020#2--add by dongsz
DEFINE r_success    LIKE type_t.num5
   LET g_errno = ''
   SELECT rtdxstus INTO l_rtdxstus
     FROM rtdx_t
    WHERE rtdxent = g_enterprise
      AND rtdxsite = g_rtia_m.rtiasite
      AND rtdx001 = g_rtib_d[l_ac].rtib004
   CASE 
      WHEN SQLCA.SQLCODE = 100 LET g_errno = 'art-00264'
      WHEN l_rtdxstus <> 'Y'   LET g_errno = 'art-00265'
      OTHERWISE                LET g_errno = SQLCA.SQLCODE USING '-------'
   END CASE
   IF cl_null(g_errno) THEN 
      IF NOT cl_null(g_rtib_d[l_ac].rtib001) AND NOT cl_null(g_rtib_d[l_ac].rtib002) THEN
         #150424-00020#2--mark by dongsz--str---  
#         SELECT DISTINCT xmdastus,xmda001 INTO l_xmdastus,l_xmda001
#           FROM xmda_t,xmdc_t
#          WHERE xmdaent = g_enterprise
#            AND xmdadocno = xmdcdocno
#            AND xmdcent = xmdaent 
#            AND xmdcdocno = g_rtib_d[l_ac].rtib001
#            AND xmdcseq = g_rtib_d[l_ac].rtib002
#            AND xmdc001 = g_rtib_d[l_ac].rtib004
         #150424-00020#2--mark by dongsz--end---
         #150424-00020#2--add by dongsz--str---
         SELECT DISTINCT rtilstus INTO l_rtilstus
           FROM rtil_t,rtim_t
          WHERE rtilent = g_enterprise
            AND rtildocno = rtimdocno
            AND rtiment = rtilent 
            AND rtimdocno = g_rtib_d[l_ac].rtib001
            AND rtimseq = g_rtib_d[l_ac].rtib002
            AND rtim004 = g_rtib_d[l_ac].rtib004
         #150424-00020#2--add by dongsz--end---
          CASE 
             WHEN SQLCA.SQLCODE = 100 LET g_errno = 'art-00294'
             OTHERWISE                LET g_errno = SQLCA.SQLCODE USING '-------'
          END CASE
      END IF             
   END IF
    
END FUNCTION
################################################################################
# Descriptions...: 商品带值
# Memo...........:
# Usage..........: 无
# Input parameter: 无
# Return code....: 无
# Date & Author..: 2014/02/25 By yangxf
# Modify.........:
################################################################################
PRIVATE FUNCTION artt622_rtib004_display()
DEFINE l_oodb011   LIKE oodb_t.oodb011
DEFINE l_imaystus  LIKE imay_t.imaystus

   IF NOT cl_null(g_rtib_d[l_ac].rtib003) THEN 
      SELECT imaystus INTO l_imaystus
        FROM imay_t
       WHERE imayent = g_enterprise
         AND imay001 = g_rtib_d[l_ac].rtib004
         AND imay003 = g_rtib_d[l_ac].rtib003
      CASE 
        WHEN SQLCA.SQLCODE = 100 LET g_errno = 'art-00295'
        WHEN l_imaystus <> 'Y'   LET g_errno = 'art-00047'
        OTHERWISE                LET g_errno = SQLCA.SQLCODE USING '-------'
      END CASE
      IF NOT cl_null(g_errno) THEN 
         LET g_errno = ''
         LET g_rtib_d[l_ac].rtib003 = ''
      END IF 
   END IF 
   IF cl_null(g_rtib_d[l_ac].rtib003) THEN 
      SELECT DISTINCT imay003 
        INTO g_rtib_d[l_ac].rtib003
        FROM imay_t
       WHERE imayent = g_enterprise
         AND imay001 = g_rtib_d[l_ac].rtib004
         AND imay006 = 'Y'      
   END IF 
   SELECT oodb011 INTO l_oodb011
     FROM oodb_t,ooef_t
    WHERE oodbent = ooefent
      AND oodb001 = ooef019
      AND oodb002 = g_rtia_m.rtia028
      AND ooef001 = g_rtia_m.rtiasite   
   IF l_oodb011 = '1' THEN 
      LET g_rtib_d[l_ac].rtib006 = g_rtia_m.rtia028
   ELSE
      #带出税别
      SELECT rtdx014 INTO g_rtib_d[l_ac].rtib006
        FROM rtdx_t
       WHERE rtdxent = g_enterprise 
         AND rtdxsite = g_rtia_m.rtiasite
         AND rtdx001 = g_rtib_d[l_ac].rtib004      
      SELECT oodbl004 INTO g_rtib_d[l_ac].rtib006_desc 
        FROM oodbl_t,ooef_t
       WHERE oodblent = ooefent
        AND ooefent = g_enterprise
        AND ooef001 = g_rtia_m.rtiasite
        AND oodbl001 = ooef019
        AND oodbl002 = g_rtib_d[l_ac].rtib006         
   END IF    
#   #带出税别
#   SELECT rtdx014 INTO g_rtib_d[l_ac].rtib006
#     FROM rtdx_t
#    WHERE rtdxent = g_enterprise 
#      AND rtdxsite = g_rtia_m.rtiasite
#      AND rtdx001 = g_rtib_d[l_ac].rtib004
      
#   #带出销售单位
#   SELECT imaa105,imaa106 INTO g_rtib_d[l_ac].rtib013,g_rtib_d[l_ac].rtib018
#     FROM imaa_t
#    WHERE imaaent = g_enterprise
#      AND imaa001 = g_rtib_d[l_ac].rtib004
    #带出销售单位,计价单位
    IF NOT cl_null(g_rtib_d[l_ac].rtib003) THEN 
       SELECT imay004,imay012,imay014
         INTO g_rtib_d[l_ac].rtib013,g_rtib_d[l_ac].rtib018,g_rtib_d[l_ac].rtib015
         FROM imay_t
        WHERE imayent = g_enterprise
          AND imay001 = g_rtib_d[l_ac].rtib004
          AND imay003 = g_rtib_d[l_ac].rtib003
    ELSE
       SELECT imaa104,imaa105,imaa106 INTO g_rtib_d[l_ac].rtib015,g_rtib_d[l_ac].rtib013,g_rtib_d[l_ac].rtib018
         FROM imaa_t
        WHERE imaaent = g_enterprise
          AND imaa001 = g_rtib_d[l_ac].rtib004
    END IF 
      
   #获取商品特征码
   SELECT imaa005 INTO g_rtib_d[l_ac].rtib005
     FROM imaa_t
    WHERE imaaent = g_enterprise
      AND imaa001 = g_rtib_d[l_ac].rtib004
      
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_rtib_d[l_ac].rtib013
   CALL ap_ref_array2(g_ref_fields,"SELECT oocal003 FROM oocal_t WHERE oocalent='"||g_enterprise||"' AND oocal001=? AND oocal002='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_rtib_d[l_ac].rtib013_desc = '', g_rtn_fields[1] , ''
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_rtib_d[l_ac].rtib018
   CALL ap_ref_array2(g_ref_fields,"SELECT oocal003 FROM oocal_t WHERE oocalent='"||g_enterprise||"' AND oocal001=? AND oocal002='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_rtib_d[l_ac].rtib018_desc = '', g_rtn_fields[1] , ''
   LET g_rtib_d[l_ac].rtib025 = '' 
   LET g_rtib_d[l_ac].rtib026 = ''
   LET g_rtib_d[l_ac].rtib027 = ''
#mark by yangxf ---start----
#   #收银机不为空预设库区，储位，批号
#   IF NOT cl_null(g_rtia_m.rtia036) THEN 
#      SELECT inag004,inag005,inag006
#        INTO g_rtib_d[l_ac].rtib025,g_rtib_d[l_ac].rtib026,g_rtib_d[l_ac].rtib027
#        FROM pcao_t,inag_t
#       WHERE pcaoent = g_enterprise
#         AND pcaosite = g_rtia_m.rtiasite
#         AND pcao001 = g_rtia_m.rtia036
#         AND pcaoent = inagent
#         AND inagsite = pcaosite
#         AND inag001 = g_rtib_d[l_ac].rtib004
#         AND inag004 = pcao002
#       ORDER BY inag004
#   ELSE
#      SELECT inag004,inag005,inag006
#        INTO g_rtib_d[l_ac].rtib025,g_rtib_d[l_ac].rtib026,g_rtib_d[l_ac].rtib027
#        FROM inag_t
#       WHERE inagent = g_enterprise
#         AND inagsite = g_rtia_m.rtiasite
#         AND inag001 = g_rtib_d[l_ac].rtib004
#       ORDER BY inag004
#   END IF 
#mark by yangxf ----end----
#add by yangxf ---start----预设值带门店商品清单中的库区
   SELECT rtdx044 INTO g_rtib_d[l_ac].rtib025
     FROM rtdx_t 
    WHERE rtdxent = g_enterprise
      AND rtdxsite = g_rtia_m.rtiasite
      AND rtdx001 = g_rtib_d[l_ac].rtib004
   #150819-00004#1 150819 By pomelo mark(S)
   #SELECT inag005,inag006
   #  INTO g_rtib_d[l_ac].rtib026,g_rtib_d[l_ac].rtib027
   #  FROM inag_t
   # WHERE inagent = g_enterprise
   #   AND inagsite = g_rtia_m.rtiasite
   #   AND inag004 = g_rtib_d[l_ac].rtib025
   #   AND inag001 = g_rtib_d[l_ac].rtib004
   #150819-00004#1 150819 By pomelo mark(E)
   IF g_prog = 'artt620' THEN 
      SELECT SUM(inag008) INTO g_rtib_d[l_ac].inag008
        FROM inag_t
       WHERE inagent = g_enterprise
         AND inagsite = g_rtia_m.rtiasite
         AND inag001 = g_rtib_d[l_ac].rtib004
   END IF 
#add by yangxf ---end------
END FUNCTION
################################################################################
# Descriptions...: 地址设置
# Memo...........:
# Usage..........: 
# Input parameter: 无
# Return code....: 无
# Date & Author..: 2014/02/20 By yangxf
# Modify.........:
################################################################################
PRIVATE FUNCTION artt622_adress(p_sign)
DEFINE  l_oocn002   LIKE oocn_t.oocn002
DEFINE  l_rtia020   LIKE rtia_t.rtia020
DEFINE  l_rtia019   LIKE rtia_t.rtia019
DEFINE  p_sign      LIKE type_t.chr1

   LET g_errno = ''
   IF g_rtia_m.rtiastus<>'N' THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = "amm-00038"
      LET g_errparam.extend = g_rtia_m.rtiastus
      LET g_errparam.popup = TRUE
      CALL cl_err()

      RETURN
   END IF
   IF cl_null(g_rtia_m.rtiadocno) THEN 
      RETURN 
   END IF 
   CALL s_transaction_begin()
   CALL artt600_01(g_rtia_m.rtiadocno,g_enterprise,g_sign) RETURNING g_errno,l_rtia019,l_rtia020
   IF NOT cl_null(g_errno) THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = g_errno
      LET g_errparam.extend = g_rtia_m.rtiadocno
      LET g_errparam.popup = TRUE
      CALL cl_err()

      CALL s_transaction_end('N','0')
      RETURN
   END IF
   IF NOT cl_null(l_rtia019) THEN
      LET g_rtia_m.rtia019 = l_rtia019
   END IF
   IF NOT cl_null(l_rtia020) THEN
      LET g_rtia_m.rtia020 = l_rtia020
   END IF
   IF cl_null(l_rtia019) AND cl_null(l_rtia020) THEN 
      RETURN 
   END IF 
   OPEN artt622_cl USING g_enterprise,g_rtia_m.rtiadocno
   IF STATUS THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code =  STATUS
      LET g_errparam.extend = "OPEN artt622_cl:"
      LET g_errparam.popup = TRUE
      CALL cl_err()

      CLOSE artt622_cl
      CALL s_transaction_end('N','0')
   ELSE
      UPDATE rtia_t SET rtia019 = l_rtia019,
                        rtia020 = l_rtia020
       WHERE rtiaent = g_enterprise
         AND rtiadocno = g_rtia_m.rtiadocno
      IF SQLCA.sqlcode THEN
        INITIALIZE g_errparam TO NULL
        LET g_errparam.code = SQLCA.sqlcode
        LET g_errparam.extend = ''
        LET g_errparam.popup = TRUE
        CALL cl_err()

         CLOSE artt622_cl
         CALL s_transaction_end('N','0')
      ELSE
         CLOSE artt622_cl
         CALL s_transaction_end('Y','0')
      END IF
   END IF 
   DISPLAY BY NAME g_rtia_m.rtia019,g_rtia_m.rtia020
END FUNCTION
################################################################################
# Descriptions...: 邮编检查
# Memo...........:
# Usage..........: 
# Input parameter: 无
# Return code....: 无
# Date & Author..: 2014/02/20 By yangxf
# Modify.........:
################################################################################
PRIVATE FUNCTION artt622_rtia019_chk()
DEFINE   l_cnt      LIKE type_t.num5
DEFINE   l_cnt1     LIKE type_t.num5
DEFINE   l_ooef006  LIKE ooef_t.ooef006
DEFINE   l_oocn001  LIKE oocn_t.oocn001
DEFINE   l_oocn003  LIKE oocn_t.oocn003
DEFINE   l_oocn004  LIKE oocn_t.oocn004
DEFINE   l_oocn005  LIKE oocn_t.oocn005
DEFINE   l_oocn006  LIKE oocn_t.oocn006 
DEFINE   l_oocgl003 LIKE oocgl_t.oocgl003
DEFINE   l_oocil004 LIKE oocil_t.oocil004
DEFINE   l_oockl005 LIKE oockl_t.oockl005
DEFINE   l_oocml006 LIKE oocml_t.oocml006   
   
   LET g_errno = NULL
   SELECT COUNT(*) INTO l_cnt  FROM oocn_t WHERE oocn002 =g_rtia_m.rtia019 AND oocnent = g_enterprise
   IF l_cnt <= 0 THEN
      LET g_errno = "aoo-00151"
   ELSE
      SELECT COUNT(*) INTO l_cnt1  FROM oocn_t WHERE oocn002 =g_rtia_m.rtia019 AND oocnent = g_enterprise 
         AND oocnstus='Y'
      IF l_cnt1 <= 0 THEN
         LET g_errno = "aoo-00152"
      END IF
   END IF
   IF cl_null(g_errno) THEN
      SELECT ooef006 INTO l_ooef006 
        FROM ooef_t WHERE ooef001 = g_rtia_m.rtiasite AND ooefent = g_enterprise
      SELECT oocn001,oocn003,oocn004,oocn005,oocn006 INTO l_oocn001,l_oocn003,l_oocn004,l_oocn005,l_oocn006
        FROM oocn_t
       WHERE oocn002 = g_rtia_m.rtia019 AND rownum=1
         AND oocnent = g_enterprise  #160905-00007#15 by 08172
      SELECT COALESCE(oockl005,oockl003) INTO l_oockl005 FROM oockl_t 
       WHERE oocklent=g_enterprise
         AND oockl004=g_dlang  AND oockl001=l_oocn001 AND oockl002= l_oocn003
         AND oockl003 = l_oocn004 AND oocklent = g_enterprise

      SELECT COALESCE(oocil004,oocil002) INTO l_oocil004 FROM oocil_t WHERE oocil001 = l_oocn001
         AND oocil002 = l_oocn003 AND oocil003 = g_dlang  AND oocilent = g_enterprise
      
      SELECT COALESCE(oocml006,oocml004) INTO l_oocml006 FROM oocml_t
       WHERE oocml001 = l_oocn001 AND oocml002 = l_oocn003 AND oocml003 = l_oocn004
         AND oocml004 = l_oocn005 AND oocml005 = g_dlang AND oocmlent = g_enterprise
   
      SELECT COALESCE(oocgl003,oocgl001) INTO l_oocgl003 FROM oocgl_t 
       WHERE oocgl001 = l_oocn001 AND oocgl002 = g_dlang AND oocglent = g_enterprise 

      IF cl_null(l_oockl005) THEN LET l_oockl005 = l_oocn004 END IF
      IF cl_null(l_oocil004) THEN LET l_oocil004 = l_oocn003 END IF
      IF cl_null(l_oocml006) THEN LET l_oocml006 = l_oocn005 END IF
      IF cl_null(l_oocgl003) THEN LET l_oocgl003 = l_oocn001 END IF
      IF cl_null(g_rtia_m.rtia001) OR (NOT cl_null(g_rtia_m.rtia001) AND cl_null(g_rtia_m.rtia020))THEN 
         IF (g_rtia_m.rtia019 <> g_rtia_m_t.rtia019 OR cl_null(g_rtia_m_t.rtia019)) OR  cl_null(g_rtia_m.rtia020) THEN
            LET g_rtia_m.rtia020 = l_oocgl003 CLIPPED,l_oocil004 CLIPPED,l_oockl005 CLIPPED,l_oocml006 CLIPPED,l_oocn006 CLIPPED
         END IF
      END IF          
      DISPLAY g_rtia_m.rtia020 TO rtia020
   END IF 
   
END FUNCTION
################################################################################
# Descriptions...: 检查理由码
# Memo...........:
# Usage..........: 无
# Input parameter: 无
# Return code....: 无
# Date & Author..: 2014/02/26 By yangxf
# Modify.........:
################################################################################
PRIVATE FUNCTION artt622_rtib024_chk()
   DEFINE l_oocqstus   LIKE oocq_t.oocqstus
   
   LET g_errno = ''
   SELECT oocqstus INTO l_oocqstus
     FROM oocq_t
    WHERE oocqent = g_enterprise
      AND oocq001 = '278'
      AND oocq002 = g_rtib_d[l_ac].rtib024
   CASE 
#      WHEN SQLCA.SQLCODE = 100 LET g_errno = 'art-00270'    #160318-00005#43  mark
      WHEN SQLCA.SQLCODE = 100 LET g_errno = 'sub-01303'    #160318-00005#43  add
      WHEN l_oocqstus <> 'Y'   LET g_errno = 'art-00271'
      OTHERWISE                LET g_errno = SQLCA.SQLCODE USING '-------'
   END CASE
END FUNCTION
################################################################################
# Descriptions...: 库区检查
# Memo...........:
# Usage..........: 无
# Input parameter: 无
# Return code....: 无
# Date & Author..: 2014/02/27 By yangxf
# Modify.........:
################################################################################
PRIVATE FUNCTION artt622_rtib025_chk()
   DEFINE l_n      LIKE type_t.num5
   DEFINE l_sql    STRING
   DEFINE l_table  STRING
   DEFINE l_where  STRING 
   
   LET g_errno = ''
   LET l_n = 0
   #150324-00007#7 150507 by sakura modify---STR
   #抓取庫區基本檔
   LET l_sql = "SELECT COUNT(*) "
   LET l_table = "  FROM inaa_t "
   LET l_where = " WHERE inaaent = '",g_enterprise,"' ",
                 "   AND inaasite = '",g_rtia_m.rtiasite,"'",
                 "   AND inaa001 = '",g_rtib_d[l_ac].rtib025,"'"
   #LET l_sql = "SELECT COUNT(*) "
   #LET l_table = "  FROM inag_t "
   #LET l_where = " WHERE inagent = '",g_enterprise,"' ",
   #              "   AND inagsite = '",g_rtia_m.rtiasite,"'",
   #              "   AND inag004 = '",g_rtib_d[l_ac].rtib025,"'"
   #IF NOT cl_null(g_rtib_d[l_ac].rtib004) THEN 
   #   LET l_where = l_where," AND inag001 = '",g_rtib_d[l_ac].rtib004,"'"
   #END IF
   IF NOT cl_null(g_rtia_m.rtia036) THEN
      LET l_table = l_table,",pcao_t "   
      LET l_where = l_where," AND pcao001 = '",g_rtia_m.rtia036,"' ",
                           #" AND pcaoent = inagent ",
                           #" AND pcaosite = inagsite " ,
                            " AND pcaoent = inaaent ",
                            " AND pcaosite = inaasite " ,                            
                            " AND pcao002 = '",g_rtib_d[l_ac].rtib025,"'"
   END IF
   #150324-00007#7 150507 by sakura modify---END
##add by yangxf ----start----  #检查库存是否存在门店商品清单档中，如有收银机，关联收银机对对应的库区表
#   LET l_sql = "SELECT COUNT(*) "
#   LET l_table = "  FROM rtdx_t "
#   LET l_where = " WHERE rtdxent = '",g_enterprise,"' ",
#                 "   AND rtdxsite = '",g_rtia_m.rtiasite,"'",
#                 "   AND rtdx044 = '",g_rtib_d[l_ac].rtib025,"'"
#   IF NOT cl_null(g_rtib_d[l_ac].rtib004) THEN 
#      LET l_where = l_where," AND rtdx001 = '",g_rtib_d[l_ac].rtib004,"'"
#   END IF 
#   IF NOT cl_null(g_rtia_m.rtia036) THEN
#      LET l_table = l_table,",pcao_t "   
#      LET l_where = l_where," AND pcao001 = '",g_rtia_m.rtia036,"' ",
#                            " AND pcaoent = rtdxent ",
#                            " AND pcaosite = rtdxsite " ,
#                            " AND pcao002 = '",g_rtib_d[l_ac].rtib025,"'"
#   END IF
##add by yangxf ----end------
   LET l_sql = l_sql,l_table,l_where
   PREPARE sel_cn1 FROM l_sql
   EXECUTE sel_cn1 INTO l_n
   IF l_n = 0 THEN
      IF NOT cl_null(g_rtia_m.rtia036) THEN
         LET g_errno = 'art-00275'
      ELSE
         LET g_errno = 'art-00276'
      END IF 
   END IF 
END FUNCTION
################################################################################
# Descriptions...: 储位检查
# Memo...........:
# Usage..........: 无
# Input parameter: 无
# Return code....: 无
# Date & Author..: 2014/02/27 By yangxf
# Modify.........:
################################################################################
PRIVATE FUNCTION artt622_rtib026_chk()
   DEFINE l_n      LIKE type_t.num5
   
   LET g_errno = ''
   LET l_n = 0
   #150324-00007#7 150507 by sakura modify---STR
   #檢查儲位基本檔
   SELECT COUNT(*) INTO l_n
     FROM inab_t
    WHERE inabent = g_enterprise
      AND inabsite = g_rtia_m.rtiasite
      AND inab001 = g_rtib_d[l_ac].rtib025 #庫位編號
      AND inab002 = g_rtib_d[l_ac].rtib026 #儲位編號
   #IF NOT cl_null(g_rtib_d[l_ac].rtib004) THEN 
   #   SELECT COUNT(*) INTO l_n
   #     FROM inag_t
   #    WHERE inagent = g_enterprise
   #      AND inagsite = g_rtia_m.rtiasite
   #      AND inag001 = g_rtib_d[l_ac].rtib004
   #      AND inag005 = g_rtib_d[l_ac].rtib026
   #      AND inag004 = g_rtib_d[l_ac].rtib025
   #ELSE
   #   SELECT COUNT(*) INTO l_n
   #     FROM inag_t
   #    WHERE inagent = g_enterprise
   #      AND inagsite = g_rtia_m.rtiasite
   #      AND inag005 = g_rtib_d[l_ac].rtib026
   #      AND inag004 = g_rtib_d[l_ac].rtib025
   #END IF
   IF l_n = 0 THEN 
      #LET g_errno = 'art-00278'
      LET g_errno = 'ain-00382'
   END IF
   #150324-00007#7 150507 by sakura modify---END   
END FUNCTION
################################################################################
# Descriptions...: 批号检查
# Memo...........:
# Usage..........: 无
# Input parameter: 无
# Return code....: 无
# Date & Author..: 2014/02/27 By yangxf
# Modify.........:
################################################################################
PRIVATE FUNCTION artt622_rtib027_chk()
   DEFINE l_n      LIKE type_t.num5
   DEFINE l_sql    STRING
   DEFINE l_where  STRING
   LET g_errno = ''
   LET l_n = 0
   LET l_sql =  "SELECT COUNT(*) FROM inag_t "
   LET l_where = "WHERE inagent = '",g_enterprise,"'",
                 "  AND inagsite = '",g_rtia_m.rtiasite,"'"
   IF NOT cl_null(g_rtib_d[l_ac].rtib004) THEN 
      LET l_where = l_where," AND inag001 = '",g_rtib_d[l_ac].rtib004,"'"
   END IF 
   IF NOT cl_null(g_rtib_d[l_ac].rtib025) THEN 
      LET l_where = l_where," AND inag004 = '",g_rtib_d[l_ac].rtib025,"'"
   END IF 
   IF NOT cl_null(g_rtib_d[l_ac].rtib026) THEN 
      LET l_where = l_where," AND inag005 = '",g_rtib_d[l_ac].rtib026,"'"
   END IF 
   IF NOT cl_null(g_rtib_d[l_ac].rtib027) THEN 
      LET l_where = l_where," AND inag006 = '",g_rtib_d[l_ac].rtib027,"'"
   END IF 
   LET l_sql = l_sql,l_where
   PREPARE sel_cnt FROM l_sql
   EXECUTE sel_cnt INTO l_n
   IF l_n = 0 THEN 
      LET g_errno = 'art-00279'
   END IF 
END FUNCTION
################################################################################
# Descriptions...: 商品条码带值
# Memo...........:
# Usage..........: 无
# Input parameter: 无
# Return code....: 无
# Date & Author..: 2014/03/04 By yangxf
# Modify.........:
################################################################################
PRIVATE FUNCTION artt622_rtib003_display()
   DEFINE r_success    LIKE type_t.num5 
   SELECT DISTINCT imay001 
     INTO g_rtib_d[l_ac].rtib004
     FROM imay_t
    WHERE imayent = g_enterprise
      AND imay003 = g_rtib_d[l_ac].rtib003
      
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_rtib_d[l_ac].rtib004
   CALL ap_ref_array2(g_ref_fields,"SELECT imaal003,imaal004 FROM imaal_t WHERE imaalent='"||g_enterprise||"' AND imaal001=? AND imaal002='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_rtib_d[l_ac].rtib004_desc = '', g_rtn_fields[1] , ''
   LET g_rtib_d[l_ac].rtib004_desc_desc = '', g_rtn_fields[2] , ''
   DISPLAY BY NAME g_rtib_d[l_ac].rtib004_desc,g_rtib_d[l_ac].rtib004_desc_desc
  
   CALL artt622_rtib004_display()   
END FUNCTION
################################################################################
# Descriptions...: 计算应收金额
# Memo...........:
# Usage..........: 无
# Input parameter: 无
# Return code....: 无
# Date & Author..: 2014/03/11 By yangxf
# Modify.........:
################################################################################
PRIVATE FUNCTION artt622_rtib021()
#库存单位
DEFINE l_imaa104   LIKE imaa_t.imaa104
#销售单位
DEFINE l_imaa105   LIKE imaa_t.imaa105
#计价单位
DEFINE l_imaa106   LIKE imaa_t.imaa106
DEFINE l_rate      LIKE inaj_t.inaj014
DEFINE l_rate1     LIKE inaj_t.inaj014
DEFINE l_success   LIKE type_t.num5
DEFINE l_ooef016   LIKE ooef_t.ooef016

   IF NOT cl_null(g_rtib_d[l_ac].rtib004) THEN 
      IF NOT cl_null(g_rtib_d[l_ac].rtib003) THEN 
         SELECT imay004,imay012,imay014
           INTO l_imaa105,l_imaa106,l_imaa104
           FROM imay_t
          WHERE imayent = g_enterprise
            AND imay001 = g_rtib_d[l_ac].rtib004
            AND imay003 = g_rtib_d[l_ac].rtib003
      ELSE
         SELECT imaa104,imaa105,imaa106 INTO l_imaa104,l_imaa105,l_imaa106
           FROM imaa_t
          WHERE imaaent = g_enterprise
            AND imaa001 = g_rtib_d[l_ac].rtib004
      END IF 
   END IF 
   IF cl_null(g_rtib_d[l_ac].rtib004) OR cl_null(g_rtib_d[l_ac].rtib012) THEN 
      RETURN 
   END IF 
   #計價單位
   LET g_rtib_d[l_ac].rtib018 = l_imaa106
   #计算销售单位与库存单位转换率
  #141224-00013#15---sakura---mod---str 
   CALL s_aimi190_get_convert(g_rtib_d[l_ac].rtib004,l_imaa105,l_imaa104) RETURNING l_success,l_rate
   IF NOT l_success THEN 
      RETURN
   END IF
   CALL s_aooi250_convert_qty(g_rtib_d[l_ac].rtib004,l_imaa105,l_imaa104,g_rtib_d[l_ac].rtib012) RETURNING l_success,g_rtib_d[l_ac].rtib014
   IF NOT l_success THEN 
      RETURN
   END IF   
   #计算销售单位与计价单位转换率
   CALL s_aimi190_get_convert(g_rtib_d[l_ac].rtib004,l_imaa105,l_imaa106) RETURNING l_success,l_rate1
   IF NOT l_success THEN 
      RETURN
   END IF
   CALL s_aooi250_convert_qty(g_rtib_d[l_ac].rtib004,l_imaa105,l_imaa106,g_rtib_d[l_ac].rtib012) RETURNING l_success,g_rtib_d[l_ac].rtib017
   IF NOT l_success THEN 
      RETURN
   END IF   
   #库存数量
  #LET g_rtib_d[l_ac].rtib014 = g_rtib_d[l_ac].rtib012 * l_rate
   #库存单位
   LET g_rtib_d[l_ac].rtib015 = l_imaa104
   #銷售庫存單位換算率
   LET g_rtib_d[l_ac].rtib016 = l_rate
   #計價數量     
  #LET g_rtib_d[l_ac].rtib017 = g_rtib_d[l_ac].rtib012 * l_rate1
  #141224-00013#15---sakura---mod---end 
   #銷售計價單位換算率
   LET g_rtib_d[l_ac].rtib019 = l_rate1
   IF NOT cl_null(g_rtib_d[l_ac].rtib010) AND NOT cl_null(g_rtib_d[l_ac].rtib017) THEN     #add by yangxf
      #应收金额 = 交易价*计价数量
      LET g_rtib_d[l_ac].rtib021 = g_rtib_d[l_ac].rtib010 * g_rtib_d[l_ac].rtib017
      LET g_rtib_d[l_ac].rtib021 = s_curr_round(g_rtia_m.rtiasite,g_rtia_m.rtia026,g_rtib_d[l_ac].rtib021,'2')
      #计算本币应收金额
      LET g_rtib_d[l_ac].rtib031 = g_rtib_d[l_ac].rtib021 * g_rtia_m.rtia027
      SELECT ooef016 INTO l_ooef016
        FROM ooef_t
       WHERE ooefent = g_enterprise
         AND ooef001 = g_rtia_m.rtiasite
      LET g_rtib_d[l_ac].rtib031 = s_curr_round(g_rtia_m.rtiasite,l_ooef016,g_rtib_d[l_ac].rtib031,'2')
   END IF  #add by yangxf
END FUNCTION
################################################################################
# Descriptions...: 客户带值
# Memo...........:
# Usage..........: 无
# Input parameter: 无
# Return code....: 无
# Date & Author..: 2014/03/18 By yangxf
# Modify.........:
################################################################################
PRIVATE FUNCTION artt622_rtia002_display()
   DEFINE l_rtia010              LIKE rtia_t.rtia010
   DEFINE l_rtia011              LIKE rtia_t.rtia011
   DEFINE l_rtia012              LIKE rtia_t.rtia012
   DEFINE l_rtia025              LIKE rtia_t.rtia025
   DEFINE l_rtia026              LIKE rtia_t.rtia026
   DEFINE l_rtia027              LIKE rtia_t.rtia027
   DEFINE l_ooef015    LIKE ooef_t.ooef015
   DEFINE l_ooef016    LIKE ooef_t.ooef016
   DEFINE l_ooam005    LIKE ooam_t.ooam005
   DEFINE l_gzsz008    LIKE gzsz_t.gzsz008

   LET l_rtia025 = ''
   LET l_rtia026 = ''
   LET l_rtia027 = ''
   LET l_rtia010 = ''
   LET l_rtia011 = ''
   LET l_rtia012 = ''
   #带出送货客户、帐款客户、发票客户
   SELECT pmac002 INTO l_rtia010
     FROM pmac_t
    WHERE pmacent = g_enterprise 
      AND pmac001 = g_rtia_m.rtia002
      AND pmac003 = '2'
      AND pmac004 = 'Y'
   SELECT pmac002 INTO l_rtia011
     FROM pmac_t
    WHERE pmacent = g_enterprise 
      AND pmac001 = g_rtia_m.rtia002
      AND pmac003 = '1'
      AND pmac004 = 'Y'        
   SELECT pmac002 INTO l_rtia012
     FROM pmac_t
    WHERE pmacent = g_enterprise    
      AND pmac001 = g_rtia_m.rtia002
      AND pmac003 = '3'
      AND pmac004 = 'Y'     
   LET g_rtia_m.rtia010 = l_rtia010   
   LET g_rtia_m.rtia011 = l_rtia011
   LET g_rtia_m.rtia012 = l_rtia012
   DISPLAY BY NAME g_rtia_m.rtia010,g_rtia_m.rtia011,g_rtia_m.rtia012         
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_rtia_m.rtia010
   CALL ap_ref_array2(g_ref_fields,"SELECT pmaal004 FROM pmaal_t WHERE pmaalent='"||g_enterprise||"' AND pmaal001=? AND pmaal002='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_rtia_m.rtia010_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_rtia_m.rtia010_desc

   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_rtia_m.rtia011
   CALL ap_ref_array2(g_ref_fields,"SELECT pmaal004 FROM pmaal_t WHERE pmaalent='"||g_enterprise||"' AND pmaal001=? AND pmaal002='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_rtia_m.rtia011_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_rtia_m.rtia011_desc

   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_rtia_m.rtia012
   CALL ap_ref_array2(g_ref_fields,"SELECT pmaal004 FROM pmaal_t WHERE pmaalent='"||g_enterprise||"' AND pmaal001=? AND pmaal002='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_rtia_m.rtia012_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_rtia_m.rtia012_desc  
   #抓取客户主要收款条件
   SELECT pmad002 INTO l_rtia025
     FROM pmad_t
    WHERE pmadent = g_enterprise
      AND pmad001 = g_rtia_m.rtia002
      AND pmad004 = 'Y'
      AND pmadstus = 'Y'
      AND pmad003 = '2'
   LET g_rtia_m.rtia025 = l_rtia025
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_rtia_m.rtia025
   CALL ap_ref_array2(g_ref_fields,"SELECT ooibl004 FROM ooibl_t WHERE ooiblent='"||g_enterprise||"' AND ooibl002=? AND ooibl003='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_rtia_m.rtia025_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_rtia_m.rtia025_desc
   #抓取客户惯用币别
   SELECT pmab083 INTO l_rtia026
     FROM pmab_t
    WHERE pmabent = g_enterprise
#      AND pmabsite = g_rtia_m.rtiasite      #mark by yangxf
      AND pmabsite = 'ALL'                   #add by yangxf
      AND pmab001 = g_rtia_m.rtia002
   LET g_rtia_m.rtia026 = l_rtia026
   IF NOT cl_null(g_rtia_m.rtia026) THEN
      LET g_rate = NULL
      #取匯率參照表號、主幣別
      SELECT ooef015,ooef016 INTO l_ooef015,l_ooef016 FROM ooef_t  
       WHERE ooefent = g_enterprise AND ooef001 = g_rtia_m.rtiasite

      #取交易貨幣批量
      SELECT ooam005 INTO l_ooam005 FROM ooam_t
       WHERE ooament = g_enterprise AND ooam001 = l_ooef015
         AND ooam003 = g_rtia_m.rtia026 AND ooam004 = g_rtia_m.rtiadocdt

      #取匯率類型   
      CALL cl_get_para(g_enterprise,g_rtia_m.rtiasite,'S-BAS-0010') RETURNING l_gzsz008
      CALL s_aooi160_get_exrate('1',g_rtia_m.rtiasite,g_rtia_m.rtiadocdt,g_rtia_m.rtia026,l_ooef016,l_ooam005,l_gzsz008)
         RETURNING g_rtia_m.rtia027
   END IF 
   #抓取客户惯用税别
   SELECT pmab084 INTO g_rtia_m.rtia028
     FROM pmab_t
    WHERE pmabent = g_enterprise
#      AND pmabsite = g_rtia_m.rtiasite    #mark by yangxf
      AND pmabsite = 'ALL'                 #add by yangxf
      AND pmab001 = g_rtia_m.rtia002
   IF NOT cl_null(g_rtia_m.rtia028) THEN 
      SELECT DISTINCT oodb005,oodb006
        INTO g_rtia_m.rtia030,g_rtia_m.rtia029
        FROM ooef_t,oodb_t 
        WHERE oodbent = g_enterprise
          AND ooef019 = oodb001
          AND ooefent = oodbent
          AND oodb002 = g_rtia_m.rtia028
          AND ooef001 = g_rtia_m.rtiasite
          AND oodbstus = 'Y'
   END IF 
   
   DISPLAY BY NAME g_rtia_m.rtia025,g_rtia_m.rtia026,g_rtia_m.rtia027,g_rtia_m.rtia028,
                   g_rtia_m.rtia029,g_rtia_m.rtia030
   #add by yangxf ---start---
   IF NOT cl_null(g_rtia_m.rtia025) THEN 
      CALL artt622_set_required()   
   END IF 
   #add by yangxf ---end----
END FUNCTION
################################################################################
# Descriptions...: 班别检查
# Memo...........:
# Usage..........: 无
# Input parameter: 无
# Return code....: 无
# Date & Author..: 2014/03/19 By yangxf
# Modify.........:
################################################################################
PRIVATE FUNCTION artt622_rtia038_chk()
   DEFINE l_oogdstus   LIKE oogd_t.oogdstus
   
   LET g_errno = ''
   SELECT oogdstus INTO l_oogdstus
     FROM oogd_t
    WHERE oogdent = g_enterprise
      AND oogd001 = g_rtia_m.rtia038
      AND oogdsite = g_rtia_m.rtiasite
   CASE 
      WHEN SQLCA.SQLCODE = 100 LET g_errno = 'art-00299'
      WHEN l_oogdstus <> 'Y'   LET g_errno = 'art-00300'
      OTHERWISE                LET g_errno = SQLCA.SQLCODE USING '-------'
   END CASE
   
END FUNCTION
################################################################################
# Descriptions...: 描述说明
# Memo...........:
# Usage..........: 无
# Input parameter: 无
# Return code....: 无
# Date & Author..: 2014/03/20 By yangxf
# Modify.........:
################################################################################
PRIVATE FUNCTION artt622_rtiasite_chk()
DEFINE l_n         LIKE type_t.num5
DEFINE l_sql       STRING 

   LET g_errno = ''
   LET l_n = 0
   SELECT COUNT(*) INTO l_n
     FROM ooed_t
    WHERE ooed004 = g_rtia_m.rtiasite
      AND ooed001='8'
      AND ooedent = g_enterprise
   IF l_n = 0 THEN 
      LET g_errno = 'art-00301'
      RETURN 
   END IF 
   LET l_n = 0
   SELECT COUNT(*) INTO l_n
     FROM ooed_t
    WHERE ooed004 = g_rtia_m.rtiasite
      AND ooed001='8'
      AND ooedent = g_enterprise
      AND ooed006<= g_today
      AND (ooed007>= g_today OR ooed007 IS NULL)
   IF l_n = 0 THEN 
      LET g_errno = 'art-00302'
      RETURN 
   END IF 
   LET l_n = 0            
   LET l_sql = " SELECT COUNT(*) ", 
               "   FROM ooed_t ",
               "  WHERE ooedent = '",g_enterprise,"' AND ooed001='8' ",
               "    AND ooed004 = '",g_rtia_m.rtiasite,"'",
               "    AND ooed006<= '",g_today,"' AND (ooed007>= '",g_today,"' OR ooed007 IS NULL) ", 
               "    AND ooed004 in (SELECT ooed004 FROM ooed_t START WITH ooed005= '",g_site,"' AND ooed001='8' AND ooed006<='",g_today,"' AND (ooed007>='",g_today,"' OR ooed007 IS NULL) ", 
               "           CONNECT BY nocycle PRIOR ooed004=ooed005 AND ooed001='8' AND ooed006<='",g_today,"' AND (ooed007>='",g_today,"' OR ooed007 IS NULL) " ,
               "         UNION SELECT ooed004 FROM ooed_t WHERE ooedent='",g_enterprise,"' AND ooed004 = '",g_site,"')",  #160905-00007#15 by 08172 add ent
               "  ORDER BY ooed004 "
   PREPARE sel_cn FROM l_sql
   EXECUTE sel_cn INTO l_n
   IF l_n = 0 THEN 
      LET g_errno = 'art-00221'
   END IF    
END FUNCTION
################################################################################
# Descriptions...: 带出订单数量及控管
# Memo...........:
# Usage..........: 无
# Input parameter: p_cmd 输入状态
# Return code....: 无
# Date & Author..: 2014/03/20 By yangxf
# Modify.........: 2015/05/05 By dongsz #150424-00020#2
################################################################################
PRIVATE FUNCTION artt622_rtib012(p_cmd)
DEFINE l_rtib012   LIKE rtib_t.rtib012
#DEFINE l_xmdc007   LIKE xmdc_t.xmdc007    #150424-00020#2--mark by dongsz
DEFINE l_rtim012   LIKE rtim_t.rtim012     #150424-00020#2--add by dongsz
DEFINE p_cmd       LIKE type_t.chr1
DEFINE l_rtib012_t LIKE rtib_t.rtib012

   LET g_errno = ''
   IF cl_null(g_rtib_d[l_ac].rtib001) OR cl_null(g_rtib_d[l_ac].rtib002) THEN
      RETURN 
   END IF
   #160604-00009#85--dongsz add--s
   IF g_rtib_d[l_ac].rtib042 = '2' THEN
      RETURN
   END IF
   #160604-00009#85--dongsz add--e
   #抓取订单数量
   #150424-00020#2--mark by dongsz--str---
#   SELECT xmdc007 INTO l_xmdc007
#     FROM xmdc_t
#    WHERE xmdcent = g_enterprise
#      AND xmdcdocno = g_rtib_d[l_ac].rtib001
#      AND xmdcseq = g_rtib_d[l_ac].rtib002
#   IF cl_null(l_xmdc007) THEN 
#      LET l_xmdc007 = 0
#   END IF
   #150424-00020#2--mark by dongsz--end---
   #add by yangxf ----start----
   IF g_prog = 'artt622' THEN 
      #150424-00020#2--add by dongsz--str---
      SELECT rtim012 INTO l_rtim012
        FROM rtim_t
       WHERE rtiment = g_enterprise
         AND rtimdocno = g_rtib_d[l_ac].rtib001
         AND rtimseq = g_rtib_d[l_ac].rtib002
      IF cl_null(l_rtim012) THEN 
         LET l_rtim012 = 0
      END IF
      #150424-00020#2--add by dongsz--end---
      #抓取出货单已有数量
      IF p_cmd = 'a' THEN 
         SELECT SUM(rtib012) INTO l_rtib012
           FROM rtib_t,rtia_t
          WHERE rtib001 = g_rtib_d[l_ac].rtib001
            AND rtib002 = g_rtib_d[l_ac].rtib002
            AND rtiaent = rtibent
            AND rtiadocno = rtibdocno
            AND rtiaent = g_enterprise
            AND rtiastus <> 'X'
         IF cl_null(l_rtib012) THEN 
            LET l_rtib012 = 0
         END IF 
      ELSE
         SELECT SUM(rtib012) INTO l_rtib012
           FROM rtib_t a,rtia_t
          WHERE rtib001 = g_rtib_d[l_ac].rtib001
            AND rtib002 = g_rtib_d[l_ac].rtib002
            AND rtiaent = rtibent
            AND rtiadocno = rtibdocno
            AND rtiaent = g_enterprise
            AND rtiastus <> 'X'
            AND NOT EXISTS (SELECT 1 FROM rtib_t b
                             WHERE b.rtibseq = g_rtib_d_t.rtibseq 
                               AND b.rtibdocno = g_rtia_m.rtiadocno
                               AND b.rtibent = g_enterprise
                               AND a.rtibent = b.rtibent
                               AND a.rtibdocno = b.rtibdocno
                               AND a.rtibseq = b.rtibseq)
         IF cl_null(l_rtib012) THEN
            LET l_rtib012 = 0
         END IF 
      END IF 
      #光标在订单或是项次中带出数量
      IF INFIELD(rtib001) OR INFIELD(rtib002) THEN 
         IF p_cmd = 'a' THEN 
            #LET g_rtib_d[l_ac].rtib012 = l_xmdc007 - l_rtib012    #150424-00020#2--mark by dongsz
            LET g_rtib_d[l_ac].rtib012 = l_rtim012 - l_rtib012     #150424-00020#2--add by dongsz
            IF g_rtib_d[l_ac].rtib012 <=0 THEN 
               LET g_rtib_d[l_ac].rtib012 = ''
            END IF 
         ELSE
            IF NOT cl_null(g_rtib_d[l_ac].rtib012) THEN 
               #IF g_rtib_d[l_ac].rtib012 > l_xmdc007 - l_rtib012 THEN   #150424-00020#2--mark by dongsz
               #   LET g_rtib_d[l_ac].rtib012 = l_xmdc007 - l_rtib012    #150424-00020#2--mark by dongsz
               IF g_rtib_d[l_ac].rtib012 > l_rtim012 - l_rtib012 THEN    #150424-00020#2--add by dongsz
                  LET g_rtib_d[l_ac].rtib012 = l_rtim012 - l_rtib012     #150424-00020#2--add by dongsz
               END IF 
            ELSE
               LET g_rtib_d[l_ac].rtib012 = l_rtim012 - l_rtib012
            END IF 
         END IF 
         IF g_rtib_d[l_ac].rtib012 <=0 THEN 
            LET g_rtib_d[l_ac].rtib012 = ''
         END IF 
      END IF 
      IF INFIELD(rtib012) THEN 
         #IF l_xmdc007 - l_rtib012 < g_rtib_d[l_ac].rtib012 THEN      #150424-00020#2--mark by dongsz
         IF l_rtim012 - l_rtib012 < g_rtib_d[l_ac].rtib012 THEN       #150424-00020#2--add by dongsz  
            LET g_errno = 'art-00303'
            RETURN 
         END IF 
      END IF 
   END IF   #add by yangxf 
   #add by yangxf start------添加销退数量控管
   IF g_prog = 'artt610' OR g_prog = 'artt620' THEN 
      SELECT rtib012 INTO l_rtib012_t
        FROM rtib_t
       WHERE rtibent = g_enterprise
         AND rtibdocno = g_rtib_d[l_ac].rtib001
         AND rtibseq = g_rtib_d[l_ac].rtib002
      IF cl_null(l_rtib012) THEN 
         LET l_rtib012 = 0
      END IF
      #抓取出货单已有数量
      IF p_cmd = 'a' THEN 
         SELECT SUM(rtib012) INTO l_rtib012
           FROM rtib_t,rtia_t
          WHERE rtib001 = g_rtib_d[l_ac].rtib001
            AND rtib002 = g_rtib_d[l_ac].rtib002
            AND rtiaent = rtibent
            AND rtiadocno = rtibdocno
            AND rtiaent = g_enterprise
            AND rtiastus <> 'X'
         IF cl_null(l_rtib012) THEN 
            LET l_rtib012 = 0
         END IF 
      ELSE
         SELECT SUM(rtib012) INTO l_rtib012
           FROM rtib_t a,rtia_t
          WHERE rtib001 = g_rtib_d[l_ac].rtib001
            AND rtib002 = g_rtib_d[l_ac].rtib002
            AND rtiaent = rtibent
            AND rtiadocno = rtibdocno
            AND rtiaent = g_enterprise
            AND rtiastus <> 'X'
            AND NOT EXISTS (SELECT 1 FROM rtib_t b
                             WHERE b.rtibseq = g_rtib_d_t.rtibseq 
                               AND b.rtibdocno = g_rtia_m.rtiadocno
                               AND b.rtibent = g_enterprise
                               AND a.rtibent = b.rtibent
                               AND a.rtibdocno = b.rtibdocno
                               AND a.rtibseq = b.rtibseq)
         IF cl_null(l_rtib012) THEN
            LET l_rtib012 = 0
         END IF 
      END IF 
      #光标在订单或是项次中带出数量
      IF INFIELD(rtib001) OR INFIELD(rtib002) THEN 
         IF p_cmd = 'a' THEN 
            LET g_rtib_d[l_ac].rtib012 = l_rtib012_t + l_rtib012 
            IF g_rtib_d[l_ac].rtib012 <=0 THEN 
               LET g_rtib_d[l_ac].rtib012 = ''
            ELSE
               LET g_rtib_d[l_ac].rtib012 = g_rtib_d[l_ac].rtib012*(-1)
            END IF 
         ELSE
            IF NOT cl_null(g_rtib_d[l_ac].rtib012) THEN 
               IF g_rtib_d[l_ac].rtib012*(-1) > l_rtib012_t + l_rtib012 THEN 
                  LET g_rtib_d[l_ac].rtib012 = (l_rtib012_t + l_rtib012)*(-1) 
               END IF 
            ELSE
               LET g_rtib_d[l_ac].rtib012 = (l_rtib012_t + l_rtib012)*(-1)
            END IF 
         END IF 
         IF g_rtib_d[l_ac].rtib012 >=0 THEN 
            LET g_rtib_d[l_ac].rtib012 = ''
         END IF 
      END IF 
      IF INFIELD(rtib012) THEN 
         IF l_rtib012_t + l_rtib012 < g_rtib_d[l_ac].rtib012*(-1) THEN      
            LET g_errno = 'art-00589'
            RETURN 
         END IF 
      END IF    
   END IF 
   IF g_prog = 'artt700' THEN  
      SELECT rtib012 INTO l_rtib012_t
        FROM rtib_t
       WHERE rtibent = g_enterprise
         AND rtibdocno = g_rtib_d[l_ac].rtib001
         AND rtibseq = g_rtib_d[l_ac].rtib002
      IF cl_null(l_rtib012) THEN 
         LET l_rtib012 = 0
      END IF
      #抓取出货单已有数量
      IF p_cmd = 'a' THEN 
         SELECT SUM(rtib012) INTO l_rtib012
           FROM rtib_t,rtia_t
          WHERE rtib001 = g_rtib_d[l_ac].rtib001
            AND rtib002 = g_rtib_d[l_ac].rtib002
            AND rtiaent = rtibent
            AND rtiadocno = rtibdocno
            AND rtiaent = g_enterprise
            AND rtiastus <> 'X'
         IF cl_null(l_rtib012) THEN 
            LET l_rtib012 = 0
         END IF 
      ELSE
         SELECT SUM(rtib012) INTO l_rtib012
           FROM rtib_t a,rtia_t
          WHERE rtib001 = g_rtib_d[l_ac].rtib001
            AND rtib002 = g_rtib_d[l_ac].rtib002
            AND rtiaent = rtibent
            AND rtiadocno = rtibdocno
            AND rtiaent = g_enterprise
            AND rtiastus <> 'X'
            AND NOT EXISTS (SELECT 1 FROM rtib_t b
                             WHERE b.rtibseq = g_rtib_d_t.rtibseq 
                               AND b.rtibdocno = g_rtia_m.rtiadocno
                               AND b.rtibent = g_enterprise
                               AND a.rtibent = b.rtibent
                               AND a.rtibdocno = b.rtibdocno
                               AND a.rtibseq = b.rtibseq)
         IF cl_null(l_rtib012) THEN
            LET l_rtib012 = 0
         END IF 
      END IF 
      #光标在订单或是项次中带出数量
      IF INFIELD(rtib001) OR INFIELD(rtib002) THEN 
         IF p_cmd = 'a' THEN 
            LET g_rtib_d[l_ac].rtib012 = l_rtib012_t + l_rtib012 
            IF g_rtib_d[l_ac].rtib012 <=0 THEN 
               LET g_rtib_d[l_ac].rtib012 = ''
            END IF 
         ELSE
            IF NOT cl_null(g_rtib_d[l_ac].rtib012) THEN 
               IF g_rtib_d[l_ac].rtib012 > l_rtib012_t + l_rtib012 THEN 
                  LET g_rtib_d[l_ac].rtib012 = l_rtib012_t + l_rtib012
               END IF 
            ELSE
               LET g_rtib_d[l_ac].rtib012 = l_rtib012_t + l_rtib012
            END IF 
         END IF 
         IF g_rtib_d[l_ac].rtib012 <=0 THEN 
            LET g_rtib_d[l_ac].rtib012 = ''
         END IF 
      END IF 
      IF INFIELD(rtib012) THEN 
         IF l_rtib012_t + l_rtib012 < g_rtib_d[l_ac].rtib012 THEN      
            LET g_errno = 'art-00589'
            RETURN 
         END IF 
      END IF 
   END IF 
   #add by yangxf end -------
END FUNCTION
################################################################################
# Descriptions...: 专柜检查
# Memo...........:
# Usage..........: 无
# Input parameter: 无
# Return code....: 无
# Date & Author..: 2014/03/21 By yangxf
# Modify.........:
################################################################################
PRIVATE FUNCTION artt622_rtib028_chk()
   DEFINE l_inaastus LIKE inaa_t.inaastus
   
   LET g_errno = ''
   SELECT inaastus INTO l_inaastus
     FROM inaa_t
    WHERE inaaent = g_enterprise
      AND inaasite = g_rtia_m.rtiasite
      AND inaa001 = g_rtib_d[l_ac].rtib025
      AND inaa120 = g_rtib_d[l_ac].rtib028
   CASE 
      WHEN SQLCA.SQLCODE = 100 LET g_errno = 'art-00304'
      WHEN l_inaastus <> 'Y'   LET g_errno = 'art-00305'
      OTHERWISE                LET g_errno = SQLCA.SQLCODE USING '-------'
   END CASE
   
END FUNCTION

################################################################################
# Descriptions...: 依订单产生单身资料
# Memo...........:
# Usage..........: 
# Input parameter: 无
# Return code....: 无
# Date & Author..: 2014/04/01 By yangxf
# Modify.........: 2015/05/05 By dongsz #150424-00020#2
################################################################################
PRIVATE FUNCTION artt622_ins_rtib()
   #DEFINE l_rtib    RECORD LIKE rtib_t.*   #160517-00004#1 160517 by sakura mark
   #160517-00004#1 160517 by sakura add(S)
   DEFINE l_rtib RECORD  #銷售交易商品明細檔
          rtibent LIKE rtib_t.rtibent, #企業編號
          rtibsite LIKE rtib_t.rtibsite, #營運據點
          rtibunit LIKE rtib_t.rtibunit, #應用組織
          rtiborga LIKE rtib_t.rtiborga, #帳務組織
          rtibdocno LIKE rtib_t.rtibdocno, #單據編號
          rtibseq LIKE rtib_t.rtibseq, #項次
          rtib001 LIKE rtib_t.rtib001, #來源單號
          rtib002 LIKE rtib_t.rtib002, #來源單號項次
          rtib003 LIKE rtib_t.rtib003, #商品條碼
          rtib004 LIKE rtib_t.rtib004, #商品編號
          rtib005 LIKE rtib_t.rtib005, #特徵碼
          rtib006 LIKE rtib_t.rtib006, #稅別編號
          rtib007 LIKE rtib_t.rtib007, #銷售開立發票
          rtib008 LIKE rtib_t.rtib008, #標準售價
          rtib009 LIKE rtib_t.rtib009, #促銷售價
          rtib010 LIKE rtib_t.rtib010, #交易售價
          rtib011 LIKE rtib_t.rtib011, #成本售價
          rtib012 LIKE rtib_t.rtib012, #銷售數量
          rtib013 LIKE rtib_t.rtib013, #銷售單位
          rtib014 LIKE rtib_t.rtib014, #庫存數量
          rtib015 LIKE rtib_t.rtib015, #庫存單位
          rtib016 LIKE rtib_t.rtib016, #銷售庫存單位換算率
          rtib017 LIKE rtib_t.rtib017, #計價數量
          rtib018 LIKE rtib_t.rtib018, #計價單位
          rtib019 LIKE rtib_t.rtib019, #銷售計價單位換算率
          rtib020 LIKE rtib_t.rtib020, #折價金額
          rtib021 LIKE rtib_t.rtib021, #應收金額
          rtib022 LIKE rtib_t.rtib022, #未稅金額
          rtib023 LIKE rtib_t.rtib023, #成本金額
          rtib024 LIKE rtib_t.rtib024, #理由碼
          rtib025 LIKE rtib_t.rtib025, #庫區
          rtib026 LIKE rtib_t.rtib026, #儲位
          rtib027 LIKE rtib_t.rtib027, #批號
          rtib028 LIKE rtib_t.rtib028, #專櫃編號
          rtib029 LIKE rtib_t.rtib029, #分攤積點
          rtib030 LIKE rtib_t.rtib030, #卡券銷售明細對應項次
          rtib031 LIKE rtib_t.rtib031, #本幣應收金額
          rtib032 LIKE rtib_t.rtib032, #庫存管理特徵
          rtib033 LIKE rtib_t.rtib033, #營業員
          rtib034 LIKE rtib_t.rtib034, #掃描碼
          rtib035 LIKE rtib_t.rtib035, #交易類型
          rtib036 LIKE rtib_t.rtib036, #商品屬性
          rtib037 LIKE rtib_t.rtib037, #捆綁條碼項次
          rtib038 LIKE rtib_t.rtib038, #結算扣率
          rtib039 LIKE rtib_t.rtib039, #贈品否
          rtib040 LIKE rtib_t.rtib040, #卡種/券種編號
          rtib041 LIKE rtib_t.rtib041, #卡號/券號
          rtib101 LIKE rtib_t.rtib101, #退貨退回商品
          rtib102 LIKE rtib_t.rtib102, #產品品類
          rtib103 LIKE rtib_t.rtib103, #品牌
          rtib104 LIKE rtib_t.rtib104, #商戶編號(租賃)
          rtib105 LIKE rtib_t.rtib105  #合約編號(租賃)
   END RECORD   
   #160517-00004#1 160517 by sakura add(E)   
   DEFINE l_n       LIKE type_t.num5
   DEFINE l_rtib012 LIKE rtib_t.rtib012
   #DEFINE l_xmdc007 LIKE xmdc_t.xmdc007         #150424-00020#2--mark by dongsz
   #150424-00020#2--add by dongsz--str---
   DEFINE l_rtim012 LIKE rtim_t.rtim012          
   DEFINE l_xrcd103   LIKE xrcd_t.xrcd103,
          l_xrcd104   LIKE xrcd_t.xrcd104,
          l_xrcd105   LIKE xrcd_t.xrcd105,
          l_xrcd113   LIKE xrcd_t.xrcd113,
          l_xrcd114   LIKE xrcd_t.xrcd114,
          l_xrcd115   LIKE xrcd_t.xrcd115,
          l_imaa005   LIKE imaa_t.imaa005,
          l_xrcd123   LIKE xrcd_t.xrcd113,
          l_xrcd124   LIKE xrcd_t.xrcd114,
          l_xrcd125   LIKE xrcd_t.xrcd115,
          l_xrcd133   LIKE xrcd_t.xrcd113,
          l_xrcd134   LIKE xrcd_t.xrcd114,
          l_xrcd135   LIKE xrcd_t.xrcd115
   #150424-00020#2--add by dongsz--end---
   DEFINE l_success   LIKE type_t.num5      #add by yangxf
   DEFINE l_rtic013   LIKE rtic_t.rtic013   #add by yangxf
   
   INITIALIZE l_rtib.* TO NULL
   LET l_rtib.rtibent = g_enterprise
   LET l_rtib.rtibsite = g_rtia_m.rtiasite
   LET l_rtib.rtibunit = g_rtia_m.rtiasite
   LET l_rtib.rtiborga = g_rtia_m.rtiasite
   LET l_rtib.rtibdocno = g_rtia_m.rtiadocno
   LET l_rtib.rtib001 = g_rtia_m.rtia007
   LET l_rtib.rtib035 = '1'
   LET l_n = 1
   #150424-00020#2--mark by dongsz--str---
#   DECLARE xmdc_curs CURSOR FOR SELECT xmdcseq,xmdc001,xmdc006,xmdc016
#                                  FROM xmdc_t 
#                                 WHERE xmdcdocno = g_rtia_m.rtia007
#                                   AND xmdcent = g_enterprise
#   FOREACH xmdc_curs INTO l_rtib.rtib002,l_rtib.rtib004,l_rtib.rtib013,l_rtib.rtib006
   #150424-00020#2--mark by dongsz--end---
   #150424-00020#2--add by dongsz--str---
   DECLARE rtim_curs CURSOR FOR SELECT rtimseq,rtim003,rtim004,rtim005,rtim006,
                                       rtim008,rtim009,rtim010,rtim011,rtim013,
                                       rtim014,rtim015,rtim016,rtim018,rtim019,
                                       rtim025,rtim026,rtim027,rtim028
                                  FROM rtim_t 
                                 WHERE rtimdocno = g_rtia_m.rtia007
                                   AND rtiment = g_enterprise
   FOREACH rtim_curs INTO l_rtib.rtib002,l_rtib.rtib003,l_rtib.rtib004,l_rtib.rtib005,l_rtib.rtib006,
                          l_rtib.rtib008,l_rtib.rtib009,l_rtib.rtib010,l_rtib.rtib011,l_rtib.rtib013,
                          l_rtib.rtib014,l_rtib.rtib015,l_rtib.rtib016,l_rtib.rtib018,l_rtib.rtib019,
                          l_rtib.rtib025,l_rtib.rtib026,l_rtib.rtib027,l_rtib.rtib028
   #150424-00020#2--add by dongsz--end---
      IF SQLCA.sqlcode THEN
          INITIALIZE g_errparam TO NULL
          LET g_errparam.code = SQLCA.sqlcode
          #LET g_errparam.extend = 'foreach:xmdc_curs'   #150424-00020#2--mark by dongsz
          LET g_errparam.extend = 'foreach:rtim_curs'    #150424-00020#2--add by dongsz
          LET g_errparam.popup = TRUE
          CALL cl_err()

          EXIT FOREACH
      END IF
      #抓取订单数量
      #150424-00020#2--mark by dongsz--str---
#      SELECT xmdc007 INTO l_xmdc007
#        FROM xmdc_t
#       WHERE xmdcent = g_enterprise
#         AND xmdcdocno = l_rtib.rtib001
#         AND xmdcseq = l_rtib.rtib002
#      IF cl_null(l_xmdc007) THEN 
#         LET l_xmdc007 = 0
#      END IF
      #150424-00020#2--mark by dongsz--end---
      #150424-00020#2--add by dongsz--str---
      SELECT rtim012 INTO l_rtim012
        FROM rtim_t
       WHERE rtiment = g_enterprise
         AND rtimdocno = l_rtib.rtib001
         AND rtimseq = l_rtib.rtib002
      IF cl_null(l_rtim012) THEN 
         LET l_rtim012 = 0
      END IF
      #150424-00020#2--add by dongsz--end---
      #抓取出货单已有数量
      SELECT SUM(rtib012) INTO l_rtib012
        FROM rtib_t,rtia_t
       WHERE rtib001 = l_rtib.rtib001
         AND rtib002 = l_rtib.rtib002
         AND rtiaent = rtibent
         AND rtiadocno = rtibdocno
         AND rtiaent = g_enterprise
         AND rtiastus <> 'X'
      IF cl_null(l_rtib012) THEN 
         LET l_rtib012 = 0
      END IF 
      #LET l_rtib.rtib012 = l_xmdc007 - l_rtib012    #150424-00020#2--mark by dongsz
      LET l_rtib.rtib012 = l_rtim012 - l_rtib012     #150424-00020#2--add by dongsz
      IF l_rtib.rtib012 <=0 THEN 
         CONTINUE FOREACH        #add by yangxf 
         LET l_rtib.rtib012 = 0
      END IF 
      #150424-00020#2--add by dongsz--str---
      #计价数量
      CALL s_aooi250_convert_qty(l_rtib.rtib004,l_rtib.rtib013,l_rtib.rtib018,l_rtib.rtib012)
           RETURNING l_success,l_rtib.rtib017
      #庫存數量
      CALL s_aooi250_convert_qty(l_rtib.rtib004,l_rtib.rtib013,l_rtib.rtib015,l_rtib.rtib012)
           RETURNING l_success,l_rtib.rtib014
      #应收金额 = 交易价*计价数量
      LET l_rtib.rtib021 = l_rtib.rtib010 * l_rtib.rtib017
      LET l_rtib.rtib021 = s_curr_round(g_rtia_m.rtiasite,g_rtia_m.rtia026,l_rtib.rtib021,'2')
      #计算本币应收金额
      LET l_rtib.rtib031 = l_rtib.rtib021 * g_rtia_m.rtia027
      #150424-00020#2--add by dongsz--end---
      LET l_rtib.rtibseq = l_n
      #收银机不为空预设库区，储位，批号
#mark by yangxf ---
#      IF NOT cl_null(g_rtia_m.rtia036) THEN 
#         SELECT inag004,inag005,inag006
#           INTO l_rtib.rtib025,l_rtib.rtib026,l_rtib.rtib027
#           FROM pcao_t,inag_t
#          WHERE pcaoent = g_enterprise
#            AND pcaosite = g_rtia_m.rtiasite
#            AND pcao001 = g_rtia_m.rtia036
#            AND pcaoent = inagent
#            AND inagsite = pcaosite
#            AND inag001 = l_rtib.rtib004
#          ORDER BY inag004
#      ELSE
#         SELECT inag004,inag005,inag006
#           INTO l_rtib.rtib025,l_rtib.rtib026,l_rtib.rtib027
#           FROM inag_t
#          WHERE inagent = g_enterprise
#            AND inagsite = g_rtia_m.rtiasite
#            AND inag001 = l_rtib.rtib004
#          ORDER BY inag004
#      END IF 
#mark by yangxf ----
#add by yangxf ---start---预设商品清单中的库区
      SELECT rtdx044 INTO l_rtib.rtib025
        FROM rtdx_t 
       WHERE rtdxent = g_enterprise
         AND rtdxsite = g_rtia_m.rtiasite
         AND rtdx001 = l_rtib.rtib004
      SELECT inag005,inag006
        INTO l_rtib.rtib026,l_rtib.rtib027
        FROM inag_t
       WHERE inagent = g_enterprise
         AND inagsite = g_rtia_m.rtiasite
         AND inag004 = l_rtib.rtib025
         AND inag001 = l_rtib.rtib004
#add by yangxf ----end----
      #INSERT INTO rtib_t VALUES(l_rtib.*)  #160517-00004#1 160517 by sakura mark
      #160517-00004#1 160517 by sakura add(S)
      INSERT INTO rtib_t (rtibent,rtibsite,rtibunit,rtiborga,rtibdocno,
                          rtibseq,rtib001 ,rtib002 ,rtib003 ,rtib004,
                          rtib005,rtib006 ,rtib007 ,rtib008 ,rtib009,
                          rtib010,rtib011 ,rtib012 ,rtib013 ,rtib014,
                          rtib015,rtib016 ,rtib017 ,rtib018 ,rtib019,
                          rtib020,rtib021 ,rtib022 ,rtib023 ,rtib024,
                          rtib025,rtib026 ,rtib027 ,rtib028 ,rtib029,
                          rtib030,rtib031 ,rtib032 ,rtib033 ,rtib034,
                          rtib035,rtib036 ,rtib037 ,rtib038 ,rtib039,
                          rtib040,rtib041 ,rtib101 ,rtib102 ,rtib103,
                          rtib104,rtib105)
      VALUES (l_rtib.rtibent,l_rtib.rtibsite,l_rtib.rtibunit,l_rtib.rtiborga,l_rtib.rtibdocno,
              l_rtib.rtibseq,l_rtib.rtib001 ,l_rtib.rtib002 ,l_rtib.rtib003 ,l_rtib.rtib004,
              l_rtib.rtib005,l_rtib.rtib006 ,l_rtib.rtib007 ,l_rtib.rtib008 ,l_rtib.rtib009,
              l_rtib.rtib010,l_rtib.rtib011 ,l_rtib.rtib012 ,l_rtib.rtib013 ,l_rtib.rtib014,
              l_rtib.rtib015,l_rtib.rtib016 ,l_rtib.rtib017 ,l_rtib.rtib018 ,l_rtib.rtib019,
              l_rtib.rtib020,l_rtib.rtib021 ,l_rtib.rtib022 ,l_rtib.rtib023 ,l_rtib.rtib024,
              l_rtib.rtib025,l_rtib.rtib026 ,l_rtib.rtib027 ,l_rtib.rtib028 ,l_rtib.rtib029,
              l_rtib.rtib030,l_rtib.rtib031 ,l_rtib.rtib032 ,l_rtib.rtib033 ,l_rtib.rtib034,
              l_rtib.rtib035,l_rtib.rtib036 ,l_rtib.rtib037 ,l_rtib.rtib038 ,l_rtib.rtib039,
              l_rtib.rtib040,l_rtib.rtib041 ,l_rtib.rtib101 ,l_rtib.rtib102 ,l_rtib.rtib103,
              l_rtib.rtib104,l_rtib.rtib105)
      #160517-00004#1 160517 by sakura add(E)
      IF SQLCA.sqlcode THEN
          INITIALIZE g_errparam TO NULL
          LET g_errparam.code = SQLCA.sqlcode
          LET g_errparam.extend = 'ins rtib_t'
          LET g_errparam.popup = TRUE
          CALL cl_err()

          RETURN
      END IF
#add by yangxf ---start----

      CALL s_artt622_rtin_modify('a',g_rtia_m.rtiasite,g_rtia_m.rtiadocno,l_rtib.rtibseq,'',l_rtib.rtib004,l_rtib.rtib005,
                                 g_prog,'',l_rtib.rtib025,l_rtib.rtib026,l_rtib.rtib027,l_rtib.rtib013,l_rtib.rtib012,l_rtib.rtib032) RETURNING l_success
      IF NOT l_success THEN            
         RETURN
      END IF
      #写入折扣明细
      CALL artt622_ins_rtic(l_rtib.rtibseq,l_rtib.rtib001,l_rtib.rtib002,l_rtib.rtib017) RETURNING l_success,l_rtic013
      IF NOT l_success THEN            
         RETURN
      END IF
      UPDATE rtib_t SET rtib020 = l_rtic013
       WHERE rtibent = g_enterprise
         AND rtibdocno = g_rtia_m.rtiadocno
         AND rtibseq = l_rtib.rtibseq
      CASE
         WHEN SQLCA.sqlcode #其他錯誤
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = SQLCA.sqlcode
            LET g_errparam.extend = "upd rtib_t"
            LET g_errparam.popup = TRUE
            CALL cl_err()
            RETURN
      END CASE
#add by yangxf ---end------
      #150424-00020#2--add by dongsz--str---
                     #單號      項次       項次2   營運據點           應收金額
      CALL s_tax_ins(g_rtia_m.rtiadocno,l_rtib.rtibseq,'0',g_rtia_m.rtiasite,l_rtib.rtib021,
                     #稅別                          數量                           幣別             匯率             帳套  匯率2 匯率3
                     l_rtib.rtib006,l_rtib.rtib017,g_rtia_m.rtia026,g_rtia_m.rtia027,' ',' ',  ' ')
                #原幣未稅金額 原幣稅額   原幣含稅金額 本幣未稅金額(AR/AP使用) 本幣稅額(AR/AP使用) 本幣含稅金額(AR/AP使用)
      RETURNING l_xrcd103,    l_xrcd104, l_xrcd105,   l_xrcd113,              l_xrcd114,          l_xrcd115,
                l_xrcd123,l_xrcd124,l_xrcd125,l_xrcd133,l_xrcd134,l_xrcd135

      UPDATE rtib_t SET rtib022 = l_xrcd103
       WHERE rtibent = g_enterprise
         AND rtibdocno = g_rtia_m.rtiadocno
         AND rtibseq = l_rtib.rtibseq
      CASE
         WHEN SQLCA.sqlcode #其他錯誤
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = SQLCA.sqlcode
            LET g_errparam.extend = "upd rtib_t"
            LET g_errparam.popup = TRUE
            CALL cl_err()
  
            RETURN
         
      END CASE
      #150424-00020#2--add by dongsz--end---
      LET l_n = l_n + 1
   END FOREACH
   #150424-00020#2--add by dongsz--str---
   #更新单头本币应收金额
   #更新单头含税金额
   UPDATE rtia_t SET rtia031 = (SELECT SUM(rtib021)
                                  FROM rtib_t
                                 WHERE rtibent = g_enterprise
                                   AND rtibdocno = g_rtia_m.rtiadocno),
                     rtia049 = (SELECT SUM(rtib031)
                                  FROM rtib_t
                                 WHERE rtibent = g_enterprise
                                   AND rtibdocno = g_rtia_m.rtiadocno)              
    WHERE rtiaent = g_enterprise
      AND rtiadocno = g_rtia_m.rtiadocno  
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = "upd rtia_t"
      LET g_errparam.popup = FALSE
      CALL cl_err()

      RETURN
   END IF     
   #150424-00020#2--add by dongsz--end---
   CALL artt622_b_fill()
END FUNCTION

################################################################################
# Descriptions...: 刷新单身
# Memo...........:
# Usage..........: CALL artt622_refresh()
# Input parameter: 无
# Return code....: 无
# Date & Author..: 2014、12、30 By yangxf
# Modify.........:
################################################################################
PRIVATE FUNCTION artt622_refresh()

    CALL artt622_b_fill()
    DISPLAY ARRAY g_rtib3_d TO s_detail3.* ATTRIBUTES(COUNT=g_rec_b)  
       BEFORE DISPLAY
          EXIT DISPLAY 
    
    END DISPLAY
    DISPLAY ARRAY g_rtib4_d TO s_detail4.* ATTRIBUTES(COUNT=g_rec_b)  
    
       BEFORE DISPLAY
          EXIT DISPLAY 
    
    END DISPLAY
END FUNCTION

################################################################################
# Descriptions...: 訂單帶值
# Memo...........:
# Usage..........: CALL artt622_rtia007_ref()
# Date & Author..: 20150505 By dongsz #150424-00020#2
# Modify.........:
################################################################################
PRIVATE FUNCTION artt622_rtia007_ref()
DEFINE l_rtif031_sum    LIKE rtif_t.rtif031
DEFINE l_rtia051_sum    LIKE rtia_t.rtia051

   #add by yangxf ---start----
   #IF g_prog = 'artt610' OR g_prog = 'artt700' OR g_prog = 'artt800' OR g_prog = 'artt620' THEN    #160604-00009#85 dongsz mark
   IF g_prog = 'artt610' OR g_prog = 'artt700' OR g_prog = 'artt800' OR g_prog = 'artt620' OR g_prog = 'artt622' THEN     #160604-00009#85 dongsz add
      SELECT rtia001,rtia002,
             rtia009,rtia041,rtia013,rtia014,rtia015,rtia016,
             rtia010,rtia011,rtia012,rtia017,rtia018,rtia019,
             rtia020,rtia021,rtia022,rtia023,rtia024,rtia025,
             rtia026,rtia027,rtia028,rtia029,rtia030,rtia039
        INTO g_rtia_m.rtia001,g_rtia_m.rtia002,
             g_rtia_m.rtia009,g_rtia_m.rtia041,g_rtia_m.rtia013,g_rtia_m.rtia014,g_rtia_m.rtia015,g_rtia_m.rtia016,
             g_rtia_m.rtia010,g_rtia_m.rtia011,g_rtia_m.rtia012,g_rtia_m.rtia017,g_rtia_m.rtia018,g_rtia_m.rtia019,
             g_rtia_m.rtia020,g_rtia_m.rtia021,g_rtia_m.rtia022,g_rtia_m.rtia023,g_rtia_m.rtia024,g_rtia_m.rtia025,
             g_rtia_m.rtia026,g_rtia_m.rtia027,g_rtia_m.rtia028,g_rtia_m.rtia029,g_rtia_m.rtia030,g_rtia_m.rtia039
        FROM rtia_t
       WHERE rtiaent = g_enterprise
         AND rtiadocno = g_rtia_m.rtia007
      #160604-00009#85--dongsz add--s
      SELECT mmaq018 INTO g_rtia_m.rtia043
        FROM mmaq_t
       WHERE mmaq001 = g_rtia_m.rtia001
         AND mmaqent = g_enterprise  
      LET g_rtia_m.l_rtia047 = g_rtia_m.rtia043 - g_rtia_m.rtia047
      DISPLAY BY NAME g_rtia_m.rtia043,g_rtia_m.rtia047,g_rtia_m.l_rtia047
      #160604-00009#85--dongsz add--e
   ELSE
   #add by yangxf ---end----
      SELECT rtil001,rtil002,
             rtil006,rtil038,rtil010,rtil011,rtil012,rtil013,
             rtil007,rtil008,rtil009,rtil014,rtil015,rtil016,
             rtil017,rtil018,rtil019,rtil020,rtil021,rtil022,
             rtil023,rtil024,rtil025,rtil026,rtil027,rtil036
        INTO g_rtia_m.rtia001,g_rtia_m.rtia002,
             g_rtia_m.rtia009,g_rtia_m.rtia041,g_rtia_m.rtia013,g_rtia_m.rtia014,g_rtia_m.rtia015,g_rtia_m.rtia016,
             g_rtia_m.rtia010,g_rtia_m.rtia011,g_rtia_m.rtia012,g_rtia_m.rtia017,g_rtia_m.rtia018,g_rtia_m.rtia019,
             g_rtia_m.rtia020,g_rtia_m.rtia021,g_rtia_m.rtia022,g_rtia_m.rtia023,g_rtia_m.rtia024,g_rtia_m.rtia025,
             g_rtia_m.rtia026,g_rtia_m.rtia027,g_rtia_m.rtia028,g_rtia_m.rtia029,g_rtia_m.rtia030,g_rtia_m.rtia039
        FROM rtil_t
       WHERE rtilent = g_enterprise
         AND rtildocno = g_rtia_m.rtia007
   END IF    #add by yangxf 
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_rtia_m.rtia009
   CALL ap_ref_array2(g_ref_fields,"SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001='295' AND oocql002=? AND oocql003='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_rtia_m.rtia009_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_rtia_m.rtia009_desc
   
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_rtia_m.rtia010
   CALL ap_ref_array2(g_ref_fields,"SELECT pmaal004 FROM pmaal_t WHERE pmaalent='"||g_enterprise||"' AND pmaal001=? AND pmaal002='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_rtia_m.rtia010_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_rtia_m.rtia010_desc
   
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_rtia_m.rtia011
   CALL ap_ref_array2(g_ref_fields,"SELECT pmaal004 FROM pmaal_t WHERE pmaalent='"||g_enterprise||"' AND pmaal001=? AND pmaal002='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_rtia_m.rtia011_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_rtia_m.rtia011_desc
   
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_rtia_m.rtia012
   CALL ap_ref_array2(g_ref_fields,"SELECT pmaal004 FROM pmaal_t WHERE pmaalent='"||g_enterprise||"' AND pmaal001=? AND pmaal002='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_rtia_m.rtia012_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_rtia_m.rtia012_desc
   
   CALL s_desc_get_department_desc(g_rtia_m.rtia018) RETURNING g_rtia_m.rtia018_desc
   DISPLAY BY NAME g_rtia_m.rtia018,g_rtia_m.rtia018_desc
   
   CALL s_desc_get_department_desc(g_rtia_m.rtia024) RETURNING g_rtia_m.rtia024_desc
   DISPLAY BY NAME g_rtia_m.rtia024,g_rtia_m.rtia024_desc
   
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_rtia_m.rtia025
   CALL ap_ref_array2(g_ref_fields,"SELECT ooibl004 FROM ooibl_t WHERE ooiblent='"||g_enterprise||"' AND ooibl002=? AND ooibl003='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_rtia_m.rtia025_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_rtia_m.rtia025_desc
   
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_rtia_m.rtia036
   CALL ap_ref_array2(g_ref_fields,"SELECT pcaal003 FROM pcaal_t WHERE pcaalent='"||g_enterprise||"' AND pcaalsite = '"||g_rtia_m.rtiasite||"' AND pcaal001=? AND pcaal002='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_rtia_m.rtia036_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_rtia_m.rtia036_desc
   
   SELECT pcab003 INTO g_rtia_m.rtia037_desc
     FROM pcab_t
    WHERE pcabent = g_enterprise
      AND pcab001 = g_rtia_m.rtia037
      
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_rtia_m.rtia038
   LET g_ref_fields[2] = g_rtia_m.rtiasite
   CALL ap_ref_array2(g_ref_fields,"SELECT oogd002 FROM oogd_t WHERE oogdent='"||g_enterprise||"' AND oogd001=? AND oogdsite=? ","") RETURNING g_rtn_fields
   LET g_rtia_m.rtia038_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_rtia_m.rtia038_desc
   IF g_prog = 'artt800' THEN 
      
      #带出总赊销金额
      SELECT SUM(rtif031) INTO l_rtif031_sum
        FROM rtif_t
       WHERE rtifent = g_enterprise
         AND rtif001 = '91'
         AND rtifdocno = g_rtia_m.rtia007
      IF cl_null(l_rtif031_sum) THEN 
         LET l_rtif031_sum = 0
      END IF 
      #已回款金额
      SELECT SUM(rtia051) INTO l_rtia051_sum
        FROM rtia_t
       WHERE rtiaent = g_enterprise
         AND rtia007 = g_rtia_m.rtia007
         AND rtia000 = 'artt800'
         AND rtiastus <> 'X'
      IF cl_null(l_rtia051_sum) THEN 
         LET l_rtia051_sum = 0
      END IF 
      LET g_rtia_m.rtia051 = l_rtif031_sum - l_rtia051_sum
      DISPLAY BY NAME g_rtia_m.rtia051
   END IF 
END FUNCTION

################################################################################
# Descriptions...: 收银员栏位是否必录
# Memo...........:
# Usage..........: CALL artt622_set_required()
# Input parameter: 无
# Return code....: 无
# Date & Author..: 2015/05/11 By yangxf
# Modify.........:
################################################################################
PRIVATE FUNCTION artt622_set_required()
   DEFINE l_ooib007   LIKE ooib_t.ooib007
   
   #抓取现金交易否
   SELECT ooib007 INTO l_ooib007
     FROM ooib_t
    WHERE ooibent = g_enterprise
      AND ooib002 = g_rtia_m.rtia025
   IF l_ooib007 ='Y' THEN 
      CALL cl_set_comp_required("rtia037",TRUE) 
   ELSE
      CALL cl_set_comp_required("rtia037",FALSE) 
   END IF 
END FUNCTION

################################################################################
# Descriptions...: 营业员检查
# Memo...........:
# Usage..........: CALL artt622_rtib033_chk()
# Input parameter: 无
# Return code....: 无
# Date & Author..: 2015/05/12 By yangxf
# Modify.........:
################################################################################
PRIVATE FUNCTION artt622_rtib033_chk()
   DEFINE l_pcabstus   LIKE pcab_t.pcabstus
   DEFINE l_pcab006    LIKE pcab_t.pcab006
   DEFINE l_n          LIKE type_t.num5
   
   LET g_errno = ''
   #判断收银员是否存OR有效OR职能='营业员'
   SELECT pcabstus,pcab006
     INTO l_pcabstus,l_pcab006
     FROM pcab_t
    WHERE pcabent = g_enterprise
      AND pcab001 = g_rtib_d[l_ac].rtib033 
      CASE 
         WHEN SQLCA.SQLCODE = 100 LET g_errno = 'ade-00024'        #收银员不存在
         WHEN l_pcabstus <> 'Y'   LET g_errno = 'ade-00025'        #收银员无效
         WHEN l_pcab006 <> '2'    LET g_errno = 'art-00566'        #收银员职能不为2.营业员
         OTHERWISE                LET g_errno = SQLCA.SQLCODE USING '-------'
      END CASE
   IF NOT cl_null(g_errno) THEN 
      RETURN 
   END IF 
   LET l_n = 0
   #检查营业员是否在可用组织范围内
   SELECT COUNT(*) INTO l_n
     FROM pcac_t
    WHERE pcacent = g_enterprise
      AND pcacstus = 'Y' 
      AND pcac001 = g_rtib_d[l_ac].rtib033 
      AND pcac002 = g_rtia_m.rtiasite
   IF l_n = 0 THEN 
      #該收銀員無此營運組織的使用權限!
      LET g_errno = 'ade-00026'
   END IF 
END FUNCTION

################################################################################
# Descriptions...: 取价
# Memo...........:
# Usage..........: CALL artt622_get_price()
# Input parameter: 无
# Return code....: 无
# Date & Author..: 2015/05/14 By yangxf
# Modify.........:
################################################################################
PRIVATE FUNCTION artt622_get_price()
DEFINE l_success   LIKE type_t.num5
DEFINE l_price1    LIKE rtib_t.rtib008
DEFINE l_ooef016   LIKE ooef_t.ooef016   #add by yangxf
DEFINE l_imaa108   LIKE imaa_t.imaa108   #add by yangxf

   IF cl_null(g_rtib_d[l_ac].rtibseq) OR cl_null(g_rtib_d[l_ac].rtib003) OR cl_null(g_rtib_d[l_ac].rtib004)  OR cl_null(g_rtib_d[l_ac].rtib012) THEN
      RETURN
   END IF
   #add by yangxf ---start---
   #如果有来源单号就不取价
   IF NOT cl_null(g_rtib_d[l_ac].rtib001) THEN 
      RETURN 
   END IF 
   #add by yangxf ---end----
   CALL s_get_price('2',g_rtia_m.rtiadocno,g_rtia_m.rtiadocdt,g_rtib_d[l_ac].rtibseq,g_rtia_m.rtia002,g_rtia_m.rtia001,g_rtib_d[l_ac].rtib004,g_rtib_d[l_ac].rtib003,g_rtib_d[l_ac].rtib018,g_rtib_d[l_ac].rtib017,'1')
      RETURNING l_success,g_rtib_d[l_ac].rtib008,l_price1,g_rtib_d[l_ac].rtib009,g_rtib_d[l_ac].rtib010
   IF  g_prog = 'artt620' THEN
      SELECT imaa108 INTO l_imaa108 
        FROM imaa_t 
       WHERE imaaent = g_enterprise 
         AND imaa001 = g_rtib_d[l_ac].rtib004
      IF l_imaa108 = '3' THEN 
         SELECT prbh012 INTO g_rtib_d[l_ac].rtib008
           FROM prbh_t
          WHERE prbhent = g_enterprise
            AND prbh003 = g_rtib_d[l_ac].rtib004
         LET g_rtib_d[l_ac].rtib009 =  g_rtib_d[l_ac].rtib008
         LET g_rtib_d[l_ac].rtib010 =  g_rtib_d[l_ac].rtib008      
      END IF   
   END IF
   LET g_rtib_d[l_ac].rtib008 = 0
   LET g_rtib_d[l_ac].rtib009 = 0
   LET g_rtib_d[l_ac].rtib010 = 0  
   #add by yangxf  ---start----    #交易价不为空AND 计价数量不为空
   IF NOT cl_null(g_rtib_d[l_ac].rtib010) AND NOT cl_null(g_rtib_d[l_ac].rtib017) THEN     
      #应收金额 = 交易价*计价数量
      LET g_rtib_d[l_ac].rtib021 = g_rtib_d[l_ac].rtib010 * g_rtib_d[l_ac].rtib017
      LET g_rtib_d[l_ac].rtib021 = s_curr_round(g_rtia_m.rtiasite,g_rtia_m.rtia026,g_rtib_d[l_ac].rtib021,'2')
      #计算本币应收金额
      LET g_rtib_d[l_ac].rtib031 = g_rtib_d[l_ac].rtib021 * g_rtia_m.rtia027
      SELECT ooef016 INTO l_ooef016
        FROM ooef_t
       WHERE ooefent = g_enterprise
         AND ooef001 = g_rtia_m.rtiasite
      LET g_rtib_d[l_ac].rtib031 = s_curr_round(g_rtia_m.rtiasite,l_ooef016,g_rtib_d[l_ac].rtib031,'2')
   END IF  
   #add by yangxf  ----end----
END FUNCTION

################################################################################
# Descriptions...: 單身必填欄位設定
# Memo...........:
# Usage..........: CALL artt622_set_required_b()
# Date & Author..: 2015/05/29 By Lori   #150427-00001#8
# Modify.........:
################################################################################
PRIVATE FUNCTION artt622_set_required_b()
   DEFINE l_success         LIKE type_t.num5      
   DEFINE l_set_required    LIKE type_t.num5     

   IF g_aw = "s_detail1" THEN
      IF l_ac > 0 THEN
         IF NOT cl_null(g_rtib_d[l_ac].rtib004) THEN
            #批號
            LET l_success = ''     
            LET l_set_required = '' 
            
            CALL s_lot_out_required(g_rtib_d[l_ac].rtib004) RETURNING l_success,l_set_required
            IF l_success THEN
               CALL cl_set_comp_required("rtib027",l_set_required)
            END IF           
         END IF
      END IF
   END IF
END FUNCTION

################################################################################
# Descriptions...: 單身非必填欄位設定
# Memo...........:
# Usage..........: CALL artt622_set_no_required_b()
# Date & Author..: 2015/05/29 By Lori   #150427-00001#8
# Modify.........:
################################################################################
PRIVATE FUNCTION artt622_set_no_required_b()
   IF g_aw = "s_detail1" THEN
      #批號
      CALL cl_set_comp_required("rtib027",FALSE)
   END IF   
END FUNCTION

################################################################################
# Descriptions...: 新增单身明细
# Memo...........:
# Usage..........: CALL artt622_ins_rtib_1()
# Input parameter: 无
# Return code....: 无
# Date & Author..: 2015/06/02 By yangxf
# Modify.........:
################################################################################
PRIVATE FUNCTION artt622_ins_rtib_1()
   #DEFINE l_rtib    RECORD LIKE rtib_t.*   #160517-00004#1 160517 by sakura mark
   #160517-00004#1 160517 by sakura add(S)
   DEFINE l_rtib RECORD  #銷售交易商品明細檔
          rtibent LIKE rtib_t.rtibent, #企業編號
          rtibsite LIKE rtib_t.rtibsite, #營運據點
          rtibunit LIKE rtib_t.rtibunit, #應用組織
          rtiborga LIKE rtib_t.rtiborga, #帳務組織
          rtibdocno LIKE rtib_t.rtibdocno, #單據編號
          rtibseq LIKE rtib_t.rtibseq, #項次
          rtib001 LIKE rtib_t.rtib001, #來源單號
          rtib002 LIKE rtib_t.rtib002, #來源單號項次
          rtib003 LIKE rtib_t.rtib003, #商品條碼
          rtib004 LIKE rtib_t.rtib004, #商品編號
          rtib005 LIKE rtib_t.rtib005, #特徵碼
          rtib006 LIKE rtib_t.rtib006, #稅別編號
          rtib007 LIKE rtib_t.rtib007, #銷售開立發票
          rtib008 LIKE rtib_t.rtib008, #標準售價
          rtib009 LIKE rtib_t.rtib009, #促銷售價
          rtib010 LIKE rtib_t.rtib010, #交易售價
          rtib011 LIKE rtib_t.rtib011, #成本售價
          rtib012 LIKE rtib_t.rtib012, #銷售數量
          rtib013 LIKE rtib_t.rtib013, #銷售單位
          rtib014 LIKE rtib_t.rtib014, #庫存數量
          rtib015 LIKE rtib_t.rtib015, #庫存單位
          rtib016 LIKE rtib_t.rtib016, #銷售庫存單位換算率
          rtib017 LIKE rtib_t.rtib017, #計價數量
          rtib018 LIKE rtib_t.rtib018, #計價單位
          rtib019 LIKE rtib_t.rtib019, #銷售計價單位換算率
          rtib020 LIKE rtib_t.rtib020, #折價金額
          rtib021 LIKE rtib_t.rtib021, #應收金額
          rtib022 LIKE rtib_t.rtib022, #未稅金額
          rtib023 LIKE rtib_t.rtib023, #成本金額
          rtib024 LIKE rtib_t.rtib024, #理由碼
          rtib025 LIKE rtib_t.rtib025, #庫區
          rtib026 LIKE rtib_t.rtib026, #儲位
          rtib027 LIKE rtib_t.rtib027, #批號
          rtib028 LIKE rtib_t.rtib028, #專櫃編號
          rtib029 LIKE rtib_t.rtib029, #分攤積點
          rtib030 LIKE rtib_t.rtib030, #卡券銷售明細對應項次
          rtib031 LIKE rtib_t.rtib031, #本幣應收金額
          rtib032 LIKE rtib_t.rtib032, #庫存管理特徵
          rtib033 LIKE rtib_t.rtib033, #營業員
          rtib034 LIKE rtib_t.rtib034, #掃描碼
          rtib035 LIKE rtib_t.rtib035, #交易類型
          rtib036 LIKE rtib_t.rtib036, #商品屬性
          rtib037 LIKE rtib_t.rtib037, #捆綁條碼項次
          rtib038 LIKE rtib_t.rtib038, #結算扣率
          rtib039 LIKE rtib_t.rtib039, #贈品否
          rtib040 LIKE rtib_t.rtib040, #卡種/券種編號
          rtib041 LIKE rtib_t.rtib041, #卡號/券號
          rtib101 LIKE rtib_t.rtib101, #退貨退回商品
          rtib102 LIKE rtib_t.rtib102, #產品品類
          rtib103 LIKE rtib_t.rtib103, #品牌
          rtib104 LIKE rtib_t.rtib104, #商戶編號(租賃)
          rtib105 LIKE rtib_t.rtib105, #合約編號(租賃)
          rtib106 LIKE rtib_t.rtib106, #单位兑换积分      #160604-00009#85 dongsz add
          rtib107 LIKE rtib_t.rtib107, #促销单位兑换积分  #160604-00009#85 dongsz add
          rtib108 LIKE rtib_t.rtib108, #总兑换积分        #160604-00009#85 dongsz add
          rtib042 LIKE rtib_t.rtib042  #退货方式　　　　　#160604-00009#85 dongsz add
   END RECORD   
   #160517-00004#1 160517 by sakura add(E) 
   DEFINE l_n       LIKE type_t.num5
   DEFINE l_rtib012 LIKE rtib_t.rtib012       
   DEFINE l_xrcd103   LIKE xrcd_t.xrcd103,
          l_xrcd104   LIKE xrcd_t.xrcd104,
          l_xrcd105   LIKE xrcd_t.xrcd105,
          l_xrcd113   LIKE xrcd_t.xrcd113,
          l_xrcd114   LIKE xrcd_t.xrcd114,
          l_xrcd115   LIKE xrcd_t.xrcd115,
          l_imaa005   LIKE imaa_t.imaa005,
          l_xrcd123   LIKE xrcd_t.xrcd113,
          l_xrcd124   LIKE xrcd_t.xrcd114,
          l_xrcd125   LIKE xrcd_t.xrcd115,
          l_xrcd133   LIKE xrcd_t.xrcd113,
          l_xrcd134   LIKE xrcd_t.xrcd114,
          l_xrcd135   LIKE xrcd_t.xrcd115
   DEFINE l_success   LIKE type_t.num5  
   DEFINE l_rtic013   LIKE rtic_t.rtic013
   
   INITIALIZE l_rtib.* TO NULL
   LET l_n = 1

   IF NOT cl_ask_confirm('axm-00465') THEN
      RETURN
   END IF 
   #160604-00009#85--dongsz mark--s
#   DECLARE rtim_curs2 CURSOR FOR SELECT *
#                                  FROM rtib_t 
#                                 WHERE rtibdocno = g_rtia_m.rtia007
#                                   AND rtibent = g_enterprise
#                                   AND rtib035 = '1'
   #160604-00009#85--dongsz mark--e
   #160604-00009#85--dongsz add--s
   DECLARE rtim_curs2 CURSOR FOR 
    SELECT rtibent,  rtibsite,  rtibunit, rtiborga,  rtibdocno, rtibseq,  rtib001,  
           rtib002,  rtib003,  rtib004,  rtib005,  rtib006,  rtib007,  rtib008,  
           rtib009,  rtib010,  rtib011,  rtib012,  rtib013,  rtib014,  rtib015,  
           rtib016,  rtib017,  rtib018,  rtib019,  rtib020,  rtib021,  rtib022,  
           rtib023,  rtib024,  rtib025,  rtib026,  rtib027,  rtib028,  rtib029,  
           rtib030,  rtib031,  rtib032,  rtib033,  rtib034,  rtib035,  rtib036,  
           rtib037,  rtib038,  rtib039,  rtib040,  rtib041,  rtib101,  rtib102,  
           rtib103,  rtib104,  rtib105,  rtib106,  rtib107,  rtib108,  rtib042 
      FROM rtib_t 
     WHERE rtibdocno = g_rtia_m.rtia007
       AND rtibent = g_enterprise
       AND rtib035 = '1'
   #160604-00009#85--dongsz add--e
   FOREACH rtim_curs2 INTO l_rtib.*
      IF SQLCA.sqlcode THEN
          INITIALIZE g_errparam TO NULL
          LET g_errparam.code = SQLCA.sqlcode
          LET g_errparam.extend = 'foreach:rtim_curs2'
          LET g_errparam.popup = TRUE
          CALL cl_err()
          EXIT FOREACH
      END IF
      LET l_rtib.rtibent = g_enterprise
      LET l_rtib.rtibsite = g_rtia_m.rtiasite
      LET l_rtib.rtibunit = g_rtia_m.rtiasite
      LET l_rtib.rtiborga = g_rtia_m.rtiasite
      LET l_rtib.rtibdocno = g_rtia_m.rtiadocno
      LET l_rtib.rtib001 = g_rtia_m.rtia007
      LET l_rtib.rtib002 = l_rtib.rtibseq
      LET l_rtib.rtib035 = '2'
      LET l_rtib.rtib042 = '1'       #退货方式   #160604-00009#85 dongsz add
      LET l_rtib012 = 0
      #抓取已被销退的数量
      SELECT SUM(rtib012) INTO l_rtib012
        FROM rtib_t,rtia_t
       WHERE rtibent = g_enterprise
         AND rtiaent = rtibent
         AND rtiadocno = rtibdocno
         AND rtib001 = g_rtia_m.rtia007
         AND rtib002 = l_rtib.rtib002
         AND rtib035 = '2'
         AND rtibdocno <> g_rtia_m.rtiadocno
         AND rtiastus <> 'X'
         AND rtib042='1'
      IF cl_null(l_rtib012) THEN 
         LET l_rtib012 = 0
      END IF 
      LET l_rtib.rtib012 = l_rtib.rtib012 + l_rtib012
      IF l_rtib.rtib012 <= 0 THEN
         CONTINUE FOREACH       
         LET l_rtib.rtib012 = 0
         LET l_rtib.rtib017 = 0
      END IF
      #计价数量
      CALL s_aooi250_convert_qty(l_rtib.rtib004,l_rtib.rtib013,l_rtib.rtib018,l_rtib.rtib012)
           RETURNING l_success,l_rtib.rtib017
      #庫存數量
      CALL s_aooi250_convert_qty(l_rtib.rtib004,l_rtib.rtib013,l_rtib.rtib015,l_rtib.rtib012)
           RETURNING l_success,l_rtib.rtib014
      #应收金额 = 交易价*计价数量
      LET l_rtib.rtib021 = l_rtib.rtib010 * l_rtib.rtib017
      IF NOT cl_null(l_rtib.rtib021) THEN 
         LET l_rtib.rtib021 = s_curr_round(g_rtia_m.rtiasite,g_rtia_m.rtia026,l_rtib.rtib021,'2')
         #计算本币应收金额
         LET l_rtib.rtib031 = l_rtib.rtib021 * g_rtia_m.rtia027
      END IF 
      LET l_rtib.rtib012 = l_rtib.rtib012*(-1)
      LET l_rtib.rtib014 = l_rtib.rtib014*(-1)
      LET l_rtib.rtib017 = l_rtib.rtib017*(-1)
      LET l_rtib.rtib020 = l_rtib.rtib020*(-1)
      LET l_rtib.rtib021 = l_rtib.rtib021*(-1)
      LET l_rtib.rtib022 = l_rtib.rtib022*(-1)
      LET l_rtib.rtib031 = l_rtib.rtib031*(-1)
      LET l_rtib.rtib108 = l_rtib.rtib108*(-1)    #160604-00009#85 dongsz add
      LET l_rtib.rtibseq = l_n
      #INSERT INTO rtib_t VALUES(l_rtib.*)  #160517-00004#1 160517 by sakura mark
      #160517-00004#1 160517 by sakura add(S)
      INSERT INTO rtib_t (rtibent,rtibsite,rtibunit,rtiborga,rtibdocno,
                          rtibseq,rtib001 ,rtib002 ,rtib003 ,rtib004,
                          rtib005,rtib006 ,rtib007 ,rtib008 ,rtib009,
                          rtib010,rtib011 ,rtib012 ,rtib013 ,rtib014,
                          rtib015,rtib016 ,rtib017 ,rtib018 ,rtib019,
                          rtib020,rtib021 ,rtib022 ,rtib023 ,rtib024,
                          rtib025,rtib026 ,rtib027 ,rtib028 ,rtib029,
                          rtib030,rtib031 ,rtib032 ,rtib033 ,rtib034,
                          rtib035,rtib036 ,rtib037 ,rtib038 ,rtib039,
                          rtib040,rtib041 ,rtib101 ,rtib102 ,rtib103,
                          #rtib104,rtib105)         #160604-00009#85 dongsz mark
                          rtib104,rtib105 ,rtib106 ,rtib107 ,rtib108, rtib042)  #160604-00009#85 dongsz add
      VALUES (l_rtib.rtibent,l_rtib.rtibsite,l_rtib.rtibunit,l_rtib.rtiborga,l_rtib.rtibdocno,
              l_rtib.rtibseq,l_rtib.rtib001 ,l_rtib.rtib002 ,l_rtib.rtib003 ,l_rtib.rtib004,
              l_rtib.rtib005,l_rtib.rtib006 ,l_rtib.rtib007 ,l_rtib.rtib008 ,l_rtib.rtib009,
              l_rtib.rtib010,l_rtib.rtib011 ,l_rtib.rtib012 ,l_rtib.rtib013 ,l_rtib.rtib014,
              l_rtib.rtib015,l_rtib.rtib016 ,l_rtib.rtib017 ,l_rtib.rtib018 ,l_rtib.rtib019,
              l_rtib.rtib020,l_rtib.rtib021 ,l_rtib.rtib022 ,l_rtib.rtib023 ,l_rtib.rtib024,
              l_rtib.rtib025,l_rtib.rtib026 ,l_rtib.rtib027 ,l_rtib.rtib028 ,l_rtib.rtib029,
              l_rtib.rtib030,l_rtib.rtib031 ,l_rtib.rtib032 ,l_rtib.rtib033 ,l_rtib.rtib034,
              l_rtib.rtib035,l_rtib.rtib036 ,l_rtib.rtib037 ,l_rtib.rtib038 ,l_rtib.rtib039,
              l_rtib.rtib040,l_rtib.rtib041 ,l_rtib.rtib101 ,l_rtib.rtib102 ,l_rtib.rtib103,
              #l_rtib.rtib104,l_rtib.rtib105)       #160604-00009#85 dongsz mark
              l_rtib.rtib104,l_rtib.rtib105 ,l_rtib.rtib106 ,l_rtib.rtib107 ,l_rtib.rtib108, l_rtib.rtib042)     #160604-00009#85 dongsz add
      #160517-00004#1 160517 by sakura add(E)
      IF SQLCA.sqlcode THEN
          INITIALIZE g_errparam TO NULL
          LET g_errparam.code = SQLCA.sqlcode
          LET g_errparam.extend = 'ins rtib_t'
          LET g_errparam.popup = TRUE
          CALL cl_err()
          RETURN
      END IF
      CALL s_artt622_rtin_modify('a',g_rtia_m.rtiasite,g_rtia_m.rtiadocno,l_rtib.rtibseq,'',l_rtib.rtib004,l_rtib.rtib005,
                                 g_prog,'',l_rtib.rtib025,l_rtib.rtib026,l_rtib.rtib027,l_rtib.rtib013,l_rtib.rtib012,l_rtib.rtib032) RETURNING l_success
      IF NOT l_success THEN            
         RETURN
      END IF
      #写入折扣明细
      CALL artt622_ins_rtic(l_rtib.rtibseq,l_rtib.rtib001,l_rtib.rtib002,l_rtib.rtib017) RETURNING l_success,l_rtic013
      IF NOT l_success THEN            
         RETURN
      END IF
      UPDATE rtib_t SET rtib020 = l_rtic013
       WHERE rtibent = g_enterprise
         AND rtibdocno = g_rtia_m.rtiadocno
         AND rtibseq = l_rtib.rtibseq
      CASE
         WHEN SQLCA.sqlcode #其他錯誤
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = SQLCA.sqlcode
            LET g_errparam.extend = "upd rtib_t"
            LET g_errparam.popup = TRUE
            CALL cl_err()
            RETURN
      END CASE
      
                     #單號      項次       項次2   營運據點           應收金額
      CALL s_tax_ins(g_rtia_m.rtiadocno,l_rtib.rtibseq,'0',g_rtia_m.rtiasite,l_rtib.rtib021,
                     #稅別                          數量                           幣別             匯率             帳套  匯率2 匯率3
                     l_rtib.rtib006,l_rtib.rtib017,g_rtia_m.rtia026,g_rtia_m.rtia027,' ',' ',  ' ')
                #原幣未稅金額 原幣稅額   原幣含稅金額 本幣未稅金額(AR/AP使用) 本幣稅額(AR/AP使用) 本幣含稅金額(AR/AP使用)
      RETURNING l_xrcd103,    l_xrcd104, l_xrcd105,   l_xrcd113,              l_xrcd114,          l_xrcd115,
                l_xrcd123,l_xrcd124,l_xrcd125,l_xrcd133,l_xrcd134,l_xrcd135

      UPDATE rtib_t SET rtib022 = l_xrcd103
       WHERE rtibent = g_enterprise
         AND rtibdocno = g_rtia_m.rtiadocno
         AND rtibseq = l_rtib.rtibseq
      CASE
         WHEN SQLCA.sqlcode #其他錯誤
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = SQLCA.sqlcode
            LET g_errparam.extend = "upd rtib_t"
            LET g_errparam.popup = TRUE
            CALL cl_err()
            RETURN
      END CASE
      LET l_n = l_n + 1
   END FOREACH
   #更新单头本币应收金额
   #更新单头含税金额
   UPDATE rtia_t SET rtia031 = (SELECT SUM(rtib021)
                                  FROM rtib_t
                                 WHERE rtibent = g_enterprise
                                   AND rtibdocno = g_rtia_m.rtiadocno),
                     rtia049 = (SELECT SUM(rtib031)
                                  FROM rtib_t
                                 WHERE rtibent = g_enterprise
                                   AND rtibdocno = g_rtia_m.rtiadocno)              
    WHERE rtiaent = g_enterprise
      AND rtiadocno = g_rtia_m.rtiadocno  
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = "upd rtia_t"
      LET g_errparam.popup = FALSE
      CALL cl_err()

      RETURN
   END IF     
   CALL artt622_b_fill()
   
END FUNCTION

################################################################################
# Descriptions...: 更新单身折扣明细
# Memo...........:
# Usage..........: CALL artt622_set_rtic()
# Input parameter: 无
# Return code....: 无
# Date & Author..: 2015/06/03 By yangxf
# Modify.........:
################################################################################
PRIVATE FUNCTION artt622_set_rtic()
#DEFINE l_rtib    RECORD LIKE rtib_t.*   #160517-00004#1 160517 by sakura mark
#160517-00004#1 160517 by sakura add(S)
DEFINE l_rtib RECORD  #銷售交易商品明細檔
       rtibent LIKE rtib_t.rtibent, #企業編號
       rtibsite LIKE rtib_t.rtibsite, #營運據點
       rtibunit LIKE rtib_t.rtibunit, #應用組織
       rtiborga LIKE rtib_t.rtiborga, #帳務組織
       rtibdocno LIKE rtib_t.rtibdocno, #單據編號
       rtibseq LIKE rtib_t.rtibseq, #項次
       rtib001 LIKE rtib_t.rtib001, #來源單號
       rtib002 LIKE rtib_t.rtib002, #來源單號項次
       rtib003 LIKE rtib_t.rtib003, #商品條碼
       rtib004 LIKE rtib_t.rtib004, #商品編號
       rtib005 LIKE rtib_t.rtib005, #特徵碼
       rtib006 LIKE rtib_t.rtib006, #稅別編號
       rtib007 LIKE rtib_t.rtib007, #銷售開立發票
       rtib008 LIKE rtib_t.rtib008, #標準售價
       rtib009 LIKE rtib_t.rtib009, #促銷售價
       rtib010 LIKE rtib_t.rtib010, #交易售價
       rtib011 LIKE rtib_t.rtib011, #成本售價
       rtib012 LIKE rtib_t.rtib012, #銷售數量
       rtib013 LIKE rtib_t.rtib013, #銷售單位
       rtib014 LIKE rtib_t.rtib014, #庫存數量
       rtib015 LIKE rtib_t.rtib015, #庫存單位
       rtib016 LIKE rtib_t.rtib016, #銷售庫存單位換算率
       rtib017 LIKE rtib_t.rtib017, #計價數量
       rtib018 LIKE rtib_t.rtib018, #計價單位
       rtib019 LIKE rtib_t.rtib019, #銷售計價單位換算率
       rtib020 LIKE rtib_t.rtib020, #折價金額
       rtib021 LIKE rtib_t.rtib021, #應收金額
       rtib022 LIKE rtib_t.rtib022, #未稅金額
       rtib023 LIKE rtib_t.rtib023, #成本金額
       rtib024 LIKE rtib_t.rtib024, #理由碼
       rtib025 LIKE rtib_t.rtib025, #庫區
       rtib026 LIKE rtib_t.rtib026, #儲位
       rtib027 LIKE rtib_t.rtib027, #批號
       rtib028 LIKE rtib_t.rtib028, #專櫃編號
       rtib029 LIKE rtib_t.rtib029, #分攤積點
       rtib030 LIKE rtib_t.rtib030, #卡券銷售明細對應項次
       rtib031 LIKE rtib_t.rtib031, #本幣應收金額
       rtib032 LIKE rtib_t.rtib032, #庫存管理特徵
       rtib033 LIKE rtib_t.rtib033, #營業員
       rtib034 LIKE rtib_t.rtib034, #掃描碼
       rtib035 LIKE rtib_t.rtib035, #交易類型
       rtib036 LIKE rtib_t.rtib036, #商品屬性
       rtib037 LIKE rtib_t.rtib037, #捆綁條碼項次
       rtib038 LIKE rtib_t.rtib038, #結算扣率
       rtib039 LIKE rtib_t.rtib039, #贈品否
       rtib040 LIKE rtib_t.rtib040, #卡種/券種編號
       rtib041 LIKE rtib_t.rtib041, #卡號/券號
       rtib101 LIKE rtib_t.rtib101, #退貨退回商品(租賃)
       rtib102 LIKE rtib_t.rtib102, #產品品類(租賃)
       rtib103 LIKE rtib_t.rtib103, #品牌(租賃)
       rtib104 LIKE rtib_t.rtib104, #商戶編號(租賃)
       rtib105 LIKE rtib_t.rtib105, #合約編號(租賃)
       rtib106 LIKE rtib_t.rtib106, #單位兌換積分
       rtib107 LIKE rtib_t.rtib107, #促銷單位兌換積分
       rtib108 LIKE rtib_t.rtib108, #總兌換積分
       rtib042 LIKE rtib_t.rtib042, #退貨方式
       rtib043 LIKE rtib_t.rtib043, #發票編號
       rtib044 LIKE rtib_t.rtib044, #發票號碼
       rtib109 LIKE rtib_t.rtib109 #返現金額
       END RECORD
#160517-00004#1 160517 by sakura add(E)
DEFINE l_rtic013 LIKE rtic_t.rtic013

   #DECLARE sel_rtib CURSOR FOR SELECT *    #161111-00028#3--mark
  #161111-00028#3--ADD--BEGIN-----------   
    DECLARE sel_rtib CURSOR FOR SELECT rtibent,rtibsite,rtibunit,rtiborga,rtibdocno,rtibseq,rtib001,rtib002,rtib003,
                                       rtib004,rtib005,rtib006,rtib007,rtib008,rtib009,rtib010,rtib011,rtib012,rtib013,
                                       rtib014,rtib015,rtib016,rtib017,rtib018,rtib019,rtib020,rtib021,rtib022,rtib023,
                                       rtib024,rtib025,rtib026,rtib027,rtib028,rtib029,rtib030,rtib031,rtib032,rtib033,
                                       rtib034,rtib035,rtib036,rtib037,rtib038,rtib039,rtib040,rtib041,rtib101,rtib102,
                                       rtib103,rtib104,rtib105,rtib106,rtib107,rtib108,rtib042,rtib043,rtib044,rtib109
   #161111-00028#3--ADD--END-------------
                                 FROM rtib_t
                                WHERE rtibent = g_enterprise
                                  AND rtibdocno = g_rtia_m.rtiadocno
                                  AND rtib035 = '2'
                                  AND rtib001 IS NOT NULL
   FOREACH sel_rtib INTO l_rtib.*
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = 'FOREACH sel_rtib:'
         LET g_errparam.popup = TRUE
         CALL cl_err()
         RETURN 
      END IF
      #删除对应折价
      DELETE FROM rtic_t WHERE rticent = g_enterprise AND rticdocno = g_rtia_m.rtiadocno AND rticseq = l_rtib.rtibseq
      #新增折价明细
      INSERT INTO rtic_t(rticent,rticsite,rticunit,rticdocno,rticseq,rticseq1,
                         rtic001,rtic002,rtic003,rtic004,rtic005,rtic006,rtic007,
                         rtic008,rtic009,rtic010,rtic011,rtic012,rtic013,rtic014,
                         rtic015,rtic016,rtic017,rtic018,rtic019,rtic020,rtic021,
                         rtic022,rtic023,rtic024,rtic025,rtic026,rtic027,rtic028,
                         rtic029)
                  SELECT rticent,g_rtia_m.rtiasite,g_rtia_m.rtiasite,g_rtia_m.rtiadocno,l_rtib.rtibseq,rticseq1,
                         rtic001,rtic002,rtic003,rtic004,rtic005,rtic006,rtic007,
                         rtic008,rtic009,rtic010,rtic011,rtic012,rtic013,rtic014,
                         rtic015,rtic016,rtic017,rtic018,rtic019,rtic020,rtic021,
                         rtic022,rtic023,rtic024,rtic025,rtic026,rtic027,rtic028,
                         rtic029
                    FROM rtic_t 
                   WHERE rticent = g_enterprise
                     AND rticdocno =  l_rtib.rtib001
                     AND rticseq = l_rtib.rtib002
         
      UPDATE rtic_t SET rtic013 = l_rtib.rtib017/rtic008*rtic013
       WHERE rticent = g_enterprise
         AND rticdocno = g_rtia_m.rtiadocno
         AND rticseq = l_rtib.rtibseq
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = 'UPD rtic_t'
         LET g_errparam.popup = TRUE
         CALL cl_err()
         RETURN 
      END IF
      UPDATE rtic_t SET rtic008 = l_rtib.rtib017,
                        rtic009 = l_rtib.rtib021
       WHERE rticent = g_enterprise
         AND rticdocno = g_rtia_m.rtiadocno
         AND rticseq = l_rtib.rtibseq
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = 'UPD rtic_t'
         LET g_errparam.popup = TRUE
         CALL cl_err()
         RETURN 
      END IF
      SELECT SUM(rtic013) INTO l_rtic013
        FROM rtic_t
       WHERE rticent = g_enterprise
         AND rticdocno = g_rtia_m.rtiadocno
         AND rticseq = l_rtib.rtibseq
      IF cl_null(l_rtic013) THEN 
         LET l_rtic013 = 0
      END IF 
      UPDATE rtib_t SET rtib020 = l_rtic013
       WHERE rtibent = g_enterprise
         AND rtibdocno = g_rtia_m.rtiadocno
         AND rtibseq = l_rtib.rtibseq
      IF SQLCA.sqlcode THEN 
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "upd rtib_t"
         LET g_errparam.popup = TRUE
         CALL cl_err()
         RETURN
      END IF 
   END FOREACH

END FUNCTION

################################################################################
# Descriptions...: 描述说明
# Memo...........:
# Usage..........: CALL artt622_ins_rtic(p_rtib001,p_rtib002,p_rtib012)
#                  RETURNING l_success
# Input parameter: p_rtibseq      项次
#                : p_rtib001      来源单号
#                : p_rtib002      来源项次
#                : p_rtib012      数量
# Return code....: r_success      处理状态
# Date & Author..: 2015/06/03 By yangxf
# Modify.........:
################################################################################
PRIVATE FUNCTION artt622_ins_rtic(p_rtibseq,p_rtib001,p_rtib002,p_rtib012)
DEFINE p_rtibseq   LIKE rtib_t.rtibseq
DEFINE p_rtib001   LIKE rtib_t.rtib001
DEFINE p_rtib002   LIKE rtib_t.rtib002
DEFINE p_rtib012   LIKE rtib_t.rtib012
DEFINE r_success   LIKE type_t.num5
DEFINE l_rtic013   LIKE rtic_t.rtic013
DEFINE l_sql       STRING 

   LET r_success  = TRUE
   DROP TABLE artt622_detail_rtic

   #CREATE TEMP TABLE
   LET l_sql = "CREATE GLOBAL TEMPORARY TABLE artt622_detail_rtic AS ",
                "SELECT * FROM rtic_t "
   PREPARE rtic_tbl FROM l_sql
   EXECUTE rtic_tbl
   FREE rtic_tbl
                
   #將符合條件的資料丟入TEMP TABLE
   INSERT INTO artt622_detail_rtic SELECT * FROM rtic_t 
                                    WHERE rticent = g_enterprise 
                                      AND rticdocno = p_rtib001
                                      AND rticseq = p_rtib002
 
   #將key修正為調整後   
   UPDATE artt622_detail_rtic 
      #更新key欄位
      SET rticdocno = g_rtia_m.rtiadocno,
          rticseq = p_rtibseq,
          rtic013 = p_rtib012/rtic008*rtic013
          
   UPDATE artt622_detail_rtic 
      #更新key欄位
      SET rtic008 =  p_rtib012,
          rtic009 = rtic009*(-1)
   
   SELECT SUM(rtic013) INTO l_rtic013
     FROM artt622_detail_rtic
   IF cl_null(l_rtic013) THEN 
      LET l_rtic013 = 0
   END IF 
   INSERT INTO rtic_t SELECT * FROM artt622_detail_rtic
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "reproduce" 
      LET g_errparam.code   = SQLCA.sqlcode 
      LET g_errparam.popup  = TRUE 
      CALL cl_err()
      LET r_success = FALSE
      RETURN r_success,''
   END IF
   DROP TABLE artt622_detail_rtic

   RETURN r_success,l_rtic013
END FUNCTION

################################################################################
# Descriptions...: 检查单号+项次是否重复
# Memo...........:
# Usage..........: CALL artt622_rtib001_rtib002_chk()
# Input parameter: 无
# Return code....: 无
# Date & Author..: 2015/06/04 By yangxf
# Modify.........:
################################################################################
PRIVATE FUNCTION artt622_rtib001_rtib002_chk()
DEFINE l_n    LIKE type_t.num5

   LET g_errno = ''
   LET l_n = 0
   SELECT COUNT(*) INTO l_n
     FROM rtib_t
    WHERE rtibent = g_enterprise
      AND rtibdocno = g_rtia_m.rtiadocno
      AND rtib001 = g_rtib_d[l_ac].rtib001
      AND rtib002 = g_rtib_d[l_ac].rtib002
   IF l_n > 0 THEN 
      LET g_errno = 'art-00598'
   END IF 
   
END FUNCTION

################################################################################
# Descriptions...: 产生单身明细
# Memo...........:
# Usage..........: CALL artt622_ins_rtib_2()
# Input parameter: 无
# Return code....: 无
# Date & Author..: 2105/06/09 By yangxf
# Modify.........:
################################################################################
PRIVATE FUNCTION artt622_ins_rtib_2()
DEFINE l_sql      STRING 

   WHENEVER ERROR CONTINUE
   #CREATE TEMP TABLE
   LET l_sql = "CREATE GLOBAL TEMPORARY TABLE artt622_detail_rtib AS ",
                "SELECT * FROM rtib_t "
   PREPARE rtib_tbl FROM l_sql
   EXECUTE rtib_tbl
   FREE rtib_tbl
                
   #將符合條件的資料丟入TEMP TABLE
   INSERT INTO artt622_detail_rtib SELECT * FROM rtib_t 
                                    WHERE rtibent = g_enterprise 
                                      AND rtibdocno = g_rtia_m.rtia007
 
   #將key修正為調整後   
   UPDATE artt622_detail_rtib 
      #更新key欄位
      SET rtibdocno = g_rtia_m.rtiadocno,
          rtibsite = g_rtia_m.rtiasite,
          rtibunit = g_rtia_m.rtiasite,
          rtiborga = g_rtia_m.rtiasite

   INSERT INTO rtib_t SELECT * FROM artt622_detail_rtib
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "reproduce" 
      LET g_errparam.code   = SQLCA.sqlcode 
      LET g_errparam.popup  = TRUE 
      CALL cl_err()
      RETURN 
   END IF
   DROP TABLE artt622_detail_rtib
   
   #CREATE TEMP TABLE
   LET l_sql = "CREATE GLOBAL TEMPORARY TABLE artt622_detail_rtic2 AS ",
                "SELECT * FROM rtic_t "
   PREPARE rtic_tbl2 FROM l_sql
   EXECUTE rtic_tbl2
   FREE rtic_tbl2
                
   #將符合條件的資料丟入TEMP TABLE
   INSERT INTO artt622_detail_rtic2 SELECT * FROM rtic_t 
                                    WHERE rticent = g_enterprise 
                                      AND rticdocno = g_rtia_m.rtia007
 
   #將key修正為調整後   
   UPDATE artt622_detail_rtic2 
      #更新key欄位
      SET rticdocno = g_rtia_m.rtiadocno,
          rticsite = g_rtia_m.rtiasite,
          rticunit = g_rtia_m.rtiasite

   INSERT INTO rtic_t SELECT * FROM artt622_detail_rtic2
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "reproduce" 
      LET g_errparam.code   = SQLCA.sqlcode 
      LET g_errparam.popup  = TRUE 
      CALL cl_err()
      RETURN 
   END IF
   DROP TABLE artt622_detail_rtic2
   
   #CREATE TEMP TABLE
   LET l_sql = "CREATE GLOBAL TEMPORARY TABLE artt622_detail_rtin AS ",
                "SELECT * FROM rtin_t "
   PREPARE rtin_tbl FROM l_sql
   EXECUTE rtin_tbl
   FREE rtin_tbl
                
   #將符合條件的資料丟入TEMP TABLE
   INSERT INTO artt622_detail_rtin SELECT * FROM rtin_t 
                                    WHERE rtinent = g_enterprise 
                                      AND rtindocno = g_rtia_m.rtia007
 
   #將key修正為調整後   
   UPDATE artt622_detail_rtin 
      #更新key欄位
      SET rtindocno = g_rtia_m.rtiadocno,
          rtinsite = g_rtia_m.rtiasite

   INSERT INTO rtin_t SELECT * FROM artt622_detail_rtin
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "reproduce" 
      LET g_errparam.code   = SQLCA.sqlcode 
      LET g_errparam.popup  = TRUE 
      CALL cl_err()
      RETURN 
   END IF
   DROP TABLE artt622_detail_rtin
   
   #CREATE TEMP TABLE
   LET l_sql = "CREATE GLOBAL TEMPORARY TABLE artt622_detail_xrcd AS ",
                "SELECT * FROM xrcd_t "
   PREPARE xrcd_tbl FROM l_sql
   EXECUTE xrcd_tbl
   FREE xrcd_tbl
                
   #將符合條件的資料丟入TEMP TABLE
   INSERT INTO artt622_detail_xrcd SELECT * FROM xrcd_t 
                                    WHERE xrcdent = g_enterprise 
                                      AND xrcddocno = g_rtia_m.rtia007
 
   #將key修正為調整後   
   UPDATE artt622_detail_xrcd 
      #更新key欄位
      SET xrcddocno = g_rtia_m.rtiadocno,
          xrcdsite = g_rtia_m.rtiasite

   INSERT INTO xrcd_t SELECT * FROM artt622_detail_xrcd
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "reproduce" 
      LET g_errparam.code   = SQLCA.sqlcode 
      LET g_errparam.popup  = TRUE 
      CALL cl_err()
      RETURN 
   END IF
   DROP TABLE artt622_detail_xrcd
   
   
END FUNCTION

################################################################################
# Descriptions...: 修改交易價
# Memo...........:
# Usage..........: CALL artt500_discount()
# Input parameter: 無
# Return code....: 無
# Date & Author..: 2015/06/28 By yangxf
# Modify.........:
################################################################################
PRIVATE FUNCTION artt622_discount()
DEFINE l_n   LIKE type_t.num5

   IF g_prog != 'artt622' AND g_prog != 'artt610' THEN 
      RETURN 
   END IF
   #單身無資料不可操作
   LET l_n = 0   
   SELECT COUNT(*) INTO l_n
     FROM rtib_t
    WHERE rtibent = g_enterprise
      AND rtibdocno = g_rtia_m.rtiadocno
   IF l_n = 0 THEN 
      RETURN 
   END IF 
   #單據狀態不為未確認，不可操作
   IF g_rtia_m.rtiastus != 'N' THEN 
      RETURN 
   END IF 
   IF g_rtia_m.rtia048 = 'Y' THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = "art-00374"
      LET g_errparam.extend = ""
      LET g_errparam.popup = TRUE
      CALL cl_err()

      RETURN 
   END IF 
   LET l_n = 0
   #检查是否有付款资料
   SELECT COUNT(*) INTO l_n
     FROM rtif_t
    WHERE rtifent = g_enterprise
      AND rtifdocno = g_rtia_m.rtiadocno
   IF l_n > 0 THEN 
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'amm-00411'
      LET g_errparam.extend = ''
      LET g_errparam.popup = TRUE
      CALL cl_err()
      RETURN 
   END IF 
   
   CALL artt622_discount_input()
   CALL artt622_b_fill()
END FUNCTION

################################################################################
#  escriptions...: 描述说明
# Memo...........:
# Usage..........: CALL artt622_discount_input()
# Input parameter: 無
# Return code....: 無
# Date & Author..: 2015/06/28 By yangxf
################################################################################
PRIVATE FUNCTION artt622_discount_input()
DEFINE l_success              LIKE type_t.num5
DEFINE l_xrcd103              LIKE xrcd_t.xrcd103,
       l_xrcd104              LIKE xrcd_t.xrcd104,
       l_xrcd105              LIKE xrcd_t.xrcd105,
       l_xrcd113              LIKE xrcd_t.xrcd113,
       l_xrcd114              LIKE xrcd_t.xrcd114,
       l_xrcd115              LIKE xrcd_t.xrcd115,
       l_imaa005              LIKE imaa_t.imaa005,
       l_xrcd123              LIKE xrcd_t.xrcd113,
       l_xrcd124              LIKE xrcd_t.xrcd114,
       l_xrcd125              LIKE xrcd_t.xrcd115,
       l_xrcd133              LIKE xrcd_t.xrcd113,
       l_xrcd134              LIKE xrcd_t.xrcd114,
       l_xrcd135              LIKE xrcd_t.xrcd115
DEFINE l_price                LIKE rtib_t.rtib008
DEFINE l_price1               LIKE rtib_t.rtib008
DEFINE l_price2               LIKE rtib_t.rtib008
DEFINE l_price3               LIKE rtib_t.rtib008
DEFINE l_n                    LIKE type_t.num10
DEFINE l_lock_sw              LIKE type_t.chr1 
DEFINE l_oodb011              LIKE oodb_t.oodb011
DEFINE l_ooef016              LIKE ooef_t.ooef016

   LET g_forupd_sql = "SELECT rtibsite,rtibunit,rtiborga,rtibseq,rtib035,rtib001,rtib002,rtib003,rtib004, 
       rtib005,rtib006,rtib008,rtib009,rtib010,rtib012,rtib013,rtib014,rtib015,rtib016,rtib018,rtib017, 
       rtib019,rtib020,rtib021,rtib031,rtib022,rtib024,rtib025,rtib026,rtib027,rtib032,rtib033,rtib028, 
       rtib030 FROM rtib_t WHERE rtibent=? AND rtibdocno=? AND rtibseq=? FOR UPDATE"

   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE artt622_discount_bcl CURSOR FROM g_forupd_sql
   
      INPUT ARRAY g_rtib_d FROM s_detail1.*
          ATTRIBUTE(COUNT = g_rec_b,WITHOUT DEFAULTS, 
                  INSERT ROW = FALSE, 
                  DELETE ROW = FALSE,
                  APPEND ROW = TRUE)
 
         BEFORE INPUT
            CALL artt622_b_fill()
            IF g_loc = 'm' AND g_rec_b != 0 THEN
               CALL FGL_SET_ARR_CURR(g_detail_idx)
            END IF
            CALL cl_set_comp_entry('rtib010',TRUE)
            CALL cl_set_comp_required('rtib010',TRUE)
            CALL cl_set_comp_entry("rtibseq,rtib001,rtib002,rtib003,rtib004,rtib012,rtib024,rtib025,rtib026,rtib027,rtib028,rtib032,rtib033,rtib035",FALSE)
            LET g_rec_b = g_rtib_d.getLength()
         
         BEFORE ROW
            LET l_ac = ARR_CURR()
            LET g_detail_idx = l_ac
            LET g_current_page = 1
            
            LET l_lock_sw = 'N'            
            LET l_n = ARR_COUNT()
            DISPLAY l_ac TO FORMONLY.idx
         
            CALL s_transaction_begin()
            OPEN artt622_cl USING g_enterprise,g_rtia_m.rtiadocno
            IF STATUS THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "OPEN artt622_cl:" 
               LET g_errparam.code   = STATUS 
               LET g_errparam.popup  = TRUE 
               CALL cl_err()
               CLOSE artt622_cl
               CALL s_transaction_end('N','0')
               #RETURN     #20150707-mark by dongsz
               EXIT INPUT  #20150707-add by dongsz
            END IF
            LET g_rec_b = g_rtib_d.getLength()
            IF g_rec_b >= l_ac 
               AND g_rtib_d[l_ac].rtibseq IS NOT NULL
            THEN
               LET g_rtib_d_t.* = g_rtib_d[l_ac].*  #BACKUP
               LET g_rtib_d_o.* = g_rtib_d[l_ac].*  #BACKUP
               OPEN artt622_discount_bcl USING g_enterprise,g_rtia_m.rtiadocno,g_rtib_d[l_ac].rtibseq     
               IF SQLCA.sqlcode THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "artt622_discount_bcl" 
                  LET g_errparam.code   = SQLCA.sqlcode 
                  LET g_errparam.popup  = TRUE 
                  CALL cl_err()
                  LET l_lock_sw='Y'
                  EXIT INPUT
               ELSE
                  FETCH artt622_discount_bcl INTO g_rtib_d[l_ac].rtibsite,g_rtib_d[l_ac].rtibunit,g_rtib_d[l_ac].rtiborga, 
                      g_rtib_d[l_ac].rtibseq,g_rtib_d[l_ac].rtib035,g_rtib_d[l_ac].rtib001,g_rtib_d[l_ac].rtib002, 
                      g_rtib_d[l_ac].rtib003,g_rtib_d[l_ac].rtib004,g_rtib_d[l_ac].rtib005,g_rtib_d[l_ac].rtib006, 
                      g_rtib_d[l_ac].rtib008,g_rtib_d[l_ac].rtib009,g_rtib_d[l_ac].rtib010,g_rtib_d[l_ac].rtib012, 
                      g_rtib_d[l_ac].rtib013,g_rtib_d[l_ac].rtib014,g_rtib_d[l_ac].rtib015,g_rtib_d[l_ac].rtib016, 
                      g_rtib_d[l_ac].rtib018,g_rtib_d[l_ac].rtib017,g_rtib_d[l_ac].rtib019,g_rtib_d[l_ac].rtib020, 
                      g_rtib_d[l_ac].rtib021,g_rtib_d[l_ac].rtib031,g_rtib_d[l_ac].rtib022,g_rtib_d[l_ac].rtib024, 
                      g_rtib_d[l_ac].rtib025,g_rtib_d[l_ac].rtib026,g_rtib_d[l_ac].rtib027,g_rtib_d[l_ac].rtib032, 
                      g_rtib_d[l_ac].rtib033,g_rtib_d[l_ac].rtib028,g_rtib_d[l_ac].rtib030
                  IF SQLCA.sqlcode THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = g_rtib_d_t.rtibseq 
                     LET g_errparam.code   = SQLCA.sqlcode 
                     LET g_errparam.popup  = TRUE 
                     CALL cl_err()
                     LET l_lock_sw = "Y"
                  END IF
                  
                  #遮罩相關處理
                  LET g_rtib_d_mask_o[l_ac].* =  g_rtib_d[l_ac].*
                  CALL artt622_rtib_t_mask()
                  LET g_rtib_d_mask_n[l_ac].* =  g_rtib_d[l_ac].*
                  
                  LET g_bfill = "N"
                  CALL artt622_show()
                  LET g_bfill = "Y"
                  
                  CALL cl_show_fld_cont()
               END IF
            END IF
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_rtib_d[l_ac].rtib004
            CALL ap_ref_array2(g_ref_fields,"SELECT imaal003,imaal004 FROM imaal_t WHERE imaalent='"||g_enterprise||"' AND imaal001=? AND imaal002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_rtib_d[l_ac].rtib004_desc = '', g_rtn_fields[1] , ''
            LET g_rtib_d[l_ac].rtib004_desc_desc = '', g_rtn_fields[2] , ''
            DISPLAY BY NAME g_rtib_d[l_ac].rtib004_desc,g_rtib_d[l_ac].rtib004_desc_desc
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_rtib_d[l_ac].rtib013
            CALL ap_ref_array2(g_ref_fields,"SELECT oocal003 FROM oocal_t WHERE oocalent='"||g_enterprise||"' AND oocal001=? AND oocal002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_rtib_d[l_ac].rtib013_desc = '', g_rtn_fields[1] , ''
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_rtib_d[l_ac].rtib018
            CALL ap_ref_array2(g_ref_fields,"SELECT oocal003 FROM oocal_t WHERE oocalent='"||g_enterprise||"' AND oocal001=? AND oocal002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_rtib_d[l_ac].rtib018_desc = '', g_rtn_fields[1] , ''            
            #单头税别不为空且
            IF NOT cl_null(g_rtia_m.rtia028) THEN
               SELECT oodb011 INTO l_oodb011
                 FROM oodb_t,ooef_t
                WHERE oodbent = g_enterprise
                  AND oodb001 = ooef019
                  AND oodb002 = g_rtia_m.rtia028
                  AND oodbent = ooefent
                  AND ooef001 = g_rtia_m.rtiasite
            END IF 
            SELECT oodbl004 INTO g_rtib_d[l_ac].rtib006_desc 
              FROM oodbl_t,ooef_t
             WHERE oodblent = ooefent
              AND ooefent = g_enterprise
              AND ooef001 = g_rtia_m.rtiasite
              AND oodbl001 = ooef019
              AND oodbl002 = g_rtib_d[l_ac].rtib006
        
         BEFORE INSERT
            CANCEL INSERT
           
         BEFORE DELETE
            CANCEL DELETE
          

      AFTER FIELD rtib010
         IF NOT cl_null(g_rtib_d[l_ac].rtib010) THEN 
            IF g_rtib_d[l_ac].rtib010 < 0 THEN 
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = 'art-00394'
               LET g_errparam.extend = ''
               LET g_errparam.popup = TRUE
               CALL cl_err()
               LET g_rtib_d[l_ac].rtib010 = g_rtib_d_t.rtib010
               NEXT FIELD rtib010
            END IF
            LET g_rtib_d[l_ac].rtib010 = s_curr_round(g_rtia_m.rtiasite,g_rtia_m.rtia026,g_rtib_d[l_ac].rtib010,'1')
            #应收金额 = 交易价*计价数量
            LET g_rtib_d[l_ac].rtib021 = g_rtib_d[l_ac].rtib010 * g_rtib_d[l_ac].rtib017
            LET g_rtib_d[l_ac].rtib021 = s_curr_round(g_rtia_m.rtiasite,g_rtia_m.rtia026,g_rtib_d[l_ac].rtib021,'2')
            #计算本币应收金额
            LET g_rtib_d[l_ac].rtib031 = g_rtib_d[l_ac].rtib021 * g_rtia_m.rtia027
            SELECT ooef016 INTO l_ooef016
              FROM ooef_t
             WHERE ooefent = g_enterprise
               AND ooef001 = g_rtia_m.rtiasite
            LET g_rtib_d[l_ac].rtib031 = s_curr_round(g_rtia_m.rtiasite,l_ooef016,g_rtib_d[l_ac].rtib031,'2')
            #160604-00009#85--dongsz add--s
            IF g_prog = 'artt622' THEN
               LET g_rtib_d[l_ac].rtib008 = g_rtib_d[l_ac].rtib010
               LET g_rtib_d[l_ac].rtib009 = g_rtib_d[l_ac].rtib010
            END IF
            #160604-00009#85--dongsz add--e
         END IF 
         
         ON ROW CHANGE
            IF INT_FLAG THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code   = 9001 
               LET g_errparam.popup  = FALSE 
               CALL cl_err()
               LET INT_FLAG = 0
               LET g_rtib_d[l_ac].* = g_rtib_d_t.*
               CLOSE artt622_bcl
               CALL s_transaction_end('N','0')
               EXIT INPUT 
            END IF
              
            IF l_lock_sw = 'Y' THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = g_rtib_d[l_ac].rtibseq 
               LET g_errparam.code   = -263 
               LET g_errparam.popup  = TRUE 
               CALL cl_err()
               LET g_rtib_d[l_ac].* = g_rtib_d_t.*
            ELSE
               UPDATE rtib_t SET (rtib010,rtib021,rtib031) = (g_rtib_d[l_ac].rtib010,g_rtib_d[l_ac].rtib021,g_rtib_d[l_ac].rtib031)
                WHERE rtibent = g_enterprise AND rtibdocno = g_rtia_m.rtiadocno 
                  AND rtibseq = g_rtib_d_t.rtibseq #項次   
               CASE
                  WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "rtib_t" 
                     LET g_errparam.code   = "std-00009" 
                     LET g_errparam.popup  = TRUE 
                     CALL cl_err()
                     CALL s_transaction_end('N','0')
                     LET g_rtib_d[l_ac].* = g_rtib_d_t.*
                  WHEN SQLCA.sqlcode #其他錯誤
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "rtib_t" 
                     LET g_errparam.code   = SQLCA.sqlcode 
                     LET g_errparam.popup  = TRUE 
                     CALL cl_err()                   
                     CALL s_transaction_end('N','0')
                     LET g_rtib_d[l_ac].* = g_rtib_d_t.*  
                  OTHERWISE
               END CASE
               
               #修改歷程記錄(單身修改)
               LET g_log1 = util.JSON.stringify(g_rtia_m),util.JSON.stringify(g_rtib_d_t)
               LET g_log2 = util.JSON.stringify(g_rtia_m),util.JSON.stringify(g_rtib_d[l_ac])
               IF NOT cl_log_modified_record_d(g_log1,g_log2) THEN 
                  CALL s_transaction_end('N','0')
               END IF
               
               #add-point:單身修改後
                              #單號      項次       項次2   營運據點           應收金額
               CALL s_tax_ins(g_rtia_m.rtiadocno,g_rtib_d[l_ac].rtibseq,'0',   g_rtia_m.rtiasite,g_rtib_d[l_ac].rtib021,
                              #稅別                   计价數量                   幣別             匯率             帳套 匯率2 匯率3
                              g_rtib_d[l_ac].rtib006,g_rtib_d[l_ac].rtib017,g_rtia_m.rtia026,g_rtia_m.rtia027,' ',' ',  ' ')
                         #原幣未稅金額 原幣稅額   原幣含稅金額 本幣未稅金額(AR/AP使用) 本幣稅額(AR/AP使用) 本幣含稅金額(AR/AP使用)
               RETURNING l_xrcd103,    l_xrcd104, l_xrcd105,   l_xrcd113,              l_xrcd114,          l_xrcd115,
                         l_xrcd123,l_xrcd124,l_xrcd125,l_xrcd133,l_xrcd134,l_xrcd135
               IF g_rtib_d[l_ac].rtib010 != g_rtib_d_t.rtib010 THEN 
                  LET l_xrcd103 = s_curr_round(g_rtia_m.rtiasite,g_rtia_m.rtia026,l_xrcd103,'2')
                  UPDATE rtib_t SET rtib022 = l_xrcd103
                   WHERE rtibent = g_enterprise
                     AND rtibdocno = g_rtia_m.rtiadocno
                     AND rtibseq = g_rtib_d[l_ac].rtibseq
                  CASE
                     WHEN SQLCA.sqlcode #其他錯誤
                        INITIALIZE g_errparam TO NULL
                        LET g_errparam.code = SQLCA.sqlcode
                        LET g_errparam.extend = "rtib_t"
                        LET g_errparam.popup = TRUE
                        CALL cl_err()
  
                        CALL s_transaction_end('N','0')
                     OTHERWISE
                  END CASE
                  #寫折價
                  IF NOT artt622_ins_rtic2(g_rtib_d_t.rtibseq,g_rtib_d[l_ac].rtib021,g_rtib_d_t.rtib021,g_rtib_d[l_ac].rtib012) THEN
                     CALL s_transaction_end('N','0')
                  END IF 
                  UPDATE rtib_t SET rtib020 = g_rtib_d_t.rtib021 - g_rtib_d[l_ac].rtib021
                   WHERE rtibent = g_enterprise
                     AND rtibdocno = g_rtia_m.rtiadocno
                     AND rtibseq = g_rtib_d_t.rtibseq
               END IF 
            END IF
            
         AFTER ROW
            UPDATE rtia_t SET rtia031 = (SELECT SUM(rtib021)
                                           FROM rtib_t
                                          WHERE rtibent = g_enterprise
                                            AND rtibdocno = g_rtia_m.rtiadocno),
                              rtia049 = (SELECT SUM(rtib031)
                                           FROM rtib_t
                                          WHERE rtibent = g_enterprise
                                            AND rtibdocno = g_rtia_m.rtiadocno)
             WHERE rtiaent = g_enterprise
               AND rtiadocno = g_rtia_m.rtiadocno

            CALL artt622_unlock_b("rtib_t","'1'")
            CALL s_transaction_end('Y','0')
              
         AFTER INPUT

         ON ACTION accept 
            ACCEPT INPUT
           
         ON ACTION cancel 
            LET INT_FLAG = TRUE 
            EXIT INPUT
    END INPUT 
    CALL cl_set_comp_entry('rtib010',FALSE)
    CALL cl_set_comp_entry("rtibseq,rtib003,rtib004,rtib012,rtib024,rtib025,rtib026,rtib027,rtib028,rtib032,rtib033",TRUE)
    SELECT SUM(rtib012),SUM(rtib008*rtib017),SUM(rtib020),SUM(rtib021)
      INTO g_rtia_m.snum,g_rtia_m.amount,g_rtia_m.amount2,g_rtia_m.amount3
      FROM rtib_t
     WHERE rtibent = g_enterprise
       AND rtibdocno = g_rtia_m.rtiadocno
    DISPLAY g_rtia_m.snum TO FORMONLY.snum  
    DISPLAY g_rtia_m.amount TO FORMONLY.amount
    DISPLAY g_rtia_m.amount2 TO FORMONLY.amount2
    DISPLAY g_rtia_m.amount3 TO FORMONLY.amount3
END FUNCTION

################################################################################
# Memo...........:
# Usage..........: CALL artt500_ins_rtic(p_rtibseq,p_rtib021,p_rtib021_t,p_num)
#                  RETURNING r_success
# Input parameter: p_rtibseq      项次
#                : p_rtib021      销售金额
#                : p_price        原销售金额
#                : p_num          数量
#                : p_mmea010      加值金額
#                : p_mmea010_t    原加值金額
# Return code....: r_success      处理状态
# Date & Author..: 2015/06/28 By yangxf 
# Modify.........:
################################################################################
PRIVATE FUNCTION artt622_ins_rtic2(p_rtibseq,p_rtib021,p_rtib021_t,p_num)
DEFINE p_rtibseq   LIKE rtib_t.rtibseq
DEFINE p_rtib021   LIKE rtib_t.rtib021
DEFINE p_rtib021_t LIKE rtib_t.rtib021
DEFINE p_num       LIKE rtib_t.rtib012
#DEFINE l_rtic      RECORD LIKE rtic_t.*  #161111-00028#3--mark
#161111-00028#3-add--begin---------
DEFINE l_rtic RECORD  #銷售交易折扣明細檔
       rticent LIKE rtic_t.rticent, #企業編號
       rticsite LIKE rtic_t.rticsite, #營運據點
       rticunit LIKE rtic_t.rticunit, #應用組織
       rticdocno LIKE rtic_t.rticdocno, #單據編號
       rticseq LIKE rtic_t.rticseq, #項次
       rticseq1 LIKE rtic_t.rticseq1, #折扣序
       rtic001 LIKE rtic_t.rtic001, #單據類型
       rtic002 LIKE rtic_t.rtic002, #折價方式
       rtic003 LIKE rtic_t.rtic003, #促銷規則
       rtic004 LIKE rtic_t.rtic004, #活動類別
       rtic005 LIKE rtic_t.rtic005, #活動子類別
       rtic006 LIKE rtic_t.rtic006, #促銷方式
       rtic007 LIKE rtic_t.rtic007, #入機方式
       rtic008 LIKE rtic_t.rtic008, #參與數量
       rtic009 LIKE rtic_t.rtic009, #參與金額
       rtic010 LIKE rtic_t.rtic010, #贈送基數
       rtic011 LIKE rtic_t.rtic011, #贈送幅度
       rtic012 LIKE rtic_t.rtic012, #折扣率
       rtic013 LIKE rtic_t.rtic013, #折讓金額
       rtic014 LIKE rtic_t.rtic014, #贈卡券種
       rtic015 LIKE rtic_t.rtic015, #贈卡券號
       rtic016 LIKE rtic_t.rtic016, #贈送面額
       rtic017 LIKE rtic_t.rtic017, #贈送面額單位金額
       rtic018 LIKE rtic_t.rtic018, #接卡券種
       rtic019 LIKE rtic_t.rtic019, #接卡券號
       rtic020 LIKE rtic_t.rtic020, #接收基數
       rtic021 LIKE rtic_t.rtic021, #接收幅度
       rtic022 LIKE rtic_t.rtic022, #接收面額
       rtic023 LIKE rtic_t.rtic023, #接收面額單位金額
       rtic024 LIKE rtic_t.rtic024, #接卡券折扣率
       rtic025 LIKE rtic_t.rtic025, #來源類型
       rtic026 LIKE rtic_t.rtic026, #來源單號
       rtic027 LIKE rtic_t.rtic027, #來源折價方式
       rtic028 LIKE rtic_t.rtic028, #承擔比例
       rtic029 LIKE rtic_t.rtic029  #轉費用否
       END RECORD
#161111-00028#3--add--end---------- 
DEFINE r_success   LIKE type_t.num5

   LET r_success = TRUE 
   #写入折价明细
   LET l_rtic.rticent   = g_enterprise                     #企業編號
   LET l_rtic.rticsite  = g_rtia_m.rtiasite                #營運據點
   LET l_rtic.rticunit  = g_rtia_m.rtiasite                #應用組織
   LET l_rtic.rticdocno = g_rtia_m.rtiadocno               #單據編號
   LET l_rtic.rticseq   = p_rtibseq                        #項次
   SELECT max(rticseq1) + 1 INTO l_rtic.rticseq1
     FROM rtic_t
    WHERE rticent = g_enterprise
      AND rticdocno = g_rtia_m.rtiadocno
      AND rticseq = p_rtibseq
   IF cl_null(l_rtic.rticseq1) THEN 
      LET l_rtic.rticseq1  = 1                             #折扣序
   END IF
   LET l_rtic.rtic001   = g_prog                           #單據類型 1.訂單 2.銷售單 3.銷退單 暂给程序编号
   LET l_rtic.rtic002   = '10'                             #折價方式 scc=6708 1.促銷特價 2.捆綁特價 3.削價特價 4.會員價 5.一般促銷 6.組合促銷 7.滿額滿量促銷 8.換贈
   LET l_rtic.rtic003   = ''                               #促銷規則
   LET l_rtic.rtic004   = ''                               #活動類別
   LET l_rtic.rtic005   = ''                               #活動子類別
   LET l_rtic.rtic006   = ''                               #促銷方式
   LET l_rtic.rtic007   = ''                               #入机方式
   LET l_rtic.rtic008   = p_num                            #參與數量
   LET l_rtic.rtic009   = p_rtib021_t                      #參與金額
   LET l_rtic.rtic010   = p_rtib021_t                      #贈送基數
   LET l_rtic.rtic012 = p_rtib021/(p_rtib021_t)*100        #折扣率
   LET l_rtic.rtic011 =  p_rtib021_t                       #贈送幅度
   LET l_rtic.rtic013 =  p_rtib021_t - p_rtib021           #折讓金額
   LET l_rtic.rtic014   = ''                               #贈卡券種
   LET l_rtic.rtic015   = ''                               #贈卡券號
   LET l_rtic.rtic016   = ''                               #贈送面額
   LET l_rtic.rtic017   = ''                               #贈送面額單位金額
   LET l_rtic.rtic018   = ''                               #接卡券種
   LET l_rtic.rtic019   = ''                               #接卡券號
   LET l_rtic.rtic020   = ''                               #接收基數
   LET l_rtic.rtic021   = ''                               #接收幅度
   LET l_rtic.rtic022   = ''                               #接收面額
   LET l_rtic.rtic023   = ''                               #接收面額單位金額
   LET l_rtic.rtic024   = ''                               #接卡券折扣率
   LET l_rtic.rtic025   = ''                               #來源類型
   LET l_rtic.rtic026   = ''                               #來源單號
   LET l_rtic.rtic027   = ''                               #來源折價方式
   LET l_rtic.rtic011 = s_curr_round(g_rtia_m.rtiasite,g_rtia_m.rtia026,l_rtic.rtic011,'2')
   LET l_rtic.rtic012 = s_curr_round(g_rtia_m.rtiasite,g_rtia_m.rtia026,l_rtic.rtic012,'1')
   LET l_rtic.rtic013 = s_curr_round(g_rtia_m.rtiasite,g_rtia_m.rtia026,l_rtic.rtic013,'2')
   #写入数据库
   #INSERT INTO rtic_t VALUES (l_rtic.*)  #161111-00028#3--mark
   #161111-00028#3--add--begin----------
   INSERT INTO rtic_t (rticent,rticsite,rticunit,rticdocno,rticseq,rticseq1,rtic001,rtic002,rtic003,rtic004,rtic005,
                       rtic006,rtic007,rtic008,rtic009,rtic010,rtic011,rtic012,rtic013,rtic014,rtic015,rtic016,
                       rtic017,rtic018,rtic019,rtic020,rtic021,rtic022,rtic023,rtic024,rtic025,rtic026,rtic027,
                       rtic028,rtic029)
     VALUES (l_rtic.rticent,l_rtic.rticsite,l_rtic.rticunit,l_rtic.rticdocno,l_rtic.rticseq,l_rtic.rticseq1,
             l_rtic.rtic001,l_rtic.rtic002,l_rtic.rtic003,l_rtic.rtic004,l_rtic.rtic005,l_rtic.rtic006,
             l_rtic.rtic007,l_rtic.rtic008,l_rtic.rtic009,l_rtic.rtic010,l_rtic.rtic011,l_rtic.rtic012,
             l_rtic.rtic013,l_rtic.rtic014,l_rtic.rtic015,l_rtic.rtic016,l_rtic.rtic017,l_rtic.rtic018,
             l_rtic.rtic019,l_rtic.rtic020,l_rtic.rtic021,l_rtic.rtic022,l_rtic.rtic023,l_rtic.rtic024,
             l_rtic.rtic025,l_rtic.rtic026,l_rtic.rtic027,l_rtic.rtic028,l_rtic.rtic029)
   #161111-00028#3--add--end----------
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = 'ins rtic_t'
      LET g_errparam.popup = TRUE
      CALL cl_err()
      LET r_success = FALSE
      RETURN r_success
   END IF
   RETURN r_success 
END FUNCTION

################################################################################
# Descriptions...: 积分判断
# Memo...........:
# Usage..........: CALL artt622_point_chk()
# Input parameter: 无
# Return code....: 无
# Date & Author..: 2016/06/17 By geza
# Modify.........:
################################################################################
PRIVATE FUNCTION artt622_point_chk()
DEFINE r_success   LIKE type_t.num5
DEFINE l_price1    LIKE rtib_t.rtib008
DEFINE l_ooef016   LIKE ooef_t.ooef016   #add by yangxf
DEFINE l_rtib018   LIKE rtib_t.rtib108   #add by yangxf
DEFINE l_rtib106   LIKE rtib_t.rtib106
DEFINE l_rtib107   LIKE rtib_t.rtib107
 
   LET r_success = TRUE
   IF cl_null(g_rtib_d[l_ac].rtibseq) OR cl_null(g_rtib_d[l_ac].rtib003) OR cl_null(g_rtib_d[l_ac].rtib004) OR cl_null(g_rtib_d[l_ac].rtib012) THEN
      RETURN r_success
   END IF

   SELECT rtdx101,rtdx102 ##INTO g_rtib_d[l_ac].rtib106,g_rtib_d[l_ac].rtib107
   INTO l_rtib106,l_rtib107
     FROM rtdx_t
    WHERE rtdxent = g_enterprise
      AND rtdx001 = g_rtib_d[l_ac].rtib004
      AND rtdxsite = g_rtia_m.rtiasite
      AND rtdxstus = 'Y'
   IF g_rtib_d[l_ac].rtib106 IS NULL THEN 
      LET g_rtib_d[l_ac].rtib106=l_rtib106
      LET g_rtib_d[l_ac].rtib107=l_rtib107
   ELSE
   
   END IF 
   IF g_rtib_d[l_ac].rtib106 IS NULL THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'art-00784'
      LET g_errparam.extend = ''
      LET g_errparam.popup = TRUE
      CALL cl_err()

      LET r_success = FALSE
      RETURN r_success
   END IF
   IF g_rtib_d[l_ac].rtib106 IS NULL THEN
      LET g_rtib_d[l_ac].rtib106 = 0 
   END IF
   IF g_rtib_d[l_ac].rtib107 IS NULL THEN
      LET g_rtib_d[l_ac].rtib107 = 0 
   END IF
   LET g_rtib_d[l_ac].rtib107 = ''  
   LET g_rtib_d[l_ac].rtib108 = g_rtib_d[l_ac].rtib106 * g_rtib_d[l_ac].rtib012 
   #160604-00009#85--dongsz add--s
   IF g_rtib_d[l_ac].rtib042 = '2' THEN
      LET g_rtib_d[l_ac].rtib108 = g_rtib_d[l_ac].rtib106 * g_rtib_d[l_ac].rtib012 * (-1)
   END IF
   #160604-00009#85--dongsz add--e   
   SELECT SUM(rtib108) INTO l_rtib018
     FROM rtib_t
    WHERE rtibent = g_enterprise
      AND rtibdocno = g_rtia_m.rtiadocno
      AND rtibseq <> g_rtib_d[l_ac].rtibseq
   IF l_rtib018 IS NULL THEN
      LET l_rtib018 = 0 
   END IF
   IF l_rtib018+g_rtib_d[l_ac].rtib108 > g_rtia_m.rtia043 THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'wss-00130'
      LET g_errparam.extend = ''
      LET g_errparam.popup = TRUE
      CALL cl_err()

      LET r_success = FALSE
      RETURN r_success
   END IF
   RETURN r_success
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
PRIVATE FUNCTION artt622_tmq()
define l_m   int
DEFINE l_imaystus   LIKE imay_t.imaystus
define l_oodb011   like oodb_t.oodb011
DEFINE r_success    LIKE type_t.num5
DEFINE l_success   LIKE type_t.num5
DEFINE l_price1    LIKE rtib_t.rtib008
DEFINE l_ooef016   LIKE ooef_t.ooef016   #add by yangxf
DEFINE l_imaa108   LIKE imaa_t.imaa108   #add by yangxf
# DEFINE l_rtib     RECORD LIKE rtib_t.*  #161111-00028#3--MARK
#161111-00028#3--ADD----BEGIN-----------
DEFINE l_rtib RECORD  #銷售交易商品明細檔
       rtibent LIKE rtib_t.rtibent, #企業編號
       rtibsite LIKE rtib_t.rtibsite, #營運據點
       rtibunit LIKE rtib_t.rtibunit, #應用組織
       rtiborga LIKE rtib_t.rtiborga, #帳務組織
       rtibdocno LIKE rtib_t.rtibdocno, #單據編號
       rtibseq LIKE rtib_t.rtibseq, #項次
       rtib001 LIKE rtib_t.rtib001, #來源單號
       rtib002 LIKE rtib_t.rtib002, #來源單號項次
       rtib003 LIKE rtib_t.rtib003, #商品條碼
       rtib004 LIKE rtib_t.rtib004, #商品編號
       rtib005 LIKE rtib_t.rtib005, #特徵碼
       rtib006 LIKE rtib_t.rtib006, #稅別編號
       rtib007 LIKE rtib_t.rtib007, #銷售開立發票
       rtib008 LIKE rtib_t.rtib008, #標準售價
       rtib009 LIKE rtib_t.rtib009, #促銷售價
       rtib010 LIKE rtib_t.rtib010, #交易售價
       rtib011 LIKE rtib_t.rtib011, #成本售價
       rtib012 LIKE rtib_t.rtib012, #銷售數量
       rtib013 LIKE rtib_t.rtib013, #銷售單位
       rtib014 LIKE rtib_t.rtib014, #庫存數量
       rtib015 LIKE rtib_t.rtib015, #庫存單位
       rtib016 LIKE rtib_t.rtib016, #銷售庫存單位換算率
       rtib017 LIKE rtib_t.rtib017, #計價數量
       rtib018 LIKE rtib_t.rtib018, #計價單位
       rtib019 LIKE rtib_t.rtib019, #銷售計價單位換算率
       rtib020 LIKE rtib_t.rtib020, #折價金額
       rtib021 LIKE rtib_t.rtib021, #應收金額
       rtib022 LIKE rtib_t.rtib022, #未稅金額
       rtib023 LIKE rtib_t.rtib023, #成本金額
       rtib024 LIKE rtib_t.rtib024, #理由碼
       rtib025 LIKE rtib_t.rtib025, #庫區
       rtib026 LIKE rtib_t.rtib026, #儲位
       rtib027 LIKE rtib_t.rtib027, #批號
       rtib028 LIKE rtib_t.rtib028, #專櫃編號
       rtib029 LIKE rtib_t.rtib029, #分攤積點
       rtib030 LIKE rtib_t.rtib030, #卡券銷售明細對應項次
       rtib031 LIKE rtib_t.rtib031, #本幣應收金額
       rtib032 LIKE rtib_t.rtib032, #庫存管理特徵
       rtib033 LIKE rtib_t.rtib033, #營業員
       rtib034 LIKE rtib_t.rtib034, #掃描碼
       rtib035 LIKE rtib_t.rtib035, #交易類型
       rtib036 LIKE rtib_t.rtib036, #商品屬性
       rtib037 LIKE rtib_t.rtib037, #捆綁條碼項次
       rtib038 LIKE rtib_t.rtib038, #結算扣率
       rtib039 LIKE rtib_t.rtib039, #贈品否
       rtib040 LIKE rtib_t.rtib040, #卡種/券種編號
       rtib041 LIKE rtib_t.rtib041, #卡號/券號
       rtib101 LIKE rtib_t.rtib101, #退貨退回商品(租賃)
       rtib102 LIKE rtib_t.rtib102, #產品品類(租賃)
       rtib103 LIKE rtib_t.rtib103, #品牌(租賃)
       rtib104 LIKE rtib_t.rtib104, #商戶編號(租賃)
       rtib105 LIKE rtib_t.rtib105, #合約編號(租賃)
       rtib106 LIKE rtib_t.rtib106, #單位兌換積分
       rtib107 LIKE rtib_t.rtib107, #促銷單位兌換積分
       rtib108 LIKE rtib_t.rtib108, #總兌換積分
       rtib042 LIKE rtib_t.rtib042, #退貨方式
       rtib043 LIKE rtib_t.rtib043, #發票編號
       rtib044 LIKE rtib_t.rtib044, #發票號碼
       rtib109 LIKE rtib_t.rtib109  #返現
       END RECORD
#161111-00028#3--ADD----END-------------
define l_suc       LIKE type_t.num5
define l_l   int 
DEFINE l_set_entry            LIKE type_t.num5 
DEFINE l_rate      LIKE inaj_t.inaj014
define l_rtim012  like rtim_t.rtim012
define l_rtib012   like rtib_t.rtib012
DEFINE l_rtib018   like rtib_t.rtib018
DEFINE l_rate1     LIKE inaj_t.inaj014
DEFINE l_xrcd103   LIKE xrcd_t.xrcd103,
          l_xrcd104   LIKE xrcd_t.xrcd104,
          l_xrcd105   LIKE xrcd_t.xrcd105,
          l_xrcd113   LIKE xrcd_t.xrcd113,
          l_xrcd114   LIKE xrcd_t.xrcd114,
          l_xrcd115   LIKE xrcd_t.xrcd115,
          l_imaa005   LIKE imaa_t.imaa005,
          l_xrcd123   LIKE xrcd_t.xrcd113,
          l_xrcd124   LIKE xrcd_t.xrcd114,
          l_xrcd125   LIKE xrcd_t.xrcd115,
          l_xrcd133   LIKE xrcd_t.xrcd113,
          l_xrcd134   LIKE xrcd_t.xrcd114,
          l_xrcd135   LIKE xrcd_t.xrcd115
      let l_suc=1
    INITIALIZE l_rtib.* TO NULL
     SELECT max(rtibseq) into l_m from rtib_t where rtibent=g_enterprise  and rtibdocno=g_rtia_m.rtiadocno
     if cl_null(l_m) then 
       let l_m=0
     end if 
     SELECT COUNT (*) INTO l_l FROM rtib_t WHERE rtibent=g_enterprise  AND rtibdocno=g_rtia_m.rtiadocno AND rtib003=g_barcode and rtib035=g_chantype
     IF l_l=0 THEN
       let l_rtib.rtibseq=l_m+1
       let l_rtib.rtib003=g_barcode
     let l_rtib.rtib035=g_chantype
     if l_rtib.rtib035='2' then 
        let l_rtib.rtib042='1'
        let l_rtib.rtib012=-1
     else
        let l_rtib.rtib042=''
        let l_rtib.rtib012=1
     end if 
     SELECT imaystus INTO l_imaystus
        FROM imay_t
       WHERE imayent = g_enterprise
         AND imay003 = l_rtib.rtib003
      CASE 
         WHEN SQLCA.SQLCODE = 100 LET g_errno = 'art-00046'
         WHEN l_imaystus <> 'Y'   LET g_errno = 'art-00047'
         OTHERWISE                LET g_errno = SQLCA.SQLCODE USING '-------'
      END CASE
     IF NOT cl_null(g_errno) THEN
       INITIALIZE g_errparam TO NULL
       LET g_errparam.code = g_errno
       LET g_errparam.extend = ''
       LET g_errparam.popup = TRUE
       CALL cl_err()
       let l_suc=0
       return l_suc
     END IF
     SELECT DISTINCT imay001 
     INTO l_rtib.rtib004
     FROM imay_t
     WHERE imayent = g_enterprise
      AND imay003 = g_barcode
      SELECT oodb011 INTO l_oodb011
     FROM oodb_t,ooef_t
    WHERE oodbent = ooefent
      AND oodb001 = ooef019
      AND oodb002 = g_rtia_m.rtia028
      AND ooef001 = g_rtia_m.rtiasite   
   IF l_oodb011 = '1' THEN 
      LET l_rtib.rtib006 = g_rtia_m.rtia028
   ELSE
      #带出税别
      SELECT rtdx014 INTO l_rtib.rtib006
        FROM rtdx_t
       WHERE rtdxent = g_enterprise 
         AND rtdxsite = g_rtia_m.rtiasite
         AND rtdx001 = l_rtib.rtib004               
   END IF    
       SELECT imay004,imay012,imay014
         INTO l_rtib.rtib013,l_rtib.rtib018,l_rtib.rtib015
         FROM imay_t
        WHERE imayent = g_enterprise
          AND imay001 = l_rtib.rtib004
          AND imay003 = g_barcode
      
   #获取商品特征码
   SELECT imaa005 INTO l_rtib.rtib005
     FROM imaa_t
    WHERE imaaent = g_enterprise
      AND imaa001 = l_rtib.rtib004
   LET l_rtib.rtib025 = '' 
   LET l_rtib.rtib026 = ''
   LET l_rtib.rtib027 = ''

   SELECT rtdx044 INTO l_rtib.rtib025
     FROM rtdx_t 
    WHERE rtdxent = g_enterprise
      AND rtdxsite = g_rtia_m.rtiasite
      AND rtdx001 = l_rtib.rtib004

     #检查生命周期有效性
      CALL s_life_cycle_chk(g_prog,g_rtia_m.rtiasite,'1',l_rtib.rtib004,'','') RETURNING r_success    #150616-00035#78-add by dongsz                  
      IF r_success = FALSE THEN 
         #NEXT FIELD CURRENT
      END IF               

   CALL s_aimi190_get_convert(l_rtib.rtib004,l_rtib.rtib013,l_rtib.rtib015) RETURNING l_success,l_rate
   IF NOT l_success THEN 
      let l_suc=0
       return l_suc
   END IF
   CALL s_aooi250_convert_qty(l_rtib.rtib004,l_rtib.rtib013,l_rtib.rtib015,l_rtib.rtib012) RETURNING l_success,l_rtib.rtib014
   IF NOT l_success THEN 
       let l_suc=0
       return l_suc
   END IF   
   #计算销售单位与计价单位转换率
   CALL s_aimi190_get_convert(l_rtib.rtib004,l_rtib.rtib013,l_rtib.rtib018) RETURNING l_success,l_rate1
   IF NOT l_success THEN 
      let l_suc=0
       return l_suc
   END IF
   CALL s_aooi250_convert_qty(l_rtib.rtib004,l_rtib.rtib013,l_rtib.rtib018,l_rtib.rtib012) RETURNING l_success,l_rtib.rtib017
   IF NOT l_success THEN 
     let l_suc=0
       return l_suc
   END IF   
   LET l_rtib.rtib016 = l_rate
   LET l_rtib.rtib019 = l_rate1
 
   #add by yangxf ---end----
   CALL s_get_price('2',g_rtia_m.rtiadocno,g_rtia_m.rtiadocdt,l_rtib.rtibseq,g_rtia_m.rtia002,g_rtia_m.rtia001,l_rtib.rtib004,l_rtib.rtib003,l_rtib.rtib018,l_rtib.rtib017,'1')
      RETURNING l_success,l_rtib.rtib008,l_price1,l_rtib.rtib009,l_rtib.rtib010
   LET l_rtib.rtib008 = 0
   LET l_rtib.rtib009 = 0
   LET l_rtib.rtib010 = 0  
   IF NOT cl_null(l_rtib.rtib010) AND NOT cl_null(l_rtib.rtib017) THEN     
      #应收金额 = 交易价*计价数量
      LET l_rtib.rtib021 =l_rtib.rtib010 * l_rtib.rtib017
      LET l_rtib.rtib021 = s_curr_round(g_rtia_m.rtiasite,g_rtia_m.rtia026,l_rtib.rtib021,'2')
      #计算本币应收金额
      LET l_rtib.rtib031 = l_rtib.rtib021 * g_rtia_m.rtia027
      SELECT ooef016 INTO l_ooef016
        FROM ooef_t
       WHERE ooefent = g_enterprise
         AND ooef001 = g_rtia_m.rtiasite
      LET l_rtib.rtib031 = s_curr_round(g_rtia_m.rtiasite,l_ooef016,l_rtib.rtib031,'2')
     END IF
      SELECT rtdx101,rtdx102 INTO l_rtib.rtib106,l_rtib.rtib107
     FROM rtdx_t
    WHERE rtdxent = g_enterprise
      AND rtdx001 = l_rtib.rtib004
      AND rtdxsite = g_rtia_m.rtiasite
      AND rtdxstus = 'Y'
   IF l_rtib.rtib106 IS NULL THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'art-00784'
      LET g_errparam.extend = ''
      LET g_errparam.popup = TRUE
      CALL cl_err()
      let l_suc=0
       return l_suc
   END IF
 IF l_rtib.rtib106 IS NULL THEN
      LET l_rtib.rtib106 = 0 
   END IF
   IF l_rtib.rtib107 IS NULL THEN
      LET l_rtib.rtib107 = 0 
   END IF
   LET l_rtib.rtib107 = '' 

     LET l_rtib.rtib108 = l_rtib.rtib106 * l_rtib.rtib012
   #160604-00009#85--dongsz add--s
   IF l_rtib.rtib042 = '2' THEN
      LET l_rtib.rtib108 = l_rtib.rtib106 * l_rtib.rtib012 * (-1)
   END IF
   #160604-00009#85--dongsz add--e   
   SELECT SUM(rtib108) INTO l_rtib018
     FROM rtib_t
    WHERE rtibent = g_enterprise
      AND rtibdocno = g_rtia_m.rtiadocno
      AND rtibseq <> l_rtib.rtibseq
   IF l_rtib018 IS NULL THEN
      LET l_rtib018 = 0 
   END IF
   IF l_rtib018+l_rtib.rtib108 > g_rtia_m.rtia043 THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'wss-00130'
      LET g_errparam.extend = ''
      LET g_errparam.popup = TRUE
      CALL cl_err()
      let l_suc=0
      return l_suc

      #NEXT FIELD CURRENT
   END IF     
      LET l_success = ''  
      LET l_set_entry = ''
      CALL s_lot_out_entry(-1,g_rtia_m.rtiadocno,g_rtia_m.rtiasite,l_rtib.rtib004)   
            RETURNING l_success,l_set_entry
     # SELECT rtim012 INTO l_rtim012
      #  FROM rtim_t
      # WHERE rtiment = g_enterprise
       #  AND rtimdocno = l_rtib.rtib001
       # AND rtimseq = l_rtib.rtib002
     # IF cl_null(l_rtim012) THEN 
      #   LET l_rtim012 = 0
     # END IF
     # SELECT SUM(rtib012) INTO l_rtib012
      #  FROM rtib_t,rtia_t
      # WHERE rtib001 = l_rtib.rtib001
       #  AND rtib002 = l_rtib.rtib002
        # AND rtiaent = rtibent
        # AND rtiadocno = rtibdocno
        # AND rtiaent = g_enterprise
        # AND rtiastus <> 'X'
     # IF cl_null(l_rtib012) THEN 
      #   LET l_rtib012 = 0
     # END IF 
     # LET l_rtib.rtib012 = l_rtim012 - l_rtib012     #150424-00020#2--add by dongsz
     ## IF l_rtib.rtib012 <=0 THEN 
       #  LET l_rtib.rtib012 = 0
     # END IF 

     # CALL s_aooi250_convert_qty(l_rtib.rtib004,l_rtib.rtib013,l_rtib.rtib018,l_rtib.rtib012)
      #     RETURNING l_success,l_rtib.rtib017
      #庫存數量
     # CALL s_aooi250_convert_qty(l_rtib.rtib004,l_rtib.rtib013,l_rtib.rtib015,l_rtib.rtib012)
      #     RETURNING l_success,l_rtib.rtib014
      #应收金额 = 交易价*计价数量
      LET l_rtib.rtib021 = l_rtib.rtib010 * l_rtib.rtib017
      LET l_rtib.rtib021 = s_curr_round(g_rtia_m.rtiasite,g_rtia_m.rtia026,l_rtib.rtib021,'2')
      #计算本币应收金额
     # LET l_rtib.rtib031 = l_rtib.rtib021 * g_rtia_m.rtia027
    if g_chantype='2' then 
      SELECT rtdx044 INTO l_rtib.rtib025
        FROM rtdx_t 
       WHERE rtdxent = g_enterprise
         AND rtdxsite = g_rtia_m.rtiasite
         AND rtdx001 = l_rtib.rtib004
      SELECT inag005,inag006
        INTO l_rtib.rtib026,l_rtib.rtib027
        FROM inag_t
       WHERE inagent = g_enterprise
         AND inagsite = g_rtia_m.rtiasite
         AND inag004 = l_rtib.rtib025
         AND inag001 = l_rtib.rtib004
    end if             

       INSERT INTO rtib_t
                  (rtibent,rtibdocno,rtibseq,rtibsite,rtibunit,
                   rtiborga,rtib035,rtib042,rtib001,rtib002,
                   rtib003,rtib004,rtib005,rtib013,rtib106,
                   rtib107,rtib012,rtib108,rtib008,rtib009,
                   rtib010,rtib014,rtib015,rtib016,rtib018,
                   rtib017,rtib019,rtib020,rtib021,rtib031,
                   rtib022,rtib024,rtib025,rtib026,rtib027,
                   rtib032,rtib033,rtib028,rtib030,rtib039,
                   rtib006) 
            VALUES(g_enterprise,g_rtia_m.rtiadocno,l_rtib.rtibseq,g_rtia_m.rtiasite,g_rtia_m.rtiasite,
                   g_rtia_m.rtiasite,l_rtib.rtib035,l_rtib.rtib042,'','',
                   g_barcode,l_rtib.rtib004,l_rtib.rtib005,l_rtib.rtib013,l_rtib.rtib106, 
                   l_rtib.rtib107,l_rtib.rtib012,l_rtib.rtib108,l_rtib.rtib008,l_rtib.rtib009,
                   l_rtib.rtib010,l_rtib.rtib014,l_rtib.rtib015,l_rtib.rtib016,l_rtib.rtib018,
                   l_rtib.rtib017,l_rtib.rtib019,l_rtib.rtib020,l_rtib.rtib021,l_rtib.rtib031, 
                   l_rtib.rtib022,l_rtib.rtib024,l_rtib.rtib025,l_rtib.rtib026,l_rtib.rtib027,
                   l_rtib.rtib032,l_rtib.rtib033,l_rtib.rtib028,l_rtib.rtib030,l_rtib.rtib039,l_rtib.rtib006)
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "rtib_t:",SQLERRMESSAGE 
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = FALSE 
         CALL cl_err()
         let l_suc=0
          return l_suc
      END IF
      
     CALL s_tax_ins(g_rtia_m.rtiadocno,l_rtib.rtibseq,'0',   g_rtia_m.rtiasite,l_rtib.rtib021,
                     #稅別                          數量                           幣別             匯率             帳套  匯率2 匯率3
                     l_rtib.rtib006,l_rtib.rtib017,g_rtia_m.rtia026,g_rtia_m.rtia027,' ',' ',  ' ')
                #原幣未稅金額 原幣稅額   原幣含稅金額 本幣未稅金額(AR/AP使用) 本幣稅額(AR/AP使用) 本幣含稅金額(AR/AP使用)
      RETURNING l_xrcd103,    l_xrcd104, l_xrcd105,   l_xrcd113,              l_xrcd114,          l_xrcd115,
                l_xrcd123,l_xrcd124,l_xrcd125,l_xrcd133,l_xrcd134,l_xrcd135

      UPDATE rtib_t SET rtib022 = l_xrcd103
       WHERE rtibent = g_enterprise
         AND rtibdocno = g_rtia_m.rtiasite
         AND rtibseq = l_rtib.rtibseq
      CASE
         WHEN SQLCA.sqlcode #其他錯誤
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = SQLCA.sqlcode
            LET g_errparam.extend = "rtib_t"
            LET g_errparam.popup = TRUE
            CALL cl_err()
            let l_suc=0
            return l_suc
            #CALL s_transaction_end('N','0')
         OTHERWISE
      END CASE
        # IF l_rtib.rtib012 < 0 AND cl_null(l_rtib.rtib027) THEN
        #          LET l_success = ''
       #           CALL s_lot_out_get_batch_no(l_rtib.rtib004)
        #             RETURNING l_success,l_rtib.rtib027
         #         IF l_success = FALSE THEN
          #           let l_suc=0
           #         return l_suc                 
            #      END IF
             #  END IF
               #150819-00004#1 150819 By pomelo add(E)
               #更新多库儲批明細
               CALL s_artt622_rtin_modify('a',g_rtia_m.rtiasite,g_rtia_m.rtiadocno,l_rtib.rtibseq,'',l_rtib.rtib004,l_rtib.rtib005,
                                          g_prog,'',l_rtib.rtib025,l_rtib.rtib026,l_rtib.rtib027,l_rtib.rtib013,l_rtib.rtib012,l_rtib.rtib032) RETURNING l_success
            IF NOT l_success THEN
              let l_suc=0
                return l_suc                 
            END IF
              RETURN  l_suc
     ELSE 
      # SELECT rtib012,rtib106,rtibseq,rtib010,rtib006,rtib026,rtib027,rtib035 
       #INTO  l_rtib.rtib012,l_rtib.rtib106,l_rtib.rtibseq,l_rtib.rtib010,l_rtib.rtib006,l_rtib.rtib026,l_rtib.rtib027,l_rtib.rtib035 
      # FROM rtib_t
      # WHERE rtibent=g_enterprise  AND rtibdocno=g_rtia_m.rtiadocno AND rtib003=g_barcode
     SELECT rtib004,rtib005,rtib012,rtib013,rtib106,rtibseq,rtib010,rtib006,rtib025,rtib026,rtib027,rtib032,rtib035,rtib015,rtib018
       INTO  l_rtib.rtib004,l_rtib.rtib005,l_rtib.rtib012,l_rtib.rtib013,l_rtib.rtib106,l_rtib.rtibseq,l_rtib.rtib010,l_rtib.rtib006,l_rtib.rtib025,l_rtib.rtib026,l_rtib.rtib027,l_rtib.rtib032,l_rtib.rtib035,l_rtib.rtib015,l_rtib.rtib018 
       FROM rtib_t
       WHERE rtibent=g_enterprise  AND rtibdocno=g_rtia_m.rtiadocno AND rtib003=g_barcode  and rtib035=g_chantype
       if l_rtib.rtib035='1'  then
         LET l_rtib.rtib012= l_rtib.rtib012+1
         #LET l_rtib.rtib017=l_rtib.rtib012        
         #LET l_rtib.rtib021=l_rtib.rtib010*l_rtib.rtib017
       else
         LET l_rtib.rtib012= l_rtib.rtib012-1
         #LET l_rtib.rtib017=l_rtib.rtib012
         #LET l_rtib.rtib021=l_rtib.rtib010*l_rtib.rtib017
       end if

          LET l_rtib.rtib108=l_rtib.rtib106*l_rtib.rtib012
        SELECT SUM(rtib108) INTO l_rtib018
        FROM rtib_t
       WHERE rtibent = g_enterprise
         AND rtibdocno = g_rtia_m.rtiadocno
         AND rtibseq <> l_rtib.rtibseq
      IF l_rtib018 IS NULL THEN
          LET l_rtib018 = 0 
       END IF
      IF l_rtib018+l_rtib.rtib108 > g_rtia_m.rtia043 THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = 'wss-00130'
         LET g_errparam.extend = ''
         LET g_errparam.popup = TRUE
         CALL cl_err()
         let l_suc=0
         return l_suc

       END IF     
       CALL s_artt622_rtin_modify('u',g_rtia_m.rtiasite,g_rtia_m.rtiadocno,l_rtib.rtibseq,l_rtib.rtibseq,l_rtib.rtib004,l_rtib.rtib005,
                                          g_prog,'',l_rtib.rtib025,l_rtib.rtib026,l_rtib.rtib027,l_rtib.rtib013,l_rtib.rtib012,l_rtib.rtib032) RETURNING l_success
            IF NOT l_success THEN
              let l_suc=0
                return l_suc                 
            END IF
       CALL s_aooi250_convert_qty(l_rtib.rtib004,l_rtib.rtib013,l_rtib.rtib015,l_rtib.rtib012) RETURNING l_success,l_rtib.rtib014
       IF NOT l_success THEN 
          let l_suc=0
          return l_suc
       END IF
       CALL s_aooi250_convert_qty(l_rtib.rtib004,l_rtib.rtib013,l_rtib.rtib018,l_rtib.rtib012) RETURNING l_success,l_rtib.rtib017
       IF NOT l_success THEN 
          let l_suc=0
          return l_suc
       END IF
       LET l_rtib.rtib021=l_rtib.rtib010*l_rtib.rtib017
       UPDATE rtib_t  SET rtib012=l_rtib.rtib012,
                          rtib108=l_rtib.rtib108,
                          rtib017=l_rtib.rtib017,
                          rtib021=l_rtib.rtib021,
                          rtib014=l_rtib.rtib014
       WHERE rtibent=g_enterprise  AND rtibdocno=g_rtia_m.rtiadocno AND rtib003=g_barcode and rtibseq=l_rtib.rtibseq
       CALL s_tax_ins(g_rtia_m.rtiadocno,l_rtib.rtibseq,'0',   g_rtia_m.rtiasite,l_rtib.rtib021,
                     #稅別                          數量                           幣別             匯率             帳套  匯率2 匯率3
                     l_rtib.rtib006,l_rtib.rtib017,g_rtia_m.rtia026,g_rtia_m.rtia027,' ',' ',  ' ')
                #原幣未稅金額 原幣稅額   原幣含稅金額 本幣未稅金額(AR/AP使用) 本幣稅額(AR/AP使用) 本幣含稅金額(AR/AP使用)
      RETURNING l_xrcd103,    l_xrcd104, l_xrcd105,   l_xrcd113,              l_xrcd114,          l_xrcd115,
                l_xrcd123,l_xrcd124,l_xrcd125,l_xrcd133,l_xrcd134,l_xrcd135

      UPDATE rtib_t SET rtib022 = l_xrcd103
       WHERE rtibent = g_enterprise
         AND rtibdocno = g_rtia_m.rtiasite
         AND rtibseq = l_rtib.rtibseq
      CASE
         WHEN SQLCA.sqlcode #其他錯誤
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = SQLCA.sqlcode
            LET g_errparam.extend = "rtib_t"
            LET g_errparam.popup = TRUE
            CALL cl_err()
            let l_suc=0
            return l_suc
            #CALL s_transaction_end('N','0')
         OTHERWISE
      END CASE
   END IF
   RETURN  l_suc
END FUNCTION

 
{</section>}
 
