#該程式已解開Section, 不再透過樣板產出!
{<section id="aecm200.description" >}
#+ Version..: T100-ERP-1.00.00(SD版次:4,PR版次:4) Build-000367
#+ 
#+ Filename...: aecm200
#+ Description: 料件製程資料維護作業
#+ Creator....: 02482(2013/09/23)
#+ Modifier...: 01258(2014/08/26) -SD/PR- TOPSTD
#+ Buildtype..: 應用 t01 樣板自動產生
#+ 以上段落由子樣板a00產生
 
{</section>}
 
{<section id="aecm200.global" >}
#151215-00002#4   2016/01/11  By shiun    增加工具群組及開啟子作業aecm200_05
#160113-00001#1   2016/01/14  By Sarah    在原有兩個作業中插入一個新的作業時，下站作業與作業序的更新會有錯
#160112-00011#2   2016/01/21  By ming     在「整單操作」中加入「上傳eSop」與「開啟eSop」 
#160201-00008#1   2016/02/15  By dorislai 將全部的開窗改為，在新增、修改狀態時，為單選
#160224-00022#1   2016/03/23  By xianghui 1.流程图页签右方table栏位名称与值对应
#                                         2.调整上站时，其上站资料的下站资料需要更新
#160112-00011#4   2016/03/25  By dorislai mark 開啟eSop(open_esop)、上傳eSop(upload_esop)的action
#160330-00023#1   2016/04/05  By xianghui 增加E-MFG-0002参数控制
#160318-00025#3   2016/04/11  By 07675    將重複內容的錯誤訊息置換為公用錯誤訊息(r.v）
#160411-00047#1   2016/04/11  By Sarah    執行複製時,製程流程圖的線會不見
#160411-00012#1   2016/04/20  By xianghui 将状态码的作废放在确认下面
#160513-00029#1   2016/05/17  By Ann_Huang 修正若一開始直接點選查詢按鈕,會無法出現[製程流程圖]中流程圖與工具箱
#160707-00040#1   2016/07/07  By xianghui 營運據點切換后，單頭資料抓取的CURSOR沒有根據新據點抓資料
#160801-00023#1   2016/08/02  By 02097    1.工具群組隱藏/2.action資源項目隱藏
#160616-00009#1   2016/08/09  By 00768    修正误进去元件单身里面后出不来的问题
#160808-00011#1   2016/08/10  By xianghui 审核时判断单身工作站不可为空
#160825-00026#1   2016/08/25  By xianghui 工艺料件在aect801维护变更后，在aecm200中依旧控管不可取消审核和删除
#161021-00046#1   2016/10/21  By 00768    修正问题：手工维护工单，保存后无法点击编辑以及审核。（同asft300中160825-00032单号修改）
#161108-00012#1   2016/11/08  By 08734    g_browser_cnt 由num5改為num10
#161108-00023#1   2016/11/17  By 02295    当修改当前站的本站作业和作业序时，需要更新其他站中上站作业为原本站作业和作业序的值为新值
#161123-00002#1   2016/11/24  By zhujing  提交修改后，画面不随意跳动。
#161124-00037#1   2016/12/01  By fionchen 調整因開帳匯入製程後的流程圖中,INIT與END座標問題 
#161124-00048#1   2016/12/06  By 08734    星号整批调整
#170105-00055#1   2017/01/06  By catmoon47 當應用分類碼說明為null時，給值為-
#170418-00063#1   2017/04/24  By Whitney  修正調整項次後圖形錯亂
        
IMPORT os
IMPORT util
IMPORT FGL lib_cl_dlg
#add-point:增加匯入項目

#end add-point
 
SCHEMA ds 
 
GLOBALS "../../cfg/top_global.inc"
 
#add-point:增加匯入變數檔
DEFINE   l_wcpath  STRING   # WebComponent路?          {#ADP版次:1#}
DEFINE   wc        STRING
DEFINE   js_cmd    STRING
DEFINE   g_wc_init BOOLEAN
#end add-point
 
#單頭 type 宣告
PRIVATE type type_g_ecba_m        RECORD
       ecba001 LIKE ecba_t.ecba001, 
   ecba001_desc LIKE type_t.chr80, 
   ecba001_desc1 LIKE type_t.chr80, 
   ecba002 LIKE ecba_t.ecba002, 
   ecba003 LIKE ecba_t.ecba003, 
   ecba004 LIKE ecba_t.ecba004, 
   ecba005 LIKE ecba_t.ecba005, 
   ecba006 LIKE ecba_t.ecba006, 
   ecba007 LIKE ecba_t.ecba007, 
   ecbastus LIKE ecba_t.ecbastus, 
   ooeb013 LIKE type_t.chr80, 
   ecbacrtid LIKE ecba_t.ecbacrtid, 
   ecbacrtid_desc LIKE type_t.chr80, 
   ecbacrtdp LIKE ecba_t.ecbacrtdp, 
   ecbacrtdp_desc LIKE type_t.chr80, 
   ecbacrtdt DATETIME YEAR TO SECOND, 
   ecbaownid LIKE ecba_t.ecbaownid, 
   ecbaownid_desc LIKE type_t.chr80, 
   ecbaowndp LIKE ecba_t.ecbaowndp, 
   ecbaowndp_desc LIKE type_t.chr80, 
   ecbamodid LIKE ecba_t.ecbamodid, 
   ecbamodid_desc LIKE type_t.chr80, 
   ecbamoddt DATETIME YEAR TO SECOND, 
   ecbacnfid LIKE ecba_t.ecbacnfid, 
   ecbacnfid_desc LIKE type_t.chr80, 
   ecbacnfdt DATETIME YEAR TO SECOND
       END RECORD
 
#單身 type 宣告
PRIVATE TYPE type_g_ecbb_d        RECORD
       ecbb003 LIKE ecbb_t.ecbb003, 
   ecbb004 LIKE ecbb_t.ecbb004, 
   ecbb004_desc LIKE type_t.chr500, 
   ecbb005 LIKE ecbb_t.ecbb005, 
   ecbb006 LIKE ecbb_t.ecbb006, 
   ecbb007 LIKE ecbb_t.ecbb007, 
   ecbb008 LIKE ecbb_t.ecbb008, 
   ecbb008_desc LIKE type_t.chr500, 
   ecbb009 LIKE ecbb_t.ecbb009, 
   ecbb010 LIKE ecbb_t.ecbb010, 
   ecbb010_desc LIKE type_t.chr500, 
   ecbb011 LIKE ecbb_t.ecbb011, 
   ecbb012 LIKE ecbb_t.ecbb012, 
   ecbb012_desc LIKE type_t.chr500, 
   ecbb037 LIKE ecbb_t.ecbb037,         #141006-00003#1  
   ecbb037_desc LIKE type_t.chr500,     #141006-00003#1  
   ecbb038 LIKE ecbb_t.ecbb038,         #add--151215-00002#4 By shiun  
   ecbb038_desc LIKE type_t.chr500,     #add--151215-00002#4 By shiun  
   ecbb024 LIKE ecbb_t.ecbb024, 
   ecbb025 LIKE ecbb_t.ecbb025, 
   ecbb026 LIKE ecbb_t.ecbb026, 
   ecbb027 LIKE ecbb_t.ecbb027, 
   ecbb034 LIKE ecbb_t.ecbb034, 
   ecbb013 LIKE ecbb_t.ecbb013, 
   ecbb014 LIKE ecbb_t.ecbb014, 
   ecbb014_desc LIKE type_t.chr500, 
   ecbb015 LIKE ecbb_t.ecbb015, 
   ecbb016 LIKE ecbb_t.ecbb016, 
   ecbb017 LIKE ecbb_t.ecbb017, 
   ecbb018 LIKE ecbb_t.ecbb018, 
   ecbb019 LIKE ecbb_t.ecbb019, 
   ecbb020 LIKE ecbb_t.ecbb020, 
   ecbb030 LIKE ecbb_t.ecbb030, 
   ecbb031 LIKE ecbb_t.ecbb031, 
   ecbb032 LIKE ecbb_t.ecbb032, 
   ecbb021 LIKE ecbb_t.ecbb021, 
   ecbb022 LIKE ecbb_t.ecbb022, 
   ecbb023 LIKE ecbb_t.ecbb023, 
   ecbb033 LIKE ecbb_t.ecbb033, 
   ecbb028 LIKE ecbb_t.ecbb028, 
   ecbb029 LIKE ecbb_t.ecbb029, 
   ecbb035 LIKE ecbb_t.ecbb035, 
   ecbb036 LIKE ecbb_t.ecbb036, 
   ooff013 LIKE type_t.chr80
       END RECORD
 
 
#模組變數(Module Variables)
DEFINE g_ecba_m          type_g_ecba_m
DEFINE g_ecba_m_t        type_g_ecba_m
DEFINE g_ecba_m_o        type_g_ecba_m
 
   DEFINE g_ecba001_t LIKE ecba_t.ecba001
DEFINE g_ecba002_t LIKE ecba_t.ecba002
 
 
DEFINE g_ecbb_d          DYNAMIC ARRAY OF type_g_ecbb_d
DEFINE g_ecbb_d_t        type_g_ecbb_d
DEFINE g_ecbb_d_o        type_g_ecbb_d
 
 
DEFINE g_browser    DYNAMIC ARRAY OF RECORD    #資料瀏覽之欄位 
         b_statepic     LIKE type_t.chr50,
            b_ecba001 LIKE ecba_t.ecba001,
   b_ecba001_desc LIKE type_t.chr80,
   b_ecba001_desc1 LIKE type_t.chr80,
      b_ecba002 LIKE ecba_t.ecba002,
      b_ecba003 LIKE ecba_t.ecba003
      END RECORD 
      
DEFINE g_browser_f  RECORD    #資料瀏覽之欄位 
       b_statepic     LIKE type_t.chr50,
          b_ecba001 LIKE ecba_t.ecba001,
   b_ecba001_desc LIKE type_t.chr80,
   b_ecba001_desc1 LIKE type_t.chr80,
      b_ecba002 LIKE ecba_t.ecba002,
      b_ecba003 LIKE ecba_t.ecba003
      END RECORD 
      
 
DEFINE g_wc                  STRING
DEFINE g_wc_t                STRING
DEFINE g_wc2                 STRING                          #單身CONSTRUCT結果
DEFINE g_wc2_table1          STRING
 
 
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
#DEFINE g_browser_cnt         LIKE type_t.num5              #Browser總筆數    #161108-00012#1  2016/11/08 By 08734 mark
DEFINE g_browser_cnt         LIKE type_t.num10              #Browser總筆數    #161108-00012#1  2016/11/08 By 08734 add
DEFINE g_browser_idx         LIKE type_t.num10              #Browser目前所在筆數  #161108-00012#1 num5==》num10
DEFINE g_temp_idx            LIKE type_t.num10              #Browser目前所在筆數(暫存用)  #161108-00012#1 num5==》num10
 
DEFINE g_searchcol           STRING                        #查詢欄位代碼
DEFINE g_searchstr           STRING                        #查詢欄位字串
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
 
#add-point:自定義模組變數(Module Variable)
DEFINE g_smfg0036          LIKE type_t.chr1     #160801-00023#1
#DEFINE g_browser_cnt       LIKE type_t.num10              #Browser總筆數  #161108-00012#1  2016/11/08 By 08734 add
#單身2 type 宣告
 TYPE type_g_ecbb2_d        RECORD
       ecbc004 LIKE ecbc_t.ecbc004, 
       ecbc005 LIKE ecbc_t.ecbc005,
       ecbc005_desc  LIKE type_t.chr80,
       ecbc005_desc1 LIKE type_t.chr80,   
       ecbc006 LIKE ecbc_t.ecbc006, 
       ecbc006_desc LIKE type_t.chr80, 
       ecbc007 LIKE ecbc_t.ecbc007, 
       ecbc008 LIKE ecbc_t.ecbc008, 
       ecbc009 LIKE ecbc_t.ecbc009, 
       ecbc010 LIKE ecbc_t.ecbc010
       END RECORD
#單身3 type 宣告
 TYPE type_g_ecbb3_d        RECORD
       ecbd005 LIKE ecbd_t.ecbd005,
       ecbd006 LIKE ecbd_t.ecbd006,
       ecbd007 LIKE ecbd_t.ecbd007, 
       ecbd008 LIKE ecbd_t.ecbd008
       END RECORD
       
DEFINE g_ecbb2_d          DYNAMIC ARRAY OF type_g_ecbb2_d
DEFINE g_ecbb2_d_t        type_g_ecbb2_d
DEFINE g_ecbb3_d          DYNAMIC ARRAY OF type_g_ecbb3_d
DEFINE g_ecbb3_d_t        type_g_ecbb3_d
DEFINE g_rec_b1           LIKE type_t.num10  #161108-00012#1 num5==》num10         
DEFINE l_ac1              LIKE type_t.num10   #161108-00012#1 num5==》num10
DEFINE g_rec_b2           LIKE type_t.num10   #161108-00012#1 num5==》num10          
DEFINE l_ac2              LIKE type_t.num10   #161108-00012#1 num5==》num10
DEFINE g_wc3              STRING  
DEFINE g_wc3_table1       STRING
DEFINE g_wc4              STRING
DEFINE g_wc4_table1       STRING
DEFINE l_success          LIKE type_t.num5
#add by wuxj 
DEFINE g_ecbb4_d          DYNAMIC ARRAY OF RECORD
       l_text             LIKE type_t.chr80,
       l_value            LIKE type_t.chr80
                          END RECORD
DEFINE g_ecbb4_d_t        DYNAMIC ARRAY OF RECORD
       l_text             LIKE type_t.chr80,
       l_value            LIKE type_t.chr80
                          END RECORD
DEFINE l_ac3              LIKE type_t.num10  #161108-00012#1 num5==》num10

DEFINE g_ecba001  LIKE ecba_t.ecba001,
       g_ecba002  LIKE ecba_t.ecba002
TYPE t_container RECORD
               id          STRING,   #節點代號
               group       STRING,   #群組代號
               module      STRING,   #節點類型(station,group)
               image       STRING,   #節點圖片
               label       STRING,   #顯示文字
               desc        STRING,
               position       RECORD      #坐標
                  top            STRING,     #X
                  left           STRING      #Y
                              END RECORD,
               size           RECORD      #尺寸
                  width          STRING,     #寬
                  height         STRING      #高
                              END RECORD,
               sources        DYNAMIC ARRAY OF STRING,
               targets        DYNAMIC ARRAY OF STRING,
               params         RECORD       #自定的參數，在WebComponent中會無條件回傳
                  ecbb003        LIKE ecbb_t.ecbb003
                              END RECORD
                        END RECORD
TYPE t_connection RECORD
         source      STRING,        #來源節點代號
         target      STRING,        #目的節點代號
         parameters     RECORD      #其它設定
            label          STRING      #連結線上的標籤
                        END RECORD
                  END RECORD
TYPE t_group      RECORD
         id          STRING,     #群組編號
         label       STRING,     #顯示文字
         params      RECORD
            groupType   INTEGER
                     END RECORD,
         containers  DYNAMIC ARRAY OF STRING  #群組中的節點代號
                  END RECORD
                  
#160112-00011#2 20160121 add by ming -----(S) 
DEFINE g_target_dir     STRING
DEFINE g_num            LIKE type_t.num10  #161108-00012#1 num5==》num10
#160112-00011#2 20160121 add by ming -----(E) 
DEFINE g_aecm200_05_chk LIKE type_t.num5   #add--151215-00002#4 By shiun
DEFINE g_field          STRING             #161123-00002 add
#end add-point
 
#add-point:傳入參數說明(global.argv)
 
#end add-point
 
{</section>}
 
{<section id="aecm200.main" >}
#+ 此段落由子樣板a26產生
#OPTIONS SHORT CIRCUIT
#+ 作業開始 
MAIN
   #add-point:main段define
   DEFINE l_sql      STRING
   #end add-point   
 
   OPTIONS
   INPUT NO WRAP
   DEFER INTERRUPT
   
   #設定SQL錯誤記錄方式 (模組內定義有效)
   WHENEVER ERROR CALL cl_err_msg_log
       
   #依模組進行系統初始化設定(系統設定)
   #CALL cl_ap_init("aec","")
   CALL cl_ap_init("cec","")#modify by yangxb 170503
 
   #add-point:作業初始化

   #end add-point
   
   
 
   #LOCK CURSOR (identifier)
   #add-point:SQL_define

   #end add-point
   LET g_forupd_sql = " SELECT ecba001,'','',ecba002,ecba003,ecba004,ecba005,ecba006,ecba007,ecbastus, 
       '',ecbacrtid,'',ecbacrtdp,'',ecbacrtdt,ecbaownid,'',ecbaowndp,'',ecbamodid,'',ecbamoddt,ecbacnfid, 
       '',ecbacnfdt", 
                      " FROM ecba_t",
                      " WHERE ecbaent= ? AND ecbasite= ? AND ecba001=? AND ecba002=? FOR UPDATE"
   #add-point:SQL_define

   #end add-point
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)                #轉換不同資料庫語法
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE aecm200_cl CURSOR FROM g_forupd_sql                 # LOCK CURSOR
 
   LET g_sql = " SELECT UNIQUE t0.ecba001,t0.ecba002,t0.ecba003,t0.ecba004,t0.ecba005,t0.ecba006,t0.ecba007, 
       t0.ecbastus,t0.ecbacrtid,t0.ecbacrtdp,t0.ecbacrtdt,t0.ecbaownid,t0.ecbaowndp,t0.ecbamodid,t0.ecbamoddt, 
       t0.ecbacnfid,t0.ecbacnfdt,t1.ooag011 ,t2.ooefl003 ,t3.ooag011 ,t4.ooefl003 ,t5.ooag011 ,t6.ooag011", 
 
               " FROM ecba_t t0",
                              " LEFT JOIN ooag_t t1 ON t1.ooagent='"||g_enterprise||"' AND t1.ooag001=t0.ecbacrtid  ",
               " LEFT JOIN ooefl_t t2 ON t2.ooeflent='"||g_enterprise||"' AND t2.ooefl001=t0.ecbacrtdp AND t2.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t3 ON t3.ooagent='"||g_enterprise||"' AND t3.ooag001=t0.ecbaownid  ",
               " LEFT JOIN ooefl_t t4 ON t4.ooeflent='"||g_enterprise||"' AND t4.ooefl001=t0.ecbaowndp AND t4.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t5 ON t5.ooagent='"||g_enterprise||"' AND t5.ooag001=t0.ecbamodid  ",
               " LEFT JOIN ooag_t t6 ON t6.ooagent='"||g_enterprise||"' AND t6.ooag001=t0.ecbacnfid  ",
 
               #" WHERE t0.ecbaent = '" ||g_enterprise|| "' AND t0.ecbasite = '" ||g_site|| "' AND t0.ecba001 = ? AND t0.ecba002 = ?"  #160707-00040#1 mark
               " WHERE t0.ecbaent = '" ||g_enterprise|| "' AND t0.ecbasite = ? AND t0.ecba001 = ? AND t0.ecba002 = ?"  #160707-00040#1
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   #add-point:SQL_define
       
   LET l_sql = "SELECT ecbeent, ecbesite, ecbe001, ecbe002, ecbe003, ecbeseq, ecbe004, ecbe005 FROM ecbe_t ",
               "WHERE ecbeent = ? AND ecbesite = ? AND ecbe001 = ? AND ecbe002 = ? AND ecbe003 = ?"
   DECLARE aecm200_ecbe_declare CURSOR FROM l_sql
   
   
   #end add-point
   PREPARE aecm200_master_referesh FROM g_sql
 
 
 
   
   IF g_bgjob = "Y" THEN
      #add-point:Service Call

      #end add-point
   ELSE
      LET l_wcpath = FGL_GETENV("FGLASIP"),"/components"                           #wuxja
      CALL ui.interface.frontCall("standard", "setwebcomponentpath",[l_wcpath],[]) #wuxja
      #畫面開啟 (identifier)
     # OPEN WINDOW w_aecm200 WITH FORM cl_ap_formpath("aec",g_code)
       OPEN WINDOW w_aecm200 WITH FORM cl_ap_formpath("cec",g_code)#modify by yangxb 170503
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
   
      #程式初始化
      CALL aecm200_init()   
 
      #進入選單 Menu (="N")
      CALL aecm200_ui_dialog() 
      
      #add-point:畫面關閉前

      #end add-point
 
      #畫面關閉
      CLOSE WINDOW w_aecm200
      
   END IF 
   
   CLOSE aecm200_cl
   
   
 
   #add-point:作業離開前

   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
   
END MAIN
 
 
 
{</section>}
 
{<section id="aecm200.init" >}
#+ 瀏覽頁簽資料初始化
PRIVATE FUNCTION aecm200_init()
   #add-point:init段define
   DEFINE l_mfg_0002   LIKE type_t.chr1   #160330-00023#1
   #end add-point    
   
   LET g_bfill       = "Y"
   LET g_detail_idx  = 1
   LET g_detail_idx2 = 1
   LET g_error_show  = 1
   LET l_ac = 1
      CALL cl_set_combo_scc_part('ecbastus','50','N,X,Y')
 
      CALL cl_set_combo_scc('ecbb006','1202') 
 
   LET gwin_curr = ui.Window.getCurrent()  #取得現行畫面
   LET gfrm_curr = gwin_curr.getForm()     #取出物件化後的畫面物件
 
   #add-point:畫面資料初始化
   CALL cl_set_combo_scc('ecbc010','1108') 
 #  CALL cl_set_act_visible("resource",FALSE)    #141006-00003#1  
 
  #160112-00011#2 20160121 add by ming -----(S) 
  LET g_target_dir = FGL_GETENV('TEMPDIR')
  #160112-00011#2 20160121 add by ming -----(E) 
  
   #160330-00023#1---add---begin
   CALL cl_get_para(g_enterprise,g_site,'E-MFG-0002') RETURNING l_mfg_0002
   CALL cl_set_comp_visible('group_3',FALSE)
   CALL cl_set_act_visible("bom",FALSE)
   IF l_mfg_0002 = 'Y' THEN 
      CALL cl_set_comp_visible('group_3',TRUE)
      CALL cl_set_act_visible("bom",TRUE)
   END IF
   #160330-00023#1---add---end
   #160801-00023#4--(S)
   CALL cl_get_para(g_enterprise,g_site,'S-MFG-0036') RETURNING g_smfg0036 #160801-00023#1
   IF g_smfg0036 <> '2' THEN
      CALL cl_set_toolbaritem_visible("resource", FALSE)
      CALL cl_set_comp_visible('ecbb038,ecbb038_desc',FALSE)    #隱藏      
   ELSE
      CALL cl_set_toolbaritem_visible("resource", TRUE)
      CALL cl_set_comp_visible('ecbb038,ecbb038_desc',TRUE)    #隱藏      
   END IF
   #160801-00023#4--(E)
   #end add-point
   
   CALL aecm200_default_search()
    
END FUNCTION
 
{</section>}
 
{<section id="aecm200.ui_dialog" >}
#+ 功能選單
PRIVATE FUNCTION aecm200_ui_dialog()
   DEFINE li_idx    LIKE type_t.num10  #161108-00012#1 num5==》num10
   DEFINE ls_wc     STRING
   DEFINE lb_first  BOOLEAN
   DEFINE la_param  RECORD
             prog   STRING,
             param  DYNAMIC ARRAY OF STRING
                    END RECORD
   DEFINE ls_js     STRING
   #add-point:ui_dialog段define
   DEFINE l_ecbb004     LIKE ecbb_t.ecbb004,
          l_ecbb005     LIKE ecbb_t.ecbb005
   #end add-point
   
   CALL cl_set_act_visible("accept,cancel", FALSE)
 
   #因應查詢方案進行處理
   CALL gfrm_curr.setElementImage("logo","logo/applogo.png") 
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
            CALL aecm200_insert()
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
      CALL aecm200_browser_fill("")
      CALL lib_cl_dlg.cl_dlg_before_display()
      CALL cl_notice()
            
      #判斷前一個動作是否為新增, 若是的話切換到新增的筆數
      IF g_state = "Y" THEN
         FOR li_idx = 1 TO g_browser.getLength()
            IF g_browser[li_idx].b_ecba001 = g_ecba001_t
               AND g_browser[li_idx].b_ecba002 = g_ecba002_t
 
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
               
               CALL aecm200_fetch('') # reload data
               LET l_ac = 1
               CALL aecm200_ui_detailshow() #Setting the current row 
      
               CALL aecm200_idx_chk()
               #NEXT FIELD ecbb003
         
         END DISPLAY
        
         DISPLAY ARRAY g_ecbb_d TO s_detail1.* ATTRIBUTES(COUNT=g_rec_b) #page1  
    
            BEFORE ROW
               #顯示單身筆數
               CALL aecm200_idx_chk()
               #確定當下選擇的筆數
               LET l_ac = DIALOG.getCurrentRow("s_detail1")
               LET g_detail_idx = l_ac
               
               #add-point:page1, before row動作
               #add by wuxja 
               CALL aecm200_b_fill_1()
               DISPLAY ARRAY g_ecbb2_d TO s_detail2.* ATTRIBUTES(COUNT=g_rec_b1)
                  BEFORE DISPLAY
                    EXIT DISPLAY
               END DISPLAY
               
               LET l_ac1 = 1
               CALL aecm200_b_fill_2()
               DISPLAY ARRAY g_ecbb3_d TO s_detail3.* ATTRIBUTES(COUNT=g_rec_b2)
                  BEFORE DISPLAY
                    EXIT DISPLAY
               END DISPLAY
    
    
               CALL aecm200_b_fill_value(g_ecbb_d[l_ac].ecbb004, g_ecbb_d[l_ac].ecbb005)
               DISPLAY ARRAY g_ecbb4_d TO s_detail4.* ATTRIBUTES(COUNT=32)
                  BEFORE DISPLAY
                    EXIT DISPLAY
               END DISPLAY
               #end
               
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
               CALL aecm200_idx_chk()
               #add-point:page1自定義行為

               #end add-point
               
            #自訂ACTION(detail_show,page_1)
            
               
            #add-point:page1自定義行為

            #end add-point
               
         END DISPLAY
        
 
         
 
         
         #add-point:ui_dialog段自定義display array
         
         
         
         DISPLAY ARRAY g_ecbb2_d TO s_detail2.* ATTRIBUTES(COUNT=g_rec_b1) #page2  
    
            BEFORE ROW
               CALL aecm200_idx_chk()
               LET l_ac1 = DIALOG.getCurrentRow("s_detail2")
               LET g_detail_idx = l_ac1
               CALL aecm200_b_fill_2()
               DISPLAY ARRAY g_ecbb3_d TO s_detail3.* ATTRIBUTES(COUNT=g_rec_b2)
                  BEFORE DISPLAY
                    EXIT DISPLAY
               END DISPLAY
               
            BEFORE DISPLAY
               CALL FGL_SET_ARR_CURR(g_detail_idx)
               LET l_ac1 = DIALOG.getCurrentRow("s_detail2")
               CALL aecm200_idx_chk()
               LET g_current_page = 2
               
               
         END DISPLAY
         DISPLAY ARRAY g_ecbb3_d TO s_detail3.* ATTRIBUTES(COUNT=g_rec_b2) #page2  
    
            BEFORE ROW
               CALL aecm200_idx_chk()
               LET l_ac2 = DIALOG.getCurrentRow("s_detail3")
               LET g_detail_idx = l_ac2

            BEFORE DISPLAY
               CALL FGL_SET_ARR_CURR(g_detail_idx)
               LET l_ac2 = DIALOG.getCurrentRow("s_detail3")
               CALL aecm200_idx_chk()
               LET g_current_page = 3
               
               
         END DISPLAY
         
         DISPLAY ARRAY g_ecbb4_d TO s_detail4.* ATTRIBUTES(COUNT=32)   
    
            BEFORE ROW
               CALL aecm200_idx_chk()
               LET l_ac3 = DIALOG.getCurrentRow("s_detail4")
               LET g_detail_idx = l_ac2

            BEFORE DISPLAY
               CALL FGL_SET_ARR_CURR(g_detail_idx)
               LET l_ac3 = DIALOG.getCurrentRow("s_detail4")
               CALL aecm200_idx_chk()
                           
         END DISPLAY
         
         #wuxja
         INPUT BY NAME wc ATTRIBUTE(WITHOUT DEFAULTS=TRUE)
            BEFORE INPUT
               #CALL aecm200_06(g_ecbb_d,g_ecba_m.*)
               CALL aecm200_wc_init(FALSE)

               
            ON ACTION shapeclicked
                CALL aecm200_b_fill_value(g_ecbb_d[g_detail_idx].ecbb004,g_ecbb_d[g_detail_idx].ecbb005)
            ON ACTION wc_select_node
               CALL aecm200_wc_parse_id(wc) RETURNING l_ecbb004, l_ecbb005
               LET l_ac = aecm200_arr_curr(l_ecbb004, l_ecbb005)
               IF l_ac > 0 THEN
                  LET g_detail_idx = l_ac
                  CALL DIALOG.setCurrentRow("s_detail1", l_ac)
                  CALL aecm200_b_fill_value(g_ecbb_d[l_ac].ecbb004, g_ecbb_d[l_ac].ecbb005)
               ELSE
                  CALL g_ecbb4_d.clear()
               END IF
                
         END INPUT
         
         
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
               CALL aecm200_fetch('') # reload data
            END IF
            #LET g_detail_idx = 1
            CALL aecm200_ui_detailshow() #Setting the current row 
            
            #筆數顯示
            LET g_current_page = 1
            CALL aecm200_idx_chk()
            
            #add-point:ui_dialog段before_dialog2
            #161123-00002#1 add-S
            CALL gfrm_curr.ensureFieldVisible(g_field)
            #161123-00002#1 add-E
         ON ACTION wc_flow_init
            CALL aecm200_wc_init(FALSE)           
            
            #end add-point
        
         #狀態碼切換
         ON ACTION statechange
            LET g_action_choice = "statechange"
            CALL aecm200_statechange()
            EXIT DIALOG
      
         
          
         #查詢方案選擇 
         ON ACTION queryplansel
            CALL cl_dlg_qryplan_select() RETURNING ls_wc
            #不是空條件才寫入g_wc跟重新找資料
            IF NOT cl_null(ls_wc) THEN
               LET g_wc = ls_wc
               CALL aecm200_browser_fill("F")   #browser_fill()會將notice區塊清空
               CALL cl_notice()   #重新顯示,此處不可用EXIT DIALOG, SUBDIALOG重讀會導致部分變數消失
            END IF
         
         #查詢方案選擇
         ON ACTION qbe_select
            CALL cl_qbe_list("m") RETURNING ls_wc
            IF NOT cl_null(ls_wc) THEN
               LET g_wc = ls_wc
               #取得條件後需要重查、跳到結果第一筆資料的功能程式段
               CALL aecm200_browser_fill("F")
               IF g_browser_cnt = 0 THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "" 
                  LET g_errparam.code   = "-100" 
                  LET g_errparam.popup  = TRUE 
                  CALL cl_err()
 
                  CLEAR FORM
               ELSE
                  CALL aecm200_fetch("F")
               END IF
            END IF
            #重新搜尋會將notice區塊清空,此處不可用EXIT DIALOG, SUBDIALOG重讀會導致部分變數消失
            CALL cl_notice()
          
         #+ 此段落由子樣板a49產生
            #過濾瀏覽頁資料
            ON ACTION filter
               #add-point:filter action

               #end add-point
               CALL aecm200_filter()
               EXIT DIALOG
 
 
 
         
         ON ACTION first
            CALL aecm200_fetch('F')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL aecm200_idx_chk()
            
         ON ACTION previous
            CALL aecm200_fetch('P')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL aecm200_idx_chk()
            
         ON ACTION jump
            CALL aecm200_fetch('/')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL aecm200_idx_chk()
            
         ON ACTION next
            CALL aecm200_fetch('N')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL aecm200_idx_chk()
            
         ON ACTION last
            CALL aecm200_fetch('L')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL aecm200_idx_chk()
            
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
               NEXT FIELD wc   #wuxja
            ELSE
               CALL gfrm_curr.setElementHidden("mainlayout",1)
               CALL gfrm_curr.setElementHidden("worksheet",0)
               LET g_main_hidden = 1
            END IF
            IF lb_first THEN
               LET lb_first = FALSE
               NEXT FIELD ecbb003
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
                IF l_ac > 0 THEN
                   IF NOT cl_null(g_ecba_m.ecba001) AND  NOT cl_null(g_ecba_m.ecba002) AND NOT cl_null(g_ecbb_d[l_ac].ecbb003) AND NOT cl_null(g_ecbb_d[l_ac].ecbb004)  AND NOT cl_null(g_ecbb_d[l_ac].ecbb005) THEN
                      IF g_ecba_m.ecbastus = 'N' THEN
                         CALL aecm200_02(g_ecba_m.ecba001,g_ecba_m.ecba002,g_ecbb_d[l_ac].ecbb003,g_ecbb_d[l_ac].ecbb004,g_ecbb_d[l_ac].ecbb005,'2','Y','N')
                      ELSE             
                         CALL aecm200_02(g_ecba_m.ecba001,g_ecba_m.ecba002,g_ecbb_d[l_ac].ecbb003,g_ecbb_d[l_ac].ecbb004,g_ecbb_d[l_ac].ecbb005,'2','N','N')
                      END IF
                   END IF
                END IF
                LET g_action_choice=""
               #END add-point
               EXIT DIALOG
            END IF
 
 
         #+ 此段落由子樣板a43產生
         ON ACTION modify
            LET g_action_choice="modify"
            IF cl_auth_chk_act("modify") THEN
               LET g_aw = ''
               CALL aecm200_modify()
               #add-point:ON ACTION modify
               #161123-00002#1 add-S
               CALL gfrm_curr.ensureFieldVisible(g_field)
               #161123-00002#1 add-E
               #END add-point
               EXIT DIALOG
            END IF
 
 
         #+ 此段落由子樣板a43產生
         ON ACTION modify_detail
            LET g_action_choice="modify_detail"
            IF cl_auth_chk_act("modify") THEN
               LET g_aw = g_curr_diag.getCurrentItem()
               CALL aecm200_modify()
               #add-point:ON ACTION modify_detail
               #161123-00002#1 add-S
               CALL gfrm_curr.ensureFieldVisible(g_field)
               #161123-00002#1 add-E
               #END add-point
               EXIT DIALOG
            END IF
 
 
         #+ 此段落由子樣板a43產生
         ON ACTION delete
            LET g_action_choice="delete"
            IF cl_auth_chk_act("delete") THEN
               CALL aecm200_delete()
               #add-point:ON ACTION delete

               #END add-point
               
            END IF
 
 
         #+ 此段落由子樣板a43產生
         ON ACTION insert
            LET g_action_choice="insert"
            IF cl_auth_chk_act("insert") THEN
               CALL aecm200_insert()
               #add-point:ON ACTION insert
               #161123-00002#1 add-S
               CALL gfrm_curr.ensureFieldVisible(g_field)
               #161123-00002#1 add-E
               #END add-point
               
            END IF
 
 
         #+ 此段落由子樣板a43產生
         ON ACTION output
            LET g_action_choice="output"
            IF cl_auth_chk_act("output") THEN
               
               #add-point:ON ACTION output

               #END add-point
               EXIT DIALOG
            END IF
 
 
         #+ 此段落由子樣板a43產生
         ON ACTION reproduce
            LET g_action_choice="reproduce"
            IF cl_auth_chk_act("reproduce") THEN
               CALL aecm200_reproduce()
               #add-point:ON ACTION reproduce
               CALL aecm200_wc_submit("wc", "station_enable", "false")  #160411-00047#1 add
               #END add-point
               
            END IF
 
 
         #+ 此段落由子樣板a43產生
         ON ACTION query
            LET g_action_choice="query"
            IF cl_auth_chk_act("query") THEN
               CALL aecm200_query()
               #add-point:ON ACTION query

               #END add-point
               
            END IF
 
 
         #+ 此段落由子樣板a43產生  
        ON ACTION resource
           LET g_action_choice="resource"
           IF cl_auth_chk_act("resource") THEN
              
              #add-point:ON ACTION resource
       #        IF l_ac > 0 THEN
       #           IF NOT cl_null(g_ecba_m.ecba001) AND  NOT cl_null(g_ecba_m.ecba002) AND NOT cl_null(g_ecbb_d[l_ac].ecbb003) AND NOT cl_null(g_ecbb_d[l_ac].ecbb004)  AND NOT cl_null(g_ecbb_d[l_ac].ecbb005) THEN
       #              IF g_ecba_m.ecbastus = 'N' THEN
       #                 CALL aecm200_03(g_ecba_m.ecba001,g_ecba_m.ecba002,g_ecbb_d[l_ac].ecbb003,g_ecbb_d[l_ac].ecbb004,g_ecbb_d[l_ac].ecbb005,'Y','N')
       #              ELSE             
       #                 CALL aecm200_03(g_ecba_m.ecba001,g_ecba_m.ecba002,g_ecbb_d[l_ac].ecbb003,g_ecbb_d[l_ac].ecbb004,g_ecbb_d[l_ac].ecbb005,'N','N')
       #              END IF
       #           END IF
       #        END IF
       #        LET g_action_choice=""
              IF l_ac > 0 THEN
                 IF NOT cl_null(g_ecba_m.ecba001) AND  NOT cl_null(g_ecba_m.ecba002) AND NOT cl_null(g_ecbb_d[l_ac].ecbb003) AND (NOT cl_null(g_ecbb_d[l_ac].ecbb037) OR NOT cl_null(g_ecbb_d[l_ac].ecbb038)) THEN
                    CALL aecm200_05(g_ecba_m.ecba001,g_ecba_m.ecba002,g_ecbb_d[l_ac].ecbb003)
                 END IF
                 LET g_action_choice=""
              END IF
              #END add-point
              EXIT DIALOG
           END IF
 
 
         #+ 此段落由子樣板a43產生
         ON ACTION stand
            LET g_action_choice="stand"
            IF cl_auth_chk_act("stand") THEN
               
               #add-point:ON ACTION stand
                IF l_ac > 0 THEN
                   IF NOT cl_null(g_ecba_m.ecba001) AND  NOT cl_null(g_ecba_m.ecba002) AND NOT cl_null(g_ecbb_d[l_ac].ecbb003) AND NOT cl_null(g_ecbb_d[l_ac].ecbb004)  AND NOT cl_null(g_ecbb_d[l_ac].ecbb005) THEN
                      IF g_ecba_m.ecbastus = 'N' AND g_ecbb_d[l_ac].ecbb008 = 'MULT' THEN
                         CALL aecm200_01(g_ecba_m.ecba001,g_ecba_m.ecba002,g_ecbb_d[l_ac].ecbb003,g_ecbb_d[l_ac].ecbb004,g_ecbb_d[l_ac].ecbb005,'Y','N')
                      ELSE
                         CALL aecm200_01(g_ecba_m.ecba001,g_ecba_m.ecba002,g_ecbb_d[l_ac].ecbb003,g_ecbb_d[l_ac].ecbb004,g_ecbb_d[l_ac].ecbb005,'N','N')
                      END IF
                   END IF
                END IF
                LET g_action_choice=""
               #END add-point
               EXIT DIALOG
            END IF
 
 
         #+ 此段落由子樣板a43產生
         ON ACTION bom
            LET g_action_choice="bom"
            IF cl_auth_chk_act("bom") THEN
               
               #add-point:ON ACTION bom
                CALL aecm200_04(g_ecba_m.ecba001,g_ecba_m.ecba002)
                LET g_action_choice=""
               #END add-point
               EXIT DIALOG
            END IF
         #160112-00011#4-mark-(S)
#         ON ACTION open_esop
#            LET g_action_choice="open_esop"
#            IF cl_auth_chk_act("open_esop") THEN
#               #160112-00011#2 20160121 add by ming -----(S) 
#               #開啟eSop 
#               CALL aecm200_open_esop()
#               #160112-00011#2 20160121 add by ming -----(E) 
#               EXIT DIALOG
#            END IF
         
#         ON ACTION upload_esop
#            LET g_action_choice="upload_esop"
#            IF cl_auth_chk_act("upload_esop") THEN
#               #160112-00011#2 20160121 add by ming -----(S) 
#               #上傳eSop 
#               CALL aecm200_upload_esop()
#               #160112-00011#2 20160121 add by ming -----(E) 
#               EXIT DIALOG
#            END IF
         #160112-00011#4-mark-(E)   
         #+ 此段落由子樣板a43產生
         ON ACTION checkin
            LET g_action_choice="checkin"
            IF cl_auth_chk_act("checkin") THEN
               
               #add-point:ON ACTION checkin
                IF l_ac > 0 THEN
                   IF NOT cl_null(g_ecba_m.ecba001) AND  NOT cl_null(g_ecba_m.ecba002) AND NOT cl_null(g_ecbb_d[l_ac].ecbb003) AND NOT cl_null(g_ecbb_d[l_ac].ecbb004)  AND NOT cl_null(g_ecbb_d[l_ac].ecbb005) THEN
                      IF g_ecba_m.ecbastus = 'N' THEN
                         CALL aecm200_02(g_ecba_m.ecba001,g_ecba_m.ecba002,g_ecbb_d[l_ac].ecbb003,g_ecbb_d[l_ac].ecbb004,g_ecbb_d[l_ac].ecbb005,'1','Y','N')
                      ELSE             
                         CALL aecm200_02(g_ecba_m.ecba001,g_ecba_m.ecba002,g_ecbb_d[l_ac].ecbb003,g_ecbb_d[l_ac].ecbb004,g_ecbb_d[l_ac].ecbb005,'1','N','N')
                      END IF
                   END IF
                END IF
                LET g_action_choice=""
               #END add-point
               EXIT DIALOG
            END IF
 
 
         
         #+ 此段落由子樣板a46產生
         #新增相關文件
         ON ACTION related_document
            CALL aecm200_set_pk_array()
            IF cl_auth_chk_act("related_document") THEN
               #add-point:ON ACTION related_document

               #END add-point
               CALL cl_doc()
            END IF
            
         ON ACTION agendum
            CALL aecm200_set_pk_array()
            #add-point:ON ACTION agendum

            #END add-point
            CALL cl_user_overview()
            CALL cl_user_overview_set_follow_pic()
         
         ON ACTION followup
            CALL aecm200_set_pk_array()
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
 
{<section id="aecm200.browser_fill" >}
#+ 瀏覽頁簽資料填充
PRIVATE FUNCTION aecm200_browser_fill(ps_page_action)
   DEFINE ps_page_action    STRING
   DEFINE l_wc              STRING
   DEFINE l_wc2             STRING
   DEFINE l_sql             STRING
   DEFINE l_sub_sql         STRING
   DEFINE l_sql_rank        STRING
   DEFINE l_searchcol       STRING
   #add-point:browser_fill段define
   DEFINE l_wc3             STRING 
   DEFINE l_wc4             STRING 
   #end add-point    
 
   #清除畫面
   CLEAR FORM                
   INITIALIZE g_ecba_m.* TO NULL
   CALL g_ecbb_d.clear()        
 
   CALL g_browser.clear()
   #add-point:browser_fill段動作開始前
   #160801-00023#4--(S)
   CALL cl_get_para(g_enterprise,g_site,'S-MFG-0036') RETURNING g_smfg0036
   IF g_smfg0036 <> '2' THEN
      CALL cl_set_toolbaritem_visible("resource", FALSE)
      CALL cl_set_comp_visible('ecbb038,ecbb038_desc',FALSE)
   ELSE
      CALL cl_set_toolbaritem_visible("resource", TRUE)
      CALL cl_set_comp_visible('ecbb038,ecbb038_desc',TRUE)
   END IF
   #160801-00023#4--(E)
   #end add-point
   
   #搜尋用
   IF cl_null(g_searchcol) OR g_searchcol = '0' THEN
      LET l_searchcol = "ecba001,ecba002"
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
   CALL g_ecbb2_d.clear()
   CALL g_ecbb3_d.clear()
   CALL g_ecbb4_d.clear()
   LET l_wc3 = g_wc3.trim()
   LET l_wc4 = g_wc4.trim()
   #end add-point
    
   IF g_wc2 <> " 1=1" THEN
      #單身有輸入搜尋條件                      
      LET l_sub_sql = " SELECT UNIQUE ecba001,ecba002 ",
                      " FROM ecba_t ",
                      " ",
                      " LEFT JOIN ecbb_t ON ecbbent = ecbaent AND ecbbsite = ecbasite AND ecba001 = ecbb001 AND ecba002 = ecbb002 ",
 
 
                      " ", 
                      " ", 
                      " WHERE ecbaent = '" ||g_enterprise|| "' AND ecbasite = '" ||g_site|| "' AND ecbbent = '" ||g_enterprise|| "' AND ecbbsite = '" ||g_site|| "' AND ",l_wc, " AND ", l_wc2, cl_sql_add_filter("ecba_t")
   ELSE
      #單身未輸入搜尋條件
      LET l_sub_sql = " SELECT UNIQUE ecba001,ecba002 ",
                      " FROM ecba_t ", 
                      "  ",
                      "  ",
                      " WHERE ecbaent = '" ||g_enterprise|| "' AND ecbasite = '" ||g_site|| "' AND ",l_wc CLIPPED, cl_sql_add_filter("ecba_t")
   END IF
   
   #add-point:browser_fill,cnt wc
   
   #end add-point
   
   LET g_sql = " SELECT COUNT(*) FROM (",l_sub_sql,")"
   
   #add-point:browser_fill,count前
   IF g_wc4 <> " 1=1" THEN
      #單身3有輸入搜尋條件                      
      LET l_sub_sql = " SELECT UNIQUE ecba001,ecba002 ",
                      "   FROM ecba_t ",
                      "   LEFT JOIN ecbb_t ON ecbbent = ecbaent AND ecbbsite = ecbasite AND ecba001 = ecbb001 AND ecba002 = ecbb002 ",
                      "   LEFT JOIN ecbc_t ON ecbcent = ecbbent AND ecbcsite = ecbbsite AND ecbc001 = ecbb001 AND ecbc002 = ecbb002 AND ecbc003 = ecbb003 ",
                      "   LEFT JOIN ecbd_t ON ecbdent = ecbcent AND ecbdsite = ecbcsite AND ecbd001 = ecbc001 AND ecbd002 = ecbc002 AND ecbd003 = ecbc003 AND ecbd004 = ecbc004 ",
                      "  WHERE ecbaent = '" ||g_enterprise|| "' AND ecbasite = '" ||g_site|| "' AND ecbbent = '" ||g_enterprise|| "' AND ecbbsite = '" ||g_site|| "' AND ",l_wc, " AND ", l_wc2, " AND ",l_wc3, " AND ",l_wc4
   ELSE
      #單身2有輸入搜尋條件
      IF g_wc3 <> " 1=1" THEN
         LET l_sub_sql = " SELECT UNIQUE ecba001,ecba002 ",
                         "   FROM ecba_t ",
                         "   LEFT JOIN ecbb_t ON ecbbent = ecbaent AND ecbbsite = ecbasite AND ecba001 = ecbb001 AND ecba002 = ecbb002 ",
                         "   LEFT JOIN ecbc_t ON ecbcent = ecbbent AND ecbcsite = ecbbsite AND ecbc001 = ecbb001 AND ecbc002 = ecbb002 AND ecbc003 = ecbb003 ",
                         "  WHERE ecbaent = '" ||g_enterprise|| "' AND ecbasite = '" ||g_site|| "' AND ecbbent = '" ||g_enterprise|| "' AND ecbbsite = '" ||g_site|| "' AND ",l_wc, " AND ", l_wc2, " AND ",l_wc3
      ELSE
         IF g_wc2 <> " 1=1" THEN
            LET l_sub_sql = " SELECT UNIQUE ecba001,ecba002 ",
                            "   FROM ecba_t ",
                            "   LEFT JOIN ecbb_t ON ecbbent = ecbaent AND ecbbsite = ecbasite AND ecba001 = ecbb001 AND ecba002 = ecbb002 ",
                            "  WHERE ecbaent = '" ||g_enterprise|| "' AND ecbasite = '" ||g_site|| "' AND ecbbent = '" ||g_enterprise|| "' AND ecbbsite = '" ||g_site|| "' AND ",l_wc, " AND ", l_wc2
         ELSE
            LET l_sub_sql = " SELECT UNIQUE ecba001,ecba002 ",
                            "   FROM ecba_t ",
                            "  WHERE ecbaent = '" ||g_enterprise|| "' AND ecbasite = '" ||g_site|| "' AND ",l_wc CLIPPED
         END IF
      END IF
   END IF
   
   LET g_sql = " SELECT COUNT(*) FROM (",l_sub_sql,")"
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
 
   #依照t0.ecba001,t0.ecba002,t0.ecba003 Browser欄位定義(取代原本bs_sql功能)
   LET g_sql = " SELECT DISTINCT t0.ecbastus,t0.ecba001,t0.ecba002,t0.ecba003,t1.imaal003 ",
               " FROM ecba_t t0",
               "  ",
               "  LEFT JOIN ecbb_t ON ecbbent = ecbaent AND ecbbsite = ecbasite AND ecba001 = ecbb001 AND ecba002 = ecbb002 ",
 
 
               "  ",
               "  ",
                              " LEFT JOIN imaal_t t1 ON t1.imaalent='"||g_enterprise||"' AND t1.imaal001=t0.ecba001 AND t1.imaal002='"||g_lang||"' ",
 
               " WHERE t0.ecbaent = '" ||g_enterprise|| "' AND t0.ecbasite = '" ||g_site|| "' AND ",l_wc," AND ",l_wc2, cl_sql_add_filter("ecba_t")
   #add-point:browser_fill,sql wc
   
   #end add-point
   LET g_sql = g_sql, " ORDER BY ",l_searchcol," ",g_order
 
   #add-point:browser_fill,before_prepare
   IF g_wc4 <> " 1=1" THEN
      #單身3有輸入搜尋條件                      
      LET l_sql_rank = "  SELECT DISTINCT ecbastus,ecba001,'','',ecba002,ecba003,DENSE_RANK() OVER(ORDER BY ecba001,ecba002 ",g_order,") AS RANK ",
                      "   FROM ecba_t ",
                      "   LEFT JOIN ecbb_t ON ecbbent = ecbaent AND ecbbsite = ecbasite AND ecba001 = ecbb001 AND ecba002 = ecbb002 ",
                      "   LEFT JOIN ecbc_t ON ecbcent = ecbbent AND ecbcsite = ecbbsite AND ecbc001 = ecbb001 AND ecbc002 = ecbb002 AND ecbc003 = ecbb003 ",
                      "   LEFT JOIN ecbd_t ON ecbdent = ecbcent AND ecbdsite = ecbcsite AND ecbd001 = ecbc001 AND ecbd002 = ecbc002 AND ecbd003 = ecbc003 AND ecbd004 = ecbc004 ",
                      "  WHERE ecbaent = '" ||g_enterprise|| "' AND ecbasite = '" ||g_site|| "' AND ecbbent = '" ||g_enterprise|| "' AND ecbbsite = '" ||g_site|| "' AND ",g_wc, " AND ", g_wc2, " AND ",g_wc3, " AND ",g_wc4
   ELSE
      #單身2有輸入搜尋條件
      IF g_wc3 <> " 1=1" THEN
         LET l_sql_rank = " SELECT DISTINCT ecbastus,ecba001,'','',ecba002,ecba003,DENSE_RANK() OVER(ORDER BY ecba001,ecba002 ",g_order,") AS RANK ",
                         "   FROM ecba_t ",
                         "   LEFT JOIN ecbb_t ON ecbbent = ecbaent AND ecbbsite = ecbasite AND ecba001 = ecbb001 AND ecba002 = ecbb002 ",
                         "   LEFT JOIN ecbc_t ON ecbcent = ecbbent AND ecbcsite = ecbbsite AND ecbc001 = ecbb001 AND ecbc002 = ecbb002 AND ecbc003 = ecbb003 ",
                         "  WHERE ecbaent = '" ||g_enterprise|| "' AND ecbasite = '" ||g_site|| "' AND ecbbent = '" ||g_enterprise|| "' AND ecbbsite = '" ||g_site|| "' AND ",g_wc, " AND ", g_wc2, " AND ",g_wc3
      ELSE
         IF g_wc2 <> " 1=1" THEN
            LET l_sql_rank = " SELECT DISTINCT ecbastus,ecba001,'','',ecba002,ecba003,DENSE_RANK() OVER(ORDER BY ecba001,ecba002 ",g_order,") AS RANK ",
                            "   FROM ecba_t ",
                            "   LEFT JOIN ecbb_t ON ecbbent = ecbaent AND ecbbsite = ecbasite AND ecba001 = ecbb001 AND ecba002 = ecbb002 ",
                            "  WHERE ecbaent = '" ||g_enterprise|| "' AND ecbasite = '" ||g_site|| "' AND ecbbent = '" ||g_enterprise|| "' AND ecbbsite = '" ||g_site|| "' AND ",g_wc, " AND ", g_wc2
         ELSE
            LET l_sql_rank = " SELECT DISTINCT ecbastus,ecba001,'','',ecba002,ecba003,DENSE_RANK() OVER(ORDER BY ecba001,ecba002 ",g_order,") AS RANK ",
                            "   FROM ecba_t ",
                            "  WHERE ecbaent = '" ||g_enterprise|| "' AND ecbasite = '" ||g_site|| "' AND ",g_wc CLIPPED
         END IF
      END IF
   END IF
   
   #定義翻頁CURSOR
   LET g_sql= "SELECT ecbastus,ecba001,ecba002,ecba003,'' FROM (",l_sql_rank,") WHERE ",
              " RANK >= ",1," AND RANK<",1+g_max_browse,
              " ORDER BY ",l_searchcol," ",g_order
   #end add-point
        
   #LET g_sql = cl_sql_add_tabid(g_sql,"ecba_t") #WC重組
   LET g_sql = cl_sql_add_mask(g_sql) #遮蔽特定資料
   PREPARE browse_pre FROM g_sql
   DECLARE browse_cur CURSOR FOR browse_pre
   
   #add-point:browser_fill段open cursor
   
   #end add-point
 
   CALL g_browser.clear()
   LET g_cnt = 1
   FOREACH browse_cur INTO g_browser[g_cnt].b_statepic,g_browser[g_cnt].b_ecba001,g_browser[g_cnt].b_ecba002, 
       g_browser[g_cnt].b_ecba003,g_browser[g_cnt].b_ecba001_desc
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = 'foreach:' 
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = TRUE 
         CALL cl_err()
         EXIT FOREACH
      END IF
  
      #add-point:browser_fill段reference
      INITIALIZE g_ref_fields TO NULL
      LET g_ref_fields[1] = g_browser[g_cnt].b_ecba001
      CALL ap_ref_array2(g_ref_fields,"SELECT imaal003,imaal004 FROM imaal_t WHERE imaalent='"||g_enterprise||"' AND imaal001=? AND imaal002='"||g_dlang||"'","") RETURNING g_rtn_fields
      LET g_browser[g_cnt].b_ecba001_desc = g_rtn_fields[1]
      LET g_browser[g_cnt].b_ecba001_desc1 = g_rtn_fields[2]
      DISPLAY BY NAME g_browser[g_cnt].b_ecba001_desc
      DISPLAY BY NAME g_browser[g_cnt].b_ecba001_desc1

      #end add-point
  
            #此段落由子樣板a24產生
      #browser段落顯示圖片
      CASE g_browser[g_cnt].b_statepic
         WHEN "N"
            LET g_browser[g_cnt].b_statepic = "stus/16/open.png"
         WHEN "X"
            LET g_browser[g_cnt].b_statepic = "stus/16/void.png"
         WHEN "Y"
            LET g_browser[g_cnt].b_statepic = "stus/16/valid.png"
         
      END CASE
 
 
      LET g_cnt = g_cnt + 1
      IF g_cnt > g_max_rec THEN
         EXIT FOREACH
      END IF
      
   END FOREACH
 
   CALL g_browser.deleteElement(g_cnt)
   LET g_header_cnt = g_browser.getLength()
 
   LET g_rec_b = g_cnt - 1
   LET g_detail_cnt = g_rec_b
   LET g_cnt = 0
   
   FREE browse_pre
   
   #add-point:browser_fill段結束前
   
   #end add-point
   
   #若無資料則關閉相關功能
   IF g_browser_cnt = 0 THEN
      CALL cl_set_act_visible("statechange,modify,delete,reproduce", FALSE)
   ELSE
      CALL cl_set_act_visible("statechange,modify,delete,reproduce", TRUE)
   END IF
   
END FUNCTION
 
{</section>}
 
{<section id="aecm200.ui_headershow" >}
#+ 單頭資料重新顯示
PRIVATE FUNCTION aecm200_ui_headershow()
   #add-point:ui_headershow段define

   #end add-point    
   
   LET g_ecba_m.ecba001 = g_browser[g_current_idx].b_ecba001   
   LET g_ecba_m.ecba002 = g_browser[g_current_idx].b_ecba002   
 
   #EXECUTE aecm200_master_referesh USING g_ecba_m.ecba001,g_ecba_m.ecba002 INTO g_ecba_m.ecba001,g_ecba_m.ecba002,   #160707-00040#1 mark
   EXECUTE aecm200_master_referesh USING g_site,g_ecba_m.ecba001,g_ecba_m.ecba002 INTO g_ecba_m.ecba001,g_ecba_m.ecba002,    #160707-00040#1
       g_ecba_m.ecba003,g_ecba_m.ecba004,g_ecba_m.ecba005,g_ecba_m.ecba006,g_ecba_m.ecba007,g_ecba_m.ecbastus, 
       g_ecba_m.ecbacrtid,g_ecba_m.ecbacrtdp,g_ecba_m.ecbacrtdt,g_ecba_m.ecbaownid,g_ecba_m.ecbaowndp, 
       g_ecba_m.ecbamodid,g_ecba_m.ecbamoddt,g_ecba_m.ecbacnfid,g_ecba_m.ecbacnfdt,g_ecba_m.ecbacrtid_desc, 
       g_ecba_m.ecbacrtdp_desc,g_ecba_m.ecbaownid_desc,g_ecba_m.ecbaowndp_desc,g_ecba_m.ecbamodid_desc, 
       g_ecba_m.ecbacnfid_desc
   CALL aecm200_show()
   
END FUNCTION
 
{</section>}
 
{<section id="aecm200.ui_detailshow" >}
#+ 單身資料重新顯示
PRIVATE FUNCTION aecm200_ui_detailshow()
   #add-point:ui_detailshow段define
   
   #end add-point    
   
   #add-point:ui_detailshow段before
   
   #end add-point    
   
   IF g_curr_diag IS NOT NULL THEN
      CALL g_curr_diag.setCurrentRow("s_detail1",g_detail_idx)      
 
   END IF
   
   #add-point:ui_detailshow段after
   IF g_curr_diag IS NOT NULL THEN
      CALL g_curr_diag.setCurrentRow("s_detail2",g_detail_idx)      
      CALL g_curr_diag.setCurrentRow("s_detail3",g_detail_idx) 
   END IF
   #end add-point    
   
END FUNCTION
 
{</section>}
 
{<section id="aecm200.ui_browser_refresh" >}
#+ 瀏覽頁簽資料重新顯示
PRIVATE FUNCTION aecm200_ui_browser_refresh()
   DEFINE l_i  LIKE type_t.num10
   #add-point:ui_browser_refresh段define
   
   #end add-point    
   
   FOR l_i =1 TO g_browser.getLength()
      IF g_browser[l_i].b_ecba001 = g_ecba_m.ecba001 
         AND g_browser[l_i].b_ecba002 = g_ecba_m.ecba002 
 
         THEN  
         CALL g_browser.deleteElement(l_i)
         LET g_header_cnt = g_header_cnt - 1
         EXIT FOR
      END IF
   END FOR
 
   LET g_browser_cnt = g_browser_cnt - 1
   IF g_current_row > g_browser_cnt THEN        #確定browse 筆數指在同一筆
      LET g_current_row = g_browser_cnt
   END IF
 
   #DISPLAY g_browser_cnt TO FORMONLY.b_count    #總筆數的顯示
   
END FUNCTION
 
{</section>}
 
{<section id="aecm200.construct" >}
#+ QBE資料查詢
PRIVATE FUNCTION aecm200_construct()
   DEFINE ls_return   STRING
   DEFINE ls_result   STRING 
   DEFINE ls_wc       STRING 
   #add-point:cs段define
   
   #end add-point    
 
   #清除畫面
   CLEAR FORM                
   INITIALIZE g_ecba_m.* TO NULL
   CALL g_ecbb_d.clear()        
 
   
   LET g_action_choice = ""
    
   INITIALIZE g_wc TO NULL
   INITIALIZE g_wc2 TO NULL
   
   INITIALIZE g_wc2_table1 TO NULL
 
    
   LET g_qryparam.state = 'c'
   
   #add-point:cs段開始前
   CALL g_ecbb2_d.clear()
   CALL g_ecbb3_d.clear()   
   INITIALIZE g_wc3 TO NULL
   INITIALIZE g_wc3_table1 TO NULL
   INITIALIZE g_wc4 TO NULL
   INITIALIZE g_wc4_table1 TO NULL
   #end add-point 
   
   #使用DIALOG包住 單頭CONSTRUCT及單身CONSTRUCT
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
      
      #單頭
      CONSTRUCT BY NAME g_wc ON ecba001,ecba002,ecba003,ecba004,ecba005,ecba006,ecba007,ecbastus,ooeb013, 
          ecbacrtid,ecbacrtdp,ecbacrtdt,ecbaownid,ecbaowndp,ecbamodid,ecbamoddt,ecbacnfid,ecbacnfdt
 
         BEFORE CONSTRUCT
            #add-point:cs段before_construct
            
            #end add-point 
            
         #公用欄位開窗相關處理
         #此段落由子樣板a11產生
         #共用欄位查詢處理
         ##----<<ecbacrtdt>>----
         AFTER FIELD ecbacrtdt
            CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
            IF NOT cl_null(ls_result) THEN
               IF NOT cl_chk_date_symbol(ls_result) THEN
                  LET ls_result = cl_add_date_extra_cond(ls_result)
               END IF
            END IF
            CALL FGL_DIALOG_SETBUFFER(ls_result)
         
         #----<<ecbamoddt>>----
         AFTER FIELD ecbamoddt
            CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
            IF NOT cl_null(ls_result) THEN
               IF NOT cl_chk_date_symbol(ls_result) THEN
                  LET ls_result = cl_add_date_extra_cond(ls_result)
               END IF
            END IF
            CALL FGL_DIALOG_SETBUFFER(ls_result)
         
         #----<<ecbacnfdt>>----
         AFTER FIELD ecbacnfdt
            CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
            IF NOT cl_null(ls_result) THEN
               IF NOT cl_chk_date_symbol(ls_result) THEN
                  LET ls_result = cl_add_date_extra_cond(ls_result)
               END IF
            END IF
            CALL FGL_DIALOG_SETBUFFER(ls_result)
         
         #----<<ecbapstdt>>----
 
 
            
         #一般欄位開窗相關處理    
                  #Ctrlp:construct.c.ecba001
         ON ACTION controlp INFIELD ecba001
            #add-point:ON ACTION controlp INFIELD ecba001
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'     #160201-00008#1-add
            LET g_qryparam.reqry = FALSE
            CALL q_imaf001_6()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO ecba001  #顯示到畫面上

            NEXT FIELD ecba001                     #返回原欄位


            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD ecba001
            #add-point:BEFORE FIELD ecba001
            
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD ecba001
            
            #add-point:AFTER FIELD ecba001
 
            #END add-point
            
 
         #此段落由子樣板a01產生
         BEFORE FIELD ecba002
            #add-point:BEFORE FIELD ecba002
            
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD ecba002
            
            #add-point:AFTER FIELD ecba002
 
            #END add-point
            
 
         #Ctrlp:construct.c.ecba002
         ON ACTION controlp INFIELD ecba002
            #add-point:ON ACTION controlp INFIELD ecba002
            
            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD ecba003
            #add-point:BEFORE FIELD ecba003
            
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD ecba003
            
            #add-point:AFTER FIELD ecba003
            
            #END add-point
            
 
         #Ctrlp:construct.c.ecba003
         ON ACTION controlp INFIELD ecba003
            #add-point:ON ACTION controlp INFIELD ecba003
            
            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD ecba004
            #add-point:BEFORE FIELD ecba004
            
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD ecba004
            
            #add-point:AFTER FIELD ecba004
            
            #END add-point
            
 
         #Ctrlp:construct.c.ecba004
         ON ACTION controlp INFIELD ecba004
            #add-point:ON ACTION controlp INFIELD ecba004
            
            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD ecba005
            #add-point:BEFORE FIELD ecba005
            
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD ecba005
            
            #add-point:AFTER FIELD ecba005
            
            #END add-point
            
 
         #Ctrlp:construct.c.ecba005
         ON ACTION controlp INFIELD ecba005
            #add-point:ON ACTION controlp INFIELD ecba005
            
            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD ecba006
            #add-point:BEFORE FIELD ecba006
            
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD ecba006
            
            #add-point:AFTER FIELD ecba006
            
            #END add-point
            
 
         #Ctrlp:construct.c.ecba006
         ON ACTION controlp INFIELD ecba006
            #add-point:ON ACTION controlp INFIELD ecba006
            
            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD ecba007
            #add-point:BEFORE FIELD ecba007
            
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD ecba007
            
            #add-point:AFTER FIELD ecba007
            
            #END add-point
            
 
         #Ctrlp:construct.c.ecba007
         ON ACTION controlp INFIELD ecba007
            #add-point:ON ACTION controlp INFIELD ecba007
            
            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD ecbastus
            #add-point:BEFORE FIELD ecbastus
            
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD ecbastus
            
            #add-point:AFTER FIELD ecbastus
            
            #END add-point
            
 
         #Ctrlp:construct.c.ecbastus
         ON ACTION controlp INFIELD ecbastus
            #add-point:ON ACTION controlp INFIELD ecbastus
            
            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD ooeb013
            #add-point:BEFORE FIELD ooeb013
            
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD ooeb013
            
            #add-point:AFTER FIELD ooeb013
            
            #END add-point
            
 
         #Ctrlp:construct.c.ooeb013
         ON ACTION controlp INFIELD ooeb013
            #add-point:ON ACTION controlp INFIELD ooeb013
            
            #END add-point
 
         #Ctrlp:construct.c.ecbacrtid
         ON ACTION controlp INFIELD ecbacrtid
            #add-point:ON ACTION controlp INFIELD ecbacrtid
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'     #160201-00008#1-add
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO ecbacrtid  #顯示到畫面上

            NEXT FIELD ecbacrtid                     #返回原欄位


            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD ecbacrtid
            #add-point:BEFORE FIELD ecbacrtid
            
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD ecbacrtid
            
            #add-point:AFTER FIELD ecbacrtid
            
            #END add-point
            
 
         #Ctrlp:construct.c.ecbacrtdp
         ON ACTION controlp INFIELD ecbacrtdp
            #add-point:ON ACTION controlp INFIELD ecbacrtdp
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'     #160201-00008#1-add
            LET g_qryparam.reqry = FALSE
            CALL q_ooeg001_9()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO ecbacrtdp  #顯示到畫面上

            NEXT FIELD ecbacrtdp                     #返回原欄位


            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD ecbacrtdp
            #add-point:BEFORE FIELD ecbacrtdp
            
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD ecbacrtdp
            
            #add-point:AFTER FIELD ecbacrtdp
            
            #END add-point
            
 
         #此段落由子樣板a01產生
         BEFORE FIELD ecbacrtdt
            #add-point:BEFORE FIELD ecbacrtdt
            
            #END add-point
 
         #Ctrlp:construct.c.ecbaownid
         ON ACTION controlp INFIELD ecbaownid
            #add-point:ON ACTION controlp INFIELD ecbaownid
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'     #160201-00008#1-add
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO ecbaownid  #顯示到畫面上

            NEXT FIELD ecbaownid                     #返回原欄位


            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD ecbaownid
            #add-point:BEFORE FIELD ecbaownid
            
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD ecbaownid
            
            #add-point:AFTER FIELD ecbaownid
            
            #END add-point
            
 
         #Ctrlp:construct.c.ecbaowndp
         ON ACTION controlp INFIELD ecbaowndp
            #add-point:ON ACTION controlp INFIELD ecbaowndp
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'     #160201-00008#1-add
            LET g_qryparam.reqry = FALSE
            CALL q_ooeg001_9()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO ecbaowndp  #顯示到畫面上

            NEXT FIELD ecbaowndp                     #返回原欄位


            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD ecbaowndp
            #add-point:BEFORE FIELD ecbaowndp
            
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD ecbaowndp
            
            #add-point:AFTER FIELD ecbaowndp
            
            #END add-point
            
 
         #Ctrlp:construct.c.ecbamodid
         ON ACTION controlp INFIELD ecbamodid
            #add-point:ON ACTION controlp INFIELD ecbamodid
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'     #160201-00008#1-add
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO ecbamodid  #顯示到畫面上

            NEXT FIELD ecbamodid                     #返回原欄位


            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD ecbamodid
            #add-point:BEFORE FIELD ecbamodid
            
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD ecbamodid
            
            #add-point:AFTER FIELD ecbamodid
            
            #END add-point
            
 
         #此段落由子樣板a01產生
         BEFORE FIELD ecbamoddt
            #add-point:BEFORE FIELD ecbamoddt
            
            #END add-point
 
         #Ctrlp:construct.c.ecbacnfid
         ON ACTION controlp INFIELD ecbacnfid
            #add-point:ON ACTION controlp INFIELD ecbacnfid
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'     #160201-00008#1-add
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO ecbacnfid  #顯示到畫面上

            NEXT FIELD ecbacnfid                     #返回原欄位


            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD ecbacnfid
            #add-point:BEFORE FIELD ecbacnfid
            
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD ecbacnfid
            
            #add-point:AFTER FIELD ecbacnfid
            
            #END add-point
            
 
         #此段落由子樣板a01產生
         BEFORE FIELD ecbacnfdt
            #add-point:BEFORE FIELD ecbacnfdt
            
            #END add-point
 
 
         
      END CONSTRUCT
 
      #單身根據table分拆construct
      CONSTRUCT g_wc2_table1 ON ecbb003,ecbb004,ecbb005,ecbb006,ecbb007,ecbb008,ecbb009,ecbb010,ecbb011, 
          ecbb012,ecbb024,ecbb025,ecbb026,ecbb027,ecbb034,ecbb013,ecbb014,ecbb015,ecbb016,ecbb017,ecbb018, 
          ecbb019,ecbb020,ecbb030,ecbb031,ecbb032,ecbb021,ecbb022,ecbb023,ecbb033,ecbb028,ecbb029,ecbb035, 
          ecbb036,ooff013
           FROM s_detail1[1].ecbb003,s_detail1[1].ecbb004,s_detail1[1].ecbb005,s_detail1[1].ecbb006, 
               s_detail1[1].ecbb007,s_detail1[1].ecbb008,s_detail1[1].ecbb009,s_detail1[1].ecbb010,s_detail1[1].ecbb011, 
               s_detail1[1].ecbb012,s_detail1[1].ecbb024,s_detail1[1].ecbb025,s_detail1[1].ecbb026,s_detail1[1].ecbb027, 
               s_detail1[1].ecbb034,s_detail1[1].ecbb013,s_detail1[1].ecbb014,s_detail1[1].ecbb015,s_detail1[1].ecbb016, 
               s_detail1[1].ecbb017,s_detail1[1].ecbb018,s_detail1[1].ecbb019,s_detail1[1].ecbb020,s_detail1[1].ecbb030, 
               s_detail1[1].ecbb031,s_detail1[1].ecbb032,s_detail1[1].ecbb021,s_detail1[1].ecbb022,s_detail1[1].ecbb023, 
               s_detail1[1].ecbb033,s_detail1[1].ecbb028,s_detail1[1].ecbb029,s_detail1[1].ecbb035,s_detail1[1].ecbb036, 
               s_detail1[1].ooff013
                      
         BEFORE CONSTRUCT
            #add-point:cs段before_construct
            
            #end add-point 
            
       #單身公用欄位開窗相關處理
       
         
       #單身一般欄位開窗相關處理
                #此段落由子樣板a01產生
         BEFORE FIELD ecbb003
            #add-point:BEFORE FIELD ecbb003
            
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD ecbb003
            
            #add-point:AFTER FIELD ecbb003
            
            #END add-point
            
 
         #Ctrlp:construct.c.page1.ecbb003
         ON ACTION controlp INFIELD ecbb003
            #add-point:ON ACTION controlp INFIELD ecbb003
            
            #END add-point
 
         #Ctrlp:construct.c.page1.ecbb004
         ON ACTION controlp INFIELD ecbb004
            #add-point:ON ACTION controlp INFIELD ecbb004
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'     #160201-00008#1-add
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.arg1 = "221"
            CALL q_oocq002()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO ecbb004  #顯示到畫面上

            NEXT FIELD ecbb004                     #返回原欄位


            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD ecbb004
            #add-point:BEFORE FIELD ecbb004
            
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD ecbb004
            
            #add-point:AFTER FIELD ecbb004
            
            #END add-point
            
 
         #此段落由子樣板a01產生
         BEFORE FIELD ecbb005
            #add-point:BEFORE FIELD ecbb005
            
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD ecbb005
            
            #add-point:AFTER FIELD ecbb005
            
            #END add-point
            
 
         #Ctrlp:construct.c.page1.ecbb005
         ON ACTION controlp INFIELD ecbb005
            #add-point:ON ACTION controlp INFIELD ecbb005
            
            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD ecbb006
            #add-point:BEFORE FIELD ecbb006
            
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD ecbb006
            
            #add-point:AFTER FIELD ecbb006
            
            #END add-point
            
 
         #Ctrlp:construct.c.page1.ecbb006
         ON ACTION controlp INFIELD ecbb006
            #add-point:ON ACTION controlp INFIELD ecbb006
            
            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD ecbb007
            #add-point:BEFORE FIELD ecbb007
            
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD ecbb007
            
            #add-point:AFTER FIELD ecbb007
            
            #END add-point
            
 
         #Ctrlp:construct.c.page1.ecbb007
         ON ACTION controlp INFIELD ecbb007
            #add-point:ON ACTION controlp INFIELD ecbb007
            
            #END add-point
 
         #Ctrlp:construct.c.page1.ecbb008
         ON ACTION controlp INFIELD ecbb008
            #add-point:ON ACTION controlp INFIELD ecbb008
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'     #160201-00008#1-add
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.arg1 = "221"
            CALL q_oocq002()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO ecbb008  #顯示到畫面上

            NEXT FIELD ecbb008                     #返回原欄位


            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD ecbb008
            #add-point:BEFORE FIELD ecbb008
            
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD ecbb008
            
            #add-point:AFTER FIELD ecbb008
            
            #END add-point
            
 
         #此段落由子樣板a01產生
         BEFORE FIELD ecbb009
            #add-point:BEFORE FIELD ecbb009
            
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD ecbb009
            
            #add-point:AFTER FIELD ecbb009
            
            #END add-point
            
 
         #Ctrlp:construct.c.page1.ecbb009
         ON ACTION controlp INFIELD ecbb009
            #add-point:ON ACTION controlp INFIELD ecbb009
            
            #END add-point
 
         #Ctrlp:construct.c.page1.ecbb010
         ON ACTION controlp INFIELD ecbb010
            #add-point:ON ACTION controlp INFIELD ecbb010
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'     #160201-00008#1-add
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.arg1 = "221"
            CALL q_oocq002()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO ecbb010  #顯示到畫面上

            NEXT FIELD ecbb010                     #返回原欄位


            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD ecbb010
            #add-point:BEFORE FIELD ecbb010
            
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD ecbb010
            
            #add-point:AFTER FIELD ecbb010
            
            #END add-point
            
 
         #此段落由子樣板a01產生
         BEFORE FIELD ecbb011
            #add-point:BEFORE FIELD ecbb011
            
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD ecbb011
            
            #add-point:AFTER FIELD ecbb011
            
            #END add-point
            
 
         #Ctrlp:construct.c.page1.ecbb011
         ON ACTION controlp INFIELD ecbb011
            #add-point:ON ACTION controlp INFIELD ecbb011
            
            #END add-point
 
         #Ctrlp:construct.c.page1.ecbb012
         ON ACTION controlp INFIELD ecbb012
            #add-point:ON ACTION controlp INFIELD ecbb012
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'     #160201-00008#1-add
            LET g_qryparam.reqry = FALSE
            CALL q_ecaa001_1()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO ecbb012  #顯示到畫面上

            NEXT FIELD ecbb012                     #返回原欄位


            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD ecbb012
            #add-point:BEFORE FIELD ecbb012
            
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD ecbb012
            
            #add-point:AFTER FIELD ecbb012
            
            #END add-point
            
 
         #此段落由子樣板a01產生
         BEFORE FIELD ecbb024
            #add-point:BEFORE FIELD ecbb024
            
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD ecbb024
            
            #add-point:AFTER FIELD ecbb024
            
            #END add-point
            
 
         #Ctrlp:construct.c.page1.ecbb024
         ON ACTION controlp INFIELD ecbb024
            #add-point:ON ACTION controlp INFIELD ecbb024
            
            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD ecbb025
            #add-point:BEFORE FIELD ecbb025
            
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD ecbb025
            
            #add-point:AFTER FIELD ecbb025
            
            #END add-point
            
 
         #Ctrlp:construct.c.page1.ecbb025
         ON ACTION controlp INFIELD ecbb025
            #add-point:ON ACTION controlp INFIELD ecbb025
            
            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD ecbb026
            #add-point:BEFORE FIELD ecbb026
            
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD ecbb026
            
            #add-point:AFTER FIELD ecbb026
            
            #END add-point
            
 
         #Ctrlp:construct.c.page1.ecbb026
         ON ACTION controlp INFIELD ecbb026
            #add-point:ON ACTION controlp INFIELD ecbb026
            
            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD ecbb027
            #add-point:BEFORE FIELD ecbb027
            
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD ecbb027
            
            #add-point:AFTER FIELD ecbb027
            
            #END add-point
            
 
         #Ctrlp:construct.c.page1.ecbb027
         ON ACTION controlp INFIELD ecbb027
            #add-point:ON ACTION controlp INFIELD ecbb027
            
            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD ecbb034
            #add-point:BEFORE FIELD ecbb034
            
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD ecbb034
            
            #add-point:AFTER FIELD ecbb034
            
            #END add-point
            
 
         #Ctrlp:construct.c.page1.ecbb034
         ON ACTION controlp INFIELD ecbb034
            #add-point:ON ACTION controlp INFIELD ecbb034
            
            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD ecbb013
            #add-point:BEFORE FIELD ecbb013
            
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD ecbb013
            
            #add-point:AFTER FIELD ecbb013
            
            #END add-point
            
 
         #Ctrlp:construct.c.page1.ecbb013
         ON ACTION controlp INFIELD ecbb013
            #add-point:ON ACTION controlp INFIELD ecbb013
            
            #END add-point
 
         #Ctrlp:construct.c.page1.ecbb014
         ON ACTION controlp INFIELD ecbb014
            #add-point:ON ACTION controlp INFIELD ecbb014
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'     #160201-00008#1-add
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.arg1 = " ('1','3')"
            CALL q_pmaa001_1()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO ecbb014  #顯示到畫面上

            NEXT FIELD ecbb014                     #返回原欄位


            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD ecbb014
            #add-point:BEFORE FIELD ecbb014
            
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD ecbb014
            
            #add-point:AFTER FIELD ecbb014
            
            #END add-point
            
 
         #此段落由子樣板a01產生
         BEFORE FIELD ecbb015
            #add-point:BEFORE FIELD ecbb015
            
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD ecbb015
            
            #add-point:AFTER FIELD ecbb015
            
            #END add-point
            
 
         #Ctrlp:construct.c.page1.ecbb015
         ON ACTION controlp INFIELD ecbb015
            #add-point:ON ACTION controlp INFIELD ecbb015
            
            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD ecbb016
            #add-point:BEFORE FIELD ecbb016
            
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD ecbb016
            
            #add-point:AFTER FIELD ecbb016
            
            #END add-point
            
 
         #Ctrlp:construct.c.page1.ecbb016
         ON ACTION controlp INFIELD ecbb016
            #add-point:ON ACTION controlp INFIELD ecbb016
            
            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD ecbb017
            #add-point:BEFORE FIELD ecbb017
            
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD ecbb017
            
            #add-point:AFTER FIELD ecbb017
            
            #END add-point
            
 
         #Ctrlp:construct.c.page1.ecbb017
         ON ACTION controlp INFIELD ecbb017
            #add-point:ON ACTION controlp INFIELD ecbb017
            
            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD ecbb018
            #add-point:BEFORE FIELD ecbb018
            
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD ecbb018
            
            #add-point:AFTER FIELD ecbb018
            
            #END add-point
            
 
         #Ctrlp:construct.c.page1.ecbb018
         ON ACTION controlp INFIELD ecbb018
            #add-point:ON ACTION controlp INFIELD ecbb018
            
            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD ecbb019
            #add-point:BEFORE FIELD ecbb019
            
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD ecbb019
            
            #add-point:AFTER FIELD ecbb019
            
            #END add-point
            
 
         #Ctrlp:construct.c.page1.ecbb019
         ON ACTION controlp INFIELD ecbb019
            #add-point:ON ACTION controlp INFIELD ecbb019
            
            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD ecbb020
            #add-point:BEFORE FIELD ecbb020
            
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD ecbb020
            
            #add-point:AFTER FIELD ecbb020
            
            #END add-point
            
 
         #Ctrlp:construct.c.page1.ecbb020
         ON ACTION controlp INFIELD ecbb020
            #add-point:ON ACTION controlp INFIELD ecbb020
            
            #END add-point
 
         #Ctrlp:construct.c.page1.ecbb030
         ON ACTION controlp INFIELD ecbb030
            #add-point:ON ACTION controlp INFIELD ecbb030
            #此段落由子樣板a08產生
            #開窗c段
			   INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			   LET g_qryparam.reqry = FALSE
            CALL q_ooca001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO ecbb030  #顯示到畫面上

            NEXT FIELD ecbb030                     #返回原欄位


            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD ecbb030
            #add-point:BEFORE FIELD ecbb030
            
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD ecbb030
            
            #add-point:AFTER FIELD ecbb030
            
            #END add-point
            
 
         #此段落由子樣板a01產生
         BEFORE FIELD ecbb031
            #add-point:BEFORE FIELD ecbb031
            
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD ecbb031
            
            #add-point:AFTER FIELD ecbb031
            
            #END add-point
            
 
         #Ctrlp:construct.c.page1.ecbb031
         ON ACTION controlp INFIELD ecbb031
            #add-point:ON ACTION controlp INFIELD ecbb031
            
            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD ecbb032
            #add-point:BEFORE FIELD ecbb032
            
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD ecbb032
            
            #add-point:AFTER FIELD ecbb032
            
            #END add-point
            
 
         #Ctrlp:construct.c.page1.ecbb032
         ON ACTION controlp INFIELD ecbb032
            #add-point:ON ACTION controlp INFIELD ecbb032
            
            #END add-point
 
         #Ctrlp:construct.c.page1.ecbb021
         ON ACTION controlp INFIELD ecbb021
            #add-point:ON ACTION controlp INFIELD ecbb021
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'     #160201-00008#1-add
            LET g_qryparam.reqry = FALSE
            CALL q_ooca001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO ecbb021  #顯示到畫面上

            NEXT FIELD ecbb021                     #返回原欄位


            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD ecbb021
            #add-point:BEFORE FIELD ecbb021
            
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD ecbb021
            
            #add-point:AFTER FIELD ecbb021
            
            #END add-point
            
 
         #此段落由子樣板a01產生
         BEFORE FIELD ecbb022
            #add-point:BEFORE FIELD ecbb022
            
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD ecbb022
            
            #add-point:AFTER FIELD ecbb022
            
            #END add-point
            
 
         #Ctrlp:construct.c.page1.ecbb022
         ON ACTION controlp INFIELD ecbb022
            #add-point:ON ACTION controlp INFIELD ecbb022
            
            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD ecbb023
            #add-point:BEFORE FIELD ecbb023
            
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD ecbb023
            
            #add-point:AFTER FIELD ecbb023
            
            #END add-point
            
 
         #Ctrlp:construct.c.page1.ecbb023
         ON ACTION controlp INFIELD ecbb023
            #add-point:ON ACTION controlp INFIELD ecbb023
            
            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD ecbb033
            #add-point:BEFORE FIELD ecbb033
            
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD ecbb033
            
            #add-point:AFTER FIELD ecbb033
            
            #END add-point
            
 
         #Ctrlp:construct.c.page1.ecbb033
         ON ACTION controlp INFIELD ecbb033
            #add-point:ON ACTION controlp INFIELD ecbb033
            
            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD ecbb028
            #add-point:BEFORE FIELD ecbb028
            
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD ecbb028
            
            #add-point:AFTER FIELD ecbb028
            
            #END add-point
            
 
         #Ctrlp:construct.c.page1.ecbb028
         ON ACTION controlp INFIELD ecbb028
            #add-point:ON ACTION controlp INFIELD ecbb028
            
            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD ecbb029
            #add-point:BEFORE FIELD ecbb029
            
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD ecbb029
            
            #add-point:AFTER FIELD ecbb029
            
            #END add-point
            
 
         #Ctrlp:construct.c.page1.ecbb029
         ON ACTION controlp INFIELD ecbb029
            #add-point:ON ACTION controlp INFIELD ecbb029
            
            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD ecbb035
            #add-point:BEFORE FIELD ecbb035
            
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD ecbb035
            
            #add-point:AFTER FIELD ecbb035
            
            #END add-point
            
 
         #Ctrlp:construct.c.page1.ecbb035
         ON ACTION controlp INFIELD ecbb035
            #add-point:ON ACTION controlp INFIELD ecbb035
            
            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD ecbb036
            #add-point:BEFORE FIELD ecbb036
            
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD ecbb036
            
            #add-point:AFTER FIELD ecbb036
            
            #END add-point
            
 
         #Ctrlp:construct.c.page1.ecbb036
         ON ACTION controlp INFIELD ecbb036
            #add-point:ON ACTION controlp INFIELD ecbb036
            
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
 
   
       
      END CONSTRUCT
      
 
      
 
      
      #add-point:cs段add_cs(本段內只能出現新的CONSTRUCT指令)
      CONSTRUCT g_wc3_table1 ON ecbc004,ecbc005,ecbc006,ecbc007,ecbc008,ecbc009,ecbc010
           FROM s_detail2[1].ecbc004,s_detail2[1].ecbc005,s_detail2[1].ecbc006,s_detail2[1].ecbc007,s_detail2[1].ecbc008,s_detail2[1].ecbc009,s_detail2[1].ecbc010                   
         
         BEFORE CONSTRUCT
           # CALL cl_qbe_display_condition(lc_qbe_sn)
            
         ON ACTION controlp INFIELD ecbc004
            
         BEFORE FIELD ecbc004

         AFTER FIELD ecbc004
            
         BEFORE FIELD ecbc005
        
         AFTER FIELD ecbc005
            
         ON ACTION controlp INFIELD ecbc005
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'     #160201-00008#1-add
            LET g_qryparam.reqry = FALSE
            CALL q_imaf001_6()                       #呼叫開窗
            DISPLAY g_qryparam.return1 TO ecbc005  #顯示到畫面上
            NEXT FIELD ecbc005                     #返回原欄位
            
         BEFORE FIELD ecbc006
           
         AFTER FIELD ecbc006
          
         ON ACTION controlp INFIELD ecbc006
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'     #160201-00008#1-add
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.arg1 = "215" 
            CALL q_oocq002()                       #呼叫開窗
            DISPLAY g_qryparam.return1 TO ecbc006  #顯示到畫面上
            NEXT FIELD ecbc006                     #返回原欄位
            
         BEFORE FIELD ecbc007
         
         AFTER FIELD ecbc007
            
         ON ACTION controlp INFIELD ecbc007
           
         ON ACTION controlp INFIELD ecbc008
            
            
         BEFORE FIELD ecbc008
           
         AFTER FIELD ecbc008
        
         BEFORE FIELD ecbc009
          
         AFTER FIELD ecbc009
      
         ON ACTION controlp INFIELD ecbc009
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'     #160201-00008#1-add
            LET g_qryparam.reqry = FALSE
            CALL q_ooca001_1()                      #呼叫開窗
            DISPLAY g_qryparam.return1 TO ecbc009   #顯示到畫面上
            NEXT FIELD ecbc009                      #返回原欄位
            
         ON ACTION controlp INFIELD ecbc010
           
         BEFORE FIELD ecbc010
            
         AFTER FIELD ecbc010
       
      END CONSTRUCT
      
      CONSTRUCT g_wc4_table1 ON ecbd005,ecbd006,ecbd007,ecbd008
           FROM s_detail3[1].ecbd005,s_detail3[1].ecbd006,s_detail3[1].ecbd007,s_detail3[1].ecbd008
           
         BEFORE CONSTRUCT
            #CALL cl_qbe_display_condition(lc_qbe_sn)
            
         BEFORE FIELD ecbd005
        
         AFTER FIELD ecbd005
            
         ON ACTION controlp INFIELD ecbd005
            
         BEFORE FIELD ecbd006
           
         AFTER FIELD ecbd006
          
         ON ACTION controlp INFIELD ecbd006
            
         BEFORE FIELD ecbd007
         
         AFTER FIELD ecbd007
            
         ON ACTION controlp INFIELD ecbd007
           
         ON ACTION controlp INFIELD ecbd008
            
            
         BEFORE FIELD ecbd008
           
         AFTER FIELD ecbd008
       
      END CONSTRUCT
      
INPUT BY NAME wc ATTRIBUTE(WITHOUT DEFAULTS=TRUE)
            BEFORE INPUT
               #CALL aecm200_06(g_ecbb_d,g_ecba_m.*)
               CALL aecm200_wc_init(FALSE)
END INPUT
      #end add-point
 
      BEFORE DIALOG
         CALL cl_qbe_init()
         #add-point:cs段b_dialog
         #為了能讓一開始按查詢後停留在wc進到INPUT BY NAME wc 抓取流程圖
         NEXT FIELD wc    #160513-00029#1  --- add
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
 
 
 
   
   #add-point:cs段結束前
   LET g_wc3 = g_wc3_table1
   LET g_wc4 = g_wc4_table1
   #end add-point    
 
   IF INT_FLAG THEN
      RETURN
   END IF
 
END FUNCTION
 
{</section>}
 
{<section id="aecm200.filter" >}
#+ 此段落由子樣板a50產生
#+ filter過濾功能
PRIVATE FUNCTION aecm200_filter()
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
      CONSTRUCT g_wc_filter ON ecba001,ecba002,ecba003
                          FROM s_browse[1].b_ecba001,s_browse[1].b_ecba002,s_browse[1].b_ecba003
 
         BEFORE CONSTRUCT
               DISPLAY aecm200_filter_parser('ecba001') TO s_browse[1].b_ecba001
            DISPLAY aecm200_filter_parser('ecba002') TO s_browse[1].b_ecba002
            DISPLAY aecm200_filter_parser('ecba003') TO s_browse[1].b_ecba003
      
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
 
      CALL aecm200_filter_show('ecba001')
   CALL aecm200_filter_show('ecba002')
   CALL aecm200_filter_show('ecba003')
 
END FUNCTION
 
{</section>}
 
{<section id="aecm200.filter_parser" >}
#+ filter過濾功能
PRIVATE FUNCTION aecm200_filter_parser(ps_field)
   DEFINE ps_field   STRING
   DEFINE ls_tmp     STRING
   DEFINE li_tmp     LIKE type_t.num10  #161108-00012#1 num5==》num10
   DEFINE li_tmp2    LIKE type_t.num10  #161108-00012#1 num5==》num10
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
 
{<section id="aecm200.filter_show" >}
#+ 顯示過濾條件
PRIVATE FUNCTION aecm200_filter_show(ps_field)
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
   LET ls_condition = aecm200_filter_parser(ps_field)
   IF NOT cl_null(ls_condition) THEN
      LET ls_title = ls_title, '※', ls_condition, '※'
   END IF
 
   #將資料顯示回去
   CALL lnode_item.setAttribute("text",ls_title)
 
END FUNCTION
 
{</section>}
 
{<section id="aecm200.query" >}
#+ 資料查詢QBE功能準備
PRIVATE FUNCTION aecm200_query()
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
   CALL g_ecbb_d.clear()
 
   
   #add-point:query段other
      
   #end add-point   
   
   DISPLAY ' ' TO FORMONLY.idx
   DISPLAY ' ' TO FORMONLY.cnt
   DISPLAY ' ' TO FORMONLY.b_index
   DISPLAY ' ' TO FORMONLY.b_count
   DISPLAY ' ' TO FORMONLY.h_index
   DISPLAY ' ' TO FORMONLY.h_count
   
   CALL aecm200_construct()
 
   IF INT_FLAG THEN
      #取消查詢
      LET INT_FLAG = 0
      LET g_wc = ls_wc
      CALL aecm200_browser_fill("")
      CALL aecm200_fetch("")
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
      CALL aecm200_filter_show('ecba001')
   CALL aecm200_filter_show('ecba002')
   CALL aecm200_filter_show('ecba003')
   CALL aecm200_browser_fill("F")
         
   IF g_browser_cnt = 0 THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code   = "-100" 
      LET g_errparam.popup  = TRUE 
      CALL cl_err()
 
   ELSE
      CALL aecm200_fetch("F") 
   END IF
 
END FUNCTION
 
{</section>}
 
{<section id="aecm200.fetch" >}
#+ 指定PK後抓取單頭其他資料
PRIVATE FUNCTION aecm200_fetch(p_flag)
   DEFINE p_flag     LIKE type_t.chr1
   DEFINE ls_msg     STRING
   #add-point:fetch段define
   DEFINE l_mfg_0002   LIKE type_t.chr1   #160330-00023#1  
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
   #LET g_detail_idx = 1
   IF g_detail_cnt > 0 THEN
      #LET g_detail_idx = 1
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
   
   LET g_ecba_m.ecba001 = g_browser[g_current_idx].b_ecba001
   LET g_ecba_m.ecba002 = g_browser[g_current_idx].b_ecba002
 
   
   #重讀DB,因TEMP有不被更新特性
   #EXECUTE aecm200_master_referesh USING g_ecba_m.ecba001,g_ecba_m.ecba002 INTO g_ecba_m.ecba001,g_ecba_m.ecba002,   #160707-00040#1 mark 
   EXECUTE aecm200_master_referesh USING g_site,g_ecba_m.ecba001,g_ecba_m.ecba002 INTO g_ecba_m.ecba001,g_ecba_m.ecba002,   #160707-00040#1  
       g_ecba_m.ecba003,g_ecba_m.ecba004,g_ecba_m.ecba005,g_ecba_m.ecba006,g_ecba_m.ecba007,g_ecba_m.ecbastus, 
       g_ecba_m.ecbacrtid,g_ecba_m.ecbacrtdp,g_ecba_m.ecbacrtdt,g_ecba_m.ecbaownid,g_ecba_m.ecbaowndp, 
       g_ecba_m.ecbamodid,g_ecba_m.ecbamoddt,g_ecba_m.ecbacnfid,g_ecba_m.ecbacnfdt,g_ecba_m.ecbacrtid_desc, 
       g_ecba_m.ecbacrtdp_desc,g_ecba_m.ecbaownid_desc,g_ecba_m.ecbaowndp_desc,g_ecba_m.ecbamodid_desc, 
       g_ecba_m.ecbacnfid_desc
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "ecba_t" 
      LET g_errparam.code   = SQLCA.sqlcode 
      LET g_errparam.popup  = TRUE 
      CALL cl_err()
 
      INITIALIZE g_ecba_m.* TO NULL
      RETURN
   END IF
   
   #add-point:fetch段action控制
 # IF g_ecba_m.ecbastus = 'N'  THEN
 #    CALL cl_set_act_visible("modify,delete,reproduce", TRUE)
 # ELSE
 #    CALL cl_set_act_visible("modify,delete,reproduce", FALSE)
 # END IF
   CALL cl_get_para(g_enterprise,g_site,'E-MFG-0002') RETURNING l_mfg_0002
   CALL cl_set_act_visible("bom",FALSE)
   IF l_mfg_0002 = 'Y' THEN 
      CALL cl_set_act_visible("bom",TRUE)
   END IF
   #160330-00023#1---add---end
   #end add-point  
   
   
   
   #add-point:fetch結束前

   #end add-point
   
   #保存單頭舊值
   LET g_ecba_m_t.* = g_ecba_m.*
   LET g_ecba_m_o.* = g_ecba_m.*
   
   LET g_data_owner = g_ecba_m.ecbaownid      
   LET g_data_dept  = g_ecba_m.ecbaowndp
   
   #重新顯示   
   CALL aecm200_show()
 
   #CALL aecm200_06(g_ecbb_d,g_ecba_m.*)  #wuxja
   IF NOT cl_null(p_flag) THEN
      CALL aecm200_wc_gen_flow_json(FALSE)
   END IF
END FUNCTION
 
{</section>}
 
{<section id="aecm200.insert" >}
#+ 資料新增
PRIVATE FUNCTION aecm200_insert()
   #add-point:insert段define

   #end add-point    
   
   #清畫面欄位內容
   CLEAR FORM                    
   CALL g_ecbb_d.clear()  
   CALL g_ecbb2_d.clear() 
   CALL g_ecbb3_d.clear() 
   CALL g_ecbb4_d.clear() 
 
 
   #INITIALIZE g_ecba_m.* LIKE ecba_t.*             #DEFAULT 設定  #161124-00048#1  2016/12/13 By 08734 mark
   INITIALIZE g_ecba_m.* TO NULL             #DEFAULT 設定  #161124-00048#1  2016/12/13 By 08734 add
   
   LET g_ecba001_t = NULL
   LET g_ecba002_t = NULL
 
   
   LET g_master_insert = FALSE
   
   CALL s_transaction_begin()
   WHILE TRUE
      #公用欄位給值(單頭)
      #此段落由子樣板a14產生    
      #公用欄位新增給值
      LET g_ecba_m.ecbaownid = g_user
      LET g_ecba_m.ecbaowndp = g_dept
      LET g_ecba_m.ecbacrtid = g_user
      LET g_ecba_m.ecbacrtdp = g_dept 
      LET g_ecba_m.ecbacrtdt = cl_get_current()
      LET g_ecba_m.ecbamodid = ""
      LET g_ecba_m.ecbamoddt = ""
      LET g_ecba_m.ecbastus = "N"
 
 
 
      #append欄位給值
      
     
      #一般欄位給值
            LET g_ecba_m.ecbastus = "N"
 
  
      #add-point:單頭預設值
      CALL g_ecbb2_d.clear()
      CALL g_ecbb3_d.clear()   
      #INITIALIZE g_ecba_m_t.* LIKE ecba_t.*   #161124-00048#1  2016/12/13 By 08734 mark
      INITIALIZE g_ecba_m_t.* TO NULL             #DEFAULT 設定  #161124-00048#1  2016/12/13 By 08734 add
      
      #wuxja
      CALL aecm200_b_fill_text()
      #CALL cl_chart_property_comp("wc", "jsonstring" , "")
      #CALL cl_chart_property_comp("wc", "modify" , "1")
      CASE g_ecba_m.ecbastus
         WHEN "N"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/open.png")
         WHEN "X"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/void.png")
         WHEN "Y"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/valid.png")
         
      END CASE
      
      #CALL aecm200_wc_submit("wc", "station_enable", "true")
      
      #end add-point 
      
      #顯示狀態(stus)圖片
    
      CALL aecm200_input("a")
      
      #add-point:單頭輸入後
      
      CALL aecm200_wc_submit("wc", "station_enable", "false")
      
      #161021-00046#1 --s
      IF NOT INT_FLAG THEN
         LET g_browser_cnt = g_browser_cnt + 1
      END IF
      IF g_browser_cnt = 0 THEN
         CALL cl_set_act_visible("statechange,modify,delete,reproduce", FALSE)
      ELSE
         CALL cl_set_act_visible("statechange,modify,delete,reproduce", TRUE)
      END IF
      #161021-00046#1 --e

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
         INITIALIZE g_ecba_m.* TO NULL
         INITIALIZE g_ecbb_d TO NULL
 
         CALL aecm200_show()
         RETURN
      END IF
      
      LET INT_FLAG = 0
      #CALL g_ecbb_d.clear()
 
 
      LET g_rec_b = 0
      CALL s_transaction_end('Y','0')
      EXIT WHILE
        
   END WHILE
   
   #將新增的資料併入搜尋條件中
   LET g_state = "Y"
   LET g_current_idx = 1 
   
   LET g_ecba001_t = g_ecba_m.ecba001
   LET g_ecba002_t = g_ecba_m.ecba002
   
   LET g_current_idx = g_browser.getLength() + 1
   LET g_browser[g_current_idx].b_ecba001 = g_ecba_m.ecba001
   LET g_browser[g_current_idx].b_ecba002 = g_ecba_m.ecba002
 
   
   LET g_detail_cnt = g_browser.getLength()
   LET g_header_cnt  = g_browser.getLength()
   LET g_browser_cnt = g_browser.getLength()
   DISPLAY g_detail_cnt  TO FORMONLY.h_count    #總筆數
   DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
   CALL cl_navigator_setting(g_current_idx, g_detail_cnt)
   
   LET g_wc = "(",g_wc,  
              " OR ( ecbaent = '" ||g_enterprise|| "' AND ecbasite = '" ||g_site|| "' AND",
              " ecba001 = '", g_ecba_m.ecba001 CLIPPED, "' "
              ," AND ecba002 = '", g_ecba_m.ecba002 CLIPPED, "' "
 
              , ")) "
   
   CLOSE aecm200_cl
   
   CALL aecm200_idx_chk()
   
END FUNCTION
 
{</section>}
 
{<section id="aecm200.modify" >}
#+ 資料修改
PRIVATE FUNCTION aecm200_modify()
   DEFINE l_new_key    DYNAMIC ARRAY OF STRING
   DEFINE l_old_key    DYNAMIC ARRAY OF STRING
   DEFINE l_field_key  DYNAMIC ARRAY OF STRING
   #add-point:modify段define

   #end add-point    
   
   IF g_ecba_m.ecba001 IS NULL
   OR g_ecba_m.ecba002 IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code   = "std-00003" 
      LET g_errparam.popup  = FALSE 
      CALL cl_err()
 
      RETURN
   END IF
 
   #wuxja add
   #EXECUTE aecm200_master_referesh USING g_ecba_m.ecba001,g_ecba_m.ecba002 INTO g_ecba_m.ecba001,g_ecba_m.ecba002,   #160707-00040#1 mark
   EXECUTE aecm200_master_referesh USING g_site,g_ecba_m.ecba001,g_ecba_m.ecba002 INTO g_ecba_m.ecba001,g_ecba_m.ecba002,   #160707-00040#1 
       g_ecba_m.ecba003,g_ecba_m.ecba004,g_ecba_m.ecba005,g_ecba_m.ecba006,g_ecba_m.ecba007,g_ecba_m.ecbastus,g_ecba_m.ecbacrtid,g_ecba_m.ecbacrtdp,g_ecba_m.ecbacrtdt,g_ecba_m.ecbaownid,
       g_ecba_m.ecbaowndp,g_ecba_m.ecbamodid,g_ecba_m.ecbamoddt,g_ecba_m.ecbacnfid,g_ecba_m.ecbacnfdt
 
   #CALL cl_chart_property_comp("wc", "modify" , "1")
   #end
   
   ERROR ""
  
   LET g_ecba001_t = g_ecba_m.ecba001
   LET g_ecba002_t = g_ecba_m.ecba002
 
   CALL s_transaction_begin()
   
   OPEN aecm200_cl USING g_enterprise, g_site,g_ecba_m.ecba001,g_ecba_m.ecba002
   IF STATUS THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "OPEN aecm200_cl:" 
      LET g_errparam.code   = STATUS 
      LET g_errparam.popup  = TRUE 
      CALL cl_err()
 
      CLOSE aecm200_cl
      CALL s_transaction_end('N','0')
      RETURN
   END IF
 
   #顯示最新的資料
   #EXECUTE aecm200_master_referesh USING g_ecba_m.ecba001,g_ecba_m.ecba002 INTO g_ecba_m.ecba001,g_ecba_m.ecba002,  #160707-00040#1 mark 
   EXECUTE aecm200_master_referesh USING g_site,g_ecba_m.ecba001,g_ecba_m.ecba002 INTO g_ecba_m.ecba001,g_ecba_m.ecba002,  #160707-00040#1  
       g_ecba_m.ecba003,g_ecba_m.ecba004,g_ecba_m.ecba005,g_ecba_m.ecba006,g_ecba_m.ecba007,g_ecba_m.ecbastus, 
       g_ecba_m.ecbacrtid,g_ecba_m.ecbacrtdp,g_ecba_m.ecbacrtdt,g_ecba_m.ecbaownid,g_ecba_m.ecbaowndp, 
       g_ecba_m.ecbamodid,g_ecba_m.ecbamoddt,g_ecba_m.ecbacnfid,g_ecba_m.ecbacnfdt,g_ecba_m.ecbacrtid_desc, 
       g_ecba_m.ecbacrtdp_desc,g_ecba_m.ecbaownid_desc,g_ecba_m.ecbaowndp_desc,g_ecba_m.ecbamodid_desc, 
       g_ecba_m.ecbacnfid_desc
 
   #資料被他人LOCK, 或是sql執行時出現錯誤
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = g_ecba_m.ecba001 
      LET g_errparam.code   = SQLCA.sqlcode 
      LET g_errparam.popup  = FALSE 
      CALL cl_err()
 
      CLOSE aecm200_cl
      CALL s_transaction_end('N','0')
      RETURN
   END IF
   
   
   
   #add-point:modify段show之前
   IF g_ecba_m.ecbastus <> 'N' THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'apm-00035'
      LET g_errparam.extend = g_ecba_m.ecbastus
      LET g_errparam.popup = TRUE
      CALL cl_err()

      RETURN
   END IF
   #end add-point  
   
   CALL aecm200_show()
   WHILE TRUE
      LET g_ecba001_t = g_ecba_m.ecba001
      LET g_ecba002_t = g_ecba_m.ecba002
 
      
      #寫入修改者/修改日期資訊(單頭)
      LET g_ecba_m.ecbamodid = g_user 
LET g_ecba_m.ecbamoddt = cl_get_current()
 
      
      #add-point:modify段修改前
 
      #end add-point
      
      #欄位更改
      CALL aecm200_input("u")
 
      #add-point:modify段修改後
      CALL aecm200_wc_submit("wc", "station_enable", "false")
      #end add-point
      
      IF INT_FLAG THEN
         LET INT_FLAG = 0
         LET g_ecba_m.* = g_ecba_m_t.*
         CALL aecm200_show()
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = '' 
         LET g_errparam.code   = 9001 
         LET g_errparam.popup  = FALSE 
         CALL cl_err()
 
         CALL s_transaction_end('N','0')
         EXIT WHILE
      END IF 
      
      #若有modid跟moddt則進行update
      UPDATE ecba_t SET (ecbamodid,ecbamoddt) = (g_ecba_m.ecbamodid,g_ecba_m.ecbamoddt)
       WHERE ecbaent = g_enterprise AND ecbasite = g_site AND ecba001 = g_ecba001_t
         AND ecba002 = g_ecba002_t
 
                  
      #若單頭key欄位有變更
      IF g_ecba_m.ecba001 != g_ecba001_t 
      OR g_ecba_m.ecba002 != g_ecba002_t 
 
      THEN
         CALL s_transaction_begin()
         
         #add-point:單身fk修改前

         #end add-point
         
         #更新單身key值
         UPDATE ecbb_t SET ecbb001 = g_ecba_m.ecba001
                                       ,ecbb002 = g_ecba_m.ecba002
 
          WHERE ecbbent = g_enterprise AND ecbbsite = g_site AND ecbb001 = g_ecba001_t
            AND ecbb002 = g_ecba002_t
 
            
         #add-point:單身fk修改中

         #end add-point
 
         CASE
            WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "ecbb_t" 
               LET g_errparam.code   = "std-00009" 
               LET g_errparam.popup  = TRUE 
               CALL cl_err()
 
               CALL s_transaction_end('N','0')
               CONTINUE WHILE
            WHEN SQLCA.sqlcode #其他錯誤
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "ecbb_t" 
               LET g_errparam.code   = SQLCA.sqlcode 
               LET g_errparam.popup  = TRUE 
               CALL cl_err()
 
               CALL s_transaction_end('N','0')
               CONTINUE WHILE
         END CASE
         
         #add-point:單身fk修改後
         UPDATE ecbc_t SET ecbc001 = g_ecba_m.ecba001,
                           ecbc002 = g_ecba_m.ecba002
          WHERE ecbcent = g_enterprise 
            AND ecbcsite = g_site
            AND ecbc001 = g_ecba001_t
            AND ecbc002 = g_ecba002_t
         IF SQLCA.sqlcode THEN
             INITIALIZE g_errparam TO NULL
             LET g_errparam.code = SQLCA.sqlcode
             LET g_errparam.extend = ""
             LET g_errparam.popup = TRUE
             CALL cl_err()
 
             CALL s_transaction_end('N','0')
             CONTINUE WHILE
         END IF
         
         UPDATE ecbd_t SET ecbd001 = g_ecba_m.ecba001,
                           ecbd002 = g_ecba_m.ecba002
          WHERE ecbdent = g_enterprise 
            AND ecbdsite = g_site
            AND ecbd001 = g_ecba001_t
            AND ecbd002 = g_ecba002_t
         IF SQLCA.sqlcode THEN
             INITIALIZE g_errparam TO NULL
             LET g_errparam.code = SQLCA.sqlcode
             LET g_errparam.extend = ""
             LET g_errparam.popup = TRUE
             CALL cl_err()
 
             CALL s_transaction_end('N','0')
             CONTINUE WHILE
         END IF
         #end add-point
         
 
         
 
         
         #UPDATE 多語言table key值
         
 
         CALL s_transaction_end('Y','0')
      END IF
    
      EXIT WHILE
   END WHILE
 
   #修改歷程記錄
   #IF NOT cl_log_modified_record(g_ecba_m.ecba001,g_site) THEN 
   #   CALL s_transaction_end('N','0')
   #END IF
 
   CLOSE aecm200_cl
   CALL s_transaction_end('Y','0')
 
   #流程通知預埋點-U
   CALL cl_flow_notify(g_ecba_m.ecba001,'U')
 
END FUNCTION   
 
{</section>}
 
{<section id="aecm200.input" >}
#+ 資料輸入
PRIVATE FUNCTION aecm200_input(p_cmd)
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
   DEFINE  l_n1                  LIKE type_t.num5
   DEFINE  l_sql                 STRING
   DEFINE  l_success             LIKE type_t.num5
   DEFINE  l_ecbfseq             LIKE ecbf_t.ecbfseq
  # DEFINE  l_ecab                RECORD LIKE ecab_t.*  #161124-00048#1  16/12/06 By 08734 mark
   #161124-00048#1  16/12/06 By 08734 add(S)
   DEFINE l_ecab RECORD  #製程作業預設Check in/Check out項目檔
       ecabent LIKE ecab_t.ecabent, #企业编号
       ecabownid LIKE ecab_t.ecabownid, #资料所有者
       ecabowndp LIKE ecab_t.ecabowndp, #资料所有部门
       ecabcrtid LIKE ecab_t.ecabcrtid, #资料录入者
       ecabcrtdp LIKE ecab_t.ecabcrtdp, #资料录入部门
       ecabcrtdt LIKE ecab_t.ecabcrtdt, #资料创建日
       ecabmodid LIKE ecab_t.ecabmodid, #资料更改者
       ecabmoddt LIKE ecab_t.ecabmoddt, #最近更改日
       ecabstus LIKE ecab_t.ecabstus, #状态码
       ecab001 LIKE ecab_t.ecab001, #作业编号
       ecabseq LIKE ecab_t.ecabseq, #项序
       ecab002 LIKE ecab_t.ecab002, #check in/check out
       ecab003 LIKE ecab_t.ecab003, #项目
       ecab004 LIKE ecab_t.ecab004, #形态
       ecab005 LIKE ecab_t.ecab005, #下限
       ecab006 LIKE ecab_t.ecab006, #上限
       ecab007 LIKE ecab_t.ecab007, #默认值
       ecab008 LIKE ecab_t.ecab008 #必要
END RECORD
#161124-00048#1  16/12/06 By 08734 add(E)
   DEFINE  l_flag                LIKE type_t.chr1    #add by wuxja
   DEFINE  l_n2                  LIKE type_t.chr2    #add by wuxja
   DEFINE  l_n4                  LIKE type_t.num5    #add by wuxja
   DEFINE  l_sys                 LIKE type_t.num5    #add by wuxja
  # DEFINE  l_ecbb                RECORD LIKE ecbb_t.*#add by wuxja  #161124-00048#1  16/12/06 By 08734 mark
   #161124-00048#1  16/12/06 By 08734 add(S)
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
#161124-00048#1  16/12/06 By 08734 add(E)
   DEFINE  wc_i                  INTEGER             #add by wuxja
   DEFINE  qryText               STRING              #add by wuxja
   DEFINE  json                  util.JSONObject     #add by wuxja
   DEFINE  jsonArray             util.JSONArray      #add by wuxja
   DEFINE  json_t                util.JSONObject     #add by wuxja
   DEFINE  jsonstring            STRING              #add by wuxja
   DEFINE  json_ecbb             type_g_ecbb_d       #add by wuxja
   DEFINE  l_wc_str              STRING              #add by wuxja
   DEFINE  li_workchg            BOOLEAN             #add by wuxja
   DEFINE  l_n3                  LIKE type_t.num5
   DEFINE  l_ecba001_t           LIKE ecba_t.ecba001,
           l_ecba002_t           LIKE ecba_t.ecba002
   DEFINE  l_ecbb003             LIKE ecbb_t.ecbb003,
           l_ecbb004             LIKE ecbb_t.ecbb004,
           l_ecbb005             LIKE ecbb_t.ecbb005,
           l_ecbb006             LIKE ecbb_t.ecbb006,
           l_ecbb007             LIKE ecbb_t.ecbb007,
           l_ecbb008             LIKE ecbb_t.ecbb008,
           l_ecbb009             LIKE ecbb_t.ecbb009,
           l_ecbeseq             LIKE ecbe_t.ecbeseq,
           l_ecbe004             LIKE ecbe_t.ecbe004,
           l_ecbe005             LIKE ecbe_t.ecbe005
   DEFINE  l_json_obj            util.JSONObject,
           l_json_params         util.JSONObject
   DEFINE  l_json_upd            RECORD
               old_id               STRING,
               new_id               STRING,
               new_label            STRING,
               new_desc             STRING,
               params               RECORD  #自定的參數，在WebComponent中會無條件回傳
                  ecbb003              LIKE ecbb_t.ecbb003
                                    END RECORD
                                 END RECORD
   DEFINE  l_group               t_group
   DEFINE  l_seq                 INTEGER
   #add--151215-00002#4 By shiun--(S)
   DEFINE  l_n5                  LIKE type_t.num5
   DEFINE  l_count_chk           LIKE type_t.num5
   #add--151215-00002#4 By shiun--(E)
   #end add-point  
 
   #先做狀態判定
   IF p_cmd = 'r' THEN
      LET l_cmd_t = 'r'
      LET p_cmd   = 'a'
   ELSE
      LET l_cmd_t = p_cmd
   END IF   
   
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
   LET g_forupd_sql = "SELECT ecbb003,ecbb004,ecbb005,ecbb006,ecbb007,ecbb008,ecbb009,ecbb010,ecbb011, 
       ecbb012,ecbb037,ecbb038,ecbb024,ecbb025,ecbb026,ecbb027,ecbb034,ecbb013,ecbb014,ecbb015,ecbb016,ecbb017,ecbb018, 
       ecbb019,ecbb020,ecbb030,ecbb031,ecbb032,ecbb021,ecbb022,ecbb023,ecbb033,ecbb028,ecbb029,ecbb035, 
       ecbb036 FROM ecbb_t WHERE ecbbent=? AND ecbbsite=? AND ecbb001=? AND ecbb002=? AND ecbb003=?  
       FOR UPDATE"
   #add-point:input段define_sql

   #end add-point 
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE aecm200_bcl CURSOR FROM g_forupd_sql
   
 
   
 
 
   #add-point:input段define_sql
 
   #end add-point 
 
   LET l_allow_insert = cl_auth_detail_input("insert")
   LET l_allow_delete = cl_auth_detail_input("delete")
   LET g_qryparam.state = 'i'
   
   #控制key欄位可否輸入
   CALL aecm200_set_entry(p_cmd)
   #add-point:set_entry後
   LET g_forupd_sql = "SELECT ecbc004,ecbc005,'','',ecbc006,'',ecbc007,ecbc008,ecbc009,ecbc010 FROM ecbc_t WHERE ecbcent=? AND ecbcsite=? AND ecbc001=? AND ecbc002=? AND ecbc003=? AND ecbc004=? FOR UPDATE"
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)
   DECLARE aecm200_bcl2 CURSOR FROM g_forupd_sql
   
   LET g_forupd_sql = "SELECT ecbd005,ecbd006,ecbd007,ecbd008 FROM ecbd_t WHERE ecbdent=? AND ecbdsite=? AND ecbd001=? AND ecbd002=? AND ecbd003=? AND ecbd004=? AND ecbd005=? FOR UPDATE"
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)
   DECLARE aecm200_bcl3 CURSOR FROM g_forupd_sql
   #end add-point
   CALL aecm200_set_no_entry(p_cmd)
 
   DISPLAY BY NAME g_ecba_m.ecba001,g_ecba_m.ecba002,g_ecba_m.ecba003,g_ecba_m.ecba004,g_ecba_m.ecba005, 
       g_ecba_m.ecba006,g_ecba_m.ecba007,g_ecba_m.ecbastus,g_ecba_m.ooeb013
   
   LET lb_reproduce = FALSE
   
   #add-point:資料輸入前
   LET g_errshow = 1 
   LET l_flag = 'Y'
   CALL aecm200_wc_submit("wc", "station_enable", "true")
   WHILE TRUE
   #end add-point
   
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
   
 
{</section>}
 
{<section id="aecm200.input.head" >}
      #單頭段
      INPUT BY NAME g_ecba_m.ecba001,g_ecba_m.ecba002,g_ecba_m.ecba003,g_ecba_m.ecba004,g_ecba_m.ecba005, 
          g_ecba_m.ecba006,g_ecba_m.ecba007,g_ecba_m.ecbastus,g_ecba_m.ooeb013,wc
         ATTRIBUTE(WITHOUT DEFAULTS)
         
         #自訂ACTION(master_input)
#刪除節點
         #如果是新增狀態，直接結果單頭新增
         BEFORE FIELD wc
         
         ON ACTION wc_delete_node
            
            LET l_json_obj = util.JSONObject.parse(wc)
            CALL aecm200_wc_parse_id(l_json_obj.get("id")) RETURNING l_ecbb004, l_ecbb005
            LET l_json_params = l_json_obj.get("params")
            LET l_ecbb003 = l_json_params.get("ecbb003")
            IF cl_null(l_ecbb003)  THEN
               CONTINUE DIALOG
            END IF
            CALL s_transaction_begin()
            
            IF l_ecbb004 != "INIT" AND l_ecbb004 != "END" THEN
               DELETE FROM ecbb_t 
                   WHERE ecbbent  = g_enterprise 
                      AND ecbbsite = g_site
                      AND ecbb001  = g_ecba_m.ecba001
                      AND ecbb002  = g_ecba_m.ecba002
                      AND ecbb003  = l_ecbb003
                      AND ecbb004  = l_ecbb004
                      AND ecbb005  = l_ecbb005
               IF SQLCA.sqlcode THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = 'delete ecbb_t:' 
                  LET g_errparam.code   = SQLCA.sqlcode 
                  LET g_errparam.popup  = TRUE 
                  CALL cl_err()
                  CALL s_transaction_end('N','0')
                  CONTINUE DIALOG
               END IF
            END IF
            
            
            #更新相關工作站的上站
            UPDATE ecbb_t SET ecbb008 = NULL, ecbb009 = NULL
                 WHERE ecbbent  = g_enterprise 
                   AND ecbbsite = g_site
                   AND ecbb001  = g_ecba_m.ecba001
                   AND ecbb002  = g_ecba_m.ecba002
                   AND ecbb008  = l_ecbb004
                   AND ecbb009  = l_ecbb005
            IF SQLCA.sqlcode THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = 'update ecbb_t:' 
               LET g_errparam.code   = SQLCA.sqlcode 
               LET g_errparam.popup  = TRUE 
               CALL cl_err()
               CALL s_transaction_end('N','0')
               CONTINUE DIALOG
            END IF
            
            #更新相關工作站的下站
            UPDATE ecbb_t SET ecbb010 = NULL, ecbb011 = NULL
                WHERE ecbbent = g_enterprise
                  AND ecbbsite = g_site
                  AND ecbb001 = g_ecba_m.ecba001
                  AND ecbb002 = g_ecba_m.ecba002
                  AND ecbb010 = l_ecbb004
                  AND ecbb011 = l_ecbb005
            IF SQLCA.sqlcode THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = 'update ecbb_t:' 
               LET g_errparam.code   = SQLCA.sqlcode 
               LET g_errparam.popup  = TRUE 
               CALL cl_err()
               CALL s_transaction_end('N','0')
               CONTINUE DIALOG
            END IF
            
            #刪除上站資料
            DELETE FROM ecbe_t
              WHERE ecbeent = g_enterprise 
                AND ecbesite = g_site 
                AND ecbe001 = g_ecba_m.ecba001 
                AND ecbe002 = g_ecba_m.ecba002 
                AND ecbe003 = l_ecbb003
             IF SQLCA.sqlcode THEN
                INITIALIZE g_errparam TO NULL
                LET g_errparam.code = SQLCA.sqlcode
                LET g_errparam.extend = "ecbe_t"
                LET g_errparam.popup = TRUE
                CALL cl_err()
                CALL s_transaction_end('N','0')
                CONTINUE DIALOG
             END IF
 
             DELETE FROM ecbf_t
              WHERE ecbfent = g_enterprise 
                AND ecbfsite = g_site 
                AND ecbf001 = g_ecba_m.ecba001 
                AND ecbf002 = g_ecba_m.ecba002 
                AND ecbf003 = l_ecbb003
             IF SQLCA.sqlcode THEN
                INITIALIZE g_errparam TO NULL
                LET g_errparam.code = SQLCA.sqlcode
                LET g_errparam.extend = "ecbf_t"
                LET g_errparam.popup = TRUE
                CALL cl_err()
                CALL s_transaction_end('N','0')
                CONTINUE DIALOG  
             END IF
             
             DELETE FROM ecbg_t
              WHERE ecbgent = g_enterprise 
                AND ecbgsite = g_site 
                AND ecbg001 = g_ecba_m.ecba001 
                AND ecbg002 = g_ecba_m.ecba002 
                AND ecbg003 = l_ecbb003
             IF SQLCA.sqlcode THEN
                INITIALIZE g_errparam TO NULL
                LET g_errparam.code = SQLCA.sqlcode
                LET g_errparam.extend = "ecbg_t"
                LET g_errparam.popup = TRUE
                CALL cl_err()
                CALL s_transaction_end('N','0')
                CONTINUE DIALOG
             END IF
             CALL s_transaction_end('Y','0')
             
         ON ACTION wc_init_finish
            IF l_cmd_t == "a" THEN
               NEXT FIELD ecba001
            END IF
         
         ON ACTION wc_flow_init
            CALL aecm200_wc_init(TRUE)
         
         #刪除群組
         ON ACTION wc_delete_group
            INITIALIZE l_group TO NULL
            
            LET l_ecbb007 = wc
            
            CALL s_transaction_begin()
            UPDATE ecbb_t SET ecbb006 = 1, ecbb007 = NULL
                WHERE ecbbent = g_enterprise
                  AND ecbbsite = g_site
                  AND ecbb001 = g_ecba_m.ecba001
                  AND ecbb002 = g_ecba_m.ecba002
                  AND ecbb006 = l_ecbb006
 
            IF SQLCA.sqlcode THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = 'update ecbb_t:' 
               LET g_errparam.code   = SQLCA.sqlcode 
               LET g_errparam.popup  = TRUE 
               CALL cl_err()
               CALL s_transaction_end('N','0')
               CONTINUE DIALOG
            END IF
            CALL s_transaction_end('Y','0')
 
            
         #新增群組
         ON ACTION wc_add_group
            LET l_json_obj = util.JSONObject.parse(wc)
            
         #新增節點
         ON ACTION wc_add_node 
            LET l_json_obj = util.JSONObject.parse(wc)
 
            #已經有存在INIT或END節點時，就取消新增
            IF l_json_obj.get("label") == "INIT" OR l_json_obj.get("label") == "END" THEN
            #   IF aecm200_wc_init_end_exist(l_json_obj.get("label")) THEN
            #       CALL aecm200_wc_submit("wc", "station_del_node", l_json_obj.get("id"))
            #   ELSE 
                 INITIALIZE l_json_upd TO NULL
                 LET l_json_upd.old_id = l_json_obj.get("id")
                 LET l_json_upd.new_id = l_json_obj.get("label")
                 LET l_json_upd.new_label = l_json_obj.get("label")
                 LET l_json_upd.new_desc = NULL
                 #20101113 by wuxja  add  --begin--
                 IF l_json_obj.get("label") == "INIT" THEN
                    LET g_ecba_m.ecba004 = l_json_obj.get("left")
                    LET g_ecba_m.ecba005 = l_json_obj.get("top")
                 END IF
                 IF l_json_obj.get("label") == "END" THEN
                    LET g_ecba_m.ecba006 = l_json_obj.get("left")
                    LET g_ecba_m.ecba007 = l_json_obj.get("top")
                 END IF
                 #20151113 by wuxja  add  --end--
                 CALL aecm200_wc_submit("wc","station_update_node",util.JSON.stringify(l_json_upd))  
            #   END IF
            ELSE
               #初始化一筆ecbb_t.*
               CALL aecm200_wc_add_node(l_json_obj) RETURNING l_ecbb.*
               
               #如果沒有選擇ecbb004，則刪除使用者自己新增的節點
               IF cl_null(l_ecbb.ecbb004) THEN
                  CALL aecm200_wc_submit("wc", "station_del_node", l_json_obj.get("id"))
                  CONTINUE DIALOG
               END IF
               
               #WebComponent會自行先建立id，所以選擇了ecbb004之後通知WebComponent更新id
               #170105-00055#1--add--start--
               IF cl_null(g_rtn_fields[1]) THEN
                  LET g_rtn_fields[1]='-'
               END IF
               #170105-00055#1--add--end----
               LET l_seq = l_ecbb.ecbb005   
               LET l_ecbb.ecbb005 = l_seq   
               INITIALIZE l_json_upd TO NULL            
               LET l_json_upd.old_id = l_json_obj.get("id")
               LET l_json_upd.new_id = SFMT("%1__%2", l_ecbb.ecbb004 CLIPPED,l_seq CLIPPED)
               LET l_json_upd.new_label = g_rtn_fields[1]
               LET l_json_upd.new_desc = l_ecbb.ecbb004
               LET l_json_upd.params.ecbb003 = l_ecbb.ecbb003               
               CALL aecm200_wc_submit("wc","station_update_node",util.JSON.stringify(l_json_upd))  
               
               #INSERT INTO ecbb_t VALUES(l_ecbb.*)  #161124-00048#1  16/12/06 By 08734 mark
               INSERT INTO ecbb_t(ecbbent,ecbbsite,ecbb001,ecbb002,ecbb003,ecbb004,ecbb005,ecbb006,ecbb007,ecbb008,ecbb009,ecbb010,ecbb011,ecbb012,ecbb013,ecbb014,ecbb015,ecbb016,ecbb017,ecbb018,ecbb019,ecbb020,ecbb021,ecbb022,ecbb023,ecbb024,ecbb025,ecbb026,ecbb027,ecbb028,ecbb029,ecbb030,ecbb031,ecbb032,ecbb033,ecbb034,ecbb035,ecbb036,ecbb037,ecbb038)  #161124-00048#1  16/12/06 By 08734 add
                  VALUES(l_ecbb.ecbbent,l_ecbb.ecbbsite,l_ecbb.ecbb001,l_ecbb.ecbb002,l_ecbb.ecbb003,l_ecbb.ecbb004,l_ecbb.ecbb005,l_ecbb.ecbb006,l_ecbb.ecbb007,l_ecbb.ecbb008,l_ecbb.ecbb009,l_ecbb.ecbb010,l_ecbb.ecbb011,l_ecbb.ecbb012,l_ecbb.ecbb013,l_ecbb.ecbb014,l_ecbb.ecbb015,l_ecbb.ecbb016,l_ecbb.ecbb017,l_ecbb.ecbb018,l_ecbb.ecbb019,l_ecbb.ecbb020,l_ecbb.ecbb021,l_ecbb.ecbb022,l_ecbb.ecbb023,l_ecbb.ecbb024,l_ecbb.ecbb025,l_ecbb.ecbb026,l_ecbb.ecbb027,l_ecbb.ecbb028,l_ecbb.ecbb029,l_ecbb.ecbb030,l_ecbb.ecbb031,l_ecbb.ecbb032,l_ecbb.ecbb033,l_ecbb.ecbb034,l_ecbb.ecbb035,l_ecbb.ecbb036,l_ecbb.ecbb037,l_ecbb.ecbb038)
               CALL aecm200_b_fill()
            END IF            
 
         #新增連結線
         ON ACTION wc_add_connect
 
            #新增狀態下，直接更新db
            #160728-00002 by whitney mark start
            #CALL s_transaction_begin()
            #IF l_cmd_t == "a" THEN
            #160728-00002 by whitney mark end
               #20151111 by wuxja add   --begin--
               #初始化变量
               LET l_ecbb008 = ''
               LET l_ecbb009 = ''
               LET l_ecbb004 = ''
               LET l_ecbb005 = ''
               LET l_ecbb003 = ''
               LET l_ecbeseq = ''
               #20151111 by wuxja add   --end--
               LET l_json_obj = util.JSONObject.parse(wc)
               CALL aecm200_wc_parse_id(l_json_obj.get("sourceId")) RETURNING l_ecbb008, l_ecbb009
               CALL aecm200_wc_parse_id(l_json_obj.get("targetId")) RETURNING l_ecbb004, l_ecbb005
               SELECT ecbb003 INTO l_ecbb003 FROM ecbb_t
                  WHERE ecbbent = g_enterprise
                    AND ecbbsite = g_site
                    AND ecbb001 = g_ecba_m.ecba001
                    AND ecbb002 = g_ecba_m.ecba002
                    AND ecbb004 = l_ecbb004
                    AND ecbb005 = l_ecbb005
               IF NOT cl_null(l_ecbb003) THEN   #20151111 by wuxja add
                  SELECT COUNT(*) + 1 INTO l_ecbeseq FROM ecbe_t 
                     WHERE ecbeent = g_enterprise
                       AND ecbesite = g_site
                       AND ecbe001 = g_ecba_m.ecba001
                       AND ecbe002 = g_ecba_m.ecba002
                       AND ecbe003 = l_ecbb003
                  INSERT INTO ecbe_t (ecbeent,ecbesite,ecbe001,ecbe002,ecbe003,ecbeseq,ecbe004,ecbe005)
                     VALUES (g_enterprise, g_site, g_ecba_m.ecba001, g_ecba_m.ecba002, l_ecbb003, l_ecbeseq, l_ecbb008, l_ecbb009)
                  IF SQLCA.sqlcode THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = 'insert ecbe_t:' 
                     LET g_errparam.code   = SQLCA.sqlcode 
                     LET g_errparam.popup  = TRUE 
                     CALL cl_err()
                     CALL s_transaction_end('N','0')
                     CONTINUE DIALOG
                  END IF
                  IF l_ecbeseq > 1 THEN
                     UPDATE ecbb_t SET ecbb008 = 'MULT' , ecbb009 = 0
                        WHERE ecbbent = g_enterprise
                          AND ecbbsite = g_site
                          AND ecbb001 = g_ecba_m.ecba001
                          AND ecbb002 = g_ecba_m.ecba002
                          AND ecbb003 = l_ecbb003
                          AND ecbb004 = l_ecbb004
                          AND ecbb005 = l_ecbb005
                     IF SQLCA.sqlcode THEN
                        INITIALIZE g_errparam TO NULL 
                        LET g_errparam.extend = 'update ecbb_t:' 
                        LET g_errparam.code   = SQLCA.sqlcode 
                        LET g_errparam.popup  = TRUE 
                        CALL cl_err()
                        CALL s_transaction_end('N','0')
                        CONTINUE DIALOG
                     END IF
                  ELSE
                     UPDATE ecbb_t SET ecbb008 = l_ecbb008 , ecbb009 = l_ecbb009
                        WHERE ecbbent = g_enterprise
                          AND ecbbsite = g_site
                          AND ecbb001 = g_ecba_m.ecba001
                          AND ecbb002 = g_ecba_m.ecba002
                          AND ecbb003 = l_ecbb003
                          AND ecbb004 = l_ecbb004
                          AND ecbb005 = l_ecbb005
                     IF SQLCA.sqlcode THEN
                        INITIALIZE g_errparam TO NULL 
                        LET g_errparam.extend = 'update ecbb_t:' 
                        LET g_errparam.code   = SQLCA.sqlcode 
                        LET g_errparam.popup  = TRUE 
                        CALL cl_err()
                        CALL s_transaction_end('N','0')
                        CONTINUE DIALOG
                     END IF
                  END IF
                  #20151112 by wuxja add  --begin--
                  IF NOT aecm200_return_ecbb_mult() THEN
                     CALL s_transaction_end('N','0')
                  END IF
                  #20151112 by wuxja add  --end--
               END IF   #20151111 by wuxja  add 
            #160728-00002 by whitney mark start
            #END IF
            #CALL s_transaction_end('Y',0)
            #160728-00002 by whitney mark end
            
         #刪除連結線
         ON ACTION wc_del_connect
 
            #新增狀態下，直接更新db
            #160728-00002 by whitney mark start
            #CALL s_transaction_begin()
            #IF l_cmd_t == "a" THEN
            #160728-00002 by whitney mark end
               LET l_json_obj = util.JSONObject.parse(wc)
               CALL aecm200_wc_parse_id(l_json_obj.get("sourceId")) RETURNING l_ecbb008, l_ecbb009
               CALL aecm200_wc_parse_id(l_json_obj.get("targetId")) RETURNING l_ecbb004, l_ecbb005
               SELECT ecbb003 INTO l_ecbb003 FROM ecbb_t
                  WHERE ecbbent = g_enterprise
                    AND ecbbsite = g_site
                    AND ecbb001 = g_ecba_m.ecba001
                    AND ecbb002 = g_ecba_m.ecba002
                    AND ecbb004 = l_ecbb004
                    AND ecbb005 = l_ecbb005
               DELETE FROM ecbe_t 
                  WHERE ecbeent = g_enterprise
                    AND ecbesite = g_site                
                    AND ecbe001 = g_ecba_m.ecba001                
                    AND ecbe002 = g_ecba_m.ecba002                
                    AND ecbe003 = l_ecbb003                
                    AND ecbe004 = l_ecbb008                
                    AND ecbe005 = l_ecbb009                
               IF SQLCA.sqlcode THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = 'delete ecbb_t:' 
                  LET g_errparam.code   = SQLCA.sqlcode 
                  LET g_errparam.popup  = TRUE 
                  CALL cl_err()
                  CALL s_transaction_end('N','0')
                  CONTINUE DIALOG
               END IF
               SELECT COUNT(*) INTO l_ecbeseq FROM ecbe_t 
                  WHERE ecbeent = g_enterprise
                    AND ecbesite = g_site
                    AND ecbe001 = g_ecba_m.ecba001
                    AND ecbe002 = g_ecba_m.ecba002
                    AND ecbe003 = l_ecbb003
               IF l_ecbeseq == 1 THEN
                  SELECT ecbe004, ecbe005 INTO l_ecbe004, l_ecbe005 FROM ecbe_t
                     WHERE ecbeent = g_enterprise
                       AND ecbesite = g_site
                       AND ecbe001 = g_ecba_m.ecba001
                       AND ecbe002 = g_ecba_m.ecba002
                       AND ecbe003 = l_ecbb003
                  UPDATE ecbb_t SET ecbb008 = l_ecbe004 , ecbb009 = l_ecbe005
                     WHERE ecbbent = g_enterprise
                       AND ecbbsite = g_site
                       AND ecbb001 = g_ecba_m.ecba001
                       AND ecbb002 = g_ecba_m.ecba002
                       AND ecbb003 = l_ecbb003
                       AND ecbb004 = l_ecbb004
                       AND ecbb005 = l_ecbb005
                  IF SQLCA.sqlcode THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = 'delete ecbb_t:' 
                     LET g_errparam.code   = SQLCA.sqlcode 
                     LET g_errparam.popup  = TRUE 
                     CALL cl_err()
                     CALL s_transaction_end('N','0')
                     CONTINUE DIALOG
                  END IF
               END IF
               IF l_ecbeseq == 0 THEN
                  UPDATE ecbb_t SET ecbb008 = NULL , ecbb009 = NULL
                     WHERE ecbbent = g_enterprise
                       AND ecbbsite = g_site
                       AND ecbb001 = g_ecba_m.ecba001
                       AND ecbb002 = g_ecba_m.ecba002
                       AND ecbb003 = l_ecbb003
                       AND ecbb004 = l_ecbb004
                       AND ecbb005 = l_ecbb005
                  IF SQLCA.sqlcode THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = 'delete ecbb_t:' 
                     LET g_errparam.code   = SQLCA.sqlcode 
                     LET g_errparam.popup  = TRUE 
                     CALL cl_err()
                     CALL s_transaction_end('N','0')
                     CONTINUE DIALOG
                  END IF
               END IF
            #160728-00002 by whitney mark start
            #END IF
            #CALL s_transaction_end('Y',0)
            #160728-00002 by whitney mark end
            
         #更新坐標
         ON ACTION wc_position
            IF p_cmd != "a" THEN
               CALL aecm200_wc_update_pos(wc)
            END IF
         
         #重新選擇工作站         
         ON ACTION wc_edit_node
            IF NOT cl_null(wc) THEN
               CALL aecm200_wc_edit_node(wc)
            END IF
            
         ON ACTION wc_select_node
            CALL aecm200_wc_parse_id(wc) RETURNING l_ecbb004, l_ecbb005
            LET l_ac = aecm200_arr_curr(l_ecbb004, l_ecbb005)
            CALL DIALOG.setCurrentRow("s_detail1", l_ac)
            CALL aecm200_b_fill_value(l_ecbb004, l_ecbb005)
         #WebComponent回傳資料，更新製程圖
         ON ACTION wc_get_data
            CALL aecm200_wc_save_data(wc)
            accept dialog
     
         BEFORE INPUT
            IF s_transaction_chk("N",0) THEN
               CALL s_transaction_begin()
            END IF
            
            IF l_cmd_t = 'r' THEN
               
            END IF
            #add-point:資料輸入前
            IF NOT l_cmd_t == "a" AND NOT l_cmd_t == "u"  THEN
               #CALL aecm200_06(g_ecbb_d,g_ecba_m.*)
               IF g_action_choice != "accept" THEN
                  CALL aecm200_wc_gen_flow_json(FALSE)
               END IF
            END IF

            #end add-point
 
                  #此段落由子樣板a02產生
         AFTER FIELD ecba001
            
            #add-point:AFTER FIELD ecba001
            #此段落由子樣板a05產生
            IF cl_null(g_ecba_m.ecba001) THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "" 
               LET g_errparam.code   = "adz-00255" 
               LET g_errparam.popup  = FALSE
               CALL cl_err()
               NEXT FIELD ecba001
            END IF

            CALL aecm200_desc()
            IF NOT cl_null(g_ecba_m.ecba001) AND NOT cl_null(g_ecba_m.ecba002) THEN 
               IF p_cmd = 'a' OR ( p_cmd = 'u' AND ( p_cmd = 'u' AND (g_ecba_m.ecba001 != g_ecba001_t  OR g_ecba_m.ecba002 != g_ecba002_t ))) THEN 
                  IF NOT ap_chk_notDup(g_ecba_m.ecba001,"SELECT COUNT(*) FROM ecba_t WHERE "||"ecbaent = '" ||g_enterprise|| "' AND ecbasite = '" ||g_site|| "' AND "||"ecba001 = '"||g_ecba_m.ecba001 ||"' AND "|| "ecba002 = '"||g_ecba_m.ecba002 ||"'",'std-00004',0) THEN 
                     LET g_ecba_m.ecba001 = g_ecba_m_t.ecba001
                     CALL aecm200_desc()
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF
            IF NOT cl_null(g_ecba_m.ecba001) THEN
               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
               INITIALIZE g_chkparam.* TO NULL

               #設定g_chkparam.*的參數
               LET g_chkparam.arg1 = g_ecba_m.ecba001

               #呼叫檢查存在並帶值的library
               IF NOT cl_chk_exist("v_imaf001_1") THEN
                  LET g_ecba_m.ecba001 = g_ecba_m_t.ecba001
                  CALL aecm200_desc()
                  NEXT FIELD ecba001
               END IF
            END IF
            IF NOT cl_null(g_ecba_m.ecba001) AND NOT cl_null(g_ecba_m.ecba002) THEN
               CALL aecm200_wc_submit("wc", "station_enable", "true")
            END IF
            
            #如果又回去修改單頭，必須連同所有單身都UPDATE，以免造成新加入的單身資料變垃圾
            IF NOT cl_null(l_ecba001_t) AND NOT cl_null(g_ecba_m.ecba001) AND NOT cl_null(g_ecba_m.ecba002) THEN
               CALL s_transaction_begin()
               
               UPDATE ecbb_t SET ecbb001 = g_ecba_m.ecba001,
                                 ecbb002 = g_ecba_m.ecba002
                  WHERE ecbbent = g_enterprise
                    AND ecbbsite = g_site
                    AND ecbb001 = l_ecba001_t
                    AND ecbb002 = g_ecba_m.ecba002
               IF SQLCA.sqlcode THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = 'update ecbb_t:' 
                  LET g_errparam.code   = SQLCA.sqlcode 
                  LET g_errparam.popup  = TRUE 
                  CALL cl_err()
                  CALL s_transaction_end('N',0)
                  CONTINUE DIALOG
               END IF
               UPDATE ecbc_t SET ecbc001 = g_ecba_m.ecba001,
                                 ecbc002 = g_ecba_m.ecba002
                  WHERE ecbcent = g_enterprise
                    AND ecbcsite = g_site
                    AND ecbc001 = l_ecba001_t
                    AND ecbc002 = g_ecba_m.ecba002
               IF SQLCA.sqlcode THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = 'update ecbc_t:' 
                  LET g_errparam.code   = SQLCA.sqlcode 
                  LET g_errparam.popup  = TRUE 
                  CALL cl_err()
                  CALL s_transaction_end('N',0)
                  CONTINUE DIALOG
               END IF
               
               UPDATE ecbd_t SET ecbd001 = g_ecba_m.ecba001,
                                 ecbd002 = g_ecba_m.ecba002
                  WHERE ecbdent = g_enterprise
                    AND ecbdsite = g_site
                    AND ecbd001 = l_ecba001_t
                    AND ecbd002 = g_ecba_m.ecba002
               IF SQLCA.sqlcode THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = 'update ecbd_t:' 
                  LET g_errparam.code   = SQLCA.sqlcode 
                  LET g_errparam.popup  = TRUE 
                  CALL cl_err()
                  CALL s_transaction_end('N',0)
                  CONTINUE DIALOG
               END IF
               
               UPDATE ecbe_t SET ecbe001 = g_ecba_m.ecba001,
                                 ecbe002 = g_ecba_m.ecba002
                  WHERE ecbeent = g_enterprise
                    AND ecbesite = g_site
                    AND ecbe001 = l_ecba001_t
                    AND ecbe002 = g_ecba_m.ecba002
               IF SQLCA.sqlcode THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = 'update ecbe_t:' 
                  LET g_errparam.code   = SQLCA.sqlcode 
                  LET g_errparam.popup  = TRUE 
                  CALL cl_err()
                  CALL s_transaction_end('N',0)
                  CONTINUE DIALOG
               END IF
               
               UPDATE ecbf_t SET ecbf001 = g_ecba_m.ecba001,
                                 ecbf002 = g_ecba_m.ecba002
                  WHERE ecbfent = g_enterprise
                    AND ecbfsite = g_site
                    AND ecbf001 = l_ecba001_t
                    AND ecbf002 = g_ecba_m.ecba002
               IF SQLCA.sqlcode THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = 'update ecbf_t:' 
                  LET g_errparam.code   = SQLCA.sqlcode 
                  LET g_errparam.popup  = TRUE 
                  CALL cl_err()
                  CALL s_transaction_end('N',0)
                  CONTINUE DIALOG
               END IF
               
               UPDATE ecbg_t SET ecbg001 = g_ecba_m.ecba001,
                                 ecbg002 = g_ecba_m.ecba002
                  WHERE ecbgent = g_enterprise
                    AND ecbgsite = g_site
                    AND ecbg001 = l_ecba001_t
                    AND ecbg002 = g_ecba_m.ecba002 
               IF SQLCA.sqlcode THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = 'update ecbg_t:' 
                  LET g_errparam.code   = SQLCA.sqlcode 
                  LET g_errparam.popup  = TRUE 
                  CALL cl_err()
                  CALL s_transaction_end('N',0)
                  CONTINUE DIALOG
               END IF
            END IF
            IF NOT cl_null(g_ecba_m.ecba001) THEN
               LET l_ecba001_t = g_ecba_m.ecba001
            END IF
            CALL s_transaction_end('Y',0)
            #END add-point
            
 
         #此段落由子樣板a01產生
         BEFORE FIELD ecba001
            #add-point:BEFORE FIELD ecba001

            #END add-point
 
         #此段落由子樣板a04產生
         ON CHANGE ecba001
            #add-point:ON CHANGE ecba001
 
            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD ecba002
            #add-point:BEFORE FIELD ecba002

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD ecba002
            
            #add-point:AFTER FIELD ecba002
            #此段落由子樣板a05產生
            IF cl_null(g_ecba_m.ecba001) THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "" 
               LET g_errparam.code   = "adz-00255" 
               LET g_errparam.popup  = FALSE
               CALL cl_err()
               NEXT FIELD ecba002
            END IF

            IF NOT cl_null(g_ecba_m.ecba001) AND NOT cl_null(g_ecba_m.ecba002) THEN 
               IF p_cmd = 'a' OR ( p_cmd = 'u' AND ( p_cmd = 'u' AND (g_ecba_m.ecba001 != g_ecba001_t  OR g_ecba_m.ecba002 != g_ecba002_t ))) THEN 
                  IF NOT ap_chk_notDup(g_ecba_m.ecba002,"SELECT COUNT(*) FROM ecba_t WHERE "||"ecbaent = '" ||g_enterprise|| "' AND ecbasite = '" ||g_site|| "' AND "||"ecba001 = '"||g_ecba_m.ecba001 ||"' AND "|| "ecba002 = '"||g_ecba_m.ecba002 ||"'",'std-00004',0) THEN 
                     LET g_ecba_m.ecba002 = g_ecba_m_t.ecba002
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF

            IF NOT cl_null(g_ecba_m.ecba001) AND NOT cl_null(g_ecba_m.ecba002) THEN
               CALL aecm200_wc_submit("wc", "station_enable", "true")
            END IF
            #如果又回去修改單頭，必須連同所有單身都UPDATE，以免造成新加入的單身資料變垃圾
            IF NOT cl_null(l_ecba002_t) AND NOT cl_null(g_ecba_m.ecba002) AND NOT cl_null(g_ecba_m.ecba001) THEN
               CALL s_transaction_begin()
               
               UPDATE ecbb_t SET ecbb001 = g_ecba_m.ecba001,
                                 ecbb002 = g_ecba_m.ecba002
                  WHERE ecbbent = g_enterprise
                    AND ecbbsite = g_site
                    AND ecbb001 = g_ecba_m.ecba001
                    AND ecbb002 = l_ecba002_t
               IF SQLCA.sqlcode THEN    
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = 'update ecbb_t:' 
                  LET g_errparam.code   = SQLCA.sqlcode 
                  LET g_errparam.popup  = TRUE 
                  CALL cl_err()
                  CALL s_transaction_end('N',0)
                  CONTINUE DIALOG
               END IF
               
               UPDATE ecbc_t SET ecbc001 = g_ecba_m.ecba001,
                                 ecbc002 = g_ecba_m.ecba002
                  WHERE ecbcent = g_enterprise
                    AND ecbcsite = g_site
                    AND ecbc001 = g_ecba_m.ecba001
                    AND ecbc002 = l_ecba002_t
               IF SQLCA.sqlcode THEN    
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = 'update ecbC_t:' 
                  LET g_errparam.code   = SQLCA.sqlcode 
                  LET g_errparam.popup  = TRUE 
                  CALL cl_err()
                  CALL s_transaction_end('N',0)
                  CONTINUE DIALOG
               END IF
               
               UPDATE ecbd_t SET ecbd001 = g_ecba_m.ecba001,
                                 ecbd002 = g_ecba_m.ecba002
                  WHERE ecbdent = g_enterprise
                    AND ecbdsite = g_site
                    AND ecbd001 = g_ecba_m.ecba001
                    AND ecbd002 = l_ecba002_t
               IF SQLCA.sqlcode THEN    
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = 'update ecbd_t:' 
                  LET g_errparam.code   = SQLCA.sqlcode 
                  LET g_errparam.popup  = TRUE 
                  CALL cl_err()
                  CALL s_transaction_end('N',0)
                  CONTINUE DIALOG
               END IF
               
               UPDATE ecbe_t SET ecbe001 = g_ecba_m.ecba001,
                                 ecbe002 = g_ecba_m.ecba002
                  WHERE ecbeent = g_enterprise
                    AND ecbesite = g_site
                    AND ecbe001 = g_ecba_m.ecba001
                    AND ecbe002 = l_ecba002_t
               IF SQLCA.sqlcode THEN    
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = 'update ecbe_t:' 
                  LET g_errparam.code   = SQLCA.sqlcode 
                  LET g_errparam.popup  = TRUE 
                  CALL cl_err()
                  CALL s_transaction_end('N',0)
                  CONTINUE DIALOG
               END IF
               
               UPDATE ecbf_t SET ecbf001 = g_ecba_m.ecba001,
                                 ecbf002 = g_ecba_m.ecba002
                  WHERE ecbfent = g_enterprise
                    AND ecbfsite = g_site
                    AND ecbf001 = g_ecba_m.ecba001
                    AND ecbf002 = l_ecba002_t
               IF SQLCA.sqlcode THEN    
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = 'update ecbf_t:' 
                  LET g_errparam.code   = SQLCA.sqlcode 
                  LET g_errparam.popup  = TRUE 
                  CALL cl_err()
                  CALL s_transaction_end('N',0)
                  CONTINUE DIALOG
               END IF
               
               UPDATE ecbg_t SET ecbg001 = g_ecba_m.ecba001,
                                 ecbg002 = g_ecba_m.ecba002
                  WHERE ecbgent = g_enterprise
                    AND ecbgsite = g_site
                    AND ecbg001 = g_ecba_m.ecba001
                    AND ecbg002 = l_ecba002_t
               IF SQLCA.sqlcode THEN    
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = 'update ecbg_t:' 
                  LET g_errparam.code   = SQLCA.sqlcode 
                  LET g_errparam.popup  = TRUE 
                  CALL cl_err()
                  CALL s_transaction_end('N',0)
                  CONTINUE DIALOG
               END IF
               
            END IF
            IF NOT cl_null(g_ecba_m.ecba002) THEN
               LET l_ecba002_t = g_ecba_m.ecba002
            END IF
            
            CALL s_transaction_end('Y', 0)
            #END add-point
            
 
         #此段落由子樣板a04產生
         ON CHANGE ecba002
            #add-point:ON CHANGE ecba002
 
            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD ecba003
            #add-point:BEFORE FIELD ecba003

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD ecba003
            
            #add-point:AFTER FIELD ecba003

            #END add-point
            
 
         #此段落由子樣板a04產生
         ON CHANGE ecba003
            #add-point:ON CHANGE ecba003

            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD ecba004
            #add-point:BEFORE FIELD ecba004

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD ecba004
            
            #add-point:AFTER FIELD ecba004

            #END add-point
            
 
         #此段落由子樣板a04產生
         ON CHANGE ecba004
            #add-point:ON CHANGE ecba004

            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD ecba005
            #add-point:BEFORE FIELD ecba005

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD ecba005
            
            #add-point:AFTER FIELD ecba005

            #END add-point
            
 
         #此段落由子樣板a04產生
         ON CHANGE ecba005
            #add-point:ON CHANGE ecba005

            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD ecba006
            #add-point:BEFORE FIELD ecba006

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD ecba006
            
            #add-point:AFTER FIELD ecba006

            #END add-point
            
 
         #此段落由子樣板a04產生
         ON CHANGE ecba006
            #add-point:ON CHANGE ecba006

            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD ecba007
            #add-point:BEFORE FIELD ecba007

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD ecba007
            
            #add-point:AFTER FIELD ecba007

            #END add-point
            
 
         #此段落由子樣板a04產生
         ON CHANGE ecba007
            #add-point:ON CHANGE ecba007

            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD ecbastus
            #add-point:BEFORE FIELD ecbastus

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD ecbastus
            
            #add-point:AFTER FIELD ecbastus

            #END add-point
            
 
         #此段落由子樣板a04產生
         ON CHANGE ecbastus
            #add-point:ON CHANGE ecbastus

            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD ooeb013
            #add-point:BEFORE FIELD ooeb013

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD ooeb013
            
            #add-point:AFTER FIELD ooeb013
            IF NOT cl_null(g_ecba_m.ooeb013) AND NOT cl_null(g_ecba_m.ecba001) AND NOT cl_null(g_ecba_m.ecba002) THEN
               CALL s_aooi360_gen('6',g_site,g_ecba_m.ecba001,g_ecba_m.ecba002,'','','','','','','','4',g_ecba_m.ooeb013) RETURNING l_success
               IF NOT l_success THEN
                  NEXT FIELD ooeb013
               END IF
            END IF
            #END add-point
            
 
         #此段落由子樣板a04產生
         ON CHANGE ooeb013
            #add-point:ON CHANGE ooeb013

            #END add-point
 
 #欄位檢查
                  #Ctrlp:input.c.ecba001
         ON ACTION controlp INFIELD ecba001
            #add-point:ON ACTION controlp INFIELD ecba001
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'     #160201-00008#1-add
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_ecba_m.ecba001        #給予default值
            CALL q_imaf001_6()                                #呼叫開窗
            LET g_ecba_m.ecba001 = g_qryparam.return1         #將開窗取得的值回傳到變數
            DISPLAY g_ecba_m.ecba001 TO ecba001               #顯示到畫面上
            CALL aecm200_desc()
            NEXT FIELD ecba001                                #返回原欄位


            #END add-point
 
         #Ctrlp:input.c.ecba002
         ON ACTION controlp INFIELD ecba002
            #add-point:ON ACTION controlp INFIELD ecba002

            #END add-point
 
         #Ctrlp:input.c.ecba003
         ON ACTION controlp INFIELD ecba003
            #add-point:ON ACTION controlp INFIELD ecba003

            #END add-point
 
         #Ctrlp:input.c.ecba004
         ON ACTION controlp INFIELD ecba004
            #add-point:ON ACTION controlp INFIELD ecba004

            #END add-point
 
         #Ctrlp:input.c.ecba005
         ON ACTION controlp INFIELD ecba005
            #add-point:ON ACTION controlp INFIELD ecba005

            #END add-point
 
         #Ctrlp:input.c.ecba006
         ON ACTION controlp INFIELD ecba006
            #add-point:ON ACTION controlp INFIELD ecba006

            #END add-point
 
         #Ctrlp:input.c.ecba007
         ON ACTION controlp INFIELD ecba007
            #add-point:ON ACTION controlp INFIELD ecba007

            #END add-point
 
         #Ctrlp:input.c.ecbastus
         ON ACTION controlp INFIELD ecbastus
            #add-point:ON ACTION controlp INFIELD ecbastus

            #END add-point
 
         #Ctrlp:input.c.ooeb013
         ON ACTION controlp INFIELD ooeb013
            #add-point:ON ACTION controlp INFIELD ooeb013

            #END add-point
 
 #欄位開窗
            
         AFTER INPUT
            IF INT_FLAG THEN
               EXIT DIALOG
            END IF
 
            #CALL cl_err_collect_show()      #錯誤訊息統整顯示
            CALL cl_showmsg()
            DISPLAY BY NAME g_ecba_m.ecba001,g_ecba_m.ecba002
                        
            #add-point:單頭INPUT後
 
            #end add-point
                        
            IF p_cmd <> 'u' THEN
    
               CALL s_transaction_begin()
               
               #add-point:單頭新增前

               #end add-point
               
               INSERT INTO ecba_t (ecbaent, ecbasite,ecba001,ecba002,ecba003,ecba004,ecba005,ecba006, 
                   ecba007,ecbastus,ecbacrtid,ecbacrtdp,ecbacrtdt,ecbaownid,ecbaowndp,ecbacnfid,ecbacnfdt) 
 
               VALUES (g_enterprise, g_site,g_ecba_m.ecba001,g_ecba_m.ecba002,g_ecba_m.ecba003,g_ecba_m.ecba004, 
                   g_ecba_m.ecba005,g_ecba_m.ecba006,g_ecba_m.ecba007,g_ecba_m.ecbastus,g_ecba_m.ecbacrtid, 
                   g_ecba_m.ecbacrtdp,g_ecba_m.ecbacrtdt,g_ecba_m.ecbaownid,g_ecba_m.ecbaowndp,g_ecba_m.ecbacnfid, 
                   g_ecba_m.ecbacnfdt) 
               IF SQLCA.sqlcode THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "g_ecba_m" 
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
                  CALL aecm200_detail_reproduce()
               END IF
               
               LET g_master_insert = TRUE
               
               LET p_cmd = 'u'
            ELSE
               CALL s_transaction_begin()
            
               #add-point:單頭修改前

               #end add-point
               
               UPDATE ecba_t SET (ecba001,ecba002,ecba003,ecbastus,ecbacrtid, 
                   ecbacrtdp,ecbacrtdt,ecbaownid,ecbaowndp,ecbacnfid,ecbacnfdt) = (g_ecba_m.ecba001, 
                   g_ecba_m.ecba002,g_ecba_m.ecba003,g_ecba_m.ecbastus,g_ecba_m.ecbacrtid,
                   g_ecba_m.ecbacrtdp,g_ecba_m.ecbacrtdt, 
                   g_ecba_m.ecbaownid,g_ecba_m.ecbaowndp,g_ecba_m.ecbacnfid,g_ecba_m.ecbacnfdt)
                WHERE ecbaent = g_enterprise AND ecbasite = g_site AND ecba001 = g_ecba001_t
                  AND ecba002 = g_ecba002_t
 
               IF SQLCA.sqlcode THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "ecba_t" 
                  LET g_errparam.code   = SQLCA.sqlcode 
                  LET g_errparam.popup  = TRUE 
                  CALL cl_err()
 
                  CALL s_transaction_end('N','0')
                  CONTINUE DIALOG
               END IF
               
               #add-point:單頭修改中

               #end add-point
               
               
               
               
               #修改歷程記錄
               LET g_log1 = util.JSON.stringify(g_ecba_m_t)
               LET g_log2 = util.JSON.stringify(g_ecba_m)
               IF NOT cl_log_modified_record(g_log1,g_log2) THEN 
                  CALL s_transaction_end('N','0')
               ELSE
                  CALL s_transaction_end('Y','0')
               END IF
               
               #add-point:單頭修改後

               #end add-point
            END IF
            
            LET g_ecba001_t = g_ecba_m.ecba001
            LET g_ecba002_t = g_ecba_m.ecba002
 
            
      END INPUT
   
 
{</section>}
 
{<section id="aecm200.input.body" >}
   
      #Page1 預設值產生於此處
      INPUT ARRAY g_ecbb_d FROM s_detail1.*
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
                IF NOT cl_null(g_ecba_m.ecba001) AND  NOT cl_null(g_ecba_m.ecba002) AND NOT cl_null(g_ecbb_d[l_ac].ecbb003) AND NOT cl_null(g_ecbb_d[l_ac].ecbb004)  AND NOT cl_null(g_ecbb_d[l_ac].ecbb005) THEN
                   CALL aecm200_02(g_ecba_m.ecba001,g_ecba_m.ecba002,g_ecbb_d[l_ac].ecbb003,g_ecbb_d[l_ac].ecbb004,g_ecbb_d[l_ac].ecbb005,'2','Y','N')
                END IF
                LET g_action_choice=""
               #END add-point
            END IF
 
 
         #+ 此段落由子樣板a43產生
        ON ACTION resource
          LET g_action_choice="resource"
          IF cl_auth_chk_act("resource") THEN
             
             #add-point:ON ACTION resource
        #       IF NOT cl_null(g_ecba_m.ecba001) AND  NOT cl_null(g_ecba_m.ecba002) AND NOT cl_null(g_ecbb_d[l_ac].ecbb003) AND NOT cl_null(g_ecbb_d[l_ac].ecbb004)  AND NOT cl_null(g_ecbb_d[l_ac].ecbb005) THEN
        #          CALL aecm200_03(g_ecba_m.ecba001,g_ecba_m.ecba002,g_ecbb_d[l_ac].ecbb003,g_ecbb_d[l_ac].ecbb004,g_ecbb_d[l_ac].ecbb005,'Y','N')
        #       END IF
        #       LET g_action_choice=""
                IF NOT cl_null(g_ecba_m.ecba001) AND  NOT cl_null(g_ecba_m.ecba002) AND NOT cl_null(g_ecbb_d[l_ac].ecbb003) AND (NOT cl_null(g_ecbb_d[l_ac].ecbb037) OR NOT cl_null(g_ecbb_d[l_ac].ecbb038)) THEN
                   CALL aecm200_05(g_ecba_m.ecba001,g_ecba_m.ecba002,g_ecbb_d[l_ac].ecbb003)
                END IF
                LET g_action_choice=""
             #END add-point
          END IF
 
 
         #+ 此段落由子樣板a43產生
         ON ACTION stand
            LET g_action_choice="stand"
            IF cl_auth_chk_act("stand") THEN
               
               #add-point:ON ACTION stand
                IF NOT cl_null(g_ecba_m.ecba001) AND  NOT cl_null(g_ecba_m.ecba002) AND NOT cl_null(g_ecbb_d[l_ac].ecbb003) AND NOT cl_null(g_ecbb_d[l_ac].ecbb004)  AND NOT cl_null(g_ecbb_d[l_ac].ecbb005) THEN
                   IF g_ecba_m.ecbastus = 'N' THEN
                      CALL aecm200_01(g_ecba_m.ecba001,g_ecba_m.ecba002,g_ecbb_d[l_ac].ecbb003,g_ecbb_d[l_ac].ecbb004,g_ecbb_d[l_ac].ecbb005,'Y','N')
                      SELECT COUNT(*) INTO l_n4 FROM ecbe_t 
                       WHERE ecbeent = g_enterprise AND ecbesite = g_site 
                         AND ecbe001 = g_ecba_m.ecba001 AND ecbe002 = g_ecba_m.ecba002
                         AND ecbe003 = g_ecbb_d[l_ac].ecbb003
                      IF l_n4 = 0 THEN 
                         LET g_ecbb_d[l_ac].ecbb008 = ''
                         LET g_ecbb_d[l_ac].ecbb008_desc = ''
                         LET g_ecbb_d[l_ac].ecbb009 = ''
                      END IF
                      IF l_n4 = 1 THEN
                         SELECT ecbe004,ecbe005 INTO g_ecbb_d[l_ac].ecbb008,g_ecbb_d[l_ac].ecbb009 FROM ecbe_t
                          WHERE ecbeent = g_enterprise AND ecbesite = g_site 
                            AND ecbe001 = g_ecba_m.ecba001 AND ecbe002 = g_ecba_m.ecba002
                            AND ecbe003 = g_ecbb_d[l_ac].ecbb003
                         INITIALIZE g_ref_fields TO NULL
                         LET g_ref_fields[1] = g_ecbb_d[l_ac].ecbb008
                         CALL ap_ref_array2(g_ref_fields,"SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001 = '221' AND oocql002=? AND oocql003='"||g_dlang||"'","") RETURNING g_rtn_fields
                         LET g_ecbb_d[l_ac].ecbb008_desc = g_rtn_fields[1]
                         CALL aecm200_ecbb_desc()                  
                      END IF
                      IF l_n4 > 1 THEN
                         LET g_ecbb_d[l_ac].ecbb008 = 'MULT'
                         LET g_ecbb_d[l_ac].ecbb008_desc = ''
                         LET g_ecbb_d[l_ac].ecbb009 = '0'
                      END IF
                   END IF
                   UPDATE ecbb_t SET ecbb008 = g_ecbb_d[l_ac].ecbb008,
                                     ecbb009 = g_ecbb_d[l_ac].ecbb009
                    WHERE ecbbent = g_enterprise AND ecbbsite = g_site
                      AND ecbb001 = g_ecba_m.ecba001 AND ecbe002 = g_ecba_m.ecba002
                      AND ecbe003 = g_ecbb_d[l_ac].ecbb003
                END IF
                LET g_action_choice=""
               #END add-point
            END IF
 
 
         #+ 此段落由子樣板a43產生
         ON ACTION checkin
            LET g_action_choice="checkin"
            IF cl_auth_chk_act("checkin") THEN
               
               #add-point:ON ACTION checkin
                IF NOT cl_null(g_ecba_m.ecba001) AND  NOT cl_null(g_ecba_m.ecba002) AND NOT cl_null(g_ecbb_d[l_ac].ecbb003) AND NOT cl_null(g_ecbb_d[l_ac].ecbb004)  AND NOT cl_null(g_ecbb_d[l_ac].ecbb005) THEN
                   CALL aecm200_02(g_ecba_m.ecba001,g_ecba_m.ecba002,g_ecbb_d[l_ac].ecbb003,g_ecbb_d[l_ac].ecbb004,g_ecbb_d[l_ac].ecbb005,'1','Y','N')
                END IF
                LET g_action_choice=""
               #END add-point
            END IF
 
 
         
         BEFORE INPUT
            #add-point:資料輸入前
            
            #end add-point
            IF g_insert = 'Y' AND NOT cl_null(g_insert) THEN 
              CALL FGL_SET_ARR_CURR(g_ecbb_d.getLength()+1) 
              LET g_insert = 'N' 
           END IF 
 
            CALL aecm200_b_fill()
            LET g_rec_b = g_ecbb_d.getLength()
            #add-point:資料輸入前

            #end add-point
         
         BEFORE ROW
            #add-point:modify段before row2
            LET g_aecm200_05_chk = FALSE   #add--151215-00002#4 By shiun
            #end add-point  
            LET l_insert = FALSE
            LET l_cmd = ''
            LET l_ac = ARR_CURR()
            LET g_detail_idx = l_ac
            
            LET l_lock_sw = 'N'            #DEFAULT
            LET l_n = ARR_COUNT()
            DISPLAY l_ac TO FORMONLY.idx
         
            CALL s_transaction_begin()
            OPEN aecm200_cl USING g_enterprise, g_site,g_ecba_m.ecba001,g_ecba_m.ecba002
            IF STATUS THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "OPEN aecm200_cl:" 
               LET g_errparam.code   = STATUS 
               LET g_errparam.popup  = TRUE 
               CALL cl_err()
 
               CLOSE aecm200_cl
               CALL s_transaction_end('N','0')
               RETURN
            END IF
            
            LET g_rec_b = g_ecbb_d.getLength()
            
            IF g_rec_b >= l_ac 
               AND g_ecbb_d[l_ac].ecbb003 IS NOT NULL
 
            THEN
               LET l_cmd='u'
               LET g_ecbb_d_t.* = g_ecbb_d[l_ac].*  #BACKUP
               LET g_ecbb_d_o.* = g_ecbb_d[l_ac].*  #BACKUP
               CALL aecm200_set_entry_b(l_cmd)
               #add-point:modify段after_set_entry_b

               #end add-point  
               CALL aecm200_set_no_entry_b(l_cmd)
               IF NOT aecm200_lock_b("ecbb_t","'1'") THEN
                  LET l_lock_sw='Y'
               ELSE
                  FETCH aecm200_bcl INTO g_ecbb_d[l_ac].ecbb003,g_ecbb_d[l_ac].ecbb004,g_ecbb_d[l_ac].ecbb005, 
                      g_ecbb_d[l_ac].ecbb006,g_ecbb_d[l_ac].ecbb007,g_ecbb_d[l_ac].ecbb008,g_ecbb_d[l_ac].ecbb009, 
                      g_ecbb_d[l_ac].ecbb010,g_ecbb_d[l_ac].ecbb011,g_ecbb_d[l_ac].ecbb012,g_ecbb_d[l_ac].ecbb037,g_ecbb_d[l_ac].ecbb038,
                      g_ecbb_d[l_ac].ecbb024,g_ecbb_d[l_ac].ecbb025,g_ecbb_d[l_ac].ecbb026,g_ecbb_d[l_ac].ecbb027,g_ecbb_d[l_ac].ecbb034, 
                      g_ecbb_d[l_ac].ecbb013,g_ecbb_d[l_ac].ecbb014,g_ecbb_d[l_ac].ecbb015,g_ecbb_d[l_ac].ecbb016, 
                      g_ecbb_d[l_ac].ecbb017,g_ecbb_d[l_ac].ecbb018,g_ecbb_d[l_ac].ecbb019,g_ecbb_d[l_ac].ecbb020, 
                      g_ecbb_d[l_ac].ecbb030,g_ecbb_d[l_ac].ecbb031,g_ecbb_d[l_ac].ecbb032,g_ecbb_d[l_ac].ecbb021, 
                      g_ecbb_d[l_ac].ecbb022,g_ecbb_d[l_ac].ecbb023,g_ecbb_d[l_ac].ecbb033,g_ecbb_d[l_ac].ecbb028, 
                      g_ecbb_d[l_ac].ecbb029,g_ecbb_d[l_ac].ecbb035,g_ecbb_d[l_ac].ecbb036
                  IF SQLCA.sqlcode THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = g_ecbb_d_t.ecbb003 
                     LET g_errparam.code   = SQLCA.sqlcode 
                     LET g_errparam.popup  = TRUE 
                     CALL cl_err()
 
                     LET l_lock_sw = "Y"
                  END IF
                  
                  LET g_bfill = "N"
                  CALL aecm200_show()
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
            INITIALIZE g_ecbb_d[l_ac].* TO NULL 
            INITIALIZE g_ecbb_d_t.* TO NULL 
            INITIALIZE g_ecbb_d_o.* TO NULL 
            #公用欄位給值(單身)
            
            #自定義預設值
                  LET g_ecbb_d[l_ac].ecbb006 = "1"
      LET g_ecbb_d[l_ac].ecbb024 = "0"
      LET g_ecbb_d[l_ac].ecbb025 = "0"
      LET g_ecbb_d[l_ac].ecbb026 = "0"
      LET g_ecbb_d[l_ac].ecbb027 = "0"
      LET g_ecbb_d[l_ac].ecbb034 = "0"
      LET g_ecbb_d[l_ac].ecbb013 = "N"
      LET g_ecbb_d[l_ac].ecbb015 = "N"
      LET g_ecbb_d[l_ac].ecbb016 = "N"
      LET g_ecbb_d[l_ac].ecbb017 = "Y"
      LET g_ecbb_d[l_ac].ecbb018 = "N"
      LET g_ecbb_d[l_ac].ecbb019 = "N"
      LET g_ecbb_d[l_ac].ecbb020 = "N"
      LET g_ecbb_d[l_ac].ecbb031 = "1"
      LET g_ecbb_d[l_ac].ecbb032 = "1"
      LET g_ecbb_d[l_ac].ecbb022 = "1"
      LET g_ecbb_d[l_ac].ecbb023 = "1"
      LET g_ecbb_d[l_ac].ecbb033 = "N"
 
            #add-point:modify段before備份
            LET g_ecbb_d[l_ac].ecbb035 = 0 
            LET g_ecbb_d[l_ac].ecbb036 = 0
            #end add-point
            LET g_ecbb_d_t.* = g_ecbb_d[l_ac].*     #新輸入資料
            LET g_ecbb_d_o.* = g_ecbb_d[l_ac].*     #新輸入資料
            CALL cl_show_fld_cont()
            CALL aecm200_set_entry_b(l_cmd)
            #add-point:modify段after_set_entry_b

            #end add-point
            CALL aecm200_set_no_entry_b(l_cmd)
            IF lb_reproduce THEN
               LET lb_reproduce = FALSE
               LET g_ecbb_d[li_reproduce_target].* = g_ecbb_d[li_reproduce].*
 
               LET g_ecbb_d[li_reproduce_target].ecbb003 = NULL
 
            END IF
            
            #add-point:modify段before insert
            #add by wuxja ---begin---
            SELECT MAX(ecbb003) INTO g_ecbb_d[l_ac].ecbb003 FROM ecbb_t
             WHERE ecbbent = g_enterprise
               AND ecbbsite = g_site
               AND ecbb001 = g_ecba_m.ecba001
               AND ecbb002 = g_ecba_m.ecba002
            CALL cl_get_para(g_enterprise,g_site,'E-MFG-0001') RETURNING l_sys
            IF cl_null(l_sys) OR l_sys = 0 THEN LET l_sys = 1 END IF 
            #單身第一筆，預設上站為INIT
            IF cl_null(g_ecbb_d[l_ac].ecbb003) THEN
               LET g_ecbb_d[l_ac].ecbb003 = l_sys
               LET g_ecbb_d[l_ac].ecbb008 = 'INIT'
               LET g_ecbb_d[l_ac].ecbb009 ='0'
            ELSE           
               SELECT ecbb004,ecbb005 INTO g_ecbb_d[l_ac].ecbb008,g_ecbb_d[l_ac].ecbb009 FROM ecbb_t
                WHERE ecbbent = g_enterprise
                  AND ecbbsite = g_site
                  AND ecbb001 = g_ecba_m.ecba001
                  AND ecbb002 = g_ecba_m.ecba002
                  AND ecbb003 = g_ecbb_d[l_ac].ecbb003
               LET g_ecbb_d[l_ac].ecbb003 = g_ecbb_d[l_ac].ecbb003 + l_sys
            END IF
            #end
            
            SELECT imae016 INTO g_ecbb_d[l_ac].ecbb021
              FROM imae_t
             WHERE imaeent = g_enterprise
               AND imaesite = g_site
               AND imae001 = g_ecba_m.ecba001
            #add by wuxj
            IF cl_null(g_ecbb_d[l_ac].ecbb021) THEN
               SELECT imaa006 INTO g_ecbb_d[l_ac].ecbb021 FROM imaa_t
                WHERE imaaent = g_enterprise AND imaa001 = g_ecba_m.ecba001
            END IF
            LET g_ecbb_d[l_ac].ecbb030 = g_ecbb_d[l_ac].ecbb021
            #end

            CALL g_ecbb2_d.clear()
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
            SELECT COUNT(*) INTO l_count FROM ecbb_t 
             WHERE ecbbent = g_enterprise AND ecbbsite = g_site AND ecbb001 = g_ecba_m.ecba001
               AND ecbb002 = g_ecba_m.ecba002
 
               AND ecbb003 = g_ecbb_d[l_ac].ecbb003
 
                
            #資料未重複, 插入新增資料
            IF l_count = 0 THEN 
               #add-point:單身新增前

               #end add-point
            
               #同步新增到同層的table
                              INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_ecba_m.ecba001
               LET gs_keys[2] = g_ecba_m.ecba002
               LET gs_keys[3] = g_ecbb_d[g_detail_idx].ecbb003
               CALL aecm200_insert_b('ecbb_t',gs_keys,"'1'")
                           
               #add-point:單身新增後
#               LET l_sql = " SELECT * FROM ecab_t",
#                           "  WHERE ecabent = '",g_enterprise,"' ",
#                           "    AND ecab001 = '",g_ecbb_d[l_ac].ecbb004,"'"
#               PREPARE aecm200_sel_ecab_pb FROM l_sql
#               DECLARE aecm200_sel_ecab_cs CURSOR FOR aecm200_sel_ecab_pb
#               FOREACH aecm200_sel_ecab_cs INTO l_ecab.*
#                  LET l_n1 = 0
#                  SELECT COUNT(*) INTO l_n1
#                    FROM ecbf_t
#                   WHERE ecbfent = g_enterprise
#                     AND ecbfsite = g_site
#                     AND ecbf001 = g_ecba_m.ecba001
#                     AND ecbf002 = g_ecba_m.ecba002
#                     AND ecbf003 = g_ecbb_d[l_ac].ecbb003
#                     AND ecbf004 = l_ecab.ecab002
#                     AND ecbf005 = l_ecab.ecab003
#                  IF l_n1 = 0 THEN
#                     SELECT MAX(ecbfseq) +1 INTO l_ecbfseq
#                       FROM ecbf_t
#                      WHERE ecbfent = g_enterprise
#                        AND ecbfsite = g_site
#                        AND ecbf001 = g_ecba_m.ecba001
#                        AND ecbf002 = g_ecba_m.ecba002
#                        AND ecbf003 = g_ecbb_d[l_ac].ecbb003
#                     IF cl_null(l_ecbfseq) THEN
#                        LET l_ecbfseq = 1
#                     END IF
#                     INSERT INTO ecbf_t(ecbfent,ecbfsite,ecbf001,ecbf002,ecbf003,ecbfseq,ecbf004,ecbf005,ecbf006,ecbf007,ecbf008,ecbf009,ecbf010)
#                                 VALUES(g_enterprise,g_site,g_ecba_m.ecba001,g_ecba_m.ecba002,g_ecbb_d[l_ac].ecbb003,l_ecbfseq,l_ecab.ecab002,l_ecab.ecab003,l_ecab.ecab004,l_ecab.ecab005,l_ecab.ecab006,l_ecab.ecab007,l_ecab.ecab008)
#                     IF SQLCA.sqlcode THEN
#                        INITIALIZE g_errparam TO NULL
#                 LET g_errparam.code = SQLCA.sqlcode
#                 LET g_errparam.extend = "ins_ecbf_t"
#                 LET g_errparam.popup = TRUE
#                 CALL cl_err()
#
#                        CALL s_transaction_end('N','0')
#                     END IF    
#                  END IF
#               END FOREACH
               LET l_sql = " MERGE INTO ecbf_t ",
                           " USING (SELECT ecab001,ecabseq,ecab002,ecab003,ecab004,ecab005,ecab006,ecab007,ecab008",
                           "          FROM ecab_t ",
                           "         WHERE ecabent = '",g_enterprise,"' AND ecab001 = '",g_ecbb_d[l_ac].ecbb004,"') ",
                           "    ON (ecab002 = ecbf004 AND ecab003 = ecbf005 AND ecbf002 = '",g_ecba_m.ecba002,"'",
                           "        AND ecbfent = '",g_enterprise,"' AND ecbfsite = '",g_site,"' AND ecbf001 = '",g_ecba_m.ecba001,"'",
                           "        AND ecbf003 = '",g_ecbb_d[l_ac].ecbb003,"')",
                           "  WHEN NOT MATCHED THEN ",
                           "INSERT(ecbfent,ecbfsite,ecbf001,ecbf002,ecbf003,ecbfseq,ecbf004,ecbf005,ecbf006,ecbf007,ecbf008,ecbf009,ecbf010) ",
                           "VALUES('",g_enterprise,"','",g_site,"','",g_ecba_m.ecba001,"','",g_ecba_m.ecba002,"','",g_ecbb_d[l_ac].ecbb003,"',ecabseq,ecab002,ecab003,ecab004,ecab005,ecab006,ecab007,ecab008)"
               PREPARE aecm200_ins_ecbf_pre FROM l_sql
               EXECUTE aecm200_ins_ecbf_pre
               IF SQLCA.sqlcode THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = SQLCA.sqlcode
                  LET g_errparam.extend = "ins_ecbf_t"
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
 
                  CALL s_transaction_end('N','0')
               END IF            
               IF g_ecbb_d[l_ac].ecbb008 <> 'MULT' THEN
                  LET l_n1 = 0
                  SELECT COUNT(*) INTO l_n1
                    FROM ecbe_t
                   WHERE ecbeent = g_enterprise
                     AND ecbesite = g_site
                     AND ecbe001 = g_ecba_m.ecba001
                     AND ecbe002 = g_ecba_m.ecba002
                     AND ecbe003 = g_ecbb_d[l_ac].ecbb003
                     AND ecbe004 = g_ecbb_d[l_ac].ecbb008
                     AND ecbe005 = g_ecbb_d[l_ac].ecbb009
                  SELECT MAX(ecbeseq) +1 INTO l_ecbeseq
                    FROM ecbe_t
                   WHERE ecbeent = g_enterprise
                     AND ecbesite = g_site
                     AND ecbe001 = g_ecba_m.ecba001
                     AND ecbe002 = g_ecba_m.ecba002
                     AND ecbe003 = g_ecbb_d[l_ac].ecbb003
                  IF cl_null(l_ecbeseq) THEN
                     LET l_ecbeseq = 1
                  END IF
                  IF l_n1 = 0 THEN
                     INSERT INTO ecbe_t(ecbeent,ecbesite,ecbe001,ecbe002,ecbe003,ecbeseq,ecbe004,ecbe005)
                                 VALUES(g_enterprise,g_site,g_ecba_m.ecba001,g_ecba_m.ecba002,g_ecbb_d[l_ac].ecbb003,l_ecbeseq,g_ecbb_d[l_ac].ecbb008,g_ecbb_d[l_ac].ecbb009)
                     IF SQLCA.sqlcode THEN
                        INITIALIZE g_errparam TO NULL
                        LET g_errparam.code = SQLCA.sqlcode
                        LET g_errparam.extend = "ins_ecbe_t"
                        LET g_errparam.popup = TRUE
                        CALL cl_err()
 
                        CALL s_transaction_end('N','0')
                     END IF
                  END IF
               END IF 
               #add by wuxja 
               IF NOT cl_null(g_ecbb_d[l_ac].ooff013) THEN
                  CALL s_aooi360_gen('7',g_site,g_ecba_m.ecba001,g_ecba_m.ecba002,g_ecbb_d[l_ac].ecbb003,' ',' ',' ',' ',' ',' ','4',g_ecbb_d[l_ac].ooff013)
                     RETURNING l_success
               ELSE
                  CALL s_aooi360_del('7',g_site,g_ecba_m.ecba001,g_ecba_m.ecba002,g_ecbb_d[l_ac].ecbb003,' ',' ',' ',' ',' ',' ','4')
                     RETURNING l_success
               END IF
               IF NOT l_success THEN
                  CALL s_transaction_end('N','0')
               END IF
               #end
               #CALL aecm200_return_ecbb_mult()
               IF NOT aecm200_return_ecbb_mult() THEN
                  CALL s_transaction_end('N','0')
               END IF
               CALL aecm200_b_fill()
               #end add-point
            ELSE    
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = 'INSERT' 
               LET g_errparam.code   = "std-00006" 
               LET g_errparam.popup  = TRUE 
               CALL cl_err()
 
               INITIALIZE g_ecbb_d[l_ac].* TO NULL
               CALL s_transaction_end('N','0')
               CANCEL INSERT
            END IF
 
            IF SQLCA.SQLcode  THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "ecbb_t" 
               LET g_errparam.code   = SQLCA.sqlcode 
               LET g_errparam.popup  = TRUE 
               CALL cl_err()
 
               CALL s_transaction_end('N','0')                    
               CANCEL INSERT
            ELSE
               #先刷新資料
               #CALL aecm200_b_fill()
               #資料多語言用-增/改
               
               #add-point:input段-after_insert

               #end add-point
               CALL s_transaction_end('Y','0')
               ERROR 'INSERT O.K'
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
               IF s_transaction_chk("N",0) THEN
                  CALL s_transaction_begin()
               END IF
               #end add-point 
               
               DELETE FROM ecbb_t
                WHERE ecbbent = g_enterprise AND ecbbsite = g_site AND ecbb001 = g_ecba_m.ecba001 AND
                                          ecbb002 = g_ecba_m.ecba002 AND
 
                      ecbb003 = g_ecbb_d_t.ecbb003
 
                  
               #add-point:單身刪除中

               #end add-point 
               
               IF SQLCA.sqlcode THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "ecbb_t" 
                  LET g_errparam.code   = SQLCA.sqlcode 
                  LET g_errparam.popup  = TRUE 
                  CALL cl_err()
 
                  CALL s_transaction_end('N','0')
                  CANCEL DELETE   
               ELSE
                  LET g_rec_b = g_rec_b-1
                  
                  #add-point:單身刪除後
                  DELETE FROM ecbe_t
                   WHERE ecbeent = g_enterprise 
                     AND ecbesite = g_site 
                     AND ecbe001 = g_ecba_m.ecba001 
                     AND ecbe002 = g_ecba_m.ecba002 
                     AND ecbe003 = g_ecbb_d_t.ecbb003
                  IF SQLCA.sqlcode THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = SQLCA.sqlcode
                     LET g_errparam.extend = "ecbe_t"
                     LET g_errparam.popup = TRUE
                     CALL cl_err()

                     CALL s_transaction_end('N','0')
                     CANCEL DELETE   
                  END IF
                  DELETE FROM ecbf_t
                   WHERE ecbfent = g_enterprise 
                     AND ecbfsite = g_site 
                     AND ecbf001 = g_ecba_m.ecba001 
                     AND ecbf002 = g_ecba_m.ecba002 
                     AND ecbf003 = g_ecbb_d_t.ecbb003
                  IF SQLCA.sqlcode THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = SQLCA.sqlcode
                     LET g_errparam.extend = "ecbf_t"
                     LET g_errparam.popup = TRUE
                     CALL cl_err()

                     CALL s_transaction_end('N','0')
                     CANCEL DELETE   
                  END IF
                  DELETE FROM ecbg_t
                   WHERE ecbgent = g_enterprise 
                     AND ecbgsite = g_site 
                     AND ecbg001 = g_ecba_m.ecba001 
                     AND ecbg002 = g_ecba_m.ecba002 
                     AND ecbg003 = g_ecbb_d_t.ecbb003
                  IF SQLCA.sqlcode THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = SQLCA.sqlcode
                     LET g_errparam.extend = "ecbg_t"
                     LET g_errparam.popup = TRUE
                     CALL cl_err()

                     CALL s_transaction_end('N','0')
                     CANCEL DELETE   
                  END IF
                  #add by wuxja 
                  CALL s_aooi360_del('7',g_site,g_ecba_m.ecba001,g_ecba_m.ecba002,g_ecbb_d[l_ac].ecbb003,' ',' ',' ',' ',' ',' ','4')
                     RETURNING l_success
                  IF NOT l_success THEN
                     CALL s_transaction_end('N','0')
                  END IF
                  IF NOT aecm200_return_ecbb_mult() THEN
                     CALL s_transaction_end('N','0')
                  END IF
                  #end
                  #end add-point
                  CALL s_transaction_end('Y','0')
               END IF 
               CLOSE aecm200_bcl
               LET l_count = g_ecbb_d.getLength()
                              INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_ecba_m.ecba001
               LET gs_keys[2] = g_ecba_m.ecba002
               LET gs_keys[3] = g_ecbb_d[g_detail_idx].ecbb003
 
            END IF 
              
         AFTER DELETE 
            IF l_cmd <> 'd' THEN
               #add-point:單身刪除後2

               #end add-point
                              CALL aecm200_delete_b('ecbb_t',gs_keys,"'1'")
            END IF
            #如果是最後一筆
            IF l_ac = (g_ecbb_d.getLength() + 1) THEN
               CALL FGL_SET_ARR_CURR(l_ac-1)
            END IF
 
                  #此段落由子樣板a02產生
         AFTER FIELD ecbb003
            #此段落由子樣板a15產生
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_ecbb_d[l_ac].ecbb003,"0","0","","","azz-00079",1) THEN
               NEXT FIELD ecbb003
            END IF
 
 
            #add-point:AFTER FIELD ecbb003
            #此段落由子樣板a05產生
            IF NOT cl_null(g_ecba_m.ecba001) AND NOT cl_null(g_ecba_m.ecba002) AND NOT cl_null(g_ecbb_d[l_ac].ecbb003) THEN 
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND ( l_cmd = 'u' AND (g_ecba_m.ecba001 != g_ecba001_t OR g_ecba_m.ecba002 != g_ecba002_t OR g_ecbb_d[l_ac].ecbb003 != g_ecbb_d_t.ecbb003))) THEN 
                  IF NOT ap_chk_notDup(g_ecbb_d[l_ac].ecbb003,"SELECT COUNT(*) FROM ecbb_t WHERE "||"ecbbent = '" ||g_enterprise|| "' AND ecbbsite = '" ||g_site|| "' AND "||"ecbb001 = '"||g_ecba_m.ecba001 ||"' AND "|| "ecbb002 = '"||g_ecba_m.ecba002 ||"' AND "|| "ecbb003 = '"||g_ecbb_d[l_ac].ecbb003 ||"'",'std-00004',0) THEN
                     LET g_ecbb_d[l_ac].ecbb003 = g_ecbb_d_t.ecbb003                  
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF


            #END add-point
            
 
         #此段落由子樣板a01產生
         BEFORE FIELD ecbb003
            #add-point:BEFORE FIELD ecbb003

            #END add-point
 
         #此段落由子樣板a04產生
         ON CHANGE ecbb003
            #add-point:ON CHANGE ecbb003

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD ecbb004
            
            #add-point:AFTER FIELD ecbb004
            CALL aecm200_ecbb_desc()
            IF NOT cl_null(g_ecbb_d[l_ac].ecbb004) THEN
               CALL s_azzi650_chk_exist('221',g_ecbb_d[l_ac].ecbb004) RETURNING l_success
               IF NOT l_success THEN
                  LET g_ecbb_d[l_ac].ecbb004 = g_ecbb_d_t.ecbb004
                  CALL aecm200_ecbb_desc()
                  NEXT FIELD ecbb004
               END IF
               IF l_cmd = 'a' OR (l_cmd = 'u' AND g_ecbb_d[l_ac].ecbb004<>　g_ecbb_d_t.ecbb004) THEN
                  IF NOT cl_null(g_ecbb_d[l_ac].ecbb005) THEN
                     CALL aecm200_chk_ecbb004(l_cmd)
                     IF NOT cl_null(g_errno) THEN
                        INITIALIZE g_errparam TO NULL
                        LET g_errparam.code = g_errno
                        LET g_errparam.extend = g_ecbb_d[l_ac].ecbb004
                        LET g_errparam.popup = TRUE
                        CALL cl_err()

                        LET g_ecbb_d[l_ac].ecbb004 = g_ecbb_d_t.ecbb004
                        CALL aecm200_ecbb_desc()
                        NEXT FIELD ecbb004
                     END IF
                  END IF
               END IF
               IF l_cmd = 'a' THEN
                  CALL aecm200_def_ecbb005()
               END IF
            END IF

            #END add-point
            
 
         #此段落由子樣板a01產生
         BEFORE FIELD ecbb004
            #add-point:BEFORE FIELD ecbb004

            #END add-point
 
         #此段落由子樣板a04產生
         ON CHANGE ecbb004
            #add-point:ON CHANGE ecbb004

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD ecbb005
            #此段落由子樣板a15產生
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_ecbb_d[l_ac].ecbb005,"0","1","","","azz-00079",1) THEN
               NEXT FIELD ecbb005
            END IF
 
 
            #add-point:AFTER FIELD ecbb005
            IF NOT cl_null(g_ecbb_d[l_ac].ecbb005) THEN 
               IF l_cmd = 'a' OR (l_cmd = 'u' AND g_ecbb_d[l_ac].ecbb005<>　g_ecbb_d_t.ecbb005) THEN
                  IF NOT cl_null(g_ecbb_d[l_ac].ecbb004) THEN
                     CALL aecm200_chk_ecbb004(l_cmd)
                     IF NOT cl_null(g_errno) THEN
                        INITIALIZE g_errparam TO NULL
                        LET g_errparam.code = g_errno
                        LET g_errparam.extend = g_ecbb_d[l_ac].ecbb005
                        LET g_errparam.popup = TRUE
                        CALL cl_err()

                        LET g_ecbb_d[l_ac].ecbb005 = g_ecbb_d_t.ecbb005
                        NEXT FIELD ecbb005
                     END IF
                  END IF
               END IF
            END IF 
            
            #END add-point
            
 
         #此段落由子樣板a01產生
         BEFORE FIELD ecbb005
            #add-point:BEFORE FIELD ecbb005

            #END add-point
 
         #此段落由子樣板a04產生
         ON CHANGE ecbb005
            #add-point:ON CHANGE ecbb005

            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD ecbb006
            #add-point:BEFORE FIELD ecbb006

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD ecbb006
            
            #add-point:AFTER FIELD ecbb006
            IF NOT cl_null(g_ecbb_d[l_ac].ecbb007) THEN
               IF NOT cl_null(g_ecbb_d[l_ac].ecbb006) THEN
                  LET l_n1 = 0
                  SELECT COUNT(*) INTO l_n1
                    FROM ecbb_t
                   WHERE ecbbent = g_enterprise
                     AND ecbbsite = g_site
                     AND ecbb001 = g_ecba_m.ecba001
                     AND ecbb002 = g_ecba_m.ecba002
                     AND ecbb003 <> g_ecbb_d[l_ac].ecbb003
                     AND ecbb006 <>'1'
                     AND ecbb006 <> g_ecbb_d[l_ac].ecbb006
                     AND ecbb007 = g_ecbb_d[l_ac].ecbb007
                  IF l_n1 > 0 THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = 'aec-00026'
                     LET g_errparam.extend = g_ecbb_d[l_ac].ecbb006
                     LET g_errparam.popup = TRUE
                     CALL cl_err()

                     LET g_ecbb_d[l_ac].ecbb006 = g_ecbb_d_t.ecbb006
                     NEXT FIELD ecbb006
                  END IF
               END IF
            END IF
            CALL aecm200_set_entry_b(l_cmd)
            CALL aecm200_set_no_entry_b(l_cmd)
            #END add-point
            
 
         #此段落由子樣板a04產生
         ON CHANGE ecbb006
            #add-point:ON CHANGE ecbb006
            
            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD ecbb007
            #add-point:BEFORE FIELD ecbb007

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD ecbb007
            
            #add-point:AFTER FIELD ecbb007
            IF NOT cl_null(g_ecbb_d[l_ac].ecbb007) THEN
               IF NOT cl_null(g_ecbb_d[l_ac].ecbb006) THEN
                  LET l_n1 = 0
                  SELECT COUNT(*) INTO l_n1
                    FROM ecbb_t
                   WHERE ecbbent = g_enterprise
                     AND ecbbsite = g_site
                     AND ecbb001 = g_ecba_m.ecba001
                     AND ecbb002 = g_ecba_m.ecba002
                     AND ecbb003 <> g_ecbb_d[l_ac].ecbb003
                     AND ecbb006 <>'1'
                     AND ecbb006 <> g_ecbb_d[l_ac].ecbb006
                     AND ecbb007 = g_ecbb_d[l_ac].ecbb007
                  IF l_n1 > 0 THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = 'aec-00026'
                     LET g_errparam.extend = g_ecbb_d[l_ac].ecbb007
                     LET g_errparam.popup = TRUE
                     CALL cl_err()

                     LET g_ecbb_d[l_ac].ecbb007 = g_ecbb_d_t.ecbb007
                     NEXT FIELD ecbb007
                  END IF
               END IF
            END IF
            #END add-point
            
 
         #此段落由子樣板a04產生
         ON CHANGE ecbb007
            #add-point:ON CHANGE ecbb007

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD ecbb008
            
            #add-point:AFTER FIELD ecbb008
            CALL aecm200_ecbb_desc()
            IF NOT cl_null(g_ecbb_d[l_ac].ecbb008) THEN
               IF NOT cl_null(g_ecbb_d[l_ac].ecbb009) THEN
                  CALL aecm200_chk_ecbb008(l_cmd)
                  IF NOT cl_null(g_errno) THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = g_errno
                     LET g_errparam.extend = g_ecbb_d[l_ac].ecbb008
                     LET g_errparam.popup = TRUE
                     CALL cl_err()

                     LET g_ecbb_d[l_ac].ecbb008 = g_ecbb_d_t.ecbb008
                     CALL aecm200_ecbb_desc()
                     NEXT FIELD ecbb008
                  END IF
               END IF
               IF NOT cl_null(g_ecbb_d[l_ac].ecbb004) AND 
                  NOT cl_null(g_ecbb_d[l_ac].ecbb005) AND 
                  NOT cl_null(g_ecbb_d[l_ac].ecbb008) AND 
                  NOT cl_null(g_ecbb_d[l_ac].ecbb009) THEN
                  IF g_ecbb_d[l_ac].ecbb008 = g_ecbb_d[l_ac].ecbb004 AND 
                     g_ecbb_d[l_ac].ecbb009 = g_ecbb_d[l_ac].ecbb005 THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = 'aec-00008'
                     LET g_errparam.extend = g_ecbb_d[l_ac].ecbb008
                     LET g_errparam.popup = TRUE
                     CALL cl_err()

                     LET g_ecbb_d[l_ac].ecbb008 = g_ecbb_d_t.ecbb008
                     CALL aecm200_ecbb_desc()
                     NEXT FIELD ecbb008
                  END IF
               END IF
               IF NOT cl_null(g_ecbb_d[l_ac].ecbb003) AND 
                  NOT cl_null(g_ecbb_d[l_ac].ecbb004) AND 
                  NOT cl_null(g_ecbb_d[l_ac].ecbb005) AND 
                      g_ecbb_d[l_ac].ecbb008 = 'MULT' THEN
                  SELECT COUNT(*) INTO l_n4 FROM ecbe_t 
                   WHERE ecbeent = g_enterprise AND ecbesite = g_site 
                     AND ecbe001 = g_ecba_m.ecba001 AND ecbe002 = g_ecba_m.ecba002
                     AND ecbe003 = g_ecbb_d[l_ac].ecbb003
                  IF l_n4 <= 1 THEN
                     CALL aecm200_01(g_ecba_m.ecba001,g_ecba_m.ecba002,g_ecbb_d[l_ac].ecbb003,g_ecbb_d[l_ac].ecbb004,g_ecbb_d[l_ac].ecbb005,'Y','Y')
                  END IF
                  SELECT COUNT(*) INTO l_n4 FROM ecbe_t 
                   WHERE ecbeent = g_enterprise AND ecbesite = g_site 
                     AND ecbe001 = g_ecba_m.ecba001 AND ecbe002 = g_ecba_m.ecba002
                     AND ecbe003 = g_ecbb_d[l_ac].ecbb003
                  IF l_n4 = 0 THEN 
                     LET g_ecbb_d[l_ac].ecbb008 = ''
                     LET g_ecbb_d[l_ac].ecbb008_desc = ''
                     LET g_ecbb_d[l_ac].ecbb009 = ''
                  END IF
                  IF l_n4 = 1 THEN
                     SELECT ecbe004,ecbe005 INTO g_ecbb_d[l_ac].ecbb008,g_ecbb_d[l_ac].ecbb009 FROM ecbe_t
                      WHERE ecbeent = g_enterprise AND ecbesite = g_site 
                        AND ecbe001 = g_ecba_m.ecba001 AND ecbe002 = g_ecba_m.ecba002
                        AND ecbe003 = g_ecbb_d[l_ac].ecbb003
                     CALL aecm200_ecbb_desc()
                  END IF
                  IF l_n4 > 1 THEN
                     LET g_ecbb_d[l_ac].ecbb008 = 'MULT'
                     LET g_ecbb_d[l_ac].ecbb008_desc = ''
                     LET g_ecbb_d[l_ac].ecbb009 = '0'
                  END IF
               END IF
               #160224-00022#1---add--begin
               IF NOT cl_null(g_ecbb_d[l_ac].ecbb009) THEN
                  IF g_ecbb_d[l_ac].ecbb008 <> g_ecbb_d_o.ecbb008 OR cl_null(g_ecbb_d_o.ecbb008) 
                   OR g_ecbb_d[l_ac].ecbb009 <> g_ecbb_d_o.ecbb009 OR cl_null(g_ecbb_d_o.ecbb009) THEN 
                     LET l_cnt = 0
                     SELECT COUNT(ecbb004) INTO l_cnt
                       FROM ecbb_t
                      WHERE ecbbent = g_enterprise
                        AND ecbb001 = g_ecba_m.ecba001
                        AND ecbb002 = g_ecba_m.ecba002
                        AND ecbb008 = g_ecbb_d[l_ac].ecbb008
                     IF l_cnt = 0 THEN 
                        UPDATE ecbb_t
                           SET ecbb010 = g_ecbb_d[l_ac].ecbb004,
                               ecbb011 = g_ecbb_d[l_ac].ecbb005
                         WHERE ecbbent = g_enterprise
                           AND ecbb001 = g_ecba_m.ecba001
                           AND ecbb002 = g_ecba_m.ecba002
                           AND ecbb004 = g_ecbb_d[l_ac].ecbb008
                           AND ecbb005 = g_ecbb_d[l_ac].ecbb009                         
                     ELSE
                        UPDATE ecbb_t
                           SET ecbb010 = 'MULT',
                               ecbb011 = '0'
                         WHERE ecbbent = g_enterprise
                           AND ecbb001 = g_ecba_m.ecba001
                           AND ecbb002 = g_ecba_m.ecba002
                           AND ecbb004 = g_ecbb_d[l_ac].ecbb008
                           AND ecbb005 = g_ecbb_d[l_ac].ecbb009                       
                     END IF
                  END IF
               END IF   
               #160224-00022#1---add---end               
            END IF
            CALL aecm200_set_entry_b(l_cmd)
            CALL aecm200_set_no_entry_b(l_cmd)
            LET g_ecbb_d_o.ecbb008 = g_ecbb_d[l_ac].ecbb008   #160224-00022#1 add
            LET g_ecbb_d_o.ecbb009 = g_ecbb_d[l_ac].ecbb009   #160224-00022#1 add
            #END add-point
            
 
         #此段落由子樣板a01產生
         BEFORE FIELD ecbb008
            #add-point:BEFORE FIELD ecbb008
         
            #END add-point
 
         #此段落由子樣板a04產生
         ON CHANGE ecbb008
            #add-point:ON CHANGE ecbb008
            
            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD ecbb009
            #add-point:BEFORE FIELD ecbb009

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD ecbb009
            
            #add-point:AFTER FIELD ecbb009
            CALL aecm200_ecbb_desc()
            IF NOT cl_null(g_ecbb_d[l_ac].ecbb009) THEN
               IF NOT cl_null(g_ecbb_d[l_ac].ecbb008) THEN
                  CALL aecm200_chk_ecbb008(l_cmd)
                  IF NOT cl_null(g_errno) THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = g_errno
                     LET g_errparam.extend = g_ecbb_d[l_ac].ecbb009
                     LET g_errparam.popup = TRUE
                     CALL cl_err()

                     LET g_ecbb_d[l_ac].ecbb009 = g_ecbb_d_t.ecbb009
                     CALL aecm200_ecbb_desc()
                     NEXT FIELD ecbb009
                  END IF
               END IF
               IF NOT cl_null(g_ecbb_d[l_ac].ecbb004) AND NOT cl_null(g_ecbb_d[l_ac].ecbb005) AND NOT cl_null(g_ecbb_d[l_ac].ecbb008) AND NOT cl_null(g_ecbb_d[l_ac].ecbb009) THEN
                  IF g_ecbb_d[l_ac].ecbb008 = g_ecbb_d[l_ac].ecbb004 AND g_ecbb_d[l_ac].ecbb009 = g_ecbb_d[l_ac].ecbb005 THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = 'aec-00008'
                     LET g_errparam.extend = g_ecbb_d[l_ac].ecbb008
                     LET g_errparam.popup = TRUE
                     CALL cl_err()

                     LET g_ecbb_d[l_ac].ecbb009 = g_ecbb_d_t.ecbb009
                     CALL aecm200_ecbb_desc()
                     NEXT FIELD ecbb009
                  END IF
               END IF
               #160224-00022#1---add--begin
               IF NOT cl_null(g_ecbb_d[l_ac].ecbb008) THEN
                  IF g_ecbb_d[l_ac].ecbb008 <> g_ecbb_d_o.ecbb008 OR cl_null(g_ecbb_d_o.ecbb008) 
                   OR g_ecbb_d[l_ac].ecbb009 <> g_ecbb_d_o.ecbb009 OR cl_null(g_ecbb_d_o.ecbb009) THEN 
                     LET l_cnt = 0
                     SELECT COUNT(ecbb004) INTO l_cnt
                       FROM ecbb_t
                      WHERE ecbbent = g_enterprise
                        AND ecbb001 = g_ecba_m.ecba001
                        AND ecbb002 = g_ecba_m.ecba002
                        AND ecbb008 = g_ecbb_d[l_ac].ecbb008
                     IF l_cnt = 0 THEN 
                        UPDATE ecbb_t
                           SET ecbb010 = g_ecbb_d[l_ac].ecbb004,
                               ecbb011 = g_ecbb_d[l_ac].ecbb005
                         WHERE ecbbent = g_enterprise
                           AND ecbb001 = g_ecba_m.ecba001
                           AND ecbb002 = g_ecba_m.ecba002
                           AND ecbb004 = g_ecbb_d[l_ac].ecbb008
                           AND ecbb005 = g_ecbb_d[l_ac].ecbb009                         
                     ELSE
                        UPDATE ecbb_t
                           SET ecbb010 = 'MULT',
                               ecbb011 = '0'
                         WHERE ecbbent = g_enterprise
                           AND ecbb001 = g_ecba_m.ecba001
                           AND ecbb002 = g_ecba_m.ecba002
                           AND ecbb004 = g_ecbb_d[l_ac].ecbb008
                           AND ecbb005 = g_ecbb_d[l_ac].ecbb009                       
                     END IF
                  END IF
               END IF   
               #160224-00022#1---add---end                
            END IF
            LET g_ecbb_d_o.ecbb008 = g_ecbb_d[l_ac].ecbb008   #160224-00022#1 add
            LET g_ecbb_d_o.ecbb009 = g_ecbb_d[l_ac].ecbb009   #160224-00022#1 add            
            #END add-point
            
 
         #此段落由子樣板a04產生
         ON CHANGE ecbb009
            #add-point:ON CHANGE ecbb009

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD ecbb010
            
            #add-point:AFTER FIELD ecbb010
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_ecbb_d[l_ac].ecbb010
            CALL ap_ref_array2(g_ref_fields,"SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql002=? AND oocql003='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_ecbb_d[l_ac].ecbb010_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_ecbb_d[l_ac].ecbb010_desc

            #END add-point
            
 
         #此段落由子樣板a01產生
         BEFORE FIELD ecbb010
            #add-point:BEFORE FIELD ecbb010

            #END add-point
 
         #此段落由子樣板a04產生
         ON CHANGE ecbb010
            #add-point:ON CHANGE ecbb010

            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD ecbb011
            #add-point:BEFORE FIELD ecbb011

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD ecbb011
            
            #add-point:AFTER FIELD ecbb011

            #END add-point
            
 
         #此段落由子樣板a04產生
         ON CHANGE ecbb011
            #add-point:ON CHANGE ecbb011

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD ecbb012
            
            #add-point:AFTER FIELD ecbb012
            CALL aecm200_ecbb_desc()
            IF NOT cl_null(g_ecbb_d[l_ac].ecbb012) THEN
               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
               INITIALIZE g_chkparam.* TO NULL

               #設定g_chkparam.*的參數
               LET g_chkparam.arg1 = g_ecbb_d[l_ac].ecbb012
               #160318-00025#3--add--str
               LET g_errshow = TRUE 
               LET g_chkparam.err_str[1] = "aec-00010:sub-01302|aeci001|",cl_get_progname("aeci001",g_lang,"2"),"|:EXEPROGaeci001"
               #160318-00025#3--add--end
               #呼叫檢查存在並帶值的library
               IF NOT cl_chk_exist("v_ecaa001_1") THEN
                  LET g_ecbb_d[l_ac].ecbb012 = g_ecbb_d_t.ecbb012
                  CALL aecm200_ecbb_desc()
                  NEXT FIELD ecbb012
               END IF
               
            END IF

            #END add-point
            
 
         #此段落由子樣板a01產生
         BEFORE FIELD ecbb012
            #add-point:BEFORE FIELD ecbb012

            #END add-point
 
         #此段落由子樣板a04產生
         ON CHANGE ecbb012
            #add-point:ON CHANGE ecbb012
         
        #141006-00003#1 add 
         AFTER FIELD ecbb037
            CALL aecm200_ecbb_desc()
            IF NOT cl_null(g_ecbb_d[l_ac].ecbb037) AND (cl_null(g_ecbb_d_t.ecbb037) OR g_ecbb_d[l_ac].ecbb037 != g_ecbb_d_t.ecbb037) THEN
               CALL s_azzi650_chk_exist('1103',g_ecbb_d[l_ac].ecbb037) RETURNING l_success
               IF NOT l_success THEN
                  LET g_ecbb_d[l_ac].ecbb037 = g_ecbb_d_t.ecbb037
                  CALL aecm200_ecbb_desc()
                  NEXT FIELD ecbb037
               #add--151215-00002#4 By shiun--(S)
               ELSE
                  LET l_n5 = 0
                  SELECT COUNT(*) INTO l_n5 FROM oocq_t
                   WHERE oocqent = g_enterprise AND oocq001 = '1103' 
                     AND oocq002 = g_ecbb_d[l_ac].ecbb037 AND oocq019 = '1'  
                  
                  IF l_n5 = 0 OR cl_null(l_n5) THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = 'aec-00052'
                     LET g_errparam.extend = g_ecbb_d[l_ac].ecbb037
                     LET g_errparam.popup = TRUE
                     CALL cl_err()                   
                     LET g_ecbb_d[l_ac].ecbb037 = g_ecbb_d_t.ecbb037
                     CALL aecm200_ecbb_desc()
                     NEXT FIELD ecbb037  
                  END IF
               #add--151215-00002#4 By shiun--(E)
               END IF
               IF cl_get_para(g_enterprise,g_site,'S-MFG-0036') = '1' THEN
                  SELECT COUNT(*) INTO l_n3 FROM oocq_t
                   WHERE oocqent = g_enterprise AND oocq001 = '1103' 
                     AND oocq002 = g_ecbb_d[l_ac].ecbb037 AND oocq014 = 'Y'    
                  IF l_n3 > 0 THEN
                     SELECT COUNT(*) INTO l_n3 FROM ecbb_t,oocq_t
                      WHERE ecbbent = oocqent AND ecbb037 = oocq002 AND oocq001 = '1103' AND oocq014 = 'Y'
                        AND ecbbent = g_enterprise AND ecbbsite = g_site
                        AND ecbb001 = g_ecba_m.ecba001 AND ecbb002 = g_ecba_m.ecba002
                     IF l_n3 > 0 THEN
                        INITIALIZE g_errparam TO NULL
                        LET g_errparam.code = 'aec-00044'
                        LET g_errparam.extend = g_ecbb_d[l_ac].ecbb037
                        LET g_errparam.popup = TRUE
                        CALL cl_err()                   
                        LET g_ecbb_d[l_ac].ecbb037 = g_ecbb_d_t.ecbb037
                        CALL aecm200_ecbb_desc()
                        NEXT FIELD ecbb037  
                     END IF
                  END IF                     
               END IF
               LET g_aecm200_05_chk = TRUE   #add--151215-00002#4 By shiun
            END IF
            #add--151215-00002#4 By shiun--(S)
            IF cl_null(g_ecbb_d[l_ac].ecbb037) AND NOT cl_null(g_ecbb_d_t.ecbb037) THEN
               LET g_aecm200_05_chk = TRUE
            END IF
            IF g_ecbb_d[l_ac].ecbb037 = g_ecbb_d_t.ecbb037 AND g_ecbb_d[l_ac].ecbb038 = g_ecbb_d_t.ecbb038 THEN
               LET g_aecm200_05_chk = FALSE
            END IF
            #add--151215-00002#4 By shiun--(E)
            #add--151215-00002#4 By shiun--(S)
            AFTER FIELD ecbb038
            CALL aecm200_ecbb_desc()
            IF NOT cl_null(g_ecbb_d[l_ac].ecbb038) AND (cl_null(g_ecbb_d_t.ecbb038) OR g_ecbb_d[l_ac].ecbb038 != g_ecbb_d_t.ecbb038) THEN
               CALL s_azzi650_chk_exist('1103',g_ecbb_d[l_ac].ecbb038) RETURNING l_success
               IF NOT l_success THEN
                  LET g_ecbb_d[l_ac].ecbb038 = g_ecbb_d_t.ecbb038
                  CALL aecm200_ecbb_desc()
                  NEXT FIELD ecbb038
               ELSE
                  LET l_n5 = 0
                  SELECT COUNT(*) INTO l_n5 FROM oocq_t
                   WHERE oocqent = g_enterprise AND oocq001 = '1103' 
                     AND oocq002 = g_ecbb_d[l_ac].ecbb038 AND oocq019 = '2'  
                  
                  IF l_n5 = 0 OR cl_null(l_n5) THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = 'aec-00053'
                     LET g_errparam.extend = g_ecbb_d[l_ac].ecbb038
                     LET g_errparam.popup = TRUE
                     CALL cl_err()                   
                     LET g_ecbb_d[l_ac].ecbb038 = g_ecbb_d_t.ecbb038
                     CALL aecm200_ecbb_desc()
                     NEXT FIELD ecbb038                 
                  END IF               
               END IF
               LET g_aecm200_05_chk = TRUE
            END IF
            IF cl_null(g_ecbb_d[l_ac].ecbb038) AND NOT cl_null(g_ecbb_d_t.ecbb038) THEN
               LET g_aecm200_05_chk = TRUE
            END IF
            IF g_ecbb_d[l_ac].ecbb037 = g_ecbb_d_t.ecbb037 AND g_ecbb_d[l_ac].ecbb038 = g_ecbb_d_t.ecbb038 THEN
               LET g_aecm200_05_chk = FALSE
            END IF
            #add--151215-00002#4 By shiun--(E)
            #END add-point
         
         #此段落由子樣板a02產生
         AFTER FIELD ecbb024
            #此段落由子樣板a15產生
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_ecbb_d[l_ac].ecbb024,"0.000","1","","","azz-00079",1) THEN
               NEXT FIELD ecbb024
            END IF
 
 
            #add-point:AFTER FIELD ecbb024
            IF NOT cl_null(g_ecbb_d[l_ac].ecbb024) THEN 
            END IF 

            #END add-point
            
 
         #此段落由子樣板a01產生
         BEFORE FIELD ecbb024
            #add-point:BEFORE FIELD ecbb024

            #END add-point
 
         #此段落由子樣板a04產生
         ON CHANGE ecbb024
            #add-point:ON CHANGE ecbb024

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD ecbb025
            #此段落由子樣板a15產生
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_ecbb_d[l_ac].ecbb025,"0.000","1","","","azz-00079",1) THEN
               NEXT FIELD ecbb025
            END IF
 
 
            #add-point:AFTER FIELD ecbb025
            IF NOT cl_null(g_ecbb_d[l_ac].ecbb025) THEN 
            END IF 

            #END add-point
            
 
         #此段落由子樣板a01產生
         BEFORE FIELD ecbb025
            #add-point:BEFORE FIELD ecbb025

            #END add-point
 
         #此段落由子樣板a04產生
         ON CHANGE ecbb025
            #add-point:ON CHANGE ecbb025

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD ecbb026
            #此段落由子樣板a15產生
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_ecbb_d[l_ac].ecbb026,"0.000","1","","","azz-00079",1) THEN
               NEXT FIELD ecbb026
            END IF
 
 
            #add-point:AFTER FIELD ecbb026
            IF NOT cl_null(g_ecbb_d[l_ac].ecbb026) THEN 
            END IF 

            #END add-point
            
 
         #此段落由子樣板a01產生
         BEFORE FIELD ecbb026
            #add-point:BEFORE FIELD ecbb026

            #END add-point
 
         #此段落由子樣板a04產生
         ON CHANGE ecbb026
            #add-point:ON CHANGE ecbb026

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD ecbb027
            #此段落由子樣板a15產生
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_ecbb_d[l_ac].ecbb027,"0.000","1","","","azz-00079",1) THEN
               NEXT FIELD ecbb027
            END IF
 
 
            #add-point:AFTER FIELD ecbb027
            IF NOT cl_null(g_ecbb_d[l_ac].ecbb027) THEN 
            END IF 

            #END add-point
            
 
         #此段落由子樣板a01產生
         BEFORE FIELD ecbb027
            #add-point:BEFORE FIELD ecbb027

            #END add-point
 
         #此段落由子樣板a04產生
         ON CHANGE ecbb027
            #add-point:ON CHANGE ecbb027

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD ecbb034
            #此段落由子樣板a15產生
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_ecbb_d[l_ac].ecbb034,"0.000","1","","","azz-00079",1) THEN
               NEXT FIELD ecbb034
            END IF
 
 
            #add-point:AFTER FIELD ecbb034
            IF NOT cl_null(g_ecbb_d[l_ac].ecbb034) THEN 
            END IF 

            #END add-point
            
 
         #此段落由子樣板a01產生
         BEFORE FIELD ecbb034
            #add-point:BEFORE FIELD ecbb034

            #END add-point
 
         #此段落由子樣板a04產生
         ON CHANGE ecbb034
            #add-point:ON CHANGE ecbb034

            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD ecbb013
            #add-point:BEFORE FIELD ecbb013

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD ecbb013
            
            #add-point:AFTER FIELD ecbb013

            #END add-point
            
 
         #此段落由子樣板a04產生
         ON CHANGE ecbb013
            #add-point:ON CHANGE ecbb013

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD ecbb014
            
            #add-point:AFTER FIELD ecbb014
            
            CALL aecm200_ecbb_desc()
            IF NOT cl_null(g_ecbb_d[l_ac].ecbb014) THEN
               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
               INITIALIZE g_chkparam.* TO NULL

               #設定g_chkparam.*的參數
               LET g_chkparam.arg1 = g_ecbb_d[l_ac].ecbb014

               #呼叫檢查存在並帶值的library
               IF NOT cl_chk_exist("v_pmaa001_1") THEN
                  LET g_ecbb_d[l_ac].ecbb014 = g_ecbb_d_t.ecbb014
                  CALL aecm200_ecbb_desc()
                  NEXT FIELD ecbb014
               END IF
               
            END IF
            #END add-point
            
 
         #此段落由子樣板a01產生
         BEFORE FIELD ecbb014
            #add-point:BEFORE FIELD ecbb014

            #END add-point
 
         #此段落由子樣板a04產生
         ON CHANGE ecbb014
            #add-point:ON CHANGE ecbb014

            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD ecbb015
            #add-point:BEFORE FIELD ecbb015

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD ecbb015
            
            #add-point:AFTER FIELD ecbb015

            #END add-point
            
 
         #此段落由子樣板a04產生
         ON CHANGE ecbb015
            #add-point:ON CHANGE ecbb015

            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD ecbb016
            #add-point:BEFORE FIELD ecbb016

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD ecbb016
            
            #add-point:AFTER FIELD ecbb016

            #END add-point
            
 
         #此段落由子樣板a04產生
         ON CHANGE ecbb016
            #add-point:ON CHANGE ecbb016

            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD ecbb017
            #add-point:BEFORE FIELD ecbb017

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD ecbb017
            
            #add-point:AFTER FIELD ecbb017

            #END add-point
            
 
         #此段落由子樣板a04產生
         ON CHANGE ecbb017
            #add-point:ON CHANGE ecbb017

            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD ecbb018
            #add-point:BEFORE FIELD ecbb018

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD ecbb018
            
            #add-point:AFTER FIELD ecbb018

            #END add-point
            
 
         #此段落由子樣板a04產生
         ON CHANGE ecbb018
            #add-point:ON CHANGE ecbb018

            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD ecbb019
            #add-point:BEFORE FIELD ecbb019

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD ecbb019
            
            #add-point:AFTER FIELD ecbb019

            #END add-point
            
 
         #此段落由子樣板a04產生
         ON CHANGE ecbb019
            #add-point:ON CHANGE ecbb019

            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD ecbb020
            #add-point:BEFORE FIELD ecbb020

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD ecbb020
            
            #add-point:AFTER FIELD ecbb020

            #END add-point
            
 
         #此段落由子樣板a04產生
         ON CHANGE ecbb020
            #add-point:ON CHANGE ecbb020

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD ecbb030
            
            #add-point:AFTER FIELD ecbb030
            IF NOT cl_null(g_ecbb_d[l_ac].ecbb030) THEN 
#此段落由子樣板a19產生
               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
               INITIALIZE g_chkparam.* TO NULL
               
               #設定g_chkparam.*的參數
               LET g_chkparam.arg1 = g_ecbb_d[l_ac].ecbb030
               #160318-00025#3--add--str
               LET g_errshow = TRUE 
               LET g_chkparam.err_str[1] = "aim-00005:sub-01302|aooi250|",cl_get_progname("aooi250",g_lang,"2"),"|:EXEPROGaooi250"
               #160318-00025#3--add--end
                  
               #呼叫檢查存在並帶值的library
               IF NOT cl_chk_exist("v_ooca001") THEN
                  LET g_ecbb_d[l_ac].ecbb030 = g_ecbb_d_t.ecbb030
                  NEXT FIELD ecbb030
               END IF
            END IF
            #END add-point
            
 
         #此段落由子樣板a01產生
         BEFORE FIELD ecbb030
            #add-point:BEFORE FIELD ecbb030

            #END add-point
 
         #此段落由子樣板a04產生
         ON CHANGE ecbb030
            #add-point:ON CHANGE ecbb030

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD ecbb031
            #此段落由子樣板a15產生
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_ecbb_d[l_ac].ecbb031,"0.000000","1","","","azz-00079",1) THEN
               NEXT FIELD ecbb031
            END IF
 
 
            #add-point:AFTER FIELD ecbb031
            IF NOT cl_null(g_ecbb_d[l_ac].ecbb031) THEN 
            END IF 

            #END add-point
            
 
         #此段落由子樣板a01產生
         BEFORE FIELD ecbb031
            #add-point:BEFORE FIELD ecbb031

            #END add-point
 
         #此段落由子樣板a04產生
         ON CHANGE ecbb031
            #add-point:ON CHANGE ecbb031

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD ecbb032
            #此段落由子樣板a15產生
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_ecbb_d[l_ac].ecbb032,"0.000000","0","","","azz-00079",1) THEN
               NEXT FIELD ecbb032
            END IF
 
 
            #add-point:AFTER FIELD ecbb032
            IF NOT cl_null(g_ecbb_d[l_ac].ecbb032) THEN 
            END IF 

            #END add-point
            
 
         #此段落由子樣板a01產生
         BEFORE FIELD ecbb032
            #add-point:BEFORE FIELD ecbb032

            #END add-point
 
         #此段落由子樣板a04產生
         ON CHANGE ecbb032
            #add-point:ON CHANGE ecbb032

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD ecbb021
            
            #add-point:AFTER FIELD ecbb021
            IF NOT cl_null(g_ecbb_d[l_ac].ecbb021) THEN
               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
               INITIALIZE g_chkparam.* TO NULL

               #設定g_chkparam.*的參數
               LET g_chkparam.arg1 = g_ecbb_d[l_ac].ecbb021
               #160318-00025#3--add--str
               LET g_errshow = TRUE 
               LET g_chkparam.err_str[1] = "aim-00005:sub-01302|aooi250|",cl_get_progname("aooi250",g_lang,"2"),"|:EXEPROGaooi250"
               #160318-00025#3--add--end
               #呼叫檢查存在並帶值的library
               IF NOT cl_chk_exist("v_ooca001") THEN
                  LET g_ecbb_d[l_ac].ecbb021 = g_ecbb_d_t.ecbb021
                  NEXT FIELD ecbb021
               END IF
               
            END IF
            #END add-point
            
 
         #此段落由子樣板a01產生
         BEFORE FIELD ecbb021
            #add-point:BEFORE FIELD ecbb021

            #END add-point
 
         #此段落由子樣板a04產生
         ON CHANGE ecbb021
            #add-point:ON CHANGE ecbb021

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD ecbb022
            #此段落由子樣板a15產生
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_ecbb_d[l_ac].ecbb022,"0.000000","1","","","azz-00079",1) THEN
               NEXT FIELD ecbb022
            END IF
 
 
            #add-point:AFTER FIELD ecbb022
            IF NOT cl_null(g_ecbb_d[l_ac].ecbb022) THEN 
            END IF 

            #END add-point
            
 
         #此段落由子樣板a01產生
         BEFORE FIELD ecbb022
            #add-point:BEFORE FIELD ecbb022

            #END add-point
 
         #此段落由子樣板a04產生
         ON CHANGE ecbb022
            #add-point:ON CHANGE ecbb022

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD ecbb023
            #此段落由子樣板a15產生
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_ecbb_d[l_ac].ecbb023,"0.000000","0","","","azz-00079",1) THEN
               NEXT FIELD ecbb023
            END IF
 
 
            #add-point:AFTER FIELD ecbb023
            IF NOT cl_null(g_ecbb_d[l_ac].ecbb023) THEN 
            END IF 

            #END add-point
            
 
         #此段落由子樣板a01產生
         BEFORE FIELD ecbb023
            #add-point:BEFORE FIELD ecbb023

            #END add-point
 
         #此段落由子樣板a04產生
         ON CHANGE ecbb023
            #add-point:ON CHANGE ecbb023

            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD ecbb033
            #add-point:BEFORE FIELD ecbb033

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD ecbb033
            
            #add-point:AFTER FIELD ecbb033
            IF g_ecbb_d[l_ac].ecbb033 = 'Y' THEN
               IF l_cmd = 'a' OR (l_cmd = 'u' AND g_ecbb_d[l_ac].ecbb033<>　g_ecbb_d_t.ecbb033) THEN
                  LET l_n1 = 0 
                  SELECT COUNT(*) INTO l_n1
                    FROM ecbb_t
                   WHERE ecbbent = g_enterprise
                     AND ecbbsite = g_site
                     AND ecbb001 = g_ecba_m.ecba001
                     AND ecbb002 = g_ecba_m.ecba002
                     AND ecbb003 <> g_ecbb_d[l_ac].ecbb003
                     AND ecbb033 = 'Y'
                  IF l_n1 > 0 THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = 'aec-00025'
                     LET g_errparam.extend = g_ecbb_d[l_ac].ecbb033
                     LET g_errparam.popup = TRUE
                     CALL cl_err()

                     LET g_ecbb_d[l_ac].ecbb033 = g_ecbb_d_t.ecbb033
                     NEXT FIELD ecbb033
                  END IF
               END IF
            END IF
            #END add-point
            
 
         #此段落由子樣板a04產生
         ON CHANGE ecbb033
            #add-point:ON CHANGE ecbb033

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD ecbb028
            #此段落由子樣板a15產生
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_ecbb_d[l_ac].ecbb028,"0.000","1","","","azz-00079",1) THEN
               NEXT FIELD ecbb028
            END IF
 
 
            #add-point:AFTER FIELD ecbb028
            IF NOT cl_null(g_ecbb_d[l_ac].ecbb028) THEN 
            END IF 

            #END add-point
            
 
         #此段落由子樣板a01產生
         BEFORE FIELD ecbb028
            #add-point:BEFORE FIELD ecbb028

            #END add-point
 
         #此段落由子樣板a04產生
         ON CHANGE ecbb028
            #add-point:ON CHANGE ecbb028

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD ecbb029
            #此段落由子樣板a15產生
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_ecbb_d[l_ac].ecbb029,"0.000","1","","","azz-00079",1) THEN
               NEXT FIELD ecbb029
            END IF
 
 
            #add-point:AFTER FIELD ecbb029
            IF NOT cl_null(g_ecbb_d[l_ac].ecbb029) THEN 
            END IF 

            #END add-point
            
 
         #此段落由子樣板a01產生
         BEFORE FIELD ecbb029
            #add-point:BEFORE FIELD ecbb029

            #END add-point
 
         #此段落由子樣板a04產生
         ON CHANGE ecbb029
            #add-point:ON CHANGE ecbb029

            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD ecbb035
            #add-point:BEFORE FIELD ecbb035

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD ecbb035
            
            #add-point:AFTER FIELD ecbb035

            #END add-point
            
 
         #此段落由子樣板a04產生
         ON CHANGE ecbb035
            #add-point:ON CHANGE ecbb035

            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD ecbb036
            #add-point:BEFORE FIELD ecbb036

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD ecbb036
            
            #add-point:AFTER FIELD ecbb036

            #END add-point
            
 
         #此段落由子樣板a04產生
         ON CHANGE ecbb036
            #add-point:ON CHANGE ecbb036

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
 
 
                  #Ctrlp:input.c.page1.ecbb003
         ON ACTION controlp INFIELD ecbb003
            #add-point:ON ACTION controlp INFIELD ecbb003

            #END add-point
 
         #Ctrlp:input.c.page1.ecbb004
         ON ACTION controlp INFIELD ecbb004
            #add-point:ON ACTION controlp INFIELD ecbb004
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'     #160201-00008#1-add
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_ecbb_d[l_ac].ecbb004      #給予default值
            LET g_qryparam.arg1 = "221" 
            CALL q_oocq002()                                      #呼叫開窗
            LET g_ecbb_d[l_ac].ecbb004 = g_qryparam.return1       #將開窗取得的值回傳到變數
            DISPLAY g_ecbb_d[l_ac].ecbb004 TO ecbb004             #顯示到畫面上
            CALL aecm200_ecbb_desc()
            NEXT FIELD ecbb004                                    #返回原欄位


            #END add-point
 
         #Ctrlp:input.c.page1.ecbb005
         ON ACTION controlp INFIELD ecbb005
            #add-point:ON ACTION controlp INFIELD ecbb005

            #END add-point
 
         #Ctrlp:input.c.page1.ecbb006
         ON ACTION controlp INFIELD ecbb006
            #add-point:ON ACTION controlp INFIELD ecbb006

            #END add-point
 
         #Ctrlp:input.c.page1.ecbb007
         ON ACTION controlp INFIELD ecbb007
            #add-point:ON ACTION controlp INFIELD ecbb007

            #END add-point
 
         #Ctrlp:input.c.page1.ecbb008
         ON ACTION controlp INFIELD ecbb008
            #add-point:ON ACTION controlp INFIELD ecbb008
#此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'     #160201-00008#1-add
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_ecbb_d[l_ac].ecbb008             #給予default值
            LET g_qryparam.where = " ecbb001 = '",g_ecba_m.ecba001,"' AND ecbb002 = '",g_ecba_m.ecba002,"' "
            CALL q_ecbb004()                                             #呼叫開窗
            LET g_ecbb_d[l_ac].ecbb008 = g_qryparam.return1              #將開窗取得的值回傳到變數
            LET g_ecbb_d[l_ac].ecbb009 = g_qryparam.return2
            DISPLAY g_ecbb_d[l_ac].ecbb008 TO ecbb008                    #顯示到畫面上
            DISPLAY g_ecbb_d[l_ac].ecbb009 TO ecbb009  
            CALL aecm200_ecbb_desc()
            LET g_qryparam.where = ""
            NEXT FIELD ecbb008                                           #返回原欄位


            #END add-point
 
         #Ctrlp:input.c.page1.ecbb009
         ON ACTION controlp INFIELD ecbb009
            #add-point:ON ACTION controlp INFIELD ecbb009

            #END add-point
 
         #Ctrlp:input.c.page1.ecbb010
         ON ACTION controlp INFIELD ecbb010
            #add-point:ON ACTION controlp INFIELD ecbb010

            #END add-point
 
         #Ctrlp:input.c.page1.ecbb011
         ON ACTION controlp INFIELD ecbb011
            #add-point:ON ACTION controlp INFIELD ecbb011

            #END add-point
 
         #Ctrlp:input.c.page1.ecbb012
         ON ACTION controlp INFIELD ecbb012
            #add-point:ON ACTION controlp INFIELD ecbb012
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'     #160201-00008#1-add
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_ecbb_d[l_ac].ecbb012  #給予default值
            CALL q_ecaa001_1()                                #呼叫開窗
            LET g_ecbb_d[l_ac].ecbb012 = g_qryparam.return1   #將開窗取得的值回傳到變數
            DISPLAY g_ecbb_d[l_ac].ecbb012 TO ecbb012         #顯示到畫面上
            CALL aecm200_ecbb_desc()
            NEXT FIELD ecbb012                                #返回原欄位

         ON ACTION controlp INFIELD ecbb037
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'     #160201-00008#1-add
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_ecbb_d[l_ac].ecbb037            #給予default值
            LET g_qryparam.arg1 = "1103" 
            LET g_qryparam.where = " oocq019 = '1' "   #add--151215-00002#4 By shiun
            CALL q_oocq002()                                            #呼叫開窗
            LET g_ecbb_d[l_ac].ecbb037 = g_qryparam.return1             #將開窗取得的值回傳到變數
            DISPLAY g_ecbb_d[l_ac].ecbb037 TO ecbb037                   #顯示到畫面上
            CALL aecm200_ecbb_desc()
            NEXT FIELD ecbb037                                          #返回原欄位
            
            #add--151215-00002#4 By shiun--(S)
         ON ACTION controlp INFIELD ecbb038
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'     #160201-00008#1-add
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_ecbb_d[l_ac].ecbb038            #給予default值
            LET g_qryparam.arg1 = "1103" 
            LET g_qryparam.where = " oocq019 = '2' "
            CALL q_oocq002()                                            #呼叫開窗
            LET g_ecbb_d[l_ac].ecbb038 = g_qryparam.return1              #將開窗取得的值回傳到變數
            DISPLAY g_ecbb_d[l_ac].ecbb038 TO ecbb038              #顯示到畫面上
            CALL aecm200_ecbb_desc()
            NEXT FIELD ecbb038  
            #add--151215-00002#4 By shiun--(E)
            #END add-point
 
         #Ctrlp:input.c.page1.ecbb024
         ON ACTION controlp INFIELD ecbb024
            #add-point:ON ACTION controlp INFIELD ecbb024

            #END add-point
 
         #Ctrlp:input.c.page1.ecbb025
         ON ACTION controlp INFIELD ecbb025
            #add-point:ON ACTION controlp INFIELD ecbb025

            #END add-point
 
         #Ctrlp:input.c.page1.ecbb026
         ON ACTION controlp INFIELD ecbb026
            #add-point:ON ACTION controlp INFIELD ecbb026

            #END add-point
 
         #Ctrlp:input.c.page1.ecbb027
         ON ACTION controlp INFIELD ecbb027
            #add-point:ON ACTION controlp INFIELD ecbb027

            #END add-point
 
         #Ctrlp:input.c.page1.ecbb034
         ON ACTION controlp INFIELD ecbb034
            #add-point:ON ACTION controlp INFIELD ecbb034

            #END add-point
 
         #Ctrlp:input.c.page1.ecbb013
         ON ACTION controlp INFIELD ecbb013
            #add-point:ON ACTION controlp INFIELD ecbb013

            #END add-point
 
         #Ctrlp:input.c.page1.ecbb014
         ON ACTION controlp INFIELD ecbb014
            #add-point:ON ACTION controlp INFIELD ecbb014
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'     #160201-00008#1-add
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_ecbb_d[l_ac].ecbb014             #給予default值
            LET g_qryparam.arg1 = " ('1','3')" #交易對象類型
            CALL q_pmaa001_1()                                           #呼叫開窗
            LET g_ecbb_d[l_ac].ecbb014 = g_qryparam.return1              #將開窗取得的值回傳到變數
            DISPLAY g_ecbb_d[l_ac].ecbb014 TO ecbb014                    #顯示到畫面上
            CALL aecm200_ecbb_desc()
            NEXT FIELD ecbb014                                           #返回原欄位


            #END add-point
 
         #Ctrlp:input.c.page1.ecbb015
         ON ACTION controlp INFIELD ecbb015
            #add-point:ON ACTION controlp INFIELD ecbb015

            #END add-point
 
         #Ctrlp:input.c.page1.ecbb016
         ON ACTION controlp INFIELD ecbb016
            #add-point:ON ACTION controlp INFIELD ecbb016

            #END add-point
 
         #Ctrlp:input.c.page1.ecbb017
         ON ACTION controlp INFIELD ecbb017
            #add-point:ON ACTION controlp INFIELD ecbb017

            #END add-point
 
         #Ctrlp:input.c.page1.ecbb018
         ON ACTION controlp INFIELD ecbb018
            #add-point:ON ACTION controlp INFIELD ecbb018

            #END add-point
 
         #Ctrlp:input.c.page1.ecbb019
         ON ACTION controlp INFIELD ecbb019
            #add-point:ON ACTION controlp INFIELD ecbb019

            #END add-point
 
         #Ctrlp:input.c.page1.ecbb020
         ON ACTION controlp INFIELD ecbb020
            #add-point:ON ACTION controlp INFIELD ecbb020

            #END add-point
 
         #Ctrlp:input.c.page1.ecbb030
         ON ACTION controlp INFIELD ecbb030
            #add-point:ON ACTION controlp INFIELD ecbb030
            #此段落由子樣板a07產生            
            #開窗i段
			   INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
			   LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_ecbb_d[l_ac].ecbb030             #給予default值
            CALL q_ooca001()                                #呼叫開窗
            LET g_ecbb_d[l_ac].ecbb030 = g_qryparam.return1              #將開窗取得的值回傳到變數
            DISPLAY g_ecbb_d[l_ac].ecbb030 TO ecbb030              #顯示到畫面上
            NEXT FIELD ecbb030                          #返回原欄位


            #END add-point
 
         #Ctrlp:input.c.page1.ecbb031
         ON ACTION controlp INFIELD ecbb031
            #add-point:ON ACTION controlp INFIELD ecbb031

            #END add-point
 
         #Ctrlp:input.c.page1.ecbb032
         ON ACTION controlp INFIELD ecbb032
            #add-point:ON ACTION controlp INFIELD ecbb032

            #END add-point
 
         #Ctrlp:input.c.page1.ecbb021
         ON ACTION controlp INFIELD ecbb021
            #add-point:ON ACTION controlp INFIELD ecbb021
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'     #160201-00008#1-add
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_ecbb_d[l_ac].ecbb021             #給予default值
            CALL q_ooca001()                                             #呼叫開窗
            LET g_ecbb_d[l_ac].ecbb021 = g_qryparam.return1              #將開窗取得的值回傳到變數
            DISPLAY g_ecbb_d[l_ac].ecbb021 TO ecbb021                    #顯示到畫面上
            NEXT FIELD ecbb021                                           #返回原欄位


            #END add-point
 
         #Ctrlp:input.c.page1.ecbb022
         ON ACTION controlp INFIELD ecbb022
            #add-point:ON ACTION controlp INFIELD ecbb022

            #END add-point
 
         #Ctrlp:input.c.page1.ecbb023
         ON ACTION controlp INFIELD ecbb023
            #add-point:ON ACTION controlp INFIELD ecbb023

            #END add-point
 
         #Ctrlp:input.c.page1.ecbb033
         ON ACTION controlp INFIELD ecbb033
            #add-point:ON ACTION controlp INFIELD ecbb033

            #END add-point
 
         #Ctrlp:input.c.page1.ecbb028
         ON ACTION controlp INFIELD ecbb028
            #add-point:ON ACTION controlp INFIELD ecbb028

            #END add-point
 
         #Ctrlp:input.c.page1.ecbb029
         ON ACTION controlp INFIELD ecbb029
            #add-point:ON ACTION controlp INFIELD ecbb029

            #END add-point
 
         #Ctrlp:input.c.page1.ecbb035
         ON ACTION controlp INFIELD ecbb035
            #add-point:ON ACTION controlp INFIELD ecbb035

            #END add-point
 
         #Ctrlp:input.c.page1.ecbb036
         ON ACTION controlp INFIELD ecbb036
            #add-point:ON ACTION controlp INFIELD ecbb036

            #END add-point
 
         #Ctrlp:input.c.page1.ooff013
         ON ACTION controlp INFIELD ooff013
            #add-point:ON ACTION controlp INFIELD ooff013
            IF NOT cl_null(g_ecbb_d[l_ac].ecbb003) THEN
               CALL aooi360_02('7',g_site,g_ecba_m.ecba001,g_ecba_m.ecba002,g_ecbb_d[l_ac].ecbb003,'','','','','','','4')
               CALL s_aooi360_sel('7',g_site,g_ecba_m.ecba001,g_ecba_m.ecba002,g_ecbb_d[l_ac].ecbb003,'','','','','','','4') RETURNING l_success,g_ecbb_d[l_ac].ooff013
            END IF
            #END add-point
 
 
 
         ON ROW CHANGE
            IF INT_FLAG THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code   = 9001 
               LET g_errparam.popup  = FALSE 
               CALL cl_err()
 
               LET INT_FLAG = 0
               LET g_ecbb_d[l_ac].* = g_ecbb_d_t.*
               CLOSE aecm200_bcl
               CALL s_transaction_end('N','0')
               EXIT DIALOG 
            END IF
              
            IF l_lock_sw = 'Y' THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = g_ecbb_d[l_ac].ecbb003 
               LET g_errparam.code   = -263 
               LET g_errparam.popup  = TRUE 
               CALL cl_err()
 
               LET g_ecbb_d[l_ac].* = g_ecbb_d_t.*
            ELSE
            
               #add-point:單身修改前
               IF s_transaction_chk("N",0) THEN
                  CALL s_transaction_begin()
               END IF
               #add--151215-00002#4 By shiun--(S)
               IF g_aecm200_05_chk THEN
                  IF cl_null(g_ecbb_d[l_ac].ecbb037) AND cl_null(g_ecbb_d[l_ac].ecbb038) THEN
                     LET l_count_chk = 0
                     SELECT COUNT(*) INTO l_count_chk
                       FROM ecbh_t
                      WHERE ecbhent = g_enterprise
                        AND ecbhsite = g_site
                        AND ecbh001 = g_ecba_m.ecba001 
                        AND ecbh002 = g_ecba_m.ecba002
                        AND ecbh003 = g_ecbb_d[l_ac].ecbb003
                     IF l_count_chk > 0 THEN
                        IF NOT cl_ask_confirm('aec-00057') THEN   #是否刪除資源項目的資料
                           NEXT FIELD CURRENT
                        ELSE
                           DELETE FROM ecbh_t 
                            WHERE ecbhent = g_enterprise
                              AND ecbhsite = g_site
                              AND ecbh001 = g_ecba_m.ecba001 
                              AND ecbh002 = g_ecba_m.ecba002
                              AND ecbh003 = g_ecbb_d[l_ac].ecbb003
                           IF SQLCA.sqlcode THEN
                              INITIALIZE g_errparam TO NULL 
                              LET g_errparam.extend = 'delete ecbh_t:' 
                              LET g_errparam.code   = SQLCA.sqlcode 
                              LET g_errparam.popup  = TRUE 
                              CALL cl_err()
                              CALL s_transaction_end('N','0')
                              CONTINUE DIALOG
                           END IF
                        END IF
                     END IF
                  END IF
               END IF
               #end add-point
               
               #寫入修改者/修改日期資訊(單身)
               
      
               UPDATE ecbb_t SET (ecbb001,ecbb002,ecbb003,ecbb004,ecbb005,ecbb006,ecbb007,ecbb008,ecbb009, 
                   ecbb010,ecbb011,ecbb012,ecbb024,ecbb025,ecbb026,ecbb027,ecbb034,ecbb013,ecbb014,ecbb015, 
                   ecbb016,ecbb017,ecbb018,ecbb019,ecbb020,ecbb030,ecbb031,ecbb032,ecbb021,ecbb022,ecbb023, 
                   ecbb033,ecbb028,ecbb029,ecbb035,ecbb036,ecbb037,ecbb038) = (g_ecba_m.ecba001,g_ecba_m.ecba002,g_ecbb_d[l_ac].ecbb003, 
                   g_ecbb_d[l_ac].ecbb004,g_ecbb_d[l_ac].ecbb005,g_ecbb_d[l_ac].ecbb006,g_ecbb_d[l_ac].ecbb007, 
                   g_ecbb_d[l_ac].ecbb008,g_ecbb_d[l_ac].ecbb009,g_ecbb_d[l_ac].ecbb010,g_ecbb_d[l_ac].ecbb011, 
                   g_ecbb_d[l_ac].ecbb012,g_ecbb_d[l_ac].ecbb024,g_ecbb_d[l_ac].ecbb025,g_ecbb_d[l_ac].ecbb026, 
                   g_ecbb_d[l_ac].ecbb027,g_ecbb_d[l_ac].ecbb034,g_ecbb_d[l_ac].ecbb013,g_ecbb_d[l_ac].ecbb014, 
                   g_ecbb_d[l_ac].ecbb015,g_ecbb_d[l_ac].ecbb016,g_ecbb_d[l_ac].ecbb017,g_ecbb_d[l_ac].ecbb018, 
                   g_ecbb_d[l_ac].ecbb019,g_ecbb_d[l_ac].ecbb020,g_ecbb_d[l_ac].ecbb030,g_ecbb_d[l_ac].ecbb031, 
                   g_ecbb_d[l_ac].ecbb032,g_ecbb_d[l_ac].ecbb021,g_ecbb_d[l_ac].ecbb022,g_ecbb_d[l_ac].ecbb023, 
                   g_ecbb_d[l_ac].ecbb033,g_ecbb_d[l_ac].ecbb028,g_ecbb_d[l_ac].ecbb029,g_ecbb_d[l_ac].ecbb035, 
                   g_ecbb_d[l_ac].ecbb036,g_ecbb_d[l_ac].ecbb037,g_ecbb_d[l_ac].ecbb038)
                WHERE ecbbent = g_enterprise AND ecbbsite = g_site AND ecbb001 = g_ecba_m.ecba001 
                  AND ecbb002 = g_ecba_m.ecba002 
 
                  AND ecbb003 = g_ecbb_d_t.ecbb003 #項次   
 
                  
               #add-point:單身修改中

               #end add-point
               CASE
                  WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "ecbb_t" 
                     LET g_errparam.code   = "std-00009" 
                     LET g_errparam.popup  = TRUE 
                     CALL cl_err()
 
                     CALL s_transaction_end('N','0')
                     LET g_ecbb_d[l_ac].* = g_ecbb_d_t.*
                  WHEN SQLCA.sqlcode #其他錯誤
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "ecbb_t" 
                     LET g_errparam.code   = SQLCA.sqlcode 
                     LET g_errparam.popup  = TRUE 
                     CALL cl_err()
 
                     LET g_ecbb_d[l_ac].* = g_ecbb_d_t.*                     
                     CALL s_transaction_end('N','0')
                  OTHERWISE
                                    INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_ecba_m.ecba001
               LET gs_keys_bak[1] = g_ecba001_t
               LET gs_keys[2] = g_ecba_m.ecba002
               LET gs_keys_bak[2] = g_ecba002_t
               LET gs_keys[3] = g_ecbb_d[g_detail_idx].ecbb003
               LET gs_keys_bak[3] = g_ecbb_d_t.ecbb003
               CALL aecm200_update_b('ecbb_t',gs_keys,gs_keys_bak,"'1'")
                     #資料多語言用-增/改
                     
               END CASE
               
               #修改歷程記錄
               LET g_log1 = util.JSON.stringify(g_ecba_m),util.JSON.stringify(g_ecbb_d_t)
               LET g_log2 = util.JSON.stringify(g_ecba_m),util.JSON.stringify(g_ecbb_d[l_ac])
               IF NOT cl_log_modified_record(g_log1,g_log2) THEN 
                  CALL s_transaction_end('N','0')
               END IF
               
               #add-point:單身修改後
               #170418-00063#1-s
               IF g_ecbb_d_t.ecbb003 <> g_ecbb_d[l_ac].ecbb003 THEN
                  UPDATE ecbe_t SET ecbe003 = g_ecbb_d[l_ac].ecbb003
                   WHERE ecbeent = g_enterprise
                     AND ecbesite = g_site
                     AND ecbe001 = g_ecba_m.ecba001
                     AND ecbe002 = g_ecba_m.ecba002
                     AND ecbe003 = g_ecbb_d_t.ecbb003
                  IF SQLCA.sqlcode THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = SQLCA.sqlcode
                     LET g_errparam.extend = "ecbe_t"
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                     CALL s_transaction_end('N','0')
                  END IF
               END IF
               #170418-00063#1-e
               #add--151215-00002#4 By shiun--(S)
               IF g_aecm200_05_chk THEN
                IF cl_get_para(g_enterprise,g_site,'S-MFG-0036') = '2' THEN #add by yangxb 170503使用APS高端查询时，弹窗
                  IF NOT cl_null(g_ecba_m.ecba001) AND  NOT cl_null(g_ecba_m.ecba002) AND NOT cl_null(g_ecbb_d[l_ac].ecbb003) AND (NOT cl_null(g_ecbb_d[l_ac].ecbb037) OR NOT cl_null(g_ecbb_d[l_ac].ecbb038)) THEN
                     CALL aecm200_05(g_ecba_m.ecba001,g_ecba_m.ecba002,g_ecbb_d[l_ac].ecbb003)
                  END IF
                END IF #add by yangxb 170503
               END IF
               #add--151215-00002#4 By shiun--(E)
               IF g_ecbb_d[l_ac].ecbb008 <> 'MULT' THEN
                  UPDATE ecbe_t SET ecbe004 = g_ecbb_d[l_ac].ecbb008,
                                    ecbe005 = g_ecbb_d[l_ac].ecbb009
                   WHERE ecbeent = g_enterprise
                     AND ecbesite = g_site
                     AND ecbe001 = g_ecba_m.ecba001
                     AND ecbe002 = g_ecba_m.ecba002
                     AND ecbe003 = g_ecbb_d[l_ac].ecbb003
                     AND ecbe004 = g_ecbb_d_t.ecbb008
                     AND ecbe005 = g_ecbb_d_t.ecbb009
                  IF SQLCA.sqlcode THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = SQLCA.sqlcode
                     LET g_errparam.extend = "ecbe_t"
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
 
                     CALL s_transaction_end('N','0')
                  END IF
               END IF
               #add by wuxja
               #161108-00023#1---add---s
               IF g_ecbb_d[l_ac].ecbb004 <> g_ecbb_d_t.ecbb004 OR g_ecbb_d[l_ac].ecbb005 <> g_ecbb_d_t.ecbb005 THEN
                  #检查原本站作业和作业序是否存在其他站的上站作业和作业序中，如果存在就将其改成新值
                  UPDATE ecbe_t SET ecbe004 = g_ecbb_d[l_ac].ecbb004,
                                    ecbe005 = g_ecbb_d[l_ac].ecbb005
                   WHERE ecbeent = g_enterprise
                     AND ecbesite = g_site
                     AND ecbe001 = g_ecba_m.ecba001
                     AND ecbe002 = g_ecba_m.ecba002
                     AND ecbe004 = g_ecbb_d_t.ecbb004
                     AND ecbe005 = g_ecbb_d_t.ecbb005
                  IF SQLCA.sqlcode THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = SQLCA.sqlcode
                     LET g_errparam.extend = "ecbe_t"
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
 
                     CALL s_transaction_end('N','0')
                  END IF
                  UPDATE ecbb_t SET ecbb008 = g_ecbb_d[l_ac].ecbb004,
                                    ecbb009 = g_ecbb_d[l_ac].ecbb005
                   WHERE ecbbent = g_enterprise
                     AND ecbbsite = g_site
                     AND ecbb001 = g_ecba_m.ecba001
                     AND ecbb002 = g_ecba_m.ecba002
                     AND ecbb008 = g_ecbb_d_t.ecbb004
                     AND ecbb009 = g_ecbb_d_t.ecbb005
                  IF SQLCA.sqlcode THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = SQLCA.sqlcode
                     LET g_errparam.extend = "ecbb_t"
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
 
                     CALL s_transaction_end('N','0')
                  END IF                  
               END IF
               #161108-00023#1---add---e
               IF NOT cl_null(g_ecbb_d[l_ac].ooff013) THEN
                  CALL s_aooi360_gen('7',g_site,g_ecba_m.ecba001,g_ecba_m.ecba002,g_ecbb_d[l_ac].ecbb003,' ',' ',' ',' ',' ',' ','4',g_ecbb_d[l_ac].ooff013)
                     RETURNING l_success
               ELSE
                  CALL s_aooi360_del('7',g_site,g_ecba_m.ecba001,g_ecba_m.ecba002,g_ecbb_d[l_ac].ecbb003,' ',' ',' ',' ',' ',' ','4')
                     RETURNING l_success
               END IF
               IF NOT l_success THEN
                  CALL s_transaction_end('N','0')
               END IF
               #end
               #CALL aecm200_return_ecbb_mult()
               IF NOT aecm200_return_ecbb_mult() THEN
                  CALL s_transaction_end('N','0')
               END IF
               CALL aecm200_b_fill()
               #end add-point
 
            END IF
            
         AFTER ROW
            #add-point:單身after_row

            #end add-point
            CALL aecm200_unlock_b("ecbb_t","'1'")
            CALL s_transaction_end('Y','0')
            #其他table進行unlock
            #add-point:單身after_row2

            #end add-point
              
         AFTER INPUT
            #add-point:input段after input 

            #end add-point 
 
         ON ACTION controlo    
            CALL FGL_SET_ARR_CURR(g_ecbb_d.getLength()+1)
            LET lb_reproduce = TRUE
            LET li_reproduce = l_ac
            LET li_reproduce_target = g_ecbb_d.getLength()+1
            
         #ON ACTION cancel
         #   LET INT_FLAG = 1
         #   LET g_detail_idx = 1
         #   EXIT DIALOG 
 
      END INPUT
      
 
      
 
      
 
      
 
      
 
{</section>}
 
{<section id="aecm200.input.other" >}
      
      #add-point:自定義input
      
      INPUT ARRAY g_ecbb2_d FROM s_detail2.*
          ATTRIBUTE(COUNT = g_rec_b1,MAXCOUNT = g_max_rec,WITHOUT DEFAULTS, 
                  INSERT ROW = l_allow_insert, 
                  DELETE ROW = l_allow_delete,
                  APPEND ROW = l_allow_insert)
 
         
         BEFORE INPUT
            IF g_insert = 'Y' AND NOT cl_null(g_insert) THEN 
               CALL FGL_SET_ARR_CURR(g_ecbb2_d.getLength()+1) 
               LET g_insert = 'N' 
           END IF 
           CALL aecm200_b_fill_1()
           LET g_rec_b1 = g_ecbb2_d.getLength()
           IF cl_null(g_ecbb_d[l_ac].ecbb003) THEN
              NEXT FIELD ecbb003
           END IF
           
         BEFORE ROW
            LET l_insert = FALSE
            LET l_cmd = ''
            LET l_ac1 = ARR_CURR()
            LET g_detail_idx = l_ac1
            
            LET l_lock_sw = 'N'            #DEFAULT
            LET l_n = ARR_COUNT()
            DISPLAY l_ac1 TO FORMONLY.idx
         
            CALL s_transaction_begin()
            OPEN aecm200_cl USING g_enterprise, g_site,g_ecba_m.ecba001,g_ecba_m.ecba002
            IF STATUS THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code =  STATUS
               LET g_errparam.extend = "OPEN aecm200_cl:"
               LET g_errparam.popup = TRUE
               CALL cl_err()

               CLOSE aecm200_cl
               CALL s_transaction_end('N','0')
               RETURN
            END IF
            LET g_rec_b1 = g_ecbb2_d.getLength()
            
            IF g_rec_b1 >= l_ac1 AND NOT cl_null(g_ecbb2_d[l_ac1].ecbc004) THEN
               LET l_cmd='u'
               LET g_ecbb2_d_t.* = g_ecbb2_d[l_ac1].*  #BACKUP
               CALL aecm200_set_entry_b(l_cmd)
               CALL aecm200_set_no_entry_b(l_cmd)
               OPEN aecm200_bcl2 USING g_enterprise,g_site,g_ecba_m.ecba001,g_ecba_m.ecba002,g_ecbb_d[l_ac].ecbb003,g_ecbb2_d[l_ac1].ecbc004
               IF SQLCA.sqlcode THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = SQLCA.sqlcode
                  LET g_errparam.extend = "aecm200_bcl2"
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  LET l_lock_sw='Y'
               ELSE
                  FETCH aecm200_bcl2 INTO g_ecbb2_d[l_ac1].ecbc004,g_ecbb2_d[l_ac1].ecbc005,g_ecbb2_d[l_ac1].ecbc005_desc,g_ecbb2_d[l_ac1].ecbc005_desc1,g_ecbb2_d[l_ac1].ecbc006,g_ecbb2_d[l_ac1].ecbc006_desc,g_ecbb2_d[l_ac1].ecbc007,g_ecbb2_d[l_ac1].ecbc008,g_ecbb2_d[l_ac1].ecbc009,g_ecbb2_d[l_ac1].ecbc010
                  IF SQLCA.sqlcode THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = SQLCA.sqlcode
                     LET g_errparam.extend = g_ecbb2_d_t.ecbc004
                     LET g_errparam.popup = TRUE
                     CALL cl_err()

                     LET l_lock_sw = "Y"
                  END IF
                  LET g_bfill = "N"
                  CALL aecm200_show()
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
            INITIALIZE g_ecbb2_d[l_ac1].* TO NULL 
            LET g_ecbb2_d[l_ac1].ecbc007 = 1
            LET g_ecbb2_d[l_ac1].ecbc008 = 1
            LET g_ecbb2_d[l_ac1].ecbc010 = "1"
            LET g_ecbb2_d_t.* = g_ecbb2_d[l_ac1].*     #新輸入資料
            CALL cl_show_fld_cont()
            CALL aecm200_set_entry_b(l_cmd)
            CALL aecm200_set_no_entry_b(l_cmd)
            SELECT MAX(ecbc004)+1 INTO g_ecbb2_d[l_ac1].ecbc004
              FROM ecbc_t
             WHERE ecbcent = g_enterprise
               AND ecbcsite = g_site 
               AND ecbc001 = g_ecba_m.ecba001
               AND ecbc002 = g_ecba_m.ecba002
               AND ecbc003 = g_ecbb_d[l_ac].ecbb003
            IF cl_null(g_ecbb2_d[l_ac1].ecbc004) THEN
               LET g_ecbb2_d[l_ac1].ecbc004 = 1
               #DISPLAY BY NAME g_ecbb2_d[l_ac1].ecbc004   #160616-00009#1 mark
            END IF
            CALL g_ecbb3_d.clear()
            
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
            IF cl_null(g_ecbb2_d[l_ac1].ecbc006) THEN
               LET g_ecbb2_d[l_ac1].ecbc006 = ' '
            END IF
            LET l_count = 1  
            SELECT COUNT(*) INTO l_count FROM ecbc_t 
             WHERE ecbcent = g_enterprise
               AND ecbcsite = g_site 
               AND ecbc001 = g_ecba_m.ecba001
               AND ecbc002 = g_ecba_m.ecba002
               AND ecbc003 = g_ecbb_d[l_ac].ecbb003
               AND ecbc004 = g_ecbb2_d[l_ac1].ecbc004
            #資料未重複, 插入新增資料
            IF l_count = 0 THEN 
               INSERT INTO ecbc_t(ecbcent,ecbcsite,ecbc001,ecbc002,ecbc003,ecbc004,ecbc005,ecbc006,ecbc007,ecbc008,ecbc009,ecbc010) 
                           VALUES(g_enterprise,g_site,g_ecba_m.ecba001,g_ecba_m.ecba002,g_ecbb_d[l_ac].ecbb003,g_ecbb2_d[l_ac1].ecbc004,g_ecbb2_d[l_ac1].ecbc005,g_ecbb2_d[l_ac1].ecbc006,g_ecbb2_d[l_ac1].ecbc007,g_ecbb2_d[l_ac1].ecbc008,g_ecbb2_d[l_ac1].ecbc009,g_ecbb2_d[l_ac1].ecbc010)
            ELSE    
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = "std-00006"
               LET g_errparam.extend = 'INSERT'
               LET g_errparam.popup = TRUE
               CALL cl_err()

               INITIALIZE g_ecbb2_d[l_ac1].* TO NULL
               CALL s_transaction_end('N','0')
               CANCEL INSERT
            END IF
 
            IF SQLCA.SQLcode  THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = SQLCA.sqlcode
               LET g_errparam.extend = "ecbc_t"
               LET g_errparam.popup = TRUE
               CALL cl_err()
  
               CALL s_transaction_end('N','0')                    
               CANCEL INSERT
            ELSE
               CALL s_transaction_end('Y','0')
               ERROR 'INSERT O.K'
               LET g_rec_b1 = g_rec_b1 + 1
            END IF
              
         BEFORE DELETE                            #是否取消單身
            IF l_cmd = 'a' THEN
               CALL FGL_SET_ARR_CURR(l_ac1-1)
               CALL g_ecbb2_d.deleteElement(l_ac1)
               NEXT FIELD ecbc004
            END IF
         
            IF NOT cl_null(g_ecbb2_d[l_ac1].ecbc004) THEN 
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
               DELETE FROM ecbc_t
                WHERE ecbcent = g_enterprise
                  AND ecbcsite = g_site 
                  AND ecbc001 = g_ecba_m.ecba001 
                  AND ecbc002 = g_ecba_m.ecba002 
                  AND ecbc003 = g_ecbb_d[l_ac].ecbb003
                  AND ecbc004 = g_ecbb2_d_t.ecbc004
               
               IF SQLCA.sqlcode THEN
                  INITIALIZE g_errparam TO NULL
               LET g_errparam.code = SQLCA.sqlcode
               LET g_errparam.extend = "ecbc_t"
               LET g_errparam.popup = TRUE
               CALL cl_err()

                  CALL s_transaction_end('N','0')
                  CANCEL DELETE   
               ELSE
                  LET g_rec_b1 = g_rec_b1-1
                  CALL s_transaction_end('Y','0')
               END IF 
               CLOSE aecm200_bcl2
               LET l_count = g_ecbb2_d.getLength()
            END IF 
            
              
         AFTER DELETE 
            DELETE FROM ecbc_t
             WHERE ecbcent = g_enterprise
               AND ecbcsite = g_site 
               AND ecbc001 = g_ecba_m.ecba001 
               AND ecbc002 = g_ecba_m.ecba002 
               AND ecbc003 = g_ecbb_d[l_ac].ecbb003
               AND ecbc004 = g_ecbb2_d_t.ecbc004
               
         AFTER FIELD ecbc004
            IF NOT cl_ap_chk_Range(g_ecbb2_d[l_ac1].ecbc004,"0","0","","","azz-00079",1) THEN
               NEXT FIELD ecbc004
            END IF
            IF NOT cl_null(g_ecba_m.ecba001) AND NOT cl_null(g_ecba_m.ecba002) AND NOT cl_null(g_ecbb_d[l_ac].ecbb003) AND NOT cl_null(g_ecbb2_d[l_ac1].ecbc004) THEN 
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND g_ecbb2_d[l_ac1].ecbc004 != g_ecbb2_d_t.ecbc004) THEN 
                  IF NOT ap_chk_notDup(g_ecbb2_d[l_ac1].ecbc004,"SELECT COUNT(*) FROM ecbc_t WHERE "||"ecbcent = '" ||g_enterprise|| "' AND ecbcsite = '" ||g_site|| "' AND "||"ecbc001 = '"||g_ecba_m.ecba001 ||"' AND "|| "ecbc002 = '"||g_ecba_m.ecba002 ||"' AND "|| "ecbc003 = '"||g_ecbb_d[l_ac].ecbb003 ||"' AND "|| "ecbc004 = '"||g_ecbb2_d[l_ac1].ecbc004 ||"'",'std-00004',0) THEN 
                     LET g_ecbb2_d[l_ac1].ecbc004 = g_ecbb2_d_t.ecbc004
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF
            
         BEFORE FIELD ecbc004

         ON CHANGE ecbc004
   

         AFTER FIELD ecbc005
            CALL aecm200_ecbc_desc()
            IF NOT cl_null(g_ecbb2_d[l_ac1].ecbc005) THEN 
               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
               INITIALIZE g_chkparam.* TO NULL

               #設定g_chkparam.*的參數
               LET g_chkparam.arg1 = g_ecbb2_d[l_ac1].ecbc005

               #呼叫檢查存在並帶值的library
               IF NOT cl_chk_exist("v_imaf001_1") THEN
                  LET g_ecbb2_d[l_ac1].ecbc005 = g_ecbb2_d_t.ecbc005
                  CALL aecm200_ecbc_desc()
                  NEXT FIELD ecbc005
               END IF
               
               IF g_ecbb2_d[l_ac1].ecbc005 = g_ecba_m.ecba001 THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'aec-00003'
                  LET g_errparam.extend = g_ecbb2_d[l_ac1].ecbc005
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  LET g_ecbb2_d[l_ac1].ecbc005 = g_ecbb2_d_t.ecbc005
                  CALL aecm200_ecbc_desc()
                  NEXT FIELD ecbc005
               END IF
               CALL aecm200_def_ecbc009()
            END IF 

         BEFORE FIELD ecbc005
          
         ON CHANGE ecbc005
        
         BEFORE FIELD ecbc006
            
         AFTER FIELD ecbc006
            CALL aecm200_ecbc_desc()
            IF NOT cl_null(g_ecbb2_d[l_ac1].ecbc006) THEN 
               CALL s_azzi650_chk_exist('215',g_ecbb2_d[l_ac1].ecbc006) RETURNING l_success
               IF NOT l_success THEN
                  LET g_ecbb2_d[l_ac1].ecbc006 = g_ecbb2_d_t.ecbc006
                  CALL aecm200_ecbc_desc()
                  NEXT FIELD ecbc006
               END IF
            END IF 
            
         ON CHANGE ecbc006
        
         BEFORE FIELD ecbc007

         AFTER FIELD ecbc007
            IF NOT cl_ap_chk_Range(g_ecbb2_d[l_ac1].ecbc007,"0.000","1","","","azz-00079",1) THEN
               LET g_ecbb2_d[l_ac1].ecbc007 = g_ecbb2_d_t.ecbc007
               NEXT FIELD ecbc007
            END IF
            
         ON CHANGE ecbc007
           
         AFTER FIELD ecbc008
            IF NOT cl_ap_chk_Range(g_ecbb2_d[l_ac1].ecbc008,"0.000","0","","","azz-00079",1) THEN
               LET g_ecbb2_d[l_ac1].ecbc008 = g_ecbb2_d_t.ecbc008
               NEXT FIELD ecbc008
            END IF
            
         BEFORE FIELD ecbc008
            
         ON CHANGE ecbc008
            
         BEFORE FIELD ecbc009
            
         AFTER FIELD ecbc009
            IF NOT cl_null(g_ecbb2_d[l_ac1].ecbc009) THEN
               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
               INITIALIZE g_chkparam.* TO NULL

               #設定g_chkparam.*的參數
               LET g_chkparam.arg1 = g_ecbb2_d[l_ac1].ecbc009
               #160318-00025#3--add--str
               LET g_errshow = TRUE 
               LET g_chkparam.err_str[1] = "aim-00005:sub-01302|aooi250|",cl_get_progname("aooi250",g_lang,"2"),"|:EXEPROGaooi250"
               #160318-00025#3--add--end
               #呼叫檢查存在並帶值的library
               IF NOT cl_chk_exist("v_ooca001") THEN
                  LET g_ecbb2_d[l_ac1].ecbc009 = g_ecbb2_d_t.ecbc009
                  NEXT FIELD ecbc009
               END IF
               
               IF NOT aecm200_chk_ecbc009() THEN
                  IF NOT cl_null(g_errno) THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = g_errno
                     LET g_errparam.extend = g_ecbb2_d[l_ac1].ecbc009
                     LET g_errparam.popup = TRUE
                     CALL cl_err()

                  END IF
                  LET g_ecbb2_d[l_ac1].ecbc009 = g_ecbb2_d_t.ecbc009
                  NEXT FIELD ecbc009
               END IF
               
            END IF
            
         ON CHANGE ecbc009
           
         AFTER FIELD ecbc010
           
         BEFORE FIELD ecbc010
           
         ON CHANGE ecbc010
           
         ON ACTION controlp INFIELD ecbc004

         ON ACTION controlp INFIELD ecbc005
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'     #160201-00008#1-add
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_ecbb2_d[l_ac1].ecbc005     #給予default值
            CALL q_imaf001_6()                                     #呼叫開窗
            LET g_ecbb2_d[l_ac1].ecbc005 = g_qryparam.return1      #將開窗取得的值回傳到變數
            DISPLAY g_ecbb2_d[l_ac1].ecbc005 TO ecbc005            #顯示到畫面上
            CALL aecm200_ecbc_desc()
            NEXT FIELD ecbc005                                     #返回原欄位
            
         ON ACTION controlp INFIELD ecbc006
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'     #160201-00008#1-add
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_ecbb2_d[l_ac1].ecbc006     #給予default值
            #給予arg
            LET g_qryparam.arg1 = "215" 
            CALL q_oocq002()                                       #呼叫開窗
            LET g_ecbb2_d[l_ac1].ecbc006 = g_qryparam.return1      #將開窗取得的值回傳到變數
            DISPLAY g_ecbb2_d[l_ac1].ecbc006 TO ecbc006            #顯示到畫面上
            CALL aecm200_ecbc_desc()
            NEXT FIELD ecbc006                                     #返回原欄位
            
         ON ACTION controlp INFIELD ecbc007
            
         ON ACTION controlp INFIELD ecbc008
     
         ON ACTION controlp INFIELD ecbc009
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'     #160201-00008#1-add
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_ecbb2_d[l_ac1].ecbc009     #給予default值
            CALL q_ooca001_1()                                       #呼叫開窗
            LET g_ecbb2_d[l_ac1].ecbc009 = g_qryparam.return1      #將開窗取得的值回傳到變數
            DISPLAY g_ecbb2_d[l_ac1].ecbc009 TO ecbc009            #顯示到畫面上
            NEXT FIELD ecbc009   
            
         ON ACTION controlp INFIELD ecbc010

 
         ON ROW CHANGE
            IF INT_FLAG THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = 9001
               LET g_errparam.extend = ''
               LET g_errparam.popup = FALSE
               CALL cl_err()

               LET INT_FLAG = 0
               LET g_ecbb2_d[l_ac1].* = g_ecbb2_d_t.*
               CLOSE aecm200_bcl2
               CALL s_transaction_end('N','0')
               EXIT DIALOG 
            END IF
              
            IF l_lock_sw = 'Y' THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = -263
               LET g_errparam.extend = g_ecbb2_d[l_ac1].ecbc004
               LET g_errparam.popup = TRUE
               CALL cl_err()

               LET g_ecbb2_d[l_ac1].* = g_ecbb2_d_t.*
            ELSE
               #寫入修改者/修改日期資訊(單身)
               UPDATE ecbc_t SET (ecbc001,ecbc002,ecbc003,ecbc004,ecbc005,ecbc006,ecbc007,ecbc008,ecbc009,ecbc010)
                               = (g_ecba_m.ecba001,g_ecba_m.ecba002,g_ecbb_d[l_ac].ecbb003,g_ecbb2_d[l_ac1].ecbc004,g_ecbb2_d[l_ac1].ecbc005,g_ecbb2_d[l_ac1].ecbc006,g_ecbb2_d[l_ac1].ecbc007,g_ecbb2_d[l_ac1].ecbc008,g_ecbb2_d[l_ac1].ecbc009,g_ecbb2_d[l_ac1].ecbc010)
                WHERE ecbcent = g_enterprise 
                  AND ecbcsite = g_site 
                  AND ecbc001 = g_ecba_m.ecba001 
                  AND ecbc002 = g_ecba_m.ecba002 
                  AND ecbc003 = g_ecbb_d[l_ac].ecbb003
                  AND ecbc004 = g_ecbb2_d_t.ecbc004 #項次   
               IF SQLCA.sqlcode THEN
                  INITIALIZE g_errparam TO NULL
               LET g_errparam.code = SQLCA.sqlcode
               LET g_errparam.extend = "ecbc_t"
               LET g_errparam.popup = TRUE
               CALL cl_err()
   
                  LET g_ecbb2_d[l_ac1].* = g_ecbb2_d_t.*
               ELSE
                  UPDATE ecbc_t SET (ecbc001,ecbc002,ecbc003,ecbc004,ecbc005,ecbc006,ecbc007,ecbc008,ecbc009,ecbc010)
                                  = (g_ecba_m.ecba001,g_ecba_m.ecba002,g_ecbb_d[l_ac].ecbb003,g_ecbb2_d[l_ac1].ecbc004,g_ecbb2_d[l_ac1].ecbc005,g_ecbb2_d[l_ac1].ecbc006,g_ecbb2_d[l_ac1].ecbc007,g_ecbb2_d[l_ac1].ecbc008,g_ecbb2_d[l_ac1].ecbc009,g_ecbb2_d[l_ac1].ecbc010)
                   WHERE ecbcent = g_enterprise 
                     AND ecbcsite = g_site 
                     AND ecbc001 = g_ecba_m.ecba001 
                     AND ecbc002 = g_ecba_m.ecba002 
                     AND ecbc003 = g_ecbb_d[l_ac].ecbb003
                     AND ecbc004 = g_ecbb2_d_t.ecbc004 #項次 
               END IF
              
            END IF
            
         AFTER ROW
      
            CLOSE aecm200_bcl2
            CALL s_transaction_end('Y','0')
              
         AFTER INPUT
         
      END INPUT
      
      
      INPUT ARRAY g_ecbb3_d FROM s_detail3.*
          ATTRIBUTE(COUNT = g_rec_b2,MAXCOUNT = g_max_rec,WITHOUT DEFAULTS, 
                  INSERT ROW = l_allow_insert, 
                  DELETE ROW = l_allow_delete,
                  APPEND ROW = l_allow_insert)
 
         
         BEFORE INPUT
            IF g_insert = 'Y' AND NOT cl_null(g_insert) THEN 
               CALL FGL_SET_ARR_CURR(g_ecbb3_d.getLength()+1) 
               LET g_insert = 'N' 
           END IF 
           CALL aecm200_b_fill_2()
           LET g_rec_b2 = g_ecbb3_d.getLength()
           IF cl_null(g_ecbb2_d[l_ac1].ecbc004) THEN
              NEXT FIELD ecbc004
           END IF
           
         BEFORE ROW
            LET l_insert = FALSE
            LET l_cmd = ''
            LET l_ac2 = ARR_CURR()
            LET g_detail_idx = l_ac2
            
            LET l_lock_sw = 'N'            #DEFAULT
            LET l_n = ARR_COUNT()
            DISPLAY l_ac2 TO FORMONLY.idx
         
            CALL s_transaction_begin()
            OPEN aecm200_cl USING g_enterprise, g_site,g_ecba_m.ecba001,g_ecba_m.ecba002
            IF STATUS THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code =  STATUS
               LET g_errparam.extend = "OPEN aecm200_cl:"
               LET g_errparam.popup = TRUE
               CALL cl_err()

               CLOSE aecm200_cl
               CALL s_transaction_end('N','0')
               RETURN
            END IF
            LET g_rec_b2 = g_ecbb3_d.getLength()
            
            IF g_rec_b2 >= l_ac2 AND NOT cl_null(g_ecbb3_d[l_ac2].ecbd005) THEN
               LET l_cmd='u'
               LET g_ecbb3_d_t.* = g_ecbb3_d[l_ac2].*  #BACKUP
               CALL aecm200_set_entry_b(l_cmd)
               CALL aecm200_set_no_entry_b(l_cmd)
               OPEN aecm200_bcl3 USING g_enterprise,g_site,g_ecba_m.ecba001,g_ecba_m.ecba002,g_ecbb_d[l_ac].ecbb003,g_ecbb2_d[l_ac1].ecbc004,g_ecbb3_d[l_ac2].ecbd005
               IF SQLCA.sqlcode THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = SQLCA.sqlcode
                  LET g_errparam.extend = "aecm200_bcl3"
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  LET l_lock_sw='Y'
               ELSE
                  FETCH aecm200_bcl3 INTO g_ecbb3_d[l_ac2].ecbd005,g_ecbb3_d[l_ac2].ecbd006,g_ecbb3_d[l_ac2].ecbd007,g_ecbb3_d[l_ac2].ecbd008
                  IF SQLCA.sqlcode THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = SQLCA.sqlcode
                     LET g_errparam.extend = g_ecbb3_d_t.ecbd005
                     LET g_errparam.popup = TRUE
                     CALL cl_err()

                     LET l_lock_sw = "Y"
                  END IF
                  LET g_bfill = "N"
                  CALL aecm200_show()
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
            INITIALIZE g_ecbb3_d[l_ac2].* TO NULL 
            LET g_ecbb3_d[l_ac2].ecbd007 = 0
            LET g_ecbb3_d[l_ac2].ecbd008 = 0
            LET g_ecbb3_d_t.* = g_ecbb3_d[l_ac2].*     #新輸入資料
            CALL cl_show_fld_cont()
            CALL aecm200_set_entry_b(l_cmd)
            CALL aecm200_set_no_entry_b(l_cmd)
            CALL aecm200_def_ecbd005()
  
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
            SELECT COUNT(*) INTO l_count FROM ecbd_t 
             WHERE ecbdent = g_enterprise
               AND ecbdsite = g_site 
               AND ecbd001 = g_ecba_m.ecba001
               AND ecbd002 = g_ecba_m.ecba002
               AND ecbd003 = g_ecbb_d[l_ac].ecbb003
               AND ecbd004 = g_ecbb2_d[l_ac1].ecbc004
               AND ecbd005 = g_ecbb3_d[l_ac2].ecbd005
            #資料未重複, 插入新增資料
            IF l_count = 0 THEN 
               INSERT INTO ecbd_t(ecbdent,ecbdsite,ecbd001,ecbd002,ecbd003,ecbd004,ecbd005,ecbd006,ecbd007,ecbd008) 
                           VALUES(g_enterprise,g_site,g_ecba_m.ecba001,g_ecba_m.ecba002,g_ecbb_d[l_ac].ecbb003,g_ecbb2_d[l_ac1].ecbc004,g_ecbb3_d[l_ac2].ecbd005,g_ecbb3_d[l_ac2].ecbd006,g_ecbb3_d[l_ac2].ecbd007,g_ecbb3_d[l_ac2].ecbd008)
            ELSE    
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = "std-00006"
               LET g_errparam.extend = 'INSERT'
               LET g_errparam.popup = TRUE
               CALL cl_err()

               INITIALIZE g_ecbb3_d[l_ac2].* TO NULL
               CALL s_transaction_end('N','0')
               CANCEL INSERT
            END IF
 
            IF SQLCA.SQLcode  THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = SQLCA.sqlcode
               LET g_errparam.extend = "ecbd_t"
               LET g_errparam.popup = TRUE
               CALL cl_err()
  
               CALL s_transaction_end('N','0')                    
               CANCEL INSERT
            ELSE
               CALL s_transaction_end('Y','0')
               ERROR 'INSERT O.K'
               LET g_rec_b2 = g_rec_b2 + 1
            END IF
              
         BEFORE DELETE                            #是否取消單身
            IF l_cmd = 'a' THEN
               CALL FGL_SET_ARR_CURR(l_ac2-1)
               CALL g_ecbb3_d.deleteElement(l_ac2)
               NEXT FIELD ecbd005
            END IF
         
            IF NOT cl_null(g_ecbb3_d[l_ac2].ecbd005) THEN 
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
               DELETE FROM ecbd_t
                WHERE ecbdent = g_enterprise
                  AND ecbdsite = g_site 
                  AND ecbd001 = g_ecba_m.ecba001 
                  AND ecbd002 = g_ecba_m.ecba002 
                  AND ecbd003 = g_ecbb_d[l_ac].ecbb003
                  AND ecbd004 = g_ecbb2_d[l_ac1].ecbc004
                  AND ecbd005 = g_ecbb3_d_t.ecbd005
               
               IF SQLCA.sqlcode THEN
                  INITIALIZE g_errparam TO NULL
               LET g_errparam.code = SQLCA.sqlcode
               LET g_errparam.extend = "ecbd_t"
               LET g_errparam.popup = TRUE
               CALL cl_err()

                  CALL s_transaction_end('N','0')
                  CANCEL DELETE   
               ELSE
                  LET g_rec_b2 = g_rec_b2-1
                  CALL s_transaction_end('Y','0')
               END IF 
               CLOSE aecm200_bcl3
               LET l_count = g_ecbb3_d.getLength()
            END IF 
            
              
         AFTER DELETE 
            DELETE FROM ecbd_t
             WHERE ecbdent = g_enterprise
               AND ecbdsite = g_site 
               AND ecbd001 = g_ecba_m.ecba001 
               AND ecbd002 = g_ecba_m.ecba002 
               AND ecbd003 = g_ecbb_d[l_ac].ecbb003
               AND ecbd004 = g_ecbb2_d[l_ac1].ecbc004
               AND ecbd005 = g_ecbb3_d_t.ecbd005
               
         AFTER FIELD ecbd005
            IF NOT cl_ap_chk_Range(g_ecbb3_d[l_ac2].ecbd005,"0.000","1","","","azz-00079",1) THEN
               LET g_ecbb3_d[l_ac2].ecbd005 = g_ecbb3_d_t.ecbd005
               NEXT FIELD ecbd005
            END IF
            IF NOT cl_null(g_ecba_m.ecba001) AND NOT cl_null(g_ecba_m.ecba002) AND NOT cl_null(g_ecbb_d[l_ac].ecbb003) AND NOT cl_null(g_ecbb2_d[l_ac1].ecbc004) AND NOT cl_null(g_ecbb3_d[l_ac2].ecbd005) THEN 
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND g_ecbb3_d[l_ac2].ecbd005 != g_ecbb3_d_t.ecbd005) THEN 
                  IF NOT ap_chk_notDup(g_ecbb3_d[l_ac2].ecbd005,"SELECT COUNT(*) FROM ecbd_t WHERE "||"ecbdent = '" ||g_enterprise|| "' AND ecbdsite = '" ||g_site|| "' AND "||"ecbd001 = '"||g_ecba_m.ecba001 ||"' AND "|| "ecbd002 = '"||g_ecba_m.ecba002 ||"' AND "|| "ecbd003 = '"||g_ecbb_d[l_ac].ecbb003 ||"' AND "|| "ecbd004 = '"||g_ecbb2_d[l_ac1].ecbc004 ||"' AND "|| "ecbd005 = '"||g_ecbb3_d[l_ac2].ecbd005 ||"'",'std-00004',0) THEN 
                     LET g_ecbb3_d[l_ac2].ecbd005 = g_ecbb3_d_t.ecbd005
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF
            IF NOT cl_null(g_ecbb3_d[l_ac2].ecbd005) THEN
               IF NOT cl_null(g_ecbb3_d[l_ac2].ecbd006) THEN
                  IF g_ecbb3_d[l_ac2].ecbd005 > g_ecbb3_d[l_ac2].ecbd006 THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = 'aec-00005'
                     LET g_errparam.extend = g_ecbb3_d[l_ac2].ecbd005
                     LET g_errparam.popup = TRUE
                     CALL cl_err()

                     LET g_ecbb3_d[l_ac2].ecbd005 = g_ecbb3_d_t.ecbd005
                     NEXT FIELD ecbd005
                  END IF
               END IF
               CALL aecm200_chk_ecbd005(g_ecbb3_d[l_ac2].ecbd005,'1',l_cmd)
               IF NOT cl_null(g_errno) THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = g_errno
                  LET g_errparam.extend = g_ecbb3_d[l_ac2].ecbd005
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  LET g_ecbb3_d[l_ac2].ecbd005 = g_ecbb3_d_t.ecbd005
                  NEXT FIELD ecbd005
               END IF
            END IF
            NEXT FIELD ecbd006
            
         BEFORE FIELD ecbd005

         ON CHANGE ecbd005
        
         BEFORE FIELD ecbd006
            
         AFTER FIELD ecbd006
            IF NOT cl_ap_chk_Range(g_ecbb3_d[l_ac2].ecbd006,"0.000","1","","","azz-00079",1) THEN
               LET g_ecbb3_d[l_ac2].ecbd006 = g_ecbb3_d_t.ecbd006
               NEXT FIELD ecbd006
            END IF
            IF NOT cl_null(g_ecbb3_d[l_ac2].ecbd006) THEN
               IF NOT cl_null(g_ecbb3_d[l_ac2].ecbd005) THEN
                  IF g_ecbb3_d[l_ac2].ecbd005 > g_ecbb3_d[l_ac2].ecbd006 THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = 'aec-00005'
                     LET g_errparam.extend = g_ecbb3_d[l_ac2].ecbd006
                     LET g_errparam.popup = TRUE
                     CALL cl_err()

                     LET g_ecbb3_d[l_ac2].ecbd006 = g_ecbb3_d_t.ecbd006
                     NEXT FIELD ecbd006
                  END IF
               END IF
            END IF
            CALL aecm200_chk_ecbd005(g_ecbb3_d[l_ac2].ecbd006,'2',l_cmd)
            IF NOT cl_null(g_errno) THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = g_errno
               LET g_errparam.extend = g_ecbb3_d[l_ac2].ecbd006
               LET g_errparam.popup = TRUE
               CALL cl_err()

               LET g_ecbb3_d[l_ac2].ecbd006 = g_ecbb3_d_t.ecbd006
               NEXT FIELD ecbd006
            END IF
            
         ON CHANGE ecbd006
        
         BEFORE FIELD ecbd007

         AFTER FIELD ecbd007
            IF NOT cl_ap_chk_Range(g_ecbb3_d[l_ac2].ecbd007,"0.000","1","","","azz-00079",1) THEN
               LET g_ecbb3_d[l_ac2].ecbd007 = g_ecbb3_d_t.ecbd007
               NEXT FIELD ecbd007
            END IF
            
         ON CHANGE ecbd007
           
         AFTER FIELD ecbd008
            IF NOT cl_ap_chk_Range(g_ecbb3_d[l_ac2].ecbd008,"0.000","1","","","azz-00079",1) THEN
               LET g_ecbb3_d[l_ac2].ecbd008 = g_ecbb3_d_t.ecbd008
               NEXT FIELD ecbd008
            END IF
            
         BEFORE FIELD ecbd008
            
         ON CHANGE ecbd008
           
         ON ACTION controlp INFIELD ecbd005
            
         ON ACTION controlp INFIELD ecbd006
                       
         ON ACTION controlp INFIELD ecbd007
            
         ON ACTION controlp INFIELD ecbd008
    
         ON ROW CHANGE
            IF INT_FLAG THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = 9001
               LET g_errparam.extend = ''
               LET g_errparam.popup = FALSE
               CALL cl_err()

               LET INT_FLAG = 0
               LET g_ecbb3_d[l_ac2].* = g_ecbb3_d_t.*
               CLOSE aecm200_bcl3
               CALL s_transaction_end('N','0')
               EXIT DIALOG 
            END IF
              
            IF l_lock_sw = 'Y' THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = -263
               LET g_errparam.extend = g_ecbb3_d[l_ac2].ecbd005
               LET g_errparam.popup = TRUE
               CALL cl_err()

               LET g_ecbb3_d[l_ac2].* = g_ecbb3_d_t.*
            ELSE
               #寫入修改者/修改日期資訊(單身)
               UPDATE ecbd_t SET (ecbd001,ecbd002,ecbd003,ecbd004,ecbd005,ecbd006,ecbd007,ecbd008)
                               = (g_ecba_m.ecba001,g_ecba_m.ecba002,g_ecbb_d[l_ac].ecbb003,g_ecbb2_d[l_ac1].ecbc004,g_ecbb3_d[l_ac2].ecbd005,g_ecbb3_d[l_ac2].ecbd006,g_ecbb3_d[l_ac2].ecbd007,g_ecbb3_d[l_ac2].ecbd008)
                WHERE ecbdent = g_enterprise 
                  AND ecbdsite = g_site 
                  AND ecbd001 = g_ecba_m.ecba001 
                  AND ecbd002 = g_ecba_m.ecba002 
                  AND ecbd003 = g_ecbb_d[l_ac].ecbb003
                  AND ecbd004 = g_ecbb2_d[l_ac1].ecbc004
                  AND ecbd005 = g_ecbb3_d_t.ecbd005   
               IF SQLCA.sqlcode THEN
                  INITIALIZE g_errparam TO NULL
               LET g_errparam.code = SQLCA.sqlcode
               LET g_errparam.extend = "ecbd_t"
               LET g_errparam.popup = TRUE
               CALL cl_err()
   
                  LET g_ecbb3_d[l_ac2].* = g_ecbb3_d_t.*
               ELSE
                  UPDATE ecbd_t SET (ecbd001,ecbd002,ecbd003,ecbd004,ecbd005,ecbd006,ecbd007,ecbd008)
                                  = (g_ecba_m.ecba001,g_ecba_m.ecba002,g_ecbb_d[l_ac].ecbb003,g_ecbb2_d[l_ac1].ecbc004,g_ecbb3_d[l_ac2].ecbd005,g_ecbb3_d[l_ac2].ecbd006,g_ecbb3_d[l_ac2].ecbd007,g_ecbb3_d[l_ac2].ecbd008)
                   WHERE ecbdent = g_enterprise 
                     AND ecbdsite = g_site 
                     AND ecbd001 = g_ecba_m.ecba001 
                     AND ecbd002 = g_ecba_m.ecba002 
                     AND ecbd003 = g_ecbb_d[l_ac].ecbb003
                     AND ecbd004 = g_ecbb2_d[l_ac1].ecbc004
                     AND ecbd005 = g_ecbb3_d_t.ecbd005
               END IF
              
            END IF
            
         AFTER ROW
      
            CLOSE aecm200_bcl3
            CALL s_transaction_end('Y','0')
              
         AFTER INPUT
         
      END INPUT
      
      #add by wuxja --begin---
      INPUT ARRAY g_ecbb4_d FROM s_detail4.*
         ATTRIBUTE(COUNT = 34,MAXCOUNT = 34,WITHOUT DEFAULTS, 
                  INSERT ROW = FALSE, 
                  DELETE ROW = FALSE,
                  APPEND ROW = FALSE)
                  
         BEFORE INPUT                
          #  CALL aecm200_b_fill_text()
            CALL s_transaction_begin()
            CALL DIALOG.setCurrentRow("s_detail4",l_ac3)
            IF l_flag = 'Y' THEN
               CALL aecm200_b_fill_value(g_ecbb_d[l_ac].ecbb004, g_ecbb_d[l_ac].ecbb005)
               #项次为空，代表是新增，反之是修改
               IF cl_null(g_ecbb4_d[1].l_value) THEN
                  CALL aecm200_value_def()
               END IF
               #赋旧值
               FOR l_ac3 = 1 TO 34
                  LET g_ecbb4_d_t[l_ac3].* = g_ecbb4_d[l_ac3].*
               END FOR
               NEXT FIELD l_value
            END IF
            
         BEFORE ROW
            LET l_ac3 = ARR_CURR()
            IF l_ac3 = 3 OR l_ac3 = 6 OR l_ac3 = 8 OR l_ac3 = 16 OR l_ac3 = 24 OR l_ac3 = 28 THEN
               LET l_ac3 = l_ac3 + 1
               LET l_flag = 'N'
               EXIT DIALOG
            ELSE
               LET l_flag = 'Y'
            END IF
            
            
         AFTER FIELD l_value
            IF NOT aecm200_chk_value(l_ac3,g_ecbb4_d[l_ac3].l_value,g_ecbb4_d_t[l_ac3].l_value) THEN
               LET g_ecbb4_d[l_ac3].l_value = g_ecbb4_d_t[l_ac3].l_value
               NEXT FIELD CURRENT
            END IF
            #wuxja
            IF l_ac3 == 2 OR l_ac == 3 THEN
               ERROR "未更新工作站"
               #CALL cl_chart_property_comp("wc","qrytext","0#"||g_ecbb4_d[3].l_value||"#"||g_ecbb4_d[2].l_value)
            END IF
         
         ON ACTION controlp INFIELD l_value
            CALL aecm200_value_controlp(l_ac3,g_ecbb4_d[l_ac3].l_value)
            NEXT FIELD CURRENT    

        #20151112 by wuxja  add  --begin--
         ON ACTION wc_select_node
            NEXT FIELD wc
        #20151112 by wuxja  add  --end--

         AFTER INPUT
            IF NOT cl_null(g_ecbb4_d[1].l_value) AND NOT cl_null(g_ecbb4_d[2].l_value) AND NOT cl_null(g_ecbb4_d[4].l_value) THEN 
               IF NOT aecm200_value_ins_upd(g_ecbb4_d[1].l_value,g_ecbb4_d_t[1].l_value) THEN
                  CALL s_transaction_end('N','0')
               ELSE
                  CALL s_transaction_end('Y','0')
               END IF
            END IF   
               
      END INPUT
 
      #add by wuxja ---end---
      
      #end add-point
      
      BEFORE DIALOG 
         #CALL cl_err_collect_init()    
         #add-point:input段before dialog
         IF l_flag = 'N' THEN
            NEXT FIELD l_value
         END IF
        #若執行複製功能，則不將製程流程圖畫面做initialize
        #IF p_cmd == 'a' THEN                      #160411-00047#1 mark
         IF p_cmd == 'a' AND l_cmd_t <> 'r' THEN   #160411-00047#1 mod
            CALL aecm200_wc_init(FALSE)
            NEXT FIELD wc
         END IF
         
         #end add-point    
         #新增時強制從單頭開始填
         IF p_cmd = 'a' THEN
            NEXT FIELD ecba001
         ELSE
            CASE g_aw
               WHEN "s_detail1"
                  NEXT FIELD ecbb003
 
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
         #CALL cl_chart("wc","save","1")   #wuxja
         #NEXT FIELD wc                    #wuxja
         #161123-00002#1 add-S
         LET g_field = DIALOG.getCurrentItem()
         #161123-00002#1 add-E
         #通知WebComponent回傳資料後，next field wc等待資料回傳
         IF INFIELD(wc) THEN
            LET g_action_choice = "accept"
            CALL aecm200_wc_submit("wc", "station_get_data", "data")
            NEXT FIELD wc
         END IF
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
   IF p_cmd == "a" AND INT_FLAG == TRUE THEN
      IF NOT cl_null(g_ecba_m.ecba001) AND NOT cl_null(g_ecba_m.ecba002) THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = 'ecba_t' 
         LET g_errparam.popup  = TRUE 
         DELETE FROM ecba_t WHERE ecbaent = g_enterprise     AND ecbasite = g_site 
                              AND ecba001 = g_ecba_m.ecba001 AND ecba002 = g_ecba_m.ecba002
         IF SQLCA.sqlcode THEN LET g_errparam.code = SQLCA.sqlcode CALL cl_err() END IF
         
         DELETE FROM ecbb_t WHERE ecbbent = g_enterprise     AND ecbbsite = g_site 
                              AND ecbb001 = g_ecba_m.ecba001 AND ecbb002 = g_ecba_m.ecba002
         IF SQLCA.sqlcode THEN LET g_errparam.code = SQLCA.sqlcode CALL cl_err() END IF
         
         DELETE FROM ecbc_t WHERE ecbcent = g_enterprise     AND ecbcsite = g_site 
                              AND ecbc001 = g_ecba_m.ecba001 AND ecbc002 = g_ecba_m.ecba002
         IF SQLCA.sqlcode THEN LET g_errparam.code = SQLCA.sqlcode CALL cl_err() END IF
         
         DELETE FROM ecbd_t WHERE ecbdent = g_enterprise     AND ecbdsite = g_site 
                              AND ecbd001 = g_ecba_m.ecba001 AND ecbd002 = g_ecba_m.ecba002
         IF SQLCA.sqlcode THEN LET g_errparam.code = SQLCA.sqlcode CALL cl_err() END IF
         
         DELETE FROM ecbe_t WHERE ecbeent = g_enterprise     AND ecbesite = g_site 
                              AND ecbe001 = g_ecba_m.ecba001 AND ecbe002 = g_ecba_m.ecba002
         IF SQLCA.sqlcode THEN LET g_errparam.code = SQLCA.sqlcode CALL cl_err() END IF
         
         DELETE FROM ecbf_t WHERE ecbfent = g_enterprise     AND ecbfsite = g_site 
                              AND ecbf001 = g_ecba_m.ecba001 AND ecbf002 = g_ecba_m.ecba002
         IF SQLCA.sqlcode THEN LET g_errparam.code = SQLCA.sqlcode CALL cl_err() END IF
         
         DELETE FROM ecbg_t WHERE ecbgent = g_enterprise     AND ecbgsite = g_site 
                              AND ecbg001 = g_ecba_m.ecba001 AND ecbg002 = g_ecba_m.ecba002
         IF SQLCA.sqlcode THEN LET g_errparam.code = SQLCA.sqlcode CALL cl_err() END IF
         
         #清空單頭
         INITIALIZE g_ecba_m.* TO NULL

      END IF
   END IF
   CALL aecm200_b_fill()
   IF l_flag = 'N' THEN
      CONTINUE WHILE
   ELSE
      EXIT WHILE
   END IF 
   
   END WHILE
   #end add-point    
 
END FUNCTION
 
{</section>}
 
{<section id="aecm200.show" >}
#+ 單頭資料重新顯示及單身資料重抓
PRIVATE FUNCTION aecm200_show()
   DEFINE l_ac_t    LIKE type_t.num10  #161108-00012#1 num5==》num10
   #add-point:show段define
   DEFINE l_ac1_t   LIKE type_t.num10  #161108-00012#1 num5==》num10
   #end add-point  
 
   #add-point:show段之前
   IF l_ac = 0 OR cl_null(l_ac) THEN
      LET l_ac = 1
   END IF
   IF l_ac1 = 0 OR cl_null(l_ac1) THEN
      LET l_ac1 = 1
   END IF
   #end add-point
   
   
   
   IF g_bfill = "Y" THEN
      CALL aecm200_b_fill() #單身填充
      CALL aecm200_b_fill2('0') #單身填充
   END IF
     
   #帶出公用欄位reference值
   
 
   
   #顯示followup圖示
   #+ 此段落由子樣板a48產生
   CALL aecm200_set_pk_array()
   #add-point:ON ACTION agendum

   #END add-point
   CALL cl_user_overview_set_follow_pic()
 
 
   
   LET l_ac_t = l_ac
   
   #讀入ref值(單頭)
   #add-point:show段reference
  
   CALL aecm200_b_fill_1() 
   CALL aecm200_b_fill_2()
   
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_ecba_m.ecbaownid
   CALL ap_ref_array2(g_ref_fields,"SELECT ooag011 FROM ooag_t WHERE ooagent='"||g_enterprise||"' AND ooag001=? ","") RETURNING g_rtn_fields
   LET g_ecba_m.ecbaownid_desc = g_rtn_fields[1]
   DISPLAY BY NAME g_ecba_m.ecbaownid_desc
 
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_ecba_m.ecbaowndp
   CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_ecba_m.ecbaowndp_desc =  g_rtn_fields[1]
   DISPLAY BY NAME g_ecba_m.ecbaowndp_desc
 
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_ecba_m.ecbacrtid
   CALL ap_ref_array2(g_ref_fields,"SELECT ooag011 FROM ooag_t WHERE ooagent='"||g_enterprise||"' AND ooag001=? ","") RETURNING g_rtn_fields
   LET g_ecba_m.ecbacrtid_desc =  g_rtn_fields[1]
   DISPLAY BY NAME g_ecba_m.ecbacrtid_desc
 
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_ecba_m.ecbacrtdp
   CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_ecba_m.ecbacrtdp_desc =  g_rtn_fields[1]
   DISPLAY BY NAME g_ecba_m.ecbacrtdp_desc
 
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_ecba_m.ecbamodid
   CALL ap_ref_array2(g_ref_fields,"SELECT ooag011 FROM ooag_t WHERE ooagent='"||g_enterprise||"' AND ooag001=? ","") RETURNING g_rtn_fields
   LET g_ecba_m.ecbamodid_desc =  g_rtn_fields[1]
   DISPLAY BY NAME g_ecba_m.ecbamodid_desc
   
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_ecba_m.ecbacnfid
   CALL ap_ref_array2(g_ref_fields,"SELECT ooag011 FROM ooag_t WHERE ooagent='"||g_enterprise||"' AND ooag001=? ","") RETURNING g_rtn_fields
   LET g_ecba_m.ecbacnfid_desc =  g_rtn_fields[1]
   DISPLAY BY NAME g_ecba_m.ecbacnfid_desc
   
   CALL aecm200_desc()   
   
   #end add-point
   
   #將資料輸出到畫面上
   DISPLAY BY NAME g_ecba_m.ecba001,g_ecba_m.ecba001_desc,g_ecba_m.ecba001_desc1,g_ecba_m.ecba002,g_ecba_m.ecba003, 
       g_ecba_m.ecba004,g_ecba_m.ecba005,g_ecba_m.ecba006,g_ecba_m.ecba007,g_ecba_m.ecbastus,g_ecba_m.ooeb013, 
       g_ecba_m.ecbacrtid,g_ecba_m.ecbacrtid_desc,g_ecba_m.ecbacrtdp,g_ecba_m.ecbacrtdp_desc,g_ecba_m.ecbacrtdt, 
       g_ecba_m.ecbaownid,g_ecba_m.ecbaownid_desc,g_ecba_m.ecbaowndp,g_ecba_m.ecbaowndp_desc,g_ecba_m.ecbamodid, 
       g_ecba_m.ecbamodid_desc,g_ecba_m.ecbamoddt,g_ecba_m.ecbacnfid,g_ecba_m.ecbacnfid_desc,g_ecba_m.ecbacnfdt 
 
   
   #顯示狀態(stus)圖片
         #此段落由子樣板a21產生
	  #根據狀態碼顯示對應圖片
      CASE g_ecba_m.ecbastus
         WHEN "N"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/open.png")
         WHEN "X"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/void.png")
         WHEN "Y"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/valid.png")
         
      END CASE
 
 
   
   #讀入ref值(單身)
   FOR l_ac = 1 TO g_ecbb_d.getLength()
      #add-point:show段單身reference
      IF NOT cl_null(g_ecbb_d[l_ac].ecbb003) THEN
         CALL s_aooi360_sel('7',g_site,g_ecba_m.ecba001,g_ecba_m.ecba002,g_ecbb_d[l_ac].ecbb003,'','','','','','','4') RETURNING l_success,g_ecbb_d[l_ac].ooff013
      END IF 
      DISPLAY BY NAME g_ecbb_d[l_ac].ooff013
      #end add-point
   END FOR
   
 
   
    
   
   #add-point:show段other

   CALL aecm200_b_fill_text()
   CALL aecm200_b_fill_value(g_ecbb_d[l_ac_t].ecbb004, g_ecbb_d[l_ac_t].ecbb005)
   #end add-point  
   
   LET l_ac = l_ac_t
   
   #移動上下筆可以連動切換資料
   CALL cl_show_fld_cont()     
 
   CALL aecm200_detail_show()
   
   #add-point:show段之後
  
   #end add-point
   
END FUNCTION
 
{</section>}
 
{<section id="aecm200.detail_show" >}
#+ 第二階單身reference
PRIVATE FUNCTION aecm200_detail_show()
   #add-point:detail_show段define
   
   #end add-point  
 
   #add-point:detail_show段之前
   
   #end add-point
   
   #add-point:detail_show段之後
   
   #end add-point
   
END FUNCTION
 
{</section>}
 
{<section id="aecm200.reproduce" >}
#+ 資料複製
PRIVATE FUNCTION aecm200_reproduce()
   DEFINE l_newno     LIKE ecba_t.ecba001 
   DEFINE l_oldno     LIKE ecba_t.ecba001 
   DEFINE l_newno02     LIKE ecba_t.ecba002 
   DEFINE l_oldno02     LIKE ecba_t.ecba002 
 
   DEFINE l_master    RECORD LIKE ecba_t.*
   DEFINE l_detail    RECORD LIKE ecbb_t.*
 
 
   DEFINE l_cnt       LIKE type_t.num5
   #add-point:reproduce段define
  # DEFINE l_detail2   RECORD LIKE ecbc_t.*  #161124-00048#1  16/12/06 By 08734 mark
   #161124-00048#1  16/12/06 By 08734 add(S)
   DEFINE l_detail2   RECORD  #料件製程用料底稿
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
#161124-00048#1  16/12/06 By 08734 add(E)
   DEFINE l_sql       STRING
   #end add-point   
 
   #切換畫面
   IF g_main_hidden THEN
      CALL gfrm_curr.setElementHidden("mainlayout",0)
      CALL gfrm_curr.setElementHidden("worksheet",1)
      LET g_main_hidden = 0
   END IF
   
   LET g_master_insert = FALSE
   
   IF g_ecba_m.ecba001 IS NULL
   OR g_ecba_m.ecba002 IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code   = "std-00003" 
      LET g_errparam.popup  = FALSE 
      CALL cl_err()
      RETURN
   END IF
    
   LET g_ecba001_t = g_ecba_m.ecba001
   LET g_ecba002_t = g_ecba_m.ecba002
 
    
   LET g_ecba_m.ecba001 = ""
   LET g_ecba_m.ecba002 = ""
 
    
   CALL aecm200_set_entry('a')
   CALL aecm200_set_no_entry('a')
 
   CALL cl_set_head_visible("","YES")
 
   #公用欄位給予預設值
   #此段落由子樣板a14產生    
      #公用欄位新增給值
      LET g_ecba_m.ecbaownid = g_user
      LET g_ecba_m.ecbaowndp = g_dept
      LET g_ecba_m.ecbacrtid = g_user
      LET g_ecba_m.ecbacrtdp = g_dept 
      LET g_ecba_m.ecbacrtdt = cl_get_current()
      LET g_ecba_m.ecbamodid = ""
      LET g_ecba_m.ecbamoddt = ""
      LET g_ecba_m.ecbastus = "N"
 
 
   
   CALL s_transaction_begin()
   
   #add-point:複製輸入前
   LET g_ecba_m.ecbacnfid = ''
   LET g_ecba_m.ecbacnfdt = ''
   CASE g_ecba_m.ecbastus
      WHEN "N"
         CALL gfrm_curr.setElementImage("statechange", "stus/32/open.png")
      WHEN "X"
         CALL gfrm_curr.setElementImage("statechange", "stus/32/void.png")
      WHEN "Y"
         CALL gfrm_curr.setElementImage("statechange", "stus/32/valid.png")
      
   END CASE
   #end add-point
   
   #顯示狀態(stus)圖片
   
   CALL aecm200_input("r")
   
      LET g_ecba_m.ecba001_desc = ''
   DISPLAY BY NAME g_ecba_m.ecba001_desc
   LET g_ecba_m.ecba001_desc1 = ''
   DISPLAY BY NAME g_ecba_m.ecba001_desc1
 
   
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
      INITIALIZE g_ecba_m.* TO NULL
      INITIALIZE g_ecbb_d TO NULL
 
      CALL aecm200_show()
      RETURN
   END IF
   
   #將新增的資料併入搜尋條件中
   LET g_state = "Y"
   LET g_current_idx = 1 
   
   LET g_ecba001_t = g_ecba_m.ecba001
   LET g_ecba002_t = g_ecba_m.ecba002
 
   
   LET g_current_idx = g_browser.getLength() + 1
   LET g_browser[g_current_idx].b_ecba001 = g_ecba_m.ecba001
   LET g_browser[g_current_idx].b_ecba002 = g_ecba_m.ecba002
 
   
   LET g_detail_cnt = g_browser.getLength()
   LET g_header_cnt = g_browser.getLength()
   LET g_browser_cnt = g_browser.getLength()
   DISPLAY g_detail_cnt  TO FORMONLY.h_count     #總筆數
   DISPLAY g_current_idx TO FORMONLY.h_index     #當下筆數
   CALL cl_navigator_setting(g_current_idx, g_detail_cnt)
   
   LET g_wc = "(",g_wc,  
              " OR (",
              " ecba001 = '", g_ecba_m.ecba001 CLIPPED, "' "
              ," AND ecba002 = '", g_ecba_m.ecba002 CLIPPED, "' "
 
              , ")) "
   
   #add-point:完成複製段落後
   CALL aecm200_show()   #160411-00047#1 add
   #end add-point
   
   CALL aecm200_idx_chk()
   
END FUNCTION
 
{</section>}
 
{<section id="aecm200.detail_reproduce" >}
#+ 單身自動複製
PRIVATE FUNCTION aecm200_detail_reproduce()
   DEFINE ls_sql      STRING
   DEFINE ld_date     DATETIME YEAR TO SECOND
   DEFINE l_detail    RECORD LIKE ecbb_t.*
 
 
   #add-point:delete段define
   
   #end add-point    
   
   CALL s_transaction_begin()
   
   LET ld_date = cl_get_current()
   
   DROP TABLE aecm200_detail
   
   #add-point:單身複製前1
   
   #end add-point
   
   #CREATE TEMP TABLE
   LET ls_sql = "CREATE GLOBAL TEMPORARY TABLE aecm200_detail AS ",
                "SELECT * FROM ecbb_t "
   PREPARE repro_tbl FROM ls_sql
   EXECUTE repro_tbl
   FREE repro_tbl
                
   #將符合條件的資料丟入TEMP TABLE
   INSERT INTO aecm200_detail SELECT * FROM ecbb_t 
                                         WHERE ecbbent = g_enterprise AND ecbbsite = g_site AND ecbb001 = g_ecba001_t
                                         AND ecbb002 = g_ecba002_t
 
   
   #將key修正為調整後   
   UPDATE aecm200_detail 
      #更新key欄位
      SET ecbb001 = g_ecba_m.ecba001
          , ecbb002 = g_ecba_m.ecba002
 
      #更新共用欄位
      
                                       
  
   #將資料塞回原table   
   INSERT INTO ecbb_t SELECT * FROM aecm200_detail
   
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
   DROP TABLE aecm200_detail
   
   #add-point:單身複製後1
   #add by wuxj  ---2014/6/6---
   #CREATE TEMP TABLE
   LET ls_sql = "CREATE GLOBAL TEMPORARY TABLE aecm200_detail AS ",
                "SELECT * FROM ecbc_t "  
   PREPARE repro_tb2 FROM ls_sql
   EXECUTE repro_tb2
   FREE repro_tb2
                
   #將符合條件的資料丟入TEMP TABLE
   INSERT INTO aecm200_detail SELECT * FROM ecbc_t 
                                         WHERE ecbcent = g_enterprise AND ecbcsite = g_site AND ecbc001 = g_ecba001_t
                                         AND ecbc002 = g_ecba002_t
 
   
   #將key修正為調整後   
   UPDATE aecm200_detail 
      #更新key欄位
      SET ecbc001 = g_ecba_m.ecba001
          , ecbc002 = g_ecba_m.ecba002
 
      #更新共用欄位
      
                                       
  
   #將資料塞回原table   
   INSERT INTO ecbc_t SELECT * FROM aecm200_detail
   
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = "reproduce"
      LET g_errparam.popup = TRUE
      CALL cl_err()

      RETURN
   END IF
   
   DROP TABLE aecm200_detail
   #CREATE TEMP TABLE
   LET ls_sql = "CREATE GLOBAL TEMPORARY TABLE aecm200_detail AS ",
                "SELECT * FROM ecbd_t "  
   PREPARE repro_tb3 FROM ls_sql
   EXECUTE repro_tb3
   FREE repro_tb3
                
   #將符合條件的資料丟入TEMP TABLE
   INSERT INTO aecm200_detail SELECT * FROM ecbd_t 
                                         WHERE ecbdent = g_enterprise AND ecbdsite = g_site AND ecbd001 = g_ecba001_t
                                         AND ecbd002 = g_ecba002_t
 
   
   #將key修正為調整後   
   UPDATE aecm200_detail 
      #更新key欄位
      SET ecbd001 = g_ecba_m.ecba001
          , ecbd002 = g_ecba_m.ecba002
 
      #更新共用欄位
       
   #將資料塞回原table   
   INSERT INTO ecbd_t SELECT * FROM aecm200_detail
   
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = "reproduce"
      LET g_errparam.popup = TRUE
      CALL cl_err()

      RETURN
   END IF
   
   DROP TABLE aecm200_detail
   #CREATE TEMP TABLE
   LET ls_sql = "CREATE GLOBAL TEMPORARY TABLE aecm200_detail AS ",
                "SELECT * FROM ecbe_t "  
   PREPARE repro_tb4 FROM ls_sql
   EXECUTE repro_tb4
   FREE repro_tb4
                
   #將符合條件的資料丟入TEMP TABLE
   INSERT INTO aecm200_detail SELECT * FROM ecbe_t 
                                         WHERE ecbeent = g_enterprise AND ecbesite = g_site AND ecbe001 = g_ecba001_t
                                         AND ecbe002 = g_ecba002_t
 
   
   #將key修正為調整後   
   UPDATE aecm200_detail 
      #更新key欄位
      SET ecbe001 = g_ecba_m.ecba001
          , ecbe002 = g_ecba_m.ecba002
 
      #更新共用欄位
       
   #將資料塞回原table   
   INSERT INTO ecbe_t SELECT * FROM aecm200_detail
   
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = "reproduce"
      LET g_errparam.popup = TRUE
      CALL cl_err()

      RETURN
   END IF
   
   DROP TABLE aecm200_detail
   #CREATE TEMP TABLE
   LET ls_sql = "CREATE GLOBAL TEMPORARY TABLE aecm200_detail AS ",
                "SELECT * FROM ecbf_t "  
   PREPARE repro_tb5 FROM ls_sql
   EXECUTE repro_tb5
   FREE repro_tb5
                
   #將符合條件的資料丟入TEMP TABLE
   INSERT INTO aecm200_detail SELECT * FROM ecbf_t 
                                         WHERE ecbfent = g_enterprise AND ecbfsite = g_site AND ecbf001 = g_ecba001_t
                                         AND ecbf002 = g_ecba002_t
 
   
   #將key修正為調整後   
   UPDATE aecm200_detail 
      #更新key欄位
      SET ecbf001 = g_ecba_m.ecba001
          , ecbf002 = g_ecba_m.ecba002
 
      #更新共用欄位
       
   #將資料塞回原table   
   INSERT INTO ecbf_t SELECT * FROM aecm200_detail
   
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = "reproduce"
      LET g_errparam.popup = TRUE
      CALL cl_err()

      RETURN
   END IF
   
   DROP TABLE aecm200_detail
   #CREATE TEMP TABLE
   LET ls_sql = "CREATE GLOBAL TEMPORARY TABLE aecm200_detail AS ",
                "SELECT * FROM ecbg_t "  
   PREPARE repro_tb6 FROM ls_sql
   EXECUTE repro_tb6
   FREE repro_tb6
                
   #將符合條件的資料丟入TEMP TABLE
   INSERT INTO aecm200_detail SELECT * FROM ecbg_t 
                                         WHERE ecbgent = g_enterprise AND ecbgsite = g_site AND ecbg001 = g_ecba001_t
                                         AND ecbg002 = g_ecba002_t
 
   
   #將key修正為調整後   
   UPDATE aecm200_detail 
      #更新key欄位
      SET ecbg001 = g_ecba_m.ecba001
          , ecbg002 = g_ecba_m.ecba002
 
      #更新共用欄位
       
   #將資料塞回原table   
   INSERT INTO ecbg_t SELECT * FROM aecm200_detail
   
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = "reproduce"
      LET g_errparam.popup = TRUE
      CALL cl_err()

      RETURN
   END IF
   DROP TABLE aecm200_detail
   #end add-point
 
 
   
 
   
   #多語言複製段落
   
   
   CALL s_transaction_end('Y','0')
   
   #已新增完, 調整資料內容(修改時使用)
   LET g_ecba001_t = g_ecba_m.ecba001
   LET g_ecba002_t = g_ecba_m.ecba002
 
   
   DROP TABLE aecm200_detail
   
END FUNCTION
 
{</section>}
 
{<section id="aecm200.delete" >}
#+ 資料刪除
PRIVATE FUNCTION aecm200_delete()
   DEFINE  l_var_keys      DYNAMIC ARRAY OF STRING
   DEFINE  l_field_keys    DYNAMIC ARRAY OF STRING
   DEFINE  l_vars          DYNAMIC ARRAY OF STRING
   DEFINE  l_fields        DYNAMIC ARRAY OF STRING
   DEFINE  l_var_keys_bak  DYNAMIC ARRAY OF STRING
   #add-point:delete段define

   #end add-point     
   
   IF g_ecba_m.ecba001 IS NULL
   OR g_ecba_m.ecba002 IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code   = "std-00003" 
      LET g_errparam.popup  = FALSE 
      CALL cl_err()
 
      RETURN
   END IF
   
   
 
   CALL aecm200_show()
   
   CALL s_transaction_begin()
 
   OPEN aecm200_cl USING g_enterprise, g_site,g_ecba_m.ecba001,g_ecba_m.ecba002
   IF STATUS THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "OPEN aecm200_cl:" 
      LET g_errparam.code   = STATUS 
      LET g_errparam.popup  = TRUE 
      CALL cl_err()
 
      CLOSE aecm200_cl
      CALL s_transaction_end('N','0')
      RETURN
   END IF
 
   #顯示最新的資料
   #EXECUTE aecm200_master_referesh USING g_ecba_m.ecba001,g_ecba_m.ecba002 INTO g_ecba_m.ecba001,g_ecba_m.ecba002,   #160707-00040#1 mark 
   EXECUTE aecm200_master_referesh USING g_site,g_ecba_m.ecba001,g_ecba_m.ecba002 INTO g_ecba_m.ecba001,g_ecba_m.ecba002,   #160707-00040#1 
       g_ecba_m.ecba003,g_ecba_m.ecba004,g_ecba_m.ecba005,g_ecba_m.ecba006,g_ecba_m.ecba007,g_ecba_m.ecbastus, 
       g_ecba_m.ecbacrtid,g_ecba_m.ecbacrtdp,g_ecba_m.ecbacrtdt,g_ecba_m.ecbaownid,g_ecba_m.ecbaowndp, 
       g_ecba_m.ecbamodid,g_ecba_m.ecbamoddt,g_ecba_m.ecbacnfid,g_ecba_m.ecbacnfdt,g_ecba_m.ecbacrtid_desc, 
       g_ecba_m.ecbacrtdp_desc,g_ecba_m.ecbaownid_desc,g_ecba_m.ecbaowndp_desc,g_ecba_m.ecbamodid_desc, 
       g_ecba_m.ecbacnfid_desc
 
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = g_ecba_m.ecba001 
      LET g_errparam.code   = SQLCA.sqlcode 
      LET g_errparam.popup  = FALSE 
      CALL cl_err()
 
      CALL s_transaction_end('N','0')
      RETURN
   END IF
   
   #add-point:delete段before ask
   IF g_ecba_m.ecbastus <> 'N' THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'apm-00034'
      LET g_errparam.extend = g_ecba_m.ecbastus
      LET g_errparam.popup = TRUE
      CALL cl_err()

      RETURN
   END IF
   #end add-point 
 
   IF cl_ask_del_master() THEN              #確認一下
   
      #add-point:單頭刪除前

      #end add-point   
      
      #+ 此段落由子樣板a47產生
      #刪除相關文件
      CALL aecm200_set_pk_array()
      #add-point:相關文件刪除前

      #end add-point   
      CALL cl_doc_remove()  
 
  
  
      #資料備份
      LET g_ecba001_t = g_ecba_m.ecba001
      LET g_ecba002_t = g_ecba_m.ecba002
 
 
      DELETE FROM ecba_t
       WHERE ecbaent = g_enterprise AND ecbasite = g_site AND ecba001 = g_ecba_m.ecba001
         AND ecba002 = g_ecba_m.ecba002
 
       
      #add-point:單頭刪除中

      #end add-point
       
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = g_ecba_m.ecba001 
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = FALSE 
         CALL cl_err()
 
         CALL s_transaction_end('N','0')
         RETURN
      END IF
      
      #add-point:單頭刪除後

      #end add-point
  
      #add-point:單身刪除前

      #end add-point
      
      DELETE FROM ecbb_t
       WHERE ecbbent = g_enterprise AND ecbbsite = g_site AND ecbb001 = g_ecba_m.ecba001
         AND ecbb002 = g_ecba_m.ecba002
 
 
      #add-point:單身刪除中

      #end add-point
         
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "ecbb_t" 
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = FALSE 
         CALL cl_err()
 
         CALL s_transaction_end('N','0')
         RETURN
      END IF    
 
      #add-point:單身刪除後
      DELETE FROM ecbc_t
       WHERE ecbcent = g_enterprise 
         AND ecbcsite = g_site 
         AND ecbc001 = g_ecba_m.ecba001
         AND ecbc002 = g_ecba_m.ecba002
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "ecbc_t"
         LET g_errparam.popup = FALSE
         CALL cl_err()
 
         CALL s_transaction_end('N','0')
         RETURN
      END IF
      DELETE FROM ecbd_t
       WHERE ecbdent = g_enterprise 
         AND ecbdsite = g_site 
         AND ecbd001 = g_ecba_m.ecba001
         AND ecbd002 = g_ecba_m.ecba002
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "ecbd_t"
         LET g_errparam.popup = FALSE
         CALL cl_err()
 
         CALL s_transaction_end('N','0')
         RETURN
      END IF
      DELETE FROM ecbe_t
       WHERE ecbeent = g_enterprise 
         AND ecbesite = g_site 
         AND ecbe001 = g_ecba_m.ecba001 
         AND ecbe002 = g_ecba_m.ecba002
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "ecbe_t"
         LET g_errparam.popup = TRUE
         CALL cl_err()

         CALL s_transaction_end('N','0')
         RETURN   
      END IF
      DELETE FROM ecbf_t
       WHERE ecbfent = g_enterprise 
         AND ecbfsite = g_site 
         AND ecbf001 = g_ecba_m.ecba001 
         AND ecbf002 = g_ecba_m.ecba002
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "ecbf_t"
         LET g_errparam.popup = TRUE
         CALL cl_err()

         CALL s_transaction_end('N','0')
         RETURN  
      END IF
      DELETE FROM ecbg_t
       WHERE ecbgent = g_enterprise 
         AND ecbgsite = g_site 
         AND ecbg001 = g_ecba_m.ecba001 
         AND ecbg002 = g_ecba_m.ecba002
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "ecbg_t"
         LET g_errparam.popup = TRUE
         CALL cl_err()

         CALL s_transaction_end('N','0')
         RETURN
      END IF 
      
      #160112-00011#2 20160121 add by ming -----(S) 
      DELETE FROM ecbi_t
       WHERE ecbient  = g_enterprise
         AND ecbisite = g_site
         AND ecbi001  = g_ecba_m.ecba001
         AND ecbi002  = g_ecba_m.ecba002
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.extend = 'ecbi_t'
         LET g_errparam.code   = SQLCA.sqlcode
         LET g_errparam.popup  = TRUE
         CALL cl_err()

         CALL s_transaction_end('N','0')
         RETURN
      END IF
      #160112-00011#2 20160121 add by ming -----(E) 
      #end add-point
      
            
                                                               
 
 
 
                                                               
      CLEAR FORM
      CALL g_ecbb_d.clear() 
 
     
      #CALL aecm200_ui_browser_refresh()  
      CALL aecm200_ui_headershow()  
      CALL aecm200_ui_detailshow()
       
      IF g_browser_cnt > 0 THEN 
         CALL aecm200_browser_fill("")
         CALL aecm200_fetch('P')
         DISPLAY g_browser_cnt TO FORMONLY.h_count   #總筆數的顯示
      ELSE
         LET g_wc = " 1=1"
         CALL aecm200_browser_fill("F")
      END IF
 
      #add-point:多語言刪除

      #end add-point
      
      #單頭多語言刪除
      
      
      #單身多語言刪除
      
 
 
   
      #add-point:多語言刪除

      #end add-point
   
   END IF
 
   CALL s_transaction_end('Y','0')
   
   CLOSE aecm200_cl
 
   #流程通知預埋點-D
   CALL cl_flow_notify(g_ecba_m.ecba001,'D')
    
END FUNCTION
 
{</section>}
 
{<section id="aecm200.b_fill" >}
#+ 單身陣列填充
PRIVATE FUNCTION aecm200_b_fill()
   DEFINE p_wc2      STRING
   #add-point:b_fill段define

   #end add-point     
 
   CALL g_ecbb_d.clear()    #g_ecbb_d 單頭及單身 
 
 
   #add-point:b_fill段sql_before

   #end add-point
   
   #判斷是否填充
   IF aecm200_fill_chk(1) THEN
   
      LET g_sql = "SELECT  UNIQUE ecbb003,ecbb004,ecbb005,ecbb006,ecbb007,ecbb008,ecbb009,ecbb010,ecbb011, 
          ecbb012,ecbb037,ecbb038,ecbb024,ecbb025,ecbb026,ecbb027,ecbb034,ecbb013,ecbb014,ecbb015,ecbb016,ecbb017,ecbb018, 
          ecbb019,ecbb020,ecbb030,ecbb031,ecbb032,ecbb021,ecbb022,ecbb023,ecbb033,ecbb028,ecbb029,ecbb035, 
          ecbb036 ,t1.oocql004 ,t2.oocql004 ,t3.oocql004 ,t4.ecaa002 ,t5.pmaal004 FROM ecbb_t",   
                  #" INNER JOIN ecba_t ON ecba001 = ecbb001 ",
                  #" AND ecba002 = ecbb002 ",
 
                  #"",
                  
                  "",
                                 " LEFT JOIN oocql_t t1 ON t1.oocqlent='"||g_enterprise||"' AND t1.oocql001='221' AND t1.oocql002=ecbb004 AND t1.oocql003='"||g_dlang||"' ",
               " LEFT JOIN oocql_t t2 ON t2.oocqlent='"||g_enterprise||"' AND t2.oocql001='221' AND t2.oocql002=ecbb008 AND t2.oocql003='"||g_dlang||"' ",
               " LEFT JOIN oocql_t t3 ON t3.oocqlent='"||g_enterprise||"' AND t3.oocql001='221' AND t3.oocql002=ecbb010 AND t3.oocql003='"||g_dlang||"' ",
               " LEFT JOIN ecaa_t t4 ON t4.ecaaent='"||g_enterprise||"' AND t4.ecaasite='"||g_site||"' AND t4.ecaa001=ecbb012  ",
               " LEFT JOIN pmaal_t t5 ON t5.pmaalent='"||g_enterprise||"' AND t5.pmaal001=ecbb014 AND t5.pmaal002='"||g_dlang||"' ",
 
                  " WHERE ecbbent=? AND ecbbsite=? AND ecbb001=? AND ecbb002=?"
      LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
      #add-point:b_fill段sql_before

      #end add-point
      IF NOT cl_null(g_wc2_table1) THEN
         LET g_sql = g_sql CLIPPED, " AND ", g_wc2_table1 CLIPPED
      END IF
      
      #子單身的WC
      
      
      LET g_sql = g_sql, " ORDER BY ecbb_t.ecbb003"
      
      #add-point:單身填充控制

      #end add-point
      
      LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
      PREPARE aecm200_pb FROM g_sql
      DECLARE b_fill_cs CURSOR FOR aecm200_pb
      
      LET g_cnt = l_ac
      LET l_ac = 1
      
      OPEN b_fill_cs USING g_enterprise, g_site,g_ecba_m.ecba001,g_ecba_m.ecba002
                                               
      FOREACH b_fill_cs INTO g_ecbb_d[l_ac].ecbb003,g_ecbb_d[l_ac].ecbb004,g_ecbb_d[l_ac].ecbb005,g_ecbb_d[l_ac].ecbb006, 
          g_ecbb_d[l_ac].ecbb007,g_ecbb_d[l_ac].ecbb008,g_ecbb_d[l_ac].ecbb009,g_ecbb_d[l_ac].ecbb010, 
          g_ecbb_d[l_ac].ecbb011,g_ecbb_d[l_ac].ecbb012,g_ecbb_d[l_ac].ecbb037,g_ecbb_d[l_ac].ecbb038,
          g_ecbb_d[l_ac].ecbb024,g_ecbb_d[l_ac].ecbb025, 
          g_ecbb_d[l_ac].ecbb026,g_ecbb_d[l_ac].ecbb027,g_ecbb_d[l_ac].ecbb034,g_ecbb_d[l_ac].ecbb013, 
          g_ecbb_d[l_ac].ecbb014,g_ecbb_d[l_ac].ecbb015,g_ecbb_d[l_ac].ecbb016,g_ecbb_d[l_ac].ecbb017, 
          g_ecbb_d[l_ac].ecbb018,g_ecbb_d[l_ac].ecbb019,g_ecbb_d[l_ac].ecbb020,g_ecbb_d[l_ac].ecbb030, 
          g_ecbb_d[l_ac].ecbb031,g_ecbb_d[l_ac].ecbb032,g_ecbb_d[l_ac].ecbb021,g_ecbb_d[l_ac].ecbb022, 
          g_ecbb_d[l_ac].ecbb023,g_ecbb_d[l_ac].ecbb033,g_ecbb_d[l_ac].ecbb028,g_ecbb_d[l_ac].ecbb029, 
          g_ecbb_d[l_ac].ecbb035,g_ecbb_d[l_ac].ecbb036,g_ecbb_d[l_ac].ecbb004_desc,g_ecbb_d[l_ac].ecbb008_desc, 
          g_ecbb_d[l_ac].ecbb010_desc,g_ecbb_d[l_ac].ecbb012_desc,g_ecbb_d[l_ac].ecbb014_desc
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "FOREACH:" 
            LET g_errparam.code   = SQLCA.sqlcode 
            LET g_errparam.popup  = TRUE 
            CALL cl_err()
 
            EXIT FOREACH
         END IF
        
         #add-point:b_fill段資料填充
         CALL aecm200_ecbb_desc()
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
   
   CALL g_ecbb_d.deleteElement(g_ecbb_d.getLength())
 
   
 
   LET l_ac = g_cnt
   LET g_cnt = 0  
   
   FREE aecm200_pb
 
   
END FUNCTION
 
{</section>}
 
{<section id="aecm200.delete_b" >}
#+ 刪除單身後其他table連動
PRIVATE FUNCTION aecm200_delete_b(ps_table,ps_keys_bak,ps_page)
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
      DELETE FROM ecbb_t
       WHERE ecbbent = g_enterprise AND ecbbsite = g_site AND
         ecbb001 = ps_keys_bak[1] AND ecbb002 = ps_keys_bak[2] AND ecbb003 = ps_keys_bak[3]
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
   
 
   
 
   
   #add-point:delete_b段other
   
   #end add-point  
   
END FUNCTION
 
{</section>}
 
{<section id="aecm200.insert_b" >}
#+ 新增單身後其他table連動
PRIVATE FUNCTION aecm200_insert_b(ps_table,ps_keys,ps_page)
   DEFINE ps_table    STRING
   DEFINE ps_page     STRING
   DEFINE ps_keys     DYNAMIC ARRAY OF VARCHAR(500)
   DEFINE ls_group    STRING
   DEFINE ls_page     STRING
   #add-point:insert_b段define

   #end add-point     
   
   #判斷是否是同一群組的table
   LET ls_group = "'1',"
   IF ls_group.getIndexOf(ps_page,1) > 0 THEN
      #add-point:insert_b段資料新增前

      #end add-point 
      INSERT INTO ecbb_t
                  (ecbbent, ecbbsite,
                   ecbb001,ecbb002,
                   ecbb003
                   ,ecbb004,ecbb005,ecbb006,ecbb007,ecbb008,ecbb009,ecbb010,ecbb011,ecbb012,ecbb024,ecbb025,ecbb026,ecbb027,ecbb034,ecbb013,ecbb014,ecbb015,ecbb016,ecbb017,ecbb018,ecbb019,ecbb020,ecbb030,ecbb031,ecbb032,ecbb021,ecbb022,ecbb023,ecbb033,ecbb028,ecbb029,ecbb035,ecbb036,ecbb037,ecbb038) 
            VALUES(g_enterprise, g_site,
                   ps_keys[1],ps_keys[2],ps_keys[3]
                   ,g_ecbb_d[g_detail_idx].ecbb004,g_ecbb_d[g_detail_idx].ecbb005,g_ecbb_d[g_detail_idx].ecbb006, 
                       g_ecbb_d[g_detail_idx].ecbb007,g_ecbb_d[g_detail_idx].ecbb008,g_ecbb_d[g_detail_idx].ecbb009, 
                       g_ecbb_d[g_detail_idx].ecbb010,g_ecbb_d[g_detail_idx].ecbb011,g_ecbb_d[g_detail_idx].ecbb012, 
                       g_ecbb_d[g_detail_idx].ecbb024,g_ecbb_d[g_detail_idx].ecbb025,g_ecbb_d[g_detail_idx].ecbb026, 
                       g_ecbb_d[g_detail_idx].ecbb027,g_ecbb_d[g_detail_idx].ecbb034,g_ecbb_d[g_detail_idx].ecbb013, 
                       g_ecbb_d[g_detail_idx].ecbb014,g_ecbb_d[g_detail_idx].ecbb015,g_ecbb_d[g_detail_idx].ecbb016, 
                       g_ecbb_d[g_detail_idx].ecbb017,g_ecbb_d[g_detail_idx].ecbb018,g_ecbb_d[g_detail_idx].ecbb019, 
                       g_ecbb_d[g_detail_idx].ecbb020,g_ecbb_d[g_detail_idx].ecbb030,g_ecbb_d[g_detail_idx].ecbb031, 
                       g_ecbb_d[g_detail_idx].ecbb032,g_ecbb_d[g_detail_idx].ecbb021,g_ecbb_d[g_detail_idx].ecbb022, 
                       g_ecbb_d[g_detail_idx].ecbb023,g_ecbb_d[g_detail_idx].ecbb033,g_ecbb_d[g_detail_idx].ecbb028, 
                       g_ecbb_d[g_detail_idx].ecbb029,g_ecbb_d[g_detail_idx].ecbb035,g_ecbb_d[g_detail_idx].ecbb036,
                       g_ecbb_d[g_detail_idx].ecbb037,g_ecbb_d[g_detail_idx].ecbb038) 
 
      #add-point:insert_b段資料新增中

      #end add-point 
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "ecbb_t" 
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = FALSE 
         CALL cl_err()
 
      END IF
      #add-point:insert_b段資料新增後
      #add--151215-00002#4 By shiun--(S)
      IF g_aecm200_05_chk THEN
       IF cl_get_para(g_enterprise,g_site,'S-MFG-0036') = '2' THEN #add by yangxb 170503使用APS高端查询时，弹窗
         IF NOT cl_null(g_ecba_m.ecba001) AND  NOT cl_null(g_ecba_m.ecba002) AND NOT cl_null(g_ecbb_d[l_ac].ecbb003) AND (NOT cl_null(g_ecbb_d[l_ac].ecbb037) OR NOT cl_null(g_ecbb_d[l_ac].ecbb038)) THEN
            CALL aecm200_05(g_ecba_m.ecba001,g_ecba_m.ecba002,g_ecbb_d[l_ac].ecbb003)
         END IF 
       END IF   #add by yangxb 170503
      END IF
      #add--151215-00002#4 By shiun--(E)
      #end add-point 
   END IF
   
 
   
 
   
   #add-point:insert_b段other

   #end add-point     
   
END FUNCTION
 
{</section>}
 
{<section id="aecm200.update_b" >}
#+ 修改單身後其他table連動
PRIVATE FUNCTION aecm200_update_b(ps_table,ps_keys,ps_keys_bak,ps_page)
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
   IF ls_group.getIndexOf(ps_page,1) > 0 AND ps_table <> "ecbb_t" THEN
      #add-point:update_b段修改前

      #end add-point     
      UPDATE ecbb_t 
         SET (ecbb001,ecbb002,
              ecbb003
              ,ecbb004,ecbb005,ecbb006,ecbb007,ecbb008,ecbb009,ecbb010,ecbb011,ecbb012,ecbb024,ecbb025,ecbb026,ecbb027,ecbb034,ecbb013,ecbb014,ecbb015,ecbb016,ecbb017,ecbb018,ecbb019,ecbb020,ecbb030,ecbb031,ecbb032,ecbb021,ecbb022,ecbb023,ecbb033,ecbb028,ecbb029,ecbb035,ecbb036,ecbb037,ecbb038) 
              = 
             (ps_keys[1],ps_keys[2],ps_keys[3]
              ,g_ecbb_d[g_detail_idx].ecbb004,g_ecbb_d[g_detail_idx].ecbb005,g_ecbb_d[g_detail_idx].ecbb006, 
                  g_ecbb_d[g_detail_idx].ecbb007,g_ecbb_d[g_detail_idx].ecbb008,g_ecbb_d[g_detail_idx].ecbb009, 
                  g_ecbb_d[g_detail_idx].ecbb010,g_ecbb_d[g_detail_idx].ecbb011,g_ecbb_d[g_detail_idx].ecbb012, 
                  g_ecbb_d[g_detail_idx].ecbb024,g_ecbb_d[g_detail_idx].ecbb025,g_ecbb_d[g_detail_idx].ecbb026, 
                  g_ecbb_d[g_detail_idx].ecbb027,g_ecbb_d[g_detail_idx].ecbb034,g_ecbb_d[g_detail_idx].ecbb013, 
                  g_ecbb_d[g_detail_idx].ecbb014,g_ecbb_d[g_detail_idx].ecbb015,g_ecbb_d[g_detail_idx].ecbb016, 
                  g_ecbb_d[g_detail_idx].ecbb017,g_ecbb_d[g_detail_idx].ecbb018,g_ecbb_d[g_detail_idx].ecbb019, 
                  g_ecbb_d[g_detail_idx].ecbb020,g_ecbb_d[g_detail_idx].ecbb030,g_ecbb_d[g_detail_idx].ecbb031, 
                  g_ecbb_d[g_detail_idx].ecbb032,g_ecbb_d[g_detail_idx].ecbb021,g_ecbb_d[g_detail_idx].ecbb022, 
                  g_ecbb_d[g_detail_idx].ecbb023,g_ecbb_d[g_detail_idx].ecbb033,g_ecbb_d[g_detail_idx].ecbb028, 
                  g_ecbb_d[g_detail_idx].ecbb029,g_ecbb_d[g_detail_idx].ecbb035,g_ecbb_d[g_detail_idx].ecbb036,
                  g_ecbb_d[g_detail_idx].ecbb037,g_ecbb_d[g_detail_idx].ecbb038)  
 
         WHERE ecbbent = g_enterprise AND ecbbsite = g_site AND ecbb001 = ps_keys_bak[1] AND ecbb002 = ps_keys_bak[2] AND ecbb003 = ps_keys_bak[3]
      #add-point:update_b段修改中

      #end add-point   
      CASE
         WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "ecbb_t" 
            LET g_errparam.code   = "std-00009" 
            LET g_errparam.popup  = TRUE 
            CALL cl_err()
 
            CALL s_transaction_end('N','0')
         WHEN SQLCA.sqlcode #其他錯誤
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "ecbb_t" 
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
 
{<section id="aecm200.lock_b" >}
#+ 連動lock其他單身table資料
PRIVATE FUNCTION aecm200_lock_b(ps_table,ps_page)
   DEFINE ps_page     STRING
   DEFINE ps_table    STRING
   DEFINE ls_group    STRING
   #add-point:lock_b段define
   
   #end add-point   
   
   #先刷新資料
   #CALL aecm200_b_fill()
   
   #鎖定整組table
   #LET ls_group = "'1',"
   #僅鎖定自身table
   LET ls_group = "ecbb_t"
   
   IF ls_group.getIndexOf(ps_table,1) THEN
      OPEN aecm200_bcl USING g_enterprise, g_site,
                                       g_ecba_m.ecba001,g_ecba_m.ecba002,g_ecbb_d[g_detail_idx].ecbb003  
                                               
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "aecm200_bcl" 
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
 
{<section id="aecm200.unlock_b" >}
#+ 連動unlock其他單身table資料
PRIVATE FUNCTION aecm200_unlock_b(ps_table,ps_page)
   DEFINE ps_page     STRING
   DEFINE ps_table    STRING
   DEFINE ls_group    STRING
   #add-point:unlock_b段define
   
   #end add-point  
   
   LET ls_group = "'1',"
   
   IF ls_group.getIndexOf(ps_page,1) THEN
      CLOSE aecm200_bcl
   END IF
   
 
   
 
 
   #add-point:unlock_b段other
   
   #end add-point  
 
END FUNCTION
 
{</section>}
 
{<section id="aecm200.set_entry" >}
#+ 單頭欄位開啟設定
PRIVATE FUNCTION aecm200_set_entry(p_cmd)
   DEFINE p_cmd   LIKE type_t.chr1  
   #add-point:set_entry段define
   
   #end add-point       
 
   IF p_cmd = 'a' THEN
      CALL cl_set_comp_entry("ecba001,ecba002",TRUE)
      #add-point:set_entry段欄位控制
      
      #end add-point  
   END IF
   
   #add-point:set_entry段欄位控制後
   
   #end add-point 
 
END FUNCTION
 
{</section>}
 
{<section id="aecm200.set_no_entry" >}
#+ 單頭欄位關閉設定
PRIVATE FUNCTION aecm200_set_no_entry(p_cmd)
   DEFINE p_cmd   LIKE type_t.chr1   
   #add-point:set_no_entry段define
   
   #end add-point     
 
   IF p_cmd = 'u' AND g_chkey = 'N' THEN
      CALL cl_set_comp_entry("ecba001,ecba002",FALSE)
      #add-point:set_no_entry段欄位控制
      
      #end add-point 
   END IF 
   
   #add-point:set_no_entry段欄位控制後
   
   #end add-point 
 
END FUNCTION
 
{</section>}
 
{<section id="aecm200.set_entry_b" >}
#+ 單身欄位開啟設定
PRIVATE FUNCTION aecm200_set_entry_b(p_cmd)
   DEFINE p_cmd   LIKE type_t.chr1   
   #add-point:set_entry_b段define
   
   #end add-point     
   
   IF p_cmd = 'a' THEN
      CALL cl_set_comp_entry("",TRUE)
      #add-point:set_entry段欄位控制
      
      #end add-point  
   END IF
   
   #add-point:set_entry_b段
   CALL cl_set_comp_entry("ecbb007",TRUE)
   CALL cl_set_comp_entry("ecbb009",TRUE)
   #end add-point  
END FUNCTION
 
{</section>}
 
{<section id="aecm200.set_no_entry_b" >}
#+ 單身欄位關閉設定
PRIVATE FUNCTION aecm200_set_no_entry_b(p_cmd)
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
   IF NOT (g_ecbb_d[l_ac].ecbb006 = '2' OR g_ecbb_d[l_ac].ecbb006 = '3') THEN
      CALL cl_set_comp_entry("ecbb007",FALSE)
      LET g_ecbb_d[l_ac].ecbb007 = ""
   END IF
   
   IF g_ecbb_d[l_ac].ecbb008 = 'INIT' OR g_ecbb_d[l_ac].ecbb008 = 'MULT' THEN
      LET g_ecbb_d[l_ac].ecbb009 = 0
      CALL cl_set_comp_entry("ecbb009",FALSE)
   END IF
   LET l_n = 0 
   SELECT COUNT(*) INTO l_n
     FROM ecbb_t
    WHERE ecbbent = g_enterprise
      AND ecbbsite = g_site
      AND ecbb001 = g_ecba_m.ecba001
      AND ecbb002 = g_ecba_m.ecba002
      AND ecbb007 = g_ecbb_d[l_ac].ecbb008
   IF l_n > 0 THEN
      LET g_ecbb_d[l_ac].ecbb009 = 0
      CALL cl_set_comp_entry("ecbb009",FALSE)
   END IF
   #end add-point     
END FUNCTION
 
{</section>}
 
{<section id="aecm200.default_search" >}
#+ 外部參數搜尋
PRIVATE FUNCTION aecm200_default_search()
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
      LET ls_wc = ls_wc, " ecba001 = '", g_argv[01], "' AND "
   END IF
   
   IF NOT cl_null(g_argv[02]) THEN
      LET ls_wc = ls_wc, " ecba002 = '", g_argv[02], "' AND "
   END IF
 
   
   IF NOT cl_null(ls_wc) THEN
      LET g_wc = ls_wc.subString(1,ls_wc.getLength()-5)
      LET g_default = TRUE
   ELSE
      LET g_default = FALSE
      #預設查詢條件
      LET g_wc = cl_qbe_get_default_qryplan()
      IF cl_null(g_wc) THEN
         LET g_wc = " 1=1"
      END IF
   END IF
   
   #add-point:default_search段結束前

   #end add-point  
 
END FUNCTION
 
{</section>}
 
{<section id="aecm200.state_change" >}
   #+ 此段落由子樣板a09產生
#+ 確認碼變更
PRIVATE FUNCTION aecm200_statechange()
   DEFINE lc_state LIKE type_t.chr5
   #add-point:statechange段define
   DEFINE l_time      DATETIME YEAR TO SECOND
   DEFINE l_ecbb003   LIKE ecbb_t.ecbb003             ##20150909 by wuxja  add 
   #end add-point  
   
   #add-point:statechange段開始前
   #160825-00026#1---add---s
   IF NOT aecm200_check_ecca() THEN 
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'aec-00060'
      LET g_errparam.extend = g_ecba_m.ecba001
      LET g_errparam.popup = TRUE
      CALL cl_err()

      RETURN      
   END IF
   #160825-00026#1---add---e
   #end add-point  
   
   ERROR ""     #清空畫面右下側ERROR區塊
 
   IF g_ecba_m.ecba001 IS NULL
      OR g_ecba_m.ecba002 IS NULL
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
         CASE g_ecba_m.ecbastus
            WHEN "N"
               HIDE OPTION "open"
            WHEN "X"
               HIDE OPTION "void"
            WHEN "Y"
               HIDE OPTION "valid"
            
         END CASE
     
      #add-point:menu前
      IF g_ecba_m.ecbastus = 'Y' THEN
         CALL cl_set_act_visible("void",FALSE)
      END IF
      IF g_ecba_m.ecbastus = 'X' THEN
         CALL cl_set_act_visible("valid",FAlSE)
      END IF
      #end add-point
      
      ON ACTION open
         IF cl_auth_chk_act("open") THEN
            LET lc_state = "N"
            #add-point:action控制

            #end add-point
         END IF
         EXIT MENU
#      ON ACTION void
#         IF cl_auth_chk_act("void") THEN
#            LET lc_state = "X"
#            #add-point:action控制

            #end add-point
#         END IF
#         EXIT MENU
      ON ACTION valid
         IF cl_auth_chk_act("valid") THEN
            LET lc_state = "Y"
            #add-point:action控制
         CALL aecm200_chk_valid() RETURNING l_ecbb003
         IF NOT cl_null(g_errno) THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = g_errno
            LET g_errparam.extend = g_ecba_m.ecba001
           #20150909 by wuxja  add  --begin--
            IF NOT cl_null(l_ecbb003) THEN
               LET g_errparam.extend = g_errparam.extend,"      |",l_ecbb003
            END IF
           #20150909 by wuxja  add  --end--
            LET g_errparam.popup = TRUE
            CALL cl_err()

            RETURN
         END IF
            #end add-point
         END IF
         EXIT MENU
    
      
      
      #add-point:stus控制
      #160411-00012#1---add---begin  
      ON ACTION void
         IF cl_auth_chk_act("void") THEN
            LET lc_state = "X"

         END IF
         EXIT MENU
      #160411-00012#1---add---end   
      #end add-point
      
   END MENU
   
   IF (lc_state <> "N" 
      AND lc_state <> "X"
      AND lc_state <> "Y"
      ) OR 
      cl_null(lc_state) THEN
      RETURN
   END IF
   
   #add-point:stus修改前

   #end add-point
      
   UPDATE ecba_t SET ecbastus = lc_state 
    WHERE ecbaent = g_enterprise AND ecbasite = g_site AND ecba001 = g_ecba_m.ecba001
      AND ecba002 = g_ecba_m.ecba002
  
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code   = SQLCA.sqlcode 
      LET g_errparam.popup  = FALSE 
      CALL cl_err()
 
   ELSE
      CASE lc_state
         WHEN "N"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/open.png")
         WHEN "X"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/void.png")
         WHEN "Y"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/valid.png")
         
      END CASE
      LET g_ecba_m.ecbastus = lc_state
      DISPLAY BY NAME g_ecba_m.ecbastus
   END IF
 
   #add-point:stus修改後
   IF lc_state = "Y" THEN
      LET l_time = cl_get_current()
      UPDATE ecba_t SET ecbacnfid = g_user,
                        ecbacnfdt = l_time
       WHERE ecbaent = g_enterprise
         AND ecbasite = g_site
         AND ecba001 = g_ecba_m.ecba001
         AND ecba002 = g_ecba_m.ecba002
   END IF
   IF lc_state = "N" THEN
      UPDATE ecba_t SET ecbacnfid = '',
                        ecbacnfdt = ''
       WHERE ecbaent = g_enterprise
         AND ecbasite = g_site
         AND ecba001 = g_ecba_m.ecba001
         AND ecba002 = g_ecba_m.ecba002
   END IF
   #end add-point
 
   #add-point:statechange段結束前

   #end add-point  
 
END FUNCTION
 
 
 
{</section>}
 
{<section id="aecm200.idx_chk" >}
#+ 顯示正確的單身資料筆數
PRIVATE FUNCTION aecm200_idx_chk()
   #add-point:idx_chk段define
   IF g_current_page = 2 THEN
      LET g_detail_idx = g_curr_diag.getCurrentRow("s_detail2")
      IF g_detail_idx > g_ecbb2_d.getLength() THEN
         LET g_detail_idx = g_ecbb2_d.getLength()
      END IF
      IF g_detail_idx = 0 AND g_ecbb2_d.getLength() <> 0 THEN
         LET g_detail_idx = 1
      END IF
      DISPLAY g_detail_idx TO FORMONLY.idx
      DISPLAY g_ecbb_d.getLength() TO FORMONLY.cnt
   END IF
   IF g_current_page = 3 THEN
      LET g_detail_idx = g_curr_diag.getCurrentRow("s_detail3")
      IF g_detail_idx > g_ecbb3_d.getLength() THEN
         LET g_detail_idx = g_ecbb3_d.getLength()
      END IF
      IF g_detail_idx = 0 AND g_ecbb3_d.getLength() <> 0 THEN
         LET g_detail_idx = 1
      END IF
      DISPLAY g_detail_idx TO FORMONLY.idx
      DISPLAY g_ecbb_d.getLength() TO FORMONLY.cnt
   END IF
   
   #end add-point  
   
   IF g_current_page = 1 THEN
      LET g_detail_idx = g_curr_diag.getCurrentRow("s_detail1")
      IF g_detail_idx > g_ecbb_d.getLength() THEN
         LET g_detail_idx = g_ecbb_d.getLength()
      END IF
      IF g_detail_idx = 0 AND g_ecbb_d.getLength() <> 0 THEN
         LET g_detail_idx = 1
      END IF
      DISPLAY g_detail_idx TO FORMONLY.idx
      DISPLAY g_ecbb_d.getLength() TO FORMONLY.cnt
   END IF
   
 
   
   #add-point:idx_chk段other
   
   #end add-point  
   
END FUNCTION
 
{</section>}
 
{<section id="aecm200.b_fill2" >}
#+ 單身陣列填充2
PRIVATE FUNCTION aecm200_b_fill2(pi_idx)
   DEFINE pi_idx          LIKE type_t.num10  #161108-00012#1 num5==》num10
   DEFINE li_ac           LIKE type_t.num10  #161108-00012#1 num5==》num10
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
   
   CALL aecm200_detail_show()
   
END FUNCTION
 
{</section>}
 
{<section id="aecm200.fill_chk" >}
#+ 單身填充確認
PRIVATE FUNCTION aecm200_fill_chk(ps_idx)
   DEFINE ps_idx        LIKE type_t.chr10
   #add-point:fill_chk段define
   
   #end add-point
   
   #add-point:fill_chk段before_chk
   
   #end add-point
   
   #全部為1=1 or null時回傳true
   IF (cl_null(g_wc2_table1) OR g_wc2_table1.trim() = '1=1') THEN
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
 
 
   
   #add-point:fill_chk段after_chk
   
   #end add-point
   
   RETURN FALSE
 
END FUNCTION
 
{</section>}
 
{<section id="aecm200.signature" >}
   
 
{</section>}
 
{<section id="aecm200.set_pk_array" >}
   #+ 此段落由子樣板a51產生
#+ 給予pk_array內容
PRIVATE FUNCTION aecm200_set_pk_array()
   #add-point:set_pk_array段define
   
   #end add-point
   
   #add-point:set_pk_array段之前
   
   #end add-point  
   
   CALL g_pk_array.clear()
   LET g_pk_array[1].values = g_ecba_m.ecba001
   LET g_pk_array[1].column = 'ecba001'
   LET g_pk_array[2].values = g_ecba_m.ecba002
   LET g_pk_array[2].column = 'ecba002'
   
   #add-point:set_pk_array段之後
   
   #end add-point  
   
END FUNCTION
 
 
 
{</section>}
 
{<section id="aecm200.other_dialog" readonly="Y" >}
   
 
{</section>}
 
{<section id="aecm200.other_function" readonly="Y" >}
#+單身3填充
PRIVATE FUNCTION aecm200_b_fill_2()
 
   IF l_ac = 0 OR cl_null(l_ac) THEN
      RETURN
   END IF
   IF l_ac1 = 0 OR cl_null(l_ac1) THEN
      RETURN
   END IF
   CALL g_ecbb3_d.clear()
   IF cl_null(g_ecbb2_d[l_ac1].ecbc004) THEN
      CALL g_ecbb2_d.deleteElement(l_ac1)
      RETURN
   END IF
   LET g_sql = "SELECT UNIQUE ecbd005,ecbd006,ecbd007,ecbd008 ",
               "  FROM ecbd_t",   
               " WHERE ecbdent=? AND ecbdsite=? AND ecbd001=? AND ecbd002=? AND ecbd003 = ? AND ecbd004 = ? "
   
   IF NOT cl_null(g_wc4_table1) THEN
      LET g_sql = g_sql CLIPPED, " AND ", g_wc4_table1 CLIPPED
   END IF
   
   LET g_sql = g_sql, " ORDER BY ecbd_t.ecbd005"
   
   PREPARE aecm200_pb2 FROM g_sql
   DECLARE b_fill_cs2 CURSOR FOR aecm200_pb2
   
   LET g_cnt = l_ac2
   LET l_ac2 = 1
   
   OPEN b_fill_cs2 USING g_enterprise, g_site,g_ecba_m.ecba001,g_ecba_m.ecba002,g_ecbb_d[l_ac].ecbb003,g_ecbb2_d[l_ac1].ecbc004
                                           
   FOREACH b_fill_cs2 INTO g_ecbb3_d[l_ac2].ecbd005,g_ecbb3_d[l_ac2].ecbd006,g_ecbb3_d[l_ac2].ecbd007,g_ecbb3_d[l_ac2].ecbd008
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "FOREACH:"
         LET g_errparam.popup = TRUE
         CALL cl_err()

         EXIT FOREACH
      END IF
   
      LET l_ac2 = l_ac2 + 1
      IF l_ac2 > g_max_rec AND g_error_show = 1 THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code =  9035
         LET g_errparam.extend =  ''
         LET g_errparam.popup = TRUE
         CALL cl_err()

         EXIT FOREACH
      END IF
   END FOREACH
   LET g_error_show = 0
   
   CALL g_ecbb3_d.deleteElement(g_ecbb3_d.getLength())

   

   LET l_ac2 = g_cnt
   LET g_cnt = 0  
   
   FREE aecm200_pb2
END FUNCTION
#用量單位檢查
PRIVATE FUNCTION aecm200_chk_ecbc009()
DEFINE l_imaa006               LIKE imaa_t.imaa006
DEFINE r_success               LIKE type_t.num5
DEFINE r_rate                  LIKE type_t.num26_10


    LET g_errno = ''
    LET r_rate = ''
    LET l_imaa006 = ''
    IF NOT cl_null(g_ecbb2_d[l_ac1].ecbc009) THEN
       SELECT imaa006 INTO l_imaa006
         FROM imaa_t
        WHERE imaaent = g_enterprise
          AND imaa001 = g_ecbb2_d[l_ac1].ecbc005
        IF NOT cl_null(g_ecbb2_d[l_ac1].ecbc009) AND NOT cl_null(l_imaa006) THEN
           CALL s_aimi190_get_convert(g_ecbb2_d[l_ac1].ecbc005,g_ecbb2_d[l_ac1].ecbc009,l_imaa006) RETURNING r_success,r_rate
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
#+單身2參考欄位顯示
PRIVATE FUNCTION aecm200_ecbc_desc()
   
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_ecbb2_d[l_ac1].ecbc005
   CALL ap_ref_array2(g_ref_fields,"SELECT imaal003,imaal004 FROM imaal_t WHERE imaalent='"||g_enterprise||"' AND imaal001=? AND imaal002='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_ecbb2_d[l_ac1].ecbc005_desc = g_rtn_fields[1]
   LET g_ecbb2_d[l_ac1].ecbc005_desc1 = g_rtn_fields[2]
   DISPLAY BY NAME g_ecbb2_d[l_ac1].ecbc005_desc
   DISPLAY BY NAME g_ecbb2_d[l_ac1].ecbc005_desc1

   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_ecbb2_d[l_ac1].ecbc006
   CALL ap_ref_array2(g_ref_fields,"SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001 = '215' AND oocql002=? AND oocql003='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_ecbb2_d[l_ac1].ecbc006_desc = g_rtn_fields[1]
   DISPLAY BY NAME g_ecbb2_d[l_ac1].ecbc006_desc
END FUNCTION
#+單身2填充
PRIVATE FUNCTION aecm200_b_fill_1()
   
   IF l_ac = 0 OR cl_null(l_ac) THEN
      RETURN
   END IF
   CALL g_ecbb2_d.clear()
   IF cl_null(g_ecbb_d[l_ac].ecbb003) THEN
      CALL g_ecbb_d.deleteElement(l_ac)
      RETURN
   END IF
   LET g_sql = "SELECT UNIQUE ecbc004,ecbc005,'','',ecbc006,'',ecbc007,ecbc008,ecbc009,ecbc010 ",
               "  FROM ecbc_t",   
               " WHERE ecbcent=? AND ecbcsite=? AND ecbc001=? AND ecbc002=? AND ecbc003 = ?"
   
   IF NOT cl_null(g_wc3_table1) THEN
      LET g_sql = g_sql CLIPPED, " AND ", g_wc3_table1 CLIPPED
   END IF
   
   LET g_sql = g_sql, " ORDER BY ecbc_t.ecbc004"
   
   PREPARE aecm200_pb1 FROM g_sql
   DECLARE b_fill_cs1 CURSOR FOR aecm200_pb1
   
   LET g_cnt = l_ac1
   LET l_ac1 = 1
   
   OPEN b_fill_cs1 USING g_enterprise, g_site,g_ecba_m.ecba001,g_ecba_m.ecba002,g_ecbb_d[l_ac].ecbb003
                                           
   FOREACH b_fill_cs1 INTO g_ecbb2_d[l_ac1].ecbc004,g_ecbb2_d[l_ac1].ecbc005,g_ecbb2_d[l_ac1].ecbc005_desc,g_ecbb2_d[l_ac1].ecbc005_desc1,g_ecbb2_d[l_ac1].ecbc006,g_ecbb2_d[l_ac1].ecbc006_desc,g_ecbb2_d[l_ac1].ecbc007,g_ecbb2_d[l_ac1].ecbc008,g_ecbb2_d[l_ac1].ecbc009,g_ecbb2_d[l_ac1].ecbc010
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "FOREACH:"
         LET g_errparam.popup = TRUE
         CALL cl_err()

         EXIT FOREACH
      END IF
      CALL aecm200_ecbc_desc()
      LET l_ac1 = l_ac1 + 1
      IF l_ac1 > g_max_rec AND g_error_show = 1 THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code =  9035
         LET g_errparam.extend =  ''
         LET g_errparam.popup = TRUE
         CALL cl_err()

         EXIT FOREACH
      END IF
   END FOREACH
   LET g_error_show = 0
   
   CALL g_ecbb2_d.deleteElement(g_ecbb2_d.getLength())

   

   LET l_ac1 = g_cnt
   LET g_cnt = 0  
   
   FREE aecm200_pb1
   
END FUNCTION
#起始截止數量檢查
PRIVATE FUNCTION aecm200_chk_ecbd005(p_qty,p_type,p_cmd)
DEFINE l_n         LIKE type_t.num5
DEFINE l_sql       STRING
DEFINE p_qty       LIKE ecbd_t.ecbd005
DEFINE p_type      LIKE type_t.chr1     #1.ecbd005 2.ecbd006
DEFINE p_cmd       LIKE type_t.chr1
DEFINE l_ecbd005   LIKE ecbd_t.ecbd005
DEFINE l_ecbd006   LIKE ecbd_t.ecbd006

   LET g_errno = ""
   IF cl_null(l_ac) OR l_ac = 0 THEN RETURN END IF
   IF cl_null(l_ac1) OR l_ac1 = 0 THEN RETURN END IF
   
   IF p_cmd = 'a' THEN
      LET l_sql = " SELECT ecbd005,ecbd006 ",
                  "   FROM ecbd_t",
                  "  WHERE ecbdent = '",g_enterprise,"' ",
                  "    AND ecbdsite = '",g_site,"' ",
                  "    AND ecbd001 = '",g_ecba_m.ecba001,"' ",
                  "    AND ecbd002 = '",g_ecba_m.ecba002,"' ",
                  "    AND ecbd003 = '",g_ecbb_d[l_ac].ecbb003,"'",
                  "    AND ecbd004 = '",g_ecbb2_d[l_ac1].ecbc004,"'"
   ELSE
      LET l_sql = " SELECT ecbd005,ecbd006",
                  "   FROM ecbd_t",
                  "  WHERE ecbdent = '",g_enterprise,"' ",
                  "    AND ecbdsite = '",g_site,"' ",
                  "    AND ecbd001 = '",g_ecba_m.ecba001,"' ",
                  "    AND ecbd002 = '",g_ecba_m.ecba002,"' ",
                  "    AND ecbd003 = '",g_ecbb_d[l_ac].ecbb003,"'",
                  "    AND ecbd004 = '",g_ecbb2_d[l_ac1].ecbc004,"'",
                  "    AND ecbd005 <> '",g_ecbb3_d_t.ecbd005,"'"
   END IF
   PREPARE aecm200_chk_ecbd005_pb FROM l_sql
   DECLARE aecm200_chk_ecbd005_cs CURSOR FOR aecm200_chk_ecbd005_pb
   FOREACH aecm200_chk_ecbd005_cs INTO l_ecbd005,l_ecbd006
      #--当笔输入的值不能再其他笔起止数量范围内
      #当笔输入的值不能在其他笔数量范围内
      IF NOT cl_null(l_ecbd006) AND (p_qty >= l_ecbd005 AND p_qty <= l_ecbd006) THEN
         LET g_errno = 'aec-00004'
         RETURN
      END IF
      #当笔输入的值不能在其他笔无穷大范围内
      IF cl_null(l_ecbd006) AND p_qty >= l_ecbd005 THEN
         LET g_errno = 'aec-00004'
         RETURN
      END IF
      CASE p_type
         WHEN '1'   #ecbd005
              #--当笔输入的范围，不能包含到其他笔的起止数量
              IF p_qty <= l_ecbd005 AND NOT cl_null(g_ecbb3_d[l_ac2].ecbd006) AND g_ecbb3_d[l_ac2].ecbd006 >= l_ecbd006 THEN
                 LET g_errno = 'aec-00004'
                 RETURN
              END IF
         WHEN '2'   #ecbd006
              #--当笔输入的范围，不能包含到其他笔的起止数量
              IF NOT cl_null(g_ecbb3_d[l_ac2].ecbd005) AND g_ecbb3_d[l_ac2].ecbd005 <= l_ecbd005 AND p_qty >= l_ecbd006 THEN
                 LET g_errno = 'aec-00004'
                 RETURN
              END IF
              #当笔输入无穷大的，需检查当笔输入的起始数量，不可小于其他笔截止数量
              IF NOT cl_null(g_ecbb3_d[l_ac2].ecbd005) AND cl_null(p_qty) AND g_ecbb3_d[l_ac2].ecbd005 <= l_ecbd006 THEN
                 LET g_errno = 'aec-00004'
                 RETURN
              END IF
              #当笔输入无穷大的，需检查其他笔没有无穷大的（不可出现两个无穷大的）
              IF NOT cl_null(g_ecbb3_d[l_ac2].ecbd005) AND cl_null(p_qty) AND cl_null(l_ecbd006) THEN
                 LET g_errno = 'aec-00004'
                 RETURN
              END IF
      END CASE
   END FOREACH
END FUNCTION
#起始數量預設值
PRIVATE FUNCTION aecm200_def_ecbd005()
DEFINE l_n          LIKE type_t.num5
DEFINE i            LIKE type_t.num5
DEFINE l_imae016    LIKE imae_t.imae016
DEFINE l_ooca002    LIKE ooca_t.ooca002
DEFINE l_ecbd006    LIKE ecbd_t.ecbd006
DEFINE l_str        STRING
DEFINE l_num        LIKE type_t.num5
            
   LET l_n = 0
   IF cl_null(l_ac) OR l_ac = 0 THEN RETURN END IF
   IF cl_null(l_ac1) OR l_ac1 = 0 THEN RETURN END IF
   SELECT COUNT(*) INTO l_n 
     FROM ecbd_t
    WHERE ecbdent = g_enterprise
      AND ecbdsite = g_site
      AND ecbd001 = g_ecba_m.ecba001
      AND ecbd002 = g_ecba_m.ecba002
      AND ecbd003 = g_ecbb_d[l_ac].ecbb003
      AND ecbd004 = g_ecbb2_d[l_ac1].ecbc004
   IF l_n = 0 THEN
      LET g_ecbb3_d[l_ac2].ecbd005 = 0
   ELSE
      SELECT imae016 INTO l_imae016
        FROM imae_t
       WHERE imaeent = g_enterprise
         AND imaesite = g_site
         AND imae001 = g_ecbb2_d[l_ac1].ecbc005
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
      END IF
      IF l_ooca002 = 1 THEN
         LET l_num = 0.1
      END IF
      IF l_ooca002 = 2 THEN
         LET l_num = 0.01
      END IF
      IF l_ooca002 > 2 THEN
         LET l_str = '0'
         FOR i=1 TO l_ooca002 -2
             LET l_str = '0',l_str
         END FOR
         LET l_str = '0.',l_str,'1'
         LET l_num = l_str
      END IF
      SELECT MAX(ecbd006) INTO l_ecbd006
        FROM ecbd_t
       WHERE ecbdent = g_enterprise
         AND ecbdsite = g_site
         AND ecbd001 = g_ecba_m.ecba001
         AND ecbd002 = g_ecba_m.ecba002
         AND ecbd003 = g_ecbb_d[l_ac].ecbb003
         AND ecbd004 = g_ecbb2_d[l_ac1].ecbc004
      IF NOT cl_null(l_ecbd006) THEN
         LET g_ecbb3_d[l_ac2].ecbd005 = l_ecbd006 + l_num +1
      END IF
   END IF
   DISPLAY BY NAME g_ecbb3_d[l_ac2].ecbd005
END FUNCTION
#+單身1參考欄位顯示
PRIVATE FUNCTION aecm200_ecbb_desc()
   
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_ecbb_d[l_ac].ecbb004
   CALL ap_ref_array2(g_ref_fields,"SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001 = '221' AND oocql002=? AND oocql003='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_ecbb_d[l_ac].ecbb004_desc =  g_rtn_fields[1]
   #170105-00055#1--add--start--
   IF cl_null(g_ecbb_d[l_ac].ecbb004_desc) THEN
      LET g_ecbb_d[l_ac].ecbb004_desc='-'
   END IF
   #170105-00055#1--add--end----
   DISPLAY BY NAME g_ecbb_d[l_ac].ecbb004_desc
 
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_ecbb_d[l_ac].ecbb008
   CALL ap_ref_array2(g_ref_fields,"SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001 = '221' AND oocql002=? AND oocql003='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_ecbb_d[l_ac].ecbb008_desc = g_rtn_fields[1]
   DISPLAY BY NAME g_ecbb_d[l_ac].ecbb008_desc
 
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_ecbb_d[l_ac].ecbb010
   CALL ap_ref_array2(g_ref_fields,"SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001 = '221' AND oocql002=? AND oocql003='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_ecbb_d[l_ac].ecbb010_desc = g_rtn_fields[1] 
   DISPLAY BY NAME g_ecbb_d[l_ac].ecbb010_desc
 
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_ecbb_d[l_ac].ecbb012
   CALL ap_ref_array2(g_ref_fields,"SELECT ecaa002 FROM ecaa_t WHERE ecaaent='"||g_enterprise||"' AND ecaasite='"||g_site||"' AND ecaa001=? ","") RETURNING g_rtn_fields
   LET g_ecbb_d[l_ac].ecbb012_desc = g_rtn_fields[1] 
   DISPLAY BY NAME g_ecbb_d[l_ac].ecbb012_desc
   
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_ecbb_d[l_ac].ecbb037
   CALL ap_ref_array2(g_ref_fields,"SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001 = '1103' AND oocql002=? AND oocql003='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_ecbb_d[l_ac].ecbb037_desc =  g_rtn_fields[1]
   DISPLAY BY NAME g_ecbb_d[l_ac].ecbb037_desc
   
   #add--151215-00002#4 By shiun--(S)
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_ecbb_d[l_ac].ecbb038
   CALL ap_ref_array2(g_ref_fields,"SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001 = '1103' AND oocql002=? AND oocql003='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_ecbb_d[l_ac].ecbb038_desc =  g_rtn_fields[1]
   DISPLAY BY NAME g_ecbb_d[l_ac].ecbb038_desc
   #add--151215-00002#4 By shiun--(E)
 
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_ecbb_d[l_ac].ecbb014
   CALL ap_ref_array2(g_ref_fields,"SELECT pmaal004 FROM pmaal_t WHERE pmaalent='"||g_enterprise||"' AND pmaal001=? AND pmaal002='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_ecbb_d[l_ac].ecbb014_desc = g_rtn_fields[1]
   DISPLAY BY NAME g_ecbb_d[l_ac].ecbb014_desc
   
   IF NOT cl_null(g_ecbb_d[l_ac].ecbb003) THEN
      CALL s_aooi360_sel('7',g_site,g_ecba_m.ecba001,g_ecba_m.ecba002,g_ecbb_d[l_ac].ecbb003,'','','','','','','4') RETURNING l_success,g_ecbb_d[l_ac].ooff013
   END IF   
      
END FUNCTION
#+單頭參考欄位顯示
PRIVATE FUNCTION aecm200_desc()
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_ecba_m.ecba001
   CALL ap_ref_array2(g_ref_fields,"SELECT imaal003,imaal004 FROM imaal_t WHERE imaalent='"||g_enterprise||"' AND imaal001=? AND imaal002='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_ecba_m.ecba001_desc = g_rtn_fields[1]
   LET g_ecba_m.ecba001_desc1 = g_rtn_fields[2]
   DISPLAY BY NAME g_ecba_m.ecba001_desc
   DISPLAY BY NAME g_ecba_m.ecba001_desc1
   
   IF NOT cl_null(g_ecba_m.ecba001) AND NOT cl_null(g_ecba_m.ecba002) THEN
      CALL s_aooi360_sel('6',g_site,g_ecba_m.ecba001,g_ecba_m.ecba002,'','','','','','','','4') RETURNING l_success,g_ecba_m.ooeb013
      DISPLAY BY NAME g_ecba_m.ooeb013
   END IF
END FUNCTION
#+用量單位賦值
PRIVATE FUNCTION aecm200_def_ecbc009()
   SELECT imaa006 INTO  g_ecbb2_d[l_ac1].ecbc009
     FROM imaa_t
    WHERE imaaent = g_enterprise
      AND imaa001 = g_ecbb2_d[l_ac1].ecbc005
   DISPLAY BY NAME  g_ecbb2_d[l_ac1].ecbc009
END FUNCTION
#+本站作業+制程序不可以重複
PRIVATE FUNCTION aecm200_chk_ecbb004(p_cmd)
DEFINE p_cmd    LIKE type_t.chr1
DEFINE l_n      LIKE type_t.num5

   LET g_errno = ""
   LET l_n = 0
   IF p_cmd = 'a' THEN
      SELECT COUNT(*) INTO l_n
        FROM ecbb_t
       WHERE ecbbent = g_enterprise
         AND ecbbsite = g_site
         AND ecbb001 = g_ecba_m.ecba001
         AND ecbb002 = g_ecba_m.ecba002
         AND ecbb004 = g_ecbb_d[l_ac].ecbb004
         AND ecbb005 = g_ecbb_d[l_ac].ecbb005
   ELSE
      SELECT COUNT(*) INTO l_n
        FROM ecbb_t
       WHERE ecbbent = g_enterprise
         AND ecbbsite = g_site
         AND ecbb001 = g_ecba_m.ecba001
         AND ecbb002 = g_ecba_m.ecba002
         AND ecbb004 = g_ecbb_d[l_ac].ecbb004
         AND ecbb005 = g_ecbb_d[l_ac].ecbb005
         AND ecbb003 <> g_ecbb_d_t.ecbb003
   END IF
   IF l_n > 0 THEN
      LET g_errno = 'aec-00006'
   END IF
END FUNCTION
#+制程序賦值
PRIVATE FUNCTION aecm200_def_ecbb005()
DEFINE l_ecbb005    LIKE ecbb_t.ecbb005
DEFINE l_ecbb005_1  LIKE type_t.num5

   SELECT MAX(ecbb005) INTO l_ecbb005
     FROM ecbb_t
    WHERE ecbbent = g_enterprise
      AND ecbbsite = g_site
      AND ecbb001 = g_ecba_m.ecba001
      AND ecbb002 = g_ecba_m.ecba002
      AND ecbb004 = g_ecbb_d[l_ac].ecbb004
   LET l_ecbb005_1 = l_ecbb005
   LET l_ecbb005_1 = l_ecbb005_1 +1
   LET g_ecbb_d[l_ac].ecbb005 = l_ecbb005_1
   IF cl_null(g_ecbb_d[l_ac].ecbb005) THEN
      LET g_ecbb_d[l_ac].ecbb005 = 1
   END IF
   DISPLAY BY NAME g_ecbb_d[l_ac].ecbb005
END FUNCTION
#+上站作業+上站制程序檢查
PRIVATE FUNCTION aecm200_chk_ecbb008(p_cmd)
DEFINE l_n         LIKE type_t.num5
DEFINE p_cmd       LIKE type_t.chr1

   LET g_errno = ""
   IF g_ecbb_d[l_ac].ecbb008 = 'INIT' OR g_ecbb_d[l_ac].ecbb008 = 'MULT' THEN
      RETURN
   END IF
   LET l_n = 0
   SELECT COUNT(*) INTO l_n
     FROM ecbb_t
    WHERE ecbbent = g_enterprise
      AND ecbbsite = g_site
      AND ecbb001 = g_ecba_m.ecba001
      AND ecbb002 = g_ecba_m.ecba002
      AND ecbb007 = g_ecbb_d[l_ac].ecbb008
   IF l_n > 0 THEN
      RETURN
   END IF
   LET l_n = 0
   IF p_cmd = 'a' THEN
      SELECT COUNT(*) INTO l_n
        FROM ecbb_t
       WHERE ecbbent = g_enterprise
         AND ecbbsite = g_site
         AND ecbb001 = g_ecba_m.ecba001
         AND ecbb002 = g_ecba_m.ecba002
         AND ecbb004 = g_ecbb_d[l_ac].ecbb008
         AND ecbb005 = g_ecbb_d[l_ac].ecbb009
   ELSE
      SELECT COUNT(*) INTO l_n
        FROM ecbb_t
       WHERE ecbbent = g_enterprise
         AND ecbbsite = g_site
         AND ecbb001 = g_ecba_m.ecba001
         AND ecbb002 = g_ecba_m.ecba002
         AND ecbb004 = g_ecbb_d[l_ac].ecbb008
         AND ecbb005 = g_ecbb_d[l_ac].ecbb009
         AND ecbb003 <> g_ecbb_d[l_ac].ecbb003
   END IF   
   IF l_n = 0 THEN
      LET g_errno = 'aec-00007'
   END IF
END FUNCTION
################################################################################
# Descriptions...: 回寫下站作業+下站制程序
# Memo...........:
# Usage..........: CALL aecm200_return_ecbb(p_ecbb008,p_ecbb009)
# Input parameter: p_ecbb008 上站作業
#................: p_ecbb009 上站制程序
# Return code....: 無
# Date & Author..: 2013/10/29 BY xumm
# Modify.........:
################################################################################
PRIVATE FUNCTION aecm200_return_ecbb(p_ecbb008,p_ecbb009)
DEFINE p_ecbb008    LIKE ecbb_t.ecbb008
DEFINE p_ecbb009    LIKE ecbb_t.ecbb009
DEFINE l_n          LIKE type_t.num5
DEFINE l_ecbb007    LIKE ecbb_t.ecbb007
DEFINE l_tot        LIKE type_t.num5
DEFINE l_n1         LIKE type_t.num5

   #計算多上站資料有幾筆相同的上站作業+製程序
   LET l_tot = 0
   SELECT COUNT(*) INTO l_tot FROM ecbe_t
    WHERE ecbeent = g_enterprise
      AND ecbesite = g_site
      AND ecbe001 = g_ecba_m.ecba001
      AND ecbe002 = g_ecba_m.ecba002
      AND ecbe004 = p_ecbb008
      AND ecbe005 = p_ecbb009
         
      
   CASE 
      #兩筆以上時，本站作業+製程序=p_ecbb008+p_ecbb009的下站作業+製程序更新為MULT+0
      WHEN l_tot > 1   
           LET l_n = 0
           LET l_n1 = 0
           SELECT COUNT(DISTINCT ecbb007),COUNT(ecbb007) INTO l_n,l_n1
             FROM ecbb_t
            WHERE ecbbent = g_enterprise
              AND ecbbsite = g_site
              AND ecbb001 = g_ecba_m.ecba001
              AND ecbb002 = g_ecba_m.ecba002
              AND ecbb004 = p_ecbb008
              AND ecbb005 = p_ecbb009
              AND ecbb007 IS  NOT NULL
           IF l_n > 1 OR l_n1 <> l_tot THEN
              UPDATE ecbb_t SET ecbb010 = 'MULT',
                                ecbb011 = 0
               WHERE ecbbent = g_enterprise
                 AND ecbbsite = g_site
                 AND ecbb001 = g_ecba_m.ecba001
                 AND ecbb002 = g_ecba_m.ecba002
                 AND ecbb004 = p_ecbb008
                 AND ecbb005 = p_ecbb009
           ELSE
              UPDATE ecbb_t SET ecbb010 = g_ecbb_d[l_ac].ecbb007,          
                                ecbb011 = g_ecbb_d[l_ac].ecbb005
               WHERE ecbbent = g_enterprise
                 AND ecbbsite = g_site
                 AND ecbb001 = g_ecba_m.ecba001
                 AND ecbb002 = g_ecba_m.ecba002
                 AND ecbb004 = p_ecbb008
                 AND ecbb005 = p_ecbb009
           END IF
           IF SQLCA.sqlcode THEN
              INITIALIZE g_errparam TO NULL
              LET g_errparam.code = SQLCA.sqlcode
              LET g_errparam.extend = "ecbb_t"
              LET g_errparam.popup = TRUE
              CALL cl_err()

              CALL s_transaction_end('N','0')
           END IF
      #只有一筆時，本站作業+製程序=p_ecbb008+p_ecbb009的資料更新下站作業+製程序
      WHEN l_tot = 1
           IF NOT cl_null(g_ecbb_d[l_ac].ecbb007) THEN
              #維護群組
              #更新上站作業+上站制程序且無維護群組或群組不一樣的資料對應下站程序+下站制程序為本資料的群組+本站  
              UPDATE ecbb_t SET ecbb010 = g_ecbb_d[l_ac].ecbb007,          
                                ecbb011 = 0
               WHERE ecbbent = g_enterprise
                 AND ecbbsite = g_site
                 AND ecbb001 = g_ecba_m.ecba001
                 AND ecbb002 = g_ecba_m.ecba002
                 AND ecbb004 = p_ecbb008
                 AND ecbb005 = p_ecbb009
                 AND (ecbb007 IS NULL OR ecbb007 <> g_ecbb_d[l_ac].ecbb007)
              IF SQLCA.sqlcode THEN
                 INITIALIZE g_errparam TO NULL
              LET g_errparam.code = SQLCA.sqlcode
              LET g_errparam.extend = "ecbb_t"
              LET g_errparam.popup = TRUE
              CALL cl_err()

                 CALL s_transaction_end('N','0')
              END IF
              #更新上站作業+上站制程序且有維護群組(相同群組)的資料對應下站程序+下站制程序為本資料的本站程序+本站制程序
              UPDATE ecbb_t SET ecbb010 = g_ecbb_d[l_ac].ecbb004,          
                                ecbb011 = g_ecbb_d[l_ac].ecbb005
               WHERE ecbbent = g_enterprise
                 AND ecbbsite = g_site
                 AND ecbb001 = g_ecba_m.ecba001
                 AND ecbb002 = g_ecba_m.ecba002
                 AND ecbb004 = p_ecbb008
                 AND ecbb005 = p_ecbb009
                 AND ecbb007 = g_ecbb_d[l_ac].ecbb007
              IF SQLCA.sqlcode THEN
                 INITIALIZE g_errparam TO NULL
              LET g_errparam.code = SQLCA.sqlcode
              LET g_errparam.extend = "ecbb_t"
              LET g_errparam.popup = TRUE
              CALL cl_err()

                 CALL s_transaction_end('N','0')
              END IF
           ELSE
              #無維護群組
              #更新上站作業+上站制程序對應下站程序+下站制程序為本資料的本站程序+本站制程序
              UPDATE ecbb_t SET ecbb010 = g_ecbb_d[l_ac].ecbb004,          
                                ecbb011 = g_ecbb_d[l_ac].ecbb005
               WHERE ecbbent = g_enterprise
                 AND ecbbsite = g_site
                 AND ecbb001 = g_ecba_m.ecba001
                 AND ecbb002 = g_ecba_m.ecba002
                 AND ecbb004 = p_ecbb008
                 AND ecbb005 = p_ecbb009
              IF SQLCA.sqlcode THEN
                 INITIALIZE g_errparam TO NULL
              LET g_errparam.code = SQLCA.sqlcode
              LET g_errparam.extend = "ecbb_t"
              LET g_errparam.popup = TRUE
              CALL cl_err()

                 CALL s_transaction_end('N','0')
              END IF
           END IF
           #若p_ecbb008為群組
           LET l_n = 0
           SELECT COUNT(*) INTO l_n FROM ecbb_t
            WHERE ecbbent = g_enterprise
              AND ecbbsite = g_site
              AND ecbb001 = g_ecba_m.ecba001
              AND ecbb002 = g_ecba_m.ecba002
              AND ecbb007 = p_ecbb008
           IF l_n > 0 THEN
              UPDATE ecbb_t SET ecbb010 = g_ecbb_d[l_ac].ecbb004,
                                ecbb011 = g_ecbb_d[l_ac].ecbb005
               WHERE ecbbent = g_enterprise
                 AND ecbbsite = g_site
                 AND ecbb001 = g_ecba_m.ecba001
                 AND ecbb002 = g_ecba_m.ecba002
                 AND ecbb007 = p_ecbb008
                 AND ecbb010 = 'END'
                 AND ecbb011 = 0
              IF SQLCA.sqlcode THEN
                 INITIALIZE g_errparam TO NULL
              LET g_errparam.code = SQLCA.sqlcode
              LET g_errparam.extend = "ecbb_t"
              LET g_errparam.popup = TRUE
              CALL cl_err()

                 CALL s_transaction_end('N','0')
              END IF
           END IF
        
   END CASE
END FUNCTION
################################################################################
# Descriptions...: 複製單頭品名規格顯示
# Memo...........:
# Usage..........: CALL aecm200_rdesc(p_newno)
# Input parameter: p_newno   製程料號
# Return code....: 無
# Date & Author..: 2013/11/11 By xumm
# Modify.........:
################################################################################
PRIVATE FUNCTION aecm200_rdesc(p_newno)
DEFINE p_newno      LIKE ecba_t.ecba001

   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = p_newno
   CALL ap_ref_array2(g_ref_fields,"SELECT imaal003,imaal004 FROM imaal_t WHERE imaalent='"||g_enterprise||"' AND imaal001=? AND imaal002='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_ecba_m.ecba001_desc = g_rtn_fields[1]
   LET g_ecba_m.ecba001_desc1 = g_rtn_fields[2]
   DISPLAY BY NAME g_ecba_m.ecba001_desc
   DISPLAY BY NAME g_ecba_m.ecba001_desc1
END FUNCTION
################################################################################
# Descriptions...: 抓取上站作業+上站制程序的資料
# Memo...........:
# Usage..........: CALL aecm200_return_ecbb_mult()
# Input parameter: 無
# Return code....: 無
# Date & Author..: 2013/11/13 By xumm
# Modify.........: 2014/6/6   By wuxj
################################################################################
PRIVATE FUNCTION aecm200_return_ecbb_mult()
DEFINE l_ecbe004      LIKE ecbe_t.ecbe004
DEFINE l_ecbe005      LIKE ecbe_t.ecbe005
DEFINE l_n            LIKE type_t.num5
DEFINE r_success      LIKE type_t.num5
#DEFINE l_ecbb         RECORD LIKE ecbb_t.*  #161124-00048#1  16/12/06 By 08734 mark
#161124-00048#1  16/12/06 By 08734 add(S)
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
#161124-00048#1  16/12/06 By 08734 add(E)
DEFINE l_ecbb010      LIKE ecbb_t.ecbb010
DEFINE l_ecbb011      LIKE ecbb_t.ecbb011
DEFINE l_tot          LIKE type_t.num5
DEFINE l_n0           LIKE type_t.num5
DEFINE l_n1           LIKE type_t.num5
DEFINE l_n2           LIKE type_t.num5
DEFINE l_n3           LIKE type_t.num5
DEFINE l_n4           LIKE type_t.num5

   #mark by wuxj
   # LET l_n = 0 
   # SELECT COUNT(*) INTO l_n
   #   FROM ecbe_t
   #  WHERE ecbeent = g_enterprise
   #    AND ecbesite = g_site
   #    AND ecbe001 = g_ecba_m.ecba001
   #    AND ecbe002 = g_ecba_m.ecba002
   #    AND ecbe003 = g_ecbb_d[l_ac].ecbb003
   # #无资料時，本站作業+製程序=p_ecbb008+p_ecbb009的資料更新END+0
   # IF l_n = 1 THEN
   #     #更新上站作業+上站制程序對應下站程序+下站制程序為本資料的本站程序+本站制程序
   #     UPDATE ecbb_t SET ecbb010 = 'END',          
   #                       ecbb011 = 0
   #      WHERE ecbbent = g_enterprise
   #        AND ecbbsite = g_site
   #        AND ecbb001 = g_ecba_m.ecba001
   #        AND ecbb002 = g_ecba_m.ecba002
   #        AND ecbb003 = g_ecbb_d[l_ac].ecbb003
   #     IF SQLCA.sqlcode THEN
   #        INITIALIZE g_errparam TO NULL
   #              LET g_errparam.code = SQLCA.sqlcode
   #              LET g_errparam.extend = "ecbb_t"
   #              LET g_errparam.popup = TRUE
   #              CALL cl_err()
   #
   #        CALL s_transaction_end('N','0')
   #     END IF
   #END IF    
   # #多上站作業+上站製程序
   #  DECLARE ecbb_mult CURSOR FOR
   #   SELECT ecbe004,ecbe005 FROM ecbe_t
   #    WHERE ecbeent = g_enterprise
   #      AND ecbesite = g_site
   #      AND ecbe001 = g_ecba_m.ecba001
   #      AND ecbe002 = g_ecba_m.ecba002
   #      AND ecbe003 = g_ecbb_d[l_ac].ecbb003        
   #  FOREACH ecbb_mult INTO l_ecbe004,l_ecbe005
   #     CALL aecm200_return_ecbb(l_ecbe004,l_ecbe005)
   #  END FOREACH   
   #end mark

   #add by wuxja
   LET r_success = FALSE
   LET l_n = 0 
   DECLARE ecbb_mult0 CURSOR FOR 
   # SELECT * FROM ecbb_t  #161124-00048#1   2016/12/06  By 08734 mark
    SELECT ecbbent,ecbbsite,ecbb001,ecbb002,ecbb003,ecbb004,ecbb005,ecbb006,ecbb007,ecbb008,ecbb009,ecbb010,ecbb011,ecbb012,ecbb013,ecbb014,ecbb015,ecbb016,ecbb017,ecbb018,ecbb019,ecbb020,ecbb021,ecbb022,ecbb023,ecbb024,ecbb025,ecbb026,ecbb027,ecbb028,ecbb029,ecbb030,ecbb031,ecbb032,ecbb033,ecbb034,ecbb035,ecbb036,ecbb037,ecbb038 FROM ecbb_t #161124-00048#1   2016/12/06  By 08734 add
     WHERE ecbbent=g_enterprise AND ecbbsite=g_site
       AND ecbb001 = g_ecba_m.ecba001 AND ecbb002 = g_ecba_m.ecba002
   FOREACH ecbb_mult0 INTO l_ecbb.*
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "FOREACH:"
         LET g_errparam.popup = TRUE
         CALL cl_err()
         EXIT FOREACH
      END IF
      
      #当前作业、作业序，不存在其他站的 上站作业 中，
      #当前群組 也不存在其他站的 上站作业 中，
      #则更新本站对应下站为END,0
      SELECT COUNT(*) INTO l_n4 FROM ecbe_t 
       WHERE ecbeent = g_enterprise AND ecbesite = g_site
         AND ecbe001 = g_ecba_m.ecba001 AND ecbe002 = g_ecba_m.ecba002 
         AND ecbe004 = l_ecbb.ecbb004 AND ecbe005 = l_ecbb.ecbb005
      IF NOT cl_null(l_ecbb.ecbb007) AND l_n4 = 0 THEN 
         SELECT COUNT(*) INTO l_n4 FROM ecbe_t 
          WHERE ecbeent = g_enterprise AND ecbesite = g_site
            AND ecbe001 = g_ecba_m.ecba001 AND ecbe002 = g_ecba_m.ecba002
            AND ecbe004 = l_ecbb.ecbb007 AND ecbe005 = 0
      END IF
      IF l_n4 = 0 THEN
         UPDATE ecbb_t SET ecbb010 = 'END',ecbb011 = 0
          WHERE ecbbent = g_enterprise AND ecbbsite = g_site
            AND ecbb001 = g_ecba_m.ecba001 AND ecbb002 = g_ecba_m.ecba002 
            AND ecbb003 = l_ecbb.ecbb003
      END IF
            
      #多上站作業+上站製程序
      DECLARE ecbb_mult CURSOR FOR
       SELECT ecbe004,ecbe005 FROM ecbe_t
        WHERE ecbeent = g_enterprise AND ecbesite = g_site
          AND ecbe001 = g_ecba_m.ecba001 AND ecbe002 = g_ecba_m.ecba002
          AND ecbe003 = l_ecbb.ecbb003          
      FOREACH ecbb_mult INTO l_ecbe004,l_ecbe005
         #計算一下抓到的上站作業+作業序  是其他幾筆資料的 上站作業+作業序         
         LET l_tot = 0
         SELECT COUNT(*) INTO l_tot FROM ecbe_t
          WHERE ecbeent = g_enterprise  AND ecbesite = g_site
            AND ecbe001 = g_ecba_m.ecba001 AND ecbe002 = g_ecba_m.ecba002
            AND ecbe004 = l_ecbe004 AND ecbe005 = l_ecbe005
        #IF l_tot = 1 THEN  #160113-00001#1 mark
        #160113-00001#1 mod str
         CASE
            WHEN l_tot = 1  #抓到一筆作業+作業序的上站資料
        #160113-00001#1 mod end
               IF NOT cl_null(l_ecbb.ecbb007) THEN   #有維護群組                  
                  #更新上站作業+上站作業序且無維護群組或群組不一樣的資料
                  #對應下站程序+下站制程序為本資料的群組+本站  
                  UPDATE ecbb_t SET ecbb010 = l_ecbb.ecbb007,ecbb011 = '0'
                   WHERE ecbbent = g_enterprise AND ecbbsite = g_site
                     AND ecbb001 = g_ecba_m.ecba001 AND ecbb002 = g_ecba_m.ecba002
                     AND ecbb004 = l_ecbe004 AND ecbb005 = l_ecbe005
                     AND (ecbb007 IS NULL OR ecbb007 <> l_ecbb.ecbb007)
                  IF SQLCA.sqlcode THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = SQLCA.sqlcode
                     LET g_errparam.extend = "ecbb_t"
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                     RETURN r_success 
                  END IF
                  #更新上站作業+上站制程序且有維護群組(相同群組)的資料
                  #對應下站程序+下站制程序為本資料的本站程序+本站制程序
                  UPDATE ecbb_t SET ecbb010 = l_ecbb.ecbb004,ecbb011 = l_ecbb.ecbb005
                   WHERE ecbbent = g_enterprise AND ecbbsite = g_site
                     AND ecbb001 = g_ecba_m.ecba001 AND ecbb002 = g_ecba_m.ecba002
                     AND ecbb004 = l_ecbe004 AND ecbb005 = l_ecbe005
                     AND ecbb007 = l_ecbb.ecbb007
                  IF SQLCA.sqlcode THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = SQLCA.sqlcode
                     LET g_errparam.extend = "ecbb_t"
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                     RETURN r_success
                  END IF
               ELSE    #無維護群組
                  #更新上站作業+上站制程序對應下站程序+下站制程序為本資料的本站程序+本站制程序
                  UPDATE ecbb_t SET ecbb010 = l_ecbb.ecbb004,ecbb011 = l_ecbb.ecbb005
                   WHERE ecbbent = g_enterprise AND ecbbsite = g_site
                     AND ecbb001 = g_ecba_m.ecba001 AND ecbb002 = g_ecba_m.ecba002
                     AND ecbb004 = l_ecbe004 AND ecbb005 = l_ecbe005
                  IF SQLCA.sqlcode THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = SQLCA.sqlcode
                     LET g_errparam.extend = "ecbb_t"
                     LET g_errparam.popup = TRUE
                     CALL cl_err()   
                     RETURN r_success
                  END IF
               END IF
        #160113-00001#1 add str
           WHEN l_tot > 1  #抓到多筆作業+作業序的上站資料
               IF NOT cl_null(l_ecbb.ecbb007) THEN
                  UPDATE ecbb_t SET ecbb010 = l_ecbb.ecbb007, ecbb011 = '0'
                   WHERE ecbbent = g_enterprise AND ecbbsite = g_site
                     AND ecbb001 = g_ecba_m.ecba001 AND ecbb002 = g_ecba_m.ecba002
                     AND ecbb004 = l_ecbe004 AND ecbb005 = l_ecbe005
               ELSE
                  UPDATE ecbb_t SET ecbb010 = 'MULT', ecbb011 = '0'
                   WHERE ecbbent = g_enterprise AND ecbbsite = g_site
                     AND ecbb001 = g_ecba_m.ecba001 AND ecbb002 = g_ecba_m.ecba002
                     AND ecbb004 = l_ecbe004 AND ecbb005 = l_ecbe005
               END IF
           WHEN l_tot = 0  #都不是別人的上站
               UPDATE ecbb_t SET ecbb010 = 'END', ecbb011 = '0'
                WHERE ecbbent = g_enterprise AND ecbbsite = g_site
                  AND ecbb001 = g_ecba_m.ecba001 AND ecbb002 = g_ecba_m.ecba002
                  AND ecbb004 = l_ecbe004 AND ecbb005 = l_ecbe005
         END CASE
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL
               LET g_errparam.code = SQLCA.sqlcode
               LET g_errparam.extend = "ecbb_t"
               LET g_errparam.popup = TRUE
               CALL cl_err()
            RETURN r_success
         END IF
        #160113-00001#1 add end
        #160113-00001#1 mark str
         #ELSE
         #   SELECT COUNT(DISTINCT ecbe004) INTO l_n2 FROM ecbe_t
         #    WHERE ecbeent = g_enterprise  AND ecbesite = g_site
         #      AND ecbe001 = g_ecba_m.ecba001 AND ecbe002 = g_ecba_m.ecba002
         #      AND ecbe004 = l_ecbe004 AND ecbe005 = l_ecbe005
         #   SELECT COUNT(DISTINCT ecbe005) INTO l_n3 FROM ecbe_t
         #    WHERE ecbeent = g_enterprise  AND ecbesite = g_site
         #      AND ecbe001 = g_ecba_m.ecba001 AND ecbe002 = g_ecba_m.ecba002
         #      AND ecbe004 = l_ecbe004 AND ecbe005 = l_ecbe005
         #   IF l_n2 = 1 AND l_n3 = 1 THEN
         #      
         #      UPDATE ecbb_t SET ecbb010 = 'MULT', ecbb011 = '0'
         #       WHERE ecbbent = g_enterprise AND ecbbsite = g_site
         #         AND ecbb001 = g_ecba_m.ecba001 AND ecbb002 = g_ecba_m.ecba002
         #         AND ecbb004 = l_ecbe004 AND ecbb005 = l_ecbe005
         #   ELSE
         #      UPDATE ecbb_t SET ecbb010 = l_ecbb.ecbb007, ecbb011 = '0'
         #       WHERE ecbbent = g_enterprise AND ecbbsite = g_site
         #         AND ecbb001 = g_ecba_m.ecba001 AND ecbb002 = g_ecba_m.ecba002
         #         AND ecbb004 = l_ecbe004 AND ecbb005 = l_ecbe005
         #   END IF
         #   IF SQLCA.sqlcode THEN
         #      INITIALIZE g_errparam TO NULL
         #         LET g_errparam.code = SQLCA.sqlcode
         #         LET g_errparam.extend = "ecbb_t"
         #         LET g_errparam.popup = TRUE
         #         CALL cl_err()
         #      RETURN r_success
         #   END IF
         #END IF
        #160113-00001#1 mark end
         
         SELECT COUNT(*) INTO l_n1 FROM ecbb_t
          WHERE ecbbent = g_enterprise AND ecbbsite = g_site
            AND ecbb001 = g_ecba_m.ecba001 AND ecbb002 = g_ecba_m.ecba002
            AND ecbb007 = l_ecbe004
            AND (ecbb004 NOT IN (SELECT ecbb008 FROM ecbb_t
                                  WHERE ecbbent = g_enterprise AND ecbbsite = g_site
                                    AND ecbb001 = g_ecba_m.ecba001 AND ecbb002 = g_ecba_m.ecba002
                                    AND ecbb007 = l_ecbe004) OR
                 ecbb005 NOT IN (SELECT ecbb009 FROM ecbb_t
                                  WHERE ecbbent = g_enterprise AND ecbbsite = g_site
                                    AND ecbb001 = g_ecba_m.ecba001 AND ecbb002 = g_ecba_m.ecba002
                                    AND ecbb007 = l_ecbe004))
         IF l_n1 > 0 THEN
            IF NOT cl_null(l_ecbb.ecbb007) THEN
               UPDATE ecbb_t SET ecbb010 = l_ecbb.ecbb007,ecbb011 = '0'
                WHERE ecbbent = g_enterprise AND ecbbsite = g_site
                  AND ecbb001 = g_ecba_m.ecba001 AND ecbb002 = g_ecba_m.ecba002
                  AND ecbb007 = l_ecbe004
                  AND (ecbb004 NOT IN (SELECT ecbb008 FROM ecbb_t
                                        WHERE ecbbent = g_enterprise AND ecbbsite = g_site
                                          AND ecbb001 = g_ecba_m.ecba001 AND ecbb002 = g_ecba_m.ecba002
                                          AND ecbb007 = l_ecbe004) OR
                       ecbb005 NOT IN (SELECT ecbb009 FROM ecbb_t
                                        WHERE ecbbent = g_enterprise AND ecbbsite = g_site
                                          AND ecbb001 = g_ecba_m.ecba001 AND ecbb002 = g_ecba_m.ecba002
                                          AND ecbb007 = l_ecbe004))
            ELSE
               UPDATE ecbb_t SET ecbb010 = l_ecbb.ecbb004,ecbb011 = l_ecbb.ecbb005
                WHERE ecbbent = g_enterprise AND ecbbsite = g_site
                  AND ecbb001 = g_ecba_m.ecba001 AND ecbb002 = g_ecba_m.ecba002
                  AND ecbb007 = l_ecbe004
                  AND (ecbb004 NOT IN (SELECT ecbb008 FROM ecbb_t
                                        WHERE ecbbent = g_enterprise AND ecbbsite = g_site
                                          AND ecbb001 = g_ecba_m.ecba001 AND ecbb002 = g_ecba_m.ecba002
                                          AND ecbb007 = l_ecbe004) OR
                       ecbb005 NOT IN (SELECT ecbb009 FROM ecbb_t
                                        WHERE ecbbent = g_enterprise AND ecbbsite = g_site
                                          AND ecbb001 = g_ecba_m.ecba001 AND ecbb002 = g_ecba_m.ecba002
                                          AND ecbb007 = l_ecbe004))
            END IF
            IF SQLCA.sqlcode THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = SQLCA.sqlcode
               LET g_errparam.extend = "ecbb_t"
               LET g_errparam.popup = TRUE
               CALL cl_err()
               RETURN r_success
            END IF
         END IF
      END FOREACH
      
     #160113-00001#1 mark str
      ##若当站对应下站不存在或者为空，则更新下站作业+下站作业序END+0
      #SELECT ecbb010,ecbb011 INTO l_ecbb010,l_ecbb011 FROM ecbb_t
      # WHERE ecbbent=g_enterprise AND ecbbsite=g_site
      #   AND ecbb001=g_ecba_m.ecba001 AND ecbb002=g_ecba_m.ecba002 AND ecbb003=l_ecbb.ecbb003 
      #IF NOT cl_null(l_ecbb010) AND NOT cl_null(l_ecbb011) THEN
      #   SELECT COUNT(*) INTO l_n0 FROM ecbe_t
      #    WHERE ecbeent=g_enterprise AND ecbesite=g_site AND ecbe001=g_ecba_m.ecba001
      #      AND ecbe002=g_ecba_m.ecba002 AND ecbe004=l_ecbb010 AND ecbe005=l_ecbb011
      #   IF l_n0 = 0 THEN
      #      IF l_ecbb.ecbb010 = 'MULT' THEN
      #         SELECT COUNT(*) INTO l_n0 FROM ecbe_t
      #          WHERE ecbeent=g_enterprise AND ecbesite=g_site AND ecbe001=g_ecba_m.ecba001
      #            AND ecbe002=g_ecba_m.ecba002 AND ecbe004=l_ecbb.ecbb004 AND ecbe005=l_ecbb.ecbb005
      #      ELSE
      #         #群组
      #         SELECT COUNT(*) INTO l_n0 FROM ecbb_t
      #          WHERE ecbbent=g_enterprise AND ecbbsite=g_site AND ecbb001=g_ecba_m.ecba001 
      #            AND ecbb002=g_ecba_m.ecba002 AND ecbb008=l_ecbb.ecbb004 AND ecbb009=l_ecbb.ecbb005
      #            AND ecbb007=l_ecbb010
      #         IF l_n0 = 0 THEN
      #            SELECT COUNT(*) INTO l_n0 FROM ecbb_t
      #             WHERE ecbbent=g_enterprise AND ecbbsite=g_site AND ecbb001=g_ecba_m.ecba001 
      #               AND ecbb002=g_ecba_m.ecba002 AND ecbb004=l_ecbb010 AND ecbb005=l_ecbb011
      #               AND ecbb008=l_ecbb.ecbb007
      #            IF l_n0 = 0 THEN
      #               SELECT COUNT(*) INTO l_n0 FROM ecbb_t
      #                WHERE ecbbent=g_enterprise AND ecbbsite=g_site AND ecbb001=g_ecba_m.ecba001 
      #                  AND ecbb002=g_ecba_m.ecba002 AND ecbb007=l_ecbb010 AND ecbb008=l_ecbb.ecbb007
      #               END IF
      #         END IF
      #      END IF
      #   END IF
      #END IF
      #IF cl_null(l_ecbb010) OR l_n0 = 0 THEN           
      #   UPDATE ecbb_t SET ecbb010 = 'END',ecbb011 = '0'
      #    WHERE ecbbent = g_enterprise
      #      AND ecbbsite = g_site
      #      AND ecbb001=g_ecba_m.ecba001
      #      AND ecbb002=g_ecba_m.ecba002 
      #      AND ecbb003=l_ecbb.ecbb003
      #   IF SQLCA.sqlcode THEN
      #      INITIALIZE g_errparam TO NULL
      #      LET g_errparam.code = SQLCA.sqlcode
      #      LET g_errparam.extend = "UPDATE ecbb_t"
      #      LET g_errparam.popup = TRUE
      #      CALL cl_err()
      #
      #      RETURN r_success
      #   END IF
      #END IF
     #160113-00001#1 mark end
   END FOREACH
   
   LET r_success = TRUE
   RETURN r_success
   #end add
END FUNCTION
################################################################################
# Descriptions...: 確認前檢查
# Memo...........:
# Usage..........: CALL aecm200_chk_valid()
# Input parameter: 無
# Return code....: 無
# Date & Author..: 2013/11/15 By xumm
# Modify.........:
################################################################################
PRIVATE FUNCTION aecm200_chk_valid()
DEFINE l_n           LIKE type_t.num5
DEFINE l_sql         STRING
DEFINE l_ecbb008     LIKE ecbb_t.ecbb008
DEFINE l_ecbb009     LIKE ecbb_t.ecbb009
DEFINE l_ecbb010     LIKE ecbb_t.ecbb010      #20150909 by wuxja  add
DEFINE l_ecbb011     LIKE ecbb_t.ecbb011      #20150909 by wuxja  add
DEFINE l_ecbb003     LIKE ecbb_t.ecbb003      #20150909 by wuxja  add
DEFINE l_ecbb012     LIKE ecbb_t.ecbb012      #160808-00011#1 add ecbb012

   LET g_errno = ""
   LET l_n = 0
   SELECT COUNT(*) INTO l_n
     FROM ecbb_t
    WHERE ecbbent = g_enterprise
      AND ecbb001 = g_ecba_m.ecba001
      AND ecbb002 = g_ecba_m.ecba002
   IF l_n = 0 THEN
      LET g_errno = 'aec-00020'
      RETURN ''                                                     #20150909 by wuxja  add ''
   END IF
   LET l_sql =" SELECT ecbb003,ecbb008,ecbb009,ecbb010,ecbb011,ecbb012 ",   #20150909 by wuxja  add  ecbb003,ecbb010,ecbb011 #160808-00011#1 add ecbb012
              "   FROM ecbb_t ",
              "  WHERE ecbbent = '",g_enterprise,"'",
              "    AND ecbb001 = '",g_ecba_m.ecba001,"'",
              "    AND ecbb002 = '",g_ecba_m.ecba002,"'"
   DECLARE aecm200_chk_valid CURSOR FROM l_sql
   FOREACH aecm200_chk_valid INTO l_ecbb003,l_ecbb008,l_ecbb009,l_ecbb010,l_ecbb011,l_ecbb012   #20150909 by wuxja  add  ecbb003,ecbb010,ecbb011 #160808-00011#1 add ecbb012
     #20150909 by wuxja  add  --begin--
      IF cl_null(l_ecbb008) OR cl_null(l_ecbb009) THEN
         LET g_errno = 'aec-00050'
         RETURN l_ecbb003                    #20150909 by wuxja  add l_ecbb003
      END IF
      IF cl_null(l_ecbb010) OR cl_null(l_ecbb011) THEN
         LET g_errno = 'aec-00051'
         RETURN l_ecbb003                    #20150909 by wuxja  add l_ecbb003
      END IF
     #20150909 by wuxja  add  --end--
     #160808-00011#1---add---s
      IF cl_null(l_ecbb012) THEN
         LET g_errno = 'aec-00059'
         RETURN l_ecbb003                    
      END IF     
     #160808-00011#1---add---e
      IF l_ecbb008 = 'INIT' OR l_ecbb008 = 'MULT' THEN
         CONTINUE FOREACH
      END IF
      LET l_n = 0
      SELECT COUNT(*) INTO l_n
        FROM ecbb_t
        WHERE ecbbent = g_enterprise
          AND ecbb001 = g_ecba_m.ecba001
          AND ecbb002 = g_ecba_m.ecba002
          AND ((ecbb004 = l_ecbb008
               AND ecbb005 = l_ecbb009)
               OR ecbb007 = l_ecbb008)
       IF l_n = 0 THEN
          LET g_errno = 'aec-00021'
          RETURN l_ecbb003                   #20150909 by wuxja  add l_ecbb003
       END IF
       
      #20150909 by wuxja  add  --begin--
      #下站作业检查
       IF l_ecbb010 = 'END' OR l_ecbb010 = 'MULT' THEN
         CONTINUE FOREACH
      END IF
      LET l_n = 0
      SELECT COUNT(*) INTO l_n
        FROM ecbb_t
        WHERE ecbbent = g_enterprise
          AND ecbb001 = g_ecba_m.ecba001
          AND ecbb002 = g_ecba_m.ecba002
          AND ((ecbb004 = l_ecbb010
               AND ecbb005 = l_ecbb011)
               OR ecbb007 = l_ecbb010)
       IF l_n = 0 THEN
          LET g_errno = 'aec-00049'
          RETURN l_ecbb003                   
       END IF
      #20150909 by wuxja  add  --end--
   END FOREACH
   
   RETURN ''                     #20150909 by wuxja  add ''
END FUNCTION

################################################################################
# Descriptions...: 製程流程圖頁簽table值顯示
# Date & Author..: 2014/6/4 By wuxja
# Modify.........:
################################################################################
PRIVATE FUNCTION aecm200_b_fill_text()
DEFINE l_msg1                   STRING
DEFINE l_msg2                   STRING
DEFINE l_msg3                   STRING
DEFINE l_msg4                   STRING
DEFINE l_msg5                   STRING
DEFINE l_msg6                   STRING   #160224-00022#1 因azzi920中aec-00030维护的字段太多，栏位长度不够，现在分成2段
DEFINE l_i                      LIKE type_t.num5
DEFINE l_j                      LIKE type_t.num5

   LET l_msg1 = cl_getmsg("aec-00030",g_lang)
   LET l_msg2 = cl_getmsg("aec-00031",g_lang)
   LET l_msg3 = cl_getmsg("aec-00032",g_lang)
   LET l_msg4 = cl_getmsg("aec-00033",g_lang)
   LET l_msg5 = cl_getmsg("aec-00034",g_lang)
   LET l_msg6 = cl_getmsg("aec-00058",g_lang)
   #錯誤信息維護，不能維護很長，且中英文码长不同，故拆开维护
   LET l_j = 1
   #160224-00022#1---mod---begin
   #FOR l_i = 1 TO 16    
   #   IF l_i = 1 THEN
   #      LET g_ecbb4_d[l_i].l_text = l_msg1.subString(1,l_msg1.getIndexOf('|',1)-1)
   #      LET l_j = l_msg1.getIndexOf('|',1) + 1
   #   ELSE
   #      LET g_ecbb4_d[l_i].l_text = l_msg1.subString(l_j,l_msg1.getIndexOf('|',l_j)-1)
   #      LET l_j = l_msg1.getIndexOf('|',l_j) + 1
   #   END IF
   #END FOR
   FOR l_i = 1 TO 10    
      IF l_i = 1 THEN
         LET g_ecbb4_d[l_i].l_text = l_msg1.subString(1,l_msg1.getIndexOf('|',1)-1)
         LET l_j = l_msg1.getIndexOf('|',1) + 1
      ELSE
         LET g_ecbb4_d[l_i].l_text = l_msg1.subString(l_j,l_msg1.getIndexOf('|',l_j)-1)
         LET l_j = l_msg1.getIndexOf('|',l_j) + 1
      END IF
   END FOR
   FOR l_i = 11 TO 18    
      IF l_i = 11 THEN
         LET g_ecbb4_d[l_i].l_text = l_msg6.subString(1,l_msg6.getIndexOf('|',1)-1)
         LET l_j = l_msg6.getIndexOf('|',1) + 1
      ELSE
         LET g_ecbb4_d[l_i].l_text = l_msg6.subString(l_j,l_msg6.getIndexOf('|',l_j)-1)
         LET l_j = l_msg6.getIndexOf('|',l_j) + 1
      END IF
   END FOR   
   #160224-00022#1---mod---end
   #FOR l_i = 17 TO 18    #160224-00022#1
   FOR l_i = 19 TO 20     #160224-00022#1   
      IF l_i = 19 THEN    #160224-00022#1 l_i = 17->19
         LET g_ecbb4_d[l_i].l_text = l_msg2.subString(1,l_msg2.getIndexOf('|',1)-1)
         LET l_j = l_msg2.getIndexOf('|',1) + 1
      ELSE
         LET g_ecbb4_d[l_i].l_text = l_msg2.subString(l_j,l_msg2.getIndexOf('|',l_j)-1)
         LET l_j = l_msg2.getIndexOf('|',l_j) + 1
      END IF
   END FOR
   
   #LET g_ecbb4_d[19].l_text = l_msg3.subString(1,l_msg3.getIndexOf('|',1)-1)    #160224-00022#1
   LET g_ecbb4_d[21].l_text = l_msg3.subString(1,l_msg3.getIndexOf('|',1)-1)    #160224-00022#1
   #FOR l_i = 20 TO 22   #160224-00022#1
   FOR l_i = 22 TO 24    #160224-00022#1
      IF l_i = 22 THEN   #160224-00022#1 l_i = 20->22
         LET g_ecbb4_d[l_i].l_text = l_msg4.subString(1,l_msg4.getIndexOf('|',1)-1)
         LET l_j = l_msg4.getIndexOf('|',1) + 1
      ELSE
         LET g_ecbb4_d[l_i].l_text = l_msg4.subString(l_j,l_msg4.getIndexOf('|',l_j)-1)
         LET l_j = l_msg4.getIndexOf('|',l_j) + 1
      END IF
   END FOR
   
   #FOR l_i = 23 TO 34  #160224-00022#1
   FOR l_i = 25 TO 36   #160224-00022#1
      IF l_i = 25 THEN  #160224-00022#1 l_i = 23->25
         LET g_ecbb4_d[l_i].l_text = l_msg5.subString(1,l_msg5.getIndexOf('|',1)-1)
         LET l_j = l_msg5.getIndexOf('|',1) + 1
      ELSE
         LET g_ecbb4_d[l_i].l_text = l_msg5.subString(l_j,l_msg5.getIndexOf('|',l_j)-1)
         LET l_j = l_msg5.getIndexOf('|',l_j) + 1
      END IF
   END FOR

END FUNCTION

################################################################################
# Descriptions...: 流程图页签table新增时的预设值
# Date & Author..: 2014/6/4 By wuxja
# Modify.........:
################################################################################
PRIVATE FUNCTION aecm200_value_def()
DEFINE l_ecbb003               LIKE ecbb_t.ecbb003
DEFINE l_sys                   LIKE ecbb_t.ecbb003

   LET g_ecbb4_d[9].l_value = "0"
   LET g_ecbb4_d[10].l_value = "0"
   LET g_ecbb4_d[11].l_value = "0"
   LET g_ecbb4_d[12].l_value = "0"
   LET g_ecbb4_d[13].l_value = "0"
   LET g_ecbb4_d[14].l_value = "N"
   LET g_ecbb4_d[17].l_value = "N"
   LET g_ecbb4_d[18].l_value = "N"
   LET g_ecbb4_d[19].l_value = "Y"
   LET g_ecbb4_d[20].l_value = "N"
   LET g_ecbb4_d[21].l_value = "N"
   LET g_ecbb4_d[22].l_value = "N"
   LET g_ecbb4_d[25].l_value = "1"
   LET g_ecbb4_d[26].l_value = "1"
   LET g_ecbb4_d[29].l_value = "1"
   LET g_ecbb4_d[30].l_value = "1"
   LET g_ecbb4_d[31].l_value = "N"
         
   #项次
   SELECT MAX(ecbb003) INTO l_ecbb003 FROM ecbb_t
    WHERE ecbbent = g_enterprise
      AND ecbbsite = g_site
      AND ecbb001 = g_ecba_m.ecba001
      AND ecbb002 = g_ecba_m.ecba002
   CALL cl_get_para(g_enterprise,g_site,'E-MFG-0001') RETURNING l_sys
   IF cl_null(l_sys) OR l_sys = 0 THEN LET l_sys = 1 END IF 
   IF cl_null(l_ecbb003) THEN
      LET l_ecbb003 = l_sys
   ELSE
      LET l_ecbb003 = l_ecbb003+l_sys
   END IF
   LET g_ecbb4_d[1].l_value =l_ecbb003
   SELECT imae016 INTO g_ecbb4_d[23].l_value FROM imae_t
    WHERE imaeent = g_enterprise
      AND imaesite = g_site
      AND imae001 = g_ecba_m.ecba001
   LET g_ecbb4_d[27].l_value = g_ecbb4_d[23].l_value
   
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_ecbb4_d[23].l_value
   CALL ap_ref_array2(g_ref_fields,"SELECT oocal003 FROM oocal_t WHERE oocalent='"||g_enterprise||"' AND oocal001=? AND oocal002='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_ecbb4_d[24].l_value = '', g_rtn_fields[1] , ''
   
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_ecbb4_d[27].l_value
   CALL ap_ref_array2(g_ref_fields,"SELECT oocal003 FROM oocal_t WHERE oocalent='"||g_enterprise||"' AND oocal001=? AND oocal002='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_ecbb4_d[28].l_value = '', g_rtn_fields[1] , ''

END FUNCTION

################################################################################
# Descriptions...: 制程流程图页签table栏位值显示
# Date & Author..: 2014/6/4 By wuxja
# Modify.........:
################################################################################
PRIVATE FUNCTION aecm200_b_fill_value(p_ecbb004,p_ecbb005)
DEFINE p_ecbb004        LIKE ecbb_t.ecbb004,
       p_ecbb005        LIKE ecbb_t.ecbb005
DEFINE l_success        LIKE type_t.num5
#DEFINE l_ecbb           RECORD LIKE ecbb_t.*  #161124-00048#1  16/12/06 By 08734 mark
#161124-00048#1  16/12/06 By 08734 add(S)
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
#161124-00048#1  16/12/06 By 08734 add(E)
DEFINE l_cnt            INTEGER
   
   SELECT COUNT(*) INTO l_cnt FROM ecbb_t WHERE ecbbent=g_enterprise AND ecbbsite=g_site 
      AND ecbb001 = g_ecba_m.ecba001 AND ecbb002 = g_ecba_m.ecba002
      AND ecbb004 = p_ecbb004
      AND ecbb005 = p_ecbb005
      
   IF l_cnt == 0 THEN 
      CALL g_ecbb4_d.clear()     
   END IF
   
   IF g_ecbb4_d.getLength() == 0 THEN
      CALL aecm200_b_fill_text()
      RETURN
   END IF
   
  # SELECT * INTO l_ecbb.* FROM ecbb_t WHERE ecbbent=g_enterprise AND ecbbsite=g_site   #161124-00048#1  16/12/06 By 08734 mark
   SELECT ecbbent,ecbbsite,ecbb001,ecbb002,ecbb003,ecbb004,ecbb005,ecbb006,ecbb007,ecbb008,ecbb009,ecbb010,ecbb011,ecbb012,ecbb013,ecbb014,ecbb015,ecbb016,ecbb017,ecbb018,ecbb019,ecbb020,ecbb021,ecbb022,ecbb023,ecbb024,ecbb025,ecbb026,ecbb027,ecbb028,ecbb029,ecbb030,ecbb031,ecbb032,ecbb033,ecbb034,ecbb035,ecbb036,ecbb037,ecbb038 INTO l_ecbb.* FROM ecbb_t WHERE ecbbent=g_enterprise AND ecbbsite=g_site  #161124-00048#1  16/12/06 By 08734 add
      AND ecbb001 = g_ecba_m.ecba001 AND ecbb002 = g_ecba_m.ecba002
      AND ecbb004 = p_ecbb004
      AND ecbb005 = p_ecbb005
      
   LET g_ecbb4_d[1].l_value = l_ecbb.ecbb003
   LET g_ecbb4_d[2].l_value = l_ecbb.ecbb004
   
   LET g_ecbb4_d[4].l_value = l_ecbb.ecbb005
   LET g_ecbb4_d[5].l_value = l_ecbb.ecbb012
   
   LET g_ecbb4_d[7].l_value = l_ecbb.ecbb037
   
   #160224-00022---mod---b
   ##modify--151215-00002#4 By shiun--(S)
   #LET g_ecbb4_d[9].l_value = l_ecbb.ecbb038
   #LET g_ecbb4_d[11].l_value = l_ecbb.ecbb024
   #LET g_ecbb4_d[12].l_value = l_ecbb.ecbb025
   #LET g_ecbb4_d[13].l_value = l_ecbb.ecbb026
   #LET g_ecbb4_d[14].l_value = l_ecbb.ecbb027
   #LET g_ecbb4_d[15].l_value = l_ecbb.ecbb034
   #LET g_ecbb4_d[16].l_value = l_ecbb.ecbb013
   #LET g_ecbb4_d[17].l_value = l_ecbb.ecbb014
   #
   #LET g_ecbb4_d[19].l_value = l_ecbb.ecbb015
   #LET g_ecbb4_d[20].l_value = l_ecbb.ecbb016
   #LET g_ecbb4_d[21].l_value = l_ecbb.ecbb017
   #LET g_ecbb4_d[22].l_value = l_ecbb.ecbb018
   #LET g_ecbb4_d[23].l_value = l_ecbb.ecbb019
   #LET g_ecbb4_d[24].l_value = l_ecbb.ecbb020
   #LET g_ecbb4_d[25].l_value = l_ecbb.ecbb030
   #
   #LET g_ecbb4_d[27].l_value = l_ecbb.ecbb031
   #LET g_ecbb4_d[28].l_value = l_ecbb.ecbb032
   #LET g_ecbb4_d[29].l_value = l_ecbb.ecbb021
   #
   #LET g_ecbb4_d[31].l_value = l_ecbb.ecbb022
   #LET g_ecbb4_d[32].l_value = l_ecbb.ecbb023
   #LET g_ecbb4_d[33].l_value = l_ecbb.ecbb033
   #LET g_ecbb4_d[34].l_value = l_ecbb.ecbb028
   #LET g_ecbb4_d[35].l_value = l_ecbb.ecbb029
   ##modify--151215-00002#4 By shiun--(E)
   LET g_ecbb4_d[9].l_value = l_ecbb.ecbb038
   
   LET g_ecbb4_d[11].l_value = l_ecbb.ecbb024
   LET g_ecbb4_d[12].l_value = l_ecbb.ecbb025
   LET g_ecbb4_d[13].l_value = l_ecbb.ecbb026
   LET g_ecbb4_d[14].l_value = l_ecbb.ecbb027
   LET g_ecbb4_d[15].l_value = l_ecbb.ecbb034
   LET g_ecbb4_d[16].l_value = l_ecbb.ecbb013
   LET g_ecbb4_d[17].l_value = l_ecbb.ecbb014
   
   LET g_ecbb4_d[19].l_value = l_ecbb.ecbb015
   LET g_ecbb4_d[20].l_value = l_ecbb.ecbb016
   LET g_ecbb4_d[21].l_value = l_ecbb.ecbb017
   LET g_ecbb4_d[22].l_value = l_ecbb.ecbb018
   LET g_ecbb4_d[23].l_value = l_ecbb.ecbb019
   LET g_ecbb4_d[24].l_value = l_ecbb.ecbb020
   LET g_ecbb4_d[25].l_value = l_ecbb.ecbb030
   
   LET g_ecbb4_d[27].l_value = l_ecbb.ecbb031
   LET g_ecbb4_d[28].l_value = l_ecbb.ecbb032
   LET g_ecbb4_d[29].l_value = l_ecbb.ecbb021
   
   LET g_ecbb4_d[31].l_value = l_ecbb.ecbb022
   LET g_ecbb4_d[32].l_value = l_ecbb.ecbb023
   LET g_ecbb4_d[33].l_value = l_ecbb.ecbb033
   LET g_ecbb4_d[34].l_value = l_ecbb.ecbb028
   LET g_ecbb4_d[35].l_value = l_ecbb.ecbb029
   LET g_ecbb4_d[36].l_value = ''  
   #160224-00022---mod---e  
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = l_ecbb.ecbb004
   CALL ap_ref_array2(g_ref_fields,"SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001 = '221' AND oocql002=? AND oocql003='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_ecbb4_d[3].l_value =  '', g_rtn_fields[1] , ''
   
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = l_ecbb.ecbb012
   CALL ap_ref_array2(g_ref_fields,"SELECT ecaa002 FROM ecaa_t WHERE ecaaent='"||g_enterprise||"' AND ecaasite='"||g_site||"' AND ecaa001=? ","") RETURNING g_rtn_fields
   LET g_ecbb4_d[6].l_value =  '', g_rtn_fields[1] , ''
   
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = l_ecbb.ecbb037
   CALL ap_ref_array2(g_ref_fields,"SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001 = '1103' AND oocql002=? AND oocql003='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_ecbb4_d[8].l_value =  '', g_rtn_fields[1] , ''
   
   #modify--151215-00002#4 By shiun--(S)
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = l_ecbb.ecbb038
   CALL ap_ref_array2(g_ref_fields,"SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001 = '1103' AND oocql002=? AND oocql003='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_ecbb4_d[10].l_value =  '', g_rtn_fields[1] , ''
   #modify--151215-00002#4 By shiun--(E)
   
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = l_ecbb.ecbb014
   CALL ap_ref_array2(g_ref_fields,"SELECT pmaal004 FROM pmaal_t WHERE pmaalent='"||g_enterprise||"' AND pmaal001=? AND pmaal002='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_ecbb4_d[18].l_value =  '', g_rtn_fields[1] , ''
   
   
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = l_ecbb.ecbb030
   CALL ap_ref_array2(g_ref_fields,"SELECT oocal003 FROM oocal_t WHERE oocalent='"||g_enterprise||"' AND oocal001=? AND oocal002='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_ecbb4_d[26].l_value = '', g_rtn_fields[1] , ''
   
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = l_ecbb.ecbb021
   CALL ap_ref_array2(g_ref_fields,"SELECT oocal003 FROM oocal_t WHERE oocalent='"||g_enterprise||"' AND oocal001=? AND oocal002='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_ecbb4_d[30].l_value = '', g_rtn_fields[1] , ''
   
   
   IF NOT cl_null(g_ecbb4_d[1].l_value) AND g_ecbb4_d[1].l_value != 0 THEN
      CALL s_aooi360_sel('7',g_site,g_ecba_m.ecba001,g_ecba_m.ecba002,g_ecbb4_d[1].l_value,'','','','','','','4') RETURNING l_success,g_ecbb4_d[36].l_value
   END IF
END FUNCTION

################################################################################
# Descriptions...: 流程图页签table栏位值chk
# Date & Author..: 2014/6/4 By wuxja
# Modify.........:
################################################################################
PRIVATE FUNCTION aecm200_chk_value(p_ac,p_value,p_value_t)
DEFINE p_ac                  LIKE type_t.num10   #161108-00012#1 num5==》num10
DEFINE p_value               LIKE type_t.chr80
DEFINE p_value_t             LIKE type_t.chr80
DEFINE r_success             LIKE type_t.num5
#DEFINE l_ecbb                RECORD LIKE ecbb_t.*  #161124-00048#1  16/12/06 By 08734 mark
#161124-00048#1  16/12/06 By 08734 add(S)
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
#161124-00048#1  16/12/06 By 08734 add(E)
#DEFINE l_ecbb_t              RECORD LIKE ecbb_t.*  #161124-00048#1  16/12/06 By 08734 mark
#161124-00048#1  16/12/06 By 08734 add(S)
DEFINE l_ecbb_t RECORD  #料件製程單身檔
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
#161124-00048#1  16/12/06 By 08734 add(E)
DEFINE l_ecbb005             LIKE type_t.num5
DEFINE l_n                   LIKE type_t.num5
   
   LET r_success = FALSE
   IF cl_null(p_ac) THEN
      RETURN r_success
   END IF
   
   CASE p_ac
      WHEN 1
          LET l_ecbb.ecbb003 = p_value
          LET l_ecbb_t.ecbb003 = p_value_t
          IF NOT cl_ap_chk_Range(l_ecbb.ecbb003,"0","0","","","azz-00079",1) THEN
             RETURN r_success
          END IF
        
          IF NOT cl_null(l_ecbb.ecbb003) AND (cl_null(l_ecbb_t.ecbb003) OR l_ecbb.ecbb003 != l_ecbb_t.ecbb003) THEN 
             IF NOT ap_chk_notDup(l_ecbb.ecbb003,"SELECT COUNT(*) FROM ecbb_t WHERE "||"ecbbent = '" ||g_enterprise|| "' AND ecbbsite = '" ||g_site|| "' AND "||"ecbb001 = '"||g_ecba_m.ecba001 ||"' AND "|| "ecbb002 = '"||g_ecba_m.ecba002 ||"' AND "|| "ecbb003 = '"||l_ecbb.ecbb003 ||"'",'std-00004',0) THEN
                RETURN r_success
             END IF
          END IF
       
       WHEN 2
          LET l_ecbb.ecbb004 = p_value
          LET l_ecbb_t.ecbb004 = p_value_t
          IF NOT cl_null(l_ecbb.ecbb004) AND (cl_null(l_ecbb_t.ecbb004) OR l_ecbb.ecbb004 != l_ecbb_t.ecbb004) THEN 
             CALL s_azzi650_chk_exist('221',l_ecbb.ecbb004) RETURNING l_success
             IF NOT l_success THEN
                RETURN r_success
             END IF
             IF NOT cl_null(g_ecbb4_d[4].l_value) THEN
                LET l_ecbb.ecbb005 = g_ecbb4_d[4].l_value
                SELECT COUNT(*) INTO l_n FROM ecbb_t
                 WHERE ecbbent = g_enterprise
                   AND ecbbsite = g_site
                   AND ecbb001 = g_ecba_m.ecba001
                   AND ecbb002 = g_ecba_m.ecba002
                   AND ecbb004 = l_ecbb.ecbb004
                   AND ecbb005 = l_ecbb.ecbb005
                IF l_n > 0 THEN
                   INITIALIZE g_errparam TO NULL
                   LET g_errparam.code = 'aec-00006'
                   LET g_errparam.extend = l_ecbb.ecbb004
                   LET g_errparam.popup = TRUE
                   CALL cl_err()

                   RETURN r_success
                END IF
             ELSE
                SELECT MAX(ecbb005) INTO l_ecbb005 FROM ecbb_t
                 WHERE ecbbent = g_enterprise
                   AND ecbbsite = g_site
                   AND ecbb001 = g_ecba_m.ecba001
                   AND ecbb002 = g_ecba_m.ecba002
                   AND ecbb004 = l_ecbb.ecbb004
                LET l_ecbb005 = l_ecbb005 +1
                LET g_ecbb4_d[4].l_value = l_ecbb005 + 1
                IF cl_null(g_ecbb4_d[4].l_value) THEN
                   LET g_ecbb4_d[4].l_value = 1
                END IF
             END IF
          END IF
          INITIALIZE g_ref_fields TO NULL
          LET g_ref_fields[1] = l_ecbb.ecbb004
          CALL ap_ref_array2(g_ref_fields,"SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001 = '221' AND oocql002=? AND oocql003='"||g_dlang||"'","") RETURNING g_rtn_fields
          LET g_ecbb4_d[3].l_value =  '', g_rtn_fields[1] , ''
          
       WHEN 4
          LET l_ecbb.ecbb005 = p_value
          LET l_ecbb_t.ecbb005 = p_value_t
          IF NOT cl_ap_chk_Range(l_ecbb.ecbb005,"0.000","1","","","azz-00079",1) THEN
             RETURN r_success
          END IF
          IF NOT cl_null(l_ecbb.ecbb005) AND (cl_null(l_ecbb_t.ecbb005) OR l_ecbb.ecbb005 != l_ecbb_t.ecbb005) THEN 
             IF NOT cl_null(g_ecbb4_d[2].l_value) THEN
                LET l_ecbb.ecbb004 = g_ecbb4_d[2].l_value
                SELECT COUNT(*) INTO l_n FROM ecbb_t
                 WHERE ecbbent = g_enterprise
                   AND ecbbsite = g_site
                   AND ecbb001 = g_ecba_m.ecba001
                   AND ecbb002 = g_ecba_m.ecba002
                   AND ecbb004 = l_ecbb.ecbb004
                   AND ecbb005 = l_ecbb.ecbb005
                IF l_n > 0 THEN
                   INITIALIZE g_errparam TO NULL
                   LET g_errparam.code = 'aec-00006'
                   LET g_errparam.extend = l_ecbb.ecbb004
                   LET g_errparam.popup = TRUE
                   CALL cl_err()

                   RETURN r_success
                END IF
             END IF
          END IF
          
       WHEN 5
          LET l_ecbb.ecbb012 = p_value
          LET l_ecbb_t.ecbb012 = p_value_t
          IF NOT cl_null(l_ecbb.ecbb012) AND (cl_null(l_ecbb_t.ecbb012) OR l_ecbb.ecbb012 != l_ecbb_t.ecbb012) THEN 
             INITIALIZE g_chkparam.* TO NULL
             LET g_chkparam.arg1 = l_ecbb.ecbb012
             #160318-00025#3--add--str
             LET g_errshow = TRUE 
             LET g_chkparam.err_str[1] = "aec-00010:sub-01302|aeci001|",cl_get_progname("aeci001",g_lang,"2"),"|:EXEPROGaeci001"
             #160318-00025#3--add--end
             IF NOT cl_chk_exist("v_ecaa001_1") THEN
                RETURN r_success
             END IF
          END IF
          INITIALIZE g_ref_fields TO NULL
          LET g_ref_fields[1] = l_ecbb.ecbb012
          CALL ap_ref_array2(g_ref_fields,"SELECT ecaa002 FROM ecaa_t WHERE ecaaent='"||g_enterprise||"' AND ecaasite='"||g_site||"' AND ecaa001=? ","") RETURNING g_rtn_fields
          LET g_ecbb4_d[6].l_value =  '', g_rtn_fields[1] , ''
          
       WHEN 7
          LET l_ecbb.ecbb037 = p_value
          LET l_ecbb_t.ecbb037 = p_value_t
          IF NOT cl_null(l_ecbb.ecbb037) AND (cl_null(l_ecbb_t.ecbb037) OR l_ecbb.ecbb037 != l_ecbb_t.ecbb037) THEN 
             CALL s_azzi650_chk_exist('1103',l_ecbb.ecbb037) RETURNING l_success
             IF NOT l_success THEN
                RETURN r_success
             END IF
          END IF
          INITIALIZE g_ref_fields TO NULL
          LET g_ref_fields[1] = l_ecbb.ecbb037
          CALL ap_ref_array2(g_ref_fields,"SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001 = '1103' AND oocql002=? AND oocql003='"||g_dlang||"'","") RETURNING g_rtn_fields
          LET g_ecbb4_d[8].l_value =  '', g_rtn_fields[1] , ''
       #modify--151215-00002#4 By shiun--(S)
       WHEN 9
         LET l_ecbb.ecbb038 = p_value
          LET l_ecbb_t.ecbb038 = p_value_t
          IF NOT cl_null(l_ecbb.ecbb038) AND (cl_null(l_ecbb_t.ecbb038) OR l_ecbb.ecbb038 != l_ecbb_t.ecbb038) THEN 
             CALL s_azzi650_chk_exist('1103',l_ecbb.ecbb038) RETURNING l_success
             IF NOT l_success THEN
                RETURN r_success
             END IF
          END IF
          INITIALIZE g_ref_fields TO NULL
          LET g_ref_fields[1] = l_ecbb.ecbb038
          CALL ap_ref_array2(g_ref_fields,"SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001 = '1103' AND oocql002=? AND oocql003='"||g_dlang||"'","") RETURNING g_rtn_fields
          LET g_ecbb4_d[10].l_value =  '', g_rtn_fields[1] , ''
       
       WHEN 11
          LET l_ecbb.ecbb024 = p_value
          LET l_ecbb_t.ecbb024 = p_value_t 
          IF NOT cl_ap_chk_Range(l_ecbb.ecbb024,"0.000","1","","","azz-00079",1) THEN
             RETURN r_success
          END IF

       WHEN 12
          LET l_ecbb.ecbb025 = p_value
          LET l_ecbb_t.ecbb025 = p_value_t
          IF NOT cl_ap_chk_Range(l_ecbb.ecbb025,"0.000","1","","","azz-00079",1) THEN
             RETURN r_success
          END IF
          
       WHEN 13
          LET l_ecbb.ecbb026 = p_value
          LET l_ecbb_t.ecbb026 = p_value_t 
          IF NOT cl_ap_chk_Range(l_ecbb.ecbb026,"0.000","1","","","azz-00079",1) THEN
             RETURN r_success
          END IF
          
       WHEN 14
          LET l_ecbb.ecbb027 = p_value
          LET l_ecbb_t.ecbb027 = p_value_t
          IF NOT cl_ap_chk_Range(l_ecbb.ecbb027,"0.000","1","","","azz-00079",1) THEN
             RETURN r_success
          END IF
          
       WHEN 15
          LET l_ecbb.ecbb034 = p_value
          LET l_ecbb_t.ecbb034 = p_value_t 
          IF NOT cl_ap_chk_Range(l_ecbb.ecbb024,"0.000","1","","","azz-00079",1) THEN
             RETURN r_success
          END IF
       
       WHEN 16
          LET l_ecbb.ecbb013 = p_value
          LET l_ecbb_t.ecbb013 = p_value_t
          IF l_ecbb.ecbb013 NOT MATCHES '[YN]' THEN
             INITIALIZE g_errparam TO NULL
             LET g_errparam.code = 'aec-00035'
             LET g_errparam.extend = l_ecbb.ecbb013
             LET g_errparam.popup = TRUE
             CALL cl_err()

             RETURN r_success
          END IF
          
       WHEN 17
          LET l_ecbb.ecbb014 = p_value
          LET l_ecbb_t.ecbb014 = p_value_t
          IF NOT cl_null(l_ecbb.ecbb014) AND (cl_null(l_ecbb_t.ecbb014) OR l_ecbb.ecbb014 != l_ecbb_t.ecbb014) THEN 
             INITIALIZE g_chkparam.* TO NULL
             LET g_chkparam.arg1 = l_ecbb.ecbb014
             IF NOT cl_chk_exist("v_pmaa001_1") THEN
                RETURN r_success
             END IF
          END IF
          INITIALIZE g_ref_fields TO NULL
          LET g_ref_fields[1] = l_ecbb.ecbb014
          CALL ap_ref_array2(g_ref_fields,"SELECT pmaal004 FROM pmaal_t WHERE pmaalent='"||g_enterprise||"' AND pmaal001=? AND pmaal002='"||g_dlang||"'","") RETURNING g_rtn_fields
          LET g_ecbb4_d[18].l_value =  '', g_rtn_fields[1] , ''
          
       WHEN 19
          LET l_ecbb.ecbb015 = p_value
          LET l_ecbb_t.ecbb015 = p_value_t
          IF l_ecbb.ecbb015 NOT MATCHES '[YN]' THEN
             INITIALIZE g_errparam TO NULL
             LET g_errparam.code = 'aec-00035'
             LET g_errparam.extend = l_ecbb.ecbb015
             LET g_errparam.popup = TRUE
             CALL cl_err()

             RETURN r_success
          END IF

       WHEN 20
          LET l_ecbb.ecbb016 = p_value
          LET l_ecbb_t.ecbb016 = p_value_t
          IF l_ecbb.ecbb016 NOT MATCHES '[YN]' THEN
             INITIALIZE g_errparam TO NULL
             LET g_errparam.code = 'aec-00035'
             LET g_errparam.extend = l_ecbb.ecbb016
             LET g_errparam.popup = TRUE
             CALL cl_err()

             RETURN r_success
          END IF
          
       WHEN 21
          LET l_ecbb.ecbb017 = p_value
          LET l_ecbb_t.ecbb017 = p_value_t
          IF l_ecbb.ecbb017 NOT MATCHES '[YN]' THEN
             INITIALIZE g_errparam TO NULL
             LET g_errparam.code = 'aec-00035'
             LET g_errparam.extend = l_ecbb.ecbb017
             LET g_errparam.popup = TRUE
             CALL cl_err()

             RETURN r_success
          END IF
          
       WHEN 22
          LET l_ecbb.ecbb018 = p_value
          LET l_ecbb_t.ecbb018 = p_value_t
          IF l_ecbb.ecbb018 NOT MATCHES '[YN]' THEN
             INITIALIZE g_errparam TO NULL
             LET g_errparam.code = 'aec-00035'
             LET g_errparam.extend = l_ecbb.ecbb018
             LET g_errparam.popup = TRUE
             CALL cl_err()

             RETURN r_success
          END IF
          
       WHEN 23
          LET l_ecbb.ecbb019 = p_value
          LET l_ecbb_t.ecbb019 = p_value_t
          IF l_ecbb.ecbb019 NOT MATCHES '[YN]' THEN
             INITIALIZE g_errparam TO NULL
             LET g_errparam.code = 'aec-00035'
             LET g_errparam.extend = l_ecbb.ecbb019
             LET g_errparam.popup = TRUE
             CALL cl_err()

             RETURN r_success
          END IF
          
       WHEN 24
          LET l_ecbb.ecbb020 = p_value
          LET l_ecbb_t.ecbb020 = p_value_t
          IF l_ecbb.ecbb020 NOT MATCHES '[YN]' THEN
             INITIALIZE g_errparam TO NULL
             LET g_errparam.code = 'aec-00035'
             LET g_errparam.extend = l_ecbb.ecbb020
             LET g_errparam.popup = TRUE
             CALL cl_err()

             RETURN r_success
          END IF
          
       WHEN 25
          LET l_ecbb.ecbb030 = p_value
          LET l_ecbb_t.ecbb030 = p_value_t
          IF NOT cl_null(l_ecbb.ecbb030) AND (cl_null(l_ecbb_t.ecbb030) OR l_ecbb.ecbb030 != l_ecbb_t.ecbb030) THEN 
             INITIALIZE g_chkparam.* TO NULL
             LET g_chkparam.arg1 = l_ecbb.ecbb030
             #160318-00025#3--add--str
             LET g_errshow = TRUE 
             LET g_chkparam.err_str[1] = "aim-00005:sub-01302|aooi250|",cl_get_progname("aooi250",g_lang,"2"),"|:EXEPROGaooi250"
             #160318-00025#3--add--end
             IF NOT cl_chk_exist("v_ooca001") THEN
                RETURN r_success
             END IF
          END IF
          INITIALIZE g_ref_fields TO NULL
          LET g_ref_fields[1] = l_ecbb.ecbb030
          CALL ap_ref_array2(g_ref_fields,"SELECT oocal003 FROM oocal_t WHERE oocalent='"||g_enterprise||"' AND oocal001=? AND oocal002='"||g_dlang||"'","") RETURNING g_rtn_fields
          LET g_ecbb4_d[24].l_value = '', g_rtn_fields[1] , ''
       
       WHEN 26
          LET l_ecbb.ecbb031 = p_value
          LET l_ecbb_t.ecbb031 = p_value_t 
          IF NOT cl_ap_chk_Range(l_ecbb.ecbb031,"0.000","0","","","azz-00079",1) THEN
             RETURN r_success
          END IF       
          
       WHEN 27
          LET l_ecbb.ecbb032 = p_value
          LET l_ecbb_t.ecbb032 = p_value_t 
          IF NOT cl_ap_chk_Range(l_ecbb.ecbb032,"0.000","0","","","azz-00079",1) THEN
             RETURN r_success
          END IF
          
       WHEN 28
          LET l_ecbb.ecbb021 = p_value
          LET l_ecbb_t.ecbb021 = p_value_t
          IF NOT cl_null(l_ecbb.ecbb021) AND (cl_null(l_ecbb_t.ecbb021) OR l_ecbb.ecbb021 != l_ecbb_t.ecbb021) THEN 
             INITIALIZE g_chkparam.* TO NULL
             LET g_chkparam.arg1 = l_ecbb.ecbb021
             #160318-00025#3--add--str
             LET g_errshow = TRUE 
             LET g_chkparam.err_str[1] = "aim-00005:sub-01302|aooi250|",cl_get_progname("aooi250",g_lang,"2"),"|:EXEPROGaooi250"
             #160318-00025#3--add--end
             IF NOT cl_chk_exist("v_ooca001") THEN
                RETURN r_success
             END IF
          END IF
          INITIALIZE g_ref_fields TO NULL
          LET g_ref_fields[1] = l_ecbb.ecbb021
          CALL ap_ref_array2(g_ref_fields,"SELECT oocal003 FROM oocal_t WHERE oocalent='"||g_enterprise||"' AND oocal001=? AND oocal002='"||g_dlang||"'","") RETURNING g_rtn_fields
          LET g_ecbb4_d[30].l_value = '', g_rtn_fields[1] , ''
       
       WHEN 31
          LET l_ecbb.ecbb022 = p_value
          LET l_ecbb_t.ecbb022 = p_value_t 
          IF NOT cl_ap_chk_Range(l_ecbb.ecbb022,"0.000","0","","","azz-00079",1) THEN
             RETURN r_success
          END IF       
          
       WHEN 32
          LET l_ecbb.ecbb023 = p_value
          LET l_ecbb_t.ecbb023 = p_value_t 
          IF NOT cl_ap_chk_Range(l_ecbb.ecbb023,"0.000","0","","","azz-00079",1) THEN
             RETURN r_success
          END IF
       
       WHEN 33
          LET l_ecbb.ecbb033 = p_value
          LET l_ecbb_t.ecbb033 = p_value_t
          IF l_ecbb.ecbb033 NOT MATCHES '[YN]' THEN
             INITIALIZE g_errparam TO NULL
             LET g_errparam.code = 'aec-00035'
             LET g_errparam.extend = l_ecbb.ecbb033
             LET g_errparam.popup = TRUE
             CALL cl_err()

             RETURN r_success
          END IF
          IF l_ecbb.ecbb033 = 'Y' THEN
             LET l_ecbb.ecbb003 = g_ecbb4_d[1].l_value
             SELECT count(*) INTO l_n FROM ecbb_t
              WHERE ecbbent = g_enterprise
                AND ecbbsite = g_site
                AND ecbb001 = g_ecba_m.ecba001
                AND ecbb002 = g_ecba_m.ecba002
                AND ecbb003 <> l_ecbb.ecbb003
                AND ecbb033 = 'Y'
             IF l_n > 0 THEN
                IF NOT cl_ask_confirm('asf-00134') THEN
                   LET g_ecbb4_d[33].l_value = 'N'
                ELSE
                   UPDATE ecbb_t SET ecbb033 = 'N' 
                    WHERE ecbbent = g_enterprise
                      AND ecbbsite = g_site
                      AND ecbb001 = g_ecba_m.ecba001
                      AND ecbb002 = g_ecba_m.ecba002
                      AND ecbb003 <> l_ecbb.ecbb003
                      AND ecbb033 = 'Y'
                END IF
             END IF
          END IF
       
       WHEN 34
          LET l_ecbb.ecbb028 = p_value
          LET l_ecbb_t.ecbb028 = p_value_t 
          IF NOT cl_ap_chk_Range(l_ecbb.ecbb028,"0.000","1","","","azz-00079",1) THEN
             RETURN r_success
          END IF
          
       WHEN 35
          LET l_ecbb.ecbb029 = p_value
          LET l_ecbb_t.ecbb029 = p_value_t 
          IF NOT cl_ap_chk_Range(l_ecbb.ecbb029,"0.000","0","","","azz-00079",1) THEN
             RETURN r_success
          END IF
          
    END CASE
    #modify--151215-00002#4 By shiun--(E)
    LET r_success = TRUE
    RETURN r_success
END FUNCTION

################################################################################
# Descriptions...: 流程图页签table栏位开窗
# Date & Author..: 2014/6/4 By wuxja
# Modify.........:
################################################################################
PRIVATE FUNCTION aecm200_value_controlp(p_ac,p_value)
DEFINE p_ac                  LIKE type_t.num10  #161108-00012#1 num5==》num10
DEFINE p_value               LIKE type_t.chr80
DEFINE l_ecbb003             LIKE ecbb_t.ecbb003
DEFINE l_success             LIKE type_t.num5
 
   CASE p_ac
      WHEN 2
         INITIALIZE g_qryparam.* TO NULL
         LET g_qryparam.state = 'i'     #160201-00008#1-add
         LET g_qryparam.reqry = FALSE
         LET g_qryparam.default1 = g_ecbb4_d[2].l_value  
         LET g_qryparam.arg1 = "221" #
         CALL q_oocq002()                                
         LET g_ecbb4_d[2].l_value = g_qryparam.return1   
         DISPLAY g_ecbb4_d[2].l_value TO l_value         
         
      WHEN 5
         INITIALIZE g_qryparam.* TO NULL
         LET g_qryparam.state = 'i'     #160201-00008#1-add
         LET g_qryparam.reqry = FALSE
         LET g_qryparam.default1 = g_ecbb4_d[5].l_value  
         CALL q_ecaa001_1()                              
         LET g_ecbb4_d[5].l_value = g_qryparam.return1   
         DISPLAY g_ecbb4_d[5].l_value TO l_value  

      WHEN 7
         INITIALIZE g_qryparam.* TO NULL
         LET g_qryparam.state = 'i'     #160201-00008#1-add
         LET g_qryparam.reqry = FALSE
         LET g_qryparam.default1 = g_ecbb4_d[7].l_value  
         LET g_qryparam.arg1 = "1103" #
         LET g_qryparam.where = " oocq019 = '1' "   #add--151215-00002#4 By shiun
         CALL q_oocq002()                               
         LET g_ecbb4_d[7].l_value = g_qryparam.return1   
         DISPLAY g_ecbb4_d[7].l_value TO l_value 
         
      WHEN 15
         INITIALIZE g_qryparam.* TO NULL
         LET g_qryparam.state = 'i'     #160201-00008#1-add
         LET g_qryparam.reqry = FALSE
         LET g_qryparam.default1 = g_ecbb4_d[15].l_value 
         LET g_qryparam.arg1 = " ('1','3')"
         CALL q_pmaa001_1()                              
         LET g_ecbb4_d[15].l_value = g_qryparam.return1  
         DISPLAY g_ecbb4_d[15].l_value TO l_value 

      WHEN 23
         INITIALIZE g_qryparam.* TO NULL
         LET g_qryparam.state = 'i'     #160201-00008#1-add
         LET g_qryparam.reqry = FALSE
         LET g_qryparam.default1 = g_ecbb4_d[23].l_value 
         CALL q_ooca001()                              
         LET g_ecbb4_d[23].l_value = g_qryparam.return1  
         DISPLAY g_ecbb4_d[23].l_value TO l_value
      WHEN 27
         INITIALIZE g_qryparam.* TO NULL
         LET g_qryparam.state = 'i'     #160201-00008#1-add
         LET g_qryparam.reqry = FALSE
         LET g_qryparam.default1 = g_ecbb4_d[27].l_value 
         CALL q_ooca001()                               
         LET g_ecbb4_d[27].l_value = g_qryparam.return1  
         DISPLAY g_ecbb4_d[27].l_value TO l_value
       
      WHEN 34
         IF NOT cl_null(g_ecbb4_d[1].l_value) THEN
            LET l_ecbb003 = g_ecbb4_d[1].l_value
            CALL aooi360_02('7',g_site,g_ecba_m.ecba001,g_ecba_m.ecba002,l_ecbb003,'','','','','','','4')
            CALL s_aooi360_sel('7',g_site,g_ecba_m.ecba001,g_ecba_m.ecba002,l_ecbb003,'','','','','','','4') RETURNING l_success,g_ecbb4_d[34].l_value
            DISPLAY g_ecbb4_d[34].l_value TO l_value
         END IF
   END CASE
END FUNCTION

################################################################################
# Descriptions...: 根据流程页签table中维护的值，异动ecbb_t
# Date & Author..: 2014/6/4 By wuxja
# Modify.........:
################################################################################
PRIVATE FUNCTION aecm200_value_ins_upd(p_value,p_value_t)
DEFINE p_value           LIKE ecbb_t.ecbb003
DEFINE p_value_t         LIKE ecbb_t.ecbb003
DEFINE r_success         LIKE type_t.num5
DEFINE l_n               LIKE type_t.num5
#DEFINE l_ecbb            RECORD LIKE ecbb_t.*  #161124-00048#1  16/12/06 By 08734 mark
#161124-00048#1  16/12/06 By 08734 add(S)
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
#161124-00048#1  16/12/06 By 08734 add(E)

   LET r_success = FALSE
   SELECT COUNT(*) INTO l_n FROM ecbb_t 
    WHERE ecbbent = g_enterprise
      AND ecbbsite = g_site
      AND ecbb001 = g_ecba_m.ecba001
      AND ecbb002 = g_ecba_m.ecba002
      AND ecbb003 = p_value
   
   #ecbb赋值
  # SELECT * INTO l_ecbb.* FROM ecbb_t  #161124-00048#1  16/12/06 By 08734 mark
   SELECT ecbbent,ecbbsite,ecbb001,ecbb002,ecbb003,ecbb004,ecbb005,ecbb006,ecbb007,ecbb008,ecbb009,ecbb010,ecbb011,ecbb012,ecbb013,ecbb014,ecbb015,ecbb016,ecbb017,ecbb018,ecbb019,ecbb020,ecbb021,ecbb022,ecbb023,ecbb024,ecbb025,ecbb026,ecbb027,ecbb028,ecbb029,ecbb030,ecbb031,ecbb032,ecbb033,ecbb034,ecbb035,ecbb036,ecbb037,ecbb038 INTO l_ecbb.* FROM ecbb_t #161124-00048#1  16/12/06 By 08734 add
    WHERE ecbbent = g_enterprise
      AND ecbbsite = g_site
      AND ecbb001 = g_ecba_m.ecba001
      AND ecbb002 = g_ecba_m.ecba002
      AND ecbb003 = p_value_t

   LET l_ecbb.ecbbent = g_enterprise
   LET l_ecbb.ecbbsite = g_site
   LET l_ecbb.ecbb001 = g_ecba_m.ecba001
   LET l_ecbb.ecbb002 = g_ecba_m.ecba002
   LET l_ecbb.ecbb003 = g_ecbb4_d[1].l_value
   LET l_ecbb.ecbb004 = g_ecbb4_d[2].l_value
   LET l_ecbb.ecbb005 = g_ecbb4_d[4].l_value
   LET l_ecbb.ecbb012 = g_ecbb4_d[5].l_value
   LET l_ecbb.ecbb037 = g_ecbb4_d[7].l_value
   #modify--151215-00002#4 By shiun--(S)
   LET l_ecbb.ecbb038 = g_ecbb4_d[9].l_value
   LET l_ecbb.ecbb013 = g_ecbb4_d[16].l_value
   LET l_ecbb.ecbb014 = g_ecbb4_d[17].l_value
   LET l_ecbb.ecbb015 = g_ecbb4_d[19].l_value
   LET l_ecbb.ecbb016 = g_ecbb4_d[20].l_value
   LET l_ecbb.ecbb017 = g_ecbb4_d[21].l_value
   LET l_ecbb.ecbb018 = g_ecbb4_d[22].l_value
   LET l_ecbb.ecbb019 = g_ecbb4_d[23].l_value
   LET l_ecbb.ecbb020 = g_ecbb4_d[24].l_value
   LET l_ecbb.ecbb021 = g_ecbb4_d[29].l_value
   LET l_ecbb.ecbb022 = g_ecbb4_d[31].l_value
   LET l_ecbb.ecbb023 = g_ecbb4_d[32].l_value
   LET l_ecbb.ecbb024 = g_ecbb4_d[11].l_value
   LET l_ecbb.ecbb025 = g_ecbb4_d[12].l_value
   LET l_ecbb.ecbb026 = g_ecbb4_d[13].l_value
   LET l_ecbb.ecbb027 = g_ecbb4_d[14].l_value
   LET l_ecbb.ecbb028 = g_ecbb4_d[34].l_value
   LET l_ecbb.ecbb029 = g_ecbb4_d[35].l_value
   LET l_ecbb.ecbb030 = g_ecbb4_d[25].l_value
   LET l_ecbb.ecbb031 = g_ecbb4_d[27].l_value
   LET l_ecbb.ecbb032 = g_ecbb4_d[28].l_value
   LET l_ecbb.ecbb033 = g_ecbb4_d[33].l_value
   LET l_ecbb.ecbb034 = g_ecbb4_d[14].l_value
   #modify--151215-00002#4 By shiun--(E)
   IF l_n = 0 THEN
     # INSERT INTO ecbb_t VALUES(l_ecbb.*)  #161124-00048#1  16/12/06 By 08734 mark
      INSERT INTO ecbb_t(ecbbent,ecbbsite,ecbb001,ecbb002,ecbb003,ecbb004,ecbb005,ecbb006,ecbb007,ecbb008,ecbb009,ecbb010,ecbb011,ecbb012,ecbb013,ecbb014,ecbb015,ecbb016,ecbb017,ecbb018,ecbb019,ecbb020,ecbb021,ecbb022,ecbb023,ecbb024,ecbb025,ecbb026,ecbb027,ecbb028,ecbb029,ecbb030,ecbb031,ecbb032,ecbb033,ecbb034,ecbb035,ecbb036,ecbb037,ecbb038)  #161124-00048#1  16/12/06 By 08734 add
         VALUES(l_ecbb.ecbbent,l_ecbb.ecbbsite,l_ecbb.ecbb001,l_ecbb.ecbb002,l_ecbb.ecbb003,l_ecbb.ecbb004,l_ecbb.ecbb005,l_ecbb.ecbb006,l_ecbb.ecbb007,l_ecbb.ecbb008,l_ecbb.ecbb009,l_ecbb.ecbb010,l_ecbb.ecbb011,l_ecbb.ecbb012,l_ecbb.ecbb013,l_ecbb.ecbb014,l_ecbb.ecbb015,l_ecbb.ecbb016,l_ecbb.ecbb017,l_ecbb.ecbb018,l_ecbb.ecbb019,l_ecbb.ecbb020,l_ecbb.ecbb021,l_ecbb.ecbb022,l_ecbb.ecbb023,l_ecbb.ecbb024,l_ecbb.ecbb025,l_ecbb.ecbb026,l_ecbb.ecbb027,l_ecbb.ecbb028,l_ecbb.ecbb029,l_ecbb.ecbb030,l_ecbb.ecbb031,l_ecbb.ecbb032,l_ecbb.ecbb033,l_ecbb.ecbb034,l_ecbb.ecbb035,l_ecbb.ecbb036,l_ecbb.ecbb037,l_ecbb.ecbb038)
   ELSE
     # UPDATE ecbb_t SET ecbb_t.* = l_ecbb.*  #161124-00048#1  16/12/06 By 08734 mark
       UPDATE ecbb_t SET ecbb_t.ecbbent = l_ecbb.ecbbent,ecbb_t.ecbbsite=l_ecbb.ecbbsite,ecbb_t.ecbb001=l_ecbb.ecbb001,ecbb_t.ecbb002=l_ecbb.ecbb002,ecbb_t.ecbb003=l_ecbb.ecbb003,ecbb_t.ecbb004=l_ecbb.ecbb004,ecbb_t.ecbb005=l_ecbb.ecbb005,ecbb_t.ecbb006=l_ecbb.ecbb006,ecbb_t.ecbb007=l_ecbb.ecbb007,ecbb_t.ecbb008=l_ecbb.ecbb008,ecbb_t.ecbb009=l_ecbb.ecbb009,ecbb_t.ecbb010=l_ecbb.ecbb010,ecbb_t.ecbb011=l_ecbb.ecbb011,ecbb_t.ecbb012=l_ecbb.ecbb012,ecbb_t.ecbb013=l_ecbb.ecbb013,ecbb_t.ecbb014=l_ecbb.ecbb014,ecbb_t.ecbb015=l_ecbb.ecbb015,ecbb_t.ecbb016=l_ecbb.ecbb016,ecbb_t.ecbb017=l_ecbb.ecbb017,ecbb_t.ecbb018=l_ecbb.ecbb018,
              ecbb_t.ecbb019=l_ecbb.ecbb019,ecbb_t.ecbb020=l_ecbb.ecbb020,ecbb_t.ecbb021=l_ecbb.ecbb021,ecbb_t.ecbb022=l_ecbb.ecbb022,ecbb_t.ecbb023=l_ecbb.ecbb023,ecbb_t.ecbb024=l_ecbb.ecbb024,ecbb_t.ecbb025=l_ecbb.ecbb025,ecbb_t.ecbb026=l_ecbb.ecbb026,ecbb_t.ecbb027=l_ecbb.ecbb027,ecbb_t.ecbb028=l_ecbb.ecbb028,ecbb_t.ecbb029=l_ecbb.ecbb029,ecbb_t.ecbb030=l_ecbb.ecbb030,ecbb_t.ecbb031=l_ecbb.ecbb031,ecbb_t.ecbb032=l_ecbb.ecbb032,ecbb_t.ecbb033=l_ecbb.ecbb033,ecbb_t.ecbb034=l_ecbb.ecbb034,ecbb_t.ecbb035=l_ecbb.ecbb035,ecbb_t.ecbb036=l_ecbb.ecbb036,ecbb_t.ecbb037=l_ecbb.ecbb037,ecbb_t.ecbb038=l_ecbb.ecbb038 #161124-00048#1  16/12/06 By 08734 add                 
       WHERE ecbbent = g_enterprise
         AND ecbbsite = g_site
         AND ecbb001 = g_ecba_m.ecba001
         AND ecbb002 = g_ecba_m.ecba002
         AND ecbb003 = p_value      
   END IF
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = "ecbb_t"
      LET g_errparam.popup = TRUE
      CALL cl_err()
 
      RETURN r_success
   END IF
   IF p_value != p_value_t THEN
      DELETE FROM ecbb_t
       WHERE ecbbent = g_enterprise
         AND ecbbsite = g_site
         AND ecbb001 = g_ecba_m.ecba001
         AND ecbb002 = g_ecba_m.ecba002
         AND ecbb003 = p_value_t
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "DEL ecbb_t"
         LET g_errparam.popup = TRUE
         CALL cl_err()
 
         RETURN r_success
      END IF
   END IF
   IF NOT cl_null(g_ecbb4_d[34].l_value) THEN
      CALL s_aooi360_gen('7',g_site,g_ecba_m.ecba001,g_ecba_m.ecba002,g_ecbb_d[l_ac].ecbb003,' ',' ',' ',' ',' ',' ','4',g_ecbb4_d[34].l_value)
         RETURNING l_success
   ELSE
      CALL s_aooi360_del('7',g_site,g_ecba_m.ecba001,g_ecba_m.ecba002,g_ecbb_d[l_ac].ecbb003,' ',' ',' ',' ',' ',' ','4')
         RETURNING l_success
   END IF
   IF NOT l_success THEN
      RETURN r_success
   END IF
   
   LET r_success = TRUE
   RETURN r_success
END FUNCTION

PRIVATE FUNCTION aecm200_arr_curr(p_ecbb004,p_ecbb005)
   DEFINE p_ecbb004     LIKE ecbb_t.ecbb004,
          p_ecbb005     INTEGER
   DEFINE l_i           INTEGER
   DEFINE l_ac          INTEGER
   DEFINE l_ecbb005     INTEGER
   FOR l_i = 1 TO g_ecbb_d.getLength()
      LET l_ecbb005 = g_ecbb_d[l_i].ecbb005
      IF g_ecbb_d[l_i].ecbb004 == p_ecbb004 AND l_ecbb005 == p_ecbb005 THEN
         LET l_ac = l_i
         EXIT FOR
      END IF
   END FOR
   RETURN l_ac
   
END FUNCTION

################################################################################
# Descriptions...: 刪除ecbb_t, ecbe_t, ecbf_t,ecbg_t
# Memo...........:
# Usage..........: CALL aecm200_delete_ecbb(p_ecba001, p_ecba002, p_ecbb003)
#                  RETURNING none
# Input parameter: p_ecba001    料件編號
#                : p_ecba002    製程編號
#                : p_ecbb003    製程項次
# Return code....: none
# Date & Author..: 劉偉先
# Modify.........:
################################################################################
PRIVATE FUNCTION aecm200_delete_ecbb(p_ecba001,p_ecba002,p_ecbb003)
   DEFINE p_ecba001     LIKE ecba_t.ecba001,
          p_ecba002     LIKE ecba_t.ecba002,
          p_ecbb003     LIKE ecbb_t.ecbb003
END FUNCTION
#
# input parameters: p_enable  是否可以進行編輯
#
PRIVATE FUNCTION aecm200_wc_init(p_enable)
   DEFINE p_enable   BOOLEAN
   DEFINE l_wc_cfg   RECORD
            editable    BOOLEAN,            #編輯模式
            renderDefaultModules BOOLEAN,   #載入預設的工具箱
            lans              RECORD        #多語言訊息
                  C_TOOLS           STRING, 
                  C_DELETE          STRING,
                  C_MODIFY          STRING,
                  C_GROUP_INTO      STRING,
                  C_UNGROUP         STRING,
                  C_DELETE_NODE     STRING,
                  C_DELETE_CONNECTION STRING,
                  C_GROUP           STRING,
                  C_UNSEQ_GROUP     STRING
                              END RECORD
                     END RECORD
   LET g_wc_init = FALSE
   LET l_wc_cfg.editable = TRUE
   LET l_wc_cfg.renderDefaultModules = FALSE
   LET l_wc_cfg.lans.C_TOOLS = cl_getmsg("azz-00269", g_dlang)
   LET l_wc_cfg.lans.C_DELETE = cl_getmsg("azz-00270", g_dlang)
   LET l_wc_cfg.lans.C_MODIFY = cl_getmsg("azz-00271", g_dlang)
   LET l_wc_cfg.lans.C_GROUP_INTO = cl_getmsg("azz-00272", g_dlang)
   LET l_wc_cfg.lans.C_UNGROUP = cl_getmsg("azz-00273", g_dlang)
   LET l_wc_cfg.lans.C_DELETE_NODE = cl_getmsg("azz-00275", g_dlang)
   LET l_wc_cfg.lans.C_DELETE_CONNECTION = cl_getmsg("azz-00276", g_dlang)
   LET l_wc_cfg.lans.C_GROUP = cl_getmsg("azz-00296", g_dlang)," ",cl_getmsg("azz-00294", g_dlang)
   LET l_wc_cfg.lans.C_UNSEQ_GROUP = cl_getmsg("azz-00296", g_dlang)," ",cl_getmsg("azz-00295", g_dlang)
   
   CALL aecm200_wc_submit("wc", "station_init", util.JSON.stringify(l_wc_cfg))
   CALL aecm200_wc_submit("wc", "station_modules", aecm200_wc_gen_modules())       
   CALL aecm200_wc_gen_flow_json(p_enable)
   LET g_wc_init = TRUE
END FUNCTION

PRIVATE FUNCTION aecm200_wc_add_node(p_json_obj)
   DEFINE p_json_obj util.JSONObject
   #DEFINE l_ecbb     RECORD LIKE ecbb_t.*  #161124-00048#1  16/12/06 By 08734 mark
   #161124-00048#1  16/12/06 By 08734 add(S)
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
#161124-00048#1  16/12/06 By 08734 add(E)
   DEFINE l_sys      LIKE type_t.num5
   #步驟：
   #  1.WebComponent會先行建立id
   #  2.初始化新資料後，利用ecbb004, ecbb005組成新id並更新WebComponent
   INITIALIZE l_ecbb.* TO NULL
   LET l_ecbb.ecbbent = g_enterprise
   LET l_ecbb.ecbbsite = g_site
   LET l_ecbb.ecbb001 = g_ecba_m.ecba001
   LET l_ecbb.ecbb002 = g_ecba_m.ecba002

   #LET l_ecbb.ecbb003 = wc.subString(1,wc_i - 1)
   #LET l_ecbb.ecbb004 = g_qryparam.return1
   #LET l_ecbb.ecbb005 = wc.subString(wc_i + 1,wc.getLength()) 
   LET l_ecbb.ecbb006 = '1'    #20151111  add by wuxja 先预设“一般”   
   LET l_ecbb.ecbb012 = null           
   LET l_ecbb.ecbb013 = "N"
   LET l_ecbb.ecbb015 = "N" 
   LET l_ecbb.ecbb016 = "N" 
   LET l_ecbb.ecbb017 = "Y" 
   LET l_ecbb.ecbb018 = "N"                             
   LET l_ecbb.ecbb019 = "N" 
   LET l_ecbb.ecbb020 = "N" 
   LET l_ecbb.ecbb022 = "1"
   LET l_ecbb.ecbb023 = "1"
   LET l_ecbb.ecbb024 = "0"
   LET l_ecbb.ecbb025 = "0"
   LET l_ecbb.ecbb026 = "0"
   LET l_ecbb.ecbb027 = "0"
   LET l_ecbb.ecbb031 = "1"
   LET l_ecbb.ecbb032 = "1"
   LET l_ecbb.ecbb033 = "N"
   LET l_ecbb.ecbb034 = "0"
   LET l_ecbb.ecbb035 = p_json_obj.get("left")
   LET l_ecbb.ecbb036 = p_json_obj.get("top")
   
   #建立新工作站的[本站作業]及自動建立[作業序]
   INITIALIZE g_qryparam.* TO NULL
   LET g_qryparam.reqry = FALSE
   LET g_qryparam.arg1 = "221"
   LET g_qryparam.state = 'i'
   #ecbb004
   CALL q_oocq002()
   
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_qryparam.return1
   CALL ap_ref_array2(g_ref_fields,"SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001 = '221' AND oocql002=? AND oocql003='"||g_dlang||"'","") RETURNING g_rtn_fields

   
   LET l_ecbb.ecbb004 = g_qryparam.return1
   SELECT COUNT(*) + 1 INTO l_ecbb.ecbb005 FROM ecbb_t
    WHERE ecbbent  = g_enterprise
      AND ecbbsite = g_site
      AND ecbb001  = g_ecba_m.ecba001
      AND ecbb002  = g_ecba_m.ecba002
      AND ecbb004  = l_ecbb.ecbb004
    
   #建立新的[項次]
   SELECT MAX(ecbb003) INTO l_ecbb.ecbb003 FROM ecbb_t
    WHERE ecbbent = g_enterprise
      AND ecbbsite = g_site
      AND ecbb001 = g_ecba_m.ecba001
      AND ecbb002 = g_ecba_m.ecba002
   CALL cl_get_para(g_enterprise,g_site,'E-MFG-0001') RETURNING l_sys
   IF cl_null(l_sys) OR l_sys = 0 THEN LET l_sys = 1 END IF 
   #單身第一筆，預設上站為INIT
   IF cl_null(l_ecbb.ecbb003) THEN
      LET l_ecbb.ecbb003 = l_sys
      LET l_ecbb.ecbb008 = 'INIT'
      LET l_ecbb.ecbb009 ='0'
   ELSE           
      SELECT ecbb004,ecbb005 INTO l_ecbb.ecbb008,l_ecbb.ecbb009 FROM ecbb_t
       WHERE ecbbent = g_enterprise
         AND ecbbsite = g_site
         AND ecbb001 = g_ecba_m.ecba001
         AND ecbb002 = g_ecba_m.ecba002
         AND ecbb003 = l_ecbb.ecbb003
      LET l_ecbb.ecbb003 = l_ecbb.ecbb003 + l_sys
   END IF
   
   SELECT imae016 INTO l_ecbb.ecbb021
     FROM imae_t
    WHERE imaeent = g_enterprise
      AND imaesite = g_site
      AND imae001 = g_ecba_m.ecba001
   
   IF cl_null(l_ecbb.ecbb021) THEN
      SELECT imaa006 INTO l_ecbb.ecbb021 FROM imaa_t
       WHERE imaaent = g_enterprise AND imaa001 = g_ecba_m.ecba001
   END IF
   LET l_ecbb.ecbb030 = l_ecbb.ecbb021
   
   RETURN l_ecbb.*
            
END FUNCTION

PRIVATE FUNCTION aecm200_wc_gen_flow_json(p_enable)
   DEFINE p_enable      BOOLEAN #是否可編輯
   DEFINE wc_data RECORD
            enable      BOOLEAN,
            groups      DYNAMIC ARRAY OF t_group,
            containers  DYNAMIC ARRAY OF t_container,
            connections DYNAMIC ARRAY OF t_connection
                  END RECORD
   DEFINE l_init    t_container
   DEFINE l_end     t_container
   DEFINE l_conn    t_connection
   DEFINE idx        INTEGER
   DEFINE idx1       INTEGER
   DEFINE idx2       INTEGER
   DEFINE l_find_grp BOOLEAN
   DEFINE l_in_grp   BOOLEAN
   DEFINE l_len      INTEGER
   DEFINE l_gzcbl004 LIKE gzcbl_t.gzcbl004
   DEFINE l_ecba004  LIKE ecba_t.ecba004,
          l_ecba005  LIKE ecba_t.ecba005,
          l_ecba006  LIKE ecba_t.ecba006,
          l_ecba007  LIKE ecba_t.ecba007
   DEFINE l_ecbb005  INTEGER, #作業序
          l_ecbb009  INTEGER, #作業序
          l_ecbb011  INTEGER  #作業序
   DEFINE l_ecbe_t   RECORD 
            ecbeent     LIKE ecbe_t.ecbeent,
            ecbesite    LIKE ecbe_t.ecbesite,
            ecbe001     LIKE ecbe_t.ecbe001, 
            ecbe002     LIKE ecbe_t.ecbe002, 
            ecbe003     LIKE ecbe_t.ecbe003, 
            ecbeseq     LIKE ecbe_t.ecbeseq, 
            ecbe004     LIKE ecbe_t.ecbe004, 
            ecbe005     LIKE ecbe_t.ecbe005 
                     END RECORD
   
   INITIALIZE l_init TO NULL
   INITIALIZE l_end  TO NULL
   LET wc_data.enable = p_enable
   #節點
   #ecbb004 containers:[]
   FOR idx = 1 TO g_ecbb_d.getLength()
      IF g_ecbb_d[idx].ecbb004 IS NULL AND g_ecbb_d[idx].ecbb005 IS NULL THEN CONTINUE FOR END IF
      LET l_ecbb005 = g_ecbb_d[idx].ecbb005
      CALL wc_data.containers.appendElement()
      LET wc_data.containers[idx].id = SFMT("%1__%2", g_ecbb_d[idx].ecbb004 CLIPPED,l_ecbb005 CLIPPED)

      LET wc_data.containers[idx].group = g_ecbb_d[idx].ecbb007
      LET wc_data.containers[idx].module = "station"
      LET wc_data.containers[idx].image = "station.png"
      LET wc_data.containers[idx].label = g_ecbb_d[idx].ecbb004_desc, " "
      LET wc_data.containers[idx].desc = "" , g_ecbb_d[idx].ecbb004 CLIPPED
      LET wc_data.containers[idx].position.left = g_ecbb_d[idx].ecbb035
      LET wc_data.containers[idx].position.top = g_ecbb_d[idx].ecbb036
      LET wc_data.containers[idx].size.width = 60
      LET wc_data.containers[idx].size.height = 60
      LET wc_data.containers[idx].params.ecbb003 = g_ecbb_d[idx].ecbb003
      
      #產生INIT
      IF g_ecbb_d[idx].ecbb008 == "INIT" THEN
         IF l_init.id IS NULL THEN
            LET l_init.id = "INIT"
            LET l_init.label = "INIT"
            LET l_init.image = "start.png"
            LET l_init.module = "station"
            LET l_init.size.width = 60
            LET l_init.size.height = 60
            SELECT ecba004, ecba005 INTO l_ecba004, l_ecba005 FROM ecba_t
             WHERE ecbaent  = g_enterprise
               AND ecbasite = g_site
               AND ecba001  = g_ecba_m.ecba001
               AND ecba002  = g_ecba_m.ecba002
            #161124-00037#1 add --(S)--
            IF cl_null(l_ecba004) OR cl_null(l_ecba005) THEN
               LET l_ecba004 = g_ecbb_d[idx].ecbb035 - 100
               LET l_ecba005 = g_ecbb_d[idx].ecbb036
               IF l_ecba004 < 0 THEN LET l_ecba004 = 0 END IF
            END IF
            #161124-00037#1 add --(E)--            
            LET l_init.position.left = l_ecba004
            LET l_init.position.top  = l_ecba005
         END IF
      END IF  
      
      #產生END
      IF g_ecbb_d[idx].ecbb010 == "END" THEN
         IF l_end.id IS NULL THEN
            LET l_end.id = "END"
            LET l_end.label = "END"
            LET l_end.image = "end.png"
            LET l_end.module = "station"      
            LET l_end.size.width = 60
            LET l_end.size.height = 60
            SELECT ecba006, ecba007 INTO l_ecba006, l_ecba007 FROM ecba_t
             WHERE ecbaent  = g_enterprise
               AND ecbasite = g_site
               AND ecba001  = g_ecba_m.ecba001
               AND ecba002  = g_ecba_m.ecba002
            #161124-00037#1 add --(S)--
            IF cl_null(l_ecba006) OR cl_null(l_ecba007) THEN
               LET l_ecba006 = g_ecbb_d[idx].ecbb035 + 100
               LET l_ecba007 = g_ecbb_d[idx].ecbb036
            END IF
            #161124-00037#1 add --(E)--          
            LET l_end.position.left = l_ecba006
            LET l_end.position.top  = l_ecba007
         END IF
      END IF

      #群組
      IF g_ecbb_d[idx].ecbb007 IS NOT NULL THEN  
         LET l_find_grp = FALSE
         #找看看有沒有已經建立好的群組
         FOR idx1 = 1 TO wc_data.groups.getLength()
            IF g_ecbb_d[idx].ecbb007 == wc_data.groups[idx1].id THEN
               LET l_find_grp = TRUE
               EXIT FOR
            END IF
         END FOR
         
         #沒找到則建立群組資料
         IF l_find_grp == FALSE THEN
            SELECT gzcbl004 INTO l_gzcbl004 FROM gzcbl_t 
               WHERE gzcbl001 = '1202'
                 AND gzcbl002 = g_ecbb_d[idx].ecbb006
                 AND gzcbl003 = g_dlang
            CALL wc_data.groups.appendElement()
            LET idx1 = wc_data.groups.getLength()
            LET wc_data.groups[idx1].id = g_ecbb_d[idx].ecbb007
            LET wc_data.groups[idx1].label = l_gzcbl004, " - ", g_ecbb_d[idx].ecbb007
            LET wc_data.groups[idx1].params.groupType = g_ecbb_d[idx].ecbb006
         END IF

         #將目前的工作站加入群組中
         LET l_len = wc_data.groups[idx1].containers.getLength() + 1
         LET wc_data.groups[idx1].containers[l_len] = wc_data.containers[idx].id
         
      END IF
   END FOR
   IF l_init.id IS NOT NULL THEN
      CALL wc_data.containers.insertElement(1)
      LET wc_data.containers[1].* = l_init.*
   END IF
   IF l_end.id IS NOT NULL THEN
      LET idx = wc_data.containers.getLength() + 1
      LET wc_data.containers[idx].* = l_end.*
   END IF
   
   #連結線
   #ecbe_t connections:[]
   FOR idx = 1 TO g_ecbb_d.getLength()
      #上站
      IF g_ecbb_d[idx].ecbb008 IS NOT NULL  THEN
         #這裡其實都要去ecbe_t抓上站的資訊，但目前ecbe_t好像沒同步寫入，所以資料是錯的
         #多上站作業中抓
        
         OPEN aecm200_ecbe_declare USING g_enterprise, g_site, g_ecba_m.ecba001, g_ecba_m.ecba002, g_ecbb_d[idx].ecbb003
         FOREACH aecm200_ecbe_declare INTO l_ecbe_t.*
            LET l_ecbb005 = l_ecbe_t.ecbe005
            INITIALIZE l_conn TO NULL
            
            IF l_ecbe_t.ecbe004 == "INIT" OR l_ecbe_t.ecbe004 == "END" THEN
               LET l_conn.source = SFMT("%1", l_ecbe_t.ecbe004)
            ELSE
               LET l_conn.source = SFMT("%1__%2", l_ecbe_t.ecbe004, l_ecbb005)   
            END IF
            LET l_conn.target = SFMT("%1__%2", g_ecbb_d[idx].ecbb004 CLIPPED,g_ecbb_d[idx].ecbb005 CLIPPED)
            
            LET idx1 = wc_data.connections.getLength() + 1
            LET wc_data.connections[idx1].* = l_conn.*
         END FOREACH
         
      END IF
      
      #TODO: 找出下站是END節點的，建立連結線
      IF g_ecbb_d[idx].ecbb010 == "END" THEN
         INITIALIZE l_conn TO NULL
         LET l_ecbb005 = g_ecbb_d[idx].ecbb005
      
         LET l_conn.source = SFMT("%1__%2", g_ecbb_d[idx].ecbb004 CLIPPED, l_ecbb005 CLIPPED)
         LET l_conn.target = "END"
         LET idx1 = wc_data.connections.getLength() + 1
         LET wc_data.connections[idx1].* = l_conn.*
      END IF
      #下站
      #IF g_ecbb_d[idx].ecbb010 IS NOT NULL AND g_ecbb_d[idx].ecbb010 != "MULT" THEN
      #   INITIALIZE l_conn TO NULL
      #   LET l_ecbb005 = g_ecbb_d[idx].ecbb005
      #   LET l_ecbb011 = g_ecbb_d[idx].ecbb011
      #
      #   LET l_conn.source = SFMT("%1__%2", g_ecbb_d[idx].ecbb004 CLIPPED, l_ecbb005 CLIPPED)
      #
      #   LET l_in_grp = FALSE
      #   FOR idx2 = 1 TO wc_data.groups.getLength()
      #      IF g_ecbb_d[idx].ecbb010 == wc_data.groups[idx2].id THEN
      #         LET l_in_grp = TRUE
      #         EXIT FOR
      #      END IF
      #   END FOR
      #      
      #   IF g_ecbb_d[idx].ecbb010 != "INIT" AND g_ecbb_d[idx].ecbb010 != "END" AND l_ecbb011 != 0 AND l_in_grp != TRUE THEN
      #      LET l_conn.target = SFMT("%1__%2", g_ecbb_d[idx].ecbb010 CLIPPED, l_ecbb011 CLIPPED)         
      #   ELSE
      #      LET l_conn.target = SFMT("%1", g_ecbb_d[idx].ecbb010 CLIPPED)
      #   END IF
      #   
      #   
      #   LET idx1 = wc_data.connections.getLength() + 1
      #   LET wc_data.connections[idx1].* = l_conn.*
      #END IF
   END FOR   
  
   #display util.JSON.stringify(wc_data)
   CALL aecm200_wc_submit("wc", "station_flow", util.JSON.stringify(wc_data))

END FUNCTION

PRIVATE FUNCTION aecm200_wc_gen_modules()
   DEFINE l_modules     DYNAMIC ARRAY OF RECORD
            label          STRING,  #節點文字
            module         STRING,  #節點類型
            params         RECORD   #群組類型
               groupType      STRING
                           END RECORD,
            image          STRING   #圖片名稱
                        END RECORD
   LET l_modules[1].label = "INIT"
   LET l_modules[1].module = "station"
   LET l_modules[1].image = "start.png"
   LET l_modules[2].label = "Station"
   LET l_modules[2].module = "station"
   LET l_modules[2].image = "station.png"
   LET l_modules[3].label = "END"
   LET l_modules[3].module = "station"
   LET l_modules[3].image = "end.png"
   LET l_modules[4].label = cl_getmsg("azz-00294", g_dlang)
   LET l_modules[4].module = "group"
   LET l_modules[4].image = "group2.png"
   LET l_modules[4].params.groupType = 2
   LET l_modules[5].label = cl_getmsg("azz-00295", g_dlang)
   LET l_modules[5].module = "group"
   LET l_modules[5].image = "group3.png"
   LET l_modules[5].params.groupType = 3
   #DISPLAY util.JSON.stringify(l_modules)
   RETURN util.JSON.stringify(l_modules)
END FUNCTION

PRIVATE FUNCTION aecm200_wc_submit(ps_wc,ps_type,ps_value)
   DEFINE   ps_wc          STRING
   DEFINE   ps_type        STRING
   DEFINE   ps_value       STRING

   # 沒值就不跑了
   IF ps_value IS NULL THEN
      RETURN
   END IF
   IF g_wc_init == TRUE THEN
      CALL aecm200_wc_property(ps_wc, "station_init", '')
      CALL aecm200_wc_property(ps_wc, "station_flow", '')
      #CALL aecm200_wc_property(ps_wc, "station_modules", '')
      CALL aecm200_wc_property(ps_wc, "station_enable", '')
      CALL aecm200_wc_property(ps_wc, "station_get_data", '')
      CALL aecm200_wc_property(ps_wc, "station_update_node", '')   
      CALL aecm200_wc_property(ps_wc, "station_del_node", '')
   END IF
   
   CALL aecm200_wc_property(ps_wc, ps_type , '')
   CALL aecm200_wc_property(ps_wc, ps_type , ps_value)

END FUNCTION

PRIVATE FUNCTION aecm200_wc_property(ps_comp,prop_name,prop_value)
   DEFINE ps_comp STRING
   DEFINE prop_name STRING
   DEFINE prop_value STRING
   DEFINE win ui.Window
   DEFINE l_ff    om.DomNode
   DEFINE win_node      om.DomNode
   DEFINE l_nl   om.NodeList
   DEFINE l_wc  om.DomNode
   DEFINE l_dict    om.DomNode
   DEFINE l_prop    om.DomNode

   LET win = ui.Window.getCurrent()
   LET win_node = win.getNode()

   LET l_nl = win_node.selectByPath("//FormField[@name=\"formonly."|| ps_comp ||"\"]")

   IF l_nl.getLength() > 0 THEN
      LET l_ff = l_nl.item(1)
      LET l_wc = l_ff.getFirstChild()
      LET l_dict = l_wc.getFirstChild()
      IF l_dict IS NULL THEN
        LET l_dict = l_wc.createChild("PropertyDict")
        CALL l_dict.setAttribute("name", "properties")
      END IF
      LET l_nl = l_dict.selectByPath("//Property[@name=\"" || prop_name || "\"]")
      LET l_prop = l_nl.item(1)
      IF l_prop IS NULL THEN
         LET l_prop = l_dict.createChild("Property")
         CALL l_prop.setAttribute("name", prop_name)
      END IF
      CALL l_prop.setAttribute("value", prop_value)
   END IF
END FUNCTION
#
# ps_jsn格式為：
#   [{"id":"1040__1","group":null,"module":"station","label":"塗料 ","image":"station.png","position":{"top":150,"left":280},"size":{"width":"60px","height":"60px"}}]
#
PRIVATE FUNCTION aecm200_wc_update_pos(ps_json)
   DEFINE ps_json        STRING
   DEFINE l_json_array  util.JSONArray
   DEFINE l_json        util.JSONObject,
          l_json_params util.JSONObject
   DEFINE l_position    util.JSONObject
   DEFINE l_i           INTEGER,
          l_j           INTEGER
   DEFINE l_ecbb003     LIKE ecbb_t.ecbb003,
          l_ecbb004     LIKE ecbb_t.ecbb004,
          l_ecbb005     LIKE ecbb_t.ecbb005,
          l_ecbb035     LIKE ecbb_t.ecbb035,
          l_ecbb036     LIKE ecbb_t.ecbb036
   
   LET l_json_array = util.JSONArray.parse(ps_json)
   FOR l_i = 1 TO l_json_array.getLength()
      LET l_json = l_json_array.get(l_i)
      LET l_position = l_json.get("position")
      
      CALL aecm200_wc_parse_id(l_json.get("id")) RETURNING l_ecbb004, l_ecbb005
      LET l_json_params = l_json.get("params")
      LET l_ecbb003 = l_json_params.get("ecbb003")
      #CALL aecm200_arr_curr(l_ecbb004,l_ecbb005) RETURNING l_ac

      LET l_ecbb035 = l_position.get("left")
      LET l_ecbb036 = l_position.get("top")
      
      CASE l_ecbb004
         WHEN "INIT" #開始的坐標要寫回ecba004, ecba005
            UPDATE ecba_t SET ecba004 = l_ecbb035, ecba005 = l_ecbb036
             WHERE ecbaent  = g_enterprise
               AND ecbasite = g_site
               AND ecba001  = g_ecba_m.ecba001
               AND ecba002  = g_ecba_m.ecba002
            IF SQLCA.sqlcode THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.extend = 'update ecba004, ecba005'
               LET g_errparam.code   = SQLCA.sqlcode
               LET g_errparam.popup  = TRUE
               CALL cl_err()
            END IF
         WHEN "END"  #結束的坐標要寫回ecba006, ecba007
            UPDATE ecba_t SET ecba006 = l_ecbb035, ecba007 = l_ecbb036
             WHERE ecbaent  = g_enterprise
               AND ecbasite = g_site
               AND ecba001  = g_ecba_m.ecba001
               AND ecba002  = g_ecba_m.ecba002
            IF SQLCA.sqlcode THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.extend = 'update ecba006, ecba007'
               LET g_errparam.code   = SQLCA.sqlcode
               LET g_errparam.popup  = TRUE
               CALL cl_err()
            END IF
         OTHERWISE  #寫回單身s_detail1的X,Y軸
            FOR l_j = 1 TO g_ecbb_d.getLength()
               IF g_ecbb_d[l_j].ecbb004 == l_ecbb004 AND g_ecbb_d[l_j].ecbb005 == l_ecbb005 THEN
                  UPDATE ecbb_t SET ecbb035 = l_ecbb035, ecbb036 = l_ecbb036
                     WHERE ecbbent  = g_enterprise
                       AND ecbbsite = g_site
                       AND ecbb001  = g_ecba_m.ecba001
                       AND ecbb002  = g_ecba_m.ecba002
                       AND ecbb003  = g_ecbb_d[l_j].ecbb003
                       AND ecbb004  = l_ecbb004
                       AND ecbb005  = l_ecbb005
                  IF SQLCA.sqlcode THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.extend = 'update:'
                     LET g_errparam.code   = SQLCA.sqlcode
                     LET g_errparam.popup  = TRUE
                     CALL cl_err()
                  END IF
                  EXIT FOR
               END IF
            END FOR
      END CASE
      #DISPLAY "更新坐標：",ps_json
      #display "ecbb004:", l_ecbb004
      #display "ecbb005:", l_ecbb005
      #display "x:", l_position.get("top")
      #display "y:", l_position.get("left")
   END FOR
   
   
END FUNCTION

#
#解析回傳的id如：1030__1, INIT, END
#id是以ecbb004 + "__" + ecbb005 組成
#
PRIVATE FUNCTION aecm200_wc_parse_id(p_str)
   DEFINE p_str      STRING,
          l_str      STRING
   DEFINE l_sb       base.StringBuffer
   DEFINE l_i        INTEGER
   DEFINE l_ecbb004  LIKE ecbb_t.ecbb004,
          l_ecbb005  LIKE ecbb_t.ecbb005
   LET l_sb = base.StringBuffer.create()
   CALL l_sb.append(p_str)
   CALL l_sb.replace("\"", "", 0)
   LET l_str = l_sb.toString()
   LET l_i = l_str.getIndexOf("__",1)
   IF l_i == 0 THEN
      RETURN l_str, 0
   END IF
   LET l_ecbb004 = l_str.subString(1,l_i-1)
   LET l_ecbb005 = l_str.subString(l_i+2, l_str.getLength())
   RETURN l_ecbb004, l_ecbb005
END FUNCTION
#檢查是否已經存在INIT或END節點
PRIVATE FUNCTION aecm200_wc_init_end_exist(p_label)
   DEFINE p_label    STRING
   DEFINE l_i        INTEGER
   FOR l_i = 1 TO g_ecbb_d.getLength()
      IF g_ecbb_d[l_i].ecbb008 == p_label OR g_ecbb_d[l_i].ecbb010 == p_label THEN
         RETURN TRUE
      END IF
   END FOR
   RETURN FALSE
END FUNCTION


#
#儲存時，僅須利用WebComponent提供的連結線來更新ecbe_t及上下站欄位
#
PRIVATE FUNCTION aecm200_wc_save_data(p_wc)
   DEFINE p_wc          STRING
   DEFINE l_ecba004     LIKE ecba_t.ecba004,  #起始站X軸
          l_ecba005     LIKE ecba_t.ecba005,  #起始站Y軸
          l_ecba006     LIKE ecba_t.ecba006,  #終止站X軸
          l_ecba007     LIKE ecba_t.ecba007   #終止站Y軸
   DEFINE l_ecbb003     LIKE ecbb_t.ecbb003,
          l_ecbb004     LIKE ecbb_t.ecbb004,
          l_ecbb005     LIKE ecbb_t.ecbb005,
          l_ecbb006     LIKE ecbb_t.ecbb006,
          l_ecbb004_t   LIKE ecbb_t.ecbb004,
          l_ecbb005_t   LIKE ecbb_t.ecbb005,
          l_ecbb007     LIKE ecbb_t.ecbb007,
          l_ecbb008     LIKE ecbb_t.ecbb008,
          l_ecbb009     LIKE ecbb_t.ecbb009,
          l_ecbb010     LIKE ecbb_t.ecbb010,
          l_ecbb011     LIKE ecbb_t.ecbb011
   DEFINE l_i           INTEGER,
          l_j           INTEGER
   DEFINE l_wc_data     RECORD
            containers     DYNAMIC ARRAY OF t_container,   #工作站
            connections    DYNAMIC ARRAY OF t_connection,  #連接線
            groups         DYNAMIC ARRAY OF t_group        #群組
                        END RECORD
   DEFINE l_container   t_container
   DEFINE l_wc          STRING
   #先刪除所有的ecbe_t   
   #遇到INIT, END時，將坐標存入ecba004, ecba005, ecba006, ecba007
   #先刪除多上站資料，再新增多上站
   #更新ecbb_t資訊
   #刪除不存在於containers中的製程
   
   CALL util.JSON.parse(p_wc, l_wc_data)   
   
   CALL s_transaction_begin()
   
   FOR l_i = 1 TO l_wc_data.containers.getLength()
      INITIALIZE l_container TO NULL
      LET l_container.* = l_wc_data.containers[l_i].*
      
      CALL aecm200_wc_parse_id(l_container.id) RETURNING l_ecbb004, l_ecbb005
      
      IF l_container.id == "INIT" THEN
         LET l_ecba004 = l_container.position.left
         LET l_ecba005 = l_container.position.top
         CONTINUE FOR
      END IF
      IF l_container.id == "END" THEN
         LET l_ecba006 = l_container.position.left
         LET l_ecba007 = l_container.position.top
         CONTINUE FOR
      END IF
      
      #CALL aecm200_arr_curr(l_ecbb004, l_ecbb005) RETURNING l_ac

      IF l_ac > 0 THEN
         
         LET l_ecbb003 = l_container.params.ecbb003
         
         #更新多上站
         CALL aecm200_wc_upd_ecbe(l_container.*)
         
         #更新上站ecbb008, ecbb009欄位
         CASE 
            WHEN l_container.sources.getLength() == 0 #沒上站
               LET l_ecbb008 = NULL
               LET l_ecbb009 = NULL
            WHEN l_container.sources.getLength() == 1 #一個上站
               CALL aecm200_wc_parse_id(l_container.sources[1]) RETURNING l_ecbb004_t, l_ecbb005_t
               LET l_ecbb008 = l_ecbb004_t
               LET l_ecbb009 = l_ecbb005_t
            WHEN l_container.sources.getLength() > 1  #多上站
               LET l_ecbb008 = 'MULT'
               LET l_ecbb009 = 0            
         END CASE
         UPDATE ecbb_t SET ecbb008 = l_ecbb008, ecbb009 = l_ecbb009
           WHERE ecbbent  = g_enterprise
             AND ecbbsite = g_site
             AND ecbb001  = g_ecba_m.ecba001
             AND ecbb002  = g_ecba_m.ecba002
             AND ecbb003  = l_ecbb003
             AND ecbb004  = l_ecbb004
             AND ecbb005  = l_ecbb005
             
             
         #更新下站ecbb010, ecbb011
         CASE
            WHEN l_container.targets.getLength() == 0
               LET l_ecbb010 = NULL
               LET l_ecbb011 = NULL
            WHEN l_container.targets.getLength() == 1
               CALL aecm200_wc_parse_id(l_container.targets[1]) RETURNING l_ecbb004_t, l_ecbb005_t
               LET l_ecbb010 = l_ecbb004_t
               LET l_ecbb011 = l_ecbb005_t
            WHEN l_container.targets.getLength() > 1
               LET l_ecbb010 = 'MULT'
               LET l_ecbb011 = 0
         END CASE
         UPDATE ecbb_t SET ecbb010 = l_ecbb010, ecbb011 = l_ecbb011
            WHERE ecbbent  = g_enterprise
              AND ecbbsite = g_site
              AND ecbb001  = g_ecba_m.ecba001
              AND ecbb002  = g_ecba_m.ecba002
              AND ecbb003  = l_ecbb003
              AND ecbb004  = l_ecbb004
              AND ecbb005  = l_ecbb005
         
         #更新群組
         IF cl_null(l_container.group) THEN
            UPDATE ecbb_t SET ecbb006 = 1 , ecbb007 = NULL
                WHERE ecbbent  = g_enterprise
                  AND ecbbsite = g_site
                  AND ecbb001  = g_ecba_m.ecba001
                  AND ecbb002  = g_ecba_m.ecba002
                  AND ecbb003  = l_ecbb003
                  AND ecbb004  = l_ecbb004
                  AND ecbb005  = l_ecbb005
         ELSE
            FOR l_j = 1 TO l_wc_data.groups.getLength()
               IF l_container.group == l_wc_data.groups[l_j].id THEN
                  LET l_ecbb006 = l_wc_data.groups[l_j].params.groupType
                  LET l_ecbb007 = l_wc_data.groups[l_j].id
                  UPDATE ecbb_t SET ecbb006 = l_ecbb006 , ecbb007 = l_ecbb007
                      WHERE ecbbent  = g_enterprise
                        AND ecbbsite = g_site
                        AND ecbb001  = g_ecba_m.ecba001
                        AND ecbb002  = g_ecba_m.ecba002
                        AND ecbb003  = l_ecbb003
                        AND ecbb004  = l_ecbb004
                        AND ecbb005  = l_ecbb005                  
                  EXIT FOR
               END IF
            END FOR
         END IF         
         
         #組現有節點，預備將不存在現有的從DB刪除
         IF l_i == 1 THEN
            LET l_wc = l_container.id
         ELSE
            LET l_wc = l_wc, ",", l_container.id
         END IF      
      END IF
      
   END FOR
   UPDATE ecba_t SET ecba004 = l_ecba004, ecba005 = l_ecba005, ecba006 = l_ecba006, ecba007 = l_ecba007
      WHERE ecbaent = g_enterprise
        AND ecbasite = g_site
        AND ecba001 = g_ecba_m.ecba001
        AND ecba002 = g_ecba_m.ecba002
        
   LET g_ecba_m.ecba004 = l_ecba004
   LET g_ecba_m.ecba005 = l_ecba005
   LET g_ecba_m.ecba006 = l_ecba006
   LET g_ecba_m.ecba007 = l_ecba007
   
   CALL s_transaction_end('Y',0)
   #更新開始、終止的坐標
  
   
END FUNCTION

PRIVATE FUNCTION aecm200_wc_upd_ecbe(p_container)
   DEFINE p_container      t_container
   DEFINE l_ecbb003        LIKE ecbb_t.ecbb003,
          l_ecbb004        LIKE ecbb_t.ecbb004,
          l_ecbb005        LIKE ecbb_t.ecbb005,
          l_ecbb004_t      LIKE ecbb_t.ecbb004,
          l_ecbb005_t      LIKE ecbb_t.ecbb005
   DEFINE l_i              INTEGER
   
   CALL aecm200_wc_parse_id(p_container.id) RETURNING l_ecbb004, l_ecbb005
   
   LET l_ecbb003 = p_container.params.ecbb003
   IF cl_null(l_ecbb003) THEN RETURN END IF
   
   DELETE FROM ecbe_t WHERE ecbeent  = g_enterprise
                        AND ecbesite = g_site
                        AND ecbe001  = g_ecba_m.ecba001
                        AND ecbe002  = g_ecba_m.ecba002
                        AND ecbe003  = l_ecbb003
   
   FOR l_i = 1 TO p_container.sources.getLength()
      CALL aecm200_wc_parse_id(p_container.sources[l_i]) RETURNING l_ecbb004_t, l_ecbb005_t
      INSERT INTO ecbe_t (ecbeent,      ecbesite, ecbe001,          ecbe002,          ecbe003,   ecbeseq, ecbe004, ecbe005)
                  VALUES (g_enterprise, g_site,   g_ecba_m.ecba001, g_ecba_m.ecba002, l_ecbb003, l_i,     l_ecbb004_t, l_ecbb005_t) 
      
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = 'insert ecbe_t:' 
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = TRUE 
         CALL cl_err()
         EXIT FOR
      END IF
   END FOR
END FUNCTION

PRIVATE FUNCTION aecm200_wc_edit_node(p_wc)
   DEFINE p_wc          STRING
   DEFINE l_container   RECORD
            id             STRING,
            module         STRING,
            params         RECORD
               ecbb003        LIKE ecbb_t.ecbb003
                           END RECORD
                        END RECORD
   DEFINE l_ecbb003     LIKE ecbb_t.ecbb003,
          l_ecbb004     LIKE ecbb_t.ecbb004,   #原本的作業代號
          l_ecbb005     LIKE ecbb_t.ecbb005, #原本的作業序
          l_ecbb004_new LIKE ecbb_t.ecbb004,
          l_ecbb005_new INTEGER,             #自動編過的作業序
          l_ac          INTEGER
   DEFINE l_upd_json    RECORD
            old_id         STRING,
            new_id         STRING,
            new_label      STRING,
            new_desc       STRING,
            params         RECORD   #自訂的參數，WebComponent會無條件回傳
               ecbb003        LIKE ecbb_t.ecbb003
                           END RECORD
                        END RECORD

   IF NOT cl_null(wc) THEN

      CALL util.JSON.parse(p_wc, l_container)
      CALL aecm200_wc_parse_id(l_container.id) RETURNING l_ecbb004, l_ecbb005
      LET l_ecbb003 = l_container.params.ecbb003
      INITIALIZE g_qryparam.* TO NULL
      LET g_qryparam.reqry = FALSE
      LET g_qryparam.arg1 = "221"
      LET g_qryparam.state = 'i'
      CALL q_oocq002()
      INITIALIZE g_ref_fields TO NULL
      LET g_ref_fields[1] = g_qryparam.return1
      CALL ap_ref_array2(g_ref_fields,"SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001 = '221' AND oocql002=? AND oocql003='"||g_dlang||"'","") RETURNING g_rtn_fields
      DISPLAY g_qryparam.return1
      #modify the properties table
      IF NOT cl_null(g_qryparam.return1) THEN
         CALL s_transaction_begin()

         LET l_ecbb004_new = g_qryparam.return1
         SELECT MAX(ecbb005) + 1 INTO l_ecbb005_new FROM ecbb_t
         WHERE ecbbent  = g_enterprise
         AND ecbbsite = g_site
         AND ecbb001 = g_ecba_m.ecba001
         AND ecbb002 = g_ecba_m.ecba002
         AND ecbb004 = l_ecbb004_new
         IF l_ecbb005_new IS NULL THEN LET l_ecbb005_new = 1 END IF

         #更新所有相關的上站、下站

         #更新節點
         UPDATE ecbb_t SET ecbb004 = l_ecbb004_new, ecbb005 = l_ecbb005_new
            WHERE ecbbent = g_enterprise
              AND ecbbsite = g_site
              AND ecbb001 = g_ecba_m.ecba001
              AND ecbb002 = g_ecba_m.ecba002
              AND ecbb003 = l_ecbb003
              AND ecbb004 = l_ecbb004
              AND ecbb005 = l_ecbb005
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = SQLCA.sqlcode
            LET g_errparam.extend = "ecbb_t update"
            LET g_errparam.popup = TRUE
            LET g_errparam.sqlerr = SQLCA.SQLERRD[2]
            CALL cl_err()
            CALL s_transaction_end('N','0')
         END IF
         
         #更新其它節點的上站
         UPDATE ecbb_t SET ecbb008 = l_ecbb004_new, ecbb009 = l_ecbb005_new
            WHERE ecbbent = g_enterprise
              AND ecbbsite = g_site
              AND ecbb001 = g_ecba_m.ecba001
              AND ecbb002 = g_ecba_m.ecba002
              AND ecbb008 = l_ecbb004
              AND ecbb009 = l_ecbb005
              AND ecbb008 != 'MULT'
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = SQLCA.sqlcode
            LET g_errparam.extend = "ecbb_t update"
            LET g_errparam.popup = TRUE
            LET g_errparam.sqlerr = SQLCA.SQLERRD[2]
            CALL cl_err()
            CALL s_transaction_end('N','0')
         END IF
              
         #更新其它節點的下站
         UPDATE ecbb_t SET ecbb010 = l_ecbb004_new, ecbb011 = l_ecbb005_new
            WHERE ecbbent = g_enterprise
              AND ecbbsite = g_site
              AND ecbb001 = g_ecba_m.ecba001
              AND ecbb002 = g_ecba_m.ecba002
              AND ecbb010 = l_ecbb004
              AND ecbb011 = l_ecbb005
              AND ecbb010 != 'MULT'
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = SQLCA.sqlcode
            LET g_errparam.extend = "ecbb_t update"
            LET g_errparam.popup = TRUE
            LET g_errparam.sqlerr = SQLCA.SQLERRD[2]
            CALL cl_err()
            CALL s_transaction_end('N','0')
         END IF
         
         #更新下站的多上站資訊
         UPDATE ecbe_t SET ecbe004 = l_ecbb004_new, ecbe005 = l_ecbb005_new
            WHERE ecbeent = g_enterprise
            AND ecbesite = g_site
            AND ecbe001 = g_ecba_m.ecba001
            AND ecbe002 = g_ecba_m.ecba002
            AND ecbe004 = l_ecbb004
            AND ecbe005 = l_ecbb005
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = SQLCA.sqlcode
            LET g_errparam.extend = "ecbe_t update"
            LET g_errparam.popup = TRUE
            LET g_errparam.sqlerr = SQLCA.SQLERRD[2]
            CALL cl_err()
            CALL s_transaction_end('N','0')
         END IF

         CALL aecm200_b_fill()
         CALL aecm200_b_fill_value(l_ecbb004_new, l_ecbb005_new)
         
         CALL s_transaction_end('Y','0')
         CALL aecm200_arr_curr(l_ecbb004_new, l_ecbb005_new) RETURNING l_ac
         
         #通知WebComponent更新工作站資訊
         #170105-00055#1--add--start--
         IF cl_null(g_ecbb_d[l_ac].ecbb004_desc) THEN
            LET g_ecbb_d[l_ac].ecbb004_desc='-'
         END IF
         #170105-00055#1--add--end----
         LET l_upd_json.old_id = l_container.id
         LET l_upd_json.new_id = SFMT("%1__%2", l_ecbb004_new, l_ecbb005_new CLIPPED)
         LET l_upd_json.new_label = g_ecbb_d[l_ac].ecbb004_desc
         LET l_upd_json.new_desc = g_ecbb_d[l_ac].ecbb004
         LET l_upd_json.params.ecbb003 = g_ecbb_d[l_ac].ecbb003
         CALL aecm200_wc_submit("wc", "station_update_node", util.JSON.stringify(l_upd_json))
      END IF

   END IF
END FUNCTION

################################################################################
# Descriptions...: 上傳eSop
# Memo...........:
# Usage..........: CALL aecm200_open_esop()
# Date & Author..: 2016/01/21 By ming
# Modify.........:
################################################################################
PRIVATE FUNCTION aecm200_open_esop()
   DEFINE li_stat     LIKE type_t.num5
   DEFINE l_target    STRING
   DEFINE lb_file     LIKE ecbi_t.ecbi004
   DEFINE l_ecbi006   LIKE ecbi_t.ecbi006

   LOCATE lb_file IN FILE

   SELECT ecbi004,ecbi006 INTO lb_file,l_ecbi006
     FROM ecbi_t
    WHERE ecbient  = g_enterprise
      AND ecbisite = g_site
      AND ecbi001  = g_ecba_m.ecba001
      AND ecbi002  = g_ecba_m.ecba002
      AND ecbi003  = '1'

   IF SQLCA.sqlcode THEN
      RETURN
   ELSE
      #設定之後要寫體檔案時的目錄與檔名 
      LET l_target = g_enterprise,g_ecba_m.ecba001,g_ecba_m.ecba002,'1','.',l_ecbi006
      LET l_target = os.Path.join(g_target_dir,l_target)
      #寫入實體檔案 
      CALL lb_file.writeFile(l_target)
      #以url的方式開啟檔案 
      CALL s_azzi930_open_url("TEMPDIR",l_target) RETURNING li_stat

   END IF
END FUNCTION

################################################################################
# Descriptions...: 描述说明
# Memo...........:
# Usage..........: CALL aecm200_check_ecca()
#                  RETURNING r_success
# Return code....: r_success TRUE/FALSE
# Date & Author..: 2016/08/25 By xianghui
# Modify.........: #160825-00026#1
################################################################################
PRIVATE FUNCTION aecm200_check_ecca()
DEFINE l_cnt        LIKE type_t.num10       
DEFINE r_success    LIKE type_t.num5

   LET r_success = TRUE

   LET l_cnt = 0 
   SELECT COUNT(*) INTO l_cnt 
     FROM ecca_t
    WHERE eccaent = g_enterprise
      AND ecca001 = g_ecba_m.ecba001
      AND ecca002 = g_ecba_m.ecba002
      AND ecca004 = '2'
      AND eccastus = 'Y'      
   IF l_cnt > 0 AND g_ecba_m.ecbastus = 'Y' THEN  
      LET r_success = FALSE
   END IF    
   RETURN r_success
END FUNCTION

################################################################################
# Descriptions...: 上傳eSop 
# Memo...........:
# Usage..........: CALL aecm200_upload_esop()
# Date & Author..: 2016/01/21 By ming
# Modify.........:
################################################################################
PRIVATE FUNCTION aecm200_upload_esop()
   DEFINE ls_upload            STRING
   DEFINE l_chk                BOOLEAN
   DEFINE l_file_extension     STRING
   DEFINE l_file_basename      STRING
   DEFINE l_str                STRING
   DEFINE ls_pid               STRING
   DEFINE l_new_path           STRING
   DEFINE l_size               LIKE type_t.num10
   DEFINE l_ecbi               RECORD
                                  ecbient     LIKE ecbi_t.ecbient,
                                  ecbisite    LIKE ecbi_t.ecbisite,
                                  ecbi001     LIKE ecbi_t.ecbi001,
                                  ecbi002     LIKE ecbi_t.ecbi002,
                                  ecbi003     LIKE ecbi_t.ecbi003,
                                  ecbi004     LIKE ecbi_t.ecbi004,
                                  ecbi005     LIKE ecbi_t.ecbi005,
                                  ecbi006     LIKE ecbi_t.ecbi006
                               END RECORD
   DEFINE l_file_blob          LIKE type_t.blob
   DEFINE l_cnt                LIKE type_t.num5

   LOCATE l_file_blob IN MEMORY     #blob必須先用locate初始化  
   
   #開窗選取檔案  
   CALL cl_client_browse_file() RETURNING ls_upload

   IF NOT cl_null(ls_upload) THEN
      #取得副檔名 
      LET l_file_extension = os.Path.extension(ls_upload)
      #取得檔名 
      LET l_file_basename  = os.Path.basename(ls_upload)
      #如果有副檔名就把副檔名清掉 
      IF NOT cl_null(l_file_extension) THEN
         LET l_str = ".",l_file_extension
         LET l_file_basename = cl_replace_str(l_file_basename,l_str,"")
      END IF

      #把檔案放在暫存的目錄中，要改檔名，避免重覆 
      LET ls_pid = FGL_GETPID()     #取得編號 
      LET g_num = g_num + 1         #防重覆上傳，所以要建流水號  
      LET l_str = g_num
      #程式名+任意編號+使用者編號+流水編+副檔名 
      LET l_new_path = g_prog CLIPPED,"_",ls_pid CLIPPED,"_",
                       g_user CLIPPED,"_",l_str CLIPPED,".",l_file_extension
      #新路徑=取環境變數(暫存目錄)+新檔名 
      LET l_new_path = os.Path.join(FGL_GETENV("TEMPDIR"),l_new_path CLIPPED)
      #把檔案上傳到暫存目錄 
      CALL FGL_GETFILE(ls_upload,l_new_path) 
      
      #檢查檔案是否存在 
      IF os.Path.exists(l_new_path) THEN
         #取得檔案大小 
         LET l_size = os.Path.size(l_new_path)
         #檢查檔案是否超過限制 
         CALL s_azzi932_filelimt(l_size) RETURNING l_chk

         IF NOT l_chk THEN
            #超過就不做了 
            RETURN
         END IF

         CALL s_transaction_begin()

         LET l_cnt = 0
         SELECT COUNT(*) INTO l_cnt
           FROM ecbi_t
          WHERE ecbient  = g_enterprise
            AND ecbisite = g_site
            AND ecbi001  = g_ecba_m.ecba001
            AND ecbi002  = g_ecba_m.ecba002
         IF l_cnt > 0 THEN
            DELETE FROM ecbi_t WHERE ecbient  = g_enterprise
                                 AND ecbisite = g_site
                                 AND ecbi001  = g_ecba_m.ecba001
                                 AND ecbi002  = g_ecba_m.ecba002
            IF SQLCA.sqlcode THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.extend = 'del ecbi'
               LET g_errparam.code   = SQLCA.sqlcode 
               LET g_errparam.popup  = TRUE
               CALL cl_err()

               CALL s_transaction_end('N','0')
               RETURN
            END IF
         END IF

         INITIALIZE l_ecbi.* TO NULL
         LET l_ecbi.ecbient  = g_enterprise
         LET l_ecbi.ecbisite = g_site
         LET l_ecbi.ecbi001  = g_ecba_m.ecba001
         LET l_ecbi.ecbi002  = g_ecba_m.ecba002
         LET l_ecbi.ecbi003  = '1'

         LET l_ecbi.ecbi005  = l_file_basename     #附件檔名   
         LET l_ecbi.ecbi006  = l_file_extension    #附件副檔名  

         LOCATE l_file_blob IN FILE l_new_path

         INSERT INTO ecbi_t(ecbient,ecbisite,ecbi001,ecbi002,ecbi003,
                            ecbi004,ecbi005,ecbi006)
                     VALUES(l_ecbi.ecbient,l_ecbi.ecbisite,l_ecbi.ecbi001,l_ecbi.ecbi002,
                            l_ecbi.ecbi003,l_file_blob,l_ecbi.ecbi005,l_ecbi.ecbi006)
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.extend = 'ins ecbi_t'
            LET g_errparam.code   = SQLCA.sqlcode
            LET g_errparam.popup  = TRUE 
            CALL cl_err()

            CALL s_transaction_end('N','0')
         ELSE
            CALL s_transaction_end('Y','0')
         END IF

      END IF
   END IF
END FUNCTION

 
{</section>}
 
