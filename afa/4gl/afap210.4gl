#該程式未解開Section, 採用最新樣板產出!
{<section id="afap210.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0023(2016-12-28 15:33:17), PR版次:0023(2016-12-28 18:30:44)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000175
#+ Filename...: afap210
#+ Description: 底稿拋轉固定資產作業
#+ Creator....: 01531(2014-08-01 11:13:37)
#+ Modifier...: 07900 -SD/PR- 07900
 
{</section>}
 
{<section id="afap210.global" >}
#應用 p02 樣板自動產生(Version:22)
#add-point:填寫註解說明 name="global.memo"
#150731-00004#1  BY yangtt  BY 20150807   錯誤信息匯總報錯，將舊的報錯方式(cl_errmdg)改成新的報錯方式
#151023          151023     BY albireo    帳款單號採購單號收貨單號帶值
#151222-00006#1  151230     BY albireo    afap210回追:
#                                         1.選分割時:資產屬性未從底稿带到固資
#                                         2.中介檔faap固資號碼未取已取好號的號碼
#                                         3.拋固資本幣金額錯誤,(重新依原幣*匯率計算,並依本位幣取位)
#151228-00008#3  151230     BY albireo    afap210若是重覆執行, 第二次會將第一次的TEMP資料, 再產生一次
#                                         增加刪除子表的動作
#160111          160111     BY albireo    優化連續自動編碼時,只會取到最後一次的設定問題
#151225-00014#1  160130     BY albireo    配合連續編碼元件修正
#160318-00025#5  160414     BY 07675      將重複內容的錯誤訊息置換為公用錯誤訊息(r.v）
#160408-00020#3  2016/04/21 BY 01531      预设值为afai020里面主要类型的投资抵减值,抵减率,抵减年限
#160525-00040#1  2016/08/03 BY fengmy     资产合并,抛转后数量会加总,应该在抛转之前可维护抛转后数量；
#                                         资产合并抛转afai100的单价和金额不对，只有原币金额是对的
#                                         资产分割后产生的afai100的‘开始折旧年月’faaj008为空值
#160905-00007#1  2016/09/05 BY 08734      ent调整
#160913-00028#1  2016/09/13 BY 00768      单笔生成是类型是主件，附号依然可以输入并生成。
#160426-00014#37 2016/09/18 BY 02114      資產底稿產生到正式固資時, 若採分割  按数量成本金額自動分配
#160926-00010#1  2016/09/27 BY 02114      透過afap210產生固資資料時於單身其他資料及核算項頁籤中沒有帳款編號
#160923-00041#1  2016/09/29 By 01531      转固定资产时没有依据afai021主要类型设置的列账/列管给予faaj048赋值
#161009-00006#3  2016/10/12 By 02114      卡编自动编码时，抓取max（卡编）要按归属法人来抓
#161021-00053#1  2016/10/21 By dorishsu   當aoos020"財產編號是否自動編號"參數設定為N,再做財產編號是否已存在的檢查
#161111-00028#6  2016/11/17 by 08172      标准程式定义采用宣告模式,弃用.*写法
#161104-00048#8  2016/11/29 By 01531      底稿afai120抛转afai100时增加faai038的处理，default faah015.
#161130-00031#1  2016/12/02 By 01531      按拆分方式生成正式资产，在拆分界面中修改数量后，重新计算画面上金额=数量*底稿原币单价。
#161213-00015#1  2016/12/15 By 01531      允许异币种资产底稿合并生成正式资产，faah020(币种)=归属法人主账套的本位币，faah022(原币金额)=faah024(本币金额)=sum(faak024)，faah021=faah023=sum(faak024)/生成数量。
#161102-00025#2  2016/12/21 By 07900      增减资产建立日期的录入，抛转afai100的取得日期(faah014)=资产建立日期.
#161227-00026#1  2016/12/27 By 01531      afap210资产分割金额小数位及差异处理有误
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
     sel     LIKE type_t.chr1,
     faak000 LIKE faak_t.faak000,
     faak001 LIKE faak_t.faak001,
     faak003 LIKE faak_t.faak003,
     faak004 LIKE faak_t.faak004,
     faak019 LIKE faak_t.faak019,
     faak018 LIKE faak_t.faak018,
     faak022 LIKE faak_t.faak022,    
     produce LIKE type_t.chr1,     
     in      LIKE type_t.chr1,
     out     LIKE type_t.chr1,  
     faah000 LIKE faah_t.faah000,
     faah002 LIKE faah_t.faah002,
     faah001 LIKE faah_t.faah001,
     faah003 LIKE faah_t.faah003,
     faah004 LIKE faah_t.faah004,
     faah014 LIKE faah_t.faah014    #161102-00025#2 add xul     
                     END RECORD
DEFINE g_rec_b              LIKE type_t.num5
DEFINE g_rec_b1             LIKE type_t.num5 
DEFINE g_detail_idx         LIKE type_t.num5 
DEFINE g_detail_idx1        LIKE type_t.num5 
DEFINE l_ac1                LIKE type_t.num5 
DEFINE g_tmp  DYNAMIC ARRAY OF type_g_detail_d

TYPE type_g_detail1_d RECORD
     flag    LIKE type_t.num5, 
     faak000 LIKE faak_t.faak000,
     faak001 LIKE faak_t.faak001,
     faak003 LIKE faak_t.faak003,
     faak004 LIKE faak_t.faak004,
     faak019 LIKE faak_t.faak019,
     faak018 LIKE faak_t.faak018,
     faah018 LIKE faah_t.faah018, 
     faah022 LIKE faah_t.faah022,
     faah002 LIKE faah_t.faah002,
     faah001 LIKE faah_t.faah001,
     faah003 LIKE faah_t.faah003,
     faah004 LIKE faah_t.faah004,
     faah014 LIKE faah_t.faah014,      #161102-00025#2 add xul 
     #albireo 160111-----s
     l_oofg001_t1   LIKE type_t.chr100,
     l_before_code  LIKE type_t.chr100,
     l_num_code     LIKE type_t.chr100,
     l_after_code   LIKE type_t.chr100
     #albireo 160111-----e     
                     END RECORD
                     
DEFINE g_detail1_d  DYNAMIC ARRAY OF type_g_detail1_d 
DEFINE g_detail1_d_t   type_g_detail1_d
DEFINE g_detail1_d_o   type_g_detail1_d  #161130-00031#1 add
#############################add by huangtao
TYPE type_g_detail3_d RECORD
     sel     LIKE type_t.chr1,
     faak000 LIKE faak_t.faak000,
     faak001 LIKE faak_t.faak001,
     faak003 LIKE faak_t.faak003,
     faak004 LIKE faak_t.faak004,
     faak019 LIKE faak_t.faak019,
     faak018 LIKE faak_t.faak018,
     faak022 LIKE faak_t.faak022,
     faah002 LIKE faah_t.faah002,
     faah001 LIKE faah_t.faah001,
     faah003 LIKE faah_t.faah003,
     faah004 LIKE faah_t.faah004,
     faah014 LIKE faah_t.faah014       #161102-00025#2 add xul
                     END RECORD                
DEFINE g_detail3_d  DYNAMIC ARRAY OF type_g_detail3_d 
DEFINE g_detail3_d_t   type_g_detail3_d
#############################add by huangtao   
DEFINE g_faah_m     RECORD 
       faah002      LIKE faah_t.faah002,
       faah001      LIKE faah_t.faah001,
       faah003      LIKE faah_t.faah003,
       faah004      LIKE faah_t.faah004,
       faah006      LIKE faah_t.faah006,
       faah006_desc LIKE type_t.chr80,
       faah007      LIKE faah_t.faah007,
       faah007_desc LIKE type_t.chr80
      ,faah018      LIKE faah_t.faah018,   #160525-00040#1 add
       faah014      LIKE faah_t.faah014    #161102-00025#2 add xul
      END RECORD 
DEFINE g_para_data      LIKE type_t.chr80     #卡片編號是否自動編號
DEFINE g_para_data1     LIKE type_t.chr80     #折舊費用科目取值
DEFINE g_para_data2     LIKE type_t.chr80 
DEFINE g_para_data3     LIKE type_t.chr80 
DEFINE g_faah002_t      LIKE faah_t.faah002
DEFINE g_faah003_t      LIKE faah_t.faah003
DEFINE g_faak000    LIKE faak_t.faak000
DEFINE g_faak001    LIKE faak_t.faak001
DEFINE g_faak003    LIKE faak_t.faak003
DEFINE g_faak004    LIKE faak_t.faak004
DEFINE g_faak022    LIKE faak_t.faak022
DEFINE g_faak018    LIKE faak_t.faak018
DEFINE g_faak019    LIKE faak_t.faak019     #160426-00014#37 add lujh
DEFINE g_faak032    LIKE faak_t.faak032     #161009-00006#3 add lujh
DEFINE g_flag       LIKE type_t.chr1
DEFINE g_pr         LIKE type_t.chr1
#albireo 160111-----s
#自動編碼元件用的變數
DEFINE g_oofg001_t1         STRING
DEFINE g_before_code        STRING
DEFINE g_num_code           STRING
DEFINE g_after_code         STRING
#albireo 160111-----e
DEFINE g_faah014    LIKE faah_t.faah014    #161102-00025#2 add xul
#end add-point
 
#add-point:自定義客戶專用模組變數(Module Variable) name="global.variable_customerization"

#end add-point
DEFINE g_detail_cnt         LIKE type_t.num10              #單身 總筆數(所有資料)
DEFINE g_detail_d  DYNAMIC ARRAY OF type_g_detail_d
 
#add-point:傳入參數說明 name="global.argv"

#end add-point
 
{</section>}
 
{<section id="afap210.main" >}
#+ 作業開始 
MAIN
   #add-point:main段define(客製用) name="main.define_customerization"
   
   #end add-point   
   DEFINE ls_js  STRING
   #add-point:main段define name="main.define"
   DEFINE l_success    LIKE type_t.num5   #add--2015/03/20 By shiun
   #end add-point   
   
   #設定SQL錯誤記錄方式 (模組內定義有效)
   WHENEVER ERROR CALL cl_err_msg_log
 
   #add-point:初始化前定義 name="main.before_ap_init"
   
   #end add-point
   #依模組進行系統初始化設定(系統設定)
   CALL cl_ap_init("afa","")
 
   #add-point:定義背景狀態與整理進入需用參數ls_js name="main.background"
   CALL s_aooi390_cre_tmp_table() RETURNING l_success   #add--2015/03/20 By shiun
   #end add-point
 
   IF g_bgjob = "Y" THEN
      #add-point:Service Call name="main.servicecall"
      
      #end add-point
   ELSE
      #畫面開啟 (identifier)
      OPEN WINDOW w_afap210 WITH FORM cl_ap_formpath("afa",g_code)
   
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
   
      #程式初始化
      CALL afap210_init()   
 
      #進入選單 Menu (="N")
      CALL afap210_ui_dialog() 
 
      #add-point:畫面關閉前 name="main.before_close"
 
      #end add-point
      #畫面關閉
      CLOSE WINDOW w_afap210
   END IF 
   
   #add-point:作業離開前 name="main.exit"
   CALL s_aooi390_drop_tmp_table()   #add--2015/03/20 By shiun
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
END MAIN
 
{</section>}
 
{<section id="afap210.init" >}
#+ 畫面資料初始化
PRIVATE FUNCTION afap210_init()
   #add-point:init段define(客製用) name="init.define_customerization"
   
   #end add-point   
   #add-point:init段define name="init.define"
   DEFINE l_ooef017  LIKE ooef_t.ooef017
   #end add-point   
   
   LET g_error_show  = 1
   LET g_wc_filter   = " 1=1"
   LET g_wc_filter_t = " 1=1"
 
   #add-point:畫面資料初始化 name="init.init"
   CALL cl_set_combo_scc('b_faah002','9911')
   CALL cl_set_comp_entry("b_faah000,b_faah001,b_faah003,b_faah004",FALSE) #20141127 add by chenying 
   SELECT ooef017 INTO l_ooef017
     FROM ooef_t
    WHERE ooef001 = g_site
      AND ooefent = g_enterprise
   CALL cl_get_para(g_enterprise,l_ooef017,'S-FIN-9005') RETURNING g_para_data   #卡片編號是否自動編號
   CALL cl_get_para(g_enterprise,l_ooef017,'S-FIN-9002') RETURNING g_para_data2  #财产编号预设是否与卡片编号一致
   CALL cl_get_para(g_enterprise,l_ooef017,'S-FIN-9010') RETURNING g_para_data3  #财产编号自动编号否
   IF g_para_data = 'Y' THEN 
      CALL cl_set_comp_visible("b_faah001",FALSE)
   ELSE
      CALL cl_set_comp_visible("b_faah001",TRUE)
   END IF 
   #end add-point
   
END FUNCTION
 
{</section>}
 
{<section id="afap210.ui_dialog" >}
#+ 選單功能實際執行處
PRIVATE FUNCTION afap210_ui_dialog()
   #add-point:ui_dialog段define(客製用) name="ui_dialog.define_customerization"
   
   #end add-point 
   DEFINE li_idx   LIKE type_t.num10
   #add-point:ui_dialog段define name="init.init"
   
   CALL afap210_ui_dialog_1()
   RETURN
   
#  DEFINE l_ooab002     LIKE ooab_t.ooab002
#  DEFINE l_max_faah001 LIKE faah_t.faah001
#  DEFINE l_cnt         LIKE type_t.num5 
#  DEFINE l_n           LIKE type_t.num5
#  DEFINE l_faah001     LIKE faah_t.faah001
   #end add-point 
   
   LET gwin_curr = ui.Window.getCurrent()
   LET gfrm_curr = gwin_curr.getForm()   
   
   LET g_action_choice = " "  
   CALL cl_set_act_visible("accept,cancel", FALSE)
         
   LET g_detail_cnt = g_detail_d.getLength()
   #add-point:ui_dialog段before dialog name="ui_dialog.before_dialog"

   CALL afap210_create_tmp()
   

   #end add-point
   
   WHILE TRUE
 
      IF g_action_choice = "logistics" THEN
         #清除畫面及相關資料
         CLEAR FORM
         CALL g_detail_d.clear()
         LET g_wc  = ' 1=2'
         LET g_wc2 = ' 1=1'
         LET g_action_choice = ""
         CALL afap210_init()
      END IF
 
      DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
         #add-point:ui_dialog段construct name="ui_dialog.more_construct"
               
         #end add-point
         #add-point:ui_dialog段input name="ui_dialog.more_input"
         INPUT ARRAY g_detail_d FROM s_detail1.*
            ATTRIBUTE(COUNT = g_rec_b,MAXCOUNT = g_max_rec,WITHOUT DEFAULTS, 
                      INSERT ROW = FALSE, 
                      DELETE ROW = FALSE,
                      APPEND ROW = TRUE)
                    
   #        BEFORE INPUT
   #           CALL cl_set_comp_entry("b_faah000,b_faah001,b_faah003,b_faah004",FALSE)  
   #
   #        BEFORE ROW
   #           LET l_ac = ARR_CURR()
   #           
   #        AFTER FIELD b_faah003
   #           IF NOT cl_null(g_detail_d[l_ac].faah000) AND NOT cl_null(g_detail_d[l_ac].faah001) AND
   #              NOT cl_null(g_detail_d[l_ac].faah003) AND NOT cl_null(g_detail_d[l_ac].faah003) THEN 
   #              SELECT COUNT(*) INTO l_cnt FROM faah_t 
   #               WHERE faahent = g_enterprise
   #                 AND faah000 = g_detail_d[l_ac].faah000
   #                 AND faah001 = g_detail_d[l_ac].faah001
   #                 AND faah003 = g_detail_d[l_ac].faah003
   #                 AND faah004 = g_detail_d[l_ac].faah004
   #              IF l_cnt > 0 THEN
   #                 INITIALIZE g_errparam TO NULL
   #                 LET g_errparam.code = 'afa-00141'
   #                 LET g_errparam.extend = ''
   #                 LET g_errparam.popup = TRUE
   #                 CALL cl_err()
   #                 NEXT FIELD CURRENT                  
   #              END IF                  
   #           END IF  
   #           
   #           IF NOT cl_null(g_detail_d[l_ac].faah003) THEN          
   #              UPDATE afap210_tmp SET faah003 = g_detail_d[l_ac].faah003 
   #               WHERE faak000 = g_detail_d[l_ac].faak000
   #                 AND faak001 = g_detail_d[l_ac].faak001
   #                 AND faak003 = g_detail_d[l_ac].faak003
   #                 AND faak004 = g_detail_d[l_ac].faak004  
   #              IF SQLCA.sqlcode THEN
   #                 INITIALIZE g_errparam TO NULL
   #                 LET g_errparam.code = SQLCA.sqlcode
   #                 LET g_errparam.extend = 'update faah003'
   #                 LET g_errparam.popup = TRUE
   #                 CALL cl_err()                 
   #              END IF 
   #           END IF                
   #
   #       AFTER FIELD b_faah004  
   #           IF NOT cl_null(g_detail_d[l_ac].faah000) AND NOT cl_null(g_detail_d[l_ac].faah001) AND
   #              NOT cl_null(g_detail_d[l_ac].faah003) AND NOT cl_null(g_detail_d[l_ac].faah003) THEN 
   #              SELECT COUNT(*) INTO l_cnt FROM faah_t 
   #               WHERE faahent = g_enterprise
   #                 AND faah000 = g_detail_d[l_ac].faah000
   #                 AND faah001 = g_detail_d[l_ac].faah001
   #                 AND faah003 = g_detail_d[l_ac].faah003
   #                 AND faah004 = g_detail_d[l_ac].faah004
   #              IF l_cnt > 0 THEN
   #                 INITIALIZE g_errparam TO NULL
   #                 LET g_errparam.code = 'afa-00141'
   #                 LET g_errparam.extend = ''
   #                 LET g_errparam.popup = TRUE
   #                 CALL cl_err()
   #                 NEXT FIELD CURRENT                  
   #              END IF                  
   #           END IF   
   #
   #           IF NOT cl_null(g_detail_d[l_ac].faah004) THEN  
   #              UPDATE afap210_tmp SET faah004 = g_detail_d[l_ac].faah004 
   #               WHERE faak000 = g_detail_d[l_ac].faak000
   #                 AND faak001 = g_detail_d[l_ac].faak001
   #                 AND faak003 = g_detail_d[l_ac].faak003
   #                 AND faak004 = g_detail_d[l_ac].faak004  
   #              IF SQLCA.sqlcode THEN
   #                 INITIALIZE g_errparam TO NULL
   #                 LET g_errparam.code = SQLCA.sqlcode
   #                 LET g_errparam.extend = 'update faah004'
   #                 LET g_errparam.popup = TRUE
   #                 CALL cl_err()                 
   #              END IF
   #           END IF
   #        
   #        AFTER FIELD b_faah001
   #           IF NOT cl_null(g_detail_d[l_ac].faah000) AND NOT cl_null(g_detail_d[l_ac].faah001) AND
   #              NOT cl_null(g_detail_d[l_ac].faah003) AND NOT cl_null(g_detail_d[l_ac].faah003) THEN 
   #              SELECT COUNT(*) INTO l_cnt FROM faah_t 
   #               WHERE faahent = g_enterprise
   #                 AND faah000 = g_detail_d[l_ac].faah000
   #                 AND faah001 = g_detail_d[l_ac].faah001
   #                 AND faah003 = g_detail_d[l_ac].faah003
   #                 AND faah004 = g_detail_d[l_ac].faah004
   #              IF l_cnt > 0 THEN
   #                 INITIALIZE g_errparam TO NULL
   #                 LET g_errparam.code = 'afa-00141'
   #                 LET g_errparam.extend = ''
   #                 LET g_errparam.popup = TRUE
   #                 CALL cl_err()
   #                 NEXT FIELD CURRENT                  
   #              END IF                  
   #           END IF 
   #
   #           IF NOT cl_null(g_detail_d[l_ac].faah001) THEN
   #              UPDATE afap210_tmp SET faah001 = g_detail_d[l_ac].faah001 
   #               WHERE faak000 = g_detail_d[l_ac].faak000
   #                 AND faak001 = g_detail_d[l_ac].faak001
   #                 AND faak003 = g_detail_d[l_ac].faak003
   #                 AND faak004 = g_detail_d[l_ac].faak004 
   #              IF SQLCA.sqlcode THEN
   #                 INITIALIZE g_errparam TO NULL
   #                 LET g_errparam.code = SQLCA.sqlcode
   #                 LET g_errparam.extend = 'update faah001'
   #                 LET g_errparam.popup = TRUE
   #                 CALL cl_err()                 
   #              END IF
   #           END IF
   #
   #        AFTER FIELD b_faah000
   #           IF NOT cl_null(g_detail_d[l_ac].faah000) AND NOT cl_null(g_detail_d[l_ac].faah001) AND
   #              NOT cl_null(g_detail_d[l_ac].faah003) AND NOT cl_null(g_detail_d[l_ac].faah003) THEN 
   #              SELECT COUNT(*) INTO l_cnt FROM faah_t 
   #               WHERE faahent = g_enterprise
   #                 AND faah000 = g_detail_d[l_ac].faah000
   #                 AND faah001 = g_detail_d[l_ac].faah001
   #                 AND faah003 = g_detail_d[l_ac].faah003
   #                 AND faah004 = g_detail_d[l_ac].faah004
   #              IF l_cnt > 0 THEN
   #                 INITIALIZE g_errparam TO NULL
   #                 LET g_errparam.code = 'afa-00141'
   #                 LET g_errparam.extend = ''
   #                 LET g_errparam.popup = TRUE
   #                 CALL cl_err()
   #                 NEXT FIELD CURRENT                  
   #              END IF                  
   #           END IF 
   #
   #           IF NOT cl_null(g_detail_d[l_ac].faah000) THEN  
   #              UPDATE afap210_tmp SET faah000 = g_detail_d[l_ac].faah000 
   #               WHERE faak000 = g_detail_d[l_ac].faak000
   #                 AND faak001 = g_detail_d[l_ac].faak001
   #                 AND faak003 = g_detail_d[l_ac].faak003
   #                 AND faak004 = g_detail_d[l_ac].faak004 
   #              IF SQLCA.sqlcode THEN
   #                 INITIALIZE g_errparam TO NULL
   #                 LET g_errparam.code = SQLCA.sqlcode
   #                 LET g_errparam.extend = 'update faah000'
   #                 LET g_errparam.popup = TRUE
   #                 CALL cl_err()                 
   #              END IF
   #           END IF
   #            
   #        ON CHANGE sel
   #           IF g_detail_d[l_ac].sel = 'Y' THEN 
   #              UPDATE afap210_tmp SET sel = 'Y' 
   #               WHERE faak000 = g_detail_d[l_ac].faak000
   #                 AND faak001 = g_detail_d[l_ac].faak001
   #                 AND faak003 = g_detail_d[l_ac].faak003
   #                 AND faak004 = g_detail_d[l_ac].faak004
   #              CALL cl_set_comp_entry("b_faah000,b_faah001,b_faah003,b_faah004,out,in",TRUE)   
   #           ELSE
   #              UPDATE afap210_tmp SET sel = 'N' 
   #               WHERE faak000 = g_detail_d[l_ac].faak000
   #                 AND faak001 = g_detail_d[l_ac].faak001
   #                 AND faak003 = g_detail_d[l_ac].faak003
   #                 AND faak004 = g_detail_d[l_ac].faak004  
   #              CALL cl_set_comp_entry("b_faah000,b_faah001,b_faah003,b_faah004,out,in",FALSE)    
   #           END IF 
   #           
   #           IF SQLCA.sqlcode THEN
   #              INITIALIZE g_errparam TO NULL
   #              LET g_errparam.code = SQLCA.sqlcode
   #              LET g_errparam.extend = 'update 1'
   #              LET g_errparam.popup = TRUE
   #              CALL cl_err()                 
   #           END IF
   #           
   #        ON CHANGE in
   #           CALL cl_set_comp_entry("b_faah000,b_faah001,b_faah003,b_faah004",TRUE) 
   #
   #           IF g_detail_d[l_ac].in = 'Y' THEN 
   #              CALL cl_set_comp_entry("out",FALSE)
   #              
   #              UPDATE afap210_tmp SET pin = 'Y' 
   #               WHERE faak000 = g_detail_d[l_ac].faak000
   #                 AND faak001 = g_detail_d[l_ac].faak001
   #                 AND faak003 = g_detail_d[l_ac].faak003
   #                 AND faak004 = g_detail_d[l_ac].faak004
   #             
   #        #SELECT COUNT(*) INTO l_n FROM afap210_tmp WHERE sel = 'Y' AND pin = 'Y'  #ceshi   
   #  
#  #               #檢查tmp中是否存在已有最大的卡片編號  
#  #               #是否自動編號 S-FIN-9005
#  #               SELECT ooab002 INTO l_ooab002 FROM ooab_t
#  #                WHERE ooabent = g_enterprise
#  #                  AND ooab001 = 'S-FIN-9005'
#  #                  AND ooabsite = g_site 
#  #                  
#  #               SELECT MAX(faah001) INTO l_max_faah001 FROM afap210_tmp,afap210_01_tmp
#  #               
#  #               IF l_max_faah001 IS NULL THEN
#  #                  IF l_ooab002 = 'Y' THEN 
#  #                     SELECT MAX(faah001) INTO l_max_faah001 FROM faah_t     
#  #                     LET g_detail_d[l_ac].faah001 = l_max_faah001+1 USING '&&&&&&&&&&'                     
#  #                  ELSE
#  #                     LET g_detail_d[l_ac].faah001 = ''
#  #                  END IF                  
#  #               ELSE
#  #                  IF l_ooab002 = 'Y' THEN 
#  #                     LET g_detail_d[l_ac].faah001 = l_max_faah001+1 USING '&&&&&&&&&&'
#  #                  ELSE
#  #                     LET g_detail_d[l_ac].faah001 = ''
#  #                  END IF                  
#  #               END IF   
   #              
   #              CALL afap210_get_faah001() RETURNING l_faah001
   #              LET g_detail_d[l_ac].faah001 = l_faah001
   #              UPDATE afap210_tmp SET faah001 = g_detail_d[l_ac].faah001 
   #               WHERE faak000 = g_detail_d[l_ac].faak000
   #                 AND faak001 = g_detail_d[l_ac].faak001
   #                 AND faak003 = g_detail_d[l_ac].faak003
   #                 AND faak004 = g_detail_d[l_ac].faak004 
   #
   #              IF SQLCA.sqlcode THEN
   #                 INITIALIZE g_errparam TO NULL
   #                 LET g_errparam.code = SQLCA.sqlcode
   #                 LET g_errparam.extend = 'update 8'
   #                 LET g_errparam.popup = TRUE
   #                 CALL cl_err()                 
   #              END IF                    
   #           ELSE
   #              LET g_detail_d[l_ac].faah000 = ''
   #              LET g_detail_d[l_ac].faah001 = ''
   #              LET g_detail_d[l_ac].faah003 = ''
   #              LET g_detail_d[l_ac].faah004 = ''
   #              
   #              CALL cl_set_comp_entry("out",TRUE)
   #              
   #              UPDATE afap210_tmp SET pin = 'N' 
   #               WHERE faak000 = g_detail_d[l_ac].faak000
   #                 AND faak001 = g_detail_d[l_ac].faak001
   #                 AND faak003 = g_detail_d[l_ac].faak003
   #                 AND faak004 = g_detail_d[l_ac].faak004               
   #           END IF 
   #           
   #           IF SQLCA.sqlcode THEN
   #              INITIALIZE g_errparam TO NULL
   #              LET g_errparam.code = SQLCA.sqlcode
   #              LET g_errparam.extend = 'update 2'
   #              LET g_errparam.popup = TRUE
   #              CALL cl_err()                 
   #           END IF               
   #           
   #
   #        ON CHANGE out
   #           CALL cl_set_comp_entry("b_faah000,b_faah001,b_faah003,b_faah004",TRUE)
   #
   #           IF g_detail_d[l_ac].out = 'Y' THEN 
   #              CALL cl_set_comp_entry("in",FALSE)
   #              
   #              UPDATE afap210_tmp SET pout = 'Y' 
   #               WHERE faak000 = g_detail_d[l_ac].faak000
   #                 AND faak001 = g_detail_d[l_ac].faak001
   #                 AND faak003 = g_detail_d[l_ac].faak003
   #                 AND faak004 = g_detail_d[l_ac].faak004
   #                 
   #              CALL afap210_01_ins(g_detail_d[l_ac].faak000,g_detail_d[l_ac].faak001,g_detail_d[l_ac].faak003,
   #                                  g_detail_d[l_ac].faak004,g_detail_d[l_ac].faak019,g_detail_d[l_ac].faak018) 
   #                                  
   #              CALL afap210_01_open(g_detail_d[l_ac].faak000,g_detail_d[l_ac].faak001,g_detail_d[l_ac].faak003,
   #                                    g_detail_d[l_ac].faak004,g_detail_d[l_ac].faak019,g_detail_d[l_ac].faak018,
   #                                    g_detail_d[l_ac].in,g_detail_d[l_ac].out)   
   #           ELSE
   #              CALL cl_set_comp_entry("in",TRUE)
   #              
   #              UPDATE afap210_tmp SET pout = 'N' 
   #               WHERE faak000 = g_detail_d[l_ac].faak000
   #                 AND faak001 = g_detail_d[l_ac].faak001
   #                 AND faak003 = g_detail_d[l_ac].faak003
   #                 AND faak004 = g_detail_d[l_ac].faak004               
   #           END IF 
   #           
   #           IF SQLCA.sqlcode THEN
   #              INITIALIZE g_errparam TO NULL
   #              LET g_errparam.code = SQLCA.sqlcode
   #              LET g_errparam.extend = 'update 3'
   #              LET g_errparam.popup = TRUE
   #              CALL cl_err()                 
   #           END IF  
   #
   #        ON CHANGE b_faah000 
   #           UPDATE afap210_tmp SET faah000 = g_detail_d[l_ac].faah000 
   #            WHERE faak000 = g_detail_d[l_ac].faak000
   #              AND faak001 = g_detail_d[l_ac].faak001
   #              AND faak003 = g_detail_d[l_ac].faak003
   #              AND faak004 = g_detail_d[l_ac].faak004  
   #           IF SQLCA.sqlcode THEN
   #              INITIALIZE g_errparam TO NULL
   #              LET g_errparam.code = SQLCA.sqlcode
   #              LET g_errparam.extend = 'update faah000'
   #              LET g_errparam.popup = TRUE
   #              CALL cl_err()                 
   #           END IF 
   #
   #        ON CHANGE b_faah001 
   #           UPDATE afap210_tmp SET faah001 = g_detail_d[l_ac].faah001 
   #            WHERE faak000 = g_detail_d[l_ac].faak000
   #              AND faak001 = g_detail_d[l_ac].faak001
   #              AND faak003 = g_detail_d[l_ac].faak003
   #              AND faak004 = g_detail_d[l_ac].faak004  
   #           IF SQLCA.sqlcode THEN
   #              INITIALIZE g_errparam TO NULL
   #              LET g_errparam.code = SQLCA.sqlcode
   #              LET g_errparam.extend = 'update faah001'
   #              LET g_errparam.popup = TRUE
   #              CALL cl_err()                 
   #           END IF  
   #           
   #        ON CHANGE b_faah003 
   #           UPDATE afap210_tmp SET faah003 = g_detail_d[l_ac].faah003 
   #            WHERE faak000 = g_detail_d[l_ac].faak000
   #              AND faak001 = g_detail_d[l_ac].faak001
   #              AND faak003 = g_detail_d[l_ac].faak003
   #              AND faak004 = g_detail_d[l_ac].faak004  
   #           IF SQLCA.sqlcode THEN
   #              INITIALIZE g_errparam TO NULL
   #              LET g_errparam.code = SQLCA.sqlcode
   #              LET g_errparam.extend = 'update faah003'
   #              LET g_errparam.popup = TRUE
   #              CALL cl_err()                 
   #           END IF  
   #
   #        ON CHANGE b_faah004 
   #           UPDATE afap210_tmp SET faah004 = g_detail_d[l_ac].faah004 
   #            WHERE faak000 = g_detail_d[l_ac].faak000
   #              AND faak001 = g_detail_d[l_ac].faak001
   #              AND faak003 = g_detail_d[l_ac].faak003
   #              AND faak004 = g_detail_d[l_ac].faak004                  
   #           IF SQLCA.sqlcode THEN
   #              INITIALIZE g_errparam TO NULL
   #              LET g_errparam.code = SQLCA.sqlcode
   #              LET g_errparam.extend = 'update faah004'
   #              LET g_errparam.popup = TRUE
   #              CALL cl_err()                 
   #           END IF
   #
   #        AFTER INPUT
   #           IF NOT cl_null(g_detail_d[l_ac].faah004) THEN
   #              UPDATE afap210_tmp SET faah004 = g_detail_d[l_ac].faah004 
   #               WHERE faak000 = g_detail_d[l_ac].faak000
   #                 AND faak001 = g_detail_d[l_ac].faak001
   #                 AND faak003 = g_detail_d[l_ac].faak003
   #                 AND faak004 = g_detail_d[l_ac].faak004 
   #           END IF  
   #           IF NOT cl_null(g_detail_d[l_ac].faah003) THEN
   #              UPDATE afap210_tmp SET faah003 = g_detail_d[l_ac].faah003 
   #               WHERE faak000 = g_detail_d[l_ac].faak000
   #                 AND faak001 = g_detail_d[l_ac].faak001
   #                 AND faak003 = g_detail_d[l_ac].faak003
   #                 AND faak004 = g_detail_d[l_ac].faak004 
   #           END IF 
   #           IF NOT cl_null(g_detail_d[l_ac].faah001) THEN
   #              UPDATE afap210_tmp SET faah001 = g_detail_d[l_ac].faah001 
   #               WHERE faak000 = g_detail_d[l_ac].faak000
   #                 AND faak001 = g_detail_d[l_ac].faak001
   #                 AND faak003 = g_detail_d[l_ac].faak003
   #                 AND faak004 = g_detail_d[l_ac].faak004 
   #           END IF 
   #           IF NOT cl_null(g_detail_d[l_ac].faah000) THEN
   #              UPDATE afap210_tmp SET faah000 = g_detail_d[l_ac].faah000 
   #               WHERE faak000 = g_detail_d[l_ac].faak000
   #                 AND faak001 = g_detail_d[l_ac].faak001
   #                 AND faak003 = g_detail_d[l_ac].faak003
   #                 AND faak004 = g_detail_d[l_ac].faak004 
   #           END IF   
   #
   #           IF SQLCA.sqlcode THEN
   #              INITIALIZE g_errparam TO NULL
   #              LET g_errparam.code = SQLCA.sqlcode
   #              LET g_errparam.extend = 'update :'
   #              LET g_errparam.popup = TRUE
   #              CALL cl_err()                 
   #           END IF
            
              
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
            CALL afap210_construct()
   
            IF g_action_choice = "exit" AND NOT cl_null(g_action_choice) THEN
               EXIT WHILE
            END IF
   
            CALL afap210_b_fill()
            #end add-point
 
         #選擇全部
         ON ACTION selall
            CALL DIALOG.setSelectionRange("s_detail1", 1, -1, 1)
            #add-point:ui_dialog段on action selall name="ui_dialog.selall.befroe"
            
            #end add-point            
            FOR li_idx = 1 TO g_detail_d.getLength()
               LET g_detail_d[li_idx].sel = "Y"
               #add-point:ui_dialog段on action selall name="ui_dialog.for.onaction_selall"
               
               #end add-point
            END FOR
            #add-point:ui_dialog段on action selall name="ui_dialog.onaction_selall"
            UPDATE afap210_tmp SET sel = 'Y'
            IF SQLCA.sqlcode THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = SQLCA.sqlcode
               LET g_errparam.extend = 'update 4'
               LET g_errparam.popup = TRUE
               CALL cl_err()                 
            END IF            
 
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
            UPDATE afap210_tmp SET sel = 'N'
            IF SQLCA.sqlcode THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = SQLCA.sqlcode
               LET g_errparam.extend = 'update 5'
               LET g_errparam.popup = TRUE
               CALL cl_err()                 
            END IF   
            #end add-point
 
         #勾選所選資料
         ON ACTION sel
            FOR li_idx = 1 TO g_detail_d.getLength()
               IF DIALOG.isRowSelected("s_detail1", li_idx) THEN
                  LET g_detail_d[li_idx].sel = "Y"
               END IF
            END FOR
            #add-point:ui_dialog段on action sel name="ui_dialog.onaction_sel"
            UPDATE afap210_tmp SET sel = 'Y' 
             WHERE faak000 = g_detail_d[l_ac].faak000
               AND faak001 = g_detail_d[l_ac].faak001
               AND faak003 = g_detail_d[l_ac].faak003
               AND faak004 = g_detail_d[l_ac].faak004

            IF SQLCA.sqlcode THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = SQLCA.sqlcode
               LET g_errparam.extend = 'update 6'
               LET g_errparam.popup = TRUE
               CALL cl_err()                 
            END IF
            #end add-point
 
         #取消所選資料
         ON ACTION unsel
            FOR li_idx = 1 TO g_detail_d.getLength()
               IF DIALOG.isRowSelected("s_detail1", li_idx) THEN
                  LET g_detail_d[li_idx].sel = "N"
               END IF
            END FOR
            #add-point:ui_dialog段on action unsel name="ui_dialog.onaction_unsel"
            UPDATE afap210_tmp SET sel = 'N' 
             WHERE faak000 = g_detail_d[l_ac].faak000
               AND faak001 = g_detail_d[l_ac].faak001
               AND faak003 = g_detail_d[l_ac].faak003
               AND faak004 = g_detail_d[l_ac].faak004

            IF SQLCA.sqlcode THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = SQLCA.sqlcode
               LET g_errparam.extend = 'update 7'
               LET g_errparam.popup = TRUE
               CALL cl_err()                 
            END IF
            #end add-point
      
         ON ACTION filter
            LET g_action_choice="filter"
            CALL afap210_filter()
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
            CALL afap210_query()
             
         # 條件清除
         ON ACTION qbeclear
            #add-point:ui_dialog段 name="ui_dialog.qbeclear"
            #20150210 add by chenying
            LET INT_FLAG = 1
            EXIT DIALOG   
            #20150210 add by chenying
            #end add-point
 
         # 重新整理
         ON ACTION datarefresh
            LET g_error_show = 1
            #add-point:ui_dialog段datarefresh name="ui_dialog.datarefresh"
            
            #end add-point
            CALL afap210_b_fill()
 
         #add-point:ui_dialog段action name="ui_dialog.more_action"
         ON ACTION cancel
            LET INT_FLAG = 1
            EXIT DIALOG         
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
 
{<section id="afap210.query" >}
#+ QBE資料查詢
PRIVATE FUNCTION afap210_query()
   #add-point:query段define(客製用) name="query.define_customerization"
   
   #end add-point 
   DEFINE ls_wc      STRING
   DEFINE ls_return  STRING
   DEFINE ls_result  STRING 
   #add-point:query段define name="query.define"
   
   #end add-point 
    
   #add-point:cs段after_construct name="query.after_construct"
   CALL afap210_upd_tmp()
   RETURN
   #end add-point
        
   LET g_error_show = 1
   CALL afap210_b_fill()
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
 
{<section id="afap210.b_fill" >}
#+ 單身陣列填充
PRIVATE FUNCTION afap210_b_fill()
   #add-point:b_fill段define(客製用) name="b_fill.define_customerization"
   
   #end add-point
   DEFINE ls_wc           STRING
   #add-point:b_fill段define name="b_fill.define"
   DEFINE  l_n       LIKE type_t.num5
   #end add-point
 
   LET g_wc = g_wc, cl_sql_auth_filter()   #(ver:21) add cl_sql_auth_filter()
 
   #add-point:b_fill段sql_before name="b_fill.sql_before"
  #LET g_sql = " SELECT 'N',faak000,faak001,faak003,faak004,faak019,faak018,faak022,'N','N','N','','','','',' ' ",    #161102-00025#2 MARK
   LET g_sql = " SELECT 'N',faak000,faak001,faak003,faak004,faak019,faak018,faak022,'N','N','N','','','','',' ','' ", #161102-00025#2 ADD 
               "   FROM faak_t ",
               "  WHERE faakent = ? AND faakstus = 'Y' AND faak043 = 'N' ",
               "    AND ",g_wc CLIPPED,
               "  ORDER BY faak000,faak001,faak003,faak004"               
   #end add-point
 
   PREPARE afap210_sel FROM g_sql
   DECLARE b_fill_curs CURSOR FOR afap210_sel
   
   CALL g_detail_d.clear()
   #add-point:b_fill段其他頁簽清空 name="b_fill.clear"
   #删除临时表资料
   DELETE FROM afap210_tmp
   DELETE FROM afap210_01_tmp   #151228-00008#3      
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = "afap210_tmp"
      LET g_errparam.popup = TRUE
      CALL cl_err()
      RETURN
   END IF
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
#      LET g_detail_d[l_ac].faah000=g_detail_d[l_ac].faak000   #mark by yangxf
      INSERT INTO afap210_tmp VALUES(g_detail_d[l_ac].*)
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "afap210_tmp"
         LET g_errparam.popup = TRUE
         CALL cl_err()  
         EXIT FOREACH
      END IF  

      SELECT COUNT(*) INTO l_n FROM afap210_tmp  

      #end add-point
      
      CALL afap210_detail_show()      
 
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
   CALL g_detail_d.deleteElement(l_ac)
   #end add-point
    
   LET g_detail_cnt = l_ac - 1 
   DISPLAY g_detail_cnt TO FORMONLY.h_count
   LET l_ac = g_cnt
   LET g_cnt = 0
   
   CLOSE b_fill_curs
   FREE afap210_sel
   
   LET l_ac = 1
   CALL afap210_fetch()
   #add-point:b_fill段資料填充(其他單身) name="b_fill.after_b_fill"
   
   #end add-point
 
END FUNCTION
 
{</section>}
 
{<section id="afap210.fetch" >}
#+ 單身陣列填充2
PRIVATE FUNCTION afap210_fetch()
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
 
{<section id="afap210.detail_show" >}
#+ 顯示相關資料
PRIVATE FUNCTION afap210_detail_show()
   #add-point:show段define(客製用) name="detail_show.define_customerization"
   
   #end add-point
   #add-point:show段define name="detail_show.define"
   
   #end add-point
   
   #add-point:detail_show段 name="detail_show.detail_show"
   
   #end add-point
 
END FUNCTION
 
{</section>}
 
{<section id="afap210.filter" >}
#+ filter過濾功能
PRIVATE FUNCTION afap210_filter()
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
   
   CALL afap210_b_fill()
   
END FUNCTION
 
{</section>}
 
{<section id="afap210.filter_parser" >}
#+ filter欄位解析
PRIVATE FUNCTION afap210_filter_parser(ps_field)
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
 
{<section id="afap210.filter_show" >}
#+ Browser標題欄位顯示搜尋條件
PRIVATE FUNCTION afap210_filter_show(ps_field,ps_object)
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
   LET ls_condition = afap210_filter_parser(ps_field)
   IF NOT cl_null(ls_condition) THEN
      LET ls_title = ls_title, '※', ls_condition, '※'
   END IF
 
   #將資料顯示回去
   CALL lnode_item.setAttribute("text",ls_title)
 
END FUNCTION
 
{</section>}
 
{<section id="afap210.other_function" readonly="Y" >}
#add-point:自定義元件(Function) name="other.function"

################################################################################
# Descriptions...: 單身資料查詢
# Memo...........:
# Usage..........: CALL afap210_construct()
# Input parameter: 
# Date & Author..: 2014/8/5 By 01531
# Modify.........:
################################################################################
PRIVATE FUNCTION afap210_construct()
   CLEAR FORM
   CALL g_detail_d.clear()
   INITIALIZE g_wc TO NULL
   
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)

         CONSTRUCT BY NAME g_wc ON faak000,faak001,faak003,faak004

            BEFORE CONSTRUCT
               CALL cl_qbe_init()
            
            ON ACTION controlp INFIELD faak000
	            INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c'
	            LET g_qryparam.reqry = FALSE
               CALL q_faak000()                       #呼叫開窗
               DISPLAY g_qryparam.return1 TO faak000  #顯示到畫面上  
               NEXT FIELD faak000                     #返回原欄位 
               
            ON ACTION controlp INFIELD faak001
	            INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c'
	            LET g_qryparam.reqry = FALSE
               CALL q_faak001_1()                     #呼叫開窗
               DISPLAY g_qryparam.return1 TO faak001  #顯示到畫面上  
               NEXT FIELD faak001                     #返回原欄位 

            ON ACTION controlp INFIELD faak003
	            INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c'
	            LET g_qryparam.reqry = FALSE
               CALL q_faak003_1()                       #呼叫開窗
               DISPLAY g_qryparam.return1 TO faak003  #顯示到畫面上  
               NEXT FIELD faak003                     #返回原欄位 
               
            ON ACTION controlp INFIELD faak004
	            INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c'
	            LET g_qryparam.reqry = FALSE
               CALL q_faak004_1()                       #呼叫開窗
               DISPLAY g_qryparam.return1 TO faak004_1  #顯示到畫面上  
               NEXT FIELD faak004                       #返回原欄位
               
         END CONSTRUCT



      ON ACTION accept
         ACCEPT DIALOG

      ON ACTION cancel
         LET INT_FLAG = 1
         EXIT DIALOG
         
      ON ACTION close
         LET g_action_choice = "exit" 
         LET INT_FLAG = 1
         EXIT DIALOG


      #查詢CONSTRUCT共用ACTION
      &include "construct_action.4gl"

      #交談指令共用ACTION
      &include "common_action.4gl"
         CONTINUE DIALOG
   END DIALOG
