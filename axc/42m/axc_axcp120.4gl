#該程式未解開Section, 採用最新樣板產出!
{<section id="axcp120.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0027(2016-07-21 11:00:54), PR版次:0027(2017-04-12 14:44:06)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000272
#+ Filename...: axcp120
#+ Description: 成本階計算作業
#+ Creator....: 02291(2014-03-20 13:43:47)
#+ Modifier...: 02294 -SD/PR- 02111
 
{</section>}
 
{<section id="axcp120.global" >}
#應用 p01 樣板自動產生(Version:19)
#add-point:填寫註解說明 name="global.memo" name="global.memo"
#Memos
#160712-00005#6   2016/07/21 By lixiang  以aps计算结果发料低阶码
#160727-00019#20  2016/08/04 By 08742    系统中定义的临时表名称超过15码在执行时会出错,将系统中定义的临时表长度超过15码的改掉
#                                        Mod  axcp120_xcbb_tmp   --> axcp120_tmp01 , axcp120_xcbb_tmp1 --> axcp120_tmp02
#                                        Mod  axcp120_ins_xcbb_t --> axcp120_tmp03 , axcp120_sfaa_tmp  --> axcp120_tmp04 
#                                        Mod  axcp120_imaa_tmp   --> axcp120_tmp05 , axcp120_imaa_tmp1 --> axcp120_tmp06
#                                        Mod  axcp120_imaa_tmp2  --> axcp120_tmp07
#160812-00001#1   2016/08/25 By Sarah    成本階計算材料階一般為99,當材料件有開重工工單做為生產料號時,成本階會調到98,原判斷誤將回收料與拆件子件
#                                        也納入為生產料號,改為只判斷生產料號為1.一般、2.聯產品、3.多產生出件的才視為生產料號
#161013-00051#1   2016/10/18 By shiun    整批調整據點組織開窗
#161215-00036#1   2017/01/05 By 06948    增加背景執行功能
#170208-00012#1   2017/02/09 By zhujing  使用bom低阶码，参数启用成本特性的时候，最后写xcbb的来源tmp01和tmp02反掉了
#170213-00017#1   2017/02/13 By wujiea   改為不使用成本特性的邏輯    
#170118-00060#2   2017/02/15 By 02040    增加xcbb011存貨類別值的給予
#170217-00025#7   2017/03/10 By zhujing  整批调整未产生数据时，提示消息修正。
#170410-00021#1   2017/04/12  By 02111   inaj_t 的勾稽改用 LEFT OUTER JOIN，避免漏算料號。
#end add-point
#add-point:填寫註解說明(客製用) name="global.memo_customerization"

#end add-point
 
IMPORT os
IMPORT util
IMPORT FGL lib_cl_schedule
#add-point:增加匯入項目 name="global.import"

#end add-point
 
SCHEMA ds
 
GLOBALS "../../cfg/top_global.inc"
GLOBALS "../../cfg/top_schedule.inc"
GLOBALS
   DEFINE gwin_curr2  ui.Window
   DEFINE gfrm_curr2  ui.Form
   DEFINE gi_hiden_asign       LIKE type_t.num5
   DEFINE gi_hiden_exec        LIKE type_t.num5
   DEFINE gi_hiden_spec        LIKE type_t.num5
   DEFINE gi_hiden_exec_end    LIKE type_t.num5
   DEFINE g_chk_jobid          LIKE type_t.num5
END GLOBALS
 
PRIVATE TYPE type_parameter RECORD
   #add-point:自定背景執行須傳遞的參數(Module Variable) name="global.parameter"
   #161215-00036#1 add (S)
   imagsite LIKE type_t.chr10, 
   year LIKE type_t.chr500, 
   month LIKE type_t.chr500, 
   order LIKE type_t.chr500, 
   level LIKE type_t.num5,
   check LIKE type_t.chr500,
   #161215-00036#1 add (E)
   #end add-point
        wc               STRING
                     END RECORD
 
DEFINE g_sql             STRING        #組 sql 用
DEFINE g_forupd_sql      STRING        #SELECT ... FOR UPDATE  SQL
DEFINE g_error_show      LIKE type_t.num5
DEFINE g_jobid           STRING
DEFINE g_wc              STRING
 
PRIVATE TYPE type_master RECORD
       imagsite LIKE type_t.chr10, 
   imagsite_desc LIKE type_t.chr80, 
   year LIKE type_t.chr500, 
   month LIKE type_t.chr500, 
   order LIKE type_t.chr500, 
   level LIKE type_t.num5, 
   check LIKE type_t.chr500, 
   stagenow LIKE type_t.chr80,
       wc               STRING
       END RECORD
 
#模組變數(Module Variables)
DEFINE g_master type_master
 
#add-point:自定義模組變數(Module Variable) name="global.variable"
#單頭 type 宣告
DEFINE g_glaa003    LIKE glaa_t.glaa003
DEFINE g_tmp        RECORD     
   xcbbent      LIKE xcbb_t.xcbbent,
   imagsite     LIKE imag_t.imagsite,   #法人組織
   xcbb001      LIKE xcbb_t.xcbb001,
   xcbb002      LIKE xcbb_t.xcbb002,
   imag001      LIKE imag_t.imag001,   #料件編號
   xcbb004      LIKE xcbb_t.xcbb004,   #特性
   imaa006      LIKE imaa_t.imaa006,   #單位
   imag013      LIKE imag_t.imag013,   #成本料號
   xcbb006      LIKE xcbb_t.xcbb006,   #成本階
   xcbb007      LIKE xcbb_t.xcbb007,   #按發料計算的低階碼
   xcbb008      LIKE xcbb_t.xcbb008,   #按BOM計算的低階碼
   xcbb009      LIKE xcbb_t.xcbb009,   #當月入聯產品否
   imag011      LIKE imag_t.imag011,   #成本分群碼
   imaa003      LIKE imaa_t.imaa003,   #主分群碼
   imaa004     LIKE imaa_t.imaa004     #料件类别
   END RECORD
DEFINE l_bdate          LIKE glav_t.glav004 #起始年度+期別對應的起始截止日期
DEFINE l_edate          LIKE glav_t.glav004
DEFINE g_success        LIKE type_t.chr1
DEFINE g_ref_fields     DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
DEFINE g_ref_vars       DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
DEFINE g_rtn_fields     DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
DEFINE g_flag           LIKE type_t.num5  #170217-00025#7 add
#end add-point
 
#add-point:自定義客戶專用模組變數(Module Variable) name="global.variable_customerization"

#end add-point
 
#add-point:傳入參數說明 name="global.argv"

#end add-point
 
{</section>}
 
{<section id="axcp120.main" >}
MAIN
   #add-point:main段define (客製用) name="main.define_customerization"
   
   #end add-point 
   DEFINE ls_js    STRING
   DEFINE lc_param type_parameter  
   #add-point:main段define name="main.define"
   
   #end add-point 
  
   #設定SQL錯誤記錄方式 (模組內定義有效)
   WHENEVER ERROR CALL cl_err_msg_log
 
   #add-point:初始化前定義 name="main.before_ap_init"
   
   #end add-point
   #依模組進行系統初始化設定(系統設定)
   CALL cl_ap_init("axc","")
 
   #add-point:定義背景狀態與整理進入需用參數ls_js name="main.background"
   
   #end add-point
 
   #背景(Y) 或半背景(T) 時不做主畫面開窗
   IF g_bgjob = "Y" OR g_bgjob = "T" THEN
      #排程參數由01開始，若不是1開始，表示有保留參數
      LET ls_js = g_argv[01]
     #CALL util.JSON.parse(ls_js,g_master)   #p類主要使用l_param,此處不解析
      #add-point:Service Call name="main.servicecall"
      
      #end add-point
      CALL axcp120_process(ls_js)
   ELSE
      #畫面開啟 (identifier)
      OPEN WINDOW w_axcp120 WITH FORM cl_ap_formpath("axc",g_code)
 
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
 
      #程式初始化
      CALL axcp120_init()
 
      #進入選單 Menu (="N")
      CALL axcp120_ui_dialog()
 
      #add-point:畫面關閉前 name="main.before_close"
      
      #end add-point
      #畫面關閉
      CLOSE WINDOW w_axcp120
   END IF
 
   #add-point:作業離開前 name="main.exit"
   
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
END MAIN
 
{</section>}
 
{<section id="axcp120.init" >}
#+ 初始化作業
PRIVATE FUNCTION axcp120_init()
 
   #add-point:init段define (客製用) name="init.define_customerization"
   
   #end add-point
   #add-point:ui_dialog段define name="init.define"
   
   #end add-point
 
   LET g_error_show = 1
   LET gwin_curr2 = ui.Window.getCurrent()
   LET gfrm_curr2 = gwin_curr2.getForm()
   CALL cl_schedule_import_4fd()
   CALL cl_set_combo_scc("gzpa003","75")
   IF cl_get_para(g_enterprise,"","E-SYS-0005") = "N" THEN
       CALL cl_set_comp_visible("scheduling_page,history_page",FALSE)
   END IF 
   #add-point:畫面資料初始化 name="init.init"
#170213-00017#1 mod ---start
##wujie 150731 --begin   #只有启用成本特性才可见选项3：发料+特性
#   IF cl_get_para(g_enterprise,g_site,'S-FIN-6013') = 'Y' THEN
#      CALL cl_set_combo_scc_part("order","8913","0,1,2")
#   ELSE
#      CALL cl_set_combo_scc_part("order","8913","0,1")
#   END IF
##wujie 150731 --end
   CALL cl_set_combo_scc_part("order","8913","0,1")
#170213-00017#1 mod ---end    
   #end add-point
   
END FUNCTION
 
{</section>}
 
{<section id="axcp120.ui_dialog" >}
#+ 選單功能實際執行處
PRIVATE FUNCTION axcp120_ui_dialog()
 
   #add-point:ui_dialog段define (客製用) name="ui_dialog.define_customerization"
   
   #end add-point
   DEFINE li_exit  LIKE type_t.num5    #判別是否為離開作業
   DEFINE li_idx   LIKE type_t.num10
   DEFINE ls_js    STRING
   DEFINE ls_wc    STRING
   DEFINE l_dialog ui.DIALOG
   DEFINE lc_param type_parameter
   #add-point:ui_dialog段define name="ui_dialog.define"
 
   #end add-point
   
   #add-point:ui_dialog段before dialog name="ui_dialog.before_dialog"
   
   #end add-point
 
   WHILE TRUE
      #add-point:ui_dialog段before dialog2 name="ui_dialog.before_dialog2"
      
      #end add-point
 
      DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
         #應用 a57 樣板自動產生(Version:3)
         INPUT BY NAME g_master.imagsite,g_master.year,g_master.month,g_master.order,g_master.level, 
             g_master.check 
            ATTRIBUTE(WITHOUT DEFAULTS)
            
            #自訂ACTION(master_input)
            
         
            BEFORE INPUT
               #add-point:資料輸入前 name="input.m.before_input"
               LET g_master.check = 'N'
               LET g_master.order = '0'
               LET g_master.level = 20
               CALL axcp120_head_default() #dorislai-21051023-add 
               #end add-point
         
                     #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imagsite
            
            #add-point:AFTER FIELD imagsite name="input.a.imagsite"
            IF NOT cl_null(g_master.imagsite) THEN 
#此段落由子樣板a19產生
               #校驗代值
               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
               INITIALIZE g_chkparam.* TO NULL
               
               #設定g_chkparam.*的參數
               LET g_chkparam.arg1 = g_master.imagsite
                  
               #呼叫檢查存在並帶值的library
               IF cl_chk_exist("v_ooef001_1") THEN
                  #檢查成功時後續處理
                  #LET  = g_chkparam.return1
                  #DISPLAY BY NAME 
                  IF g_master.year IS NULL OR g_master.month IS NULL THEN
                     SELECT glaa010,glaa011 INTO g_master.year,g_master.month
                       FROM glaa_t
                      WHERE glaaent  = g_enterprise
                        AND glaacomp = g_master.imagsite
                        AND glaa014  = 'Y'
                  END IF
               ELSE
                  #檢查失敗時後續處理
                  NEXT FIELD CURRENT
               END IF
#抓出会计周期参考表号  glaa003
               SELECT glaa003 INTO g_glaa003
                 FROM glaa_t
                WHERE glaaent  = g_enterprise
                  AND glaacomp = g_master.imagsite
                  AND glaa014  = 'Y'             
#170213-00017#1 mod ---start
##wujie 150731 --begin   #只有启用成本特性才可见选项3：发料+特性
#               IF cl_get_para(g_enterprise,g_master.imagsite,'S-FIN-6013') = 'Y' THEN
#                  CALL cl_set_combo_scc_part("order","8913","0,1,2")
#               ELSE
#                  CALL cl_set_combo_scc_part("order","8913","0,1")
#               END IF
##wujie 150731 --end
               CALL cl_set_combo_scc_part("order","8913","0,1")
#170213-00017#1 mod ---end
            END IF 
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_master.imagsite
            CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_master.imagsite_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_master.imagsite_desc
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imagsite
            #add-point:BEFORE FIELD imagsite name="input.b.imagsite"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE imagsite
            #add-point:ON CHANGE imagsite name="input.g.imagsite"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD year
            #add-point:BEFORE FIELD year name="input.b.year"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD year
            
            #add-point:AFTER FIELD year name="input.a.year"
            IF NOT cl_null(g_master.year) THEN
               IF NOT axcp120_chk_year_month() THEN
                  LET g_master.year = NULL
                  NEXT FIELD CURRENT
               END IF
            END IF 
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE year
            #add-point:ON CHANGE year name="input.g.year"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD month
            #add-point:BEFORE FIELD month name="input.b.month"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD month
            
            #add-point:AFTER FIELD month name="input.a.month"
            IF NOT cl_null(g_master.month) THEN
               IF NOT axcp120_chk_year_month() THEN
                  LET g_master.month = NULL
                  NEXT FIELD CURRENT
               END IF
            END IF
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE month
            #add-point:ON CHANGE month name="input.g.month"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD order
            #add-point:BEFORE FIELD order name="input.b.order"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD order
            
            #add-point:AFTER FIELD order name="input.a.order"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE order
            #add-point:ON CHANGE order name="input.g.order"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD level
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_master.level,"0","1","99","1","azz-00087",1) THEN
               NEXT FIELD level
            END IF 
 
 
 
            #add-point:AFTER FIELD level name="input.a.level"
            IF NOT cl_null(g_master.level) THEN 
            END IF 


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD level
            #add-point:BEFORE FIELD level name="input.b.level"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE level
            #add-point:ON CHANGE level name="input.g.level"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD check
            #add-point:BEFORE FIELD check name="input.b.check"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD check
            
            #add-point:AFTER FIELD check name="input.a.check"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE check
            #add-point:ON CHANGE check name="input.g.check"
            
            #END add-point 
 
 
 
                     #Ctrlp:input.c.imagsite
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imagsite
            #add-point:ON ACTION controlp INFIELD imagsite name="input.c.imagsite"
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_master.imagsite             #給予default值
            LET g_qryparam.where = " ooef003 = 'Y'"

            #給予arg
            #mod--161013-00051#1 By shiun--(S)
