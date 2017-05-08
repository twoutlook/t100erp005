#該程式未解開Section, 採用最新樣板產出!
{<section id="afmp530.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0003(2015-06-12 10:02:37), PR版次:0003(2016-10-24 09:30:40)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000038
#+ Filename...: afmp530
#+ Description: 拋轉還原整批處理
#+ Creator....: 05016(2015-05-26 17:30:31)
#+ Modifier...: 05016 -SD/PR- 06814
 
{</section>}
 
{<section id="afmp530.global" >}
#應用 p02 樣板自動產生(Version:22)
#add-point:填寫註解說明 name="global.memo"
#Memos
#161006-00005#24  161024      By 06814    帳務中心(site)開窗改用q_ooef001_46() 
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

#end add-point
 
#模組變數(Module Variables)
DEFINE g_wc                 STRING
DEFINE g_wc_t               STRING                        #儲存 user 的查詢條件
DEFINE g_wc2                STRING
DEFINE g_wc_filter          STRING
DEFINE g_wc_filter_t        STRING
DEFINE g_sql                STRING
DEFINE g_forupd_sql         STRING                        #SELECT ... FOR UPDATE SQL
DEFINE g_before_input_done  LIKE type_t.num5
DEFINE g_cnt                LIKE type_t.num10    
DEFINE l_ac                 LIKE type_t.num10              
DEFINE l_ac_d               LIKE type_t.num10             #單身idx 
DEFINE g_curr_diag          ui.Dialog                     #Current Dialog
DEFINE gwin_curr            ui.Window                     #Current Window
DEFINE gfrm_curr            ui.Form                       #Current Form
DEFINE g_current_page       LIKE type_t.num10             #目前所在頁數
DEFINE g_ref_fields         DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
DEFINE g_rtn_fields         DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
DEFINE g_ref_vars           DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
DEFINE gs_keys              DYNAMIC ARRAY OF VARCHAR(500) #同步資料用陣列
DEFINE gs_keys_bak          DYNAMIC ARRAY OF VARCHAR(500) #同步資料用陣列
DEFINE g_insert             LIKE type_t.chr5              #是否導到其他page
DEFINE g_error_show         LIKE type_t.num5
DEFINE g_master_idx         LIKE type_t.num10
 
TYPE type_parameter RECORD
   #add-point:自定背景執行須傳遞的參數(Module Variable) name="global.parameter"
        site            LIKE type_t.chr20,
        site_desc       LIKE type_t.chr80,
        glaald          LIKE glaa_t.glaald,
        glaald_desc     LIKE type_t.chr80,
        glaacomp        LIKE glaa_t.glaacomp,
        glaacomp_desc   LIKE type_t.chr80,
        type            LIKE type_t.chr10,
   #end add-point
        wc               STRING
                     END RECORD
 
TYPE type_g_detail_d RECORD
#add-point:自定義模組變數(Module Variable)  #注意要在add-point內寫入END RECORD name="global.variable"
     sel           LIKE type_t.chr1,
     glapdocno     LIKE glap_t.glapdocno,
     glapdocdt     LIKE glap_t.glapdocdt,
     glap007       LIKE glap_t.glap007,
     glap008       LIKE glap_t.glap008,
     glap010       LIKE glap_t.glap010,
     glap011       LIKE glap_t.glap011,
     glapstus      LIKE glap_t.glapstus
     END RECORD

TYPE type_g_qbe   RECORD
   ori_docno          LIKE type_t.chr500,
   ori_docdt          LIKE type_t.dat,
   glapdocno      LIKE type_t.chr500,
   glapcrtid      LIKE type_t.chr500
              END RECORD

      
DEFINE g_input       type_parameter    #INPUT條件
DEFINE g_input_t     type_parameter    #備份INPUT條件
DEFINE g_qbe         type_g_qbe        #QBE條件

DEFINE g_rec_b        LIKE type_t.num5 
DEFINE l_cnt          LIKE type_t.num5
DEFINE g_detail_idx   LIKE type_t.num5
DEFINE g_glaa013      LIKE glaa_t.glaa013

DEFINE g_wc_glaald   STRING
DEFINE g_glap008     LIKE glap_t.glap008
#end add-point
 
#add-point:自定義客戶專用模組變數(Module Variable) name="global.variable_customerization"

#end add-point
DEFINE g_detail_cnt         LIKE type_t.num10              #單身 總筆數(所有資料)
DEFINE g_detail_d  DYNAMIC ARRAY OF type_g_detail_d
 
#add-point:傳入參數說明 name="global.argv"
 
#end add-point
 
{</section>}
 
{<section id="afmp530.main" >}
#+ 作業開始 
MAIN
   #add-point:main段define(客製用) name="main.define_customerization"
   
   #end add-point   
   DEFINE ls_js  STRING
   #add-point:main段define name="main.define"
   
   #end add-point   
   
   #設定SQL錯誤記錄方式 (模組內定義有效)
   WHENEVER ERROR CALL cl_err_msg_log
 
   #add-point:初始化前定義 name="main.before_ap_init"
   
   #end add-point
   #依模組進行系統初始化設定(系統設定)
   CALL cl_ap_init("afm","")
 
   #add-point:定義背景狀態與整理進入需用參數ls_js name="main.background"
   
   #end add-point
 
   IF g_bgjob = "Y" THEN
      #add-point:Service Call name="main.servicecall"
      
      #end add-point
   ELSE
      #畫面開啟 (identifier)
      OPEN WINDOW w_afmp530 WITH FORM cl_ap_formpath("afm",g_code)
   
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
   
      #程式初始化
      CALL afmp530_init()   
 
      #進入選單 Menu (="N")
      CALL afmp530_ui_dialog() 
 
      #add-point:畫面關閉前 name="main.before_close"
      
      #end add-point
      #畫面關閉
      CLOSE WINDOW w_afmp530
   END IF 
   
   #add-point:作業離開前 name="main.exit"
   DROP TABLE afmp530_tmp;
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
END MAIN
 
{</section>}
 
{<section id="afmp530.init" >}
#+ 畫面資料初始化
PRIVATE FUNCTION afmp530_init()
   #add-point:init段define(客製用) name="init.define_customerization"
   
   #end add-point   
   #add-point:init段define name="init.define"
 
   #end add-point   
   
   LET g_error_show  = 1
   LET g_wc_filter   = " 1=1"
   LET g_wc_filter_t = " 1=1"
 
   #add-point:畫面資料初始化 name="init.init"
   CALL cl_set_combo_scc_part('glapstus','13','N,Y,S')
   CALL cl_set_combo_scc('type','9986')
   CALL cl_set_combo_scc('glap007','8007')
   CALL s_fin_create_account_center_tmp()     #展組織下階成員所需之暫存檔 
   #end add-point
   
END FUNCTION
 
{</section>}
 
{<section id="afmp530.ui_dialog" >}
#+ 選單功能實際執行處
PRIVATE FUNCTION afmp530_ui_dialog()
   #add-point:ui_dialog段define(客製用) name="ui_dialog.define_customerization"
   
   #end add-point 
   DEFINE li_idx   LIKE type_t.num10
   #add-point:ui_dialog段define name="init.init"
 
   #end add-point 
   
   LET gwin_curr = ui.Window.getCurrent()
   LET gfrm_curr = gwin_curr.getForm()   
   
   LET g_action_choice = " "  
   CALL cl_set_act_visible("accept,cancel", FALSE)
         
   LET g_detail_cnt = g_detail_d.getLength()
   #add-point:ui_dialog段before dialog name="ui_dialog.before_dialog"
   CALL afmp530_qbeclear()
   #end add-point
   
   WHILE TRUE
 
      IF g_action_choice = "logistics" THEN
         #清除畫面及相關資料
         CLEAR FORM
         CALL g_detail_d.clear()
         LET g_wc  = ' 1=2'
         LET g_wc2 = ' 1=1'
         LET g_action_choice = ""
         CALL afmp530_init()
      END IF
 
      DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
         #add-point:ui_dialog段construct name="ui_dialog.more_construct"
         
         #end add-point
         #add-point:ui_dialog段input name="ui_dialog.more_input"
         INPUT BY NAME g_input.site,g_input.site_desc,g_input.glaald,g_input.glaald_desc,g_input.glaacomp,
                       g_input.glaacomp_desc,g_input.type
               ATTRIBUTE(WITHOUT DEFAULTS)
           
            BEFORE INPUT
               

           AFTER FIELD site
               LET g_input.site_desc = ''
               IF NOT cl_null(g_input.site) THEN
                  CALL s_fin_account_center_sons_query('3',g_input.site,g_today,'')
                  CALL s_fin_account_center_with_ld_chk(g_input.site,g_input.glaald,g_user,'3','N','',g_today) RETURNING g_sub_success,g_errno
                  IF NOT g_sub_success THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = g_errno
                     LET g_errparam.extend = ''
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                     LET g_input.site = ''
                     LET g_input.glaald = ''
                     LET g_input.glaald_desc  = ''
                     CALL s_desc_get_department_desc(g_input.site) RETURNING g_input.site_desc
                     DISPLAY BY NAME g_input.site_desc,g_input.glaald_desc
                     NEXT FIELD CURRENT
                  END IF
               END IF
               CALL s_fin_account_center_sons_query('3',g_input.site,g_today,'')
               CALL s_fin_account_center_ld_str() RETURNING g_wc_glaald
               CALL s_fin_get_wc_str(g_wc_glaald) RETURNING g_wc_glaald
               CALL s_desc_get_department_desc(g_input.site) RETURNING g_input.site_desc
               DISPLAY BY NAME g_input.site_desc 
               
           AFTER FIELD glaald
               LET g_input.glaald_desc   = ''
               LET g_input.glaacomp_desc = ''
               LET g_input.glaacomp      = ''
               IF NOT cl_null(g_input.glaald) THEN
                  CALL s_fin_account_center_with_ld_chk(g_input.site,g_input.glaald,g_user,'3','N','',g_today) RETURNING g_sub_success,g_errno
                  IF NOT g_sub_success THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = g_errno
                     LET g_errparam.extend = ''
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                     LET g_input.glaald = ''
                     LET g_input.glaald_desc  = ''
                     DISPLAY BY NAME g_input.glaald_desc
                     NEXT FIELD CURRENT
                  END IF
                  CALL s_fin_ld_carry(g_input.glaald,'') RETURNING g_sub_success,g_input.glaald,g_input.glaacomp,g_errno
                  IF NOT g_sub_success THEN
                      INITIALIZE g_errparam TO NULL
                      LET g_errparam.code = g_errno
                      LET g_errparam.extend = g_input.glaald
                      LET g_errparam.popup = TRUE
                      CALL cl_err()
                      LET g_input.glaald = ''
                      LET g_input.glaald_desc  = ''
                      DISPLAY BY NAME g_input.glaald_desc
                  END IF
                  IF NOT g_success THEN LET g_input.glaald = '' END IF
                  LET g_input_t.glaald = g_input.glaald
               END IF
   　　　　　　 #取得帳套關帳日期
   　　　　　　SELECT glaa013 INTO g_glaa013
   　　　　　　  FROM glaa_t
   　　　　　　 WHERE glaaent = g_enterprise
   　　　　　　   AND glaald = g_input.glaald
               LET g_input.glaald_desc   = s_desc_get_ld_desc(g_input.glaald)
               LET g_input.glaacomp_desc = s_desc_get_department_desc(g_input.glaacomp)
               DISPLAY BY NAME g_input.glaald,g_input.glaald_desc,g_input.glaacomp,g_input.glaacomp_desc
               
               
            ON ACTION controlp INFIELD site
      			INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'i'
      			LET g_qryparam.reqry = FALSE
               LET g_qryparam.default1 = g_input.site                    #給予default值
               #161006-00005#24 20161024 add by beckxie---S
               #LET g_qryparam.where = " ooef204 = 'Y' "  #資金組織
               #CALL q_ooef001()                                       #呼叫開窗
               #161006-00005#24 20161024 add by beckxie---E
               CALL q_ooef001_46()                                        #161006-00005#24 20161024 add by beckxie
               LET g_input.site = g_qryparam.return1                     #將開窗取得的值回傳到變數
               CALL s_desc_get_department_desc(g_input.site) RETURNING g_input.site_desc
               DISPLAY BY NAME g_input.site,g_input.site_desc
               NEXT FIELD site                                            #返回原欄位
                        
               
           ON ACTION controlp INFIELD glaald
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'i'
               LET g_qryparam.reqry = FALSE
               LET g_qryparam.default1 = g_input.glaald                     #給予default值
               LET g_qryparam.where = " (glaa008 = 'Y' OR glaa014 = 'Y') "  #glaa008(平行記帳)/glaa014(主帳套)
               LET g_qryparam.arg1 = g_user                                 #人員權限
               LET g_qryparam.arg2 = g_dept                                 #部門權限
               LET g_qryparam.where = " glaald IN ",g_wc_glaald
               CALL q_authorised_ld()                                       #呼叫開窗
               LET g_input.glaald = g_qryparam.return1                      #將開窗取得的值回傳到變數
               CALL s_fin_ld_carry(g_input.glaald,'') RETURNING g_success,g_input.glaald,g_input.glaacomp,g_errno
               LET g_input.glaald_desc   = s_desc_get_ld_desc(g_input.glaald)
               LET g_input.glaacomp_desc = s_desc_get_department_desc(g_input.glaacomp)
               DISPLAY BY NAME g_input.glaald,g_input.glaald_desc,g_input.glaacomp,g_input.glaacomp_desc
               NEXT FIELD glaald                                        #返回原欄位
               
         END INPUT
         
         #查詢QBE
         CONSTRUCT BY NAME g_wc ON ori_docno,ori_docdt,glapdocno,glapcrtid

            BEFORE CONSTRUCT
               CALL cl_qbe_init()
            
            AFTER CONSTRUCT
               #呼叫P次作業
               
            ON ACTION controlp INFIELD ori_docno
   	         INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c'
   	         LET g_qryparam.reqry = FALSE
   	         CASE
                  WHEN g_input.type = 'afmt535'
                     LET g_qryparam.where ="     fmmlstus = 'Y' AND fmml007 IS NOT NULL ",
                                           " AND fmml001 = '",g_input.site,"'   ",
                                           " AND fmml003 = '",g_input.glaald,"'     "
                      CALL q_fmmldocno() 
                  WHEN g_input.type = 'afmt555'
                     LET g_qryparam.where = "     fmmqstus ='Y' AND fmmq004 IS NOT NULL  ", 
                                            " AND fmmqsite = '",g_input.site,"'  ",
                                            " AND fmmq001  = '",g_input.glaald,"'    "                       
                     CALL q_fmmqdocno()                           
                  WHEN g_input.type = 'afmt565'
                     LET g_qryparam.where = "     fmmustus ='Y' AND fmmu004 IS NOT NULL   ", 
                                            " AND fmmusite = '",g_input.site,"'   ",
                                           "  AND fmmu001  = '",g_input.glaald,"'     " 
                     CALL q_fmmudocno()                                                  
                  WHEN g_input.type = 'afmt570' 
                     LET g_qryparam.where = "     fmnastus ='Y' AND fmna005 IS  NOT NULL   ",
                                            " AND fmnasite = '",g_input.site,"'   ",
                                            " AND fmna001  = '",g_input.glaald,"'     "                     
                     CALL q_fmnadocno()                      
                  WHEN g_input.type = 'afmt585'
                     LET g_qryparam.where = "     fmmwstus ='Y' AND fmmw004 IS  NOT NULL   ",
                                            " AND fmmwsite = '",g_input.site,"'   ",
                                            " AND fmmw001  = '",g_input.glaald,"'     "
                     CALL q_fmmwdocno()                        
                  WHEN g_input.type = 'afmt595'
                     LET g_qryparam.where = "     fmnestus ='Y' AND fmne004 IS NOT NULL   ", 
                                            " AND fmnesite = '",g_input.site,"'   ",
                                            " AND fmne001  = '",g_input.glaald,"'     "                     
                     CALL q_fmnedocno()                                      
               END CASE
   	         
               DISPLAY g_qryparam.return1 TO ori_docno  #顯示到畫面上  
               NEXT FIELD ori_docno                     #返回原欄位                 
         
   
            ON ACTION controlp INFIELD glapdocno
   	         INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c'
   	         LET g_qryparam.reqry = FALSE
               CASE
                  WHEN g_input.type = 'afmt535'  
                     LET g_qryparam.where = " glap007 = 'FM' AND glap008 = 'M20' AND glapstus <> 'Y'"
                  WHEN g_input.type = 'afmt555'  
                     LET g_qryparam.where = " glap007 = 'FM' AND glap008 = 'M30' AND glapstus <> 'Y'"
                  WHEN g_input.type = 'afmt565'  
                     LET g_qryparam.where = " glap007 = 'FM' AND glap008 = 'M40' AND glapstus <> 'Y'"
                  WHEN g_input.type = 'afmt570'  
                     LET g_qryparam.where = " glap007 = 'FM' AND glap008 = 'M10' AND glapstus <> 'Y'"
                  WHEN g_input.type = 'afmt585'  
                     LET g_qryparam.where = " glap007 = 'FM' AND glap008 = 'M50' AND glapstus <> 'Y'"
                  WHEN g_input.type = 'afmt595'  
                     LET g_qryparam.where = " glap007 = 'FM' AND glap008 = 'M60' AND glapstus <> 'Y'"                                   
   	         END CASE
   	         CALL q_glapdocno_1() 
   	         DISPLAY g_qryparam.return1 TO glapdocno  #顯示到畫面上  
               NEXT FIELD glapdocno                     #返回原欄位  
               
            ON ACTION controlp INFIELD glapcrtid
			      INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c'
			      LET g_qryparam.reqry = FALSE
               CALL q_ooag001()                         #呼叫開窗
               DISPLAY g_qryparam.return1 TO glapcrtid  #顯示到畫面上
               NEXT FIELD glapcrtid                     #返回原欄位
               
         END CONSTRUCT
         
         INPUT ARRAY g_detail_d FROM s_detail1.* 
              ATTRIBUTE(COUNT = g_rec_b,MAXCOUNT = g_max_rec,WITHOUT DEFAULTS, 
                        INSERT ROW = FALSE,
                        DELETE ROW = FALSE,
                        APPEND ROW = FALSE)
            BEFORE INPUT
               IF g_insert = 'Y' AND NOT cl_null(g_insert) THEN 
                 CALL FGL_SET_ARR_CURR(g_detail_d.getLength()+1) 
                 LET g_insert = 'N' 
               END IF 
             
            BEFORE ROW
               LET l_ac = ARR_CURR()
               LET g_master_idx = l_ac
               DISPLAY l_ac TO FORMONLY.h_index
               CALL afmp530_fetch() 
             
               
            ON CHANGE sel
               CALL s_afm_close_day_chk(g_input.glaald,g_detail_d[l_ac].glapdocno) RETURNING g_sub_success,g_errno
               IF NOT g_sub_success THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = g_errno
                  LET g_errparam.extend = ''
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
                  CONTINUE DIALOG
               END IF
           
         END INPUT
         #end add-point
         #add-point:ui_dialog段自定義display array name="ui_dialog.more_displayarray"
 
         #end add-point
 
         BEFORE DIALOG
            IF g_detail_d.getLength() > 0 THEN
               CALL gfrm_curr.setFieldHidden("formonly.sel", TRUE)
               CALL gfrm_curr.setFieldHidden("formonly.statepic", TRUE)
            ELSE
               CALL gfrm_curr.setFieldHidden("formonly.sel", FALSE)
               CALL gfrm_curr.setFieldHidden("formonly.statepic", FALSE)
            END IF
            #add-point:ui_dialog段before_dialog2 name="ui_dialog.before_dialog2"
            CALL gfrm_curr.setFieldHidden("formonly.sel", FALSE)
            #end add-point
 
         #選擇全部
         ON ACTION selall
            CALL DIALOG.setSelectionRange("s_detail1", 1, -1, 1)
            #add-point:ui_dialog段on action selall name="ui_dialog.selall.befroe"
            CALL cl_err_collect_init()
            #end add-point            
            FOR li_idx = 1 TO g_detail_d.getLength()
               LET g_detail_d[li_idx].sel = "Y"
               #add-point:ui_dialog段on action selall name="ui_dialog.for.onaction_selall"
               CALL s_afm_close_day_chk(g_input.glaald,g_detail_d[li_idx].glapdocno) RETURNING g_sub_success,g_errno
               IF NOT g_sub_success THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = g_errno
                  LET g_errparam.extend = ''
                  LET g_errparam.popup = TRUE
                  CALL cl_err()              
                  CONTINUE DIALOG
               END IF
               #end add-point
            END FOR
            #add-point:ui_dialog段on action selall name="ui_dialog.onaction_selall"
            CALL cl_err_collect_show()
            #end add-point
 
         #取消全部
         ON ACTION selnone
            CALL DIALOG.setSelectionRange("s_detail1", 1, -1, 0)
            FOR li_idx = 1 TO g_detail_d.getLength()
               LET g_detail_d[li_idx].sel = "N"
               #add-point:ui_dialog段on action selnone name="ui_dialog.for.onaction_selnone"
 
               #end add-point
            END FOR
            #add-point:ui_dialog段on action selnone name="ui_dialog.onaction_selnone"
            
            #end add-point
 
         #勾選所選資料
         ON ACTION sel
            FOR li_idx = 1 TO g_detail_d.getLength()
               IF DIALOG.isRowSelected("s_detail1", li_idx) THEN
                  LET g_detail_d[li_idx].sel = "Y"
               END IF
            END FOR
            #add-point:ui_dialog段on action sel name="ui_dialog.onaction_sel"
         
            #end add-point
 
         #取消所選資料
         ON ACTION unsel
            FOR li_idx = 1 TO g_detail_d.getLength()
               IF DIALOG.isRowSelected("s_detail1", li_idx) THEN
                  LET g_detail_d[li_idx].sel = "N"
               END IF
            END FOR
            #add-point:ui_dialog段on action unsel name="ui_dialog.onaction_unsel"
 
            #end add-point
      
         ON ACTION filter
            LET g_action_choice="filter"
            CALL afmp530_filter()
            #add-point:ON ACTION filter name="menu.filter"
            
            #END add-point
            EXIT DIALOG
      
         ON ACTION close
            LET INT_FLAG=FALSE         
            LET g_action_choice = "exit"
            EXIT DIALOG
      
         ON ACTION exit
            LET g_action_choice="exit"
            EXIT DIALOG
 
         ON ACTION accept
            #add-point:ui_dialog段accept之前 name="menu.filter"
            
            #end add-point
            CALL afmp530_query()
             
         # 條件清除
         ON ACTION qbeclear
            #add-point:ui_dialog段 name="ui_dialog.qbeclear"
            CALL afmp530_qbeclear()
            #end add-point
 
         # 重新整理
         ON ACTION datarefresh
            LET g_error_show = 1
            #add-point:ui_dialog段datarefresh name="ui_dialog.datarefresh"
            
            #end add-point
            CALL afmp530_b_fill()
 
         #add-point:ui_dialog段action name="ui_dialog.more_action"
         ON ACTION batch_execute
            
            CALL afmp530_process() 
            
         #end add-point
 
         #主選單用ACTION
         &include "main_menu_exit_dialog.4gl"
         &include "relating_action.4gl"
         #交談指令共用ACTION
         &include "common_action.4gl"
            CONTINUE DIALOG
      END DIALOG
 
      #(ver:22) ---start---
      #add-point:ui_dialog段 after dialog name="ui_dialog.exit_dialog"
      
      #end add-point
      #(ver:22) --- end ---
 
      IF g_action_choice = "exit" AND NOT cl_null(g_action_choice) THEN
         #(ver:22) ---start---
         #add-point:ui_dialog段離開dialog前 name="ui_dialog.b_exit"
         
         #end add-point
         #(ver:22) --- end ---
         EXIT WHILE
      END IF
      
   END WHILE
 
   CALL cl_set_act_visible("accept,cancel", TRUE)
 
END FUNCTION
 
{</section>}
 
{<section id="afmp530.query" >}
#+ QBE資料查詢
PRIVATE FUNCTION afmp530_query()
   #add-point:query段define(客製用) name="query.define_customerization"
   
   #end add-point 
   DEFINE ls_wc      STRING
   DEFINE ls_return  STRING
   DEFINE ls_result  STRING 
   #add-point:query段define name="query.define"
   
   #end add-point 
    
   #add-point:cs段after_construct name="query.after_construct"
   
   #end add-point
        
   LET g_error_show = 1
   CALL afmp530_b_fill()
   LET l_ac = g_master_idx
   IF g_detail_cnt = 0 AND NOT INT_FLAG THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code   = -100 
      LET g_errparam.popup  = TRUE 
      CALL cl_err()
 
   END IF
   
   #add-point:cs段after_query name="query.cs_after_query"
   
   #end add-point
   
END FUNCTION
 
{</section>}
 
{<section id="afmp530.b_fill" >}
#+ 單身陣列填充
PRIVATE FUNCTION afmp530_b_fill()
   #add-point:b_fill段define(客製用) name="b_fill.define_customerization"
   
   #end add-point
   DEFINE ls_wc           STRING
   #add-point:b_fill段define name="b_fill.define"
  
   #end add-point
 
   LET g_wc = g_wc, cl_sql_auth_filter()   #(ver:21) add cl_sql_auth_filter()
 
   #add-point:b_fill段sql_before name="b_fill.sql_before"
   
   IF cl_null(g_wc) THEN 
      LET g_wc = "1=1"
   END IF
   LET g_glap008 = g_input.type 
   CASE 
      WHEN g_input.type = 'afmt535'     
         LET g_wc = cl_replace_str(g_wc,"ori_docno","fmmldocno")  #帳款單號
         LET g_wc = cl_replace_str(g_wc,"ori_docdt","fmmldocdt")  #帳款日期
         LET g_sql = "SELECT DISTINCT 'N',glapdocno,glapdocdt,glap007,glap008,glap010,glap011,glapstus ",
                     "  FROM glap_t,fmml_t ",
                     " WHERE glapent = ? ",
                     "   AND glapent = fmmlent AND glapld = fmml003 ",
                     "   AND glapld = '",g_input.glaald,"'",
                     "   AND glapstus NOT IN ('Y','S')    ",
                     "   AND fmml007 = glapdocno  AND fmml001 = '",g_input.site,"'",
                     "   AND ",g_wc
      WHEN g_input.type = 'afmt555'     
         LET g_wc = cl_replace_str(g_wc,"ori_docno","fmmqdocno")  #帳款單號
         LET g_wc = cl_replace_str(g_wc,"ori_docdt","fmmqdocdt")  #帳款日期
         LET g_sql = "SELECT DISTINCT 'N',glapdocno,glapdocdt,glap007,glap008,glap010,glap011,glapstus ",
                     "  FROM glap_t,fmmq_t ",
                     " WHERE glapent = ? ",
                     "   AND glapent = fmmqent AND glapld = fmmq001 ",
                     "   AND glapld = '",g_input.glaald,"'",
                     "   AND glapstus NOT IN ('Y','S')    ",
                     "   AND fmmq004 = glapdocno  AND fmmqsite = '",g_input.site,"'",
                     "   AND ",g_wc
                     
      WHEN g_input.type = 'afmt565'     
         LET g_wc = cl_replace_str(g_wc,"ori_docno","fmmudocno")  #帳款單號
         LET g_wc = cl_replace_str(g_wc,"ori_docdt","fmmudocdt")  #帳款日期
         LET g_sql = "SELECT DISTINCT 'N',glapdocno,glapdocdt,glap007,glap008,glap010,glap011,glapstus ",
                     "  FROM glap_t,fmmu_t ",
                     " WHERE glapent = ? ",
                     "   AND glapent = fmmuent AND glapld = fmmu001 ",
                     "   AND glapld = '",g_input.glaald,"'",
                     "   AND glapstus NOT IN ('Y','S')    ",
                     "   AND fmmu004 = glapdocno  AND fmmusite = '",g_input.site,"'",
                     "   AND ",g_wc
                     
      WHEN g_input.type = 'afmt570'     
         LET g_wc = cl_replace_str(g_wc,"ori_docno","fmnadocno")  #帳款單號
         LET g_wc = cl_replace_str(g_wc,"ori_docdt","fmnadocdt")  #帳款日期
         LET g_sql = "SELECT DISTINCT 'N',glapdocno,glapdocdt,glap007,glap008,glap010,glap011,glapstus ",
                     "  FROM glap_t,fmna_t ",
                     " WHERE glapent = ? ",
                     "   AND glapent = fmnaent AND glapld = fmna001 ",
                     "   AND glapld = '",g_input.glaald,"'",
                     "   AND glapstus NOT IN ('Y','S')    ",
                     "   AND fmna005 = glapdocno  AND fmnasite = '",g_input.site,"'",
                     "   AND ",g_wc
                     
      WHEN g_input.type = 'afmt585'     
         LET g_wc = cl_replace_str(g_wc,"ori_docno","fmmwdocno")  #帳款單號
         LET g_wc = cl_replace_str(g_wc,"ori_docdt","fmmwdocdt")  #帳款日期
         LET g_sql = "SELECT DISTINCT 'N',glapdocno,glapdocdt,glap007,glap008,glap010,glap011,glapstus ",
                     "  FROM glap_t,fmmw_t ",
                     " WHERE glapent = ? ",
                     "   AND glapent = fmmwent AND glapld = fmmw001 ",
                     "   AND glapld = '",g_input.glaald,"'",
                     "   AND glapstus NOT IN ('Y','S')    ",
                     "   AND fmmw004 = glapdocno  AND fmmwsite = '",g_input.site,"'",
                     "   AND ",g_wc
      WHEN g_input.type = 'afmt595'     
         LET g_wc = cl_replace_str(g_wc,"ori_docno","fmnedocno")  #帳款單號
         LET g_wc = cl_replace_str(g_wc,"ori_docdt","fmnedocdt")  #帳款日期
         LET g_sql = "SELECT DISTINCT 'N',glapdocno,glapdocdt,glap007,glap008,glap010,glap011,glapstus ",
                     "  FROM glap_t,fmne_t ",
                     " WHERE glapent = ? ",
                     "   AND glapent = fmneent AND glapld = fmne001 ",
                     "   AND glapld = '",g_input.glaald,"'",
                     "   AND glapstus NOT IN ('Y','S')    ",
                     "   AND fmne004 = glapdocno  AND fmnesite = '",g_input.site,"'",
                     "   AND ",g_wc
   END CASE

   #end add-point
 
   PREPARE afmp530_sel FROM g_sql
   DECLARE b_fill_curs CURSOR FOR afmp530_sel
   
   CALL g_detail_d.clear()
   #add-point:b_fill段其他頁簽清空 name="b_fill.clear"
   
   #end add-point
 
   LET g_cnt = l_ac
   LET l_ac = 1   
   ERROR "Searching!" 
 
   FOREACH b_fill_curs USING g_enterprise INTO 
   #add-point:b_fill段foreach_into name="b_fill.foreach_into"
   g_detail_d[l_ac].*
   #end add-point
   
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "FOREACH:" 
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = TRUE 
         CALL cl_err()
 
         EXIT FOREACH
      END IF
      
      #add-point:b_fill段資料填充 name="b_fill.foreach_iside"
     
      #end add-point
      
      CALL afmp530_detail_show()      
 
      LET l_ac = l_ac + 1
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
      
   END FOREACH
   LET g_error_show = 0
   
   #add-point:b_fill段資料填充(其他單身) name="b_fill.other_table"
   CALL g_detail_d.deleteElement(g_detail_d.getLength())
   #end add-point
    
   LET g_detail_cnt = l_ac - 1 
   DISPLAY g_detail_cnt TO FORMONLY.h_count
   LET l_ac = g_cnt
   LET g_cnt = 0
   
   CLOSE b_fill_curs
   FREE afmp530_sel
   
   LET l_ac = 1
   CALL afmp530_fetch()
   #add-point:b_fill段資料填充(其他單身) name="b_fill.after_b_fill"
 
   #end add-point
 
END FUNCTION
 
{</section>}
 
{<section id="afmp530.fetch" >}
#+ 單身陣列填充2
PRIVATE FUNCTION afmp530_fetch()
   #add-point:fetch段define(客製用) name="fetch.define_customerization"
   
   #end add-point
   DEFINE li_ac           LIKE type_t.num10
   #add-point:fetch段define name="fetch.define"
   
   #end add-point
   
   LET li_ac = l_ac 
   
   #add-point:單身填充後 name="fetch.after_fill"
   
   #end add-point 
   
   LET l_ac = li_ac
   
END FUNCTION
 
{</section>}
 
{<section id="afmp530.detail_show" >}
#+ 顯示相關資料
PRIVATE FUNCTION afmp530_detail_show()
   #add-point:show段define(客製用) name="detail_show.define_customerization"
   
   #end add-point
   #add-point:show段define name="detail_show.define"
   
   #end add-point
   
   #add-point:detail_show段 name="detail_show.detail_show"
   
   #end add-point
 
END FUNCTION
 
{</section>}
 
{<section id="afmp530.filter" >}
#+ filter過濾功能
PRIVATE FUNCTION afmp530_filter()
   #add-point:filter段define(客製用) name="filter.define_customerization"
   
   #end add-point    
   #add-point:filter段define name="filter.define"
   
   #end add-point
   
   DISPLAY ARRAY g_detail_d TO s_detail1.* ATTRIBUTE(COUNT=g_detail_cnt)
      ON UPDATE
 
   END DISPLAY
 
   LET l_ac = 1
   LET g_detail_cnt = 1
   #add-point:filter段define name="filter.detail_cnt"
   
   #end add-point    
 
   LET INT_FLAG = 0
 
   LET g_qryparam.state = 'c'
 
   LET g_wc_filter_t = g_wc_filter
   LET g_wc_t = g_wc
   
   LET g_wc = cl_replace_str(g_wc, g_wc_filter, '')
   
   CALL afmp530_b_fill()
   
END FUNCTION
 
{</section>}
 
{<section id="afmp530.filter_parser" >}
#+ filter欄位解析
PRIVATE FUNCTION afmp530_filter_parser(ps_field)
   #add-point:filter段define(客製用) name="filter_parser.define_customerization"
   
   #end add-point    
   DEFINE ps_field   STRING
   DEFINE ls_tmp     STRING
   DEFINE li_tmp     LIKE type_t.num10
   DEFINE li_tmp2    LIKE type_t.num10
   DEFINE ls_var     STRING
   #add-point:filter段define name="filter_parser.define"
   
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
 
{<section id="afmp530.filter_show" >}
#+ Browser標題欄位顯示搜尋條件
PRIVATE FUNCTION afmp530_filter_show(ps_field,ps_object)
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
   LET ls_condition = afmp530_filter_parser(ps_field)
   IF NOT cl_null(ls_condition) THEN
      LET ls_title = ls_title, '※', ls_condition, '※'
   END IF
 
   #將資料顯示回去
   CALL lnode_item.setAttribute("text",ls_title)
 
END FUNCTION
 
{</section>}
 
{<section id="afmp530.other_function" readonly="Y" >}
#add-point:自定義元件(Function) name="other.function"
# 創建臨時表
PRIVATE FUNCTION afmp530_create_tmp()
   DEFINE r_success       LIKE type_t.num5
   
   WHENEVER ERROR CONTINUE
   LET r_success = FALSE
   
   DROP TABLE afmp530_tmp;
   CREATE TEMP TABLE afmp530_tmp(
     sel            VARCHAR(1),
     glapld         VARCHAR(5),
     glapdocno      VARCHAR(20),
     glapdocdt      DATE,
     glap010        DECIMAL(20,6),
     glap011        DECIMAL(20,6),
     glapstus       VARCHAR(10),
     glap012        SMALLINT
   );
   
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "create" 
      LET g_errparam.code   = SQLCA.sqlcode 
      LET g_errparam.popup  = TRUE 
      CALL cl_err()
      
      RETURN r_success
   END IF
   
   LET r_success = TRUE
   RETURN r_success
END FUNCTION

################################################################################
# Descriptions...: 回復預設值
# Memo...........:
# Usage..........: CALL afmp530_qbeclear()
# Date & Author..: 2015/05/28 By 作者
# Modify.........:
################################################################################
PRIVATE FUNCTION afmp530_qbeclear()

   CLEAR FORM
   CALL g_detail_d.clear()
   INITIALIZE g_input.*    TO NULL
   INITIALIZE g_input_t.*  TO NULL     
   INITIALIZE g_qbe.*      TO NULL
   INITIALIZE g_wc         TO NULL
   LET g_input.type = 'afmt535'
   CALL s_aap_get_default_apcasite('','','')RETURNING g_sub_success,g_errno,g_input.site,
                                                      g_input.glaald,g_input.glaacomp
   #取得帳套關帳日期
   SELECT glaa013 INTO g_glaa013
     FROM glaa_t
    WHERE glaaent = g_enterprise
      AND glaald = g_input.glaald
     
   #取得帳務組織下所屬成員
   CALL s_fin_account_center_sons_query('3',g_input.site,g_today,'')
   CALL s_fin_account_center_ld_str() RETURNING g_wc_glaald
   CALL s_fin_get_wc_str(g_wc_glaald) RETURNING g_wc_glaald
   LET g_input.glaald_desc   = s_desc_get_ld_desc(g_input.glaald)
   LET g_input.glaacomp_desc = s_desc_get_department_desc(g_input.glaacomp)
   LET g_input.site_desc = s_desc_get_department_desc(g_input.site)

   DISPLAY BY NAME g_input.glaald,g_input.glaald_desc,g_input.glaacomp,g_input.glaacomp_desc,
                   g_input.type,g_input.site,g_input.site_desc




END FUNCTION

################################################################################
# Descriptions...: 執行還原
# Memo...........:
# Usage..........: CALL afmp530_process()
# Date & Author..: 2015/05/28 By Hans
# Modify.........:
################################################################################
PRIVATE FUNCTION afmp530_process()
DEFINE l_cnt         LIKE type_t.num5
DEFINE li_idx        LIKE type_t.num5
DEFINE l_i           LIKE type_t.num5
DEFINE l_docno       LIKE fmmw_t.fmmwdocno
DEFINE l_sql              STRING

   LET l_cnt = 0
   LET l_i = 0
   #清空顯示條
   DISPLAY '' ,0 TO stagenow,stagecomplete
   #總共有幾筆資料要跑
   FOR li_idx = 1 TO g_detail_d.getLength()
      IF g_detail_d[li_idx].sel = "Y" THEN
         LET l_cnt = l_cnt + 1
      END IF
   END FOR
   IF l_cnt = 0 THEN
      #未選擇資料
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'adb-00078'
      LET g_errparam.popup = TRUE
      CALL cl_err()
      RETURN
   END IF

   CALL cl_progress_bar_no_window(li_idx)
   #锁资料
   LET l_sql = "SELECT glapent,glapld,glapdocno FROM glap_t WHERE glapent = ? AND glapld = ? AND glapdocno = ? FOR UPDATE"
   LET l_sql = cl_sql_forupd(l_sql)                #轉換不同資料庫語法
   LET l_sql = cl_sql_add_mask(l_sql)              #遮蔽特定資料
   DECLARE afmp530_cl CURSOR FROM l_sql            # LOCK CURSOR
   
   CALL cl_err_collect_init()
   FOR li_idx = 1 TO g_detail_cnt
      IF g_detail_d[li_idx].sel = 'N' THEN
         CONTINUE FOR
      ELSE
         CALL s_transaction_begin()
         OPEN afmp530_cl USING g_enterprise,g_input.glaald,g_detail_d[li_idx].glapdocno
         IF STATUS THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.extend =g_detail_d[li_idx].glapdocno,"  OPEN afmp530_cl:"
            LET g_errparam.code   =  STATUS
            LET g_errparam.popup  = TRUE
            CALL cl_err()       
            CLOSE afmp530_cl
            CALL s_transaction_end('N','0')
            CONTINUE FOR
         END IF
         DELETE FROM glap_t  #刪除傳票
          WHERE glapent = g_enterprise
            AND glapld = g_input.glaald
            AND glapdocno = g_detail_d[li_idx].glapdocno    
         DELETE FROM glaq_t 
          WHERE glaqent = g_enterprise
            AND glaqld = g_input.glaald
            AND glaqdocno = g_detail_d[li_idx].glapdocno                          
         LET g_prog = 'aglt310'      
         CALL s_aooi200_fin_del_docno(g_input.glaald,g_detail_d[li_idx].glapdocno,g_detail_d[li_idx].glapdocdt)RETURNING g_sub_success      
         IF NOT g_sub_success THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = 'aap-00300'
            LET g_errparam.extend = ''
            LET g_errparam.popup = TRUE
            CALL cl_err()            
            CALL s_transaction_end('N',0)         
            CONTINUE FOR           
         ELSE
            LET g_prog = 'afmp530'   
            CALL afmp530_updtable(g_detail_d[li_idx].glapdocno)
            INITIALIZE g_errparam TO NULL            
            LET g_errparam.code = SQLCA.sqlcode
            LET g_errparam.extend = g_detail_d[li_idx].glapdocno
            LET g_errparam.code   = 'adz-00217'
            LET g_errparam.popup = TRUE
            CALL cl_err()             
            CALL s_transaction_end('Y','0')
            LET l_i = 1
         END IF
      END IF
   END FOR
   IF l_i = 0 THEN #執行失敗刪除0筆
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = ''
      LET g_errparam.code   = 'axc-00530'
      LET g_errparam.popup = TRUE
      CALL cl_err()    
   END IF  
   CALL cl_err_collect_show()  
   CALL afmp530_b_fill()

END FUNCTION

################################################################################
# Descriptions...: 更新來源資料
# Memo...........:
# Usage..........: CALL afmp530_updtable(p_glapdocno)
# Date & Author..: 2015/05/29 By Hans
# Modify.........:
################################################################################
PRIVATE FUNCTION afmp530_updtable(p_glapdocno)
DEFINE p_glapdocno LIKE glap_t.glapdocno
DEFINE l_docno    LIKE fmmw_t.fmmwdocno
DEFINE l_str      LIKE type_t.chr80
    
    LET l_docno = ''
    LET l_str =''
    CASE
      WHEN g_glap008 = 'afmt535'
         LET l_str = 'M20'               
      WHEN g_glap008 = 'afmt555'
         LET l_str = 'M30'
      WHEN g_glap008 = 'afmt570'
         LET l_str = 'M10'                    
      WHEN g_glap008 = 'afmt565'
         LET l_str = 'M40'
      WHEN g_glap008 = 'afmt585'
         LET l_str = 'M50'
      WHEN g_glap008 = 'afmt595'
         LET l_str = 'M60'
   END CASE
   
   CASE #更新月結傳票號碼給空
      WHEN g_glap008 = 'afmt535'      #投資購買
         SELECT fmmldocno INTO l_docno   #取得帳款單號
           FROM fmml_t 
          WHERE fmmlent =g_enterprise 
            AND fmml007 = p_glapdocno
         
         UPDATE fmml_t SET fmml007 = ''
          WHERE fmmlent = g_enterprise
            AND fmmldocno = l_docno
            
      WHEN g_glap008 = 'afmt555'      #投資購買
         SELECT fmmqdocno INTO l_docno   #取得帳款單號
           FROM fmmq_t 
          WHERE fmmqent =g_enterprise 
            AND fmmq004 = p_glapdocno
         
         UPDATE fmmq_t SET fmmq004 = ''
          WHERE fmmqent = g_enterprise
            AND fmmqdocno = l_docno 
            
      WHEN g_glap008 = 'afmt565'      #投資購買
         SELECT fmmudocno INTO l_docno   #取得帳款單號
           FROM fmmu_t 
          WHERE fmmuent =g_enterprise 
            AND fmmu004 = p_glapdocno
         
         UPDATE fmmu_t SET fmmu004 = ''
          WHERE fmmuent = g_enterprise
            AND fmmudocno = l_docno             
            
      WHEN g_glap008 = 'afmt570'      #重評價
         SELECT fmnadocno INTO l_docno   #取得帳款單號
           FROM fmna_t 
          WHERE fmnaent =g_enterprise 
            AND fmna005 = p_glapdocno
         
         UPDATE fmna_t SET fmna005 = ''
          WHERE fmnaent = g_enterprise
            AND fmnadocno = l_docno   
            
      WHEN g_glap008 = 'afmt585'      #投資收息              
         SELECT fmmwdocno INTO l_docno   #取得帳款單號
           FROM fmmw_t 
          WHERE fmmwent =g_enterprise 
            AND fmmw004 = p_glapdocno
       
         UPDATE fmmw_t SET fmmw004 = ''
          WHERE fmmwent = g_enterprise
            AND fmmwdocno = l_docno   
      
      WHEN g_glap008 = 'afmt585'      #投資收息              
         SELECT fmnedocno INTO l_docno   #取得帳款單號
           FROM fmne_t 
          WHERE fmneent =g_enterprise 
            AND fmne004 = p_glapdocno
       
         UPDATE fmne_t SET fmne004 = ''
          WHERE fmneent = g_enterprise
            AND fmnedocno = l_docno                 

   END CASE  
   #分錄底稿
   UPDATE glga_t SET glga007 = ''
    WHERE glgaent = g_enterprise AND glgald = g_input.glaald
      AND glgadocno = l_docno    AND glga100 = 'FM' 
      AND glga101 = l_str      
         
         
END FUNCTION

#end add-point
 
{</section>}
 