END FUNCTION

################################################################################
# Descriptions...: 臨時表
# Memo...........:
# Usage..........: CALL afap210_create_tmp()
# Input parameter:  
# Return code....:  
# Date & Author..: 2014/8/5 By 01531
# Modify.........:
################################################################################
PRIVATE FUNCTION afap210_create_tmp()
#DEFINE r_success       LIKE type_t.num5
#   
#   WHENEVER ERROR CONTINUE
#   LET r_success = FALSE
#
#   #检查事务中
#   IF NOT s_transaction_chk('N',1) THEN
#      RETURN r_success
#   END IF 
    DROP TABLE afap210_tmp;
      CREATE TEMP TABLE afap210_tmp(
     sel     LIKE type_t.chr1,
     faak000 LIKE faak_t.faak000,
     faak001 LIKE faak_t.faak001,
     faak003 LIKE faak_t.faak003,
     faak004 LIKE faak_t.faak004,
     faak019 LIKE faak_t.faak019,
     faak018 LIKE faak_t.faak018,
     faak022 LIKE faak_t.faak022,     
     produce LIKE type_t.chr1,
     pin     LIKE type_t.chr1,
     pout    LIKE type_t.chr1,  
     faah000 LIKE faah_t.faah000,
     faah002 LIKE faah_t.faah002,
     faah001 LIKE faah_t.faah001,
     faah003 LIKE faah_t.faah003,
     faah004 LIKE faah_t.faah004,
     faah014 LIKE faah_t.faah014)  #161102-00025#2 add xul  faah014 LIKE faah_t.faah014

     
    DROP TABLE afap210_01_tmp;
      CREATE TEMP TABLE afap210_01_tmp(
     flag    LIKE type_t.num5,
     faak000 LIKE faak_t.faak000,
     faak001 LIKE faak_t.faak001,
     faak003 LIKE faak_t.faak003,
     faak004 LIKE faak_t.faak004,
     faak019 LIKE faak_t.faak019,
     faak018 LIKE faak_t.faak018,
     faah018 LIKE faah_t.faah018,
     faah022 LIKE faah_t.faah022,     
     faah002 LIKE faah_t.faah002,
     faah001 LIKE faah_t.faah001,
     faah003 LIKE faah_t.faah003,
     faah004 LIKE faah_t.faah004,
     faah014 LIKE faah_t.faah014,  #161102-00025#2 add xul
     #albireo 160111-----s
     l_oofg001_t1   LIKE type_t.chr100,
     l_before_code  LIKE type_t.chr100,
     l_num_code     LIKE type_t.chr100,
     l_after_code   LIKE type_t.chr100)
     #albireo 160111-----e     
    
END FUNCTION

################################################################################
# Descriptions...: 更新tmp卡編、批號等資料
# Memo...........:
# Usage..........: CALL afap210_upd_tmp()
# Input parameter:  
# Date & Author..: 2014/8/5 By 01531
# Modify.........:
################################################################################
PRIVATE FUNCTION afap210_upd_tmp()
DEFINE  l_sql     STRING
DEFINE  l_cnt     LIKE type_t.num5
DEFINE  l_n       LIKE type_t.num5
DEFINE  l_n1      LIKE type_t.num5
DEFINE  l_faah000 LIKE faah_t.faah000
DEFINE  l_faah001 LIKE faah_t.faah001
DEFINE  l_faah003 LIKE faah_t.faah003
DEFINE  l_faah004 LIKE faah_t.faah004
DEFINE  l_faak019_1 LIKE faak_t.faak019
DEFINE  l_faak019 LIKE faak_t.faak019
DEFINE  l_faah    DYNAMIC ARRAY OF type_g_detail_d 
#161213-00015#1 add s---
DEFINE  l_flag     LIKE type_t.chr1 
DEFINE  l_glaa001  LIKE glaa_t.glaa001
DEFINE  l_glaa025  LIKE glaa_t.glaa025
DEFINE  l_glaald   LIKE glaa_t.glaald
DEFINE  l_rate     LIKE faaj_t.faaj015
#161213-00015#1 add e---
#   SELECT COUNT(*) INTO l_n FROM afap210_tmp WHERE sel = 'Y' AND pin = 'Y'
#   
#   LET l_faah000 = ''
#   LET l_faah001 = ''
#   LET l_faah003 = ''
#   LET l_faah004 = ''
#   LET l_faak019_1 = ''
#   LET l_faaK019 = ''
#   
#   #批號更新
#   LET g_sql = " SELECT * FROM afap210_tmp WHERE sel = 'Y' AND pin = 'Y' "
#   PREPARE afap210_tmp_pr3 FROM g_sql 
#   DECLARE afap210_tmp_cs3 CURSOR FOR afap210_tmp_pr3
#   
#
#   LET l_sql = " SELECT COUNT(*) FROM afap210_tmp ",
#               "  WHERE sel = 'Y' AND pin = 'Y' ",
#               "    AND faah003 = ? AND faah004 = ? AND faah001 = ? ",
#               "    AND faah000 IS NOT NULL"
#   PREPARE afap210_tmp_1 FROM l_sql 
#   
#   LET l_cnt = 0 
#   
#   LET l_n1 = 1
#   
#   FOREACH afap210_tmp_cs3 INTO l_faah[l_n1].* 
#      IF SQLCA.sqlcode THEN
#         INITIALIZE g_errparam TO NULL
#         LET g_errparam.code = SQLCA.sqlcode
#         LET g_errparam.extend = "foreach:"
#         LET g_errparam.popup = TRUE
#         CALL cl_err()
#         EXIT FOREACH
#      END IF
#
#      EXECUTE afap210_tmp_1 USING l_faah[l_n1].faah003,l_faah[l_n1].faah004,l_faah[l_n1].faah001 INTO l_cnt 
#      IF l_cnt >= 0 THEN 
#         SELECT MIN(faak000) INTO l_faah[l_n1].faah000 FROM afap210_tmp 
#          WHERE sel = 'Y' AND pin = 'Y'
#            AND faah003 = l_faah[l_n1].faah003 AND faah004 = l_faah[l_n1].faah004
#            AND faah001 = l_faah[l_n1].faah001  
#
#         UPDATE afap210_tmp SET faah000 = l_faah[l_n1].faah000
#          WHERE sel = 'Y' AND pin = 'Y'
#            AND faah003 = l_faah[l_n1].faah003 AND faah004 = l_faah[l_n1].faah004 
#            AND faah001 = l_faah[l_n1].faah001 AND faah000 IS NULL
#         IF SQLCA.sqlcode THEN
#            INITIALIZE g_errparam TO NULL
#            LET g_errparam.code = SQLCA.sqlcode
#            LET g_errparam.extend = 'update faah000 1'
#            LET g_errparam.popup = TRUE
#            CALL cl_err()                 
#         END IF     
#      END IF
#
#      LET l_n1 = l_n1 + 1
#   END FOREACH
#   
#   
#   #不同幣別，財編+附號為空
#   LET l_sql = " SELECT faah000,faah001,faah003,faah004,faak019 FROM afap210_tmp ",
#               "  WHERE sel = 'Y' AND pin = 'Y' "
#  
#   PREPARE afap210_tmp_pr1 FROM l_sql 
#   DECLARE afap210_tmp_cs1 CURSOR FOR afap210_tmp_pr1
#   
#   
#   LET l_sql = " SELECT faak019 FROM afap210_tmp ",
#               "  WHERE sel = 'Y' AND pin = 'Y' ",
#               "    AND faah003 = ? AND faah004 = ? AND faah001 = ? AND faah000 = ?"
#
#   PREPARE afap210_tmp_pr2 FROM l_sql 
#   DECLARE afap210_tmp_cs2 CURSOR FOR afap210_tmp_pr2
#   
#   FOREACH afap210_tmp_cs1 INTO l_faah000,l_faah001,l_faah003,l_faah004,l_faak019
#      IF SQLCA.sqlcode THEN
#         INITIALIZE g_errparam TO NULL
#         LET g_errparam.code = SQLCA.sqlcode
#         LET g_errparam.extend = "foreach cs1:"
#         LET g_errparam.popup = TRUE
#         CALL cl_err()
#         EXIT FOREACH
#      END IF 
#      
#      FOREACH afap210_tmp_cs2 USING l_faah003,l_faah004,l_faah001,l_faah000 INTO l_faak019_1
#         IF SQLCA.sqlcode THEN
#            INITIALIZE g_errparam TO NULL
#            LET g_errparam.code = SQLCA.sqlcode
#            LET g_errparam.extend = "foreach cs2:"
#            LET g_errparam.popup = TRUE
#            CALL cl_err()
#            EXIT FOREACH
#         END IF      
#         IF l_faak019_1 != l_faak019 THEN 
#            #合併時不同幣別，財編+附號為空
#            UPDATE afap210_tmp SET faah003 = '',
#                                   faah004 = ''
#               WHERE faah003 IS NOT NULL AND faah004 IS NOT NULL
#                 AND faah003 = l_faah003 AND faah004 = l_faah004
#                 AND faak019 = l_faak019_1 AND faah000 = l_faah000                
#            IF SQLCA.sqlcode THEN
#               INITIALIZE g_errparam TO NULL
#               LET g_errparam.code = SQLCA.sqlcode
#               LET g_errparam.extend = 'update cs2'
#               LET g_errparam.popup = TRUE
#               CALL cl_err()                 
#            END IF                  
#         END IF
#      END FOREACH       
#   END FOREACH
   
   #detail array
   #161213-00015#1 add s---
   #合并时，异币别标记
   LET g_sql = " SELECT COUNT(DISTINCT faak019)",
               "   FROM afap210_tmp ",
               "  WHERE sel = 'Y' AND pin = 'Y'"

   PREPARE afap210_pre_4 FROM g_sql
   EXECUTE afap210_pre_4 INTO l_flag
   #161213-00015#1 add e---   
   
#   LET g_sql = " SELECT * FROM afap210_tmp WHERE sel = 'Y' AND pin = 'Y' "                 #chenying mark 20141123 
   LET g_sql = " SELECT * FROM afap210_tmp WHERE sel = 'Y' AND (pin = 'Y' OR pout = 'Y' OR produce = 'Y')"   #chenying add
   
   LET g_cnt = 1 
   
   PREPARE afap210_tmp_pr FROM g_sql
   DECLARE afap210_tmp_cs CURSOR FOR afap210_tmp_pr

   FOREACH afap210_tmp_cs INTO g_tmp[g_cnt].* 
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "foreach:"
         LET g_errparam.popup = TRUE
         CALL cl_err()
         EXIT FOREACH
      END IF

      #161213-00015#1 add s---
      IF l_flag <> 1 THEN 
         IF g_tmp[g_cnt].in = 'Y' THEN 
            #归属法人主账套的本位币
            SELECT glaald,glaa001,glaa025 INTO l_glaald,l_glaa001,l_glaa025 FROM glaa_t WHERE glaaent=g_enterprise AND glaacomp=g_faak032 AND glaa014='Y'  
            #获取当前汇率
            CALL s_aooi160_get_exrate('2',l_glaald,g_today,g_tmp[g_cnt].faak019,
                                            #目的幣別          #匯類類型
                                            l_glaa001,0,l_glaa025) RETURNING l_rate 
            LET g_tmp[g_cnt].faak022 = g_tmp[g_cnt].faak022 * l_rate                                  
            LET g_tmp[g_cnt].faak019 = l_glaa001   
            UPDATE afap210_tmp SET faak022 = g_tmp[g_cnt].faak022,
                                   faak019 = g_tmp[g_cnt].faak019 
             WHERE faak001 = g_tmp[g_cnt].faak001
               AND faak003 = g_tmp[g_cnt].faak003
               AND faak004 = g_tmp[g_cnt].faak004 
               AND pin = 'Y' 
            IF SQLCA.SQLcode THEN   
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "UPD afap210_tmp1" 
               LET g_errparam.code   = SQLCA.sqlcode 
               LET g_errparam.popup  = TRUE 
               CALL cl_err()  
               RETURN               
            END IF               
         END IF
      END IF
      #161213-00015#1 add e---
   
      LET g_cnt = g_cnt + 1    
   END FOREACH
   

   
   CALL g_tmp.deleteElement(g_cnt)
   IF g_cnt > 1 THEN 
      CALL afap210_detail_display()
   END IF 
   IF g_action_choice = "exit" AND NOT cl_null(g_action_choice) THEN
      RETURN
   END IF
   
   
END FUNCTION

################################################################################
# Descriptions...: 单身資料顯示
# Memo...........:
# Usage..........: CALL afap210_detail_display()
# Input parameter:  
# Date & Author..: 2014/8/5 By 01531
# Modify.........:
################################################################################
PRIVATE FUNCTION afap210_detail_display()
   DISPLAY ARRAY g_tmp TO s_detail1.* ATTRIBUTES(COUNT=g_rec_b)

      BEFORE ROW
          LET l_ac = DIALOG.getCurrentRow("s_detail1")
          LET g_detail_idx = l_ac
          DISPLAY g_detail_idx TO h_index

       BEFORE DISPLAY
          CALL cl_set_act_visible("accept,cancel", FALSE)
          CALL FGL_SET_ARR_CURR(g_detail_idx)
          LET l_ac = DIALOG.getCurrentRow("s_detail1")
          DISPLAY g_rec_b TO h_count
 
   
      ON ACTION close
         LET g_action_choice="exit"
         LET INT_FLAG=FALSE         
         EXIT DISPLAY
         
      ON ACTION exit
         LET g_action_choice="exit"
         LET INT_FLAG = FALSE
         EXIT DISPLAY
         
      ON ACTION batch_execute
         CALL afap210_process()
         EXIT DISPLAY 
   END DISPLAY    
   
END FUNCTION

################################################################################
# Descriptions...: p處理
# Memo...........:
# Usage..........: CALL afap210_process()
# Input parameter:  
# Date & Author..: 2014/8/4 By 01531
# Modify.........:
################################################################################
PRIVATE FUNCTION afap210_process()
   DEFINE  l_success    LIKE type_t.num5
   DEFINE  l_cnt        LIKE type_t.num5  
   DEFINE  l_cnt1       LIKE type_t.num5   
   DEFINE  l_faah000    LIKE faah_t.faah000
   DEFINE  l_faah001    LIKE faah_t.faah001
   DEFINE  l_faah003    LIKE faah_t.faah003
   DEFINE  l_faah004    LIKE faah_t.faah004
   DEFINE  l_faak000    LIKE faak_t.faak000
   DEFINE  l_faak001    LIKE faak_t.faak001
   DEFINE  l_faak003    LIKE faak_t.faak003
   DEFINE  l_faak004    LIKE faak_t.faak004   
   DEFINE  l_sum        LIKE faak_t.faak022
   DEFINE  l_faak019    LIKE faak_t.faak019
   DEFINE  l_faak018    LIKE faak_t.faak018
   DEFINE  l_faah018    LIKE faah_t.faah018
   DEFINE  l_faah022    LIKE faah_t.faah022  
   #161111-00028#6 -s by 08172
