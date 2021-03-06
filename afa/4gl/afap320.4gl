#該程式未解開Section, 採用最新樣板產出!
{<section id="afap320.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0010(2014-12-07 16:18:48), PR版次:0010(2016-12-15 17:28:13)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000106
#+ Filename...: afap320
#+ Description: 固定資產月結還原作業
#+ Creator....: 01531(2014-12-07 16:14:58)
#+ Modifier...: 01531 -SD/PR- 02481
 
{</section>}
 
{<section id="afap320.global" >}
#應用 p02 樣板自動產生(Version:22)
#add-point:填寫註解說明 name="global.memo"
#Memos
#160125-00005#7   2016/08/10  By 01531  查詢時加上帳套人員權限條件過濾
#161024-00008#2   2016/10/24 By Hans     AFA組織類型與職能開窗清單調整。
#161111-00028#6   2016/11/21 by 06189    标准程式定义采用宣告模式,弃用.*写
#161123-00011#4   2016/11/24 By 01531    還原或重新執行時, 檢核是否有異動資料時，排除作廢單據的資料。
#161208-00009#1   2016/12/09 By 01531    afap320和afap310一样做管控，‘次月已有折旧、出售等异动资料，不可执行月结还原’
#161215-00044#1   2016/12/15 by 02481    标准程式定义采用宣告模式,弃用.*写
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
   glaald        LIKE glaa_t.glaald,
   glaald_desc   LIKE type_t.chr500,
   glaacomp      LIKE glaa_t.glaacomp,   
   glaacomp_desc LIKE type_t.chr500
                  END RECORD
 
DEFINE l_para_data           LIKE type_t.chr80
DEFINE g_detail_idx          LIKE type_t.num5              #單身目前所在筆數
DEFINE g_rec_b               LIKE type_t.num5                     
 TYPE type_master RECORD
   faansite      LIKE faan_t.faansite, 
   faansite_desc LIKE type_t.chr500, 
   faan001       LIKE faan_t.faan001, 
   faan002       LIKE faan_t.faan002, 
   stagenow      LIKE type_t.chr80,
       wc               STRING
                   END RECORD
DEFINE g_master    type_master
DEFINE g_master_t  type_master
#161215-00044#1---modify----begin-----------------
#DEFINE g_glaa      RECORD LIKE glaa_t.* 
 DEFINE g_glaa RECORD  #帳套資料檔
        glaaent LIKE glaa_t.glaaent, #企业编号
        glaaownid LIKE glaa_t.glaaownid, #资料所有者
        glaaowndp LIKE glaa_t.glaaowndp, #资料所有部门
        glaacrtid LIKE glaa_t.glaacrtid, #资料录入者
        glaacrtdp LIKE glaa_t.glaacrtdp, #资料录入部门
        glaacrtdt LIKE glaa_t.glaacrtdt, #资料创建日
        glaamodid LIKE glaa_t.glaamodid, #资料更改者
        glaamoddt LIKE glaa_t.glaamoddt, #最近更改日
        glaastus LIKE glaa_t.glaastus, #状态码
        glaald LIKE glaa_t.glaald, #账套编号
        glaacomp LIKE glaa_t.glaacomp, #归属法人
        glaa001 LIKE glaa_t.glaa001, #使用币种
        glaa002 LIKE glaa_t.glaa002, #汇率参照表号
        glaa003 LIKE glaa_t.glaa003, #会计周期参照表号
        glaa004 LIKE glaa_t.glaa004, #会计科目参照表号
        glaa005 LIKE glaa_t.glaa005, #现金变动参照表号
        glaa006 LIKE glaa_t.glaa006, #月结方式
        glaa007 LIKE glaa_t.glaa007, #年结方式
        glaa008 LIKE glaa_t.glaa008, #平行记账否
        glaa009 LIKE glaa_t.glaa009, #凭证登录方式
        glaa010 LIKE glaa_t.glaa010, #现行年度
        glaa011 LIKE glaa_t.glaa011, #现行期别
        glaa012 LIKE glaa_t.glaa012, #最后过账日期
        glaa013 LIKE glaa_t.glaa013, #关账日期
        glaa014 LIKE glaa_t.glaa014, #主账套
        glaa015 LIKE glaa_t.glaa015, #启用本位币二
        glaa016 LIKE glaa_t.glaa016, #本位币二
        glaa017 LIKE glaa_t.glaa017, #本位币二换算基准
        glaa018 LIKE glaa_t.glaa018, #本位币二汇率采用
        glaa019 LIKE glaa_t.glaa019, #启用本位币三
        glaa020 LIKE glaa_t.glaa020, #本位币三
        glaa021 LIKE glaa_t.glaa021, #本位币三换算基准
        glaa022 LIKE glaa_t.glaa022, #本位币三汇率采用
        glaa023 LIKE glaa_t.glaa023, #次账套账务生成时机
        glaa024 LIKE glaa_t.glaa024, #单据别参照表号
        glaa025 LIKE glaa_t.glaa025, #本位币一汇率采用
        glaa026 LIKE glaa_t.glaa026, #币种参照表号
        glaa100 LIKE glaa_t.glaa100, #凭证录入时自动按缺号生成
        glaa101 LIKE glaa_t.glaa101, #凭证总号录入时机
        glaa102 LIKE glaa_t.glaa102, #凭证成立时,借贷不平衡的处理方式
        glaa103 LIKE glaa_t.glaa103, #未打印的凭证可否进行过账
        glaa111 LIKE glaa_t.glaa111, #应计调整单别
        glaa112 LIKE glaa_t.glaa112, #期末结转单别
        glaa113 LIKE glaa_t.glaa113, #年底结转单别
        glaa120 LIKE glaa_t.glaa120, #成本计算类型
        glaa121 LIKE glaa_t.glaa121, #子模块启用分录底稿
        glaa122 LIKE glaa_t.glaa122, #总账可维护资金异动明细
        glaa027 LIKE glaa_t.glaa027, #单据据点编号
        glaa130 LIKE glaa_t.glaa130, #合并账套否
        glaa131 LIKE glaa_t.glaa131, #分层合并
        glaa132 LIKE glaa_t.glaa132, #平均汇率计算方式
        glaa133 LIKE glaa_t.glaa133, #非T100公司导入余额类型
        glaa134 LIKE glaa_t.glaa134, #合并科目转换依据异动码设置值
        glaa135 LIKE glaa_t.glaa135, #现流表间接法群组参照表号
        glaa136 LIKE glaa_t.glaa136, #应收账款核销限定己立账凭证
        glaa137 LIKE glaa_t.glaa137, #应付账款核销限定已立账凭证
        glaa138 LIKE glaa_t.glaa138, #合并报表编制期别
        glaa139 LIKE glaa_t.glaa139, #递延收入(负债)管理生成否
        glaa140 LIKE glaa_t.glaa140, #无原出货单的递延负债减项者,是否仍立递延收入管理?
        glaa123 LIKE glaa_t.glaa123, #应收帐款核销可维护资金异动明细
        glaa124 LIKE glaa_t.glaa124, #应付帐款核销可维护资金异动明细
        glaa028 LIKE glaa_t.glaa028  #汇率来源
        END RECORD
 #161215-00044#1---modify----end-----------------
DEFINE g_wc_cs_orga   STRING      #160125-00005#7
#end add-point
 
#add-point:自定義客戶專用模組變數(Module Variable) name="global.variable_customerization"

#end add-point
DEFINE g_detail_cnt         LIKE type_t.num10              #單身 總筆數(所有資料)
DEFINE g_detail_d  DYNAMIC ARRAY OF type_g_detail_d
 
#add-point:傳入參數說明 name="global.argv"
 
#end add-point
 
{</section>}
 
{<section id="afap320.main" >}
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
   CALL cl_ap_init("afa","")
 
   #add-point:定義背景狀態與整理進入需用參數ls_js name="main.background"
   
   #end add-point
 
   IF g_bgjob = "Y" THEN
      #add-point:Service Call name="main.servicecall"
      
      #end add-point
   ELSE
      #畫面開啟 (identifier)
      OPEN WINDOW w_afap320 WITH FORM cl_ap_formpath("afa",g_code)
   
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
   
      #程式初始化
      CALL afap320_init()   
 
      #進入選單 Menu (="N")
      CALL afap320_ui_dialog() 
 
      #add-point:畫面關閉前 name="main.before_close"
      
      #end add-point
      #畫面關閉
      CLOSE WINDOW w_afap320
   END IF 
   
   #add-point:作業離開前 name="main.exit"
   
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
END MAIN
 
{</section>}
 
{<section id="afap320.init" >}
#+ 畫面資料初始化
PRIVATE FUNCTION afap320_init()
   #add-point:init段define(客製用) name="init.define_customerization"
   
   #end add-point   
   #add-point:init段define name="init.define"
   DEFINE l_array DYNAMIC ARRAY OF RECORD
                  value       STRING,
                  label_tag   STRING,
                  label       STRING
              END RECORD
   DEFINE i       LIKE type_t.num5
   #end add-point   
   
   LET g_error_show  = 1
   LET g_wc_filter   = " 1=1"
   LET g_wc_filter_t = " 1=1"
 
   #add-point:畫面資料初始化 name="init.init"
   #CALL cl_set_combo_scc('faan001','43')
   #CALL cl_set_combo_scc('faan002','8861')
   CALL s_fin_set_comp_scc('faan001','43')
   CALL s_fin_create_account_center_tmp() 
   #营运据点范围
   CALL s_axrt300_get_site(g_user,'','1') RETURNING g_wc_cs_orga #160125-00005#7     
   #end add-point
   
END FUNCTION
 
{</section>}
 
{<section id="afap320.ui_dialog" >}
#+ 選單功能實際執行處
PRIVATE FUNCTION afap320_ui_dialog()
   #add-point:ui_dialog段define(客製用) name="ui_dialog.define_customerization"
   
   #end add-point 
   DEFINE li_idx   LIKE type_t.num10
   #add-point:ui_dialog段define name="init.init"
 
   DEFINE l_faan001   LIKE faan_t.faan001
   DEFINE l_faan002   LIKE faan_t.faan002
   DEFINE l_site      LIKE faan_t.faansite
   DEFINE l_success   LIKE type_t.chr1
   DEFINE l_cnt       LIKE type_t.num5
   DEFINE l_i         LIKE type_t.num5   
   #end add-point 
   
   LET gwin_curr = ui.Window.getCurrent()
   LET gfrm_curr = gwin_curr.getForm()   
   
   LET g_action_choice = " "  
   CALL cl_set_act_visible("accept,cancel", FALSE)
         
   LET g_detail_cnt = g_detail_d.getLength()
   #add-point:ui_dialog段before dialog name="ui_dialog.before_dialog"
   
   #end add-point
   
   WHILE TRUE
 
      IF g_action_choice = "logistics" THEN
         #清除畫面及相關資料
         CLEAR FORM
         CALL g_detail_d.clear()
         LET g_wc  = ' 1=2'
         LET g_wc2 = ' 1=1'
         LET g_action_choice = ""
         CALL afap320_init()
      END IF
 
      DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
         #add-point:ui_dialog段construct name="ui_dialog.more_construct"
         
         #end add-point
         #add-point:ui_dialog段input name="ui_dialog.more_input"
         INPUT BY NAME g_master.faansite,g_master.faan001,g_master.faan002 
            ATTRIBUTE(WITHOUT DEFAULTS)
            
         BEFORE INPUT
               IF cl_null(g_master_t.faansite) THEN
                  CALL afap320_def()
               ELSE
                  LET g_master.* = g_master_t.*
               END IF
               DISPLAY g_master.faansite,g_master.faansite_desc,g_master.faan001,g_master.faan002
                    TO faansite,faansite_desc,faan001,faan002

         BEFORE FIELD faansite
            LET l_site = g_master.faansite
               
         AFTER FIELD faansite
            IF NOT cl_null(g_master.faansite) THEN
               #資料存在性、有效性檢查
               LET g_errno = ' '
               CALL s_fin_account_center_chk(g_master.faansite,'',5,g_today) RETURNING l_success,g_errno
               IF NOT cl_null(g_errno) THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = g_master.faansite
                  LET g_errparam.code   = g_errno
                  LET g_errparam.popup  = TRUE 
                  CALL cl_err()
                  LET g_master.faansite = l_site
                  CALL s_desc_get_department_desc(g_master.faansite) RETURNING g_master.faansite_desc
                  DISPLAY g_master.faansite_desc TO faansite_desc
                  NEXT FIELD CURRENT
               END IF
            END IF
            #161024-00008#2---s---
            IF s_chr_get_index_of(g_wc_cs_orga,g_master.faansite,1) = 0 THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = g_master.faansite
               LET g_errparam.code = 'afa-00291'
               LET g_errparam.popup  = TRUE 
               CALL cl_err()
               LET g_master.faansite = l_site
               CALL s_desc_get_department_desc(g_master.faansite) RETURNING g_master.faansite_desc
               DISPLAY g_master.faansite_desc TO faansite_desc
               NEXT FIELD CURRENT
            END IF
            #161024-00008#2---e---
            LET g_master.faan001 = cl_get_para(g_enterprise,g_master.faansite,'S-FIN-9018')    
            LET g_master.faan002 = cl_get_para(g_enterprise,g_master.faansite,'S-FIN-9019')
            CALL s_desc_get_department_desc(g_master.faansite) RETURNING g_master.faansite_desc
            DISPLAY g_master.faansite_desc TO faansite_desc

         BEFORE FIELD faan001
            LET l_faan001 = g_master.faan001

         ON CHANGE faan001
            IF NOT cl_null(g_master.faan001) THEN
               CALL afap320_date_chk()
               IF NOT cl_null(g_errno) THEN
                  LET g_errparam.extend = ''
                  LET g_errparam.code   = g_errno
                  LET g_errparam.popup  = TRUE 
                  CALL cl_err()
#                  LET g_master.faan001 = l_faan001
                  NEXT FIELD CURRENT
               END IF
               IF NOT cl_null(g_master.faan002) THEN
                  CALL afap320_b_fill()
               END IF
            END IF

         BEFORE FIELD faan002
            LET l_faan002 = g_master.faan002

         ON CHANGE faan002
            IF NOT cl_null(g_master.faan002) THEN
               CALL afap320_date_chk()
               IF NOT cl_null(g_errno) THEN
                  LET g_errparam.extend = ''
                  LET g_errparam.code   = g_errno
                  LET g_errparam.popup  = TRUE 
                  CALL cl_err()
#                  LET g_master.faan002 = l_faan002
                  NEXT FIELD CURRENT
               END IF
               IF NOT cl_null(g_master.faan001) THEN
                  CALL afap320_b_fill()
               END IF
            END IF
               
         ON ACTION controlp INFIELD faansite
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_master.faansite             #給予default值
            LET g_qryparam.where = " ooef201 = 'Y' "
             #160125-00005#7--add--str--
             IF NOT cl_null(g_wc_cs_orga) THEN
			       LET g_qryparam.where = g_wc_cs_orga
			    END IF
			    #160125-00005#7--add--end              
            #CALL q_ooef001()                                #呼叫開窗#161024-00008#2
            CALL q_ooef001_47()                                      #161024-00008#2
            LET g_master.faansite = g_qryparam.return1               
            DISPLAY g_master.faansite TO faansite              #
            CALL s_desc_get_department_desc(g_master.faansite) RETURNING g_master.faansite_desc
            DISPLAY BY NAME g_master.faansite_desc
            NEXT FIELD faansite                         #返回原欄位
 
         END INPUT
         INPUT ARRAY g_detail_d FROM s_detail1.*
             ATTRIBUTE(COUNT = g_detail_cnt,MAXCOUNT = g_max_rec,WITHOUT DEFAULTS,
                       INSERT ROW = FALSE,
                       DELETE ROW = FALSE,
                       APPEND ROW = FALSE) 
            ON CHANGE sel
               LET l_ac = ARR_CURR()


               #因更新aoos020时是根据主帐套的归属法人更新的，所以需确保勾选的归属法人有勾选主帐套资料，不然不可月结还原
               #如果更新为N时，检查该帐套是否是主帐套
               #若非主帐套，则可取消勾选
               #若是主帐套，则需检查该归属法人下的非主帐套是否勾选
               #若勾选则不可取消勾选，若没有勾选则可取消  
               SELECT glaacomp,glaa014 INTO g_glaa.glaacomp,g_glaa.glaa014 FROM glaa_t 
                WHERE glaaent = g_enterprise AND glaald = g_detail_d[l_ac].glaald 
               LET l_cnt = 0
               FOR l_i = 1 TO g_detail_d.getLength()
                  IF g_detail_d[l_i].sel = "Y" THEN
                     IF g_glaa.glaacomp = g_detail_d[l_i].glaacomp THEN
                        LET l_cnt = l_cnt + 1
                     END IF
                  END IF                        
               END FOR                 
               IF g_detail_d[l_ac].sel = 'N' THEN
                  IF g_glaa.glaa014 = 'Y' THEN
                     IF l_cnt >= 1 THEN 
                        INITIALIZE g_errparam TO NULL
                        LET g_errparam.code = 'afa-00407'
                        LET g_errparam.extend = ''
                        LET g_errparam.popup = TRUE
                        CALL cl_err()
                        
                        LET g_detail_d[l_ac].sel = 'Y'                   
                     END IF                     
                  END IF                  
               ELSE
                  IF g_glaa.glaa014 = 'N' THEN
                     IF l_cnt <= 1 THEN 
                        INITIALIZE g_errparam TO NULL
                        LET g_errparam.code = 'afa-00411'
                        LET g_errparam.extend = ''
                        LET g_errparam.popup = TRUE
                        CALL cl_err()
                        
                        LET g_detail_d[l_ac].sel = 'N'                   
                     END IF 
                  END IF 
               END IF
               DISPLAY g_detail_d[l_ac].sel TO sel
               NEXT FIELD sel    
               
               IF g_detail_d[l_ac].sel = 'Y' THEN
                  CALL afap320_clik_chk(l_ac)
                  IF NOT cl_null(g_errno) THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = g_errno
                     LET g_errparam.extend = ''
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                     LET g_detail_d[l_ac].sel = 'N'
                     DISPLAY g_detail_d[l_ac].sel TO sel
                     NEXT FIELD sel                     
                  END IF
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
      
            #end add-point
 
         #選擇全部
         ON ACTION selall
            CALL DIALOG.setSelectionRange("s_detail1", 1, -1, 1)
            #add-point:ui_dialog段on action selall name="ui_dialog.selall.befroe"
            
            #end add-point            
            FOR li_idx = 1 TO g_detail_d.getLength()
               LET g_detail_d[li_idx].sel = "Y"
               #add-point:ui_dialog段on action selall name="ui_dialog.for.onaction_selall"
#               CALL afap320_clik_chk(li_idx)
#               IF NOT cl_null(g_errno) THEN
#                  LET g_detail_d[li_idx].sel = 'N'                    
#               END IF
               #end add-point
            END FOR
            #add-point:ui_dialog段on action selall name="ui_dialog.onaction_selall"
            
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
            FOR li_idx = 1 TO g_detail_d.getLength()
               IF DIALOG.isRowSelected("s_detail1", li_idx) THEN
                  LET g_detail_d[li_idx].sel = "Y"
                  CALL afap320_clik_chk(li_idx)
                  IF NOT cl_null(g_errno) THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = g_errno
                     LET g_errparam.extend = ''
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                     LET g_detail_d[li_idx].sel = 'N'                     
                  END IF
               END IF
            END FOR
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
            CALL afap320_filter()
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
            CALL afap320_query()
             
         # 條件清除
         ON ACTION qbeclear
            #add-point:ui_dialog段 name="ui_dialog.qbeclear"
            
            #end add-point
 
         # 重新整理
         ON ACTION datarefresh
            LET g_error_show = 1
            #add-point:ui_dialog段datarefresh name="ui_dialog.datarefresh"
            
            #end add-point
            CALL afap320_b_fill()
 
         #add-point:ui_dialog段action name="ui_dialog.more_action"
         ON ACTION batch_execute
            CALL afap320_cycle_ld()
            CALL afap320_b_fill()            
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
 
{<section id="afap320.query" >}
#+ QBE資料查詢
PRIVATE FUNCTION afap320_query()
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
   CALL afap320_b_fill()
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
 
{<section id="afap320.b_fill" >}
#+ 單身陣列填充
PRIVATE FUNCTION afap320_b_fill()
   #add-point:b_fill段define(客製用) name="b_fill.define_customerization"
   
   #end add-point
   DEFINE ls_wc           STRING
   #add-point:b_fill段define name="b_fill.define"
   DEFINE l_ooef017        LIKE ooef_t.ooef017
   DEFINE l_cnt            LIKE type_t.num5
   DEFINE l_glaa003        LIKE glaa_t.glaa003
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
   DEFINE l_success        LIKE type_t.chr1  
   DEFINE l_ld_str         STRING                 #160125-00005#7   
   #end add-point
 
   LET g_wc = g_wc, cl_sql_auth_filter()   #(ver:21) add cl_sql_auth_filter()
 
   #add-point:b_fill段sql_before name="b_fill.sql_before"
#160125-00005#7--mod--str
#   #取得帳務組織下所屬成員
#   CALL s_fin_account_center_sons_query('3',g_master.faansite,g_today,'1')
#   #取得帳務組織下所屬成員之帳別   
#   CALL s_fin_account_center_ld_str() RETURNING ls_wc
#   #將取回的字串轉換為SQL條件
#   CALL s_fin_get_wc_str(ls_wc) RETURNING ls_wc
#   LET g_sql =" SELECT 'Y',glaald,'',glaacomp,'' FROM glaa_t ",
#              "  WHERE glaaent = ? ",
#              "    AND glaald IN ",ls_wc,    
#              "  ORDER BY glaald,glaacomp "   
   CALL s_fin_account_center_sons_query('5',g_master.faansite,g_today,'1')
   CALL s_fin_account_center_comp_str() RETURNING ls_wc
   CALL s_fin_get_wc_str(ls_wc) RETURNING ls_wc
   LET ls_wc=ls_wc.substring(3,ls_wc.getLength()-2)
   #账套范围
   CALL s_axrt300_get_site(g_user,ls_wc,'2')  RETURNING l_ld_str 
   
   LET g_sql =" SELECT 'Y',glaald,'',glaacomp,'' FROM glaa_t ",
              "  WHERE glaaent = ? "
              
   IF NOT cl_null(l_ld_str) THEN   
      LET g_sql = g_sql, " AND ",l_ld_str
   END IF
   LET g_sql = g_sql,"  ORDER BY glaald,glaacomp "   
#160125-00005#7--mod--end

   #end add-point
 
   PREPARE afap320_sel FROM g_sql
   DECLARE b_fill_curs CURSOR FOR afap320_sel
   
   CALL g_detail_d.clear()
   #add-point:b_fill段其他頁簽清空 name="b_fill.clear"
   
   #end add-point
 
   LET g_cnt = l_ac
   LET l_ac = 1   
   ERROR "Searching!" 
 
   FOREACH b_fill_curs USING g_enterprise INTO 
   #add-point:b_fill段foreach_into name="b_fill.foreach_into"
   g_detail_d[l_ac].sel,g_detail_d[l_ac].glaald,g_detail_d[l_ac].glaald_desc,
   g_detail_d[l_ac].glaacomp,g_detail_d[l_ac].glaacomp_desc
    
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
      CALL s_axrt300_xrca_ref('xrcald',g_detail_d[l_ac].glaald,'','')
         RETURNING l_success,g_detail_d[l_ac].glaald_desc
      LET g_detail_d[l_ac].glaald_desc = g_detail_d[l_ac].glaald,"(",g_detail_d[l_ac].glaald_desc,")"

      CALL s_axrt300_xrca_ref('xrcasite',g_detail_d[l_ac].glaacomp,'','')
         RETURNING l_success,g_detail_d[l_ac].glaacomp_desc
      LET g_detail_d[l_ac].glaacomp_desc = g_detail_d[l_ac].glaacomp,"(",g_detail_d[l_ac].glaacomp_desc,")"       

      #end add-point
      
      CALL afap320_detail_show()      
 
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
   FREE afap320_sel
   
   LET l_ac = 1
   CALL afap320_fetch()
   #add-point:b_fill段資料填充(其他單身) name="b_fill.after_b_fill"
   
   #end add-point
 
END FUNCTION
 
{</section>}
 
{<section id="afap320.fetch" >}
#+ 單身陣列填充2
PRIVATE FUNCTION afap320_fetch()
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
 
{<section id="afap320.detail_show" >}
#+ 顯示相關資料
PRIVATE FUNCTION afap320_detail_show()
   #add-point:show段define(客製用) name="detail_show.define_customerization"
   
   #end add-point
   #add-point:show段define name="detail_show.define"
   
   #end add-point
   
   #add-point:detail_show段 name="detail_show.detail_show"
   
   #end add-point
 
END FUNCTION
 
{</section>}
 
{<section id="afap320.filter" >}
#+ filter過濾功能
PRIVATE FUNCTION afap320_filter()
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
   
   CALL afap320_b_fill()
   
END FUNCTION
 
{</section>}
 
{<section id="afap320.filter_parser" >}
#+ filter欄位解析
PRIVATE FUNCTION afap320_filter_parser(ps_field)
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
 
{<section id="afap320.filter_show" >}
#+ Browser標題欄位顯示搜尋條件
PRIVATE FUNCTION afap320_filter_show(ps_field,ps_object)
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
   LET ls_condition = afap320_filter_parser(ps_field)
   IF NOT cl_null(ls_condition) THEN
      LET ls_title = ls_title, '※', ls_condition, '※'
   END IF
 
   #將資料顯示回去
   CALL lnode_item.setAttribute("text",ls_title)
 
END FUNCTION
 
{</section>}
 
{<section id="afap320.other_function" readonly="Y" >}
#add-point:自定義元件(Function) name="other.function"

################################################################################
# Descriptions...:  
# Memo...........:
# Usage..........: CALL afap320_def()
# Input parameter:  
# Date & Author..: 2014/12/01 By 01531
# Modify.........:
################################################################################
PRIVATE FUNCTION afap320_def()
   DEFINE l_success         LIKE type_t.chr1
 

   IF NOT cl_null(g_master.faansite) THEN RETURN END IF
   #帳務中心
   #取得預設的帳務中心,因新增階段的時候,並不會知道site,所以以登入人員做為依據
   CALL s_fin_get_account_center('',g_user,'5',g_today) RETURNING l_success,g_master.faansite,g_errno
   CALL s_desc_get_department_desc(g_master.faansite) RETURNING g_master.faansite_desc

   LET g_master.faan001 = cl_get_para(g_enterprise,g_master.faansite,'S-FIN-9018')    
   LET g_master.faan002 = cl_get_para(g_enterprise,g_master.faansite,'S-FIN-9019')
 
END FUNCTION

################################################################################
# Descriptions...:  
# Memo...........:
# Usage..........: CALL afap320_date_chk()
# Input parameter:  
# Date & Author..: 2014/12/01 By 01531
# Modify.........:
################################################################################
PRIVATE FUNCTION afap320_date_chk()
   DEFINE l_flag         LIKE type_t.dat
   DEFINE l_faan001      LIKE faan_t.faan001
   DEFINE l_faan002      LIKE faan_t.faan002

   IF cl_null(g_master.faansite) THEN RETURN END IF
   IF cl_null(g_master.faan001) THEN RETURN END IF
   IF cl_null(g_master.faan002) THEN RETURN END IF

   LET l_flag = cl_get_para(g_enterprise,g_master.faansite,'S-FIN-9003')   #关账日期

   LET l_faan001 = YEAR(l_flag)
   LET l_faan002 = MONTH(l_flag)

   LET g_errno = ' '
   IF g_master.faan001 < l_faan001 THEN
      LET g_errno = 'anm-00248'
   END IF

   IF g_master.faan001 = l_faan001  AND g_master.faan002 < l_faan002 THEN
      LET g_errno = 'anm-00249'
   END IF
END FUNCTION

################################################################################
# Descriptions...:  
# Memo...........:
# Usage..........: CALL afap320_clik_chk(p_ac)
# Input parameter:  
# Date & Author..: 2014/12/01 By 01531
# Modify.........:
################################################################################
PRIVATE FUNCTION afap320_clik_chk(p_ac)
   DEFINE p_ac             LIKE type_t.num5
   DEFINE l_count          LIKE type_t.num5
   DEFINE l_yy             LIKE faan_t.faan001
   DEFINE l_mm             LIKE faan_t.faan002
   DEFINE l_glaa003        LIKE glaa_t.glaa003
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
   DEFINE l_prog           LIKE type_t.chr10
   DEFINE l_fabg005        LIKE fabg_t.fabg005   
   DEFINE l_faah003        LIKE faah_t.faah003
   DEFINE l_faah004        LIKE faah_t.faah004
   DEFINE l_faah001        LIKE faah_t.faah001
   DEFINE l_faan001        LIKE faan_t.faan001
   DEFINE l_faan002        LIKE faan_t.faan002
   DEFINE l_errmsg         STRING
   DEFINE l_month          LIKE type_t.chr20   #161208-00009#1 add
   DEFINE l_cnt            LIKE type_t.num5    #161208-00009#1 add
   LET g_errno = NULL
   IF cl_null(p_ac) OR p_ac <= 0 THEN
      RETURN 
   END IF

 
   
   #檢核 帳別+年度+期別 不存在月结资料提示
   LET l_count = 0
   SELECT COUNT(*) INTO l_count FROM faan_t
    WHERE faanent = g_enterprise
      AND faanld  = g_detail_d[p_ac].glaald
      AND faan001 = g_master.faan001
      AND faan002 = g_master.faan002
   IF cl_null(l_count) THEN LET l_count = 0 END IF
   IF l_count = 0 THEN
      LET g_errno   = 'afa-00409'
      RETURN
   END IF   

#   #现行年度期别跟单头输入的会计年度期别不一致   
# 
#   LET l_count = 0
# 
#   SELECT COUNT(*) INTO l_count FROM faan_t
#    WHERE faanent = g_enterprise
#      AND faanld  = g_detail_d[p_ac].glaald
#      AND ((faan001 = g_master.faan001 AND faan002 > g_master.faan002) OR (faan001 > g_master.faan001))   
#   IF cl_null(l_count) THEN LET l_count = 0 END IF
#   IF l_count > 0  THEN
#      LET g_errno   = 'afa-00408'
#      RETURN
#   END IF     
 

   #檢核 帳別+年度+期別 檢查是否有折旧傳票
   LET l_count = NULL
   SELECT COUNT(*) INTO l_count FROM fabg_t
    WHERE fabgent = g_enterprise
      AND fabgld  = g_detail_d[p_ac].glaald
      AND fabg005 = '0'
      AND fabgstus <> 'X' #161123-00011#4
      AND YEAR(fabg009) = g_master.faan001
      AND MONTH(fabg009) = g_master.faan002
      AND (fabg008 IS NOT NULL OR fabg008 != " ")
   IF cl_null(l_count) THEN LET l_count = 0 END IF
   IF l_count > 0 THEN
      LET g_errno   = 'afa-00316'  
      RETURN
   END IF

   #161208-00009#1 add e---
   #执行本月月结还原时检核次月是否有折旧、出售等各类异动，有就不能执行还原。
   IF g_master.faan002 = '12' THEN 
      LET l_yy = g_master.faan001 + 1
      LET l_mm = 1
   ELSE
      LET l_yy = g_master.faan001
      LET l_mm = g_master.faan002 + 1
   END IF
   
   LET l_month = l_mm
   IF l_month < 10 THEN 
      LET l_month = '0' CLIPPED,l_month
   END IF
   
   LET l_cnt = 0
   SELECT COUNT(*) INTO l_cnt
     FROM fabg_t,fabh_t 
    WHERE fabgent = g_enterprise
      AND fabgent = fabhent 
      AND fabgld = fabhld 
      AND fabgdocno = fabhdocno 
      AND TO_CHAR(fabgdocdt,'YYYY') = l_yy
      AND TO_CHAR(fabgdocdt,'MM') = l_month
      AND fabhld = g_detail_d[p_ac].glaald
      AND fabgstus <> 'X'    
   
   IF l_cnt > 0 THEN
      LET g_errno   = 'afa-01138'  
      RETURN
   END IF
   
   LET l_cnt = 0
   SELECT COUNT(*) INTO l_cnt
     FROM faba_t,fabb_t 
    WHERE fabaent = g_enterprise
      AND fabaent = fabbent 
      AND fabadocno = fabbdocno 
      AND TO_CHAR(fabadocdt,'YYYY') = l_yy
      AND TO_CHAR(fabadocdt,'MM') = l_month
      AND fabacomp = g_glaa_m.glaacomp
      AND fabastus <> 'X'      
   
   IF l_cnt > 0 THEN
      LET g_errno   = 'afa-01138'  
      RETURN
   END IF
 
   #外送,外送收回
   LET l_cnt = 0
   SELECT COUNT(*) INTO l_cnt
     FROM faba_t,fabk_t 
    WHERE fabaent = g_enterprise
      AND fabaent = fabkent 
      AND fabadocno = fabkdocno 
      AND TO_CHAR(fabadocdt,'YYYY') = l_yy
      AND TO_CHAR(fabadocdt,'MM') = l_month
      AND fabacomp = g_glaa_m.glaacomp
      AND fabastus <> 'X'      
   
   IF l_cnt > 0 THEN
      LET g_errno   = 'afa-01138'  
      RETURN
   END IF
   
   #资本化
   LET l_cnt = 0
   SELECT COUNT(*) INTO l_cnt
     FROM faba_t,fabj_t 
    WHERE fabaent = g_enterprise
      AND fabaent = fabjent 
      AND fabadocno = fabjdocno 
      AND TO_CHAR(fabadocdt,'YYYY') = l_yy
      AND TO_CHAR(fabadocdt,'MM') = l_month
      AND fabacomp = g_glaa_m.glaacomp
      AND fabastus <> 'X'     
   
   IF l_cnt > 0 THEN
      LET g_errno   = 'afa-01138'  
      RETURN
   END IF
   
   #合并,分割
   LET l_cnt = 0
   SELECT COUNT(*) INTO l_cnt
     FROM faba_t,fabl_t 
    WHERE fabaent = g_enterprise
      AND fabaent = fablent 
      AND fabadocno = fabldocno 
      AND TO_CHAR(fabadocdt,'YYYY') = l_yy
      AND TO_CHAR(fabadocdt,'MM') = l_month
      AND fabacomp = g_glaa_m.glaacomp
      AND fabastus <> 'X'      
   
   IF l_cnt > 0 THEN
      LET g_errno   = 'afa-01138'  
      RETURN
   END IF
   
   LET l_cnt = 0
   SELECT COUNT(*) INTO l_cnt
     FROM faba_t,fabm_t 
    WHERE fabaent = g_enterprise
      AND fabaent = fabment 
      AND fabadocno = fabmdocno 
      AND TO_CHAR(fabadocdt,'YYYY') = l_yy
      AND TO_CHAR(fabadocdt,'MM') = l_month
      AND fabacomp = g_glaa_m.glaacomp
      AND fabastus <> 'X'      
   
   IF l_cnt > 0 THEN
      LET g_errno   = 'afa-01138'  
      RETURN
   END IF
   
   #折毕再提
   LET l_cnt = 0
   SELECT COUNT(*) INTO l_cnt
     FROM fabg_t,fabd_t 
    WHERE fabgent = g_enterprise
      AND fabgent = fabdent 
      AND fabgld = fabdld 
      AND fabgdocno = fabddocno 
      AND TO_CHAR(fabgdocdt,'YYYY') = l_yy
      AND TO_CHAR(fabgdocdt,'MM') = l_month
      AND fabgld = g_detail_d[p_ac].glaald
      AND fabgstus <> 'X'    
   
   IF l_cnt > 0 THEN
      LET g_errno   = 'afa-01138'  
      RETURN
   END IF
   
   #出售
   LET l_cnt = 0
   SELECT COUNT(*) INTO l_cnt
     FROM fabg_t,fabo_t 
    WHERE fabgent = g_enterprise
      AND fabgent = faboent 
      AND fabgld = fabold 
      AND fabgdocno = fabodocno 
      AND TO_CHAR(fabgdocdt,'YYYY') = l_yy
      AND TO_CHAR(fabgdocdt,'MM') = l_month
      AND fabgld = g_detail_d[p_ac].glaald
      AND fabgstus <> 'X'     
   
   IF l_cnt > 0 THEN
      LET g_errno   = 'afa-01138'  
      RETURN
   END IF
   
   #抵押,解除抵押
   LET l_cnt = 0
   SELECT COUNT(*) INTO l_cnt
     FROM fabg_t,fabq_t 
    WHERE fabgent = g_enterprise
      AND fabgent = fabqent 
      AND fabgld = fabqld 
      AND fabgdocno = fabqdocno 
      AND TO_CHAR(fabgdocdt,'YYYY') = l_yy
      AND TO_CHAR(fabgdocdt,'MM') = l_month
      AND fabgld = g_detail_d[p_ac].glaald
      AND fabgstus <> 'X'      
   
   IF l_cnt > 0 THEN
      LET g_errno   = 'afa-01138'  
      RETURN
   END IF
   
   #盘点
   LET l_cnt = 0
   SELECT COUNT(*) INTO l_cnt
     FROM fabr_t
    WHERE fabrent = g_enterprise
      AND TO_CHAR(fabr031,'YYYY') = l_yy
      AND TO_CHAR(fabr031,'MM') = l_month
      AND fabrcomp = g_detail_d[p_ac].glaald
      AND fabrstus <> 'X'     
   
   IF l_cnt > 0 THEN
      LET g_errno   = 'afa-01138'  
      RETURN
   END IF
   #161208-00009#1 add e---
    
#   #20150206 add by chenying
#   #1:检查是否存在已过账的异动资料
#   #2:检查afai100是否存在新增资料
#   LET g_sql = " SELECT faah001,faah003,faah004",
#               "   FROM faah_t LEFT JOIN faaj_t ",
#               "     ON faajent = faahent AND faah000 = faaj000 ",
#               "    AND faah003 = faaj001 AND faah004 = faaj002 ",
#               "    AND faah001 = faaj037 ",
#               "    AND faah015 NOT IN('10') ", 
#               "  WHERE faahent = '",g_enterprise,"' AND faajld = '",g_detail_d[p_ac].glaald,"'",
#               "    AND faahstus = 'Y' AND faajstus = 'Y' "
#   PREPARE afap320_pr FROM g_sql
#   DECLARE afap320_cs CURSOR FOR afap320_pr   
#   
#   #根据取得日期范围
#   LET g_sql = "SELECT COUNT(*)  FROM faah_t ",
#               " WHERE faahent = '",g_enterprise,"'", 
#               " AND faah001 = ? AND faah003 = ? AND faah004 = ? ", 
#               " AND faahstus = 'Y' " ,
#               " AND faah014 <= '",l_pdate_e,"' AND faah014 >= '",l_pdate_s,"' "
#   PREPARE afap320_pr_faah_count FROM g_sql 
#
#   LET l_glaa003 = NULL   
#   #取得會計週期參照表
#   CALL s_ld_sel_glaa(g_detail_d[l_ac].glaald,'glaa003')
#            RETURNING  g_sub_success,l_glaa003
#   LET l_faan001 = NULL
#   LET l_faan002 = NULL   
#   IF g_master.faan002 = 12 THEN 
#      LET l_faan001 = g_master.faan001 + 1 
#      LET l_faan002 = 1
#   ELSE
#      LET l_faan001 = g_master.faan001
#      LET l_faan002 = g_master.faan002 + 1     
#   END IF    
#   #依年度+期別取得會計週期起迄日
#   CALL s_get_accdate(l_glaa003,'',l_faan001,l_faan002)
#   RETURNING l_flag,l_errno,l_glav002,l_glav005,l_sdate_s,l_sdate_e,
#                l_glav006,l_pdate_s,l_pdate_e,l_glav007,l_wdate_s,l_wdate_e
#
#   LET g_sql = " SELECT fabg005 FROM fabg_t LEFT OUTER JOIN fabh_t ",
#               "     ON fabgent = fabhent AND fabgld = fabhld AND fabgdocno =  fabhdocno ",
#               "  WHERE fabhent = '",g_enterprise,"' AND fabhld = '",g_detail_d[p_ac].glaald,"'",
#               "    AND fabg005 IN('14','6','21','8','9')  AND fabh000 = ? AND fabh001 = ? AND fabh002 = ? ",
#               "    AND fabgdocdt <= '",l_pdate_e,"' AND fabgdocdt >= '",l_pdate_s,"' ", 
#               "    AND fabgstus = 'S' " 
#   PREPARE afap320_pr_fabh FROM g_sql
#   DECLARE afap320_cs_fabh CURSOR FOR afap320_pr_fabh   
#    
#   LET g_sql = " SELECT fabg005 FROM fabg_t LEFT OUTER JOIN fabh_t ",
#               "     ON fabgent = fabhent AND fabgld = fabhld AND fabgdocno =  fabhdocno ",
#               "  WHERE fabhent = '",g_enterprise,"' AND fabhld = '",g_detail_d[p_ac].glaald,"'",
#               "    AND fabg005 IN('12')  AND fabh000 = ? AND fabh001 = ? AND fabh002 = ? ",
#               "    AND fabgdocdt <= '",l_pdate_e,"' AND fabgdocdt >= '",l_pdate_s,"' ", 
#               "    AND fabgstus = 'Y' " 
#   PREPARE afap320_pr_fabh_2 FROM g_sql
#   DECLARE afap320_cs_fabh_2 CURSOR FOR afap320_pr_fabh_2  
#   
#   LET g_sql = " SELECT fabg005 FROM fabg_t LEFT OUTER JOIN fabo_t ",
#               "     ON fabgent = faboent AND fabgld = fabold AND fabgdocno =  fabodocno ",
#               "  WHERE faboent = '",g_enterprise,"' ",
#               "    AND fabg005 IN('4','17') AND fabold = '",g_detail_d[p_ac].glaald,"' AND fabo003 = ? AND fabo001 = ? AND fabo002 = ? ",
#               "    AND fabgdocdt <= '",l_pdate_e,"' AND fabgdocdt >= '",l_pdate_s,"' ", 
#               "    AND fabgstus = 'S' " 
#   PREPARE afap320_pr_fabo FROM g_sql
#   DECLARE afap320_cs_fabo CURSOR FOR afap320_pr_fabo 
#
#   LET g_sql = " SELECT SUM(fabk006) FROM faba_t LEFT OUTER JOIN fabk_t ",
#               "     ON fabaent = fabkent AND fabadocno = fabkdocno ",
#               "  WHERE fabkent = '",g_enterprise,"' AND faba003 IN('10','11') ",
#               "    AND fabk000 = ? AND fabk001 = ? AND fabk002 = ? ",
#               "    AND fabastus = 'Y' ",
#               "    AND fabadocdt <= '",l_pdate_e,"' AND fabadocdt >= '",l_pdate_s,"' "
#   PREPARE afap320_pr_faba FROM g_sql
#   DECLARE afap320_cs_faba CURSOR FOR afap320_pr_faba 
#   
#   
#   LET l_faah001 = NULL
#   LET l_faah003 = NULL
#   LET l_faah004 = NULL
#   FOREACH afap320_cs INTO l_faah001,l_faah003,l_faah004
#      LET l_count = 0
#      EXECUTE afap320_pr_faah_count USING l_faah001,l_faah003,l_faah004 INTO l_count
#      IF l_count = NULL THEN LET l_count = 0 END IF
#      IF l_count > 0 THEN
#         LET l_prog = 'afai100'
#         LET g_errno   = 'afa-00419'  
#         LET l_errmsg = l_prog||'/'||l_faah001||'/'||l_faah003||'/'||l_faah004 
#
#         INITIALIZE g_errparam TO NULL
#         LET g_errparam.extend = l_errmsg
#         LET g_errparam.code   = g_errno
#         LET g_errparam.popup  = TRUE 
#         CALL cl_err()          
#         RETURN               
#      END IF
#      
#      LET l_fabg005 = NULL
#      FOREACH afap320_cs_fabh  USING l_faah001,l_faah003,l_faah004 INTO l_fabg005
#         CASE l_fabg005 
#           WHEN '14' LET l_prog = 'afat502'
#           WHEN '8'  LET l_prog = 'afat503'
#           WHEN '6'  LET l_prog = 'afat506'
#           WHEN '21' LET l_prog = 'afat507'
#           WHEN '9'  LET l_prog = 'afat508'
#         END CASE 
#         LET g_errno   = 'afa-00420'  
#         LET l_errmsg = l_prog||'/'||l_faah001||'/'||l_faah003||'/'||l_faah004 
#         INITIALIZE g_errparam TO NULL
#         LET g_errparam.extend = l_errmsg
#         LET g_errparam.code   = g_errno
#         LET g_errparam.popup  = TRUE 
#         CALL cl_err()            
#      END FOREACH
#      
#      LET l_fabg005 = NULL
#      FOREACH afap320_cs_fabh_2  USING l_faah001,l_faah003,l_faah004 INTO l_fabg005
#         CASE l_fabg005 
#           WHEN '12' LET l_prog = 'afat501'
#         END CASE 
#         LET g_errno   = 'afa-00420'  
#         LET l_errmsg = l_prog||'/'||l_faah001||'/'||l_faah003||'/'||l_faah004 
#         INITIALIZE g_errparam TO NULL
#         LET g_errparam.extend = l_errmsg
#         LET g_errparam.code   = g_errno
#         LET g_errparam.popup  = TRUE 
#         CALL cl_err()            
#      END FOREACH
#    
#      LET l_fabg005 = NULL
#      FOREACH afap320_cs_fabo  USING l_faah001,l_faah003,l_faah004 INTO l_fabg005
#         CASE l_fabg005 
#           WHEN '4'   LET l_prog = 'afat504'
#           WHEN '17'  LET l_prog = 'afat505'
#         END CASE 
#         LET g_errno   = 'afa-00420'  
#         LET l_errmsg = l_prog||'/'||l_faah001||'/'||l_faah003||'/'||l_faah004 
#         INITIALIZE g_errparam TO NULL
#         LET g_errparam.extend = l_errmsg
#         LET g_errparam.code   = g_errno
#         LET g_errparam.popup  = TRUE 
#         CALL cl_err()            
#      END FOREACH 
#
#      LET l_fabg005 = NULL
#      FOREACH afap320_cs_fabo  USING l_faah001,l_faah003,l_faah004 INTO l_fabg005
#         CASE l_fabg005 
#           WHEN '10'   LET l_prog = 'afat440'
#           WHEN '11'   LET l_prog = 'afat450'
#         END CASE 
#         LET g_errno   = 'afa-00420'  
#         LET l_errmsg = l_prog||'/'||l_faah001||'/'||l_faah003||'/'||l_faah004 
#         INITIALIZE g_errparam TO NULL
#         LET g_errparam.extend = l_errmsg
#         LET g_errparam.code   = g_errno
#         LET g_errparam.popup  = TRUE 
#         CALL cl_err()            
#      END FOREACH  
#      
#   END FOREACH
#   
#   
#   RETURN
#   #20150206 add by chenying
END FUNCTION

################################################################################
# Descriptions...:  
# Memo...........:
# Usage..........: CALL afap320_cycle_ld()
# Input parameter:  
# Date & Author..: 2014/12/01 By 01531
# Modify.........:
################################################################################
PRIVATE FUNCTION afap320_cycle_ld()
   DEFINE l_colname_1     STRING  
   DEFINE l_comment_1     STRING  
   DEFINE l_flag1     LIKE type_t.num5
   DEFINE l_i         LIKE type_t.num5
   DEFINE l_cnt       LIKE type_t.num5
   
   CALL s_transaction_begin()  #事务开始
   CALL cl_err_collect_init()  #汇总错误讯息初始化
   CALL s_azzi902_get_gzzd('afat504',"lbl_fabgld") RETURNING l_colname_1,l_comment_1  #帐套
   LET g_coll_title[1] = l_colname_1
   
   LET g_success = 'Y'
   LET l_flag1 = FALSE #是否勾選拋轉帳套
   
   FOR l_i = 1 TO g_detail_d.getLength()
      IF g_detail_d[l_i].sel = "Y" THEN
         LET l_flag1 = TRUE
         #檢查是否有月結資料產生
         CALL afap320_clik_chk(l_i)
         IF NOT cl_null(g_errno) THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = g_errno
            LET g_errparam.extend = g_detail_d[l_i].glaald
            LET g_errparam.popup = TRUE
            CALL cl_err()
            LET g_success = 'N'
            CONTINUE FOR
         END IF
      END IF
   END FOR   
    
   IF g_success = 'Y' THEN
      FOR l_i = 1 TO g_detail_d.getLength()
         IF g_detail_d[l_i].sel = "Y" THEN  
#161215-00044#1---modify----begin-----------------         
#            SELECT * INTO g_glaa.* 
            SELECT glaaent,glaaownid,glaaowndp,glaacrtid,
                   glaacrtdp,glaacrtdt,glaamodid,glaamoddt,
                   glaastus,glaald,glaacomp,
                   glaa001,glaa002,glaa003,glaa004,glaa005,
                   glaa006,glaa007,glaa008,glaa009,glaa010,
                   glaa011,glaa012,glaa013,glaa014,glaa015,
                   glaa016,glaa017,glaa018,glaa019,glaa020,
                   glaa021,glaa022,glaa023,glaa024,glaa025,
                   glaa026,glaa100,glaa101,glaa102,glaa103,
                   glaa111,glaa112,glaa113,glaa120,glaa121,
                   glaa122,glaa027,glaa130,glaa131,glaa132,
                   glaa133,glaa134,glaa135,glaa136,glaa137,
                   glaa138,glaa139,glaa140,glaa123,glaa124,
                   glaa028 
              INTO g_glaa.glaaent,g_glaa.glaaownid,g_glaa.glaaowndp,g_glaa.glaacrtid,
                   g_glaa.glaacrtdp,g_glaa.glaacrtdt,g_glaa.glaamodid,g_glaa.glaamoddt,
                   g_glaa.glaastus,g_glaa.glaald,g_glaa.glaacomp,
                   g_glaa.glaa001,g_glaa.glaa002,g_glaa.glaa003,g_glaa.glaa004,g_glaa.glaa005,
                   g_glaa.glaa006,g_glaa.glaa007,g_glaa.glaa008,g_glaa.glaa009,g_glaa.glaa010,
                   g_glaa.glaa011,g_glaa.glaa012,g_glaa.glaa013,g_glaa.glaa014,g_glaa.glaa015,
                   g_glaa.glaa016,g_glaa.glaa017,g_glaa.glaa018,g_glaa.glaa019,g_glaa.glaa020,
                   g_glaa.glaa021,g_glaa.glaa022,g_glaa.glaa023,g_glaa.glaa024,g_glaa.glaa025,
                   g_glaa.glaa026,g_glaa.glaa100,g_glaa.glaa101,g_glaa.glaa102,g_glaa.glaa103,
                   g_glaa.glaa111,g_glaa.glaa112,g_glaa.glaa113,g_glaa.glaa120,g_glaa.glaa121,
                   g_glaa.glaa122,g_glaa.glaa027,g_glaa.glaa130,g_glaa.glaa131,g_glaa.glaa132,
                   g_glaa.glaa133,g_glaa.glaa134,g_glaa.glaa135,g_glaa.glaa136,g_glaa.glaa137,
                   g_glaa.glaa138,g_glaa.glaa139,g_glaa.glaa140,g_glaa.glaa123,g_glaa.glaa124,
                   g_glaa.glaa028 
#161215-00044#1---modify----end-----------------
            FROM glaa_t WHERE glaaent = g_enterprise AND glaald = g_detail_d[l_i].glaald
            CALL afap320_del_faan(g_detail_d[l_i].glaald,g_detail_d[l_i].glaacomp)
         END IF
      END FOR
   END IF         

   #提示選取預處理資料
   IF l_flag1 = FALSE THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.extend = ''
      LET g_errparam.code   = '-400'
      LET g_errparam.popup  = TRUE 
      CALL cl_err()
      LET g_success = 'N'
   END IF 
#   #判斷是否有月結資料
#   IF g_success = 'N' THEN
#      INITIALIZE g_errparam TO NULL
#      LET g_errparam.extend = ''
#      LET g_errparam.code   = 'axc-00530'
#      LET g_errparam.popup  = TRUE 
#      CALL cl_err()
#      LET g_success = 'N'
#   END IF  

   IF g_success = 'N' THEN
      CALL cl_err_collect_show()
      CALL s_transaction_end('N','0')
   ELSE
      CALL s_transaction_end('Y','0')
      CALL cl_err_collect_init()
      CALL cl_err_collect_show()
      INITIALIZE g_errparam TO NULL
      LET g_errparam.extend = ''
      LET g_errparam.code   = 'axm-00088'
      LET g_errparam.popup  = TRUE 
      CALL cl_err() 
   END IF
END FUNCTION

################################################################################
# Descriptions...:  
# Memo...........:
# Usage..........: CALL afap320_del_faan(p_glaald,p_glaacomp)
# Input parameter:  
# Date & Author..: 2014/12/07 By 01531
# Modify.........:
################################################################################
PRIVATE FUNCTION afap320_del_faan(p_glaald,p_glaacomp)
DEFINE p_glaald   LIKE glaa_t.glaald
DEFINE p_glaacomp LIKE glaa_t.glaacomp
DEFINE l_yy       LIKE faan_t.faan001
DEFINE l_mm       LIKE faan_t.faan002 
DEFINE l_yy_1     LIKE faan_t.faan001
DEFINE l_mm_1     LIKE faan_t.faan002 

 
   DELETE FROM faan_t WHERE faanent = g_enterprise
                        AND faanld = p_glaald
                        AND faan001 = g_master.faan001
                        AND faan002 = g_master.faan002
         IF SQLCA.SQLCODE THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.extend = "del faan_t" 
            LET g_errparam.code   = SQLCA.sqlcode 
            LET g_errparam.popup  = TRUE 
            CALL cl_err()
            LET g_success = 'N'
         END IF    
  
   IF g_glaa.glaa014 = 'Y' THEN 
      LET l_yy = NULL
      LET l_mm = NULL
      LET l_yy = cl_get_para(g_enterprise,p_glaacomp,'S-FIN-9018')
      LET l_mm = cl_get_para(g_enterprise,p_glaacomp,'S-FIN-9019')
      IF l_mm = 1 THEN 
         LET l_yy = l_yy - 1
         LET l_mm = 12
      ELSE
         LET l_yy = l_yy 
         LET l_mm = l_mm - 1               
      END IF 
      
      UPDATE ooab_t SET ooab002 = l_yy  
       WHERE ooabent = g_enterprise
         AND ooab001 = 'S-FIN-9018'
         AND ooabsite = p_glaacomp
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.extend = "upd ooab_t" 
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = TRUE 
         CALL cl_err()
         LET g_success = 'N'
      END IF
      
      UPDATE ooab_t SET ooab002 = l_mm
       WHERE ooabent = g_enterprise
         AND ooab001 = 'S-FIN-9019'
         AND ooabsite = p_glaacomp         
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.extend = "upd ooab_t" 
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = TRUE 
         CALL cl_err()
         LET g_success = 'N'
      END IF
   END IF   
END FUNCTION

#end add-point
 
{</section>}
 
