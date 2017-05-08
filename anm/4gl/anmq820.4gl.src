#該程式已解開Section, 不再透過樣板產出!
{<section id="anmq820.description" >}
#應用 a00 樣板自動產生(Version:1)
#+ Version..: T100-ERP-1.00.00(SD版次:2,PR版次:2) Build-000142
#+ 
#+ Filename...: anmq820
#+ Description: 銀行資金各期進出查詢
#+ Creator....: 04152(2014-08-06 10:36:54)
#+ Modifier...: 01251(2014-12-10 15:50:57) -SD/PR- 01531
 
{</section>}
 
{<section id="anmq820.global" >}
#應用 q01 樣板自動產生(Version:12)
#150715-00014#2  2015/07/22  By Jessy    anmq* bug修復(二次篩選時須隱藏選取項目，QBE交易帳戶編碼無法查出任何資料)
#150915-00008#6  2015/09/17  By Jessy    單頭加上起迄期別，單身需依起迄期別指定的期別顯示，如果當期無資料也要計算結存數 
#151002-00004#1  2015/10/02  By RayHuang 1.XG列印時資料不完整  2.第二單身期初金額錯誤
#160122-00001#29 2016/02/03  By 02599    增加交易账户用户权限控管
#160122-00001#29 2016/03/17  By 07900    增加交易账户用户权限控管,增加部门权限
#160321-00016#39 2016/03/30  By Jessy    將重複內容的錯誤訊息置換為公用錯誤訊息
#160516-00021#1  2016/05/14  By fengmy   增加调汇金额栏位nmde105
#160727-00019#4  2016/07/28  By 08742    系统中定义的临时表名称超过15码在执行时会出错,将系统中定义的临时表长度超过15码的改掉	
#160816-00053#1  2016/08/18  By 00768    修正本期存入与提出数据为0问题，没筛选法人，以致定位错数据，导致数据为0
#160819-00016#1  2016/08/19  By 9768     修正160516-00021#1单修改错误,nmde105的抓取sql与变量没对应上
#160816-00012#4  2016/09/06  By 07900    ANM增加资金中心，帐套，法人三个栏位权限
#161207-00018#1  2016/12/08  By 01531    anmq820查询，本期汇差金额为空，且本币结存没有加nmde105计算
 
IMPORT os
IMPORT util
#add-point:增加匯入項目

#end add-point
 
SCHEMA ds
 
GLOBALS "../../cfg/top_global.inc"
 
#add-point:增加匯入變數檔

#end add-point
 
#單身 type 宣告
PRIVATE TYPE type_g_nmaa_d RECORD
       
       sel LIKE type_t.chr1, 
   nmaa001 LIKE nmaa_t.nmaa001, 
   nmaa002 LIKE nmaa_t.nmaa002, 
   nmaa002_desc LIKE type_t.chr500, 
   nmaa003 LIKE nmaa_t.nmaa003, 
   nmaa003_desc LIKE type_t.chr500, 
   nmas002 LIKE nmas_t.nmas002, 
   nmas003 LIKE nmas_t.nmas003
       END RECORD
PRIVATE TYPE type_g_nmaa2_d RECORD
       nmbx002 LIKE nmbx_t.nmbx002, 
   l_ori_begin LIKE type_t.num20_6, 
   nmbx103 LIKE nmbx_t.nmbx103, 
   nmbx104 LIKE nmbx_t.nmbx104, 
   l_ori_end LIKE type_t.num20_6, 
   l_loc_begin LIKE type_t.num20_6, 
   nmbx113 LIKE nmbx_t.nmbx113, 
   nmbx114 LIKE nmbx_t.nmbx114, 
   nmde105 LIKE nmde_t.nmde105,   #fengmy160514    
   l_loc_end LIKE type_t.num20_6
       END RECORD
 
PRIVATE TYPE type_g_nmaa3_d RECORD
       l_nmbx0022 LIKE type_t.chr500, 
   l_loc_begin2 LIKE type_t.num20_6, 
   nmbx123 LIKE nmbx_t.nmbx123, 
   nmbx124 LIKE nmbx_t.nmbx124, 
   l_loc_end2 LIKE type_t.num20_6, 
   l_loc_begin3 LIKE type_t.num20_6, 
   nmbx133 LIKE nmbx_t.nmbx133, 
   nmbx134 LIKE nmbx_t.nmbx134, 
   l_loc_end3 LIKE type_t.num20_6, 
   l_nmbxcomp LIKE type_t.chr500
       END RECORD
 
 
 
#模組變數(Module Variables)
DEFINE g_nmaa_d            DYNAMIC ARRAY OF type_g_nmaa_d
DEFINE g_nmaa_d_t          type_g_nmaa_d
DEFINE g_nmaa2_d     DYNAMIC ARRAY OF type_g_nmaa2_d
DEFINE g_nmaa2_d_t   type_g_nmaa2_d
 
DEFINE g_nmaa3_d     DYNAMIC ARRAY OF type_g_nmaa3_d
DEFINE g_nmaa3_d_t   type_g_nmaa3_d
 
 
 
 
 
DEFINE g_wc                  STRING                        #儲存 user 的查詢條件
DEFINE g_wc_t                STRING                        #儲存 user 的查詢條件
DEFINE g_wc2                 STRING
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
 
#多table用wc
DEFINE g_wc_table           STRING
 
DEFINE g_wc2_table2   STRING
 
 
 
DEFINE g_wc_filter_table           STRING
 
DEFINE g_wc2_filter_table2   STRING
 
 
 
#add-point:自定義模組變數-標準(Module Variable)
DEFINE g_input     RECORD
        nmbxcomp      LIKE nmbx_t.nmbxcomp,
        nmbxcomp_desc LIKE type_t.chr80,
        nmbx001       LIKE nmbx_t.nmbx001,
        strmon        LIKE nmbx_t.nmbx002,  #150915-00008#6
        endmon        LIKE nmbx_t.nmbx002   #150915-00008#6
                   END RECORD
DEFINE l_para_data   LIKE type_t.chr80
DEFINE g_glaa001     LIKE glaa_t.glaa001
DEFINE g_glaa015     LIKE glaa_t.glaa015
DEFINE g_glaa019     LIKE glaa_t.glaa019
DEFINE g_nmbxcomp    LIKE nmbx_t.nmbxcomp
DEFINE g_sql_bank    STRING   #160122-00001#29 by 07900 -add
#end add-point
#add-point:自定義模組變數-客製(Module Variable)

##end add-point
 
#add-point:傳入參數說明

#end add-point
 
{</section>}
 
{<section id="anmq820.main" >}
#應用 a26 樣板自動產生(Version:3)
#+ 作業開始(主程式類型)
MAIN
   #add-point:main段define
   
   #end add-point   
   #add-point:main段define(客製用)
   
   #end add-point   
 
   OPTIONS
   INPUT NO WRAP
   DEFER INTERRUPT
   
   #設定SQL錯誤記錄方式 (模組內定義有效)
   WHENEVER ERROR CALL cl_err_msg_log
       
   #依模組進行系統初始化設定(系統設定)
   CALL cl_ap_init("anm","")
 
   #add-point:作業初始化
   
   #end add-point
   
   
 
   #LOCK CURSOR (identifier)
   #add-point:SQL_define
   
   #end add-point
   LET g_forupd_sql = " ", 
                      " FROM ",
                      " "
   #add-point:SQL_define
   
   #end add-point
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)                #轉換不同資料庫語法
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE anmq820_cl CURSOR FROM g_forupd_sql                 # LOCK CURSOR
 
   LET g_sql = " SELECT  ",
               " FROM  t0",
               
               " WHERE  "
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   #add-point:SQL_define
   
   #end add-point
   PREPARE anmq820_master_referesh FROM g_sql
 
   #add-point:main段define_sql
   
   #end add-point 
   LET g_forupd_sql = ""
   #add-point:main段define_sql
   
   #end add-point 
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE anmq820_bcl CURSOR FROM g_forupd_sql
    
 
   
   IF g_bgjob = "Y" THEN
      #add-point:Service Call
      
      #end add-point
   ELSE
      #畫面開啟 (identifier)
      OPEN WINDOW w_anmq820 WITH FORM cl_ap_formpath("anm",g_code)
   
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
   
      #程式初始化
      CALL anmq820_init()   
 
      #進入選單 Menu (="N")
      CALL anmq820_ui_dialog() 
      
      #add-point:畫面關閉前
      
      #end add-point
 
      #畫面關閉
      CLOSE WINDOW w_anmq820
      
   END IF 
   
   CLOSE anmq820_cl
   
   
 
   #add-point:作業離開前
   DROP TABLE anmq820_xg_tmp;
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
END MAIN
 
 
 
{</section>}
 