#   DEFINE  l_faap       RECORD LIKE faap_t.*
#   DEFINE  l_faah       RECORD LIKE faah_t.*
#   DEFINE  l_faak       RECORD LIKE faak_t.*
   DEFINE l_faap RECORD  #底稿卡片資料記錄檔
       faapent LIKE faap_t.faapent, #企业编码
       faap000 LIKE faap_t.faap000, #底稿批号
       faap001 LIKE faap_t.faap001, #底稿卡片批号
       faap002 LIKE faap_t.faap002, #底稿编号
       faap003 LIKE faap_t.faap003, #底稿附号
       faap004 LIKE faap_t.faap004, #项目编号
       faap005 LIKE faap_t.faap005, #WBS
       faap006 LIKE faap_t.faap006, #财编批号
       faap007 LIKE faap_t.faap007, #资产卡片编号
       faap008 LIKE faap_t.faap008, #财产编号
       faap009 LIKE faap_t.faap009, #附号
       faapownid LIKE faap_t.faapownid, #资料所有者
       faapowndp LIKE faap_t.faapowndp, #资料所有部门
       faapcrtid LIKE faap_t.faapcrtid, #资料录入者
       faapcrtdp LIKE faap_t.faapcrtdp, #资料录入部门
       faapcrtdt LIKE faap_t.faapcrtdt, #资料创建日
       faapmodid LIKE faap_t.faapmodid, #资料更改者
       faapmoddt LIKE faap_t.faapmoddt, #最近更改日
       faapstus LIKE faap_t.faapstus #状态码
   END RECORD
   DEFINE l_faah RECORD  #固定資產基礎資料檔
       faahent LIKE faah_t.faahent, #企业编号
       faah000 LIKE faah_t.faah000, #生成批号
       faah001 LIKE faah_t.faah001, #卡片编号
       faah002 LIKE faah_t.faah002, #型态
       faah003 LIKE faah_t.faah003, #财产编号
       faah004 LIKE faah_t.faah004, #附号
       faah005 LIKE faah_t.faah005, #资产性质
       faah006 LIKE faah_t.faah006, #资产主要类型
       faah007 LIKE faah_t.faah007, #资产次要类型
       faah008 LIKE faah_t.faah008, #资产组
       faah009 LIKE faah_t.faah009, #供应供应商
       faah010 LIKE faah_t.faah010, #制造供应商
       faah011 LIKE faah_t.faah011, #产地
       faah012 LIKE faah_t.faah012, #名称
       faah013 LIKE faah_t.faah013, #规格型号
       faah014 LIKE faah_t.faah014, #取得日期
       faah015 LIKE faah_t.faah015, #资产状态
       faah016 LIKE faah_t.faah016, #取得方式
       faah017 LIKE faah_t.faah017, #单位
       faah018 LIKE faah_t.faah018, #数量
       faah019 LIKE faah_t.faah019, #在外数量
       faah020 LIKE faah_t.faah020, #币种
       faah021 LIKE faah_t.faah021, #原币单价
       faah022 LIKE faah_t.faah022, #原币金额
       faah023 LIKE faah_t.faah023, #本币单价
       faah024 LIKE faah_t.faah024, #本币金额
       faah025 LIKE faah_t.faah025, #保管人员
       faah026 LIKE faah_t.faah026, #保管部门
       faah027 LIKE faah_t.faah027, #存放位置
       faah028 LIKE faah_t.faah028, #存放组织
       faah029 LIKE faah_t.faah029, #负责人员
       faah030 LIKE faah_t.faah030, #管理组织
       faah031 LIKE faah_t.faah031, #核算组织
       faah032 LIKE faah_t.faah032, #归属法人
       faah033 LIKE faah_t.faah033, #直接资本化
       faah034 LIKE faah_t.faah034, #保税
       faah035 LIKE faah_t.faah035, #保险
       faah036 LIKE faah_t.faah036, #免税
       faah037 LIKE faah_t.faah037, #抵押
       faah038 LIKE faah_t.faah038, #采购单号
       faah039 LIKE faah_t.faah039, #收货单号
       faah040 LIKE faah_t.faah040, #账款单号
       faah041 LIKE faah_t.faah041, #来源营运中心
       faah042 LIKE faah_t.faah042, #资产属性
       faah043 LIKE faah_t.faah043, #预计总工作量
       faah044 LIKE faah_t.faah044, #已使用工作量
       faah045 LIKE faah_t.faah045, #账款编号项次
       faahownid LIKE faah_t.faahownid, #资料所有者
       faahowndp LIKE faah_t.faahowndp, #资料所有部门
       faahcrtid LIKE faah_t.faahcrtid, #资料录入者
       faahcrtdp LIKE faah_t.faahcrtdp, #资料录入部门
       faahcrtdt LIKE faah_t.faahcrtdt, #资料创建日
       faahmodid LIKE faah_t.faahmodid, #资料更改者
       faahmoddt LIKE faah_t.faahmoddt, #最近更改日
       faahstus LIKE faah_t.faahstus, #状态码
       faah046 LIKE faah_t.faah046, #备注
       faah047 LIKE faah_t.faah047, #保税机器截取否
       faah048 LIKE faah_t.faah048, #投资抵减状态
       faah049 LIKE faah_t.faah049, #投资抵减合并码
       faah050 LIKE faah_t.faah050, #抵减率
       faah051 LIKE faah_t.faah051, #投资抵减用途
       faah052 LIKE faah_t.faah052, #抵减金额
       faah053 LIKE faah_t.faah053, #已抵减金额
       faah054 LIKE faah_t.faah054, #投资抵减否
       faah055 LIKE faah_t.faah055, #投资抵减年限
       faah056 LIKE faah_t.faah056 #免税状态
   END RECORD
   DEFINE l_faak RECORD  #固定資產底稿資料檔
       faakent LIKE faak_t.faakent, #企业编号
       faakld LIKE faak_t.faakld, #账套别编码
       faak000 LIKE faak_t.faak000, #生成批号
       faak001 LIKE faak_t.faak001, #卡片编号
       faak002 LIKE faak_t.faak002, #型态
       faak003 LIKE faak_t.faak003, #底稿编号
       faak004 LIKE faak_t.faak004, #附号
       faak005 LIKE faak_t.faak005, #资产性质
       faak006 LIKE faak_t.faak006, #资产主要类型
       faak007 LIKE faak_t.faak007, #资产次要类型
       faak008 LIKE faak_t.faak008, #资产组
       faak009 LIKE faak_t.faak009, #供应供应商
       faak010 LIKE faak_t.faak010, #制造供应商
       faak011 LIKE faak_t.faak011, #产地
       faak012 LIKE faak_t.faak012, #名称
       faak013 LIKE faak_t.faak013, #规格型号
       faak014 LIKE faak_t.faak014, #取得日期
       faak015 LIKE faak_t.faak015, #资产状态
       faak016 LIKE faak_t.faak016, #取得方式
       faak017 LIKE faak_t.faak017, #单位
       faak018 LIKE faak_t.faak018, #数量
       faak019 LIKE faak_t.faak019, #币种
       faak020 LIKE faak_t.faak020, #汇率
       faak021 LIKE faak_t.faak021, #原币单价
       faak022 LIKE faak_t.faak022, #原币金额
       faak023 LIKE faak_t.faak023, #本币单价
       faak024 LIKE faak_t.faak024, #本币金额
       faak025 LIKE faak_t.faak025, #保管人员
       faak026 LIKE faak_t.faak026, #保管部门
       faak027 LIKE faak_t.faak027, #存放位置
       faak028 LIKE faak_t.faak028, #存放组织
       faak029 LIKE faak_t.faak029, #负责人员
       faak030 LIKE faak_t.faak030, #管理组织
       faak031 LIKE faak_t.faak031, #核算组织
       faak032 LIKE faak_t.faak032, #归属法人
       faak033 LIKE faak_t.faak033, #直接资本化
       faak034 LIKE faak_t.faak034, #入账日期
       faak035 LIKE faak_t.faak035, #保税
       faak036 LIKE faak_t.faak036, #保险
       faak037 LIKE faak_t.faak037, #免税
       faak038 LIKE faak_t.faak038, #抵押
       faak039 LIKE faak_t.faak039, #采购单号
       faak040 LIKE faak_t.faak040, #收货单号
       faak041 LIKE faak_t.faak041, #账款单号
       faak042 LIKE faak_t.faak042, #来源营运中心
       faak043 LIKE faak_t.faak043, #更新码
       faak044 LIKE faak_t.faak044, #账款编号项次
       faak045 LIKE faak_t.faak045, #杂发单号项次
       faak046 LIKE faak_t.faak046, #资产来源
       faak047 LIKE faak_t.faak047, #杂发单号
       faak048 LIKE faak_t.faak048, #凭证单号
       faak049 LIKE faak_t.faak049, #资产属性
       faak050 LIKE faak_t.faak050, #项目编号
       faak051 LIKE faak_t.faak051, #WBS
       faakownid LIKE faak_t.faakownid, #资料所有者
       faakowndp LIKE faak_t.faakowndp, #资料所有部门
       faakcrtid LIKE faak_t.faakcrtid, #资料录入者
       faakcrtdp LIKE faak_t.faakcrtdp, #资料录入部门
       faakcrtdt LIKE faak_t.faakcrtdt, #资料创建日
       faakmodid LIKE faak_t.faakmodid, #资料更改者
       faakmoddt LIKE faak_t.faakmoddt, #最近更改日
       faakstus LIKE faak_t.faakstus, #状态码
       faak052 LIKE faak_t.faak052, #抵减率
       faak053 LIKE faak_t.faak053, #投资抵减
       faak054 LIKE faak_t.faak054 #投资抵减年限
   END RECORD
   #161111-00028#6 -e by 08172
   DEFINE  l_faaj014    LIKE faaj_t.faaj014
   DEFINE  l_faaj015    LIKE faaj_t.faaj015
   DEFINE  l_glaa025    LIKE glaa_t.glaa025
   DEFINE  l_faajld     LIKE faaj_t.faajld
   DEFINE  l_year       STRING
   DEFINE  l_month      STRING
   DEFINE  l_str        STRING 
   DEFINE  l_faah002    LIKE faah_t.faah002
   #161111-00028#6 -s by 08172
#   DEFINE  l_faai       RECORD LIKE faai_t.*
   DEFINE l_faai RECORD  #固定資產標籤檔
       faaient LIKE faai_t.faaient, #企业编号
       faai000 LIKE faai_t.faai000, #生成批号
       faai001 LIKE faai_t.faai001, #卡片编号
       faai002 LIKE faai_t.faai002, #财产编号
       faai003 LIKE faai_t.faai003, #附号
       faaiseq LIKE faai_t.faaiseq, #项次
       faai004 LIKE faai_t.faai004, #财签条码
       faai005 LIKE faai_t.faai005, #S/N号码
       faai006 LIKE faai_t.faai006, #单位
       faai007 LIKE faai_t.faai007, #数量
       faai008 LIKE faai_t.faai008, #在外数量
       faai009 LIKE faai_t.faai009, #供应供应商
       faai010 LIKE faai_t.faai010, #制造供应商
       faai011 LIKE faai_t.faai011, #产地
       faai012 LIKE faai_t.faai012, #名称
       faai013 LIKE faai_t.faai013, #规格型号
       faai014 LIKE faai_t.faai014, #取得日期
       faai015 LIKE faai_t.faai015, #保管人员
       faai016 LIKE faai_t.faai016, #保管部门
       faai017 LIKE faai_t.faai017, #存放位置
       faai018 LIKE faai_t.faai018, #存放组织
       faai019 LIKE faai_t.faai019, #负责人员
       faai020 LIKE faai_t.faai020, #管理组织
       faai021 LIKE faai_t.faai021, #核算组织
       faai022 LIKE faai_t.faai022, #归属法人
       faai023 LIKE faai_t.faai023 #标签状态
   END RECORD
   #161111-00028#6 -e by 08172
   DEFINE  l_sql        STRING 
   DEFINE  l_n          LIKE type_t.num5
   DEFINE  l_pin        LIKE type_t.chr1   #150803-00002 1 add
   DEFINE  l_produce    LIKE type_t.chr1   #150803-00002 1 add
   #albireo 160111-----s
   DEFINE l_oofg001_t1  LIKE type_t.chr100
   DEFINE l_before_code LIKE type_t.chr100
   DEFINE l_num_code    LIKE type_t.chr100
   DEFINE l_after_code  LIKE type_t.chr100
   #albireo 160111-----e
   DEFINE l_faah014     LIKE faah_t.faah014  #161102-00025#2 add xul
   
   WHENEVER ERROR CONTINUE
   
   LET l_faah000 = ''
   LET l_faah001 = ''
   LET l_faah003 = ''
   LET l_faah004 = ''
   LET l_faak000 = ''
   LET l_faak001 = ''
   LET l_faak003 = ''
   LET l_faak004 = ''   
   LET l_faak018 = 0
   LET l_faak019 = ''   
   LET l_sum = 0
   LET g_faah014 = ''  #161102-00025#2 add 
 
  #CALL cl_showmsg_init()       #150731-00004#1 20150807 mark
   CALL cl_err_collect_init()   #150731-00004#1 20150807 add
   LET l_success=TRUE
   CALL s_transaction_begin()
   
   LET g_sql = " SELECT faah000,faah001,faah002,faah003,faah004,faak019,SUM(faak018),SUM(faak022),pin,produce ",
               "   FROM afap210_tmp ",
               "  WHERE sel = 'Y' AND (pin = 'Y' OR produce = 'Y')",
               "  GROUP BY faah000,faah001,faah002,faah003,faah004,faak019,pin,produce  ",
               "  ORDER BY faah000,faah001,faah002,faah003,faah004,faak019,pin,produce "

   PREPARE afap210_pre_1 FROM g_sql
   DECLARE afap210_cs_1 CURSOR FOR afap210_pre_1
   
   
   LET g_sql = " SELECT faak000,faak001,faak003,faak004,faah001,faah002,faah003,faah004,faak019,faah018,faah022, ",
               "        l_oofg001_t1,l_before_code,l_num_code,l_after_code,faah014 ",   #albireo 160111 add  #161102-00025#2 add faah014 
               "   FROM afap210_01_tmp ",
               "  ORDER BY flag "   #160426-00014#37 add lujh               

   PREPARE afap210_pre_2 FROM g_sql
   DECLARE afap210_cs_2 CURSOR FOR afap210_pre_2
   
   
   LET g_sql = " SELECT faak000,faak001,faak003,faak004 ",
               "   FROM afap210_tmp ",
               "  WHERE sel = 'Y' AND (pin = 'Y' OR produce = 'Y') ",   #20150210 add produce = 'Y'                          
               "    AND faah003 = ? AND faah004 = ? "

   PREPARE afap210_pre_3 FROM g_sql
   DECLARE afap210_cs_3 CURSOR FOR afap210_pre_3        
   

   #合併
   LET l_cnt = 0 
   SELECT COUNT(*) INTO l_cnt FROM afap210_tmp
    WHERE sel = 'Y' 
      AND (pin = 'Y' OR produce = 'Y') 
   INITIALIZE l_faah.* TO NULL
   INITIALIZE l_faak.* TO NULL
   IF l_cnt > 0 THEN 
      FOREACH afap210_cs_1 INTO l_faah000,l_faah001,l_faah002,l_faah003,l_faah004,l_faak019,l_faak018,l_sum,l_pin,l_produce
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = SQLCA.sqlcode
            LET g_errparam.extend = "foreach cs_1:"
            LET g_errparam.popup = TRUE
            CALL cl_err()
            EXIT FOREACH
         END IF
      
         IF cl_null(l_faah004) THEN LET l_faah004 = ' '  END IF 
         SELECT faak000,faak001,faak003,faak004,faah014  #161102-00025#2 add faah014
           INTO l_faak000,l_faak001,l_faak003,l_faak004,g_faah014  #161102-00025#2 add g_faah014
           FROM afap210_tmp
          WHERE faah003 = l_faah003
            AND faah004 = l_faah004
         #161111-00028#6 -s by 08172
#         SELECT * INTO l_faak.*
         SELECT faakent,  faakld,   faak000,  faak001,  faak002,
                faak003,  faak004,  faak005,  faak006,  faak007,
                faak008,  faak009,  faak010,  faak011,  faak012,
                faak013,  faak014,  faak015,  faak016,  faak017,
                faak018,  faak019,  faak020,  faak021,  faak022,
                faak023,  faak024,  faak025,  faak026,  faak027,
                faak028,  faak029,  faak030,  faak031,  faak032,
                faak033,  faak034,  faak035,  faak036,  faak037,
                faak038,  faak039,  faak040,  faak041,  faak042,
                faak043,  faak044,  faak045,  faak046,  faak047,
                faak048,  faak049,  faak050,  faak051,  faakownid,
                faakowndp,faakcrtid,faakcrtdp,faakcrtdt,faakmodid,
                faakmoddt,faakstus, faak052,  faak053,  faak054
           INTO l_faak.faakent,  l_faak.faakld,   l_faak.faak000,  l_faak.faak001,  l_faak.faak002,
                l_faak.faak003,  l_faak.faak004,  l_faak.faak005,  l_faak.faak006,  l_faak.faak007,
                l_faak.faak008,  l_faak.faak009,  l_faak.faak010,  l_faak.faak011,  l_faak.faak012,
                l_faak.faak013,  l_faak.faak014,  l_faak.faak015,  l_faak.faak016,  l_faak.faak017,
                l_faak.faak018,  l_faak.faak019,  l_faak.faak020,  l_faak.faak021,  l_faak.faak022,
                l_faak.faak023,  l_faak.faak024,  l_faak.faak025,  l_faak.faak026,  l_faak.faak027,
                l_faak.faak028,  l_faak.faak029,  l_faak.faak030,  l_faak.faak031,  l_faak.faak032,
                l_faak.faak033,  l_faak.faak034,  l_faak.faak035,  l_faak.faak036,  l_faak.faak037,
                l_faak.faak038,  l_faak.faak039,  l_faak.faak040,  l_faak.faak041,  l_faak.faak042,
                l_faak.faak043,  l_faak.faak044,  l_faak.faak045,  l_faak.faak046,  l_faak.faak047,
                l_faak.faak048,  l_faak.faak049,  l_faak.faak050,  l_faak.faak051,  l_faak.faakownid,
                l_faak.faakowndp,l_faak.faakcrtid,l_faak.faakcrtdp,l_faak.faakcrtdt,l_faak.faakmodid,
                l_faak.faakmoddt,l_faak.faakstus, l_faak.faak052,  l_faak.faak053,  l_faak.faak054
         #161111-00028#6 -e by 08172
           FROM faak_t
          WHERE faakent = g_enterprise
            AND faak000 = l_faak000
            AND faak001 = l_faak001
            AND faak003 = l_faak003
            AND faak004 = l_faak004
         LET l_faah.faahent = g_enterprise
         IF g_para_data = 'Y' THEN
            #SELECT lpad((MAX(faah001) + 1),10,'0') INTO l_faah.faah001               #161009-00006#3 mark lujh
            SELECT lpad((MAX(lpad(faah001,10,'0')) + 1),10,'0') INTO l_faah.faah001   #161009-00006#3 add lujh
              FROM faah_t
             WHERE faahent = g_enterprise
               AND faah032 = l_faak.faak032    #161009-00006#3 add lujh

            IF cl_null(l_faah.faah001) THEN
               SELECT lpad(1,10,'0') INTO l_faah.faah001
                 FROM faah_t
                WHERE faahent = g_enterprise
                  AND faah032 = l_faak.faak032    #161009-00006#3 add lujh
            END IF
         ELSE
            LET l_faah.faah001 = l_faah001
         END IF
         IF g_para_data2 = 'Y' AND l_faah.faah002 = '1' THEN          
            LET l_faah.faah003 = l_faah.faah001
         END IF
         LET l_year = YEAR(g_today)
         LET l_month = MONTH(g_today)
         IF l_month < 10 THEN
            LET l_month = '0' CLIPPED,l_month
         END IF
         LET l_str = l_year CLIPPED,l_month
         LET g_sql = "SELECT MAX(faah000) ",
                     "  FROM faah_t ",
                     " WHERE faahent = '",g_enterprise,"'",
                     "   AND faah000 LIKE '",l_str,"%'"
         PREPARE faah000_pre FROM g_sql
         EXECUTE faah000_pre INTO l_faah000
         IF cl_null(l_faah000) THEN
            LET l_faah.faah000 = l_str,'0001'
         ELSE
            LET g_sql = "SELECT lpad((lpad((substr(MAX(faah000),7,10) + 1),4,'0')),10,'",l_str,"')",
                        "  FROM faah_t ",
                        " WHERE faahent = '",g_enterprise,"'",
                        "   AND faah000 LIKE '",l_str,"%'"
            PREPARE faah000_pre1 FROM g_sql
            EXECUTE faah000_pre1 INTO l_faah.faah000
         END IF
         
         #150803-00002#1  add--str
         IF l_pin = 'Y' THEN  #若為合併
            #160525-00040#1---begin
            IF NOT cl_null(g_faah_m.faah018) OR g_faah_m.faah018<>0 THEN
               LET l_faak018 = g_faah_m.faah018
            END IF
            #160525-00040#1---end         
            LET l_faah.faah006 = g_faah_m.faah006
            LET l_faah.faah007 = g_faah_m.faah007
            SELECT faac002 INTO l_faah.faah005 FROM faac_t
             WHERE faacent = g_enterprise AND faac001 = g_faah_m.faah006
         END IF
         IF l_produce = 'Y' THEN  #若為單筆
            LET l_faah.faah005 = l_faak.faak005
            LET l_faah.faah006 = l_faak.faak006
            LET l_faah.faah007 = l_faak.faak007
         END IF
         #150803-00002#1  add--end
         
         LET l_faah.faah002 = l_faah002
         LET l_faah.faah003 = l_faah003
         LET l_faah.faah004 = l_faah004
        #LET l_faah.faah005 = l_faak.faak005    #150803-00002#1 mark
        #LET l_faah.faah006 = l_faak.faak006    #150803-00002#1 mark
        #LET l_faah.faah007 = l_faak.faak007    #150803-00002#1 mark
         LET l_faah.faah008 = l_faak.faak008
         LET l_faah.faah009 = l_faak.faak009
         LET l_faah.faah010 = l_faak.faak010
         LET l_faah.faah011 = l_faak.faak011
         LET l_faah.faah012 = l_faak.faak012
         LET l_faah.faah013 = l_faak.faak013
#         LET l_faah.faah014 = l_faak.faak014  #chenying mark 20141124
         #LET l_faah.faah014 = g_today         #chenying add   #161102-00025#2 mark xul
         LET l_faah.faah014 = g_faah014        #161102-00025#2  add  xul 
         LET l_faah.faah015 = l_faak.faak015
         LET l_faah.faah016 = l_faak.faak016
         LET l_faah.faah017 = l_faak.faak017
         LET l_faah.faah018 = l_faak018
         LET l_faah.faah019 = 0
         #LET l_faah.faah020 = l_faak.faak019 #161213-00015#1 mark
         LET l_faah.faah020 = l_faak019 #161213-00015#1 add
#         LET l_faah.faah021 = l_faak.faak021    #160525-00040#1 mark
         LET l_faah.faah021 = l_sum/l_faah.faah018    #160525-00040#1          
         LET l_faah.faah022 = l_sum
         #根据归属法人获取对应主帐套 
         SELECT UNIQUE glaald INTO l_faajld FROM glaa_t WHERE glaaent=g_enterprise AND glaacomp=l_faak.faak032 AND glaa014='Y'        
         IF cl_null(l_faajld) THEN LET l_faajld=' ' END IF
         #获取帐套使用主本币
         SELECT glaa001,glaa025 INTO l_faaj014,l_glaa025 FROM glaa_t WHERE glaald=l_faajld AND glaaent=g_enterprise   
         #获取当前汇率
         CALL s_aooi160_get_exrate('2',l_faajld,g_today,l_faah.faah020,
                                         #目的幣別          #匯類類型
                                         l_faaj014,0,l_glaa025) RETURNING l_faaj015 
         LET l_faah.faah023 = l_faah.faah021 * l_faaj015
         LET l_faah.faah024 = l_faah.faah018 * l_faah.faah023
         LET l_faah.faah025 = l_faak.faak025
         LET l_faah.faah026 = l_faak.faak026
         LET l_faah.faah027 = l_faak.faak027
         LET l_faah.faah028 = l_faak.faak028
         LET l_faah.faah029 = l_faak.faak029
         LET l_faah.faah030 = l_faak.faak030
         LET l_faah.faah031 = l_faak.faak031
         LET l_faah.faah032 = l_faak.faak032

#160408-00020#3 mod--str--
#         SELECT faac007 INTO l_faah.faah033
#           FROM faac_t
#           WHERE faacent = g_enterprise AND faac001 = l_faah.faah006 
         SELECT faac007,faac012,faac013,faac015 
           INTO l_faah.faah033,l_faah.faah054,l_faah.faah050,l_faah.faah055
           FROM faac_t
           WHERE faacent = g_enterprise AND faac001 = l_faah.faah006
#160408-00020#3 mod--end--           
           
         IF cl_null(l_faah.faah033) THEN 
            LET l_faah.faah033 = 'Y'
         END IF 
         LET l_faah.faah034 = l_faak.faak035
         LET l_faah.faah035 = l_faak.faak036
         LET l_faah.faah036 = l_faak.faak037
         LET l_faah.faah037 = l_faak.faak038
         LET l_faah.faah041 = l_faak.faak042
         LET l_faah.faah042 = l_faak.faak049
         LET l_faah.faahownid = g_user
         LET l_faah.faahowndp = g_dept
         LET l_faah.faahcrtid = g_user
         LET l_faah.faahcrtdp = g_dept
         LET l_faah.faahcrtdt = g_today
         LET l_faah.faahmodid = ''
         LET l_faah.faahmoddt = ''
         LET l_faah.faahstus = 'N'
         #160525-00040#1----begin
         CALL s_curr_round_ld('1',l_faajld,l_faah.faah020,l_faah.faah021,1) RETURNING g_sub_success,g_errno,l_faah.faah021
         CALL s_curr_round_ld('1',l_faajld,l_faah.faah020,l_faah.faah023,2) RETURNING g_sub_success,g_errno,l_faah.faah023
         CALL s_curr_round_ld('1',l_faajld,l_faaj014,l_faah.faah022,1) RETURNING g_sub_success,g_errno,l_faah.faah022
         CALL s_curr_round_ld('1',l_faajld,l_faaj014,l_faah.faah024,2) RETURNING g_sub_success,g_errno,l_faah.faah024
         #160525-00040#1----end         
         #add--2015/07/16 By shiun--(S)
         CALL s_aooi390_get_auto_no('3',l_faah.faah003) RETURNING l_success,l_faah.faah003
         IF NOT l_success THEN
            EXIT FOREACH
         END IF   
         #add--2015/07/16 By shiun--(E)
         CALL s_aooi390_oofi_upd('3',l_faah.faah003) RETURNING l_success  #add--2015/05/07 By shiun
         #161111-00028#6 -s by 08172
#         INSERT INTO faah_t VALUES(l_faah.*)

         INSERT INTO faah_t(faahent,  faah000,  faah001,  faah002,  faah003,
                            faah004,  faah005,  faah006,  faah007,  faah008,
                            faah009,  faah010,  faah011,  faah012,  faah013,
                            faah014,  faah015,  faah016,  faah017,  faah018,
                            faah019,  faah020,  faah021,  faah022,  faah023,
                            faah024,  faah025,  faah026,  faah027,  faah028,
                            faah029,  faah030,  faah031,  faah032,  faah033,
                            faah034,  faah035,  faah036,  faah037,  faah038,
                            faah039,  faah040,  faah041,  faah042,  faah043,
                            faah044,  faah045,  faahownid,faahowndp,faahcrtid,
                            faahcrtdp,faahcrtdt,faahmodid,faahmoddt,faahstus,
                            faah046,  faah047,  faah048,  faah049,  faah050,
                            faah051,  faah052,  faah053,  faah054,  faah055,
                            faah056)
                     VALUES(l_faah.faahent,  l_faah.faah000,  l_faah.faah001,  l_faah.faah002,  l_faah.faah003,
                            l_faah.faah004,  l_faah.faah005,  l_faah.faah006,  l_faah.faah007,  l_faah.faah008,
                            l_faah.faah009,  l_faah.faah010,  l_faah.faah011,  l_faah.faah012,  l_faah.faah013,
                            l_faah.faah014,  l_faah.faah015,  l_faah.faah016,  l_faah.faah017,  l_faah.faah018,
                            l_faah.faah019,  l_faah.faah020,  l_faah.faah021,  l_faah.faah022,  l_faah.faah023,
                            l_faah.faah024,  l_faah.faah025,  l_faah.faah026,  l_faah.faah027,  l_faah.faah028,
                            l_faah.faah029,  l_faah.faah030,  l_faah.faah031,  l_faah.faah032,  l_faah.faah033,
                            l_faah.faah034,  l_faah.faah035,  l_faah.faah036,  l_faah.faah037,  l_faah.faah038,
                            l_faah.faah039,  l_faah.faah040,  l_faah.faah041,  l_faah.faah042,  l_faah.faah043,
                            l_faah.faah044,  l_faah.faah045,  l_faah.faahownid,l_faah.faahowndp,l_faah.faahcrtid,
                            l_faah.faahcrtdp,l_faah.faahcrtdt,l_faah.faahmodid,l_faah.faahmoddt,l_faah.faahstus,
                            l_faah.faah046,  l_faah.faah047,  l_faah.faah048,  l_faah.faah049,  l_faah.faah050,
                            l_faah.faah051,  l_faah.faah052,  l_faah.faah053,  l_faah.faah054,  l_faah.faah055,
                            l_faah.faah056)
         #161111-00028#6 -e by 08172
#         INSERT INTO faah_t(faahent,faah000,faah001,faah003,faah004,faah020,faah018,faah022,faahstus,
#         faah014,faah015,faah025,faah026,faah028,faah029,faah030,faah031,faah032,faahownid,faahowndp,faahcrtid,faahcrtdp,faahcrtdt) 
#            VALUES(g_enterprise,l_faah000,l_faah001,l_faah003,l_faah004,l_faak019,l_faak018,l_sum,'N',
#            g_today,'0',g_user,g_dept,g_dept,g_user,g_dept,g_dept,g_dept,g_user,g_dept,g_user,g_dept,g_today) 
         
#         IF SQLCA.sqlcode THEN  #chenying mark  #20141123
         IF SQLCA.sqlcode OR SQLCA.sqlcode = 100 THEN   #chenying add 
            LET l_success = FALSE
            #150731-00004#1 20150807 str---
            #CALL cl_errmsg('ins faah',l_faah001,'N',sqlca.sqlcode,1)
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = sqlca.sqlcode
            LET g_errparam.extend = "ins faah_t:"||l_faah001
            LET g_errparam.popup = TRUE
            CALL cl_err()
            #150731-00004#1 20150807 end---
         END IF
         
         #yangtt---2015/6/9--
         #標籤明細,如果底稿中有標籤明細，則插入
         SELECT COUNT(*) INTO l_n FROM faai_t WHERE faaient = g_enterprise
           AND faai000 = l_faak000 AND faai001 = l_faak001
           AND faai002 = l_faak003 AND faai003 = l_faak004
         IF l_n > 0 THEN
            #161111-00028#6 -s by 08172
#            LET l_sql = " SELECT *  FROM faai_t ",
            LET l_sql = " SELECT faaient,faai000,faai001,faai002,faai003,
                                 faaiseq,faai004,faai005,faai006,faai007,
                                 faai008,faai009,faai010,faai011,faai012,
                                 faai013,faai014,faai015,faai016,faai017,
                                 faai018,faai019,faai020,faai021,faai022,
                                 faai023
                            FROM faai_t",
            #161111-00028#6 -e by 08172
                        "   WHERE faaient = ",g_enterprise,
                         "    AND faai000 = '",l_faak000,"' AND faai001 = '",l_faak001,"'",
                         "    AND faai002 = '",l_faak003,"' AND faai003 = '",l_faak004,"'"
            PREPARE faai_prep FROM l_sql
            DECLARE faai_curs CURSOR FOR faai_prep
            #161111-00028#6 -s by 08172
#            FOREACH faai_curs INTO l_faai.*
            FOREACH faai_curs INTO l_faai.faaient,l_faai.faai000,l_faai.faai001,l_faai.faai002,l_faai.faai003,
                                   l_faai.faaiseq,l_faai.faai004,l_faai.faai005,l_faai.faai006,l_faai.faai007,
                                   l_faai.faai008,l_faai.faai009,l_faai.faai010,l_faai.faai011,l_faai.faai012,
                                   l_faai.faai013,l_faai.faai014,l_faai.faai015,l_faai.faai016,l_faai.faai017,
                                   l_faai.faai018,l_faai.faai019,l_faai.faai020,l_faai.faai021,l_faai.faai022,
                                   l_faai.faai023
            #161111-00028#6 -e by 08172
               LET l_faai.faai000 = l_faah.faah000
               LET l_faai.faai001 = l_faah.faah001
               LET l_faai.faai002 = l_faah.faah003
               LET l_faai.faai003 = l_faah.faah004
               
               INSERT INTO faai_t
                        (faaient,
                         faai000,faai001,faai002,faai003,
                         faaiseq
                         ,faai004,faai012,faai013,faai005,faai006,faai007,faai008,faai010,faai009,faai014,faai015,faai016,faai017,faai018,faai019,faai020,faai021,faai022,faai023) 
                  VALUES(g_enterprise,
                         l_faai.faai000,l_faai.faai001,l_faai.faai002,l_faai.faai003,l_faai.faaiseq,
                         l_faai.faai004,l_faai.faai012,l_faai.faai013, 
                         l_faai.faai005,l_faai.faai006,l_faai.faai007, 
                         l_faai.faai008,l_faai.faai010,l_faai.faai009, 
                         l_faai.faai014,l_faai.faai015,l_faai.faai016, 
                         l_faai.faai017,l_faai.faai018,l_faai.faai019, 
                         l_faai.faai020,l_faai.faai021,l_faai.faai022, 
                         l_faai.faai023)
               
               IF SQLCA.sqlcode OR SQLCA.sqlcode = 100 THEN
                  LET l_success = FALSE
                  #150731-00004#1 20150807 str---
                  #CALL cl_errmsg('ins faai',l_faah001,'N',sqlca.sqlcode,1)
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = sqlca.sqlcode
                  LET g_errparam.extend = "ins faai_t:"||l_faah001
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
                  #150731-00004#1 20150807 end---
               END IF

            END FOREACH
        END IF
        #yangtt---2015/6/9--
            
            
         FOREACH afap210_cs_3 USING l_faah003,l_faah004 
            INTO l_faak000,l_faak001,l_faak003,l_faak004
            IF SQLCA.sqlcode THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = SQLCA.sqlcode
               LET g_errparam.extend = "foreach cs_3:"
               LET g_errparam.popup = TRUE
               CALL cl_err()
               EXIT FOREACH
            END IF  

            LET l_faap.faapownid = g_user
            LET l_faap.faapowndp = g_dept
            LET l_faap.faapcrtid = g_user
            LET l_faap.faapcrtdp = g_dept 
            LET l_faap.faapcrtdt = cl_get_current()
            LET l_faap.faapmodid = ""
            LET l_faap.faapmoddt = ""
         IF cl_null(l_faak004) THEN LET l_faak004 = ' ' END IF  #chenying add 20141123  
         IF cl_null(l_faah004) THEN LET l_faah004 = ' ' END IF  #chenying add 20141123              
         
            INSERT INTO faap_t(faapent,faap000,faap001,faap002,faap003,faap006,faap007,faap008,faap009,
                               faapownid,faapowndp,faapcrtid,faapcrtdp,faapcrtdt,faapmodid,faapmoddt,faapstus)
                        VALUES(g_enterprise,l_faak000,l_faak001,l_faak003,l_faak004,l_faah.faah000,l_faah.faah001,l_faah.faah003,l_faah004,    #l_faah003 >>>> l_faah.faah003   #151222-00006#1
                               l_faap.faapownid,l_faap.faapowndp,l_faap.faapcrtid,l_faap.faapcrtdp,l_faap.faapcrtdt,l_faap.faapmodid,
                               l_faap.faapmoddt,'Y')
            IF SQLCA.sqlcode THEN
               LET l_success = FALSE
               #150731-00004#1 20150807 str---
               #CALL cl_errmsg('ins faap',l_faah001,'N',sqlca.sqlcode,1)
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = sqlca.sqlcode
               LET g_errparam.extend = "ins faap_t:"||l_faah001
               LET g_errparam.popup = TRUE
               CALL cl_err()
               #150731-00004#1 20150807 end---
            END IF 
            UPDATE faak_t SET faak043 = 'Y'
                        WHERE faakent = g_enterprise
                          AND faak000 = l_faak000
                          AND faak001 = l_faak001
                          AND faak003 = l_faak003
                          AND faak004 = l_faak004
                          AND faak043 = 'N'
            IF SQLCA.sqlcode THEN
               LET l_success = FALSE
               #150731-00004#1 20150807 str---
               #CALL cl_errmsg('upd faak',l_faak001,'N',sqlca.sqlcode,1)
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = sqlca.sqlcode
               LET g_errparam.extend = "upd faak_t:"||l_faak001
               LET g_errparam.popup = TRUE
               CALL cl_err()
               #150731-00004#1 20150807 end---
            END IF                           
          END FOREACH            
          CALL afap210_get_deault_value(l_faak000,l_faak001,l_faak003,l_faak004,l_faah.faah000,l_faah.faah001,l_faah003,l_faah004,l_pin,l_produce)
       END FOREACH         
   END IF   
   
   #分割 
   LET l_cnt1 = 0

   LET l_faah000 = ''
   LET l_faah001 = ''
   LET l_faah003 = ''
   LET l_faah004 = ''
   LET l_faah018 = 0
   LET l_faak019 = '' 
   LET l_faah022 = 0
   
   SELECT COUNT(*) INTO l_cnt1 FROM afap210_01_tmp
   INITIALIZE l_faah.* TO NULL
   INITIALIZE l_faak.* TO NULL
   IF l_cnt1 > 0 THEN 
      FOREACH afap210_cs_2 INTO l_faak000,l_faak001,l_faak003,l_faak004,l_faah001,l_faah002,l_faah003,l_faah004,l_faak019,l_faah018,l_faah022,
                                l_oofg001_t1,l_before_code,l_num_code,l_after_code,l_faah014   #albireo 160111 add  #161102-00025#2 add l_faah014
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = SQLCA.sqlcode
            LET g_errparam.extend = "foreach cs_2:"
            LET g_errparam.popup = TRUE
            CALL cl_err()
            EXIT FOREACH
         END IF      
         #161111-00028#6 -s by 08172
