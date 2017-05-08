#該程式未解開Section, 採用最新樣板產出!
{<section id="afmp520.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0004(2015-06-12 09:48:27), PR版次:0004(2016-10-24 09:35:14)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000042
#+ Filename...: afmp520
#+ Description: 拋轉傳票整批處理
#+ Creator....: 05016(2015-05-26 15:03:38)
#+ Modifier...: 05016 -SD/PR- 06814
 
{</section>}
 
{<section id="afmp520.global" >}
#應用 p02 樣板自動產生(Version:22)
#add-point:填寫註解說明 name="global.memo"
#+ Modifier...:   No.160318-00025#39 16/04/22 By pengxin 將重複內容的錯誤訊息置換為公用錯誤訊息(r.v)
#+ Modifier...:   No.161006-00005#24 16/10/24 By 06814   帳務中心(nmbssite)開窗改用q_ooef001_46()
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
 
   #end add-point
        wc               STRING
                     END RECORD
 
TYPE type_g_detail_d RECORD
#add-point:自定義模組變數(Module Variable)  #注意要在add-point內寫入END RECORD name="global.variable"
       sel           LIKE type_t.chr1,
       docno         LIKE fmmx_t.fmmxdocno,
       docdt         LIKE fmmw_t.fmmwdocdt,
       money         LIKE fmmx_t.fmmx101,
       money2        LIKE fmmx_t.fmmx101
END RECORD

TYPE type_g_input    RECORD
      nmbssite       LIKE nmbs_t.nmbssite,
      nmbssite_desc  LIKE type_t.chr80,
      nmbsld         LIKE nmbs_t.nmbsld,
      nmbsld_desc    LIKE type_t.chr80,
      glapdocno      LIKE glap_t.glapdocno,
      glapdocdt      LIKE glap_t.glapdocdt,
      l_comp         LIKE fmmw_t.fmmwcomp,
      comp_desc      LIKE type_t.chr80,
      glstr_no       LIKE fmmw_t.fmmwdocno,
      glend_no       LIKE fmmw_t.fmmwdocno,
      type           LIKE type_t.chr80
      END RECORD
TYPE type_g_qbe   RECORD
   datrange       LIKE type_t.dat,
   datdocno       LIKE type_t.chr500
              END RECORD
      
DEFINE g_input       type_g_input    #INPUT條件
DEFINE g_input_t     type_g_input    #備份INPUT條件
DEFINE g_qbe         type_g_qbe      #QBE條件
DEFINE g_glaa003     LIKE glaa_t.glaa003     #會計週期參照表
DEFINE g_glaa013     LIKE glaa_t.glaa013     #最後關帳日期
DEFINE g_glaa102     LIKE glaa_t.glaa102     #借貸不平衡處理方式
DEFINE g_glaa024     LIKE glaa_t.glaa024
DEFINE g_glaa121     LIKE glaa_t.glaa121
DEFINE g_glaa100     LIKE glaa_t.glaa100

DEFINE g_rec_b       LIKE type_t.num5
DEFINE g_rec_b2      LIKE type_t.num5
DEFINE g_detail_idx  LIKE type_t.num5
DEFINE g_detail_idx2 LIKE type_t.num5
DEFINE g_detail_idxb LIKE type_t.num5     
DEFINE g_glap008     LIKE glap_t.glap008
DEFINE g_wc_nmbsld   STRING

#end add-point
 
#add-point:自定義客戶專用模組變數(Module Variable) name="global.variable_customerization"

#end add-point
DEFINE g_detail_cnt         LIKE type_t.num10              #單身 總筆數(所有資料)
DEFINE g_detail_d  DYNAMIC ARRAY OF type_g_detail_d
 
#add-point:傳入參數說明 name="global.argv"

#end add-point
 
{</section>}
 
{<section id="afmp520.main" >}
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
      OPEN WINDOW w_afmp520 WITH FORM cl_ap_formpath("afm",g_code)
   
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
   
      #程式初始化
      CALL afmp520_init()   
 
      #進入選單 Menu (="N")
      CALL afmp520_ui_dialog() 
 
      #add-point:畫面關閉前 name="main.before_close"
      
      #end add-point
      #畫面關閉
      CLOSE WINDOW w_afmp520
   END IF 
   
   #add-point:作業離開前 name="main.exit"
   
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
END MAIN
 
{</section>}
 
{<section id="afmp520.init" >}
#+ 畫面資料初始化
PRIVATE FUNCTION afmp520_init()
   #add-point:init段define(客製用) name="init.define_customerization"
   
   #end add-point   
   #add-point:init段define name="init.define"
   
   #end add-point   
   
   LET g_error_show  = 1
   LET g_wc_filter   = " 1=1"
   LET g_wc_filter_t = " 1=1"
 
   #add-point:畫面資料初始化 name="init.init"
   CALL s_pre_voucher_cre_tmp_table() RETURNING g_sub_success  #啟用分錄底稿用
   CALL s_fin_create_account_center_tmp()     #展組織下階成員所需之暫存檔 
   CALL s_fin_continue_no_tmp()   
   CALL cl_set_combo_scc('type','9986')
   #end add-point
   
END FUNCTION
 
{</section>}
 
{<section id="afmp520.ui_dialog" >}
#+ 選單功能實際執行處
PRIVATE FUNCTION afmp520_ui_dialog()
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
   CALL afmp520_qbeclear()
   
   #end add-point
   
   WHILE TRUE
 
      IF g_action_choice = "logistics" THEN
         #清除畫面及相關資料
         CLEAR FORM
         CALL g_detail_d.clear()
         LET g_wc  = ' 1=2'
         LET g_wc2 = ' 1=1'
         LET g_action_choice = ""
         CALL afmp520_init()
      END IF
 
      DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
         #add-point:ui_dialog段construct name="ui_dialog.more_construct"
         
         #end add-point
         #add-point:ui_dialog段input name="ui_dialog.more_input"
         INPUT g_input.nmbssite,g_input.nmbsld,g_input.type,g_input.glapdocno,g_input.glapdocdt
          FROM nmbssite,nmbsld,type,glapdocno,glapdocdt
               ATTRIBUTE(WITHOUT DEFAULTS)
               
            AFTER FIELD nmbssite
               LET g_input.nmbssite_desc = ''
               IF NOT cl_null(g_input.nmbssite) THEN
                  CALL s_fin_account_center_sons_query('3',g_input.nmbssite,g_today,'')
                  CALL s_fin_account_center_with_ld_chk(g_input.nmbssite,g_input.nmbsld,g_user,'3','N','',g_today) RETURNING g_sub_success,g_errno
                  IF NOT g_sub_success THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = g_errno
                     LET g_errparam.extend = ''
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                     LET g_input.nmbssite = ''
                     LET g_input.nmbsld = ''
                     LET g_input.nmbsld_desc = ''
                     DISPLAY BY NAME g_input.nmbsld_desc
                     CALL s_desc_get_department_desc(g_input.nmbssite) RETURNING g_input.nmbssite_desc
                     DISPLAY BY NAME g_input.nmbssite_desc
                     NEXT FIELD CURRENT
                  END IF
               END IF
               CALL s_fin_account_center_sons_query('3',g_input.nmbssite,g_today,'')
               CALL s_fin_account_center_ld_str() RETURNING g_wc_nmbsld
               CALL s_fin_get_wc_str(g_wc_nmbsld) RETURNING g_wc_nmbsld
               CALL s_desc_get_department_desc(g_input.nmbssite) RETURNING g_input.nmbssite_desc
               DISPLAY BY NAME g_input.nmbssite_desc             
               
            AFTER FIELD nmbsld
               LET g_input.nmbsld_desc = ''
               LET g_input.comp_desc   = ''
               LET g_input.l_comp      = ''
               IF NOT cl_null(g_input.nmbsld) THEN
                  CALL s_fin_account_center_with_ld_chk(g_input.nmbssite,g_input.nmbsld,g_user,'3','N','',g_today) RETURNING g_sub_success,g_errno
                  IF NOT g_sub_success THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = g_errno
                     LET g_errparam.extend = ''
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                     LET g_input.nmbsld = ''
                     LET g_input.nmbsld_desc = ''
                     DISPLAY BY NAME g_input.nmbsld_desc
                     NEXT FIELD CURRENT
                  END IF
                  CALL s_fin_ld_carry(g_input.nmbsld,'') RETURNING g_sub_success,g_input.nmbsld,g_input.l_comp,g_errno
                  IF NOT g_sub_success THEN
                      INITIALIZE g_errparam TO NULL
                      LET g_errparam.code = g_errno
                      LET g_errparam.extend = g_input.nmbsld
                      LET g_errparam.popup = TRUE
                      CALL cl_err()
                      LET g_input.nmbsld = ''
                      LET g_input.nmbsld_desc = ''
                      DISPLAY BY NAME g_input.nmbsld_desc
                  END IF
                  CALL afmp520_set_ld_info(g_input.nmbsld)
                  IF g_input.nmbsld <> g_input_t.nmbsld THEN
                     DELETE FROM s_fin_tmp_conti_no
                  END IF
                  LET g_input_t.nmbsld = g_input.nmbsld
               END IF
               LET g_input.nmbsld_desc   = s_desc_get_ld_desc(g_input.nmbsld)
               LET g_input.comp_desc = s_desc_get_department_desc(g_input.l_comp)
               DISPLAY BY NAME g_input.nmbsld,g_input.nmbsld_desc,g_input.l_comp,g_input.nmbsld_desc,g_input.comp_desc
               
             AFTER FIELD glapdocno
               IF NOT cl_null(g_input.glapdocno) THEN
                  INITIALIZE g_chkparam.* TO NULL
                  LET g_chkparam.arg1 = g_glaa024
                  LET g_chkparam.arg2 = g_input.glapdocno
                  #160318-00025#39  2016/04/22  by pengxin  add(S)
                  LET g_errshow = TRUE #是否開窗 
                  LET g_chkparam.err_str[1] = "agl-00189:sub-01302|aooi200|",cl_get_progname("aooi200",g_lang,"2"),"|:EXEPROGaooi200"
                  #160318-00025#39  2016/04/22  by pengxin  add(E)
                  IF cl_chk_exist("v_ooba002_07") THEN
                     IF g_input_t.glapdocno <> g_input.glapdocno THEN
                        DELETE FROM s_fin_tmp_conti_no
                     END IF
                     LET g_input_t.glapdocno = g_input.glapdocno
                  ELSE
                     LET g_input.glapdocno = ''
                     DELETE FROM s_fin_tmp_conti_no
                     LET g_input_t.glapdocno = g_input.glapdocno
                     NEXT FIELD CURRENT
                  END IF
               END IF
            
            AFTER FIELD glapdocdt
               IF g_input_t.glapdocdt <> g_input.glapdocdt THEN
                  DELETE FROM s_fin_tmp_conti_no
               END IF
               LET g_input_t.glapdocdt = g_input.glapdocdt
               SELECT glaa013 INTO g_glaa013
                 FROM glaa_t
                WHERE glaaent = g_enterprise AND glaald = g_input.nmbsld

               IF NOT cl_null(g_input.glapdocdt) AND g_input.glapdocdt <= g_glaa013 THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'aap-00077'
                  LET g_errparam.extend =  ''
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
                  LET g_input.glapdocdt = ''
                  LET g_input_t.glapdocdt = g_input.glapdocdt
                  CONTINUE DIALOG
               END IF
               
               
            ON ACTION cont_no
               IF cl_null(g_input.nmbsld)  THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'aap-00332'
                  LET g_errparam.extend = s_fin_get_colname('','nmbsld')
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
                  CONTINUE DIALOG
               END IF
               IF cl_null(g_input.glapdocno) THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'aap-00332'
                  LET g_errparam.extend = s_fin_get_colname('','glapdocno')
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
                  CONTINUE DIALOG
               END IF
               IF cl_null(g_input.glapdocdt) THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'aap-00331'
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
                  CONTINUE DIALOG
               END IF   
               
               CALL s_transaction_begin()
               CALL s_fin_continue_no_input(g_input.nmbsld,'',g_input.glapdocno,g_input.glapdocdt,'3')
               CALL s_transaction_end('Y','Y')
               
            ON ACTION controlp INFIELD nmbsld
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'i'
               LET g_qryparam.reqry = FALSE
               LET g_qryparam.default1 = g_input.nmbsld                     #給予default值
               LET g_qryparam.where = " (glaa008 = 'Y' OR glaa014 = 'Y') "  #glaa008(平行記帳)/glaa014(主帳套)
               LET g_qryparam.arg1 = g_user                                 #人員權限
               LET g_qryparam.arg2 = g_dept                                 #部門權限
               LET g_qryparam.where = " glaald IN ",g_wc_nmbsld
               CALL q_authorised_ld()                                       #呼叫開窗
               LET g_input.nmbsld = g_qryparam.return1                      #將開窗取得的值回傳到變數
               CALL s_fin_ld_carry(g_input.nmbsld,'') RETURNING g_success,g_input.nmbsld,g_input.l_comp,g_errno
               LET g_input.nmbsld_desc   = s_desc_get_ld_desc(g_input.nmbsld)
               LET g_input.comp_desc = s_desc_get_department_desc(g_input.l_comp)
               DISPLAY BY NAME g_input.nmbsld,g_input.nmbsld_desc,g_input.l_comp,g_input.comp_desc
               NEXT FIELD nmbsld                                            #返回原欄位
            
           ON ACTION controlp INFIELD nmbssite
             INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'i'
               LET g_qryparam.reqry = FALSE
               LET g_qryparam.default1 = g_input.nmbssite
               #161006-00005#24 20161024 mark by beckxie---S
               #LET g_qryparam.where = " ooef204 = 'Y' "  #資金組織
               #CALL q_ooef001()
               #161006-00005#24 20161024 mark by beckxie---E
               CALL q_ooef001_46()                        #161006-00005#24 20161024 add by beckxie
               LET g_input.nmbssite = g_qryparam.return1
               CALL s_desc_get_department_desc(g_input.nmbssite) RETURNING g_input.nmbssite_desc
               DISPLAY BY NAME g_input.nmbssite,g_input.nmbssite_desc
               NEXT FIELD nmbssite

            ON ACTION controlp INFIELD glapdocno
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'i'
               LET g_qryparam.reqry = FALSE
               LET g_qryparam.default1 = g_input.glapdocno  #給予default值
               LET g_qryparam.arg1 = g_glaa024
               LET g_qryparam.arg2 = 'aglt310'
               CALL q_ooba002_1()                            #呼叫開窗
               LET g_input.glapdocno = g_qryparam.return1   #將開窗取得的值回傳到變數
               DISPLAY g_input.glapdocno TO glapdocno       #顯示到畫面上
               NEXT FIELD glapdocno                          #返回原欄位

            AFTER INPUT
               
               
         END INPUT
          
         CONSTRUCT BY NAME g_wc ON datrange,docnorange
         
            BEFORE CONSTRUCT
               CALL cl_qbe_init()
            
            ON ACTION controlp INFIELD pplrange
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c'
               LET g_qryparam.reqry = FALSE
               CALL q_ooag001()                       #呼叫開窗
               DISPLAY g_qryparam.return1 TO pplrange  #顯示到畫面上  
               NEXT FIELD pplrange                     #返回原欄位
            
            ON ACTION controlp INFIELD docnorange
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c'
               LET g_qryparam.reqry = FALSE
               CASE
                  WHEN g_input.type = 'afmt535'
                     LET g_qryparam.where ="     fmmlstus = 'Y' AND fmml007 IS NULL ",
                                           " AND fmml001 = '",g_input.nmbssite,"'   ",
                                           " AND fmml003 = '",g_input.nmbsld,"'     "
                      CALL q_fmmldocno() 
                  WHEN g_input.type = 'afmt555'
                     LET g_qryparam.where = "     fmmqstus ='Y' AND fmmq004 IS NULL  ", 
                                            " AND fmmqsite = '",g_input.nmbssite,"'  ",
                                            " AND fmmq001  = '",g_input.nmbsld,"'    "                       
                     CALL q_fmmqdocno()                           
                  WHEN g_input.type = 'afmt565'
                     LET g_qryparam.where = "     fmmustus ='Y' AND fmmu004 IS NULL   ", 
                                            " AND fmmusite = '",g_input.nmbssite,"'   ",
                                           "  AND fmmu001  = '",g_input.nmbsld,"'     " 
                     CALL q_fmmudocno()                                                  
                  WHEN g_input.type = 'afmt570' 
                     LET g_qryparam.where = "     fmnastus ='Y' AND fmna005 IS NULL   ",
                                            " AND fmnasite = '",g_input.nmbssite,"'   ",
                                            " AND fmna001  = '",g_input.nmbsld,"'     "                     
                     CALL q_fmnadocno()                      
                  WHEN g_input.type = 'afmt585'
                     LET g_qryparam.where = "     fmmwstus ='Y' AND fmmw004 IS NULL   ",
                                            " AND fmmwsite = '",g_input.nmbssite,"'   ",
                                            " AND fmmw001  = '",g_input.nmbsld,"'     "
                     CALL q_fmmwdocno()                        
                  WHEN g_input.type = 'afmt595'
                     LET g_qryparam.where = "     fmnestus ='Y' AND fmne004 IS NULL   ", 
                                            " AND fmnesite = '",g_input.nmbssite,"'   ",
                                            " AND fmne001  = '",g_input.nmbsld,"'     "                     
                     CALL q_fmnedocno()                                      
               END CASE
               
               DISPLAY g_qryparam.return1 TO docnorange  #顯示到畫面上  
               NEXT FIELD docnorange  




            AFTER CONSTRUCT
         END CONSTRUCT


         #end add-point
         #add-point:ui_dialog段自定義display array name="ui_dialog.more_displayarray"
         INPUT ARRAY g_detail_d FROM s_detail1.*
             ATTRIBUTE(COUNT = g_detail_cnt,MAXCOUNT = g_max_rec,WITHOUT DEFAULTS,
                       INSERT ROW = FALSE,
                       DELETE ROW = FALSE,
                       APPEND ROW = FALSE)
            BEFORE ROW
               LET l_ac = ARR_CURR()
               DISPLAY l_ac TO FORMONLY.h_index
         
         ON CHANGE sel
               CALL afmp520_chk_date(g_detail_d[l_ac].docdt) RETURNING g_sub_success,g_errno
               IF NOT g_sub_success THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = g_errno
                  LET g_errparam.extend = g_detail_d[l_ac].docno
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
                  LET g_detail_d[l_ac].sel = 'N'
               END IF
               IF g_input.type = 'afmt535' THEN
                  IF NOT  s_afmt535_do_voucher_chk(g_detail_d[l_ac].docno,'') THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = 'afm-00132'
                     LET g_errparam.extend = g_detail_d[l_ac].docno
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                     LET g_detail_d[l_ac].sel = 'N'              
                   END IF 
                END IF
         END INPUT
         
               
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
               CALL afmp520_chk_date(g_detail_d[li_idx].docdt) RETURNING g_sub_success,g_errno
               IF NOT g_sub_success THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = g_errno
                  LET g_errparam.extend = g_detail_d[li_idx].docno
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
                  LET g_detail_d[li_idx].sel = 'N'
                  CONTINUE FOR
               END IF
               IF g_input.type = 'afmt535' THEN
                  IF NOT s_afmt535_do_voucher_chk(g_detail_d[li_idx].docno,'') THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = 'afm-00132'
                     LET g_errparam.extend = g_detail_d[li_idx].docno
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                     LET g_detail_d[li_idx].sel = 'N'  
                     CONTINUE FOR                  
                  END IF 
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
            CALL afmp520_filter()
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
            LET g_input.glstr_no = '' 
            LET g_input.glend_no = '' 
            DISPLAY BY NAME g_input.glstr_no,g_input.glend_no
            #end add-point
            CALL afmp520_query()
             
         # 條件清除
         ON ACTION qbeclear
            #add-point:ui_dialog段 name="ui_dialog.qbeclear"
            CALL afmp520_qbeclear()
            #end add-point
 
         # 重新整理
         ON ACTION datarefresh
            LET g_error_show = 1
            #add-point:ui_dialog段datarefresh name="ui_dialog.datarefresh"
            
            #end add-point
            CALL afmp520_b_fill()
 
         #add-point:ui_dialog段action name="ui_dialog.more_action"
         ON ACTION batch_execute
            IF cl_null(g_input.glapdocno) THEN CONTINUE DIALOG END IF
            IF cl_null(g_input.glapdocdt) THEN CONTINUE DIALOG END IF             
            CALL afmp520_process()
            CALL afmp520_b_fill()
         
         
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
 
{<section id="afmp520.query" >}
#+ QBE資料查詢
PRIVATE FUNCTION afmp520_query()
   #add-point:query段define(客製用) name="query.define_customerization"
   
   #end add-point 
   DEFINE ls_wc      STRING
   DEFINE ls_return  STRING
   DEFINE ls_result  STRING 
   #add-point:query段define name="query.define"
   
   #end add-point 
    
   #add-point:cs段after_construct name="query.after_construct"
   IF cl_null(g_wc) THEN
      LET g_wc = " 1=1"
   END IF
   #end add-point
        
   LET g_error_show = 1
   CALL afmp520_b_fill()
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
 
{<section id="afmp520.b_fill" >}
#+ 單身陣列填充
PRIVATE FUNCTION afmp520_b_fill()
   #add-point:b_fill段define(客製用) name="b_fill.define_customerization"
   
   #end add-point
   DEFINE ls_wc           STRING
   #add-point:b_fill段define name="b_fill.define"
   
   #end add-point
 
   LET g_wc = g_wc, cl_sql_auth_filter()   #(ver:21) add cl_sql_auth_filter()
 
   #add-point:b_fill段sql_before name="b_fill.sql_before"
   LET g_glap008 = g_input.type
   CASE   
      WHEN g_input.type = 'afmt535'
         LET g_wc = cl_replace_str(g_wc,"datrange","fmmldocdt")   #日期
         LET g_wc = cl_replace_str(g_wc,"docnorange","fmmldocno")   #帳款單號
         LET g_sql = " SELECT 'N',fmmldocno,fmmldocdt,sum(fmmm008),sum(fmmm010)  ",
                     "   FROM fmml_t,fmmm_t                                      ",
                     "  WHERE fmmlent = fmmment AND fmmlent = ?                  ",
                     "    AND fmmldocno = fmmm001 AND fmml007 IS NULL            ",
                     "    AND fmml001 = '",g_input.nmbssite,"'                   ",
                     "    AND fmml003  = '",g_input.nmbsld,"'                    ",                  
                     "    AND fmmlstus = 'Y'                                     ",
                     "    AND ", g_wc ,
                     "  GROUP BY fmmldocno,fmmldocdt                             "   
                       
      WHEN g_input.type = 'afmt555'
         LET g_wc = cl_replace_str(g_wc,"datrange","fmmqdocdt")   #日期
         LET g_wc = cl_replace_str(g_wc,"docnorange","fmmqdocno") #帳款單號
         LET g_sql = " SELECT 'N',fmmqdocno,fmmqdocdt,sum(fmmr004),sum(fmmr006) ",
                     "   FROM fmmq_t,fmmr_t                                     ",
                     "  WHERE fmmqent = fmmrent AND fmmqent = ?                 ",
                     "    AND fmmqdocno = fmmrdocno AND fmmq004 IS NULL         ",
                     "    AND fmmqsite = '",g_input.nmbssite,"'                 ",
                     "    AND fmmq001  = '",g_input.nmbsld,"'                   ",                  
                     "    AND fmmqstus = 'Y'                                    ",
                     "    AND ",  g_wc ,                                         
                     "  GROUP BY fmmqdocno,fmmqdocdt                            "  
                       
     WHEN g_input.type = 'afmt565'
        LET g_wc = cl_replace_str(g_wc,"datrange","fmmudocdt")   #日期
        LET g_wc = cl_replace_str(g_wc,"docnorange","fmmudocno") #帳款單號
        LET g_sql = " SELECT 'N',fmmudocno,fmmudocdt,sum(fmng005),sum(fmng009) ",
                    "   FROM fmmu_t,fmng_t                                     ",
                    "  WHERE fmmuent = fmngent AND fmmuent = ?                 ",
                    "    AND fmmudocno = fmngdocno AND fmmu004 IS NULL         ",
                    "    AND fmmusite = '",g_input.nmbssite,"'                 ",
                    "    AND fmmu001  = '",g_input.nmbsld,"'                   ",                  
                    "    AND fmmustus = 'Y'                                    ",
                    "    AND ",  g_wc ,                                         
                    "  GROUP BY fmmudocno,fmmudocdt                            "  
       
     WHEN g_input.type = 'afmt570'
        LET g_wc = cl_replace_str(g_wc,"datrange","fmnadocdt")   #日期
        LET g_wc = cl_replace_str(g_wc,"docnorange","fmnadocno") #帳款單號
        LET g_sql = " SELECT 'N',fmnadocno,fmnadocdt,sum(fmnb103),sum(fmnb113)  ",
                    "   FROM fmna_t,fmnb_t                                      ",
                    "  WHERE fmnaent = fmnbent AND fmnbent = ?                  ",
                    "    AND fmnadocno = fmnbdocno AND fmna005 IS NULL          ",
                    "    AND fmnasite = '",g_input.nmbssite,"'                  ",
                    "    AND fmna001  = '",g_input.nmbsld,"'                    ",                    
                    "    AND fmnastus = 'Y'                                     ",
                    "    AND ",  g_wc ,
                    " GROUP BY fmnadocno,fmnadocdt                              "
                     
                       
     WHEN g_input.type = 'afmt585'
        LET g_wc = cl_replace_str(g_wc,"datrange","fmmwdocdt")   #日期
        LET g_wc = cl_replace_str(g_wc,"docnorange","fmmwdocno") #帳款單號
        LET g_sql = " SELECT 'N',fmmwdocno,fmmwdocdt,sum(fmmx101),sum(fmmx112) ",
                    "   FROM fmmw_t,fmmx_t                                      ",
                    "  WHERE fmmwent = fmmxent AND fmmwent = ?                  ",
                    "    AND fmmwdocno = fmmxdocno AND fmmw004 IS NULL          ",
                    "    AND fmmwsite = '",g_input.nmbssite,"'                  ",
                    "    AND fmmw001  = '",g_input.nmbsld,"'                    ",                     
                    "    AND fmmwstus = 'Y'                                     ",
                    "    AND ",  g_wc ,
                    " GROUP BY fmmwdocno,fmmwdocdt                              "
                    
       WHEN g_input.type = 'afmt595'
          LET g_wc = cl_replace_str(g_wc,"datrange","fmnedocdt")   #日期
          LET g_wc = cl_replace_str(g_wc,"docnorange","fmnedocno") #帳款單號
          LET g_sql = " SELECT 'N',fmnedocno,fmnedocdt,sum(fmmx101),sum(fmmx112)  ",
                      "   FROM fmne_t,fmmx_t                                      ",
                      "  WHERE fmneent = fmmxent AND fmneent = ?                  ",
                      "    AND fmnedocno = fmmxdocno AND fmne004 IS NULL          ",
                      "    AND fmnesite = '",g_input.nmbssite,"'                  ",
                      "    AND fmne001  = '",g_input.nmbsld,"'                    ",                    
                      "    AND fmnestus = 'Y'                                     ",
                      "    AND ",  g_wc ,
                      " GROUP BY fmnedocno,fmnedocdt                              "                         
   END CASE 
              
       
   #end add-point
 
   PREPARE afmp520_sel FROM g_sql
   DECLARE b_fill_curs CURSOR FOR afmp520_sel
   
   CALL g_detail_d.clear()
   #add-point:b_fill段其他頁簽清空 name="b_fill.clear"
   CALL g_detail_d.clear()
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
      
      CALL afmp520_detail_show()      
 
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
   ERROR ""
   CALL g_detail_d.deleteElement(g_detail_d.getLength())
   #end add-point
    
   LET g_detail_cnt = l_ac - 1 
   DISPLAY g_detail_cnt TO FORMONLY.h_count
   LET l_ac = g_cnt
   LET g_cnt = 0
   
   CLOSE b_fill_curs
   FREE afmp520_sel
   
   LET l_ac = 1
   CALL afmp520_fetch()
   #add-point:b_fill段資料填充(其他單身) name="b_fill.after_b_fill"
   DISPLAY l_ac TO FORMONLY.h_index
   #end add-point
 
END FUNCTION
 
{</section>}
 
{<section id="afmp520.fetch" >}
#+ 單身陣列填充2
PRIVATE FUNCTION afmp520_fetch()
   #add-point:fetch段define(客製用) name="fetch.define_customerization"
   
   #end add-point
   DEFINE li_ac           LIKE type_t.num10
   #add-point:fetch段define name="fetch.define"
   
   #end add-point
   
   LET li_ac = l_ac 
   
   #add-point:單身填充後 name="fetch.after_fill"
   IF cl_null(g_detail_idx) THEN LET g_detail_idx = g_detail_idxb END IF
   IF g_detail_idx = 0 OR cl_null(g_detail_idx) THEN
      LET g_detail_idx = 1
   END IF
   #end add-point 
   
   LET l_ac = li_ac
   
END FUNCTION
 
{</section>}
 
{<section id="afmp520.detail_show" >}
#+ 顯示相關資料
PRIVATE FUNCTION afmp520_detail_show()
   #add-point:show段define(客製用) name="detail_show.define_customerization"
   
   #end add-point
   #add-point:show段define name="detail_show.define"
   
   #end add-point
   
   #add-point:detail_show段 name="detail_show.detail_show"
   
   #end add-point
 
END FUNCTION
 
{</section>}
 
{<section id="afmp520.filter" >}
#+ filter過濾功能
PRIVATE FUNCTION afmp520_filter()
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
   
   CALL afmp520_b_fill()
   
END FUNCTION
 
{</section>}
 
{<section id="afmp520.filter_parser" >}
#+ filter欄位解析
PRIVATE FUNCTION afmp520_filter_parser(ps_field)
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
 
{<section id="afmp520.filter_show" >}
#+ Browser標題欄位顯示搜尋條件
PRIVATE FUNCTION afmp520_filter_show(ps_field,ps_object)
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
   LET ls_condition = afmp520_filter_parser(ps_field)
   IF NOT cl_null(ls_condition) THEN
      LET ls_title = ls_title, '※', ls_condition, '※'
   END IF
 
   #將資料顯示回去
   CALL lnode_item.setAttribute("text",ls_title)
 
END FUNCTION
 
{</section>}
 
{<section id="afmp520.other_function" readonly="Y" >}
#add-point:自定義元件(Function) name="other.function"

################################################################################
# Descriptions...: 傳票補號
# Memo...........:
# Usage..........: CALL afmp520_set_ld_info(p_ld)
# Date & Author..: 2015/05/27 By Hans
# Modify.........:
################################################################################
PRIVATE FUNCTION afmp520_set_ld_info(p_ld)
DEFINE p_ld          LIKE glaa_t.glaald
    CALL s_ld_sel_glaa(p_ld,'glaa102|glaacomp|glaa121|glaa024|glaa100|glaa003')
                       RETURNING g_sub_success,
                                 g_glaa102,g_input.l_comp,g_glaa121,g_glaa024,
                                 g_glaa100,g_glaa003
                                    
   SELECT glaa013 INTO g_glaa013
     FROM glaa_t
    WHERE glaaent = g_enterprise AND glaald = p_ld


   IF g_glaa100 = 'Y' THEN
     CALL cl_set_comp_visible('cont_no',FALSE)
   ELSE
     CALL cl_set_comp_visible('cont_no',TRUE)
   END IF
END FUNCTION

################################################################################
# Descriptions...: 回復預設值
# Memo...........:
# Usage..........: CALL afmp520_qbeclear()
# Date & Author..: 2015/05/27 By Hans
# Modify.........:
################################################################################
PRIVATE FUNCTION afmp520_qbeclear()
   
   CLEAR FORM
   CALL g_detail_d.clear()
   INITIALIZE g_input.*    TO NULL
   INITIALIZE g_input_t.*  TO NULL     
   INITIALIZE g_qbe.*      TO NULL
   INITIALIZE g_wc         TO NULL
   LET g_input.type = 'afmt535'
   LET g_input.glapdocdt = g_today
   CALL s_aap_get_default_apcasite('','','')RETURNING g_sub_success,g_errno,g_input.nmbssite,
                                                       g_input.nmbsld,g_input.l_comp
     
   #取得帳務組織下所屬成員
   CALL s_fin_account_center_sons_query('3',g_input.nmbssite,g_today,'')
   CALL s_fin_account_center_ld_str() RETURNING g_wc_nmbsld
   CALL s_fin_get_wc_str(g_wc_nmbsld) RETURNING g_wc_nmbsld
   CALL afmp520_set_ld_info(g_input.nmbsld)
   LET g_input.nmbsld_desc   = s_desc_get_ld_desc(g_input.nmbsld)
   LET g_input.comp_desc = s_desc_get_department_desc(g_input.l_comp)
   LET g_input.nmbssite_desc = s_desc_get_department_desc(g_input.nmbssite)

   DISPLAY BY NAME g_input.nmbsld,g_input.nmbsld_desc,g_input.l_comp,g_input.comp_desc,g_input.type,g_input.nmbssite,
                   g_input.glapdocdt,g_input.nmbssite_desc
   
   LET g_input_t.* = g_input.*
   
   
   
   
END FUNCTION

################################################################################
# Descriptions...: 檢查傳票日期
# Memo...........:
# Usage..........: CALL afmp520__chk_date()
# Date & Author..: 2015/05/27 By Hans
# Modify.........:
################################################################################
PRIVATE FUNCTION afmp520_chk_date(p_docdt)
DEFINE p_docdt         LIKE apca_t.apcadocdt
DEFINE l_year          LIKE type_t.num5
DEFINE l_month         LIKE type_t.num5
DEFINE l_pdate_s       LIKE glav_t.glav004   #當期起始日
DEFINE l_pdate_e       LIKE glav_t.glav004   #當期截止日
DEFINE l_glav002       LIKE glav_t.glav002
DEFINE l_glav005       LIKE glav_t.glav005
DEFINE l_glav006       LIKE glav_t.glav006
DEFINE l_glav007       LIKE glav_t.glav007
DEFINE l_wdate         LIKE glav_t.glav004
DEFINE r_success       LIKE type_t.num5
DEFINE r_errno         LIKE type_t.chr100

   LET r_success = TRUE
   
   #判斷傳票日期有值否，有值用此來推算出當期會計週期起始日，單據的立帳日必須在這區間內
   IF NOT cl_null(g_input.glapdocdt) THEN
      #取得會計週期參照表
      LET l_year = YEAR(g_input.glapdocdt)
      LET l_month = MONTH(g_input.glapdocdt)
      #取得會計當期起始日
      CALL s_get_accdate(g_glaa003,'',l_year,l_month)
            RETURNING g_sub_success,g_errno,l_glav002,l_glav005,l_wdate,l_wdate,
                      l_glav006,l_pdate_s,l_pdate_e,l_glav007,l_wdate,l_wdate
      IF NOT cl_null(l_pdate_s) AND NOT cl_null(l_pdate_e) THEN
         IF p_docdt < l_pdate_s OR p_docdt > l_pdate_e THEN
            LET r_errno = 'aap-00340'
            LET r_success = FALSE
         END IF
      END IF
   END IF

   #判斷立帳日期>關帳日
   IF NOT cl_null(g_glaa013) THEN
      IF p_docdt <= g_glaa013 THEN
         LET r_errno = 'aap-00341'
         LET r_success = FALSE
      END IF
   END IF

   RETURN r_success,r_errno





END FUNCTION

################################################################################
# Descriptions...: 執行拋轉傳票
# Memo...........:
# Usage..........: CALLafmp520_process()
# Date & Author..: 2015/05/27 By Hans
# Modify.........:
################################################################################
PRIVATE FUNCTION afmp520_process()
DEFINE r_start_no    LIKE glap_t.glapdocno
DEFINE r_end_no      LIKE glap_t.glapdocno
DEFINE l_str         LIKE type_t.chr30
DEFINE l_cnt         LIKE type_t.num5
DEFINE li_idx        LIKE type_t.num5
DEFINE l_i           LIKE type_t.num5
DEFINE l_wc        STRING
   
   LET l_str = ''
   LET l_cnt = 0
   LET l_i = 0
   LET g_input.glstr_no = ''
   LET g_input.glend_no = ''
   DISPLAY BY NAME g_input.glstr_no,g_input.glend_no   
   
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
   
   
   CALL cl_err_collect_init() 
   FOR li_idx = 1 TO g_detail_cnt     
      IF g_detail_d[li_idx].sel = 'N' THEN
         CONTINUE FOR
      ELSE          
         IF cl_null(g_input.glapdocdt) AND g_detail_d[li_idx].docdt < = g_glaa013 THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = 'aap-00077'
            LET g_errparam.extend = g_detail_d[li_idx].docno                                  
            LET g_errparam.popup = TRUE
            LET g_errparam.coll_vals[1]  = g_detail_d[li_idx].docno 
            CALL cl_err()
            LET g_detail_d[li_idx].sel = 'N'         
            CONTINUE FOR    
         END IF            
         CALL s_transaction_begin()         
         IF g_glaa121 = 'Y' THEN
            LET l_wc =" glgbdocno = '",g_detail_d[li_idx].docno,"' "                   
            CALL s_pre_voucher_ins_glap('FM',l_str,g_input.nmbsld,g_input.glapdocdt,g_input.glapdocno,'1',l_wc)
                RETURNING g_sub_success,r_start_no,r_end_no
         ELSE
            CASE
               WHEN g_glap008 = 'afmt535'
                  LET l_wc =" fmmldocno = '",g_detail_d[li_idx].docno,"' "
                  CALL s_voucher_gen_fm('8',g_input.nmbsld,g_input.glapdocdt,g_input.glapdocno,'0',l_wc,'N','afmt535')
                      RETURNING g_sub_success,r_start_no,r_end_no  
               WHEN g_glap008 = 'afmt555'
                  LET l_wc =" fmmqdocno = '",g_detail_d[li_idx].docno,"' "
                  CALL s_voucher_gen_fm('4',g_input.nmbsld,g_input.glapdocdt,g_input.glapdocno,'0',l_wc,'N','afmt555')
                      RETURNING g_sub_success,r_start_no,r_end_no       
               WHEN g_glap008 = 'afmt565'
                  LET l_wc =" fmmudocno = '",g_detail_d[li_idx].docno,"' "
                  CALL s_voucher_gen_fm('7',g_input.nmbsld,g_input.glapdocdt,g_input.glapdocno,'0',l_wc,'N','afmt565')
                      RETURNING g_sub_success,r_start_no,r_end_no
              WHEN g_glap008 = 'afmt570'
                  LET l_wc =" fmnadocno = '",g_detail_d[li_idx].docno,"' "
                  CALL s_voucher_gen_fm('3',g_input.nmbsld,g_input.glapdocdt,g_input.glapdocno,'0',l_wc,'N','afmt570')
                      RETURNING g_sub_success,r_start_no,r_end_no                        
               WHEN g_glap008 = 'afmt585'
                  LET l_wc =" fmmwdocno = '",g_detail_d[li_idx].docno,"' "
                  CALL s_voucher_gen_fm('6',g_input.nmbsld,g_input.glapdocdt,g_input.glapdocno,'0',l_wc,'N','afmt585')
                      RETURNING g_sub_success,r_start_no,r_end_no
               WHEN g_glap008 = 'afmt595'
                  LET l_wc =" fmnedocno = '",g_detail_d[li_idx].docno,"' "
                  CALL s_voucher_gen_fm('5',g_input.nmbsld,g_input.glapdocdt,g_input.glapdocno,'0',l_wc,'N','afmt595')
                      RETURNING g_sub_success,r_start_no,r_end_no
            END CASE
         END IF        
                      
         IF g_sub_success THEN
            UPDATE glga_t SET glga007 = r_start_no
             WHERE glgaent = g_enterprise AND glgald = g_input.nmbsld
               AND glgadocno=g_detail_d[li_idx].docno AND glga100 = 'FM' AND glga101 = l_str                   
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = SQLCA.sqlcode
            LET g_errparam.extend = g_detail_d[li_idx].docno
            LET g_errparam.code   = 'adz-00217'
            LET g_errparam.popup = TRUE
            CALL cl_err()             
            CALL s_transaction_end('Y','0')
            LET l_i = l_i + 1
            IF l_i = 1 THEN LET g_input.glstr_no = r_start_no END IF
         ELSE
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = SQLCA.sqlcode
            LET g_errparam.extend = g_detail_d[li_idx].docno
            LET g_errparam.code   = 'axr-00120'
            LET g_errparam.popup = TRUE
            CALL cl_err()
            CALL s_transaction_end('N','0')
         END IF       
      END IF         
   END FOR
   CALL g_detail_d.deleteElement(g_detail_d.getLength())
   IF l_i = 0 THEN
       INITIALIZE g_errparam TO NULL
       LET g_errparam.code = SQLCA.sqlcode
       LET g_errparam.extend = ''
       LET g_errparam.code   = 'axc-00530'
       LET g_errparam.popup = TRUE
       CALL cl_err()    
   END IF      
   CALL cl_err_collect_show()  
   LET g_input.glend_no = r_end_no
   DISPLAY BY NAME g_input.glstr_no,g_input.glend_no  

END FUNCTION

#end add-point
 
{</section>}
 