{<section id="anmq820.init" >}
#+ 瀏覽頁簽資料初始化
PRIVATE FUNCTION anmq820_init()
   #add-point:init段define-標準
   DEFINE l_array DYNAMIC ARRAY OF RECORD
                  value       STRING,
                  label_tag   STRING,
                  label       STRING
                  END RECORD
   DEFINE i       LIKE type_t.num5
   #end add-point
   #add-point:init段define-客製
   
   #end add-point
 
   LET g_wc_filter   = " 1=1"
   LET g_wc_filter_t = " 1=1" 
   LET g_error_show  = 1
#  LET g_selcolor    = "#D0E7FD"
   
     
 
   #add-point:畫面資料初始化
   CALL l_array.clear()
   FOR i = 2000 TO 2100
      CALL l_array.appendElement()
      LET l_array[l_array.getLength()].value = i
      LET l_array[l_array.getLength()].label = i
   END FOR
   CALL cl_set_combo_detail('nmbx001',l_array)     #年度
   CALL l_array.clear()
   CALL anmq820_create_temp_table()
   CALL cl_set_comp_visible('sel',FALSE)  #150715-00014#2 隱藏選取標籤
   #160122-00001#2 By 07900--add--str--
   LET g_sql_bank=NULL
   CALL s_anmi120_get_bank_account_sql(g_user,g_dept) RETURNING g_sub_success,g_sql_bank
   #160122-00001#2 By 07900--add--end
   #150915-00008#6-----s
   CALL s_fin_set_comp_scc('b_strmon','111')  #期別
   CALL s_fin_set_comp_scc('b_endmon','111')  #期別
   LET g_input.nmbx001 = YEAR(g_today)
   LET g_input.strmon  = MONTH(g_today)
   LET g_input.endmon  = MONTH(g_today)
   #150915-00008#6-----e   
   #end add-point
 
   CALL anmq820_default_search()
END FUNCTION
 
{</section>}
 
{<section id="anmq820.default_search" >}
PRIVATE FUNCTION anmq820_default_search()
   #add-point:default_search段define-標準
   
   #end add-point
   #add-point:default_search段define-客製
   
   #end add-point
 
 
   #add-point:default_search段開始前
   
   #end add-point
 
   #應用 qs27 樣板自動產生(Version:2)
   #+ 組承接外部參數時資料庫欄位對應條件(單身)
   IF NOT cl_null(g_argv[01]) THEN
      LET g_wc = g_wc, " nmaa001 = '", g_argv[01], "' AND "
   END IF
 
 
 
 
 
 
   IF NOT cl_null(g_wc) THEN
      LET g_wc = g_wc.subString(1,g_wc.getLength()-5)
   ELSE
      #預設查詢條件
      LET g_wc = " 1=2"
   END IF
 
   #add-point:default_search段結束前
   
   #end add-point
 
END FUNCTION
 
{</section>}
 