#         SELECT * INTO l_faak.*
         SELECT faakent,  faakld,   faak000,  faak001,  faak002,
                faak003,  faak004,  faak005,  faak006,  faak007,
                faak008,  faak009,  faak010,  faak011,  faak012,
                faak013,  faak014,  faak015,  faak016,  faak017,
                faak018,  faak019,  faak020,  faak021,  faak022,
                faak023,  faak024,  faak025,  faak026,  faak027,
                faak028,  faak029,  faak030,  faak031,  faak032,
                faak033,  faak034,  faak035,  faak036,  faak037,
                faak038,  faak039,  faak040,  faak041,  faak042,
                faak043,  faak044,  faak045,  faak046,  faak047,
                faak048,  faak049,  faak050,  faak051,  faakownid,
                faakowndp,faakcrtid,faakcrtdp,faakcrtdt,faakmodid,
                faakmoddt,faakstus, faak052,  faak053,  faak054
           INTO l_faak.faakent,  l_faak.faakld,   l_faak.faak000,  l_faak.faak001,  l_faak.faak002,
                l_faak.faak003,  l_faak.faak004,  l_faak.faak005,  l_faak.faak006,  l_faak.faak007,
                l_faak.faak008,  l_faak.faak009,  l_faak.faak010,  l_faak.faak011,  l_faak.faak012,
                l_faak.faak013,  l_faak.faak014,  l_faak.faak015,  l_faak.faak016,  l_faak.faak017,
                l_faak.faak018,  l_faak.faak019,  l_faak.faak020,  l_faak.faak021,  l_faak.faak022,
                l_faak.faak023,  l_faak.faak024,  l_faak.faak025,  l_faak.faak026,  l_faak.faak027,
                l_faak.faak028,  l_faak.faak029,  l_faak.faak030,  l_faak.faak031,  l_faak.faak032,
                l_faak.faak033,  l_faak.faak034,  l_faak.faak035,  l_faak.faak036,  l_faak.faak037,
                l_faak.faak038,  l_faak.faak039,  l_faak.faak040,  l_faak.faak041,  l_faak.faak042,
                l_faak.faak043,  l_faak.faak044,  l_faak.faak045,  l_faak.faak046,  l_faak.faak047,
                l_faak.faak048,  l_faak.faak049,  l_faak.faak050,  l_faak.faak051,  l_faak.faakownid,
                l_faak.faakowndp,l_faak.faakcrtid,l_faak.faakcrtdp,l_faak.faakcrtdt,l_faak.faakmodid,
                l_faak.faakmoddt,l_faak.faakstus, l_faak.faak052,  l_faak.faak053,  l_faak.faak054
         #161111-00028#6 -e by 08172
           FROM faak_t
          WHERE faakent = g_enterprise
            AND faak000 = l_faak000
            AND faak001 = l_faak001
            AND faak003 = l_faak003
            AND faak004 = l_faak004         
         LET l_faah.faahent = g_enterprise
         IF g_para_data = 'Y' THEN
            #160426-00014#37--mark--str--lujh
            #SELECT lpad((MAX(faah001) + 1),10,'0') INTO l_faah.faah001
            #  FROM faah_t
            # WHERE faahent = g_enterprise
            #160426-00014#37--mark--end--lujh
            
            #160426-00014#37--add--str--lujh
            SELECT lpad((MAX(lpad(faah001,10,'0')) + 1),10,'0') INTO l_faah.faah001
              FROM faah_t
             WHERE faahent = g_enterprise
               AND faah032 = l_faak.faak032    #161009-00006#3 add lujh
            #160426-00014#37--add--end--lujh

            IF cl_null(l_faah.faah001) THEN
               SELECT lpad(1,10,'0') INTO l_faah.faah001
                 FROM faah_t
                WHERE faahent = g_enterprise
                  AND faah032 = l_faak.faak032    #161009-00006#3 add lujh
            END IF
         ELSE
            LET l_faah.faah001 = l_faah001
         END IF
         IF g_para_data2 = 'Y' AND l_faah.faah002 = '1' THEN          
            LET l_faah.faah003 = l_faah.faah001
         END IF
         LET l_year = YEAR(g_today)
         LET l_month = MONTH(g_today)
         IF l_month < 10 THEN
            LET l_month = '0' CLIPPED,l_month
         END IF
         LET l_str = l_year CLIPPED,l_month
         LET g_sql = "SELECT MAX(faah000) ",
                     "  FROM faah_t ",
                     " WHERE faahent = '",g_enterprise,"'",
                     "   AND faah000 LIKE '",l_str,"%'"
         PREPARE faah000_pre2 FROM g_sql
         EXECUTE faah000_pre2 INTO l_faah000
         IF cl_null(l_faah000) THEN
            LET l_faah.faah000 = l_str,'0001'
         ELSE
            LET g_sql = "SELECT lpad((lpad((substr(MAX(faah000),7,10) + 1),4,'0')),10,'",l_str,"')",
                        "  FROM faah_t ",
                        " WHERE faahent = '",g_enterprise,"'",
                        "   AND faah000 LIKE '",l_str,"%'"
            PREPARE faah000_pre3 FROM g_sql
            EXECUTE faah000_pre3 INTO l_faah.faah000
         END IF
         LET l_faah.faah002 = l_faah002
         LET l_faah.faah003 = l_faah003
         IF cl_null(l_faah004) THEN LET l_faah004=' ' END IF
         LET l_faah.faah004 = l_faah004
         LET l_faah.faah005 = l_faak.faak005
         LET l_faah.faah006 = l_faak.faak006
         LET l_faah.faah007 = l_faak.faak007
         LET l_faah.faah008 = l_faak.faak008
         LET l_faah.faah009 = l_faak.faak009
         LET l_faah.faah010 = l_faak.faak010
         LET l_faah.faah011 = l_faak.faak011
         LET l_faah.faah012 = l_faak.faak012
         LET l_faah.faah013 = l_faak.faak013
#         LET l_faah.faah014 = l_faak.faak014  #chenying mark 20141124
        #LET l_faah.faah014 = g_today          #chenying add   #161102-00025#2 mark xul  
         #161102-00025#2--add--s--
         LET l_faah.faah014 = l_faah014
         LET g_faah014 = l_faah014
         #161102-00025#2--add--e--
         LET l_faah.faah015 = l_faak.faak015
         LET l_faah.faah016 = l_faak.faak016
         LET l_faah.faah017 = l_faak.faak017
         LET l_faah.faah018 = l_faah018
         LET l_faah.faah019 = 0
         LET l_faah.faah020 = l_faak019
         LET l_faah.faah021 = l_faak.faak021
         LET l_faah.faah022 = l_faah022
         LET l_faah.faah023 = l_faak.faak023
         #LET l_faah.faah024 = l_faak.faak024    ##151222-00006#1 mark
         #albireo 151222   #151222-00006#1-----s
         LET l_faah.faah024 = l_faah022*l_faak.faak020   
         
         #根据归属法人获取对应主帐套
         SELECT UNIQUE glaald INTO l_faajld FROM glaa_t WHERE glaaent=g_enterprise AND glaacomp=l_faak.faak032 AND glaa014='Y'
         IF cl_null(l_faajld) THEN LET l_faajld=' ' END IF
         #获取帐套使用主本币
         SELECT glaa001,glaa025 INTO l_faaj014,l_glaa025 FROM glaa_t WHERE glaald=l_faajld AND glaaent=g_enterprise
         CALL s_curr_round_ld('1',l_faajld,l_faaj014,l_faah.faah024,2) RETURNING g_sub_success,g_errno,l_faah.faah024
         #albireo 151222   #151222-00006#1-----e
         LET l_faah.faah025 = l_faak.faak025
         LET l_faah.faah026 = l_faak.faak026
         LET l_faah.faah027 = l_faak.faak027
         LET l_faah.faah028 = l_faak.faak028
         LET l_faah.faah029 = l_faak.faak029
         LET l_faah.faah030 = l_faak.faak030
         LET l_faah.faah031 = l_faak.faak031
         LET l_faah.faah032 = l_faak.faak032
         LET l_faah.faah033 = l_faak.faak033
         LET l_faah.faah034 = l_faak.faak035
         LET l_faah.faah035 = l_faak.faak036
         LET l_faah.faah036 = l_faak.faak037
         LET l_faah.faah037 = l_faak.faak038
         LET l_faah.faah041 = l_faak.faak042
         LET l_faah.faah042 = l_faak.faak049   ##151222-00006#1 add
         LET l_faah.faahownid = g_user
         LET l_faah.faahowndp = g_dept
         LET l_faah.faahcrtid = g_user
         LET l_faah.faahcrtdp = g_dept
         LET l_faah.faahcrtdt = g_today
         LET l_faah.faahmodid = ''
         LET l_faah.faahmoddt = ''
         LET l_faah.faahstus = 'N'
         #albireo 151022-----s
         LET l_faah.faah038 = l_faak.faak039
         LET l_faah.faah039 = l_faak.faak040
         LET l_faah.faah040 = l_faak.faak041
         #albireo 151022-----e
         
         #160408-00020#3 add--str--
         SELECT faac012,faac013,faac015 
           INTO l_faah.faah054,l_faah.faah050,l_faah.faah055
           FROM faac_t
           WHERE faacent = g_enterprise AND faac001 = l_faah.faah006
         #160408-00020#3 add--end--             
         
         #add--2015/07/16 By shiun--(S)
         #albireo 160111-----s
         LET g_oofg001_t1  = l_oofg001_t1
         LET g_before_code = l_before_code
         LET g_num_code    = l_num_code
         LET g_after_code  = l_after_code
         #albireo 160111-----e
         #CALL s_aooi390_get_auto_no('3',l_faah.faah003) RETURNING l_success,l_faah.faah003   #151225-00014#1 mark
         
         #151225-00014#1 modify-----s
         CALL s_aooi390_get_auto_no_for_successive('3',l_faah.faah003, 
                                               l_oofg001_t1,
                                               l_before_code, 
                                               l_num_code, 
                                               l_after_code)
          RETURNING l_success,l_faah.faah003 
          
         #151225-00014#1 modify-----e 
         IF NOT l_success THEN
            EXIT FOREACH
         END IF   
         #add--2015/07/16 By shiun--(E)
         CALL s_aooi390_oofi_upd('3',l_faah.faah003) RETURNING l_success  #add--2015/05/07 By shiun
         #161111-00028#6 -s by 08172
#         INSERT INTO faah_t VALUES(l_faah.*)
         INSERT INTO faah_t(faahent,  faah000,  faah001,  faah002,  faah003,
                            faah004,  faah005,  faah006,  faah007,  faah008,
                            faah009,  faah010,  faah011,  faah012,  faah013,
                            faah014,  faah015,  faah016,  faah017,  faah018,
                            faah019,  faah020,  faah021,  faah022,  faah023,
                            faah024,  faah025,  faah026,  faah027,  faah028,
                            faah029,  faah030,  faah031,  faah032,  faah033,
                            faah034,  faah035,  faah036,  faah037,  faah038,
                            faah039,  faah040,  faah041,  faah042,  faah043,
                            faah044,  faah045,  faahownid,faahowndp,faahcrtid,
                            faahcrtdp,faahcrtdt,faahmodid,faahmoddt,faahstus,
                            faah046,  faah047,  faah048,  faah049,  faah050,
                            faah051,  faah052,  faah053,  faah054,  faah055,
                            faah056)
                     VALUES(l_faah.faahent,  l_faah.faah000,  l_faah.faah001,  l_faah.faah002,  l_faah.faah003,
                            l_faah.faah004,  l_faah.faah005,  l_faah.faah006,  l_faah.faah007,  l_faah.faah008,
                            l_faah.faah009,  l_faah.faah010,  l_faah.faah011,  l_faah.faah012,  l_faah.faah013,
                            l_faah.faah014,  l_faah.faah015,  l_faah.faah016,  l_faah.faah017,  l_faah.faah018,
                            l_faah.faah019,  l_faah.faah020,  l_faah.faah021,  l_faah.faah022,  l_faah.faah023,
                            l_faah.faah024,  l_faah.faah025,  l_faah.faah026,  l_faah.faah027,  l_faah.faah028,
                            l_faah.faah029,  l_faah.faah030,  l_faah.faah031,  l_faah.faah032,  l_faah.faah033,
                            l_faah.faah034,  l_faah.faah035,  l_faah.faah036,  l_faah.faah037,  l_faah.faah038,
                            l_faah.faah039,  l_faah.faah040,  l_faah.faah041,  l_faah.faah042,  l_faah.faah043,
                            l_faah.faah044,  l_faah.faah045,  l_faah.faahownid,l_faah.faahowndp,l_faah.faahcrtid,
                            l_faah.faahcrtdp,l_faah.faahcrtdt,l_faah.faahmodid,l_faah.faahmoddt,l_faah.faahstus,
                            l_faah.faah046,  l_faah.faah047,  l_faah.faah048,  l_faah.faah049,  l_faah.faah050,
                            l_faah.faah051,  l_faah.faah052,  l_faah.faah053,  l_faah.faah054,  l_faah.faah055,
                            l_faah.faah056)
         #161111-00028#6 -e by 08172
#         INSERT INTO faah_t(faahent,faah000,faah001,faah003,faah004,faah020,faah018,faah022,faahstus,
#          faah014,faah015,faah025,faah026,faah028,faah029,faah030,faah031,faah032,faahownid,faahowndp,faahcrtid,faahcrtdp,faahcrtdt) 
#            VALUES(g_enterprise,l_faah000,l_faah001,l_faah003,l_faah004,l_faak019,l_faah018,l_faah022,'N',
#            g_today,'0',g_user,g_dept,g_dept,g_user,g_dept,g_dept,g_dept,g_user,g_dept,g_user,g_dept,g_today) 
         
#         IF SQLCA.sqlcode THEN                         #cheniyng mark
          IF SQLCA.sqlcode OR SQLCA.sqlcode = 100 THEN  #chenying add 20141123
            LET l_success = FALSE
            #150731-00004#1 20150807 str---
            #CALL cl_errmsg('ins faah 1',l_faah001,'N',sqlca.sqlcode,1)
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = sqlca.sqlcode
            LET g_errparam.extend = "ins faah 1:"||l_faah001
            LET g_errparam.popup = TRUE
            CALL cl_err()
            #150731-00004#1 20150807 end---
         END IF

         LET l_faap.faapownid = g_user
         LET l_faap.faapowndp = g_dept
         LET l_faap.faapcrtid = g_user
         LET l_faap.faapcrtdp = g_dept 
         LET l_faap.faapcrtdt = cl_get_current()
         LET l_faap.faapmodid = ""
         LET l_faap.faapmoddt = ""
         
         IF cl_null(l_faak004) THEN LET l_faak004 = ' ' END IF  #chenying add 20141123  
         IF cl_null(l_faah004) THEN LET l_faah004 = ' ' END IF  #chenying add 20141123    
         INSERT INTO faap_t(faapent,faap000,faap001,faap002,faap003,faap006,faap007,faap008,faap009,
                            faapownid,faapowndp,faapcrtid,faapcrtdp,faapcrtdt,faapmodid,faapmoddt,faapstus)
                     VALUES(g_enterprise,l_faak000,l_faak001,l_faak003,l_faak004,l_faah.faah000,l_faah.faah001,l_faah.faah003,l_faah004,   #l_faah003>>>l_faah.faah003   #151222-00006#1
                            l_faap.faapownid,l_faap.faapowndp,l_faap.faapcrtid,l_faap.faapcrtdp,l_faap.faapcrtdt,l_faap.faapmodid,
                            l_faap.faapmoddt,'Y')
         IF SQLCA.sqlcode THEN
            LET l_success = FALSE
            #150731-00004#1 20150807 str---
            #CALL cl_errmsg('ins faap',l_faah001,'N',sqlca.sqlcode,1)
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = sqlca.sqlcode
            LET g_errparam.extend = "ins faap:"||l_faah001
            LET g_errparam.popup = TRUE
            CALL cl_err()
            #150731-00004#1 20150807 end---
         END IF  
         CALL afap210_get_deault_value(l_faak000,l_faak001,l_faak003,l_faak004,l_faah.faah000,l_faah.faah001,l_faah.faah003,l_faah004,'N','N')   ##151222-00006#1 l_faah003>>>>l_faah.faah003
         UPDATE faak_t SET faak043 = 'Y'
                     WHERE faakent = g_enterprise
                       AND faak000 = l_faak000
                       AND faak001 = l_faak001
                       AND faak003 = l_faak003
                       AND faak004 = l_faak004
                       AND faak043 = 'N'
         IF SQLCA.sqlcode THEN
            LET l_success = FALSE
            #150731-00004#1 20150807 str---
            #CALL cl_errmsg('upd faak',l_faak001,'N',sqlca.sqlcode,1)
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = sqlca.sqlcode
            LET g_errparam.extend = "upd faak:"||l_faak001
            LET g_errparam.popup = TRUE
            CALL cl_err()
            #150731-00004#1 20150807 end---
         END IF 
            
      END FOREACH           
   END IF 
   
   IF l_success = FALSE  THEN
      #CALL cl_err_showmsg()       #150731-00004#1 20150807 mark
      CALL cl_err_collect_show()   #150731-00004#1 20150807 add
      CALL s_transaction_end('N','0') 
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'adz-00218'
      LET g_errparam.extend = ''
      LET g_errparam.popup = TRUE
      CALL cl_err()
      RETURN    
   ELSE
      CALL cl_err_collect_show()   #150921
      CALL s_transaction_end('Y','0')
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'adz-00217'
      LET g_errparam.extend = ''
      LET g_errparam.popup = TRUE
      CALL cl_err()      
   END IF 
END FUNCTION

################################################################################
# Descriptions...: 分割資料新增tmp
# Memo...........:
# Usage..........: CALL afap210_01_ins(p_faak000,p_faak001,p_faak003,p_faak004,p_faak019,p_faak018)
# Input parameter:  
# Date & Author..: 2014/8/6 By 01531
# Modify.........:
################################################################################
PRIVATE FUNCTION afap210_01_ins(p_faak000,p_faak001,p_faak003,p_faak004,p_faak019,p_faak018)
DEFINE p_faak000 LIKE faak_t.faak000
DEFINE p_faak001 LIKE faak_t.faak001
DEFINE p_faak003 LIKE faak_t.faak003
DEFINE p_faak004 LIKE faak_t.faak004
DEFINE p_faak019 LIKE faak_t.faak019
DEFINE p_faak018 LIKE faak_t.faak018
DEFINE i         LIKE type_t.num5
DEFINE l_faak022 LIKE faak_t.faak022
DEFINE l_faah018 LIKE faah_t.faah018
DEFINE l_faah022 LIKE faah_t.faah022
DEFINE l_faak022_1 LIKE faak_t.faak022
DEFINE l_faah022_t LIKE faah_t.faah022
DEFINE l_faah001  LIKE faah_t.faah001
DEFINE l_ld      LIKE faaj_t.faajld  #161227-00026#1 add
DEFINE l_success LIKE type_t.num5    #161227-00026#1 add

   LET l_faak022 = 0
   LET l_faah022 = 0
   LET l_faah018 = 0
   LET l_faak022_1 = 0
   LET l_faah001 = ''
   
#   LET l_faah022_t = p_faak018 - l_faah022
   
   #删除临时表已存在的资料
   DELETE FROM afap210_01_tmp
    WHERE faak000 = p_faak000
      AND faak001 = p_faak001
      AND faak003 = p_faak003
      AND faak004 = p_faak004
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.extend = "DEL afap210_01_tmp"
      LET g_errparam.code   = SQLCA.sqlcode
      LET g_errparam.popup  = TRUE
      CALL cl_err()
      RETURN
   END IF
   
   #161009-00006#3--add--str--lujh
   SELECT faak032 INTO g_faak032
     FROM faak_t
    WHERE faakent = g_enterprise
      AND faak000 = p_faak000
      AND faak001 = p_faak001
      AND faak003 = p_faak003
      AND faak004 = p_faak004
   #161009-00006#3--add--end--lujh
   
   CALL afap210_get_faah001() RETURNING l_faah001
    
   SELECT faak022 INTO l_faak022 FROM faak_t 
    WHERE faakent = g_enterprise
      AND faakstus = 'Y' AND faak043 = 'N' 
      AND faak000 = p_faak000
      AND faak001 = p_faak001
      AND faak003 = p_faak003
      AND faak004 = p_faak004
      
   LET l_faah022_t = l_faak022 #20141123 chenying add #总金额备份 
   SELECT UNIQUE glaald INTO l_ld FROM glaa_t WHERE glaaent=g_enterprise AND glaacomp=g_faak032 AND glaa014='Y' #161227-00026#1 add     
   IF p_faak018 = 0 THEN
      LET l_faah018 = 1
      LET l_faah022 = l_faak022
      LET l_faah001 = l_faah001+1 USING '&&&&&&&&&&' 
      #161102-00025#2--mark--s--
#      INSERT INTO afap210_01_tmp VALUES(1,'Y',p_faak000,p_faak001,p_faak003,p_faak004,p_faak019,p_faak018,'N','Y',
#                                         1,l_faah022,p_faak000,l_faah001,'',' ')
      #161102-00025#2--mark--e--                                   
      #161102-00025#2--add--s--
      INSERT INTO afap210_01_tmp VALUES(1,'Y',p_faak000,p_faak001,p_faak003,p_faak004,p_faak019,p_faak018,'N','Y',
                                         1,l_faah022,p_faak000,l_faah001,'',' ',g_today,'','','','')    
      #161102-00025#2--add--e--                                         
   ELSE   
      LET l_faak022_1 = l_faak022 / p_faak018      
#      LET l_faah022_t = l_faak022  #chenying mark
      FOR i = 1 TO p_faak018
          LET l_faah018 = 1
          #LET l_faah022 = s_num_round('3',l_faak022_1,0)  #161227-00026#1 mark
          CALL s_curr_round_ld('3',l_ld,p_faak019,l_faak022_1,2)   #161227-00026#1 add
              RETURNING l_success,g_errno,l_faah022                #161227-00026#1 add          
          IF i = p_faak018 THEN 
#             LET l_faah022 = l_faah022_t - (i-1)*l_faak022_1 #20141123 chenying mark
             #LET l_faah022 = l_faak022 - (i-1)*l_faak022_1  #20141123 chenying add #用总金额去减 #161227-00026#1 mark
             LET l_faah022 = l_faah022_t                      #161227-00026#1 add
             #LET l_faah022 = s_num_round('3',l_faah022,0)    #161227-00026#1 mark
             CALL s_curr_round_ld('3',l_ld,p_faak019,l_faah022,2)   #161227-00026#1 add
                 RETURNING l_success,g_errno,l_faah022                #161227-00026#1 add
          ELSE
#             LET l_faah022_t = l_faah022_t - l_faah022
             LET l_faah022_t = l_faah022_t - l_faah022  #20141123 chenying add #循环得到剩余金额    
          END IF  
 
          LET l_faah001 = l_faah001+1 USING '&&&&&&&&&&'
          
          #160426-00014#37--mark--str--lujh
          #INSERT INTO afap210_01_tmp VALUES(i,'Y',p_faak000,p_faak001,p_faak003,p_faak004,p_faak019,p_faak018,'N','Y',
          #                                   l_faah018,l_faah022,p_faak000,l_faah001,'',' ')
          #160426-00014#37--mark--end--lujh
          #161102-00025#2--mark--s--xul
          #160426-00014#37--add--str--lujh
#          INSERT INTO afap210_01_tmp VALUES(i,p_faak000,p_faak001,p_faak003,p_faak004,p_faak019,p_faak018,l_faah018,
#                                            l_faah022,'1',l_faah001,'',' ','','','','')
          #160426-00014#37--add--end--lujh
          #161102-00025#2--mark--e--xul
          #161102-00025#2--add--s--xul
           INSERT INTO afap210_01_tmp VALUES(i,p_faak000,p_faak001,p_faak003,p_faak004,p_faak019,p_faak018,l_faah018,
                                            l_faah022,'1',l_faah001,'',' ',g_today,'','','','')
          #161102-00025#2--add--e--xul
      END FOR
   END IF    

END FUNCTION

################################################################################
# Descriptions...: 卡片編號
# Memo...........:
# Usage..........: CALL afap210_get_faah001()
# Input parameter:  
# Date & Author..: 2014/8/6 By 01531
# Modify.........:
################################################################################
PRIVATE FUNCTION afap210_get_faah001()
   DEFINE l_ooab002     LIKE ooab_t.ooab002
   DEFINE l_max_faah001 LIKE faah_t.faah001
   DEFINE l_faah001     LIKE faah_t.faah001
   DEFINE l_faah001_1   LIKE faah_t.faah001

    #檢查tmp中是否存在已有最大的卡片編號
    #是否自動編號 S-FIN-9005
#    SELECT ooab002 INTO l_ooab002 FROM ooab_t
#     WHERE ooabent = g_enterprise
#       AND ooab001 = 'S-FIN-9005'
#       AND ooabsite = g_site

    SELECT lpad((MAX(faah001) + 1),10,'0') INTO l_max_faah001 FROM afap210_tmp
    SELECT lpad((MAX(faah001) + 1),10,'0') INTO l_faah001_1 FROM afap210_01_tmp

    IF l_max_faah001 IS NULL AND l_faah001_1 IS NULL THEN
       SELECT lpad((MAX(faah001) + 1),10,'0') INTO l_max_faah001
         FROM faah_t
        WHERE faahent = g_enterprise
          AND faah032 = g_faak032    #161009-00006#3 add lujh
        LET l_faah001 = l_max_faah001
    ELSE
       IF l_max_faah001 IS NULL AND l_faah001_1 IS NOT NULL THEN
          LET l_faah001 = l_faah001_1
       END IF
       IF l_max_faah001 IS NOT NULL AND l_faah001_1 IS NULL THEN
          LET l_faah001 = l_max_faah001
       END IF
       IF l_max_faah001 IS NOT NULL AND l_faah001_1 IS NOT NULL THEN
          IF l_max_faah001 > l_faah001_1 THEN
             LET l_faah001 = l_max_faah001
          ELSE
             LET l_faah001 = l_faah001_1
          END IF
       END IF
    END IF
    IF cl_null(l_faah001) THEN 
       SELECT lpad(1,10,'0') INTO l_faah001
         FROM faah_t
        WHERE faahent = g_enterprise
    END IF 
    RETURN l_faah001
END FUNCTION

################################################################################
# Descriptions...:  
# Memo...........:
# Usage..........: CALL afap210_ui_dialog_1()
# Input parameter:  
# Date & Author..: 2014/08/29 By 01531
# Modify.........:
################################################################################
PRIVATE FUNCTION afap210_ui_dialog_1()
   DEFINE li_idx   LIKE type_t.num5
   #add-point:ui_dialog段define
   DEFINE l_ooab002     LIKE ooab_t.ooab002
   DEFINE l_max_faah001 LIKE faah_t.faah001
   DEFINE l_cnt         LIKE type_t.num5 
   DEFINE l_n           LIKE type_t.num5
   DEFINE l_faah001     LIKE faah_t.faah001
   DEFINE l_c           LIKE type_t.num5
   #end add-point 
 
   LET gwin_curr = ui.Window.getCurrent()
   LET gfrm_curr = gwin_curr.getForm()   
   
   LET g_action_choice = " "  
   CALL cl_set_act_visible("accept,cancel", FALSE)
         
   LET g_detail_cnt = g_detail_d.getLength()
   #add-point:ui_dialog段before dialog 
   CALL afap210_create_tmp()
   
   
   WHILE TRUE
      CALL g_detail_d.clear()
      CALL cl_dlg_query_bef_disp()  #相關查詢
 
      DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
         #add-point:ui_dialog段construct
               
         #end add-point
         #add-point:ui_dialog段input
         INPUT ARRAY g_detail_d FROM s_detail1.*
            ATTRIBUTE(COUNT = g_rec_b,MAXCOUNT = g_max_rec,WITHOUT DEFAULTS, 
                      INSERT ROW = FALSE, 
                      DELETE ROW = FALSE,
                      APPEND ROW = TRUE)
                    
            BEFORE INPUT

            BEFORE ROW
                         
                LET l_ac = ARR_CURR()
               
            
               
            ON CHANGE sel
           
               IF g_detail_d[l_ac].sel = 'Y' THEN 
                  UPDATE afap210_tmp SET sel = 'Y' 
                   WHERE faak000 = g_detail_d[l_ac].faak000
                     AND faak001 = g_detail_d[l_ac].faak001
                     AND faak003 = g_detail_d[l_ac].faak003
                     AND faak004 = g_detail_d[l_ac].faak004
                  IF SQLCA.sqlcode THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.extend = "UPD afap210_tmp"
                     LET g_errparam.code   = SQLCA.sqlcode
                     LET g_errparam.popup  = TRUE
                     CALL cl_err()
                     LET g_detail_d[l_ac].sel = 'N'
                     NEXT FIELD sel
                  END IF
               ELSE        
                  #存在分割或合并               
                  IF g_detail_d[l_ac].out = 'Y' OR g_detail_d[l_ac].in = 'Y' OR g_detail_d[l_ac].produce = 'Y' THEN 
                     IF NOT cl_ask_confirm('afa-00330') THEN
                        LET g_detail_d[l_ac].sel = 'Y'
                        NEXT FIELD sel
                     END IF
                     #單筆產生                   
                     IF g_detail_d[l_ac].produce = 'Y' THEN                      
                        UPDATE afap210_tmp SET sel = 'N',
                                               faah002 = '',
                                               faah001 = '',
                                               faah003 = '',
                                               faah004 = '',
                                               faah014 = '', #161102-00025#2
                                               produce = 'N'
                         WHERE faak003 = g_detail_d[l_ac].faak003
                           AND faak004 = g_detail_d[l_ac].faak004
                           AND faak001 = g_detail_d[l_ac].faak001
                           AND produce = 'Y'
                         IF SQLCA.sqlcode THEN
                            INITIALIZE g_errparam TO NULL
                            LET g_errparam.extend = "UPD afap210_tmp"
                            LET g_errparam.code   = SQLCA.sqlcode
                            LET g_errparam.popup  = TRUE
                            CALL cl_err()
                            LET g_detail_d[l_ac].sel = 'Y'
                            NEXT FIELD sel
                         END IF
                     END IF 
                     #合并                     
                     IF g_detail_d[l_ac].in = 'Y' THEN
                        UPDATE afap210_tmp SET sel = 'N',
                                               faah002 = '',
                                               faah001 = '',
                                               faah003 = '',
                                               faah004 = '',
                                               faah014 = '', #161102-00025#2
                                               pin = 'N'
                         WHERE faah003 = g_detail_d[l_ac].faah003
                           AND faah004 = g_detail_d[l_ac].faah004
                           AND pin = 'Y'
                         IF SQLCA.sqlcode THEN
                            INITIALIZE g_errparam TO NULL
                            LET g_errparam.extend = "UPD afap210_tmp"
                            LET g_errparam.code   = SQLCA.sqlcode
                            LET g_errparam.popup  = TRUE
                            CALL cl_err()
                            LET g_detail_d[l_ac].sel = 'Y'
                            NEXT FIELD sel
                         END IF
                     END IF 
                     #分割
                     IF g_detail_d[l_ac].out = 'Y' THEN 
                        UPDATE afap210_tmp SET sel = 'N',
                                               faah002 = '',
                                               faah001 = '',
                                               faah003 = '',
                                               faah004 = '',
                                               faah014 = '', #161102-00025#2
                                               pout = 'N'
                         WHERE faak001 = g_detail_d[l_ac].faak001
                           AND faak003 = g_detail_d[l_ac].faak003
                           AND faak004 = g_detail_d[l_ac].faak004
                           AND pout = 'Y'
                        IF SQLCA.sqlcode THEN
                           INITIALIZE g_errparam TO NULL
                           LET g_errparam.extend = "UPD afap210_tmp"
                           LET g_errparam.code   = SQLCA.sqlcode
                           LET g_errparam.popup  = TRUE
                           CALL cl_err()
                           LET g_detail_d[l_ac].sel = 'Y'
                           NEXT FIELD sel
                        END IF
                        #删除临时表已存在的资料
                        DELETE FROM afap210_01_tmp
                         WHERE faak000 = g_detail_d[l_ac].faak000
                           AND faak001 = g_detail_d[l_ac].faak001
                           AND faak003 = g_detail_d[l_ac].faak003
                           AND faak004 = g_detail_d[l_ac].faak004
                        IF SQLCA.sqlcode THEN
                           INITIALIZE g_errparam TO NULL
                           LET g_errparam.extend = "DEL afap210_01_tmp"
                           LET g_errparam.code   = SQLCA.sqlcode
                           LET g_errparam.popup  = TRUE
                           CALL cl_err()
                           LET g_detail_d[l_ac].sel = 'Y'
                           NEXT FIELD sel
                        END IF
                     END IF 
                  #不存在合并或分割
                  ELSE
                     UPDATE afap210_tmp SET sel = 'N' 
                      WHERE faak000 = g_detail_d[l_ac].faak000
                        AND faak001 = g_detail_d[l_ac].faak001
                        AND faak003 = g_detail_d[l_ac].faak003
                        AND faak004 = g_detail_d[l_ac].faak004  
                     IF SQLCA.sqlcode THEN
                        INITIALIZE g_errparam TO NULL
                        LET g_errparam.extend = "UPD afap210_tmp"
                        LET g_errparam.code   = SQLCA.sqlcode
                        LET g_errparam.popup  = TRUE
                        CALL cl_err()
                        LET g_detail_d[l_ac].sel = 'Y'
                        NEXT FIELD sel
                     END IF
                  END IF 
                  LET g_detail_d[l_ac].faah001 = ''
                  LET g_detail_d[l_ac].faah002 = ''
                  LET g_detail_d[l_ac].faah003 = ''
                  LET g_detail_d[l_ac].faah004 = ''
                  LET g_detail_d[l_ac].out ='N'
                  LET g_detail_d[l_ac].in = 'N'
                  LET g_detail_d[l_ac].produce = 'N'
               END IF 
               CALL afap210_display()
               
            AFTER INPUT
               CALL afap210_query()
              
         END INPUT             
         #end add-point
         #add-point:ui_dialog段自定義display array
     
         #end add-point
 
       #  SUBDIALOG lib_cl_dlg.cl_dlg_qryplan
 
         BEFORE DIALOG
            IF g_detail_d.getLength() > 0 THEN
               CALL gfrm_curr.setFieldHidden("formonly.sel", TRUE)
               CALL gfrm_curr.setFieldHidden("formonly.statepic", TRUE)
            ELSE
               CALL gfrm_curr.setFieldHidden("formonly.sel", FALSE)
               CALL gfrm_curr.setFieldHidden("formonly.statepic", FALSE)
            END IF
            #add-point:ui_dialog段before_dialog2
            CALL afap210_construct()
   
            IF g_action_choice = "exit" AND NOT cl_null(g_action_choice) THEN
               EXIT WHILE
            END IF
   
            CALL afap210_b_fill()
  
            #end add-point
 
         #選擇全部
