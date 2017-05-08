#該程式已解開Section, 不再透過樣板產出!
{<section id="aglq760.description" >}
#+ Version..: T100-ERP-1.00.00(版次:1) Build-000081
#+ 
#+ Filename...: aglq760
#+ Description: 明細分類帳查詢作業
#+ Creator....: 02599(2014/03/27)
#+ Modifier...: 02599(2014/03/28)
#+ Buildtype..: 應用 q02 樣板自動產生
#+ 以上段落由子樣板a00產生
 
{</section>}
 
{<section id="aglq760.global" >}
#151231-00004#1    2015/12/31   By 02599   期初金额算法错误，改成当破期时抓取年期金额 + 抓取起始年期第一天到起始日期前一天的凭证金额
#151204-00013#6    2016/01/12   By 02599   当未勾选‘含月结凭证’是，要排除CE凭证中科目属性为6.损益类科目和XC凭证中科目属性为5.成本类科目
#160302-00006#1    2016/03/02   By 07675   原本单身为可查询作业，增加二次筛选功能 
#160503-00037#6    2016/05/09   By 07900   本年累计数不应含期初第0期的数据
#160511-00006#3    2016/05/11   By 02599   期初只显示余额，借方金额、贷方金额不显示；本年累计的余额=本年累计+年初余额
#160505-00007#16   2016/06/07   By 02599   程式优化
#160824-00004#2    2016/08/31   By 02599   排除XC凭证时限定科目费用类别glac010<>N.非费用科目
#160914-00030#1    2016/09/18   By 02599   本期合计余额字段,原本有包含期初余额，现逻辑改为借-貨,不包含期初余额,因為是本期明細表達
#160824-00004#4    2016/09/23   By 02599   排除XC类凭证时，继续增加条件：来源单据的成本凭证类型(xcea002)<>(7 OR 9)
#161011-00018#1    2016/10/14   By 02599   去除 first next last jump previous 这些action的权限检核
#161027-00022#1    2016/10/27   By 02599   含月结凭证=N时，在排除XC凭证时，增加条件：来源成本单据的成本类型(xrea002)=9 and 科目对应的费用类别(glac010)=费用类型。
#161125-00012#1    2017/01/22   By 02599   增加统治科目查询
#170214-00018#1    2017/02/14   By 02599   抓取明细SQL语句去除g_wc中科目条件
#170216-00033#1    2017/02/17   By 02599   勾选显示原币时，增加抓取余额档0期的币别
 
IMPORT os
IMPORT util
#add-point:增加匯入項目

#end add-point
 
SCHEMA ds
 
GLOBALS "../../cfg/top_global.inc"
 
#add-point:增加匯入變數檔

#end add-point
 
#單身 type 宣告
PRIVATE TYPE type_g_glaq_d RECORD
       #statepic       LIKE type_t.chr1,
       sel            LIKE type_t.chr1,
       glaq002 LIKE glaq_t.glaq002, 
   glaq002_desc LIKE type_t.chr500,
   glaqdocno LIKE glap_t.glapdocno,
   glapdocdt LIKE glap_t.glapdocdt,
   glap004 LIKE glap_t.glap004, 
   glaq001 LIKE glaq_t.glaq001,
   style LIKE type_t.chr80, 
   glaq005 LIKE glaq_t.glaq005, 
   glaq006 LIKE glaq_t.glaq006, 
   glaq010d LIKE glaq_t.glaq010, 
   glaq010c LIKE glaq_t.glaq010, 
   glaq003 LIKE glaq_t.glaq003, 
   glaq004 LIKE glaq_t.glaq004, 
   glaq039 LIKE glaq_t.glaq039, 
   glaq040 LIKE glaq_t.glaq040, 
   glaq041 LIKE glaq_t.glaq041, 
   glaq042 LIKE glaq_t.glaq042, 
   glaq043 LIKE glaq_t.glaq043, 
   glaq044 LIKE glaq_t.glaq044, 
   state LIKE type_t.chr80, 
   amt LIKE glaq_t.glaq003, 
   amt1 LIKE glaq_t.glaq003, 
   amt2 LIKE glaq_t.glaq003, 
   amt3 LIKE glaq_t.glaq003 
       END RECORD
 
 
#模組變數(Module Variables)
DEFINE g_master                     type_g_glaq_d
DEFINE g_master_t                   type_g_glaq_d
DEFINE g_glaq_d          DYNAMIC ARRAY OF type_g_glaq_d
DEFINE g_glaq_d_t        type_g_glaq_d
 
      
DEFINE g_wc                 STRING
DEFINE g_wc_t               STRING                        #儲存 user 的查詢條件
DEFINE g_wc2                STRING
DEFINE g_wc_filter          STRING
DEFINE g_wc_filter_t        STRING
DEFINE g_sql                STRING
DEFINE g_forupd_sql         STRING                        #SELECT ... FOR UPDATE SQL
DEFINE g_before_input_done  LIKE type_t.num5
DEFINE g_cnt                LIKE type_t.num10    
DEFINE l_ac                 LIKE type_t.num5              
DEFINE l_ac_d               LIKE type_t.num5              #單身idx 
DEFINE g_curr_diag          ui.Dialog                     #Current Dialog
DEFINE gwin_curr            ui.Window                     #Current Window
DEFINE gfrm_curr            ui.Form                       #Current Form
DEFINE g_current_page       LIKE type_t.num5              #目前所在頁數
DEFINE g_detail_cnt         LIKE type_t.num5              #單身 總筆數(所有資料)
DEFINE g_ref_fields         DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
DEFINE g_rtn_fields         DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
DEFINE g_ref_vars           DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
DEFINE gs_keys              DYNAMIC ARRAY OF VARCHAR(500) #同步資料用陣列
DEFINE gs_keys_bak          DYNAMIC ARRAY OF VARCHAR(500) #同步資料用陣列
DEFINE g_insert             LIKE type_t.chr5              #是否導到其他page
DEFINE g_error_show         LIKE type_t.num5
DEFINE g_master_idx         LIKE type_t.num5
DEFINE g_detail_idx         LIKE type_t.num5
DEFINE g_detail_idx2        LIKE type_t.num5
DEFINE g_hyper_url          STRING                        #hyperlink的主要網址
 
 
#多table用wc
DEFINE g_wc_table           STRING
 
 
 
DEFINE g_wc_filter_table           STRING
 
 
 
 
#add-point:自定義模組變數(Module Variable)
#依据当前账别，抓取账别所归属的法人，使用币别，汇率参照表号，会计科目参照表号
DEFINE g_bookno        LIKE glap_t.glapld
DEFINE g_glaald        LIKE glaa_t.glaald
DEFINE g_glaald_desc   LIKE glaal_t.glaal002
DEFINE g_glaacomp      LIKE glaa_t.glaacomp
DEFINE g_glaacomp_desc LIKE ooefl_t.ooefl003
DEFINE g_glaa001       LIKE glaa_t.glaa001
DEFINE g_glaa002       LIKE glaa_t.glaa002
DEFINE g_glaa003       LIKE glaa_t.glaa003
DEFINE g_glaa004       LIKE glaa_t.glaa004
DEFINE g_glaa013       LIKE glaa_t.glaa013
DEFINE g_glaa015       LIKE glaa_t.glaa015
DEFINE g_glaa016       LIKE glaa_t.glaa016
DEFINE g_glaa017       LIKE glaa_t.glaa017
DEFINE g_glaa018       LIKE glaa_t.glaa018
DEFINE g_glaa019       LIKE glaa_t.glaa019
DEFINE g_glaa020       LIKE glaa_t.glaa020
DEFINE g_glaa021       LIKE glaa_t.glaa021
DEFINE g_glaa022       LIKE glaa_t.glaa022
#查询条件定义
DEFINE tm              RECORD
       sdate           LIKE glap_t.glapdocdt,  #起始日期
       syear           LIKE glap_t.glap002,    #起始年度
       speriod         LIKE glap_t.glap004,    #起始期別
       edate           LIKE glap_t.glapdocdt,  #截止日期
       eyear           LIKE glap_t.glap002,    #截止年度
       eperiod         LIKE glap_t.glap004,    #截止期別
       ctype           LIKE type_t.chr1,       #多本位幣
       curr_o          LIKE type_t.chr1, 
       curr_p          LIKE type_t.chr1, 
       acc_p           LIKE type_t.chr1, 
       show_acc        LIKE type_t.chr1, 
       glac005	       LIKE glac_t.glac005,
       stus            LIKE type_t.chr1,
       glac009	       LIKE glac_t.glac009,
       show_ad         LIKE type_t.chr1,
       show_ce         LIKE type_t.chr1,
       show_ye         LIKE type_t.chr1
       END RECORD
DEFINE g_wc1           STRING
DEFINE g_glaq002       LIKE glaq_t.glaq002
DEFINE g_glaq005       LIKE glaq_t.glaq005
DEFINE g_glaq_s        DYNAMIC ARRAY OF RECORD    #資料瀏覽之欄位 
       glaq002         LIKE glaq_t.glaq002, 
       glaq005         LIKE glaq_t.glaq005
      END RECORD 
DEFINE g_current_row   LIKE type_t.num5 
DEFINE g_current_idx   LIKE type_t.num10     
DEFINE g_jump          LIKE type_t.num10        
DEFINE g_no_ask        LIKE type_t.num5  
DEFINE g_rec_b         LIKE type_t.num5
DEFINE g_argv_flag     LIKE type_t.num5    #標示是否是串查
#DEFINE g_param type_g_glaq_d
#end add-point
 
#add-point:傳入參數說明
 TYPE type_g_glfb_e RECORD
       v          STRING
       END RECORD
DEFINE g_param                     type_g_glfb_e     
#end add-point
 
{</section>}
 
{<section id="aglq760.main" >}
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
   CALL cl_ap_init("agl","")
 
   #add-point:作業初始化
   
   #end add-point
   
   
   
 
   #LOCK CURSOR (identifier)
   #add-point:SQL_define
   
   #end add-point
   LET g_forupd_sql = ""
   #add-point:SQL_define
   
   #end add-point
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)                #轉換不同資料庫語法
   DECLARE aglq760_cl CURSOR FROM g_forupd_sql                 # LOCK CURSOR
 
   LET g_sql = " SELECT UNIQUE ",
               " FROM ",
               " WHERE  "
   #add-point:SQL_define
   
   #end add-point
   PREPARE aglq760_master_referesh FROM g_sql
 
   IF g_bgjob = "Y" THEN
 
      #add-point:Service Call
      
      #end add-point
 
   ELSE
      
      #畫面開啟 (identifier)
      OPEN WINDOW w_aglq760 WITH FORM cl_ap_formpath("agl",g_code)
   
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
   
      #程式初始化
      CALL aglq760_init()   
 
      #進入選單 Menu (="N")
      CALL aglq760_ui_dialog() 
      
      #add-point:畫面關閉前
      
      #end add-point
 
      #畫面關閉
      CLOSE WINDOW w_aglq760
      
   END IF 
   
   CLOSE aglq760_cl
   
   
 
   #add-point:作業離開前
   DROP TABLE aglq760_tmp
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
   
END MAIN
 
 
 
{</section>}
 
{<section id="aglq760.init" >}
#+ 畫面資料初始化
PRIVATE FUNCTION aglq760_init()
   #add-point:init段define
   DEFINE l_success   LIKE type_t.num5
   DEFINE l_pass      LIKE type_t.num5
   #end add-point   
   
   LET g_error_show  = 1
   LET g_wc_filter   = " 1=1"
   LET g_wc_filter_t = " 1=1"
   
   
   
   #add-point:畫面資料初始化
   LET g_detail_idx  = 1
   CALL cl_set_combo_scc('stus','9922')
   CALL cl_set_combo_scc('state','9926')
   CALL cl_set_combo_scc('style','9927')
   
   #抓取傳參
   CALL aglq760_default_search()
   
   #获取账别
   IF cl_null(g_glaald) THEN
      CALL s_ld_bookno()  RETURNING l_success,g_glaald
      IF l_success = FALSE THEN
         RETURN 
      END IF 
      CALL s_ld_chk_authorization(g_user,g_glaald) RETURNING l_pass
      IF l_pass = FALSE THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = 'agl-00164'
         LET g_errparam.extend = g_glaald
         LET g_errparam.popup = TRUE
         CALL cl_err()

         RETURN
      END IF
   END IF      
   CALL aglq760_glaald_desc(g_glaald)
   IF cl_null(g_argv[01]) THEN
      LET g_argv_flag = FALSE
      CALL aglq760_set_default_value()
   ELSE
      LET g_argv_flag = TRUE
      SELECT MIN(glav004) INTO tm.sdate FROM glav_t 
       WHERE glavent=g_enterprise AND glav001=g_glaa003 AND glav002=tm.syear AND glav006=tm.speriod
      SELECT MAX(glav004) INTO tm.edate FROM glav_t 
       WHERE glavent=g_enterprise AND glav001=g_glaa003 AND glav002=tm.eyear AND glav006=tm.eperiod
   END IF
   #建立临时表
   CALL aglq760_create_temp_table()
   #end add-point
   
END FUNCTION
 
{</section>}
 
{<section id="aglq760.ui_dialog" >}
#+ 功能選單 
PRIVATE FUNCTION aglq760_ui_dialog()
   {<Local define>}
   DEFINE li_idx   LIKE type_t.num5
   {</Local define>}
   #add-point:ui_dialog段define

   DEFINE l_string STRING
   #end add-point 
 
   LET gwin_curr = ui.Window.getCurrent()
   LET gfrm_curr = gwin_curr.getForm()   
   
   LET g_action_choice = " "  
   CALL cl_set_act_visible("accept,cancel", FALSE)
         
   #add-point:ui_dialog段before dialog 

   #end add-point
   
   CALL aglq760_query()
   
   WHILE TRUE
   
      DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
         DISPLAY ARRAY g_glaq_d TO s_detail1.* ATTRIBUTE(COUNT=g_detail_cnt) 
      
            BEFORE DISPLAY 
               LET g_current_page = 1
 
            BEFORE ROW
               LET g_detail_idx = DIALOG.getCurrentRow("s_detail1")
               LET l_ac = g_detail_idx
               DISPLAY g_detail_idx TO FORMONLY.h_index
               DISPLAY g_glaq_d.getLength() TO FORMONLY.h_count
               LET g_master_idx = l_ac
               CALL aglq760_fetch()
               #add-point:input段before row
               DISPLAY g_current_idx TO FORMONLY.h_index
               DISPLAY g_glaq_s.getLength() TO FORMONLY.h_count
               DISPLAY g_detail_idx TO FORMONLY.idx
               DISPLAY g_glaq_d.getLength() TO FORMONLY.cnt
               #end add-point  
            
            #自訂ACTION(detail_show,page_1)
            
               
         END DISPLAY
      
 
         
 
      
         #add-point:ui_dialog段define

         #end add-point
         
         BEFORE DIALOG      
            CALL DIALOG.setSelectionMode("s_detail1", 1)
 
            #add-point:ui_dialog段before dialog
            IF g_header_cnt=1 THEN
               CALL cl_set_act_visible("first,previous,jump,next,last",FALSE) 
            ELSE
               IF g_current_idx=1 THEN
                  CALL cl_set_act_visible("first,previous", FALSE) 
                  CALL cl_set_act_visible("jump,next,last", TRUE) 
               ELSE
                  IF g_current_idx<>g_header_cnt THEN
                     CALL cl_set_act_visible("first,previous,jump,next,last",TRUE) 
                  ELSE
                     CALL cl_set_act_visible("first,previous,jump",TRUE) 
                     CALL cl_set_act_visible("next,last", FALSE) 
                  END IF
               END IF
            END IF
            CALL gfrm_curr.setFieldHidden("formonly.sel", TRUE)
            #end add-point
 
            NEXT FIELD sel
      
         
 
         ON ACTION previous
 
            LET g_action_choice="fetch" #161011-00018#1 mod previous-->fetch
#            IF cl_auth_chk_act("previous") THEN  #161011-00018#1 mark
               #add-point:ON ACTION previous
               CALL aglq760_fetch1('P')
               LET g_current_row = g_current_idx
               LET g_curr_diag = ui.DIALOG.getCurrent()
               #END add-point
               EXIT DIALOG
#            END IF #161011-00018#1 mark
 
 
         ON ACTION first
 
            LET g_action_choice="fetch" #161011-00018#1 mod first-->fetch
#            IF cl_auth_chk_act("first") THEN  #161011-00018#1 mark 
               #add-point:ON ACTION first
               CALL aglq760_fetch1('F')
               LET g_current_row = g_current_idx
               LET g_curr_diag = ui.DIALOG.getCurrent()
               #END add-point
               EXIT DIALOG
#            END IF #161011-00018#1 mark
 
 
         ON ACTION next
 
            LET g_action_choice="fetch" #161011-00018#1 mod next-->fetch
#            IF cl_auth_chk_act("next") THEN  #161011-00018#1 mark 
               #add-point:ON ACTION next
               CALL aglq760_fetch1('N')
               LET g_current_row = g_current_idx
               LET g_curr_diag = ui.DIALOG.getCurrent()
               #END add-point
               EXIT DIALOG
#            END IF #161011-00018#1 mark
 
 
         ON ACTION exchange_ld
 
            LET g_action_choice="exchange_ld"
            IF cl_auth_chk_act("exchange_ld") THEN 
               #add-point:ON ACTION exchange_ld
               CALL aglt310_01(g_glaald) RETURNING g_bookno
               IF g_glaald <> g_bookno THEN
                  CLEAR FORM
                  CALL g_glaq_s.clear()
                  CALL g_glaq_d.clear()
               END IF
               LET g_glaald = g_bookno
               #依据对应的主账套编码，抓取对应法人，币别，汇率参照编号，会计科目参照编号,关账日期
               CALL aglq760_glaald_desc(g_glaald)
               CALL aglq760_show()
                IF cl_null(g_wc) THEN
                   LET g_wc = '1=1'
                END IF 
                LET g_wc1 = ' 1=1'
                LET g_wc2 = ' 1=1'
               #END add-point
               EXIT DIALOG
            END IF
 
 
         ON ACTION jump
 
            LET g_action_choice="fetch" #161011-00018#1 mod jump-->fetch
#            IF cl_auth_chk_act("jump") THEN #161011-00018#1 mark
               #add-point:ON ACTION jump
               CALL aglq760_fetch1('/')
               LET g_current_row = g_current_idx
               LET g_curr_diag = ui.DIALOG.getCurrent()
               #END add-point
               EXIT DIALOG
#            END IF #161011-00018#1 mark
 
 
         ON ACTION query
 
            LET g_action_choice="query"
            IF cl_auth_chk_act("query") THEN 
               CALL aglq760_query()
               #add-point:ON ACTION query
               EXIT DIALOG
               #END add-point
            END IF
 
 
         ON ACTION datainfo
 
            LET g_action_choice="datainfo"
            IF cl_auth_chk_act("datainfo") THEN 
               #add-point:ON ACTION datainfo

               #END add-point
               EXIT DIALOG
            END IF
 
 
         ON ACTION last
 
            LET g_action_choice="fetch" #161011-00018#1 mod last-->fetch
#            IF cl_auth_chk_act("last") THEN  #161011-00018#1 mark
               #add-point:ON ACTION last
               CALL aglq760_fetch1('L')
               LET g_current_row = g_current_idx
               LET g_curr_diag = ui.DIALOG.getCurrent()
               #END add-point
               EXIT DIALOG