{<section id="anmq820.ui_dialog" >}
#+ 選單功能實際執行處
PRIVATE FUNCTION anmq820_ui_dialog() 
   DEFINE li_exit   LIKE type_t.num5    #判別是否為離開作業
   DEFINE li_idx    LIKE type_t.num10
   DEFINE ls_result STRING
   DEFINE ls_wc     STRING
   DEFINE lc_action_choice_old   STRING
   #add-point:ui_dialog段define-標準
   DEFINE l_sql      STRING   #160816-00012#4 Add
   DEFINE l_wc       STRING   #160816-00012#4 Add
   DEFINE l_count    LIKE type_t.num5  #160816-00012#4 Add
   #end add-point
   #add-point:ui_dialog段define-客製

   #end add-point
   
 
   CALL cl_set_act_visible("accept,cancel", FALSE)
 
   LET li_exit = FALSE
   LET gwin_curr = ui.Window.getCurrent()
   LET gfrm_curr = gwin_curr.getForm()   
   LET g_current_row = 0
   LET g_current_idx = 1
   LET g_action_choice = " "
   LET lc_action_choice_old = ""
   LET l_ac = 1
 
   #add-point:ui_dialog段before dialog 
 
   #end add-point
 
   
   CALL anmq820_b_fill()
  
   WHILE li_exit = FALSE
 
      IF g_action_choice = "logistics" THEN
         #清除畫面及相關資料
         CLEAR FORM
         CALL g_nmaa_d.clear()
         CALL g_nmaa2_d.clear()
 
         CALL g_nmaa3_d.clear()
 
 
         LET g_wc  = " 1=2"
         LET g_wc2 = " 1=1"
         LET g_action_choice = ""
 
         CALL anmq820_init()
      END IF
 
      DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
         #add-point:input段落
         INPUT g_input.nmbxcomp,g_input.nmbx001,g_input.strmon,g_input.endmon 
          FROM nmbxcomp,nmbx001,b_strmon,b_endmon  #150915-00008#6 add b_strmon,b_endmon
            ATTRIBUTE(WITHOUT DEFAULTS)  
            
            AFTER FIELD nmbxcomp
               #取得資金關帳日+1天之所在年月當預設值
               IF NOT cl_null(g_input.nmbxcomp) THEN
                   
                  CALL s_fin_comp_chk(g_input.nmbxcomp) RETURNING g_sub_success,g_errno
                  IF NOT g_sub_success THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = g_errno
                     LET g_errparam.extend = ''
                     #160321-00016#39 --s add
                     LET g_errparam.replace[1] = 'aooi100'
                     LET g_errparam.replace[2] = cl_get_progname('aooi100',g_lang,"2")
                     LET g_errparam.exeprog = 'aooi100'
                     #160321-00016#39 --e add
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                     #150715-00014#2-----s
                     #清空錯誤欄位
                     LET g_input.nmbxcomp = ''
                     LET g_input.nmbxcomp_desc = ''
                     LET g_input.nmbx001 = ''
                     DISPLAY BY NAME g_input.nmbxcomp_desc,g_input.nmbx001
                     #150715-00014#2-----e
                     NEXT FIELD CURRENT
                  END IF
                  #160816-00012#4 Add  ---(S)---
                   #检查用户是否有资金中心对应法人的权限
                   CALL s_axrt300_get_site(g_user,'','3') RETURNING l_wc
                   LET l_count = 0
                   LET l_sql = "SELECT COUNT(*) FROM ooef_t WHERE ooefent = '",g_enterprise,"' ",
                               "   AND ooef001 = '",g_input.nmbxcomp,"'",
                               "   AND ooef003 = 'Y'",
                               "   AND ",l_wc CLIPPED
                   PREPARE anmp410_count_prep1 FROM l_sql
                   EXECUTE anmp410_count_prep1 INTO l_count
                   IF cl_null(l_count) THEN LET l_count = 0 END IF
                   IF l_count = 0 THEN
                      INITIALIZE g_errparam TO NULL
                      LET g_errparam.code = "ais-00228"
                      LET g_errparam.extend = ''
                      LET g_errparam.popup = TRUE
                      CALL cl_err()
                      LET g_input.nmbxcomp = ''
                      NEXT FIELD CURRENT
                   END IF
                   #160816-00012#4 Add  ---(E)---
                  CALL cl_get_para(g_enterprise,g_input.nmbxcomp,'S-FIN-4007') RETURNING l_para_data
                  LET l_para_data = s_date_get_date(l_para_data,0,1)
                  LET g_input.nmbx001 = YEAR(l_para_data)
                  CALL s_fin_get_major_ld(g_input.nmbxcomp) RETURNING g_glaa001
                  CALL s_ld_sel_glaa(g_glaa001,'glaa015| glaa019')
                       RETURNING g_sub_success,g_glaa015,g_glaa019
                  IF g_glaa015 = 'N' AND  g_glaa019 = 'N' THEN
                     CALL cl_set_comp_visible('page_2',FALSE)    #本幣頁籤隱藏
                  ELSE
                     CALL cl_set_comp_visible('page_2',TRUE)     #本幣頁籤顯示
                     CALL cl_set_comp_visible('l_nmbx0022,l_loc_begin2,nmbx123,nmbx124,l_loc_end2,l_loc_begin3,nmbx133,nmbx134,l_loc_end3',FALSE) 
                     IF g_glaa015 = 'Y' THEN
                        CALL cl_set_comp_visible('l_nmbx0022,l_loc_begin2,nmbx123,nmbx124,l_loc_end2',TRUE) 
                     END IF
                     IF g_glaa019 = 'Y' THEN
                        CALL cl_set_comp_visible('l_loc_begin3,nmbx133,nmbx134,l_loc_end3',TRUE) 
                     END IF
                  END IF
               END IF
               CALL s_desc_get_department_desc(g_input.nmbxcomp) RETURNING g_input.nmbxcomp_desc
               DISPLAY BY NAME g_input.nmbxcomp_desc,g_input.nmbx001 #150715-00014#2 補上nmbx001

            ON ACTION controlp INFIELD nmbxcomp
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'i'
               LET g_qryparam.reqry = FALSE
               LET g_qryparam.default1 = g_input.nmbxcomp
               LET g_qryparam.where = "ooef003 = 'Y'"
               #160816-00012#4 Add  ---(S)---
               CALL s_axrt300_get_site(g_user,'','3') RETURNING l_wc
               LET g_qryparam.where = l_wc CLIPPED
               #160816-00012#4 Add  ---(E)---
               CALL q_ooef017_01()   #150715-00014#2 修改開窗
               LET g_input.nmbxcomp = g_qryparam.return1
               DISPLAY g_input.nmbxcomp TO nmbxcomp
               CALL s_desc_get_department_desc(g_input.nmbxcomp) RETURNING g_input.nmbxcomp_desc
               DISPLAY BY NAME g_input.nmbxcomp_desc
               NEXT FIELD nmbxcomp

            #150915-00008#6-----s
            #期別控卡
            ON CHANGE b_strmon
               IF g_input.endmon < g_input.strmon THEN
                  LET g_input.endmon = g_input.strmon
               END IF
               DISPLAY BY NAME g_input.endmon,g_input.strmon
               
            ON CHANGE b_endmon
               IF g_input.endmon < g_input.strmon THEN
                  LET g_input.strmon = g_input.endmon
               END IF
               DISPLAY BY NAME g_input.endmon,g_input.strmon
            #150915-00008#6-----e

         END INPUT
         #end add-point
 
         #add-point:construct段落
         CONSTRUCT BY NAME g_wc ON nmaa001,nmas003,nmaa002,nmaa003                                 
            ON ACTION controlp INFIELD nmaa001 #帳戶編碼
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c'
               LET g_qryparam.reqry = FALSE
               LET g_qryparam.where = " ooef017 = '",g_input.nmbxcomp,"'",
                                      #160122-00001#29--add--str--
                                      " AND nmaa001 IN (SELECT DISTINCT nmas001 FROM nmas_t",
                                      "                  WHERE nmas002 IN (",g_sql_bank,"))"      #160122-00001#29 by 07900 --mod
                                      #160122-00001#29--add--end
                                      
               CALL q_nmaa001_01()
               DISPLAY g_qryparam.return1 TO nmaa001
               NEXT FIELD nmaa001

            ON ACTION controlp INFIELD nmas003 #幣別
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c'
               LET g_qryparam.reqry = FALSE
               CALL q_aooi001_1()
               DISPLAY g_qryparam.return1 TO nmas003
               NEXT FIELD nmas003

            ON ACTION controlp INFIELD nmaa002 #開戶人（組織）
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c'
               LET g_qryparam.reqry = FALSE
               LET g_qryparam.where = " ooed004 IN (SELECT ooef001 from ooef_t where ooef017 = '",g_input.nmbxcomp,"' AND ooefent='",g_enterprise,"')"
               CALL q_ooed004_8()
               DISPLAY g_qryparam.return1 TO nmaa002
               NEXT FIELD nmaa002

            ON ACTION controlp INFIELD nmaa003 #帳戶類型
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c'
               LET g_qryparam.reqry = FALSE
               CALL q_nmag001()
               DISPLAY g_qryparam.return1 TO nmaa003
               NEXT FIELD nmaa003
         END CONSTRUCT
         #end add-point
     
         DISPLAY ARRAY g_nmaa_d TO s_detail1.* ATTRIBUTE(COUNT=g_detail_cnt)
 
            BEFORE DISPLAY
               LET g_current_page = 1
 
            BEFORE ROW
               LET g_detail_idx = DIALOG.getCurrentRow("s_detail1")
               LET l_ac = g_detail_idx
               DISPLAY g_detail_idx TO FORMONLY.h_index
               DISPLAY g_nmaa_d.getLength() TO FORMONLY.h_count
               LET g_master_idx = l_ac
               #為避免按上下筆時影響執行效能，所以做一些處理
               LET lc_action_choice_old = g_action_choice
               LET g_action_choice = "fetch"
               CALL anmq820_b_fill2()
               LET g_action_choice = lc_action_choice_old
 
               #add-point:input段before row
               CALL s_fin_get_major_ld(g_nmbxcomp) RETURNING g_glaa001
               CALL s_ld_sel_glaa(g_glaa001,'glaa015| glaa019')
                    RETURNING g_sub_success,g_glaa015,g_glaa019
               IF g_glaa015 = 'N' AND  g_glaa019 = 'N' THEN
                  CALL cl_set_comp_visible('page_2',FALSE)    #本幣頁籤隱藏
               ELSE
                  CALL cl_set_comp_visible('page_2',TRUE)     #本幣頁籤顯示
                  CALL cl_set_comp_visible('nmbx0022,loc_begin2,nmbx123,nmbx124,loc_end2,loc_begin3,nmbx133,nmbx134,loc_end3',FALSE) 
                  IF g_glaa015 = 'Y' THEN
                     CALL cl_set_comp_visible('nmbx0022,loc_begin2,nmbx123,nmbx124,loc_end2',TRUE) 
                  END IF
                  IF g_glaa019 = 'Y' THEN
                     CALL cl_set_comp_visible('loc_begin3,nmbx133,nmbx134,loc_end3',TRUE) 
                  
                  END IF
               END IF
               #end add-point
 
            
 
            #自訂ACTION(detail_show,page_1)
            
 
         END DISPLAY
 
         DISPLAY ARRAY g_nmaa2_d TO s_detail2.*
            ATTRIBUTES(COUNT=g_detail_cnt)
            BEFORE DISPLAY
               LET g_current_page = 2
            BEFORE ROW
               LET g_detail_idx2 = DIALOG.getCurrentRow("s_detail2")
               LET l_ac = g_detail_idx2
               LET g_detail_idx2 = l_ac
               DISPLAY g_detail_idx2 TO FORMONLY.idx
               #add-point:input段before row
               CALL anmq820_b_fill2()
               #end add-point
            #自訂ACTION(detail_show,page_2)
            
         END DISPLAY
 
         DISPLAY ARRAY g_nmaa3_d TO s_detail3.*
            ATTRIBUTES(COUNT=g_detail_cnt)
            BEFORE DISPLAY
               LET g_current_page = 3
            BEFORE ROW
               LET g_detail_idx2 = DIALOG.getCurrentRow("s_detail3")
               LET l_ac = g_detail_idx2
               LET g_detail_idx2 = l_ac
               DISPLAY g_detail_idx2 TO FORMONLY.idx
               #add-point:input段before row

               #end add-point
            #自訂ACTION(detail_show,page_3)
            
         END DISPLAY
 
 
 
         #add-point:ui_dialog段自定義display array

         #end add-point
 
         BEFORE DIALOG
            CALL DIALOG.setSelectionMode("s_detail1", 1)
            #add-point:ui_dialog段before dialog
            #150715-00014#2-----s
            CALL cl_set_act_visible('insert',FALSE)   #隱藏新增Action
            CALL cl_set_comp_visible('sel',FALSE)     #隱藏選取標籤
            #150715-00014#2-----e
            #end add-point
            NEXT FIELD nmbxcomp
 
         AFTER DIALOG
            #add-point:ui_dialog段 after dialog

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
            IF cl_null(g_wc) OR g_wc=" 1=2" THEN   #2015/03/23---add->g_wc=" 1=2"
               LET g_wc = " 1=1"
            END IF
 
            IF NOT cl_null(g_wc2_table2) AND g_wc2_table2 <> " 1=1" THEN
               LET g_wc = g_wc, " AND ", g_wc2_table2
            END IF
 
 
         
            LET g_wc2 = " 1=1"
            IF NOT cl_null(g_wc2_table2) AND g_wc2_table2 <> " 1=1" THEN
               LET g_wc2 = g_wc2, " AND ", g_wc2_table2
            END IF
 
 
            CALL anmq820_b_fill()
 
            IF g_detail_cnt = 0 AND NOT INT_FLAG THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.extend = ""
               LET g_errparam.code   = -100
               LET g_errparam.popup  = TRUE
               CALL cl_err()
            END IF
      
 
         ON ACTION agendum   # 待辦事項
            #add-point:ON ACTION agendum

            #end add-point
            CALL cl_user_overview()
 
         ON ACTION exporttoexcel   #匯出excel
            LET g_action_choice="exporttoexcel"
            IF cl_auth_chk_act("exporttoexcel") THEN
               CALL g_export_node.clear()
               LET g_export_node[1] = base.typeInfo.create(g_nmaa_d)
               LET g_export_id[1]   = "s_detail1"
               LET g_export_node[2] = base.typeInfo.create(g_nmaa2_d)
               LET g_export_id[2]   = "s_detail2"
 
               LET g_export_node[3] = base.typeInfo.create(g_nmaa3_d)
               LET g_export_id[3]   = "s_detail3"
 
 
               #add-point:ON ACTION exporttoexcel

               #END add-point
               CALL cl_export_to_excel_getpage()
               CALL cl_export_to_excel()
            END IF
 
         ON ACTION datarefresh   # 重新整理
            CALL anmq820_b_fill()
 
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
 
         #應用 qs19 樣板自動產生(Version:2)
         #有關於sel欄位選取的action段落
         #選擇全部
         ON ACTION selall
            CALL DIALOG.setSelectionRange("s_detail1", 1, -1, 1)
            FOR li_idx = 1 TO g_nmaa_d.getLength()
               LET g_nmaa_d[li_idx].sel = "Y"
            END FOR
 
            #add-point:ui_dialog段on action selall

            #end add-point
 
         #取消全部
         ON ACTION selnone
            CALL DIALOG.setSelectionRange("s_detail1", 1, -1, 0)
            FOR li_idx = 1 TO g_nmaa_d.getLength()
               LET g_nmaa_d[li_idx].sel = "N"
            END FOR
 
            #add-point:ui_dialog段on action selnone

            #end add-point
 
         #勾選所選資料
         ON ACTION sel
            FOR li_idx = 1 TO g_nmaa_d.getLength()
               IF DIALOG.isRowSelected("s_detail1", li_idx) THEN
                  LET g_nmaa_d[li_idx].sel = "Y"
               END IF
            END FOR
 
            #add-point:ui_dialog段on action sel

            #end add-point
 
         #取消所選資料
         ON ACTION unsel
            FOR li_idx = 1 TO g_nmaa_d.getLength()
               IF DIALOG.isRowSelected("s_detail1", li_idx) THEN
                  LET g_nmaa_d[li_idx].sel = "N"
               END IF
            END FOR
 
            #add-point:ui_dialog段on action unsel

            #end add-point
 
 
 
 
         #應用 qs16 樣板自動產生(Version:2)
         ON ACTION filter
            LET g_action_choice="filter"
            CALL anmq820_filter()
            #add-point:ON ACTION filter

            #END add-point
            EXIT DIALOG
 
 
 
         
         #應用 a43 樣板自動產生(Version:2)
         ON ACTION insert
            LET g_action_choice="insert"
            IF cl_auth_chk_act("insert") THEN
               
               #add-point:ON ACTION insert

               #END add-point
               
               EXIT DIALOG
            END IF
 
 
 
         #應用 a43 樣板自動產生(Version:2)
         ON ACTION output
            LET g_action_choice="output"
            IF cl_auth_chk_act("output") THEN
               
               #add-point:ON ACTION output
               CALL anmq820_print()
               #END add-point
               
               EXIT DIALOG
            END IF
 
 
 
         #應用 a43 樣板自動產生(Version:2)
         ON ACTION query
            LET g_action_choice="query"
            IF cl_auth_chk_act("query") THEN
               
               #add-point:ON ACTION query
 
               #END add-point
               
               
            END IF
 
 
 
         #應用 a43 樣板自動產生(Version:2)
         ON ACTION datainfo
            LET g_action_choice="datainfo"
            IF cl_auth_chk_act("datainfo") THEN
               
               #add-point:ON ACTION datainfo

               #END add-point
               
               EXIT DIALOG
            END IF
 
 
 
      
         #主選單用ACTION
         &include "main_menu_exit_dialog.4gl"
         &include "relating_action.4gl"
         #交談指令共用ACTION
         &include "common_action.4gl"
 
         #add-point:查詢方案相關ACTION設定前

         #end add-point
 
         ON ACTION qbeclear   # 條件清除
            CLEAR FORM
            #add-point:條件清除後

            #end add-point
 
         #add-point:查詢方案相關ACTION設定後

         #end add-point
 
      END DIALOG 
   
   END WHILE
 