#            CALL q_ooef001()
            CALL q_ooef001_1()
            #mod--161013-00051#1 By shiun--(E)

            LET g_master.imagsite = g_qryparam.return1              #將開窗取得的值回傳到變數


            DISPLAY g_master.imagsite TO imagsite              #顯示到畫面上

            NEXT FIELD imagsite                          #返回原欄位
            #END add-point
 
 
         #Ctrlp:input.c.year
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD year
            #add-point:ON ACTION controlp INFIELD year name="input.c.year"
            
            #END add-point
 
 
         #Ctrlp:input.c.month
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD month
            #add-point:ON ACTION controlp INFIELD month name="input.c.month"
            
            #END add-point
 
 
         #Ctrlp:input.c.order
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD order
            #add-point:ON ACTION controlp INFIELD order name="input.c.order"
            
            #END add-point
 
 
         #Ctrlp:input.c.level
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD level
            #add-point:ON ACTION controlp INFIELD level name="input.c.level"
            
            #END add-point
 
 
         #Ctrlp:input.c.check
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD check
            #add-point:ON ACTION controlp INFIELD check name="input.c.check"
            
            #END add-point
 
 
 
               
            AFTER INPUT
               #add-point:資料輸入後 name="input.m.after_input"
               
               #end add-point
               
            #add-point:其他管控(on row change, etc...) name="input.other"
            
            #end add-point
         END INPUT
 
 
 
         
         #應用 a58 樣板自動產生(Version:3)
         CONSTRUCT BY NAME g_master.wc ON imagsite,year,month,order,check
            BEFORE CONSTRUCT
               #add-point:cs段before_construct name="cs.head.before_construct"
               
               #end add-point 
         
            #公用欄位開窗相關處理
            
               
            #一般欄位開窗相關處理    
                     #Ctrlp:construct.c.imagsite
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imagsite
            #add-point:ON ACTION controlp INFIELD imagsite name="construct.c.imagsite"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            #mod--161013-00051#1 By shiun--(S)
#            CALL q_ooef001()                           #呼叫開窗
            CALL q_ooef001_1()
            #mod--161013-00051#1 By shiun--(E)
            DISPLAY g_qryparam.return1 TO imagsite  #顯示到畫面上
            NEXT FIELD imagsite                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imagsite
            #add-point:BEFORE FIELD imagsite name="construct.b.imagsite"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imagsite
            
            #add-point:AFTER FIELD imagsite name="construct.a.imagsite"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD year
            #add-point:BEFORE FIELD year name="construct.b.year"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD year
            
            #add-point:AFTER FIELD year name="construct.a.year"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.year
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD year
            #add-point:ON ACTION controlp INFIELD year name="construct.c.year"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD month
            #add-point:BEFORE FIELD month name="construct.b.month"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD month
            
            #add-point:AFTER FIELD month name="construct.a.month"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.month
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD month
            #add-point:ON ACTION controlp INFIELD month name="construct.c.month"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD order
            #add-point:BEFORE FIELD order name="construct.b.order"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD order
            
            #add-point:AFTER FIELD order name="construct.a.order"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.order
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD order
            #add-point:ON ACTION controlp INFIELD order name="construct.c.order"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD check
            #add-point:BEFORE FIELD check name="construct.b.check"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD check
            
            #add-point:AFTER FIELD check name="construct.a.check"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.check
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD check
            #add-point:ON ACTION controlp INFIELD check name="construct.c.check"
            
            #END add-point
 
 
 
            
            #add-point:其他管控 name="cs.other"
            
            #end add-point
            
         END CONSTRUCT
 
 
 
      
         #add-point:ui_dialog段construct name="ui_dialog.more_construct"
         
         #end add-point
         #add-point:ui_dialog段input name="ui_dialog.more_input"
 
         #end add-point
         #add-point:ui_dialog段自定義display array name="ui_dialog.more_displayarray"
         
         #end add-point
 
         SUBDIALOG lib_cl_schedule.cl_schedule_setting
         SUBDIALOG lib_cl_schedule.cl_schedule_setting_exec_call
         SUBDIALOG lib_cl_schedule.cl_schedule_select_show_history
         SUBDIALOG lib_cl_schedule.cl_schedule_show_history
 
         BEFORE DIALOG
            LET l_dialog = ui.DIALOG.getCurrent()
            CALL axcp120_get_buffer(l_dialog)
            #add-point:ui_dialog段before dialog name="ui_dialog.before_dialog3"
            
            #end add-point
 
         ON ACTION batch_execute
            LET g_action_choice = "batch_execute"
            ACCEPT DIALOG
 
         #add-point:ui_dialog段before_qbeclear name="ui_dialog.before_qbeclear"
         
         #end add-point
 
         ON ACTION qbeclear         
            CLEAR FORM
            INITIALIZE g_master.* TO NULL   #畫面變數清空
            INITIALIZE lc_param.* TO NULL   #傳遞參數變數清空
            #add-point:ui_dialog段qbeclear name="ui_dialog.qbeclear"
            
            #end add-point
 
         ON ACTION history_fill
            CALL cl_schedule_history_fill()
 
         ON ACTION close
            LET INT_FLAG = TRUE
            EXIT DIALOG
         
         ON ACTION exit
            LET INT_FLAG = TRUE
            EXIT DIALOG
 
         #add-point:ui_dialog段action name="ui_dialog.more_action"
         
         #end add-point
 
         #主選單用ACTION
         &include "main_menu_exit_dialog.4gl"
         &include "relating_action.4gl"
         #交談指令共用ACTION
         &include "common_action.4gl"
            CONTINUE DIALOG
      END DIALOG
 
      IF g_action_choice = "logistics" THEN
         #清除畫面及相關資料
         CLEAR FORM   
         INITIALIZE g_master.* TO NULL
         LET g_wc  = ' 1=2'
         LET g_action_choice = ""
         CALL axcp120_init()
         CONTINUE WHILE
      END IF
 
      #檢查批次設定是否有錯(或未設定完成)
      IF NOT cl_schedule_exec_check() THEN
         CONTINUE WHILE
      END IF
      
      LET lc_param.wc = g_master.wc    #把畫面上的wc傳遞到參數變數
      #請在下方的add-point內進行把畫面的輸入資料(g_master)轉換到傳遞參數變數(lc_param)的動作
      #add-point:ui_dialog段exit dialog name="process.exit_dialog"
      #161215-00036#1 add (S)
      LET lc_param.imagsite = g_master.imagsite 
      LET lc_param.year = g_master.year
      LET lc_param.month = g_master.month
      LET lc_param.order = g_master.order
      LET lc_param.level = g_master.level
      LET lc_param.check = g_master.check
      IF cl_null(lc_param.wc) THEN
         LET lc_param.wc = " 1=1"
         LET g_master.wc = " 1=1"
      END IF
      #161215-00036#1 add (E)
      #end add-point
 
      LET ls_js = util.JSON.stringify(lc_param)  #r類使用g_master/p類使用lc_param
 
      IF INT_FLAG THEN
         LET INT_FLAG = FALSE
         EXIT WHILE
      ELSE
         IF g_chk_jobid THEN 
            LET g_jobid = g_schedule.gzpa001
         ELSE 
            LET g_jobid = cl_schedule_get_jobid(g_prog)
         END IF 
 
         #依照指定模式執行報表列印
         CASE 
            WHEN g_schedule.gzpa003 = "0"
                 CALL axcp120_process(ls_js)
 
            WHEN g_schedule.gzpa003 = "1"
                 LET ls_js = axcp120_transfer_argv(ls_js)
                 CALL cl_cmdrun(ls_js)
 
            WHEN g_schedule.gzpa003 = "2"
                 CALL cl_schedule_update_data(g_jobid,ls_js)
 
            WHEN g_schedule.gzpa003 = "3"
                 CALL cl_schedule_update_data(g_jobid,ls_js)
         END CASE  
 
         IF g_schedule.gzpa003 = "2" OR g_schedule.gzpa003 = "3" THEN 
            CALL cl_ask_confirm3("std-00014","") #設定完成
         END IF    
         LET g_schedule.gzpa003 = "0" #預設一開始 立即於前景執行
 
         #add-point:ui_dialog段after schedule name="process.after_schedule"
         
         #end add-point
 
         #欄位初始資訊 
         CALL cl_schedule_init_info("all",g_schedule.gzpa003) 
         LET gi_hiden_asign = FALSE 
         LET gi_hiden_exec = FALSE 
         LET gi_hiden_spec = FALSE 
         LET gi_hiden_exec_end = FALSE 
         CALL cl_schedule_hidden()
      END IF
   END WHILE
 
END FUNCTION
 
{</section>}
 
{<section id="axcp120.transfer_argv" >}
#+ 轉換本地參數至cmdrun參數內,準備進入背景執行
PRIVATE FUNCTION axcp120_transfer_argv(ls_js)
 
   #add-point:transfer_agrv段define (客製用) name="transfer_agrv.define_customerization"
   
   #end add-point
   DEFINE ls_js       STRING
   DEFINE la_cmdrun   RECORD
             prog       STRING,
             actionid   STRING,
             background LIKE type_t.chr1,
             param      DYNAMIC ARRAY OF STRING
                  END RECORD
   DEFINE la_param    type_parameter
   #add-point:transfer_agrv段define name="transfer_agrv.define"
   
   #end add-point
 
   LET la_cmdrun.prog = g_prog
   LET la_cmdrun.background = "Y"
   LET la_cmdrun.param[1] = ls_js
 
   #add-point:transfer.argv段程式內容 name="transfer.argv.define"
   
   #end add-point
 
   RETURN util.JSON.stringify( la_cmdrun )
END FUNCTION
 
{</section>}
 
{<section id="axcp120.process" >}
#+ 資料處理   (r類使用g_master為主處理/p類使用l_param為主)
PRIVATE FUNCTION axcp120_process(ls_js)
 
   #add-point:process段define (客製用) name="process.define_customerization"
   
   #end add-point
   DEFINE ls_js         STRING
   DEFINE lc_param      type_parameter
   DEFINE li_stus       LIKE type_t.num5
   DEFINE li_count      LIKE type_t.num10  #progressbar計量
   DEFINE ls_sql        STRING             #主SQL
   DEFINE li_p01_status LIKE type_t.num5
   #add-point:process段define name="process.define"
   
   #end add-point
 
  #INITIALIZE lc_param TO NULL           #p類不可以清空
   CALL util.JSON.parse(ls_js,lc_param)  #r類作業被t類呼叫時使用, p類主要解開參數處
   LET li_p01_status = 1
 
  #IF lc_param.wc IS NOT NULL THEN
  #   LET g_bgjob = "T"       #特殊情況,此為t類作業鬆耦合串入報表主程式使用
  #END IF
 
   #add-point:process段前處理 name="process.pre_process"
   CALL axcp120_create_tmp()
   CALL cl_err_showmsg_init()
   #end add-point
 
   #預先計算progressbar迴圈次數
   IF g_bgjob <> "Y" THEN
      #add-point:process段count_progress name="process.count_progress"
      CALL cl_progress_bar_no_window(3)
      #end add-point
   END IF
 
   #主SQL及相關FOREACH前置處理
#  DECLARE axcp120_process_cs CURSOR FROM ls_sql
#  FOREACH axcp120_process_cs INTO
   #add-point:process段process name="process.process"
   
   #end add-point
#  END FOREACH
 
   IF g_bgjob = "N" THEN
      #前景作業完成處理
      #add-point:process段foreground完成處理 name="process.foreground_finish"
      CALL axcp120_get_xcbb_tmp()
      IF g_success = 'Y' THEN
         CALL s_transaction_end('Y','1')
      ELSE
         CALL s_transaction_end('N','1')
      END IF
      CALL cl_err_collect_show()    #wujie 150802
      CALL axcp120_drop_tmp_table()
      #170217-00025#7 add-S
      IF g_flag = FALSE THEN
         CALL s_transaction_end('N','0')
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.code = 'sub-00491'   #無資料產生
         LET g_errparam.extend = ''
         LET g_errparam.popup = TRUE 
         CALL cl_err()
         RETURN            
      END IF
      #170217-00025#7 add-E
      #end add-point
      CALL cl_ask_confirm3("std-00012","")
   ELSE
      #背景作業完成處理
      #add-point:process段background完成處理 name="process.background_finish"
      #161215-00036#1 add (S)
      LET g_master.year = lc_param.year
      LET g_master.month = lc_param.month
      LET g_master.imagsite = lc_param.imagsite
      LET g_master.order = lc_param.order
      LET g_master.check = lc_param.check
      SELECT glaa003 INTO g_glaa003
        FROM glaa_t
       WHERE glaaent  = g_enterprise
         AND glaacomp = g_master.imagsite
         AND glaa014  = 'Y'
      #161215-00036#1 add (E)
      CALL axcp120_get_xcbb_tmp()
      IF g_success = 'Y' THEN
         CALL s_transaction_end('Y','0')
      ELSE
         CALL s_transaction_end('N','0')
      END IF
      CALL axcp120_drop_tmp_table()
      #end add-point
      CALL cl_schedule_exec_call(li_p01_status)
   END IF
 
   #呼叫訊息中心傳遞本關完成訊息
   CALL axcp120_msgcentre_notify()
 
END FUNCTION
 
{</section>}
 
{<section id="axcp120.get_buffer" >}
PRIVATE FUNCTION axcp120_get_buffer(p_dialog)
 
   #add-point:process段define (客製用) name="get_buffer.define_customerization"
   
   #end add-point
   DEFINE p_dialog   ui.DIALOG
   #add-point:process段define name="get_buffer.define"
   
   #end add-point
 
   
   LET g_master.imagsite = p_dialog.getFieldBuffer('imagsite')
   LET g_master.year = p_dialog.getFieldBuffer('year')
   LET g_master.month = p_dialog.getFieldBuffer('month')
   LET g_master.order = p_dialog.getFieldBuffer('order')
   LET g_master.level = p_dialog.getFieldBuffer('level')
   LET g_master.check = p_dialog.getFieldBuffer('check')
 
   CALL cl_schedule_get_buffer(p_dialog)
 
   #add-point:get_buffer段其他欄位處理 name="get_buffer.others"
   
   #end add-point
END FUNCTION
 
{</section>}
 