#            END IF #161011-00018#1 mark
 
 
         ON ACTION output
 
            LET g_action_choice="output"
            IF cl_auth_chk_act("output") THEN 
               #add-point:ON ACTION output
        
               CALL aglq760_g01("aglq760_tmp",tm.sdate,tm.syear,tm.speriod,tm.edate,tm.eyear,tm.eperiod,tm.curr_o,tm.curr_p,tm.acc_p,tm.ctype,g_glaald) 

               #END add-point
               EXIT DIALOG
            END IF
 
      
         #選擇全部
         ON ACTION selall
            CALL DIALOG.setSelectionRange("s_detail1", 1, -1, 1)
            FOR li_idx = 1 TO g_glaq_d.getLength()
               LET g_glaq_d[li_idx].sel = "Y"
            END FOR
 
            #add-point:ui_dialog段on action selall

            #end add-point
 
         #取消全部
         ON ACTION selnone
            CALL DIALOG.setSelectionRange("s_detail1", 1, -1, 0)
            FOR li_idx = 1 TO g_glaq_d.getLength()
               LET g_glaq_d[li_idx].sel = "N"
            END FOR
 
            #add-point:ui_dialog段on action selnone

            #end add-point
 
         #勾選所選資料
         ON ACTION sel
            FOR li_idx = 1 TO g_glaq_d.getLength()
               IF DIALOG.isRowSelected("s_detail1", li_idx) THEN
                  LET g_glaq_d[li_idx].sel = "Y"
               END IF
            END FOR
 
            #add-point:ui_dialog段on action sel

            #end add-point
 
         #取消所選資料
         ON ACTION unsel
            FOR li_idx = 1 TO g_glaq_d.getLength()
               IF DIALOG.isRowSelected("s_detail1", li_idx) THEN
                  LET g_glaq_d[li_idx].sel = "N"
               END IF
            END FOR
 
            #add-point:ui_dialog段on action unsel
         ON ACTION qbeclear   # 條件清除
            CLEAR FORM
            CALL aglq760_glaald_desc(g_glaald)
            CALL aglq760_set_default_value()
            CALL aglq760_query()
            EXIT DIALOG
            
         ON ACTION modify_detail
            LET g_action_choice="modify_detail"
            IF cl_auth_chk_act("modify_detail") THEN
               IF g_detail_idx>=1 THEN
                  IF NOT cl_null(g_glaq_d[g_detail_idx].glaqdocno) THEN
                     CALL aglq760_cmdrun() #串查aglt310傳票資料    
                  END IF
               END IF
               EXIT DIALOG
            END IF  
            #end add-point
      
         ON ACTION filter
            LET g_action_choice="filter"
            CALL aglq760_filter()
            #add-point:ON ACTION filter

            #END add-point
            EXIT DIALOG
      
         ON ACTION close
            LET INT_FLAG=FALSE         
            LET g_action_choice = "exit"
            EXIT DIALOG
      
         ON ACTION exit
            LET g_action_choice="exit"
            EXIT DIALOG
 
         # 重新整理
         ON ACTION datarefresh
            LET g_error_show = 1
            CALL aglq760_b_fill()
            CALL aglq760_fetch()
            
          ON ACTION exporttoexcel   #匯出excel
            LET g_action_choice="exporttoexcel"
            IF cl_auth_chk_act("exporttoexcel") THEN
               CALL g_export_node.clear()
               LET g_export_node[1] = base.typeInfo.create(g_glaq_d)
 
               CALL cl_export_to_excel_getpage()
               CALL cl_export_to_excel()
            END IF            
      
         #主選單用ACTION
         &include "main_menu.4gl"
         &include "relating_action.4gl"
         #交談指令共用ACTION
         &include "common_action.4gl"
            CONTINUE DIALOG
      END DIALOG
      
      IF g_action_choice = "exit" AND NOT cl_null(g_action_choice) THEN
         EXIT WHILE
      END IF
      
   END WHILE
 
   CALL cl_set_act_visible("accept,cancel", TRUE)
 
END FUNCTION
 
{</section>}
 
{<section id="aglq760.query" >}
#+ QBE資料查詢
PRIVATE FUNCTION aglq760_query()
   {<Local define>}
   DEFINE ls_wc      LIKE type_t.chr500
   DEFINE ls_return  STRING
   DEFINE ls_result  STRING 
   {</Local define>}
   #add-point:query段define
   DEFINE l_flag           LIKE type_t.num5
   DEFINE l_flag1          LIKE type_t.chr1
   DEFINE l_errno          LIKE type_t.chr100
   DEFINE l_glav002        LIKE glav_t.glav002
   DEFINE l_glav005        LIKE glav_t.glav005
   DEFINE l_sdate_s        LIKE glav_t.glav004
   DEFINE l_sdate_e        LIKE glav_t.glav004
   DEFINE l_glav006        LIKE glav_t.glav006
   DEFINE l_pdate_s        LIKE glav_t.glav004
   DEFINE l_pdate_e        LIKE glav_t.glav004
   DEFINE l_glav007        LIKE glav_t.glav007
   DEFINE l_wdate_s        LIKE glav_t.glav004
   DEFINE l_wdate_e        LIKE glav_t.glav004
   DEFINE l_cnt            LIKE type_t.num5
   
   #建立临时表
   CALL aglq760_create_temp_table()
   #從aglq740串查資料
   IF g_argv_flag = TRUE THEN 
      LET g_argv_flag = FALSE
      CALL aglq760_show()  
      IF cl_null(g_wc1) THEN
         LET g_wc1=" 1=1"
      END IF
      IF cl_null(g_wc2) THEN
         LET g_wc2=" 1=1"
      END IF
      CALL aglq760_get_data()
      SELECT COUNT(*) INTO l_cnt FROM aglq760_tmp
      IF l_cnt=0 THEN 
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = -100
         LET g_errparam.extend = ''
         LET g_errparam.popup = FALSE
         CALL cl_err()

         RETURN
      END IF
      CALL aglq760_set_page()
      CALL aglq760_fetch1('F')     
      RETURN
   END IF

   LET l_flag=TRUE
   #end add-point 
   
   LET INT_FLAG = 0
   CLEAR FORM
   CALL g_glaq_d.clear()
   LET g_wc_filter = " 1=1"
   
   CALL gfrm_curr.setFieldHidden("formonly.sel", TRUE)
   CALL gfrm_curr.setFieldHidden("formonly.statepic", TRUE)
   
   LET g_qryparam.state = "c"
   LET g_detail_idx  = 1
   LET g_detail_idx2 = 1
   
   #wc備份
   LET ls_wc = g_wc
   LET g_master_idx = l_ac
 
   
 
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
 
      #單身根據table分拆construct
      CONSTRUCT g_wc_table ON glaq002
           FROM s_detail1[1].b_glaq002
                      
         BEFORE CONSTRUCT
            #add-point:cs段more_construct

            #end add-point 
            
       #單身公用欄位開窗相關處理
       
         
       #單身一般欄位開窗相關處理
       #---------------------<  Detail: page1  >---------------------
         #----<<b_glaq002>>----
         #Ctrlp:construct.c.page1.b_glaq002
         ON ACTION controlp INFIELD b_glaq002
            #add-point:ON ACTION controlp INFIELD b_glaq002
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.where = "glac001 = '",g_glaa004,"' AND glac006 = '1'"
            CALL aglt310_04()                        #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_glaq002  #顯示到畫面上
            NEXT FIELD b_glaq002                     #返回原欄位

            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD b_glaq002
            #add-point:BEFORE FIELD b_glaq002

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD b_glaq002
            
            #add-point:AFTER FIELD b_glaq002

            #END add-point

 

 

 
 
 

 

 
 
 

 

 

 

 

 

 

 

 

 

 

 

 

 

 

 

 

      END CONSTRUCT
   
      #add-point:query段more_construct
      CONSTRUCT g_wc1 ON glapdocdt,glaqdocno
           FROM s_detail1[1].glapdocdt,s_detail1[1].glaqdocno
                      
         BEFORE CONSTRUCT
         
         ON ACTION controlp INFIELD glaqdocno
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_glapdocno()                        #呼叫開窗
            DISPLAY g_qryparam.return1 TO glaqdocno  #顯示到畫面上
            NEXT FIELD glaqdocno                     #返回原欄位            
      END CONSTRUCT
      
      CONSTRUCT g_wc2 ON glaq005
           FROM s_detail1[1].glaq005
                      
         BEFORE CONSTRUCT
         
         ON ACTION controlp INFIELD glaq005
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooai001()                         #呼叫開窗
            DISPLAY g_qryparam.return1 TO glaq005  #顯示到畫面上
            NEXT FIELD glaq005                     #返回原欄位            
      END CONSTRUCT
      
      INPUT BY NAME tm.sdate,tm.edate,tm.ctype,tm.curr_o,tm.curr_p,tm.acc_p,
                    tm.show_acc,tm.glac005,tm.stus,tm.glac009,tm.show_ad,tm.show_ce,tm.show_ye
         ATTRIBUTE(WITHOUT DEFAULTS)
         BEFORE INPUT
         
         AFTER FIELD sdate
            IF NOT cl_null(tm.sdate) THEN
               CALL s_get_accdate(g_glaa003,tm.sdate,'','')
               RETURNING l_flag1,l_errno,l_glav002,l_glav005,l_sdate_s,l_sdate_e,
                         l_glav006,l_pdate_s,l_pdate_e,l_glav007,l_wdate_s,l_wdate_e
               IF l_flag1='N' THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = l_errno
                  LET g_errparam.extend = ''
                  LET g_errparam.popup = FALSE
                  CALL cl_err()

                  NEXT FIELD sdate
               END IF
               IF NOT cl_null(tm.edate) THEN
                  IF tm.sdate>tm.edate THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = 'agl-00116'
                     LET g_errparam.extend = ''
                     LET g_errparam.popup = FALSE
                     CALL cl_err()

                     NEXT FIELD sdate
                  END IF
               END IF
               LET tm.syear=l_glav002
               LET tm.speriod=l_glav006
               DISPLAY tm.syear,tm.speriod TO syear,speriod 
            END IF
            
         AFTER FIELD edate
            IF NOT cl_null(tm.edate) THEN
               CALL s_get_accdate(g_glaa003,tm.edate,'','')
               RETURNING l_flag1,l_errno,l_glav002,l_glav005,l_sdate_s,l_sdate_e,
                         l_glav006,l_pdate_s,l_pdate_e,l_glav007,l_wdate_s,l_wdate_e
               IF l_flag1='N' THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = l_errno
                  LET g_errparam.extend = ''
                  LET g_errparam.popup = FALSE
                  CALL cl_err()

                  NEXT FIELD edate
               END IF
               IF NOT cl_null(tm.sdate) THEN
                  IF tm.sdate>tm.edate THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = 'agl-00117'
                     LET g_errparam.extend = ''
                     LET g_errparam.popup = FALSE
                     CALL cl_err()

                     NEXT FIELD edate
                  END IF
               END IF
               LET tm.eyear=l_glav002
               LET tm.eperiod=l_glav006
               DISPLAY tm.eyear,tm.eperiod TO eyear,eperiod 
            END IF
         
         ON CHANGE ctype
            IF tm.ctype MATCHES '[0123]' THEN
               CALL aglq760_set_curr_show()
            ELSE
               NEXT FIELD ctype
            END IF
            
         ON CHANGE curr_o 
            IF tm.curr_o MATCHES '[yYnN]' THEN
               IF tm.curr_o='Y' THEN
                  CALL cl_set_comp_visible('glaq005,glaq006,glaq010d,glaq010c,amt',TRUE)
                  CALL aglq760_set_comp_entry('curr_p',TRUE)
               ELSE
                  CALL cl_set_comp_visible('glaq005,glaq006,glaq010d,glaq010c,amt',FALSE)
                  CALL aglq760_set_comp_entry('curr_p',FALSE)
                  LET tm.curr_p='N'
                  DISPLAY tm.curr_p TO curr_p
               END IF                  
            ELSE
               NEXT FIELD curr_o
            END IF
            
         ON CHANGE curr_p
            IF tm.curr_p NOT MATCHES '[yYnN]' THEN
                NEXT FIELD curr_p
            END IF
            
         AFTER FIELD acc_p
            IF tm.acc_p NOT MATCHES '[yYnN]' THEN
               NEXT FIELD acc_p
            END IF
            
         AFTER FIELD show_acc
            IF tm.show_acc NOT MATCHES '[yYnN]' THEN
               NEXT FIELD show_acc
            END IF
         
         AFTER FIELD glac005
            IF NOT cl_ap_chk_Range(tm.glac005,"1","1","99","1","azz-00087",1) THEN
               NEXT FIELD glac005
            END IF
         
         AFTER FIELD stus
            IF tm.stus NOT MATCHES '[123]' THEN
               NEXT FIELD stus
            END IF
            
         AFTER FIELD glac009
            IF tm.glac009 NOT MATCHES '[yYnN]' THEN
               NEXT FIELD glac009
            END IF
         
         AFTER FIELD show_ad
            IF tm.show_ad NOT MATCHES '[yYnN]' THEN
               NEXT FIELD show_ad
            END IF
            
         AFTER FIELD show_ce
            IF tm.show_ce NOT MATCHES '[yYnN]' THEN
               NEXT FIELD show_ce
            END IF
         
         AFTER FIELD show_ye
            IF tm.show_ye NOT MATCHES '[yYnN]' THEN
               NEXT FIELD show_ye
            END IF
  
      END INPUT
      
      BEFORE DIALOG
        #預設
        CALL aglq760_show()
        
      ON ACTION qbeclear   # 條件清除
         CLEAR FORM
         CALL aglq760_glaald_desc(g_glaald)
         CALL aglq760_set_default_value()
         CALL aglq760_show()
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
 
   
 
   IF INT_FLAG THEN
      LET INT_FLAG = 0
      #還原
      LET g_wc = ls_wc
      LET l_flag=FALSE
   ELSE
      LET g_master_idx = 1
   END IF
   
   LET g_wc = g_wc_table 
 
 
        
   LET g_wc2 = " 1=1"
 
        
   #add-point:cs段after_construct
   IF l_flag=TRUE THEN
      CALL aglq760_get_data()
      SELECT COUNT(*) INTO l_cnt FROM aglq760_tmp
      IF l_cnt=0 THEN 
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = -100
         LET g_errparam.extend = ''
         LET g_errparam.popup = FALSE
         CALL cl_err()

         RETURN
      END IF
      CALL aglq760_set_page()
      CALL aglq760_fetch1('F')
   ELSE
      CALL aglq760_b_fill1()
      DISPLAY g_current_idx TO FORMONLY.h_index
      DISPLAY g_glaq_s.getLength() TO FORMONLY.h_count
      DISPLAY g_detail_idx TO FORMONLY.idx
   END IF
   #end add-point
        
   LET g_error_show = 1
   CALL aglq760_b_fill()
   LET l_ac = g_master_idx
   CALL aglq760_fetch()
#   IF g_detail_cnt = 0 AND NOT INT_FLAG THEN
#      CALL cl_err("",-100,1)
#   END IF
   
   CALL gfrm_curr.setFieldHidden("formonly.sel", FALSE)
   CALL gfrm_curr.setFieldHidden("formonly.statepic", FALSE)
   
END FUNCTION
 
{</section>}
 
{<section id="aglq760.b_fill" >}
#+ 單身陣列填充
PRIVATE FUNCTION aglq760_b_fill()
   {<Local define>}
   DEFINE ls_wc           STRING
   {</Local define>}
   #add-point:b_fill段define
   
   #end add-point
 
   #add-point:b_fill段sql_before
   RETURN
   #end add-point
   
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
   
   LET g_sql = "SELECT  UNIQUE glaq002,'','','','','','','','','','','','','','','','','','','','','', 
       '' FROM glaq_t",
 
 
               "",
               " WHERE glaqent= ? AND 1=1 AND ", ls_wc
    
   LET g_sql = g_sql, " ORDER BY glaq_t.glaqld,glaq_t.glaqdocno,glaq_t.glaqseq"
  
   #add-point:b_fill段sql_after
   
   #end add-point
  
   PREPARE aglq760_pb FROM g_sql
   DECLARE b_fill_curs CURSOR FOR aglq760_pb
   
   OPEN b_fill_curs USING g_enterprise
 
   CALL g_glaq_d.clear()
 
 
   LET g_cnt = l_ac
   LET l_ac = 1   
   ERROR "Searching!" 
 
   FOREACH b_fill_curs INTO g_glaq_d[l_ac].glaq002,g_glaq_d[l_ac].glaq002_desc,g_glaq_d[l_ac].glapdocdt, 
       g_glaq_d[l_ac].glaqdocno,g_glaq_d[l_ac].glap004,g_glaq_d[l_ac].style,g_glaq_d[l_ac].glaq005,g_glaq_d[l_ac].glaq006, 
       g_glaq_d[l_ac].glaq010d,g_glaq_d[l_ac].glaq010c,g_glaq_d[l_ac].glaq003,g_glaq_d[l_ac].glaq004, 
       g_glaq_d[l_ac].glaq039,g_glaq_d[l_ac].glaq040,g_glaq_d[l_ac].glaq041,g_glaq_d[l_ac].glaq042,g_glaq_d[l_ac].glaq043, 
       g_glaq_d[l_ac].glaq044,g_glaq_d[l_ac].state,g_glaq_d[l_ac].amt,g_glaq_d[l_ac].amt1,g_glaq_d[l_ac].amt2, 
       g_glaq_d[l_ac].amt3
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "FOREACH:"
         LET g_errparam.popup = TRUE
         CALL cl_err()
 
         EXIT FOREACH
      END IF
      
      LET g_glaq_d[l_ac].sel = "N"
      #LET g_glaq_d[l_ac].statepic = cl_get_actipic(g_glaq_d[l_ac].statepic)
 
      
 
      #add-point:b_fill段資料填充
      
      #end add-point
      
      CALL aglq760_detail_show()      
 
      LET l_ac = l_ac + 1
      IF l_ac > g_max_rec THEN
         IF g_error_show = 1 THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code =  9035
            LET g_errparam.extend =  ""
            LET g_errparam.popup = TRUE
            CALL cl_err()
 
         END IF
         EXIT FOREACH
      END IF
      
   END FOREACH
   LET g_error_show = 0
   
 
   
   CALL g_glaq_d.deleteElement(g_glaq_d.getLength())   
 
   
   #add-point:b_fill段資料填充(其他單身)
   
   #end add-point
    
   LET g_detail_cnt = l_ac - 1 
   DISPLAY g_detail_cnt TO FORMONLY.h_count
   LET l_ac = g_cnt
   LET g_cnt = 0
   
   CLOSE b_fill_curs
   FREE aglq760_pb
   
   LET l_ac = 1
   CALL aglq760_fetch()
   
      CALL aglq760_filter_show('glaq002','b_glaq002')
   CALL aglq760_filter_show('glaqdocno','b_glaq002_desc')
   CALL aglq760_filter_show('glaq005','b_glaq002_desc')
   CALL aglq760_filter_show('glaq006','b_glaq002_desc')
   CALL aglq760_filter_show('glaq003','b_glaq002_desc')
   CALL aglq760_filter_show('glaq004','b_glaq002_desc')
   CALL aglq760_filter_show('glaq039','b_glaq002_desc')
   CALL aglq760_filter_show('glaq040','b_glaq002_desc')
   CALL aglq760_filter_show('glaq041','b_glaq002_desc')
   CALL aglq760_filter_show('glaq042','b_glaq002_desc')
   CALL aglq760_filter_show('glaq043','b_glaq002_desc')
   CALL aglq760_filter_show('glaq044','b_glaq002_desc')
 
   
END FUNCTION
 
{</section>}
 
{<section id="aglq760.fetch" >}
#+ 單身陣列填充2
PRIVATE FUNCTION aglq760_fetch()
   {<Local define>}
   DEFINE li_ac           LIKE type_t.num5
   {</Local define>}
   #add-point:fetch段define
   RETURN
   #end add-point
   
 
   
   LET li_ac = l_ac 
   
 
   
   #DISPLAY g_detail_cnt TO FORMONLY.cnt
 
   #add-point:單身填充後
   
   #end add-point 
   
 
   
   LET l_ac = li_ac
   
END FUNCTION
 
{</section>}
 