END FUNCTION
 
{</section>}
 
{<section id="anmq820.b_fill" >}
#+ 單身陣列填充
PRIVATE FUNCTION anmq820_b_fill()
   DEFINE ls_wc           STRING
   DEFINE l_pid           LIKE type_t.chr50
   #add-point:b_fill段define-標準
   DEFINE l_where         STRING
   #end add-point
   #add-point:b_fill段define-客製
   
   #end add-point
 
   #add-point:b_fill段sql_before
 
   #end add-point
 
   LET g_detail_idx  = 1
   LET g_detail_idx2 = 1
 
   IF cl_null(g_wc_filter) THEN
      LET g_wc_filter = " 1=1"
   END IF
   IF cl_null(g_wc) THEN
      LET g_wc = " 1=1"
   END IF
   IF cl_null(g_wc2) THEN
      LET g_wc2 = " 1=1"
   END IF
 
   LET ls_wc = g_wc, " AND ", g_wc2, " AND ", g_wc_filter
 
   CALL g_nmaa_d.clear()
 
   #add-point:陣列清空
   IF NOT cl_null(g_input.nmbxcomp) THEN
      LET l_where = "ooef017='",g_input.nmbxcomp,"'"
   ELSE
      LET l_where = " 1=1"
   END IF
   LET ls_wc = g_wc, " AND ", g_wc_filter, " AND ",l_where
   #end add-point
 
   LET g_cnt = l_ac
   LET l_ac = 1
 
   # b_fill段sql組成及FOREACH撰寫
   #應用 qs04 樣板自動產生(Version:2)
   #+ b_fill段資料取得(包含sql組成及FOREACH段撰寫)
   LET g_sql = "SELECT  UNIQUE '',nmaa001,nmaa002,'',nmaa003,'','','' FROM nmaa_t",
 
#table2
               " LEFT JOIN nmbx_t ON nmbxent = nmaaent AND nmaa001 = nmbxcomp AND  = nmbx001 AND  = nmbx002 AND  = nmbx003",
 
               "",
               " WHERE nmaaent= ? AND 1=1 AND ", ls_wc
 
   LET g_sql = g_sql, cl_sql_add_filter("nmaa_t"),
                      " ORDER BY nmaa_t.nmaa001"
 
   #add-point:b_fill段sql_after
   #160122-00001#29--add--str--
   LET ls_wc = ls_wc," AND nmas002 IN (",g_sql_bank,")"  #160122-00001#29 by 07900 -mod
   #160122-00001#29--add--end
   #因還要串nmas_t所以重寫SQL by Reanna 140807
   LET g_sql = "SELECT UNIQUE '',nmaa001,nmaa002,'',nmaa003,'',nmas002,nmas003",
               "  FROM nmaa_t",
               "  INNER JOIN nmas_t ON nmaaent = nmasent AND nmaa001 = nmas001",
               "  INNER JOIN ooef_t ON ooefent = nmaaent AND nmaa002 = ooef001",
               
               " WHERE nmaaent= ? AND ", ls_wc
   LET g_sql = g_sql, cl_sql_add_filter("nmaa_t"),
                      " ORDER BY nmaa_t.nmaa001"
   #end add-point
 
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   PREPARE anmq820_pb FROM g_sql
   DECLARE b_fill_curs CURSOR FOR anmq820_pb
 
   OPEN b_fill_curs USING g_enterprise
 
   FOREACH b_fill_curs INTO g_nmaa_d[l_ac].sel,g_nmaa_d[l_ac].nmaa001,g_nmaa_d[l_ac].nmaa002,g_nmaa_d[l_ac].nmaa002_desc, 
       g_nmaa_d[l_ac].nmaa003,g_nmaa_d[l_ac].nmaa003_desc,g_nmaa_d[l_ac].nmas002,g_nmaa_d[l_ac].nmas003 
 
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "FOREACH:" 
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = TRUE 
         CALL cl_err()
 
         EXIT FOREACH
      END IF
 
      
 
      #add-point:b_fill段資料填充
      CALL cl_set_comp_visible('sel',FALSE)  #150715-00014#2 隱藏選取標籤
      #end add-point
 
      CALL anmq820_detail_show("'1'")
 
      IF l_ac > g_max_rec THEN
         IF g_error_show = 1 THEN
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend =  "" 
            LET g_errparam.code   =  9035 
            LET g_errparam.popup  = TRUE 
            CALL cl_err()
 
         END IF
         EXIT FOREACH
      END IF
      LET l_ac = l_ac + 1
 
   END FOREACH
 
 
 
 
 
 
   #add-point:b_fill段資料填充(其他單身)
 
   #end add-point
 
   CALL g_nmaa_d.deleteElement(g_nmaa_d.getLength())
 
   #add-point:陣列長度調整
   CALL anmq820_insert_tmp() #150915-00008#6 填入單身2資料
   #end add-point
 
   LET g_error_show = 0
 
   LET g_detail_cnt = g_nmaa_d.getLength()
   DISPLAY g_detail_cnt TO FORMONLY.h_count
   LET g_detail_idx = 1
   DISPLAY g_detail_idx TO FORMONLY.h_index
   LET l_ac = g_cnt
   LET g_cnt = 0
 
   #應用 qs06 樣板自動產生(Version:2)
   #+ b_fill段CURSOR釋放
   CLOSE b_fill_curs
   FREE anmq820_pb
 
 
 
 
 
   LET l_ac = 1
   CALL anmq820_b_fill2()
 
      CALL anmq820_filter_show('nmaa001','b_nmaa001')
   CALL anmq820_filter_show('nmaa002','b_nmaa002')
   CALL anmq820_filter_show('nmaa003','b_nmaa003')
   CALL anmq820_filter_show('nmas002','b_nmas002')
   CALL anmq820_filter_show('nmas003','b_nmas003')
   CALL anmq820_filter_show('nmbx002','b_nmbx002')
   CALL anmq820_filter_show('nmbx103','b_nmbx103')
   CALL anmq820_filter_show('nmbx104','b_nmbx104')
   CALL anmq820_filter_show('nmbx113','b_nmbx113')
   CALL anmq820_filter_show('nmbx114','b_nmbx114')
   CALL anmq820_filter_show('nmbx123','b_nmbx123')
   CALL anmq820_filter_show('nmbx124','b_nmbx124')
   CALL anmq820_filter_show('nmbx133','b_nmbx133')
   CALL anmq820_filter_show('nmbx134','b_nmbx134')
 
 