{<section id="axcp120.msgcentre_notify" >}
PRIVATE FUNCTION axcp120_msgcentre_notify()
 
   #add-point:process段define (客製用) name="msgcentre_notify.define_customerization"
   
   #end add-point
   DEFINE lc_state LIKE type_t.chr5
   #add-point:process段define name="msgcentre_notify.define"
   
   #end add-point
 
   INITIALIZE g_msgparam TO NULL
 
   #action-id與狀態填寫
   LET g_msgparam.state = "process"
 
   #add-point:msgcentre其他通知 name="msg_centre.process"
   
   #end add-point
 
   #呼叫訊息中心傳遞本關完成訊息
   CALL cl_msgcentre_notify()
 
END FUNCTION
 
{</section>}
 
{<section id="axcp120.other_function" readonly="Y" >}
#add-point:自定義元件(Function) name="other.function"
################################################################################
# Descriptions...: 插入臨時表資料
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
PRIVATE FUNCTION axcp120_get_xcbb_tmp()
   DEFINE p_wc              STRING
   DEFINE l_sql             STRING
   DEFINE p_apcbdocno       LIKE apcb_t.apcbdocno
   DEFINE l_apcb002         LIKE apcb_t.apcb002
   DEFINE l_apcb003         LIKE apcb_t.apcb003
   DEFINE l_flag1           LIKE type_t.chr1
   DEFINE l_errno           LIKE type_t.chr100
   DEFINE l_glav002         LIKE glav_t.glav002
   DEFINE l_glav005         LIKE glav_t.glav005
   DEFINE l_sdate_s         LIKE glav_t.glav004
   DEFINE l_sdate_e         LIKE glav_t.glav004
   DEFINE l_glav006         LIKE glav_t.glav006
   DEFINE l_glav007         LIKE glav_t.glav007
   DEFINE l_wdate_s         LIKE glav_t.glav004
   DEFINE l_wdate_e         LIKE glav_t.glav004
   DEFINE l_year            LIKE type_t.num5
   DEFINE l_month           LIKE type_t.num5
   DEFINE l_sfdd001         LIKE sfdd_t.sfdd001
   DEFINE l_bmba002         LIKE bmba_t.bmba002
   DEFINE l_imag001         LIKE imag_t.imag001
   DEFINE l_xcbbcnfdt       DATETIME YEAR TO SECOND
   DEFINE l_xcbb006         LIKE xcbb_t.xcbb006
   DEFINE l_success         LIKE type_t.num5
   DEFINE l_today           LIKE xcbb_t.xcbbcrtdt
   DEFINE l_xcbb004         STRING    #wujie 150801
   
   CALL s_transaction_begin()
   
   LET l_today = cl_get_current()
   CALL s_get_accdate(g_glaa003,'',g_master.year,g_master.month)
     RETURNING l_flag1,l_errno,l_glav002,l_glav005,l_sdate_s,l_sdate_e,
               l_glav006,l_bdate,l_edate,l_glav007,l_wdate_s,l_wdate_e
   IF l_flag1='N' THEN
       LET g_success='N'
       INITIALIZE g_errparam TO NULL
       LET g_errparam.code = l_errno
       LET g_errparam.extend = ''
       CALL cl_err()         
       RETURN
   END IF 

   CALL cl_err_collect_init() #汇总错误讯息初始化  #wujie 150802
#wujie 150731 --begin
#   DECLARE p120_ins_xcbb_tmp CURSOR FOR
#    INSERT INTO  axcp120_ins_xcbb_t(imag001,xcbb006) VALUES(?,?)
#wujie 150731 --end    
   LET l_sql = " UPDATE axcp120_tmp01 SET xcbb006 = ?",  #160727-00019#20 Mod  axcp120_xcbb_tmp--> axcp120_tmp01
               "  WHERE imag001 = ?  "  
   PREPARE p120_upd_p2 FROM l_sql


    CALL s_fin_date_get_last_period(g_glaa003,'',g_master.year,g_master.month)
         RETURNING l_success,l_year,l_month
 
   IF l_success='N' THEN
       LET g_success='N'
       INITIALIZE g_errparam TO NULL
       LET g_errparam.code = 'get last period failed'
       LET g_errparam.extend = ''
       CALL cl_err() 
      RETURN
   END IF

    DELETE FROM  xcbb_t WHERE xcbbent = g_enterprise AND xcbbcomp = g_master.imagsite 
      AND xcbb001 =  g_master.year AND xcbb002 = g_master.month
 
    CALL cl_progress_no_window_ing("delete xcbb_t")
    
    DELETE FROM axcp120_tmp01       #160727-00019#20 Mod  axcp120_xcbb_tmp--> axcp120_tmp01
    
    IF g_master.order = '0' THEN       #依BOM低階碼
       INSERT INTO axcp120_tmp01    #160727-00019#20 Mod  axcp120_xcbb_tmp--> axcp120_tmp01
          SELECT DISTINCT imagent,imagsite,0,0,imag001,' ',imaa006,imag013,imac003,0,imac003,'N',imag011,imaa003,imaa004   
           FROM imac_t,imaa_t,imag_t  
          WHERE imagent = imaaent AND imaaent = imacent
            AND imag001 = imaa001 AND imaa001 = imac001 
            AND imagsite = g_master.imagsite AND imagent = g_enterprise
            
       IF SQLCA.sqlcode THEN
         LET g_success='N'
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = 'INS axcp120_tmp01'    #160727-00019#20 Mod  axcp120_xcbb_tmp--> axcp120_tmp01
         CALL cl_err() 
         RETURN
       END IF
       
       UPDATE axcp120_tmp01 SET xcbb001 = g_master.year,xcbb002 = g_master.month      #160727-00019#20 Mod  axcp120_xcbb_tmp--> axcp120_tmp01
       
       IF SQLCA.sqlcode THEN
         LET g_success='N'
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = 'UPD axcp120_tmp01'       #160727-00019#20 Mod  axcp120_xcbb_tmp--> axcp120_tmp01
         CALL cl_err() 
         RETURN
       END IF
       
    END IF 
#wujie 150731 --begin #order选项1，2 
    IF g_master.order ='1' OR g_master.order ='2' THEN       #依發料低階碼or发料+特性 
       IF NOT axcp120_gen_imac() THEN   #依发料计算低阶码，放入类似imac的临时表中   #APS改好的话这个if可以去掉了
          LET g_success='N'
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = 'INS axcp120_tmp03'           #160727-00019#20 Mod  axcp120_ins_xcbb_t--> axcp120_tmp03
         CALL cl_err() 
          RETURN
       END IF 
       #160712-00005#6---s   
#把发料低阶码更新到每个料号
       #LET l_sql = "  INSERT INTO axcp120_xcbb_tmp",
       #            "  SELECT DISTINCT b.imagent,b.imagsite,",g_master.year,",",g_master.month,",a.imag001,a.xcbb004,imaa006,b.imag013,a.xcbb006,a.xcbb006,0,'N',b.imag011,imaa003,imaa004",
       #            "   FROM axcp120_ins_xcbb_t a,imaa_t,imag_t b",
       #            "  WHERE imagent = imaaent ",
       #            "    AND a.imag001 = b.imag001 ",
       #            #AND a.imagsite = b.imagsite",
       #            "    AND a.imag001 = imaa001 AND imaa001 = b.imag001",
       #            "    AND b.imagsite = '",g_master.imagsite,"' AND b.imagent = '",g_enterprise,"'"
       LET l_sql = "  INSERT INTO axcp120_tmp01",        #160727-00019#20 Mod  axcp120_xcbb_tmp--> axcp120_tmp01
                   "  SELECT DISTINCT imagent,imagsite,",g_master.year,",",g_master.month,",imaq001,' ',imaa006,imag013,imaq003,imaq003,0,'N',imag011,imaa003,imaa004",  #170213-00017#1 imaq002 --> ' '
                   "   FROM imaq_t ,imaa_t,imag_t ",
                   "  WHERE imagent = imaaent AND imaqent = imaaent ",
                   "    AND imaq001 = imag001 AND imaq001 = imaa001 ",
                   "    AND imagsite = '",g_master.imagsite,"' AND imagent = '",g_enterprise,"'"
       #160712-00005#6---e 
       PREPARE p120_ins_xcbb_tmp2 FROM l_sql
       EXECUTE p120_ins_xcbb_tmp2
        
       IF SQLCA.sqlcode THEN
          LET g_success='N'
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = 'INS axcp120_tmp01'      #160727-00019#20 Mod  axcp120_xcbb_tmp--> axcp120_tmp01
         CALL cl_err() 
          RETURN
       END IF 
       
#不在发料范围内的料件按BOM低阶码计算
#按bom取出料件
       LET l_sql = " INSERT INTO axcp120_tmp01 ",        #160727-00019#20 Mod  axcp120_xcbb_tmp--> axcp120_tmp01
                   " SELECT DISTINCT imagent,imagsite,",g_master.year,",",g_master.month,",imag001,' ' inaj006,imaa006,imag013,NVL(imac003,99),0,NVL(imac003,99),'N',imag011,imaa003,imaa004",   #160106-00003 imac003 -->NVL  #170213-00017#1 NVL(inaj006,' ') -> ' ' inaj006
                   #170410-00021#1 mark start -----
#                   "  FROM imaa_t  LEFT OUTER JOIN imac_t ON imaaent = imacent AND imaa001 = imac001,imag_t,inaj_t ",  #160106-00003  imac改为外联
#                   " WHERE imagent = imaaent", 
##                   "   AND imaaent = imacent",   #160106-00003 mark
#                   "   AND imag001 = imaa001", 
##                   "   AND imaa001 = imac001",   #160106-00003 mark  
#                   "   AND imagent = inajent ",
#                   "   AND imagsite = inaj209 ",
#                   "   AND imag001 = inaj005 ",
                   #170410-00021#1 mark end   -----
                   #170410-00021#1 add start -----
                   "  FROM imag_t  ",
                   "  LEFT OUTER JOIN imaa_t ON imaaent = imagent AND imaa001 = imag001 ",
                   "  LEFT OUTER JOIN imac_t ON imagent = imacent AND imag001 = imac001 ",     
                   "  LEFT OUTER JOIN inaj_t ON inajent = imagent AND inaj005 = imag001 AND inaj209 = imagsite ",                   
                   #170410-00021#1 add end   -----                   
                   "   AND inaj006 IS NOT NULL",   #加这个是为了排除inaj里特性为null的错误资料
                   #"   AND imagsite = '",g_master.imagsite,"'", #170410-00021#1 mark
                   " WHERE imagsite = '",g_master.imagsite,"'", #170410-00021#1 add
                   "   AND imagent = ",g_enterprise,
#170213-00017#1 --begin
                   #"   AND NOT EXISTS (SELECT 1 FROM axcp120_tmp01 T1 WHERE T1.imag001 = inaj005 )" #170410-00021#1 mark
                   "   AND imag001 NOT IN (SELECT T1.imag001 FROM axcp120_tmp01 T1 )"   #170410-00021#1 add                   
#                  "   AND NOT EXISTS (SELECT 1 FROM axcp120_tmp01 T1 WHERE T1.xcbbent = inajent AND T1.imagsite = inajsite AND T1.imag001 = inaj005 AND T1.xcbb004 = inaj006 )"   #wujie 161031
#170213-00017#1 --end 
       PREPARE p120_ins_xcbb_tmp6 FROM l_sql
       EXECUTE p120_ins_xcbb_tmp6
       
       IF SQLCA.sqlcode THEN
         LET g_success='N'
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = 'INS axcp120_tmp02'     #160727-00019#20 Mod  axcp120_xcbb_tmp1--> axcp120_tmp02
         CALL cl_err() 
         RETURN
       END IF

#170213-00017#1 mark ---start
##160106-00003 --begin   
##自制件更新成本阶为0 
#       LET l_sql =" MERGE INTO axcp120_tmp02 T1 ",      #160727-00019#20 Mod  axcp120_xcbb_tmp1--> axcp120_tmp02  
#                  " USING imaf_t T2",   
#                  "    ON (T1.xcbbent = T2.imafent AND T1.imagsite = T2.imafsite AND T1.imag001 = T2.imaf001 )",
#                  " WHEN MATCHED THEN UPDATE SET T1.xcbb006 =0,T1.xcbb007=0 WHERE T2.imaf013 ='2'"   #自制件更新为0    
#
#       PREPARE p120_upd_xcbb_96 FROM l_sql
#       EXECUTE p120_upd_xcbb_96
#       
#       IF SQLCA.sqlcode THEN
#         LET g_success='N'
#         INITIALIZE g_errparam TO NULL
#         LET g_errparam.code = SQLCA.sqlcode
#         LET g_errparam.extend = 'upd xcbb006 by imaf013'
#         CALL cl_err() 
#         RETURN
#       END IF