#         ON ACTION selall
#            CALL DIALOG.setSelectionRange("s_detail1", 1, -1, 1)
#            FOR li_idx = 1 TO g_detail_d.getLength()
#               LET g_detail_d[li_idx].sel = "Y"
#               #add-point:ui_dialog段on action selall
#
#               #end add-point
#            END FOR
#            #add-point:ui_dialog段on action selall
#            UPDATE afap210_tmp SET sel = 'Y'
#            IF SQLCA.sqlcode THEN
#               INITIALIZE g_errparam TO NULL
#               LET g_errparam.code = SQLCA.sqlcode
#               LET g_errparam.extend = 'update 4'
#               LET g_errparam.popup = TRUE
#               CALL cl_err()                 
#            END IF            
 
            #end add-point
 
#         #取消全部
#         ON ACTION selnone
#            CALL DIALOG.setSelectionRange("s_detail1", 1, -1, 0)
#            FOR li_idx = 1 TO g_detail_d.getLength()
#               LET g_detail_d[li_idx].sel = "N"
#               #add-point:ui_dialog段on action selnone
#
#               #end add-point
#            END FOR
#            #add-point:ui_dialog段on action selnone
#            UPDATE afap210_tmp SET sel = 'N'
#            IF SQLCA.sqlcode THEN
#               INITIALIZE g_errparam TO NULL
#               LET g_errparam.code = SQLCA.sqlcode
#               LET g_errparam.extend = 'update 5'
#               LET g_errparam.popup = TRUE
#               CALL cl_err()                 
#            END IF   
            #end add-point
 
#         #勾選所選資料
#         ON ACTION sel
#            FOR li_idx = 1 TO g_detail_d.getLength()
#               IF DIALOG.isRowSelected("s_detail1", li_idx) THEN
#                  LET g_detail_d[li_idx].sel = "Y"
#               END IF
#            END FOR
#            #add-point:ui_dialog段on action sel
#            UPDATE afap210_tmp SET sel = 'Y' 
#             WHERE faak000 = g_detail_d[l_ac].faak000
#               AND faak001 = g_detail_d[l_ac].faak001
#               AND faak003 = g_detail_d[l_ac].faak003
#               AND faak004 = g_detail_d[l_ac].faak004
#
#            IF SQLCA.sqlcode THEN
#               INITIALIZE g_errparam TO NULL
#               LET g_errparam.code = SQLCA.sqlcode
#               LET g_errparam.extend = 'update 6'
#               LET g_errparam.popup = TRUE
#               CALL cl_err()                 
#            END IF
            #end add-point
 
         #取消所選資料
#         ON ACTION unsel
#            FOR li_idx = 1 TO g_detail_d.getLength()
#               IF DIALOG.isRowSelected("s_detail1", li_idx) THEN
#                  LET g_detail_d[li_idx].sel = "N"
#               END IF
#            END FOR
#            #add-point:ui_dialog段on action unsel
#            UPDATE afap210_tmp SET sel = 'N' 
#             WHERE faak000 = g_detail_d[l_ac].faak000
#               AND faak001 = g_detail_d[l_ac].faak001
#               AND faak003 = g_detail_d[l_ac].faak003
#               AND faak004 = g_detail_d[l_ac].faak004
#
#            IF SQLCA.sqlcode THEN
#               INITIALIZE g_errparam TO NULL
#               LET g_errparam.code = SQLCA.sqlcode
#               LET g_errparam.extend = 'update 7'
#               LET g_errparam.popup = TRUE
#               CALL cl_err()                 
#            END IF
            #end add-point
         #產生單一資料
         ON ACTION produce
            LET g_action_choice="produce"
            #########################mark by huangtao
            CALL afap210_produce()
            #########################mark by huangtao  
            NEXT FIELD sel
         #合併
         ON ACTION coalition
            LET g_action_choice="coalition"
            #########################mark by huangtao
            #CALL afap210_produce('2')
            CALL afap210_coalition()
            #########################mark by huangtao
            NEXT FIELD sel
         #分割
         ON ACTION comminute
            LET g_action_choice="comminute"
            CALL afap210_comminute()
            NEXT FIELD sel
            
         ON ACTION filter
            LET g_action_choice="filter"
            CALL afap210_filter()
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
 
         ON ACTION accept
            ACCEPT DIALOG 
            
             
         # 條件清除
         ON ACTION qbeclear
            #20150210 add by chenying
            LET INT_FLAG = 1
            EXIT DIALOG   
            #20150210 add by chenying
            
         # 重新整理
         ON ACTION datarefresh
            LET g_error_show = 1
            CALL afap210_b_fill()
            CALL afap210_fetch()
 
         #add-point:ui_dialog段action
         ON ACTION cancel
            LET INT_FLAG = 1
            EXIT DIALOG         
         #end add-point
 
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

################################################################################
# Descriptions...: 获取底稿信息作为默认值

# Date & Author..: 2014/11/13 By liuym
# Modify.........: 2015/08/04 by yantt 150803-00002 1 add p_pin,p_produce
################################################################################
PRIVATE FUNCTION afap210_get_deault_value(p_faak000,p_faak001,p_faak003,p_faak004,p_faah000,p_faah001,p_faah003,p_faah004,p_pin,p_produce)
   DEFINE  p_faak000    LIKE faak_t.faak000
   DEFINE  p_faak001    LIKE faak_t.faak001
   DEFINE  p_faak003    LIKE faak_t.faak003
   DEFINE  p_faak004    LIKE faak_t.faak004
   DEFINE  p_faah000    LIKE faah_t.faah000
   DEFINE  p_faah001    LIKE faah_t.faah001
   DEFINE  p_faah003    LIKE faah_t.faah003
   DEFINE  p_faah004    LIKE faah_t.faah004
   DEFINE  p_pin        LIKE type_t.chr1       #150803-00002#1
   DEFINE  p_produce    LIKE type_t.chr1       #150803-00002#1
   DEFINE  l_faah002    LIKE faah_t.faah002
   DEFINE  l_faah005    LIKE faah_t.faah005
   DEFINE  l_faah006    LIKE faah_t.faah006
   DEFINE  l_faah007    LIKE faah_t.faah007
   DEFINE  l_faah008    LIKE faah_t.faah008
   DEFINE  l_faah009    LIKE faah_t.faah009
   DEFINE  l_faah010    LIKE faah_t.faah010
   DEFINE  l_faah011    LIKE faah_t.faah011
   DEFINE  l_faah012    LIKE faah_t.faah012
   DEFINE  l_faah013    LIKE faah_t.faah013 
   DEFINE  l_faah014    LIKE faah_t.faah014
   DEFINE  l_faah015    LIKE faah_t.faah015
   DEFINE  l_faah017    LIKE faah_t.faah017
   DEFINE  l_faah020    LIKE faah_t.faah020
   DEFINE  l_faah021    LIKE faah_t.faah021
   DEFINE  l_faah022    LIKE faah_t.faah022
   DEFINE  l_faah023    LIKE faah_t.faah023
   DEFINE  l_faah024    LIKE faah_t.faah024
   DEFINE  l_faah032    LIKE faah_t.faah032
   DEFINE  l_faah042    LIKE faah_t.faah042
   DEFINE  l_faah033    LIKE faah_t.faah033
   DEFINE  l_faah034    LIKE faah_t.faah034   
   DEFINE  l_faah035    LIKE faah_t.faah035
   DEFINE  l_faah036    LIKE faah_t.faah036
   DEFINE  l_faah037    LIKE faah_t.faah037
   DEFINE  l_faaj003    LIKE faaj_t.faaj003
   DEFINE  l_faaj004    LIKE faaj_t.faaj004
   DEFINE  l_faaj011    LIKE faaj_t.faaj011
   DEFINE  l_faaj014    LIKE faaj_t.faaj014
   DEFINE  l_faaj015    LIKE faaj_t.faaj015
   DEFINE  l_faaj016    LIKE faaj_t.faaj016
   DEFINE  l_faaj019    LIKE faaj_t.faaj019
   DEFINE  l_faaj024    LIKE faaj_t.faaj024
   DEFINE  l_faaj025    LIKE faaj_t.faaj025
   DEFINE  l_faaj026    LIKE faaj_t.faaj026
   DEFINE  l_faajld     LIKE faaj_t.faajld
   DEFINE  l_faaj006    LIKE faaj_t.faaj006
   DEFINE  l_faaj007    LIKE faaj_t.faaj007
   DEFINE  l_success    LIKE type_t.num5   
   DEFINE  l_glaa025    LIKE glaa_t.glaa025
   DEFINE  l_faaj028    LIKE faaj_t.faaj028
   DEFINE  l_faaj023    LIKE faaj_t.faaj023
   DEFINE  l_faac016    LIKE faac_t.faac016#残值率
   DEFINE  l_faaj038    LIKE faaj_t.faaj038  #161104-00048#8 add
   #161111-00028#6 -s by 08172
#   DEFINE  l_faah       RECORD LIKE faah_t.*
   DEFINE l_faah RECORD  #固定資產基礎資料檔
       faahent LIKE faah_t.faahent, #企业编号
       faah000 LIKE faah_t.faah000, #生成批号
       faah001 LIKE faah_t.faah001, #卡片编号
       faah002 LIKE faah_t.faah002, #型态
       faah003 LIKE faah_t.faah003, #财产编号
       faah004 LIKE faah_t.faah004, #附号
       faah005 LIKE faah_t.faah005, #资产性质
       faah006 LIKE faah_t.faah006, #资产主要类型
       faah007 LIKE faah_t.faah007, #资产次要类型
       faah008 LIKE faah_t.faah008, #资产组
       faah009 LIKE faah_t.faah009, #供应供应商
       faah010 LIKE faah_t.faah010, #制造供应商
       faah011 LIKE faah_t.faah011, #产地
       faah012 LIKE faah_t.faah012, #名称
       faah013 LIKE faah_t.faah013, #规格型号
       faah014 LIKE faah_t.faah014, #取得日期
       faah015 LIKE faah_t.faah015, #资产状态
       faah016 LIKE faah_t.faah016, #取得方式
       faah017 LIKE faah_t.faah017, #单位
       faah018 LIKE faah_t.faah018, #数量
       faah019 LIKE faah_t.faah019, #在外数量
       faah020 LIKE faah_t.faah020, #币种
       faah021 LIKE faah_t.faah021, #原币单价
       faah022 LIKE faah_t.faah022, #原币金额
       faah023 LIKE faah_t.faah023, #本币单价
       faah024 LIKE faah_t.faah024, #本币金额
       faah025 LIKE faah_t.faah025, #保管人员
       faah026 LIKE faah_t.faah026, #保管部门
       faah027 LIKE faah_t.faah027, #存放位置
       faah028 LIKE faah_t.faah028, #存放组织
       faah029 LIKE faah_t.faah029, #负责人员
       faah030 LIKE faah_t.faah030, #管理组织
       faah031 LIKE faah_t.faah031, #核算组织
       faah032 LIKE faah_t.faah032, #归属法人
       faah033 LIKE faah_t.faah033, #直接资本化
       faah034 LIKE faah_t.faah034, #保税
       faah035 LIKE faah_t.faah035, #保险
       faah036 LIKE faah_t.faah036, #免税
       faah037 LIKE faah_t.faah037, #抵押
       faah038 LIKE faah_t.faah038, #采购单号
       faah039 LIKE faah_t.faah039, #收货单号
       faah040 LIKE faah_t.faah040, #账款单号
       faah041 LIKE faah_t.faah041, #来源营运中心
       faah042 LIKE faah_t.faah042, #资产属性
       faah043 LIKE faah_t.faah043, #预计总工作量
       faah044 LIKE faah_t.faah044, #已使用工作量
       faah045 LIKE faah_t.faah045, #账款编号项次
       faahownid LIKE faah_t.faahownid, #资料所有者
       faahowndp LIKE faah_t.faahowndp, #资料所有部门
       faahcrtid LIKE faah_t.faahcrtid, #资料录入者
       faahcrtdp LIKE faah_t.faahcrtdp, #资料录入部门
       faahcrtdt LIKE faah_t.faahcrtdt, #资料创建日
       faahmodid LIKE faah_t.faahmodid, #资料更改者
       faahmoddt LIKE faah_t.faahmoddt, #最近更改日
       faahstus LIKE faah_t.faahstus, #状态码
       faah046 LIKE faah_t.faah046, #备注
       faah047 LIKE faah_t.faah047, #保税机器截取否
       faah048 LIKE faah_t.faah048, #投资抵减状态
       faah049 LIKE faah_t.faah049, #投资抵减合并码
       faah050 LIKE faah_t.faah050, #抵减率
       faah051 LIKE faah_t.faah051, #投资抵减用途
       faah052 LIKE faah_t.faah052, #抵减金额
       faah053 LIKE faah_t.faah053, #已抵减金额
       faah054 LIKE faah_t.faah054, #投资抵减否
       faah055 LIKE faah_t.faah055, #投资抵减年限
       faah056 LIKE faah_t.faah056 #免税状态
   END RECORD
   #161111-00028#6 -e by 08172
   DEFINE  l_glaa015    LIKE glaa_t.glaa015
   DEFINE  l_glaa017    LIKE glaa_t.glaa017
   DEFINE  l_faaj101    LIKE faaj_t.faaj101
   DEFINE  l_glaa018    LIKE glaa_t.glaa018
   DEFINE  l_faaj102    LIKE faaj_t.faaj102
   DEFINE  l_faaj103    LIKE faaj_t.faaj103
   DEFINE  l_faaj104    LIKE faaj_t.faaj104
   DEFINE  l_faaj105    LIKE faaj_t.faaj105
   DEFINE  l_faaj111    LIKE faaj_t.faaj111
   DEFINE  l_faaj108    LIKE faaj_t.faaj108
   DEFINE  l_glaa019    LIKE glaa_t.glaa019
   DEFINE  l_faaj017    LIKE faaj_t.faaj017
   DEFINE  l_faaj018    LIKE faaj_t.faaj018
   DEFINE  l_faaj151    LIKE faaj_t.faaj151
   DEFINE  l_glaa022    LIKE glaa_t.glaa022
   DEFINE  l_glaa021    LIKE glaa_t.glaa021
   DEFINE  l_faaj152    LIKE faaj_t.faaj152
   DEFINE  l_faaj153    LIKE faaj_t.faaj153
   DEFINE  l_faaj154    LIKE faaj_t.faaj154
   DEFINE  l_faaj155    LIKE faaj_t.faaj155
   DEFINE  l_faaj161    LIKE faaj_t.faaj161
   DEFINE  l_faaj158    LIKE faaj_t.faaj158
   #160525-00040#1----begin
   DEFINE  l_faal005    LIKE faal_t.faal005   
   DEFINE  l_faaj008    LIKE faaj_t.faaj008
   DEFINE  l_year       LIKE type_t.num5
   DEFINE  l_month      LIKE type_t.num5
   DEFINE  l_num1       LIKE type_t.num5
   DEFINE  l_num2       LIKE type_t.num5
   DEFINE  l_str        STRING
   DEFINE  l_str1       STRING
   DEFINE  l_str2       STRING
   #160525-00040#1----end   
   #161111-00028#6 -s by 08172
#   DEFINE  l_faaj       RECORD LIKE faaj_t.*    #160926-00010#1 add lujh
   DEFINE l_faaj RECORD  #固定資產帳套折舊資訊資料檔
       faajent LIKE faaj_t.faajent, #企业编码
       faajld LIKE faaj_t.faajld, #账套别编码
       faajsite LIKE faaj_t.faajsite, #营运据点
       faaj000 LIKE faaj_t.faaj000, #批号
       faaj001 LIKE faaj_t.faaj001, #财产编号
       faaj002 LIKE faaj_t.faaj002, #附号
       faaj003 LIKE faaj_t.faaj003, #折旧方式
       faaj004 LIKE faaj_t.faaj004, #耐用年限(月数)
       faaj005 LIKE faaj_t.faaj005, #未使用年限(月数)
       faaj006 LIKE faaj_t.faaj006, #分摊方式
       faaj007 LIKE faaj_t.faaj007, #分摊类别
       faaj008 LIKE faaj_t.faaj008, #开始折旧年月
       faaj009 LIKE faaj_t.faaj009, #最近折旧年度
       faaj010 LIKE faaj_t.faaj010, #最近折旧期别
       faaj011 LIKE faaj_t.faaj011, #折毕再提
       faaj012 LIKE faaj_t.faaj012, #折毕再提预留残值
       faaj013 LIKE faaj_t.faaj013, #折毕再提预留年月（数）
       faaj014 LIKE faaj_t.faaj014, #币种
       faaj015 LIKE faaj_t.faaj015, #汇率
       faaj016 LIKE faaj_t.faaj016, #成本
       faaj017 LIKE faaj_t.faaj017, #累折
       faaj018 LIKE faaj_t.faaj018, #本期累折
       faaj019 LIKE faaj_t.faaj019, #预留残值
       faaj020 LIKE faaj_t.faaj020, #调整成本
       faaj021 LIKE faaj_t.faaj021, #已计提减值准备
       faaj022 LIKE faaj_t.faaj022, #年折旧额
       faaj023 LIKE faaj_t.faaj023, #资产科目
       faaj024 LIKE faaj_t.faaj024, #累折科目
       faaj025 LIKE faaj_t.faaj025, #折旧科目
       faaj026 LIKE faaj_t.faaj026, #减值准备科目
       faaj027 LIKE faaj_t.faaj027, #销账减值准备
       faaj028 LIKE faaj_t.faaj028, #未折减额
       faaj029 LIKE faaj_t.faaj029, #第一个月未折减额
       faaj030 LIKE faaj_t.faaj030, #账款编号
       faaj031 LIKE faaj_t.faaj031, #账款编号项次
       faaj032 LIKE faaj_t.faaj032, #本期处置累折
       faaj033 LIKE faaj_t.faaj033, #处置数量
       faaj034 LIKE faaj_t.faaj034, #处置成本
       faaj035 LIKE faaj_t.faaj035, #处置累折
       faaj036 LIKE faaj_t.faaj036, #交易价格差异
       faaj037 LIKE faaj_t.faaj037, #卡片编号
       faaj038 LIKE faaj_t.faaj038, #资产状态
       faaj039 LIKE faaj_t.faaj039, #部门
       faaj040 LIKE faaj_t.faaj040, #利润/成本中心
       faaj041 LIKE faaj_t.faaj041, #区域
       faaj042 LIKE faaj_t.faaj042, #交易客商
       faaj043 LIKE faaj_t.faaj043, #账款客商
       faaj044 LIKE faaj_t.faaj044, #客群
       faaj045 LIKE faaj_t.faaj045, #项目编号
       faaj046 LIKE faaj_t.faaj046, #WBS
       faaj047 LIKE faaj_t.faaj047, #人员
       faaj101 LIKE faaj_t.faaj101, #本位币二币种
       faaj102 LIKE faaj_t.faaj102, #本位币二汇率
       faaj103 LIKE faaj_t.faaj103, #本位币二成本
       faaj104 LIKE faaj_t.faaj104, #本位币二累折
       faaj105 LIKE faaj_t.faaj105, #本位币二预留残值
       faaj106 LIKE faaj_t.faaj106, #本位币二折毕再提预留残值
       faaj107 LIKE faaj_t.faaj107, #本位币二年折旧额
       faaj108 LIKE faaj_t.faaj108, #本位币二未折减额
       faaj109 LIKE faaj_t.faaj109, #本位币二第一月未折减额
       faaj110 LIKE faaj_t.faaj110, #本位币二处置减值准备
       faaj111 LIKE faaj_t.faaj111, #本位币二本年累折
       faaj112 LIKE faaj_t.faaj112, #本位币二已计提减值准备
       faaj113 LIKE faaj_t.faaj113, #本位币二处置成本
       faaj114 LIKE faaj_t.faaj114, #本位币二处置累折
       faaj115 LIKE faaj_t.faaj115, #本位币二本期处置累折
       faaj116 LIKE faaj_t.faaj116, #本位币二交易价格差异
       faaj117 LIKE faaj_t.faaj117, #本位币二调整成本
       faaj151 LIKE faaj_t.faaj151, #本位币三币种
       faaj152 LIKE faaj_t.faaj152, #本位币三汇率
       faaj153 LIKE faaj_t.faaj153, #本位币三成本
       faaj154 LIKE faaj_t.faaj154, #本位币三累折
       faaj155 LIKE faaj_t.faaj155, #本位币三预留残值
       faaj156 LIKE faaj_t.faaj156, #本位币三折毕再提预留残值
       faaj157 LIKE faaj_t.faaj157, #本位币三年折旧额
       faaj158 LIKE faaj_t.faaj158, #本位币三未折减额
       faaj159 LIKE faaj_t.faaj159, #本位币三第一月未折减额
       faaj160 LIKE faaj_t.faaj160, #本位币三处置减值准备
       faaj161 LIKE faaj_t.faaj161, #本位币三本年累折
       faaj162 LIKE faaj_t.faaj162, #本位币三已计提减值准备
       faaj163 LIKE faaj_t.faaj163, #本位币三处置成本
       faaj164 LIKE faaj_t.faaj164, #本位币三处置累折
       faaj165 LIKE faaj_t.faaj165, #本位币三本期处置累折
       faaj166 LIKE faaj_t.faaj166, #本位币三交易价格差异
       faaj167 LIKE faaj_t.faaj167, #本位币三调整成本
       faajownid LIKE faaj_t.faajownid, #资料所有者
       faajowndp LIKE faaj_t.faajowndp, #资料所有部门
       faajcrtid LIKE faaj_t.faajcrtid, #资料录入者
       faajcrtdp LIKE faaj_t.faajcrtdp, #资料录入部门
       faajcrtdt LIKE faaj_t.faajcrtdt, #资料创建日
       faajmodid LIKE faaj_t.faajmodid, #资料更改者
       faajmoddt LIKE faaj_t.faajmoddt, #最近更改日
       faajstus LIKE faaj_t.faajstus, #状态码
       faaj048 LIKE faaj_t.faaj048 #资产分类
   END RECORD
   #161111-00028#6 -e by 08172
   INITIALIZE l_faaj.* TO NULL   #160926-00010#1 add lujh
   
   #取faak_t數據作為預設值
   IF cl_null(p_faah004) THEN LET p_faah004=' ' END IF
   #      类型    资产性质 主要类型  次要类型  资产组   取得日期  资产状态  单位    资产属性   原币单价  本币单价  本币金额
   SELECT faak005, faak006, faak007, faak008,faak014, faak015, faak017,faak049  ,faak021, faak023,  faak024,faak009,faak010,faak011,faak012,faak013,faak019,faak022,faak032  #20150210 del faak002  
   INTO l_faah005,l_faah006,l_faah007,l_faah008,l_faah014,l_faah015,l_faah017,l_faah042,l_faah021,l_faah023,l_faah024,                                                     #20150210 del l_faah002     
        l_faah009,l_faah010,l_faah011,l_faah012,l_faah013,l_faah020,l_faah022,l_faah032 
   FROM faak_t WHERE faak000=p_faak000 AND faak001=p_faak001 AND faak003=p_faak003 AND faak004=p_faak004 AND faakent=g_enterprise
   #161111-00028#6 -s by 08172