END FUNCTION
 
{</section>}
 
{<section id="anmq820.b_fill2" >}
#+ 單身陣列填充2
PRIVATE FUNCTION anmq820_b_fill2()
   DEFINE li_ac           LIKE type_t.num10
   #add-point:b_fill2段define-標準
   DEFINE l_nmbx103       LIKE nmbx_t.nmbx103
   DEFINE l_nmbx104       LIKE nmbx_t.nmbx104
   DEFINE l_nmbx113       LIKE nmbx_t.nmbx113
   DEFINE l_nmbx114       LIKE nmbx_t.nmbx114
   DEFINE l_nmbx123       LIKE nmbx_t.nmbx123
   DEFINE l_nmbx124       LIKE nmbx_t.nmbx124
   DEFINE l_nmbx133       LIKE nmbx_t.nmbx133
   DEFINE l_nmbx134       LIKE nmbx_t.nmbx134
   #end add-point
   #add-point:b_fill2段define-客製

   #end add-point
 
   LET li_ac = l_ac
 
   #單身組成
   #應用 qs07 樣板自動產生(Version:2)
   #+ b_fill2段table資料取得(包含sql組成及資料填充)
#Page2
   CALL g_nmaa2_d.clear()
#Page3
   CALL g_nmaa3_d.clear()
 
   #add-point:陣列清空
   CALL g_nmaa2_d.clear()
   LET g_nmbxcomp = ''
   #end add-point
 
#table2
   #為避免影響執行效能，若是按上下筆就不重組SQL
   #IF g_action_choice <> "fetch" OR cl_null(g_action_choice) THEN    #2015/03/23---mark---
      LET g_sql = "SELECT  UNIQUE nmbx002,'',nmbx103,nmbx104,'','',nmbx113,nmbx114,'','','',nmbx123, 
          nmbx124,'','',nmbx133,nmbx134,'','' FROM nmbx_t",
                  "",
                  " WHERE nmbxent=? AND nmbx003=?"
  
      IF NOT cl_null(g_wc2_table2) THEN
         LET g_sql = g_sql CLIPPED," AND ",g_wc2_table2 CLIPPED
      END IF
  
      LET g_sql = g_sql, " ORDER BY nmbx_t.nmbxcomp,nmbx_t.nmbx001,nmbx_t.nmbx002,nmbx_t.nmbx003"
  
      #add-point:單身填充前
      #150915-00008#6-----s
      #單身2依起迄期別填入
      LET g_sql = " SELECT UNIQUE nmbx002,'',nmbx103,nmbx104,'','',nmbx113,nmbx114,'', ",
                  "               '','',nmbx123,nmbx124,'','',nmbx133,nmbx134,'',nmbxcomp ", 
                  ",nmde105 ",  #fengmy160514    
                  "   FROM anmq820_tmp01 ",         #160727-00019#4 Mod  anmq820_bfill_tmp--> anmq820_tmp01
                  "  WHERE nmbxent= ? AND nmas001= ? ",
                  "    AND nmbx003 = '",g_nmaa_d[g_detail_idx].nmas002,"' AND nmbx100 = '",g_nmaa_d[g_detail_idx].nmas003,"'",
                  "  ORDER BY nmbx002 "
      #150915-00008#6-----e
      
##150915-00008#6-----(s)MARK
#   #因SQL不需串nmbxcomp、nmbx001、nmbx003所以重寫SQL by Reanna 140801
#   LET g_sql = "SELECT UNIQUE nmbx002,'',nmbx103,nmbx104,'','',nmbx113,nmbx114,'',",
#               "              '','',nmbx123,nmbx124,'','',nmbx133,nmbx134,'',nmbxcomp",
#               "  FROM nmas_t,nmbx_t",
#               " WHERE nmasent = nmbxent AND nmas002 = nmbx003 ",
#               "   AND nmbxent=? AND nmas001=? AND nmbx002 > 0",
#               "   AND nmbx001 = '",g_input.nmbx001,"'",
#               "   AND nmbx003 = '",g_nmaa_d[g_detail_idx].nmas002,"' AND nmbx100 = '",g_nmaa_d[g_detail_idx].nmas003,"'",
#               " ORDER BY nmbx002"
##150915-00008#6-----(e)MARK
      #end add-point
 
      LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
      PREPARE anmq820_pb2 FROM g_sql
      DECLARE b_fill_curs2 CURSOR FOR anmq820_pb2
   #END IF                       #2015/03/23---mark---
 
   OPEN b_fill_curs2 USING g_enterprise,g_nmaa_d[g_detail_idx].nmaa001
 
   LET l_ac = 1
   FOREACH b_fill_curs2 INTO g_nmaa2_d[l_ac].nmbx002,g_nmaa2_d[l_ac].l_ori_begin,g_nmaa2_d[l_ac].nmbx103, 
                             g_nmaa2_d[l_ac].nmbx104,g_nmaa2_d[l_ac].l_ori_end,  g_nmaa2_d[l_ac].l_loc_begin,g_nmaa2_d[l_ac].nmbx113, 
                             g_nmaa2_d[l_ac].nmbx114,g_nmaa2_d[l_ac].l_loc_end,  g_nmaa3_d[l_ac].l_nmbx0022, g_nmaa3_d[l_ac].l_loc_begin2, 
                             g_nmaa3_d[l_ac].nmbx123,g_nmaa3_d[l_ac].nmbx124,    g_nmaa3_d[l_ac].l_loc_end2, g_nmaa3_d[l_ac].l_loc_begin3, 
                             g_nmaa3_d[l_ac].nmbx133,g_nmaa3_d[l_ac].nmbx134,    g_nmaa3_d[l_ac].l_loc_end3, g_nmaa3_d[l_ac].l_nmbxcomp,
                             g_nmaa2_d[l_ac].nmde105 #161207-00018#1 add 
 
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "FOREACH:" 
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = TRUE 
         CALL cl_err()
 
         EXIT FOREACH
      END IF
 
      
 
      #add-point:b_fill2段資料填充
      CALL cl_set_comp_visible('sel',FALSE)  #150715-00014#2 隱藏選取標籤
      LET g_nmbxcomp = g_nmaa3_d[l_ac].l_nmbxcomp
      #帳戶月統計------------------------------------------------------------------------------------------------------------
      IF l_ac = 1 THEN #第一筆先抓上一期餘額
         SELECT SUM(nmbx103),SUM(nmbx104),SUM(nmbx113),SUM(nmbx114)   #151002-00004#1 modify
           INTO l_nmbx103,l_nmbx104,l_nmbx113,l_nmbx114
           FROM nmbx_t
          WHERE nmbxent = g_enterprise
            AND nmbx001 = g_input.nmbx001  #150915-00008#6 加入年度條件
            AND nmbx003 = g_nmaa_d[g_detail_idx].nmas002 AND nmbx100 = g_nmaa_d[g_detail_idx].nmas003
            AND nmbx002 < g_nmaa2_d[1].nmbx002                        #151002-00004#1 modify
         IF cl_null(l_nmbx103) THEN LET l_nmbx103=0 END IF
         IF cl_null(l_nmbx104) THEN LET l_nmbx104=0 END IF
         IF cl_null(l_nmbx113) THEN LET l_nmbx113=0 END IF
         IF cl_null(l_nmbx114) THEN LET l_nmbx114=0 END IF
         #計算期初金額
         LET g_nmaa2_d[1].l_ori_begin = l_nmbx103-l_nmbx104 USING '-,---,---,---,--&.&&'
         LET g_nmaa2_d[1].l_loc_begin = l_nmbx113-l_nmbx114 USING '-,---,---,---,--&.&&'
         
         
         #151002-00004#1---MARK