##采购件有重工自己领自己的，成本阶给98
#       LET l_sql = " SELECT DISTINCT sfac001,NVL(sfac006,' ') sfac006,sfdd001,NVL(sfdd013,' ') sfdd013 FROM sfda_t,sfdd_t,sfdc_t,sfac_t ",
#                   " WHERE sfdaent   = sfdcent ", 
#                   "   AND sfdaent   = sfacent ",
#                   "   AND sfdaent   = sfddent ",
#                   "   AND sfdasite  = sfdcsite ", 
#                   "   AND sfdasite  = sfddsite ",
#                   "   AND sfdasite  = sfacsite ", 
#                   "   AND sfdadocno = sfdcdocno ",
#                   "   AND sfdadocno = sfdddocno ",                  
#                   "   AND sfacdocno = sfdc001 ",
#                   "   AND sfdcseq   = sfddseq ",
#                   "   AND sfdcsite  = '",g_master.imagsite,"'",
#                   "   AND sfdaent   = '",g_enterprise,"'",
#                   "   AND sfdastus  = 'S' ",
#                   "   AND sfda001 BETWEEN '",l_bdate,"' AND '",l_edate,"'",
#                   "   AND sfac001 = sfdd001 ",
#                   "   AND sfac002 IN ('1','2','3')"   #160812-00001#1 add
#       IF g_master.order ='1' THEN   #不需要特性
#          LET l_sql = " SELECT DISTINCT sfac001,' ' sfac006,sfdd001,' ' sfdd013 FROM (",l_sql,")"
#       END IF
#       LET l_sql = " (SELECT DISTINCT sfac001,sfac006 FROM (",l_sql,") WHERE sfac001 = sfdd001 AND sfac006 = sfdd013) "
#
#       LET l_sql =" MERGE INTO axcp120_tmp01 T1 ",        #160727-00019#20 Mod  axcp120_xcbb_tmp1--> axcp120_tmp02  #170213-00017#1 axcp120_tmp02 --> axcp120_tmp01
#                  " USING ",l_sql," T2",   
#                  "    ON (T1.imag001 = T2.sfac001 AND T1.xcbb004 = T2.sfac006 )",
#                  " WHEN MATCHED THEN UPDATE SET T1.xcbb006 =98,T1.xcbb007=98 "                     
#
#       PREPARE p120_upd_xcbb_97 FROM l_sql
#       EXECUTE p120_upd_xcbb_97
#       
#       IF SQLCA.sqlcode THEN
#         LET g_success='N'
#         INITIALIZE g_errparam TO NULL
#         LET g_errparam.code = SQLCA.sqlcode
#         LET g_errparam.extend = 'upd xcbb006_97'
#         CALL cl_err() 
#         RETURN
#       END IF
#160106-00003 --end 
#170213-00017#1 --end
##加上特性，从inaj里找
#
#       LET l_sql = " MERGE INTO axcp120_xcbb_tmp1 T1",
#                   " USING (SELECT DISTINCT T3.xcbbent xcbbent,T3.imagsite imagsite,T3.xcbb001 xcbb001,T3.xcbb002 xcbb002,T3.imag001 imag001,T4.inaj006 xcbb004,",
#                   "                        T3.imaa006 imaa006,T3.imag013 imag013,T3.xcbb006 xcbb006,T3.xcbb007 xcbb007,T3.xcbb008 xcbb008,T3.xcbb009 xcbb009,T3.imag011 imag011,T3.imaa003 imaa003,T3.imaa004 imaa004  ",
#                   "   FROM axcp120_xcbb_tmp1 T3,inaj_t T4 ",
#                   "  WHERE T3.xcbbent = T4.inajent AND T3.imagsite = T4.inaj209 AND T3.imag001 = T4.inaj005) T2",
#                   "    ON (T1.xcbbent = T2.xcbbent AND T1.imagsite = T2.imagsite AND T1.imag001 = T2.imag001 AND T1.xcbb004 = T2.xcbb004)",
#                   "  WHEN NOT MATCHED THEN INSERT VALUES (T2.xcbbent,T2.imagsite,T2.xcbb001,T2.xcbb002,T2.imag001,T2.xcbb004,",
#                   "                                       T2.imaa006,T2.imag013,T2.xcbb006,T2.xcbb007,T2.xcbb008,T2.xcbb009,T2.imag011,T2.imaa003,T2.imaa004)"
#                   
#
#       PREPARE p120_ins_xcbb_tmp4 FROM l_sql
#       EXECUTE p120_ins_xcbb_tmp4
# 
#       IF SQLCA.sqlcode THEN
#          LET g_success='N'
#         INITIALIZE g_errparam TO NULL
#         LET g_errparam.code = SQLCA.sqlcode
#         LET g_errparam.extend = 'INS axcp120_xcbb_tmp1'
#         CALL cl_err() 
#          RETURN
#       END IF 
 #      LET l_sql = " MERGE INTO axcp120_xcbb_tmp1 T1 ",
 #                  " USING inaj_t T2",
 #                  "    ON (T1.xcbbent = T2.inajent AND T1.imagsite = T2.inaj209 AND T1.imag001 = T2.inaj005)",
 #                  " WHEN MATCHED THEN UPDATE SET T1.xcbb004 = T2.inaj006 "
 #
 #      PREPARE p120_ins_xcbb_tmp4 FROM l_sql
 #      EXECUTE p120_ins_xcbb_tmp4
 #      
 #      IF SQLCA.sqlcode THEN
 #        LET g_success='N'
 #        INITIALIZE g_errparam TO NULL
 #        LET g_errparam.code = SQLCA.sqlcode
 #        LET g_errparam.extend = 'MERGE INTO axcp120_xcbb_tmp1'
 #        CALL cl_err() 
 #        RETURN
 #      END IF
       

#170213-00017#1 --begin       
#把前面发料低阶码计算出来的结果做对比，不存在的料件+特性就添加进去                   
#       LET l_sql = " MERGE INTO axcp120_tmp01 T1 ",       #160727-00019#20 Mod  axcp120_xcbb_tmp--> axcp120_tmp01
#                   " USING axcp120_tmp02 T2",         #160727-00019#20 Mod  axcp120_xcbb_tmp1--> axcp120_tmp02
#                   "    ON (T1.xcbbent = T2.xcbbent AND T1.imagsite = T2.imagsite AND T1.imag001 = T2.imag001 AND T1.xcbb004 = T2.xcbb004 )",
#                   "  WHEN NOT MATCHED THEN INSERT VALUES (T2.xcbbent,T2.imagsite,T2.xcbb001,T2.xcbb002,T2.imag001,T2.xcbb004,",
#                   "                                       T2.imaa006,T2.imag013,T2.xcbb006,T2.xcbb007,T2.xcbb008,T2.xcbb009,T2.imag011,T2.imaa003,T2.imaa004)"
#
#       PREPARE p120_ins_xcbb_tmp5 FROM l_sql
#       EXECUTE p120_ins_xcbb_tmp5
#       
#       IF SQLCA.sqlcode THEN
#         LET g_success='N'
#         INITIALIZE g_errparam TO NULL
#         LET g_errparam.code = SQLCA.sqlcode
#         LET g_errparam.extend = 'MERGE INTO axcp120_tmp01'             #160727-00019#20 Mod  axcp120_xcbb_tmp--> axcp120_tmp01
#         CALL cl_err() 
#         RETURN
#       END IF
#      
#       DELETE FROM  axcp120_tmp02          #160727-00019#20 Mod  axcp120_xcbb_tmp1--> axcp120_tmp02        

       CALL cl_progress_no_window_ing("insert axcp120_tmp01")           #160727-00019#20 Mod  axcp120_xcbb_tmp--> axcp120_tmp01
    END IF
#170213-00017#1 --end
#成本阶临时表插入完后，依据各种条件更新临时表里的成本阶
    CALL axcp120_upd_tmp()
    CALL cl_progress_no_window_ing("update axcp120_tmp01")              #160727-00019#20 Mod  axcp120_xcbb_tmp--> axcp120_tmp01 
#170213-00017#1 --begin 不需要特性栏位值
##wujie 150731 --begin
##order选项0的情况，最后根据参数，启用特性的，关联inaj去找料件的特性
#    IF cl_get_para(g_enterprise,g_master.imagsite,'S-FIN-6013') = 'Y' AND (g_master.order = '0') THEN   
#       DELETE FROM axcp120_tmp02        #160727-00019#20 Mod  axcp120_xcbb_tmp1--> axcp120_tmp02
#       #170208-00012#1 mod-S  tmp01和tmp02搞反了，纠正下
#       LET l_sql = " INSERT INTO axcp120_tmp02 ",    
#                   " SELECT * FROM axcp120_tmp01  "
#
#       PREPARE p120_ins_xcbb_tmp7 FROM l_sql
#       EXECUTE p120_ins_xcbb_tmp7
#
# 
#       IF SQLCA.sqlcode THEN
#          LET g_success='N'
#         INITIALIZE g_errparam TO NULL
#         LET g_errparam.code = SQLCA.sqlcode
#         LET g_errparam.extend = 'INS axcp120_xcbb_tmp02'          
#         CALL cl_err() 
#          RETURN
#       END IF 
#       DELETE FROM axcp120_tmp01
#       
##       LET l_sql = " INSERT INTO axcp120_tmp02 ",        #160727-00019#20 Mod  axcp120_xcbb_tmp1--> axcp120_tmp02
#       LET l_sql = " INSERT INTO axcp120_tmp01 ",         #170208-00012#1 tmp02 -->tmp01
#                   " SELECT DISTINCT T1.xcbbent,T1.imagsite,T1.xcbb001,T1.xcbb002,T1.imag001,T2.inaj006,T1.imaa006,T1.imag013,T1.xcbb006,T1.xcbb007,T1.xcbb008,T1.xcbb009,T1.imag011,T1.imaa003,T1.imaa004  ",
##                   "   FROM axcp120_tmp01 T1,inaj_t T2 ",               #160727-00019#20 Mod  axcp120_xcbb_tmp--> axcp120_tmp01
#                   "   FROM axcp120_tmp02 T1,inaj_t T2 ",               #170208-00012#1 tmp01 -->tmp02
#                   "  WHERE T1.xcbbent = T2.inajent AND T1.imagsite = T2.inaj209 AND T1.imag001 = T2.inaj005"
#       #170208-00012#1 mod-E
#
#       PREPARE p120_ins_xcbb_tmp3 FROM l_sql
#       EXECUTE p120_ins_xcbb_tmp3
# 
#       IF SQLCA.sqlcode THEN
#          LET g_success='N'
#         INITIALIZE g_errparam TO NULL
#         LET g_errparam.code = SQLCA.sqlcode
#         LET g_errparam.extend = 'INS axcp120_xcbb_tmp1'           #160727-00019#20 Mod  axcp120_xcbb_tmp1--> axcp120_tmp02
#         CALL cl_err() 
#          RETURN
#       END IF 
#    END IF
#    UPDATE axcp120_tmp02 SET xcbb004 = ' ' WHERE xcbb004 IS NULL
#170213-00017#1 --end
    UPDATE axcp120_tmp01 SET xcbb004 = ' ' WHERE xcbb004 IS NULL          #160727-00019#20 Mod  axcp120_xcbb_tmp--> axcp120_tmp01
#wujie 150731 --end      




#按BOM和按发料都不需要抓特性
#用merge，不存在xcbb的，insert，存在于xcbb的，update
#    LET l_sql = " MERGE INTO xcbb_t T1 "
#    IF cl_get_para(g_enterprise,g_master.imagsite,'S-FIN-6013') = 'Y' AND g_master.order = '0' THEN  #wujie 150731 add 0
#       LET l_sql = l_sql," USING axcp120_xcbb_tmp1 T2 "
#    ELSE
#       LET l_sql = l_sql," USING axcp120_xcbb_tmp T2 "
#    END IF
    LET l_sql = " MERGE INTO xcbb_t T1  ",
                " USING axcp120_tmp01 T2 "        #160727-00019#20 Mod  axcp120_xcbb_tmp--> axcp120_tmp01
    LET l_sql = l_sql,    
                "    ON (T1.xcbbent = T2.xcbbent AND T1.xcbbcomp = T2.imagsite AND T1.xcbb001 = T2.xcbb001 AND T1.xcbb002 = T2.xcbb002
                         AND T1.xcbb003 = T2.imag001 AND T1.xcbb004 = T2.xcbb004)",   #add xcbb004
                " WHEN MATCHED THEN UPDATE SET T1.xcbb005 = T2.imaa006,", 
                "                              T1.xcbb006 = T2.xcbb006,",     
                "                              T1.xcbb007 = T2.xcbb007,", 
                "                              T1.xcbb008 = T2.xcbb008,", 
                "                              T1.xcbb009 = T2.xcbb009,", 
                "                              T1.xcbb010 = T2.imag011,", 
                "                              T1.xcbb012 = T2.imaa003",
                " WHEN NOT MATCHED THEN INSERT VALUES (T2.xcbbent,'",g_user,"','",g_dept,"','",g_user,"','",g_dept,"',",
                "                                      SYSTIMESTAMP,'','','Y',T2.imagsite,",
                "                                      T2.xcbb001,T2.xcbb002,T2.imag001,T2.xcbb004,T2.imaa006,",
                "                                      T2.xcbb006,T2.xcbb007,T2.xcbb008,T2.xcbb009,T2.imag011,",
                "                                      '',T2.imaa003,'',",   #30个自定义栏位
                "                                      '','','','','',",    
                "                                      '','','','','',",
                "                                      '','','','','',",
                "                                      '','','','','',",
                "                                      '','','','','',",
                "                                      '','','','','')"

    PREPARE p120_merge_xcbb FROM l_sql
    EXECUTE p120_merge_xcbb

    IF SQLCA.sqlcode THEN
       LET g_success='N'
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = 'MERGE xcbb_t'
         CALL cl_err() 
       RETURN
    END IF
    #170217-00025#7 add-S
    IF SQLCA.sqlerrd[3] > 0 THEN
      LET g_flag = TRUE
    END IF
    #170217-00025#7 add-E
   #170118-00060#2-s-add
    #當成本階=0，xcbb011 = 1.製成品
    #當成本階=99、98、97，xcbb011 = 3.原料
    #成本階非以上兩類，xcbb011 = 2.半成品
    LET l_sql = "MERGE INTO xcbb_t T1 ",
                "USING (SELECT xcbbent,imagsite,xcbb001,xcbb002,imag001,xcbb004, ",
                "              CASE WHEN xcbb006 = 0 THEN '1' WHEN xcbb006 = 99 THEN '3' WHEN xcbb006 = 98 THEN '3' WHEN xcbb006 = 97 THEN '3' ELSE '2' END xcbb011 ",
                "         FROM axcp120_tmp01) T2 ",
                "   ON (T1.xcbbent = T2.xcbbent AND T1.xcbbcomp = T2.imagsite AND ",
                "       T1.xcbb001 = T2.xcbb001 AND T1.xcbb002 = T2.xcbb002 AND ",
                "       T1.xcbb003 = T2.imag001 AND T1.xcbb004 = T2.xcbb004 )",   
                " WHEN MATCHED THEN UPDATE SET T1.xcbb011 = T2.xcbb011 " 
              
    PREPARE p120_merge_xcbb011 FROM l_sql
    EXECUTE p120_merge_xcbb011

    IF SQLCA.sqlcode THEN
       LET g_success='N'
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = 'MERGE xcbb_t xcbb011'
         CALL cl_err() 
       RETURN
    END IF    
   #170118-00060#2-e-add 

    #170217-00025#7 add-S
    IF SQLCA.sqlerrd[3] > 0 THEN
      LET g_flag = TRUE
    END IF
    #170217-00025#7 add-E
    
    CALL cl_progress_no_window_ing("merge xcbb_t")
    
         
END FUNCTION
################################################################################
# Descriptions...: 建立臨時表
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
PRIVATE FUNCTION axcp120_create_tmp()
   DEFINE l_sql     STRING

   DROP TABLE axcp120_tmp01         #160727-00019#20 Mod  axcp120_xcbb_tmp--> axcp120_tmp01

   CREATE TEMP TABLE axcp120_tmp01(       #160727-00019#20 Mod  axcp120_xcbb_tmp--> axcp120_tmp01
   xcbbent      SMALLINT,
   imagsite     VARCHAR(10),         #法人組織
   xcbb001      SMALLINT,
   xcbb002      SMALLINT,
   imag001      VARCHAR(40),         #料件編號
   xcbb004      VARCHAR(256),         #特性
   imaa006      VARCHAR(10),         #單位
   imag013      VARCHAR(40),         #成本料號
   xcbb006      SMALLINT,         #成本階
   xcbb007      DECIMAL(15,3),         #按發料計算的低階碼
   xcbb008      DECIMAL(15,3),         #按BOM計算的低階碼
   xcbb009      VARCHAR(1),         #當月入聯產品否
   imag011      VARCHAR(10),         #成本分群碼
   imaa003      VARCHAR(10),         #主分群碼
   imaa004      VARCHAR(10)     #料件类别
    );

   DROP TABLE axcp120_tmp02             #160727-00019#20 Mod  axcp120_xcbb_tmp1--> axcp120_tmp02

   CREATE TEMP TABLE axcp120_tmp02(    #160727-00019#20 Mod  axcp120_xcbb_tmp1--> axcp120_tmp02
   xcbbent      SMALLINT,
   imagsite     VARCHAR(10),         #法人組織
   xcbb001      SMALLINT,
   xcbb002      SMALLINT,
   imag001      VARCHAR(40),         #料件編號
   xcbb004      VARCHAR(256),         #特性
   imaa006      VARCHAR(10),         #單位
   imag013      VARCHAR(40),         #成本料號
   xcbb006      SMALLINT,         #成本階
   xcbb007      DECIMAL(15,3),         #按發料計算的低階碼
   xcbb008      DECIMAL(15,3),         #按BOM計算的低階碼
   xcbb009      VARCHAR(1),         #當月入聯產品否
   imag011      VARCHAR(10),         #成本分群碼
   imaa003      VARCHAR(10),         #主分群碼
   imaa004      VARCHAR(10)     #料件类别
    );
    
