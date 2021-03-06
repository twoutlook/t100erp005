#該程式未解開Section, 採用最新樣板產出!
{<section id="afap280.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0014(2015-04-03 15:48:33), PR版次:0014(2017-01-04 15:08:14)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000155
#+ Filename...: afap280
#+ Description: 資產傳票拋轉總帳作業
#+ Creator....: 02599(2014-08-10 13:27:08)
#+ Modifier...: 02003 -SD/PR- 07900
 
{</section>}
 
{<section id="afap280.global" >}
#應用 p02 樣板自動產生(Version:22)
#add-point:填寫註解說明 name="global.memo"
#151013-00019#4   2015/10/16 By Reanna  修正bug：臨時表afap280_01_fa_group名稱太長，只能為18碼，改成afap280_01_group
#151228-00007#1   2015/12/28 By yangtt  单身没有勾选的单据一并抛转到总账
#160114-00011#1   2016/01/15 By yangtt  若账套不存在，作业down出
#160318-00005#    2016/03/23 By 07675   將重複內容的錯誤訊息置換為公用錯誤訊息
#160329-00025#3   2016/04/06 by 01531   1、[单据性质]下拉框显示23盘盈、24盘亏
#160318-00025#39  2016/04/22 By pengxin 將重複內容的錯誤訊息置換為公用錯誤訊息(r.v)
#160426-00014#10  2016/07/25 By 01531   单据性质增加39调整
#160727-00019#2   2016/08/01 By 08742   系统中定义的临时表名称超过15码在执行时会出错,所以需要将系统中定义的临时表长度超过15码的全部改掉	 	
#                                       Mod   afap280_01_fa_tmp -->afap280_tmp01
#                                       Mod   afap280_01_group -->afap280_tmp02
#160125-00005#7   2016/08/09 By 01531   查詢時加上帳套人員權限條件過濾
#160727-00019#34  2016/08/15 By 08734   临时表长度超过15码的减少到15码以下 s_pre_voucher_tmp ——> s_pre_vr_tmp01
#161024-00008#2   2016/10/24 By Hans    AFA組織類型與職能開窗清單調整。 
#160426-00014#45  2016/10/31 By 02114   增加afat517的逻辑
#160426-00014#44  2016/11/03 By 02114   增加afat510的逻辑
#161215-00044#1   2016/12/15 by 02481   标准程式定义采用宣告模式,弃用.*写
#161215-00079#1   2016/12/19 By 01531   afat509 整单操作抛转凭证，  默认凭证单别未按 afat509的单别设定 取ooac004里的默认值。
#161226-00057#1   2017/01/04 By 07900   afat513/afat514通过整单操作的“抛转凭证”，建议自动将单号带到单身【符合条件的单据】
#end add-point
#add-point:填寫註解說明(客製用) name="global.memo_customerization"

#end add-point
 
IMPORT os
IMPORT util
#add-point:增加匯入項目 name="global.import"
IMPORT FGL afa_afap280_01  #傳票底稿
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
       fabgld        LIKE fabg_t.fabgld,
       fabgld_desc   LIKE glaal_t.glaal002,
       fabgcomp      LIKE fabg_t.fabgcomp,
       fabgcomp_desc LIKE ooefl_t.ooefl003,
       type          LIKE type_t.chr1,
       glapdocno     LIKE glap_t.glapdocno,
       glapdocdt     LIKE glap_t.glapdocdt,
       docno_s       LIKE glap_t.glapdocno,
       docno_e       LIKE glap_t.glapdocno,
       fabg005       LIKE fabg_t.fabg005,
   #end add-point
        wc               STRING
                     END RECORD
 
TYPE type_g_detail_d RECORD
#add-point:自定義模組變數(Module Variable)  #注意要在add-point內寫入END RECORD name="global.variable"
     sel           LIKE type_t.chr1,
     fabgdocno     LIKE fabg_t.fabgdocno,
     fabgdocdt     LIKE fabg_t.fabgdocdt,
     fabh004       LIKE fabh_t.fabh004,
     fabh008       LIKE fabh_t.fabh008,
     fabh010       LIKE fabh_t.fabh010,
     fabh012       LIKE fabh_t.fabh012,
     fabh019       LIKE fabh_t.fabh019,
     fabh017       LIKE fabh_t.fabh017,
     fabg015       LIKE fabg_t.fabg015,
     fabo012       LIKE fabo_t.fabo012,
     fabo013       LIKE fabo_t.fabo013,
     fabo014       LIKE fabo_t.fabo014,
     fabo015       LIKE fabo_t.fabo015,
     fabo016       LIKE fabo_t.fabo016,
     fabo017       LIKE fabo_t.fabo017
                 END RECORD
#end add-point
 
#add-point:自定義客戶專用模組變數(Module Variable) name="global.variable_customerization"

#end add-point
DEFINE g_detail_cnt         LIKE type_t.num10              #單身 總筆數(所有資料)
DEFINE g_detail_d  DYNAMIC ARRAY OF type_g_detail_d
 
#add-point:傳入參數說明 name="global.argv"
DEFINE g_master       type_parameter
DEFINE g_master_t     type_parameter
DEFINE g_rec_b        LIKE type_t.num5 
DEFINE l_cnt          LIKE type_t.num5
DEFINE g_detail_idx   LIKE type_t.num5
DEFINE la_param  RECORD
          prog   STRING,
          param  DYNAMIC ARRAY OF STRING
                 END RECORD
DEFINE ls_js     STRING
DEFINE g_glaald          LIKE glaa_t.glaald
DEFINE g_glaa004         LIKE glaa_t.glaa004
DEFINE g_glaa013         LIKE glaa_t.glaa013
DEFINE g_flag            LIKE type_t.chr1

#不同作业调用此作业时传入的参数
DEFINE g_fabg005_p   LIKE fabg_t.fabg005      #单据性质
DEFINE g_fabgdocno_p LIKE fabg_t.fabgdocno    #异动单号 
DEFINE g_fabgld_p    LIKE fabg_t.fabgld       #帐套
#161215-00044#1---modify----begin-----------------
#DEFINE g_glaa        RECORD LIKE glaa_t.*
DEFINE g_glaa RECORD  #帳套資料檔
       glaaent LIKE glaa_t.glaaent, #企業編號
       glaaownid LIKE glaa_t.glaaownid, #資料所有者
       glaaowndp LIKE glaa_t.glaaowndp, #資料所屬部門
       glaacrtid LIKE glaa_t.glaacrtid, #資料建立者
       glaacrtdp LIKE glaa_t.glaacrtdp, #資料建立部門
       glaacrtdt LIKE glaa_t.glaacrtdt, #資料創建日
       glaamodid LIKE glaa_t.glaamodid, #資料修改者
       glaamoddt LIKE glaa_t.glaamoddt, #最近修改日
       glaastus LIKE glaa_t.glaastus, #狀態碼
       glaald LIKE glaa_t.glaald, #帳套編號
       glaacomp LIKE glaa_t.glaacomp, #歸屬法人
       glaa001 LIKE glaa_t.glaa001, #使用幣別
       glaa002 LIKE glaa_t.glaa002, #匯率參照表號
       glaa003 LIKE glaa_t.glaa003, #會計週期參照表號
       glaa004 LIKE glaa_t.glaa004, #會計科目參照表號
       glaa005 LIKE glaa_t.glaa005, #現金變動參照表號
       glaa006 LIKE glaa_t.glaa006, #月結方式
       glaa007 LIKE glaa_t.glaa007, #年結方式
       glaa008 LIKE glaa_t.glaa008, #平行記帳否
       glaa009 LIKE glaa_t.glaa009, #傳票登入方式
       glaa010 LIKE glaa_t.glaa010, #現行年度
       glaa011 LIKE glaa_t.glaa011, #現行期別
       glaa012 LIKE glaa_t.glaa012, #最後過帳日期
       glaa013 LIKE glaa_t.glaa013, #關帳日期
       glaa014 LIKE glaa_t.glaa014, #主帳套
       glaa015 LIKE glaa_t.glaa015, #啟用本位幣二
       glaa016 LIKE glaa_t.glaa016, #本位幣二
       glaa017 LIKE glaa_t.glaa017, #本位幣二換算基準
       glaa018 LIKE glaa_t.glaa018, #本位幣二匯率採用
       glaa019 LIKE glaa_t.glaa019, #啟用本位幣三
       glaa020 LIKE glaa_t.glaa020, #本位幣三
       glaa021 LIKE glaa_t.glaa021, #本位幣三換算基準
       glaa022 LIKE glaa_t.glaa022, #本位幣三匯率採用
       glaa023 LIKE glaa_t.glaa023, #次帳套帳務產生時機
       glaa024 LIKE glaa_t.glaa024, #單據別參照表號
       glaa025 LIKE glaa_t.glaa025, #本位幣一匯率採用
       glaa026 LIKE glaa_t.glaa026, #幣別參照表號
       glaa100 LIKE glaa_t.glaa100, #傳票輸入時自動按缺號產生
       glaa101 LIKE glaa_t.glaa101, #傳票總號輸入時機
       glaa102 LIKE glaa_t.glaa102, #傳票成立時,借貸不平衡的處理方式
       glaa103 LIKE glaa_t.glaa103, #未列印的傳票可否進行過帳
       glaa111 LIKE glaa_t.glaa111, #應計調整單別
       glaa112 LIKE glaa_t.glaa112, #期末結轉單別
       glaa113 LIKE glaa_t.glaa113, #年底結轉單別
       glaa120 LIKE glaa_t.glaa120, #成本計算類型
       glaa121 LIKE glaa_t.glaa121, #子模組啟用分錄底稿
       glaa122 LIKE glaa_t.glaa122, #總帳可維護資金異動明細
       glaa027 LIKE glaa_t.glaa027, #單據據點編號
       glaa130 LIKE glaa_t.glaa130, #合併帳套否
       glaa131 LIKE glaa_t.glaa131, #分層合併
       glaa132 LIKE glaa_t.glaa132, #平均匯率計算方式
       glaa133 LIKE glaa_t.glaa133, #非T100公司匯入餘額類型
       glaa134 LIKE glaa_t.glaa134, #合併科目轉換依據異動碼設定值
       glaa135 LIKE glaa_t.glaa135, #現流表間接法群組參照表號
       glaa136 LIKE glaa_t.glaa136, #應收帳款核銷限定己立帳傳票
       glaa137 LIKE glaa_t.glaa137, #應付帳款核銷限定已立帳傳票
       glaa138 LIKE glaa_t.glaa138, #合併報表編制期別
       glaa139 LIKE glaa_t.glaa139, #遞延收入(負債)管理產生否
       glaa140 LIKE glaa_t.glaa140, #無原出貨單的遞延負債減項者,是否仍立遞延收入管理?
       glaa123 LIKE glaa_t.glaa123, #應收帳款核銷可維護資金異動明細
       glaa124 LIKE glaa_t.glaa124, #應付帳款核銷可維護資金異動明細
       glaa028 LIKE glaa_t.glaa028  #匯率來源
       END RECORD

#161215-00044#1---modify----end-----------------
DEFINE g_wc_cs_orga      STRING      #160125-00005#7
DEFINE g_site_str        STRING      #160125-00005#7
DEFINE g_wc_cs_ld        STRING      #160125-00005#7
#end add-point
 
{</section>}
 
{<section id="afap280.main" >}
#+ 作業開始 
MAIN
   #add-point:main段define(客製用) name="main.define_customerization"
   
   #end add-point   
   DEFINE ls_js  STRING
   #add-point:main段define name="main.define"
   #151125-00006#1---add--s 
   DEFINE l_cate         LIKE type_t.chr10
   DEFINE l_wc           STRING
   DEFINE l_success      LIKE type_t.num5
   DEFINE r_success      LIKE type_t.num5   
   DEFINE l_glaa013     LIKE glaa_t.glaa013
   DEFINE l_glaa024     LIKE glaa_t.glaa024
   DEFINE l_year        LIKE type_t.num5
   DEFINE l_month       LIKE type_t.num5
   DEFINE l_bdate       LIKE glap_t.glapdocdt
   DEFINE l_edate       LIKE glap_t.glapdocdt
   DEFINE l_glaa003     LIKE glaa_t.glaa003
   DEFINE l_glaacomp    LIKE glaa_t.glaacomp
   #151125-00006#1---add--e
   #end add-point   
   
   #設定SQL錯誤記錄方式 (模組內定義有效)
   WHENEVER ERROR CALL cl_err_msg_log
 
   #add-point:初始化前定義 name="main.before_ap_init"
   
   #end add-point
   #依模組進行系統初始化設定(系統設定)
   CALL cl_ap_init("afa","")
 
   #add-point:定義背景狀態與整理進入需用參數ls_js name="main.background"
   #151125-00006#1--add-s
   LET g_bgjob = g_argv[5]
   IF cl_null(g_bgjob) THEN LET g_bgjob = 'N' END IF
   #151125-00006#1---add---e
   #end add-point
 
   IF g_bgjob = "Y" THEN
      #add-point:Service Call name="main.servicecall"
      #151125-00006#1--add-s
      DISPLAY 'OK!'
      CALL afap280_init()
      LET g_master.type='1'
      IF NOT cl_null(g_argv[1]) THEN
         LET g_master.fabgld=g_argv[1]
      END IF
      IF NOT cl_null(g_argv[02]) THEN
         LET g_fabgdocno_p=g_argv[02]
      END IF
      IF NOT cl_null(g_argv[03]) THEN
         LET g_master.fabg005=g_argv[03]
      END IF
      IF NOT cl_null(g_argv[04]) THEN
         LET g_master.glapdocno=g_argv[04]
      END IF
      
      IF NOT cl_null(g_glaald) THEN 
         SELECT glaacomp,glaa003 INTO l_glaacomp,l_glaa003
           FROM glaa_t
          WHERE glaaent = g_enterprise
            AND glaald = g_glaald
         CALL cl_get_para(g_enterprise,l_glaacomp,'S-FIN-9018') RETURNING l_year
         CALL cl_get_para(g_enterprise,l_glaacomp,'S-FIN-9019') RETURNING l_month
         CALL s_fin_date_get_period_range(l_glaa003,l_year,l_month) RETURNING l_bdate,l_edate
         LET g_master.glapdocdt = l_edate
      ELSE
         LET g_master.glapdocdt = g_today
      END IF 
      
      CALL afap280_default_search()
      
      CALL afap280_fabgld_desc(g_master.fabgld) 
            
      CALL afap280_b_fill()
      
      LET g_bgjob = 'N'
      
      IF g_detail_d.getLength()>0 THEN
         
         DROP TABLE s_pre_vr_tmp01;   #160727-00019#34   16/08/15 By 08734      临时表长度超过15码的减少到15码以下 s_pre_voucher_tmp ——> s_pre_vr_tmp01                         
         CALL s_pre_voucher_cre_tmp_table() RETURNING l_success 
         
         CASE g_master.fabg005
            WHEN '0'
               LET l_cate =  'F30'  
            WHEN '4'
               LET l_cate =  'F40'  
            WHEN '6'
               LET l_cate =  'F50'  
            WHEN '8'
               LET l_cate =  'F50' 
            WHEN '14'
               LET l_cate =  'F50'  
            WHEN '21'
               LET l_cate =  'F50'
            WHEN '9'
               LET l_cate =  'F50'   
            WHEN '31'              
               LET l_cate =  'F50'    
            OTHERWISE                          
               LET l_cate =  'F50'             
         END CASE  
         
         IF NOT cl_null(g_master.docno_s) OR NOT cl_null(g_master.docno_e) THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = 'asf-00408'
            LET g_errparam.extend = g_master.docno_s
            LET g_errparam.popup = TRUE
            CALL cl_err()
         ELSE

            #161215-00044#1---modify----begin-----------------
            #SELECT * INTO g_glaa.* 
            SELECT glaaent,glaaownid,glaaowndp,glaacrtid,glaacrtdp,glaacrtdt,glaamodid,glaamoddt,glaastus,
            glaald,glaacomp,glaa001,glaa002,glaa003,glaa004,glaa005,glaa006,glaa007,glaa008,glaa009,glaa010,
            glaa011,glaa012,glaa013,glaa014,glaa015,glaa016,glaa017,glaa018,glaa019,glaa020,glaa021,glaa022,
            glaa023,glaa024,glaa025,glaa026,glaa100,glaa101,glaa102,glaa103,glaa111,glaa112,glaa113,glaa120,
            glaa121,glaa122,glaa027,glaa130,glaa131,glaa132,glaa133,glaa134,glaa135,glaa136,glaa137,glaa138,
            glaa139,glaa140,glaa123,glaa124,glaa028 INTO g_glaa.*
            #161215-00044#1---modify----end-----------------
            FROM glaa_t WHERE glaaent = g_enterprise AND glaald = g_master.fabgld
            IF g_glaa.glaa121 = 'Y' THEN 
               CALL s_transaction_begin()
               CALL cl_err_collect_init() 

               #当选择单据日期汇总时， afap280_01_fa_group临时表中docno清空
               IF g_master.type = '1' THEN                   
                  #LET l_wc =" glgbdocno IN (SELECT docno FROM afap280_01_group)"    #151013-00019#4 #160727-00019#2 mark
                  LET l_wc =" glgbdocno IN (SELECT docno FROM afap280_tmp02)"        #160727-00019#2 Mod   afap280_01_group -->afap280_tmp02                  
               ELSE
                  LET l_wc =" glgbdocno IN (SELECT docno FROM afap280_tmp01)"    #160727-00019#2 Mod   afap280_01_fa_tmp -->afap280_tmp01 
               END IF   
                 
               CALL s_pre_voucher_ins_glap('FA',l_cate,g_master.fabgld,g_master.glapdocdt,g_master.glapdocno,g_master.type,l_wc) 
                    RETURNING r_success,g_master.docno_s,g_master.docno_e

               IF r_success THEN
                  CALL s_transaction_end('Y','1')
               ELSE
                  CALL s_transaction_end('N','1')    
               END IF
               CALL cl_err_collect_show()
            ELSE 
               CALL afap280_01_p(g_master.fabg005,g_master.fabgld,g_master.type,g_master.glapdocno,g_master.glapdocdt) 
                    RETURNING g_master.docno_s,g_master.docno_e
            END IF  

         END IF
       END IF
      #151125-00006#1--add-e
      #end add-point
   ELSE
      #畫面開啟 (identifier)
      OPEN WINDOW w_afap280 WITH FORM cl_ap_formpath("afa",g_code)
   
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
   
      #程式初始化
      CALL afap280_init()   
 
      #進入選單 Menu (="N")
      CALL afap280_ui_dialog() 
 
      #add-point:畫面關閉前 name="main.before_close"
      #160426-00014#45--add--str--lujh
      DROP TABLE afap280_tmp01;
      DROP TABLE afap280_tmp02;
      #160426-00014#45--add--end--lujh
      #end add-point
      #畫面關閉
      CLOSE WINDOW w_afap280
   END IF 
   
   #add-point:作業離開前 name="main.exit"
   
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
END MAIN
 
{</section>}
 
{<section id="afap280.init" >}
#+ 畫面資料初始化
PRIVATE FUNCTION afap280_init()
   #add-point:init段define(客製用) name="init.define_customerization"
   
   #end add-point   
   #add-point:init段define name="init.define"
    DEFINE l_success      LIKE type_t.num5
   #end add-point   
   
   LET g_error_show  = 1
   LET g_wc_filter   = " 1=1"
   LET g_wc_filter_t = " 1=1"
 
   #add-point:畫面資料初始化 name="init.init"
   #CALL cl_set_combo_scc_part('fabg005','9910','0,1,4,6,8,9,14,21')
   CALL cl_set_combo_scc_part('fabg005','9910','0,4,6,8,9,14,21,22,26,30,31,23,24,39,43,44')   #add by yangxf  add '30' #150417-00007#65 add '31' #160329-00025#3 add '23' '24' #160426-00014#10 add '39'   #160426-00014#45 add 43 lujh #160426-00014#44 add 44 lujh
   CALL cl_set_combo_scc_part('glapstus','50','N,Y,S')
   CALL afap280_default_search()
   IF NOT cl_null(g_argv[1]) THEN
      LET g_glaald=g_argv[1]
   END IF
   IF NOT cl_null(g_argv[02]) THEN
      LET g_fabgdocno_p=g_argv[02]
      DISPLAY g_fabgdocno_p TO fabgdocno
   END IF
   IF NOT cl_null(g_argv[03]) THEN
      LET g_master.fabg005=g_argv[03]
      DISPLAY g_master.fabg005 TO fabg005
   END IF
   #161215-00079#1 add s---
   IF NOT cl_null(g_argv[04]) THEN
      LET g_master.glapdocno=g_argv[04]
      DISPLAY g_master.glapdocno TO glapdocno
   END IF   
   #161215-00079#1 add e---
   IF cl_null(g_glaald) THEN
      #抓取预设帐别
      CALL s_ld_bookno() RETURNING l_success,g_glaald
      IF l_success = FALSE THEN
         LET g_glaald=NULL
        #RETURN    #160114-00011#1
      END IF
      CALL s_ld_chk_authorization(g_user,g_glaald) RETURNING l_success
      IF l_success = FALSE THEN
         LET g_glaald=NULL
        #RETURN    #160114-00011#1
      END IF
   END IF
   
   CALL s_fin_continue_no_tmp()
   #子程式畫面取代主程式元件
   CALL cl_ui_replace_sub_window(cl_ap_formpath("afa", "afap280_01"), "grid_subject", "Table", "s_detail1_afap280_01")
   
   #营运据点范围
   CALL s_axrt300_get_site(g_user,'','1') RETURNING g_wc_cs_orga #160125-00005#7    
   #end add-point
   
END FUNCTION
 
{</section>}
 
{<section id="afap280.ui_dialog" >}
#+ 選單功能實際執行處
PRIVATE FUNCTION afap280_ui_dialog()
   #add-point:ui_dialog段define(客製用) name="ui_dialog.define_customerization"
   
   #end add-point 
   DEFINE li_idx   LIKE type_t.num10
   #add-point:ui_dialog段define name="init.init"
   DEFINE l_pass         LIKE type_t.num5
   DEFINE l_slip         LIKE ooba_t.ooba002
   DEFINE l_date         LIKE glap_t.glapdocdt
   DEFINE l_success      LIKE type_t.num5
   DEFINE l_oobx004      LIKE oobx_t.oobx004 
   DEFINE l_flag         LIKE type_t.chr1   
   DEFINE l_cate         LIKE type_t.chr10
   DEFINE l_wc           STRING
   DEFINE r_success      LIKE type_t.num5
   DEFINE l_glaa013     LIKE glaa_t.glaa013
   DEFINE l_glaa024     LIKE glaa_t.glaa024
   DEFINE l_year        LIKE type_t.num5
   DEFINE l_month       LIKE type_t.num5
   DEFINE l_bdate       LIKE glap_t.glapdocdt
   DEFINE l_edate       LIKE glap_t.glapdocdt
   DEFINE l_glaa003     LIKE glaa_t.glaa003
   DEFINE l_glaacomp    LIKE glaa_t.glaacomp
   #end add-point 
   
   LET gwin_curr = ui.Window.getCurrent()
   LET gfrm_curr = gwin_curr.getForm()   
   
   LET g_action_choice = " "  
   CALL cl_set_act_visible("accept,cancel", FALSE)
         
   LET g_detail_cnt = g_detail_d.getLength()
   #add-point:ui_dialog段before dialog name="ui_dialog.before_dialog"
   CALL cl_set_act_visible("selall,selnone,unsel,filter",FALSE)
   CLEAR FORM 
#   LET g_master.glapdocdt=g_today           #mark by yangxf
   IF NOT cl_null(g_glaald) THEN 
      SELECT glaacomp,glaa003 INTO l_glaacomp,l_glaa003
        FROM glaa_t
       WHERE glaaent = g_enterprise
         AND glaald = g_glaald
      CALL cl_get_para(g_enterprise,l_glaacomp,'S-FIN-9018') RETURNING l_year
      CALL cl_get_para(g_enterprise,l_glaacomp,'S-FIN-9019') RETURNING l_month
      CALL s_fin_date_get_period_range(l_glaa003,l_year,l_month) RETURNING l_bdate,l_edate
      LET g_master.glapdocdt = l_edate
   ELSE
      LET g_master.glapdocdt = g_today
   END IF 
   LET g_master_t.* = g_master.*
   LET g_master_t.glapdocno = ' '
   DISPLAY BY NAME g_master.fabgld,g_master.fabgld_desc,g_master.fabgcomp,g_master.fabgcomp_desc,g_master.fabg005,g_master.glapdocdt
   
   LET g_site_str = NULL #160125-00005#7  
   
   #end add-point
   
   WHILE TRUE
 
      IF g_action_choice = "logistics" THEN
         #清除畫面及相關資料
         CLEAR FORM
         CALL g_detail_d.clear()
         LET g_wc  = ' 1=2'
         LET g_wc2 = ' 1=1'
         LET g_action_choice = ""
         CALL afap280_init()
      END IF
 
      DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
         #add-point:ui_dialog段construct name="ui_dialog.more_construct"
         INPUT BY NAME g_master.fabgld,g_master.type,g_master.glapdocno,g_master.glapdocdt,g_master.fabg005
               ATTRIBUTE(WITHOUT DEFAULTS)
           
             BEFORE INPUT
               #帳套
               IF cl_null(g_master.fabgld) THEN 
                  LET g_master.fabgld=g_glaald
               END IF
               CALL afap280_set_ld_info(g_master.fabgld)
               CALL afap280_fabgld_desc(g_master.fabgld)
               #單據性質
#               IF cl_null(g_master.fabg005) OR g_master.fabg005=0 THEN   #mark by yangxf
                IF cl_null(g_master.fabg005) THEN                         #add by yangxf
                  LET g_master.fabg005='1'
                  DISPLAY BY NAME g_master.fabg005
               END IF
#               #抓取预设单号和单据性质
#               IF NOT cl_null(g_fabg005_p) THEN 
#                  LET g_master.fabg005 =g_fabg005_p
#                  DISPLAY g_fabg005_p TO fabg005
#               END IF
               IF NOT cl_null(g_fabgdocno_p) THEN 
                  #LET g_master.fabgdocno =g_fabgdocno_p
                  DISPLAY g_fabgdocno_p TO fabgdocno
               END IF
               SELECT glaa024 INTO l_glaa024 FROM glaa_t WHERE glaaent = g_enterprise AND glaald = g_master.fabgld   
               SELECT glaa013 INTO l_glaa013 FROM glaa_t WHERE glaaent=g_enterprise AND glaald=g_master.fabgld   
#               IF NOT cl_null(g_fabgld_p) THEN 
#                  #LET g_master.fabgdocno =g_fabgdocno_p
#                  DISPLAY g_fabgld_p TO fabgld
#               END iF
               
               IF g_master.fabg005 <> '4' THEN
                  #add by yangxf ----
                  IF g_master.fabg005 = '30' THEN  
                     CALL cl_set_comp_visible("b_fabh004,b_fabh010,b_fabh017,b_fabh019",FALSE)
                     CALL cl_set_comp_visible("b_fabh008,b_fabh012",TRUE)
                     CALL cl_set_comp_visible("b_fabg015,b_fabo012,b_fabo013,b_fabo014,b_fabo015,b_fabo016,b_fabo017",FALSE)
                  ELSE
                  #add by yangxf ---
                     CALL cl_set_comp_visible("b_fabh004,b_fabh008,b_fabh010,b_fabh012,b_fabh017,b_fabh019",TRUE)
                     CALL cl_set_comp_visible("b_fabg015,b_fabo012,b_fabo013,b_fabo014,b_fabo015,b_fabo016,b_fabo017",FALSE)
                  END IF #add by yangxf 
               ELSE
                  CALL cl_set_comp_visible("b_fabh004,b_fabh008,b_fabh010,b_fabh012,b_fabh017,b_fabh019",FALSE)
                  CALL cl_set_comp_visible("b_fabg015,b_fabo012,b_fabo013,b_fabo014,b_fabo015,b_fabo016,b_fabo017",TRUE)
               END IF  
               #匯總方式
               IF cl_null(g_master.type) THEN
                  LET g_master.type='1'
                  DISPLAY BY NAME g_master.type
               END IF
               
               
            AFTER FIELD fabgld
               IF NOT cl_null(g_master.fabgld) THEN
                  CALL afap280_fabgld_chk(g_master.fabgld)
                  IF NOT cl_null(g_errno) THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = g_errno
                     LET g_errparam.extend = g_master.fabgld
                     #160318-00005#9 --add--str
                     LET g_errparam.replace[1] ='agli010'
                     LET g_errparam.replace[2] = cl_get_progname('agli010',g_lang,"2")
                     LET g_errparam.exeprog    ='agli010'
                     #160318-00005#9 --add--end
                     LET g_errparam.popup = FALSE
                     CALL cl_err()
            
                     LET g_master.fabgld = ''
                     NEXT FIELD fabgld
                  END IF
                  #检查使用者是否有权限使用当前账别
                  CALL s_ld_chk_authorization(g_user,g_master.fabgld) RETURNING l_pass
                  IF l_pass = FALSE THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = 'axr-00022'
                     LET g_errparam.extend = g_master.fabgld
                     LET g_errparam.popup = FALSE
                     CALL cl_err()
            
                     LET g_master.fabgld = ''
                     NEXT FIELD fabgld
                  END IF
                  #add by yangxf ---
                  IF g_master.fabgld != g_master_t.fabgld THEN 
                     DELETE FROM s_fin_tmp_conti_no
                  END IF 
                  #add by yangxf ---
                  CALL afap280_fabgld_desc(g_master.fabgld)         
                  CALL afap280_set_ld_info(g_master.fabgld)
                  SELECT glaa024 INTO l_glaa024 FROM glaa_t WHERE glaaent = g_enterprise AND glaald = g_master.fabgld   
                  SELECT glaa013 INTO l_glaa013 FROM glaa_t WHERE glaaent=g_enterprise AND glaald=g_master.fabgld    
                  SELECT glaacomp,glaa003 INTO l_glaacomp,l_glaa003
                    FROM glaa_t
                   WHERE glaaent = g_enterprise
                     AND glaald = g_glaald
                  CALL cl_get_para(g_enterprise,l_glaacomp,'S-FIN-9018') RETURNING l_year
                  CALL cl_get_para(g_enterprise,l_glaacomp,'S-FIN-9019') RETURNING l_month
                  CALL s_fin_date_get_period_range(l_glaa003,l_year,l_month) RETURNING l_bdate,l_edate
                  LET g_master.glapdocdt = l_edate  
                  DISPLAY BY NAME g_master.glapdocdt             
               END IF 
               
            AFTER FIELD glapdocno
               IF NOT cl_null(g_master.glapdocno) THEN 
                  #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
                  INITIALIZE g_chkparam.* TO NULL               
                  LET g_chkparam.arg1 = l_glaa024
                  LET g_chkparam.arg2 = g_master.glapdocno
                  #160318-00025#39  2016/04/22  by pengxin  add(S)
                  LET g_errshow = TRUE #是否開窗 
                  LET g_chkparam.err_str[1] = "agl-00189:sub-01302|aooi200|",cl_get_progname("aooi200",g_lang,"2"),"|:EXEPROGaooi200"
                  #160318-00025#39  2016/04/22  by pengxin  add(E)
                  #呼叫檢查存在並帶值的library
                  IF cl_chk_exist("v_ooba002_07") THEN
                  ELSE
                     #檢查失敗時後續處理
                     LET g_master.glapdocno = ''
                     NEXT FIELD CURRENT
                  END IF
                  #add by yangxf ---
                  IF g_master.glapdocno != g_master_t.glapdocno THEN 
                     DELETE FROM s_fin_tmp_conti_no
                  END IF 
                  #add by yangxf ---
               END IF
            
            AFTER FIELD glapdocdt
               IF NOT cl_null(g_master.glapdocdt) THEN
                  IF g_master.glapdocdt<=l_glaa013 THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = "asf-00008"
                     LET g_errparam.extend = g_master.glapdocdt
                     LET g_errparam.popup = FALSE
                     CALL cl_err()
                     NEXT FIELD glapdocdt
                  END IF                
                  #add by yangxf ---
                  IF g_master.glapdocdt != g_master_t.glapdocdt THEN 
                     DELETE FROM s_fin_tmp_conti_no
                  END IF 
                  #add by yangxf ---                  
               END IF
              
            ON ACTION controlp INFIELD glapdocno
   			   INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'i'
   			   LET g_qryparam.reqry = FALSE
               LET g_qryparam.default1 = g_master.glapdocno  #給予default值
               LET g_qryparam.arg1 = l_glaa024
               LET g_qryparam.arg2 = 'aglt310'
               CALL q_ooba002_1()                            #呼叫開窗
               LET g_master.glapdocno = g_qryparam.return1   #將開窗取得的值回傳到變數
               DISPLAY g_master.glapdocno TO glapdocno       #顯示到畫面上
               NEXT FIELD glapdocno 
               
            ON CHANGE type
               IF g_master.type NOT MATCHES '[12]' THEN
                  NEXT FIELD type
               END IF
                 
            ON CHANGE fabg005
               IF g_master.fabg005 <> '4' AND g_master.fabg005 <> '43' AND g_master.fabg005 <> '44' THEN    #160426-00014#45 add g_master.fabg005 <> '43' lujh  #160426-00014#44 add g_master.fabg005 <> '44' lujh
                  #add by yangxf ----
                  IF g_master.fabg005 = '30' THEN  
                     CALL cl_set_comp_visible("b_fabh004,b_fabh010,b_fabh017,b_fabh019",FALSE)
                     CALL cl_set_comp_visible("b_fabh008,b_fabh012",TRUE)
                     CALL cl_set_comp_visible("b_fabg015,b_fabo012,b_fabo013,b_fabo014,b_fabo015,b_fabo016,b_fabo017",FALSE)
                  ELSE
                  #add by yangxf ---
                     CALL cl_set_comp_visible("b_fabh004,b_fabh008,b_fabh010,b_fabh012,b_fabh017,b_fabh019",TRUE)
                     CALL cl_set_comp_visible("b_fabg015,b_fabo012,b_fabo013,b_fabo014,b_fabo015,b_fabo016,b_fabo017",FALSE)
                  END IF    #add by yangxf
               ELSE
                  CALL cl_set_comp_visible("b_fabh004,b_fabh008,b_fabh010,b_fabh012,b_fabh017,b_fabh019",FALSE)
                  CALL cl_set_comp_visible("b_fabg015,b_fabo012,b_fabo013,b_fabo014,b_fabo015,b_fabo016,b_fabo017",TRUE)
               END IF  
               
            ON ACTION cont_no
               IF cl_null(g_master.fabgld)  THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'aap-00332'
                  LET g_errparam.extend = s_fin_get_colname('','fabgld')
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
                  CONTINUE DIALOG
               END IF
               IF cl_null(g_master.glapdocno) THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'aap-00332'
                  LET g_errparam.extend = s_fin_get_colname('','glapdocno')
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
                  CONTINUE DIALOG
               END IF
               IF cl_null(g_master.glapdocdt) THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'aap-00331'
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
                  CONTINUE DIALOG
               END IF
               
               CALL s_transaction_begin()
               CALL s_fin_continue_no_input(g_master.fabgld,'',g_master.glapdocno,g_master.glapdocdt,'3')
               CALL s_transaction_end('Y','Y')
               
            ON ACTION controlp INFIELD fabgld
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'i'
               LET g_qryparam.reqry = FALSE
               LET g_qryparam.default1 = g_master.fabgld             #給予default值
               #給予arg
               LET g_qryparam.arg1 = g_user
               LET g_qryparam.arg2 = g_dept     
               #160125-00005#7--add--str--
               #账套范围
               CALL s_axrt300_get_site(g_user,g_site_str,'2')  RETURNING g_wc_cs_ld 
               IF NOT cl_null(g_wc_cs_ld) THEN   
                  LET g_qryparam.where = g_wc_cs_ld
               END IF
               #160125-00005#7--add--end                   
               CALL q_authorised_ld()                                #呼叫開窗
               LET g_master.fabgld = g_qryparam.return1              
               DISPLAY g_master.fabgld TO fabgld              #
               CALL afap280_fabgld_desc(g_master.fabgld)
               NEXT FIELD fabgld                          #返回原欄位
         END INPUT
         
         #查詢QBE
         CONSTRUCT BY NAME g_master.wc ON fabgsite,fabg001,fabgdocdt,fabgdocno

            BEFORE CONSTRUCT
               CALL cl_qbe_init()
               
            #160125-00005#7 add s---   
            AFTER FIELD fabgsite   
               CALL FGL_DIALOG_GETBUFFER() RETURNING g_site_str  
            #160125-00005#7 add e---
            
            AFTER CONSTRUCT
               #呼叫P次作業
            
            ON ACTION controlp INFIELD fabgsite
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c'
               LET g_qryparam.reqry = FALSE
               #160125-00005#7--add--str--   
               LET g_qryparam.where = " ooef201 = 'Y' "
               IF NOT cl_null(g_wc_cs_orga) THEN
			         LET g_qryparam.where = g_wc_cs_orga
			      END IF
			      #CALL q_ooef001()    #161024-00008#2 
			      CALL q_ooef001_47()  #161024-00008#2 
			      #160125-00005#7--add--end                  
               #CALL q_faab001()   #160125-00005#7               #呼叫開窗
               DISPLAY g_qryparam.return1 TO fabgsite  #顯示到畫面上
               NEXT FIELD fabgsite                     #返回原欄位
               
            ON ACTION controlp INFIELD fabg001
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c'
               LET g_qryparam.reqry = FALSE
               CALL q_ooag001()                           #呼叫開窗
               DISPLAY g_qryparam.return1 TO fabg001  #顯示到畫面上
               NEXT FIELD fabg001  
               
            ON ACTION controlp INFIELD fabgdocno
   	         INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c'
   	         LET g_qryparam.reqry = FALSE
               LET g_qryparam.where = " fabg005='",g_master.fabg005,"'"
   	         CALL q_fabgdocno()
               DISPLAY g_qryparam.return1 TO fabgdocno  #顯示到畫面上  
               NEXT FIELD fabgdocno                     #返回原欄位  
             
         END CONSTRUCT
         #end add-point
         #add-point:ui_dialog段input name="ui_dialog.more_input"
         
         #end add-point
         #add-point:ui_dialog段自定義display array name="ui_dialog.more_displayarray"
         DISPLAY ARRAY g_detail_d TO s_detail1.* ATTRIBUTES(COUNT=g_rec_b) #page1  
    
            BEFORE ROW
               LET l_ac = DIALOG.getCurrentRow("s_detail1")
               LET g_detail_idx = l_ac
               DISPLAY g_detail_idx TO h_index
               
            BEFORE DISPLAY
               CALL FGL_SET_ARR_CURR(g_detail_idx)
               LET l_ac = DIALOG.getCurrentRow("s_detail1")
               DISPLAY g_rec_b TO h_count
               
            ON ACTION axrt330
#               CALL s_aooi200_get_slip(g_detail_d[l_ac].fabgdocno)           #mark by yangxf
               CALL s_aooi200_fin_get_slip_desc(g_detail_d[l_ac].fabgdocno)   #add by yangxf
               RETURNING l_success,l_slip
               SELECT oobx004 INTO l_oobx004 FROM oobx_t WHERE oobxent = g_enterprise AND oobx001 = l_slip
               IF l_oobx004 = 'MULTI' THEN 
                  INITIALIZE g_qryparam.* TO NULL
                  LET g_qryparam.state = 'i'
                  LET g_qryparam.arg1 = l_slip
                  CALL q_oobl002()                                
                  LET l_oobx004 = g_qryparam.return1           
               END IF
               
               LET la_param.prog = l_oobx004
               LET la_param.param[1] = g_master.fabgld
               LET la_param.param[2] = g_detail_d[l_ac].fabgdocno
               LET ls_js = util.JSON.stringify(la_param)
               CALL cl_cmdrun(ls_js)

         END DISPLAY
         SUBDIALOG afa_afap280_01.afap280_01_display
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
            #CALL cl_set_comp_visible("sel",FALSE)
            #161226-00057#1--add--s--
            IF g_bgjob = "T" THEN
              LET g_master.type='1'
              LET g_master.fabgld = g_argv[1]
              LET g_master_idx=1
              LET g_error_show = 1
              CALL afap280_b_fill()
              LET l_ac = g_master_idx
              IF g_detail_cnt = 0 AND NOT INT_FLAG THEN
                 INITIALIZE g_errparam TO NULL 
                 LET g_errparam.extend = "" 
                 LET g_errparam.code   = -100 
                 LET g_errparam.popup  = TRUE 
                 CALL cl_err()             
              END IF              
            END IF
            #161226-00057#1--add--e--
             NEXT FIELD fabgld
            #end add-point
 
         #選擇全部
         ON ACTION selall
            CALL DIALOG.setSelectionRange("s_detail1", 1, -1, 1)
            #add-point:ui_dialog段on action selall name="ui_dialog.selall.befroe"
            
            #end add-point            
            FOR li_idx = 1 TO g_detail_d.getLength()
               LET g_detail_d[li_idx].sel = "Y"
               #add-point:ui_dialog段on action selall name="ui_dialog.for.onaction_selall"
               ##############################add by huangtao 
               SELECT glaa013 INTO g_glaa013  FROM glaa_t WHERE glaaent = g_enterprise AND glaald = g_master.fabgld            
               IF g_detail_d[li_idx].fabgdocdt <g_glaa013 THEN
                  CALL cl_ask_pressanykey('axr-00061')
                  LET g_detail_d[li_idx].sel = "N"
               ELSE
                  LET g_detail_d[li_idx].sel = "Y"
               END IF
               ##############################add by huangtao
               #end add-point
            END FOR
            #add-point:ui_dialog段on action selall name="ui_dialog.onaction_selall"
            CALL afap280_gen()   #151228-00007#1 add
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
            CALL afap280_gen()   #151228-00007#1 add
            #end add-point
 
         #勾選所選資料
         ON ACTION sel
            FOR li_idx = 1 TO g_detail_d.getLength()
               IF DIALOG.isRowSelected("s_detail1", li_idx) THEN
                  LET g_detail_d[li_idx].sel = "Y"
               END IF
            END FOR
            #add-point:ui_dialog段on action sel name="ui_dialog.onaction_sel"
            #############################add by huangtao
            FOR li_idx = 1 TO g_detail_d.getLength()
               IF DIALOG.isRowSelected("s_detail1", li_idx) THEN
                  SELECT glaa013 INTO g_glaa013  FROM glaa_t WHERE glaaent = g_enterprise AND glaald = g_master.fabgld               
                  IF g_detail_d[li_idx].fabgdocdt <g_glaa013 THEN
                     CALL cl_ask_pressanykey('axr-00061')
                     LET g_detail_d[li_idx].sel = "N"
                  ELSE
                     LET g_detail_d[li_idx].sel = "Y"
                  END IF           
               END IF
            END FOR
            #############################add by huangtao
            CALL afap280_gen()   #151228-00007#1 add
            #end add-point
 
         #取消所選資料
         ON ACTION unsel
            FOR li_idx = 1 TO g_detail_d.getLength()
               IF DIALOG.isRowSelected("s_detail1", li_idx) THEN
                  LET g_detail_d[li_idx].sel = "N"
               END IF
            END FOR
            #add-point:ui_dialog段on action unsel name="ui_dialog.onaction_unsel"
            CALL afap280_gen()   #151228-00007#1 add
            CONTINUE DIALOG
       {
            #end add-point
      
         ON ACTION filter
            LET g_action_choice="filter"
            CALL afap280_filter()
            #add-point:ON ACTION filter name="menu.filter"
       }
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
            CALL afap280_query()
             
         # 條件清除
         ON ACTION qbeclear
            #add-point:ui_dialog段 name="ui_dialog.qbeclear"
            CALL afap280_set_ld_info(g_master.fabgld)
            
            CALL afap280_default()   #160811-00049#1 add lujh
            #end add-point
 
         # 重新整理
         ON ACTION datarefresh
            LET g_error_show = 1
            #add-point:ui_dialog段datarefresh name="ui_dialog.datarefresh"
            
            #end add-point
            CALL afap280_b_fill()
 
         #add-point:ui_dialog段action name="ui_dialog.more_action"
         ON ACTION detail_page
            NEXT FIELD fabgdocno
            
         ON ACTION subject_page
            IF g_detail_idx>0 THEN
               CALL afap280_01_glap_fill(g_master.type,g_master.fabgld,g_detail_d[g_detail_idx].fabgdocno,g_detail_d[g_detail_idx].fabgdocdt,'')
            END IF
            NEXT FIELD lc_subject
            
         ON ACTION batch_execute
            LET g_action_choice="batch_execute"
            IF cl_auth_chk_act("batch_execute") THEN
               #IF g_flag = 'N'THEN
               #   CALL cl_ask_pressanykey('axr-00061')
               #END IF
               #傳入g_argv[03]，判斷是否從其他程序調用，若是從其他程序調用，那麼拋轉成功后，關閉所有窗體，回到主畫面
               LET l_flag = 'N' 
               FOR li_idx = 1 TO g_detail_d.getLength()
                   IF g_detail_d[li_idx].sel = "Y" THEN 
                      LET l_flag = 'Y' 
                   END IF     
               END FOR          
               IF g_detail_d.getLength()>0 AND l_flag = 'Y' THEN
                  IF cl_null(g_master.glapdocno) THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "" 
                     LET g_errparam.code   = 'axr-00254' 
                     LET g_errparam.popup  = TRUE 
                     CALL cl_err()
                     NEXT FIELD glapdocno
                  END IF
                  IF cl_null(g_master.glapdocdt) THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "" 
                     LET g_errparam.code   = 'axr-00296' 
                     LET g_errparam.popup  = TRUE 
                     CALL cl_err()
                     NEXT FIELD glapdocdt
                  END IF
                  DROP TABLE s_pre_vr_tmp01;                          #20150112 add by chenying  #160727-00019#34   16/08/15 By 08734      临时表长度超过15码的减少到15码以下 s_pre_voucher_tmp ——> s_pre_vr_tmp01
                  CALL s_pre_voucher_cre_tmp_table() RETURNING l_success #20150112 add by chenying
                  #20150112 add by chenying
                  CASE g_master.fabg005
                     WHEN '0'
                        LET l_cate =  'F30'  
                     WHEN '4'
                        LET l_cate =  'F40'  
                     WHEN '6'
                        LET l_cate =  'F50'  
                     WHEN '8'
                        LET l_cate =  'F50' 
                     WHEN '14'
                        LET l_cate =  'F50'  
                     WHEN '21'
                        LET l_cate =  'F50'
                     WHEN '9'
                        LET l_cate =  'F50'   
                     WHEN '31'              #150417-00007#65 add '31'
                        LET l_cate =  'F50'    
                     OTHERWISE                          #add by yangxf
                        LET l_cate =  'F50'             #add by yangxf
                  END CASE  
                  #20150112 add by chenying
                  
                  IF NOT cl_null(g_master.docno_s) OR NOT cl_null(g_master.docno_e) THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = 'asf-00408'
                     LET g_errparam.extend = g_master.docno_s
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                  ELSE
                     #20150112 add by chenying 
                     #161215-00044#1---modify----begin-----------------
                     #SELECT * INTO g_glaa.* 
                     SELECT glaaent,glaaownid,glaaowndp,glaacrtid,glaacrtdp,glaacrtdt,glaamodid,glaamoddt,glaastus,
                     glaald,glaacomp,glaa001,glaa002,glaa003,glaa004,glaa005,glaa006,glaa007,glaa008,glaa009,glaa010,
                     glaa011,glaa012,glaa013,glaa014,glaa015,glaa016,glaa017,glaa018,glaa019,glaa020,glaa021,glaa022,
                     glaa023,glaa024,glaa025,glaa026,glaa100,glaa101,glaa102,glaa103,glaa111,glaa112,glaa113,glaa120,
                     glaa121,glaa122,glaa027,glaa130,glaa131,glaa132,glaa133,glaa134,glaa135,glaa136,glaa137,glaa138,
                     glaa139,glaa140,glaa123,glaa124,glaa028 INTO g_glaa.*
                     #161215-00044#1---modify----end-----------------
                     FROM glaa_t WHERE glaaent = g_enterprise AND glaald = g_master.fabgld
                     IF g_glaa.glaa121 = 'Y' THEN 
                        CALL s_transaction_begin()
                        CALL cl_err_collect_init() 
                        #20150130 mod by chenying 
                        #当选择单据日期汇总时， afap280_01_fa_group临时表中docno清空
                        IF g_master.type = '1' THEN                   
                          #LET l_wc =" glgbdocno IN (SELECT docno FROM afap280_01_fa_group)" #151013-00019#4 mark 
                          #LET l_wc =" glgbdocno IN (SELECT docno FROM afap280_01_group)"    #151013-00019#4 #160727-00019#2 mark
                           LET l_wc =" glgbdocno IN (SELECT docno FROM afap280_tmp02)"       #160727-00019#2 Mod   afap280_01_group -->afap280_tmp02                      
                        ELSE
                           LET l_wc =" glgbdocno IN (SELECT docno FROM afap280_tmp01)"   #160727-00019#2 Mod   afap280_01_fa_tmp -->afap280_tmp01 
                        END IF   
                        #20150130 mod by chenying                   
                        CALL s_pre_voucher_ins_glap('FA',l_cate,g_master.fabgld,g_master.glapdocdt,g_master.glapdocno,g_master.type,l_wc) RETURNING r_success,g_master.docno_s,g_master.docno_e
                        DISPLAY BY NAME g_master.docno_s,g_master.docno_e
                        IF r_success THEN
                           CALL s_transaction_end('Y','1')
                        ELSE
                           CALL s_transaction_end('N','1')    
                        END IF
                        CALL cl_err_collect_show()
                     ELSE 
                     #20150112 add by chenying
                        CALL afap280_01_p(g_master.fabg005,g_master.fabgld,g_master.type,g_master.glapdocno,g_master.glapdocdt) RETURNING g_master.docno_s,g_master.docno_e
                     END IF   #20150112 add by chenying 
                     DISPLAY BY NAME g_master.docno_s,g_master.docno_e
                  END IF
                  
#                 CALL afap280_01_s02(g_master.fabg005,g_master.fabgld,g_master.type,g_argv[03]) 
#                 IF NOT cl_null(g_argv[03]) THEN
#                    LET INT_FLAG=FALSE         
#                    LET g_action_choice = "exit"
#                    EXIT DIALOG
#                 END IF
               END IF
            END IF
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
 
{<section id="afap280.query" >}
#+ QBE資料查詢
PRIVATE FUNCTION afap280_query()
   #add-point:query段define(客製用) name="query.define_customerization"
   
   #end add-point 
   DEFINE ls_wc      STRING
   DEFINE ls_return  STRING
   DEFINE ls_result  STRING 
   #add-point:query段define name="query.define"
   
   #end add-point 
    
   #add-point:cs段after_construct name="query.after_construct"
   LET g_master_idx=1
   #end add-point
        
   LET g_error_show = 1
   CALL afap280_b_fill()
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
 
{<section id="afap280.b_fill" >}
#+ 單身陣列填充
PRIVATE FUNCTION afap280_b_fill()
   #add-point:b_fill段define(客製用) name="b_fill.define_customerization"
   
   #end add-point
   DEFINE ls_wc           STRING
   #add-point:b_fill段define name="b_fill.define"
   DEFINE l_i             LIKE type_t.num5
   #end add-point
 
   LET g_wc = g_wc, cl_sql_auth_filter()   #(ver:21) add cl_sql_auth_filter()
 
   #add-point:b_fill段sql_before name="b_fill.sql_before"
   LET g_flag = 'Y'
   #160811-00049#1--add--str--lujh
   LET g_master.docno_s = ''
   LET g_master.docno_e = ''
   DISPLAY g_master.docno_s,g_master.docno_e TO docno_s,docno_e
   #160811-00049#1--add--end--lujh
   IF cl_null(g_master.wc) THEN
      LET g_master.wc=" 1=1"
   END IF
   IF NOT cl_null(g_master.fabg005) THEN 
      IF g_master.fabg005 <> '4' AND g_master.fabg005 <> '43' AND g_master.fabg005 <> '44' THEN   #160426-00014#45 add g_master.fabg005 <> '43' lujh   #160426-00014#44 add g_master.fabg005 <> '44' lujh
         #add by yangxf ---
         IF g_master.fabg005 = '30' THEN
            LET g_sql="SELECT 'Y',fabgdocno,fabgdocdt,'',SUM(fabp006),'',SUM(fabp007),",
                      "       '','','','','','','','',''  ",
                      "  FROM fabg_t,fabp_t ",
                      " WHERE fabgent=fabpent AND fabgld=fabpld AND fabgdocno=fabpdocno AND fabgent=? ",
                      "   AND fabgld='",g_master.fabgld,"' AND fabg005='",g_master.fabg005,"' ",
                      "   AND fabg008 IS NULL",
                      "   AND fabgstus='S' AND ",g_master.wc,
                      " GROUP BY fabgdocno,fabgdocdt ",
                      " ORDER BY fabgdocno,fabgdocdt "
         ELSE
         #add by yangxf ---
            LET g_sql="SELECT 'Y',fabgdocno,fabgdocdt,SUM(fabh004),SUM(fabh008),SUM(fabh010),SUM(fabh011),",
                      "       SUM(fabh019),SUM(fabh017),'','','','','','',''  ",
                      "  FROM fabg_t,fabh_t ",
                      " WHERE fabgent=fabhent AND fabgld=fabhld AND fabgdocno=fabhdocno AND fabgent=? ",
                      "   AND fabgld='",g_master.fabgld,"' AND fabg005='",g_master.fabg005,"' ",
                      "   AND fabg008 IS NULL",
                      "   AND fabgstus='S' AND ",g_master.wc,
                      " GROUP BY fabgdocno,fabgdocdt ",
                      " ORDER BY fabgdocno,fabgdocdt "
         END IF #add by yangxf
      ELSE
         IF g_master.fabg005 = '4' THEN     #160426-00014#45 add lujh
            LET g_sql="SELECT 'Y',fabgdocno,fabgdocdt,'','','','','','',",
                      "       fabg015,SUM(fabo012),SUM(fabo013),SUM(fabo014),SUM(fabo015),SUM(fabo016),SUM(fabo017) ",
                      "  FROM fabg_t,fabo_t",
                      " WHERE fabgent=faboent AND fabgld=fabold AND fabgdocno=fabodocno AND fabgent=? ",
                      "   AND fabgld='",g_master.fabgld,"' AND fabg005='",g_master.fabg005,"' ",
                      "   AND fabg008 IS NULL",
                      "   AND fabgstus='S' AND ",g_master.wc,
                      " GROUP BY fabgdocno,fabgdocdt,fabg015",
                      " ORDER BY fabgdocno,fabgdocdt,fabg015"
         #160426-00014#45--add--str--lujh
         ELSE
            LET g_sql="SELECT 'Y',fabgdocno,fabgdocdt,'','','','','','',",
                      "       fabg015,SUM(faca011),SUM(faca012),SUM(faca013),SUM(faca014),SUM(faca015),SUM(faca016) ",
                      "  FROM fabg_t,faca_t",
                      " WHERE fabgent = facaent ",
                      "   AND fabgld = facald ",
                      "   AND fabgdocno = facadocno ",
                      "   AND fabgent = ? ",
                      "   AND fabgld = '",g_master.fabgld,"'",
                      "   AND fabg005 = '",g_master.fabg005,"' ",
                      "   AND fabg008 IS NULL",
                      "   AND fabgstus = 'S' ",
                      "   AND ",g_master.wc,
                      " GROUP BY fabgdocno,fabgdocdt,fabg015",
                      " ORDER BY fabgdocno,fabgdocdt,fabg015"
         END IF  
         #160426-00014#45--add--end--lujh         
      END IF
   ELSE
      LET g_sql="SELECT 'Y',fabgdocno,fabgdocdt,SUM(fabh004),SUM(fabh008),SUM(fabh010),SUM(fabh011),",
                "       SUM(fabh019),SUM(fabh017),'','','','','','',''  ",
                "  FROM fabg_t,fabh_t ",
                " WHERE fabgent=fabhent AND fabgld=fabhld AND fabgdocno=fabhdocno AND fabgent=? ",
                "   AND fabgld='",g_master.fabgld,"' AND fabg005 IN ('6','8','9','14','21') ",
                "   AND fabg008 IS NULL",
                "   AND fabgstus='S' AND ",g_master.wc,
                " GROUP BY fabgdocno,fabgdocdt ",
                " ORDER BY fabgdocno,fabgdocdt "
   END IF 
   #end add-point
 
   PREPARE afap280_sel FROM g_sql
   DECLARE b_fill_curs CURSOR FOR afap280_sel
   
   CALL g_detail_d.clear()
   #add-point:b_fill段其他頁簽清空 name="b_fill.clear"
   SELECT glaa013 INTO g_glaa013  FROM glaa_t WHERE glaaent = g_enterprise AND glaald = g_master.fabgld
   #end add-point
 
   LET g_cnt = l_ac
   LET l_ac = 1   
   ERROR "Searching!" 
 
   FOREACH b_fill_curs USING g_enterprise INTO 
   #add-point:b_fill段foreach_into name="b_fill.foreach_into"
   g_detail_d[l_ac].sel,g_detail_d[l_ac].fabgdocno,g_detail_d[l_ac].fabgdocdt,g_detail_d[l_ac].fabh004,g_detail_d[l_ac].fabh008,
   g_detail_d[l_ac].fabh010,g_detail_d[l_ac].fabh012,g_detail_d[l_ac].fabh019,g_detail_d[l_ac].fabh017,
   g_detail_d[l_ac].fabg015,g_detail_d[l_ac].fabo012,g_detail_d[l_ac].fabo013,g_detail_d[l_ac].fabo014,
   g_detail_d[l_ac].fabo015,g_detail_d[l_ac].fabo016,g_detail_d[l_ac].fabo017
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
      IF g_detail_d[l_ac].fabgdocdt <g_glaa013 THEN
         LET g_flag = 'N'
         LET g_detail_d[l_ac].sel = 'N'    #add by huangtao
      END IF
      IF cl_null(g_detail_d[l_ac].fabh004) THEN LET g_detail_d[l_ac].fabh004 = 0 END IF
      IF cl_null(g_detail_d[l_ac].fabh008) THEN LET g_detail_d[l_ac].fabh008 = 0 END IF
      IF cl_null(g_detail_d[l_ac].fabh010) THEN LET g_detail_d[l_ac].fabh010 = 0 END IF
      IF cl_null(g_detail_d[l_ac].fabh012) THEN LET g_detail_d[l_ac].fabh012 = 0 END IF
      IF cl_null(g_detail_d[l_ac].fabh019) THEN LET g_detail_d[l_ac].fabh019 = 0 END IF
      IF cl_null(g_detail_d[l_ac].fabh017) THEN LET g_detail_d[l_ac].fabh017 = 0 END IF
      IF cl_null(g_detail_d[l_ac].fabo012) THEN LET g_detail_d[l_ac].fabo012 = 0 END IF
      IF cl_null(g_detail_d[l_ac].fabo013) THEN LET g_detail_d[l_ac].fabo013 = 0 END IF
      IF cl_null(g_detail_d[l_ac].fabo014) THEN LET g_detail_d[l_ac].fabo014 = 0 END IF
      IF cl_null(g_detail_d[l_ac].fabo015) THEN LET g_detail_d[l_ac].fabo015 = 0 END IF
      IF cl_null(g_detail_d[l_ac].fabo016) THEN LET g_detail_d[l_ac].fabo016 = 0 END IF
      IF cl_null(g_detail_d[l_ac].fabo017) THEN LET g_detail_d[l_ac].fabo017 = 0 END IF
      #end add-point
      
      CALL afap280_detail_show()      
 
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
   FREE afap280_sel
   
   LET l_ac = 1
   CALL afap280_fetch()
   #add-point:b_fill段資料填充(其他單身) name="b_fill.after_b_fill"
   IF g_flag = 'N' THEN
      CALL cl_ask_pressanykey('axr-00061')
   END IF

   IF g_detail_d.getLength()>0 THEN    
      LET g_detail_idx=1
      CALL afap280_gen()
   END IF

   #end add-point
 
END FUNCTION
 
{</section>}
 
{<section id="afap280.fetch" >}
#+ 單身陣列填充2
PRIVATE FUNCTION afap280_fetch()
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
 
{<section id="afap280.detail_show" >}
#+ 顯示相關資料
PRIVATE FUNCTION afap280_detail_show()
   #add-point:show段define(客製用) name="detail_show.define_customerization"
   
   #end add-point
   #add-point:show段define name="detail_show.define"
   
   #end add-point
   
   #add-point:detail_show段 name="detail_show.detail_show"
   
   #end add-point
 
END FUNCTION
 
{</section>}
 
{<section id="afap280.filter" >}
#+ filter過濾功能
PRIVATE FUNCTION afap280_filter()
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
   
   CALL afap280_b_fill()
   
END FUNCTION
 
{</section>}
 
{<section id="afap280.filter_parser" >}
#+ filter欄位解析
PRIVATE FUNCTION afap280_filter_parser(ps_field)
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
 
{<section id="afap280.filter_show" >}
#+ Browser標題欄位顯示搜尋條件
PRIVATE FUNCTION afap280_filter_show(ps_field,ps_object)
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
   LET ls_condition = afap280_filter_parser(ps_field)
   IF NOT cl_null(ls_condition) THEN
      LET ls_title = ls_title, '※', ls_condition, '※'
   END IF
 
   #將資料顯示回去
   CALL lnode_item.setAttribute("text",ls_title)
 
END FUNCTION
 
{</section>}
 
{<section id="afap280.other_function" readonly="Y" >}
#add-point:自定義元件(Function) name="other.function"

################################################################################
# Descriptions...: 帳別檢查
# Memo...........:
# Usage..........: CALL afap280_fabgld_chk(p_fabgld)
# Modify.........:
################################################################################
PRIVATE FUNCTION afap280_fabgld_chk(p_fabgld)
   DEFINE p_fabgld    LIKE fabg_t.fabgld
   DEFINE l_glaastus  LIKE glaa_t.glaastus
   
   LET g_errno = ''
   SELECT glaastus INTO l_glaastus FROM glaa_t
    WHERE glaaent = g_enterprise
      AND glaald = p_fabgld
   CASE
      WHEN SQLCA.SQLCODE = 100   LET g_errno = 'agl-00016'
      WHEN l_glaastus = 'N'      LET g_errno = 'sub-01302'  #'agl-00051' #160318-00005#9 mod
   END CASE
END FUNCTION

################################################################################
# Descriptions...: 帳套說明
# Memo...........:
# Usage..........: CALL afap280_fabgld_desc(p_fabgld)
# Modify.........:
################################################################################
PRIVATE FUNCTION afap280_fabgld_desc(p_fabgld)
   DEFINE p_fabgld    LIKE fabg_t.fabgld
   
   SELECT glaacomp,glaa004 INTO g_master.fabgcomp,g_glaa004 FROM glaa_t 
   WHERE glaaent=g_enterprise AND glaald= p_fabgld
   
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = p_fabgld 
   CALL ap_ref_array2(g_ref_fields,"SELECT glaal002 FROM glaal_t WHERE glaalent='"||g_enterprise||"' AND glaalld=? AND glaal001='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_master.fabgld_desc=g_rtn_fields[1]
   
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_master.fabgcomp 
   CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_master.fabgcomp_desc=g_rtn_fields[1]
   DISPLAY BY NAME g_master.fabgld_desc,g_master.fabgcomp,g_master.fabgcomp_desc
END FUNCTION

################################################################################
# Descriptions...: 產生傳票底稿
# Memo...........:
# Usage..........: CALL afap280_gen()
# Modify.........:
################################################################################
PRIVATE FUNCTION afap280_gen()
   DEFINE l_success        LIKE type_t.num5
   DEFINE l_wc             STRING
   DEFINE l_i              LIKE type_t.num5
   
   IF cl_null(g_master.fabg005) THEN
      RETURN
   END IF
   
   IF cl_null(g_master.fabgld) THEN
      RETURN
   END IF
   
   IF cl_null(g_master.type) THEN
      RETURN
   END IF
   
   IF cl_null(g_master.wc) THEN
      LET g_master.wc=' 1=1'
   END IF
   
   ####################add by huangtao
   FOR l_i = 1 TO g_detail_d.getLength()
       IF g_detail_d[l_i].sel = "Y" THEN     
          IF cl_null(l_wc) THEN
             LET l_wc = "'",g_detail_d[l_i].fabgdocno,"'"
          ELSE
             LET l_wc =l_wc,",'",g_detail_d[l_i].fabgdocno,"'"
          END IF         
       END IF     
   END FOR 
   LET l_wc = g_master.wc," AND fabgdocno IN (",l_wc,")" 
  #####################add by huangtao
   
   CALL afap280_01_cre_fa_tmp_table() RETURNING l_success  #151125-0006#1---add by aiqq
   CALL s_transaction_begin()  #151125-00006#1---add by aiqq
                          #移動類型         #帳套        #日期 #單據別  #匯總方式 #查詢條件  #是否先預覽后再拋憑證
   CALL afap280_01_gen_ar(g_master.fabg005,g_master.fabgld,'','',g_master.type,l_wc,'Y','afap280') RETURNING l_success
   
   IF l_success THEN
      CALL s_transaction_end('Y','0')
   ELSE
      CALL s_transaction_end('N','0')
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
PRIVATE FUNCTION afap280_default_search()
   DEFINE li_idx  LIKE type_t.num5
   DEFINE li_cnt  LIKE type_t.num5
   DEFINE ls_wc   STRING
   
   IF NOT cl_null(g_argv[1]) THEN
      LET ls_wc = ls_wc, " fabgld = '", g_argv[1], "' AND "
   END IF

   IF NOT cl_null(g_argv[02]) THEN
      LET ls_wc = ls_wc, " fabgdocno = '", g_argv[02], "' AND "
   END IF
   
   IF NOT cl_null(g_argv[03]) THEN
      LET ls_wc = ls_wc, " fabg005 = '", g_argv[03], "' AND "
   END IF



   IF NOT cl_null(ls_wc) THEN
      LET g_wc = ls_wc.subString(1,ls_wc.getLength()-5)
   ELSE
      IF cl_null(g_wc) THEN
         LET g_wc = " 1=1"
      END IF
   END IF

   #add-point:default_search段結束前
   LET g_master.wc = g_wc
   #end add-point
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
PRIVATE FUNCTION afap280_set_ld_info(p_ld)
DEFINE p_ld          LIKE glaa_t.glaald
DEFINE l_glaa100     LIKE glaa_t.glaa100

   SELECT glaa100 INTO l_glaa100 FROM glaa_t WHERE glaaent = g_enterprise AND glaald = p_ld

    IF l_glaa100 = 'Y' THEN
      CALL cl_set_comp_visible('cont_no',FALSE)
    ELSE
      CALL cl_set_comp_visible('cont_no',TRUE)
    END IF
END FUNCTION
# 赋默认值
#160811-00049#1 add lujh
PRIVATE FUNCTION afap280_default()
   DEFINE l_glaa013     LIKE glaa_t.glaa013
   DEFINE l_glaa024     LIKE glaa_t.glaa024
   DEFINE l_year        LIKE type_t.num5
   DEFINE l_month       LIKE type_t.num5
   DEFINE l_bdate       LIKE glap_t.glapdocdt
   DEFINE l_edate       LIKE glap_t.glapdocdt
   DEFINE l_glaa003     LIKE glaa_t.glaa003
   DEFINE l_glaacomp    LIKE glaa_t.glaacomp
   
   CALL cl_set_act_visible("selall,selnone,unsel,filter",FALSE)

   CLEAR FORM
   INITIALIZE g_master.* TO NULL
   INITIALIZE g_master_t.*  TO NULL   
   CALL g_detail_d.clear()   

   IF NOT cl_null(g_glaald) THEN 
      SELECT glaacomp,glaa003 INTO l_glaacomp,l_glaa003
        FROM glaa_t
       WHERE glaaent = g_enterprise
         AND glaald = g_glaald
      CALL cl_get_para(g_enterprise,l_glaacomp,'S-FIN-9018') RETURNING l_year
      CALL cl_get_para(g_enterprise,l_glaacomp,'S-FIN-9019') RETURNING l_month
      CALL s_fin_date_get_period_range(l_glaa003,l_year,l_month) RETURNING l_bdate,l_edate
      LET g_master.glapdocdt = l_edate
   ELSE
      LET g_master.glapdocdt = g_today
   END IF 
   
   #帳套
   IF cl_null(g_master.fabgld) THEN 
      LET g_master.fabgld=g_glaald
   END IF
   CALL afap280_set_ld_info(g_master.fabgld)
   CALL afap280_fabgld_desc(g_master.fabgld)
   #單據性質
   IF cl_null(g_master.fabg005) THEN                         
      LET g_master.fabg005='0'
      DISPLAY BY NAME g_master.fabg005
   END IF
    
   IF NOT cl_null(g_fabgdocno_p) THEN 
      DISPLAY g_fabgdocno_p TO fabgdocno
   END IF
   SELECT glaa024 INTO l_glaa024 FROM glaa_t WHERE glaaent = g_enterprise AND glaald = g_master.fabgld   
   SELECT glaa013 INTO l_glaa013 FROM glaa_t WHERE glaaent=g_enterprise AND glaald=g_master.fabgld   
    
   
   IF g_master.fabg005 <> '4' THEN
      IF g_master.fabg005 = '30' THEN  
         CALL cl_set_comp_visible("b_fabh004,b_fabh010,b_fabh017,b_fabh019",FALSE)
         CALL cl_set_comp_visible("b_fabh008,b_fabh012",TRUE)
         CALL cl_set_comp_visible("b_fabg015,b_fabo012,b_fabo013,b_fabo014,b_fabo015,b_fabo016,b_fabo017",FALSE)
      ELSE
         CALL cl_set_comp_visible("b_fabh004,b_fabh008,b_fabh010,b_fabh012,b_fabh017,b_fabh019",TRUE)
         CALL cl_set_comp_visible("b_fabg015,b_fabo012,b_fabo013,b_fabo014,b_fabo015,b_fabo016,b_fabo017",FALSE)
      END IF 
   ELSE
      CALL cl_set_comp_visible("b_fabh004,b_fabh008,b_fabh010,b_fabh012,b_fabh017,b_fabh019",FALSE)
      CALL cl_set_comp_visible("b_fabg015,b_fabo012,b_fabo013,b_fabo014,b_fabo015,b_fabo016,b_fabo017",TRUE)
   END IF  
   #匯總方式
   IF cl_null(g_master.type) THEN
      LET g_master.type='1'
      DISPLAY BY NAME g_master.type
   END IF
   
   LET g_master_t.* = g_master.*
   LET g_master_t.glapdocno = ' '
   DISPLAY BY NAME g_master.fabgld,g_master.fabgld_desc,g_master.fabgcomp,g_master.fabgcomp_desc,g_master.fabg005,g_master.glapdocdt
   
   LET g_site_str = NULL 
END FUNCTION

#end add-point
 
{</section>}
 
