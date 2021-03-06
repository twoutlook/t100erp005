#該程式未解開Section, 採用最新樣板產出!
{<section id="aapq330.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:21(2015-11-30 17:41:17), PR版次:0021(2017-01-06 17:42:21)
#+ Customerized Version.: SD版次:(), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000288
#+ Filename...: aapq330
#+ Description: 應付帳款查詢作業
#+ Creator....: 02097(2014-06-23 17:57:30)
#+ Modifier...: 02097 -SD/PR- 06821
 
{</section>}
 
{<section id="aapq330.global" >}
#應用 q01 樣板自動產生(Version:34)
#add-point:填寫註解說明 name="global.memo"
#150127-00007#1             By Reanna    掃把清空&給預設值
#150319-00004#2             By rayhuang  新增Q轉XG功能
#150401-00001#44 2015/12/09 By 02097     查詢時應參考左側QBE
#150909-00005#1  2015/12/28 By Jessy     1."沖銷明細",一次顯示所有沖銷記錄, WHERE　(apce003 IN (apcadocno list 帳款明細))  2.沖銷暫估apcf_t, 若是沖銷原立暫估單性質為02/04者, 則以負數值呈現,底下的合計值才會正確
#151231-00010#4  2016/01/11 By 02097     增加控制組
#160729-00030#1  2016/07/29 By 03538     當彙總條件選擇帳款對象時,隱藏原來的帳款對象欄位,避免重複出現兩欄相同欄位
#161014-00053#2  2016/10/20 By 08171     帳套權限調整
#161006-00005#19 2016/10/24 By 08732     組織類型與職能開窗調整
#161108-00017#2  2016/11/09 By Reanna    程式中INSERT INTO 有星號作整批調整
#161114-00017#1  2016/11/14 By Reanna    開窗權限調整
#161229-00047#27 2017/01/06 By 06821     財務用供應商對象控制組,法人條件改為用 IN (site...)的方式,QBE時,傳入符合權限的法人；INPUT時傳入目前法人據點
#end add-point
#add-point:填寫註解說明(客製用) name="global.memo_customerization"

#end add-point
 
IMPORT os
IMPORT util
#add-point:增加匯入項目 name="global.import"

#end add-point
 
SCHEMA ds
 
GLOBALS "../../cfg/top_global.inc"
 
#add-point:增加匯入變數檔 name="global.inc"
GLOBALS "../../cfg/top_report.inc"               #150319-00004#2
#end add-point
 
#單身 type 宣告
PRIVATE TYPE type_g_apca_d RECORD
       
       sel LIKE type_t.chr1, 
   txt LIKE type_t.chr500, 
   val LIKE type_t.chr500, 
   val2 LIKE type_t.chr500, 
   apca004 LIKE apca_t.apca004, 
   apca004_desc LIKE type_t.chr500, 
   apca100 LIKE apca_t.apca100, 
   apcc108 LIKE apcc_t.apcc108, 
   apcc134 LIKE apcc_t.apcc134, 
   apcc135 LIKE apcc_t.apcc135, 
   apcc133 LIKE apcc_t.apcc133, 
   apcc136 LIKE apcc_t.apcc136, 
   apcc137 LIKE apcc_t.apcc137, 
   apcc109 LIKE apcc_t.apcc109, 
   apcc138 LIKE apcc_t.apcc138, 
   apcc118 LIKE apcc_t.apcc118, 
   apcc139 LIKE apcc_t.apcc139
       END RECORD
 
 
#add-point:自定義模組變數-標準(Module Variable)  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="global.variable"
TYPE type_g_apca_d2  RECORD
        apcasite     LIKE type_t.chr80,
        apca001      LIKE type_t.chr80,
        apca007      LIKE type_t.chr80,
        apcadocno    LIKE apca_t.apcadocno,
        apca018      LIKE apca_t.apca018,
        apcc108      LIKE apcc_t.apcc105,
        apcc1081     LIKE apcc_t.apcc108,
        apcc118      LIKE apcc_t.apcc118,
        apcc003      LIKE apcc_t.apcc003,
        apcc004      LIKE apcc_t.apcc004,
        apcc009      LIKe apcc_t.apcc009        
                 END RECORD
TYPE type_g_apca_d3  RECORD
        isam011      LIKE isam_t.isam011,
        isam008      LIKE type_t.chr80,
        isam008_desc LIKE type_t.chr80,
        isam010      LIKE isam_t.isam010,
        isam014      LIKE isam_t.isam014,
        isam023      LIKE isam_t.isam023,
        isam024      LIKE isam_t.isam024,
        isam025      LIKE isam_t.isam025,
        isam026      LIKE isam_t.isam026,
        isam027      LIKE isam_t.isam027,
        isam028      LIKE isam_t.isam028,
        isam004      LIKE type_t.chr80
                 END RECORD
TYPE type_g_apca_d4  RECORD
        apce001      LIKE type_t.chr80,
        apcedocno    LIKE apce_t.apcedocno,
        apce002      LIKE type_t.chr80,
        apce024      LIKE apce_t.apce024,
        apce100      LIKE apce_t.apce100,
        apce109      LIKE apce_t.apce109,
        apce119      LIKE apce_t.apce119,
        apce003      LIKE apce_t.apce003,
        apce010      LIKE apce_t.apce010,
        apce014      LIKE apce_t.apce014        
                 END RECORD
DEFINE g_apca_d2     DYNAMIC ARRAY OF type_g_apca_d2
DEFINE g_apca_d3     DYNAMIC ARRAY OF type_g_apca_d3
DEFINE g_apca_d4     DYNAMIC ARRAY OF type_g_apca_d4

TYPE type_g_input    RECORD
       apcald        LIKE apca_t.apcald,
       apcacomp      LIKE apca_t.apcacomp,
       apcasite      LIKE apca_t.apcasite,
       apcald_desc   LIKE type_t.chr80,
       apcasite_desc LIKE type_t.chr80,
       apcacomp_desc LIKE type_t.chr80,
       op1           LIKE type_t.chr1,
       op2           LIKE type_t.chr1
                 END RECORD
DEFINE g_input       type_g_input  #INPUT條件
DEFINE l_ar          DYNAMIC ARRAY OF RECORD
           feld1     LIKE type_t.chr7,
           title     LIKE gzze_t.gzze001
                 END RECORD
DEFINE g_glaa003           LIKE glaa_t.glaa003
DEFINE g_wc_apcald         STRING
DEFINE g_input_wc          STRING
DEFINE g_wc_apcastus       STRING      #151013-00016#12
DEFINE g_wc_qry            STRING      #150401-00001#44
DEFINE g_apcbdocno_str     STRING      #150909-00005#1 add
DEFINE g_sql_ctrl          STRING      #151231-00010#4
DEFINE g_wc_cs_comp        STRING      #161229-00047#27 add
DEFINE g_comp_str          STRING      #161229-00047#27 add 
#end add-point
 
#模組變數(Module Variables)
DEFINE g_apca_d            DYNAMIC ARRAY OF type_g_apca_d
DEFINE g_apca_d_t          type_g_apca_d
 
 
 
 
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
 
 
 
DEFINE g_wc_filter_table           STRING
 
 
 
#add-point:自定義模組變數-客製(Module Variable) name="global.variable_customerization"

#end add-point
 
#add-point:傳入參數說明 name="global.argv"

#end add-point
 
{</section>}
 
{<section id="aapq330.main" >}
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
   LET l_ar[1].feld1 = 'apca004' #帳款對象
   LET l_ar[2].feld1 = 'apca015' #業務部門
   LET l_ar[3].feld1 = 'apca014' #業務人員
   LET l_ar[4].feld1 = 'apca007' #帳款類型
   LET l_ar[5].feld1 = 'ym'      #立帳期別
   LET l_ar[1].title = 'aap-00099'
   LET l_ar[2].title = 'aap-00100'
   LET l_ar[3].title = 'aap-00101'
   LET l_ar[4].title = 'aap-00102'
   LET l_ar[5].title = 'aap-00103'
   #151231-00010#4--(S)
   LET g_sql_ctrl = NULL
   #CALL s_control_get_supplier_sql('4',g_site,g_user,g_dept,'') RETURNING g_sub_success,g_sql_ctrl #161114-00017#1 mark
   #151231-00010#4--(E)
   #161114-00017#1 add ------
   SELECT ooef017 INTO g_input.apcacomp
     FROM ooef_t
    WHERE ooefent = g_enterprise
      AND ooef001 = g_site
      AND ooefstus = 'Y'
   #CALL s_control_get_supplier_sql_pmab('4',g_site,g_user,g_dept,'',g_input.apcacomp) RETURNING g_sub_success,g_sql_ctrl #161229-00047#27 mark
   #161114-00017#1 add end---
   #161229-00047#27 --s add
   CALL s_fin_azzi800_sons_query(g_today)
   CALL s_fin_account_center_comp_str() RETURNING g_wc_cs_comp   
   CALL s_fin_get_wc_str(g_wc_cs_comp) RETURNING g_wc_cs_comp      
   CALL s_control_get_supplier_sql_pmab('4',g_site,g_user,g_dept,'',g_wc_cs_comp) RETURNING g_sub_success,g_sql_ctrl
   #161229-00047#27 --e add  
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
   DECLARE aapq330_cl CURSOR FROM g_forupd_sql                 # LOCK CURSOR
 
   LET g_sql = " SELECT  ",
               " FROM  t0",
               
               " WHERE  "
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   #add-point:SQL_define name="main.after_refresh_sql"
   
   #end add-point
   PREPARE aapq330_master_referesh FROM g_sql
 
   #add-point:main段define_sql name="main.body.define_sql"
   
   #end add-point 
   LET g_forupd_sql = ""
   #add-point:main段define_sql name="main.body.after_define_sql"
   
   #end add-point 
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE aapq330_bcl CURSOR FROM g_forupd_sql
    
 
   
   IF g_bgjob = "Y" THEN
      #add-point:Service Call name="main.servicecall"
      
      #end add-point
   ELSE
      #畫面開啟 (identifier)
      OPEN WINDOW w_aapq330 WITH FORM cl_ap_formpath("aap",g_code)
   
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
   
      #程式初始化
      CALL aapq330_init()   
 
      #進入選單 Menu (="N")
      CALL aapq330_ui_dialog() 
      
      #add-point:畫面關閉前 name="main.before_close"
      
      #end add-point
 
      #畫面關閉
      CLOSE WINDOW w_aapq330
      
   END IF 
   
   CLOSE aapq330_cl
   
   
 
   #add-point:作業離開前 name="main.exit"
   
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
END MAIN
 
 
 
 
{</section>}
 
{<section id="aapq330.init" >}
#+ 瀏覽頁簽資料初始化
PRIVATE FUNCTION aapq330_init()
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
   CALL aapq330_create_tmp()              #150319-00004#2
   LET g_input.op1 = 1
   #160729-00030#1--S
   #彙總選擇1.帳款對象,則隱藏原來帳款對象欄位
   IF g_input.op1 = 1 THEN
      CALL cl_set_comp_visible("apca004_desc",FALSE)
   ELSE
      CALL cl_set_comp_visible("apca004_desc",TRUE)
   END IF
   #160729-00030#1--E         
   LET g_input.op2 = 6
   CALL cl_set_combo_scc_part('apcastus','13','N,Y,A,D,R,W,X') #151013-00016#12
   #展組織下階成員所需之暫存檔 
   CALL s_fin_create_account_center_tmp()
   CALL aapq330_qbe_clear()  #150127-00007#1
   #150127-00007#1 mark-------
   #CALL cl_set_comp_att_text('txt',cl_getmsg(l_ar[g_input.op1].title,g_lang))
   #CALL s_aap_get_default_apcasite('','','')RETURNING g_sub_success,g_errno,g_input.apcasite,
   #                                                   g_input.apcald,g_input.apcacomp
   #LET g_input.apcald_desc   = s_desc_get_ld_desc(g_input.apcald)
   #LET g_input.apcacomp_desc = s_desc_get_department_desc(g_input.apcacomp)
   #LET g_input.apcasite_desc = s_desc_get_department_desc(g_input.apcasite)                                                                                                         
   ##取得帳務組織下所屬成員
   #CALL s_fin_account_center_sons_query('3',g_input.apcasite,g_today,'')
   #CALL s_fin_account_center_ld_str() RETURNING g_wc_apcald
   #CALL s_fin_get_wc_str(g_wc_apcald) RETURNING g_wc_apcald
   #
   #DISPLAY BY NAME g_input.apcald,g_input.apcald_desc,g_input.apcacomp,g_input.apcacomp_desc,
   #                g_input.apcasite, g_input.apcasite_desc
   #150127-00007#1 mark end---
   #end add-point
 
   CALL aapq330_default_search()
END FUNCTION
 
{</section>}
 
{<section id="aapq330.default_search" >}
PRIVATE FUNCTION aapq330_default_search()
   #add-point:default_search段define-客製 name="default_search.define_customerization"
   
   #end add-point
   #add-point:default_search段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="default_search.define"
   
   #end add-point
 
 
   #add-point:default_search段開始前 name="default_search.before"
   
   #end add-point
 
   #應用 qs27 樣板自動產生(Version:3)
   #+ 組承接外部參數時資料庫欄位對應條件(單身)
   IF NOT cl_null(g_argv[01]) THEN
      LET g_wc = g_wc, " apcald = '", g_argv[01], "' AND "
   END IF
 
   IF NOT cl_null(g_argv[02]) THEN
      LET g_wc = g_wc, " apcadocno = '", g_argv[02], "' AND "
   END IF
 
 
 
 
 
 
   IF NOT cl_null(g_wc) THEN
      LET g_wc = g_wc.subString(1,g_wc.getLength()-5)
   ELSE
      #預設查詢條件
      LET g_wc = " 1=2"
   END IF
 
   #add-point:default_search段結束前 name="default_search.after"
   IF cl_null(g_input_wc) THEN LET g_input_wc = " 1=2 " END IF  #150909-00005#1 add
   #end add-point
 
END FUNCTION
 
{</section>}
 
{<section id="aapq330.ui_dialog" >}
#+ 選單功能實際執行處
PRIVATE FUNCTION aapq330_ui_dialog() 
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
   #add-point:ui_dialog段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="ui_dialog.define"
   DEFINE l_success LIKE type_t.num5  
   DEFINE l_comp_wc STRING  #161014-00053#2
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
   LET g_current_row_tot = 0
   LET g_page_start_num = 1
   LET g_page_end_num = g_num_in_page
   LET g_detail_idx = 1
   LET g_detail_idx2 = 1
   LET l_ac = 1
 
   #add-point:ui_dialog段before dialog  name="ui_dialog.before_dialog"
   
   #end add-point
 
   
   CALL aapq330_b_fill()
  
   WHILE li_exit = FALSE
 
      IF g_action_choice = "logistics" THEN
         #清除畫面及相關資料
         CLEAR FORM
         CALL g_apca_d.clear()
 
         LET g_wc  = " 1=2"
         LET g_wc2 = " 1=1"
         LET g_action_choice = ""
         LET g_detail_page_action = "detail_first"
         LET g_pagestart = 1
         LET g_current_row_tot = 0
         LET g_page_start_num = 1
         LET g_page_end_num = g_num_in_page
         LET g_detail_idx = 1
         LET g_detail_idx2 = 1
 
         CALL aapq330_init()
      END IF
 
      DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
         #add-point:input段落 name="ui_dialog.input"
         
         #end add-point
 
         #add-point:construct段落 name="ui_dialog.construct"
         
       
         #INPUT條件
         INPUT g_input.apcald,g_input.apcasite,g_input.op1,g_input.op2 FROM apcald,apcasite,op1,op2
               ATTRIBUTE(WITHOUT DEFAULTS)
         BEFORE INPUT
            LET g_wc = " 1=1"
            LET g_input_wc = " 1=1 "   #150909-00005#1 add
               
            AFTER FIELD apcald
               LET g_input.apcald_desc   = ''
               LET g_input.apcacomp_desc = ''
               IF NOT cl_null(g_input.apcald) THEN
                  #CALL s_fin_account_center_with_ld_chk(g_input.apcasite,g_input.apcald,g_user,'3','N','',g_today) RETURNING g_sub_success,g_errno #161014-00053#2 mark
                  CALL s_fin_account_center_with_ld_chk(g_input.apcasite,g_input.apcald,g_user,'3','Y',g_wc_apcald,g_today) RETURNING g_sub_success,g_errno #161014-00053#2 add
                  IF NOT g_sub_success THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = g_errno
                     LET g_errparam.extend = ''
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                     CALL s_aap_get_default_apcasite('','','')RETURNING g_sub_success,g_errno,g_input.apcasite,
                                                                        g_input.apcald,g_input.apcacomp
                     LET g_input.apcald_desc   = s_desc_get_ld_desc(g_input.apcald)
                     LET g_input.apcacomp_desc = s_desc_get_department_desc(g_input.apcacomp)
                     LET g_input.apcasite_desc = s_desc_get_department_desc(g_input.apcasite)
                     DISPLAY BY NAME g_input.apcald,g_input.apcald_desc,g_input.apcacomp,g_input.apcacomp_desc,
                                     g_input.apcasite, g_input.apcasite_desc
                     NEXT FIELD CURRENT
                  END IF
                  CALL s_fin_ld_carry(g_input.apcald,'') RETURNING g_sub_success,g_input.apcald,g_input.apcacomp,g_errno
                  IF NOT g_sub_success THEN
                      INITIALIZE g_errparam TO NULL
                      LET g_errparam.code = g_errno
                      LET g_errparam.extend = g_input.apcald
                      LET g_errparam.popup = TRUE
                      CALL cl_err()
                  END IF
                  CALL s_ld_sel_glaa(g_input.apcald,'glaa003') RETURNING l_success,g_glaa003
                  IF NOT g_success THEN LET g_input.apcald = '' END IF
                  LET g_input.apcald_desc   = s_desc_get_ld_desc(g_input.apcald)
                  LET g_input.apcacomp_desc = s_desc_get_department_desc(g_input.apcacomp)
                  DISPLAY g_input.apcald,g_input.apcald_desc,g_input.apcacomp,g_input.apcacomp_desc
                       TO apcald,apcald_desc,apcacomp,apcacomp_desc
                  #161114-00017#1 add ------
                  #CALL s_control_get_supplier_sql_pmab('4',g_site,g_user,g_dept,'',g_input.apcacomp) RETURNING g_sub_success,g_sql_ctrl  #161229-00047#27 mark
                  #161114-00017#1 add end---
                  #161229-00047#27 --s add 
                  CALL s_fin_get_wc_str(g_input.apcacomp) RETURNING g_comp_str 
                  CALL s_control_get_supplier_sql_pmab('4',g_site,g_user,g_dept,'',g_comp_str) RETURNING g_sub_success,g_sql_ctrl
                  #161229-00047#27 --e add 
               END IF
               
            AFTER FIELD apcasite
               LET g_input.apcasite_desc = ''
               IF NOT cl_null(g_input.apcasite) THEN
                  CALL s_fin_account_center_with_ld_chk(g_input.apcasite,g_input.apcald,g_user,'3','N','',g_today) RETURNING g_sub_success,g_errno
                  IF NOT g_sub_success THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = g_errno
                     LET g_errparam.extend = ''
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                     LET g_input.apcasite = ''
                     LET g_input.apcald   = ''                     
                     CALL s_desc_get_department_desc(g_input.apcasite) RETURNING g_input.apcasite_desc
                     DISPLAY BY NAME g_input.apcasite_desc
                     NEXT FIELD CURRENT
                  END IF
               END IF
               #重新取得帳套範圍
               CALL s_fin_account_center_sons_query('3',g_input.apcasite,g_today,'')
               CALL s_fin_account_center_ld_str() RETURNING g_wc_apcald
               CALL s_fin_get_wc_str(g_wc_apcald) RETURNING g_wc_apcald
               CALL s_desc_get_department_desc(g_input.apcasite) RETURNING g_input.apcasite_desc                    
               DISPLAY BY NAME g_input.apcasite_desc
               
            AFTER FIELD op1
               IF NOT g_input.op1 MATCHES '[12345]' THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = "apm-00379"
                  LET g_errparam.extend = ""
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

               END IF
               
            ON CHANGE op1
               CALL cl_set_comp_att_text('txt',cl_getmsg(l_ar[g_input.op1].title,g_lang))
               #160729-00030#1--S
               #彙總選擇1.帳款對象,則隱藏原來帳款對象欄位
               IF g_input.op1 = 1 THEN
                  CALL cl_set_comp_visible("apca004_desc",FALSE)
               ELSE
                  CALL cl_set_comp_visible("apca004_desc",TRUE)
               END IF
               #160729-00030#1--E               
               
            AFTER FIELD op2
               IF NOT g_input.op2 MATCHES '[678]' THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = "apm-00379"
                  LET g_errparam.extend = ""
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

               END IF    
               
            ON ACTION controlp INFIELD apcald
               #161014-00053#2 --s add
               #取得帳務組織下所屬成員之帳別   
               CALL s_fin_account_center_comp_str() RETURNING l_comp_wc
               #將取回的字串轉換為SQL條件
               CALL aapq330_get_ooef001_wc(l_comp_wc) RETURNING l_comp_wc
               #161014-00053#2 --e add       
      			INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'i'
      			LET g_qryparam.reqry = FALSE
               LET g_qryparam.default1 = g_input.apcald                     #給予default值
               #LET g_qryparam.where = " (glaa008 = 'Y' OR glaa014 = 'Y') "  #glaa008(平行記帳)/glaa014(主帳套) #161014-00053#2 mark
               LET g_qryparam.arg1 = g_user                                 #人員權限
               LET g_qryparam.arg2 = g_dept                                 #部門權限
               #LET g_qryparam.where = " glaald IN ",g_wc_apcald                                               #161014-00053#2 mark
               LET g_qryparam.where = " (glaa008 = 'Y' OR glaa014 = 'Y') AND glaacomp IN ",l_comp_wc,"" #161014-00053#2 add
               CALL q_authorised_ld()                                       #呼叫開窗
               LET g_input.apcald = g_qryparam.return1                      #將開窗取得的值回傳到變數
               NEXT FIELD apcald             
               
            ON ACTION controlp INFIELD apcasite
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'i'
   			   LET g_qryparam.reqry = FALSE
               LET g_qryparam.default1 = g_input.apcasite       #給予default值
               #CALL q_ooef001()     #161006-00005#19   mark
               CALL q_ooef001_46()   #161006-00005#19   add                            
               LET g_input.apcasite = g_qryparam.return1        #將開窗取得的值回傳到變數
               DISPLAY BY NAME g_input.apcasite
               NEXT FIELD apcasite                              #返回原欄位
         END INPUT
         
         #QBE查詢條件
         CONSTRUCT BY NAME g_input_wc ON apca004,apcadocdt,apca001,apca007,apcastus #151013-00016#12增加狀態碼suts
            
            ON ACTION controlp INFIELD apca004
               #帳款對象編號
   			   INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c'
   			   LET g_qryparam.reqry = FALSE
   			   LEt g_qryparam.arg1  = "('1','3')"
   			   #151231-00010#4--(S)
               LET g_qryparam.where = " pmaa001 IN (SELECT pmab001 FROM pmab_t WHERE pmabent = ",g_enterprise,
                                      " AND pmabsite IN (SELECT a.ooef001 FROM ooef_t a,ooef_t b WHERE a.ooefent = b.ooefent AND a.ooef017 = b.ooef017 AND a.ooefent = ",g_enterprise," AND a.ooef001 = '",g_site,"'))"
               IF NOT cl_null(g_sql_ctrl) AND NOT g_sql_ctrl = ' 1=1'  THEN
                  LET g_qryparam.where = g_qryparam.where , " AND pmaa001 IN (SELECT pmaa001 FROM pmaa_t WHERE pmaaent = ",g_enterprise, " AND ", g_sql_ctrl,")"
               END IF
               #151231-00010#4--(E)
               CALL q_pmaa001_1()
               DISPLAY g_qryparam.return1 TO apca004
               NEXT FIELD apca004
            

            ON ACTION controlp INFIELD apca007
               #帳款類別
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c'
               LET g_qryparam.reqry = FALSE
               LET g_qryparam.arg1 = '3211'
               CALL q_oocq002()
               DISPLAY g_qryparam.return1 TO apca007
               NEXT FIELD apca007
               
            ON ACTION controlp INFIELD apca001
               #帳款類別
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c'
               LET g_qryparam.reqry = FALSE
               LET g_qryparam.arg1 = '8502'
               CALL q_gzcb001()
               DISPLAY g_qryparam.return1 TO apca001
               NEXT FIELD apca001  

         END CONSTRUCT
         #end add-point
     
         DISPLAY ARRAY g_apca_d TO s_detail1.* ATTRIBUTE(COUNT=g_detail_cnt)
 
            BEFORE DISPLAY
               LET g_current_page = 1
 
            BEFORE ROW
               LET g_detail_idx = DIALOG.getCurrentRow("s_detail1")
               LET l_ac = g_detail_idx
               CALL aapq330_detail_action_trans()
 
               LET g_master_idx = l_ac
               #為避免按上下筆時影響執行效能，所以做一些處理
               LET lc_action_choice_old = g_action_choice
               LET g_action_choice = "fetch"
               CALL aapq330_b_fill2()
               LET g_action_choice = lc_action_choice_old
 
               #add-point:input段before row name="input.body.before_row"
 
               #end add-point
 
            
 
            #自訂ACTION(detail_show,page_1)
            
 
            #add-point:page1自定義行為 name="ui_dialog.body.page1.action"
            
            #end add-point
 
         END DISPLAY
 
         #add-point:第一頁籤程式段mark結束用 name="ui_dialog.page1.mark.end"
         
         #end add-point
 
 
 
         #add-point:ui_dialog段自定義display array name="ui_dialog.more_displayarray"
         #帳款單據
         DISPLAY ARRAY g_apca_d2 TO s_detail2.* ATTRIBUTE(COUNT=g_detail_cnt)
 
            BEFORE DISPLAY
               LET g_current_page = 2
            
            BEFORE ROW
               LET g_detail_idx2 = DIALOG.getCurrentRow("s_detail2")
               LET l_ac = g_detail_idx2
               DISPLAY g_detail_idx2 TO FORMONLY.h_index
               DISPLAY g_apca_d2.getLength() TO FORMONLY.h_count
               CALL aapq330_b_fill2()
            
         END DISPLAY
         #發票信息
         DISPLAY ARRAY g_apca_d3 TO s_detail3.* ATTRIBUTE(COUNT=g_detail_cnt)
 
            BEFORE DISPLAY
               LET g_current_page = 3
 
  
         END DISPLAY
         #沖銷信息
         DISPLAY ARRAY g_apca_d4 TO s_detail4.* ATTRIBUTE(COUNT=g_detail_cnt)
 
            BEFORE DISPLAY
               LET g_current_page = 4
  
         END DISPLAY
         #end add-point
 
         BEFORE DIALOG
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL DIALOG.setSelectionMode("s_detail1", 1)
            LET g_detail_idx = DIALOG.getCurrentRow("s_detail1")
            CALL aapq330_detail_action_trans()
 
            #add-point:ui_dialog段before dialog name="ui_dialog.bef_dialog"
            #150127-00007#1
            CALL cl_set_act_visible('selall,selnone,unsel,sel',FALSE)
            #end add-point
            NEXT FIELD apcald
 
         AFTER DIALOG
            #add-point:ui_dialog段 after dialog name="ui_dialog.after_dialog"
 
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
            CALL aapq330_b_fill()
 
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
               LET g_export_node[1] = base.typeInfo.create(g_apca_d)
               LET g_export_id[1]   = "s_detail1"
 
               #add-point:ON ACTION exporttoexcel name="menu.exporttoexcel"
      
               LET g_export_node[2] = base.typeInfo.create(g_apca_d2)
               LET g_export_id[2]   = "s_detail2"
               LET g_export_node[3] = base.typeInfo.create(g_apca_d3)
               LET g_export_id[3]   = "s_detail3"
               LET g_export_node[4] = base.typeInfo.create(g_apca_d4)
               LET g_export_id[4]   = "s_detail4"
               #END add-point
               CALL cl_export_to_excel_getpage()
               CALL cl_export_to_excel()
            END IF
 
         ON ACTION datarefresh   # 重新整理
            CALL aapq330_b_fill()
 
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
            CALL aapq330_b_fill()
 
         ON ACTION detail_previous                #page previous
            LET g_action_choice = "detail_previous"
            LET g_detail_page_action = "detail_previous"
            CALL aapq330_b_fill()
 
         ON ACTION detail_next               #page next
            LET g_action_choice = "detail_next"
            LET g_detail_page_action = "detail_next"
            CALL aapq330_b_fill()
 
         ON ACTION detail_last               #page last
            LET g_action_choice = "detail_last"
            LET g_detail_page_action = "detail_last"
            CALL aapq330_b_fill()
 
         #應用 qs19 樣板自動產生(Version:3)
         #有關於sel欄位選取的action段落
         #選擇全部
         ON ACTION selall
            CALL DIALOG.setSelectionRange("s_detail1", 1, -1, 1)
            FOR li_idx = 1 TO g_apca_d.getLength()
               LET g_apca_d[li_idx].sel = "Y"
            END FOR
 
            #add-point:ui_dialog段on action selall name="ui_dialog.onaction_selall"
            
            #end add-point
 
         #取消全部
         ON ACTION selnone
            CALL DIALOG.setSelectionRange("s_detail1", 1, -1, 0)
            FOR li_idx = 1 TO g_apca_d.getLength()
               LET g_apca_d[li_idx].sel = "N"
            END FOR
 
            #add-point:ui_dialog段on action selnone name="ui_dialog.onaction_selnone"
            
            #end add-point
 
         #勾選所選資料
         ON ACTION sel
            FOR li_idx = 1 TO g_apca_d.getLength()
               IF DIALOG.isRowSelected("s_detail1", li_idx) THEN
                  LET g_apca_d[li_idx].sel = "Y"
               END IF
            END FOR
 
            #add-point:ui_dialog段on action sel name="ui_dialog.onaction_sel"
            
            #end add-point
 
         #取消所選資料
         ON ACTION unsel
            FOR li_idx = 1 TO g_apca_d.getLength()
               IF DIALOG.isRowSelected("s_detail1", li_idx) THEN
                  LET g_apca_d[li_idx].sel = "N"
               END IF
            END FOR
 
            #add-point:ui_dialog段on action unsel name="ui_dialog.onaction_unsel"
            
            #end add-point
 
 
 
 
 
         #應用 qs16 樣板自動產生(Version:3)
         ON ACTION filter
            LET g_action_choice="filter"
            CALL aapq330_filter()
            #add-point:ON ACTION filter name="menu.filter"
            
            #END add-point
            EXIT DIALOG
 
 
 
 
         
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION datainfo
            LET g_action_choice="datainfo"
            IF cl_auth_chk_act("datainfo") THEN
               
               #add-point:ON ACTION datainfo name="menu.datainfo"
               
               #END add-point
               
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION query
            LET g_action_choice="query"
            IF cl_auth_chk_act("query") THEN
               
               #add-point:ON ACTION query name="menu.query"
               
               #END add-point
               
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION output
            LET g_action_choice="output"
            IF cl_auth_chk_act("output") THEN
               
               #add-point:ON ACTION output name="menu.output"
               #動態抓取txt欄位的Title
               LET g_xg_fieldname[1] =  cl_getmsg(l_ar[g_input.op1].title,g_lang)   #150319-00004#2         
               CALL aapq330_x01(" 1=1","aapq330_x01_tmp")   #150319-00004#2
               #END add-point
               
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION quickprint
            LET g_action_choice="quickprint"
            IF cl_auth_chk_act("quickprint") THEN
               
               #add-point:ON ACTION quickprint name="menu.quickprint"
               #動態抓取txt欄位的Title
               LET g_xg_fieldname[1] =  cl_getmsg(l_ar[g_input.op1].title,g_lang)   #150319-00004#2         
               CALL aapq330_x01(" 1=1","aapq330_x01_tmp")   #150319-00004#2
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
            CALL aapq330_qbe_clear()  #150127-00007#1
         #end add-point
 
      END DIALOG 
   
   END WHILE
 
END FUNCTION
 
{</section>}
 
{<section id="aapq330.b_fill" >}
#+ 單身陣列填充
PRIVATE FUNCTION aapq330_b_fill()
   #add-point:b_fill段define-客製 name="b_fill.define_customerization"
   
   #end add-point
   DEFINE ls_wc           STRING
   DEFINE l_pid           LIKE type_t.chr50
   DEFINE ls_sql_rank     STRING
   #add-point:b_fill段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="b_fill.define"
   DEFINE l_chr           LIKE type_t.chr1
   DEFINE l_success       LIKE type_t.num5
   #150319-00004#2-----s
   DEFINE l_i             LIKE type_t.num10
   DEFINE l_x01_tmp       RECORD                            #XG報表用的temp
                          txt           LIKE type_t.chr500,
                          apca004_desc  LIKE type_t.chr500, 
                          apca100       LIKE apca_t.apca100, 
                          apcc108       LIKE apcc_t.apcc108, 
                          apcc134       LIKE apcc_t.apcc134, 
                          apcc135       LIKE apcc_t.apcc135, 
                          apcc133       LIKE apcc_t.apcc133, 
                          apcc136       LIKE apcc_t.apcc136, 
                          apcc137       LIKE apcc_t.apcc137, 
                          apcc109       LIKE apcc_t.apcc109, 
                          apcc138       LIKE apcc_t.apcc138, 
                          apcc118       LIKE apcc_t.apcc118, 
                          apcc139       LIKE apcc_t.apcc139,
                          apcald        LIKE apca_t.apcald,
                          apcacomp      LIKE apca_t.apcacomp,
                          apcasite      LIKE apca_t.apcasite,
                          apcald_desc   LIKE type_t.chr500,
                          apcacomp_desc LIKE type_t.chr500,
                          apcasite_desc LIKE type_t.chr500
                          END RECORD
   #150319-00004#2-----e 
   DEFINE l_tok     base.Stringtokenizer   
   DEFINE l_pos     LIKE type_t.num10
   #end add-point
 
   #add-point:b_fill段sql_before name="b_fill.sql_before"
   LET l_chr = ''
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
 
   LET ls_wc = g_wc, " AND ", g_wc2, " AND ", g_wc_filter, cl_sql_auth_filter()   #(ver:34) add cl_sql_auth_filter()
 
   CALL g_apca_d.clear()
 
   #add-point:陣列清空 name="b_fill.array_clear"
   IF cl_null(g_input_wc) THEN LET g_input_wc = " 1=1 " END IF
   LET ls_wc =  g_input_wc CLIPPED
   LET ls_wc = ls_wc , " AND apcald = '", g_input.apcald,"' AND apcasite = '",g_input.apcasite,"' AND apca001 NOT IN ('11','14')"
   #151231-00010#4--(S)
   IF NOT cl_null(g_sql_ctrl) AND NOT g_sql_ctrl = ' 1=1'  THEN
      LET ls_wc =  ls_wc ," AND apca004 IN (SELECT pmaa001 FROM pmaa_t WHERE pmaaent = ",g_enterprise, " AND ", g_sql_ctrl,")"
   END IF
   #151231-00010#4--(E)
   LET g_wc_qry = ls_wc    #150401-00001#44
   #end add-point
 
   LET g_cnt = l_ac
   IF g_cnt = 0 THEN
      LET g_cnt = 1
   END IF
   LET l_ac = 1
 
   # b_fill段sql組成及FOREACH撰寫
   #應用 qs04 樣板自動產生(Version:9)
   #+ b_fill段資料取得(包含sql組成及FOREACH段撰寫)
   LET ls_sql_rank = "SELECT  UNIQUE '','','','',apca004,'',apca100,'','','','','','','','','',''  , 
       DENSE_RANK() OVER( ORDER BY apca_t.apcald,apca_t.apcadocno) AS RANK FROM apca_t",
 
 
                     "",
                     " WHERE apcaent= ? AND 1=1 AND ", ls_wc
   LET ls_sql_rank = ls_sql_rank, cl_sql_add_filter("apca_t"),
                     " ORDER BY apca_t.apcald,apca_t.apcadocno"
 
   #add-point:b_fill段rank_sql_after name="b_fill.rank_sql_after"
   
   #end add-point
 
   LET g_sql = "SELECT COUNT(1) FROM (",ls_sql_rank,")"
 
   PREPARE b_fill_cnt_pre FROM g_sql  #總筆數
   EXECUTE b_fill_cnt_pre USING g_enterprise INTO g_tot_cnt
   FREE b_fill_cnt_pre
 
   #add-point:b_fill段rank_sql_after_count name="b_fill.rank_sql_after_count"
   
   #end add-point
 
   CASE g_detail_page_action
      WHEN "detail_first"
          LET g_pagestart = 1
 
      WHEN "detail_previous"
          LET g_pagestart = g_pagestart - g_num_in_page
          IF g_pagestart < 1 THEN
              LET g_pagestart = 1
          END IF
 
      WHEN "detail_next"
         LET g_pagestart = g_pagestart + g_num_in_page
         IF g_pagestart > g_tot_cnt THEN
            LET g_pagestart = g_tot_cnt - (g_tot_cnt mod g_num_in_page) + 1
            WHILE g_pagestart > g_tot_cnt
               LET g_pagestart = g_pagestart - g_num_in_page
            END WHILE
         END IF
 
      WHEN "detail_last"
         LET g_pagestart = g_tot_cnt - (g_tot_cnt mod g_num_in_page) + 1
         WHILE g_pagestart > g_tot_cnt
            LET g_pagestart = g_pagestart - g_num_in_page
         END WHILE
 
      OTHERWISE
         LET g_pagestart = 1
 
   END CASE
 
   LET g_sql = "SELECT '','','','',apca004,'',apca100,'','','','','','','','','',''",
               " FROM (",ls_sql_rank,")",
              " WHERE RANK >= ",g_pagestart,
                " AND RANK < ",g_pagestart + g_num_in_page
 
   #add-point:b_fill段sql_after name="b_fill.sql_after"
   #l_ar[g_input.op1].feld1:用於顯示/var:實際使用的值
   IF NOT g_input.op1 = '5' THEN
      LET g_sql = "SELECT 'N',",l_ar[g_input.op1].feld1,",",l_ar[g_input.op1].feld1,",'',apca004,'',apca100,'','','','','','','','','','' FROM apca_t", 
                  " WHERE apcaent= ? AND 1=1 AND ", ls_wc ,
                  "   AND apca004 <> 'EMPL' ",                          #暫不處理員工請款部分
                  " GROUP BY apca100,apca004,",l_ar[g_input.op1].feld1
   ELSE
      LET g_sql = "SELECT 'N','',glav002,glav006,apca004,'',apca100,'','','','','','','','','',''",
                  "  FROM apca_t,glav_t", 
                  " WHERE apcaent= ? AND 1=1 AND ", ls_wc ,
                  "   AND glav001 = '",g_glaa003,"' AND apcadocdt = glav004 AND glavent = apcaent",
                  "   AND apca004 <> 'EMPL' ",                          #暫不處理員工請款部分
                  " GROUP BY apca100,apca004,glav002,glav006"
   END IF
   LET g_wc_apcastus = NULL
   LET l_pos = g_input_wc.getIndexOf('apcastus',1)
   IF l_pos > 0 THEN
      LET g_wc_apcastus = " AND ",g_input_wc.subString(g_input_wc.getIndexOf('apcastus',1),g_input_wc.getLength())
   END IF
   #end add-point
 
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   PREPARE aapq330_pb FROM g_sql
   DECLARE b_fill_curs CURSOR FOR aapq330_pb
 
   OPEN b_fill_curs USING g_enterprise
 
   FOREACH b_fill_curs INTO g_apca_d[l_ac].sel,g_apca_d[l_ac].txt,g_apca_d[l_ac].val,g_apca_d[l_ac].val2, 
       g_apca_d[l_ac].apca004,g_apca_d[l_ac].apca004_desc,g_apca_d[l_ac].apca100,g_apca_d[l_ac].apcc108, 
       g_apca_d[l_ac].apcc134,g_apca_d[l_ac].apcc135,g_apca_d[l_ac].apcc133,g_apca_d[l_ac].apcc136,g_apca_d[l_ac].apcc137, 
       g_apca_d[l_ac].apcc109,g_apca_d[l_ac].apcc138,g_apca_d[l_ac].apcc118,g_apca_d[l_ac].apcc139
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "FOREACH:" 
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = TRUE 
         CALL cl_err()
 
         EXIT FOREACH
      END IF
 
      
 
      #add-point:b_fill段資料填充 name="b_fill.fill"
      IF NOT cl_null(g_apca_d[l_ac].val) THEN
         CASE g_input.op1
            WHEN 1   LET g_apca_d[l_ac].txt = g_apca_d[l_ac].txt ,l_chr,s_desc_get_trading_partner_abbr_desc(g_apca_d[l_ac].txt) 
            WHEN 2   LET g_apca_d[l_ac].txt = g_apca_d[l_ac].txt ,l_chr,s_desc_get_department_desc(g_apca_d[l_ac].txt) 
            WHEN 3   LET g_apca_d[l_ac].txt = g_apca_d[l_ac].txt ,l_chr,s_desc_get_person_desc(g_apca_d[l_ac].txt) 
            WHEN 4   LET g_apca_d[l_ac].txt = g_apca_d[l_ac].txt ,l_chr,s_desc_get_acc_desc('3211',g_apca_d[l_ac].txt) 
            WHEN 5
                     IF g_apca_d[l_ac].val2 > 9 THEN
                        LET g_apca_d[l_ac].txt = g_apca_d[l_ac].val,g_apca_d[l_ac].val2
                     ELSE
                        LET g_apca_d[l_ac].txt = g_apca_d[l_ac].val,"0",g_apca_d[l_ac].val2
                     END IF            
         END CASE
      END IF
      #採購應付(+)
      LET g_apca_d[l_ac].apcc134 = aapq330_get_value_b(g_apca_d[l_ac].apca004,g_apca_d[l_ac].apca100,'13',g_apca_d[l_ac].val,g_apca_d[l_ac].val2,g_apca_d[l_ac].val)
      #其他應付(+)
      LET g_apca_d[l_ac].apcc135 = aapq330_get_value_b(g_apca_d[l_ac].apca004,g_apca_d[l_ac].apca100,'19',g_apca_d[l_ac].val,g_apca_d[l_ac].val2,g_apca_d[l_ac].val)
      #預付款(-)
      LET g_apca_d[l_ac].apcc133 = aapq330_get_value_b(g_apca_d[l_ac].apca004,g_apca_d[l_ac].apca100,'11',g_apca_d[l_ac].val,g_apca_d[l_ac].val2,g_apca_d[l_ac].val)         
      #倉退及折讓(-)
      LET g_apca_d[l_ac].apcc136 = aapq330_get_value_b(g_apca_d[l_ac].apca004,g_apca_d[l_ac].apca100,'22',g_apca_d[l_ac].val,g_apca_d[l_ac].val2,g_apca_d[l_ac].val)
      #暫估應付(+)
      LET g_apca_d[l_ac].apcc137 = aapq330_get_value_b(g_apca_d[l_ac].apca004,g_apca_d[l_ac].apca100,'01',g_apca_d[l_ac].val,g_apca_d[l_ac].val2,g_apca_d[l_ac].val)
                 
      CALL aapq330_get_sum_b(g_apca_d[l_ac].apca004,g_apca_d[l_ac].apca100,g_apca_d[l_ac].val,g_apca_d[l_ac].val2,g_apca_d[l_ac].val)
           RETURNING g_apca_d[l_ac].apcc108,g_apca_d[l_ac].apcc109,g_apca_d[l_ac].apcc138, 
                     g_apca_d[l_ac].apcc118,                       g_apca_d[l_ac].apcc139
                     
      LET g_apca_d[l_ac].apcc108 = (g_apca_d[l_ac].apcc133*-1) +  g_apca_d[l_ac].apcc134
                                   + g_apca_d[l_ac].apcc135    + (g_apca_d[l_ac].apcc136*-1)
                                   + g_apca_d[l_ac].apcc137        
      LET g_apca_d[l_ac].apca004_desc = g_apca_d[l_ac].apca004,s_desc_get_trading_partner_abbr_desc(g_apca_d[l_ac].apca004)
      
      #無應付總額者 剃除
      IF cl_null(g_apca_d[l_ac].apcc108) OR g_apca_d[l_ac].apcc108 = 0 THEN
         CALL g_apca_d.deleteElement(l_ac)
         CONTINUE FOREACH
      END IF
      
      #end add-point
 
      CALL aapq330_detail_show("'1'")
 
      CALL aapq330_apca_t_mask()
 
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
 
 
 
 
 
   #應用 qs05 樣板自動產生(Version:4)
   #+ b_fill段其他table資料取得(包含sql組成及資料填充)
 
 
 
 
 
 
   #add-point:b_fill段資料填充(其他單身) name="b_fill.others.fill"
   #150319-00004#2-----s             #依畫面資料INSERT XG_tmp 
   DELETE FROM aapq330_x01_tmp
   FOR l_i = 1 TO g_apca_d.getLength()
      INITIALIZE l_x01_tmp.* TO NULL
      LET l_x01_tmp.txt            = g_apca_d[l_i].txt
      LET l_x01_tmp.apca004_desc   = g_apca_d[l_i].apca004_desc
      LET l_x01_tmp.apca100        = g_apca_d[l_i].apca100
      LET l_x01_tmp.apcc108        = g_apca_d[l_i].apcc108
      LET l_x01_tmp.apcc134        = g_apca_d[l_i].apcc134
      LET l_x01_tmp.apcc135        = g_apca_d[l_i].apcc135
      LET l_x01_tmp.apcc133        = g_apca_d[l_i].apcc133
      LET l_x01_tmp.apcc136        = g_apca_d[l_i].apcc136
      LET l_x01_tmp.apcc137        = g_apca_d[l_i].apcc137
      LET l_x01_tmp.apcc109        = g_apca_d[l_i].apcc109
      LET l_x01_tmp.apcc138        = g_apca_d[l_i].apcc138
      LET l_x01_tmp.apcc118        = g_apca_d[l_i].apcc118
      LET l_x01_tmp.apcc139        = g_apca_d[l_i].apcc139
      LET l_x01_tmp.apcald_desc    = g_input.apcald  ,":",g_input.apcald_desc
      LET l_x01_tmp.apcacomp_desc  = g_input.apcacomp,":",g_input.apcacomp_desc
      LET l_x01_tmp.apcasite_desc  = g_input.apcasite,":",g_input.apcasite_desc
      #INSERT INTO aapq330_x01_tmp VALUES(l_x01_tmp.*) #161108-00017#2 mark
      #161108-00017#2 add ------
      INSERT INTO aapq330_x01_tmp (txt,apca004_desc,apca100,apcc108,apcc134,
                                   apcc135,apcc133,apcc136,apcc137,apcc109,
                                   apcc138,apcc118,apcc139,apcald,apcacomp,
                                   apcasite,apcald_desc,apcacomp,apcasite_desc
                                  )
      VALUES (l_x01_tmp.txt,l_x01_tmp.apca004_desc,l_x01_tmp.apca100,l_x01_tmp.apcc108,l_x01_tmp.apcc134,
              l_x01_tmp.apcc135,l_x01_tmp.apcc133,l_x01_tmp.apcc136,l_x01_tmp.apcc137,l_x01_tmp.apcc109,
              l_x01_tmp.apcc138,l_x01_tmp.apcc118,l_x01_tmp.apcc139,l_x01_tmp.apcald,l_x01_tmp.apcacomp,
              l_x01_tmp.apcasite,l_x01_tmp.apcald_desc,l_x01_tmp.apcacomp,l_x01_tmp.apcasite_desc
             )
      #161108-00017#2 add end---
   END FOR
   #150319-00004#2-----e
   #end add-point
 
   CALL g_apca_d.deleteElement(g_apca_d.getLength())
 
   #add-point:陣列長度調整 name="b_fill.array_deleteElement"
   
   #end add-point
 
   LET g_error_show = 0
 
   LET g_detail_cnt = g_apca_d.getLength()
   LET l_ac = g_cnt
   LET g_cnt = 0
 
   #應用 qs06 樣板自動產生(Version:3)
   #+ b_fill段CURSOR釋放
   CLOSE b_fill_curs
   FREE aapq330_pb
 
 
 
 
 
 
   #調整單身index指標，避免翻頁後指到空白筆數
   CALL aapq330_detail_index_setting()
 
   #重新計算單身筆數並呈現
   CALL aapq330_detail_action_trans()
 
   LET l_ac = 1
   IF g_apca_d.getLength() > 0 THEN
      CALL aapq330_b_fill2()
   END IF
 
      CALL aapq330_filter_show('apca004','b_apca004')
   CALL aapq330_filter_show('apca100','b_apca100')
   CALL aapq330_filter_show('apcc133','b_apcc133')
   CALL aapq330_filter_show('apcc136','b_apcc136')
 
 
END FUNCTION
 
{</section>}
 
{<section id="aapq330.b_fill2" >}
#+ 單身陣列填充2
PRIVATE FUNCTION aapq330_b_fill2()
   #add-point:b_fill2段define-客製 name="b_fill2.define_customerization"
   
   #end add-point
   DEFINE li_ac           LIKE type_t.num10
   #add-point:b_fill2段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="b_fill2.define"
   DEFINE l_sql           STRING
   DEFINE l_chr           LIKE type_t.chr1
   DEFINE l_apca001       LIKE apca_t.apca001   #150909-00005#1 add
   #end add-point
 
   #add-point:FUNCTION前置處理 name="b_fill2.before_function"
   
   #end add-point
 
   LET li_ac = l_ac
 
   #單身組成
   #應用 qs07 樣板自動產生(Version:7)
   #+ b_fill2段table資料取得(包含sql組成及資料填充)
 
   #add-point:陣列清空 name="b_fill2.array_clear"
   IF g_current_page = 1 THEN
      CALL g_apca_d2.clear()
   END IF
   CALL g_apca_d3.clear()
   CALL g_apca_d4.clear()
   #end add-point
 
 
 
 
   #add-point:陣列長度調整 name="b_fill2.array_deleteElement"
   IF g_current_page = 1 THEN
      IF NOT g_input.op1 = 5 THEN
         LET l_sql = "SELECT apcasite,apca001,apca007,apcadocno,apca018,apcc108,(apcc108-apcc109),(apcc118-apcc119+apcc113)",
                     "       ,apcc003,apcc004,apcc009 ",
                     "  FROM apca_t,apcc_t ",
                     " WHERE apcaent = apccent AND apcald = apccld AND apcadocno = apccdocno ",
                     "   AND apcastus = 'Y' ",
                     "   AND apcaent = ?     AND apcald  = ?        ",
                     "   AND apca004 = ?     AND apca100 = ?     AND ",l_ar[g_input.op1].feld1 ," = '",g_apca_d[l_ac].val,"'"
      ELSE
         LET l_sql = "SELECT apcasite,apca001,apca007,apcadocno,apca018,apcc108,(apcc108-apcc109),(apcc118-apcc119+apcc113)",
                     "       ,apcc003,apcc004,apcc009 ",
                     "  FROM apca_t,apcc_t,glav_t ",
                     " WHERE apcaent = apccent AND apcald = apccld AND apcadocno = apccdocno ",                    
                     "   AND apcaent = glavent AND glav001 = '",g_glaa003,"'",
                     "   AND apcastus = 'Y' ",
                     "   AND glav002 =",g_apca_d[l_ac].val," AND glav006 = ",g_apca_d[l_ac].val2,
                     "   AND apcadocdt = glav004",
                     "   AND apcaent = ?     AND apcald    = ?  ",
                     "   AND apca004 = ?     AND apca100   = ?  "
      END IF
      IF g_input.op2 = '7' THEN #尚有未沖餘額者
         LET l_sql =  l_sql ," AND apcc108 - apcc109 <> 0"
      END IF
      IF g_input.op2 = '8' THEN #已沖銷完畢者
         LET l_sql =  l_sql ," AND apcc108 - apcc109 = 0"
      END IF
      
         
      LET l_sql = l_sql CLIPPED ," AND apcasite = '",g_input.apcasite,"' AND apcald = '",g_input.apcald,"' AND apca001 NOT IN ('11','14') " 
      LET l_sql = l_sql CLIPPED , " AND ",g_wc_qry," "    #150401-00001#44 將g_wc改為g_wc_qry
      
      #151013-00016#12
      IF NOT cl_null(g_wc_apcastus) THEN
         LET l_sql =  l_sql ,g_wc_apcastus
      END IF
      #151013-00016#12
      
      PREPARE aapq330_pb2 FROM l_sql
      DECLARE b_fill2_curs CURSOR FOR aapq330_pb2
      LET li_ac = 1
      LET g_apcbdocno_str = ''   #150909-00005#1 add
      FOREACH b_fill2_curs USING g_enterprise,g_input.apcald,g_apca_d[l_ac].apca004,g_apca_d[l_ac].apca100
         INTO g_apca_d2[li_ac].apcasite,g_apca_d2[li_ac].apca001,g_apca_d2[li_ac].apca007,g_apca_d2[li_ac].apcadocno,
              g_apca_d2[li_ac].apca018 ,g_apca_d2[li_ac].apcc108,g_apca_d2[li_ac].apcc1081,g_apca_d2[li_ac].apcc118,
              g_apca_d2[li_ac].apcc003, g_apca_d2[li_ac].apcc004,g_apca_d2[li_ac].apcc009
             
   
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = SQLCA.sqlcode
            LET g_errparam.extend = "FOREACH:b_fill2_curs"
            LET g_errparam.popup = TRUE
            CALL cl_err()

            EXIT FOREACH
         END IF
         
         #金額欄位(交易、未沖)：
         #金額依[帳款單性質apca001]+[來源作業別apcb001]作 正負值判別。   
         #           帳款單性質apca001  來源作業別apcb001     負值
         #           ----------------  ----------------     ------
         #採購應付   13,14,16           apmt580,apmt590      -
         #其他應付   29                 X不限                -
         #倉退及折讓 22                 apmt580,apmt590,空白	-
         #暫估應付   01                 apmt580,apmt590	   -
         #暫估應付   02                 apmt580,apmt590,空白	-
#         LET l_chr = 'N'
#         IF g_apca_d2[li_ac].apca001 = '29' THEN
#            LET l_chr = 'Y'
#         END IF         
#         IF (l_apcb001 = 'apmt580' OR l_apcb001 = 'apmt590') AND 
#            (g_apca_d2[li_ac].apca001 = '13' OR g_apca_d2[li_ac].apca001 = '14' OR g_apca_d2[li_ac].apca001 = '16'  OR 
#             g_apca_d2[li_ac].apca001 = '22' OR g_apca_d2[li_ac].apca001 = '01' OR g_apca_d2[li_ac].apca001 = '02') 
#         THEN
#            LET l_chr = 'Y'
#         END IF
#         IF (g_apca_d2[li_ac].apca001 = '22' OR g_apca_d2[li_ac].apca001 = '02') AND cl_null(l_apcb001) THEN
#            LET l_chr = 'Y'
#         END IF
#         IF l_chr = 'Y' THEN
#            LET g_apca_d2[li_ac].apcc105 = g_apca_d2[li_ac].apcc105 * -1
#            LET g_apca_d2[li_ac].apcc108 = g_apca_d2[li_ac].apcc108 * -1
#            LET g_apca_d2[li_ac].apcc118 = g_apca_d2[li_ac].apcc118 * -1
#         END IF
  CASE 
     WHEN g_apca_d2[li_ac].apca001 MATCHES '2[123459]'
          LET g_apca_d2[li_ac].apcc108  = g_apca_d2[li_ac].apcc108 * -1
          LET g_apca_d2[li_ac].apcc1081 = g_apca_d2[li_ac].apcc1081 * -1
          LET g_apca_d2[li_ac].apcc118  = g_apca_d2[li_ac].apcc118 * -1
     WHEN g_apca_d2[li_ac].apca001 MATCHES '0[24|'
          LET g_apca_d2[li_ac].apcc108  = g_apca_d2[li_ac].apcc108 * -1
          LET g_apca_d2[li_ac].apcc1081 = g_apca_d2[li_ac].apcc1081 * -1
          LET g_apca_d2[li_ac].apcc118  = g_apca_d2[li_ac].apcc118 * -1
   END CASE     

         #150909-00005#1 --s
         #串帳款單據頁籤中應付帳款單號
         IF cl_null(g_apcbdocno_str) THEN
            LET g_apcbdocno_str = g_apca_d2[li_ac].apcadocno
         ELSE
            LET g_apcbdocno_str = g_apcbdocno_str,",",g_apca_d2[li_ac].apcadocno
         END IF  
         #150909-00005#1 --e

         LET g_apca_d2[li_ac].apca001  = g_apca_d2[li_ac].apca001 ,s_desc_gzcbl004_desc('8502',g_apca_d2[li_ac].apca001)
         LET g_apca_d2[li_ac].apca007  = g_apca_d2[li_ac].apca007 ,s_desc_get_acc_desc('3211',g_apca_d2[li_ac].apca007)
      
         LET li_ac = li_ac + 1
         IF li_ac > g_max_rec THEN
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
      CALL g_apca_d2.deleteElement(g_apca_d2.getLength())
      LET g_detail_idx2 = 1
      CALL s_fin_get_wc_str(g_apcbdocno_str) RETURNING g_apcbdocno_str #150909-00005#1 add
   END IF
   
   #發票信息
   LET l_sql = "SELECT isam011,isam008,'',isam010,isam014,",
               "       isam023,isam024,isam025,isam026,isam027,",
               "       isam028,isam004",
               "  FROM isam_t ",
               " WHERE isament = ? AND isam050 = ?"
               
   PREPARE aapq330_pb3 FROM l_sql
   DECLARE b_fill3_curs CURSOR FOR aapq330_pb3
   LET li_ac = 1
   FOREACH b_fill3_curs USING g_enterprise,g_apca_d2[g_detail_idx2].apcadocno
      INTO g_apca_d3[li_ac].isam011,g_apca_d3[li_ac].isam008,g_apca_d3[li_ac].isam008_desc,g_apca_d3[li_ac].isam010,g_apca_d3[li_ac].isam014,
           g_apca_d3[li_ac].isam023,g_apca_d3[li_ac].isam024,g_apca_d3[li_ac].isam025,g_apca_d3[li_ac].isam026,g_apca_d3[li_ac].isam027,
           g_apca_d3[li_ac].isam028,g_apca_d3[li_ac].isam004
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "FOREACH:b_fill3_curs"
         LET g_errparam.popup = TRUE
         CALL cl_err()

         EXIT FOREACH
      END IF
      LET g_apca_d3[li_ac].isam004 = g_apca_d3[li_ac].isam004,s_desc_get_department_desc(g_apca_d3[li_ac].isam004)
      LET g_apca_d3[li_ac].isam008_desc = g_apca_d3[li_ac].isam008,s_desc_get_invoice_type_desc(g_input.apcald,g_apca_d3[li_ac].isam008)
      LET li_ac = li_ac + 1
      IF li_ac > g_max_rec THEN
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
   CALL g_apca_d3.deleteElement(g_apca_d3.getLength())

   #沖銷信息   
   LET l_sql = "   SELECT * FROM ",
               "   (             ",
               "   SELECT apce001,apcedocno,apce002,apce024,apce100,",
               "          apce109,apce119,apce003,apce010,apce014",
               "     FROM apce_t                                               ",
               "    WHERE apceent   = ",g_enterprise,"                         ",
               "      AND apceld    = '",g_input.apcald,"'                     ",
               #"      AND apce003 = '",g_apca_d2[g_detail_idx2].apcadocno,"'   ", #150909-00005#1 mark
               "      AND apce003 IN ",g_apcbdocno_str,"                        ",  #150909-00005#1 add
               "    UNION ",
               "   SELECT xrce001,xrcedocno,xrce002,xrce024,xrce100,           ",
               "          xrce109,xrce119,xrce003,xrce010,xrce014              ",
               "     FROM xrce_t                                               ",
               "    WHERE xrceent   = ",g_enterprise,"                         ",
               "      AND xrceld    = '",g_input.apcald,"'                     ",     
               #"      AND xrce003 = '",g_apca_d2[g_detail_idx2].apcadocno,"'   ", #150909-00005#1 mark        
               "      AND xrce003 IN ",g_apcbdocno_str,"                        ",  #150909-00005#1 add
               "                                                             ) ",
               "    ORDER BY apce002                                           " 
   PREPARE aapq330_pb4 FROM l_sql
   DECLARE b_fill4_curs CURSOR FOR aapq330_pb4
   LET li_ac = 1
   FOREACH b_fill4_curs 
      INTO g_apca_d4[li_ac].apce001,g_apca_d4[li_ac].apcedocno,g_apca_d4[li_ac].apce002,g_apca_d4[li_ac].apce024,g_apca_d4[li_ac].apce100,
           g_apca_d4[li_ac].apce109,g_apca_d4[li_ac].apce119  ,g_apca_d4[li_ac].apce003,g_apca_d4[li_ac].apce010,g_apca_d4[li_ac].apce014
      
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "FOREACH:b_fill4_curs"
         LET g_errparam.popup = TRUE
         CALL cl_err()

         EXIT FOREACH
      END IF
      
      #150909-00005#1 --s
      #針對沖銷明細頁籤─沖銷帳款單號,撈取對應apca001,屬於2*者,金額都要*-1呈現
      LET l_apca001 = NULL
      SELECT apca001 INTO l_apca001 FROM apca_t 
       WHERE apcaent = g_enterprise AND apcald = g_input.apcald AND apcadocno = g_apca_d4[li_ac].apce003
      IF l_apca001 MATCHES '2*' THEN
         LET g_apca_d4[li_ac].apce109 = g_apca_d4[li_ac].apce109 * -1
         LET g_apca_d4[li_ac].apce119 = g_apca_d4[li_ac].apce119 * -1   
      END IF
      #150909-00005#1 --e
      
      LET g_apca_d4[li_ac].apce001 = s_desc_gzcbl004_desc('8529',g_apca_d4[li_ac].apce001)
      LET g_apca_d4[li_ac].apce002 = s_desc_gzcbl004_desc('8506',g_apca_d4[li_ac].apce002)
      LET li_ac = li_ac + 1
      IF li_ac > g_max_rec THEN
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
   CALL g_apca_d4.deleteElement(g_apca_d4.getLength())
   #end add-point
 
 
   DISPLAY li_ac TO FORMONLY.cnt
   LET g_detail_idx2 = 1
   DISPLAY g_detail_idx2 TO FORMONLY.idx
 
 
 
 
 
   #add-point:單身填充後 name="b_fill2.after_fill"
   
   #end add-point
 
   LET l_ac = li_ac
 
END FUNCTION
 
{</section>}
 
{<section id="aapq330.detail_show" >}
#+ 顯示相關資料
PRIVATE FUNCTION aapq330_detail_show(ps_page)
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
      #應用 a12 樣板自動產生(Version:4)
 
 
 
 
      #add-point:show段單身reference name="detail_show.body.reference"
 
      #end add-point
   END IF
 
 
 
   #add-point:detail_show段之後 name="detail_show.after"
   
   #end add-point
 
END FUNCTION
 
{</section>}
 
{<section id="aapq330.filter" >}
#應用 qs13 樣板自動產生(Version:8)
#+ filter段相關程式段
#+ filter過濾功能
PRIVATE FUNCTION aapq330_filter()
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
      CONSTRUCT g_wc_filter ON apca004,apca100,apcc133,apcc136
                          FROM s_detail1[1].b_apca004,s_detail1[1].b_apca100,s_detail1[1].b_apcc133, 
                              s_detail1[1].b_apcc136
 
         BEFORE CONSTRUCT
                     DISPLAY aapq330_filter_parser('apca004') TO s_detail1[1].b_apca004
            DISPLAY aapq330_filter_parser('apca100') TO s_detail1[1].b_apca100
            DISPLAY aapq330_filter_parser('apcc133') TO s_detail1[1].b_apcc133
            DISPLAY aapq330_filter_parser('apcc136') TO s_detail1[1].b_apcc136
 
 
         #單身公用欄位開窗相關處理
         
 
         #單身一般欄位開窗相關處理
                  #----<<sel>>----
         #----<<txt>>----
         #----<<val>>----
         #----<<val2>>----
         #----<<b_apca004>>----
         #Ctrlp:construct.c.filter.page1.b_apca004
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_apca004
            #add-point:ON ACTION controlp INFIELD b_apca004 name="construct.c.filter.page1.b_apca004"
            
            #END add-point
 
 
         #----<<apca004_desc>>----
         #----<<b_apca100>>----
         #Ctrlp:construct.c.page1.b_apca100
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_apca100
            #add-point:ON ACTION controlp INFIELD b_apca100 name="construct.c.filter.page1.b_apca100"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooaj002_1()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_apca100  #顯示到畫面上
            NEXT FIELD b_apca100                     #返回原欄位
    


            #END add-point
 
 
         #----<<b_apcc108>>----
         #----<<b_apcc134>>----
         #----<<b_apcc135>>----
         #----<<b_apcc133>>----
         #Ctrlp:construct.c.filter.page1.b_apcc133
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_apcc133
            #add-point:ON ACTION controlp INFIELD b_apcc133 name="construct.c.filter.page1.b_apcc133"
            
            #END add-point
 
 
         #----<<b_apcc136>>----
         #Ctrlp:construct.c.filter.page1.b_apcc136
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_apcc136
            #add-point:ON ACTION controlp INFIELD b_apcc136 name="construct.c.filter.page1.b_apcc136"
            
            #END add-point
 
 
         #----<<b_apcc137>>----
         #----<<b_apcc109>>----
         #----<<b_apcc138>>----
         #----<<b_apcc118>>----
         #----<<b_apcc139>>----
 
 
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
 
      CALL aapq330_filter_show('apca004','b_apca004')
   CALL aapq330_filter_show('apca100','b_apca100')
   CALL aapq330_filter_show('apcc133','b_apcc133')
   CALL aapq330_filter_show('apcc136','b_apcc136')
 
 
   CALL aapq330_b_fill()
 
   CALL gfrm_curr.setFieldHidden("formonly.sel", FALSE)
   CALL gfrm_curr.setFieldHidden("formonly.b_statepic", FALSE)
 
END FUNCTION
 
{</section>}
 
{<section id="aapq330.filter_parser" >}
#應用 qs14 樣板自動產生(Version:6)
#+ filter pasara段
#+ filter欄位解析
PRIVATE FUNCTION aapq330_filter_parser(ps_field)
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
 
{<section id="aapq330.filter_show" >}
#應用 qs15 樣板自動產生(Version:6)
#+ filter標題欄位顯示搜尋條件
PRIVATE FUNCTION aapq330_filter_show(ps_field,ps_object)
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
   LET ls_condition = aapq330_filter_parser(ps_field)
   IF NOT cl_null(ls_condition) THEN
      LET ls_title = ls_title, '※', ls_condition, '※'
   END IF
 
   #將資料顯示回去
   CALL lnode_item.setAttribute("text",ls_title)
 
END FUNCTION
 
 
{</section>}
 
{<section id="aapq330.detail_action_trans" >}
#+ 單身分頁筆數顯示及action圖片顯示切換功能
PRIVATE FUNCTION aapq330_detail_action_trans()
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
 
{<section id="aapq330.detail_index_setting" >}
#+ 單身切頁後，index重新調整，避免翻頁後指到空白筆數
PRIVATE FUNCTION aapq330_detail_index_setting()
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
            IF g_apca_d.getLength() > 0 THEN
               LET li_redirect = TRUE
            END IF
         WHEN g_curr_diag.getCurrentRow("s_detail1") > g_apca_d.getLength() AND g_apca_d.getLength() > 0
            LET g_detail_idx = g_apca_d.getLength()
            LET li_redirect = TRUE
         WHEN g_curr_diag.getCurrentRow("s_detail1") != g_detail_idx
            IF g_detail_idx > g_apca_d.getLength() THEN
               LET g_detail_idx = g_apca_d.getLength()
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
 
{<section id="aapq330.mask_functions" >}
 &include "erp/aap/aapq330_mask.4gl"
 
{</section>}
 
{<section id="aapq330.other_function" readonly="Y" >}

################################################################################
# Descriptions...: 取得該類型欄位sum
# Memo...........:
# Usage..........: CALL aapq330_get_value_b(p_apca004,p_apca100,p_type,p_yy,p_mm,p_feld)
#                  RETURNING r_apcc105
# Date & Author..: 14/06/25 By Belle
# Modify.........:
################################################################################
PUBLIC FUNCTION aapq330_get_value_b(p_apca004,p_apca100,p_type,p_yy,p_mm,p_feld)
DEFINE p_apca004   LIKE apca_t.apca004 #帳款對象
DEFINE p_apca100   LIKE apca_t.apca100 #幣別
DEFINE p_feld      LIKE type_t.chr80   #彙總欄位條件
DEFINE p_type      LIKE type_t.chr2    #類型  
DEFINE p_yy        LIKE glav_t.glav002 #年度
DEFINE p_mm        LIKE glav_t.glav006 #期別

DEFINE r_apcc108   LIKE apcc_t.apcc108
DEFINE l_apcc108   LIKE apcc_t.apcc108
DEFINE l_sql       STRING
DEFINE l_sql1      STRING
DEFINE l_sql2      STRING
   
   IF NOT g_input.op1 = '5' THEN
      LET l_sql = " SELECT (SUM(CASE apca001 WHEN '02' THEN apcc108 * -1                    ",
                  "                          WHEN '04' THEN apcc108 * -1 ELSE apcc108 END)) ",
                  "   FROM apca_t,apcc_t",
                  "  WHERE apcaent = apccent AND apcald = apccld AND apcadocno = apccdocno",
                  "    AND apcastus = 'Y'",
                  "    AND apcaent = ?       AND apcald = ?      AND apca004 = ? ",
                  "    AND apca100 = ?"
      IF NOT g_input.op1 = '1' THEN
         LET l_sql =  l_sql ," AND ",l_ar[g_input.op1].feld1,"= '",p_feld,"'"
      END IF
   ELSE
     LET l_sql =  " SELECT (SUM(CASE apca001 WHEN '02' THEN apcc108 * -1                    ",
                  "                          WHEN '04' THEN apcc108 * -1 ELSE apcc108 END)) ",
                  "   FROM apca_t,apcc_t,glav_t",
                  "  WHERE apcaent = apccent AND apcald = apccld AND apcadocno = apccdocno",
                  "    AND apcaent = glavent AND glav001 = '",g_glaa003,"'",
                  "    AND glav002 =",p_yy," AND glav006 = ",p_mm,
                  "    AND apcastus = 'Y'    AND apcadocdt = glav004",
                  "    AND apcaent = ?       AND apcald = ?      AND apca004 = ? ",
                  "    AND apca100 = ?"
   END IF
   
   IF g_input.op2 = '7' THEN #尚有未沖餘額者
      LET l_sql =  l_sql ," AND apcc108 - apcc109 <> 0"
   END IF
   IF g_input.op2 = '8' THEN #已沖銷完畢者
      LET l_sql =  l_sql ," AND apcc108 - apcc109 = 0"
   END IF
   #151013-00016#12
   IF NOT cl_null(g_wc_apcastus) THEN
      LET l_sql =  l_sql ,g_wc_apcastus
   END IF
   #151013-00016#12
   CASE p_type

        WHEN '13' #採購應付(+)
             LET l_sql1 =  l_sql ," AND apca001 IN ('13','17','18')" 
        WHEN '19' #其他應付(+)
             LET l_sql1 =  l_sql ," AND apca001 = '19' " 
       WHEN '11' #預付款(-)
             LET l_sql1 =  l_sql ," AND apca001 IN ('21','23','25') " 
        WHEN '22' #倉退及折讓(-)
             LET l_sql1 =  l_sql ," AND apca001 IN ('22','24','29')" 
        WHEN '01' #暫估應付(+)
             LET l_sql1 =  l_sql ," AND apca001 IN ('01','02','03','04') " 
   END CASE
   LET l_sql1 = l_sql1 CLIPPED , " AND apcasite = '",g_input.apcasite,"' AND apcald = '",g_input.apcald,"' AND apca001 NOT IN ('11','14') " 
   LET l_sql1 = l_sql1 CLIPPED , " AND ",g_wc_qry," "   #150401-00001#44 將g_wc改為g_wc_qry
   PREPARE aapq330_get_value_pre1 FROM l_sql1
   EXECUTE aapq330_get_value_pre1 USING g_enterprise,g_input.apcald,p_apca004,p_apca100 INTO r_apcc108
   IF cl_null(r_apcc108) THEN LET r_apcc108 = 0  END IF
   
#   IF p_type = '19' OR p_type = '02' THEN 
#      CASE p_type
#           WHEN '19' #其他應付 
#                LET l_sql2 =  l_sql ," AND apca001 ='29'" 
#           WHEN '01' #暫估應付
#                LET l_sql1 =  l_sql ," AND apca001 ='02'" 
#      END CASE
#      PREPARE aapq330_get_value_pre2 FROM l_sql2
#      EXECUTE aapq330_get_value_pre2 USING g_enterprise,g_input.apcald,p_apca004,p_apca100 INTO l_apcc105
#      IF cl_null(l_apcc105) THEN LET l_apcc105 = 0  END IF
#      LET r_apcc105 = r_apcc105 - l_apcc105
#   END IF
   
   RETURN r_apcc108

END FUNCTION

################################################################################
# Descriptions...: 取得該類型欄位sum
# Memo...........:
# Usage..........: CALL aapq330_get_sum_b(p_apca004,p_apca100,p_yy,p_mm,p_feld)
#                  RETURNING r_value
# Date & Author..: 14/06/25 By Belle
# Modify.........:
################################################################################
PUBLIC FUNCTION aapq330_get_sum_b(p_apca004,p_apca100,p_yy,p_mm,p_feld)
DEFINE p_apca004   LIKE apca_t.apca004 #帳款對象
DEFINE p_apca100   LIKE apca_t.apca100 #幣別
DEFINE p_feld      LIKE type_t.chr80   #彙總欄位條件
DEFINE p_type      LIKE type_t.chr2    #類型
DEFINE p_yy        LIKE glav_t.glav002 #年度
DEFINE p_mm        LIKE glav_t.glav006 #期別
DEFINE r_apcc108   LIKE apcc_t.apcc108
DEFINE r_apcc109   LIKE apcc_t.apcc109
DEFINE r_apcc1081  LIKE apcc_t.apcc108
DEFINE r_apcc118   LIKE apcc_t.apcc118
DEFINE r_apcc1181  LIKE apcc_t.apcc118

DEFINE l_sql       STRING
DEFINE l_sql1      STRING
DEFINE l_sql2      STRING
DEFINE l_apcc108   LIKE apcc_t.apcc108
DEFINE l_apcc109   LIKE apcc_t.apcc109
DEFINE l_apcc1081  LIKE apcc_t.apcc108
DEFINE l_apcc118   LIKE apcc_t.apcc118
DEFINE l_apcc1181  LIKE apcc_t.apcc118
   
   IF NOT g_input.op1 = '5' THEN
      LET l_sql = " SELECT sum(apcc108),sum(apcc109),sum(apcc108-apcc109), ",
                  "        sum(apcc118),             sum(apcc118-apcc119+apcc113)",
                  "   FROM apca_t,apcc_t",
                  "  WHERE apcaent = apccent AND apcald = apccld AND apcadocno = apccdocno",
                  "    AND apcastus = 'Y'",
                  "    AND apcaent = ?       AND apcald = ?      AND apca004 = ?",
                  "    AND apca100 = ? "
      IF NOT g_input.op1 = '1' THEN
         LET l_sql =  l_sql ," AND ",l_ar[g_input.op1].feld1,"= '",p_feld,"'"
      END IF
   ELSE
      LET l_sql = " SELECT sum(apcc108),sum(apcc109),sum(apcc108-apcc109), ",
                  "        sum(apcc118),             sum(apcc118-apcc119+apcc113)",
                  "   FROM apca_t,apcc_t,glav_t",
                  "  WHERE apcaent = apccent AND apcald = apccld AND apcadocno = apccdocno",
                  "    AND apcaent = glavent AND glav001 = '",g_glaa003,"'",
                  "    AND glav002 =",p_yy," AND glav006 = ",p_mm,
                  "    AND apcastus = 'Y'    AND apcadocdt = glav004",
                  "    AND apcaent = ?       AND apcald = ?      AND apca004 = ? ",
                  "    AND apca100 = ?"
   END IF
   IF g_input.op2 = '7' THEN #尚有未沖餘額者
      LET l_sql =  l_sql ," AND apcc108 - apcc109 <> 0"
   END IF
   IF g_input.op2 = '8' THEN #已沖銷完畢者
      LET l_sql =  l_sql ," AND apcc108 - apcc109 = 0"
   END IF
   LET l_sql = l_sql CLIPPED , " AND apcasite = '",g_input.apcasite,"' AND apcald = '",g_input.apcald,"' AND apca001 NOT IN ('11','14') " 
   LET l_sql = l_sql CLIPPED , " AND ",g_wc_qry," "    #150401-00001#44 將g_wc改為g_wc_qry
   
   #加項
   LET l_sql1= l_sql ,"    AND apca001 IN ('13','17','18','19','01','03')"
   #減項
   LET l_sql2= l_sql ,"    AND apca001 IN ('21','22','23','24','25','29','02','04')"
   #151013-00016#12
   IF NOT cl_null(g_wc_apcastus) THEN
      LET l_sql =  l_sql ,g_wc_apcastus
   END IF
   #151013-00016#12
   
   
   PREPARE aapq330_get_sum_pre1 FROM l_sql1
   EXECUTE aapq330_get_sum_pre1 USING g_enterprise,g_input.apcald,p_apca004,p_apca100 INTO r_apcc108,r_apcc109,r_apcc1081,r_apcc118,r_apcc1181 
   IF cl_null(r_apcc108)  THEN LET r_apcc108 = 0  END IF
   IF cl_null(r_apcc109)  THEN LET r_apcc109 = 0  END IF
   IF cl_null(r_apcc1081) THEN LET r_apcc1081= 0  END IF
   IF cl_null(r_apcc118)  THEN LET r_apcc118 = 0  END IF
   IF cl_null(r_apcc1181) THEN LET r_apcc1181= 0  END IF
   
   PREPARE aapq330_get_sum_pre2 FROM l_sql2
   EXECUTE aapq330_get_sum_pre2 USING g_enterprise,g_input.apcald,p_apca004,p_apca100 INTO l_apcc108,l_apcc109,l_apcc1081,l_apcc118,l_apcc1181 
   IF cl_null(l_apcc108)  THEN LET l_apcc108 = 0  END IF
   IF cl_null(l_apcc109)  THEN LET l_apcc109 = 0  END IF
   IF cl_null(l_apcc1081) THEN LET l_apcc1081= 0  END IF
   IF cl_null(l_apcc118)  THEN LET l_apcc118 = 0  END IF
   IF cl_null(l_apcc1181) THEN LET l_apcc1181= 0  END IF
   
   #應付總額
   LET r_apcc108  = r_apcc108 - l_apcc108 
   LET r_apcc109  = r_apcc109 - l_apcc109 
   LET r_apcc1081 = r_apcc1081- l_apcc1081
   LET r_apcc118  = r_apcc118 - l_apcc118 
   LET r_apcc1181 = r_apcc1181- l_apcc1181
   
   RETURN r_apcc108,r_apcc109,r_apcc1081,
          r_apcc118,          r_apcc1181
END FUNCTION

################################################################################
# Descriptions...: 掃把清空&給預設值 #150127-00007#1
# Memo...........:
# Usage..........: CALL aapq330_qbe_clear()

# Date & Author..: 2015/02/02 By Reanna
# Modify.........:
################################################################################
PRIVATE FUNCTION aapq330_qbe_clear()
   
   CALL cl_set_comp_att_text('txt',cl_getmsg(l_ar[g_input.op1].title,g_lang))
   
   CALL s_aap_get_default_apcasite('','','')RETURNING g_sub_success,g_errno,g_input.apcasite,
                                                      g_input.apcald,g_input.apcacomp
   LET g_input.apcald_desc   = s_desc_get_ld_desc(g_input.apcald)
   LET g_input.apcacomp_desc = s_desc_get_department_desc(g_input.apcacomp)
   LET g_input.apcasite_desc = s_desc_get_department_desc(g_input.apcasite) 
   #161114-00017#1 add ------
   CALL s_fin_get_wc_str(g_input.apcacomp) RETURNING g_comp_str  #161229-00047#27 add
   CALL s_control_get_supplier_sql_pmab('4',g_site,g_user,g_dept,'',g_comp_str) RETURNING g_sub_success,g_sql_ctrl        #161229-00047#27 add
   #CALL s_control_get_supplier_sql_pmab('4',g_site,g_user,g_dept,'',g_input.apcacomp) RETURNING g_sub_success,g_sql_ctrl #161229-00047#27 mark
   #161114-00017#1 add end---   
   #取得帳務組織下所屬成員
   CALL s_fin_account_center_sons_query('3',g_input.apcasite,g_today,'')
   CALL s_fin_account_center_ld_str() RETURNING g_wc_apcald
   CALL s_fin_get_wc_str(g_wc_apcald) RETURNING g_wc_apcald
   
   DISPLAY BY NAME g_input.apcald,g_input.apcald_desc,g_input.apcacomp,g_input.apcacomp_desc,
                   g_input.apcasite, g_input.apcasite_desc
END FUNCTION

################################################################################
# Descriptions...: 新增TEMP TABLE
# Memo...........: #150319-00004#2  
# Date & Author..: 150428   By rayhuang
# Modify.........:
################################################################################
PRIVATE FUNCTION aapq330_create_tmp()
   DROP TABLE aapq330_x01_tmp;
   CREATE TEMP TABLE aapq330_x01_tmp(
      txt           LIKE type_t.chr500, 
      apca004_desc  LIKE type_t.chr500, 
      apca100       LIKE apca_t.apca100, 
      apcc108       LIKE apcc_t.apcc108, 
      apcc134       LIKE apcc_t.apcc134, 
      apcc135       LIKE apcc_t.apcc135, 
      apcc133       LIKE apcc_t.apcc133, 
      apcc136       LIKE apcc_t.apcc136, 
      apcc137       LIKE apcc_t.apcc137, 
      apcc109       LIKE apcc_t.apcc109, 
      apcc138       LIKE apcc_t.apcc138, 
      apcc118       LIKE apcc_t.apcc118, 
      apcc139       LIKE apcc_t.apcc139,
      apcald        LIKE apca_t.apcald,
      apcacomp      LIKE apca_t.apcacomp,
      apcasite      LIKE apca_t.apcasite,
      apcald_desc   LIKE type_t.chr500,
      apcacomp_desc LIKE type_t.chr500,
      apcasite_desc LIKE type_t.chr500
      )      
END FUNCTION

################################################################################
# Descriptions...: 轉成SQL
# Memo...........: #161014-00053#2
# Usage..........: CALL aapq330_get_ooef001_wc(p_wc)
#                  RETURNING 回传参数
# Input parameter: p_wc 帳套
# Return code....: r_wc ('帳套')
# Date & Author..: 161020 By 08171
# Modify.........:
################################################################################
PRIVATE FUNCTION aapq330_get_ooef001_wc(p_wc)
   DEFINE p_wc       STRING
   DEFINE r_wc       STRING
   DEFINE tok        base.StringTokenizer
   DEFINE l_str      STRING

   LET tok = base.StringTokenizer.create(p_wc,",")
   WHILE tok.hasMoreTokens()
      IF cl_null(l_str) THEN
         LET l_str = tok.nextToken()
      ELSE
         LET l_str = l_str,"','",tok.nextToken()
      END IF      
   END WHILE   
   LET r_wc = "('",l_str,"')"
   
   RETURN r_wc
END FUNCTION

 
{</section>}
 