#依发料计算低阶码时用来存放最后料件计算出来的低阶码
#结果表
   DROP TABLE axcp120_tmp03            #160727-00019#20 Mod  axcp120_ins_xcbb_t--> axcp120_tmp03 
   CREATE TEMP TABLE axcp120_tmp03     
   (
   imag001       VARCHAR(40),
   xcbb004       VARCHAR(256),         #wujie 150731
   xcbb006       SMALLINT
   );

#依发料计算低阶码时用来存放工单主件和下阶发料关系的资料
#关系表
   DROP TABLE axcp120_tmp04                      #160727-00019#20 Mod  axcp120_sfaa_tmp--> axcp120_tmp04 
   CREATE TEMP TABLE axcp120_tmp04               
   (
   sfaa010      VARCHAR(40),
   sfaa011      VARCHAR(30),         #wujie 150731
   sfdd001      VARCHAR(40),
   sfdd013      VARCHAR(256)     #wujie 150731
   );

#依发料计算低阶码时用来存放工单主件和下阶发料的料号
#基准表
   DROP TABLE axcp120_tmp05          #160727-00019#20 Mod  axcp120_imaa_tmp--> axcp120_tmp05
   CREATE TEMP TABLE axcp120_tmp05   
   (
   imaa001      VARCHAR(40),
   xcbb004      VARCHAR(256)     #wujie 150731
   );

#依发料计算低阶码时用来存放本轮循环的料号
#运算临时表
   DROP TABLE axcp120_tmp06               #160727-00019#20 Mod  axcp120_imaa_tmp1--> axcp120_tmp06
   CREATE TEMP TABLE axcp120_tmp06        
   (
   imaa0011     VARCHAR(40),
   xcbb0041     VARCHAR(256)     #wujie 150731
   );

#依发料计算低阶码时用来存放死循环料号中只做元件的，低阶码+1
#运算临时表
   DROP TABLE axcp120_tmp07            #160727-00019#20 Mod  axcp120_imaa_tmp2--> axcp120_tmp07
   CREATE TEMP TABLE axcp120_tmp07     
   (
   imaa0012     VARCHAR(40),
   xcbb0042     VARCHAR(256)     #wujie 150731
   );
   
   DROP TABLE sfac_tmp
   LET l_sql = "CREATE GLOBAL TEMPORARY TABLE sfac_tmp AS ",   #wujie 150801 sfaa-->sfac
                "SELECT * FROM sfac_t "
   PREPARE sfaa_tbl FROM l_sql
   EXECUTE sfaa_tbl
   FREE sfaa_tbl
   
   DROP TABLE sfec_tmp
   LET l_sql = "CREATE GLOBAL TEMPORARY TABLE sfec_tmp AS ",
                "SELECT * FROM sfec_t "
   PREPARE sfec_tbl FROM l_sql
   EXECUTE sfec_tbl
   FREE sfec_tbl
 
#wujie 160530 --begin #未结案工单 逻辑参考axcp160，s_axcp500
   DROP TABLE axcp120_sfaa_tmp1
   LET l_sql = " SELECT sfaa_t.* FROM sfaa_t,ooef_t,imaa_t ",  
               " WHERE sfaaent = ",g_enterprise,                 
               "   AND (sfaa048 IS NULL OR sfaa048 >= '",l_bdate,"')", #成会结案日期
               "   AND sfaastus IN ('Y','F','C','E','M') ",            #单据状态
               "   AND ooefent = sfaaent ",
               "   AND ooef001 = sfaasite ",
               "   AND ooef017 = '",g_master.imagsite,"'",
               "   AND imaaent = ",g_enterprise,
               "   AND sfaa010 = imaa001 ",
               "   INTO TEMP axcp120_sfaa_tmp1 "
           
                              
   PREPARE axcp120_cre_tmp_table_sfaa_p1 FROM l_sql
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code   = SQLCA.sqlcode
      LET g_errparam.extend = "axcp120_cre_tmp_table_sfaa_p1"
      LET g_errparam.popup  = TRUE
      CALL cl_err()
   END IF

   EXECUTE axcp120_cre_tmp_table_sfaa_p1
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code   = SQLCA.sqlcode
      LET g_errparam.extend = "EXECUTE axcp120_cre_tmp_table_sfaa_p1"
      LET g_errparam.popup  = TRUE
      CALL cl_err()
   END IF

   FREE axcp120_cre_tmp_table_sfaa_p1
#wujie 160530 --end
#wujie 160612 --begin
   DROP TABLE axcp120_sfaa_tmp2     
   CREATE TEMP TABLE axcp120_sfaa_tmp2     
   (
   sfaadocno    VARCHAR(20),
   sfaa010      VARCHAR(40),
   sfaa011      VARCHAR(30)
   );

#wujie 160623 --begin
#   DROP TABLE axcp120_sfaa_tmp3     
#   CREATE TEMP TABLE axcp120_sfaa_tmp3     
#   (
#   sfaadocno   LIKE sfaa_t.sfaadocno,
#   sfaa010     LIKE sfaa_t.sfaa010,
#   sfaa011     LIKE sfaa_t.sfaa011
#   );
   DROP TABLE axcp120_sfaa_tmp3    
   CREATE TEMP TABLE axcp120_sfaa_tmp3     
   (
   sfaa010_1      VARCHAR(40),
   sfaa011_1      VARCHAR(30),  
   sfaa010_2      VARCHAR(40),
   sfaa011_2      VARCHAR(30)
   );
#wujie 160623 --end
#wujie 160612 --end
#wujie 160623 --begin
   DROP TABLE axcp120_sfaa_tmp4     
   CREATE TEMP TABLE axcp120_sfaa_tmp4     
   (
   sfaa010_1      VARCHAR(40),
   sfaa011_1      VARCHAR(30),  
   sfaa010_2      VARCHAR(40),
   sfaa011_2      VARCHAR(30)
   );
#wujie 160623 --end

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
PRIVATE FUNCTION axcp120_upd_tmp()
DEFINE l_sql            STRING
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
DEFINE l_xcbc004        LIKE xcbc_t.xcbc004
DEFINE l_xcbc003        LIKE xcbc_t.xcbc003
DEFINE l_n              LIKE type_t.num5
DEFINE l_xcbb009        LIKE xcbb_t.xcbb009
DEFINE l_imag001        LIKE imag_t.imag001
DEFINE l_imag013        LIKE imag_t.imag013
DEFINE l_imaa004        LIKE imaa_t.imaa004
DEFINE l_xcbb006        LIKE xcbb_t.xcbb006
DEFINE l_where1         STRING
DEFINE l_where2         STRING
   
   LET g_success = 'Y'
   CALL s_get_accdate(g_glaa003,'',g_master.year,g_master.month)
     RETURNING l_flag1,l_errno,l_glav002,l_glav005,l_sdate_s,l_sdate_e,
               l_glav006,l_bdate,l_edate,l_glav007,l_wdate_s,l_wdate_e
   IF l_flag1='N' THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = l_errno
      LET g_errparam.extend = ''
      LET g_errparam.popup = FALSE
      CALL cl_err()

   END IF    

#对要用的工单和完工入库单数量先过滤精简，提高效率
#wujie 150801 --begin sfaa -->sfac
   DELETE FROM sfac_tmp
   INSERT INTO sfac_tmp 
        SELECT sfac_t.*
          FROM sfac_t,sfaa_t,axcp120_tmp01       #160727-00019#20 Mod  axcp120_xcbb_tmp--> axcp120_tmp01
         WHERE sfaaent = g_enterprise AND sfac001 = imag001    #这里不卡特性，范围虽然大一点，但是不用考虑特性到底给空格还是具体值的情况   
           AND sfaaent = sfacent
           AND sfaadocno = sfacdocno
           AND (sfaadocdt BETWEEN l_bdate AND l_edate
            OR sfaa048 BETWEEN l_bdate AND l_edate)

#wujie 150801 --end
   DELETE FROM sfec_tmp
   INSERT INTO sfec_tmp 
        SELECT sfec_t.*
          FROM sfac_tmp,sfea_t,sfec_t
         WHERE sfacent = sfeaent AND sfeaent = sfecent
           AND sfacdocno = sfec001 AND sfecdocno = sfeadocno
           AND sfec004 IN ('2','3')   #联产品类型 联产品，多产出视同一个逻辑计算成本阶  #wujie 150407 ，5:副产品排除
           AND sfea001 BETWEEN l_bdate AND l_edate
           AND sfeastus = 'S' 

#   IF g_master.order = '0' THEN    #wujie 150801 mark
#料件的来源码是采购性质，则成本阶(xcbb006)=99
      LET l_sql = " UPDATE axcp120_tmp01 SET xcbb006 = 99 ",        #160727-00019#20 Mod  axcp120_xcbb_tmp--> axcp120_tmp01
                  "  WHERE imaa004 ='M' "
      PREPARE p120_upd_xcbb006_99 FROM l_sql  
      
      EXECUTE p120_upd_xcbb006_99
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend =l_imag001,'||p120_upd_xcbb006_99'
         CALL cl_err()          
         LET g_success='N'
         RETURN
      END IF

#料件是采购性质，但有开工单的话成本阶(xcbb006)=98
      LET l_sql = " UPDATE axcp120_tmp01 SET xcbb006 = 98 ",       #160727-00019#20 Mod  axcp120_xcbb_tmp--> axcp120_tmp01
                  "  WHERE imaa004 ='M' ",
                  "    AND EXISTS (SELECT 1 FROM sfac_tmp WHERE sfac001 = imag001 ",
                  "                                         AND sfac002 IN ('1','2','3')"   #160812-00001#1 add
      
      IF g_master.order = '2' THEN #order是发料+特性的，需要考虑特性条件
         LET l_sql = l_sql," AND sfac006 = xcbb004)"
      ELSE
         LET l_sql = l_sql,")"
      END IF

                  
      PREPARE p120_upd_xcbb006_98 FROM l_sql  
      
      EXECUTE p120_upd_xcbb006_98
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend =l_imag001,'||p120_upd_xcbb006_98'
         CALL cl_err()           
         LET g_success='N'
         RETURN
      END IF
#wujie 150801 --begin
#   ELSE 
#      UPDATE axcp120_xcbb_tmp SET xcbb006 = xcbb007 
#   END IF
#wujie 150801 --end
#判斷當工單的生產料件是imag001,但入庫类型有=2,3,5的  #联产品，副产品，多产出视同一个逻辑计算成本阶
#表示有入聯產品
   UPDATE axcp120_tmp01 SET xcbb009 = 'N'        #160727-00019#20 Mod  axcp120_xcbb_tmp--> axcp120_tmp01

#wujie 150801 --begin
#   LET l_sql = " UPDATE axcp120_xcbb_tmp SET xcbb009 = 'Y' ",
#               "  WHERE imag001 IN (SELECT DISTINCT sfaa010 FROM sfaa_tmp,sfec_tmp ",
#               "                     WHERE sfaaent = sfecent ", 
#               "                       AND sfaadocno = sfec001)"

   IF g_master.order = '2' THEN #order是发料+特性的，需要考虑特性条件
      LET l_where1 = " AND sfaa011 = xcbb004 "
      LET l_where2 = " AND sfac006 = xcbb004 "   #wujie 160605 <> --> =
   ELSE
      LET l_where1 = " "
      LET l_where2 = " "
   END IF
#wujie 160607 --begin
#   LET l_sql = " UPDATE axcp120_xcbb_tmp SET xcbb009 = 'Y' ",
#               "  WHERE EXISTS (SELECT 1 FROM sfaa_t,sfac_tmp ",
#               "                 WHERE sfaa010 = imag001 ",l_where1,  #是否要特性
#               "                   AND (sfac001 <> imag001 ",l_where2,")",  #是否要特性2
#               "                   AND sfaaent = sfacent ",
#               "                   AND sfaasite = sfacsite ",
#               "                   AND sfaadocno = sfacdocno ",
#               "                   AND sfac002 IN ('2','3')) "
   LET l_sql = " UPDATE axcp120_tmp01 SET xcbb009 = 'Y' ",       #160727-00019#20 Mod  axcp120_xcbb_tmp--> axcp120_tmp01 
   #170208-00012#1 mod-S 添加ent条件   
#               "  WHERE EXISTS (SELECT 1 FROM (SELECT DISTINCT sfac001,sfac006 FROM sfac_tmp,sfec_tmp WHERE sfacdocno = sfec001) ",
#               "                 WHERE imag001 = sfac001 ",l_where2,")"               
               "  WHERE EXISTS (SELECT 1 FROM (SELECT DISTINCT sfac001,sfac006,sfacent FROM sfac_tmp,sfec_tmp WHERE sfacent = sfecent AND sfacent = ",g_enterprise," AND sfacdocno = sfec001) ",
               "                 WHERE xcbbent = sfacent AND xcbbent = ",g_enterprise," AND imag001 = sfac001 ",l_where2,")"               
   #170208-00012#1 mod-E    
