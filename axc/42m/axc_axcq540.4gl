#該程式已解開Section, 不再透過樣板產出!
{<section id="axcq540.description" >}
#+ Version..: T100-ERP-1.00.00(SD版次:1,PR版次:1) Build-000017
#+ 
#+ Filename...: axcq540
#+ Description: 在製成本匯總查詢作業
#+ Creator....: 00537(2014-09-16 13:41:40)
#+ Modifier...: 00537(2014-09-18 09:33:31) -SD/PR- 02295
#+ Buildtype..: 應用 t01 樣板自動產生
#+ 以上段落由子樣板a00產生
 
{</section>}
 
{<section id="axcq540.global" >}
#151130  By Polly  151130-00003#2  增加二次蒒選功能
#160119  By Dorislai #160107-00023#1 browser_fill段新增library→cl_sql_add_filter("xcce_t")、cl_sql_add_filter("xcci_t")
#160628-00031#1  2016/06/28 By xianghui拆件在制的期初与期末数据不对
#160802-00020#4  2016/08/04 By dorislai   增加帳套權限管控
#160802-00020#10 2016/08/11 By dorislai   增加法人權限管控
#160812-00009#1  2016/08/12 By xianghui   月份比较时需先判断年度相同
#160813-00002#1  2016/09/10 By 02040     工單號一張會由多個成本域領料，因此拿掉工單單頭的成本域對單身的成本域的條件
#160201-00004#1  2017/01/22 By 02295 小計行顯示：小计-在制单号，小计-組織，應列出小計的具體在制單編號及組織名
#170123-00012#1  2017/02/06 By 02295 小计后面的料号+品名+规格不需要显示,组织小计改成合计
        
IMPORT os
IMPORT util
IMPORT FGL lib_cl_dlg
#add-point:增加匯入項目

#end add-point
 
SCHEMA ds 
 
GLOBALS "../../cfg/top_global.inc"
 
#add-point:增加匯入變數檔

#end add-point
 
#單頭 type 宣告
PRIVATE type type_g_xccd_m        RECORD
       xccdcomp LIKE xccd_t.xccdcomp, 
   xccdcomp_desc LIKE type_t.chr80, 
   xccdld LIKE xccd_t.xccdld, 
   xccdld_desc LIKE type_t.chr80, 
   xccd004 LIKE xccd_t.xccd004, 
   xccd005 LIKE xccd_t.xccd005, 
   xccd004_1 LIKE type_t.num5, 
   xccd005_1 LIKE type_t.num5, 
   xccd001 LIKE xccd_t.xccd001, 
   xccd001_desc LIKE type_t.chr80, 
   xccd003 LIKE xccd_t.xccd003, 
   xccd003_desc LIKE type_t.chr80
       END RECORD
 
#單身 type 宣告
PRIVATE TYPE type_g_xccd_d        RECORD
       #sfaa068 LIKE xcce_t.xcce006,     #故意改的，为了能放下“小计-组织”的汉字  #160201-00004#1 
       sfaa068 LIKE type_t.chr500,     #160201-00004#1 增加了栏位长度
   sfaa068_desc LIKE type_t.chr500, 
   #xccd006 LIKE xccd_t.xccd006,   #160201-00004#1  mark
   xccd006 LIKE type_t.chr500,     #160201-00004#1 增加了栏位长度
   xccd007 LIKE xccd_t.xccd007,          #fengmy150303
   xccd007_desc LIKE type_t.chr500,      #fengmy150303
   xccd007_desc_desc LIKE type_t.chr500, #fengmy150303
   xccd008 LIKE xccd_t.xccd008,          #liuym150810
   xccd301 LIKE xccd_t.xccd301,          #151202-00029 by whitney add
   xcce007 LIKE xcce_t.xcce007, 
   xcce007_desc LIKE type_t.chr500, 
   xcce007_desc_1 LIKE type_t.chr500, 
   xcce008 LIKE xcce_t.xcce008, 
   xcce009 LIKE xcce_t.xcce009, 
   xcbb005 LIKE xcbb_t.xcbb005, 
   xcbb005_desc LIKE type_t.chr500, 
   xccd002 LIKE xccd_t.xccd002, 
   xcce101 LIKE xcce_t.xcce101, 
   xcce102 LIKE xcce_t.xcce102, 
   xcce201 LIKE xcce_t.xcce201, 
   xcce202 LIKE xcce_t.xcce202, 
   xcce301 LIKE xcce_t.xcce301, 
   xcce302 LIKE xcce_t.xcce302, 
   xcce303 LIKE xcce_t.xcce303, 
   xcce304 LIKE xcce_t.xcce304, 
   xcce307 LIKE xcce_t.xcce307, 
   xcce308 LIKE xcce_t.xcce308, 
   xcce901 LIKE xcce_t.xcce901, 
   xcce902 LIKE xcce_t.xcce902
       END RECORD
 
PRIVATE TYPE type_g_xccd2_d RECORD
       #sfaa068 LIKE xcce_t.xcce006,     #故意改的，为了能放下“小计-组织”的汉字  #160201-00004#1
       sfaa068 LIKE type_t.chr500,     #160201-00004#1 增加了栏位长度
   sfaa068_2_desc LIKE type_t.chr500, 
   #xcce006 LIKE xcce_t.xcce006,   #160201-00004#1 mark
   xcce006 LIKE type_t.chr500,     #160201-00004#1 增加了栏位长度
   xccd007 LIKE xccd_t.xccd007,            #fengmy150303
   xccd007_2_desc LIKE type_t.chr500,      #fengmy150303
   xccd007_2_desc_desc LIKE type_t.chr500, #fengmy150303
   xccd008 LIKE xccd_t.xccd008,             #liuym150810
   xccd301 LIKE xccd_t.xccd301,          #151202-00029 by whitney add
   xcce007 LIKE xcce_t.xcce007, 
   xcce007_2_desc LIKE type_t.chr500, 
   xcce007_2_desc_1 LIKE type_t.chr500, 
   xcce008 LIKE xcce_t.xcce008, 
   xcce009 LIKE xcce_t.xcce009, 
   xcbb005 LIKE xcbb_t.xcbb005, 
   xcbb005_2_desc LIKE type_t.chr500, 
   xcce002 LIKE xcce_t.xcce002, 
   xcce101 LIKE xcce_t.xcce101, 
   xcce102a LIKE type_t.num20_6, 
   xcce102b LIKE type_t.num20_6, 
   xcce102c LIKE type_t.num20_6, 
   xcce102d LIKE type_t.num20_6, 
   xcce102e LIKE type_t.num20_6, 
   xcce102f LIKE type_t.num20_6, 
   xcce102g LIKE type_t.num20_6, 
   xcce102h LIKE type_t.num20_6, 
   xcce102 LIKE type_t.num20_6, 
   xcce201 LIKE type_t.num20_6, 
   xcce202a LIKE type_t.num20_6, 
   xcce202b LIKE type_t.num20_6, 
   xcce202c LIKE type_t.num20_6, 
   xcce202d LIKE type_t.num20_6, 
   xcce202e LIKE type_t.num20_6, 
   xcce202f LIKE type_t.num20_6, 
   xcce202g LIKE type_t.num20_6, 
   xcce202h LIKE type_t.num20_6, 
   xcce202 LIKE type_t.num20_6, 
   xcce301 LIKE type_t.num20_6, 
   xcce302a LIKE type_t.num20_6, 
   xcce302b LIKE type_t.num20_6, 
   xcce302c LIKE type_t.num20_6, 
   xcce302d LIKE type_t.num20_6, 
   xcce302e LIKE type_t.num20_6, 
   xcce302f LIKE type_t.num20_6, 
   xcce302g LIKE type_t.num20_6, 
   xcce302h LIKE type_t.num20_6, 
   xcce302 LIKE type_t.num20_6, 
   xcce303 LIKE type_t.num20_6, 
   xcce304a LIKE type_t.num20_6, 
   xcce304b LIKE type_t.num20_6, 
   xcce304c LIKE type_t.num20_6, 
   xcce304d LIKE type_t.num20_6, 
   xcce304e LIKE type_t.num20_6, 
   xcce304f LIKE type_t.num20_6, 
   xcce304g LIKE type_t.num20_6, 
   xcce304h LIKE type_t.num20_6, 
   xcce304 LIKE type_t.num20_6, 
   xcce307 LIKE type_t.num20_6, 
   xcce308a LIKE type_t.num20_6, 
   xcce308b LIKE type_t.num20_6, 
   xcce308c LIKE type_t.num20_6, 
   xcce308d LIKE type_t.num20_6, 
   xcce308e LIKE type_t.num20_6, 
   xcce308f LIKE type_t.num20_6, 
   xcce308g LIKE type_t.num20_6, 
   xcce308h LIKE type_t.num20_6, 
   xcce308 LIKE type_t.num20_6, 
   xcce901 LIKE type_t.num20_6, 
   xcce902a LIKE type_t.num20_6, 
   xcce902b LIKE type_t.num20_6, 
   xcce902c LIKE type_t.num20_6, 
   xcce902d LIKE type_t.num20_6, 
   xcce902e LIKE type_t.num20_6, 
   xcce902f LIKE type_t.num20_6, 
   xcce902g LIKE type_t.num20_6, 
   xcce902h LIKE type_t.num20_6, 
   xcce902 LIKE type_t.num20_6
       END RECORD
PRIVATE TYPE type_g_xccd3_d RECORD
       #sfaa068 LIKE xcce_t.xcce006,     #故意改的，为了能放下“小计-组织”的汉字 #160201-00004#1 mark
       sfaa068 LIKE type_t.chr500,     #160201-00004#1 增加了栏位长度
   sfaa068_3_desc LIKE type_t.chr500, 
   #xcci006 LIKE xcci_t.xcci006,   #160201-00004#1 mark
   xcci006 LIKE type_t.chr500,     #160201-00004#1 增加了栏位长度
   xcch007 LIKE xccd_t.xccd007,          #fengmy150303
   xcch007_desc LIKE type_t.chr500,      #fengmy150303
   xcch007_desc_desc LIKE type_t.chr500, #fengmy150303
   xcch008 LIKE xccd_t.xccd008,          #liuym150810
   xcch301 LIKE xccd_t.xccd301,          #151202-00029 by whitney add
   xcci007 LIKE xcci_t.xcci007, 
   xcci007_desc LIKE type_t.chr500, 
   xcci007_desc_1 LIKE type_t.chr500, 
   xcci008 LIKE xcci_t.xcci008, 
   xcci009 LIKE xcci_t.xcci009, 
   xcbb005 LIKE xcbb_t.xcbb005, 
   xcbb005_3_desc LIKE type_t.chr500, 
   xcci002 LIKE xcci_t.xcci002, 
   xcci101 LIKE xcci_t.xcci101, 
   xcci102a LIKE type_t.num20_6, 
   xcci102b LIKE type_t.num20_6, 
   xcci102c LIKE type_t.num20_6, 
   xcci102d LIKE type_t.num20_6, 
   xcci102e LIKE type_t.num20_6, 
   xcci102f LIKE type_t.num20_6, 
   xcci102g LIKE type_t.num20_6, 
   xcci102h LIKE type_t.num20_6, 
   xcci102 LIKE type_t.num20_6, 
   xcci201 LIKE type_t.num20_6, 
   xcci202a LIKE type_t.num20_6, 
   xcci202b LIKE type_t.num20_6, 
   xcci202c LIKE type_t.num20_6, 
   xcci202d LIKE type_t.num20_6, 
   xcci202e LIKE type_t.num20_6, 
   xcci202f LIKE type_t.num20_6, 
   xcci202g LIKE type_t.num20_6, 
   xcci202h LIKE type_t.num20_6, 
   xcci202 LIKE type_t.num20_6, 
   xcci301 LIKE type_t.num20_6, 
   xcci302a LIKE type_t.num20_6, 
   xcci302b LIKE type_t.num20_6, 
   xcci302c LIKE type_t.num20_6, 
   xcci302d LIKE type_t.num20_6, 
   xcci302e LIKE type_t.num20_6, 
   xcci302f LIKE type_t.num20_6, 
   xcci302g LIKE type_t.num20_6, 
   xcci302h LIKE type_t.num20_6, 
   xcci302 LIKE type_t.num20_6, 
   xcci303 LIKE type_t.num20_6, 
   xcci304a LIKE type_t.num20_6, 
   xcci304b LIKE type_t.num20_6, 
   xcci304c LIKE type_t.num20_6, 
   xcci304d LIKE type_t.num20_6, 
   xcci304e LIKE type_t.num20_6, 
   xcci304f LIKE type_t.num20_6, 
   xcci304g LIKE type_t.num20_6, 
   xcci304h LIKE type_t.num20_6, 
   xcci304 LIKE type_t.num20_6,  
   xcci901 LIKE type_t.num20_6, 
   xcci902a LIKE type_t.num20_6, 
   xcci902b LIKE type_t.num20_6, 
   xcci902c LIKE type_t.num20_6, 
   xcci902d LIKE type_t.num20_6, 
   xcci902e LIKE type_t.num20_6, 
   xcci902f LIKE type_t.num20_6, 
   xcci902g LIKE type_t.num20_6, 
   xcci902h LIKE type_t.num20_6, 
   xcci902 LIKE type_t.num20_6
       END RECORD
 
 
#模組變數(Module Variables)
DEFINE g_xccd_m          type_g_xccd_m
DEFINE g_xccd_m_t        type_g_xccd_m
DEFINE g_xccd_m_o        type_g_xccd_m
 
   DEFINE g_xccdld_t LIKE xccd_t.xccdld
DEFINE g_xccd004_t LIKE xccd_t.xccd004
DEFINE g_xccd005_t LIKE xccd_t.xccd005
DEFINE g_xccd001_t LIKE xccd_t.xccd001
DEFINE g_xccd003_t LIKE xccd_t.xccd003
 
 
DEFINE g_xccd_d          DYNAMIC ARRAY OF type_g_xccd_d
DEFINE g_xccd_d_t        type_g_xccd_d
DEFINE g_xccd_d_o        type_g_xccd_d
DEFINE g_xccd2_d   DYNAMIC ARRAY OF type_g_xccd2_d
DEFINE g_xccd2_d_t type_g_xccd2_d
DEFINE g_xccd2_d_o type_g_xccd2_d
DEFINE g_xccd3_d   DYNAMIC ARRAY OF type_g_xccd3_d
DEFINE g_xccd3_d_t type_g_xccd3_d
DEFINE g_xccd3_d_o type_g_xccd3_d
 
DEFINE g_browser    DYNAMIC ARRAY OF RECORD    #資料瀏覽之欄位 
         b_statepic     LIKE type_t.chr50,
            b_xccdld LIKE xccd_t.xccdld,
      b_xccd001 LIKE xccd_t.xccd001,
      b_xccd003 LIKE xccd_t.xccd003,
      b_xccd004 LIKE xccd_t.xccd004,
      b_xccd005 LIKE xccd_t.xccd005
      END RECORD 
      
DEFINE g_browser_f  RECORD    #資料瀏覽之欄位 
       b_statepic     LIKE type_t.chr50,
          b_xccdld LIKE xccd_t.xccdld,
      b_xccd001 LIKE xccd_t.xccd001,
      b_xccd003 LIKE xccd_t.xccd003,
      b_xccd004 LIKE xccd_t.xccd004,
      b_xccd005 LIKE xccd_t.xccd005
      END RECORD 
      
#DEFINE g_detail_multi_table_t    RECORD
#      sfaadocno LIKE sfaa_t.sfaadocno,
#      sfaa068 LIKE sfaa_t.sfaa068,
#      xcceld LIKE xcce_t.xcceld,
#      xcce001 LIKE xcce_t.xcce001,
#      xcce002 LIKE xcce_t.xcce002,
#      xcce003 LIKE xcce_t.xcce003,
#      xcce004 LIKE xcce_t.xcce004,
#      xcce005 LIKE xcce_t.xcce005,
#      xcce006 LIKE xcce_t.xcce006,
#      xcce007 LIKE xcce_t.xcce007,
#      xcce008 LIKE xcce_t.xcce008,
#      xcce009 LIKE xcce_t.xcce009,
#      xcce007 LIKE xcce_t.xcce007,
#      xcce008 LIKE xcce_t.xcce008,
#      xcce009 LIKE xcce_t.xcce009,
#      xcce101 LIKE xcce_t.xcce101,
#      xcce102 LIKE xcce_t.xcce102,
#      xcce201 LIKE xcce_t.xcce201,
#      xcce202 LIKE xcce_t.xcce202,
#      xcce301 LIKE xcce_t.xcce301,
#      xcce302 LIKE xcce_t.xcce302,
#      xcce303 LIKE xcce_t.xcce303,
#      xcce304 LIKE xcce_t.xcce304,
#      xcce307 LIKE xcce_t.xcce307,
#      xcce308 LIKE xcce_t.xcce308,
#      xcce901 LIKE xcce_t.xcce901,
#      xcce902 LIKE xcce_t.xcce902,
#      xcbbcomp LIKE xcbb_t.xcbbcomp,
#      xcbb001 LIKE xcbb_t.xcbb001,
#      xcbb002 LIKE xcbb_t.xcbb002,
#      xcbb003 LIKE xcbb_t.xcbb003,
#      xcbb004 LIKE xcbb_t.xcbb004,
#      xcbb005 LIKE xcbb_t.xcbb005
#      END RECORD
 
DEFINE g_wc                  STRING
DEFINE g_wc_t                STRING
DEFINE g_wc2                 STRING                          #單身CONSTRUCT結果
DEFINE g_wc2_table1          STRING
DEFINE g_wc2_table2   STRING
 
DEFINE g_wc2_table3   STRING
 
 
 
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
DEFINE g_curr_diag           ui.Dialog                     #Current Dialog
    
DEFINE g_pagestart           LIKE type_t.num5           
DEFINE gwin_curr             ui.Window                     #Current Window
DEFINE gfrm_curr             ui.Form                       #Current Form
DEFINE g_page_action         STRING                        #page action
DEFINE g_header_hidden       LIKE type_t.num5              #隱藏單頭
DEFINE g_worksheet_hidden    LIKE type_t.num5              #隱藏工作Panel
DEFINE g_page                STRING                        #第幾頁
DEFINE g_state               STRING       
 
DEFINE g_detail_cnt          LIKE type_t.num10              #單身總筆數
DEFINE g_detail_idx          LIKE type_t.num10              #單身目前所在筆數
DEFINE g_detail_idx2         LIKE type_t.num10              #單身2目前所在筆數
DEFINE g_browser_cnt         LIKE type_t.num10              #Browser總筆數
DEFINE g_browser_idx         LIKE type_t.num10              #Browser目前所在筆數
DEFINE g_temp_idx            LIKE type_t.num10              #Browser目前所在筆數(暫存用)
 
DEFINE g_searchcol           STRING                        #查詢欄位代碼
DEFINE g_searchstr           STRING                        #查詢欄位字串
DEFINE g_order               STRING                        #查詢排序欄位
                                                        
DEFINE g_current_row         LIKE type_t.num10              #Browser所在筆數
DEFINE g_current_sw          BOOLEAN                       #Browser所在筆數用開關
DEFINE g_current_page        LIKE type_t.num5              #目前所在頁數
DEFINE g_insert              LIKE type_t.chr5              #是否導到其他page
 
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
 
#add-point:自定義模組變數(Module Variable)
DEFINE g_para_data           LIKE type_t.chr80     #采用成本域否  #fengmy150113
DEFINE g_para_data1          LIKE type_t.chr80     #采用特性否    #fengmy150113
DEFINE g_wc3                 STRING                #fengmy150304
DEFINE g_wc2_table4          STRING                #fengmy150304
DEFINE g_wc2_table5          STRING                #fengmy150304
DEFINE g_wc2_table6          STRING                #fengmy150304
#2015/3/27 ouhz add------begin----
TYPE type_g_xccd_e RECORD
       v          STRING
       END RECORD
DEFINE g_param                     type_g_xccd_e
DEFINE g_sql_tmp             STRING
#2015/3/27 ouhz add------end----
#fengmy150806-----add
DEFINE g_yy1 LIKE type_t.num5
DEFINE g_mm1 LIKE type_t.num5
DEFINE g_yy2 LIKE type_t.num5
DEFINE g_mm2 LIKE type_t.num5
#fengmy150806-----end
#151130-00003#3--add-(s)
DEFINE g_wc_filter2           STRING
DEFINE g_wc_filter2_t         STRING
DEFINE g_wc_filter3           STRING
DEFINE g_wc_filter3_t         STRING
#151130-00003#3--add-(e)
DEFINE g_wc_cs_ld            STRING                #160802-00020#4-add
DEFINE g_wc_cs_comp          STRING                #160802-00020#10-add
#end add-point
 
#add-point:傳入參數說明(global.argv)

#end add-point
 
{</section>}
 
{<section id="axcq540.main" >}
#+ 此段落由子樣板a26產生
#OPTIONS SHORT CIRCUIT
#+ 作業開始 
MAIN
   #add-point:main段define
   
   #end add-point   
 
   OPTIONS
   INPUT NO WRAP
   DEFER INTERRUPT
   
   #設定SQL錯誤記錄方式 (模組內定義有效)
   WHENEVER ERROR CALL cl_err_msg_log
       
   #依模組進行系統初始化設定(系統設定)
   CALL cl_ap_init("axc","")
 
   #add-point:作業初始化
   #160802-00020#4-add-(S)
   CALL s_fin_create_account_center_tmp()                      #展組織下階成員所需之暫存檔 
   CALL s_fin_azzi800_sons_query(g_today)
   CALL s_fin_account_center_ld_str() RETURNING g_wc_cs_ld
   CALL s_fin_get_wc_str(g_wc_cs_ld)  RETURNING g_wc_cs_ld
   #160802-00020#4-add-(E)
   CALL s_axc_get_authcomp() RETURNING g_wc_cs_comp            #抓取使用者有拜訪權限據點的對應法人  #160802-00020#10-add
   #end add-point
   
   
 
   #LOCK CURSOR (identifier)
   #add-point:SQL_define
   
   #end add-point
   LET g_forupd_sql = " SELECT xccdcomp,'',xccdld,'',xccd004,xccd005,xccd001,'',xccd003,''", 
                      " FROM xccd_t",
                      " WHERE xccdent= ? AND xccdld=? AND xccd001=? AND xccd003=? AND xccd004=? AND  
                          xccd005=? FOR UPDATE"
   #add-point:SQL_define
   
   #end add-point
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)                #轉換不同資料庫語法
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE axcq540_cl CURSOR FROM g_forupd_sql                 # LOCK CURSOR
 
   LET g_sql = " SELECT UNIQUE t0.xccdcomp,t0.xccdld,t0.xccd004,t0.xccd005,t0.xccd001,t0.xccd003,t1.ooefl003 , 
       t2.glaal002 ,t3.xcatl003",
               " FROM xccd_t t0",
                              " LEFT JOIN ooefl_t t1 ON t1.ooeflent='"||g_enterprise||"' AND t1.ooefl001=t0.xccdcomp AND t1.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN glaal_t t2 ON t2.glaalent='"||g_enterprise||"' AND t2.glaalld=t0.xccdld AND t2.glaal001='"||g_dlang||"' ",
               " LEFT JOIN xcatl_t t3 ON t3.xcatlent='"||g_enterprise||"' AND t3.xcatl001=t0.xccd003 AND t3.xcatl002='"||g_dlang||"' ",
 
               " WHERE t0.xccdent = '" ||g_enterprise|| "' AND t0.xccdld = ? AND t0.xccd001 = ? AND t0.xccd003 = ? AND t0.xccd004 = ? AND t0.xccd005 = ?"
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   #add-point:SQL_define
   
   #end add-point
   PREPARE axcq540_master_referesh FROM g_sql
 
 
 
   
   IF g_bgjob = "Y" THEN
      #add-point:Service Call
      
      #end add-point
   ELSE
      #畫面開啟 (identifier)
      OPEN WINDOW w_axcq540 WITH FORM cl_ap_formpath("axc",g_code)
   
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
   
      #程式初始化
      CALL axcq540_init()   
 
      #進入選單 Menu (="N")
      CALL axcq540_ui_dialog() 
      
      #add-point:畫面關閉前
      CALL axcq540_ins_xckk()
      #end add-point
 
      #畫面關閉
      CLOSE WINDOW w_axcq540
      
   END IF 
   
   CLOSE axcq540_cl
   
   
 
   #add-point:作業離開前
   
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
   
END MAIN
 
 
 
{</section>}
 
{<section id="axcq540.init" >}
#+ 瀏覽頁簽資料初始化
PRIVATE FUNCTION axcq540_init()
   #add-point:init段define
   
   #end add-point    
   
   LET g_bfill       = "Y"
   LET g_detail_idx  = 1
   LET g_detail_idx2 = 1
   LET g_error_show  = 1
   LET l_ac = 1
   
   
   LET gwin_curr = ui.Window.getCurrent()  #取得現行畫面
   LET gfrm_curr = gwin_curr.getForm()     #取出物件化後的畫面物件
 
   #add-point:畫面資料初始化
   CALL cl_set_combo_scc('xccd001','8914')
   #特性
   IF cl_get_para(g_enterprise,g_site,'S-FIN-6013') = 'N' THEN
      CALL cl_set_comp_visible('xcce008,xcce008_2,xcci008',FALSE)
   END IF
   #成本域
   IF cl_get_para(g_enterprise,g_site,'S-FIN-6001') = 'N' THEN
      CALL cl_set_comp_visible('xccd002,xccd002_desc,xcce002_2,xcce002_2_desc,xcci002,xcci002_desc',FALSE) 
   END IF
   #end add-point
   
   CALL axcq540_default_search()
    
END FUNCTION
 
{</section>}
 
{<section id="axcq540.ui_dialog" >}
#+ 功能選單
PRIVATE FUNCTION axcq540_ui_dialog()
   DEFINE li_idx    LIKE type_t.num10
   DEFINE ls_wc     STRING
   DEFINE lb_first  BOOLEAN
   DEFINE la_param  RECORD
             prog   STRING,
             param  DYNAMIC ARRAY OF STRING
                    END RECORD
   DEFINE ls_js     STRING
   #add-point:ui_dialog段define

   #end add-point
   
   CALL cl_set_act_visible("accept,cancel", FALSE)
 
   
   #action default動作
   
   
   LET lb_first = TRUE
   
   #add-point:ui_dialog段before dialog 

   #end add-point
   
   WHILE TRUE 
   
      #先填充browser資料
      CALL axcq540_browser_fill("")
            
      DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
 
 
 
               
      
         
        
         DISPLAY ARRAY g_xccd_d TO s_detail1.* ATTRIBUTES(COUNT=g_rec_b) #page1  
    
            BEFORE ROW
               #顯示單身筆數
               CALL axcq540_idx_chk()
               #確定當下選擇的筆數
               LET l_ac = DIALOG.getCurrentRow("s_detail1")
               LET g_detail_idx = l_ac
               
               #add-point:page1, before row動作

               #end add-point
               
            BEFORE DISPLAY
               #如果一直都在單頭則控制筆數位置
               IF g_loc = 'm' THEN
                  CALL FGL_SET_ARR_CURR(g_detail_idx)
               END IF
               LET g_loc = 'm'
               LET l_ac = DIALOG.getCurrentRow("s_detail1")
               LET g_current_page = 1
               #顯示單身筆數
               CALL axcq540_idx_chk()
               #add-point:page1自定義行為

               #end add-point
               
            #自訂ACTION(detail_show,page_1)
            
               
            #add-point:page1自定義行為

            #end add-point
               
         END DISPLAY
        
         #第一階單身段落
         DISPLAY ARRAY g_xccd2_d TO s_detail2.* ATTRIBUTES(COUNT=g_rec_b)  
    
            BEFORE ROW
               #顯示單身筆數
               CALL axcq540_idx_chk()
               LET l_ac = DIALOG.getCurrentRow("s_detail2")
               LET g_detail_idx = l_ac
               
               #add-point:page2, before row動作

               #end add-point
               
            BEFORE DISPLAY
               #如果一直都在單頭則控制筆數位置
               IF g_loc = 'm' THEN
                  CALL FGL_SET_ARR_CURR(g_detail_idx)
               END IF
               LET g_loc = 'm'
               LET l_ac = DIALOG.getCurrentRow("s_detail2")
               LET g_current_page = 2
               #顯示單身筆數
               CALL axcq540_idx_chk()
               #add-point:page2自定義行為

               #end add-point
      
            #自訂ACTION(detail_show,page_2)
            
         
            #add-point:page2自定義行為

            #end add-point
         
         END DISPLAY
         #第一階單身段落
         DISPLAY ARRAY g_xccd3_d TO s_detail3.* ATTRIBUTES(COUNT=g_rec_b)  
    
            BEFORE ROW
               #顯示單身筆數
               CALL axcq540_idx_chk()
               LET l_ac = DIALOG.getCurrentRow("s_detail3")
               LET g_detail_idx = l_ac
               
               #add-point:page3, before row動作

               #end add-point
               
            BEFORE DISPLAY
               #如果一直都在單頭則控制筆數位置
               IF g_loc = 'm' THEN
                  CALL FGL_SET_ARR_CURR(g_detail_idx)
               END IF
               LET g_loc = 'm'
               LET l_ac = DIALOG.getCurrentRow("s_detail3")
               LET g_current_page = 3
               #顯示單身筆數
               CALL axcq540_idx_chk()
               #add-point:page3自定義行為

               #end add-point
      
            #自訂ACTION(detail_show,page_3)
            
         
            #add-point:page3自定義行為

            #end add-point
         
         END DISPLAY
         
 
         
         #add-point:ui_dialog段自定義display array
         #151130-00003#3--add--(s)
         ON ACTION filter
            LET g_action_choice="filter"
            CALL axcq540_filter()
         #151130-00003#3--add--(e)   
         #end add-point
         
      
         BEFORE DIALOG
            CALL cl_navigator_setting(g_current_idx, g_detail_cnt)
            LET g_curr_diag = ui.DIALOG.getCurrent()
            LET g_current_sw = FALSE
            #回歸舊筆數位置 (回到當時異動的筆數)
            
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
               CALL axcq540_fetch('') # reload data
            END IF
            #LET g_detail_idx = 1
            CALL axcq540_ui_detailshow() #Setting the current row 
            
            #筆數顯示
            LET g_current_page = 4
            CALL axcq540_idx_chk()
            
            #add-point:ui_dialog段before_dialog2

            #end add-point
        
 
    
         
          
         #查詢方案選擇 
         ON ACTION queryplansel
            CALL cl_dlg_qryplan_select() RETURNING ls_wc
            #不是空條件才寫入g_wc跟重新找資料
            IF NOT cl_null(ls_wc) THEN
               LET g_wc = ls_wc
               CALL axcq540_browser_fill("F")   #browser_fill()會將notice區塊清空
            END IF
         
         #查詢方案選擇
         ON ACTION qbe_select
            CALL cl_qbe_list("m") RETURNING ls_wc
            IF NOT cl_null(ls_wc) THEN
               LET g_wc = ls_wc
               #取得條件後需要重查、跳到結果第一筆資料的功能程式段
               CALL axcq540_browser_fill("F")
               IF g_browser_cnt = 0 THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "" 
                  LET g_errparam.code   = "-100" 
                  LET g_errparam.popup  = TRUE 
                  CALL cl_err()
 
                  CLEAR FORM
               ELSE
                  CALL axcq540_fetch("F")
               END IF
            END IF
            #重新搜尋會將notice區塊清空,此處不可用EXIT DIALOG, SUBDIALOG重讀會導致部分變數消失
          
         
         
         ON ACTION first
            CALL axcq540_fetch('F')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL axcq540_idx_chk()
            
         ON ACTION previous
            CALL axcq540_fetch('P')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL axcq540_idx_chk()
            
         ON ACTION jump
            CALL axcq540_fetch('/')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL axcq540_idx_chk()
            
         ON ACTION next
            CALL axcq540_fetch('N')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL axcq540_idx_chk()
            
         ON ACTION last
            CALL axcq540_fetch('L')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL axcq540_idx_chk()
            
         ON ACTION exporttoexcel
            LET g_action_choice="exporttoexcel"
            IF cl_auth_chk_act("exporttoexcel") THEN
               #browser
               CALL g_export_node.clear()
               IF g_main_hidden = 1 THEN
                  LET g_export_node[1] = base.typeInfo.create(g_browser)
                  CALL cl_export_to_excel()
               #非browser
               ELSE
                  LET g_export_node[1] = base.typeInfo.create(g_xccd_d)
                  LET g_export_node[2] = base.typeInfo.create(g_xccd2_d)
                  LET g_export_node[3] = base.typeInfo.create(g_xccd3_d)
 
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
            END IF
            
       
         #單頭摺疊，可利用hot key "Ctrl-s"開啟/關閉單頭
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
    
         
         #+ 此段落由子樣板a43產生
         ON ACTION output
            LET g_action_choice="output"
            IF cl_auth_chk_act("output") THEN
               
               #add-point:ON ACTION output
               #ouhz 2015/3/27 add ----begin-----
               #創建臨時表，存放當前單身數據
               CALL axcq540_create_temp_table()        
               #把單身內容放入暫存檔，以便XG調用打印
               CALL axcq540_ins_temp()                    
               LET g_param.v = "axcq540_tmp"
               CALL axcq540_x01('1=1',g_param.v)
               #ouhz 2015/3/27 add ----end----- 
               #END add-point
               
            END IF
 
 
         #+ 此段落由子樣板a43產生
         ON ACTION query
            LET g_action_choice="query"
            IF cl_auth_chk_act("query") THEN
               CALL axcq540_query()
               #add-point:ON ACTION query

               #END add-point
               
            END IF
 
 
         
         #+ 此段落由子樣板a46產生
         #新增相關文件
         ON ACTION related_document
            CALL axcq540_set_pk_array()
            IF cl_auth_chk_act("related_document") THEN
               #add-point:ON ACTION related_document

               #END add-point
               CALL cl_doc()
            END IF
            
         ON ACTION agendum
            CALL axcq540_set_pk_array()
            #add-point:ON ACTION agendum

            #END add-point
            CALL cl_user_overview()
            CALL cl_user_overview_set_follow_pic()
         
         ON ACTION followup
            CALL axcq540_set_pk_array()
            #add-point:ON ACTION followup

            #END add-point
            CALL cl_user_overview_follow('')
 
 
         
         #主選單用ACTION
         &include "main_menu.4gl"
         &include "relating_action.4gl"
         #交談指令共用ACTION
         &include "common_action.4gl" 
            CONTINUE DIALOG
            
      END DIALOG
    
      IF g_action_choice = "exit" AND NOT cl_null(g_action_choice) THEN
         #add-point:ui_dialog段離開dialog前

         #end add-point
         EXIT WHILE
      END IF
    
   END WHILE    
      
   CALL cl_set_act_visible("accept,cancel", TRUE)
    
END FUNCTION
 
{</section>}
 
{<section id="axcq540.browser_fill" >}
#+ 瀏覽頁簽資料填充
PRIVATE FUNCTION axcq540_browser_fill(ps_page_action)
   DEFINE ps_page_action    STRING
   DEFINE l_wc              STRING
   DEFINE l_wc2             STRING
   DEFINE l_sql             STRING
   DEFINE l_sub_sql         STRING
   DEFINE l_sql_rank        STRING
   DEFINE l_searchcol       STRING
   #add-point:browser_fill段define
   DEFINE l_wc1             STRING    #fengmy150215 add
   DEFINE l_wc3             STRING    #fengmy150215 add
   DEFINE l_wc4             STRING    #fengmy150304 add
   DEFINE l_wc5             STRING    #fengmy150304 add
   #end add-point   
   
   #add-point:browser_fill段動作開始前

   #end add-point
   
   #搜尋用
   IF cl_null(g_searchcol) OR g_searchcol = '0' THEN
      LET l_searchcol = "xccdld,xccd001,xccd003,xccd004,xccd005"
   ELSE
      LET l_searchcol = g_searchcol
   END IF
   
   IF cl_null(g_wc) THEN
      LET g_wc = " 1=1"
   END IF
   IF cl_null(g_wc2) THEN
      LET g_wc2 = " 1=1"
   END IF
   LET l_wc  = g_wc.trim() 
   LET l_wc2 = g_wc2.trim()
 
   #add-point:browser_fill,foreach前
#fengmy150304---begin
   IF cl_null(g_wc3) THEN
      LET g_wc3 = " 1=1"
   END IF
   LET l_wc4  = g_wc3.trim()
   LET l_wc5  = g_wc3.trim()
#fengmy150304---end
   LET g_wc = g_wc," AND (xccd004*12+xccd005 BETWEEN ",g_yy1,"*12+",g_mm1," AND ",g_yy2,"*12+",g_mm2,")"  #fengmy150806
   LET l_wc  = g_wc.trim()     #fengmy150813
   #end add-point
   
   IF g_wc2 <> " 1=1" THEN
      #單身有輸入搜尋條件                      
      LET l_sub_sql = " SELECT UNIQUE xccdld,xccd001,xccd003,xccd004,xccd005 ",
                      " FROM xccd_t ",
                      " LEFT JOIN sfaa_t ON sfaaent = '"||g_enterprise||"' AND xccdld = sfaadocno ",
                      " WHERE xccdent = '" ||g_enterprise|| "' AND xccdent = '" ||g_enterprise|| "' AND ",l_wc, " AND ", l_wc2, cl_sql_add_filter("xccd_t")
   ELSE
      #單身未輸入搜尋條件
      LET l_sub_sql = " SELECT UNIQUE xccdld,xccd001,xccd003,xccd004,xccd005 ",
                      " FROM xccd_t ", 
                      "  ",
                      "  ",
                      " WHERE xccdent = '" ||g_enterprise|| "' AND ",l_wc CLIPPED, cl_sql_add_filter("xccd_t")
   END IF
   
   #add-point:browser_fill,cnt wc
   #fengmy150215---begin
   LET l_wc1 = cl_replace_str(l_wc,"xccd","xcci")
   LET l_wc3 = cl_replace_str(l_wc2,"xccd","xcci")
   LET l_wc3 = cl_replace_str(l_wc3,"xcce","xcci")
   LET l_wc2 = cl_replace_str(l_wc2,"xcci","xcce")
   LET l_wc4 = cl_replace_str(l_wc4,"xcch","xccd")   #fengmy150304
   LET l_wc5 = cl_replace_str(l_wc4,"xccd","xcch")   #fengmy150304
   IF (g_wc2 <> " 1=1") OR (g_wc3 <> " 1=1")  THEN   #fengmy150304 add g_wc3
      #單身有輸入搜尋條件                      
     #LET l_sub_sql = " SELECT UNIQUE xccdld,xccd001,xccd003,xccd004,xccd005 ",  #fengmy150813 mark
      LET l_sub_sql = " SELECT UNIQUE xccdld,xccd001,xccd003 ",  #fengmy150813 del xccd004&xccd005
                      " FROM xccd_t ",
                     #"  INNER JOIN xcce_t ON xccdent = xcceent AND xccd006 = xcce006 AND xccd002 = xcce002 ",    #160813-00002#1 mark
                      "  INNER JOIN xcce_t ON xccdent = xcceent AND xccd006 = xcce006 ",                          #160813-00002#1 add
                      "   AND xccdld = xcceld AND xccd001 = xcce001 AND xccd003 = xcce003 AND xccd004 = xcce004 AND xccd005 = xcce005 ",
                      " LEFT JOIN sfaa_t ON sfaaent = '"||g_enterprise||"' AND xccd006 = sfaadocno ",  #fengmy150304 xccdldtoxccd006
                      " WHERE xccdent = '" ||g_enterprise|| "' AND xccdent = '" ||g_enterprise|| "' AND ",l_wc, " AND ", l_wc2, " AND ", l_wc4, #fengmy150304 add l_wc4
                      cl_sql_add_filter("xccd_t") #160107-00023-add
      #160802-00020#4-add-(S)
      #---帳套權限控管
      IF NOT cl_null(g_wc_cs_ld) THEN
         LET g_sql = g_sql , " AND xccdld IN ",g_wc_cs_ld
       END IF
      #160802-00020#4-add-(E)
      #160802-00020#10-add-(S)
      #---增加法人過濾條件
      IF NOT cl_null(g_wc_cs_comp) THEN
         LET g_sql = g_sql," AND xccdcomp IN ",g_wc_cs_comp
      END IF
      #160802-00020#10-add-(E)
   #add------begin---------
      LET l_sub_sql = l_sub_sql CLIPPED,   
                         " UNION ",
                        #" SELECT UNIQUE xcchld,xcch001,xcch003,xcch004,xcch005 ",  #fengmy150813 mark
                         " SELECT UNIQUE xcchld,xcch001,xcch003 ",  #fengmy150813 
                         " FROM xcch_t ",
                         "  INNER JOIN xcci_t ON xcchent = xccient AND xcch006 = xcci006 AND xcch002 = xcci002 ",
                         "   AND xcchld = xccild AND xcch001 = xcci001 AND xcch003 = xcci003 AND xcch004 = xcci004 AND xcch005 = xcci005 ",
                         " LEFT JOIN sfaa_t ON sfaaent = '"||g_enterprise||"' AND xcch006 = sfaadocno ",   #fengmy150304 xcchldtoxcch006
                         " WHERE xcchent = '" ||g_enterprise|| "' AND xcchent = '" ||g_enterprise|| "' AND ",l_wc1, " AND ", l_wc3, " AND ", l_wc5, #fengmy150304 add l_wc5
                         cl_sql_add_filter("xccd_t") #160107-00023-add
      #160802-00020#4-add-(S)
      #---帳套權限控管
      IF NOT cl_null(g_wc_cs_ld) THEN
         LET g_sql = g_sql , " AND xcchld IN ",g_wc_cs_ld
       END IF
      #160802-00020#4-add-(E)
      #160802-00020#10-add-(S)
      #---增加法人過濾條件
      IF NOT cl_null(g_wc_cs_comp) THEN
         LET g_sql = g_sql," AND xcchcomp IN ",g_wc_cs_comp
      END IF
   #160802-00020#10-add-(E)                   
   #add------end-----------
   ELSE
      #單身未輸入搜尋條件
     #LET l_sub_sql = " SELECT UNIQUE xccdld,xccd001,xccd003,xccd004,xccd005 ",  #fengmy150813 mark
      LET l_sub_sql = " SELECT UNIQUE xccdld,xccd001,xccd003 ",  #fengmy150813 
                      " FROM xccd_t ", 
                      "  ",
                      "  ",
                      " WHERE xccdent = '" ||g_enterprise|| "' AND ",l_wc CLIPPED, cl_sql_add_filter("xccd_t")
      #160802-00020#4-add-(S)
      #---帳套權限控管
      IF NOT cl_null(g_wc_cs_ld) THEN
         LET g_sql = g_sql , " AND xccdld IN ",g_wc_cs_ld
       END IF
      #160802-00020#4-add-(E)
      #160802-00020#10-add-(S)
      #---增加法人過濾條件
      IF NOT cl_null(g_wc_cs_comp) THEN
         LET g_sql = g_sql," AND xccdcomp IN ",g_wc_cs_comp
      END IF
      #160802-00020#10-add-(E)
   END IF
   #fengmy150215---end
   
   #end add-point
   
   LET g_sql = " SELECT COUNT(*) FROM (",l_sub_sql,")"
   
   #add-point:browser_fill,count前

   #end add-point
   
   PREPARE header_cnt_pre FROM g_sql
   EXECUTE header_cnt_pre INTO g_browser_cnt   #總筆數
   FREE header_cnt_pre
 
   IF g_browser_cnt > g_max_rec THEN
      IF g_error_show = 1 THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = g_browser_cnt
         LET g_errparam.code   = 9035 
         LET g_errparam.popup  = TRUE 
         CALL cl_err()
      END IF
      LET g_browser_cnt = g_max_rec
   END IF
   
   DISPLAY g_browser_cnt TO FORMONLY.b_count   #總筆數的顯示
   DISPLAY g_browser_cnt TO FORMONLY.h_count   #總筆數的顯示
 
   #根據行為確定資料填充位置及WC
   #CASE g_state
   #   WHEN "insert"
   #      LET l_wc  = g_add_browse
   #      LET l_wc2 = " 1=1" 
   #      LET g_cnt = g_browser.getLength() + 1
   #   WHEN "modify"
   #      LET l_wc  = g_add_browse
   #      LET l_wc2 = " 1=1" 
   #      LET g_cnt = g_current_idx
   #   OTHERWISE
   #      #清除畫面
   #      CLEAR FORM                
   #      INITIALIZE g_xccd_m.* TO NULL
   #      CALL g_xccd_d.clear()        
   #      CALL g_xccd2_d.clear() 
   #      CALL g_xccd3_d.clear() 
 
   #      CALL g_browser.clear()
   #      LET g_cnt = 1
   #END CASE
   
   IF NOT cl_null(g_state) THEN   #2015/10/16 by stellar add:查詢時，g_add_browse會是null
      IF cl_null(g_add_browse) THEN
         #清除畫面
         CLEAR FORM                
         INITIALIZE g_xccd_m.* TO NULL
         CALL g_xccd_d.clear()        
         CALL g_xccd2_d.clear() 
         CALL g_xccd3_d.clear() 
    
         CALL g_browser.clear()
         LET g_cnt = 1
      ELSE
         LET l_wc  = g_add_browse
         LET l_wc2 = " 1=1" 
         LET g_cnt = g_current_idx
         LET g_add_browse = ""
      END IF
   #2015/10/16 by stellar add ----- (S)
   ELSE
      LET g_cnt = 1
   END IF  
   #2015/10/16 by stellar add ----- (E)
 
   #依照t0.xccdld,t0.xccd001,t0.xccd003,t0.xccd004,t0.xccd005 Browser欄位定義(取代原本bs_sql功能)
   LET g_sql = " SELECT DISTINCT '',t0.xccdld,t0.xccd001,t0.xccd003,t0.xccd004,t0.xccd005 ",
               " FROM xccd_t t0",
               "  LEFT JOIN sfaa_t ON sfaaent = '"||g_enterprise||"' AND xccdld = sfaadocno ",               
               " WHERE t0.xccdent = '" ||g_enterprise|| "' AND ",l_wc," AND ",l_wc2, cl_sql_add_filter("xccd_t")
   #add-point:browser_fill,sql wc
   #fengmy150215------begin---------
  #LET g_sql = " SELECT DISTINCT '',t0.xccdld,t0.xccd001,t0.xccd003,t0.xccd004,t0.xccd005 ",   #fengmy150813 mark
   LET g_sql = " SELECT DISTINCT '',t0.xccdld,t0.xccd001,t0.xccd003,'','' ",   #fengmy150813 
               " FROM xccd_t t0",
              #"  INNER JOIN xcce_t ON xccdent = xcceent AND xccd006 = xcce006 AND xccd002 = xcce002 ",    #160813-00002#1 mark
               "  INNER JOIN xcce_t ON xccdent = xcceent AND xccd006 = xcce006 ",                          #160813-00002#1 add
               "   AND xccdld = xcceld AND xccd001 = xcce001 AND xccd003 = xcce003 AND xccd004 = xcce004 AND xccd005 = xcce005 ",               
               "  LEFT JOIN sfaa_t ON sfaaent = '"||g_enterprise||"' AND xccd006 = sfaadocno ",  #fengmy150304 xccdldtoxccd006               
               " WHERE t0.xccdent = '" ||g_enterprise|| "' AND ",l_wc," AND ",l_wc2," AND ",l_wc4  #fengmy150304 add l_wc4
   #160802-00020#4-add-(S)
   #---帳套權限控管
   IF NOT cl_null(g_wc_cs_ld) THEN
      LET g_sql = g_sql , " AND t0.xccdld IN ",g_wc_cs_ld
   END IF  
   #160802-00020#4-add-(E)     
   #160802-00020#10-add-(S)
   #---增加法人過濾條件
   IF NOT cl_null(g_wc_cs_comp) THEN
      LET g_sql = g_sql," AND t0.xccdcomp IN ",g_wc_cs_comp
   END IF
   #160802-00020#10-add-(E)
   LET g_sql = g_sql CLIPPED,    
               " UNION ",
              #" SELECT DISTINCT '',t0.xcchld,t0.xcch001,t0.xcch003,t0.xcch004,t0.xcch005 ",  #fengmy150813 mark
               " SELECT DISTINCT '',t0.xcchld,t0.xcch001,t0.xcch003,'','' ",  #fengmy150813 
               " FROM xcch_t t0",
               "  INNER JOIN xcci_t ON xcchent = xccient AND xcch006 = xcci006 AND xcch002 = xcci002 ",
               "   AND xcchld = xccild AND xcch001 = xcci001 AND xcch003 = xcci003 AND xcch004 = xcci004 AND xcch005 = xcci005 ",
               "  LEFT JOIN sfaa_t ON sfaaent = '"||g_enterprise||"' AND xcch006 = sfaadocno ",  #fengmy150304 xcchldtoxcch006             
               " WHERE t0.xcchent = '" ||g_enterprise|| "' AND ",l_wc1," AND ",l_wc3," AND ",l_wc5 #fengmy150304 add l_wc5
   #160802-00020#4-add-(S)
   #---帳套權限控管
   IF NOT cl_null(g_wc_cs_ld) THEN
      LET g_sql = g_sql , " AND t0.xcchld IN ",g_wc_cs_ld
   END IF  
   #160802-00020#4-add-(E)  
   #160802-00020#10-add-(S)
   #---增加法人過濾條件
   IF NOT cl_null(g_wc_cs_comp) THEN
      LET g_sql = g_sql," AND t0.xcchcomp IN ",g_wc_cs_comp
   END IF
   #160802-00020#10-add-(E)   
  #LET g_sql = g_sql, " ORDER BY 1,2,3,4,5,6"," ",g_order   #fengmy150813 mark
   LET g_sql = g_sql, " ORDER BY 1,2,3,4"," ",g_order   #fengmy150813 
   #160802-00020#4-mark-(S) 原本foreach被mark了，這段沒用了
#   #dorislai-20151021-add----(S)
#   #與上方g_sql相同，差別是多select出法人組織、年度、期別
#   LET l_sql = " SELECT DISTINCT t0.xccdcomp,t0.xccdld,t0.xccd001,t0.xccd003,t0.xccd004,t0.xccd005 ",
#               " FROM xccd_t t0",
#               "  INNER JOIN xcce_t ON xccdent = xcceent AND xccd006 = xcce006 AND xccd002 = xcce002 ",
#               "   AND xccdld = xcceld AND xccd001 = xcce001 AND xccd003 = xcce003 AND xccd004 = xcce004 AND xccd005 = xcce005 ",               
#               "  LEFT JOIN sfaa_t ON sfaaent = '"||g_enterprise||"' AND xccd006 = sfaadocno ",
#               " WHERE t0.xccdent = '" ||g_enterprise|| "' AND ",l_wc," AND ",l_wc2," AND ",l_wc4,
#               " UNION ",
#               " SELECT DISTINCT t0.xcchcomp,t0.xcchld,t0.xcch001,t0.xcch003,t0.xcch004,t0.xcch005 ",  
#               " FROM xcch_t t0",
#               "  INNER JOIN xcci_t ON xcchent = xccient AND xcch006 = xcci006 AND xcch002 = xcci002 ",
#               "   AND xcchld = xccild AND xcch001 = xcci001 AND xcch003 = xcci003 AND xcch004 = xcci004 AND xcch005 = xcci005 ",
#               "  LEFT JOIN sfaa_t ON sfaaent = '"||g_enterprise||"' AND xcch006 = sfaadocno ",  
#               " WHERE t0.xcchent = '" ||g_enterprise|| "' AND ",l_wc1," AND ",l_wc3," AND ",l_wc5, 
#               " ORDER BY 1,2,3,4"," ",g_order  
#               
#   PREPARE ins_tmp_pre FROM l_sql
#   DECLARE ins_tmp_cur CURSOR FOR ins_tmp_pre
#   #dorislai-20151021-add----(E)
   #160802-00020#4-mark-(E)
   IF 1=2 THEN
   #fengmy150215------end-----------
   #end add-point
   LET g_sql = g_sql, " ORDER BY ",l_searchcol," ",g_order
 
   #add-point:browser_fill,before_prepare
   END IF   #fengmy150215
   #end add-point
        
   #LET g_sql = cl_sql_add_tabid(g_sql,"xccd_t") #WC重組
   LET g_sql = cl_sql_add_mask(g_sql) #遮蔽特定資料
   PREPARE browse_pre FROM g_sql
   DECLARE browse_cur CURSOR FOR browse_pre
   
   #add-point:browser_fill段open cursor

   #end add-point
   
   FOREACH browse_cur INTO g_browser[g_cnt].b_statepic,g_browser[g_cnt].b_xccdld,g_browser[g_cnt].b_xccd001, 
       g_browser[g_cnt].b_xccd003,g_browser[g_cnt].b_xccd004,g_browser[g_cnt].b_xccd005
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = 'foreach:' 
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = TRUE 
         CALL cl_err()
         EXIT FOREACH
      END IF
  
      #add-point:browser_fill段reference

      #end add-point
  
      
      LET g_cnt = g_cnt + 1
      IF g_cnt > g_max_rec THEN
         EXIT FOREACH
      END IF
      
   END FOREACH
   
   IF cl_null(g_browser[g_cnt].b_xccdld) THEN
      CALL g_browser.deleteElement(g_cnt)
   END IF
    
   
   #清空填充狀態
   LET g_state = ""
   
   LET g_header_cnt  = g_browser.getLength()
   LET g_browser_cnt = g_browser.getLength()
   DISPLAY g_browser_cnt TO FORMONLY.b_count   #總筆數的顯示
   DISPLAY g_browser_cnt TO FORMONLY.h_count   #總筆數的顯示
   DISPLAY g_current_idx TO FORMONLY.b_index   #當下筆數的顯示
   DISPLAY g_current_idx TO FORMONLY.h_index   #當下筆數的顯示
 
   LET g_rec_b = g_cnt - 1
   LET g_detail_cnt = g_rec_b
   LET g_cnt = 0
   
   FREE browse_pre
   
   #若無資料則關閉相關功能
   IF g_browser_cnt = 0 THEN
      CALL cl_set_act_visible("statechange,modify,delete,reproduce", FALSE)
   ELSE
      CALL cl_set_act_visible("statechange,modify,delete,reproduce", TRUE)
   END IF
   
   #add-point:browser_fill段結束前

   #end add-point   
   
END FUNCTION
 
{</section>}
 
{<section id="axcq540.ui_headershow" >}
#+ 單頭資料重新顯示
PRIVATE FUNCTION axcq540_ui_headershow()
   #add-point:ui_headershow段define
   
   #end add-point    
   
   LET g_xccd_m.xccdld = g_browser[g_current_idx].b_xccdld   
   LET g_xccd_m.xccd001 = g_browser[g_current_idx].b_xccd001   
   LET g_xccd_m.xccd003 = g_browser[g_current_idx].b_xccd003   
   LET g_xccd_m.xccd004 = g_browser[g_current_idx].b_xccd004   
   LET g_xccd_m.xccd005 = g_browser[g_current_idx].b_xccd005   
 
   EXECUTE axcq540_master_referesh USING g_xccd_m.xccdld,g_xccd_m.xccd001,g_xccd_m.xccd003,g_xccd_m.xccd004, 
       g_xccd_m.xccd005 INTO g_xccd_m.xccdcomp,g_xccd_m.xccdld,g_xccd_m.xccd004,g_xccd_m.xccd005,g_xccd_m.xccd001, 
       g_xccd_m.xccd003,g_xccd_m.xccdcomp_desc,g_xccd_m.xccdld_desc,g_xccd_m.xccd003_desc
   CALL axcq540_show()
   
END FUNCTION
 
{</section>}
 
{<section id="axcq540.ui_detailshow" >}
#+ 單身資料重新顯示
PRIVATE FUNCTION axcq540_ui_detailshow()
   #add-point:ui_detailshow段define
   
   #end add-point    
   
   #add-point:ui_detailshow段before
   
   #end add-point    
   
   IF g_curr_diag IS NOT NULL THEN
      CALL g_curr_diag.setCurrentRow("s_detail1",g_detail_idx)      
      CALL g_curr_diag.setCurrentRow("s_detail2",g_detail_idx)
      CALL g_curr_diag.setCurrentRow("s_detail3",g_detail_idx)
 
   END IF
   
   #add-point:ui_detailshow段after
   
   #end add-point    
   
END FUNCTION
 
{</section>}
 
{<section id="axcq540.ui_browser_refresh" >}
#+ 瀏覽頁簽資料重新顯示
PRIVATE FUNCTION axcq540_ui_browser_refresh()
   DEFINE l_i  LIKE type_t.num10
   #add-point:ui_browser_refresh段define
   
   #end add-point    
   
   FOR l_i =1 TO g_browser.getLength()
      IF g_browser[l_i].b_xccdld = g_xccd_m.xccdld 
         AND g_browser[l_i].b_xccd001 = g_xccd_m.xccd001 
         AND g_browser[l_i].b_xccd003 = g_xccd_m.xccd003 
         AND g_browser[l_i].b_xccd004 = g_xccd_m.xccd004 
         AND g_browser[l_i].b_xccd005 = g_xccd_m.xccd005 
 
         THEN  
         CALL g_browser.deleteElement(l_i)
         LET g_header_cnt = g_header_cnt - 1
         EXIT FOR
      END IF
   END FOR
 
   LET g_browser_cnt = g_browser.getLength()
   #IF g_current_row > g_browser_cnt THEN        #確定browse 筆數指在同一筆
   #   LET g_current_row = g_browser_cnt
   #END IF
 
   #DISPLAY g_browser_cnt TO FORMONLY.b_count    #總筆數的顯示
   
END FUNCTION
 
{</section>}
 
{<section id="axcq540.construct" >}
#+ QBE資料查詢
PRIVATE FUNCTION axcq540_construct()
   DEFINE ls_return   STRING
   DEFINE ls_result   STRING 
   DEFINE ls_wc       STRING 
   #add-point:cs段define

   #end add-point    
 
   #清除畫面
   CLEAR FORM                
   INITIALIZE g_xccd_m.* TO NULL
   CALL g_xccd_d.clear()        
   CALL g_xccd2_d.clear() 
   CALL g_xccd3_d.clear() 
 
   
   LET g_action_choice = ""
    
   INITIALIZE g_wc TO NULL
   INITIALIZE g_wc2 TO NULL
   
   INITIALIZE g_wc2_table1 TO NULL
   INITIALIZE g_wc2_table2 TO NULL
 
   INITIALIZE g_wc2_table3 TO NULL
 
 
    
   LET g_qryparam.state = 'c'
   
   #add-point:cs段開始前
#fengmy150304------begin
   INITIALIZE g_wc2_table4 TO NULL
   INITIALIZE g_wc2_table5 TO NULL
   INITIALIZE g_wc2_table6 TO NULL
#fengmy150304------end
   #end add-point 
   
   #使用DIALOG包住 單頭CONSTRUCT及單身CONSTRUCT
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
      
      #單頭
      CONSTRUCT BY NAME g_wc ON xccdcomp,xccdld,xccd001,xccd003
 
         BEFORE CONSTRUCT
            #add-point:cs段before_construct
            CALL axcq540_default()
            #end add-point 
            
         #公用欄位開窗相關處理
         
            
         #一般欄位開窗相關處理    
                  #Ctrlp:construct.c.xccdcomp
         ON ACTION controlp INFIELD xccdcomp
            #add-point:ON ACTION controlp INFIELD xccdcomp
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            #160802-00020#10-add-(S)
            #增加法人過濾條件
            IF NOT cl_null(g_wc_cs_comp) THEN
               LET g_qryparam.where = " ooef001 IN ",g_wc_cs_comp
            END IF
            #160802-00020#10-add-(E)
            CALL q_ooef001_2()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO xccdcomp  #顯示到畫面上
            NEXT FIELD xccdcomp                     #返回原欄位
    


            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD xccdcomp
            #add-point:BEFORE FIELD xccdcomp

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD xccdcomp
            
            #add-point:AFTER FIELD xccdcomp

            #END add-point
            
 
         #Ctrlp:construct.c.xccdld
         ON ACTION controlp INFIELD xccdld
            #add-point:ON ACTION controlp INFIELD xccdld
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            #160802-00020#4-add-(S)
            LET g_qryparam.arg1 = g_user
            LET g_qryparam.arg2 = g_dept
            IF NOT cl_null(g_wc_cs_ld) THEN
               LET g_qryparam.where = " glaald IN ",g_wc_cs_ld
            END IF
            #160802-00020#4-add-(E)
            CALL q_authorised_ld()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO xccdld  #顯示到畫面上
            NEXT FIELD xccdld                     #返回原欄位
    


            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD xccdld
            #add-point:BEFORE FIELD xccdld

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD xccdld
            
            #add-point:AFTER FIELD xccdld

            #END add-point
            
 
         #此段落由子樣板a01產生
         BEFORE FIELD xccd004
            #add-point:BEFORE FIELD xccd004

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD xccd004
            
            #add-point:AFTER FIELD xccd004

            #END add-point
            
 
         #Ctrlp:construct.c.xccd004
         ON ACTION controlp INFIELD xccd004
            #add-point:ON ACTION controlp INFIELD xccd004

            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD xccd005
            #add-point:BEFORE FIELD xccd005

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD xccd005
            
            #add-point:AFTER FIELD xccd005

            #END add-point
            
 
         #Ctrlp:construct.c.xccd005
         ON ACTION controlp INFIELD xccd005
            #add-point:ON ACTION controlp INFIELD xccd005

            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD xccd001
            #add-point:BEFORE FIELD xccd001

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD xccd001
            
            #add-point:AFTER FIELD xccd001

            #END add-point
            
 
         #Ctrlp:construct.c.xccd001
         ON ACTION controlp INFIELD xccd001
            #add-point:ON ACTION controlp INFIELD xccd001

            #END add-point
 
         #此段落由子樣板a01產生

            #END add-point
 
 
            
 

 

            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD xccd003
            #add-point:BEFORE FIELD xccd003

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD xccd003
            
            #add-point:AFTER FIELD xccd003

            #END add-point
            
 
         #Ctrlp:construct.c.xccd003
         ON ACTION controlp INFIELD xccd003
            #add-point:ON ACTION controlp INFIELD xccd003

            #END add-point
 
 
         
      END CONSTRUCT
 
      #單身根據table分拆construct
#fengmy150215----begin  带出栏位不放开查询
 
#      CONSTRUCT g_wc2_table1 ON xccd006,xcce007,xcce008,xcce009,xccd002,xcce101,xcce102, 
#          xcce201,xcce202,xcce301,xcce302,xcce303,xcce304,xcce307,xcce308,xcce901,xcce902
#           FROM s_detail1[1].xccd006,s_detail1[1].xcce007,s_detail1[1].xcce008, 
#               s_detail1[1].xcce009,s_detail1[1].xccd002,s_detail1[1].xcce101,s_detail1[1].xcce102, 
#               s_detail1[1].xcce201,s_detail1[1].xcce202,s_detail1[1].xcce301,s_detail1[1].xcce302,s_detail1[1].xcce303, 
#               s_detail1[1].xcce304,s_detail1[1].xcce307,s_detail1[1].xcce308,s_detail1[1].xcce901,s_detail1[1].xcce902 
       CONSTRUCT g_wc2_table1 ON sfaa068,xccd006,xcce007,xcce008,xcce009,xcbb005,xccd002,xcce101,xcce102, 
           xcce201,xcce202,xcce301,xcce302,xcce303,xcce304,xcce307,xcce308,xcce901,xcce902
            FROM s_detail1[1].sfaa068,s_detail1[1].xccd006,s_detail1[1].xcce007,s_detail1[1].xcce008, 
                s_detail1[1].xcce009,s_detail1[1].xcbb005,s_detail1[1].xccd002,s_detail1[1].xcce101,s_detail1[1].xcce102, 
                s_detail1[1].xcce201,s_detail1[1].xcce202,s_detail1[1].xcce301,s_detail1[1].xcce302,s_detail1[1].xcce303, 
                s_detail1[1].xcce304,s_detail1[1].xcce307,s_detail1[1].xcce308,s_detail1[1].xcce901,s_detail1[1].xcce902
#fengmy150215----end
                      
         BEFORE CONSTRUCT
            #add-point:cs段before_construct

            #end add-point 
            
       #單身公用欄位開窗相關處理
       
         
       #單身一般欄位開窗相關處理
                #此段落由子樣板a01產生
         BEFORE FIELD sfaa068
            #add-point:BEFORE FIELD sfaa068

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD sfaa068
            
            #add-point:AFTER FIELD sfaa068

            #END add-point
            
 
         #Ctrlp:construct.c.page1.sfaa068
         ON ACTION controlp INFIELD sfaa068
            #add-point:ON ACTION controlp INFIELD sfaa068
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.arg1 = cl_get_today()
            CALL q_ooeg001_8()                        #呼叫開窗
            DISPLAY g_qryparam.return1 TO sfaa068  #顯示到畫面上
            NEXT FIELD sfaa068                     #返回原欄位
            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD xccd006
            #add-point:BEFORE FIELD xccd006

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD xccd006
            
            #add-point:AFTER FIELD xccd006

            #END add-point
            
 
         #Ctrlp:construct.c.page1.xccd006
         ON ACTION controlp INFIELD xccd006
            #add-point:ON ACTION controlp INFIELD xccd006
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_xccd006()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO xccd006  #顯示到畫面上
            NEXT FIELD xccd006                     #返回原欄位
            #END add-point
 
         ON ACTION controlp INFIELD xccd007
            #add-point:ON ACTION controlp INFIELD xccd006
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_xccd007()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO xccd007  #顯示到畫面上
            NEXT FIELD xccd007                     #返回原欄位
            
         #此段落由子樣板a01產生
         BEFORE FIELD xcce007
            #add-point:BEFORE FIELD xcce007

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD xcce007
            
            #add-point:AFTER FIELD xcce007

            #END add-point
            
 
         #Ctrlp:construct.c.page1.xcce007
         ON ACTION controlp INFIELD xcce007
            #add-point:ON ACTION controlp INFIELD xcce007
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_xcce007()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO xcce007  #顯示到畫面上
            NEXT FIELD xcce007                     #返回原欄位
            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD xcce008
            #add-point:BEFORE FIELD xcce008

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD xcce008
            
            #add-point:AFTER FIELD xcce008

            #END add-point
            
 
         #Ctrlp:construct.c.page1.xcce008
         ON ACTION controlp INFIELD xcce008
            #add-point:ON ACTION controlp INFIELD xcce008
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_xcce007()                           #呼叫開窗
            DISPLAY g_qryparam.return2 TO xcce008  #顯示到畫面上
            NEXT FIELD xcce008                     #返回原欄位
            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD xcce009
            #add-point:BEFORE FIELD xcce009

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD xcce009
            
            #add-point:AFTER FIELD xcce009

            #END add-point
            
 
         #Ctrlp:construct.c.page1.xcce009
         ON ACTION controlp INFIELD xcce009
            #add-point:ON ACTION controlp INFIELD xcce009
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_xcce007()                           #呼叫開窗
            DISPLAY g_qryparam.return3 TO xcce009  #顯示到畫面上
            NEXT FIELD xcce009                     #返回原欄位
            #END add-point
 
         #Ctrlp:construct.c.page1.xcbb005
         ON ACTION controlp INFIELD xcbb005
            #add-point:ON ACTION controlp INFIELD xcbb005
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_imac003()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO xcbb005  #顯示到畫面上
            NEXT FIELD xcbb005                     #返回原欄位
    


            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD xcbb005
            #add-point:BEFORE FIELD xcbb005

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD xcbb005
            
            #add-point:AFTER FIELD xcbb005

            #END add-point
            
 
         #此段落由子樣板a01產生
         BEFORE FIELD xccd002
            #add-point:BEFORE FIELD xccd002

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD xccd002
            
            #add-point:AFTER FIELD xccd002

            #END add-point
            
 
         #Ctrlp:construct.c.page1.xccd002
         ON ACTION controlp INFIELD xccd002
            #add-point:ON ACTION controlp INFIELD xccd002

            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD xcce101
            #add-point:BEFORE FIELD xcce101

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD xcce101
            
            #add-point:AFTER FIELD xcce101

            #END add-point
            
 
         #Ctrlp:construct.c.page1.xcce101
         ON ACTION controlp INFIELD xcce101
            #add-point:ON ACTION controlp INFIELD xcce101

            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD xcce102
            #add-point:BEFORE FIELD xcce102

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD xcce102
            
            #add-point:AFTER FIELD xcce102

            #END add-point
            
 
         #Ctrlp:construct.c.page1.xcce102
         ON ACTION controlp INFIELD xcce102
            #add-point:ON ACTION controlp INFIELD xcce102

            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD xcce201
            #add-point:BEFORE FIELD xcce201

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD xcce201
            
            #add-point:AFTER FIELD xcce201

            #END add-point
            
 
         #Ctrlp:construct.c.page1.xcce201
         ON ACTION controlp INFIELD xcce201
            #add-point:ON ACTION controlp INFIELD xcce201

            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD xcce202
            #add-point:BEFORE FIELD xcce202

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD xcce202
            
            #add-point:AFTER FIELD xcce202

            #END add-point
            
 
         #Ctrlp:construct.c.page1.xcce202
         ON ACTION controlp INFIELD xcce202
            #add-point:ON ACTION controlp INFIELD xcce202

            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD xcce301
            #add-point:BEFORE FIELD xcce301

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD xcce301
            
            #add-point:AFTER FIELD xcce301

            #END add-point
            
 
         #Ctrlp:construct.c.page1.xcce301
         ON ACTION controlp INFIELD xcce301
            #add-point:ON ACTION controlp INFIELD xcce301

            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD xcce302
            #add-point:BEFORE FIELD xcce302

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD xcce302
            
            #add-point:AFTER FIELD xcce302

            #END add-point
            
 
         #Ctrlp:construct.c.page1.xcce302
         ON ACTION controlp INFIELD xcce302
            #add-point:ON ACTION controlp INFIELD xcce302

            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD xcce303
            #add-point:BEFORE FIELD xcce303

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD xcce303
            
            #add-point:AFTER FIELD xcce303

            #END add-point
            
 
         #Ctrlp:construct.c.page1.xcce303
         ON ACTION controlp INFIELD xcce303
            #add-point:ON ACTION controlp INFIELD xcce303

            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD xcce304
            #add-point:BEFORE FIELD xcce304

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD xcce304
            
            #add-point:AFTER FIELD xcce304

            #END add-point
            
 
         #Ctrlp:construct.c.page1.xcce304
         ON ACTION controlp INFIELD xcce304
            #add-point:ON ACTION controlp INFIELD xcce304

            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD xcce307
            #add-point:BEFORE FIELD xcce307

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD xcce307
            
            #add-point:AFTER FIELD xcce307

            #END add-point
            
 
         #Ctrlp:construct.c.page1.xcce307
         ON ACTION controlp INFIELD xcce307
            #add-point:ON ACTION controlp INFIELD xcce307

            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD xcce308
            #add-point:BEFORE FIELD xcce308

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD xcce308
            
            #add-point:AFTER FIELD xcce308

            #END add-point
            
 
         #Ctrlp:construct.c.page1.xcce308
         ON ACTION controlp INFIELD xcce308
            #add-point:ON ACTION controlp INFIELD xcce308

            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD xcce901
            #add-point:BEFORE FIELD xcce901

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD xcce901
            
            #add-point:AFTER FIELD xcce901

            #END add-point
            
 
         #Ctrlp:construct.c.page1.xcce901
         ON ACTION controlp INFIELD xcce901
            #add-point:ON ACTION controlp INFIELD xcce901

            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD xcce902
            #add-point:BEFORE FIELD xcce902

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD xcce902
            
            #add-point:AFTER FIELD xcce902

            #END add-point
            
 
         #Ctrlp:construct.c.page1.xcce902
         ON ACTION controlp INFIELD xcce902
            #add-point:ON ACTION controlp INFIELD xcce902

            #END add-point
 
   
       
      END CONSTRUCT
  
      CONSTRUCT g_wc2_table2 ON xcce102a,xcce102b,xcce102c,xcce102d,xcce102e,xcce102f,xcce102g,xcce102h, 
          xcce201,xcce202a,xcce202b,xcce202c,xcce202d,xcce202e,xcce202f,xcce202g,xcce202h,xcce301,xcce302a, 
          xcce302b,xcce302c,xcce302d,xcce302e,xcce302f,xcce302g,xcce302h,xcce303,xcce304a,xcce304b,xcce304c, 
          xcce304d,xcce304e,xcce304f,xcce304g,xcce304h,xcce307,xcce308a,xcce308b,xcce308c,xcce308d,xcce308e, 
          xcce308f,xcce308g,xcce308h,xcce901,xcce902a,xcce902b,xcce902c,xcce902d,xcce902e,xcce902f,xcce902g, 
          xcce902h
          ,xcce006,xcce007,xcce008,xcce009,xcce002,xcce101,sfaa068     #fengmy150303
           FROM s_detail2[1].xcce102a,s_detail2[1].xcce102b,s_detail2[1].xcce102c,s_detail2[1].xcce102d, 
               s_detail2[1].xcce102e,s_detail2[1].xcce102f,s_detail2[1].xcce102g,s_detail2[1].xcce102h, 
               s_detail2[1].xcce201,s_detail2[1].xcce202a,s_detail2[1].xcce202b,s_detail2[1].xcce202c, 
               s_detail2[1].xcce202d,s_detail2[1].xcce202e,s_detail2[1].xcce202f,s_detail2[1].xcce202g, 
               s_detail2[1].xcce202h,s_detail2[1].xcce301,s_detail2[1].xcce302a,s_detail2[1].xcce302b, 
               s_detail2[1].xcce302c,s_detail2[1].xcce302d,s_detail2[1].xcce302e,s_detail2[1].xcce302f, 
               s_detail2[1].xcce302g,s_detail2[1].xcce302h,s_detail2[1].xcce303,s_detail2[1].xcce304a, 
               s_detail2[1].xcce304b,s_detail2[1].xcce304c,s_detail2[1].xcce304d,s_detail2[1].xcce304e, 
               s_detail2[1].xcce304f,s_detail2[1].xcce304g,s_detail2[1].xcce304h,s_detail2[1].xcce307, 
               s_detail2[1].xcce308a,s_detail2[1].xcce308b,s_detail2[1].xcce308c,s_detail2[1].xcce308d, 
               s_detail2[1].xcce308e,s_detail2[1].xcce308f,s_detail2[1].xcce308g,s_detail2[1].xcce308h, 
               s_detail2[1].xcce901,s_detail2[1].xcce902a,s_detail2[1].xcce902b,s_detail2[1].xcce902c, 
               s_detail2[1].xcce902d,s_detail2[1].xcce902e,s_detail2[1].xcce902f,s_detail2[1].xcce902g, 
               s_detail2[1].xcce902h
               ,s_detail2[1].xcce006_2,s_detail2[1].xcce007_2,s_detail2[1].xcce008_2,s_detail2[1].xcce009_2,  #fengmy150303 
               s_detail2[1].xcce002_2,s_detail2[1].xcce101_2,s_detail2[1].sfaa068_2 #fengmy150303 
                
                      
         BEFORE CONSTRUCT
            #add-point:cs段before_construct

            #end add-point 
            
       #單身公用欄位開窗相關處理(table 2)
        ON ACTION controlp INFIELD sfaa068_2
            #add-point:ON ACTION controlp INFIELD sfaa068
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.arg1 = cl_get_today()
            CALL q_ooeg001_8()                        #呼叫開窗
            DISPLAY g_qryparam.return1 TO sfaa068_2  #顯示到畫面上
            NEXT FIELD sfaa068_2                     #返回原欄位  
            
         ON ACTION controlp INFIELD xcce007_2
            #add-point:ON ACTION controlp INFIELD xcce007
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_xcce007()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO xcce007_2  #顯示到畫面上
            NEXT FIELD xcce007_2                     #返回原欄位
            #END add-point
            
        ON ACTION controlp INFIELD xcce008_2
            #add-point:ON ACTION controlp INFIELD xcce008
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_xcce007()                           #呼叫開窗
            DISPLAY g_qryparam.return2 TO xcce008_2  #顯示到畫面上
            NEXT FIELD xcce008_2                     #返回原欄位
            #END add-point
            
            
        ON ACTION controlp INFIELD xcce009_2
            #add-point:ON ACTION controlp INFIELD xcce009
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_xcce007()                           #呼叫開窗
            DISPLAY g_qryparam.return3 TO xcce009_2  #顯示到畫面上
            NEXT FIELD xcce009_2                     #返回原欄位
            #END add-point       
       #單身一般欄位開窗相關處理       
                #此段落由子樣板a01產生
         BEFORE FIELD xcce102a
            #add-point:BEFORE FIELD xcce102a

            #END add-point
         ON ACTION controlp INFIELD xcce006_2
            #add-point:ON ACTION controlp INFIELD xccd006
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_xccd006()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO xcce006_2  #顯示到畫面上
            NEXT FIELD xcce006_2
         #此段落由子樣板a02產生
         AFTER FIELD xcce102a
            
            #add-point:AFTER FIELD xcce102a

            #END add-point
            
 
         #Ctrlp:construct.c.page2.xcce102a
         ON ACTION controlp INFIELD xcce102a
            #add-point:ON ACTION controlp INFIELD xcce102a

            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD xcce102b
            #add-point:BEFORE FIELD xcce102b

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD xcce102b
            
            #add-point:AFTER FIELD xcce102b

            #END add-point
            
 
         #Ctrlp:construct.c.page2.xcce102b
         ON ACTION controlp INFIELD xcce102b
            #add-point:ON ACTION controlp INFIELD xcce102b

            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD xcce102c
            #add-point:BEFORE FIELD xcce102c

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD xcce102c
            
            #add-point:AFTER FIELD xcce102c

            #END add-point
            
 
         #Ctrlp:construct.c.page2.xcce102c
         ON ACTION controlp INFIELD xcce102c
            #add-point:ON ACTION controlp INFIELD xcce102c

            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD xcce102d
            #add-point:BEFORE FIELD xcce102d

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD xcce102d
            
            #add-point:AFTER FIELD xcce102d

            #END add-point
            
 
         #Ctrlp:construct.c.page2.xcce102d
         ON ACTION controlp INFIELD xcce102d
            #add-point:ON ACTION controlp INFIELD xcce102d

            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD xcce102e
            #add-point:BEFORE FIELD xcce102e

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD xcce102e
            
            #add-point:AFTER FIELD xcce102e

            #END add-point
            
 
         #Ctrlp:construct.c.page2.xcce102e
         ON ACTION controlp INFIELD xcce102e
            #add-point:ON ACTION controlp INFIELD xcce102e

            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD xcce102f
            #add-point:BEFORE FIELD xcce102f

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD xcce102f
            
            #add-point:AFTER FIELD xcce102f

            #END add-point
            
 
         #Ctrlp:construct.c.page2.xcce102f
         ON ACTION controlp INFIELD xcce102f
            #add-point:ON ACTION controlp INFIELD xcce102f

            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD xcce102g
            #add-point:BEFORE FIELD xcce102g

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD xcce102g
            
            #add-point:AFTER FIELD xcce102g

            #END add-point
            
 
         #Ctrlp:construct.c.page2.xcce102g
         ON ACTION controlp INFIELD xcce102g
            #add-point:ON ACTION controlp INFIELD xcce102g

            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD xcce102h
            #add-point:BEFORE FIELD xcce102h

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD xcce102h
            
            #add-point:AFTER FIELD xcce102h

            #END add-point
            
 
         #Ctrlp:construct.c.page2.xcce102h
         ON ACTION controlp INFIELD xcce102h
            #add-point:ON ACTION controlp INFIELD xcce102h

            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD xcce102
            #add-point:BEFORE FIELD xcce102

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD xcce102
            
            #add-point:AFTER FIELD xcce102

            #END add-point
            
 
         #Ctrlp:construct.c.page2.xcce102
         ON ACTION controlp INFIELD xcce102
            #add-point:ON ACTION controlp INFIELD xcce102

            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD xcce201
            #add-point:BEFORE FIELD xcce201

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD xcce201
            
            #add-point:AFTER FIELD xcce201

            #END add-point
            
 
         #Ctrlp:construct.c.page2.xcce201
         ON ACTION controlp INFIELD xcce201
            #add-point:ON ACTION controlp INFIELD xcce201

            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD xcce202a
            #add-point:BEFORE FIELD xcce202a

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD xcce202a
            
            #add-point:AFTER FIELD xcce202a

            #END add-point
            
 
         #Ctrlp:construct.c.page2.xcce202a
         ON ACTION controlp INFIELD xcce202a
            #add-point:ON ACTION controlp INFIELD xcce202a

            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD xcce202b
            #add-point:BEFORE FIELD xcce202b

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD xcce202b
            
            #add-point:AFTER FIELD xcce202b

            #END add-point
            
 
         #Ctrlp:construct.c.page2.xcce202b
         ON ACTION controlp INFIELD xcce202b
            #add-point:ON ACTION controlp INFIELD xcce202b

            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD xcce202c
            #add-point:BEFORE FIELD xcce202c

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD xcce202c
            
            #add-point:AFTER FIELD xcce202c

            #END add-point
            
 
         #Ctrlp:construct.c.page2.xcce202c
         ON ACTION controlp INFIELD xcce202c
            #add-point:ON ACTION controlp INFIELD xcce202c

            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD xcce202d
            #add-point:BEFORE FIELD xcce202d

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD xcce202d
            
            #add-point:AFTER FIELD xcce202d

            #END add-point
            
 
         #Ctrlp:construct.c.page2.xcce202d
         ON ACTION controlp INFIELD xcce202d
            #add-point:ON ACTION controlp INFIELD xcce202d

            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD xcce202e
            #add-point:BEFORE FIELD xcce202e

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD xcce202e
            
            #add-point:AFTER FIELD xcce202e

            #END add-point
            
 
         #Ctrlp:construct.c.page2.xcce202e
         ON ACTION controlp INFIELD xcce202e
            #add-point:ON ACTION controlp INFIELD xcce202e

            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD xcce202f
            #add-point:BEFORE FIELD xcce202f

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD xcce202f
            
            #add-point:AFTER FIELD xcce202f

            #END add-point
            
 
         #Ctrlp:construct.c.page2.xcce202f
         ON ACTION controlp INFIELD xcce202f
            #add-point:ON ACTION controlp INFIELD xcce202f

            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD xcce202g
            #add-point:BEFORE FIELD xcce202g

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD xcce202g
            
            #add-point:AFTER FIELD xcce202g

            #END add-point
            
 
         #Ctrlp:construct.c.page2.xcce202g
         ON ACTION controlp INFIELD xcce202g
            #add-point:ON ACTION controlp INFIELD xcce202g

            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD xcce202h
            #add-point:BEFORE FIELD xcce202h

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD xcce202h
            
            #add-point:AFTER FIELD xcce202h

            #END add-point
            
 
         #Ctrlp:construct.c.page2.xcce202h
         ON ACTION controlp INFIELD xcce202h
            #add-point:ON ACTION controlp INFIELD xcce202h

            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD xcce202
            #add-point:BEFORE FIELD xcce202

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD xcce202
            
            #add-point:AFTER FIELD xcce202

            #END add-point
            
 
         #Ctrlp:construct.c.page2.xcce202
         ON ACTION controlp INFIELD xcce202
            #add-point:ON ACTION controlp INFIELD xcce202

            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD xcce301
            #add-point:BEFORE FIELD xcce301

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD xcce301
            
            #add-point:AFTER FIELD xcce301

            #END add-point
            
 
         #Ctrlp:construct.c.page2.xcce301
         ON ACTION controlp INFIELD xcce301
            #add-point:ON ACTION controlp INFIELD xcce301

            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD xcce302a
            #add-point:BEFORE FIELD xcce302a

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD xcce302a
            
            #add-point:AFTER FIELD xcce302a

            #END add-point
            
 
         #Ctrlp:construct.c.page2.xcce302a
         ON ACTION controlp INFIELD xcce302a
            #add-point:ON ACTION controlp INFIELD xcce302a

            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD xcce302b
            #add-point:BEFORE FIELD xcce302b

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD xcce302b
            
            #add-point:AFTER FIELD xcce302b

            #END add-point
            
 
         #Ctrlp:construct.c.page2.xcce302b
         ON ACTION controlp INFIELD xcce302b
            #add-point:ON ACTION controlp INFIELD xcce302b

            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD xcce302c
            #add-point:BEFORE FIELD xcce302c

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD xcce302c
            
            #add-point:AFTER FIELD xcce302c

            #END add-point
            
 
         #Ctrlp:construct.c.page2.xcce302c
         ON ACTION controlp INFIELD xcce302c
            #add-point:ON ACTION controlp INFIELD xcce302c

            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD xcce302d
            #add-point:BEFORE FIELD xcce302d

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD xcce302d
            
            #add-point:AFTER FIELD xcce302d

            #END add-point
            
 
         #Ctrlp:construct.c.page2.xcce302d
         ON ACTION controlp INFIELD xcce302d
            #add-point:ON ACTION controlp INFIELD xcce302d

            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD xcce302e
            #add-point:BEFORE FIELD xcce302e

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD xcce302e
            
            #add-point:AFTER FIELD xcce302e

            #END add-point
            
 
         #Ctrlp:construct.c.page2.xcce302e
         ON ACTION controlp INFIELD xcce302e
            #add-point:ON ACTION controlp INFIELD xcce302e

            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD xcce302f
            #add-point:BEFORE FIELD xcce302f

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD xcce302f
            
            #add-point:AFTER FIELD xcce302f

            #END add-point
            
 
         #Ctrlp:construct.c.page2.xcce302f
         ON ACTION controlp INFIELD xcce302f
            #add-point:ON ACTION controlp INFIELD xcce302f

            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD xcce302g
            #add-point:BEFORE FIELD xcce302g

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD xcce302g
            
            #add-point:AFTER FIELD xcce302g

            #END add-point
            
 
         #Ctrlp:construct.c.page2.xcce302g
         ON ACTION controlp INFIELD xcce302g
            #add-point:ON ACTION controlp INFIELD xcce302g

            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD xcce302h
            #add-point:BEFORE FIELD xcce302h

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD xcce302h
            
            #add-point:AFTER FIELD xcce302h

            #END add-point
            
 
         #Ctrlp:construct.c.page2.xcce302h
         ON ACTION controlp INFIELD xcce302h
            #add-point:ON ACTION controlp INFIELD xcce302h

            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD xcce302
            #add-point:BEFORE FIELD xcce302

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD xcce302
            
            #add-point:AFTER FIELD xcce302

            #END add-point
            
 
         #Ctrlp:construct.c.page2.xcce302
         ON ACTION controlp INFIELD xcce302
            #add-point:ON ACTION controlp INFIELD xcce302

            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD xcce303
            #add-point:BEFORE FIELD xcce303

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD xcce303
            
            #add-point:AFTER FIELD xcce303

            #END add-point
            
 
         #Ctrlp:construct.c.page2.xcce303
         ON ACTION controlp INFIELD xcce303
            #add-point:ON ACTION controlp INFIELD xcce303

            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD xcce304a
            #add-point:BEFORE FIELD xcce304a

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD xcce304a
            
            #add-point:AFTER FIELD xcce304a

            #END add-point
            
 
         #Ctrlp:construct.c.page2.xcce304a
         ON ACTION controlp INFIELD xcce304a
            #add-point:ON ACTION controlp INFIELD xcce304a

            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD xcce304b
            #add-point:BEFORE FIELD xcce304b

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD xcce304b
            
            #add-point:AFTER FIELD xcce304b

            #END add-point
            
 
         #Ctrlp:construct.c.page2.xcce304b
         ON ACTION controlp INFIELD xcce304b
            #add-point:ON ACTION controlp INFIELD xcce304b

            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD xcce304c
            #add-point:BEFORE FIELD xcce304c

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD xcce304c
            
            #add-point:AFTER FIELD xcce304c

            #END add-point
            
 
         #Ctrlp:construct.c.page2.xcce304c
         ON ACTION controlp INFIELD xcce304c
            #add-point:ON ACTION controlp INFIELD xcce304c

            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD xcce304d
            #add-point:BEFORE FIELD xcce304d

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD xcce304d
            
            #add-point:AFTER FIELD xcce304d

            #END add-point
            
 
         #Ctrlp:construct.c.page2.xcce304d
         ON ACTION controlp INFIELD xcce304d
            #add-point:ON ACTION controlp INFIELD xcce304d

            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD xcce304e
            #add-point:BEFORE FIELD xcce304e

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD xcce304e
            
            #add-point:AFTER FIELD xcce304e

            #END add-point
            
 
         #Ctrlp:construct.c.page2.xcce304e
         ON ACTION controlp INFIELD xcce304e
            #add-point:ON ACTION controlp INFIELD xcce304e

            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD xcce304f
            #add-point:BEFORE FIELD xcce304f

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD xcce304f
            
            #add-point:AFTER FIELD xcce304f

            #END add-point
            
 
         #Ctrlp:construct.c.page2.xcce304f
         ON ACTION controlp INFIELD xcce304f
            #add-point:ON ACTION controlp INFIELD xcce304f

            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD xcce304g
            #add-point:BEFORE FIELD xcce304g

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD xcce304g
            
            #add-point:AFTER FIELD xcce304g

            #END add-point
            
 
         #Ctrlp:construct.c.page2.xcce304g
         ON ACTION controlp INFIELD xcce304g
            #add-point:ON ACTION controlp INFIELD xcce304g

            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD xcce304h
            #add-point:BEFORE FIELD xcce304h

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD xcce304h
            
            #add-point:AFTER FIELD xcce304h

            #END add-point
            
 
         #Ctrlp:construct.c.page2.xcce304h
         ON ACTION controlp INFIELD xcce304h
            #add-point:ON ACTION controlp INFIELD xcce304h

            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD xcce304
            #add-point:BEFORE FIELD xcce304

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD xcce304
            
            #add-point:AFTER FIELD xcce304

            #END add-point
            
 
         #Ctrlp:construct.c.page2.xcce304
         ON ACTION controlp INFIELD xcce304
            #add-point:ON ACTION controlp INFIELD xcce304

            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD xcce307
            #add-point:BEFORE FIELD xcce307

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD xcce307
            
            #add-point:AFTER FIELD xcce307

            #END add-point
            
 
         #Ctrlp:construct.c.page2.xcce307
         ON ACTION controlp INFIELD xcce307
            #add-point:ON ACTION controlp INFIELD xcce307

            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD xcce308a
            #add-point:BEFORE FIELD xcce308a

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD xcce308a
            
            #add-point:AFTER FIELD xcce308a

            #END add-point
            
 
         #Ctrlp:construct.c.page2.xcce308a
         ON ACTION controlp INFIELD xcce308a
            #add-point:ON ACTION controlp INFIELD xcce308a

            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD xcce308b
            #add-point:BEFORE FIELD xcce308b

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD xcce308b
            
            #add-point:AFTER FIELD xcce308b

            #END add-point
            
 
         #Ctrlp:construct.c.page2.xcce308b
         ON ACTION controlp INFIELD xcce308b
            #add-point:ON ACTION controlp INFIELD xcce308b

            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD xcce308c
            #add-point:BEFORE FIELD xcce308c

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD xcce308c
            
            #add-point:AFTER FIELD xcce308c

            #END add-point
            
 
         #Ctrlp:construct.c.page2.xcce308c
         ON ACTION controlp INFIELD xcce308c
            #add-point:ON ACTION controlp INFIELD xcce308c

            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD xcce308d
            #add-point:BEFORE FIELD xcce308d

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD xcce308d
            
            #add-point:AFTER FIELD xcce308d

            #END add-point
            
 
         #Ctrlp:construct.c.page2.xcce308d
         ON ACTION controlp INFIELD xcce308d
            #add-point:ON ACTION controlp INFIELD xcce308d

            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD xcce308e
            #add-point:BEFORE FIELD xcce308e

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD xcce308e
            
            #add-point:AFTER FIELD xcce308e

            #END add-point
            
 
         #Ctrlp:construct.c.page2.xcce308e
         ON ACTION controlp INFIELD xcce308e
            #add-point:ON ACTION controlp INFIELD xcce308e

            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD xcce308f
            #add-point:BEFORE FIELD xcce308f

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD xcce308f
            
            #add-point:AFTER FIELD xcce308f

            #END add-point
            
 
         #Ctrlp:construct.c.page2.xcce308f
         ON ACTION controlp INFIELD xcce308f
            #add-point:ON ACTION controlp INFIELD xcce308f

            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD xcce308g
            #add-point:BEFORE FIELD xcce308g

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD xcce308g
            
            #add-point:AFTER FIELD xcce308g

            #END add-point
            
 
         #Ctrlp:construct.c.page2.xcce308g
         ON ACTION controlp INFIELD xcce308g
            #add-point:ON ACTION controlp INFIELD xcce308g

            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD xcce308h
            #add-point:BEFORE FIELD xcce308h

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD xcce308h
            
            #add-point:AFTER FIELD xcce308h

            #END add-point
            
 
         #Ctrlp:construct.c.page2.xcce308h
         ON ACTION controlp INFIELD xcce308h
            #add-point:ON ACTION controlp INFIELD xcce308h

            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD xcce308
            #add-point:BEFORE FIELD xcce308

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD xcce308
            
            #add-point:AFTER FIELD xcce308

            #END add-point
            
 
         #Ctrlp:construct.c.page2.xcce308
         ON ACTION controlp INFIELD xcce308
            #add-point:ON ACTION controlp INFIELD xcce308

            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD xcce901
            #add-point:BEFORE FIELD xcce901

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD xcce901
            
            #add-point:AFTER FIELD xcce901

            #END add-point
            
 
         #Ctrlp:construct.c.page2.xcce901
         ON ACTION controlp INFIELD xcce901
            #add-point:ON ACTION controlp INFIELD xcce901

            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD xcce902a
            #add-point:BEFORE FIELD xcce902a

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD xcce902a
            
            #add-point:AFTER FIELD xcce902a

            #END add-point
            
 
         #Ctrlp:construct.c.page2.xcce902a
         ON ACTION controlp INFIELD xcce902a
            #add-point:ON ACTION controlp INFIELD xcce902a

            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD xcce902b
            #add-point:BEFORE FIELD xcce902b

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD xcce902b
            
            #add-point:AFTER FIELD xcce902b

            #END add-point
            
 
         #Ctrlp:construct.c.page2.xcce902b
         ON ACTION controlp INFIELD xcce902b
            #add-point:ON ACTION controlp INFIELD xcce902b

            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD xcce902c
            #add-point:BEFORE FIELD xcce902c

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD xcce902c
            
            #add-point:AFTER FIELD xcce902c

            #END add-point
            
 
         #Ctrlp:construct.c.page2.xcce902c
         ON ACTION controlp INFIELD xcce902c
            #add-point:ON ACTION controlp INFIELD xcce902c

            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD xcce902d
            #add-point:BEFORE FIELD xcce902d

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD xcce902d
            
            #add-point:AFTER FIELD xcce902d

            #END add-point
            
 
         #Ctrlp:construct.c.page2.xcce902d
         ON ACTION controlp INFIELD xcce902d
            #add-point:ON ACTION controlp INFIELD xcce902d

            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD xcce902e
            #add-point:BEFORE FIELD xcce902e

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD xcce902e
            
            #add-point:AFTER FIELD xcce902e

            #END add-point
            
 
         #Ctrlp:construct.c.page2.xcce902e
         ON ACTION controlp INFIELD xcce902e
            #add-point:ON ACTION controlp INFIELD xcce902e

            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD xcce902f
            #add-point:BEFORE FIELD xcce902f

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD xcce902f
            
            #add-point:AFTER FIELD xcce902f

            #END add-point
            
 
         #Ctrlp:construct.c.page2.xcce902f
         ON ACTION controlp INFIELD xcce902f
            #add-point:ON ACTION controlp INFIELD xcce902f

            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD xcce902g
            #add-point:BEFORE FIELD xcce902g

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD xcce902g
            
            #add-point:AFTER FIELD xcce902g

            #END add-point
            
 
         #Ctrlp:construct.c.page2.xcce902g
         ON ACTION controlp INFIELD xcce902g
            #add-point:ON ACTION controlp INFIELD xcce902g

            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD xcce902h
            #add-point:BEFORE FIELD xcce902h

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD xcce902h
            
            #add-point:AFTER FIELD xcce902h

            #END add-point
            
 
         #Ctrlp:construct.c.page2.xcce902h
         ON ACTION controlp INFIELD xcce902h
            #add-point:ON ACTION controlp INFIELD xcce902h

            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD xcce902
            #add-point:BEFORE FIELD xcce902

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD xcce902
            
            #add-point:AFTER FIELD xcce902

            #END add-point
            
 
         #Ctrlp:construct.c.page2.xcce902
         ON ACTION controlp INFIELD xcce902
            #add-point:ON ACTION controlp INFIELD xcce902

            #END add-point
 
   
       
      END CONSTRUCT
 
      CONSTRUCT g_wc2_table3 ON xcci006,xcci007,xcci008,xcci009,xcci002
           ,sfaa068         #fengmy150303
           FROM s_detail3[1].xcci006,s_detail3[1].xcci007,s_detail3[1].xcci008,s_detail3[1].xcci009,s_detail3[1].xcci002
                ,s_detail3[1].sfaa068_3         #fengmy150303      
         BEFORE CONSTRUCT
            #add-point:cs段before_construct

            #end add-point 
            
       #單身公用欄位開窗相關處理(table 3)
       
        ON ACTION controlp INFIELD sfaa068_3
            #add-point:ON ACTION controlp INFIELD sfaa068
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.arg1 = cl_get_today()
            CALL q_ooeg001_8()                        #呼叫開窗
            DISPLAY g_qryparam.return1 TO sfaa068_3  #顯示到畫面上
            NEXT FIELD sfaa068_3                     #返回原欄位         
       #單身一般欄位開窗相關處理       
                #此段落由子樣板a01產生
         BEFORE FIELD xcci006
            #add-point:BEFORE FIELD xcci006

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD xcci006
            
            #add-point:AFTER FIELD xcci006

            #END add-point
            
 
         #Ctrlp:construct.c.page3.xcci006
         ON ACTION controlp INFIELD xcci006
            #add-point:ON ACTION controlp INFIELD xcci006
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_xcch006()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO xcci006  #顯示到畫面上
            NEXT FIELD xcci006
            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD xcci007
            #add-point:BEFORE FIELD xcci007

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD xcci007
            
            #add-point:AFTER FIELD xcci007

            #END add-point
            
 
         #Ctrlp:construct.c.page3.xcci007
         ON ACTION controlp INFIELD xcci007
            #add-point:ON ACTION controlp INFIELD xcci007
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_xcci007()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO xcci007  #顯示到畫面上
            NEXT FIELD xcci007                     #返回原欄位
            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD xcci008
            #add-point:BEFORE FIELD xcci008

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD xcci008
            
            #add-point:AFTER FIELD xcci008

            #END add-point
            
 
         #Ctrlp:construct.c.page3.xcci008
         ON ACTION controlp INFIELD xcci008
            #add-point:ON ACTION controlp INFIELD xcci008
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_xcci007()                           #呼叫開窗
            DISPLAY g_qryparam.return2 TO xcci008  #顯示到畫面上
            NEXT FIELD xcci008                     #返回原欄位
            #END add-point
        ON ACTION controlp INFIELD xcci009
            #add-point:ON ACTION controlp INFIELD xcci009
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_xcci007()                           #呼叫開窗
            DISPLAY g_qryparam.return3 TO xcci009  #顯示到畫面上
            NEXT FIELD xcci009                     #返回原欄位
         #此段落由子樣板a01產生
         BEFORE FIELD xcci002
            #add-point:BEFORE FIELD xcci002

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD xcci002
            
            #add-point:AFTER FIELD xcci002

            #END add-point
            
 
         #Ctrlp:construct.c.page3.xcci002
         ON ACTION controlp INFIELD xcci002
            #add-point:ON ACTION controlp INFIELD xcci002

            #END add-point
 
   
       
      END CONSTRUCT
 
 
      
 
      
      #add-point:cs段add_cs(本段內只能出現新的CONSTRUCT指令)
      #fengmy150304---begin
      CONSTRUCT g_wc2_table4 ON xccd007
           FROM s_detail1[1].xccd007
         ON ACTION controlp INFIELD xccd007
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_xccd007()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO xccd007  #顯示到畫面上
            NEXT FIELD xccd007                     #返回原欄位
    
      END CONSTRUCT 
      CONSTRUCT g_wc2_table5 ON xccd007
           FROM s_detail2[1].xccd007_2
         ON ACTION controlp INFIELD xccd007_2
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_xccd007()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO xccd007_2  #顯示到畫面上
            NEXT FIELD xccd007_2                     #返回原欄位
      END CONSTRUCT 
      
      CONSTRUCT g_wc2_table6 ON xcch007
           FROM s_detail3[1].xcch007
         ON ACTION controlp INFIELD xcch007
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_xcch007()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO xcch007  #顯示到畫面上
            NEXT FIELD xcch007                     #返回原欄位
            
      END CONSTRUCT      
      #fengmy150304---end
      #fengmy150806---begin
      INPUT g_yy1,g_mm1,g_yy2,g_mm2 FROM xccd004,xccd005,xccd004_1,xccd005_1
         AFTER FIELD xccd004 
            IF NOT cl_null(g_yy1) AND NOT cl_null(g_yy2) THEN
                IF g_yy1 > g_yy2 THEN
                   INITIALIZE g_errparam TO NULL
                   LET g_errparam.code = 'acr-00064'
                   LET g_errparam.extend = ''
                   LET g_errparam.popup = TRUE
                   CALL cl_err()
                   NEXT FIELD xccd004
                END IF
             END IF
         AFTER FIELD xccd005
            IF NOT cl_null(g_mm1) AND NOT cl_null(g_mm2) THEN
               #IF g_mm1 > g_mm2 THEN   #160812-00009#1 mark
               IF g_mm1 > g_mm2 AND g_yy1 = g_yy2 THEN   #160812-00009#1 add
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'acr-00067'
                  LET g_errparam.extend = ''
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
                  NEXT FIELD xccd005
               END IF
            END IF
         AFTER FIELD xccd004_1
            IF NOT cl_null(g_yy1) AND NOT cl_null(g_yy2) THEN
                IF g_yy1 > g_yy2 THEN
                   INITIALIZE g_errparam TO NULL
                   LET g_errparam.code = 'acr-00064'
                   LET g_errparam.extend = ''
                   LET g_errparam.popup = TRUE
                   CALL cl_err()
                   NEXT FIELD xccd004_1
                END IF
             END IF
         AFTER FIELD xccd005_1   
            IF NOT cl_null(g_mm1) AND NOT cl_null(g_mm2) THEN
               #IF g_mm1 > g_mm2 THEN        #160812-00009#1 mark
               IF g_mm1 > g_mm2 AND g_yy1 = g_yy2 THEN   #160812-00009#1 add
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'acr-00067'
                  LET g_errparam.extend = ''
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
                  NEXT FIELD xccd005_1
               END IF
            END IF               
      END INPUT
      #fengmy150806---end
      #end add-point
 
      BEFORE DIALOG
         CALL cl_qbe_init()
         #add-point:cs段b_dialog

         #end add-point  
 
      #查詢方案列表
      ON ACTION qbe_select
         LET ls_wc = ""
         CALL cl_qbe_list("c") RETURNING ls_wc
    
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
 
 
 
 
   
   #add-point:cs段結束前
#fengmy150304---begin
   LET g_wc3 = g_wc2_table4
   IF g_wc2_table5 <> " 1=1" THEN
      LET g_wc3 = g_wc3 ," AND ", g_wc2_table5
   END IF
   IF g_wc2_table6 <> " 1=1" THEN
      LET g_wc3 = g_wc3 ," AND ", g_wc2_table6
   END IF
#fengmy150304---end
   #end add-point    
 
   IF INT_FLAG THEN
      RETURN
   END IF
 
END FUNCTION
 
{</section>}
 
{<section id="axcq540.query" >}
#+ 資料查詢QBE功能準備
PRIVATE FUNCTION axcq540_query()
   DEFINE ls_wc STRING
   #add-point:query段define
   
   #end add-point   
 
   #切換畫面
   
   LET ls_wc = g_wc
   
   LET INT_FLAG = 0
   CALL cl_navigator_setting( g_current_idx, g_detail_cnt )
   ERROR ""
   
   #清除畫面及相關資料
   CLEAR FORM
   CALL g_browser.clear()       
   CALL g_xccd_d.clear()
   CALL g_xccd2_d.clear()
   CALL g_xccd3_d.clear()
 
   
   #add-point:query段other
   
   #end add-point   
   
   DISPLAY ' ' TO FORMONLY.idx
   DISPLAY ' ' TO FORMONLY.cnt
   DISPLAY ' ' TO FORMONLY.b_index
   DISPLAY ' ' TO FORMONLY.b_count
   DISPLAY ' ' TO FORMONLY.h_index
   DISPLAY ' ' TO FORMONLY.h_count
   
   CALL axcq540_construct()
 
   IF INT_FLAG THEN
      #取消查詢
      LET INT_FLAG = 0
      LET g_wc = ls_wc
      CALL axcq540_browser_fill("")
      CALL axcq540_fetch("")
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
   LET g_error_show  = 1
   LET g_wc_filter   = ""
   LET l_ac = 1
   CALL FGL_SET_ARR_CURR(1)
   CALL axcq540_browser_fill("F")
         
   IF g_browser_cnt = 0 THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code   = "-100" 
      LET g_errparam.popup  = TRUE 
      CALL cl_err()
 
   ELSE
      CALL axcq540_fetch("F") 
   END IF
 
END FUNCTION
 
{</section>}
 
{<section id="axcq540.fetch" >}
#+ 指定PK後抓取單頭其他資料
PRIVATE FUNCTION axcq540_fetch(p_flag)
   DEFINE p_flag     LIKE type_t.chr1
   DEFINE ls_msg     STRING
   #add-point:fetch段define
 
   #end add-point    
   
   IF g_browser_cnt = 0 THEN
      RETURN
   END IF
   
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
   
   CALL axcq540_browser_fill(p_flag)
   
   
   LET g_detail_cnt = g_header_cnt                  
   
   #單身總筆數顯示
   #LET g_detail_idx = 1
   IF g_detail_cnt > 0 THEN
      #LET g_detail_idx = 1
      DISPLAY g_detail_idx TO FORMONLY.idx  
   ELSE
      LET g_detail_idx = 0
      DISPLAY ' ' TO FORMONLY.idx    
   END IF
   
   #瀏覽頁筆數顯示
   LET g_pagestart = g_current_idx
   DISPLAY g_pagestart TO FORMONLY.b_index   #當下筆數
   DISPLAY g_pagestart TO FORMONLY.h_index   #當下筆數
   
   CALL cl_navigator_setting( g_pagestart, g_browser_cnt )
   
   #代表沒有資料
   IF g_current_idx = 0 OR g_browser.getLength() = 0 THEN
      RETURN
   END IF
   
   #超出範圍
   IF g_current_idx > g_browser.getLength() THEN
      LET g_current_idx = g_browser.getLength()
   END IF
   
   LET g_xccd_m.xccdld = g_browser[g_current_idx].b_xccdld
   LET g_xccd_m.xccd001 = g_browser[g_current_idx].b_xccd001
   LET g_xccd_m.xccd003 = g_browser[g_current_idx].b_xccd003
   LET g_xccd_m.xccd004 = g_browser[g_current_idx].b_xccd004
   LET g_xccd_m.xccd005 = g_browser[g_current_idx].b_xccd005
 
   
 
   
   #add-point:fetch段action控制
 
   #end add-point  
   
   
   
   #add-point:fetch結束前

   #end add-point
   
   #保存單頭舊值
   LET g_xccd_m_t.* = g_xccd_m.*
   LET g_xccd_m_o.* = g_xccd_m.*
   
   
   #重新顯示   
   CALL axcq540_show()
 
   
 
END FUNCTION
 
{</section>}
 
{<section id="axcq540.insert" >}
#+ 資料新增
PRIVATE FUNCTION axcq540_insert()
   #add-point:insert段define
   
   #end add-point    
   
   #清畫面欄位內容
   CLEAR FORM                    
   CALL g_xccd_d.clear()   
   CALL g_xccd2_d.clear()  
   CALL g_xccd3_d.clear()  
 
 
   INITIALIZE g_xccd_m.* LIKE xccd_t.*             #DEFAULT 設定
   
   LET g_xccdld_t = NULL
   LET g_xccd001_t = NULL
   LET g_xccd003_t = NULL
   LET g_xccd004_t = NULL
   LET g_xccd005_t = NULL
 
   
   LET g_master_insert = FALSE
   
   CALL s_transaction_begin()
   WHILE TRUE
      #公用欄位給值(單頭)
      
 
      #append欄位給值
      
     
      #一般欄位給值
      
  
      #add-point:單頭預設值
      
      #end add-point 
      
      #顯示狀態(stus)圖片
      
    
      CALL axcq540_input("a")
      
      #add-point:單頭輸入後
      
      #end add-point
      
      IF INT_FLAG AND NOT g_master_insert THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = '' 
         LET g_errparam.code   = 9001 
         LET g_errparam.popup  = FALSE 
         CALL cl_err()
         CALL s_transaction_end('N','0')
         LET INT_FLAG = 0
         DISPLAY g_detail_cnt  TO FORMONLY.h_count    #總筆數
         DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
         INITIALIZE g_xccd_m.* TO NULL
         INITIALIZE g_xccd_d TO NULL
         INITIALIZE g_xccd2_d TO NULL
         INITIALIZE g_xccd3_d TO NULL
 
         CALL axcq540_show()
         RETURN
      END IF
      
      LET INT_FLAG = 0
      #CALL g_xccd_d.clear()
      #CALL g_xccd2_d.clear()
      #CALL g_xccd3_d.clear()
 
 
      LET g_rec_b = 0
      CALL s_transaction_end('Y','0')
      EXIT WHILE
        
   END WHILE
   
   #將新增的資料併入搜尋條件中
   LET g_state = "insert"
   
   LET g_xccdld_t = g_xccd_m.xccdld
   LET g_xccd001_t = g_xccd_m.xccd001
   LET g_xccd003_t = g_xccd_m.xccd003
   LET g_xccd004_t = g_xccd_m.xccd004
   LET g_xccd005_t = g_xccd_m.xccd005
 
   
   #組合新增資料的條件
   LET g_add_browse = " xccdent = '" ||g_enterprise|| "' AND",
                      " xccdld = '", g_xccd_m.xccdld CLIPPED, "' "
                      ," AND xccd001 = '", g_xccd_m.xccd001 CLIPPED, "' "
                      ," AND xccd003 = '", g_xccd_m.xccd003 CLIPPED, "' "
                      ," AND xccd004 = '", g_xccd_m.xccd004 CLIPPED, "' "
                      ," AND xccd005 = '", g_xccd_m.xccd005 CLIPPED, "' "
 
   #填到最後面
   LET g_current_idx = g_browser.getLength() + 1
   CALL axcq540_browser_fill("")
   
   DISPLAY g_browser_cnt TO FORMONLY.h_count    #總筆數
   DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
   CALL cl_navigator_setting(g_current_idx, g_browser_cnt)
   
   CLOSE axcq540_cl
   
   CALL axcq540_idx_chk()
   
END FUNCTION
 
{</section>}
 
{<section id="axcq540.modify" >}
#+ 資料修改
PRIVATE FUNCTION axcq540_modify()
   DEFINE l_new_key    DYNAMIC ARRAY OF STRING
   DEFINE l_old_key    DYNAMIC ARRAY OF STRING
   DEFINE l_field_key  DYNAMIC ARRAY OF STRING
   #add-point:modify段define

   #end add-point    
   
   #保存單頭舊值
#   LET g_xccd_m_t.* = g_xccd_m.*
#   LET g_xccd_m_o.* = g_xccd_m.*
#   
#   IF g_xccd_m.xccdld IS NULL
#   OR g_xccd_m.xccd001 IS NULL
#   OR g_xccd_m.xccd003 IS NULL
#   OR g_xccd_m.xccd004 IS NULL
#   OR g_xccd_m.xccd005 IS NULL
# 
#   THEN
#      INITIALIZE g_errparam TO NULL 
#      LET g_errparam.extend = "" 
#      LET g_errparam.code   = "std-00003" 
#      LET g_errparam.popup  = FALSE 
#      CALL cl_err()
# 
#      RETURN
#   END IF
# 
#   ERROR ""
#  
#   LET g_xccdld_t = g_xccd_m.xccdld
#   LET g_xccd001_t = g_xccd_m.xccd001
#   LET g_xccd003_t = g_xccd_m.xccd003
#   LET g_xccd004_t = g_xccd_m.xccd004
#   LET g_xccd005_t = g_xccd_m.xccd005
# 
#   CALL s_transaction_begin()
#   
#   OPEN axcq540_cl USING g_enterprise,g_xccd_m.xccdld,g_xccd_m.xccd001,g_xccd_m.xccd003,g_xccd_m.xccd004,g_xccd_m.xccd005
#   IF STATUS THEN
#      INITIALIZE g_errparam TO NULL 
#      LET g_errparam.extend = "OPEN axcq540_cl:" 
#      LET g_errparam.code   = STATUS 
#      LET g_errparam.popup  = TRUE 
#      CALL cl_err()
#      CLOSE axcq540_cl
#      CALL s_transaction_end('N','0')
#      RETURN
#   END IF
# 
#   #顯示最新的資料
#   EXECUTE axcq540_master_referesh USING g_xccd_m.xccdld,g_xccd_m.xccd001,g_xccd_m.xccd003,g_xccd_m.xccd004, 
#       g_xccd_m.xccd005 INTO g_xccd_m.xccdcomp,g_xccd_m.xccdld,g_xccd_m.xccd004,g_xccd_m.xccd005,g_xccd_m.xccd001, 
#       g_xccd_m.xccd003,g_xccd_m.xccdcomp_desc,g_xccd_m.xccdld_desc,g_xccd_m.xccd003_desc
# 
#   #資料被他人LOCK, 或是sql執行時出現錯誤
#   IF SQLCA.sqlcode THEN
#      INITIALIZE g_errparam TO NULL 
#      LET g_errparam.extend = g_xccd_m.xccdld 
#      LET g_errparam.code   = SQLCA.sqlcode 
#      LET g_errparam.popup  = FALSE 
#      CALL cl_err()
# 
#      CLOSE axcq540_cl
#      CALL s_transaction_end('N','0')
#      RETURN
#   END IF
#   
#   
#   
#   #add-point:modify段show之前

#   #end add-point  
#   
#   CALL axcq540_show()
#   WHILE TRUE
#      LET g_xccdld_t = g_xccd_m.xccdld
#      LET g_xccd001_t = g_xccd_m.xccd001
#      LET g_xccd003_t = g_xccd_m.xccd003
#      LET g_xccd004_t = g_xccd_m.xccd004
#      LET g_xccd005_t = g_xccd_m.xccd005
# 
#      
#      #寫入修改者/修改日期資訊(單頭)
#      
#      
#      #add-point:modify段修改前

#      #end add-point
#      
#      #欄位更改
#      CALL axcq540_input("u")
# 
#      #add-point:modify段修改後

#      #end add-point
#      
#      IF INT_FLAG THEN
#         LET INT_FLAG = 0
#         LET g_xccd_m.* = g_xccd_m_t.*
#         CALL axcq540_show()
#         INITIALIZE g_errparam TO NULL 
#         LET g_errparam.extend = '' 
#         LET g_errparam.code   = 9001 
#         LET g_errparam.popup  = FALSE 
#         CALL cl_err()
#         CALL s_transaction_end('N','0')
#         RETURN
#      END IF 
#      
#      #若有modid跟moddt則進行update
# 
#                  
#      #若單頭key欄位有變更
#      IF g_xccd_m.xccdld != g_xccdld_t 
#      OR g_xccd_m.xccd001 != g_xccd001_t 
#      OR g_xccd_m.xccd003 != g_xccd003_t 
#      OR g_xccd_m.xccd004 != g_xccd004_t 
#      OR g_xccd_m.xccd005 != g_xccd005_t 
# 
#      THEN
#         CALL s_transaction_begin()
#         
#         #add-point:單身fk修改前
 
#         #end add-point
#         
#         #更新單身key值
#         UPDATE xccd_t SET  = g_xccd_m.xccdld
#                                       , = g_xccd_m.xccd001
#                                       , = g_xccd_m.xccd003
#                                       , = g_xccd_m.xccd004
#                                       , = g_xccd_m.xccd005
# 
#          WHERE xccdent = g_enterprise AND  = g_xccdld_t
#            AND  = g_xccd001_t
#            AND  = g_xccd003_t
#            AND  = g_xccd004_t
#            AND  = g_xccd005_t
# 
#            
#         #add-point:單身fk修改中

#         #end add-point
# 
#         CASE
#            WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
#               INITIALIZE g_errparam TO NULL 
#               LET g_errparam.extend = "xccd_t" 
#               LET g_errparam.code   = "std-00009" 
#               LET g_errparam.popup  = TRUE 
#               CALL cl_err()
#               CALL s_transaction_end('N','0')
#               CONTINUE WHILE
#            WHEN SQLCA.sqlcode #其他錯誤
#               INITIALIZE g_errparam TO NULL 
#               LET g_errparam.extend = "xccd_t" 
#               LET g_errparam.code   = SQLCA.sqlcode 
#               LET g_errparam.popup  = TRUE 
#               CALL cl_err()
# 
#               CALL s_transaction_end('N','0')
#               CONTINUE WHILE
#         END CASE
#         
#         #add-point:單身fk修改後

#         #end add-point
#         
#         #更新單身key值
#         #add-point:單身fk修改前

#         #end add-point
#         UPDATE xcce_t
#            SET xcceld = g_xccd_m.xccdld
#               ,xcce001 = g_xccd_m.xccd001
#               ,xcce003 = g_xccd_m.xccd003
#               ,xcce004 = g_xccd_m.xccd004
#               ,xcce005 = g_xccd_m.xccd005
# 
#          WHERE xcceent = g_enterprise AND
#                xcceld = g_xccdld_t
#            AND xcce001 = g_xccd001_t
#            AND xcce003 = g_xccd003_t
#            AND xcce004 = g_xccd004_t
#            AND xcce005 = g_xccd005_t
# 
#         #add-point:單身fk修改中

#         #end add-point
#         CASE
#            WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
#               INITIALIZE g_errparam TO NULL 
#               LET g_errparam.extend = "xcce_t" 
#               LET g_errparam.code   = "std-00009" 
#               LET g_errparam.popup  = TRUE 
#               CALL cl_err()
# 
#               CALL s_transaction_end('N','0')
#               CONTINUE WHILE
#            WHEN SQLCA.sqlcode #其他錯誤
#               INITIALIZE g_errparam TO NULL 
#               LET g_errparam.extend = "xcce_t" 
#               LET g_errparam.code   = SQLCA.sqlcode 
#               LET g_errparam.popup  = TRUE 
#               CALL cl_err()
# 
#               CALL s_transaction_end('N','0')
#               CONTINUE WHILE
#         END CASE
#         #add-point:單身fk修改後

#         #end add-point
# 
#         #更新單身key值
#         #add-point:單身fk修改前

#         #end add-point
#         UPDATE xcci_t
#            SET xccild = g_xccd_m.xccdld
#               ,xcci001 = g_xccd_m.xccd001
#               ,xcci003 = g_xccd_m.xccd003
#               ,xcci004 = g_xccd_m.xccd004
#               ,xcci005 = g_xccd_m.xccd005
# 
#          WHERE xccient = g_enterprise AND
#                xccild = g_xccdld_t
#            AND xcci001 = g_xccd001_t
#            AND xcci003 = g_xccd003_t
#            AND xcci004 = g_xccd004_t
#            AND xcci005 = g_xccd005_t
# 
#         #add-point:單身fk修改中

#         #end add-point
#         CASE
#            WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
#               INITIALIZE g_errparam TO NULL 
#               LET g_errparam.extend = "xcci_t" 
#               LET g_errparam.code   = "std-00009" 
#               LET g_errparam.popup  = TRUE 
#               CALL cl_err()
# 
#               CALL s_transaction_end('N','0')
#               CONTINUE WHILE
#            WHEN SQLCA.sqlcode #其他錯誤
#               INITIALIZE g_errparam TO NULL 
#               LET g_errparam.extend = "xcci_t" 
#               LET g_errparam.code   = SQLCA.sqlcode 
#               LET g_errparam.popup  = TRUE 
#               CALL cl_err()
# 
#               CALL s_transaction_end('N','0')
#               CONTINUE WHILE
#         END CASE
#         #add-point:單身fk修改後

#         #end add-point
# 
# 
#         
# 
#         
#         #UPDATE 多語言table key值
#         
#         
#         
# 
#         CALL s_transaction_end('Y','0')
#      END IF
#    
#      EXIT WHILE
#   END WHILE
 
   #修改歷程記錄
   #IF NOT cl_log_modified_record(g_xccd_m.xccdld,g_site) THEN 
   #   CALL s_transaction_end('N','0')
   #END IF
 
   #LET g_state = "modify"
 
   #組合新增資料的條件
   LET g_add_browse = " xccdent = '" ||g_enterprise|| "' AND",
                      " xccdld = '", g_xccd_m.xccdld CLIPPED, "' "
                      ," AND xccd001 = '", g_xccd_m.xccd001 CLIPPED, "' "
                      ," AND xccd003 = '", g_xccd_m.xccd003 CLIPPED, "' "
                      ," AND xccd004 = '", g_xccd_m.xccd004 CLIPPED, "' "
                      ," AND xccd005 = '", g_xccd_m.xccd005 CLIPPED, "' "
 
   #填到對應位置
   CALL axcq540_browser_fill("")
 
   CLOSE axcq540_cl
   CALL s_transaction_end('Y','0')
 
   #流程通知預埋點-U
   CALL cl_flow_notify(g_xccd_m.xccdld,'U')
 
END FUNCTION   
 
{</section>}
 
{<section id="axcq540.input" >}
#+ 資料輸入
PRIVATE FUNCTION axcq540_input(p_cmd)
   DEFINE  p_cmd                 LIKE type_t.chr1
   DEFINE  l_cmd_t               LIKE type_t.chr1
   DEFINE  l_cmd                 LIKE type_t.chr1
   DEFINE  l_n                   LIKE type_t.num5                #檢查重複用  
   DEFINE  l_cnt                 LIKE type_t.num10                #檢查重複用  
   DEFINE  l_lock_sw             LIKE type_t.chr1                #單身鎖住否  
   DEFINE  l_allow_insert        LIKE type_t.num5                #可新增否 
   DEFINE  l_allow_delete        LIKE type_t.num5                #可刪除否  
   DEFINE  l_count               LIKE type_t.num10
   DEFINE  l_i                   LIKE type_t.num10
   DEFINE  l_insert              BOOLEAN
   DEFINE  ls_return             STRING
   DEFINE  l_var_keys            DYNAMIC ARRAY OF STRING
   DEFINE  l_field_keys          DYNAMIC ARRAY OF STRING
   DEFINE  l_vars                DYNAMIC ARRAY OF STRING
   DEFINE  l_fields              DYNAMIC ARRAY OF STRING
   DEFINE  l_var_keys_bak        DYNAMIC ARRAY OF STRING
   DEFINE  lb_reproduce          BOOLEAN
   DEFINE  li_reproduce          LIKE type_t.num5
   DEFINE  li_reproduce_target   LIKE type_t.num5
   #add-point:input段define

   #end add-point  
 
#   #先做狀態判定
#   IF p_cmd = 'r' THEN
#      LET l_cmd_t = 'r'
#      LET p_cmd   = 'a'
#   ELSE
#      LET l_cmd_t = p_cmd
#   END IF   
#   
#   #將資料輸出到畫面上
#   DISPLAY BY NAME g_xccd_m.xccdcomp,g_xccd_m.xccdcomp_desc,g_xccd_m.xccdld,g_xccd_m.xccdld_desc,g_xccd_m.xccd004, 
#       g_xccd_m.xccd005,g_xccd_m.xccd001,g_xccd_m.xccd001_desc,g_xccd_m.xccd003,g_xccd_m.xccd003_desc 
#
#   
#   #切換畫面
# 
#   CALL cl_set_head_visible("","YES")  
# 
#   LET l_insert = FALSE
#   LET g_action_choice = ""
# 
#   #add-point:input段define_sql

#   #end add-point 
#   LET g_forupd_sql = "SELECT xccd006,xccd002 FROM xccd_t WHERE xccdent=? AND xccdld=? AND xccd001=?  
#       AND xccd003=? AND xccd004=? AND xccd005=? FOR UPDATE"
#   #add-point:input段define_sql

#   #end add-point 
#   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)
#   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
#   DECLARE axcq540_bcl CURSOR FROM g_forupd_sql
#   
#   #add-point:input段define_sql

#   #end add-point    
#   LET g_forupd_sql = "SELECT xcce006,xcce007,xcce008,xcce009,xcce002,xcce101,xcce102a,xcce102b,xcce102c, 
#       xcce102d,xcce102e,xcce102f,xcce102g,xcce102h,xcce102,xcce201,xcce202a,xcce202b,xcce202c,xcce202d, 
#       xcce202e,xcce202f,xcce202g,xcce202h,xcce202,xcce301,xcce302a,xcce302b,xcce302c,xcce302d,xcce302e, 
#       xcce302f,xcce302g,xcce302h,xcce302,xcce303,xcce304a,xcce304b,xcce304c,xcce304d,xcce304e,xcce304f, 
#       xcce304g,xcce304h,xcce304,xcce307,xcce308a,xcce308b,xcce308c,xcce308d,xcce308e,xcce308f,xcce308g, 
#       xcce308h,xcce308,xcce901,xcce902a,xcce902b,xcce902c,xcce902d,xcce902e,xcce902f,xcce902g,xcce902h, 
#       xcce902 FROM xcce_t WHERE xcceent=? AND xcceld=? AND xcce001=? AND xcce003=? AND xcce004=? AND  
#       xcce005=? AND xcce002=? AND xcce006=? AND xcce007=? AND xcce008=? AND xcce009=? FOR UPDATE"
#   #add-point:input段define_sql

#   #end add-point
#   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)
#   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
#   DECLARE axcq540_bcl2 CURSOR FROM g_forupd_sql
# 
#   #add-point:input段define_sql

#   #end add-point    
#   LET g_forupd_sql = "SELECT xcci006,xcci007,xcci008,xcci009,xcci002,xcci101,xcci102a,xcci102b,xcci102c, 
#       xcci102d,xcci102e,xcci102f,xcci102g,xcci102h,xcci102,xcci201,xcci202a,xcci202b,xcci202c,xcci202d, 
#       xcci202e,xcci202f,xcci202g,xcci202h,xcci202,xcci301,xcci302a,xcci302b,xcci302c,xcci302d,xcci302e, 
#       xcci302f,xcci302g,xcci302h,xcci302,xcci303,xcci304a,xcci304b,xcci304c,xcci304d,xcci304e,xcci304f, 
#       xcci304g,xcci304h,xcci304,xcci901,xcci902a,xcci902b,xcci902c,xcci902d,xcci902e,xcci902f,xcci902g, 
#       xcci902h,xcci902 FROM xcci_t WHERE xccient=? AND xccild=? AND xcci001=? AND xcci003=? AND xcci004=?  
#       AND xcci005=? AND xcci002=? AND xcci006=? AND xcci007=? AND xcci008=? AND xcci009=? FOR UPDATE" 
#
#   #add-point:input段define_sql

#   #end add-point
#   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)
#   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
#   DECLARE axcq540_bcl3 CURSOR FROM g_forupd_sql
# 
# 
#   
# 
# 
#   #add-point:input段define_sql

#   #end add-point 
# 
#   LET l_allow_insert = cl_auth_detail_input("insert")
#   LET l_allow_delete = cl_auth_detail_input("delete")
#   LET g_qryparam.state = 'i'
#   
#   #控制key欄位可否輸入
#   CALL axcq540_set_entry(p_cmd)
#   #add-point:set_entry後

#   #end add-point
#   CALL axcq540_set_no_entry(p_cmd)
# 
#   DISPLAY BY NAME g_xccd_m.xccdcomp,g_xccd_m.xccdld,g_xccd_m.xccd004,g_xccd_m.xccd005,g_xccd_m.xccd001, 
#       g_xccd_m.xccd003
#   
#   LET lb_reproduce = FALSE
#   
#   #add-point:資料輸入前

#   #end add-point
#   
#   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
#   
#
{</section>}
 
{<section id="axcq540.input.head" >}
#      #單頭段
#      INPUT BY NAME g_xccd_m.xccdcomp,g_xccd_m.xccdld,g_xccd_m.xccd004,g_xccd_m.xccd005,g_xccd_m.xccd001, 
#          g_xccd_m.xccd003 
#         ATTRIBUTE(WITHOUT DEFAULTS)
#         
#         #自訂ACTION(master_input)
#         
#     
#         BEFORE INPUT
#            IF s_transaction_chk("N",0) THEN
#               CALL s_transaction_begin()
#            END IF
#            
#            IF l_cmd_t = 'r' THEN
#               
#            END IF
#            #add-point:資料輸入前

#            #end add-point
# 
#                  #此段落由子樣板a02產生
#         AFTER FIELD xccdcomp
#            
#            #add-point:AFTER FIELD xccdcomp


#            #END add-point
#            
# 
#         #此段落由子樣板a01產生
#         BEFORE FIELD xccdcomp
#            #add-point:BEFORE FIELD xccdcomp

#            #END add-point
# 
#         #此段落由子樣板a04產生
#         ON CHANGE xccdcomp
#            #add-point:ON CHANGE xccdcomp

#            #END add-point
# 
#         #此段落由子樣板a02產生
#         AFTER FIELD xccdld
#            
#            #add-point:AFTER FIELD xccdld


#            #END add-point
#            
# 
#         #此段落由子樣板a01產生
#         BEFORE FIELD xccdld
#            #add-point:BEFORE FIELD xccdld

#            #END add-point
# 
#         #此段落由子樣板a04產生
#         ON CHANGE xccdld
#            #add-point:ON CHANGE xccdld

#            #END add-point
# 
#         #此段落由子樣板a01產生
#         BEFORE FIELD xccd004
#            #add-point:BEFORE FIELD xccd004

#            #END add-point
# 
#         #此段落由子樣板a02產生
#         AFTER FIELD xccd004
#            
#            #add-point:AFTER FIELD xccd004
            #此段落由子樣板a05產生



#            #END add-point
#            
# 
#         #此段落由子樣板a04產生
#         ON CHANGE xccd004
#            #add-point:ON CHANGE xccd004

#            #END add-point
# 
#         #此段落由子樣板a01產生
#         BEFORE FIELD xccd005
#            #add-point:BEFORE FIELD xccd005

#            #END add-point
# 
#         #此段落由子樣板a02產生
#         AFTER FIELD xccd005
#            
#            #add-point:AFTER FIELD xccd005
            #此段落由子樣板a05產生
            #確認資料無重複

#            #END add-point
#            
# 
#         #此段落由子樣板a04產生
#         ON CHANGE xccd005
#            #add-point:ON CHANGE xccd005

#            #END add-point
# 
#         #此段落由子樣板a02產生
#         AFTER FIELD xccd001
#            
#            #add-point:AFTER FIELD xccd001




#            #END add-point
#            
# 
#         #此段落由子樣板a01產生
#         BEFORE FIELD xccd001
#            #add-point:BEFORE FIELD xccd001

#            #END add-point
# 
#         #此段落由子樣板a04產生
#         ON CHANGE xccd001
#            #add-point:ON CHANGE xccd001

#            #END add-point
# 
#         #此段落由子樣板a02產生
#         AFTER FIELD xccd003
#            
#            #add-point:AFTER FIELD xccd003



#            #END add-point
#            
# 
#         #此段落由子樣板a01產生
#         BEFORE FIELD xccd003
#            #add-point:BEFORE FIELD xccd003

#            #END add-point
# 
#         #此段落由子樣板a04產生
#         ON CHANGE xccd003
#            #add-point:ON CHANGE xccd003

#            #END add-point
# 
# #欄位檢查
#                  #Ctrlp:input.c.xccdcomp
#         ON ACTION controlp INFIELD xccdcomp
#            #add-point:ON ACTION controlp INFIELD xccdcomp



#            #END add-point
# 
#         #Ctrlp:input.c.xccdld
#         ON ACTION controlp INFIELD xccdld
#            #add-point:ON ACTION controlp INFIELD xccdld


#            #END add-point
# 
#         #Ctrlp:input.c.xccd004
#         ON ACTION controlp INFIELD xccd004
#            #add-point:ON ACTION controlp INFIELD xccd004

#            #END add-point
# 
#         #Ctrlp:input.c.xccd005
#         ON ACTION controlp INFIELD xccd005
#            #add-point:ON ACTION controlp INFIELD xccd005

#            #END add-point
# 
#         #Ctrlp:input.c.xccd001
#         ON ACTION controlp INFIELD xccd001
#            #add-point:ON ACTION controlp INFIELD xccd001

#            #END add-point
# 
#         #Ctrlp:input.c.xccd003
#         ON ACTION controlp INFIELD xccd003
#            #add-point:ON ACTION controlp INFIELD xccd003

#            #END add-point
# 
# #欄位開窗
#            
#         AFTER INPUT
#            IF INT_FLAG THEN
#               EXIT DIALOG
#            END IF
# 
#            #CALL cl_err_collect_show()      #錯誤訊息統整顯示
#            #CALL cl_showmsg()
#            DISPLAY BY NAME g_xccd_m.xccdld,g_xccd_m.xccd001,g_xccd_m.xccd003,g_xccd_m.xccd004,g_xccd_m.xccd005 
#
#                        
#            #add-point:單頭INPUT後

#            #end add-point
#                        
#            IF p_cmd <> 'u' THEN
#    
#               CALL s_transaction_begin()
#               
#               #add-point:單頭新增前

#               #end add-point
#               
#               INSERT INTO xccd_t (xccdent,xccdcomp,xccdld,xccd004,xccd005,xccd001,xccd003)
#               VALUES (g_enterprise,g_xccd_m.xccdcomp,g_xccd_m.xccdld,g_xccd_m.xccd004,g_xccd_m.xccd005, 
#                   g_xccd_m.xccd001,g_xccd_m.xccd003) 
#               IF SQLCA.sqlcode THEN
#                  INITIALIZE g_errparam TO NULL 
#                  LET g_errparam.extend = "g_xccd_m" 
#                  LET g_errparam.code   = SQLCA.sqlcode 
#                  LET g_errparam.popup  = TRUE 
#                  CALL cl_err()
# 
#                  CALL s_transaction_end('N','0')
#                  CONTINUE DIALOG
#               END IF
#               
#               #add-point:單頭新增中

#               #end add-point
#               
#               
#               
#               
#               #add-point:單頭新增後

#               #end add-point
#               CALL s_transaction_end('Y','0') 
#               
#               IF l_cmd_t = 'r' AND p_cmd = 'a' THEN
#                  CALL axcq540_detail_reproduce()
#                  #因應特定程式需求, 重新刷新單身資料
#                  CALL axcq540_b_fill()
#               END IF
#               
#               LET g_master_insert = TRUE
#               
#               LET p_cmd = 'u'
#            ELSE
#               CALL s_transaction_begin()
#            
#               #add-point:單頭修改前

#               #end add-point
#               
#               UPDATE xccd_t SET (xccdcomp,xccdld,xccd004,xccd005,xccd001,xccd003) = (g_xccd_m.xccdcomp, 
#                   g_xccd_m.xccdld,g_xccd_m.xccd004,g_xccd_m.xccd005,g_xccd_m.xccd001,g_xccd_m.xccd003) 
#
#                WHERE xccdent = g_enterprise AND xccdld = g_xccdld_t
#                  AND xccd001 = g_xccd001_t
#                  AND xccd003 = g_xccd003_t
#                  AND xccd004 = g_xccd004_t
#                  AND xccd005 = g_xccd005_t
# 
#               IF SQLCA.sqlcode THEN
#                  INITIALIZE g_errparam TO NULL 
#                  LET g_errparam.extend = "xccd_t" 
#                  LET g_errparam.code   = SQLCA.sqlcode 
#                  LET g_errparam.popup  = TRUE 
#                  CALL cl_err()
# 
#                  CALL s_transaction_end('N','0')
#                  CONTINUE DIALOG
#               END IF
#               
#               #add-point:單頭修改中

#               #end add-point
#               
#               
#               
#               
#               #修改歷程記錄
#               LET g_log1 = util.JSON.stringify(g_xccd_m_t)
#               LET g_log2 = util.JSON.stringify(g_xccd_m)
#               IF NOT cl_log_modified_record(g_log1,g_log2) THEN 
#                  CALL s_transaction_end('N','0')
#               ELSE
#                  CALL s_transaction_end('Y','0')
#               END IF
#               
#               #add-point:單頭修改後

#               #end add-point
#            END IF
#            
#            LET g_xccdld_t = g_xccd_m.xccdld
#            LET g_xccd001_t = g_xccd_m.xccd001
#            LET g_xccd003_t = g_xccd_m.xccd003
#            LET g_xccd004_t = g_xccd_m.xccd004
#            LET g_xccd005_t = g_xccd_m.xccd005
# 
#            
#      END INPUT
#   
#
{</section>}
 
{<section id="axcq540.input.body" >}
#   
#      #Page1 預設值產生於此處
#      INPUT ARRAY g_xccd_d FROM s_detail1.*
#          ATTRIBUTE(COUNT = g_rec_b,WITHOUT DEFAULTS, #MAXCOUNT = g_max_rec,
#                  INSERT ROW = l_allow_insert, 
#                  DELETE ROW = l_allow_delete,
#                  APPEND ROW = l_allow_insert)
# 
#         #自訂ACTION(detail_input,page_1)
#         
#         
#         BEFORE INPUT
#            #add-point:資料輸入前

#            #end add-point
#            IF g_insert = 'Y' AND NOT cl_null(g_insert) THEN 
#              CALL FGL_SET_ARR_CURR(g_xccd_d.getLength()+1) 
#              LET g_insert = 'N' 
#           END IF 
# 
#            CALL axcq540_b_fill()
#            LET g_rec_b = g_xccd_d.getLength()
#            #add-point:資料輸入前

#            #end add-point
#         
#         BEFORE ROW
#            #add-point:modify段before row2

#            #end add-point  
#            LET l_insert = FALSE
#            LET l_cmd = ''
#            LET l_ac = ARR_CURR()
#            LET g_detail_idx = l_ac
#            
#            LET l_lock_sw = 'N'            #DEFAULT
#            LET l_n = ARR_COUNT()
#            DISPLAY l_ac TO FORMONLY.idx
#         
#            CALL s_transaction_begin()
#            OPEN axcq540_cl USING g_enterprise,g_xccd_m.xccdld,g_xccd_m.xccd001,g_xccd_m.xccd003,g_xccd_m.xccd004,g_xccd_m.xccd005
#            IF STATUS THEN
#               INITIALIZE g_errparam TO NULL 
#               LET g_errparam.extend = "OPEN axcq540_cl:" 
#               LET g_errparam.code   = STATUS 
#               LET g_errparam.popup  = TRUE 
#               CALL cl_err()
# 
#               CLOSE axcq540_cl
#               CALL s_transaction_end('N','0')
#               RETURN
#            END IF
#            
#            LET g_rec_b = g_xccd_d.getLength()
#            
#            IF g_rec_b >= l_ac 
#               AND g_xccd_d[l_ac].xccdld IS NOT NULL
#               AND g_xccd_d[l_ac].xccd001 IS NOT NULL
#               AND g_xccd_d[l_ac].xccd003 IS NOT NULL
#               AND g_xccd_d[l_ac].xccd004 IS NOT NULL
#               AND g_xccd_d[l_ac].xccd005 IS NOT NULL
# 
#            THEN
#               LET l_cmd='u'
#               LET g_xccd_d_t.* = g_xccd_d[l_ac].*  #BACKUP
#               LET g_xccd_d_o.* = g_xccd_d[l_ac].*  #BACKUP
#               CALL axcq540_set_entry_b(l_cmd)
#               #add-point:modify段after_set_entry_b

#               #end add-point  
#               CALL axcq540_set_no_entry_b(l_cmd)
#               IF NOT axcq540_lock_b("xccd_t","'1'") THEN
#                  LET l_lock_sw='Y'
#               ELSE
#                  FETCH axcq540_bcl INTO g_xccd_d[l_ac].xccd006,g_xccd_d[l_ac].xccd002
#                  IF SQLCA.sqlcode THEN
#                     INITIALIZE g_errparam TO NULL 
#                     LET g_errparam.extend = g_xccd_d_t.xccdld 
#                     LET g_errparam.code   = SQLCA.sqlcode 
#                     LET g_errparam.popup  = TRUE 
#                     CALL cl_err()
# 
#                     LET l_lock_sw = "Y"
#                  END IF
#                  
#                  LET g_bfill = "N"
#                  CALL axcq540_show()
#                  LET g_bfill = "Y"
#                  
#                  CALL cl_show_fld_cont()
#               END IF
#            ELSE
#               LET l_cmd='a'
#            END IF
#            #add-point:modify段before row

#            #end add-point  
#            #其他table資料備份(確定是否更改用)
#            LET g_detail_multi_table_t.xcbbcomp = g_xccd_m.xccdld
#LET g_detail_multi_table_t.xcbb001 = g_xccd_m.xccd001
#LET g_detail_multi_table_t.xcbb002 = g_xccd_m.xccd003
#LET g_detail_multi_table_t.xcbb003 = g_xccd_m.xccd004
#LET g_detail_multi_table_t.xcbb004 = g_xccd_m.xccd005
#LET g_detail_multi_table_t.xcbb005 = g_xccd3_d[l_ac].xcci002
# 
#            #其他table進行lock
#                        INITIALIZE l_var_keys TO NULL 
#            INITIALIZE l_field_keys TO NULL 
#            LET l_field_keys[01] = 'xcbbcomp'
#            LET l_var_keys[01] = g_xccd_m.xccdld
#            LET l_field_keys[02] = 'xcbb001'
#            LET l_var_keys[02] = g_xccd_m.xccd001
#            LET l_field_keys[03] = 'xcbb002'
#            LET l_var_keys[03] = g_xccd_m.xccd003
#            LET l_field_keys[04] = 'xcbb003'
#            LET l_var_keys[04] = g_xccd_m.xccd004
#            LET l_field_keys[05] = 'xcbb004'
#            LET l_var_keys[05] = g_xccd_m.xccd005
#            IF NOT cl_multitable_lock(l_var_keys,l_field_keys,'xcbb_t') THEN
#               RETURN 
#            END IF 
# 
#        
#         BEFORE INSERT
#            
#            LET l_insert = TRUE
#            LET l_n = ARR_COUNT()
#            LET l_cmd = 'a'
#            INITIALIZE g_xccd_d[l_ac].* TO NULL 
#            INITIALIZE g_xccd_d_t.* TO NULL 
#            INITIALIZE g_xccd_d_o.* TO NULL 
#            #公用欄位給值(單身)
#            
#            #自定義預設值
#            
#            #add-point:modify段before備份

#            #end add-point
#            LET g_xccd_d_t.* = g_xccd_d[l_ac].*     #新輸入資料
#            LET g_xccd_d_o.* = g_xccd_d[l_ac].*     #新輸入資料
#            CALL cl_show_fld_cont()
#            CALL axcq540_set_entry_b(l_cmd)
#            #add-point:modify段after_set_entry_b

#            #end add-point
#            CALL axcq540_set_no_entry_b(l_cmd)
#            IF lb_reproduce THEN
#               LET lb_reproduce = FALSE
#               LET g_xccd_d[li_reproduce_target].* = g_xccd_d[li_reproduce].*
# 
#               LET g_xccd_d[li_reproduce_target].xccdld = NULL
#               LET g_xccd_d[li_reproduce_target].xccd001 = NULL
#               LET g_xccd_d[li_reproduce_target].xccd003 = NULL
#               LET g_xccd_d[li_reproduce_target].xccd004 = NULL
#               LET g_xccd_d[li_reproduce_target].xccd005 = NULL
# 
#            END IF
#            LET g_detail_multi_table_t.xcbbcomp = g_xccd_m.xccdld
#LET g_detail_multi_table_t.xcbb001 = g_xccd_m.xccd001
#LET g_detail_multi_table_t.xcbb002 = g_xccd_m.xccd003
#LET g_detail_multi_table_t.xcbb003 = g_xccd_m.xccd004
#LET g_detail_multi_table_t.xcbb004 = g_xccd_m.xccd005
#LET g_detail_multi_table_t.xcbb005 = g_xccd3_d[l_ac].xcci002
# 
#            #add-point:modify段before insert

#            #end add-point  
#  
#         AFTER INSERT
#            LET l_insert = FALSE
#            IF INT_FLAG THEN
#               INITIALIZE g_errparam TO NULL 
#               LET g_errparam.extend = '' 
#               LET g_errparam.code   = 9001 
#               LET g_errparam.popup  = FALSE 
#               CALL cl_err()
# 
#               LET INT_FLAG = 0
#               CANCEL INSERT
#            END IF
#               
#            #add-point:單身新增
 
#            #end add-point
#               
#            LET l_count = 1  
#            SELECT COUNT(*) INTO l_count FROM xccd_t 
#             WHERE xccdent = g_enterprise AND  = g_xccd_m.xccdld
#               AND  = g_xccd_m.xccd001
#               AND  = g_xccd_m.xccd003
#               AND  = g_xccd_m.xccd004
#               AND  = g_xccd_m.xccd005
# 
#               AND xccdld = g_xccd_d[l_ac].xccdld
#               AND xccd001 = g_xccd_d[l_ac].xccd001
#               AND xccd003 = g_xccd_d[l_ac].xccd003
#               AND xccd004 = g_xccd_d[l_ac].xccd004
#               AND xccd005 = g_xccd_d[l_ac].xccd005
# 
#                
#            #資料未重複, 插入新增資料
#            IF l_count = 0 THEN 
#               #add-point:單身新增前

#               #end add-point
#            
#               #同步新增到同層的table
#                              INITIALIZE gs_keys TO NULL 
#               LET gs_keys[1] = g_xccd_m.xccdld
#               LET gs_keys[2] = g_xccd_m.xccd001
#               LET gs_keys[3] = g_xccd_m.xccd003
#               LET gs_keys[4] = g_xccd_m.xccd004
#               LET gs_keys[5] = g_xccd_m.xccd005
#               LET gs_keys[6] = g_xccd_d[g_detail_idx].xccdld
#               LET gs_keys[7] = g_xccd_d[g_detail_idx].xccd001
#               LET gs_keys[8] = g_xccd_d[g_detail_idx].xccd003
#               LET gs_keys[9] = g_xccd_d[g_detail_idx].xccd004
#               LET gs_keys[10] = g_xccd_d[g_detail_idx].xccd005
#               CALL axcq540_insert_b('xccd_t',gs_keys,"'1'")
#                           
#               #add-point:單身新增後

#               #end add-point
#            ELSE    
#               INITIALIZE g_errparam TO NULL 
#               LET g_errparam.extend = 'INSERT' 
#               LET g_errparam.code   = "std-00006" 
#               LET g_errparam.popup  = TRUE 
#               CALL cl_err()
# 
#               INITIALIZE g_xccd_d[l_ac].* TO NULL
#               CALL s_transaction_end('N','0')
#               CANCEL INSERT
#            END IF
# 
#            IF SQLCA.SQLcode  THEN
#               INITIALIZE g_errparam TO NULL 
#               LET g_errparam.extend = "xccd_t" 
#               LET g_errparam.code   = SQLCA.sqlcode 
#               LET g_errparam.popup  = TRUE 
#               CALL cl_err()
# 
#               CALL s_transaction_end('N','0')                    
#               CANCEL INSERT
#            ELSE
#               #先刷新資料
#               #CALL axcq540_b_fill()
#               #資料多語言用-增/改
#                        INITIALIZE l_var_keys TO NULL 
#         INITIALIZE l_field_keys TO NULL 
#         INITIALIZE l_vars TO NULL 
#         INITIALIZE l_fields TO NULL 
#         INITIALIZE l_var_keys_bak TO NULL 
#         IF g_xccd_m.xccdld = g_detail_multi_table_t.sfaadocno AND
#         g_xccd_m.xccd001 = g_detail_multi_table_t.sfaa068 AND
#         g_xccd_m.xccd003 =  AND
#         g_xccd_m.xccd004 =  AND
#         g_xccd_m.xccd005 =  AND
#         g_xccd3_d[l_ac].xcci002 =  AND
#         g_xccd3_d[l_ac].xcci006 =  AND
#         g_xccd3_d[l_ac].xcci007 =  AND
#         g_xccd3_d[l_ac].xcci008 =  AND
#         g_xccd3_d[l_ac].xcci009 =  AND
#         g_xccd_d[l_ac].sfaa068 =  THEN
#         ELSE 
#            LET l_var_keys[01] = g_xccd_m.xccdld
#            LET l_field_keys[01] = 'sfaadocno'
#            LET l_vars[01] = g_xccd_d[l_ac].sfaa068
#            LET l_fields[01] = 'sfaa068'
#            LET l_vars[02] = g_site 
#            LET l_fields[02] = 'sfaasite'
#            LET l_vars[03] = g_enterprise 
#            LET l_fields[03] = 'sfaaent'
#            LET l_var_keys_bak[01] = g_detail_multi_table_t.sfaadocno
#            CALL cl_multitable(l_var_keys,l_field_keys,l_vars,l_fields,l_var_keys_bak,'sfaa_t')
#         END IF 
#          INITIALIZE l_var_keys TO NULL 
#         INITIALIZE l_field_keys TO NULL 
#         INITIALIZE l_vars TO NULL 
#         INITIALIZE l_fields TO NULL 
#         INITIALIZE l_var_keys_bak TO NULL 
#         IF g_xccd_m.xccdld = g_detail_multi_table_t.xcceld AND
#         g_xccd_m.xccd001 = g_detail_multi_table_t.xcce001 AND
#         g_xccd_m.xccd003 = g_detail_multi_table_t.xcce002 AND
#         g_xccd_m.xccd004 = g_detail_multi_table_t.xcce003 AND
#         g_xccd_m.xccd005 = g_detail_multi_table_t.xcce004 AND
#         g_xccd3_d[l_ac].xcci002 = g_detail_multi_table_t.xcce005 AND
#         g_xccd3_d[l_ac].xcci006 = g_detail_multi_table_t.xcce006 AND
#         g_xccd3_d[l_ac].xcci007 = g_detail_multi_table_t.xcce007 AND
#         g_xccd3_d[l_ac].xcci008 = g_detail_multi_table_t.xcce008 AND
#         g_xccd3_d[l_ac].xcci009 = g_detail_multi_table_t.xcce009 AND
#         g_xccd_d[l_ac].xcce007 = g_detail_multi_table_t.xcce007 AND
#         g_xccd_d[l_ac].xcce008 = g_detail_multi_table_t.xcce008 AND
#         g_xccd_d[l_ac].xcce009 = g_detail_multi_table_t.xcce009 AND
#         g_xccd_d[l_ac].xcce101 = g_detail_multi_table_t.xcce101 AND
#         g_xccd_d[l_ac].xcce102 = g_detail_multi_table_t.xcce102 AND
#         g_xccd_d[l_ac].xcce201 = g_detail_multi_table_t.xcce201 AND
#         g_xccd_d[l_ac].xcce202 = g_detail_multi_table_t.xcce202 AND
#         g_xccd_d[l_ac].xcce301 = g_detail_multi_table_t.xcce301 AND
#         g_xccd_d[l_ac].xcce302 = g_detail_multi_table_t.xcce302 AND
#         g_xccd_d[l_ac].xcce303 = g_detail_multi_table_t.xcce303 AND
#         g_xccd_d[l_ac].xcce304 = g_detail_multi_table_t.xcce304 AND
#         g_xccd_d[l_ac].xcce307 = g_detail_multi_table_t.xcce307 AND
#         g_xccd_d[l_ac].xcce308 = g_detail_multi_table_t.xcce308 AND
#         g_xccd_d[l_ac].xcce901 = g_detail_multi_table_t.xcce901 AND
#         g_xccd_d[l_ac].xcce902 = g_detail_multi_table_t.xcce902 THEN
#         ELSE 
#            LET l_var_keys[01] = g_xccd_m.xccdld
#            LET l_field_keys[01] = 'xcceld'
#            LET l_var_keys[02] = g_xccd_m.xccd001
#            LET l_field_keys[02] = 'xcce001'
#            LET l_var_keys[03] = g_xccd_m.xccd003
#            LET l_field_keys[03] = 'xcce002'
#            LET l_var_keys[04] = g_xccd_m.xccd004
#            LET l_field_keys[04] = 'xcce003'
#            LET l_var_keys[05] = g_xccd_m.xccd005
#            LET l_field_keys[05] = 'xcce004'
#            LET l_var_keys[06] = g_xccd3_d[l_ac].xcci002
#            LET l_field_keys[06] = 'xcce005'
#            LET l_var_keys[07] = g_xccd3_d[l_ac].xcci006
#            LET l_field_keys[07] = 'xcce006'
#            LET l_var_keys[08] = g_xccd3_d[l_ac].xcci007
#            LET l_field_keys[08] = 'xcce007'
#            LET l_var_keys[09] = g_xccd3_d[l_ac].xcci008
#            LET l_field_keys[09] = 'xcce008'
#            LET l_var_keys[10] = g_xccd3_d[l_ac].xcci009
#            LET l_field_keys[10] = 'xcce009'
#            LET l_vars[01] = g_xccd_d[l_ac].xcce007
#            LET l_fields[01] = 'xcce007'
#            LET l_vars[02] = g_xccd_d[l_ac].xcce008
#            LET l_fields[02] = 'xcce008'
#            LET l_vars[03] = g_xccd_d[l_ac].xcce009
#            LET l_fields[03] = 'xcce009'
#            LET l_vars[04] = g_xccd_d[l_ac].xcce101
#            LET l_fields[04] = 'xcce101'
#            LET l_vars[05] = g_xccd_d[l_ac].xcce102
#            LET l_fields[05] = 'xcce102'
#            LET l_vars[06] = g_xccd_d[l_ac].xcce201
#            LET l_fields[06] = 'xcce201'
#            LET l_vars[07] = g_xccd_d[l_ac].xcce202
#            LET l_fields[07] = 'xcce202'
#            LET l_vars[08] = g_xccd_d[l_ac].xcce301
#            LET l_fields[08] = 'xcce301'
#            LET l_vars[09] = g_xccd_d[l_ac].xcce302
#            LET l_fields[09] = 'xcce302'
#            LET l_vars[10] = g_xccd_d[l_ac].xcce303
#            LET l_fields[10] = 'xcce303'
#            LET l_vars[11] = g_xccd_d[l_ac].xcce304
#            LET l_fields[11] = 'xcce304'
#            LET l_vars[12] = g_xccd_d[l_ac].xcce307
#            LET l_fields[12] = 'xcce307'
#            LET l_vars[13] = g_xccd_d[l_ac].xcce308
#            LET l_fields[13] = 'xcce308'
#            LET l_vars[14] = g_xccd_d[l_ac].xcce901
#            LET l_fields[14] = 'xcce901'
#            LET l_vars[15] = g_xccd_d[l_ac].xcce902
#            LET l_fields[15] = 'xcce902'
#            LET l_vars[16] = g_enterprise 
#            LET l_fields[16] = 'xcceent'
#            LET l_var_keys_bak[01] = g_detail_multi_table_t.xcceld
#            LET l_var_keys_bak[02] = g_detail_multi_table_t.xcce001
#            LET l_var_keys_bak[03] = g_detail_multi_table_t.xcce002
#            LET l_var_keys_bak[04] = g_detail_multi_table_t.xcce003
#            LET l_var_keys_bak[05] = g_detail_multi_table_t.xcce004
#            LET l_var_keys_bak[06] = g_detail_multi_table_t.xcce005
#            LET l_var_keys_bak[07] = g_detail_multi_table_t.xcce006
#            LET l_var_keys_bak[08] = g_detail_multi_table_t.xcce007
#            LET l_var_keys_bak[09] = g_detail_multi_table_t.xcce008
#            LET l_var_keys_bak[10] = g_detail_multi_table_t.xcce009
#            CALL cl_multitable(l_var_keys,l_field_keys,l_vars,l_fields,l_var_keys_bak,'xcce_t')
#         END IF 
#          INITIALIZE l_var_keys TO NULL 
#         INITIALIZE l_field_keys TO NULL 
#         INITIALIZE l_vars TO NULL 
#         INITIALIZE l_fields TO NULL 
#         INITIALIZE l_var_keys_bak TO NULL 
#         IF g_xccd_m.xccdld = g_detail_multi_table_t.xcbbcomp AND
#         g_xccd_m.xccd001 = g_detail_multi_table_t.xcbb001 AND
#         g_xccd_m.xccd003 = g_detail_multi_table_t.xcbb002 AND
#         g_xccd_m.xccd004 = g_detail_multi_table_t.xcbb003 AND
#         g_xccd_m.xccd005 = g_detail_multi_table_t.xcbb004 AND
#         g_xccd3_d[l_ac].xcci002 = g_detail_multi_table_t.xcbb005 AND
#         g_xccd3_d[l_ac].xcci006 =  AND
#         g_xccd3_d[l_ac].xcci007 =  AND
#         g_xccd3_d[l_ac].xcci008 =  AND
#         g_xccd3_d[l_ac].xcci009 =  AND
#         g_xccd_d[l_ac].xcbb005 =  THEN
#         ELSE 
#            LET l_var_keys[01] = g_xccd_m.xccdld
#            LET l_field_keys[01] = 'xcbbcomp'
#            LET l_var_keys[02] = g_xccd_m.xccd001
#            LET l_field_keys[02] = 'xcbb001'
#            LET l_var_keys[03] = g_xccd_m.xccd003
#            LET l_field_keys[03] = 'xcbb002'
#            LET l_var_keys[04] = g_xccd_m.xccd004
#            LET l_field_keys[04] = 'xcbb003'
#            LET l_var_keys[05] = g_xccd_m.xccd005
#            LET l_field_keys[05] = 'xcbb004'
#            LET l_vars[01] = g_xccd_d[l_ac].xcbb005
#            LET l_fields[01] = 'xcbb005'
#            LET l_vars[02] = g_enterprise 
#            LET l_fields[02] = 'xcbbent'
#            LET l_var_keys_bak[01] = g_detail_multi_table_t.xcbbcomp
#            LET l_var_keys_bak[02] = g_detail_multi_table_t.xcbb001
#            LET l_var_keys_bak[03] = g_detail_multi_table_t.xcbb002
#            LET l_var_keys_bak[04] = g_detail_multi_table_t.xcbb003
#            LET l_var_keys_bak[05] = g_detail_multi_table_t.xcbb004
#            CALL cl_multitable(l_var_keys,l_field_keys,l_vars,l_fields,l_var_keys_bak,'xcbb_t')
#         END IF 
# 
#               #add-point:input段-after_insert

#               #end add-point
#               CALL s_transaction_end('Y','0')
#               ERROR 'INSERT O.K'
#               LET g_rec_b = g_rec_b + 1
#            END IF
#              
#         BEFORE DELETE                            #是否取消單身
#            IF l_cmd = 'a' THEN
#               LET l_cmd='d'
#            ELSE
#               IF NOT cl_ask_del_detail() THEN
#                  CANCEL DELETE
#               END IF
#               IF l_lock_sw = "Y" THEN
#                  INITIALIZE g_errparam TO NULL 
#                  LET g_errparam.extend = "" 
#                  LET g_errparam.code   = -263 
#                  LET g_errparam.popup  = TRUE 
#                  CALL cl_err()
# 
#                  CANCEL DELETE
#               END IF
#               
#               #add-point:單身刪除前

#               #end add-point 
#               
#               DELETE FROM xccd_t
#                WHERE xccdent = g_enterprise AND  = g_xccd_m.xccdld AND
#                                           = g_xccd_m.xccd001 AND
#                                           = g_xccd_m.xccd003 AND
#                                           = g_xccd_m.xccd004 AND
#                                           = g_xccd_m.xccd005 AND
# 
#                      xccdld = g_xccd_d_t.xccdld
#                  AND xccd001 = g_xccd_d_t.xccd001
#                  AND xccd003 = g_xccd_d_t.xccd003
#                  AND xccd004 = g_xccd_d_t.xccd004
#                  AND xccd005 = g_xccd_d_t.xccd005
# 
#                  
#               #add-point:單身刪除中

#               #end add-point 
#               
#               IF SQLCA.sqlcode THEN
#                  INITIALIZE g_errparam TO NULL 
#                  LET g_errparam.extend = "xccd_t" 
#                  LET g_errparam.code   = SQLCA.sqlcode 
#                  LET g_errparam.popup  = TRUE 
#                  CALL cl_err()
# 
#                  CALL s_transaction_end('N','0')
#                  CANCEL DELETE   
#               ELSE
#                  LET g_rec_b = g_rec_b-1
#                  INITIALIZE l_var_keys_bak TO NULL 
#                  INITIALIZE l_field_keys TO NULL 
#                  LET l_field_keys[01] = 'xcbbcomp'
#                  LET l_field_keys[02] = 'xcbb001'
#                  LET l_field_keys[03] = 'xcbb002'
#                  LET l_field_keys[04] = 'xcbb003'
#                  LET l_field_keys[05] = 'xcbb004'
#                  LET l_var_keys_bak[01] = g_detail_multi_table_t.xcbbcomp
#                  LET l_var_keys_bak[02] = g_detail_multi_table_t.xcbb001
#                  LET l_var_keys_bak[03] = g_detail_multi_table_t.xcbb002
#                  LET l_var_keys_bak[04] = g_detail_multi_table_t.xcbb003
#                  LET l_var_keys_bak[05] = g_detail_multi_table_t.xcbb004
#                  CALL cl_multitable_delete(l_field_keys,l_var_keys_bak,'xcbb_t')
# 
#                  #add-point:單身刪除後

#                  #end add-point
#                  CALL s_transaction_end('Y','0')
#               END IF 
#               CLOSE axcq540_bcl
#               LET l_count = g_xccd_d.getLength()
#                              INITIALIZE gs_keys TO NULL 
#               LET gs_keys[1] = g_xccd_m.xccdld
#               LET gs_keys[2] = g_xccd_m.xccd001
#               LET gs_keys[3] = g_xccd_m.xccd003
#               LET gs_keys[4] = g_xccd_m.xccd004
#               LET gs_keys[5] = g_xccd_m.xccd005
#               LET gs_keys[6] = g_xccd_d[g_detail_idx].xccdld
#               LET gs_keys[7] = g_xccd_d[g_detail_idx].xccd001
#               LET gs_keys[8] = g_xccd_d[g_detail_idx].xccd003
#               LET gs_keys[9] = g_xccd_d[g_detail_idx].xccd004
#               LET gs_keys[10] = g_xccd_d[g_detail_idx].xccd005
# 
#            END IF 
#              
#         AFTER DELETE 
#            IF l_cmd <> 'd' THEN
#               #add-point:單身刪除後2

#               #end add-point
#                              CALL axcq540_delete_b('xccd_t',gs_keys,"'1'")
#            END IF
#            #如果是最後一筆
#            IF l_ac = (g_xccd_d.getLength() + 1) THEN
#               CALL FGL_SET_ARR_CURR(l_ac-1)
#            END IF
# 
#                  #此段落由子樣板a02產生
#         AFTER FIELD sfaa068
#            
#            #add-point:AFTER FIELD sfaa068
 
#            #END add-point
#            
# 
#         #此段落由子樣板a01產生
#         BEFORE FIELD sfaa068
#            #add-point:BEFORE FIELD sfaa068

#            #END add-point
# 
#         #此段落由子樣板a04產生
#         ON CHANGE sfaa068
#            #add-point:ON CHANGE sfaa068

#            #END add-point
# 
#         #此段落由子樣板a01產生
#         BEFORE FIELD xccd006
#            #add-point:BEFORE FIELD xccd006

#            #END add-point
# 
#         #此段落由子樣板a02產生
#         AFTER FIELD xccd006
#            
#            #add-point:AFTER FIELD xccd006


#            #END add-point
#            
# 
#         #此段落由子樣板a04產生
#         ON CHANGE xccd006
#            #add-point:ON CHANGE xccd006

#            #END add-point
# 
#         #此段落由子樣板a02產生
#         AFTER FIELD xcce007
#            
#            #add-point:AFTER FIELD xcce007


#            #END add-point
#            
# 
#         #此段落由子樣板a01產生
#         BEFORE FIELD xcce007
#            #add-point:BEFORE FIELD xcce007

#            #END add-point
# 
#         #此段落由子樣板a04產生
#         ON CHANGE xcce007
#            #add-point:ON CHANGE xcce007

#            #END add-point
# 
#         #此段落由子樣板a01產生
#         BEFORE FIELD xcce008
#            #add-point:BEFORE FIELD xcce008

#            #END add-point
# 
#         #此段落由子樣板a02產生
#         AFTER FIELD xcce008
#            
#            #add-point:AFTER FIELD xcce008

#            #END add-point
#            
# 
#         #此段落由子樣板a04產生
#         ON CHANGE xcce008
#            #add-point:ON CHANGE xcce008

#            #END add-point
# 
#         #此段落由子樣板a01產生
#         BEFORE FIELD xcce009
#            #add-point:BEFORE FIELD xcce009

#            #END add-point
# 
#         #此段落由子樣板a02產生
#         AFTER FIELD xcce009
#            
#            #add-point:AFTER FIELD xcce009

#            #END add-point
#            
# 
#         #此段落由子樣板a04產生
#         ON CHANGE xcce009
#            #add-point:ON CHANGE xcce009

#            #END add-point
# 
#         #此段落由子樣板a02產生
#         AFTER FIELD xcbb005
#            
#            #add-point:AFTER FIELD xcbb005
 
#            #END add-point
#            
# 
#         #此段落由子樣板a01產生
#         BEFORE FIELD xcbb005
#            #add-point:BEFORE FIELD xcbb005

#            #END add-point
# 
#         #此段落由子樣板a04產生
#         ON CHANGE xcbb005
#            #add-point:ON CHANGE xcbb005

#            #END add-point
# 
#         #此段落由子樣板a01產生
#         BEFORE FIELD xccd002
#            #add-point:BEFORE FIELD xccd002

#            #END add-point
# 
#         #此段落由子樣板a02產生
#         AFTER FIELD xccd002
#            
#            #add-point:AFTER FIELD xccd002
 
#            #END add-point
#            
# 
#         #此段落由子樣板a04產生
#         ON CHANGE xccd002
#            #add-point:ON CHANGE xccd002

#            #END add-point
# 
#         #此段落由子樣板a01產生
#         BEFORE FIELD xcce101
#            #add-point:BEFORE FIELD xcce101

#            #END add-point
# 
#         #此段落由子樣板a02產生
#         AFTER FIELD xcce101
#            
#            #add-point:AFTER FIELD xcce101

#            #END add-point
#            
# 
#         #此段落由子樣板a04產生
#         ON CHANGE xcce101
#            #add-point:ON CHANGE xcce101

#            #END add-point
# 
#         #此段落由子樣板a01產生
#         BEFORE FIELD xcce102
#            #add-point:BEFORE FIELD xcce102

#            #END add-point
# 
#         #此段落由子樣板a02產生
#         AFTER FIELD xcce102
#            
#            #add-point:AFTER FIELD xcce102

#            #END add-point
#            
# 
#         #此段落由子樣板a04產生
#         ON CHANGE xcce102
#            #add-point:ON CHANGE xcce102

#            #END add-point
# 
#         #此段落由子樣板a01產生
#         BEFORE FIELD xcce201
#            #add-point:BEFORE FIELD xcce201

#            #END add-point
# 
#         #此段落由子樣板a02產生
#         AFTER FIELD xcce201
#            
#            #add-point:AFTER FIELD xcce201

#            #END add-point
#            
# 
#         #此段落由子樣板a04產生
#         ON CHANGE xcce201
#            #add-point:ON CHANGE xcce201

#            #END add-point
# 
#         #此段落由子樣板a01產生
#         BEFORE FIELD xcce202
#            #add-point:BEFORE FIELD xcce202

#            #END add-point
# 
#         #此段落由子樣板a02產生
#         AFTER FIELD xcce202
#            
#            #add-point:AFTER FIELD xcce202

#            #END add-point
#            
# 
#         #此段落由子樣板a04產生
#         ON CHANGE xcce202
#            #add-point:ON CHANGE xcce202

#            #END add-point
# 
#         #此段落由子樣板a01產生
#         BEFORE FIELD xcce301
#            #add-point:BEFORE FIELD xcce301

#            #END add-point
# 
#         #此段落由子樣板a02產生
#         AFTER FIELD xcce301
#            
#            #add-point:AFTER FIELD xcce301

#            #END add-point
#            
# 
#         #此段落由子樣板a04產生
#         ON CHANGE xcce301
#            #add-point:ON CHANGE xcce301

#            #END add-point
# 
#         #此段落由子樣板a01產生
#         BEFORE FIELD xcce302
#            #add-point:BEFORE FIELD xcce302

#            #END add-point
# 
#         #此段落由子樣板a02產生
#         AFTER FIELD xcce302
#            
#            #add-point:AFTER FIELD xcce302

#            #END add-point
#            
# 
#         #此段落由子樣板a04產生
#         ON CHANGE xcce302
#            #add-point:ON CHANGE xcce302

#            #END add-point
# 
#         #此段落由子樣板a01產生
#         BEFORE FIELD xcce303
#            #add-point:BEFORE FIELD xcce303

#            #END add-point
# 
#         #此段落由子樣板a02產生
#         AFTER FIELD xcce303
#            
#            #add-point:AFTER FIELD xcce303

#            #END add-point
#            
# 
#         #此段落由子樣板a04產生
#         ON CHANGE xcce303
#            #add-point:ON CHANGE xcce303

#            #END add-point
# 
#         #此段落由子樣板a01產生
#         BEFORE FIELD xcce304
#            #add-point:BEFORE FIELD xcce304

#            #END add-point
# 
#         #此段落由子樣板a02產生
#         AFTER FIELD xcce304
#            
#            #add-point:AFTER FIELD xcce304

#            #END add-point
#            
# 
#         #此段落由子樣板a04產生
#         ON CHANGE xcce304
#            #add-point:ON CHANGE xcce304

#            #END add-point
# 
#         #此段落由子樣板a01產生
#         BEFORE FIELD xcce307
#            #add-point:BEFORE FIELD xcce307

#            #END add-point
# 
#         #此段落由子樣板a02產生
#         AFTER FIELD xcce307
#            
#            #add-point:AFTER FIELD xcce307

#            #END add-point
#            
# 
#         #此段落由子樣板a04產生
#         ON CHANGE xcce307
#            #add-point:ON CHANGE xcce307

#            #END add-point
# 
#         #此段落由子樣板a01產生
#         BEFORE FIELD xcce308
#            #add-point:BEFORE FIELD xcce308

#            #END add-point
# 
#         #此段落由子樣板a02產生
#         AFTER FIELD xcce308
#            
#            #add-point:AFTER FIELD xcce308

#            #END add-point
#            
# 
#         #此段落由子樣板a04產生
#         ON CHANGE xcce308
#            #add-point:ON CHANGE xcce308

#            #END add-point
# 
#         #此段落由子樣板a01產生
#         BEFORE FIELD xcce901
#            #add-point:BEFORE FIELD xcce901

#            #END add-point
# 
#         #此段落由子樣板a02產生
#         AFTER FIELD xcce901
#            
#            #add-point:AFTER FIELD xcce901

#            #END add-point
#            
# 
#         #此段落由子樣板a04產生
#         ON CHANGE xcce901
#            #add-point:ON CHANGE xcce901

#            #END add-point
# 
#         #此段落由子樣板a01產生
#         BEFORE FIELD xcce902
#            #add-point:BEFORE FIELD xcce902

#            #END add-point
# 
#         #此段落由子樣板a02產生
#         AFTER FIELD xcce902
#            
#            #add-point:AFTER FIELD xcce902

#            #END add-point
#            
# 
#         #此段落由子樣板a04產生
#         ON CHANGE xcce902
#            #add-point:ON CHANGE xcce902

#            #END add-point
# 
# 
#                  #Ctrlp:input.c.page1.sfaa068
#         ON ACTION controlp INFIELD sfaa068
#            #add-point:ON ACTION controlp INFIELD sfaa068

#            #END add-point
# 
#         #Ctrlp:input.c.page1.xccd006
#         ON ACTION controlp INFIELD xccd006
#            #add-point:ON ACTION controlp INFIELD xccd006

#            #END add-point
# 
#         #Ctrlp:input.c.page1.xcce007
#         ON ACTION controlp INFIELD xcce007
#            #add-point:ON ACTION controlp INFIELD xcce007

#            #END add-point
# 
#         #Ctrlp:input.c.page1.xcce008
#         ON ACTION controlp INFIELD xcce008
#            #add-point:ON ACTION controlp INFIELD xcce008

#            #END add-point
# 
#         #Ctrlp:input.c.page1.xcce009
#         ON ACTION controlp INFIELD xcce009
#            #add-point:ON ACTION controlp INFIELD xcce009

#            #END add-point
# 
#         #Ctrlp:input.c.page1.xcbb005
#         ON ACTION controlp INFIELD xcbb005
#            #add-point:ON ACTION controlp INFIELD xcbb005

#            #END add-point
# 
#         #Ctrlp:input.c.page1.xccd002
#         ON ACTION controlp INFIELD xccd002
#            #add-point:ON ACTION controlp INFIELD xccd002

#            #END add-point
# 
#         #Ctrlp:input.c.page1.xcce101
#         ON ACTION controlp INFIELD xcce101
#            #add-point:ON ACTION controlp INFIELD xcce101

#            #END add-point
# 
#         #Ctrlp:input.c.page1.xcce102
#         ON ACTION controlp INFIELD xcce102
#            #add-point:ON ACTION controlp INFIELD xcce102

#            #END add-point
# 
#         #Ctrlp:input.c.page1.xcce201
#         ON ACTION controlp INFIELD xcce201
#            #add-point:ON ACTION controlp INFIELD xcce201

#            #END add-point
# 
#         #Ctrlp:input.c.page1.xcce202
#         ON ACTION controlp INFIELD xcce202
#            #add-point:ON ACTION controlp INFIELD xcce202

#            #END add-point
# 
#         #Ctrlp:input.c.page1.xcce301
#         ON ACTION controlp INFIELD xcce301
#            #add-point:ON ACTION controlp INFIELD xcce301

#            #END add-point
# 
#         #Ctrlp:input.c.page1.xcce302
#         ON ACTION controlp INFIELD xcce302
#            #add-point:ON ACTION controlp INFIELD xcce302

#            #END add-point
# 
#         #Ctrlp:input.c.page1.xcce303
#         ON ACTION controlp INFIELD xcce303
#            #add-point:ON ACTION controlp INFIELD xcce303

#            #END add-point
# 
#         #Ctrlp:input.c.page1.xcce304
#         ON ACTION controlp INFIELD xcce304
#            #add-point:ON ACTION controlp INFIELD xcce304

#            #END add-point
# 
#         #Ctrlp:input.c.page1.xcce307
#         ON ACTION controlp INFIELD xcce307
#            #add-point:ON ACTION controlp INFIELD xcce307

#            #END add-point
# 
#         #Ctrlp:input.c.page1.xcce308
#         ON ACTION controlp INFIELD xcce308
#            #add-point:ON ACTION controlp INFIELD xcce308

#            #END add-point
# 
#         #Ctrlp:input.c.page1.xcce901
#         ON ACTION controlp INFIELD xcce901
#            #add-point:ON ACTION controlp INFIELD xcce901

#            #END add-point
# 
#         #Ctrlp:input.c.page1.xcce902
#         ON ACTION controlp INFIELD xcce902
#            #add-point:ON ACTION controlp INFIELD xcce902

#            #END add-point
# 
# 
# 
#         ON ROW CHANGE
#            IF INT_FLAG THEN
#               INITIALIZE g_errparam TO NULL 
#               LET g_errparam.extend = '' 
#               LET g_errparam.code   = 9001 
#               LET g_errparam.popup  = FALSE 
#               CALL cl_err()
# 
#               LET INT_FLAG = 0
#               LET g_xccd_d[l_ac].* = g_xccd_d_t.*
#               CLOSE axcq540_bcl
#               CALL s_transaction_end('N','0')
#               EXIT DIALOG 
#            END IF
#              
#            IF l_lock_sw = 'Y' THEN
#               INITIALIZE g_errparam TO NULL 
#               LET g_errparam.extend = g_xccd_d[l_ac].xccdld 
#               LET g_errparam.code   = -263 
#               LET g_errparam.popup  = TRUE 
#               CALL cl_err()
# 
#               LET g_xccd_d[l_ac].* = g_xccd_d_t.*
#            ELSE
#            
#               #add-point:單身修改前

#               #end add-point
#               
#               #寫入修改者/修改日期資訊(單身)
#               
#      
#               UPDATE xccd_t SET (xccd006,xccd002) = (g_xccd_m.xccdld,g_xccd_m.xccd001,g_xccd_m.xccd003, 
#                   g_xccd_m.xccd004,g_xccd_m.xccd005,g_xccd_d[l_ac].xccd006,g_xccd_d[l_ac].xccd002)
#                WHERE xccdent = g_enterprise AND  = g_xccd_m.xccdld 
#                  AND  = g_xccd_m.xccd001 
#                  AND  = g_xccd_m.xccd003 
#                  AND  = g_xccd_m.xccd004 
#                  AND  = g_xccd_m.xccd005 
# 
#                  AND xccdld = g_xccd_d_t.xccdld #項次   
#                  AND xccd001 = g_xccd_d_t.xccd001  
#                  AND xccd003 = g_xccd_d_t.xccd003  
#                  AND xccd004 = g_xccd_d_t.xccd004  
#                  AND xccd005 = g_xccd_d_t.xccd005  
# 
#                  
#               #add-point:單身修改中

#               #end add-point
#               CASE
#                  WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
#                     INITIALIZE g_errparam TO NULL 
#                     LET g_errparam.extend = "xccd_t" 
#                     LET g_errparam.code   = "std-00009" 
#                     LET g_errparam.popup  = TRUE 
#                     CALL cl_err()
#                     CALL s_transaction_end('N','0')
#                     LET g_xccd_d[l_ac].* = g_xccd_d_t.*
#                  WHEN SQLCA.sqlcode #其他錯誤
#                     INITIALIZE g_errparam TO NULL 
#                     LET g_errparam.extend = "xccd_t" 
#                     LET g_errparam.code   = SQLCA.sqlcode 
#                     LET g_errparam.popup  = TRUE 
#                     CALL cl_err()                   
#                     CALL s_transaction_end('N','0')
#                     LET g_xccd_d[l_ac].* = g_xccd_d_t.*  
#                  OTHERWISE
#                                    INITIALIZE gs_keys TO NULL 
#               LET gs_keys[1] = g_xccd_m.xccdld
#               LET gs_keys_bak[1] = g_xccdld_t
#               LET gs_keys[2] = g_xccd_m.xccd001
#               LET gs_keys_bak[2] = g_xccd001_t
#               LET gs_keys[3] = g_xccd_m.xccd003
#               LET gs_keys_bak[3] = g_xccd003_t
#               LET gs_keys[4] = g_xccd_m.xccd004
#               LET gs_keys_bak[4] = g_xccd004_t
#               LET gs_keys[5] = g_xccd_m.xccd005
#               LET gs_keys_bak[5] = g_xccd005_t
#               LET gs_keys[6] = g_xccd_d[g_detail_idx].xccdld
#               LET gs_keys_bak[6] = g_xccd_d_t.xccdld
#               LET gs_keys[7] = g_xccd_d[g_detail_idx].xccd001
#               LET gs_keys_bak[7] = g_xccd_d_t.xccd001
#               LET gs_keys[8] = g_xccd_d[g_detail_idx].xccd003
#               LET gs_keys_bak[8] = g_xccd_d_t.xccd003
#               LET gs_keys[9] = g_xccd_d[g_detail_idx].xccd004
#               LET gs_keys_bak[9] = g_xccd_d_t.xccd004
#               LET gs_keys[10] = g_xccd_d[g_detail_idx].xccd005
#               LET gs_keys_bak[10] = g_xccd_d_t.xccd005
#               CALL axcq540_update_b('xccd_t',gs_keys,gs_keys_bak,"'1'")
#                     #資料多語言用-增/改
#                              INITIALIZE l_var_keys TO NULL 
#         INITIALIZE l_field_keys TO NULL 
#         INITIALIZE l_vars TO NULL 
#         INITIALIZE l_fields TO NULL 
#         INITIALIZE l_var_keys_bak TO NULL 
#         IF g_xccd_m.xccdld = g_detail_multi_table_t.sfaadocno AND
#         g_xccd_m.xccd001 = g_detail_multi_table_t.sfaa068 AND
#         g_xccd_m.xccd003 =  AND
#         g_xccd_m.xccd004 =  AND
#         g_xccd_m.xccd005 =  AND
#         g_xccd3_d[l_ac].xcci002 =  AND
#         g_xccd3_d[l_ac].xcci006 =  AND
#         g_xccd3_d[l_ac].xcci007 =  AND
#         g_xccd3_d[l_ac].xcci008 =  AND
#         g_xccd3_d[l_ac].xcci009 =  AND
#         g_xccd_d[l_ac].sfaa068 =  THEN
#         ELSE 
#            LET l_var_keys[01] = g_xccd_m.xccdld
#            LET l_field_keys[01] = 'sfaadocno'
#            LET l_vars[01] = g_xccd_d[l_ac].sfaa068
#            LET l_fields[01] = 'sfaa068'
#            LET l_vars[02] = g_site 
#            LET l_fields[02] = 'sfaasite'
#            LET l_vars[03] = g_enterprise 
#            LET l_fields[03] = 'sfaaent'
#            LET l_var_keys_bak[01] = g_detail_multi_table_t.sfaadocno
#            CALL cl_multitable(l_var_keys,l_field_keys,l_vars,l_fields,l_var_keys_bak,'sfaa_t')
#         END IF 
#          INITIALIZE l_var_keys TO NULL 
#         INITIALIZE l_field_keys TO NULL 
#         INITIALIZE l_vars TO NULL 
#         INITIALIZE l_fields TO NULL 
#         INITIALIZE l_var_keys_bak TO NULL 
#         IF g_xccd_m.xccdld = g_detail_multi_table_t.xcceld AND
#         g_xccd_m.xccd001 = g_detail_multi_table_t.xcce001 AND
#         g_xccd_m.xccd003 = g_detail_multi_table_t.xcce002 AND
#         g_xccd_m.xccd004 = g_detail_multi_table_t.xcce003 AND
#         g_xccd_m.xccd005 = g_detail_multi_table_t.xcce004 AND
#         g_xccd3_d[l_ac].xcci002 = g_detail_multi_table_t.xcce005 AND
#         g_xccd3_d[l_ac].xcci006 = g_detail_multi_table_t.xcce006 AND
#         g_xccd3_d[l_ac].xcci007 = g_detail_multi_table_t.xcce007 AND
#         g_xccd3_d[l_ac].xcci008 = g_detail_multi_table_t.xcce008 AND
#         g_xccd3_d[l_ac].xcci009 = g_detail_multi_table_t.xcce009 AND
#         g_xccd_d[l_ac].xcce007 = g_detail_multi_table_t.xcce007 AND
#         g_xccd_d[l_ac].xcce008 = g_detail_multi_table_t.xcce008 AND
#         g_xccd_d[l_ac].xcce009 = g_detail_multi_table_t.xcce009 AND
#         g_xccd_d[l_ac].xcce101 = g_detail_multi_table_t.xcce101 AND
#         g_xccd_d[l_ac].xcce102 = g_detail_multi_table_t.xcce102 AND
#         g_xccd_d[l_ac].xcce201 = g_detail_multi_table_t.xcce201 AND
#         g_xccd_d[l_ac].xcce202 = g_detail_multi_table_t.xcce202 AND
#         g_xccd_d[l_ac].xcce301 = g_detail_multi_table_t.xcce301 AND
#         g_xccd_d[l_ac].xcce302 = g_detail_multi_table_t.xcce302 AND
#         g_xccd_d[l_ac].xcce303 = g_detail_multi_table_t.xcce303 AND
#         g_xccd_d[l_ac].xcce304 = g_detail_multi_table_t.xcce304 AND
#         g_xccd_d[l_ac].xcce307 = g_detail_multi_table_t.xcce307 AND
#         g_xccd_d[l_ac].xcce308 = g_detail_multi_table_t.xcce308 AND
#         g_xccd_d[l_ac].xcce901 = g_detail_multi_table_t.xcce901 AND
#         g_xccd_d[l_ac].xcce902 = g_detail_multi_table_t.xcce902 THEN
#         ELSE 
#            LET l_var_keys[01] = g_xccd_m.xccdld
#            LET l_field_keys[01] = 'xcceld'
#            LET l_var_keys[02] = g_xccd_m.xccd001
#            LET l_field_keys[02] = 'xcce001'
#            LET l_var_keys[03] = g_xccd_m.xccd003
#            LET l_field_keys[03] = 'xcce002'
#            LET l_var_keys[04] = g_xccd_m.xccd004
#            LET l_field_keys[04] = 'xcce003'
#            LET l_var_keys[05] = g_xccd_m.xccd005
#            LET l_field_keys[05] = 'xcce004'
#            LET l_var_keys[06] = g_xccd3_d[l_ac].xcci002
#            LET l_field_keys[06] = 'xcce005'
#            LET l_var_keys[07] = g_xccd3_d[l_ac].xcci006
#            LET l_field_keys[07] = 'xcce006'
#            LET l_var_keys[08] = g_xccd3_d[l_ac].xcci007
#            LET l_field_keys[08] = 'xcce007'
#            LET l_var_keys[09] = g_xccd3_d[l_ac].xcci008
#            LET l_field_keys[09] = 'xcce008'
#            LET l_var_keys[10] = g_xccd3_d[l_ac].xcci009
#            LET l_field_keys[10] = 'xcce009'
#            LET l_vars[01] = g_xccd_d[l_ac].xcce007
#            LET l_fields[01] = 'xcce007'
#            LET l_vars[02] = g_xccd_d[l_ac].xcce008
#            LET l_fields[02] = 'xcce008'
#            LET l_vars[03] = g_xccd_d[l_ac].xcce009
#            LET l_fields[03] = 'xcce009'
#            LET l_vars[04] = g_xccd_d[l_ac].xcce101
#            LET l_fields[04] = 'xcce101'
#            LET l_vars[05] = g_xccd_d[l_ac].xcce102
#            LET l_fields[05] = 'xcce102'
#            LET l_vars[06] = g_xccd_d[l_ac].xcce201
#            LET l_fields[06] = 'xcce201'
#            LET l_vars[07] = g_xccd_d[l_ac].xcce202
#            LET l_fields[07] = 'xcce202'
#            LET l_vars[08] = g_xccd_d[l_ac].xcce301
#            LET l_fields[08] = 'xcce301'
#            LET l_vars[09] = g_xccd_d[l_ac].xcce302
#            LET l_fields[09] = 'xcce302'
#            LET l_vars[10] = g_xccd_d[l_ac].xcce303
#            LET l_fields[10] = 'xcce303'
#            LET l_vars[11] = g_xccd_d[l_ac].xcce304
#            LET l_fields[11] = 'xcce304'
#            LET l_vars[12] = g_xccd_d[l_ac].xcce307
#            LET l_fields[12] = 'xcce307'
#            LET l_vars[13] = g_xccd_d[l_ac].xcce308
#            LET l_fields[13] = 'xcce308'
#            LET l_vars[14] = g_xccd_d[l_ac].xcce901
#            LET l_fields[14] = 'xcce901'
#            LET l_vars[15] = g_xccd_d[l_ac].xcce902
#            LET l_fields[15] = 'xcce902'
#            LET l_vars[16] = g_enterprise 
#            LET l_fields[16] = 'xcceent'
#            LET l_var_keys_bak[01] = g_detail_multi_table_t.xcceld
#            LET l_var_keys_bak[02] = g_detail_multi_table_t.xcce001
#            LET l_var_keys_bak[03] = g_detail_multi_table_t.xcce002
#            LET l_var_keys_bak[04] = g_detail_multi_table_t.xcce003
#            LET l_var_keys_bak[05] = g_detail_multi_table_t.xcce004
#            LET l_var_keys_bak[06] = g_detail_multi_table_t.xcce005
#            LET l_var_keys_bak[07] = g_detail_multi_table_t.xcce006
#            LET l_var_keys_bak[08] = g_detail_multi_table_t.xcce007
#            LET l_var_keys_bak[09] = g_detail_multi_table_t.xcce008
#            LET l_var_keys_bak[10] = g_detail_multi_table_t.xcce009
#            CALL cl_multitable(l_var_keys,l_field_keys,l_vars,l_fields,l_var_keys_bak,'xcce_t')
#         END IF 
#          INITIALIZE l_var_keys TO NULL 
#         INITIALIZE l_field_keys TO NULL 
#         INITIALIZE l_vars TO NULL 
#         INITIALIZE l_fields TO NULL 
#         INITIALIZE l_var_keys_bak TO NULL 
#         IF g_xccd_m.xccdld = g_detail_multi_table_t.xcbbcomp AND
#         g_xccd_m.xccd001 = g_detail_multi_table_t.xcbb001 AND
#         g_xccd_m.xccd003 = g_detail_multi_table_t.xcbb002 AND
#         g_xccd_m.xccd004 = g_detail_multi_table_t.xcbb003 AND
#         g_xccd_m.xccd005 = g_detail_multi_table_t.xcbb004 AND
#         g_xccd3_d[l_ac].xcci002 = g_detail_multi_table_t.xcbb005 AND
#         g_xccd3_d[l_ac].xcci006 =  AND
#         g_xccd3_d[l_ac].xcci007 =  AND
#         g_xccd3_d[l_ac].xcci008 =  AND
#         g_xccd3_d[l_ac].xcci009 =  AND
#         g_xccd_d[l_ac].xcbb005 =  THEN
#         ELSE 
#            LET l_var_keys[01] = g_xccd_m.xccdld
#            LET l_field_keys[01] = 'xcbbcomp'
#            LET l_var_keys[02] = g_xccd_m.xccd001
#            LET l_field_keys[02] = 'xcbb001'
#            LET l_var_keys[03] = g_xccd_m.xccd003
#            LET l_field_keys[03] = 'xcbb002'
#            LET l_var_keys[04] = g_xccd_m.xccd004
#            LET l_field_keys[04] = 'xcbb003'
#            LET l_var_keys[05] = g_xccd_m.xccd005
#            LET l_field_keys[05] = 'xcbb004'
#            LET l_vars[01] = g_xccd_d[l_ac].xcbb005
#            LET l_fields[01] = 'xcbb005'
#            LET l_vars[02] = g_enterprise 
#            LET l_fields[02] = 'xcbbent'
#            LET l_var_keys_bak[01] = g_detail_multi_table_t.xcbbcomp
#            LET l_var_keys_bak[02] = g_detail_multi_table_t.xcbb001
#            LET l_var_keys_bak[03] = g_detail_multi_table_t.xcbb002
#            LET l_var_keys_bak[04] = g_detail_multi_table_t.xcbb003
#            LET l_var_keys_bak[05] = g_detail_multi_table_t.xcbb004
#            CALL cl_multitable(l_var_keys,l_field_keys,l_vars,l_fields,l_var_keys_bak,'xcbb_t')
#         END IF 
# 
#               END CASE
#               
#               #修改歷程記錄
#               LET g_log1 = util.JSON.stringify(g_xccd_m),util.JSON.stringify(g_xccd_d_t)
#               LET g_log2 = util.JSON.stringify(g_xccd_m),util.JSON.stringify(g_xccd_d[l_ac])
#               IF NOT cl_log_modified_record(g_log1,g_log2) THEN 
#                  CALL s_transaction_end('N','0')
#               END IF
#               
#               #add-point:單身修改後

#               #end add-point
# 
#            END IF
#            
#         AFTER ROW
#            #add-point:單身after_row

#            #end add-point
#            CALL axcq540_unlock_b("xccd_t","'1'")
#            CALL s_transaction_end('Y','0')
#            #其他table進行unlock
#            #add-point:單身after_row2

#            #end add-point
#              
#         AFTER INPUT
#            #add-point:input段after input 

#            #end add-point 
# 
#         ON ACTION controlo    
#            CALL FGL_SET_ARR_CURR(g_xccd_d.getLength()+1)
#            LET lb_reproduce = TRUE
#            LET li_reproduce = l_ac
#            LET li_reproduce_target = g_xccd_d.getLength()+1
#            
#         #ON ACTION cancel
#         #   LET INT_FLAG = 1
#         #   LET g_detail_idx = 1
#         #   EXIT DIALOG 
# 
#      END INPUT
#      
#      INPUT ARRAY g_xccd2_d FROM s_detail2.*
#         ATTRIBUTE(COUNT = g_rec_b,WITHOUT DEFAULTS, #MAXCOUNT = g_max_rec,
#                 INSERT ROW = l_allow_insert, #此頁面insert功能由產生器控制, 手動之設定無效! 
#
#                 DELETE ROW = l_allow_delete,
#                 APPEND ROW = l_allow_insert)
#                 
#         #自訂ACTION(detail_input,page_2)
#         
#         
#         BEFORE INPUT
#            #add-point:資料輸入前

#            #end add-point
#            IF g_insert = 'Y' AND NOT cl_null(g_insert) THEN 
#              CALL FGL_SET_ARR_CURR(g_xccd2_d.getLength()+1) 
#              LET g_insert = 'N' 
#           END IF 
# 
#            CALL axcq540_b_fill()
#            LET g_rec_b = g_xccd2_d.getLength()
#            #add-point:資料輸入前

#            #end add-point
#            
#         BEFORE INSERT
#            
#            LET l_insert = TRUE
#            LET l_n = ARR_COUNT()
#            LET l_cmd = 'a'
#            INITIALIZE g_xccd2_d[l_ac].* TO NULL 
#            INITIALIZE g_xccd2_d_t.* TO NULL 
#            INITIALIZE g_xccd2_d_o.* TO NULL 
#            #公用欄位給值(單身2)
#            
#            #自定義預設值(單身2)
#            
#            #add-point:modify段before備份

#            #end add-point
#            LET g_xccd2_d_t.* = g_xccd2_d[l_ac].*     #新輸入資料
#            LET g_xccd2_d_o.* = g_xccd2_d[l_ac].*     #新輸入資料
#            CALL cl_show_fld_cont()
#            CALL axcq540_set_entry_b(l_cmd)
#            #add-point:modify段after_set_entry_b

#            #end add-point
#            CALL axcq540_set_no_entry_b(l_cmd)
#            IF lb_reproduce THEN
#               LET lb_reproduce = FALSE
#               LET g_xccd2_d[li_reproduce_target].* = g_xccd2_d[li_reproduce].*
# 
#               LET g_xccd2_d[li_reproduce_target].xcce002 = NULL
#               LET g_xccd2_d[li_reproduce_target].xcce006 = NULL
#               LET g_xccd2_d[li_reproduce_target].xcce007 = NULL
#               LET g_xccd2_d[li_reproduce_target].xcce008 = NULL
#               LET g_xccd2_d[li_reproduce_target].xcce009 = NULL
#            END IF
#            LET g_detail_multi_table_t.xcbbcomp = g_xccd_m.xccdld
#LET g_detail_multi_table_t.xcbb001 = g_xccd_m.xccd001
#LET g_detail_multi_table_t.xcbb002 = g_xccd_m.xccd003
#LET g_detail_multi_table_t.xcbb003 = g_xccd_m.xccd004
#LET g_detail_multi_table_t.xcbb004 = g_xccd_m.xccd005
#LET g_detail_multi_table_t.xcbb005 = g_xccd3_d[l_ac].xcci002
# 
#            #add-point:modify段before insert

#            #end add-point  
#            
#         BEFORE ROW     
#            #add-point:modify段before row2

#            #end add-point  
#            LET l_insert = FALSE
#            LET l_cmd = ''
#            LET l_ac = ARR_CURR()
#            LET g_detail_idx = l_ac
#              
#            LET l_lock_sw = 'N'            #DEFAULT
#            LET l_n = ARR_COUNT()
#            DISPLAY l_ac TO FORMONLY.idx
#         
#            CALL s_transaction_begin()
#            OPEN axcq540_cl USING g_enterprise,g_xccd_m.xccdld,g_xccd_m.xccd001,g_xccd_m.xccd003,g_xccd_m.xccd004,g_xccd_m.xccd005
#            IF STATUS THEN
#               INITIALIZE g_errparam TO NULL 
#               LET g_errparam.extend = "OPEN axcq540_cl:" 
#               LET g_errparam.code   = STATUS 
#               LET g_errparam.popup  = TRUE 
#               CALL cl_err()
#               CLOSE axcq540_cl
#               CALL s_transaction_end('N','0')
#               RETURN
#            END IF
#            
#            LET g_rec_b = g_xccd2_d.getLength()
#            
#            IF g_rec_b >= l_ac 
#               AND g_xccd2_d[l_ac].xcce002 IS NOT NULL
#               AND g_xccd2_d[l_ac].xcce006 IS NOT NULL
#               AND g_xccd2_d[l_ac].xcce007 IS NOT NULL
#               AND g_xccd2_d[l_ac].xcce008 IS NOT NULL
#               AND g_xccd2_d[l_ac].xcce009 IS NOT NULL
#            THEN 
#               LET l_cmd='u'
#               LET g_xccd2_d_t.* = g_xccd2_d[l_ac].*  #BACKUP
#               LET g_xccd2_d_o.* = g_xccd2_d[l_ac].*  #BACKUP
#               CALL axcq540_set_entry_b(l_cmd)
#               #add-point:modify段after_set_entry_b

#               #end add-point  
#               CALL axcq540_set_no_entry_b(l_cmd)
#               IF NOT axcq540_lock_b("xcce_t","'2'") THEN
#                  LET l_lock_sw='Y'
#               ELSE
#                  FETCH axcq540_bcl2 INTO g_xccd2_d[l_ac].xcce006,g_xccd2_d[l_ac].xcce007,g_xccd2_d[l_ac].xcce008, 
#                      g_xccd2_d[l_ac].xcce009,g_xccd2_d[l_ac].xcce002,g_xccd2_d[l_ac].xcce101,g_xccd2_d[l_ac].xcce102a, 
#                      g_xccd2_d[l_ac].xcce102b,g_xccd2_d[l_ac].xcce102c,g_xccd2_d[l_ac].xcce102d,g_xccd2_d[l_ac].xcce102e, 
#                      g_xccd2_d[l_ac].xcce102f,g_xccd2_d[l_ac].xcce102g,g_xccd2_d[l_ac].xcce102h,g_xccd2_d[l_ac].xcce102, 
#                      g_xccd2_d[l_ac].xcce201,g_xccd2_d[l_ac].xcce202a,g_xccd2_d[l_ac].xcce202b,g_xccd2_d[l_ac].xcce202c, 
#                      g_xccd2_d[l_ac].xcce202d,g_xccd2_d[l_ac].xcce202e,g_xccd2_d[l_ac].xcce202f,g_xccd2_d[l_ac].xcce202g, 
#                      g_xccd2_d[l_ac].xcce202h,g_xccd2_d[l_ac].xcce202,g_xccd2_d[l_ac].xcce301,g_xccd2_d[l_ac].xcce302a, 
#                      g_xccd2_d[l_ac].xcce302b,g_xccd2_d[l_ac].xcce302c,g_xccd2_d[l_ac].xcce302d,g_xccd2_d[l_ac].xcce302e, 
#                      g_xccd2_d[l_ac].xcce302f,g_xccd2_d[l_ac].xcce302g,g_xccd2_d[l_ac].xcce302h,g_xccd2_d[l_ac].xcce302, 
#                      g_xccd2_d[l_ac].xcce303,g_xccd2_d[l_ac].xcce304a,g_xccd2_d[l_ac].xcce304b,g_xccd2_d[l_ac].xcce304c, 
#                      g_xccd2_d[l_ac].xcce304d,g_xccd2_d[l_ac].xcce304e,g_xccd2_d[l_ac].xcce304f,g_xccd2_d[l_ac].xcce304g, 
#                      g_xccd2_d[l_ac].xcce304h,g_xccd2_d[l_ac].xcce304,g_xccd2_d[l_ac].xcce307,g_xccd2_d[l_ac].xcce308a, 
#                      g_xccd2_d[l_ac].xcce308b,g_xccd2_d[l_ac].xcce308c,g_xccd2_d[l_ac].xcce308d,g_xccd2_d[l_ac].xcce308e, 
#                      g_xccd2_d[l_ac].xcce308f,g_xccd2_d[l_ac].xcce308g,g_xccd2_d[l_ac].xcce308h,g_xccd2_d[l_ac].xcce308, 
#                      g_xccd2_d[l_ac].xcce901,g_xccd2_d[l_ac].xcce902a,g_xccd2_d[l_ac].xcce902b,g_xccd2_d[l_ac].xcce902c, 
#                      g_xccd2_d[l_ac].xcce902d,g_xccd2_d[l_ac].xcce902e,g_xccd2_d[l_ac].xcce902f,g_xccd2_d[l_ac].xcce902g, 
#                      g_xccd2_d[l_ac].xcce902h,g_xccd2_d[l_ac].xcce902
#                  IF SQLCA.sqlcode THEN
#                     INITIALIZE g_errparam TO NULL 
#                     LET g_errparam.extend = '' 
#                     LET g_errparam.code   = SQLCA.sqlcode 
#                     LET g_errparam.popup  = TRUE 
#                     CALL cl_err()
#                     LET l_lock_sw = "Y"
#                  END IF
#                  
#                  LET g_bfill = "N"
#                  CALL axcq540_show()
#                  LET g_bfill = "Y"
#                  
#                  CALL cl_show_fld_cont()
#               END IF
#            ELSE
#               LET l_cmd='a'
#            END IF
#            #add-point:modify段before row

#            #end add-point  
#            #其他table資料備份(確定是否更改用)
#            LET g_detail_multi_table_t.xcbbcomp = g_xccd_m.xccdld
#LET g_detail_multi_table_t.xcbb001 = g_xccd_m.xccd001
#LET g_detail_multi_table_t.xcbb002 = g_xccd_m.xccd003
#LET g_detail_multi_table_t.xcbb003 = g_xccd_m.xccd004
#LET g_detail_multi_table_t.xcbb004 = g_xccd_m.xccd005
#LET g_detail_multi_table_t.xcbb005 = g_xccd3_d[l_ac].xcci002
# 
#            #其他table進行lock
#            
#            
#         BEFORE DELETE                            #是否取消單身
#            IF l_cmd = 'a' THEN
#               LET l_cmd='d'
#            ELSE
#               IF NOT cl_ask_del_detail() THEN
#                  CANCEL DELETE
#               END IF
#               IF l_lock_sw = "Y" THEN
#                  INITIALIZE g_errparam TO NULL 
#                  LET g_errparam.extend = "" 
#                  LET g_errparam.code   = -263 
#                  LET g_errparam.popup  = TRUE 
#                  CALL cl_err()
#                  CANCEL DELETE
#               END IF
#               
#               #add-point:單身2刪除前

#               #end add-point    
#               
#               DELETE FROM xcce_t
#                WHERE xcceent = g_enterprise AND xcceld = g_xccd_m.xccdld AND
#                                          xcce001 = g_xccd_m.xccd001 AND
#                                          xcce003 = g_xccd_m.xccd003 AND
#                                          xcce004 = g_xccd_m.xccd004 AND
#                                          xcce005 = g_xccd_m.xccd005 AND
#                      xcce002 = g_xccd2_d_t.xcce002
#                  AND xcce006 = g_xccd2_d_t.xcce006
#                  AND xcce007 = g_xccd2_d_t.xcce007
#                  AND xcce008 = g_xccd2_d_t.xcce008
#                  AND xcce009 = g_xccd2_d_t.xcce009
#                  
#               #add-point:單身2刪除中

#               #end add-point    
#                  
#               IF SQLCA.sqlcode THEN
#                  INITIALIZE g_errparam TO NULL 
#                  LET g_errparam.extend = "xccd_t" 
#                  LET g_errparam.code   = SQLCA.sqlcode 
#                  LET g_errparam.popup  = TRUE 
#                  CALL cl_err()
#                  CALL s_transaction_end('N','0')
#                  CANCEL DELETE   
#               ELSE
#                  LET g_rec_b = g_rec_b-1
#                  INITIALIZE l_var_keys_bak TO NULL 
#                  INITIALIZE l_field_keys TO NULL 
#                  LET l_field_keys[01] = 'xcbbcomp'
#                  LET l_field_keys[02] = 'xcbb001'
#                  LET l_field_keys[03] = 'xcbb002'
#                  LET l_field_keys[04] = 'xcbb003'
#                  LET l_field_keys[05] = 'xcbb004'
#                  LET l_var_keys_bak[01] = g_detail_multi_table_t.xcbbcomp
#                  LET l_var_keys_bak[02] = g_detail_multi_table_t.xcbb001
#                  LET l_var_keys_bak[03] = g_detail_multi_table_t.xcbb002
#                  LET l_var_keys_bak[04] = g_detail_multi_table_t.xcbb003
#                  LET l_var_keys_bak[05] = g_detail_multi_table_t.xcbb004
#                  CALL cl_multitable_delete(l_field_keys,l_var_keys_bak,'xcbb_t')
# 
#                  #add-point:單身2刪除後

#                  #end add-point
#                  CALL s_transaction_end('Y','0')
#               END IF 
#               CLOSE axcq540_bcl
#               LET l_count = g_xccd_d.getLength()
#                              INITIALIZE gs_keys TO NULL 
#               LET gs_keys[1] = g_xccd_m.xccdld
#               LET gs_keys[2] = g_xccd_m.xccd001
#               LET gs_keys[3] = g_xccd_m.xccd003
#               LET gs_keys[4] = g_xccd_m.xccd004
#               LET gs_keys[5] = g_xccd_m.xccd005
#               LET gs_keys[6] = g_xccd2_d[g_detail_idx].xcce002
#               LET gs_keys[7] = g_xccd2_d[g_detail_idx].xcce006
#               LET gs_keys[8] = g_xccd2_d[g_detail_idx].xcce007
#               LET gs_keys[9] = g_xccd2_d[g_detail_idx].xcce008
#               LET gs_keys[10] = g_xccd2_d[g_detail_idx].xcce009
# 
#            END IF 
#            
#         AFTER DELETE 
#            IF l_cmd <> 'd' THEN
#               #add-point:單身AFTER DELETE 

#               #end add-point
#                              CALL axcq540_delete_b('xcce_t',gs_keys,"'2'")
#            END IF
#            #如果是最後一筆
#            IF l_ac = (g_xccd2_d.getLength() + 1) THEN
#               CALL FGL_SET_ARR_CURR(l_ac-1)
#            END IF
# 
#         AFTER INSERT    
#            LET l_insert = FALSE
#            IF INT_FLAG THEN
#               INITIALIZE g_errparam TO NULL 
#               LET g_errparam.extend = '' 
#               LET g_errparam.code   = 9001 
#               LET g_errparam.popup  = FALSE 
#               CALL cl_err()
#               LET INT_FLAG = 0
#               CANCEL INSERT
#            END IF
#               
#            #add-point:單身2新增前

#            #end add-point
#               
#            LET l_count = 1  
#            SELECT COUNT(*) INTO l_count FROM xcce_t 
#             WHERE xcceent = g_enterprise AND xcceld = g_xccd_m.xccdld
#               AND xcce001 = g_xccd_m.xccd001
#               AND xcce003 = g_xccd_m.xccd003
#               AND xcce004 = g_xccd_m.xccd004
#               AND xcce005 = g_xccd_m.xccd005
#               AND xcce002 = g_xccd2_d[l_ac].xcce002
#               AND xcce006 = g_xccd2_d[l_ac].xcce006
#               AND xcce007 = g_xccd2_d[l_ac].xcce007
#               AND xcce008 = g_xccd2_d[l_ac].xcce008
#               AND xcce009 = g_xccd2_d[l_ac].xcce009
#                
#            #資料未重複, 插入新增資料
#            IF l_count = 0 THEN 
#               #add-point:單身2新增前

#               #end add-point
#            
#                              INITIALIZE gs_keys TO NULL 
#               LET gs_keys[1] = g_xccd_m.xccdld
#               LET gs_keys[2] = g_xccd_m.xccd001
#               LET gs_keys[3] = g_xccd_m.xccd003
#               LET gs_keys[4] = g_xccd_m.xccd004
#               LET gs_keys[5] = g_xccd_m.xccd005
#               LET gs_keys[6] = g_xccd2_d[g_detail_idx].xcce002
#               LET gs_keys[7] = g_xccd2_d[g_detail_idx].xcce006
#               LET gs_keys[8] = g_xccd2_d[g_detail_idx].xcce007
#               LET gs_keys[9] = g_xccd2_d[g_detail_idx].xcce008
#               LET gs_keys[10] = g_xccd2_d[g_detail_idx].xcce009
#               CALL axcq540_insert_b('xcce_t',gs_keys,"'2'")
#                           
#               #add-point:單身新增後2

#               #end add-point
#            ELSE    
#               INITIALIZE g_errparam TO NULL 
#               LET g_errparam.extend = 'INSERT' 
#               LET g_errparam.code   = "std-00006" 
#               LET g_errparam.popup  = TRUE 
#               CALL cl_err()
#               INITIALIZE g_xccd_d[l_ac].* TO NULL
#               CALL s_transaction_end('N','0')
#               CANCEL INSERT
#            END IF
# 
#            IF SQLCA.SQLcode  THEN
#               INITIALIZE g_errparam TO NULL 
#               LET g_errparam.extend = "xcce_t" 
#               LET g_errparam.code   = SQLCA.sqlcode 
#               LET g_errparam.popup  = TRUE 
#               CALL cl_err()
#               CALL s_transaction_end('N','0')                    
#               CANCEL INSERT
#            ELSE
#               #先刷新資料
#               #CALL axcq540_b_fill()
#               #資料多語言用-增/改
#               
#               #add-point:單身新增後

#               #end add-point
#               CALL s_transaction_end('Y','0')
#               ERROR 'INSERT O.K'
#               LET g_rec_b = g_rec_b + 1
#            END IF
#            
#         ON ROW CHANGE 
#            IF INT_FLAG THEN
#               INITIALIZE g_errparam TO NULL 
#               LET g_errparam.extend = '' 
#               LET g_errparam.code   = 9001 
#               LET g_errparam.popup  = FALSE 
#               CALL cl_err()
#               LET INT_FLAG = 0
#               LET g_xccd2_d[l_ac].* = g_xccd2_d_t.*
#               CLOSE axcq540_bcl2
#               CALL s_transaction_end('N','0')
#               EXIT DIALOG 
#            END IF
#            
#            IF l_lock_sw = 'Y' THEN
#               INITIALIZE g_errparam TO NULL 
#               LET g_errparam.extend = '' 
#               LET g_errparam.code   = -263 
#               LET g_errparam.popup  = TRUE 
#               CALL cl_err()
#               LET g_xccd2_d[l_ac].* = g_xccd2_d_t.*
#            ELSE
#               #add-point:單身page2修改前

#               #end add-point
#               
#               #寫入修改者/修改日期資訊(單身2)
#               
#               
#               UPDATE xcce_t SET (xcceld,xcce001,xcce003,xcce004,xcce005,xcce006,xcce007,xcce008,xcce009, 
#                   xcce002,xcce101,xcce102a,xcce102b,xcce102c,xcce102d,xcce102e,xcce102f,xcce102g,xcce102h, 
#                   xcce201,xcce202a,xcce202b,xcce202c,xcce202d,xcce202e,xcce202f,xcce202g,xcce202h,xcce301, 
#                   xcce302a,xcce302b,xcce302c,xcce302d,xcce302e,xcce302f,xcce302g,xcce302h,xcce303,xcce304a, 
#                   xcce304b,xcce304c,xcce304d,xcce304e,xcce304f,xcce304g,xcce304h,xcce307,xcce308a,xcce308b, 
#                   xcce308c,xcce308d,xcce308e,xcce308f,xcce308g,xcce308h,xcce901,xcce902a,xcce902b,xcce902c, 
#                   xcce902d,xcce902e,xcce902f,xcce902g,xcce902h) = (g_xccd_m.xccdld,g_xccd_m.xccd001, 
#                   g_xccd_m.xccd003,g_xccd_m.xccd004,g_xccd_m.xccd005,g_xccd2_d[l_ac].xcce006,g_xccd2_d[l_ac].xcce007, 
#                   g_xccd2_d[l_ac].xcce008,g_xccd2_d[l_ac].xcce009,g_xccd2_d[l_ac].xcce002,g_xccd2_d[l_ac].xcce101, 
#                   g_xccd2_d[l_ac].xcce102a,g_xccd2_d[l_ac].xcce102b,g_xccd2_d[l_ac].xcce102c,g_xccd2_d[l_ac].xcce102d, 
#                   g_xccd2_d[l_ac].xcce102e,g_xccd2_d[l_ac].xcce102f,g_xccd2_d[l_ac].xcce102g,g_xccd2_d[l_ac].xcce102h, 
#                   g_xccd2_d[l_ac].xcce201,g_xccd2_d[l_ac].xcce202a,g_xccd2_d[l_ac].xcce202b,g_xccd2_d[l_ac].xcce202c, 
#                   g_xccd2_d[l_ac].xcce202d,g_xccd2_d[l_ac].xcce202e,g_xccd2_d[l_ac].xcce202f,g_xccd2_d[l_ac].xcce202g, 
#                   g_xccd2_d[l_ac].xcce202h,g_xccd2_d[l_ac].xcce301,g_xccd2_d[l_ac].xcce302a,g_xccd2_d[l_ac].xcce302b, 
#                   g_xccd2_d[l_ac].xcce302c,g_xccd2_d[l_ac].xcce302d,g_xccd2_d[l_ac].xcce302e,g_xccd2_d[l_ac].xcce302f, 
#                   g_xccd2_d[l_ac].xcce302g,g_xccd2_d[l_ac].xcce302h,g_xccd2_d[l_ac].xcce303,g_xccd2_d[l_ac].xcce304a, 
#                   g_xccd2_d[l_ac].xcce304b,g_xccd2_d[l_ac].xcce304c,g_xccd2_d[l_ac].xcce304d,g_xccd2_d[l_ac].xcce304e, 
#                   g_xccd2_d[l_ac].xcce304f,g_xccd2_d[l_ac].xcce304g,g_xccd2_d[l_ac].xcce304h,g_xccd2_d[l_ac].xcce307, 
#                   g_xccd2_d[l_ac].xcce308a,g_xccd2_d[l_ac].xcce308b,g_xccd2_d[l_ac].xcce308c,g_xccd2_d[l_ac].xcce308d, 
#                   g_xccd2_d[l_ac].xcce308e,g_xccd2_d[l_ac].xcce308f,g_xccd2_d[l_ac].xcce308g,g_xccd2_d[l_ac].xcce308h, 
#                   g_xccd2_d[l_ac].xcce901,g_xccd2_d[l_ac].xcce902a,g_xccd2_d[l_ac].xcce902b,g_xccd2_d[l_ac].xcce902c, 
#                   g_xccd2_d[l_ac].xcce902d,g_xccd2_d[l_ac].xcce902e,g_xccd2_d[l_ac].xcce902f,g_xccd2_d[l_ac].xcce902g, 
#                   g_xccd2_d[l_ac].xcce902h) #自訂欄位頁簽
#                WHERE xcceent = g_enterprise AND xcceld = g_xccd_m.xccdld
#                  AND xcce001 = g_xccd_m.xccd001
#                  AND xcce003 = g_xccd_m.xccd003
#                  AND xcce004 = g_xccd_m.xccd004
#                  AND xcce005 = g_xccd_m.xccd005
#                  AND xcce002 = g_xccd2_d_t.xcce002 #項次 
#                  AND xcce006 = g_xccd2_d_t.xcce006
#                  AND xcce007 = g_xccd2_d_t.xcce007
#                  AND xcce008 = g_xccd2_d_t.xcce008
#                  AND xcce009 = g_xccd2_d_t.xcce009
#                  
#               #add-point:單身page2修改中

#               #end add-point
#                  
#               CASE
#                  WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
#                     INITIALIZE g_errparam TO NULL 
#                     LET g_errparam.extend = "xcce_t" 
#                     LET g_errparam.code   = "std-00009" 
#                     LET g_errparam.popup  = TRUE 
#                     CALL cl_err()
#                     CALL s_transaction_end('N','0')
#                     LET g_xccd2_d[l_ac].* = g_xccd2_d_t.*
#                  WHEN SQLCA.sqlcode #其他錯誤
#                     INITIALIZE g_errparam TO NULL 
#                     LET g_errparam.extend = "xcce_t" 
#                     LET g_errparam.code   = SQLCA.sqlcode 
#                     LET g_errparam.popup  = TRUE 
#                     CALL cl_err()
#                     CALL s_transaction_end('N','0')
#                     LET g_xccd2_d[l_ac].* = g_xccd2_d_t.*
#                  OTHERWISE
#                                    INITIALIZE gs_keys TO NULL 
#               LET gs_keys[1] = g_xccd_m.xccdld
#               LET gs_keys_bak[1] = g_xccdld_t
#               LET gs_keys[2] = g_xccd_m.xccd001
#               LET gs_keys_bak[2] = g_xccd001_t
#               LET gs_keys[3] = g_xccd_m.xccd003
#               LET gs_keys_bak[3] = g_xccd003_t
#               LET gs_keys[4] = g_xccd_m.xccd004
#               LET gs_keys_bak[4] = g_xccd004_t
#               LET gs_keys[5] = g_xccd_m.xccd005
#               LET gs_keys_bak[5] = g_xccd005_t
#               LET gs_keys[6] = g_xccd2_d[g_detail_idx].xcce002
#               LET gs_keys_bak[6] = g_xccd2_d_t.xcce002
#               LET gs_keys[7] = g_xccd2_d[g_detail_idx].xcce006
#               LET gs_keys_bak[7] = g_xccd2_d_t.xcce006
#               LET gs_keys[8] = g_xccd2_d[g_detail_idx].xcce007
#               LET gs_keys_bak[8] = g_xccd2_d_t.xcce007
#               LET gs_keys[9] = g_xccd2_d[g_detail_idx].xcce008
#               LET gs_keys_bak[9] = g_xccd2_d_t.xcce008
#               LET gs_keys[10] = g_xccd2_d[g_detail_idx].xcce009
#               LET gs_keys_bak[10] = g_xccd2_d_t.xcce009
#               CALL axcq540_update_b('xcce_t',gs_keys,gs_keys_bak,"'2'")
#                     #資料多語言用-增/改
#                     
#               END CASE
#               
#               #修改歷程記錄
#               LET g_log1 = util.JSON.stringify(g_xccd_m),util.JSON.stringify(g_xccd2_d_t)
#               LET g_log2 = util.JSON.stringify(g_xccd_m),util.JSON.stringify(g_xccd2_d[l_ac])
#               IF NOT cl_log_modified_record(g_log1,g_log2) THEN 
#                  CALL s_transaction_end('N','0')
#               END IF
#               
#               #add-point:單身page2修改後

#               #end add-point
#            END IF
#         
#                  #此段落由子樣板a01產生
#         BEFORE FIELD xcce102a
#            #add-point:BEFORE FIELD xcce102a

#            #END add-point
# 
#         #此段落由子樣板a02產生
#         AFTER FIELD xcce102a
#            
#            #add-point:AFTER FIELD xcce102a

#            #END add-point
#            
# 
#         #此段落由子樣板a04產生
#         ON CHANGE xcce102a
#            #add-point:ON CHANGE xcce102a

#            #END add-point
# 
#         #此段落由子樣板a01產生
#         BEFORE FIELD xcce102b
#            #add-point:BEFORE FIELD xcce102b

#            #END add-point
# 
#         #此段落由子樣板a02產生
#         AFTER FIELD xcce102b
#            
#            #add-point:AFTER FIELD xcce102b

#            #END add-point
#            
# 
#         #此段落由子樣板a04產生
#         ON CHANGE xcce102b
#            #add-point:ON CHANGE xcce102b

#            #END add-point
# 
#         #此段落由子樣板a01產生
#         BEFORE FIELD xcce102c
#            #add-point:BEFORE FIELD xcce102c

#            #END add-point
# 
#         #此段落由子樣板a02產生
#         AFTER FIELD xcce102c
#            
#            #add-point:AFTER FIELD xcce102c

#            #END add-point
#            
# 
#         #此段落由子樣板a04產生
#         ON CHANGE xcce102c
#            #add-point:ON CHANGE xcce102c

#            #END add-point
# 
#         #此段落由子樣板a01產生
#         BEFORE FIELD xcce102d
#            #add-point:BEFORE FIELD xcce102d

#            #END add-point
# 
#         #此段落由子樣板a02產生
#         AFTER FIELD xcce102d
#            
#            #add-point:AFTER FIELD xcce102d

#            #END add-point
#            
# 
#         #此段落由子樣板a04產生
#         ON CHANGE xcce102d
#            #add-point:ON CHANGE xcce102d

#            #END add-point
# 
#         #此段落由子樣板a01產生
#         BEFORE FIELD xcce102e
#            #add-point:BEFORE FIELD xcce102e

#            #END add-point
# 
#         #此段落由子樣板a02產生
#         AFTER FIELD xcce102e
#            
#            #add-point:AFTER FIELD xcce102e

#            #END add-point
#            
# 
#         #此段落由子樣板a04產生
#         ON CHANGE xcce102e
#            #add-point:ON CHANGE xcce102e

#            #END add-point
# 
#         #此段落由子樣板a01產生
#         BEFORE FIELD xcce102f
#            #add-point:BEFORE FIELD xcce102f

#            #END add-point
# 
#         #此段落由子樣板a02產生
#         AFTER FIELD xcce102f
#            
#            #add-point:AFTER FIELD xcce102f

#            #END add-point
#            
# 
#         #此段落由子樣板a04產生
#         ON CHANGE xcce102f
#            #add-point:ON CHANGE xcce102f

#            #END add-point
# 
#         #此段落由子樣板a01產生
#         BEFORE FIELD xcce102g
#            #add-point:BEFORE FIELD xcce102g

#            #END add-point
# 
#         #此段落由子樣板a02產生
#         AFTER FIELD xcce102g
#            
#            #add-point:AFTER FIELD xcce102g

#            #END add-point
#            
# 
#         #此段落由子樣板a04產生
#         ON CHANGE xcce102g
#            #add-point:ON CHANGE xcce102g

#            #END add-point
# 
#         #此段落由子樣板a01產生
#         BEFORE FIELD xcce102h
#            #add-point:BEFORE FIELD xcce102h

#            #END add-point
# 
#         #此段落由子樣板a02產生
#         AFTER FIELD xcce102h
#            
#            #add-point:AFTER FIELD xcce102h

#            #END add-point
#            
# 
#         #此段落由子樣板a04產生
#         ON CHANGE xcce102h
#            #add-point:ON CHANGE xcce102h

#            #END add-point
# 
#         #此段落由子樣板a01產生
#         BEFORE FIELD xcce102
#            #add-point:BEFORE FIELD xcce102

#            #END add-point
# 
#         #此段落由子樣板a02產生
#         AFTER FIELD xcce102
#            
#            #add-point:AFTER FIELD xcce102

#            #END add-point
#            
# 
#         #此段落由子樣板a04產生
#         ON CHANGE xcce102
#            #add-point:ON CHANGE xcce102

#            #END add-point
# 
#         #此段落由子樣板a01產生
#         BEFORE FIELD xcce201
#            #add-point:BEFORE FIELD xcce201

#            #END add-point
# 
#         #此段落由子樣板a02產生
#         AFTER FIELD xcce201
#            
#            #add-point:AFTER FIELD xcce201

#            #END add-point
#            
# 
#         #此段落由子樣板a04產生
#         ON CHANGE xcce201
#            #add-point:ON CHANGE xcce201

#            #END add-point
# 
#         #此段落由子樣板a01產生
#         BEFORE FIELD xcce202a
#            #add-point:BEFORE FIELD xcce202a

#            #END add-point
# 
#         #此段落由子樣板a02產生
#         AFTER FIELD xcce202a
#            
#            #add-point:AFTER FIELD xcce202a

#            #END add-point
#            
# 
#         #此段落由子樣板a04產生
#         ON CHANGE xcce202a
#            #add-point:ON CHANGE xcce202a

#            #END add-point
# 
#         #此段落由子樣板a01產生
#         BEFORE FIELD xcce202b
#            #add-point:BEFORE FIELD xcce202b

#            #END add-point
# 
#         #此段落由子樣板a02產生
#         AFTER FIELD xcce202b
#            
#            #add-point:AFTER FIELD xcce202b

#            #END add-point
#            
# 
#         #此段落由子樣板a04產生
#         ON CHANGE xcce202b
#            #add-point:ON CHANGE xcce202b

#            #END add-point
# 
#         #此段落由子樣板a01產生
#         BEFORE FIELD xcce202c
#            #add-point:BEFORE FIELD xcce202c

#            #END add-point
# 
#         #此段落由子樣板a02產生
#         AFTER FIELD xcce202c
#            
#            #add-point:AFTER FIELD xcce202c

#            #END add-point
#            
# 
#         #此段落由子樣板a04產生
#         ON CHANGE xcce202c
#            #add-point:ON CHANGE xcce202c

#            #END add-point
# 
#         #此段落由子樣板a01產生
#         BEFORE FIELD xcce202d
#            #add-point:BEFORE FIELD xcce202d

#            #END add-point
# 
#         #此段落由子樣板a02產生
#         AFTER FIELD xcce202d
#            
#            #add-point:AFTER FIELD xcce202d

#            #END add-point
#            
# 
#         #此段落由子樣板a04產生
#         ON CHANGE xcce202d
#            #add-point:ON CHANGE xcce202d

#            #END add-point
# 
#         #此段落由子樣板a01產生
#         BEFORE FIELD xcce202e
#            #add-point:BEFORE FIELD xcce202e

#            #END add-point
# 
#         #此段落由子樣板a02產生
#         AFTER FIELD xcce202e
#            
#            #add-point:AFTER FIELD xcce202e

#            #END add-point
#            
# 
#         #此段落由子樣板a04產生
#         ON CHANGE xcce202e
#            #add-point:ON CHANGE xcce202e

#            #END add-point
# 
#         #此段落由子樣板a01產生
#         BEFORE FIELD xcce202f
#            #add-point:BEFORE FIELD xcce202f

#            #END add-point
# 
#         #此段落由子樣板a02產生
#         AFTER FIELD xcce202f
#            
#            #add-point:AFTER FIELD xcce202f

#            #END add-point
#            
# 
#         #此段落由子樣板a04產生
#         ON CHANGE xcce202f
#            #add-point:ON CHANGE xcce202f

#            #END add-point
# 
#         #此段落由子樣板a01產生
#         BEFORE FIELD xcce202g
#            #add-point:BEFORE FIELD xcce202g

#            #END add-point
# 
#         #此段落由子樣板a02產生
#         AFTER FIELD xcce202g
#            
#            #add-point:AFTER FIELD xcce202g

#            #END add-point
#            
# 
#         #此段落由子樣板a04產生
#         ON CHANGE xcce202g
#            #add-point:ON CHANGE xcce202g

#            #END add-point
# 
#         #此段落由子樣板a01產生
#         BEFORE FIELD xcce202h
#            #add-point:BEFORE FIELD xcce202h

#            #END add-point
# 
#         #此段落由子樣板a02產生
#         AFTER FIELD xcce202h
#            
#            #add-point:AFTER FIELD xcce202h

#            #END add-point
#            
# 
#         #此段落由子樣板a04產生
#         ON CHANGE xcce202h
#            #add-point:ON CHANGE xcce202h

#            #END add-point
# 
#         #此段落由子樣板a01產生
#         BEFORE FIELD xcce202
#            #add-point:BEFORE FIELD xcce202

#            #END add-point
# 
#         #此段落由子樣板a02產生
#         AFTER FIELD xcce202
#            
#            #add-point:AFTER FIELD xcce202

#            #END add-point
#            
# 
#         #此段落由子樣板a04產生
#         ON CHANGE xcce202
#            #add-point:ON CHANGE xcce202

#            #END add-point
# 
#         #此段落由子樣板a01產生
#         BEFORE FIELD xcce301
#            #add-point:BEFORE FIELD xcce301

#            #END add-point
# 
#         #此段落由子樣板a02產生
#         AFTER FIELD xcce301
#            
#            #add-point:AFTER FIELD xcce301

#            #END add-point
#            
# 
#         #此段落由子樣板a04產生
#         ON CHANGE xcce301
#            #add-point:ON CHANGE xcce301

#            #END add-point
# 
#         #此段落由子樣板a01產生
#         BEFORE FIELD xcce302a
#            #add-point:BEFORE FIELD xcce302a

#            #END add-point
# 
#         #此段落由子樣板a02產生
#         AFTER FIELD xcce302a
#            
#            #add-point:AFTER FIELD xcce302a

#            #END add-point
#            
# 
#         #此段落由子樣板a04產生
#         ON CHANGE xcce302a
#            #add-point:ON CHANGE xcce302a

#            #END add-point
# 
#         #此段落由子樣板a01產生
#         BEFORE FIELD xcce302b
#            #add-point:BEFORE FIELD xcce302b

#            #END add-point
# 
#         #此段落由子樣板a02產生
#         AFTER FIELD xcce302b
#            
#            #add-point:AFTER FIELD xcce302b

#            #END add-point
#            
# 
#         #此段落由子樣板a04產生
#         ON CHANGE xcce302b
#            #add-point:ON CHANGE xcce302b

#            #END add-point
# 
#         #此段落由子樣板a01產生
#         BEFORE FIELD xcce302c
#            #add-point:BEFORE FIELD xcce302c

#            #END add-point
# 
#         #此段落由子樣板a02產生
#         AFTER FIELD xcce302c
#            
#            #add-point:AFTER FIELD xcce302c

#            #END add-point
#            
# 
#         #此段落由子樣板a04產生
#         ON CHANGE xcce302c
#            #add-point:ON CHANGE xcce302c

#            #END add-point
# 
#         #此段落由子樣板a01產生
#         BEFORE FIELD xcce302d
#            #add-point:BEFORE FIELD xcce302d

#            #END add-point
# 
#         #此段落由子樣板a02產生
#         AFTER FIELD xcce302d
#            
#            #add-point:AFTER FIELD xcce302d

#            #END add-point
#            
# 
#         #此段落由子樣板a04產生
#         ON CHANGE xcce302d
#            #add-point:ON CHANGE xcce302d

#            #END add-point
# 
#         #此段落由子樣板a01產生
#         BEFORE FIELD xcce302e
#            #add-point:BEFORE FIELD xcce302e

#            #END add-point
# 
#         #此段落由子樣板a02產生
#         AFTER FIELD xcce302e
#            
#            #add-point:AFTER FIELD xcce302e

#            #END add-point
#            
# 
#         #此段落由子樣板a04產生
#         ON CHANGE xcce302e
#            #add-point:ON CHANGE xcce302e

#            #END add-point
# 
#         #此段落由子樣板a01產生
#         BEFORE FIELD xcce302f
#            #add-point:BEFORE FIELD xcce302f

#            #END add-point
# 
#         #此段落由子樣板a02產生
#         AFTER FIELD xcce302f
#            
#            #add-point:AFTER FIELD xcce302f

#            #END add-point
#            
# 
#         #此段落由子樣板a04產生
#         ON CHANGE xcce302f
#            #add-point:ON CHANGE xcce302f

#            #END add-point
# 
#         #此段落由子樣板a01產生
#         BEFORE FIELD xcce302g
#            #add-point:BEFORE FIELD xcce302g

#            #END add-point
# 
#         #此段落由子樣板a02產生
#         AFTER FIELD xcce302g
#            
#            #add-point:AFTER FIELD xcce302g

#            #END add-point
#            
# 
#         #此段落由子樣板a04產生
#         ON CHANGE xcce302g
#            #add-point:ON CHANGE xcce302g

#            #END add-point
# 
#         #此段落由子樣板a01產生
#         BEFORE FIELD xcce302h
#            #add-point:BEFORE FIELD xcce302h

#            #END add-point
# 
#         #此段落由子樣板a02產生
#         AFTER FIELD xcce302h
#            
#            #add-point:AFTER FIELD xcce302h

#            #END add-point
#            
# 
#         #此段落由子樣板a04產生
#         ON CHANGE xcce302h
#            #add-point:ON CHANGE xcce302h

#            #END add-point
# 
#         #此段落由子樣板a01產生
#         BEFORE FIELD xcce302
#            #add-point:BEFORE FIELD xcce302

#            #END add-point
# 
#         #此段落由子樣板a02產生
#         AFTER FIELD xcce302
#            
#            #add-point:AFTER FIELD xcce302

#            #END add-point
#            
# 
#         #此段落由子樣板a04產生
#         ON CHANGE xcce302
#            #add-point:ON CHANGE xcce302

#            #END add-point
# 
#         #此段落由子樣板a01產生
#         BEFORE FIELD xcce303
#            #add-point:BEFORE FIELD xcce303

#            #END add-point
# 
#         #此段落由子樣板a02產生
#         AFTER FIELD xcce303
#            
#            #add-point:AFTER FIELD xcce303

#            #END add-point
#            
# 
#         #此段落由子樣板a04產生
#         ON CHANGE xcce303
#            #add-point:ON CHANGE xcce303

#            #END add-point
# 
#         #此段落由子樣板a01產生
#         BEFORE FIELD xcce304a
#            #add-point:BEFORE FIELD xcce304a

#            #END add-point
# 
#         #此段落由子樣板a02產生
#         AFTER FIELD xcce304a
#            
#            #add-point:AFTER FIELD xcce304a

#            #END add-point
#            
# 
#         #此段落由子樣板a04產生
#         ON CHANGE xcce304a
#            #add-point:ON CHANGE xcce304a

#            #END add-point
# 
#         #此段落由子樣板a01產生
#         BEFORE FIELD xcce304b
#            #add-point:BEFORE FIELD xcce304b

#            #END add-point
# 
#         #此段落由子樣板a02產生
#         AFTER FIELD xcce304b
#            
#            #add-point:AFTER FIELD xcce304b

#            #END add-point
#            
# 
#         #此段落由子樣板a04產生
#         ON CHANGE xcce304b
#            #add-point:ON CHANGE xcce304b

#            #END add-point
# 
#         #此段落由子樣板a01產生
#         BEFORE FIELD xcce304c
#            #add-point:BEFORE FIELD xcce304c

#            #END add-point
# 
#         #此段落由子樣板a02產生
#         AFTER FIELD xcce304c
#            
#            #add-point:AFTER FIELD xcce304c

#            #END add-point
#            
# 
#         #此段落由子樣板a04產生
#         ON CHANGE xcce304c
#            #add-point:ON CHANGE xcce304c

#            #END add-point
# 
#         #此段落由子樣板a01產生
#         BEFORE FIELD xcce304d
#            #add-point:BEFORE FIELD xcce304d

#            #END add-point
# 
#         #此段落由子樣板a02產生
#         AFTER FIELD xcce304d
#            
#            #add-point:AFTER FIELD xcce304d

#            #END add-point
#            
# 
#         #此段落由子樣板a04產生
#         ON CHANGE xcce304d
#            #add-point:ON CHANGE xcce304d

#            #END add-point
# 
#         #此段落由子樣板a01產生
#         BEFORE FIELD xcce304e
#            #add-point:BEFORE FIELD xcce304e

#            #END add-point
# 
#         #此段落由子樣板a02產生
#         AFTER FIELD xcce304e
#            
#            #add-point:AFTER FIELD xcce304e

#            #END add-point
#            
# 
#         #此段落由子樣板a04產生
#         ON CHANGE xcce304e
#            #add-point:ON CHANGE xcce304e

#            #END add-point
# 
#         #此段落由子樣板a01產生
#         BEFORE FIELD xcce304f
#            #add-point:BEFORE FIELD xcce304f

#            #END add-point
# 
#         #此段落由子樣板a02產生
#         AFTER FIELD xcce304f
#            
#            #add-point:AFTER FIELD xcce304f

#            #END add-point
#            
# 
#         #此段落由子樣板a04產生
#         ON CHANGE xcce304f
#            #add-point:ON CHANGE xcce304f

#            #END add-point
# 
#         #此段落由子樣板a01產生
#         BEFORE FIELD xcce304g
#            #add-point:BEFORE FIELD xcce304g

#            #END add-point
# 
#         #此段落由子樣板a02產生
#         AFTER FIELD xcce304g
#            
#            #add-point:AFTER FIELD xcce304g

#            #END add-point
#            
# 
#         #此段落由子樣板a04產生
#         ON CHANGE xcce304g
#            #add-point:ON CHANGE xcce304g

#            #END add-point
# 
#         #此段落由子樣板a01產生
#         BEFORE FIELD xcce304h
#            #add-point:BEFORE FIELD xcce304h

#            #END add-point
# 
#         #此段落由子樣板a02產生
#         AFTER FIELD xcce304h
#            
#            #add-point:AFTER FIELD xcce304h

#            #END add-point
#            
# 
#         #此段落由子樣板a04產生
#         ON CHANGE xcce304h
#            #add-point:ON CHANGE xcce304h

#            #END add-point
# 
#         #此段落由子樣板a01產生
#         BEFORE FIELD xcce304
#            #add-point:BEFORE FIELD xcce304

#            #END add-point
# 
#         #此段落由子樣板a02產生
#         AFTER FIELD xcce304
#            
#            #add-point:AFTER FIELD xcce304

#            #END add-point
#            
# 
#         #此段落由子樣板a04產生
#         ON CHANGE xcce304
#            #add-point:ON CHANGE xcce304

#            #END add-point
# 
#         #此段落由子樣板a01產生
#         BEFORE FIELD xcce307
#            #add-point:BEFORE FIELD xcce307

#            #END add-point
# 
#         #此段落由子樣板a02產生
#         AFTER FIELD xcce307
#            
#            #add-point:AFTER FIELD xcce307

#            #END add-point
#            
# 
#         #此段落由子樣板a04產生
#         ON CHANGE xcce307
#            #add-point:ON CHANGE xcce307

#            #END add-point
# 
#         #此段落由子樣板a01產生
#         BEFORE FIELD xcce308a
#            #add-point:BEFORE FIELD xcce308a

#            #END add-point
# 
#         #此段落由子樣板a02產生
#         AFTER FIELD xcce308a
#            
#            #add-point:AFTER FIELD xcce308a

#            #END add-point
#            
# 
#         #此段落由子樣板a04產生
#         ON CHANGE xcce308a
#            #add-point:ON CHANGE xcce308a

#            #END add-point
# 
#         #此段落由子樣板a01產生
#         BEFORE FIELD xcce308b
#            #add-point:BEFORE FIELD xcce308b

#            #END add-point
# 
#         #此段落由子樣板a02產生
#         AFTER FIELD xcce308b
#            
#            #add-point:AFTER FIELD xcce308b

#            #END add-point
#            
# 
#         #此段落由子樣板a04產生
#         ON CHANGE xcce308b
#            #add-point:ON CHANGE xcce308b

#            #END add-point
# 
#         #此段落由子樣板a01產生
#         BEFORE FIELD xcce308c
#            #add-point:BEFORE FIELD xcce308c

#            #END add-point
# 
#         #此段落由子樣板a02產生
#         AFTER FIELD xcce308c
#            
#            #add-point:AFTER FIELD xcce308c

#            #END add-point
#            
# 
#         #此段落由子樣板a04產生
#         ON CHANGE xcce308c
#            #add-point:ON CHANGE xcce308c

#            #END add-point
# 
#         #此段落由子樣板a01產生
#         BEFORE FIELD xcce308d
#            #add-point:BEFORE FIELD xcce308d

#            #END add-point
# 
#         #此段落由子樣板a02產生
#         AFTER FIELD xcce308d
#            
#            #add-point:AFTER FIELD xcce308d

#            #END add-point
#            
# 
#         #此段落由子樣板a04產生
#         ON CHANGE xcce308d
#            #add-point:ON CHANGE xcce308d

#            #END add-point
# 
#         #此段落由子樣板a01產生
#         BEFORE FIELD xcce308e
#            #add-point:BEFORE FIELD xcce308e

#            #END add-point
# 
#         #此段落由子樣板a02產生
#         AFTER FIELD xcce308e
#            
#            #add-point:AFTER FIELD xcce308e

#            #END add-point
#            
# 
#         #此段落由子樣板a04產生
#         ON CHANGE xcce308e
#            #add-point:ON CHANGE xcce308e

#            #END add-point
# 
#         #此段落由子樣板a01產生
#         BEFORE FIELD xcce308f
#            #add-point:BEFORE FIELD xcce308f

#            #END add-point
# 
#         #此段落由子樣板a02產生
#         AFTER FIELD xcce308f
#            
#            #add-point:AFTER FIELD xcce308f

#            #END add-point
#            
# 
#         #此段落由子樣板a04產生
#         ON CHANGE xcce308f
#            #add-point:ON CHANGE xcce308f

#            #END add-point
# 
#         #此段落由子樣板a01產生
#         BEFORE FIELD xcce308g
#            #add-point:BEFORE FIELD xcce308g

#            #END add-point
# 
#         #此段落由子樣板a02產生
#         AFTER FIELD xcce308g
#            
#            #add-point:AFTER FIELD xcce308g

#            #END add-point
#            
# 
#         #此段落由子樣板a04產生
#         ON CHANGE xcce308g
#            #add-point:ON CHANGE xcce308g

#            #END add-point
# 
#         #此段落由子樣板a01產生
#         BEFORE FIELD xcce308h
#            #add-point:BEFORE FIELD xcce308h

#            #END add-point
# 
#         #此段落由子樣板a02產生
#         AFTER FIELD xcce308h
#            
#            #add-point:AFTER FIELD xcce308h

#            #END add-point
#            
# 
#         #此段落由子樣板a04產生
#         ON CHANGE xcce308h
#            #add-point:ON CHANGE xcce308h

#            #END add-point
# 
#         #此段落由子樣板a01產生
#         BEFORE FIELD xcce308
#            #add-point:BEFORE FIELD xcce308

#            #END add-point
# 
#         #此段落由子樣板a02產生
#         AFTER FIELD xcce308
#            
#            #add-point:AFTER FIELD xcce308

#            #END add-point
#            
# 
#         #此段落由子樣板a04產生
#         ON CHANGE xcce308
#            #add-point:ON CHANGE xcce308

#            #END add-point
# 
#         #此段落由子樣板a01產生
#         BEFORE FIELD xcce901
#            #add-point:BEFORE FIELD xcce901

#            #END add-point
# 
#         #此段落由子樣板a02產生
#         AFTER FIELD xcce901
#            
#            #add-point:AFTER FIELD xcce901

#            #END add-point
#            
# 
#         #此段落由子樣板a04產生
#         ON CHANGE xcce901
#            #add-point:ON CHANGE xcce901

#            #END add-point
# 
#         #此段落由子樣板a01產生
#         BEFORE FIELD xcce902a
#            #add-point:BEFORE FIELD xcce902a

#            #END add-point
# 
#         #此段落由子樣板a02產生
#         AFTER FIELD xcce902a
#            
#            #add-point:AFTER FIELD xcce902a

#            #END add-point
#            
# 
#         #此段落由子樣板a04產生
#         ON CHANGE xcce902a
#            #add-point:ON CHANGE xcce902a

#            #END add-point
# 
#         #此段落由子樣板a01產生
#         BEFORE FIELD xcce902b
#            #add-point:BEFORE FIELD xcce902b

#            #END add-point
# 
#         #此段落由子樣板a02產生
#         AFTER FIELD xcce902b
#            
#            #add-point:AFTER FIELD xcce902b

#            #END add-point
#            
# 
#         #此段落由子樣板a04產生
#         ON CHANGE xcce902b
#            #add-point:ON CHANGE xcce902b

#            #END add-point
# 
#         #此段落由子樣板a01產生
#         BEFORE FIELD xcce902c
#            #add-point:BEFORE FIELD xcce902c

#            #END add-point
# 
#         #此段落由子樣板a02產生
#         AFTER FIELD xcce902c
#            
#            #add-point:AFTER FIELD xcce902c

#            #END add-point
#            
# 
#         #此段落由子樣板a04產生
#         ON CHANGE xcce902c
#            #add-point:ON CHANGE xcce902c

#            #END add-point
# 
#         #此段落由子樣板a01產生
#         BEFORE FIELD xcce902d
#            #add-point:BEFORE FIELD xcce902d

#            #END add-point
# 
#         #此段落由子樣板a02產生
#         AFTER FIELD xcce902d
#            
#            #add-point:AFTER FIELD xcce902d

#            #END add-point
#            
# 
#         #此段落由子樣板a04產生
#         ON CHANGE xcce902d
#            #add-point:ON CHANGE xcce902d

#            #END add-point
# 
#         #此段落由子樣板a01產生
#         BEFORE FIELD xcce902e
#            #add-point:BEFORE FIELD xcce902e

#            #END add-point
# 
#         #此段落由子樣板a02產生
#         AFTER FIELD xcce902e
#            
#            #add-point:AFTER FIELD xcce902e

#            #END add-point
#            
# 
#         #此段落由子樣板a04產生
#         ON CHANGE xcce902e
#            #add-point:ON CHANGE xcce902e

#            #END add-point
# 
#         #此段落由子樣板a01產生
#         BEFORE FIELD xcce902f
#            #add-point:BEFORE FIELD xcce902f

#            #END add-point
# 
#         #此段落由子樣板a02產生
#         AFTER FIELD xcce902f
#            
#            #add-point:AFTER FIELD xcce902f

#            #END add-point
#            
# 
#         #此段落由子樣板a04產生
#         ON CHANGE xcce902f
#            #add-point:ON CHANGE xcce902f

#            #END add-point
# 
#         #此段落由子樣板a01產生
#         BEFORE FIELD xcce902g
#            #add-point:BEFORE FIELD xcce902g

#            #END add-point
# 
#         #此段落由子樣板a02產生
#         AFTER FIELD xcce902g
#            
#            #add-point:AFTER FIELD xcce902g

#            #END add-point
#            
# 
#         #此段落由子樣板a04產生
#         ON CHANGE xcce902g
#            #add-point:ON CHANGE xcce902g

#            #END add-point
# 
#         #此段落由子樣板a01產生
#         BEFORE FIELD xcce902h
#            #add-point:BEFORE FIELD xcce902h

#            #END add-point
# 
#         #此段落由子樣板a02產生
#         AFTER FIELD xcce902h
#            
#            #add-point:AFTER FIELD xcce902h

#            #END add-point
#            
# 
#         #此段落由子樣板a04產生
#         ON CHANGE xcce902h
#            #add-point:ON CHANGE xcce902h

#            #END add-point
# 
#         #此段落由子樣板a01產生
#         BEFORE FIELD xcce902
#            #add-point:BEFORE FIELD xcce902

#            #END add-point
# 
#         #此段落由子樣板a02產生
#         AFTER FIELD xcce902
#            
#            #add-point:AFTER FIELD xcce902

#            #END add-point
#            
# 
#         #此段落由子樣板a04產生
#         ON CHANGE xcce902
#            #add-point:ON CHANGE xcce902

#            #END add-point
# 
# 
#                  #Ctrlp:input.c.page2.xcce102a
#         ON ACTION controlp INFIELD xcce102a
#            #add-point:ON ACTION controlp INFIELD xcce102a

#            #END add-point
# 
#         #Ctrlp:input.c.page2.xcce102b
#         ON ACTION controlp INFIELD xcce102b
#            #add-point:ON ACTION controlp INFIELD xcce102b

#            #END add-point
# 
#         #Ctrlp:input.c.page2.xcce102c
#         ON ACTION controlp INFIELD xcce102c
#            #add-point:ON ACTION controlp INFIELD xcce102c

#            #END add-point
# 
#         #Ctrlp:input.c.page2.xcce102d
#         ON ACTION controlp INFIELD xcce102d
#            #add-point:ON ACTION controlp INFIELD xcce102d

#            #END add-point
# 
#         #Ctrlp:input.c.page2.xcce102e
#         ON ACTION controlp INFIELD xcce102e
#            #add-point:ON ACTION controlp INFIELD xcce102e

#            #END add-point
# 
#         #Ctrlp:input.c.page2.xcce102f
#         ON ACTION controlp INFIELD xcce102f
#            #add-point:ON ACTION controlp INFIELD xcce102f

#            #END add-point
# 
#         #Ctrlp:input.c.page2.xcce102g
#         ON ACTION controlp INFIELD xcce102g
#            #add-point:ON ACTION controlp INFIELD xcce102g

#            #END add-point
# 
#         #Ctrlp:input.c.page2.xcce102h
#         ON ACTION controlp INFIELD xcce102h
#            #add-point:ON ACTION controlp INFIELD xcce102h

#            #END add-point
# 
#         #Ctrlp:input.c.page2.xcce102
#         ON ACTION controlp INFIELD xcce102
#            #add-point:ON ACTION controlp INFIELD xcce102

#            #END add-point
# 
#         #Ctrlp:input.c.page2.xcce201
#         ON ACTION controlp INFIELD xcce201
#            #add-point:ON ACTION controlp INFIELD xcce201

#            #END add-point
# 
#         #Ctrlp:input.c.page2.xcce202a
#         ON ACTION controlp INFIELD xcce202a
#            #add-point:ON ACTION controlp INFIELD xcce202a

#            #END add-point
# 
#         #Ctrlp:input.c.page2.xcce202b
#         ON ACTION controlp INFIELD xcce202b
#            #add-point:ON ACTION controlp INFIELD xcce202b

#            #END add-point
# 
#         #Ctrlp:input.c.page2.xcce202c
#         ON ACTION controlp INFIELD xcce202c
#            #add-point:ON ACTION controlp INFIELD xcce202c

#            #END add-point
# 
#         #Ctrlp:input.c.page2.xcce202d
#         ON ACTION controlp INFIELD xcce202d
#            #add-point:ON ACTION controlp INFIELD xcce202d

#            #END add-point
# 
#         #Ctrlp:input.c.page2.xcce202e
#         ON ACTION controlp INFIELD xcce202e
#            #add-point:ON ACTION controlp INFIELD xcce202e

#            #END add-point
# 
#         #Ctrlp:input.c.page2.xcce202f
#         ON ACTION controlp INFIELD xcce202f
#            #add-point:ON ACTION controlp INFIELD xcce202f

#            #END add-point
# 
#         #Ctrlp:input.c.page2.xcce202g
#         ON ACTION controlp INFIELD xcce202g
#            #add-point:ON ACTION controlp INFIELD xcce202g

#            #END add-point
# 
#         #Ctrlp:input.c.page2.xcce202h
#         ON ACTION controlp INFIELD xcce202h
#            #add-point:ON ACTION controlp INFIELD xcce202h

#            #END add-point
# 
#         #Ctrlp:input.c.page2.xcce202
#         ON ACTION controlp INFIELD xcce202
#            #add-point:ON ACTION controlp INFIELD xcce202

#            #END add-point
# 
#         #Ctrlp:input.c.page2.xcce301
#         ON ACTION controlp INFIELD xcce301
#            #add-point:ON ACTION controlp INFIELD xcce301

#            #END add-point
# 
#         #Ctrlp:input.c.page2.xcce302a
#         ON ACTION controlp INFIELD xcce302a
#            #add-point:ON ACTION controlp INFIELD xcce302a

#            #END add-point
# 
#         #Ctrlp:input.c.page2.xcce302b
#         ON ACTION controlp INFIELD xcce302b
#            #add-point:ON ACTION controlp INFIELD xcce302b

#            #END add-point
# 
#         #Ctrlp:input.c.page2.xcce302c
#         ON ACTION controlp INFIELD xcce302c
#            #add-point:ON ACTION controlp INFIELD xcce302c

#            #END add-point
# 
#         #Ctrlp:input.c.page2.xcce302d
#         ON ACTION controlp INFIELD xcce302d
#            #add-point:ON ACTION controlp INFIELD xcce302d

#            #END add-point
# 
#         #Ctrlp:input.c.page2.xcce302e
#         ON ACTION controlp INFIELD xcce302e
#            #add-point:ON ACTION controlp INFIELD xcce302e

#            #END add-point
# 
#         #Ctrlp:input.c.page2.xcce302f
#         ON ACTION controlp INFIELD xcce302f
#            #add-point:ON ACTION controlp INFIELD xcce302f

#            #END add-point
# 
#         #Ctrlp:input.c.page2.xcce302g
#         ON ACTION controlp INFIELD xcce302g
#            #add-point:ON ACTION controlp INFIELD xcce302g

#            #END add-point
# 
#         #Ctrlp:input.c.page2.xcce302h
#         ON ACTION controlp INFIELD xcce302h
#            #add-point:ON ACTION controlp INFIELD xcce302h

#            #END add-point
# 
#         #Ctrlp:input.c.page2.xcce302
#         ON ACTION controlp INFIELD xcce302
#            #add-point:ON ACTION controlp INFIELD xcce302

#            #END add-point
# 
#         #Ctrlp:input.c.page2.xcce303
#         ON ACTION controlp INFIELD xcce303
#            #add-point:ON ACTION controlp INFIELD xcce303

#            #END add-point
# 
#         #Ctrlp:input.c.page2.xcce304a
#         ON ACTION controlp INFIELD xcce304a
#            #add-point:ON ACTION controlp INFIELD xcce304a

#            #END add-point
# 
#         #Ctrlp:input.c.page2.xcce304b
#         ON ACTION controlp INFIELD xcce304b
#            #add-point:ON ACTION controlp INFIELD xcce304b

#            #END add-point
# 
#         #Ctrlp:input.c.page2.xcce304c
#         ON ACTION controlp INFIELD xcce304c
#            #add-point:ON ACTION controlp INFIELD xcce304c

#            #END add-point
# 
#         #Ctrlp:input.c.page2.xcce304d
#         ON ACTION controlp INFIELD xcce304d
#            #add-point:ON ACTION controlp INFIELD xcce304d

#            #END add-point
# 
#         #Ctrlp:input.c.page2.xcce304e
#         ON ACTION controlp INFIELD xcce304e
#            #add-point:ON ACTION controlp INFIELD xcce304e

#            #END add-point
# 
#         #Ctrlp:input.c.page2.xcce304f
#         ON ACTION controlp INFIELD xcce304f
#            #add-point:ON ACTION controlp INFIELD xcce304f

#            #END add-point
# 
#         #Ctrlp:input.c.page2.xcce304g
#         ON ACTION controlp INFIELD xcce304g
#            #add-point:ON ACTION controlp INFIELD xcce304g

#            #END add-point
# 
#         #Ctrlp:input.c.page2.xcce304h
#         ON ACTION controlp INFIELD xcce304h
#            #add-point:ON ACTION controlp INFIELD xcce304h

#            #END add-point
# 
#         #Ctrlp:input.c.page2.xcce304
#         ON ACTION controlp INFIELD xcce304
#            #add-point:ON ACTION controlp INFIELD xcce304

#            #END add-point
# 
#         #Ctrlp:input.c.page2.xcce307
#         ON ACTION controlp INFIELD xcce307
#            #add-point:ON ACTION controlp INFIELD xcce307

#            #END add-point
# 
#         #Ctrlp:input.c.page2.xcce308a
#         ON ACTION controlp INFIELD xcce308a
#            #add-point:ON ACTION controlp INFIELD xcce308a

#            #END add-point
# 
#         #Ctrlp:input.c.page2.xcce308b
#         ON ACTION controlp INFIELD xcce308b
#            #add-point:ON ACTION controlp INFIELD xcce308b

#            #END add-point
# 
#         #Ctrlp:input.c.page2.xcce308c
#         ON ACTION controlp INFIELD xcce308c
#            #add-point:ON ACTION controlp INFIELD xcce308c

#            #END add-point
# 
#         #Ctrlp:input.c.page2.xcce308d
#         ON ACTION controlp INFIELD xcce308d
#            #add-point:ON ACTION controlp INFIELD xcce308d

#            #END add-point
# 
#         #Ctrlp:input.c.page2.xcce308e
#         ON ACTION controlp INFIELD xcce308e
#            #add-point:ON ACTION controlp INFIELD xcce308e

#            #END add-point
# 
#         #Ctrlp:input.c.page2.xcce308f
#         ON ACTION controlp INFIELD xcce308f
#            #add-point:ON ACTION controlp INFIELD xcce308f

#            #END add-point
# 
#         #Ctrlp:input.c.page2.xcce308g
#         ON ACTION controlp INFIELD xcce308g
#            #add-point:ON ACTION controlp INFIELD xcce308g

#            #END add-point
# 
#         #Ctrlp:input.c.page2.xcce308h
#         ON ACTION controlp INFIELD xcce308h
#            #add-point:ON ACTION controlp INFIELD xcce308h

#            #END add-point
# 
#         #Ctrlp:input.c.page2.xcce308
#         ON ACTION controlp INFIELD xcce308
#            #add-point:ON ACTION controlp INFIELD xcce308

#            #END add-point
# 
#         #Ctrlp:input.c.page2.xcce901
#         ON ACTION controlp INFIELD xcce901
#            #add-point:ON ACTION controlp INFIELD xcce901

#            #END add-point
# 
#         #Ctrlp:input.c.page2.xcce902a
#         ON ACTION controlp INFIELD xcce902a
#            #add-point:ON ACTION controlp INFIELD xcce902a

#            #END add-point
# 
#         #Ctrlp:input.c.page2.xcce902b
#         ON ACTION controlp INFIELD xcce902b
#            #add-point:ON ACTION controlp INFIELD xcce902b

#            #END add-point
# 
#         #Ctrlp:input.c.page2.xcce902c
#         ON ACTION controlp INFIELD xcce902c
#            #add-point:ON ACTION controlp INFIELD xcce902c

#            #END add-point
# 
#         #Ctrlp:input.c.page2.xcce902d
#         ON ACTION controlp INFIELD xcce902d
#            #add-point:ON ACTION controlp INFIELD xcce902d

#            #END add-point
# 
#         #Ctrlp:input.c.page2.xcce902e
#         ON ACTION controlp INFIELD xcce902e
#            #add-point:ON ACTION controlp INFIELD xcce902e

#            #END add-point
# 
#         #Ctrlp:input.c.page2.xcce902f
#         ON ACTION controlp INFIELD xcce902f
#            #add-point:ON ACTION controlp INFIELD xcce902f

#            #END add-point
# 
#         #Ctrlp:input.c.page2.xcce902g
#         ON ACTION controlp INFIELD xcce902g
#            #add-point:ON ACTION controlp INFIELD xcce902g

#            #END add-point
# 
#         #Ctrlp:input.c.page2.xcce902h
#         ON ACTION controlp INFIELD xcce902h
#            #add-point:ON ACTION controlp INFIELD xcce902h

#            #END add-point
# 
#         #Ctrlp:input.c.page2.xcce902
#         ON ACTION controlp INFIELD xcce902
#            #add-point:ON ACTION controlp INFIELD xcce902

#            #END add-point
# 
# 
# 
#         AFTER ROW
#            #add-point:單身page2 after_row

#            #end add-point
#            LET l_ac = ARR_CURR()
#            IF INT_FLAG THEN
#               INITIALIZE g_errparam TO NULL 
#               LET g_errparam.extend = '' 
#               LET g_errparam.code   = 9001 
#               LET g_errparam.popup  = FALSE 
#               CALL cl_err()
#               LET INT_FLAG = 0
#               IF l_cmd = 'u' THEN
#                  LET g_xccd2_d[l_ac].* = g_xccd2_d_t.*
#               END IF
#               CLOSE axcq540_bcl2
#               CALL s_transaction_end('N','0')
#               EXIT DIALOG 
#            END IF
#            
#            #其他table進行unlock
#            
#            CALL axcq540_unlock_b("xcce_t","'2'")
#            CALL s_transaction_end('Y','0')
#            #add-point:單身page2 after_row2

#            #end add-point
# 
#         AFTER INPUT
#            #add-point:input段after input 

#            #end add-point   
#    
#         ON ACTION controlo
#            CALL FGL_SET_ARR_CURR(g_xccd2_d.getLength()+1)
#            LET lb_reproduce = TRUE
#            LET li_reproduce = l_ac
#            LET li_reproduce_target = g_xccd2_d.getLength()+1
# 
#      END INPUT
#      INPUT ARRAY g_xccd3_d FROM s_detail3.*
#         ATTRIBUTE(COUNT = g_rec_b,WITHOUT DEFAULTS, #MAXCOUNT = g_max_rec,
#                 INSERT ROW = l_allow_insert, #此頁面insert功能由產生器控制, 手動之設定無效! 
#
#                 DELETE ROW = l_allow_delete,
#                 APPEND ROW = l_allow_insert)
#                 
#         #自訂ACTION(detail_input,page_3)
#         
#         
#         BEFORE INPUT
#            #add-point:資料輸入前

#            #end add-point
#            IF g_insert = 'Y' AND NOT cl_null(g_insert) THEN 
#              CALL FGL_SET_ARR_CURR(g_xccd3_d.getLength()+1) 
#              LET g_insert = 'N' 
#           END IF 
# 
#            CALL axcq540_b_fill()
#            LET g_rec_b = g_xccd3_d.getLength()
#            #add-point:資料輸入前

#            #end add-point
#            
#         BEFORE INSERT
#            
#            LET l_insert = TRUE
#            LET l_n = ARR_COUNT()
#            LET l_cmd = 'a'
#            INITIALIZE g_xccd3_d[l_ac].* TO NULL 
#            INITIALIZE g_xccd3_d_t.* TO NULL 
#            INITIALIZE g_xccd3_d_o.* TO NULL 
#            #公用欄位給值(單身3)
#            
#            #自定義預設值(單身3)
#            
#            #add-point:modify段before備份

#            #end add-point
#            LET g_xccd3_d_t.* = g_xccd3_d[l_ac].*     #新輸入資料
#            LET g_xccd3_d_o.* = g_xccd3_d[l_ac].*     #新輸入資料
#            CALL cl_show_fld_cont()
#            CALL axcq540_set_entry_b(l_cmd)
#            #add-point:modify段after_set_entry_b

#            #end add-point
#            CALL axcq540_set_no_entry_b(l_cmd)
#            IF lb_reproduce THEN
#               LET lb_reproduce = FALSE
#               LET g_xccd3_d[li_reproduce_target].* = g_xccd3_d[li_reproduce].*
# 
#               LET g_xccd3_d[li_reproduce_target].xcci002 = NULL
#               LET g_xccd3_d[li_reproduce_target].xcci006 = NULL
#               LET g_xccd3_d[li_reproduce_target].xcci007 = NULL
#               LET g_xccd3_d[li_reproduce_target].xcci008 = NULL
#               LET g_xccd3_d[li_reproduce_target].xcci009 = NULL
#            END IF
#            LET g_detail_multi_table_t.xcbbcomp = g_xccd_m.xccdld
#LET g_detail_multi_table_t.xcbb001 = g_xccd_m.xccd001
#LET g_detail_multi_table_t.xcbb002 = g_xccd_m.xccd003
#LET g_detail_multi_table_t.xcbb003 = g_xccd_m.xccd004
#LET g_detail_multi_table_t.xcbb004 = g_xccd_m.xccd005
#LET g_detail_multi_table_t.xcbb005 = g_xccd3_d[l_ac].xcci002
# 
#            #add-point:modify段before insert

#            #end add-point  
#            
#         BEFORE ROW     
#            #add-point:modify段before row2

#            #end add-point  
#            LET l_insert = FALSE
#            LET l_cmd = ''
#            LET l_ac = ARR_CURR()
#            LET g_detail_idx = l_ac
#              
#            LET l_lock_sw = 'N'            #DEFAULT
#            LET l_n = ARR_COUNT()
#            DISPLAY l_ac TO FORMONLY.idx
#         
#            CALL s_transaction_begin()
#            OPEN axcq540_cl USING g_enterprise,g_xccd_m.xccdld,g_xccd_m.xccd001,g_xccd_m.xccd003,g_xccd_m.xccd004,g_xccd_m.xccd005
#            IF STATUS THEN
#               INITIALIZE g_errparam TO NULL 
#               LET g_errparam.extend = "OPEN axcq540_cl:" 
#               LET g_errparam.code   = STATUS 
#               LET g_errparam.popup  = TRUE 
#               CALL cl_err()
#               CLOSE axcq540_cl
#               CALL s_transaction_end('N','0')
#               RETURN
#            END IF
#            
#            LET g_rec_b = g_xccd3_d.getLength()
#            
#            IF g_rec_b >= l_ac 
#               AND g_xccd3_d[l_ac].xcci002 IS NOT NULL
#               AND g_xccd3_d[l_ac].xcci006 IS NOT NULL
#               AND g_xccd3_d[l_ac].xcci007 IS NOT NULL
#               AND g_xccd3_d[l_ac].xcci008 IS NOT NULL
#               AND g_xccd3_d[l_ac].xcci009 IS NOT NULL
#            THEN 
#               LET l_cmd='u'
#               LET g_xccd3_d_t.* = g_xccd3_d[l_ac].*  #BACKUP
#               LET g_xccd3_d_o.* = g_xccd3_d[l_ac].*  #BACKUP
#               CALL axcq540_set_entry_b(l_cmd)
#               #add-point:modify段after_set_entry_b

#               #end add-point  
#               CALL axcq540_set_no_entry_b(l_cmd)
#               IF NOT axcq540_lock_b("xcci_t","'3'") THEN
#                  LET l_lock_sw='Y'
#               ELSE
#                  FETCH axcq540_bcl3 INTO g_xccd3_d[l_ac].xcci006,g_xccd3_d[l_ac].xcci007,g_xccd3_d[l_ac].xcci008, 
#                      g_xccd3_d[l_ac].xcci009,g_xccd3_d[l_ac].xcci002,g_xccd3_d[l_ac].xcci101,g_xccd3_d[l_ac].xcci102a, 
#                      g_xccd3_d[l_ac].xcci102b,g_xccd3_d[l_ac].xcci102c,g_xccd3_d[l_ac].xcci102d,g_xccd3_d[l_ac].xcci102e, 
#                      g_xccd3_d[l_ac].xcci102f,g_xccd3_d[l_ac].xcci102g,g_xccd3_d[l_ac].xcci102h,g_xccd3_d[l_ac].xcci102, 
#                      g_xccd3_d[l_ac].xcci201,g_xccd3_d[l_ac].xcci202a,g_xccd3_d[l_ac].xcci202b,g_xccd3_d[l_ac].xcci202c, 
#                      g_xccd3_d[l_ac].xcci202d,g_xccd3_d[l_ac].xcci202e,g_xccd3_d[l_ac].xcci202f,g_xccd3_d[l_ac].xcci202g, 
#                      g_xccd3_d[l_ac].xcci202h,g_xccd3_d[l_ac].xcci202,g_xccd3_d[l_ac].xcci301,g_xccd3_d[l_ac].xcci302a, 
#                      g_xccd3_d[l_ac].xcci302b,g_xccd3_d[l_ac].xcci302c,g_xccd3_d[l_ac].xcci302d,g_xccd3_d[l_ac].xcci302e, 
#                      g_xccd3_d[l_ac].xcci302f,g_xccd3_d[l_ac].xcci302g,g_xccd3_d[l_ac].xcci302h,g_xccd3_d[l_ac].xcci302, 
#                      g_xccd3_d[l_ac].xcci303,g_xccd3_d[l_ac].xcci304a,g_xccd3_d[l_ac].xcci304b,g_xccd3_d[l_ac].xcci304c, 
#                      g_xccd3_d[l_ac].xcci304d,g_xccd3_d[l_ac].xcci304e,g_xccd3_d[l_ac].xcci304f,g_xccd3_d[l_ac].xcci304g, 
#                      g_xccd3_d[l_ac].xcci304h,g_xccd3_d[l_ac].xcci304,g_xccd3_d[l_ac].xcci901,g_xccd3_d[l_ac].xcci902a, 
#                      g_xccd3_d[l_ac].xcci902b,g_xccd3_d[l_ac].xcci902c,g_xccd3_d[l_ac].xcci902d,g_xccd3_d[l_ac].xcci902e, 
#                      g_xccd3_d[l_ac].xcci902f,g_xccd3_d[l_ac].xcci902g,g_xccd3_d[l_ac].xcci902h,g_xccd3_d[l_ac].xcci902 
#
#                  IF SQLCA.sqlcode THEN
#                     INITIALIZE g_errparam TO NULL 
#                     LET g_errparam.extend = '' 
#                     LET g_errparam.code   = SQLCA.sqlcode 
#                     LET g_errparam.popup  = TRUE 
#                     CALL cl_err()
#                     LET l_lock_sw = "Y"
#                  END IF
#                  
#                  LET g_bfill = "N"
#                  CALL axcq540_show()
#                  LET g_bfill = "Y"
#                  
#                  CALL cl_show_fld_cont()
#               END IF
#            ELSE
#               LET l_cmd='a'
#            END IF
#            #add-point:modify段before row

#            #end add-point  
#            #其他table資料備份(確定是否更改用)
#            LET g_detail_multi_table_t.xcbbcomp = g_xccd_m.xccdld
#LET g_detail_multi_table_t.xcbb001 = g_xccd_m.xccd001
#LET g_detail_multi_table_t.xcbb002 = g_xccd_m.xccd003
#LET g_detail_multi_table_t.xcbb003 = g_xccd_m.xccd004
#LET g_detail_multi_table_t.xcbb004 = g_xccd_m.xccd005
#LET g_detail_multi_table_t.xcbb005 = g_xccd3_d[l_ac].xcci002
# 
#            #其他table進行lock
#            
#            
#         BEFORE DELETE                            #是否取消單身
#            IF l_cmd = 'a' THEN
#               LET l_cmd='d'
#            ELSE
#               IF NOT cl_ask_del_detail() THEN
#                  CANCEL DELETE
#               END IF
#               IF l_lock_sw = "Y" THEN
#                  INITIALIZE g_errparam TO NULL 
#                  LET g_errparam.extend = "" 
#                  LET g_errparam.code   = -263 
#                  LET g_errparam.popup  = TRUE 
#                  CALL cl_err()
#                  CANCEL DELETE
#               END IF
#               
#               #add-point:單身3刪除前

#               #end add-point    
#               
#               DELETE FROM xcci_t
#                WHERE xccient = g_enterprise AND xccild = g_xccd_m.xccdld AND
#                                          xcci001 = g_xccd_m.xccd001 AND
#                                          xcci003 = g_xccd_m.xccd003 AND
#                                          xcci004 = g_xccd_m.xccd004 AND
#                                          xcci005 = g_xccd_m.xccd005 AND
#                      xcci002 = g_xccd3_d_t.xcci002
#                  AND xcci006 = g_xccd3_d_t.xcci006
#                  AND xcci007 = g_xccd3_d_t.xcci007
#                  AND xcci008 = g_xccd3_d_t.xcci008
#                  AND xcci009 = g_xccd3_d_t.xcci009
#                  
#               #add-point:單身3刪除中

#               #end add-point    
#                  
#               IF SQLCA.sqlcode THEN
#                  INITIALIZE g_errparam TO NULL 
#                  LET g_errparam.extend = "xccd_t" 
#                  LET g_errparam.code   = SQLCA.sqlcode 
#                  LET g_errparam.popup  = TRUE 
#                  CALL cl_err()
#                  CALL s_transaction_end('N','0')
#                  CANCEL DELETE   
#               ELSE
#                  LET g_rec_b = g_rec_b-1
#                  INITIALIZE l_var_keys_bak TO NULL 
#                  INITIALIZE l_field_keys TO NULL 
#                  LET l_field_keys[01] = 'xcbbcomp'
#                  LET l_field_keys[02] = 'xcbb001'
#                  LET l_field_keys[03] = 'xcbb002'
#                  LET l_field_keys[04] = 'xcbb003'
#                  LET l_field_keys[05] = 'xcbb004'
#                  LET l_var_keys_bak[01] = g_detail_multi_table_t.xcbbcomp
#                  LET l_var_keys_bak[02] = g_detail_multi_table_t.xcbb001
#                  LET l_var_keys_bak[03] = g_detail_multi_table_t.xcbb002
#                  LET l_var_keys_bak[04] = g_detail_multi_table_t.xcbb003
#                  LET l_var_keys_bak[05] = g_detail_multi_table_t.xcbb004
#                  CALL cl_multitable_delete(l_field_keys,l_var_keys_bak,'xcbb_t')
# 
#                  #add-point:單身3刪除後

#                  #end add-point
#                  CALL s_transaction_end('Y','0')
#               END IF 
#               CLOSE axcq540_bcl
#               LET l_count = g_xccd_d.getLength()
#                              INITIALIZE gs_keys TO NULL 
#               LET gs_keys[1] = g_xccd_m.xccdld
#               LET gs_keys[2] = g_xccd_m.xccd001
#               LET gs_keys[3] = g_xccd_m.xccd003
#               LET gs_keys[4] = g_xccd_m.xccd004
#               LET gs_keys[5] = g_xccd_m.xccd005
#               LET gs_keys[6] = g_xccd3_d[g_detail_idx].xcci002
#               LET gs_keys[7] = g_xccd3_d[g_detail_idx].xcci006
#               LET gs_keys[8] = g_xccd3_d[g_detail_idx].xcci007
#               LET gs_keys[9] = g_xccd3_d[g_detail_idx].xcci008
#               LET gs_keys[10] = g_xccd3_d[g_detail_idx].xcci009
# 
#            END IF 
#            
#         AFTER DELETE 
#            IF l_cmd <> 'd' THEN
#               #add-point:單身AFTER DELETE 

#               #end add-point
#                              CALL axcq540_delete_b('xcci_t',gs_keys,"'3'")
#            END IF
#            #如果是最後一筆
#            IF l_ac = (g_xccd3_d.getLength() + 1) THEN
#               CALL FGL_SET_ARR_CURR(l_ac-1)
#            END IF
# 
#         AFTER INSERT    
#            LET l_insert = FALSE
#            IF INT_FLAG THEN
#               INITIALIZE g_errparam TO NULL 
#               LET g_errparam.extend = '' 
#               LET g_errparam.code   = 9001 
#               LET g_errparam.popup  = FALSE 
#               CALL cl_err()
#               LET INT_FLAG = 0
#               CANCEL INSERT
#            END IF
#               
#            #add-point:單身3新增前

#            #end add-point
#               
#            LET l_count = 1  
#            SELECT COUNT(*) INTO l_count FROM xcci_t 
#             WHERE xccient = g_enterprise AND xccild = g_xccd_m.xccdld
#               AND xcci001 = g_xccd_m.xccd001
#               AND xcci003 = g_xccd_m.xccd003
#               AND xcci004 = g_xccd_m.xccd004
#               AND xcci005 = g_xccd_m.xccd005
#               AND xcci002 = g_xccd3_d[l_ac].xcci002
#               AND xcci006 = g_xccd3_d[l_ac].xcci006
#               AND xcci007 = g_xccd3_d[l_ac].xcci007
#               AND xcci008 = g_xccd3_d[l_ac].xcci008
#               AND xcci009 = g_xccd3_d[l_ac].xcci009
#                
#            #資料未重複, 插入新增資料
#            IF l_count = 0 THEN 
#               #add-point:單身3新增前

#               #end add-point
#            
#                              INITIALIZE gs_keys TO NULL 
#               LET gs_keys[1] = g_xccd_m.xccdld
#               LET gs_keys[2] = g_xccd_m.xccd001
#               LET gs_keys[3] = g_xccd_m.xccd003
#               LET gs_keys[4] = g_xccd_m.xccd004
#               LET gs_keys[5] = g_xccd_m.xccd005
#               LET gs_keys[6] = g_xccd3_d[g_detail_idx].xcci002
#               LET gs_keys[7] = g_xccd3_d[g_detail_idx].xcci006
#               LET gs_keys[8] = g_xccd3_d[g_detail_idx].xcci007
#               LET gs_keys[9] = g_xccd3_d[g_detail_idx].xcci008
#               LET gs_keys[10] = g_xccd3_d[g_detail_idx].xcci009
#               CALL axcq540_insert_b('xcci_t',gs_keys,"'3'")
#                           
#               #add-point:單身新增後3

#               #end add-point
#            ELSE    
#               INITIALIZE g_errparam TO NULL 
#               LET g_errparam.extend = 'INSERT' 
#               LET g_errparam.code   = "std-00006" 
#               LET g_errparam.popup  = TRUE 
#               CALL cl_err()
#               INITIALIZE g_xccd_d[l_ac].* TO NULL
#               CALL s_transaction_end('N','0')
#               CANCEL INSERT
#            END IF
# 
#            IF SQLCA.SQLcode  THEN
#               INITIALIZE g_errparam TO NULL 
#               LET g_errparam.extend = "xcci_t" 
#               LET g_errparam.code   = SQLCA.sqlcode 
#               LET g_errparam.popup  = TRUE 
#               CALL cl_err()
#               CALL s_transaction_end('N','0')                    
#               CANCEL INSERT
#            ELSE
#               #先刷新資料
#               #CALL axcq540_b_fill()
#               #資料多語言用-增/改
#               
#               #add-point:單身新增後

#               #end add-point
#               CALL s_transaction_end('Y','0')
#               ERROR 'INSERT O.K'
#               LET g_rec_b = g_rec_b + 1
#            END IF
#            
#         ON ROW CHANGE 
#            IF INT_FLAG THEN
#               INITIALIZE g_errparam TO NULL 
#               LET g_errparam.extend = '' 
#               LET g_errparam.code   = 9001 
#               LET g_errparam.popup  = FALSE 
#               CALL cl_err()
#               LET INT_FLAG = 0
#               LET g_xccd3_d[l_ac].* = g_xccd3_d_t.*
#               CLOSE axcq540_bcl3
#               CALL s_transaction_end('N','0')
#               EXIT DIALOG 
#            END IF
#            
#            IF l_lock_sw = 'Y' THEN
#               INITIALIZE g_errparam TO NULL 
#               LET g_errparam.extend = '' 
#               LET g_errparam.code   = -263 
#               LET g_errparam.popup  = TRUE 
#               CALL cl_err()
#               LET g_xccd3_d[l_ac].* = g_xccd3_d_t.*
#            ELSE
#               #add-point:單身page3修改前

#               #end add-point
#               
#               #寫入修改者/修改日期資訊(單身3)
#               
#               
#               UPDATE xcci_t SET (xccild,xcci001,xcci003,xcci004,xcci005,xcci006,xcci007,xcci008,xcci009, 
#                   xcci002,xcci101,xcci102a,xcci102b,xcci102c,xcci102d,xcci102e,xcci102f,xcci102g,xcci102h, 
#                   xcci201,xcci202a,xcci202b,xcci202c,xcci202d,xcci202e,xcci202f,xcci202g,xcci202h,xcci301, 
#                   xcci302a,xcci302b,xcci302c,xcci302d,xcci302e,xcci302f,xcci302g,xcci302h,xcci303,xcci304a, 
#                   xcci304b,xcci304c,xcci304d,xcci304e,xcci304f,xcci304g,xcci304h,xcci901,xcci902a,xcci902b, 
#                   xcci902c,xcci902d,xcci902e,xcci902f,xcci902g,xcci902h) = (g_xccd_m.xccdld,g_xccd_m.xccd001, 
#                   g_xccd_m.xccd003,g_xccd_m.xccd004,g_xccd_m.xccd005,g_xccd3_d[l_ac].xcci006,g_xccd3_d[l_ac].xcci007, 
#                   g_xccd3_d[l_ac].xcci008,g_xccd3_d[l_ac].xcci009,g_xccd3_d[l_ac].xcci002,g_xccd3_d[l_ac].xcci101, 
#                   g_xccd3_d[l_ac].xcci102a,g_xccd3_d[l_ac].xcci102b,g_xccd3_d[l_ac].xcci102c,g_xccd3_d[l_ac].xcci102d, 
#                   g_xccd3_d[l_ac].xcci102e,g_xccd3_d[l_ac].xcci102f,g_xccd3_d[l_ac].xcci102g,g_xccd3_d[l_ac].xcci102h, 
#                   g_xccd3_d[l_ac].xcci201,g_xccd3_d[l_ac].xcci202a,g_xccd3_d[l_ac].xcci202b,g_xccd3_d[l_ac].xcci202c, 
#                   g_xccd3_d[l_ac].xcci202d,g_xccd3_d[l_ac].xcci202e,g_xccd3_d[l_ac].xcci202f,g_xccd3_d[l_ac].xcci202g, 
#                   g_xccd3_d[l_ac].xcci202h,g_xccd3_d[l_ac].xcci301,g_xccd3_d[l_ac].xcci302a,g_xccd3_d[l_ac].xcci302b, 
#                   g_xccd3_d[l_ac].xcci302c,g_xccd3_d[l_ac].xcci302d,g_xccd3_d[l_ac].xcci302e,g_xccd3_d[l_ac].xcci302f, 
#                   g_xccd3_d[l_ac].xcci302g,g_xccd3_d[l_ac].xcci302h,g_xccd3_d[l_ac].xcci303,g_xccd3_d[l_ac].xcci304a, 
#                   g_xccd3_d[l_ac].xcci304b,g_xccd3_d[l_ac].xcci304c,g_xccd3_d[l_ac].xcci304d,g_xccd3_d[l_ac].xcci304e, 
#                   g_xccd3_d[l_ac].xcci304f,g_xccd3_d[l_ac].xcci304g,g_xccd3_d[l_ac].xcci304h,g_xccd3_d[l_ac].xcci901, 
#                   g_xccd3_d[l_ac].xcci902a,g_xccd3_d[l_ac].xcci902b,g_xccd3_d[l_ac].xcci902c,g_xccd3_d[l_ac].xcci902d, 
#                   g_xccd3_d[l_ac].xcci902e,g_xccd3_d[l_ac].xcci902f,g_xccd3_d[l_ac].xcci902g,g_xccd3_d[l_ac].xcci902h)  
#                   #自訂欄位頁簽
#                WHERE xccient = g_enterprise AND xccild = g_xccd_m.xccdld
#                  AND xcci001 = g_xccd_m.xccd001
#                  AND xcci003 = g_xccd_m.xccd003
#                  AND xcci004 = g_xccd_m.xccd004
#                  AND xcci005 = g_xccd_m.xccd005
#                  AND xcci002 = g_xccd3_d_t.xcci002 #項次 
#                  AND xcci006 = g_xccd3_d_t.xcci006
#                  AND xcci007 = g_xccd3_d_t.xcci007
#                  AND xcci008 = g_xccd3_d_t.xcci008
#                  AND xcci009 = g_xccd3_d_t.xcci009
#                  
#               #add-point:單身page3修改中

#               #end add-point
#                  
#               CASE
#                  WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
#                     INITIALIZE g_errparam TO NULL 
#                     LET g_errparam.extend = "xcci_t" 
#                     LET g_errparam.code   = "std-00009" 
#                     LET g_errparam.popup  = TRUE 
#                     CALL cl_err()
#                     CALL s_transaction_end('N','0')
#                     LET g_xccd3_d[l_ac].* = g_xccd3_d_t.*
#                  WHEN SQLCA.sqlcode #其他錯誤
#                     INITIALIZE g_errparam TO NULL 
#                     LET g_errparam.extend = "xcci_t" 
#                     LET g_errparam.code   = SQLCA.sqlcode 
#                     LET g_errparam.popup  = TRUE 
#                     CALL cl_err()
#                     CALL s_transaction_end('N','0')
#                     LET g_xccd3_d[l_ac].* = g_xccd3_d_t.*
#                  OTHERWISE
#                                    INITIALIZE gs_keys TO NULL 
#               LET gs_keys[1] = g_xccd_m.xccdld
#               LET gs_keys_bak[1] = g_xccdld_t
#               LET gs_keys[2] = g_xccd_m.xccd001
#               LET gs_keys_bak[2] = g_xccd001_t
#               LET gs_keys[3] = g_xccd_m.xccd003
#               LET gs_keys_bak[3] = g_xccd003_t
#               LET gs_keys[4] = g_xccd_m.xccd004
#               LET gs_keys_bak[4] = g_xccd004_t
#               LET gs_keys[5] = g_xccd_m.xccd005
#               LET gs_keys_bak[5] = g_xccd005_t
#               LET gs_keys[6] = g_xccd3_d[g_detail_idx].xcci002
#               LET gs_keys_bak[6] = g_xccd3_d_t.xcci002
#               LET gs_keys[7] = g_xccd3_d[g_detail_idx].xcci006
#               LET gs_keys_bak[7] = g_xccd3_d_t.xcci006
#               LET gs_keys[8] = g_xccd3_d[g_detail_idx].xcci007
#               LET gs_keys_bak[8] = g_xccd3_d_t.xcci007
#               LET gs_keys[9] = g_xccd3_d[g_detail_idx].xcci008
#               LET gs_keys_bak[9] = g_xccd3_d_t.xcci008
#               LET gs_keys[10] = g_xccd3_d[g_detail_idx].xcci009
#               LET gs_keys_bak[10] = g_xccd3_d_t.xcci009
#               CALL axcq540_update_b('xcci_t',gs_keys,gs_keys_bak,"'3'")
#                     #資料多語言用-增/改
#                     
#               END CASE
#               
#               #修改歷程記錄
#               LET g_log1 = util.JSON.stringify(g_xccd_m),util.JSON.stringify(g_xccd3_d_t)
#               LET g_log2 = util.JSON.stringify(g_xccd_m),util.JSON.stringify(g_xccd3_d[l_ac])
#               IF NOT cl_log_modified_record(g_log1,g_log2) THEN 
#                  CALL s_transaction_end('N','0')
#               END IF
#               
#               #add-point:單身page3修改後

#               #end add-point
#            END IF
#         
#                  #此段落由子樣板a01產生
#         BEFORE FIELD xcci006
#            #add-point:BEFORE FIELD xcci006

#            #END add-point
# 
#         #此段落由子樣板a02產生
#         AFTER FIELD xcci006
#            
#            #add-point:AFTER FIELD xcci006
 
#            #END add-point
#            
# 
#         #此段落由子樣板a04產生
#         ON CHANGE xcci006
#            #add-point:ON CHANGE xcci006

#            #END add-point
# 
#         #此段落由子樣板a02產生
#         AFTER FIELD xcci007
#            
#            #add-point:AFTER FIELD xcci007
            #此段落由子樣板a05產生
##            #END add-point
##            
## 
##         #此段落由子樣板a01產生
##         BEFORE FIELD xcci007
##            #add-point:BEFORE FIELD xcci007

##            #END add-point
## 
##         #此段落由子樣板a04產生
##         ON CHANGE xcci007
##            #add-point:ON CHANGE xcci007

##            #END add-point
## 
##         #此段落由子樣板a01產生
##         BEFORE FIELD xcci008
##            #add-point:BEFORE FIELD xcci008

##            #END add-point
## 
##         #此段落由子樣板a02產生
##         AFTER FIELD xcci008
##            
##            #add-point:AFTER FIELD xcci008
 
##            #END add-point
##            
## 
##         #此段落由子樣板a04產生
##         ON CHANGE xcci008
##            #add-point:ON CHANGE xcci008

##            #END add-point
## 
##         #此段落由子樣板a01產生
##         BEFORE FIELD xcci002
##            #add-point:BEFORE FIELD xcci002

##            #END add-point
## 
##         #此段落由子樣板a02產生
##         AFTER FIELD xcci002
##            
##            #add-point:AFTER FIELD xcci002
 
##            #END add-point
##            
## 
##         #此段落由子樣板a04產生
##         ON CHANGE xcci002
##            #add-point:ON CHANGE xcci002

##            #END add-point
## 
## 
##                  #Ctrlp:input.c.page3.xcci006
##         ON ACTION controlp INFIELD xcci006
##            #add-point:ON ACTION controlp INFIELD xcci006

##            #END add-point
## 
##         #Ctrlp:input.c.page3.xcci007
##         ON ACTION controlp INFIELD xcci007
##            #add-point:ON ACTION controlp INFIELD xcci007

##            #END add-point
## 
##         #Ctrlp:input.c.page3.xcci008
##         ON ACTION controlp INFIELD xcci008
##            #add-point:ON ACTION controlp INFIELD xcci008

##            #END add-point
## 
##         #Ctrlp:input.c.page3.xcci002
##         ON ACTION controlp INFIELD xcci002
##            #add-point:ON ACTION controlp INFIELD xcci002

##            #END add-point
## 
## 
## 
##         AFTER ROW
##            #add-point:單身page3 after_row

##            #end add-point
##            LET l_ac = ARR_CURR()
##            IF INT_FLAG THEN
##               INITIALIZE g_errparam TO NULL 
##               LET g_errparam.extend = '' 
##               LET g_errparam.code   = 9001 
##               LET g_errparam.popup  = FALSE 
##               CALL cl_err()
##               LET INT_FLAG = 0
##               IF l_cmd = 'u' THEN
##                  LET g_xccd3_d[l_ac].* = g_xccd3_d_t.*
##               END IF
##               CLOSE axcq540_bcl3
##               CALL s_transaction_end('N','0')
##               EXIT DIALOG 
##            END IF
##            
##            #其他table進行unlock
##            
##            CALL axcq540_unlock_b("xcci_t","'3'")
##            CALL s_transaction_end('Y','0')
##            #add-point:單身page3 after_row2

##            #end add-point
## 
##         AFTER INPUT
##            #add-point:input段after input 

##            #end add-point   
##    
##         ON ACTION controlo
##            CALL FGL_SET_ARR_CURR(g_xccd3_d.getLength()+1)
##            LET lb_reproduce = TRUE
##            LET li_reproduce = l_ac
##            LET li_reproduce_target = g_xccd3_d.getLength()+1
## 
##      END INPUT
## 
##      
## 
##      
## 
##      
## 
##      
##
{</section>}
 
{<section id="axcq540.input.other" >}
##      
##      #add-point:自定義input

##      #end add-point
##      
##      BEFORE DIALOG 
##         #CALL cl_err_collect_init()    
##         #add-point:input段before dialog

##         #end add-point    
##         #新增時強制從單頭開始填
##         IF p_cmd = 'a' THEN
##            NEXT FIELD xccdld
##         ELSE
##            CASE g_aw
##               WHEN "s_detail1"
##                  NEXT FIELD sfaa068
##               WHEN "s_detail2"
##                  NEXT FIELD sfaa068
##               WHEN "s_detail3"
##                  NEXT FIELD sfaa068
## 
##            END CASE
##         END IF
##    
##      ON ACTION controlf
##         CALL cl_set_focus_form(ui.Interface.getRootNode()) RETURNING g_fld_name,g_frm_name
##         CALL cl_fldhelp(g_frm_name,g_fld_name,g_lang)
## 
##      ON ACTION controlr
##         CALL cl_show_req_fields()
## 
##      ON ACTION controls
##         IF g_header_hidden THEN
##            CALL gfrm_curr.setElementHidden("vb_master",0)
##            CALL gfrm_curr.setElementImage("controls","small/arr-u.png")
##            LET g_header_hidden = 0     #visible
##         ELSE
##            CALL gfrm_curr.setElementHidden("vb_master",1)
##            CALL gfrm_curr.setElementImage("controls","small/arr-d.png")
##            LET g_header_hidden = 1     #hidden     
##         END IF
## 
##      ON ACTION accept
##         #add-point:input段accept 

##         #end add-point    
##         ACCEPT DIALOG
##        
##      ON ACTION cancel      #在dialog button (放棄)
##         LET INT_FLAG = TRUE 
##         LET g_detail_idx  = 1
##         LET g_detail_idx2 = 1
##         EXIT DIALOG
## 
##      ON ACTION close       #在dialog 右上角 (X)
##         LET INT_FLAG = TRUE 
##         EXIT DIALOG
## 
##      ON ACTION exit        #toolbar 離開
##         LET INT_FLAG = TRUE 
##         EXIT DIALOG
## 
##      #交談指令共用ACTION
##      &include "common_action.4gl" 
##         CONTINUE DIALOG 
##         
##   END DIALOG
##    
#   #add-point:input段after input 

#   #end add-point    
# 
END FUNCTION
 
{</section>}
 
{<section id="axcq540.show" >}
#+ 單頭資料重新顯示及單身資料重抓
PRIVATE FUNCTION axcq540_show()
   DEFINE l_ac_t    LIKE type_t.num10
   #add-point:show段define
   DEFINE l_glaa001 LIKE glaa_t.glaa001
   DEFINE l_glaa016 LIKE glaa_t.glaa016
   DEFINE l_glaa020 LIKE glaa_t.glaa020
   #end add-point  
 
   #add-point:show段之前
   #fengmy 150113----begin
   #根據參數顯示隱藏成本域 和 料件特性
   IF cl_null(g_xccd_m.xccdcomp) THEN
      CALL cl_get_para(g_enterprise,g_site,'S-FIN-6001') RETURNING g_para_data   #采用成本域否
      CALL cl_get_para(g_enterprise,g_site,'S-FIN-6013') RETURNING g_para_data1   #采用特性否       
   ELSE
      CALL cl_get_para(g_enterprise,g_xccd_m.xccdcomp,'S-FIN-6001') RETURNING g_para_data   #采用成本域否
      CALL cl_get_para(g_enterprise,g_xccd_m.xccdcomp,'S-FIN-6013') RETURNING g_para_data1   #采用特性否       
   END IF          
         
   IF g_para_data = 'Y' THEN
      CALL cl_set_comp_visible('xccd002,xccd002_desc,xcce002_2,xcce002_2_desc,xcci002,xcci002_desc',TRUE)                    
   ELSE                        
      CALL cl_set_comp_visible('xccd002,xccd002_desc,xcce002_2,xcce002_2_desc,xcci002,xcci002_desc',FALSE)                
   END IF   
   IF g_para_data1 = 'Y' THEN
      CALL cl_set_comp_visible('xcce008,xcce008_2,xcci008',TRUE)                    
   ELSE                       
      CALL cl_set_comp_visible('xcce008,xcce008_2,xcci008',FALSE)                
   END IF   
   #fengmy 150113----end
   #end add-point
   
   
   
   IF g_bfill = "Y" THEN
      CALL axcq540_b_fill() #單身填充
      CALL axcq540_b_fill2('0') #單身填充
   END IF
     
   #帶出公用欄位reference值
   
   
   #顯示followup圖示
   #+ 此段落由子樣板a48產生
   CALL axcq540_set_pk_array()
   #add-point:ON ACTION agendum
   SELECT glaa001,glaa016,glaa020 INTO l_glaa001,l_glaa016,l_glaa020
     FROM glaa_t
    WHERE glaaent = g_enterprise
      AND glaald  = g_xccd_m.xccdld
      
      
   CASE g_xccd_m.xccd001
      WHEN '1' 
        INITIALIZE g_ref_fields TO NULL
        LET g_ref_fields[1] = l_glaa001
        CALL ap_ref_array2(g_ref_fields,"SELECT ooail003 FROM ooail_t WHERE ooailent='"||g_enterprise||"' AND ooail001=? AND ooail002='"||g_dlang||"'","") RETURNING g_rtn_fields
        LET g_xccd_m.xccd001_desc = '', g_rtn_fields[1] , ''                  
      WHEN '2'
        INITIALIZE g_ref_fields TO NULL
        LET g_ref_fields[1] = l_glaa016
        CALL ap_ref_array2(g_ref_fields,"SELECT ooail003 FROM ooail_t WHERE ooailent='"||g_enterprise||"' AND ooail001=? AND ooail002='"||g_dlang||"'","") RETURNING g_rtn_fields
        LET g_xccd_m.xccd001_desc = '', g_rtn_fields[1] , ''
      WHEN '3'
        INITIALIZE g_ref_fields TO NULL
        LET g_ref_fields[1] = l_glaa020
        CALL ap_ref_array2(g_ref_fields,"SELECT ooail003 FROM ooail_t WHERE ooailent='"||g_enterprise||"' AND ooail001=? AND ooail002='"||g_dlang||"'","") RETURNING g_rtn_fields
        LET g_xccd_m.xccd001_desc = '', g_rtn_fields[1] , ''
   END CASE 
   

   #END add-point
   CALL cl_user_overview_set_follow_pic()
 
 
   
   LET l_ac_t = l_ac
   
   #讀入ref值(單頭)
   #add-point:show段reference
   #fengmy150813----begin
   LET g_sql = " SELECT UNIQUE t0.xccdcomp,t0.xccdld,t0.xccd003,t1.ooefl003 , 
       t2.glaal002 ,t3.xcatl003",
               " FROM xccd_t t0",
                              " LEFT JOIN ooefl_t t1 ON t1.ooeflent='"||g_enterprise||"' AND t1.ooefl001=t0.xccdcomp AND t1.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN glaal_t t2 ON t2.glaalent='"||g_enterprise||"' AND t2.glaalld=t0.xccdld AND t2.glaal001='"||g_dlang||"' ",
               " LEFT JOIN xcatl_t t3 ON t3.xcatlent='"||g_enterprise||"' AND t3.xcatl001=t0.xccd003 AND t3.xcatl002='"||g_dlang||"' ",
                
               " WHERE t0.xccdent = '" ||g_enterprise|| "' AND t0.xccdld = '" ||g_xccd_m.xccdld|| "'  AND t0.xccd003 = '" ||g_xccd_m.xccd003|| "'" 
   PREPARE axcq540_reference FROM g_sql
   EXECUTE axcq540_reference INTO g_xccd_m.xccdcomp,g_xccd_m.xccdld, 
    g_xccd_m.xccd003,g_xccd_m.xccdcomp_desc,g_xccd_m.xccdld_desc,g_xccd_m.xccd003_desc
   #fengmy150813----begin
   #end add-point
   
   #將資料輸出到畫面上
   DISPLAY BY NAME g_xccd_m.xccdcomp,g_xccd_m.xccdcomp_desc,g_xccd_m.xccdld,g_xccd_m.xccdld_desc,g_xccd_m.xccd004, 
       g_xccd_m.xccd005,g_xccd_m.xccd001,g_xccd_m.xccd001_desc,g_xccd_m.xccd003,g_xccd_m.xccd003_desc 
 
   
   #顯示狀態(stus)圖片
   
   
   #讀入ref值(單身)
#   FOR l_ac = 1 TO g_xccd_d.getLength()
#      #add-point:show段單身reference

#   INITIALIZE g_ref_fields TO NULL 
#   LET g_ref_fields[1] = g_xccd_m.xccdld
#   LET g_ref_fields[2] = g_xccd_m.xccd001
#   LET g_ref_fields[3] = g_xccd_d[l_ac].xccd002
#   LET g_ref_fields[4] = g_xccd_m.xccd003
#   LET g_ref_fields[5] = g_xccd_m.xccd004
#   LET g_ref_fields[6] = g_xccd_m.xccd005
#   LET g_ref_fields[7] = g_xccd_d[l_ac].xccd006
#   LET g_ref_fields[8] = g_xccd3_d[l_ac].xcci002
#   LET g_ref_fields[9] = g_xccd3_d[l_ac].xcci006
#   LET g_ref_fields[10] = g_xccd3_d[l_ac].xcci007
#   LET g_ref_fields[11] = g_xccd3_d[l_ac].xcci008
#   LET g_ref_fields[12] = g_xccd3_d[l_ac].xcci009
#   CALL ap_ref_array2(g_ref_fields," SELECT sfaa068 FROM sfaa_t WHERE sfaaent = '"||g_enterprise||"' AND sfaadocno = ? ","") RETURNING g_rtn_fields 
#   LET g_xccd_d[l_ac].sfaa068 = g_rtn_fields[1] 
#   DISPLAY BY NAME g_xccd_d[l_ac].sfaa068
#   INITIALIZE g_ref_fields TO NULL 
#   LET g_ref_fields[1] = g_xccd_m.xccdld
#   LET g_ref_fields[2] = g_xccd_m.xccd001
#   LET g_ref_fields[3] = g_xccd_d[l_ac].xccd002
#   LET g_ref_fields[4] = g_xccd_m.xccd003
#   LET g_ref_fields[5] = g_xccd_m.xccd004
#   LET g_ref_fields[6] = g_xccd_m.xccd005
#   LET g_ref_fields[7] = g_xccd_d[l_ac].xccd006
#   LET g_ref_fields[8] = g_xccd3_d[l_ac].xcci002
#   LET g_ref_fields[9] = g_xccd3_d[l_ac].xcci006
#   LET g_ref_fields[10] = g_xccd3_d[l_ac].xcci007
#   LET g_ref_fields[11] = g_xccd3_d[l_ac].xcci008
#   LET g_ref_fields[12] = g_xccd3_d[l_ac].xcci009
#   CALL ap_ref_array2(g_ref_fields," SELECT xcce007,xcce008,xcce009,xcce101,xcce102,xcce201,xcce202,xcce301,xcce302,xcce303,xcce304,xcce307,xcce308,xcce901,xcce902 FROM xcce_t WHERE xcceent = '"||g_enterprise||"' AND xcceld = ? AND xcce001 = ? AND xcce002 = ? AND xcce003 = ? AND xcce004 = ? AND xcce005 = ? AND xcce006 = ? AND xcce007 = ? AND xcce008 = ? AND xcce009 = ? ","") RETURNING g_rtn_fields 
#   LET g_xccd_d[l_ac].xcce007 = g_rtn_fields[1] 
#   LET g_xccd_d[l_ac].xcce008 = g_rtn_fields[2] 
#   LET g_xccd_d[l_ac].xcce009 = g_rtn_fields[3] 
#   LET g_xccd_d[l_ac].xcce101 = g_rtn_fields[4] 
#   LET g_xccd_d[l_ac].xcce102 = g_rtn_fields[5] 
#   LET g_xccd_d[l_ac].xcce201 = g_rtn_fields[6] 
#   LET g_xccd_d[l_ac].xcce202 = g_rtn_fields[7] 
#   LET g_xccd_d[l_ac].xcce301 = g_rtn_fields[8] 
#   LET g_xccd_d[l_ac].xcce302 = g_rtn_fields[9] 
#   LET g_xccd_d[l_ac].xcce303 = g_rtn_fields[10] 
#   LET g_xccd_d[l_ac].xcce304 = g_rtn_fields[11] 
#   LET g_xccd_d[l_ac].xcce307 = g_rtn_fields[12] 
#   LET g_xccd_d[l_ac].xcce308 = g_rtn_fields[13] 
#   LET g_xccd_d[l_ac].xcce901 = g_rtn_fields[14] 
#   LET g_xccd_d[l_ac].xcce902 = g_rtn_fields[15] 
#   DISPLAY BY NAME g_xccd_d[l_ac].xcce007,g_xccd_d[l_ac].xcce008,g_xccd_d[l_ac].xcce009,g_xccd_d[l_ac].xcce101,g_xccd_d[l_ac].xcce102,g_xccd_d[l_ac].xcce201,g_xccd_d[l_ac].xcce202,g_xccd_d[l_ac].xcce301,g_xccd_d[l_ac].xcce302,g_xccd_d[l_ac].xcce303,g_xccd_d[l_ac].xcce304,g_xccd_d[l_ac].xcce307,g_xccd_d[l_ac].xcce308,g_xccd_d[l_ac].xcce901,g_xccd_d[l_ac].xcce902
#   INITIALIZE g_ref_fields TO NULL 
#   LET g_ref_fields[1] = g_xccd_m.xccdld
#   LET g_ref_fields[2] = g_xccd_m.xccd001
#   LET g_ref_fields[3] = g_xccd_d[l_ac].xccd002
#   LET g_ref_fields[4] = g_xccd_m.xccd003
#   LET g_ref_fields[5] = g_xccd_m.xccd004
#   LET g_ref_fields[6] = g_xccd_m.xccd005
#   LET g_ref_fields[7] = g_xccd_d[l_ac].xccd006
#   LET g_ref_fields[8] = g_xccd3_d[l_ac].xcci002
#   LET g_ref_fields[9] = g_xccd3_d[l_ac].xcci006
#   LET g_ref_fields[10] = g_xccd3_d[l_ac].xcci007
#   LET g_ref_fields[11] = g_xccd3_d[l_ac].xcci008
#   LET g_ref_fields[12] = g_xccd3_d[l_ac].xcci009
#   CALL ap_ref_array2(g_ref_fields," SELECT xcbb005 FROM xcbb_t WHERE xcbbent = '"||g_enterprise||"' AND xcbbcomp = ? AND xcbb001 = ? AND xcbb002 = ? AND xcbb003 = ? AND xcbb004 = ? ","") RETURNING g_rtn_fields 
#   LET g_xccd_d[l_ac].xcbb005 = g_rtn_fields[1] 
#   DISPLAY BY NAME g_xccd_d[l_ac].xcbb005
#      #end add-point
#   END FOR
#   
#   FOR l_ac = 1 TO g_xccd2_d.getLength()
#      #add-point:show段單身reference

#      #end add-point
#   END FOR
#   FOR l_ac = 1 TO g_xccd3_d.getLength()
#      #add-point:show段單身reference

#      #end add-point
#   END FOR
# 
#   
#    
#   
   #add-point:show段other

   #end add-point  
   
   LET l_ac = l_ac_t
   
   #移動上下筆可以連動切換資料
   CALL cl_show_fld_cont()     
 
   CALL axcq540_detail_show()
   
   #add-point:show段之後
#顯示單身筆數
   CALL axcq540_idx_chk()
   #fengmy150812---begin
   DISPLAY g_yy1 TO xccd004
   DISPLAY g_mm1 TO xccd005
   DISPLAY g_yy2 TO xccd004_1
   DISPLAY g_mm2 TO xccd005_1

   #fengmy150812---end 
   #end add-point
   
END FUNCTION
 
{</section>}
 
{<section id="axcq540.detail_show" >}
##+ 第二階單身reference
PRIVATE FUNCTION axcq540_detail_show()
#   #add-point:detail_show段define

#   #end add-point  
# 
#   #add-point:detail_show段之前

#   #end add-point
#   
#   #add-point:detail_show段之後

#   #end add-point
#   
END FUNCTION
#
{</section>}
 
{<section id="axcq540.reproduce" >}
##+ 資料複製
PRIVATE FUNCTION axcq540_reproduce()
#   DEFINE l_newno     LIKE xccd_t.xccdld 
#   DEFINE l_oldno     LIKE xccd_t.xccdld 
#   DEFINE l_newno02     LIKE xccd_t.xccd001 
#   DEFINE l_oldno02     LIKE xccd_t.xccd001 
#   DEFINE l_newno03     LIKE xccd_t.xccd003 
#   DEFINE l_oldno03     LIKE xccd_t.xccd003 
#   DEFINE l_newno04     LIKE xccd_t.xccd004 
#   DEFINE l_oldno04     LIKE xccd_t.xccd004 
#   DEFINE l_newno05     LIKE xccd_t.xccd005 
#   DEFINE l_oldno05     LIKE xccd_t.xccd005 
# 
#   DEFINE l_master    RECORD LIKE xccd_t.*
#   DEFINE l_detail    RECORD LIKE xccd_t.*
#   DEFINE l_detail2    RECORD LIKE xcce_t.*
# 
#   DEFINE l_detail3    RECORD LIKE xcci_t.*
# 
# 
# 
#   DEFINE l_cnt       LIKE type_t.num5
#   #add-point:reproduce段define

#   #end add-point   
# 
#   #切換畫面
#   
#   LET g_master_insert = FALSE
#   
#   IF g_xccd_m.xccdld IS NULL
#   OR g_xccd_m.xccd001 IS NULL
#   OR g_xccd_m.xccd003 IS NULL
#   OR g_xccd_m.xccd004 IS NULL
#   OR g_xccd_m.xccd005 IS NULL
# 
#   THEN
#      INITIALIZE g_errparam TO NULL 
#      LET g_errparam.extend = "" 
#      LET g_errparam.code   = "std-00003" 
#      LET g_errparam.popup  = FALSE 
#      CALL cl_err()
#      RETURN
#   END IF
#    
#   LET g_xccdld_t = g_xccd_m.xccdld
#   LET g_xccd001_t = g_xccd_m.xccd001
#   LET g_xccd003_t = g_xccd_m.xccd003
#   LET g_xccd004_t = g_xccd_m.xccd004
#   LET g_xccd005_t = g_xccd_m.xccd005
# 
#    
#   LET g_xccd_m.xccdld = ""
#   LET g_xccd_m.xccd001 = ""
#   LET g_xccd_m.xccd003 = ""
#   LET g_xccd_m.xccd004 = ""
#   LET g_xccd_m.xccd005 = ""
# 
#    
#   CALL axcq540_set_entry('a')
#   CALL axcq540_set_no_entry('a')
# 
#   CALL cl_set_head_visible("","YES")
# 
#   #公用欄位給予預設值
#   
#   
#   CALL s_transaction_begin()
#   
#   #add-point:複製輸入前

#   #end add-point
#   
#   #顯示狀態(stus)圖片
#   
#   
#   CALL axcq540_input("r")
#   
#      LET g_xccd_m.xccdld_desc = ''
#   DISPLAY BY NAME g_xccd_m.xccdld_desc
#   LET g_xccd_m.xccd001_desc = ''
#   DISPLAY BY NAME g_xccd_m.xccd001_desc
#   LET g_xccd_m.xccd003_desc = ''
#   DISPLAY BY NAME g_xccd_m.xccd003_desc
# 
#   
#   IF INT_FLAG AND NOT g_master_insert THEN
#      INITIALIZE g_errparam TO NULL 
#      LET g_errparam.extend = '' 
#      LET g_errparam.code   = 9001 
#      LET g_errparam.popup  = FALSE 
#      CALL cl_err()
#      CALL s_transaction_end('N','0')
#      LET INT_FLAG = 0
#      DISPLAY g_detail_cnt  TO FORMONLY.h_count    #總筆數
#      DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
#      LET INT_FLAG = 0
#      INITIALIZE g_xccd_m.* TO NULL
#      INITIALIZE g_xccd_d TO NULL
#      INITIALIZE g_xccd2_d TO NULL
#      INITIALIZE g_xccd3_d TO NULL
# 
#      CALL axcq540_show()
#      RETURN
#   END IF
#   
#   #將新增的資料併入搜尋條件中
#   LET g_state = "insert"
#   
#   LET g_xccdld_t = g_xccd_m.xccdld
#   LET g_xccd001_t = g_xccd_m.xccd001
#   LET g_xccd003_t = g_xccd_m.xccd003
#   LET g_xccd004_t = g_xccd_m.xccd004
#   LET g_xccd005_t = g_xccd_m.xccd005
# 
#   
#   #組合新增資料的條件
#   LET g_add_browse = " xccdent = '" ||g_enterprise|| "' AND",
#                      " xccdld = '", g_xccd_m.xccdld CLIPPED, "' "
#                      ," AND xccd001 = '", g_xccd_m.xccd001 CLIPPED, "' "
#                      ," AND xccd003 = '", g_xccd_m.xccd003 CLIPPED, "' "
#                      ," AND xccd004 = '", g_xccd_m.xccd004 CLIPPED, "' "
#                      ," AND xccd005 = '", g_xccd_m.xccd005 CLIPPED, "' "
# 
#   #填到最後面
#   LET g_current_idx = g_browser.getLength() + 1
#   CALL axcq540_browser_fill("")
#   
#   DISPLAY g_browser_cnt TO FORMONLY.h_count    #總筆數
#   DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
#   CALL cl_navigator_setting(g_current_idx, g_browser_cnt)
#   
#   #add-point:完成複製段落後

#   #end add-point
#   
#   CALL axcq540_idx_chk()
   
END FUNCTION
 
{</section>}
 
{<section id="axcq540.detail_reproduce" >}
#+ 單身自動複製
PRIVATE FUNCTION axcq540_detail_reproduce()
#   DEFINE ls_sql      STRING
#   DEFINE ld_date     DATETIME YEAR TO SECOND
#   DEFINE l_detail    RECORD LIKE xccd_t.*
#   DEFINE l_detail2    RECORD LIKE xcce_t.*
# 
#   DEFINE l_detail3    RECORD LIKE xcci_t.*
# 
# 
# 
#   #add-point:delete段define

#   #end add-point    
#   
#   CALL s_transaction_begin()
#   
#   LET ld_date = cl_get_current()
#   
#   DROP TABLE axcq540_detail
#   
#   #add-point:單身複製前1

#   #end add-point
#   
#   #CREATE TEMP TABLE
#   LET ls_sql = "CREATE GLOBAL TEMPORARY TABLE axcq540_detail AS ",
#                "SELECT * FROM xccd_t "
#   PREPARE repro_tbl FROM ls_sql
#   EXECUTE repro_tbl
#   FREE repro_tbl
#                
#   #將符合條件的資料丟入TEMP TABLE
#   INSERT INTO axcq540_detail SELECT * FROM xccd_t 
#                                         WHERE xccdent = g_enterprise AND  = g_xccdld_t
#                                         AND  = g_xccd001_t
#                                         AND  = g_xccd003_t
#                                         AND  = g_xccd004_t
#                                         AND  = g_xccd005_t
# 
#   
#   #將key修正為調整後   
#   UPDATE axcq540_detail 
#      #更新key欄位
#      SET  = g_xccd_m.xccdld
#          ,  = g_xccd_m.xccd001
#          ,  = g_xccd_m.xccd003
#          ,  = g_xccd_m.xccd004
#          ,  = g_xccd_m.xccd005
# 
#      #更新共用欄位
#      
# 
#   #add-point:單身修改前

#   #end add-point                                       
#  
#   #將資料塞回原table   
#   INSERT INTO xccd_t SELECT * FROM axcq540_detail
#   
#   IF SQLCA.sqlcode THEN
#      INITIALIZE g_errparam TO NULL 
#      LET g_errparam.extend = "reproduce" 
#      LET g_errparam.code   = SQLCA.sqlcode 
#      LET g_errparam.popup  = TRUE 
#      CALL cl_err()
# 
#      RETURN
#   END IF
#   
#   #add-point:單身複製中1

#   #end add-point
#   
#   #刪除TEMP TABLE
#   DROP TABLE axcq540_detail
#   
#   #add-point:單身複製後1

#   #end add-point
# 
#   #add-point:單身複製前

#   #end add-point
#   
#   #CREATE TEMP TABLE
#   LET ls_sql = 
#      "CREATE GLOBAL TEMPORARY TABLE axcq540_detail AS ",
#      "SELECT * FROM xcce_t "
#   PREPARE repro_tbl2 FROM ls_sql
#   EXECUTE repro_tbl2
#   FREE repro_tbl2
#      
#   #將符合條件的資料丟入TEMP TABLE
#   INSERT INTO axcq540_detail SELECT * FROM xcce_t
#                                         WHERE xcceent = g_enterprise AND xcceld = g_xccdld_t
#                                         AND xcce001 = g_xccd001_t
#                                         AND xcce003 = g_xccd003_t
#                                         AND xcce004 = g_xccd004_t
#                                         AND xcce005 = g_xccd005_t
# 
# 
#   #將key修正為調整後   
#   UPDATE axcq540_detail SET xcceld = g_xccd_m.xccdld
#                                       , xcce001 = g_xccd_m.xccd001
#                                       , xcce003 = g_xccd_m.xccd003
#                                       , xcce004 = g_xccd_m.xccd004
#                                       , xcce005 = g_xccd_m.xccd005
# 
#  
#   #將資料塞回原table   
#   INSERT INTO xcce_t SELECT * FROM axcq540_detail
#   
#   #add-point:單身複製中

#   #end add-point
#   
#   #刪除TEMP TABLE
#   DROP TABLE axcq540_detail
#   
#   #add-point:單身複製後

#   #end add-point
# 
#   #add-point:單身複製前

#   #end add-point
#   
#   #CREATE TEMP TABLE
#   LET ls_sql = 
#      "CREATE GLOBAL TEMPORARY TABLE axcq540_detail AS ",
#      "SELECT * FROM xcci_t "
#   PREPARE repro_tbl3 FROM ls_sql
#   EXECUTE repro_tbl3
#   FREE repro_tbl3
#      
#   #將符合條件的資料丟入TEMP TABLE
#   INSERT INTO axcq540_detail SELECT * FROM xcci_t
#                                         WHERE xccient = g_enterprise AND xccild = g_xccdld_t
#                                         AND xcci001 = g_xccd001_t
#                                         AND xcci003 = g_xccd003_t
#                                         AND xcci004 = g_xccd004_t
#                                         AND xcci005 = g_xccd005_t
# 
# 
#   #將key修正為調整後   
#   UPDATE axcq540_detail SET xccild = g_xccd_m.xccdld
#                                       , xcci001 = g_xccd_m.xccd001
#                                       , xcci003 = g_xccd_m.xccd003
#                                       , xcci004 = g_xccd_m.xccd004
#                                       , xcci005 = g_xccd_m.xccd005
# 
#  
#   #將資料塞回原table   
#   INSERT INTO xcci_t SELECT * FROM axcq540_detail
#   
#   #add-point:單身複製中

#   #end add-point
#   
#   #刪除TEMP TABLE
#   DROP TABLE axcq540_detail
#   
#   #add-point:單身複製後

#   #end add-point
# 
# 
#   
# 
#   
#   #多語言複製段落
#      #此段落由子樣板a38產生
#   #單身多語言複製
#   DROP TABLE axcq540_detail_lang
#   
#   #add-point:單身複製前1

#   #end add-point
#   
#   #CREATE TEMP TABLE
#   LET ls_sql = "CREATE GLOBAL TEMPORARY TABLE axcq540_detail_lang AS ",
#                "SELECT * FROM sfaa_t "
#   PREPARE repro_sfaa_t FROM ls_sql
#   EXECUTE repro_sfaa_t
#   FREE repro_sfaa_t
#                
#   #將符合條件的資料丟入TEMP TABLE
#   INSERT INTO axcq540_detail_lang SELECT * FROM sfaa_t 
#                                             WHERE sfaaent = g_enterprise AND sfaadocno = g_xccdld_t
#                                             AND  = g_xccd001_t                                             AND  = g_xccd003_t                                             AND  = g_xccd004_t                                             AND  = g_xccd005_t
#   
#   #將key修正為調整後   
#   UPDATE axcq540_detail_lang 
#      #更新key欄位
#      SET sfaadocno = g_xccd_m.xccdld
#          ,  = g_xccd_m.xccd001          ,  = g_xccd_m.xccd003          ,  = g_xccd_m.xccd004          ,  = g_xccd_m.xccd005
#  
#   #將資料塞回原table   
#   INSERT INTO sfaa_t SELECT * FROM axcq540_detail_lang
#   
#   IF SQLCA.sqlcode THEN
#      INITIALIZE g_errparam TO NULL 
#      LET g_errparam.extend = "reproduce" 
#      LET g_errparam.code   = SQLCA.sqlcode 
#      LET g_errparam.popup  = TRUE 
#      CALL cl_err()
# 
#      RETURN
#   END IF
#   
#   #add-point:單身複製中1

#   #end add-point
#   
#   #刪除TEMP TABLE
#   DROP TABLE axcq540_detail_lang
#   
#   #add-point:單身複製後1

#   #end add-point
# 
#   #此段落由子樣板a38產生
#   #單身多語言複製
#   DROP TABLE axcq540_detail_lang
#   
#   #add-point:單身複製前1

#   #end add-point
#   
#   #CREATE TEMP TABLE
#   LET ls_sql = "CREATE GLOBAL TEMPORARY TABLE axcq540_detail_lang AS ",
#                "SELECT * FROM xcce_t "
#   PREPARE repro_xcce_t FROM ls_sql
#   EXECUTE repro_xcce_t
#   FREE repro_xcce_t
#                
#   #將符合條件的資料丟入TEMP TABLE
#   INSERT INTO axcq540_detail_lang SELECT * FROM xcce_t 
#                                             WHERE xcceent = g_enterprise AND xcceld = g_xccdld_t
#                                             AND xcce001 = g_xccd001_t                                             AND xcce002 = g_xccd003_t                                             AND xcce003 = g_xccd004_t                                             AND xcce004 = g_xccd005_t
#   
#   #將key修正為調整後   
#   UPDATE axcq540_detail_lang 
#      #更新key欄位
#      SET xcceld = g_xccd_m.xccdld
#          , xcce001 = g_xccd_m.xccd001          , xcce002 = g_xccd_m.xccd003          , xcce003 = g_xccd_m.xccd004          , xcce004 = g_xccd_m.xccd005
#  
#   #將資料塞回原table   
#   INSERT INTO xcce_t SELECT * FROM axcq540_detail_lang
#   
#   IF SQLCA.sqlcode THEN
#      INITIALIZE g_errparam TO NULL 
#      LET g_errparam.extend = "reproduce" 
#      LET g_errparam.code   = SQLCA.sqlcode 
#      LET g_errparam.popup  = TRUE 
#      CALL cl_err()
# 
#      RETURN
#   END IF
#   
#   #add-point:單身複製中1

#   #end add-point
#   
#   #刪除TEMP TABLE
#   DROP TABLE axcq540_detail_lang
#   
#   #add-point:單身複製後1

#   #end add-point
# 
#   #此段落由子樣板a38產生
#   #單身多語言複製
#   DROP TABLE axcq540_detail_lang
#   
#   #add-point:單身複製前1

#   #end add-point
#   
#   #CREATE TEMP TABLE
#   LET ls_sql = "CREATE GLOBAL TEMPORARY TABLE axcq540_detail_lang AS ",
#                "SELECT * FROM xcbb_t "
#   PREPARE repro_xcbb_t FROM ls_sql
#   EXECUTE repro_xcbb_t
#   FREE repro_xcbb_t
#                
#   #將符合條件的資料丟入TEMP TABLE
#   INSERT INTO axcq540_detail_lang SELECT * FROM xcbb_t 
#                                             WHERE xcbbent = g_enterprise AND xcbbcomp = g_xccdld_t
#                                             AND xcbb001 = g_xccd001_t                                             AND xcbb002 = g_xccd003_t                                             AND xcbb003 = g_xccd004_t                                             AND xcbb004 = g_xccd005_t
#   
#   #將key修正為調整後   
#   UPDATE axcq540_detail_lang 
#      #更新key欄位
#      SET xcbbcomp = g_xccd_m.xccdld
#          , xcbb001 = g_xccd_m.xccd001          , xcbb002 = g_xccd_m.xccd003          , xcbb003 = g_xccd_m.xccd004          , xcbb004 = g_xccd_m.xccd005
#  
#   #將資料塞回原table   
#   INSERT INTO xcbb_t SELECT * FROM axcq540_detail_lang
#   
#   IF SQLCA.sqlcode THEN
#      INITIALIZE g_errparam TO NULL 
#      LET g_errparam.extend = "reproduce" 
#      LET g_errparam.code   = SQLCA.sqlcode 
#      LET g_errparam.popup  = TRUE 
#      CALL cl_err()
# 
#      RETURN
#   END IF
#   
#   #add-point:單身複製中1

#   #end add-point
#   
#   #刪除TEMP TABLE
#   DROP TABLE axcq540_detail_lang
#   
#   #add-point:單身複製後1

#   #end add-point
# 
# 
#   
#   CALL s_transaction_end('Y','0')
#   
#   #已新增完, 調整資料內容(修改時使用)
#   LET g_xccdld_t = g_xccd_m.xccdld
#   LET g_xccd001_t = g_xccd_m.xccd001
#   LET g_xccd003_t = g_xccd_m.xccd003
#   LET g_xccd004_t = g_xccd_m.xccd004
#   LET g_xccd005_t = g_xccd_m.xccd005
# 
#   
#   DROP TABLE axcq540_detail
   
END FUNCTION
 
{</section>}
 
{<section id="axcq540.delete" >}
#+ 資料刪除
PRIVATE FUNCTION axcq540_delete()
   DEFINE  l_var_keys      DYNAMIC ARRAY OF STRING
   DEFINE  l_field_keys    DYNAMIC ARRAY OF STRING
   DEFINE  l_vars          DYNAMIC ARRAY OF STRING
   DEFINE  l_fields        DYNAMIC ARRAY OF STRING
   DEFINE  l_var_keys_bak  DYNAMIC ARRAY OF STRING
   #add-point:delete段define

   #end add-point     
   
#   IF g_xccd_m.xccdld IS NULL
#   OR g_xccd_m.xccd001 IS NULL
#   OR g_xccd_m.xccd003 IS NULL
#   OR g_xccd_m.xccd004 IS NULL
#   OR g_xccd_m.xccd005 IS NULL
# 
#   THEN
#      INITIALIZE g_errparam TO NULL 
#      LET g_errparam.extend = "" 
#      LET g_errparam.code   = "std-00003" 
#      LET g_errparam.popup  = FALSE 
#      CALL cl_err()
#      RETURN
#   END IF
#   
#   
# 
#   CALL axcq540_show()
#   
#   CALL s_transaction_begin()
# 
#   OPEN axcq540_cl USING g_enterprise,g_xccd_m.xccdld,g_xccd_m.xccd001,g_xccd_m.xccd003,g_xccd_m.xccd004,g_xccd_m.xccd005
#   IF STATUS THEN
#      INITIALIZE g_errparam TO NULL 
#      LET g_errparam.extend = "OPEN axcq540_cl:" 
#      LET g_errparam.code   = STATUS 
#      LET g_errparam.popup  = TRUE 
#      CALL cl_err()
# 
#      CLOSE axcq540_cl
#      CALL s_transaction_end('N','0')
#      RETURN
#   END IF
# 
#   #顯示最新的資料
#   EXECUTE axcq540_master_referesh USING g_xccd_m.xccdld,g_xccd_m.xccd001,g_xccd_m.xccd003,g_xccd_m.xccd004, 
#       g_xccd_m.xccd005 INTO g_xccd_m.xccdcomp,g_xccd_m.xccdld,g_xccd_m.xccd004,g_xccd_m.xccd005,g_xccd_m.xccd001, 
#       g_xccd_m.xccd003,g_xccd_m.xccdcomp_desc,g_xccd_m.xccdld_desc,g_xccd_m.xccd003_desc
# 
#   IF SQLCA.sqlcode THEN
#      INITIALIZE g_errparam TO NULL 
#      LET g_errparam.extend = g_xccd_m.xccdld 
#      LET g_errparam.code   = SQLCA.sqlcode 
#      LET g_errparam.popup  = FALSE 
#      CALL cl_err()
#      CALL s_transaction_end('N','0')
#      RETURN
#   END IF
#   
#   #add-point:delete段before ask

#   #end add-point 
# 
#   IF cl_ask_del_master() THEN              #確認一下
#   
#      #add-point:單頭刪除前

#      #end add-point   
#      
#      #+ 此段落由子樣板a47產生
#      #刪除相關文件
#      CALL axcq540_set_pk_array()
#      #add-point:相關文件刪除前

#      #end add-point   
#      CALL cl_doc_remove()  
# 
#  
#  
#      #資料備份
#      LET g_xccdld_t = g_xccd_m.xccdld
#      LET g_xccd001_t = g_xccd_m.xccd001
#      LET g_xccd003_t = g_xccd_m.xccd003
#      LET g_xccd004_t = g_xccd_m.xccd004
#      LET g_xccd005_t = g_xccd_m.xccd005
# 
# 
#      DELETE FROM xccd_t
#       WHERE xccdent = g_enterprise AND xccdld = g_xccd_m.xccdld
#         AND xccd001 = g_xccd_m.xccd001
#         AND xccd003 = g_xccd_m.xccd003
#         AND xccd004 = g_xccd_m.xccd004
#         AND xccd005 = g_xccd_m.xccd005
# 
#       
#      #add-point:單頭刪除中

#      #end add-point
#       
#      IF SQLCA.sqlcode THEN
#         INITIALIZE g_errparam TO NULL 
#         LET g_errparam.extend = g_xccd_m.xccdld 
#         LET g_errparam.code   = SQLCA.sqlcode 
#         LET g_errparam.popup  = FALSE 
#         CALL cl_err()
# 
#         CALL s_transaction_end('N','0')
#         RETURN
#      END IF
#      
#      #add-point:單頭刪除後

#      #end add-point
#  
#      #add-point:單身刪除前

#      #end add-point
#      
#      DELETE FROM xccd_t
#       WHERE xccdent = g_enterprise AND  = g_xccd_m.xccdld
#         AND  = g_xccd_m.xccd001
#         AND  = g_xccd_m.xccd003
#         AND  = g_xccd_m.xccd004
#         AND  = g_xccd_m.xccd005
# 
# 
#      #add-point:單身刪除中

#      #end add-point
#         
#      IF SQLCA.sqlcode THEN
#         INITIALIZE g_errparam TO NULL 
#         LET g_errparam.extend = "xccd_t" 
#         LET g_errparam.code   = SQLCA.sqlcode 
#         LET g_errparam.popup  = FALSE 
#         CALL cl_err()
# 
#         CALL s_transaction_end('N','0')
#         RETURN
#      END IF    
# 
#      #add-point:單身刪除後

#      #end add-point
#      
#            
#                                                               
#      #add-point:單身刪除前

#      #end add-point
#      DELETE FROM xcce_t
#       WHERE xcceent = g_enterprise AND
#             xcceld = g_xccd_m.xccdld AND xcce001 = g_xccd_m.xccd001 AND xcce003 = g_xccd_m.xccd003 AND xcce004 = g_xccd_m.xccd004 AND xcce005 = g_xccd_m.xccd005
#      #add-point:單身刪除中

#      #end add-point
#      IF SQLCA.sqlcode THEN
#         INITIALIZE g_errparam TO NULL 
#         LET g_errparam.extend = "xcce_t" 
#         LET g_errparam.code   = SQLCA.sqlcode 
#         LET g_errparam.popup  = FALSE 
#         CALL cl_err()
# 
#         CALL s_transaction_end('N','0')
#         RETURN
#      END IF      
# 
#      #add-point:單身刪除後

#      #end add-point
# 
#      #add-point:單身刪除前

#      #end add-point
#      DELETE FROM xcci_t
#       WHERE xccient = g_enterprise AND
#             xccild = g_xccd_m.xccdld AND xcci001 = g_xccd_m.xccd001 AND xcci003 = g_xccd_m.xccd003 AND xcci004 = g_xccd_m.xccd004 AND xcci005 = g_xccd_m.xccd005
#      #add-point:單身刪除中

#      #end add-point
#      IF SQLCA.sqlcode THEN
#         INITIALIZE g_errparam TO NULL 
#         LET g_errparam.extend = "xcci_t" 
#         LET g_errparam.code   = SQLCA.sqlcode 
#         LET g_errparam.popup  = FALSE 
#         CALL cl_err()
# 
#         CALL s_transaction_end('N','0')
#         RETURN
#      END IF      
# 
#      #add-point:單身刪除後

#      #end add-point
# 
# 
# 
# 
#                                                               
#      CLEAR FORM
#      CALL g_xccd_d.clear() 
#      CALL g_xccd2_d.clear()       
#      CALL g_xccd3_d.clear()       
# 
#     
#      CALL axcq540_ui_browser_refresh()  
#      #CALL axcq540_ui_headershow()  
#      #CALL axcq540_ui_detailshow()
#      
#      IF g_browser_cnt > 0 THEN 
#         #CALL axcq540_browser_fill("")
#         CALL axcq540_fetch('P')
#         DISPLAY g_browser_cnt TO FORMONLY.h_count   #總筆數的顯示
#         DISPLAY g_browser_cnt TO FORMONLY.b_count   #總筆數的顯示
#      ELSE
#         #LET g_wc = " 1=2"
#         #CALL axcq540_browser_fill("F")
#         CLEAR FORM
#      END IF
# 
#      #add-point:多語言刪除

#      #end add-point
#      
#      #單頭多語言刪除
#      
#      
#      #單身多語言刪除
#      INITIALIZE l_var_keys_bak TO NULL 
#         INITIALIZE l_field_keys TO NULL 
#         LET l_field_keys[01] = 'xcbbcomp'
#         LET l_field_keys[02] = 'xcbb001'
#         LET l_field_keys[03] = 'xcbb002'
#         LET l_field_keys[04] = 'xcbb003'
#         LET l_field_keys[05] = 'xcbb004'
#         LET l_var_keys_bak[01] = g_detail_multi_table_t.xcbbcomp
#         LET l_var_keys_bak[02] = g_detail_multi_table_t.xcbb001
#         LET l_var_keys_bak[03] = g_detail_multi_table_t.xcbb002
#         LET l_var_keys_bak[04] = g_detail_multi_table_t.xcbb003
#         LET l_var_keys_bak[05] = g_detail_multi_table_t.xcbb004
#         CALL cl_multitable_delete(l_field_keys,l_var_keys_bak,'xcbb_t')
# 
#      
# 
#      
# 
# 
# 
#   
#      #add-point:多語言刪除

#      #end add-point
#   
#   END IF
# 
#   CALL s_transaction_end('Y','0')
#   
#   CLOSE axcq540_cl
# 
#   #流程通知預埋點-D
#   CALL cl_flow_notify(g_xccd_m.xccdld,'D')
    
END FUNCTION
 
{</section>}
 
{<section id="axcq540.b_fill" >}
#+ 單身陣列填充
PRIVATE FUNCTION axcq540_b_fill()
   DEFINE p_wc2      STRING
   #add-point:b_fill段define
   define l_cnt2     LIKE type_t.num10
   DEFINE l_xcce101_sum1           LIKE xcce_t.xcce101  #dorislai-20151021-add
   DEFINE l_xcce102a_sum1          LIKE xcce_t.xcce102a
   DEFINE l_xcce102b_sum1          LIKE xcce_t.xcce102b
   DEFINE l_xcce102c_sum1          LIKE xcce_t.xcce102c
   DEFINE l_xcce102d_sum1          LIKE xcce_t.xcce102d
   DEFINE l_xcce102e_sum1          LIKE xcce_t.xcce102e
   DEFINE l_xcce102f_sum1          LIKE xcce_t.xcce102f
   DEFINE l_xcce102g_sum1          LIKE xcce_t.xcce102g
   DEFINE l_xcce102h_sum1          LIKE xcce_t.xcce102h
   DEFINE l_xcce102_sum1           LIKE xcce_t.xcce102 
   DEFINE l_xcce201_sum1          LIKE xcce_t.xcce201   #dorislai-20151021-add
   DEFINE l_xcce202a_sum1          LIKE xcce_t.xcce202a
   DEFINE l_xcce202b_sum1          LIKE xcce_t.xcce202b
   DEFINE l_xcce202c_sum1          LIKE xcce_t.xcce202c
   DEFINE l_xcce202d_sum1          LIKE xcce_t.xcce202d
   DEFINE l_xcce202e_sum1          LIKE xcce_t.xcce202e
   DEFINE l_xcce202f_sum1          LIKE xcce_t.xcce202f
   DEFINE l_xcce202g_sum1          LIKE xcce_t.xcce202g
   DEFINE l_xcce202h_sum1          LIKE xcce_t.xcce202h
   DEFINE l_xcce202_sum1           LIKE xcce_t.xcce202 
   DEFINE l_xcce301_sum1           LIKE xcce_t.xcce301  #dorislai-20151021-add
   DEFINE l_xcce302a_sum1          LIKE xcce_t.xcce302a
   DEFINE l_xcce302b_sum1          LIKE xcce_t.xcce302b
   DEFINE l_xcce302c_sum1          LIKE xcce_t.xcce302c
   DEFINE l_xcce302d_sum1          LIKE xcce_t.xcce302d
   DEFINE l_xcce302e_sum1          LIKE xcce_t.xcce302e
   DEFINE l_xcce302f_sum1          LIKE xcce_t.xcce302f
   DEFINE l_xcce302g_sum1          LIKE xcce_t.xcce302g
   DEFINE l_xcce302h_sum1          LIKE xcce_t.xcce302h
   DEFINE l_xcce303_sum1           LIKE xcce_t.xcce303  #dorislai-20151021-add
   DEFINE l_xcce302_sum1           LIKE xcce_t.xcce302 
   DEFINE l_xcce304a_sum1          LIKE xcce_t.xcce304a
   DEFINE l_xcce304b_sum1          LIKE xcce_t.xcce304b
   DEFINE l_xcce304c_sum1          LIKE xcce_t.xcce304c
   DEFINE l_xcce304d_sum1          LIKE xcce_t.xcce304d
   DEFINE l_xcce304e_sum1          LIKE xcce_t.xcce304e
   DEFINE l_xcce304f_sum1          LIKE xcce_t.xcce304f
   DEFINE l_xcce304g_sum1          LIKE xcce_t.xcce304g
   DEFINE l_xcce304h_sum1          LIKE xcce_t.xcce304h
   DEFINE l_xcce304_sum1           LIKE xcce_t.xcce304 
   DEFINE l_xcce307_sum1           LIKE xcce_t.xcce307  #dorislai-20151021-add
   DEFINE l_xcce308a_sum1          LIKE xcce_t.xcce308a
   DEFINE l_xcce308b_sum1          LIKE xcce_t.xcce308b
   DEFINE l_xcce308c_sum1          LIKE xcce_t.xcce308c
   DEFINE l_xcce308d_sum1          LIKE xcce_t.xcce308d
   DEFINE l_xcce308e_sum1          LIKE xcce_t.xcce308e
   DEFINE l_xcce308f_sum1          LIKE xcce_t.xcce308f
   DEFINE l_xcce308g_sum1          LIKE xcce_t.xcce308g
   DEFINE l_xcce308h_sum1          LIKE xcce_t.xcce308h
   DEFINE l_xcce308_sum1           LIKE xcce_t.xcce308 
   DEFINE l_xcce901_sum1           LIKE xcce_t.xcce901  #dorislai-20151021-add
   DEFINE l_xcce902a_sum1          LIKE xcce_t.xcce902a
   DEFINE l_xcce902b_sum1          LIKE xcce_t.xcce902b
   DEFINE l_xcce902c_sum1          LIKE xcce_t.xcce902c
   DEFINE l_xcce902d_sum1          LIKE xcce_t.xcce902d
   DEFINE l_xcce902e_sum1          LIKE xcce_t.xcce902e
   DEFINE l_xcce902f_sum1          LIKE xcce_t.xcce902f
   DEFINE l_xcce902g_sum1          LIKE xcce_t.xcce902g
   DEFINE l_xcce902h_sum1          LIKE xcce_t.xcce902h
   DEFINE l_xcce902_sum1           LIKE xcce_t.xcce902 
   DEFINE l_xcce101_sum2           LIKE xcce_t.xcce101   #dorislai-20151021-add
   DEFINE l_xcce102a_sum2          LIKE xcce_t.xcce102a
   DEFINE l_xcce102b_sum2          LIKE xcce_t.xcce102b
   DEFINE l_xcce102c_sum2          LIKE xcce_t.xcce102c
   DEFINE l_xcce102d_sum2          LIKE xcce_t.xcce102d
   DEFINE l_xcce102e_sum2          LIKE xcce_t.xcce102e
   DEFINE l_xcce102f_sum2          LIKE xcce_t.xcce102f
   DEFINE l_xcce102g_sum2          LIKE xcce_t.xcce102g
   DEFINE l_xcce102h_sum2          LIKE xcce_t.xcce102h
   DEFINE l_xcce102_sum2           LIKE xcce_t.xcce102 
   DEFINE l_xcce201_sum2           LIKE xcce_t.xcce201  #dorislai-20151021-add
   DEFINE l_xcce202a_sum2          LIKE xcce_t.xcce202a
   DEFINE l_xcce202b_sum2          LIKE xcce_t.xcce202b
   DEFINE l_xcce202c_sum2          LIKE xcce_t.xcce202c
   DEFINE l_xcce202d_sum2          LIKE xcce_t.xcce202d
   DEFINE l_xcce202e_sum2          LIKE xcce_t.xcce202e
   DEFINE l_xcce202f_sum2          LIKE xcce_t.xcce202f
   DEFINE l_xcce202g_sum2          LIKE xcce_t.xcce202g
   DEFINE l_xcce202h_sum2          LIKE xcce_t.xcce202h
   DEFINE l_xcce202_sum2           LIKE xcce_t.xcce202 
   DEFINE l_xcce301_sum2           LIKE xcce_t.xcce301  #dorislai-20151021-add
   DEFINE l_xcce302a_sum2          LIKE xcce_t.xcce302a
   DEFINE l_xcce302b_sum2          LIKE xcce_t.xcce302b
   DEFINE l_xcce302c_sum2          LIKE xcce_t.xcce302c
   DEFINE l_xcce302d_sum2          LIKE xcce_t.xcce302d
   DEFINE l_xcce302e_sum2          LIKE xcce_t.xcce302e
   DEFINE l_xcce302f_sum2          LIKE xcce_t.xcce302f
   DEFINE l_xcce302g_sum2          LIKE xcce_t.xcce302g
   DEFINE l_xcce302h_sum2          LIKE xcce_t.xcce302h
   DEFINE l_xcce302_sum2           LIKE xcce_t.xcce302 
   DEFINE l_xcce303_sum2           LIKE xcce_t.xcce303  #dorislai-20151021-add
   DEFINE l_xcce304a_sum2          LIKE xcce_t.xcce304a
   DEFINE l_xcce304b_sum2          LIKE xcce_t.xcce304b
   DEFINE l_xcce304c_sum2          LIKE xcce_t.xcce304c
   DEFINE l_xcce304d_sum2          LIKE xcce_t.xcce304d
   DEFINE l_xcce304e_sum2          LIKE xcce_t.xcce304e
   DEFINE l_xcce304f_sum2          LIKE xcce_t.xcce304f
   DEFINE l_xcce304g_sum2          LIKE xcce_t.xcce304g
   DEFINE l_xcce304h_sum2          LIKE xcce_t.xcce304h
   DEFINE l_xcce304_sum2           LIKE xcce_t.xcce304 
   DEFINE l_xcce307_sum2           LIKE xcce_t.xcce307  #dorislai-20151021-add
   DEFINE l_xcce308a_sum2          LIKE xcce_t.xcce308a
   DEFINE l_xcce308b_sum2          LIKE xcce_t.xcce308b
   DEFINE l_xcce308c_sum2          LIKE xcce_t.xcce308c
   DEFINE l_xcce308d_sum2          LIKE xcce_t.xcce308d
   DEFINE l_xcce308e_sum2          LIKE xcce_t.xcce308e
   DEFINE l_xcce308f_sum2          LIKE xcce_t.xcce308f
   DEFINE l_xcce308g_sum2          LIKE xcce_t.xcce308g
   DEFINE l_xcce308h_sum2          LIKE xcce_t.xcce308h
   DEFINE l_xcce308_sum2           LIKE xcce_t.xcce308 
   DEFINE l_xcce901_sum2           LIKE xcce_t.xcce901  #dorislai-20151021-add
   DEFINE l_xcce902a_sum2          LIKE xcce_t.xcce902a
   DEFINE l_xcce902b_sum2          LIKE xcce_t.xcce902b
   DEFINE l_xcce902c_sum2          LIKE xcce_t.xcce902c
   DEFINE l_xcce902d_sum2          LIKE xcce_t.xcce902d
   DEFINE l_xcce902e_sum2          LIKE xcce_t.xcce902e
   DEFINE l_xcce902f_sum2          LIKE xcce_t.xcce902f
   DEFINE l_xcce902g_sum2          LIKE xcce_t.xcce902g
   DEFINE l_xcce902h_sum2          LIKE xcce_t.xcce902h
   DEFINE l_xcce902_sum2           LIKE xcce_t.xcce902 
   DEFINE l_xcce101_total           LIKE xcce_t.xcce101  #dorislai-20151021-add
   DEFINE l_xcce102a_total          LIKE xcce_t.xcce102a
   DEFINE l_xcce102b_total          LIKE xcce_t.xcce102b
   DEFINE l_xcce102c_total          LIKE xcce_t.xcce102c
   DEFINE l_xcce102d_total          LIKE xcce_t.xcce102d
   DEFINE l_xcce102e_total          LIKE xcce_t.xcce102e
   DEFINE l_xcce102f_total          LIKE xcce_t.xcce102f
   DEFINE l_xcce102g_total          LIKE xcce_t.xcce102g
   DEFINE l_xcce102h_total          LIKE xcce_t.xcce102h
   DEFINE l_xcce102_total           LIKE xcce_t.xcce102 
   DEFINE l_xcce201_total           LIKE xcce_t.xcce201  #dorislai-20151021-add
   DEFINE l_xcce202a_total          LIKE xcce_t.xcce202a
   DEFINE l_xcce202b_total          LIKE xcce_t.xcce202b
   DEFINE l_xcce202c_total          LIKE xcce_t.xcce202c
   DEFINE l_xcce202d_total          LIKE xcce_t.xcce202d
   DEFINE l_xcce202e_total          LIKE xcce_t.xcce202e
   DEFINE l_xcce202f_total          LIKE xcce_t.xcce202f
   DEFINE l_xcce202g_total          LIKE xcce_t.xcce202g
   DEFINE l_xcce202h_total          LIKE xcce_t.xcce202h
   DEFINE l_xcce202_total           LIKE xcce_t.xcce202 
   DEFINE l_xcce301_total           LIKE xcce_t.xcce301   #dorislai-20151021-add
   DEFINE l_xcce302a_total          LIKE xcce_t.xcce302a
   DEFINE l_xcce302b_total          LIKE xcce_t.xcce302b
   DEFINE l_xcce302c_total          LIKE xcce_t.xcce302c
   DEFINE l_xcce302d_total          LIKE xcce_t.xcce302d
   DEFINE l_xcce302e_total          LIKE xcce_t.xcce302e
   DEFINE l_xcce302f_total          LIKE xcce_t.xcce302f
   DEFINE l_xcce302g_total          LIKE xcce_t.xcce302g
   DEFINE l_xcce302h_total          LIKE xcce_t.xcce302h
   DEFINE l_xcce302_total           LIKE xcce_t.xcce302 
   DEFINE l_xcce303_total           LIKE xcce_t.xcce303   #dorislai-20151021-add
   DEFINE l_xcce304a_total          LIKE xcce_t.xcce304a
   DEFINE l_xcce304b_total          LIKE xcce_t.xcce304b
   DEFINE l_xcce304c_total          LIKE xcce_t.xcce304c
   DEFINE l_xcce304d_total          LIKE xcce_t.xcce304d
   DEFINE l_xcce304e_total          LIKE xcce_t.xcce304e
   DEFINE l_xcce304f_total          LIKE xcce_t.xcce304f
   DEFINE l_xcce304g_total          LIKE xcce_t.xcce304g
   DEFINE l_xcce304h_total          LIKE xcce_t.xcce304h
   DEFINE l_xcce304_total           LIKE xcce_t.xcce304 
   DEFINE l_xcce307_total           LIKE xcce_t.xcce307   #dorislai-20151021-add
   DEFINE l_xcce308a_total          LIKE xcce_t.xcce308a
   DEFINE l_xcce308b_total          LIKE xcce_t.xcce308b
   DEFINE l_xcce308c_total          LIKE xcce_t.xcce308c
   DEFINE l_xcce308d_total          LIKE xcce_t.xcce308d
   DEFINE l_xcce308e_total          LIKE xcce_t.xcce308e
   DEFINE l_xcce308f_total          LIKE xcce_t.xcce308f
   DEFINE l_xcce308g_total          LIKE xcce_t.xcce308g
   DEFINE l_xcce308h_total          LIKE xcce_t.xcce308h
   DEFINE l_xcce308_total           LIKE xcce_t.xcce308 
   DEFINE l_xcce901_total           LIKE xcce_t.xcce901   #dorislai-20151021-add
   DEFINE l_xcce902a_total          LIKE xcce_t.xcce902a
   DEFINE l_xcce902b_total          LIKE xcce_t.xcce902b
   DEFINE l_xcce902c_total          LIKE xcce_t.xcce902c
   DEFINE l_xcce902d_total          LIKE xcce_t.xcce902d
   DEFINE l_xcce902e_total          LIKE xcce_t.xcce902e
   DEFINE l_xcce902f_total          LIKE xcce_t.xcce902f
   DEFINE l_xcce902g_total          LIKE xcce_t.xcce902g
   DEFINE l_xcce902h_total          LIKE xcce_t.xcce902h
   DEFINE l_xcce902_total           LIKE xcce_t.xcce902 
   DEFINE l_xcci101_sum1           LIKE xcci_t.xcci101   #dorislai-20151021-add
   DEFINE l_xcci102a_sum1          LIKE xcci_t.xcci102a
   DEFINE l_xcci102b_sum1          LIKE xcci_t.xcci102b
   DEFINE l_xcci102c_sum1          LIKE xcci_t.xcci102c
   DEFINE l_xcci102d_sum1          LIKE xcci_t.xcci102d
   DEFINE l_xcci102e_sum1          LIKE xcci_t.xcci102e
   DEFINE l_xcci102f_sum1          LIKE xcci_t.xcci102f
   DEFINE l_xcci102g_sum1          LIKE xcci_t.xcci102g
   DEFINE l_xcci102h_sum1          LIKE xcci_t.xcci102h
   DEFINE l_xcci102_sum1           LIKE xcci_t.xcci102
   DEFINE l_xcci201_sum1           LIKE xcci_t.xcci201   #dorislai-20151021-add
   DEFINE l_xcci202a_sum1          LIKE xcci_t.xcci202a   
   DEFINE l_xcci202b_sum1          LIKE xcci_t.xcci202b
   DEFINE l_xcci202c_sum1          LIKE xcci_t.xcci202c
   DEFINE l_xcci202d_sum1          LIKE xcci_t.xcci202d
   DEFINE l_xcci202e_sum1          LIKE xcci_t.xcci202e
   DEFINE l_xcci202f_sum1          LIKE xcci_t.xcci202f
   DEFINE l_xcci202g_sum1          LIKE xcci_t.xcci202g
   DEFINE l_xcci202h_sum1          LIKE xcci_t.xcci202h
   DEFINE l_xcci202_sum1           LIKE xcci_t.xcci202 
   DEFINE l_xcci301_sum1           LIKE xcci_t.xcci301   #dorislai-20151021-add
   DEFINE l_xcci302a_sum1          LIKE xcci_t.xcci302a
   DEFINE l_xcci302b_sum1          LIKE xcci_t.xcci302b
   DEFINE l_xcci302c_sum1          LIKE xcci_t.xcci302c
   DEFINE l_xcci302d_sum1          LIKE xcci_t.xcci302d
   DEFINE l_xcci302e_sum1          LIKE xcci_t.xcci302e
   DEFINE l_xcci302f_sum1          LIKE xcci_t.xcci302f
   DEFINE l_xcci302g_sum1          LIKE xcci_t.xcci302g
   DEFINE l_xcci302h_sum1          LIKE xcci_t.xcci302h
   DEFINE l_xcci302_sum1           LIKE xcci_t.xcci302 
   DEFINE l_xcci303_sum1           LIKE xcci_t.xcci303   #dorislai-20151021-add
   DEFINE l_xcci304a_sum1          LIKE xcci_t.xcci304a
   DEFINE l_xcci304b_sum1          LIKE xcci_t.xcci304b
   DEFINE l_xcci304c_sum1          LIKE xcci_t.xcci304c
   DEFINE l_xcci304d_sum1          LIKE xcci_t.xcci304d
   DEFINE l_xcci304e_sum1          LIKE xcci_t.xcci304e
   DEFINE l_xcci304f_sum1          LIKE xcci_t.xcci304f
   DEFINE l_xcci304g_sum1          LIKE xcci_t.xcci304g
   DEFINE l_xcci304h_sum1          LIKE xcci_t.xcci304h
   DEFINE l_xcci304_sum1           LIKE xcci_t.xcci304  
   DEFINE l_xcci901_sum1           LIKE xcci_t.xcci901   #dorislai-20151021-add
   DEFINE l_xcci902a_sum1          LIKE xcci_t.xcci902a
   DEFINE l_xcci902b_sum1          LIKE xcci_t.xcci902b
   DEFINE l_xcci902c_sum1          LIKE xcci_t.xcci902c
   DEFINE l_xcci902d_sum1          LIKE xcci_t.xcci902d
   DEFINE l_xcci902e_sum1          LIKE xcci_t.xcci902e
   DEFINE l_xcci902f_sum1          LIKE xcci_t.xcci902f
   DEFINE l_xcci902g_sum1          LIKE xcci_t.xcci902g
   DEFINE l_xcci902h_sum1          LIKE xcci_t.xcci902h
   DEFINE l_xcci902_sum1           LIKE xcci_t.xcci902 
   DEFINE l_xcci101_sum2           LIKE xcci_t.xcci101   #dorislai-20151021-add
   DEFINE l_xcci102a_sum2          LIKE xcci_t.xcci102a
   DEFINE l_xcci102b_sum2          LIKE xcci_t.xcci102b
   DEFINE l_xcci102c_sum2          LIKE xcci_t.xcci102c
   DEFINE l_xcci102d_sum2          LIKE xcci_t.xcci102d
   DEFINE l_xcci102e_sum2          LIKE xcci_t.xcci102e
   DEFINE l_xcci102f_sum2          LIKE xcci_t.xcci102f
   DEFINE l_xcci102g_sum2          LIKE xcci_t.xcci102g
   DEFINE l_xcci102h_sum2          LIKE xcci_t.xcci102h
   DEFINE l_xcci102_sum2           LIKE xcci_t.xcci102 
   DEFINE l_xcci201_sum2           LIKE xcci_t.xcci201   #dorislai-20151021-add
   DEFINE l_xcci202a_sum2          LIKE xcci_t.xcci202a
   DEFINE l_xcci202b_sum2          LIKE xcci_t.xcci202b
   DEFINE l_xcci202c_sum2          LIKE xcci_t.xcci202c
   DEFINE l_xcci202d_sum2          LIKE xcci_t.xcci202d
   DEFINE l_xcci202e_sum2          LIKE xcci_t.xcci202e
   DEFINE l_xcci202f_sum2          LIKE xcci_t.xcci202f
   DEFINE l_xcci202g_sum2          LIKE xcci_t.xcci202g
   DEFINE l_xcci202h_sum2          LIKE xcci_t.xcci202h
   DEFINE l_xcci202_sum2           LIKE xcci_t.xcci202 
   DEFINE l_xcci301_sum2           LIKE xcci_t.xcci301   #dorislai-20151021-add
   DEFINE l_xcci302a_sum2          LIKE xcci_t.xcci302a
   DEFINE l_xcci302b_sum2          LIKE xcci_t.xcci302b
   DEFINE l_xcci302c_sum2          LIKE xcci_t.xcci302c
   DEFINE l_xcci302d_sum2          LIKE xcci_t.xcci302d
   DEFINE l_xcci302e_sum2          LIKE xcci_t.xcci302e
   DEFINE l_xcci302f_sum2          LIKE xcci_t.xcci302f
   DEFINE l_xcci302g_sum2          LIKE xcci_t.xcci302g
   DEFINE l_xcci302h_sum2          LIKE xcci_t.xcci302h
   DEFINE l_xcci302_sum2           LIKE xcci_t.xcci302 
   DEFINE l_xcci303_sum2           LIKE xcci_t.xcci303   #dorislai-20151021-add
   DEFINE l_xcci304a_sum2          LIKE xcci_t.xcci304a
   DEFINE l_xcci304b_sum2          LIKE xcci_t.xcci304b
   DEFINE l_xcci304c_sum2          LIKE xcci_t.xcci304c
   DEFINE l_xcci304d_sum2          LIKE xcci_t.xcci304d
   DEFINE l_xcci304e_sum2          LIKE xcci_t.xcci304e
   DEFINE l_xcci304f_sum2          LIKE xcci_t.xcci304f
   DEFINE l_xcci304g_sum2          LIKE xcci_t.xcci304g
   DEFINE l_xcci304h_sum2          LIKE xcci_t.xcci304h
   DEFINE l_xcci304_sum2           LIKE xcci_t.xcci304  
   DEFINE l_xcci901_sum2           LIKE xcci_t.xcci901   #dorislai-20151021-add
   DEFINE l_xcci902a_sum2          LIKE xcci_t.xcci902a
   DEFINE l_xcci902b_sum2          LIKE xcci_t.xcci902b
   DEFINE l_xcci902c_sum2          LIKE xcci_t.xcci902c
   DEFINE l_xcci902d_sum2          LIKE xcci_t.xcci902d
   DEFINE l_xcci902e_sum2          LIKE xcci_t.xcci902e
   DEFINE l_xcci902f_sum2          LIKE xcci_t.xcci902f
   DEFINE l_xcci902g_sum2          LIKE xcci_t.xcci902g
   DEFINE l_xcci902h_sum2          LIKE xcci_t.xcci902h
   DEFINE l_xcci902_sum2           LIKE xcci_t.xcci902 
   DEFINE l_xcci101_total           LIKE xcci_t.xcci101   #dorislai-20151021-add
   DEFINE l_xcci102a_total          LIKE xcci_t.xcci102a
   DEFINE l_xcci102b_total          LIKE xcci_t.xcci102b
   DEFINE l_xcci102c_total          LIKE xcci_t.xcci102c
   DEFINE l_xcci102d_total          LIKE xcci_t.xcci102d
   DEFINE l_xcci102e_total          LIKE xcci_t.xcci102e
   DEFINE l_xcci102f_total          LIKE xcci_t.xcci102f
   DEFINE l_xcci102g_total          LIKE xcci_t.xcci102g
   DEFINE l_xcci102h_total          LIKE xcci_t.xcci102h
   DEFINE l_xcci102_total           LIKE xcci_t.xcci102 
   DEFINE l_xcci201_total           LIKE xcci_t.xcci201  #dorislai-20151021-add
   DEFINE l_xcci202a_total          LIKE xcci_t.xcci202a
   DEFINE l_xcci202b_total          LIKE xcci_t.xcci202b
   DEFINE l_xcci202c_total          LIKE xcci_t.xcci202c
   DEFINE l_xcci202d_total          LIKE xcci_t.xcci202d
   DEFINE l_xcci202e_total          LIKE xcci_t.xcci202e
   DEFINE l_xcci202f_total          LIKE xcci_t.xcci202f
   DEFINE l_xcci202g_total          LIKE xcci_t.xcci202g
   DEFINE l_xcci202h_total          LIKE xcci_t.xcci202h
   DEFINE l_xcci202_total           LIKE xcci_t.xcci202 
   DEFINE l_xcci301_total           LIKE xcci_t.xcci301  #dorislai-20151021-add
   DEFINE l_xcci302a_total          LIKE xcci_t.xcci302a
   DEFINE l_xcci302b_total          LIKE xcci_t.xcci302b
   DEFINE l_xcci302c_total          LIKE xcci_t.xcci302c
   DEFINE l_xcci302d_total          LIKE xcci_t.xcci302d
   DEFINE l_xcci302e_total          LIKE xcci_t.xcci302e
   DEFINE l_xcci302f_total          LIKE xcci_t.xcci302f
   DEFINE l_xcci302g_total          LIKE xcci_t.xcci302g
   DEFINE l_xcci302h_total          LIKE xcci_t.xcci302h
   DEFINE l_xcci302_total           LIKE xcci_t.xcci302 
   DEFINE l_xcci303_total           LIKE xcci_t.xcci303  #dorislai-20151021-add
   DEFINE l_xcci304a_total          LIKE xcci_t.xcci304a
   DEFINE l_xcci304b_total          LIKE xcci_t.xcci304b
   DEFINE l_xcci304c_total          LIKE xcci_t.xcci304c
   DEFINE l_xcci304d_total          LIKE xcci_t.xcci304d
   DEFINE l_xcci304e_total          LIKE xcci_t.xcci304e
   DEFINE l_xcci304f_total          LIKE xcci_t.xcci304f
   DEFINE l_xcci304g_total          LIKE xcci_t.xcci304g
   DEFINE l_xcci304h_total          LIKE xcci_t.xcci304h
   DEFINE l_xcci304_total           LIKE xcci_t.xcci304  
   DEFINE l_xcci901_total           LIKE xcci_t.xcci901  #dorislai-20151021-add
   DEFINE l_xcci902a_total          LIKE xcci_t.xcci902a
   DEFINE l_xcci902b_total          LIKE xcci_t.xcci902b
   DEFINE l_xcci902c_total          LIKE xcci_t.xcci902c
   DEFINE l_xcci902d_total          LIKE xcci_t.xcci902d
   DEFINE l_xcci902e_total          LIKE xcci_t.xcci902e
   DEFINE l_xcci902f_total          LIKE xcci_t.xcci902f
   DEFINE l_xcci902g_total          LIKE xcci_t.xcci902g
   DEFINE l_xcci902h_total          LIKE xcci_t.xcci902h
   DEFINE l_xcci902_total           LIKE xcci_t.xcci902 
   DEFINE l_merge_qc                STRING  #fengmy150813 
   DEFINE l_merge_qm                STRING  #fengmy150813
   #end add-point     
 
   CALL g_xccd_d.clear()    #g_xccd_d 單頭及單身 
   CALL g_xccd2_d.clear()
   CALL g_xccd3_d.clear()
 
 
   #add-point:b_fill段sql_before
#这只作业是关于xccd的假双挡，单身是单号+成本域，但是如果按照这个逻辑产生单身，会有问题
#举例来说，相同单号可以有不同料号，如果以原来的假双挡的两个栏位来区分每一笔单身，这种情况是处理不了的
#解决办法，以单头xccd栏位的g_wc为条件，去xcce/xccj抓资料，union起来，抛进一个临时表，再从临时表以组织和单号为排序填充到单身

   IF NOT axcq540_cre_tmp_table() THEN RETURN END IF
   #fengmy150813----mark------begin
#   LET g_sql = " INSERT INTO axcq540_tmp02 ",   #第二单身的临时表
#                 "  SELECT UNIQUE sfaa068,'',xcce006,xccd007,xccd008,xccd301,xcce007,'','',xcce008,xcce009,xcbb005,'',xcce002,xcce101,xcce102a,xcce102b,xcce102c,xcce102d,xcce102e,",   #add xccd007 fengmy150303    #add xccd008 liuym150810
#                 "         xcce102f,xcce102g,xcce102h,xcce102,xcce201+xcce205+xcce207+xcce209 xcce201,xcce202a+xcce206a+xcce208a+xcce210a xcce202a,xcce202b+xcce206b+xcce208b+xcce210b xcce202b,",
#                 "         xcce202c+xcce206c+xcce208c+xcce210c xcce202c,xcce202d+xcce206d+xcce208d+xcce210d xcce202d,xcce202e+xcce206e+xcce208e+xcce210e xcce202e,xcce202f+xcce206f+xcce208f+xcce210f xcce202f,",
#                 "         xcce202g+xcce206g+xcce208g+xcce210g xcce202g,xcce202h+xcce206h+xcce208h+xcce210h xcce202h,xcce202+xcce206+xcce208+xcce210 xcce202,xcce301,xcce302a,xcce302b,xcce302c,xcce302d,",
#                 "         xcce302e,xcce302f,xcce302g,xcce302h,xcce302,xcce303,xcce304a,xcce304b,xcce304c,xcce304d,xcce304e,xcce304f,xcce304g,xcce304h,xcce304,xcce307,xcce308a,",
#                 "         xcce308b,xcce308c,xcce308d,xcce308e,xcce308f,xcce308g,xcce308h,xcce308,xcce901,xcce902a,xcce902b,xcce902c,xcce902d,xcce902e,xcce902f,xcce902g,xcce902h,xcce902 ",
##                 "    FROM xcce_t LEFT JOIN sfaa_t ON sfaaent = xcceent AND sfaadocno = xcce006 ",   #fengmy150303 mark
#                 #fengmy150303----begin
#                 "    FROM xcce_t                      ",
#                 "        LEFT JOIN xccd_t ON xccdent = xcceent AND xccd006 = xcce006 AND xccd002 = xcce002 ",
#                 "                         AND xccdld = xcceld AND xccd001 = xcce001 AND xccd003 = xcce003 AND xccd004 = xcce004 AND xccd005 = xcce005 ",
#                 "        LEFT JOIN sfaa_t ON sfaaent = xcceent AND sfaadocno = xcce006 ", 
#                 #fengmy150303----end
#                 "                LEFT JOIN xcbb_t ON xcbbent = xcceent AND xcbbcomp = xccecomp AND xcbb001 = xcce004 AND xcbb002 = xcce005 ",
#                 "                                                      AND xcbb003 = xcce007 AND xcbb004 = xcce008 ",
#                 "   WHERE xcceent  = '",g_enterprise,"'",
#                 "     AND xccecomp = '",g_xccd_m.xccdcomp,"'",
#                 "     AND xcceld   = '",g_xccd_m.xccdld,"'",
#                 "     AND xcce001  = '",g_xccd_m.xccd001,"'",
#                 "     AND xcce003  = '",g_xccd_m.xccd003,"'",
#                 "     AND xcce004  = '",g_xccd_m.xccd004,"'",  
#                 "     AND xcce005  = '",g_xccd_m.xccd005,"'"  
     #fengmy150215----begin
     #fengmy150813----mark------end
     LET g_wc =cl_replace_str(g_wc,"xcch","xccd")  #dorislai-20151021-add g_wc的條件需換回來，才不會產生錯誤
     #fengmy150813-----跨年期查询------begin
     LET g_sql = " INSERT INTO axcq540_tmp02 ",   #第二单身的临时表
                 "  SELECT sfaa068,'',xcce006,xccd007,xccd008,xccd301,xcce007,'','',xcce008,xcce009,xcbb005,'',xcce002,0,0,0,0,0,0,",   #add xccd007 fengmy150303    #add xccd008 liuym150810
                 "         0,0,0,0,SUM(xcce201+xcce205+xcce207+xcce209) xcce201,SUM(xcce202a+xcce206a+xcce208a+xcce210a) xcce202a,SUM(xcce202b+xcce206b+xcce208b+xcce210b) xcce202b,",
                 "         SUM(xcce202c+xcce206c+xcce208c+xcce210c) xcce202c,SUM(xcce202d+xcce206d+xcce208d+xcce210d) xcce202d,SUM(xcce202e+xcce206e+xcce208e+xcce210e) xcce202e,SUM(xcce202f+xcce206f+xcce208f+xcce210f) xcce202f,",
                 "         SUM(xcce202g+xcce206g+xcce208g+xcce210g) xcce202g,SUM(xcce202h+xcce206h+xcce208h+xcce210h) xcce202h,SUM(xcce202+xcce206+xcce208+xcce210) xcce202,SUM(xcce301),SUM(xcce302a),SUM(xcce302b),SUM(xcce302c),SUM(xcce302d),",
                 "         SUM(xcce302e),SUM(xcce302f),SUM(xcce302g),SUM(xcce302h),SUM(xcce302),SUM(xcce303),SUM(xcce304a),SUM(xcce304b),SUM(xcce304c),SUM(xcce304d),SUM(xcce304e),SUM(xcce304f),SUM(xcce304g),SUM(xcce304h),SUM(xcce304),SUM(xcce307),SUM(xcce308a),",
                 "         SUM(xcce308b),SUM(xcce308c),SUM(xcce308d),SUM(xcce308e),SUM(xcce308f),SUM(xcce308g),SUM(xcce308h),SUM(xcce308),0,0,0,0,0,0,0,0,0,0 ",
#                 "    FROM xcce_t LEFT JOIN sfaa_t ON sfaaent = xcceent AND sfaadocno = xcce006 ",   #fengmy150303 mark
                 #fengmy150303----begin
                 "    FROM xcce_t                      ",
                #"        LEFT JOIN xccd_t ON xccdent = xcceent AND xccd006 = xcce006 AND xccd002 = xcce002 ",   #160813-00002#1 mark
                 "        LEFT JOIN xccd_t ON xccdent = xcceent AND xccd006 = xcce006 ",                         #160813-00002#1 add
                 "                         AND xccdld = xcceld AND xccd001 = xcce001 AND xccd003 = xcce003 AND xccd004 = xcce004 AND xccd005 = xcce005 ",
                 "        LEFT JOIN sfaa_t ON sfaaent = xcceent AND sfaadocno = xcce006 ", 
                 #fengmy150303----end
                 "                LEFT JOIN xcbb_t ON xcbbent = xcceent AND xcbbcomp = xccecomp AND xcbb001 = xcce004 AND xcbb002 = xcce005 ",
                 "                                                      AND xcbb003 = xcce007 AND xcbb004 = xcce008 ",
                 "   WHERE xcceent  = '",g_enterprise,"'",
                 "     AND xcceld   = '",g_xccd_m.xccdld,"'",
                 "     AND xcce001  = '",g_xccd_m.xccd001,"'",
                 "     AND xcce003  = '",g_xccd_m.xccd003,"'",
                 "     AND ",g_wc #,   #2015/10/16 by stellar mark,
                 #"     GROUP BY sfaa068,xcce006,xccd007,xccd008,xcce007,xcce008,xcce009,xcbb005,xcce002 "   #2015/10/16 by stellar mark              
     #fengmy150813-----跨年期查询------end 
     IF g_wc2 <> " 1=1" THEN
        LET g_wc2=cl_replace_str(g_wc2,"xccd","xcce")
        LET g_wc2=cl_replace_str(g_wc2,"xcci","xcce")
        LET g_sql = g_sql CLIPPED," AND ",g_wc2
     END IF
     #fengmy150215----end  
     #fengmy150304----begin
     IF g_wc3 <> " 1=1" THEN
        LET g_wc3=cl_replace_str(g_wc3,"xcch","xccd")
        LET g_sql = g_sql CLIPPED," AND ",g_wc3
     END IF
     #fengmy150304----end  
     #151130-00003#2--add--(s)
     IF g_wc_filter <> " 1=1" THEN
        LET g_wc_filter = cl_replace_str(g_wc_filter,"xccd","xcce")
        LET g_wc_filter = cl_replace_str(g_wc_filter,"xcci","xcce")
        LET g_sql = g_sql CLIPPED," AND ",g_wc_filter
     END IF  
     IF g_wc_filter2 <> " 1=1" THEN
        LET g_wc_filter2 = cl_replace_str(g_wc_filter2,"xccd","xcce")
        LET g_wc_filter2 = cl_replace_str(g_wc_filter2,"xcci","xcce")
        LET g_sql = g_sql CLIPPED," AND ",g_wc_filter2
     END IF       
     IF g_wc_filter3 <> " 1=1" THEN
        LET g_wc_filter3 = cl_replace_str(g_wc_filter3,"xccd","xcce")
        LET g_wc_filter3 = cl_replace_str(g_wc_filter3,"xcci","xcce")
        LET g_sql = g_sql CLIPPED," AND ",g_wc_filter3
     END IF       
     #151130-00003#2--add--(e)
     
     #2015/10/16 by stellar add ----- (S)
     LET g_sql = g_sql CLIPPED, #160106-00012#1-add-'xccd301'
                 " GROUP BY sfaa068,xcce006,xccd007,xccd008,xccd301,xcce007,xcce008,xcce009,xcbb005,xcce002 "
     #2015/10/16 by stellar add ----- (E)

     LET g_sql = cl_sql_add_mask(g_sql)  
     
     PREPARE axcq540_ins_tmp02 FROM g_sql

     EXECUTE axcq540_ins_tmp02

     IF SQLCA.sqlcode THEN
        INITIALIZE g_errparam TO NULL 
        LET g_errparam.extend = "ins tmp02" 
        LET g_errparam.code   = SQLCA.sqlcode 
        LET g_errparam.popup  = TRUE 
        CALL cl_err()
 
        RETURN
     END IF

#fengmy150813-----begin
   LET l_merge_qc =                  
       " MERGE INTO axcq540_tmp02 t0 ",
       "      USING (SELECT xcce002,xcce006,xcce007,xcce008,xcce009,xcce101,xcce102, ", 
       "                    xcce102a,xcce102b,xcce102c,xcce102d,xcce102e,xcce102f,xcce102g,xcce102h ",
       "               FROM xcce_t ",
       "              WHERE xcceent  = '",g_enterprise,"'",
       "                AND xcceld   = '",g_xccd_m.xccdld,"'",
       "                AND xcce001  = '",g_xccd_m.xccd001,"'",
       "                AND xcce003  = '",g_xccd_m.xccd003,"'",
       "                AND xcce004 = '",g_yy1,"' AND xcce005 = '",g_mm1,"' ) tqc",          
       "      ON ( t0.xcce002 = tqc.xcce002 AND t0.xcce006 = tqc.xcce006
                  AND t0.xcce007 = tqc.xcce007 AND t0.xcce008 = tqc.xcce008 AND t0.xcce009 = tqc.xcce009 ) ",
       "    WHEN MATCHED THEN ",
       " UPDATE SET t0.xcce101 = tqc.xcce101,", 
       "            t0.xcce102a = tqc.xcce102a,",
       "            t0.xcce102b = tqc.xcce102b,",
       "            t0.xcce102c = tqc.xcce102c,",
       "            t0.xcce102d = tqc.xcce102d,",
       "            t0.xcce102e = tqc.xcce102e,",
       "            t0.xcce102f = tqc.xcce102f,",
       "            t0.xcce102g = tqc.xcce102g,",
       "            t0.xcce102h = tqc.xcce102h,",
       "            t0.xcce102 = tqc.xcce102 "
   PREPARE axcq540_merge_qc FROM l_merge_qc
   EXECUTE axcq540_merge_qc 
   
   LET l_merge_qm =                  
       " MERGE INTO axcq540_tmp02 t0 ",
       "      USING (SELECT xcce002,xcce006,xcce007,xcce008,xcce009,xcce901,xcce902, ", 
       "                    xcce902a,xcce902b,xcce902c,xcce902d,xcce902e,xcce902f,xcce902g,xcce902h ",
       "               FROM xcce_t ",
       "              WHERE xcceent  = '",g_enterprise,"'",
       "                AND xcceld   = '",g_xccd_m.xccdld,"'",
       "                AND xcce001  = '",g_xccd_m.xccd001,"'",
       "                AND xcce003  = '",g_xccd_m.xccd003,"'",
       "                AND xcce004 = '",g_yy2,"' AND xcce005 = '",g_mm2,"' ) tqm",          
       "      ON ( t0.xcce002 = tqm.xcce002 AND t0.xcce006 = tqm.xcce006
                  AND t0.xcce007 = tqm.xcce007 AND t0.xcce008 = tqm.xcce008 AND t0.xcce009 = tqm.xcce009 ) ",
       "    WHEN MATCHED THEN ",
       " UPDATE SET t0.xcce901 = tqm.xcce901,", 
       "            t0.xcce902a = tqm.xcce902a,",
       "            t0.xcce902b = tqm.xcce902b,",
       "            t0.xcce902c = tqm.xcce902c,",
       "            t0.xcce902d = tqm.xcce902d,",
       "            t0.xcce902e = tqm.xcce902e,",
       "            t0.xcce902f = tqm.xcce902f,",
       "            t0.xcce902g = tqm.xcce902g,",
       "            t0.xcce902h = tqm.xcce902h,",
       "            t0.xcce902 = tqm.xcce902 "
   PREPARE axcq540_merge_qm FROM l_merge_qm
   EXECUTE axcq540_merge_qm 

#fengmy150813-----end
#fengmy150813-----begin-----mark     
#     LET g_sql = " INSERT INTO axcq540_tmp03 ",   #第三单身的临时表
#                 "  SELECT UNIQUE sfaa068,'',xcci006,xcch007,xcch008,xcch301,xcci007,'','',xcci008,xcci009,xcbb005,'',xcci002,xcci101,xcci102a,xcci102b,xcci102c,xcci102d,xcci102e,",  #add xcch007 fengmy150303     # add xcch008 liuym150810
#                 "         xcci102f,xcci102g,xcci102h,xcci102,xcci201,xcci202a,xcci202b,xcci202c,xcci202d,xcci202e,xcci202f,",
#                 "         xcci202g,xcci202h,xcci202,xcci301,xcci302a,xcci302b,xcci302c,xcci302d,",
#                 "         xcci302e,xcci302f,xcci302g,xcci302h,xcci302,xcci303,xcci304a,xcci304b,xcci304c,xcci304d,xcci304e,xcci304f,xcci304g,xcci304h,xcci304,",
#                 "         xcci901,xcci902a,xcci902b,xcci902c,xcci902d,xcci902e,xcci902f,xcci902g,xcci902h,xcci902 ",
##                 "    FROM xcci_t LEFT JOIN sfaa_t ON sfaaent = xccient AND sfaadocno = xcci006 ",  #fengmy150303
#                 #fengmy150303----begin
#                 "    FROM xcci_t                      ",
#                 "        LEFT JOIN xcch_t ON xcchent = xccient AND xcch006 = xcci006 AND xcch002 = xcci002 ",
#                 "                         AND xcchld = xccild AND xcch001 = xcci001 AND xcch003 = xcci003 AND xcch004 = xcci004 AND xcch005 = xcci005 ",
#                 "        LEFT JOIN sfaa_t ON sfaaent = xccient AND sfaadocno = xcci006 ",
#                 #fengmy150303----end
#                 "                LEFT JOIN xcbb_t ON xcbbent = xccient AND xcbbcomp = xccicomp AND xcbb001 = xcci004 AND xcbb002 = xcci005 ",
#                 "                                                      AND xcbb003 = xcci007 AND xcbb004 = xcci008 ",
#                 "   WHERE xccient  = '",g_enterprise,"'",
#                 "     AND xccicomp = '",g_xccd_m.xccdcomp,"'",
#                 "     AND xccild   = '",g_xccd_m.xccdld,"'",
#                 "     AND xcci001  = '",g_xccd_m.xccd001,"'",
#                 "     AND xcci003  = '",g_xccd_m.xccd003,"'",
#                 "     AND xcci004  = '",g_xccd_m.xccd004,"'",
#                 "     AND xcci005  = '",g_xccd_m.xccd005,"'"
     #fengmy150215----begin
     #fengmy150813-----end-----mark 
     #fengmy150813-----begin----跨年期查询-----
     LET g_sql = " INSERT INTO axcq540_tmp03 ",   #第三单身的临时表
                 "  SELECT UNIQUE sfaa068,'',xcci006,xcch007,xcch008,xcch301,xcci007,'','',xcci008,xcci009,xcbb005,'',xcci002,0,0,0,0,0,0,",  
                 "         0,0,0,0,SUM(xcci201),SUM(xcci202a),SUM(xcci202b),SUM(xcci202c),SUM(xcci202d),SUM(xcci202e),SUM(xcci202f),",
                 "         SUM(xcci202g),SUM(xcci202h),SUM(xcci202),SUM(xcci301),SUM(xcci302a),SUM(xcci302b),SUM(xcci302c),SUM(xcci302d),",
                 "         SUM(xcci302e),SUM(xcci302f),SUM(xcci302g),SUM(xcci302h),SUM(xcci302),SUM(xcci303),SUM(xcci304a),SUM(xcci304b),",
                 "         SUM(xcci304c),SUM(xcci304d),SUM(xcci304e),SUM(xcci304f),SUM(xcci304g),SUM(xcci304h),SUM(xcci304),",
                 "         0,0,0,0,0,0,0,0,0,0 ",
                 #fengmy150303----begin
                 "    FROM xcci_t                      ",
                 "        LEFT JOIN xcch_t ON xcchent = xccient AND xcch006 = xcci006 AND xcch002 = xcci002 ",
                 "                         AND xcchld = xccild AND xcch001 = xcci001 AND xcch003 = xcci003 AND xcch004 = xcci004 AND xcch005 = xcci005 ",
                 "        LEFT JOIN sfaa_t ON sfaaent = xccient AND sfaadocno = xcci006 ",
                 #fengmy150303----end
                 "                LEFT JOIN xcbb_t ON xcbbent = xccient AND xcbbcomp = xccicomp AND xcbb001 = xcci004 AND xcbb002 = xcci005 ",
                 "                                                      AND xcbb003 = xcci007 AND xcbb004 = xcci008 ",
                 "   WHERE xccient  = '",g_enterprise,"'",
                 "     AND xccicomp = '",g_xccd_m.xccdcomp,"'",
                 "     AND xccild   = '",g_xccd_m.xccdld,"'",
                 "     AND xcci001  = '",g_xccd_m.xccd001,"'",
                 "     AND xcci003  = '",g_xccd_m.xccd003,"'"
     #fengmy150813-----end-----跨年期查询----
     IF g_wc2 <> " 1=1" THEN
        LET g_wc2=cl_replace_str(g_wc2,"xcce","xcci")
        LET g_sql = g_sql CLIPPED," AND ",g_wc2
     END IF
     #fengmy150215----end    
     #fengmy150304----begin
     IF g_wc3 <> " 1=1" THEN
        LET g_wc3=cl_replace_str(g_wc3,"xccd","xcch")
        LET g_sql = g_sql CLIPPED," AND ",g_wc3
     END IF
     #fengmy150304----end  
     #151130-00003#2--add--(s)
     IF g_wc_filter <> " 1=1" THEN
        LET g_wc_filter = cl_replace_str(g_wc_filter,"xcce","xcci")
        LET g_sql = g_sql CLIPPED," AND ",g_wc_filter
     END IF   
     IF g_wc_filter2 <> " 1=1" THEN
        LET g_wc_filter2 = cl_replace_str(g_wc_filter2,"xcce","xcci")
        LET g_sql = g_sql CLIPPED," AND ",g_wc_filter2
     END IF  
     IF g_wc_filter3 <> " 1=1" THEN
        LET g_wc_filter3 = cl_replace_str(g_wc_filter3,"xcce","xcci")
        LET g_sql = g_sql CLIPPED," AND ",g_wc_filter3
     END IF       
     #151130-00003#2--add--(e)     
     LET g_wc =cl_replace_str(g_wc,"xccd","xcch")  
     LET g_sql = g_sql CLIPPED,"     AND ",g_wc, #160106-00012#1-add-'xcch301'
                 "     GROUP BY sfaa068,xcci006,xcch007,xcch008,xcch301,xcci007,xcci008,xcci009,xcbb005,xcci002 "  
     LET g_sql = cl_sql_add_mask(g_sql)  
     
     PREPARE axcq540_ins_tmp03 FROM g_sql

     EXECUTE axcq540_ins_tmp03

     IF SQLCA.sqlcode THEN
        INITIALIZE g_errparam TO NULL 
        LET g_errparam.extend = "ins tmp03" 
        LET g_errparam.code   = SQLCA.sqlcode 
        LET g_errparam.popup  = TRUE 
        CALL cl_err()
 
        RETURN
     END IF  

#fengmy150813-----begin
   LET l_merge_qc = cl_replace_str(l_merge_qc,"axcq540_tmp02","axcq540_tmp03")   #160628-00031#1 
   LET l_merge_qc = cl_replace_str(l_merge_qc,"xcce","xcci")
   PREPARE axcq540_merge_qc1 FROM l_merge_qc
   EXECUTE axcq540_merge_qc1 
    
   LET l_merge_qm = cl_replace_str(l_merge_qm,"axcq540_tmp02","axcq540_tmp03")   #160628-00031#1
   LET l_merge_qm = cl_replace_str(l_merge_qm,"xcce","xcci")
   PREPARE axcq540_merge_qm1 FROM l_merge_qm
   EXECUTE axcq540_merge_qm1 

#fengmy150813-----end
     
     LET g_sql = " INSERT INTO axcq540_tmp01 ",   #第一单身的临时表
                 " SELECT UNIQUE sfaa068,'',xcce006,xccd007,xccd008,xccd301,xcce007,'','',xcce008,xcce009,xcbb005,'',xcce002,xcce101,xcce102,", #fengmy150303 add xccd007   # add xccd008 liuym150810
                 "        xcce201,xcce202,xcce301,xcce302,xcce303,xcce304,xcce307,xcce308,xcce901,xcce902 ",
                 "   FROM axcq540_tmp02 ",
                 "  UNION ",
                 " SELECT UNIQUE sfaa068,'',xcci006,xcch007,xcch008,xcch301,xcci007,'','',xcci008,xcci009,xcbb005,'',xcci002,xcci101,xcci102,xcci201,xcci202,xcci301,xcci302,xcci303,xcci304,0,0,xcci901,xcci902 ", #fengmy150303 add xcch007  # add xcch008 liuym150810 
                 "   FROM axcq540_tmp03 "
                 
                
     LET g_sql = cl_sql_add_mask(g_sql)  
     
     PREPARE axcq540_ins_tmp01 FROM g_sql

     EXECUTE axcq540_ins_tmp01

     IF SQLCA.sqlcode THEN
        INITIALIZE g_errparam TO NULL 
        LET g_errparam.extend = "ins tmp01" 
        LET g_errparam.code   = SQLCA.sqlcode 
        LET g_errparam.popup  = TRUE 
        CALL cl_err()
 
        RETURN
     END IF 
  
   #end add-point
   
   #判斷是否填充
   IF axcq540_fill_chk(1) THEN
   
#     LET g_sql = "SELECT  UNIQUE xccd006,xccd002  FROM xccd_t",   
#                 " INNER JOIN xccd_t ON xccdld =  ",
#                 " AND xccd001 =  ",
#                 " AND xccd003 =  ",
#                 " AND xccd004 =  ",
#                 " AND xccd005 =  ",
#
#                 #" LEFT JOIN sfaa_t ON sfaaent = '"||g_enterprise||"' AND xccdld = sfaadocnoxccd001 = xccd003 = xccd004 = xccd005 = xcci002 = xcci006 = xcci007 = xcci008 = xcci009 =  LEFT JOIN xcce_t ON xcceent = '"||g_enterprise||"' AND xccdld = xcceld AND xccd001 = xcce001 AND xccd003 = xcce002 AND xccd004 = xcce003 AND xccd005 = xcce004 AND xcci002 = xcce005 AND xcci006 = xcce006 AND xcci007 = xcce007 AND xcci008 = xcce008 AND xcci009 = xcce009 LEFT JOIN xcbb_t ON xcbbent = '"||g_enterprise||"' AND xccdld = xcbbcomp AND xccd001 = xcbb001 AND xccd003 = xcbb002 AND xccd004 = xcbb003 AND xccd005 = xcbb004xcci002 = xcci006 = xcci007 = xcci008 = xcci009 =",
#                 
#                 " LEFT JOIN sfaa_t ON sfaaent = '"||g_enterprise||"' AND xccdld = sfaadocno LEFT JOIN xcce_t ON xcceent = '"||g_enterprise||"' AND xccdld = xcceld AND xccd001 = xcce001 AND xccd003 = xcce002 AND xccd004 = xcce003 AND xccd005 = xcce004 AND xcci002 = xcce005 AND xcci006 = xcce006 AND xcci007 = xcce007 AND xcci008 = xcce008 AND xcci009 = xcce009 LEFT JOIN xcbb_t ON xcbbent = '"||g_enterprise||"' AND xccdld = xcbbcomp AND xccd001 = xcbb001 AND xccd003 = xcbb002 AND xccd004 = xcbb003 AND xccd005 = xcbb004",
#                 
#                 " WHERE"
#     LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
#     #add-point:b_fill段sql_before
#
#     #end add-point
#     IF NOT cl_null(g_wc2_table1) THEN
#        LET g_sql = g_sql CLIPPED, " AND ", g_wc2_table1 CLIPPED
#     END IF
#     
#     #子單身的WC
#     
#     
#     LET g_sql = g_sql, " ORDER BY xccd_t.xccdld,xccd_t.xccd001,xccd_t.xccd003,xccd_t.xccd004,xccd_t.xccd005"
#     
      #add-point:單身填充控制

#三个单身的临时表都插入成功，开始select出来填单身了！
#以下开始就和一般的双档填单身一样处理
      LET g_sql = " SELECT UNIQUE sfaa068,xccd006,xcce007,xcce008,xcce009,xcbb005,xccd002,xcce101,xcce102,xcce201,",
                  "        xcce202,xcce301,xcce302,xcce303,xcce304,xcce307,xcce308,xcce901,xcce902 ",
                  "        ,xccd007,xccd008 ",      #fengmy150303   # add xccd008 liuym150810       
                  "        ,xccd301 ",  #151202-00029 by whitney add
                  "   FROM axcq540_tmp01 ",
                  "  ORDER BY sfaa068,xccd006 "

      
      LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
      PREPARE axcq540_pb FROM g_sql
      DECLARE b_fill_cs CURSOR FOR axcq540_pb
      
      
      LET g_cnt = l_ac
      LET l_ac = 1
      LET l_xcce101_sum1  = 0 #dorislai-20151021-add
      LET l_xcce102_sum1  = 0 
      LET l_xcce201_sum1  = 0 #dorislai-20151021-add
      LET l_xcce202_sum1  = 0  
      LET l_xcce301_sum1  = 0 #dorislai-20151021-add
      LET l_xcce302_sum1  = 0  
      LET l_xcce303_sum1  = 0 #dorislai-20151021-add
      LET l_xcce304_sum1  = 0  
      LET l_xcce307_sum1  = 0 #dorislai-20151021-add
      LET l_xcce308_sum1  = 0  
      LET l_xcce901_sum1  = 0 #dorislai-20151021-add
      LET l_xcce902_sum1  = 0 
      LET l_xcce101_sum2  = 0 #dorislai-20151021-add
      LET l_xcce102_sum2  = 0 
      LET l_xcce201_sum2  = 0 #dorislai-20151021-add
      LET l_xcce202_sum2  = 0  
      LET l_xcce301_sum2  = 0 #dorislai-20151021-add
      LET l_xcce302_sum2  = 0  
      LET l_xcce303_sum2  = 0 #dorislai-20151021-add
      LET l_xcce304_sum2  = 0  
      LET l_xcce307_sum2  = 0 #dorislai-20151021-add
      LET l_xcce308_sum2  = 0  
      LET l_xcce901_sum2  = 0 #dorislai-20151021-add
      LET l_xcce902_sum2  = 0  
      LET l_xcce101_total  = 0 #dorislai-20151021-add
      LET l_xcce102_total  = 0 
      LET l_xcce201_total  = 0 #dorislai-20151021-add
      LET l_xcce202_total  = 0  
      LET l_xcce301_total  = 0 #dorislai-20151021-add
      LET l_xcce302_total  = 0  
      LET l_xcce303_total  = 0 #dorislai-20151021-add
      LET l_xcce304_total  = 0  
      LET l_xcce307_total  = 0 #dorislai-20151021-add
      LET l_xcce308_total  = 0  
      LET l_xcce901_total  = 0 #dorislai-20151021-add
      LET l_xcce902_total  = 0  
      
      FOREACH b_fill_cs INTO g_xccd_d[l_ac].sfaa068,g_xccd_d[l_ac].xccd006,g_xccd_d[l_ac].xcce007,g_xccd_d[l_ac].xcce008,g_xccd_d[l_ac].xcce009,g_xccd_d[l_ac].xcbb005,
                             g_xccd_d[l_ac].xccd002,g_xccd_d[l_ac].xcce101,g_xccd_d[l_ac].xcce102,g_xccd_d[l_ac].xcce201,g_xccd_d[l_ac].xcce202,g_xccd_d[l_ac].xcce301,
                             g_xccd_d[l_ac].xcce302,g_xccd_d[l_ac].xcce303,g_xccd_d[l_ac].xcce304,g_xccd_d[l_ac].xcce307,g_xccd_d[l_ac].xcce308,g_xccd_d[l_ac].xcce901,g_xccd_d[l_ac].xcce902
                            ,g_xccd_d[l_ac].xccd007,g_xccd_d[l_ac].xccd008  #fengmy150303 # add xccd008 liuym150810
                            ,g_xccd_d[l_ac].xccd301  #151202-00029 by whitney add
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "FOREACH:" 
            LET g_errparam.code   = SQLCA.sqlcode 
            LET g_errparam.popup  = TRUE 
            CALL cl_err()
 
            EXIT FOREACH
         END IF
         IF g_xccd_d[l_ac].sfaa068 IS NULL THEN LET g_xccd_d[l_ac].sfaa068 = ' ' END IF #170123-00012#1
         CALL s_desc_get_department_desc(g_xccd_d[l_ac].sfaa068) RETURNING g_xccd_d[l_ac].sfaa068_desc
         CALL s_desc_get_item_desc(g_xccd_d[l_ac].xcce007) RETURNING g_xccd_d[l_ac].xcce007_desc,g_xccd_d[l_ac].xcce007_desc_1
         CALL s_desc_get_unit_desc(g_xccd_d[l_ac].xcbb005) RETURNING g_xccd_d[l_ac].xcbb005_desc
         CALL s_desc_get_item_desc(g_xccd_d[l_ac].xccd007) RETURNING g_xccd_d[l_ac].xccd007_desc,g_xccd_d[l_ac].xccd007_desc_desc   #fengmy150304
#合计
         LET l_xcce101_total  = l_xcce101_total  + g_xccd_d[l_ac].xcce101 #dorislai-20151021-add
         LET l_xcce102_total  = l_xcce102_total  + g_xccd_d[l_ac].xcce102 
         LET l_xcce201_total  = l_xcce201_total  + g_xccd_d[l_ac].xcce201 #dorislai-20151021-add
         LET l_xcce202_total  = l_xcce202_total  + g_xccd_d[l_ac].xcce202 
         LET l_xcce301_total  = l_xcce301_total  + g_xccd_d[l_ac].xcce301 #dorislai-20151021-add
         LET l_xcce302_total  = l_xcce302_total  + g_xccd_d[l_ac].xcce302 
         LET l_xcce303_total  = l_xcce303_total  + g_xccd_d[l_ac].xcce303 #dorislai-20151021-add
         LET l_xcce304_total  = l_xcce304_total  + g_xccd_d[l_ac].xcce304 
         LET l_xcce307_total  = l_xcce307_total  + g_xccd_d[l_ac].xcce307 #dorislai-20151021-add
         LET l_xcce308_total  = l_xcce308_total  + g_xccd_d[l_ac].xcce308 
         LET l_xcce901_total  = l_xcce901_total  + g_xccd_d[l_ac].xcce901 #dorislai-20151021-add
         LET l_xcce902_total  = l_xcce902_total  + g_xccd_d[l_ac].xcce902 
#按单号小计
         LET l_xcce101_sum1  = l_xcce101_sum1  + g_xccd_d[l_ac].xcce101 #dorislai-20151021-add
         LET l_xcce102_sum1  = l_xcce102_sum1  + g_xccd_d[l_ac].xcce102 
         LET l_xcce201_sum1  = l_xcce201_sum1  + g_xccd_d[l_ac].xcce201 #dorislai-20151021-add
         LET l_xcce202_sum1  = l_xcce202_sum1  + g_xccd_d[l_ac].xcce202 
         LET l_xcce301_sum1  = l_xcce301_sum1  + g_xccd_d[l_ac].xcce301 #dorislai-20151021-add
         LET l_xcce302_sum1  = l_xcce302_sum1  + g_xccd_d[l_ac].xcce302 
         LET l_xcce303_sum1  = l_xcce303_sum1  + g_xccd_d[l_ac].xcce303 #dorislai-20151021-add
         LET l_xcce304_sum1  = l_xcce304_sum1  + g_xccd_d[l_ac].xcce304 
         LET l_xcce307_sum1  = l_xcce307_sum1  + g_xccd_d[l_ac].xcce307 #dorislai-20151021-add
         LET l_xcce308_sum1  = l_xcce308_sum1  + g_xccd_d[l_ac].xcce308 
         LET l_xcce901_sum1  = l_xcce901_sum1  + g_xccd_d[l_ac].xcce901 #dorislai-20151021-add
         LET l_xcce902_sum1  = l_xcce902_sum1  + g_xccd_d[l_ac].xcce902 
         IF l_ac > 1 THEN 
            IF g_xccd_d[l_ac].xccd006 != g_xccd_d[l_ac-1].xccd006 THEN
               #把当前行下移，并在当前行显示小计
               LET g_xccd_d[l_ac + 1].* = g_xccd_d[l_ac].*  
               INITIALIZE  g_xccd_d[l_ac].* TO NULL
               #LET g_xccd_d[l_ac].xccd006  = cl_getmsg("axc-00577",g_lang) #160201-00004#1 mark
               LET g_xccd_d[l_ac].xccd006  = cl_getmsg("lib-00156",g_lang),"-",g_xccd_d[l_ac-1].xccd006 #160201-00004#1
               #170123-00012#1---mark---s            
               ##160108-00001#1-add----(S)
               #LET g_xccd_d[l_ac].xccd007  = g_xccd_d[l_ac-1].xccd007 
               #LET g_xccd_d[l_ac].xccd007_desc  = g_xccd_d[l_ac-1].xccd007_desc 
               #LET g_xccd_d[l_ac].xccd007_desc_desc  = g_xccd_d[l_ac-1].xccd007_desc_desc
               ##160108-00001#1-add----(E)
               #170123-00012#1---mark---s            
               LET g_xccd_d[l_ac].xccd301  = g_xccd_d[l_ac-1].xccd301 #160106-00012#1-add                
               LET g_xccd_d[l_ac].xcce101  = l_xcce101_sum1  - g_xccd_d[l_ac+1].xcce101 #dorislai-20151021-add
               LET g_xccd_d[l_ac].xcce102  = l_xcce102_sum1  - g_xccd_d[l_ac+1].xcce102
               LET g_xccd_d[l_ac].xcce201  = l_xcce201_sum1  - g_xccd_d[l_ac+1].xcce201 #dorislai-20151021-add
               LET g_xccd_d[l_ac].xcce202  = l_xcce202_sum1  - g_xccd_d[l_ac+1].xcce202 
               LET g_xccd_d[l_ac].xcce301  = l_xcce301_sum1  - g_xccd_d[l_ac+1].xcce301 #dorislai-20151021-add
               LET g_xccd_d[l_ac].xcce302  = l_xcce302_sum1  - g_xccd_d[l_ac+1].xcce302 
               LET g_xccd_d[l_ac].xcce303  = l_xcce303_sum1  - g_xccd_d[l_ac+1].xcce303 #dorislai-20151021-add
               LET g_xccd_d[l_ac].xcce304  = l_xcce304_sum1  - g_xccd_d[l_ac+1].xcce304 
               LET g_xccd_d[l_ac].xcce307  = l_xcce307_sum1  - g_xccd_d[l_ac+1].xcce307 #dorislai-20151021-add
               LET g_xccd_d[l_ac].xcce308  = l_xcce308_sum1  - g_xccd_d[l_ac+1].xcce308 
               LET g_xccd_d[l_ac].xcce901  = l_xcce901_sum1  - g_xccd_d[l_ac+1].xcce901 #dorislai-20151021-add
               LET g_xccd_d[l_ac].xcce902  = l_xcce902_sum1  - g_xccd_d[l_ac+1].xcce902 
               LET l_ac = l_ac + 1
               LET l_xcce101_sum1  = g_xccd_d[l_ac].xcce101 #dorislai-20151021-add
               LET l_xcce102_sum1  = g_xccd_d[l_ac].xcce102
               LET l_xcce201_sum1  = g_xccd_d[l_ac].xcce201 #dorislai-20151021-add
               LET l_xcce202_sum1  = g_xccd_d[l_ac].xcce202 
               LET l_xcce301_sum1  = g_xccd_d[l_ac].xcce301 #dorislai-20151021-add
               LET l_xcce302_sum1  = g_xccd_d[l_ac].xcce302 
               LET l_xcce303_sum1  = g_xccd_d[l_ac].xcce303 #dorislai-20151021-add
               LET l_xcce304_sum1  = g_xccd_d[l_ac].xcce304 
               LET l_xcce307_sum1  = g_xccd_d[l_ac].xcce307 #dorislai-20151021-add
               LET l_xcce308_sum1  = g_xccd_d[l_ac].xcce308 
               LET l_xcce901_sum1  = g_xccd_d[l_ac].xcce901 #dorislai-20151021-add
               LET l_xcce902_sum1  = g_xccd_d[l_ac].xcce902 
            END IF               
         END IF         
#按组织小计
         LET l_xcce101_sum2  = l_xcce101_sum2  + g_xccd_d[l_ac].xcce101 #dorislai-20151021-add 
         LET l_xcce102_sum2  = l_xcce102_sum2  + g_xccd_d[l_ac].xcce102 
         LET l_xcce201_sum2  = l_xcce201_sum2  + g_xccd_d[l_ac].xcce201 #dorislai-20151021-add 
         LET l_xcce202_sum2  = l_xcce202_sum2  + g_xccd_d[l_ac].xcce202 
         LET l_xcce301_sum2  = l_xcce301_sum2  + g_xccd_d[l_ac].xcce301 #dorislai-20151021-add 
         LET l_xcce302_sum2  = l_xcce302_sum2  + g_xccd_d[l_ac].xcce302 
         LET l_xcce303_sum2  = l_xcce303_sum2  + g_xccd_d[l_ac].xcce303 #dorislai-20151021-add 
         LET l_xcce304_sum2  = l_xcce304_sum2  + g_xccd_d[l_ac].xcce304 
         LET l_xcce307_sum2  = l_xcce307_sum2  + g_xccd_d[l_ac].xcce307 #dorislai-20151021-add 
         LET l_xcce308_sum2  = l_xcce308_sum2  + g_xccd_d[l_ac].xcce308 
         LET l_xcce901_sum2  = l_xcce901_sum2  + g_xccd_d[l_ac].xcce901 #dorislai-20151021-add 
         LET l_xcce902_sum2  = l_xcce902_sum2  + g_xccd_d[l_ac].xcce902 
         IF l_ac > 2 THEN
            #IF g_xccd_d[l_ac].sfaa068 != g_xccd_d[l_ac-2].sfaa068 THEN  #170123-00012#1  mark
            IF g_xccd_d[l_ac].sfaa068 != g_xccd_d[l_ac-2].sfaa068 AND g_xccd_d[l_ac].xccd006 != g_xccd_d[l_ac-1].xccd006 THEN  #170123-00012#1
               #把当前行下移，并在当前行显示小计
               LET g_xccd_d[l_ac + 1].* = g_xccd_d[l_ac].*  
               INITIALIZE  g_xccd_d[l_ac].* TO NULL
               #LET g_xccd_d[l_ac].sfaa068  = cl_getmsg("axc-00578",g_lang) #160201-00004#1 mark
               #LET g_xccd_d[l_ac].sfaa068  = cl_getmsg("lib-00156",g_lang),"-",g_xccd_d[l_ac-2].sfaa068  #160201-00004#1 #170123-00012#1 mark
               LET g_xccd_d[l_ac].sfaa068  = cl_getmsg("aps-00134",g_lang),"-",g_xccd_d[l_ac-2].sfaa068  #170123-00012#1
               LET g_xccd_d[l_ac].xcce101  = l_xcce101_sum2  - g_xccd_d[l_ac+1].xcce101 #dorislai-20151021-add
               LET g_xccd_d[l_ac].xcce102  = l_xcce102_sum2  - g_xccd_d[l_ac+1].xcce102
               LET g_xccd_d[l_ac].xcce201  = l_xcce201_sum2  - g_xccd_d[l_ac+1].xcce201 #dorislai-20151021-add
               LET g_xccd_d[l_ac].xcce202  = l_xcce202_sum2  - g_xccd_d[l_ac+1].xcce202 
               LET g_xccd_d[l_ac].xcce301  = l_xcce301_sum2  - g_xccd_d[l_ac+1].xcce301 #dorislai-20151021-add
               LET g_xccd_d[l_ac].xcce302  = l_xcce302_sum2  - g_xccd_d[l_ac+1].xcce302 
               LET g_xccd_d[l_ac].xcce303  = l_xcce303_sum2  - g_xccd_d[l_ac+1].xcce303 #dorislai-20151021-add
               LET g_xccd_d[l_ac].xcce304  = l_xcce304_sum2  - g_xccd_d[l_ac+1].xcce304 
               LET g_xccd_d[l_ac].xcce307  = l_xcce307_sum2  - g_xccd_d[l_ac+1].xcce307 #dorislai-20151021-add
               LET g_xccd_d[l_ac].xcce308  = l_xcce308_sum2  - g_xccd_d[l_ac+1].xcce308 
               LET g_xccd_d[l_ac].xcce901  = l_xcce901_sum2  - g_xccd_d[l_ac+1].xcce901 #dorislai-20151021-add
               LET g_xccd_d[l_ac].xcce902  = l_xcce902_sum2  - g_xccd_d[l_ac+1].xcce902 
               LET l_ac = l_ac + 1
               LET l_xcce101_sum2  = g_xccd_d[l_ac].xcce101 #dorislai-20151021-add
               LET l_xcce102_sum2  = g_xccd_d[l_ac].xcce102 
               LET l_xcce201_sum2  = g_xccd_d[l_ac].xcce201 #dorislai-20151021-add
               LET l_xcce202_sum2  = g_xccd_d[l_ac].xcce202 
               LET l_xcce301_sum2  = g_xccd_d[l_ac].xcce301 #dorislai-20151021-add
               LET l_xcce302_sum2  = g_xccd_d[l_ac].xcce302 
               LET l_xcce303_sum2  = g_xccd_d[l_ac].xcce303 #dorislai-20151021-add
               LET l_xcce304_sum2  = g_xccd_d[l_ac].xcce304 
               LET l_xcce307_sum2  = g_xccd_d[l_ac].xcce307 #dorislai-20151021-add
               LET l_xcce308_sum2  = g_xccd_d[l_ac].xcce308 
               LET l_xcce901_sum2  = g_xccd_d[l_ac].xcce901 #dorislai-20151021-add
               LET l_xcce902_sum2  = g_xccd_d[l_ac].xcce902
            END IF               
         END IF           
         
         IF l_ac > g_max_rec THEN
            IF g_error_show = 1 THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = l_ac
               LET g_errparam.code   = 9035 
               LET g_errparam.popup  = TRUE 
               CALL cl_err()
            END IF
            EXIT FOREACH
         END IF
         
         LET l_ac = l_ac + 1
      END FOREACH
      
#最后一组小计，还有合计
#按在制单号小计
      IF l_ac > 1 THEN 
         #LET g_xccd_d[l_ac].xccd006   = cl_getmsg("axc-00577",g_lang) #160201-00004#1 mark
         LET g_xccd_d[l_ac].xccd006   = cl_getmsg("lib-00156",g_lang),"-",g_xccd_d[l_ac-1].xccd006  #160201-00004#1
         #170123-00012#1---mark---s            
         ##160108-00001#1-add----(S)
         #LET g_xccd_d[l_ac].xccd007  = g_xccd_d[l_ac-1].xccd007 
         #LET g_xccd_d[l_ac].xccd007_desc  = g_xccd_d[l_ac-1].xccd007_desc 
         #LET g_xccd_d[l_ac].xccd007_desc_desc  = g_xccd_d[l_ac-1].xccd007_desc_desc
         ##160108-00001#1-add----(E)
         #170123-00012#1---mark---e            
         LET g_xccd_d[l_ac].xccd301  = g_xccd_d[l_ac-1].xccd301 #160106-00012#-add
         LET g_xccd_d[l_ac].xcce101  = l_xcce101_sum1 #dorislai-20151021-add
         LET g_xccd_d[l_ac].xcce102  = l_xcce102_sum1 
         LET g_xccd_d[l_ac].xcce201  = l_xcce201_sum1 #dorislai-20151021-add
         LET g_xccd_d[l_ac].xcce202  = l_xcce202_sum1   
         LET g_xccd_d[l_ac].xcce301  = l_xcce301_sum1 #dorislai-20151021-add
         LET g_xccd_d[l_ac].xcce302  = l_xcce302_sum1   
         LET g_xccd_d[l_ac].xcce303  = l_xcce303_sum1 #dorislai-20151021-add
         LET g_xccd_d[l_ac].xcce304  = l_xcce304_sum1   
         LET g_xccd_d[l_ac].xcce307  = l_xcce307_sum1 #dorislai-20151021-add
         LET g_xccd_d[l_ac].xcce308  = l_xcce308_sum1   
         LET g_xccd_d[l_ac].xcce901  = l_xcce901_sum1 #dorislai-20151021-add
         LET g_xccd_d[l_ac].xcce902  = l_xcce902_sum1  
         LET l_ac = l_ac+1  
#按组织小计 
         #LET g_xccd_d[l_ac].sfaa068  = cl_getmsg("axc-00578",g_lang) #160201-00004#1 mark
         #LET g_xccd_d[l_ac].sfaa068  = cl_getmsg("lib-00156",g_lang),"-",g_xccd_d[l_ac-2].sfaa068   #160201-00004#1  #170123-00012#1 mark
         LET g_xccd_d[l_ac].sfaa068  = cl_getmsg("aps-00134",g_lang),"-",g_xccd_d[l_ac-2].sfaa068    #170123-00012#1 
         LET g_xccd_d[l_ac].xcce101  = l_xcce101_sum2 #dorislai-20151021-add
         LET g_xccd_d[l_ac].xcce102  = l_xcce102_sum2 
         LET g_xccd_d[l_ac].xcce201  = l_xcce201_sum2 #dorislai-20151021-add
         LET g_xccd_d[l_ac].xcce202  = l_xcce202_sum2   
         LET g_xccd_d[l_ac].xcce301  = l_xcce301_sum2 #dorislai-20151021-add
         LET g_xccd_d[l_ac].xcce302  = l_xcce302_sum2   
         LET g_xccd_d[l_ac].xcce303  = l_xcce303_sum2 #dorislai-20151021-add
         LET g_xccd_d[l_ac].xcce304  = l_xcce304_sum2   
         LET g_xccd_d[l_ac].xcce307  = l_xcce307_sum2 #dorislai-20151021-add
         LET g_xccd_d[l_ac].xcce308  = l_xcce308_sum2   
         LET g_xccd_d[l_ac].xcce901  = l_xcce901_sum2 #dorislai-20151021-add
         LET g_xccd_d[l_ac].xcce902  = l_xcce902_sum2  
         LET l_ac = l_ac + 1
#合计 
         LET g_xccd_d[l_ac].sfaa068  = cl_getmsg("lib-00133",g_lang)
         LET g_xccd_d[l_ac].xcce101  = l_xcce101_total #dorislai-20151021-add 
         LET g_xccd_d[l_ac].xcce102  = l_xcce102_total  
         LET g_xccd_d[l_ac].xcce201  = l_xcce201_total #dorislai-20151021-add 
         LET g_xccd_d[l_ac].xcce202  = l_xcce202_total
         LET g_xccd_d[l_ac].xcce301  = l_xcce301_total #dorislai-20151021-add 
         LET g_xccd_d[l_ac].xcce302  = l_xcce302_total   
         LET g_xccd_d[l_ac].xcce303  = l_xcce303_total #dorislai-20151021-add 
         LET g_xccd_d[l_ac].xcce304  = l_xcce304_total   
         LET g_xccd_d[l_ac].xcce307  = l_xcce307_total #dorislai-20151021-add 
         LET g_xccd_d[l_ac].xcce308  = l_xcce308_total   
         LET g_xccd_d[l_ac].xcce901  = l_xcce901_total #dorislai-20151021-add 
         LET g_xccd_d[l_ac].xcce902  = l_xcce902_total  
      END IF         
   END IF

   
   #判斷是否填充
   IF axcq540_fill_chk(2) THEN
      LET g_sql = " SELECT  sfaa068,xcce006,xcce007,xcce008,xcce009,xcbb005,xcce002,xcce101,xcce102a,xcce102b,xcce102c,xcce102d,xcce102e,xcce102f,xcce102g,xcce102h,",
                  "         xcce102,xcce201,xcce202a,xcce202b,xcce202c,xcce202d,xcce202e,xcce202f,xcce202g,xcce202h,xcce202,xcce301,xcce302a,xcce302b,xcce302c,xcce302d,xcce302e,xcce302f,xcce302g,xcce302h,",
                  "         xcce302,xcce303,xcce304a,xcce304b,xcce304c,xcce304d,xcce304e,xcce304f,xcce304g,xcce304h,xcce304,xcce307,xcce308a,xcce308b,xcce308c,xcce308d,xcce308e,xcce308f,xcce308g,xcce308h,",
                  "         xcce308,xcce901,xcce902a,xcce902b,xcce902c,xcce902d,xcce902e,xcce902f,xcce902g,xcce902h,xcce902 ",
                  "        ,xccd007,xccd008 ",      #fengmy150303   # add xccd008 liuym150810
                  "        ,xccd301 ",  #151202-00029 by whitney add
                  "   FROM axcq540_tmp02 ",
                  "  ORDER BY sfaa068,xcce006 "
  
      LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
      
      LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
      PREPARE axcq540_pb2 FROM g_sql
      DECLARE b_fill_cs2 CURSOR FOR axcq540_pb2
      
      LET l_ac = 1
      LET l_xcce101_sum1 = 0  #dorislai-20151021-add
      LET l_xcce102a_sum1 = 0  
      LET l_xcce102b_sum1 = 0  
      LET l_xcce102c_sum1 = 0  
      LET l_xcce102d_sum1 = 0  
      LET l_xcce102e_sum1 = 0  
      LET l_xcce102f_sum1 = 0  
      LET l_xcce102g_sum1 = 0  
      LET l_xcce102h_sum1 = 0  
      LET l_xcce102_sum1  = 0 
      LET l_xcce201_sum1 = 0  #dorislai-20151021-add
      LET l_xcce202a_sum1 = 0
      LET l_xcce202b_sum1 = 0  
      LET l_xcce202c_sum1 = 0  
      LET l_xcce202d_sum1 = 0  
      LET l_xcce202e_sum1 = 0  
      LET l_xcce202f_sum1 = 0  
      LET l_xcce202g_sum1 = 0  
      LET l_xcce202h_sum1 = 0  
      LET l_xcce202_sum1  = 0  
      LET l_xcce301_sum1 = 0  #dorislai-20151021-add
      LET l_xcce302a_sum1 = 0  
      LET l_xcce302b_sum1 = 0  
      LET l_xcce302c_sum1 = 0  
      LET l_xcce302d_sum1 = 0  
      LET l_xcce302e_sum1 = 0  
      LET l_xcce302f_sum1 = 0  
      LET l_xcce302g_sum1 = 0  
      LET l_xcce302h_sum1 = 0  
      LET l_xcce302_sum1  = 0  
      LET l_xcce303_sum1 = 0  #dorislai-20151021-add
      LET l_xcce304a_sum1 = 0  
      LET l_xcce304b_sum1 = 0  
      LET l_xcce304c_sum1 = 0  
      LET l_xcce304d_sum1 = 0  
      LET l_xcce304e_sum1 = 0  
      LET l_xcce304f_sum1 = 0  
      LET l_xcce304g_sum1 = 0  
      LET l_xcce304h_sum1 = 0  
      LET l_xcce304_sum1  = 0  
      LET l_xcce307_sum1 = 0  #dorislai-20151021-add
      LET l_xcce308a_sum1 = 0  
      LET l_xcce308b_sum1 = 0  
      LET l_xcce308c_sum1 = 0  
      LET l_xcce308d_sum1 = 0  
      LET l_xcce308e_sum1 = 0  
      LET l_xcce308f_sum1 = 0  
      LET l_xcce308g_sum1 = 0  
      LET l_xcce308h_sum1 = 0  
      LET l_xcce308_sum1  = 0  
      LET l_xcce901_sum1 = 0  #dorislai-20151021-add
      LET l_xcce902a_sum1 = 0  
      LET l_xcce902b_sum1 = 0  
      LET l_xcce902c_sum1 = 0  
      LET l_xcce902d_sum1 = 0  
      LET l_xcce902e_sum1 = 0  
      LET l_xcce902f_sum1 = 0  
      LET l_xcce902g_sum1 = 0  
      LET l_xcce902h_sum1 = 0  
      LET l_xcce902_sum1  = 0  
      LET l_xcce101_sum2 = 0  #dorislai-20151021-add
      LET l_xcce102a_sum2 = 0  
      LET l_xcce102b_sum2 = 0  
      LET l_xcce102c_sum2 = 0  
      LET l_xcce102d_sum2 = 0  
      LET l_xcce102e_sum2 = 0  
      LET l_xcce102f_sum2 = 0  
      LET l_xcce102g_sum2 = 0  
      LET l_xcce102h_sum2 = 0  
      LET l_xcce102_sum2  = 0 
      LET l_xcce201_sum2 = 0  #dorislai-20151021-add
      LET l_xcce202a_sum2 = 0
      LET l_xcce202b_sum2 = 0  
      LET l_xcce202c_sum2 = 0  
      LET l_xcce202d_sum2 = 0  
      LET l_xcce202e_sum2 = 0  
      LET l_xcce202f_sum2 = 0  
      LET l_xcce202g_sum2 = 0  
      LET l_xcce202h_sum2 = 0  
      LET l_xcce202_sum2  = 0  
      LET l_xcce301_sum2 = 0  #dorislai-20151021-add
      LET l_xcce302a_sum2 = 0  
      LET l_xcce302b_sum2 = 0  
      LET l_xcce302c_sum2 = 0  
      LET l_xcce302d_sum2 = 0  
      LET l_xcce302e_sum2 = 0  
      LET l_xcce302f_sum2 = 0  
      LET l_xcce302g_sum2 = 0  
      LET l_xcce302h_sum2 = 0  
      LET l_xcce302_sum2  = 0  
      LET l_xcce303_sum2 = 0  #dorislai-20151021-add
      LET l_xcce304a_sum2 = 0  
      LET l_xcce304b_sum2 = 0  
      LET l_xcce304c_sum2 = 0  
      LET l_xcce304d_sum2 = 0  
      LET l_xcce304e_sum2 = 0  
      LET l_xcce304f_sum2 = 0  
      LET l_xcce304g_sum2 = 0  
      LET l_xcce304h_sum2 = 0  
      LET l_xcce304_sum2  = 0  
      LET l_xcce307_sum2 = 0  #dorislai-20151021-add
      LET l_xcce308a_sum2 = 0  
      LET l_xcce308b_sum2 = 0  
      LET l_xcce308c_sum2 = 0  
      LET l_xcce308d_sum2 = 0  
      LET l_xcce308e_sum2 = 0  
      LET l_xcce308f_sum2 = 0  
      LET l_xcce308g_sum2 = 0  
      LET l_xcce308h_sum2 = 0  
      LET l_xcce308_sum2  = 0  
      LET l_xcce901_sum2 = 0  #dorislai-20151021-add
      LET l_xcce902a_sum2 = 0  
      LET l_xcce902b_sum2 = 0  
      LET l_xcce902c_sum2 = 0  
      LET l_xcce902d_sum2 = 0  
      LET l_xcce902e_sum2 = 0  
      LET l_xcce902f_sum2 = 0  
      LET l_xcce902g_sum2 = 0  
      LET l_xcce902h_sum2 = 0  
      LET l_xcce902_sum2  = 0
      LET l_xcce101_total = 0  #dorislai-20151021-add
      LET l_xcce102a_total = 0  
      LET l_xcce102b_total = 0  
      LET l_xcce102c_total = 0  
      LET l_xcce102d_total = 0  
      LET l_xcce102e_total = 0  
      LET l_xcce102f_total = 0  
      LET l_xcce102g_total = 0  
      LET l_xcce102h_total = 0  
      LET l_xcce102_total  = 0 
      LET l_xcce201_total = 0  #dorislai-20151021-add
      LET l_xcce202a_total = 0      
      LET l_xcce202b_total = 0  
      LET l_xcce202c_total = 0  
      LET l_xcce202d_total = 0  
      LET l_xcce202e_total = 0  
      LET l_xcce202f_total = 0  
      LET l_xcce202g_total = 0  
      LET l_xcce202h_total = 0  
      LET l_xcce202_total  = 0  
      LET l_xcce301_total = 0  #dorislai-20151021-add
      LET l_xcce302a_total = 0  
      LET l_xcce302b_total = 0  
      LET l_xcce302c_total = 0  
      LET l_xcce302d_total = 0  
      LET l_xcce302e_total = 0  
      LET l_xcce302f_total = 0  
      LET l_xcce302g_total = 0  
      LET l_xcce302h_total = 0  
      LET l_xcce302_total  = 0  
      LET l_xcce303_total = 0  #dorislai-20151021-add
      LET l_xcce304a_total = 0  
      LET l_xcce304b_total = 0  
      LET l_xcce304c_total = 0  
      LET l_xcce304d_total = 0  
      LET l_xcce304e_total = 0  
      LET l_xcce304f_total = 0  
      LET l_xcce304g_total = 0  
      LET l_xcce304h_total = 0  
      LET l_xcce304_total  = 0  
      LET l_xcce307_total = 0  #dorislai-20151021-add
      LET l_xcce308a_total = 0  
      LET l_xcce308b_total = 0  
      LET l_xcce308c_total = 0  
      LET l_xcce308d_total = 0  
      LET l_xcce308e_total = 0  
      LET l_xcce308f_total = 0  
      LET l_xcce308g_total = 0  
      LET l_xcce308h_total = 0  
      LET l_xcce308_total  = 0  
      LET l_xcce901_total = 0  #dorislai-20151021-add
      LET l_xcce902a_total = 0  
      LET l_xcce902b_total = 0  
      LET l_xcce902c_total = 0  
      LET l_xcce902d_total = 0  
      LET l_xcce902e_total = 0  
      LET l_xcce902f_total = 0  
      LET l_xcce902g_total = 0  
      LET l_xcce902h_total = 0  
      LET l_xcce902_total  = 0


      FOREACH b_fill_cs2 INTO g_xccd2_d[l_ac].sfaa068,g_xccd2_d[l_ac].xcce006,g_xccd2_d[l_ac].xcce007,g_xccd2_d[l_ac].xcce008,g_xccd2_d[l_ac].xcce009,g_xccd2_d[l_ac].xcbb005,
                              g_xccd2_d[l_ac].xcce002,g_xccd2_d[l_ac].xcce101,g_xccd2_d[l_ac].xcce102a,g_xccd2_d[l_ac].xcce102b,g_xccd2_d[l_ac].xcce102c,g_xccd2_d[l_ac].xcce102d,g_xccd2_d[l_ac].xcce102e,g_xccd2_d[l_ac].xcce102f,g_xccd2_d[l_ac].xcce102g,g_xccd2_d[l_ac].xcce102h,
                              g_xccd2_d[l_ac].xcce102,g_xccd2_d[l_ac].xcce201,g_xccd2_d[l_ac].xcce202a,g_xccd2_d[l_ac].xcce202b,g_xccd2_d[l_ac].xcce202c,g_xccd2_d[l_ac].xcce202d,g_xccd2_d[l_ac].xcce202e,g_xccd2_d[l_ac].xcce202f,g_xccd2_d[l_ac].xcce202g,g_xccd2_d[l_ac].xcce202h,
                              g_xccd2_d[l_ac].xcce202,g_xccd2_d[l_ac].xcce301,g_xccd2_d[l_ac].xcce302a,g_xccd2_d[l_ac].xcce302b,g_xccd2_d[l_ac].xcce302c,g_xccd2_d[l_ac].xcce302d,g_xccd2_d[l_ac].xcce302e,g_xccd2_d[l_ac].xcce302f,g_xccd2_d[l_ac].xcce302g,g_xccd2_d[l_ac].xcce302h,
                              g_xccd2_d[l_ac].xcce302,g_xccd2_d[l_ac].xcce303,g_xccd2_d[l_ac].xcce304a,g_xccd2_d[l_ac].xcce304b,g_xccd2_d[l_ac].xcce304c,g_xccd2_d[l_ac].xcce304d,g_xccd2_d[l_ac].xcce304e,g_xccd2_d[l_ac].xcce304f,g_xccd2_d[l_ac].xcce304g,g_xccd2_d[l_ac].xcce304h,
                              g_xccd2_d[l_ac].xcce304,g_xccd2_d[l_ac].xcce307,g_xccd2_d[l_ac].xcce308a,g_xccd2_d[l_ac].xcce308b,g_xccd2_d[l_ac].xcce308c,g_xccd2_d[l_ac].xcce308d,g_xccd2_d[l_ac].xcce308e,g_xccd2_d[l_ac].xcce308f,g_xccd2_d[l_ac].xcce308g,g_xccd2_d[l_ac].xcce308h,
                              g_xccd2_d[l_ac].xcce308,g_xccd2_d[l_ac].xcce901,g_xccd2_d[l_ac].xcce902a,g_xccd2_d[l_ac].xcce902b,g_xccd2_d[l_ac].xcce902c,g_xccd2_d[l_ac].xcce902d,g_xccd2_d[l_ac].xcce902e,g_xccd2_d[l_ac].xcce902f,g_xccd2_d[l_ac].xcce902g,g_xccd2_d[l_ac].xcce902h,g_xccd2_d[l_ac].xcce902
                             ,g_xccd2_d[l_ac].xccd007,g_xccd2_d[l_ac].xccd008  #fengmy150303  # add xccd008 liuym150810
                             ,g_xccd2_d[l_ac].xccd301  #151202-00029 by whitney add
                             
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "FOREACH:" 
            LET g_errparam.code   = SQLCA.sqlcode 
            LET g_errparam.popup  = TRUE 
            CALL cl_err()
 
            EXIT FOREACH
         END IF
         IF g_xccd2_d[l_ac].sfaa068 IS NULL THEN LET g_xccd2_d[l_ac].sfaa068 = ' ' END IF #170123-00012#1     
         CALL s_desc_get_department_desc(g_xccd2_d[l_ac].sfaa068) RETURNING g_xccd2_d[l_ac].sfaa068_2_desc
         CALL s_desc_get_item_desc(g_xccd2_d[l_ac].xcce007) RETURNING g_xccd2_d[l_ac].xcce007_2_desc,g_xccd2_d[l_ac].xcce007_2_desc_1
         CALL s_desc_get_unit_desc(g_xccd2_d[l_ac].xcbb005) RETURNING g_xccd2_d[l_ac].xcbb005_2_desc
         CALL s_desc_get_item_desc(g_xccd2_d[l_ac].xccd007) RETURNING g_xccd2_d[l_ac].xccd007_2_desc,g_xccd2_d[l_ac].xccd007_2_desc_desc  #fengmy150304
#合计
         LET l_xcce101_total  = l_xcce101_total  + g_xccd2_d[l_ac].xcce101  #dorislai-20151021-add
         LET l_xcce102a_total = l_xcce102a_total + g_xccd2_d[l_ac].xcce102a
         LET l_xcce102b_total = l_xcce102b_total + g_xccd2_d[l_ac].xcce102b
         LET l_xcce102c_total = l_xcce102c_total + g_xccd2_d[l_ac].xcce102c
         LET l_xcce102d_total = l_xcce102d_total + g_xccd2_d[l_ac].xcce102d
         LET l_xcce102e_total = l_xcce102e_total + g_xccd2_d[l_ac].xcce102e
         LET l_xcce102f_total = l_xcce102f_total + g_xccd2_d[l_ac].xcce102f
         LET l_xcce102g_total = l_xcce102g_total + g_xccd2_d[l_ac].xcce102g
         LET l_xcce102h_total = l_xcce102h_total + g_xccd2_d[l_ac].xcce102h
         LET l_xcce102_total  = l_xcce102_total  + g_xccd2_d[l_ac].xcce102 
         LET l_xcce201_total  = l_xcce201_total  + g_xccd2_d[l_ac].xcce201  #dorislai-20151021-add
         LET l_xcce202a_total = l_xcce202a_total + g_xccd2_d[l_ac].xcce202a
         LET l_xcce202b_total = l_xcce202b_total + g_xccd2_d[l_ac].xcce202b
         LET l_xcce202c_total = l_xcce202c_total + g_xccd2_d[l_ac].xcce202c
         LET l_xcce202d_total = l_xcce202d_total + g_xccd2_d[l_ac].xcce202d
         LET l_xcce202e_total = l_xcce202e_total + g_xccd2_d[l_ac].xcce202e
         LET l_xcce202f_total = l_xcce202f_total + g_xccd2_d[l_ac].xcce202f
         LET l_xcce202g_total = l_xcce202g_total + g_xccd2_d[l_ac].xcce202g
         LET l_xcce202h_total = l_xcce202h_total + g_xccd2_d[l_ac].xcce202h
         LET l_xcce202_total  = l_xcce202_total  + g_xccd2_d[l_ac].xcce202 
         LET l_xcce301_total  = l_xcce301_total  + g_xccd2_d[l_ac].xcce301  #dorislai-20151021-add
         LET l_xcce302a_total = l_xcce302a_total + g_xccd2_d[l_ac].xcce302a
         LET l_xcce302b_total = l_xcce302b_total + g_xccd2_d[l_ac].xcce302b
         LET l_xcce302c_total = l_xcce302c_total + g_xccd2_d[l_ac].xcce302c
         LET l_xcce302d_total = l_xcce302d_total + g_xccd2_d[l_ac].xcce302d
         LET l_xcce302e_total = l_xcce302e_total + g_xccd2_d[l_ac].xcce302e
         LET l_xcce302f_total = l_xcce302f_total + g_xccd2_d[l_ac].xcce302f
         LET l_xcce302g_total = l_xcce302g_total + g_xccd2_d[l_ac].xcce302g
         LET l_xcce302h_total = l_xcce302h_total + g_xccd2_d[l_ac].xcce302h
         LET l_xcce302_total  = l_xcce302_total  + g_xccd2_d[l_ac].xcce302 
         LET l_xcce303_total  = l_xcce303_total  + g_xccd2_d[l_ac].xcce303  #dorislai-20151021-add
         LET l_xcce304a_total = l_xcce304a_total + g_xccd2_d[l_ac].xcce304a
         LET l_xcce304b_total = l_xcce304b_total + g_xccd2_d[l_ac].xcce304b
         LET l_xcce304c_total = l_xcce304c_total + g_xccd2_d[l_ac].xcce304c
         LET l_xcce304d_total = l_xcce304d_total + g_xccd2_d[l_ac].xcce304d
         LET l_xcce304e_total = l_xcce304e_total + g_xccd2_d[l_ac].xcce304e
         LET l_xcce304f_total = l_xcce304f_total + g_xccd2_d[l_ac].xcce304f
         LET l_xcce304g_total = l_xcce304g_total + g_xccd2_d[l_ac].xcce304g
         LET l_xcce304h_total = l_xcce304h_total + g_xccd2_d[l_ac].xcce304h
         LET l_xcce304_total  = l_xcce304_total  + g_xccd2_d[l_ac].xcce304 
         LET l_xcce307_total  = l_xcce307_total  + g_xccd2_d[l_ac].xcce307  #dorislai-20151021-add
         LET l_xcce308a_total = l_xcce308a_total + g_xccd2_d[l_ac].xcce308a
         LET l_xcce308b_total = l_xcce308b_total + g_xccd2_d[l_ac].xcce308b
         LET l_xcce308c_total = l_xcce308c_total + g_xccd2_d[l_ac].xcce308c
         LET l_xcce308d_total = l_xcce308d_total + g_xccd2_d[l_ac].xcce308d
         LET l_xcce308e_total = l_xcce308e_total + g_xccd2_d[l_ac].xcce308e
         LET l_xcce308f_total = l_xcce308f_total + g_xccd2_d[l_ac].xcce308f
         LET l_xcce308g_total = l_xcce308g_total + g_xccd2_d[l_ac].xcce308g
         LET l_xcce308h_total = l_xcce308h_total + g_xccd2_d[l_ac].xcce308h
         LET l_xcce308_total  = l_xcce308_total  + g_xccd2_d[l_ac].xcce308 
         LET l_xcce901_total  = l_xcce901_total  + g_xccd2_d[l_ac].xcce901  #dorislai-20151021-add
         LET l_xcce902a_total = l_xcce902a_total + g_xccd2_d[l_ac].xcce902a
         LET l_xcce902b_total = l_xcce902b_total + g_xccd2_d[l_ac].xcce902b
         LET l_xcce902c_total = l_xcce902c_total + g_xccd2_d[l_ac].xcce902c
         LET l_xcce902d_total = l_xcce902d_total + g_xccd2_d[l_ac].xcce902d
         LET l_xcce902e_total = l_xcce902e_total + g_xccd2_d[l_ac].xcce902e
         LET l_xcce902f_total = l_xcce902f_total + g_xccd2_d[l_ac].xcce902f
         LET l_xcce902g_total = l_xcce902g_total + g_xccd2_d[l_ac].xcce902g
         LET l_xcce902h_total = l_xcce902h_total + g_xccd2_d[l_ac].xcce902h
         LET l_xcce902_total  = l_xcce902_total  + g_xccd2_d[l_ac].xcce902 
#按单号小计
         LET l_xcce101_sum1  = l_xcce101_sum1  + g_xccd2_d[l_ac].xcce101  #dorislai-20151021-add
         LET l_xcce102a_sum1 = l_xcce102a_sum1 + g_xccd2_d[l_ac].xcce102a
         LET l_xcce102b_sum1 = l_xcce102b_sum1 + g_xccd2_d[l_ac].xcce102b
         LET l_xcce102c_sum1 = l_xcce102c_sum1 + g_xccd2_d[l_ac].xcce102c
         LET l_xcce102d_sum1 = l_xcce102d_sum1 + g_xccd2_d[l_ac].xcce102d
         LET l_xcce102e_sum1 = l_xcce102e_sum1 + g_xccd2_d[l_ac].xcce102e
         LET l_xcce102f_sum1 = l_xcce102f_sum1 + g_xccd2_d[l_ac].xcce102f
         LET l_xcce102g_sum1 = l_xcce102g_sum1 + g_xccd2_d[l_ac].xcce102g
         LET l_xcce102h_sum1 = l_xcce102h_sum1 + g_xccd2_d[l_ac].xcce102h
         LET l_xcce102_sum1  = l_xcce102_sum1  + g_xccd2_d[l_ac].xcce102 
         LET l_xcce201_sum1  = l_xcce201_sum1  + g_xccd2_d[l_ac].xcce201  #dorislai-20151021-add
         LET l_xcce202a_sum1 = l_xcce202a_sum1 + g_xccd2_d[l_ac].xcce202a
         LET l_xcce202b_sum1 = l_xcce202b_sum1 + g_xccd2_d[l_ac].xcce202b
         LET l_xcce202c_sum1 = l_xcce202c_sum1 + g_xccd2_d[l_ac].xcce202c
         LET l_xcce202d_sum1 = l_xcce202d_sum1 + g_xccd2_d[l_ac].xcce202d
         LET l_xcce202e_sum1 = l_xcce202e_sum1 + g_xccd2_d[l_ac].xcce202e
         LET l_xcce202f_sum1 = l_xcce202f_sum1 + g_xccd2_d[l_ac].xcce202f
         LET l_xcce202g_sum1 = l_xcce202g_sum1 + g_xccd2_d[l_ac].xcce202g
         LET l_xcce202h_sum1 = l_xcce202h_sum1 + g_xccd2_d[l_ac].xcce202h
         LET l_xcce202_sum1  = l_xcce202_sum1  + g_xccd2_d[l_ac].xcce202 
         LET l_xcce301_sum1  = l_xcce301_sum1  + g_xccd2_d[l_ac].xcce301  #dorislai-20151021-add
         LET l_xcce302a_sum1 = l_xcce302a_sum1 + g_xccd2_d[l_ac].xcce302a
         LET l_xcce302b_sum1 = l_xcce302b_sum1 + g_xccd2_d[l_ac].xcce302b
         LET l_xcce302c_sum1 = l_xcce302c_sum1 + g_xccd2_d[l_ac].xcce302c
         LET l_xcce302d_sum1 = l_xcce302d_sum1 + g_xccd2_d[l_ac].xcce302d
         LET l_xcce302e_sum1 = l_xcce302e_sum1 + g_xccd2_d[l_ac].xcce302e
         LET l_xcce302f_sum1 = l_xcce302f_sum1 + g_xccd2_d[l_ac].xcce302f
         LET l_xcce302g_sum1 = l_xcce302g_sum1 + g_xccd2_d[l_ac].xcce302g
         LET l_xcce302h_sum1 = l_xcce302h_sum1 + g_xccd2_d[l_ac].xcce302h
         LET l_xcce302_sum1  = l_xcce302_sum1  + g_xccd2_d[l_ac].xcce302 
         LET l_xcce303_sum1  = l_xcce303_sum1  + g_xccd2_d[l_ac].xcce303  #dorislai-20151021-add
         LET l_xcce304a_sum1 = l_xcce304a_sum1 + g_xccd2_d[l_ac].xcce304a
         LET l_xcce304b_sum1 = l_xcce304b_sum1 + g_xccd2_d[l_ac].xcce304b
         LET l_xcce304c_sum1 = l_xcce304c_sum1 + g_xccd2_d[l_ac].xcce304c
         LET l_xcce304d_sum1 = l_xcce304d_sum1 + g_xccd2_d[l_ac].xcce304d
         LET l_xcce304e_sum1 = l_xcce304e_sum1 + g_xccd2_d[l_ac].xcce304e
         LET l_xcce304f_sum1 = l_xcce304f_sum1 + g_xccd2_d[l_ac].xcce304f
         LET l_xcce304g_sum1 = l_xcce304g_sum1 + g_xccd2_d[l_ac].xcce304g
         LET l_xcce304h_sum1 = l_xcce304h_sum1 + g_xccd2_d[l_ac].xcce304h
         LET l_xcce304_sum1  = l_xcce304_sum1  + g_xccd2_d[l_ac].xcce304 
         LET l_xcce307_sum1  = l_xcce307_sum1  + g_xccd2_d[l_ac].xcce307  #dorislai-20151021-add
         LET l_xcce308a_sum1 = l_xcce308a_sum1 + g_xccd2_d[l_ac].xcce308a
         LET l_xcce308b_sum1 = l_xcce308b_sum1 + g_xccd2_d[l_ac].xcce308b
         LET l_xcce308c_sum1 = l_xcce308c_sum1 + g_xccd2_d[l_ac].xcce308c
         LET l_xcce308d_sum1 = l_xcce308d_sum1 + g_xccd2_d[l_ac].xcce308d
         LET l_xcce308e_sum1 = l_xcce308e_sum1 + g_xccd2_d[l_ac].xcce308e
         LET l_xcce308f_sum1 = l_xcce308f_sum1 + g_xccd2_d[l_ac].xcce308f
         LET l_xcce308g_sum1 = l_xcce308g_sum1 + g_xccd2_d[l_ac].xcce308g
         LET l_xcce308h_sum1 = l_xcce308h_sum1 + g_xccd2_d[l_ac].xcce308h
         LET l_xcce308_sum1  = l_xcce308_sum1  + g_xccd2_d[l_ac].xcce308 
         LET l_xcce901_sum1  = l_xcce901_sum1  + g_xccd2_d[l_ac].xcce901  #dorislai-20151021-add
         LET l_xcce902a_sum1 = l_xcce902a_sum1 + g_xccd2_d[l_ac].xcce902a
         LET l_xcce902b_sum1 = l_xcce902b_sum1 + g_xccd2_d[l_ac].xcce902b
         LET l_xcce902c_sum1 = l_xcce902c_sum1 + g_xccd2_d[l_ac].xcce902c
         LET l_xcce902d_sum1 = l_xcce902d_sum1 + g_xccd2_d[l_ac].xcce902d
         LET l_xcce902e_sum1 = l_xcce902e_sum1 + g_xccd2_d[l_ac].xcce902e
         LET l_xcce902f_sum1 = l_xcce902f_sum1 + g_xccd2_d[l_ac].xcce902f
         LET l_xcce902g_sum1 = l_xcce902g_sum1 + g_xccd2_d[l_ac].xcce902g
         LET l_xcce902h_sum1 = l_xcce902h_sum1 + g_xccd2_d[l_ac].xcce902h
         LET l_xcce902_sum1  = l_xcce902_sum1  + g_xccd2_d[l_ac].xcce902 
         IF l_ac > 1 THEN
            IF g_xccd2_d[l_ac].xcce006 != g_xccd2_d[l_ac-1].xcce006 THEN
               #把当前行下移，并在当前行显示小计
               LET g_xccd2_d[l_ac + 1].* = g_xccd2_d[l_ac].*  
               INITIALIZE  g_xccd2_d[l_ac].* TO NULL
               #LET g_xccd2_d[l_ac].xcce006  = cl_getmsg("axc-00577",g_lang) #160201-00004#1 mark
               LET g_xccd2_d[l_ac].xcce006  = cl_getmsg("lib-00156",g_lang),"-",g_xccd2_d[l_ac-1].xcce006 #160201-00004#1 
               #170123-00012#1---mark---s            
               ##160108-00001#1-add----(S)
               #LET g_xccd2_d[l_ac].xccd007  = g_xccd2_d[l_ac-1].xccd007 
               #LET g_xccd2_d[l_ac].xccd007_2_desc  = g_xccd2_d[l_ac-1].xccd007_2_desc 
               #LET g_xccd2_d[l_ac].xccd007_2_desc_desc  = g_xccd2_d[l_ac-1].xccd007_2_desc_desc
               ##160108-00001#1-add----(E)
               #170123-00012#1---mark---e            
               LET g_xccd2_d[l_ac].xccd301  = g_xccd2_d[l_ac-1].xccd301 #160106-00012#1-add               
               LET g_xccd2_d[l_ac].xcce101  = l_xcce101_sum1  - g_xccd2_d[l_ac+1].xcce101  #dorislai-20151021-add
               LET g_xccd2_d[l_ac].xcce102a = l_xcce102a_sum1 - g_xccd2_d[l_ac+1].xcce102a
               LET g_xccd2_d[l_ac].xcce102b = l_xcce102b_sum1 - g_xccd2_d[l_ac+1].xcce102b
               LET g_xccd2_d[l_ac].xcce102c = l_xcce102c_sum1 - g_xccd2_d[l_ac+1].xcce102c
               LET g_xccd2_d[l_ac].xcce102d = l_xcce102d_sum1 - g_xccd2_d[l_ac+1].xcce102d
               LET g_xccd2_d[l_ac].xcce102e = l_xcce102e_sum1 - g_xccd2_d[l_ac+1].xcce102e
               LET g_xccd2_d[l_ac].xcce102f = l_xcce102f_sum1 - g_xccd2_d[l_ac+1].xcce102f
               LET g_xccd2_d[l_ac].xcce102g = l_xcce102g_sum1 - g_xccd2_d[l_ac+1].xcce102g
               LET g_xccd2_d[l_ac].xcce102h = l_xcce102h_sum1 - g_xccd2_d[l_ac+1].xcce102h
               LET g_xccd2_d[l_ac].xcce102  = l_xcce102_sum1  - g_xccd2_d[l_ac+1].xcce102
               LET g_xccd2_d[l_ac].xcce201  = l_xcce201_sum1  - g_xccd2_d[l_ac+1].xcce201  #dorislai-20151021-add
               LET g_xccd2_d[l_ac].xcce202a = l_xcce202a_sum1 - g_xccd2_d[l_ac+1].xcce202a            
               LET g_xccd2_d[l_ac].xcce202b = l_xcce202b_sum1 - g_xccd2_d[l_ac+1].xcce202b
               LET g_xccd2_d[l_ac].xcce202c = l_xcce202c_sum1 - g_xccd2_d[l_ac+1].xcce202c
               LET g_xccd2_d[l_ac].xcce202d = l_xcce202d_sum1 - g_xccd2_d[l_ac+1].xcce202d
               LET g_xccd2_d[l_ac].xcce202e = l_xcce202e_sum1 - g_xccd2_d[l_ac+1].xcce202e
               LET g_xccd2_d[l_ac].xcce202f = l_xcce202f_sum1 - g_xccd2_d[l_ac+1].xcce202f
               LET g_xccd2_d[l_ac].xcce202g = l_xcce202g_sum1 - g_xccd2_d[l_ac+1].xcce202g
               LET g_xccd2_d[l_ac].xcce202h = l_xcce202h_sum1 - g_xccd2_d[l_ac+1].xcce202h
               LET g_xccd2_d[l_ac].xcce202  = l_xcce202_sum1  - g_xccd2_d[l_ac+1].xcce202 
               LET g_xccd2_d[l_ac].xcce301  = l_xcce301_sum1  - g_xccd2_d[l_ac+1].xcce301  #dorislai-20151021-add
               LET g_xccd2_d[l_ac].xcce302a = l_xcce302a_sum1 - g_xccd2_d[l_ac+1].xcce302a
               LET g_xccd2_d[l_ac].xcce302b = l_xcce302b_sum1 - g_xccd2_d[l_ac+1].xcce302b
               LET g_xccd2_d[l_ac].xcce302c = l_xcce302c_sum1 - g_xccd2_d[l_ac+1].xcce302c
               LET g_xccd2_d[l_ac].xcce302d = l_xcce302d_sum1 - g_xccd2_d[l_ac+1].xcce302d
               LET g_xccd2_d[l_ac].xcce302e = l_xcce302e_sum1 - g_xccd2_d[l_ac+1].xcce302e
               LET g_xccd2_d[l_ac].xcce302f = l_xcce302f_sum1 - g_xccd2_d[l_ac+1].xcce302f
               LET g_xccd2_d[l_ac].xcce302g = l_xcce302g_sum1 - g_xccd2_d[l_ac+1].xcce302g
               LET g_xccd2_d[l_ac].xcce302h = l_xcce302h_sum1 - g_xccd2_d[l_ac+1].xcce302h
               LET g_xccd2_d[l_ac].xcce302  = l_xcce302_sum1  - g_xccd2_d[l_ac+1].xcce302 
               LET g_xccd2_d[l_ac].xcce303  = l_xcce301_sum1  - g_xccd2_d[l_ac+1].xcce303  #dorislai-20151021-add
               LET g_xccd2_d[l_ac].xcce304a = l_xcce304a_sum1 - g_xccd2_d[l_ac+1].xcce304a
               LET g_xccd2_d[l_ac].xcce304b = l_xcce304b_sum1 - g_xccd2_d[l_ac+1].xcce304b
               LET g_xccd2_d[l_ac].xcce304c = l_xcce304c_sum1 - g_xccd2_d[l_ac+1].xcce304c
               LET g_xccd2_d[l_ac].xcce304d = l_xcce304d_sum1 - g_xccd2_d[l_ac+1].xcce304d
               LET g_xccd2_d[l_ac].xcce304e = l_xcce304e_sum1 - g_xccd2_d[l_ac+1].xcce304e
               LET g_xccd2_d[l_ac].xcce304f = l_xcce304f_sum1 - g_xccd2_d[l_ac+1].xcce304f
               LET g_xccd2_d[l_ac].xcce304g = l_xcce304g_sum1 - g_xccd2_d[l_ac+1].xcce304g
               LET g_xccd2_d[l_ac].xcce304h = l_xcce304h_sum1 - g_xccd2_d[l_ac+1].xcce304h
               LET g_xccd2_d[l_ac].xcce304  = l_xcce304_sum1  - g_xccd2_d[l_ac+1].xcce304 
               LET g_xccd2_d[l_ac].xcce307  = l_xcce307_sum1  - g_xccd2_d[l_ac+1].xcce307  #dorislai-20151021-add
               LET g_xccd2_d[l_ac].xcce308a = l_xcce308a_sum1 - g_xccd2_d[l_ac+1].xcce308a
               LET g_xccd2_d[l_ac].xcce308b = l_xcce308b_sum1 - g_xccd2_d[l_ac+1].xcce308b
               LET g_xccd2_d[l_ac].xcce308c = l_xcce308c_sum1 - g_xccd2_d[l_ac+1].xcce308c
               LET g_xccd2_d[l_ac].xcce308d = l_xcce308d_sum1 - g_xccd2_d[l_ac+1].xcce308d
               LET g_xccd2_d[l_ac].xcce308e = l_xcce308e_sum1 - g_xccd2_d[l_ac+1].xcce308e
               LET g_xccd2_d[l_ac].xcce308f = l_xcce308f_sum1 - g_xccd2_d[l_ac+1].xcce308f
               LET g_xccd2_d[l_ac].xcce308g = l_xcce308g_sum1 - g_xccd2_d[l_ac+1].xcce308g
               LET g_xccd2_d[l_ac].xcce308h = l_xcce308h_sum1 - g_xccd2_d[l_ac+1].xcce308h
               LET g_xccd2_d[l_ac].xcce308  = l_xcce308_sum1  - g_xccd2_d[l_ac+1].xcce308 
               LET g_xccd2_d[l_ac].xcce901  = l_xcce901_sum1  - g_xccd2_d[l_ac+1].xcce901  #dorislai-20151021-add
               LET g_xccd2_d[l_ac].xcce902a = l_xcce902a_sum1 - g_xccd2_d[l_ac+1].xcce902a
               LET g_xccd2_d[l_ac].xcce902b = l_xcce902b_sum1 - g_xccd2_d[l_ac+1].xcce902b
               LET g_xccd2_d[l_ac].xcce902c = l_xcce902c_sum1 - g_xccd2_d[l_ac+1].xcce902c
               LET g_xccd2_d[l_ac].xcce902d = l_xcce902d_sum1 - g_xccd2_d[l_ac+1].xcce902d
               LET g_xccd2_d[l_ac].xcce902e = l_xcce902e_sum1 - g_xccd2_d[l_ac+1].xcce902e
               LET g_xccd2_d[l_ac].xcce902f = l_xcce902f_sum1 - g_xccd2_d[l_ac+1].xcce902f
               LET g_xccd2_d[l_ac].xcce902g = l_xcce902g_sum1 - g_xccd2_d[l_ac+1].xcce902g
               LET g_xccd2_d[l_ac].xcce902h = l_xcce902h_sum1 - g_xccd2_d[l_ac+1].xcce902h
               LET g_xccd2_d[l_ac].xcce902  = l_xcce902_sum1  - g_xccd2_d[l_ac+1].xcce902 
               LET l_ac = l_ac + 1
               LET l_xcce101_sum1  = g_xccd2_d[l_ac].xcce101  #dorislai-20151021-add
               LET l_xcce102a_sum1 = g_xccd2_d[l_ac].xcce102a
               LET l_xcce102b_sum1 = g_xccd2_d[l_ac].xcce102b
               LET l_xcce102c_sum1 = g_xccd2_d[l_ac].xcce102c
               LET l_xcce102d_sum1 = g_xccd2_d[l_ac].xcce102d
               LET l_xcce102e_sum1 = g_xccd2_d[l_ac].xcce102e
               LET l_xcce102f_sum1 = g_xccd2_d[l_ac].xcce102f
               LET l_xcce102g_sum1 = g_xccd2_d[l_ac].xcce102g
               LET l_xcce102h_sum1 = g_xccd2_d[l_ac].xcce102h
               LET l_xcce102_sum1  = g_xccd2_d[l_ac].xcce102
               LET l_xcce201_sum1  = g_xccd2_d[l_ac].xcce201  #dorislai-20151021-add
               LET l_xcce202a_sum1 = g_xccd2_d[l_ac].xcce202a            
               LET l_xcce202b_sum1 = g_xccd2_d[l_ac].xcce202b
               LET l_xcce202c_sum1 = g_xccd2_d[l_ac].xcce202c
               LET l_xcce202d_sum1 = g_xccd2_d[l_ac].xcce202d
               LET l_xcce202e_sum1 = g_xccd2_d[l_ac].xcce202e
               LET l_xcce202f_sum1 = g_xccd2_d[l_ac].xcce202f
               LET l_xcce202g_sum1 = g_xccd2_d[l_ac].xcce202g
               LET l_xcce202h_sum1 = g_xccd2_d[l_ac].xcce202h
               LET l_xcce202_sum1  = g_xccd2_d[l_ac].xcce202 
               LET l_xcce301_sum1  = g_xccd2_d[l_ac].xcce301  #dorislai-20151021-add
               LET l_xcce302a_sum1 = g_xccd2_d[l_ac].xcce302a
               LET l_xcce302b_sum1 = g_xccd2_d[l_ac].xcce302b
               LET l_xcce302c_sum1 = g_xccd2_d[l_ac].xcce302c
               LET l_xcce302d_sum1 = g_xccd2_d[l_ac].xcce302d
               LET l_xcce302e_sum1 = g_xccd2_d[l_ac].xcce302e
               LET l_xcce302f_sum1 = g_xccd2_d[l_ac].xcce302f
               LET l_xcce302g_sum1 = g_xccd2_d[l_ac].xcce302g
               LET l_xcce302h_sum1 = g_xccd2_d[l_ac].xcce302h
               LET l_xcce302_sum1  = g_xccd2_d[l_ac].xcce302 
               LET l_xcce303_sum1  = g_xccd2_d[l_ac].xcce303  #dorislai-20151021-add
               LET l_xcce304a_sum1 = g_xccd2_d[l_ac].xcce304a
               LET l_xcce304b_sum1 = g_xccd2_d[l_ac].xcce304b
               LET l_xcce304c_sum1 = g_xccd2_d[l_ac].xcce304c
               LET l_xcce304d_sum1 = g_xccd2_d[l_ac].xcce304d
               LET l_xcce304e_sum1 = g_xccd2_d[l_ac].xcce304e
               LET l_xcce304f_sum1 = g_xccd2_d[l_ac].xcce304f
               LET l_xcce304g_sum1 = g_xccd2_d[l_ac].xcce304g
               LET l_xcce304h_sum1 = g_xccd2_d[l_ac].xcce304h
               LET l_xcce304_sum1  = g_xccd2_d[l_ac].xcce304 
               LET l_xcce307_sum1  = g_xccd2_d[l_ac].xcce307  #dorislai-20151021-add
               LET l_xcce308a_sum1 = g_xccd2_d[l_ac].xcce308a
               LET l_xcce308b_sum1 = g_xccd2_d[l_ac].xcce308b
               LET l_xcce308c_sum1 = g_xccd2_d[l_ac].xcce308c
               LET l_xcce308d_sum1 = g_xccd2_d[l_ac].xcce308d
               LET l_xcce308e_sum1 = g_xccd2_d[l_ac].xcce308e
               LET l_xcce308f_sum1 = g_xccd2_d[l_ac].xcce308f
               LET l_xcce308g_sum1 = g_xccd2_d[l_ac].xcce308g
               LET l_xcce308h_sum1 = g_xccd2_d[l_ac].xcce308h
               LET l_xcce308_sum1  = g_xccd2_d[l_ac].xcce308 
               LET l_xcce901_sum1  = g_xccd2_d[l_ac].xcce901  #dorislai-20151021-add
               LET l_xcce902a_sum1 = g_xccd2_d[l_ac].xcce902a
               LET l_xcce902b_sum1 = g_xccd2_d[l_ac].xcce902b
               LET l_xcce902c_sum1 = g_xccd2_d[l_ac].xcce902c
               LET l_xcce902d_sum1 = g_xccd2_d[l_ac].xcce902d
               LET l_xcce902e_sum1 = g_xccd2_d[l_ac].xcce902e
               LET l_xcce902f_sum1 = g_xccd2_d[l_ac].xcce902f
               LET l_xcce902g_sum1 = g_xccd2_d[l_ac].xcce902g
               LET l_xcce902h_sum1 = g_xccd2_d[l_ac].xcce902h
               LET l_xcce902_sum1  = g_xccd2_d[l_ac].xcce902 
            END IF            
         END IF         
#按组织小计
         LET l_xcce101_sum2  = l_xcce101_sum2  + g_xccd2_d[l_ac].xcce101  #dorislai-20151021-add
         LET l_xcce102a_sum2 = l_xcce102a_sum2 + g_xccd2_d[l_ac].xcce102a
         LET l_xcce102b_sum2 = l_xcce102b_sum2 + g_xccd2_d[l_ac].xcce102b
         LET l_xcce102c_sum2 = l_xcce102c_sum2 + g_xccd2_d[l_ac].xcce102c
         LET l_xcce102d_sum2 = l_xcce102d_sum2 + g_xccd2_d[l_ac].xcce102d
         LET l_xcce102e_sum2 = l_xcce102e_sum2 + g_xccd2_d[l_ac].xcce102e
         LET l_xcce102f_sum2 = l_xcce102f_sum2 + g_xccd2_d[l_ac].xcce102f
         LET l_xcce102g_sum2 = l_xcce102g_sum2 + g_xccd2_d[l_ac].xcce102g
         LET l_xcce102h_sum2 = l_xcce102h_sum2 + g_xccd2_d[l_ac].xcce102h
         LET l_xcce102_sum2  = l_xcce102_sum2  + g_xccd2_d[l_ac].xcce102 
         LET l_xcce201_sum2  = l_xcce201_sum2  + g_xccd2_d[l_ac].xcce201  #dorislai-20151021-add
         LET l_xcce202a_sum2 = l_xcce202a_sum2 + g_xccd2_d[l_ac].xcce202a
         LET l_xcce202b_sum2 = l_xcce202b_sum2 + g_xccd2_d[l_ac].xcce202b
         LET l_xcce202c_sum2 = l_xcce202c_sum2 + g_xccd2_d[l_ac].xcce202c
         LET l_xcce202d_sum2 = l_xcce202d_sum2 + g_xccd2_d[l_ac].xcce202d
         LET l_xcce202e_sum2 = l_xcce202e_sum2 + g_xccd2_d[l_ac].xcce202e
         LET l_xcce202f_sum2 = l_xcce202f_sum2 + g_xccd2_d[l_ac].xcce202f
         LET l_xcce202g_sum2 = l_xcce202g_sum2 + g_xccd2_d[l_ac].xcce202g
         LET l_xcce202h_sum2 = l_xcce202h_sum2 + g_xccd2_d[l_ac].xcce202h
         LET l_xcce202_sum2  = l_xcce202_sum2  + g_xccd2_d[l_ac].xcce202 
         LET l_xcce301_sum2  = l_xcce301_sum2  + g_xccd2_d[l_ac].xcce301  #dorislai-20151021-add
         LET l_xcce302a_sum2 = l_xcce302a_sum2 + g_xccd2_d[l_ac].xcce302a
         LET l_xcce302b_sum2 = l_xcce302b_sum2 + g_xccd2_d[l_ac].xcce302b
         LET l_xcce302c_sum2 = l_xcce302c_sum2 + g_xccd2_d[l_ac].xcce302c
         LET l_xcce302d_sum2 = l_xcce302d_sum2 + g_xccd2_d[l_ac].xcce302d
         LET l_xcce302e_sum2 = l_xcce302e_sum2 + g_xccd2_d[l_ac].xcce302e
         LET l_xcce302f_sum2 = l_xcce302f_sum2 + g_xccd2_d[l_ac].xcce302f
         LET l_xcce302g_sum2 = l_xcce302g_sum2 + g_xccd2_d[l_ac].xcce302g
         LET l_xcce302h_sum2 = l_xcce302h_sum2 + g_xccd2_d[l_ac].xcce302h
         LET l_xcce302_sum2  = l_xcce302_sum2  + g_xccd2_d[l_ac].xcce302 
         LET l_xcce303_sum2  = l_xcce303_sum2  + g_xccd2_d[l_ac].xcce303  #dorislai-20151021-add
         LET l_xcce304a_sum2 = l_xcce304a_sum2 + g_xccd2_d[l_ac].xcce304a
         LET l_xcce304b_sum2 = l_xcce304b_sum2 + g_xccd2_d[l_ac].xcce304b
         LET l_xcce304c_sum2 = l_xcce304c_sum2 + g_xccd2_d[l_ac].xcce304c
         LET l_xcce304d_sum2 = l_xcce304d_sum2 + g_xccd2_d[l_ac].xcce304d
         LET l_xcce304e_sum2 = l_xcce304e_sum2 + g_xccd2_d[l_ac].xcce304e
         LET l_xcce304f_sum2 = l_xcce304f_sum2 + g_xccd2_d[l_ac].xcce304f
         LET l_xcce304g_sum2 = l_xcce304g_sum2 + g_xccd2_d[l_ac].xcce304g
         LET l_xcce304h_sum2 = l_xcce304h_sum2 + g_xccd2_d[l_ac].xcce304h
         LET l_xcce304_sum2  = l_xcce304_sum2  + g_xccd2_d[l_ac].xcce304 
         LET l_xcce307_sum2  = l_xcce307_sum2  + g_xccd2_d[l_ac].xcce307  #dorislai-20151021-add
         LET l_xcce308a_sum2 = l_xcce308a_sum2 + g_xccd2_d[l_ac].xcce308a
         LET l_xcce308b_sum2 = l_xcce308b_sum2 + g_xccd2_d[l_ac].xcce308b
         LET l_xcce308c_sum2 = l_xcce308c_sum2 + g_xccd2_d[l_ac].xcce308c
         LET l_xcce308d_sum2 = l_xcce308d_sum2 + g_xccd2_d[l_ac].xcce308d
         LET l_xcce308e_sum2 = l_xcce308e_sum2 + g_xccd2_d[l_ac].xcce308e
         LET l_xcce308f_sum2 = l_xcce308f_sum2 + g_xccd2_d[l_ac].xcce308f
         LET l_xcce308g_sum2 = l_xcce308g_sum2 + g_xccd2_d[l_ac].xcce308g
         LET l_xcce308h_sum2 = l_xcce308h_sum2 + g_xccd2_d[l_ac].xcce308h
         LET l_xcce308_sum2  = l_xcce308_sum2  + g_xccd2_d[l_ac].xcce308 
         LET l_xcce901_sum2  = l_xcce901_sum2  + g_xccd2_d[l_ac].xcce901  #dorislai-20151021-add
         LET l_xcce902a_sum2 = l_xcce902a_sum2 + g_xccd2_d[l_ac].xcce902a
         LET l_xcce902b_sum2 = l_xcce902b_sum2 + g_xccd2_d[l_ac].xcce902b
         LET l_xcce902c_sum2 = l_xcce902c_sum2 + g_xccd2_d[l_ac].xcce902c
         LET l_xcce902d_sum2 = l_xcce902d_sum2 + g_xccd2_d[l_ac].xcce902d
         LET l_xcce902e_sum2 = l_xcce902e_sum2 + g_xccd2_d[l_ac].xcce902e
         LET l_xcce902f_sum2 = l_xcce902f_sum2 + g_xccd2_d[l_ac].xcce902f
         LET l_xcce902g_sum2 = l_xcce902g_sum2 + g_xccd2_d[l_ac].xcce902g
         LET l_xcce902h_sum2 = l_xcce902h_sum2 + g_xccd2_d[l_ac].xcce902h
         LET l_xcce902_sum2  = l_xcce902_sum2  + g_xccd2_d[l_ac].xcce902 
         IF l_ac > 2 THEN
            #IF g_xccd2_d[l_ac].sfaa068 != g_xccd2_d[l_ac-2].sfaa068 THEN  #170123-00012#1 mark
            IF g_xccd2_d[l_ac].sfaa068 != g_xccd2_d[l_ac-2].sfaa068 AND g_xccd2_d[l_ac].xcce006 != g_xccd2_d[l_ac-1].xcce006 THEN  #170123-00012#1
               #把当前行下移，并在当前行显示小计
               LET g_xccd2_d[l_ac + 1].* = g_xccd2_d[l_ac].*  
               INITIALIZE  g_xccd2_d[l_ac].* TO NULL
               #LET g_xccd2_d[l_ac].sfaa068  = cl_getmsg("axc-00578",g_lang) #160201-00004#1 mark            
               #LET g_xccd2_d[l_ac].sfaa068  = cl_getmsg("lib-00156",g_lang),"-",g_xccd2_d[l_ac-2].sfaa068   #160201-00004#1   #170123-00012#1 mark       
               LET g_xccd2_d[l_ac].sfaa068  = cl_getmsg("aps-00134",g_lang),"-",g_xccd2_d[l_ac-2].sfaa068   #170123-00012#1        
               LET g_xccd2_d[l_ac].xcce101  = l_xcce101_sum2  - g_xccd2_d[l_ac+1].xcce101  #dorislai-20151021-add
               LET g_xccd2_d[l_ac].xcce102a = l_xcce102a_sum2 - g_xccd2_d[l_ac+1].xcce102a
               LET g_xccd2_d[l_ac].xcce102b = l_xcce102b_sum2 - g_xccd2_d[l_ac+1].xcce102b
               LET g_xccd2_d[l_ac].xcce102c = l_xcce102c_sum2 - g_xccd2_d[l_ac+1].xcce102c
               LET g_xccd2_d[l_ac].xcce102d = l_xcce102d_sum2 - g_xccd2_d[l_ac+1].xcce102d
               LET g_xccd2_d[l_ac].xcce102e = l_xcce102e_sum2 - g_xccd2_d[l_ac+1].xcce102e
               LET g_xccd2_d[l_ac].xcce102f = l_xcce102f_sum2 - g_xccd2_d[l_ac+1].xcce102f
               LET g_xccd2_d[l_ac].xcce102g = l_xcce102g_sum2 - g_xccd2_d[l_ac+1].xcce102g
               LET g_xccd2_d[l_ac].xcce102h = l_xcce102h_sum2 - g_xccd2_d[l_ac+1].xcce102h
               LET g_xccd2_d[l_ac].xcce102  = l_xcce102_sum2  - g_xccd2_d[l_ac+1].xcce102
               LET g_xccd2_d[l_ac].xcce201  = l_xcce201_sum2  - g_xccd2_d[l_ac+1].xcce201  #dorislai-20151021-add
               LET g_xccd2_d[l_ac].xcce202a = l_xcce202a_sum2 - g_xccd2_d[l_ac+1].xcce202a            
               LET g_xccd2_d[l_ac].xcce202b = l_xcce202b_sum2 - g_xccd2_d[l_ac+1].xcce202b
               LET g_xccd2_d[l_ac].xcce202c = l_xcce202c_sum2 - g_xccd2_d[l_ac+1].xcce202c
               LET g_xccd2_d[l_ac].xcce202d = l_xcce202d_sum2 - g_xccd2_d[l_ac+1].xcce202d
               LET g_xccd2_d[l_ac].xcce202e = l_xcce202e_sum2 - g_xccd2_d[l_ac+1].xcce202e
               LET g_xccd2_d[l_ac].xcce202f = l_xcce202f_sum2 - g_xccd2_d[l_ac+1].xcce202f
               LET g_xccd2_d[l_ac].xcce202g = l_xcce202g_sum2 - g_xccd2_d[l_ac+1].xcce202g
               LET g_xccd2_d[l_ac].xcce202h = l_xcce202h_sum2 - g_xccd2_d[l_ac+1].xcce202h
               LET g_xccd2_d[l_ac].xcce202  = l_xcce202_sum2  - g_xccd2_d[l_ac+1].xcce202 
               LET g_xccd2_d[l_ac].xcce301  = l_xcce301_sum2  - g_xccd2_d[l_ac+1].xcce301  #dorislai-20151021-add
               LET g_xccd2_d[l_ac].xcce302a = l_xcce302a_sum2 - g_xccd2_d[l_ac+1].xcce302a
               LET g_xccd2_d[l_ac].xcce302b = l_xcce302b_sum2 - g_xccd2_d[l_ac+1].xcce302b
               LET g_xccd2_d[l_ac].xcce302c = l_xcce302c_sum2 - g_xccd2_d[l_ac+1].xcce302c
               LET g_xccd2_d[l_ac].xcce302d = l_xcce302d_sum2 - g_xccd2_d[l_ac+1].xcce302d
               LET g_xccd2_d[l_ac].xcce302e = l_xcce302e_sum2 - g_xccd2_d[l_ac+1].xcce302e
               LET g_xccd2_d[l_ac].xcce302f = l_xcce302f_sum2 - g_xccd2_d[l_ac+1].xcce302f
               LET g_xccd2_d[l_ac].xcce302g = l_xcce302g_sum2 - g_xccd2_d[l_ac+1].xcce302g
               LET g_xccd2_d[l_ac].xcce302h = l_xcce302h_sum2 - g_xccd2_d[l_ac+1].xcce302h
               LET g_xccd2_d[l_ac].xcce302  = l_xcce302_sum2  - g_xccd2_d[l_ac+1].xcce302 
               LET g_xccd2_d[l_ac].xcce303  = l_xcce303_sum2  - g_xccd2_d[l_ac+1].xcce303  #dorislai-20151021-add
               LET g_xccd2_d[l_ac].xcce304a = l_xcce304a_sum2 - g_xccd2_d[l_ac+1].xcce304a
               LET g_xccd2_d[l_ac].xcce304b = l_xcce304b_sum2 - g_xccd2_d[l_ac+1].xcce304b
               LET g_xccd2_d[l_ac].xcce304c = l_xcce304c_sum2 - g_xccd2_d[l_ac+1].xcce304c
               LET g_xccd2_d[l_ac].xcce304d = l_xcce304d_sum2 - g_xccd2_d[l_ac+1].xcce304d
               LET g_xccd2_d[l_ac].xcce304e = l_xcce304e_sum2 - g_xccd2_d[l_ac+1].xcce304e
               LET g_xccd2_d[l_ac].xcce304f = l_xcce304f_sum2 - g_xccd2_d[l_ac+1].xcce304f
               LET g_xccd2_d[l_ac].xcce304g = l_xcce304g_sum2 - g_xccd2_d[l_ac+1].xcce304g
               LET g_xccd2_d[l_ac].xcce304h = l_xcce304h_sum2 - g_xccd2_d[l_ac+1].xcce304h
               LET g_xccd2_d[l_ac].xcce304  = l_xcce304_sum2  - g_xccd2_d[l_ac+1].xcce304 
               LET g_xccd2_d[l_ac].xcce307  = l_xcce307_sum2  - g_xccd2_d[l_ac+1].xcce307  #dorislai-20151021-add
               LET g_xccd2_d[l_ac].xcce308a = l_xcce308a_sum2 - g_xccd2_d[l_ac+1].xcce308a
               LET g_xccd2_d[l_ac].xcce308b = l_xcce308b_sum2 - g_xccd2_d[l_ac+1].xcce308b
               LET g_xccd2_d[l_ac].xcce308c = l_xcce308c_sum2 - g_xccd2_d[l_ac+1].xcce308c
               LET g_xccd2_d[l_ac].xcce308d = l_xcce308d_sum2 - g_xccd2_d[l_ac+1].xcce308d
               LET g_xccd2_d[l_ac].xcce308e = l_xcce308e_sum2 - g_xccd2_d[l_ac+1].xcce308e
               LET g_xccd2_d[l_ac].xcce308f = l_xcce308f_sum2 - g_xccd2_d[l_ac+1].xcce308f
               LET g_xccd2_d[l_ac].xcce308g = l_xcce308g_sum2 - g_xccd2_d[l_ac+1].xcce308g
               LET g_xccd2_d[l_ac].xcce308h = l_xcce308h_sum2 - g_xccd2_d[l_ac+1].xcce308h
               LET g_xccd2_d[l_ac].xcce308  = l_xcce308_sum2  - g_xccd2_d[l_ac+1].xcce308 
               LET g_xccd2_d[l_ac].xcce901  = l_xcce901_sum2  - g_xccd2_d[l_ac+1].xcce901  #dorislai-20151021-add
               LET g_xccd2_d[l_ac].xcce902a = l_xcce902a_sum2 - g_xccd2_d[l_ac+1].xcce902a
               LET g_xccd2_d[l_ac].xcce902b = l_xcce902b_sum2 - g_xccd2_d[l_ac+1].xcce902b
               LET g_xccd2_d[l_ac].xcce902c = l_xcce902c_sum2 - g_xccd2_d[l_ac+1].xcce902c
               LET g_xccd2_d[l_ac].xcce902d = l_xcce902d_sum2 - g_xccd2_d[l_ac+1].xcce902d
               LET g_xccd2_d[l_ac].xcce902e = l_xcce902e_sum2 - g_xccd2_d[l_ac+1].xcce902e
               LET g_xccd2_d[l_ac].xcce902f = l_xcce902f_sum2 - g_xccd2_d[l_ac+1].xcce902f
               LET g_xccd2_d[l_ac].xcce902g = l_xcce902g_sum2 - g_xccd2_d[l_ac+1].xcce902g
               LET g_xccd2_d[l_ac].xcce902h = l_xcce902h_sum2 - g_xccd2_d[l_ac+1].xcce902h
               LET g_xccd2_d[l_ac].xcce902  = l_xcce902_sum2  - g_xccd2_d[l_ac+1].xcce902 
               LET l_ac = l_ac + 1
               LET l_xcce101_sum2  = g_xccd2_d[l_ac].xcce101  #dorislai-20151021-add
               LET l_xcce102a_sum2 = g_xccd2_d[l_ac].xcce102a
               LET l_xcce102b_sum2 = g_xccd2_d[l_ac].xcce102b
               LET l_xcce102c_sum2 = g_xccd2_d[l_ac].xcce102c
               LET l_xcce102d_sum2 = g_xccd2_d[l_ac].xcce102d
               LET l_xcce102e_sum2 = g_xccd2_d[l_ac].xcce102e
               LET l_xcce102f_sum2 = g_xccd2_d[l_ac].xcce102f
               LET l_xcce102g_sum2 = g_xccd2_d[l_ac].xcce102g
               LET l_xcce102h_sum2 = g_xccd2_d[l_ac].xcce102h
               LET l_xcce102_sum2  = g_xccd2_d[l_ac].xcce102 
               LET l_xcce201_sum2  = g_xccd2_d[l_ac].xcce201  #dorislai-20151021-add
               LET l_xcce202a_sum2 = g_xccd2_d[l_ac].xcce202a
               LET l_xcce202b_sum2 = g_xccd2_d[l_ac].xcce202b
               LET l_xcce202c_sum2 = g_xccd2_d[l_ac].xcce202c
               LET l_xcce202d_sum2 = g_xccd2_d[l_ac].xcce202d
               LET l_xcce202e_sum2 = g_xccd2_d[l_ac].xcce202e
               LET l_xcce202f_sum2 = g_xccd2_d[l_ac].xcce202f
               LET l_xcce202g_sum2 = g_xccd2_d[l_ac].xcce202g
               LET l_xcce202h_sum2 = g_xccd2_d[l_ac].xcce202h
               LET l_xcce202_sum2  = g_xccd2_d[l_ac].xcce202 
               LET l_xcce301_sum2  = g_xccd2_d[l_ac].xcce301  #dorislai-20151021-add
               LET l_xcce302a_sum2 = g_xccd2_d[l_ac].xcce302a
               LET l_xcce302b_sum2 = g_xccd2_d[l_ac].xcce302b
               LET l_xcce302c_sum2 = g_xccd2_d[l_ac].xcce302c
               LET l_xcce302d_sum2 = g_xccd2_d[l_ac].xcce302d
               LET l_xcce302e_sum2 = g_xccd2_d[l_ac].xcce302e
               LET l_xcce302f_sum2 = g_xccd2_d[l_ac].xcce302f
               LET l_xcce302g_sum2 = g_xccd2_d[l_ac].xcce302g
               LET l_xcce302h_sum2 = g_xccd2_d[l_ac].xcce302h
               LET l_xcce302_sum2  = g_xccd2_d[l_ac].xcce302 
               LET l_xcce303_sum2  = g_xccd2_d[l_ac].xcce303  #dorislai-20151021-add
               LET l_xcce304a_sum2 = g_xccd2_d[l_ac].xcce304a
               LET l_xcce304b_sum2 = g_xccd2_d[l_ac].xcce304b
               LET l_xcce304c_sum2 = g_xccd2_d[l_ac].xcce304c
               LET l_xcce304d_sum2 = g_xccd2_d[l_ac].xcce304d
               LET l_xcce304e_sum2 = g_xccd2_d[l_ac].xcce304e
               LET l_xcce304f_sum2 = g_xccd2_d[l_ac].xcce304f
               LET l_xcce304g_sum2 = g_xccd2_d[l_ac].xcce304g
               LET l_xcce304h_sum2 = g_xccd2_d[l_ac].xcce304h
               LET l_xcce304_sum2  = g_xccd2_d[l_ac].xcce304 
               LET l_xcce307_sum2  = g_xccd2_d[l_ac].xcce307  #dorislai-20151021-add
               LET l_xcce308a_sum2 = g_xccd2_d[l_ac].xcce308a
               LET l_xcce308b_sum2 = g_xccd2_d[l_ac].xcce308b
               LET l_xcce308c_sum2 = g_xccd2_d[l_ac].xcce308c
               LET l_xcce308d_sum2 = g_xccd2_d[l_ac].xcce308d
               LET l_xcce308e_sum2 = g_xccd2_d[l_ac].xcce308e
               LET l_xcce308f_sum2 = g_xccd2_d[l_ac].xcce308f
               LET l_xcce308g_sum2 = g_xccd2_d[l_ac].xcce308g
               LET l_xcce308h_sum2 = g_xccd2_d[l_ac].xcce308h
               LET l_xcce308_sum2  = g_xccd2_d[l_ac].xcce308 
               LET l_xcce901_sum2  = g_xccd2_d[l_ac].xcce901  #dorislai-20151021-add
               LET l_xcce902a_sum2 = g_xccd2_d[l_ac].xcce902a
               LET l_xcce902b_sum2 = g_xccd2_d[l_ac].xcce902b
               LET l_xcce902c_sum2 = g_xccd2_d[l_ac].xcce902c
               LET l_xcce902d_sum2 = g_xccd2_d[l_ac].xcce902d
               LET l_xcce902e_sum2 = g_xccd2_d[l_ac].xcce902e
               LET l_xcce902f_sum2 = g_xccd2_d[l_ac].xcce902f
               LET l_xcce902g_sum2 = g_xccd2_d[l_ac].xcce902g
               LET l_xcce902h_sum2 = g_xccd2_d[l_ac].xcce902h
               LET l_xcce902_sum2  = g_xccd2_d[l_ac].xcce902  
            END IF            
         END IF           
         
         
         LET l_ac = l_ac + 1
         IF l_ac > g_max_rec THEN
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = l_ac
            LET g_errparam.code   = 9035 
            LET g_errparam.popup  = TRUE 
            CALL cl_err()
            EXIT FOREACH
         END IF
         
      END FOREACH
#最后一组小计，还有合计
#按在制单号小计
      IF l_ac > 1 THEN
         #LET g_xccd2_d[l_ac].xcce006  = cl_getmsg("axc-00577",g_lang) #160201-00004#1 mark
         LET g_xccd2_d[l_ac].xcce006  = cl_getmsg("lib-00156",g_lang),"-",g_xccd2_d[l_ac-1].xcce006  #160201-00004#1 mark
         #170123-00012#1---mark---s            
         ##160108-00001#1-add----(S)
         #LET g_xccd2_d[l_ac].xccd007  = g_xccd2_d[l_ac-1].xccd007 
         #LET g_xccd2_d[l_ac].xccd007_2_desc  = g_xccd2_d[l_ac-1].xccd007_2_desc 
         #LET g_xccd2_d[l_ac].xccd007_2_desc_desc  = g_xccd2_d[l_ac-1].xccd007_2_desc_desc
         ##160108-00001#1-add----(E)
         #170123-00012#1---mark---e            
         LET g_xccd2_d[l_ac].xccd301  = g_xccd2_d[l_ac-1].xccd301 #160106-00012#2-add
         LET g_xccd2_d[l_ac].xcce101  = l_xcce101_sum1  #dorislai-20151021-add
         LET g_xccd2_d[l_ac].xcce102a = l_xcce102a_sum1 
         LET g_xccd2_d[l_ac].xcce102b = l_xcce102b_sum1 
         LET g_xccd2_d[l_ac].xcce102c = l_xcce102c_sum1 
         LET g_xccd2_d[l_ac].xcce102d = l_xcce102d_sum1 
         LET g_xccd2_d[l_ac].xcce102e = l_xcce102e_sum1 
         LET g_xccd2_d[l_ac].xcce102f = l_xcce102f_sum1 
         LET g_xccd2_d[l_ac].xcce102g = l_xcce102g_sum1 
         LET g_xccd2_d[l_ac].xcce102h = l_xcce102h_sum1 
         LET g_xccd2_d[l_ac].xcce102  = l_xcce102_sum1
         LET g_xccd2_d[l_ac].xcce201  = l_xcce201_sum1  #dorislai-20151021-add
         LET g_xccd2_d[l_ac].xcce202a = l_xcce202a_sum1         
         LET g_xccd2_d[l_ac].xcce202b = l_xcce202b_sum1 
         LET g_xccd2_d[l_ac].xcce202c = l_xcce202c_sum1 
         LET g_xccd2_d[l_ac].xcce202d = l_xcce202d_sum1 
         LET g_xccd2_d[l_ac].xcce202e = l_xcce202e_sum1 
         LET g_xccd2_d[l_ac].xcce202f = l_xcce202f_sum1 
         LET g_xccd2_d[l_ac].xcce202g = l_xcce202g_sum1 
         LET g_xccd2_d[l_ac].xcce202h = l_xcce202h_sum1 
         LET g_xccd2_d[l_ac].xcce202  = l_xcce202_sum1  
         LET g_xccd2_d[l_ac].xcce301  = l_xcce301_sum1  #dorislai-20151021-add
         LET g_xccd2_d[l_ac].xcce302a = l_xcce302a_sum1 
         LET g_xccd2_d[l_ac].xcce302b = l_xcce302b_sum1 
         LET g_xccd2_d[l_ac].xcce302c = l_xcce302c_sum1 
         LET g_xccd2_d[l_ac].xcce302d = l_xcce302d_sum1 
         LET g_xccd2_d[l_ac].xcce302e = l_xcce302e_sum1 
         LET g_xccd2_d[l_ac].xcce302f = l_xcce302f_sum1 
         LET g_xccd2_d[l_ac].xcce302g = l_xcce302g_sum1 
         LET g_xccd2_d[l_ac].xcce302h = l_xcce302h_sum1 
         LET g_xccd2_d[l_ac].xcce302  = l_xcce302_sum1  
         LET g_xccd2_d[l_ac].xcce303  = l_xcce303_sum1  #dorislai-20151021-add
         LET g_xccd2_d[l_ac].xcce304a = l_xcce304a_sum1 
         LET g_xccd2_d[l_ac].xcce304b = l_xcce304b_sum1 
         LET g_xccd2_d[l_ac].xcce304c = l_xcce304c_sum1 
         LET g_xccd2_d[l_ac].xcce304d = l_xcce304d_sum1 
         LET g_xccd2_d[l_ac].xcce304e = l_xcce304e_sum1 
         LET g_xccd2_d[l_ac].xcce304f = l_xcce304f_sum1 
         LET g_xccd2_d[l_ac].xcce304g = l_xcce304g_sum1 
         LET g_xccd2_d[l_ac].xcce304h = l_xcce304h_sum1 
         LET g_xccd2_d[l_ac].xcce304  = l_xcce304_sum1  
         LET g_xccd2_d[l_ac].xcce307  = l_xcce307_sum1  #dorislai-20151021-add
         LET g_xccd2_d[l_ac].xcce308a = l_xcce308a_sum1 
         LET g_xccd2_d[l_ac].xcce308b = l_xcce308b_sum1 
         LET g_xccd2_d[l_ac].xcce308c = l_xcce308c_sum1 
         LET g_xccd2_d[l_ac].xcce308d = l_xcce308d_sum1 
         LET g_xccd2_d[l_ac].xcce308e = l_xcce308e_sum1 
         LET g_xccd2_d[l_ac].xcce308f = l_xcce308f_sum1 
         LET g_xccd2_d[l_ac].xcce308g = l_xcce308g_sum1 
         LET g_xccd2_d[l_ac].xcce308h = l_xcce308h_sum1 
         LET g_xccd2_d[l_ac].xcce308  = l_xcce308_sum1  
         LET g_xccd2_d[l_ac].xcce901  = l_xcce901_sum1  #dorislai-20151021-add
         LET g_xccd2_d[l_ac].xcce902a = l_xcce902a_sum1 
         LET g_xccd2_d[l_ac].xcce902b = l_xcce902b_sum1 
         LET g_xccd2_d[l_ac].xcce902c = l_xcce902c_sum1 
         LET g_xccd2_d[l_ac].xcce902d = l_xcce902d_sum1 
         LET g_xccd2_d[l_ac].xcce902e = l_xcce902e_sum1 
         LET g_xccd2_d[l_ac].xcce902f = l_xcce902f_sum1 
         LET g_xccd2_d[l_ac].xcce902g = l_xcce902g_sum1 
         LET g_xccd2_d[l_ac].xcce902h = l_xcce902h_sum1 
         LET g_xccd2_d[l_ac].xcce902  = l_xcce902_sum1  
         LET l_ac = l_ac+1  
#按组织小计
         #LET g_xccd2_d[l_ac].sfaa068  = cl_getmsg("axc-00578",g_lang) #160201-00004#1 mark 
         #LET g_xccd2_d[l_ac].sfaa068  = cl_getmsg("lib-00156",g_lang),"-",g_xccd2_d[l_ac-2].sfaa068   #160201-00004#1  #170123-00012#1 mark
         LET g_xccd2_d[l_ac].sfaa068  = cl_getmsg("aps-00134",g_lang),"-",g_xccd2_d[l_ac-2].sfaa068   #170123-00012#1 
         LET g_xccd2_d[l_ac].xcce101  = l_xcce101_sum2 #dorislai-20151021-add
         LET g_xccd2_d[l_ac].xcce102a = l_xcce102a_sum2 
         LET g_xccd2_d[l_ac].xcce102b = l_xcce102b_sum2 
         LET g_xccd2_d[l_ac].xcce102c = l_xcce102c_sum2 
         LET g_xccd2_d[l_ac].xcce102d = l_xcce102d_sum2 
         LET g_xccd2_d[l_ac].xcce102e = l_xcce102e_sum2 
         LET g_xccd2_d[l_ac].xcce102f = l_xcce102f_sum2 
         LET g_xccd2_d[l_ac].xcce102g = l_xcce102g_sum2 
         LET g_xccd2_d[l_ac].xcce102h = l_xcce102h_sum2 
         LET g_xccd2_d[l_ac].xcce102  = l_xcce102_sum2
         LET g_xccd2_d[l_ac].xcce201  = l_xcce201_sum2 #dorislai-20151021-add
         LET g_xccd2_d[l_ac].xcce202a = l_xcce202a_sum2         
         LET g_xccd2_d[l_ac].xcce202b = l_xcce202b_sum2 
         LET g_xccd2_d[l_ac].xcce202c = l_xcce202c_sum2 
         LET g_xccd2_d[l_ac].xcce202d = l_xcce202d_sum2 
         LET g_xccd2_d[l_ac].xcce202e = l_xcce202e_sum2 
         LET g_xccd2_d[l_ac].xcce202f = l_xcce202f_sum2 
         LET g_xccd2_d[l_ac].xcce202g = l_xcce202g_sum2 
         LET g_xccd2_d[l_ac].xcce202h = l_xcce202h_sum2 
         LET g_xccd2_d[l_ac].xcce202  = l_xcce202_sum2  
         LET g_xccd2_d[l_ac].xcce301  = l_xcce301_sum2 #dorislai-20151021-add
         LET g_xccd2_d[l_ac].xcce302a = l_xcce302a_sum2 
         LET g_xccd2_d[l_ac].xcce302b = l_xcce302b_sum2 
         LET g_xccd2_d[l_ac].xcce302c = l_xcce302c_sum2 
         LET g_xccd2_d[l_ac].xcce302d = l_xcce302d_sum2 
         LET g_xccd2_d[l_ac].xcce302e = l_xcce302e_sum2 
         LET g_xccd2_d[l_ac].xcce302f = l_xcce302f_sum2 
         LET g_xccd2_d[l_ac].xcce302g = l_xcce302g_sum2 
         LET g_xccd2_d[l_ac].xcce302h = l_xcce302h_sum2 
         LET g_xccd2_d[l_ac].xcce302  = l_xcce302_sum2  
         LET g_xccd2_d[l_ac].xcce303  = l_xcce303_sum2 #dorislai-20151021-add
         LET g_xccd2_d[l_ac].xcce304a = l_xcce304a_sum2 
         LET g_xccd2_d[l_ac].xcce304b = l_xcce304b_sum2 
         LET g_xccd2_d[l_ac].xcce304c = l_xcce304c_sum2 
         LET g_xccd2_d[l_ac].xcce304d = l_xcce304d_sum2 
         LET g_xccd2_d[l_ac].xcce304e = l_xcce304e_sum2 
         LET g_xccd2_d[l_ac].xcce304f = l_xcce304f_sum2 
         LET g_xccd2_d[l_ac].xcce304g = l_xcce304g_sum2 
         LET g_xccd2_d[l_ac].xcce304h = l_xcce304h_sum2 
         LET g_xccd2_d[l_ac].xcce304  = l_xcce304_sum2  
         LET g_xccd2_d[l_ac].xcce307  = l_xcce307_sum2 #dorislai-20151021-add
         LET g_xccd2_d[l_ac].xcce308a = l_xcce308a_sum2 
         LET g_xccd2_d[l_ac].xcce308b = l_xcce308b_sum2 
         LET g_xccd2_d[l_ac].xcce308c = l_xcce308c_sum2 
         LET g_xccd2_d[l_ac].xcce308d = l_xcce308d_sum2 
         LET g_xccd2_d[l_ac].xcce308e = l_xcce308e_sum2 
         LET g_xccd2_d[l_ac].xcce308f = l_xcce308f_sum2 
         LET g_xccd2_d[l_ac].xcce308g = l_xcce308g_sum2 
         LET g_xccd2_d[l_ac].xcce308h = l_xcce308h_sum2 
         LET g_xccd2_d[l_ac].xcce308  = l_xcce308_sum2  
         LET g_xccd2_d[l_ac].xcce901  = l_xcce901_sum2 #dorislai-20151021-add
         LET g_xccd2_d[l_ac].xcce902a = l_xcce902a_sum2 
         LET g_xccd2_d[l_ac].xcce902b = l_xcce902b_sum2 
         LET g_xccd2_d[l_ac].xcce902c = l_xcce902c_sum2 
         LET g_xccd2_d[l_ac].xcce902d = l_xcce902d_sum2 
         LET g_xccd2_d[l_ac].xcce902e = l_xcce902e_sum2 
         LET g_xccd2_d[l_ac].xcce902f = l_xcce902f_sum2 
         LET g_xccd2_d[l_ac].xcce902g = l_xcce902g_sum2 
         LET g_xccd2_d[l_ac].xcce902h = l_xcce902h_sum2 
         LET g_xccd2_d[l_ac].xcce902  = l_xcce902_sum2  
         LET l_ac = l_ac + 1
#合计
         LET g_xccd2_d[l_ac].sfaa068  = cl_getmsg("lib-00133",g_lang) 
         LET g_xccd2_d[l_ac].xcce101  = l_xcce101_total #dorislai-20151021-add
         LET g_xccd2_d[l_ac].xcce102a = l_xcce102a_total 
         LET g_xccd2_d[l_ac].xcce102b = l_xcce102b_total 
         LET g_xccd2_d[l_ac].xcce102c = l_xcce102c_total 
         LET g_xccd2_d[l_ac].xcce102d = l_xcce102d_total 
         LET g_xccd2_d[l_ac].xcce102e = l_xcce102e_total 
         LET g_xccd2_d[l_ac].xcce102f = l_xcce102f_total 
         LET g_xccd2_d[l_ac].xcce102g = l_xcce102g_total 
         LET g_xccd2_d[l_ac].xcce102h = l_xcce102h_total 
         LET g_xccd2_d[l_ac].xcce102  = l_xcce102_total 
         LET g_xccd2_d[l_ac].xcce201  = l_xcce201_total #dorislai-20151021-add
         LET g_xccd2_d[l_ac].xcce202a = l_xcce202a_total         
         LET g_xccd2_d[l_ac].xcce202b = l_xcce202b_total 
         LET g_xccd2_d[l_ac].xcce202c = l_xcce202c_total 
         LET g_xccd2_d[l_ac].xcce202d = l_xcce202d_total 
         LET g_xccd2_d[l_ac].xcce202e = l_xcce202e_total 
         LET g_xccd2_d[l_ac].xcce202f = l_xcce202f_total 
         LET g_xccd2_d[l_ac].xcce202g = l_xcce202g_total 
         LET g_xccd2_d[l_ac].xcce202h = l_xcce202h_total 
         LET g_xccd2_d[l_ac].xcce202  = l_xcce202_total  
         LET g_xccd2_d[l_ac].xcce301  = l_xcce301_total #dorislai-20151021-add
         LET g_xccd2_d[l_ac].xcce302a = l_xcce302a_total 
         LET g_xccd2_d[l_ac].xcce302b = l_xcce302b_total 
         LET g_xccd2_d[l_ac].xcce302c = l_xcce302c_total 
         LET g_xccd2_d[l_ac].xcce302d = l_xcce302d_total 
         LET g_xccd2_d[l_ac].xcce302e = l_xcce302e_total 
         LET g_xccd2_d[l_ac].xcce302f = l_xcce302f_total 
         LET g_xccd2_d[l_ac].xcce302g = l_xcce302g_total 
         LET g_xccd2_d[l_ac].xcce302h = l_xcce302h_total 
         LET g_xccd2_d[l_ac].xcce302  = l_xcce302_total  
         LET g_xccd2_d[l_ac].xcce303  = l_xcce303_total #dorislai-20151021-add
         LET g_xccd2_d[l_ac].xcce304a = l_xcce304a_total 
         LET g_xccd2_d[l_ac].xcce304b = l_xcce304b_total 
         LET g_xccd2_d[l_ac].xcce304c = l_xcce304c_total 
         LET g_xccd2_d[l_ac].xcce304d = l_xcce304d_total 
         LET g_xccd2_d[l_ac].xcce304e = l_xcce304e_total 
         LET g_xccd2_d[l_ac].xcce304f = l_xcce304f_total 
         LET g_xccd2_d[l_ac].xcce304g = l_xcce304g_total 
         LET g_xccd2_d[l_ac].xcce304h = l_xcce304h_total 
         LET g_xccd2_d[l_ac].xcce304  = l_xcce304_total  
         LET g_xccd2_d[l_ac].xcce307  = l_xcce307_total #dorislai-20151021-add
         LET g_xccd2_d[l_ac].xcce308a = l_xcce308a_total 
         LET g_xccd2_d[l_ac].xcce308b = l_xcce308b_total 
         LET g_xccd2_d[l_ac].xcce308c = l_xcce308c_total 
         LET g_xccd2_d[l_ac].xcce308d = l_xcce308d_total 
         LET g_xccd2_d[l_ac].xcce308e = l_xcce308e_total 
         LET g_xccd2_d[l_ac].xcce308f = l_xcce308f_total 
         LET g_xccd2_d[l_ac].xcce308g = l_xcce308g_total 
         LET g_xccd2_d[l_ac].xcce308h = l_xcce308h_total 
         LET g_xccd2_d[l_ac].xcce308  = l_xcce308_total  
         LET g_xccd2_d[l_ac].xcce901  = l_xcce901_total #dorislai-20151021-add
         LET g_xccd2_d[l_ac].xcce902a = l_xcce902a_total 
         LET g_xccd2_d[l_ac].xcce902b = l_xcce902b_total 
         LET g_xccd2_d[l_ac].xcce902c = l_xcce902c_total 
         LET g_xccd2_d[l_ac].xcce902d = l_xcce902d_total 
         LET g_xccd2_d[l_ac].xcce902e = l_xcce902e_total 
         LET g_xccd2_d[l_ac].xcce902f = l_xcce902f_total 
         LET g_xccd2_d[l_ac].xcce902g = l_xcce902g_total 
         LET g_xccd2_d[l_ac].xcce902h = l_xcce902h_total 
         LET g_xccd2_d[l_ac].xcce902  = l_xcce902_total  
      END IF         
   END IF
 
   #判斷是否填充
   IF axcq540_fill_chk(3) THEN
      LET g_sql = " SELECT  UNIQUE sfaa068,xcci006,xcci007,xcci008,xcci009,xcbb005,",
                  "                xcci002,xcci101,xcci102a,xcci102b,xcci102c,xcci102d,xcci102e,xcci102f,xcci102g,xcci102h,xcci102,",
                  "                xcci201,xcci202a,xcci202b,xcci202c,xcci202d,xcci202e,xcci202f,xcci202g,xcci202h,xcci202,",
                  "                xcci301,xcci302a,xcci302b,xcci302c,xcci302d,xcci302e,xcci302f,xcci302g,xcci302h,xcci302,",
                  "                xcci303,xcci304a,xcci304b,xcci304c,xcci304d,xcci304e,xcci304f,xcci304g,xcci304h,xcci304,",
                  "                xcci901,xcci902a,xcci902b,xcci902c,xcci902d,xcci902e,xcci902f,xcci902g,xcci902h,xcci902 ",
                  "               ,xcch007,xcch008 ",      #fengmy150303  #add xcch008 liuym150810
                  "               ,xcch301 ",  #151202-00029 by whitney add
                  "  FROM axcq540_tmp03 "
  
      
      LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
      PREPARE axcq540_pb3 FROM g_sql
      DECLARE b_fill_cs3 CURSOR FOR axcq540_pb3
      
      LET l_ac = 1
      LET l_xcci101_sum1  = 0  #dorislai-20151021-add
      LET l_xcci102a_sum1 = 0  
      LET l_xcci102b_sum1 = 0  
      LET l_xcci102c_sum1 = 0  
      LET l_xcci102d_sum1 = 0  
      LET l_xcci102e_sum1 = 0  
      LET l_xcci102f_sum1 = 0  
      LET l_xcci102g_sum1 = 0  
      LET l_xcci102h_sum1 = 0  
      LET l_xcci102_sum1  = 0 
      LET l_xcci201_sum1  = 0  #dorislai-20151021-add
      LET l_xcci202a_sum1 = 0
      LET l_xcci202b_sum1 = 0  
      LET l_xcci202c_sum1 = 0  
      LET l_xcci202d_sum1 = 0  
      LET l_xcci202e_sum1 = 0  
      LET l_xcci202f_sum1 = 0  
      LET l_xcci202g_sum1 = 0  
      LET l_xcci202h_sum1 = 0  
      LET l_xcci202_sum1  = 0  
      LET l_xcci301_sum1  = 0  #dorislai-20151021-add
      LET l_xcci302a_sum1 = 0  
      LET l_xcci302b_sum1 = 0  
      LET l_xcci302c_sum1 = 0  
      LET l_xcci302d_sum1 = 0  
      LET l_xcci302e_sum1 = 0  
      LET l_xcci302f_sum1 = 0  
      LET l_xcci302g_sum1 = 0  
      LET l_xcci302h_sum1 = 0  
      LET l_xcci302_sum1  = 0  
      LET l_xcci303_sum1  = 0  #dorislai-20151021-add
      LET l_xcci304a_sum1 = 0  
      LET l_xcci304b_sum1 = 0  
      LET l_xcci304c_sum1 = 0  
      LET l_xcci304d_sum1 = 0  
      LET l_xcci304e_sum1 = 0  
      LET l_xcci304f_sum1 = 0  
      LET l_xcci304g_sum1 = 0  
      LET l_xcci304h_sum1 = 0  
      LET l_xcci304_sum1  = 0   
      LET l_xcci901_sum1  = 0  #dorislai-20151021-add
      LET l_xcci902a_sum1 = 0  
      LET l_xcci902b_sum1 = 0  
      LET l_xcci902c_sum1 = 0  
      LET l_xcci902d_sum1 = 0  
      LET l_xcci902e_sum1 = 0  
      LET l_xcci902f_sum1 = 0  
      LET l_xcci902g_sum1 = 0  
      LET l_xcci902h_sum1 = 0  
      LET l_xcci902_sum1  = 0  
      LET l_xcci101_sum2  = 0  #dorislai-20151021-add
      LET l_xcci102a_sum2 = 0  
      LET l_xcci102b_sum2 = 0  
      LET l_xcci102c_sum2 = 0  
      LET l_xcci102d_sum2 = 0  
      LET l_xcci102e_sum2 = 0  
      LET l_xcci102f_sum2 = 0  
      LET l_xcci102g_sum2 = 0  
      LET l_xcci102h_sum2 = 0  
      LET l_xcci102_sum2  = 0 
      LET l_xcci201_sum2  = 0  #dorislai-20151021-add
      LET l_xcci202a_sum2 = 0
      LET l_xcci202b_sum2 = 0  
      LET l_xcci202c_sum2 = 0  
      LET l_xcci202d_sum2 = 0  
      LET l_xcci202e_sum2 = 0  
      LET l_xcci202f_sum2 = 0  
      LET l_xcci202g_sum2 = 0  
      LET l_xcci202h_sum2 = 0  
      LET l_xcci202_sum2  = 0  
      LET l_xcci301_sum2  = 0  #dorislai-20151021-add
      LET l_xcci302a_sum2 = 0  
      LET l_xcci302b_sum2 = 0  
      LET l_xcci302c_sum2 = 0  
      LET l_xcci302d_sum2 = 0  
      LET l_xcci302e_sum2 = 0  
      LET l_xcci302f_sum2 = 0  
      LET l_xcci302g_sum2 = 0  
      LET l_xcci302h_sum2 = 0  
      LET l_xcci302_sum2  = 0  
      LET l_xcci303_sum2  = 0  #dorislai-20151021-add
      LET l_xcci304a_sum2 = 0  
      LET l_xcci304b_sum2 = 0  
      LET l_xcci304c_sum2 = 0  
      LET l_xcci304d_sum2 = 0  
      LET l_xcci304e_sum2 = 0  
      LET l_xcci304f_sum2 = 0  
      LET l_xcci304g_sum2 = 0  
      LET l_xcci304h_sum2 = 0  
      LET l_xcci304_sum2  = 0    
      LET l_xcci901_sum2  = 0  #dorislai-20151021-add
      LET l_xcci902a_sum2 = 0  
      LET l_xcci902b_sum2 = 0  
      LET l_xcci902c_sum2 = 0  
      LET l_xcci902d_sum2 = 0  
      LET l_xcci902e_sum2 = 0  
      LET l_xcci902f_sum2 = 0  
      LET l_xcci902g_sum2 = 0  
      LET l_xcci902h_sum2 = 0  
      LET l_xcci902_sum2  = 0
      LET l_xcci101_total  = 0 #dorislai-20151021-add  
      LET l_xcci102a_total = 0  
      LET l_xcci102b_total = 0  
      LET l_xcci102c_total = 0  
      LET l_xcci102d_total = 0  
      LET l_xcci102e_total = 0  
      LET l_xcci102f_total = 0  
      LET l_xcci102g_total = 0  
      LET l_xcci102h_total = 0  
      LET l_xcci102_total  = 0  
      LET l_xcci201_total  = 0 #dorislai-20151021-add
      LET l_xcci202a_total = 0  
      LET l_xcci202b_total = 0  
      LET l_xcci202c_total = 0  
      LET l_xcci202d_total = 0  
      LET l_xcci202e_total = 0  
      LET l_xcci202f_total = 0  
      LET l_xcci202g_total = 0  
      LET l_xcci202h_total = 0  
      LET l_xcci202_total  = 0  
      LET l_xcci301_total  = 0 #dorislai-20151021-add
      LET l_xcci302a_total = 0  
      LET l_xcci302b_total = 0  
      LET l_xcci302c_total = 0  
      LET l_xcci302d_total = 0  
      LET l_xcci302e_total = 0  
      LET l_xcci302f_total = 0  
      LET l_xcci302g_total = 0  
      LET l_xcci302h_total = 0  
      LET l_xcci302_total  = 0  
      LET l_xcci303_total  = 0 #dorislai-20151021-add
      LET l_xcci304a_total = 0  
      LET l_xcci304b_total = 0  
      LET l_xcci304c_total = 0  
      LET l_xcci304d_total = 0  
      LET l_xcci304e_total = 0  
      LET l_xcci304f_total = 0  
      LET l_xcci304g_total = 0  
      LET l_xcci304h_total = 0  
      LET l_xcci304_total  = 0   
      LET l_xcci901_total  = 0 #dorislai-20151021-add
      LET l_xcci902a_total = 0  
      LET l_xcci902b_total = 0  
      LET l_xcci902c_total = 0  
      LET l_xcci902d_total = 0  
      LET l_xcci902e_total = 0  
      LET l_xcci902f_total = 0  
      LET l_xcci902g_total = 0  
      LET l_xcci902h_total = 0  
      LET l_xcci902_total  = 0                                                     
      FOREACH b_fill_cs3 INTO g_xccd3_d[l_ac].sfaa068,g_xccd3_d[l_ac].xcci006,g_xccd3_d[l_ac].xcci007,g_xccd3_d[l_ac].xcci008,g_xccd3_d[l_ac].xcci009,g_xccd3_d[l_ac].xcbb005,
                              g_xccd3_d[l_ac].xcci002,g_xccd3_d[l_ac].xcci101,g_xccd3_d[l_ac].xcci102a,g_xccd3_d[l_ac].xcci102b,g_xccd3_d[l_ac].xcci102c,g_xccd3_d[l_ac].xcci102d,g_xccd3_d[l_ac].xcci102e,g_xccd3_d[l_ac].xcci102f,g_xccd3_d[l_ac].xcci102g,g_xccd3_d[l_ac].xcci102h,
                              g_xccd3_d[l_ac].xcci102,g_xccd3_d[l_ac].xcci201,g_xccd3_d[l_ac].xcci202a,g_xccd3_d[l_ac].xcci202b,g_xccd3_d[l_ac].xcci202c,g_xccd3_d[l_ac].xcci202d,g_xccd3_d[l_ac].xcci202e,g_xccd3_d[l_ac].xcci202f,g_xccd3_d[l_ac].xcci202g,g_xccd3_d[l_ac].xcci202h,
                              g_xccd3_d[l_ac].xcci202,g_xccd3_d[l_ac].xcci301,g_xccd3_d[l_ac].xcci302a,g_xccd3_d[l_ac].xcci302b,g_xccd3_d[l_ac].xcci302c,g_xccd3_d[l_ac].xcci302d,g_xccd3_d[l_ac].xcci302e,g_xccd3_d[l_ac].xcci302f,g_xccd3_d[l_ac].xcci302g,g_xccd3_d[l_ac].xcci302h,
                              g_xccd3_d[l_ac].xcci302,g_xccd3_d[l_ac].xcci303,g_xccd3_d[l_ac].xcci304a,g_xccd3_d[l_ac].xcci304b,g_xccd3_d[l_ac].xcci304c,g_xccd3_d[l_ac].xcci304d,g_xccd3_d[l_ac].xcci304e,g_xccd3_d[l_ac].xcci304f,g_xccd3_d[l_ac].xcci304g,g_xccd3_d[l_ac].xcci304h,
                              g_xccd3_d[l_ac].xcci304,g_xccd3_d[l_ac].xcci901,g_xccd3_d[l_ac].xcci902a,g_xccd3_d[l_ac].xcci902b,g_xccd3_d[l_ac].xcci902c,g_xccd3_d[l_ac].xcci902d,g_xccd3_d[l_ac].xcci902e,g_xccd3_d[l_ac].xcci902f,g_xccd3_d[l_ac].xcci902g,g_xccd3_d[l_ac].xcci902h,g_xccd3_d[l_ac].xcci902
                             ,g_xccd3_d[l_ac].xcch007,g_xccd3_d[l_ac].xcch008  #fengmy150303  #add xcch008 liuym0810
                             ,g_xccd3_d[l_ac].xcch301  #151202-00029 by whitney add
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "FOREACH:" 
            LET g_errparam.code   = SQLCA.sqlcode 
            LET g_errparam.popup  = TRUE 
            CALL cl_err()
 
            EXIT FOREACH
         END IF
         IF g_xccd3_d[l_ac].sfaa068 IS NULL THEN LET g_xccd3_d[l_ac].sfaa068 = ' ' END IF #170123-00012#1        
         CALL s_desc_get_department_desc(g_xccd3_d[l_ac].sfaa068) RETURNING g_xccd3_d[l_ac].sfaa068_3_desc
         CALL s_desc_get_item_desc(g_xccd3_d[l_ac].xcci007) RETURNING g_xccd3_d[l_ac].xcci007_desc,g_xccd3_d[l_ac].xcci007_desc_1
         CALL s_desc_get_unit_desc(g_xccd3_d[l_ac].xcbb005) RETURNING g_xccd3_d[l_ac].xcbb005_3_desc
         CALL s_desc_get_item_desc(g_xccd3_d[l_ac].xcch007) RETURNING g_xccd3_d[l_ac].xcch007_desc,g_xccd3_d[l_ac].xcch007_desc_desc  #fengmy150304
#合计
         LET l_xcci101_total  = l_xcci101_total  + g_xccd3_d[l_ac].xcci101  #dorislai-20151021-add
         LET l_xcci102a_total = l_xcci102a_total + g_xccd3_d[l_ac].xcci102a
         LET l_xcci102b_total = l_xcci102b_total + g_xccd3_d[l_ac].xcci102b
         LET l_xcci102c_total = l_xcci102c_total + g_xccd3_d[l_ac].xcci102c
         LET l_xcci102d_total = l_xcci102d_total + g_xccd3_d[l_ac].xcci102d
         LET l_xcci102e_total = l_xcci102e_total + g_xccd3_d[l_ac].xcci102e
         LET l_xcci102f_total = l_xcci102f_total + g_xccd3_d[l_ac].xcci102f
         LET l_xcci102g_total = l_xcci102g_total + g_xccd3_d[l_ac].xcci102g
         LET l_xcci102h_total = l_xcci102h_total + g_xccd3_d[l_ac].xcci102h
         LET l_xcci102_total  = l_xcci102_total  + g_xccd3_d[l_ac].xcci102 
         LET l_xcci201_total  = l_xcci201_total  + g_xccd3_d[l_ac].xcci201  #dorislai-20151021-add
         LET l_xcci202a_total = l_xcci202a_total + g_xccd3_d[l_ac].xcci202a
         LET l_xcci202b_total = l_xcci202b_total + g_xccd3_d[l_ac].xcci202b
         LET l_xcci202c_total = l_xcci202c_total + g_xccd3_d[l_ac].xcci202c
         LET l_xcci202d_total = l_xcci202d_total + g_xccd3_d[l_ac].xcci202d
         LET l_xcci202e_total = l_xcci202e_total + g_xccd3_d[l_ac].xcci202e
         LET l_xcci202f_total = l_xcci202f_total + g_xccd3_d[l_ac].xcci202f
         LET l_xcci202g_total = l_xcci202g_total + g_xccd3_d[l_ac].xcci202g
         LET l_xcci202h_total = l_xcci202h_total + g_xccd3_d[l_ac].xcci202h
         LET l_xcci202_total  = l_xcci202_total  + g_xccd3_d[l_ac].xcci202 
         LET l_xcci301_total  = l_xcci301_total  + g_xccd3_d[l_ac].xcci301  #dorislai-20151021-add
         LET l_xcci302a_total = l_xcci302a_total + g_xccd3_d[l_ac].xcci302a
         LET l_xcci302b_total = l_xcci302b_total + g_xccd3_d[l_ac].xcci302b
         LET l_xcci302c_total = l_xcci302c_total + g_xccd3_d[l_ac].xcci302c
         LET l_xcci302d_total = l_xcci302d_total + g_xccd3_d[l_ac].xcci302d
         LET l_xcci302e_total = l_xcci302e_total + g_xccd3_d[l_ac].xcci302e
         LET l_xcci302f_total = l_xcci302f_total + g_xccd3_d[l_ac].xcci302f
         LET l_xcci302g_total = l_xcci302g_total + g_xccd3_d[l_ac].xcci302g
         LET l_xcci302h_total = l_xcci302h_total + g_xccd3_d[l_ac].xcci302h
         LET l_xcci302_total  = l_xcci302_total  + g_xccd3_d[l_ac].xcci302 
         LET l_xcci303_total  = l_xcci303_total  + g_xccd3_d[l_ac].xcci303  #dorislai-20151021-add
         LET l_xcci304a_total = l_xcci304a_total + g_xccd3_d[l_ac].xcci304a
         LET l_xcci304b_total = l_xcci304b_total + g_xccd3_d[l_ac].xcci304b
         LET l_xcci304c_total = l_xcci304c_total + g_xccd3_d[l_ac].xcci304c
         LET l_xcci304d_total = l_xcci304d_total + g_xccd3_d[l_ac].xcci304d
         LET l_xcci304e_total = l_xcci304e_total + g_xccd3_d[l_ac].xcci304e
         LET l_xcci304f_total = l_xcci304f_total + g_xccd3_d[l_ac].xcci304f
         LET l_xcci304g_total = l_xcci304g_total + g_xccd3_d[l_ac].xcci304g
         LET l_xcci304h_total = l_xcci304h_total + g_xccd3_d[l_ac].xcci304h
         LET l_xcci304_total  = l_xcci304_total  + g_xccd3_d[l_ac].xcci304  
         LET l_xcci901_total  = l_xcci901_total  + g_xccd3_d[l_ac].xcci901  #dorislai-20151021-add
         LET l_xcci902a_total = l_xcci902a_total + g_xccd3_d[l_ac].xcci902a
         LET l_xcci902b_total = l_xcci902b_total + g_xccd3_d[l_ac].xcci902b
         LET l_xcci902c_total = l_xcci902c_total + g_xccd3_d[l_ac].xcci902c
         LET l_xcci902d_total = l_xcci902d_total + g_xccd3_d[l_ac].xcci902d
         LET l_xcci902e_total = l_xcci902e_total + g_xccd3_d[l_ac].xcci902e
         LET l_xcci902f_total = l_xcci902f_total + g_xccd3_d[l_ac].xcci902f
         LET l_xcci902g_total = l_xcci902g_total + g_xccd3_d[l_ac].xcci902g
         LET l_xcci902h_total = l_xcci902h_total + g_xccd3_d[l_ac].xcci902h
         LET l_xcci902_total  = l_xcci902_total  + g_xccd3_d[l_ac].xcci902 
#按单号小计
         LET l_xcci101_sum1  = l_xcci101_sum1  + g_xccd3_d[l_ac].xcci101  #dorislai-20151021-add
         LET l_xcci102a_sum1 = l_xcci102a_sum1 + g_xccd3_d[l_ac].xcci102a
         LET l_xcci102b_sum1 = l_xcci102b_sum1 + g_xccd3_d[l_ac].xcci102b
         LET l_xcci102c_sum1 = l_xcci102c_sum1 + g_xccd3_d[l_ac].xcci102c
         LET l_xcci102d_sum1 = l_xcci102d_sum1 + g_xccd3_d[l_ac].xcci102d
         LET l_xcci102e_sum1 = l_xcci102e_sum1 + g_xccd3_d[l_ac].xcci102e
         LET l_xcci102f_sum1 = l_xcci102f_sum1 + g_xccd3_d[l_ac].xcci102f
         LET l_xcci102g_sum1 = l_xcci102g_sum1 + g_xccd3_d[l_ac].xcci102g
         LET l_xcci102h_sum1 = l_xcci102h_sum1 + g_xccd3_d[l_ac].xcci102h
         LET l_xcci102_sum1  = l_xcci102_sum1  + g_xccd3_d[l_ac].xcci102 
         LET l_xcci201_sum1  = l_xcci201_sum1  + g_xccd3_d[l_ac].xcci201  #dorislai-20151021-add
         LET l_xcci202a_sum1 = l_xcci202a_sum1 + g_xccd3_d[l_ac].xcci202a
         LET l_xcci202b_sum1 = l_xcci202b_sum1 + g_xccd3_d[l_ac].xcci202b
         LET l_xcci202c_sum1 = l_xcci202c_sum1 + g_xccd3_d[l_ac].xcci202c
         LET l_xcci202d_sum1 = l_xcci202d_sum1 + g_xccd3_d[l_ac].xcci202d
         LET l_xcci202e_sum1 = l_xcci202e_sum1 + g_xccd3_d[l_ac].xcci202e
         LET l_xcci202f_sum1 = l_xcci202f_sum1 + g_xccd3_d[l_ac].xcci202f
         LET l_xcci202g_sum1 = l_xcci202g_sum1 + g_xccd3_d[l_ac].xcci202g
         LET l_xcci202h_sum1 = l_xcci202h_sum1 + g_xccd3_d[l_ac].xcci202h
         LET l_xcci202_sum1  = l_xcci202_sum1  + g_xccd3_d[l_ac].xcci202 
         LET l_xcci301_sum1  = l_xcci301_sum1  + g_xccd3_d[l_ac].xcci301  #dorislai-20151021-add
         LET l_xcci302a_sum1 = l_xcci302a_sum1 + g_xccd3_d[l_ac].xcci302a
         LET l_xcci302b_sum1 = l_xcci302b_sum1 + g_xccd3_d[l_ac].xcci302b
         LET l_xcci302c_sum1 = l_xcci302c_sum1 + g_xccd3_d[l_ac].xcci302c
         LET l_xcci302d_sum1 = l_xcci302d_sum1 + g_xccd3_d[l_ac].xcci302d
         LET l_xcci302e_sum1 = l_xcci302e_sum1 + g_xccd3_d[l_ac].xcci302e
         LET l_xcci302f_sum1 = l_xcci302f_sum1 + g_xccd3_d[l_ac].xcci302f
         LET l_xcci302g_sum1 = l_xcci302g_sum1 + g_xccd3_d[l_ac].xcci302g
         LET l_xcci302h_sum1 = l_xcci302h_sum1 + g_xccd3_d[l_ac].xcci302h
         LET l_xcci302_sum1  = l_xcci302_sum1  + g_xccd3_d[l_ac].xcci302 
         LET l_xcci303_sum1  = l_xcci303_sum1  + g_xccd3_d[l_ac].xcci303  #dorislai-20151021-add
         LET l_xcci304a_sum1 = l_xcci304a_sum1 + g_xccd3_d[l_ac].xcci304a
         LET l_xcci304b_sum1 = l_xcci304b_sum1 + g_xccd3_d[l_ac].xcci304b
         LET l_xcci304c_sum1 = l_xcci304c_sum1 + g_xccd3_d[l_ac].xcci304c
         LET l_xcci304d_sum1 = l_xcci304d_sum1 + g_xccd3_d[l_ac].xcci304d
         LET l_xcci304e_sum1 = l_xcci304e_sum1 + g_xccd3_d[l_ac].xcci304e
         LET l_xcci304f_sum1 = l_xcci304f_sum1 + g_xccd3_d[l_ac].xcci304f
         LET l_xcci304g_sum1 = l_xcci304g_sum1 + g_xccd3_d[l_ac].xcci304g
         LET l_xcci304h_sum1 = l_xcci304h_sum1 + g_xccd3_d[l_ac].xcci304h
         LET l_xcci304_sum1  = l_xcci304_sum1  + g_xccd3_d[l_ac].xcci304 
         LET l_xcci901_sum1  = l_xcci901_sum1  + g_xccd3_d[l_ac].xcci901  #dorislai-20151021-add
         LET l_xcci902a_sum1 = l_xcci902a_sum1 + g_xccd3_d[l_ac].xcci902a
         LET l_xcci902b_sum1 = l_xcci902b_sum1 + g_xccd3_d[l_ac].xcci902b
         LET l_xcci902c_sum1 = l_xcci902c_sum1 + g_xccd3_d[l_ac].xcci902c
         LET l_xcci902d_sum1 = l_xcci902d_sum1 + g_xccd3_d[l_ac].xcci902d
         LET l_xcci902e_sum1 = l_xcci902e_sum1 + g_xccd3_d[l_ac].xcci902e
         LET l_xcci902f_sum1 = l_xcci902f_sum1 + g_xccd3_d[l_ac].xcci902f
         LET l_xcci902g_sum1 = l_xcci902g_sum1 + g_xccd3_d[l_ac].xcci902g
         LET l_xcci902h_sum1 = l_xcci902h_sum1 + g_xccd3_d[l_ac].xcci902h
         LET l_xcci902_sum1  = l_xcci902_sum1  + g_xccd3_d[l_ac].xcci902 
         IF l_ac > 1 THEN
            IF g_xccd3_d[l_ac].xcci006 != g_xccd3_d[l_ac-1].xcci006 THEN
               #把当前行下移，并在当前行显示小计
               LET g_xccd3_d[l_ac + 1].* = g_xccd3_d[l_ac].*  
               INITIALIZE  g_xccd3_d[l_ac].* TO NULL
               #LET g_xccd3_d[l_ac].xcci006  = cl_getmsg("axc-00577",g_lang) #160201-00004#1 mark
               LET g_xccd3_d[l_ac].xcci006  = cl_getmsg("lib-00156",g_lang),"-",g_xccd3_d[l_ac].xcci006  #160201-00004#1 
               #170123-00012#1---mark---s            
               ##160108-00001#1-add----(S)
               #LET g_xccd3_d[l_ac].xcch007  = g_xccd3_d[l_ac-1].xcch007 
               #LET g_xccd3_d[l_ac].xcch007_desc  = g_xccd3_d[l_ac-1].xcch007_desc 
               #LET g_xccd3_d[l_ac].xcch007_desc_desc  = g_xccd3_d[l_ac-1].xcch007_desc_desc
               ##160108-00001#1-add----(E)
               #170123-00012#1---mark---e            
               LET g_xccd3_d[l_ac].xcch301  = g_xccd3_d[l_ac-1].xcch301 #160106-00012#1-add
               LET g_xccd3_d[l_ac].xcci101  = l_xcci101_sum1  - g_xccd3_d[l_ac+1].xcci101  #dorislai-20151021-add
               LET g_xccd3_d[l_ac].xcci102a = l_xcci102a_sum1 - g_xccd3_d[l_ac+1].xcci102a
               LET g_xccd3_d[l_ac].xcci102b = l_xcci102b_sum1 - g_xccd3_d[l_ac+1].xcci102b
               LET g_xccd3_d[l_ac].xcci102c = l_xcci102c_sum1 - g_xccd3_d[l_ac+1].xcci102c
               LET g_xccd3_d[l_ac].xcci102d = l_xcci102d_sum1 - g_xccd3_d[l_ac+1].xcci102d
               LET g_xccd3_d[l_ac].xcci102e = l_xcci102e_sum1 - g_xccd3_d[l_ac+1].xcci102e
               LET g_xccd3_d[l_ac].xcci102f = l_xcci102f_sum1 - g_xccd3_d[l_ac+1].xcci102f
               LET g_xccd3_d[l_ac].xcci102g = l_xcci102g_sum1 - g_xccd3_d[l_ac+1].xcci102g
               LET g_xccd3_d[l_ac].xcci102h = l_xcci102h_sum1 - g_xccd3_d[l_ac+1].xcci102h
               LET g_xccd3_d[l_ac].xcci102  = l_xcci102_sum1  - g_xccd3_d[l_ac+1].xcci102
               LET g_xccd3_d[l_ac].xcci201  = l_xcci201_sum1  - g_xccd3_d[l_ac+1].xcci201  #dorislai-20151021-add
               LET g_xccd3_d[l_ac].xcci202a = l_xcci202a_sum1 - g_xccd3_d[l_ac+1].xcci202a            
               LET g_xccd3_d[l_ac].xcci202b = l_xcci202b_sum1 - g_xccd3_d[l_ac+1].xcci202b
               LET g_xccd3_d[l_ac].xcci202c = l_xcci202c_sum1 - g_xccd3_d[l_ac+1].xcci202c
               LET g_xccd3_d[l_ac].xcci202d = l_xcci202d_sum1 - g_xccd3_d[l_ac+1].xcci202d
               LET g_xccd3_d[l_ac].xcci202e = l_xcci202e_sum1 - g_xccd3_d[l_ac+1].xcci202e
               LET g_xccd3_d[l_ac].xcci202f = l_xcci202f_sum1 - g_xccd3_d[l_ac+1].xcci202f
               LET g_xccd3_d[l_ac].xcci202g = l_xcci202g_sum1 - g_xccd3_d[l_ac+1].xcci202g
               LET g_xccd3_d[l_ac].xcci202h = l_xcci202h_sum1 - g_xccd3_d[l_ac+1].xcci202h
               LET g_xccd3_d[l_ac].xcci202  = l_xcci202_sum1  - g_xccd3_d[l_ac+1].xcci202 
               LET g_xccd3_d[l_ac].xcci301  = l_xcci301_sum1  - g_xccd3_d[l_ac+1].xcci301  #dorislai-20151021-add
               LET g_xccd3_d[l_ac].xcci302a = l_xcci302a_sum1 - g_xccd3_d[l_ac+1].xcci302a
               LET g_xccd3_d[l_ac].xcci302b = l_xcci302b_sum1 - g_xccd3_d[l_ac+1].xcci302b
               LET g_xccd3_d[l_ac].xcci302c = l_xcci302c_sum1 - g_xccd3_d[l_ac+1].xcci302c
               LET g_xccd3_d[l_ac].xcci302d = l_xcci302d_sum1 - g_xccd3_d[l_ac+1].xcci302d
               LET g_xccd3_d[l_ac].xcci302e = l_xcci302e_sum1 - g_xccd3_d[l_ac+1].xcci302e
               LET g_xccd3_d[l_ac].xcci302f = l_xcci302f_sum1 - g_xccd3_d[l_ac+1].xcci302f
               LET g_xccd3_d[l_ac].xcci302g = l_xcci302g_sum1 - g_xccd3_d[l_ac+1].xcci302g
               LET g_xccd3_d[l_ac].xcci302h = l_xcci302h_sum1 - g_xccd3_d[l_ac+1].xcci302h
               LET g_xccd3_d[l_ac].xcci302  = l_xcci302_sum1  - g_xccd3_d[l_ac+1].xcci302 
               LET g_xccd3_d[l_ac].xcci303  = l_xcci303_sum1  - g_xccd3_d[l_ac+1].xcci303  #dorislai-20151021-add
               LET g_xccd3_d[l_ac].xcci304a = l_xcci304a_sum1 - g_xccd3_d[l_ac+1].xcci304a
               LET g_xccd3_d[l_ac].xcci304b = l_xcci304b_sum1 - g_xccd3_d[l_ac+1].xcci304b
               LET g_xccd3_d[l_ac].xcci304c = l_xcci304c_sum1 - g_xccd3_d[l_ac+1].xcci304c
               LET g_xccd3_d[l_ac].xcci304d = l_xcci304d_sum1 - g_xccd3_d[l_ac+1].xcci304d
               LET g_xccd3_d[l_ac].xcci304e = l_xcci304e_sum1 - g_xccd3_d[l_ac+1].xcci304e
               LET g_xccd3_d[l_ac].xcci304f = l_xcci304f_sum1 - g_xccd3_d[l_ac+1].xcci304f
               LET g_xccd3_d[l_ac].xcci304g = l_xcci304g_sum1 - g_xccd3_d[l_ac+1].xcci304g
               LET g_xccd3_d[l_ac].xcci304h = l_xcci304h_sum1 - g_xccd3_d[l_ac+1].xcci304h
               LET g_xccd3_d[l_ac].xcci304  = l_xcci304_sum1  - g_xccd3_d[l_ac+1].xcci304  
               LET g_xccd3_d[l_ac].xcci901  = l_xcci901_sum1  - g_xccd3_d[l_ac+1].xcci901  #dorislai-20151021-add
               LET g_xccd3_d[l_ac].xcci902a = l_xcci902a_sum1 - g_xccd3_d[l_ac+1].xcci902a
               LET g_xccd3_d[l_ac].xcci902b = l_xcci902b_sum1 - g_xccd3_d[l_ac+1].xcci902b
               LET g_xccd3_d[l_ac].xcci902c = l_xcci902c_sum1 - g_xccd3_d[l_ac+1].xcci902c
               LET g_xccd3_d[l_ac].xcci902d = l_xcci902d_sum1 - g_xccd3_d[l_ac+1].xcci902d
               LET g_xccd3_d[l_ac].xcci902e = l_xcci902e_sum1 - g_xccd3_d[l_ac+1].xcci902e
               LET g_xccd3_d[l_ac].xcci902f = l_xcci902f_sum1 - g_xccd3_d[l_ac+1].xcci902f
               LET g_xccd3_d[l_ac].xcci902g = l_xcci902g_sum1 - g_xccd3_d[l_ac+1].xcci902g
               LET g_xccd3_d[l_ac].xcci902h = l_xcci902h_sum1 - g_xccd3_d[l_ac+1].xcci902h
               LET g_xccd3_d[l_ac].xcci902  = l_xcci902_sum1  - g_xccd3_d[l_ac+1].xcci902 
               LET l_ac = l_ac + 1
               LET l_xcci101_sum1  = g_xccd3_d[l_ac].xcci101  #dorislai-20151021-add
               LET l_xcci102a_sum1 = g_xccd3_d[l_ac].xcci102a
               LET l_xcci102b_sum1 = g_xccd3_d[l_ac].xcci102b
               LET l_xcci102c_sum1 = g_xccd3_d[l_ac].xcci102c
               LET l_xcci102d_sum1 = g_xccd3_d[l_ac].xcci102d
               LET l_xcci102e_sum1 = g_xccd3_d[l_ac].xcci102e
               LET l_xcci102f_sum1 = g_xccd3_d[l_ac].xcci102f
               LET l_xcci102g_sum1 = g_xccd3_d[l_ac].xcci102g
               LET l_xcci102h_sum1 = g_xccd3_d[l_ac].xcci102h
               LET l_xcci102_sum1  = g_xccd3_d[l_ac].xcci102
               LET l_xcci201_sum1  = g_xccd3_d[l_ac].xcci201  #dorislai-20151021-add
               LET l_xcci202a_sum1 = g_xccd3_d[l_ac].xcci202a            
               LET l_xcci202b_sum1 = g_xccd3_d[l_ac].xcci202b
               LET l_xcci202c_sum1 = g_xccd3_d[l_ac].xcci202c
               LET l_xcci202d_sum1 = g_xccd3_d[l_ac].xcci202d
               LET l_xcci202e_sum1 = g_xccd3_d[l_ac].xcci202e
               LET l_xcci202f_sum1 = g_xccd3_d[l_ac].xcci202f
               LET l_xcci202g_sum1 = g_xccd3_d[l_ac].xcci202g
               LET l_xcci202h_sum1 = g_xccd3_d[l_ac].xcci202h
               LET l_xcci202_sum1  = g_xccd3_d[l_ac].xcci202 
               LET l_xcci301_sum1  = g_xccd3_d[l_ac].xcci301  #dorislai-20151021-add
               LET l_xcci302a_sum1 = g_xccd3_d[l_ac].xcci302a
               LET l_xcci302b_sum1 = g_xccd3_d[l_ac].xcci302b
               LET l_xcci302c_sum1 = g_xccd3_d[l_ac].xcci302c
               LET l_xcci302d_sum1 = g_xccd3_d[l_ac].xcci302d
               LET l_xcci302e_sum1 = g_xccd3_d[l_ac].xcci302e
               LET l_xcci302f_sum1 = g_xccd3_d[l_ac].xcci302f
               LET l_xcci302g_sum1 = g_xccd3_d[l_ac].xcci302g
               LET l_xcci302h_sum1 = g_xccd3_d[l_ac].xcci302h
               LET l_xcci302_sum1  = g_xccd3_d[l_ac].xcci302 
               LET l_xcci303_sum1  = g_xccd3_d[l_ac].xcci303  #dorislai-20151021-add
               LET l_xcci304a_sum1 = g_xccd3_d[l_ac].xcci304a
               LET l_xcci304b_sum1 = g_xccd3_d[l_ac].xcci304b
               LET l_xcci304c_sum1 = g_xccd3_d[l_ac].xcci304c
               LET l_xcci304d_sum1 = g_xccd3_d[l_ac].xcci304d
               LET l_xcci304e_sum1 = g_xccd3_d[l_ac].xcci304e
               LET l_xcci304f_sum1 = g_xccd3_d[l_ac].xcci304f
               LET l_xcci304g_sum1 = g_xccd3_d[l_ac].xcci304g
               LET l_xcci304h_sum1 = g_xccd3_d[l_ac].xcci304h
               LET l_xcci304_sum1  = g_xccd3_d[l_ac].xcci304  
               LET l_xcci901_sum1  = g_xccd3_d[l_ac].xcci901  #dorislai-20151021-add
               LET l_xcci902a_sum1 = g_xccd3_d[l_ac].xcci902a
               LET l_xcci902b_sum1 = g_xccd3_d[l_ac].xcci902b
               LET l_xcci902c_sum1 = g_xccd3_d[l_ac].xcci902c
               LET l_xcci902d_sum1 = g_xccd3_d[l_ac].xcci902d
               LET l_xcci902e_sum1 = g_xccd3_d[l_ac].xcci902e
               LET l_xcci902f_sum1 = g_xccd3_d[l_ac].xcci902f
               LET l_xcci902g_sum1 = g_xccd3_d[l_ac].xcci902g
               LET l_xcci902h_sum1 = g_xccd3_d[l_ac].xcci902h
               LET l_xcci902_sum1  = g_xccd3_d[l_ac].xcci902 
            END IF            
         END IF         
#按组织小计
         LET l_xcci101_sum2  = l_xcci101_sum2  + g_xccd3_d[l_ac].xcci101  #dorislai-20151021-add
         LET l_xcci102a_sum2 = l_xcci102a_sum2 + g_xccd3_d[l_ac].xcci102a
         LET l_xcci102b_sum2 = l_xcci102b_sum2 + g_xccd3_d[l_ac].xcci102b
         LET l_xcci102c_sum2 = l_xcci102c_sum2 + g_xccd3_d[l_ac].xcci102c
         LET l_xcci102d_sum2 = l_xcci102d_sum2 + g_xccd3_d[l_ac].xcci102d
         LET l_xcci102e_sum2 = l_xcci102e_sum2 + g_xccd3_d[l_ac].xcci102e
         LET l_xcci102f_sum2 = l_xcci102f_sum2 + g_xccd3_d[l_ac].xcci102f
         LET l_xcci102g_sum2 = l_xcci102g_sum2 + g_xccd3_d[l_ac].xcci102g
         LET l_xcci102h_sum2 = l_xcci102h_sum2 + g_xccd3_d[l_ac].xcci102h
         LET l_xcci102_sum2  = l_xcci102_sum2  + g_xccd3_d[l_ac].xcci102 
         LET l_xcci201_sum2  = l_xcci201_sum2  + g_xccd3_d[l_ac].xcci201  #dorislai-20151021-add
         LET l_xcci202a_sum2 = l_xcci202a_sum2 + g_xccd3_d[l_ac].xcci202a
         LET l_xcci202b_sum2 = l_xcci202b_sum2 + g_xccd3_d[l_ac].xcci202b
         LET l_xcci202c_sum2 = l_xcci202c_sum2 + g_xccd3_d[l_ac].xcci202c
         LET l_xcci202d_sum2 = l_xcci202d_sum2 + g_xccd3_d[l_ac].xcci202d
         LET l_xcci202e_sum2 = l_xcci202e_sum2 + g_xccd3_d[l_ac].xcci202e
         LET l_xcci202f_sum2 = l_xcci202f_sum2 + g_xccd3_d[l_ac].xcci202f
         LET l_xcci202g_sum2 = l_xcci202g_sum2 + g_xccd3_d[l_ac].xcci202g
         LET l_xcci202h_sum2 = l_xcci202h_sum2 + g_xccd3_d[l_ac].xcci202h
         LET l_xcci202_sum2  = l_xcci202_sum2  + g_xccd3_d[l_ac].xcci202 
         LET l_xcci301_sum2  = l_xcci301_sum2  + g_xccd3_d[l_ac].xcci301  #dorislai-20151021-add
         LET l_xcci302a_sum2 = l_xcci302a_sum2 + g_xccd3_d[l_ac].xcci302a
         LET l_xcci302b_sum2 = l_xcci302b_sum2 + g_xccd3_d[l_ac].xcci302b
         LET l_xcci302c_sum2 = l_xcci302c_sum2 + g_xccd3_d[l_ac].xcci302c
         LET l_xcci302d_sum2 = l_xcci302d_sum2 + g_xccd3_d[l_ac].xcci302d
         LET l_xcci302e_sum2 = l_xcci302e_sum2 + g_xccd3_d[l_ac].xcci302e
         LET l_xcci302f_sum2 = l_xcci302f_sum2 + g_xccd3_d[l_ac].xcci302f
         LET l_xcci302g_sum2 = l_xcci302g_sum2 + g_xccd3_d[l_ac].xcci302g
         LET l_xcci302h_sum2 = l_xcci302h_sum2 + g_xccd3_d[l_ac].xcci302h
         LET l_xcci302_sum2  = l_xcci302_sum2  + g_xccd3_d[l_ac].xcci302 
         LET l_xcci303_sum2  = l_xcci303_sum2  + g_xccd3_d[l_ac].xcci303  #dorislai-20151021-add
         LET l_xcci304a_sum2 = l_xcci304a_sum2 + g_xccd3_d[l_ac].xcci304a
         LET l_xcci304b_sum2 = l_xcci304b_sum2 + g_xccd3_d[l_ac].xcci304b
         LET l_xcci304c_sum2 = l_xcci304c_sum2 + g_xccd3_d[l_ac].xcci304c
         LET l_xcci304d_sum2 = l_xcci304d_sum2 + g_xccd3_d[l_ac].xcci304d
         LET l_xcci304e_sum2 = l_xcci304e_sum2 + g_xccd3_d[l_ac].xcci304e
         LET l_xcci304f_sum2 = l_xcci304f_sum2 + g_xccd3_d[l_ac].xcci304f
         LET l_xcci304g_sum2 = l_xcci304g_sum2 + g_xccd3_d[l_ac].xcci304g
         LET l_xcci304h_sum2 = l_xcci304h_sum2 + g_xccd3_d[l_ac].xcci304h
         LET l_xcci304_sum2  = l_xcci304_sum2  + g_xccd3_d[l_ac].xcci304  
         LET l_xcci901_sum2  = l_xcci901_sum2  + g_xccd3_d[l_ac].xcci901  #dorislai-20151021-add
         LET l_xcci902a_sum2 = l_xcci902a_sum2 + g_xccd3_d[l_ac].xcci902a
         LET l_xcci902b_sum2 = l_xcci902b_sum2 + g_xccd3_d[l_ac].xcci902b
         LET l_xcci902c_sum2 = l_xcci902c_sum2 + g_xccd3_d[l_ac].xcci902c
         LET l_xcci902d_sum2 = l_xcci902d_sum2 + g_xccd3_d[l_ac].xcci902d
         LET l_xcci902e_sum2 = l_xcci902e_sum2 + g_xccd3_d[l_ac].xcci902e
         LET l_xcci902f_sum2 = l_xcci902f_sum2 + g_xccd3_d[l_ac].xcci902f
         LET l_xcci902g_sum2 = l_xcci902g_sum2 + g_xccd3_d[l_ac].xcci902g
         LET l_xcci902h_sum2 = l_xcci902h_sum2 + g_xccd3_d[l_ac].xcci902h
         LET l_xcci902_sum2  = l_xcci902_sum2  + g_xccd3_d[l_ac].xcci902 
         IF l_ac > 2 THEN
            #IF g_xccd3_d[l_ac].sfaa068 != g_xccd3_d[l_ac-2].sfaa068 THEN  #170123-00012#1 mark
            IF g_xccd3_d[l_ac].sfaa068 != g_xccd3_d[l_ac-2].sfaa068 AND g_xccd3_d[l_ac].xcci006 != g_xccd3_d[l_ac-1].xcci006 THEN  #170123-00012#1 mark
               #把当前行下移，并在当前行显示小计
               LET g_xccd3_d[l_ac + 1].* = g_xccd3_d[l_ac].*  
               INITIALIZE  g_xccd3_d[l_ac].* TO NULL
               #LET g_xccd3_d[l_ac].sfaa068  = cl_getmsg("axc-00578",g_lang) #160201-00004#1 mark           
               #LET g_xccd3_d[l_ac].sfaa068  = cl_getmsg("lib-00156",g_lang),"-",g_xccd3_d[l_ac-2].sfaa068  #160201-00004#1  #170123-00012#1 mark         
               LET g_xccd3_d[l_ac].sfaa068  = cl_getmsg("aps-00134",g_lang),"-",g_xccd3_d[l_ac-2].sfaa068   #170123-00012#1 
               LET g_xccd3_d[l_ac].xcci101  = l_xcci101_sum2  - g_xccd3_d[l_ac+1].xcci101  #dorislai-20151021-add
               LET g_xccd3_d[l_ac].xcci102a = l_xcci102a_sum2 - g_xccd3_d[l_ac+1].xcci102a
               LET g_xccd3_d[l_ac].xcci102b = l_xcci102b_sum2 - g_xccd3_d[l_ac+1].xcci102b
               LET g_xccd3_d[l_ac].xcci102c = l_xcci102c_sum2 - g_xccd3_d[l_ac+1].xcci102c
               LET g_xccd3_d[l_ac].xcci102d = l_xcci102d_sum2 - g_xccd3_d[l_ac+1].xcci102d
               LET g_xccd3_d[l_ac].xcci102e = l_xcci102e_sum2 - g_xccd3_d[l_ac+1].xcci102e
               LET g_xccd3_d[l_ac].xcci102f = l_xcci102f_sum2 - g_xccd3_d[l_ac+1].xcci102f
               LET g_xccd3_d[l_ac].xcci102g = l_xcci102g_sum2 - g_xccd3_d[l_ac+1].xcci102g
               LET g_xccd3_d[l_ac].xcci102h = l_xcci102h_sum2 - g_xccd3_d[l_ac+1].xcci102h
               LET g_xccd3_d[l_ac].xcci102  = l_xcci102_sum2  - g_xccd3_d[l_ac+1].xcci102
               LET g_xccd3_d[l_ac].xcci201  = l_xcci201_sum2  - g_xccd3_d[l_ac+1].xcci201  #dorislai-20151021-add
               LET g_xccd3_d[l_ac].xcci202a = l_xcci202a_sum2 - g_xccd3_d[l_ac+1].xcci202a            
               LET g_xccd3_d[l_ac].xcci202b = l_xcci202b_sum2 - g_xccd3_d[l_ac+1].xcci202b
               LET g_xccd3_d[l_ac].xcci202c = l_xcci202c_sum2 - g_xccd3_d[l_ac+1].xcci202c
               LET g_xccd3_d[l_ac].xcci202d = l_xcci202d_sum2 - g_xccd3_d[l_ac+1].xcci202d
               LET g_xccd3_d[l_ac].xcci202e = l_xcci202e_sum2 - g_xccd3_d[l_ac+1].xcci202e
               LET g_xccd3_d[l_ac].xcci202f = l_xcci202f_sum2 - g_xccd3_d[l_ac+1].xcci202f
               LET g_xccd3_d[l_ac].xcci202g = l_xcci202g_sum2 - g_xccd3_d[l_ac+1].xcci202g
               LET g_xccd3_d[l_ac].xcci202h = l_xcci202h_sum2 - g_xccd3_d[l_ac+1].xcci202h
               LET g_xccd3_d[l_ac].xcci202  = l_xcci202_sum2  - g_xccd3_d[l_ac+1].xcci202 
               LET g_xccd3_d[l_ac].xcci301  = l_xcci301_sum2  - g_xccd3_d[l_ac+1].xcci301  #dorislai-20151021-add
               LET g_xccd3_d[l_ac].xcci302a = l_xcci302a_sum2 - g_xccd3_d[l_ac+1].xcci302a
               LET g_xccd3_d[l_ac].xcci302b = l_xcci302b_sum2 - g_xccd3_d[l_ac+1].xcci302b
               LET g_xccd3_d[l_ac].xcci302c = l_xcci302c_sum2 - g_xccd3_d[l_ac+1].xcci302c
               LET g_xccd3_d[l_ac].xcci302d = l_xcci302d_sum2 - g_xccd3_d[l_ac+1].xcci302d
               LET g_xccd3_d[l_ac].xcci302e = l_xcci302e_sum2 - g_xccd3_d[l_ac+1].xcci302e
               LET g_xccd3_d[l_ac].xcci302f = l_xcci302f_sum2 - g_xccd3_d[l_ac+1].xcci302f
               LET g_xccd3_d[l_ac].xcci302g = l_xcci302g_sum2 - g_xccd3_d[l_ac+1].xcci302g
               LET g_xccd3_d[l_ac].xcci302h = l_xcci302h_sum2 - g_xccd3_d[l_ac+1].xcci302h
               LET g_xccd3_d[l_ac].xcci302  = l_xcci302_sum2  - g_xccd3_d[l_ac+1].xcci302 
               LET g_xccd3_d[l_ac].xcci303  = l_xcci303_sum2  - g_xccd3_d[l_ac+1].xcci303  #dorislai-20151021-add
               LET g_xccd3_d[l_ac].xcci304a = l_xcci304a_sum2 - g_xccd3_d[l_ac+1].xcci304a
               LET g_xccd3_d[l_ac].xcci304b = l_xcci304b_sum2 - g_xccd3_d[l_ac+1].xcci304b
               LET g_xccd3_d[l_ac].xcci304c = l_xcci304c_sum2 - g_xccd3_d[l_ac+1].xcci304c
               LET g_xccd3_d[l_ac].xcci304d = l_xcci304d_sum2 - g_xccd3_d[l_ac+1].xcci304d
               LET g_xccd3_d[l_ac].xcci304e = l_xcci304e_sum2 - g_xccd3_d[l_ac+1].xcci304e
               LET g_xccd3_d[l_ac].xcci304f = l_xcci304f_sum2 - g_xccd3_d[l_ac+1].xcci304f
               LET g_xccd3_d[l_ac].xcci304g = l_xcci304g_sum2 - g_xccd3_d[l_ac+1].xcci304g
               LET g_xccd3_d[l_ac].xcci304h = l_xcci304h_sum2 - g_xccd3_d[l_ac+1].xcci304h
               LET g_xccd3_d[l_ac].xcci304  = l_xcci304_sum2  - g_xccd3_d[l_ac+1].xcci304 
               LET g_xccd3_d[l_ac].xcci901  = l_xcci901_sum2  - g_xccd3_d[l_ac+1].xcci901  #dorislai-20151021-add
               LET g_xccd3_d[l_ac].xcci902a = l_xcci902a_sum2 - g_xccd3_d[l_ac+1].xcci902a
               LET g_xccd3_d[l_ac].xcci902b = l_xcci902b_sum2 - g_xccd3_d[l_ac+1].xcci902b
               LET g_xccd3_d[l_ac].xcci902c = l_xcci902c_sum2 - g_xccd3_d[l_ac+1].xcci902c
               LET g_xccd3_d[l_ac].xcci902d = l_xcci902d_sum2 - g_xccd3_d[l_ac+1].xcci902d
               LET g_xccd3_d[l_ac].xcci902e = l_xcci902e_sum2 - g_xccd3_d[l_ac+1].xcci902e
               LET g_xccd3_d[l_ac].xcci902f = l_xcci902f_sum2 - g_xccd3_d[l_ac+1].xcci902f
               LET g_xccd3_d[l_ac].xcci902g = l_xcci902g_sum2 - g_xccd3_d[l_ac+1].xcci902g
               LET g_xccd3_d[l_ac].xcci902h = l_xcci902h_sum2 - g_xccd3_d[l_ac+1].xcci902h
               LET g_xccd3_d[l_ac].xcci902  = l_xcci902_sum2  - g_xccd3_d[l_ac+1].xcci902 
               LET l_ac = l_ac + 1
               LET l_xcci101_sum2  = g_xccd3_d[l_ac].xcci101  #dorislai-20151021-add
               LET l_xcci102a_sum2 = g_xccd3_d[l_ac].xcci102a
               LET l_xcci102b_sum2 = g_xccd3_d[l_ac].xcci102b
               LET l_xcci102c_sum2 = g_xccd3_d[l_ac].xcci102c
               LET l_xcci102d_sum2 = g_xccd3_d[l_ac].xcci102d
               LET l_xcci102e_sum2 = g_xccd3_d[l_ac].xcci102e
               LET l_xcci102f_sum2 = g_xccd3_d[l_ac].xcci102f
               LET l_xcci102g_sum2 = g_xccd3_d[l_ac].xcci102g
               LET l_xcci102h_sum2 = g_xccd3_d[l_ac].xcci102h
               LET l_xcci102_sum2  = g_xccd3_d[l_ac].xcci102 
               LET l_xcci201_sum2  = g_xccd3_d[l_ac].xcci201  #dorislai-20151021-add
               LET l_xcci202a_sum2 = g_xccd3_d[l_ac].xcci202a
               LET l_xcci202b_sum2 = g_xccd3_d[l_ac].xcci202b
               LET l_xcci202c_sum2 = g_xccd3_d[l_ac].xcci202c
               LET l_xcci202d_sum2 = g_xccd3_d[l_ac].xcci202d
               LET l_xcci202e_sum2 = g_xccd3_d[l_ac].xcci202e
               LET l_xcci202f_sum2 = g_xccd3_d[l_ac].xcci202f
               LET l_xcci202g_sum2 = g_xccd3_d[l_ac].xcci202g
               LET l_xcci202h_sum2 = g_xccd3_d[l_ac].xcci202h
               LET l_xcci202_sum2  = g_xccd3_d[l_ac].xcci202 
               LET l_xcci301_sum2  = g_xccd3_d[l_ac].xcci301  #dorislai-20151021-add
               LET l_xcci302a_sum2 = g_xccd3_d[l_ac].xcci302a
               LET l_xcci302b_sum2 = g_xccd3_d[l_ac].xcci302b
               LET l_xcci302c_sum2 = g_xccd3_d[l_ac].xcci302c
               LET l_xcci302d_sum2 = g_xccd3_d[l_ac].xcci302d
               LET l_xcci302e_sum2 = g_xccd3_d[l_ac].xcci302e
               LET l_xcci302f_sum2 = g_xccd3_d[l_ac].xcci302f
               LET l_xcci302g_sum2 = g_xccd3_d[l_ac].xcci302g
               LET l_xcci302h_sum2 = g_xccd3_d[l_ac].xcci302h
               LET l_xcci302_sum2  = g_xccd3_d[l_ac].xcci302 
               LET l_xcci303_sum2  = g_xccd3_d[l_ac].xcci303  #dorislai-20151021-add
               LET l_xcci304a_sum2 = g_xccd3_d[l_ac].xcci304a
               LET l_xcci304b_sum2 = g_xccd3_d[l_ac].xcci304b
               LET l_xcci304c_sum2 = g_xccd3_d[l_ac].xcci304c
               LET l_xcci304d_sum2 = g_xccd3_d[l_ac].xcci304d
               LET l_xcci304e_sum2 = g_xccd3_d[l_ac].xcci304e
               LET l_xcci304f_sum2 = g_xccd3_d[l_ac].xcci304f
               LET l_xcci304g_sum2 = g_xccd3_d[l_ac].xcci304g
               LET l_xcci304h_sum2 = g_xccd3_d[l_ac].xcci304h
               LET l_xcci304_sum2  = g_xccd3_d[l_ac].xcci304  
               LET l_xcci901_sum2  = g_xccd3_d[l_ac].xcci901  #dorislai-20151021-add
               LET l_xcci902a_sum2 = g_xccd3_d[l_ac].xcci902a
               LET l_xcci902b_sum2 = g_xccd3_d[l_ac].xcci902b
               LET l_xcci902c_sum2 = g_xccd3_d[l_ac].xcci902c
               LET l_xcci902d_sum2 = g_xccd3_d[l_ac].xcci902d
               LET l_xcci902e_sum2 = g_xccd3_d[l_ac].xcci902e
               LET l_xcci902f_sum2 = g_xccd3_d[l_ac].xcci902f
               LET l_xcci902g_sum2 = g_xccd3_d[l_ac].xcci902g
               LET l_xcci902h_sum2 = g_xccd3_d[l_ac].xcci902h
               LET l_xcci902_sum2  = g_xccd3_d[l_ac].xcci902 
            END IF            
         END IF           
         


         LET l_ac = l_ac + 1
         IF l_ac > g_max_rec THEN
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = l_ac
            LET g_errparam.code   = 9035 
            LET g_errparam.popup  = TRUE 
            CALL cl_err()
            EXIT FOREACH
         END IF
         
      END FOREACH
      
#最后一组小计，还有合计
#按在制单号小计
      IF l_ac > 1 THEN
         #LET g_xccd3_d[l_ac].xcci006  = cl_getmsg("axc-00577",g_lang) #160201-00004#1 mark
         LET g_xccd3_d[l_ac].xcci006  = cl_getmsg("lib-00156",g_lang),"-",g_xccd3_d[l_ac-1].xcci006 #160201-00004#1
         #170123-00012#1---mark---s            
         ##160108-00001#1-add----(S)
         #LET g_xccd3_d[l_ac].xcch007  = g_xccd3_d[l_ac-1].xcch007 
         #LET g_xccd3_d[l_ac].xcch007_desc  = g_xccd3_d[l_ac-1].xcch007_desc 
         #LET g_xccd3_d[l_ac].xcch007_desc_desc  = g_xccd3_d[l_ac-1].xcch007_desc_desc
         ##160108-00001#1-add----(E)
         #170123-00012#1---mark---e            
         LET g_xccd3_d[l_ac].xcch301  = g_xccd3_d[l_ac-1].xcch301 #160106-00012#1-add
         LET g_xccd3_d[l_ac].xcci101  = l_xcci101_sum1  #dorislai-20151021-add
         LET g_xccd3_d[l_ac].xcci102a = l_xcci102a_sum1 
         LET g_xccd3_d[l_ac].xcci102b = l_xcci102b_sum1 
         LET g_xccd3_d[l_ac].xcci102c = l_xcci102c_sum1 
         LET g_xccd3_d[l_ac].xcci102d = l_xcci102d_sum1 
         LET g_xccd3_d[l_ac].xcci102e = l_xcci102e_sum1 
         LET g_xccd3_d[l_ac].xcci102f = l_xcci102f_sum1 
         LET g_xccd3_d[l_ac].xcci102g = l_xcci102g_sum1 
         LET g_xccd3_d[l_ac].xcci102h = l_xcci102h_sum1 
         LET g_xccd3_d[l_ac].xcci102  = l_xcci102_sum1
         LET g_xccd3_d[l_ac].xcci201  = l_xcci201_sum1  #dorislai-20151021-add
         LET g_xccd3_d[l_ac].xcci202a = l_xcci202a_sum1         
         LET g_xccd3_d[l_ac].xcci202b = l_xcci202b_sum1 
         LET g_xccd3_d[l_ac].xcci202c = l_xcci202c_sum1 
         LET g_xccd3_d[l_ac].xcci202d = l_xcci202d_sum1 
         LET g_xccd3_d[l_ac].xcci202e = l_xcci202e_sum1 
         LET g_xccd3_d[l_ac].xcci202f = l_xcci202f_sum1 
         LET g_xccd3_d[l_ac].xcci202g = l_xcci202g_sum1 
         LET g_xccd3_d[l_ac].xcci202h = l_xcci202h_sum1 
         LET g_xccd3_d[l_ac].xcci202  = l_xcci202_sum1  
         LET g_xccd3_d[l_ac].xcci301  = l_xcci301_sum1  #dorislai-20151021-add
         LET g_xccd3_d[l_ac].xcci302a = l_xcci302a_sum1 
         LET g_xccd3_d[l_ac].xcci302b = l_xcci302b_sum1 
         LET g_xccd3_d[l_ac].xcci302c = l_xcci302c_sum1 
         LET g_xccd3_d[l_ac].xcci302d = l_xcci302d_sum1 
         LET g_xccd3_d[l_ac].xcci302e = l_xcci302e_sum1 
         LET g_xccd3_d[l_ac].xcci302f = l_xcci302f_sum1 
         LET g_xccd3_d[l_ac].xcci302g = l_xcci302g_sum1 
         LET g_xccd3_d[l_ac].xcci302h = l_xcci302h_sum1 
         LET g_xccd3_d[l_ac].xcci302  = l_xcci302_sum1  
         LET g_xccd3_d[l_ac].xcci303  = l_xcci303_sum1  #dorislai-20151021-add
         LET g_xccd3_d[l_ac].xcci304a = l_xcci304a_sum1 
         LET g_xccd3_d[l_ac].xcci304b = l_xcci304b_sum1 
         LET g_xccd3_d[l_ac].xcci304c = l_xcci304c_sum1 
         LET g_xccd3_d[l_ac].xcci304d = l_xcci304d_sum1 
         LET g_xccd3_d[l_ac].xcci304e = l_xcci304e_sum1 
         LET g_xccd3_d[l_ac].xcci304f = l_xcci304f_sum1 
         LET g_xccd3_d[l_ac].xcci304g = l_xcci304g_sum1 
         LET g_xccd3_d[l_ac].xcci304h = l_xcci304h_sum1 
         LET g_xccd3_d[l_ac].xcci304  = l_xcci304_sum1    
         LET g_xccd3_d[l_ac].xcci901  = l_xcci901_sum1  #dorislai-20151021-add
         LET g_xccd3_d[l_ac].xcci902a = l_xcci902a_sum1 
         LET g_xccd3_d[l_ac].xcci902b = l_xcci902b_sum1 
         LET g_xccd3_d[l_ac].xcci902c = l_xcci902c_sum1 
         LET g_xccd3_d[l_ac].xcci902d = l_xcci902d_sum1 
         LET g_xccd3_d[l_ac].xcci902e = l_xcci902e_sum1 
         LET g_xccd3_d[l_ac].xcci902f = l_xcci902f_sum1 
         LET g_xccd3_d[l_ac].xcci902g = l_xcci902g_sum1 
         LET g_xccd3_d[l_ac].xcci902h = l_xcci902h_sum1 
         LET g_xccd3_d[l_ac].xcci902  = l_xcci902_sum1  
         LET l_ac = l_ac+1  
#按组织小计
         #LET g_xccd3_d[l_ac].sfaa068  = cl_getmsg("axc-00578",g_lang) #160201-00004#1 mark 
         #LET g_xccd3_d[l_ac].sfaa068  = cl_getmsg("lib-00156",g_lang),"-",g_xccd3_d[l_ac-2].sfaa068   #160201-00004#1  #170123-00012#1 mark 
         LET g_xccd3_d[l_ac].sfaa068  = cl_getmsg("aps-00134",g_lang),"-",g_xccd3_d[l_ac-2].sfaa068   #170123-00012#1 
         LET g_xccd3_d[l_ac].xcci101  = l_xcci101_sum2  #dorislai-20151021-add
         LET g_xccd3_d[l_ac].xcci102a = l_xcci102a_sum2 
         LET g_xccd3_d[l_ac].xcci102b = l_xcci102b_sum2 
         LET g_xccd3_d[l_ac].xcci102c = l_xcci102c_sum2 
         LET g_xccd3_d[l_ac].xcci102d = l_xcci102d_sum2 
         LET g_xccd3_d[l_ac].xcci102e = l_xcci102e_sum2 
         LET g_xccd3_d[l_ac].xcci102f = l_xcci102f_sum2 
         LET g_xccd3_d[l_ac].xcci102g = l_xcci102g_sum2 
         LET g_xccd3_d[l_ac].xcci102h = l_xcci102h_sum2 
         LET g_xccd3_d[l_ac].xcci102  = l_xcci102_sum2
         LET g_xccd3_d[l_ac].xcci201  = l_xcci201_sum2  #dorislai-20151021-add
         LET g_xccd3_d[l_ac].xcci202a = l_xcci202a_sum2         
         LET g_xccd3_d[l_ac].xcci202b = l_xcci202b_sum2 
         LET g_xccd3_d[l_ac].xcci202c = l_xcci202c_sum2 
         LET g_xccd3_d[l_ac].xcci202d = l_xcci202d_sum2 
         LET g_xccd3_d[l_ac].xcci202e = l_xcci202e_sum2 
         LET g_xccd3_d[l_ac].xcci202f = l_xcci202f_sum2 
         LET g_xccd3_d[l_ac].xcci202g = l_xcci202g_sum2 
         LET g_xccd3_d[l_ac].xcci202h = l_xcci202h_sum2 
         LET g_xccd3_d[l_ac].xcci202  = l_xcci202_sum2 
         LET g_xccd3_d[l_ac].xcci301  = l_xcci301_sum2  #dorislai-20151021-add         
         LET g_xccd3_d[l_ac].xcci302a = l_xcci302a_sum2 
         LET g_xccd3_d[l_ac].xcci302b = l_xcci302b_sum2 
         LET g_xccd3_d[l_ac].xcci302c = l_xcci302c_sum2 
         LET g_xccd3_d[l_ac].xcci302d = l_xcci302d_sum2 
         LET g_xccd3_d[l_ac].xcci302e = l_xcci302e_sum2 
         LET g_xccd3_d[l_ac].xcci302f = l_xcci302f_sum2 
         LET g_xccd3_d[l_ac].xcci302g = l_xcci302g_sum2 
         LET g_xccd3_d[l_ac].xcci302h = l_xcci302h_sum2 
         LET g_xccd3_d[l_ac].xcci302  = l_xcci302_sum2  
         LET g_xccd3_d[l_ac].xcci303  = l_xcci303_sum2  #dorislai-20151021-add         
         LET g_xccd3_d[l_ac].xcci304a = l_xcci304a_sum2 
         LET g_xccd3_d[l_ac].xcci304b = l_xcci304b_sum2 
         LET g_xccd3_d[l_ac].xcci304c = l_xcci304c_sum2 
         LET g_xccd3_d[l_ac].xcci304d = l_xcci304d_sum2 
         LET g_xccd3_d[l_ac].xcci304e = l_xcci304e_sum2 
         LET g_xccd3_d[l_ac].xcci304f = l_xcci304f_sum2 
         LET g_xccd3_d[l_ac].xcci304g = l_xcci304g_sum2 
         LET g_xccd3_d[l_ac].xcci304h = l_xcci304h_sum2 
         LET g_xccd3_d[l_ac].xcci304  = l_xcci304_sum2   
         LET g_xccd3_d[l_ac].xcci901  = l_xcci901_sum2  #dorislai-20151021-add         
         LET g_xccd3_d[l_ac].xcci902a = l_xcci902a_sum2 
         LET g_xccd3_d[l_ac].xcci902b = l_xcci902b_sum2 
         LET g_xccd3_d[l_ac].xcci902c = l_xcci902c_sum2 
         LET g_xccd3_d[l_ac].xcci902d = l_xcci902d_sum2 
         LET g_xccd3_d[l_ac].xcci902e = l_xcci902e_sum2 
         LET g_xccd3_d[l_ac].xcci902f = l_xcci902f_sum2 
         LET g_xccd3_d[l_ac].xcci902g = l_xcci902g_sum2 
         LET g_xccd3_d[l_ac].xcci902h = l_xcci902h_sum2 
         LET g_xccd3_d[l_ac].xcci902  = l_xcci902_sum2  
         LET l_ac = l_ac + 1
#合计
         LET g_xccd3_d[l_ac].sfaa068  = cl_getmsg("lib-00133",g_lang)
         LET g_xccd3_d[l_ac].xcci101  = l_xcci101_total  #dorislai-20151021-add
         LET g_xccd3_d[l_ac].xcci102a = l_xcci102a_total 
         LET g_xccd3_d[l_ac].xcci102b = l_xcci102b_total 
         LET g_xccd3_d[l_ac].xcci102c = l_xcci102c_total 
         LET g_xccd3_d[l_ac].xcci102d = l_xcci102d_total 
         LET g_xccd3_d[l_ac].xcci102e = l_xcci102e_total 
         LET g_xccd3_d[l_ac].xcci102f = l_xcci102f_total 
         LET g_xccd3_d[l_ac].xcci102g = l_xcci102g_total 
         LET g_xccd3_d[l_ac].xcci102h = l_xcci102h_total 
         LET g_xccd3_d[l_ac].xcci102  = l_xcci102_total 
         LET g_xccd3_d[l_ac].xcci201  = l_xcci201_total  #dorislai-20151021-add
         LET g_xccd3_d[l_ac].xcci202a = l_xcci202a_total         
         LET g_xccd3_d[l_ac].xcci202b = l_xcci202b_total 
         LET g_xccd3_d[l_ac].xcci202c = l_xcci202c_total 
         LET g_xccd3_d[l_ac].xcci202d = l_xcci202d_total 
         LET g_xccd3_d[l_ac].xcci202e = l_xcci202e_total 
         LET g_xccd3_d[l_ac].xcci202f = l_xcci202f_total 
         LET g_xccd3_d[l_ac].xcci202g = l_xcci202g_total 
         LET g_xccd3_d[l_ac].xcci202h = l_xcci202h_total 
         LET g_xccd3_d[l_ac].xcci202  = l_xcci202_total  
         LET g_xccd3_d[l_ac].xcci301  = l_xcci301_total  #dorislai-20151021-add
         LET g_xccd3_d[l_ac].xcci302a = l_xcci302a_total 
         LET g_xccd3_d[l_ac].xcci302b = l_xcci302b_total 
         LET g_xccd3_d[l_ac].xcci302c = l_xcci302c_total 
         LET g_xccd3_d[l_ac].xcci302d = l_xcci302d_total 
         LET g_xccd3_d[l_ac].xcci302e = l_xcci302e_total 
         LET g_xccd3_d[l_ac].xcci302f = l_xcci302f_total 
         LET g_xccd3_d[l_ac].xcci302g = l_xcci302g_total 
         LET g_xccd3_d[l_ac].xcci302h = l_xcci302h_total 
         LET g_xccd3_d[l_ac].xcci302  = l_xcci302_total  
         LET g_xccd3_d[l_ac].xcci303  = l_xcci303_total  #dorislai-20151021-add
         LET g_xccd3_d[l_ac].xcci304a = l_xcci304a_total 
         LET g_xccd3_d[l_ac].xcci304b = l_xcci304b_total 
         LET g_xccd3_d[l_ac].xcci304c = l_xcci304c_total 
         LET g_xccd3_d[l_ac].xcci304d = l_xcci304d_total 
         LET g_xccd3_d[l_ac].xcci304e = l_xcci304e_total 
         LET g_xccd3_d[l_ac].xcci304f = l_xcci304f_total 
         LET g_xccd3_d[l_ac].xcci304g = l_xcci304g_total 
         LET g_xccd3_d[l_ac].xcci304h = l_xcci304h_total 
         LET g_xccd3_d[l_ac].xcci304  = l_xcci304_total    
         LET g_xccd3_d[l_ac].xcci901  = l_xcci901_total  #dorislai-20151021-add
         LET g_xccd3_d[l_ac].xcci902a = l_xcci902a_total 
         LET g_xccd3_d[l_ac].xcci902b = l_xcci902b_total 
         LET g_xccd3_d[l_ac].xcci902c = l_xcci902c_total 
         LET g_xccd3_d[l_ac].xcci902d = l_xcci902d_total 
         LET g_xccd3_d[l_ac].xcci902e = l_xcci902e_total 
         LET g_xccd3_d[l_ac].xcci902f = l_xcci902f_total 
         LET g_xccd3_d[l_ac].xcci902g = l_xcci902g_total 
         LET g_xccd3_d[l_ac].xcci902h = l_xcci902h_total 
         LET g_xccd3_d[l_ac].xcci902  = l_xcci902_total  
      END IF         
   END IF
 
#2015/04/02 ouhz add------begin----  
 IF axcq540_fill_chk(4) THEN
 LET g_sql = " SELECT UNIQUE sfaa068,xccd006,xcce007,xcce008,xcce009,xcbb005,xccd002,xcce101,xcce102,xcce201,",
                  "        xcce202,xcce301,xcce302,xcce303,xcce304,xcce307,xcce308,xcce901,xcce902 ",
                  "        ,xccd007 ",          
                  "   FROM axcq540_tmp04 ",
                  " WHERE xcccent= ? AND  xcccld=? AND xccc001=? AND xccc003=? AND xccc004=? AND xccc005=?" , 
                  "  ORDER BY sfaa068,xccd006 "

      LET g_sql_tmp= g_sql
      LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
      PREPARE axcq540_pb4 FROM g_sql
      DECLARE b_fill_cs4 CURSOR FOR axcq540_pb4
      
      LET g_cnt = l_ac
      LET l_ac = 1
      LET l_xcce101_sum1  = 0 #dorislai-20151021-add
      LET l_xcce102_sum1  = 0 
      LET l_xcce201_sum1  = 0 #dorislai-20151021-add
      LET l_xcce202_sum1  = 0  
      LET l_xcce301_sum1  = 0 #dorislai-20151021-add
      LET l_xcce302_sum1  = 0  
      LET l_xcce303_sum1  = 0 #dorislai-20151021-add
      LET l_xcce304_sum1  = 0  
      LET l_xcce307_sum1  = 0 #dorislai-20151021-add
      LET l_xcce308_sum1  = 0  
      LET l_xcce901_sum1  = 0 #dorislai-20151021-add
      LET l_xcce902_sum1  = 0 
      LET l_xcce101_sum2  = 0 #dorislai-20151021-add
      LET l_xcce102_sum2  = 0 
      LET l_xcce201_sum2  = 0 #dorislai-20151021-add
      LET l_xcce202_sum2  = 0  
      LET l_xcce301_sum2  = 0 #dorislai-20151021-add
      LET l_xcce302_sum2  = 0  
      LET l_xcce303_sum2  = 0 #dorislai-20151021-add
      LET l_xcce304_sum2  = 0  
      LET l_xcce307_sum2  = 0 #dorislai-20151021-add
      LET l_xcce308_sum2  = 0  
      LET l_xcce901_sum2  = 0 #dorislai-20151021-add
      LET l_xcce902_sum2  = 0  
      LET l_xcce101_total  = 0 #dorislai-20151021-add
      LET l_xcce102_total  = 0 
      LET l_xcce201_total  = 0 #dorislai-20151021-add
      LET l_xcce202_total  = 0  
      LET l_xcce301_total  = 0 #dorislai-20151021-add
      LET l_xcce302_total  = 0  
      LET l_xcce303_total  = 0 #dorislai-20151021-add
      LET l_xcce304_total  = 0  
      LET l_xcce307_total  = 0 #dorislai-20151021-add
      LET l_xcce308_total  = 0  
      LET l_xcce901_total  = 0 #dorislai-20151021-add
      LET l_xcce902_total  = 0  
      
      FOREACH b_fill_cs4 INTO g_xccd_d[l_ac].sfaa068,g_xccd_d[l_ac].xccd006,g_xccd_d[l_ac].xcce007,g_xccd_d[l_ac].xcce008,g_xccd_d[l_ac].xcce009,g_xccd_d[l_ac].xcbb005,
                             g_xccd_d[l_ac].xccd002,g_xccd_d[l_ac].xcce101,g_xccd_d[l_ac].xcce102,g_xccd_d[l_ac].xcce201,g_xccd_d[l_ac].xcce202,g_xccd_d[l_ac].xcce301,
                             g_xccd_d[l_ac].xcce302,g_xccd_d[l_ac].xcce303,g_xccd_d[l_ac].xcce304,g_xccd_d[l_ac].xcce307,g_xccd_d[l_ac].xcce308,g_xccd_d[l_ac].xcce901,g_xccd_d[l_ac].xcce902
                            ,g_xccd_d[l_ac].xccd007  
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "FOREACH:" 
            LET g_errparam.code   = SQLCA.sqlcode 
            LET g_errparam.popup  = TRUE 
            CALL cl_err()
 
            EXIT FOREACH
         END IF
         
         IF g_xccd_d[l_ac].sfaa068 IS NULL THEN LET g_xccd_d[l_ac].sfaa068 = ' ' END IF #170123-00012#1

         CALL s_desc_get_department_desc(g_xccd_d[l_ac].sfaa068) RETURNING g_xccd_d[l_ac].sfaa068_desc
         CALL s_desc_get_item_desc(g_xccd_d[l_ac].xcce007) RETURNING g_xccd_d[l_ac].xcce007_desc,g_xccd_d[l_ac].xcce007_desc_1
         CALL s_desc_get_unit_desc(g_xccd_d[l_ac].xcbb005) RETURNING g_xccd_d[l_ac].xcbb005_desc
         CALL s_desc_get_item_desc(g_xccd_d[l_ac].xccd007) RETURNING g_xccd_d[l_ac].xccd007_desc,g_xccd_d[l_ac].xccd007_desc_desc   #fengmy150304
#合计
         LET l_xcce101_total  = l_xcce101_total  + g_xccd_d[l_ac].xcce101 #dorislai-20151021-add
         LET l_xcce102_total  = l_xcce102_total  + g_xccd_d[l_ac].xcce102 
         LET l_xcce201_total  = l_xcce201_total  + g_xccd_d[l_ac].xcce201 #dorislai-20151021-add
         LET l_xcce202_total  = l_xcce202_total  + g_xccd_d[l_ac].xcce202 
         LET l_xcce301_total  = l_xcce301_total  + g_xccd_d[l_ac].xcce301 #dorislai-20151021-add
         LET l_xcce302_total  = l_xcce302_total  + g_xccd_d[l_ac].xcce302 
         LET l_xcce303_total  = l_xcce303_total  + g_xccd_d[l_ac].xcce303 #dorislai-20151021-add
         LET l_xcce304_total  = l_xcce304_total  + g_xccd_d[l_ac].xcce304 
         LET l_xcce307_total  = l_xcce307_total  + g_xccd_d[l_ac].xcce307 #dorislai-20151021-add
         LET l_xcce308_total  = l_xcce308_total  + g_xccd_d[l_ac].xcce308 
         LET l_xcce901_total  = l_xcce901_total  + g_xccd_d[l_ac].xcce901 #dorislai-20151021-add
         LET l_xcce902_total  = l_xcce902_total  + g_xccd_d[l_ac].xcce902 
#按单号小计
         LET l_xcce101_sum1  = l_xcce101_sum1  + g_xccd_d[l_ac].xcce101 #dorislai-20151021-add
         LET l_xcce102_sum1  = l_xcce102_sum1  + g_xccd_d[l_ac].xcce102 
         LET l_xcce201_sum1  = l_xcce201_sum1  + g_xccd_d[l_ac].xcce201 #dorislai-20151021-add
         LET l_xcce202_sum1  = l_xcce202_sum1  + g_xccd_d[l_ac].xcce202 
         LET l_xcce301_sum1  = l_xcce301_sum1  + g_xccd_d[l_ac].xcce301 #dorislai-20151021-add
         LET l_xcce302_sum1  = l_xcce302_sum1  + g_xccd_d[l_ac].xcce302 
         LET l_xcce303_sum1  = l_xcce303_sum1  + g_xccd_d[l_ac].xcce303 #dorislai-20151021-add
         LET l_xcce304_sum1  = l_xcce304_sum1  + g_xccd_d[l_ac].xcce304 
         LET l_xcce307_sum1  = l_xcce307_sum1  + g_xccd_d[l_ac].xcce307 #dorislai-20151021-add
         LET l_xcce308_sum1  = l_xcce308_sum1  + g_xccd_d[l_ac].xcce308 
         LET l_xcce901_sum1  = l_xcce901_sum1  + g_xccd_d[l_ac].xcce901 #dorislai-20151021-add
         LET l_xcce902_sum1  = l_xcce902_sum1  + g_xccd_d[l_ac].xcce902 
         IF l_ac > 1 THEN 
            IF g_xccd_d[l_ac].xccd006 != g_xccd_d[l_ac-1].xccd006 THEN
               #把当前行下移，并在当前行显示小计
               LET g_xccd_d[l_ac + 1].* = g_xccd_d[l_ac].*  
               INITIALIZE  g_xccd_d[l_ac].* TO NULL
               #LET g_xccd_d[l_ac].xccd006  = cl_getmsg("axc-00577",g_lang) #160201-00004#1 mark           
               LET g_xccd_d[l_ac].xccd006  = cl_getmsg("lib-00156",g_lang),"-",g_xccd_d[l_ac-1].xccd006 #160201-00004#1            
               LET g_xccd_d[l_ac].xcce101  = l_xcce101_sum1  - g_xccd_d[l_ac+1].xcce101 #dorislai-20151021-add
               LET g_xccd_d[l_ac].xcce102  = l_xcce102_sum1  - g_xccd_d[l_ac+1].xcce102
               LET g_xccd_d[l_ac].xcce201  = l_xcce201_sum1  - g_xccd_d[l_ac+1].xcce201 #dorislai-20151021-add
               LET g_xccd_d[l_ac].xcce202  = l_xcce202_sum1  - g_xccd_d[l_ac+1].xcce202 
               LET g_xccd_d[l_ac].xcce301  = l_xcce301_sum1  - g_xccd_d[l_ac+1].xcce301 #dorislai-20151021-add
               LET g_xccd_d[l_ac].xcce302  = l_xcce302_sum1  - g_xccd_d[l_ac+1].xcce302 
               LET g_xccd_d[l_ac].xcce303  = l_xcce303_sum1  - g_xccd_d[l_ac+1].xcce303 #dorislai-20151021-add
               LET g_xccd_d[l_ac].xcce304  = l_xcce304_sum1  - g_xccd_d[l_ac+1].xcce304 
               LET g_xccd_d[l_ac].xcce307  = l_xcce307_sum1  - g_xccd_d[l_ac+1].xcce307 #dorislai-20151021-add
               LET g_xccd_d[l_ac].xcce308  = l_xcce308_sum1  - g_xccd_d[l_ac+1].xcce308 
               LET g_xccd_d[l_ac].xcce901  = l_xcce901_sum1  - g_xccd_d[l_ac+1].xcce901 #dorislai-20151021-add
               LET g_xccd_d[l_ac].xcce902  = l_xcce902_sum1  - g_xccd_d[l_ac+1].xcce902 
               LET l_ac = l_ac + 1
               LET l_xcce101_sum1  = g_xccd_d[l_ac].xcce101 #dorislai-20151021-add
               LET l_xcce102_sum1  = g_xccd_d[l_ac].xcce102
               LET l_xcce201_sum1  = g_xccd_d[l_ac].xcce201 #dorislai-20151021-add
               LET l_xcce202_sum1  = g_xccd_d[l_ac].xcce202 
               LET l_xcce301_sum1  = g_xccd_d[l_ac].xcce301 #dorislai-20151021-add
               LET l_xcce302_sum1  = g_xccd_d[l_ac].xcce302
               LET l_xcce303_sum1  = g_xccd_d[l_ac].xcce303 #dorislai-20151021-add
               LET l_xcce304_sum1  = g_xccd_d[l_ac].xcce304 
               LET l_xcce307_sum1  = g_xccd_d[l_ac].xcce307 #dorislai-20151021-add
               LET l_xcce308_sum1  = g_xccd_d[l_ac].xcce308 
               LET l_xcce901_sum1  = g_xccd_d[l_ac].xcce901 #dorislai-20151021-add
               LET l_xcce902_sum1  = g_xccd_d[l_ac].xcce902 
            END IF               
         END IF         
#按组织小计
         LET l_xcce101_sum2  = l_xcce101_sum2  + g_xccd_d[l_ac].xcce101 #dorislai-20151021-add
         LET l_xcce102_sum2  = l_xcce102_sum2  + g_xccd_d[l_ac].xcce102 
         LET l_xcce201_sum2  = l_xcce201_sum2  + g_xccd_d[l_ac].xcce201 #dorislai-20151021-add
         LET l_xcce202_sum2  = l_xcce202_sum2  + g_xccd_d[l_ac].xcce202 
         LET l_xcce301_sum2  = l_xcce301_sum2  + g_xccd_d[l_ac].xcce301 #dorislai-20151021-add
         LET l_xcce302_sum2  = l_xcce302_sum2  + g_xccd_d[l_ac].xcce302 
         LET l_xcce303_sum2  = l_xcce303_sum2  + g_xccd_d[l_ac].xcce303 #dorislai-20151021-add
         LET l_xcce304_sum2  = l_xcce304_sum2  + g_xccd_d[l_ac].xcce304 
         LET l_xcce307_sum2  = l_xcce307_sum2  + g_xccd_d[l_ac].xcce307 #dorislai-20151021-add
         LET l_xcce308_sum2  = l_xcce308_sum2  + g_xccd_d[l_ac].xcce308 
         LET l_xcce901_sum2  = l_xcce901_sum2  + g_xccd_d[l_ac].xcce901 #dorislai-20151021-add
         LET l_xcce902_sum2  = l_xcce902_sum2  + g_xccd_d[l_ac].xcce902 
         IF l_ac > 2 THEN
            #IF g_xccd_d[l_ac].sfaa068 != g_xccd_d[l_ac-2].sfaa068 THEN #170123-00012#1 mark
            IF g_xccd_d[l_ac].sfaa068 != g_xccd_d[l_ac-2].sfaa068 AND g_xccd_d[l_ac].xccd006 != g_xccd_d[l_ac-1].xccd006 THEN #170123-00012#1 mark
               #把当前行下移，并在当前行显示小计
               LET g_xccd_d[l_ac + 1].* = g_xccd_d[l_ac].*  
               INITIALIZE  g_xccd_d[l_ac].* TO NULL
               #LET g_xccd_d[l_ac].sfaa068  = cl_getmsg("axc-00578",g_lang) #160201-00004#1           
               #LET g_xccd_d[l_ac].sfaa068  = cl_getmsg("lib-00156",g_lang),"-",g_xccd_d[l_ac-2].sfaa068  #160201-00004#1   #170123-00012#1 mark         
               LET g_xccd_d[l_ac].sfaa068  = cl_getmsg("aps-00134",g_lang),"-",g_xccd_d[l_ac-2].sfaa068   #170123-00012#1 
               LET g_xccd_d[l_ac].xcce101  = l_xcce101_sum2  - g_xccd_d[l_ac+1].xcce101 #dorislai-20151021-add
               LET g_xccd_d[l_ac].xcce102  = l_xcce102_sum2  - g_xccd_d[l_ac+1].xcce102
               LET g_xccd_d[l_ac].xcce201  = l_xcce201_sum2  - g_xccd_d[l_ac+1].xcce201 #dorislai-20151021-add
               LET g_xccd_d[l_ac].xcce202  = l_xcce202_sum2  - g_xccd_d[l_ac+1].xcce202 
               LET g_xccd_d[l_ac].xcce301  = l_xcce301_sum2  - g_xccd_d[l_ac+1].xcce301 #dorislai-20151021-add
               LET g_xccd_d[l_ac].xcce302  = l_xcce302_sum2  - g_xccd_d[l_ac+1].xcce302 
               LET g_xccd_d[l_ac].xcce303  = l_xcce303_sum2  - g_xccd_d[l_ac+1].xcce303 #dorislai-20151021-add
               LET g_xccd_d[l_ac].xcce304  = l_xcce304_sum2  - g_xccd_d[l_ac+1].xcce304 
               LET g_xccd_d[l_ac].xcce307  = l_xcce307_sum2  - g_xccd_d[l_ac+1].xcce307 #dorislai-20151021-add
               LET g_xccd_d[l_ac].xcce308  = l_xcce308_sum2  - g_xccd_d[l_ac+1].xcce308 
               LET g_xccd_d[l_ac].xcce901  = l_xcce901_sum2  - g_xccd_d[l_ac+1].xcce901 #dorislai-20151021-add
               LET g_xccd_d[l_ac].xcce902  = l_xcce902_sum2  - g_xccd_d[l_ac+1].xcce902 
               LET l_ac = l_ac + 1
               LET l_xcce101_sum2  = g_xccd_d[l_ac].xcce101 #dorislai-20151021-add
               LET l_xcce102_sum2  = g_xccd_d[l_ac].xcce102 
               LET l_xcce201_sum2  = g_xccd_d[l_ac].xcce201 #dorislai-20151021-add
               LET l_xcce202_sum2  = g_xccd_d[l_ac].xcce202 
               LET l_xcce301_sum2  = g_xccd_d[l_ac].xcce301 #dorislai-20151021-add
               LET l_xcce302_sum2  = g_xccd_d[l_ac].xcce302 
               LET l_xcce303_sum2  = g_xccd_d[l_ac].xcce303 #dorislai-20151021-add
               LET l_xcce304_sum2  = g_xccd_d[l_ac].xcce304 
               LET l_xcce307_sum2  = g_xccd_d[l_ac].xcce307 #dorislai-20151021-add
               LET l_xcce308_sum2  = g_xccd_d[l_ac].xcce308 
               LET l_xcce901_sum2  = g_xccd_d[l_ac].xcce901 #dorislai-20151021-add
               LET l_xcce902_sum2  = g_xccd_d[l_ac].xcce902
            END IF               
         END IF           
         
         IF l_ac > g_max_rec THEN
            IF g_error_show = 1 THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = l_ac
               LET g_errparam.code   = 9035 
               LET g_errparam.popup  = TRUE 
               CALL cl_err()
            END IF
            EXIT FOREACH
         END IF
         
         LET l_ac = l_ac + 1
      END FOREACH
      
#最后一组小计，还有合计
#按在制单号小计
      IF l_ac > 1 THEN 
         #LET g_xccd_d[l_ac].xccd006   = cl_getmsg("axc-00577",g_lang) #160201-00004#1 mark
         LET g_xccd_d[l_ac].xccd006   = cl_getmsg("lib-00156",g_lang),"-",g_xccd_d[l_ac-1].xccd006  #160201-00004#1 
         LET g_xccd_d[l_ac].xcce101  = l_xcce101_sum1 #dorislai-20151021-add
         LET g_xccd_d[l_ac].xcce102  = l_xcce102_sum1 
         LET g_xccd_d[l_ac].xcce201  = l_xcce201_sum1 #dorislai-20151021-add
         LET g_xccd_d[l_ac].xcce202  = l_xcce202_sum1   
         LET g_xccd_d[l_ac].xcce301  = l_xcce301_sum1 #dorislai-20151021-add
         LET g_xccd_d[l_ac].xcce302  = l_xcce302_sum1   
         LET g_xccd_d[l_ac].xcce303  = l_xcce303_sum1 #dorislai-20151021-add
         LET g_xccd_d[l_ac].xcce304  = l_xcce304_sum1   
         LET g_xccd_d[l_ac].xcce307  = l_xcce307_sum1 #dorislai-20151021-add
         LET g_xccd_d[l_ac].xcce308  = l_xcce308_sum1   
         LET g_xccd_d[l_ac].xcce901  = l_xcce901_sum1 #dorislai-20151021-add
         LET g_xccd_d[l_ac].xcce902  = l_xcce902_sum1  
         LET l_ac = l_ac+1  
#按组织小计 
         #LET g_xccd_d[l_ac].sfaa068  = cl_getmsg("axc-00578",g_lang) #160201-00004#1
         #LET g_xccd_d[l_ac].sfaa068  = cl_getmsg("lib-00156",g_lang),"-",g_xccd_d[l_ac-2].sfaa068  #160201-00004#1 #170123-00012#1 mark
         LET g_xccd_d[l_ac].sfaa068  = cl_getmsg("aps-00134",g_lang),"-",g_xccd_d[l_ac-2].sfaa068   #170123-00012#1 
         LET g_xccd_d[l_ac].xcce101  = l_xcce101_sum2 #dorislai-20151021-add
         LET g_xccd_d[l_ac].xcce102  = l_xcce102_sum2 
         LET g_xccd_d[l_ac].xcce201  = l_xcce201_sum2 #dorislai-20151021-add
         LET g_xccd_d[l_ac].xcce202  = l_xcce202_sum2   
         LET g_xccd_d[l_ac].xcce301  = l_xcce301_sum2 #dorislai-20151021-add
         LET g_xccd_d[l_ac].xcce302  = l_xcce302_sum2   
         LET g_xccd_d[l_ac].xcce303  = l_xcce303_sum2 #dorislai-20151021-add
         LET g_xccd_d[l_ac].xcce304  = l_xcce304_sum2   
         LET g_xccd_d[l_ac].xcce307  = l_xcce307_sum2 #dorislai-20151021-add
         LET g_xccd_d[l_ac].xcce308  = l_xcce308_sum2   
         LET g_xccd_d[l_ac].xcce901  = l_xcce901_sum2 #dorislai-20151021-add
         LET g_xccd_d[l_ac].xcce902  = l_xcce902_sum2  
         LET l_ac = l_ac + 1
#合计 
         LET g_xccd_d[l_ac].sfaa068  = cl_getmsg("lib-00133",g_lang)
         LET g_xccd_d[l_ac].xcce101  = l_xcce101_total  #dorislai-20151021-add
         LET g_xccd_d[l_ac].xcce102  = l_xcce102_total  
         LET g_xccd_d[l_ac].xcce201  = l_xcce201_total  #dorislai-20151021-add
         LET g_xccd_d[l_ac].xcce202  = l_xcce202_total
         LET g_xccd_d[l_ac].xcce301  = l_xcce301_total  #dorislai-20151021-add
         LET g_xccd_d[l_ac].xcce302  = l_xcce302_total   
         LET g_xccd_d[l_ac].xcce303  = l_xcce303_total  #dorislai-20151021-add
         LET g_xccd_d[l_ac].xcce304  = l_xcce304_total   
         LET g_xccd_d[l_ac].xcce307  = l_xcce307_total  #dorislai-20151021-add
         LET g_xccd_d[l_ac].xcce308  = l_xcce308_total   
         LET g_xccd_d[l_ac].xcce901  = l_xcce901_total  #dorislai-20151021-add
         LET g_xccd_d[l_ac].xcce902  = l_xcce902_total  
      END IF         
   END IF
#2015/3/27 ouhz add------end----  

   
   #add-point:browser_fill段其他table處理
   #end add-point
   
#   CALL g_xccd_d.deleteElement(g_xccd_d.getLength())
#   CALL g_xccd2_d.deleteElement(g_xccd2_d.getLength())
#   CALL g_xccd3_d.deleteElement(g_xccd3_d.getLength())
 
   
 
   LET l_ac = g_cnt
   LET g_cnt = 0  
   
   FREE axcq540_pb
   FREE axcq540_pb2
 
   FREE axcq540_pb3    
   FREE axcq540_pb4  #2015/3/27 ouhz add---
   CALL axcq540_drop_tmp_table()   
      #end add-point
#     
#     LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
#     PREPARE axcq540_pb FROM g_sql
#     DECLARE b_fill_cs CURSOR FOR axcq540_pb
#     
#     LET g_cnt = l_ac
#     LET l_ac = 1
#     
#     OPEN b_fill_cs USING g_enterprise,g_xccd_m.xccdld,g_xccd_m.xccd001,g_xccd_m.xccd003,g_xccd_m.xccd004,g_xccd_m.xccd005
#                                              
#     FOREACH b_fill_cs INTO g_xccd_d[l_ac].xccd006,g_xccd_d[l_ac].xccd002
#        IF SQLCA.sqlcode THEN
#           INITIALIZE g_errparam TO NULL 
#           LET g_errparam.extend = "FOREACH:" 
#           LET g_errparam.code   = SQLCA.sqlcode 
#           LET g_errparam.popup  = TRUE 
#           CALL cl_err()
#
#           EXIT FOREACH
#        END IF
#       
#        #add-point:b_fill段資料填充
#
#        #end add-point
#     
#        IF l_ac > g_max_rec THEN
#           IF g_error_show = 1 THEN
#              INITIALIZE g_errparam TO NULL 
#              LET g_errparam.extend = l_ac
#              LET g_errparam.code   = 9035 
#              LET g_errparam.popup  = TRUE 
#              CALL cl_err()
#           END IF
#           EXIT FOREACH
#        END IF
#        
#        LET l_ac = l_ac + 1
#     END FOREACH
#     LET g_error_show = 0
#  
#  END IF
#  
#  #判斷是否填充
#  IF axcq540_fill_chk(2) THEN
#     LET g_sql = "SELECT  UNIQUE xcce006,xcce007,xcce008,xcce009,xcce002,xcce101,xcce102a,xcce102b, 
#         xcce102c,xcce102d,xcce102e,xcce102f,xcce102g,xcce102h,xcce102,xcce201,xcce202a,xcce202b,xcce202c, 
#         xcce202d,xcce202e,xcce202f,xcce202g,xcce202h,xcce202,xcce301,xcce302a,xcce302b,xcce302c,xcce302d, 
#         xcce302e,xcce302f,xcce302g,xcce302h,xcce302,xcce303,xcce304a,xcce304b,xcce304c,xcce304d,xcce304e, 
#         xcce304f,xcce304g,xcce304h,xcce304,xcce307,xcce308a,xcce308b,xcce308c,xcce308d,xcce308e,xcce308f, 
#         xcce308g,xcce308h,xcce308,xcce901,xcce902a,xcce902b,xcce902c,xcce902d,xcce902e,xcce902f,xcce902g, 
#         xcce902h,xcce902  FROM xcce_t",   
#                 " INNER JOIN xccd_t ON xccdld = xcceld ",
#                 " AND xccd001 = xcce001 ",
#                 " AND xccd003 = xcce003 ",
#                 " AND xccd004 = xcce004 ",
#                 " AND xccd005 = xcce005 ",
#
#                 "",
#                 
#                 
#                 " WHERE xcceent=? AND xcceld=? AND xcce001=? AND xcce003=? AND xcce004=? AND xcce005=?"   
#     LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
#     #add-point:b_fill段sql_before
#
#     #end add-point
#     IF NOT cl_null(g_wc2_table2) THEN
#        LET g_sql = g_sql CLIPPED," AND ",g_wc2_table2 CLIPPED
#     END IF
#     
#     #子單身的WC
#     
#     
#     LET g_sql = g_sql, " ORDER BY xcce_t.xcce002,xcce_t.xcce006,xcce_t.xcce007,xcce_t.xcce008,xcce_t.xcce009"
#     
#     #add-point:單身填充控制
#
#     #end add-point
#     
#     LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
#     PREPARE axcq540_pb2 FROM g_sql
#     DECLARE b_fill_cs2 CURSOR FOR axcq540_pb2
#     
#     LET l_ac = 1
#     
#     OPEN b_fill_cs2 USING g_enterprise,g_xccd_m.xccdld,g_xccd_m.xccd001,g_xccd_m.xccd003,g_xccd_m.xccd004,g_xccd_m.xccd005
#                                              
#     FOREACH b_fill_cs2 INTO g_xccd2_d[l_ac].xcce006,g_xccd2_d[l_ac].xcce007,g_xccd2_d[l_ac].xcce008, 
#         g_xccd2_d[l_ac].xcce009,g_xccd2_d[l_ac].xcce002,g_xccd2_d[l_ac].xcce101,g_xccd2_d[l_ac].xcce102a, 
#         g_xccd2_d[l_ac].xcce102b,g_xccd2_d[l_ac].xcce102c,g_xccd2_d[l_ac].xcce102d,g_xccd2_d[l_ac].xcce102e, 
#         g_xccd2_d[l_ac].xcce102f,g_xccd2_d[l_ac].xcce102g,g_xccd2_d[l_ac].xcce102h,g_xccd2_d[l_ac].xcce102, 
#         g_xccd2_d[l_ac].xcce201,g_xccd2_d[l_ac].xcce202a,g_xccd2_d[l_ac].xcce202b,g_xccd2_d[l_ac].xcce202c, 
#         g_xccd2_d[l_ac].xcce202d,g_xccd2_d[l_ac].xcce202e,g_xccd2_d[l_ac].xcce202f,g_xccd2_d[l_ac].xcce202g, 
#         g_xccd2_d[l_ac].xcce202h,g_xccd2_d[l_ac].xcce202,g_xccd2_d[l_ac].xcce301,g_xccd2_d[l_ac].xcce302a, 
#         g_xccd2_d[l_ac].xcce302b,g_xccd2_d[l_ac].xcce302c,g_xccd2_d[l_ac].xcce302d,g_xccd2_d[l_ac].xcce302e, 
#         g_xccd2_d[l_ac].xcce302f,g_xccd2_d[l_ac].xcce302g,g_xccd2_d[l_ac].xcce302h,g_xccd2_d[l_ac].xcce302, 
#         g_xccd2_d[l_ac].xcce303,g_xccd2_d[l_ac].xcce304a,g_xccd2_d[l_ac].xcce304b,g_xccd2_d[l_ac].xcce304c, 
#         g_xccd2_d[l_ac].xcce304d,g_xccd2_d[l_ac].xcce304e,g_xccd2_d[l_ac].xcce304f,g_xccd2_d[l_ac].xcce304g, 
#         g_xccd2_d[l_ac].xcce304h,g_xccd2_d[l_ac].xcce304,g_xccd2_d[l_ac].xcce307,g_xccd2_d[l_ac].xcce308a, 
#         g_xccd2_d[l_ac].xcce308b,g_xccd2_d[l_ac].xcce308c,g_xccd2_d[l_ac].xcce308d,g_xccd2_d[l_ac].xcce308e, 
#         g_xccd2_d[l_ac].xcce308f,g_xccd2_d[l_ac].xcce308g,g_xccd2_d[l_ac].xcce308h,g_xccd2_d[l_ac].xcce308, 
#         g_xccd2_d[l_ac].xcce901,g_xccd2_d[l_ac].xcce902a,g_xccd2_d[l_ac].xcce902b,g_xccd2_d[l_ac].xcce902c, 
#         g_xccd2_d[l_ac].xcce902d,g_xccd2_d[l_ac].xcce902e,g_xccd2_d[l_ac].xcce902f,g_xccd2_d[l_ac].xcce902g, 
#         g_xccd2_d[l_ac].xcce902h,g_xccd2_d[l_ac].xcce902
#        IF SQLCA.sqlcode THEN
#           INITIALIZE g_errparam TO NULL 
#           LET g_errparam.extend = "FOREACH:" 
#           LET g_errparam.code   = SQLCA.sqlcode 
#           LET g_errparam.popup  = TRUE 
#           CALL cl_err()
#
#           EXIT FOREACH
#        END IF
#       
#        #add-point:b_fill段資料填充
#
#        #end add-point
#     
#        LET l_ac = l_ac + 1
#        IF l_ac > g_max_rec THEN
#           INITIALIZE g_errparam TO NULL 
#           LET g_errparam.extend = l_ac
#           LET g_errparam.code   = 9035 
#           LET g_errparam.popup  = TRUE 
#           CALL cl_err()
#           EXIT FOREACH
#        END IF
#        
#     END FOREACH
#  END IF
#
#  #判斷是否填充
#  IF axcq540_fill_chk(3) THEN
#     LET g_sql = "SELECT  UNIQUE xcci006,xcci007,xcci008,xcci009,xcci002,xcci101,xcci102a,xcci102b, 
#         xcci102c,xcci102d,xcci102e,xcci102f,xcci102g,xcci102h,xcci102,xcci201,xcci202a,xcci202b,xcci202c, 
#         xcci202d,xcci202e,xcci202f,xcci202g,xcci202h,xcci202,xcci301,xcci302a,xcci302b,xcci302c,xcci302d, 
#         xcci302e,xcci302f,xcci302g,xcci302h,xcci302,xcci303,xcci304a,xcci304b,xcci304c,xcci304d,xcci304e, 
#         xcci304f,xcci304g,xcci304h,xcci304,xcci901,xcci902a,xcci902b,xcci902c,xcci902d,xcci902e,xcci902f, 
#         xcci902g,xcci902h,xcci902 ,t4.imaal003 FROM xcci_t",   
#                 " INNER JOIN xccd_t ON xccdld = xccild ",
#                 " AND xccd001 = xcci001 ",
#                 " AND xccd003 = xcci003 ",
#                 " AND xccd004 = xcci004 ",
#                 " AND xccd005 = xcci005 ",
#
#                 "",
#                 
#                                " LEFT JOIN imaal_t t4 ON t4.imaalent='"||g_enterprise||"' AND t4.imaal001=xcci007 AND t4.imaal002='"||g_dlang||"' ",
#
#                 " WHERE xccient=? AND xccild=? AND xcci001=? AND xcci003=? AND xcci004=? AND xcci005=?"   
#     LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
#     #add-point:b_fill段sql_before
#
#     #end add-point
#     IF NOT cl_null(g_wc2_table3) THEN
#        LET g_sql = g_sql CLIPPED," AND ",g_wc2_table3 CLIPPED
#     END IF
#     
#     #子單身的WC
#     
#     
#     LET g_sql = g_sql, " ORDER BY xcci_t.xcci002,xcci_t.xcci006,xcci_t.xcci007,xcci_t.xcci008,xcci_t.xcci009"
#     
#     #add-point:單身填充控制
#
#     #end add-point
#     
#     LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
#     PREPARE axcq540_pb3 FROM g_sql
#     DECLARE b_fill_cs3 CURSOR FOR axcq540_pb3
#     
#     LET l_ac = 1
#     
#     OPEN b_fill_cs3 USING g_enterprise,g_xccd_m.xccdld,g_xccd_m.xccd001,g_xccd_m.xccd003,g_xccd_m.xccd004,g_xccd_m.xccd005
#                                              
#     FOREACH b_fill_cs3 INTO g_xccd3_d[l_ac].xcci006,g_xccd3_d[l_ac].xcci007,g_xccd3_d[l_ac].xcci008, 
#         g_xccd3_d[l_ac].xcci009,g_xccd3_d[l_ac].xcci002,g_xccd3_d[l_ac].xcci101,g_xccd3_d[l_ac].xcci102a, 
#         g_xccd3_d[l_ac].xcci102b,g_xccd3_d[l_ac].xcci102c,g_xccd3_d[l_ac].xcci102d,g_xccd3_d[l_ac].xcci102e, 
#         g_xccd3_d[l_ac].xcci102f,g_xccd3_d[l_ac].xcci102g,g_xccd3_d[l_ac].xcci102h,g_xccd3_d[l_ac].xcci102, 
#         g_xccd3_d[l_ac].xcci201,g_xccd3_d[l_ac].xcci202a,g_xccd3_d[l_ac].xcci202b,g_xccd3_d[l_ac].xcci202c, 
#         g_xccd3_d[l_ac].xcci202d,g_xccd3_d[l_ac].xcci202e,g_xccd3_d[l_ac].xcci202f,g_xccd3_d[l_ac].xcci202g, 
#         g_xccd3_d[l_ac].xcci202h,g_xccd3_d[l_ac].xcci202,g_xccd3_d[l_ac].xcci301,g_xccd3_d[l_ac].xcci302a, 
#         g_xccd3_d[l_ac].xcci302b,g_xccd3_d[l_ac].xcci302c,g_xccd3_d[l_ac].xcci302d,g_xccd3_d[l_ac].xcci302e, 
#         g_xccd3_d[l_ac].xcci302f,g_xccd3_d[l_ac].xcci302g,g_xccd3_d[l_ac].xcci302h,g_xccd3_d[l_ac].xcci302, 
#         g_xccd3_d[l_ac].xcci303,g_xccd3_d[l_ac].xcci304a,g_xccd3_d[l_ac].xcci304b,g_xccd3_d[l_ac].xcci304c, 
#         g_xccd3_d[l_ac].xcci304d,g_xccd3_d[l_ac].xcci304e,g_xccd3_d[l_ac].xcci304f,g_xccd3_d[l_ac].xcci304g, 
#         g_xccd3_d[l_ac].xcci304h,g_xccd3_d[l_ac].xcci304,g_xccd3_d[l_ac].xcci901,g_xccd3_d[l_ac].xcci902a, 
#         g_xccd3_d[l_ac].xcci902b,g_xccd3_d[l_ac].xcci902c,g_xccd3_d[l_ac].xcci902d,g_xccd3_d[l_ac].xcci902e, 
#         g_xccd3_d[l_ac].xcci902f,g_xccd3_d[l_ac].xcci902g,g_xccd3_d[l_ac].xcci902h,g_xccd3_d[l_ac].xcci902, 
#         g_xccd3_d[l_ac].xcci007_desc
#        IF SQLCA.sqlcode THEN
#           INITIALIZE g_errparam TO NULL 
#           LET g_errparam.extend = "FOREACH:" 
#           LET g_errparam.code   = SQLCA.sqlcode 
#           LET g_errparam.popup  = TRUE 
#           CALL cl_err()
#
#           EXIT FOREACH
#        END IF
#       
#        #add-point:b_fill段資料填充
#
#        #end add-point
#     
#        LET l_ac = l_ac + 1
#        IF l_ac > g_max_rec THEN
#           INITIALIZE g_errparam TO NULL 
#           LET g_errparam.extend = l_ac
#           LET g_errparam.code   = 9035 
#           LET g_errparam.popup  = TRUE 
#           CALL cl_err()
#           EXIT FOREACH
#        END IF
#        
#     END FOREACH
#  END IF
#
#
#  
#  #add-point:browser_fill段其他table處理
#
#  #end add-point
#  
#  CALL g_xccd_d.deleteElement(g_xccd_d.getLength())
#  CALL g_xccd2_d.deleteElement(g_xccd2_d.getLength())
#  CALL g_xccd3_d.deleteElement(g_xccd3_d.getLength())
#
#  
#
#  LET l_ac = g_cnt
#  LET g_cnt = 0  
#  
#  FREE axcq540_pb
#  FREE axcq540_pb2
#
#  FREE axcq540_pb3
 
 
   
END FUNCTION
 
{</section>}
 
{<section id="axcq540.delete_b" >}
#+ 刪除單身後其他table連動
PRIVATE FUNCTION axcq540_delete_b(ps_table,ps_keys_bak,ps_page)
   DEFINE ps_table    STRING
   DEFINE ps_page     STRING
   DEFINE ps_keys_bak DYNAMIC ARRAY OF VARCHAR(500)
   DEFINE ls_group    STRING
   #add-point:delete_b段define
   
   #end add-point     
 
   #判斷是否是同一群組的table
   LET ls_group = "'1',"
   IF ls_group.getIndexOf(ps_page,1) > 0 THEN
      #add-point:delete_b段刪除前
      
      #end add-point    
      DELETE FROM xccd_t
       WHERE xccdent = g_enterprise AND
         xccdld = ps_keys_bak[1] AND xccd001 = ps_keys_bak[2] AND xccd003 = ps_keys_bak[3] AND xccd004 = ps_keys_bak[4] AND xccd005 = ps_keys_bak[5]
      #add-point:delete_b段刪除中
      
      #end add-point    
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "" 
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = FALSE 
         CALL cl_err()
 
      END IF
      #add-point:delete_b段刪除後
      
      #end add-point   
   END IF
   
   LET ls_group = "'2',"
   #判斷是否是同一群組的table
   IF ls_group.getIndexOf(ps_page,1) > 0 THEN
      #add-point:delete_b段刪除前
      
      #end add-point    
      DELETE FROM xcce_t
       WHERE xcceent = g_enterprise AND
         xcceld = ps_keys_bak[1] AND xcce001 = ps_keys_bak[2] AND xcce003 = ps_keys_bak[3] AND xcce004 = ps_keys_bak[4] AND xcce005 = ps_keys_bak[5] AND xcce002 = ps_keys_bak[6] AND xcce006 = ps_keys_bak[7] AND xcce007 = ps_keys_bak[8] AND xcce008 = ps_keys_bak[9] AND xcce009 = ps_keys_bak[10]
      #add-point:delete_b段刪除中
      
      #end add-point    
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "xcce_t" 
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = FALSE 
         CALL cl_err()
 
      END IF
      #add-point:delete_b段刪除後
      
      #end add-point    
   END IF
 
   LET ls_group = "'3',"
   #判斷是否是同一群組的table
   IF ls_group.getIndexOf(ps_page,1) > 0 THEN
      #add-point:delete_b段刪除前
      
      #end add-point    
      DELETE FROM xcci_t
       WHERE xccient = g_enterprise AND
         xccild = ps_keys_bak[1] AND xcci001 = ps_keys_bak[2] AND xcci003 = ps_keys_bak[3] AND xcci004 = ps_keys_bak[4] AND xcci005 = ps_keys_bak[5] AND xcci002 = ps_keys_bak[6] AND xcci006 = ps_keys_bak[7] AND xcci007 = ps_keys_bak[8] AND xcci008 = ps_keys_bak[9] AND xcci009 = ps_keys_bak[10]
      #add-point:delete_b段刪除中
      
      #end add-point    
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "xcci_t" 
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = FALSE 
         CALL cl_err()
 
      END IF
      #add-point:delete_b段刪除後
      
      #end add-point    
   END IF
 
 
   
 
   
   #add-point:delete_b段other
   
   #end add-point  
   
END FUNCTION
 
{</section>}
 
{<section id="axcq540.insert_b" >}
#+ 新增單身後其他table連動
PRIVATE FUNCTION axcq540_insert_b(ps_table,ps_keys,ps_page)
   DEFINE ps_table    STRING
   DEFINE ps_page     STRING
   DEFINE ps_keys     DYNAMIC ARRAY OF VARCHAR(500)
   DEFINE ls_group    STRING
   DEFINE ls_page     STRING
   #add-point:insert_b段define

   #end add-point     
   
#   #判斷是否是同一群組的table
#   LET ls_group = "'1',"
#   IF ls_group.getIndexOf(ps_page,1) > 0 THEN
#      #add-point:insert_b段資料新增前

#      #end add-point 
#      INSERT INTO xccd_t
#                  (xccdent,
#                   ,
#                   xccdld,xccd001,xccd003,xccd004,xccd005
#                   ,xccd006,xccd002) 
#            VALUES(g_enterprise,
#                   ps_keys[1],ps_keys[2],ps_keys[3],ps_keys[4],ps_keys[5]
#                   ,g_xccd_d[g_detail_idx].xccd006,g_xccd_d[g_detail_idx].xccd002)
#      #add-point:insert_b段資料新增中

#      #end add-point 
#      IF SQLCA.sqlcode THEN
#         INITIALIZE g_errparam TO NULL 
#         LET g_errparam.extend = "xccd_t" 
#         LET g_errparam.code   = SQLCA.sqlcode 
#         LET g_errparam.popup  = FALSE 
#         CALL cl_err()
# 
#      END IF
#      #add-point:insert_b段資料新增後

#      #end add-point 
#   END IF
#   
#   LET ls_group = "'2',"
#   #判斷是否是同一群組的table
#   IF ls_group.getIndexOf(ps_page,1) > 0 THEN
#      #add-point:insert_b段資料新增前

#      #end add-point 
#      INSERT INTO xcce_t
#                  (xcceent,
#                   xcceld,xcce001,xcce003,xcce004,xcce005,
#                   xcce002,xcce006,xcce007,xcce008,xcce009
#                   ,xcce101,xcce102a,xcce102b,xcce102c,xcce102d,xcce102e,xcce102f,xcce102g,xcce102h,xcce102,xcce201,xcce202a,xcce202b,xcce202c,xcce202d,xcce202e,xcce202f,xcce202g,xcce202h,xcce202,xcce301,xcce302a,xcce302b,xcce302c,xcce302d,xcce302e,xcce302f,xcce302g,xcce302h,xcce302,xcce303,xcce304a,xcce304b,xcce304c,xcce304d,xcce304e,xcce304f,xcce304g,xcce304h,xcce304,xcce307,xcce308a,xcce308b,xcce308c,xcce308d,xcce308e,xcce308f,xcce308g,xcce308h,xcce308,xcce901,xcce902a,xcce902b,xcce902c,xcce902d,xcce902e,xcce902f,xcce902g,xcce902h,xcce902) 
#            VALUES(g_enterprise,
#                   ps_keys[1],ps_keys[2],ps_keys[3],ps_keys[4],ps_keys[5],ps_keys[6],ps_keys[7],ps_keys[8],ps_keys[9],ps_keys[10]
#                   ,g_xccd2_d[g_detail_idx].xcce101,g_xccd2_d[g_detail_idx].xcce102a,g_xccd2_d[g_detail_idx].xcce102b, 
#                       g_xccd2_d[g_detail_idx].xcce102c,g_xccd2_d[g_detail_idx].xcce102d,g_xccd2_d[g_detail_idx].xcce102e, 
#                       g_xccd2_d[g_detail_idx].xcce102f,g_xccd2_d[g_detail_idx].xcce102g,g_xccd2_d[g_detail_idx].xcce102h, 
#                       g_xccd2_d[g_detail_idx].xcce102,g_xccd2_d[g_detail_idx].xcce201,g_xccd2_d[g_detail_idx].xcce202a, 
#                       g_xccd2_d[g_detail_idx].xcce202b,g_xccd2_d[g_detail_idx].xcce202c,g_xccd2_d[g_detail_idx].xcce202d, 
#                       g_xccd2_d[g_detail_idx].xcce202e,g_xccd2_d[g_detail_idx].xcce202f,g_xccd2_d[g_detail_idx].xcce202g, 
#                       g_xccd2_d[g_detail_idx].xcce202h,g_xccd2_d[g_detail_idx].xcce202,g_xccd2_d[g_detail_idx].xcce301, 
#                       g_xccd2_d[g_detail_idx].xcce302a,g_xccd2_d[g_detail_idx].xcce302b,g_xccd2_d[g_detail_idx].xcce302c, 
#                       g_xccd2_d[g_detail_idx].xcce302d,g_xccd2_d[g_detail_idx].xcce302e,g_xccd2_d[g_detail_idx].xcce302f, 
#                       g_xccd2_d[g_detail_idx].xcce302g,g_xccd2_d[g_detail_idx].xcce302h,g_xccd2_d[g_detail_idx].xcce302, 
#                       g_xccd2_d[g_detail_idx].xcce303,g_xccd2_d[g_detail_idx].xcce304a,g_xccd2_d[g_detail_idx].xcce304b, 
#                       g_xccd2_d[g_detail_idx].xcce304c,g_xccd2_d[g_detail_idx].xcce304d,g_xccd2_d[g_detail_idx].xcce304e, 
#                       g_xccd2_d[g_detail_idx].xcce304f,g_xccd2_d[g_detail_idx].xcce304g,g_xccd2_d[g_detail_idx].xcce304h, 
#                       g_xccd2_d[g_detail_idx].xcce304,g_xccd2_d[g_detail_idx].xcce307,g_xccd2_d[g_detail_idx].xcce308a, 
#                       g_xccd2_d[g_detail_idx].xcce308b,g_xccd2_d[g_detail_idx].xcce308c,g_xccd2_d[g_detail_idx].xcce308d, 
#                       g_xccd2_d[g_detail_idx].xcce308e,g_xccd2_d[g_detail_idx].xcce308f,g_xccd2_d[g_detail_idx].xcce308g, 
#                       g_xccd2_d[g_detail_idx].xcce308h,g_xccd2_d[g_detail_idx].xcce308,g_xccd2_d[g_detail_idx].xcce901, 
#                       g_xccd2_d[g_detail_idx].xcce902a,g_xccd2_d[g_detail_idx].xcce902b,g_xccd2_d[g_detail_idx].xcce902c, 
#                       g_xccd2_d[g_detail_idx].xcce902d,g_xccd2_d[g_detail_idx].xcce902e,g_xccd2_d[g_detail_idx].xcce902f, 
#                       g_xccd2_d[g_detail_idx].xcce902g,g_xccd2_d[g_detail_idx].xcce902h,g_xccd2_d[g_detail_idx].xcce902) 
#
#      #add-point:insert_b段資料新增中

#      #end add-point
#      IF SQLCA.sqlcode THEN
#         INITIALIZE g_errparam TO NULL 
#         LET g_errparam.extend = "xcce_t" 
#         LET g_errparam.code   = SQLCA.sqlcode 
#         LET g_errparam.popup  = FALSE 
#         CALL cl_err()
# 
#      END IF
#      #add-point:insert_b段資料新增後

#      #end add-point
#   END IF
# 
#   LET ls_group = "'3',"
#   #判斷是否是同一群組的table
#   IF ls_group.getIndexOf(ps_page,1) > 0 THEN
#      #add-point:insert_b段資料新增前

#      #end add-point 
#      INSERT INTO xcci_t
#                  (xccient,
#                   xccild,xcci001,xcci003,xcci004,xcci005,
#                   xcci002,xcci006,xcci007,xcci008,xcci009
#                   ,xcci101,xcci102a,xcci102b,xcci102c,xcci102d,xcci102e,xcci102f,xcci102g,xcci102h,xcci102,xcci201,xcci202a,xcci202b,xcci202c,xcci202d,xcci202e,xcci202f,xcci202g,xcci202h,xcci202,xcci301,xcci302a,xcci302b,xcci302c,xcci302d,xcci302e,xcci302f,xcci302g,xcci302h,xcci302,xcci303,xcci304a,xcci304b,xcci304c,xcci304d,xcci304e,xcci304f,xcci304g,xcci304h,xcci304,xcci901,xcci902a,xcci902b,xcci902c,xcci902d,xcci902e,xcci902f,xcci902g,xcci902h,xcci902) 
#            VALUES(g_enterprise,
#                   ps_keys[1],ps_keys[2],ps_keys[3],ps_keys[4],ps_keys[5],ps_keys[6],ps_keys[7],ps_keys[8],ps_keys[9],ps_keys[10]
#                   ,g_xccd3_d[g_detail_idx].xcci101,g_xccd3_d[g_detail_idx].xcci102a,g_xccd3_d[g_detail_idx].xcci102b, 
#                       g_xccd3_d[g_detail_idx].xcci102c,g_xccd3_d[g_detail_idx].xcci102d,g_xccd3_d[g_detail_idx].xcci102e, 
#                       g_xccd3_d[g_detail_idx].xcci102f,g_xccd3_d[g_detail_idx].xcci102g,g_xccd3_d[g_detail_idx].xcci102h, 
#                       g_xccd3_d[g_detail_idx].xcci102,g_xccd3_d[g_detail_idx].xcci201,g_xccd3_d[g_detail_idx].xcci202a, 
#                       g_xccd3_d[g_detail_idx].xcci202b,g_xccd3_d[g_detail_idx].xcci202c,g_xccd3_d[g_detail_idx].xcci202d, 
#                       g_xccd3_d[g_detail_idx].xcci202e,g_xccd3_d[g_detail_idx].xcci202f,g_xccd3_d[g_detail_idx].xcci202g, 
#                       g_xccd3_d[g_detail_idx].xcci202h,g_xccd3_d[g_detail_idx].xcci202,g_xccd3_d[g_detail_idx].xcci301, 
#                       g_xccd3_d[g_detail_idx].xcci302a,g_xccd3_d[g_detail_idx].xcci302b,g_xccd3_d[g_detail_idx].xcci302c, 
#                       g_xccd3_d[g_detail_idx].xcci302d,g_xccd3_d[g_detail_idx].xcci302e,g_xccd3_d[g_detail_idx].xcci302f, 
#                       g_xccd3_d[g_detail_idx].xcci302g,g_xccd3_d[g_detail_idx].xcci302h,g_xccd3_d[g_detail_idx].xcci302, 
#                       g_xccd3_d[g_detail_idx].xcci303,g_xccd3_d[g_detail_idx].xcci304a,g_xccd3_d[g_detail_idx].xcci304b, 
#                       g_xccd3_d[g_detail_idx].xcci304c,g_xccd3_d[g_detail_idx].xcci304d,g_xccd3_d[g_detail_idx].xcci304e, 
#                       g_xccd3_d[g_detail_idx].xcci304f,g_xccd3_d[g_detail_idx].xcci304g,g_xccd3_d[g_detail_idx].xcci304h, 
#                       g_xccd3_d[g_detail_idx].xcci304,g_xccd3_d[g_detail_idx].xcci901,g_xccd3_d[g_detail_idx].xcci902a, 
#                       g_xccd3_d[g_detail_idx].xcci902b,g_xccd3_d[g_detail_idx].xcci902c,g_xccd3_d[g_detail_idx].xcci902d, 
#                       g_xccd3_d[g_detail_idx].xcci902e,g_xccd3_d[g_detail_idx].xcci902f,g_xccd3_d[g_detail_idx].xcci902g, 
#                       g_xccd3_d[g_detail_idx].xcci902h,g_xccd3_d[g_detail_idx].xcci902)
#      #add-point:insert_b段資料新增中

#      #end add-point
#      IF SQLCA.sqlcode THEN
#         INITIALIZE g_errparam TO NULL 
#         LET g_errparam.extend = "xcci_t" 
#         LET g_errparam.code   = SQLCA.sqlcode 
#         LET g_errparam.popup  = FALSE 
#         CALL cl_err()
# 
#      END IF
#      #add-point:insert_b段資料新增後

#      #end add-point
#   END IF
# 
# 
#   
# 
#   
#   #add-point:insert_b段other

#   #end add-point     
   
END FUNCTION
 
{</section>}
 
{<section id="axcq540.update_b" >}
#+ 修改單身後其他table連動
PRIVATE FUNCTION axcq540_update_b(ps_table,ps_keys,ps_keys_bak,ps_page)
   DEFINE ps_table         STRING
   DEFINE ps_page          STRING
   DEFINE ps_keys          DYNAMIC ARRAY OF VARCHAR(500)
   DEFINE ps_keys_bak      DYNAMIC ARRAY OF VARCHAR(500)
   DEFINE ls_group         STRING
   DEFINE li_idx           LIKE type_t.num5 
   DEFINE lb_chk           BOOLEAN
   DEFINE l_new_key        DYNAMIC ARRAY OF STRING
   DEFINE l_old_key        DYNAMIC ARRAY OF STRING
   DEFINE l_field_key      DYNAMIC ARRAY OF STRING
   #add-point:update_b段define

   #end add-point     
   
#   #判斷key是否有改變
#   LET lb_chk = TRUE
#   FOR li_idx = 1 TO ps_keys.getLength()
#      IF ps_keys[li_idx] <> ps_keys_bak[li_idx] THEN
#         LET lb_chk = FALSE
#         EXIT FOR
#      END IF
#   END FOR
#   
#   #不需要做處理
#   IF lb_chk THEN
#      RETURN
#   END IF
#   
#   #判斷是否是同一群組的table
#   LET ls_group = "'1',"
#   IF ls_group.getIndexOf(ps_page,1) > 0 AND ps_table <> "xccd_t" THEN
#      #add-point:update_b段修改前

#      #end add-point     
#      UPDATE xccd_t 
#         SET (,
#              xccdld,xccd001,xccd003,xccd004,xccd005
#              ,xccd006,xccd002) 
#              = 
#             (ps_keys[1],ps_keys[2],ps_keys[3],ps_keys[4],ps_keys[5]
#              ,g_xccd_d[g_detail_idx].xccd006,g_xccd_d[g_detail_idx].xccd002) 
#         WHERE xccdent = g_enterprise AND xccdld = ps_keys_bak[1] AND xccd001 = ps_keys_bak[2] AND xccd003 = ps_keys_bak[3] AND xccd004 = ps_keys_bak[4] AND xccd005 = ps_keys_bak[5]
#      #add-point:update_b段修改中

#      #end add-point   
#      CASE
#         WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
#            INITIALIZE g_errparam TO NULL 
#            LET g_errparam.extend = "xccd_t" 
#            LET g_errparam.code   = "std-00009" 
#            LET g_errparam.popup  = TRUE 
#            CALL cl_err()
#            CALL s_transaction_end('N','0')
#         WHEN SQLCA.sqlcode #其他錯誤
#            INITIALIZE g_errparam TO NULL 
#            LET g_errparam.extend = "xccd_t" 
#            LET g_errparam.code   = SQLCA.sqlcode 
#            LET g_errparam.popup  = TRUE 
#            CALL cl_err()
# 
#            CALL s_transaction_end('N','0')
#         OTHERWISE
#            LET l_new_key[01] = ps_keys[01] 
#LET l_old_key[01] = ps_keys_bak[01] 
#LET l_field_key[01] = 'xcbbcomp'
#LET l_new_key[02] = ps_keys[02] 
#LET l_old_key[02] = ps_keys_bak[02] 
#LET l_field_key[02] = 'xcbb001'
#LET l_new_key[03] = ps_keys[03] 
#LET l_old_key[03] = ps_keys_bak[03] 
#LET l_field_key[03] = 'xcbb002'
#LET l_new_key[04] = ps_keys[04] 
#LET l_old_key[04] = ps_keys_bak[04] 
#LET l_field_key[04] = 'xcbb003'
#LET l_new_key[05] = ps_keys[05] 
#LET l_old_key[05] = ps_keys_bak[05] 
#LET l_field_key[05] = 'xcbb004'
#CALL cl_multitable_key_upd(l_new_key, l_old_key, l_field_key, 'xcbb_t')
#      END CASE
#      #add-point:update_b段修改後

#      #end add-point  
#   END IF
#   
#   LET ls_group = "'2',"
#   #判斷是否是同一群組的table
#   IF ls_group.getIndexOf(ps_page,1) > 0 AND ps_table <> "xcce_t" THEN
#      #add-point:update_b段修改前

#      #end add-point     
#      UPDATE xcce_t 
#         SET (xcceld,xcce001,xcce003,xcce004,xcce005,
#              xcce002,xcce006,xcce007,xcce008,xcce009
#              ,xcce101,xcce102a,xcce102b,xcce102c,xcce102d,xcce102e,xcce102f,xcce102g,xcce102h,xcce102,xcce201,xcce202a,xcce202b,xcce202c,xcce202d,xcce202e,xcce202f,xcce202g,xcce202h,xcce202,xcce301,xcce302a,xcce302b,xcce302c,xcce302d,xcce302e,xcce302f,xcce302g,xcce302h,xcce302,xcce303,xcce304a,xcce304b,xcce304c,xcce304d,xcce304e,xcce304f,xcce304g,xcce304h,xcce304,xcce307,xcce308a,xcce308b,xcce308c,xcce308d,xcce308e,xcce308f,xcce308g,xcce308h,xcce308,xcce901,xcce902a,xcce902b,xcce902c,xcce902d,xcce902e,xcce902f,xcce902g,xcce902h,xcce902) 
#              = 
#             (ps_keys[1],ps_keys[2],ps_keys[3],ps_keys[4],ps_keys[5],ps_keys[6],ps_keys[7],ps_keys[8],ps_keys[9],ps_keys[10]
#              ,g_xccd2_d[g_detail_idx].xcce101,g_xccd2_d[g_detail_idx].xcce102a,g_xccd2_d[g_detail_idx].xcce102b, 
#                  g_xccd2_d[g_detail_idx].xcce102c,g_xccd2_d[g_detail_idx].xcce102d,g_xccd2_d[g_detail_idx].xcce102e, 
#                  g_xccd2_d[g_detail_idx].xcce102f,g_xccd2_d[g_detail_idx].xcce102g,g_xccd2_d[g_detail_idx].xcce102h, 
#                  g_xccd2_d[g_detail_idx].xcce102,g_xccd2_d[g_detail_idx].xcce201,g_xccd2_d[g_detail_idx].xcce202a, 
#                  g_xccd2_d[g_detail_idx].xcce202b,g_xccd2_d[g_detail_idx].xcce202c,g_xccd2_d[g_detail_idx].xcce202d, 
#                  g_xccd2_d[g_detail_idx].xcce202e,g_xccd2_d[g_detail_idx].xcce202f,g_xccd2_d[g_detail_idx].xcce202g, 
#                  g_xccd2_d[g_detail_idx].xcce202h,g_xccd2_d[g_detail_idx].xcce202,g_xccd2_d[g_detail_idx].xcce301, 
#                  g_xccd2_d[g_detail_idx].xcce302a,g_xccd2_d[g_detail_idx].xcce302b,g_xccd2_d[g_detail_idx].xcce302c, 
#                  g_xccd2_d[g_detail_idx].xcce302d,g_xccd2_d[g_detail_idx].xcce302e,g_xccd2_d[g_detail_idx].xcce302f, 
#                  g_xccd2_d[g_detail_idx].xcce302g,g_xccd2_d[g_detail_idx].xcce302h,g_xccd2_d[g_detail_idx].xcce302, 
#                  g_xccd2_d[g_detail_idx].xcce303,g_xccd2_d[g_detail_idx].xcce304a,g_xccd2_d[g_detail_idx].xcce304b, 
#                  g_xccd2_d[g_detail_idx].xcce304c,g_xccd2_d[g_detail_idx].xcce304d,g_xccd2_d[g_detail_idx].xcce304e, 
#                  g_xccd2_d[g_detail_idx].xcce304f,g_xccd2_d[g_detail_idx].xcce304g,g_xccd2_d[g_detail_idx].xcce304h, 
#                  g_xccd2_d[g_detail_idx].xcce304,g_xccd2_d[g_detail_idx].xcce307,g_xccd2_d[g_detail_idx].xcce308a, 
#                  g_xccd2_d[g_detail_idx].xcce308b,g_xccd2_d[g_detail_idx].xcce308c,g_xccd2_d[g_detail_idx].xcce308d, 
#                  g_xccd2_d[g_detail_idx].xcce308e,g_xccd2_d[g_detail_idx].xcce308f,g_xccd2_d[g_detail_idx].xcce308g, 
#                  g_xccd2_d[g_detail_idx].xcce308h,g_xccd2_d[g_detail_idx].xcce308,g_xccd2_d[g_detail_idx].xcce901, 
#                  g_xccd2_d[g_detail_idx].xcce902a,g_xccd2_d[g_detail_idx].xcce902b,g_xccd2_d[g_detail_idx].xcce902c, 
#                  g_xccd2_d[g_detail_idx].xcce902d,g_xccd2_d[g_detail_idx].xcce902e,g_xccd2_d[g_detail_idx].xcce902f, 
#                  g_xccd2_d[g_detail_idx].xcce902g,g_xccd2_d[g_detail_idx].xcce902h,g_xccd2_d[g_detail_idx].xcce902)  
#
#         WHERE xcceent = g_enterprise AND xcceld = ps_keys_bak[1] AND xcce001 = ps_keys_bak[2] AND xcce003 = ps_keys_bak[3] AND xcce004 = ps_keys_bak[4] AND xcce005 = ps_keys_bak[5] AND xcce002 = ps_keys_bak[6] AND xcce006 = ps_keys_bak[7] AND xcce007 = ps_keys_bak[8] AND xcce008 = ps_keys_bak[9] AND xcce009 = ps_keys_bak[10]
#      #add-point:update_b段修改中

#      #end add-point  
#      CASE
#         WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
#            INITIALIZE g_errparam TO NULL 
#            LET g_errparam.extend = "xcce_t" 
#            LET g_errparam.code   = "std-00009" 
#            LET g_errparam.popup  = TRUE 
#            CALL cl_err()
#            CALL s_transaction_end('N','0')
#         WHEN SQLCA.sqlcode #其他錯誤
#            INITIALIZE g_errparam TO NULL 
#            LET g_errparam.extend = "xcce_t" 
#            LET g_errparam.code   = SQLCA.sqlcode 
#            LET g_errparam.popup  = TRUE 
#            CALL cl_err()
# 
#            CALL s_transaction_end('N','0')
#         OTHERWISE
#            
#      END CASE
#      #add-point:update_b段修改後

#      #end add-point  
#   END IF
# 
#   LET ls_group = "'3',"
#   #判斷是否是同一群組的table
#   IF ls_group.getIndexOf(ps_page,1) > 0 AND ps_table <> "xcci_t" THEN
#      #add-point:update_b段修改前

#      #end add-point     
#      UPDATE xcci_t 
#         SET (xccild,xcci001,xcci003,xcci004,xcci005,
#              xcci002,xcci006,xcci007,xcci008,xcci009
#              ,xcci101,xcci102a,xcci102b,xcci102c,xcci102d,xcci102e,xcci102f,xcci102g,xcci102h,xcci102,xcci201,xcci202a,xcci202b,xcci202c,xcci202d,xcci202e,xcci202f,xcci202g,xcci202h,xcci202,xcci301,xcci302a,xcci302b,xcci302c,xcci302d,xcci302e,xcci302f,xcci302g,xcci302h,xcci302,xcci303,xcci304a,xcci304b,xcci304c,xcci304d,xcci304e,xcci304f,xcci304g,xcci304h,xcci304,xcci901,xcci902a,xcci902b,xcci902c,xcci902d,xcci902e,xcci902f,xcci902g,xcci902h,xcci902) 
#              = 
#             (ps_keys[1],ps_keys[2],ps_keys[3],ps_keys[4],ps_keys[5],ps_keys[6],ps_keys[7],ps_keys[8],ps_keys[9],ps_keys[10]
#              ,g_xccd3_d[g_detail_idx].xcci101,g_xccd3_d[g_detail_idx].xcci102a,g_xccd3_d[g_detail_idx].xcci102b, 
#                  g_xccd3_d[g_detail_idx].xcci102c,g_xccd3_d[g_detail_idx].xcci102d,g_xccd3_d[g_detail_idx].xcci102e, 
#                  g_xccd3_d[g_detail_idx].xcci102f,g_xccd3_d[g_detail_idx].xcci102g,g_xccd3_d[g_detail_idx].xcci102h, 
#                  g_xccd3_d[g_detail_idx].xcci102,g_xccd3_d[g_detail_idx].xcci201,g_xccd3_d[g_detail_idx].xcci202a, 
#                  g_xccd3_d[g_detail_idx].xcci202b,g_xccd3_d[g_detail_idx].xcci202c,g_xccd3_d[g_detail_idx].xcci202d, 
#                  g_xccd3_d[g_detail_idx].xcci202e,g_xccd3_d[g_detail_idx].xcci202f,g_xccd3_d[g_detail_idx].xcci202g, 
#                  g_xccd3_d[g_detail_idx].xcci202h,g_xccd3_d[g_detail_idx].xcci202,g_xccd3_d[g_detail_idx].xcci301, 
#                  g_xccd3_d[g_detail_idx].xcci302a,g_xccd3_d[g_detail_idx].xcci302b,g_xccd3_d[g_detail_idx].xcci302c, 
#                  g_xccd3_d[g_detail_idx].xcci302d,g_xccd3_d[g_detail_idx].xcci302e,g_xccd3_d[g_detail_idx].xcci302f, 
#                  g_xccd3_d[g_detail_idx].xcci302g,g_xccd3_d[g_detail_idx].xcci302h,g_xccd3_d[g_detail_idx].xcci302, 
#                  g_xccd3_d[g_detail_idx].xcci303,g_xccd3_d[g_detail_idx].xcci304a,g_xccd3_d[g_detail_idx].xcci304b, 
#                  g_xccd3_d[g_detail_idx].xcci304c,g_xccd3_d[g_detail_idx].xcci304d,g_xccd3_d[g_detail_idx].xcci304e, 
#                  g_xccd3_d[g_detail_idx].xcci304f,g_xccd3_d[g_detail_idx].xcci304g,g_xccd3_d[g_detail_idx].xcci304h, 
#                  g_xccd3_d[g_detail_idx].xcci304,g_xccd3_d[g_detail_idx].xcci901,g_xccd3_d[g_detail_idx].xcci902a, 
#                  g_xccd3_d[g_detail_idx].xcci902b,g_xccd3_d[g_detail_idx].xcci902c,g_xccd3_d[g_detail_idx].xcci902d, 
#                  g_xccd3_d[g_detail_idx].xcci902e,g_xccd3_d[g_detail_idx].xcci902f,g_xccd3_d[g_detail_idx].xcci902g, 
#                  g_xccd3_d[g_detail_idx].xcci902h,g_xccd3_d[g_detail_idx].xcci902) 
#         WHERE xccient = g_enterprise AND xccild = ps_keys_bak[1] AND xcci001 = ps_keys_bak[2] AND xcci003 = ps_keys_bak[3] AND xcci004 = ps_keys_bak[4] AND xcci005 = ps_keys_bak[5] AND xcci002 = ps_keys_bak[6] AND xcci006 = ps_keys_bak[7] AND xcci007 = ps_keys_bak[8] AND xcci008 = ps_keys_bak[9] AND xcci009 = ps_keys_bak[10]
#      #add-point:update_b段修改中

#      #end add-point  
#      CASE
#         WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
#            INITIALIZE g_errparam TO NULL 
#            LET g_errparam.extend = "xcci_t" 
#            LET g_errparam.code   = "std-00009" 
#            LET g_errparam.popup  = TRUE 
#            CALL cl_err()
#            CALL s_transaction_end('N','0')
#         WHEN SQLCA.sqlcode #其他錯誤
#            INITIALIZE g_errparam TO NULL 
#            LET g_errparam.extend = "xcci_t" 
#            LET g_errparam.code   = SQLCA.sqlcode 
#            LET g_errparam.popup  = TRUE 
#            CALL cl_err()
# 
#            CALL s_transaction_end('N','0')
#         OTHERWISE
#            
#      END CASE
#      #add-point:update_b段修改後

#      #end add-point  
#   END IF
# 
# 
#   
# 
#   
# 
#   
#   #add-point:update_b段other

#   #end add-point  
   
END FUNCTION
 
{</section>}
 
{<section id="axcq540.lock_b" >}
#+ 連動lock其他單身table資料
PRIVATE FUNCTION axcq540_lock_b(ps_table,ps_page)
   DEFINE ps_page     STRING
   DEFINE ps_table    STRING
   DEFINE ls_group    STRING
   #add-point:lock_b段define

   #end add-point   
   
#   #先刷新資料
#   #CALL axcq540_b_fill()
#   
#   #鎖定整組table
#   #LET ls_group = "'1',"
#   #僅鎖定自身table
#   LET ls_group = "xccd_t"
#   
#   IF ls_group.getIndexOf(ps_table,1) THEN
#      OPEN axcq540_bcl USING g_enterprise,
#                                       g_xccd_m.xccdld,g_xccd_m.xccd001,g_xccd_m.xccd003,g_xccd_m.xccd004, 
#                                           g_xccd_m.xccd005,g_xccd_d[g_detail_idx].xccdld,g_xccd_d[g_detail_idx].xccd001, 
#                                           g_xccd_d[g_detail_idx].xccd003,g_xccd_d[g_detail_idx].xccd004, 
#                                           g_xccd_d[g_detail_idx].xccd005     
#      IF SQLCA.sqlcode THEN
#         INITIALIZE g_errparam TO NULL 
#         LET g_errparam.extend = "axcq540_bcl" 
#         LET g_errparam.code   = SQLCA.sqlcode 
#         LET g_errparam.popup  = TRUE 
#         CALL cl_err()
# 
#         RETURN FALSE
#      END IF
#   END IF
#                                    
#   #鎖定整組table
#   #LET ls_group = "'2',"
#   #僅鎖定自身table
#   LET ls_group = "xcce_t"
#   IF ls_group.getIndexOf(ps_table,1) THEN
#   
#      OPEN axcq540_bcl2 USING g_enterprise,
#                                             g_xccd_m.xccdld,g_xccd_m.xccd001,g_xccd_m.xccd003,g_xccd_m.xccd004, 
#                                                 g_xccd_m.xccd005,g_xccd2_d[g_detail_idx].xcce002,g_xccd2_d[g_detail_idx].xcce006, 
#                                                 g_xccd2_d[g_detail_idx].xcce007,g_xccd2_d[g_detail_idx].xcce008, 
#                                                 g_xccd2_d[g_detail_idx].xcce009
#      IF SQLCA.sqlcode THEN
#         INITIALIZE g_errparam TO NULL 
#         LET g_errparam.extend = "axcq540_bcl2" 
#         LET g_errparam.code   = SQLCA.sqlcode 
#         LET g_errparam.popup  = TRUE 
#         CALL cl_err()
# 
#         RETURN FALSE
#      END IF
#   END IF
# 
#   #鎖定整組table
#   #LET ls_group = "'3',"
#   #僅鎖定自身table
#   LET ls_group = "xcci_t"
#   IF ls_group.getIndexOf(ps_table,1) THEN
#   
#      OPEN axcq540_bcl3 USING g_enterprise,
#                                             g_xccd_m.xccdld,g_xccd_m.xccd001,g_xccd_m.xccd003,g_xccd_m.xccd004, 
#                                                 g_xccd_m.xccd005,g_xccd3_d[g_detail_idx].xcci002,g_xccd3_d[g_detail_idx].xcci006, 
#                                                 g_xccd3_d[g_detail_idx].xcci007,g_xccd3_d[g_detail_idx].xcci008, 
#                                                 g_xccd3_d[g_detail_idx].xcci009
#      IF SQLCA.sqlcode THEN
#         INITIALIZE g_errparam TO NULL 
#         LET g_errparam.extend = "axcq540_bcl3" 
#         LET g_errparam.code   = SQLCA.sqlcode 
#         LET g_errparam.popup  = TRUE 
#         CALL cl_err()
# 
#         RETURN FALSE
#      END IF
#   END IF
# 
# 
#   
# 
#   
#   #add-point:lock_b段other

#   #end add-point  
#   
#   RETURN TRUE
# 
END FUNCTION
 
{</section>}
 
{<section id="axcq540.unlock_b" >}
#+ 連動unlock其他單身table資料
PRIVATE FUNCTION axcq540_unlock_b(ps_table,ps_page)
   DEFINE ps_page     STRING
   DEFINE ps_table    STRING
   DEFINE ls_group    STRING
   #add-point:unlock_b段define

   #end add-point  
   
#   LET ls_group = "'1',"
#   
#   IF ls_group.getIndexOf(ps_page,1) THEN
#      CLOSE axcq540_bcl
#   END IF
#   
#   LET ls_group = "'2',"
#   
#   IF ls_group.getIndexOf(ps_page,1) THEN
#      CLOSE axcq540_bcl2
#   END IF
# 
#   LET ls_group = "'3',"
#   
#   IF ls_group.getIndexOf(ps_page,1) THEN
#      CLOSE axcq540_bcl3
#   END IF
# 
# 
#   
# 
# 
   #add-point:unlock_b段other

   #end add-point  
 
END FUNCTION
 
{</section>}
 
{<section id="axcq540.set_entry" >}
#+ 單頭欄位開啟設定
PRIVATE FUNCTION axcq540_set_entry(p_cmd)
   DEFINE p_cmd   LIKE type_t.chr1  
   #add-point:set_entry段define
   
   #end add-point       
 
   IF p_cmd = 'a' THEN
      CALL cl_set_comp_entry("xccdld,xccd001,xccd003,xccd004,xccd005",TRUE)
      #add-point:set_entry段欄位控制
      
      #end add-point  
   END IF
   
   #add-point:set_entry段欄位控制後
   
   #end add-point 
 
END FUNCTION
 
{</section>}
 
{<section id="axcq540.set_no_entry" >}
#+ 單頭欄位關閉設定
PRIVATE FUNCTION axcq540_set_no_entry(p_cmd)
   DEFINE p_cmd   LIKE type_t.chr1   
   #add-point:set_no_entry段define
   
   #end add-point     
 
   IF p_cmd = 'u' AND g_chkey = 'N' THEN
      CALL cl_set_comp_entry("xccdld,xccd001,xccd003,xccd004,xccd005",FALSE)
      #add-point:set_no_entry段欄位控制
      
      #end add-point 
   END IF 
   
   #add-point:set_no_entry段欄位控制後
   
   #end add-point 
 
END FUNCTION
 
{</section>}
 
{<section id="axcq540.set_entry_b" >}
#+ 單身欄位開啟設定
PRIVATE FUNCTION axcq540_set_entry_b(p_cmd)
   DEFINE p_cmd   LIKE type_t.chr1   
   #add-point:set_entry_b段define
   
   #end add-point     
   
   IF p_cmd = 'a' THEN
      CALL cl_set_comp_entry("",TRUE)
      #add-point:set_entry段欄位控制
      
      #end add-point  
   END IF
   
   #add-point:set_entry_b段
   
   #end add-point  
END FUNCTION
 
{</section>}
 
{<section id="axcq540.set_no_entry_b" >}
#+ 單身欄位關閉設定
PRIVATE FUNCTION axcq540_set_no_entry_b(p_cmd)
   DEFINE p_cmd   LIKE type_t.chr1   
   #add-point:set_no_entry_b段define
   
   #end add-point    
   
   IF p_cmd = 'u' AND g_chkey = 'N' THEN
      CALL cl_set_comp_entry("",FALSE)
      #add-point:set_no_entry_b段欄位控制
      
      #end add-point 
   END IF 
   
   #add-point:set_no_entry_b段
   
   #end add-point     
END FUNCTION
 
{</section>}
 
{<section id="axcq540.default_search" >}
#+ 外部參數搜尋
PRIVATE FUNCTION axcq540_default_search()
   DEFINE li_idx  LIKE type_t.num5
   DEFINE li_cnt  LIKE type_t.num5
   DEFINE ls_wc   STRING
   #add-point:default_search段define
   
   #end add-point  
   
   #add-point:default_search段開始前
   
   #end add-point  
   
   LET g_pagestart = 1
   
   IF cl_null(g_order) THEN
      LET g_order = "ASC"
   END IF
   
   IF NOT cl_null(g_argv[01]) THEN
      LET ls_wc = ls_wc, " xccdld = '", g_argv[01], "' AND "
   END IF
   
   IF NOT cl_null(g_argv[02]) THEN
      LET ls_wc = ls_wc, " xccd001 = '", g_argv[02], "' AND "
   END IF
   IF NOT cl_null(g_argv[03]) THEN
      LET ls_wc = ls_wc, " xccd003 = '", g_argv[03], "' AND "
   END IF
   IF NOT cl_null(g_argv[04]) THEN
      LET ls_wc = ls_wc, " xccd004 = '", g_argv[04], "' AND "
   END IF
   IF NOT cl_null(g_argv[05]) THEN
      LET ls_wc = ls_wc, " xccd005 = '", g_argv[05], "' AND "
   END IF
 
   
   #add-point:default_search段after sql
   
   #end add-point  
   
   IF NOT cl_null(ls_wc) THEN
      LET g_wc = ls_wc.subString(1,ls_wc.getLength()-5)
      LET g_default = TRUE
   ELSE
      LET g_default = FALSE
      #預設查詢條件
      LET g_wc = cl_qbe_get_default_qryplan()
      IF cl_null(g_wc) THEN
         LET g_wc = " 1=2"
      END IF
   END IF
   
   #add-point:default_search段結束前
   
   #end add-point  
 
END FUNCTION
 
{</section>}
 
{<section id="axcq540.state_change" >}
   
 
{</section>}
 
{<section id="axcq540.idx_chk" >}
#+ 顯示正確的單身資料筆數
PRIVATE FUNCTION axcq540_idx_chk()
   #add-point:idx_chk段define
   
   #end add-point  
   
   IF g_current_page = 1 THEN
      LET g_detail_idx = g_curr_diag.getCurrentRow("s_detail1")
      IF g_detail_idx > g_xccd_d.getLength() THEN
         LET g_detail_idx = g_xccd_d.getLength()
      END IF
      IF g_detail_idx = 0 AND g_xccd_d.getLength() <> 0 THEN
         LET g_detail_idx = 1
      END IF
      DISPLAY g_detail_idx TO FORMONLY.idx
      DISPLAY g_xccd_d.getLength() TO FORMONLY.cnt
   END IF
   
   IF g_current_page = 2 THEN
      LET g_detail_idx = g_curr_diag.getCurrentRow("s_detail2")
      IF g_detail_idx > g_xccd2_d.getLength() THEN
         LET g_detail_idx = g_xccd2_d.getLength()
      END IF
      IF g_detail_idx = 0 AND g_xccd2_d.getLength() <> 0 THEN
         LET g_detail_idx = 1
      END IF
      DISPLAY g_detail_idx TO FORMONLY.idx
      DISPLAY g_xccd2_d.getLength() TO FORMONLY.cnt
   END IF
   IF g_current_page = 3 THEN
      LET g_detail_idx = g_curr_diag.getCurrentRow("s_detail3")
      IF g_detail_idx > g_xccd3_d.getLength() THEN
         LET g_detail_idx = g_xccd3_d.getLength()
      END IF
      IF g_detail_idx = 0 AND g_xccd3_d.getLength() <> 0 THEN
         LET g_detail_idx = 1
      END IF
      DISPLAY g_detail_idx TO FORMONLY.idx
      DISPLAY g_xccd3_d.getLength() TO FORMONLY.cnt
   END IF
 
   
   #add-point:idx_chk段other
   
   #end add-point  
   
END FUNCTION
 
{</section>}
 
{<section id="axcq540.b_fill2" >}
#+ 單身陣列填充2
PRIVATE FUNCTION axcq540_b_fill2(pi_idx)
   DEFINE pi_idx          LIKE type_t.num5
   DEFINE li_ac           LIKE type_t.num5
   DEFINE ls_chk          LIKE type_t.chr1
   #add-point:b_fill2段define
   
   #end add-point
   
   LET li_ac = l_ac 
   
   IF g_detail_idx <= 0 THEN
      RETURN
   END IF
   
 
      
   #add-point:單身填充後
   
   #end add-point
    
   LET l_ac = li_ac
   
   CALL axcq540_detail_show()
   
END FUNCTION
 
{</section>}
 
{<section id="axcq540.fill_chk" >}
#+ 單身填充確認
PRIVATE FUNCTION axcq540_fill_chk(ps_idx)
   DEFINE ps_idx        LIKE type_t.chr10
   #add-point:fill_chk段define
   
   #end add-point
   
   #add-point:fill_chk段before_chk
   
   #end add-point
   
   #全部為1=1 or null時回傳true
   IF (cl_null(g_wc2_table1) OR g_wc2_table1.trim() = '1=1')  AND 
      (cl_null(g_wc2_table2) OR g_wc2_table2.trim() = '1=1')  AND 
      (cl_null(g_wc2_table3) OR g_wc2_table3.trim() = '1=1') THEN
      #add-point:fill_chk段other_chk
      
      #end add-point
      RETURN TRUE
   END IF
   
   #第一單身
   IF ps_idx = 1 AND
      ((NOT cl_null(g_wc2_table1) AND g_wc2_table1.trim() <> '1=1')) THEN
      RETURN TRUE
   END IF
   
   #根據wc判定是否需要填充
   IF ps_idx = 2 AND
      ((NOT cl_null(g_wc2_table2) AND g_wc2_table2.trim() <> '1=1')) THEN
      RETURN TRUE
   END IF
 
   IF ps_idx = 3 AND
      ((NOT cl_null(g_wc2_table3) AND g_wc2_table3.trim() <> '1=1')) THEN
      RETURN TRUE
   END IF
 
 
 
   
   #add-point:fill_chk段after_chk
   #fengmy150215---begin
   IF ((NOT cl_null(g_wc2_table1) AND g_wc2_table1.trim() <> '1=1')) OR
      ((NOT cl_null(g_wc2_table2) AND g_wc2_table2.trim() <> '1=1')) OR     
      ((NOT cl_null(g_wc2_table3) AND g_wc2_table3.trim() <> '1=1')) THEN
      RETURN TRUE
   END IF
   #fengmy150215---end
   #end add-point
   
   RETURN FALSE
 
END FUNCTION
 
{</section>}
 
{<section id="axcq540.signature" >}
   
 
{</section>}
 
{<section id="axcq540.set_pk_array" >}
   #+ 此段落由子樣板a51產生
#+ 給予pk_array內容
PRIVATE FUNCTION axcq540_set_pk_array()
   #add-point:set_pk_array段define
   
   #end add-point
   
   #add-point:set_pk_array段之前
   
   #end add-point  
   
   CALL g_pk_array.clear()
   LET g_pk_array[1].values = g_xccd_m.xccdld
   LET g_pk_array[1].column = 'xccdld'
   LET g_pk_array[2].values = g_xccd_m.xccd001
   LET g_pk_array[2].column = 'xccd001'
   LET g_pk_array[3].values = g_xccd_m.xccd003
   LET g_pk_array[3].column = 'xccd003'
   LET g_pk_array[4].values = g_xccd_m.xccd004
   LET g_pk_array[4].column = 'xccd004'
   LET g_pk_array[5].values = g_xccd_m.xccd005
   LET g_pk_array[5].column = 'xccd005'
   
   #add-point:set_pk_array段之後
   
   #end add-point  
   
END FUNCTION
 
 
 
{</section>}
 
{<section id="axcq540.other_dialog" readonly="Y" >}
   
 
{</section>}
 
{<section id="axcq540.other_function" readonly="Y" >}

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
PRIVATE FUNCTION axcq540_default()
DEFINE  l_glaa001        LIKE glaa_t.glaa001

   #预设当前site的法人，主账套，年度期别，成本计算类型
   #fengmy150806----begin
#   CALL s_axc_set_site_default() RETURNING g_xccd_m.xccdcomp,g_xccd_m.xccdld,g_xccd_m.xccd004,g_xccd_m.xccd005,g_xccd_m.xccd003
#   DISPLAY BY NAME g_xccd_m.xccdcomp,g_xccd_m.xccdld,g_xccd_m.xccd004,g_xccd_m.xccd005,g_xccd_m.xccd003
   IF cl_null(g_xccd_m.xccdcomp) AND cl_null(g_xccd_m.xccdld) AND cl_null(g_yy1) AND cl_null(g_mm1) 
             AND cl_null(g_yy2) AND cl_null(g_mm2) AND cl_null(g_xccd_m.xccd003) AND cl_null(g_xccd_m.xccd001) THEN
      CALL s_axc_set_site_default() RETURNING g_xccd_m.xccdcomp,g_xccd_m.xccdld,g_yy2,g_mm2,g_xccd_m.xccd003
      DISPLAY BY NAME g_xccd_m.xccdcomp,g_xccd_m.xccdld,g_xccd_m.xccd003
      LET g_yy1 = g_yy2
      LET g_mm1 = g_mm2
      DISPLAY g_yy1 TO xccd004
      DISPLAY g_mm1 TO xccd005
      DISPLAY g_yy2 TO xccd004_1
      DISPLAY g_mm2 TO xccd005_1
   END IF
   #fengmy150806----end      
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_xccd_m.xccdcomp
   CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_xccd_m.xccdcomp_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_xccd_m.xccdcomp_desc 
   
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_xccd_m.xccdld
   CALL ap_ref_array2(g_ref_fields,"SELECT glaal002 FROM glaal_t WHERE glaalent='"||g_enterprise||"' AND glaalld=? AND glaal001='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_xccd_m.xccdld_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_xccd_m.xccdld_desc 

   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_xccd_m.xccd003
   CALL ap_ref_array2(g_ref_fields,"SELECT xcatl003 FROM xcatl_t WHERE xcatlent='"||g_enterprise||"' AND xcatl001=? AND xcatl002='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_xccd_m.xccd003_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_xccd_m.xccd003_desc
      
   LET g_xccd_m.xccd001 = '1'
   DISPLAY BY NAME g_xccd_m.xccd001
   
   SELECT glaa001 INTO l_glaa001
     FROM glaa_t
    WHERE glaaent = g_enterprise
      AND glaald  = g_xccd_m.xccdld

   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = l_glaa001
   CALL ap_ref_array2(g_ref_fields,"SELECT ooail003 FROM ooail_t WHERE ooailent='"||g_enterprise||"' AND ooail001=? AND ooail002='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_xccd_m.xccd001_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_xccd_m.xccd001_desc      
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
PRIVATE FUNCTION axcq540_cre_tmp_table()
   DEFINE r_success       LIKE type_t.num5

   WHENEVER ERROR CONTINUE
   LET r_success = TRUE

   #检查事务中
   IF NOT s_transaction_chk('N',1) THEN
      LET r_success = FALSE
      RETURN r_success
   END IF

   DROP TABLE axcq540_tmp01;
   CREATE TEMP TABLE axcq540_tmp01(
       sfaa068  VARCHAR(10), 
       sfaa068_desc  VARCHAR(500), 
       xccd006  VARCHAR(20), 
       xccd007  VARCHAR(40),        #fengmy150303
       xccd008  VARCHAR(256),        #liuym150810
       xccd301  DECIMAL(20,6),        #151202-00029 by whitney add
       xcce007  VARCHAR(40), 
       xcce007_desc  VARCHAR(500), 
       xcce007_desc_1  VARCHAR(500), 
       xcce008  VARCHAR(256), 
       xcce009  VARCHAR(30), 
       xcbb005  VARCHAR(10), 
       xcbb005_desc  VARCHAR(500), 
       xccd002  VARCHAR(30), 
       xcce101  DECIMAL(20,6), 
       xcce102  DECIMAL(20,6), 
       xcce201  DECIMAL(20,6), 
       xcce202  DECIMAL(20,6), 
       xcce301  DECIMAL(20,6), 
       xcce302  DECIMAL(20,6), 
       xcce303  DECIMAL(20,6), 
       xcce304  DECIMAL(20,6), 
       xcce307  DECIMAL(20,6), 
       xcce308  DECIMAL(20,6), 
       xcce901  DECIMAL(20,6), 
       xcce902  DECIMAL(20,6)
       );

   IF SQLCA.sqlcode THEN
      LET r_success = FALSE
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = 'create tmp01'
      LET g_errparam.popup = TRUE
      CALL cl_err()

      RETURN r_success
   END IF
   
   DROP TABLE axcq540_tmp02;
   CREATE TEMP TABLE axcq540_tmp02(
       sfaa068  VARCHAR(10), 
       sfaa068_2_desc  VARCHAR(500), 
       xcce006  VARCHAR(20), 
       xccd007  VARCHAR(40),        #fengmy150303
       xccd008  VARCHAR(256),        #liuym150810
       xccd301  DECIMAL(20,6),        #151202-00029 by whitney add
       xcce007  VARCHAR(40), 
       xcce007_2_desc  VARCHAR(500), 
       xcce007_2_desc_1  VARCHAR(500), 
       xcce008  VARCHAR(256), 
       xcce009  VARCHAR(30), 
       xcbb005  VARCHAR(10), 
       xcbb005_2_desc  VARCHAR(500), 
       xcce002  VARCHAR(30), 
       xcce101  DECIMAL(20,6), 
       xcce102a  DECIMAL(20,6), 
       xcce102b  DECIMAL(20,6), 
       xcce102c  DECIMAL(20,6), 
       xcce102d  DECIMAL(20,6), 
       xcce102e  DECIMAL(20,6), 
       xcce102f  DECIMAL(20,6), 
       xcce102g  DECIMAL(20,6), 
       xcce102h  DECIMAL(20,6), 
       xcce102  DECIMAL(20,6), 
       xcce201  DECIMAL(20,6), 
       xcce202a  DECIMAL(20,6), 
       xcce202b  DECIMAL(20,6), 
       xcce202c  DECIMAL(20,6), 
       xcce202d  DECIMAL(20,6), 
       xcce202e  DECIMAL(20,6), 
       xcce202f  DECIMAL(20,6), 
       xcce202g  DECIMAL(20,6), 
       xcce202h  DECIMAL(20,6), 
       xcce202  DECIMAL(20,6), 
       xcce301  DECIMAL(20,6), 
       xcce302a  DECIMAL(20,6), 
       xcce302b  DECIMAL(20,6), 
       xcce302c  DECIMAL(20,6), 
       xcce302d  DECIMAL(20,6), 
       xcce302e  DECIMAL(20,6), 
       xcce302f  DECIMAL(20,6), 
       xcce302g  DECIMAL(20,6), 
       xcce302h  DECIMAL(20,6), 
       xcce302  DECIMAL(20,6), 
       xcce303  DECIMAL(20,6), 
       xcce304a  DECIMAL(20,6), 
       xcce304b  DECIMAL(20,6), 
       xcce304c  DECIMAL(20,6), 
       xcce304d  DECIMAL(20,6), 
       xcce304e  DECIMAL(20,6), 
       xcce304f  DECIMAL(20,6), 
       xcce304g  DECIMAL(20,6), 
       xcce304h  DECIMAL(20,6), 
       xcce304  DECIMAL(20,6), 
       xcce307  DECIMAL(20,6), 
       xcce308a  DECIMAL(20,6), 
       xcce308b  DECIMAL(20,6), 
       xcce308c  DECIMAL(20,6), 
       xcce308d  DECIMAL(20,6), 
       xcce308e  DECIMAL(20,6), 
       xcce308f  DECIMAL(20,6), 
       xcce308g  DECIMAL(20,6), 
       xcce308h  DECIMAL(20,6), 
       xcce308  DECIMAL(20,6), 
       xcce901  DECIMAL(20,6), 
       xcce902a  DECIMAL(20,6), 
       xcce902b  DECIMAL(20,6), 
       xcce902c  DECIMAL(20,6), 
       xcce902d  DECIMAL(20,6), 
       xcce902e  DECIMAL(20,6), 
       xcce902f  DECIMAL(20,6), 
       xcce902g  DECIMAL(20,6), 
       xcce902h  DECIMAL(20,6), 
       xcce902  DECIMAL(20,6)
       );


   IF SQLCA.sqlcode THEN
      LET r_success = FALSE
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = 'create tmp02'
      LET g_errparam.popup = TRUE
      CALL cl_err()

      RETURN r_success
   END IF
   
   
   DROP TABLE axcq540_tmp03;
   CREATE TEMP TABLE axcq540_tmp03(                        
       sfaa068  VARCHAR(10), 
       sfaa068_2_desc  VARCHAR(500), 
       xcci006  VARCHAR(20), 
       xcch007  VARCHAR(40),        #fengmy150303
       xcch008  VARCHAR(256),        #liuym150810
       xcch301  DECIMAL(20,6),        #151202-00029 by whitney add
       xcci007  VARCHAR(40), 
       xcci007_2_desc  VARCHAR(500), 
       xcci007_2_desc_1  VARCHAR(500), 
       xcci008  VARCHAR(256), 
       xcci009  VARCHAR(30), 
       xcbb005  VARCHAR(10), 
       xcbb005_2_desc  VARCHAR(500), 
       xcci002  VARCHAR(30), 
       xcci101  DECIMAL(20,6), 
       xcci102a  DECIMAL(20,6), 
       xcci102b  DECIMAL(20,6), 
       xcci102c  DECIMAL(20,6), 
       xcci102d  DECIMAL(20,6), 
       xcci102e  DECIMAL(20,6), 
       xcci102f  DECIMAL(20,6), 
       xcci102g  DECIMAL(20,6), 
       xcci102h  DECIMAL(20,6), 
       xcci102  DECIMAL(20,6), 
       xcci201  DECIMAL(20,6), 
       xcci202a  DECIMAL(20,6), 
       xcci202b  DECIMAL(20,6), 
       xcci202c  DECIMAL(20,6), 
       xcci202d  DECIMAL(20,6), 
       xcci202e  DECIMAL(20,6), 
       xcci202f  DECIMAL(20,6), 
       xcci202g  DECIMAL(20,6), 
       xcci202h  DECIMAL(20,6), 
       xcci202  DECIMAL(20,6), 
       xcci301  DECIMAL(20,6), 
       xcci302a  DECIMAL(20,6), 
       xcci302b  DECIMAL(20,6), 
       xcci302c  DECIMAL(20,6), 
       xcci302d  DECIMAL(20,6), 
       xcci302e  DECIMAL(20,6), 
       xcci302f  DECIMAL(20,6), 
       xcci302g  DECIMAL(20,6), 
       xcci302h  DECIMAL(20,6), 
       xcci302  DECIMAL(20,6), 
       xcci303  DECIMAL(20,6), 
       xcci304a  DECIMAL(20,6), 
       xcci304b  DECIMAL(20,6), 
       xcci304c  DECIMAL(20,6), 
       xcci304d  DECIMAL(20,6), 
       xcci304e  DECIMAL(20,6), 
       xcci304f  DECIMAL(20,6), 
       xcci304g  DECIMAL(20,6), 
       xcci304h  DECIMAL(20,6), 
       xcci304  DECIMAL(20,6),  
       xcci901  DECIMAL(20,6), 
       xcci902a  DECIMAL(20,6), 
       xcci902b  DECIMAL(20,6), 
       xcci902c  DECIMAL(20,6), 
       xcci902d  DECIMAL(20,6), 
       xcci902e  DECIMAL(20,6), 
       xcci902f  DECIMAL(20,6), 
       xcci902g  DECIMAL(20,6), 
       xcci902h  DECIMAL(20,6), 
       xcci902  DECIMAL(20,6)
       );                         

   IF SQLCA.sqlcode THEN
      LET r_success = FALSE
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = 'create tmp03'
      LET g_errparam.popup = TRUE
      CALL cl_err()

      RETURN r_success
   END IF
#2015/3/27 ouhz add------begin----
  DROP TABLE axcq540_tmp04;
   CREATE TEMP TABLE axcq540_tmp04(
       sfaa068  VARCHAR(10), 
       sfaa068_desc  VARCHAR(500), 
       xccd006  VARCHAR(20), 
       xccd007  VARCHAR(40),   
       xcce007  VARCHAR(40), 
       xcce007_desc  VARCHAR(500), 
       xcce007_desc_1  VARCHAR(500), 
       xcce008  VARCHAR(256), 
       xcce009  VARCHAR(30), 
       xcbb005  VARCHAR(10), 
       xcbb005_desc  VARCHAR(500), 
       xccd002  VARCHAR(30), 
       xcce101  DECIMAL(20,6), 
       xcce102  DECIMAL(20,6), 
       xcce201  DECIMAL(20,6), 
       xcce202  DECIMAL(20,6), 
       xcce301  DECIMAL(20,6), 
       xcce302  DECIMAL(20,6), 
       xcce303  DECIMAL(20,6), 
       xcce304  DECIMAL(20,6), 
       xcce307  DECIMAL(20,6), 
       xcce308  DECIMAL(20,6), 
       xcce901  DECIMAL(20,6), 
       xcce902  DECIMAL(20,6)
       );

   IF SQLCA.sqlcode THEN
      LET r_success = FALSE
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = 'create tmp04'
      LET g_errparam.popup = TRUE
      CALL cl_err()

      RETURN r_success
   END IF  
#2015/3/27 ouhz add------end------
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
PRIVATE FUNCTION axcq540_drop_tmp_table()
   WHENEVER ERROR CONTINUE

   #检查事务中
   IF NOT s_transaction_chk('N',1) THEN
      RETURN 
   END IF
   
   #刪除TEMP TABLE
   DROP TABLE axcq540_tmp01
   DROP TABLE axcq540_tmp02
   DROP TABLE axcq540_tmp03
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
PRIVATE FUNCTION axcq540_ins_xckk()
   DEFINE l_cnt                    LIKE type_t.num10
   DEFINE l_sum_xcce102a          LIKE xcce_t.xcce102a
   DEFINE l_sum_xcce102b          LIKE xcce_t.xcce102b
   DEFINE l_sum_xcce102c          LIKE xcce_t.xcce102c
   DEFINE l_sum_xcce102d          LIKE xcce_t.xcce102d
   DEFINE l_sum_xcce102e          LIKE xcce_t.xcce102e
   DEFINE l_sum_xcce102f          LIKE xcce_t.xcce102f
   DEFINE l_sum_xcce102g          LIKE xcce_t.xcce102g
   DEFINE l_sum_xcce102h          LIKE xcce_t.xcce102h
   DEFINE l_sum_xcce101           LIKE xcce_t.xcce101
   DEFINE l_sum_xcce102           LIKE xcce_t.xcce102 
   DEFINE l_sum_xcce202a          LIKE xcce_t.xcce202a
   DEFINE l_sum_xcce202b          LIKE xcce_t.xcce202b
   DEFINE l_sum_xcce202c          LIKE xcce_t.xcce202c
   DEFINE l_sum_xcce202d          LIKE xcce_t.xcce202d
   DEFINE l_sum_xcce202e          LIKE xcce_t.xcce202e
   DEFINE l_sum_xcce202f          LIKE xcce_t.xcce202f
   DEFINE l_sum_xcce202g          LIKE xcce_t.xcce202g
   DEFINE l_sum_xcce202h          LIKE xcce_t.xcce202h
   DEFINE l_sum_xcce201           LIKE xcce_t.xcce201
   DEFINE l_sum_xcce202           LIKE xcce_t.xcce202 
   DEFINE l_sum_xcce302a          LIKE xcce_t.xcce302a
   DEFINE l_sum_xcce302b          LIKE xcce_t.xcce302b
   DEFINE l_sum_xcce302c          LIKE xcce_t.xcce302c
   DEFINE l_sum_xcce302d          LIKE xcce_t.xcce302d
   DEFINE l_sum_xcce302e          LIKE xcce_t.xcce302e
   DEFINE l_sum_xcce302f          LIKE xcce_t.xcce302f
   DEFINE l_sum_xcce302g          LIKE xcce_t.xcce302g
   DEFINE l_sum_xcce302h          LIKE xcce_t.xcce302h
   DEFINE l_sum_xcce301           LIKE xcce_t.xcce301
   DEFINE l_sum_xcce302           LIKE xcce_t.xcce302 
   DEFINE l_sum_xcce304a          LIKE xcce_t.xcce304a
   DEFINE l_sum_xcce304b          LIKE xcce_t.xcce304b
   DEFINE l_sum_xcce304c          LIKE xcce_t.xcce304c
   DEFINE l_sum_xcce304d          LIKE xcce_t.xcce304d
   DEFINE l_sum_xcce304e          LIKE xcce_t.xcce304e
   DEFINE l_sum_xcce304f          LIKE xcce_t.xcce304f
   DEFINE l_sum_xcce304g          LIKE xcce_t.xcce304g
   DEFINE l_sum_xcce304h          LIKE xcce_t.xcce304h
   DEFINE l_sum_xcce303           LIKE xcce_t.xcce303
   DEFINE l_sum_xcce304           LIKE xcce_t.xcce304 
   DEFINE l_sum_xcce308a          LIKE xcce_t.xcce308a
   DEFINE l_sum_xcce308b          LIKE xcce_t.xcce308b
   DEFINE l_sum_xcce308c          LIKE xcce_t.xcce308c
   DEFINE l_sum_xcce308d          LIKE xcce_t.xcce308d
   DEFINE l_sum_xcce308e          LIKE xcce_t.xcce308e
   DEFINE l_sum_xcce308f          LIKE xcce_t.xcce308f
   DEFINE l_sum_xcce308g          LIKE xcce_t.xcce308g
   DEFINE l_sum_xcce308h          LIKE xcce_t.xcce308h
   DEFINE l_sum_xcce307           LIKE xcce_t.xcce307
   DEFINE l_sum_xcce308           LIKE xcce_t.xcce308 
   DEFINE l_sum_xcce902a          LIKE xcce_t.xcce902a
   DEFINE l_sum_xcce902b          LIKE xcce_t.xcce902b
   DEFINE l_sum_xcce902c          LIKE xcce_t.xcce902c
   DEFINE l_sum_xcce902d          LIKE xcce_t.xcce902d
   DEFINE l_sum_xcce902e          LIKE xcce_t.xcce902e
   DEFINE l_sum_xcce902f          LIKE xcce_t.xcce902f
   DEFINE l_sum_xcce902g          LIKE xcce_t.xcce902g
   DEFINE l_sum_xcce902h          LIKE xcce_t.xcce902h
   DEFINE l_sum_xcce901           LIKE xcce_t.xcce901
   DEFINE l_sum_xcce902           LIKE xcce_t.xcce902 
   DEFINE l_sum_xcci102a          LIKE xcci_t.xcci102a
   DEFINE l_sum_xcci102b          LIKE xcci_t.xcci102b
   DEFINE l_sum_xcci102c          LIKE xcci_t.xcci102c
   DEFINE l_sum_xcci102d          LIKE xcci_t.xcci102d
   DEFINE l_sum_xcci102e          LIKE xcci_t.xcci102e
   DEFINE l_sum_xcci102f          LIKE xcci_t.xcci102f
   DEFINE l_sum_xcci102g          LIKE xcci_t.xcci102g
   DEFINE l_sum_xcci102h          LIKE xcci_t.xcci102h
   DEFINE l_sum_xcci101           LIKE xcci_t.xcci101
   DEFINE l_sum_xcci102           LIKE xcci_t.xcci102
   DEFINE l_sum_xcci202a          LIKE xcci_t.xcci202a   
   DEFINE l_sum_xcci202b          LIKE xcci_t.xcci202b
   DEFINE l_sum_xcci202c          LIKE xcci_t.xcci202c
   DEFINE l_sum_xcci202d          LIKE xcci_t.xcci202d
   DEFINE l_sum_xcci202e          LIKE xcci_t.xcci202e
   DEFINE l_sum_xcci202f          LIKE xcci_t.xcci202f
   DEFINE l_sum_xcci202g          LIKE xcci_t.xcci202g
   DEFINE l_sum_xcci202h          LIKE xcci_t.xcci202h
   DEFINE l_sum_xcci201           LIKE xcci_t.xcci201
   DEFINE l_sum_xcci202           LIKE xcci_t.xcci202 
   DEFINE l_sum_xcci302a          LIKE xcci_t.xcci302a
   DEFINE l_sum_xcci302b          LIKE xcci_t.xcci302b
   DEFINE l_sum_xcci302c          LIKE xcci_t.xcci302c
   DEFINE l_sum_xcci302d          LIKE xcci_t.xcci302d
   DEFINE l_sum_xcci302e          LIKE xcci_t.xcci302e
   DEFINE l_sum_xcci302f          LIKE xcci_t.xcci302f
   DEFINE l_sum_xcci302g          LIKE xcci_t.xcci302g
   DEFINE l_sum_xcci302h          LIKE xcci_t.xcci302h
   DEFINE l_sum_xcci301           LIKE xcci_t.xcci301
   DEFINE l_sum_xcci302           LIKE xcci_t.xcci302 
   DEFINE l_sum_xcci304a          LIKE xcci_t.xcci304a
   DEFINE l_sum_xcci304b          LIKE xcci_t.xcci304b
   DEFINE l_sum_xcci304c          LIKE xcci_t.xcci304c
   DEFINE l_sum_xcci304d          LIKE xcci_t.xcci304d
   DEFINE l_sum_xcci304e          LIKE xcci_t.xcci304e
   DEFINE l_sum_xcci304f          LIKE xcci_t.xcci304f
   DEFINE l_sum_xcci304g          LIKE xcci_t.xcci304g
   DEFINE l_sum_xcci304h          LIKE xcci_t.xcci304h
   DEFINE l_sum_xcci303           LIKE xcci_t.xcci303
   DEFINE l_sum_xcci304           LIKE xcci_t.xcci304  
   DEFINE l_sum_xcci902a          LIKE xcci_t.xcci902a
   DEFINE l_sum_xcci902b          LIKE xcci_t.xcci902b
   DEFINE l_sum_xcci902c          LIKE xcci_t.xcci902c
   DEFINE l_sum_xcci902d          LIKE xcci_t.xcci902d
   DEFINE l_sum_xcci902e          LIKE xcci_t.xcci902e
   DEFINE l_sum_xcci902f          LIKE xcci_t.xcci902f
   DEFINE l_sum_xcci902g          LIKE xcci_t.xcci902g
   DEFINE l_sum_xcci902h          LIKE xcci_t.xcci902h
   DEFINE l_sum_xcci901           LIKE xcci_t.xcci901
   DEFINE l_sum_xcci902           LIKE xcci_t.xcci902 

   RETURN
         IF g_xccd2_d.getLength() = 0 AND g_xccd3_d.getLength() = 0 THEN RETURN END IF
#先判断单头条件是否存在与axci601的设置资料里，不存在则退出
#再判断是否已有重复单头资料的xckk/xckl，提示是否删除，若不删除，则退出

#2015/10/16 by stellar mark ----- (S)
#stellar mark:s_axcq004_upd_xckk已沒在使用
#      IF NOT s_axcq004_upd_xckk_chk_del('2',                                     #type         传入更新类型 1：axcq004更新总报表 2：子查询作业更新分项报表
#                                        g_enterprise,                            #xckkent      传入企业编号
#                                        g_xccd_m.xccdcomp,                       #xckkcomp     传入法人
#                                        g_xccd_m.xccdld,                         #xckkld       传入账套
#                                        g_xccd_m.xccd004,                        #xckk003      传入年度
#                                        g_xccd_m.xccd005,                        #xckk004      传入期别
#                                        g_prog,                                  #xckk005      传入程序代号
#                                        g_xccd_m.xccd003,                        #xckk006      传入成本计算类型
#                                        g_xccd_m.xccd001)                        #xckk007      传入本位币顺序
#      THEN
#         RETURN
#      END IF
#2015/10/16 by stellar mark ----- (E)

#xckk是勾稽表的，对应单头范围，所以它接受的金额数量是当前单头下的总计，xckl是细分到明细的勾稽表，对应到每一笔单身  
#以下是第二单身，在制明细
      IF g_xccd2_d.getLength() = 0 THEN RETURN END IF   
      SELECT  SUM(xcce102a),
              SUM(xcce102b),
              SUM(xcce102c),
              SUM(xcce102d),
              SUM(xcce102e),
              SUM(xcce102f),
              SUM(xcce102g),
              SUM(xcce102h),
              SUM(xcce101), 
              SUM(xcce102), 
              SUM(xcce202a),
              SUM(xcce202b),
              SUM(xcce202c),
              SUM(xcce202d),
              SUM(xcce202e),
              SUM(xcce202f),
              SUM(xcce202g),
              SUM(xcce202h),
              SUM(xcce201), 
              SUM(xcce202), 
              SUM(xcce302a),
              SUM(xcce302b),
              SUM(xcce302c),
              SUM(xcce302d),
              SUM(xcce302e),
              SUM(xcce302f),
              SUM(xcce302g),
              SUM(xcce302h),
              SUM(xcce301), 
              SUM(xcce302), 
              SUM(xcce304a),
              SUM(xcce304b),
              SUM(xcce304c),
              SUM(xcce304d),
              SUM(xcce304e),
              SUM(xcce304f),
              SUM(xcce304g),
              SUM(xcce304h),
              SUM(xcce303), 
              SUM(xcce304), 
              SUM(xcce308a),
              SUM(xcce308b),
              SUM(xcce308c),
              SUM(xcce308d),
              SUM(xcce308e),
              SUM(xcce308f),
              SUM(xcce308g),
              SUM(xcce308h),
              SUM(xcce307), 
              SUM(xcce308), 
              SUM(xcce902a),
              SUM(xcce902b),
              SUM(xcce902c),
              SUM(xcce902d),
              SUM(xcce902e),
              SUM(xcce902f),
              SUM(xcce902g),
              SUM(xcce902h),
              SUM(xcce901), 
              SUM(xcce902)
         INTO l_sum_xcce102a, 
              l_sum_xcce102b, 
              l_sum_xcce102c, 
              l_sum_xcce102d, 
              l_sum_xcce102e, 
              l_sum_xcce102f, 
              l_sum_xcce102g, 
              l_sum_xcce102h, 
              l_sum_xcce101, 
              l_sum_xcce102, 
              l_sum_xcce202a, 
              l_sum_xcce202b, 
              l_sum_xcce202c, 
              l_sum_xcce202d, 
              l_sum_xcce202e, 
              l_sum_xcce202f, 
              l_sum_xcce202g, 
              l_sum_xcce202h, 
              l_sum_xcce201, 
              l_sum_xcce202, 
              l_sum_xcce302a, 
              l_sum_xcce302b, 
              l_sum_xcce302c, 
              l_sum_xcce302d, 
              l_sum_xcce302e, 
              l_sum_xcce302f, 
              l_sum_xcce302g, 
              l_sum_xcce302h, 
              l_sum_xcce301, 
              l_sum_xcce302, 
              l_sum_xcce304a, 
              l_sum_xcce304b, 
              l_sum_xcce304c, 
              l_sum_xcce304d, 
              l_sum_xcce304e, 
              l_sum_xcce304f, 
              l_sum_xcce304g, 
              l_sum_xcce304h, 
              l_sum_xcce303, 
              l_sum_xcce304, 
              l_sum_xcce308a, 
              l_sum_xcce308b, 
              l_sum_xcce308c, 
              l_sum_xcce308d, 
              l_sum_xcce308e, 
              l_sum_xcce308f, 
              l_sum_xcce308g, 
              l_sum_xcce308h, 
              l_sum_xcce307, 
              l_sum_xcce308, 
              l_sum_xcce902a, 
              l_sum_xcce902b, 
              l_sum_xcce902c, 
              l_sum_xcce902d, 
              l_sum_xcce902e, 
              l_sum_xcce902f, 
              l_sum_xcce902g, 
              l_sum_xcce902h, 
              l_sum_xcce901, 
              l_sum_xcce902  
         FROM xcce_t
        WHERE xcceent  = g_enterprise
          AND xccecomp = g_xccd_m.xccdcomp
          AND xcceld   = g_xccd_m.xccdld
          AND xcce001  = g_xccd_m.xccd001
          AND xcce003  = g_xccd_m.xccd003
          AND xcce004  = g_xccd_m.xccd004
          AND xcce005  = g_xccd_m.xccd005
 
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "sel_xcce_ins_xckk" 
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = TRUE 
         CALL cl_err() 
         RETURN
      END IF

      FOR l_cnt = 1 TO g_xccd2_d.getLength()
         IF g_xccd2_d[l_ac].xcce007 IS NULL THEN    #排除小计/总计行 小计总计行后面元件栏位是空的
            CONTINUE FOR
         END IF
#2015/10/16 by stellar mark ----- (S)
#stellar mark:s_axcq004_upd_xckk已沒在使用
##期初在制   xcce101,xcce102         
#         IF NOT s_axcq004_upd_xckk('2',                                     #type         传入更新类型 1：axcq004更新总报表 2：子查询作业更新分项报表
#                                   g_enterprise,                            #xckkent      传入企业编号
#                                   g_xccd_m.xccdcomp,                       #xckkcomp     传入法人
#                                   g_xccd_m.xccdld,                         #xckkld       传入账套
#                                   '201',                                   #xckk001      传入类型代码
#                                   g_xccd_m.xccd004,                        #xckk003      传入年度
#                                   g_xccd_m.xccd005,                        #xckk004      传入期别
#                                   g_prog,                                  #xckk005      传入程序代号
#                                   g_xccd_m.xccd003,                        #xckk006      传入成本计算类型
#                                   g_xccd_m.xccd001,                        #xckk007      传入本位币顺序
#                                   l_sum_xcce101,                           #xckk103      传入总表/分项报表数量
#                                   l_sum_xcce102,                           #xckk104      传入总表/分项报表金额
#                                   l_sum_xcce102a,                          #xckk104a     传入总表/分项报表金额-材料
#                                   l_sum_xcce102b,                          #xckk104b     传入总表/分项报表金额-人工
#                                   l_sum_xcce102c,                          #xckk104c     传入总表/分项报表金额-加工
#                                   l_sum_xcce102d,                          #xckk104d     传入总表/分项报表金额-制费一
#                                   l_sum_xcce102e,                          #xckk104e     传入总表/分项报表金额-制费二
#                                   l_sum_xcce102f,                          #xckk104f     传入总表/分项报表金额-制费三
#                                   l_sum_xcce102g,                          #xckk104g     传入总表/分项报表金额-制费四
#                                   l_sum_xcce102h,                          #xckk104h     传入总表/分项报表金额-制费五
#                                   g_xccd2_d[l_cnt].xcce006,                #xckl007      传入成本勾稽明细表-单据编号
#                                   '',                                      #xckl008      传入成本勾稽明细表-项次
#                                   '',                                      #xckl009      传入成本勾稽明细表-序号
#                                   g_xccd2_d[l_cnt].xcce007,                #xckl010      传入成本勾稽明细表-料件
#                                   g_xccd2_d[l_cnt].xcce008,                #xckl011      传入成本勾稽明细表-特性
#                                   g_xccd2_d[l_cnt].xcce009,                #xckl012      传入成本勾稽明细表-批号
#                                   g_xccd2_d[l_cnt].xcce101,                #xckl014      传入成本勾稽明细表-数量
#                                   g_xccd2_d[l_cnt].xcce102)                #xckl015      传入成本勾稽明细表-金额
#           THEN
#            EXIT FOR
#         END IF
##本期在制投入-材料  xcce201  xcce202a
#         IF NOT s_axcq004_upd_xckk('2',                                     #type         传入更新类型 1：axcq004更新总报表 2：子查询作业更新分项报表
#                                   g_enterprise,                            #xckkent      传入企业编号
#                                   g_xccd_m.xccdcomp,                       #xckkcomp     传入法人
#                                   g_xccd_m.xccdld,                         #xckkld       传入账套
#                                   '202',                                   #xckk001      传入类型代码
#                                   g_xccd_m.xccd004,                        #xckk003      传入年度
#                                   g_xccd_m.xccd005,                        #xckk004      传入期别
#                                   g_prog,                                  #xckk005      传入程序代号
#                                   g_xccd_m.xccd003,                        #xckk006      传入成本计算类型
#                                   g_xccd_m.xccd001,                        #xckk007      传入本位币顺序
#                                   l_sum_xcce201,                           #xckk103      传入总表/分项报表数量
#                                   l_sum_xcce202a,                          #xckk104      传入总表/分项报表金额
#                                   l_sum_xcce202a,                          #xckk104a     传入总表/分项报表金额-材料
#                                   0,                                       #xckk104b     传入总表/分项报表金额-人工
#                                   0,                                       #xckk104c     传入总表/分项报表金额-加工
#                                   0,                                       #xckk104d     传入总表/分项报表金额-制费一
#                                   0,                                       #xckk104e     传入总表/分项报表金额-制费二
#                                   0,                                       #xckk104f     传入总表/分项报表金额-制费三
#                                   0,                                       #xckk104g     传入总表/分项报表金额-制费四
#                                   0,                                       #xckk104h     传入总表/分项报表金额-制费五
#                                   g_xccd2_d[l_cnt].xcce006,                #xckl007      传入成本勾稽明细表-单据编号
#                                   '',                                      #xckl008      传入成本勾稽明细表-项次
#                                   '',                                      #xckl009      传入成本勾稽明细表-序号
#                                   g_xccd2_d[l_cnt].xcce007,                #xckl010      传入成本勾稽明细表-料件
#                                   g_xccd2_d[l_cnt].xcce008,                #xckl011      传入成本勾稽明细表-特性
#                                   g_xccd2_d[l_cnt].xcce009,                #xckl012      传入成本勾稽明细表-批号
#                                   g_xccd2_d[l_cnt].xcce201,                #xckl014      传入成本勾稽明细表-数量
#                                   g_xccd2_d[l_cnt].xcce202a)               #xckl015      传入成本勾稽明细表-金额
#           THEN
#            EXIT FOR
#         END IF
#
##本期在制投入-人工  xcce201  xcce202b
#         IF NOT s_axcq004_upd_xckk('2',                                     #type         传入更新类型 1：axcq004更新总报表 2：子查询作业更新分项报表
#                                   g_enterprise,                            #xckkent      传入企业编号
#                                   g_xccd_m.xccdcomp,                       #xckkcomp     传入法人
#                                   g_xccd_m.xccdld,                         #xckkld       传入账套
#                                   '203',                                   #xckk001      传入类型代码
#                                   g_xccd_m.xccd004,                        #xckk003      传入年度
#                                   g_xccd_m.xccd005,                        #xckk004      传入期别
#                                   g_prog,                                  #xckk005      传入程序代号
#                                   g_xccd_m.xccd003,                        #xckk006      传入成本计算类型
#                                   g_xccd_m.xccd001,                        #xckk007      传入本位币顺序
#                                   l_sum_xcce201,                           #xckk103      传入总表/分项报表数量
#                                   l_sum_xcce202b,                          #xckk104      传入总表/分项报表金额
#                                   0,                                       #xckk104a     传入总表/分项报表金额-材料
#                                   l_sum_xcce202b,                          #xckk104b     传入总表/分项报表金额-人工
#                                   0,                                       #xckk104c     传入总表/分项报表金额-加工
#                                   0,                                       #xckk104d     传入总表/分项报表金额-制费一
#                                   0,                                       #xckk104e     传入总表/分项报表金额-制费二
#                                   0,                                       #xckk104f     传入总表/分项报表金额-制费三
#                                   0,                                       #xckk104g     传入总表/分项报表金额-制费四
#                                   0,                                       #xckk104h     传入总表/分项报表金额-制费五
#                                   g_xccd2_d[l_cnt].xcce006,                #xckl007      传入成本勾稽明细表-单据编号
#                                   '',                                      #xckl008      传入成本勾稽明细表-项次
#                                   '',                                      #xckl009      传入成本勾稽明细表-序号
#                                   g_xccd2_d[l_cnt].xcce007,                #xckl010      传入成本勾稽明细表-料件
#                                   g_xccd2_d[l_cnt].xcce008,                #xckl011      传入成本勾稽明细表-特性
#                                   g_xccd2_d[l_cnt].xcce009,                #xckl012      传入成本勾稽明细表-批号
#                                   g_xccd2_d[l_cnt].xcce201,                #xckl014      传入成本勾稽明细表-数量
#                                   g_xccd2_d[l_cnt].xcce202b)               #xckl015      传入成本勾稽明细表-金额
#           THEN
#            EXIT FOR
#         END IF
#         
##本期在制投入-加工  xcce201  xcce202c
#         IF NOT s_axcq004_upd_xckk('2',                                     #type         传入更新类型 1：axcq004更新总报表 2：子查询作业更新分项报表
#                                   g_enterprise,                            #xckkent      传入企业编号
#                                   g_xccd_m.xccdcomp,                       #xckkcomp     传入法人
#                                   g_xccd_m.xccdld,                         #xckkld       传入账套
#                                   '209',                                   #xckk001      传入类型代码
#                                   g_xccd_m.xccd004,                        #xckk003      传入年度
#                                   g_xccd_m.xccd005,                        #xckk004      传入期别
#                                   g_prog,                                  #xckk005      传入程序代号
#                                   g_xccd_m.xccd003,                        #xckk006      传入成本计算类型
#                                   g_xccd_m.xccd001,                        #xckk007      传入本位币顺序
#                                   l_sum_xcce201,                           #xckk103      传入总表/分项报表数量
#                                   l_sum_xcce202c,                          #xckk104      传入总表/分项报表金额
#                                   0,                                       #xckk104a     传入总表/分项报表金额-材料
#                                   0,                                       #xckk104b     传入总表/分项报表金额-人工
#                                   l_sum_xcce202c,                          #xckk104c     传入总表/分项报表金额-加工
#                                   0,                                       #xckk104d     传入总表/分项报表金额-制费一
#                                   0,                                       #xckk104e     传入总表/分项报表金额-制费二
#                                   0,                                       #xckk104f     传入总表/分项报表金额-制费三
#                                   0,                                       #xckk104g     传入总表/分项报表金额-制费四
#                                   0,                                       #xckk104h     传入总表/分项报表金额-制费五
#                                   g_xccd2_d[l_cnt].xcce006,                #xckl007      传入成本勾稽明细表-单据编号
#                                   '',                                      #xckl008      传入成本勾稽明细表-项次
#                                   '',                                      #xckl009      传入成本勾稽明细表-序号
#                                   g_xccd2_d[l_cnt].xcce007,                #xckl010      传入成本勾稽明细表-料件
#                                   g_xccd2_d[l_cnt].xcce008,                #xckl011      传入成本勾稽明细表-特性
#                                   g_xccd2_d[l_cnt].xcce009,                #xckl012      传入成本勾稽明细表-批号
#                                   g_xccd2_d[l_cnt].xcce201,                #xckl014      传入成本勾稽明细表-数量
#                                   g_xccd2_d[l_cnt].xcce202c)               #xckl015      传入成本勾稽明细表-金额
#           THEN
#            EXIT FOR
#         END IF
#         
##本期在制投入-制费一  xcce201  xcce202d
#         IF NOT s_axcq004_upd_xckk('2',                                     #type         传入更新类型 1：axcq004更新总报表 2：子查询作业更新分项报表
#                                   g_enterprise,                            #xckkent      传入企业编号
#                                   g_xccd_m.xccdcomp,                       #xckkcomp     传入法人
#                                   g_xccd_m.xccdld,                         #xckkld       传入账套
#                                   '204',                                   #xckk001      传入类型代码
#                                   g_xccd_m.xccd004,                        #xckk003      传入年度
#                                   g_xccd_m.xccd005,                        #xckk004      传入期别
#                                   g_prog,                                  #xckk005      传入程序代号
#                                   g_xccd_m.xccd003,                        #xckk006      传入成本计算类型
#                                   g_xccd_m.xccd001,                        #xckk007      传入本位币顺序
#                                   l_sum_xcce201,                           #xckk103      传入总表/分项报表数量
#                                   l_sum_xcce202d,                          #xckk104      传入总表/分项报表金额
#                                   0,                                       #xckk104a     传入总表/分项报表金额-材料
#                                   0,                                       #xckk104b     传入总表/分项报表金额-人工
#                                   0,                                       #xckk104c     传入总表/分项报表金额-加工
#                                   l_sum_xcce202d,                          #xckk104d     传入总表/分项报表金额-制费一
#                                   0,                                       #xckk104e     传入总表/分项报表金额-制费二
#                                   0,                                       #xckk104f     传入总表/分项报表金额-制费三
#                                   0,                                       #xckk104g     传入总表/分项报表金额-制费四
#                                   0,                                       #xckk104h     传入总表/分项报表金额-制费五
#                                   g_xccd2_d[l_cnt].xcce006,                #xckl007      传入成本勾稽明细表-单据编号
#                                   '',                                      #xckl008      传入成本勾稽明细表-项次
#                                   '',                                      #xckl009      传入成本勾稽明细表-序号
#                                   g_xccd2_d[l_cnt].xcce007,                #xckl010      传入成本勾稽明细表-料件
#                                   g_xccd2_d[l_cnt].xcce008,                #xckl011      传入成本勾稽明细表-特性
#                                   g_xccd2_d[l_cnt].xcce009,                #xckl012      传入成本勾稽明细表-批号
#                                   g_xccd2_d[l_cnt].xcce201,                #xckl014      传入成本勾稽明细表-数量
#                                   g_xccd2_d[l_cnt].xcce202d)               #xckl015      传入成本勾稽明细表-金额
#           THEN
#            EXIT FOR
#         END IF
#         
##本期在制投入-制费二  xcce201  xcce202e
#         IF NOT s_axcq004_upd_xckk('2',                                     #type         传入更新类型 1：axcq004更新总报表 2：子查询作业更新分项报表
#                                   g_enterprise,                            #xckkent      传入企业编号
#                                   g_xccd_m.xccdcomp,                       #xckkcomp     传入法人
#                                   g_xccd_m.xccdld,                         #xckkld       传入账套
#                                   '205',                                   #xckk001      传入类型代码
#                                   g_xccd_m.xccd004,                        #xckk003      传入年度
#                                   g_xccd_m.xccd005,                        #xckk004      传入期别
#                                   g_prog,                                  #xckk005      传入程序代号
#                                   g_xccd_m.xccd003,                        #xckk006      传入成本计算类型
#                                   g_xccd_m.xccd001,                        #xckk007      传入本位币顺序
#                                   l_sum_xcce201,                           #xckk103      传入总表/分项报表数量
#                                   l_sum_xcce202e,                          #xckk104      传入总表/分项报表金额
#                                   0,                                       #xckk104a     传入总表/分项报表金额-材料
#                                   0,                                       #xckk104b     传入总表/分项报表金额-人工
#                                   0,                                       #xckk104c     传入总表/分项报表金额-加工
#                                   0,                                       #xckk104d     传入总表/分项报表金额-制费一
#                                   l_sum_xcce202e,                          #xckk104e     传入总表/分项报表金额-制费二
#                                   0,                                       #xckk104f     传入总表/分项报表金额-制费三
#                                   0,                                       #xckk104g     传入总表/分项报表金额-制费四
#                                   0,                                       #xckk104h     传入总表/分项报表金额-制费五
#                                   g_xccd2_d[l_cnt].xcce006,                #xckl007      传入成本勾稽明细表-单据编号
#                                   '',                                      #xckl008      传入成本勾稽明细表-项次
#                                   '',                                      #xckl009      传入成本勾稽明细表-序号
#                                   g_xccd2_d[l_cnt].xcce007,                #xckl010      传入成本勾稽明细表-料件
#                                   g_xccd2_d[l_cnt].xcce008,                #xckl011      传入成本勾稽明细表-特性
#                                   g_xccd2_d[l_cnt].xcce009,                #xckl012      传入成本勾稽明细表-批号
#                                   g_xccd2_d[l_cnt].xcce201,                #xckl014      传入成本勾稽明细表-数量
#                                   g_xccd2_d[l_cnt].xcce202e)               #xckl015      传入成本勾稽明细表-金额
#           THEN
#            EXIT FOR
#         END IF
#         
##本期在制投入-制费三  xcce201  xcce202f
#         IF NOT s_axcq004_upd_xckk('2',                                     #type         传入更新类型 1：axcq004更新总报表 2：子查询作业更新分项报表
#                                   g_enterprise,                            #xckkent      传入企业编号
#                                   g_xccd_m.xccdcomp,                       #xckkcomp     传入法人
#                                   g_xccd_m.xccdld,                         #xckkld       传入账套
#                                   '206',                                   #xckk001      传入类型代码
#                                   g_xccd_m.xccd004,                        #xckk003      传入年度
#                                   g_xccd_m.xccd005,                        #xckk004      传入期别
#                                   g_prog,                                  #xckk005      传入程序代号
#                                   g_xccd_m.xccd003,                        #xckk006      传入成本计算类型
#                                   g_xccd_m.xccd001,                        #xckk007      传入本位币顺序
#                                   l_sum_xcce201,                           #xckk103      传入总表/分项报表数量
#                                   l_sum_xcce202f,                          #xckk104      传入总表/分项报表金额
#                                   0,                                       #xckk104a     传入总表/分项报表金额-材料
#                                   0,                                       #xckk104b     传入总表/分项报表金额-人工
#                                   0,                                       #xckk104c     传入总表/分项报表金额-加工
#                                   0,                                       #xckk104d     传入总表/分项报表金额-制费一
#                                   0,                                       #xckk104e     传入总表/分项报表金额-制费二
#                                   l_sum_xcce202f,                          #xckk104f     传入总表/分项报表金额-制费三
#                                   0,                                       #xckk104g     传入总表/分项报表金额-制费四
#                                   0,                                       #xckk104h     传入总表/分项报表金额-制费五
#                                   g_xccd2_d[l_cnt].xcce006,                #xckl007      传入成本勾稽明细表-单据编号
#                                   '',                                      #xckl008      传入成本勾稽明细表-项次
#                                   '',                                      #xckl009      传入成本勾稽明细表-序号
#                                   g_xccd2_d[l_cnt].xcce007,                #xckl010      传入成本勾稽明细表-料件
#                                   g_xccd2_d[l_cnt].xcce008,                #xckl011      传入成本勾稽明细表-特性
#                                   g_xccd2_d[l_cnt].xcce009,                #xckl012      传入成本勾稽明细表-批号
#                                   g_xccd2_d[l_cnt].xcce201,                #xckl014      传入成本勾稽明细表-数量
#                                   g_xccd2_d[l_cnt].xcce202f)               #xckl015      传入成本勾稽明细表-金额
#           THEN
#            EXIT FOR
#         END IF
#         
##本期在制投入-制费四  xcce201  xcce202g
#         IF NOT s_axcq004_upd_xckk('2',                                     #type         传入更新类型 1：axcq004更新总报表 2：子查询作业更新分项报表
#                                   g_enterprise,                            #xckkent      传入企业编号
#                                   g_xccd_m.xccdcomp,                       #xckkcomp     传入法人
#                                   g_xccd_m.xccdld,                         #xckkld       传入账套
#                                   '207',                                   #xckk001      传入类型代码
#                                   g_xccd_m.xccd004,                        #xckk003      传入年度
#                                   g_xccd_m.xccd005,                        #xckk004      传入期别
#                                   g_prog,                                  #xckk005      传入程序代号
#                                   g_xccd_m.xccd003,                        #xckk006      传入成本计算类型
#                                   g_xccd_m.xccd001,                        #xckk007      传入本位币顺序
#                                   l_sum_xcce201,                           #xckk103      传入总表/分项报表数量
#                                   l_sum_xcce202g,                          #xckk104      传入总表/分项报表金额
#                                   0,                                       #xckk104a     传入总表/分项报表金额-材料
#                                   0,                                       #xckk104b     传入总表/分项报表金额-人工
#                                   0,                                       #xckk104c     传入总表/分项报表金额-加工
#                                   0,                                       #xckk104d     传入总表/分项报表金额-制费一
#                                   0,                                       #xckk104e     传入总表/分项报表金额-制费二
#                                   0,                                       #xckk104f     传入总表/分项报表金额-制费三
#                                   l_sum_xcce202g,                          #xckk104g     传入总表/分项报表金额-制费四
#                                   0,                                       #xckk104h     传入总表/分项报表金额-制费五
#                                   g_xccd2_d[l_cnt].xcce006,                #xckl007      传入成本勾稽明细表-单据编号
#                                   '',                                      #xckl008      传入成本勾稽明细表-项次
#                                   '',                                      #xckl009      传入成本勾稽明细表-序号
#                                   g_xccd2_d[l_cnt].xcce007,                #xckl010      传入成本勾稽明细表-料件
#                                   g_xccd2_d[l_cnt].xcce008,                #xckl011      传入成本勾稽明细表-特性
#                                   g_xccd2_d[l_cnt].xcce009,                #xckl012      传入成本勾稽明细表-批号
#                                   g_xccd2_d[l_cnt].xcce201,                #xckl014      传入成本勾稽明细表-数量
#                                   g_xccd2_d[l_cnt].xcce202g)               #xckl015      传入成本勾稽明细表-金额
#           THEN
#            EXIT FOR
#         END IF
#         
##本期在制投入-制费五  xcce201  xcce202h
#         IF NOT s_axcq004_upd_xckk('2',                                     #type         传入更新类型 1：axcq004更新总报表 2：子查询作业更新分项报表
#                                   g_enterprise,                            #xckkent      传入企业编号
#                                   g_xccd_m.xccdcomp,                       #xckkcomp     传入法人
#                                   g_xccd_m.xccdld,                         #xckkld       传入账套
#                                   '208',                                   #xckk001      传入类型代码
#                                   g_xccd_m.xccd004,                        #xckk003      传入年度
#                                   g_xccd_m.xccd005,                        #xckk004      传入期别
#                                   g_prog,                                  #xckk005      传入程序代号
#                                   g_xccd_m.xccd003,                        #xckk006      传入成本计算类型
#                                   g_xccd_m.xccd001,                        #xckk007      传入本位币顺序
#                                   l_sum_xcce201,                           #xckk103      传入总表/分项报表数量
#                                   l_sum_xcce202h,                          #xckk104      传入总表/分项报表金额
#                                   0,                                       #xckk104a     传入总表/分项报表金额-材料
#                                   0,                                       #xckk104b     传入总表/分项报表金额-人工
#                                   0,                                       #xckk104c     传入总表/分项报表金额-加工
#                                   0,                                       #xckk104d     传入总表/分项报表金额-制费一
#                                   0,                                       #xckk104e     传入总表/分项报表金额-制费二
#                                   0,                                       #xckk104f     传入总表/分项报表金额-制费三
#                                   0,                                       #xckk104g     传入总表/分项报表金额-制费四
#                                   l_sum_xcce202h,                          #xckk104h     传入总表/分项报表金额-制费五
#                                   g_xccd2_d[l_cnt].xcce006,                #xckl007      传入成本勾稽明细表-单据编号
#                                   '',                                      #xckl008      传入成本勾稽明细表-项次
#                                   '',                                      #xckl009      传入成本勾稽明细表-序号
#                                   g_xccd2_d[l_cnt].xcce007,                #xckl010      传入成本勾稽明细表-料件
#                                   g_xccd2_d[l_cnt].xcce008,                #xckl011      传入成本勾稽明细表-特性
#                                   g_xccd2_d[l_cnt].xcce009,                #xckl012      传入成本勾稽明细表-批号
#                                   g_xccd2_d[l_cnt].xcce201,                #xckl014      传入成本勾稽明细表-数量
#                                   g_xccd2_d[l_cnt].xcce202h)               #xckl015      传入成本勾稽明细表-金额
#           THEN
#            EXIT FOR
#         END IF
#         
##本期在制转出  xcce301   xcce302
#         IF NOT s_axcq004_upd_xckk('2',                                     #type         传入更新类型 1：axcq004更新总报表 2：子查询作业更新分项报表
#                                   g_enterprise,                            #xckkent      传入企业编号
#                                   g_xccd_m.xccdcomp,                       #xckkcomp     传入法人
#                                   g_xccd_m.xccdld,                         #xckkld       传入账套
#                                   '211',                                   #xckk001      传入类型代码
#                                   g_xccd_m.xccd004,                        #xckk003      传入年度
#                                   g_xccd_m.xccd005,                        #xckk004      传入期别
#                                   g_prog,                                  #xckk005      传入程序代号
#                                   g_xccd_m.xccd003,                        #xckk006      传入成本计算类型
#                                   g_xccd_m.xccd001,                        #xckk007      传入本位币顺序
#                                   l_sum_xcce301,                           #xckk103      传入总表/分项报表数量
#                                   l_sum_xcce302,                           #xckk104      传入总表/分项报表金额
#                                   l_sum_xcce302a,                          #xckk104a     传入总表/分项报表金额-材料
#                                   l_sum_xcce302b,                          #xckk104b     传入总表/分项报表金额-人工
#                                   l_sum_xcce302c,                          #xckk104c     传入总表/分项报表金额-加工
#                                   l_sum_xcce302d,                          #xckk104d     传入总表/分项报表金额-制费一
#                                   l_sum_xcce302e,                          #xckk104e     传入总表/分项报表金额-制费二
#                                   l_sum_xcce302f,                          #xckk104f     传入总表/分项报表金额-制费三
#                                   l_sum_xcce302g,                          #xckk104g     传入总表/分项报表金额-制费四
#                                   l_sum_xcce302h,                          #xckk104h     传入总表/分项报表金额-制费五
#                                   g_xccd2_d[l_cnt].xcce006,                #xckl007      传入成本勾稽明细表-单据编号
#                                   '',                                      #xckl008      传入成本勾稽明细表-项次
#                                   '',                                      #xckl009      传入成本勾稽明细表-序号
#                                   g_xccd2_d[l_cnt].xcce007,                #xckl010      传入成本勾稽明细表-料件
#                                   g_xccd2_d[l_cnt].xcce008,                #xckl011      传入成本勾稽明细表-特性
#                                   g_xccd2_d[l_cnt].xcce009,                #xckl012      传入成本勾稽明细表-批号
#                                   g_xccd2_d[l_cnt].xcce301,                #xckl014      传入成本勾稽明细表-数量
#                                   g_xccd2_d[l_cnt].xcce302)                #xckl015      传入成本勾稽明细表-金额
#           THEN
#            EXIT FOR
#         END IF
#         
##在制差异转出  xcce303  xcce304
#         IF NOT s_axcq004_upd_xckk('2',                                     #type         传入更新类型 1：axcq004更新总报表 2：子查询作业更新分项报表
#                                   g_enterprise,                            #xckkent      传入企业编号
#                                   g_xccd_m.xccdcomp,                       #xckkcomp     传入法人
#                                   g_xccd_m.xccdld,                         #xckkld       传入账套
#                                   '212',                                   #xckk001      传入类型代码
#                                   g_xccd_m.xccd004,                        #xckk003      传入年度
#                                   g_xccd_m.xccd005,                        #xckk004      传入期别
#                                   g_prog,                                  #xckk005      传入程序代号
#                                   g_xccd_m.xccd003,                        #xckk006      传入成本计算类型
#                                   g_xccd_m.xccd001,                        #xckk007      传入本位币顺序
#                                   l_sum_xcce303,                           #xckk103      传入总表/分项报表数量
#                                   l_sum_xcce304,                           #xckk104      传入总表/分项报表金额
#                                   l_sum_xcce304a,                          #xckk104a     传入总表/分项报表金额-材料
#                                   l_sum_xcce304b,                          #xckk104b     传入总表/分项报表金额-人工
#                                   l_sum_xcce304c,                          #xckk104c     传入总表/分项报表金额-加工
#                                   l_sum_xcce304d,                          #xckk104d     传入总表/分项报表金额-制费一
#                                   l_sum_xcce304e,                          #xckk104e     传入总表/分项报表金额-制费二
#                                   l_sum_xcce304f,                          #xckk104f     传入总表/分项报表金额-制费三
#                                   l_sum_xcce304g,                          #xckk104g     传入总表/分项报表金额-制费四
#                                   l_sum_xcce304h,                          #xckk104h     传入总表/分项报表金额-制费五
#                                   g_xccd2_d[l_cnt].xcce006,                #xckl007      传入成本勾稽明细表-单据编号
#                                   '',                                      #xckl008      传入成本勾稽明细表-项次
#                                   '',                                      #xckl009      传入成本勾稽明细表-序号
#                                   g_xccd2_d[l_cnt].xcce007,                #xckl010      传入成本勾稽明细表-料件
#                                   g_xccd2_d[l_cnt].xcce008,                #xckl011      传入成本勾稽明细表-特性
#                                   g_xccd2_d[l_cnt].xcce009,                #xckl012      传入成本勾稽明细表-批号
#                                   g_xccd2_d[l_cnt].xcce303,                #xckl014      传入成本勾稽明细表-数量
#                                   g_xccd2_d[l_cnt].xcce304)                #xckl015      传入成本勾稽明细表-金额
#           THEN
#            EXIT FOR
#         END IF
#         
##在制盘差  xcce307    xcce308
#         IF NOT s_axcq004_upd_xckk('2',                                     #type         传入更新类型 1：axcq004更新总报表 2：子查询作业更新分项报表
#                                   g_enterprise,                            #xckkent      传入企业编号
#                                   g_xccd_m.xccdcomp,                       #xckkcomp     传入法人
#                                   g_xccd_m.xccdld,                         #xckkld       传入账套
#                                   '109',                                   #xckk001      传入类型代码
#                                   g_xccd_m.xccd004,                        #xckk003      传入年度
#                                   g_xccd_m.xccd005,                        #xckk004      传入期别
#                                   g_prog,                                  #xckk005      传入程序代号
#                                   g_xccd_m.xccd003,                        #xckk006      传入成本计算类型
#                                   g_xccd_m.xccd001,                        #xckk007      传入本位币顺序
#                                   l_sum_xcce307,                           #xckk103      传入总表/分项报表数量
#                                   l_sum_xcce308,                           #xckk104      传入总表/分项报表金额
#                                   l_sum_xcce308a,                          #xckk104a     传入总表/分项报表金额-材料
#                                   l_sum_xcce308b,                          #xckk104b     传入总表/分项报表金额-人工
#                                   l_sum_xcce308c,                          #xckk104c     传入总表/分项报表金额-加工
#                                   l_sum_xcce308d,                          #xckk104d     传入总表/分项报表金额-制费一
#                                   l_sum_xcce308e,                          #xckk104e     传入总表/分项报表金额-制费二
#                                   l_sum_xcce308f,                          #xckk104f     传入总表/分项报表金额-制费三
#                                   l_sum_xcce308g,                          #xckk104g     传入总表/分项报表金额-制费四
#                                   l_sum_xcce308h,                          #xckk104h     传入总表/分项报表金额-制费五
#                                   g_xccd2_d[l_cnt].xcce006,                #xckl007      传入成本勾稽明细表-单据编号
#                                   '',                                      #xckl008      传入成本勾稽明细表-项次
#                                   '',                                      #xckl009      传入成本勾稽明细表-序号
#                                   g_xccd2_d[l_cnt].xcce007,                #xckl010      传入成本勾稽明细表-料件
#                                   g_xccd2_d[l_cnt].xcce008,                #xckl011      传入成本勾稽明细表-特性
#                                   g_xccd2_d[l_cnt].xcce009,                #xckl012      传入成本勾稽明细表-批号
#                                   g_xccd2_d[l_cnt].xcce307,                #xckl014      传入成本勾稽明细表-数量
#                                   g_xccd2_d[l_cnt].xcce308)                #xckl015      传入成本勾稽明细表-金额
#           THEN
#            EXIT FOR
#         END IF
#         
##期末在制   xcce901    xcce902
#         IF NOT s_axcq004_upd_xckk('2',                                     #type         传入更新类型 1：axcq004更新总报表 2：子查询作业更新分项报表
#                                   g_enterprise,                            #xckkent      传入企业编号
#                                   g_xccd_m.xccdcomp,                       #xckkcomp     传入法人
#                                   g_xccd_m.xccdld,                         #xckkld       传入账套
#                                   '214',                                   #xckk001      传入类型代码
#                                   g_xccd_m.xccd004,                        #xckk003      传入年度
#                                   g_xccd_m.xccd005,                        #xckk004      传入期别
#                                   g_prog,                                  #xckk005      传入程序代号
#                                   g_xccd_m.xccd003,                        #xckk006      传入成本计算类型
#                                   g_xccd_m.xccd001,                        #xckk007      传入本位币顺序
#                                   l_sum_xcce901,                           #xckk103      传入总表/分项报表数量
#                                   l_sum_xcce902,                           #xckk104      传入总表/分项报表金额
#                                   l_sum_xcce902a,                          #xckk104a     传入总表/分项报表金额-材料
#                                   l_sum_xcce902b,                          #xckk104b     传入总表/分项报表金额-人工
#                                   l_sum_xcce902c,                          #xckk104c     传入总表/分项报表金额-加工
#                                   l_sum_xcce902d,                          #xckk104d     传入总表/分项报表金额-制费一
#                                   l_sum_xcce902e,                          #xckk104e     传入总表/分项报表金额-制费二
#                                   l_sum_xcce902f,                          #xckk104f     传入总表/分项报表金额-制费三
#                                   l_sum_xcce902g,                          #xckk104g     传入总表/分项报表金额-制费四
#                                   l_sum_xcce902h,                          #xckk104h     传入总表/分项报表金额-制费五
#                                   g_xccd2_d[l_cnt].xcce006,                #xckl007      传入成本勾稽明细表-单据编号
#                                   '',                                      #xckl008      传入成本勾稽明细表-项次
#                                   '',                                      #xckl009      传入成本勾稽明细表-序号
#                                   g_xccd2_d[l_cnt].xcce007,                #xckl010      传入成本勾稽明细表-料件
#                                   g_xccd2_d[l_cnt].xcce008,                #xckl011      传入成本勾稽明细表-特性
#                                   g_xccd2_d[l_cnt].xcce009,                #xckl012      传入成本勾稽明细表-批号
#                                   g_xccd2_d[l_cnt].xcce901,                #xckl014      传入成本勾稽明细表-数量
#                                   g_xccd2_d[l_cnt].xcce902)                #xckl015      传入成本勾稽明细表-金额
#           THEN
#            EXIT FOR
#         END IF
#2015/10/16 by stellar mark ----- (S)
      END FOR
      
#以下是第三单身，拆件明细
      IF g_xccd3_d.getLength() = 0 THEN RETURN END IF   
      SELECT  SUM(xcci102a),
              SUM(xcci102b),
              SUM(xcci102c),
              SUM(xcci102d),
              SUM(xcci102e),
              SUM(xcci102f),
              SUM(xcci102g),
              SUM(xcci102h),
              SUM(xcci101), 
              SUM(xcci102), 
              SUM(xcci202a),
              SUM(xcci202b),
              SUM(xcci202c),
              SUM(xcci202d),
              SUM(xcci202e),
              SUM(xcci202f),
              SUM(xcci202g),
              SUM(xcci202h),
              SUM(xcci201), 
              SUM(xcci202), 
              SUM(xcci302a),
              SUM(xcci302b),
              SUM(xcci302c),
              SUM(xcci302d),
              SUM(xcci302e),
              SUM(xcci302f),
              SUM(xcci302g),
              SUM(xcci302h),
              SUM(xcci301), 
              SUM(xcci302), 
              SUM(xcci304a),
              SUM(xcci304b),
              SUM(xcci304c),
              SUM(xcci304d),
              SUM(xcci304e),
              SUM(xcci304f),
              SUM(xcci304g),
              SUM(xcci304h),
              SUM(xcci303), 
              SUM(xcci304), 
              SUM(xcci308), 
              SUM(xcci902a),
              SUM(xcci902b),
              SUM(xcci902c),
              SUM(xcci902d),
              SUM(xcci902e),
              SUM(xcci902f),
              SUM(xcci902g),
              SUM(xcci902h),
              SUM(xcci901), 
              SUM(xcci902)
         INTO l_sum_xcci102a, 
              l_sum_xcci102b, 
              l_sum_xcci102c, 
              l_sum_xcci102d, 
              l_sum_xcci102e, 
              l_sum_xcci102f, 
              l_sum_xcci102g, 
              l_sum_xcci102h, 
              l_sum_xcci101, 
              l_sum_xcci102, 
              l_sum_xcci202a, 
              l_sum_xcci202b, 
              l_sum_xcci202c, 
              l_sum_xcci202d, 
              l_sum_xcci202e, 
              l_sum_xcci202f, 
              l_sum_xcci202g, 
              l_sum_xcci202h, 
              l_sum_xcci201, 
              l_sum_xcci202, 
              l_sum_xcci302a, 
              l_sum_xcci302b, 
              l_sum_xcci302c, 
              l_sum_xcci302d, 
              l_sum_xcci302e, 
              l_sum_xcci302f, 
              l_sum_xcci302g, 
              l_sum_xcci302h, 
              l_sum_xcci301, 
              l_sum_xcci302, 
              l_sum_xcci304a, 
              l_sum_xcci304b, 
              l_sum_xcci304c, 
              l_sum_xcci304d, 
              l_sum_xcci304e, 
              l_sum_xcci304f, 
              l_sum_xcci304g, 
              l_sum_xcci304h, 
              l_sum_xcci303, 
              l_sum_xcci304,  
              l_sum_xcci902a, 
              l_sum_xcci902b, 
              l_sum_xcci902c, 
              l_sum_xcci902d, 
              l_sum_xcci902e, 
              l_sum_xcci902f, 
              l_sum_xcci902g, 
              l_sum_xcci902h, 
              l_sum_xcci901, 
              l_sum_xcci902 
         FROM xcci_t
        WHERE xccient  = g_enterprise
          AND xccicomp = g_xccd_m.xccdcomp
          AND xccild   = g_xccd_m.xccdld
          AND xcci001  = g_xccd_m.xccd001
          AND xcci003  = g_xccd_m.xccd003
          AND xcci004  = g_xccd_m.xccd004
          AND xcci005  = g_xccd_m.xccd005
 
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "sel_xcci_ins_xckk" 
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = TRUE 
         CALL cl_err() 
         RETURN
      END IF

      FOR l_cnt = 1 TO g_xccd3_d.getLength()
         IF g_xccd3_d[l_ac].xcci007 IS NULL THEN    #排除小计/总计行 小计总计行后面元件栏位是空的
            CONTINUE FOR
         END IF
#2015/10/16 by stellar mark ----- (S)
#stellar mark:s_axcq004_upd_xckk已沒在使用
##期初拆件   xcci101,xcci102         
#         IF NOT s_axcq004_upd_xckk('2',                                     #type         传入更新类型 1：axcq004更新总报表 2：子查询作业更新分项报表
#                                   g_enterprise,                            #xckkent      传入企业编号
#                                   g_xccd_m.xccdcomp,                       #xckkcomp     传入法人
#                                   g_xccd_m.xccdld,                         #xckkld       传入账套
#                                   '301',                                   #xckk001      传入类型代码
#                                   g_xccd_m.xccd004,                        #xckk003      传入年度
#                                   g_xccd_m.xccd005,                        #xckk004      传入期别
#                                   g_prog,                                  #xckk005      传入程序代号
#                                   g_xccd_m.xccd003,                        #xckk006      传入成本计算类型
#                                   g_xccd_m.xccd001,                        #xckk007      传入本位币顺序
#                                   l_sum_xcci101,                           #xckk103      传入总表/分项报表数量
#                                   l_sum_xcci102,                           #xckk104      传入总表/分项报表金额
#                                   l_sum_xcci102a,                          #xckk104a     传入总表/分项报表金额-材料
#                                   l_sum_xcci102b,                          #xckk104b     传入总表/分项报表金额-人工
#                                   l_sum_xcci102c,                          #xckk104c     传入总表/分项报表金额-加工
#                                   l_sum_xcci102d,                          #xckk104d     传入总表/分项报表金额-制费一
#                                   l_sum_xcci102e,                          #xckk104e     传入总表/分项报表金额-制费二
#                                   l_sum_xcci102f,                          #xckk104f     传入总表/分项报表金额-制费三
#                                   l_sum_xcci102g,                          #xckk104g     传入总表/分项报表金额-制费四
#                                   l_sum_xcci102h,                          #xckk104h     传入总表/分项报表金额-制费五
#                                   g_xccd3_d[l_cnt].xcci006,                #xckl007      传入成本勾稽明细表-单据编号
#                                   '',                                      #xckl008      传入成本勾稽明细表-项次
#                                   '',                                      #xckl009      传入成本勾稽明细表-序号
#                                   g_xccd3_d[l_cnt].xcci007,                #xckl010      传入成本勾稽明细表-料件
#                                   g_xccd3_d[l_cnt].xcci008,                #xckl011      传入成本勾稽明细表-特性
#                                   g_xccd3_d[l_cnt].xcci009,                #xckl012      传入成本勾稽明细表-批号
#                                   g_xccd3_d[l_cnt].xcci101,                #xckl014      传入成本勾稽明细表-数量
#                                   g_xccd3_d[l_cnt].xcci102)                #xckl015      传入成本勾稽明细表-金额
#           THEN
#            EXIT FOR
#         END IF
##本期拆件投入  xcci201  xcci202
#         IF NOT s_axcq004_upd_xckk('2',                                     #type         传入更新类型 1：axcq004更新总报表 2：子查询作业更新分项报表
#                                   g_enterprise,                            #xckkent      传入企业编号
#                                   g_xccd_m.xccdcomp,                       #xckkcomp     传入法人
#                                   g_xccd_m.xccdld,                         #xckkld       传入账套
#                                   '302',                                   #xckk001      传入类型代码
#                                   g_xccd_m.xccd004,                        #xckk003      传入年度
#                                   g_xccd_m.xccd005,                        #xckk004      传入期别
#                                   g_prog,                                  #xckk005      传入程序代号
#                                   g_xccd_m.xccd003,                        #xckk006      传入成本计算类型
#                                   g_xccd_m.xccd001,                        #xckk007      传入本位币顺序
#                                   l_sum_xcci201,                           #xckk103      传入总表/分项报表数量
#                                   l_sum_xcci202a,                          #xckk104      传入总表/分项报表金额
#                                   l_sum_xcci202a,                          #xckk104a     传入总表/分项报表金额-材料
#                                   l_sum_xcci202b,                          #xckk104b     传入总表/分项报表金额-人工
#                                   l_sum_xcci202c,                          #xckk104c     传入总表/分项报表金额-加工
#                                   l_sum_xcci202d,                          #xckk104d     传入总表/分项报表金额-制费一
#                                   l_sum_xcci202e,                          #xckk104e     传入总表/分项报表金额-制费二
#                                   l_sum_xcci202f,                          #xckk104f     传入总表/分项报表金额-制费三
#                                   l_sum_xcci202g,                          #xckk104g     传入总表/分项报表金额-制费四
#                                   l_sum_xcci202h,                          #xckk104h     传入总表/分项报表金额-制费五
#                                   g_xccd3_d[l_cnt].xcci006,                #xckl007      传入成本勾稽明细表-单据编号
#                                   '',                                      #xckl008      传入成本勾稽明细表-项次
#                                   '',                                      #xckl009      传入成本勾稽明细表-序号
#                                   g_xccd3_d[l_cnt].xcci007,                #xckl010      传入成本勾稽明细表-料件
#                                   g_xccd3_d[l_cnt].xcci008,                #xckl011      传入成本勾稽明细表-特性
#                                   g_xccd3_d[l_cnt].xcci009,                #xckl012      传入成本勾稽明细表-批号
#                                   g_xccd3_d[l_cnt].xcci201,                #xckl014      传入成本勾稽明细表-数量
#                                   g_xccd3_d[l_cnt].xcci202)                #xckl015      传入成本勾稽明细表-金额
#           THEN
#            EXIT FOR
#         END IF
#
#         
##本期拆件转出  xcci301   xcci302
#         IF NOT s_axcq004_upd_xckk('2',                                     #type         传入更新类型 1：axcq004更新总报表 2：子查询作业更新分项报表
#                                   g_enterprise,                            #xckkent      传入企业编号
#                                   g_xccd_m.xccdcomp,                       #xckkcomp     传入法人
#                                   g_xccd_m.xccdld,                         #xckkld       传入账套
#                                   '303',                                   #xckk001      传入类型代码
#                                   g_xccd_m.xccd004,                        #xckk003      传入年度
#                                   g_xccd_m.xccd005,                        #xckk004      传入期别
#                                   g_prog,                                  #xckk005      传入程序代号
#                                   g_xccd_m.xccd003,                        #xckk006      传入成本计算类型
#                                   g_xccd_m.xccd001,                        #xckk007      传入本位币顺序
#                                   l_sum_xcci301,                           #xckk103      传入总表/分项报表数量
#                                   l_sum_xcci302,                           #xckk104      传入总表/分项报表金额
#                                   l_sum_xcci302a,                          #xckk104a     传入总表/分项报表金额-材料
#                                   l_sum_xcci302b,                          #xckk104b     传入总表/分项报表金额-人工
#                                   l_sum_xcci302c,                          #xckk104c     传入总表/分项报表金额-加工
#                                   l_sum_xcci302d,                          #xckk104d     传入总表/分项报表金额-制费一
#                                   l_sum_xcci302e,                          #xckk104e     传入总表/分项报表金额-制费二
#                                   l_sum_xcci302f,                          #xckk104f     传入总表/分项报表金额-制费三
#                                   l_sum_xcci302g,                          #xckk104g     传入总表/分项报表金额-制费四
#                                   l_sum_xcci302h,                          #xckk104h     传入总表/分项报表金额-制费五
#                                   g_xccd3_d[l_cnt].xcci006,                #xckl007      传入成本勾稽明细表-单据编号
#                                   '',                                      #xckl008      传入成本勾稽明细表-项次
#                                   '',                                      #xckl009      传入成本勾稽明细表-序号
#                                   g_xccd3_d[l_cnt].xcci007,                #xckl010      传入成本勾稽明细表-料件
#                                   g_xccd3_d[l_cnt].xcci008,                #xckl011      传入成本勾稽明细表-特性
#                                   g_xccd3_d[l_cnt].xcci009,                #xckl012      传入成本勾稽明细表-批号
#                                   g_xccd3_d[l_cnt].xcci301,                #xckl014      传入成本勾稽明细表-数量
#                                   g_xccd3_d[l_cnt].xcci302)                #xckl015      传入成本勾稽明细表-金额
#           THEN
#            EXIT FOR
#         END IF
#         
##拆件差异转出  xcci303  xcci304
#         IF NOT s_axcq004_upd_xckk('2',                                     #type         传入更新类型 1：axcq004更新总报表 2：子查询作业更新分项报表
#                                   g_enterprise,                            #xckkent      传入企业编号
#                                   g_xccd_m.xccdcomp,                       #xckkcomp     传入法人
#                                   g_xccd_m.xccdld,                         #xckkld       传入账套
#                                   '304',                                   #xckk001      传入类型代码
#                                   g_xccd_m.xccd004,                        #xckk003      传入年度
#                                   g_xccd_m.xccd005,                        #xckk004      传入期别
#                                   g_prog,                                  #xckk005      传入程序代号
#                                   g_xccd_m.xccd003,                        #xckk006      传入成本计算类型
#                                   g_xccd_m.xccd001,                        #xckk007      传入本位币顺序
#                                   l_sum_xcci303,                           #xckk103      传入总表/分项报表数量
#                                   l_sum_xcci304,                           #xckk104      传入总表/分项报表金额
#                                   l_sum_xcci304a,                          #xckk104a     传入总表/分项报表金额-材料
#                                   l_sum_xcci304b,                          #xckk104b     传入总表/分项报表金额-人工
#                                   l_sum_xcci304c,                          #xckk104c     传入总表/分项报表金额-加工
#                                   l_sum_xcci304d,                          #xckk104d     传入总表/分项报表金额-制费一
#                                   l_sum_xcci304e,                          #xckk104e     传入总表/分项报表金额-制费二
#                                   l_sum_xcci304f,                          #xckk104f     传入总表/分项报表金额-制费三
#                                   l_sum_xcci304g,                          #xckk104g     传入总表/分项报表金额-制费四
#                                   l_sum_xcci304h,                          #xckk104h     传入总表/分项报表金额-制费五
#                                   g_xccd3_d[l_cnt].xcci006,                #xckl007      传入成本勾稽明细表-单据编号
#                                   '',                                      #xckl008      传入成本勾稽明细表-项次
#                                   '',                                      #xckl009      传入成本勾稽明细表-序号
#                                   g_xccd3_d[l_cnt].xcci007,                #xckl010      传入成本勾稽明细表-料件
#                                   g_xccd3_d[l_cnt].xcci008,                #xckl011      传入成本勾稽明细表-特性
#                                   g_xccd3_d[l_cnt].xcci009,                #xckl012      传入成本勾稽明细表-批号
#                                   g_xccd3_d[l_cnt].xcci303,                #xckl014      传入成本勾稽明细表-数量
#                                   g_xccd3_d[l_cnt].xcci304)                #xckl015      传入成本勾稽明细表-金额
#           THEN
#            EXIT FOR
#         END IF
#         
##期末拆件   xcci901    xcci902
#         IF NOT s_axcq004_upd_xckk('2',                                     #type         传入更新类型 1：axcq004更新总报表 2：子查询作业更新分项报表
#                                   g_enterprise,                            #xckkent      传入企业编号
#                                   g_xccd_m.xccdcomp,                       #xckkcomp     传入法人
#                                   g_xccd_m.xccdld,                         #xckkld       传入账套
#                                   '305',                                   #xckk001      传入类型代码
#                                   g_xccd_m.xccd004,                        #xckk003      传入年度
#                                   g_xccd_m.xccd005,                        #xckk004      传入期别
#                                   g_prog,                                  #xckk005      传入程序代号
#                                   g_xccd_m.xccd003,                        #xckk006      传入成本计算类型
#                                   g_xccd_m.xccd001,                        #xckk007      传入本位币顺序
#                                   l_sum_xcci901,                           #xckk103      传入总表/分项报表数量
#                                   l_sum_xcci902,                           #xckk104      传入总表/分项报表金额
#                                   l_sum_xcci902a,                          #xckk104a     传入总表/分项报表金额-材料
#                                   l_sum_xcci902b,                          #xckk104b     传入总表/分项报表金额-人工
#                                   l_sum_xcci902c,                          #xckk104c     传入总表/分项报表金额-加工
#                                   l_sum_xcci902d,                          #xckk104d     传入总表/分项报表金额-制费一
#                                   l_sum_xcci902e,                          #xckk104e     传入总表/分项报表金额-制费二
#                                   l_sum_xcci902f,                          #xckk104f     传入总表/分项报表金额-制费三
#                                   l_sum_xcci902g,                          #xckk104g     传入总表/分项报表金额-制费四
#                                   l_sum_xcci902h,                          #xckk104h     传入总表/分项报表金额-制费五
#                                   g_xccd3_d[l_cnt].xcci006,                #xckl007      传入成本勾稽明细表-单据编号
#                                   '',                                      #xckl008      传入成本勾稽明细表-项次
#                                   '',                                      #xckl009      传入成本勾稽明细表-序号
#                                   g_xccd3_d[l_cnt].xcci007,                #xckl010      传入成本勾稽明细表-料件
#                                   g_xccd3_d[l_cnt].xcci008,                #xckl011      传入成本勾稽明细表-特性
#                                   g_xccd3_d[l_cnt].xcci009,                #xckl012      传入成本勾稽明细表-批号
#                                   g_xccd3_d[l_cnt].xcci901,                #xckl014      传入成本勾稽明细表-数量
#                                   g_xccd3_d[l_cnt].xcci902)                #xckl015      传入成本勾稽明细表-金额
#           THEN
#            EXIT FOR
#         END IF
#2015/10/16 by stellar mark ----- (E)

      END FOR
END FUNCTION

################################################################################
# Descriptions...: 創建暫存檔
# Date & Author..: 2015/3/27 By ouhz
# Modify.........:
################################################################################
PRIVATE FUNCTION axcq540_create_temp_table()
DROP TABLE axcq540_tmp;
   CREATE TEMP TABLE axcq540_tmp(
   sfaa068         VARCHAR(20), 
   sfaa068_desc    VARCHAR(100), 
   xccd006         VARCHAR(20),
   xccd007         VARCHAR(40), 
   xccd007_desc    VARCHAR(100), 
   xccd007_desc_1  VARCHAR(100), 
   xcce007         VARCHAR(40), 
   xcce007_desc    VARCHAR(100), 
   xcce007_desc_1  VARCHAR(100), 
   xcce008         VARCHAR(256), 
   xcce009         VARCHAR(30), 
   xcbb005         VARCHAR(100), 
   xcbb005_desc    VARCHAR(100), 
   xccd002         VARCHAR(30),
   xcce101         DECIMAL(20,6), 
   xcce102         DECIMAL(20,6), 
   xcce201         DECIMAL(20,6), 
   xcce202         DECIMAL(20,6), 
   xcce301         DECIMAL(20,6), 
   xcce302         DECIMAL(20,6), 
   xcce303         DECIMAL(20,6), 
   xcce304         DECIMAL(20,6), 
   xcce307         DECIMAL(20,6), 
   xcce308         DECIMAL(20,6), 
   xcce901         DECIMAL(20,6), 
   xcce902         DECIMAL(20,6), 
   xccdcomp        VARCHAR(10), 
   xccdcomp_desc   VARCHAR(100), 
   xccd004         SMALLINT, 
   xccd001         VARCHAR(1), 
   xccd001_desc    VARCHAR(100), 
   xccdld          VARCHAR(5), 
   xccdld_desc     VARCHAR(100), 
   xccd005         SMALLINT, 
   xccd003         VARCHAR(10), 
   xccd003_desc    VARCHAR(100), 
   xccdent         SMALLINT, 
   xccdkey         INTEGER     #type_t.chr1000 #160106-00012#1-mod
   );
END FUNCTION

################################################################################
# Descriptions...: 將數據存放在暫存檔
# Date & Author..: 2015/3/27 By ouhz
# Modify.........:
################################################################################
PRIVATE FUNCTION axcq540_ins_temp()
DEFINE sr         RECORD
   sfaa068        LIKE xcce_t.xcce006, 
   sfaa068_desc   LIKE type_t.chr100, 
   xccd006        LIKE xccd_t.xccd006, 
   xccd007        LIKE xccd_t.xccd007, 
   xccd007_desc   LIKE type_t.chr100, 
   xccd007_desc_1 LIKE type_t.chr100, 
   xcce007        LIKE xcce_t.xcce007, 
   xcce007_desc   LIKE type_t.chr100, 
   xcce007_desc_1 LIKE type_t.chr100, 
   xcce008        LIKE xcce_t.xcce008, 
   xcce009        LIKE xcce_t.xcce009, 
   xcbb005        LIKE type_t.chr100, 
   xcbb005_desc   LIKE type_t.chr100, 
   xccd002        LIKE xccd_t.xccd002,
   xcce101        LIKE xcce_t.xcce101, 
   xcce102        LIKE xcce_t.xcce102, 
   xcce201        LIKE xcce_t.xcce201, 
   xcce202        LIKE xcce_t.xcce202, 
   xcce301        LIKE xcce_t.xcce301, 
   xcce302        LIKE xcce_t.xcce302, 
   xcce303        LIKE xcce_t.xcce303, 
   xcce304        LIKE xcce_t.xcce304, 
   xcce307        LIKE xcce_t.xcce307, 
   xcce308        LIKE xcce_t.xcce308, 
   xcce901        LIKE xcce_t.xcce901, 
   xcce902        LIKE xcce_t.xcce902, 
   xccdcomp       LIKE xccd_t.xccdcomp, 
   xccdcomp_desc  LIKE type_t.chr100, 
   xccd004        LIKE xccd_t.xccd004, 
   xccd001        LIKE xccd_t.xccd001, 
   xccd001_desc   LIKE type_t.chr100, 
   xccdld         LIKE xccd_t.xccdld, 
   xccdld_desc    LIKE type_t.chr100, 
   xccd005        LIKE xccd_t.xccd005, 
   xccd003        LIKE xccd_t.xccd003, 
   xccd003_desc   LIKE type_t.chr100, 
   xccdent        LIKE xccd_t.xccdent, 
   xccdkey        LIKE type_t.num10 #type_t.chr1000  #160106-00012#1-mod
                  END RECORD
DEFINE l_i               LIKE type_t.num10
DEFINE l_glaa001         LIKE glaa_t.glaa001
DEFINE l_glaa016         LIKE glaa_t.glaa016
DEFINE l_glaa020         LIKE glaa_t.glaa020
DEFINE l_xccd004         LIKE type_t.chr30
DEFINE l_xccd005         LIKE type_t.chr30 
DEFINE l_success         LIKE type_t.num5
DEFINE l_cnt1            LIKE type_t.num10

   #刪除臨時表中資料
   LET l_success = TRUE
   #dorislai-20151022-modify----(S)
   #年度月份換成區間，故需分別取各筆資料的年度、期別
#    FOR l_i = 1 TO g_browser.getLength()

#      LET sr.xccd004  = g_browser[l_i].b_xccd004
#      LET sr.xccd001  = g_browser[l_i].b_xccd001
#      LET sr.xccdld   = g_browser[l_i].b_xccdld
#      LET sr.xccd005  = g_browser[l_i].b_xccd005
#      LET sr.xccd003  = g_browser[l_i].b_xccd003
   #160108-00001#1-mark----(S)
#   FOREACH ins_tmp_cur INTO sr.xccdcomp,sr.xccdld,sr.xccd001,sr.xccd003,sr.xccd004,sr.xccd005     
#   #dorislai-20151022-modify----(E)
#      EXECUTE axcq540_master_referesh USING sr.xccdld,sr.xccd001,sr.xccd003,sr.xccd004,sr.xccd005  
#      INTO sr.xccdcomp,sr.xccdld,sr.xccd004,sr.xccd005,sr.xccd001,sr.xccd003,sr.xccdcomp_desc,sr.xccdld_desc,sr.xccd003_desc
# 
#      LET l_xccd004=sr.xccd004
#      LET l_xccd005=sr.xccd005
#      LET sr.xccdkey = sr.xccdcomp,"-",sr.xccdld,"-",l_xccd004 CLIPPED,"-",l_xccd005 CLIPPED,"-",sr.xccd001 CLIPPED,"-",sr.xccd003     
#      
#      CALL axcq540_data(sr.xccdcomp,sr.xccdld,sr.xccd001,sr.xccd003,sr.xccd004,sr.xccd005)
#      
#        LET g_sql_tmp = " SELECT UNIQUE sfaa068,xccd006,xcce007,xcce008,xcce009,xcbb005,xccd002,xcce101,xcce102,xcce201,",
#                  "        xcce202,xcce301,xcce302,xcce303,xcce304,xcce307,xcce308,xcce901,xcce902 ",
#                  "        ,xccd007 ",                
#                  "   FROM axcq540_tmp04 ",
#                  "  ORDER BY sfaa068,xccd006 "
#                  
#      LET g_sql_tmp = cl_sql_add_mask(g_sql_tmp)              
#      
#      PREPARE axcq540_ins_tmp_pre FROM  g_sql_tmp
#      DECLARE axcq540_ins_tmp_cs CURSOR FOR axcq540_ins_tmp_pre     
#      
#      FOREACH axcq540_ins_tmp_cs INTO sr.sfaa068,sr.xccd006,sr.xcce007,sr.xcce008,sr.xcce009,sr.xcbb005,sr.xccd002,sr.xcce101,sr.xcce102,sr.xcce201,
#                                      sr.xcce202,sr.xcce301,sr.xcce302,sr.xcce303,sr.xcce304,sr.xcce307,sr.xcce308,sr.xcce901,sr.xcce902,sr.xccd007
#                                     
#      CALL s_desc_get_department_desc(g_xccd_d[l_ac].sfaa068) RETURNING g_xccd_d[l_ac].sfaa068_desc
#      LET sr.sfaa068_desc=g_xccd_d[l_ac].sfaa068_desc
#      
#      INITIALIZE g_ref_fields TO NULL
#      LET g_ref_fields[1] = sr.xcce007
#      CALL ap_ref_array2(g_ref_fields,"SELECT imaal003,imaal004 FROM imaal_t WHERE imaalent='"||g_enterprise||"' AND imaal001=? AND imaal002='"||g_dlang||"'","") RETURNING g_rtn_fields
#      LET sr.xcce007_desc = '', g_rtn_fields[1] , ''
#      LET sr.xcce007_desc_1 = '', g_rtn_fields[2] , ''
#      
#      INITIALIZE g_ref_fields TO NULL
#      LET g_ref_fields[1] = sr.xccd007
#      CALL ap_ref_array2(g_ref_fields,"SELECT imaal003,imaal004 FROM imaal_t WHERE imaalent='"||g_enterprise||"' AND imaal001=? AND imaal002='"||g_dlang||"'","") RETURNING g_rtn_fields
#      LET sr.xccd007_desc = '', g_rtn_fields[1] , ''
#      LET sr.xccd007_desc_1 = '', g_rtn_fields[2] , ''
#   
#       #成本單位取axci120
#      SELECT xcbb005 INTO sr.xcbb005 FROM xcbb_t
#       WHERE xcbbent  = g_enterprise
#         AND xcbbcomp = sr.xccdcomp
#         AND xcbb001  = sr.xccd004
#         AND xcbb002  = sr.xccd005
#         AND xcbb003  = sr.xccd006
#             
#      CALL s_desc_get_unit_desc(sr.xcbb005) RETURNING sr.xcbb005_desc
      #160108-00001#1-mark----(E)
      #160108-00001#1-add----(S)
      FOR l_i = 1 TO g_xccd_d.getLength()
         LET sr.xccdcomp = g_xccd_m.xccdcomp
         LET sr.xccdld = g_xccd_m.xccdld
         LET sr.xccd001 = g_xccd_m.xccd001
         LET sr.xccd003 = g_xccd_m.xccd003
         LET sr.xccd004 = g_yy1
         LET sr.xccd005 = g_mm1
         LET sr.xccdkey = l_i
         LET sr.xccdcomp_desc = g_xccd_m.xccdcomp_desc
         LET sr.xccdld_desc = g_xccd_m.xccdld_desc
         LET sr.xccd003_desc = g_xccd_m.xccd003_desc
         
         LET l_xccd004=sr.xccd004
         LET l_xccd005=sr.xccd005
         LET sr.sfaa068 = g_xccd_d[l_i].sfaa068
         LET sr.sfaa068_desc = g_xccd_d[l_i].sfaa068_desc
         LET sr.xccd006 = g_xccd_d[l_i].xccd006
         LET sr.xccd007 = g_xccd_d[l_i].xccd007
         LET sr.xccd007_desc = g_xccd_d[l_i].xccd007_desc
         LET sr.xccd007_desc_1 = g_xccd_d[l_i].xccd007_desc_desc
         LET sr.xcce007 = g_xccd_d[l_i].xcce007
         LET sr.xcce007_desc = g_xccd_d[l_i].xcce007_desc
         LET sr.xcce007_desc_1 = g_xccd_d[l_i].xcce007_desc_1
         LET sr.xcce008 = g_xccd_d[l_i].xcce008
         LET sr.xcce009 = g_xccd_d[l_i].xcce009
         LET sr.xcbb005 = g_xccd_d[l_i].xcbb005
         LET sr.xcbb005_desc = g_xccd_d[l_i].xcbb005_desc
         LET sr.xccd002 = g_xccd_d[l_i].xccd002
         LET sr.xcce101 = g_xccd_d[l_i].xcce101
         LET sr.xcce102 = g_xccd_d[l_i].xcce102
         LET sr.xcce201 = g_xccd_d[l_i].xcce201
         LET sr.xcce202 = g_xccd_d[l_i].xcce202
         LET sr.xcce301 = g_xccd_d[l_i].xcce301
         LET sr.xcce302 = g_xccd_d[l_i].xcce302
         LET sr.xcce303 = g_xccd_d[l_i].xcce303
         LET sr.xcce304 = g_xccd_d[l_i].xcce304
         LET sr.xcce307 = g_xccd_d[l_i].xcce307
         LET sr.xcce308 = g_xccd_d[l_i].xcce308
         LET sr.xcce901 = g_xccd_d[l_i].xcce901
         LET sr.xcce902 = g_xccd_d[l_i].xcce902
         LET sr.xccdent = g_enterprise
         CALL s_desc_gzcbl004_desc('8914',sr.xccd001) RETURNING sr.xccd001_desc
      #160108-00001#1-add----(E)
      
      INSERT INTO axcq540_tmp( sfaa068,sfaa068_desc,xccd006,xccd007,xccd007_desc,xccd007_desc_1,xcce007,xcce007_desc,xcce007_desc_1,xcce008,xcce009,xcbb005,
                               xcbb005_desc,xccd002,xcce101,xcce102,xcce201,xcce202,xcce301,xcce302,xcce303,xcce304,xcce307,xcce308,xcce901,xcce902,
                               xccdcomp,xccdcomp_desc,xccd004,xccd001,xccd001_desc,xccdld,xccdld_desc,xccd005,xccd003,xccd003_desc,xccdent,xccdkey )
                      VALUES(  sr.sfaa068,sr.sfaa068_desc,sr.xccd006,sr.xccd007,sr.xccd007_desc,sr.xccd007_desc_1,sr.xcce007,sr.xcce007_desc,sr.xcce007_desc_1,sr.xcce008,sr.xcce009,sr.xcbb005,
                               sr.xcbb005_desc,sr.xccd002,sr.xcce101,sr.xcce102,sr.xcce201,sr.xcce202,sr.xcce301,sr.xcce302,sr.xcce303,sr.xcce304,sr.xcce307,sr.xcce308,sr.xcce901,sr.xcce902,
                               sr.xccdcomp,sr.xccdcomp_desc,sr.xccd004,sr.xccd001,sr.xccd001_desc,sr.xccdld,sr.xccdld_desc,sr.xccd005,sr.xccd003,sr.xccd003_desc,sr.xccdent,sr.xccdkey )
    
      IF SQLCA.sqlcode  THEN
           INITIALIZE g_errparam TO NULL
           LET g_errparam.extend = 'insert tmp'
           LET g_errparam.code = SQLCA.SQLCODE
           LET g_errparam.popup = TRUE
           CALL cl_err()
      END IF   
#     END FOREACH #160108-00001#1-mod-(S)
     END FOR      #160108-00001#1-mod-(E)
     
     CALL cl_err_collect_show()
     IF l_success = FALSE THEN
        DELETE FROM axcq540_tmp
     END IF
      
#     FREE axcq540_ins_tmp_pre #160108-00001#1-mark
   
#   END FOR     #dorislai-20151022-mark
#   END FOREACH  #dorislai-20151022-add  #160108-00001#1-mark
   
END FUNCTION

################################################################################
# Descriptions...: 取臨時表數據
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
PRIVATE FUNCTION axcq540_data(p1,p2,p3,p4,p5,p6)
DEFINE p1   LIKE xccd_t.xccdcomp
DEFINE p2   LIKE xccd_t.xccdld
DEFINE p3   LIKE xccd_t.xccd001
DEFINE p4   LIKE xccd_t.xccd003
DEFINE p5   LIKE xccd_t.xccd004
DEFINE p6   LIKE xccd_t.xccd005

  #刪除TEMP TABLE
   DROP TABLE axcq540_tmp04
   DROP TABLE axcq540_tmp02
   DROP TABLE axcq540_tmp03
  IF NOT axcq540_cre_tmp_table() THEN RETURN END IF
   LET g_sql = " INSERT INTO axcq540_tmp02 ",   #第二单身的临时表
                 "  SELECT UNIQUE sfaa068,'',xcce006,xccd007,xccd008,xccd301,xcce007,'','',xcce008,xcce009,xcbb005,'',xcce002,xcce101,xcce102a,xcce102b,xcce102c,xcce102d,xcce102e,",   
                 "         xcce102f,xcce102g,xcce102h,xcce102,xcce201+xcce205+xcce207+xcce209 xcce201,xcce202a+xcce206a+xcce208a+xcce210a xcce202a,xcce202b+xcce206b+xcce208b+xcce210b xcce202b,",
                 "         xcce202c+xcce206c+xcce208c+xcce210c xcce202c,xcce202d+xcce206d+xcce208d+xcce210d xcce202d,xcce202e+xcce206e+xcce208e+xcce210e xcce202e,xcce202f+xcce206f+xcce208f+xcce210f xcce202f,",
                 "         xcce202g+xcce206g+xcce208g+xcce210g xcce202g,xcce202h+xcce206h+xcce208h+xcce210h xcce202h,xcce202+xcce206+xcce208+xcce210 xcce202,xcce301,xcce302a,xcce302b,xcce302c,xcce302d,",
                 "         xcce302e,xcce302f,xcce302g,xcce302h,xcce302,xcce303,xcce304a,xcce304b,xcce304c,xcce304d,xcce304e,xcce304f,xcce304g,xcce304h,xcce304,xcce307,xcce308a,",
                 "         xcce308b,xcce308c,xcce308d,xcce308e,xcce308f,xcce308g,xcce308h,xcce308,xcce901,xcce902a,xcce902b,xcce902c,xcce902d,xcce902e,xcce902f,xcce902g,xcce902h,xcce902 ",
                 "    FROM xcce_t                      ",
                #"        LEFT JOIN xccd_t ON xccdent = xcceent AND xccd006 = xcce006 AND xccd002 = xcce002 ",    #160813-00002#1 mark
                 "        LEFT JOIN xccd_t ON xccdent = xcceent AND xccd006 = xcce006 ",                          #160813-00002#1 add
                 "                         AND xccdld = xcceld AND xccd001 = xcce001 AND xccd003 = xcce003 AND xccd004 = xcce004 AND xccd005 = xcce005 ",
                 "        LEFT JOIN sfaa_t ON sfaaent = xcceent AND sfaadocno = xcce006 ", 
      
                 "                LEFT JOIN xcbb_t ON xcbbent = xcceent AND xcbbcomp = xccecomp AND xcbb001 = xcce004 AND xcbb002 = xcce005 ",
                 "                                                      AND xcbb003 = xcce007 AND xcbb004 = xcce008 ",
                 "   WHERE xcceent  = '",g_enterprise,"'",
                 "     AND xccecomp = '",p1,"'",
                 "     AND xcceld   = '",p2,"'",
                 "     AND xcce001  = '",p3,"'",
                 "     AND xcce003  = '",p4,"'",
                 "     AND xcce004  = '",p5,"'",
                 "     AND xcce005  = '",p6,"'"

    
     LET g_sql = cl_sql_add_mask(g_sql)  
     
     PREPARE axcq540_ins_tmp02a FROM g_sql

     EXECUTE axcq540_ins_tmp02a

     IF SQLCA.sqlcode THEN
        INITIALIZE g_errparam TO NULL 
        LET g_errparam.extend = "ins tmp02" 
        LET g_errparam.code   = SQLCA.sqlcode 
        LET g_errparam.popup  = TRUE 
        CALL cl_err()
 
        RETURN
     END IF
         
     LET g_sql = " INSERT INTO axcq540_tmp03 ",   #第三单身的临时表
                 "  SELECT UNIQUE sfaa068,'',xcci006,xcch007,xcch008,xcch301,xcci007,'','',xcci008,xcci009,xcbb005,'',xcci002,xcci101,xcci102a,xcci102b,xcci102c,xcci102d,xcci102e,",  
                 "         xcci102f,xcci102g,xcci102h,xcci102,xcci201,xcci202a,xcci202b,xcci202c,xcci202d,xcci202e,xcci202f,",
                 "         xcci202g,xcci202h,xcci202,xcci301,xcci302a,xcci302b,xcci302c,xcci302d,",
                 "         xcci302e,xcci302f,xcci302g,xcci302h,xcci302,xcci303,xcci304a,xcci304b,xcci304c,xcci304d,xcci304e,xcci304f,xcci304g,xcci304h,xcci304,",
                 "         xcci901,xcci902a,xcci902b,xcci902c,xcci902d,xcci902e,xcci902f,xcci902g,xcci902h,xcci902 ",

                 "    FROM xcci_t                      ",
                 "        LEFT JOIN xcch_t ON xcchent = xccient AND xcch006 = xcci006 AND xcch002 = xcci002 ",
                 "                         AND xcchld = xccild AND xcch001 = xcci001 AND xcch003 = xcci003 AND xcch004 = xcci004 AND xcch005 = xcci005 ",
                 "        LEFT JOIN sfaa_t ON sfaaent = xccient AND sfaadocno = xcci006 ",
     
                 "                LEFT JOIN xcbb_t ON xcbbent = xccient AND xcbbcomp = xccicomp AND xcbb001 = xcci004 AND xcbb002 = xcci005 ",
                 "                                                      AND xcbb003 = xcci007 AND xcbb004 = xcci008 ",
                 "   WHERE xccient  = '",g_enterprise,"'",
                 "     AND xccicomp = '",p1,"'",
                 "     AND xccild   = '",p2,"'",
                 "     AND xcci001  = '",p3,"'",
                 "     AND xcci003  = '",p4,"'",
                 "     AND xcci004  = '",p5,"'",
                 "     AND xcci005  = '",p6,"'"
   
   
     LET g_sql = cl_sql_add_mask(g_sql)  
     
     PREPARE axcq540_ins_tmp03a FROM g_sql

     EXECUTE axcq540_ins_tmp03a

     IF SQLCA.sqlcode THEN
        INITIALIZE g_errparam TO NULL 
        LET g_errparam.extend = "ins tmp03" 
        LET g_errparam.code   = SQLCA.sqlcode 
        LET g_errparam.popup  = TRUE 
        CALL cl_err()
 
        RETURN
     END IF  
    LET g_sql =     " INSERT INTO axcq540_tmp04 ",   #第一单身的临时表
                    " SELECT UNIQUE sfaa068,'',xcce006,xccd007,xcce007,'','',xcce008,xcce009,xcbb005,'',xcce002,xcce101,xcce102,", 
                    "        xcce201,xcce202,xcce301,xcce302,xcce303,xcce304,xcce307,xcce308,xcce901,xcce902 ",
                    "   FROM axcq540_tmp02 ",
                    "  UNION ",
                    " SELECT UNIQUE sfaa068,'',xcci006,xcch007,xcci007,'','',xcci008,xcci009,xcbb005,'',xcci002,xcci101,xcci102,xcci201,xcci202,xcci301,xcci302,xcci303,xcci304,0,0,xcci901,xcci902 ", 
                    "   FROM axcq540_tmp03 "
              
     LET g_sql = cl_sql_add_mask(g_sql)  
     
     PREPARE axcq540_ins_tmp04 FROM g_sql

     EXECUTE axcq540_ins_tmp04 
 

     IF SQLCA.sqlcode THEN
        INITIALIZE g_errparam TO NULL 
        LET g_errparam.extend = "ins tmp04" 
        LET g_errparam.code   = SQLCA.sqlcode 
        LET g_errparam.popup  = TRUE 
        CALL cl_err()
 
        RETURN
     END IF 
           

END FUNCTION

################################################################################
# Descriptions...: filter過濾功能
# Memo...........:
# Usage..........: CALL axcq540_filter()
#                  RETURNING
# Input parameter: 
# Return code....: 
# Date & Author..: 151130 By Polly
# Modify.........: 151130-00003#2  增加二次蒒選功能
################################################################################
PRIVATE FUNCTION axcq540_filter()

   LET l_ac = 1
   LET g_detail_idx = 1
   LET g_detail_idx2 = 1
 
   LET INT_FLAG = 0
 
   LET g_qryparam.state = 'c'
 
   #備份
   LET g_wc_filter_t = g_wc_filter
   LET g_wc_filter2_t = g_wc_filter2
   LET g_wc_filter3_t = g_wc_filter3   
   
   LET g_wc_t = g_wc
   
   LET g_wc = cl_replace_str(g_wc, g_wc_filter, '')
   LET g_wc = cl_replace_str(g_wc, g_wc_filter2, '')
   LET g_wc = cl_replace_str(g_wc, g_wc_filter3, '')
 
   LET g_wc_filter       = ''
   LET g_wc_filter2      = ''
   LET g_wc_filter3      = ''
 
   CALL gfrm_curr.setFieldHidden("formonly.sel", TRUE)
   CALL gfrm_curr.setFieldHidden("formonly.statepic", TRUE) 

   #使用DIALOG包住 單頭CONSTRUCT及單身CONSTRUCT
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)

      CONSTRUCT g_wc_filter ON sfaa068,xccd006,xcce007,xcce008,xcce009,xcbb005,xccd002,xcce101,xcce102, 
                               xcce201,xcce202,xcce301,xcce302,xcce303,xcce304,xcce307,xcce308,xcce901,xcce902
           FROM s_detail1[1].sfaa068,s_detail1[1].xccd006,s_detail1[1].xcce007,s_detail1[1].xcce008, 
                s_detail1[1].xcce009,s_detail1[1].xcbb005,s_detail1[1].xccd002,s_detail1[1].xcce101,s_detail1[1].xcce102, 
                s_detail1[1].xcce201,s_detail1[1].xcce202,s_detail1[1].xcce301,s_detail1[1].xcce302,s_detail1[1].xcce303, 
                s_detail1[1].xcce304,s_detail1[1].xcce307,s_detail1[1].xcce308,s_detail1[1].xcce901,s_detail1[1].xcce902
                
         BEFORE CONSTRUCT
            DISPLAY axcq540_filter_parser('sfaa068') TO s_detail1[1].sfaa068
            DISPLAY axcq540_filter_parser('xccd006') TO s_detail1[1].xccd006
            DISPLAY axcq540_filter_parser('xcce007') TO s_detail1[1].xcce007
            DISPLAY axcq540_filter_parser('xcce008') TO s_detail1[1].xcce008
            DISPLAY axcq540_filter_parser('xcce009') TO s_detail1[1].xcce009
            DISPLAY axcq540_filter_parser('xcbb005') TO s_detail1[1].xcbb005
            DISPLAY axcq540_filter_parser('xccd002') TO s_detail1[1].xccd002
            DISPLAY axcq540_filter_parser('xcce101') TO s_detail1[1].xcce101
            DISPLAY axcq540_filter_parser('xcce102') TO s_detail1[1].xcce102
            DISPLAY axcq540_filter_parser('xcce201') TO s_detail1[1].xcce201
            DISPLAY axcq540_filter_parser('xcce202') TO s_detail1[1].xcce202
            DISPLAY axcq540_filter_parser('xcce301') TO s_detail1[1].xcce301
            DISPLAY axcq540_filter_parser('xcce302') TO s_detail1[1].xcce302
            DISPLAY axcq540_filter_parser('xcce303') TO s_detail1[1].xcce303
            DISPLAY axcq540_filter_parser('xcce304') TO s_detail1[1].xcce304
            DISPLAY axcq540_filter_parser('xcce307') TO s_detail1[1].xcce307
            DISPLAY axcq540_filter_parser('xcce308') TO s_detail1[1].xcce308
            DISPLAY axcq540_filter_parser('xcce901') TO s_detail1[1].xcce901
            DISPLAY axcq540_filter_parser('xcce902') TO s_detail1[1].xcce902



         ON ACTION controlp INFIELD sfaa068
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.arg1 = cl_get_today()
            CALL q_ooeg001_8()                       #呼叫開窗
            DISPLAY g_qryparam.return1 TO sfaa068    #顯示到畫面上
            NEXT FIELD sfaa068                       #返回原欄位
            
         ON ACTION controlp INFIELD xccd006
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_xccd006()                       #呼叫開窗
            DISPLAY g_qryparam.return1 TO xccd006  #顯示到畫面上
            NEXT FIELD xccd006                     #返回原欄位
            
         ON ACTION controlp INFIELD xccd007
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_xccd007()                       #呼叫開窗
            DISPLAY g_qryparam.return1 TO xccd007  #顯示到畫面上
            NEXT FIELD xccd007                     #返回原欄位
            
         ON ACTION controlp INFIELD xcce007
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_xcce007()                       #呼叫開窗
            DISPLAY g_qryparam.return1 TO xcce007  #顯示到畫面上
            NEXT FIELD xcce007                     #返回原欄位
            
         ON ACTION controlp INFIELD xcce008
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_xcce007()                       #呼叫開窗
            DISPLAY g_qryparam.return2 TO xcce008  #顯示到畫面上
            NEXT FIELD xcce008                     #返回原欄位
            
         ON ACTION controlp INFIELD xcce009
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_xcce007()                       #呼叫開窗
            DISPLAY g_qryparam.return3 TO xcce009  #顯示到畫面上
            NEXT FIELD xcce009                     #返回原欄位
            
         ON ACTION controlp INFIELD xcbb005
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_imac003()                       #呼叫開窗
            DISPLAY g_qryparam.return1 TO xcbb005  #顯示到畫面上
            NEXT FIELD xcbb005                     #返回原欄位                                                                        

      END CONSTRUCT
      
      CONSTRUCT g_wc_filter2 ON xcce102a,xcce102b,xcce102c,xcce102d,xcce102e,xcce102f,xcce102g,xcce102h, 
          xcce201,xcce202a,xcce202b,xcce202c,xcce202d,xcce202e,xcce202f,xcce202g,xcce202h,xcce301,xcce302a, 
          xcce302b,xcce302c,xcce302d,xcce302e,xcce302f,xcce302g,xcce302h,xcce303,xcce304a,xcce304b,xcce304c, 
          xcce304d,xcce304e,xcce304f,xcce304g,xcce304h,xcce307,xcce308a,xcce308b,xcce308c,xcce308d,xcce308e, 
          xcce308f,xcce308g,xcce308h,xcce901,xcce902a,xcce902b,xcce902c,xcce902d,xcce902e,xcce902f,xcce902g, 
          xcce902h,xcce006,xcce007,xcce008,xcce009,xcce002,xcce101,sfaa068    
           FROM s_detail2[1].xcce102a,s_detail2[1].xcce102b,s_detail2[1].xcce102c,s_detail2[1].xcce102d, 
               s_detail2[1].xcce102e,s_detail2[1].xcce102f,s_detail2[1].xcce102g,s_detail2[1].xcce102h, 
               s_detail2[1].xcce201,s_detail2[1].xcce202a,s_detail2[1].xcce202b,s_detail2[1].xcce202c, 
               s_detail2[1].xcce202d,s_detail2[1].xcce202e,s_detail2[1].xcce202f,s_detail2[1].xcce202g, 
               s_detail2[1].xcce202h,s_detail2[1].xcce301,s_detail2[1].xcce302a,s_detail2[1].xcce302b, 
               s_detail2[1].xcce302c,s_detail2[1].xcce302d,s_detail2[1].xcce302e,s_detail2[1].xcce302f, 
               s_detail2[1].xcce302g,s_detail2[1].xcce302h,s_detail2[1].xcce303,s_detail2[1].xcce304a, 
               s_detail2[1].xcce304b,s_detail2[1].xcce304c,s_detail2[1].xcce304d,s_detail2[1].xcce304e, 
               s_detail2[1].xcce304f,s_detail2[1].xcce304g,s_detail2[1].xcce304h,s_detail2[1].xcce307, 
               s_detail2[1].xcce308a,s_detail2[1].xcce308b,s_detail2[1].xcce308c,s_detail2[1].xcce308d, 
               s_detail2[1].xcce308e,s_detail2[1].xcce308f,s_detail2[1].xcce308g,s_detail2[1].xcce308h, 
               s_detail2[1].xcce901,s_detail2[1].xcce902a,s_detail2[1].xcce902b,s_detail2[1].xcce902c, 
               s_detail2[1].xcce902d,s_detail2[1].xcce902e,s_detail2[1].xcce902f,s_detail2[1].xcce902g, 
               s_detail2[1].xcce902h ,s_detail2[1].xcce006_2,s_detail2[1].xcce007_2,s_detail2[1].xcce008_2,s_detail2[1].xcce009_2,  
               s_detail2[1].xcce002_2,s_detail2[1].xcce101_2,s_detail2[1].sfaa068_2 
               
       #單身公用欄位開窗相關處理(table 2)
        ON ACTION controlp INFIELD sfaa068_2
            #add-point:ON ACTION controlp INFIELD sfaa068
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.arg1 = cl_get_today()
            CALL q_ooeg001_8()                        #呼叫開窗
            DISPLAY g_qryparam.return1 TO sfaa068_2  #顯示到畫面上
            NEXT FIELD sfaa068_2                     #返回原欄位  
            
         ON ACTION controlp INFIELD xcce007_2
            #add-point:ON ACTION controlp INFIELD xcce007
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_xcce007()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO xcce007_2  #顯示到畫面上
            NEXT FIELD xcce007_2                     #返回原欄位
            #END add-point
            
        ON ACTION controlp INFIELD xcce008_2
            #add-point:ON ACTION controlp INFIELD xcce008
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_xcce007()                           #呼叫開窗
            DISPLAY g_qryparam.return2 TO xcce008_2  #顯示到畫面上
            NEXT FIELD xcce008_2                     #返回原欄位
            #END add-point
            
            
        ON ACTION controlp INFIELD xcce009_2
            #add-point:ON ACTION controlp INFIELD xcce009
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_xcce007()                           #呼叫開窗
            DISPLAY g_qryparam.return3 TO xcce009_2  #顯示到畫面上
            NEXT FIELD xcce009_2    

         ON ACTION controlp INFIELD xcce006_2
            #add-point:ON ACTION controlp INFIELD xccd006
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_xccd006()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO xcce006_2  #顯示到畫面上
            NEXT FIELD xcce006_2
            
            
      END CONSTRUCT
      
      CONSTRUCT g_wc_filter3 ON xcci006,xcci007,xcci008,xcci009,xcci002,sfaa068        
           FROM s_detail3[1].xcci006,s_detail3[1].xcci007,s_detail3[1].xcci008,s_detail3[1].xcci009,s_detail3[1].xcci002,s_detail3[1].sfaa068_3  
           
         BEFORE CONSTRUCT                                                                 
           
        ON ACTION controlp INFIELD sfaa068_3
            #add-point:ON ACTION controlp INFIELD sfaa068
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.arg1 = cl_get_today()
            CALL q_ooeg001_8()                        #呼叫開窗
            DISPLAY g_qryparam.return1 TO sfaa068_3  #顯示到畫面上
            NEXT FIELD sfaa068_3  
            
         ON ACTION controlp INFIELD xcci006
            #add-point:ON ACTION controlp INFIELD xcci006
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_xcch006()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO xcci006  #顯示到畫面上
            NEXT FIELD xcci006
            
         ON ACTION controlp INFIELD xcci007
            #add-point:ON ACTION controlp INFIELD xcci007
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_xcci007()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO xcci007  #顯示到畫面上
            NEXT FIELD xcci007 
            
         ON ACTION controlp INFIELD xcci008
            #add-point:ON ACTION controlp INFIELD xcci008
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_xcci007()                           #呼叫開窗
            DISPLAY g_qryparam.return2 TO xcci008  #顯示到畫面上
            NEXT FIELD xcci008                     #返回原欄位
            #END add-point
        ON ACTION controlp INFIELD xcci009
            #add-point:ON ACTION controlp INFIELD xcci009
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_xcci007()                       #呼叫開窗
            DISPLAY g_qryparam.return3 TO xcci009  #顯示到畫面上
            NEXT FIELD xcci009                     #返回原欄位	   

      END CONSTRUCT                                                               
      
      
      BEFORE DIALOG

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
      LET g_wc_filter = g_wc_filter, " "
      LET g_wc_filter2 = g_wc_filter2, " "
      LET g_wc_filter3 = g_wc_filter3, " "
   ELSE
      LET g_wc_filter = g_wc_filter_t
      LET g_wc_filter2 = g_wc_filter2_t
      LET g_wc_filter3 = g_wc_filter3_t
      LET g_wc = g_wc_t
   END IF
   CALL axcq540_filter_show('sfaa068','sfaa068')
   CALL axcq540_filter_show('xccd006','xccd006')
   CALL axcq540_filter_show('xcce007','xcce007')
   CALL axcq540_filter_show('xcce008','xcce008')
   CALL axcq540_filter_show('xcce009','xcce009')
   CALL axcq540_filter_show('xcbb005','xcbb005')
   CALL axcq540_filter_show('xccd002','xccd002')
   CALL axcq540_filter_show('xcce101','xcce101')
   CALL axcq540_filter_show('xcce102','xcce102')
   CALL axcq540_filter_show('xcce201','xcce201')
   CALL axcq540_filter_show('xcce202','xcce202')
   CALL axcq540_filter_show('xcce301','xcce301')
   CALL axcq540_filter_show('xcce302','xcce302')
   CALL axcq540_filter_show('xcce303','xcce303')
   CALL axcq540_filter_show('xcce304','xcce304')
   CALL axcq540_filter_show('xcce307','xcce307')
   CALL axcq540_filter_show('xcce308','xcce308')
   CALL axcq540_filter_show('xcce901','xcce901')
   CALL axcq540_filter_show('xcce902','xcce902')
   
   CALL axcq540_b_fill()

   CALL gfrm_curr.setFieldHidden("formonly.sel", FALSE)
   CALL gfrm_curr.setFieldHidden("formonly.statepic", FALSE)
END FUNCTION
################################################################################
# Descriptions...: Browser標題欄位顯示搜尋條件
# Memo...........:
# Usage..........: axcq540_filter_show(ps_field,ps_object)
#                  RETURNING
# Input parameter: 
# Return code....: 
# Date & Author..: 151130 By Polly
# Modify.........: 151130-00003#2  增加二次蒒選功能
################################################################################
PRIVATE FUNCTION axcq540_filter_show(ps_field,ps_object)
   DEFINE ps_field         STRING
   DEFINE ps_object        STRING
   DEFINE lnode_item       om.DomNode
   DEFINE ls_title         STRING
   DEFINE ls_name          STRING
   DEFINE ls_condition     STRING
   
   LET ls_name = "formonly.", ps_object
 
   LET lnode_item = gfrm_curr.findNode("TableColumn", ls_name)
   LET ls_title = lnode_item.getAttribute("text")
   IF ls_title.getIndexOf('※',1) > 0 THEN
      LEt ls_title = ls_title.subString(1,ls_title.getIndexOf('※',1)-1)
   END IF   
   
    #顯示資料組合
   LET ls_condition = axcq540_filter_parser(ps_field)
   IF NOT cl_null(ls_condition) THEN
      LET ls_title = ls_title, '※', ls_condition, '※'
   END IF
 
   #將資料顯示回去
   CALL lnode_item.setAttribute("text",ls_title)
   
END FUNCTION
################################################################################
# Descriptions...: filter欄位解析
# Memo...........:
# Usage..........: axcq540_filter_parser(ps_field)
#                  RETURNING
# Input parameter: 
# Return code....: 
# Date & Author..: 151130 By Polly
# Modify.........: 151130-00003#2  增加二次蒒選功能
################################################################################
PRIVATE FUNCTION axcq540_filter_parser(ps_field)
   DEFINE ps_field   STRING
   DEFINE ls_tmp     STRING
   DEFINE li_tmp     LIKE type_t.num5
   DEFINE li_tmp2    LIKE type_t.num5
   DEFINE ls_var     STRING
   
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
 