#         IF g_nmaa2_d[1].nmbx002 = '1' THEN
#            LET g_nmaa2_d[1].l_ori_begin = 0 USING '-,---,---,---,--&.&&'
#            LET g_nmaa2_d[1].l_loc_begin = 0 USING '-,---,---,---,--&.&&'
#         END IF
         #151002-00004#1
      ELSE
         #計算期初金額
         LET g_nmaa2_d[l_ac].l_ori_begin = g_nmaa2_d[l_ac-1].l_ori_end USING '-,---,---,---,--&.&&'
         LET g_nmaa2_d[l_ac].l_loc_begin = g_nmaa2_d[l_ac-1].l_loc_end USING '-,---,---,---,--&.&&'
      END IF
      #計算結存金額
      LET g_nmaa2_d[l_ac].nmbx104=0-g_nmaa2_d[l_ac].nmbx104
      LET g_nmaa2_d[l_ac].nmbx114=0-g_nmaa2_d[l_ac].nmbx114
      LET g_nmaa2_d[l_ac].l_ori_end = g_nmaa2_d[l_ac].l_ori_begin+g_nmaa2_d[l_ac].nmbx103+g_nmaa2_d[l_ac].nmbx104
      #LET g_nmaa2_d[l_ac].l_loc_end = g_nmaa2_d[l_ac].l_loc_begin+g_nmaa2_d[l_ac].nmbx113+g_nmaa2_d[l_ac].nmbx114                        #161207-00018#1 add
      LET g_nmaa2_d[l_ac].l_loc_end = g_nmaa2_d[l_ac].l_loc_begin+g_nmaa2_d[l_ac].nmbx113+g_nmaa2_d[l_ac].nmbx114+g_nmaa2_d[l_ac].nmde105 #161207-00018#1 add
      LET g_nmaa2_d[l_ac].l_ori_end = g_nmaa2_d[l_ac].l_ori_end USING '-,---,---,---,--&.&&'
      LET g_nmaa2_d[l_ac].l_loc_end = g_nmaa2_d[l_ac].l_loc_end USING '-,---,---,---,--&.&&'
      #帳戶月統計 end--------------------------------------------------------------------------------------------------------
      #其他本位幣------------------------------------------------------------------------------------------------------------
      LET g_nmaa3_d[l_ac].l_nmbx0022=g_nmaa2_d[l_ac].nmbx002
      IF l_ac = 1 THEN #第一筆先抓上一期餘額
         SELECT SUM(nmbx123),SUM(nmbx124),SUM(nmbx133),SUM(nmbx134)  #151002-00004#1 modify
           INTO l_nmbx123,l_nmbx124,l_nmbx133,l_nmbx134
           FROM nmbx_t
          WHERE nmbxent = g_enterprise
            AND nmbx003 = g_nmaa_d[g_detail_idx].nmas002 AND nmbx100 = g_nmaa_d[g_detail_idx].nmas003
            AND nmbx002 < g_nmaa3_d[1].l_nmbx0022                    #151002-00004#1 modify
         IF cl_null(l_nmbx123) THEN LET l_nmbx123=0 END IF
         IF cl_null(l_nmbx124) THEN LET l_nmbx124=0 END IF
         IF cl_null(l_nmbx133) THEN LET l_nmbx133=0 END IF
         IF cl_null(l_nmbx134) THEN LET l_nmbx134=0 END IF
         #計算期初金額
         LET g_nmaa3_d[1].l_loc_begin2 = l_nmbx123-l_nmbx124
         LET g_nmaa3_d[1].l_loc_begin3 = l_nmbx133-l_nmbx134
         
#         #151002-00004#1 MARK
#         #若期別為第1期，期初給預設值
#         IF g_nmaa3_d[1].l_nmbx0022 = '1' THEN
#            LET g_nmaa3_d[1].l_loc_begin2 = 0 USING '-,---,---,---,--&.&&'
#            LET g_nmaa3_d[1].l_loc_begin3 = 0 USING '-,---,---,---,--&.&&'
#         END IF
#         #151002-00004#1 MARK
      ELSE
         #計算期初金額
         LET g_nmaa3_d[l_ac].l_loc_begin2 = g_nmaa3_d[l_ac-1].l_loc_end2
         LET g_nmaa3_d[l_ac].l_loc_begin3 = g_nmaa3_d[l_ac-1].l_loc_end3
      END IF
      #計算結存金額
      LET g_nmaa3_d[l_ac].nmbx124=0-g_nmaa3_d[l_ac].nmbx124
      LET g_nmaa3_d[l_ac].nmbx134=0-g_nmaa3_d[l_ac].nmbx134
      LET g_nmaa3_d[l_ac].l_loc_end2 = g_nmaa3_d[l_ac].l_loc_begin2+g_nmaa3_d[l_ac].nmbx123+g_nmaa3_d[l_ac].nmbx124
      LET g_nmaa3_d[l_ac].l_loc_end3 = g_nmaa3_d[l_ac].l_loc_begin3+g_nmaa3_d[l_ac].nmbx133+g_nmaa3_d[l_ac].nmbx134
      #其他本位幣 end--------------------------------------------------------------------------------------------------------

      #end add-point
 
      CALL anmq820_detail_show("'2'")
 
      IF l_ac > g_max_rec THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend =  "" 
         LET g_errparam.code   =  9035 
         LET g_errparam.popup  = TRUE 
         CALL cl_err()
 
         EXIT FOREACH
      END IF
      LET l_ac = l_ac + 1
 
   END FOREACH
 
 
#Page2
   CALL g_nmaa2_d.deleteElement(g_nmaa2_d.getLength())
#Page3
   CALL g_nmaa3_d.deleteElement(g_nmaa3_d.getLength())
 
   #add-point:陣列長度調整
 
   #end add-point
 
#Page2
   LET li_ac = g_nmaa2_d.getLength()
#Page3
   LET li_ac = g_nmaa3_d.getLength()
 
   DISPLAY li_ac TO FORMONLY.cnt
   LET g_detail_idx2 = 1
   DISPLAY g_detail_idx2 TO FORMONLY.idx
 
 
 
 
   #add-point:單身填充後
 
   #end add-point
 
   LET l_ac = li_ac
 
END FUNCTION
 
{</section>}
 
{<section id="anmq820.detail_show" >}
#+ 顯示相關資料
PRIVATE FUNCTION anmq820_detail_show(ps_page)
   DEFINE ps_page    STRING
   DEFINE ls_sql     STRING
   #add-point:show段define-標準
   
   #end add-point
   #add-point:show段define-客製
   
   #end add-point
 
   #add-point:detail_show段之前
 
   #end add-point
 
   
 
   #讀入ref值
   IF ps_page.getIndexOf("'1'",1) > 0 THEN
      #帶出公用欄位reference值page1
      
 
      #add-point:show段單身reference

            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_nmaa_d[l_ac].nmaa002
            LET ls_sql = "SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'"
            LET ls_sql = cl_sql_add_mask(ls_sql)              #遮蔽特定資料
            CALL ap_ref_array2(g_ref_fields,ls_sql,"") RETURNING g_rtn_fields
            LET g_nmaa_d[l_ac].nmaa002_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_nmaa_d[l_ac].nmaa002_desc

            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_nmaa_d[l_ac].nmaa003
            LET ls_sql = "SELECT nmagl003 FROM nmagl_t WHERE nmaglent='"||g_enterprise||"' AND nmagl001=? AND nmagl002='"||g_dlang||"'"
            LET ls_sql = cl_sql_add_mask(ls_sql)              #遮蔽特定資料
            CALL ap_ref_array2(g_ref_fields,ls_sql,"") RETURNING g_rtn_fields
            LET g_nmaa_d[l_ac].nmaa003_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_nmaa_d[l_ac].nmaa003_desc

      #end add-point
   END IF
 
   IF ps_page.getIndexOf("'2'",1) > 0 THEN
      #帶出公用欄位reference值page2
      
      #add-point:show段單身reference
      
      #end add-point
   END IF
 
   IF ps_page.getIndexOf("'3'",1) > 0 THEN
      #帶出公用欄位reference值page3
      
      #add-point:show段單身reference
      
      #end add-point
   END IF
 
 
 
   #add-point:detail_show段之後
   
   #end add-point
 
END FUNCTION
 
{</section>}
 