#wujie 160607 --end
#wujie 150801 --end
   PREPARE p120_upd_xcbb009 FROM l_sql  

   EXECUTE p120_upd_xcbb009
   IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend =l_imag001,'||p120_upd_xcbb009'
         CALL cl_err()       
      LET g_success='N'
      RETURN
   END IF

   IF g_master.check = 'Y' THEN  #成本分群设定成本阶范围不分特性，不用考虑特性
      LET l_sql = " UPDATE axcp120_tmp01 SET xcbb006 = ? ",         #160727-00019#20 Mod  axcp120_xcbb_tmp--> axcp120_tmp01 
                  "  WHERE imag001 = ? "
      PREPARE p120_upd_prep FROM l_sql   
      
      LET l_sql = " SELECT * FROM axcp120_tmp01 "        #160727-00019#20 Mod  axcp120_xcbb_tmp--> axcp120_tmp01 
      PREPARE p120_prep FROM l_sql
      DECLARE p120_curs CURSOR FOR p120_prep
         
      FOREACH p120_curs INTO g_tmp.*      
         LET l_xcbb006 = g_tmp.xcbb006
         LET l_xcbc003 = NULL
         LET l_xcbc004 = NULL
         SELECT xcbc003,xcbc004 INTO l_xcbc003,l_xcbc004 FROM xcbc_t
          WHERE xcbcent = g_enterprise AND xcbc001 = g_master.imagsite
            AND xcbc002 = g_tmp.imag011
         IF SQLCA.SQLCODE <> 100 THEN
            IF NOT cl_null(l_xcbc004) THEN
               IF l_xcbb006 > l_xcbc004 THEN
                  LET l_xcbb006 = l_xcbc004
                  EXECUTE p120_upd_prep USING l_xcbb006,g_tmp.imag001
                  IF SQLCA.sqlcode OR SQLCA.sqlerrd[3]=0  THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = SQLCA.sqlcode
                     LET g_errparam.extend =l_imag001,'||p120_upd_prep'
                     CALL cl_err()                      
                     LET g_success='N'
                     EXIT FOREACH
                  END IF                  
               END IF
            END IF
            IF NOT cl_null(l_xcbc003) THEN
               IF l_xcbb006 < l_xcbc003 THEN
                  LET l_xcbb006 = l_xcbc003
                  EXECUTE p120_upd_prep USING l_xcbb006,g_tmp.imag001
                  IF SQLCA.sqlcode OR SQLCA.sqlerrd[3]=0  THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = SQLCA.sqlcode
                     LET g_errparam.extend =l_imag001,'||p120_upd_prep'
                     CALL cl_err()                      
                     LET g_success='N'
                     EXIT FOREACH
                  END IF 
               END IF
            END IF
         END IF
         
         
      END FOREACH
   END IF

   IF g_master.order = '0' THEN    #按发料计算的不用走这个逻辑
      CALL axcp120_nobom()
   END IF 
   CALL axcp120_setjp()  #处理联产品的成本阶
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
PRIVATE FUNCTION axcp120_nobom()
DEFINE l_sql       STRING
DEFINE l_imag001   LIKE imag_t.imag001
DEFINE l_imag013   LIKE imag_t.imag013
DEFINE l_xcbb006_b LIKE xcbb_t.xcbb005
DEFINE l_xcbb006_n LIKE xcbb_t.xcbb005
DEFINE l_xcbb006   LIKE xcbb_t.xcbb005
DEFINE l_n         LIKE type_t.num5
DEFINE l_n1        LIKE type_t.num5
DEFINE l_sfbadocno LIKE sfba_t.sfbadocno

   LET l_sql = " SELECT xcbb006,sfbadocno FROM sfaa_t,sfba_t,axcp120_tmp01",          #160727-00019#20 Mod  axcp120_xcbb_tmp--> axcp120_tmp01 
               "  WHERE sfaadocno=sfbadocno AND imag001=sfaa010 AND sfba006=? ",
               "  AND sfaadocdt <= '",l_edate,"'",
               "  AND (sfaa048 IS NULL OR sfaa048 >='",l_bdate,"')",
               "  AND sfaastus='Y'",
               "  ORDER BY imag013"
   PREPARE p120_sfaa_prep FROM l_sql
   DECLARE p120_sfaa_curs SCROLL CURSOR FOR p120_sfaa_prep           
  
   LET l_sql = " SELECT min(xcbb006) FROM sfaa_t,sfba_t,axcp120_tmp01",          #160727-00019#20 Mod  axcp120_xcbb_tmp--> axcp120_tmp01    #161103-00061 mod SELECT min(xcbb005)--> SELECT min(xcbb006)
               "  WHERE sfaadocno=sfbadocno AND imag001=sfba006 AND sfaa010=? ",
               "  AND sfaadocdt <= '",l_edate,"'",
               "  AND (sfaa048 IS NULL OR sfaa048 >='",l_bdate,"')",
               "  AND sfaastus='Y'",
               "  ORDER BY imag013"
   PREPARE p120_sfaa_prep1 FROM l_sql
   DECLARE p120_sfaa_curs1 SCROLL CURSOR FOR p120_sfaa_prep1
   
   DECLARE p120_nobom_curs CURSOR FOR
    SELECT imag001,imag013 FROM axcp120_tmp01 WHERE xcbb006 = 0           #160727-00019#20 Mod  axcp120_xcbb_tmp--> axcp120_tmp01
#wujie 150820 --begin
                                                   AND NOT EXISTS (SELECT 1 FROM bmaa_t,bmba_t     #160106-00003 add NOT
                                                                WHERE bmaaent = bmbaent
                                                                  AND bmaa001 = bmba001
                                                                  AND bmaaent = g_enterprise
                                                                  AND bmaa001 = imag001
                                                                  AND bmaastus = 'Y'
                                                                  AND bmba005 <=l_edate )
#wujie 150820 --end

#    SELECT COUNT(*) INTO l_n1 FROM axcp120_xcbb_tmp WHERE xcbb006 = 0    #160106-00003 mark
    
   FOREACH p120_nobom_curs INTO l_imag001,l_imag013
      IF SQLCA.sqlcode THEN
         LET g_success='N'
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend ='nobom for:'
         CALL cl_err()          
         EXIT FOREACH
      END IF
#wujie 150820 --begin       
#      LET l_n = 0
#      SELECT COUNT(*) INTO l_n FROM bmaa_t,bmba_t 
#      WHERE bmaaent = bmbaent AND bmaa001 = bmba001
#        AND bmaaent = g_enterprise AND bmaa001 = l_imag001
#        AND bmaastus = 'Y' AND bmba005 <=l_edate
#      IF l_n >0 THEN CONTINUE FOREACH END IF
#wujie 150820 --end      
      OPEN p120_sfaa_curs USING l_imag001
      FETCH FIRST p120_sfaa_curs INTO l_xcbb006,l_sfbadocno
      IF SQLCA.sqlcode AND STATUS<>100 THEN  
         LET g_success='N'
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend ='p120_sfaa_curs'
         CALL cl_err()                   
         LET l_xcbb006 =''       
         LET l_imag001 =''      
         EXIT FOREACH
      END IF
      CLOSE p120_sfaa_curs
      
      IF NOT cl_null(l_sfbadocno) THEN
         OPEN p120_sfaa_curs1 USING l_imag001
         FETCH FIRST p120_sfaa_curs1 INTO l_xcbb006_b
         IF SQLCA.sqlcode THEN LET l_xcbb006_b = '' END IF
         CLOSE p120_sfaa_curs1
         
         IF l_xcbb006_b = 0 THEN 
            LET l_xcbb006_n = 0 
         ELSE
            IF l_xcbb006_b > 0 AND NOT cl_null(l_xcbb006_b) THEN
               LET l_xcbb006_n = l_xcbb006_b - 1
            ELSE 
               LET l_xcbb006_n = 97
            END IF
         END IF
         EXECUTE p120_upd_p2 USING l_xcbb006_n,l_imag001
         IF SQLCA.sqlcode OR SQLCA.sqlerrd[3]=0  THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = SQLCA.sqlcode
            LET g_errparam.extend =l_imag001,'||upd imaag'
            CALL cl_err()              
            LET g_success='N'
            EXIT FOREACH
         END IF
      END IF
      LET l_sfbadocno = ''
   END FOREACH     
  
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
PRIVATE FUNCTION axcp120_setjp()
DEFINE l_imag001            LIKE imag_t.imag001
DEFINE l_imag013            LIKE imag_t.imag013
DEFINE l_xcbb006            LIKE xcbb_t.xcbb006  #联产品/多产出成本阶
DEFINE l_xcbb006_t          LIKE xcbb_t.xcbb006  #主件成本阶
DEFINE l_sfec005            LIKE sfec_t.sfec005
DEFINE l_sql                STRING
DEFINE l_field              STRING

   RETURN    #wujie 160622 add  发料那里改了，不需要再重复处理
   
   IF g_master.order = '2' THEN
      LET l_field = "sfec006"
   ELSE
      LET l_field = "' '"
   END IF
#   LET l_sql = " SELECT xcbb004,sfec005,",l_field," sfec006 FROM sfaa_t,sfea_t,sfec_t,axcp120_xcbb_tmp ",
#wujie 160607 --begin
#   LET l_sql = " SELECT xcbb006,sfec005,",l_field," sfec006 FROM sfaa_t,sfea_t,sfec_t,axcp120_xcbb_tmp ", #mod zhangllc 151105
#               "  WHERE sfaaent = sfeaent ",
#               "    AND sfeaent = sfecent ",
#               "    AND sfaadocno = sfec001 ",
#               "    AND sfecdocno = sfeadocno ",
#               "    AND sfaa010 = imag001 ", 
#               "    AND sfea001 BETWEEN '",l_bdate,"' AND '",l_edate,"'",
#               "    AND sfeastus = 'S' ", 
#               "    AND sfaa010 <> sfec005 ",
#               "    AND xcbb009 ='Y' ",
#               "    AND sfec004 IN ('2','3') "   
#       
#   LET l_sql = " MERGE INTO axcp120_xcbb_tmp T1 ", 
#               " USING (",l_sql,") T2",
#               "    ON ( T1.imag001 = T2.sfec005 AND T1.xcbb004 = T2.sfec006)", 
##               "  WHEN MATCHED THEN UPDATE SET T1.xcbb006 = T2.xcbb004 "
#               "  WHEN MATCHED THEN UPDATE SET T1.xcbb006 = T2.xcbb006 " #mod zhangllc 151105
               
#   LET l_sql = " SELECT sfacdocno,MIN(xcbb006) xcbb006 FROM axcp120_xcbb_tmp,sfac_tmp,sfec_tmp" ,
#               "  WHERE sfacdocno = sfec001",
#               "    AND sfac001   = imag001",
#               "    AND sfac006   = xcbb004",
#               "  GROUP BY sfacdocno "

   LET l_sql = " SELECT sfac001,sfac006,MIN(xcbb006) xcbb006 FROM axcp120_tmp01,sfac_tmp" ,        #160727-00019#20 Mod  axcp120_xcbb_tmp--> axcp120_tmp01
               "  WHERE sfac001 = imag001",
               "    AND sfac006 = xcbb004",
               "  GROUP BY sfac001,sfac006 "

#   LET l_sql = "SELECT DISTINCT sfac001,sfac006,xcbb006 FROM (",l_sql,") A,sfac_tmp B WHERE A.sfacdocno = B.sfacdocno"
   
   LET l_sql = " MERGE INTO axcp120_tmp01 T1 ",        #160727-00019#20 Mod  axcp120_xcbb_tmp--> axcp120_tmp01
               " USING (",l_sql,") T2",
               "    ON ( T1.imag001 = T2.sfac001 AND T1.xcbb004 = T2.sfac006)", 
               "  WHEN MATCHED THEN UPDATE SET T1.xcbb006 = T2.xcbb006 "
#wujie 160607 --end
    PREPARE p120_setjp_curs FROM l_sql
    EXECUTE p120_setjp_curs

    IF SQLCA.sqlcode THEN
       LET g_success='N'
       INITIALIZE g_errparam TO NULL
       LET g_errparam.code = SQLCA.sqlcode
       LET g_errparam.extend ='setjp'
       CALL cl_err()  
       RETURN
    END IF
#   DECLARE p120_setjp_curs CURSOR FOR 
#    SELECT imag001,sfec005,imag013,xcbb004 FROM sfaa_t,sfea_t,sfec_t,axcp120_xcbb_tmp
#       WHERE sfaaent = sfeaent 
#         AND sfeaent = sfecent
#         AND sfaadocno = sfec001 
#         AND sfecdocno = sfeadocno
#         AND sfaa010 = imag001 
#         AND sfea001 BETWEEN l_bdate AND l_edate
#         AND sfeastus = 'S' 
#         AND sfaa010 <> sfec005
#         AND xcbb009 ='Y'
#         AND sfec004 IN ('2','3')   #wujie 150407 ，5:副产品排除
#                  
#   FOREACH p120_setjp_curs INTO l_imag001,l_sfec005,l_imag013,l_xcbb004
##wujie 150407 --begin   #以主件成本阶为准
###抓聯產品的成本階,若主產品的成本階比聯產品成本階小的話,就以主產品的成本階為主
##      SELECT xcbb006 INTO l_xcbb006 FROM axcp120_xcbb_tmp
##       WHERE imag001 = l_sfec005
##         AND xcbb009 = 'N'
##      IF l_xcbb006_t < l_xcbb006 THEN
##         LET l_xcbb006 = l_xcbb006_t
##      END IF
#      SELECT xcbb006 INTO l_xcbb006 FROM axcp120_xcbb_tmp
#       WHERE imag001 = l_sfec005
#         AND xcbb009 = 'N'
##wujie 150407 --end 
#      
#      EXECUTE p120_upd_p2 USING l_xcbb006,l_sfec005
#      IF SQLCA.sqlcode OR SQLCA.sqlerrd[3]=0  THEN
#         CALL cl_errmsg('imaag001',l_sfec005,'upd imaag',STATUS,1)                                  
#         LET g_success='N'
#         EXIT FOREACH
#      END IF
#   END FOREACH
#
   #前段资料无，委外待补
         
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
PRIVATE FUNCTION axcp120_chk_year_month()
DEFINE r_success       LIKE type_t.num5
DEFINE l_glaa003       LIKE glaa_t.glaa003
DEFINE l_cnt           LIKE type_t.num5

   LET r_success = TRUE
   IF g_master.year IS NULL THEN
      LET r_success = TRUE
      RETURN r_success
   END IF

   IF g_master.imagsite IS NULL THEN
      LET r_success = TRUE
      RETURN r_success
   END IF
   
#抓出会计周期参考表号  glaa003
   SELECT glaa003 INTO l_glaa003
     FROM glaa_t
    WHERE glaaent  = g_enterprise
      AND glaacomp = g_master.imagsite
      AND glaa014  = 'Y'     
   
   IF g_master.month IS NULL THEN   