#   SELECT * INTO l_faah.* 
   SELECT faahent,  faah000,  faah001,  faah002,  faah003,
          faah004,  faah005,  faah006,  faah007,  faah008,
          faah009,  faah010,  faah011,  faah012,  faah013,
          faah014,  faah015,  faah016,  faah017,  faah018,
          faah019,  faah020,  faah021,  faah022,  faah023,
          faah024,  faah025,  faah026,  faah027,  faah028,
          faah029,  faah030,  faah031,  faah032,  faah033,
          faah034,  faah035,  faah036,  faah037,  faah038,
          faah039,  faah040,  faah041,  faah042,  faah043,
          faah044,  faah045,  faahownid,faahowndp,faahcrtid,
          faahcrtdp,faahcrtdt,faahmodid,faahmoddt,faahstus,
          faah046,  faah047,  faah048,  faah049,  faah050,
          faah051,  faah052,  faah053,  faah054,  faah055,
          faah056
     INTO l_faah.faahent,  l_faah.faah000,  l_faah.faah001,  l_faah.faah002,  l_faah.faah003,
          l_faah.faah004,  l_faah.faah005,  l_faah.faah006,  l_faah.faah007,  l_faah.faah008,
          l_faah.faah009,  l_faah.faah010,  l_faah.faah011,  l_faah.faah012,  l_faah.faah013,
          l_faah.faah014,  l_faah.faah015,  l_faah.faah016,  l_faah.faah017,  l_faah.faah018,
          l_faah.faah019,  l_faah.faah020,  l_faah.faah021,  l_faah.faah022,  l_faah.faah023,
          l_faah.faah024,  l_faah.faah025,  l_faah.faah026,  l_faah.faah027,  l_faah.faah028,
          l_faah.faah029,  l_faah.faah030,  l_faah.faah031,  l_faah.faah032,  l_faah.faah033,
          l_faah.faah034,  l_faah.faah035,  l_faah.faah036,  l_faah.faah037,  l_faah.faah038,
          l_faah.faah039,  l_faah.faah040,  l_faah.faah041,  l_faah.faah042,  l_faah.faah043,
          l_faah.faah044,  l_faah.faah045,  l_faah.faahownid,l_faah.faahowndp,l_faah.faahcrtid,
          l_faah.faahcrtdp,l_faah.faahcrtdt,l_faah.faahmodid,l_faah.faahmoddt,l_faah.faahstus,
          l_faah.faah046,  l_faah.faah047,  l_faah.faah048,  l_faah.faah049,  l_faah.faah050,
          l_faah.faah051,  l_faah.faah052,  l_faah.faah053,  l_faah.faah054,  l_faah.faah055,
          l_faah.faah056
   #161111-00028#6 -e by 08172
     FROM faah_t WHERE faah000 = p_faah000 AND faah001 = p_faah001 AND faah003 = p_faah003 AND faah004 = p_faah004 AND faahent = g_enterprise
   #根据资产主要类型获取预设值
   SELECT faac003,faac004,faac005,faac007,faac008,faac009,
          #faac010,faac011,faac016,faac006,faac017   #160926-00010#1 add faac006,faac017 lujh #160923-00041#1 mark faac017
          faac010,faac011,faac016,faac006            #160923-00041#1 add
   INTO l_faaj003,l_faaj004,l_faaj011,l_faah033,l_faah034,
        l_faah035,l_faah036,l_faah037,l_faac016,
        #l_faaj.faaj013,l_faaj.faaj048   #160926-00010#1 add  lujh #160923-00041#1 mark faaj048
        l_faaj.faaj013  #160923-00041#1 add 
   FROM faac_t
   WHERE faacent = g_enterprise
   AND faac001 = l_faah006  #資產主要類型
   #根据归属法人获取对应主帐套
   SELECT UNIQUE glaald INTO l_faajld FROM glaa_t WHERE glaaent=g_enterprise AND glaacomp=l_faah032 AND glaa014='Y'
   IF cl_null(l_faajld) THEN LET l_faajld=' ' END IF
   
   #160923-00041#1 add s---
   #根据资产主要类型依账套设定取列账/列管
   SELECT faal006 INTO l_faaj.faaj048 FROM faal_t
    WHERE faalent = g_enterprise AND faalld = l_faajld
      AND faal001 = l_faah006  #資產主要類型   
   #160923-00041#1 add e---
   
   #获取帐套使用主本币
   SELECT glaa001,glaa025 INTO l_faaj014,l_glaa025 FROM glaa_t WHERE glaald=l_faajld AND glaaent=g_enterprise   
   #获取当前汇率
   #CALL s_aooi160_get_exrate('2',l_faajld,g_today,l_faah020,     #161213-00015#1 mark
   CALL s_aooi160_get_exrate('2',l_faajld,g_today,l_faah.faah020, #161213-00015#1 add
                                   #目的幣別          #匯類類型
                                   l_faaj014,0,l_glaa025)
    RETURNING l_faaj015 
    LET l_faaj016 = l_faah.faah022*l_faaj015
    #预留残值
    IF cl_null(l_faac016) THEN LET l_faac016=0 END IF
    LET l_faaj019 =l_faaj016*l_faac016/100
    
    #160926-00010#1--add--str--lujh
    #折毕再提预留残值一
    LET l_faaj.faaj012 = l_faaj019
    
    LET l_faaj.faaj030 = l_faah.faah040
    
    SELECT apca004,apca005
      INTO l_faaj.faaj043,l_faaj.faaj042
      FROM apca_t
     WHERE apcaent = g_enterprise
       AND apcald = l_faajld
       AND apcadocno = l_faaj.faaj030
    #160926-00010#1--add--end--lujh
    
    LET l_faaj006 = '1'

    SELECT ooag003 INTO l_faaj007
      FROM ooag_t 
     WHERE ooagent = g_enterprise
       AND ooag001 = g_user
   #未折减额
   LET l_faaj028 = l_faaj016
   #根据帐套+主要类型获资产旧科目 
   SELECT glab005 INTO l_faaj023 FROM glab_t  WHERE glabld =l_faajld
   AND glab003 = '9901_01' AND glab002=l_faah006 AND glabent=g_enterprise #160905-00007#1 add
   #根据帐套+主要类型获取折旧科目 
   SELECT glab005 INTO l_faaj025 FROM glab_t  WHERE glabld =l_faajld
   AND glab003 = '9901_03' AND glab002=l_faah006 AND glabent=g_enterprise #160905-00007#1 add
   #根据帐套+主要类型获取累折科目 
   SELECT glab005 INTO l_faaj024 FROM glab_t WHERE glabld =l_faajld
           AND glab003 = '9901_02' AND glab002=l_faah006 AND glabent=g_enterprise #160905-00007#1 add
   #根据帐套+主要类型获取減值準備科目 
   SELECT glab005 INTO l_faaj026 FROM glab_t WHERE glabld = l_faajld
   AND glab003 = '9901_04' AND glab002=l_faah006 AND glabent=g_enterprise #160905-00007#1 add
   
   #150803-00002#1 add---str
   IF p_pin = 'Y' THEN  #若為合併
      LET l_faah006 = g_faah_m.faah006
      LET l_faah007 = g_faah_m.faah007
      SELECT faac002 INTO l_faah005 FROM faac_t
       WHERE faacent = g_enterprise AND faac001 = g_faah_m.faah006
   END IF
   IF p_produce = 'Y' THEN  #若為單筆
      LET l_faah005 = l_faah005
      LET l_faah006 = l_faah006
      LET l_faah007 = l_faah007
   END IF
   #150803-00002#1 add---end
   #161102-00025#2--add--s--xul
   #取得日期 
   LET l_faah014 = g_faah014
   #161102-00025#2--add--e--xul
   

   UPDATE faah_t SET(faah004,faah005,faah006,faah007,faah008,faah014,faah015,faah016,faah017,faah042,     #20150210 del faah002
                     faah033,faah034,faah035,faah036,faah037,faah009,faah010,faah011,faah012,faah013)   #,faah024)  ##151222-00006#1 mark faah024 ##161213-00015#1 del faah023 faah021
                      =
                     (p_faah004,l_faah005,l_faah006,l_faah007,l_faah008,l_faah014,l_faah015,'1',l_faah017,l_faah042,l_faah033,l_faah034, #20150210 del l_faah002  
                      l_faah035,l_faah036,l_faah037,l_faah009,l_faah010,l_faah011,l_faah012,l_faah013)   #,l_faah024)  #151222-00006#1 mark l_faah024 #161213-00015#1 del faah023 l_faah021
    WHERE faah000= p_faah000 AND faah001=p_faah001 AND faah003=p_faah003 AND faah004=p_faah004 AND faahent=g_enterprise 
   IF SQLCA.sqlcode THEN
      LET l_success = FALSE
      #150731-00004#1 20150807 str---
      # CALL cl_errmsg('UPD faah',p_faak001,'N',sqlca.sqlcode,1)
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = sqlca.sqlcode
      LET g_errparam.extend = "upd faah:"||p_faak001
      LET g_errparam.popup = TRUE
      CALL cl_err()
      #150731-00004#1 20150807 end---
   END IF  
   LET l_faaj017 = 0
   LET l_faaj018 = 0
   #帳套是否使用本位幣二
    SELECT glaa015 INTO l_glaa015 FROM glaa_t 
     WHERE glaaent = g_enterprise
       AND glaald = l_faajld
    IF l_glaa015 = 'Y' THEN
       #本位幣二 匯率類型
       SELECT glaa016,glaa018 INTO l_faaj101,l_glaa018
         FROM glaa_t
        WHERE glaaent = g_enterprise
          AND glaald = l_faajld
          
       #本位幣二 換算基準
       SELECT glaa017 INTO l_glaa017
         FROM glaa_t
        WHERE glaaent = g_enterprise
          AND glaald = l_faajld
       
       IF l_glaa017 ='1' THEN
          #本位幣二 匯率  
          CALL s_aooi160_get_exrate('2',l_faajld,g_today,l_faah.faah020,
                                 #目的幣別                 #匯類類型
                                 l_faaj101,0,l_glaa018)
          RETURNING l_faaj102

          #本位幣二 成本
         LET l_faaj103 =  l_faah.faah022 *  l_faaj102
       ELSE
         #本位幣二 匯率  
         CALL s_aooi160_get_exrate('2',l_faajld,g_today,l_faaj014,
                                 #目的幣別                 #匯類類型
                                 l_faaj101,0,l_glaa018)
         RETURNING l_faaj102

         #本位幣二 成本
         LET l_faaj103 =  l_faah.faah024 *  l_faaj102
       END IF   
       LET l_faaj105 = l_faaj103 * l_faac016/100
       #160926-00010#1--add--str--lujh
       #折毕再提预留残值二
       LET l_faaj.faaj106 = l_faaj105
       #160926-00010#1--add--end--lujh
       LET l_faaj104 = l_faaj017 * l_faaj102
       LET l_faaj111 = l_faaj018 * l_faaj102
       LET l_faaj108 = l_faaj028 * l_faaj102
   END IF     
   #帳套是否使用本位幣三
   SELECT glaa019 INTO l_glaa019 FROM glaa_t 
    WHERE glaaent = g_enterprise
      AND glaald = l_faajld
   IF l_glaa019 = 'Y' THEN
      #本位幣三 匯率類型
      SELECT glaa020,glaa022 INTO l_faaj151,l_glaa022
        FROM glaa_t
       WHERE glaaent = g_enterprise
         AND glaald = l_faajld
      
      #本位幣二 換算基準
      SELECT glaa021 INTO l_glaa021
        FROM glaa_t
       WHERE glaaent = g_enterprise
         AND glaald = l_faajld   
      
      IF l_glaa021 ='1' THEN
         #本位幣三 匯率  
         CALL s_aooi160_get_exrate('2',l_faajld,g_today,l_faah.faah020,
                                  #目的幣別                 #匯類類型
                                  l_faaj151,0,l_glaa022)
         RETURNING l_faaj152
         
         #本位幣三 成本
         LET l_faaj153 =  l_faah.faah022 *  l_faaj152  
      ELSE
         #本位幣三 匯率  
         CALL s_aooi160_get_exrate('2',l_faajld,g_today,l_faaj014,
                                  #目的幣別                 #匯類類型
                                  l_faaj151,0,l_glaa022)
         RETURNING l_faaj152
         
         #本位幣三 成本
         LET l_faaj153 =  l_faah.faah024 *  l_faaj152
      END IF   
      LET l_faaj155 = l_faaj153 * l_faac016/100
      #160926-00010#1--add--str--lujh
      #折毕再提预留残值三
      LET l_faaj.faaj156 = l_faaj155
      #160926-00010#1--add--end--lujh
      LET l_faaj154 = l_faaj017 * l_faaj152
      LET l_faaj161 = l_faaj018 * l_faaj152
      LET l_faaj158 = l_faaj028 * l_faaj152
   END IF
   #160525-00040#1-----b
      #抓取本月入帳提列方式
      SELECT faal005 INTO l_faal005
        FROM faal_t
       WHERE faalent = g_enterprise
         AND faalld  = l_faajld 
         AND faal001 = l_faah006
      
      LET l_year = YEAR(l_faah014)
      LET l_month = MONTH(l_faah014)
      IF l_faal005 = '1' THEN
         LET l_num2 = l_month + 1
         IF l_num2 > 12 THEN
            LET l_num2 = 1
            LET l_num1 = l_year + 1
         ELSE
            LET l_num2 = l_num2
            LET l_num1 = l_year
         END IF
      ELSE
         LET l_num1 = l_year
         LET l_num2 = l_month
      END IF
      
      LET l_str1 = l_num1
      LET l_str2 = l_num2
      IF l_num2 < 10 THEN
         LET l_str = l_str1 CLIPPED,'0' CLIPPED,l_str2 CLIPPED
      ELSE
         LET l_str = l_str1 CLIPPED,l_str2 CLIPPED
      END IF
      LET l_faaj008 = l_str.trim()    

   LET l_faaj038 = l_faah015 #161104-00048#8 add 
   #160525-00040#1----end   
   INSERT INTO faaj_t(faajent,faajld ,faaj037,faaj001,faaj002,faaj000 ,faaj003,faaj004,
                      faaj005,faaj011,faaj023,faaj024,faaj025,faaj026 ,faaj014,faaj015,
                      faaj016,faaj019,faaj028,faaj006,faaj007,faajsite,faaj101,faaj102,
                      faaj103,faaj104,faaj105,faaj111,faaj108,faaj151 ,faaj152,faaj153,
                      faaj154,faaj155,faaj161,faaj158,faaj017,faaj018 ,faaj008,faaj030,
                      faaj042,faaj043,faaj048,faaj013,faaj012,faaj106 ,faaj156,faaj038) #160525-00040#1 add faaj008 #160926-00010#1 add faaj030,faaj042,faaj043,faaj048,faaj013,faaj012,faaj106,faaj156 lujh #161104-00048#8 add faaj038
               VALUES(g_enterprise,l_faajld ,p_faah001,p_faah003,p_faah004,
                      p_faah000   ,l_faaj003,l_faaj004,l_faaj004,l_faaj011,
                      l_faaj023   ,l_faaj024,l_faaj025,l_faaj026,l_faaj014,
                      l_faaj015   ,l_faaj016,l_faaj019,l_faaj028,l_faaj006,
                      l_faaj007   ,g_site   ,l_faaj101,l_faaj102,l_faaj103,
                      l_faaj104   ,l_faaj105,l_faaj111,l_faaj108,l_faaj151,
                      l_faaj152   ,l_faaj153,l_faaj154,l_faaj155,l_faaj161,
                      l_faaj158   ,0,0,      l_faaj008,
                      l_faaj.faaj030,l_faaj.faaj042,l_faaj.faaj043,
                      l_faaj.faaj048,l_faaj.faaj013,l_faaj.faaj012,
                      l_faaj.faaj106,l_faaj.faaj156,l_faah015) #160525-00040#1 add faaj008) #161104-00048#8 add l_faah015
               
   IF SQLCA.sqlcode THEN
      LET l_success = FALSE
      #150731-00004#1 20150807 str---
      #CALL cl_errmsg('INS faaj_t',p_faak001,'N',sqlca.sqlcode,1)
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = sqlca.sqlcode
      LET g_errparam.extend = "INS faaj_t:"||p_faak001
      LET g_errparam.popup = TRUE
      CALL cl_err()
      #150731-00004#1 20150807 end---
   END IF

END FUNCTION

################################################################################
# Descriptions...: 产生单一资料
# Memo...........:
# Usage..........: CALL afap210_produce()
# Input parameter: p_type    
# Return code....: 无
# Date & Author..: 2014/12/13 By yangxf
# Modify.........:
################################################################################
PRIVATE FUNCTION afap210_produce()
   DEFINE p_type       LIKE type_t.num5
   DEFINE l_n          LIKE type_t.num5
   DEFINE l_faak019    LIKE faak_t.faak019
   DEFINE l_faak019_t  LIKE faak_t.faak019
   
   LET l_n = 0
   #单一产生

   SELECT COUNT(*) INTO l_n
     FROM afap210_tmp
    WHERE sel = 'Y'
      AND pin = 'N'
      AND produce = 'N'
      AND pout = 'N'
   
   IF l_n = 0 THEN 
      RETURN 
   END IF 

   CALL afap210_03_open()
   IF NOT INT_FLAG THEN 
     
     #   UPDATE afap210_tmp SET faah001 = g_faah_m.faah001,
     #                          faah002 = g_faah_m.faah002,
     #                          faah003 = g_faah_m.faah003,
     #                          faah004 = g_faah_m.faah004,
     #                          produce = 'Y'
     #    WHERE sel = 'Y'
     #      AND pin = 'N'
     #      AND pout = 'N'   
     #      AND produce = 'N'
     #   IF SQLCA.SQLcode  THEN
     #      INITIALIZE g_errparam TO NULL 
     #      LET g_errparam.extend = "UPD afap210_tmp" 
     #      LET g_errparam.code   = SQLCA.sqlcode 
     #      LET g_errparam.popup  = TRUE 
     #      CALL cl_err()                  
     #      RETURN 
     #   END IF 
      
   END IF
   CALL afap210_display()
END FUNCTION

################################################################################
# Descriptions...: 分割
# Memo...........:
# Usage..........: CALL afap210_comminute()
# Input parameter: 无
# Return code....: 无
# Date & Author..: 2014/12/14 By yangxf
# Modify.........:
################################################################################
PRIVATE FUNCTION afap210_comminute()
   DEFINE l_n      LIKE type_t.num5
   
   LET l_n = 0
   #检查分割资料是否大于1
   SELECT COUNT(*) INTO l_n
     FROM afap210_tmp
    WHERE sel = 'Y'
      AND pout = 'N'
      AND produce = 'N'
      AND pin = 'N'
   IF l_n > 1 THEN 
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code   = "afa-00337"
      LET g_errparam.popup  = TRUE 
      CALL cl_err()
      RETURN 
   END IF 
   IF l_n = 0 THEN 
      RETURN 
   END IF 
#   #检查被分割资料数量是否小于等于1
#   SELECT COUNT(*) INTO l_n
#     FROM afap210_tmp
#    WHERE sel = 'Y'
#      AND pout = 'N'
#      AND pin = 'N'
#      AND faak018 <= 1
#   IF l_n > 0 THEN 
#      INITIALIZE g_errparam TO NULL 
#      LET g_errparam.extend = "" 
#      LET g_errparam.code   = "afa-00338"
#      LET g_errparam.popup  = TRUE 
#      CALL cl_err()
#      RETURN 
#   END IF 
   SELECT faak000,faak001,faak003,faak004,faak018,faak019,faak022                 #160426-00014#37 add faak018,faak019,faak022 lujh 
     INTO g_faak000,g_faak001,g_faak003,g_faak004,g_faak018,g_faak019,g_faak022   #160426-00014#37 add faak018,faak019,faak022 lujh
     FROM afap210_tmp 
    WHERE sel = 'Y'
      AND pout = 'N'
      AND produce = 'N'
      AND pin = 'N'
   LET g_flag = 'Y'
   CALL afap210_01_open()
   IF g_flag = 'Y' THEN 
      UPDATE afap210_tmp SET pout = 'Y'
       WHERE sel = 'Y'
         AND pout = 'N'
         AND produce = 'N'
         AND pin = 'N'
      IF SQLCA.SQLcode  THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "UPD afap210_tmp" 
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = TRUE 
         CALL cl_err()                  
         RETURN 
      END IF 
   END IF 
   CALL afap210_display()
END FUNCTION

################################################################################
# Descriptions...: 財编资料维护
# Memo...........:
# Usage..........: CALL afap210_02_open()
# Input parameter: 无
# Return code....: 无
# Date & Author..: 2014/12/14 By yangxf
# Modify.........:
################################################################################
PRIVATE FUNCTION afap210_02_open()
DEFINE lwin_curr       ui.Window
DEFINE lfrm_curr       ui.Form
DEFINE ls_path         STRING
DEFINE l_ooef017       LIKE ooef_t.ooef017
DEFINE l_n             LIKE type_t.num5
DEFINE l_success       LIKE type_t.num5
DEFINE l_faah001       LIKE faah_t.faah001
DEFINE l_faah001_2     LIKE faah_t.faah001
DEFINE l_faah001_3     LIKE faah_t.faah001
DEFINE l_count         LIKE type_t.num5
DEFINE l_count1        LIKE type_t.num5
DEFINE l_sql           STRING                 #150803-00002#1

#150311---earl---add---s
DEFINE l_oofg_return    DYNAMIC ARRAY OF RECORD
                oofg019     LIKE oofg_t.oofg019,   #field
                oofg020     LIKE oofg_t.oofg020    #value
                        END RECORD
