#該程式已解開Section, 不再透過樣板產出!
{<section id="aect801.description" >}
#+ Version..: T100-ERP-1.00.00(SD版次:1,PR版次:1) Build-000202
#+ 
#+ Filename...: aect801
#+ Description: 料件製程資料新增、修改申請作業
#+ Creator....: 01258(2014-07-07 17:30:45)
#+ Modifier...: 01258(2014-09-10 10:14:55) -SD/PR- 07556
#+ Buildtype..: 應用 t01 樣板自動產生
#+ 以上段落由子樣板a00產生
 
{</section>}
 
{<section id="aect801.global" >}
#151125-00001#1...: 2015/11/27 BY fionchen 執行[作廢]作業時,增加詢問「是否執行作廢？」
#160318-00025#3...: 2016/04/11 By 07675    將重複內容的錯誤訊息置換為公用錯誤訊息(r.v）
#160613-00038#1     2016/06/14 By 06821    s_aooi200_chk_slip傳入值(原寫死程式代號)，改用g_prog處理
#160816-00001#2     2016/08/16 By 08742    抓取理由碼改CALL sub
#161108-00012#1     2016/11/08 By 08734    g_browser_cnt 由num5改為num10 
#161108-00023#4     2016/11/17 By 02295    当修改当前站的本站作业和作业序时，需要更新其他站中上站作业为原本站作业和作业序的值为新值
#160824-00007#227   2016/12/01 By sakura   新舊值備份處理
#161124-00048#2     2016/12/06 By 08734    星号整批调整
#170213-00014#1   2017/02/13  By Jessica  aect801的BPM整合功能修正:
#                                         1. 沒有確認元件(s_aect801_ws_confirm)
#                                         2.「提交成功後」畫面會自動關閉
#                                         3.「抽單、已拒絕」此筆單據狀態不是未確認,不可修改！
#                                         4.「作廢」仍有修改、刪除按鈕
#                                         5. 增加s_detail3單身是排除控件
       
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
PRIVATE type type_g_ecca_m        RECORD
       eccadocno LIKE ecca_t.eccadocno, 
   ecca001 LIKE ecca_t.ecca001, 
   oobxl003 LIKE type_t.chr80, 
   ecca001_desc LIKE type_t.chr80, 
   eccadocdt LIKE ecca_t.eccadocdt, 
   ecca001_desc_1 LIKE type_t.chr80, 
   ecca004 LIKE ecca_t.ecca004, 
   ecca002 LIKE ecca_t.ecca002, 
   eccasite LIKE ecca_t.eccasite, 
   ecca003 LIKE ecca_t.ecca003, 
   ecca900 LIKE ecca_t.ecca900, 
   ecca905 LIKE ecca_t.ecca905, 
   ecca905_desc LIKE type_t.chr80, 
   ecca906 LIKE ecca_t.ecca906, 
   eccastus LIKE ecca_t.eccastus, 
   eccaownid LIKE ecca_t.eccaownid, 
   eccaownid_desc LIKE type_t.chr80, 
   eccaowndp LIKE ecca_t.eccaowndp, 
   eccaowndp_desc LIKE type_t.chr80, 
   eccacrtid LIKE ecca_t.eccacrtid, 
   eccacrtid_desc LIKE type_t.chr80, 
   eccacrtdp LIKE ecca_t.eccacrtdp, 
   eccacrtdp_desc LIKE type_t.chr80, 
   eccacrtdt LIKE ecca_t.eccacrtdt, 
   eccamodid LIKE ecca_t.eccamodid, 
   eccamodid_desc LIKE type_t.chr80, 
   eccamoddt LIKE ecca_t.eccamoddt, 
   eccacnfid LIKE ecca_t.eccacnfid, 
   eccacnfid_desc LIKE type_t.chr80, 
   eccacnfdt LIKE ecca_t.eccacnfdt
       END RECORD
 
#單身 type 宣告
PRIVATE TYPE type_g_eccb_d        RECORD
       eccb003 LIKE eccb_t.eccb003, 
   eccb004 LIKE eccb_t.eccb004, 
   eccb004_desc LIKE type_t.chr500, 
   eccb005 LIKE eccb_t.eccb005, 
   eccb006 LIKE eccb_t.eccb006, 
   eccb007 LIKE eccb_t.eccb007, 
   eccb008 LIKE eccb_t.eccb008, 
   eccb008_desc LIKE type_t.chr500, 
   eccb009 LIKE eccb_t.eccb009, 
   eccb010 LIKE eccb_t.eccb010, 
   eccb010_desc LIKE type_t.chr500, 
   eccb011 LIKE eccb_t.eccb011, 
   eccb012 LIKE eccb_t.eccb012, 
   eccb012_desc LIKE type_t.chr500, 
   eccb024 LIKE eccb_t.eccb024, 
   eccb025 LIKE eccb_t.eccb025, 
   eccb026 LIKE eccb_t.eccb026, 
   eccb027 LIKE eccb_t.eccb027, 
   eccb034 LIKE eccb_t.eccb034, 
   eccb013 LIKE eccb_t.eccb013, 
   eccb014 LIKE eccb_t.eccb014, 
   eccb014_desc LIKE type_t.chr500, 
   eccb015 LIKE eccb_t.eccb015, 
   eccb016 LIKE eccb_t.eccb016, 
   eccb017 LIKE eccb_t.eccb017, 
   eccb018 LIKE eccb_t.eccb018, 
   eccb019 LIKE eccb_t.eccb019, 
   eccb020 LIKE eccb_t.eccb020, 
   eccb030 LIKE eccb_t.eccb030, 
   eccb030_desc LIKE type_t.chr500, 
   eccb031 LIKE eccb_t.eccb031, 
   eccb032 LIKE eccb_t.eccb032, 
   eccb021 LIKE eccb_t.eccb021, 
   eccb021_desc LIKE type_t.chr500, 
   eccb022 LIKE eccb_t.eccb022, 
   eccb023 LIKE eccb_t.eccb023, 
   eccb033 LIKE eccb_t.eccb033, 
   eccb028 LIKE eccb_t.eccb028, 
   eccb029 LIKE eccb_t.eccb029, 
   ooff013 LIKE type_t.chr500, 
   eccb035 LIKE eccb_t.eccb035, 
   eccb036 LIKE eccb_t.eccb036, 
   eccb901 LIKE eccb_t.eccb901, 
   eccb905 LIKE eccb_t.eccb905, 
   eccb905_desc LIKE type_t.chr500, 
   eccb906 LIKE eccb_t.eccb906, 
   eccb001 LIKE eccb_t.eccb001, 
   eccb002 LIKE eccb_t.eccb002, 
   eccb900 LIKE eccb_t.eccb900, 
   eccb902 LIKE eccb_t.eccb902
       END RECORD
PRIVATE TYPE type_g_eccb2_d RECORD
       eccc004 LIKE eccc_t.eccc004, 
   eccc005 LIKE eccc_t.eccc005, 
   eccc005_desc LIKE type_t.chr500, 
   eccc005_desc_1 LIKE type_t.chr500, 
   eccc006 LIKE eccc_t.eccc006, 
   eccc006_desc LIKE type_t.chr500, 
   eccc007 LIKE eccc_t.eccc007, 
   eccc008 LIKE eccc_t.eccc008, 
   eccc009 LIKE eccc_t.eccc009, 
   eccc009_desc LIKE type_t.chr500, 
   eccc010 LIKE eccc_t.eccc010, 
   eccc901 LIKE eccc_t.eccc901, 
   eccc905 LIKE eccc_t.eccc905, 
   eccc905_desc LIKE type_t.chr500, 
   eccc906 LIKE eccc_t.eccc906, 
   eccc001 LIKE eccc_t.eccc001, 
   eccc002 LIKE eccc_t.eccc002, 
   eccc900 LIKE eccc_t.eccc900, 
   eccc902 LIKE eccc_t.eccc902
       END RECORD
 
 
#模組變數(Module Variables)
DEFINE g_ecca_m          type_g_ecca_m
DEFINE g_ecca_m_t        type_g_ecca_m
DEFINE g_ecca_m_o        type_g_ecca_m
 
   DEFINE g_eccadocno_t LIKE ecca_t.eccadocno
DEFINE g_eccasite_t LIKE ecca_t.eccasite
 
 
DEFINE g_eccb_d          DYNAMIC ARRAY OF type_g_eccb_d
DEFINE g_eccb_d_t        type_g_eccb_d
DEFINE g_eccb_d_o        type_g_eccb_d
DEFINE g_eccb2_d   DYNAMIC ARRAY OF type_g_eccb2_d
DEFINE g_eccb2_d_t type_g_eccb2_d
DEFINE g_eccb2_d_o type_g_eccb2_d
 
 
DEFINE g_browser    DYNAMIC ARRAY OF RECORD    #資料瀏覽之欄位 
         b_statepic     LIKE type_t.chr50,
            b_eccadocno LIKE ecca_t.eccadocno,
   b_oobxl003_1 LIKE type_t.chr500,
      b_eccasite LIKE ecca_t.eccasite,
      b_eccadocdt LIKE ecca_t.eccadocdt,
      b_ecca004 LIKE ecca_t.ecca004,
      b_ecca001 LIKE ecca_t.ecca001,
   b_ecca001_desc LIKE type_t.chr80,
   b_ecca001_desc_2 LIKE type_t.chr500,
      b_ecca002 LIKE ecca_t.ecca002,
      b_ecca003 LIKE ecca_t.ecca003,
      b_ecca900 LIKE ecca_t.ecca900,
      b_ecca905 LIKE ecca_t.ecca905,
   b_ecca905_desc LIKE type_t.chr80
      END RECORD 
      
DEFINE g_browser_f  RECORD #資料瀏覽之欄位 
       b_statepic     LIKE type_t.chr50,
          b_eccadocno LIKE ecca_t.eccadocno,
   b_oobxl003_1 LIKE type_t.chr500,
      b_eccasite LIKE ecca_t.eccasite,
      b_eccadocdt LIKE ecca_t.eccadocdt,
      b_ecca004 LIKE ecca_t.ecca004,
      b_ecca001 LIKE ecca_t.ecca001,
   b_ecca001_desc LIKE type_t.chr80,
   b_ecca001_desc_2 LIKE type_t.chr500,
      b_ecca002 LIKE ecca_t.ecca002,
      b_ecca003 LIKE ecca_t.ecca003,
      b_ecca900 LIKE ecca_t.ecca900,
      b_ecca905 LIKE ecca_t.ecca905,
   b_ecca905_desc LIKE type_t.chr80
      END RECORD 
      
 
DEFINE g_wc                  STRING
DEFINE g_wc_t                STRING
DEFINE g_wc2                 STRING                          #單身CONSTRUCT結果
DEFINE g_wc2_table1          STRING
 
DEFINE g_wc2_table2   STRING
 
 
DEFINE g_wc_filter           STRING
DEFINE g_wc_filter_t         STRING
 
DEFINE g_sql                 STRING
DEFINE g_forupd_sql          STRING
DEFINE g_cnt                 LIKE type_t.num10
DEFINE g_current_idx         LIKE type_t.num10     
DEFINE g_jump                LIKE type_t.num10        
DEFINE g_no_ask              LIKE type_t.num5        
DEFINE g_rec_b               LIKE type_t.num10   #161108-00012#1 num5==》num10        
DEFINE l_ac                  LIKE type_t.num10   #161108-00012#1 num5==》num10 
DEFINE g_curr_diag           ui.Dialog                     #Current Dialog
    
DEFINE g_pagestart           LIKE type_t.num10   #161108-00012#1 num5==》num10         
DEFINE gwin_curr             ui.Window                     #Current Window
DEFINE gfrm_curr             ui.Form                       #Current Form
DEFINE g_page_action         STRING                        #page action
DEFINE g_header_hidden       LIKE type_t.num5              #隱藏單頭
DEFINE g_worksheet_hidden    LIKE type_t.num5              #隱藏工作Panel
DEFINE g_page                STRING                        #第幾頁
DEFINE g_state               STRING       
 
DEFINE g_detail_cnt          LIKE type_t.num10              #單身總筆數  #161108-00012#1 num5==》num10
DEFINE g_detail_idx          LIKE type_t.num10              #單身目前所在筆數  #161108-00012#1 num5==》num10
DEFINE g_detail_idx2         LIKE type_t.num10              #單身2目前所在筆數  #161108-00012#1 num5==》num10
#DEFINE g_browser_cnt         LIKE type_t.num5              #Browser總筆數              #161108-00012#1  2016/11/08 By 08734 mark
DEFINE g_browser_cnt         LIKE type_t.num10              #Browser總筆數              #161108-00012#1  2016/11/08 By 08734 add
DEFINE g_browser_idx         LIKE type_t.num10              #Browser目前所在筆數  #161108-00012#1 num5==》num10
DEFINE g_temp_idx            LIKE type_t.num10              #Browser目前所在筆數(暫存用) #161108-00012#1 num5==》num10
DEFINE g_order               STRING                        #查詢排序欄位
                                                        
DEFINE g_current_row         LIKE type_t.num10              #Browser所在筆數  #161108-00012#1 num5==》num10
DEFINE g_current_sw          BOOLEAN                       #Browser所在筆數用開關
DEFINE g_current_page        LIKE type_t.num10              #目前所在頁數  #161108-00012#1 num5==》num10
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
DEFINE g_ecch003             LIKE ecch_t.ecch003
DEFINE g_ecch007             LIKE ecch_t.ecch007
DEFINE g_wc2_table3          STRING
DEFINE l_ac1                 LIKE type_t.num10   #161108-00012#1 num5==》num10
DEFINE g_rec_b1              LIKE type_t.num10  #161108-00012#1 num5==》num10         
DEFINE l_ac2                 LIKE type_t.num10  #161108-00012#1 num5==》num10
DEFINE g_rec_b2              LIKE type_t.num10  #161108-00012#1 num5==》num10
DEFINE g_detail_idx3         LIKE type_t.num10  #161108-00012#1 num5==》num10
#單身3 type 宣告
TYPE type_g_eccb3_d          RECORD
       eccdseq               LIKE eccd_t.eccdseq,
       eccd005               LIKE eccd_t.eccd005,
       eccd006               LIKE eccd_t.eccd006,
       eccd007               LIKE eccd_t.eccd007, 
       eccd008               LIKE eccd_t.eccd008,
       eccd901               LIKE eccd_t.eccd901,
       eccd905               LIKE eccd_t.eccd905,
       eccd905_desc          LIKE type_t.chr80,
       eccd906               LIKE eccd_t.eccd906
                             END RECORD      
DEFINE g_eccb3_d             DYNAMIC ARRAY OF type_g_eccb3_d
DEFINE g_eccb3_d_t           type_g_eccb3_d
DEFINE g_eccb_d_color        DYNAMIC ARRAY OF RECORD
       eccb003               STRING,
       eccb004               STRING,
       eccb004_desc          STRING,
       eccb005               STRING,
       eccb006               STRING,
       eccb007               STRING,
       eccb008               STRING,
       eccb008_desc          STRING,
       eccb009               STRING,
       eccb010               STRING,
       eccb010_desc          STRING,
       eccb011               STRING,
       eccb012               STRING,
       eccb012_desc          STRING,
       eccb024               STRING,
       eccb025               STRING,
       eccb026               STRING,
       eccb027               STRING,
       eccb034               STRING,
       eccb013               STRING,
       eccb014               STRING,
       eccb014_desc          STRING,
       eccb015               STRING,
       eccb016               STRING,
       eccb017               STRING,
       eccb018               STRING,
       eccb019               STRING,
       eccb020               STRING,
       eccb030               STRING,
       eccb030_desc          STRING,
       eccb031               STRING,
       eccb032               STRING,
       eccb021               STRING,
       eccb021_desc          STRING,
       eccb022               STRING,
       eccb023               STRING,
       eccb033               STRING,
       eccb028               STRING,
       eccb029               STRING,
       ooff013               STRING,
       eccb035               STRING,
       eccb036               STRING,
       eccb901               STRING,
       eccb905               STRING,
       eccb905_desc          STRING,
       eccb906               STRING
       END RECORD
DEFINE g_eccb2_d_color       DYNAMIC ARRAY OF RECORD
       eccc004               STRING,
       eccc005               STRING,
       eccc005_desc          STRING,
       eccc005_desc_1        STRING,
       eccc006               STRING,
       eccc006_desc          STRING,
       eccc007               STRING,
       eccc008               STRING,
       eccc009               STRING,
       eccc009_desc          STRING,
       eccc010               STRING,
       eccc901               STRING,
       eccc905               STRING,
       eccc905_desc          STRING,
       eccc906               STRING
       END RECORD
DEFINE g_eccb3_d_color       DYNAMIC ARRAY OF RECORD
       eccdseq               STRING,
       eccd005               STRING,
       eccd006               STRING,
       eccd007               STRING,
       eccd008               STRING,
       eccd901               STRING,
       eccd905               STRING,
       eccd905_desc          STRING,
       eccd906               STRING
                             END RECORD
#end add-point
 
#add-point:傳入參數說明(global.argv)
DEFINE g_acc                 LIKE gzcb_t.gzcb007
DEFINE g_flag                LIKE type_t.chr1
#end add-point
 
{</section>}
 
{<section id="aect801.main" >}
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
   CALL cl_ap_init("aec","")
 
   #add-point:作業初始化
   
   #end add-point
   
   
 
   #LOCK CURSOR (identifier)
   #add-point:SQL_define
   
   #end add-point
   LET g_forupd_sql = " SELECT eccadocno,ecca001,'','',eccadocdt,'',ecca004,ecca002,eccasite,ecca003, 
       ecca900,ecca905,'',ecca906,eccastus,eccaownid,'',eccaowndp,'',eccacrtid,'',eccacrtdp,'',eccacrtdt, 
       eccamodid,'',eccamoddt,eccacnfid,'',eccacnfdt", 
                      " FROM ecca_t",
                      " WHERE eccaent= ? AND eccasite=? AND eccadocno=? FOR UPDATE"
   #add-point:SQL_define
   
   #end add-point
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)                #轉換不同資料庫語法
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE aect801_cl CURSOR FROM g_forupd_sql                 # LOCK CURSOR
 
   LET g_sql = " SELECT UNIQUE t0.eccadocno,t0.ecca001,t0.eccadocdt,t0.ecca004,t0.ecca002,t0.eccasite, 
       t0.ecca003,t0.ecca900,t0.ecca905,t0.ecca906,t0.eccastus,t0.eccaownid,t0.eccaowndp,t0.eccacrtid, 
       t0.eccacrtdp,t0.eccacrtdt,t0.eccamodid,t0.eccamoddt,t0.eccacnfid,t0.eccacnfdt,t1.imaal003 ,t2.oocql004 , 
       t3.ooag011 ,t4.ooefl003 ,t5.ooag011 ,t6.ooefl003 ,t7.ooag011 ,t8.ooag011",
               " FROM ecca_t t0",
                              " LEFT JOIN imaal_t t1 ON t1.imaalent='"||g_enterprise||"' AND t1.imaal001=t0.ecca001 AND t1.imaal002='"||g_dlang||"' ",
               " LEFT JOIN oocql_t t2 ON t2.oocqlent='"||g_enterprise||"' AND t2.oocql001='225' AND t2.oocql002=t0.ecca905 AND t2.oocql003='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t3 ON t3.ooagent='"||g_enterprise||"' AND t3.ooag001=t0.eccaownid  ",
               " LEFT JOIN ooefl_t t4 ON t4.ooeflent='"||g_enterprise||"' AND t4.ooefl001=t0.eccaowndp AND t4.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t5 ON t5.ooagent='"||g_enterprise||"' AND t5.ooag001=t0.eccacrtid  ",
               " LEFT JOIN ooefl_t t6 ON t6.ooeflent='"||g_enterprise||"' AND t6.ooefl001=t0.eccacrtdp AND t6.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t7 ON t7.ooagent='"||g_enterprise||"' AND t7.ooag001=t0.eccamodid  ",
               " LEFT JOIN ooag_t t8 ON t8.ooagent='"||g_enterprise||"' AND t8.ooag001=t0.eccacnfid  ",
 
               " WHERE t0.eccaent = '" ||g_enterprise|| "' AND t0.eccasite = ? AND t0.eccadocno = ?"
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   #add-point:SQL_define
   
   #end add-point
   PREPARE aect801_master_referesh FROM g_sql
 
 
 
   
   IF g_bgjob = "Y" THEN
      #add-point:Service Call
      
      #end add-point
   ELSE
      #畫面開啟 (identifier)
      OPEN WINDOW w_aect801 WITH FORM cl_ap_formpath("aec",g_code)
   
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
   
      #程式初始化
      CALL aect801_init()   
 
      #進入選單 Menu (="N")
      CALL aect801_ui_dialog() 
      
      #add-point:畫面關閉前
      
      #end add-point
 
      #畫面關閉
      CLOSE WINDOW w_aect801
      
   END IF 
   
   CLOSE aect801_cl
   
   
 
   #add-point:作業離開前
   
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
   
END MAIN
 
 
 
{</section>}
 
{<section id="aect801.init" >}
#+ 瀏覽頁簽資料初始化
PRIVATE FUNCTION aect801_init()
   #add-point:init段define
   
   #end add-point    
   
   LET g_bfill       = "Y"
   LET g_detail_idx  = 1
   LET g_detail_idx2 = 1
   LET g_error_show  = 1
   LET l_ac = 1
      CALL cl_set_combo_scc_part('eccastus','13','A,D,N,R,W,X,Y')
 
      CALL cl_set_combo_scc('ecca004','4030') 
   CALL cl_set_combo_scc('eccb901','5448') 
   CALL cl_set_combo_scc('eccc901','5448') 
 
   LET gwin_curr = ui.Window.getCurrent()  #取得現行畫面
   LET gfrm_curr = gwin_curr.getForm()     #取出物件化後的畫面物件
 
   #add-point:畫面資料初始化
   CALL cl_set_combo_scc('b_ecca004','4030') 
   CALL cl_set_combo_scc('eccb006','1202') 
   CALL cl_set_combo_scc('eccc010','1108') 
   CALL cl_set_combo_scc('eccd901','5448') 
   LET g_acc = ''
   #抓取[T:系統分類值檔].[C:系統分類碼]=24且[T:系統分類值檔].[C:系統分類碼]=g_prog 的[T:系統分類值檔].[C:參考欄位>
   #SELECT gzcb004 INTO g_acc FROM gzcb_t WHERE gzcb001 = '24' AND gzcb002 = g_prog   #160816-00001#2 mark
   
   LET g_acc = s_fin_get_scc_value('24',g_prog,'2')   #160816-00001#2  Add  
   #end add-point
   
   CALL aect801_default_search()
    
END FUNCTION
 
{</section>}
 
{<section id="aect801.ui_dialog" >}
#+ 功能選單
PRIVATE FUNCTION aect801_ui_dialog()
   DEFINE li_idx    LIKE type_t.num10  #161108-00012#1 num5==》num10
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
   #+ 此段落由子樣板a42產生
   #進入程式時預設執行的動作
   CASE g_actdefault
      WHEN "insert"
         LET g_action_choice="insert"
         LET g_actdefault = ""
         IF cl_auth_chk_act("insert") THEN
            CALL aect801_insert()
            #add-point:ON ACTION insert

            #END add-point
         END IF
 
      #add-point:action default自訂

      #end add-point
      OTHERWISE
         
   END CASE
 
 
   
   LET lb_first = TRUE
   
   #add-point:ui_dialog段before dialog 

   #end add-point
   
   WHILE TRUE 
   
      #先填充browser資料
      CALL aect801_browser_fill("")
      CALL lib_cl_dlg.cl_dlg_before_display()
      CALL cl_notice()
      
      #判斷前一個動作是否為新增, 若是的話切換到新增的筆數
      IF g_state = "Y" THEN
         FOR li_idx = 1 TO g_browser.getLength()
            IF g_browser[li_idx].b_eccadocno = g_eccadocno_t
               THEN
               LET g_current_row = li_idx
               LET g_current_idx = li_idx
               EXIT FOR
            END IF
         END FOR
         LET g_state = ""
      END IF
            
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
               
               CALL aect801_fetch('') # reload data
               LET l_ac = 1
               CALL aect801_ui_detailshow() #Setting the current row 
      
               CALL aect801_idx_chk()
               #NEXT FIELD eccb003
         
         END DISPLAY
        
         DISPLAY ARRAY g_eccb_d TO s_detail1.* ATTRIBUTES(COUNT=g_rec_b) #page1  
    
            BEFORE ROW
               #顯示單身筆數
               CALL aect801_idx_chk()
               #確定當下選擇的筆數
               LET l_ac = DIALOG.getCurrentRow("s_detail1")
               LET g_detail_idx = l_ac
               #填充下層單身資料
CALL aect801_b_fill2('2')
 
               #add-point:page1, before row動作
               CALL s_hint_show('ecch_t','eccb_t','ecbb_t',g_ecca_m.eccadocno,g_ecca_m.ecca900,g_eccb_d[g_detail_idx].eccb003,0,0)
               
               DISPLAY ARRAY g_eccb2_d TO s_detail2.* ATTRIBUTES(COUNT=g_rec_b)  
                  BEFORE DISPLAY
                    EXIT DISPLAY
               END DISPLAY
               LET g_detail_idx2 = 1 
               CALL aect801_b_fill3()
               DISPLAY ARRAY g_eccb3_d TO s_detail3.* ATTRIBUTES(COUNT=g_rec_b)  
                  BEFORE DISPLAY
                    EXIT DISPLAY
               END DISPLAY
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
               CALL aect801_idx_chk()
               #add-point:page1自定義行為
               CALL DIALOG.setCellAttributes(g_eccb_d_color)
               #end add-point
               
            #自訂ACTION(detail_show,page_1)
            
               
            #add-point:page1自定義行為

            #end add-point
               
         END DISPLAY
        
 
         
         #第二階單身段落
         DISPLAY ARRAY g_eccb2_d TO s_detail2.* ATTRIBUTES(COUNT=g_rec_b)  
    
            BEFORE ROW
               #顯示單身筆數
               CALL aect801_idx_chk()
               LET l_ac = DIALOG.getCurrentRow("s_detail2")
               LET g_detail_idx2 = l_ac
               
               #add-point:page2, before row動作
               CALL s_hint_show('ecch_t','eccc_t','ecbc_t',g_ecca_m.eccadocno,g_ecca_m.ecca900,g_eccb_d[g_detail_idx].eccb003,g_eccb2_d[g_detail_idx2].eccc004,0)
               
               CALL aect801_b_fill3()
               DISPLAY ARRAY g_eccb3_d TO s_detail3.* ATTRIBUTES(COUNT=g_rec_b)  
                  BEFORE DISPLAY
                    EXIT DISPLAY
               END DISPLAY
               #end add-point
               
            BEFORE DISPLAY
               #如果一直都在單身則控制筆數位置
               IF g_loc = 'd' THEN
                  CALL FGL_SET_ARR_CURR(g_detail_idx2)
               END IF
               LET g_loc = 'd'
               LET l_ac = DIALOG.getCurrentRow("s_detail2")
               LET g_current_page = 2
               #顯示單身筆數
               CALL aect801_idx_chk()
               #add-point:page2自定義行為
               CALL DIALOG.setCellAttributes(g_eccb2_d_color)
               #end add-point
      
            #自訂ACTION(detail_show,page_2)
            
         
            #add-point:page2自定義行為

            #end add-point
         
         END DISPLAY
 
         
         #add-point:ui_dialog段自定義display array
         DISPLAY ARRAY g_eccb3_d TO s_detail3.* ATTRIBUTES(COUNT=g_rec_b) #page2  
    
            BEFORE ROW
               CALL aect801_idx_chk()
               LET g_detail_idx3 = DIALOG.getCurrentRow("s_detail3")
               CALL s_hint_show('ecch_t','eccd_t','ecbd_t',g_ecca_m.eccadocno,g_ecca_m.ecca900,g_eccb_d[g_detail_idx].eccb003,g_eccb2_d[g_detail_idx2].eccc004,g_eccb3_d[g_detail_idx3].eccdseq)
               
            BEFORE DISPLAY
               CALL FGL_SET_ARR_CURR(g_detail_idx3)
               LET g_detail_idx3 = DIALOG.getCurrentRow("s_detail3")
               CALL aect801_idx_chk()
               LET g_current_page = 3
               CALL DIALOG.setCellAttributes(g_eccb3_d_color)
               
         END DISPLAY
         #end add-point
         
         SUBDIALOG lib_cl_dlg.cl_dlg_qryplan
         SUBDIALOG lib_cl_dlg.cl_dlg_relateapps
      
         BEFORE DIALOG
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
               CALL aect801_fetch('') # reload data
            END IF
            #LET g_detail_idx = 1
            CALL aect801_ui_detailshow() #Setting the current row 
            
            #筆數顯示
            LET g_current_page = 1
            CALL aect801_idx_chk()
            
            #add-point:ui_dialog段before_dialog2

            #end add-point
        
         #狀態碼切換
         ON ACTION statechange
            LET g_action_choice = "statechange"
            CALL aect801_statechange()
            #根據資料狀態切換action狀態
            CALL cl_set_act_visible("statechange,modify,modify_detail,delete,reproduce", TRUE)
            CALL aect801_set_act_visible()   
            CALL aect801_set_act_no_visible()
            IF NOT (g_ecca_m.eccasite IS NULL
              OR g_ecca_m.eccadocno IS NULL
 
              ) THEN
               #組合條件
               LET g_add_browse = " eccaent = '" ||g_enterprise|| "' AND",
                                  " eccasite = '", g_ecca_m.eccasite, "' "
                                  ," AND eccadocno = '", g_ecca_m.eccadocno, "' "
 
               #填到對應位置
               CALL aect801_browser_fill("")
            END IF
         #此段落由子樣板a32產生
         #簽核狀況
         ON ACTION bpm_status
            #查詢簽核狀況, 統一建立HyperLink
            CALL cl_bpm_status()
            #add-point:ON ACTION bpm_status

            #END add-point
 
 
 
 
          
         #查詢方案選擇 
         ON ACTION queryplansel
            CALL cl_dlg_qryplan_select() RETURNING ls_wc
            #不是空條件才寫入g_wc跟重新找資料
            IF NOT cl_null(ls_wc) THEN
               LET g_wc = ls_wc
               CALL aect801_browser_fill("F")   #browser_fill()會將notice區塊清空
               CALL cl_notice()   #重新顯示,此處不可用EXIT DIALOG, SUBDIALOG重讀會導致部分變數消失
            END IF
         
         #查詢方案選擇
         ON ACTION qbe_select
            CALL cl_qbe_list("m") RETURNING ls_wc
            IF NOT cl_null(ls_wc) THEN
               LET g_wc = ls_wc
               #取得條件後需要重查、跳到結果第一筆資料的功能程式段
               CALL aect801_browser_fill("F")
               IF g_browser_cnt = 0 THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "" 
                  LET g_errparam.code   = "-100" 
                  LET g_errparam.popup  = TRUE 
                  CALL cl_err()
 
                  CLEAR FORM
               ELSE
                  CALL aect801_fetch("F")
               END IF
            END IF
            #重新搜尋會將notice區塊清空,此處不可用EXIT DIALOG, SUBDIALOG重讀會導致部分變數消失
            CALL cl_notice()
          
         #+ 此段落由子樣板a49產生
            #過濾瀏覽頁資料
            ON ACTION filter
               #add-point:filter action

               #end add-point
               CALL aect801_filter()
               EXIT DIALOG
 
 
 
         
         ON ACTION first
            CALL aect801_fetch('F')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL aect801_idx_chk()
            
         ON ACTION previous
            CALL aect801_fetch('P')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL aect801_idx_chk()
            
         ON ACTION jump
            CALL aect801_fetch('/')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL aect801_idx_chk()
            
         ON ACTION next
            CALL aect801_fetch('N')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL aect801_idx_chk()
            
         ON ACTION last
            CALL aect801_fetch('L')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL aect801_idx_chk()
            
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
                  LET g_export_node[1] = base.typeInfo.create(g_eccb_d)
                  LET g_export_node[2] = base.typeInfo.create(g_eccb2_d)
 
                  #add-point:ON ACTION exporttoexcel

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
               NEXT FIELD eccb003
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
         ON ACTION checkout
            LET g_action_choice="checkout"
            IF cl_auth_chk_act("checkout") THEN
               
               #add-point:ON ACTION checkout
               IF g_detail_idx > 0 THEN
                   IF NOT cl_null(g_ecca_m.eccadocno) AND NOT cl_null(g_eccb_d[g_detail_idx].eccb003) AND NOT cl_null(g_eccb_d[g_detail_idx].eccb004)  AND NOT cl_null(g_eccb_d[g_detail_idx].eccb005) THEN
                      CALL aect801_02(g_ecca_m.eccadocno,g_eccb_d[g_detail_idx].eccb003,g_eccb_d[g_detail_idx].eccb004,g_eccb_d[g_detail_idx].eccb005,'2','N')
                   END IF
                END IF
               #END add-point
               
            END IF
 
 
         #+ 此段落由子樣板a43產生
         ON ACTION modify
            LET g_action_choice="modify"
            IF cl_auth_chk_act("modify") THEN
               LET g_aw = ''
               CALL aect801_modify()
               #add-point:ON ACTION modify

               #END add-point
               
            END IF
 
 
         #+ 此段落由子樣板a43產生
         ON ACTION modify_detail
            LET g_action_choice="modify_detail"
            IF cl_auth_chk_act("modify") THEN
               LET g_aw = g_curr_diag.getCurrentItem()
               CALL aect801_modify()
               #add-point:ON ACTION modify_detail

               #END add-point
               
            END IF
 
 
         #+ 此段落由子樣板a43產生
         ON ACTION delete
            LET g_action_choice="delete"
            IF cl_auth_chk_act("delete") THEN
               CALL aect801_delete()
               #add-point:ON ACTION delete

               #END add-point
               
            END IF
 
 
         #+ 此段落由子樣板a43產生
         ON ACTION insert
            LET g_action_choice="insert"
            IF cl_auth_chk_act("insert") THEN
               CALL aect801_insert()
               #add-point:ON ACTION insert

               #END add-point
               
            END IF
 
 
         #+ 此段落由子樣板a43產生
         ON ACTION output
            LET g_action_choice="output"
            IF cl_auth_chk_act("output") THEN
               
               #add-point:ON ACTION output

               #END add-point
               &include "erp/aec/aect801_rep.4gl"
               
            END IF
 
 
         #+ 此段落由子樣板a43產生
       # ON ACTION reproduce
       #    LET g_action_choice="reproduce"
       #    IF cl_auth_chk_act("reproduce") THEN
       #       CALL aect801_reproduce()
       #       #add-point:ON ACTION reproduce

       #       #END add-point
       #       
       #    END IF
 
 
         #+ 此段落由子樣板a43產生
         ON ACTION query
            LET g_action_choice="query"
            IF cl_auth_chk_act("query") THEN
               CALL aect801_query()
               #add-point:ON ACTION query

               #END add-point
               #此段落由子樣板a59產生  
               CALL g_curr_diag.setCurrentRow("s_detail1",1)
               CALL g_curr_diag.setCurrentRow("s_detail2",1)
 
			   
 
 
            END IF
 
 
         #+ 此段落由子樣板a43產生
         ON ACTION resource
            LET g_action_choice="resource"
            IF cl_auth_chk_act("resource") THEN
               
               #add-point:ON ACTION resource
               IF g_detail_idx > 0 THEN
                   IF NOT cl_null(g_ecca_m.eccadocno) AND NOT cl_null(g_eccb_d[g_detail_idx].eccb003) AND NOT cl_null(g_eccb_d[g_detail_idx].eccb004)  AND NOT cl_null(g_eccb_d[g_detail_idx].eccb005) THEN
                      CALL aect801_03(g_ecca_m.eccadocno,g_eccb_d[g_detail_idx].eccb003,g_eccb_d[g_detail_idx].eccb004,g_eccb_d[g_detail_idx].eccb005,'N')
                   END IF
                END IF
               #END add-point
               
            END IF
 
 
         #+ 此段落由子樣板a43產生
         ON ACTION stand
            LET g_action_choice="stand"
            IF cl_auth_chk_act("stand") THEN
               
               #add-point:ON ACTION stand
               IF g_detail_idx > 0 THEN
                   IF NOT cl_null(g_ecca_m.eccadocno) AND NOT cl_null(g_eccb_d[g_detail_idx].eccb003) AND NOT cl_null(g_eccb_d[g_detail_idx].eccb004)  AND NOT cl_null(g_eccb_d[g_detail_idx].eccb005) THEN
                      CALL aect801_01(g_ecca_m.eccadocno,g_eccb_d[g_detail_idx].eccb003,g_eccb_d[g_detail_idx].eccb004,g_eccb_d[g_detail_idx].eccb005,'N')
                   END IF
                END IF
               #END add-point
               
            END IF
 
 
         #+ 此段落由子樣板a43產生
         ON ACTION bom
            LET g_action_choice="bom"
            IF cl_auth_chk_act("bom") THEN
               
               #add-point:ON ACTION bom
               CALL aect801_04(g_ecca_m.eccadocno)
               LET g_action_choice=""
               #END add-point
               
            END IF
 
 
         #+ 此段落由子樣板a43產生
         ON ACTION checkin
            LET g_action_choice="checkin"
            IF cl_auth_chk_act("checkin") THEN
               
               #add-point:ON ACTION checkin
               IF g_detail_idx > 0 THEN
                   IF NOT cl_null(g_ecca_m.eccadocno) AND NOT cl_null(g_eccb_d[g_detail_idx].eccb003) AND NOT cl_null(g_eccb_d[g_detail_idx].eccb004)  AND NOT cl_null(g_eccb_d[g_detail_idx].eccb005) THEN
                      CALL aect801_02(g_ecca_m.eccadocno,g_eccb_d[g_detail_idx].eccb003,g_eccb_d[g_detail_idx].eccb004,g_eccb_d[g_detail_idx].eccb005,'1','N')
                   END IF
                END IF
               #END add-point
               
            END IF
 
 
         
         #+ 此段落由子樣板a46產生
         #新增相關文件
         ON ACTION related_document
            CALL aect801_set_pk_array()
            IF cl_auth_chk_act("related_document") THEN
               #add-point:ON ACTION related_document

               #END add-point
               CALL cl_doc()
            END IF
            
         ON ACTION agendum
            CALL aect801_set_pk_array()
            #add-point:ON ACTION agendum

            #END add-point
            CALL cl_user_overview()
            CALL cl_user_overview_set_follow_pic()
         
         ON ACTION followup
            CALL aect801_set_pk_array()
            #add-point:ON ACTION followup

            #END add-point
            CALL cl_user_overview_follow(g_ecca_m.eccadocdt)
 
 
         
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
 
{<section id="aect801.browser_fill" >}
#+ 瀏覽頁簽資料填充
PRIVATE FUNCTION aect801_browser_fill(ps_page_action)
   DEFINE ps_page_action    STRING
   DEFINE l_wc              STRING
   DEFINE l_wc2             STRING
   DEFINE l_sql             STRING
   DEFINE l_sub_sql         STRING
   DEFINE l_sql_rank        STRING
   #add-point:browser_fill段define
   DEFINE l_success         LIKE type_t.num5
   DEFINE l_slip            STRING
   #end add-point   
   
   #add-point:browser_fill段動作開始前

   #end add-point
   
   IF cl_null(g_wc) THEN
      LET g_wc = " 1=1"
   END IF
   IF cl_null(g_wc2) THEN
      LET g_wc2 = " 1=1"
   END IF
   LET l_wc  = g_wc.trim() 
   LET l_wc2 = g_wc2.trim()
 
   #add-point:browser_fill,foreach前
   IF cl_null(g_wc) THEN
      LET g_wc = " eccasite = '",g_site,"'"
   ELSE
      LET g_wc = g_wc," AND eccasite = '",g_site,"'"
   END IF
   LET l_wc  = g_wc.trim()
   LET l_wc2 = g_wc2.trim()
   #end add-point
   
   IF g_wc2 <> " 1=1" THEN
      #單身有輸入搜尋條件                      
      LET l_sub_sql = " SELECT UNIQUE eccasite,eccadocno ",
                      " FROM ecca_t ",
                      " ",
                      " LEFT JOIN eccb_t ON eccbent = eccaent AND eccasite = eccbsite AND eccadocno = eccbdocno ",
 
                      " LEFT JOIN eccc_t ON ecccent = eccaent AND eccbsite = ecccsite AND eccbdocno = ecccdocno AND eccb003 = eccc003", 
 
 
                      " ", 
                      " ", 
                      " WHERE eccaent = '" ||g_enterprise|| "' AND eccbent = '" ||g_enterprise|| "' AND ",l_wc, " AND ", l_wc2, cl_sql_add_filter("ecca_t")
   ELSE
      #單身未輸入搜尋條件
      LET l_sub_sql = " SELECT UNIQUE eccasite,eccadocno ",
                      " FROM ecca_t ", 
                      "  ",
                      "  ",
                      " WHERE eccaent = '" ||g_enterprise|| "' AND ",l_wc CLIPPED, cl_sql_add_filter("ecca_t")
   END IF
   
   #add-point:browser_fill,cnt wc

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
   IF cl_null(g_add_browse) THEN
      #清除畫面
      CLEAR FORM                
      INITIALIZE g_ecca_m.* TO NULL
      CALL g_eccb_d.clear()        
      CALL g_eccb2_d.clear() 
 
      #add-point:browser_fill g_add_browse段額外處理

      #end add-point   
      CALL g_browser.clear()
      LET g_cnt = 1
   ELSE
      LET l_wc  = g_add_browse
      LET l_wc2 = " 1=1" 
      LET g_cnt = g_current_idx
   END IF
 
   #依照t0.eccadocno,t0.eccasite,t0.eccadocdt,t0.ecca004,t0.ecca001,t0.ecca002,t0.ecca003,t0.ecca900,t0.ecca905 Browser欄位定義(取代原本bs_sql功能)
   LET g_sql = " SELECT DISTINCT t0.eccastus,t0.eccadocno,t0.eccasite,t0.eccadocdt,t0.ecca004,t0.ecca001, 
       t0.ecca002,t0.ecca003,t0.ecca900,t0.ecca905,t1.imaal003 ,t2.oocql004 ",
               " FROM ecca_t t0",
               "  ",
               "  LEFT JOIN eccb_t ON eccbent = eccaent AND eccasite = eccbsite AND eccadocno = eccbdocno ",
 
               "  LEFT JOIN eccc_t ON ecccent = eccaent AND eccbsite = ecccsite AND eccbdocno = ecccdocno AND eccb003 = eccc003",
 
 
               "  ",
                              " LEFT JOIN imaal_t t1 ON t1.imaalent='"||g_enterprise||"' AND t1.imaal001=t0.ecca001 AND t1.imaal002='"||g_lang||"' ",
               " LEFT JOIN oocql_t t2 ON t2.oocqlent='"||g_enterprise||"' AND t2.oocql001='225' AND t2.oocql002=t0.ecca905 AND t2.oocql003='"||g_lang||"' ",
 
               " WHERE t0.eccaent = '" ||g_enterprise|| "' AND ",l_wc," AND ",l_wc2, cl_sql_add_filter("ecca_t")
   #add-point:browser_fill,sql wc

   #end add-point
   LET g_sql = g_sql, " ORDER BY eccasite,eccadocno ",g_order
 
   #add-point:browser_fill,before_prepare

   #end add-point
        
   #LET g_sql = cl_sql_add_tabid(g_sql,"ecca_t") #WC重組
   LET g_sql = cl_sql_add_mask(g_sql) #遮蔽特定資料
   PREPARE browse_pre FROM g_sql
   DECLARE browse_cur CURSOR FOR browse_pre
   
   #add-point:browser_fill段open cursor

   #end add-point
   
   FOREACH browse_cur INTO g_browser[g_cnt].b_statepic,g_browser[g_cnt].b_eccadocno,g_browser[g_cnt].b_eccasite, 
       g_browser[g_cnt].b_eccadocdt,g_browser[g_cnt].b_ecca004,g_browser[g_cnt].b_ecca001,g_browser[g_cnt].b_ecca002, 
       g_browser[g_cnt].b_ecca003,g_browser[g_cnt].b_ecca900,g_browser[g_cnt].b_ecca905,g_browser[g_cnt].b_ecca001_desc, 
       g_browser[g_cnt].b_ecca905_desc
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = 'foreach:' 
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = TRUE 
         CALL cl_err()
         EXIT FOREACH
      END IF
  
      #add-point:browser_fill段reference
      CALL s_aooi200_get_slip(g_browser[g_cnt].b_eccadocno) RETURNING l_success,l_slip
      CALL s_aooi200_get_slip_desc(l_slip)
        RETURNING g_browser[g_cnt].b_oobxl003_1
      DISPLAY BY NAME g_browser[g_cnt].b_oobxl003_1
      
      INITIALIZE g_ref_fields TO NULL
      LET g_ref_fields[1] = g_browser[g_cnt].b_ecca001
      CALL ap_ref_array2(g_ref_fields,"SELECT imaal003,imaal004 FROM imaal_t WHERE imaalent='"||g_enterprise||"' AND imaal001=? AND imaal002='"||g_dlang||"'","") RETURNING g_rtn_fields
      LET g_browser[g_cnt].b_ecca001_desc = '', g_rtn_fields[1] , ''
      LET g_browser[g_cnt].b_ecca001_desc_2 = '', g_rtn_fields[1] , ''
      DISPLAY BY NAME g_browser[g_cnt].b_ecca001_desc,g_browser[g_cnt].b_ecca001_desc_2
      
      INITIALIZE g_ref_fields TO NULL
      LET g_ref_fields[1] = g_browser[g_cnt].b_ecca905
      CALL ap_ref_array2(g_ref_fields,"SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001='"||g_acc||"' AND oocql002=? AND oocql003='"||g_dlang||"'","") RETURNING g_rtn_fields
      LET g_browser[g_cnt].b_ecca905_desc = '', g_rtn_fields[1] , ''
      DISPLAY BY NAME g_browser[g_cnt].b_ecca905_desc
      #end add-point
  
            #此段落由子樣板a24產生
      #browser段落顯示圖片
      CASE g_browser[g_cnt].b_statepic
         WHEN "A"
            LET g_browser[g_cnt].b_statepic = "stus/16/approved.png"
         WHEN "D"
            LET g_browser[g_cnt].b_statepic = "stus/16/withdraw.png"
         WHEN "N"
            LET g_browser[g_cnt].b_statepic = "stus/16/unconfirmed.png"
         WHEN "R"
            LET g_browser[g_cnt].b_statepic = "stus/16/rejection.png"
         WHEN "W"
            LET g_browser[g_cnt].b_statepic = "stus/16/signing.png"
         WHEN "X"
            LET g_browser[g_cnt].b_statepic = "stus/16/invalid.png"
         WHEN "Y"
            LET g_browser[g_cnt].b_statepic = "stus/16/confirmed.png"             
         
      END CASE
 
 
      LET g_cnt = g_cnt + 1
      IF g_cnt > g_max_rec THEN
         EXIT FOREACH
      END IF
      
   END FOREACH
   
   #清空g_add_browse, 並指定指標位置
   IF NOT cl_null(g_add_browse) THEN
      LET g_add_browse = ""
      CALL g_curr_diag.setCurrentRow("s_browse",g_current_idx)
   END IF
   
   IF cl_null(g_browser[g_cnt].b_eccasite) THEN
      CALL g_browser.deleteElement(g_cnt)
   END IF
   
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
      CALL cl_set_act_visible("statechange,modify,modify_detail,delete,reproduce", FALSE)
   END IF
   
   #add-point:browser_fill段結束前

   #end add-point   
   
END FUNCTION
 
{</section>}
 
{<section id="aect801.ui_headershow" >}
#+ 單頭資料重新顯示
PRIVATE FUNCTION aect801_ui_headershow()
   #add-point:ui_headershow段define
   
   #end add-point    
   
   LET g_ecca_m.eccasite = g_browser[g_current_idx].b_eccasite   
   LET g_ecca_m.eccadocno = g_browser[g_current_idx].b_eccadocno   
 
   EXECUTE aect801_master_referesh USING g_ecca_m.eccasite,g_ecca_m.eccadocno INTO g_ecca_m.eccadocno, 
       g_ecca_m.ecca001,g_ecca_m.eccadocdt,g_ecca_m.ecca004,g_ecca_m.ecca002,g_ecca_m.eccasite,g_ecca_m.ecca003, 
       g_ecca_m.ecca900,g_ecca_m.ecca905,g_ecca_m.ecca906,g_ecca_m.eccastus,g_ecca_m.eccaownid,g_ecca_m.eccaowndp, 
       g_ecca_m.eccacrtid,g_ecca_m.eccacrtdp,g_ecca_m.eccacrtdt,g_ecca_m.eccamodid,g_ecca_m.eccamoddt, 
       g_ecca_m.eccacnfid,g_ecca_m.eccacnfdt,g_ecca_m.ecca001_desc,g_ecca_m.ecca905_desc,g_ecca_m.eccaownid_desc, 
       g_ecca_m.eccaowndp_desc,g_ecca_m.eccacrtid_desc,g_ecca_m.eccacrtdp_desc,g_ecca_m.eccamodid_desc, 
       g_ecca_m.eccacnfid_desc
   CALL aect801_show()
      
END FUNCTION
 
{</section>}
 
{<section id="aect801.ui_detailshow" >}
#+ 單身資料重新顯示
PRIVATE FUNCTION aect801_ui_detailshow()
   #add-point:ui_detailshow段define
   
   #end add-point    
   
   #add-point:ui_detailshow段before
   
   #end add-point    
   
   IF g_curr_diag IS NOT NULL THEN
      CALL g_curr_diag.setCurrentRow("s_detail1",g_detail_idx)      
      CALL g_curr_diag.setCurrentRow("s_detail2",g_detail_idx)
 
   END IF
   
   #add-point:ui_detailshow段after
   
   #end add-point    
   
END FUNCTION
 
{</section>}
 
{<section id="aect801.ui_browser_refresh" >}
#+ 瀏覽頁簽資料重新顯示
PRIVATE FUNCTION aect801_ui_browser_refresh()
   DEFINE l_i  LIKE type_t.num10
   #add-point:ui_browser_refresh段define
   
   #end add-point    
   
   FOR l_i =1 TO g_browser.getLength()
      IF g_browser[l_i].b_eccasite = g_ecca_m.eccasite 
         AND g_browser[l_i].b_eccadocno = g_ecca_m.eccadocno 
 
         THEN
         CALL g_browser.deleteElement(l_i)
         LET g_header_cnt = g_header_cnt - 1
         EXIT FOR
      END IF
   END FOR
   LET g_browser_cnt = g_browser.getLength()
 
   #add-point:ui_browser_refresh段after
   
   #end add-point    
   
END FUNCTION
 
{</section>}
 
{<section id="aect801.construct" >}
#+ QBE資料查詢
PRIVATE FUNCTION aect801_construct()
   DEFINE ls_return   STRING
   DEFINE ls_result   STRING 
   DEFINE ls_wc       STRING 
   #add-point:cs段define
   
   #end add-point    
 
   #清除畫面
   CLEAR FORM                
   INITIALIZE g_ecca_m.* TO NULL
   CALL g_eccb_d.clear()        
   CALL g_eccb2_d.clear() 
 
   
   LET g_action_choice = ""
    
   INITIALIZE g_wc TO NULL
   INITIALIZE g_wc2 TO NULL
   
   INITIALIZE g_wc2_table1 TO NULL
 
    
   LET g_qryparam.state = 'c'
   
   #add-point:cs段開始前
   
   #end add-point 
   
   #使用DIALOG包住 單頭CONSTRUCT及單身CONSTRUCT
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
      
      #單頭
      CONSTRUCT BY NAME g_wc ON eccadocno,ecca001,oobxl003,eccadocdt,ecca004,ecca002,eccasite,ecca003, 
          ecca900,ecca905,ecca906,eccastus,eccaownid,eccaowndp,eccacrtid,eccacrtdp,eccacrtdt,eccamodid, 
          eccamoddt,eccacnfid,eccacnfdt
 
         BEFORE CONSTRUCT
            #add-point:cs段before_construct
            
            #end add-point 
            
         #公用欄位開窗相關處理
         #此段落由子樣板a11產生
         #共用欄位查詢處理
         ##----<<eccacrtdt>>----
         AFTER FIELD eccacrtdt
            CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
            IF NOT cl_null(ls_result) THEN
               IF NOT cl_chk_date_symbol(ls_result) THEN
                  LET ls_result = cl_add_date_extra_cond(ls_result)
               END IF
            END IF
            CALL FGL_DIALOG_SETBUFFER(ls_result)
         
         #----<<eccamoddt>>----
         AFTER FIELD eccamoddt
            CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
            IF NOT cl_null(ls_result) THEN
               IF NOT cl_chk_date_symbol(ls_result) THEN
                  LET ls_result = cl_add_date_extra_cond(ls_result)
               END IF
            END IF
            CALL FGL_DIALOG_SETBUFFER(ls_result)
         
         #----<<eccacnfdt>>----
         AFTER FIELD eccacnfdt
            CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
            IF NOT cl_null(ls_result) THEN
               IF NOT cl_chk_date_symbol(ls_result) THEN
                  LET ls_result = cl_add_date_extra_cond(ls_result)
               END IF
            END IF
            CALL FGL_DIALOG_SETBUFFER(ls_result)
         
         #----<<eccapstdt>>----
 
 
            
         #一般欄位開窗相關處理    
                  #此段落由子樣板a01產生
         BEFORE FIELD eccadocno
            #add-point:BEFORE FIELD eccadocno
            
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD eccadocno
            
            #add-point:AFTER FIELD eccadocno
            
            #END add-point
            
 
         #Ctrlp:construct.c.eccadocno
         ON ACTION controlp INFIELD eccadocno
            #add-point:ON ACTION controlp INFIELD eccadocno
            
            #END add-point
 
         #Ctrlp:construct.c.ecca001
         ON ACTION controlp INFIELD ecca001
            #add-point:ON ACTION controlp INFIELD ecca001
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_imaf001_6()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO ecca001  #顯示到畫面上
            NEXT FIELD ecca001                     #返回原欄位
    


            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD ecca001
            #add-point:BEFORE FIELD ecca001
            
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD ecca001
            
            #add-point:AFTER FIELD ecca001
            
            #END add-point
            
 
         #此段落由子樣板a01產生
         BEFORE FIELD oobxl003
            #add-point:BEFORE FIELD oobxl003
            
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD oobxl003
            
            #add-point:AFTER FIELD oobxl003
            
            #END add-point
            
 
         #Ctrlp:construct.c.oobxl003
         ON ACTION controlp INFIELD oobxl003
            #add-point:ON ACTION controlp INFIELD oobxl003
            
            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD eccadocdt
            #add-point:BEFORE FIELD eccadocdt
            
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD eccadocdt
            
            #add-point:AFTER FIELD eccadocdt
            
            #END add-point
            
 
         #Ctrlp:construct.c.eccadocdt
         ON ACTION controlp INFIELD eccadocdt
            #add-point:ON ACTION controlp INFIELD eccadocdt
            
            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD ecca004
            #add-point:BEFORE FIELD ecca004
            
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD ecca004
            
            #add-point:AFTER FIELD ecca004
            
            #END add-point
            
 
         #Ctrlp:construct.c.ecca004
         ON ACTION controlp INFIELD ecca004
            #add-point:ON ACTION controlp INFIELD ecca004
            
            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD ecca002
            #add-point:BEFORE FIELD ecca002
            
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD ecca002
            
            #add-point:AFTER FIELD ecca002
            
            #END add-point
            
 
         #Ctrlp:construct.c.ecca002
         ON ACTION controlp INFIELD ecca002
            #add-point:ON ACTION controlp INFIELD ecca002
            
            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD eccasite
            #add-point:BEFORE FIELD eccasite
            
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD eccasite
            
            #add-point:AFTER FIELD eccasite
            
            #END add-point
            
 
         #Ctrlp:construct.c.eccasite
         ON ACTION controlp INFIELD eccasite
            #add-point:ON ACTION controlp INFIELD eccasite
            
            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD ecca003
            #add-point:BEFORE FIELD ecca003
            
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD ecca003
            
            #add-point:AFTER FIELD ecca003
            
            #END add-point
            
 
         #Ctrlp:construct.c.ecca003
         ON ACTION controlp INFIELD ecca003
            #add-point:ON ACTION controlp INFIELD ecca003
            
            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD ecca900
            #add-point:BEFORE FIELD ecca900
            
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD ecca900
            
            #add-point:AFTER FIELD ecca900
            
            #END add-point
            
 
         #Ctrlp:construct.c.ecca900
         ON ACTION controlp INFIELD ecca900
            #add-point:ON ACTION controlp INFIELD ecca900
            
            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD ecca905
            #add-point:BEFORE FIELD ecca905
            
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD ecca905
            
            #add-point:AFTER FIELD ecca905
            
            #END add-point
            
 
         #Ctrlp:construct.c.ecca905
         ON ACTION controlp INFIELD ecca905
            #add-point:ON ACTION controlp INFIELD ecca905
            
            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD ecca906
            #add-point:BEFORE FIELD ecca906
            
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD ecca906
            
            #add-point:AFTER FIELD ecca906
            
            #END add-point
            
 
         #Ctrlp:construct.c.ecca906
         ON ACTION controlp INFIELD ecca906
            #add-point:ON ACTION controlp INFIELD ecca906
            
            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD eccastus
            #add-point:BEFORE FIELD eccastus
            
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD eccastus
            
            #add-point:AFTER FIELD eccastus
            
            #END add-point
            
 
         #Ctrlp:construct.c.eccastus
         ON ACTION controlp INFIELD eccastus
            #add-point:ON ACTION controlp INFIELD eccastus
            
            #END add-point
 
         #Ctrlp:construct.c.eccaownid
         ON ACTION controlp INFIELD eccaownid
            #add-point:ON ACTION controlp INFIELD eccaownid
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO eccaownid  #顯示到畫面上
            NEXT FIELD eccaownid                     #返回原欄位
    


            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD eccaownid
            #add-point:BEFORE FIELD eccaownid
            
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD eccaownid
            
            #add-point:AFTER FIELD eccaownid
            
            #END add-point
            
 
         #Ctrlp:construct.c.eccaowndp
         ON ACTION controlp INFIELD eccaowndp
            #add-point:ON ACTION controlp INFIELD eccaowndp
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooeg001_9()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO eccaowndp  #顯示到畫面上
            NEXT FIELD eccaowndp                     #返回原欄位
    


            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD eccaowndp
            #add-point:BEFORE FIELD eccaowndp
            
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD eccaowndp
            
            #add-point:AFTER FIELD eccaowndp
            
            #END add-point
            
 
         #Ctrlp:construct.c.eccacrtid
         ON ACTION controlp INFIELD eccacrtid
            #add-point:ON ACTION controlp INFIELD eccacrtid
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO eccacrtid  #顯示到畫面上
            NEXT FIELD eccacrtid                     #返回原欄位
    


            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD eccacrtid
            #add-point:BEFORE FIELD eccacrtid
            
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD eccacrtid
            
            #add-point:AFTER FIELD eccacrtid
            
            #END add-point
            
 
         #Ctrlp:construct.c.eccacrtdp
         ON ACTION controlp INFIELD eccacrtdp
            #add-point:ON ACTION controlp INFIELD eccacrtdp
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooeg001_9()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO eccacrtdp  #顯示到畫面上
            NEXT FIELD eccacrtdp                     #返回原欄位
    


            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD eccacrtdp
            #add-point:BEFORE FIELD eccacrtdp
            
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD eccacrtdp
            
            #add-point:AFTER FIELD eccacrtdp
            
            #END add-point
            
 
         #此段落由子樣板a01產生
         BEFORE FIELD eccacrtdt
            #add-point:BEFORE FIELD eccacrtdt
            
            #END add-point
 
         #Ctrlp:construct.c.eccamodid
         ON ACTION controlp INFIELD eccamodid
            #add-point:ON ACTION controlp INFIELD eccamodid
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO eccamodid  #顯示到畫面上
            NEXT FIELD eccamodid                     #返回原欄位
    


            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD eccamodid
            #add-point:BEFORE FIELD eccamodid
            
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD eccamodid
            
            #add-point:AFTER FIELD eccamodid
            
            #END add-point
            
 
         #此段落由子樣板a01產生
         BEFORE FIELD eccamoddt
            #add-point:BEFORE FIELD eccamoddt
            
            #END add-point
 
         #Ctrlp:construct.c.eccacnfid
         ON ACTION controlp INFIELD eccacnfid
            #add-point:ON ACTION controlp INFIELD eccacnfid
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO eccacnfid  #顯示到畫面上
            NEXT FIELD eccacnfid                     #返回原欄位
    


            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD eccacnfid
            #add-point:BEFORE FIELD eccacnfid
            
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD eccacnfid
            
            #add-point:AFTER FIELD eccacnfid
            
            #END add-point
            
 
         #此段落由子樣板a01產生
         BEFORE FIELD eccacnfdt
            #add-point:BEFORE FIELD eccacnfdt
            
            #END add-point
 
 
         
      END CONSTRUCT
 
      #單身根據table分拆construct
      CONSTRUCT g_wc2_table1 ON eccb003,eccb004,eccb005,eccb006,eccb007,eccb008,eccb009,eccb010,eccb011, 
          eccb012,eccb024,eccb025,eccb026,eccb027,eccb034,eccb013,eccb014,eccb015,eccb016,eccb017,eccb018, 
          eccb019,eccb020,eccb030,eccb031,eccb032,eccb021,eccb022,eccb023,eccb033,eccb028,eccb029,ooff013, 
          eccb035,eccb036,eccb901,eccb905,eccb906,eccb001,eccb002,eccb900,eccb902
           FROM s_detail1[1].eccb003,s_detail1[1].eccb004,s_detail1[1].eccb005,s_detail1[1].eccb006, 
               s_detail1[1].eccb007,s_detail1[1].eccb008,s_detail1[1].eccb009,s_detail1[1].eccb010,s_detail1[1].eccb011, 
               s_detail1[1].eccb012,s_detail1[1].eccb024,s_detail1[1].eccb025,s_detail1[1].eccb026,s_detail1[1].eccb027, 
               s_detail1[1].eccb034,s_detail1[1].eccb013,s_detail1[1].eccb014,s_detail1[1].eccb015,s_detail1[1].eccb016, 
               s_detail1[1].eccb017,s_detail1[1].eccb018,s_detail1[1].eccb019,s_detail1[1].eccb020,s_detail1[1].eccb030, 
               s_detail1[1].eccb031,s_detail1[1].eccb032,s_detail1[1].eccb021,s_detail1[1].eccb022,s_detail1[1].eccb023, 
               s_detail1[1].eccb033,s_detail1[1].eccb028,s_detail1[1].eccb029,s_detail1[1].ooff013,s_detail1[1].eccb035, 
               s_detail1[1].eccb036,s_detail1[1].eccb901,s_detail1[1].eccb905,s_detail1[1].eccb906,s_detail1[1].eccb001, 
               s_detail1[1].eccb002,s_detail1[1].eccb900,s_detail1[1].eccb902
                      
         BEFORE CONSTRUCT
            #add-point:cs段before_construct
            
            #end add-point 
            
       #單身公用欄位開窗相關處理
       
         
       #單身一般欄位開窗相關處理
                #此段落由子樣板a01產生
         BEFORE FIELD eccb003
            #add-point:BEFORE FIELD eccb003
            
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD eccb003
            
            #add-point:AFTER FIELD eccb003
            
            #END add-point
            
 
         #Ctrlp:construct.c.page1.eccb003
         ON ACTION controlp INFIELD eccb003
            #add-point:ON ACTION controlp INFIELD eccb003
            
            #END add-point
 
         #Ctrlp:construct.c.page1.eccb004
         ON ACTION controlp INFIELD eccb004
            #add-point:ON ACTION controlp INFIELD eccb004
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_oocq002()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO eccb004  #顯示到畫面上
            NEXT FIELD eccb004                     #返回原欄位
    


            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD eccb004
            #add-point:BEFORE FIELD eccb004
            
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD eccb004
            
            #add-point:AFTER FIELD eccb004
            
            #END add-point
            
 
         #此段落由子樣板a01產生
         BEFORE FIELD eccb005
            #add-point:BEFORE FIELD eccb005
            
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD eccb005
            
            #add-point:AFTER FIELD eccb005
            
            #END add-point
            
 
         #Ctrlp:construct.c.page1.eccb005
         ON ACTION controlp INFIELD eccb005
            #add-point:ON ACTION controlp INFIELD eccb005
            
            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD eccb006
            #add-point:BEFORE FIELD eccb006
            
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD eccb006
            
            #add-point:AFTER FIELD eccb006
            
            #END add-point
            
 
         #Ctrlp:construct.c.page1.eccb006
         ON ACTION controlp INFIELD eccb006
            #add-point:ON ACTION controlp INFIELD eccb006
            
            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD eccb007
            #add-point:BEFORE FIELD eccb007
            
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD eccb007
            
            #add-point:AFTER FIELD eccb007
            
            #END add-point
            
 
         #Ctrlp:construct.c.page1.eccb007
         ON ACTION controlp INFIELD eccb007
            #add-point:ON ACTION controlp INFIELD eccb007
            
            #END add-point
 
         #Ctrlp:construct.c.page1.eccb008
         ON ACTION controlp INFIELD eccb008
            #add-point:ON ACTION controlp INFIELD eccb008
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_oocq002()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO eccb008  #顯示到畫面上
            NEXT FIELD eccb008                     #返回原欄位
    


            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD eccb008
            #add-point:BEFORE FIELD eccb008
            
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD eccb008
            
            #add-point:AFTER FIELD eccb008
            
            #END add-point
            
 
         #此段落由子樣板a01產生
         BEFORE FIELD eccb009
            #add-point:BEFORE FIELD eccb009
            
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD eccb009
            
            #add-point:AFTER FIELD eccb009
            
            #END add-point
            
 
         #Ctrlp:construct.c.page1.eccb009
         ON ACTION controlp INFIELD eccb009
            #add-point:ON ACTION controlp INFIELD eccb009
            
            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD eccb010
            #add-point:BEFORE FIELD eccb010
            
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD eccb010
            
            #add-point:AFTER FIELD eccb010
            
            #END add-point
            
 
         #Ctrlp:construct.c.page1.eccb010
         ON ACTION controlp INFIELD eccb010
            #add-point:ON ACTION controlp INFIELD eccb010
            
            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD eccb011
            #add-point:BEFORE FIELD eccb011
            
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD eccb011
            
            #add-point:AFTER FIELD eccb011
            
            #END add-point
            
 
         #Ctrlp:construct.c.page1.eccb011
         ON ACTION controlp INFIELD eccb011
            #add-point:ON ACTION controlp INFIELD eccb011
            
            #END add-point
 
         #Ctrlp:construct.c.page1.eccb012
         ON ACTION controlp INFIELD eccb012
            #add-point:ON ACTION controlp INFIELD eccb012
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ecaa001_1()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO eccb012  #顯示到畫面上
            NEXT FIELD eccb012                     #返回原欄位
    


            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD eccb012
            #add-point:BEFORE FIELD eccb012
            
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD eccb012
            
            #add-point:AFTER FIELD eccb012
            
            #END add-point
            
 
         #此段落由子樣板a01產生
         BEFORE FIELD eccb024
            #add-point:BEFORE FIELD eccb024
            
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD eccb024
            
            #add-point:AFTER FIELD eccb024
            
            #END add-point
            
 
         #Ctrlp:construct.c.page1.eccb024
         ON ACTION controlp INFIELD eccb024
            #add-point:ON ACTION controlp INFIELD eccb024
            
            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD eccb025
            #add-point:BEFORE FIELD eccb025
            
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD eccb025
            
            #add-point:AFTER FIELD eccb025
            
            #END add-point
            
 
         #Ctrlp:construct.c.page1.eccb025
         ON ACTION controlp INFIELD eccb025
            #add-point:ON ACTION controlp INFIELD eccb025
            
            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD eccb026
            #add-point:BEFORE FIELD eccb026
            
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD eccb026
            
            #add-point:AFTER FIELD eccb026
            
            #END add-point
            
 
         #Ctrlp:construct.c.page1.eccb026
         ON ACTION controlp INFIELD eccb026
            #add-point:ON ACTION controlp INFIELD eccb026
            
            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD eccb027
            #add-point:BEFORE FIELD eccb027
            
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD eccb027
            
            #add-point:AFTER FIELD eccb027
            
            #END add-point
            
 
         #Ctrlp:construct.c.page1.eccb027
         ON ACTION controlp INFIELD eccb027
            #add-point:ON ACTION controlp INFIELD eccb027
            
            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD eccb034
            #add-point:BEFORE FIELD eccb034
            
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD eccb034
            
            #add-point:AFTER FIELD eccb034
            
            #END add-point
            
 
         #Ctrlp:construct.c.page1.eccb034
         ON ACTION controlp INFIELD eccb034
            #add-point:ON ACTION controlp INFIELD eccb034
            
            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD eccb013
            #add-point:BEFORE FIELD eccb013
            
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD eccb013
            
            #add-point:AFTER FIELD eccb013
            
            #END add-point
            
 
         #Ctrlp:construct.c.page1.eccb013
         ON ACTION controlp INFIELD eccb013
            #add-point:ON ACTION controlp INFIELD eccb013
            
            #END add-point
 
         #Ctrlp:construct.c.page1.eccb014
         ON ACTION controlp INFIELD eccb014
            #add-point:ON ACTION controlp INFIELD eccb014
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_pmaa001_1()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO eccb014  #顯示到畫面上
            NEXT FIELD eccb014                     #返回原欄位
    


            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD eccb014
            #add-point:BEFORE FIELD eccb014
            
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD eccb014
            
            #add-point:AFTER FIELD eccb014
            
            #END add-point
            
 
         #此段落由子樣板a01產生
         BEFORE FIELD eccb015
            #add-point:BEFORE FIELD eccb015
            
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD eccb015
            
            #add-point:AFTER FIELD eccb015
            
            #END add-point
            
 
         #Ctrlp:construct.c.page1.eccb015
         ON ACTION controlp INFIELD eccb015
            #add-point:ON ACTION controlp INFIELD eccb015
            
            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD eccb016
            #add-point:BEFORE FIELD eccb016
            
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD eccb016
            
            #add-point:AFTER FIELD eccb016
            
            #END add-point
            
 
         #Ctrlp:construct.c.page1.eccb016
         ON ACTION controlp INFIELD eccb016
            #add-point:ON ACTION controlp INFIELD eccb016
            
            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD eccb017
            #add-point:BEFORE FIELD eccb017
            
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD eccb017
            
            #add-point:AFTER FIELD eccb017
            
            #END add-point
            
 
         #Ctrlp:construct.c.page1.eccb017
         ON ACTION controlp INFIELD eccb017
            #add-point:ON ACTION controlp INFIELD eccb017
            
            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD eccb018
            #add-point:BEFORE FIELD eccb018
            
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD eccb018
            
            #add-point:AFTER FIELD eccb018
            
            #END add-point
            
 
         #Ctrlp:construct.c.page1.eccb018
         ON ACTION controlp INFIELD eccb018
            #add-point:ON ACTION controlp INFIELD eccb018
            
            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD eccb019
            #add-point:BEFORE FIELD eccb019
            
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD eccb019
            
            #add-point:AFTER FIELD eccb019
            
            #END add-point
            
 
         #Ctrlp:construct.c.page1.eccb019
         ON ACTION controlp INFIELD eccb019
            #add-point:ON ACTION controlp INFIELD eccb019
            
            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD eccb020
            #add-point:BEFORE FIELD eccb020
            
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD eccb020
            
            #add-point:AFTER FIELD eccb020
            
            #END add-point
            
 
         #Ctrlp:construct.c.page1.eccb020
         ON ACTION controlp INFIELD eccb020
            #add-point:ON ACTION controlp INFIELD eccb020
            
            #END add-point
 
         #Ctrlp:construct.c.page1.eccb030
         ON ACTION controlp INFIELD eccb030
            #add-point:ON ACTION controlp INFIELD eccb030
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooca001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO eccb030  #顯示到畫面上
            NEXT FIELD eccb030                     #返回原欄位
    


            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD eccb030
            #add-point:BEFORE FIELD eccb030
            
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD eccb030
            
            #add-point:AFTER FIELD eccb030
            
            #END add-point
            
 
         #此段落由子樣板a01產生
         BEFORE FIELD eccb031
            #add-point:BEFORE FIELD eccb031
            
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD eccb031
            
            #add-point:AFTER FIELD eccb031
            
            #END add-point
            
 
         #Ctrlp:construct.c.page1.eccb031
         ON ACTION controlp INFIELD eccb031
            #add-point:ON ACTION controlp INFIELD eccb031
            
            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD eccb032
            #add-point:BEFORE FIELD eccb032
            
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD eccb032
            
            #add-point:AFTER FIELD eccb032
            
            #END add-point
            
 
         #Ctrlp:construct.c.page1.eccb032
         ON ACTION controlp INFIELD eccb032
            #add-point:ON ACTION controlp INFIELD eccb032
            
            #END add-point
 
         #Ctrlp:construct.c.page1.eccb021
         ON ACTION controlp INFIELD eccb021
            #add-point:ON ACTION controlp INFIELD eccb021
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooca001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO eccb021  #顯示到畫面上
            NEXT FIELD eccb021                     #返回原欄位
    


            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD eccb021
            #add-point:BEFORE FIELD eccb021
            
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD eccb021
            
            #add-point:AFTER FIELD eccb021
            
            #END add-point
            
 
         #此段落由子樣板a01產生
         BEFORE FIELD eccb022
            #add-point:BEFORE FIELD eccb022
            
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD eccb022
            
            #add-point:AFTER FIELD eccb022
            
            #END add-point
            
 
         #Ctrlp:construct.c.page1.eccb022
         ON ACTION controlp INFIELD eccb022
            #add-point:ON ACTION controlp INFIELD eccb022
            
            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD eccb023
            #add-point:BEFORE FIELD eccb023
            
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD eccb023
            
            #add-point:AFTER FIELD eccb023
            
            #END add-point
            
 
         #Ctrlp:construct.c.page1.eccb023
         ON ACTION controlp INFIELD eccb023
            #add-point:ON ACTION controlp INFIELD eccb023
            
            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD eccb033
            #add-point:BEFORE FIELD eccb033
            
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD eccb033
            
            #add-point:AFTER FIELD eccb033
            
            #END add-point
            
 
         #Ctrlp:construct.c.page1.eccb033
         ON ACTION controlp INFIELD eccb033
            #add-point:ON ACTION controlp INFIELD eccb033
            
            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD eccb028
            #add-point:BEFORE FIELD eccb028
            
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD eccb028
            
            #add-point:AFTER FIELD eccb028
            
            #END add-point
            
 
         #Ctrlp:construct.c.page1.eccb028
         ON ACTION controlp INFIELD eccb028
            #add-point:ON ACTION controlp INFIELD eccb028
            
            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD eccb029
            #add-point:BEFORE FIELD eccb029
            
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD eccb029
            
            #add-point:AFTER FIELD eccb029
            
            #END add-point
            
 
         #Ctrlp:construct.c.page1.eccb029
         ON ACTION controlp INFIELD eccb029
            #add-point:ON ACTION controlp INFIELD eccb029
            
            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD ooff013
            #add-point:BEFORE FIELD ooff013
            
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD ooff013
            
            #add-point:AFTER FIELD ooff013
            
            #END add-point
            
 
         #Ctrlp:construct.c.page1.ooff013
         ON ACTION controlp INFIELD ooff013
            #add-point:ON ACTION controlp INFIELD ooff013
            
            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD eccb035
            #add-point:BEFORE FIELD eccb035
            
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD eccb035
            
            #add-point:AFTER FIELD eccb035
            
            #END add-point
            
 
         #Ctrlp:construct.c.page1.eccb035
         ON ACTION controlp INFIELD eccb035
            #add-point:ON ACTION controlp INFIELD eccb035
            
            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD eccb036
            #add-point:BEFORE FIELD eccb036
            
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD eccb036
            
            #add-point:AFTER FIELD eccb036
            
            #END add-point
            
 
         #Ctrlp:construct.c.page1.eccb036
         ON ACTION controlp INFIELD eccb036
            #add-point:ON ACTION controlp INFIELD eccb036
            
            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD eccb901
            #add-point:BEFORE FIELD eccb901
            
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD eccb901
            
            #add-point:AFTER FIELD eccb901
            
            #END add-point
            
 
         #Ctrlp:construct.c.page1.eccb901
         ON ACTION controlp INFIELD eccb901
            #add-point:ON ACTION controlp INFIELD eccb901
            
            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD eccb905
            #add-point:BEFORE FIELD eccb905
            
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD eccb905
            
            #add-point:AFTER FIELD eccb905
            
            #END add-point
            
 
         #Ctrlp:construct.c.page1.eccb905
         ON ACTION controlp INFIELD eccb905
            #add-point:ON ACTION controlp INFIELD eccb905
            
            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD eccb906
            #add-point:BEFORE FIELD eccb906
            
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD eccb906
            
            #add-point:AFTER FIELD eccb906
            
            #END add-point
            
 
         #Ctrlp:construct.c.page1.eccb906
         ON ACTION controlp INFIELD eccb906
            #add-point:ON ACTION controlp INFIELD eccb906
            
            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD eccb001
            #add-point:BEFORE FIELD eccb001
            
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD eccb001
            
            #add-point:AFTER FIELD eccb001
            
            #END add-point
            
 
         #Ctrlp:construct.c.page1.eccb001
         ON ACTION controlp INFIELD eccb001
            #add-point:ON ACTION controlp INFIELD eccb001
            
            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD eccb002
            #add-point:BEFORE FIELD eccb002
            
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD eccb002
            
            #add-point:AFTER FIELD eccb002
            
            #END add-point
            
 
         #Ctrlp:construct.c.page1.eccb002
         ON ACTION controlp INFIELD eccb002
            #add-point:ON ACTION controlp INFIELD eccb002
            
            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD eccb900
            #add-point:BEFORE FIELD eccb900
            
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD eccb900
            
            #add-point:AFTER FIELD eccb900
            
            #END add-point
            
 
         #Ctrlp:construct.c.page1.eccb900
         ON ACTION controlp INFIELD eccb900
            #add-point:ON ACTION controlp INFIELD eccb900
            
            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD eccb902
            #add-point:BEFORE FIELD eccb902
            
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD eccb902
            
            #add-point:AFTER FIELD eccb902
            
            #END add-point
            
 
         #Ctrlp:construct.c.page1.eccb902
         ON ACTION controlp INFIELD eccb902
            #add-point:ON ACTION controlp INFIELD eccb902
            
            #END add-point
 
   
       
      END CONSTRUCT
      
 
      
      CONSTRUCT g_wc2_table2 ON eccc004,eccc005,eccc006,eccc007,eccc008,eccc009,eccc010,eccc901,eccc905, 
          eccc906,eccc001,eccc002,eccc900,eccc902
           FROM s_detail2[1].eccc004,s_detail2[1].eccc005,s_detail2[1].eccc006,s_detail2[1].eccc007, 
               s_detail2[1].eccc008,s_detail2[1].eccc009,s_detail2[1].eccc010,s_detail2[1].eccc901,s_detail2[1].eccc905, 
               s_detail2[1].eccc906,s_detail2[1].eccc001,s_detail2[1].eccc002,s_detail2[1].eccc900,s_detail2[1].eccc902 
 
                      
         BEFORE CONSTRUCT
            #add-point:cs段before_construct
            
            #end add-point 
            
       #單身公用欄位開窗相關處理(table 2)
       
       
       #單身一般欄位開窗相關處理       
                #此段落由子樣板a01產生
         BEFORE FIELD eccc004
            #add-point:BEFORE FIELD eccc004
            
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD eccc004
            
            #add-point:AFTER FIELD eccc004
            
            #END add-point
            
 
         #Ctrlp:construct.c.page2.eccc004
         ON ACTION controlp INFIELD eccc004
            #add-point:ON ACTION controlp INFIELD eccc004
            
            #END add-point
 
         #Ctrlp:construct.c.page2.eccc005
         ON ACTION controlp INFIELD eccc005
            #add-point:ON ACTION controlp INFIELD eccc005
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_imaf001_6()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO eccc005  #顯示到畫面上
            NEXT FIELD eccc005                     #返回原欄位
    


            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD eccc005
            #add-point:BEFORE FIELD eccc005
            
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD eccc005
            
            #add-point:AFTER FIELD eccc005
            
            #END add-point
            
 
         #Ctrlp:construct.c.page2.eccc006
         ON ACTION controlp INFIELD eccc006
            #add-point:ON ACTION controlp INFIELD eccc006
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_oocq002()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO eccc006  #顯示到畫面上
            NEXT FIELD eccc006                     #返回原欄位
    


            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD eccc006
            #add-point:BEFORE FIELD eccc006
            
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD eccc006
            
            #add-point:AFTER FIELD eccc006
            
            #END add-point
            
 
         #此段落由子樣板a01產生
         BEFORE FIELD eccc007
            #add-point:BEFORE FIELD eccc007
            
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD eccc007
            
            #add-point:AFTER FIELD eccc007
            
            #END add-point
            
 
         #Ctrlp:construct.c.page2.eccc007
         ON ACTION controlp INFIELD eccc007
            #add-point:ON ACTION controlp INFIELD eccc007
            
            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD eccc008
            #add-point:BEFORE FIELD eccc008
            
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD eccc008
            
            #add-point:AFTER FIELD eccc008
            
            #END add-point
            
 
         #Ctrlp:construct.c.page2.eccc008
         ON ACTION controlp INFIELD eccc008
            #add-point:ON ACTION controlp INFIELD eccc008
            
            #END add-point
 
         #Ctrlp:construct.c.page2.eccc009
         ON ACTION controlp INFIELD eccc009
            #add-point:ON ACTION controlp INFIELD eccc009
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooca001_1()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO eccc009  #顯示到畫面上
            NEXT FIELD eccc009                     #返回原欄位
    


            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD eccc009
            #add-point:BEFORE FIELD eccc009
            
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD eccc009
            
            #add-point:AFTER FIELD eccc009
            
            #END add-point
            
 
         #此段落由子樣板a01產生
         BEFORE FIELD eccc010
            #add-point:BEFORE FIELD eccc010
            
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD eccc010
            
            #add-point:AFTER FIELD eccc010
            
            #END add-point
            
 
         #Ctrlp:construct.c.page2.eccc010
         ON ACTION controlp INFIELD eccc010
            #add-point:ON ACTION controlp INFIELD eccc010
            
            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD eccc901
            #add-point:BEFORE FIELD eccc901
            
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD eccc901
            
            #add-point:AFTER FIELD eccc901
            
            #END add-point
            
 
         #Ctrlp:construct.c.page2.eccc901
         ON ACTION controlp INFIELD eccc901
            #add-point:ON ACTION controlp INFIELD eccc901
            
            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD eccc905
            #add-point:BEFORE FIELD eccc905
            
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD eccc905
            
            #add-point:AFTER FIELD eccc905
            
            #END add-point
            
 
         #Ctrlp:construct.c.page2.eccc905
         ON ACTION controlp INFIELD eccc905
            #add-point:ON ACTION controlp INFIELD eccc905
            
            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD eccc906
            #add-point:BEFORE FIELD eccc906
            
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD eccc906
            
            #add-point:AFTER FIELD eccc906
            
            #END add-point
            
 
         #Ctrlp:construct.c.page2.eccc906
         ON ACTION controlp INFIELD eccc906
            #add-point:ON ACTION controlp INFIELD eccc906
            
            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD eccc001
            #add-point:BEFORE FIELD eccc001
            
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD eccc001
            
            #add-point:AFTER FIELD eccc001
            
            #END add-point
            
 
         #Ctrlp:construct.c.page2.eccc001
         ON ACTION controlp INFIELD eccc001
            #add-point:ON ACTION controlp INFIELD eccc001
            
            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD eccc002
            #add-point:BEFORE FIELD eccc002
            
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD eccc002
            
            #add-point:AFTER FIELD eccc002
            
            #END add-point
            
 
         #Ctrlp:construct.c.page2.eccc002
         ON ACTION controlp INFIELD eccc002
            #add-point:ON ACTION controlp INFIELD eccc002
            
            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD eccc900
            #add-point:BEFORE FIELD eccc900
            
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD eccc900
            
            #add-point:AFTER FIELD eccc900
            
            #END add-point
            
 
         #Ctrlp:construct.c.page2.eccc900
         ON ACTION controlp INFIELD eccc900
            #add-point:ON ACTION controlp INFIELD eccc900
            
            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD eccc902
            #add-point:BEFORE FIELD eccc902
            
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD eccc902
            
            #add-point:AFTER FIELD eccc902
            
            #END add-point
            
 
         #Ctrlp:construct.c.page2.eccc902
         ON ACTION controlp INFIELD eccc902
            #add-point:ON ACTION controlp INFIELD eccc902
            
            #END add-point
 
   
       
      END CONSTRUCT
 
 
      
      #add-point:cs段add_cs(本段內只能出現新的CONSTRUCT指令)
      
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
 
 
   
   #add-point:cs段結束前
   
   #end add-point    
 
   IF INT_FLAG THEN
      RETURN
   END IF
 
END FUNCTION
 
{</section>}
 
{<section id="aect801.filter" >}
#+ 此段落由子樣板a50產生
#+ filter過濾功能
PRIVATE FUNCTION aect801_filter()
   #add-point:filter段define
   
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
      CONSTRUCT g_wc_filter ON eccadocno,eccasite,eccadocdt,ecca004,ecca001,ecca002,ecca003,ecca900, 
          ecca905
                          FROM s_browse[1].b_eccadocno,s_browse[1].b_eccasite,s_browse[1].b_eccadocdt, 
                              s_browse[1].b_ecca004,s_browse[1].b_ecca001,s_browse[1].b_ecca002,s_browse[1].b_ecca003, 
                              s_browse[1].b_ecca900,s_browse[1].b_ecca905
 
         BEFORE CONSTRUCT
               DISPLAY aect801_filter_parser('eccadocno') TO s_browse[1].b_eccadocno
            DISPLAY aect801_filter_parser('eccasite') TO s_browse[1].b_eccasite
            DISPLAY aect801_filter_parser('eccadocdt') TO s_browse[1].b_eccadocdt
            DISPLAY aect801_filter_parser('ecca004') TO s_browse[1].b_ecca004
            DISPLAY aect801_filter_parser('ecca001') TO s_browse[1].b_ecca001
            DISPLAY aect801_filter_parser('ecca002') TO s_browse[1].b_ecca002
            DISPLAY aect801_filter_parser('ecca003') TO s_browse[1].b_ecca003
            DISPLAY aect801_filter_parser('ecca900') TO s_browse[1].b_ecca900
            DISPLAY aect801_filter_parser('ecca905') TO s_browse[1].b_ecca905
      
         #add-point:filter段cs_ctrl
         
         #end add-point
      
      END CONSTRUCT
 
      #add-point:filter段add_cs
      
      #end add-point
 
      BEFORE DIALOG
         #add-point:filter段b_dialog
         
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
 
      CALL aect801_filter_show('eccadocno')
   CALL aect801_filter_show('eccasite')
   CALL aect801_filter_show('eccadocdt')
   CALL aect801_filter_show('ecca004')
   CALL aect801_filter_show('ecca001')
   CALL aect801_filter_show('ecca002')
   CALL aect801_filter_show('ecca003')
   CALL aect801_filter_show('ecca900')
   CALL aect801_filter_show('ecca905')
 
END FUNCTION
 
{</section>}
 
{<section id="aect801.filter_parser" >}
#+ filter過濾功能
PRIVATE FUNCTION aect801_filter_parser(ps_field)
   DEFINE ps_field   STRING
   DEFINE ls_tmp     STRING
   DEFINE li_tmp     LIKE type_t.num5
   DEFINE li_tmp2    LIKE type_t.num5
   DEFINE ls_var     STRING
   #add-point:filter段define
   
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
 
{<section id="aect801.filter_show" >}
#+ 顯示過濾條件
PRIVATE FUNCTION aect801_filter_show(ps_field)
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
   LET ls_condition = aect801_filter_parser(ps_field)
   IF NOT cl_null(ls_condition) THEN
      LET ls_title = ls_title, '※', ls_condition, '※'
   END IF
 
   #將資料顯示回去
   CALL lnode_item.setAttribute("text",ls_title)
 
END FUNCTION
 
{</section>}
 
{<section id="aect801.query" >}
#+ 資料查詢QBE功能準備
PRIVATE FUNCTION aect801_query()
   DEFINE ls_wc STRING
   #add-point:query段define
   
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
   CALL g_eccb_d.clear()
   CALL g_eccb2_d.clear()
 
   
   #add-point:query段other
   
   #end add-point   
   
   DISPLAY ' ' TO FORMONLY.idx
   DISPLAY ' ' TO FORMONLY.cnt
   DISPLAY ' ' TO FORMONLY.b_index
   DISPLAY ' ' TO FORMONLY.b_count
   DISPLAY ' ' TO FORMONLY.h_index
   DISPLAY ' ' TO FORMONLY.h_count
   
   CALL aect801_construct()
 
   IF INT_FLAG THEN
      #取消查詢
      LET INT_FLAG = 0
      LET g_wc = ls_wc
      CALL aect801_browser_fill("")
      CALL aect801_fetch("")
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
      CALL aect801_filter_show('eccadocno')
   CALL aect801_filter_show('eccasite')
   CALL aect801_filter_show('eccadocdt')
   CALL aect801_filter_show('ecca004')
   CALL aect801_filter_show('ecca001')
   CALL aect801_filter_show('ecca002')
   CALL aect801_filter_show('ecca003')
   CALL aect801_filter_show('ecca900')
   CALL aect801_filter_show('ecca905')
   CALL aect801_browser_fill("F")
         
   IF g_browser_cnt = 0 THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code   = "-100" 
      LET g_errparam.popup  = TRUE 
      CALL cl_err()
   ELSE
      CALL aect801_fetch("F") 
      #顯示單身筆數
      CALL aect801_idx_chk()
   END IF
 
END FUNCTION
 
{</section>}
 
{<section id="aect801.fetch" >}
#+ 指定PK後抓取單頭其他資料
PRIVATE FUNCTION aect801_fetch(p_flag)
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
   
   
   CALL g_curr_diag.setCurrentRow("s_browse", g_current_idx) #設定browse 索引
   
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
      DISPLAY ' ' TO FORMONLY.idx    
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
   
   #超出範圍
   IF g_current_idx > g_browser.getLength() THEN
      LET g_current_idx = g_browser.getLength()
   END IF
   
   LET g_ecca_m.eccasite = g_browser[g_current_idx].b_eccasite
   LET g_ecca_m.eccadocno = g_browser[g_current_idx].b_eccadocno
 
   
   #重讀DB,因TEMP有不被更新特性
   EXECUTE aect801_master_referesh USING g_ecca_m.eccasite,g_ecca_m.eccadocno INTO g_ecca_m.eccadocno, 
       g_ecca_m.ecca001,g_ecca_m.eccadocdt,g_ecca_m.ecca004,g_ecca_m.ecca002,g_ecca_m.eccasite,g_ecca_m.ecca003, 
       g_ecca_m.ecca900,g_ecca_m.ecca905,g_ecca_m.ecca906,g_ecca_m.eccastus,g_ecca_m.eccaownid,g_ecca_m.eccaowndp, 
       g_ecca_m.eccacrtid,g_ecca_m.eccacrtdp,g_ecca_m.eccacrtdt,g_ecca_m.eccamodid,g_ecca_m.eccamoddt, 
       g_ecca_m.eccacnfid,g_ecca_m.eccacnfdt,g_ecca_m.ecca001_desc,g_ecca_m.ecca905_desc,g_ecca_m.eccaownid_desc, 
       g_ecca_m.eccaowndp_desc,g_ecca_m.eccacrtid_desc,g_ecca_m.eccacrtdp_desc,g_ecca_m.eccamodid_desc, 
       g_ecca_m.eccacnfid_desc
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "ecca_t" 
      LET g_errparam.code   = SQLCA.sqlcode 
      LET g_errparam.popup  = TRUE 
      CALL cl_err()
 
      INITIALIZE g_ecca_m.* TO NULL
      RETURN
   END IF
   
   #根據資料狀態切換action狀態
   CALL cl_set_act_visible("statechange,modify,modify_detail,delete,reproduce", TRUE)
   CALL aect801_set_act_visible()   
   CALL aect801_set_act_no_visible()
   
   #add-point:fetch段action控制
   #170213-00014#1-S
   IF g_ecca_m.eccastus NOT MATCHES '[NDR]' THEN   # N未確認/D抽單/R已拒絕允許修改
      CALL cl_set_act_visible("modify,delete,modify_detail", FALSE)
   END IF
   #170213-00014#1-E
   #end add-point  
   
   
   
   #add-point:fetch結束前
   
   #end add-point
   
   #保存單頭舊值
   LET g_ecca_m_t.* = g_ecca_m.*
   LET g_ecca_m_o.* = g_ecca_m.*
   
   LET g_data_owner = g_ecca_m.eccaownid      
   LET g_data_dept  = g_ecca_m.eccaowndp
   
   #重新顯示   
   CALL aect801_show()
 
   #+ 此段落由子樣板a56產生
   #檢查此單據是否需顯示BPM簽核狀況按鈕 
   IF cl_bpm_chk() THEN
      CALL cl_set_act_visible("bpm_status",TRUE)
   ELSE
      CALL cl_set_act_visible("bpm_status",FALSE)
   END IF
 
 
 
END FUNCTION
 
{</section>}
 
{<section id="aect801.insert" >}
#+ 資料新增
PRIVATE FUNCTION aect801_insert()
   #add-point:insert段define

   #end add-point    
   
   #清畫面欄位內容
   CLEAR FORM                    
   CALL g_eccb_d.clear()   
   CALL g_eccb2_d.clear()  
 
 
   #INITIALIZE g_ecca_m.* LIKE ecca_t.*             #DEFAULT 設定  #161124-00048#2  2016/12/13 By 08734 mark
   INITIALIZE g_ecca_m.* TO NULL            #DEFAULT 設定 #161124-00048#2  2016/12/13 By 08734 add
   
   LET g_eccasite_t = NULL
   LET g_eccadocno_t = NULL
 
   
   LET g_master_insert = FALSE
   
   CALL s_transaction_begin()
   WHILE TRUE
      #公用欄位給值(單頭)
      #此段落由子樣板a14產生    
      #公用欄位新增給值
      LET g_ecca_m.eccaownid = g_user
      LET g_ecca_m.eccaowndp = g_dept
      LET g_ecca_m.eccacrtid = g_user
      LET g_ecca_m.eccacrtdp = g_dept 
      LET g_ecca_m.eccacrtdt = cl_get_current()
      LET g_ecca_m.eccamodid = ""
      LET g_ecca_m.eccamoddt = ""
      LET g_ecca_m.eccastus = "N"
 
 
 
      #append欄位給值
      
     
      #一般欄位給值
            LET g_ecca_m.ecca004 = "1"
 
  
      #add-point:單頭預設值
      LET g_ecca_m.eccasite = g_site
      LET g_ecca_m.eccadocdt = cl_get_today()
      LET g_ecca_m_t.* = g_ecca_m.*
      #end add-point 
      
      #顯示狀態(stus)圖片
            #此段落由子樣板a21產生
	  #根據狀態碼顯示對應圖片
      CASE g_ecca_m.eccastus
         WHEN "A"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/approved.png")
         WHEN "D"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/withdraw.png")
         WHEN "N"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/unconfirmed.png")
         WHEN "R"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/rejection.png")
         WHEN "W"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/signing.png")
         WHEN "X"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/invalid.png")  
         WHEN "Y"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/confirmed.png")                    
            
      END CASE
 
 
    
      CALL aect801_input("a")
      
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
         INITIALIZE g_ecca_m.* TO NULL
         INITIALIZE g_eccb_d TO NULL
         INITIALIZE g_eccb2_d TO NULL
 
         #add-point:取消新增後

         #end add-point 
         CALL aect801_show()
         RETURN
      END IF
      
      LET INT_FLAG = 0
      #CALL g_eccb_d.clear()
      #CALL g_eccb2_d.clear()
 
 
      LET g_rec_b = 0
      CALL s_transaction_end('Y','0')
      EXIT WHILE
        
   END WHILE
   
   #根據資料狀態切換action狀態
   CALL cl_set_act_visible("statechange,modify,modify_detail,delete,reproduce", TRUE)
   CALL aect801_set_act_visible()   
   CALL aect801_set_act_no_visible()
   
   #將新增的資料併入搜尋條件中
   LET g_eccasite_t = g_ecca_m.eccasite
   LET g_eccadocno_t = g_ecca_m.eccadocno
   LET g_state = 'Y'
   
   #組合新增資料的條件
   LET g_add_browse = " eccaent = '" ||g_enterprise|| "' AND",
                      " eccasite = '", g_ecca_m.eccasite, "' "
                      ," AND eccadocno = '", g_ecca_m.eccadocno, "' "
 
                      
   #add-point:組合新增資料的條件後

   #end add-point
      
   #填到最後面
   LET g_current_idx = g_browser.getLength() + 1
   CALL aect801_browser_fill("")
   
   DISPLAY g_browser_cnt TO FORMONLY.h_count    #總筆數
   DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
   CALL cl_navigator_setting(g_current_idx, g_browser_cnt)
   
   CLOSE aect801_cl
   
   CALL aect801_idx_chk()
   
   #add-point:新增結束後
   IF g_flag = 'N' THEN
      LET g_flag = 'Y'
      CALL aect801_modify()
   END IF
   #end add-point 
   
END FUNCTION
 
{</section>}
 
{<section id="aect801.modify" >}
#+ 資料修改
PRIVATE FUNCTION aect801_modify()
   DEFINE l_new_key    DYNAMIC ARRAY OF STRING
   DEFINE l_old_key    DYNAMIC ARRAY OF STRING
   DEFINE l_field_key  DYNAMIC ARRAY OF STRING
   DEFINE l_wc2_table1          STRING
 
   DEFINE l_wc2_table2   STRING
 
 
   #add-point:modify段define
   
   #end add-point    
   
   #保存單頭舊值
   LET g_ecca_m_t.* = g_ecca_m.*
   LET g_ecca_m_o.* = g_ecca_m.*
   
   IF g_ecca_m.eccasite IS NULL
   OR g_ecca_m.eccadocno IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code   = "std-00003" 
      LET g_errparam.popup  = FALSE 
      CALL cl_err()
 
      RETURN
   END IF
 
   ERROR ""
  
   LET g_eccasite_t = g_ecca_m.eccasite
   LET g_eccadocno_t = g_ecca_m.eccadocno
 
   CALL s_transaction_begin()
   
   OPEN aect801_cl USING g_enterprise,g_ecca_m.eccasite,g_ecca_m.eccadocno
   IF STATUS THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "OPEN aect801_cl:" 
      LET g_errparam.code   = STATUS 
      LET g_errparam.popup  = TRUE 
      CALL cl_err()
      CLOSE aect801_cl
      CALL s_transaction_end('N','0')
      RETURN
   END IF
 
   #顯示最新的資料
   EXECUTE aect801_master_referesh USING g_ecca_m.eccasite,g_ecca_m.eccadocno INTO g_ecca_m.eccadocno, 
       g_ecca_m.ecca001,g_ecca_m.eccadocdt,g_ecca_m.ecca004,g_ecca_m.ecca002,g_ecca_m.eccasite,g_ecca_m.ecca003, 
       g_ecca_m.ecca900,g_ecca_m.ecca905,g_ecca_m.ecca906,g_ecca_m.eccastus,g_ecca_m.eccaownid,g_ecca_m.eccaowndp, 
       g_ecca_m.eccacrtid,g_ecca_m.eccacrtdp,g_ecca_m.eccacrtdt,g_ecca_m.eccamodid,g_ecca_m.eccamoddt, 
       g_ecca_m.eccacnfid,g_ecca_m.eccacnfdt,g_ecca_m.ecca001_desc,g_ecca_m.ecca905_desc,g_ecca_m.eccaownid_desc, 
       g_ecca_m.eccaowndp_desc,g_ecca_m.eccacrtid_desc,g_ecca_m.eccacrtdp_desc,g_ecca_m.eccamodid_desc, 
       g_ecca_m.eccacnfid_desc
   
   
   
   #add-point:modify段show之前
   #170213-00014#1-S
   #IF g_ecca_m.eccastus <> 'N' THEN
   #   INITIALIZE g_errparam TO NULL
   #   LET g_errparam.code = 'apm-00035'
   #   LET g_errparam.extend = g_ecca_m.eccastus
   #   LET g_errparam.popup = TRUE
   #   CALL cl_err()
   #   CLOSE aect801_cl
   #   CALL s_transaction_end('N','0')
   #   RETURN
   #END IF
   #170213-00014#1-E
   #end add-point  
   
   #LET l_wc2_table1 = g_wc2_table1
   #LET g_wc2_table1 = " 1=1"
 
   #LET l_wc2_table2 = g_wc2_table2
   #LET l_wc2_table2 = " 1=1"
 
 
   
   CALL aect801_show()
   #add-point:modify段show之後
   
   #end add-point
   
   #LET g_wc2_table1 = l_wc2_table1
 
   #LET  g_wc2_table2 = l_wc2_table2 
 
 
    
   WHILE TRUE
      LET g_eccasite_t = g_ecca_m.eccasite
      LET g_eccadocno_t = g_ecca_m.eccadocno
 
      
      #寫入修改者/修改日期資訊(單頭)
      LET g_ecca_m.eccamodid = g_user 
LET g_ecca_m.eccamoddt = cl_get_current()
LET g_ecca_m.eccamodid_desc = cl_get_username(g_ecca_m.eccamodid)
      
      #add-point:modify段修改前
      #170213-00014#1-S
      IF g_ecca_m.eccastus MATCHES '[DR]' THEN 
         LET g_ecca_m.eccastus = "N"
      END IF
      #170213-00014#1-E
      #end add-point
      
      #欄位更改
      CALL aect801_input("u")
 
      #add-point:modify段修改後
      
      #end add-point
      
      IF INT_FLAG THEN
         LET INT_FLAG = 0
         LET g_ecca_m.* = g_ecca_m_t.*
         CALL aect801_show()
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = '' 
         LET g_errparam.code   = 9001 
         LET g_errparam.popup  = FALSE 
         CALL cl_err()
         CALL s_transaction_end('N','0')
         RETURN
      END IF 
      
      #若有modid跟moddt則進行update
      UPDATE ecca_t SET (eccamodid,eccamoddt) = (g_ecca_m.eccamodid,g_ecca_m.eccamoddt)
       WHERE eccaent = g_enterprise AND eccasite = g_eccasite_t
         AND eccadocno = g_eccadocno_t
 
                  
      #若單頭key欄位有變更
      IF g_ecca_m.eccasite != g_eccasite_t 
      OR g_ecca_m.eccadocno != g_eccadocno_t 
 
      THEN
         CALL s_transaction_begin()
         
         #add-point:單身fk修改前
         
         #end add-point
         
         #更新單身key值
         UPDATE eccb_t SET eccbsite = g_ecca_m.eccasite
                                       ,eccbdocno = g_ecca_m.eccadocno
 
          WHERE eccbent = g_enterprise AND eccbsite = g_eccasite_t
            AND eccbdocno = g_eccadocno_t
 
            
         #add-point:單身fk修改中
         
         #end add-point
 
         CASE
            WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "eccb_t" 
               LET g_errparam.code   = "std-00009" 
               LET g_errparam.popup  = TRUE 
               CALL cl_err()
               CALL s_transaction_end('N','0')
               CONTINUE WHILE
            WHEN SQLCA.sqlcode #其他錯誤
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "eccb_t" 
               LET g_errparam.code   = SQLCA.sqlcode 
               LET g_errparam.popup  = TRUE 
               CALL cl_err()
 
               CALL s_transaction_end('N','0')
               CONTINUE WHILE
         END CASE
         
         #add-point:單身fk修改後
         
         #end add-point
         
 
         
         #更新單身key值
         #add-point:單身fk修改前
         
         #end add-point
         UPDATE eccc_t
            SET ecccsite = g_ecca_m.eccasite
               ,ecccdocno = g_ecca_m.eccadocno
 
          WHERE ecccent = g_enterprise AND
                ecccsite = g_eccasite_t
            AND ecccdocno = g_eccadocno_t
 
         #add-point:單身fk修改中
         
         #end add-point
         CASE
            WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "eccc_t" 
               LET g_errparam.code   = "std-00009" 
               LET g_errparam.popup  = TRUE 
               CALL cl_err()
 
               CALL s_transaction_end('N','0')
               CONTINUE WHILE
            WHEN SQLCA.sqlcode #其他錯誤
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "eccc_t" 
               LET g_errparam.code   = SQLCA.sqlcode 
               LET g_errparam.popup  = TRUE 
               CALL cl_err()
 
               CALL s_transaction_end('N','0')
               CONTINUE WHILE
         END CASE
         #add-point:單身fk修改後
         
         #end add-point
 
 
         
         #UPDATE 多語言table key值
         
         
 
         CALL s_transaction_end('Y','0')
      END IF
    
      EXIT WHILE
   END WHILE
 
   #根據資料狀態切換action狀態
   CALL cl_set_act_visible("statechange,modify,modify_detail,delete,reproduce", TRUE)
   CALL aect801_set_act_visible()   
   CALL aect801_set_act_no_visible()
 
   #組合新增資料的條件
   LET g_add_browse = " eccaent = '" ||g_enterprise|| "' AND",
                      " eccasite = '", g_ecca_m.eccasite, "' "
                      ," AND eccadocno = '", g_ecca_m.eccadocno, "' "
 
   #填到對應位置
   CALL aect801_browser_fill("")
 
   CLOSE aect801_cl
   CALL s_transaction_end('Y','0')
 
   #流程通知預埋點-U
   CALL cl_flow_notify(g_ecca_m.eccasite,'U')
 
END FUNCTION   
 
{</section>}
 
{<section id="aect801.input" >}
#+ 資料輸入
PRIVATE FUNCTION aect801_input(p_cmd)
   DEFINE  p_cmd                 LIKE type_t.chr1
   DEFINE  l_cmd_t               LIKE type_t.chr1
   DEFINE  l_cmd                 LIKE type_t.chr1
   DEFINE  l_n                   LIKE type_t.num5                #檢查重複用  
   DEFINE  l_cnt                 LIKE type_t.num5                #檢查重複用  
   DEFINE  l_lock_sw             LIKE type_t.chr1                #單身鎖住否  
   DEFINE  l_allow_insert        LIKE type_t.num5                #可新增否 
   DEFINE  l_allow_delete        LIKE type_t.num5                #可刪除否  
   DEFINE  l_count               LIKE type_t.num5
   DEFINE  l_i                   LIKE type_t.num5
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
   DEFINE  l_m                   LIKE type_t.num5
   DEFINE  l_m1                  LIKE type_t.num5
   DEFINE  l_success             LIKE type_t.num5
  #DEFINE  l_flag1               LIKE type_t.chr1
   DEFINE  l_ooef004             LIKE ooef_t.ooef004
   DEFINE  l_eccd902             LIKE eccd_t.eccd902
   DEFINE  l_n1                  LIKE type_t.num5
   DEFINE  l_n2                  LIKE type_t.num5
   DEFINE  l_n4                  LIKE type_t.num5
   DEFINE  l_sql                 STRING
   DEFINE  l_sys                 LIKE type_t.num5 
   DEFINE  l_ecceseq             LIKE ecce_t.ecceseq
   DEFINE  l_ecca900             STRING
   #end add-point  
 
   #先做狀態判定
   IF p_cmd = 'r' THEN
      LET l_cmd_t = 'r'
      LET p_cmd   = 'a'
   ELSE
      LET l_cmd_t = p_cmd
   END IF   
   
   #將資料輸出到畫面上
   DISPLAY BY NAME g_ecca_m.eccadocno,g_ecca_m.ecca001,g_ecca_m.oobxl003,g_ecca_m.ecca001_desc,g_ecca_m.eccadocdt, 
       g_ecca_m.ecca001_desc_1,g_ecca_m.ecca004,g_ecca_m.ecca002,g_ecca_m.eccasite,g_ecca_m.ecca003, 
       g_ecca_m.ecca900,g_ecca_m.ecca905,g_ecca_m.ecca905_desc,g_ecca_m.ecca906,g_ecca_m.eccastus,g_ecca_m.eccaownid, 
       g_ecca_m.eccaownid_desc,g_ecca_m.eccaowndp,g_ecca_m.eccaowndp_desc,g_ecca_m.eccacrtid,g_ecca_m.eccacrtid_desc, 
       g_ecca_m.eccacrtdp,g_ecca_m.eccacrtdp_desc,g_ecca_m.eccacrtdt,g_ecca_m.eccamodid,g_ecca_m.eccamodid_desc, 
       g_ecca_m.eccamoddt,g_ecca_m.eccacnfid,g_ecca_m.eccacnfid_desc,g_ecca_m.eccacnfdt
   
   #切換畫面
   IF g_main_hidden THEN
      CALL gfrm_curr.setElementHidden("mainlayout",0)
      CALL gfrm_curr.setElementHidden("worksheet",1)
      LET g_main_hidden = 0
   END IF
 
   CALL cl_set_head_visible("","YES")  
 
   LET l_insert = FALSE
   LET g_action_choice = ""
 
   #add-point:input段define_sql
   
   #end add-point 
   LET g_forupd_sql = "SELECT eccb003,eccb004,eccb005,eccb006,eccb007,eccb008,eccb009,eccb010,eccb011, 
       eccb012,eccb024,eccb025,eccb026,eccb027,eccb034,eccb013,eccb014,eccb015,eccb016,eccb017,eccb018, 
       eccb019,eccb020,eccb030,eccb031,eccb032,eccb021,eccb022,eccb023,eccb033,eccb028,eccb029,eccb035, 
       eccb036,eccb901,eccb905,eccb906,eccb001,eccb002,eccb900,eccb902 FROM eccb_t WHERE eccbent=? AND  
       eccbsite=? AND eccbdocno=? AND eccb003=? FOR UPDATE"
   #add-point:input段define_sql
   
   #end add-point 
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE aect801_bcl CURSOR FROM g_forupd_sql
   
 
   
   #add-point:input段define_sql
   
   #end add-point 
   LET g_forupd_sql = "SELECT eccc004,eccc005,eccc006,eccc007,eccc008,eccc009,eccc010,eccc901,eccc905, 
       eccc906,eccc001,eccc002,eccc900,eccc902 FROM eccc_t WHERE ecccent=? AND ecccsite=? AND ecccdocno=?  
       AND eccc003=? AND eccc004=? FOR UPDATE"
   #add-point:input段define_sql
   
   #end add-point 
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE aect801_bcl2 CURSOR FROM g_forupd_sql
 
 
 
   #add-point:input段define_sql
   LET g_forupd_sql = "SELECT eccdseq,eccd005,eccd006,eccd007,eccd008,eccd901,eccd905,'',eccd906 FROM eccd_t",
                   " WHERE eccdent=? AND eccdsite=? AND eccddocno=? AND eccd003=? AND eccd004=? AND eccd005=? FOR UPDATE"
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)
   DECLARE aect801_bcl3 CURSOR FROM g_forupd_sql
   #end add-point 
 
   LET l_allow_insert = cl_auth_detail_input("insert")
   LET l_allow_delete = cl_auth_detail_input("delete")
   LET g_qryparam.state = 'i'
   
   #控制key欄位可否輸入
   CALL aect801_set_entry(p_cmd)
   #add-point:set_entry後
   
   #end add-point
   CALL aect801_set_no_entry(p_cmd)
 
   DISPLAY BY NAME g_ecca_m.eccadocno,g_ecca_m.ecca001,g_ecca_m.eccadocdt,g_ecca_m.ecca004,g_ecca_m.ecca002, 
       g_ecca_m.eccasite,g_ecca_m.ecca003,g_ecca_m.ecca900,g_ecca_m.ecca905,g_ecca_m.ecca906,g_ecca_m.eccastus 
 
   
   LET lb_reproduce = FALSE
   
   #add-point:資料輸入前
 # LET l_flag1 = 'Y'
   LET g_flag = 'Y'
   #end add-point
   
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
 
{</section>}
 
{<section id="aect801.input.head" >}
      #單頭段
      INPUT BY NAME g_ecca_m.eccadocno,g_ecca_m.ecca001,g_ecca_m.eccadocdt,g_ecca_m.ecca004,g_ecca_m.ecca002, 
          g_ecca_m.eccasite,g_ecca_m.ecca003,g_ecca_m.ecca900,g_ecca_m.ecca905,g_ecca_m.ecca906,g_ecca_m.eccastus  
 
         ATTRIBUTE(WITHOUT DEFAULTS)
         
         #自訂ACTION(master_input)
         
     
         BEFORE INPUT
            IF s_transaction_chk("N",0) THEN
               CALL s_transaction_begin()
            END IF
            OPEN aect801_cl USING g_enterprise,g_ecca_m.eccasite,g_ecca_m.eccadocno
            IF STATUS THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "OPEN aect801_cl:" 
               LET g_errparam.code   = STATUS 
               LET g_errparam.popup  = TRUE 
               CALL cl_err()
               CLOSE aect801_cl
               CALL s_transaction_end('N','0')
               RETURN
            END IF
            
            IF l_cmd_t = 'r' THEN
               
            END IF
            #add-point:資料輸入前
            
            #end add-point
 
                  #此段落由子樣板a01產生
         BEFORE FIELD eccadocno
            #add-point:BEFORE FIELD eccadocno
            
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD eccadocno
            
            #add-point:AFTER FIELD eccadocno
            #此段落由子樣板a05產生
            IF NOT cl_null(g_ecca_m.eccasite) AND NOT cl_null(g_ecca_m.eccadocno) THEN 
               #CALL s_aooi200_chk_slip(g_site,'',g_ecca_m.eccadocno,'aect801') #160613-00038#1 mark
               CALL s_aooi200_chk_slip(g_site,'',g_ecca_m.eccadocno,g_prog)     #160613-00038#1 add
               RETURNING l_success
               IF NOT l_success THEN
                  NEXT FIELD CURRENT
               END IF
               #单别带出单据名称
               CALL s_aooi200_get_slip_desc(g_ecca_m.eccadocno)
                 RETURNING g_ecca_m.oobxl003
               DISPLAY g_ecca_m.oobxl003 TO FORMONLY.oobxl003
               
               IF p_cmd = 'a' OR ( p_cmd = 'u' AND (g_ecca_m.eccasite != g_eccasite_t  OR g_ecca_m.eccadocno != g_eccadocno_t )) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM ecca_t WHERE "||"eccaent = '" ||g_enterprise|| "' AND "||"eccasite = '"||g_ecca_m.eccasite ||"' AND "|| "eccadocno = '"||g_ecca_m.eccadocno ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF



            #END add-point
            
 
         #此段落由子樣板a04產生
         ON CHANGE eccadocno
            #add-point:ON CHANGE eccadocno
            
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD ecca001
            
            #add-point:AFTER FIELD ecca001
            CALL aect801_desc()
            IF NOT cl_null(g_ecca_m.ecca001) AND (cl_null(g_ecca_m_t.ecca001) OR g_ecca_m.ecca001 != g_ecca_m_t.ecca001) THEN
               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
               INITIALIZE g_chkparam.* TO NULL
               #設定g_chkparam.*的參數
               LET g_chkparam.arg1 = g_ecca_m.ecca001
               #呼叫檢查存在並帶值的library
               IF NOT cl_chk_exist("v_imaf001_1") THEN
                  LET g_ecca_m.ecca001 = g_ecca_m_t.ecca001
                  CALL aect801_desc()
                  NEXT FIELD ecca001
               END IF
               
               IF NOT cl_null(g_ecca_m.ecca002) THEN
                  #同一张制程不可有多张未确认的变更单
                  SELECT COUNT(*) INTO l_m1 FROM ecca_t 
                   WHERE eccaent = g_enterprise AND eccasite = g_site
                     AND ecca001 = g_ecca_m.ecca001 AND ecca002 = g_ecca_m.ecca002
                     AND eccastus = 'N'
                  IF l_m1 > 0 THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = 'aec-00036'
                     LET g_errparam.extend = ''
                     LET g_errparam.popup = TRUE
                     CALL cl_err()      
                     LET g_ecca_m.ecca001 = g_ecca_m_t.ecca001                     
                     NEXT FIELD ecca001
                  END IF
                  
                  SELECT COUNT(*) INTO l_m FROM ecba_t 
                   WHERE ecbaent = g_enterprise AND ecbasite = g_site
                     AND ecba001 = g_ecca_m.ecca001 AND ecba002 = g_ecca_m.ecca002
                  IF l_m > 0 THEN 
                     SELECT COUNT(*) INTO l_m FROM ecba_t 
                      WHERE ecbaent = g_enterprise AND ecbasite = g_site
                        AND ecba001 = g_ecca_m.ecca001 AND ecba002 = g_ecca_m.ecca002 AND ecbastus = 'Y'
                     IF l_m = 0 THEN
                        INITIALIZE g_errparam TO NULL
                        LET g_errparam.code = 'aec-00043'
                        LET g_errparam.extend = ''
                        LET g_errparam.popup = TRUE
                        CALL cl_err()      
                        LET g_ecca_m.ecca001 = g_ecca_m_t.ecca001                     
                        NEXT FIELD ecca001
                     END IF       
                     
                     #自动编号
                     CALL s_aooi200_gen_docno(g_site,g_ecca_m.eccadocno,g_ecca_m.eccadocdt,g_prog)
                          RETURNING l_success,g_ecca_m.eccadocno
                     IF NOT l_success THEN
                        NEXT FIELD eccadocno
                     END IF
                     LET g_ecca_m.ecca004 = '2'
                     #變更序=變更單的變更序最大值+1
                     SELECT MAX(ecca900)+1 INTO g_ecca_m.ecca900 FROM ecca_t
                      WHERE eccaent = g_enterprise AND eccasite = g_site
                        AND ecca001 = g_ecca_m.ecca001 AND ecca002 = g_ecca_m.ecca002 
                     IF cl_null(g_ecca_m.ecca900) OR g_ecca_m.ecca900 = 0 THEN
                        LET g_ecca_m.ecca900 = 1
                     END IF
                     IF NOT aect801_gen() THEN
                        LET g_ecca_m.ecca001 = g_ecca_m_t.ecca001
                        CALL aect801_desc()
                        NEXT FIELD ecca001
                     END IF
                   # LET l_flag1 = 'N'
                     LET g_flag = 'N'
                     EXIT DIALOG
                  END IF
               END IF
            END IF
            
            
            #END add-point
            
 
         #此段落由子樣板a01產生
         BEFORE FIELD ecca001
            #add-point:BEFORE FIELD ecca001
            
            #END add-point
 
         #此段落由子樣板a04產生
         ON CHANGE ecca001
            #add-point:ON CHANGE ecca001
            
            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD eccadocdt
            #add-point:BEFORE FIELD eccadocdt
            
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD eccadocdt
            
            #add-point:AFTER FIELD eccadocdt
            
            #END add-point
            
 
         #此段落由子樣板a04產生
         ON CHANGE eccadocdt
            #add-point:ON CHANGE eccadocdt
            
            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD ecca004
            #add-point:BEFORE FIELD ecca004
            
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD ecca004
            
            #add-point:AFTER FIELD ecca004
            
            #END add-point
            
 
         #此段落由子樣板a04產生
         ON CHANGE ecca004
            #add-point:ON CHANGE ecca004
            
            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD ecca002
            #add-point:BEFORE FIELD ecca002
            
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD ecca002
            
            #add-point:AFTER FIELD ecca002
            CALL aect801_desc()
            IF NOT cl_null(g_ecca_m.ecca002) AND (cl_null(g_ecca_m_t.ecca002) OR g_ecca_m.ecca002 != g_ecca_m_t.ecca002) THEN
               IF NOT cl_null(g_ecca_m.ecca001) THEN
                  #同一张制程不可有多张未确认的变更单
                  SELECT COUNT(*) INTO l_m1 FROM ecca_t 
                   WHERE eccaent = g_enterprise AND eccasite = g_site
                     AND ecca001 = g_ecca_m.ecca001 AND ecca002 = g_ecca_m.ecca002
                     AND eccastus = 'N'
                  IF l_m1 > 0 THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = 'aec-00036'
                     LET g_errparam.extend = ''
                     LET g_errparam.popup = TRUE
                     CALL cl_err()   
                     LET g_ecca_m.ecca002 = g_ecca_m_t.ecca002                     
                     NEXT FIELD ecca002
                  END IF
                     
                  SELECT COUNT(*) INTO l_m FROM ecba_t 
                   WHERE ecbaent = g_enterprise AND ecbasite = g_site
                     AND ecba001 = g_ecca_m.ecca001 AND ecba002 = g_ecca_m.ecca002
                  IF l_m > 0 THEN  
                     SELECT COUNT(*) INTO l_m FROM ecba_t 
                      WHERE ecbaent = g_enterprise AND ecbasite = g_site
                        AND ecba001 = g_ecca_m.ecca001 AND ecba002 = g_ecca_m.ecca002 AND ecbastus = 'Y'
                     IF l_m = 0 THEN
                        INITIALIZE g_errparam TO NULL
                        LET g_errparam.code = 'aec-00043'
                        LET g_errparam.extend = ''
                        LET g_errparam.popup = TRUE
                        CALL cl_err()      
                        LET g_ecca_m.ecca002 = g_ecca_m_t.ecca002                     
                        NEXT FIELD ecca002
                     END IF                         
                     #自动编号
                     CALL s_aooi200_gen_docno(g_site,g_ecca_m.eccadocno,g_ecca_m.eccadocdt,g_prog)
                          RETURNING l_success,g_ecca_m.eccadocno
                     IF NOT l_success THEN
                        NEXT FIELD eccadocno
                     END IF
                     LET g_ecca_m.ecca004 = '2'
                     #變更序=變更單的變更序最大值+1
                     SELECT MAX(ecca900)+1 INTO g_ecca_m.ecca900 FROM ecca_t
                      WHERE eccaent = g_enterprise AND eccasite = g_site
                        AND ecca001 = g_ecca_m.ecca001 AND ecca002 = g_ecca_m.ecca002 
                     IF cl_null(g_ecca_m.ecca900) OR g_ecca_m.ecca900 = 0 THEN
                        LET g_ecca_m.ecca900 = 1
                     END IF
                     IF NOT aect801_gen() THEN
                        LET g_ecca_m.ecca001 = g_ecca_m_t.ecca001
                        CALL aect801_desc()
                        NEXT FIELD ecca002
                     END IF
                   # LET l_flag1 = 'N'
                     LET g_flag = 'N'
                     EXIT DIALOG
                  END IF
               END IF
            END IF
            #END add-point
            
 
         #此段落由子樣板a04產生
         ON CHANGE ecca002
            #add-point:ON CHANGE ecca002
            
            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD eccasite
            #add-point:BEFORE FIELD eccasite
            
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD eccasite
            
            #add-point:AFTER FIELD eccasite
            #此段落由子樣板a05產生
            IF  NOT cl_null(g_ecca_m.eccasite) AND NOT cl_null(g_ecca_m.eccadocno) THEN 
               IF p_cmd = 'a' OR ( p_cmd = 'u' AND (g_ecca_m.eccasite != g_eccasite_t  OR g_ecca_m.eccadocno != g_eccadocno_t )) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM ecca_t WHERE "||"eccaent = '" ||g_enterprise|| "' AND "||"eccasite = '"||g_ecca_m.eccasite ||"' AND "|| "eccadocno = '"||g_ecca_m.eccadocno ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF



            #END add-point
            
 
         #此段落由子樣板a04產生
         ON CHANGE eccasite
            #add-point:ON CHANGE eccasite
            
            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD ecca003
            #add-point:BEFORE FIELD ecca003
            
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD ecca003
            
            #add-point:AFTER FIELD ecca003
            
            #END add-point
            
 
         #此段落由子樣板a04產生
         ON CHANGE ecca003
            #add-point:ON CHANGE ecca003
            
            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD ecca900
            #add-point:BEFORE FIELD ecca900
            
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD ecca900
            
            #add-point:AFTER FIELD ecca900
            
            #END add-point
            
 
         #此段落由子樣板a04產生
         ON CHANGE ecca900
            #add-point:ON CHANGE ecca900
            
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD ecca905
            
            #add-point:AFTER FIELD ecca905
            IF NOT cl_null(g_ecca_m.ecca905) AND (cl_null(g_ecca_m_t.ecca905) OR g_ecca_m.ecca905 != g_ecca_m_t.ecca905) THEN
               IF NOT aect801_ecca905_chk(g_ecca_m.ecca905) THEN
                  LET g_ecca_m.ecca905 = g_ecca_m_t.ecca905
                  CALL aect801_ecca905_desc(g_ecca_m.ecca905) RETURNING g_ecca_m.ecca905_desc
                  DISPLAY BY NAME g_ecca_m.ecca905_desc
                  NEXT FIELD ecca905
               END IF
               CALL aect801_ecca905_desc(g_ecca_m.ecca905) RETURNING g_ecca_m.ecca905_desc
               DISPLAY BY NAME g_ecca_m.ecca905_desc
            END IF
            
            #END add-point
            
 
         #此段落由子樣板a01產生
         BEFORE FIELD ecca905
            #add-point:BEFORE FIELD ecca905
            
            #END add-point
 
         #此段落由子樣板a04產生
         ON CHANGE ecca905
            #add-point:ON CHANGE ecca905
            
            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD ecca906
            #add-point:BEFORE FIELD ecca906
            
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD ecca906
            
            #add-point:AFTER FIELD ecca906
            
            #END add-point
            
 
         #此段落由子樣板a04產生
         ON CHANGE ecca906
            #add-point:ON CHANGE ecca906
            
            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD eccastus
            #add-point:BEFORE FIELD eccastus
            
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD eccastus
            
            #add-point:AFTER FIELD eccastus
            
            #END add-point
            
 
         #此段落由子樣板a04產生
         ON CHANGE eccastus
            #add-point:ON CHANGE eccastus
            
            #END add-point
 
 #欄位檢查
                  #Ctrlp:input.c.eccadocno
         ON ACTION controlp INFIELD eccadocno
            #add-point:ON ACTION controlp INFIELD eccadocno
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_ecca_m.eccadocno             #給予default值

            #給予arg
            SELECT ooef004 INTO l_ooef004 FROM ooef_t
             WHERE ooef001 = g_site
               AND ooefent  = g_enterprise
            LET g_qryparam.arg1 = l_ooef004 #參照表編號
            LET g_qryparam.arg2 = g_prog    #作业代号
            
            CALL q_ooba002_1()                                #呼叫開窗

            LET g_ecca_m.eccadocno = g_qryparam.return1              

            DISPLAY g_ecca_m.eccadocno TO eccadocno              #

            NEXT FIELD eccadocno                          #返回原欄位


            #END add-point
 
         #Ctrlp:input.c.ecca001
         ON ACTION controlp INFIELD ecca001
            #add-point:ON ACTION controlp INFIELD ecca001
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_ecca_m.ecca001             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "" #

            
            CALL q_imaf001_6()                                #呼叫開窗

            LET g_ecca_m.ecca001 = g_qryparam.return1              

            DISPLAY g_ecca_m.ecca001 TO ecca001              #

            NEXT FIELD ecca001                          #返回原欄位


            #END add-point
 
         #Ctrlp:input.c.eccadocdt
         ON ACTION controlp INFIELD eccadocdt
            #add-point:ON ACTION controlp INFIELD eccadocdt
            
            #END add-point
 
         #Ctrlp:input.c.ecca004
         ON ACTION controlp INFIELD ecca004
            #add-point:ON ACTION controlp INFIELD ecca004
            
            #END add-point
 
         #Ctrlp:input.c.ecca002
         ON ACTION controlp INFIELD ecca002
            #add-point:ON ACTION controlp INFIELD ecca002
            
            #END add-point
 
         #Ctrlp:input.c.eccasite
         ON ACTION controlp INFIELD eccasite
            #add-point:ON ACTION controlp INFIELD eccasite
            
            #END add-point
 
         #Ctrlp:input.c.ecca003
         ON ACTION controlp INFIELD ecca003
            #add-point:ON ACTION controlp INFIELD ecca003
            
            #END add-point
 
         #Ctrlp:input.c.ecca900
         ON ACTION controlp INFIELD ecca900
            #add-point:ON ACTION controlp INFIELD ecca900
            
            #END add-point
 
         #Ctrlp:input.c.ecca905
         ON ACTION controlp INFIELD ecca905
            #add-point:ON ACTION controlp INFIELD ecca905
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_ecca_m.ecca905             #給予default值

            LET g_qryparam.arg1 = g_acc
            
            CALL q_oocq002()                                #呼叫開窗

            LET g_ecca_m.ecca905 = g_qryparam.return1              
            DISPLAY g_ecca_m.ecca905 TO ecca905     
            NEXT FIELD ecca905                          #返回原欄位
            #END add-point
 
         #Ctrlp:input.c.ecca906
         ON ACTION controlp INFIELD ecca906
            #add-point:ON ACTION controlp INFIELD ecca906
            
            #END add-point
 
         #Ctrlp:input.c.eccastus
         ON ACTION controlp INFIELD eccastus
            #add-point:ON ACTION controlp INFIELD eccastus
            
            #END add-point
 
 #欄位開窗
            
         AFTER INPUT
            IF INT_FLAG THEN
               EXIT DIALOG
            END IF
 
            #CALL cl_err_collect_show()      #錯誤訊息統整顯示
            #CALL cl_showmsg()
            DISPLAY BY NAME g_ecca_m.eccasite,g_ecca_m.eccadocno
                        
            #add-point:單頭INPUT後
            
            #end add-point
                        
            IF p_cmd <> 'u' THEN
    
               CALL s_transaction_begin()
               
               #add-point:單頭新增前
               CALL s_aooi200_gen_docno(g_site,g_ecca_m.eccadocno,g_ecca_m.eccadocdt,g_prog)
                    RETURNING l_success,g_ecca_m.eccadocno
               IF NOT l_success THEN
                  NEXT FIELD eccadocno
               END IF
               #end add-point
               
               INSERT INTO ecca_t (eccaent,eccadocno,ecca001,eccadocdt,ecca004,ecca002,eccasite,ecca003, 
                   ecca900,ecca905,ecca906,eccastus,eccaownid,eccaowndp,eccacrtid,eccacrtdp,eccacrtdt, 
                   eccacnfid,eccacnfdt)
               VALUES (g_enterprise,g_ecca_m.eccadocno,g_ecca_m.ecca001,g_ecca_m.eccadocdt,g_ecca_m.ecca004, 
                   g_ecca_m.ecca002,g_ecca_m.eccasite,g_ecca_m.ecca003,g_ecca_m.ecca900,g_ecca_m.ecca905, 
                   g_ecca_m.ecca906,g_ecca_m.eccastus,g_ecca_m.eccaownid,g_ecca_m.eccaowndp,g_ecca_m.eccacrtid, 
                   g_ecca_m.eccacrtdp,g_ecca_m.eccacrtdt,g_ecca_m.eccacnfid,g_ecca_m.eccacnfdt) 
               IF SQLCA.sqlcode THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "g_ecca_m" 
                  LET g_errparam.code   = SQLCA.sqlcode 
                  LET g_errparam.popup  = TRUE 
                  CALL cl_err()
                  CALL s_transaction_end('N','0')
                  CONTINUE DIALOG
               END IF
               
               #add-point:單頭新增中
               
               #end add-point
               
               
               
               
               #add-point:單頭新增後
               
               #end add-point
               CALL s_transaction_end('Y','0') 
               
               IF l_cmd_t = 'r' AND p_cmd = 'a' THEN
                  CALL aect801_detail_reproduce()
                  #因應特定程式需求, 重新刷新單身資料
                  CALL aect801_b_fill()
               END IF
               
               #add-point:單頭新增後
               
               #end add-point
               
               LET g_master_insert = TRUE
               
               LET p_cmd = 'u'
            ELSE
               CALL s_transaction_begin()
            
               #add-point:單頭修改前
               
               #end add-point
               
               UPDATE ecca_t SET (eccadocno,ecca001,eccadocdt,ecca004,ecca002,eccasite,ecca003,ecca900, 
                   ecca905,ecca906,eccastus,eccaownid,eccaowndp,eccacrtid,eccacrtdp,eccacrtdt,eccacnfid, 
                   eccacnfdt) = (g_ecca_m.eccadocno,g_ecca_m.ecca001,g_ecca_m.eccadocdt,g_ecca_m.ecca004, 
                   g_ecca_m.ecca002,g_ecca_m.eccasite,g_ecca_m.ecca003,g_ecca_m.ecca900,g_ecca_m.ecca905, 
                   g_ecca_m.ecca906,g_ecca_m.eccastus,g_ecca_m.eccaownid,g_ecca_m.eccaowndp,g_ecca_m.eccacrtid, 
                   g_ecca_m.eccacrtdp,g_ecca_m.eccacrtdt,g_ecca_m.eccacnfid,g_ecca_m.eccacnfdt)
                WHERE eccaent = g_enterprise AND eccasite = g_eccasite_t
                  AND eccadocno = g_eccadocno_t
 
               IF SQLCA.sqlcode THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "ecca_t" 
                  LET g_errparam.code   = SQLCA.sqlcode 
                  LET g_errparam.popup  = TRUE 
                  CALL cl_err()
 
                  CALL s_transaction_end('N','0')
                  CONTINUE DIALOG
               END IF
               
               #add-point:單頭修改中
               IF NOT aect801_upd_ecca_ecch() THEN
                  CALL s_transaction_end('N','0')
                  CONTINUE DIALOG               
               END IF
               #end add-point
               
               
               
               
               #修改歷程記錄
               LET g_log1 = util.JSON.stringify(g_ecca_m_t)
               LET g_log2 = util.JSON.stringify(g_ecca_m)
               IF NOT cl_log_modified_record(g_log1,g_log2) THEN 
                  CALL s_transaction_end('N','0')
               ELSE
                  CALL s_transaction_end('Y','0')
               END IF
               
               #add-point:單頭修改後
               
               #end add-point
            END IF
            
            LET g_eccasite_t = g_ecca_m.eccasite
            LET g_eccadocno_t = g_ecca_m.eccadocno
 
            
      END INPUT
   
 
{</section>}
 
{<section id="aect801.input.body" >}
   
      #Page1 預設值產生於此處
      INPUT ARRAY g_eccb_d FROM s_detail1.*
          ATTRIBUTE(COUNT = g_rec_b,WITHOUT DEFAULTS, #MAXCOUNT = g_max_rec,
                  INSERT ROW = l_allow_insert, 
                  DELETE ROW = l_allow_delete,
                  APPEND ROW = l_allow_insert)
 
         #自訂ACTION(detail_input,page_1)
         
 
         #+ 此段落由子樣板a43產生
         ON ACTION checkout
            LET g_action_choice="checkout"
            IF cl_auth_chk_act("checkout") THEN
               
               #add-point:ON ACTION checkout
               IF g_detail_idx > 0 THEN
                   IF NOT cl_null(g_ecca_m.eccadocno) AND NOT cl_null(g_eccb_d[l_ac].eccb003) AND NOT cl_null(g_eccb_d[l_ac].eccb004)  AND NOT cl_null(g_eccb_d[l_ac].eccb005) THEN
                      CALL aect801_02(g_ecca_m.eccadocno,g_eccb_d[l_ac].eccb003,g_eccb_d[l_ac].eccb004,g_eccb_d[l_ac].eccb005,'2','Y')
                   END IF
                END IF
                LET g_action_choice=""
               #END add-point
            END IF
 
 
         #+ 此段落由子樣板a43產生
         ON ACTION resource
            LET g_action_choice="resource"
            IF cl_auth_chk_act("resource") THEN
               
               #add-point:ON ACTION resource
               IF NOT cl_null(g_ecca_m.eccadocno) AND NOT cl_null(g_eccb_d[l_ac].eccb003) AND NOT cl_null(g_eccb_d[l_ac].eccb004) AND NOT cl_null(g_eccb_d[l_ac].eccb005) THEN
                  CALL aect801_03(g_ecca_m.eccadocno,g_eccb_d[l_ac].eccb003,g_eccb_d[l_ac].eccb004,g_eccb_d[l_ac].eccb005,'Y')
               END IF
               LET g_action_choice=""
               #END add-point
            END IF
 
 
         #+ 此段落由子樣板a43產生
         ON ACTION stand
            LET g_action_choice="stand"
            IF cl_auth_chk_act("stand") THEN
               
               #add-point:ON ACTION stand
               IF NOT cl_null(g_ecca_m.eccadocno) AND NOT cl_null(g_eccb_d[l_ac].eccb003) AND NOT cl_null(g_eccb_d[l_ac].eccb004) AND NOT cl_null(g_eccb_d[l_ac].eccb005) THEN
                  CALL aect801_01(g_ecca_m.eccadocno,g_eccb_d[l_ac].eccb003,g_eccb_d[l_ac].eccb004,g_eccb_d[l_ac].eccb005,'Y')
               END IF
               SELECT COUNT(*) INTO l_n FROM ecce_t WHERE ecceent=g_enterprise AND eccesite=g_site 
                  AND eccedocno = g_ecca_m.eccadocno AND ecce003 = g_eccb_d[l_ac].eccb003
               IF l_n = 0 THEN
                  LET g_eccb_d[l_ac].eccb008 = ''
                  LET g_eccb_d[l_ac].eccb009 = ''
               END IF
               IF l_n = 1 THEN
                  SELECT ecce004,ecce005 INTO g_eccb_d[l_ac].eccb008,g_eccb_d[l_ac].eccb009 FROM ecce_t
                   WHERE ecceent=g_enterprise AND eccesite=g_site 
                     AND eccedocno = g_ecca_m.eccadocno AND ecce003 = g_eccb_d[l_ac].eccb003
               END IF
               IF l_n > 1 THEN
                  LET g_eccb_d[l_ac].eccb008 = 'MULT'
                  LET g_eccb_d[l_ac].eccb009 = 0
               END IF
               UPDATE eccb_t SET eccb008=g_eccb_d[l_ac].eccb008,eccb009=g_eccb_d[l_ac].eccb009
                WHERE eccbent=g_enterprise AND eccbsite=g_site 
                  AND eccbdocno = g_ecca_m.eccadocno AND eccb003 = g_eccb_d[l_ac].eccb003
             # CALL aect801_b_fill()
               LET g_action_choice=""
               #END add-point
            END IF
 
 
         #+ 此段落由子樣板a43產生
         ON ACTION checkin
            LET g_action_choice="checkin"
            IF cl_auth_chk_act("checkin") THEN
               
               #add-point:ON ACTION checkin
               IF g_detail_idx > 0 THEN
                   IF NOT cl_null(g_ecca_m.eccadocno) AND NOT cl_null(g_eccb_d[l_ac].eccb003) AND NOT cl_null(g_eccb_d[l_ac].eccb004)  AND NOT cl_null(g_eccb_d[l_ac].eccb005) THEN
                      CALL aect801_02(g_ecca_m.eccadocno,g_eccb_d[l_ac].eccb003,g_eccb_d[l_ac].eccb004,g_eccb_d[l_ac].eccb005,'1','Y')
                   END IF
                END IF
                LET g_action_choice=""
               #END add-point
            END IF
 
 
         
         BEFORE INPUT
            #add-point:資料輸入前
            
            #end add-point
            IF g_insert = 'Y' AND NOT cl_null(g_insert) THEN 
              CALL FGL_SET_ARR_CURR(g_eccb_d.getLength()+1) 
              LET g_insert = 'N' 
           END IF 
 
            CALL aect801_b_fill()
            IF g_rec_b != 0 THEN
               CALL fgl_set_arr_curr(l_ac)
            END IF
            LET g_rec_b = g_eccb_d.getLength()
            #add-point:資料輸入前
            
            #end add-point
         
         BEFORE ROW
            #add-point:modify段before row2
            CALL cl_set_comp_entry("eccb003",TRUE)
            #end add-point  
            LET l_insert = FALSE
            LET l_cmd = ''
            LET l_ac = ARR_CURR()
            LET g_detail_idx = l_ac
            #填充下層單身資料
CALL aect801_b_fill2('2')
 
            LET l_lock_sw = 'N'            #DEFAULT
            LET l_n = ARR_COUNT()
            DISPLAY l_ac TO FORMONLY.idx
         
            CALL s_transaction_begin()
            OPEN aect801_cl USING g_enterprise,g_ecca_m.eccasite,g_ecca_m.eccadocno
            IF STATUS THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "OPEN aect801_cl:" 
               LET g_errparam.code   = STATUS 
               LET g_errparam.popup  = TRUE 
               CALL cl_err()
               CLOSE aect801_cl
               CALL s_transaction_end('N','0')
               RETURN
            END IF
            
            LET g_rec_b = g_eccb_d.getLength()
            
            IF g_rec_b >= l_ac 
               AND g_eccb_d[l_ac].eccb003 IS NOT NULL
 
            THEN
               LET l_cmd='u'
               LET g_eccb_d_t.* = g_eccb_d[l_ac].*  #BACKUP
               LET g_eccb_d_o.* = g_eccb_d[l_ac].*  #BACKUP
               CALL aect801_set_entry_b(l_cmd)
               #add-point:modify段after_set_entry_b
               CALL cl_set_comp_entry("eccb003",FALSE)
               #end add-point  
               CALL aect801_set_no_entry_b(l_cmd)
               IF NOT aect801_lock_b("eccb_t","'1'") THEN
                  LET l_lock_sw='Y'
               ELSE
                  FETCH aect801_bcl INTO g_eccb_d[l_ac].eccb003,g_eccb_d[l_ac].eccb004,g_eccb_d[l_ac].eccb005, 
                      g_eccb_d[l_ac].eccb006,g_eccb_d[l_ac].eccb007,g_eccb_d[l_ac].eccb008,g_eccb_d[l_ac].eccb009, 
                      g_eccb_d[l_ac].eccb010,g_eccb_d[l_ac].eccb011,g_eccb_d[l_ac].eccb012,g_eccb_d[l_ac].eccb024, 
                      g_eccb_d[l_ac].eccb025,g_eccb_d[l_ac].eccb026,g_eccb_d[l_ac].eccb027,g_eccb_d[l_ac].eccb034, 
                      g_eccb_d[l_ac].eccb013,g_eccb_d[l_ac].eccb014,g_eccb_d[l_ac].eccb015,g_eccb_d[l_ac].eccb016, 
                      g_eccb_d[l_ac].eccb017,g_eccb_d[l_ac].eccb018,g_eccb_d[l_ac].eccb019,g_eccb_d[l_ac].eccb020, 
                      g_eccb_d[l_ac].eccb030,g_eccb_d[l_ac].eccb031,g_eccb_d[l_ac].eccb032,g_eccb_d[l_ac].eccb021, 
                      g_eccb_d[l_ac].eccb022,g_eccb_d[l_ac].eccb023,g_eccb_d[l_ac].eccb033,g_eccb_d[l_ac].eccb028, 
                      g_eccb_d[l_ac].eccb029,g_eccb_d[l_ac].eccb035,g_eccb_d[l_ac].eccb036,g_eccb_d[l_ac].eccb901, 
                      g_eccb_d[l_ac].eccb905,g_eccb_d[l_ac].eccb906,g_eccb_d[l_ac].eccb001,g_eccb_d[l_ac].eccb002, 
                      g_eccb_d[l_ac].eccb900,g_eccb_d[l_ac].eccb902
                  IF SQLCA.sqlcode THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = g_eccb_d_t.eccb003 
                     LET g_errparam.code   = SQLCA.sqlcode 
                     LET g_errparam.popup  = TRUE 
                     CALL cl_err()
                     LET l_lock_sw = "Y"
                  END IF
                  
                  LET g_bfill = "N"
                  CALL aect801_show()
                  LET g_bfill = "Y"
                  
                  CALL cl_show_fld_cont()
               END IF
            ELSE
               LET l_cmd='a'
            END IF
            #add-point:modify段before row
            
            #end add-point  
            #其他table資料備份(確定是否更改用)
            
            #其他table進行lock
            
        
         BEFORE INSERT
            
            LET l_insert = TRUE
            LET l_n = ARR_COUNT()
            LET l_cmd = 'a'
            INITIALIZE g_eccb_d[l_ac].* TO NULL 
            INITIALIZE g_eccb_d_t.* TO NULL 
            INITIALIZE g_eccb_d_o.* TO NULL 
            #公用欄位給值(單身)
            
            #自定義預設值
                  LET g_eccb_d[l_ac].eccb006 = "1"
      LET g_eccb_d[l_ac].eccb024 = "0"
      LET g_eccb_d[l_ac].eccb025 = "0"
      LET g_eccb_d[l_ac].eccb026 = "0"
      LET g_eccb_d[l_ac].eccb027 = "0"
      LET g_eccb_d[l_ac].eccb034 = "0"
      LET g_eccb_d[l_ac].eccb013 = "N"
      LET g_eccb_d[l_ac].eccb015 = "N"
      LET g_eccb_d[l_ac].eccb016 = "N"
      LET g_eccb_d[l_ac].eccb017 = "Y"
      LET g_eccb_d[l_ac].eccb018 = "N"
      LET g_eccb_d[l_ac].eccb019 = "N"
      LET g_eccb_d[l_ac].eccb020 = "N"
      LET g_eccb_d[l_ac].eccb031 = "1"
      LET g_eccb_d[l_ac].eccb032 = "1"
      LET g_eccb_d[l_ac].eccb022 = "1"
      LET g_eccb_d[l_ac].eccb023 = "1"
      LET g_eccb_d[l_ac].eccb033 = "N"
      LET g_eccb_d[l_ac].eccb901 = "3"
 
            #add-point:modify段before備份
            LET g_eccb_d[l_ac].eccb001 = g_ecca_m.ecca001
            LET g_eccb_d[l_ac].eccb002 = g_ecca_m.ecca002
            LET g_eccb_d[l_ac].eccb900 = g_ecca_m.ecca900
            LET g_eccb_d[l_ac].eccb902 = cl_get_today()
            #end add-point
            LET g_eccb_d_t.* = g_eccb_d[l_ac].*     #新輸入資料
            LET g_eccb_d_o.* = g_eccb_d[l_ac].*     #新輸入資料
            CALL cl_show_fld_cont()
            CALL aect801_set_entry_b(l_cmd)
            #add-point:modify段after_set_entry_b
            
            #end add-point
            CALL aect801_set_no_entry_b(l_cmd)
            IF lb_reproduce THEN
               LET lb_reproduce = FALSE
               LET g_eccb_d[li_reproduce_target].* = g_eccb_d[li_reproduce].*
 
               LET g_eccb_d[li_reproduce_target].eccb003 = NULL
 
            END IF
            
            #add-point:modify段before insert
            SELECT MAX(eccb003) INTO g_eccb_d[l_ac].eccb003 FROM eccb_t
             WHERE eccbent = g_enterprise
               AND eccbsite = g_site
               AND eccbdocno = g_ecca_m.eccadocno
               AND eccb901 != '4'
            CALL cl_get_para(g_enterprise,g_site,'E-MFG-0001') RETURNING l_sys
            IF cl_null(l_sys) OR l_sys = 0 THEN LET l_sys = 1 END IF 
            IF cl_null(g_eccb_d[l_ac].eccb003) THEN
               LET g_eccb_d[l_ac].eccb003 = l_sys
               LET g_eccb_d[l_ac].eccb008 = 'INIT'
               LET g_eccb_d[l_ac].eccb009 ='0'
            ELSE           
               SELECT eccb004,eccb005 INTO g_eccb_d[l_ac].eccb008,g_eccb_d[l_ac].eccb009 FROM eccb_t
                WHERE eccbent = g_enterprise
                  AND eccbsite = g_site
                  AND eccbdocno = g_ecca_m.eccadocno
                  AND eccb003 = g_eccb_d[l_ac].eccb003
               LET g_eccb_d[l_ac].eccb003 = g_eccb_d[l_ac].eccb003 + l_sys
            END IF
            #end
            
            SELECT imae016 INTO g_eccb_d[l_ac].eccb021
              FROM imae_t
             WHERE imaeent = g_enterprise
               AND imaesite = g_site
               AND imae001 = g_ecca_m.ecca001

            IF cl_null(g_eccb_d[l_ac].eccb021) THEN
               SELECT imaa006 INTO g_eccb_d[l_ac].eccb021 FROM imaa_t
                WHERE imaaent = g_enterprise AND imaa001 = g_ecca_m.ecca001
            END IF

            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_eccb_d[l_ac].eccb021
            CALL ap_ref_array2(g_ref_fields,"SELECT oocal003 FROM oocal_t WHERE oocalent='"||g_enterprise||"' AND oocal001=? AND oocal002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_eccb_d[l_ac].eccb021_desc = '', g_rtn_fields[1] , ''
            
            LET g_eccb_d[l_ac].eccb030 = g_eccb_d[l_ac].eccb021
            LET g_eccb_d[l_ac].eccb030_desc = g_eccb_d[l_ac].eccb021_desc

            CALL g_eccb2_d.clear()
            CALL g_eccb3_d.clear()
            #end add-point  
  
         AFTER INSERT
            LET l_insert = FALSE
            IF INT_FLAG THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code   = 9001 
               LET g_errparam.popup  = FALSE 
               CALL cl_err()
               LET INT_FLAG = 0
               CANCEL INSERT
            END IF
               
            #add-point:單身新增
            IF s_transaction_chk("N",0) THEN
               CALL s_transaction_begin()
            END IF
            #end add-point
               
            LET l_count = 1  
            SELECT COUNT(*) INTO l_count FROM eccb_t 
             WHERE eccbent = g_enterprise AND eccbsite = g_ecca_m.eccasite
               AND eccbdocno = g_ecca_m.eccadocno
 
               AND eccb003 = g_eccb_d[l_ac].eccb003
 
                
            #資料未重複, 插入新增資料
            IF l_count = 0 THEN 
               #add-point:單身新增前
               
               #end add-point
            
               #同步新增到同層的table
                              INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_ecca_m.eccasite
               LET gs_keys[2] = g_ecca_m.eccadocno
               LET gs_keys[3] = g_eccb_d[g_detail_idx].eccb003
               CALL aect801_insert_b('eccb_t',gs_keys,"'1'")
                           
               #add-point:單身新增後
               
               #end add-point
            ELSE    
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = 'INSERT' 
               LET g_errparam.code   = "std-00006" 
               LET g_errparam.popup  = TRUE 
               CALL cl_err()
 
               INITIALIZE g_eccb_d[l_ac].* TO NULL
               CALL s_transaction_end('N','0')
               CANCEL INSERT
            END IF
 
            IF SQLCA.SQLcode  THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "eccb_t" 
               LET g_errparam.code   = SQLCA.sqlcode 
               LET g_errparam.popup  = TRUE 
               CALL cl_err()
 
               CALL s_transaction_end('N','0')                    
               CANCEL INSERT
            ELSE
               #先刷新資料
               #CALL aect801_b_fill()
               #資料多語言用-增/改
               
               #add-point:input段-after_insert
               IF cl_null(g_ecca_m.ecca900) THEN
                  LET l_ecca900 = ''
               ELSE
                  LET l_ecca900 = g_ecca_m.ecca900
               END IF                  
               LET l_sql = " MERGE INTO eccf_t ",
                           " USING (SELECT ecab001,ecabseq,ecab002,ecab003,ecab004,ecab005,ecab006,ecab007,ecab008",
                           "          FROM ecab_t ",
                           "         WHERE ecabent = '",g_enterprise,"' AND ecab001 = '",g_eccb_d[l_ac].eccb004,"') ",
                           "    ON (ecab002 = eccf004 AND ecab003 = eccf005 AND eccfdocno = '",g_ecca_m.eccadocno,"'",
                           "        AND eccfent = '",g_enterprise,"' AND eccfsite = '",g_site,"'",
                           "        AND eccf003 = '",g_eccb_d[l_ac].eccb003,"')",
                           "  WHEN NOT MATCHED THEN ",
                           "INSERT(eccfent,eccfsite,eccfdocno,eccf001,eccf002,eccf003,eccfseq,eccf004,eccf005,eccf006,eccf007,eccf008,eccf009,eccf010,eccf900,eccf901,eccf905,eccf906) ",
                           "VALUES('",g_enterprise,"','",g_site,"','",g_ecca_m.eccadocno,"','",g_ecca_m.ecca001,"','",g_ecca_m.ecca002,"','",g_eccb_d[l_ac].eccb003,"',ecabseq,ecab002,ecab003,ecab004,ecab005,ecab006,ecab007,ecab008,'",l_ecca900,"','",g_eccb_d[l_ac].eccb901,"','",g_eccb_d[l_ac].eccb905,"','",g_eccb_d[l_ac].eccb906,"')"
               PREPARE aect801_ins_eccf_pre FROM l_sql
               EXECUTE aect801_ins_eccf_pre
               IF SQLCA.sqlcode THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = SQLCA.sqlcode
                  LET g_errparam.extend = "ins_eccf_t"
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
 
                  CALL s_transaction_end('N','0')
               END IF            
               IF g_eccb_d[l_ac].eccb008 <> 'M
               
               ULT' THEN
                  LET l_n1 = 0
                  SELECT COUNT(*) INTO l_n1
                    FROM ecce_t
                   WHERE ecceent = g_enterprise
                     AND eccesite = g_site
                     AND eccedocno = g_ecca_m.eccadocno
                     AND ecce003 = g_eccb_d[l_ac].eccb003
                     AND ecce004 = g_eccb_d[l_ac].eccb008
                     AND ecce005 = g_eccb_d[l_ac].eccb009
                  SELECT MAX(ecceseq) +1 INTO l_ecceseq
                    FROM ecce_t
                   WHERE ecceent = g_enterprise
                     AND eccesite = g_site
                     AND eccedocno = g_ecca_m.eccadocno
                     AND ecce003 = g_eccb_d[l_ac].eccb003
                  IF cl_null(l_ecceseq) THEN
                     LET l_ecceseq = 1
                  END IF
                  IF l_n1 = 0 THEN
                     INSERT INTO ecce_t(ecceent,eccesite,eccedocno,ecce001,ecce002,ecce003,ecceseq,ecce004,ecce005,ecce900,ecce901,ecce905,ecce906)
                                 VALUES(g_enterprise,g_site,g_ecca_m.eccadocno,g_ecca_m.ecca001,g_ecca_m.ecca002,g_eccb_d[l_ac].eccb003,l_ecceseq,g_eccb_d[l_ac].eccb008,g_eccb_d[l_ac].eccb009,g_ecca_m.ecca900,g_eccb_d[l_ac].eccb901,g_eccb_d[l_ac].eccb905,g_eccb_d[l_ac].eccb906)
                     IF SQLCA.sqlcode THEN
                        INITIALIZE g_errparam TO NULL
                        LET g_errparam.code = SQLCA.sqlcode
                        LET g_errparam.extend = "ins_ecce_t"
                        LET g_errparam.popup = TRUE
                        CALL cl_err()
 
                        CALL s_transaction_end('N','0')
                     END IF
                  END IF
               END IF 

               IF NOT cl_null(g_eccb_d[l_ac].ooff013) THEN
                  CALL s_aooi360_gen('7',g_site,g_ecca_m.eccadocno,g_eccb_d[l_ac].eccb003,' ',' ',' ',' ',' ',' ',' ','4',g_eccb_d[l_ac].ooff013)
                     RETURNING l_success
               ELSE
                  CALL s_aooi360_del('7',g_site,g_ecca_m.eccadocno,g_eccb_d[l_ac].eccb003,' ',' ',' ',' ',' ',' ',' ','4')
                     RETURNING l_success
               END IF
               IF NOT l_success THEN
                  CALL s_transaction_end('N','0')
               END IF

               IF NOT aect801_return_eccb_mult() THEN
                  CALL s_transaction_end('N','0')
               END IF
               CALL aect801_show()
             # IF NOT aect801_upd_eccb_ecch(g_ecca_m.eccadocno,g_eccb_d[l_ac].eccb003) THEN
             #    INITIALIZE g_eccb_d[l_ac].* TO NULL
             #    CALL s_transaction_end('N','0')
             #    CANCEL INSERT
             # END IF
               #end add-point
               CALL s_transaction_end('Y','0')
               #ERROR 'INSERT O.K'
               LET g_rec_b = g_rec_b + 1
            END IF
              
         BEFORE DELETE                            #是否取消單身
            IF l_cmd = 'a' THEN
               LET l_cmd='d'
            ELSE
               IF NOT cl_ask_del_detail() THEN
                  CANCEL DELETE
               END IF
               IF l_lock_sw = "Y" THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "" 
                  LET g_errparam.code   = -263 
                  LET g_errparam.popup  = TRUE 
                  CALL cl_err()
 
                  CANCEL DELETE
               END IF
               
               #add-point:單身刪除前
               #变更类型是已删除的，则不可再次删除
               IF g_eccb_d[l_ac].eccb901 = '4' THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = g_eccb_d[l_ac].eccb003
                  LET g_errparam.code   = 'aec-00037' 
                  LET g_errparam.popup  = TRUE 
                  CALL cl_err() 
                  CANCEL DELETE
               END IF
               IF NOT aect801_return_ecbb(g_ecca_m.eccadocno,g_eccb_d[l_ac].eccb003) THEN
                  CALL s_transaction_end('N','0')
                  CANCEL DELETE
               END IF
               
               IF NOT aect801_eccb_delete(g_ecca_m.eccadocno,g_eccb_d[l_ac].eccb003) THEN
                  CALL s_transaction_end('N','0')
                  CANCEL DELETE
               END IF
               
               IF NOT aect801_return_eccb_mult() THEN
                  CALL s_transaction_end('N','0')
                  CANCEL DELETE
               END IF
               
               CALL s_transaction_end('Y','0')
               CALL aect801_b_fill()
               LET l_cmd = 'd'     #防止进入AFTER DELETE 继续删除单身资料
               IF 1 = 2 THEN
               #end add-point 
               
               DELETE FROM eccb_t
                WHERE eccbent = g_enterprise AND eccbsite = g_ecca_m.eccasite AND
                                          eccbdocno = g_ecca_m.eccadocno AND
 
                      eccb003 = g_eccb_d_t.eccb003
 
                  
               #add-point:單身刪除中
               
               #end add-point 
               
               IF SQLCA.sqlcode THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "eccb_t" 
                  LET g_errparam.code   = SQLCA.sqlcode 
                  LET g_errparam.popup  = TRUE 
                  CALL cl_err()
 
                  CALL s_transaction_end('N','0')
                  CANCEL DELETE   
               ELSE
                  LET g_rec_b = g_rec_b-1
                  
                  #add-point:單身刪除後
                  END IF                 
                  #end add-point
                  CALL s_transaction_end('Y','0')
               END IF 
               CLOSE aect801_bcl
               LET l_count = g_eccb_d.getLength()
                              INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_ecca_m.eccasite
               LET gs_keys[2] = g_ecca_m.eccadocno
               LET gs_keys[3] = g_eccb_d[g_detail_idx].eccb003
 
            END IF 
              
         AFTER DELETE 
            IF l_cmd <> 'd' THEN
               #add-point:單身刪除後2
               
               #end add-point
                              CALL aect801_delete_b('eccb_t',gs_keys,"'1'")
            END IF
            #如果是最後一筆
            IF l_ac = (g_eccb_d.getLength() + 1) THEN
               CALL FGL_SET_ARR_CURR(l_ac-1)
            END IF
 
                  #此段落由子樣板a01產生
         BEFORE FIELD eccb003
            #add-point:BEFORE FIELD eccb003
            
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD eccb003
            
            #add-point:AFTER FIELD eccb003
            #此段落由子樣板a05產生
            IF NOT cl_ap_chk_Range(g_eccb_d[l_ac].eccb003,"0","0","","","azz-00079",1) THEN
               LET g_eccb_d[l_ac].eccb003 = g_eccb_d_t.eccb003
               NEXT FIELD eccb003
            END IF
            IF  g_ecca_m.eccasite IS NOT NULL AND g_ecca_m.eccadocno IS NOT NULL AND g_eccb_d[g_detail_idx].eccb003 IS NOT NULL THEN 
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_ecca_m.eccasite != g_eccasite_t OR g_ecca_m.eccadocno != g_eccadocno_t OR g_eccb_d[g_detail_idx].eccb003 != g_eccb_d_t.eccb003)) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM eccb_t WHERE "||"eccbent = '" ||g_enterprise|| "' AND "||"eccbsite = '"||g_ecca_m.eccasite ||"' AND "|| "eccbdocno = '"||g_ecca_m.eccadocno ||"' AND "|| "eccb003 = '"||g_eccb_d[g_detail_idx].eccb003 ||"'",'std-00004',0) THEN 
                     LET g_eccb_d[l_ac].eccb003 = g_eccb_d_t.eccb003
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF


            #END add-point
            
 
         #此段落由子樣板a04產生
         ON CHANGE eccb003
            #add-point:ON CHANGE eccb003
            
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD eccb004
            
            #add-point:AFTER FIELD eccb004
            CALL aect801_eccb_desc()
            IF NOT cl_null(g_eccb_d[l_ac].eccb004) THEN
               CALL s_azzi650_chk_exist('221',g_eccb_d[l_ac].eccb004) RETURNING l_success
               IF NOT l_success THEN
                 #LET g_eccb_d[l_ac].eccb004 = g_eccb_d_t.eccb004   #160824-00007#227 by sakura mark
                  LET g_eccb_d[l_ac].eccb004 = g_eccb_d_o.eccb004   #160824-00007#227 by sakura add
                  CALL aect801_eccb_desc()
                  NEXT FIELD eccb004
               END IF
              #IF l_cmd = 'a' OR (l_cmd = 'u' AND g_eccb_d[l_ac].eccb004<>　g_eccb_d_t.eccb004) THEN   #160824-00007#227 by sakura mark
               IF g_eccb_d[l_ac].eccb004 <> g_eccb_d_o.eccb004 OR cl_null(g_eccb_d_o.eccb004) THEN     #160824-00007#227 by sakura add
                  CALL aect801_def_eccb005()
                  IF NOT cl_null(g_eccb_d[l_ac].eccb005) THEN
                     CALL aect801_chk_eccb004(l_cmd)
                     IF NOT cl_null(g_errno) THEN
                        INITIALIZE g_errparam TO NULL
                        LET g_errparam.code = g_errno
                        LET g_errparam.extend = g_eccb_d[l_ac].eccb004
                        LET g_errparam.popup = TRUE
                        CALL cl_err()

                       #LET g_eccb_d[l_ac].eccb004 = g_eccb_d_t.eccb004   #160824-00007#227 by sakura mark
                        LET g_eccb_d[l_ac].eccb004 = g_eccb_d_o.eccb004   #160824-00007#227 by sakura add
                        CALL aect801_eccb_desc()
                        NEXT FIELD eccb004
                     END IF
                  END IF
               END IF
            END IF
            LET g_eccb_d_o.* = g_eccb_d[l_ac].*   #160824-00007#227 by sakura add
            #END add-point
            
 
         #此段落由子樣板a01產生
         BEFORE FIELD eccb004
            #add-point:BEFORE FIELD eccb004
            
            #END add-point
 
         #此段落由子樣板a04產生
         ON CHANGE eccb004
            #add-point:ON CHANGE eccb004
            
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD eccb005
            #此段落由子樣板a15產生
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_eccb_d[l_ac].eccb005,"0","1","","","azz-00079",1) THEN
               NEXT FIELD eccb005
            END IF
 
 
            #add-point:AFTER FIELD eccb005
            IF NOT cl_null(g_eccb_d[l_ac].eccb005) THEN 
               IF l_cmd = 'a' OR (l_cmd = 'u' AND g_eccb_d[l_ac].eccb005<>　g_eccb_d_t.eccb005) THEN
                  IF NOT cl_null(g_eccb_d[l_ac].eccb004) THEN
                     CALL aect801_chk_eccb004(l_cmd)
                     IF NOT cl_null(g_errno) THEN
                        INITIALIZE g_errparam TO NULL
                        LET g_errparam.code = g_errno
                        LET g_errparam.extend = g_eccb_d[l_ac].eccb005
                        LET g_errparam.popup = TRUE
                        CALL cl_err()

                        LET g_eccb_d[l_ac].eccb005 = g_eccb_d_t.eccb005
                        NEXT FIELD eccb005
                     END IF
                  END IF
               END IF
            END IF 
            #END add-point
            
 
         #此段落由子樣板a01產生
         BEFORE FIELD eccb005
            #add-point:BEFORE FIELD eccb005
            
            #END add-point
 
         #此段落由子樣板a04產生
         ON CHANGE eccb005
            #add-point:ON CHANGE eccb005
            
            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD eccb006
            #add-point:BEFORE FIELD eccb006
            
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD eccb006
            
            #add-point:AFTER FIELD eccb006
            IF NOT cl_null(g_eccb_d[l_ac].eccb007) THEN
               IF NOT cl_null(g_eccb_d[l_ac].eccb006) THEN
                  LET l_n1 = 0
                  SELECT COUNT(*) INTO l_n1
                    FROM eccb_t
                   WHERE eccbent = g_enterprise
                     AND eccbsite = g_site
                     AND eccbdocno = g_ecca_m.eccadocno
                     AND eccb003 <> g_eccb_d[l_ac].eccb003
                     AND eccb006 <>'1'
                     AND eccb006 <> g_eccb_d[l_ac].eccb006
                     AND eccb007 = g_eccb_d[l_ac].eccb007
                  IF l_n1 > 0 THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = 'aec-00026'
                     LET g_errparam.extend = g_eccb_d[l_ac].eccb006
                     LET g_errparam.popup = TRUE
                     CALL cl_err()

                     LET g_eccb_d[l_ac].eccb006 = g_eccb_d_t.eccb006
                     NEXT FIELD eccb006
                  END IF
               END IF
            END IF
            CALL aect801_set_entry_b(l_cmd)
            CALL aect801_set_no_entry_b(l_cmd)
            #END add-point
            
 
         #此段落由子樣板a04產生
         ON CHANGE eccb006
            #add-point:ON CHANGE eccb006
            
            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD eccb007
            #add-point:BEFORE FIELD eccb007
            CALL aect801_set_entry_b(l_cmd)
            CALL aect801_set_no_entry_b(l_cmd)
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD eccb007
            
            #add-point:AFTER FIELD eccb007
            IF NOT cl_null(g_eccb_d[l_ac].eccb007) THEN
               IF NOT cl_null(g_eccb_d[l_ac].eccb006) THEN
                  LET l_n1 = 0
                  SELECT COUNT(*) INTO l_n1
                    FROM eccb_t
                   WHERE eccbent = g_enterprise
                     AND eccbsite = g_site
                     AND eccbdocno = g_ecca_m.eccadocno
                     AND eccb003 <> g_eccb_d[l_ac].eccb003
                     AND eccb006 <>'1'
                     AND eccb006 <> g_eccb_d[l_ac].eccb006
                     AND eccb007 = g_eccb_d[l_ac].eccb007
                  IF l_n1 > 0 THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = 'aec-00026'
                     LET g_errparam.extend = g_eccb_d[l_ac].eccb007
                     LET g_errparam.popup = TRUE
                     CALL cl_err()

                     LET g_eccb_d[l_ac].eccb007 = g_eccb_d_t.eccb007
                     NEXT FIELD eccb007
                  END IF
               END IF
            END IF
            #END add-point
            
 
         #此段落由子樣板a04產生
         ON CHANGE eccb007
            #add-point:ON CHANGE eccb007
            
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD eccb008
            
            #add-point:AFTER FIELD eccb008
            CALL aect801_eccb_desc()
            IF NOT cl_null(g_eccb_d[l_ac].eccb008) THEN
               IF NOT cl_null(g_eccb_d[l_ac].eccb009) THEN
                  CALL aect801_chk_eccb008(l_cmd)
                  IF NOT cl_null(g_errno) THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = g_errno
                     LET g_errparam.extend = g_eccb_d[l_ac].eccb008
                     LET g_errparam.popup = TRUE
                     CALL cl_err()

                     LET g_eccb_d[l_ac].eccb008 = g_eccb_d_t.eccb008
                     CALL aect801_eccb_desc()
                     NEXT FIELD eccb008
                  END IF
               END IF
               IF NOT cl_null(g_eccb_d[l_ac].eccb004) AND NOT cl_null(g_eccb_d[l_ac].eccb005) AND NOT cl_null(g_eccb_d[l_ac].eccb008) AND NOT cl_null(g_eccb_d[l_ac].eccb009) THEN
                  IF g_eccb_d[l_ac].eccb008 = g_eccb_d[l_ac].eccb004 AND g_eccb_d[l_ac].eccb009 = g_eccb_d[l_ac].eccb005 THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = 'aec-00008'
                     LET g_errparam.extend = g_eccb_d[l_ac].eccb008
                     LET g_errparam.popup = TRUE
                     CALL cl_err()

                     LET g_eccb_d[l_ac].eccb008 = g_eccb_d_t.eccb008
                     CALL aect801_eccb_desc()
                     NEXT FIELD eccb008
                  END IF
               END IF
               IF NOT cl_null(g_eccb_d[l_ac].eccb003) AND NOT cl_null(g_eccb_d[l_ac].eccb004) AND NOT cl_null(g_eccb_d[l_ac].eccb005) AND g_eccb_d[l_ac].eccb008 = 'MULT' THEN
                  SELECT COUNT(*) INTO l_n4 FROM ecce_t 
                   WHERE ecceent = g_enterprise AND eccesite = g_site 
                     AND eccedocno = g_ecca_m.eccadocno
                     AND ecce003 = g_eccb_d[l_ac].eccb003
                  IF l_n4 <= 1 THEN
                     CALL aect801_01(g_ecca_m.eccadocno,g_eccb_d[l_ac].eccb003,g_eccb_d[l_ac].eccb004,g_eccb_d[l_ac].eccb005,'Y')
                     SELECT COUNT(*) INTO l_n4 FROM ecce_t 
                      WHERE ecceent = g_enterprise AND eccesite = g_site 
                        AND eccedocno = g_ecca_m.eccadocno
                        AND ecce003 = g_eccb_d[l_ac].eccb003
                     IF l_n4 = 0 THEN 
                        LET g_eccb_d[l_ac].eccb008 = ''
                        LET g_eccb_d[l_ac].eccb008_desc = ''
                        LET g_eccb_d[l_ac].eccb009 = ''
                     END IF
                     IF l_n4 = 1 THEN
                        SELECT ecce004,ecce005 INTO g_eccb_d[l_ac].eccb008,g_eccb_d[l_ac].eccb009 FROM ecce_t
                         WHERE ecceent = g_enterprise AND eccesite = g_site 
                           AND eccedocno = g_ecca_m.eccadocno
                           AND ecce003 = g_eccb_d[l_ac].eccb003
                        CALL aect801_eccb_desc()
                     END IF
                     IF l_n4 > 1 THEN
                        LET g_eccb_d[l_ac].eccb008 = 'MULT'
                        LET g_eccb_d[l_ac].eccb008_desc = ''
                        LET g_eccb_d[l_ac].eccb009 = '0'
                     END IF
                  END IF
               END IF
            END IF
            CALL aect801_set_entry_b(l_cmd)
            CALL aect801_set_no_entry_b(l_cmd)

            #END add-point
            
 
         #此段落由子樣板a01產生
         BEFORE FIELD eccb008
            #add-point:BEFORE FIELD eccb008
            
            #END add-point
 
         #此段落由子樣板a04產生
         ON CHANGE eccb008
            #add-point:ON CHANGE eccb008
            
            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD eccb009
            #add-point:BEFORE FIELD eccb009
            
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD eccb009
            
            #add-point:AFTER FIELD eccb009
            IF NOT cl_null(g_eccb_d[l_ac].eccb009) THEN
               IF NOT cl_null(g_eccb_d[l_ac].eccb008) THEN
                  CALL aect801_chk_eccb008(l_cmd)
                  IF NOT cl_null(g_errno) THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = g_errno
                     LET g_errparam.extend = g_eccb_d[l_ac].eccb009
                     LET g_errparam.popup = TRUE
                     CALL cl_err()

                     LET g_eccb_d[l_ac].eccb009 = g_eccb_d_t.eccb009
                     NEXT FIELD eccb009
                  END IF
               END IF
               IF NOT cl_null(g_eccb_d[l_ac].eccb004) AND NOT cl_null(g_eccb_d[l_ac].eccb005) AND NOT cl_null(g_eccb_d[l_ac].eccb008) AND NOT cl_null(g_eccb_d[l_ac].eccb009) THEN
                  IF g_eccb_d[l_ac].eccb008 = g_eccb_d[l_ac].eccb004 AND g_eccb_d[l_ac].eccb009 = g_eccb_d[l_ac].eccb005 THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = 'aec-00008'
                     LET g_errparam.extend = g_eccb_d[l_ac].eccb008
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                     LET g_eccb_d[l_ac].eccb009 = g_eccb_d_t.eccb009
                     NEXT FIELD eccb009
                  END IF
               END IF
            END IF
            #END add-point
            
 
         #此段落由子樣板a04產生
         ON CHANGE eccb009
            #add-point:ON CHANGE eccb009
            
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD eccb010
            
            #add-point:AFTER FIELD eccb010
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_eccb_d[l_ac].eccb010
            CALL ap_ref_array2(g_ref_fields,"SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001='221' AND oocql002=? AND oocql003='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_eccb_d[l_ac].eccb010_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_eccb_d[l_ac].eccb010_desc


            #END add-point
            
 
         #此段落由子樣板a01產生
         BEFORE FIELD eccb010
            #add-point:BEFORE FIELD eccb010
            
            #END add-point
 
         #此段落由子樣板a04產生
         ON CHANGE eccb010
            #add-point:ON CHANGE eccb010
            
            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD eccb011
            #add-point:BEFORE FIELD eccb011
            
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD eccb011
            
            #add-point:AFTER FIELD eccb011
            
            #END add-point
            
 
         #此段落由子樣板a04產生
         ON CHANGE eccb011
            #add-point:ON CHANGE eccb011
            
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD eccb012
            
            #add-point:AFTER FIELD eccb012
            CALL aect801_eccb_desc()
            IF NOT cl_null(g_eccb_d[l_ac].eccb012) THEN
               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
               INITIALIZE g_chkparam.* TO NULL

               #設定g_chkparam.*的參數
               LET g_chkparam.arg1 = g_eccb_d[l_ac].eccb012
               #160318-00025#3--add--str
               LET g_errshow = TRUE 
               LET g_chkparam.err_str[1] = "aec-00010:sub-01302|aeci001|",cl_get_progname("aeci001",g_lang,"2"),"|:EXEPROGaeci001"
               #160318-00025#3--add--end
               #呼叫檢查存在並帶值的library
               IF NOT cl_chk_exist("v_ecaa001_1") THEN
                  LET g_eccb_d[l_ac].eccb012 = g_eccb_d_t.eccb012
                  CALL aect801_eccb_desc()
                  NEXT FIELD eccb012
               END IF               
            END IF


            #END add-point
            
 
         #此段落由子樣板a01產生
         BEFORE FIELD eccb012
            #add-point:BEFORE FIELD eccb012
            
            #END add-point
 
         #此段落由子樣板a04產生
         ON CHANGE eccb012
            #add-point:ON CHANGE eccb012
            
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD eccb024
            #此段落由子樣板a15產生
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_eccb_d[l_ac].eccb024,"0.000","1","","","azz-00079",1) THEN
               NEXT FIELD eccb024
            END IF
 
 
            #add-point:AFTER FIELD eccb024
            IF NOT cl_null(g_eccb_d[l_ac].eccb024) THEN 
            END IF 


            #END add-point
            
 
         #此段落由子樣板a01產生
         BEFORE FIELD eccb024
            #add-point:BEFORE FIELD eccb024
            
            #END add-point
 
         #此段落由子樣板a04產生
         ON CHANGE eccb024
            #add-point:ON CHANGE eccb024
            
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD eccb025
            #此段落由子樣板a15產生
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_eccb_d[l_ac].eccb025,"0.000","1","","","azz-00079",1) THEN
               NEXT FIELD eccb025
            END IF
 
 
            #add-point:AFTER FIELD eccb025
            IF NOT cl_null(g_eccb_d[l_ac].eccb025) THEN 
            END IF 


            #END add-point
            
 
         #此段落由子樣板a01產生
         BEFORE FIELD eccb025
            #add-point:BEFORE FIELD eccb025
            
            #END add-point
 
         #此段落由子樣板a04產生
         ON CHANGE eccb025
            #add-point:ON CHANGE eccb025
            
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD eccb026
            #此段落由子樣板a15產生
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_eccb_d[l_ac].eccb026,"0.000","1","","","azz-00079",1) THEN
               NEXT FIELD eccb026
            END IF
 
 
            #add-point:AFTER FIELD eccb026
            IF NOT cl_null(g_eccb_d[l_ac].eccb026) THEN 
            END IF 


            #END add-point
            
 
         #此段落由子樣板a01產生
         BEFORE FIELD eccb026
            #add-point:BEFORE FIELD eccb026
            
            #END add-point
 
         #此段落由子樣板a04產生
         ON CHANGE eccb026
            #add-point:ON CHANGE eccb026
            
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD eccb027
            #此段落由子樣板a15產生
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_eccb_d[l_ac].eccb027,"0.000","1","","","azz-00079",1) THEN
               NEXT FIELD eccb027
            END IF
 
 
            #add-point:AFTER FIELD eccb027
            IF NOT cl_null(g_eccb_d[l_ac].eccb027) THEN 
            END IF 


            #END add-point
            
 
         #此段落由子樣板a01產生
         BEFORE FIELD eccb027
            #add-point:BEFORE FIELD eccb027
            
            #END add-point
 
         #此段落由子樣板a04產生
         ON CHANGE eccb027
            #add-point:ON CHANGE eccb027
            
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD eccb034
            #此段落由子樣板a15產生
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_eccb_d[l_ac].eccb034,"0","1","","","azz-00079",1) THEN
               NEXT FIELD eccb034
            END IF
 
 
            #add-point:AFTER FIELD eccb034
            IF NOT cl_null(g_eccb_d[l_ac].eccb034) THEN 
            END IF 


            #END add-point
            
 
         #此段落由子樣板a01產生
         BEFORE FIELD eccb034
            #add-point:BEFORE FIELD eccb034
            
            #END add-point
 
         #此段落由子樣板a04產生
         ON CHANGE eccb034
            #add-point:ON CHANGE eccb034
            
            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD eccb013
            #add-point:BEFORE FIELD eccb013
            
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD eccb013
            
            #add-point:AFTER FIELD eccb013
            
            #END add-point
            
 
         #此段落由子樣板a04產生
         ON CHANGE eccb013
            #add-point:ON CHANGE eccb013
            
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD eccb014
            
            #add-point:AFTER FIELD eccb014
            CALL aect801_eccb_desc()
            IF NOT cl_null(g_eccb_d[l_ac].eccb014) THEN
               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
               INITIALIZE g_chkparam.* TO NULL

               #設定g_chkparam.*的參數
               LET g_chkparam.arg1 = g_eccb_d[l_ac].eccb014

               #呼叫檢查存在並帶值的library
               IF NOT cl_chk_exist("v_pmaa001_1") THEN
                  LET g_eccb_d[l_ac].eccb014 = g_eccb_d_t.eccb014
                  CALL aect801_eccb_desc()
                  NEXT FIELD eccb014
               END IF
               
            END IF
            
            #END add-point
            
 
         #此段落由子樣板a01產生
         BEFORE FIELD eccb014
            #add-point:BEFORE FIELD eccb014
            
            #END add-point
 
         #此段落由子樣板a04產生
         ON CHANGE eccb014
            #add-point:ON CHANGE eccb014
            
            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD eccb015
            #add-point:BEFORE FIELD eccb015
            
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD eccb015
            
            #add-point:AFTER FIELD eccb015
            
            #END add-point
            
 
         #此段落由子樣板a04產生
         ON CHANGE eccb015
            #add-point:ON CHANGE eccb015
            
            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD eccb016
            #add-point:BEFORE FIELD eccb016
            
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD eccb016
            
            #add-point:AFTER FIELD eccb016
            
            #END add-point
            
 
         #此段落由子樣板a04產生
         ON CHANGE eccb016
            #add-point:ON CHANGE eccb016
            
            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD eccb017
            #add-point:BEFORE FIELD eccb017
            
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD eccb017
            
            #add-point:AFTER FIELD eccb017
            
            #END add-point
            
 
         #此段落由子樣板a04產生
         ON CHANGE eccb017
            #add-point:ON CHANGE eccb017
            
            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD eccb018
            #add-point:BEFORE FIELD eccb018
            
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD eccb018
            
            #add-point:AFTER FIELD eccb018
            
            #END add-point
            
 
         #此段落由子樣板a04產生
         ON CHANGE eccb018
            #add-point:ON CHANGE eccb018
            
            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD eccb019
            #add-point:BEFORE FIELD eccb019
            
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD eccb019
            
            #add-point:AFTER FIELD eccb019
            
            #END add-point
            
 
         #此段落由子樣板a04產生
         ON CHANGE eccb019
            #add-point:ON CHANGE eccb019
            
            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD eccb020
            #add-point:BEFORE FIELD eccb020
            
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD eccb020
            
            #add-point:AFTER FIELD eccb020
            
            #END add-point
            
 
         #此段落由子樣板a04產生
         ON CHANGE eccb020
            #add-point:ON CHANGE eccb020
            
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD eccb030
            
            #add-point:AFTER FIELD eccb030
            CALL aect801_eccb_desc()
            IF NOT cl_null(g_eccb_d[l_ac].eccb030) THEN 
#此段落由子樣板a19產生
               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
               INITIALIZE g_chkparam.* TO NULL
               
               #設定g_chkparam.*的參數
               LET g_chkparam.arg1 = g_eccb_d[l_ac].eccb030
               #160318-00025#3--add--str
               LET g_errshow = TRUE 
               LET g_chkparam.err_str[1] = "aim-00005:sub-01302|aooi250|",cl_get_progname("aooi250",g_lang,"2"),"|:EXEPROGaooi250"
               #160318-00025#3--add--end
                  
               #呼叫檢查存在並帶值的library
               IF NOT cl_chk_exist("v_ooca001") THEN
                  LET g_eccb_d[l_ac].eccb030 = g_eccb_d_t.eccb030
                  CALL aect801_eccb_desc()
                  NEXT FIELD eccb030
               END IF
            END IF
            
            #END add-point
            
 
         #此段落由子樣板a01產生
         BEFORE FIELD eccb030
            #add-point:BEFORE FIELD eccb030
            
            #END add-point
 
         #此段落由子樣板a04產生
         ON CHANGE eccb030
            #add-point:ON CHANGE eccb030
            
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD eccb031
            #此段落由子樣板a15產生
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_eccb_d[l_ac].eccb031,"0","1","","","azz-00079",1) THEN
               NEXT FIELD eccb031
            END IF
 
 
            #add-point:AFTER FIELD eccb031
            IF NOT cl_null(g_eccb_d[l_ac].eccb031) THEN 
            END IF 


            #END add-point
            
 
         #此段落由子樣板a01產生
         BEFORE FIELD eccb031
            #add-point:BEFORE FIELD eccb031
            
            #END add-point
 
         #此段落由子樣板a04產生
         ON CHANGE eccb031
            #add-point:ON CHANGE eccb031
            
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD eccb032
            #此段落由子樣板a15產生
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_eccb_d[l_ac].eccb032,"0","0","","","azz-00079",1) THEN
               NEXT FIELD eccb032
            END IF
 
 
            #add-point:AFTER FIELD eccb032
            IF NOT cl_null(g_eccb_d[l_ac].eccb032) THEN 
            END IF 


            #END add-point
            
 
         #此段落由子樣板a01產生
         BEFORE FIELD eccb032
            #add-point:BEFORE FIELD eccb032
            
            #END add-point
 
         #此段落由子樣板a04產生
         ON CHANGE eccb032
            #add-point:ON CHANGE eccb032
            
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD eccb021
            
            #add-point:AFTER FIELD eccb021
            CALL aect801_eccb_desc()
            IF NOT cl_null(g_eccb_d[l_ac].eccb021) THEN 
#此段落由子樣板a19產生
               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
               INITIALIZE g_chkparam.* TO NULL
               
               #設定g_chkparam.*的參數
               LET g_chkparam.arg1 = g_eccb_d[l_ac].eccb021
               #160318-00025#3--add--str
               LET g_errshow = TRUE 
               LET g_chkparam.err_str[1] = "aim-00005:sub-01302|aooi250|",cl_get_progname("aooi250",g_lang,"2"),"|:EXEPROGaooi250"
               #160318-00025#3--add--end
                  
               #呼叫檢查存在並帶值的library
               IF NOT cl_chk_exist("v_ooca001") THEN
                  LET g_eccb_d[l_ac].eccb021 = g_eccb_d_t.eccb021
                  CALL aect801_eccb_desc()
                  NEXT FIELD eccb021
               END IF
            END IF
            #END add-point
            
 
         #此段落由子樣板a01產生
         BEFORE FIELD eccb021
            #add-point:BEFORE FIELD eccb021
            
            #END add-point
 
         #此段落由子樣板a04產生
         ON CHANGE eccb021
            #add-point:ON CHANGE eccb021
            
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD eccb022
            #此段落由子樣板a15產生
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_eccb_d[l_ac].eccb022,"0","1","","","azz-00079",1) THEN
               NEXT FIELD eccb022
            END IF
 
 
            #add-point:AFTER FIELD eccb022
            IF NOT cl_null(g_eccb_d[l_ac].eccb022) THEN 
            END IF 


            #END add-point
            
 
         #此段落由子樣板a01產生
         BEFORE FIELD eccb022
            #add-point:BEFORE FIELD eccb022
            
            #END add-point
 
         #此段落由子樣板a04產生
         ON CHANGE eccb022
            #add-point:ON CHANGE eccb022
            
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD eccb023
            #此段落由子樣板a15產生
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_eccb_d[l_ac].eccb023,"0","0","","","azz-00079",1) THEN
               NEXT FIELD eccb023
            END IF
 
 
            #add-point:AFTER FIELD eccb023
            IF NOT cl_null(g_eccb_d[l_ac].eccb023) THEN 
            END IF 


            #END add-point
            
 
         #此段落由子樣板a01產生
         BEFORE FIELD eccb023
            #add-point:BEFORE FIELD eccb023
            
            #END add-point
 
         #此段落由子樣板a04產生
         ON CHANGE eccb023
            #add-point:ON CHANGE eccb023
            
            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD eccb033
            #add-point:BEFORE FIELD eccb033
            
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD eccb033
            
            #add-point:AFTER FIELD eccb033
            IF g_eccb_d[l_ac].eccb033 = 'Y' THEN
               IF l_cmd = 'a' OR (l_cmd = 'u' AND g_eccb_d[l_ac].eccb033<>　g_eccb_d_t.eccb033) THEN
                  LET l_n1 = 0 
                  SELECT COUNT(*) INTO l_n1
                    FROM eccb_t
                   WHERE eccbent = g_enterprise
                     AND eccbsite = g_site
                     AND eccbdocno = g_ecca_m.eccadocno
                     AND eccb003 <> g_eccb_d[l_ac].eccb003
                     AND eccb033 = 'Y'
                  IF l_n1 > 0 THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = 'aec-00025'
                     LET g_errparam.extend = g_eccb_d[l_ac].eccb033
                     LET g_errparam.popup = TRUE
                     CALL cl_err()

                     LET g_eccb_d[l_ac].eccb033 = g_eccb_d_t.eccb033
                     NEXT FIELD eccb033
                  END IF
               END IF
            END IF
            #END add-point
            
 
         #此段落由子樣板a04產生
         ON CHANGE eccb033
            #add-point:ON CHANGE eccb033
            
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD eccb028
            #此段落由子樣板a15產生
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_eccb_d[l_ac].eccb028,"0","1","","","azz-00079",1) THEN
               NEXT FIELD eccb028
            END IF
 
 
            #add-point:AFTER FIELD eccb028
            IF NOT cl_null(g_eccb_d[l_ac].eccb028) THEN 
            END IF 


            #END add-point
            
 
         #此段落由子樣板a01產生
         BEFORE FIELD eccb028
            #add-point:BEFORE FIELD eccb028
            
            #END add-point
 
         #此段落由子樣板a04產生
         ON CHANGE eccb028
            #add-point:ON CHANGE eccb028
            
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD eccb029
            #此段落由子樣板a15產生
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_eccb_d[l_ac].eccb029,"0","1","","","azz-00079",1) THEN
               NEXT FIELD eccb029
            END IF
 
 
            #add-point:AFTER FIELD eccb029
            IF NOT cl_null(g_eccb_d[l_ac].eccb029) THEN 
            END IF 


            #END add-point
            
 
         #此段落由子樣板a01產生
         BEFORE FIELD eccb029
            #add-point:BEFORE FIELD eccb029
            
            #END add-point
 
         #此段落由子樣板a04產生
         ON CHANGE eccb029
            #add-point:ON CHANGE eccb029
            
            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD ooff013
            #add-point:BEFORE FIELD ooff013
            
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD ooff013
            
            #add-point:AFTER FIELD ooff013
            
            #END add-point
            
 
         #此段落由子樣板a04產生
         ON CHANGE ooff013
            #add-point:ON CHANGE ooff013
            
            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD eccb035
            #add-point:BEFORE FIELD eccb035
            
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD eccb035
            
            #add-point:AFTER FIELD eccb035
            
            #END add-point
            
 
         #此段落由子樣板a04產生
         ON CHANGE eccb035
            #add-point:ON CHANGE eccb035
            
            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD eccb036
            #add-point:BEFORE FIELD eccb036
            
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD eccb036
            
            #add-point:AFTER FIELD eccb036
            
            #END add-point
            
 
         #此段落由子樣板a04產生
         ON CHANGE eccb036
            #add-point:ON CHANGE eccb036
            
            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD eccb901
            #add-point:BEFORE FIELD eccb901
            
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD eccb901
            
            #add-point:AFTER FIELD eccb901
            
            #END add-point
            
 
         #此段落由子樣板a04產生
         ON CHANGE eccb901
            #add-point:ON CHANGE eccb901
            
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD eccb905
            
            #add-point:AFTER FIELD eccb905
            IF NOT cl_null(g_eccb_d[l_ac].eccb905) AND (cl_null(g_eccb_d_t.eccb905) OR g_eccb_d[l_ac].eccb905 != g_eccb_d_t.eccb905) THEN
               IF NOT aect801_ecca905_chk(g_eccb_d[l_ac].eccb905) THEN
                  LET g_eccb_d[l_ac].eccb905 = g_eccb_d_t.eccb905
                  CALL aect801_ecca905_desc(g_eccb_d[l_ac].eccb905) RETURNING g_eccb_d[l_ac].eccb905_desc
                  DISPLAY BY NAME g_eccb_d[l_ac].eccb905_desc
                  NEXT FIELD eccb905
               END IF
               CALL aect801_ecca905_desc(g_eccb_d[l_ac].eccb905) RETURNING g_eccb_d[l_ac].eccb905_desc
               DISPLAY BY NAME g_eccb_d[l_ac].eccb905_desc
            END IF
            #END add-point
            
 
         #此段落由子樣板a01產生
         BEFORE FIELD eccb905
            #add-point:BEFORE FIELD eccb905
            
            #END add-point
 
         #此段落由子樣板a04產生
         ON CHANGE eccb905
            #add-point:ON CHANGE eccb905
            
            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD eccb906
            #add-point:BEFORE FIELD eccb906
            
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD eccb906
            
            #add-point:AFTER FIELD eccb906
            
            #END add-point
            
 
         #此段落由子樣板a04產生
         ON CHANGE eccb906
            #add-point:ON CHANGE eccb906
            
            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD eccb001
            #add-point:BEFORE FIELD eccb001
            
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD eccb001
            
            #add-point:AFTER FIELD eccb001
            
            #END add-point
            
 
         #此段落由子樣板a04產生
         ON CHANGE eccb001
            #add-point:ON CHANGE eccb001
            
            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD eccb002
            #add-point:BEFORE FIELD eccb002
            
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD eccb002
            
            #add-point:AFTER FIELD eccb002
            
            #END add-point
            
 
         #此段落由子樣板a04產生
         ON CHANGE eccb002
            #add-point:ON CHANGE eccb002
            
            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD eccb900
            #add-point:BEFORE FIELD eccb900
            
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD eccb900
            
            #add-point:AFTER FIELD eccb900
            
            #END add-point
            
 
         #此段落由子樣板a04產生
         ON CHANGE eccb900
            #add-point:ON CHANGE eccb900
            
            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD eccb902
            #add-point:BEFORE FIELD eccb902
            
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD eccb902
            
            #add-point:AFTER FIELD eccb902
            
            #END add-point
            
 
         #此段落由子樣板a04產生
         ON CHANGE eccb902
            #add-point:ON CHANGE eccb902
            
            #END add-point
 
 
                  #Ctrlp:input.c.page1.eccb003
         ON ACTION controlp INFIELD eccb003
            #add-point:ON ACTION controlp INFIELD eccb003
            
            #END add-point
 
         #Ctrlp:input.c.page1.eccb004
         ON ACTION controlp INFIELD eccb004
            #add-point:ON ACTION controlp INFIELD eccb004
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_eccb_d[l_ac].eccb004             #給予default值
            #給予arg
            LET g_qryparam.arg1 = "221" #            
            CALL q_oocq002()                                #呼叫開窗
            LET g_eccb_d[l_ac].eccb004 = g_qryparam.return1               
            DISPLAY g_eccb_d[l_ac].eccb004 TO eccb004              #
            NEXT FIELD eccb004                          #返回原欄位


            #END add-point
 
         #Ctrlp:input.c.page1.eccb005
         ON ACTION controlp INFIELD eccb005
            #add-point:ON ACTION controlp INFIELD eccb005
            
            #END add-point
 
         #Ctrlp:input.c.page1.eccb006
         ON ACTION controlp INFIELD eccb006
            #add-point:ON ACTION controlp INFIELD eccb006
            
            #END add-point
 
         #Ctrlp:input.c.page1.eccb007
         ON ACTION controlp INFIELD eccb007
            #add-point:ON ACTION controlp INFIELD eccb007
            
            #END add-point
 
         #Ctrlp:input.c.page1.eccb008
         ON ACTION controlp INFIELD eccb008
            #add-point:ON ACTION controlp INFIELD eccb008
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_eccb_d[l_ac].eccb008             #給予default值

            #給予arg
            LET g_qryparam.where = " eccbdocno = '",g_ecca_m.eccadocno,"' "
            CALL q_eccb004()                                #呼叫開窗

            LET g_eccb_d[l_ac].eccb008 = g_qryparam.return1              #將開窗取得的值回傳到變數
            LET g_eccb_d[l_ac].eccb009 = g_qryparam.return2
            DISPLAY g_eccb_d[l_ac].eccb008 TO eccb008              #顯示到畫面上
            DISPLAY g_eccb_d[l_ac].eccb009 TO eccb009  
            CALL aect801_eccb_desc()
            LET g_qryparam.where = ""
            NEXT FIELD eccb008 

            #END add-point
 
         #Ctrlp:input.c.page1.eccb009
         ON ACTION controlp INFIELD eccb009
            #add-point:ON ACTION controlp INFIELD eccb009
            
            #END add-point
 
         #Ctrlp:input.c.page1.eccb010
         ON ACTION controlp INFIELD eccb010
            #add-point:ON ACTION controlp INFIELD eccb010
            
            #END add-point
 
         #Ctrlp:input.c.page1.eccb011
         ON ACTION controlp INFIELD eccb011
            #add-point:ON ACTION controlp INFIELD eccb011
            
            #END add-point
 
         #Ctrlp:input.c.page1.eccb012
         ON ACTION controlp INFIELD eccb012
            #add-point:ON ACTION controlp INFIELD eccb012
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_eccb_d[l_ac].eccb012             #給予default值

            #給予arg

            CALL q_ecaa001_1()                                #呼叫開窗

            LET g_eccb_d[l_ac].eccb012 = g_qryparam.return1              #將開窗取得的值回傳到變數

            DISPLAY g_eccb_d[l_ac].eccb012 TO eccb012              #顯示到畫面上
            CALL aect801_eccb_desc()
            NEXT FIELD eccb012 


            #END add-point
 
         #Ctrlp:input.c.page1.eccb024
         ON ACTION controlp INFIELD eccb024
            #add-point:ON ACTION controlp INFIELD eccb024
            
            #END add-point
 
         #Ctrlp:input.c.page1.eccb025
         ON ACTION controlp INFIELD eccb025
            #add-point:ON ACTION controlp INFIELD eccb025
            
            #END add-point
 
         #Ctrlp:input.c.page1.eccb026
         ON ACTION controlp INFIELD eccb026
            #add-point:ON ACTION controlp INFIELD eccb026
            
            #END add-point
 
         #Ctrlp:input.c.page1.eccb027
         ON ACTION controlp INFIELD eccb027
            #add-point:ON ACTION controlp INFIELD eccb027
            
            #END add-point
 
         #Ctrlp:input.c.page1.eccb034
         ON ACTION controlp INFIELD eccb034
            #add-point:ON ACTION controlp INFIELD eccb034
            
            #END add-point
 
         #Ctrlp:input.c.page1.eccb013
         ON ACTION controlp INFIELD eccb013
            #add-point:ON ACTION controlp INFIELD eccb013
            
            #END add-point
 
         #Ctrlp:input.c.page1.eccb014
         ON ACTION controlp INFIELD eccb014
            #add-point:ON ACTION controlp INFIELD eccb014
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_eccb_d[l_ac].eccb014             #給予default值

            #給予arg
            LET g_qryparam.arg1 = " ('1','3')" #交易對象類型

            CALL q_pmaa001_1()                                #呼叫開窗

            LET g_eccb_d[l_ac].eccb014 = g_qryparam.return1              #將開窗取得的值回傳到變數

            DISPLAY g_eccb_d[l_ac].eccb014 TO eccb014              #顯示到畫面上
            CALL aect801_eccb_desc()
            NEXT FIELD eccb014                         #返回原欄位


            #END add-point
 
         #Ctrlp:input.c.page1.eccb015
         ON ACTION controlp INFIELD eccb015
            #add-point:ON ACTION controlp INFIELD eccb015
            
            #END add-point
 
         #Ctrlp:input.c.page1.eccb016
         ON ACTION controlp INFIELD eccb016
            #add-point:ON ACTION controlp INFIELD eccb016
            
            #END add-point
 
         #Ctrlp:input.c.page1.eccb017
         ON ACTION controlp INFIELD eccb017
            #add-point:ON ACTION controlp INFIELD eccb017
            
            #END add-point
 
         #Ctrlp:input.c.page1.eccb018
         ON ACTION controlp INFIELD eccb018
            #add-point:ON ACTION controlp INFIELD eccb018
            
            #END add-point
 
         #Ctrlp:input.c.page1.eccb019
         ON ACTION controlp INFIELD eccb019
            #add-point:ON ACTION controlp INFIELD eccb019
            
            #END add-point
 
         #Ctrlp:input.c.page1.eccb020
         ON ACTION controlp INFIELD eccb020
            #add-point:ON ACTION controlp INFIELD eccb020
            
            #END add-point
 
         #Ctrlp:input.c.page1.eccb030
         ON ACTION controlp INFIELD eccb030
            #add-point:ON ACTION controlp INFIELD eccb030
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_eccb_d[l_ac].eccb030             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "" #

            
            CALL q_ooca001()                                #呼叫開窗

            LET g_eccb_d[l_ac].eccb030 = g_qryparam.return1              

            DISPLAY g_eccb_d[l_ac].eccb030 TO eccb030              #

            NEXT FIELD eccb030                          #返回原欄位


            #END add-point
 
         #Ctrlp:input.c.page1.eccb031
         ON ACTION controlp INFIELD eccb031
            #add-point:ON ACTION controlp INFIELD eccb031
            
            #END add-point
 
         #Ctrlp:input.c.page1.eccb032
         ON ACTION controlp INFIELD eccb032
            #add-point:ON ACTION controlp INFIELD eccb032
            
            #END add-point
 
         #Ctrlp:input.c.page1.eccb021
         ON ACTION controlp INFIELD eccb021
            #add-point:ON ACTION controlp INFIELD eccb021
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_eccb_d[l_ac].eccb021             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "" #

            
            CALL q_ooca001()                                #呼叫開窗

            LET g_eccb_d[l_ac].eccb021 = g_qryparam.return1              

            DISPLAY g_eccb_d[l_ac].eccb021 TO eccb021              #

            NEXT FIELD eccb021                          #返回原欄位


            #END add-point
 
         #Ctrlp:input.c.page1.eccb022
         ON ACTION controlp INFIELD eccb022
            #add-point:ON ACTION controlp INFIELD eccb022
            
            #END add-point
 
         #Ctrlp:input.c.page1.eccb023
         ON ACTION controlp INFIELD eccb023
            #add-point:ON ACTION controlp INFIELD eccb023
            
            #END add-point
 
         #Ctrlp:input.c.page1.eccb033
         ON ACTION controlp INFIELD eccb033
            #add-point:ON ACTION controlp INFIELD eccb033
            
            #END add-point
 
         #Ctrlp:input.c.page1.eccb028
         ON ACTION controlp INFIELD eccb028
            #add-point:ON ACTION controlp INFIELD eccb028
            
            #END add-point
 
         #Ctrlp:input.c.page1.eccb029
         ON ACTION controlp INFIELD eccb029
            #add-point:ON ACTION controlp INFIELD eccb029
            
            #END add-point
 
         #Ctrlp:input.c.page1.ooff013
         ON ACTION controlp INFIELD ooff013
            #add-point:ON ACTION controlp INFIELD ooff013
            IF NOT cl_null(g_eccb_d[l_ac].eccb003) THEN
               CALL aooi360_02('7',g_site,g_ecca_m.eccadocno,g_eccb_d[l_ac].eccb003,'','','','','','','','4')
               CALL s_aooi360_sel('7',g_site,g_ecca_m.eccadocno,g_eccb_d[l_ac].eccb003,'','','','','','','','4') RETURNING l_success,g_eccb_d[l_ac].ooff013
            END IF
            #END add-point
 
         #Ctrlp:input.c.page1.eccb035
         ON ACTION controlp INFIELD eccb035
            #add-point:ON ACTION controlp INFIELD eccb035
            
            #END add-point
 
         #Ctrlp:input.c.page1.eccb036
         ON ACTION controlp INFIELD eccb036
            #add-point:ON ACTION controlp INFIELD eccb036
            
            #END add-point
 
         #Ctrlp:input.c.page1.eccb901
         ON ACTION controlp INFIELD eccb901
            #add-point:ON ACTION controlp INFIELD eccb901
            
            #END add-point
 
         #Ctrlp:input.c.page1.eccb905
         ON ACTION controlp INFIELD eccb905
            #add-point:ON ACTION controlp INFIELD eccb905
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_eccb_d[l_ac].eccb905             #給予default值

            LET g_qryparam.arg1 = g_acc
            
            CALL q_oocq002()                                #呼叫開窗

            LET g_eccb_d[l_ac].eccb905 = g_qryparam.return1              
            DISPLAY g_eccb_d[l_ac].eccb905 TO eccb905     
            NEXT FIELD eccb905                          #返回原欄位
            #END add-point
 
         #Ctrlp:input.c.page1.eccb906
         ON ACTION controlp INFIELD eccb906
            #add-point:ON ACTION controlp INFIELD eccb906
            
            #END add-point
 
         #Ctrlp:input.c.page1.eccb001
         ON ACTION controlp INFIELD eccb001
            #add-point:ON ACTION controlp INFIELD eccb001
            
            #END add-point
 
         #Ctrlp:input.c.page1.eccb002
         ON ACTION controlp INFIELD eccb002
            #add-point:ON ACTION controlp INFIELD eccb002
            
            #END add-point
 
         #Ctrlp:input.c.page1.eccb900
         ON ACTION controlp INFIELD eccb900
            #add-point:ON ACTION controlp INFIELD eccb900
            
            #END add-point
 
         #Ctrlp:input.c.page1.eccb902
         ON ACTION controlp INFIELD eccb902
            #add-point:ON ACTION controlp INFIELD eccb902
            
            #END add-point
 
 
 
         ON ROW CHANGE
            IF INT_FLAG THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code   = 9001 
               LET g_errparam.popup  = FALSE 
               CALL cl_err()
 
               LET INT_FLAG = 0
               LET g_eccb_d[l_ac].* = g_eccb_d_t.*
               CLOSE aect801_bcl
               CALL s_transaction_end('N','0')
               EXIT DIALOG 
            END IF
              
            IF l_lock_sw = 'Y' THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = g_eccb_d[l_ac].eccb003 
               LET g_errparam.code   = -263 
               LET g_errparam.popup  = TRUE 
               CALL cl_err()
 
               LET g_eccb_d[l_ac].* = g_eccb_d_t.*
            ELSE
            
               #add-point:單身修改前
               IF s_transaction_chk("N",0) THEN
                  CALL s_transaction_begin()
               END IF
               IF g_eccb_d[l_ac].eccb901 = '1' THEN
                  LET g_eccb_d[l_ac].eccb901 = '2' 
               END IF
               #end add-point
               
               #寫入修改者/修改日期資訊(單身)
               
      
               UPDATE eccb_t SET (eccbsite,eccbdocno,eccb003,eccb004,eccb005,eccb006,eccb007,eccb008, 
                   eccb009,eccb010,eccb011,eccb012,eccb024,eccb025,eccb026,eccb027,eccb034,eccb013,eccb014, 
                   eccb015,eccb016,eccb017,eccb018,eccb019,eccb020,eccb030,eccb031,eccb032,eccb021,eccb022, 
                   eccb023,eccb033,eccb028,eccb029,eccb035,eccb036,eccb901,eccb905,eccb906,eccb001,eccb002, 
                   eccb900,eccb902) = (g_ecca_m.eccasite,g_ecca_m.eccadocno,g_eccb_d[l_ac].eccb003,g_eccb_d[l_ac].eccb004, 
                   g_eccb_d[l_ac].eccb005,g_eccb_d[l_ac].eccb006,g_eccb_d[l_ac].eccb007,g_eccb_d[l_ac].eccb008, 
                   g_eccb_d[l_ac].eccb009,g_eccb_d[l_ac].eccb010,g_eccb_d[l_ac].eccb011,g_eccb_d[l_ac].eccb012, 
                   g_eccb_d[l_ac].eccb024,g_eccb_d[l_ac].eccb025,g_eccb_d[l_ac].eccb026,g_eccb_d[l_ac].eccb027, 
                   g_eccb_d[l_ac].eccb034,g_eccb_d[l_ac].eccb013,g_eccb_d[l_ac].eccb014,g_eccb_d[l_ac].eccb015, 
                   g_eccb_d[l_ac].eccb016,g_eccb_d[l_ac].eccb017,g_eccb_d[l_ac].eccb018,g_eccb_d[l_ac].eccb019, 
                   g_eccb_d[l_ac].eccb020,g_eccb_d[l_ac].eccb030,g_eccb_d[l_ac].eccb031,g_eccb_d[l_ac].eccb032, 
                   g_eccb_d[l_ac].eccb021,g_eccb_d[l_ac].eccb022,g_eccb_d[l_ac].eccb023,g_eccb_d[l_ac].eccb033, 
                   g_eccb_d[l_ac].eccb028,g_eccb_d[l_ac].eccb029,g_eccb_d[l_ac].eccb035,g_eccb_d[l_ac].eccb036, 
                   g_eccb_d[l_ac].eccb901,g_eccb_d[l_ac].eccb905,g_eccb_d[l_ac].eccb906,g_eccb_d[l_ac].eccb001, 
                   g_eccb_d[l_ac].eccb002,g_eccb_d[l_ac].eccb900,g_eccb_d[l_ac].eccb902)
                WHERE eccbent = g_enterprise AND eccbsite = g_ecca_m.eccasite 
                  AND eccbdocno = g_ecca_m.eccadocno 
 
                  AND eccb003 = g_eccb_d_t.eccb003 #項次   
 
                  
               #add-point:單身修改中
               
               #end add-point
               CASE
                  WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "eccb_t" 
                     LET g_errparam.code   = "std-00009" 
                     LET g_errparam.popup  = TRUE 
                     CALL cl_err()
                     CALL s_transaction_end('N','0')
                     LET g_eccb_d[l_ac].* = g_eccb_d_t.*
                  WHEN SQLCA.sqlcode #其他錯誤
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "eccb_t" 
                     LET g_errparam.code   = SQLCA.sqlcode 
                     LET g_errparam.popup  = TRUE 
                     CALL cl_err()                   
                     CALL s_transaction_end('N','0')
                     LET g_eccb_d[l_ac].* = g_eccb_d_t.*  
                  OTHERWISE
                                    INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_ecca_m.eccasite
               LET gs_keys_bak[1] = g_eccasite_t
               LET gs_keys[2] = g_ecca_m.eccadocno
               LET gs_keys_bak[2] = g_eccadocno_t
               LET gs_keys[3] = g_eccb_d[g_detail_idx].eccb003
               LET gs_keys_bak[3] = g_eccb_d_t.eccb003
               CALL aect801_update_b('eccb_t',gs_keys,gs_keys_bak,"'1'")
                     #資料多語言用-增/改
                     
               END CASE
               
               #修改歷程記錄
               LET g_log1 = util.JSON.stringify(g_ecca_m),util.JSON.stringify(g_eccb_d_t)
               LET g_log2 = util.JSON.stringify(g_ecca_m),util.JSON.stringify(g_eccb_d[l_ac])
               IF NOT cl_log_modified_record(g_log1,g_log2) THEN 
                  CALL s_transaction_end('N','0')
               END IF
               
               #add-point:單身修改後
               IF g_eccb_d[l_ac].eccb008 <> 'MULT' AND (g_eccb_d[l_ac].eccb008 != g_eccb_d_t.eccb008 OR g_eccb_d[l_ac].eccb009 != g_eccb_d_t.eccb009) THEN
                  #新增的上站作业删除
                  DELETE FROM ecce_t 
                   WHERE ecceent = g_enterprise
                     AND eccesite = g_site
                     AND eccedocno = g_ecca_m.eccadocno
                     AND ecce003 = g_eccb_d[l_ac].eccb003
                     AND ecce901 = '3'
                  SELECT COUNT(*) INTO l_n2 FROM ecce_t 
                   WHERE ecceent = g_enterprise
                     AND eccesite = g_site
                     AND eccedocno = g_ecca_m.eccadocno
                     AND ecce003 = g_eccb_d[l_ac].eccb003
                     AND ecce004 = g_eccb_d_t.eccb008
                     AND ecce005 = g_eccb_d_t.eccb009
                     AND ecce901 != '3'
                  IF l_n2 > 0 THEN
                     UPDATE ecce_t SET ecce004 = g_eccb_d[l_ac].eccb008,
                                       ecce005 = g_eccb_d[l_ac].eccb009,
                                       ecce901 = '2'
                      WHERE ecceent = g_enterprise
                        AND eccesite = g_site
                        AND eccedocno = g_ecca_m.eccadocno
                        AND ecce003 = g_eccb_d[l_ac].eccb003
                        AND ecce004 = g_eccb_d_t.eccb008
                        AND ecce005 = g_eccb_d_t.eccb009
                        AND ecce901 != '3'
                  ELSE
                     SELECT MAX(ecceseq)+1 INTO l_ecceseq FROM ecce_t
                      WHERE ecceent = g_enterprise
                        AND eccesite = g_site
                        AND eccedocno = g_ecca_m.eccadocno
                        AND ecce003 = g_eccb_d[l_ac].eccb003
                     IF cl_null(l_ecceseq) THEN
                        LET l_ecceseq = 1
                     END IF
                     INSERT INTO ecce_t(ecceent,eccesite,eccedocno,ecce001,ecce002,ecce003,ecceseq,ecce004,ecce005,ecce900,ecce901,ecce905,ecce906)
                        VALUES(g_enterprise,g_site,g_ecca_m.eccadocno,g_ecca_m.ecca001,g_ecca_m.ecca002,g_eccb_d[l_ac].eccb003,l_ecceseq,g_eccb_d[l_ac].eccb008,g_eccb_d[l_ac].eccb009,g_ecca_m.ecca900,'3',g_eccb_d[l_ac].eccb905,g_eccb_d[l_ac].eccb906)
                 END IF
                 UPDATE ecce_t SET ecce901 = '4'
                  WHERE ecceent = g_enterprise
                    AND eccesite = g_site
                    AND eccedocno = g_ecca_m.eccadocno
                    AND ecce003 = g_eccb_d[l_ac].eccb003
                    AND ecce004 != g_eccb_d_t.eccb008
                    AND ecce005 != g_eccb_d_t.eccb009
                    AND ecce901 != '3'
                  IF SQLCA.sqlcode THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = SQLCA.sqlcode
                     LET g_errparam.extend = " ecce_t"
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
 
                     CALL s_transaction_end('N','0')
                  END IF
               END IF
               #161108-00023#4---add---s
               IF g_eccb_d[l_ac].eccb004 <> g_eccb_d_t.eccb004 OR g_eccb_d[l_ac].eccb005 <> g_eccb_d_t.eccb005 THEN
                  #检查原本站作业和作业序是否存在其他站的上站作业和作业序中，如果存在就将其改成新值
                  UPDATE ecce_t SET ecce004 = g_eccb_d[l_ac].eccb004,
                                    ecce005 = g_eccb_d[l_ac].eccb005
                   WHERE ecceent = g_enterprise
                     AND eccesite = g_site
                     AND eccedocno = g_ecca_m.eccadocno
                     AND ecce004 = g_eccb_d_t.eccb004
                     AND ecce005 = g_eccb_d_t.eccb005
                  IF SQLCA.sqlcode THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = SQLCA.sqlcode
                     LET g_errparam.extend = "ecce_t"
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
 
                     CALL s_transaction_end('N','0')
                  END IF
                  UPDATE eccb_t SET eccb008 = g_eccb_d[l_ac].eccb004,
                                    eccb009 = g_eccb_d[l_ac].eccb005
                   WHERE eccbent = g_enterprise
                     AND eccbsite = g_site
                     AND eccbdocno = g_ecca_m.eccadocno
                     AND eccb008 = g_eccb_d_t.eccb004
                     AND eccb009 = g_eccb_d_t.eccb005
                  IF SQLCA.sqlcode THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = SQLCA.sqlcode
                     LET g_errparam.extend = "eccb_t"
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
 
                     CALL s_transaction_end('N','0')
                  END IF                  
               END IF
               #161108-00023#4---add---e               
               IF NOT cl_null(g_eccb_d[l_ac].ooff013) THEN
                  CALL s_aooi360_gen('7',g_site,g_ecca_m.eccadocno,g_eccb_d[l_ac].eccb003,' ',' ',' ',' ',' ',' ',' ','4',g_eccb_d[l_ac].ooff013)
                     RETURNING l_success
               ELSE
                  CALL s_aooi360_del('7',g_site,g_ecca_m.eccadocno,g_eccb_d[l_ac].eccb003,' ',' ',' ',' ',' ',' ',' ','4')
                     RETURNING l_success
               END IF
               IF NOT l_success THEN
                  CALL s_transaction_end('N','0')
               END IF

               IF NOT aect801_return_eccb_mult() THEN
                  CALL s_transaction_end('N','0')
               END IF
               
               IF NOT aect801_upd_eccb_ecch(g_ecca_m.eccadocno,g_eccb_d[l_ac].eccb003) THEN
                  LET g_eccb_d[l_ac].* = g_eccb_d_t.*    
                  CALL s_transaction_end('N','0')
               END IF
               
               CALL aect801_b_fill()
               #end add-point
 
            END IF
            
         AFTER ROW
            #add-point:單身after_row
            
            #end add-point
            CALL aect801_unlock_b("eccb_t","'1'")
            CALL s_transaction_end('Y','0')
            #其他table進行unlock
            #add-point:單身after_row2
            
            #end add-point
              
         AFTER INPUT
            #add-point:input段after input 
            
            #end add-point 
 
         ON ACTION controlo    
            CALL FGL_SET_ARR_CURR(g_eccb_d.getLength()+1)
            LET lb_reproduce = TRUE
            LET li_reproduce = l_ac
            LET li_reproduce_target = g_eccb_d.getLength()+1
            
         #ON ACTION cancel
         #   LET INT_FLAG = 1
         #   LET g_detail_idx = 1
         #   EXIT DIALOG 
 
      END INPUT
      
 
      
      INPUT ARRAY g_eccb2_d FROM s_detail2.*
         ATTRIBUTE(COUNT = g_rec_b,WITHOUT DEFAULTS, #MAXCOUNT = g_max_rec,
                 INSERT ROW = l_allow_insert, #此頁面insert功能由產生器控制, 手動之設定無效! 
 
                 DELETE ROW = l_allow_delete,
                 APPEND ROW = l_allow_insert)
                 
         #自訂ACTION(detail_input,page_2)
         
         
         BEFORE INPUT
            #add-point:資料輸入前
            
            #end add-point
            IF g_insert = 'Y' AND NOT cl_null(g_insert) THEN 
              CALL FGL_SET_ARR_CURR(g_eccb2_d.getLength()+1) 
              LET g_insert = 'N' 
           END IF 
 
            IF g_rec_b != 0 THEN
               CALL fgl_set_arr_curr(l_ac)
            END IF
            LET g_rec_b = g_eccb2_d.getLength()
            #add-point:資料輸入前
            CALL aect801_b_fill2('2')
            LET g_rec_b = g_eccb2_d.getLength()
            IF cl_null(g_eccb_d[g_detail_idx].eccb003) THEN
               NEXT FIELD eccb003
            END IF
            #end add-point
            
         BEFORE INSERT
            
            LET l_insert = TRUE
            LET l_n = ARR_COUNT()
            LET l_cmd = 'a'
            INITIALIZE g_eccb2_d[l_ac].* TO NULL 
            INITIALIZE g_eccb2_d_t.* TO NULL 
            INITIALIZE g_eccb2_d_o.* TO NULL 
            #公用欄位給值(單身2)
            
            #自定義預設值(單身2)
                  LET g_eccb2_d[l_ac].eccc007 = "1"
      LET g_eccb2_d[l_ac].eccc008 = "1"
      LET g_eccb2_d[l_ac].eccc010 = "1"
      LET g_eccb2_d[l_ac].eccc901 = "3"
 
            #add-point:modify段before備份
            LET g_eccb2_d[l_ac].eccc001 = g_ecca_m.ecca001
            LET g_eccb2_d[l_ac].eccc002 = g_ecca_m.ecca002
            LET g_eccb2_d[l_ac].eccc900 = g_ecca_m.ecca900
            LET g_eccb2_d[l_ac].eccc902 = cl_get_today()
            #end add-point
            LET g_eccb2_d_t.* = g_eccb2_d[l_ac].*     #新輸入資料
            LET g_eccb2_d_o.* = g_eccb2_d[l_ac].*     #新輸入資料
            CALL cl_show_fld_cont()
            CALL aect801_set_entry_b(l_cmd)
            #add-point:modify段after_set_entry_b
            
            #end add-point
            CALL aect801_set_no_entry_b(l_cmd)
            IF lb_reproduce THEN
               LET lb_reproduce = FALSE
               LET g_eccb2_d[li_reproduce_target].* = g_eccb2_d[li_reproduce].*
 
               LET g_eccb2_d[li_reproduce_target].eccc004 = NULL
            END IF
            
            #add-point:modify段before insert
            SELECT MAX(eccc004)+1 INTO g_eccb2_d[l_ac].eccc004
              FROM eccc_t
             WHERE ecccent = g_enterprise
               AND ecccsite = g_site 
               AND ecccdocno = g_ecca_m.eccadocno
               AND eccc003 = g_eccb_d[g_detail_idx].eccb003
            IF cl_null(g_eccb2_d[l_ac].eccc004) THEN
               LET g_eccb2_d[l_ac].eccc004 = 1 
            END IF
            CALL g_eccb3_d.clear()
            #end add-point  
            
         BEFORE ROW
            #add-point:modify段before row2
            CALL cl_set_comp_entry("eccc004",TRUE)
            #end add-point  
            LET l_insert = FALSE
            LET l_cmd = ''
            LET l_ac = ARR_CURR()
            LET g_detail_idx2 = l_ac
            
            LET l_lock_sw = 'N'            #DEFAULT
            LET l_n = ARR_COUNT()
            DISPLAY l_ac TO FORMONLY.idx
         
            CALL s_transaction_begin()
            OPEN aect801_cl USING g_enterprise,g_ecca_m.eccasite,g_ecca_m.eccadocno
            OPEN aect801_bcl USING g_enterprise,g_ecca_m.eccasite,g_ecca_m.eccadocno,g_eccb_d[g_detail_idx].eccb003 
 
            IF STATUS THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "OPEN aect801_cl:" 
               LET g_errparam.code   = STATUS 
               LET g_errparam.popup  = TRUE 
               CALL cl_err()
               CLOSE aect801_cl
               CLOSE aect801_bcl
               CALL s_transaction_end('N','0')
               RETURN
            END IF
            
            LET g_rec_b = g_eccb2_d.getLength()
            
            IF g_rec_b >= l_ac 
               AND g_eccb2_d[l_ac].eccc004 IS NOT NULL
            THEN 
               LET l_cmd='u'
               LET g_eccb2_d_t.* = g_eccb2_d[l_ac].*  #BACKUP
               LET g_eccb2_d_o.* = g_eccb2_d[l_ac].*  #BACKUP
               CALL aect801_set_entry_b(l_cmd)
               #add-point:modify段after_set_entry_b
               CALL cl_set_comp_entry("eccc004",FALSE)
               #end add-point  
               CALL aect801_set_no_entry_b(l_cmd)
               IF NOT aect801_lock_b("eccc_t","'2'") THEN
                  LET l_lock_sw='Y'
               ELSE
                  FETCH aect801_bcl2 INTO g_eccb2_d[l_ac].eccc004,g_eccb2_d[l_ac].eccc005,g_eccb2_d[l_ac].eccc006, 
                      g_eccb2_d[l_ac].eccc007,g_eccb2_d[l_ac].eccc008,g_eccb2_d[l_ac].eccc009,g_eccb2_d[l_ac].eccc010, 
                      g_eccb2_d[l_ac].eccc901,g_eccb2_d[l_ac].eccc905,g_eccb2_d[l_ac].eccc906,g_eccb2_d[l_ac].eccc001, 
                      g_eccb2_d[l_ac].eccc002,g_eccb2_d[l_ac].eccc900,g_eccb2_d[l_ac].eccc902
                  IF SQLCA.sqlcode THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = '' 
                     LET g_errparam.code   = SQLCA.sqlcode 
                     LET g_errparam.popup  = TRUE 
                     CALL cl_err()
                     LET l_lock_sw = "Y"
                  END IF
                  
                  LET g_bfill = "N"
                  CALL aect801_show()
                  LET g_bfill = "Y"
                  
                  CALL cl_show_fld_cont()
               END IF
            ELSE
               LET l_cmd='a'
            END IF
            #add-point:modify段before row
            
            #end add-point  
            #其他table資料備份(確定是否更改用)
            
            #其他table進行lock
            
            
         BEFORE DELETE                            #是否取消單身
            IF l_cmd = 'a' THEN
               LET l_cmd='d'
            ELSE
               IF NOT cl_ask_del_detail() THEN
                  CANCEL DELETE
               END IF
               IF l_lock_sw = "Y" THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "" 
                  LET g_errparam.code   = -263 
                  LET g_errparam.popup  = TRUE 
                  CALL cl_err()
                  CANCEL DELETE
               END IF
               
               #add-point:單身2刪除前
               
               #end add-point    
               
               DELETE FROM eccc_t
                     WHERE ecccent = g_enterprise AND ecccsite = g_ecca_m.eccasite AND ecccdocno = g_ecca_m.eccadocno  
                         AND eccc003 = g_eccb_d[g_detail_idx].eccb003 AND eccc004 = g_eccb2_d[g_detail_idx2].eccc004 
 
                  
               #add-point:單身2刪除中
               
               #end add-point    
                  
               IF SQLCA.sqlcode THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "eccb_t" 
                  LET g_errparam.code   = SQLCA.sqlcode 
                  LET g_errparam.popup  = TRUE 
                  CALL cl_err()
                  CALL s_transaction_end('N','0')
                  CANCEL DELETE   
               ELSE
                  LET g_rec_b = g_rec_b-1
                  
                  #add-point:單身2刪除後
                  
                  #end add-point
                  CALL s_transaction_end('Y','0')
               END IF 
               CLOSE aect801_bcl
               LET l_count = g_eccb_d.getLength()
                              INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_ecca_m.eccasite
               LET gs_keys[2] = g_ecca_m.eccadocno
               LET gs_keys[3] = g_eccb_d[g_detail_idx].eccb003
               LET gs_keys[4] = g_eccb2_d[g_detail_idx2].eccc004
 
            END IF 
            
         AFTER DELETE 
            IF l_cmd <> 'd' THEN
               #add-point:單身AFTER DELETE 
               
               #end add-point
                              CALL aect801_delete_b('eccc_t',gs_keys,"'2'")
            END IF
            #如果是最後一筆
            IF l_ac = (g_eccb2_d.getLength() + 1) THEN
               CALL FGL_SET_ARR_CURR(l_ac-1)
            END IF
 
         AFTER INSERT    
            LET l_insert = FALSE
            IF INT_FLAG THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code   = 9001 
               LET g_errparam.popup  = FALSE 
               CALL cl_err()
               LET INT_FLAG = 0
               CANCEL INSERT
            END IF
               
            #add-point:單身2新增前
            IF s_transaction_chk("N",0) THEN
               CALL s_transaction_begin()
            END IF
            #end add-point
    
            LET l_count = 1  
            SELECT COUNT(*) INTO l_count FROM eccc_t 
             WHERE ecccent = g_enterprise AND ecccsite = g_ecca_m.eccasite AND ecccdocno = g_ecca_m.eccadocno  
                 AND eccc003 = g_eccb_d[g_detail_idx].eccb003 AND eccc004 = g_eccb2_d[g_detail_idx2].eccc004 
 
                
            #資料未重複, 插入新增資料
            IF l_count = 0 THEN 
               #add-point:單身2新增前
               
               #end add-point
            
                              INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_ecca_m.eccasite
               LET gs_keys[2] = g_ecca_m.eccadocno
               LET gs_keys[3] = g_eccb_d[g_detail_idx].eccb003
               LET gs_keys[4] = g_eccb2_d[g_detail_idx2].eccc004
               CALL aect801_insert_b('eccc_t',gs_keys,"'2'")
                           
               #add-point:單身新增後2
               
               #end add-point
            ELSE    
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = 'INSERT' 
               LET g_errparam.code   = "std-00006" 
               LET g_errparam.popup  = TRUE 
               CALL cl_err()
               INITIALIZE g_eccb_d[l_ac].* TO NULL
               CALL s_transaction_end('N','0')
               CANCEL INSERT
            END IF
 
            IF SQLCA.SQLcode  THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "eccc_t" 
               LET g_errparam.code   = SQLCA.sqlcode 
               LET g_errparam.popup  = TRUE 
               CALL cl_err()
               CALL s_transaction_end('N','0')                    
               CANCEL INSERT
            ELSE
               #先刷新資料
               #CALL aect801_b_fill()
               #資料多語言用-增/改
               
               #add-point:單身新增後
               IF NOT aect801_upd_eccc_ecch(g_ecca_m.eccadocno,g_eccb_d[g_detail_idx].eccb003,g_eccb2_d[l_ac].eccc004) THEN
                  LET g_eccb2_d[l_ac].* = g_eccb2_d_t.*    
                  CALL s_transaction_end('N','0')
                  CANCEL INSERT
               END IF
               #end add-point
               CALL s_transaction_end('Y','0')
               #ERROR 'INSERT O.K'
               LET g_rec_b = g_rec_b + 1
            END IF
            
         ON ROW CHANGE 
            IF INT_FLAG THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code   = 9001 
               LET g_errparam.popup  = FALSE 
               CALL cl_err()
               LET INT_FLAG = 0
               LET g_eccb2_d[l_ac].* = g_eccb2_d_t.*
               CLOSE aect801_bcl2
               CALL s_transaction_end('N','0')
               EXIT DIALOG 
            END IF
            
            IF l_lock_sw = 'Y' THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code   = -263 
               LET g_errparam.popup  = TRUE 
               CALL cl_err()
               LET g_eccb2_d[l_ac].* = g_eccb2_d_t.*
            ELSE
               #add-point:單身page2修改前
               IF s_transaction_chk("N",0) THEN
                  CALL s_transaction_begin()
               END IF
               IF g_eccb2_d[l_ac].eccc901 = '1' THEN
                  LET g_eccb2_d[l_ac].eccc901 = '2'
               END IF
               #end add-point
               
               #寫入修改者/修改日期資訊(單身2)
               
               
               UPDATE eccc_t SET (ecccsite,ecccdocno,eccc003,eccc004,eccc005,eccc006,eccc007,eccc008, 
                   eccc009,eccc010,eccc901,eccc905,eccc906,eccc001,eccc002,eccc900,eccc902) = (g_ecca_m.eccasite, 
                   g_ecca_m.eccadocno,g_eccb_d[g_detail_idx].eccb003,g_eccb2_d[l_ac].eccc004,g_eccb2_d[l_ac].eccc005, 
                   g_eccb2_d[l_ac].eccc006,g_eccb2_d[l_ac].eccc007,g_eccb2_d[l_ac].eccc008,g_eccb2_d[l_ac].eccc009, 
                   g_eccb2_d[l_ac].eccc010,g_eccb2_d[l_ac].eccc901,g_eccb2_d[l_ac].eccc905,g_eccb2_d[l_ac].eccc906, 
                   g_eccb2_d[l_ac].eccc001,g_eccb2_d[l_ac].eccc002,g_eccb2_d[l_ac].eccc900,g_eccb2_d[l_ac].eccc902)  
                   #自訂欄位頁簽
                WHERE ecccent = g_enterprise AND ecccsite = g_eccasite_t AND ecccdocno = g_eccadocno_t  
                    AND eccc003 = g_eccb_d[g_detail_idx].eccb003 AND eccc004 = g_eccb2_d_t.eccc004
                  
               #add-point:單身page2修改中
               
               #end add-point
                  
               CASE
                  WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "eccc_t" 
                     LET g_errparam.code   = "std-00009" 
                     LET g_errparam.popup  = TRUE 
                     CALL cl_err()
                     CALL s_transaction_end('N','0')
                     LET g_eccb2_d[l_ac].* = g_eccb2_d_t.*
                  WHEN SQLCA.sqlcode #其他錯誤
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "eccc_t" 
                     LET g_errparam.code   = SQLCA.sqlcode 
                     LET g_errparam.popup  = TRUE 
                     CALL cl_err()
                     CALL s_transaction_end('N','0')
                     LET g_eccb2_d[l_ac].* = g_eccb2_d_t.*
                  OTHERWISE
                                    INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_ecca_m.eccasite
               LET gs_keys_bak[1] = g_eccasite_t
               LET gs_keys[2] = g_ecca_m.eccadocno
               LET gs_keys_bak[2] = g_eccadocno_t
               LET gs_keys[3] = g_eccb_d[g_detail_idx].eccb003
               LET gs_keys_bak[3] = g_eccb_d[g_detail_idx].eccb003
               LET gs_keys[4] = g_eccb2_d[g_detail_idx2].eccc004
               LET gs_keys_bak[4] = g_eccb2_d_t.eccc004
               CALL aect801_update_b('eccc_t',gs_keys,gs_keys_bak,"'2'")
                     #資料多語言用-增/改
                     
               END CASE
               
               #修改歷程記錄
               LET g_log1 = util.JSON.stringify(g_ecca_m),util.JSON.stringify(g_eccb2_d_t)
               LET g_log2 = util.JSON.stringify(g_ecca_m),util.JSON.stringify(g_eccb2_d[l_ac])
               IF NOT cl_log_modified_record(g_log1,g_log2) THEN 
                  CALL s_transaction_end('N','0')
               END IF
               
               #add-point:單身page2修改後
               IF NOT aect801_upd_eccc_ecch(g_ecca_m.eccadocno,g_eccb_d[g_detail_idx].eccb003,g_eccb2_d[l_ac].eccc004) THEN
                  LET g_eccb2_d[l_ac].* = g_eccb2_d_t.*    
                  CALL s_transaction_end('N','0')
               END IF
               #end add-point
            END IF
         
                  #此段落由子樣板a02產生
         AFTER FIELD eccc004
            #此段落由子樣板a15產生
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_eccb2_d[l_ac].eccc004,"0","0","","","azz-00079",1) THEN
               NEXT FIELD eccc004
            END IF
 
 
            #add-point:AFTER FIELD eccc004
            #此段落由子樣板a05產生
            IF  g_ecca_m.eccasite IS NOT NULL AND g_ecca_m.eccadocno IS NOT NULL AND g_eccb_d[g_detail_idx].eccb003 IS NOT NULL AND g_eccb2_d[g_detail_idx2].eccc004 IS NOT NULL THEN 
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_ecca_m.eccasite != g_eccasite_t OR g_ecca_m.eccadocno != g_eccadocno_t OR g_eccb_d[g_detail_idx].eccb003 != g_eccb_d[g_detail_idx].eccb003 OR g_eccb2_d[g_detail_idx2].eccc004 != g_eccb2_d_t.eccc004)) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM eccc_t WHERE "||"ecccent = '" ||g_enterprise|| "' AND "||"ecccsite = '"||g_ecca_m.eccasite ||"' AND "|| "ecccdocno = '"||g_ecca_m.eccadocno ||"' AND "|| "eccc003 = '"||g_eccb_d[g_detail_idx].eccb003 ||"' AND "|| "eccc004 = '"||g_eccb2_d[g_detail_idx2].eccc004 ||"'",'std-00004',0) THEN 
                     LET g_eccb2_d[l_ac].eccc004 = g_eccb2_d_t.eccc004
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF


            #END add-point
            
 
         #此段落由子樣板a01產生
         BEFORE FIELD eccc004
            #add-point:BEFORE FIELD eccc004
            
            #END add-point
 
         #此段落由子樣板a04產生
         ON CHANGE eccc004
            #add-point:ON CHANGE eccc004
            
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD eccc005
            
            #add-point:AFTER FIELD eccc005
            CALL aect801_eccc_desc()
            IF NOT cl_null(g_eccb2_d[l_ac].eccc005) THEN 
               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
               INITIALIZE g_chkparam.* TO NULL

               #設定g_chkparam.*的參數
               LET g_chkparam.arg1 = g_eccb2_d[l_ac].eccc005

               #呼叫檢查存在並帶值的library
               IF NOT cl_chk_exist("v_imaf001_1") THEN
                  LET g_eccb2_d[l_ac].eccc005 = g_eccb2_d_t.eccc005
                  CALL aect801_eccc_desc()
                  NEXT FIELD eccc005
               END IF
               
               IF g_eccb2_d[l_ac].eccc005 = g_ecca_m.ecca001 THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'aec-00003'
                  LET g_errparam.extend = g_eccb2_d[l_ac].eccc005
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  LET g_eccb2_d[l_ac].eccc005 = g_eccb2_d_t.eccc005
                  CALL aect801_eccc_desc()
                  NEXT FIELD eccc005
               END IF
               SELECT imaa006 INTO  g_eccb2_d[l_ac].eccc009
                 FROM imaa_t
                WHERE imaaent = g_enterprise
                  AND imaa001 = g_eccb2_d[l_ac].eccc005
            END IF 
            
            #END add-point
            
 
         #此段落由子樣板a01產生
         BEFORE FIELD eccc005
            #add-point:BEFORE FIELD eccc005
            
            #END add-point
 
         #此段落由子樣板a04產生
         ON CHANGE eccc005
            #add-point:ON CHANGE eccc005
            
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD eccc006
            
            #add-point:AFTER FIELD eccc006
            CALL aect801_eccc_desc()
            IF NOT cl_null(g_eccb2_d[l_ac].eccc006) THEN 
               CALL s_azzi650_chk_exist('215',g_eccb2_d[l_ac].eccc006) RETURNING l_success
               IF NOT l_success THEN
                  LET g_eccb2_d[l_ac].eccc006 = g_eccb2_d_t.eccc006
                  CALL aect801_eccc_desc()
                  NEXT FIELD eccc006
               END IF
            END IF 
            
            #END add-point
            
 
         #此段落由子樣板a01產生
         BEFORE FIELD eccc006
            #add-point:BEFORE FIELD eccc006
            
            #END add-point
 
         #此段落由子樣板a04產生
         ON CHANGE eccc006
            #add-point:ON CHANGE eccc006
            
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD eccc007
            #此段落由子樣板a15產生
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_eccb2_d[l_ac].eccc007,"0","1","","","azz-00079",1) THEN
               NEXT FIELD eccc007
            END IF
 
 
            #add-point:AFTER FIELD eccc007
            IF NOT cl_null(g_eccb2_d[l_ac].eccc007) THEN 
            END IF 


            #END add-point
            
 
         #此段落由子樣板a01產生
         BEFORE FIELD eccc007
            #add-point:BEFORE FIELD eccc007
            
            #END add-point
 
         #此段落由子樣板a04產生
         ON CHANGE eccc007
            #add-point:ON CHANGE eccc007
            
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD eccc008
            #此段落由子樣板a15產生
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_eccb2_d[l_ac].eccc008,"0","0","","","azz-00079",1) THEN
               NEXT FIELD eccc008
            END IF
 
 
            #add-point:AFTER FIELD eccc008
            IF NOT cl_null(g_eccb2_d[l_ac].eccc008) THEN 
            END IF 


            #END add-point
            
 
         #此段落由子樣板a01產生
         BEFORE FIELD eccc008
            #add-point:BEFORE FIELD eccc008
            
            #END add-point
 
         #此段落由子樣板a04產生
         ON CHANGE eccc008
            #add-point:ON CHANGE eccc008
            
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD eccc009
            
            #add-point:AFTER FIELD eccc009
            CALL aect801_eccc_desc()
            IF NOT cl_null(g_eccb2_d[l_ac].eccc009) THEN
               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
               INITIALIZE g_chkparam.* TO NULL

               #設定g_chkparam.*的參數
               LET g_chkparam.arg1 = g_eccb2_d[l_ac].eccc009
               #160318-00025#3--add--str
               LET g_errshow = TRUE 
               LET g_chkparam.err_str[1] = "aim-00005:sub-01302|aooi250|",cl_get_progname("aooi250",g_lang,"2"),"|:EXEPROGaooi250"
               #160318-00025#3--add--end
               #呼叫檢查存在並帶值的library
               IF NOT cl_chk_exist("v_ooca001") THEN
                  LET g_eccb2_d[l_ac].eccc009 = g_eccb2_d_t.eccc009
                  CALL aect801_eccc_desc()
                  NEXT FIELD eccc009
               END IF
               
               IF NOT aect801_chk_eccc009() THEN
                  IF NOT cl_null(g_errno) THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = g_errno
                     LET g_errparam.extend = g_eccb2_d[l_ac].eccc009
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                  END IF
                  LET g_eccb2_d[l_ac].eccc009 = g_eccb2_d_t.eccc009
                  CALL aect801_eccc_desc()
                  NEXT FIELD eccc009
               END IF            
            END IF
            
            #END add-point
            
 
         #此段落由子樣板a01產生
         BEFORE FIELD eccc009
            #add-point:BEFORE FIELD eccc009
            
            #END add-point
 
         #此段落由子樣板a04產生
         ON CHANGE eccc009
            #add-point:ON CHANGE eccc009
            
            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD eccc010
            #add-point:BEFORE FIELD eccc010
            
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD eccc010
            
            #add-point:AFTER FIELD eccc010
            
            #END add-point
            
 
         #此段落由子樣板a04產生
         ON CHANGE eccc010
            #add-point:ON CHANGE eccc010
            
            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD eccc901
            #add-point:BEFORE FIELD eccc901
            
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD eccc901
            
            #add-point:AFTER FIELD eccc901
            
            #END add-point
            
 
         #此段落由子樣板a04產生
         ON CHANGE eccc901
            #add-point:ON CHANGE eccc901
            
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD eccc905
            
            #add-point:AFTER FIELD eccc905
            IF NOT cl_null(g_eccb2_d[l_ac].eccc905) AND (cl_null(g_eccb2_d_t.eccc905) OR g_eccb2_d[l_ac].eccc905 != g_eccb2_d_t.eccc905) THEN
               IF NOT aect801_ecca905_chk(g_eccb2_d[l_ac].eccc905) THEN
                  LET g_eccb2_d[l_ac].eccc905 = g_eccb2_d_t.eccc905
                  CALL aect801_ecca905_desc(g_eccb2_d[l_ac].eccc905) RETURNING g_eccb2_d[l_ac].eccc905_desc
                  DISPLAY BY NAME g_eccb2_d[l_ac].eccc905_desc
                  NEXT FIELD eccc905
               END IF
               CALL aect801_ecca905_desc(g_eccb2_d[l_ac].eccc905) RETURNING g_eccb2_d[l_ac].eccc905_desc
               DISPLAY BY NAME g_eccb2_d[l_ac].eccc905_desc
            END IF

            #END add-point
            
 
         #此段落由子樣板a01產生
         BEFORE FIELD eccc905
            #add-point:BEFORE FIELD eccc905
            
            #END add-point
 
         #此段落由子樣板a04產生
         ON CHANGE eccc905
            #add-point:ON CHANGE eccc905
            
            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD eccc906
            #add-point:BEFORE FIELD eccc906
            
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD eccc906
            
            #add-point:AFTER FIELD eccc906
            
            #END add-point
            
 
         #此段落由子樣板a04產生
         ON CHANGE eccc906
            #add-point:ON CHANGE eccc906
            
            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD eccc001
            #add-point:BEFORE FIELD eccc001
            
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD eccc001
            
            #add-point:AFTER FIELD eccc001
            
            #END add-point
            
 
         #此段落由子樣板a04產生
         ON CHANGE eccc001
            #add-point:ON CHANGE eccc001
            
            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD eccc002
            #add-point:BEFORE FIELD eccc002
            
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD eccc002
            
            #add-point:AFTER FIELD eccc002
            
            #END add-point
            
 
         #此段落由子樣板a04產生
         ON CHANGE eccc002
            #add-point:ON CHANGE eccc002
            
            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD eccc900
            #add-point:BEFORE FIELD eccc900
            
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD eccc900
            
            #add-point:AFTER FIELD eccc900
            
            #END add-point
            
 
         #此段落由子樣板a04產生
         ON CHANGE eccc900
            #add-point:ON CHANGE eccc900
            
            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD eccc902
            #add-point:BEFORE FIELD eccc902
            
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD eccc902
            
            #add-point:AFTER FIELD eccc902
            
            #END add-point
            
 
         #此段落由子樣板a04產生
         ON CHANGE eccc902
            #add-point:ON CHANGE eccc902
            
            #END add-point
 
 
                  #Ctrlp:input.c.page2.eccc004
         ON ACTION controlp INFIELD eccc004
            #add-point:ON ACTION controlp INFIELD eccc004
            
            #END add-point
 
         #Ctrlp:input.c.page2.eccc005
         ON ACTION controlp INFIELD eccc005
            #add-point:ON ACTION controlp INFIELD eccc005
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_eccb2_d[l_ac].eccc005     #給予default值
            CALL q_imaf001_6()                                       #呼叫開窗
            LET g_eccb2_d[l_ac].eccc005 = g_qryparam.return1      #將開窗取得的值回傳到變數
            DISPLAY g_eccb2_d[l_ac].eccc005 TO eccc005            #顯示到畫面上
            CALL aect801_eccc_desc()
            NEXT FIELD eccc005


            #END add-point
 
         #Ctrlp:input.c.page2.eccc006
         ON ACTION controlp INFIELD eccc006
            #add-point:ON ACTION controlp INFIELD eccc006
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_eccb2_d[l_ac].eccc006             #給予default值
            #給予arg
            LET g_qryparam.arg1 = "215" #            
            CALL q_oocq002()                                #呼叫開窗
            LET g_eccb2_d[l_ac].eccc006 = g_qryparam.return1              
            DISPLAY g_eccb2_d[l_ac].eccc006 TO eccc006              #
            NEXT FIELD eccc006                          #返回原欄位


            #END add-point
 
         #Ctrlp:input.c.page2.eccc007
         ON ACTION controlp INFIELD eccc007
            #add-point:ON ACTION controlp INFIELD eccc007
            
            #END add-point
 
         #Ctrlp:input.c.page2.eccc008
         ON ACTION controlp INFIELD eccc008
            #add-point:ON ACTION controlp INFIELD eccc008
            
            #END add-point
 
         #Ctrlp:input.c.page2.eccc009
         ON ACTION controlp INFIELD eccc009
            #add-point:ON ACTION controlp INFIELD eccc009
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_eccb2_d[l_ac].eccc009             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "" #

            
            CALL q_ooca001_1()                                #呼叫開窗

            LET g_eccb2_d[l_ac].eccc009 = g_qryparam.return1              

            DISPLAY g_eccb2_d[l_ac].eccc009 TO eccc009              #

            NEXT FIELD eccc009                          #返回原欄位


            #END add-point
 
         #Ctrlp:input.c.page2.eccc010
         ON ACTION controlp INFIELD eccc010
            #add-point:ON ACTION controlp INFIELD eccc010
            
            #END add-point
 
         #Ctrlp:input.c.page2.eccc901
         ON ACTION controlp INFIELD eccc901
            #add-point:ON ACTION controlp INFIELD eccc901
            
            #END add-point
 
         #Ctrlp:input.c.page2.eccc905
         ON ACTION controlp INFIELD eccc905
            #add-point:ON ACTION controlp INFIELD eccc905
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_eccb2_d[l_ac].eccc905             #給予default值

            LET g_qryparam.arg1 = g_acc
            
            CALL q_oocq002()                                #呼叫開窗

            LET g_eccb2_d[l_ac].eccc905 = g_qryparam.return1              
            DISPLAY g_eccb2_d[l_ac].eccc905 TO eccc905     
            NEXT FIELD eccc905                          #返回原欄位
            #END add-point
 
         #Ctrlp:input.c.page2.eccc906
         ON ACTION controlp INFIELD eccc906
            #add-point:ON ACTION controlp INFIELD eccc906
            #開窗i段
            

            #END add-point
 
         #Ctrlp:input.c.page2.eccc001
         ON ACTION controlp INFIELD eccc001
            #add-point:ON ACTION controlp INFIELD eccc001
            
            #END add-point
 
         #Ctrlp:input.c.page2.eccc002
         ON ACTION controlp INFIELD eccc002
            #add-point:ON ACTION controlp INFIELD eccc002
            
            #END add-point
 
         #Ctrlp:input.c.page2.eccc900
         ON ACTION controlp INFIELD eccc900
            #add-point:ON ACTION controlp INFIELD eccc900
            
            #END add-point
 
         #Ctrlp:input.c.page2.eccc902
         ON ACTION controlp INFIELD eccc902
            #add-point:ON ACTION controlp INFIELD eccc902
            
            #END add-point
 
 
 
         AFTER ROW
            #add-point:單身page2_after_row
            
            #end add-point
            LET l_ac = ARR_CURR()
            IF INT_FLAG THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code   = 9001 
               LET g_errparam.popup  = FALSE 
               CALL cl_err()
               LET INT_FLAG = 0
               IF l_cmd = 'u' THEN
                  LET g_eccb2_d[l_ac].* = g_eccb2_d_t.*
               END IF
               CLOSE aect801_bcl2
               CLOSE aect801_bcl
               CALL s_transaction_end('N','0')
               EXIT DIALOG 
            END IF
            
            #其他table進行unlock
            
            CALL aect801_unlock_b("eccc_t","'2'")
            CALL s_transaction_end('Y','0')
            #add-point:單身page2_after_row2
            
            #end add-point
 
         AFTER INPUT
            #add-point:input段after input 
            
            #end add-point  
 
         ON ACTION controlo    
            CALL FGL_SET_ARR_CURR(g_eccb2_d.getLength()+1)
            LET lb_reproduce = TRUE
            LET li_reproduce = l_ac
            LET li_reproduce_target = g_eccb2_d.getLength()+1
 
      END INPUT
 
      
 
      
 
      
 
{</section>}
 
{<section id="aect801.input.other" >}
      
      #add-point:自定義input
      INPUT ARRAY g_eccb3_d FROM s_detail3.*
          ATTRIBUTE(COUNT = g_rec_b2,MAXCOUNT = g_max_rec,WITHOUT DEFAULTS, 
                  INSERT ROW = l_allow_insert, 
                  DELETE ROW = l_allow_delete,
                  APPEND ROW = l_allow_insert)
 
         
         BEFORE INPUT
            IF g_insert = 'Y' AND NOT cl_null(g_insert) THEN 
               CALL FGL_SET_ARR_CURR(g_eccb3_d.getLength()+1) 
               LET g_insert = 'N' 
           END IF 
           CALL aect801_b_fill3()
           LET g_rec_b2 = g_eccb3_d.getLength()
           IF cl_null(g_eccb_d[g_detail_idx].eccb003) THEN
              NEXT FIELD eccb003
           END IF
           IF cl_null(g_eccb2_d[g_detail_idx2].eccc004) THEN
              NEXT FIELD eccc004
           END IF
           
         BEFORE ROW
            LET l_insert = FALSE
            LET l_cmd = ''
            LET l_ac2 = ARR_CURR()
            LET g_detail_idx3 = l_ac2
            
            LET l_lock_sw = 'N'            #DEFAULT
            LET l_n = ARR_COUNT()
            DISPLAY l_ac2 TO FORMONLY.idx
         
            CALL s_transaction_begin()
            OPEN aect801_cl USING g_enterprise, g_site,g_ecca_m.eccadocno
            IF STATUS THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code =  STATUS
               LET g_errparam.extend = "OPEN aect801_cl:"
               LET g_errparam.popup = TRUE
               CALL cl_err()

               CLOSE aect801_cl
               CALL s_transaction_end('N','0')
               RETURN
            END IF
            LET g_rec_b2 = g_eccb3_d.getLength()
            
            IF g_rec_b2 >= l_ac2 AND NOT cl_null(g_eccb3_d[l_ac2].eccd005) THEN
               LET l_cmd='u'
               LET g_eccb3_d_t.* = g_eccb3_d[l_ac2].*  #BACKUP
               CALL aect801_set_entry_b(l_cmd)
               CALL aect801_set_no_entry_b(l_cmd)
               OPEN aect801_bcl3 USING g_enterprise,g_site,g_ecca_m.eccadocno,g_eccb_d[g_detail_idx].eccb003,g_eccb2_d[g_detail_idx2].eccc004,g_eccb3_d[g_detail_idx3].eccd005
               IF SQLCA.sqlcode THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = SQLCA.sqlcode
                  LET g_errparam.extend = "aect801_bcl3"
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  LET l_lock_sw='Y'
               ELSE
                  FETCH aect801_bcl3 INTO g_eccb3_d[l_ac2].*
                  IF SQLCA.sqlcode THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = SQLCA.sqlcode
                     LET g_errparam.extend = g_eccb3_d_t.eccd005
                     LET g_errparam.popup = TRUE
                     CALL cl_err()

                     LET l_lock_sw = "Y"
                  END IF
                  LET g_bfill = "N"
                  CALL aect801_show()
                  LET g_bfill = "Y"
                  CALL cl_show_fld_cont()
               END IF
            ELSE
               LET l_cmd='a'
            END IF
            
        
         BEFORE INSERT
            LET l_insert = TRUE
            LET l_n = ARR_COUNT()
            LET l_cmd = 'a'
            INITIALIZE g_eccb3_d[l_ac2].* TO NULL 
            SELECT MAX(eccdseq) INTO g_eccb3_d[l_ac2].eccdseq FROM eccd_t
             WHERE eccdent = g_enterprise AND eccdsite = g_site
               AND eccddocno = g_ecca_m.eccadocno AND eccd003 = g_eccb_d[g_detail_idx].eccb003
               AND eccd004 = g_eccb2_d[g_detail_idx2].eccc004
            IF cl_null(g_eccb3_d[l_ac2].eccdseq) OR g_eccb3_d[l_ac2].eccdseq = 0 THEN
               LET g_eccb3_d[l_ac2].eccdseq = 1
            ELSE
               LET g_eccb3_d[l_ac2].eccdseq = g_eccb3_d[l_ac2].eccdseq + 1
            END IF
            LET g_eccb3_d[l_ac2].eccd007 = 0
            LET g_eccb3_d[l_ac2].eccd008 = 0
            LET g_eccb3_d[l_ac2].eccd901 = '3'
            LET g_eccb3_d_t.* = g_eccb3_d[l_ac2].*     #新輸入資料
            CALL cl_show_fld_cont()
            CALL aect801_set_entry_b(l_cmd)
            CALL aect801_set_no_entry_b(l_cmd)
            CALL aect801_def_ecca005()
            
         AFTER INSERT
            LET l_insert = FALSE
            IF INT_FLAG THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = 9001
               LET g_errparam.extend = ''
               LET g_errparam.popup = FALSE
               CALL cl_err()

               LET INT_FLAG = 0
               CANCEL INSERT
            END IF
                      
            LET l_count = 1  
            SELECT COUNT(*) INTO l_count FROM eccd_t 
             WHERE eccdent = g_enterprise
               AND eccdsite = g_site 
               AND eccddocno = g_ecca_m.eccadocno
               AND eccd003 = g_eccb_d[g_detail_idx].eccb003
               AND eccd004 = g_eccb2_d[g_detail_idx2].eccc004
               AND eccd005 = g_eccb3_d[g_detail_idx3].eccd005
            #資料未重複, 插入新增資料
            IF l_count = 0 THEN 
               IF s_transaction_chk("N",0) THEN
                  CALL s_transaction_begin()
               END IF
               LET l_eccd902 = cl_get_today()
               INSERT INTO eccd_t(eccdent,eccdsite,eccddocno,eccd001,eccd002,eccd003,eccd004,eccdseq,eccd005,eccd006,eccd007,eccd008,eccd900,eccd901,eccd902,eccd905,eccd906) 
                           VALUES(g_enterprise,g_site,g_ecca_m.eccadocno,g_ecca_m.ecca001,g_ecca_m.ecca002,g_eccb_d[g_detail_idx].eccb003,g_eccb2_d[g_detail_idx2].eccc004,g_eccb3_d[l_ac2].eccdseq,g_eccb3_d[l_ac2].eccd005,g_eccb3_d[l_ac2].eccd006,g_eccb3_d[l_ac2].eccd007,g_eccb3_d[l_ac2].eccd008,g_ecca_m.ecca900,g_eccb3_d[l_ac2].eccd901,l_eccd902,g_eccb3_d[l_ac2].eccd905,g_eccb3_d[l_ac2].eccd906)
            ELSE    
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = "std-00006"
               LET g_errparam.extend = 'INSERT'
               LET g_errparam.popup = TRUE
               CALL cl_err()

               INITIALIZE g_eccb3_d[l_ac2].* TO NULL
               CALL s_transaction_end('N','0')
               CANCEL INSERT
            END IF
 
            IF SQLCA.SQLcode  THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = SQLCA.sqlcode
               LET g_errparam.extend = "eccd_t"
               LET g_errparam.popup = TRUE
               CALL cl_err()
  
               CALL s_transaction_end('N','0')                    
               CANCEL INSERT
            ELSE
               IF NOT aect801_upd_eccd_ecch(g_ecca_m.eccadocno,g_eccb_d[g_detail_idx].eccb003,g_eccb2_d[g_detail_idx2].eccc004,g_eccb3_d[l_ac2].eccdseq) THEN
                  LET g_eccb3_d[l_ac2].* = g_eccb3_d_t.*    
                  CALL s_transaction_end('N','0')
                  CANCEL INSERT
               END IF
               CALL s_transaction_end('Y','0')
               ERROR 'INSERT O.K'
               LET g_rec_b2 = g_rec_b2 + 1
            END IF
              
         BEFORE DELETE                            #是否取消單身
            IF l_cmd = 'a' THEN
               CALL FGL_SET_ARR_CURR(l_ac2-1)
               CALL g_eccb3_d.deleteElement(l_ac2)
               NEXT FIELD eccd005
            END IF
         
            IF NOT cl_null(g_eccb3_d[l_ac2].eccd005) THEN 
               IF NOT cl_ask_del_detail() THEN
                  CANCEL DELETE
               END IF
               IF l_lock_sw = "Y" THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code =  -263
                  LET g_errparam.extend = ""
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  CANCEL DELETE
               END IF

               #变更类型是已删除的，则不可再次删除
               IF g_eccb3_d[l_ac2].eccd901 = '4' THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = g_eccb3_d[l_ac2].eccd005
                  LET g_errparam.code   = 'aec-00037' 
                  LET g_errparam.popup  = TRUE 
                  CALL cl_err() 
                  CANCEL DELETE
               END IF
               
               DELETE FROM eccd_t
                WHERE eccdent = g_enterprise
                  AND eccdsite = g_site 
                  AND eccddocno = g_ecca_m.eccadocno 
                  AND eccd003 = g_eccb_d[g_detail_idx].eccb003
                  AND eccd004 = g_eccb2_d[g_detail_idx2].eccc004
                  AND eccd005 = g_eccb3_d_t.eccd005
               
               IF SQLCA.sqlcode THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = SQLCA.sqlcode
                  LET g_errparam.extend = "eccd_t"
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  CALL s_transaction_end('N','0')
                  CANCEL DELETE   
               ELSE
                  LET g_rec_b2 = g_rec_b2-1
                  CALL s_transaction_end('Y','0')
               END IF 
               CLOSE aect801_bcl3
               LET l_count = g_eccb3_d.getLength()
            END IF 
            
              
         AFTER FIELD eccd005
            IF NOT cl_ap_chk_Range(g_eccb3_d[l_ac2].eccd005,"0.000","1","","","azz-00079",1) THEN
               LET g_eccb3_d[l_ac2].eccd005 = g_eccb3_d_t.eccd005
               NEXT FIELD eccd005
            END IF
            IF NOT cl_null(g_ecca_m.ecca001) AND NOT cl_null(g_ecca_m.ecca002) AND NOT cl_null(g_eccb_d[g_detail_idx].eccb003) AND NOT cl_null(g_eccb2_d[g_detail_idx2].eccc004) AND NOT cl_null(g_eccb3_d[l_ac2].eccd005) THEN 
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND g_eccb3_d[l_ac2].eccd005 != g_eccb3_d_t.eccd005) THEN 
                  IF NOT ap_chk_notDup(g_eccb3_d[l_ac2].eccd005,"SELECT COUNT(*) FROM eccd_t WHERE "||"eccdent = '" ||g_enterprise|| "' AND eccdsite = '" ||g_site|| "' AND "||"eccd001 = '"||g_ecca_m.ecca001 ||"' AND "|| "eccd002 = '"||g_ecca_m.ecca002 ||"' AND "|| "eccd003 = '"||g_eccb_d[g_detail_idx].eccb003 ||"' AND "|| "eccd004 = '"||g_eccb2_d[g_detail_idx2].eccc004 ||"' AND "|| "eccd005 = '"||g_eccb3_d[l_ac2].eccd005 ||"'",'std-00004',0) THEN 
                     LET g_eccb3_d[l_ac2].eccd005 = g_eccb3_d_t.eccd005
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF
            IF NOT cl_null(g_eccb3_d[l_ac2].eccd005) THEN
               IF NOT cl_null(g_eccb3_d[l_ac2].eccd006) THEN
                  IF g_eccb3_d[l_ac2].eccd005 > g_eccb3_d[l_ac2].eccd006 THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = 'aec-00005'
                     LET g_errparam.extend = g_eccb3_d[l_ac2].eccd005
                     LET g_errparam.popup = TRUE
                     CALL cl_err()

                     LET g_eccb3_d[l_ac2].eccd005 = g_eccb3_d_t.eccd005
                     NEXT FIELD eccd005
                  END IF
               END IF
               CALL aect801_chk_eccd005(g_eccb3_d[l_ac2].eccd005,'1',l_cmd)
               IF NOT cl_null(g_errno) THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = g_errno
                  LET g_errparam.extend = g_eccb3_d[l_ac2].eccd005
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  LET g_eccb3_d[l_ac2].eccd005 = g_eccb3_d_t.eccd005
                  NEXT FIELD eccd005
               END IF
            END IF
            NEXT FIELD eccd006
            
            
         AFTER FIELD eccd006
            IF NOT cl_ap_chk_Range(g_eccb3_d[l_ac2].eccd006,"0.000","1","","","azz-00079",1) THEN
               LET g_eccb3_d[l_ac2].eccd006 = g_eccb3_d_t.eccd006
               NEXT FIELD eccd006
            END IF
            IF NOT cl_null(g_eccb3_d[l_ac2].eccd006) THEN
               IF NOT cl_null(g_eccb3_d[l_ac2].eccd005) THEN
                  IF g_eccb3_d[l_ac2].eccd005 > g_eccb3_d[l_ac2].eccd006 THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = 'aec-00005'
                     LET g_errparam.extend = g_eccb3_d[l_ac2].eccd006
                     LET g_errparam.popup = TRUE
                     CALL cl_err()

                     LET g_eccb3_d[l_ac2].eccd006 = g_eccb3_d_t.eccd006
                     NEXT FIELD eccd006
                  END IF
               END IF
            END IF
            CALL aect801_chk_eccd005(g_eccb3_d[l_ac2].eccd006,'2',l_cmd)
            IF NOT cl_null(g_errno) THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = g_errno
               LET g_errparam.extend = g_eccb3_d[l_ac2].eccd006
               LET g_errparam.popup = TRUE
               CALL cl_err()

               LET g_eccb3_d[l_ac2].eccd006 = g_eccb3_d_t.eccd006
               NEXT FIELD eccd006
            END IF
            
         AFTER FIELD eccd007
            IF NOT cl_ap_chk_Range(g_eccb3_d[l_ac2].eccd007,"0.000","1","","","azz-00079",1) THEN
               LET g_eccb3_d[l_ac2].eccd007 = g_eccb3_d_t.eccd007
               NEXT FIELD eccd007
            END IF
           
         AFTER FIELD eccd008
            IF NOT cl_ap_chk_Range(g_eccb3_d[l_ac2].eccd008,"0.000","1","","","azz-00079",1) THEN
               LET g_eccb3_d[l_ac2].eccd008 = g_eccb3_d_t.eccd008
               NEXT FIELD eccd008
            END IF
            
         AFTER FIELD eccd905
            IF NOT cl_null(g_eccb3_d[l_ac2].eccd905) AND (cl_null(g_eccb3_d_t.eccd905) OR g_eccb3_d[l_ac2].eccd905 != g_eccb3_d_t.eccd905) THEN
               IF NOT aect801_ecca905_chk(g_eccb3_d[l_ac2].eccd905) THEN
                  LET g_eccb3_d[l_ac2].eccd905 = g_eccb3_d_t.eccd905
                  CALL aect801_ecca905_desc(g_eccb3_d[l_ac2].eccd905) RETURNING g_eccb3_d[l_ac2].eccd905_desc
                  DISPLAY BY NAME g_eccb3_d[l_ac2].eccd905_desc
                  NEXT FIELD eccd905
               END IF
               CALL aect801_ecca905_desc(g_eccb3_d[l_ac2].eccd905) RETURNING g_eccb3_d[l_ac2].eccd905_desc
               DISPLAY BY NAME g_eccb3_d[l_ac2].eccd905_desc
            END IF
            
         ON ACTION controlp INFIELD eccd905
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_eccb3_d[l_ac].eccd905             #給予default值

            LET g_qryparam.arg1 = g_acc
            
            CALL q_oocq002()                                #呼叫開窗

            LET g_eccb3_d[l_ac].eccd905 = g_qryparam.return1              
            DISPLAY g_eccb3_d[l_ac].eccd905 TO eccd905     
            NEXT FIELD eccd905                          #返回原欄位
    
         ON ROW CHANGE
            IF INT_FLAG THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = 9001
               LET g_errparam.extend = ''
               LET g_errparam.popup = FALSE
               CALL cl_err()

               LET INT_FLAG = 0
               LET g_eccb3_d[l_ac2].* = g_eccb3_d_t.*
               CLOSE aect801_bcl3
               CALL s_transaction_end('N','0')
               EXIT DIALOG 
            END IF
              
            IF l_lock_sw = 'Y' THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = -263
               LET g_errparam.extend = g_eccb3_d[l_ac2].eccd005
               LET g_errparam.popup = TRUE
               CALL cl_err()

               LET g_eccb3_d[l_ac2].* = g_eccb3_d_t.*
            ELSE
               IF s_transaction_chk("N",0) THEN
                  CALL s_transaction_begin()
               END IF
               IF g_eccb3_d[l_ac2].eccd901 = '1' THEN
                  LET g_eccb3_d[l_ac2].eccd901 = '2' 
               END IF
               LET l_eccd902 = cl_get_today()
               #寫入修改者/修改日期資訊(單身)
               UPDATE eccd_t SET (eccd005,eccd006,eccd007,eccd008,eccd901,eccd902,eccd905,eccd906)
                               = (g_eccb3_d[l_ac2].eccd005,g_eccb3_d[l_ac2].eccd006,g_eccb3_d[l_ac2].eccd007,g_eccb3_d[l_ac2].eccd008,g_eccb3_d[l_ac2].eccd901,l_eccd902,g_eccb3_d[l_ac2].eccd905,g_eccb3_d[l_ac2].eccd906)
                WHERE eccdent = g_enterprise 
                  AND eccdsite = g_site 
                  AND eccddocno = g_ecca_m.eccadocno 
                  AND eccd003 = g_eccb_d[g_detail_idx].eccb003
                  AND eccd004 = g_eccb2_d[g_detail_idx2].eccc004
                  AND eccd005 = g_eccb3_d_t.eccd005   
               IF SQLCA.sqlcode THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = SQLCA.sqlcode
                  LET g_errparam.extend = "eccd_t"
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
                  LET g_eccb3_d[l_ac2].* = g_eccb3_d_t.*
                  CALL s_transaction_end('N','0')
               END IF
               IF NOT aect801_upd_eccd_ecch(g_ecca_m.eccadocno,g_eccb_d[g_detail_idx].eccb003,g_eccb2_d[g_detail_idx2].eccc004,g_eccb3_d[l_ac2].eccdseq) THEN
                  LET g_eccb3_d[l_ac2].* = g_eccb3_d_t.*    
                  CALL s_transaction_end('N','0')
               END IF
            END IF
            
         AFTER ROW
      
            CLOSE aect801_bcl3
            CALL s_transaction_end('Y','0')
              
         AFTER INPUT
         
      END INPUT
      #end add-point
      
      BEFORE DIALOG 
         #CALL cl_err_collect_init()    
         #add-point:input段before dialog
         IF p_cmd = 'a' THEN
            NEXT FIELD eccadocno
         END IF
         #end add-point    
         #重新導回資料到正確位置上
         CALL DIALOG.setCurrentRow("s_detail1",g_detail_idx)      
         CALL DIALOG.setCurrentRow("s_detail2",g_detail_idx2)
 
         #新增時強制從單頭開始填
         IF p_cmd = 'a' THEN
            NEXT FIELD eccasite
         ELSE
            CASE g_aw
               WHEN "s_detail1"
                  NEXT FIELD eccb003
               WHEN "s_detail2"
                  NEXT FIELD eccc004
 
               #add-point:input段modify_detail 
               
               #end add-point  
            END CASE
         END IF
    
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
         #add-point:input段accept 
         
         #end add-point    
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
         EXIT DIALOG
 
      #交談指令共用ACTION
      &include "common_action.4gl" 
         CONTINUE DIALOG 
         
   END DIALOG
    
   #add-point:input段after input 
  #IF l_flag1 = 'N' THEN
  #   LET l_flag1 = 'Y'
  #   CALL aect801_modify()
  #END IF
   #end add-point    
 
END FUNCTION
 
{</section>}
 
{<section id="aect801.show" >}
#+ 單頭資料重新顯示及單身資料重抓
PRIVATE FUNCTION aect801_show()
   DEFINE l_ac_t    LIKE type_t.num10  #161108-00012#1 num5==》num10
   #add-point:show段define
   DEFINE l_success         LIKE type_t.num5
   DEFINE l_slip            STRING
   #end add-point  
 
   #add-point:show段之前
 
   #end add-point
   
   
   
   IF g_bfill = "Y" THEN
      CALL aect801_b_fill() #單身填充
      CALL aect801_b_fill2('0') #單身填充
   END IF
     
   #帶出公用欄位reference值
   
 
   
   #顯示followup圖示
   #+ 此段落由子樣板a48產生
   CALL aect801_set_pk_array()
   #add-point:ON ACTION agendum
   
   #END add-point
   CALL cl_user_overview_set_follow_pic()
 
 
   
   LET l_ac_t = l_ac
   
   #讀入ref值(單頭)
   #add-point:show段reference
   CALL aect801_b_fill3()
   IF g_eccb_d.getLength() > 0 AND (cl_null(g_detail_idx) OR g_detail_idx = 0) THEN
      LET g_detail_idx = 1
   END IF
   IF g_eccb2_d.getLength() > 0 AND (cl_null(g_detail_idx2) OR g_detail_idx2 = 0) THEN
      LET g_detail_idx2 = 1
   END IF
   IF g_eccb3_d.getLength() > 0 AND (cl_null(g_detail_idx3) OR g_detail_idx3 = 0) THEN
      LET g_detail_idx3 = 1
   END IF
   
   IF NOT cl_null(g_ecca_m.eccadocno) THEN
      CALL s_aooi200_get_slip(g_ecca_m.eccadocno) RETURNING l_success,l_slip
      CALL s_aooi200_get_slip_desc(l_slip)
       RETURNING g_ecca_m.oobxl003
      DISPLAY BY NAME g_ecca_m.oobxl003
      CALL aect801_desc()
   END IF
   #end add-point
   
   #將資料輸出到畫面上
   DISPLAY BY NAME g_ecca_m.eccadocno,g_ecca_m.ecca001,g_ecca_m.oobxl003,g_ecca_m.ecca001_desc,g_ecca_m.eccadocdt, 
       g_ecca_m.ecca001_desc_1,g_ecca_m.ecca004,g_ecca_m.ecca002,g_ecca_m.eccasite,g_ecca_m.ecca003, 
       g_ecca_m.ecca900,g_ecca_m.ecca905,g_ecca_m.ecca905_desc,g_ecca_m.ecca906,g_ecca_m.eccastus,g_ecca_m.eccaownid, 
       g_ecca_m.eccaownid_desc,g_ecca_m.eccaowndp,g_ecca_m.eccaowndp_desc,g_ecca_m.eccacrtid,g_ecca_m.eccacrtid_desc, 
       g_ecca_m.eccacrtdp,g_ecca_m.eccacrtdp_desc,g_ecca_m.eccacrtdt,g_ecca_m.eccamodid,g_ecca_m.eccamodid_desc, 
       g_ecca_m.eccamoddt,g_ecca_m.eccacnfid,g_ecca_m.eccacnfid_desc,g_ecca_m.eccacnfdt
   
   #顯示狀態(stus)圖片
         #此段落由子樣板a21產生
	  #根據狀態碼顯示對應圖片
      CASE g_ecca_m.eccastus
         WHEN "A"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/approved.png")
         WHEN "D"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/withdraw.png")
         WHEN "N"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/unconfirmed.png")
         WHEN "R"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/rejection.png")
         WHEN "W"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/signing.png")   
         WHEN "X"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/invalid.png")   
         WHEN "Y"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/confirmed.png")             
         
      END CASE
 
 
   
   #讀入ref值(單身)
   FOR l_ac = 1 TO g_eccb_d.getLength()
      #add-point:show段單身reference
      CALL aect801_eccb_desc()
      #end add-point
   END FOR
   
   FOR l_ac = 1 TO g_eccb2_d.getLength()
      #add-point:show段單身reference
      CALL aect801_eccc_desc()
      #end add-point
   END FOR
 
   
    
   
   #add-point:show段other
   
   #end add-point  
   
   LET l_ac = l_ac_t
   
   #移動上下筆可以連動切換資料
   CALL cl_show_fld_cont()     
 
   CALL aect801_detail_show()
   
   #add-point:show段之後
   CALL aect801_ecca_color()                                                                                            
   CALL s_hint_show('ecch_t','ecca_t','ecba_t',g_ecca_m.eccadocno,g_ecca_m.ecca900,0,'','')
   IF g_detail_idx > 0 THEN                                                                                             
      CALL s_hint_show('ecch_t','eccb_t','ecbb_t',g_ecca_m.eccadocno,g_ecca_m.ecca900,g_eccb_d[g_detail_idx].eccb003,0,0)
      IF g_detail_idx2 > 0 THEN
         CALL s_hint_show('ecch_t','eccc_t','ecbc_t',g_ecca_m.eccadocno,g_ecca_m.ecca900,g_eccb_d[g_detail_idx].eccb003,g_eccb2_d[g_detail_idx2].eccc004,0)
         IF g_detail_idx3 > 0 THEN
            CALL s_hint_show('ecch_t','eccd_t','ecbd_t',g_ecca_m.eccadocno,g_ecca_m.ecca900,g_eccb_d[g_detail_idx].eccb003,g_eccb2_d[g_detail_idx2].eccc004,g_eccb3_d[g_detail_idx3].eccdseq)
         END IF
      END IF
   END IF
   #end add-point
   
END FUNCTION
 
{</section>}
 
{<section id="aect801.detail_show" >}
#+ 第二階單身reference
PRIVATE FUNCTION aect801_detail_show()
   #add-point:detail_show段define
   
   #end add-point  
 
   #add-point:detail_show段之前
   
   #end add-point
   
   #add-point:detail_show段之後
   
   #end add-point
   
END FUNCTION
 
{</section>}
 
{<section id="aect801.reproduce" >}
#+ 資料複製
PRIVATE FUNCTION aect801_reproduce()
   DEFINE l_newno     LIKE ecca_t.eccasite 
   DEFINE l_oldno     LIKE ecca_t.eccasite 
   DEFINE l_newno02     LIKE ecca_t.eccadocno 
   DEFINE l_oldno02     LIKE ecca_t.eccadocno 
 
   #DEFINE l_master    RECORD LIKE ecca_t.*  #161124-00048#2     2016/12/06 By 08734 mark
   #161124-00048#2     2016/12/06 By 08734 add(S)
   DEFINE l_master RECORD  #料件製程變更單頭檔
       eccaent LIKE ecca_t.eccaent, #企业编号
       eccaownid LIKE ecca_t.eccaownid, #资料所有者
       eccaowndp LIKE ecca_t.eccaowndp, #资料所有部门
       eccacrtid LIKE ecca_t.eccacrtid, #资料录入者
       eccacrtdp LIKE ecca_t.eccacrtdp, #资料录入部门
       eccacrtdt LIKE ecca_t.eccacrtdt, #资料创建日
       eccamodid LIKE ecca_t.eccamodid, #资料更改者
       eccamoddt LIKE ecca_t.eccamoddt, #最近更改日
       eccacnfid LIKE ecca_t.eccacnfid, #资料审核者
       eccacnfdt LIKE ecca_t.eccacnfdt, #数据审核日
       eccastus LIKE ecca_t.eccastus, #状态码
       eccasite LIKE ecca_t.eccasite, #营运据点
       eccadocno LIKE ecca_t.eccadocno, #申请单号
       eccadocdt LIKE ecca_t.eccadocdt, #申请日期
       ecca001 LIKE ecca_t.ecca001, #工艺料号
       ecca002 LIKE ecca_t.ecca002, #工艺编号
       ecca003 LIKE ecca_t.ecca003, #说明
       ecca004 LIKE ecca_t.ecca004, #申请类型
       ecca900 LIKE ecca_t.ecca900, #变更序
       ecca901 LIKE ecca_t.ecca901, #变更类型
       ecca902 LIKE ecca_t.ecca902, #变更日期
       ecca905 LIKE ecca_t.ecca905, #变更理由
       ecca906 LIKE ecca_t.ecca906 #变更备注
END RECORD
#161124-00048#2     2016/12/06 By 08734 add(E)
   #DEFINE l_detail    RECORD LIKE eccb_t.*  #161124-00048#2     2016/12/06 By 08734 mark
   #161124-00048#2     2016/12/06 By 08734 add(S)
   DEFINE l_detail RECORD  #料件製程變更單身檔
       eccbent LIKE eccb_t.eccbent, #企业编号
       eccbsite LIKE eccb_t.eccbsite, #营运据点
       eccbdocno LIKE eccb_t.eccbdocno, #申请单号
       eccb001 LIKE eccb_t.eccb001, #工艺料号
       eccb002 LIKE eccb_t.eccb002, #工艺编号
       eccb003 LIKE eccb_t.eccb003, #项次
       eccb004 LIKE eccb_t.eccb004, #本站作业
       eccb005 LIKE eccb_t.eccb005, #作业序
       eccb006 LIKE eccb_t.eccb006, #群组性质
       eccb007 LIKE eccb_t.eccb007, #群组
       eccb008 LIKE eccb_t.eccb008, #上站作业
       eccb009 LIKE eccb_t.eccb009, #上站作业序
       eccb010 LIKE eccb_t.eccb010, #下站作业
       eccb011 LIKE eccb_t.eccb011, #下站作业序
       eccb012 LIKE eccb_t.eccb012, #工作站
       eccb013 LIKE eccb_t.eccb013, #允许委外
       eccb014 LIKE eccb_t.eccb014, #主要加工厂
       eccb015 LIKE eccb_t.eccb015, #Move in
       eccb016 LIKE eccb_t.eccb016, #Check in
       eccb017 LIKE eccb_t.eccb017, #报工站
       eccb018 LIKE eccb_t.eccb018, #PQC
       eccb019 LIKE eccb_t.eccb019, #Check out
       eccb020 LIKE eccb_t.eccb020, #Move out
       eccb021 LIKE eccb_t.eccb021, #转出单位
       eccb022 LIKE eccb_t.eccb022, #转出单位转换率分子
       eccb023 LIKE eccb_t.eccb023, #转出单位转换率分母
       eccb024 LIKE eccb_t.eccb024, #固定工时
       eccb025 LIKE eccb_t.eccb025, #标准工时
       eccb026 LIKE eccb_t.eccb026, #固定机时
       eccb027 LIKE eccb_t.eccb027, #标准机时
       eccb028 LIKE eccb_t.eccb028, #完成度
       eccb029 LIKE eccb_t.eccb029, #标准单价
       eccb030 LIKE eccb_t.eccb030, #转入单位
       eccb031 LIKE eccb_t.eccb031, #转入单位转换分子
       eccb032 LIKE eccb_t.eccb032, #转入单位转换分母
       eccb033 LIKE eccb_t.eccb033, #回收站
       eccb034 LIKE eccb_t.eccb034, #后置时间
       eccb035 LIKE eccb_t.eccb035, #X轴
       eccb036 LIKE eccb_t.eccb036, #Y轴
       eccb900 LIKE eccb_t.eccb900, #变更序
       eccb901 LIKE eccb_t.eccb901, #变更类型
       eccb902 LIKE eccb_t.eccb902, #变更日期
       eccb905 LIKE eccb_t.eccb905, #变更理由
       eccb906 LIKE eccb_t.eccb906 #变更备注
END RECORD
#161124-00048#2     2016/12/06 By 08734 add(E)
 
   #DEFINE l_detail2    RECORD LIKE eccc_t.*  #161124-00048#2     2016/12/06 By 08734 mark
   #161124-00048#2     2016/12/06 By 08734 add(S)
   DEFINE l_detail2 RECORD  #料件製程變更用料底稿
       ecccent LIKE eccc_t.ecccent, #企业编号
       ecccsite LIKE eccc_t.ecccsite, #营运据点
       ecccdocno LIKE eccc_t.ecccdocno, #申请单号
       eccc001 LIKE eccc_t.eccc001, #工艺料号
       eccc002 LIKE eccc_t.eccc002, #工艺编号
       eccc003 LIKE eccc_t.eccc003, #工艺项次
       eccc004 LIKE eccc_t.eccc004, #项次
       eccc005 LIKE eccc_t.eccc005, #元件料号
       eccc006 LIKE eccc_t.eccc006, #部位
       eccc007 LIKE eccc_t.eccc007, #组成用量
       eccc008 LIKE eccc_t.eccc008, #主件底数
       eccc009 LIKE eccc_t.eccc009, #用量单位
       eccc010 LIKE eccc_t.eccc010, #损耗率形态
       eccc900 LIKE eccc_t.eccc900, #变更序
       eccc901 LIKE eccc_t.eccc901, #变更类型
       eccc902 LIKE eccc_t.eccc902, #变更日期
       eccc905 LIKE eccc_t.eccc905, #变更理由
       eccc906 LIKE eccc_t.eccc906 #变更备注
END RECORD
#161124-00048#2     2016/12/06 By 08734 add(E)
 
 
   DEFINE l_cnt       LIKE type_t.num5
   #add-point:reproduce段define

   #end add-point   
 
   #切換畫面
   IF g_main_hidden THEN
      CALL gfrm_curr.setElementHidden("mainlayout",0)
      CALL gfrm_curr.setElementHidden("worksheet",1)
      LET g_main_hidden = 0
   END IF
   
   LET g_master_insert = FALSE
   
   IF g_ecca_m.eccasite IS NULL
   OR g_ecca_m.eccadocno IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code   = "std-00003" 
      LET g_errparam.popup  = FALSE 
      CALL cl_err()
      RETURN
   END IF
    
   LET g_eccasite_t = g_ecca_m.eccasite
   LET g_eccadocno_t = g_ecca_m.eccadocno
 
    
   LET g_ecca_m.eccasite = ""
   LET g_ecca_m.eccadocno = ""
 
    
   CALL aect801_set_entry('a')
   CALL aect801_set_no_entry('a')
 
   CALL cl_set_head_visible("","YES")
 
   #公用欄位給予預設值
   #此段落由子樣板a14產生    
      #公用欄位新增給值
      LET g_ecca_m.eccaownid = g_user
      LET g_ecca_m.eccaowndp = g_dept
      LET g_ecca_m.eccacrtid = g_user
      LET g_ecca_m.eccacrtdp = g_dept 
      LET g_ecca_m.eccacrtdt = cl_get_current()
      LET g_ecca_m.eccamodid = ""
      LET g_ecca_m.eccamoddt = ""
      LET g_ecca_m.eccastus = "N"
 
 
   
   CALL s_transaction_begin()
   
   #add-point:複製輸入前

   #end add-point
   
   #顯示狀態(stus)圖片
         #此段落由子樣板a21產生
	  #根據狀態碼顯示對應圖片
      CASE g_ecca_m.eccastus
         WHEN "A"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/approved.png")
         WHEN "D"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/withdraw.png")
         WHEN "N"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/unconfirmed.png")
         WHEN "R"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/rejection.png")
         WHEN "W"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/signing.png")
         WHEN "X"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/invalid.png")
         WHEN "Y"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/confirmed.png")   
         
      END CASE
 
 
   
   CALL aect801_input("r")
   
   
   
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
      LET INT_FLAG = 0
      INITIALIZE g_ecca_m.* TO NULL
      INITIALIZE g_eccb_d TO NULL
      INITIALIZE g_eccb2_d TO NULL
 
      #add-point:複製取消後

      #end add-point
      CALL aect801_show()
      RETURN
   END IF
   
   #根據資料狀態切換action狀態
   CALL cl_set_act_visible("statechange,modify,modify_detail,delete,reproduce", TRUE)
   CALL aect801_set_act_visible()   
   CALL aect801_set_act_no_visible()
   
   #將新增的資料併入搜尋條件中
   LET g_eccasite_t = g_ecca_m.eccasite
   LET g_eccadocno_t = g_ecca_m.eccadocno
   
   LET g_state = 'Y'
   
   #組合新增資料的條件
   LET g_add_browse = " eccaent = '" ||g_enterprise|| "' AND",
                      " eccasite = '", g_ecca_m.eccasite, "' "
                      ," AND eccadocno = '", g_ecca_m.eccadocno, "' "
 
   #填到最後面
   LET g_current_idx = g_browser.getLength() + 1
   CALL aect801_browser_fill("")
   
   DISPLAY g_browser_cnt TO FORMONLY.h_count    #總筆數
   DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
   CALL cl_navigator_setting(g_current_idx, g_browser_cnt)
   
   #add-point:完成複製段落後

   #end add-point
   
   CALL aect801_idx_chk()
   
END FUNCTION
 
{</section>}
 
{<section id="aect801.detail_reproduce" >}
#+ 單身自動複製
PRIVATE FUNCTION aect801_detail_reproduce()
   DEFINE ls_sql      STRING
   DEFINE ld_date     DATETIME YEAR TO SECOND
   #DEFINE l_detail    RECORD LIKE eccb_t.*  #161124-00048#2     2016/12/06 By 08734 mark
   #161124-00048#2     2016/12/06 By 08734 add(S)
   DEFINE l_detail RECORD  #料件製程變更單身檔
       eccbent LIKE eccb_t.eccbent, #企业编号
       eccbsite LIKE eccb_t.eccbsite, #营运据点
       eccbdocno LIKE eccb_t.eccbdocno, #申请单号
       eccb001 LIKE eccb_t.eccb001, #工艺料号
       eccb002 LIKE eccb_t.eccb002, #工艺编号
       eccb003 LIKE eccb_t.eccb003, #项次
       eccb004 LIKE eccb_t.eccb004, #本站作业
       eccb005 LIKE eccb_t.eccb005, #作业序
       eccb006 LIKE eccb_t.eccb006, #群组性质
       eccb007 LIKE eccb_t.eccb007, #群组
       eccb008 LIKE eccb_t.eccb008, #上站作业
       eccb009 LIKE eccb_t.eccb009, #上站作业序
       eccb010 LIKE eccb_t.eccb010, #下站作业
       eccb011 LIKE eccb_t.eccb011, #下站作业序
       eccb012 LIKE eccb_t.eccb012, #工作站
       eccb013 LIKE eccb_t.eccb013, #允许委外
       eccb014 LIKE eccb_t.eccb014, #主要加工厂
       eccb015 LIKE eccb_t.eccb015, #Move in
       eccb016 LIKE eccb_t.eccb016, #Check in
       eccb017 LIKE eccb_t.eccb017, #报工站
       eccb018 LIKE eccb_t.eccb018, #PQC
       eccb019 LIKE eccb_t.eccb019, #Check out
       eccb020 LIKE eccb_t.eccb020, #Move out
       eccb021 LIKE eccb_t.eccb021, #转出单位
       eccb022 LIKE eccb_t.eccb022, #转出单位转换率分子
       eccb023 LIKE eccb_t.eccb023, #转出单位转换率分母
       eccb024 LIKE eccb_t.eccb024, #固定工时
       eccb025 LIKE eccb_t.eccb025, #标准工时
       eccb026 LIKE eccb_t.eccb026, #固定机时
       eccb027 LIKE eccb_t.eccb027, #标准机时
       eccb028 LIKE eccb_t.eccb028, #完成度
       eccb029 LIKE eccb_t.eccb029, #标准单价
       eccb030 LIKE eccb_t.eccb030, #转入单位
       eccb031 LIKE eccb_t.eccb031, #转入单位转换分子
       eccb032 LIKE eccb_t.eccb032, #转入单位转换分母
       eccb033 LIKE eccb_t.eccb033, #回收站
       eccb034 LIKE eccb_t.eccb034, #后置时间
       eccb035 LIKE eccb_t.eccb035, #X轴
       eccb036 LIKE eccb_t.eccb036, #Y轴
       eccb900 LIKE eccb_t.eccb900, #变更序
       eccb901 LIKE eccb_t.eccb901, #变更类型
       eccb902 LIKE eccb_t.eccb902, #变更日期
       eccb905 LIKE eccb_t.eccb905, #变更理由
       eccb906 LIKE eccb_t.eccb906 #变更备注
END RECORD
#161124-00048#2     2016/12/06 By 08734 add(E)
 
   #DEFINE l_detail2    RECORD LIKE eccc_t.*  #161124-00048#2     2016/12/06 By 08734 mark
   #161124-00048#2     2016/12/06 By 08734 add(S)
   DEFINE l_detail2 RECORD  #料件製程變更用料底稿
       ecccent LIKE eccc_t.ecccent, #企业编号
       ecccsite LIKE eccc_t.ecccsite, #营运据点
       ecccdocno LIKE eccc_t.ecccdocno, #申请单号
       eccc001 LIKE eccc_t.eccc001, #工艺料号
       eccc002 LIKE eccc_t.eccc002, #工艺编号
       eccc003 LIKE eccc_t.eccc003, #工艺项次
       eccc004 LIKE eccc_t.eccc004, #项次
       eccc005 LIKE eccc_t.eccc005, #元件料号
       eccc006 LIKE eccc_t.eccc006, #部位
       eccc007 LIKE eccc_t.eccc007, #组成用量
       eccc008 LIKE eccc_t.eccc008, #主件底数
       eccc009 LIKE eccc_t.eccc009, #用量单位
       eccc010 LIKE eccc_t.eccc010, #损耗率形态
       eccc900 LIKE eccc_t.eccc900, #变更序
       eccc901 LIKE eccc_t.eccc901, #变更类型
       eccc902 LIKE eccc_t.eccc902, #变更日期
       eccc905 LIKE eccc_t.eccc905, #变更理由
       eccc906 LIKE eccc_t.eccc906 #变更备注
END RECORD
#161124-00048#2     2016/12/06 By 08734 add(E)
 
 
   #add-point:delete段define

   #end add-point    
   
   CALL s_transaction_begin()
   
   LET ld_date = cl_get_current()
   
   DROP TABLE aect801_detail
   
   #add-point:單身複製前1

   #end add-point
   
   #CREATE TEMP TABLE
   LET ls_sql = "CREATE GLOBAL TEMPORARY TABLE aect801_detail AS ",
                "SELECT * FROM eccb_t "
   PREPARE repro_tbl FROM ls_sql
   EXECUTE repro_tbl
   FREE repro_tbl
                
   #將符合條件的資料丟入TEMP TABLE
   INSERT INTO aect801_detail SELECT * FROM eccb_t 
                                         WHERE eccbent = g_enterprise AND eccbsite = g_eccasite_t
                                         AND eccbdocno = g_eccadocno_t
 
   
   #將key修正為調整後   
   UPDATE aect801_detail 
      #更新key欄位
      SET eccbsite = g_ecca_m.eccasite
          , eccbdocno = g_ecca_m.eccadocno
 
      #更新共用欄位
      
 
   #add-point:單身修改前

   #end add-point                                       
  
   #將資料塞回原table   
   INSERT INTO eccb_t SELECT * FROM aect801_detail
   
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "reproduce" 
      LET g_errparam.code   = SQLCA.sqlcode 
      LET g_errparam.popup  = TRUE 
      CALL cl_err()
 
      RETURN
   END IF
   
   #add-point:單身複製中1

   #end add-point
   
   #刪除TEMP TABLE
   DROP TABLE aect801_detail
   
   #add-point:單身複製後1

   #end add-point
 
 
   
   #add-point:單身複製前

   #end add-point
   
   #CREATE TEMP TABLE
   LET ls_sql = 
      "CREATE GLOBAL TEMPORARY TABLE aect801_detail AS ",
      "SELECT * FROM eccc_t "
   PREPARE repro_tbl2 FROM ls_sql
   EXECUTE repro_tbl2
   FREE repro_tbl2
      
   #將符合條件的資料丟入TEMP TABLE
   INSERT INTO aect801_detail SELECT * FROM eccc_t
                                         WHERE ecccent = g_enterprise AND ecccsite = g_eccasite_t
                                         AND ecccdocno = g_eccadocno_t
 
 
   #將key修正為調整後   
   UPDATE aect801_detail SET ecccsite = g_ecca_m.eccasite
                                       , ecccdocno = g_ecca_m.eccadocno
 
  
   #將資料塞回原table   
   INSERT INTO eccc_t SELECT * FROM aect801_detail
   
   #add-point:單身複製中

   #end add-point
   
   #刪除TEMP TABLE
   DROP TABLE aect801_detail
   
   #add-point:單身複製後

   #end add-point
 
 
   
   #多語言複製段落
   
   
   CALL s_transaction_end('Y','0')
   
   #已新增完, 調整資料內容(修改時使用)
   LET g_eccasite_t = g_ecca_m.eccasite
   LET g_eccadocno_t = g_ecca_m.eccadocno
 
   
END FUNCTION
 
{</section>}
 
{<section id="aect801.delete" >}
#+ 資料刪除
PRIVATE FUNCTION aect801_delete()
   DEFINE  l_var_keys      DYNAMIC ARRAY OF STRING
   DEFINE  l_field_keys    DYNAMIC ARRAY OF STRING
   DEFINE  l_vars          DYNAMIC ARRAY OF STRING
   DEFINE  l_fields        DYNAMIC ARRAY OF STRING
   DEFINE  l_var_keys_bak  DYNAMIC ARRAY OF STRING
   #add-point:delete段define
   
   #end add-point     
   
   IF g_ecca_m.eccasite IS NULL
   OR g_ecca_m.eccadocno IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code   = "std-00003" 
      LET g_errparam.popup  = FALSE 
      CALL cl_err()
      RETURN
   END IF
   
   
 
   CALL aect801_show()
   
   CALL s_transaction_begin()
 
   OPEN aect801_cl USING g_enterprise,g_ecca_m.eccasite,g_ecca_m.eccadocno
   IF STATUS THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "OPEN aect801_cl:" 
      LET g_errparam.code   = STATUS 
      LET g_errparam.popup  = TRUE 
      CALL cl_err()
      CLOSE aect801_cl
      CALL s_transaction_end('N','0')
      RETURN
   END IF
 
   #顯示最新的資料
   EXECUTE aect801_master_referesh USING g_ecca_m.eccasite,g_ecca_m.eccadocno INTO g_ecca_m.eccadocno, 
       g_ecca_m.ecca001,g_ecca_m.eccadocdt,g_ecca_m.ecca004,g_ecca_m.ecca002,g_ecca_m.eccasite,g_ecca_m.ecca003, 
       g_ecca_m.ecca900,g_ecca_m.ecca905,g_ecca_m.ecca906,g_ecca_m.eccastus,g_ecca_m.eccaownid,g_ecca_m.eccaowndp, 
       g_ecca_m.eccacrtid,g_ecca_m.eccacrtdp,g_ecca_m.eccacrtdt,g_ecca_m.eccamodid,g_ecca_m.eccamoddt, 
       g_ecca_m.eccacnfid,g_ecca_m.eccacnfdt,g_ecca_m.ecca001_desc,g_ecca_m.ecca905_desc,g_ecca_m.eccaownid_desc, 
       g_ecca_m.eccaowndp_desc,g_ecca_m.eccacrtid_desc,g_ecca_m.eccacrtdp_desc,g_ecca_m.eccamodid_desc, 
       g_ecca_m.eccacnfid_desc
 
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = g_ecca_m.eccasite 
      LET g_errparam.code   = SQLCA.sqlcode 
      LET g_errparam.popup  = FALSE 
      CALL cl_err()
      CALL s_transaction_end('N','0')
      RETURN
   END IF
   
   #add-point:delete段before ask
   #170213-00014#1-S
   #IF g_ecca_m.eccastus <> 'N' THEN
   #   INITIALIZE g_errparam TO NULL
   #   LET g_errparam.code = 'apm-00034'
   #   LET g_errparam.extend = g_ecca_m.eccastus
   #   LET g_errparam.popup = TRUE
   #   CALL cl_err()
   #   CALL s_transaction_end('N','0')
   #   RETURN
   #END IF
   #170213-00014#1-E
   #end add-point 
 
   IF cl_ask_del_master() THEN              #確認一下
   
      #add-point:單頭刪除前
      
      #end add-point   
      
      #+ 此段落由子樣板a47產生
      #刪除相關文件
      CALL aect801_set_pk_array()
      #add-point:相關文件刪除前
      
      #end add-point   
      CALL cl_doc_remove()  
 
  
  
      #資料備份
      LET g_eccasite_t = g_ecca_m.eccasite
      LET g_eccadocno_t = g_ecca_m.eccadocno
 
 
      DELETE FROM ecca_t
       WHERE eccaent = g_enterprise AND eccasite = g_ecca_m.eccasite
         AND eccadocno = g_ecca_m.eccadocno
 
       
      #add-point:單頭刪除中
      
      #end add-point
       
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = g_ecca_m.eccasite 
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = FALSE 
         CALL cl_err()
 
         CALL s_transaction_end('N','0')
         RETURN
      END IF
      
      #add-point:單頭刪除後
      IF NOT s_aooi200_del_docno(g_ecca_m.eccadocno,g_ecca_m.eccadocdt) THEN
         CALL s_transaction_end('N','0')
         RETURN
      END IF
      #end add-point
  
      #add-point:單身刪除前
      
      #end add-point
      
      DELETE FROM eccb_t
       WHERE eccbent = g_enterprise AND eccbsite = g_ecca_m.eccasite
         AND eccbdocno = g_ecca_m.eccadocno
 
 
      #add-point:單身刪除中
      
      #end add-point
         
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "eccb_t" 
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = FALSE 
         CALL cl_err()
         CALL s_transaction_end('N','0')
         RETURN
      END IF    
 
      #add-point:單身刪除後
      
      #end add-point
      
            
                                                               
 
 
      #add-point:單身刪除前
      
      #end add-point
      DELETE FROM eccc_t
       WHERE ecccent = g_enterprise AND
             ecccsite = g_ecca_m.eccasite AND ecccdocno = g_ecca_m.eccadocno
      #add-point:單身刪除中
      
      #end add-point
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "eccc_t" 
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = FALSE 
         CALL cl_err()
 
         CALL s_transaction_end('N','0')
         RETURN
      END IF      
 
      #add-point:單身刪除後
      DELETE FROM eccd_t
       WHERE eccdent = g_enterprise AND
             eccdsite = g_ecca_m.eccasite AND eccddocno = g_ecca_m.eccadocno
      #add-point:單身刪除中

      #end add-point
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "eccd_t" 
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = FALSE 
         CALL cl_err()
 
         CALL s_transaction_end('N','0')
         RETURN
      END IF   
      
      DELETE FROM ecce_t
       WHERE ecceent = g_enterprise 
         AND eccesite = g_site 
         AND eccedocno = g_ecca_m.eccadocno
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "ecce_t"
         LET g_errparam.popup = TRUE
         CALL cl_err()

         CALL s_transaction_end('N','0')
         RETURN   
      END IF
      
      DELETE FROM eccf_t
       WHERE eccfent = g_enterprise 
         AND eccfsite = g_site 
         AND eccfdocno = g_ecca_m.eccadocno
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "eccf_t"
         LET g_errparam.popup = TRUE
         CALL cl_err()

         CALL s_transaction_end('N','0')
         RETURN  
      END IF
      DELETE FROM eccg_t
       WHERE eccgent = g_enterprise 
         AND eccgsite = g_site 
         AND eccgdocno = g_ecca_m.eccadocno
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "eccg_t"
         LET g_errparam.popup = TRUE
         CALL cl_err()

         CALL s_transaction_end('N','0')
         RETURN
      END IF
      
      DELETE FROM ecch_t
       WHERE ecchent = g_enterprise 
         AND ecchsite = g_site 
         AND ecchdocno = g_ecca_m.eccadocno
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "ecch_t"
         LET g_errparam.popup = TRUE
         CALL cl_err()

         CALL s_transaction_end('N','0')
         RETURN
      END IF
      
      CALL g_eccb3_d.clear()      
      #end add-point
 
 
                                                               
      CLEAR FORM
      CALL g_eccb_d.clear() 
      CALL g_eccb2_d.clear()       
 
     
      CALL aect801_ui_browser_refresh()  
      #CALL aect801_ui_headershow()  
      #CALL aect801_ui_detailshow()
      
      IF g_browser_cnt > 0 THEN 
         #CALL aect801_browser_fill("")
         CALL aect801_fetch('P')
         DISPLAY g_browser_cnt TO FORMONLY.h_count   #總筆數的顯示
         DISPLAY g_browser_cnt TO FORMONLY.b_count   #總筆數的顯示
      ELSE
         CLEAR FORM
      END IF
 
      #add-point:多語言刪除
      
      #end add-point
      
      #單頭多語言刪除
      
      
      #單身多語言刪除
      
 
      
 
 
   
      #add-point:多語言刪除
      
      #end add-point
   
   END IF
 
   CALL s_transaction_end('Y','0')
   
   CLOSE aect801_cl
 
   #流程通知預埋點-D
   CALL cl_flow_notify(g_ecca_m.eccasite,'D')
    
END FUNCTION
 
{</section>}
 
{<section id="aect801.b_fill" >}
#+ 單身陣列填充
PRIVATE FUNCTION aect801_b_fill()
   DEFINE p_wc2      STRING
   #add-point:b_fill段define

   #end add-point     
 
   CALL g_eccb_d.clear()    #g_eccb_d 單頭及單身 
   CALL g_eccb2_d.clear()
 
 
   #add-point:b_fill段sql_before

   #end add-point
   
   #判斷是否填充
   IF aect801_fill_chk(1) THEN
   
      LET g_sql = "SELECT  UNIQUE eccb003,eccb004,eccb005,eccb006,eccb007,eccb008,eccb009,eccb010,eccb011, 
          eccb012,eccb024,eccb025,eccb026,eccb027,eccb034,eccb013,eccb014,eccb015,eccb016,eccb017,eccb018, 
          eccb019,eccb020,eccb030,eccb031,eccb032,eccb021,eccb022,eccb023,eccb033,eccb028,eccb029,eccb035, 
          eccb036,eccb901,eccb905,eccb906,eccb001,eccb002,eccb900,eccb902 ,t1.oocql004 ,t2.oocql004 , 
          t3.oocql004 ,t4.ecaa002 ,t5.pmaal004 ,t6.oocal003 ,t7.oocal003 ,t8.oocql004 FROM eccb_t",  
            
                  " INNER JOIN ecca_t ON eccasite = eccbsite ",
                  " AND eccadocno = eccbdocno ",
 
                  #"",
                  " LEFT JOIN eccc_t ON eccbent = ecccent AND eccbsite = ecccsite AND eccbdocno = ecccdocno AND eccb003 = eccc003 ",
                  "",
                                 " LEFT JOIN oocql_t t1 ON t1.oocqlent='"||g_enterprise||"' AND t1.oocql001='221' AND t1.oocql002=eccb004 AND t1.oocql003='"||g_dlang||"' ",
               " LEFT JOIN oocql_t t2 ON t2.oocqlent='"||g_enterprise||"' AND t2.oocql001='221' AND t2.oocql002=eccb008 AND t2.oocql003='"||g_dlang||"' ",
               " LEFT JOIN oocql_t t3 ON t3.oocqlent='"||g_enterprise||"' AND t3.oocql001='221' AND t3.oocql002=eccb010 AND t3.oocql003='"||g_dlang||"' ",
               " LEFT JOIN ecaa_t t4 ON t4.ecaaent='"||g_enterprise||"' AND t4.ecaasite='"||g_site||"' AND t4.ecaa001=eccb012  ",
               " LEFT JOIN pmaal_t t5 ON t5.pmaalent='"||g_enterprise||"' AND t5.pmaal001=eccb014 AND t5.pmaal002='"||g_dlang||"' ",
               " LEFT JOIN oocal_t t6 ON t6.oocalent='"||g_enterprise||"' AND t6.oocal001=eccb030 AND t6.oocal002='"||g_dlang||"' ",
               " LEFT JOIN oocal_t t7 ON t7.oocalent='"||g_enterprise||"' AND t7.oocal001=eccb021 AND t7.oocal002='"||g_dlang||"' ",
               " LEFT JOIN oocql_t t8 ON t8.oocqlent='"||g_enterprise||"' AND t8.oocql001='215' AND t8.oocql002=eccb905 AND t8.oocql003='"||g_dlang||"' ",
 
                  " WHERE eccbent=? AND eccbsite=? AND eccbdocno=?"
      LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
      #add-point:b_fill段sql_before

      #end add-point
      IF NOT cl_null(g_wc2_table1) THEN
         LET g_sql = g_sql CLIPPED, " AND ", g_wc2_table1 CLIPPED
      END IF
      
      #子單身的WC
         IF NOT cl_null(g_wc2_table2) THEN 
      LET g_sql = g_sql CLIPPED," AND ", g_wc2_table2 CLIPPED
   END IF 
 
      
      LET g_sql = g_sql, " ORDER BY eccb_t.eccb003"
      
      #add-point:單身填充控制

      #end add-point
      
      LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
      PREPARE aect801_pb FROM g_sql
      DECLARE b_fill_cs CURSOR FOR aect801_pb
      
      LET g_cnt = l_ac
      LET l_ac = 1
      
      OPEN b_fill_cs USING g_enterprise,g_ecca_m.eccasite,g_ecca_m.eccadocno
                                               
      FOREACH b_fill_cs INTO g_eccb_d[l_ac].eccb003,g_eccb_d[l_ac].eccb004,g_eccb_d[l_ac].eccb005,g_eccb_d[l_ac].eccb006, 
          g_eccb_d[l_ac].eccb007,g_eccb_d[l_ac].eccb008,g_eccb_d[l_ac].eccb009,g_eccb_d[l_ac].eccb010, 
          g_eccb_d[l_ac].eccb011,g_eccb_d[l_ac].eccb012,g_eccb_d[l_ac].eccb024,g_eccb_d[l_ac].eccb025, 
          g_eccb_d[l_ac].eccb026,g_eccb_d[l_ac].eccb027,g_eccb_d[l_ac].eccb034,g_eccb_d[l_ac].eccb013, 
          g_eccb_d[l_ac].eccb014,g_eccb_d[l_ac].eccb015,g_eccb_d[l_ac].eccb016,g_eccb_d[l_ac].eccb017, 
          g_eccb_d[l_ac].eccb018,g_eccb_d[l_ac].eccb019,g_eccb_d[l_ac].eccb020,g_eccb_d[l_ac].eccb030, 
          g_eccb_d[l_ac].eccb031,g_eccb_d[l_ac].eccb032,g_eccb_d[l_ac].eccb021,g_eccb_d[l_ac].eccb022, 
          g_eccb_d[l_ac].eccb023,g_eccb_d[l_ac].eccb033,g_eccb_d[l_ac].eccb028,g_eccb_d[l_ac].eccb029, 
          g_eccb_d[l_ac].eccb035,g_eccb_d[l_ac].eccb036,g_eccb_d[l_ac].eccb901,g_eccb_d[l_ac].eccb905, 
          g_eccb_d[l_ac].eccb906,g_eccb_d[l_ac].eccb001,g_eccb_d[l_ac].eccb002,g_eccb_d[l_ac].eccb900, 
          g_eccb_d[l_ac].eccb902,g_eccb_d[l_ac].eccb004_desc,g_eccb_d[l_ac].eccb008_desc,g_eccb_d[l_ac].eccb010_desc, 
          g_eccb_d[l_ac].eccb012_desc,g_eccb_d[l_ac].eccb014_desc,g_eccb_d[l_ac].eccb030_desc,g_eccb_d[l_ac].eccb021_desc, 
          g_eccb_d[l_ac].eccb905_desc
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "FOREACH:" 
            LET g_errparam.code   = SQLCA.sqlcode 
            LET g_errparam.popup  = TRUE 
            CALL cl_err()
            EXIT FOREACH
         END IF
        
         #add-point:b_fill段資料填充
         CALL aect801_eccb_color()
         #end add-point
      
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
      LET g_error_show = 0
   
   END IF
   
 
   
   #add-point:browser_fill段其他table處理

   #end add-point
   
   CALL g_eccb_d.deleteElement(g_eccb_d.getLength())
   CALL g_eccb2_d.deleteElement(g_eccb2_d.getLength())
 
   
 
   LET l_ac = g_cnt
   LET g_cnt = 0  
   
   FREE aect801_pb
 
   
END FUNCTION
 
{</section>}
 
{<section id="aect801.delete_b" >}
#+ 刪除單身後其他table連動
PRIVATE FUNCTION aect801_delete_b(ps_table,ps_keys_bak,ps_page)
   DEFINE ps_table    STRING
   DEFINE ps_page     STRING
   DEFINE ps_keys_bak DYNAMIC ARRAY OF VARCHAR(500)
   DEFINE ls_group    STRING
   DEFINE li_idx      LIKE type_t.num10   #161108-00012#1 num5==》num10
   #add-point:delete_b段define

   #end add-point     
 
   #判斷是否是同一群組的table
   LET ls_group = "'1',"
   IF ls_group.getIndexOf(ps_page,1) > 0 THEN
      #add-point:delete_b段刪除前

      #end add-point    
      DELETE FROM eccb_t
       WHERE eccbent = g_enterprise AND
         eccbsite = ps_keys_bak[1] AND eccbdocno = ps_keys_bak[2] AND eccb003 = ps_keys_bak[3]
      #add-point:delete_b段刪除中

      #end add-point    
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "" 
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = FALSE 
         CALL cl_err()
      END IF
      
      LET li_idx = g_detail_idx
      
      #add-point:delete_b段刪除後

      #end add-point   
   END IF
   
 
   
   LET ls_group = "'2',"
   #判斷是否是同一群組的table2
   IF ls_group.getIndexOf(ps_page,1) > 0 THEN
      #add-point:delete_b段刪除前

      #end add-point    
      DELETE FROM eccc_t
       WHERE ecccent = g_enterprise AND
             ecccsite = ps_keys_bak[1] AND ecccdocno = ps_keys_bak[2] AND eccc003 = ps_keys_bak[3] AND eccc004 = ps_keys_bak[4]
      #add-point:delete_b段刪除中

      #end add-point    
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "eccc_t" 
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = FALSE 
         CALL cl_err()
      END IF
    
      LET li_idx = g_detail_idx2
      
      #add-point:delete_b段刪除後

      #end add-point    
   END IF
 
 
   
   #add-point:delete_b段other

   #end add-point  
   
END FUNCTION
 
{</section>}
 
{<section id="aect801.insert_b" >}
#+ 新增單身後其他table連動
PRIVATE FUNCTION aect801_insert_b(ps_table,ps_keys,ps_page)
   DEFINE ps_table    STRING
   DEFINE ps_page     STRING
   DEFINE ps_keys     DYNAMIC ARRAY OF VARCHAR(500)
   DEFINE ls_group    STRING
   DEFINE ls_page     STRING
   DEFINE li_idx      LIKE type_t.num10  #161108-00012#1 num5==》num10
   #add-point:insert_b段define

   #end add-point     
   
   #判斷是否是同一群組的table
   LET ls_group = "'1',"
   IF ls_group.getIndexOf(ps_page,1) > 0 THEN
      #add-point:insert_b段資料新增前

      #end add-point 
      INSERT INTO eccb_t
                  (eccbent,
                   eccbsite,eccbdocno,
                   eccb003
                   ,eccb004,eccb005,eccb006,eccb007,eccb008,eccb009,eccb010,eccb011,eccb012,eccb024,eccb025,eccb026,eccb027,eccb034,eccb013,eccb014,eccb015,eccb016,eccb017,eccb018,eccb019,eccb020,eccb030,eccb031,eccb032,eccb021,eccb022,eccb023,eccb033,eccb028,eccb029,eccb035,eccb036,eccb901,eccb905,eccb906,eccb001,eccb002,eccb900,eccb902) 
            VALUES(g_enterprise,
                   ps_keys[1],ps_keys[2],ps_keys[3]
                   ,g_eccb_d[g_detail_idx].eccb004,g_eccb_d[g_detail_idx].eccb005,g_eccb_d[g_detail_idx].eccb006, 
                       g_eccb_d[g_detail_idx].eccb007,g_eccb_d[g_detail_idx].eccb008,g_eccb_d[g_detail_idx].eccb009, 
                       g_eccb_d[g_detail_idx].eccb010,g_eccb_d[g_detail_idx].eccb011,g_eccb_d[g_detail_idx].eccb012, 
                       g_eccb_d[g_detail_idx].eccb024,g_eccb_d[g_detail_idx].eccb025,g_eccb_d[g_detail_idx].eccb026, 
                       g_eccb_d[g_detail_idx].eccb027,g_eccb_d[g_detail_idx].eccb034,g_eccb_d[g_detail_idx].eccb013, 
                       g_eccb_d[g_detail_idx].eccb014,g_eccb_d[g_detail_idx].eccb015,g_eccb_d[g_detail_idx].eccb016, 
                       g_eccb_d[g_detail_idx].eccb017,g_eccb_d[g_detail_idx].eccb018,g_eccb_d[g_detail_idx].eccb019, 
                       g_eccb_d[g_detail_idx].eccb020,g_eccb_d[g_detail_idx].eccb030,g_eccb_d[g_detail_idx].eccb031, 
                       g_eccb_d[g_detail_idx].eccb032,g_eccb_d[g_detail_idx].eccb021,g_eccb_d[g_detail_idx].eccb022, 
                       g_eccb_d[g_detail_idx].eccb023,g_eccb_d[g_detail_idx].eccb033,g_eccb_d[g_detail_idx].eccb028, 
                       g_eccb_d[g_detail_idx].eccb029,g_eccb_d[g_detail_idx].eccb035,g_eccb_d[g_detail_idx].eccb036, 
                       g_eccb_d[g_detail_idx].eccb901,g_eccb_d[g_detail_idx].eccb905,g_eccb_d[g_detail_idx].eccb906, 
                       g_eccb_d[g_detail_idx].eccb001,g_eccb_d[g_detail_idx].eccb002,g_eccb_d[g_detail_idx].eccb900, 
                       g_eccb_d[g_detail_idx].eccb902)
      #add-point:insert_b段資料新增中

      #end add-point 
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "eccb_t" 
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = FALSE 
         CALL cl_err()
      END IF
      
      LET li_idx = g_detail_idx
      
      #add-point:insert_b段資料新增後

      #end add-point 
   END IF
   
 
   
   LET ls_group = "'2',"
   #判斷是否是同一群組的table
   IF ls_group.getIndexOf(ps_page,1) > 0 THEN
      #add-point:insert_b段資料新增前

      #end add-point 
      INSERT INTO eccc_t
                  (ecccent,
                   ecccsite,ecccdocno,eccc003,
                   eccc004
                   ,eccc005,eccc006,eccc007,eccc008,eccc009,eccc010,eccc901,eccc905,eccc906,eccc001,eccc002,eccc900,eccc902) 
            VALUES(g_enterprise,
                   ps_keys[1],ps_keys[2],ps_keys[3],ps_keys[4]
                   ,g_eccb2_d[g_detail_idx2].eccc005,g_eccb2_d[g_detail_idx2].eccc006,g_eccb2_d[g_detail_idx2].eccc007, 
                       g_eccb2_d[g_detail_idx2].eccc008,g_eccb2_d[g_detail_idx2].eccc009,g_eccb2_d[g_detail_idx2].eccc010, 
                       g_eccb2_d[g_detail_idx2].eccc901,g_eccb2_d[g_detail_idx2].eccc905,g_eccb2_d[g_detail_idx2].eccc906, 
                       g_eccb2_d[g_detail_idx2].eccc001,g_eccb2_d[g_detail_idx2].eccc002,g_eccb2_d[g_detail_idx2].eccc900, 
                       g_eccb2_d[g_detail_idx2].eccc902)
      #add-point:insert_b段資料新增中

      #end add-point
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "eccc_t" 
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = FALSE 
         CALL cl_err()
 
      END IF
      
      LET li_idx = g_detail_idx2
      
      #add-point:insert_b段資料新增後

      #end add-point
   END IF
 
 
   
   #add-point:insert_b段other

   #end add-point     
   
END FUNCTION
 
{</section>}
 
{<section id="aect801.update_b" >}
#+ 修改單身後其他table連動
PRIVATE FUNCTION aect801_update_b(ps_table,ps_keys,ps_keys_bak,ps_page)
   DEFINE ps_table         STRING
   DEFINE ps_page          STRING
   DEFINE ps_keys          DYNAMIC ARRAY OF VARCHAR(500)
   DEFINE ps_keys_bak      DYNAMIC ARRAY OF VARCHAR(500)
   DEFINE ls_group         STRING
   DEFINE li_idx           LIKE type_t.num10   #161108-00012#1 num5==》num10
   DEFINE lb_chk           BOOLEAN
   DEFINE l_new_key        DYNAMIC ARRAY OF STRING
   DEFINE l_old_key        DYNAMIC ARRAY OF STRING
   DEFINE l_field_key      DYNAMIC ARRAY OF STRING
   #add-point:update_b段define

   #end add-point     
   
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
   IF ls_group.getIndexOf(ps_page,1) > 0 AND ps_table <> "eccb_t" THEN
      #add-point:update_b段修改前

      #end add-point     
      UPDATE eccb_t 
         SET (eccbsite,eccbdocno,
              eccb003
              ,eccb004,eccb005,eccb006,eccb007,eccb008,eccb009,eccb010,eccb011,eccb012,eccb024,eccb025,eccb026,eccb027,eccb034,eccb013,eccb014,eccb015,eccb016,eccb017,eccb018,eccb019,eccb020,eccb030,eccb031,eccb032,eccb021,eccb022,eccb023,eccb033,eccb028,eccb029,eccb035,eccb036,eccb901,eccb905,eccb906,eccb001,eccb002,eccb900,eccb902) 
              = 
             (ps_keys[1],ps_keys[2],ps_keys[3]
              ,g_eccb_d[g_detail_idx].eccb004,g_eccb_d[g_detail_idx].eccb005,g_eccb_d[g_detail_idx].eccb006, 
                  g_eccb_d[g_detail_idx].eccb007,g_eccb_d[g_detail_idx].eccb008,g_eccb_d[g_detail_idx].eccb009, 
                  g_eccb_d[g_detail_idx].eccb010,g_eccb_d[g_detail_idx].eccb011,g_eccb_d[g_detail_idx].eccb012, 
                  g_eccb_d[g_detail_idx].eccb024,g_eccb_d[g_detail_idx].eccb025,g_eccb_d[g_detail_idx].eccb026, 
                  g_eccb_d[g_detail_idx].eccb027,g_eccb_d[g_detail_idx].eccb034,g_eccb_d[g_detail_idx].eccb013, 
                  g_eccb_d[g_detail_idx].eccb014,g_eccb_d[g_detail_idx].eccb015,g_eccb_d[g_detail_idx].eccb016, 
                  g_eccb_d[g_detail_idx].eccb017,g_eccb_d[g_detail_idx].eccb018,g_eccb_d[g_detail_idx].eccb019, 
                  g_eccb_d[g_detail_idx].eccb020,g_eccb_d[g_detail_idx].eccb030,g_eccb_d[g_detail_idx].eccb031, 
                  g_eccb_d[g_detail_idx].eccb032,g_eccb_d[g_detail_idx].eccb021,g_eccb_d[g_detail_idx].eccb022, 
                  g_eccb_d[g_detail_idx].eccb023,g_eccb_d[g_detail_idx].eccb033,g_eccb_d[g_detail_idx].eccb028, 
                  g_eccb_d[g_detail_idx].eccb029,g_eccb_d[g_detail_idx].eccb035,g_eccb_d[g_detail_idx].eccb036, 
                  g_eccb_d[g_detail_idx].eccb901,g_eccb_d[g_detail_idx].eccb905,g_eccb_d[g_detail_idx].eccb906, 
                  g_eccb_d[g_detail_idx].eccb001,g_eccb_d[g_detail_idx].eccb002,g_eccb_d[g_detail_idx].eccb900, 
                  g_eccb_d[g_detail_idx].eccb902) 
         WHERE eccbent = g_enterprise AND eccbsite = ps_keys_bak[1] AND eccbdocno = ps_keys_bak[2] AND eccb003 = ps_keys_bak[3]
      #add-point:update_b段修改中

      #end add-point   
      CASE
         WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "eccb_t" 
            LET g_errparam.code   = "std-00009" 
            LET g_errparam.popup  = TRUE 
            CALL cl_err()
            CALL s_transaction_end('N','0')
         WHEN SQLCA.sqlcode #其他錯誤
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "eccb_t" 
            LET g_errparam.code   = SQLCA.sqlcode 
            LET g_errparam.popup  = TRUE 
            CALL cl_err()
 
            CALL s_transaction_end('N','0')
         OTHERWISE
            
      END CASE
      #add-point:update_b段修改後

      #end add-point  
   END IF
   
 
   
   LET ls_group = "'2',"
   #判斷是否是同一群組的table
   IF ls_group.getIndexOf(ps_page,1) > 0 AND ps_table <> "eccc_t" THEN
      #add-point:update_b段修改前

      #end add-point     
      UPDATE eccc_t 
         SET (ecccsite,ecccdocno,eccc003,
              eccc004
              ,eccc005,eccc006,eccc007,eccc008,eccc009,eccc010,eccc901,eccc905,eccc906,eccc001,eccc002,eccc900,eccc902) 
              = 
             (ps_keys[1],ps_keys[2],ps_keys[3],ps_keys[4]
              ,g_eccb2_d[g_detail_idx2].eccc005,g_eccb2_d[g_detail_idx2].eccc006,g_eccb2_d[g_detail_idx2].eccc007, 
                  g_eccb2_d[g_detail_idx2].eccc008,g_eccb2_d[g_detail_idx2].eccc009,g_eccb2_d[g_detail_idx2].eccc010, 
                  g_eccb2_d[g_detail_idx2].eccc901,g_eccb2_d[g_detail_idx2].eccc905,g_eccb2_d[g_detail_idx2].eccc906, 
                  g_eccb2_d[g_detail_idx2].eccc001,g_eccb2_d[g_detail_idx2].eccc002,g_eccb2_d[g_detail_idx2].eccc900, 
                  g_eccb2_d[g_detail_idx2].eccc902) 
         WHERE ecccent = g_enterprise AND ecccsite = ps_keys_bak[1] AND ecccdocno = ps_keys_bak[2] AND eccc003 = ps_keys_bak[3] AND eccc004 = ps_keys_bak[4]
      #add-point:update_b段修改中

      #end add-point  
      CASE
         WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "eccc_t" 
            LET g_errparam.code   = "std-00009" 
            LET g_errparam.popup  = TRUE 
            CALL cl_err()
            CALL s_transaction_end('N','0')
         WHEN SQLCA.sqlcode #其他錯誤
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "eccc_t" 
            LET g_errparam.code   = SQLCA.sqlcode 
            LET g_errparam.popup  = TRUE 
            CALL cl_err()
 
            CALL s_transaction_end('N','0')
         OTHERWISE
            
      END CASE
      #add-point:update_b段修改後

      #end add-point  
   END IF
 
 
   
   #add-point:update_b段other

   #end add-point  
   
END FUNCTION
 
{</section>}
 
{<section id="aect801.lock_b" >}
#+ 連動lock其他單身table資料
PRIVATE FUNCTION aect801_lock_b(ps_table,ps_page)
   DEFINE ps_page     STRING
   DEFINE ps_table    STRING
   DEFINE ls_group    STRING
   #add-point:lock_b段define
   
   #end add-point   
   
   #先刷新資料
   #CALL aect801_b_fill()
   
   #鎖定整組table
   #LET ls_group = "'1',"
   #僅鎖定自身table
   LET ls_group = "eccb_t"
   
   IF ls_group.getIndexOf(ps_table,1) THEN
      OPEN aect801_bcl USING g_enterprise,
                                       g_ecca_m.eccasite,g_ecca_m.eccadocno,g_eccb_d[g_detail_idx].eccb003  
                                               
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "aect801_bcl" 
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = TRUE 
         CALL cl_err()
 
         RETURN FALSE
      END IF
   END IF
                                    
 
   
   #鎖定整組table
   #LET ls_group = "'2',"
   #僅鎖定自身table
   LET ls_group = "eccc_t"
   IF ls_group.getIndexOf(ps_table,1) THEN
   
      OPEN aect801_bcl2 USING g_enterprise,
                                             g_ecca_m.eccasite,g_ecca_m.eccadocno,g_eccb_d[g_detail_idx].eccb003, 
 
                                             g_eccb2_d[g_detail_idx2].eccc004
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "aect801_bcl2" 
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = TRUE 
         CALL cl_err()
 
         RETURN FALSE
      END IF
   END IF
 
 
   
   #add-point:lock_b段other
   
   #end add-point  
   
   RETURN TRUE
 
END FUNCTION
 
{</section>}
 
{<section id="aect801.unlock_b" >}
#+ 連動unlock其他單身table資料
PRIVATE FUNCTION aect801_unlock_b(ps_table,ps_page)
   DEFINE ps_page     STRING
   DEFINE ps_table    STRING
   DEFINE ls_group    STRING
   #add-point:unlock_b段define
   
   #end add-point  
   
   LET ls_group = "'1',"
   
   IF ls_group.getIndexOf(ps_page,1) THEN
      CLOSE aect801_bcl
   END IF
   
 
   
   LET ls_group = "'2',"
   
   IF ls_group.getIndexOf(ps_page,1) THEN
      CLOSE aect801_bcl2
   END IF
 
 
 
   #add-point:unlock_b段other
   
   #end add-point  
 
END FUNCTION
 
{</section>}
 
{<section id="aect801.set_entry" >}
#+ 單頭欄位開啟設定
PRIVATE FUNCTION aect801_set_entry(p_cmd)
   DEFINE p_cmd   LIKE type_t.chr1  
   #add-point:set_entry段define
   
   #end add-point       
 
   IF p_cmd = 'a' THEN
      CALL cl_set_comp_entry("eccasite,eccadocno",TRUE)
      #add-point:set_entry段欄位控制
      
      #end add-point  
   END IF
   
   #add-point:set_entry段欄位控制後
   CALL cl_set_comp_entry("ecca001,ecca002",TRUE)
   #end add-point 
 
END FUNCTION
 
{</section>}
 
{<section id="aect801.set_no_entry" >}
#+ 單頭欄位關閉設定
PRIVATE FUNCTION aect801_set_no_entry(p_cmd)
   DEFINE p_cmd   LIKE type_t.chr1   
   #add-point:set_no_entry段define
   
   #end add-point     
 
   IF p_cmd = 'u' AND g_chkey = 'N' THEN
      CALL cl_set_comp_entry("eccasite,eccadocno",FALSE)
      #add-point:set_no_entry段欄位控制
      
      #end add-point 
   END IF 
   
   #add-point:set_no_entry段欄位控制後
   IF g_ecca_m.ecca004 = '2' THEN
      CALL cl_set_comp_entry("ecca001,ecca002",FALSE)
   END IF
   #end add-point 
 
END FUNCTION
 
{</section>}
 
{<section id="aect801.set_entry_b" >}
#+ 單身欄位開啟設定
PRIVATE FUNCTION aect801_set_entry_b(p_cmd)
   DEFINE p_cmd   LIKE type_t.chr1   
   #add-point:set_entry_b段define
   
   #end add-point     
   
   IF p_cmd = 'a' THEN
      CALL cl_set_comp_entry("",TRUE)
      #add-point:set_entry段欄位控制
      
      #end add-point  
   END IF
   
   #add-point:set_entry_b段
   CALL cl_set_comp_entry("eccb007,eccb009",TRUE)
   #end add-point  
END FUNCTION
 
{</section>}
 
{<section id="aect801.set_no_entry_b" >}
#+ 單身欄位關閉設定
PRIVATE FUNCTION aect801_set_no_entry_b(p_cmd)
   DEFINE p_cmd   LIKE type_t.chr1   
   #add-point:set_no_entry_b段define
   DEFINE l_n     LIKE type_t.num5
   #end add-point    
   
   IF p_cmd = 'u' AND g_chkey = 'N' THEN
      CALL cl_set_comp_entry("",FALSE)
      #add-point:set_no_entry_b段欄位控制
      
      #end add-point 
   END IF 
   
   #add-point:set_no_entry_b段
   IF NOT (g_eccb_d[l_ac].eccb006 = '2' OR g_eccb_d[l_ac].eccb006 = '3') THEN
      CALL cl_set_comp_entry("eccb007",FALSE)
      LET g_eccb_d[l_ac].eccb007 = ""
   END IF
   
   IF g_eccb_d[l_ac].eccb008 = 'INIT' OR g_eccb_d[l_ac].eccb008 = 'MULT' THEN
      LET g_eccb_d[l_ac].eccb009 = 0
      CALL cl_set_comp_entry("eccb009",FALSE)
   END IF
   LET l_n = 0 
   SELECT COUNT(*) INTO l_n
     FROM eccb_t
    WHERE eccbent = g_enterprise
      AND eccbsite = g_site
      AND eccbdocno = g_ecca_m.eccadocno
      AND eccb007 = g_eccb_d[l_ac].eccb008
   IF l_n > 0 THEN
      LET g_eccb_d[l_ac].eccb009 = 0
      CALL cl_set_comp_entry("eccb009",FALSE)
   END IF
   #end add-point     
END FUNCTION
 
{</section>}
 
{<section id="aect801.set_act_visible" >}
#+ 單頭權限開啟
PRIVATE FUNCTION aect801_set_act_visible()
   #add-point:set_act_visible段define
   
   #end add-point   
   #add-point:set_act_visible段
   CALL cl_set_act_visible("modify,delete,modify_detail", TRUE)   #170213-00014#1
   #end add-point   
END FUNCTION
 
{</section>}
 
{<section id="aect801.set_act_no_visible" >}
#+ 單頭權限關閉
PRIVATE FUNCTION aect801_set_act_no_visible()
   #add-point:set_act_no_visible段define
   
   #end add-point   
   #add-point:set_act_no_visible段
   #170213-00014#1-S
   IF g_ecca_m.eccastus NOT MATCHES '[NDR]' THEN   # N未確認/D抽單/R已拒絕允許修改
      CALL cl_set_act_visible("modify,delete,modify_detail", FALSE)
   END IF
   #170213-00014#1-E
   #end add-point   
END FUNCTION
 
{</section>}
 
{<section id="aect801.set_act_visible_b" >}
#+ 單身權限開啟
PRIVATE FUNCTION aect801_set_act_visible_b()
   #add-point:set_act_visible_b段define
   
   #end add-point   
   #add-point:set_act_visible_b段
   
   #end add-point   
END FUNCTION
 
{</section>}
 
{<section id="aect801.set_act_no_visible_b" >}
#+ 單身權限關閉
PRIVATE FUNCTION aect801_set_act_no_visible_b()
   #add-point:set_act_no_visible_b段define
   
   #end add-point   
   #add-point:set_act_no_visible_b段
   
   #end add-point   
END FUNCTION
 
{</section>}
 
{<section id="aect801.default_search" >}
#+ 外部參數搜尋
PRIVATE FUNCTION aect801_default_search()
   DEFINE li_idx  LIKE type_t.num10  #161108-00012#1 num5==》num10
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
      LET ls_wc = ls_wc, " eccasite = '", g_argv[01], "' AND "
   END IF
   
   IF NOT cl_null(g_argv[02]) THEN
      LET ls_wc = ls_wc, " eccadocno = '", g_argv[02], "' AND "
   END IF
 
   
   #add-point:default_search段after sql

   #end add-point  
   
   IF NOT cl_null(ls_wc) THEN
      LET g_wc = ls_wc.subString(1,ls_wc.getLength()-5)
      LET g_default = TRUE
   ELSE
      #若無外部參數則預設為1=2
      LET g_default = FALSE
      #預設查詢條件
      LET g_wc = cl_qbe_get_default_qryplan()
      IF cl_null(g_wc) THEN
         LET g_wc = " 1=2"
      END IF
   END IF
   
   #add-point:default_search段結束前

   #end add-point  
 
   IF g_wc.getIndexOf(" 1=2", 1) THEN
      LET g_default = TRUE
   END IF
 
 
END FUNCTION
 
{</section>}
 
{<section id="aect801.state_change" >}
   #+ 此段落由子樣板a09產生
#+ 確認碼變更
PRIVATE FUNCTION aect801_statechange()
   DEFINE lc_state LIKE type_t.chr5
   #add-point:statechange段define

   #end add-point  
   
   #add-point:statechange段開始前
   IF g_ecca_m.eccastus MATCHES '[XY]' THEN
      RETURN
   END IF
   #end add-point  
   
   ERROR ""     #清空畫面右下側ERROR區塊
 
   IF g_ecca_m.eccasite IS NULL
      OR g_ecca_m.eccadocno IS NULL
   THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code   = "std-00003" 
      LET g_errparam.popup  = FALSE 
      CALL cl_err()
 
      RETURN
   END IF
 
   MENU "" ATTRIBUTES (STYLE="popup")
      BEFORE MENU
         HIDE OPTION "approved"
         HIDE OPTION "rejection"
         CASE g_ecca_m.eccastus
            WHEN "A"
               HIDE OPTION "approved"
            WHEN "D"
               HIDE OPTION "withdraw"
            WHEN "N"
               HIDE OPTION "unconfirmed"
            WHEN "R"
               HIDE OPTION "rejection"
            WHEN "W"
               HIDE OPTION "signing"
            WHEN "X"
               HIDE OPTION "invalid" 
            WHEN "Y"
               HIDE OPTION "confirmed" 
            
         END CASE
     
      #add-point:menu前
      CALL cl_set_act_visible("unconfirmed,confirmed,invalid",TRUE)
      #提交和抽單一開始先無條件關
      CALL cl_set_act_visible("signing,withdraw",FALSE)
      CASE g_ecca_m.eccastus
         WHEN "N"
            CALL cl_set_act_visible("unconfirmed,closed",FALSE)
            #需提交至BPM時，則顯示「提交」功能並隱藏「確認」功能
            IF cl_bpm_chk() THEN
               CALL cl_set_act_visible("signing",TRUE)
               CALL cl_set_act_visible("confirmed",FALSE)
            END IF

         #保留修改的功能(如作廢)，隱藏其他應用功能
         WHEN "R"
            CALL cl_set_act_visible("confirmed,unconfirmed",FALSE)

         WHEN "D"
            CALL cl_set_act_visible("confirmed,unconfirmed",FALSE)

         WHEN "X"
            CALL cl_set_act_visible("unconfirmed,confirmed,invalid",FALSE)

         WHEN "Y"
            CALL cl_set_act_visible("confirmed,invalid",FALSE)
            
         #只能顯示抽單;其餘應用功能皆隱藏
         WHEN "W"
             CALL cl_set_act_visible("withdraw",TRUE)
             CALL cl_set_act_visible("unconfirmed,confirmed,invalid",FALSE)

         WHEN "A"     #只能顯示確認; 其餘應用功能皆隱藏
             CALL cl_set_act_visible("confirmed ",TRUE)
             CALL cl_set_act_visible("unconfirmed,invalid",FALSE)

      END CASE
      #end add-point
      
      ON ACTION approved
         IF cl_auth_chk_act("approved") THEN
            LET lc_state = "A"
            #add-point:action控制

            #end add-point
         END IF
         EXIT MENU
      #ON ACTION withdraw
      #   IF cl_auth_chk_act("withdraw") THEN
      #      LET lc_state = "D"
      #      #add-point:action控制

      #      #end add-point
      #   END IF
      #   EXIT MENU
      ON ACTION unconfirmed
         IF cl_auth_chk_act("unconfirmed") THEN
            LET lc_state = "N"
            #add-point:action控制

            #end add-point
         END IF
         EXIT MENU
      ON ACTION rejection
         IF cl_auth_chk_act("rejection") THEN
            LET lc_state = "R"
            #add-point:action控制

            #end add-point
         END IF
         EXIT MENU
      #ON ACTION signing
      #   IF cl_auth_chk_act("signing") THEN
      #      LET lc_state = "W"
      #      #add-point:action控制

      #      #end add-point
      #   END IF
      #   EXIT MENU
      #170213-00014#1-S
      #ON ACTION invalid
      #   IF cl_auth_chk_act("invalid") THEN
      #      LET lc_state = "X"
      #      #add-point:action控制

      #      #end add-point
      #   END IF
      #   EXIT MENU
      #170213-00014#1-E
      ON ACTION confirmed
         IF cl_auth_chk_act("confirmed") THEN
            LET lc_state = "Y"
            #add-point:action控制
            CALL s_transaction_begin()
            IF NOT s_aect801_confirm_chk(g_ecca_m.eccadocno) THEN
               CALL s_transaction_end('N','0')
               RETURN
            ELSE
               IF NOT cl_ask_confirm('aim-00108') THEN
                  CALL s_transaction_end('N','0')
                  RETURN
               ELSE
                  IF NOT s_aect801_confirm_upd(g_ecca_m.eccadocno) THEN
                     CALL s_transaction_end('N','0')
                     RETURN
                  ELSE
                     CALL s_transaction_end('Y','0')
                  END IF
               END IF
            END IF
            #顯示最新的資料
            EXECUTE aect801_master_referesh USING g_ecca_m.eccasite,g_ecca_m.eccadocno INTO g_ecca_m.eccadocno, 
                g_ecca_m.ecca001,g_ecca_m.eccadocdt,g_ecca_m.ecca004,g_ecca_m.ecca002,g_ecca_m.eccasite,g_ecca_m.ecca003, 
                g_ecca_m.ecca900,g_ecca_m.ecca905,g_ecca_m.ecca906,g_ecca_m.eccastus,g_ecca_m.eccaownid,g_ecca_m.eccaowndp, 
                g_ecca_m.eccacrtid,g_ecca_m.eccacrtdp,g_ecca_m.eccacrtdt,g_ecca_m.eccamodid,g_ecca_m.eccamoddt, 
                g_ecca_m.eccacnfid,g_ecca_m.eccacnfdt,g_ecca_m.ecca001_desc,g_ecca_m.ecca905_desc,g_ecca_m.eccaownid_desc, 
                g_ecca_m.eccaowndp_desc,g_ecca_m.eccacrtid_desc,g_ecca_m.eccacrtdp_desc,g_ecca_m.eccamodid_desc, 
                g_ecca_m.eccacnfid_desc
            DISPLAY BY NAME g_ecca_m.eccadocno, 
                g_ecca_m.ecca001,g_ecca_m.eccadocdt,g_ecca_m.ecca004,g_ecca_m.ecca002,g_ecca_m.eccasite,g_ecca_m.ecca003, 
                g_ecca_m.ecca900,g_ecca_m.ecca905,g_ecca_m.ecca906,g_ecca_m.eccastus,g_ecca_m.eccaownid,g_ecca_m.eccaowndp, 
                g_ecca_m.eccacrtid,g_ecca_m.eccacrtdp,g_ecca_m.eccacrtdt,g_ecca_m.eccamodid,g_ecca_m.eccamoddt, 
                g_ecca_m.eccacnfid,g_ecca_m.eccacnfdt,g_ecca_m.ecca001_desc,g_ecca_m.ecca905_desc,g_ecca_m.eccaownid_desc, 
                g_ecca_m.eccaowndp_desc,g_ecca_m.eccacrtid_desc,g_ecca_m.eccacrtdp_desc,g_ecca_m.eccamodid_desc, 
                g_ecca_m.eccacnfid_desc
            #end add-point
         END IF
         EXIT MENU  
         
      #此段落由子樣板a36產生
      #提交
      ON ACTION signing
         IF cl_auth_chk_act("signing") THEN
            IF NOT aect801_send() THEN
               RETURN
            END IF
         END IF
         LET lc_state = ''   #因為_send()已有執行update動作
         
         EXIT MENU
 
      #抽單
      ON ACTION withdraw
         IF cl_auth_chk_act("withdraw") THEN
            IF NOT aect801_draw_out() THEN
               RETURN
            END IF
         END IF
         LET lc_state = ''   #因為_draw_out()已有執行update動作
         EXIT MENU
 
 
      #170213-00014#1-S
      ON ACTION invalid
         IF cl_auth_chk_act("invalid") THEN
            LET lc_state = "X"
            #add-point:action控制
 
            #end add-point
         END IF
         EXIT MENU
      #170213-00014#1-E
      
      #add-point:stus控制

      #end add-point
      
   END MENU
   
   IF (lc_state <> "A" 
      AND lc_state <> "D"
      AND lc_state <> "N"
      AND lc_state <> "R"
      AND lc_state <> "W"
      AND lc_state <> "X"
      AND lc_state <> "Y"
      ) OR 
      cl_null(lc_state) THEN
      RETURN
   END IF
   
   #add-point:stus修改前
   #151125-00001#1 add start ------------------
   IF lc_state = 'X' THEN
      IF NOT cl_ask_confirm('aim-00109') THEN
         RETURN
      END IF
   END IF
   #151125-00001#1 add end   ------------------
   #end add-point
      
   UPDATE ecca_t SET eccastus = lc_state 
    WHERE eccaent = g_enterprise AND eccasite = g_ecca_m.eccasite
      AND eccadocno = g_ecca_m.eccadocno
  
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code   = SQLCA.sqlcode 
      LET g_errparam.popup  = FALSE 
      CALL cl_err()
 
   ELSE
      CASE lc_state
         WHEN "A"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/approved.png")
         WHEN "D"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/withdraw.png")
         WHEN "N"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/unconfirmed.png")
         WHEN "R"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/rejection.png")
         WHEN "W"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/signing.png") 
         WHEN "X"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/invalid.png")  
         WHEN "Y"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/confirmed.png") 
         
      END CASE
      LET g_ecca_m.eccastus = lc_state
      DISPLAY BY NAME g_ecca_m.eccastus
   END IF
 
   #add-point:stus修改後

   #end add-point
 
   #add-point:statechange段結束前

   #end add-point  
 
END FUNCTION
 
 
 
{</section>}
 
{<section id="aect801.idx_chk" >}
#+ 顯示正確的單身資料筆數
PRIVATE FUNCTION aect801_idx_chk()
   #add-point:idx_chk段define
   
   #end add-point  
   
   IF g_current_page = 1 THEN
      LET g_detail_idx = g_curr_diag.getCurrentRow("s_detail1")
      IF g_detail_idx > g_eccb_d.getLength() THEN
         LET g_detail_idx = g_eccb_d.getLength()
      END IF
      IF g_detail_idx = 0 AND g_eccb_d.getLength() <> 0 THEN
         LET g_detail_idx = 1
      END IF
      DISPLAY g_detail_idx TO FORMONLY.idx
      DISPLAY g_eccb_d.getLength() TO FORMONLY.cnt
   END IF
   
   IF g_current_page = 2 THEN
      LET g_detail_idx2 = g_curr_diag.getCurrentRow("s_detail2")
      IF g_detail_idx2 > g_eccb2_d.getLength() THEN
         LET g_detail_idx2 = g_eccb2_d.getLength()
      END IF
      IF g_detail_idx2 = 0 AND g_eccb2_d.getLength() <> 0 THEN
         LET g_detail_idx2 = 1
      END IF
      DISPLAY g_detail_idx2 TO FORMONLY.idx
      DISPLAY g_eccb2_d.getLength() TO FORMONLY.cnt
   END IF
 
   
   #add-point:idx_chk段other
   
   #end add-point  
   
END FUNCTION
 
{</section>}
 
{<section id="aect801.b_fill2" >}
#+ 單身陣列填充2
PRIVATE FUNCTION aect801_b_fill2(pi_idx)
   DEFINE pi_idx          LIKE type_t.num10  #161108-00012#1 num5==》num10
   DEFINE li_ac           LIKE type_t.num10  #161108-00012#1 num5==》num10
   DEFINE ls_chk          LIKE type_t.chr1
   #add-point:b_fill2段define

   #end add-point
   
   LET li_ac = l_ac 
   
   IF g_detail_idx <= 0 THEN
      RETURN
   END IF
   
   IF aect801_fill_chk(2) THEN
      IF (pi_idx = 2 OR pi_idx = 0 ) AND g_eccb_d.getLength() > 0 THEN
               CALL g_eccb2_d.clear()
 
         LET g_sql = "SELECT  UNIQUE eccc004,eccc005,eccc006,eccc007,eccc008,eccc009,eccc010,eccc901, 
             eccc905,eccc906,eccc001,eccc002,eccc900,eccc902 ,t9.imaal003 ,t10.oocql004 ,t11.oocal003 , 
             t12.oocql004 FROM eccc_t",    
                     "",
                                    " LEFT JOIN imaal_t t9 ON t9.imaalent='"||g_enterprise||"' AND t9.imaal001=eccc005 AND t9.imaal002='"||g_dlang||"' ",
               " LEFT JOIN oocql_t t10 ON t10.oocqlent='"||g_enterprise||"' AND t10.oocql001='215' AND t10.oocql002=eccc006 AND t10.oocql003='"||g_dlang||"' ",
               " LEFT JOIN oocal_t t11 ON t11.oocalent='"||g_enterprise||"' AND t11.oocal001=eccc009 AND t11.oocal002='"||g_dlang||"' ",
               " LEFT JOIN oocql_t t12 ON t12.oocqlent='"||g_enterprise||"' AND t12.oocql001='225' AND t12.oocql002=eccc905 AND t12.oocql003='"||g_dlang||"' ",
 
                     " WHERE ecccent=? AND ecccsite=? AND ecccdocno=? AND eccc003=?"
         
         IF NOT cl_null(g_wc2_table2) THEN
            LET g_sql = g_sql CLIPPED," AND ",g_wc2_table2 CLIPPED
         END IF
         
         LET g_sql = g_sql, " ORDER BY  eccc_t.eccc004" 
                            
         #add-point:單身填充前

         #end add-point
         
         LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
         PREPARE aect801_pb2 FROM g_sql
         DECLARE b_fill_curs2 CURSOR FOR aect801_pb2
         
         OPEN b_fill_curs2 USING g_enterprise,g_ecca_m.eccasite,g_ecca_m.eccadocno,g_eccb_d[g_detail_idx].eccb003 
 
         LET l_ac = 1
         FOREACH b_fill_curs2 INTO g_eccb2_d[l_ac].eccc004,g_eccb2_d[l_ac].eccc005,g_eccb2_d[l_ac].eccc006, 
             g_eccb2_d[l_ac].eccc007,g_eccb2_d[l_ac].eccc008,g_eccb2_d[l_ac].eccc009,g_eccb2_d[l_ac].eccc010, 
             g_eccb2_d[l_ac].eccc901,g_eccb2_d[l_ac].eccc905,g_eccb2_d[l_ac].eccc906,g_eccb2_d[l_ac].eccc001, 
             g_eccb2_d[l_ac].eccc002,g_eccb2_d[l_ac].eccc900,g_eccb2_d[l_ac].eccc902,g_eccb2_d[l_ac].eccc005_desc, 
             g_eccb2_d[l_ac].eccc006_desc,g_eccb2_d[l_ac].eccc009_desc,g_eccb2_d[l_ac].eccc905_desc  
 
            IF SQLCA.sqlcode THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "FOREACH:" 
               LET g_errparam.code   = SQLCA.sqlcode 
               LET g_errparam.popup  = TRUE 
               CALL cl_err()
 
               EXIT FOREACH
            END IF
            
            #add-point:b_fill段資料填充
            CALL aect801_eccc_color()
            #end add-point
           
            IF l_ac > g_max_rec THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = l_ac
               LET g_errparam.code   = 9035 
               LET g_errparam.popup  = TRUE 
               CALL cl_err()
 
               EXIT FOREACH
            END IF
            
            LET l_ac = l_ac + 1
            
         END FOREACH
               CALL g_eccb2_d.deleteElement(g_eccb2_d.getLength())
 
      END IF
   END IF
 
 
      
   #add-point:單身填充後

   #end add-point
    
   LET l_ac = li_ac
   
   CALL aect801_detail_show()
   
END FUNCTION
 
{</section>}
 
{<section id="aect801.fill_chk" >}
#+ 單身填充確認
PRIVATE FUNCTION aect801_fill_chk(ps_idx)
   DEFINE ps_idx        LIKE type_t.chr10
   #add-point:fill_chk段define
   
   #end add-point
   
   #add-point:fill_chk段before_chk
   
   #end add-point
   
   #全部為1=1 or null時回傳true
   IF (cl_null(g_wc2_table1) OR g_wc2_table1.trim() = '1=1')  AND 
      (cl_null(g_wc2_table2) OR g_wc2_table2.trim() = '1=1') THEN
      #add-point:fill_chk段other_chk
      
      #end add-point
      RETURN TRUE
   END IF
   
   #第一單身
   IF ps_idx = 1 AND
      ((NOT cl_null(g_wc2_table1) AND g_wc2_table1.trim() <> '1=1')  OR 
      (NOT cl_null(g_wc2_table2) AND g_wc2_table2.trim() <> '1=1')) THEN
      RETURN TRUE
   END IF
   
   #根據wc判定是否需要填充
 
   IF ps_idx = 2 AND
      ((NOT cl_null(g_wc2_table1) AND g_wc2_table1.trim() <> '1=1') OR 
      (NOT cl_null(g_wc2_table2) AND g_wc2_table2.trim() <> '1=1')) THEN
      RETURN TRUE
   END IF
 
 
   
   #add-point:fill_chk段after_chk
   
   #end add-point
   
   RETURN FALSE
 
END FUNCTION
 
{</section>}
 
{<section id="aect801.signature" >}
   #此段落由子樣板a39產生
#+ BPM提交
PRIVATE FUNCTION aect801_send()
 
   #add-point:send段define

   #end add-point 
 
   IF g_ecca_m.eccasite IS NULL
   OR g_ecca_m.eccadocno IS NULL
   THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code   = "std-00003" 
      LET g_errparam.popup  = FALSE 
      CALL cl_err()
 
      RETURN FALSE
   END IF
 
   #重新取得與顯示完整單據資料(最新單據資料)
   EXECUTE aect801_master_referesh USING g_ecca_m.eccasite,g_ecca_m.eccadocno INTO g_ecca_m.eccadocno, 
       g_ecca_m.ecca001,g_ecca_m.eccadocdt,g_ecca_m.ecca004,g_ecca_m.ecca002,g_ecca_m.eccasite,g_ecca_m.ecca003, 
       g_ecca_m.ecca900,g_ecca_m.ecca905,g_ecca_m.ecca906,g_ecca_m.eccastus,g_ecca_m.eccaownid,g_ecca_m.eccaowndp, 
       g_ecca_m.eccacrtid,g_ecca_m.eccacrtdp,g_ecca_m.eccacrtdt,g_ecca_m.eccamodid,g_ecca_m.eccamoddt, 
       g_ecca_m.eccacnfid,g_ecca_m.eccacnfdt,g_ecca_m.ecca001_desc,g_ecca_m.ecca905_desc,g_ecca_m.eccaownid_desc, 
       g_ecca_m.eccaowndp_desc,g_ecca_m.eccacrtid_desc,g_ecca_m.eccacrtdp_desc,g_ecca_m.eccamodid_desc, 
       g_ecca_m.eccacnfid_desc
 
   ERROR ""
   
   CALL s_transaction_begin()
 
   OPEN aect801_cl USING g_enterprise,g_ecca_m.eccasite,g_ecca_m.eccadocno
   IF STATUS THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "OPEN aect801_cl:" 
      LET g_errparam.code   =  STATUS 
      LET g_errparam.popup  = TRUE 
      CALL cl_err()
 
      CLOSE aect801_cl
      CALL s_transaction_end('N','0')
      RETURN FALSE
   END IF
 
   #鎖住將被更改的資料
   FETCH aect801_cl INTO g_ecca_m.eccadocno,g_ecca_m.ecca001,g_ecca_m.oobxl003,g_ecca_m.ecca001_desc, 
       g_ecca_m.eccadocdt,g_ecca_m.ecca001_desc_1,g_ecca_m.ecca004,g_ecca_m.ecca002,g_ecca_m.eccasite, 
       g_ecca_m.ecca003,g_ecca_m.ecca900,g_ecca_m.ecca905,g_ecca_m.ecca905_desc,g_ecca_m.ecca906,g_ecca_m.eccastus, 
       g_ecca_m.eccaownid,g_ecca_m.eccaownid_desc,g_ecca_m.eccaowndp,g_ecca_m.eccaowndp_desc,g_ecca_m.eccacrtid, 
       g_ecca_m.eccacrtid_desc,g_ecca_m.eccacrtdp,g_ecca_m.eccacrtdp_desc,g_ecca_m.eccacrtdt,g_ecca_m.eccamodid, 
       g_ecca_m.eccamodid_desc,g_ecca_m.eccamoddt,g_ecca_m.eccacnfid,g_ecca_m.eccacnfid_desc,g_ecca_m.eccacnfdt 
 
   
   #資料被他人LOCK, 或是sql執行時出現錯誤
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = g_ecca_m.eccasite 
      LET g_errparam.code   = SQLCA.sqlcode 
      LET g_errparam.popup  = FALSE 
      CALL cl_err()
 
      CLOSE aect801_cl
      CALL s_transaction_end('N','0')
      RETURN FALSE
   END IF
 
   #依據單據個數，需要指定所有單身條件為" 1=1"  (單身有幾個就要設幾個)
   LET g_wc2_table1 = " 1=1"
 
 
   CALL aect801_show()
   CALL aect801_set_pk_array()
   
   #add-point: 提交前的ADP
   #170213-00014#1-S
   #確認前檢核段
   IF NOT s_aect801_confirm_chk(g_ecca_m.eccadocno) THEN
      CLOSE aect801_cl
      CALL s_transaction_end('N','0')
      RETURN FALSE
   END IF
   #170213-00014#1-E
   #end add-point
   
   #公用變數初始化
   CALL cl_bpm_data_init()
                  
   #依照主檔/單身個數產生 CALL cl_bpm_set_master_data() / cl_bpm_set_detail_data() 
   #單頭固定為 CALL cl_bpm_set_master_data(util.JSONObject.fromFGL(xxxx)) 傳入參數: (1)單頭陣列  ; 回傳值: 無
   CALL cl_bpm_set_master_data(util.JSONObject.fromFGL(g_ecca_m))
                              
   #單身固定為 CALL cl_bpm_set_detail_data(s_detailX, util.JSONArray.fromFGL(xxxx)) 傳入參數: (1)單身SR名稱  (2)單身陣列  ; 回傳值: 無
   CALL cl_bpm_set_detail_data("s_detail1", util.JSONArray.fromFGL(g_eccb_d))
   CALL cl_bpm_set_detail_data("s_detail2", util.JSONArray.fromFGL(g_eccb2_d))
   CALL cl_bpm_set_detail_data("s_detail3", util.JSONArray.fromFGL(g_eccb3_d))      #170213-00014#1
 
   # cl_bpm_cli() 裡有包含以前的aws_condition()=>送簽資料檢核和更新單據狀況碼為'W'
   # cl_bpm_cli() 傳入參數:無  ;  回傳值: 0 開單失敗; 1 開單成功
 
   #開單失敗
   IF NOT cl_bpm_cli() THEN 
      CLOSE aect801_cl
      CALL s_transaction_end('N','0')
      RETURN FALSE
   END IF
 
   #add-point: 提交後的ADP

   #end add-point
   
   #完成狀態更新
   CLOSE aect801_cl
   CALL s_transaction_end('Y','0')
             
   #此段落不需要刪除資料,但是否需要refresh圖片樣式???
   #CALL aect801_ui_browser_refresh()
 
   #重新指定此筆單據資料狀態圖片=>送簽中
   #170213-00014#1-S
   #LET g_browser[g_current_row].b_statepic = "stus/16/signing.png"
   LET g_browser[g_current_idx].b_statepic = "stus/16/signing.png"
   #170213-00014#1-E
 
   #重新取得單頭/單身資料,DISPLAY在畫面上
   CALL aect801_ui_headershow()
   CALL aect801_ui_detailshow()
 
   RETURN TRUE
   
END FUNCTION
 
 
#此段落由子樣板a40產生
#+ BPM抽單
PRIVATE FUNCTION aect801_draw_out()
 
   #add-point:draw段define

   #end add-point
 
   #檢查資料是否存在
   IF g_ecca_m.eccasite IS NULL
   OR g_ecca_m.eccadocno IS NULL
   THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code   = "std-00003" 
      LET g_errparam.popup  = FALSE 
      CALL cl_err()
 
      RETURN FALSE
   END IF
 
   #LOCK主檔資料
   CALL s_transaction_begin()
 
   #進行BPM抽單功能
   OPEN aect801_cl USING g_enterprise,g_ecca_m.eccasite,g_ecca_m.eccadocno
   IF STATUS THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "OPEN aect801_cl:" 
      LET g_errparam.code   =  STATUS 
      LET g_errparam.popup  = TRUE 
      CALL cl_err()
 
      CLOSE aect801_cl
      CALL s_transaction_end('N','0')
      RETURN FALSE
   END IF
 
   #鎖住將被更改的資料
   FETCH aect801_cl INTO g_ecca_m.eccadocno,g_ecca_m.ecca001,g_ecca_m.oobxl003,g_ecca_m.ecca001_desc, 
       g_ecca_m.eccadocdt,g_ecca_m.ecca001_desc_1,g_ecca_m.ecca004,g_ecca_m.ecca002,g_ecca_m.eccasite, 
       g_ecca_m.ecca003,g_ecca_m.ecca900,g_ecca_m.ecca905,g_ecca_m.ecca905_desc,g_ecca_m.ecca906,g_ecca_m.eccastus, 
       g_ecca_m.eccaownid,g_ecca_m.eccaownid_desc,g_ecca_m.eccaowndp,g_ecca_m.eccaowndp_desc,g_ecca_m.eccacrtid, 
       g_ecca_m.eccacrtid_desc,g_ecca_m.eccacrtdp,g_ecca_m.eccacrtdp_desc,g_ecca_m.eccacrtdt,g_ecca_m.eccamodid, 
       g_ecca_m.eccamodid_desc,g_ecca_m.eccamoddt,g_ecca_m.eccacnfid,g_ecca_m.eccacnfid_desc,g_ecca_m.eccacnfdt 
 
   
   #資料被他人LOCK, 或是sql執行時出現錯誤
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = g_ecca_m.eccasite 
      LET g_errparam.code   = SQLCA.sqlcode 
      LET g_errparam.popup  = FALSE 
      CALL cl_err()
 
      CLOSE aect801_cl
      CALL s_transaction_end('N','0')
      RETURN FALSE
   END IF
 
   #抽單失敗
   IF NOT cl_bpm_draw_out() THEN 
      CLOSE aect801_cl
      CALL s_transaction_end('N','0')
      RETURN FALSE
   END IF    
 
   #完成狀態更新
   CLOSE aect801_cl
   CALL s_transaction_end('Y','0')
          
   #重新指定此筆單據資料狀態圖片=>抽單 
   #170213-00014#1-S
   #LET g_browser[g_current_row].b_statepic = "stus/16/draw_out.png"
   LET g_browser[g_current_idx].b_statepic = "stus/16/draw_out.png"
   #170213-00014#1-E
   
   #重新取得單頭/單身資料,DISPLAY在畫面上
   CALL aect801_ui_headershow()  
   CALL aect801_ui_detailshow()
 
   RETURN TRUE
   
END FUNCTION
 
 
 
 
{</section>}
 
{<section id="aect801.set_pk_array" >}
   #+ 此段落由子樣板a51產生
#+ 給予pk_array內容
PRIVATE FUNCTION aect801_set_pk_array()
   #add-point:set_pk_array段define
   
   #end add-point
   
   #add-point:set_pk_array段之前
   
   #end add-point  
   
   CALL g_pk_array.clear()
   LET g_pk_array[1].values = g_ecca_m.eccasite
   LET g_pk_array[1].column = 'eccasite'
   LET g_pk_array[2].values = g_ecca_m.eccadocno
   LET g_pk_array[2].column = 'eccadocno'
   
   #add-point:set_pk_array段之後
   
   #end add-point  
   
END FUNCTION
 
 
 
{</section>}
 
{<section id="aect801.other_dialog" readonly="Y" >}
   
 
{</section>}
 
{<section id="aect801.other_function" readonly="Y" >}

#单头ref栏位显示
PRIVATE FUNCTION aect801_desc()
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_ecca_m.ecca001
   CALL ap_ref_array2(g_ref_fields,"SELECT imaal003,imaal004 FROM imaal_t WHERE imaalent='"||g_enterprise||"' AND imaal001=? AND imaal002='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_ecca_m.ecca001_desc = '', g_rtn_fields[1] , ''
   LET g_ecca_m.ecca001_desc_1 = '', g_rtn_fields[2] , ''
   DISPLAY BY NAME g_ecca_m.ecca001_desc,g_ecca_m.ecca001_desc_1
   
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_ecca_m.ecca905
   CALL ap_ref_array2(g_ref_fields,"SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001='"||g_acc||"' AND oocql002=? AND oocql003='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_ecca_m.ecca905_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_ecca_m.ecca905_desc
END FUNCTION

#根据录入的制程料号，制程编号自动带出制程相关资料
PRIVATE FUNCTION aect801_gen()
DEFINE r_success              LIKE type_t.num5

   LET r_success = FALSE
   #变更单单头资料，ecca_t
   IF NOT aect801_gen_ecca() THEN
      RETURN r_success
   END IF
   
   #制程变更单单身资料，eccb_t
   IF NOT aect801_gen_eccb() THEN
      RETURN r_success
   END IF

   #制程变更单用料底稿资料，eccc_t
   IF NOT aect801_gen_eccc() THEN
      RETURN r_success
   END IF
   
   #制程变更单用料底稿损耗率资料，eccd_t
   IF NOT aect801_gen_eccd() THEN
      RETURN r_success
   END IF
   
   #制程变更单上站作业资料，ecce_t
   IF NOT aect801_gen_ecce() THEN
      RETURN r_success
   END IF
   
   #制程变更单check in/check out资料，eccf_t
   IF NOT aect801_gen_eccf() THEN
      RETURN r_success
   END IF
   
   #制程变更单资源项目资料，eccg_t
   IF NOT aect801_gen_eccg() THEN
      RETURN r_success
   END IF
   
   LET r_success = TRUE
   RETURN r_success
END FUNCTION

#变更单单头资料，ecca_t
PRIVATE FUNCTION aect801_gen_ecca()
DEFINE r_success              LIKE type_t.num5
#DEFINE l_ecba                 RECORD LIKE ecba_t.* #161124-00048#2     2016/12/06 By 08734 mark
#161124-00048#2     2016/12/06 By 08734 add(S)
DEFINE l_ecba RECORD  #料件製程單頭檔
       ecbaent LIKE ecba_t.ecbaent, #企业编号
       ecbasite LIKE ecba_t.ecbasite, #营运据点
       ecbaownid LIKE ecba_t.ecbaownid, #资料所有者
       ecbaowndp LIKE ecba_t.ecbaowndp, #资料所有部门
       ecbacrtid LIKE ecba_t.ecbacrtid, #资料录入者
       ecbacrtdp LIKE ecba_t.ecbacrtdp, #资料录入部门
       ecbacrtdt LIKE ecba_t.ecbacrtdt, #资料创建日
       ecbamodid LIKE ecba_t.ecbamodid, #资料更改者
       ecbamoddt LIKE ecba_t.ecbamoddt, #最近更改日
       ecbacnfid LIKE ecba_t.ecbacnfid, #资料审核者
       ecbacnfdt LIKE ecba_t.ecbacnfdt, #数据审核日
       ecbastus LIKE ecba_t.ecbastus, #状态码
       ecba001 LIKE ecba_t.ecba001, #工艺料号
       ecba002 LIKE ecba_t.ecba002, #工艺编号
       ecba003 LIKE ecba_t.ecba003, #说明
       ecba004 LIKE ecba_t.ecba004, #起始X轴
       ecba005 LIKE ecba_t.ecba005, #起始Y轴
       ecba006 LIKE ecba_t.ecba006, #截止X轴
       ecba007 LIKE ecba_t.ecba007 #截止Y轴
END RECORD
#161124-00048#2     2016/12/06 By 08734 add(E)
#DEFINE l_ecca                 RECORD LIKE ecca_t.*  #161124-00048#2     2016/12/06 By 08734 mark
#161124-00048#2     2016/12/06 By 08734 add(S)
DEFINE l_ecca RECORD  #料件製程變更單頭檔
       eccaent LIKE ecca_t.eccaent, #企业编号
       eccaownid LIKE ecca_t.eccaownid, #资料所有者
       eccaowndp LIKE ecca_t.eccaowndp, #资料所有部门
       eccacrtid LIKE ecca_t.eccacrtid, #资料录入者
       eccacrtdp LIKE ecca_t.eccacrtdp, #资料录入部门
       eccacrtdt LIKE ecca_t.eccacrtdt, #资料创建日
       eccamodid LIKE ecca_t.eccamodid, #资料更改者
       eccamoddt LIKE ecca_t.eccamoddt, #最近更改日
       eccacnfid LIKE ecca_t.eccacnfid, #资料审核者
       eccacnfdt LIKE ecca_t.eccacnfdt, #数据审核日
       eccastus LIKE ecca_t.eccastus, #状态码
       eccasite LIKE ecca_t.eccasite, #营运据点
       eccadocno LIKE ecca_t.eccadocno, #申请单号
       eccadocdt LIKE ecca_t.eccadocdt, #申请日期
       ecca001 LIKE ecca_t.ecca001, #工艺料号
       ecca002 LIKE ecca_t.ecca002, #工艺编号
       ecca003 LIKE ecca_t.ecca003, #说明
       ecca004 LIKE ecca_t.ecca004, #申请类型
       ecca900 LIKE ecca_t.ecca900, #变更序
       ecca901 LIKE ecca_t.ecca901, #变更类型
       ecca902 LIKE ecca_t.ecca902, #变更日期
       ecca905 LIKE ecca_t.ecca905, #变更理由
       ecca906 LIKE ecca_t.ecca906 #变更备注
END RECORD
#161124-00048#2     2016/12/06 By 08734 add(E)
DEFINE l_eccacrtdt            DATETIME YEAR TO SECOND  #资料建立日期

   LET r_success = FALSE
   
  # SELECT * INTO l_ecba.* FROM ecba_t WHERE ecbaent = g_enterprise AND ecbasite = g_site  #161124-00048#2     2016/12/06 By 08734 mark
   SELECT ecbaent,ecbasite,ecbaownid,ecbaowndp,ecbacrtid,ecbacrtdp,ecbacrtdt,ecbamodid,ecbamoddt,ecbacnfid,ecbacnfdt,ecbastus,ecba001,ecba002,ecba003,ecba004,ecba005,ecba006,ecba007  #161124-00048#2     2016/12/06 By 08734 add
     INTO l_ecba.* FROM ecba_t WHERE ecbaent = g_enterprise AND ecbasite = g_site
      AND ecba001 = g_ecca_m.ecca001 AND ecba002 = g_ecca_m.ecca002
   LET l_ecca.eccaent = g_enterprise
   LET l_ecca.eccasite = g_site
   LET l_ecca.ecca001 = l_ecba.ecba001
   LET l_ecca.ecca002 = l_ecba.ecba002
   LET l_ecca.ecca003 = l_ecba.ecba003   
   LET l_ecca.eccadocno = g_ecca_m.eccadocno
   LET l_ecca.eccadocdt = g_ecca_m.eccadocdt
   LET l_ecca.ecca004 = g_ecca_m.ecca004
   LET l_ecca.ecca900 = g_ecca_m.ecca900
   LET l_ecca.ecca905 = g_ecca_m.ecca905
   LET l_ecca.ecca906 = g_ecca_m.ecca906
   LET l_ecca.eccaownid =  g_user
   LET l_ecca.eccaowndp =  g_dept
   LET l_ecca.eccacrtid =  g_user
   LET l_ecca.eccacrtdp =  g_dept 
   LET l_ecca.eccacrtdt =  ""
   LET l_ecca.eccamodid =  ""
   LET l_ecca.eccamoddt =  ""
   LET l_ecca.eccacnfid =  ""
   LET l_ecca.eccacnfdt =  ""
   LET l_ecca.eccastus  =  "N"
   LET l_ecca.ecca901 = 'N'      #未变更
   #INSERT INTO ecca_t VALUES l_ecca.* #161124-00048#2     2016/12/06 By 08734 mark
   INSERT INTO ecca_t(eccaent,eccaownid,eccaowndp,eccacrtid,eccacrtdp,eccacrtdt,eccamodid,eccamoddt,eccacnfid,eccacnfdt,eccastus,eccasite,eccadocno,eccadocdt,ecca001,ecca002,ecca003,ecca004,ecca900,ecca901,ecca902,ecca905,ecca906)  #161124-00048#2     2016/12/06 By 08734 add
      VALUES (l_ecca.eccaent,l_ecca.eccaownid,l_ecca.eccaowndp,l_ecca.eccacrtid,l_ecca.eccacrtdp,l_ecca.eccacrtdt,l_ecca.eccamodid,l_ecca.eccamoddt,l_ecca.eccacnfid,l_ecca.eccacnfdt,l_ecca.eccastus,l_ecca.eccasite,l_ecca.eccadocno,l_ecca.eccadocdt,l_ecca.ecca001,l_ecca.ecca002,l_ecca.ecca003,l_ecca.ecca004,l_ecca.ecca900,l_ecca.ecca901,l_ecca.ecca902,l_ecca.ecca905,l_ecca.ecca906)
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = 'INSERT ecca_t'
      LET g_errparam.popup = TRUE
      CALL cl_err()
      RETURN r_success
   END IF
   LET l_eccacrtdt =  cl_get_current()
   UPDATE ecca_t SET eccacrtdt = l_eccacrtdt WHERE eccaent = g_enterprise AND eccasite = g_site 
      AND eccadocno = l_ecca.eccadocno
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = 'UPDATE ecca_t'
      LET g_errparam.popup = TRUE
      CALL cl_err()
      RETURN r_success
   END IF
   LET r_success = TRUE
   RETURN r_success

END FUNCTION

#变更单单身档
PRIVATE FUNCTION aect801_gen_eccb()
DEFINE r_success              LIKE type_t.num5
#DEFINE l_ecbb                 RECORD LIKE ecbb_t.*  #161124-00048#2     2016/12/06 By 08734 mark
#161124-00048#2     2016/12/06 By 08734 add(S)
DEFINE l_ecbb RECORD  #料件製程單身檔
       ecbbent LIKE ecbb_t.ecbbent, #企业编号
       ecbbsite LIKE ecbb_t.ecbbsite, #营运据点
       ecbb001 LIKE ecbb_t.ecbb001, #工艺料号
       ecbb002 LIKE ecbb_t.ecbb002, #工艺编号
       ecbb003 LIKE ecbb_t.ecbb003, #项次
       ecbb004 LIKE ecbb_t.ecbb004, #本站作业
       ecbb005 LIKE ecbb_t.ecbb005, #作业序
       ecbb006 LIKE ecbb_t.ecbb006, #群组性质
       ecbb007 LIKE ecbb_t.ecbb007, #群组
       ecbb008 LIKE ecbb_t.ecbb008, #上站作业
       ecbb009 LIKE ecbb_t.ecbb009, #上站作业序
       ecbb010 LIKE ecbb_t.ecbb010, #下站作业
       ecbb011 LIKE ecbb_t.ecbb011, #下站作业序
       ecbb012 LIKE ecbb_t.ecbb012, #工作站
       ecbb013 LIKE ecbb_t.ecbb013, #允许委外
       ecbb014 LIKE ecbb_t.ecbb014, #主要加工厂
       ecbb015 LIKE ecbb_t.ecbb015, #Move in
       ecbb016 LIKE ecbb_t.ecbb016, #Check in
       ecbb017 LIKE ecbb_t.ecbb017, #报工站
       ecbb018 LIKE ecbb_t.ecbb018, #PQC
       ecbb019 LIKE ecbb_t.ecbb019, #Check out
       ecbb020 LIKE ecbb_t.ecbb020, #Move out
       ecbb021 LIKE ecbb_t.ecbb021, #转出单位
       ecbb022 LIKE ecbb_t.ecbb022, #转出单位转换率分子
       ecbb023 LIKE ecbb_t.ecbb023, #转出单位转换率分母
       ecbb024 LIKE ecbb_t.ecbb024, #固定工时
       ecbb025 LIKE ecbb_t.ecbb025, #标准工时
       ecbb026 LIKE ecbb_t.ecbb026, #固定机时
       ecbb027 LIKE ecbb_t.ecbb027, #标准机时
       ecbb028 LIKE ecbb_t.ecbb028, #完成度
       ecbb029 LIKE ecbb_t.ecbb029, #标准单价
       ecbb030 LIKE ecbb_t.ecbb030, #转入单位
       ecbb031 LIKE ecbb_t.ecbb031, #转入单位转换分子
       ecbb032 LIKE ecbb_t.ecbb032, #转入单位转换分母
       ecbb033 LIKE ecbb_t.ecbb033, #回收站
       ecbb034 LIKE ecbb_t.ecbb034, #后置时间
       ecbb035 LIKE ecbb_t.ecbb035, #X轴
       ecbb036 LIKE ecbb_t.ecbb036, #Y轴
       ecbb037 LIKE ecbb_t.ecbb037, #资源群组
       ecbb038 LIKE ecbb_t.ecbb038 #工具群组
END RECORD
#161124-00048#2     2016/12/06 By 08734 add(E)
#DEFINE l_eccb                 RECORD LIKE eccb_t.*  #161124-00048#2     2016/12/06 By 08734 mark
#161124-00048#2     2016/12/06 By 08734 add(S)
DEFINE l_eccb RECORD  #料件製程變更單身檔
       eccbent LIKE eccb_t.eccbent, #企业编号
       eccbsite LIKE eccb_t.eccbsite, #营运据点
       eccbdocno LIKE eccb_t.eccbdocno, #申请单号
       eccb001 LIKE eccb_t.eccb001, #工艺料号
       eccb002 LIKE eccb_t.eccb002, #工艺编号
       eccb003 LIKE eccb_t.eccb003, #项次
       eccb004 LIKE eccb_t.eccb004, #本站作业
       eccb005 LIKE eccb_t.eccb005, #作业序
       eccb006 LIKE eccb_t.eccb006, #群组性质
       eccb007 LIKE eccb_t.eccb007, #群组
       eccb008 LIKE eccb_t.eccb008, #上站作业
       eccb009 LIKE eccb_t.eccb009, #上站作业序
       eccb010 LIKE eccb_t.eccb010, #下站作业
       eccb011 LIKE eccb_t.eccb011, #下站作业序
       eccb012 LIKE eccb_t.eccb012, #工作站
       eccb013 LIKE eccb_t.eccb013, #允许委外
       eccb014 LIKE eccb_t.eccb014, #主要加工厂
       eccb015 LIKE eccb_t.eccb015, #Move in
       eccb016 LIKE eccb_t.eccb016, #Check in
       eccb017 LIKE eccb_t.eccb017, #报工站
       eccb018 LIKE eccb_t.eccb018, #PQC
       eccb019 LIKE eccb_t.eccb019, #Check out
       eccb020 LIKE eccb_t.eccb020, #Move out
       eccb021 LIKE eccb_t.eccb021, #转出单位
       eccb022 LIKE eccb_t.eccb022, #转出单位转换率分子
       eccb023 LIKE eccb_t.eccb023, #转出单位转换率分母
       eccb024 LIKE eccb_t.eccb024, #固定工时
       eccb025 LIKE eccb_t.eccb025, #标准工时
       eccb026 LIKE eccb_t.eccb026, #固定机时
       eccb027 LIKE eccb_t.eccb027, #标准机时
       eccb028 LIKE eccb_t.eccb028, #完成度
       eccb029 LIKE eccb_t.eccb029, #标准单价
       eccb030 LIKE eccb_t.eccb030, #转入单位
       eccb031 LIKE eccb_t.eccb031, #转入单位转换分子
       eccb032 LIKE eccb_t.eccb032, #转入单位转换分母
       eccb033 LIKE eccb_t.eccb033, #回收站
       eccb034 LIKE eccb_t.eccb034, #后置时间
       eccb035 LIKE eccb_t.eccb035, #X轴
       eccb036 LIKE eccb_t.eccb036, #Y轴
       eccb900 LIKE eccb_t.eccb900, #变更序
       eccb901 LIKE eccb_t.eccb901, #变更类型
       eccb902 LIKE eccb_t.eccb902, #变更日期
       eccb905 LIKE eccb_t.eccb905, #变更理由
       eccb906 LIKE eccb_t.eccb906 #变更备注
END RECORD
#161124-00048#2     2016/12/06 By 08734 add(E)

   LET r_success = FALSE
   DECLARE aect801_gen_eccb_cs CURSOR FOR
    #SELECT * FROM ecbb_t WHERE ecbbent = g_enterprise AND ecbbsite = g_site  #161124-00048#2     2016/12/06 By 08734 mark
    SELECT ecbbent,ecbbsite,ecbb001,ecbb002,ecbb003,ecbb004,ecbb005,ecbb006,ecbb007,ecbb008,ecbb009,ecbb010,ecbb011,ecbb012,ecbb013,ecbb014,ecbb015,ecbb016,ecbb017,ecbb018,ecbb019,ecbb020,ecbb021,ecbb022,ecbb023,ecbb024,ecbb025,ecbb026,ecbb027,ecbb028,ecbb029,ecbb030,ecbb031,ecbb032,ecbb033,ecbb034,ecbb035,ecbb036,ecbb037,ecbb038 #161124-00048#2     2016/12/06 By 08734 add
      FROM ecbb_t WHERE ecbbent = g_enterprise AND ecbbsite = g_site
       AND ecbb001 = g_ecca_m.ecca001 AND ecbb002 = g_ecca_m.ecca002
   FOREACH aect801_gen_eccb_cs INTO l_ecbb.*
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "FOREACH:"
         LET g_errparam.popup = TRUE
         CALL cl_err()
         EXIT FOREACH
      END IF
      
      LET l_eccb.eccbent = g_enterprise 
      LET l_eccb.eccbsite = g_site
      LET l_eccb.eccbdocno = g_ecca_m.eccadocno
      LET l_eccb.eccb001 = l_ecbb.ecbb001
      LET l_eccb.eccb002 = l_ecbb.ecbb002
      LET l_eccb.eccb003 = l_ecbb.ecbb003
      LET l_eccb.eccb004 = l_ecbb.ecbb004
      LET l_eccb.eccb005 = l_ecbb.ecbb005
      LET l_eccb.eccb006 = l_ecbb.ecbb006
      LET l_eccb.eccb007 = l_ecbb.ecbb007
      LET l_eccb.eccb008 = l_ecbb.ecbb008
      LET l_eccb.eccb009 = l_ecbb.ecbb009
      LET l_eccb.eccb010 = l_ecbb.ecbb010
      LET l_eccb.eccb011 = l_ecbb.ecbb011
      LET l_eccb.eccb012 = l_ecbb.ecbb012
      LET l_eccb.eccb013 = l_ecbb.ecbb013
      LET l_eccb.eccb014 = l_ecbb.ecbb014
      LET l_eccb.eccb015 = l_ecbb.ecbb015
      LET l_eccb.eccb016 = l_ecbb.ecbb016
      LET l_eccb.eccb017 = l_ecbb.ecbb017
      LET l_eccb.eccb018 = l_ecbb.ecbb018
      LET l_eccb.eccb019 = l_ecbb.ecbb019
      LET l_eccb.eccb020 = l_ecbb.ecbb020
      LET l_eccb.eccb021 = l_ecbb.ecbb021
      LET l_eccb.eccb022 = l_ecbb.ecbb022
      LET l_eccb.eccb023 = l_ecbb.ecbb023
      LET l_eccb.eccb024 = l_ecbb.ecbb024
      LET l_eccb.eccb025 = l_ecbb.ecbb025
      LET l_eccb.eccb026 = l_ecbb.ecbb026
      LET l_eccb.eccb027 = l_ecbb.ecbb027
      LET l_eccb.eccb028 = l_ecbb.ecbb028
      LET l_eccb.eccb029 = l_ecbb.ecbb029
      LET l_eccb.eccb030 = l_ecbb.ecbb030
      LET l_eccb.eccb031 = l_ecbb.ecbb031
      LET l_eccb.eccb032 = l_ecbb.ecbb032
      LET l_eccb.eccb033 = l_ecbb.ecbb033
      LET l_eccb.eccb034 = l_ecbb.ecbb034
      LET l_eccb.eccb035 = l_ecbb.ecbb035
      LET l_eccb.eccb036 = l_ecbb.ecbb036
      LET l_eccb.eccb900 = g_ecca_m.ecca900
      LET l_eccb.eccb901 = '1'
      
      #INSERT INTO eccb_t VALUES l_eccb.*  #161124-00048#2     2016/12/06 By 08734 mark
      INSERT INTO eccb_t(eccbent,eccbsite,eccbdocno,eccb001,eccb002,eccb003,eccb004,eccb005,eccb006,eccb007,eccb008,eccb009,eccb010,eccb011,eccb012,eccb013,eccb014,eccb015,eccb016,eccb017,eccb018,eccb019,eccb020,eccb021,eccb022,eccb023,eccb024,eccb025,eccb026,eccb027,eccb028,eccb029,eccb030,eccb031,eccb032,eccb033,eccb034,eccb035,eccb036,eccb900,eccb901,eccb902,eccb905,eccb906)  #161124-00048#2     2016/12/06 By 08734 add
        VALUES (l_eccb.eccbent,l_eccb.eccbsite,l_eccb.eccbdocno,l_eccb.eccb001,l_eccb.eccb002,l_eccb.eccb003,l_eccb.eccb004,l_eccb.eccb005,l_eccb.eccb006,l_eccb.eccb007,l_eccb.eccb008,l_eccb.eccb009,l_eccb.eccb010,l_eccb.eccb011,l_eccb.eccb012,l_eccb.eccb013,l_eccb.eccb014,l_eccb.eccb015,l_eccb.eccb016,l_eccb.eccb017,l_eccb.eccb018,l_eccb.eccb019,l_eccb.eccb020,l_eccb.eccb021,l_eccb.eccb022,l_eccb.eccb023,l_eccb.eccb024,l_eccb.eccb025,l_eccb.eccb026,l_eccb.eccb027,l_eccb.eccb028,l_eccb.eccb029,l_eccb.eccb030,l_eccb.eccb031,l_eccb.eccb032,l_eccb.eccb033,l_eccb.eccb034,l_eccb.eccb035,l_eccb.eccb036,l_eccb.eccb900,l_eccb.eccb901,l_eccb.eccb902,l_eccb.eccb905,l_eccb.eccb906)
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = 'INSERT eccb_t'
         LET g_errparam.popup = TRUE
         CALL cl_err()
         RETURN r_success
      END IF
      INITIALIZE l_eccb.* TO NULL   #清空数组
   END FOREACH
   LET r_success = TRUE
   RETURN r_success
END FUNCTION

#变更单用料底稿档
PRIVATE FUNCTION aect801_gen_eccc()
DEFINE r_success              LIKE type_t.num5
#DEFINE l_ecbc                 RECORD LIKE ecbc_t.* #161124-00048#2     2016/12/06 By 08734 mark
#161124-00048#2     2016/12/06 By 08734 add(S)
DEFINE l_ecbc RECORD  #料件製程用料底稿
       ecbcent LIKE ecbc_t.ecbcent, #企业编号
       ecbcsite LIKE ecbc_t.ecbcsite, #营运据点
       ecbc001 LIKE ecbc_t.ecbc001, #工艺料号
       ecbc002 LIKE ecbc_t.ecbc002, #工艺编号
       ecbc003 LIKE ecbc_t.ecbc003, #工艺项次
       ecbc004 LIKE ecbc_t.ecbc004, #项次
       ecbc005 LIKE ecbc_t.ecbc005, #元件料号
       ecbc006 LIKE ecbc_t.ecbc006, #部位
       ecbc007 LIKE ecbc_t.ecbc007, #组成用量
       ecbc008 LIKE ecbc_t.ecbc008, #主件底数
       ecbc009 LIKE ecbc_t.ecbc009, #用量单位
       ecbc010 LIKE ecbc_t.ecbc010 #损耗率型态
END RECORD
#161124-00048#2     2016/12/06 By 08734 add(E)
#DEFINE l_eccc                 RECORD LIKE eccc_t.*  #161124-00048#2     2016/12/06 By 08734 mark
#161124-00048#2     2016/12/06 By 08734 add(S)
DEFINE l_eccc RECORD  #料件製程變更用料底稿
       ecccent LIKE eccc_t.ecccent, #企业编号
       ecccsite LIKE eccc_t.ecccsite, #营运据点
       ecccdocno LIKE eccc_t.ecccdocno, #申请单号
       eccc001 LIKE eccc_t.eccc001, #工艺料号
       eccc002 LIKE eccc_t.eccc002, #工艺编号
       eccc003 LIKE eccc_t.eccc003, #工艺项次
       eccc004 LIKE eccc_t.eccc004, #项次
       eccc005 LIKE eccc_t.eccc005, #元件料号
       eccc006 LIKE eccc_t.eccc006, #部位
       eccc007 LIKE eccc_t.eccc007, #组成用量
       eccc008 LIKE eccc_t.eccc008, #主件底数
       eccc009 LIKE eccc_t.eccc009, #用量单位
       eccc010 LIKE eccc_t.eccc010, #损耗率形态
       eccc900 LIKE eccc_t.eccc900, #变更序
       eccc901 LIKE eccc_t.eccc901, #变更类型
       eccc902 LIKE eccc_t.eccc902, #变更日期
       eccc905 LIKE eccc_t.eccc905, #变更理由
       eccc906 LIKE eccc_t.eccc906 #变更备注
END RECORD
#161124-00048#2     2016/12/06 By 08734 add(E)

   LET r_success = FALSE
   DECLARE aect801_gen_eccc_cs CURSOR FOR
    #SELECT * FROM ecbc_t WHERE ecbcent = g_enterprise AND ecbcsite = g_site  #161124-00048#2     2016/12/06 By 08734 mark
    SELECT ecbcent,ecbcsite,ecbc001,ecbc002,ecbc003,ecbc004,ecbc005,ecbc006,ecbc007,ecbc008,ecbc009,ecbc010 FROM ecbc_t WHERE ecbcent = g_enterprise AND ecbcsite = g_site  #161124-00048#2     2016/12/06 By 08734 add
       AND ecbc001 = g_ecca_m.ecca001 AND ecbc002 = g_ecca_m.ecca002
   FOREACH aect801_gen_eccc_cs INTO l_ecbc.*
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "FOREACH:"
         LET g_errparam.popup = TRUE
         CALL cl_err()
         EXIT FOREACH
      END IF
      
      LET l_eccc.ecccent = g_enterprise 
      LET l_eccc.ecccsite = g_site
      LET l_eccc.ecccdocno = g_ecca_m.eccadocno
      LET l_eccc.eccc001 = l_ecbc.ecbc001
      LET l_eccc.eccc002 = l_ecbc.ecbc002
      LET l_eccc.eccc003 = l_ecbc.ecbc003
      LET l_eccc.eccc004 = l_ecbc.ecbc004
      LET l_eccc.eccc005 = l_ecbc.ecbc005
      LET l_eccc.eccc006 = l_ecbc.ecbc006
      LET l_eccc.eccc007 = l_ecbc.ecbc007
      LET l_eccc.eccc008 = l_ecbc.ecbc008
      LET l_eccc.eccc009 = l_ecbc.ecbc009
      LET l_eccc.eccc010 = l_ecbc.ecbc010
      LET l_eccc.eccc900 = g_ecca_m.ecca900
      LET l_eccc.eccc901 = '1'
      
      #INSERT INTO eccc_t VALUES l_eccc.*  #161124-00048#2     2016/12/06 By 08734 mark
      INSERT INTO eccc_t(ecccent,ecccsite,ecccdocno,eccc001,eccc002,eccc003,eccc004,eccc005,eccc006,eccc007,eccc008,eccc009,eccc010,eccc900,eccc901,eccc902,eccc905,eccc906)  #161124-00048#2     2016/12/06 By 08734 add
        VALUES (l_eccc.ecccent,l_eccc.ecccsite,l_eccc.ecccdocno,l_eccc.eccc001,l_eccc.eccc002,l_eccc.eccc003,l_eccc.eccc004,l_eccc.eccc005,l_eccc.eccc006,l_eccc.eccc007,l_eccc.eccc008,l_eccc.eccc009,l_eccc.eccc010,l_eccc.eccc900,l_eccc.eccc901,l_eccc.eccc902,l_eccc.eccc905,l_eccc.eccc906)
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = 'INSERT eccc_t'
         LET g_errparam.popup = TRUE
         CALL cl_err()
         RETURN r_success
      END IF
      INITIALIZE l_eccc.* TO NULL   #清空数组
   END FOREACH
   LET r_success = TRUE
   RETURN r_success
END FUNCTION

#变更单用料底稿损耗率档
PRIVATE FUNCTION aect801_gen_eccd()
DEFINE r_success              LIKE type_t.num5
#DEFINE l_ecbd                 RECORD LIKE ecbd_t.*  #161124-00048#2     2016/12/06 By 08734 mark
#161124-00048#2     2016/12/06 By 08734 add(S)
DEFINE l_ecbd RECORD  #料件製程用料底稿損耗率檔
       ecbdent LIKE ecbd_t.ecbdent, #企业编号
       ecbdsite LIKE ecbd_t.ecbdsite, #营运据点
       ecbd001 LIKE ecbd_t.ecbd001, #工艺料号
       ecbd002 LIKE ecbd_t.ecbd002, #工艺编号
       ecbd003 LIKE ecbd_t.ecbd003, #工艺项次
       ecbd004 LIKE ecbd_t.ecbd004, #项次
       ecbd005 LIKE ecbd_t.ecbd005, #起始数量
       ecbd006 LIKE ecbd_t.ecbd006, #截止数量
       ecbd007 LIKE ecbd_t.ecbd007, #变动损耗率
       ecbd008 LIKE ecbd_t.ecbd008 #固定损耗量
END RECORD
#161124-00048#2     2016/12/06 By 08734 add(E)
#DEFINE l_eccd                 RECORD LIKE eccd_t.*  #161124-00048#2     2016/12/06 By 08734 mark
#161124-00048#2     2016/12/06 By 08734 add(S)
DEFINE l_eccd RECORD  #料件製程變更用料底稿損秏率檔
       eccdent LIKE eccd_t.eccdent, #企业编号
       eccdsite LIKE eccd_t.eccdsite, #营运据点
       eccddocno LIKE eccd_t.eccddocno, #申请单号
       eccd001 LIKE eccd_t.eccd001, #料件编号
       eccd002 LIKE eccd_t.eccd002, #工艺编号
       eccd003 LIKE eccd_t.eccd003, #工艺项次
       eccd004 LIKE eccd_t.eccd004, #项次
       eccd005 LIKE eccd_t.eccd005, #起始数量
       eccd006 LIKE eccd_t.eccd006, #截止数量
       eccd007 LIKE eccd_t.eccd007, #变动损耗率
       eccd008 LIKE eccd_t.eccd008, #固定损耗量
       eccd900 LIKE eccd_t.eccd900, #变更序
       eccd901 LIKE eccd_t.eccd901, #变更类型
       eccd902 LIKE eccd_t.eccd902, #变更日期
       eccd905 LIKE eccd_t.eccd905, #变更原因
       eccd906 LIKE eccd_t.eccd906, #变更备注
       eccdseq LIKE eccd_t.eccdseq #项序
END RECORD
#161124-00048#2     2016/12/06 By 08734 add(E)

   LET r_success = FALSE
   DECLARE aect801_gen_eccd_cs CURSOR FOR
    #SELECT * FROM ecbd_t WHERE ecbdent = g_enterprise AND ecbdsite = g_site  #161124-00048#2     2016/12/06 By 08734 mark
    SELECT ecbdent,ecbdsite,ecbd001,ecbd002,ecbd003,ecbd004,ecbd005,ecbd006,ecbd007,ecbd008 FROM ecbd_t WHERE ecbdent = g_enterprise AND ecbdsite = g_site #161124-00048#2     2016/12/06 By 08734 add
       AND ecbd001 = g_ecca_m.ecca001 AND ecbd002 = g_ecca_m.ecca002
       ORDER BY ecbd003,ecbd004,ecbd005
   FOREACH aect801_gen_eccd_cs INTO l_ecbd.*
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "FOREACH:"
         LET g_errparam.popup = TRUE
         CALL cl_err()
         EXIT FOREACH
      END IF
      
      IF l_ecbd.ecbd003 = l_eccd.eccd003 AND l_ecbd.ecbd004 = l_eccd.eccd004 AND NOT cl_null(l_eccd.eccd003) THEN
         LET l_eccd.eccdseq = l_eccd.eccdseq + 1
      ELSE
         LET l_eccd.eccdseq = 1
      END IF
      LET l_eccd.eccdent = g_enterprise 
      LET l_eccd.eccdsite = g_site
      LET l_eccd.eccddocno = g_ecca_m.eccadocno
      LET l_eccd.eccd001 = l_ecbd.ecbd001
      LET l_eccd.eccd002 = l_ecbd.ecbd002
      LET l_eccd.eccd003 = l_ecbd.ecbd003
      LET l_eccd.eccd004 = l_ecbd.ecbd004
      LET l_eccd.eccd005 = l_ecbd.ecbd005
      LET l_eccd.eccd006 = l_ecbd.ecbd006
      LET l_eccd.eccd007 = l_ecbd.ecbd007
      LET l_eccd.eccd008 = l_ecbd.ecbd008
      LET l_eccd.eccd900 = g_ecca_m.ecca900
      LET l_eccd.eccd901 = '1'
      
     # INSERT INTO eccd_t VALUES l_eccd.*  #161124-00048#2     2016/12/06 By 08734 mark
      INSERT INTO eccd_t(eccdent,eccdsite,eccddocno,eccd001,eccd002,eccd003,eccd004,eccd005,eccd006,eccd007,eccd008,eccd900,eccd901,eccd902,eccd905,eccd906,eccdseq)   #161124-00048#2     2016/12/06 By 08734 add
        VALUES (l_eccd.eccdent,l_eccd.eccdsite,l_eccd.eccddocno,l_eccd.eccd001,l_eccd.eccd002,l_eccd.eccd003,l_eccd.eccd004,l_eccd.eccd005,l_eccd.eccd006,l_eccd.eccd007,l_eccd.eccd008,l_eccd.eccd900,l_eccd.eccd901,l_eccd.eccd902,l_eccd.eccd905,l_eccd.eccd906,l_eccd.eccdseq)
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = 'INSERT eccd_t'
         LET g_errparam.popup = TRUE
         CALL cl_err()
         RETURN r_success
      END IF
      INITIALIZE l_ecbd.* TO NULL   #清空数组
   END FOREACH
   LET r_success = TRUE
   RETURN r_success
END FUNCTION

#变更单上站作业档
PRIVATE FUNCTION aect801_gen_ecce()
DEFINE r_success              LIKE type_t.num5
#DEFINE l_ecbe                 RECORD LIKE ecbe_t.*  #161124-00048#2     2016/12/06 By 08734 mark
#161124-00048#2     2016/12/06 By 08734 add(S)
DEFINE l_ecbe RECORD  #料件製程上站作業資料
       ecbeent LIKE ecbe_t.ecbeent, #企业编号
       ecbesite LIKE ecbe_t.ecbesite, #营运据点
       ecbe001 LIKE ecbe_t.ecbe001, #工艺料号
       ecbe002 LIKE ecbe_t.ecbe002, #工艺编号
       ecbe003 LIKE ecbe_t.ecbe003, #工艺项次
       ecbeseq LIKE ecbe_t.ecbeseq, #项序
       ecbe004 LIKE ecbe_t.ecbe004, #上站作业
       ecbe005 LIKE ecbe_t.ecbe005 #上站作业序
END RECORD
#161124-00048#2     2016/12/06 By 08734 add(E)
#DEFINE l_ecce                 RECORD LIKE ecce_t.*  #161124-00048#2     2016/12/06 By 08734 mark
#161124-00048#2     2016/12/06 By 08734 add(S)
DEFINE l_ecce RECORD  #料件製程變更上站作業資料
       ecceent LIKE ecce_t.ecceent, #企业编号
       eccesite LIKE ecce_t.eccesite, #营运据点
       eccedocno LIKE ecce_t.eccedocno, #申请单号
       ecce001 LIKE ecce_t.ecce001, #工艺料号
       ecce002 LIKE ecce_t.ecce002, #工艺编号
       ecce003 LIKE ecce_t.ecce003, #工艺项次
       ecceseq LIKE ecce_t.ecceseq, #项序
       ecce004 LIKE ecce_t.ecce004, #上站作业
       ecce005 LIKE ecce_t.ecce005, #上站作业序
       ecce900 LIKE ecce_t.ecce900, #变更序
       ecce901 LIKE ecce_t.ecce901, #变更类型
       ecce902 LIKE ecce_t.ecce902, #变更日期
       ecce905 LIKE ecce_t.ecce905, #变更原因
       ecce906 LIKE ecce_t.ecce906 #变更备注
END RECORD
#161124-00048#2     2016/12/06 By 08734 add(E)

   LET r_success = FALSE
   DECLARE aect801_gen_ecce_cs CURSOR FOR
   # SELECT * FROM ecbe_t WHERE ecbeent = g_enterprise AND ecbesite = g_site  #161124-00048#2     2016/12/06 By 08734 mark
    SELECT ecbeent,ecbesite,ecbe001,ecbe002,ecbe003,ecbeseq,ecbe004,ecbe005 FROM ecbe_t WHERE ecbeent = g_enterprise AND ecbesite = g_site #161124-00048#2     2016/12/06 By 08734 add
       AND ecbe001 = g_ecca_m.ecca001 AND ecbe002 = g_ecca_m.ecca002
   FOREACH aect801_gen_ecce_cs INTO l_ecbe.*
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "FOREACH:"
         LET g_errparam.popup = TRUE
         CALL cl_err()
         EXIT FOREACH
      END IF
      
      LET l_ecce.ecceent = g_enterprise 
      LET l_ecce.eccesite = g_site
      LET l_ecce.eccedocno = g_ecca_m.eccadocno
      LET l_ecce.ecce001 = l_ecbe.ecbe001
      LET l_ecce.ecce002 = l_ecbe.ecbe002
      LET l_ecce.ecce003 = l_ecbe.ecbe003
      LET l_ecce.ecceseq = l_ecbe.ecbeseq
      LET l_ecce.ecce004 = l_ecbe.ecbe004
      LET l_ecce.ecce005 = l_ecbe.ecbe005
      LET l_ecce.ecce900 = g_ecca_m.ecca900
      LET l_ecce.ecce901 = '1'
      
      #INSERT INTO ecce_t VALUES l_ecce.*  #161124-00048#2     2016/12/06 By 08734 mark
      INSERT INTO ecce_t(ecceent,eccesite,eccedocno,ecce001,ecce002,ecce003,ecceseq,ecce004,ecce005,ecce900,ecce901,ecce902,ecce905,ecce906)   #161124-00048#2     2016/12/06 By 08734 add
        VALUES (l_ecce.ecceent,l_ecce.eccesite,l_ecce.eccedocno,l_ecce.ecce001,l_ecce.ecce002,l_ecce.ecce003,l_ecce.ecceseq,l_ecce.ecce004,l_ecce.ecce005,l_ecce.ecce900,l_ecce.ecce901,l_ecce.ecce902,l_ecce.ecce905,l_ecce.ecce906)
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = 'INSERT ecce_t'
         LET g_errparam.popup = TRUE
         CALL cl_err()
         RETURN r_success
      END IF
      INITIALIZE l_ecce.* TO NULL   #清空数组
   END FOREACH
   LET r_success = TRUE
   RETURN r_success
END FUNCTION

#变更单check in/out资料
PRIVATE FUNCTION aect801_gen_eccf()
DEFINE r_success              LIKE type_t.num5
#DEFINE l_ecbf                 RECORD LIKE ecbf_t.*  #161124-00048#2     2016/12/06 By 08734 mark
#161124-00048#2     2016/12/06 By 08734 add(S)
DEFINE l_ecbf RECORD  #料件製程check in/out專案資料
       ecbfent LIKE ecbf_t.ecbfent, #企业编号
       ecbfsite LIKE ecbf_t.ecbfsite, #营运据点
       ecbf001 LIKE ecbf_t.ecbf001, #工艺料号
       ecbf002 LIKE ecbf_t.ecbf002, #工艺编号
       ecbf003 LIKE ecbf_t.ecbf003, #工艺项次
       ecbfseq LIKE ecbf_t.ecbfseq, #项序
       ecbf004 LIKE ecbf_t.ecbf004, #check in/check out
       ecbf005 LIKE ecbf_t.ecbf005, #项目
       ecbf006 LIKE ecbf_t.ecbf006, #型态
       ecbf007 LIKE ecbf_t.ecbf007, #下限
       ecbf008 LIKE ecbf_t.ecbf008, #上限
       ecbf009 LIKE ecbf_t.ecbf009, #默认值
       ecbf010 LIKE ecbf_t.ecbf010 #必要
END RECORD
#161124-00048#2     2016/12/06 By 08734 add(E)
#DEFINE l_eccf                 RECORD LIKE eccf_t.*  #161124-00048#2     2016/12/06 By 08734 mark
#161124-00048#2     2016/12/06 By 08734 add(S)
DEFINE l_eccf RECORD  #料件製程check in/out項目資料
       eccfent LIKE eccf_t.eccfent, #企业编号
       eccfsite LIKE eccf_t.eccfsite, #营运据点
       eccfdocno LIKE eccf_t.eccfdocno, #申请单号
       eccf001 LIKE eccf_t.eccf001, #工艺料号
       eccf002 LIKE eccf_t.eccf002, #工艺编号
       eccf003 LIKE eccf_t.eccf003, #工艺项次
       eccfseq LIKE eccf_t.eccfseq, #项序
       eccf004 LIKE eccf_t.eccf004, #check in/check out
       eccf005 LIKE eccf_t.eccf005, #项目
       eccf006 LIKE eccf_t.eccf006, #形态
       eccf007 LIKE eccf_t.eccf007, #下限
       eccf008 LIKE eccf_t.eccf008, #上限
       eccf009 LIKE eccf_t.eccf009, #默认值
       eccf010 LIKE eccf_t.eccf010, #必要
       eccf900 LIKE eccf_t.eccf900, #变更序
       eccf901 LIKE eccf_t.eccf901, #变更类型
       eccf902 LIKE eccf_t.eccf902, #变更日期
       eccf905 LIKE eccf_t.eccf905, #变更原因
       eccf906 LIKE eccf_t.eccf906 #变更备注
END RECORD
#161124-00048#2     2016/12/06 By 08734 add(E)

   LET r_success = FALSE
   DECLARE aect801_gen_eccf_cs CURSOR FOR
    #SELECT * FROM ecbf_t WHERE ecbfent = g_enterprise AND ecbfsite = g_site  #161124-00048#2     2016/12/06 By 08734 mark
    SELECT ecbfent,ecbfsite,ecbf001,ecbf002,ecbf003,ecbfseq,ecbf004,ecbf005,ecbf006,ecbf007,ecbf008,ecbf009,ecbf010 FROM ecbf_t WHERE ecbfent = g_enterprise AND ecbfsite = g_site #161124-00048#2     2016/12/06 By 08734 add
       AND ecbf001 = g_ecca_m.ecca001 AND ecbf002 = g_ecca_m.ecca002
   FOREACH aect801_gen_eccf_cs INTO l_ecbf.*
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "FOREACH:"
         LET g_errparam.popup = TRUE
         CALL cl_err()
         EXIT FOREACH
      END IF
      
      LET l_eccf.eccfent = g_enterprise 
      LET l_eccf.eccfsite = g_site
      LET l_eccf.eccfdocno = g_ecca_m.eccadocno
      LET l_eccf.eccf001 = l_ecbf.ecbf001
      LET l_eccf.eccf002 = l_ecbf.ecbf002
      LET l_eccf.eccf003 = l_ecbf.ecbf003
      LET l_eccf.eccfseq = l_ecbf.ecbfseq
      LET l_eccf.eccf004 = l_ecbf.ecbf004
      LET l_eccf.eccf005 = l_ecbf.ecbf005
      LET l_eccf.eccf006 = l_ecbf.ecbf006
      LET l_eccf.eccf007 = l_ecbf.ecbf007
      LET l_eccf.eccf008 = l_ecbf.ecbf008
      LET l_eccf.eccf009 = l_ecbf.ecbf009
      LET l_eccf.eccf010 = l_ecbf.ecbf010
      LET l_eccf.eccf900 = g_ecca_m.ecca900
      LET l_eccf.eccf901 = '1'
      
      #INSERT INTO eccf_t VALUES l_eccf.*  #161124-00048#2     2016/12/06 By 08734 mark
      INSERT INTO eccf_t(eccfent,eccfsite,eccfdocno,eccf001,eccf002,eccf003,eccfseq,eccf004,eccf005,eccf006,eccf007,eccf008,eccf009,eccf010,eccf900,eccf901,eccf902,eccf905,eccf906)  #161124-00048#2     2016/12/06 By 08734 add
        VALUES (l_eccf.eccfent,l_eccf.eccfsite,l_eccf.eccfdocno,l_eccf.eccf001,l_eccf.eccf002,l_eccf.eccf003,l_eccf.eccfseq,l_eccf.eccf004,l_eccf.eccf005,l_eccf.eccf006,l_eccf.eccf007,l_eccf.eccf008,l_eccf.eccf009,l_eccf.eccf010,l_eccf.eccf900,l_eccf.eccf901,l_eccf.eccf902,l_eccf.eccf905,l_eccf.eccf906)
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = 'INSERT eccf_t'
         LET g_errparam.popup = TRUE
         CALL cl_err()
         RETURN r_success
      END IF
      INITIALIZE l_eccf.* TO NULL   #清空数组
   END FOREACH
   LET r_success = TRUE
   RETURN r_success
END FUNCTION

#变更单资源项目档
PRIVATE FUNCTION aect801_gen_eccg()
DEFINE r_success              LIKE type_t.num5
#DEFINE l_ecbg                 RECORD LIKE ecbg_t.* #161124-00048#2     2016/12/06 By 08734 mark
#161124-00048#2     2016/12/06 By 08734 add(S)
DEFINE l_ecbg RECORD  #料件製程資源項目檔
       ecbgent LIKE ecbg_t.ecbgent, #企业编号
       ecbgsite LIKE ecbg_t.ecbgsite, #营运据点
       ecbg001 LIKE ecbg_t.ecbg001, #工艺料号
       ecbg002 LIKE ecbg_t.ecbg002, #工艺编号
       ecbg003 LIKE ecbg_t.ecbg003, #项次
       ecbgseq LIKE ecbg_t.ecbgseq, #项序
       ecbg004 LIKE ecbg_t.ecbg004, #资源类型
       ecbg005 LIKE ecbg_t.ecbg005, #资源项目
       ecbg006 LIKE ecbg_t.ecbg006, #固定标准工时
       ecbg007 LIKE ecbg_t.ecbg007, #变动标准工时
       ecbg008 LIKE ecbg_t.ecbg008, #变动标准工时批量
       ecbg009 LIKE ecbg_t.ecbg009 #效率
END RECORD
#161124-00048#2     2016/12/06 By 08734 add(E)
#DEFINE l_eccg                 RECORD LIKE eccg_t.*  #161124-00048#2     2016/12/06 By 08734 mark
#161124-00048#2     2016/12/06 By 08734 add(S)
DEFINE l_eccg RECORD  #料件製程變更資源項目檔
       eccgent LIKE eccg_t.eccgent, #企业编号
       eccgsite LIKE eccg_t.eccgsite, #营运据点
       eccgdocno LIKE eccg_t.eccgdocno, #申请单号
       eccg001 LIKE eccg_t.eccg001, #工艺料号
       eccg002 LIKE eccg_t.eccg002, #工艺编号
       eccg003 LIKE eccg_t.eccg003, #工艺项次
       eccgseq LIKE eccg_t.eccgseq, #项序
       eccg004 LIKE eccg_t.eccg004, #资源类型
       eccg005 LIKE eccg_t.eccg005, #资源项目
       eccg006 LIKE eccg_t.eccg006, #固定标准工时
       eccg007 LIKE eccg_t.eccg007, #变动标准工时
       eccg008 LIKE eccg_t.eccg008, #变动标准工时批量
       eccg009 LIKE eccg_t.eccg009, #效率
       eccg900 LIKE eccg_t.eccg900, #变更序
       eccg901 LIKE eccg_t.eccg901, #变更类型
       eccg902 LIKE eccg_t.eccg902, #变更日期
       eccg905 LIKE eccg_t.eccg905, #变更原因
       eccg906 LIKE eccg_t.eccg906 #变更备注
END RECORD
#161124-00048#2     2016/12/06 By 08734 add(E)

   LET r_success = FALSE
   DECLARE aect801_gen_eccg_cs CURSOR FOR
    #SELECT * FROM ecbg_t WHERE ecbgent = g_enterprise AND ecbgsite = g_site #161124-00048#2     2016/12/06 By 08734 mark
    SELECT ecbgent,ecbgsite,ecbg001,ecbg002,ecbg003,ecbgseq,ecbg004,ecbg005,ecbg006,ecbg007,ecbg008,ecbg009 FROM ecbg_t WHERE ecbgent = g_enterprise AND ecbgsite = g_site #161124-00048#2     2016/12/06 By 08734 add
       AND ecbg001 = g_ecca_m.ecca001 AND ecbg002 = g_ecca_m.ecca002
   FOREACH aect801_gen_eccg_cs INTO l_ecbg.*
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "FOREACH:"
         LET g_errparam.popup = TRUE
         CALL cl_err()
         EXIT FOREACH
      END IF
      
      LET l_eccg.eccgent = g_enterprise 
      LET l_eccg.eccgsite = g_site
      LET l_eccg.eccgdocno = g_ecca_m.eccadocno
      LET l_eccg.eccg001 = l_ecbg.ecbg001
      LET l_eccg.eccg002 = l_ecbg.ecbg002
      LET l_eccg.eccg003 = l_ecbg.ecbg003
      LET l_eccg.eccgseq = l_ecbg.ecbgseq
      LET l_eccg.eccg004 = l_ecbg.ecbg004
      LET l_eccg.eccg005 = l_ecbg.ecbg005
      LET l_eccg.eccg006 = l_ecbg.ecbg006
      LET l_eccg.eccg007 = l_ecbg.ecbg007
      LET l_eccg.eccg008 = l_ecbg.ecbg008
      LET l_eccg.eccg009 = l_ecbg.ecbg009
      LET l_eccg.eccg900 = g_ecca_m.ecca900
      LET l_eccg.eccg901 = '1'
      
     # INSERT INTO eccg_t VALUES l_eccg.*  #161124-00048#2     2016/12/06 By 08734 mark
      INSERT INTO eccg_t(eccgent,eccgsite,eccgdocno,eccg001,eccg002,eccg003,eccgseq,eccg004,eccg005,eccg006,eccg007,eccg008,eccg009,eccg900,eccg901,eccg902,eccg905,eccg906)  #161124-00048#2     2016/12/06 By 08734 add
        VALUES (l_eccg.eccgent,l_eccg.eccgsite,l_eccg.eccgdocno,l_eccg.eccg001,l_eccg.eccg002,l_eccg.eccg003,l_eccg.eccgseq,l_eccg.eccg004,l_eccg.eccg005,l_eccg.eccg006,l_eccg.eccg007,l_eccg.eccg008,l_eccg.eccg009,l_eccg.eccg900,l_eccg.eccg901,l_eccg.eccg902,l_eccg.eccg905,l_eccg.eccg906)
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = 'INSERT eccg_t'
         LET g_errparam.popup = TRUE
         CALL cl_err()
         RETURN r_success
      END IF
      INITIALIZE l_eccg.* TO NULL   #清空数组
   END FOREACH
   LET r_success = TRUE
   RETURN r_success
END FUNCTION

#单头发生变更写入历程档
PRIVATE FUNCTION aect801_upd_ecca_ecch()
DEFINE r_success             LIKE type_t.num5
#DEFINE l_ecba                RECORD LIKE ecba_t.*  #161124-00048#2     2016/12/06 By 08734 mark
#161124-00048#2     2016/12/06 By 08734 add(S)
DEFINE l_ecba RECORD  #料件製程單頭檔
       ecbaent LIKE ecba_t.ecbaent, #企业编号
       ecbasite LIKE ecba_t.ecbasite, #营运据点
       ecbaownid LIKE ecba_t.ecbaownid, #资料所有者
       ecbaowndp LIKE ecba_t.ecbaowndp, #资料所有部门
       ecbacrtid LIKE ecba_t.ecbacrtid, #资料录入者
       ecbacrtdp LIKE ecba_t.ecbacrtdp, #资料录入部门
       ecbacrtdt LIKE ecba_t.ecbacrtdt, #资料创建日
       ecbamodid LIKE ecba_t.ecbamodid, #资料更改者
       ecbamoddt LIKE ecba_t.ecbamoddt, #最近更改日
       ecbacnfid LIKE ecba_t.ecbacnfid, #资料审核者
       ecbacnfdt LIKE ecba_t.ecbacnfdt, #数据审核日
       ecbastus LIKE ecba_t.ecbastus, #状态码
       ecba001 LIKE ecba_t.ecba001, #工艺料号
       ecba002 LIKE ecba_t.ecba002, #工艺编号
       ecba003 LIKE ecba_t.ecba003, #说明
       ecba004 LIKE ecba_t.ecba004, #起始X轴
       ecba005 LIKE ecba_t.ecba005, #起始Y轴
       ecba006 LIKE ecba_t.ecba006, #截止X轴
       ecba007 LIKE ecba_t.ecba007 #截止Y轴
END RECORD
#161124-00048#2     2016/12/06 By 08734 add(E)
DEFINE l_flag                LIKE type_t.chr1

   LET r_success = FALSE
   LET l_flag = 'N'
   IF g_ecca_m.ecca004 = '1' THEN
      LET r_success = TRUE
      RETURN r_success
   END IF
   
   #SELECT * INTO l_ecba.* FROM ecba_t WHERE ecbaent = g_enterprise AND ecbasite = g_site  #161124-00048#2     2016/12/06 By 08734 mark
   SELECT ecbaent,ecbasite,ecbaownid,ecbaowndp,ecbacrtid,ecbacrtdp,ecbacrtdt,ecbamodid,ecbamoddt,ecbacnfid,ecbacnfdt,ecbastus,ecba001,ecba002,ecba003,ecba004,ecba005,ecba006,ecba007  #161124-00048#2     2016/12/06 By 08734 add 
     INTO l_ecba.* FROM ecba_t WHERE ecbaent = g_enterprise AND ecbasite = g_site
      AND ecba001 = g_ecca_m.ecca001 AND ecba002 = g_ecca_m.ecca002
   #制程说明
   IF (NOT cl_null(g_ecca_m.ecca003) AND (g_ecca_m.ecca003 != l_ecba.ecba003 OR l_ecba.ecba003 IS NULL)) OR (cl_null(g_ecca_m.ecca003) AND l_ecba.ecba003 IS NOT NULL) THEN
      #其說明的SQL
      LET g_ecch007 = ""
      IF NOT s_aect801_ins_ecch(g_ecca_m.eccadocno,0,0,0,'ecba003','1',l_ecba.ecba003,g_ecca_m.ecca003,g_ecch007) THEN
         RETURN r_success
      END IF
      LET l_flag = 'Y'
   ELSE
      IF NOT s_aect801_del_ecch(g_ecca_m.eccadocno,0,0,0,'ecba003') THEN
         RETURN r_success
      END IF
   END IF

   #制程单头有发生变更，则更新ecca901
   IF l_flag = 'Y' THEN
      UPDATE ecca_t SET ecca901 = 'Y' WHERE eccaent = g_enterprise AND eccasite = g_site
         AND eccadocno = g_ecca_m.eccadocno
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "upd ecca901"
         LET g_errparam.popup = TRUE
         CALL cl_err()
         RETURN r_success
      END IF
   END IF
   
   LET r_success = TRUE
   RETURN r_success
   
END FUNCTION

#制程单身发生变更时写入变更历程档
PRIVATE FUNCTION aect801_upd_eccb_ecch(p_ecchdocno,p_ecchseq)
DEFINE p_ecchdocno           LIKE ecch_t.ecchdocno
DEFINE p_ecchseq             LIKE ecch_t.ecchseq
DEFINE r_success             LIKE type_t.num5
#DEFINE l_ecbb                RECORD LIKE ecbb_t.*  #161124-00048#2     2016/12/06 By 08734 mark
#161124-00048#2     2016/12/06 By 08734 add(S)
DEFINE l_ecbb RECORD  #料件製程單身檔
       ecbbent LIKE ecbb_t.ecbbent, #企业编号
       ecbbsite LIKE ecbb_t.ecbbsite, #营运据点
       ecbb001 LIKE ecbb_t.ecbb001, #工艺料号
       ecbb002 LIKE ecbb_t.ecbb002, #工艺编号
       ecbb003 LIKE ecbb_t.ecbb003, #项次
       ecbb004 LIKE ecbb_t.ecbb004, #本站作业
       ecbb005 LIKE ecbb_t.ecbb005, #作业序
       ecbb006 LIKE ecbb_t.ecbb006, #群组性质
       ecbb007 LIKE ecbb_t.ecbb007, #群组
       ecbb008 LIKE ecbb_t.ecbb008, #上站作业
       ecbb009 LIKE ecbb_t.ecbb009, #上站作业序
       ecbb010 LIKE ecbb_t.ecbb010, #下站作业
       ecbb011 LIKE ecbb_t.ecbb011, #下站作业序
       ecbb012 LIKE ecbb_t.ecbb012, #工作站
       ecbb013 LIKE ecbb_t.ecbb013, #允许委外
       ecbb014 LIKE ecbb_t.ecbb014, #主要加工厂
       ecbb015 LIKE ecbb_t.ecbb015, #Move in
       ecbb016 LIKE ecbb_t.ecbb016, #Check in
       ecbb017 LIKE ecbb_t.ecbb017, #报工站
       ecbb018 LIKE ecbb_t.ecbb018, #PQC
       ecbb019 LIKE ecbb_t.ecbb019, #Check out
       ecbb020 LIKE ecbb_t.ecbb020, #Move out
       ecbb021 LIKE ecbb_t.ecbb021, #转出单位
       ecbb022 LIKE ecbb_t.ecbb022, #转出单位转换率分子
       ecbb023 LIKE ecbb_t.ecbb023, #转出单位转换率分母
       ecbb024 LIKE ecbb_t.ecbb024, #固定工时
       ecbb025 LIKE ecbb_t.ecbb025, #标准工时
       ecbb026 LIKE ecbb_t.ecbb026, #固定机时
       ecbb027 LIKE ecbb_t.ecbb027, #标准机时
       ecbb028 LIKE ecbb_t.ecbb028, #完成度
       ecbb029 LIKE ecbb_t.ecbb029, #标准单价
       ecbb030 LIKE ecbb_t.ecbb030, #转入单位
       ecbb031 LIKE ecbb_t.ecbb031, #转入单位转换分子
       ecbb032 LIKE ecbb_t.ecbb032, #转入单位转换分母
       ecbb033 LIKE ecbb_t.ecbb033, #回收站
       ecbb034 LIKE ecbb_t.ecbb034, #后置时间
       ecbb035 LIKE ecbb_t.ecbb035, #X轴
       ecbb036 LIKE ecbb_t.ecbb036, #Y轴
       ecbb037 LIKE ecbb_t.ecbb037, #资源群组
       ecbb038 LIKE ecbb_t.ecbb038 #工具群组
END RECORD
#161124-00048#2     2016/12/06 By 08734 add(E)
#DEFINE l_eccb                RECORD LIKE eccb_t.*  #161124-00048#2     2016/12/06 By 08734 mark
#161124-00048#2     2016/12/06 By 08734 add(S)
DEFINE l_eccb RECORD  #料件製程變更單身檔
       eccbent LIKE eccb_t.eccbent, #企业编号
       eccbsite LIKE eccb_t.eccbsite, #营运据点
       eccbdocno LIKE eccb_t.eccbdocno, #申请单号
       eccb001 LIKE eccb_t.eccb001, #工艺料号
       eccb002 LIKE eccb_t.eccb002, #工艺编号
       eccb003 LIKE eccb_t.eccb003, #项次
       eccb004 LIKE eccb_t.eccb004, #本站作业
       eccb005 LIKE eccb_t.eccb005, #作业序
       eccb006 LIKE eccb_t.eccb006, #群组性质
       eccb007 LIKE eccb_t.eccb007, #群组
       eccb008 LIKE eccb_t.eccb008, #上站作业
       eccb009 LIKE eccb_t.eccb009, #上站作业序
       eccb010 LIKE eccb_t.eccb010, #下站作业
       eccb011 LIKE eccb_t.eccb011, #下站作业序
       eccb012 LIKE eccb_t.eccb012, #工作站
       eccb013 LIKE eccb_t.eccb013, #允许委外
       eccb014 LIKE eccb_t.eccb014, #主要加工厂
       eccb015 LIKE eccb_t.eccb015, #Move in
       eccb016 LIKE eccb_t.eccb016, #Check in
       eccb017 LIKE eccb_t.eccb017, #报工站
       eccb018 LIKE eccb_t.eccb018, #PQC
       eccb019 LIKE eccb_t.eccb019, #Check out
       eccb020 LIKE eccb_t.eccb020, #Move out
       eccb021 LIKE eccb_t.eccb021, #转出单位
       eccb022 LIKE eccb_t.eccb022, #转出单位转换率分子
       eccb023 LIKE eccb_t.eccb023, #转出单位转换率分母
       eccb024 LIKE eccb_t.eccb024, #固定工时
       eccb025 LIKE eccb_t.eccb025, #标准工时
       eccb026 LIKE eccb_t.eccb026, #固定机时
       eccb027 LIKE eccb_t.eccb027, #标准机时
       eccb028 LIKE eccb_t.eccb028, #完成度
       eccb029 LIKE eccb_t.eccb029, #标准单价
       eccb030 LIKE eccb_t.eccb030, #转入单位
       eccb031 LIKE eccb_t.eccb031, #转入单位转换分子
       eccb032 LIKE eccb_t.eccb032, #转入单位转换分母
       eccb033 LIKE eccb_t.eccb033, #回收站
       eccb034 LIKE eccb_t.eccb034, #后置时间
       eccb035 LIKE eccb_t.eccb035, #X轴
       eccb036 LIKE eccb_t.eccb036, #Y轴
       eccb900 LIKE eccb_t.eccb900, #变更序
       eccb901 LIKE eccb_t.eccb901, #变更类型
       eccb902 LIKE eccb_t.eccb902, #变更日期
       eccb905 LIKE eccb_t.eccb905, #变更理由
       eccb906 LIKE eccb_t.eccb906 #变更备注
END RECORD
#161124-00048#2     2016/12/06 By 08734 add(E)
DEFINE l_flag                LIKE type_t.chr1
DEFINE l_success             LIKE type_t.num5
DEFINE l_ooff013             LIKE ooff_t.ooff013
DEFINE l_ooff013_new         LIKE ooff_t.ooff013

   LET r_success = FALSE
   LET l_flag = 'N'
   IF g_ecca_m.ecca004 = '1' THEN
      LET r_success = TRUE
      RETURN r_success
   END IF
   
   IF cl_null(p_ecchdocno) OR cl_null(p_ecchseq) THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'sub-00001'
      LET g_errparam.extend = ''
      LET g_errparam.popup = TRUE
      CALL cl_err()
      RETURN r_success
   END IF
   
   INITIALIZE l_ecbb.* TO NULL
   INITIALIZE l_eccb.* TO NULL
  # SELECT * INTO l_eccb.* FROM eccb_t WHERE eccbent = g_enterprise AND eccbsite = g_site  #161124-00048#2     2016/12/06 By 08734 mark
   SELECT eccbent,eccbsite,eccbdocno,eccb001,eccb002,eccb003,eccb004,eccb005,eccb006,eccb007,eccb008,eccb009,eccb010,eccb011,eccb012,eccb013,eccb014,eccb015,eccb016,eccb017,eccb018,eccb019,eccb020,eccb021,eccb022,eccb023,eccb024,eccb025,eccb026,eccb027,eccb028,eccb029,eccb030,eccb031,eccb032,eccb033,eccb034,eccb035,eccb036,eccb900,eccb901,eccb902,eccb905,eccb906 #161124-00048#2     2016/12/06 By 08734 add
     INTO l_eccb.* FROM eccb_t WHERE eccbent = g_enterprise AND eccbsite = g_site
      AND eccbdocno = p_ecchdocno AND eccb003 = p_ecchseq
      
   IF l_eccb.eccb901 = '1' THEN
      LET r_success = TRUE
      RETURN r_success
   END IF
   
   IF l_eccb.eccb901 = '2' OR l_eccb.eccb901 = '4' THEN
      #SELECT * INTO l_ecbb.* FROM ecbb_t WHERE ecbbent = g_enterprise AND ecbbsite = g_site #161124-00048#2     2016/12/06 By 08734 mark
      SELECT ecbbent,ecbbsite,ecbb001,ecbb002,ecbb003,ecbb004,ecbb005,ecbb006,ecbb007,ecbb008,ecbb009,ecbb010,ecbb011,ecbb012,ecbb013,ecbb014,ecbb015,ecbb016,ecbb017,ecbb018,ecbb019,ecbb020,ecbb021,ecbb022,ecbb023,ecbb024,ecbb025,ecbb026,ecbb027,ecbb028,ecbb029,ecbb030,ecbb031,ecbb032,ecbb033,ecbb034,ecbb035,ecbb036,ecbb037,ecbb038 #161124-00048#2     2016/12/06 By 08734 add 
        INTO l_ecbb.* FROM ecbb_t WHERE ecbbent = g_enterprise AND ecbbsite = g_site
         AND ecbb001 = g_ecca_m.ecca001 AND ecbb002 = g_ecca_m.ecca002
         AND ecbb003 = p_ecchseq
      CALL s_aooi360_sel('7',g_site,g_ecca_m.ecca001,g_ecca_m.ecca002,'','','','','','','','4')
           RETURNING l_success,l_ooff013
      CALL s_aooi360_sel('7',g_site,p_ecchdocno,p_ecchseq,'','','','','','','','4')
           RETURNING l_success,l_ooff013_new
   END IF
   
   LET g_ecch003 = ''
   IF l_eccb.eccb901 = '2' THEN
      LET g_ecch003 = '1'
   END IF
   IF l_eccb.eccb901 = '3' THEN
      LET g_ecch003 = '2'
   END IF
   IF l_eccb.eccb901 = '4' THEN
      INITIALIZE l_eccb.* TO NULL
      LET l_ooff013_new = ''
      LET g_ecch003 = '3'
   END IF
   
   #项次
   IF (NOT cl_null(l_eccb.eccb003) AND (l_eccb.eccb003 != l_ecbb.ecbb003 OR l_ecbb.ecbb003 IS NULL)) OR (cl_null(l_eccb.eccb003) AND l_ecbb.ecbb003 IS NOT NULL) THEN
      #其說明的SQL
      LET g_ecch007 = ""
      IF NOT s_aect801_ins_ecch(p_ecchdocno,p_ecchseq,0,0,'ecbb003',g_ecch003,l_ecbb.ecbb003,l_eccb.eccb003,g_ecch007) THEN
         RETURN r_success
      END IF
      LET l_flag = 'Y'
   ELSE
      IF NOT s_aect801_del_ecch(p_ecchdocno,p_ecchseq,0,0,'ecbb003') THEN
         RETURN r_success
      END IF
   END IF
   
   #本站作业
   IF (NOT cl_null(l_eccb.eccb004) AND (l_eccb.eccb004 != l_ecbb.ecbb004 OR l_ecbb.ecbb004 IS NULL)) OR (cl_null(l_eccb.eccb004) AND l_ecbb.ecbb004 IS NOT NULL) THEN
      #其說明的SQL
      LET g_ecch007 = "SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001='221' AND oocql002='"||l_ecbb.ecbb004||"' AND oocql003=? "
      IF NOT s_aect801_ins_ecch(p_ecchdocno,p_ecchseq,0,0,'ecbb004',g_ecch003,l_ecbb.ecbb004,l_eccb.eccb004,g_ecch007) THEN
         RETURN r_success
      END IF
      LET l_flag = 'Y'
   ELSE
      IF NOT s_aect801_del_ecch(p_ecchdocno,p_ecchseq,0,0,'ecbb004') THEN
         RETURN r_success
      END IF
   END IF
   
   #作业序
   IF (NOT cl_null(l_eccb.eccb005) AND (l_eccb.eccb005 != l_ecbb.ecbb005 OR l_ecbb.ecbb005 IS NULL)) OR (cl_null(l_eccb.eccb005) AND l_ecbb.ecbb005 IS NOT NULL) THEN
      #其說明的SQL
      LET g_ecch007 = ""
      IF NOT s_aect801_ins_ecch(p_ecchdocno,p_ecchseq,0,0,'ecbb005',g_ecch003,l_ecbb.ecbb005,l_eccb.eccb005,g_ecch007) THEN
         RETURN r_success
      END IF
      LET l_flag = 'Y'
   ELSE
      IF NOT s_aect801_del_ecch(p_ecchdocno,p_ecchseq,0,0,'ecbb005') THEN
         RETURN r_success
      END IF
   END IF

   #群组性质
   IF (NOT cl_null(l_eccb.eccb006) AND (l_eccb.eccb006 != l_ecbb.ecbb006 OR l_ecbb.ecbb006 IS NULL)) OR (cl_null(l_eccb.eccb006) AND l_ecbb.ecbb006 IS NOT NULL) THEN
      #其說明的SQL
      LET g_ecch007 = ""
      IF NOT s_aect801_ins_ecch(p_ecchdocno,p_ecchseq,0,0,'ecbb006',g_ecch003,l_ecbb.ecbb006,l_eccb.eccb006,g_ecch007) THEN
         RETURN r_success
      END IF
      LET l_flag = 'Y'
   ELSE
      IF NOT s_aect801_del_ecch(p_ecchdocno,p_ecchseq,0,0,'ecbb006') THEN
         RETURN r_success
      END IF
   END IF
   
   #群组
   IF (NOT cl_null(l_eccb.eccb007) AND (l_eccb.eccb007 != l_ecbb.ecbb007 OR l_ecbb.ecbb007 IS NULL)) OR (cl_null(l_eccb.eccb007) AND l_ecbb.ecbb007 IS NOT NULL) THEN
      #其說明的SQL
      LET g_ecch007 = ""
      IF NOT s_aect801_ins_ecch(p_ecchdocno,p_ecchseq,0,0,'ecbb007',g_ecch003,l_ecbb.ecbb007,l_eccb.eccb007,g_ecch007) THEN
         RETURN r_success
      END IF
      LET l_flag = 'Y'
   ELSE
      IF NOT s_aect801_del_ecch(p_ecchdocno,p_ecchseq,0,0,'ecbb007') THEN
         RETURN r_success
      END IF
   END IF
   
   #上站作业
   IF (NOT cl_null(l_eccb.eccb008) AND (l_eccb.eccb008 != l_ecbb.ecbb008 OR l_ecbb.ecbb008 IS NULL)) OR (cl_null(l_eccb.eccb008) AND l_ecbb.ecbb008 IS NOT NULL) THEN
      #其說明的SQL
      LET g_ecch007 = "SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001='221' AND oocql002='"||l_ecbb.ecbb008||"' AND oocql003=? "
      IF NOT s_aect801_ins_ecch(p_ecchdocno,p_ecchseq,0,0,'ecbb008',g_ecch003,l_ecbb.ecbb008,l_eccb.eccb008,g_ecch007) THEN
         RETURN r_success
      END IF
      LET l_flag = 'Y'
   ELSE
      IF NOT s_aect801_del_ecch(p_ecchdocno,p_ecchseq,0,0,'ecbb008') THEN
         RETURN r_success
      END IF
   END IF
   
   #上站作业序
   IF (NOT cl_null(l_eccb.eccb009) AND (l_eccb.eccb009 != l_ecbb.ecbb009 OR l_ecbb.ecbb009 IS NULL)) OR (cl_null(l_eccb.eccb009) AND l_ecbb.ecbb009 IS NOT NULL) THEN
      #其說明的SQL
      LET g_ecch007 = ""
      IF NOT s_aect801_ins_ecch(p_ecchdocno,p_ecchseq,0,0,'ecbb009',g_ecch003,l_ecbb.ecbb009,l_eccb.eccb009,g_ecch007) THEN
         RETURN r_success
      END IF
      LET l_flag = 'Y'
   ELSE
      IF NOT s_aect801_del_ecch(p_ecchdocno,p_ecchseq,0,0,'ecbb009') THEN
         RETURN r_success
      END IF
   END IF
   
   #下站作业
   IF (NOT cl_null(l_eccb.eccb010) AND (l_eccb.eccb010 != l_ecbb.ecbb010 OR l_ecbb.ecbb010 IS NULL)) OR (cl_null(l_eccb.eccb010) AND l_ecbb.ecbb010 IS NOT NULL) THEN
      #其說明的SQL
      LET g_ecch007 = "SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001='221' AND oocql002='"||l_ecbb.ecbb010||"' AND oocql003=? "
      IF NOT s_aect801_ins_ecch(p_ecchdocno,p_ecchseq,0,0,'ecbb010',g_ecch003,l_ecbb.ecbb010,l_eccb.eccb010,g_ecch007) THEN
         RETURN r_success
      END IF
      LET l_flag = 'Y'
   ELSE
      IF NOT s_aect801_del_ecch(p_ecchdocno,p_ecchseq,0,0,'ecbb010') THEN
         RETURN r_success
      END IF
   END IF
   
   #下站作业序
   IF (NOT cl_null(l_eccb.eccb011) AND (l_eccb.eccb011 != l_ecbb.ecbb011 OR l_ecbb.ecbb011 IS NULL)) OR (cl_null(l_eccb.eccb011) AND l_ecbb.ecbb011 IS NOT NULL) THEN
      #其說明的SQL
      LET g_ecch007 = ""
      IF NOT s_aect801_ins_ecch(p_ecchdocno,p_ecchseq,0,0,'ecbb011',g_ecch003,l_ecbb.ecbb011,l_eccb.eccb011,g_ecch007) THEN
         RETURN r_success
      END IF
      LET l_flag = 'Y'
   ELSE
      IF NOT s_aect801_del_ecch(p_ecchdocno,p_ecchseq,0,0,'ecbb011') THEN
         RETURN r_success
      END IF
   END IF
   
   #工作站
   IF (NOT cl_null(l_eccb.eccb012) AND (l_eccb.eccb012 != l_ecbb.ecbb012 OR l_ecbb.ecbb012 IS NULL)) OR (cl_null(l_eccb.eccb012) AND l_ecbb.ecbb012 IS NOT NULL) THEN
      #其說明的SQL
      LET g_ecch007 = "SELECT ecaa002 FROM ecaa_t WHERE ecaaent='"||g_enterprise||"' AND ecaasite='"||g_site||"' AND ecaa001='"||l_ecbb.ecbb012||"'"
      IF NOT s_aect801_ins_ecch(p_ecchdocno,p_ecchseq,0,0,'ecbb012',g_ecch003,l_ecbb.ecbb012,l_eccb.eccb012,g_ecch007) THEN
         RETURN r_success
      END IF
      LET l_flag = 'Y'
   ELSE
      IF NOT s_aect801_del_ecch(p_ecchdocno,p_ecchseq,0,0,'ecbb012') THEN
         RETURN r_success
      END IF
   END IF
   
   #委外
   IF (NOT cl_null(l_eccb.eccb013) AND (l_eccb.eccb013 != l_ecbb.ecbb013 OR l_ecbb.ecbb013 IS NULL)) OR (cl_null(l_eccb.eccb013) AND l_ecbb.ecbb013 IS NOT NULL) THEN
      #其說明的SQL
      LET g_ecch007 = ""
      IF NOT s_aect801_ins_ecch(p_ecchdocno,p_ecchseq,0,0,'ecbb013',g_ecch003,l_ecbb.ecbb013,l_eccb.eccb013,g_ecch007) THEN
         RETURN r_success
      END IF
      LET l_flag = 'Y'
   ELSE
      IF NOT s_aect801_del_ecch(p_ecchdocno,p_ecchseq,0,0,'ecbb013') THEN
         RETURN r_success
      END IF
   END IF
   
   #主要加工厂
   IF (NOT cl_null(l_eccb.eccb014) AND (l_eccb.eccb014 != l_ecbb.ecbb014 OR l_ecbb.ecbb014 IS NULL)) OR (cl_null(l_eccb.eccb014) AND l_ecbb.ecbb014 IS NOT NULL) THEN
      #其說明的SQL
      LET g_ecch007 = "SELECT pmaal004 FROM pmaal_t WHERE pmaalent='"||g_enterprise||"' AND pmaal001='"||l_ecbb.ecbb014||"' AND pmaal002=?"
      IF NOT s_aect801_ins_ecch(p_ecchdocno,p_ecchseq,0,0,'ecbb014',g_ecch003,l_ecbb.ecbb014,l_eccb.eccb014,g_ecch007) THEN
         RETURN r_success
      END IF
      LET l_flag = 'Y'
   ELSE
      IF NOT s_aect801_del_ecch(p_ecchdocno,p_ecchseq,0,0,'ecbb014') THEN
         RETURN r_success
      END IF
   END IF
   
   #Move in
   IF (NOT cl_null(l_eccb.eccb015) AND (l_eccb.eccb015 != l_ecbb.ecbb015 OR l_ecbb.ecbb015 IS NULL)) OR (cl_null(l_eccb.eccb015) AND l_ecbb.ecbb015 IS NOT NULL) THEN
      #其說明的SQL
      LET g_ecch007 = ""
      IF NOT s_aect801_ins_ecch(p_ecchdocno,p_ecchseq,0,0,'ecbb015',g_ecch003,l_ecbb.ecbb015,l_eccb.eccb015,g_ecch007) THEN
         RETURN r_success
      END IF
      LET l_flag = 'Y'
   ELSE
      IF NOT s_aect801_del_ecch(p_ecchdocno,p_ecchseq,0,0,'ecbb015') THEN
         RETURN r_success
      END IF
   END IF
   
   #Check in
   IF (NOT cl_null(l_eccb.eccb016) AND (l_eccb.eccb016 != l_ecbb.ecbb016 OR l_ecbb.ecbb016 IS NULL)) OR (cl_null(l_eccb.eccb016) AND l_ecbb.ecbb016 IS NOT NULL) THEN
      #其說明的SQL
      LET g_ecch007 = ""
      IF NOT s_aect801_ins_ecch(p_ecchdocno,p_ecchseq,0,0,'ecbb016',g_ecch003,l_ecbb.ecbb016,l_eccb.eccb016,g_ecch007) THEN
         RETURN r_success
      END IF
      LET l_flag = 'Y'
   ELSE
      IF NOT s_aect801_del_ecch(p_ecchdocno,p_ecchseq,0,0,'ecbb016') THEN
         RETURN r_success
      END IF
   END IF
   
   #报工站
   IF (NOT cl_null(l_eccb.eccb017) AND (l_eccb.eccb017 != l_ecbb.ecbb017 OR l_ecbb.ecbb017 IS NULL)) OR (cl_null(l_eccb.eccb017) AND l_ecbb.ecbb017 IS NOT NULL) THEN
      #其說明的SQL
      LET g_ecch007 = ""
      IF NOT s_aect801_ins_ecch(p_ecchdocno,p_ecchseq,0,0,'ecbb017',g_ecch003,l_ecbb.ecbb017,l_eccb.eccb017,g_ecch007) THEN
         RETURN r_success
      END IF
      LET l_flag = 'Y'
   ELSE
      IF NOT s_aect801_del_ecch(p_ecchdocno,p_ecchseq,0,0,'ecbb017') THEN
         RETURN r_success
      END IF
   END IF
   
   #PQC
   IF (NOT cl_null(l_eccb.eccb018) AND (l_eccb.eccb018 != l_ecbb.ecbb018 OR l_ecbb.ecbb018 IS NULL)) OR (cl_null(l_eccb.eccb018) AND l_ecbb.ecbb018 IS NOT NULL) THEN
      #其說明的SQL
      LET g_ecch007 = ""
      IF NOT s_aect801_ins_ecch(p_ecchdocno,p_ecchseq,0,0,'ecbb018',g_ecch003,l_ecbb.ecbb018,l_eccb.eccb018,g_ecch007) THEN
         RETURN r_success
      END IF
      LET l_flag = 'Y'
   ELSE
      IF NOT s_aect801_del_ecch(p_ecchdocno,p_ecchseq,0,0,'ecbb018') THEN
         RETURN r_success
      END IF
   END IF
   
   #Check out
   IF (NOT cl_null(l_eccb.eccb019) AND (l_eccb.eccb019 != l_ecbb.ecbb019 OR l_ecbb.ecbb019 IS NULL)) OR (cl_null(l_eccb.eccb019) AND l_ecbb.ecbb019 IS NOT NULL) THEN
      #其說明的SQL
      LET g_ecch007 = ""
      IF NOT s_aect801_ins_ecch(p_ecchdocno,p_ecchseq,0,0,'ecbb019',g_ecch003,l_ecbb.ecbb019,l_eccb.eccb019,g_ecch007) THEN
         RETURN r_success
      END IF
      LET l_flag = 'Y'
   ELSE
      IF NOT s_aect801_del_ecch(p_ecchdocno,p_ecchseq,0,0,'ecbb019') THEN
         RETURN r_success
      END IF
   END IF
   
   #Move out
   IF (NOT cl_null(l_eccb.eccb020) AND (l_eccb.eccb020 != l_ecbb.ecbb020 OR l_ecbb.ecbb020 IS NULL)) OR (cl_null(l_eccb.eccb020) AND l_ecbb.ecbb020 IS NOT NULL) THEN
      #其說明的SQL
      LET g_ecch007 = ""
      IF NOT s_aect801_ins_ecch(p_ecchdocno,p_ecchseq,0,0,'ecbb020',g_ecch003,l_ecbb.ecbb020,l_eccb.eccb020,g_ecch007) THEN
         RETURN r_success
      END IF
      LET l_flag = 'Y'
   ELSE
      IF NOT s_aect801_del_ecch(p_ecchdocno,p_ecchseq,0,0,'ecbb020') THEN
         RETURN r_success
      END IF
   END IF
   
   #转出单位
   IF (NOT cl_null(l_eccb.eccb021) AND (l_eccb.eccb021 != l_ecbb.ecbb021 OR l_ecbb.ecbb021 IS NULL)) OR (cl_null(l_eccb.eccb021) AND l_ecbb.ecbb021 IS NOT NULL) THEN
      #其說明的SQL
      LET g_ecch007 = "SELECT oocal003 FROM oocal_t WHERE oocalent='"||g_enterprise||"' AND oocal001='"||l_ecbb.ecbb021||"' AND oocal002=?"
      IF NOT s_aect801_ins_ecch(p_ecchdocno,p_ecchseq,0,0,'ecbb021',g_ecch003,l_ecbb.ecbb021,l_eccb.eccb021,g_ecch007) THEN
         RETURN r_success
      END IF
      LET l_flag = 'Y'
   ELSE
      IF NOT s_aect801_del_ecch(p_ecchdocno,p_ecchseq,0,0,'ecbb021') THEN
         RETURN r_success
      END IF
   END IF
   
   #转出单位转换率分子
   IF (NOT cl_null(l_eccb.eccb022) AND (l_eccb.eccb022 != l_ecbb.ecbb022 OR l_ecbb.ecbb022 IS NULL)) OR (cl_null(l_eccb.eccb022) AND l_ecbb.ecbb022 IS NOT NULL) THEN
      #其說明的SQL
      LET g_ecch007 = ""
      IF NOT s_aect801_ins_ecch(p_ecchdocno,p_ecchseq,0,0,'ecbb022',g_ecch003,l_ecbb.ecbb022,l_eccb.eccb022,g_ecch007) THEN
         RETURN r_success
      END IF
      LET l_flag = 'Y'
   ELSE
      IF NOT s_aect801_del_ecch(p_ecchdocno,p_ecchseq,0,0,'ecbb022') THEN
         RETURN r_success
      END IF
   END IF
   
   #转出单位转换率分母
   IF (NOT cl_null(l_eccb.eccb023) AND (l_eccb.eccb023 != l_ecbb.ecbb023 OR l_ecbb.ecbb023 IS NULL)) OR (cl_null(l_eccb.eccb023) AND l_ecbb.ecbb023 IS NOT NULL) THEN
      #其說明的SQL
      LET g_ecch007 = ""
      IF NOT s_aect801_ins_ecch(p_ecchdocno,p_ecchseq,0,0,'ecbb023',g_ecch003,l_ecbb.ecbb023,l_eccb.eccb023,g_ecch007) THEN
         RETURN r_success
      END IF
      LET l_flag = 'Y'
   ELSE
      IF NOT s_aect801_del_ecch(p_ecchdocno,p_ecchseq,0,0,'ecbb023') THEN
         RETURN r_success
      END IF
   END IF
   
   #固定工时
   IF (NOT cl_null(l_eccb.eccb024) AND (l_eccb.eccb024 != l_ecbb.ecbb024 OR l_ecbb.ecbb024 IS NULL)) OR (cl_null(l_eccb.eccb024) AND l_ecbb.ecbb024 IS NOT NULL) THEN
      #其說明的SQL
      LET g_ecch007 = ""
      IF NOT s_aect801_ins_ecch(p_ecchdocno,p_ecchseq,0,0,'ecbb024',g_ecch003,l_ecbb.ecbb024,l_eccb.eccb024,g_ecch007) THEN
         RETURN r_success
      END IF
      LET l_flag = 'Y'
   ELSE
      IF NOT s_aect801_del_ecch(p_ecchdocno,p_ecchseq,0,0,'ecbb024') THEN
         RETURN r_success
      END IF
   END IF
   
   #标准工时
   IF (NOT cl_null(l_eccb.eccb025) AND (l_eccb.eccb025 != l_ecbb.ecbb025 OR l_ecbb.ecbb025 IS NULL)) OR (cl_null(l_eccb.eccb025) AND l_ecbb.ecbb025 IS NOT NULL) THEN
      #其說明的SQL
      LET g_ecch007 = ""
      IF NOT s_aect801_ins_ecch(p_ecchdocno,p_ecchseq,0,0,'ecbb025',g_ecch003,l_ecbb.ecbb025,l_eccb.eccb025,g_ecch007) THEN
         RETURN r_success
      END IF
      LET l_flag = 'Y'
   ELSE
      IF NOT s_aect801_del_ecch(p_ecchdocno,p_ecchseq,0,0,'ecbb025') THEN
         RETURN r_success
      END IF
   END IF
   
   #固定机时
   IF (NOT cl_null(l_eccb.eccb026) AND (l_eccb.eccb026 != l_ecbb.ecbb026 OR l_ecbb.ecbb026 IS NULL)) OR (cl_null(l_eccb.eccb026) AND l_ecbb.ecbb026 IS NOT NULL) THEN
      #其說明的SQL
      LET g_ecch007 = ""
      IF NOT s_aect801_ins_ecch(p_ecchdocno,p_ecchseq,0,0,'ecbb026',g_ecch003,l_ecbb.ecbb026,l_eccb.eccb026,g_ecch007) THEN
         RETURN r_success
      END IF
      LET l_flag = 'Y'
   ELSE
      IF NOT s_aect801_del_ecch(p_ecchdocno,p_ecchseq,0,0,'ecbb026') THEN
         RETURN r_success
      END IF
   END IF
   
   #标准机时
   IF (NOT cl_null(l_eccb.eccb027) AND (l_eccb.eccb027 != l_ecbb.ecbb027 OR l_ecbb.ecbb027 IS NULL)) OR (cl_null(l_eccb.eccb027) AND l_ecbb.ecbb027 IS NOT NULL) THEN
      #其說明的SQL
      LET g_ecch007 = ""
      IF NOT s_aect801_ins_ecch(p_ecchdocno,p_ecchseq,0,0,'ecbb027',g_ecch003,l_ecbb.ecbb027,l_eccb.eccb027,g_ecch007) THEN
         RETURN r_success
      END IF
      LET l_flag = 'Y'
   ELSE
      IF NOT s_aect801_del_ecch(p_ecchdocno,p_ecchseq,0,0,'ecbb027') THEN
         RETURN r_success
      END IF
   END IF
   
   #完成度
   IF (NOT cl_null(l_eccb.eccb028) AND (l_eccb.eccb028 != l_ecbb.ecbb028 OR l_ecbb.ecbb028 IS NULL)) OR (cl_null(l_eccb.eccb028) AND l_ecbb.ecbb028 IS NOT NULL) THEN
      #其說明的SQL
      LET g_ecch007 = ""
      IF NOT s_aect801_ins_ecch(p_ecchdocno,p_ecchseq,0,0,'ecbb028',g_ecch003,l_ecbb.ecbb028,l_eccb.eccb028,g_ecch007) THEN
         RETURN r_success
      END IF
      LET l_flag = 'Y'
   ELSE
      IF NOT s_aect801_del_ecch(p_ecchdocno,p_ecchseq,0,0,'ecbb028') THEN
         RETURN r_success
      END IF
   END IF
   
   #标准单价
   IF (NOT cl_null(l_eccb.eccb029) AND (l_eccb.eccb029 != l_ecbb.ecbb029 OR l_ecbb.ecbb029 IS NULL)) OR (cl_null(l_eccb.eccb029) AND l_ecbb.ecbb029 IS NOT NULL) THEN
      #其說明的SQL
      LET g_ecch007 = ""
      IF NOT s_aect801_ins_ecch(p_ecchdocno,p_ecchseq,0,0,'ecbb029',g_ecch003,l_ecbb.ecbb029,l_eccb.eccb029,g_ecch007) THEN
         RETURN r_success
      END IF
      LET l_flag = 'Y'
   ELSE
      IF NOT s_aect801_del_ecch(p_ecchdocno,p_ecchseq,0,0,'ecbb029') THEN
         RETURN r_success
      END IF
   END IF
   
   #转入单位
   IF (NOT cl_null(l_eccb.eccb030) AND (l_eccb.eccb030 != l_ecbb.ecbb030 OR l_ecbb.ecbb030 IS NULL)) OR (cl_null(l_eccb.eccb030) AND l_ecbb.ecbb030 IS NOT NULL) THEN
      #其說明的SQL
      LET g_ecch007 = "SELECT oocal003 FROM oocal_t WHERE oocalent='"||g_enterprise||"' AND oocal001='"||l_ecbb.ecbb030||"' AND oocal002=?"
      IF NOT s_aect801_ins_ecch(p_ecchdocno,p_ecchseq,0,0,'ecbb030',g_ecch003,l_ecbb.ecbb030,l_eccb.eccb030,g_ecch007) THEN
         RETURN r_success
      END IF
      LET l_flag = 'Y'
   ELSE
      IF NOT s_aect801_del_ecch(p_ecchdocno,p_ecchseq,0,0,'ecbb030') THEN
         RETURN r_success
      END IF
   END IF
   
   #转入单位转换率分子
   IF (NOT cl_null(l_eccb.eccb031) AND (l_eccb.eccb031 != l_ecbb.ecbb031 OR l_ecbb.ecbb031 IS NULL)) OR (cl_null(l_eccb.eccb031) AND l_ecbb.ecbb031 IS NOT NULL) THEN
      #其說明的SQL
      LET g_ecch007 = ""
      IF NOT s_aect801_ins_ecch(p_ecchdocno,p_ecchseq,0,0,'ecbb031',g_ecch003,l_ecbb.ecbb031,l_eccb.eccb031,g_ecch007) THEN
         RETURN r_success
      END IF
      LET l_flag = 'Y'
   ELSE
      IF NOT s_aect801_del_ecch(p_ecchdocno,p_ecchseq,0,0,'ecbb031') THEN
         RETURN r_success
      END IF
   END IF
   
   #转入单位转换率分母
   IF (NOT cl_null(l_eccb.eccb032) AND (l_eccb.eccb032 != l_ecbb.ecbb032 OR l_ecbb.ecbb032 IS NULL)) OR (cl_null(l_eccb.eccb032) AND l_ecbb.ecbb032 IS NOT NULL) THEN
      #其說明的SQL
      LET g_ecch007 = ""
      IF NOT s_aect801_ins_ecch(p_ecchdocno,p_ecchseq,0,0,'ecbb032',g_ecch003,l_ecbb.ecbb032,l_eccb.eccb032,g_ecch007) THEN
         RETURN r_success
      END IF
      LET l_flag = 'Y'
   ELSE
      IF NOT s_aect801_del_ecch(p_ecchdocno,p_ecchseq,0,0,'ecbb032') THEN
         RETURN r_success
      END IF
   END IF
   
   #回收站
   IF (NOT cl_null(l_eccb.eccb033) AND (l_eccb.eccb033 != l_ecbb.ecbb033 OR l_ecbb.ecbb033 IS NULL)) OR (cl_null(l_eccb.eccb033) AND l_ecbb.ecbb033 IS NOT NULL) THEN
      #其說明的SQL
      LET g_ecch007 = ""
      IF NOT s_aect801_ins_ecch(p_ecchdocno,p_ecchseq,0,0,'ecbb033',g_ecch003,l_ecbb.ecbb033,l_eccb.eccb033,g_ecch007) THEN
         RETURN r_success
      END IF
      LET l_flag = 'Y'
   ELSE
      IF NOT s_aect801_del_ecch(p_ecchdocno,p_ecchseq,0,0,'ecbb033') THEN
         RETURN r_success
      END IF
   END IF
   
   #后置时间
   IF (NOT cl_null(l_eccb.eccb034) AND (l_eccb.eccb034 != l_ecbb.ecbb034 OR l_ecbb.ecbb034 IS NULL)) OR (cl_null(l_eccb.eccb034) AND l_ecbb.ecbb034 IS NOT NULL) THEN
      #其說明的SQL
      LET g_ecch007 = ""
      IF NOT s_aect801_ins_ecch(p_ecchdocno,p_ecchseq,0,0,'ecbb034',g_ecch003,l_ecbb.ecbb034,l_eccb.eccb034,g_ecch007) THEN
         RETURN r_success
      END IF
      LET l_flag = 'Y'
   ELSE
      IF NOT s_aect801_del_ecch(p_ecchdocno,p_ecchseq,0,0,'ecbb034') THEN
         RETURN r_success
      END IF
   END IF
   
   #X轴
   IF (NOT cl_null(l_eccb.eccb035) AND (l_eccb.eccb035 != l_ecbb.ecbb035 OR l_ecbb.ecbb035 IS NULL)) OR (cl_null(l_eccb.eccb035) AND l_ecbb.ecbb035 IS NOT NULL) THEN
      #其說明的SQL
      LET g_ecch007 = ""
      IF NOT s_aect801_ins_ecch(p_ecchdocno,p_ecchseq,0,0,'ecbb035',g_ecch003,l_ecbb.ecbb035,l_eccb.eccb035,g_ecch007) THEN
         RETURN r_success
      END IF
      LET l_flag = 'Y'
   ELSE
      IF NOT s_aect801_del_ecch(p_ecchdocno,p_ecchseq,0,0,'ecbb035') THEN
         RETURN r_success
      END IF
   END IF
   
   #Y轴
   IF (NOT cl_null(l_eccb.eccb036) AND (l_eccb.eccb036 != l_ecbb.ecbb036 OR l_ecbb.ecbb036 IS NULL)) OR (cl_null(l_eccb.eccb036) AND l_ecbb.ecbb036 IS NOT NULL) THEN
      #其說明的SQL
      LET g_ecch007 = ""
      IF NOT s_aect801_ins_ecch(p_ecchdocno,p_ecchseq,0,0,'ecbb036',g_ecch003,l_ecbb.ecbb036,l_eccb.eccb036,g_ecch007) THEN
         RETURN r_success
      END IF
      LET l_flag = 'Y'
   ELSE
      IF NOT s_aect801_del_ecch(p_ecchdocno,p_ecchseq,0,0,'ecbb036') THEN
         RETURN r_success
      END IF
   END IF
   
   #备注
   IF (NOT cl_null(l_ooff013_new) AND (l_ooff013_new != l_ooff013 OR l_ooff013 IS NULL)) OR (cl_null(l_ooff013_new) AND l_ooff013 IS NOT NULL) THEN
      #其說明的SQL
      LET g_ecch007 = ""
      IF NOT s_aect801_ins_ecch(p_ecchdocno,p_ecchseq,0,0,'ooff013',g_ecch003,l_ooff013,l_ooff013_new,g_ecch007) THEN
         RETURN r_success
      END IF
      LET l_flag = 'Y'
   ELSE
      IF NOT s_aect801_del_ecch(p_ecchdocno,p_ecchseq,0,0,'ooff013') THEN
         RETURN r_success
      END IF
   END IF
   
   #制程单身未有发生变更，则更新eccb901
   IF l_flag = 'N' THEN
      UPDATE eccb_t SET eccb901 = '1' WHERE eccbent = g_enterprise AND eccbsite = g_site
         AND eccbdocno =p_ecchdocno AND eccb003 = p_ecchseq
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "upd eccb901"
         LET g_errparam.popup = TRUE
         CALL cl_err()
         RETURN r_success
      END IF
   END IF
   
   LET r_success = TRUE
   RETURN r_success
END FUNCTION

#制程单身用料底稿档
PRIVATE FUNCTION aect801_upd_eccc_ecch(p_ecchdocno,p_ecchseq,p_ecchseq1)
DEFINE p_ecchdocno                LIKE ecch_t.ecchdocno
DEFINE p_ecchseq                  LIKE ecch_t.ecchseq
DEFINE p_ecchseq1                 LIKE ecch_t.ecchseq1
DEFINE r_success                  LIKE type_t.num5
#DEFINE l_ecbc                     RECORD LIKE ecbc_t.*  #161124-00048#2     2016/12/06 By 08734 mark
#161124-00048#2     2016/12/06 By 08734 add(S)
DEFINE l_ecbc RECORD  #料件製程用料底稿
       ecbcent LIKE ecbc_t.ecbcent, #企业编号
       ecbcsite LIKE ecbc_t.ecbcsite, #营运据点
       ecbc001 LIKE ecbc_t.ecbc001, #工艺料号
       ecbc002 LIKE ecbc_t.ecbc002, #工艺编号
       ecbc003 LIKE ecbc_t.ecbc003, #工艺项次
       ecbc004 LIKE ecbc_t.ecbc004, #项次
       ecbc005 LIKE ecbc_t.ecbc005, #元件料号
       ecbc006 LIKE ecbc_t.ecbc006, #部位
       ecbc007 LIKE ecbc_t.ecbc007, #组成用量
       ecbc008 LIKE ecbc_t.ecbc008, #主件底数
       ecbc009 LIKE ecbc_t.ecbc009, #用量单位
       ecbc010 LIKE ecbc_t.ecbc010 #损耗率型态
END RECORD
#161124-00048#2     2016/12/06 By 08734 add(E)
#DEFINE l_eccc                     RECORD LIKE eccc_t.*  #161124-00048#2     2016/12/06 By 08734 mark
#161124-00048#2     2016/12/06 By 08734 add(S)
DEFINE l_eccc RECORD  #料件製程變更用料底稿
       ecccent LIKE eccc_t.ecccent, #企业编号
       ecccsite LIKE eccc_t.ecccsite, #营运据点
       ecccdocno LIKE eccc_t.ecccdocno, #申请单号
       eccc001 LIKE eccc_t.eccc001, #工艺料号
       eccc002 LIKE eccc_t.eccc002, #工艺编号
       eccc003 LIKE eccc_t.eccc003, #工艺项次
       eccc004 LIKE eccc_t.eccc004, #项次
       eccc005 LIKE eccc_t.eccc005, #元件料号
       eccc006 LIKE eccc_t.eccc006, #部位
       eccc007 LIKE eccc_t.eccc007, #组成用量
       eccc008 LIKE eccc_t.eccc008, #主件底数
       eccc009 LIKE eccc_t.eccc009, #用量单位
       eccc010 LIKE eccc_t.eccc010, #损耗率形态
       eccc900 LIKE eccc_t.eccc900, #变更序
       eccc901 LIKE eccc_t.eccc901, #变更类型
       eccc902 LIKE eccc_t.eccc902, #变更日期
       eccc905 LIKE eccc_t.eccc905, #变更理由
       eccc906 LIKE eccc_t.eccc906 #变更备注
END RECORD
#161124-00048#2     2016/12/06 By 08734 add(E)
DEFINE l_flag                     LIKE type_t.chr1

   LET r_success = FALSE
   LET l_flag = 'N'
   IF g_ecca_m.ecca004 = '1' THEN
      LET r_success = TRUE
      RETURN r_success
   END IF
   IF cl_null(p_ecchdocno) OR cl_null(p_ecchseq) OR cl_null(p_ecchseq1) THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'sub-00001'
      LET g_errparam.extend = ''
      LET g_errparam.popup = TRUE
      CALL cl_err()
      RETURN r_success
   END IF
   
   INITIALIZE l_ecbc.* TO NULL
   INITIALIZE l_eccc.* TO NULL
  # SELECT * INTO l_eccc.* FROM eccc_t WHERE ecccent = g_enterprise AND ecccsite = g_site #161124-00048#2     2016/12/06 By 08734 mark
   SELECT ecccent,ecccsite,ecccdocno,eccc001,eccc002,eccc003,eccc004,eccc005,eccc006,eccc007,eccc008,eccc009,eccc010,eccc900,eccc901,eccc902,eccc905,eccc906 #161124-00048#2     2016/12/06 By 08734 add 
     INTO l_eccc.* FROM eccc_t WHERE ecccent = g_enterprise AND ecccsite = g_site
      AND ecccdocno = p_ecchdocno AND eccc003 = p_ecchseq AND eccc004 = p_ecchseq1
      
   IF l_eccc.eccc901 = '1' THEN
      LET r_success = TRUE
      RETURN r_success
   END IF
   
   IF l_eccc.eccc901 = '2' OR l_eccc.eccc901 = '4' THEN
      #SELECT * INTO l_ecbc.* FROM ecbc_t WHERE ecbcent = g_enterprise AND ecbcsite = g_site #161124-00048#2     2016/12/06 By 08734 mark
      SELECT ecbcent,ecbcsite,ecbc001,ecbc002,ecbc003,ecbc004,ecbc005,ecbc006,ecbc007,ecbc008,ecbc009,ecbc010  #161124-00048#2     2016/12/06 By 08734 add
        INTO l_ecbc.* FROM ecbc_t WHERE ecbcent = g_enterprise AND ecbcsite = g_site
         AND ecbc001 = g_ecca_m.ecca001 AND ecbc002 = g_ecca_m.ecca002
         AND ecbc003 = p_ecchseq AND ecbc004 = p_ecchseq1
   END IF
      
   LET g_ecch003 = ''
   IF l_eccc.eccc901 = '2' THEN
      LET g_ecch003 = '13'
   END IF
   IF l_eccc.eccc901 = '3' THEN
      LET g_ecch003 = '14'
   END IF
   IF l_eccc.eccc901 = '4' THEN
      INITIALIZE l_eccc.* TO NULL
      LET g_ecch003 = '15'
   END IF
   
   #项次
   IF (NOT cl_null(l_eccc.eccc004) AND (l_eccc.eccc004 != l_ecbc.ecbc004 OR l_ecbc.ecbc004 IS NULL)) OR (cl_null(l_eccc.eccc004) AND l_ecbc.ecbc004 IS NOT NULL) THEN
      #其說明的SQL
      LET g_ecch007 = ""
      IF NOT s_aect801_ins_ecch(p_ecchdocno,p_ecchseq,p_ecchseq1,0,'ecbc004',g_ecch003,l_ecbc.ecbc004,l_eccc.eccc004,g_ecch007) THEN
         RETURN r_success
      END IF
      LET l_flag = 'Y'
   ELSE
      IF NOT s_aect801_del_ecch(p_ecchdocno,p_ecchseq,p_ecchseq1,0,'ecbc004') THEN
         RETURN r_success
      END IF
   END IF
   
   #元件料号
   IF (NOT cl_null(l_eccc.eccc005) AND (l_eccc.eccc005 != l_ecbc.ecbc005 OR l_ecbc.ecbc005 IS NULL)) OR (cl_null(l_eccc.eccc005) AND l_ecbc.ecbc005 IS NOT NULL) THEN
      #其說明的SQL
      LET g_ecch007 = "SELECT imaal003 FROM imaal_t WHERE imaalent='"||g_enterprise||"' AND imaal001='"||l_ecbc.ecbc005||"' AND imaal002=? "
      IF NOT s_aect801_ins_ecch(p_ecchdocno,p_ecchseq,p_ecchseq1,0,'ecbc005',g_ecch003,l_ecbc.ecbc005,l_eccc.eccc005,g_ecch007) THEN
         RETURN r_success
      END IF
      LET l_flag = 'Y'
   ELSE
      IF NOT s_aect801_del_ecch(p_ecchdocno,p_ecchseq,p_ecchseq1,0,'ecbc005') THEN
         RETURN r_success
      END IF
   END IF
   
   #部位
   IF (NOT cl_null(l_eccc.eccc006) AND (l_eccc.eccc006 != l_ecbc.ecbc006 OR l_ecbc.ecbc006 IS NULL)) OR (cl_null(l_eccc.eccc006) AND l_ecbc.ecbc006 IS NOT NULL) THEN
      #其說明的SQL
      LET g_ecch007 = "SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001='215' AND oocql002='"||l_ecbc.ecbc006||"' AND oocql003=? "
      IF NOT s_aect801_ins_ecch(p_ecchdocno,p_ecchseq,p_ecchseq1,0,'ecbc006',g_ecch003,l_ecbc.ecbc006,l_eccc.eccc006,g_ecch007) THEN
         RETURN r_success
      END IF
      LET l_flag = 'Y'
   ELSE
      IF NOT s_aect801_del_ecch(p_ecchdocno,p_ecchseq,p_ecchseq1,0,'ecbc006') THEN
         RETURN r_success
      END IF
   END IF
   
   #组成用量
   IF (NOT cl_null(l_eccc.eccc007) AND (l_eccc.eccc007 != l_ecbc.ecbc007 OR l_ecbc.ecbc007 IS NULL)) OR (cl_null(l_eccc.eccc007) AND l_ecbc.ecbc007 IS NOT NULL) THEN
      #其說明的SQL
      LET g_ecch007 = ""
      IF NOT s_aect801_ins_ecch(p_ecchdocno,p_ecchseq,p_ecchseq1,0,'ecbc007',g_ecch003,l_ecbc.ecbc007,l_eccc.eccc007,g_ecch007) THEN
         RETURN r_success
      END IF
      LET l_flag = 'Y'
   ELSE
      IF NOT s_aect801_del_ecch(p_ecchdocno,p_ecchseq,p_ecchseq1,0,'ecbc007') THEN
         RETURN r_success
      END IF
   END IF
   
   #主件底数
   IF (NOT cl_null(l_eccc.eccc008) AND (l_eccc.eccc008 != l_ecbc.ecbc008 OR l_ecbc.ecbc008 IS NULL)) OR (cl_null(l_eccc.eccc008) AND l_ecbc.ecbc008 IS NOT NULL) THEN
      #其說明的SQL
      LET g_ecch007 = ""
      IF NOT s_aect801_ins_ecch(p_ecchdocno,p_ecchseq,p_ecchseq1,0,'ecbc008',g_ecch003,l_ecbc.ecbc008,l_eccc.eccc008,g_ecch007) THEN
         RETURN r_success
      END IF
      LET l_flag = 'Y'
   ELSE
      IF NOT s_aect801_del_ecch(p_ecchdocno,p_ecchseq,p_ecchseq1,0,'ecbc008') THEN
         RETURN r_success
      END IF
   END IF
   
   #用量单位
   IF (NOT cl_null(l_eccc.eccc009) AND (l_eccc.eccc009 != l_ecbc.ecbc009 OR l_ecbc.ecbc009 IS NULL)) OR (cl_null(l_eccc.eccc009) AND l_ecbc.ecbc009 IS NOT NULL) THEN
      #其說明的SQL
      LET g_ecch007 = "SELECT oocal003 FROM oocal_t WHERE oocalent='"||g_enterprise||"' AND oocal001='"||l_ecbc.ecbc009||"' AND oocal002=? "
      IF NOT s_aect801_ins_ecch(p_ecchdocno,p_ecchseq,p_ecchseq1,0,'ecbc009',g_ecch003,l_ecbc.ecbc009,l_eccc.eccc009,g_ecch007) THEN
         RETURN r_success
      END IF
      LET l_flag = 'Y'
   ELSE
      IF NOT s_aect801_del_ecch(p_ecchdocno,p_ecchseq,p_ecchseq1,0,'ecbc009') THEN
         RETURN r_success
      END IF
   END IF
   
   #损耗率形态
   IF (NOT cl_null(l_eccc.eccc010) AND (l_eccc.eccc010 != l_ecbc.ecbc010 OR l_ecbc.ecbc010 IS NULL)) OR (cl_null(l_eccc.eccc010) AND l_ecbc.ecbc010 IS NOT NULL) THEN
      #其說明的SQL
      LET g_ecch007 = ""
      IF NOT s_aect801_ins_ecch(p_ecchdocno,p_ecchseq,p_ecchseq1,0,'ecbc010',g_ecch003,l_ecbc.ecbc010,l_eccc.eccc010,g_ecch007) THEN
         RETURN r_success
      END IF
      LET l_flag = 'Y'
   ELSE
      IF NOT s_aect801_del_ecch(p_ecchdocno,p_ecchseq,p_ecchseq1,0,'ecbc010') THEN
         RETURN r_success
      END IF
   END IF
   
   #制程用料底稿未有发生变更，则更新eccc901
   IF l_flag = 'N' THEN
      UPDATE eccc_t SET eccc901 = '1' WHERE ecccent = g_enterprise AND ecccsite = g_site
         AND ecccdocno = p_ecchdocno AND eccc003 = p_ecchseq AND eccc004 = p_ecchseq1
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "upd eccc901"
         LET g_errparam.popup = TRUE
         CALL cl_err()
         RETURN r_success
      END IF
   END IF
   
   LET r_success = TRUE
   RETURN r_success
END FUNCTION

##单头ecca栏位有差异值颜色显示
PRIVATE FUNCTION aect801_ecca_color()
DEFINE l_ecch002         LIKE ecch_t.ecch002

   CALL cl_set_comp_font_color("ecca003","black")
   SELECT ecch002 INTO l_ecch002 FROM ecch_t WHERE ecchent = g_enterprise AND ecchsite = g_site 
      AND ecchdocno = g_ecca_m.eccadocno AND ecchseq = 0 AND ecchseq1 = 0
   LET l_ecch002 = cl_replace_str(l_ecch002,'ecba','ecca')                                                        
   CALL cl_set_comp_font_color(l_ecch002,"red")  
END FUNCTION

#制程单身栏位差异资料颜色显示
PRIVATE FUNCTION aect801_eccb_color()
DEFINE l_ecch002         LIKE ecch_t.ecch002

   CALL aect801_eccb_color_init()
   
   DECLARE sel_eccb_ecch_cs CURSOR FOR
    SELECT ecch002 FROM ecch_t
     WHERE ecchent   = g_enterprise AND ecchsite = g_site
       AND ecchdocno = g_ecca_m.eccadocno
       AND ecchseq   = g_eccb_d[l_ac].eccb003
       AND ecchseq1  = 0 
       AND (ecch002 LIKE 'ecbb%' OR ecch002 = 'ooff013')        
   FOREACH sel_eccb_ecch_cs INTO l_ecch002
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "FOREACH:"
         LET g_errparam.popup = TRUE
         CALL cl_err()

         EXIT FOREACH
      END IF
      
      LET l_ecch002 = cl_replace_str(l_ecch002,'ecbb','eccb')

      CASE l_ecch002
         WHEN 'eccb003' 
            LET g_eccb_d_color[l_ac].eccb003       = 'red'
         WHEN 'eccb004' 
            LET g_eccb_d_color[l_ac].eccb004       = 'red'
            LET g_eccb_d_color[l_ac].eccb004_desc  = 'red'
         WHEN 'eccb005' 
            LET g_eccb_d_color[l_ac].eccb005       = 'red'
         WHEN 'eccb006' 
            LET g_eccb_d_color[l_ac].eccb006       = 'red'
         WHEN 'eccb007' 
            LET g_eccb_d_color[l_ac].eccb007       = 'red'
         WHEN 'eccb008' 
            LET g_eccb_d_color[l_ac].eccb008       = 'red'
            LET g_eccb_d_color[l_ac].eccb008_desc  = 'red'
         WHEN 'eccb009' 
            LET g_eccb_d_color[l_ac].eccb009       = 'red'
         WHEN 'eccb010' 
            LET g_eccb_d_color[l_ac].eccb010       = 'red'
            LET g_eccb_d_color[l_ac].eccb010_desc  = 'red'
         WHEN 'eccb011' 
            LET g_eccb_d_color[l_ac].eccb011       = 'red'
         WHEN 'eccb012' 
            LET g_eccb_d_color[l_ac].eccb012       = 'red'
            LET g_eccb_d_color[l_ac].eccb012_desc  = 'red'
         WHEN 'eccb013' 
            LET g_eccb_d_color[l_ac].eccb013       = 'red'
         WHEN 'eccb014' 
            LET g_eccb_d_color[l_ac].eccb014       = 'red'
            LET g_eccb_d_color[l_ac].eccb014_desc  = 'red'
         WHEN 'eccb015' 
            LET g_eccb_d_color[l_ac].eccb015       = 'red'
         WHEN 'eccb016' 
            LET g_eccb_d_color[l_ac].eccb016       = 'red'
         WHEN 'eccb017' 
            LET g_eccb_d_color[l_ac].eccb017       = 'red'
         WHEN 'eccb018' 
            LET g_eccb_d_color[l_ac].eccb018       = 'red'
         WHEN 'eccb019' 
            LET g_eccb_d_color[l_ac].eccb019       = 'red'
         WHEN 'eccb020' 
            LET g_eccb_d_color[l_ac].eccb020       = 'red'
         WHEN 'eccb021' 
            LET g_eccb_d_color[l_ac].eccb021       = 'red'
            LET g_eccb_d_color[l_ac].eccb021_desc  = 'red'
         WHEN 'eccb022' 
            LET g_eccb_d_color[l_ac].eccb022       = 'red'
         WHEN 'eccb023' 
            LET g_eccb_d_color[l_ac].eccb023       = 'red'
         WHEN 'eccb024' 
            LET g_eccb_d_color[l_ac].eccb024       = 'red'
         WHEN 'eccb025' 
            LET g_eccb_d_color[l_ac].eccb025       = 'red'
         WHEN 'eccb026' 
            LET g_eccb_d_color[l_ac].eccb026       = 'red'
         WHEN 'eccb027' 
            LET g_eccb_d_color[l_ac].eccb027       = 'red'
         WHEN 'eccb028' 
            LET g_eccb_d_color[l_ac].eccb028       = 'red'
         WHEN 'eccb029' 
            LET g_eccb_d_color[l_ac].eccb029       = 'red'
         WHEN 'eccb030' 
            LET g_eccb_d_color[l_ac].eccb030       = 'red'
            LET g_eccb_d_color[l_ac].eccb030_desc  = 'red'
         WHEN 'eccb031' 
            LET g_eccb_d_color[l_ac].eccb031       = 'red'
         WHEN 'eccb032' 
            LET g_eccb_d_color[l_ac].eccb032       = 'red'
         WHEN 'eccb033' 
            LET g_eccb_d_color[l_ac].eccb033       = 'red'
         WHEN 'eccb034' 
            LET g_eccb_d_color[l_ac].eccb034       = 'red'
         WHEN 'eccb035' 
            LET g_eccb_d_color[l_ac].eccb035       = 'red'
         WHEN 'eccb036' 
            LET g_eccb_d_color[l_ac].eccb036       = 'red'
      END CASE
   END FOREACH
            
END FUNCTION

#制程用料底稿档差异栏位颜色显示
PRIVATE FUNCTION aect801_eccc_color()
DEFINE l_ecch002        LIKE ecch_t.ecch002

   CALL aect801_eccc_color_init()
   
   DECLARE sel_eccc_ecch_cs CURSOR FOR
    SELECT ecch002 FROM ecch_t
     WHERE ecchent   = g_enterprise AND ecchsite = g_site
       AND ecchdocno = g_ecca_m.eccadocno
       AND ecchseq   = g_eccb_d[g_detail_idx].eccb003
       AND ecchseq1  = g_eccb2_d[l_ac].eccc004
       AND ecch002 LIKE 'ecbc%'         
   FOREACH sel_eccc_ecch_cs INTO l_ecch002
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "FOREACH:"
         LET g_errparam.popup = TRUE
         CALL cl_err()

         EXIT FOREACH
      END IF
      
      LET l_ecch002 = cl_replace_str(l_ecch002,'ecbc','eccc')

      CASE l_ecch002
         WHEN 'eccc004' 
            LET g_eccb2_d_color[l_ac].eccc004       = 'red'
         WHEN 'eccc005' 
            LET g_eccb2_d_color[l_ac].eccc005       = 'red'
            LET g_eccb2_d_color[l_ac].eccc005_desc  = 'red'
            LET g_eccb2_d_color[l_ac].eccc005_desc_1= 'red'
         WHEN 'eccc006' 
            LET g_eccb2_d_color[l_ac].eccc006       = 'red'
            LET g_eccb2_d_color[l_ac].eccc006_desc  = 'red'
         WHEN 'eccc007' 
            LET g_eccb2_d_color[l_ac].eccc007       = 'red'
         WHEN 'eccc008' 
            LET g_eccb2_d_color[l_ac].eccc008       = 'red'
         WHEN 'eccc009' 
            LET g_eccb2_d_color[l_ac].eccc009       = 'red'
            LET g_eccb2_d_color[l_ac].eccc009_desc  = 'red'
         WHEN 'eccc010' 
            LET g_eccb2_d_color[l_ac].eccc010       = 'red'
      END CASE
   END FOREACH
END FUNCTION

#单身3资料显示
PRIVATE FUNCTION aect801_b_fill3()
   IF g_detail_idx = 0 OR cl_null(g_detail_idx) THEN
      RETURN
   END IF
   IF g_detail_idx2 = 0 OR cl_null(g_detail_idx2) THEN
      RETURN
   END IF
   CALL g_eccb3_d.clear()
   IF cl_null(g_eccb2_d[g_detail_idx2].eccc004) THEN
      CALL g_eccb2_d.deleteElement(g_detail_idx2)
      RETURN
   END IF
   LET g_sql = "SELECT UNIQUE eccdseq,eccd005,eccd006,eccd007,eccd008,eccd901,eccd905,'',eccd906 ",
               "  FROM eccd_t",   
               " WHERE eccdent=? AND eccdsite=? AND eccddocno=? AND eccd003 = ? AND eccd004 = ? "
   
   IF NOT cl_null(g_wc2_table3) THEN
      LET g_sql = g_sql CLIPPED, " AND ", g_wc2_table3 CLIPPED
   END IF
   
   LET g_sql = g_sql, " ORDER BY eccd_t.eccd005"
   
   PREPARE aect801_pb3 FROM g_sql
   DECLARE b_fill_cs3 CURSOR FOR aect801_pb3

   LET g_cnt = l_ac
   LET l_ac = 1
   
   OPEN b_fill_cs3 USING g_enterprise, g_site,g_ecca_m.eccadocno,g_eccb_d[g_detail_idx].eccb003,g_eccb2_d[g_detail_idx2].eccc004
                                           
   FOREACH b_fill_cs3 INTO g_eccb3_d[l_ac].*
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "FOREACH:"
         LET g_errparam.popup = TRUE
         CALL cl_err()

         EXIT FOREACH
      END IF
      
      CALL aect801_eccd_color()
      
      LET l_ac = l_ac + 1
      IF l_ac > g_max_rec AND g_error_show = 1 THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code =  9035
         LET g_errparam.extend =  ''
         LET g_errparam.popup = TRUE
         CALL cl_err()

         EXIT FOREACH
      END IF
   END FOREACH
   LET g_error_show = 0
   LET g_rec_b2 = l_ac - 1 
   CALL g_eccb3_d.deleteElement(g_eccb3_d.getLength())

   LET l_ac = g_cnt
   LET g_cnt = 0  
   
   FREE aect801_pb3
END FUNCTION

#用料底稿损耗率差异栏位颜色显示
PRIVATE FUNCTION aect801_eccd_color()
DEFINE l_ecch002         LIKE ecch_t.ecch002

   CALL aect801_eccd_color_init()
   
   DECLARE sel_eccd_ecch_cs CURSOR FOR
    SELECT ecch002 FROM ecch_t
     WHERE ecchent   = g_enterprise AND ecchsite = g_site
       AND ecchdocno = g_ecca_m.eccadocno
       AND ecchseq   = g_eccb_d[g_detail_idx].eccb003
       AND ecchseq1  = g_eccb2_d[g_detail_idx2].eccc004
       AND ecchseq2  = g_eccb3_d[l_ac].eccdseq       
       AND ecch002 LIKE 'ecbd%'         
   FOREACH sel_eccd_ecch_cs INTO l_ecch002
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "FOREACH:"
         LET g_errparam.popup = TRUE
         CALL cl_err()

         EXIT FOREACH
      END IF
      
      LET l_ecch002 = cl_replace_str(l_ecch002,'ecbd','eccd')

      CASE l_ecch002
         WHEN 'eccd005' 
            LET g_eccb3_d_color[l_ac].eccd005       = 'red'
         WHEN 'eccd006' 
            LET g_eccb3_d_color[l_ac].eccd006       = 'red'
         WHEN 'eccd007' 
            LET g_eccb3_d_color[l_ac].eccd007       = 'red'
         WHEN 'eccd008' 
            LET g_eccb3_d_color[l_ac].eccd008       = 'red'
      END CASE
   END FOREACH
END FUNCTION

#起始截止栏位检查
PRIVATE FUNCTION aect801_chk_eccd005(p_qty,p_type,p_cmd)
DEFINE p_qty       LIKE eccd_t.eccd005
DEFINE p_type      LIKE type_t.chr1     #1.eccd005 2.eccd006
DEFINE p_cmd       LIKE type_t.chr1
DEFINE l_n         LIKE type_t.num5
DEFINE l_sql       STRING
DEFINE l_eccd005   LIKE eccd_t.eccd005
DEFINE l_eccd006   LIKE eccd_t.eccd006

   LET g_errno = ""
   IF cl_null(g_detail_idx) OR g_detail_idx = 0 THEN RETURN END IF
   IF cl_null(g_detail_idx2) OR g_detail_idx2 = 0 THEN RETURN END IF
   
   IF p_cmd = 'a' THEN
      LET l_sql = " SELECT eccd005,eccd006 ",
                  "   FROM eccd_t",
                  "  WHERE eccdent = '",g_enterprise,"' ",
                  "    AND eccdsite = '",g_site,"' ",
                  "    AND eccd001 = '",g_ecca_m.ecca001,"' ",
                  "    AND eccd002 = '",g_ecca_m.ecca002,"' ",
                  "    AND eccd003 = '",g_eccb_d[g_detail_idx].eccb003,"'",
                  "    AND eccd004 = '",g_eccb2_d[g_detail_idx2].eccc004,"'"
   ELSE
      LET l_sql = " SELECT eccd005,eccd006",
                  "   FROM eccd_t",
                  "  WHERE eccdent = '",g_enterprise,"' ",
                  "    AND eccdsite = '",g_site,"' ",
                  "    AND eccd001 = '",g_ecca_m.ecca001,"' ",
                  "    AND eccd002 = '",g_ecca_m.ecca002,"' ",
                  "    AND eccd003 = '",g_eccb_d[g_detail_idx].eccb003,"'",
                  "    AND eccd004 = '",g_eccb2_d[g_detail_idx2].eccc004,"'",
                  "    AND eccd005 <> '",g_eccb3_d_t.eccd005,"'"
   END IF
   PREPARE aect801_chk_eccd005_pb FROM l_sql
   DECLARE aect801_chk_eccd005_cs CURSOR FOR aect801_chk_eccd005_pb
   FOREACH aect801_chk_eccd005_cs INTO l_eccd005,l_eccd006
      #--当笔输入的值不能再其他笔起止数量范围内
      #当笔输入的值不能在其他笔数量范围内
      IF NOT cl_null(l_eccd006) AND (p_qty >= l_eccd005 AND p_qty <= l_eccd006) THEN
         LET g_errno = 'aec-00004'
         RETURN
      END IF
      #当笔输入的值不能在其他笔无穷大范围内
      IF cl_null(l_eccd006) AND p_qty >= l_eccd005 THEN
         LET g_errno = 'aec-00004'
         RETURN
      END IF
      CASE p_type
         WHEN '1'   #eccd005
              #--当笔输入的范围，不能包含到其他笔的起止数量
              IF p_qty <= l_eccd005 AND NOT cl_null(g_eccb3_d[l_ac2].eccd006) AND g_eccb3_d[l_ac2].eccd006 >= l_eccd006 THEN
                 LET g_errno = 'aec-00004'
                 RETURN
              END IF
         WHEN '2'   #eccd006
              #--当笔输入的范围，不能包含到其他笔的起止数量
              IF NOT cl_null(g_eccb3_d[l_ac2].eccd005) AND g_eccb3_d[l_ac2].eccd005 <= l_eccd005 AND p_qty >= l_eccd006 THEN
                 LET g_errno = 'aec-00004'
                 RETURN
              END IF
              #当笔输入无穷大的，需检查当笔输入的起始数量，不可小于其他笔截止数量
              IF NOT cl_null(g_eccb3_d[l_ac2].eccd005) AND cl_null(p_qty) AND g_eccb3_d[l_ac2].eccd005 <= l_eccd006 THEN
                 LET g_errno = 'aec-00004'
                 RETURN
              END IF
              #当笔输入无穷大的，需检查其他笔没有无穷大的（不可出现两个无穷大的）
              IF NOT cl_null(g_eccb3_d[l_ac2].eccd005) AND cl_null(p_qty) AND cl_null(l_eccd006) THEN
                 LET g_errno = 'aec-00004'
                 RETURN
              END IF
      END CASE
   END FOREACH
END FUNCTION

#起始数量预设
PRIVATE FUNCTION aect801_def_ecca005()
DEFINE l_n          LIKE type_t.num5
DEFINE i            LIKE type_t.num5
DEFINE l_imae016    LIKE imae_t.imae016
DEFINE l_ooca002    LIKE ooca_t.ooca002
DEFINE l_eccd006    LIKE eccd_t.eccd006
DEFINE l_num        LIKE type_t.num20
            
   LET l_n = 0
   IF cl_null(g_detail_idx) OR g_detail_idx = 0 THEN RETURN END IF
   IF cl_null(g_detail_idx2) OR g_detail_idx2 = 0 THEN RETURN END IF
   SELECT COUNT(*) INTO l_n 
     FROM eccd_t
    WHERE eccdent = g_enterprise
      AND eccdsite = g_site
      AND eccddocno = g_ecca_m.eccadocno
      AND eccd003 = g_eccb_d[g_detail_idx].eccb003
      AND eccd004 = g_eccb2_d[g_detail_idx2].eccc004
   IF l_n = 0 THEN
      LET g_eccb3_d[l_ac2].eccd005 = 0
   ELSE
      SELECT imae016 INTO l_imae016
        FROM imae_t
       WHERE imaeent = g_enterprise
         AND imaesite = g_site
         AND imae001 = g_eccb2_d[g_detail_idx2].eccc005
      IF cl_null(l_imae016) THEN
         LET l_ooca002 = 0
         LET l_num = 0
      ELSE
         SELECT ooca002 INTO l_ooca002
           FROM ooca_t
          WHERE oocaent = g_enterprise
            AND ooca001 = l_imae016
         IF cl_null(l_ooca002) THEN
            LET l_ooca002 = 0
            LET l_num = 0
         END IF
         FOR i=1 TO l_ooca002
             IF i = 1 THEN
                LET l_num = 10
             ELSE
                LET l_num = l_num *10
             END IF
         END FOR
      END IF 

      SELECT MAX(eccd006) INTO l_eccd006
        FROM eccd_t
       WHERE eccdent = g_enterprise
         AND eccdsite = g_site
         AND eccd001 = g_ecca_m.ecca001
         AND eccd002 = g_ecca_m.ecca002
         AND eccd003 = g_eccb_d[g_detail_idx].eccb003
         AND eccd004 = g_eccb2_d[g_detail_idx2].eccc004
      IF NOT cl_null(l_eccd006) THEN
         IF l_num = 0 THEN
            LET g_eccb3_d[l_ac2].eccd005 = l_eccd006 + 1
         ELSE
            LET g_eccb3_d[l_ac2].eccd005 = l_eccd006 + 1 + 1 / l_num
         END IF
      END IF
   END IF
   DISPLAY BY NAME g_eccb3_d[l_ac2].eccd005
END FUNCTION

#制程单身栏位颜色初始化
PRIVATE FUNCTION aect801_eccb_color_init()
   LET g_eccb_d_color[l_ac].eccb003       = 'black'
   LET g_eccb_d_color[l_ac].eccb004       = 'black'
   LET g_eccb_d_color[l_ac].eccb004_desc  = 'black'
   LET g_eccb_d_color[l_ac].eccb005       = 'black'
   LET g_eccb_d_color[l_ac].eccb006       = 'black'
   LET g_eccb_d_color[l_ac].eccb007       = 'black'
   LET g_eccb_d_color[l_ac].eccb008       = 'black'
   LET g_eccb_d_color[l_ac].eccb008_desc  = 'black'
   LET g_eccb_d_color[l_ac].eccb009       = 'black'
   LET g_eccb_d_color[l_ac].eccb010       = 'black'
   LET g_eccb_d_color[l_ac].eccb010_desc  = 'black'
   LET g_eccb_d_color[l_ac].eccb011       = 'black' 
   LET g_eccb_d_color[l_ac].eccb012       = 'black'
   LET g_eccb_d_color[l_ac].eccb012_desc  = 'black' 
   LET g_eccb_d_color[l_ac].eccb013       = 'black'
   LET g_eccb_d_color[l_ac].eccb014       = 'black'
   LET g_eccb_d_color[l_ac].eccb014_desc  = 'black'
   LET g_eccb_d_color[l_ac].eccb015       = 'black'
   LET g_eccb_d_color[l_ac].eccb016       = 'black'
   LET g_eccb_d_color[l_ac].eccb017       = 'black'
   LET g_eccb_d_color[l_ac].eccb018       = 'black'
   LET g_eccb_d_color[l_ac].eccb019       = 'black'
   LET g_eccb_d_color[l_ac].eccb020       = 'black'
   LET g_eccb_d_color[l_ac].eccb021       = 'black'
   LET g_eccb_d_color[l_ac].eccb021_desc  = 'black'
   LET g_eccb_d_color[l_ac].eccb022       = 'black'
   LET g_eccb_d_color[l_ac].eccb023       = 'black'
   LET g_eccb_d_color[l_ac].eccb024       = 'black'
   LET g_eccb_d_color[l_ac].eccb025       = 'black'
   LET g_eccb_d_color[l_ac].eccb026       = 'black'
   LET g_eccb_d_color[l_ac].eccb027       = 'black'
   LET g_eccb_d_color[l_ac].eccb028       = 'black'
   LET g_eccb_d_color[l_ac].eccb029       = 'black'
   LET g_eccb_d_color[l_ac].eccb030       = 'black'
   LET g_eccb_d_color[l_ac].eccb030_desc  = 'black'
   LET g_eccb_d_color[l_ac].eccb031       = 'black'
   LET g_eccb_d_color[l_ac].eccb032       = 'black'
   LET g_eccb_d_color[l_ac].eccb033       = 'black'
   LET g_eccb_d_color[l_ac].eccb034       = 'black'
   LET g_eccb_d_color[l_ac].eccb035       = 'black'
   LET g_eccb_d_color[l_ac].eccb036       = 'black'
END FUNCTION

#用料底稿栏位颜色初始化
PRIVATE FUNCTION aect801_eccc_color_init()
   LET g_eccb2_d_color[l_ac].eccc004       = 'black'
   LET g_eccb2_d_color[l_ac].eccc005       = 'black'
   LET g_eccb2_d_color[l_ac].eccc005_desc  = 'black'
   LET g_eccb2_d_color[l_ac].eccc005_desc_1= 'black'
   LET g_eccb2_d_color[l_ac].eccc006       = 'black'
   LET g_eccb2_d_color[l_ac].eccc006_desc  = 'black'
   LET g_eccb2_d_color[l_ac].eccc007       = 'black'
   LET g_eccb2_d_color[l_ac].eccc008       = 'black'
   LET g_eccb2_d_color[l_ac].eccc009       = 'black'
   LET g_eccb2_d_color[l_ac].eccc009_desc  = 'black' 
   LET g_eccb2_d_color[l_ac].eccc010       = 'black'
END FUNCTION

#用料底稿损耗率栏位颜色初始化
PRIVATE FUNCTION aect801_eccd_color_init()
   LET g_eccb3_d_color[l_ac].eccd005       = 'black'
   LET g_eccb3_d_color[l_ac].eccd006       = 'black'
   LET g_eccb3_d_color[l_ac].eccd007       = 'black'
   LET g_eccb3_d_color[l_ac].eccd008       = 'black'
END FUNCTION

#重新抓取资料更新下站作业下站作业序
PRIVATE FUNCTION aect801_return_eccb_mult()
DEFINE l_ecce004      LIKE ecce_t.ecce004
DEFINE l_ecce005      LIKE ecce_t.ecce005
DEFINE l_n            LIKE type_t.num5
DEFINE r_success      LIKE type_t.num5
#DEFINE l_eccb         RECORD LIKE eccb_t.*  #161124-00048#2     2016/12/06 By 08734 mark
#161124-00048#2     2016/12/06 By 08734 add(S)
DEFINE l_eccb RECORD  #料件製程變更單身檔
       eccbent LIKE eccb_t.eccbent, #企业编号
       eccbsite LIKE eccb_t.eccbsite, #营运据点
       eccbdocno LIKE eccb_t.eccbdocno, #申请单号
       eccb001 LIKE eccb_t.eccb001, #工艺料号
       eccb002 LIKE eccb_t.eccb002, #工艺编号
       eccb003 LIKE eccb_t.eccb003, #项次
       eccb004 LIKE eccb_t.eccb004, #本站作业
       eccb005 LIKE eccb_t.eccb005, #作业序
       eccb006 LIKE eccb_t.eccb006, #群组性质
       eccb007 LIKE eccb_t.eccb007, #群组
       eccb008 LIKE eccb_t.eccb008, #上站作业
       eccb009 LIKE eccb_t.eccb009, #上站作业序
       eccb010 LIKE eccb_t.eccb010, #下站作业
       eccb011 LIKE eccb_t.eccb011, #下站作业序
       eccb012 LIKE eccb_t.eccb012, #工作站
       eccb013 LIKE eccb_t.eccb013, #允许委外
       eccb014 LIKE eccb_t.eccb014, #主要加工厂
       eccb015 LIKE eccb_t.eccb015, #Move in
       eccb016 LIKE eccb_t.eccb016, #Check in
       eccb017 LIKE eccb_t.eccb017, #报工站
       eccb018 LIKE eccb_t.eccb018, #PQC
       eccb019 LIKE eccb_t.eccb019, #Check out
       eccb020 LIKE eccb_t.eccb020, #Move out
       eccb021 LIKE eccb_t.eccb021, #转出单位
       eccb022 LIKE eccb_t.eccb022, #转出单位转换率分子
       eccb023 LIKE eccb_t.eccb023, #转出单位转换率分母
       eccb024 LIKE eccb_t.eccb024, #固定工时
       eccb025 LIKE eccb_t.eccb025, #标准工时
       eccb026 LIKE eccb_t.eccb026, #固定机时
       eccb027 LIKE eccb_t.eccb027, #标准机时
       eccb028 LIKE eccb_t.eccb028, #完成度
       eccb029 LIKE eccb_t.eccb029, #标准单价
       eccb030 LIKE eccb_t.eccb030, #转入单位
       eccb031 LIKE eccb_t.eccb031, #转入单位转换分子
       eccb032 LIKE eccb_t.eccb032, #转入单位转换分母
       eccb033 LIKE eccb_t.eccb033, #回收站
       eccb034 LIKE eccb_t.eccb034, #后置时间
       eccb035 LIKE eccb_t.eccb035, #X轴
       eccb036 LIKE eccb_t.eccb036, #Y轴
       eccb900 LIKE eccb_t.eccb900, #变更序
       eccb901 LIKE eccb_t.eccb901, #变更类型
       eccb902 LIKE eccb_t.eccb902, #变更日期
       eccb905 LIKE eccb_t.eccb905, #变更理由
       eccb906 LIKE eccb_t.eccb906 #变更备注
END RECORD
#161124-00048#2     2016/12/06 By 08734 add(E)
DEFINE l_eccb010      LIKE eccb_t.eccb010
DEFINE l_eccb011      LIKE eccb_t.eccb011
DEFINE l_tot          LIKE type_t.num5
DEFINE l_n0           LIKE type_t.num5
DEFINE l_n1           LIKE type_t.num5
DEFINE l_n2           LIKE type_t.num5
DEFINE l_n3           LIKE type_t.num5
DEFINE l_n4           LIKE type_t.num5

   LET r_success = FALSE
   LET l_n = 0 
   DECLARE eccb_mult0 CURSOR FOR 
    #SELECT * FROM eccb_t WHERE eccbent=g_enterprise AND eccbsite=g_site #161124-00048#2     2016/12/06 By 08734 mark
    SELECT eccbent,eccbsite,eccbdocno,eccb001,eccb002,eccb003,eccb004,eccb005,eccb006,eccb007,eccb008,eccb009,eccb010,eccb011,eccb012,eccb013,eccb014,eccb015,eccb016,eccb017,eccb018,eccb019,eccb020,eccb021,eccb022,eccb023,eccb024,eccb025,eccb026,eccb027,eccb028,eccb029,eccb030,eccb031,eccb032,eccb033,eccb034,eccb035,eccb036,eccb900,eccb901,eccb902,eccb905,eccb906 #161124-00048#2     2016/12/06 By 08734 add 
      FROM eccb_t WHERE eccbent=g_enterprise AND eccbsite=g_site
       AND eccbdocno = g_ecca_m.eccadocno AND eccb901 != '4'
       
   INITIALIZE l_eccb.* TO NULL
   FOREACH eccb_mult0 INTO l_eccb.*
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "FOREACH:"
         LET g_errparam.popup = TRUE
         CALL cl_err()

         EXIT FOREACH
      END IF
      
      #当前作业、作业序，不存在其他站的 上站作业 中，则更新本站对应下站为END,0
      SELECT COUNT(*) INTO l_n4 FROM ecce_t 
       WHERE ecceent = g_enterprise AND eccesite = g_site
         AND eccedocno = g_ecca_m.eccadocno AND ecce901 != '4'
         AND ecce004 = l_eccb.eccb004 AND ecce005 = l_eccb.eccb005
      IF NOT cl_null(l_eccb.eccb007) AND l_n4 = 0 THEN 
         SELECT COUNT(*) INTO l_n4 FROM ecce_t 
          WHERE ecceent = g_enterprise AND eccesite = g_site
            AND eccedocno = g_ecca_m.eccadocno AND ecce901 != '4'
            AND ecce004 = l_eccb.eccb007 AND ecce005 = 0
      END IF
      IF l_n4 = 0 THEN
         UPDATE eccb_t SET eccb010 = 'END',eccb011 = 0
          WHERE eccbent = g_enterprise AND eccbsite = g_site
            AND eccbdocno = g_ecca_m.eccadocno AND eccb003 = l_eccb.eccb003
      END IF

      #多上站作業+上站製程序
      DECLARE eccb_mult CURSOR FOR
       SELECT ecce004,ecce005 FROM ecce_t
        WHERE ecceent = g_enterprise AND eccesite = g_site
          AND eccedocno = g_ecca_m.eccadocno
          AND ecce003 = l_eccb.eccb003
          AND ecce901 != '4'          
      FOREACH eccb_mult INTO l_ecce004,l_ecce005
         #計算多上站資料有幾筆相同的上站作業+製程序
         LET l_tot = 0
         SELECT COUNT(*) INTO l_tot FROM ecce_t
          WHERE ecceent = g_enterprise  AND eccesite = g_site
            AND eccedocno = g_ecca_m.eccadocno
            AND ecce004 = l_ecce004 AND ecce005 = l_ecce005
            AND ecce901 != '4' 
         IF l_tot = 1 THEN
            IF NOT cl_null(l_eccb.eccb007) THEN
               #維護群組
               #更新上站作業+上站制程序且無維護群組或群組不一樣的資料對應下站程序+下站制程序為本資料的群組+本站  
               UPDATE eccb_t SET eccb010 = l_eccb.eccb007,eccb011 = 0
                WHERE eccbent = g_enterprise AND eccbsite = g_site
                  AND eccbdocno = g_ecca_m.eccadocno
                  AND eccb004 = l_ecce004 AND eccb005 = l_ecce005
                  AND (eccb007 IS NULL OR eccb007 <> l_eccb.eccb007)
                  AND eccb901 != '4' 
               IF SQLCA.sqlcode THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = SQLCA.sqlcode
                  LET g_errparam.extend = "eccb_t"
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  RETURN r_success 
               END IF
               #更新上站作業+上站制程序且有維護群組(相同群組)的資料對應下站程序+下站制程序為本資料的本站程序+本站制程序
               UPDATE eccb_t SET eccb010 = l_eccb.eccb004,eccb011 = l_eccb.eccb005
                WHERE eccbent = g_enterprise AND eccbsite = g_site
                  AND eccbdocno = g_ecca_m.eccadocno
                  AND eccb004 = l_ecce004 AND eccb005 = l_ecce005
                  AND eccb007 = l_eccb.eccb007
                  AND eccb901 != '4' 
               IF SQLCA.sqlcode THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = SQLCA.sqlcode
                  LET g_errparam.extend = "eccb_t"
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  RETURN r_success
               END IF
            ELSE
               #無維護群組
               #更新上站作業+上站制程序對應下站程序+下站制程序為本資料的本站程序+本站制程序
               UPDATE eccb_t SET eccb010 = l_eccb.eccb004,eccb011 = l_eccb.eccb005
                WHERE eccbent = g_enterprise AND eccbsite = g_site
                  AND eccbdocno = g_ecca_m.eccadocno
                  AND eccb004 = l_ecce004 AND eccb005 = l_ecce005
                  AND eccb901 != '4' 
               IF SQLCA.sqlcode THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = SQLCA.sqlcode
                  LET g_errparam.extend = "eccb_t"
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  RETURN r_success
               END IF
            END IF
         ELSE
            SELECT COUNT(DISTINCT ecce004) INTO l_n2 FROM ecce_t
             WHERE ecceent = g_enterprise  AND eccesite = g_site
               AND eccedocno = g_ecca_m.eccadocno
               AND ecce004 = l_ecce004 AND ecce005 = l_ecce005
               AND ecce901 != '4' 
            SELECT COUNT(DISTINCT ecce005) INTO l_n3 FROM ecce_t
             WHERE ecceent = g_enterprise  AND eccesite = g_site
               AND eccedocno = g_ecca_m.eccadocno
               AND ecce004 = l_ecce004 AND ecce005 = l_ecce005
               AND ecce901 != '4' 
            IF l_n2 = 1 AND l_n3 = 1 THEN
               UPDATE eccb_t SET eccb010 = 'MULT', eccb011 = 0
                WHERE eccbent = g_enterprise AND eccbsite = g_site
                  AND eccbdocno = g_ecca_m.eccadocno
                  AND eccb004 = l_ecce004 AND eccb005 = l_ecce005
                  AND eccb901 != '4' 
            ELSE
               UPDATE eccb_t SET eccb010 = l_eccb.eccb007, eccb011 = 0
                WHERE eccbent = g_enterprise AND eccbsite = g_site
                  AND eccbdocno = g_ecca_m.eccadocno
                  AND eccb004 = l_ecce004 AND eccb005 = l_ecce005
                  AND eccb901 != '4' 
            END IF
            IF SQLCA.sqlcode THEN
               INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = SQLCA.sqlcode
                  LET g_errparam.extend = "eccb_t"
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

               RETURN r_success
            END IF
         END IF
         SELECT COUNT(*) INTO l_n1 FROM eccb_t
          WHERE eccbent = g_enterprise AND eccbsite = g_site
            AND eccbdocno = g_ecca_m.eccadocno
            AND eccb007 = l_ecce004
            AND (eccb004 NOT IN(SELECT eccb008 FROM eccb_t WHERE eccbent = g_enterprise AND eccbsite = g_site
                AND eccbdocno = g_ecca_m.eccadocno AND eccb007 = l_ecce004 AND eccb901 != '4') OR
                eccb005 NOT IN(SELECT eccb009 FROM eccb_t WHERE eccbent = g_enterprise AND eccbsite = g_site
                AND eccbdocno = g_ecca_m.eccadocno AND eccb007 = l_ecce004 AND eccb901 != '4'))
            AND eccb901 != '4' 
         IF l_n1 > 0 THEN
            IF NOT cl_null(l_eccb.eccb007) THEN
               UPDATE eccb_t SET eccb010 = l_eccb.eccb007,eccb011 = '0'
                WHERE eccbent = g_enterprise AND eccbsite = g_site
                  AND eccbdocno = g_ecca_m.eccadocno
                  AND eccb007 = l_ecce004
                  AND (eccb004 NOT IN(SELECT eccb008 FROM eccb_t WHERE eccbent = g_enterprise AND eccbsite = g_site
                      AND eccbdocno = g_ecca_m.eccadocno AND eccb007 = l_ecce004 AND eccb901 != '4') OR
                      eccb005 NOT IN(SELECT eccb009 FROM eccb_t WHERE eccbent = g_enterprise AND eccbsite = g_site
                      AND eccbdocno = g_ecca_m.eccadocno AND eccb007 = l_ecce004 AND eccb901 != '4'))
                  AND eccb901 != '4'
            ELSE
               UPDATE eccb_t SET eccb010 = l_eccb.eccb004,eccb011 = l_eccb.eccb005
                WHERE eccbent = g_enterprise AND eccbsite = g_site
                  AND eccbdocno = g_ecca_m.eccadocno
                  AND eccb007 = l_ecce004
                  AND (eccb004 NOT IN(SELECT eccb008 FROM eccb_t WHERE eccbent = g_enterprise AND eccbsite = g_site
                      AND eccbdocno = g_ecca_m.eccadocno AND eccb007 = l_ecce004 AND eccb901 != '4') OR
                      eccb005 NOT IN(SELECT eccb009 FROM eccb_t WHERE eccbent = g_enterprise AND eccbsite = g_site
                      AND eccbdocno = g_ecca_m.eccadocno AND eccb007 = l_ecce004 AND eccb901 != '4'))
                  AND eccb901 != '4'
            END IF
            IF SQLCA.sqlcode THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = SQLCA.sqlcode
               LET g_errparam.extend = "eccb_t"
               LET g_errparam.popup = TRUE
               CALL cl_err()

               RETURN r_success
            END IF
         END IF
         
      END FOREACH
      
      #若当站对应下站不存在或者为空，则更新下站作业+下站作业序END+0
      SELECT eccb010,eccb011 INTO l_eccb010,l_eccb011 FROM eccb_t WHERE eccbent=g_enterprise AND eccbsite=g_site
         AND eccbdocno=g_ecca_m.eccadocno AND eccb003=l_eccb.eccb003 AND eccb901 != '4' 
      IF NOT cl_null(l_eccb010) AND NOT cl_null(l_eccb011) THEN
         SELECT COUNT(*) INTO l_n0 FROM ecce_t WHERE ecceent=g_enterprise AND eccesite=g_site AND eccedocno=g_ecca_m.eccadocno
            AND ecce004=l_eccb010 AND ecce005=l_eccb011 AND ecce901 != '4' 
         IF l_n0 = 0 THEN
            IF l_eccb.eccb010 = 'MULT' THEN
               SELECT COUNT(*) INTO l_n0 FROM ecce_t WHERE ecceent=g_enterprise AND eccesite=g_site AND eccedocno=g_ecca_m.eccadocno
                  AND ecce004=l_eccb.eccb004 AND ecce005=l_eccb.eccb005 AND ecce901 != '4' 
            ELSE
               #群组
               SELECT COUNT(*) INTO l_n0 FROM eccb_t WHERE eccbent=g_enterprise AND eccbsite=g_site AND eccbdocno=g_ecca_m.eccadocno 
                  AND eccb008=l_eccb.eccb004 AND eccb009=l_eccb.eccb005 AND eccb007=l_eccb010 AND eccb901 != '4' 
               IF l_n0 = 0 THEN
                  SELECT COUNT(*) INTO l_n0 FROM eccb_t WHERE eccbent=g_enterprise AND eccbsite=g_site AND eccbdocno=g_ecca_m.eccadocno 
                     AND eccb004=l_eccb010 AND eccb005=l_eccb011 AND eccb008=l_eccb.eccb007 AND eccb901 != '4' 
                  IF l_n0 = 0 THEN
                     SELECT COUNT(*) INTO l_n0 FROM eccb_t WHERE eccbent=g_enterprise AND eccbsite=g_site AND eccbdocno=g_ecca_m.eccadocno 
                        AND eccb007=l_eccb010 AND eccb008=l_eccb.eccb007 AND eccb901 != '4' 
                  END IF
               END IF
            END IF
         END IF
      END IF
      IF cl_null(l_eccb010) OR l_n0 = 0 THEN           
         UPDATE eccb_t SET eccb010 = 'END',eccb011 = 0
          WHERE eccbent = g_enterprise
            AND eccbsite = g_site
            AND eccbdocno=g_ecca_m.eccadocno 
            AND eccb003=l_eccb.eccb003
            AND eccb901 != '4' 
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = SQLCA.sqlcode
            LET g_errparam.extend = "UPDATE eccb_t"
            LET g_errparam.popup = TRUE
            CALL cl_err()

            RETURN r_success
         END IF
      END IF
      INITIALIZE l_eccb.* TO NULL
   END FOREACH
   
   #写入变更历程档，新增、修改、删除的时候可能会异动到其他资料，例如上下站资料，故重新抓取资料进行写入
   INITIALIZE l_eccb.* TO NULL
   FOREACH eccb_mult0 INTO l_eccb.*
      IF l_eccb.eccb901 = '1' THEN
         UPDATE eccb_t SET eccb901 = '2' 
          WHERE eccbent = g_enterprise AND eccbsite = g_site
            AND eccbdocno = g_ecca_m.eccadocno AND eccb003 = l_eccb.eccb003
      END IF
      IF NOT aect801_upd_eccb_ecch(g_ecca_m.eccadocno,l_eccb.eccb003) THEN 
         RETURN r_success
      END IF
      INITIALIZE l_eccb.* TO NULL   
   END FOREACH
   
   LET r_success = TRUE
   RETURN r_success
END FUNCTION

#制程单身ref栏位显示
PRIVATE FUNCTION aect801_eccb_desc()
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_eccb_d[l_ac].eccb004
   CALL ap_ref_array2(g_ref_fields,"SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001='221' AND oocql002=? AND oocql003='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_eccb_d[l_ac].eccb004_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_eccb_d[l_ac].eccb004_desc
   
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_eccb_d[l_ac].eccb008
   CALL ap_ref_array2(g_ref_fields,"SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001='221' AND oocql002=? AND oocql003='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_eccb_d[l_ac].eccb008_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_eccb_d[l_ac].eccb008_desc
   
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_ecca_m.eccasite
   LET g_ref_fields[2] = g_eccb_d[l_ac].eccb012
   CALL ap_ref_array2(g_ref_fields,"SELECT ecaa002 FROM ecaa_t WHERE ecaaent='"||g_enterprise||"' AND ecaasite=? AND ecaa001=? ","") RETURNING g_rtn_fields
   LET g_eccb_d[l_ac].eccb012_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_eccb_d[l_ac].eccb012_desc
   
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_eccb_d[l_ac].eccb014
   CALL ap_ref_array2(g_ref_fields,"SELECT pmaal004 FROM pmaal_t WHERE pmaalent='"||g_enterprise||"' AND pmaal001=? AND pmaal002='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_eccb_d[l_ac].eccb014_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_eccb_d[l_ac].eccb014_desc

   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_eccb_d[l_ac].eccb030
   CALL ap_ref_array2(g_ref_fields,"SELECT oocal003 FROM oocal_t WHERE oocalent='"||g_enterprise||"' AND oocal001=? AND oocal002='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_eccb_d[l_ac].eccb030_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_eccb_d[l_ac].eccb030_desc

   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_eccb_d[l_ac].eccb021
   CALL ap_ref_array2(g_ref_fields,"SELECT oocal003 FROM oocal_t WHERE oocalent='"||g_enterprise||"' AND oocal001=? AND oocal002='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_eccb_d[l_ac].eccb021_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_eccb_d[l_ac].eccb021_desc



END FUNCTION

#预设制程序
PRIVATE FUNCTION aect801_def_eccb005()
DEFINE l_eccb005    LIKE eccb_t.eccb005
DEFINE l_eccb005_1  LIKE type_t.num5

   SELECT MAX(eccb005) INTO l_eccb005
     FROM eccb_t
    WHERE eccbent = g_enterprise
      AND eccbsite = g_site
      AND eccbdocno = g_ecca_m.eccadocno
      AND eccb004 = g_eccb_d[l_ac].eccb004
   LET l_eccb005_1 = l_eccb005
   LET l_eccb005_1 = l_eccb005_1 +1
   LET g_eccb_d[l_ac].eccb005 = l_eccb005_1
   IF cl_null(g_eccb_d[l_ac].eccb005) THEN
      LET g_eccb_d[l_ac].eccb005 = 1
   END IF
   DISPLAY BY NAME g_eccb_d[l_ac].eccb005
END FUNCTION

#本站作业、作业序检查
PRIVATE FUNCTION aect801_chk_eccb004(p_cmd)
DEFINE p_cmd    LIKE type_t.chr1
DEFINE l_n      LIKE type_t.num5

   LET g_errno = ""
   LET l_n = 0
   IF p_cmd = 'a' THEN
      SELECT COUNT(*) INTO l_n
        FROM eccb_t
       WHERE eccbent = g_enterprise
         AND eccbsite = g_site
         AND eccbdocno = g_ecca_m.eccadocno
         AND eccb004 = g_eccb_d[l_ac].eccb004
         AND eccb005 = g_eccb_d[l_ac].eccb005
   ELSE
      SELECT COUNT(*) INTO l_n
        FROM eccb_t
       WHERE eccbent = g_enterprise
         AND eccbsite = g_site
         AND eccbdocno = g_ecca_m.eccadocno
         AND eccb004 = g_eccb_d[l_ac].eccb004
         AND eccb005 = g_eccb_d[l_ac].eccb005
         AND eccb003 <> g_eccb_d_t.eccb003
   END IF
   IF l_n > 0 THEN
      LET g_errno = 'aec-00006'
   END IF
END FUNCTION

#上站作业、作业序检查
PRIVATE FUNCTION aect801_chk_eccb008(p_cmd)
DEFINE l_n         LIKE type_t.num5
DEFINE p_cmd       LIKE type_t.chr1

   LET g_errno = ""
   IF g_eccb_d[l_ac].eccb008 = 'INIT' OR g_eccb_d[l_ac].eccb008 = 'MULT' THEN
      RETURN
   END IF
   LET l_n = 0
   SELECT COUNT(*) INTO l_n
     FROM eccb_t
    WHERE eccbent = g_enterprise
      AND eccbsite = g_site
      AND eccbdocno = g_ecca_m.eccadocno
      AND eccb007 = g_eccb_d[l_ac].eccb008
   IF l_n > 0 THEN
      RETURN
   END IF
   LET l_n = 0
   IF p_cmd = 'a' THEN
      SELECT COUNT(*) INTO l_n
        FROM eccb_t
       WHERE eccbent = g_enterprise
         AND eccbsite = g_site
         AND eccbdocno = g_ecca_m.eccadocno
         AND eccb004 = g_eccb_d[l_ac].eccb008
         AND eccb005 = g_eccb_d[l_ac].eccb009
   ELSE
      SELECT COUNT(*) INTO l_n
        FROM eccb_t
       WHERE eccbent = g_enterprise
         AND eccbsite = g_site
         AND eccbdocno = g_ecca_m.eccadocno
         AND eccb004 = g_eccb_d[l_ac].eccb008
         AND eccb005 = g_eccb_d[l_ac].eccb009
         AND eccb003 <> g_eccb_d[l_ac].eccb003
   END IF   
   IF l_n = 0 THEN
      LET g_errno = 'aec-00007'
   END IF
END FUNCTION

#用料底稿档ref显示
PRIVATE FUNCTION aect801_eccc_desc()
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_eccb2_d[l_ac].eccc005
   CALL ap_ref_array2(g_ref_fields,"SELECT imaal003,imaal004 FROM imaal_t WHERE imaalent='"||g_enterprise||"' AND imaal001=? AND imaal002='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_eccb2_d[l_ac].eccc005_desc = '', g_rtn_fields[1] , ''
   LET g_eccb2_d[l_ac].eccc005_desc_1 = '', g_rtn_fields[2] , ''
   DISPLAY BY NAME g_eccb2_d[l_ac].eccc005_desc,g_eccb2_d[l_ac].eccc005_desc_1

   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_eccb2_d[l_ac].eccc006
   CALL ap_ref_array2(g_ref_fields,"SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001='215' AND oocql002=? AND oocql003='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_eccb2_d[l_ac].eccc006_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_eccb2_d[l_ac].eccc006_desc

   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_eccb2_d[l_ac].eccc009
   CALL ap_ref_array2(g_ref_fields,"SELECT oocal003 FROM oocal_t WHERE oocalent='"||g_enterprise||"' AND oocal001=? AND oocal002='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_eccb2_d[l_ac].eccc009_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_eccb2_d[l_ac].eccc009_desc


END FUNCTION

#用量单位检查
PRIVATE FUNCTION aect801_chk_eccc009()
DEFINE l_imaa006               LIKE imaa_t.imaa006
DEFINE r_success               LIKE type_t.num5
DEFINE r_rate                  LIKE type_t.num26_10


    LET g_errno = ''
    LET r_rate = ''
    LET l_imaa006 = ''
    IF NOT cl_null(g_eccb2_d[l_ac].eccc009) THEN
       SELECT imaa006 INTO l_imaa006
         FROM imaa_t
        WHERE imaaent = g_enterprise
          AND imaa001 = g_eccb2_d[l_ac].eccc005
        IF NOT cl_null(g_eccb2_d[l_ac].eccc009) AND NOT cl_null(l_imaa006) THEN
           CALL s_aimi190_get_convert(g_eccb2_d[l_ac].eccc005,g_eccb2_d[l_ac].eccc009,l_imaa006) RETURNING r_success,r_rate
           IF NOT r_success THEN
              RETURN FALSE
           END IF
        END IF
        IF cl_null(l_imaa006) THEN
           LET g_errno = 'abm-00021'
           RETURN FALSE
        END IF
    END IF
    RETURN TRUE
END FUNCTION

#制程单身用料底稿损耗率档
PRIVATE FUNCTION aect801_upd_eccd_ecch(p_ecchdocno,p_ecchseq,p_ecchseq1,p_ecchseq2)
DEFINE p_ecchdocno                LIKE ecch_t.ecchdocno
DEFINE p_ecchseq                  LIKE ecch_t.ecchseq
DEFINE p_ecchseq1                 LIKE ecch_t.ecchseq1
DEFINE p_ecchseq2                 LIKE ecch_t.ecchseq2 
DEFINE r_success                  LIKE type_t.num5
#DEFINE l_ecbd                     RECORD LIKE ecbd_t.*  #161124-00048#2     2016/12/06 By 08734 mark
#161124-00048#2     2016/12/06 By 08734 add(S)
DEFINE l_ecbd RECORD  #料件製程用料底稿損耗率檔
       ecbdent LIKE ecbd_t.ecbdent, #企业编号
       ecbdsite LIKE ecbd_t.ecbdsite, #营运据点
       ecbd001 LIKE ecbd_t.ecbd001, #工艺料号
       ecbd002 LIKE ecbd_t.ecbd002, #工艺编号
       ecbd003 LIKE ecbd_t.ecbd003, #工艺项次
       ecbd004 LIKE ecbd_t.ecbd004, #项次
       ecbd005 LIKE ecbd_t.ecbd005, #起始数量
       ecbd006 LIKE ecbd_t.ecbd006, #截止数量
       ecbd007 LIKE ecbd_t.ecbd007, #变动损耗率
       ecbd008 LIKE ecbd_t.ecbd008 #固定损耗量
END RECORD
#161124-00048#2     2016/12/06 By 08734 add(E)
#DEFINE l_eccd                     RECORD LIKE eccd_t.*  #161124-00048#2     2016/12/06 By 08734 mark
#161124-00048#2     2016/12/06 By 08734 add(S)
DEFINE l_eccd RECORD  #料件製程變更用料底稿損秏率檔
       eccdent LIKE eccd_t.eccdent, #企业编号
       eccdsite LIKE eccd_t.eccdsite, #营运据点
       eccddocno LIKE eccd_t.eccddocno, #申请单号
       eccd001 LIKE eccd_t.eccd001, #料件编号
       eccd002 LIKE eccd_t.eccd002, #工艺编号
       eccd003 LIKE eccd_t.eccd003, #工艺项次
       eccd004 LIKE eccd_t.eccd004, #项次
       eccd005 LIKE eccd_t.eccd005, #起始数量
       eccd006 LIKE eccd_t.eccd006, #截止数量
       eccd007 LIKE eccd_t.eccd007, #变动损耗率
       eccd008 LIKE eccd_t.eccd008, #固定损耗量
       eccd900 LIKE eccd_t.eccd900, #变更序
       eccd901 LIKE eccd_t.eccd901, #变更类型
       eccd902 LIKE eccd_t.eccd902, #变更日期
       eccd905 LIKE eccd_t.eccd905, #变更原因
       eccd906 LIKE eccd_t.eccd906, #变更备注
       eccdseq LIKE eccd_t.eccdseq #项序
END RECORD
#161124-00048#2     2016/12/06 By 08734 add(E)
DEFINE l_flag                     LIKE type_t.chr1
DEFINE l_ecbd005                  LIKE ecbd_t.ecbd005

   LET r_success = FALSE
   LET l_flag = 'N'
   IF g_ecca_m.ecca004 = '1' THEN
      LET r_success = TRUE
      RETURN r_success
   END IF
   IF cl_null(p_ecchdocno) OR cl_null(p_ecchseq) OR cl_null(p_ecchseq1) OR cl_null(p_ecchseq2) THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'sub-00001'
      LET g_errparam.extend = ''
      LET g_errparam.popup = TRUE
      CALL cl_err()
      RETURN r_success
   END IF
   
   INITIALIZE l_ecbd.* TO NULL
   INITIALIZE l_eccd.* TO NULL
  # SELECT * INTO l_eccd.* FROM eccd_t WHERE eccdent = g_enterprise AND eccdsite = g_site  #161124-00048#2     2016/12/06 By 08734 mark
   SELECT eccdent,eccdsite,eccddocno,eccd001,eccd002,eccd003,eccd004,eccd005,eccd006,eccd007,eccd008,eccd900,eccd901,eccd902,eccd905,eccd906,eccdseq  #161124-00048#2     2016/12/06 By 08734 add 
     INTO l_eccd.* FROM eccd_t WHERE eccdent = g_enterprise AND eccdsite = g_site
      AND eccddocno = p_ecchdocno AND eccd003 = p_ecchseq AND eccd004 = p_ecchseq1 AND eccdseq = p_ecchseq2
      
   IF l_eccd.eccd901 = '1' THEN
      LET r_success = TRUE
      RETURN r_success
   END IF
   
   IF l_eccd.eccd901 = '2' OR l_eccd.eccd901 = '4' THEN
      #抓取原值
      SELECT ecch004 INTO l_ecbd005 FROM ecch_t WHERE ecchent = g_enterprise AND ecchsite = g_site
         AND ecchdocno = p_ecchdocno AND ecchseq = p_ecchseq AND ecchseq1 = p_ecchseq1 AND ecchseq2 = p_ecchseq2
         AND ecch002 = 'ecbd005'
      IF cl_null(l_ecbd005) THEN
         IF cl_null(g_eccb3_d_t.eccd005) THEN
            LET l_ecbd005 = l_eccd.eccd005
         ELSE
            LET l_ecbd005 = g_eccb3_d_t.eccd005
         END IF
      END IF
     # SELECT * INTO l_ecbd.* FROM ecbd_t WHERE ecbdent = g_enterprise AND ecbdsite = g_site #161124-00048#2     2016/12/06 By 08734 mark
      SELECT ecbdent,ecbdsite,ecbd001,ecbd002,ecbd003,ecbd004,ecbd005,ecbd006,ecbd007,ecbd008  #161124-00048#2     2016/12/06 By 08734 add
        INTO l_ecbd.* FROM ecbd_t WHERE ecbdent = g_enterprise AND ecbdsite = g_site
         AND ecbd001 = g_ecca_m.ecca001 AND ecbd002 = g_ecca_m.ecca002
         AND ecbd003 = p_ecchseq AND ecbd004 = p_ecchseq1 AND ecbd005 = l_ecbd005
   END IF
   
   LET g_ecch003 = ''
   IF l_eccd.eccd901 = '2' THEN
      LET g_ecch003 = '16'
   END IF
   IF l_eccd.eccd901 = '3' THEN
      LET g_ecch003 = '17'
   END IF
   IF l_eccd.eccd901 = '4' THEN
      INITIALIZE l_eccd.* TO NULL
      LET g_ecch003 = '18'
   END IF   
      
   #起始数量
   IF (NOT cl_null(l_eccd.eccd005) AND (l_eccd.eccd005 != l_ecbd.ecbd005 OR l_ecbd.ecbd005 IS NULL)) OR (cl_null(l_eccd.eccd005) AND l_ecbd.ecbd005 IS NOT NULL) THEN
      #其說明的SQL
      LET g_ecch007 = ""
      IF NOT s_aect801_ins_ecch(p_ecchdocno,p_ecchseq,p_ecchseq1,p_ecchseq2,'ecbd005',g_ecch003,l_ecbd.ecbd005,l_eccd.eccd005,g_ecch007) THEN
         RETURN r_success
      END IF
      LET l_flag = 'Y'
   ELSE
      IF NOT s_aect801_del_ecch(p_ecchdocno,p_ecchseq,p_ecchseq1,p_ecchseq2,'ecbd005') THEN
         RETURN r_success
      END IF
   END IF
   
   #截止数量
   #起始数量
   IF (NOT cl_null(l_eccd.eccd006) AND (l_eccd.eccd006 != l_ecbd.ecbd006 OR l_ecbd.ecbd006 IS NULL)) OR (cl_null(l_eccd.eccd006) AND l_ecbd.ecbd006 IS NOT NULL) THEN
      #其說明的SQL
      LET g_ecch007 = ""
      IF NOT s_aect801_ins_ecch(p_ecchdocno,p_ecchseq,p_ecchseq1,p_ecchseq2,'ecbd006',g_ecch003,l_ecbd.ecbd006,l_eccd.eccd006,g_ecch007) THEN
         RETURN r_success
      END IF
      LET l_flag = 'Y'
   ELSE
      IF NOT s_aect801_del_ecch(p_ecchdocno,p_ecchseq,p_ecchseq1,p_ecchseq2,'ecbd006') THEN
         RETURN r_success
      END IF
   END IF
   
   #变动损耗率
   #起始数量
   IF (NOT cl_null(l_eccd.eccd007) AND (l_eccd.eccd007 != l_ecbd.ecbd007 OR l_ecbd.ecbd007 IS NULL)) OR (cl_null(l_eccd.eccd007) AND l_ecbd.ecbd007 IS NOT NULL) THEN
      #其說明的SQL
      LET g_ecch007 = ""
      IF NOT s_aect801_ins_ecch(p_ecchdocno,p_ecchseq,p_ecchseq1,p_ecchseq2,'ecbd007',g_ecch003,l_ecbd.ecbd007,l_eccd.eccd007,g_ecch007) THEN
         RETURN r_success
      END IF
      LET l_flag = 'Y'
   ELSE
      IF NOT s_aect801_del_ecch(p_ecchdocno,p_ecchseq,p_ecchseq1,p_ecchseq2,'ecbd007') THEN
         RETURN r_success
      END IF
   END IF
   
   #固定损耗量
   #起始数量
   IF (NOT cl_null(l_eccd.eccd008) AND (l_eccd.eccd008 != l_ecbd.ecbd008 OR l_ecbd.ecbd008 IS NULL)) OR (cl_null(l_eccd.eccd008) AND l_ecbd.ecbd008 IS NOT NULL) THEN
      #其說明的SQL
      LET g_ecch007 = ""
      IF NOT s_aect801_ins_ecch(p_ecchdocno,p_ecchseq,p_ecchseq1,p_ecchseq2,'ecbd008',g_ecch003,l_ecbd.ecbd008,l_eccd.eccd008,g_ecch007) THEN
         RETURN r_success
      END IF
      LET l_flag = 'Y'
   ELSE
      IF NOT s_aect801_del_ecch(p_ecchdocno,p_ecchseq,p_ecchseq1,p_ecchseq2,'ecbd008') THEN
         RETURN r_success
      END IF
   END IF
   
   #制程用料底稿损耗率未有发生变更，则更新eccd901
   IF l_flag = 'N' THEN
      UPDATE eccd_t SET eccd901 = '1' WHERE eccdent = g_enterprise AND eccdsite = g_site
         AND eccddocno = p_ecchdocno AND eccd003 = p_ecchseq AND eccd004 = p_ecchseq1 AND eccdseq = p_ecchseq2
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "upd eccd901"
         LET g_errparam.popup = TRUE
         CALL cl_err()
         RETURN r_success
      END IF
   END IF
   
   LET r_success = TRUE
   RETURN r_success
END FUNCTION

#删除原有单身时不做delete，而是update变更类型为4.单身删除，以及对相关关联表的更新
PRIVATE FUNCTION aect801_eccb_delete(p_eccbdocno,p_eccb003)
DEFINE p_eccbdocno            LIKE eccb_t.eccbdocno
DEFINE p_eccb003              LIKE eccb_t.eccb003
DEFINE r_success              LIKE type_t.num5
DEFINE l_date                 LIKE eccb_t.eccb902
#DEFINE l_eccb                 RECORD LIKE eccb_t.*  #161124-00048#2     2016/12/06 By 08734 mark
#161124-00048#2     2016/12/06 By 08734 add(S)
DEFINE l_eccb RECORD  #料件製程變更單身檔
       eccbent LIKE eccb_t.eccbent, #企业编号
       eccbsite LIKE eccb_t.eccbsite, #营运据点
       eccbdocno LIKE eccb_t.eccbdocno, #申请单号
       eccb001 LIKE eccb_t.eccb001, #工艺料号
       eccb002 LIKE eccb_t.eccb002, #工艺编号
       eccb003 LIKE eccb_t.eccb003, #项次
       eccb004 LIKE eccb_t.eccb004, #本站作业
       eccb005 LIKE eccb_t.eccb005, #作业序
       eccb006 LIKE eccb_t.eccb006, #群组性质
       eccb007 LIKE eccb_t.eccb007, #群组
       eccb008 LIKE eccb_t.eccb008, #上站作业
       eccb009 LIKE eccb_t.eccb009, #上站作业序
       eccb010 LIKE eccb_t.eccb010, #下站作业
       eccb011 LIKE eccb_t.eccb011, #下站作业序
       eccb012 LIKE eccb_t.eccb012, #工作站
       eccb013 LIKE eccb_t.eccb013, #允许委外
       eccb014 LIKE eccb_t.eccb014, #主要加工厂
       eccb015 LIKE eccb_t.eccb015, #Move in
       eccb016 LIKE eccb_t.eccb016, #Check in
       eccb017 LIKE eccb_t.eccb017, #报工站
       eccb018 LIKE eccb_t.eccb018, #PQC
       eccb019 LIKE eccb_t.eccb019, #Check out
       eccb020 LIKE eccb_t.eccb020, #Move out
       eccb021 LIKE eccb_t.eccb021, #转出单位
       eccb022 LIKE eccb_t.eccb022, #转出单位转换率分子
       eccb023 LIKE eccb_t.eccb023, #转出单位转换率分母
       eccb024 LIKE eccb_t.eccb024, #固定工时
       eccb025 LIKE eccb_t.eccb025, #标准工时
       eccb026 LIKE eccb_t.eccb026, #固定机时
       eccb027 LIKE eccb_t.eccb027, #标准机时
       eccb028 LIKE eccb_t.eccb028, #完成度
       eccb029 LIKE eccb_t.eccb029, #标准单价
       eccb030 LIKE eccb_t.eccb030, #转入单位
       eccb031 LIKE eccb_t.eccb031, #转入单位转换分子
       eccb032 LIKE eccb_t.eccb032, #转入单位转换分母
       eccb033 LIKE eccb_t.eccb033, #回收站
       eccb034 LIKE eccb_t.eccb034, #后置时间
       eccb035 LIKE eccb_t.eccb035, #X轴
       eccb036 LIKE eccb_t.eccb036, #Y轴
       eccb900 LIKE eccb_t.eccb900, #变更序
       eccb901 LIKE eccb_t.eccb901, #变更类型
       eccb902 LIKE eccb_t.eccb902, #变更日期
       eccb905 LIKE eccb_t.eccb905, #变更理由
       eccb906 LIKE eccb_t.eccb906 #变更备注
END RECORD
#161124-00048#2     2016/12/06 By 08734 add(E)
DEFINE l_success              LIKE type_t.num5
DEFINE l_eccc004              LIKE eccc_t.eccc004
DEFINE l_ecceseq              LIKE ecce_t.ecceseq
DEFINE l_eccfseq              LIKE eccf_t.eccfseq
DEFINE l_eccgseq              LIKE eccg_t.eccgseq

   WHENEVER ERROR CONTINUE
   LET r_success = FALSE

   IF cl_null(p_eccbdocno) OR cl_null(p_eccb003) THEN                 
      RETURN r_success
   END IF
   
  # SELECT * INTO l_eccb.* FROM eccb_t WHERE eccbent = g_enterprise AND eccbsite = g_site  #161124-00048#2     2016/12/06 By 08734 mark
   SELECT eccbent,eccbsite,eccbdocno,eccb001,eccb002,eccb003,eccb004,eccb005,eccb006,eccb007,eccb008,eccb009,eccb010,eccb011,eccb012,eccb013,eccb014,eccb015,eccb016,eccb017,eccb018,eccb019,eccb020,eccb021,eccb022,eccb023,eccb024,eccb025,eccb026,eccb027,eccb028,eccb029,eccb030,eccb031,eccb032,eccb033,eccb034,eccb035,eccb036,eccb900,eccb901,eccb902,eccb905,eccb906 #161124-00048#2     2016/12/06 By 08734 add 
     INTO l_eccb.* FROM eccb_t WHERE eccbent = g_enterprise AND eccbsite = g_site
      AND eccbdocno = p_eccbdocno AND eccb003 = p_eccb003
   #原来的制程资料，删除时不做DELETE，只更新变更类型，且对应的关联表更新
   IF l_eccb.eccb901 = '1' OR l_eccb.eccb901 = '2' THEN 
      LET l_date = cl_get_today()               
      UPDATE eccb_t SET eccb901 = '4',eccb902 = l_date
       WHERE eccbent = g_enterprise AND eccbsite = g_site 
         AND eccbdocno = p_eccbdocno AND eccb003 = p_eccb003
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "UPD eccb_t" 
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = TRUE 
         CALL cl_err()                 
         RETURN r_success
      END IF

      IF NOT aect801_upd_eccb_ecch(p_eccbdocno,p_eccb003) THEN
         RETURN r_success
      END IF
      
      DECLARE aect801_eccb_delete_cs0 CURSOR FOR
       SELECT eccc004 FROM eccc_t WHERE ecccent = g_enterprise AND ecccsite = g_site
          AND ecccdocno = p_eccbdocno AND eccc003 = p_eccb003
      FOREACH aect801_eccb_delete_cs0 INTO l_eccc004
         IF NOT aect801_eccc_delete(p_eccbdocno,p_eccb003,l_eccc004) THEN
            RETURN r_success
         END IF
      END FOREACH
            
      DECLARE aect801_eccb_delete_cs1 CURSOR FOR
       SELECT ecceseq FROM ecce_t WHERE ecceent = g_enterprise AND eccesite = g_site
          AND eccedocno = p_eccbdocno AND ecce003 = p_eccb003
      FOREACH aect801_eccb_delete_cs1 INTO l_ecceseq
         IF NOT aect801_ecce_delete(p_eccbdocno,p_eccb003,l_ecceseq) THEN
            RETURN r_success
         END IF
      END FOREACH
      
      DECLARE aect801_eccb_delete_cs2 CURSOR FOR
       SELECT eccfseq FROM eccf_t WHERE eccfent = g_enterprise AND eccfsite = g_site
          AND eccfdocno = p_eccbdocno AND eccf003 = p_eccb003
      FOREACH aect801_eccb_delete_cs2 INTO l_eccfseq
         IF NOT aect801_eccf_delete(p_eccbdocno,p_eccb003,l_eccfseq) THEN
            RETURN r_success
         END IF
      END FOREACH
      
      DECLARE aect801_eccb_delete_cs3 CURSOR FOR
       SELECT eccgseq FROM eccg_t WHERE eccgent = g_enterprise AND eccgsite = g_site
          AND eccgdocno = p_eccbdocno AND eccg003 = p_eccb003
      FOREACH aect801_eccb_delete_cs3 INTO l_eccgseq
         IF NOT aect801_eccg_delete(p_eccbdocno,p_eccb003,l_eccgseq) THEN
            RETURN r_success
         END IF
      END FOREACH      
   END IF
   
   IF g_eccb_d[l_ac].eccb901 = '3' THEN
      DELETE FROM eccb_t WHERE eccbent = g_enterprise AND eccbsite = g_site
         AND eccbdocno = p_eccbdocno AND eccb003 = p_eccb003
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "DEL eccb_t" 
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = TRUE 
         CALL cl_err()                 
         RETURN r_success
      END IF
      
      CALL s_aooi360_del('7',g_site,p_eccbdocno,p_eccb003,' ',' ',' ',' ',' ',' ',' ','4')
           RETURNING l_success
      IF NOT l_success THEN
         RETURN r_success
      END IF
      
      DELETE FROM eccc_t WHERE ecccent = g_enterprise AND ecccsite = g_site
        AND ecccdocno = p_eccbdocno AND eccc003 = p_eccb003
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "DEL eccc_t" 
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = TRUE 
         CALL cl_err()                 
         RETURN r_success
      END IF
      
      DELETE FROM eccd_t WHERE eccdent = g_enterprise AND eccdsite = g_site
         AND eccddocno = p_eccbdocno AND eccd003 = p_eccb003
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "DEL eccd_t" 
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = TRUE 
         CALL cl_err()                 
         RETURN r_success
      END IF
      
      DELETE FROM ecce_t WHERE ecceent = g_enterprise AND eccesite = g_site
         AND eccedocno = p_eccbdocno AND ecce003 = p_eccb003
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "DEL ecce_t" 
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = TRUE 
         CALL cl_err()                 
         RETURN r_success
      END IF
      
      DELETE FROM eccf_t WHERE eccfent = g_enterprise AND eccfsite = g_site
         AND eccfdocno = p_eccbdocno AND eccf003 = p_eccb003
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "DEL eccf_t" 
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = TRUE 
         CALL cl_err()                 
         RETURN r_success
      END IF
      
      DELETE FROM eccg_t WHERE eccgent = g_enterprise AND eccgsite = g_site
         AND eccgdocno = p_eccbdocno AND eccg003 = p_eccb003
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "DEL eccg_t" 
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = TRUE 
         CALL cl_err()                 
         RETURN r_success
      END IF
      
      #变更历程档，包括eccb、eccc、eccd、ecce、eccf、eccg对应的
      DELETE FROM ecch_t WHERE ecchent = g_enterprise AND ecchsite = g_site
         AND ecchdocno = p_eccbdocno AND ecchseq = p_eccb003
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "DEL ecch_t" 
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = TRUE 
         CALL cl_err()                 
         RETURN r_success
      END IF
   END IF
   
   LET r_success = TRUE
   RETURN r_success
END FUNCTION

##删除原有单身时不做delete，而是update变更类型为4.单身删除，以及对相关关联表的更新
PRIVATE FUNCTION aect801_eccc_delete(p_ecccdocno,p_eccc003,p_eccc004)
DEFINE p_ecccdocno            LIKE eccc_t.ecccdocno
DEFINE p_eccc003              LIKE eccc_t.eccc003
DEFINE p_eccc004              LIKE eccc_t.eccc004
DEFINE r_success              LIKE type_t.num5
#DEFINE l_eccc                 RECORD LIKE eccc_t.*  #161124-00048#2     2016/12/06 By 08734 mark
#161124-00048#2     2016/12/06 By 08734 add(S)
DEFINE l_eccc RECORD  #料件製程變更用料底稿
       ecccent LIKE eccc_t.ecccent, #企业编号
       ecccsite LIKE eccc_t.ecccsite, #营运据点
       ecccdocno LIKE eccc_t.ecccdocno, #申请单号
       eccc001 LIKE eccc_t.eccc001, #工艺料号
       eccc002 LIKE eccc_t.eccc002, #工艺编号
       eccc003 LIKE eccc_t.eccc003, #工艺项次
       eccc004 LIKE eccc_t.eccc004, #项次
       eccc005 LIKE eccc_t.eccc005, #元件料号
       eccc006 LIKE eccc_t.eccc006, #部位
       eccc007 LIKE eccc_t.eccc007, #组成用量
       eccc008 LIKE eccc_t.eccc008, #主件底数
       eccc009 LIKE eccc_t.eccc009, #用量单位
       eccc010 LIKE eccc_t.eccc010, #损耗率形态
       eccc900 LIKE eccc_t.eccc900, #变更序
       eccc901 LIKE eccc_t.eccc901, #变更类型
       eccc902 LIKE eccc_t.eccc902, #变更日期
       eccc905 LIKE eccc_t.eccc905, #变更理由
       eccc906 LIKE eccc_t.eccc906 #变更备注
END RECORD
#161124-00048#2     2016/12/06 By 08734 add(E)
DEFINE l_date                 LIKE eccc_t.eccc902
DEFINE l_eccd005              LIKE eccd_t.eccd005

   WHENEVER ERROR CONTINUE
   LET r_success = FALSE
   IF cl_null(p_ecccdocno) OR cl_null(p_eccc003) OR cl_null(p_eccc004) THEN                 
      RETURN r_success
   END IF
   
  # SELECT * INTO l_eccc.* FROM eccc_t WHERE ecccent = g_enterprise AND ecccsite = g_site  #161124-00048#2     2016/12/06 By 08734 mark
   SELECT ecccent,ecccsite,ecccdocno,eccc001,eccc002,eccc003,eccc004,eccc005,eccc006,eccc007,eccc008,eccc009,eccc010,eccc900,eccc901,eccc902,eccc905,eccc906 #161124-00048#2     2016/12/06 By 08734 add 
     INTO l_eccc.* FROM eccc_t WHERE ecccent = g_enterprise AND ecccsite = g_site
      AND ecccdocno = p_ecccdocno AND eccc003 = p_eccc003 AND eccc004 = p_eccc004
   IF l_eccc.eccc901 = '1' OR l_eccc.eccc901 = '2' THEN   
      LET l_date = cl_get_today()               
      UPDATE eccc_t SET eccc901 = '4',eccc902 = l_date
       WHERE ecccent = g_enterprise AND ecccsite = g_site 
         AND ecccdocno = p_ecccdocno AND eccc003 = p_eccc003 AND eccc004 = p_eccc004
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "UPD eccc_t" 
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = TRUE 
         CALL cl_err()                 
         RETURN r_success
      END IF
      IF NOT aect801_upd_eccc_ecch(p_ecccdocno,p_eccc003,p_eccc004) THEN
         RETURN r_success
      END IF
      
      DECLARE aect801_eccc_delete_cs CURSOR FOR
       SELECT eccd005 FROM eccd_t WHERE eccdent = g_enterprise AND eccdsite = g_site
          AND eccddocno = p_ecccdocno AND eccd003 = p_eccc003 AND eccd004 = p_eccc004
      FOREACH aect801_eccc_delete_cs INTO l_eccd005
         IF NOT aect801_eccd_delete(p_ecccdocno,p_eccc003,p_eccc004,l_eccd005) THEN
            RETURN r_success
         END IF
      END FOREACH
   END IF
      
   IF l_eccc.eccc901 = '3' THEN
      DELETE FROM eccc_t WHERE ecccent = g_enterprise AND ecccsite = g_site
         AND ecccdocno = p_ecccdocno AND eccc003 = p_eccc003 AND eccc004 = p_eccc004
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "DEL eccc_t" 
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = TRUE 
         CALL cl_err()                 
         RETURN r_success
      END IF
      
      DELETE FROM eccd_t WHERE eccdent = g_enterprise AND eccdsite = g_site
         AND eccddocno = p_ecccdocno AND eccd003 = p_eccc003 AND eccd004 = p_eccc004
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "DEL eccd_t" 
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = TRUE 
         CALL cl_err()                 
         RETURN r_success
      END IF
      
      #变更历程档，包括eccc和eccd对应的
      DELETE FROM ecch_t WHERE ecchent = g_enterprise AND ecchsite = g_site
         AND ecchdocno = p_ecccdocno AND ecchseq = p_eccc003 AND ecchseq1 = p_eccc004
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "DEL ecch_t" 
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = TRUE 
         CALL cl_err()                 
         RETURN r_success
      END IF
   END IF
   
   LET r_success = TRUE
   RETURN r_success
END FUNCTION

#删除原有单身时不做delete，而是update变更类型为4.单身删除，以及对相关关联表的更新
PRIVATE FUNCTION aect801_eccd_delete(p_eccddocno,p_eccd003,p_eccd004,p_eccd005)
DEFINE p_eccddocno                   LIKE eccd_t.eccddocno
DEFINE p_eccd003                     LIKE eccd_t.eccd003
DEFINE p_eccd004                     LIKE eccd_t.eccd004
DEFINE p_eccd005                     LIKE eccd_t.eccd005
DEFINE r_success                     LIKE type_t.num5
DEFINE l_date                        LIKE eccd_t.eccd902
#DEFINE l_eccd                        RECORD LIKE eccd_t.*  #161124-00048#2     2016/12/06 By 08734 mark
#161124-00048#2     2016/12/06 By 08734 add(S)
DEFINE l_eccd RECORD  #料件製程變更用料底稿損秏率檔
       eccdent LIKE eccd_t.eccdent, #企业编号
       eccdsite LIKE eccd_t.eccdsite, #营运据点
       eccddocno LIKE eccd_t.eccddocno, #申请单号
       eccd001 LIKE eccd_t.eccd001, #料件编号
       eccd002 LIKE eccd_t.eccd002, #工艺编号
       eccd003 LIKE eccd_t.eccd003, #工艺项次
       eccd004 LIKE eccd_t.eccd004, #项次
       eccd005 LIKE eccd_t.eccd005, #起始数量
       eccd006 LIKE eccd_t.eccd006, #截止数量
       eccd007 LIKE eccd_t.eccd007, #变动损耗率
       eccd008 LIKE eccd_t.eccd008, #固定损耗量
       eccd900 LIKE eccd_t.eccd900, #变更序
       eccd901 LIKE eccd_t.eccd901, #变更类型
       eccd902 LIKE eccd_t.eccd902, #变更日期
       eccd905 LIKE eccd_t.eccd905, #变更原因
       eccd906 LIKE eccd_t.eccd906, #变更备注
       eccdseq LIKE eccd_t.eccdseq #项序
END RECORD
#161124-00048#2     2016/12/06 By 08734 add(E)

   WHENEVER ERROR CONTINUE
   LET r_success = FALSE
   IF cl_null(p_eccddocno) OR cl_null(p_eccd003) OR cl_null(p_eccd004) OR cl_null(p_eccd005) THEN                 
      RETURN r_success
   END IF
   
   #SELECT * INTO l_eccd.* FROM eccd_t WHERE eccdent = g_enterprise AND eccdsite = g_site  #161124-00048#2     2016/12/06 By 08734 mark
   SELECT eccdent,eccdsite,eccddocno,eccd001,eccd002,eccd003,eccd004,eccd005,eccd006,eccd007,eccd008,eccd900,eccd901,eccd902,eccd905,eccd906,eccdseq  #161124-00048#2     2016/12/06 By 08734 add 
     INTO l_eccd.* FROM eccd_t WHERE eccdent = g_enterprise AND eccdsite = g_site
      AND eccddocno = p_eccddocno AND eccd003 = p_eccd003 AND eccd004 = p_eccd004 AND eccd005 = p_eccd005
   IF l_eccd.eccd901 = '1' OR l_eccd.eccd901 = '2' THEN   
      LET l_date = cl_get_today()               
      UPDATE eccd_t SET eccd901 = '4',eccd902 = l_date
       WHERE eccdent = g_enterprise AND eccdsite = g_site 
         AND eccddocno = p_eccddocno AND eccd003 = p_eccd003 AND eccd004 = p_eccd004 AND eccd005 = p_eccd005
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "UPD eccd_t" 
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = TRUE 
         CALL cl_err()                 
         RETURN r_success
      END IF
      IF NOT aect801_upd_eccd_ecch(p_eccddocno,p_eccd003,p_eccd004,l_eccd.eccdseq) THEN
         RETURN r_success
      END IF
   END IF
      
   IF l_eccd.eccd901 = '3' THEN
      DELETE FROM eccd_t WHERE eccdent = g_enterprise AND eccdsite = g_site
         AND eccddocno = p_eccddocno AND eccd003 = p_eccd003 AND eccd004 = p_eccd004 AND eccd005 = p_eccd005
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "DEL eccd_t" 
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = TRUE 
         CALL cl_err()                 
         RETURN r_success
      END IF
      
      #变更历程档删除
      DELETE FROM ecch_t WHERE ecchent = g_enterprise AND ecchsite = g_site
         AND ecchdocno = p_eccddocno AND ecchseq = p_eccd003 AND ecchseq1 = p_eccd004
         AND ecchseq2 = l_eccd.eccdseq
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "DEL ecch_t" 
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = TRUE 
         CALL cl_err()                 
         RETURN r_success
      END IF
   END IF
   
   LET r_success = TRUE
   RETURN r_success
   
END FUNCTION

#删除原有单身时不做delete，而是update变更类型为4.单身删除，以及对相关关联表的更新
PUBLIC FUNCTION aect801_ecce_delete(p_eccedocno,p_ecce003,p_ecceseq)
DEFINE p_eccedocno                  LIKE ecce_t.eccedocno
DEFINE p_ecce003                    LIKE ecce_t.ecce003
DEFINE p_ecceseq                    LIKE ecce_t.ecceseq
DEFINE r_success                    LIKE type_t.num5
DEFINE l_date                       LIKE ecce_t.ecce902
#DEFINE l_ecce                       RECORD LIKE ecce_t.*  #161124-00048#2     2016/12/06 By 08734 mark
#161124-00048#2     2016/12/06 By 08734 add(S)
DEFINE l_ecce RECORD  #料件製程變更上站作業資料
       ecceent LIKE ecce_t.ecceent, #企业编号
       eccesite LIKE ecce_t.eccesite, #营运据点
       eccedocno LIKE ecce_t.eccedocno, #申请单号
       ecce001 LIKE ecce_t.ecce001, #工艺料号
       ecce002 LIKE ecce_t.ecce002, #工艺编号
       ecce003 LIKE ecce_t.ecce003, #工艺项次
       ecceseq LIKE ecce_t.ecceseq, #项序
       ecce004 LIKE ecce_t.ecce004, #上站作业
       ecce005 LIKE ecce_t.ecce005, #上站作业序
       ecce900 LIKE ecce_t.ecce900, #变更序
       ecce901 LIKE ecce_t.ecce901, #变更类型
       ecce902 LIKE ecce_t.ecce902, #变更日期
       ecce905 LIKE ecce_t.ecce905, #变更原因
       ecce906 LIKE ecce_t.ecce906 #变更备注
END RECORD
#161124-00048#2     2016/12/06 By 08734 add(E)

   WHENEVER ERROR CONTINUE
   LET r_success = FALSE
   IF cl_null(p_eccedocno) OR cl_null(p_ecce003) OR cl_null(p_ecceseq) THEN                 
      RETURN r_success
   END IF
   
   #SELECT * INTO l_ecce.* FROM ecce_t WHERE ecceent = g_enterprise AND eccesite = g_site  #161124-00048#2     2016/12/06 By 08734 mark
   SELECT ecceent,eccesite,eccedocno,ecce001,ecce002,ecce003,ecceseq,ecce004,ecce005,ecce900,ecce901,ecce902,ecce905,ecce906  #161124-00048#2     2016/12/06 By 08734 add
     INTO l_ecce.* FROM ecce_t WHERE ecceent = g_enterprise AND eccesite = g_site
      AND eccedocno = p_eccedocno AND ecce003 = p_ecce003 AND ecceseq = p_ecceseq
   IF l_ecce.ecce901 = '1' OR l_ecce.ecce901 = '2' THEN   
      LET l_date = cl_get_today()               
      UPDATE ecce_t SET ecce901 = '4',ecce902 = l_date
       WHERE ecceent = g_enterprise AND eccesite = g_site 
         AND eccedocno = p_eccedocno AND ecce003 = p_ecce003 AND ecceseq = p_ecceseq
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "UPD ecce_t" 
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = TRUE 
         CALL cl_err()                 
         RETURN r_success
      END IF
      IF NOT aect801_upd_ecce_ecch(p_eccedocno,p_ecce003,p_ecceseq) THEN
         RETURN r_success
      END IF
   END IF
   
   IF l_ecce.ecce901 = '3' THEN
      DELETE FROM ecce_t WHERE ecceent = g_enterprise AND eccesite = g_site
         AND eccedocno = p_eccedocno AND ecce003 = p_ecce003 AND ecceseq = p_ecceseq
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "DEL ecce_t" 
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = TRUE 
         CALL cl_err()                 
         RETURN r_success
      END IF
      
      #变更历程档删除
      DELETE FROM ecch_t WHERE ecchent = g_enterprise AND ecchsite = g_site
         AND ecchdocno = p_eccedocno AND ecchseq = p_ecce003 AND ecchseq1 = p_ecceseq
         AND ecch002 LIKE 'ecbe%'
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "DEL ecch_t" 
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = TRUE 
         CALL cl_err()                 
         RETURN r_success
      END IF
   END IF
   
   LET r_success = TRUE
   RETURN r_success
END FUNCTION

#删除原有单身时不做delete，而是update变更类型为4.单身删除，以及对相关关联表的更新
PUBLIC FUNCTION aect801_eccf_delete(p_eccfdocno,p_eccf003,p_eccfseq)
DEFINE p_eccfdocno                  LIKE eccf_t.eccfdocno
DEFINE p_eccf003                    LIKE eccf_t.eccf003
DEFINE p_eccfseq                    LIKE eccf_t.eccfseq
DEFINE r_success                    LIKE type_t.num5
DEFINE l_date                       LIKE eccf_t.eccf902
#DEFINE l_eccf                       RECORD LIKE eccf_t.*  #161124-00048#2     2016/12/06 By 08734 mark
#161124-00048#2     2016/12/06 By 08734 add(S)
DEFINE l_eccf RECORD  #料件製程check in/out項目資料
       eccfent LIKE eccf_t.eccfent, #企业编号
       eccfsite LIKE eccf_t.eccfsite, #营运据点
       eccfdocno LIKE eccf_t.eccfdocno, #申请单号
       eccf001 LIKE eccf_t.eccf001, #工艺料号
       eccf002 LIKE eccf_t.eccf002, #工艺编号
       eccf003 LIKE eccf_t.eccf003, #工艺项次
       eccfseq LIKE eccf_t.eccfseq, #项序
       eccf004 LIKE eccf_t.eccf004, #check in/check out
       eccf005 LIKE eccf_t.eccf005, #项目
       eccf006 LIKE eccf_t.eccf006, #形态
       eccf007 LIKE eccf_t.eccf007, #下限
       eccf008 LIKE eccf_t.eccf008, #上限
       eccf009 LIKE eccf_t.eccf009, #默认值
       eccf010 LIKE eccf_t.eccf010, #必要
       eccf900 LIKE eccf_t.eccf900, #变更序
       eccf901 LIKE eccf_t.eccf901, #变更类型
       eccf902 LIKE eccf_t.eccf902, #变更日期
       eccf905 LIKE eccf_t.eccf905, #变更原因
       eccf906 LIKE eccf_t.eccf906 #变更备注
END RECORD
#161124-00048#2     2016/12/06 By 08734 add(E)

   WHENEVER ERROR CONTINUE
   LET r_success = FALSE
   IF cl_null(p_eccfdocno) OR cl_null(p_eccf003) OR cl_null(p_eccfseq) THEN                 
      RETURN r_success
   END IF
   
   #SELECT * INTO l_eccf.* FROM eccf_t WHERE eccfent = g_enterprise AND eccfsite = g_site  #161124-00048#2     2016/12/06 By 08734 mark
   SELECT eccfent,eccfsite,eccfdocno,eccf001,eccf002,eccf003,eccfseq,eccf004,eccf005,eccf006,eccf007,eccf008,eccf009,eccf010,eccf900,eccf901,eccf902,eccf905,eccf906  #161124-00048#2     2016/12/06 By 08734 add
     INTO l_eccf.* FROM eccf_t WHERE eccfent = g_enterprise AND eccfsite = g_site
      AND eccfdocno = p_eccfdocno AND eccf003 = p_eccf003 AND eccfseq = p_eccfseq
   IF l_eccf.eccf901 = '1' OR l_eccf.eccf901 = '2' THEN   
      LET l_date = cl_get_today()               
      UPDATE eccf_t SET eccf901 = '4',eccf902 = l_date
       WHERE eccfent = g_enterprise AND eccfsite = g_site 
         AND eccfdocno = p_eccfdocno AND eccf003 = p_eccf003 AND eccfseq = p_eccfseq
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "UPD eccf_t" 
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = TRUE 
         CALL cl_err()                 
         RETURN r_success
      END IF
      IF NOT aect801_upd_eccf_ecch(p_eccfdocno,p_eccf003,p_eccfseq) THEN
         RETURN r_success
      END IF
   END IF
   
   IF l_eccf.eccf901 = '3' THEN
      DELETE FROM eccf_t WHERE eccfent = g_enterprise AND eccfsite = g_site
         AND eccfdocno = p_eccfdocno AND eccf003 = p_eccf003 AND eccfseq = p_eccfseq
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "DEL eccf_t" 
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = TRUE 
         CALL cl_err()                 
         RETURN r_success
      END IF
      
      #变更历程档删除
      DELETE FROM ecch_t WHERE ecchent = g_enterprise AND ecchsite = g_site
         AND ecchdocno = p_eccfdocno AND ecchseq = p_eccf003 AND ecchseq1 = p_eccfseq
         AND ecch002 LIKE 'ecbf%'
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "DEL ecch_t" 
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = TRUE 
         CALL cl_err()                 
         RETURN r_success
      END IF
   END IF
   
   LET r_success = TRUE
   RETURN r_success
END FUNCTION

#删除原有单身时不做delete，而是update变更类型为4.单身删除，以及对相关关联表的更新
PUBLIC FUNCTION aect801_eccg_delete(p_eccgdocno,p_eccg003,p_eccgseq)
DEFINE p_eccgdocno                  LIKE eccg_t.eccgdocno
DEFINE p_eccg003                    LIKE eccg_t.eccg003
DEFINE p_eccgseq                    LIKE eccg_t.eccgseq
DEFINE r_success                    LIKE type_t.num5
DEFINE l_date                       LIKE eccg_t.eccg902
#DEFINE l_eccg                       RECORD LIKE eccg_t.*  #161124-00048#2     2016/12/06 By 08734 mark
#161124-00048#2     2016/12/06 By 08734 add(S)
DEFINE l_eccg RECORD  #料件製程變更資源項目檔
       eccgent LIKE eccg_t.eccgent, #企业编号
       eccgsite LIKE eccg_t.eccgsite, #营运据点
       eccgdocno LIKE eccg_t.eccgdocno, #申请单号
       eccg001 LIKE eccg_t.eccg001, #工艺料号
       eccg002 LIKE eccg_t.eccg002, #工艺编号
       eccg003 LIKE eccg_t.eccg003, #工艺项次
       eccgseq LIKE eccg_t.eccgseq, #项序
       eccg004 LIKE eccg_t.eccg004, #资源类型
       eccg005 LIKE eccg_t.eccg005, #资源项目
       eccg006 LIKE eccg_t.eccg006, #固定标准工时
       eccg007 LIKE eccg_t.eccg007, #变动标准工时
       eccg008 LIKE eccg_t.eccg008, #变动标准工时批量
       eccg009 LIKE eccg_t.eccg009, #效率
       eccg900 LIKE eccg_t.eccg900, #变更序
       eccg901 LIKE eccg_t.eccg901, #变更类型
       eccg902 LIKE eccg_t.eccg902, #变更日期
       eccg905 LIKE eccg_t.eccg905, #变更原因
       eccg906 LIKE eccg_t.eccg906 #变更备注
END RECORD
#161124-00048#2     2016/12/06 By 08734 add(E)

   WHENEVER ERROR CONTINUE
   LET r_success = FALSE
   IF cl_null(p_eccgdocno) OR cl_null(p_eccg003) OR cl_null(p_eccgseq) THEN                 
      RETURN r_success
   END IF
   
   #SELECT * INTO l_eccg.* FROM eccg_t WHERE eccgent = g_enterprise AND eccgsite = g_site  #161124-00048#2     2016/12/06 By 08734 mark
   SELECT eccgent,eccgsite,eccgdocno,eccg001,eccg002,eccg003,eccgseq,eccg004,eccg005,eccg006,eccg007,eccg008,eccg009,eccg900,eccg901,eccg902,eccg905,eccg906 #161124-00048#2     2016/12/06 By 08734 add 
     INTO l_eccg.* FROM eccg_t WHERE eccgent = g_enterprise AND eccgsite = g_site
      AND eccgdocno = p_eccgdocno AND eccg003 = p_eccg003 AND eccgseq = p_eccgseq
   IF l_eccg.eccg901 = '1' OR l_eccg.eccg901 = '2' THEN   
      LET l_date = cl_get_today()               
      UPDATE eccg_t SET eccg901 = '4',eccg902 = l_date
       WHERE eccgent = g_enterprise AND eccgsite = g_site 
         AND eccgdocno = p_eccgdocno AND eccg003 = p_eccg003 AND eccgseq = p_eccgseq
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "UPD eccg_t" 
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = TRUE 
         CALL cl_err()                 
         RETURN r_success
      END IF
      IF NOT aect801_upd_eccg_ecch(p_eccgdocno,p_eccg003,p_eccgseq) THEN
         RETURN r_success
      END IF
   END IF
   
   IF l_eccg.eccg901 = '3' THEN
      DELETE FROM eccg_t WHERE eccgent = g_enterprise AND eccgsite = g_site
         AND eccgdocno = p_eccgdocno AND eccg003 = p_eccg003 AND eccgseq = p_eccgseq
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "DEL eccg_t" 
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = TRUE 
         CALL cl_err()                 
         RETURN r_success
      END IF
      
      #变更历程档删除
      DELETE FROM ecch_t WHERE ecchent = g_enterprise AND ecchsite = g_site
         AND ecchdocno = p_eccgdocno AND ecchseq = p_eccg003 AND ecchseq1 = p_eccgseq
         AND ecch002 LIKE 'ecbf%'
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "DEL ecch_t" 
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = TRUE 
         CALL cl_err()                 
         RETURN r_success
      END IF
   END IF
   
   LET r_success = TRUE
   RETURN r_success
END FUNCTION

#上站作业资料写入变更历程档
PUBLIC FUNCTION aect801_upd_ecce_ecch(p_ecchdocno,p_ecchseq,p_ecchseq1)
DEFINE p_ecchdocno                LIKE ecch_t.ecchdocno
DEFINE p_ecchseq                  LIKE ecch_t.ecchseq
DEFINE p_ecchseq1                 LIKE ecch_t.ecchseq1
DEFINE r_success                  LIKE type_t.num5
#DEFINE l_ecbe                     RECORD LIKE ecbe_t.*  #161124-00048#2     2016/12/06 By 08734 mark
#161124-00048#2     2016/12/06 By 08734 add(S)
DEFINE l_ecbe RECORD  #料件製程上站作業資料
       ecbeent LIKE ecbe_t.ecbeent, #企业编号
       ecbesite LIKE ecbe_t.ecbesite, #营运据点
       ecbe001 LIKE ecbe_t.ecbe001, #工艺料号
       ecbe002 LIKE ecbe_t.ecbe002, #工艺编号
       ecbe003 LIKE ecbe_t.ecbe003, #工艺项次
       ecbeseq LIKE ecbe_t.ecbeseq, #项序
       ecbe004 LIKE ecbe_t.ecbe004, #上站作业
       ecbe005 LIKE ecbe_t.ecbe005 #上站作业序
END RECORD
#161124-00048#2     2016/12/06 By 08734 add(E)
#DEFINE l_ecce                     RECORD LIKE ecce_t.*  #161124-00048#2     2016/12/06 By 08734 mark
#161124-00048#2     2016/12/06 By 08734 add(S)
DEFINE l_ecce RECORD  #料件製程變更上站作業資料
       ecceent LIKE ecce_t.ecceent, #企业编号
       eccesite LIKE ecce_t.eccesite, #营运据点
       eccedocno LIKE ecce_t.eccedocno, #申请单号
       ecce001 LIKE ecce_t.ecce001, #工艺料号
       ecce002 LIKE ecce_t.ecce002, #工艺编号
       ecce003 LIKE ecce_t.ecce003, #工艺项次
       ecceseq LIKE ecce_t.ecceseq, #项序
       ecce004 LIKE ecce_t.ecce004, #上站作业
       ecce005 LIKE ecce_t.ecce005, #上站作业序
       ecce900 LIKE ecce_t.ecce900, #变更序
       ecce901 LIKE ecce_t.ecce901, #变更类型
       ecce902 LIKE ecce_t.ecce902, #变更日期
       ecce905 LIKE ecce_t.ecce905, #变更原因
       ecce906 LIKE ecce_t.ecce906 #变更备注
END RECORD
#161124-00048#2     2016/12/06 By 08734 add(E)
DEFINE l_flag                     LIKE type_t.chr1

   LET r_success = FALSE
   LET l_flag = 'N'
   IF g_ecca_m.ecca004 = '1' THEN
      LET r_success = TRUE
      RETURN r_success
   END IF
   IF cl_null(p_ecchdocno) OR cl_null(p_ecchseq) OR cl_null(p_ecchseq1) THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'sub-00001'
      LET g_errparam.extend = ''
      LET g_errparam.popup = TRUE
      CALL cl_err()
      RETURN r_success
   END IF
   
   INITIALIZE l_ecbe.* TO NULL
   INITIALIZE l_ecce.* TO NULL
  # SELECT * INTO l_ecce.* FROM ecce_t WHERE ecceent = g_enterprise AND eccesite = g_site  #161124-00048#2     2016/12/06 By 08734 mark
   SELECT ecceent,eccesite,eccedocno,ecce001,ecce002,ecce003,ecceseq,ecce004,ecce005,ecce900,ecce901,ecce902,ecce905,ecce906  #161124-00048#2     2016/12/06 By 08734 add  
     INTO l_ecce.* FROM ecce_t WHERE ecceent = g_enterprise AND eccesite = g_site
      AND eccedocno = p_ecchdocno AND ecce003 = p_ecchseq AND ecceseq = p_ecchseq1
      
   IF l_ecce.ecce901 = '1' THEN
      LET r_success = TRUE
      RETURN r_success
   END IF
   
   IF l_ecce.ecce901 = '2' OR l_ecce.ecce901 = '4' THEN
      #SELECT * INTO l_ecbe.* FROM ecbe_t WHERE ecbeent = g_enterprise AND ecbesite = g_site  #161124-00048#2     2016/12/06 By 08734 mark
      SELECT ecbeent,ecbesite,ecbe001,ecbe002,ecbe003,ecbeseq,ecbe004,ecbe005  #161124-00048#2     2016/12/06 By 08734 add 
        INTO l_ecbe.* FROM ecbe_t WHERE ecbeent = g_enterprise AND ecbesite = g_site
         AND ecbe001 = g_ecca_m.ecca001 AND ecbe002 = g_ecca_m.ecca002
         AND ecbe003 = p_ecchseq AND ecbeseq = p_ecchseq1
   END IF
   
   LET g_ecch003 = ''
   IF l_ecce.ecce901 = '2' THEN
      LET g_ecch003 = '10'
   END IF
   IF l_ecce.ecce901 = '3' THEN
      LET g_ecch003 = '11'
   END IF
   IF l_ecce.ecce901 = '4' THEN
      INITIALIZE l_ecce.* TO NULL
      LET g_ecch003 = '12'
   END IF
   
      
   #项序
   IF (NOT cl_null(l_ecce.ecceseq) AND (l_ecce.ecceseq != l_ecbe.ecbeseq OR l_ecbe.ecbeseq IS NULL)) OR (cl_null(l_ecce.ecceseq) AND l_ecbe.ecbeseq IS NOT NULL) THEN
      #其說明的SQL
      LET g_ecch007 = ""
      IF NOT s_aect801_ins_ecch(p_ecchdocno,p_ecchseq,p_ecchseq1,-1,'ecbeseq',g_ecch003,l_ecbe.ecbeseq,l_ecce.ecceseq,g_ecch007) THEN
         RETURN r_success
      END IF
      LET l_flag = 'Y'
   ELSE
      IF NOT s_aect801_del_ecch(p_ecchdocno,p_ecchseq,p_ecchseq1,-1,'ecbeseq') THEN
         RETURN r_success
      END IF
   END IF

   #上站作业
   IF (NOT cl_null(l_ecce.ecce004) AND (l_ecce.ecce004 != l_ecbe.ecbe004 OR l_ecbe.ecbe004 IS NULL)) OR (cl_null(l_ecce.ecce004) AND l_ecbe.ecbe004 IS NOT NULL) THEN
      #其說明的SQL
      LET g_ecch007 = "SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001='221' AND oocql002='"||l_ecbe.ecbe004||"' AND oocql003=?"
      IF NOT s_aect801_ins_ecch(p_ecchdocno,p_ecchseq,p_ecchseq1,-1,'ecbe004',g_ecch003,l_ecbe.ecbe004,l_ecce.ecce004,g_ecch007) THEN
         RETURN r_success
      END IF
      LET l_flag = 'Y'
   ELSE
      IF NOT s_aect801_del_ecch(p_ecchdocno,p_ecchseq,p_ecchseq1,-1,'ecbe004') THEN
         RETURN r_success
      END IF
   END IF

   #上站作业序
   IF (NOT cl_null(l_ecce.ecce005) AND (l_ecce.ecce005 != l_ecbe.ecbe005 OR l_ecbe.ecbe005 IS NULL)) OR (cl_null(l_ecce.ecce005) AND l_ecbe.ecbe005 IS NOT NULL) THEN
      #其說明的SQL
      LET g_ecch007 = ""
      IF NOT s_aect801_ins_ecch(p_ecchdocno,p_ecchseq,p_ecchseq1,-1,'ecbe005',g_ecch003,l_ecbe.ecbe005,l_ecce.ecce005,g_ecch007) THEN
         RETURN r_success
      END IF
      LET l_flag = 'Y'
   ELSE
      IF NOT s_aect801_del_ecch(p_ecchdocno,p_ecchseq,p_ecchseq1,-1,'ecbe005') THEN
         RETURN r_success
      END IF
   END IF
   
   #未有发生变更，则更新ecce901
   IF l_flag = 'N' THEN
      UPDATE ecce_t SET ecce901 = '1' WHERE ecceent = g_enterprise AND eccesite = g_site
         AND eccedocno = p_ecchdocno AND ecce003 = p_ecchseq AND ecceseq = p_ecchseq1
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "upd ecce901"
         LET g_errparam.popup = TRUE
         CALL cl_err()
         RETURN r_success
      END IF
   END IF
   
   LET r_success = TRUE
   RETURN r_success
END FUNCTION

#check in/out资料写入变更历程档
PUBLIC FUNCTION aect801_upd_eccf_ecch(p_ecchdocno,p_ecchseq,p_ecchseq1)
DEFINE p_ecchdocno                LIKE ecch_t.ecchdocno
DEFINE p_ecchseq                  LIKE ecch_t.ecchseq
DEFINE p_ecchseq1                 LIKE ecch_t.ecchseq1
DEFINE r_success                  LIKE type_t.num5
#DEFINE l_ecbf                     RECORD LIKE ecbf_t.*  #161124-00048#2     2016/12/06 By 08734 mark
#161124-00048#2     2016/12/06 By 08734 add(S)
DEFINE l_ecbf RECORD  #料件製程check in/out專案資料
       ecbfent LIKE ecbf_t.ecbfent, #企业编号
       ecbfsite LIKE ecbf_t.ecbfsite, #营运据点
       ecbf001 LIKE ecbf_t.ecbf001, #工艺料号
       ecbf002 LIKE ecbf_t.ecbf002, #工艺编号
       ecbf003 LIKE ecbf_t.ecbf003, #工艺项次
       ecbfseq LIKE ecbf_t.ecbfseq, #项序
       ecbf004 LIKE ecbf_t.ecbf004, #check in/check out
       ecbf005 LIKE ecbf_t.ecbf005, #项目
       ecbf006 LIKE ecbf_t.ecbf006, #型态
       ecbf007 LIKE ecbf_t.ecbf007, #下限
       ecbf008 LIKE ecbf_t.ecbf008, #上限
       ecbf009 LIKE ecbf_t.ecbf009, #默认值
       ecbf010 LIKE ecbf_t.ecbf010 #必要
END RECORD
#161124-00048#2     2016/12/06 By 08734 add(E)
#DEFINE l_eccf                     RECORD LIKE eccf_t.*  #161124-00048#2     2016/12/06 By 08734 mark
#161124-00048#2     2016/12/06 By 08734 add(S)
DEFINE l_eccf RECORD  #料件製程check in/out項目資料
       eccfent LIKE eccf_t.eccfent, #企业编号
       eccfsite LIKE eccf_t.eccfsite, #营运据点
       eccfdocno LIKE eccf_t.eccfdocno, #申请单号
       eccf001 LIKE eccf_t.eccf001, #工艺料号
       eccf002 LIKE eccf_t.eccf002, #工艺编号
       eccf003 LIKE eccf_t.eccf003, #工艺项次
       eccfseq LIKE eccf_t.eccfseq, #项序
       eccf004 LIKE eccf_t.eccf004, #check in/check out
       eccf005 LIKE eccf_t.eccf005, #项目
       eccf006 LIKE eccf_t.eccf006, #形态
       eccf007 LIKE eccf_t.eccf007, #下限
       eccf008 LIKE eccf_t.eccf008, #上限
       eccf009 LIKE eccf_t.eccf009, #默认值
       eccf010 LIKE eccf_t.eccf010, #必要
       eccf900 LIKE eccf_t.eccf900, #变更序
       eccf901 LIKE eccf_t.eccf901, #变更类型
       eccf902 LIKE eccf_t.eccf902, #变更日期
       eccf905 LIKE eccf_t.eccf905, #变更原因
       eccf906 LIKE eccf_t.eccf906 #变更备注
END RECORD
#161124-00048#2     2016/12/06 By 08734 add(E)
DEFINE l_flag                     LIKE type_t.chr1

   LET r_success = FALSE
   LET l_flag = 'N'
   IF g_ecca_m.ecca004 = '1' THEN
      LET r_success = TRUE
      RETURN r_success
   END IF
   IF cl_null(p_ecchdocno) OR cl_null(p_ecchseq) OR cl_null(p_ecchseq1) THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'sub-00001'
      LET g_errparam.extend = ''
      LET g_errparam.popup = TRUE
      CALL cl_err()
      RETURN r_success
   END IF
   
   INITIALIZE l_ecbf.* TO NULL
   INITIALIZE l_eccf.* TO NULL
  # SELECT * INTO l_eccf.* FROM eccf_t WHERE eccfent = g_enterprise AND eccfsite = g_site  #161124-00048#2     2016/12/06 By 08734 mark
   SELECT eccfent,eccfsite,eccfdocno,eccf001,eccf002,eccf003,eccfseq,eccf004,eccf005,eccf006,eccf007,eccf008,eccf009,eccf010,eccf900,eccf901,eccf902,eccf905,eccf906  #161124-00048#2     2016/12/06 By 08734 add 
     INTO l_eccf.* FROM eccf_t WHERE eccfent = g_enterprise AND eccfsite = g_site
      AND eccfdocno = p_ecchdocno AND eccf003 = p_ecchseq AND eccfseq = p_ecchseq1
   
   IF l_eccf.eccf901 = '1' THEN
      LET r_success = TRUE
      RETURN r_success
   END IF
   
   IF l_eccf.eccf901 = '2' OR l_eccf.eccf901 = '4' THEN
      #SELECT * INTO l_ecbf.* FROM ecbf_t WHERE ecbfent = g_enterprise AND ecbfsite = g_site  #161124-00048#2     2016/12/06 By 08734 mark
      SELECT  ecbfent,ecbfsite,ecbf001,ecbf002,ecbf003,ecbfseq,ecbf004,ecbf005,ecbf006,ecbf007,ecbf008,ecbf009,ecbf010  #161124-00048#2     2016/12/06 By 08734 add
        INTO l_ecbf.* FROM ecbf_t WHERE ecbfent = g_enterprise AND ecbfsite = g_site
         AND ecbf001 = g_ecca_m.ecca001 AND ecbf002 = g_ecca_m.ecca002
         AND ecbf003 = p_ecchseq AND ecbfseq = p_ecchseq1
   END IF
   
   LET g_ecch003 = ''
   IF l_eccf.eccf901 = '2' THEN
      IF l_eccf.eccf004 = '1' THEN
         LET g_ecch003 = '4'
      END IF
      IF l_eccf.eccf004 = '2' THEN
         LET g_ecch003 = '7'
      END IF
   END IF
   IF l_eccf.eccf901 = '3' THEN
      IF l_eccf.eccf004 = '1' THEN
         LET g_ecch003 = '5'
      END IF
      IF l_eccf.eccf004 = '2' THEN
         LET g_ecch003 = '8'
      END IF
   END IF
   IF l_eccf.eccf901 = '4' THEN      
      IF l_eccf.eccf004 = '1' THEN
         LET g_ecch003 = '6'
      END IF
      IF l_eccf.eccf004 = '2' THEN
         LET g_ecch003 = '9'
      END IF
      INITIALIZE l_eccf.* TO NULL
   END IF
      
   #项序
   IF (NOT cl_null(l_eccf.eccfseq) AND (l_eccf.eccfseq != l_ecbf.ecbfseq OR l_ecbf.ecbfseq IS NULL)) OR (cl_null(l_eccf.eccfseq) AND l_ecbf.ecbfseq IS NOT NULL) THEN
      #其說明的SQL
      LET g_ecch007 = ""
      IF NOT s_aect801_ins_ecch(p_ecchdocno,p_ecchseq,p_ecchseq1,-2,'ecbfseq',g_ecch003,l_ecbf.ecbfseq,l_eccf.eccfseq,g_ecch007) THEN
         RETURN r_success
      END IF
      LET l_flag = 'Y'
   ELSE
      IF NOT s_aect801_del_ecch(p_ecchdocno,p_ecchseq,p_ecchseq1,-2,'ecbfseq') THEN
         RETURN r_success
      END IF
   END IF

   #项目
   IF (NOT cl_null(l_eccf.eccf005) AND (l_eccf.eccf005 != l_ecbf.ecbf005 OR l_ecbf.ecbf005 IS NULL)) OR (cl_null(l_eccf.eccf005) AND l_ecbf.ecbf005 IS NOT NULL) THEN
      #其說明的SQL
      LET g_ecch007 = "SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001 = '223' AND oocql002='"||l_ecbf.ecbf005||"' AND oocql003=? "
      IF NOT s_aect801_ins_ecch(p_ecchdocno,p_ecchseq,p_ecchseq1,-2,'ecbf005',g_ecch003,l_ecbf.ecbf005,l_eccf.eccf005,g_ecch007) THEN
         RETURN r_success
      END IF
      LET l_flag = 'Y'
   ELSE
      IF NOT s_aect801_del_ecch(p_ecchdocno,p_ecchseq,p_ecchseq1,-2,'ecbf005') THEN
         RETURN r_success
      END IF
   END IF

   #形态
   IF (NOT cl_null(l_eccf.eccf006) AND (l_eccf.eccf006 != l_ecbf.ecbf006 OR l_ecbf.ecbf006 IS NULL)) OR (cl_null(l_eccf.eccf006) AND l_ecbf.ecbf006 IS NOT NULL) THEN
      #其說明的SQL
      LET g_ecch007 = ""
      IF NOT s_aect801_ins_ecch(p_ecchdocno,p_ecchseq,p_ecchseq1,-2,'ecbf006',g_ecch003,l_ecbf.ecbf006,l_eccf.eccf006,g_ecch007) THEN
         RETURN r_success
      END IF
      LET l_flag = 'Y'
   ELSE
      IF NOT s_aect801_del_ecch(p_ecchdocno,p_ecchseq,p_ecchseq1,-2,'ecbf006') THEN
         RETURN r_success
      END IF
   END IF
   
   #下限
   IF (NOT cl_null(l_eccf.eccf007) AND (l_eccf.eccf007 != l_ecbf.ecbf007 OR l_ecbf.ecbf007 IS NULL)) OR (cl_null(l_eccf.eccf007) AND l_ecbf.ecbf007 IS NOT NULL) THEN
      #其說明的SQL
      LET g_ecch007 = ""
      IF NOT s_aect801_ins_ecch(p_ecchdocno,p_ecchseq,p_ecchseq1,-2,'ecbf007',g_ecch003,l_ecbf.ecbf007,l_eccf.eccf007,g_ecch007) THEN
         RETURN r_success
      END IF
      LET l_flag = 'Y'
   ELSE
      IF NOT s_aect801_del_ecch(p_ecchdocno,p_ecchseq,p_ecchseq1,-2,'ecbf007') THEN
         RETURN r_success
      END IF
   END IF
   
   #上限
   IF (NOT cl_null(l_eccf.eccf008) AND (l_eccf.eccf008 != l_ecbf.ecbf008 OR l_ecbf.ecbf008 IS NULL)) OR (cl_null(l_eccf.eccf008) AND l_ecbf.ecbf008 IS NOT NULL) THEN
      #其說明的SQL
      LET g_ecch007 = ""
      IF NOT s_aect801_ins_ecch(p_ecchdocno,p_ecchseq,p_ecchseq1,-2,'ecbf008',g_ecch003,l_ecbf.ecbf008,l_eccf.eccf008,g_ecch007) THEN
         RETURN r_success
      END IF
      LET l_flag = 'Y'
   ELSE
      IF NOT s_aect801_del_ecch(p_ecchdocno,p_ecchseq,p_ecchseq1,-2,'ecbf008') THEN
         RETURN r_success
      END IF
   END IF
   
   #预设值
   IF (NOT cl_null(l_eccf.eccf009) AND (l_eccf.eccf009 != l_ecbf.ecbf009 OR l_ecbf.ecbf009 IS NULL)) OR (cl_null(l_eccf.eccf009) AND l_ecbf.ecbf009 IS NOT NULL) THEN
      #其說明的SQL
      LET g_ecch007 = ""
      IF NOT s_aect801_ins_ecch(p_ecchdocno,p_ecchseq,p_ecchseq1,-2,'ecbf009',g_ecch003,l_ecbf.ecbf009,l_eccf.eccf009,g_ecch007) THEN
         RETURN r_success
      END IF
      LET l_flag = 'Y'
   ELSE
      IF NOT s_aect801_del_ecch(p_ecchdocno,p_ecchseq,p_ecchseq1,-2,'ecbf009') THEN
         RETURN r_success
      END IF
   END IF
   
   #必要
   IF (NOT cl_null(l_eccf.eccf010) AND (l_eccf.eccf010 != l_ecbf.ecbf010 OR l_ecbf.ecbf010 IS NULL)) OR (cl_null(l_eccf.eccf010) AND l_ecbf.ecbf010 IS NOT NULL) THEN
      #其說明的SQL
      LET g_ecch007 = ""
      IF NOT s_aect801_ins_ecch(p_ecchdocno,p_ecchseq,p_ecchseq1,-2,'ecbf010',g_ecch003,l_ecbf.ecbf010,l_eccf.eccf010,g_ecch007) THEN
         RETURN r_success
      END IF
      LET l_flag = 'Y'
   ELSE
      IF NOT s_aect801_del_ecch(p_ecchdocno,p_ecchseq,p_ecchseq1,-2,'ecbf010') THEN
         RETURN r_success
      END IF
   END IF
   
   #未有发生变更，则更新eccf901
   IF l_flag = 'N' THEN
      UPDATE eccf_t SET eccf901 = '1' WHERE eccfent = g_enterprise AND eccfsite = g_site
         AND eccfdocno = p_ecchdocno AND eccf003 = p_ecchseq AND eccfseq = p_ecchseq1
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "upd eccf901"
         LET g_errparam.popup = TRUE
         CALL cl_err()
         RETURN r_success
      END IF
   END IF
   
   LET r_success = TRUE
   RETURN r_success
END FUNCTION

#制程资源项目写入变更历程档
PUBLIC FUNCTION aect801_upd_eccg_ecch(p_ecchdocno,p_ecchseq,p_ecchseq1)
DEFINE p_ecchdocno                LIKE ecch_t.ecchdocno
DEFINE p_ecchseq                  LIKE ecch_t.ecchseq
DEFINE p_ecchseq1                 LIKE ecch_t.ecchseq1
DEFINE r_success                  LIKE type_t.num5
#DEFINE l_ecbg                     RECORD LIKE ecbg_t.*  #161124-00048#2     2016/12/06 By 08734 mark
#161124-00048#2     2016/12/06 By 08734 add(S)
DEFINE l_ecbg RECORD  #料件製程資源項目檔
       ecbgent LIKE ecbg_t.ecbgent, #企业编号
       ecbgsite LIKE ecbg_t.ecbgsite, #营运据点
       ecbg001 LIKE ecbg_t.ecbg001, #工艺料号
       ecbg002 LIKE ecbg_t.ecbg002, #工艺编号
       ecbg003 LIKE ecbg_t.ecbg003, #项次
       ecbgseq LIKE ecbg_t.ecbgseq, #项序
       ecbg004 LIKE ecbg_t.ecbg004, #资源类型
       ecbg005 LIKE ecbg_t.ecbg005, #资源项目
       ecbg006 LIKE ecbg_t.ecbg006, #固定标准工时
       ecbg007 LIKE ecbg_t.ecbg007, #变动标准工时
       ecbg008 LIKE ecbg_t.ecbg008, #变动标准工时批量
       ecbg009 LIKE ecbg_t.ecbg009 #效率
END RECORD
#161124-00048#2     2016/12/06 By 08734 add(E)
#DEFINE l_eccg                     RECORD LIKE eccg_t.*  #161124-00048#2     2016/12/06 By 08734 mark
#161124-00048#2     2016/12/06 By 08734 add(S)
DEFINE l_eccg RECORD  #料件製程變更資源項目檔
       eccgent LIKE eccg_t.eccgent, #企业编号
       eccgsite LIKE eccg_t.eccgsite, #营运据点
       eccgdocno LIKE eccg_t.eccgdocno, #申请单号
       eccg001 LIKE eccg_t.eccg001, #工艺料号
       eccg002 LIKE eccg_t.eccg002, #工艺编号
       eccg003 LIKE eccg_t.eccg003, #工艺项次
       eccgseq LIKE eccg_t.eccgseq, #项序
       eccg004 LIKE eccg_t.eccg004, #资源类型
       eccg005 LIKE eccg_t.eccg005, #资源项目
       eccg006 LIKE eccg_t.eccg006, #固定标准工时
       eccg007 LIKE eccg_t.eccg007, #变动标准工时
       eccg008 LIKE eccg_t.eccg008, #变动标准工时批量
       eccg009 LIKE eccg_t.eccg009, #效率
       eccg900 LIKE eccg_t.eccg900, #变更序
       eccg901 LIKE eccg_t.eccg901, #变更类型
       eccg902 LIKE eccg_t.eccg902, #变更日期
       eccg905 LIKE eccg_t.eccg905, #变更原因
       eccg906 LIKE eccg_t.eccg906 #变更备注
END RECORD
#161124-00048#2     2016/12/06 By 08734 add(E)
DEFINE l_flag                     LIKE type_t.chr1

   LET r_success = FALSE
   LET l_flag = 'N'
   IF g_ecca_m.ecca004 = '1' THEN
      LET r_success = TRUE
      RETURN r_success
   END IF
   IF cl_null(p_ecchdocno) OR cl_null(p_ecchseq) OR cl_null(p_ecchseq1) THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'sub-00001'
      LET g_errparam.extend = ''
      LET g_errparam.popup = TRUE
      CALL cl_err()
      RETURN r_success
   END IF
   
   INITIALIZE l_ecbg.* TO NULL
   INITIALIZE l_eccg.* TO NULL
   #SELECT * INTO l_eccg.* FROM eccg_t WHERE eccgent = g_enterprise AND eccgsite = g_site  #161124-00048#2     2016/12/06 By 08734 mark
   SELECT eccgent,eccgsite,eccgdocno,eccg001,eccg002,eccg003,eccgseq,eccg004,eccg005,eccg006,eccg007,eccg008,eccg009,eccg900,eccg901,eccg902,eccg905,eccg906 #161124-00048#2     2016/12/06 By 08734 add  
     INTO l_eccg.* FROM eccg_t WHERE eccgent = g_enterprise AND eccgsite = g_site
      AND eccgdocno = p_ecchdocno AND eccg003 = p_ecchseq AND eccgseq = p_ecchseq1
   
   IF l_eccg.eccg901 = '1' THEN
      LET r_success = TRUE
      RETURN r_success
   END IF
   
   IF l_eccg.eccg901 = '2' OR l_eccg.eccg901 = '4' THEN
      #SELECT * INTO l_ecbg.* FROM ecbg_t WHERE ecbgent = g_enterprise AND ecbgsite = g_site  #161124-00048#2     2016/12/06 By 08734 mark
      SELECT  ecbgent,ecbgsite,ecbg001,ecbg002,ecbg003,ecbgseq,ecbg004,ecbg005,ecbg006,ecbg007,ecbg008,ecbg009  #161124-00048#2     2016/12/06 By 08734 add
        INTO l_ecbg.* FROM ecbg_t WHERE ecbgent = g_enterprise AND ecbgsite = g_site
         AND ecbg001 = g_ecca_m.ecca001 AND ecbg002 = g_ecca_m.ecca002
         AND ecbg003 = p_ecchseq AND ecbgseq = p_ecchseq1
      IF l_eccg.eccg901 = '4' THEN
         INITIALIZE l_eccg.* TO NULL
      END IF
   END IF
   
   LET g_ecch003 = ''
   IF l_eccg.eccg901 = '2' THEN
      LET g_ecch003 = '19'
   END IF
   IF l_eccg.eccg901 = '3' THEN
      LET g_ecch003 = '20'
   END IF
   IF l_eccg.eccg901 = '4' THEN
      INITIALIZE l_eccg.* TO NULL
      LET g_ecch003 = '21'
   END IF

   #项序
   IF (NOT cl_null(l_eccg.eccgseq) AND (l_eccg.eccgseq != l_ecbg.ecbgseq OR l_ecbg.ecbgseq IS NULL)) OR (cl_null(l_eccg.eccgseq) AND l_ecbg.ecbgseq IS NOT NULL) THEN
      #其說明的SQL
      LET g_ecch007 = ""
      IF NOT s_aect801_ins_ecch(p_ecchdocno,p_ecchseq,p_ecchseq1,-3,'ecbgseq',g_ecch003,l_ecbg.ecbgseq,l_eccg.eccgseq,g_ecch007) THEN
         RETURN r_success
      END IF
      LET l_flag = 'Y'
   ELSE
      IF NOT s_aect801_del_ecch(p_ecchdocno,p_ecchseq,p_ecchseq1,-3,'ecbgseq') THEN
         RETURN r_success
      END IF
   END IF

   #资源类型
   IF (NOT cl_null(l_eccg.eccg004) AND (l_eccg.eccg004 != l_ecbg.ecbg004 OR l_ecbg.ecbg004 IS NULL)) OR (cl_null(l_eccg.eccg004) AND l_ecbg.ecbg004 IS NOT NULL) THEN
      #其說明的SQL
      LET g_ecch007 = "SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001 = '224' AND oocql002='"||l_ecbg.ecbg005||"' AND oocql003=? "
      IF NOT s_aect801_ins_ecch(p_ecchdocno,p_ecchseq,p_ecchseq1,-3,'ecbg004',g_ecch003,l_ecbg.ecbg004,l_eccg.eccg004,g_ecch007) THEN
         RETURN r_success
      END IF
      LET l_flag = 'Y'
   ELSE
      IF NOT s_aect801_del_ecch(p_ecchdocno,p_ecchseq,p_ecchseq1,-3,'ecbg004') THEN
         RETURN r_success
      END IF
   END IF

   #资源项目
   IF (NOT cl_null(l_eccg.eccg005) AND (l_eccg.eccg005 != l_ecbg.ecbg005 OR l_ecbg.ecbg005 IS NULL)) OR (cl_null(l_eccg.eccg005) AND l_ecbg.ecbg005 IS NOT NULL) THEN
      #其說明的SQL
      LET g_ecch007 = ""
      IF NOT s_aect801_ins_ecch(p_ecchdocno,p_ecchseq,p_ecchseq1,-3,'ecbg005',g_ecch003,l_ecbg.ecbg005,l_eccg.eccg005,g_ecch007) THEN
         RETURN r_success
      END IF
      LET l_flag = 'Y'
   ELSE
      IF NOT s_aect801_del_ecch(p_ecchdocno,p_ecchseq,p_ecchseq1,-3,'ecbg005') THEN
         RETURN r_success
      END IF
   END IF
   
   #固定标准工时
   IF (NOT cl_null(l_eccg.eccg006) AND (l_eccg.eccg006 != l_ecbg.ecbg006 OR l_ecbg.ecbg006 IS NULL)) OR (cl_null(l_eccg.eccg006) AND l_ecbg.ecbg006 IS NOT NULL) THEN
      #其說明的SQL
      LET g_ecch007 = ""
      IF NOT s_aect801_ins_ecch(p_ecchdocno,p_ecchseq,p_ecchseq1,-3,'ecbg006',g_ecch003,l_ecbg.ecbg006,l_eccg.eccg006,g_ecch007) THEN
         RETURN r_success
      END IF
      LET l_flag = 'Y'
   ELSE
      IF NOT s_aect801_del_ecch(p_ecchdocno,p_ecchseq,p_ecchseq1,-3,'ecbg006') THEN
         RETURN r_success
      END IF
   END IF
   
   #变动标准工时
   IF (NOT cl_null(l_eccg.eccg007) AND (l_eccg.eccg007 != l_ecbg.ecbg007 OR l_ecbg.ecbg007 IS NULL)) OR (cl_null(l_eccg.eccg007) AND l_ecbg.ecbg007 IS NOT NULL) THEN
      #其說明的SQL
      LET g_ecch007 = ""
      IF NOT s_aect801_ins_ecch(p_ecchdocno,p_ecchseq,p_ecchseq1,-3,'ecbg007',g_ecch003,l_ecbg.ecbg007,l_eccg.eccg007,g_ecch007) THEN
         RETURN r_success
      END IF
      LET l_flag = 'Y'
   ELSE
      IF NOT s_aect801_del_ecch(p_ecchdocno,p_ecchseq,p_ecchseq1,-3,'ecbg007') THEN
         RETURN r_success
      END IF
   END IF
   
   #变动标准工时批量
   IF (NOT cl_null(l_eccg.eccg008) AND (l_eccg.eccg008 != l_ecbg.ecbg008 OR l_ecbg.ecbg008 IS NULL)) OR (cl_null(l_eccg.eccg008) AND l_ecbg.ecbg008 IS NOT NULL) THEN
      #其說明的SQL
      LET g_ecch007 = ""
      IF NOT s_aect801_ins_ecch(p_ecchdocno,p_ecchseq,p_ecchseq1,-3,'ecbg008',g_ecch003,l_ecbg.ecbg008,l_eccg.eccg008,g_ecch007) THEN
         RETURN r_success
      END IF
      LET l_flag = 'Y'
   ELSE
      IF NOT s_aect801_del_ecch(p_ecchdocno,p_ecchseq,p_ecchseq1,-3,'ecbg008') THEN
         RETURN r_success
      END IF
   END IF
   
   #效率
   IF (NOT cl_null(l_eccg.eccg009) AND (l_eccg.eccg009 != l_ecbg.ecbg009 OR l_ecbg.ecbg009 IS NULL)) OR (cl_null(l_eccg.eccg009) AND l_ecbg.ecbg009 IS NOT NULL) THEN
      #其說明的SQL
      LET g_ecch007 = ""
      IF NOT s_aect801_ins_ecch(p_ecchdocno,p_ecchseq,p_ecchseq1,-3,'ecbg009',g_ecch003,l_ecbg.ecbg009,l_eccg.eccg009,g_ecch007) THEN
         RETURN r_success
      END IF
      LET l_flag = 'Y'
   ELSE
      IF NOT s_aect801_del_ecch(p_ecchdocno,p_ecchseq,p_ecchseq1,-3,'ecbg009') THEN
         RETURN r_success
      END IF
   END IF
   
   #未有发生变更，则更新eccg901
   IF l_flag = 'N' THEN
      UPDATE eccg_t SET eccg901 = '1' WHERE eccgent = g_enterprise AND eccgsite = g_site
         AND eccgdocno = p_ecchdocno AND eccg003 = p_ecchseq AND eccgseq = p_ecchseq1
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "upd eccg901"
         LET g_errparam.popup = TRUE
         CALL cl_err()
         RETURN r_success
      END IF
   END IF
   
   LET r_success = TRUE
   RETURN r_success
END FUNCTION

#删除资料时，更新关联资料的上站作业
PRIVATE FUNCTION aect801_return_ecbb(p_eccbdocno,p_eccb003)
DEFINE p_eccbdocno                   LIKE eccb_t.eccbdocno
DEFINE p_eccb003                     LIKE eccb_t.eccb003
DEFINE r_success                     LIKE type_t.num5
#DEFINE l_eccb                        RECORD LIKE eccb_t.*  #161124-00048#2     2016/12/06 By 08734 mark
#161124-00048#2     2016/12/06 By 08734 add(S)
DEFINE l_eccb RECORD  #料件製程變更單身檔
       eccbent LIKE eccb_t.eccbent, #企业编号
       eccbsite LIKE eccb_t.eccbsite, #营运据点
       eccbdocno LIKE eccb_t.eccbdocno, #申请单号
       eccb001 LIKE eccb_t.eccb001, #工艺料号
       eccb002 LIKE eccb_t.eccb002, #工艺编号
       eccb003 LIKE eccb_t.eccb003, #项次
       eccb004 LIKE eccb_t.eccb004, #本站作业
       eccb005 LIKE eccb_t.eccb005, #作业序
       eccb006 LIKE eccb_t.eccb006, #群组性质
       eccb007 LIKE eccb_t.eccb007, #群组
       eccb008 LIKE eccb_t.eccb008, #上站作业
       eccb009 LIKE eccb_t.eccb009, #上站作业序
       eccb010 LIKE eccb_t.eccb010, #下站作业
       eccb011 LIKE eccb_t.eccb011, #下站作业序
       eccb012 LIKE eccb_t.eccb012, #工作站
       eccb013 LIKE eccb_t.eccb013, #允许委外
       eccb014 LIKE eccb_t.eccb014, #主要加工厂
       eccb015 LIKE eccb_t.eccb015, #Move in
       eccb016 LIKE eccb_t.eccb016, #Check in
       eccb017 LIKE eccb_t.eccb017, #报工站
       eccb018 LIKE eccb_t.eccb018, #PQC
       eccb019 LIKE eccb_t.eccb019, #Check out
       eccb020 LIKE eccb_t.eccb020, #Move out
       eccb021 LIKE eccb_t.eccb021, #转出单位
       eccb022 LIKE eccb_t.eccb022, #转出单位转换率分子
       eccb023 LIKE eccb_t.eccb023, #转出单位转换率分母
       eccb024 LIKE eccb_t.eccb024, #固定工时
       eccb025 LIKE eccb_t.eccb025, #标准工时
       eccb026 LIKE eccb_t.eccb026, #固定机时
       eccb027 LIKE eccb_t.eccb027, #标准机时
       eccb028 LIKE eccb_t.eccb028, #完成度
       eccb029 LIKE eccb_t.eccb029, #标准单价
       eccb030 LIKE eccb_t.eccb030, #转入单位
       eccb031 LIKE eccb_t.eccb031, #转入单位转换分子
       eccb032 LIKE eccb_t.eccb032, #转入单位转换分母
       eccb033 LIKE eccb_t.eccb033, #回收站
       eccb034 LIKE eccb_t.eccb034, #后置时间
       eccb035 LIKE eccb_t.eccb035, #X轴
       eccb036 LIKE eccb_t.eccb036, #Y轴
       eccb900 LIKE eccb_t.eccb900, #变更序
       eccb901 LIKE eccb_t.eccb901, #变更类型
       eccb902 LIKE eccb_t.eccb902, #变更日期
       eccb905 LIKE eccb_t.eccb905, #变更理由
       eccb906 LIKE eccb_t.eccb906 #变更备注
END RECORD
#161124-00048#2     2016/12/06 By 08734 add(E)
DEFINE l_ecce003                     LIKE ecce_t.ecce003
DEFINE l_ecceseq                     LIKE ecce_t.ecceseq
DEFINE l_ecce004                     LIKE ecce_t.ecce004
DEFINE l_ecce005                     LIKE ecce_t.ecce005
DEFINE l_ecceseq_max                 LIKE ecce_t.ecceseq
DEFINE l_n                           LIKE type_t.num5

   WHENEVER ERROR CONTINUE
   LET r_success = FALSE

   IF cl_null(p_eccbdocno) OR cl_null(p_eccb003) THEN                 
      RETURN r_success
   END IF
   
  # SELECT * INTO l_eccb.* FROM eccb_t WHERE eccbent = g_enterprise AND eccbsite = g_site  #161124-00048#2     2016/12/06 By 08734 mark
   SELECT eccbent,eccbsite,eccbdocno,eccb001,eccb002,eccb003,eccb004,eccb005,eccb006,eccb007,eccb008,eccb009,eccb010,eccb011,eccb012,eccb013,eccb014,eccb015,eccb016,eccb017,eccb018,eccb019,eccb020,eccb021,eccb022,eccb023,eccb024,eccb025,eccb026,eccb027,eccb028,eccb029,eccb030,eccb031,eccb032,eccb033,eccb034,eccb035,eccb036,eccb900,eccb901,eccb902,eccb905,eccb906 #161124-00048#2     2016/12/06 By 08734 add  
     INTO l_eccb.* FROM eccb_t WHERE eccbent = g_enterprise AND eccbsite = g_site
      AND eccbdocno = p_eccbdocno AND eccb003 = p_eccb003
   IF l_eccb.eccb010 = 'END' THEN
      LET r_success = TRUE
      RETURN r_success
   END IF      
   
   DECLARE aect801_return_ecbb_cs1 CURSOR FOR
    SELECT ecce004,ecce005 FROM ecce_t WHERE ecceent = g_enterprise AND eccesite = g_site
       AND eccedocno = p_eccbdocno AND ecce003 = l_eccb.eccb003 AND ecce901 != '4'
   
   DECLARE aect801_return_ecbb_cs2 CURSOR FOR
    SELECT ecce003,ecceseq FROM ecce_t WHERE ecceent = g_enterprise AND eccesite = g_site
       AND eccedocno = p_eccbdocno AND ecce004 = l_eccb.eccb004 AND ecce005 = l_eccb.eccb005
       AND ecce901 != '4'
   FOREACH aect801_return_ecbb_cs2 INTO l_ecce003,l_ecceseq
      IF NOT aect801_ecce_delete(p_eccbdocno,l_ecce003,l_ecceseq) THEN
         RETURN r_success
      END IF
      
      FOREACH aect801_return_ecbb_cs1 INTO l_ecce004,l_ecce005
         IF l_ecce004 = 'INIT' THEN
            SELECT COUNT(*) INTO l_n FROM ecce_t WHERE ecceent = g_enterprise AND eccesite = g_site
               AND eccedocno = p_eccbdocno AND ecce003 = l_ecce003 AND ecce901 != '4'
            IF l_n > 0 THEN
               EXIT FOREACH
            END IF
         END IF
         
         SELECT MAX(ecceseq) INTO l_ecceseq_max FROM ecce_t
          WHERE ecceent = g_enterprise AND eccesite = g_site AND eccedocno = p_eccbdocno
            AND ecce003 = l_ecce003
         IF cl_null(l_ecceseq_max) THEN
            LET l_ecceseq_max = 1
         ELSE
            LET l_ecceseq_max = l_ecceseq_max + 1
         END IF
         INSERT INTO ecce_t(ecceent,eccesite,eccedocno,ecce001,ecce002,ecce003,ecceseq,ecce004,ecce005,ecce900,ecce901,ecce902)
                VALUES(g_enterprise,g_site,p_eccbdocno,l_eccb.eccb001,l_eccb.eccb002,l_ecce003,l_ecceseq_max,l_ecce004,l_ecce005,l_eccb.eccb900,'3',l_eccb.eccb902)
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = SQLCA.sqlcode
            LET g_errparam.extend = "ins ecce_t"
            LET g_errparam.popup = TRUE
            CALL cl_err()
            RETURN r_success
         END IF
         IF NOT aect801_upd_ecce_ecch(p_eccbdocno,p_eccb003,l_ecceseq_max) THEN
            RETURN r_success
         END IF
      END FOREACH
      SELECT COUNT(*) INTO l_n FROM ecce_t WHERE ecceent = g_enterprise AND eccesite = g_site
         AND eccedocno = p_eccbdocno AND ecce003 = l_ecce003 AND ecce901 != '4'
      IF l_n > 1 THEN
         UPDATE eccb_t SET eccb008 = 'MULT',eccb009 = '0'
          WHERE eccbent = g_enterprise AND eccbsite = g_site
            AND eccbdocno = p_eccbdocno AND eccb003 = l_ecce003
            AND eccb901 != '4'
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = SQLCA.sqlcode
            LET g_errparam.extend = "upd eccb_t"
            LET g_errparam.popup = TRUE
            CALL cl_err()
            RETURN r_success
         END IF
      END IF
      IF l_n = 1 THEN
         UPDATE eccb_t 
            SET eccb008 = (SELECT ecce004 FROM ecce_t WHERE ecceent = g_enterprise AND eccesite = g_site AND eccedocno = p_eccbdocno AND ecce003 = l_ecce003 AND ecce901 != '4'),
                eccb009 = (SELECT ecce005 FROM ecce_t WHERE ecceent = g_enterprise AND eccesite = g_site AND eccedocno = p_eccbdocno AND ecce003 = l_ecce003 AND ecce901 != '4')
          WHERE eccbent = g_enterprise AND eccbsite = g_site
            AND eccbdocno = p_eccbdocno AND eccb003 = l_ecce003
            AND eccb901 != '4'
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = SQLCA.sqlcode
            LET g_errparam.extend = "upd eccb_t"
            LET g_errparam.popup = TRUE
            CALL cl_err()
            RETURN r_success
         END IF
      END IF
   END FOREACH
   
   LET r_success = TRUE
   RETURN r_success     
END FUNCTION

#变更理由码检查
PRIVATE FUNCTION aect801_ecca905_chk(p_ecca905)
DEFINE p_ecca905                 LIKE ecca_t.ecca905
DEFINE r_success                 LIKE type_t.num5
DEFINE l_success                 LIKE type_t.num5
DEFINE l_flag                    LIKE type_t.num5

   LET r_success = FALSE
   IF cl_null(p_ecca905) THEN
      RETURN r_success
   END IF
   
   CALL s_azzi650_chk_exist(g_acc,p_ecca905) RETURNING l_success
   IF NOT l_success THEN
      RETURN r_success
   END IF

   #檢核輸入的理由碼是否在單據別限制範圍內，若不在限制內則不允許使用此理由碼
   CALL s_control_chk_doc('8',g_ecca_m.eccadocno,p_ecca905,'','','','') RETURNING l_success,l_flag
   IF NOT l_success THEN
      RETURN r_success
   ELSE
      IF NOT l_flag THEN
         RETURN r_success
      END IF
   END IF
   
   LET r_success = TRUE
   RETURN r_success
END FUNCTION

#变更理由码ref显示
PRIVATE FUNCTION aect801_ecca905_desc(p_ecca905)
DEFINE p_ecca905         LIKE ecca_t.ecca905
DEFINE r_ecca905_desc    LIKE type_t.chr80
   IF cl_null(p_ecca905) THEN
      RETURN ''
   END IF
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = p_ecca905
   CALL ap_ref_array2(g_ref_fields,"SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001= '"||g_acc||"' AND oocql002=? AND oocql003='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET r_ecca905_desc = '', g_rtn_fields[1] , ''
   RETURN r_ecca905_desc
END FUNCTION

 
{</section>}
 