#只检查年 从glav中找到输入的年是否存在
      LET l_cnt = 0 
      SELECT COUNT(*) INTO l_cnt 
        FROM glav_t
       WHERE glavent  = g_enterprise
         AND glav001  = l_glaa003
         AND glav002  = g_master.year
         AND glavstus = 'Y'
         
      IF l_cnt = 0 THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = "axc-00331"
         LET g_errparam.extend = g_master.year
         LET g_errparam.popup = TRUE
         CALL cl_err()
         LET r_success = FALSE
         RETURN r_success
      END IF
   ELSE
      LET l_cnt = 0 
      SELECT COUNT(*) INTO l_cnt 
        FROM glav_t
       WHERE glavent  = g_enterprise
         AND glav001  = l_glaa003
         AND glav002  = g_master.year
         AND glav006  = g_master.month
         AND glavstus = 'Y'
         
      IF l_cnt = 0 THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = "axc-00332"
         LET g_errparam.extend = g_master.year,'|',g_master.month
         LET g_errparam.popup = TRUE
         CALL cl_err()
         LET r_success = FALSE
         RETURN r_success
      END IF
   END IF
   
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
PRIVATE FUNCTION axcp120_drop_tmp_table()
   DROP TABLE axcp120_tmp01      #160727-00019#20 Mod  axcp120_xcbb_tmp--> axcp120_tmp01
   
   DROP TABLE axcp120_tmp02      #160727-00019#20 Mod  axcp120_xcbb_tmp1--> axcp120_tmp02
   
   DROP TABLE axcp120_tmp03        #160727-00019#20 Mod  axcp120_ins_xcbb_t--> axcp120_tmp03 
   
   DROP TABLE axcp120_tmp04        #160727-00019#20 Mod  axcp120_sfaa_tmp--> axcp120_tmp04 
   
   DROP TABLE axcp120_tmp05        #160727-00019#20 Mod  axcp120_imaa_tmp--> axcp120_tmp05
   
   DROP TABLE axcp120_tmp06        #160727-00019#20 Mod  axcp120_imaa_tmp1--> axcp120_tmp06

   DROP TABLE axcp120_tmp07        #160727-00019#20 Mod  axcp120_imaa_tmp2--> axcp120_tmp07
   
   DROP TABLE sfac_tmp       #wujie 150801 sfaa-->sfac
   
   DROP TABLE sfec_tmp 
END FUNCTION

################################################################################
# Descriptions...: 依发料计算低阶码-参考gp5.25的abmp6401
# Memo...........:
# Usage..........: CALL s_aooi150_ins (传入参数)
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: r_success      回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 2015/07/04 By wujie
# Modify.........:
################################################################################
PRIVATE FUNCTION axcp120_gen_imac()
   DEFINE r_success     LIKE type_t.num5
   DEFINE l_sql         STRING
   DEFINE l_sql1        STRING
   DEFINE l_level       LIKE type_t.num5
   DEFINE l_cnt         LIKE type_t.num5
   DEFINE l_cnt_remain  LIKE type_t.num5
   DEFINE l_field1      STRING
   DEFINE l_field2      STRING
   DEFINE l_sfaa010     LIKE sfaa_t.sfaa010
   DEFINE l_sfaa011     LIKE sfaa_t.sfaa011
   
   LET r_success = TRUE
   
   RETURN r_success    #160712-00005#6
   
#此逻辑是参考gp5.25中的abmp6041来实现的
#step1：填充axcp120_tmp04（所有料号按主件VS发料的关系存档）  #wujie 160612 改为同一层的主件/联产品要和他们所有下阶都建立关系    
#       填充axcp120_tmp05存放参与低阶码运算的所有料号） 
#       清空axcp120_ins_xcbb_t
#       剔除死循环
#step2：主循环
#       循环内容，剥离顶层料件（即只存在于单头而不存在于单身的料件）
#       被剥离出来的料件被暂存与sub_ima中，并会被从axcp120_tmp05,axcp120_tmp04中删除
#       当某次剥离出来发现结果集为空时，说明已经没有顶层料件，此时如果axcp120_tmp05中为空，则表示低阶码运算结束
#       否则说明有循环存在,axcp120_tmp05中剩余的为涉及循环的料件，全部更新为99

#step1
#填充axcp120_tmp04
   DELETE FROM axcp120_tmp04           #160727-00019#20 Mod  axcp120_sfaa_tmp--> axcp120_tmp04 
   
   INSERT INTO axcp120_tmp04           #160727-00019#20 Mod  axcp120_sfaa_tmp--> axcp120_tmp04 
   SELECT DISTINCT sfac001,NVL(sfac006,' '),sfdd001,NVL(sfdd013,' ') FROM sfda_t,sfdd_t,sfdc_t,sfac_t,axcp120_sfaa_tmp1   #wujie 160530 add sfaa_tmp1 #未结案的工单对应的要全部抓进来
       WHERE sfdaent   = sfdcent 
         AND sfdaent   = sfacent
         AND sfdaent   = sfddent
         AND sfdasite  = sfdcsite 
         AND sfdasite  = sfddsite
         AND sfdasite  = sfacsite 
         AND sfdadocno = sfdcdocno
         AND sfdadocno = sfdddocno                  
         AND sfacdocno = sfdc001
         AND sfdcseq   = sfddseq
#         AND sfdcsite  = g_master.imagsite   #wujie 160530  有sfaasite了，不需要再抓这个条件
         AND sfdaent   = g_enterprise
         AND sfdastus  = 'S'
         AND sfda002 IN ('11','12','13','14','15') 
#         AND sfda001 BETWEEN l_bdate AND l_edate      #wujie 160530
#         AND (sfaa048 IS  NULL OR sfaa048 < l_bdate)    #已做成本结案的工单排除掉
#wujie 160530 --begin 未结案的工单对应的要全部抓进来
         AND sfacent = sfaaent
         AND sfacdocno = sfaadocno
#wujie 160530 --end

   IF SQLCA.sqlcode THEN
      LET r_success = FALSE
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend ='INS axcp120_tmp04'            #160727-00019#20 Mod  axcp120_sfaa_tmp--> axcp120_tmp04 
      CALL cl_err()  
      RETURN r_success
   END IF
   
#wujie 160612 --begin 
#axcp120_sfaa_tmp2和axcp120_sfaa_tmp3是用来存工单号，主件/联产品关系的，最后用来在axcp120_tmp04中再造出同工单其他主件/联产品对应其他工单中上阶料的关系
   DELETE FROM axcp120_sfaa_tmp2
   DELETE FROM axcp120_sfaa_tmp3
   DELETE FROM axcp120_sfaa_tmp4    #wujie 160623
   
   INSERT INTO axcp120_sfaa_tmp2 
   SELECT DISTINCT sfaadocno,sfac001,NVL(sfac006,' ') FROM sfda_t,sfdd_t,sfdc_t,sfac_t,axcp120_sfaa_tmp1   #wujie 160530 add sfaa_tmp1 #未结案的工单对应的要全部抓进来
       WHERE sfdaent   = sfdcent 
         AND sfdaent   = sfacent
         AND sfdaent   = sfddent
         AND sfdasite  = sfdcsite 
         AND sfdasite  = sfddsite
         AND sfdasite  = sfacsite 
         AND sfdadocno = sfdcdocno
         AND sfdadocno = sfdddocno                  
         AND sfacdocno = sfdc001
         AND sfdcseq   = sfddseq
         AND sfdaent   = g_enterprise
         AND sfdastus  = 'S'
         AND sfda002 IN ('11','12','13','14','15') 
         AND sfacent = sfaaent
         AND sfacdocno = sfaadocno
         AND sfac002 IN ('1','2','3')   #wujie 160623 

   IF SQLCA.sqlcode THEN
      LET r_success = FALSE
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend ='INS axcp120_sfaa_tmp2'
      CALL cl_err()  
      RETURN r_success
   END IF

#wujie 160623 --begin
#   INSERT INTO axcp120_sfaa_tmp3 
#   SELECT * FROM axcp120_sfaa_tmp2
#
#   IF SQLCA.sqlcode THEN
#      LET r_success = FALSE
#      INITIALIZE g_errparam TO NULL
#      LET g_errparam.code = SQLCA.sqlcode
#      LET g_errparam.extend ='INS axcp120_sfaa_tmp3'
#      CALL cl_err()  
#      RETURN r_success
#   END IF  

#举例工单1有主件A，联产品B，元件C，工单2主件D，元件B
#axcp120_tmp04中现在有的是A-C，B-C，D-B，我们要多建一笔虚拟的D-A进去
   INSERT INTO axcp120_sfaa_tmp3
     SELECT DISTINCT T1.sfaa010,T1.sfaa011,T2.sfaa010,T2.sfaa011 
       FROM axcp120_sfaa_tmp2 T1,axcp120_sfaa_tmp2 T2
      WHERE T1.sfaadocno = T2.sfaadocno

   IF SQLCA.sqlcode THEN
      LET r_success = FALSE
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend ='INS axcp120_sfaa_tmp3'
      CALL cl_err()  
      RETURN r_success
   END IF 

#去除A-A,B-B,C-C这种
   DELETE FROM axcp120_sfaa_tmp3 WHERE sfaa010_1 = sfaa010_2 AND sfaa011_1 = sfaa011_2

#以上是先建立了同工单号下的关系，抛弃工单号之后，还要考虑料件相同的，比如A在工单1使用了，在工单2也可能被用到
#替换位置2的
   INSERT INTO axcp120_sfaa_tmp4
     SELECT DISTINCT T1.sfaa010_1,T1.sfaa011_1,T2.sfaa010_2,T2.sfaa011_2 
       FROM axcp120_sfaa_tmp3 T1,axcp120_sfaa_tmp3 T2
      WHERE T1.sfaa010_2 = T2.sfaa010_1
        AND T1.sfaa011_2 = T2.sfaa011_1

   IF SQLCA.sqlcode THEN
      LET r_success = FALSE
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend ='INS axcp120_sfaa_tmp4 first'
      CALL cl_err()  
      RETURN r_success
   END IF  
#替换位置1的
   INSERT INTO axcp120_sfaa_tmp4
     SELECT DISTINCT T2.sfaa010_2,T2.sfaa011_2,T1.sfaa010_2,T1.sfaa011_2 
       FROM axcp120_sfaa_tmp3 T1,axcp120_sfaa_tmp3 T2
      WHERE T1.sfaa010_1 = T2.sfaa010_1
        AND T1.sfaa011_1 = T2.sfaa011_1

   IF SQLCA.sqlcode THEN
      LET r_success = FALSE
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend ='INS axcp120_sfaa_tmp4 second'
      CALL cl_err()  
      RETURN r_success
   END IF 

#去除A-A,B-B,C-C这种
   DELETE FROM axcp120_sfaa_tmp4 WHERE sfaa010_1 = sfaa010_2 AND sfaa011_1 = sfaa011_2
   
#去除重复的资料   
   LET l_sql = " DELETE FROM axcp120_sfaa_tmp4 T1 ", 
               " WHERE rowid <> (SELECT MAX(rowid) FROM axcp120_sfaa_tmp4 T2 ", 
               "                  WHERE T1.sfaa010_1 = T2.sfaa010_1 AND T1.sfaa011_1 = T2.sfaa011_1 AND T1.sfaa010_2 = T2.sfaa010_2 AND T1.sfaa011_2 = T2.sfaa011_2)"

   PREPARE axcp120_del_sfaa_p0 FROM l_sql
   EXECUTE axcp120_del_sfaa_p0   
    
   IF SQLCA.sqlcode THEN
      LET r_success = FALSE
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend ='EXECUTE axcp120_del_sfaa_p0'
      CALL cl_err()  
      RETURN r_success
   END IF

#到以上为止，统计出一种关系，某个料，有哪些对应的同阶主件/联产品/多产出料，注意是跨工单的！
#举例来说，工单1有主件多产出等A，B，C，工单2单头有B，H，那最后出来就是A-B，A-C，A-H，B-A,B-C,B-H,C-A,C-B,C-H,H-A,H-B,H-C，再去之前抓出的工单主件-发料料号的关系里替换料号

   INSERT INTO axcp120_tmp04               #160727-00019#20 Mod  axcp120_sfaa_tmp--> axcp120_tmp04
     SELECT DISTINCT T1.sfaa010,T1.sfaa011,T2.sfaa010_2,T2.sfaa011_2
       FROM axcp120_tmp04 T1,axcp120_sfaa_tmp4 T2       #160727-00019#20 Mod  axcp120_sfaa_tmp--> axcp120_tmp04
      WHERE T1.sfdd001 = T2.sfaa010_1
        AND T1.sfdd013 = T2.sfaa011_1

   IF SQLCA.sqlcode THEN
      LET r_success = FALSE
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend ='INS axcp120_tmp04 first'       #160727-00019#20 Mod  axcp120_sfaa_tmp--> axcp120_tmp04
      CALL cl_err()  
      RETURN r_success
   END IF
   
   INSERT INTO axcp120_tmp04              #160727-00019#20 Mod  axcp120_sfaa_tmp--> axcp120_tmp04
     SELECT DISTINCT T2.sfaa010_2,T2.sfaa011_2,T1.sfdd001,T1.sfdd013
       FROM axcp120_tmp04 T1,axcp120_sfaa_tmp4 T2            #160727-00019#20 Mod  axcp120_sfaa_tmp--> axcp120_tmp04
      WHERE T1.sfaa010 = T2.sfaa010_1
        AND T1.sfaa011 = T2.sfaa011_1

   IF SQLCA.sqlcode THEN
      LET r_success = FALSE
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend ='INS axcp120_tmp04 second'     #160727-00019#20 Mod  axcp120_sfaa_tmp--> axcp120_tmp04
      CALL cl_err()  
      RETURN r_success
   END IF
#wujie 160623 --end
#去除重复的资料 
   LET l_sql = " DELETE FROM axcp120_tmp04 T1 ",         #160727-00019#20 Mod  axcp120_sfaa_tmp--> axcp120_tmp04
               " WHERE rowid <> (SELECT MAX(rowid) FROM axcp120_tmp04 T2 ",       #160727-00019#20 Mod  axcp120_sfaa_tmp--> axcp120_tmp04
               "                  WHERE T1.sfaa010 = T2.sfaa010 AND T1.sfaa011 = T2.sfaa011 AND T1.sfdd001 = T2.sfdd001 AND T1.sfdd013 = T2.sfdd013)"
   
   PREPARE axcp120_del_sfaa_p FROM l_sql
   EXECUTE axcp120_del_sfaa_p   
    
   IF SQLCA.sqlcode THEN
      LET r_success = FALSE
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend ='EXECUTE axcp120_del_sfaa_p'
      CALL cl_err()  
      RETURN r_success
   END IF
#wujie 160612 --end    
#填充axcp120_tmp05
   DELETE FROM axcp120_tmp05              #160727-00019#20 Mod  axcp120_imaa_tmp--> axcp120_tmp05

#不使用特性时，特性不参与计算，upd成空格  
   IF cl_get_para(g_enterprise,g_master.imagsite,'S-FIN-6013') = 'Y' THEN
      LET l_field1 = "sfaa011"
      LET l_field2 = "sfdd013"
   ELSE
      LET l_field1 = "' '"
      LET l_field2 = "' '"   
   END IF
   
   LET l_sql = "
   INSERT INTO axcp120_tmp05                   
   SELECT DISTINCT imaa001,xcbb004 FROM
   (
   SELECT DISTINCT sfaa010 imaa001,",l_field1," xcbb004 FROM axcp120_tmp04          
   UNION
   SELECT DISTINCT sfdd001,",l_field2," FROM axcp120_tmp04             
   )" #160727-00019#20 Mod  axcp120_sfaa_tmp--> axcp120_tmp04 ,axcp120_imaa_tmp--> axcp120_tmp05
   
   PREPARE axcp120_ins_imaa FROM l_sql
   EXECUTE axcp120_ins_imaa   
    
   IF SQLCA.sqlcode THEN
      LET r_success = FALSE
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend ='INS axcp120_tmp05'     #160727-00019#20 Mod  axcp120_imaa_tmp--> axcp120_tmp05
      CALL cl_err()  
      RETURN r_success
   END IF