{<section id="anmq820.filter" >}
#應用 qs13 樣板自動產生(Version:3)
#+ filter段相關程式段
#+ filter過濾功能
PRIVATE FUNCTION anmq820_filter()
   {<Local define>}
   {</Local define>}
   #add-point:filter段define-標準
   
   #end add-point
   #add-point:filter段define-客製
   
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
   #應用 qs08 樣板自動產生(Version:4)
   #+ filter段DIALOG段的組成
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
 
      #單頭
      CONSTRUCT g_wc_filter ON nmaa001,nmaa002,nmaa003,nmas002,nmas003
                          FROM s_detail1[1].b_nmaa001,s_detail1[1].b_nmaa002,s_detail1[1].b_nmaa003, 
                              s_detail1[1].b_nmas002,s_detail1[1].b_nmas003
 
         BEFORE CONSTRUCT
                     DISPLAY anmq820_filter_parser('nmaa001') TO s_detail1[1].b_nmaa001
            DISPLAY anmq820_filter_parser('nmaa002') TO s_detail1[1].b_nmaa002
            DISPLAY anmq820_filter_parser('nmaa003') TO s_detail1[1].b_nmaa003
            DISPLAY anmq820_filter_parser('nmas002') TO s_detail1[1].b_nmas002
            DISPLAY anmq820_filter_parser('nmas003') TO s_detail1[1].b_nmas003
 
 
         #單身公用欄位開窗相關處理
         
 
         #單身一般欄位開窗相關處理
                  #----<<sel>>----
         #----<<b_nmaa001>>----
         #Ctrlp:construct.c.filter.page1.b_nmaa001
         #應用 a03 樣板自動產生(Version:2)
         ON ACTION controlp INFIELD b_nmaa001
            #add-point:ON ACTION controlp INFIELD b_nmaa001
            
            #END add-point
 
         #----<<b_nmaa002>>----
         #Ctrlp:construct.c.filter.page1.b_nmaa002
         #應用 a03 樣板自動產生(Version:2)
         ON ACTION controlp INFIELD b_nmaa002
            #add-point:ON ACTION controlp INFIELD b_nmaa002
            
            #END add-point
 
         #----<<b_nmaa002_desc>>----
         #----<<b_nmaa003>>----
         #Ctrlp:construct.c.filter.page1.b_nmaa003
         #應用 a03 樣板自動產生(Version:2)
         ON ACTION controlp INFIELD b_nmaa003
            #add-point:ON ACTION controlp INFIELD b_nmaa003
            
            #END add-point
 
         #----<<b_nmaa003_desc>>----
         #----<<b_nmas002>>----
         #Ctrlp:construct.c.filter.page1.b_nmas002
         #應用 a03 樣板自動產生(Version:2)
         ON ACTION controlp INFIELD b_nmas002
            #add-point:ON ACTION controlp INFIELD b_nmas002
            
            #END add-point
 
         #----<<b_nmas003>>----
         #Ctrlp:construct.c.page1.b_nmas003
         #應用 a03 樣板自動產生(Version:2)
         ON ACTION controlp INFIELD b_nmas003
            #add-point:ON ACTION controlp INFIELD b_nmas003
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooai001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_nmas003  #顯示到畫面上
            NEXT FIELD b_nmas003                     #返回原欄位
    


            #END add-point
 
 
 
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
      LET g_wc_filter = g_wc_filter, " "
   ELSE
      LET g_wc_filter = g_wc_filter_t
   END IF
 
      CALL anmq820_filter_show('nmaa001','b_nmaa001')
   CALL anmq820_filter_show('nmaa002','b_nmaa002')
   CALL anmq820_filter_show('nmaa003','b_nmaa003')
   CALL anmq820_filter_show('nmas002','b_nmas002')
   CALL anmq820_filter_show('nmas003','b_nmas003')
   CALL anmq820_filter_show('nmbx002','b_nmbx002')
   CALL anmq820_filter_show('nmbx103','b_nmbx103')
   CALL anmq820_filter_show('nmbx104','b_nmbx104')
   CALL anmq820_filter_show('nmbx113','b_nmbx113')
   CALL anmq820_filter_show('nmbx114','b_nmbx114')
   CALL anmq820_filter_show('nmbx123','b_nmbx123')
   CALL anmq820_filter_show('nmbx124','b_nmbx124')
   CALL anmq820_filter_show('nmbx133','b_nmbx133')
   CALL anmq820_filter_show('nmbx134','b_nmbx134')
 
 
   CALL anmq820_b_fill()
 
   CALL gfrm_curr.setFieldHidden("formonly.sel", FALSE)
   CALL gfrm_curr.setFieldHidden("formonly.b_statepic", FALSE)
 
END FUNCTION
 
{</section>}
 
{<section id="anmq820.filter_parser" >}
#應用 qs14 樣板自動產生(Version:3)
#+ filter pasara段
#+ filter欄位解析
PRIVATE FUNCTION anmq820_filter_parser(ps_field)
   {<Local define>}
   DEFINE ps_field   STRING
   DEFINE ls_tmp     STRING
   DEFINE li_tmp     LIKE type_t.num5
   DEFINE li_tmp2    LIKE type_t.num5
   DEFINE ls_var     STRING
   {</Local define>}
   #add-point:filter段define-標準
   
   #end add-point
   #add-point:filter段define-客製
   
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
 
{<section id="anmq820.filter_show" >}
#應用 qs15 樣板自動產生(Version:3)
#+ filter標題欄位顯示搜尋條件
PRIVATE FUNCTION anmq820_filter_show(ps_field,ps_object)
   DEFINE ps_field         STRING
   DEFINE ps_object        STRING
   DEFINE lnode_item       om.DomNode
   DEFINE ls_title         STRING
   DEFINE ls_name          STRING
   DEFINE ls_condition     STRING
   #add-point:filter_show段define-標準
   
   #end add-point
   #add-point:filter_show段define-客製
   
   #end add-point
 
   LET ls_name = "formonly.", ps_object
 
 
   LET lnode_item = gfrm_curr.findNode("TableColumn", ls_name)
   LET ls_title = lnode_item.getAttribute("text")
   IF ls_title.getIndexOf('※',1) > 0 THEN
      LET ls_title = ls_title.subString(1,ls_title.getIndexOf('※',1)-1)
   END IF
 
   #顯示資料組合
   LET ls_condition = anmq820_filter_parser(ps_field)
   IF NOT cl_null(ls_condition) THEN
      LET ls_title = ls_title, '※', ls_condition, '※'
   END IF
 
   #將資料顯示回去
   CALL lnode_item.setAttribute("text",ls_title)
 
END FUNCTION
 
 
{</section>}
 
{<section id="anmq820.other_function" readonly="Y" >}

################################################################################
# Descriptions...: 建立临时表
# Memo...........:
# Usage..........: CALL anmq820_create_temp_table()
# Date & Author..: 2015/03/23 By 03273
# Modify.........:
################################################################################
PRIVATE FUNCTION anmq820_create_temp_table()
   DROP TABLE anmq820_xg_tmp;
   CREATE TEMP TABLE anmq820_xg_tmp(
   seq          LIKE type_t.num10,
   nmbxent      LIKE nmbx_t.nmbxent,
   nmbx003      LIKE nmbx_t.nmbx003,
   nmbx100      LIKE nmbx_t.nmbx100,
   nmbxcomp     LIKE nmbx_t.nmbxcomp,
   glaa001      LIKE glaa_t.glaa001,
   nmbx002      LIKE nmbx_t.nmbx002,
   l_ori_begin  LIKE nmbx_t.nmbx103, 
   nmbx103      LIKE nmbx_t.nmbx103, 
   nmbx104      LIKE nmbx_t.nmbx104, 
   l_ori_end    LIKE nmbx_t.nmbx103, 
   l_loc_begin  LIKE nmbx_t.nmbx113, 
   nmbx113      LIKE nmbx_t.nmbx113, 
   nmbx114      LIKE nmbx_t.nmbx114, 
   l_loc_end    LIKE nmbx_t.nmbx113
   )
   
   #150915-00008#6-----s
   #填充單身用 
   DROP TABLE anmq820_tmp01;             #160727-00019#4 Mod  anmq820_bfill_tmp--> anmq820_tmp01 
   CREATE TEMP TABLE anmq820_tmp01(      #160727-00019#4 Mod  anmq820_bfill_tmp--> anmq820_tmp01
      nmbxent      LIKE nmbx_t.nmbxent,
      nmas001      LIKE nmas_t.nmas001,
      nmbx002      LIKE nmbx_t.nmbx002,
      nmbx003      LIKE nmbx_t.nmbx003, 
      nmbx100      LIKE nmbx_t.nmbx100, 
      nmbx103      LIKE nmbx_t.nmbx103, 
      nmbx104      LIKE nmbx_t.nmbx104, 
      nmbx113      LIKE nmbx_t.nmbx113, 
      nmbx114      LIKE nmbx_t.nmbx114,  
      nmbx123      LIKE nmbx_t.nmbx123, 
      nmbx124      LIKE nmbx_t.nmbx124, 
      nmbx133      LIKE nmbx_t.nmbx133, 
      nmbx134      LIKE nmbx_t.nmbx134,
      nmde105      LIKE nmde_t.nmde105,   #fengmy160514 add
      nmbxcomp     LIKE nmbx_t.nmbxcomp
      ) 
      #150915-00008#6-----e
      