#150311---earl---add---e 

   INITIALIZE g_faah_m.* TO NULL
   #開啟畫面
   OPEN WINDOW w_afap210_s02 WITH FORM cl_ap_formpath("afa","afap210_s02")
   CALL cl_ui_init()
   CALL cl_set_combo_scc('faah002','9911')
   LET lwin_curr = ui.Window.getCurrent()
   LET lfrm_curr = lwin_curr.getForm()
   LET ls_path = os.Path.join(os.Path.join(FGL_GETENV("ERP"),"cfg"),"4tb")
   LET ls_path = os.Path.join(ls_path,"toolbar_lib.4tb")
   CALL lfrm_curr.loadToolBar(ls_path)
   LET g_faah_m.faah002 = '1' 
   LET g_faah_m.faah004 = ' ' 
   IF g_para_data = 'N' THEN 
      CALL cl_set_comp_entry("faah001",TRUE)
   ELSE
      CALL cl_set_comp_entry("faah001",FALSE)
   END IF
   IF g_para_data2 = 'Y' AND g_faah_m.faah002 = '1' THEN
      CALL cl_set_comp_entry("faah003",FALSE)
   ELSE
      CALL cl_set_comp_entry("faah003",TRUE)  
   END IF
   IF g_para_data = 'Y' THEN
      CALL afap210_get_faah001() RETURNING g_faah_m.faah001
   END IF
   IF g_para_data2 = 'Y' AND g_faah_m.faah002 = '1' THEN          
      LET g_faah_m.faah003 = g_faah_m.faah001
   END IF
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
      INPUT BY NAME g_faah_m.faah002,g_faah_m.faah001,g_faah_m.faah003,g_faah_m.faah004,g_faah_m.faah006,g_faah_m.faah007,g_faah_m.faah018,g_faah_m.faah014 ATTRIBUTE(WITHOUT DEFAULTS)  #150803-00002#1 add faah006,faah007 #160525-00040#1 add faah018  #161102-00025#2 add ,g_faah_m.faah014
          BEFORE INPUT 
            IF g_faah_m.faah002 = '1' THEN 
              LET g_faah_m.faah004 = ' '
              DISPLAY BY NAME g_faah_m.faah004
              CALL cl_set_comp_entry("faah004",FALSE)
            ELSE
              LET g_faah_m.faah004 = ''
              CALL cl_set_comp_entry("faah004",TRUE)
            END IF
            LET g_faah_m.faah014 = g_today   #161102-00025#2 add xul  
            #150803-00002#1 add---str
            LET l_sql = " SELECT t2.faak006,t2.faak007 FROM afap210_tmp t1,faak_t t2",
                        "  WHERE t1.faak001 = t2.faak001 AND t1.faak003 = t2.faak003",
                        "    AND t1.faak004 = t2.faak004 AND t2.faak002 = '1' ",
                        "    AND t1.sel = 'Y'",
                        "  ORDER BY t1.faak001,t1.faak003,t1.faak004"
            PREPARE faak_first_prep FROM l_sql
            DECLARE faak_first_curs SCROLL CURSOR FOR faak_first_prep
            OPEN faak_first_curs
            FETCH FIRST faak_first_curs INTO g_faah_m.faah006,g_faah_m.faah007
            CLOSE faak_first_curs
            DISPLAY BY NAME g_faah_m.faah006,g_faah_m.faah007
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_faah_m.faah006
            CALL ap_ref_array2(g_ref_fields,"SELECT faacl003 FROM faacl_t WHERE faaclent='"||g_enterprise||"' AND faacl001=? AND faacl002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_faah_m.faah006_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_faah_m.faah006_desc
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_faah_m.faah007
            CALL ap_ref_array2(g_ref_fields,"SELECT faadl003 FROM faadl_t WHERE faadlent='"||g_enterprise||"' AND faadl001=? AND faadl002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_faah_m.faah007_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_faah_m.faah007_desc
            #150803-00002#1 add---end
          
          BEFORE FIELD faah002
             LET g_faah002_t = g_faah_m.faah002
             
          ON CHANGE faah002
            IF g_faah_m.faah002 = '1' THEN 
               LET g_faah_m.faah003 = ''
               LET g_faah_m.faah004 = ' '
               CALL cl_set_comp_entry("faah004",FALSE)
            ELSE
               LET g_faah_m.faah003 = ''
               LET g_faah_m.faah004 = ''
               CALL cl_set_comp_entry("faah004",TRUE)
            END IF
            IF g_para_data2 = 'Y' AND g_faah_m.faah002 = '1' THEN
               CALL cl_set_comp_entry("faah003",FALSE)               
               LET g_faah_m.faah003 = g_faah_m.faah001
               DISPLAY BY NAME g_faah_m.faah003
               IF NOT cl_null(g_faah_m.faah001) AND NOT cl_null(g_faah_m.faah003) AND g_faah_m.faah004 IS NOT NULL THEN 
                  IF g_faah_m.faah002 != g_faah002_t THEN
                     IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM faah_t WHERE "||"faahent = '" ||g_enterprise|| "' AND " || "faah001 = '"||g_faah_m.faah001 ||"' AND "|| "faah003 = '"||g_faah_m.faah003 ||"' AND "|| "faah004 = '"||g_faah_m.faah004 ||"'",'std-00004',0) THEN  
                        LET g_faah_m.faah002 = ''
                        NEXT FIELD faah002
                     END IF
                     IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM afap210_tmp WHERE "||"faah003 = '"||g_faah_m.faah003 ||"' AND "|| " faah001 = '"||g_faah_m.faah001 ||"' AND " || "faah004 = '"||g_faah_m.faah004 ||"'",'std-00004',0) THEN 
                        NEXT FIELD CURRENT
                     END IF
                  END IF
               END IF
            ELSE
               CALL cl_set_comp_entry("faah003",TRUE)    
            END IF

         AFTER FIELD faah001
             IF g_para_data = 'N' THEN
                SELECT lpad(g_faah_m.faah001,10,'0') INTO g_faah_m.faah001
                  FROM faah_t
                 WHERE faahent = g_enterprise
                DISPLAY BY NAME g_faah_m.faah001
             END IF 
             IF g_para_data2 = 'Y' AND g_faah_m.faah002 = '1' THEN
                CALL cl_set_comp_entry("faah003",FALSE)               
                LET g_faah_m.faah003 = g_faah_m.faah001
                DISPLAY BY NAME g_faah_m.faah003
             ELSE
                CALL cl_set_comp_entry("faah003",TRUE)  
             END IF
            IF NOT cl_null(g_faah_m.faah003) AND g_faah_m.faah004 IS NOT NULL AND NOT cl_null(g_faah_m.faah001) THEN
               IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM faah_t WHERE "||"faahent = '" ||g_enterprise|| "' AND "|| " faah001 = '"||g_faah_m.faah001 ||"' AND "|| "faah003 = '"||g_faah_m.faah003 ||"' AND "|| "faah004 = '"||g_faah_m.faah004 ||"'",'std-00004',0) THEN 
                  NEXT FIELD CURRENT
               END IF
               IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM afap210_tmp WHERE "||"faah003 = '"||g_faah_m.faah003 ||"' AND "|| " faah001 = '"||g_faah_m.faah001 ||"' AND "|| "faah004 = '"||g_faah_m.faah004 ||"'",'std-00004',0) THEN 
                  NEXT FIELD CURRENT
               END IF
            END IF

         BEFORE FIELD faah003
            IF g_para_data2 <> 'Y' THEN
               IF cl_null(g_faah_m.faah003) AND g_faah_m.faah002 = '1' THEN
                  IF g_para_data3 = 'Y' AND g_para_data2 ='N' THEN
                     #150311---earl---mod---s
                     #CALL s_aooi390('3') RETURNING l_success,g_faah_m.faah003
#                     CALL s_aooi390_auto_no('3') RETURNING l_success,g_faah_m.faah003,l_oofg_return  #mark--2015/05/07 By shiun
                     #150311---earl---mod---e
                     CALL s_aooi390_gen('3') RETURNING l_success,g_faah_m.faah003,l_oofg_return   #add--2015/05/07 By shiun
                     DISPLAY BY NAME g_faah_m.faah003
                     LET g_faah003_t = g_faah_m.faah003
                  END IF
               END IF
            END IF
            
         AFTER FIELD faah003
            IF NOT cl_null(g_faah_m.faah003) AND g_faah_m.faah004 IS NOT NULL AND NOT cl_null(g_faah_m.faah001) THEN
               IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM faah_t WHERE "||"faahent = '" ||g_enterprise|| "' AND "|| " faah001 = '"||g_faah_m.faah001 ||"' AND "|| "faah003 = '"||g_faah_m.faah003 ||"' AND "|| "faah004 = '"||g_faah_m.faah004 ||"'",'std-00004',0) THEN 
                  NEXT FIELD CURRENT
               END IF
               IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM afap210_tmp WHERE "||"faah003 = '"||g_faah_m.faah003 ||"' AND "|| " faah001 = '"||g_faah_m.faah001 ||"' AND "|| "faah004 = '"||g_faah_m.faah004 ||"'",'std-00004',0) THEN 
                  NEXT FIELD CURRENT
               END IF
               #add--2015/05/08 By shiun--(S)
               IF NOT s_aooi390_chk('3',g_faah_m.faah003) THEN
                  LET g_faah_m.faah003 = g_faah003_t
                  DISPLAY BY NAME g_faah_m.faah003
                  NEXT FIELD CURRENT
               END IF
               #add--2015/05/08 By shiun--(E)
            END IF
            IF NOT afap210_faah003_chk() THEN
               NEXT FIELD faah003
            END IF
            #2015/02/15 Add By 01727 客户家财产编号Key值,重复需要提醒,但不需要卡死
            #2015/02/15 Add ---(S)---
            IF NOT cl_null(g_faah_m.faah003) AND NOT cl_null(g_faah_m.faah002) AND g_faah_m.faah002 = '1' THEN  #类型为主件时候才需要判断
               LET l_count = 0
               SELECT COUNT(*) INTO l_count FROM faah_t WHERE faahent = g_enterprise
                  AND faah003 = g_faah_m.faah003
               IF cl_null(l_count) THEN lET l_count = 0 END IF
               IF l_count > 0 THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'afa-00449'
                  LET g_errparam.extend = ''
                  LET g_errparam.popup = TRUE 
                  CALL cl_err()
               END IF
            END IF
            #2015/02/15 Add ---(E)---
            
         AFTER FIELD faah004
            IF NOT cl_null(g_faah_m.faah003) AND g_faah_m.faah004 IS NOT NULL AND NOT cl_null(g_faah_m.faah001) THEN
               IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM faah_t WHERE "||"faahent = '" ||g_enterprise|| "' AND "|| " faah001 = '"||g_faah_m.faah001 ||"' AND "|| "faah003 = '"||g_faah_m.faah003 ||"' AND "|| "faah004 = '"||g_faah_m.faah004 ||"'",'std-00004',0) THEN 
                  NEXT FIELD CURRENT
               END IF
               IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM afap210_tmp WHERE "||"faah003 = '"||g_faah_m.faah003 ||"' AND "|| " faah001 = '"||g_faah_m.faah001 ||"' AND "|| "faah004 = '"||g_faah_m.faah004 ||"'",'std-00004',0) THEN 
                  NEXT FIELD CURRENT
               END IF
            END IF
         
         #150803-00002#1 add--str
         AFTER FIELD faah006
            IF NOT cl_null(g_faah_m.faah006) THEN
#此段落由子樣板a19產生
               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
               INITIALIZE g_chkparam.* TO NULL
                
               #設定g_chkparam.*的參數
               LET g_chkparam.arg1 = g_faah_m.faah006
               #160318-00025#5--add--str
               LET g_errshow = TRUE 
               LET g_chkparam.err_str[1] = "afa-00007:sub-01302|afai020|",cl_get_progname("afai020",g_lang,"2"),"|:EXEPROGafai020"
               #160318-00025#5--add--end 
                
               #呼叫檢查存在並帶值的library
               IF cl_chk_exist("v_faac001") THEN
                  #檢查成功時後續處理
                  #LET  = g_chkparam.return1
                  #DISPLAY BY NAME
                
               ELSE
                  #檢查失敗時後續處理
                  LET g_faah_m.faah006 = ''
                  INITIALIZE g_ref_fields TO NULL
                  LET g_ref_fields[1] = g_faah_m.faah006
                  CALL ap_ref_array2(g_ref_fields,"SELECT faacl003 FROM faacl_t WHERE faaclent='"||g_enterprise||"' AND faacl001=? AND faacl002='"||g_dlang||"'","") RETURNING g_rtn_fields
                  LET g_faah_m.faah006_desc = '', g_rtn_fields[1] , ''
                  DISPLAY BY NAME g_faah_m.faah006_desc
                  NEXT FIELD CURRENT
               END IF
               INITIALIZE g_ref_fields TO NULL
               LET g_ref_fields[1] = g_faah_m.faah006
               CALL ap_ref_array2(g_ref_fields,"SELECT faacl003 FROM faacl_t WHERE faaclent='"||g_enterprise||"' AND faacl001=? AND faacl002='"||g_dlang||"'","") RETURNING g_rtn_fields
               LET g_faah_m.faah006_desc = '', g_rtn_fields[1] , ''
               DISPLAY BY NAME g_faah_m.faah006_desc
            END IF
            
         AFTER FIELD faah007
            IF NOT cl_null(g_faah_m.faah007) THEN
#此段落由子樣板a19產生
               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
               INITIALIZE g_chkparam.* TO NULL

               #設定g_chkparam.*的參數
               LET g_chkparam.arg1 = g_faah_m.faah007
               #160318-00025#5--add--str
               LET g_errshow = TRUE 
               LET g_chkparam.err_str[1] = "afa-00009:sub-01302|afai030|",cl_get_progname("afai030",g_lang,"2"),"|:EXEPROGafai030"
               #160318-00025#5--add--end

               #呼叫檢查存在並帶值的library
               IF cl_chk_exist("v_faad001") THEN
                  #檢查成功時後續處理
                  #LET  = g_chkparam.return1
                  #DISPLAY BY NAME
                  IF NOT cl_null(g_faah_m.faah006) THEN
                     SELECT COUNT(*) INTO l_n
                       FROM faad_t
                      WHERE faadent = g_enterprise
                        AND faad001 = g_faah_m.faah007
                        AND faad002 = g_faah_m.faah006

                     IF l_n = 0 THEN
                        INITIALIZE g_errparam TO NULL
                        LET g_errparam.extend = g_faah_m.faah007
                        LET g_errparam.code   = 'afa-01028'
                        LET g_errparam.popup  = TRUE
                        CALL cl_err()
                        LET g_faah_m.faah007 = ''
                        NEXT FIELD CURRENT
                     END IF
                  END IF
               ELSE
                  #檢查失敗時後續處理
                  LET g_faah_m.faah007 = ''
                  INITIALIZE g_ref_fields TO NULL
                  LET g_ref_fields[1] = g_faah_m.faah007
                  CALL ap_ref_array2(g_ref_fields,"SELECT faadl003 FROM faadl_t WHERE faadlent='"||g_enterprise||"' AND faadl001=? AND faadl002='"||g_dlang||"'","") RETURNING g_rtn_fields
                  LET g_faah_m.faah007_desc = '', g_rtn_fields[1] , ''
                  DISPLAY BY NAME g_faah_m.faah007_desc
                  NEXT FIELD CURRENT
               END IF

               INITIALIZE g_ref_fields TO NULL
               LET g_ref_fields[1] = g_faah_m.faah007
               CALL ap_ref_array2(g_ref_fields,"SELECT faadl003 FROM faadl_t WHERE faadlent='"||g_enterprise||"' AND faadl001=? AND faadl002='"||g_dlang||"'","") RETURNING g_rtn_fields
               LET g_faah_m.faah007_desc = '', g_rtn_fields[1] , ''
               DISPLAY BY NAME g_faah_m.faah007_desc
            END IF
         
         #Ctrlp:input.c.faah006
         #應用 a03 樣板自動產生(Version:2)
         ON ACTION controlp INFIELD faah006
            #add-point:ON ACTION controlp INFIELD faah006
            #此段落由子樣板a07產生
            #開窗i段
                        INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
                        LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_faah_m.faah006             #給予default值

            #給予arg

            CALL q_faac001()                                #呼叫開窗

            LET g_faah_m.faah006 = g_qryparam.return1              #將開窗取得的值回傳到變數

            DISPLAY g_faah_m.faah006 TO faah006              #顯示到畫面上
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_faah_m.faah006
            CALL ap_ref_array2(g_ref_fields,"SELECT faacl003 FROM faacl_t WHERE faaclent='"||g_enterprise||"' AND faacl001=? AND faacl002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_faah_m.faah006_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_faah_m.faah006_desc
            NEXT FIELD faah006                          #返回原欄位


            #END add-point

         #Ctrlp:input.c.faah007
         #應用 a03 樣板自動產生(Version:2)
         ON ACTION controlp INFIELD faah007
            #add-point:ON ACTION controlp INFIELD faah007
            #此段落由子樣板a07產生
            #開窗i段
                           INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
                           LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_faah_m.faah007             #給予default值
            IF NOT cl_null(g_faah_m.faah006) THEN
               LET g_qryparam.where = " faad002 = '",g_faah_m.faah006,"'"
            END IF
            #給予arg

            CALL q_faad001()                                #呼叫開窗

            LET g_faah_m.faah007 = g_qryparam.return1              #將開窗取得的值回傳到變數
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_faah_m.faah007
            CALL ap_ref_array2(g_ref_fields,"SELECT faadl003 FROM faadl_t WHERE faadlent='"||g_enterprise||"' AND faadl001=? AND faadl002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_faah_m.faah007_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_faah_m.faah007_desc

            DISPLAY g_faah_m.faah007 TO faah007              #顯示到畫面上
            NEXT FIELD faah007                          #返回原欄位


            #END add-point
         
         ON ACTION controlp INFIELD faah003
            IF g_faah_m.faah002 = '2' OR g_faah_m.faah002 = '3' THEN
			      INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'i'
			      LET g_qryparam.reqry = FALSE
               LET g_qryparam.default1 = g_faah_m.faah003
               CALL q_faah003()
               LET g_faah_m.faah003 = g_qryparam.return1 
               LET g_qryparam.where = " "
               DISPLAY g_faah_m.faah003 TO faah003              #顯示到畫面上
               NEXT FIELD faah003                          #返回原欄位
            END IF
      END INPUT
      ON ACTION exit
         LET g_action_choice="exit"
         EXIT DIALOG
 
      ON ACTION accept
         ACCEPT DIALOG 
         
      ON ACTION cancel
         LET INT_FLAG = 1
         EXIT DIALOG   

      ON ACTION close
         LET INT_FLAG = 1         
         LET g_action_choice = "exit"
         EXIT DIALOG 
   END DIALOG
   CLOSE WINDOW w_afap210_s02
      
END FUNCTION

################################################################################
# Descriptions...: 財编检查
# Memo...........:
# Usage..........: CALL afap210_faah003_chk()
# Input parameter: 无
# Return code....: 状态码
# Date & Author..: 2014/12/14 By yangxf
# Modify.........:
################################################################################
PRIVATE FUNCTION afap210_faah003_chk()
   DEFINE l_n      LIKE type_t.num5
   
   IF NOT cl_null(g_faah_m.faah002) AND NOT cl_null(g_faah_m.faah003) AND g_faah_m.faah002 <> '1' THEN 
      SELECT count(*) INTO l_n 
        FROM faah_t
       WHERE faahent = g_enterprise
         AND faah003 = g_faah_m.faah003
         AND faah002 = '1'
         
      IF l_n = 0 THEN 
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = 'afa-00016'
         LET g_errparam.extend = ''
         LET g_errparam.popup = TRUE
         CALL cl_err()
         RETURN FALSE
      END IF 
   END IF
   
   RETURN TRUE
END FUNCTION

################################################################################
# Descriptions...: 显示单身数据
# Memo...........:
# Usage..........: CALL afap210_display()
# Input parameter: 无
# Return code....: 无
# Date & Author..: 2014/12/15 By yangxf
# Modify.........:
################################################################################
PRIVATE FUNCTION afap210_display()
   DEFINE l_cnt   LIKE type_t.num5 
   
   LET l_cnt = 1
   DECLARE afap210_curs CURSOR FOR SELECT * FROM afap210_tmp ORDER BY faak000,faak001,faak003,faak004
   FOREACH afap210_curs INTO g_detail_d[l_cnt].*
   
      LET l_cnt = l_cnt +1
   END FOREACH 
   CALL g_detail_d.deleteElement(l_cnt)
   LET g_detail_cnt = l_cnt - 1
   
   DISPLAY ARRAY g_detail_d TO s_detail1.* ATTRIBUTE(COUNT=g_detail_cnt)
      BEFORE DISPLAY
        EXIT DISPLAY 
        
   END DISPLAY    
END FUNCTION

################################################################################
# Descriptions...: 描述说明
# Memo...........:
# Usage..........: CALL afap210_01_open()
# Input parameter: 無
# Return code....: 無
# Date & Author..: 2014/12/15 By yangxf
# Modify.........:
################################################################################
PRIVATE FUNCTION afap210_01_open()
DEFINE lwin_curr       ui.Window
DEFINE lfrm_curr       ui.Form
DEFINE ls_path         STRING
DEFINE l_n             LIKE type_t.num5
DEFINE l_faah018       LIKE faah_t.faah018
DEFINE l_success       LIKE type_t.num5
DEFINE l_insert        BOOLEAN
DEFINE l_faah022       LIKE faah_t.faah022
DEFINE p_cmd           LIKE type_t.chr1
DEFINE l_count         LIKE type_t.num5
DEFINE l_count1        LIKE type_t.num5

#150311---earl---add---s
DEFINE l_oofg_return    DYNAMIC ARRAY OF RECORD
                oofg019     LIKE oofg_t.oofg019,   #field
                oofg020     LIKE oofg_t.oofg020    #value
                        END RECORD
#150311---earl---add---e 

   #開啟畫面
   OPEN WINDOW w_afap210_s01 WITH FORM cl_ap_formpath("afa","afap210_s01")
   CALL cl_ui_init()
   LET lwin_curr = ui.Window.getCurrent()
   LET lfrm_curr = lwin_curr.getForm()
   LET INT_FLAG = 0  #161102-00025#2  add    
   LET ls_path = os.Path.join(os.Path.join(FGL_GETENV("ERP"),"cfg"),"4tb")
   LET ls_path = os.Path.join(ls_path,"toolbar_lib.4tb")
   CALL lfrm_curr.loadToolBar(ls_path)
   IF g_para_data = 'N' THEN 
      CALL cl_set_comp_entry("b_faah001",TRUE)
   ELSE
      CALL cl_set_comp_entry("b_faah001",FALSE)
   END IF
   CALL cl_set_combo_scc('b_faah002','9911')
   CALL afap210_01_b_fill()
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
      INPUT ARRAY g_detail1_d FROM s_detail2.*
         ATTRIBUTE(COUNT = g_rec_b1,MAXCOUNT = g_max_rec,WITHOUT DEFAULTS, 
               INSERT ROW = TRUE, 
               DELETE ROW = TRUE,
               APPEND ROW = TRUE)   
         
      BEFORE ROW         
         LET l_insert = FALSE             
         LET l_ac1 = ARR_CURR()
         LET g_detail_idx = l_ac1      
         LET l_n = ARR_COUNT()
         IF g_rec_b1 >= l_ac1 THEN 
            LET p_cmd = 'u'
            #LET g_detail1_d_t.* = g_detail1_d[l_ac].* #161130-00031#1 mark
            LET g_detail1_d_t.* = g_detail1_d[l_ac1].* #161130-00031#1 add
         END IF 
        
         
      BEFORE INSERT
         LET p_cmd = 'a'
         INITIALIZE g_detail1_d_t.* TO NULL
         LET l_n = ARR_COUNT()
         INITIALIZE g_detail1_d[l_ac1].* TO NULL
         SELECT MAX(flag) + 1 INTO g_detail1_d[l_ac1].flag
           FROM afap210_01_tmp
          WHERE faak000 = g_faak000
            AND faak001 = g_faak001
            AND faak003 = g_faak003
            AND faak004 = g_faak004
         IF cl_null(g_detail1_d[l_ac1].flag) THEN 
            LET g_detail1_d[l_ac1].flag = 1
         END IF 
         SELECT faak000,faak001,faak003,faak004,faak019,faak018,faak022
           INTO g_detail1_d[l_ac1].faak000,g_detail1_d[l_ac1].faak001,
                g_detail1_d[l_ac1].faak003,g_detail1_d[l_ac1].faak004,
                g_detail1_d[l_ac1].faak019,g_faak018,g_faak022
           FROM afap210_tmp
          WHERE faak000 = g_faak000
            AND faak001 = g_faak001
            AND faak003 = g_faak003
            AND faak004 = g_faak004
         LET g_detail1_d[l_ac1].faak018 = g_faak018
         LET g_detail1_d[l_ac1].faah018 = 1 
         LET g_detail1_d[l_ac1].faah002 = '1'
         LET g_detail1_d[l_ac1].faah003 = ''
         LET g_detail1_d[l_ac1].faah004 = ' '
         LET g_detail1_d[l_ac1].faah014 = g_today   #161102-00025#2 add xul 
         
         CALL cl_set_comp_entry("b_faah004",FALSE)
         IF g_para_data = 'Y' THEN
            CALL afap210_get_faah001() RETURNING g_detail1_d[l_ac1].faah001
         END IF
         IF g_para_data2 = 'Y' AND g_detail1_d[l_ac1].faah002 = '1' THEN
            CALL cl_set_comp_entry("b_faah003",FALSE)
            LET g_detail1_d[l_ac1].faah003 = g_detail1_d[l_ac1].faah001
         ELSE
            CALL cl_set_comp_entry("b_faah003",TRUE)  
         END IF
               
      AFTER INSERT
         IF INT_FLAG THEN
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = '' 
            LET g_errparam.code   = 9001 
            LET g_errparam.popup  = FALSE 
            CALL cl_err()
            LET INT_FLAG = 0
            CANCEL INSERT
         END IF
         #160426-00014#37--mark--str--lujh
         #INSERT INTO afap210_01_tmp VALUES(g_detail1_d[l_ac1].*)
         #IF SQLCA.SQLcode  THEN
         #   INITIALIZE g_errparam TO NULL 
         #   LET g_errparam.extend = "INTO afap210_01_tmp" 
         #   LET g_errparam.code   = SQLCA.sqlcode 
         #   LET g_errparam.popup  = TRUE 
         #   CALL cl_err()
         #   CANCEL INSERT
         #END IF 
         #160426-00014#37--mark--end--lujh
         
      BEFORE DELETE 
         IF NOT cl_ask_del_detail() THEN
            CANCEL DELETE
         END IF
         DELETE FROM afap210_01_tmp
          WHERE faak000 = g_faak000
            AND faak001 = g_faak001
            AND faak003 = g_faak003
            AND faak004 = g_faak004
            #AND flag = g_detail1_d[l_ac1].flag #161130-00031#1 mark
            AND flag = g_detail1_d[l_ac1].flag  #161130-00031#1 add
            
         IF SQLCA.SQLcode  THEN
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "INTO afap210_01_tmp" 
            LET g_errparam.code   = SQLCA.sqlcode 
            LET g_errparam.popup  = TRUE 
            CALL cl_err()                  
            CANCEL DELETE
         END IF 

         #161130-00031#1 add s---
         AFTER DELETE
            #如果是最後一筆
            IF l_ac1 = (g_detail1_d.getLength() + 1) THEN
               CALL FGL_SET_ARR_CURR(l_ac1-1)
            END IF
         #161130-00031#1 add e---
         
      ON ROW CHANGE 
         IF INT_FLAG THEN
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = '' 
            LET g_errparam.code   = 9001 
            LET g_errparam.popup  = FALSE 
            CALL cl_err()
            LET INT_FLAG = 0
            LET g_detail1_d[l_ac1].* = g_detail1_d_t.*
            EXIT DIALOG 
         END IF
         UPDATE afap210_01_tmp SET faah018 = g_detail1_d[l_ac1].faah018,
                                   faah022 = g_detail1_d[l_ac1].faah022,
                                   faah001 = g_detail1_d[l_ac1].faah001,
                                   faah002 = g_detail1_d[l_ac1].faah002,
                                   faah003 = g_detail1_d[l_ac1].faah003,
                                   faah004 = g_detail1_d[l_ac1].faah004,
                                   faah014 = g_detail1_d[l_ac1].faah014, #161102-00025#2 add xul
                                   #albireo 160111-----s
                                   l_oofg001_t1 = g_detail1_d[l_ac1].l_oofg001_t1  ,
                                   l_before_code = g_detail1_d[l_ac1].l_before_code ,
                                   l_num_code = g_detail1_d[l_ac1].l_num_code    ,
                                   l_after_code = g_detail1_d[l_ac1].l_after_code  
                                   #albireo 160111-----e
          WHERE faak000 = g_faak000
            AND faak001 = g_faak001
            AND faak003 = g_faak003
            AND faak004 = g_faak004
            AND flag = g_detail1_d[l_ac1].flag
         IF SQLCA.SQLcode  THEN
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "INTO afap210_01_tmp" 
            LET g_errparam.code   = SQLCA.sqlcode 
            LET g_errparam.popup  = TRUE 
            CALL cl_err()                  
            EXIT DIALOG 
         END IF 
         
         ON CHANGE b_faah002
            IF g_detail1_d[l_ac1].faah002 = '1' THEN 
               LET g_detail1_d[l_ac1].faah003 = ''
               LET g_detail1_d[l_ac1].faah004 = ' '
               CALL cl_set_comp_entry("b_faah004",FALSE)
            ELSE
               LET g_detail1_d[l_ac1].faah003 = ''
               LET g_detail1_d[l_ac1].faah004 = ''
               CALL cl_set_comp_entry("b_faah004",TRUE)
            END IF 
            IF g_para_data2 = 'Y' AND g_detail1_d[l_ac1].faah002 = '1' THEN
               CALL cl_set_comp_entry("b_faah003",FALSE)               
               LET g_detail1_d[l_ac1].faah003 = g_detail1_d[l_ac1].faah001
               IF NOT cl_null(g_detail1_d[l_ac1].faah001) AND NOT cl_null(g_detail1_d[l_ac1].faah003) AND g_detail1_d[l_ac1].faah004 IS NOT NULL THEN 
                  IF p_cmd = 'a' OR ( p_cmd = 'u' AND ( g_detail1_d[l_ac1].faah002 != g_detail1_d_t.faah002)) THEN
                     IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM faah_t WHERE "||"faahent = '" ||g_enterprise|| "' AND "|| "faah001 = '"||g_detail1_d[l_ac1].faah001 ||"' AND "|| "faah003 = '"||g_detail1_d[l_ac1].faah003 ||"' AND "|| "faah004 = '"||g_detail1_d[l_ac1].faah004 ||"'",'std-00004',0) THEN 
                        NEXT FIELD CURRENT
                     END IF
                     IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM afap210_tmp WHERE "|| "faah003 = '"||g_detail1_d[l_ac1].faah003 ||"' AND "|| "faah001 = '"||g_detail1_d[l_ac1].faah001 ||"' AND "|| "faah004 = '"||g_detail1_d[l_ac1].faah004 ||"'",'std-00004',0) THEN 
                        NEXT FIELD CURRENT
                     END IF
                     LET l_n = 0
                     SELECT COUNT(*) INTO l_n
                       FROM afap210_01_tmp 
                      WHERE flag <> g_detail1_d[l_ac1].flag
                        AND faah003 = g_detail1_d[l_ac1].faah003
                        AND faah004 = g_detail1_d[l_ac1].faah004
                        AND faah001 = g_detail1_d[l_ac1].faah001
                     IF l_n > 0 THEN 
                        INITIALIZE g_errparam TO NULL 
                        LET g_errparam.extend = '' 
                        LET g_errparam.code   = 'std-00004'
                        LET g_errparam.popup  = FALSE 
                        CALL cl_err()
                        NEXT FIELD b_faah004
                     END IF 
                  END IF 
               END IF
            ELSE
               CALL cl_set_comp_entry("b_faah003",TRUE)    
            END IF
            
         AFTER FIELD b_faah001
             IF g_para_data = 'N' THEN
                SELECT lpad(g_detail1_d[l_ac1].faah001,10,'0') INTO g_detail1_d[l_ac1].faah001
                  FROM faah_t
                 WHERE faahent = g_enterprise
                DISPLAY BY NAME g_detail1_d[l_ac1].faah001
             END IF 
             IF g_para_data2 = 'Y' AND g_detail1_d[l_ac1].faah002 = '1' THEN
                CALL cl_set_comp_entry("b_faah003",FALSE)               
                LET g_detail1_d[l_ac1].faah003 = g_detail1_d[l_ac1].faah001
                DISPLAY BY NAME g_detail1_d[l_ac1].faah003
             ELSE
                CALL cl_set_comp_entry("b_faah003",TRUE)  
             END IF
            IF p_cmd = 'a' OR ( p_cmd = 'u' AND ( g_detail1_d[l_ac1].faah001 != g_detail1_d_t.faah001)) THEN
               IF  NOT cl_null(g_detail1_d[l_ac1].faah003) AND NOT cl_null(g_detail1_d[l_ac1].faah001) AND g_detail1_d[l_ac1].faah004 IS NOT NULL THEN
                   IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM faah_t WHERE "||"faahent = '" ||g_enterprise|| "' AND "|| "faah001 = '"||g_detail1_d[l_ac1].faah001 ||"' AND "|| "faah003 = '"||g_detail1_d[l_ac1].faah003 ||"' AND "|| "faah004 = '"||g_detail1_d[l_ac1].faah004 ||"'",'std-00004',0) THEN 
                      NEXT FIELD CURRENT
                   END IF
                   IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM afap210_tmp WHERE "|| "faah003 = '"||g_detail1_d[l_ac1].faah003 ||"' AND "|| "faah001 = '"||g_detail1_d[l_ac1].faah001 ||"' AND "|| "faah004 = '"||g_detail1_d[l_ac1].faah004 ||"'",'std-00004',0) THEN 
                      NEXT FIELD CURRENT
                   END IF
                   LET l_n = 0
                   SELECT COUNT(*) INTO l_n
                     FROM afap210_01_tmp 
                    WHERE flag <> g_detail1_d[l_ac1].flag
                      AND faah003 = g_detail1_d[l_ac1].faah003
                      AND faah004 = g_detail1_d[l_ac1].faah004
                      AND faah001 = g_detail1_d[l_ac1].faah001
                   IF l_n > 0 THEN 
                      INITIALIZE g_errparam TO NULL 
                      LET g_errparam.extend = '' 
                      LET g_errparam.code   = 'std-00004'
                      LET g_errparam.popup  = FALSE 
                      CALL cl_err()
                      NEXT FIELD b_faah001
                   END IF 
               END IF
            END IF 
            
         BEFORE FIELD b_faah003
            IF g_para_data2 <> 'Y' THEN 
               IF cl_null(g_detail1_d[l_ac1].faah003) AND g_detail1_d[l_ac1].faah002 = '1' THEN
                  IF g_para_data3 = 'Y' AND g_para_data2 ='N' THEN 
                     #150311---earl---mod---s
                     #CALL s_aooi390('3') RETURNING l_success,g_detail1_d[l_ac1].faah003
#                     CALL s_aooi390_auto_no('3') RETURNING l_success,g_detail1_d[l_ac1].faah003,l_oofg_return
                     #150311---earl---mod---e
                     #CALL s_aooi390_gen('3') RETURNING l_success,g_detail1_d[l_ac1].faah003,l_oofg_return   #add--2015/05/07 By shiun   #151225-00014#1 mark
                     
                     #151225-00014#1-----s                    
                     CALL s_aooi390_gen_for_successive_1('3') 
                          RETURNING l_success,g_detail1_d[l_ac1].faah003,l_oofg_return, 
                                    g_detail1_d[l_ac1].l_oofg001_t1, 
                                    g_detail1_d[l_ac1].l_before_code, 
                                    g_detail1_d[l_ac1].l_num_code, 
                                    g_detail1_d[l_ac1].l_after_code                        
                     
                    DISPLAY BY NAME g_detail1_d[l_ac1].l_oofg001_t1,g_detail1_d[l_ac1].l_before_code,
                                     g_detail1_d[l_ac1].l_num_code,g_detail1_d[l_ac1].l_after_code                        
                     #151225-00014#1-----e
                     
                     #151225-00014#1 mark-----s
                     ##albireo 160111-----s
                     ##自動編碼後要將必要4欄位存入record方便之後INSER TEMP
                     #LET g_detail1_d[l_ac1].l_oofg001_t1  = g_oofg001_t1 CLIPPED
                     #LET g_detail1_d[l_ac1].l_before_code = g_before_code CLIPPED
                     #LET g_detail1_d[l_ac1].l_num_code    = g_num_code CLIPPED
                     #LET g_detail1_d[l_ac1].l_after_code  = g_after_code CLIPPED
                     #DISPLAY BY NAME g_detail1_d[l_ac1].l_oofg001_t1,g_detail1_d[l_ac1].l_before_code,
                     #                g_detail1_d[l_ac1].l_num_code,g_detail1_d[l_ac1].l_after_code
                     ##albrieo 160111-----e
                     #151225-00014#1 mark-----e
                  END IF 
               END IF
            END IF 
         
         #財编检查
         AFTER FIELD b_faah003
            IF p_cmd = 'a' OR ( p_cmd = 'u' AND ( g_detail1_d[l_ac1].faah003 != g_detail1_d_t.faah003)) THEN
               IF  NOT cl_null(g_detail1_d[l_ac1].faah003) AND NOT cl_null(g_detail1_d[l_ac1].faah001) AND g_detail1_d[l_ac1].faah004 IS NOT NULL THEN
                   ##151225-00014#1-----s 
                   IF NOT cl_null(g_detail1_d[l_ac1].faah003) THEN 
                      CALL s_aooi390_chk_for_successive('3',g_detail1_d[l_ac1].faah003, 
                                                        g_detail1_d[l_ac1].l_oofg001_t1, 
                                                        g_detail1_d[l_ac1].l_before_code, 
                                                        g_detail1_d[l_ac1].l_num_code, 
                                                        g_detail1_d[l_ac1].l_after_code) 
                           RETURNING l_success,g_detail1_d[l_ac1].l_oofg001_t1, 
                                               g_detail1_d[l_ac1].l_before_code, 
                                               g_detail1_d[l_ac1].l_num_code, 
                                               g_detail1_d[l_ac1].l_after_code 
                                               
                   END IF 
                   ##151225-00014#1-----e 
                   
                   IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM faah_t WHERE "||"faahent = '" ||g_enterprise|| "' AND "|| "faah001 = '"||g_detail1_d[l_ac1].faah001 ||"' AND "|| "faah003 = '"||g_detail1_d[l_ac1].faah003 ||"' AND "|| "faah004 = '"||g_detail1_d[l_ac1].faah004 ||"'",'std-00004',0) THEN 
                      NEXT FIELD CURRENT
                   END IF
                   IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM afap210_tmp WHERE "|| "faah003 = '"||g_detail1_d[l_ac1].faah003 ||"' AND "|| "faah001 = '"||g_detail1_d[l_ac1].faah001 ||"' AND "|| "faah004 = '"||g_detail1_d[l_ac1].faah004 ||"'",'std-00004',0) THEN 
                      NEXT FIELD CURRENT
                   END IF
                   LET l_n = 0
                   SELECT COUNT(*) INTO l_n
                     FROM afap210_01_tmp 
                    WHERE flag <> g_detail1_d[l_ac1].flag
                      AND faah003 = g_detail1_d[l_ac1].faah003
                      AND faah004 = g_detail1_d[l_ac1].faah004
                      AND faah001 = g_detail1_d[l_ac1].faah001
                   IF l_n > 0 THEN 
                      INITIALIZE g_errparam TO NULL 
                      LET g_errparam.extend = '' 
                      LET g_errparam.code   = 'std-00004'
                      LET g_errparam.popup  = FALSE 
                      CALL cl_err()
                      NEXT FIELD b_faah003
                   END IF 
                   
                   ##151225-00014#1-----s 
                   CALL s_aooi390_chk_for_successive('3',g_detail1_d[l_ac1].faah003, 
                                                     g_detail1_d[l_ac1].l_oofg001_t1, 
                                                     g_detail1_d[l_ac1].l_before_code, 
                                                     g_detail1_d[l_ac1].l_num_code, 
                                                     g_detail1_d[l_ac1].l_after_code) 
                        RETURNING l_success,g_detail1_d[l_ac1].l_oofg001_t1, 
                                            g_detail1_d[l_ac1].l_before_code, 
                                            g_detail1_d[l_ac1].l_num_code, 
                                            g_detail1_d[l_ac1].l_after_code                                             
                   ##151225-00014#1-----e 
                   
                   ##151225-00014#1 mark-----s
                   ##albireo 160111-----s
                   #LET g_oofg001_t1  = g_detail1_d[l_ac1].l_oofg001_t1  
                   #LET g_before_code = g_detail1_d[l_ac1].l_before_code 
                   #LET g_num_code    = g_detail1_d[l_ac1].l_num_code    
                   #LET g_after_code  = g_detail1_d[l_ac1].l_after_code  
                   ##albireo 160111-----e
                   ##add--2015/05/08 By shiun--(S)
                   #IF NOT s_aooi390_chk('2',g_detail1_d[l_ac1].faah003) THEN
                   #   LET g_detail1_d[l_ac1].faah003 = g_detail1_d_t.faah003
                   #   #albireo 160111-----s
                   #   LET g_oofg001_t1  = g_detail1_d[l_ac1].l_oofg001_t1  
                   #   LET g_before_code = g_detail1_d[l_ac1].l_before_code 
                   #   LET g_num_code    = g_detail1_d[l_ac1].l_num_code    
                   #   LET g_after_code  = g_detail1_d[l_ac1].l_after_code  
                   #   #albireo 160111-----e
                   #   DISPLAY BY NAME g_detail1_d[l_ac1].faah003
                   #   NEXT FIELD CURRENT
                   #END IF
                   ##add--2015/05/08 By shiun--(E)
                   ##albireo 160111-----s
                   #LET g_detail1_d[l_ac1].l_oofg001_t1  = g_oofg001_t1 
                   #LET g_detail1_d[l_ac1].l_before_code = g_before_code
                   #LET g_detail1_d[l_ac1].l_num_code    = g_num_code   
                   #LET g_detail1_d[l_ac1].l_after_code  = g_after_code 
                   #DISPLAY BY NAME g_detail1_d[l_ac1].l_after_code
                   ##albireo 160111-----e
                   ##151225-00014#1 mark-----s
               END IF
            END IF 
            IF NOT cl_null(g_detail1_d[l_ac1].faah003) THEN 
               IF NOT afap210_faah003_chk() THEN 
                  LET g_detail1_d[l_ac1].faah003 = ''
                  NEXT FIELD b_faah003
               END IF 

            END IF 
            #2015/02/15 Add By 01727 客户家财产编号Key值,重复需要提醒,但不需要卡死
            #2015/02/15 Add ---(S)---
            IF NOT cl_null(g_detail1_d[l_ac1].faah003) AND NOT cl_null(g_detail1_d[l_ac1].faah002) AND g_detail1_d[l_ac1].faah002 = '1' THEN  #类型为主件时候才需要判断
               LET l_count = 0
               SELECT COUNT(*) INTO l_count FROM faah_t WHERE faahent = g_enterprise
                  AND faah003 = g_detail1_d[l_ac1].faah003
               IF cl_null(l_count) THEN lET l_count = 0 END IF
               IF g_para_data3 != 'Y' THEN   #161021-00053#1 add
                  FOR l_count1 = 1 TO g_detail1_d.getLength()
                     IF g_detail1_d[l_ac1].faah003 = g_detail1_d[l_count1].faah003 AND l_ac1 <> l_count1 THEN
                        LET l_count = l_count + 1
                     END IF
                  END FOR
               END IF   #161021-00053#1 add
               IF l_count > 0 THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'afa-00449'
                  LET g_errparam.extend = ''
                  LET g_errparam.popup = TRUE 
                  CALL cl_err()
               END IF
            END IF
            #2015/02/15 Add ---(E)---
            
            #albireo 160111-----s
            IF cl_null(g_detail1_d[l_ac1].faah003)THEN
               LET g_detail1_d[l_ac1].l_oofg001_t1  = ''
               LET g_detail1_d[l_ac1].l_before_code = ''
               LET g_detail1_d[l_ac1].l_num_code    = ''
               LET g_detail1_d[l_ac1].l_after_code  = ''
               DISPLAY BY NAME g_detail1_d[l_ac1].l_oofg001_t1,g_detail1_d[l_ac1].l_before_code,
                               g_detail1_d[l_ac1].l_num_code,g_detail1_d[l_ac1].l_after_code                
            END IF
            #albireo 160111-----e
         
         AFTER FIELD b_faah004
            IF p_cmd = 'a' OR ( p_cmd = 'u' AND ( g_detail1_d[l_ac1].faah004 != g_detail1_d_t.faah004)) THEN
               IF  NOT cl_null(g_detail1_d[l_ac1].faah003) AND NOT cl_null(g_detail1_d[l_ac1].faah001) AND g_detail1_d[l_ac1].faah004 IS NOT NULL THEN
                   IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM faah_t WHERE "||"faahent = '" ||g_enterprise|| "' AND "|| "faah001 = '"||g_detail1_d[l_ac1].faah001 ||"' AND "|| "faah003 = '"||g_detail1_d[l_ac1].faah003 ||"' AND "|| "faah004 = '"||g_detail1_d[l_ac1].faah004 ||"'",'std-00004',0) THEN 
                      NEXT FIELD CURRENT
                   END IF
                   IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM afap210_tmp WHERE "|| "faah003 = '"||g_detail1_d[l_ac1].faah003 ||"' AND "|| "faah001 = '"||g_detail1_d[l_ac1].faah001 ||"' AND "|| "faah004 = '"||g_detail1_d[l_ac1].faah004 ||"'",'std-00004',0) THEN 
                      NEXT FIELD CURRENT
                   END IF
                   LET l_n = 0
                   SELECT COUNT(*) INTO l_n
                     FROM afap210_01_tmp 
                    WHERE flag <> g_detail1_d[l_ac1].flag
                      AND faah003 = g_detail1_d[l_ac1].faah003
                      AND faah004 = g_detail1_d[l_ac1].faah004
                      AND faah001 = g_detail1_d[l_ac1].faah001
                   IF l_n > 0 THEN 
                      INITIALIZE g_errparam TO NULL 
                      LET g_errparam.extend = '' 
                      LET g_errparam.code   = 'std-00004'
                      LET g_errparam.popup  = FALSE 
                      CALL cl_err()
                      NEXT FIELD b_faah004
                   END IF 
               END IF
            END IF 

         ON ACTION controlp INFIELD b_faah003
            IF g_detail1_d[l_ac1].faah002 = '2' OR g_detail1_d[l_ac1].faah002 = '3' THEN
			      INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'i'
			      LET g_qryparam.reqry = FALSE
               LET g_qryparam.default1 = g_detail1_d[l_ac1].faah003
               CALL q_faah003()
               LET g_detail1_d[l_ac1].faah003 = g_qryparam.return1 
               LET g_qryparam.where = " "
               DISPLAY BY NAME g_detail1_d[l_ac1].faah003
               NEXT FIELD b_faah003                          #返回原欄位
            END IF
         
         #161130-00031#1 add s---         
         BEFORE FIELD b_faah018
            LET g_detail1_d_o.faah018 = g_detail1_d[l_ac1].faah018         
         #161130-00031#1 add e---
         
         AFTER FIELD b_faah018
            IF NOT cl_null(g_detail1_d[l_ac1].faah018) THEN
               IF g_detail1_d[l_ac1].faah018 <= 0 THEN 
                   INITIALIZE g_errparam TO NULL 
                   LET g_errparam.extend = '' 
                   LET g_errparam.code   = 'afa-00353'
                   LET g_errparam.popup  = FALSE 
                   #LET g_detail1_d[l_ac1].faah018 = g_detail1_d_t.faah018 #161130-00031#1 mark
                   LET g_detail1_d[l_ac1].faah018 = g_detail1_d_o.faah018 #161130-00031#1 add
                   CALL cl_err()
               END IF 
               #161130-00031#1 add s---
               SELECT SUM(faah018) INTO l_faah018
                 FROM afap210_01_tmp 
                WHERE flag <> g_detail1_d[l_ac1].flag
                  AND faak000 = g_faak000
                  AND faak001 = g_faak001
                  AND faak003 = g_faak003
                  AND faak004 = g_faak004
               IF cl_null(l_faah018) THEN 
                  LET l_faah018 = 0
               END IF 
               IF l_faah018 + g_detail1_d[l_ac1].faah018 > g_faak018 THEN 
                   INITIALIZE g_errparam TO NULL 
                   LET g_errparam.extend = '' 
                   LET g_errparam.code   = 'afa-00341'
                   LET g_errparam.popup  = FALSE 
                   CALL cl_err()
                   #LET g_detail1_d[l_ac1].faah018 = g_detail1_d_t.faah018 #161130-00031#1 mark
                   LET g_detail1_d[l_ac1].faah018 = g_detail1_d_o.faah018 #161130-00031#1 add
                   NEXT FIELD b_faah018
               END IF
               LET g_detail1_d[l_ac1].faah022 = g_detail1_d[l_ac1].faah018*(g_faak022/g_faak018)               
               #161130-00031#1 add e---               
            END IF
#               SELECT SUM(faah018) INTO l_faah018
#                 FROM afap210_01_tmp 
#                WHERE flag <> g_detail1_d[l_ac1].flag
#                  AND faak000 = g_faak000
#                  AND faak001 = g_faak001
#                  AND faak003 = g_faak003
#                  AND faak004 = g_faak004
#                IF cl_null(l_faah018) THEN 
#                   LET l_faah018 = 0
#                END IF 
#                IF l_faah018 + g_detail1_d[l_ac1].faah018 > g_faak018 THEN 
#                    INITIALIZE g_errparam TO NULL 
#                    LET g_errparam.extend = '' 
#                    LET g_errparam.code   = 'afa-00341'
#                    LET g_errparam.popup  = FALSE 
#                    CALL cl_err()
#                    LET g_detail1_d[l_ac1].faah018 = g_detail1_d_t.faah018
#                    NEXT FIELD b_faah018
#                END IF
#                LET g_detail1_d[l_ac1].faah022 = g_detail1_d[l_ac1].faah018*(g_faak022/g_faak018)
#            END IF 

         #161130-00031#1 add s---         
         BEFORE FIELD b_faah022
            LET g_detail1_d_o.faah022 = g_detail1_d[l_ac1].faah022         
         #161130-00031#1 add e---

         AFTER FIELD b_faah022
            IF NOT cl_null(g_detail1_d[l_ac1].faah022) THEN
               IF g_detail1_d[l_ac1].faah022 <= 0 THEN 
                   INITIALIZE g_errparam TO NULL 
                   LET g_errparam.extend = '' 
                   LET g_errparam.code   = 'afa-00354'
                   LET g_errparam.popup  = FALSE 
                   CALL cl_err()
                   #LET g_detail1_d[l_ac1].faah022 = g_detail1_d_t.faah022 #161130-00031#1 mark
                   LET g_detail1_d[l_ac1].faah022 = g_detail1_d_o.faah022 #161130-00031#1 add
                   NEXT FIELD b_faah022
               END IF 
               SELECT SUM(faah022) INTO l_faah022
                 FROM afap210_01_tmp 
                WHERE flag <> g_detail1_d[l_ac1].flag
                  AND faak000 = g_faak000
                  AND faak001 = g_faak001
                  AND faak003 = g_faak003
                  AND faak004 = g_faak004
                IF cl_null(l_faah022) THEN 
                   LET l_faah022 = 0
                END IF 
                IF l_faah022 + g_detail1_d[l_ac1].faah022 > g_faak022 THEN 
                    INITIALIZE g_errparam TO NULL 
                    LET g_errparam.extend = '' 
                    LET g_errparam.code   = 'afa-00355'
                    LET g_errparam.popup  = FALSE 
                    CALL cl_err()
                   #LET g_detail1_d[l_ac1].faah022 = g_detail1_d_t.faah022 #161130-00031#1 mark
                   LET g_detail1_d[l_ac1].faah022 = g_detail1_d_o.faah022 #161130-00031#1 add
                    NEXT FIELD b_faah022
                END IF
            END IF 

      AFTER INPUT 
#         SELECT SUM(faah018) INTO l_faah018
#           FROM afap210_01_tmp 
#          WHERE faak000 = g_faak000
#            AND faak001 = g_faak001
#            AND faak003 = g_faak003
#            AND faak004 = g_faak004
#         IF cl_null(l_faah018) THEN 
#            LET l_faah018 = 0
#         END IF 
#         IF l_faah018 != g_faak018 THEN 
#            INITIALIZE g_errparam TO NULL 
#            LET g_errparam.extend = '' 
#            LET g_errparam.code   = 'afa-00342'
#            LET g_errparam.popup  = FALSE 
#            CALL cl_err()
#            NEXT FIELD b_faah018
#         END IF 
         SELECT SUM(faah022) INTO l_faah022
           FROM afap210_01_tmp 
          WHERE faak000 = g_faak000
            AND faak001 = g_faak001
            AND faak003 = g_faak003
            AND faak004 = g_faak004
         IF cl_null(l_faah022) THEN 
            LET l_faah022 = 0
         END IF 
         IF l_faah022 > g_faak022 THEN 
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = '' 
            LET g_errparam.code   = 'afa-00355'
            LET g_errparam.popup  = FALSE 
            CALL cl_err()
            NEXT FIELD b_faah022
         END IF
      
      END INPUT
      ON ACTION exit
         LET g_action_choice="exit"
         EXIT DIALOG
 
      ON ACTION accept
         ACCEPT DIALOG 
         
      ON ACTION cancel
         LET INT_FLAG = 1
         EXIT DIALOG   

      ON ACTION close
         LET INT_FLAG = 1         
         LET g_action_choice = "exit"
         EXIT DIALOG 
   END DIALOG
   IF INT_FLAG THEN 
      LET g_flag = 'N'
      #清空临时表数据
      DELETE FROM afap210_01_tmp 
       WHERE faak000 = g_faak000
         AND faak001 = g_faak001
         AND faak003 = g_faak003
         AND faak004 = g_faak004
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "DEL afap210_01_tmp" 
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = TRUE 
         CALL cl_err()
      END IF
   END IF 
   CLOSE WINDOW w_afap210_s01
END FUNCTION

################################################################################
# Descriptions...: 分割單身顯示
# Memo...........:
# Usage..........: CALL afap210_01_b_fill()
# Input parameter:  
# Return code....:  
# Date & Author..: 2014/12/15 By yangxf
# Modify.........:
################################################################################
PRIVATE FUNCTION afap210_01_b_fill()
   
   #160426-00014#37--add--str--lujh
   CALL afap210_01_ins(g_faak000,g_faak001,g_faak003,
                       g_faak004,g_faak019,g_faak018)
   #160426-00014#37--add--end--lujh   
   
   LET g_sql = " SELECT * FROM afap210_01_tmp ",
               "  WHERE faak000 = '",g_faak000,"'",
               "    AND faak001 = '",g_faak001,"'",
               "    AND faak003 = '",g_faak003,"'",
               "    AND faak004 = '",g_faak004,"'",
               "  ORDER BY flag "    #160426-00014#37 addlujh
               
   PREPARE afap210_01_sel FROM g_sql
   DECLARE afap210_01_curs CURSOR FOR afap210_01_sel
   
   CALL g_detail1_d.clear()    

   LET g_cnt = 1 
   ERROR "Searching!"
   
   FOREACH afap210_01_curs INTO g_detail1_d[g_cnt].*
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "FOREACH 01:" 
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = TRUE 
         CALL cl_err()
         EXIT FOREACH
      END IF
      LET g_cnt = g_cnt + 1
   END FOREACH
                 
   CALL g_detail1_d.deleteElement(g_cnt)
   LET g_rec_b1 = g_cnt - 1 
   DISPLAY g_rec_b1 TO FORMONLY.cnt
   LET g_cnt = 0       
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
PRIVATE FUNCTION afap210_set_entry()

    IF g_detail_d[l_ac].sel = 'Y' AND g_pr = 'Y' THEN
       CALL cl_set_comp_entry("b_faah001,b_faah003,b_faah004",TRUE)
       CALL cl_set_comp_required("b_faah001,b_faah003,b_faah004",TRUE)
    ELSE
       CALL cl_set_comp_entry("b_faah001,b_faah003,b_faah004",FALSE)
       CALL cl_set_comp_required("b_faah001,b_faah003,b_faah004",FALSE) 
    END IF

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
PRIVATE FUNCTION afap210_coalition()
   DEFINE p_type       LIKE type_t.num5
   DEFINE l_n          LIKE type_t.num5
   DEFINE l_faak019    LIKE faak_t.faak019
   DEFINE l_faak019_t  LIKE faak_t.faak019
   #161009-00006#3--add--str--lujh    
   DEFINE l_sql        STRING
   DEFINE l_faak001    LIKE faak_t.faak001
   DEFINE l_faak003    LIKE faak_t.faak003
   DEFINE l_faak004    LIKE faak_t.faak004
   #161009-00006#3--add--end--lujh    
   DEFINE l_faak032_t  LIKE faak_t.faak032 #161213-00015#1 add
   DEFINE l_faak032    LIKE faak_t.faak032 #161213-00015#1 add
   
   LET l_n = 0

     #######################mark by huangtao
     ##检查是否只勾选一笔资料
     #SELECT COUNT(*) INTO l_n
     #  FROM afap210_tmp
     # WHERE sel = 'Y'
     #   AND pin = 'N'
     #   AND produce = 'N'
     #   AND pout = 'N'
     #IF l_n > 1 THEN 
     #   INITIALIZE g_errparam TO NULL 
     #   LET g_errparam.extend = ""
     #   LET g_errparam.code   = "afa-00335" 
     #   LET g_errparam.popup  = TRUE 
     #   CALL cl_err()
     #   RETURN 
     #ELSE
     #   IF l_n = 0 THEN 
     #      RETURN 
     #   END IF 
     #END IF
     ######################mark by huangtao
   #多笔合并

      LET l_n = 0
      #检查是否勾选两笔以上的资料
      SELECT COUNT(*) INTO l_n
        FROM afap210_tmp
       WHERE sel = 'Y'
         AND pin = 'N'
         AND produce = 'N'
         AND pout = 'N'
      IF l_n = 0 THEN 
         RETURN 
      END IF 
      IF l_n < 2 THEN 
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "" 
         LET g_errparam.code   = "afa-00336"
         LET g_errparam.popup  = TRUE 
         CALL cl_err()
         RETURN 
      END IF
 
#161213-00015#1 mark s---
#      LET l_faak019_t = ''
#      #如果是合并检查币别是否相同
#      DECLARE sel_faak019 CURSOR FOR SELECT faak019 FROM afap210_tmp WHERE sel = 'Y'
#                                                                       AND pin = 'N'
#                                                                       AND produce = 'N'
#                                                                       AND pout = 'N'
#      FOREACH sel_faak019 INTO l_faak019
#         IF l_faak019_t != l_faak019 AND NOT cl_null(l_faak019_t) THEN
#            INITIALIZE g_errparam TO NULL 
#            LET g_errparam.extend = "" 
#            LET g_errparam.code   = "afa-00340"
#            LET g_errparam.popup  = TRUE 
#            CALL cl_err()
#            RETURN 
#         END IF 
#         LET l_faak019_t = l_faak019
#      END FOREACH 
#161213-00015#1 mark e---

#161213-00015#1 add s---
   LET l_faak032_t =NULL
   LET l_faak032   =NULL
   LET l_sql = "SELECT DISTINCT faak001,faak003,faak004 ",
               "  FROM afap210_tmp ",
               " WHERE sel = 'Y' ",
               "   AND pin = 'N' ",
               "   AND produce = 'N' ",
               "   AND pout = 'N' "
   PREPARE afap210_pre2 FROM l_sql
   DECLARE afap210_cur2 SCROLL CURSOR WITH HOLD FOR afap210_pre2   
   FOREACH afap210_cur2 INTO l_faak001,l_faak003,l_faak004
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "foreach afap210_cur2:"
         LET g_errparam.popup = TRUE
         CALL cl_err()
         EXIT FOREACH
      END IF   
      SELECT faak032 INTO l_faak032
        FROM faak_t
       WHERE faakent = g_enterprise
         AND faak001 = l_faak001
         AND faak003 = l_faak003
         AND faak004 = l_faak004
      IF l_faak032 <> l_faak032_t AND NOT cl_null(l_faak032_t) THEN 
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "" 
         LET g_errparam.code   = "afa-01139"
         LET g_errparam.popup  = TRUE 
         CALL cl_err()
         RETURN          
      END IF      
      LET l_faak032_t = l_faak032 
   END FOREACH
#161213-00015#1 add e---

   #161009-00006#3--add--str--lujh    
   LET l_sql = "SELECT DISTINCT faak001,faak003,faak004 ",
               "  FROM afap210_tmp ",
               " WHERE sel = 'Y' ",
               "   AND pin = 'N' ",
               "   AND produce = 'N' ",
               "   AND pout = 'N' "
   
   PREPARE afap210_pre1 FROM l_sql
   DECLARE afap210_cur1 SCROLL CURSOR WITH HOLD FOR afap210_pre1
   OPEN afap210_cur1
   FETCH FIRST afap210_cur1 INTO l_faak001,l_faak003,l_faak004
   CLOSE afap210_cur1
   
   SELECT faak032 INTO g_faak032
     FROM faak_t
    WHERE faakent = g_enterprise
      AND faak001 = l_faak001
      AND faak003 = l_faak003
      AND faak004 = l_faak004
   #161009-00006#3--add--end--lujh 
  
   CALL afap210_02_open()
   IF NOT INT_FLAG THEN 
 
         UPDATE afap210_tmp SET faah001 = g_faah_m.faah001,
                                faah002 = g_faah_m.faah002,
                                faah003 = g_faah_m.faah003,
                                faah004 = g_faah_m.faah004,
                                faah014 = g_faah_m.faah014, #161102-00025#2 add xul
                                pin = 'Y'
          WHERE sel = 'Y'
            AND pin = 'N'
            AND pout = 'N' 
            AND produce = 'N'      
         IF SQLCA.SQLcode  THEN
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "UPD afap210_tmp" 
            LET g_errparam.code   = SQLCA.sqlcode 
            LET g_errparam.popup  = TRUE 
            CALL cl_err()                  
            RETURN 
         END IF             

        # UPDATE afap210_tmp SET faah001 = g_faah_m.faah001,
        #                        faah002 = g_faah_m.faah002,
        #                        faah003 = g_faah_m.faah003,
        #                        faah004 = g_faah_m.faah004,
        #                        produce = 'Y'
        #  WHERE sel = 'Y'
        #    AND pin = 'N'
        #    AND pout = 'N'   
        #    AND produce = 'N'
        # IF SQLCA.SQLcode  THEN
        #    INITIALIZE g_errparam TO NULL 
        #    LET g_errparam.extend = "UPD afap210_tmp" 
        #    LET g_errparam.code   = SQLCA.sqlcode 
        #    LET g_errparam.popup  = TRUE 
        #    CALL cl_err()                  
        #    RETURN 
        # END IF 
      
   END IF
   CALL afap210_display()
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
PRIVATE FUNCTION afap210_03_open()
DEFINE lwin_curr       ui.Window
DEFINE lfrm_curr       ui.Form
DEFINE ls_path         STRING
DEFINE l_n             LIKE type_t.num5
DEFINE l_faah018       LIKE faah_t.faah018
DEFINE l_success       LIKE type_t.num5
DEFINE l_insert        BOOLEAN
DEFINE l_faah022       LIKE faah_t.faah022
DEFINE p_cmd           LIKE type_t.chr1
DEFINE l_count         LIKE type_t.num5


#開啟畫面
   OPEN WINDOW w_afap210_s03 WITH FORM cl_ap_formpath("afa","afap210_s03")
   CALL cl_ui_init()
   LET lwin_curr = ui.Window.getCurrent()
   LET lfrm_curr = lwin_curr.getForm()
   LET ls_path = os.Path.join(os.Path.join(FGL_GETENV("ERP"),"cfg"),"4tb")
   LET ls_path = os.Path.join(ls_path,"toolbar_lib.4tb")
   CALL lfrm_curr.loadToolBar(ls_path)
   IF g_para_data = 'N' THEN 
      CALL cl_set_comp_entry("b_faah001",TRUE)
   ELSE
      CALL cl_set_comp_entry("b_faah001",FALSE)
   END IF
   CALL cl_set_combo_scc('b_faah002','9911')
   CALL afap210_03_b_fill()
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
      INPUT ARRAY g_detail3_d FROM s_detail3.*
         ATTRIBUTE(COUNT = g_rec_b1,MAXCOUNT = g_max_rec,WITHOUT DEFAULTS, 
               INSERT ROW = FALSE, 
               DELETE ROW = FALSE,
               APPEND ROW = FALSE)   
         
      BEFORE ROW
         LET l_insert = FALSE
         LET l_ac1 = ARR_CURR()
         LET g_detail_idx = l_ac1      
         LET l_n = ARR_COUNT()
         IF g_rec_b1 >= l_ac1 THEN 
            LET p_cmd = 'u'
            LET g_detail3_d_t.* = g_detail3_d[l_ac1].*
         END IF 
         LET g_detail3_d[l_ac1].faah014 = g_today        #161102-00025#2--add xul
         #2015/7/1--by--02599--add--str--
         IF cl_null(g_detail3_d[l_ac1].faah002) THEN
            LET g_detail3_d[l_ac1].faah002 = '1'
         END IF
         #160913-00028#1 add--s
         IF g_detail3_d[l_ac1].faah002 = '1' THEN
            LET g_detail3_d[l_ac1].faah004 = ' '
            CALL cl_set_comp_entry("b_faah004",FALSE)
         ELSE
            CALL cl_set_comp_entry("b_faah004",TRUE)
         END IF 
         #160913-00028#1 add--e
         #2015/7/1--by--02599--add--end
    #  BEFORE INSERT
    #     LET p_cmd = 'a'
    #     INITIALIZE g_detail3_d_t.* TO NULL
    #     LET l_n = ARR_COUNT()
    #     INITIALIZE g_detail3_d[l_ac1].* TO NULL
         
       
        # CALL cl_set_comp_entry("b_faah004",FALSE)
        # IF g_para_data = 'Y' THEN
        #    CALL afap210_get_faah001() RETURNING g_detail1_d[l_ac1].faah001
        # END IF
        # IF g_para_data2 = 'Y' AND g_detail1_d[l_ac1].faah002 = '1' THEN
        #    CALL cl_set_comp_entry("b_faah003",FALSE)
        #    LET g_detail1_d[l_ac1].faah003 = g_detail1_d[l_ac1].faah001
        # ELSE
        #    CALL cl_set_comp_entry("b_faah003",TRUE)  
        # END IF

      AFTER INSERT
         IF INT_FLAG THEN
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = '' 
            LET g_errparam.code   = 9001 
            LET g_errparam.popup  = FALSE 
            CALL cl_err()
            LET INT_FLAG = 0
            CANCEL INSERT
         END IF
         
         
      BEFORE DELETE 
         IF NOT cl_ask_del_detail() THEN
            CANCEL DELETE
         END IF
       
         
      ON ROW CHANGE 
         IF INT_FLAG THEN
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = '' 
            LET g_errparam.code   = 9001 
            LET g_errparam.popup  = FALSE 
            CALL cl_err()
            LET INT_FLAG = 0
            LET g_detail3_d[l_ac1].* = g_detail3_d_t.*
            EXIT DIALOG 
         END IF
         UPDATE afap210_tmp SET faah002 = g_detail3_d[l_ac1].faah002,
                                faah003 = g_detail3_d[l_ac1].faah003,
                                faah004 = g_detail3_d[l_ac1].faah004,
                                faah001 = g_detail3_d[l_ac1].faah001,
                                faah014 = g_detail3_d[l_ac1].faah014, #161102-00025#2 add xul
                                produce = 'Y'
          WHERE faak001 = g_detail3_d[l_ac1].faak001
            AND faak003 = g_detail3_d[l_ac1].faak003
            AND faak004 = g_detail3_d[l_ac1].faak004
            
              
        ON CHANGE b_faah002
           IF g_detail3_d[l_ac1].faah002 = '1' THEN 
              LET g_detail3_d[l_ac1].faah003 = ''
              LET g_detail3_d[l_ac1].faah004 = ' '
              CALL cl_set_comp_entry("b_faah004",FALSE)
           ELSE
              LET g_detail3_d[l_ac1].faah003 = ''
              LET g_detail3_d[l_ac1].faah004 = ''
              CALL cl_set_comp_entry("b_faah004",TRUE)
           END IF 
    #       IF g_para_data2 = 'Y' AND g_detail1_d[l_ac1].faah002 = '1' THEN
    #          CALL cl_set_comp_entry("b_faah003",FALSE)               
    #          LET g_detail1_d[l_ac1].faah003 = g_detail1_d[l_ac1].faah001
    #          IF NOT cl_null(g_detail1_d[l_ac1].faah001) AND NOT cl_null(g_detail1_d[l_ac1].faah003) AND g_detail1_d[l_ac1].faah004 IS NOT NULL THEN 
    #             IF p_cmd = 'a' OR ( p_cmd = 'u' AND ( g_detail1_d[l_ac1].faah002 != g_detail1_d_t.faah002)) THEN
    #                IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM faah_t WHERE "||"faahent = '" ||g_enterprise|| "' AND "|| "faah001 = '"||g_detail1_d[l_ac1].faah001 ||"' AND "|| "faah003 = '"||g_detail1_d[l_ac1].faah003 ||"' AND "|| "faah004 = '"||g_detail1_d[l_ac1].faah004 ||"'",'std-00004',0) THEN 
    #                   NEXT FIELD CURRENT
    #                END IF
    #                IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM afap210_tmp WHERE "|| "faah003 = '"||g_detail1_d[l_ac1].faah003 ||"' AND "|| "faah001 = '"||g_detail1_d[l_ac1].faah001 ||"' AND "|| "faah004 = '"||g_detail1_d[l_ac1].faah004 ||"'",'std-00004',0) THEN 
    #                   NEXT FIELD CURRENT
    #                END IF
    #                LET l_n = 0
    #                SELECT COUNT(*) INTO l_n
    #                  FROM afap210_01_tmp 
    #                 WHERE flag <> g_detail1_d[l_ac1].flag
    #                   AND faah003 = g_detail1_d[l_ac1].faah003
    #                   AND faah004 = g_detail1_d[l_ac1].faah004
    #                   AND faah001 = g_detail1_d[l_ac1].faah001
    #                IF l_n > 0 THEN 
    #                   INITIALIZE g_errparam TO NULL 
    #                   LET g_errparam.extend = '' 
    #                   LET g_errparam.code   = 'std-00004'
    #                   LET g_errparam.popup  = FALSE 
    #                   CALL cl_err()
    #                   NEXT FIELD b_faah004
    #                END IF 
    #             END IF 
    #          END IF
    #       ELSE
    #          CALL cl_set_comp_entry("b_faah003",TRUE)    
    #       END IF
    #       
        AFTER FIELD b_faah001
            IF g_para_data = 'N' THEN
               SELECT lpad(g_detail3_d[l_ac1].faah001,10,'0') INTO g_detail3_d[l_ac1].faah001
                 FROM faah_t
                WHERE faahent = g_enterprise
               DISPLAY BY NAME g_detail3_d[l_ac1].faah001
            END IF 
    #        IF g_para_data2 = 'Y' AND g_detail1_d[l_ac1].faah002 = '1' THEN
    #           CALL cl_set_comp_entry("b_faah003",FALSE)               
    #           LET g_detail1_d[l_ac1].faah003 = g_detail1_d[l_ac1].faah001
    #           DISPLAY BY NAME g_detail1_d[l_ac1].faah003
    #        ELSE
    #           CALL cl_set_comp_entry("b_faah003",TRUE)  
    #        END IF
           IF p_cmd = 'a' OR ( p_cmd = 'u' AND ( g_detail3_d[l_ac1].faah001 != g_detail3_d_t.faah001)) THEN
              IF  NOT cl_null(g_detail3_d[l_ac1].faah003) AND NOT cl_null(g_detail3_d[l_ac1].faah001) AND g_detail3_d[l_ac1].faah004 IS NOT NULL THEN
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM faah_t WHERE "||"faahent = '" ||g_enterprise|| "' AND "|| "faah001 = '"||g_detail3_d[l_ac1].faah001 ||"' AND "|| "faah003 = '"||g_detail3_d[l_ac1].faah003 ||"' AND "|| "faah004 = '"||g_detail3_d[l_ac1].faah004 ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM afap210_tmp WHERE "|| "faah003 = '"||g_detail3_d[l_ac1].faah003 ||"' AND "|| "faah001 = '"||g_detail3_d[l_ac1].faah001 ||"' AND "|| "faah004 = '"||g_detail3_d[l_ac1].faah004 ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
                 
              END IF
           END IF 
          
    #    BEFORE FIELD b_faah003
    #       IF g_para_data2 <> 'Y' THEN 
    #          IF cl_null(g_detail1_d[l_ac1].faah003) AND g_detail1_d[l_ac1].faah002 = '1' THEN
    #             IF g_para_data3 = 'Y' AND g_para_data2 ='N' THEN 
    #                CALL s_aooi390('3') RETURNING l_success,g_detail1_d[l_ac1].faah003
    #             END IF 
    #          END IF
    #       END IF 
    #    
    #    #財编检查
        AFTER FIELD b_faah003
           IF p_cmd = 'a' OR ( p_cmd = 'u' AND ( g_detail3_d[l_ac1].faah003 != g_detail3_d_t.faah003)) THEN
              IF  NOT cl_null(g_detail3_d[l_ac1].faah003) AND NOT cl_null(g_detail3_d[l_ac1].faah001) AND g_detail3_d[l_ac1].faah004 IS NOT NULL THEN
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM faah_t WHERE "||"faahent = '" ||g_enterprise|| "' AND "|| "faah001 = '"||g_detail3_d[l_ac1].faah001 ||"' AND "|| "faah003 = '"||g_detail3_d[l_ac1].faah003 ||"' AND "|| "faah004 = '"||g_detail3_d[l_ac1].faah004 ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM afap210_tmp WHERE "|| "faah003 = '"||g_detail3_d[l_ac1].faah003 ||"' AND "|| "faah001 = '"||g_detail3_d[l_ac1].faah001 ||"' AND "|| "faah004 = '"||g_detail3_d[l_ac1].faah004 ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
                  
              END IF
           END IF 
           IF NOT cl_null(g_detail3_d[l_ac1].faah003) THEN 
              IF NOT afap210_faah003_chk1(g_detail3_d[l_ac1].faah002,g_detail3_d[l_ac1].faah003) THEN 
                 LET g_detail3_d[l_ac1].faah003 = ''
                 NEXT FIELD b_faah003
              END IF  
           END IF 
            #2015/02/15 Add By 01727 客户家财产编号Key值,重复需要提醒,但不需要卡死
            #2015/02/15 Add ---(S)---
            IF NOT cl_null(g_detail3_d[l_ac1].faah003) AND NOT cl_null(g_detail3_d[l_ac1].faah002) AND g_detail3_d[l_ac1].faah002 = '1' THEN  #类型为主件时候才需要判断
               LET l_count = 0
               SELECT COUNT(*) INTO l_count FROM faah_t WHERE faahent = g_enterprise
                  AND faah003 = g_detail3_d[l_ac1].faah003
               IF cl_null(l_count) THEN lET l_count = 0 END IF
               IF l_count > 0 THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'afa-00449'
                  LET g_errparam.extend = ''
                  LET g_errparam.popup = TRUE 
                  CALL cl_err()
               END IF
            END IF
            #2015/02/15 Add ---(E)---
        
        AFTER FIELD b_faah004
           IF p_cmd = 'a' OR ( p_cmd = 'u' AND ( g_detail3_d[l_ac1].faah004 != g_detail3_d_t.faah004)) THEN
              IF  NOT cl_null(g_detail3_d[l_ac1].faah003) AND NOT cl_null(g_detail3_d[l_ac1].faah001) AND g_detail3_d[l_ac1].faah004 IS NOT NULL THEN
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM faah_t WHERE "||"faahent = '" ||g_enterprise|| "' AND "|| "faah001 = '"||g_detail3_d[l_ac1].faah001 ||"' AND "|| "faah003 = '"||g_detail3_d[l_ac1].faah003 ||"' AND "|| "faah004 = '"||g_detail3_d[l_ac1].faah004 ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM afap210_tmp WHERE "|| "faah003 = '"||g_detail3_d[l_ac1].faah003 ||"' AND "|| "faah001 = '"||g_detail3_d[l_ac1].faah001 ||"' AND "|| "faah004 = '"||g_detail3_d[l_ac1].faah004 ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
              END IF
           END IF 
    
        ON ACTION controlp INFIELD b_faah003
           IF g_detail3_d[l_ac1].faah002 = '2' OR g_detail3_d[l_ac1].faah002 = '3' THEN
		        INITIALIZE g_qryparam.* TO NULL
              LET g_qryparam.state = 'i'
	           LET g_qryparam.reqry = FALSE
              LET g_qryparam.default1 = g_detail3_d[l_ac1].faah003
              LET g_qryparam.where = " faah002 = 1 " #20150210 add
              CALL q_faah003()
              LET g_detail3_d[l_ac1].faah003 = g_qryparam.return1 
              LET g_qryparam.where = " "
              DISPLAY BY NAME g_detail3_d[l_ac1].faah003
              NEXT FIELD b_faah003                          #返回原欄位
           END IF

 

      END INPUT
      
      BEFORE DIALOG 
         NEXT FIELD b_faah002
         
      ON ACTION exit
         LET g_action_choice="exit"
         EXIT DIALOG
 
      ON ACTION accept
         ACCEPT DIALOG 
         
      ON ACTION cancel
         LET INT_FLAG = 1
         EXIT DIALOG   

      ON ACTION close
         LET INT_FLAG = 1         
         LET g_action_choice = "exit"
         EXIT DIALOG 
   END DIALOG
   IF INT_FLAG THEN 
      LET g_flag = 'N'
     # #清空临时表数据
     # DELETE FROM afap210_01_tmp 
     #  WHERE faak000 = g_faak000
     #    AND faak001 = g_faak001
     #    AND faak003 = g_faak003
     #    AND faak004 = g_faak004
     # IF SQLCA.sqlcode THEN
     #    INITIALIZE g_errparam TO NULL 
     #    LET g_errparam.extend = "DEL afap210_01_tmp" 
     #    LET g_errparam.code   = SQLCA.sqlcode 
     #    LET g_errparam.popup  = TRUE 
     #    CALL cl_err()
     # END IF
   END IF 
   CLOSE WINDOW w_afap210_s03
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
PRIVATE FUNCTION afap210_03_b_fill()
  
   LET g_sql = " SELECT sel,faak000,faak001,faak003,faak004,faak019,faak018,
                        faak022,faah002,faah001,faah003,faah004,faah014 FROM afap210_tmp ",  #161102-00025#2 add faah014
               "  WHERE sel = 'Y' AND pin = 'N' AND produce = 'N' AND pout = 'N' "
               
   PREPARE afap210_03_sel FROM g_sql
   DECLARE afap210_03_curs CURSOR FOR afap210_03_sel
   
   CALL g_detail3_d.clear()    

   LET g_cnt = 1 
   ERROR "Searching!"
   
   FOREACH afap210_03_curs INTO g_detail3_d[g_cnt].*
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "FOREACH 03:" 
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = TRUE 
         CALL cl_err()
         EXIT FOREACH
      END IF
      LET g_cnt = g_cnt + 1
   END FOREACH
                 
   CALL g_detail3_d.deleteElement(g_cnt)
   LET g_rec_b1 = g_cnt - 1 
   DISPLAY g_rec_b1 TO FORMONLY.cnt
   LET g_cnt = 0  
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
PRIVATE FUNCTION afap210_faah003_chk1(p_faah002,p_faah003)
   DEFINE l_n       LIKE type_t.num5
   DEFINE p_faah002 LIKE faah_t.faah002
   DEFINE p_faah003 LIKE faah_t.faah003
   
   IF NOT cl_null(p_faah002) AND NOT cl_null(p_faah003) AND p_faah002 <> '1' THEN 
      SELECT count(*) INTO l_n 
        FROM faah_t
       WHERE faahent = g_enterprise
         AND faah003 = p_faah003
         AND faah002 = '1'
         
      IF l_n = 0 THEN 
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = 'afa-00016'
         LET g_errparam.extend = ''
         LET g_errparam.popup = TRUE
         CALL cl_err()
         RETURN FALSE
      END IF 
   END IF
   
   RETURN TRUE
END FUNCTION

#end add-point
 
{</section>}
 