#清空axcp120_ins_xcbb_t
   DELETE FROM axcp120_ins_xcbb_t
    
#剔除死循环
   LET l_sql="SELECT DISTINCT X1||Y1 FROM  ",                                
   					"( ",                                                               
   					"  SELECT * FROM " ,                                                
   					"  (SELECT sfaa010||sfaa011 x1,sfdd001||sfdd013 y1 FROM axcp120_tmp04 ), ",     #160727-00019#20 Mod  axcp120_sfaa_tmp--> axcp120_tmp04  
   					"  (SELECT sfaa010||sfaa011 x2,sfdd001||sfdd013 y2 FROM axcp120_tmp04 ) ",      #160727-00019#20 Mod  axcp120_sfaa_tmp--> axcp120_tmp04  
   					"  WHERE x1=y2 AND y1=x2  ", 
   					") ",                       
   					"UNION ",                                                           
  					"SELECT DISTINCT X2||Y2 FROM  ",                                
   					"( ",                                                               
   					"  SELECT * FROM ",                                                 
   					"  (SELECT sfaa010||sfaa011 x1,sfdd001||sfdd013 y1 FROM axcp120_tmp04 ), ",    #160727-00019#20 Mod  axcp120_sfaa_tmp--> axcp120_tmp04    
   					"  (SELECT sfaa010||sfaa011 x2,sfdd001||sfdd013 y2 FROM axcp120_tmp04 ) ",     #160727-00019#20 Mod  axcp120_sfaa_tmp--> axcp120_tmp04     
   					"  WHERE x1=y2 AND y1=x2  ", 
 					") "   
   LET l_sql1 = "SELECT sfaa010,sfaa011 FROM axcp120_tmp04 WHERE sfaa010||sfaa011||sfdd001||sfdd013 IN ( ",l_sql," ) " 	#这个sql是用来输出死循环的料号的	 #160727-00019#20 Mod  axcp120_sfaa_tmp--> axcp120_tmp04   
   PREPARE axcp120_sel_sfaa_p FROM l_sql
   DECLARE axcp120_sel_sfaa_c CURSOR FOR axcp120_sel_sfaa_p
   FOREACH axcp120_sel_sfaa_c INTO l_sfaa010,l_sfaa011
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'abm-00260'
      LET g_errparam.extend = l_sfaa010,'||',l_sfaa011
      CALL cl_err()   
   END FOREACH   
   
   LET l_sql="DELETE FROM axcp120_tmp04 WHERE sfaa010||sfaa011||sfdd001||sfdd013 IN ( ",l_sql," ) "  #160727-00019#20 Mod  axcp120_sfaa_tmp--> axcp120_tmp04
    
   PREPARE axcp120_del_sfaa FROM l_sql
   EXECUTE axcp120_del_sfaa
    
   IF SQLCA.sqlcode THEN
      LET r_success = FALSE
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend ='DEL FROM axcp120_tmp04' #160727-00019#20 Mod  axcp120_sfaa_tmp--> axcp120_tmp04
      CALL cl_err()
      RETURN r_success
   END IF

#开始主循环
   DELETE FROM axcp120_tmp06        #160727-00019#20 Mod  axcp120_imaa_tmp1--> axcp120_tmp06
   DELETE FROM axcp120_tmp07        #160727-00019#20 Mod  axcp120_imaa_tmp2--> axcp120_tmp07
   DELETE FROM axcp120_tmp03        #160727-00019#20 Mod  axcp120_ins_xcbb_t--> axcp120_tmp03 
   LET l_level = 0
   WHILE TRUE
#        IF l_level >= g_master.level THEN
#           LET r_success = FALSE
#           INITIALIZE g_errparam TO NULL
#           LET g_errparam.code = 'axc-00720'
#           LET g_errparam.extend =''
#           CALL cl_err()#超过预设最大展开层数
#           RETURN r_success        
#        END IF
        #找出有单头无单身的料件
        LET l_cnt_remain = 0
        SELECT COUNT(*) INTO l_cnt_remain FROM axcp120_tmp05         #160727-00019#20 Mod  axcp120_imaa_tmp--> axcp120_tmp05
        INSERT INTO axcp120_tmp06           #160727-00019#20 Mod  axcp120_imaa_tmp1--> axcp120_tmp06
         SELECT imaa001,xcbb004 FROM axcp120_tmp05                   #160727-00019#20 Mod  axcp120_imaa_tmp--> axcp120_tmp05
          WHERE NOT EXISTS ( SELECT 1 FROM axcp120_tmp04 WHERE sfdd001 = imaa001 AND sfdd013 = xcbb004 )           #160727-00019#20 Mod  axcp120_sfaa_tmp--> axcp120_tmp04
            AND EXISTS ( SELECT 1 FROM axcp120_tmp04 WHERE sfaa010 = imaa001 AND sfaa011 = xcbb004)                #160727-00019#20 Mod  axcp120_sfaa_tmp--> axcp120_tmp04
        IF SQLCA.sqlcode THEN
           LET r_success = FALSE
           INITIALIZE g_errparam TO NULL
           LET g_errparam.code = SQLCA.sqlcode
           LET g_errparam.extend ='INS axcp120_tmp06'         #160727-00019#20 Mod  axcp120_imaa_tmp1--> axcp120_tmp06
           CALL cl_err()
           RETURN r_success
        END IF
 
        LET l_cnt = 0
        SELECT COUNT(*) INTO l_cnt FROM axcp120_tmp06         #160727-00019#20 Mod  axcp120_imaa_tmp1--> axcp120_tmp06
        #如果当前没有了则要判断是出现循环还是全部执行完毕       
        IF l_cnt =0 THEN
        	  #如果最后axcp120_tmp05(基准表)中没有剩余料件，则表示所有料件低阶码已经全部计算完毕
           IF l_cnt_remain = 0 THEN
              LET r_success = TRUE
              RETURN r_success
           ELSE
#             #这里没有采用老TT的做法，直接把剩余料件设为99阶
#             INSERT INTO axcp120_ins_xcbb_t
#             SELECT DISTINCT imaa001,xcbb004,'99' FROM axcp120_imaa_tmp
#果然还是死循环啊！
#找出只做了元件
              #找出有单身无单头的料件
              INSERT INTO axcp120_tmp07        #160727-00019#20 Mod  axcp120_imaa_tmp2--> axcp120_tmp07
               SELECT imaa001,xcbb004 FROM axcp120_tmp05        #160727-00019#20 Mod  axcp120_imaa_tmp--> axcp120_tmp05
                WHERE EXISTS ( SELECT 1 FROM axcp120_sfaa_tmp WHERE sfdd001 = imaa001 AND sfdd013 = xcbb004 )
                  AND NOT EXISTS ( SELECT 1 FROM axcp120_sfaa_tmp WHERE sfaa010 = imaa001 AND sfaa011 = xcbb004) 
#死循环的应该是既有单头又有单身的            
              LET l_sql = "SELECT imaa001,xcbb004 FROM axcp120_tmp05 ",     #160727-00019#20 Mod  axcp120_imaa_tmp--> axcp120_tmp05
                          " WHERE EXISTS ( SELECT 1 FROM axcp120_sfaa_tmp WHERE sfdd001 = imaa001 AND sfdd013 = xcbb004 )",
                          "   AND EXISTS ( SELECT 1 FROM axcp120_sfaa_tmp WHERE sfaa010 = imaa001 AND sfaa011 = xcbb004)"
#                          " WHERE NOT EXISTS ( SELECT 1 FROM axcp120_imaa_tmp2 WHERE imaa001 = imaa0012 AND xcbb004 = xcbb0042) "
              PREPARE axcp120_sel_sfaa_p1 FROM l_sql
              DECLARE axcp120_sel_sfaa_c1 CURSOR FOR axcp120_sel_sfaa_p1
              FOREACH axcp120_sel_sfaa_c1 INTO l_sfaa010,l_sfaa011
                 INITIALIZE g_errparam TO NULL
                 LET g_errparam.code = 'abm-00260'
                 LET g_errparam.extend = l_sfaa010,'||',l_sfaa011
                 CALL cl_err()   
              END FOREACH 
#没有单身的元件取当前跑到的低阶码              
              LET l_sql = "INSERT INTO axcp120_tmp03 ",           #160727-00019#20 Mod  axcp120_ins_xcbb_t--> axcp120_tmp03
                          " SELECT DISTINCT imaa001,xcbb004,",l_level," FROM axcp120_tmp05",        #160727-00019#20 Mod  axcp120_imaa_tmp--> axcp120_tmp05
                          " WHERE NOT EXISTS ( SELECT 1 FROM axcp120_tmp07 WHERE imaa001 = imaa0012 AND xcbb004 = xcbb0042) "  #160727-00019#20 Mod  axcp120_imaa_tmp2--> axcp120_tmp07
              PREPARE axcp120_ins_xcbb_p FROM l_sql
              EXECUTE axcp120_ins_xcbb_p
              IF SQLCA.sqlcode THEN
                 LET r_success = FALSE
                 INITIALIZE g_errparam TO NULL
                 LET g_errparam.code = SQLCA.sqlcode
                 LET g_errparam.extend ='INS axcp120_tmp03'           #160727-00019#20 Mod  axcp120_ins_xcbb_t--> axcp120_tmp03
                 CALL cl_err()
                 RETURN r_success
              END IF
#只有单身的，低价码+1              
              LET l_sql = "INSERT INTO axcp120_tmp03 ",               #160727-00019#20 Mod  axcp120_ins_xcbb_t--> axcp120_tmp03
                          " SELECT DISTINCT imaa0012,xcbb0042,",l_level,"+1 FROM axcp120_tmp07"       #160727-00019#20 Mod  axcp120_imaa_tmp2--> axcp120_tmp07
              PREPARE axcp120_ins_xcbb_p1 FROM l_sql
              EXECUTE axcp120_ins_xcbb_p1
              IF SQLCA.sqlcode THEN
                 LET r_success = FALSE
                 INITIALIZE g_errparam TO NULL
                 LET g_errparam.code = SQLCA.sqlcode
                 LET g_errparam.extend ='INS axcp120_tmp03'           #160727-00019#20 Mod  axcp120_ins_xcbb_t--> axcp120_tmp03
                 CALL cl_err()
                 RETURN r_success
              END IF
           END IF
           EXIT WHILE
        END IF
         
        #更新这些料号的低阶码
        LET l_sql = " MERGE INTO axcp120_tmp03 T1 ",   #160727-00019#20 Mod  axcp120_ins_xcbb_t--> axcp120_tmp03
                    " USING axcp120_tmp06 T2 ",           #160727-00019#20 Mod  axcp120_imaa_tmp1--> axcp120_tmp06
                    "    ON (T1.imag001 = T2.imaa0011 AND T1.xcbb004 = T2.xcbb0041)",
                    " WHEN MATCHED THEN UPDATE SET T1.xcbb006 = '",l_level,"'", 
                    "                    WHERE T1.xcbb006 < '",l_level,"'",
                    " WHEN NOT MATCHED THEN INSERT VALUES (T2.imaa0011,T2.xcbb0041,'",l_level,"')"        
       
        PREPARE axcp120_merge_xcbb FROM l_sql
        EXECUTE axcp120_merge_xcbb       
        IF SQLCA.sqlcode THEN
           LET r_success = FALSE
           INITIALIZE g_errparam TO NULL
           LET g_errparam.code = SQLCA.sqlcode
           LET g_errparam.extend ='MERGE axcp120_tmp03'         #160727-00019#20 Mod  axcp120_ins_xcbb_t--> axcp120_tmp03
           CALL cl_err()
           RETURN r_success
        END IF

        #把这些料号从基准表中剔除掉，同时从关系表中剔除掉以其为父料件的关系记录
        DELETE FROM axcp120_tmp05 WHERE EXISTS (SELECT 1 FROM axcp120_tmp06 WHERE imaa0011 = imaa001 AND xcbb0041 = xcbb004)      #160727-00019#20 Mod  axcp120_imaa_tmp1--> axcp120_tmp06,axcp120_imaa_tmp--> axcp120_tmp05
        DELETE FROM axcp120_tmp04 WHERE EXISTS ( SELECT 1 FROM axcp120_tmp06 WHERE imaa0011 = sfaa010 AND xcbb0041 = sfaa011)     #160727-00019#20 Mod  axcp120_sfaa_tmp--> axcp120_tmp04，axcp120_imaa_tmp1--> axcp120_tmp06

        #清空axcp120_tmp06
        DELETE FROM axcp120_tmp06            #160727-00019#20 Mod  axcp120_imaa_tmp1--> axcp120_tmp06

        IF l_level >= g_master.level THEN
           LET r_success = FALSE
           INITIALIZE g_errparam TO NULL
           LET g_errparam.code = 'axc-00720'
           LET g_errparam.extend =''
           CALL cl_err()#超过预设最大展开层数
           RETURN r_success        
        END IF
        #低阶码循环累加
        LET l_level=l_level+1 

   END WHILE   
   RETURN r_success
END FUNCTION

################################################################################
# Descriptions...: 新增/查詢時，預帶預帶法人、年度、期別欄位欄位
# Memo...........:
# Usage..........: CALL axcp120_head_default()
# Input parameter: 
# Return code....: 
# Date & Author..: 20151022 By dorislai
# Modify.........:
################################################################################
PRIVATE FUNCTION axcp120_head_default()
   DEFINE l_comp        LIKE xccc_t.xccccomp
   DEFINE l_ld          LIKE xccc_t.xcccld
   DEFINE l_year        LIKE xccc_t.xccc004
   DEFINE l_period      LIKE xccc_t.xccc005
   DEFINE l_calc_type   LIKE xccc_t.xccc003


   CALL s_axc_set_site_default() RETURNING l_comp,l_ld,l_year,l_period,l_calc_type
   IF cl_null(g_master.imagsite) THEN
      LET g_master.imagsite = l_comp
      DISPLAY BY NAME g_master.imagsite
   END IF
   IF cl_null(g_master.year) THEN
      LET g_master.year = l_year
      DISPLAY BY NAME g_master.year
   END IF
   IF cl_null(g_master.month) THEN
      LET g_master.month = l_period
      DISPLAY BY NAME g_master.month
   END IF
   
   
END FUNCTION

#end add-point
 
{</section>}
 