END FUNCTION

################################################################################
# Descriptions...: 打印
# Memo...........:
# Usage..........: CALL anmq820_print()
# Date & Author..: 2015/03/23 By 03273
# Modify.........:
################################################################################
PRIVATE FUNCTION anmq820_print()
   DEFINE l_i         LIKE type_t.num10
   DEFINE l_j         LIKE type_t.num10
   DEFINE l_n         LIKE type_t.num10
   DEFINE l_glaa001   LIKE glaa_t.glaa001
   
   IF g_nmaa_d.getLength() <= 0 THEN
      RETURN
   END IF
   
   LET l_glaa001 = NULL
   SELECT glaa001 INTO l_glaa001 FROM glaa_t
    WHERE glaaent = g_enterprise AND glaacomp = g_input.nmbxcomp AND glaa014 = 'Y'
    
   LET l_n = 0
   #將所需資料插入臨時表
   DELETE FROM anmq820_xg_tmp;
   
   FOR l_i = 1 TO g_nmaa_d.getLength()
      LET g_detail_idx = l_i
      CALL anmq820_b_fill2()
      FOR l_j = 1 TO g_nmaa2_d.getLength()
         LET l_n = l_n + 1
         INSERT INTO anmq820_xg_tmp VALUES ( 
         l_n,g_enterprise,g_nmaa_d[l_i].nmas002,g_nmaa_d[l_i].nmas003,g_input.nmbxcomp,l_glaa001,
         g_nmaa2_d[l_j].nmbx002,g_nmaa2_d[l_j].l_ori_begin,g_nmaa2_d[l_j].nmbx103,g_nmaa2_d[l_j].nmbx104,
         g_nmaa2_d[l_j].l_ori_end,g_nmaa2_d[l_j].l_loc_begin,g_nmaa2_d[l_j].nmbx113,g_nmaa2_d[l_j].nmbx114,
         g_nmaa2_d[l_j].l_loc_end)   
      END FOR
   END FOR 
   CALL anmq820_x01('anmq820_xg_tmp',' 1=1')

END FUNCTION

################################################################################
# Descriptions...: 填充單身
# Memo...........: #150915-00008#6
# Usage..........: CALL anmq820_insert_tmp()
# Date & Author..: 150917 By Jessy
# Modify.........:
################################################################################
PRIVATE FUNCTION anmq820_insert_tmp()
DEFINE l_sql    STRING
DEFINE l_i      LIKE type_t.num10 #detl1_cnt
DEFINE l_j      LIKE type_t.num10 #strmon
DEFINE l_tmp    RECORD
   nmbxent      LIKE nmbx_t.nmbxent,
   nmas001      LIKE nmas_t.nmas001,
   nmbx002      LIKE nmbx_t.nmbx002, 
   nmbx003      LIKE nmbx_t.nmbx003, 
   nmbx100      LIKE nmbx_t.nmbx100, 
   nmbx103      LIKE nmbx_t.nmbx103, 
   nmbx104      LIKE nmbx_t.nmbx104, 
   nmbx113      LIKE nmbx_t.nmbx113, 
   nmbx114      LIKE nmbx_t.nmbx114, 
   nmbx123      LIKE nmbx_t.nmbx123, 
   nmbx124      LIKE nmbx_t.nmbx124, 
   nmbx133      LIKE nmbx_t.nmbx133, 
   nmbx134      LIKE nmbx_t.nmbx134,
   nmde105      LIKE nmde_t.nmde105,   #fengmy160514
   nmbxcomp     LIKE nmbx_t.nmbxcomp
                END RECORD

   
   DELETE FROM anmq820_tmp01        #160727-00019#4 Mod  anmq820_bfill_tmp--> anmq820_tmp01
   
   #160819-00016#1 mod--s 可能有多个据点对应同个法人
   #LET l_sql = "SELECT UNIQUE nmbxent,nmas001,nmbx002,nmbx003,nmbx100,nmbx103,nmbx104,nmbx113,nmbx114, ",
   #            "              nmbx123,nmbx124,nmbx133,nmbx134,nmde105,nmbxcomp ",  #160819-00016#1 mod add nmde105
   LET l_sql = "SELECT UNIQUE nmbxent,nmas001,nmbx002,nmbx003,nmbx100,SUM(nmbx103),SUM(nmbx104),SUM(nmbx113),SUM(nmbx114), ",
               "              SUM(nmbx123),SUM(nmbx124),SUM(nmbx133),SUM(nmbx134),SUM(nmde105),nmbxcomp ",  #160819-00016#1 mod add nmde105
   #160819-00016#1 mod--e
               "  FROM nmas_t,nmbx_t ",
               "  LEFT JOIN nmde_t ON nmbxent = nmdeent AND nmbxcomp = nmdecomp AND nmbx001 = nmde001 AND nmbx002 = nmde002 ",  #fengmy160514 
               "   AND nmde003 = 'NM' AND nmde004 = nmbx003 ",  #fengmy160514",             
               " WHERE nmasent = nmbxent AND nmas002 = nmbx003 ",
               "   AND nmbxent= '",g_enterprise,"' AND nmas001= ? ",
               "   AND nmbx001 = '",g_input.nmbx001,"' ",
               "   AND nmbx002 = ? ",
               "   AND nmbx003 = ? AND nmbx100 = ? ",
               "   AND nmbxcomp =  '",g_input.nmbxcomp,"' ",  #160816-00053#1 add
               " GROUP BY nmbxent,nmas001,nmbx002,nmbx003,nmbx100, nmbxcomp ",  #160819-00016#1 add
               " ORDER BY nmbx002 "
               
   PREPARE anmq820_pr1 FROM l_sql
   FOR l_i = 1 TO g_nmaa_d.getLength()
      FOR l_j = g_input.strmon TO g_input.endmon
         INITIALIZE l_tmp.* TO NULL
         EXECUTE anmq820_pr1 INTO l_tmp.*
         USING g_nmaa_d[l_i].nmaa001,l_j,g_nmaa_d[l_i].nmas002,g_nmaa_d[l_i].nmas003
         #160816-00053#1 add--s
         IF SQLCA.sqlcode AND SQLCA.sqlcode!=100 THEN
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "FOREACH:" ,g_nmaa_d[l_i].nmaa001
            LET g_errparam.code   = SQLCA.sqlcode 
            LET g_errparam.popup  = TRUE 
            CALL cl_err()
         END IF
         #160816-00053#1 add--e
         LET l_tmp.nmbxent = g_enterprise
         LET l_tmp.nmas001 = g_nmaa_d[l_i].nmaa001
         LET l_tmp.nmbx002 = l_j
         LET l_tmp.nmbx003 = g_nmaa_d[l_i].nmas002
         LET l_tmp.nmbx100 = g_nmaa_d[l_i].nmas003
         LET l_tmp.nmbxcomp = g_input.nmbxcomp
         IF cl_null(l_tmp.nmbx103) THEN LET l_tmp.nmbx103 = 0 END IF
         IF cl_null(l_tmp.nmbx104) THEN LET l_tmp.nmbx104 = 0 END IF
         IF cl_null(l_tmp.nmbx113) THEN LET l_tmp.nmbx113 = 0 END IF
         IF cl_null(l_tmp.nmbx114) THEN LET l_tmp.nmbx114 = 0 END IF
         IF cl_null(l_tmp.nmbx123) THEN LET l_tmp.nmbx123 = 0 END IF
         IF cl_null(l_tmp.nmbx124) THEN LET l_tmp.nmbx124 = 0 END IF
         IF cl_null(l_tmp.nmbx133) THEN LET l_tmp.nmbx133 = 0 END IF
         IF cl_null(l_tmp.nmbx134) THEN LET l_tmp.nmbx134 = 0 END IF
         IF cl_null(l_tmp.nmde105) THEN LET l_tmp.nmde105 = 0 END IF  #161207-00018#1 add 
         INSERT INTO anmq820_tmp01 VALUES(l_tmp.*)             #160727-00019#4 Mod  anmq820_bfill_tmp--> anmq820_tmp01
      END FOR
   END FOR

END FUNCTION

 
{</section>}
 