{<section id="aglq760.detail_show" >}
#+ 顯示相關資料
PRIVATE FUNCTION aglq760_detail_show()
   #add-point:show段define
   
   #end add-point
 
   #add-point:detail_show段之前
   
   #end add-point
   
   
   
   #帶出公用欄位reference值page1
   
    
 
   
   #讀入ref值
   #add-point:show段單身reference
   #科目編號
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_glaq_d[l_ac].glaq002
   CALL ap_ref_array2(g_ref_fields,"SELECT glacl004 FROM glacl_t WHERE glaclent='"||g_enterprise||"' AND glacl001 = '"||g_glaa004||"' AND glacl002 = ? AND glacl003='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_glaq_d[l_ac].glaq002_desc=g_rtn_fields[1]
   #end add-point
   
 
 
   #add-point:detail_show段之後
   
   #end add-point
 
END FUNCTION
 
{</section>}
 
{<section id="aglq760.filter" >}
#+ filter過濾功能
PRIVATE FUNCTION aglq760_filter()
   {<Local define>}
   {</Local define>}
   #add-point:filter段define

   #end add-point    
   
   LET l_ac = 1
   LET g_detail_idx = 1
   LET g_detail_idx2 = 1
 
   LET INT_FLAG = 0
 
   LET g_qryparam.state = 'c'
 
   LET g_wc_filter_t = g_wc_filter
   LET g_wc_t = g_wc
   
   CALL gfrm_curr.setFieldHidden("formonly.sel", TRUE)
   CALL gfrm_curr.setFieldHidden("formonly.statepic", TRUE)
 
   LET g_wc = cl_replace_str(g_wc, g_wc_filter, '')
 
   #使用DIALOG包住 單頭CONSTRUCT及單身CONSTRUCT
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
 
      #單頭  #160302-00006#1  2016/03/02 By 07675 mark
#     CONSTRUCT g_wc_filter ON glaq002,glaqdocno,glaq005,glaq006,glaq003,glaq004,glaq039,glaq040,glaq041, 
#         glaq042,glaq043,glaq044
#                         FROM s_detail1[1].b_glaq002,s_detail1[1].b_glaq002_desc,s_detail1[1].b_glaq002_desc, 
#                             s_detail1[1].b_glaq002_desc,s_detail1[1].b_glaq002_desc,s_detail1[1].b_glaq002_desc, 
#                             s_detail1[1].b_glaq002_desc,s_detail1[1].b_glaq002_desc,s_detail1[1].b_glaq002_desc, 
#                             s_detail1[1].b_glaq002_desc,s_detail1[1].b_glaq002_desc,s_detail1[1].b_glaq002_desc 
      CONSTRUCT g_wc_filter ON  glaq002,glapdocdt,glaqdocno,glaq005
               FROM s_detail1[1].b_glaq002,s_detail1[1].glapdocdt,s_detail1[1].glaqdocno,s_detail1[1].glaq005
            
            #160302-00006#1  2016/03/02 By 07675 add--str
            
          ON ACTION controlp INFIELD b_glaq002
            #add-point:ON ACTION controlp INFIELD b_glaq002
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.where = "glac001 = '",g_glaa004,"' AND glac006 = '1'"
            CALL aglt310_04()                        #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_glaq002  #顯示到畫面上
            NEXT FIELD b_glaq002                     #返回原欄位
 
            #END add-point
         ON ACTION controlp INFIELD glaqdocno
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_glapdocno()                        #呼叫開窗
            DISPLAY g_qryparam.return1 TO glaqdocno  #顯示到畫面上
            NEXT FIELD glaqdocno                     #返回原欄位            
             
             #END add-point
         
         ON ACTION controlp INFIELD glaq005
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooai001()                         #呼叫開窗
            DISPLAY g_qryparam.return1 TO glaq005  #顯示到畫面上
            NEXT FIELD glaq005                     #返回原欄位     
            
            #END add-point
            #160302-00006#1  2016/03/02 By 07675 add--end
 
         BEFORE CONSTRUCT
#saki       CALL cl_qbe_init()
             DISPLAY aglq760_filter_parser('glaq002') TO s_detail1[1].b_glaq002
             DISPLAY aglq760_filter_parser('glaqdocno') TO s_detail1[1].b_glaqdocno
             DISPLAY aglq760_filter_parser('glaqdocdt') TO s_detail1[1].b_glaqdocdt
             DISPLAY aglq760_filter_parser('glaq005') TO s_detail1[1].b_glaq005
#            DISPLAY aglq760_filter_parser('glaq006') TO s_detail1[1].b_glaq002_desc
#            DISPLAY aglq760_filter_parser('glaq003') TO s_detail1[1].b_glaq002_desc
#            DISPLAY aglq760_filter_parser('glaq004') TO s_detail1[1].b_glaq002_desc
#            DISPLAY aglq760_filter_parser('glaq039') TO s_detail1[1].b_glaq002_desc
#            DISPLAY aglq760_filter_parser('glaq040') TO s_detail1[1].b_glaq002_desc
#            DISPLAY aglq760_filter_parser('glaq041') TO s_detail1[1].b_glaq002_desc
#            DISPLAY aglq760_filter_parser('glaq042') TO s_detail1[1].b_glaq002_desc
#            DISPLAY aglq760_filter_parser('glaq043') TO s_detail1[1].b_glaq002_desc
#            DISPLAY aglq760_filter_parser('glaq044') TO s_detail1[1].b_glaq002_desc
 
 
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
   
    CALL aglq760_filter_show('glaq002','b_glaq002')
    CALL aglq760_filter_show('glaqdocno','b_glaqdocno')
    CALL aglq760_filter_show('glaqdocdt','b_glaqdocdt')
    CALL aglq760_filter_show('glaq005','b_glaq005')
#   CALL aglq760_filter_show('glaq006','b_glaq002_desc')
#   CALL aglq760_filter_show('glaq003','b_glaq002_desc')
#   CALL aglq760_filter_show('glaq004','b_glaq002_desc')
#   CALL aglq760_filter_show('glaq039','b_glaq002_desc')
#   CALL aglq760_filter_show('glaq040','b_glaq002_desc')
#   CALL aglq760_filter_show('glaq041','b_glaq002_desc')
#   CALL aglq760_filter_show('glaq042','b_glaq002_desc')
#   CALL aglq760_filter_show('glaq043','b_glaq002_desc')
#   CALL aglq760_filter_show('glaq044','b_glaq002_desc')
 
   
    CALL aglq760_b_fill1()
 
#   CALL aglq760_b_fill()
   #CALL aglq760_fetch()
   
   CALL gfrm_curr.setFieldHidden("formonly.sel", FALSE)
   CALL gfrm_curr.setFieldHidden("formonly.statepic", FALSE)
 
END FUNCTION
 
{</section>}
 
{<section id="aglq760.filter_parser" >}
#+ filter欄位解析
PRIVATE FUNCTION aglq760_filter_parser(ps_field)
   {<Local define>}
   DEFINE ps_field   STRING
   DEFINE ls_tmp     STRING
   DEFINE li_tmp     LIKE type_t.num5
   DEFINE li_tmp2    LIKE type_t.num5
   DEFINE ls_var     STRING
   {</Local define>}
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
 
{<section id="aglq760.filter_show" >}
#+ Browser標題欄位顯示搜尋條件
PRIVATE FUNCTION aglq760_filter_show(ps_field,ps_object)
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
   LET ls_condition = aglq760_filter_parser(ps_field)
   IF NOT cl_null(ls_condition) THEN
      LET ls_title = ls_title, '※', ls_condition, '※'
   END IF
 
   #將資料顯示回去
   CALL lnode_item.setAttribute("text",ls_title)
 
END FUNCTION
 
{</section>}
 
{<section id="aglq760.insert" >}
#+ insert
PRIVATE FUNCTION aglq760_insert()
   #add-point:insert段define
   
   #end add-point
 
   #add-point:insert段control
   
   #end add-point    
   
END FUNCTION
 
{</section>}
 
{<section id="aglq760.modify" >}
#+ modify
PRIVATE FUNCTION aglq760_modify()
   #add-point:modify段define
   
   #end add-point
 
   #add-point:modify段control
   
   #end add-point 
END FUNCTION
 
{</section>}
 
{<section id="aglq760.reproduce" >}
#+ reproduce
PRIVATE FUNCTION aglq760_reproduce()
   #add-point:reproduce段define
   
   #end add-point
 
   #add-point:reproduce段control
   
   #end add-point 
END FUNCTION
 
{</section>}
 
{<section id="aglq760.delete" >}
#+ delete
PRIVATE FUNCTION aglq760_delete()
   #add-point:delete段define
   
   #end add-point
 
   #add-point:delete段control
   
   #end add-point 
END FUNCTION
 
{</section>}
 
{<section id="aglq760.other_function" >}

################################################################################
# Descriptions...: 建立臨時表
# Memo...........:
# Usage..........: CALL aglq760_create_temp_table()
# Date & Author..: 2014/03/10 By 02599
# Modify.........:
################################################################################
PRIVATE FUNCTION aglq760_create_temp_table()
   DROP TABLE aglq760_tmp;
   CREATE TEMP TABLE aglq760_tmp(
   seq          LIKE glaq_t.glaqseq,
   glaq002      LIKE glaq_t.glaq002,
   glapdocdt    LIKE glap_t.glapdocdt,
   glaqdocno    LIKE glaq_t.glaqdocno,
   glaq001      LIKE glaq_t.glaq001,
   glap004      LIKE glap_t.glap004,
   style        LIKE type_t.chr1, 
   glaq005      LIKE glaq_t.glaq005,
   glaq006      LIKE glaq_t.glaq006,
   glaq010d     LIKE glaq_t.glaq010,
   glaq010c     LIKE glaq_t.glaq010,
   glaq003      LIKE glaq_t.glaq003, 
   glaq004      LIKE glaq_t.glaq004, 
   glaq039      LIKE glaq_t.glaq039,
   glaq040      LIKE glaq_t.glaq040, 
   glaq041      LIKE glaq_t.glaq041,
   glaq042      LIKE glaq_t.glaq042,   
   glaq043      LIKE glaq_t.glaq043, 
   glaq044      LIKE glaq_t.glaq044, 
   state        LIKE type_t.chr1, 
   amt          LIKE glaq_t.glaq003,
   amt1         LIKE glaq_t.glaq003,
   amt2         LIKE glaq_t.glaq003,
   amt3         LIKE glaq_t.glaq003
#   glap002      DECIMAL(5,0),
#   glaq001      VARCHAR(255),
#   glaqseq      DECIMAL(10,0),
#   glapent      DECIMAL(5,0)
#   glap002      LIKE glap_t.glap002,
#   glaq001      LIKE glaq_t.glaq001,
#   glaqseq      LIKE glaq_t.glaqseq,
#   glapent      LIKE glap_t.glapent
   );
END FUNCTION

################################################################################
# Descriptions...: 設置本位幣二、別你幣三顯示否
# Memo...........:
# Usage..........: CALL aglq760_set_curr_show()
# Date & Author..: 2014/03/30 By 02599
# Modify.........:
################################################################################
PRIVATE FUNCTION aglq760_set_curr_show()
   #顯示本位幣二
   IF tm.ctype='1' THEN
      CALL cl_set_comp_visible("glaq039,glaq040,glaq041,amt2",TRUE)
   ELSE
      CALL cl_set_comp_visible("glaq039,glaq040,glaq041,amt2",FALSE)
   END IF
   #顯示本位幣三
   IF tm.ctype='2' THEN
      CALL cl_set_comp_visible("glaq042,glaq043,glaq044,amt3",TRUE)
   ELSE
      CALL cl_set_comp_visible("glaq042,glaq043,glaq044,amt3",FALSE)
   END IF
   #全部
   IF tm.ctype='3' THEN
      CALL cl_set_comp_visible("glaq039,glaq040,glaq041,glaq042,glaq043,glaq044,amt2,amt3",TRUE)
      CALL cl_set_comp_visible("glaq039,glaq040,glaq041,glaq042,glaq043,glaq044,amt2,amt3",TRUE)
   END IF
END FUNCTION

################################################################################
# Descriptions...: 獲取帳套相關資料
# Memo...........:
# Usage..........: CALL aglq720_glaald_desc(p_glaald)
# Input parameter: p_glaald   帳套
# Date & Author..: 2014/03/30 By 02599
# Modify.........:
################################################################################
PRIVATE FUNCTION aglq760_glaald_desc(p_glaald)
   DEFINE  p_glaald    LIKE glaa_t.glaald
   
    INITIALIZE g_ref_fields TO NULL
    LET g_ref_fields[1] = p_glaald 
    CALL ap_ref_array2(g_ref_fields,"SELECT glaal002 FROM glaal_t WHERE glaalent='"||g_enterprise||"' AND glaalld=? AND glaal001='"||g_dlang||"'","") RETURNING g_rtn_fields
    LET g_glaald_desc=g_rtn_fields[1]
    #依据对应的主账套编码，抓取对应法人，币别，汇率参照编号，会计科目参照编号,关账日期
   SELECT glaacomp,glaa001,glaa002,glaa003,glaa004,glaa013,
          glaa015,glaa016,glaa017,glaa018,glaa019,glaa020,
          glaa021,glaa022
     INTO g_glaacomp,g_glaa001,g_glaa002,g_glaa003,g_glaa004,g_glaa013,
          g_glaa015,g_glaa016,g_glaa017,g_glaa018,g_glaa019,g_glaa020,
          g_glaa021,g_glaa022
     FROM glaa_t
    WHERE glaaent = g_enterprise
      AND glaald = p_glaald 
   
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_glaacomp
   CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_glaacomp_desc= g_rtn_fields[1]
   
   #本位幣二
   IF g_glaa015='Y' THEN
      CALL cl_set_comp_visible("glaa016",TRUE)
   ELSE
      CALL cl_set_comp_visible("glaa016",FALSE)
   END IF
   #本位幣三
   IF g_glaa019='Y' THEN
      CALL cl_set_comp_visible("glaa020",TRUE)
   ELSE
      CALL cl_set_comp_visible("glaa020",FALSE)
   END IF 
   #多本位幣
   CALL cl_set_comp_entry("ctype",TRUE)
   CASE
      WHEN g_glaa015<>'Y' AND g_glaa019<>'Y' 
         CALL cl_set_comp_entry("ctype",FALSE)
         CALL cl_set_combo_scc_part('ctype','9921','0')
#         LET tm.ctype=''
      WHEN g_glaa015='Y' AND g_glaa019<>'Y' 
         CALL cl_set_combo_scc_part('ctype','9921','0,1')
#         LET tm.ctype='1'
      WHEN g_glaa015<>'Y' AND g_glaa019='Y' 
         CALL cl_set_combo_scc_part('ctype','9921','0,2')
#         LET tm.ctype='2'  
      WHEN g_glaa015='Y' AND g_glaa019='Y' 
         CALL cl_set_combo_scc_part('ctype','9921','0,1,2,3')
#         LET tm.ctype='3'
   END CASE
   IF cl_null(tm.ctype) THEN
      LET tm.ctype='0'
   END IF
   IF tm.curr_o='Y' THEN
      CALL cl_set_comp_visible('glaq005,glaq006,glaq010d,glaq010c,amt',TRUE)
      CALL aglq760_set_comp_entry('curr_p',TRUE)
   ELSE
      CALL cl_set_comp_visible('glaq005,glaq006,glaq010d,glaq010c,amt',FALSE)
      CALL aglq760_set_comp_entry('curr_p',FALSE)
      LET tm.curr_p='N'
   END IF
   CALL aglq760_set_curr_show() #顯示本位幣二、本位幣三
END FUNCTION

################################################################################
# Descriptions...: 抓取數據
# Memo...........:
# Usage..........: CALL aglq760_get_data()
# Date & Author..: 2014/03/10 By 02599
# Modify.........:
################################################################################
PRIVATE FUNCTION aglq760_get_data()
   DEFINE l_pdate_s1       LIKE glav_t.glav004 #起始年度+期別對應的起始截止日期
   DEFINE l_pdate_e1       LIKE glav_t.glav004
   DEFINE l_pdate_s2       LIKE glav_t.glav004 #截止年度+期別對應的起始截止日期
   DEFINE l_pdate_e2       LIKE glav_t.glav004
   DEFINE l_flag1          LIKE type_t.chr1
   DEFINE l_errno          LIKE type_t.chr100
   DEFINE l_glav002        LIKE glav_t.glav002
   DEFINE l_glav005        LIKE glav_t.glav005
   DEFINE l_sdate_s        LIKE glav_t.glav004
   DEFINE l_sdate_e        LIKE glav_t.glav004
   DEFINE l_glav006        LIKE glav_t.glav006
   DEFINE l_glav007        LIKE glav_t.glav007
   DEFINE l_wdate_s        LIKE glav_t.glav004
   DEFINE l_wdate_e        LIKE glav_t.glav004
   DEFINE l_flag           LIKE type_t.num5    #表示是否是完整期別
   DEFINE l_sql,l_sql1,l_sql2   STRING
   DEFINE l_sql3,l_sql4         STRING
   DEFINE l_wc,l_wc2            STRING 
   DEFINE l_glar001        LIKE glar_t.glar001
   DEFINE l_glar002        LIKE glar_t.glar002
   DEFINE l_glar003        LIKE glar_t.glar003
   DEFINE l_glar009        LIKE glar_t.glar009
   DEFINE l_glar010        LIKE glar_t.glar010
   DEFINE l_glar011        LIKE glar_t.glar011
   DEFINE l_glar005        LIKE glar_t.glar005
   DEFINE l_glar006        LIKE glar_t.glar006
   DEFINE l_glar034        LIKE glar_t.glar034
   DEFINE l_glar035        LIKE glar_t.glar035
   DEFINE l_glar036        LIKE glar_t.glar036
   DEFINE l_glar037        LIKE glar_t.glar037
   DEFINE l_state          LIKE type_t.num5
   DEFINE l_amt            LIKE type_t.num20_6
   DEFINE l_oamt           LIKE type_t.num20_6
   DEFINE l_oamt_d         LIKE type_t.num20_6
   DEFINE l_oamt_c         LIKE type_t.num20_6    
   DEFINE l_amt1           LIKE type_t.num20_6 
   DEFINE l_amt2           LIKE type_t.num20_6 
   DEFINE l_amt3           LIKE type_t.num20_6 
   DEFINE l_amt4           LIKE type_t.num20_6 
   DEFINE l_amt5           LIKE type_t.num20_6 
   DEFINE l_amt6           LIKE type_t.num20_6
   DEFINE l_sum            LIKE type_t.num20_6
   DEFINE l_osum           LIKE type_t.num20_6
   DEFINE l_osum_d         LIKE type_t.num20_6
   DEFINE l_osum_c         LIKE type_t.num20_6
   DEFINE l_sum1           LIKE type_t.num20_6 
   DEFINE l_sum2           LIKE type_t.num20_6 
   DEFINE l_sum3           LIKE type_t.num20_6
   DEFINE l_sum4           LIKE type_t.num20_6 
   DEFINE l_sum5           LIKE type_t.num20_6 
   DEFINE l_sum6           LIKE type_t.num20_6   
   DEFINE l_period         LIKE glap_t.glap004
   DEFINE l_success        LIKE type_t.num5
   DEFINE l_seq            LIKE type_t.num10
   DEFINE l_str,l_str1,l_str2      STRING
   DEFINE l_glapdocdt      LIKE glap_t.glapdocdt
   DEFINE l_glapdocno      LIKE glap_t.glapdocno
   DEFINE l_glaq001        LIKE glaq_t.glaq001
   DEFINE l_glaq005        LIKE glaq_t.glaq005
   DEFINE l_glaq006        LIKE glaq_t.glaq006
   DEFINE l_glaq010d       LIKE glaq_t.glaq010
   DEFINE l_glaq010c       LIKE glaq_t.glaq010
   DEFINE l_glaq003_s      LIKE glaq_t.glaq003
   DEFINE l_glaq004_s      LIKE glaq_t.glaq004
   DEFINE l_glaq039_s      LIKE glaq_t.glaq039
   DEFINE l_glaq040_s      LIKE glaq_t.glaq040
   DEFINE l_glaq041_s      LIKE glaq_t.glaq041
   DEFINE l_glaq042_s      LIKE glaq_t.glaq042
   DEFINE l_glaq043_s      LIKE glaq_t.glaq043
   DEFINE l_glaq044_s      LIKE glaq_t.glaq044
   DEFINE l_glaq010d_s     LIKE glaq_t.glaq010
   DEFINE l_glaq010c_s     LIKE glaq_t.glaq010
   DEFINE l_glaq003        LIKE glaq_t.glaq003
   DEFINE l_glaq004        LIKE glaq_t.glaq004
   DEFINE l_glaq039        LIKE glaq_t.glaq039
   DEFINE l_glaq040        LIKE glaq_t.glaq040
   DEFINE l_glaq041        LIKE glaq_t.glaq041
   DEFINE l_glaq042        LIKE glaq_t.glaq042
   DEFINE l_glaq043        LIKE glaq_t.glaq043
   DEFINE l_glaq044        LIKE glaq_t.glaq044
   DEFINE l_state_qc       LIKE type_t.num5
   DEFINE l_oamt_qc        LIKE type_t.num20_6 
   DEFINE l_amt1_qc        LIKE type_t.num20_6 
   DEFINE l_amt2_qc        LIKE type_t.num20_6 
   DEFINE l_amt3_qc        LIKE type_t.num20_6
   DEFINE l_glar001_t      LIKE glar_t.glar001
   DEFINE l_glar009_t      LIKE glar_t.glar009
   DEFINE l_glav004        LIKE glav_t.glav004
   DEFINE l_glav004_m      LIKE glav_t.glav004
   DEFINE l_glav004_e      LIKE glav_t.glav004
   DEFINE l_pdate_s3       LIKE glav_t.glav004 #年度+期別對應的起始截止日期
   DEFINE l_pdate_e3       LIKE glav_t.glav004
   DEFINE l_flag_amt       LIKE type_t.num5  #表示是否有期初後者期末金額
   DEFINE l_wc_glac002     STRING
   DEFINE l_glar           DYNAMIC ARRAY OF RECORD    #資料瀏覽之欄位 
          glar001          LIKE glar_t.glar001,
          glac003          LIKE glac_t.glac003, #161125-00012#1 add
          glaq002_str      STRING,              #161125-00012#1 add
          glar009          LIKE glar_t.glar009
   END RECORD
   DEFINE l_glac002        LIKE glac_t.glac002
   DEFINE l_i              LIKE type_t.num5
   DEFINE l_str3,l_str4    STRING
   DEFINE l_period_max     LIKE type_t.num5
   DEFINE l_glap007        LIKE glap_t.glap007 #151204-00013#6 add
   DEFINE l_glac007        LIKE glac_t.glac007 #151204-00013#6 add
   #160511-00006#3--add--str--
   DEFINE l_year_osum      LIKE type_t.num20_6
   DEFINE l_year_sum1      LIKE type_t.num20_6
   DEFINE l_year_sum2      LIKE type_t.num20_6
   DEFINE l_year_sum3      LIKE type_t.num20_6
   #160511-00006#3--add--end
   #160505-00007#16--add--str--
   DEFINE l_glaq001_1      LIKE glaq_t.glaq001
   DEFINE l_glaq001_2      LIKE glaq_t.glaq001
   DEFINE l_glaq001_3      LIKE glaq_t.glaq001
   DEFINE l_glav006_max    LIKE glav_t.glav006
   DEFINE l_glap004        LIKE glap_t.glap004
   DEFINE l_style          LIKE type_t.chr1
   DEFINE l_glac002_sql    STRING
   #160505-00007#16--add--end
   DEFINE l_glac010        LIKE glac_t.glac010  #160824-00004#2 add
   DEFINE l_xcea002        LIKE xcea_t.xcea002  #160824-00004#4 add
   #161125-00012#1--add--str--
   DEFINE l_glac003        LIKE glac_t.glac003
   DEFINE l_glaq002_str    STRING
   DEFINE l_glac002_str    STRING
   DEFINE l_str_glaq005    STRING
   DEFINE l_sql_pr2        STRING
   DEFINE l_sql_pr3        STRING
   DEFINE l_sql_pr4        STRING
   DEFINE l_sql_pr2_1      STRING
   DEFINE l_date           LIKE type_t.dat
   #161125-00012#1--add--end
   
   #刪除臨時表中資料
   DELETE FROM aglq760_tmp
   
   CALL s_get_accdate(g_glaa003,'',tm.syear,tm.speriod) 
   RETURNING l_flag1,l_errno,l_glav002,l_glav005,l_sdate_s,l_sdate_e,
             l_glav006,l_pdate_s1,l_pdate_e1,l_glav007,l_wdate_s,l_wdate_e
   IF l_flag1='N' THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = l_errno
      LET g_errparam.extend = ''
      LET g_errparam.popup = FALSE
      CALL cl_err()

   END IF

   CALL s_get_accdate(g_glaa003,'',tm.eyear,tm.eperiod) 
   RETURNING l_flag1,l_errno,l_glav002,l_glav005,l_sdate_s,l_sdate_e,
             l_glav006,l_pdate_s2,l_pdate_e2,l_glav007,l_wdate_s,l_wdate_e
   IF l_flag1='N' THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = l_errno
      LET g_errparam.extend = ''
      LET g_errparam.popup = FALSE
      CALL cl_err()

   END IF

   #判斷是否是整期間查詢
   IF tm.sdate=l_pdate_s1 AND tm.edate=l_pdate_e2 THEN
      LET l_flag=TRUE
   ELSE
      LET l_flag=FALSE
   END IF
   LET l_wc=cl_replace_str(g_wc,'glaq002','glar001')
   LET l_wc2=cl_replace_str(g_wc2,'glaq005','glar009')
   IF g_wc1<>' 1=1' AND NOT cl_null(g_wc1) THEN
      LET l_flag=FALSE
   END IF   
   #顯示外幣否
   IF tm.curr_o='Y' THEN
      LET l_str=",glar009"
      LET l_str1=",glaq005"
      LET l_str2=",glaq005 glar009"
      LET l_str3=" AND glar009=?"
      LET l_str4=" AND glaq005=?"
   ELSE
      LET l_str=",''"
      LET l_str1=",''"
      LET l_str2=",''"
      LET l_str3=''
      LET l_str4=''
   END IF
   #科目條件
   LET l_wc_glac002=cl_replace_str(g_wc,'glaq002','glac002')
   #顯示統制科目否
   IF tm.show_acc<>'Y' THEN
      LET l_sql1=l_sql1," AND glac003<>'1' "
   END IF
   #科目層級
   IF NOT cl_null(tm.glac005) THEN
      LET l_sql1=l_sql1," AND glac005<=",tm.glac005
   END IF
   #含內部管理科目否
   IF tm.glac009<>'Y' THEN
      LET l_sql1=l_sql1," AND glac009<>'Y' "
   END IF
#151204-00013#6--mark--str--
#   #顯示月結CE憑證否
#   IF tm.show_ce<>'Y' THEN
#      LET l_sql2=l_sql2," AND glap007<>'CE' "
#      LET l_sql3="'CE'"
#   END IF
#151204-00013#6--mark--end
   #顯示年結YE憑證否
   IF tm.show_ye<>'Y' THEN
      LET l_sql2=l_sql2," AND glap007<>'YE' "
      IF NOT cl_null(l_sql3) THEN
         LET l_sql3=l_sql3,",'YE'"
      ELSE
         LET l_sql3="'YE'" 
      END IF
   END IF
   #150827-00036#2--add--str--
   #顯示AD審計調整傳票否
   IF tm.show_ad<>'Y' THEN
      LET l_sql2=l_sql2," AND glap007<>'AD' "
      IF NOT cl_null(l_sql3) THEN
         LET l_sql3=l_sql3,",'AD'"
      ELSE
         LET l_sql3="'AD'" 
      END IF
   END IF
   #150827-00036#2--add--end
   IF NOT cl_null(l_sql3) THEN
      LET l_sql3=" AND glap007 IN (",l_sql3,")"
   END IF
   #單據狀態
   CASE
      WHEN tm.stus='1'
         LET l_sql4=l_sql4," AND glapstus='S' "
      WHEN tm.stus='2'
         LET l_sql4=l_sql4," AND glapstus IN ('S','Y') "
      WHEN tm.stus='3'
         LET l_sql4=l_sql4," AND glapstus IN ('S','Y','N') "
   END CASE
   
   #160505-00007#16--add--str--
   #限定科目存在于glar_t和glaq_t表中
   LET l_glac002_sql="SELECT DISTINCT glar001 FROM (",
                     "  SELECT glar001 FROM glar_t ",
                     "  WHERE glarent=",g_enterprise," AND glarld='",g_glaald,"' ",
                     "    AND glar002<=",tm.eyear,
                     "  UNION ",
                     "  SELECT glaq002 glar001 ",
                     "    FROM glaq_t ",
                     "  INNER JOIN glap_t ON glapent=glaqent AND glapld = glaqld AND glapdocno = glaqdocno ",
                     "  WHERE glaqent=",g_enterprise," AND glaqld='",g_glaald,"' ",
                     "    AND glapdocdt <= '",tm.edate,"'",l_sql4,
                     ")"
   #160505-00007#16--add--end
   
   #抓出所有符合條件的會計科目
   #161125-00012#1--mod--str--
#   LET g_sql="SELECT glac002 FROM glac_t",
#             " WHERE glacent=",g_enterprise,
#             "   AND glac001='",g_glaa004,"' AND ",l_wc_glac002,l_sql1,
#             "   AND glac002 IN (",l_glac002_sql,")",   #160505-00007#16 add
#             " ORDER BY glac002"
   LET g_sql="SELECT glac002,glac003 FROM glac_t",
             " WHERE glacent=",g_enterprise,
             "   AND glac001='",g_glaa004,"' AND ",l_wc_glac002,l_sql1
   #当未勾选统治科目或整期间和已过账时，限定科目存在于余额档和凭证明细档中
   IF tm.show_acc <> 'Y' OR (l_flag=TRUE AND tm.stus='1') THEN
      LET g_sql=g_sql,"   AND glac002 IN (",l_glac002_sql,")"
   END IF
   LET g_sql=g_sql," ORDER BY glac002"
   #161125-00012#1--mod--str--
   PREPARE aglq760_sel_glac_pr FROM g_sql
   DECLARE aglq760_sel_glac_cs CURSOR FOR aglq760_sel_glac_pr
#160505-00007#16--mark--str--
#   #整期間&含月結傳票&含年結傳票&審計調整傳票
#   IF l_flag=TRUE AND tm.show_ce='Y' AND tm.show_ye='Y' AND tm.show_ad='Y' THEN #150827-00036#2 add 'tm.show_ad'
#      #勾選顯示原幣
#      IF tm.curr_o='Y' THEN
#         #抓取幣別
#         LET g_sql="(SELECT DISTINCT glar009 FROM glar_t ",
#                   "  WHERE glarent=",g_enterprise," AND glarld='",g_glaald,"' ",
#                   "    AND glar001=? "
#         IF tm.syear<>tm.eyear THEN
#            LET g_sql=g_sql," AND ((glar002=",tm.syear," AND glar003>=",tm.speriod,") ",
#                            "  OR (glar002=",tm.eyear," AND glar003<=",tm.eperiod,")) "
#         ELSE
#            LET g_sql=g_sql," AND glar002=",tm.syear,
#                            " AND glar003 <= ",tm.eperiod
#         END IF
#         LET g_sql=g_sql," AND ",l_wc," AND ",l_wc2,")"
#      END IF
#      #單據狀態      
#      IF tm.stus MATCHES '[23]' THEN
#         #勾選顯示原幣
#         IF tm.curr_o='Y' THEN
#            #抓取幣別
#            LET g_sql=g_sql," UNION ALL ",
#                      "(SELECT DISTINCT glaq005 glar009",
#                      "   FROM glaq_t",
#                      "  INNER JOIN glap_t ON glapent=glaqent AND glapld = glaqld AND glapdocno = glaqdocno ",
#                      "  WHERE glaqent=",g_enterprise," AND glaqld='",g_glaald,"' ",
#                      "    AND glapdocdt BETWEEN '",tm.sdate,"' AND '",tm.edate,"'",
#                      "    AND glaq002=? "
#            CASE
#                WHEN tm.stus='2'
#                   LET g_sql=g_sql," AND glapstus='Y'"
#                WHEN tm.stus='3'
#                   LET g_sql=g_sql," AND glapstus IN ('Y','N')"
#            END CASE
#            LET g_sql=g_sql,l_sql2," AND ",g_wc," AND ",g_wc1," AND ",g_wc2,")"
#         END IF
#      END IF
#      
#      #勾選顯示原幣
#      IF tm.curr_o='Y' THEN
#         LET g_sql="SELECT DISTINCT glar009 ",
#                   "  FROM (",g_sql,")",
#                   " ORDER BY glar009"
#      END IF
#   ELSE
#      #勾選顯示原幣
#      IF tm.curr_o='Y' THEN
#         LET g_sql="SELECT DISTINCT glaq005 ",
#                   "  FROM glaq_t INNER JOIN glap_t ON glapent=glaqent AND glapld = glaqld AND glapdocno = glaqdocno ",
#                   "  LEFT OUTER JOIN glac_t ON glacent=glaqent AND glac002=glaq002 AND glac001='",g_glaa004,"'",
#                   " WHERE glaqent=",g_enterprise," AND glaqld='",g_glaald,"' AND glaq002=?",
#                   "   AND glapdocdt BETWEEN '",tm.sdate,"' AND '",tm.edate,"'"
#         LET g_sql=g_sql,l_sql1,l_sql2,l_sql4," AND ",g_wc," AND ",g_wc1," AND ",g_wc2,
#                   " ORDER BY glaq005"
#      END IF
#   END IF
#   #勾選顯示原幣
#   IF tm.curr_o='Y' THEN
#      PREPARE aglq760_sel_curr_pr FROM g_sql
#      DECLARE aglq760_sel_curr_cr CURSOR FOR aglq760_sel_curr_pr
#   END IF
#160505-00007#16--mark--end
#160505-00007#16--add--str--
   #勾選顯示原幣
   IF tm.curr_o='Y' THEN
      #整期間&含月結傳票&含年結傳票&審計調整傳票&单据状态=1.已过账
      IF l_flag=TRUE AND tm.show_ce='Y' AND tm.show_ye='Y' AND tm.show_ad='Y' AND tm.stus='1' THEN
         #抓取幣別
         LET g_sql="SELECT DISTINCT glac002,glac003,glar009 FROM glar_t,glac_t ", #161125-00012#1 add glac003
                   " WHERE glacent=glarent AND glac002=glar001 ",
                   "   AND glac001='",g_glaa004,"' AND ",l_wc_glac002,l_sql1,
                   "   AND glarent=",g_enterprise," AND glarld='",g_glaald,"' "
         IF tm.syear<>tm.eyear THEN
            LET g_sql=g_sql," AND ((glar002=",tm.syear," AND glar003>=",tm.speriod,") ",
                            "   OR (glar002>",tm.syear," AND glar002<",tm.eyear,")", #161125-00012#1 add
                            "   OR (glar002=",tm.eyear," AND glar003<=",tm.eperiod,")) "
         ELSE
            LET g_sql=g_sql," AND glar002=",tm.syear,
                            " AND glar003 <= ",tm.eperiod
         END IF
         LET g_sql=g_sql," AND ",l_wc," AND ",l_wc2,
                         " ORDER BY glac002,glar009"
      ELSE
         IF tm.show_acc <> 'Y' THEN #161125-00012#1 add
            LET g_sql="SELECT DISTINCT glac002,glac003,glaq005 ", #161125-00012#1 glac003
                      #170216-00033#1--add--str--
                      " FROM (",
                      " SELECT glac002,glac003,glaq005 ",
                      #170216-00033#1--add--end
                      "  FROM glac_t,",
                      "       glaq_t INNER JOIN glap_t ON glapent=glaqent AND glapld = glaqld AND glapdocno = glaqdocno ",
                      " WHERE glacent=glaqent AND glac002=glaq002 ",
                      "   AND glac001='",g_glaa004,"' AND ",l_wc_glac002,l_sql1,
                      "   AND glaqent=",g_enterprise," AND glaqld='",g_glaald,"' ",
                      "   AND glapdocdt BETWEEN '",tm.sdate,"' AND '",tm.edate,"'",
                      l_sql1,l_sql2,l_sql4," AND ",g_wc," AND ",g_wc1," AND ",g_wc2,
                      #170216-00033#1--add--str--
                      " UNION ",
                      " SELECT glac002,glac003,glar009 glaq005 FROM glar_t,glac_t ",
                      " WHERE glacent=glarent AND glac002=glar001 ",
                      "   AND glac001='",g_glaa004,"' AND ",l_wc_glac002,l_sql1,
                      "   AND glarent=",g_enterprise," AND glarld='",g_glaald,"' ",
                      "   AND glar002=",tm.syear," AND glar003=0",
                      ")",
                      #170216-00033#1--add--end
                      " ORDER BY glac002,glaq005"
         #161125-00012#1--add--str--
         #当显示统制科目时，只能通过下层科目抓取币别
         ELSE
            LET l_str_glaq005="SELECT DISTINCT glaq005 ",
                              #170216-00033#1--add--str--
                              " FROM (",
                              " SELECT glar009 glaq005 FROM glar_t ",
                              "  WHERE glarent=",g_enterprise," AND glarld='",g_glaald,"' ",
                              "    AND glar002=",tm.syear," AND glar003=0",
                              "    AND glar001=? ",
                              "  UNION ",
                              "  SELECT glaq005 ",
                              #170216-00033#1--add--end
                              "  FROM glaq_t INNER JOIN glap_t ON glapent=glaqent AND glapld = glaqld AND glapdocno = glaqdocno ",
                              " WHERE glaqent=",g_enterprise," AND glaqld='",g_glaald,"' ",
                              "   AND glapdocdt BETWEEN '",tm.sdate,"' AND '",tm.edate,"'",
#                              l_sql2,l_sql4," AND ",g_wc," AND ",g_wc1," AND ",g_wc2   #170214-00018#1 mark
                              l_sql2,l_sql4," AND ",g_wc1," AND ",g_wc2   #170214-00018#1 add
         END IF   
         #161125-00012#1--add--end
      END IF
      PREPARE aglq760_sel_curr_pr FROM g_sql
      DECLARE aglq760_sel_curr_cr CURSOR FOR aglq760_sel_curr_pr
   END IF
#160505-00007#16--add--end

   #期初餘額（整期）
   LET l_sql="SELECT SUM(glar010),SUM(glar011),SUM(glar005),SUM(glar006),",
             "       SUM(glar034),SUM(glar035),SUM(glar036),SUM(glar037) FROM glar_t",    
             " WHERE glarent=",g_enterprise," AND glarld='",g_glaald,"' ",
             "   AND glar001=? AND glar002=? AND glar003<=? "
   IF tm.curr_o='Y' THEN
      LET l_sql=l_sql," AND glar009=? "
   END IF
   PREPARE aglq760_sel_pr1 FROM l_sql
   #160503-00037#6  by 07900 --add-str
   #本年累計（整期）
   LET l_sql="SELECT SUM(glar010),SUM(glar011),SUM(glar005),SUM(glar006),",
             "       SUM(glar034),SUM(glar035),SUM(glar036),SUM(glar037) FROM glar_t",    
             " WHERE glarent=",g_enterprise," AND glarld='",g_glaald,"' ",
             "   AND glar001=? AND glar002=? AND glar003<=? AND glar003<>0 "
   IF tm.curr_o='Y' THEN
      LET l_sql=l_sql," AND glar009=? "
   END IF
   PREPARE aglq760_sel_pr01 FROM l_sql
   #160503-00037#6  by 07900 --add-end
   
   #160511-00006#3--add--str--
   #年初余额
   LET l_sql="SELECT SUM(glar010-glar011),SUM(glar005-glar006),",
             "       SUM(glar034-glar035),SUM(glar036-glar037) FROM glar_t",    
             " WHERE glarent=",g_enterprise," AND glarld='",g_glaald,"' ",
             "   AND glar001=? AND glar002=? AND glar003=0 "
   IF tm.curr_o='Y' THEN
      LET l_sql=l_sql," AND glar009=? "
   END IF
   PREPARE aglq760_year_sum_pr FROM l_sql
   #160511-00006#3--add--end
   
   #期初：抓取YE、AD憑證金額
   IF tm.show_ye<>'Y' OR tm.show_ad<>'Y' THEN  #160505-00007#16 add
      LET l_sql_pr2="SELECT SUM(CASE WHEN glaq003>0 THEN glaq010 ELSE 0 END),", #161125-00012#1 mod l_sql-->l_sql_pr2
                "       SUM(CASE WHEN glaq003=0 THEN glaq010 ELSE 0 END),",
                "       SUM(glaq003),SUM(glaq004),SUM(glaq040),SUM(glaq041),",
                "       SUM(glaq043),SUM(glaq044) ",
                "  FROM glaq_t INNER JOIN glap_t ON glapent=glaqent AND glapld = glaqld AND glapdocno = glaqdocno ",
                " WHERE glaqent=",g_enterprise," AND glaqld='",g_glaald,"' ",
#                "   AND glaq002=? ",               #161125-00012#1 mark
                "   AND glap002=? AND glap004<=?  ",
                "   AND glapstus='S'",
#                "   AND ",g_wc,l_sql3 #170214-00018#1 mark
                l_sql3 #170214-00018#1 add
      
      IF tm.curr_o='Y' THEN
         LET l_sql_pr2=l_sql_pr2," AND glaq005=? " #161125-00012#1 mod l_sql-->l_sql_pr2
      END IF
#      PREPARE aglq760_sel_pr2 FROM l_sql #161125-00012#1 mark
   END IF  #160505-00007#16 add
   
   #151204-00013#6--add--str--
   #当未勾选含月结凭证时，要排除CE凭证中损益类科目金额和XC凭证中成本类科目金额
   IF tm.show_ce <> 'Y' THEN
      #期初：抓取CE、XC憑證金額
      LET l_sql_pr2_1="SELECT SUM(CASE WHEN glaq003>0 THEN glaq010 ELSE 0 END),",  #161125-00012#1 mod l_sql-->l_sql_pr2_1
                "       SUM(CASE WHEN glaq003=0 THEN glaq010 ELSE 0 END),",
                "       SUM(glaq003),SUM(glaq004),SUM(glaq040),SUM(glaq041),",
                "       SUM(glaq043),SUM(glaq044) ",
                "  FROM glaq_t INNER JOIN glap_t ON glapent=glaqent AND glapld = glaqld AND glapdocno = glaqdocno ",
                " WHERE glaqent=",g_enterprise," AND glaqld='",g_glaald,"' ",
#                "   AND glaq002=? ",  #161125-00012#1 mark
#                "   AND glap002=? AND glap004<=?  ", #161125-00012#1 mark
                "   AND glap002=? AND glapdocdt<=? ", #161125-00012#1 add
#                "   AND ",g_wc,l_sql4 #170214-00018#1 mark
                l_sql4 #170214-00018#1 add
#161125-00012#1--mark--str--
#                ,
#                "   AND (",
#                "        (glap007='CE' AND glaq002 IN (SELECT glac002 FROM glac_t ",
#                "                                       WHERE glacent=",g_enterprise," AND glac001='",g_glaa004,"'",
#                "                                         AND glac007='6' AND glac002=? ))",
#                "         OR ",
#                "        (glap007='XC' AND glaq002 IN (SELECT glac002 FROM glac_t ",
#                "                                       WHERE glacent=",g_enterprise," AND glac001='",g_glaa004,"'",
#                "                                         AND glac010 <> 'N' ",   #160824-00004#2 排除非费用类科目
##                "                                         AND glac007='5' AND glac002=? ))", #160824-00004#4 mark
#                #160824-00004#4--add--str--
#                "                                         AND glac007='5' AND glac002=?",
#                "                                     )",
##                "                      AND glapdocno NOT IN (SELECT xcea101 FROM xcea_t ", #161027-00022#1 mark
#                "                      AND glapdocno IN (SELECT xcea101 FROM xcea_t ",      #161027-00022#1 add
#                "                                             WHERE xceaent=",g_enterprise," AND xceald='",g_glaald,"'",
##                "                                               AND xcea002 IN ('7','9') AND xcea101 IS NOT NULL", #161027-00022#1 mark
#                "                                               AND xcea002 ='9' AND xcea101 IS NOT NULL", #161027-00022#1 add
#                "                                               AND xcea004=? AND xcea005<=? ",
#                "                                     )",
#                "        )",
#                #160824-00004#4--add--end
#                "       )"
 #161125-00012#--mark--end
               
      IF tm.curr_o='Y' THEN
         LET l_sql_pr2_1=l_sql_pr2_1," AND glaq005=? " #161125-00012#1 mod l_sql-->l_sql_pr2_1
      END IF
#      PREPARE aglq760_sel_pr2_1 FROM l_sql #161125-00012#1 mark
   END IF
   #151204-00013#6--add--end
   
   #破期或狀態=2：含已審核、3：全部
   LET l_sql_pr3="SELECT SUM(CASE WHEN glaq003>0 THEN glaq010 ELSE 0 END),", #161125-00012#1 mod l_sql-->l_sql_pr3
             "       SUM(CASE WHEN glaq003=0 THEN glaq010 ELSE 0 END),",
             "       SUM(glaq003),SUM(glaq004),SUM(glaq040),SUM(glaq041),",
             "       SUM(glaq043),SUM(glaq044) ",
             "  FROM glaq_t INNER JOIN glap_t ON glapent=glaqent AND glapld = glaqld AND glapdocno = glaqdocno ",
             " WHERE glaqent=",g_enterprise," AND glaqld='",g_glaald,"' ",
#             "   AND glaq002=? ", #161125-00012#1 mark
             "   AND glapdocdt BETWEEN ? AND ? ",
#             "   AND ",g_wc,l_sql2,l_sql4 #170214-00018#1 mark
             l_sql2,l_sql4 #170214-00018#1
   
   IF tm.curr_o='Y' THEN
      LET l_sql_pr3=l_sql_pr3," AND glaq005=? " #161125-00012#1 mod l_sql-->l_sql_pr3
   END IF
#   PREPARE aglq760_sel_pr3 FROM l_sql #161125-00012#1 mark
   
   #明細傳票資料
   LET l_sql_pr4="SELECT glapdocdt,glapdocno,glap007,glaq001,glaq005,glaq006,", ##151204-00013#6 add glap007 #161125-00012#1 mod l_sql-->l_sql_pr4
             "       (CASE WHEN glaq003>0 THEN glaq010 ELSE 0 END),",
             "       (CASE WHEN glaq003=0 THEN glaq010 ELSE 0 END),",
             "       glaq003,glaq004,glaq039,glaq040,glaq041,glaq042,glaq043,glaq044",
             "  FROM glaq_t INNER JOIN glap_t ON glapent=glaqent AND glapld = glaqld AND glapdocno = glaqdocno ",
             " WHERE glaqent=",g_enterprise," AND glaqld='",g_glaald,"' ",
#             "   AND glaq002=? ", #161125-00012#1 mark
             "   AND glapdocdt BETWEEN ? AND ? ",
#             "   AND ",g_wc," AND ",g_wc1," AND ",g_wc2,l_sql2,l_sql4 #170214-00018#1 mark
             " AND ",g_wc1," AND ",g_wc2,l_sql2,l_sql4 #170214-00018#1 add
#161125-00012#1--mark--str--
#   IF tm.curr_o='Y' THEN
#      LET l_sql=l_sql," AND glaq005=? " 
#   END IF
#   LET l_sql=l_sql,"ORDER BY glapdocno,glapdocdt"
#   PREPARE aglq760_sel_pr4 FROM l_sql 
#   DECLARE aglq760_sel_cs4 CURSOR FOR aglq760_sel_pr4   
#161125-00012#1--mark--end

   CALL cl_err_collect_init()
   LET l_success = TRUE
   LET l_seq=1
   LET l_glar001_t=''
   LET l_glar009_t=''
   #起始年度第一天
   SELECT MIN(glav004) INTO l_glav004 FROM glav_t 
   WHERE glavent=g_enterprise AND glav001=g_glaa003 AND glav002=tm.syear
   #抓取上一期最後一天
   LET l_period=tm.speriod-1 #上期
   SELECT MAX(glav004) INTO l_glav004_m FROM glav_t
    WHERE glavent=g_enterprise AND glav001=g_glaa003 AND glav002=tm.syear AND glav006=l_period
   #获取期初截止日期
   IF tm.sdate=l_pdate_s1 THEN
      LET l_glav004_e=l_glav004_m
   ELSE
      LET l_glav004_e=tm.sdate-1
   END IF
   
   #160505-00007#16--add--str--
   #摘要栏位存储说明栏位内容，说明栏位隐藏
   LET l_glaq001_1=s_desc_gzcbl004_desc('9927','1')
   LET l_glaq001_2=s_desc_gzcbl004_desc('9927','2')
   LET l_glaq001_3=s_desc_gzcbl004_desc('9927','3')
   
   #期初、本期合計、本年累计      
   LET l_sql="INSERT INTO aglq760_tmp(",
             " seq,     glaq002, glap004,glaq001,style,  glaq005,",
             " glaq010d,glaq010c,glaq003,glaq004,glaq040,glaq041,",
             " glaq043, glaq044, state,  amt,    amt1,   amt2,",
             " amt3) ",
             "VALUES(?,?,?,?,?,?,",
             "       ?,?,?,?,?,?,",
             "       ?,?,?,?,?,?,",
             "       ?)"
   PREPARE aglq760_ins_pr1 FROM l_sql
               
   #期间异动
   LET l_sql="INSERT INTO aglq760_tmp(",
             " seq,     glaq002, glapdocdt,glaqdocno,glaq001,glaq005,glaq006,",
             " glaq010d,glaq010c,glaq003,  glaq004,  glaq039,glaq040,glaq041,",
             " glaq042, glaq043, glaq044,  state,    amt,    amt1,   amt2,",
             " amt3)",
             "VALUES(?,?,?,?,?,?,?,",
             "       ?,?,?,?,?,?,?,",
             "       ?,?,?,?,?,?,?,",
             "       ?)"
   PREPARE aglq760_ins_pr2 FROM l_sql
   
   SELECT MAX(glav006) INTO l_glav006_max FROM glav_t
    WHERE glavent=g_enterprise AND glav001=g_glaa003 AND glav002=tm.syear
   #抓取期别最大日期及最小日期
   LET l_sql="SELECT MIN(glav004),MAX(glav004) FROM glav_t ",
             " WHERE glavent=",g_enterprise," AND glav001='",g_glaa003,"'",
             "   AND glav002=? AND glav006=? "
   PREPARE aglq760_glav_sel_pr FROM l_sql
   #160505-00007#16--add--end
   
   LET l_i=1 
   CALL l_glar.clear()
#160505-00007#16--mark--str--
#   FOREACH aglq760_sel_glac_cs INTO l_glac002
#      IF SQLCA.sqlcode THEN
#         INITIALIZE g_errparam TO NULL
#         LET g_errparam.code = SQLCA.sqlcode
#         LET g_errparam.extend = 'FOREACH aglq760_sel_glac_cs'
#         LET g_errparam.popup = TRUE
#         CALL cl_err()
#         LET l_success = FALSE
#         EXIT FOREACH
#      END IF
#      #勾選顯示原幣
#      IF tm.curr_o='Y' THEN
#         FOREACH aglq760_sel_curr_cr USING l_glac002 INTO l_glar009
#            IF SQLCA.sqlcode THEN
#               INITIALIZE g_errparam TO NULL
#               LET g_errparam.code = SQLCA.sqlcode
#               LET g_errparam.extend = 'FOREACH aglq760_sel_curr_cr'
#               LET g_errparam.popup = TRUE
#               CALL cl_err()
#               LET l_success = FALSE
#               EXIT FOREACH
#            END IF
#            LET l_glar[l_i].glar001=l_glac002
#            LET l_glar[l_i].glar009=l_glar009
#            LET l_i=l_i+1
#         END FOREACH
#      ELSE
#         LET l_glar[l_i].glar001=l_glac002
#         LET l_i=l_i+1
#      END IF
#   END FOREACH
#160505-00007#16--mark--end

#160505-00007#16--add--str--
   IF tm.curr_o<>'Y' THEN
      FOREACH aglq760_sel_glac_cs INTO l_glar[l_i].glar001,l_glar[l_i].glac003 #161125-00012#1 add glac003
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = SQLCA.sqlcode
            LET g_errparam.extend = 'FOREACH aglq760_sel_glac_cs'
            LET g_errparam.popup = TRUE
            CALL cl_err()
            LET l_success = FALSE
            EXIT FOREACH
         END IF
         #161125-00012#1--add--str--
         LET l_glaq002_str=''
         IF l_glar[l_i].glac003 = '1' THEN
            #抓取科目对应的明细科目或者独立科目
             CALL s_voucher_get_glac_str(g_glaa004,l_glar[l_i].glar001) RETURNING l_glaq002_str
         END IF            
         IF cl_null(l_glaq002_str) THEN
            LET l_glaq002_str = " AND glaq002='",l_glar[l_i].glar001,"'"
         ELSE
            LET l_glaq002_str = " AND glaq002 IN (",l_glaq002_str,")"
         END IF
         LET l_glar[l_i].glaq002_str = l_glaq002_str
         #161125-00012#1--add--end
      
         LET l_i=l_i+1
      END FOREACH
   ELSE
      #勾選顯示原幣
      IF (l_flag=TRUE AND tm.show_ce='Y' AND tm.show_ye='Y' AND tm.show_ad='Y' AND tm.stus='1') OR tm.show_acc<>'Y' THEN #161125-00012#1 add
         FOREACH aglq760_sel_curr_cr INTO l_glar[l_i].glar001,l_glar[l_i].glac003,l_glar[l_i].glar009 #161125-00012#1 add glac003
            IF SQLCA.sqlcode THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = SQLCA.sqlcode
               LET g_errparam.extend = 'FOREACH aglq760_sel_curr_cr'
               LET g_errparam.popup = TRUE
               CALL cl_err()
               LET l_success = FALSE
               EXIT FOREACH
            END IF
            
            #161125-00012#1--add--str--
            LET l_glaq002_str=''
            IF l_glar[l_i].glac003 = '1' THEN
               #抓取科目对应的明细科目或者独立科目
                CALL s_voucher_get_glac_str(g_glaa004,l_glar[l_i].glar001) RETURNING l_glaq002_str
            END IF            
            IF cl_null(l_glaq002_str) THEN
               LET l_glaq002_str = " AND glaq002='",l_glar[l_i].glar001,"'"
            ELSE
               LET l_glaq002_str = " AND glaq002 IN (",l_glaq002_str,")"
            END IF
            LET l_glar[l_i].glaq002_str = l_glaq002_str
            #161125-00012#1--add--end
            
            LET l_i=l_i+1
         END FOREACH
      #161125-00012#1--add--str--
      ELSE
         FOREACH aglq760_sel_glac_cs INTO l_glac002,l_glac003
            IF SQLCA.sqlcode THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = SQLCA.sqlcode
               LET g_errparam.extend = 'FOREACH aglq760_sel_glac_cs'
               LET g_errparam.popup = TRUE
               CALL cl_err()
               LET l_success = FALSE
               EXIT FOREACH
            END IF
            LET l_glaq002_str=''
            IF l_glac003 = '1' THEN
               #抓取科目对应的明细科目或者独立科目
                CALL s_voucher_get_glac_str(g_glaa004,l_glac002) RETURNING l_glaq002_str
            END IF            
            IF cl_null(l_glaq002_str) THEN
               LET l_glaq002_str = " AND glaq002='",l_glac002,"'"
            ELSE
               LET l_glaq002_str = " AND glaq002 IN (",l_glaq002_str,")"
            END IF
            
            #抓取币别资料
            LET l_sql=l_str_glaq005,l_glaq002_str,
                      " )", #170216-00033#1 add
                      " ORDER BY glaq005 "
            PREPARE aglq760_sel_glaq005_pr FROM l_sql
            DECLARE aglq760_sel_glaq005_cs CURSOR FOR aglq760_sel_glaq005_pr
            
#            FOREACH aglq760_sel_glaq005_cs INTO l_glar[l_i].glar009 #170216-00033#1 mark
            FOREACH aglq760_sel_glaq005_cs USING l_glac002 INTO l_glar[l_i].glar009 #170216-00033#1 add
               IF SQLCA.sqlcode THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = SQLCA.sqlcode
                  LET g_errparam.extend = 'FOREACH aglq760_sel_glaq005_cs'
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
                  LET l_success = FALSE
                  EXIT FOREACH
               END IF
               LET l_glar[l_i].glar001=l_glac002
               LET l_glar[l_i].glac003=l_glac003
               LET l_glar[l_i].glaq002_str = l_glaq002_str
               LET l_i=l_i+1
            END FOREACH
         END FOREACH
      END IF
      #161125-00012#1--add--end
   END IF
   CALL l_glar.deleteElement(l_glar.getLength())
#160505-00007#16--add--end

   FOR l_i=1 TO l_glar.getLength()
      LET l_flag_amt = FALSE 
      LET l_glar001=l_glar[l_i].glar001
      LET l_glar009=l_glar[l_i].glar009
      
      #161125-00012#1--add--str--
      #由于科目可能是统制科目，当查询glaq_t时，将科目组入SQL语句中
      LET l_glac003=l_glar[l_i].glac003
      LET l_glaq002_str=l_glar[l_i].glaq002_str 
      
      #期初：抓取YE、AD憑證金額
      IF tm.show_ye<>'Y' OR tm.show_ad<>'Y' THEN
         LET l_sql = l_sql_pr2,l_glaq002_str
         PREPARE aglq760_sel_pr2 FROM l_sql
      END IF
      
      #破期或狀態=2：含已審核、3：全部
      LET l_sql = l_sql_pr3,l_glaq002_str
      PREPARE aglq760_sel_pr3 FROM l_sql
      
      #当未勾选含月结凭证时，要排除CE凭证中损益类科目金额和XC凭证中成本类科目金额
      IF tm.show_ce <> 'Y' THEN
         LET l_glac002_str=cl_replace_str(l_glaq002_str,"glaq002","glac002")
         LET l_sql = l_sql_pr2_1,l_glaq002_str,
         "   AND (",
         "        (glap007='CE' AND glaq002 IN (SELECT glac002 FROM glac_t ",
         "                                       WHERE glacent=",g_enterprise," AND glac001='",g_glaa004,"'",
         "                                         AND glac007='6' ",l_glac002_str,"))",
         "         OR ",
         "        (glap007='XC' AND glaq002 IN (SELECT glac002 FROM glac_t ",
         "                                       WHERE glacent=",g_enterprise," AND glac001='",g_glaa004,"'",
         "                                         AND glac010 <> 'N' ",   #排除非费用类科目
         "                                         AND glac007='5' ",l_glac002_str,
         "                                     )",
         "                      AND glapdocno IN (SELECT xcea101 FROM xcea_t ",
         "                                             WHERE xceaent=",g_enterprise," AND xceald='",g_glaald,"'",
         "                                               AND xcea002 ='9' AND xcea101 IS NOT NULL",
         "                                               AND xcea004=? AND xcea102<=? ",
         "                                     )",
         "        )",
         "       )"
         PREPARE aglq760_sel_pr2_1 FROM l_sql 
      END IF
      
      #明細傳票資料
      LET l_sql=l_sql_pr4,l_glaq002_str
      IF tm.curr_o='Y' THEN
         LET l_sql=l_sql," AND glaq005='",l_glar009,"'"
      END IF
      LET l_sql=l_sql," ORDER BY glapdocno,glapdocdt"
      PREPARE aglq760_sel_pr4 FROM l_sql 
      DECLARE aglq760_sel_cs4 CURSOR FOR aglq760_sel_pr4 
      
      #161125-00012#1--add--end
      
      #期初餘額   
      LET l_oamt_d=0
      LET l_oamt_c=0
      LET l_amt1=0
      LET l_amt2=0
      LET l_amt3=0 
      LET l_amt4=0
      LET l_amt5=0
      LET l_amt6=0
      LET l_osum_d=0
      LET l_osum_c=0
      LET l_sum1=0
      LET l_sum2=0
      LET l_sum3=0
      LET l_sum4=0
      LET l_sum5=0
      LET l_sum6=0
      LET l_state=NULL
         
      #整期且狀態=1：已過帳
      IF tm.sdate=l_pdate_s1 AND tm.stus='1' THEN
         LET l_period=tm.speriod-1 #上期
         IF tm.curr_o='Y' THEN
            EXECUTE aglq760_sel_pr1 USING l_glar001,tm.syear,l_period,l_glar009 
                                     INTO l_oamt_d,l_oamt_c,l_amt1,l_amt2,l_amt3,l_amt4,l_amt5,l_amt6
            LET l_glaq005=l_glar009
         ELSE
            EXECUTE aglq760_sel_pr1 USING l_glar001,tm.syear,l_period 
                                     INTO l_oamt_d,l_oamt_c,l_amt1,l_amt2,l_amt3,l_amt4,l_amt5,l_amt6
            LET l_glaq005=NULL
         END IF
         IF SQLCA.sqlcode THEN
#            CALL cl_errmsg('','aglq760_sel_pr1','',SQLCA.sqlcode,1)
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = SQLCA.sqlcode
            LET g_errparam.extend = 'aglq760_sel_pr1'
            LET g_errparam.popup = TRUE
            CALL cl_err()
            LET l_success = FALSE
         END IF
         IF cl_null(l_oamt_d) THEN LET l_oamt_d=0 END IF
         IF cl_null(l_oamt_c) THEN LET l_oamt_c=0 END IF
         IF cl_null(l_amt1) THEN LET l_amt1=0 END IF
         IF cl_null(l_amt2) THEN LET l_amt2=0 END IF
         IF cl_null(l_amt3) THEN LET l_amt3=0 END IF
         IF cl_null(l_amt4) THEN LET l_amt4=0 END IF
         IF cl_null(l_amt5) THEN LET l_amt5=0 END IF
         IF cl_null(l_amt6) THEN LET l_amt6=0 END IF
         #當不包含CE或YE或AD傳票時，減去CE或YE或AD傳票金額
#         IF tm.show_ce<>'Y' OR tm.show_ye<>'Y' OR tm.show_ad<>'Y' THEN #150827-00036#2 add 'tm.show_ad' #151204-00013#6 mark
         IF tm.show_ye<>'Y' OR tm.show_ad<>'Y' THEN #151204-00013#6 add
            IF tm.curr_o='Y' THEN
#               EXECUTE aglq760_sel_pr2 USING l_glar001,tm.syear,l_period,l_glar009 #161125-00012#1 mark
               EXECUTE aglq760_sel_pr2 USING tm.syear,l_period,l_glar009 #161125-00012#1 add
                                        INTO l_osum_d,l_osum_c,l_sum1,l_sum2,l_sum3,l_sum4,l_sum5,l_sum6
            ELSE
#               EXECUTE aglq760_sel_pr2 USING l_glar001,tm.syear,l_period #161125-00012#1 mark
               EXECUTE aglq760_sel_pr2 USING tm.syear,l_period #161125-00012#1 add
                                        INTO l_osum_d,l_osum_c,l_sum1,l_sum2,l_sum3,l_sum4,l_sum5,l_sum6
            END IF
            IF SQLCA.sqlcode THEN
#               CALL cl_errmsg('','aglq760_sel_pr2','',SQLCA.sqlcode,1)
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = SQLCA.sqlcode
               LET g_errparam.extend = 'aglq760_sel_pr2'
               LET g_errparam.popup = TRUE
               CALL cl_err()
               LET l_success = FALSE
            END IF
            IF cl_null(l_osum_d) THEN LET l_osum_d=0 END IF
            IF cl_null(l_osum_c) THEN LET l_osum_c=0 END IF
            IF cl_null(l_sum1) THEN LET l_sum1=0 END IF
            IF cl_null(l_sum2) THEN LET l_sum2=0 END IF
            IF cl_null(l_sum3) THEN LET l_sum3=0 END IF
            IF cl_null(l_sum4) THEN LET l_sum4=0 END IF
            IF cl_null(l_sum5) THEN LET l_sum5=0 END IF
            IF cl_null(l_sum6) THEN LET l_sum6=0 END IF
            LET l_oamt_d=l_oamt_d-l_osum_d
            LET l_oamt_c=l_oamt_c-l_osum_c
            LET l_amt1=l_amt1-l_sum1
            LET l_amt2=l_amt2-l_sum2
            LET l_amt3=l_amt3-l_sum3
            LET l_amt4=l_amt4-l_sum4
            LET l_amt5=l_amt5-l_sum5
            LET l_amt6=l_amt6-l_sum6
         END IF
      ELSE
         #年初餘額
         LET l_period=0
         IF tm.curr_o='Y' THEN
            EXECUTE aglq760_sel_pr1 USING l_glar001,tm.syear,l_period,l_glar009 
                                     INTO l_oamt_d,l_oamt_c,l_amt1,l_amt2,l_amt3,l_amt4,l_amt5,l_amt6
            LET l_glaq005=l_glar009
         ELSE
            EXECUTE aglq760_sel_pr1 USING l_glar001,tm.syear,l_period 
                                     INTO l_oamt_d,l_oamt_c,l_amt1,l_amt2,l_amt3,l_amt4,l_amt5,l_amt6
            LET l_glaq005=NULL
         END IF
         IF SQLCA.sqlcode THEN
#            CALL cl_errmsg('','aglq760_sel_pr1','',SQLCA.sqlcode,1)
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = SQLCA.sqlcode
            LET g_errparam.extend = 'aglq760_sel_pr1'
            LET g_errparam.popup = TRUE
            CALL cl_err()
            LET l_success = FALSE
         END IF
         IF cl_null(l_oamt_d) THEN LET l_oamt_d=0 END IF
         IF cl_null(l_oamt_c) THEN LET l_oamt_c=0 END IF
         IF cl_null(l_amt1) THEN LET l_amt1=0 END IF
         IF cl_null(l_amt2) THEN LET l_amt2=0 END IF
         IF cl_null(l_amt3) THEN LET l_amt3=0 END IF
         IF cl_null(l_amt4) THEN LET l_amt4=0 END IF
         IF cl_null(l_amt5) THEN LET l_amt5=0 END IF
         IF cl_null(l_amt6) THEN LET l_amt6=0 END IF
#         LET l_period=tm.speriod-1 #上期  #151231-00004#1 mark
#         IF l_period>0 THEN               #151231-00004#1 mark
         #破期抓取傳票檔資料
         #抓取起始年的第一天到起始日期的前一天
         IF tm.curr_o='Y' THEN
#            EXECUTE aglq760_sel_pr3 USING l_glar001,l_glav004,l_glav004_e,l_glar009 #161125-00012#1 mark
            EXECUTE aglq760_sel_pr3 USING l_glav004,l_glav004_e,l_glar009 #161125-00012#1 add
                                     INTO l_osum_d,l_osum_c,l_sum1,l_sum2,l_sum3,l_sum4,l_sum5,l_sum6
         ELSE
#            EXECUTE aglq760_sel_pr3 USING l_glar001,l_glav004,l_glav004_e #161125-00012#1 mark
            EXECUTE aglq760_sel_pr3 USING l_glav004,l_glav004_e #161125-00012#1 add
                                     INTO l_osum_d,l_osum_c,l_sum1,l_sum2,l_sum3,l_sum4,l_sum5,l_sum6
         END IF
         IF SQLCA.sqlcode THEN
#            CALL cl_errmsg('','aglq760_sel_pr3','',SQLCA.sqlcode,1)
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = SQLCA.sqlcode
            LET g_errparam.extend = 'aglq760_sel_pr3'
            LET g_errparam.popup = TRUE
            CALL cl_err()
            LET l_success = FALSE
         END IF
         IF cl_null(l_osum_d) THEN LET l_osum_d=0 END IF
         IF cl_null(l_osum_c) THEN LET l_osum_c=0 END IF
         IF cl_null(l_sum1) THEN LET l_sum1=0 END IF
         IF cl_null(l_sum2) THEN LET l_sum2=0 END IF
         IF cl_null(l_sum3) THEN LET l_sum3=0 END IF
         IF cl_null(l_sum4) THEN LET l_sum4=0 END IF
         IF cl_null(l_sum5) THEN LET l_sum5=0 END IF
         IF cl_null(l_sum6) THEN LET l_sum6=0 END IF
         LET l_oamt_d=l_oamt_d+l_osum_d
         LET l_oamt_c=l_oamt_c+l_osum_c
         LET l_amt1=l_amt1+l_sum1
         LET l_amt2=l_amt2+l_sum2
         LET l_amt3=l_amt3+l_sum3
         LET l_amt4=l_amt4+l_sum4
         LET l_amt5=l_amt5+l_sum5
         LET l_amt6=l_amt6+l_sum6
#         END IF   #151231-00004#1 mark
      END IF
      
      #151204-00013#6--add--str--
      #当未勾选含月结凭证时，要排除CE凭证中损益类科目金额和XC凭证中成本类科目金额
      IF tm.show_ce <> 'Y' THEN
         #期初：抓取CE、XC憑證金額
         LET l_osum_d=0
         LET l_osum_c=0
         LET l_sum1=0
         LET l_sum2=0
         LET l_sum3=0
         LET l_sum4=0
         LET l_sum5=0
         LET l_sum6=0
         LET l_period=tm.speriod-1 #上期  #160824-00004#4
         LET l_date = tm.sdate - 1 #161125-00012#1 add
         IF tm.curr_o='Y' THEN
#            EXECUTE aglq760_sel_pr2_1 USING l_glar001,tm.syear,l_period,l_glar001,l_glar001,l_glar009 #161125-00012#1 mark
            EXECUTE aglq760_sel_pr2_1 USING tm.syear,l_date,l_glar009,tm.syear,l_date #161125-00012#1 add
#                                           ,tm.syear,l_period #160824-00004#4 #161125-00012#1 mark
                                     INTO l_osum_d,l_osum_c,l_sum1,l_sum2,l_sum3,l_sum4,l_sum5,l_sum6
         ELSE
#            EXECUTE aglq760_sel_pr2_1 USING l_glar001,tm.syear,l_period,l_glar001,l_glar001 #161125-00012#1 mark
            EXECUTE aglq760_sel_pr2_1 USING tm.syear,l_date,tm.syear,l_date #161125-00012#1 add
#                                           ,tm.syear,l_period #160824-00004#4 #161125-00012#1 mark
                                     INTO l_osum_d,l_osum_c,l_sum1,l_sum2,l_sum3,l_sum4,l_sum5,l_sum6
         END IF
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = SQLCA.sqlcode
            LET g_errparam.extend = 'aglq760_sel_pr2_1'
            LET g_errparam.popup = TRUE
            CALL cl_err()
            LET l_success = FALSE
         END IF
         IF cl_null(l_osum_d) THEN LET l_osum_d=0 END IF
         IF cl_null(l_osum_c) THEN LET l_osum_c=0 END IF
         IF cl_null(l_sum1) THEN LET l_sum1=0 END IF
         IF cl_null(l_sum2) THEN LET l_sum2=0 END IF
         IF cl_null(l_sum3) THEN LET l_sum3=0 END IF
         IF cl_null(l_sum4) THEN LET l_sum4=0 END IF
         IF cl_null(l_sum5) THEN LET l_sum5=0 END IF
         IF cl_null(l_sum6) THEN LET l_sum6=0 END IF
         LET l_oamt_d=l_oamt_d-l_osum_d
         LET l_oamt_c=l_oamt_c-l_osum_c
         LET l_amt1=l_amt1-l_sum1
         LET l_amt2=l_amt2-l_sum2
         LET l_amt3=l_amt3-l_sum3
         LET l_amt4=l_amt4-l_sum4
         LET l_amt5=l_amt5-l_sum5
         LET l_amt6=l_amt6-l_sum6
      END IF
      #151204-00013#6--add--end
      
      LET l_glaq010d= l_oamt_d
      LET l_glaq010c= l_oamt_c
      LET l_glaq003 = l_amt1
      LET l_glaq004 = l_amt2
      LET l_glaq040 = l_amt3
      LET l_glaq041 = l_amt4
      LET l_glaq043 = l_amt5
      LET l_glaq044 = l_amt6
      #余额
      LET l_oamt = l_oamt_d - l_oamt_c
      LET l_amt1 = l_amt1 -l_amt2 #（本币一余额）
      LET l_amt2 = l_amt3 -l_amt4 #（本币二余额）
      LET l_amt3 = l_amt5 -l_amt6 #（本币三余额）
      #借貸平否
      CASE
         WHEN l_amt1>0 
            LET l_state='1'
         WHEN l_amt1<0
            LET l_state='2'
            LET l_oamt=(-1)*l_oamt
            LET l_amt1=(-1)*l_amt1
            LET l_amt2=(-1)*l_amt2
            LET l_amt3=(-1)*l_amt3
         WHEN l_amt1=0
            LET l_state='3'
      END CASE
      
      #判斷是否有期初金額，如果有標示為TRUE
      IF l_state<>'3' THEN LET l_flag_amt = TRUE END IF
      #150716-00015#1--add--str--
      #摘要栏位存储说明栏位内容，说明栏位隐藏
#160505-00007#16--mod--str--
#      LET l_glaq001=s_desc_gzcbl004_desc('9927','1')
#      #150716-00015#1--add--end
#      INSERT INTO aglq760_tmp(seq,glaq002,glaq001,style,glaq005,glaq010d,glaq010c,glaq003,glaq004,glaq040,glaq041,
#                              glaq043,glaq044,state,amt,amt1,amt2,amt3)
#      VALUES(l_seq,l_glar001,l_glaq001,'1',l_glaq005,l_glaq010d,l_glaq010c,l_glaq003,l_glaq004,l_glaq040,l_glaq041,
#                              l_glaq043,l_glaq044,l_state,l_oamt,l_amt1,l_amt2,l_amt3)
      LET l_glap004 = NULL
      LET l_style='1'
      EXECUTE aglq760_ins_pr1 USING l_seq,l_glar001,l_glap004,l_glaq001_1,l_style,l_glaq005,
                                    l_glaq010d,l_glaq010c,l_glaq003,l_glaq004,l_glaq040,l_glaq041,
                                    l_glaq043,l_glaq044,l_state,l_oamt,l_amt1,l_amt2,l_amt3
#160505-00007#16--mod--end
      IF SQLCA.sqlcode THEN
#         CALL cl_errmsg('','insert','',SQLCA.sqlcode,1)
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = 'insert'
         LET g_errparam.popup = TRUE
         CALL cl_err()
         LET l_success = FALSE
      END IF
      LET l_seq=l_seq+1
      
      #記錄期初金額及借貸狀態
      #160914-00030#1--mark--str--
#      LET l_state_qc=l_state
#      LET l_oamt_qc=l_oamt
#      LET l_amt1_qc=l_amt1
#      LET l_amt2_qc=l_amt2
#      LET l_amt3_qc=l_amt3
      #160914-00030#1--mark--end
      LET l_glar001_t=l_glar001
      LET l_glar009_t=l_glar009
      
      LET l_glar003=tm.speriod
      LET l_glar002=tm.syear
      #當查詢時間範圍不是同一年，獲取起始年度的最大期別
      IF tm.syear<>tm.eyear THEN
         #160505-00007#16--mod--str--
#         SELECT MAX(glav006) INTO l_period_max FROM glav_t
#          WHERE glavent=g_enterprise AND glav001=g_glaa003 AND glav002=tm.syear
         LET l_period_max = l_glav006_max
         #160505-00007#16--mod--end
      END IF
     
      WHILE TRUE
         #查詢期間是同一年
         IF tm.syear=tm.eyear THEN
            IF l_glar003 > tm.eperiod THEN
               EXIT WHILE
            END IF
         ELSE
            IF l_glar003 > l_period_max THEN
               EXIT WHILE
            END IF
         END IF
         
         #抓取該期起始、截止日期
         #160505-00007#16--mod--str--
#         CALL s_get_accdate(g_glaa003,'',l_glar002,l_glar003) 
#         RETURNING l_flag1,l_errno,l_glav002,l_glav005,l_sdate_s,l_sdate_e,
#                   l_glav006,l_pdate_s3,l_pdate_e3,l_glav007,l_wdate_s,l_wdate_e
         EXECUTE aglq760_glav_sel_pr USING l_glar002,l_glar003 INTO l_pdate_s3,l_pdate_e3
         #160505-00007#16--mod--end          
         LET l_glav004_m=l_pdate_e3 #該期截止日期
         IF l_glar002=tm.syear AND l_glar003=tm.speriod THEN
            IF l_pdate_s3<>tm.sdate THEN
               LET l_pdate_s3=tm.sdate
            END IF
         END IF
         IF l_glar002=tm.eyear AND l_glar003=tm.eperiod THEN
            IF l_pdate_e3<>tm.edate THEN
               LET l_pdate_e3=tm.edate
            END IF
         END IF
         
         #借貸方金額
         LET l_glaq003_s=0
         LET l_glaq004_s=0
         LET l_glaq040_s=0
         LET l_glaq041_s=0
         LET l_glaq043_s=0
         LET l_glaq044_s=0
         LET l_glaq010d_s=0
         LET l_glaq010c_s=0
      
         LET l_glaq010d= 0
         LET l_glaq010c= 0
         LET l_glaq003 = 0
         LET l_glaq004 = 0
         LET l_glaq040 = 0
         LET l_glaq041 = 0
         LET l_glaq043 = 0
         LET l_glaq044 = 0
         
         #160503-00037#4 add by 02599--str--
         #160914-00030#1--mod--str--         
#         LET l_state=l_state_qc
#         LET l_oamt=l_oamt_qc
#         LET l_amt1=l_amt1_qc
#         LET l_amt2=l_amt2_qc
#         LET l_amt3=l_amt3_qc
         LET l_state='3'
         LET l_oamt=0
         LET l_amt1=0
         LET l_amt2=0
         LET l_amt3=0
         #160914-00030#1--mod--end
         #160503-00037#4 add by 02599--end
         
         #傳票明細資料
         #161125-00012#1--mark--str--
#         IF tm.curr_o='Y' THEN
#            OPEN aglq760_sel_cs4 USING l_glar001,l_pdate_s3,l_pdate_e3,l_glar009
#         ELSE
#            OPEN aglq760_sel_cs4 USING l_glar001,l_pdate_s3,l_pdate_e3
#         END IF
         #161125-00012#1--mark--end
         
         #161125-00012#1--mod--str--
#         FOREACH aglq760_sel_cs4 INTO l_glapdocdt,l_glapdocno,l_glap007,l_glaq001,l_glaq005,l_glaq006,l_glaq010d,l_glaq010c, #151204-00013#6 add l_glap007
         FOREACH aglq760_sel_cs4 USING l_pdate_s3,l_pdate_e3
                                 INTO l_glapdocdt,l_glapdocno,l_glap007,l_glaq001,
                                      l_glaq005,l_glaq006,l_glaq010d,l_glaq010c,
         #161125-00012#1--mod--end
                                      l_glaq003,l_glaq004,l_glaq039,l_glaq040,l_glaq041,
                                      l_glaq042,l_glaq043,l_glaq044
            IF SQLCA.sqlcode THEN
#               CALL cl_errmsg('','FOREACH aglq760_sel_cs4','',SQLCA.sqlcode,1)
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = SQLCA.sqlcode
               LET g_errparam.extend = 'FOREACH aglq760_sel_cs4'
               LET g_errparam.popup = TRUE
               CALL cl_err()
               LET l_success = FALSE
               EXIT FOREACH
            END IF
            
            #151204-00013#6--add--str--
            #当未勾选含月结凭证时，要排除CE凭证中损益类科目金额和XC凭证中成本类科目金额
            IF tm.show_ce <> 'Y' THEN
               IF l_glap007 = 'CE' OR l_glap007 = 'XC' THEN
                  SELECT glac007,glac010 INTO l_glac007,l_glac010 FROM glac_t   #160824-00004#2 add glac010
                   WHERE glacent=g_enterprise AND glac001=g_glaa004 AND glac002=l_glar001
                  IF l_glap007 = 'CE' AND l_glac007 = '6' THEN
                     CONTINUE FOREACH
                  END IF
                  #160824-00004#4--add--str--
                  LET l_xcea002=''
                  SELECT xcea002 INTO l_xcea002 FROM xcea_t
                   WHERE xceaent=g_enterprise AND xceald=g_glaald
                     AND xcea101=l_glapdocno
                  #160824-00004#4--add--end
                  #160824-00004#4--mod--str--
#                  IF l_glap007 = 'XC' AND l_glac007 = '5' AND l_glac010 <> 'N' THEN #160824-00004#2 add l_glac010<>N
                  IF l_glap007 = 'XC' AND l_glac007 = '5' AND l_glac010 <> 'N' 
#                     AND l_xcea002<>'7' AND l_xcea002<>'9' #161027-00022#1 mark
                     AND l_xcea002 = '9' #161027-00022#1 add
                  THEN
                  #160824-00004#4--mod--end
                     CONTINUE FOREACH
                  END IF
               END IF
            END IF
            #151204-00013#6--add--end
            
            IF cl_null(l_glaq010d) THEN LET l_glaq010d=0 END IF
            IF cl_null(l_glaq010c) THEN LET l_glaq010c=0 END IF
            IF cl_null(l_glaq003) THEN LET l_glaq003=0 END IF
            IF cl_null(l_glaq004) THEN LET l_glaq004=0 END IF
            IF cl_null(l_glaq040) THEN LET l_glaq040=0 END IF
            IF cl_null(l_glaq041) THEN LET l_glaq041=0 END IF
            IF cl_null(l_glaq043) THEN LET l_glaq043=0 END IF
            IF cl_null(l_glaq044) THEN LET l_glaq044=0 END IF
            
            #本期期間異動金額匯總
            LET l_glaq010d_s=l_glaq010d_s+l_glaq010d
            LET l_glaq010c_s=l_glaq010c_s+l_glaq010c
            LET l_glaq003_s=l_glaq003_s+l_glaq003
            LET l_glaq004_s=l_glaq004_s+l_glaq004
            LET l_glaq040_s=l_glaq040_s+l_glaq040
            LET l_glaq041_s=l_glaq041_s+l_glaq041
            LET l_glaq043_s=l_glaq043_s+l_glaq043
            LET l_glaq044_s=l_glaq044_s+l_glaq044
            
            #餘額計算
            LET l_osum=l_glaq010d-l_glaq010c
            LET l_sum1=l_glaq003-l_glaq004
	         LET l_sum2=l_glaq040-l_glaq041
	         LET l_sum3=l_glaq043-l_glaq044
            #借餘
            IF l_state='1' THEN 
               LET l_oamt=l_osum+l_oamt
               LET l_amt1=l_sum1+l_amt1
               LET l_amt2=l_sum2+l_amt2
               LET l_amt3=l_sum3+l_amt3
            END IF
            #貸餘
            IF l_state='2' THEN 
               LET l_oamt=l_osum-l_oamt
               LET l_amt1=l_sum1-l_amt1
               LET l_amt2=l_sum2-l_amt2
               LET l_amt3=l_sum3-l_amt3
            END IF
            #平
            IF l_state='3' THEN 
               LET l_oamt=l_osum
               LET l_amt1=l_sum1
               LET l_amt2=l_sum2
               LET l_amt3=l_sum3
            END IF
            #借貸平否
            CASE
               WHEN l_amt1>0 
                  LET l_state='1'
               WHEN l_amt1<0
                  LET l_state='2'
                  LET l_oamt=(-1)*l_oamt
                  LET l_amt1=(-1)*l_amt1
                  LET l_amt2=(-1)*l_amt2
                  LET l_amt3=(-1)*l_amt3
               WHEN l_amt1=0
                  LET l_state='3'
            END CASE
            
            #160505-00007#16--mod--str--
#            INSERT INTO aglq760_tmp(seq,glaq002,glapdocdt,glaqdocno,glaq001,glaq005,glaq006,
#                                    glaq010d,glaq010c,glaq003,glaq004,glaq039,glaq040,glaq041,
#                                    glaq042,glaq043,glaq044,state,amt,amt1,amt2,amt3)
#            VALUES(l_seq,l_glar001,l_glapdocdt,l_glapdocno,l_glaq001,l_glaq005,l_glaq006,l_glaq010d,l_glaq010c,
#                   l_glaq003,l_glaq004,l_glaq039,l_glaq040,l_glaq041,l_glaq042,l_glaq043,l_glaq044,
#                   l_state,l_oamt,l_amt1,l_amt2,l_amt3)
            EXECUTE aglq760_ins_pr2 
            USING l_seq,l_glar001,l_glapdocdt,l_glapdocno,l_glaq001,l_glaq005,l_glaq006,
                  l_glaq010d,l_glaq010c,l_glaq003,l_glaq004,l_glaq039,l_glaq040,l_glaq041,
                  l_glaq042,l_glaq043,l_glaq044,l_state,l_oamt,l_amt1,l_amt2,l_amt3
            #160505-00007#16--mod--end
            IF SQLCA.sqlcode THEN
#               CALL cl_errmsg('','insert','',SQLCA.sqlcode,1)
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = SQLCA.sqlcode
               LET g_errparam.extend = 'insert'
               LET g_errparam.popup = TRUE
               CALL cl_err()
               LET l_success = FALSE
            END IF
            LET l_seq=l_seq+1 
            #判斷是否有明細資料
            IF l_flag_amt = FALSE THEN 
               LET l_flag_amt = TRUE 
            END IF
         END FOREACH
         CLOSE aglq760_sel_cs4
         FREE aglq760_sel_pr4
      
         #150716-00015#1--add--str--
         #摘要栏位存储说明栏位内容，说明栏位隐藏
         #160505-00007#16--mod--str--
#         LET l_glaq001=s_desc_gzcbl004_desc('9927','2')
#         #150716-00015#1--add--end
#         #本期合計      
#         INSERT INTO aglq760_tmp(seq,glaq002,glap004,glaq001,style,glaq005,
#                                 glaq010d,glaq010c,glaq003,glaq004,glaq040,glaq041,
#                                 glaq043,glaq044,state,amt,amt1,amt2,amt3)
#         VALUES(l_seq,l_glar001,l_glar003,l_glaq001,'2',l_glaq005,l_glaq010d_s,l_glaq010c_s,
#                l_glaq003_s,l_glaq004_s,l_glaq040_s,l_glaq041_s,l_glaq043_s,l_glaq044_s,
#                l_state,l_oamt,l_amt1,l_amt2,l_amt3)
         LET l_style='2'
         EXECUTE aglq760_ins_pr1 
         USING l_seq,l_glar001,l_glar003,l_glaq001_2,l_style,l_glaq005,
               l_glaq010d_s,l_glaq010c_s,l_glaq003_s,l_glaq004_s,l_glaq040_s,l_glaq041_s,
               l_glaq043_s,l_glaq044_s,l_state,l_oamt,l_amt1,l_amt2,l_amt3
         #160505-00007#16--mod--end
         IF SQLCA.sqlcode THEN
#            CALL cl_errmsg('','insert','',SQLCA.sqlcode,1)
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = SQLCA.sqlcode
            LET g_errparam.extend = 'insert'
            LET g_errparam.popup = TRUE
            CALL cl_err()
            LET l_success = FALSE
         END IF
         LET l_seq=l_seq+1
         #160503-00037#4 add by 02599--str--
         #記錄期初金額及借貸狀態
#160914-00030#1--mark--str--
#         LET l_state_qc=l_state
#         LET l_oamt_qc=l_oamt
#         LET l_amt1_qc=l_amt1
#         LET l_amt2_qc=l_amt2
#         LET l_amt3_qc=l_amt3
#160914-00030#1--mark--end
         #160503-00037#4 add by 02599--end
         
         #本年累計
         #整期且狀態=1：已審核
         IF l_glav004_m=l_pdate_e3 AND tm.stus='1' THEN
            IF tm.curr_o='Y' THEN
               EXECUTE aglq760_sel_pr01 USING l_glar001,l_glar002,l_glar003,l_glar009  #160503-00037#6  by 07900 -mod  "aglq760_sel_pr1"-->"aglq760_sel_pr01"
                                        INTO l_oamt_d,l_oamt_c,l_amt1,l_amt2,l_amt3,l_amt4,l_amt5,l_amt6
               LET l_glaq005=l_glar009
            ELSE
               EXECUTE aglq760_sel_pr01 USING l_glar001,l_glar002,l_glar003             #160503-00037#6  by 07900 -mod  "aglq760_sel_pr1"-->"aglq760_sel_pr01"
                                        INTO l_oamt_d,l_oamt_c,l_amt1,l_amt2,l_amt3,l_amt4,l_amt5,l_amt6
               LET l_glaq005=NULL
            END IF
            IF SQLCA.sqlcode THEN
#               CALL cl_errmsg('','aglq760_sel_pr1','',SQLCA.sqlcode,1)
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = SQLCA.sqlcode
               LET g_errparam.extend = 'aglq760_sel_pr01'   #160503-00037#6  by 07900 -mod  "aglq760_sel_pr1"-->"aglq760_sel_pr01"
               LET g_errparam.popup = TRUE
               CALL cl_err()
               LET l_success = FALSE
            END IF
            IF cl_null(l_oamt_d) THEN LET l_oamt_d=0 END IF
            IF cl_null(l_oamt_c) THEN LET l_oamt_c=0 END IF
            IF cl_null(l_amt1) THEN LET l_amt1=0 END IF
            IF cl_null(l_amt2) THEN LET l_amt2=0 END IF
            IF cl_null(l_amt3) THEN LET l_amt3=0 END IF
            IF cl_null(l_amt4) THEN LET l_amt4=0 END IF
            IF cl_null(l_amt5) THEN LET l_amt5=0 END IF
            IF cl_null(l_amt6) THEN LET l_amt6=0 END IF
            #當不包含YE或AD傳票時，減去YE或AD傳票金額
#            IF tm.show_ce<>'Y' OR tm.show_ye<>'Y' OR tm.show_ad<>'Y' THEN #150827-00036#2 add 'tm.show_ad' #151204-00013#6 mark
            IF tm.show_ye<>'Y' OR tm.show_ad<>'Y' THEN #151204-00013#6 add
               IF tm.curr_o='Y' THEN
#                  EXECUTE aglq760_sel_pr2 USING l_glar001,l_glar002,l_glar003,l_glar009 #161125-00012#1 mark
                  EXECUTE aglq760_sel_pr2 USING l_glar002,l_glar003,l_glar009 #161125-00012#1 add
                                           INTO l_osum_d,l_osum_c,l_sum1,l_sum2,l_sum3,l_sum4,l_sum5,l_sum6
               ELSE
#                  EXECUTE aglq760_sel_pr2 USING l_glar001,l_glar002,l_glar003 #161125-00012#1 mark
                  EXECUTE aglq760_sel_pr2 USING l_glar002,l_glar003 #161125-00012#1 add
                                           INTO l_osum_d,l_osum_c,l_sum1,l_sum2,l_sum3,l_sum4,l_sum5,l_sum6
               END IF
               IF SQLCA.sqlcode THEN
#                  CALL cl_errmsg('','aglq760_sel_pr2','',SQLCA.sqlcode,1)
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = SQLCA.sqlcode
                  LET g_errparam.extend = 'aglq760_sel_pr2'
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
                  LET l_success = FALSE
               END IF
               IF cl_null(l_osum_d) THEN LET l_osum_d=0 END IF
               IF cl_null(l_osum_c) THEN LET l_osum_c=0 END IF
               IF cl_null(l_sum1) THEN LET l_sum1=0 END IF
               IF cl_null(l_sum2) THEN LET l_sum2=0 END IF
               IF cl_null(l_sum3) THEN LET l_sum3=0 END IF
               IF cl_null(l_sum4) THEN LET l_sum4=0 END IF
               IF cl_null(l_sum5) THEN LET l_sum5=0 END IF
               IF cl_null(l_sum6) THEN LET l_sum6=0 END IF
               LET l_oamt_d=l_oamt_d-l_osum_d
               LET l_oamt_c=l_oamt_c-l_osum_c
               LET l_amt1=l_amt1-l_sum1
               LET l_amt2=l_amt2-l_sum2
               LET l_amt3=l_amt3-l_sum3
               LET l_amt4=l_amt4-l_sum4
               LET l_amt5=l_amt5-l_sum5
               LET l_amt6=l_amt6-l_sum6
            END IF
         ELSE
            #年初餘額
            #160503-00037#6  by 07900  mark--str
          #  LET l_period=0
           # IF tm.curr_o='Y' THEN
           #    EXECUTE aglq760_sel_pr1 USING l_glar001,tm.syear,l_period,l_glar009 
           #                             INTO l_oamt_d,l_oamt_c,l_amt1,l_amt2,l_amt3,l_amt4,l_amt5,l_amt6
           #    LET l_glaq005=l_glar009
           # ELSE
           #    EXECUTE aglq760_sel_pr1 USING l_glar001,tm.syear,l_period 
           #                             INTO l_oamt_d,l_oamt_c,l_amt1,l_amt2,l_amt3,l_amt4,l_amt5,l_amt6
           #    LET l_glaq005=NULL
           # END IF
           # IF SQLCA.sqlcode THEN
#               CALL cl_errmsg('','aglq760_sel_pr1','',SQLCA.sqlcode,1)
           #    INITIALIZE g_errparam TO NULL
           #    LET g_errparam.code = SQLCA.sqlcode
           #    LET g_errparam.extend = 'aglq760_sel_pr1'
           #    LET g_errparam.popup = TRUE
           #    CALL cl_err()
           #    LET l_success = FALSE
            #END IF
            
          #  IF cl_null(l_oamt_d) THEN LET l_oamt_d=0 END IF
         #   IF cl_null(l_oamt_c) THEN LET l_oamt_c=0 END IF
         #   IF cl_null(l_amt1) THEN LET l_amt1=0 END IF
        #    IF cl_null(l_amt2) THEN LET l_amt2=0 END IF
         #   IF cl_null(l_amt3) THEN LET l_amt3=0 END IF
         #   IF cl_null(l_amt4) THEN LET l_amt4=0 END IF
        #    IF cl_null(l_amt5) THEN LET l_amt5=0 END IF
        #    IF cl_null(l_amt6) THEN LET l_amt6=0 END IF
           #160503-00037#6  by 07900  mark--end
            #破期抓取傳票檔資料
            IF tm.curr_o='Y' THEN
#               EXECUTE aglq760_sel_pr3 USING l_glar001,l_glav004,l_pdate_e3,l_glar009 #161125-00012#1 mark
               EXECUTE aglq760_sel_pr3 USING l_glav004,l_pdate_e3,l_glar009 #161125-00012#1 add
                                        INTO l_osum_d,l_osum_c,l_sum1,l_sum2,l_sum3,l_sum4,l_sum5,l_sum6
               LET l_glaq005=l_glar009 #160511-00006#3 add
            ELSE
#               EXECUTE aglq760_sel_pr3 USING l_glar001,l_glav004,l_pdate_e3 #161125-00012#1 mark
               EXECUTE aglq760_sel_pr3 USING l_glav004,l_pdate_e3 #161125-00012#1 add
                                        INTO l_osum_d,l_osum_c,l_sum1,l_sum2,l_sum3,l_sum4,l_sum5,l_sum6
               LET l_glaq005=NULL #160511-00006#3 add
            END IF
            IF SQLCA.sqlcode THEN
#               CALL cl_errmsg('','aglq760_sel_pr3','',SQLCA.sqlcode,1)
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = SQLCA.sqlcode
               LET g_errparam.extend = 'aglq760_sel_pr3'
               LET g_errparam.popup = TRUE
               CALL cl_err()
               LET l_success = FALSE
            END IF
            IF cl_null(l_osum_d) THEN LET l_osum_d=0 END IF
            IF cl_null(l_osum_c) THEN LET l_osum_c=0 END IF
            IF cl_null(l_sum1) THEN LET l_sum1=0 END IF
            IF cl_null(l_sum2) THEN LET l_sum2=0 END IF
            IF cl_null(l_sum3) THEN LET l_sum3=0 END IF
            IF cl_null(l_sum4) THEN LET l_sum4=0 END IF
            IF cl_null(l_sum5) THEN LET l_sum5=0 END IF
            IF cl_null(l_sum6) THEN LET l_sum6=0 END IF
            #160503-00037#6  by 07900  mark--str 
           # LET l_oamt_d=l_oamt_d+l_osum_d
          #  LET l_oamt_c=l_oamt_c+l_osum_c
           # LET l_amt1=l_amt1+l_sum1
           # LET l_amt2=l_amt2+l_sum2
           # LET l_amt3=l_amt3+l_sum3
           # LET l_amt4=l_amt4+l_sum4
           # LET l_amt5=l_amt5+l_sum5
           # LET l_amt6=l_amt6+l_sum6
             #160503-00037#6  by 07900  mark--end
             #160503-00037#6 add by 07900--str--
            LET l_oamt_d=l_osum_d
            LET l_oamt_c=l_osum_c
            LET l_amt1=l_sum1
            LET l_amt2=l_sum2
            LET l_amt3=l_sum3
            LET l_amt4=l_sum4
            LET l_amt5=l_sum5
            LET l_amt6=l_sum6
            #160503-00037#6 add by 07900--str--
         END IF
         
         #151204-00013#6--add--str--
         #当未勾选含月结凭证时，要排除CE凭证中损益类科目金额和XC凭证中成本类科目金额
         IF tm.show_ce <> 'Y' THEN
            LET l_osum_d=0
            LET l_osum_c=0
            LET l_sum1=0
            LET l_sum2=0
            LET l_sum3=0
            LET l_sum4=0
            LET l_sum5=0
            LET l_sum6=0
            IF tm.curr_o='Y' THEN
#               EXECUTE aglq760_sel_pr2_1 USING l_glar001,l_glar002,l_glar003,l_glar001,l_glar001,l_glar009 #161125-00012#1 mark
               EXECUTE aglq760_sel_pr2_1 USING l_glar002,l_pdate_e3,l_glar009,l_glar002,l_pdate_e3 #161125-00012#1 add
#                                              ,l_glar002,l_glar003  #160824-00004#4 #161125-00012#1 mark
                                        INTO l_osum_d,l_osum_c,l_sum1,l_sum2,l_sum3,l_sum4,l_sum5,l_sum6
            ELSE
#               EXECUTE aglq760_sel_pr2_1 USING l_glar001,l_glar002,l_glar003,l_glar001,l_glar001 #161125-00012#1 mark
               EXECUTE aglq760_sel_pr2_1 USING l_glar002,l_pdate_e3,l_glar002,l_pdate_e3 #161125-00012#1 add
#                                              ,l_glar002,l_glar003  #160824-00004#4 #161125-00012#1 mark
                                        INTO l_osum_d,l_osum_c,l_sum1,l_sum2,l_sum3,l_sum4,l_sum5,l_sum6
            END IF
            IF SQLCA.sqlcode THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = SQLCA.sqlcode
               LET g_errparam.extend = 'aglq760_sel_pr2_1'
               LET g_errparam.popup = TRUE
               CALL cl_err()
               LET l_success = FALSE
            END IF
            IF cl_null(l_osum_d) THEN LET l_osum_d=0 END IF
            IF cl_null(l_osum_c) THEN LET l_osum_c=0 END IF
            IF cl_null(l_sum1) THEN LET l_sum1=0 END IF
            IF cl_null(l_sum2) THEN LET l_sum2=0 END IF
            IF cl_null(l_sum3) THEN LET l_sum3=0 END IF
            IF cl_null(l_sum4) THEN LET l_sum4=0 END IF
            IF cl_null(l_sum5) THEN LET l_sum5=0 END IF
            IF cl_null(l_sum6) THEN LET l_sum6=0 END IF
            LET l_oamt_d=l_oamt_d-l_osum_d
            LET l_oamt_c=l_oamt_c-l_osum_c
            LET l_amt1=l_amt1-l_sum1
            LET l_amt2=l_amt2-l_sum2
            LET l_amt3=l_amt3-l_sum3
            LET l_amt4=l_amt4-l_sum4
            LET l_amt5=l_amt5-l_sum5
            LET l_amt6=l_amt6-l_sum6
         END IF
         #151204-00013#6--add--end
         
         LET l_glaq010d= l_oamt_d
         LET l_glaq010c= l_oamt_c
         LET l_glaq003 = l_amt1
         LET l_glaq004 = l_amt2
         LET l_glaq040 = l_amt3
         LET l_glaq041 = l_amt4
         LET l_glaq043 = l_amt5
         LET l_glaq044 = l_amt6
         
         #160511-00006#3--add--str--
         #本年累计的余额包括年初金额
         LET l_year_osum=0
         LET l_year_sum1=0
         LET l_year_sum2=0
         LET l_year_sum3=0
         IF tm.curr_o='Y' THEN
            EXECUTE aglq760_year_sum_pr USING l_glar001,tm.syear,l_glar009 
                                         INTO l_year_osum,l_year_sum1,l_year_sum2,l_year_sum3
         ELSE
            EXECUTE aglq760_year_sum_pr USING l_glar001,tm.syear
                                         INTO l_year_osum,l_year_sum1,l_year_sum2,l_year_sum3
         END IF
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = SQLCA.sqlcode
            LET g_errparam.extend = 'aglq760_year_sum_pr'
            LET g_errparam.popup = TRUE
            CALL cl_err()
            LET l_success = FALSE
         END IF
         IF cl_null(l_year_osum) THEN LET l_year_osum = 0 END IF
         IF cl_null(l_year_sum1) THEN LET l_year_sum1 = 0 END IF
         IF cl_null(l_year_sum2) THEN LET l_year_sum2 = 0 END IF
         IF cl_null(l_year_sum3) THEN LET l_year_sum3 = 0 END IF
         #160511-00006#3--add--end
         
         #余额
         LET l_oamt = l_oamt_d - l_oamt_c
         LET l_amt1 = l_amt1 -l_amt2 #（本币一余额）
         LET l_amt2 = l_amt3 -l_amt4 #（本币二余额）
         LET l_amt3 = l_amt5 -l_amt6 #（本币三余额）
         
         #160511-00006#3--add--str--
         #本年累计余额=本年累计金额+年初余额
         LET l_oamt = l_oamt + l_year_osum
         LET l_amt1 = l_amt1 + l_year_sum1 #（本币一余额）
         LET l_amt2 = l_amt2 + l_year_sum2 #（本币二余额）
         LET l_amt3 = l_amt3 + l_year_sum3 #（本币三余额）
         #160511-00006#3--add--end
         
         #借貸平否
         CASE
            WHEN l_amt1>0 
               LET l_state='1'
            WHEN l_amt1<0
               LET l_state='2'
               LET l_oamt=(-1)*l_oamt
               LET l_amt1=(-1)*l_amt1
               LET l_amt2=(-1)*l_amt2
               LET l_amt3=(-1)*l_amt3
            WHEN l_amt1=0
               LET l_state='3'
         END CASE
         #150716-00015#1--add--str--
         #摘要栏位存储说明栏位内容，说明栏位隐藏
         #160505-00007#16--mod--str--
#         LET l_glaq001=s_desc_gzcbl004_desc('9927','3')
#         #150716-00015#1--add--end
#         INSERT INTO aglq760_tmp(seq,glaq002,glaq001,style,glaq005,glaq010d,glaq010c,glaq003,glaq004,glaq040,glaq041,
#                                    glaq043,glaq044,state,amt,amt1,amt2,amt3)
#         VALUES(l_seq,l_glar001,l_glaq001,'3',l_glaq005,l_glaq010d,l_glaq010c,l_glaq003,l_glaq004,l_glaq040,l_glaq041,
#                l_glaq043,l_glaq044,l_state,l_oamt,l_amt1,l_amt2,l_amt3)
         LET l_glap004=NULL
         LET l_style='3'
         EXECUTE aglq760_ins_pr1 
         USING l_seq,l_glar001,l_glap004,l_glaq001_3,l_style,l_glaq005,
               l_glaq010d,l_glaq010c,l_glaq003,l_glaq004,l_glaq040,l_glaq041,
               l_glaq043,l_glaq044,l_state,l_oamt,l_amt1,l_amt2,l_amt3
         #160505-00007#16--mod--end
         IF SQLCA.sqlcode THEN
#            CALL cl_errmsg('','insert','',SQLCA.sqlcode,1)
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = SQLCA.sqlcode
            LET g_errparam.extend = 'insert'
            LET g_errparam.popup = TRUE
            CALL cl_err()
            LET l_success = FALSE
         END IF
         LET l_seq=l_seq+1
         IF l_glar002<>tm.eyear AND l_glar003 = l_period_max THEN
            LET l_period_max = tm.eperiod
            LET l_glar003 = 1
            LET l_glar002 = tm.eyear
         ELSE
            LET l_glar003 = l_glar003 + 1
         END IF
      END WHILE
      #當改科目沒有期初金額和期間異動時不用查詢出來
      IF l_flag_amt = FALSE THEN
         IF tm.curr_o ='Y' THEN
            DELETE FROM aglq760_tmp WHERE glaq002=l_glar001 AND glaq005=l_glar009
         ELSE
            DELETE FROM aglq760_tmp WHERE glaq002=l_glar001
         END IF
      END IF
   END FOR
   IF l_success = FALSE THEN
      CALL cl_err_collect_show()
      DELETE FROM aglq760_tmp
   ELSE
      CALL cl_err_collect_init()
      CALL cl_err_collect_show()
   END IF
END FUNCTION

################################################################################
# Descriptions...: 显示资料
# Memo...........:
# Usage..........: CALL aglq760_show()
# Date & Author..:  2014/03/30 By 02599
# Modify.........:
################################################################################
PRIVATE FUNCTION aglq760_show()
    DISPLAY g_glaald,g_glaald_desc,g_glaacomp,g_glaacomp_desc,g_glaa001,g_glaa016,g_glaa020,
           tm.sdate,tm.syear,tm.speriod,tm.edate,tm.eyear,tm.eperiod,tm.ctype,tm.curr_o,tm.curr_p,
           tm.acc_p,tm.show_acc,tm.glac005,tm.stus,tm.glac009,tm.show_ad,tm.show_ce,tm.show_ye
        TO glaald,glaald_desc,glaacomp,glaacomp_desc,glaa001,glaa016,glaa020,
           sdate,syear,speriod,edate,eyear,eperiod,ctype,curr_o,curr_p,
           acc_p,show_acc,glac005,stus,glac009,show_ad,show_ce,show_ye
END FUNCTION

################################################################################
# Descriptions...: 填充单身资料
# Memo...........:
# Usage..........: CALL aglq760_b_fill1()
# Date & Author..: 2014/03/30 By 02599
# Modify.........:
################################################################################
PRIVATE FUNCTION aglq760_b_fill1()
   DEFINE l_seq      LIKE type_t.num10
   DEFINE l_sql      STRING
   DEFINE l_glaq002_desc   STRING   #160505-00007#16 add
   
   #160505-00007#16--add--str--
   LET l_glaq002_desc = "(SELECT glacl004 FROM glacl_t WHERE glaclent = ",g_enterprise,
                        " AND glacl001 = '",g_glaa004,"' AND glacl002 = glaq002 AND glacl003 ='",g_dlang,"')"
   #期初：只显示余额，借贷方金额不显示
   UPDATE aglq760_tmp 
      SET glaq010d= NULL,glaq010c= NULL,
          glaq003 = NULL,glaq004 = NULL,
          glaq040 = NULL,glaq041 = NULL,
          glaq043 = NULL,glaq044 = NULL
    WHERE style = '1'
   #160505-00007#16--add--end
   
#   LET g_sql="SELECT UNIQUE seq,glaq002,'',",                #160505-00007#16 mark
   LET g_sql="SELECT UNIQUE seq,glaq002,",l_glaq002_desc,",", #160505-00007#16 add
             "       glaqdocno,glapdocdt,glaq001,glap004,style,glaq005,glaq006,glaq010d,glaq010c,glaq003,glaq004,",
             "       glaq039,glaq040,glaq041,glaq042,glaq043,glaq044,",
             "       state,amt,amt1,amt2,amt3 ",
             "  FROM aglq760_tmp ",
             "  WHERE 1=1 "#160302-00006#1   ADD by 07675
   #是否按照外幣分頁
   IF NOT cl_null(g_glaq005) THEN
      LET l_sql=" glaq005='",g_glaq005,"'"
   END IF
   #是否按照科目分頁
   IF NOT cl_null(g_glaq002) THEN
      IF cl_null(l_sql) THEN
         LET l_sql=" glaq002='",g_glaq002,"'"
      ELSE
         LET l_sql=l_sql," AND glaq002='",g_glaq002,"'"
      END IF
   END IF
   IF NOT cl_null(l_sql) THEN
     # LET g_sql=g_sql,"  WHERE ",l_sql
     LET g_sql=g_sql,"  AND ",l_sql #160302-00006#1  ADD By 07675 
   END IF
    LET g_sql = g_sql, " AND ",g_wc_filter #160302-00006#1   ADD by 07675
   LET g_sql=g_sql," ORDER BY seq "
  
   PREPARE aglq760_pb1 FROM g_sql
   DECLARE b_fill_curs1 CURSOR FOR aglq760_pb1
   OPEN b_fill_curs1
   
   CALL g_glaq_d.clear()
   LET g_cnt = l_ac
   LET l_ac = 1   
   ERROR "Searching!"
   
   FOREACH b_fill_curs1 INTO l_seq,g_glaq_d[l_ac].glaq002,g_glaq_d[l_ac].glaq002_desc,
       g_glaq_d[l_ac].glaqdocno,g_glaq_d[l_ac].glapdocdt,g_glaq_d[l_ac].glaq001,g_glaq_d[l_ac].glap004,g_glaq_d[l_ac].style, 
       g_glaq_d[l_ac].glaq005,g_glaq_d[l_ac].glaq006,g_glaq_d[l_ac].glaq010d,g_glaq_d[l_ac].glaq010c, 
       g_glaq_d[l_ac].glaq003,g_glaq_d[l_ac].glaq004,g_glaq_d[l_ac].glaq039,g_glaq_d[l_ac].glaq040,g_glaq_d[l_ac].glaq041, 
       g_glaq_d[l_ac].glaq042,g_glaq_d[l_ac].glaq043,g_glaq_d[l_ac].glaq044,g_glaq_d[l_ac].state,g_glaq_d[l_ac].amt, 
       g_glaq_d[l_ac].amt1,g_glaq_d[l_ac].amt2,g_glaq_d[l_ac].amt3
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "FOREACH:"
         LET g_errparam.popup = TRUE
         CALL cl_err()

         EXIT FOREACH
      END IF
      
      #160511-00006#3--add--str--
#160505-00007#16--mark--str--
#      #期初：只显示余额，借贷方金额不显示
#      IF g_glaq_d[l_ac].style = '1' THEN
#         LET g_glaq_d[l_ac].glaq010d= NULL
#         LET g_glaq_d[l_ac].glaq010c= NULL
#         LET g_glaq_d[l_ac].glaq003 = NULL
#         LET g_glaq_d[l_ac].glaq004 = NULL
#         LET g_glaq_d[l_ac].glaq040 = NULL
#         LET g_glaq_d[l_ac].glaq041 = NULL
#         LET g_glaq_d[l_ac].glaq043 = NULL
#         LET g_glaq_d[l_ac].glaq044 = NULL
#      END IF
      #160511-00006#3--add--end
      
#      CALL aglq760_detail_show()  
#160505-00007#16--mark--end
 
      LET l_ac = l_ac + 1
      IF l_ac > g_max_rec THEN
         IF g_error_show = 1 THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code =  9035
            LET g_errparam.extend =  ""
            LET g_errparam.popup = TRUE
            CALL cl_err()

         END IF
         EXIT FOREACH
      END IF
      
   END FOREACH
   LET g_error_show = 0
   
   CALL g_glaq_d.deleteElement(g_glaq_d.getLength())   
    
   LET g_detail_cnt = l_ac - 1 
   DISPLAY g_detail_cnt TO FORMONLY.cnt
   LET l_ac = g_cnt
   LET g_cnt = 0
   
   CLOSE b_fill_curs1
   FREE aglq760_pb1
   
   LET l_ac = 1
END FUNCTION

################################################################################
# Descriptions...: 設置默認值
# Memo...........:
# Usage..........: CALL aglq760_set_default_value()
# Date & Author..: 2014/03/30 By 02599
# Modify.........:
################################################################################
PRIVATE FUNCTION aglq760_set_default_value()
   DEFINE l_flag           LIKE type_t.chr1
   DEFINE l_errno          LIKE type_t.chr100
   DEFINE l_glav002        LIKE glav_t.glav002
   DEFINE l_glav005        LIKE glav_t.glav005
   DEFINE l_sdate_s        LIKE glav_t.glav004
   DEFINE l_sdate_e        LIKE glav_t.glav004
   DEFINE l_glav006        LIKE glav_t.glav006
   DEFINE l_pdate_s        LIKE glav_t.glav004
   DEFINE l_pdate_e        LIKE glav_t.glav004
   DEFINE l_glav007        LIKE glav_t.glav007
   DEFINE l_wdate_s        LIKE glav_t.glav004
   DEFINE l_wdate_e        LIKE glav_t.glav004
   
   CALL s_get_accdate(g_glaa003,g_today,'','')
   RETURNING l_flag,l_errno,l_glav002,l_glav005,l_sdate_s,l_sdate_e,
             l_glav006,l_pdate_s,l_pdate_e,l_glav007,l_wdate_s,l_wdate_e
   IF l_flag='N' THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = l_errno
      LET g_errparam.extend = ''
      LET g_errparam.popup = FALSE
      CALL cl_err()

   END IF
   LET tm.sdate=l_pdate_s  #起始日期
   LET tm.syear=l_glav002
   LET tm.speriod=l_glav006
   LET tm.edate=l_pdate_e  #截止日期
   LET tm.eyear=l_glav002
   LET tm.eperiod=l_glav006
  
   #原幣顯示設置
   LET tm.curr_o='N'
   CALL cl_set_comp_visible('glaq005,glaq006,glaq010d,glaq010c,amt',FALSE)
   LET tm.curr_p='N'
   CALL aglq760_set_comp_entry('curr_p',FALSE)
   #按科目分頁
   LET tm.acc_p='N'
   #統制科目
   LET tm.show_acc='N'
   #科目層級
   LET tm.glac005=99
   #單據狀態
   LET tm.stus='1'
   #含內部管理科目
   LET tm.glac009='Y'
   #含月結傳票
   LET tm.show_ce='Y'
   #含年結傳票
   LET tm.show_ye='Y'
   #150827-00036#2--add--str--
   #含審計調整傳票
   LET tm.show_ad='Y'
   #150827-00036#2--add--end
END FUNCTION

################################################################################
# Descriptions...: 抓取下一筆資料
# Memo...........:
# Usage..........: CALL aglq760_fetch1(p_flag)
# Input parameter: p_flag            
# Date & Author..: 2014/3/30 By 02599
# Modify.........:
################################################################################
PRIVATE FUNCTION aglq760_fetch1(p_flag)
   DEFINE p_flag   LIKE type_t.chr1
   DEFINE ls_msg     STRING
   
   IF g_header_cnt = 0 THEN
      RETURN
   END IF
   
   CASE p_flag
      WHEN 'F' LET g_current_idx = 1
      WHEN 'L' LET g_current_idx = g_header_cnt        
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
         
         IF g_jump > 0 AND g_jump <= g_glaq_s.getLength() THEN
             LET g_current_idx = g_jump
         END IF
         
         LET g_no_ask = FALSE  
   END CASE 
   
   #代表沒有資料
   IF g_current_idx = 0 OR g_glaq_s.getLength() = 0 THEN
      RETURN
   END IF
   
   #超出範圍
   IF g_current_idx > g_glaq_s.getLength() THEN
      LET g_current_idx = g_glaq_s.getLength()
   END IF
   
   DISPLAY g_current_idx TO FORMONLY.h_index
   LET g_glaq002 = g_glaq_s[g_current_idx].glaq002 
   LET g_glaq005 = g_glaq_s[g_current_idx].glaq005
   CALL aglq760_b_fill1() 
END FUNCTION

################################################################################
# Descriptions...: 设置分页
# Memo...........:
# Usage..........: CALL aglq760_set_page()
# Date & Author..: 2014/03/30 By 02599
# Modify.........:
################################################################################
PRIVATE FUNCTION aglq760_set_page()
   DEFINE l_sql    STRING
   DEFINE l_idx    LIKE type_t.num5
   
   CALL g_glaq_s.clear()
   IF tm.curr_p <>'Y' AND tm.acc_p<>'Y' THEN
      LET g_glaq_s[1].glaq002=''
      LET g_glaq_s[1].glaq005=''
      LET g_header_cnt = 1
      LET g_rec_b = 1
   ELSE      
      CASE      
         WHEN tm.acc_p='Y' AND tm.curr_p<>'Y' 
            LET l_sql="SELECT DISTINCT glaq002,'' FROM aglq760_tmp ORDER BY glaq002 "
         WHEN tm.acc_p='Y' AND tm.curr_p='Y' 
            LET l_sql="SELECT DISTINCT glaq002,glaq005 FROM aglq760_tmp ORDER BY glaq002,glaq005 "
         WHEN tm.acc_p<>'Y' AND tm.curr_p='Y'
            LET l_sql="SELECT DISTINCT '',glaq005 FROM aglq760_tmp ORDER BY glaq005 "
      END CASE
      PREPARE aglq760_sel_s_pr FROM l_sql
      DECLARE aglq760_sel_s_cr CURSOR FOR aglq760_sel_s_pr
      LET l_idx=1
      FOREACH aglq760_sel_s_cr INTO g_glaq_s[l_idx].glaq002,g_glaq_s[l_idx].glaq005
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = SQLCA.sqlcode
            LET g_errparam.extend = 'FOREACH aglq760_sel_s_cr'
            LET g_errparam.popup = FALSE
            CALL cl_err()

            EXIT FOREACH
         END IF
         LET l_idx=l_idx+1
         IF l_idx > g_max_rec THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = 9035
            LET g_errparam.extend = ''
            LET g_errparam.popup = FALSE
            CALL cl_err()

            EXIT FOREACH
         END IF
      END FOREACH
      LET l_idx=l_idx - 1
      CALL g_glaq_s.deleteElement(g_glaq_s.getLength())
      LET g_header_cnt = g_glaq_s.getLength()
      LET g_rec_b = l_idx
   END IF
   DISPLAY g_header_cnt TO FORMONLY.h_count
END FUNCTION

################################################################################
# Descriptions...: 動態設定元件是否需輸入值
# Memo...........:
# Usage..........: CALL aglq760_set_comp_entry(ps_fields,pi_entry)
# Input parameter: ps_fields   欄位名稱
#                : pi_entry    是否進入欄位
# Date & Author..: 2014/04/10 By 02599
# Modify.........:
################################################################################
PRIVATE FUNCTION aglq760_set_comp_entry(ps_fields,pi_entry)
   DEFINE ps_fields STRING,
          pi_entry  LIKE type_t.num5           
   DEFINE lst_fields base.StringTokenizer,
          ls_field_name STRING
   DEFINE lwin_curr     ui.Window
   DEFINE lnode_win     om.DomNode,
          llst_items    om.NodeList,
          li_i          LIKE type_t.num5,        
          lnode_item    om.DomNode,
          ls_item_name  STRING
 
   IF g_bgjob = 'Y' AND g_gui_type NOT MATCHES "[13]"  THEN  
      RETURN
   END IF
 
   IF (ps_fields IS NULL) THEN
      RETURN
   END IF
 
   LET ps_fields = ps_fields.toLowerCase()
 
   LET lst_fields = base.StringTokenizer.create(ps_fields, ",")
 
   LET lwin_curr = ui.Window.getCurrent()
   LET lnode_win = lwin_curr.getNode()
 
   LET llst_items = lnode_win.selectByPath("//Form//*")
 
   WHILE lst_fields.hasMoreTokens()
     LET ls_field_name = lst_fields.nextToken()
     LET ls_field_name = ls_field_name.trim()
 
     IF (ls_field_name.getLength() > 0) THEN
        FOR li_i = 1 TO llst_items.getLength()
            LET lnode_item = llst_items.item(li_i)
            LET ls_item_name = lnode_item.getAttribute("colName")
 
            IF (ls_item_name IS NULL) THEN
               LET ls_item_name = lnode_item.getAttribute("name")
 
               IF (ls_item_name IS NULL) THEN
                  CONTINUE FOR
               END IF
            END IF
 
            LET ls_item_name = ls_item_name.trim()
 
            IF (ls_item_name.equals(ls_field_name)) THEN
               IF (pi_entry) THEN
                  CALL lnode_item.setAttribute("noEntry", "0")
                  CALL lnode_item.setAttribute("active", "1")
               ELSE
                  CALL lnode_item.setAttribute("noEntry", "1")
                  CALL lnode_item.setAttribute("active", "0")
               END IF
 
               EXIT FOR
            END IF
        END FOR
     END IF
   END WHILE
END FUNCTION

################################################################################
# Descriptions...: 接收串查參數
# Memo...........:
# Usage..........: CALL aglq760_default_search()
# Modify.........:
################################################################################
PRIVATE FUNCTION aglq760_default_search()
   #帳別
   IF NOT cl_null(g_argv[01]) THEN
      LET g_glaald = g_argv[01]
   END IF
   #起始年度
   IF NOT cl_null(g_argv[02]) THEN
      LET tm.syear = g_argv[02]
   END IF
   #起始期別
   IF NOT cl_null(g_argv[03]) THEN
      LET tm.speriod = g_argv[03]
   END IF
   #截止年度
   IF NOT cl_null(g_argv[04]) THEN
      LET tm.eyear = g_argv[04]
   END IF
   
   #截止期別
   IF NOT cl_null(g_argv[05]) THEN
      LET tm.eperiod = g_argv[05]
   END IF
   
   #多本位幣顯示
   IF NOT cl_null(g_argv[06]) THEN
      LET tm.ctype = g_argv[06]
   END IF
   #顯示原幣
   IF NOT cl_null(g_argv[07]) THEN
      LET tm.curr_o = g_argv[07]
   END IF
   #按幣別分頁
   IF NOT cl_null(g_argv[08]) THEN
      LET tm.curr_p = g_argv[08]
   END IF
   #按科目分頁
   IF NOT cl_null(g_argv[09]) THEN
      LET tm.acc_p = g_argv[09]
   END IF
   #統制科目
   IF NOT cl_null(g_argv[10]) THEN
      LET tm.show_acc = g_argv[10]
   END IF
   #科目層級
   IF NOT cl_null(g_argv[11]) THEN
      LET tm.glac005 = g_argv[11]
   END IF
   #單據狀態
   IF NOT cl_null(g_argv[12]) THEN
      LET tm.stus = g_argv[12]
   END IF
   #含內部管理科目
   IF NOT cl_null(g_argv[13]) THEN
      LET tm.glac009 = g_argv[13]
   END IF
   #含月結傳票
   IF NOT cl_null(g_argv[14]) THEN
      LET tm.show_ce = g_argv[14]
   END IF
   #含年結傳票
   IF NOT cl_null(g_argv[15]) THEN
      LET tm.show_ye = g_argv[15]
   END IF
   #科目
   IF NOT cl_null(g_argv[16]) THEN
      IF g_argv[16]='*' THEN
         LET g_wc = " glaq002 LIKE '%' "
      ELSE
         LET g_wc = " glaq002 = '",g_argv[16],"'"
      END IF
   END IF
   #150827-00036#2--add--str--
   #含審計調整傳票否
   IF NOT cl_null(g_argv[17]) THEN
      LET tm.show_ad = g_argv[17]
   END IF
   #150827-00036#2--add--end
END FUNCTION

################################################################################
# Descriptions...: 串查aglt310傳票資料
# Memo...........:
# Usage..........: CALL aglq760_cmdrun()
# Modify.........:
################################################################################
PRIVATE FUNCTION aglq760_cmdrun()
   DEFINE la_param     RECORD
          prog         STRING,
          param        DYNAMIC ARRAY OF STRING
                       END RECORD
   DEFINE ls_js        STRING
   DEFINE l_glap001    LIKE glap_t.glap001
   
   SELECT glap001 INTO l_glap001 FROM glap_t 
    WHERE glapent=g_enterprise AND glapld=g_glaald AND glapdocno=g_glaq_d[g_detail_idx].glaqdocno
    
   INITIALIZE la_param.* TO NULL
   #傳票性質
   CASE l_glap001
      WHEN '1'
         LET la_param.prog = 'aglt310'
      WHEN '2'
         LET la_param.prog = 'aglt320'
      WHEN '3'
         LET la_param.prog = 'aglt330'
      WHEN '4'
         LET la_param.prog = 'aglt340'
      WHEN '5'
         LET la_param.prog = 'aglt350'
      WHEN '6'
         LET la_param.prog = 'aglt410'
   END CASE
#   LET la_param.prog = 'aglt310'
#   LET la_param.param[1] = l_glap001   #傳票性質
   LET la_param.param[1] = g_glaald    #帳別
   LET la_param.param[2] = g_glaq_d[g_detail_idx].glaqdocno     #傳票單號 
#   LET la_param.param[4] = g_glaq_d[g_detail_idx].glaq002 #科目編號
   LET ls_js = util.JSON.stringify( la_param )
   CALL cl_cmdrun(ls_js)
END FUNCTION

 
{</section>}
 
