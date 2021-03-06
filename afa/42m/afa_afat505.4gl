#該程式未解開Section, 採用最新樣板產出!
{<section id="afat505.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0021(2015-04-22 16:28:42), PR版次:0021(2017-01-04 17:14:33)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000148
#+ Filename...: afat505
#+ Description: 資產調撥維護作業
#+ Creator....: 02114(2014-07-28 10:53:16)
#+ Modifier...: 02003 -SD/PR- 04152
 
{</section>}
 
{<section id="afat505.global" >}
#應用 t01 樣板自動產生(Version:79)
#add-point:填寫註解說明 name="global.memo" 
#150731-00004#1   by yangtt  20150826    錯誤信息匯總報錯，將舊的報錯方式(cl_errmsg)改成新的報錯方式
#151125-00001#1   2015/11/27 BY fionchen 執行[作廢]作業時,增加詢問「是否執行作廢？」
#151130-00015#2   2015/12/21 BY taozf    判断 是否可以更改單據日期 設定開放單據日期修改
#151125-00006#2   2015/12/11 by 06421    添加自动审核
#141124-00009#1   2016/03/18 by 07673    修改bug 过账S后，点取消过账，应该把状态码更新为Y
#160318-00005#11  2016/03/25 by 07675    將重複內容的錯誤訊息置換為公用錯誤訊息
#141201-00019#1   2016/03/28 by 07673    修改bug
#160318-00025#5   2016/04/14 By 07675    將重複內容的錯誤訊息置換為公用錯誤訊息(r.v）
#160414-00015#1   2016/04/25 by 07673    复制时清空特定栏位
#141208-00022#1   2016/05/11 By 01531    BMP簽核流程调整
#160613-00011#1   2016/06/14 By 01727    单身录入一行后，报错：ins fabe_t 無法將空插入欄的'欄-名稱'.
#160616-00005#3   2016/06/21 By 01531    #141208-00022#1BUG修复
#160125-00005#7   2016/08/09 By 02599    查詢時加上帳套人員權限條件過濾
#160426-00014#33  2016/08/17 BY 02114    修改权限的问题
#160818-00017#10  2016/08/25 By 07900    删除修改未重新判断状态码
#160829-00042#1   2016/09/06 By Hans     新舊值處理
#161111-00049#12  2016/11/28 By 01531    二阶段FA问题7~14 调整作业:afat450/afat500/afat501/afat502/afat503/afat504/afat505/afat506
#161215-00044#1   2016/12/16 by 02481    标准程式定义采用宣告模式,弃用.*写
#161104-00046#22  2017/01/03 By Reanna   單別預設值;資料依照單別user dept權限過濾單號
#end add-point
#add-point:填寫註解說明(客製用) name="global.memo_customerization"

#end add-point
 
IMPORT os
IMPORT util
IMPORT FGL lib_cl_dlg
#add-point:增加匯入項目 name="global.import"

#end add-point 
 
SCHEMA ds 
 
GLOBALS "../../cfg/top_global.inc"
 
#add-point:增加匯入變數檔 name="global.inc"

#end add-point
 
#單頭 type 宣告
PRIVATE type type_g_fabg_m        RECORD
       fabgsite LIKE fabg_t.fabgsite, 
   fabgsite_desc LIKE type_t.chr80, 
   fabg001 LIKE fabg_t.fabg001, 
   fabg001_desc LIKE type_t.chr80, 
   fabgld LIKE fabg_t.fabgld, 
   fabgld_desc LIKE type_t.chr80, 
   fabg002 LIKE fabg_t.fabg002, 
   fabg002_desc LIKE type_t.chr80, 
   fabg003 LIKE fabg_t.fabg003, 
   fabg003_desc LIKE type_t.chr80, 
   fabg004 LIKE fabg_t.fabg004, 
   fabg005 LIKE fabg_t.fabg005, 
   fabgdocno LIKE fabg_t.fabgdocno, 
   fabgdocdt LIKE fabg_t.fabgdocdt, 
   fabg010 LIKE fabg_t.fabg010, 
   fabg017 LIKE fabg_t.fabg017, 
   fabg018 LIKE fabg_t.fabg018, 
   fabgstus LIKE fabg_t.fabgstus, 
   fabgownid LIKE fabg_t.fabgownid, 
   fabgownid_desc LIKE type_t.chr80, 
   fabgowndp LIKE fabg_t.fabgowndp, 
   fabgowndp_desc LIKE type_t.chr80, 
   fabgcrtid LIKE fabg_t.fabgcrtid, 
   fabgcrtid_desc LIKE type_t.chr80, 
   fabgcrtdp LIKE fabg_t.fabgcrtdp, 
   fabgcrtdp_desc LIKE type_t.chr80, 
   fabgcrtdt LIKE fabg_t.fabgcrtdt, 
   fabgmodid LIKE fabg_t.fabgmodid, 
   fabgmodid_desc LIKE type_t.chr80, 
   fabgmoddt LIKE fabg_t.fabgmoddt, 
   fabgcnfid LIKE fabg_t.fabgcnfid, 
   fabgcnfid_desc LIKE type_t.chr80, 
   fabgcnfdt LIKE fabg_t.fabgcnfdt, 
   fabgpstid LIKE fabg_t.fabgpstid, 
   fabgpstid_desc LIKE type_t.chr80, 
   fabgpstdt LIKE fabg_t.fabgpstdt
       END RECORD
 
#單身 type 宣告
PRIVATE TYPE type_g_fabo_d        RECORD
       faboseq LIKE fabo_t.faboseq, 
   fabo001 LIKE fabo_t.fabo001, 
   fabo002 LIKE fabo_t.fabo002, 
   fabo003 LIKE fabo_t.fabo003, 
   fabo005 LIKE fabo_t.fabo005, 
   fabo007 LIKE fabo_t.fabo007, 
   fabo043 LIKE fabo_t.fabo043, 
   fabo044 LIKE fabo_t.fabo044, 
   fabo045 LIKE fabo_t.fabo045, 
   fabo046 LIKE fabo_t.fabo046, 
   fabo047 LIKE fabo_t.fabo047, 
   fabo048 LIKE fabo_t.fabo048, 
   fabo023 LIKE fabo_t.fabo023, 
   fabo023_desc LIKE type_t.chr500, 
   fabo000 LIKE fabo_t.fabo000
       END RECORD
 
 
PRIVATE TYPE type_browser RECORD
         b_statepic     LIKE type_t.chr50,
            b_fabgld LIKE fabg_t.fabgld,
      b_fabgdocno LIKE fabg_t.fabgdocno
       END RECORD
       
#add-point:自定義模組變數(Module Variable) (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="global.variable"


DEFINE g_fabf009             LIKE fabf_t.fabf009
DEFINE g_faah018             LIKE faah_t.faah018
DEFINE g_bookno              LIKE glaa_t.glaald
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
DEFINE g_wc_cs_ld            STRING                #160125-00005#7
DEFINE g_site_str            STRING                #160125-00005#7
DEFINE g_glaacomp            LIKE glaa_t.glaacomp  #161111-00049#12
#161104-00046#22 add ------
DEFINE g_user_dept_wc        STRING
DEFINE g_user_dept_wc_q      STRING
DEFINE g_user_slip_wc        STRING
DEFINE g_ap_slip             LIKE ooba_t.ooba002
#161104-00046#22 add end---
#end add-point
       
#模組變數(Module Variables)
DEFINE g_fabg_m          type_g_fabg_m
DEFINE g_fabg_m_t        type_g_fabg_m
DEFINE g_fabg_m_o        type_g_fabg_m
DEFINE g_fabg_m_mask_o   type_g_fabg_m #轉換遮罩前資料
DEFINE g_fabg_m_mask_n   type_g_fabg_m #轉換遮罩後資料
 
   DEFINE g_fabgld_t LIKE fabg_t.fabgld
DEFINE g_fabgdocno_t LIKE fabg_t.fabgdocno
 
 
DEFINE g_fabo_d          DYNAMIC ARRAY OF type_g_fabo_d
DEFINE g_fabo_d_t        type_g_fabo_d
DEFINE g_fabo_d_o        type_g_fabo_d
DEFINE g_fabo_d_mask_o   DYNAMIC ARRAY OF type_g_fabo_d #轉換遮罩前資料
DEFINE g_fabo_d_mask_n   DYNAMIC ARRAY OF type_g_fabo_d #轉換遮罩後資料
 
 
DEFINE g_browser         DYNAMIC ARRAY OF type_browser
DEFINE g_browser_f       DYNAMIC ARRAY OF type_browser
 
 
DEFINE g_wc                  STRING
DEFINE g_wc_t                STRING
DEFINE g_wc2                 STRING                          #單身CONSTRUCT結果
DEFINE g_wc2_table1          STRING
 
 
DEFINE g_wc2_extend          STRING
DEFINE g_wc_filter           STRING
DEFINE g_wc_filter_t         STRING
 
DEFINE g_sql                 STRING
DEFINE g_forupd_sql          STRING
DEFINE g_cnt                 LIKE type_t.num10
DEFINE g_current_idx         LIKE type_t.num10     
DEFINE g_jump                LIKE type_t.num10        
DEFINE g_no_ask              LIKE type_t.num5        
DEFINE g_rec_b               LIKE type_t.num10           
DEFINE l_ac                  LIKE type_t.num10    
DEFINE g_curr_diag           ui.Dialog                         #Current Dialog
                                                               
DEFINE g_pagestart           LIKE type_t.num10                 
DEFINE gwin_curr             ui.Window                         #Current Window
DEFINE gfrm_curr             ui.Form                           #Current Form
DEFINE g_page_action         STRING                            #page action
DEFINE g_header_hidden       LIKE type_t.num5                  #隱藏單頭
DEFINE g_worksheet_hidden    LIKE type_t.num5                  #隱藏工作Panel
DEFINE g_page                STRING                            #第幾頁
DEFINE g_state               STRING       
DEFINE g_header_cnt          LIKE type_t.num10
DEFINE g_detail_cnt          LIKE type_t.num10                  #單身總筆數
DEFINE g_detail_idx          LIKE type_t.num10                  #單身目前所在筆數
DEFINE g_detail_idx_tmp      LIKE type_t.num10                  #單身目前所在筆數
DEFINE g_detail_idx2         LIKE type_t.num10                  #單身2目前所在筆數
DEFINE g_detail_idx_list     DYNAMIC ARRAY OF LIKE type_t.num10 #單身2目前所在筆數
DEFINE g_browser_cnt         LIKE type_t.num10                  #Browser總筆數
DEFINE g_browser_idx         LIKE type_t.num10                  #Browser目前所在筆數
DEFINE g_temp_idx            LIKE type_t.num10                  #Browser目前所在筆數(暫存用)
DEFINE g_order               STRING                             #查詢排序欄位
                                                        
DEFINE g_current_row         LIKE type_t.num10                  #Browser所在筆數
DEFINE g_current_sw          BOOLEAN                            #Browser所在筆數用開關
DEFINE g_current_page        LIKE type_t.num10                  #目前所在頁數
DEFINE g_insert              LIKE type_t.chr5                   #是否導到其他page
 
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
DEFINE g_add_browse          STRING                        #新增填充用WC
DEFINE g_update              BOOLEAN                       #確定單頭/身是否異動過
DEFINE g_idx_group           om.SaxAttributes              #頁籤群組
DEFINE g_master_commit       LIKE type_t.chr1              #確認單頭是否修改過
 
#add-point:自定義客戶專用模組變數(Module Variable) name="global.variable_customerization"

#end add-point
 
#add-point:傳入參數說明(global.argv) name="global.argv"

#end add-point
 
{</section>}
 
{<section id="afat505.main" >}
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
   CALL cl_ap_init("afa","")
 
   #add-point:作業初始化 name="main.init"
   #161104-00046#22 add ------
   #建立與單頭array相同的temptable
   CALL s_aooi200def_create('','g_fabg_m','','','','','','')RETURNING g_sub_success
   #單別控制組
   LET g_user_dept_wc = ''
   CALL s_fin_get_user_dept_control('','fabgld','fabgent','fabgdocno') RETURNING g_user_dept_wc
   #開窗使用
   LET g_user_dept_wc_q = g_user_dept_wc
   CALL s_control_get_docno_sql(g_user,g_dept) RETURNING g_sub_success,g_user_slip_wc
   #161104-00046#22 add end---
   #end add-point
   
   
 
   #LOCK CURSOR (identifier)
   #add-point:SQL_define name="main.define_sql"
   
   #end add-point
   LET g_forupd_sql = " SELECT fabgsite,'',fabg001,'',fabgld,'',fabg002,'',fabg003,'',fabg004,fabg005, 
       fabgdocno,fabgdocdt,fabg010,fabg017,fabg018,fabgstus,fabgownid,'',fabgowndp,'',fabgcrtid,'',fabgcrtdp, 
       '',fabgcrtdt,fabgmodid,'',fabgmoddt,fabgcnfid,'',fabgcnfdt,fabgpstid,'',fabgpstdt", 
                      " FROM fabg_t",
                      " WHERE fabgent= ? AND fabgld=? AND fabgdocno=? FOR UPDATE"
   #add-point:SQL_define name="main.after_define_sql"
   
   #end add-point
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)                #轉換不同資料庫語法
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE afat505_cl CURSOR FROM g_forupd_sql                 # LOCK CURSOR
 
   LET g_sql = " SELECT DISTINCT t0.fabgsite,t0.fabg001,t0.fabgld,t0.fabg002,t0.fabg003,t0.fabg004,t0.fabg005, 
       t0.fabgdocno,t0.fabgdocdt,t0.fabg010,t0.fabg017,t0.fabg018,t0.fabgstus,t0.fabgownid,t0.fabgowndp, 
       t0.fabgcrtid,t0.fabgcrtdp,t0.fabgcrtdt,t0.fabgmodid,t0.fabgmoddt,t0.fabgcnfid,t0.fabgcnfdt,t0.fabgpstid, 
       t0.fabgpstdt,t1.ooefl003 ,t2.ooag011 ,t3.glaal002 ,t4.ooag011 ,t5.ooefl003 ,t6.ooag011 ,t7.ooefl003 , 
       t8.ooag011 ,t9.ooefl003 ,t10.ooag011 ,t11.ooag011 ,t12.ooag011",
               " FROM fabg_t t0",
                              " LEFT JOIN ooefl_t t1 ON t1.ooeflent="||g_enterprise||" AND t1.ooefl001=t0.fabgsite AND t1.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t2 ON t2.ooagent="||g_enterprise||" AND t2.ooag001=t0.fabg001  ",
               " LEFT JOIN glaal_t t3 ON t3.glaalent="||g_enterprise||" AND t3.glaalld=t0.fabgld AND t3.glaal001='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t4 ON t4.ooagent="||g_enterprise||" AND t4.ooag001=t0.fabg002  ",
               " LEFT JOIN ooefl_t t5 ON t5.ooeflent="||g_enterprise||" AND t5.ooefl001=t0.fabg003 AND t5.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t6 ON t6.ooagent="||g_enterprise||" AND t6.ooag001=t0.fabgownid  ",
               " LEFT JOIN ooefl_t t7 ON t7.ooeflent="||g_enterprise||" AND t7.ooefl001=t0.fabgowndp AND t7.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t8 ON t8.ooagent="||g_enterprise||" AND t8.ooag001=t0.fabgcrtid  ",
               " LEFT JOIN ooefl_t t9 ON t9.ooeflent="||g_enterprise||" AND t9.ooefl001=t0.fabgcrtdp AND t9.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t10 ON t10.ooagent="||g_enterprise||" AND t10.ooag001=t0.fabgmodid  ",
               " LEFT JOIN ooag_t t11 ON t11.ooagent="||g_enterprise||" AND t11.ooag001=t0.fabgcnfid  ",
               " LEFT JOIN ooag_t t12 ON t12.ooagent="||g_enterprise||" AND t12.ooag001=t0.fabgpstid  ",
 
               " WHERE t0.fabgent = " ||g_enterprise|| " AND t0.fabgld = ? AND t0.fabgdocno = ?"
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   #add-point:SQL_define name="main.after_refresh_sql"
   
   #end add-point
   PREPARE afat505_master_referesh FROM g_sql
 
    
 
   
   IF g_bgjob = "Y" THEN
      #add-point:Service Call name="main.servicecall"
      
      #end add-point
   ELSE
      #畫面開啟 (identifier)
      OPEN WINDOW w_afat505 WITH FORM cl_ap_formpath("afa",g_code)
   
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
   
      #程式初始化
      CALL afat505_init()   
 
      #進入選單 Menu (="N")
      CALL afat505_ui_dialog() 
      
      #add-point:畫面關閉前 name="main.before_close"
      
      #end add-point
 
      #畫面關閉
      CLOSE WINDOW w_afat505
      
   END IF 
   
   CLOSE afat505_cl
   
   
 
   #add-point:作業離開前 name="main.exit"
   
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
END MAIN
 
 
 
 
{</section>}
 
{<section id="afat505.init" >}
#+ 瀏覽頁簽資料初始化
PRIVATE FUNCTION afat505_init()
   #add-point:init段define(客製用) name="init.define_customerization"
   
   #end add-point    
   #add-point:init段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="init.define"
   
   #end add-point   
   
   #add-point:Function前置處理  name="init.pre_function"
   
   #end add-point
   
   LET g_bfill       = "Y"
   LET g_detail_idx  = 1 #第一層單身指標
   LET g_detail_idx2 = 1 #第二層單身指標
   
   #各個page指標
   LET g_detail_idx_list[1] = 1 
 
   LET g_error_show  = 1
   LET l_ac = 1 #單身指標
      CALL cl_set_combo_scc_part('fabgstus','13','A,D,N,R,W,Y,Z,S,X')
 
      CALL cl_set_combo_scc('fabg005','9910') 
 
   LET gwin_curr = ui.Window.getCurrent()  #取得現行畫面
   LET gfrm_curr = gwin_curr.getForm()     #取出物件化後的畫面物件
   
   #page群組
   LET g_idx_group = om.SaxAttributes.create()
   CALL g_idx_group.addAttribute("'1',","1")
 
 
   #add-point:畫面資料初始化 name="init.init"
   CALL cl_set_combo_scc_part('fabg005','9910','17')
   CALL s_fin_create_account_center_tmp()  
   #end add-point
   
   #初始化搜尋條件
   CALL afat505_default_search()
    
END FUNCTION
 
{</section>}
 
{<section id="afat505.ui_dialog" >}
#+ 功能選單
PRIVATE FUNCTION afat505_ui_dialog()
   #add-point:ui_dialog段define(客製用) name="ui_dialog.define_customerization"
   
   #end add-point
   DEFINE li_idx     LIKE type_t.num10
   DEFINE ls_wc      STRING
   DEFINE lb_first   BOOLEAN
   DEFINE la_wc      DYNAMIC ARRAY OF RECORD
          tableid    STRING,
          wc         STRING
          END RECORD
   DEFINE la_param   RECORD
          prog       STRING,
          actionid   STRING,
          background LIKE type_t.chr1,
          param      DYNAMIC ARRAY OF STRING
          END RECORD
   DEFINE ls_js      STRING
   DEFINE la_output  DYNAMIC ARRAY OF STRING   #報表元件鬆耦合使用
   DEFINE  l_cmd_token           base.StringTokenizer   #報表作業cmdrun使用 
   DEFINE  l_cmd_next            STRING                 #報表作業cmdrun使用
   DEFINE  l_cmd_cnt             LIKE type_t.num5       #報表作業cmdrun使用
   DEFINE  l_cmd_prog_arg        STRING                 #報表作業cmdrun使用
   DEFINE  l_cmd_arg             STRING                 #報表作業cmdrun使用
   #add-point:ui_dialog段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="ui_dialog.define"
   #151125-00006#2 add ---s 
   DEFINE l_cn              LIKE type_t.num5
   #151125-00006#2 add ---e
   #end add-point
   
   #add-point:Function前置處理  name="ui_dialog.pre_function"
   
   #end add-point
   
   CALL cl_set_act_visible("accept,cancel", FALSE)
 
   
   #action default動作
   #應用 a42 樣板自動產生(Version:3)
   #進入程式時預設執行的動作
   CASE g_actdefault
      WHEN "insert"
         LET g_action_choice="insert"
         LET g_actdefault = ""
         IF cl_auth_chk_act("insert") THEN
            CALL afat505_insert()
            #add-point:ON ACTION insert name="menu.default.insert"
            
            #END add-point
         END IF
 
      #add-point:action default自訂 name="ui_dialog.action_default"
      
      #end add-point
      OTHERWISE
   END CASE
 
 
 
   
   LET lb_first = TRUE
   
   #add-point:ui_dialog段before dialog  name="ui_dialog.before_dialog"
   
   #end add-point
   
   WHILE TRUE 
   
      IF g_action_choice = "logistics" THEN
         #清除畫面及相關資料
         CLEAR FORM
         CALL g_browser.clear()       
         INITIALIZE g_fabg_m.* TO NULL
         CALL g_fabo_d.clear()
 
         LET g_wc  = ' 1=2'
         LET g_wc2 = ' 1=1'
         LET g_action_choice = ""
         CALL afat505_init()
      END IF
   
            
      DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
 
    
         DISPLAY ARRAY g_fabo_d TO s_detail1.* ATTRIBUTES(COUNT=g_rec_b) #page1  
    
            BEFORE ROW
               #顯示單身筆數
               CALL afat505_idx_chk()
               #確定當下選擇的筆數
               LET l_ac = DIALOG.getCurrentRow("s_detail1")
               LET g_detail_idx = l_ac
               LET g_detail_idx_list[1] = l_ac
               CALL g_idx_group.addAttribute("'1',",l_ac)
               
               #add-point:page1, before row動作 name="ui_dialog.page1.before_row"
               
               #end add-point
               
            BEFORE DISPLAY
               #如果一直都在單身1則控制筆數位置
               IF g_loc = 'm' THEN
                  CALL FGL_SET_ARR_CURR(g_idx_group.getValue("'1',"))
               END IF
               LET g_loc = 'm'
               LET l_ac = DIALOG.getCurrentRow("s_detail1")
               LET g_current_page = 1
               #顯示單身筆數
               CALL afat505_idx_chk()
               #add-point:page1自定義行為 name="ui_dialog.page1.before_display"
               
               #end add-point
               
            #自訂ACTION(detail_show,page_1)
            
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION open_afat505_02
            LET g_action_choice="open_afat505_02"
            IF cl_auth_chk_act("open_afat505_02") THEN
               
               #add-point:ON ACTION open_afat505_02 name="menu.detail_show.page1.open_afat505_02"
               CALL afat440_01('',g_fabo_d[l_ac].faboseq,g_fabo_d[l_ac].fabo001,g_fabo_d[l_ac].fabo002,
                               g_fabo_d[l_ac].fabo003,g_fabg_m.fabg005,g_fabg_m.fabgdocno,
                               g_fabo_d[l_ac].fabo007)
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION open_afat505_01
            LET g_action_choice="open_afat505_01"
            IF cl_auth_chk_act("open_afat505_01") THEN
               
               #add-point:ON ACTION open_afat505_01 name="menu.detail_show.page1.open_afat505_01"
               IF g_fabo_d[l_ac].fabo044 <> g_fabo_d[l_ac].fabo047 THEN
                  CALL afat505_01(g_fabg_m.fabgld,g_fabg_m.fabgdocno,g_fabo_d[g_detail_idx].faboseq,
                                  g_fabo_d[g_detail_idx].fabo001,g_fabo_d[g_detail_idx].fabo002,
                                  g_fabo_d[g_detail_idx].fabo003,
                                  g_fabo_d[g_detail_idx].fabo007,g_fabg_m.fabgdocdt,
                                  g_fabo_d[g_detail_idx].fabo044,g_fabo_d[g_detail_idx].fabo047) #20141113 add by chenying 新增传参调入/出所有组织
               ELSE
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'afa-00179'
                  LET g_errparam.extend = ''
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
                  
                  EXIT DIALOG
               END IF
               #END add-point
               
            END IF
 
 
 
 
               
            #add-point:page1自定義行為 name="ui_dialog.page1.action"
            
            #end add-point
               
         END DISPLAY
        
 
         
 
         
         #add-point:ui_dialog段自定義display array name="ui_dialog.more_displayarray"
         
         #end add-point
         
      
         BEFORE DIALOG
            #先填充browser資料
            CALL afat505_browser_fill("")
            CALL cl_notice()
            CALL cl_navigator_setting(g_current_idx, g_detail_cnt)
            LET g_curr_diag = ui.DIALOG.getCurrent()
            LET g_current_sw = FALSE
            #回歸舊筆數位置 (回到當時異動的筆數)
            
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
               CALL afat505_fetch('') # reload data
            END IF
            #LET g_detail_idx = 1
            CALL afat505_ui_detailshow() #Setting the current row 
            
            #筆數顯示
            LET g_current_page = 1
            CALL afat505_idx_chk()
            CALL cl_ap_performance_cal()
            #add-point:ui_dialog段before_dialog2 name="ui_dialog.before_dialog2"
            
            #end add-point
 
         #add-point:ui_dialog段more_action name="ui_dialog.more_action"
         
         #end add-point
 
         #狀態碼切換
         ON ACTION statechange
            LET g_action_choice = "statechange"
            CALL afat505_statechange()
            #根據資料狀態切換action狀態
            CALL cl_set_act_visible("statechange,modify,modify_detail,delete,reproduce", TRUE)
            CALL afat505_set_act_visible()   
            CALL afat505_set_act_no_visible()
            IF NOT (g_fabg_m.fabgld IS NULL
              OR g_fabg_m.fabgdocno IS NULL
 
              ) THEN
               #組合條件
               LET g_add_browse = " fabgent = " ||g_enterprise|| " AND",
                                  " fabgld = '", g_fabg_m.fabgld, "' "
                                  ," AND fabgdocno = '", g_fabg_m.fabgdocno, "' "
 
               #填到對應位置
               CALL afat505_browser_fill("")
            END IF
         #應用 a32 樣板自動產生(Version:3)
         #簽核狀況
         ON ACTION bpm_status
            #查詢簽核狀況, 統一建立HyperLink
            CALL cl_bpm_status()
            #add-point:ON ACTION bpm_status name="menu.bpm_status"
            
            #END add-point
 
 
 
          
         #查詢方案選擇 
         ON ACTION queryplansel
            CALL cl_dlg_qryplan_select() RETURNING ls_wc
            #不是空條件才寫入g_wc跟重新找資料
            IF NOT cl_null(ls_wc) THEN
               CALL util.JSON.parse(ls_wc, la_wc)
               INITIALIZE g_wc, g_wc2,g_wc2_table1,g_wc2_extend TO NULL
 
               FOR li_idx = 1 TO la_wc.getLength()
                  CASE
                     WHEN la_wc[li_idx].tableid = "fabg_t" 
                        LET g_wc = la_wc[li_idx].wc
                     WHEN la_wc[li_idx].tableid = "fabo_t" 
                        LET g_wc2_table1 = la_wc[li_idx].wc
 
                     WHEN la_wc[li_idx].tableid = "EXTENDWC"
                        LET g_wc2_extend = la_wc[li_idx].wc
                  END CASE
               END FOR
               IF NOT cl_null(g_wc) OR NOT cl_null(g_wc2_table1) 
 
                  OR NOT cl_null(g_wc2_extend)
                  THEN
                  #組合g_wc2
                  IF g_wc2_table1 <> " 1=1" AND NOT cl_null(g_wc2_table1) THEN
                     LET g_wc2 = g_wc2_table1
                  END IF
 
                  IF g_wc2_extend <> " 1=1" AND NOT cl_null(g_wc2_extend) THEN
                     LET g_wc2 = g_wc2 ," AND ", g_wc2_extend
                  END IF
 
                  IF g_wc2.subString(1,5) = " AND " THEN
                     LET g_wc2 = g_wc2.subString(6,g_wc2.getLength())
                  END IF
               END IF
               CALL afat505_browser_fill("F")   #browser_fill()會將notice區塊清空
            END IF
         
         #查詢方案選擇
         ON ACTION qbe_select
            CALL cl_qbe_list("m") RETURNING ls_wc
            IF NOT cl_null(ls_wc) THEN
               CALL util.JSON.parse(ls_wc, la_wc)
               INITIALIZE g_wc, g_wc2,g_wc2_table1,g_wc2_extend TO NULL
 
               FOR li_idx = 1 TO la_wc.getLength()
                  CASE
                     WHEN la_wc[li_idx].tableid = "fabg_t" 
                        LET g_wc = la_wc[li_idx].wc
                     WHEN la_wc[li_idx].tableid = "fabo_t" 
                        LET g_wc2_table1 = la_wc[li_idx].wc
 
                     WHEN la_wc[li_idx].tableid = "EXTENDWC"
                        LET g_wc2_extend = la_wc[li_idx].wc
                  END CASE
               END FOR
               IF NOT cl_null(g_wc) OR NOT cl_null(g_wc2_table1)
 
                  OR NOT cl_null(g_wc2_extend)
                  THEN
                  IF g_wc2_table1 <> " 1=1" AND NOT cl_null(g_wc2_table1) THEN
                     LET g_wc2 = g_wc2_table1
                  END IF
 
                  IF g_wc2_extend <> " 1=1" AND NOT cl_null(g_wc2_extend) THEN
                     LET g_wc2 = g_wc2 ," AND ", g_wc2_extend
                  END IF
                  IF g_wc2.subString(1,5) = " AND " THEN
                     LET g_wc2 = g_wc2.subString(6,g_wc2.getLength())
                  END IF
                  #取得條件後需要重查、跳到結果第一筆資料的功能程式段
                  CALL afat505_browser_fill("F")
                  IF g_browser_cnt = 0 THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "" 
                     LET g_errparam.code = "-100" 
                     LET g_errparam.popup = TRUE 
                     CALL cl_err()
                     CLEAR FORM
                  ELSE
                     CALL afat505_fetch("F")
                  END IF
               END IF
            END IF
            #重新搜尋會將notice區塊清空,此處不可用EXIT DIALOG, SUBDIALOG重讀會導致部分變數消失
          
         
         
         ON ACTION first
            LET g_action_choice = "fetch"
            CALL afat505_fetch('F')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL afat505_idx_chk()
            
         ON ACTION previous
            LET g_action_choice = "fetch"
            CALL afat505_fetch('P')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL afat505_idx_chk()
            
         ON ACTION jump
            LET g_action_choice = "fetch"
            CALL afat505_fetch('/')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL afat505_idx_chk()
            
         ON ACTION next
            LET g_action_choice = "fetch"
            CALL afat505_fetch('N')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL afat505_idx_chk()
            
         ON ACTION last
            LET g_action_choice = "fetch"
            CALL afat505_fetch('L')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL afat505_idx_chk()
          
         #excel匯出功能          
         ON ACTION exporttoexcel
            LET g_action_choice="exporttoexcel"
            IF cl_auth_chk_act("exporttoexcel") THEN
               #browser
               CALL g_export_node.clear()
               IF g_main_hidden = 1 THEN
                  LET g_export_node[1] = base.typeInfo.create(g_browser)
                  LET g_export_id[1]   = "s_browse"
                  CALL cl_export_to_excel()
               #非browser
               ELSE
                  LET g_export_node[1] = base.typeInfo.create(g_fabo_d)
                  LET g_export_id[1]   = "s_detail1"
 
                  #add-point:ON ACTION exporttoexcel name="menu.exporttoexcel"
                  
                  #END add-point
                  CALL cl_export_to_excel_getpage()
                  CALL cl_export_to_excel()
               END IF
            END IF
        
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
               CALL cl_notice()
            END IF
            
       
         #單頭摺疊，可利用hot key "Alt-s"開啟/關閉單頭
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
    
         
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION modify
            LET g_action_choice="modify"
            IF cl_auth_chk_act("modify") THEN
               LET g_aw = ''
               CALL afat505_modify()
               #add-point:ON ACTION modify name="menu.modify"
               #add 151125-00006#2 --s
               LET l_cn = 0 
               SELECT COUNT(1) INTO l_cn FROM fabg_t 
               WHERE fabgld  = g_fabg_m.fabgld  AND fabgdocno = g_fabg_m.fabgdocno AND fabgent = g_enterprise
               IF l_cn > 0 AND NOT cl_null (g_current_idx) THEN
                  CALL afat505_ui_headershow()
               END IF
               #add 151125-00006#2 --e
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION modify_detail
            LET g_action_choice="modify_detail"
            IF cl_auth_chk_act("modify") THEN
               LET g_aw = g_curr_diag.getCurrentItem()
               CALL afat505_modify()
               #add-point:ON ACTION modify_detail name="menu.modify_detail"
               #add 151125-00006#2 --s
               LET l_cn = 0 
               SELECT COUNT(1) INTO l_cn FROM fabg_t 
               WHERE fabgld  = g_fabg_m.fabgld  AND fabgdocno = g_fabg_m.fabgdocno AND fabgent = g_enterprise
               IF l_cn > 0 AND NOT cl_null (g_current_idx) THEN
                  CALL afat505_ui_headershow()
               END IF
               #add 151125-00006#2 --e
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION delete
            LET g_action_choice="delete"
            IF cl_auth_chk_act("delete") THEN
               CALL afat505_delete()
               #add-point:ON ACTION delete name="menu.delete"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION insert
            LET g_action_choice="insert"
            IF cl_auth_chk_act("insert") THEN
               CALL afat505_insert()
               #add-point:ON ACTION insert name="menu.insert"
               #add 151125-00006#2 --s
               LET l_cn = 0 
               SELECT COUNT(1) INTO l_cn FROM fabg_t 
               WHERE fabgld  = g_fabg_m.fabgld  AND fabgdocno = g_fabg_m.fabgdocno AND fabgent = g_enterprise
               IF l_cn > 0 AND NOT cl_null (g_current_idx) THEN
                  CALL afat505_ui_headershow()
               END IF
               #add 151125-00006#2 --e
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION confirm_out
            LET g_action_choice="confirm_out"
            IF cl_auth_chk_act("confirm_out") THEN
               
               #add-point:ON ACTION confirm_out name="menu.confirm_out"
               IF g_fabg_m.fabg010 = 'N' THEN 
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = ''
                  LET g_errparam.code   = 'afa-00180' 
                  LET g_errparam.popup  = TRUE 
                  CALL cl_err()
                  EXIT DIALOG
               END IF
               
               IF g_fabg_m.fabg017 = 'N' THEN 
                  CALL afat505_update_fabg017('Y')
               END IF

               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION output
            LET g_action_choice="output"
            IF cl_auth_chk_act("output") THEN
               
               #add-point:ON ACTION output name="menu.output"
               
               #END add-point
               &include "erp/afa/afat505_rep.4gl"
               #add-point:ON ACTION output.after name="menu.after_output"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION quickprint
            LET g_action_choice="quickprint"
            IF cl_auth_chk_act("quickprint") THEN
               
               #add-point:ON ACTION quickprint name="menu.quickprint"
               
               #END add-point
               &include "erp/afa/afat505_rep.4gl"
               #add-point:ON ACTION quickprint.after name="menu.after_quickprint"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION query
            LET g_action_choice="query"
            IF cl_auth_chk_act("query") THEN
               CALL afat505_query()
               #add-point:ON ACTION query name="menu.query"
               
               #END add-point
               #應用 a59 樣板自動產生(Version:3)  
               CALL g_curr_diag.setCurrentRow("s_detail1",1)
 
 
 
 
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION open_afap270
            LET g_action_choice="open_afap270"
            IF cl_auth_chk_act("open_afap270") THEN
               
               #add-point:ON ACTION open_afap270 name="menu.open_afap270"
               IF g_fabg_m.fabg010 = 'Y' THEN
                  IF g_fabg_m.fabg017 = 'Y' AND g_fabg_m.fabg018 = 'Y' THEN
                     LET la_param.prog = 'afap270'
                     LET la_param.param[1] = g_fabg_m.fabgld
                     LET la_param.param[2] = g_fabg_m.fabgdocno
                     LET la_param.param[3] = g_fabg_m.fabg005
                     LET ls_js = util.JSON.stringify(la_param)
                     CALL cl_cmdrun_wait(ls_js)
                  ELSE
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "" 
                     LET g_errparam.code   = "afa-00267" 
                     LET g_errparam.popup  = TRUE 
                     CALL cl_err()
                  END IF
               ELSE
                  LET la_param.prog = 'afap270'
                  LET la_param.param[1] = g_fabg_m.fabgld
                  LET la_param.param[2] = g_fabg_m.fabgdocno
                  LET la_param.param[3] = g_fabg_m.fabg005
                  LET ls_js = util.JSON.stringify(la_param)
                  CALL cl_cmdrun_wait(ls_js)
               END IF
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION unconfirm_in
            LET g_action_choice="unconfirm_in"
            IF cl_auth_chk_act("unconfirm_in") THEN
               
               #add-point:ON ACTION unconfirm_in name="menu.unconfirm_in"
               IF g_fabg_m.fabg010 = 'N' THEN 
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = ''
                  LET g_errparam.code   = 'afa-00180' 
                  LET g_errparam.popup  = TRUE 
                  CALL cl_err()
                  EXIT DIALOG
               END IF
               
               IF g_fabg_m.fabg018 = 'Y' THEN
                  CALL afat505_update_fabg018('N')
               END IF
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION unconfirm_out
            LET g_action_choice="unconfirm_out"
            IF cl_auth_chk_act("unconfirm_out") THEN
               
               #add-point:ON ACTION unconfirm_out name="menu.unconfirm_out"
               IF g_fabg_m.fabg010 = 'N' THEN 
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = ''
                  LET g_errparam.code   = 'afa-00180' 
                  LET g_errparam.popup  = TRUE 
                  CALL cl_err()
                  EXIT DIALOG
               END IF
               
               IF g_fabg_m.fabg018 = 'Y' THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = ''
                  LET g_errparam.code   = 'afa-00182' 
                  LET g_errparam.popup  = TRUE 
                  CALL cl_err()
                  EXIT DIALOG
               END IF
               IF g_fabg_m.fabg017 = 'Y' THEN
                  CALL afat505_update_fabg017('N')
               END IF
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION confirm_in
            LET g_action_choice="confirm_in"
            IF cl_auth_chk_act("confirm_in") THEN
               
               #add-point:ON ACTION confirm_in name="menu.confirm_in"
               IF g_fabg_m.fabg010 = 'N' THEN 
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = ''
                  LET g_errparam.code   = 'afa-00180' 
                  LET g_errparam.popup  = TRUE 
                  CALL cl_err()
                  EXIT DIALOG
               END IF
               
               IF g_fabg_m.fabg017 = 'N' THEN 
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = ''
                  LET g_errparam.code   = 'afa-00181' 
                  LET g_errparam.popup  = TRUE 
                  CALL cl_err()
                  EXIT DIALOG
               END IF
               
               IF g_fabg_m.fabg018 = 'N' THEN
                  CALL afat505_update_fabg018('Y')
               END IF
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION prog_fabg001
            LET g_action_choice="prog_fabg001"
            IF cl_auth_chk_act("prog_fabg001") THEN
               
               #add-point:ON ACTION prog_fabg001 name="menu.prog_fabg001"
               #應用 a41 樣板自動產生(Version:2)
               #使用JSON格式組合參數與作業編號(串查)
               CALL cl_user_contact("aooi130", "ooag_t", "ooag002", "ooag001",g_fabg_m.fabg001)
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION prog_fabg002
            LET g_action_choice="prog_fabg002"
            IF cl_auth_chk_act("prog_fabg002") THEN
               
               #add-point:ON ACTION prog_fabg002 name="menu.prog_fabg002"
               #應用 a41 樣板自動產生(Version:2)
               #使用JSON格式組合參數與作業編號(串查)
               CALL cl_user_contact("aooi130", "ooag_t", "ooag002", "ooag001",g_fabg_m.fabg002)
               #END add-point
               
            END IF
 
 
 
 
         
         #應用 a46 樣板自動產生(Version:3)
         #新增相關文件
         ON ACTION related_document
            CALL afat505_set_pk_array()
            IF cl_auth_chk_act("related_document") THEN
               #add-point:ON ACTION related_document name="ui_dialog.dialog.related_document"
               
               #END add-point
               CALL cl_doc()
            END IF
            
         ON ACTION agendum
            CALL afat505_set_pk_array()
            #add-point:ON ACTION agendum name="ui_dialog.dialog.agendum"
            
            #END add-point
            CALL cl_user_overview()
            CALL cl_user_overview_set_follow_pic()
         
         ON ACTION followup
            CALL afat505_set_pk_array()
            #add-point:ON ACTION followup name="ui_dialog.dialog.followup"
            
            #END add-point
            CALL cl_user_overview_follow(g_fabg_m.fabgdocdt)
 
 
 
         
         #主選單用ACTION
         &include "main_menu_exit_dialog.4gl"
         &include "relating_action.4gl"
    
         #交談指令共用ACTION
         &include "common_action.4gl" 
            CONTINUE DIALOG
      END DIALOG
 
      #(ver:79) ---add start---
      #add-point:ui_dialog段 after dialog name="ui_dialog.exit_dialog"
      
      #end add-point
      #(ver:79) --- add end ---
    
      IF g_action_choice = "exit" AND NOT cl_null(g_action_choice) THEN
         #add-point:ui_dialog段離開dialog前 name="ui_dialog.b_exit"
         
         #end add-point
         EXIT WHILE
      END IF
    
   END WHILE    
      
   CALL cl_set_act_visible("accept,cancel", TRUE)
    
END FUNCTION
 
{</section>}
 
{<section id="afat505.browser_fill" >}
#+ 瀏覽頁簽資料填充
PRIVATE FUNCTION afat505_browser_fill(ps_page_action)
   #add-point:browser_fill段define(客製用) name="browser_fill.define_customerization"
   
   #end add-point  
   DEFINE ps_page_action    STRING
   DEFINE l_wc              STRING
   DEFINE l_wc2             STRING
   DEFINE l_sql             STRING
   DEFINE l_sub_sql         STRING
   DEFINE l_sql_rank        STRING
   #add-point:browser_fill段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="browser_fill.define"
   DEFINE l_ld_str          STRING #160125-00005#7
   DEFINE l_comp_str  STRING  #161111-00049#12 add    
   
   IF cl_null(g_wc) THEN 
      LET g_wc = " fabg005 = '17' "
   ELSE
      LET g_wc = g_wc," AND fabg005 = '17'"
   END IF 
   #end add-point    
   
   #add-point:Function前置處理 name="browser_fill.before_browser_fill"
   
   #end add-point
   
   IF cl_null(g_wc) THEN
      LET g_wc = " 1=1"
   END IF
   IF cl_null(g_wc2) THEN
      LET g_wc2 = " 1=1"
   END IF
   LET l_wc  = g_wc.trim() 
   LET l_wc2 = g_wc2.trim()
 
   #add-point:browser_fill,foreach前 name="browser_fill.before_foreach"
   #160125-00005#7--add--str--
   #账套范围
   CALL s_axrt300_get_site(g_user,'','2')  RETURNING g_wc_cs_ld 
   IF NOT cl_null(g_wc_cs_ld) THEN   
      LET l_ld_str = cl_replace_str(g_wc_cs_ld,"glaald","fabgld")
      LET l_wc = l_wc , " AND ",l_ld_str
   END IF
   #160125-00005#7--add--end
   #161111-00049#12 add s---
   CALL s_axrt300_get_site(g_user,'','1') RETURNING l_comp_str 
   LET l_comp_str = cl_replace_str(l_comp_str,"ooef001","fabo046")
   LET l_wc = l_wc," AND ",l_comp_str
   
   CALL s_axrt300_get_site(g_user,'','1') RETURNING l_comp_str 
   LET l_comp_str = cl_replace_str(l_comp_str,"ooef001","fabo047")
   LET l_wc = l_wc," AND ",l_comp_str  

   CALL s_axrt300_get_site(g_user,'','1') RETURNING l_comp_str 
   LET l_comp_str = cl_replace_str(l_comp_str,"ooef001","fabo048")
   LET l_wc = l_wc," AND ",l_comp_str
   #161111-00049#12 add e---    
   #end add-point
   
   IF g_wc2 <> " 1=1" THEN
      #單身有輸入搜尋條件                      
      LET l_sub_sql = " SELECT DISTINCT fabgld,fabgdocno ",
                      " FROM fabg_t ",
                      " ",
                      " LEFT JOIN fabo_t ON faboent = fabgent AND fabgld = fabold AND fabgdocno = fabodocno ", "  ",
                      #add-point:browser_fill段sql(fabo_t1) name="browser_fill.cnt.join.}"
                      
                      #end add-point
 
 
                      " ", 
                      " ", 
 
 
                      " WHERE fabgent = " ||g_enterprise|| " AND faboent = " ||g_enterprise|| " AND ",l_wc, " AND ", l_wc2, cl_sql_add_filter("fabg_t")
   ELSE
      #單身未輸入搜尋條件
      LET l_sub_sql = " SELECT DISTINCT fabgld,fabgdocno ",
                      " FROM fabg_t ", 
                      "  ",
                      "  ",
                      " WHERE fabgent = " ||g_enterprise|| " AND ",l_wc CLIPPED, cl_sql_add_filter("fabg_t")
   END IF
   
   #add-point:browser_fill,cnt wc name="browser_fill.cnt_sqlwc"
   
   #end add-point
   
   LET g_sql = " SELECT COUNT(1) FROM (",l_sub_sql,")"
   
   #add-point:browser_fill,count前 name="browser_fill.before_count"
   
   #end add-point
   
   IF g_sql.getIndexOf(" 1=2",1) THEN
      DISPLAY "INFO: 1=2 jumped!"
   ELSE
      PREPARE header_cnt_pre FROM g_sql
      EXECUTE header_cnt_pre INTO g_browser_cnt   #總筆數
      FREE header_cnt_pre
   END IF
    
   IF g_browser_cnt > g_max_browse THEN
      IF g_error_show = 1 THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = g_browser_cnt
         LET g_errparam.code = 9035 
         LET g_errparam.popup = TRUE 
         CALL cl_err()
      END IF
      LET g_browser_cnt = g_max_browse
   END IF
   
   DISPLAY g_browser_cnt TO FORMONLY.b_count   #總筆數的顯示
   DISPLAY g_browser_cnt TO FORMONLY.h_count   #總筆數的顯示
 
   #根據行為確定資料填充位置及WC
   IF cl_null(g_add_browse) THEN
      #清除畫面
      CLEAR FORM                
      INITIALIZE g_fabg_m.* TO NULL
      CALL g_fabo_d.clear()        
 
      #add-point:browser_fill g_add_browse段額外處理 name="browser_fill.add_browse.other"
      
      #end add-point   
      CALL g_browser.clear()
      LET g_cnt = 1
   ELSE
      LET l_wc  = g_add_browse
      LET l_wc2 = " 1=1" 
      LET g_cnt = g_current_idx
   END IF
 
   #依照t0.fabgld,t0.fabgdocno Browser欄位定義(取代原本bs_sql功能)
   #考量到單身可能下條件, 所以此處需join單身所有table
   #DISTINCT是為了避免在join時出現重複的資料(如果不加DISTINCT則須在程式中過濾)
   IF g_wc2 <> " 1=1" THEN
      #單身有輸入搜尋條件   
      LET g_sql = " SELECT DISTINCT t0.fabgstus,t0.fabgld,t0.fabgdocno ",
                  " FROM fabg_t t0",
                  "  ",
                  "  LEFT JOIN fabo_t ON faboent = fabgent AND fabgld = fabold AND fabgdocno = fabodocno ", "  ", 
                  #add-point:browser_fill段sql(fabo_t1) name="browser_fill.join.fabo_t1"
                  
                  #end add-point
 
 
                  " ", 
 
 
                  
                  " WHERE t0.fabgent = " ||g_enterprise|| " AND ",l_wc," AND ",l_wc2, cl_sql_add_filter("fabg_t")
   ELSE
      #單身無輸入搜尋條件   
      LET g_sql = " SELECT DISTINCT t0.fabgstus,t0.fabgld,t0.fabgdocno ",
                  " FROM fabg_t t0",
                  "  ",
                  
                  " WHERE t0.fabgent = " ||g_enterprise|| " AND ",l_wc, cl_sql_add_filter("fabg_t")
   END IF
   #add-point:browser_fill,sql wc name="browser_fill.fill_sqlwc"
   
   #end add-point
   LET g_sql = g_sql, " ORDER BY fabgld,fabgdocno ",g_order
 
   #add-point:browser_fill,before_prepare name="browser_fill.before_prepare"
   
   #end add-point
        
   #LET g_sql = cl_sql_add_tabid(g_sql,"fabg_t") #WC重組
   LET g_sql = cl_sql_add_mask(g_sql) #遮蔽特定資料
   
   IF g_sql.getIndexOf(" 1=2",1) THEN
      DISPLAY "INFO: 1=2 jumped!"
   ELSE
      PREPARE browse_pre FROM g_sql
      DECLARE browse_cur CURSOR FOR browse_pre
      
      #add-point:browser_fill段open cursor name="browser_fill.open"
      
      #end add-point
      
      FOREACH browse_cur INTO g_browser[g_cnt].b_statepic,g_browser[g_cnt].b_fabgld,g_browser[g_cnt].b_fabgdocno 
 
         IF SQLCA.SQLCODE THEN
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "Foreach:",SQLERRMESSAGE 
            LET g_errparam.code = SQLCA.SQLCODE 
            LET g_errparam.popup = TRUE 
            CALL cl_err()
            EXIT FOREACH
         END IF
      
         #add-point:browser_fill段reference name="browser_fill.reference"
         
         #end add-point
      
      
               #應用 a24 樣板自動產生(Version:3)
      #browser顯示圖片
      CASE g_browser[g_cnt].b_statepic
         WHEN "A"
            LET g_browser[g_cnt].b_statepic = "stus/16/approved.png"
         WHEN "D"
            LET g_browser[g_cnt].b_statepic = "stus/16/withdraw.png"
         WHEN "N"
            LET g_browser[g_cnt].b_statepic = "stus/16/unconfirmed.png"
         WHEN "R"
            LET g_browser[g_cnt].b_statepic = "stus/16/rejection.png"
         WHEN "W"
            LET g_browser[g_cnt].b_statepic = "stus/16/signing.png"
         WHEN "Y"
            LET g_browser[g_cnt].b_statepic = "stus/16/confirmed.png"
         WHEN "Z"
            LET g_browser[g_cnt].b_statepic = "stus/16/unposted.png"
         WHEN "S"
            LET g_browser[g_cnt].b_statepic = "stus/16/posted.png"
         WHEN "X"
            LET g_browser[g_cnt].b_statepic = "stus/16/invalid.png"
         
      END CASE
 
 
 
         LET g_cnt = g_cnt + 1
         IF g_cnt > g_max_browse THEN
            EXIT FOREACH
         END IF
         
      END FOREACH
      FREE browse_pre
   END IF
   
   #清空g_add_browse, 並指定指標位置
   IF NOT cl_null(g_add_browse) THEN
      LET g_add_browse = ""
      CALL g_curr_diag.setCurrentRow("s_browse",g_current_idx)
   END IF
   
   IF cl_null(g_browser[g_cnt].b_fabgld) THEN
      CALL g_browser.deleteElement(g_cnt)
   END IF
   
   LET g_header_cnt  = g_browser.getLength()
   LET g_browser_cnt = g_browser.getLength()
   
   #筆數顯示
   IF g_browser_cnt > 0 THEN
      DISPLAY g_browser_idx TO FORMONLY.b_index #當下筆數
      DISPLAY g_browser_cnt TO FORMONLY.b_count #總筆數
      DISPLAY g_browser_idx TO FORMONLY.h_index #當下筆數
      DISPLAY g_browser_cnt TO FORMONLY.h_count #總筆數
      DISPLAY g_detail_idx  TO FORMONLY.idx     #單身當下筆數
      DISPLAY g_detail_cnt  TO FORMONLY.cnt     #單身總筆數
   ELSE
      DISPLAY '' TO FORMONLY.b_index #當下筆數
      DISPLAY '' TO FORMONLY.b_count #總筆數
      DISPLAY '' TO FORMONLY.h_index #當下筆數
      DISPLAY '' TO FORMONLY.h_count #總筆數
      DISPLAY '' TO FORMONLY.idx     #單身當下筆數
      DISPLAY '' TO FORMONLY.cnt     #單身總筆數
   END IF
 
   LET g_rec_b = g_cnt - 1
   LET g_detail_cnt = g_rec_b
   LET g_cnt = 0
 
   #若無資料則關閉相關功能
   IF g_browser_cnt = 0 THEN
      CALL cl_set_act_visible("statechange,modify,modify_detail,delete,reproduce,mainhidden", FALSE)
      CALL cl_navigator_setting(0,0)
   ELSE
      CALL cl_set_act_visible("mainhidden", TRUE)
   END IF
                  
   
   #add-point:browser_fill段結束前 name="browser_fill.after"
   
   #end add-point   
 
END FUNCTION
 
{</section>}
 
{<section id="afat505.ui_headershow" >}
#+ 單頭資料重新顯示
PRIVATE FUNCTION afat505_ui_headershow()
   #add-point:ui_headershow段define(客製用) name="ui_headershow.define_customerization"
   
   #end add-point  
   #add-point:ui_headershow段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="ui_headershow.define"
   
   #end add-point      
   
   #add-point:Function前置處理  name="ui_headershow.pre_function"
   
   #end add-point
   
   LET g_fabg_m.fabgld = g_browser[g_current_idx].b_fabgld   
   LET g_fabg_m.fabgdocno = g_browser[g_current_idx].b_fabgdocno   
 
   EXECUTE afat505_master_referesh USING g_fabg_m.fabgld,g_fabg_m.fabgdocno INTO g_fabg_m.fabgsite,g_fabg_m.fabg001, 
       g_fabg_m.fabgld,g_fabg_m.fabg002,g_fabg_m.fabg003,g_fabg_m.fabg004,g_fabg_m.fabg005,g_fabg_m.fabgdocno, 
       g_fabg_m.fabgdocdt,g_fabg_m.fabg010,g_fabg_m.fabg017,g_fabg_m.fabg018,g_fabg_m.fabgstus,g_fabg_m.fabgownid, 
       g_fabg_m.fabgowndp,g_fabg_m.fabgcrtid,g_fabg_m.fabgcrtdp,g_fabg_m.fabgcrtdt,g_fabg_m.fabgmodid, 
       g_fabg_m.fabgmoddt,g_fabg_m.fabgcnfid,g_fabg_m.fabgcnfdt,g_fabg_m.fabgpstid,g_fabg_m.fabgpstdt, 
       g_fabg_m.fabgsite_desc,g_fabg_m.fabg001_desc,g_fabg_m.fabgld_desc,g_fabg_m.fabg002_desc,g_fabg_m.fabg003_desc, 
       g_fabg_m.fabgownid_desc,g_fabg_m.fabgowndp_desc,g_fabg_m.fabgcrtid_desc,g_fabg_m.fabgcrtdp_desc, 
       g_fabg_m.fabgmodid_desc,g_fabg_m.fabgcnfid_desc,g_fabg_m.fabgpstid_desc
   
   CALL afat505_fabg_t_mask()
   CALL afat505_show()
      
END FUNCTION
 
{</section>}
 
{<section id="afat505.ui_detailshow" >}
#+ 單身資料重新顯示
PRIVATE FUNCTION afat505_ui_detailshow()
   #add-point:ui_detailshow段define(客製用) name="ui_detailshow.define_customerization"
   
   #end add-point    
   #add-point:ui_detailshow段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="ui_detailshow.define"
   
   #end add-point    
 
   #add-point:Function前置處理 name="ui_detailshow.before"
   
   #end add-point    
   
   IF g_curr_diag IS NOT NULL THEN
      CALL g_curr_diag.setCurrentRow("s_detail1",g_detail_idx)      
 
   END IF
   
   #add-point:ui_detailshow段after name="ui_detailshow.after"
   
   #end add-point    
   
END FUNCTION
 
{</section>}
 
{<section id="afat505.ui_browser_refresh" >}
#+ 瀏覽頁簽資料重新顯示
PRIVATE FUNCTION afat505_ui_browser_refresh()
   #add-point:ui_browser_refresh段define(客製用) name="ui_browser_refresh.define_customerization"
   
   #end add-point    
   DEFINE l_i  LIKE type_t.num10
   #add-point:ui_browser_refresh段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="ui_browser_refresh.define"
   
   #end add-point    
   
   #add-point:Function前置處理  name="ui_browser_refresh.pre_function"
   
   #end add-point
   
   LET g_browser_cnt = g_browser.getLength()
   LET g_header_cnt  = g_browser.getLength()
   FOR l_i =1 TO g_browser.getLength()
      IF g_browser[l_i].b_fabgld = g_fabg_m.fabgld 
         AND g_browser[l_i].b_fabgdocno = g_fabg_m.fabgdocno 
 
         THEN
         CALL g_browser.deleteElement(l_i)
         EXIT FOR
      END IF
   END FOR
   LET g_browser_cnt = g_browser_cnt - 1
   LET g_header_cnt = g_header_cnt - 1
    
   #若無資料則關閉相關功能
   IF g_browser_cnt = 0 THEN
      CALL cl_set_act_visible("statechange,modify,modify_detail,delete,reproduce,mainhidden", FALSE)
      CALL cl_navigator_setting(0,0)
      CLEAR FORM
   ELSE
      CALL cl_set_act_visible("mainhidden", TRUE)
   END IF
   
   #add-point:ui_browser_refresh段after name="ui_browser_refresh.after"
   
   #end add-point    
   
END FUNCTION
 
{</section>}
 
{<section id="afat505.construct" >}
#+ QBE資料查詢
PRIVATE FUNCTION afat505_construct()
   #add-point:cs段define(客製用) name="cs.define_customerization"
   
   #end add-point    
   DEFINE ls_return   STRING
   DEFINE ls_result   STRING 
   DEFINE ls_wc       STRING 
   DEFINE la_wc       DYNAMIC ARRAY OF RECORD
          tableid     STRING,
          wc          STRING
          END RECORD
   DEFINE li_idx      LIKE type_t.num10
   #add-point:cs段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="cs.define"
   DEFINE l_comp_str  STRING  #161111-00049#12 add 
   #end add-point    
   
   #add-point:Function前置處理  name="cs.pre_function"
   
   #end add-point
    
   #清除畫面
   CLEAR FORM                
   INITIALIZE g_fabg_m.* TO NULL
   CALL g_fabo_d.clear()        
 
   
   LET g_action_choice = ""
    
   INITIALIZE g_wc TO NULL
   INITIALIZE g_wc2 TO NULL
   
   INITIALIZE g_wc2_table1 TO NULL
 
    
   LET g_qryparam.state = 'c'
   
   #add-point:cs段開始前 name="cs.before_construct"
   LET g_site_str = NULL #160125-00005#7
   #end add-point 
   
   #使用DIALOG包住 單頭CONSTRUCT及單身CONSTRUCT
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
      
      #單頭
      CONSTRUCT BY NAME g_wc ON fabgsite,fabg001,fabgld,fabg002,fabg003,fabg004,fabg005,fabgdocno,fabgdocdt, 
          fabg010,fabg017,fabg018,fabgstus,fabgownid,fabgowndp,fabgcrtid,fabgcrtdp,fabgcrtdt,fabgmodid, 
          fabgmoddt,fabgcnfid,fabgcnfdt,fabgpstid,fabgpstdt
 
         BEFORE CONSTRUCT
            #add-point:cs段before_construct name="cs.head.before_construct"
            
            #end add-point 
            
         #公用欄位開窗相關處理
         #應用 a11 樣板自動產生(Version:3)
         #共用欄位查詢處理  
         ##----<<fabgcrtdt>>----
         AFTER FIELD fabgcrtdt
            CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
            IF NOT cl_null(ls_result) THEN
               IF NOT cl_chk_date_symbol(ls_result) THEN
                  LET ls_result = cl_add_date_extra_cond(ls_result)
               END IF
            END IF
            CALL FGL_DIALOG_SETBUFFER(ls_result)
 
         #----<<fabgmoddt>>----
         AFTER FIELD fabgmoddt
            CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
            IF NOT cl_null(ls_result) THEN
               IF NOT cl_chk_date_symbol(ls_result) THEN
                  LET ls_result = cl_add_date_extra_cond(ls_result)
               END IF
            END IF
            CALL FGL_DIALOG_SETBUFFER(ls_result)
         
         #----<<fabgcnfdt>>----
         AFTER FIELD fabgcnfdt
            CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
            IF NOT cl_null(ls_result) THEN
               IF NOT cl_chk_date_symbol(ls_result) THEN
                  LET ls_result = cl_add_date_extra_cond(ls_result)
               END IF
            END IF
            CALL FGL_DIALOG_SETBUFFER(ls_result)
         
         #----<<fabgpstdt>>----
         AFTER FIELD fabgpstdt
            CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
            IF NOT cl_null(ls_result) THEN
               IF NOT cl_chk_date_symbol(ls_result) THEN
                  LET ls_result = cl_add_date_extra_cond(ls_result)
               END IF
            END IF
            CALL FGL_DIALOG_SETBUFFER(ls_result)
 
 
 
            
         #一般欄位開窗相關處理    
                  #Ctrlp:construct.c.fabgsite
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fabgsite
            #add-point:ON ACTION controlp INFIELD fabgsite name="construct.c.fabgsite"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.where =" ooef207='Y'"    #160426-00014#33 add lujh
            CALL q_ooef001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO fabgsite  #顯示到畫面上
            NEXT FIELD fabgsite                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fabgsite
            #add-point:BEFORE FIELD fabgsite name="construct.b.fabgsite"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fabgsite
            
            #add-point:AFTER FIELD fabgsite name="construct.a.fabgsite"
            CALL FGL_DIALOG_GETBUFFER() RETURNING g_site_str #160125-00005#7
            #END add-point
            
 
 
         #Ctrlp:construct.c.fabg001
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fabg001
            #add-point:ON ACTION controlp INFIELD fabg001 name="construct.c.fabg001"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001_7()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO fabg001  #顯示到畫面上
            NEXT FIELD fabg001                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fabg001
            #add-point:BEFORE FIELD fabg001 name="construct.b.fabg001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fabg001
            
            #add-point:AFTER FIELD fabg001 name="construct.a.fabg001"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.fabgld
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fabgld
            #add-point:ON ACTION controlp INFIELD fabgld name="construct.c.fabgld"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.arg1 = g_user
            LET g_qryparam.arg2 = g_dept
            #160125-00005#7--add--str--
            #账套范围
            CALL s_axrt300_get_site(g_user,g_site_str,'2')  RETURNING g_wc_cs_ld 
            IF NOT cl_null(g_wc_cs_ld) THEN   
               LET g_qryparam.where = g_wc_cs_ld
            END IF
            #160125-00005#7--add--end
            CALL q_authorised_ld()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO fabgld  #顯示到畫面上
            NEXT FIELD fabgld                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fabgld
            #add-point:BEFORE FIELD fabgld name="construct.b.fabgld"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fabgld
            
            #add-point:AFTER FIELD fabgld name="construct.a.fabgld"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.fabg002
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fabg002
            #add-point:ON ACTION controlp INFIELD fabg002 name="construct.c.fabg002"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO fabg002  #顯示到畫面上
            NEXT FIELD fabg002                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fabg002
            #add-point:BEFORE FIELD fabg002 name="construct.b.fabg002"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fabg002
            
            #add-point:AFTER FIELD fabg002 name="construct.a.fabg002"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.fabg003
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fabg003
            #add-point:ON ACTION controlp INFIELD fabg003 name="construct.c.fabg003"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.arg1 = g_today
            CALL q_ooeg001_4()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO fabg003  #顯示到畫面上
            NEXT FIELD fabg003                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fabg003
            #add-point:BEFORE FIELD fabg003 name="construct.b.fabg003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fabg003
            
            #add-point:AFTER FIELD fabg003 name="construct.a.fabg003"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fabg004
            #add-point:BEFORE FIELD fabg004 name="construct.b.fabg004"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fabg004
            
            #add-point:AFTER FIELD fabg004 name="construct.a.fabg004"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.fabg004
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fabg004
            #add-point:ON ACTION controlp INFIELD fabg004 name="construct.c.fabg004"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fabg005
            #add-point:BEFORE FIELD fabg005 name="construct.b.fabg005"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fabg005
            
            #add-point:AFTER FIELD fabg005 name="construct.a.fabg005"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.fabg005
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fabg005
            #add-point:ON ACTION controlp INFIELD fabg005 name="construct.c.fabg005"
            
            #END add-point
 
 
         #Ctrlp:construct.c.fabgdocno
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fabgdocno
            #add-point:ON ACTION controlp INFIELD fabgdocno name="construct.c.fabgdocno"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.where = "fabg005 = '17'"
            #161104-00046#22 add ------
            #單別權限控管
            IF NOT cl_null(g_user_dept_wc_q) AND NOT g_user_dept_wc_q = ' 1=1'  THEN
               LET g_qryparam.where = g_qryparam.where," AND ",g_user_dept_wc_q CLIPPED
            END IF
            #161104-00046#22 add end---
            CALL q_fabgdocno()
            DISPLAY g_qryparam.return1 TO fabgdocno
            NEXT FIELD fabgdocno
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fabgdocno
            #add-point:BEFORE FIELD fabgdocno name="construct.b.fabgdocno"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fabgdocno
            
            #add-point:AFTER FIELD fabgdocno name="construct.a.fabgdocno"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fabgdocdt
            #add-point:BEFORE FIELD fabgdocdt name="construct.b.fabgdocdt"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fabgdocdt
            
            #add-point:AFTER FIELD fabgdocdt name="construct.a.fabgdocdt"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.fabgdocdt
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fabgdocdt
            #add-point:ON ACTION controlp INFIELD fabgdocdt name="construct.c.fabgdocdt"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fabg010
            #add-point:BEFORE FIELD fabg010 name="construct.b.fabg010"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fabg010
            
            #add-point:AFTER FIELD fabg010 name="construct.a.fabg010"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.fabg010
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fabg010
            #add-point:ON ACTION controlp INFIELD fabg010 name="construct.c.fabg010"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fabg017
            #add-point:BEFORE FIELD fabg017 name="construct.b.fabg017"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fabg017
            
            #add-point:AFTER FIELD fabg017 name="construct.a.fabg017"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.fabg017
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fabg017
            #add-point:ON ACTION controlp INFIELD fabg017 name="construct.c.fabg017"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fabg018
            #add-point:BEFORE FIELD fabg018 name="construct.b.fabg018"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fabg018
            
            #add-point:AFTER FIELD fabg018 name="construct.a.fabg018"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.fabg018
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fabg018
            #add-point:ON ACTION controlp INFIELD fabg018 name="construct.c.fabg018"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fabgstus
            #add-point:BEFORE FIELD fabgstus name="construct.b.fabgstus"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fabgstus
            
            #add-point:AFTER FIELD fabgstus name="construct.a.fabgstus"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.fabgstus
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fabgstus
            #add-point:ON ACTION controlp INFIELD fabgstus name="construct.c.fabgstus"
            
            #END add-point
 
 
         #Ctrlp:construct.c.fabgownid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fabgownid
            #add-point:ON ACTION controlp INFIELD fabgownid name="construct.c.fabgownid"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO fabgownid  #顯示到畫面上
            NEXT FIELD fabgownid                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fabgownid
            #add-point:BEFORE FIELD fabgownid name="construct.b.fabgownid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fabgownid
            
            #add-point:AFTER FIELD fabgownid name="construct.a.fabgownid"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.fabgowndp
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fabgowndp
            #add-point:ON ACTION controlp INFIELD fabgowndp name="construct.c.fabgowndp"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooeg001_9()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO fabgowndp  #顯示到畫面上
            NEXT FIELD fabgowndp                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fabgowndp
            #add-point:BEFORE FIELD fabgowndp name="construct.b.fabgowndp"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fabgowndp
            
            #add-point:AFTER FIELD fabgowndp name="construct.a.fabgowndp"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.fabgcrtid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fabgcrtid
            #add-point:ON ACTION controlp INFIELD fabgcrtid name="construct.c.fabgcrtid"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO fabgcrtid  #顯示到畫面上
            NEXT FIELD fabgcrtid                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fabgcrtid
            #add-point:BEFORE FIELD fabgcrtid name="construct.b.fabgcrtid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fabgcrtid
            
            #add-point:AFTER FIELD fabgcrtid name="construct.a.fabgcrtid"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.fabgcrtdp
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fabgcrtdp
            #add-point:ON ACTION controlp INFIELD fabgcrtdp name="construct.c.fabgcrtdp"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooeg001_9()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO fabgcrtdp  #顯示到畫面上
            NEXT FIELD fabgcrtdp                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fabgcrtdp
            #add-point:BEFORE FIELD fabgcrtdp name="construct.b.fabgcrtdp"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fabgcrtdp
            
            #add-point:AFTER FIELD fabgcrtdp name="construct.a.fabgcrtdp"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fabgcrtdt
            #add-point:BEFORE FIELD fabgcrtdt name="construct.b.fabgcrtdt"
            
            #END add-point
 
 
         #Ctrlp:construct.c.fabgmodid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fabgmodid
            #add-point:ON ACTION controlp INFIELD fabgmodid name="construct.c.fabgmodid"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO fabgmodid  #顯示到畫面上
            NEXT FIELD fabgmodid                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fabgmodid
            #add-point:BEFORE FIELD fabgmodid name="construct.b.fabgmodid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fabgmodid
            
            #add-point:AFTER FIELD fabgmodid name="construct.a.fabgmodid"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fabgmoddt
            #add-point:BEFORE FIELD fabgmoddt name="construct.b.fabgmoddt"
            
            #END add-point
 
 
         #Ctrlp:construct.c.fabgcnfid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fabgcnfid
            #add-point:ON ACTION controlp INFIELD fabgcnfid name="construct.c.fabgcnfid"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO fabgcnfid  #顯示到畫面上
            NEXT FIELD fabgcnfid                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fabgcnfid
            #add-point:BEFORE FIELD fabgcnfid name="construct.b.fabgcnfid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fabgcnfid
            
            #add-point:AFTER FIELD fabgcnfid name="construct.a.fabgcnfid"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fabgcnfdt
            #add-point:BEFORE FIELD fabgcnfdt name="construct.b.fabgcnfdt"
            
            #END add-point
 
 
         #Ctrlp:construct.c.fabgpstid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fabgpstid
            #add-point:ON ACTION controlp INFIELD fabgpstid name="construct.c.fabgpstid"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO fabgpstid  #顯示到畫面上
            NEXT FIELD fabgpstid                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fabgpstid
            #add-point:BEFORE FIELD fabgpstid name="construct.b.fabgpstid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fabgpstid
            
            #add-point:AFTER FIELD fabgpstid name="construct.a.fabgpstid"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fabgpstdt
            #add-point:BEFORE FIELD fabgpstdt name="construct.b.fabgpstdt"
            
            #END add-point
 
 
 
         
      END CONSTRUCT
 
      #單身根據table分拆construct
      CONSTRUCT g_wc2_table1 ON faboseq,fabo001,fabo002,fabo003,fabo005,fabo007,fabo043,fabo044,fabo045, 
          fabo046,fabo047,fabo048,fabo023,fabo000
           FROM s_detail1[1].faboseq,s_detail1[1].fabo001,s_detail1[1].fabo002,s_detail1[1].fabo003, 
               s_detail1[1].fabo005,s_detail1[1].fabo007,s_detail1[1].fabo043,s_detail1[1].fabo044,s_detail1[1].fabo045, 
               s_detail1[1].fabo046,s_detail1[1].fabo047,s_detail1[1].fabo048,s_detail1[1].fabo023,s_detail1[1].fabo000 
 
                      
         BEFORE CONSTRUCT
            #add-point:cs段before_construct name="cs.body.before_construct"
            
            #end add-point 
            
       #單身公用欄位開窗相關處理
       
         
       #單身一般欄位開窗相關處理
                #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD faboseq
            #add-point:BEFORE FIELD faboseq name="construct.b.page1.faboseq"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD faboseq
            
            #add-point:AFTER FIELD faboseq name="construct.a.page1.faboseq"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.faboseq
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD faboseq
            #add-point:ON ACTION controlp INFIELD faboseq name="construct.c.page1.faboseq"
            
            #END add-point
 
 
         #Ctrlp:construct.c.page1.fabo001
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fabo001
            #add-point:ON ACTION controlp INFIELD fabo001 name="construct.c.page1.fabo001"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            #161111-00049#12 add s---
			   CALL s_axrt300_get_site(g_user,'','3') RETURNING l_comp_str 
			   LET l_comp_str = cl_replace_str(l_comp_str ,"ooef017","faah032")
			   LET g_qryparam.where = " faah032 IN (SELECT ooef017 FROM ooef_t WHERE ooefent = ",g_enterprise," AND ooef001 = '",g_site,"') AND ",l_comp_str             
            #161111-00049#12 add e---              
            CALL q_faah003_3()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO fabo001  #顯示到畫面上
            NEXT FIELD fabo001                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fabo001
            #add-point:BEFORE FIELD fabo001 name="construct.b.page1.fabo001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fabo001
            
            #add-point:AFTER FIELD fabo001 name="construct.a.page1.fabo001"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.fabo002
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fabo002
            #add-point:ON ACTION controlp INFIELD fabo002 name="construct.c.page1.fabo002"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            #161111-00049#12 add s---
			   CALL s_axrt300_get_site(g_user,'','3') RETURNING l_comp_str 
			   LET l_comp_str = cl_replace_str(l_comp_str ,"ooef017","faah032")
			   LET g_qryparam.where = " faah032 IN (SELECT ooef017 FROM ooef_t WHERE ooefent = ",g_enterprise," AND ooef001 = '",g_site,"') AND ",l_comp_str             
            #161111-00049#12 add e---              
            CALL q_faah003_3()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO fabo002  #顯示到畫面上
            NEXT FIELD fabo002                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fabo002
            #add-point:BEFORE FIELD fabo002 name="construct.b.page1.fabo002"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fabo002
            
            #add-point:AFTER FIELD fabo002 name="construct.a.page1.fabo002"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.fabo003
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fabo003
            #add-point:ON ACTION controlp INFIELD fabo003 name="construct.c.page1.fabo003"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            #161111-00049#12 add s---
			   CALL s_axrt300_get_site(g_user,'','3') RETURNING l_comp_str 
			   LET l_comp_str = cl_replace_str(l_comp_str ,"ooef017","faah032")
			   LET g_qryparam.where = " faah032 IN (SELECT ooef017 FROM ooef_t WHERE ooefent = ",g_enterprise," AND ooef001 = '",g_site,"') AND ",l_comp_str             
            #161111-00049#12 add e---              
            CALL q_faah003_3()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO fabo003  #顯示到畫面上
            NEXT FIELD fabo003                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fabo003
            #add-point:BEFORE FIELD fabo003 name="construct.b.page1.fabo003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fabo003
            
            #add-point:AFTER FIELD fabo003 name="construct.a.page1.fabo003"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fabo005
            #add-point:BEFORE FIELD fabo005 name="construct.b.page1.fabo005"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fabo005
            
            #add-point:AFTER FIELD fabo005 name="construct.a.page1.fabo005"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.fabo005
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fabo005
            #add-point:ON ACTION controlp INFIELD fabo005 name="construct.c.page1.fabo005"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fabo007
            #add-point:BEFORE FIELD fabo007 name="construct.b.page1.fabo007"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fabo007
            
            #add-point:AFTER FIELD fabo007 name="construct.a.page1.fabo007"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.fabo007
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fabo007
            #add-point:ON ACTION controlp INFIELD fabo007 name="construct.c.page1.fabo007"
            
            #END add-point
 
 
         #Ctrlp:construct.c.page1.fabo043
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fabo043
            #add-point:ON ACTION controlp INFIELD fabo043 name="construct.c.page1.fabo043"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooef001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO fabo043  #顯示到畫面上
            NEXT FIELD fabo043                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fabo043
            #add-point:BEFORE FIELD fabo043 name="construct.b.page1.fabo043"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fabo043
            
            #add-point:AFTER FIELD fabo043 name="construct.a.page1.fabo043"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.fabo044
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fabo044
            #add-point:ON ACTION controlp INFIELD fabo044 name="construct.c.page1.fabo044"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooef001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO fabo044  #顯示到畫面上
            NEXT FIELD fabo044                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fabo044
            #add-point:BEFORE FIELD fabo044 name="construct.b.page1.fabo044"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fabo044
            
            #add-point:AFTER FIELD fabo044 name="construct.a.page1.fabo044"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.fabo045
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fabo045
            #add-point:ON ACTION controlp INFIELD fabo045 name="construct.c.page1.fabo045"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooef001_04()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO fabo045  #顯示到畫面上
            NEXT FIELD fabo045                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fabo045
            #add-point:BEFORE FIELD fabo045 name="construct.b.page1.fabo045"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fabo045
            
            #add-point:AFTER FIELD fabo045 name="construct.a.page1.fabo045"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.fabo046
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fabo046
            #add-point:ON ACTION controlp INFIELD fabo046 name="construct.c.page1.fabo046"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            #161111-00049#12 add s---
			   CALL s_axrt300_get_site(g_user,'','1') RETURNING l_comp_str 
			   LET g_qryparam.where = l_comp_str             
            #161111-00049#12 add e---              
            CALL q_ooef001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO fabo046  #顯示到畫面上
            NEXT FIELD fabo046                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fabo046
            #add-point:BEFORE FIELD fabo046 name="construct.b.page1.fabo046"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fabo046
            
            #add-point:AFTER FIELD fabo046 name="construct.a.page1.fabo046"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.fabo047
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fabo047
            #add-point:ON ACTION controlp INFIELD fabo047 name="construct.c.page1.fabo047"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            #161111-00049#12 add s---
			   CALL s_axrt300_get_site(g_user,'','1') RETURNING l_comp_str 
			   LET g_qryparam.where = l_comp_str             
            #161111-00049#12 add e---             
            CALL q_ooef001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO fabo047  #顯示到畫面上
            NEXT FIELD fabo047                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fabo047
            #add-point:BEFORE FIELD fabo047 name="construct.b.page1.fabo047"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fabo047
            
            #add-point:AFTER FIELD fabo047 name="construct.a.page1.fabo047"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.fabo048
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fabo048
            #add-point:ON ACTION controlp INFIELD fabo048 name="construct.c.page1.fabo048"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.arg1 = '3'
#            CALL q_ooef001_04()       #141201-00019#1 mrak
            #161111-00049#12 add s---
			   CALL s_axrt300_get_site(g_user,'','1') RETURNING l_comp_str 
			   LET g_qryparam.where = l_comp_str             
            #161111-00049#12 add e---  
            CALL q_ooef001_45()      #141201-00019#1 add                     #呼叫開窗
            DISPLAY g_qryparam.return1 TO fabo048  #顯示到畫面上
            NEXT FIELD fabo048                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fabo048
            #add-point:BEFORE FIELD fabo048 name="construct.b.page1.fabo048"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fabo048
            
            #add-point:AFTER FIELD fabo048 name="construct.a.page1.fabo048"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.fabo023
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fabo023
            #add-point:ON ACTION controlp INFIELD fabo023 name="construct.c.page1.fabo023"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.arg1 = "3904"
            CALL q_oocq002()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO fabo023  #顯示到畫面上
            NEXT FIELD fabo023                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fabo023
            #add-point:BEFORE FIELD fabo023 name="construct.b.page1.fabo023"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fabo023
            
            #add-point:AFTER FIELD fabo023 name="construct.a.page1.fabo023"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fabo000
            #add-point:BEFORE FIELD fabo000 name="construct.b.page1.fabo000"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fabo000
            
            #add-point:AFTER FIELD fabo000 name="construct.a.page1.fabo000"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.fabo000
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fabo000
            #add-point:ON ACTION controlp INFIELD fabo000 name="construct.c.page1.fabo000"
            
            #END add-point
 
 
   
       
      END CONSTRUCT
      
 
      
 
      
      #add-point:cs段add_cs(本段內只能出現新的CONSTRUCT指令) name="cs.add_cs"
      
      #end add-point
 
      BEFORE DIALOG
         CALL cl_qbe_init()
         #add-point:cs段b_dialog name="cs.b_dialog"
         
         #end add-point  
 
      #查詢方案列表
      ON ACTION qbe_select
         LET ls_wc = ""
         CALL cl_qbe_list("c") RETURNING ls_wc
         IF NOT cl_null(ls_wc) THEN
            CALL util.JSON.parse(ls_wc, la_wc)
            INITIALIZE g_wc, g_wc2, g_wc2_table1, g_wc2_extend TO NULL
 
            FOR li_idx = 1 TO la_wc.getLength()
               CASE
                  WHEN la_wc[li_idx].tableid = "fabg_t" 
                     LET g_wc = la_wc[li_idx].wc
                  WHEN la_wc[li_idx].tableid = "fabo_t" 
                     LET g_wc2_table1 = la_wc[li_idx].wc
 
               END CASE
            END FOR
         END IF
    
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
 
 
 
   
   #add-point:cs段結束前 name="cs.after_construct"
   #161104-00046#22 add ------
   IF cl_null(g_user_dept_wc)THEN
      LET g_user_dept_wc = ' 1=1'
   END IF
   IF g_user_dept_wc <>  " 1=1" THEN
      LET g_wc = g_wc ," AND ", g_user_dept_wc CLIPPED
   END IF
   #161104-00046#22 add end---
   #end add-point    
 
   IF INT_FLAG THEN
      RETURN
   END IF
 
END FUNCTION
 
{</section>}
 
{<section id="afat505.query" >}
#+ 資料查詢QBE功能準備
PRIVATE FUNCTION afat505_query()
   #add-point:query段define(客製用) name="query.define_customerization"
   
   #end add-point   
   DEFINE ls_wc STRING
   #add-point:query段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="query.define"
   
   #end add-point   
   
   #add-point:Function前置處理  name="query.pre_function"
   
   #end add-point
   
   #切換畫面
   
   LET ls_wc = g_wc
   
   LET INT_FLAG = 0
   CALL cl_navigator_setting( g_current_idx, g_detail_cnt )
   ERROR ""
   
   #清除畫面及相關資料
   CLEAR FORM
   CALL g_browser.clear()       
   CALL g_fabo_d.clear()
 
   
   #add-point:query段other name="query.other"
   
   #end add-point   
   
   DISPLAY '' TO FORMONLY.idx
   DISPLAY '' TO FORMONLY.cnt
   DISPLAY '' TO FORMONLY.b_index
   DISPLAY '' TO FORMONLY.b_count
   DISPLAY '' TO FORMONLY.h_index
   DISPLAY '' TO FORMONLY.h_count
   
   CALL afat505_construct()
 
   IF INT_FLAG THEN
      #取消查詢
      LET INT_FLAG = 0
      #LET g_wc = ls_wc
      LET g_wc = " 1=2"
      CALL afat505_browser_fill("")
      CALL afat505_fetch("")
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
   LET g_detail_idx_list[1] = 1
 
   LET g_error_show  = 1
   LET g_wc_filter   = ""
   LET l_ac = 1
   CALL FGL_SET_ARR_CURR(1)
   CALL afat505_browser_fill("F")
         
   IF g_browser_cnt = 0 THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code = "-100" 
      LET g_errparam.popup = TRUE 
      CALL cl_err()
   ELSE
      CALL afat505_fetch("F") 
      #顯示單身筆數
      CALL afat505_idx_chk()
   END IF
 
END FUNCTION
 
{</section>}
 
{<section id="afat505.fetch" >}
#+ 指定PK後抓取單頭其他資料
PRIVATE FUNCTION afat505_fetch(p_flag)
   #add-point:fetch段define(客製用) name="fetch.define_customerization"
   
   #end add-point    
   DEFINE p_flag     LIKE type_t.chr1
   DEFINE ls_msg     STRING
   #add-point:fetch段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="fetch.define"
   
   #end add-point    
   
   #add-point:Function前置處理  name="fetch.pre_function"
   
   #end add-point
   
   IF g_browser_cnt = 0 THEN
      RETURN
   END IF
 
   #清空第二階單身
 
   
   CALL cl_ap_performance_next_start()
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
 
   
   LET g_current_row = g_current_idx
   LET g_detail_cnt = g_header_cnt                  
   
   #單身總筆數顯示
   IF g_detail_cnt > 0 THEN
      #若單身有資料時, idx至少為1
      IF g_detail_idx <= 0 THEN
         LET g_detail_idx = 1
      END IF
      DISPLAY g_detail_idx TO FORMONLY.idx  
   ELSE
      LET g_detail_idx = 0
      DISPLAY '' TO FORMONLY.idx    
   END IF
   
   #瀏覽頁筆數顯示
   LET g_pagestart = g_current_idx
   DISPLAY g_pagestart TO FORMONLY.b_index   #當下筆數
   DISPLAY g_pagestart TO FORMONLY.h_index   #當下筆數
   
   CALL cl_navigator_setting( g_pagestart, g_browser_cnt )
 
   #代表沒有資料
   IF g_current_idx = 0 OR g_browser.getLength() = 0 THEN
      RETURN
   END IF
   
   #避免超出browser資料筆數上限
   IF g_current_idx > g_browser.getLength() THEN
      LET g_browser_idx = g_browser.getLength()
      LET g_current_idx = g_browser.getLength()
   END IF
   
   LET g_fabg_m.fabgld = g_browser[g_current_idx].b_fabgld
   LET g_fabg_m.fabgdocno = g_browser[g_current_idx].b_fabgdocno
 
   
   #重讀DB,因TEMP有不被更新特性
   EXECUTE afat505_master_referesh USING g_fabg_m.fabgld,g_fabg_m.fabgdocno INTO g_fabg_m.fabgsite,g_fabg_m.fabg001, 
       g_fabg_m.fabgld,g_fabg_m.fabg002,g_fabg_m.fabg003,g_fabg_m.fabg004,g_fabg_m.fabg005,g_fabg_m.fabgdocno, 
       g_fabg_m.fabgdocdt,g_fabg_m.fabg010,g_fabg_m.fabg017,g_fabg_m.fabg018,g_fabg_m.fabgstus,g_fabg_m.fabgownid, 
       g_fabg_m.fabgowndp,g_fabg_m.fabgcrtid,g_fabg_m.fabgcrtdp,g_fabg_m.fabgcrtdt,g_fabg_m.fabgmodid, 
       g_fabg_m.fabgmoddt,g_fabg_m.fabgcnfid,g_fabg_m.fabgcnfdt,g_fabg_m.fabgpstid,g_fabg_m.fabgpstdt, 
       g_fabg_m.fabgsite_desc,g_fabg_m.fabg001_desc,g_fabg_m.fabgld_desc,g_fabg_m.fabg002_desc,g_fabg_m.fabg003_desc, 
       g_fabg_m.fabgownid_desc,g_fabg_m.fabgowndp_desc,g_fabg_m.fabgcrtid_desc,g_fabg_m.fabgcrtdp_desc, 
       g_fabg_m.fabgmodid_desc,g_fabg_m.fabgcnfid_desc,g_fabg_m.fabgpstid_desc
   
   #遮罩相關處理
   LET g_fabg_m_mask_o.* =  g_fabg_m.*
   CALL afat505_fabg_t_mask()
   LET g_fabg_m_mask_n.* =  g_fabg_m.*
   
   #根據資料狀態切換action狀態
   CALL cl_set_act_visible("statechange,modify,modify_detail,delete,reproduce", TRUE)
   CALL afat505_set_act_visible()   
   CALL afat505_set_act_no_visible()
   
   #add-point:fetch段action控制 name="fetch.action_control"
   CALL cl_set_act_visible("modify,delete,insert,modify_detail", TRUE)
   IF g_fabg_m.fabgstus NOT MATCHES "[NDR]" THEN   # N未確認/D抽單/R已拒絕允許修改
      CALL cl_set_act_visible("modify,delete,modify_detail", FALSE)
   END IF
   #end add-point  
   
   
   
   #add-point:fetch結束前 name="fetch.after"
   
   #end add-point
   
   #保存單頭舊值
   LET g_fabg_m_t.* = g_fabg_m.*
   LET g_fabg_m_o.* = g_fabg_m.*
   
   LET g_data_owner = g_fabg_m.fabgownid      
   LET g_data_dept  = g_fabg_m.fabgowndp
   
   #重新顯示   
   CALL afat505_show()
 
   #應用 a56 樣板自動產生(Version:3)
   #檢查此單據是否需顯示BPM簽核狀況按鈕 
   IF cl_bpm_chk() THEN
      CALL cl_set_act_visible("bpm_status",TRUE)
   ELSE
      CALL cl_set_act_visible("bpm_status",FALSE)
   END IF
 
 
 
 
 
END FUNCTION
 
{</section>}
 
{<section id="afat505.insert" >}
#+ 資料新增
PRIVATE FUNCTION afat505_insert()
   #add-point:insert段define(客製用) name="insert.define_customerization"
   
   #end add-point    
   #add-point:insert段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="insert.define"
   DEFINE l_fabgcomp   LIKE fabg_t.fabgcomp
   DEFINE l_success  LIKE type_t.chr1 #1106
   #end add-point    
   
   #add-point:Function前置處理  name="insert.pre_function"
   
   #end add-point
   
   #清畫面欄位內容
   CLEAR FORM                    
   CALL g_fabo_d.clear()   
 
 
   INITIALIZE g_fabg_m.* TO NULL             #DEFAULT 設定
   
   LET g_fabgld_t = NULL
   LET g_fabgdocno_t = NULL
 
   
   LET g_master_insert = FALSE
   
   #add-point:insert段before name="insert.before"
   
   #end add-point    
   
   CALL s_transaction_begin()
   WHILE TRUE
      #公用欄位給值(單頭)
      #應用 a14 樣板自動產生(Version:5)    
      #公用欄位新增給值  
      LET g_fabg_m.fabgownid = g_user
      LET g_fabg_m.fabgowndp = g_dept
      LET g_fabg_m.fabgcrtid = g_user
      LET g_fabg_m.fabgcrtdp = g_dept 
      LET g_fabg_m.fabgcrtdt = cl_get_current()
      LET g_fabg_m.fabgmodid = g_user
      LET g_fabg_m.fabgmoddt = cl_get_current()
      LET g_fabg_m.fabgstus = 'N'
 
 
 
 
      #append欄位給值
      
     
      #一般欄位給值
            LET g_fabg_m.fabg005 = "8"
      LET g_fabg_m.fabg010 = "N"
      LET g_fabg_m.fabg017 = "N"
      LET g_fabg_m.fabg018 = "N"
      LET g_fabg_m.fabgstus = "N"
 
  
      #add-point:單頭預設值 name="insert.default"

      
      LET g_fabg_m.fabg004   = g_today
      LET g_fabg_m.fabgdocdt = g_today  
      LET g_fabg_m.fabg005 = "17"
#      SELECT faab002 INTO g_fabg_m.fabgsite FROM faab_t,ooag_t
#       WHERE faab004 = ooag004 AND faabent = ooagent
#         AND ooag001 = g_user AND ooagent = g_enterprise
#         AND faab007 = 'Y' AND faab001= '4'
#1106 mod--str--
#     #資產中心
#     CALL s_fin_get_account_center('',g_user,'5',g_today) RETURNING g_sub_success,g_fabg_m.fabgsite,g_errno
#     #帳套
#     CALL s_fin_ld_carry('',g_user) RETURNING g_sub_success,g_fabg_m.fabgld,l_fabgcomp,g_errno
#
      CALL s_afat503_default(g_bookno) RETURNING l_success,g_fabg_m.fabgsite,g_fabg_m.fabgld,l_fabgcomp #20141106
      #161215-00044#1---modify----begin-----------------
      #SELECT * INTO g_glaa.* 
      SELECT glaaent,glaaownid,glaaowndp,glaacrtid,glaacrtdp,glaacrtdt,glaamodid,glaamoddt,glaastus,glaald,
             glaacomp,glaa001,glaa002,glaa003,glaa004,glaa005,glaa006,glaa007,glaa008,glaa009,glaa010,glaa011,
             glaa012,glaa013,glaa014,glaa015,glaa016,glaa017,glaa018,glaa019,glaa020,glaa021,glaa022,glaa023,
             glaa024,glaa025,glaa026,glaa100,glaa101,glaa102,glaa103,glaa111,glaa112,glaa113,glaa120,glaa121,
             glaa122,glaa027,glaa130,glaa131,glaa132,glaa133,glaa134,glaa135,glaa136,glaa137,glaa138,glaa139,
             glaa140,glaa123,glaa124,glaa028 INTO g_glaa.* 
      #161215-00044#1---modify----end-----------------
      FROM glaa_t WHERE glaaent = g_enterprise AND glaald = g_fabg_m.fabgld
      LET g_fabg_m.fabg001 = g_user
      IF NOT cl_null(g_fabg_m.fabgsite) THEN
         IF NOT s_afat502_site_user_chk(g_fabg_m.fabgsite,g_fabg_m.fabg001) THEN 
            LET g_fabg_m.fabg001 = NULL
         END IF 
      END IF
      CALL afat505_fabg001_desc() 
      DISPLAY BY NAME g_fabg_m.fabg001_desc       
#1106 mod--end--
#     SELECT DISTINCT glaald INTO g_fabg_m.fabgld 
#       FROM glaa_t,ooef_t,ooag_t
#      WHERE ooag004 = ooef001 AND ooagent = ooefent AND glaacomp = ooef017 AND ooefent = glaaent AND glaa014 = 'Y'
#        AND ooag001 = g_user AND glaaent = g_enterprise
     DISPLAY BY NAME g_fabg_m.fabgld,g_fabg_m.fabgsite
     
     CALL afat505_fabgld_desc()
     CALL afat505_fabgsite_desc() 
     #申請人員、部門、時間
     LET g_fabg_m.fabg002=g_user
#     LET g_fabg_m.fabg003=g_dept         #mark by yangxf
     #add by yangxf ----
     SELECT ooag003 INTO g_fabg_m.fabg003
       FROM ooag_t
      WHERE ooagent = g_enterprise
        AND ooag001 = g_fabg_m.fabg002
     #add by yangxf ---
     CALL afat505_fabg002_desc()
     CALL afat505_fabg003_desc()
      #end add-point 
      
      #保存單頭舊值(用於資料輸入錯誤還原預設值時使用)
      LET g_fabg_m_t.* = g_fabg_m.*
      LET g_fabg_m_o.* = g_fabg_m.*
      
      #顯示狀態(stus)圖片
            #應用 a21 樣板自動產生(Version:3)
	  #根據當下狀態碼顯示圖片
      CASE g_fabg_m.fabgstus 
         WHEN "A"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/approved.png")
         WHEN "D"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/withdraw.png")
         WHEN "N"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/unconfirmed.png")
         WHEN "R"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/rejection.png")
         WHEN "W"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/signing.png")
         WHEN "Y"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/confirmed.png")
         WHEN "Z"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/unposted.png")
         WHEN "S"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/posted.png")
         WHEN "X"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/invalid.png")
         
      END CASE
 
 
 
    
      CALL afat505_input("a")
      
      #add-point:單頭輸入後 name="insert.after_insert"
      
      #end add-point
      
      IF INT_FLAG THEN
         LET INT_FLAG = 0
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = '' 
         LET g_errparam.code = 9001 
         LET g_errparam.popup = FALSE 
         CALL s_transaction_end('N','0')
         CALL cl_err()
      END IF
      
      IF NOT g_master_insert THEN
         DISPLAY g_detail_cnt  TO FORMONLY.h_count    #總筆數
         DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
         INITIALIZE g_fabg_m.* TO NULL
         INITIALIZE g_fabo_d TO NULL
 
         #add-point:取消新增後 name="insert.cancel"
         
         #end add-point 
         CALL afat505_show()
         RETURN
      END IF
      
      LET INT_FLAG = 0
      #CALL g_fabo_d.clear()
 
 
      LET g_rec_b = 0
      CALL s_transaction_end('Y','0')
      EXIT WHILE
        
   END WHILE
   
   #根據資料狀態切換action狀態
   CALL cl_set_act_visible("statechange,modify,modify_detail,delete,reproduce", TRUE)
   CALL afat505_set_act_visible()   
   CALL afat505_set_act_no_visible()
   
   #將新增的資料併入搜尋條件中
   LET g_fabgld_t = g_fabg_m.fabgld
   LET g_fabgdocno_t = g_fabg_m.fabgdocno
 
   
   #組合新增資料的條件
   LET g_add_browse = " fabgent = " ||g_enterprise|| " AND",
                      " fabgld = '", g_fabg_m.fabgld, "' "
                      ," AND fabgdocno = '", g_fabg_m.fabgdocno, "' "
 
                      
   #add-point:組合新增資料的條件後 name="insert.after.add_browse"
   
   #end add-point
      
   #填到最後面
   LET g_current_idx = g_browser.getLength() + 1
   CALL afat505_browser_fill("")
   
   DISPLAY g_browser_cnt TO FORMONLY.h_count    #總筆數
   DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
   CALL cl_navigator_setting(g_current_idx, g_browser_cnt)
   
   CLOSE afat505_cl
   
   CALL afat505_idx_chk()
   
   #撈取異動後的資料(主要是帶出reference)
   EXECUTE afat505_master_referesh USING g_fabg_m.fabgld,g_fabg_m.fabgdocno INTO g_fabg_m.fabgsite,g_fabg_m.fabg001, 
       g_fabg_m.fabgld,g_fabg_m.fabg002,g_fabg_m.fabg003,g_fabg_m.fabg004,g_fabg_m.fabg005,g_fabg_m.fabgdocno, 
       g_fabg_m.fabgdocdt,g_fabg_m.fabg010,g_fabg_m.fabg017,g_fabg_m.fabg018,g_fabg_m.fabgstus,g_fabg_m.fabgownid, 
       g_fabg_m.fabgowndp,g_fabg_m.fabgcrtid,g_fabg_m.fabgcrtdp,g_fabg_m.fabgcrtdt,g_fabg_m.fabgmodid, 
       g_fabg_m.fabgmoddt,g_fabg_m.fabgcnfid,g_fabg_m.fabgcnfdt,g_fabg_m.fabgpstid,g_fabg_m.fabgpstdt, 
       g_fabg_m.fabgsite_desc,g_fabg_m.fabg001_desc,g_fabg_m.fabgld_desc,g_fabg_m.fabg002_desc,g_fabg_m.fabg003_desc, 
       g_fabg_m.fabgownid_desc,g_fabg_m.fabgowndp_desc,g_fabg_m.fabgcrtid_desc,g_fabg_m.fabgcrtdp_desc, 
       g_fabg_m.fabgmodid_desc,g_fabg_m.fabgcnfid_desc,g_fabg_m.fabgpstid_desc
   
   
   #遮罩相關處理
   LET g_fabg_m_mask_o.* =  g_fabg_m.*
   CALL afat505_fabg_t_mask()
   LET g_fabg_m_mask_n.* =  g_fabg_m.*
   
   #將資料顯示到畫面上
   DISPLAY BY NAME g_fabg_m.fabgsite,g_fabg_m.fabgsite_desc,g_fabg_m.fabg001,g_fabg_m.fabg001_desc,g_fabg_m.fabgld, 
       g_fabg_m.fabgld_desc,g_fabg_m.fabg002,g_fabg_m.fabg002_desc,g_fabg_m.fabg003,g_fabg_m.fabg003_desc, 
       g_fabg_m.fabg004,g_fabg_m.fabg005,g_fabg_m.fabgdocno,g_fabg_m.fabgdocdt,g_fabg_m.fabg010,g_fabg_m.fabg017, 
       g_fabg_m.fabg018,g_fabg_m.fabgstus,g_fabg_m.fabgownid,g_fabg_m.fabgownid_desc,g_fabg_m.fabgowndp, 
       g_fabg_m.fabgowndp_desc,g_fabg_m.fabgcrtid,g_fabg_m.fabgcrtid_desc,g_fabg_m.fabgcrtdp,g_fabg_m.fabgcrtdp_desc, 
       g_fabg_m.fabgcrtdt,g_fabg_m.fabgmodid,g_fabg_m.fabgmodid_desc,g_fabg_m.fabgmoddt,g_fabg_m.fabgcnfid, 
       g_fabg_m.fabgcnfid_desc,g_fabg_m.fabgcnfdt,g_fabg_m.fabgpstid,g_fabg_m.fabgpstid_desc,g_fabg_m.fabgpstdt 
 
   
   #add-point:新增結束後 name="insert.after"
   
   #end add-point 
   
   LET g_data_owner = g_fabg_m.fabgownid      
   LET g_data_dept  = g_fabg_m.fabgowndp
   
   #功能已完成,通報訊息中心
   CALL afat505_msgcentre_notify('insert')
   
END FUNCTION
 
{</section>}
 
{<section id="afat505.modify" >}
#+ 資料修改
PRIVATE FUNCTION afat505_modify()
   #add-point:modify段define(客製用) name="modify.define_customerization"
   
   #end add-point    
   DEFINE l_new_key    DYNAMIC ARRAY OF STRING
   DEFINE l_old_key    DYNAMIC ARRAY OF STRING
   DEFINE l_field_key  DYNAMIC ARRAY OF STRING
   DEFINE l_wc2_table1          STRING
 
 
   #add-point:modify段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="modify.define"
   
   #end add-point    
   
   #add-point:Function前置處理  name="modify.pre_function"
   
   #end add-point
   
   #保存單頭舊值
   LET g_fabg_m_t.* = g_fabg_m.*
   LET g_fabg_m_o.* = g_fabg_m.*
   
   IF g_fabg_m.fabgld IS NULL
   OR g_fabg_m.fabgdocno IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code = "std-00003" 
      LET g_errparam.popup = FALSE 
      CALL cl_err()
      RETURN
   END IF
 
   ERROR ""
  
   LET g_fabgld_t = g_fabg_m.fabgld
   LET g_fabgdocno_t = g_fabg_m.fabgdocno
 
   CALL s_transaction_begin()
   
   OPEN afat505_cl USING g_enterprise,g_fabg_m.fabgld,g_fabg_m.fabgdocno
   IF SQLCA.SQLCODE THEN   #(ver:78)
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "OPEN afat505_cl:",SQLERRMESSAGE 
      LET g_errparam.code = SQLCA.SQLCODE   #(ver:78)
      LET g_errparam.popup = TRUE 
      CLOSE afat505_cl
      CALL s_transaction_end('N','0')
      CALL cl_err()
      RETURN
   END IF
 
   #顯示最新的資料
   EXECUTE afat505_master_referesh USING g_fabg_m.fabgld,g_fabg_m.fabgdocno INTO g_fabg_m.fabgsite,g_fabg_m.fabg001, 
       g_fabg_m.fabgld,g_fabg_m.fabg002,g_fabg_m.fabg003,g_fabg_m.fabg004,g_fabg_m.fabg005,g_fabg_m.fabgdocno, 
       g_fabg_m.fabgdocdt,g_fabg_m.fabg010,g_fabg_m.fabg017,g_fabg_m.fabg018,g_fabg_m.fabgstus,g_fabg_m.fabgownid, 
       g_fabg_m.fabgowndp,g_fabg_m.fabgcrtid,g_fabg_m.fabgcrtdp,g_fabg_m.fabgcrtdt,g_fabg_m.fabgmodid, 
       g_fabg_m.fabgmoddt,g_fabg_m.fabgcnfid,g_fabg_m.fabgcnfdt,g_fabg_m.fabgpstid,g_fabg_m.fabgpstdt, 
       g_fabg_m.fabgsite_desc,g_fabg_m.fabg001_desc,g_fabg_m.fabgld_desc,g_fabg_m.fabg002_desc,g_fabg_m.fabg003_desc, 
       g_fabg_m.fabgownid_desc,g_fabg_m.fabgowndp_desc,g_fabg_m.fabgcrtid_desc,g_fabg_m.fabgcrtdp_desc, 
       g_fabg_m.fabgmodid_desc,g_fabg_m.fabgcnfid_desc,g_fabg_m.fabgpstid_desc
   
   #檢查是否允許此動作
   IF NOT afat505_action_chk() THEN
      CALL s_transaction_end('N','0')
      RETURN
   END IF
   
   #遮罩相關處理
   LET g_fabg_m_mask_o.* =  g_fabg_m.*
   CALL afat505_fabg_t_mask()
   LET g_fabg_m_mask_n.* =  g_fabg_m.*
   
   
   
   #add-point:modify段show之前 name="modify.before_show"
   
   #end add-point  
   
   #LET l_wc2_table1 = g_wc2_table1
   #LET g_wc2_table1 = " 1=1"
 
 
   
   CALL afat505_show()
   #add-point:modify段show之後 name="modify.after_show"
   #151231-00005#4--add--str--lujh
   IF NOT cl_null(g_fabg_m.fabgdocdt) THEN 
      IF NOT s_afa_date_chk(g_fabg_m.fabgld,'',g_fabg_m.fabgdocdt) THEN 
         CLOSE afat505_cl
         CALL s_transaction_end('N','0')
         RETURN
      END IF 
   END IF 
   #151231-00005#4--add--end--lujh
   #end add-point
   
   #LET g_wc2_table1 = l_wc2_table1
 
 
    
   WHILE TRUE
      LET g_fabgld_t = g_fabg_m.fabgld
      LET g_fabgdocno_t = g_fabg_m.fabgdocno
 
      
      #寫入修改者/修改日期資訊(單頭)
      LET g_fabg_m.fabgmodid = g_user 
LET g_fabg_m.fabgmoddt = cl_get_current()
LET g_fabg_m.fabgmodid_desc = cl_get_username(g_fabg_m.fabgmodid)
      
      #add-point:modify段修改前 name="modify.before_input"
      #「D抽單 / R已拒絕」狀況碼更改資料後，需還原為「N未確認」
      IF g_fabg_m.fabgstus MATCHES "[DR]" THEN 
         LET g_fabg_m.fabgstus = "N"
      END IF
      
      IF g_fabg_m.fabgstus<>'N' THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = '' 
         LET g_errparam.code   = 'aim-00090'
         LET g_errparam.popup  = FALSE 
         CALL cl_err()
         RETURN
      END IF
      #end add-point
      
      #欄位更改
      LET g_loc = 'n'
      LET g_update = FALSE
      LET g_master_commit = "N"
      CALL afat505_input("u")
      LET g_loc = 'n'
 
      #add-point:modify段修改後 name="modify.after_input"
      
      #end add-point
      
      IF g_update OR NOT INT_FLAG THEN
         #若有modid跟moddt則進行update
         UPDATE fabg_t SET (fabgmodid,fabgmoddt) = (g_fabg_m.fabgmodid,g_fabg_m.fabgmoddt)
          WHERE fabgent = g_enterprise AND fabgld = g_fabgld_t
            AND fabgdocno = g_fabgdocno_t
 
      END IF
    
      IF INT_FLAG THEN
         CALL s_transaction_end('N','0')
         LET INT_FLAG = 0
         #若單頭無commit則還原
         IF g_master_commit = "N" THEN
            LET g_fabg_m.* = g_fabg_m_t.*
            CALL afat505_show()
         END IF
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = '' 
         LET g_errparam.code = 9001 
         LET g_errparam.popup = FALSE 
         CALL cl_err()
         RETURN
      END IF 
                  
      #若單頭key欄位有變更
      IF g_fabg_m.fabgld != g_fabg_m_t.fabgld
      OR g_fabg_m.fabgdocno != g_fabg_m_t.fabgdocno
 
      THEN
         CALL s_transaction_begin()
         
         #add-point:單身fk修改前 name="modify.body.b_fk_update"
         
         #end add-point
         
         #更新單身key值
         UPDATE fabo_t SET fabold = g_fabg_m.fabgld
                                       ,fabodocno = g_fabg_m.fabgdocno
 
          WHERE faboent = g_enterprise AND fabold = g_fabg_m_t.fabgld
            AND fabodocno = g_fabg_m_t.fabgdocno
 
            
         #add-point:單身fk修改中 name="modify.body.m_fk_update"
         
         #end add-point
 
         CASE
            WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
            #   INITIALIZE g_errparam TO NULL 
            #   LET g_errparam.extend = "fabo_t" 
            #   LET g_errparam.code = "std-00009" 
            #   LET g_errparam.popup = TRUE 
            #   CALL cl_err()
            #   CALL s_transaction_end('N','0')
            #   CONTINUE WHILE
            WHEN SQLCA.SQLCODE #其他錯誤
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "fabo_t:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE 
               LET g_errparam.popup = TRUE 
               CALL s_transaction_end('N','0')
               CALL cl_err()
               CONTINUE WHILE
         END CASE
         
         #add-point:單身fk修改後 name="modify.body.a_fk_update"
         
         #end add-point
         
 
         
 
         
         #UPDATE 多語言table key值
         
 
         CALL s_transaction_end('Y','0')
      END IF
    
      EXIT WHILE
   END WHILE
 
   #根據資料狀態切換action狀態
   CALL cl_set_act_visible("statechange,modify,modify_detail,delete,reproduce", TRUE)
   CALL afat505_set_act_visible()   
   CALL afat505_set_act_no_visible()
 
   #組合新增資料的條件
   LET g_add_browse = " fabgent = " ||g_enterprise|| " AND",
                      " fabgld = '", g_fabg_m.fabgld, "' "
                      ," AND fabgdocno = '", g_fabg_m.fabgdocno, "' "
 
   #填到對應位置
   CALL afat505_browser_fill("")
 
   CLOSE afat505_cl
   
   CALL s_transaction_end('Y','0')
 
   #功能已完成,通報訊息中心
   CALL afat505_msgcentre_notify('modify')
 
END FUNCTION 
 
{</section>}
 
{<section id="afat505.input" >}
#+ 資料輸入
PRIVATE FUNCTION afat505_input(p_cmd)
   #add-point:input段define(客製用) name="input.define_customerization"
   
   #end add-point  
   DEFINE  p_cmd                 LIKE type_t.chr1
   DEFINE  l_cmd_t               LIKE type_t.chr1
   DEFINE  l_cmd                 LIKE type_t.chr1
   DEFINE  l_n                   LIKE type_t.num10                #檢查重複用  
   DEFINE  l_cnt                 LIKE type_t.num10                #檢查重複用  
   DEFINE  l_lock_sw             LIKE type_t.chr1                #單身鎖住否  
   DEFINE  l_allow_insert        LIKE type_t.num5                #可新增否 
   DEFINE  l_allow_delete        LIKE type_t.num5                #可刪除否  
   DEFINE  l_count               LIKE type_t.num10
   DEFINE  l_i                   LIKE type_t.num10
   DEFINE  l_ac_t                LIKE type_t.num10
   DEFINE  l_insert              BOOLEAN
   DEFINE  ls_return             STRING
   DEFINE  l_var_keys            DYNAMIC ARRAY OF STRING
   DEFINE  l_field_keys          DYNAMIC ARRAY OF STRING
   DEFINE  l_vars                DYNAMIC ARRAY OF STRING
   DEFINE  l_fields              DYNAMIC ARRAY OF STRING
   DEFINE  l_var_keys_bak        DYNAMIC ARRAY OF STRING
   DEFINE  lb_reproduce          BOOLEAN
   DEFINE  li_reproduce          LIKE type_t.num10
   DEFINE  li_reproduce_target   LIKE type_t.num10
   DEFINE  ls_keys               DYNAMIC ARRAY OF VARCHAR(500)
   #add-point:input段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="input.define"
   DEFINE  l_faab004             LIKE faab_t.faab004
   DEFINE  l_ooag004             LIKE ooag_t.ooag004
   DEFINE  l_ooef004             LIKE ooef_t.ooef004
   DEFINE  l_success             LIKE type_t.num5
   DEFINE  l_ooab002             LIKE ooab_t.ooab002
   DEFINE  l_n2                  LIKE type_t.num5 
   DEFINE  l_n3                  LIKE type_t.num5 
   DEFINE  l_n4                  LIKE type_t.num5 
   DEFINE  l_n5                  LIKE type_t.num5 
   DEFINE  l_n6                  LIKE type_t.num5 
   DEFINE  l_sql                 STRING
   DEFINE  l_fabo001             LIKE fabo_t.fabo001
   DEFINE  l_fabo002             LIKE fabo_t.fabo002
   DEFINE  l_fabo003             LIKE fabo_t.fabo003
   DEFINE  l_n7                  LIKE type_t.num5 
   DEFINE  l_fabgdocno           LIKE fabg_t.fabgdocno
   DEFINE  l_faah015             LIKE faah_t.faah015
   DEFINE  l_n1                  LIKE type_t.num5 
   DEFINE l_fabgcomp             LIKE fabg_t.fabgcomp
   DEFINE l_origin_str           STRING   #組織範圍
   DEFINE l_ooef017              LIKE ooef_t.ooef017
   DEFINE l_ooef017_1            LIKE ooef_t.ooef017
   DEFINE l_fabo047              LIKE fabo_t.fabo047
   DEFINE l_cnt1                 LIKE type_t.num5
   DEFINE l_ooef204              LIKE ooef_t.ooef204
   DEFINE l_ooef003              LIKE ooef_t.ooef003
   #151125-00006#2-add-s
   DEFINE  l_ooba002             LIKE ooba_t.ooba002
   DEFINE  l_dfin0031            LIKE type_t.chr1
   DEFINE  l_dfin0032            LIKE type_t.chr1
#   DEFINE  l_fabgcomp            LIKE fabg_t.fabgcomp
   DEFINE  l_ld                  LIKE fabg_t.fabgld
   #151125-00006#2-add-e
   DEFINE l_comp_str  STRING  #161111-00049#12 add
   DEFINE  l_flag                LIKE type_t.num5      #161104-00046#22
   #end add-point  
   
   #add-point:Function前置處理  name="input.pre_function"
 
   #end add-point
   
   #先做狀態判定
   IF p_cmd = 'r' THEN
      LET l_cmd_t = 'r'
      LET p_cmd   = 'a'
   ELSE
      LET l_cmd_t = p_cmd
   END IF   
   
   #將資料輸出到畫面上
   DISPLAY BY NAME g_fabg_m.fabgsite,g_fabg_m.fabgsite_desc,g_fabg_m.fabg001,g_fabg_m.fabg001_desc,g_fabg_m.fabgld, 
       g_fabg_m.fabgld_desc,g_fabg_m.fabg002,g_fabg_m.fabg002_desc,g_fabg_m.fabg003,g_fabg_m.fabg003_desc, 
       g_fabg_m.fabg004,g_fabg_m.fabg005,g_fabg_m.fabgdocno,g_fabg_m.fabgdocdt,g_fabg_m.fabg010,g_fabg_m.fabg017, 
       g_fabg_m.fabg018,g_fabg_m.fabgstus,g_fabg_m.fabgownid,g_fabg_m.fabgownid_desc,g_fabg_m.fabgowndp, 
       g_fabg_m.fabgowndp_desc,g_fabg_m.fabgcrtid,g_fabg_m.fabgcrtid_desc,g_fabg_m.fabgcrtdp,g_fabg_m.fabgcrtdp_desc, 
       g_fabg_m.fabgcrtdt,g_fabg_m.fabgmodid,g_fabg_m.fabgmodid_desc,g_fabg_m.fabgmoddt,g_fabg_m.fabgcnfid, 
       g_fabg_m.fabgcnfid_desc,g_fabg_m.fabgcnfdt,g_fabg_m.fabgpstid,g_fabg_m.fabgpstid_desc,g_fabg_m.fabgpstdt 
 
   
   #切換畫面
 
   CALL cl_set_head_visible("","YES")  
 
   LET l_insert = FALSE
   LET g_action_choice = ""
 
   #add-point:input段define_sql name="input.define_sql"
   
   #end add-point 
   LET g_forupd_sql = "SELECT faboseq,fabo001,fabo002,fabo003,fabo005,fabo007,fabo043,fabo044,fabo045, 
       fabo046,fabo047,fabo048,fabo023,fabo000 FROM fabo_t WHERE faboent=? AND fabold=? AND fabodocno=?  
       AND faboseq=? FOR UPDATE"
   #add-point:input段define_sql name="input.after_define_sql"
   
   #end add-point 
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE afat505_bcl CURSOR FROM g_forupd_sql
   
 
   
 
 
   #add-point:input段define_sql name="input.other_sql"
   
   #end add-point 
 
   LET l_allow_insert = cl_auth_detail_input("insert")
   LET l_allow_delete = cl_auth_detail_input("delete")
   LET g_qryparam.state = 'i'
   
   #控制key欄位可否輸入
   CALL afat505_set_entry(p_cmd)
   #add-point:set_entry後 name="input.after_set_entry"
   
   #end add-point
   CALL afat505_set_no_entry(p_cmd)
 
   DISPLAY BY NAME g_fabg_m.fabgsite,g_fabg_m.fabg001,g_fabg_m.fabgld,g_fabg_m.fabg002,g_fabg_m.fabg003, 
       g_fabg_m.fabg004,g_fabg_m.fabg005,g_fabg_m.fabgdocno,g_fabg_m.fabgdocdt,g_fabg_m.fabg010,g_fabg_m.fabg017, 
       g_fabg_m.fabg018,g_fabg_m.fabgstus
   
   LET lb_reproduce = FALSE
   LET l_ac_t = 1
   
   #關閉被遮罩相關欄位輸入, 無法確定USER是否會需要輸入此欄位
   #因此先行關閉, 若有需要可於下方add-point中自行開啟
   CALL cl_mask_set_no_entry()
   
   #add-point:資料輸入前 name="input.before_input"
   LET g_errshow = 1
   #end add-point
   
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
 
{</section>}
 
{<section id="afat505.input.head" >}
      #單頭段
      INPUT BY NAME g_fabg_m.fabgsite,g_fabg_m.fabg001,g_fabg_m.fabgld,g_fabg_m.fabg002,g_fabg_m.fabg003, 
          g_fabg_m.fabg004,g_fabg_m.fabg005,g_fabg_m.fabgdocno,g_fabg_m.fabgdocdt,g_fabg_m.fabg010,g_fabg_m.fabg017, 
          g_fabg_m.fabg018,g_fabg_m.fabgstus 
         ATTRIBUTE(WITHOUT DEFAULTS)
         
         #自訂ACTION(master_input)
         
     
         BEFORE INPUT
            IF s_transaction_chk("N",0) THEN
               CALL s_transaction_begin()
            END IF
            OPEN afat505_cl USING g_enterprise,g_fabg_m.fabgld,g_fabg_m.fabgdocno
            IF SQLCA.SQLCODE THEN   #(ver:78)
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "OPEN afat505_cl:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE   #(ver:78)
               LET g_errparam.popup = TRUE 
               CLOSE afat505_cl
               CALL s_transaction_end('N','0')
               CALL cl_err()
               RETURN
            END IF
            
            IF l_cmd_t = 'r' THEN
               
            END IF
            #因應離開單頭後已寫入資料庫, 若重新回到單頭則視為修改
            #因此需於此處開啟/關閉欄位
            CALL afat505_set_entry(p_cmd)
            #add-point:資料輸入前 name="input.m.before_input"
            
            #end add-point
            CALL afat505_set_no_entry(p_cmd)
    
                  #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fabgsite
            
            #add-point:AFTER FIELD fabgsite name="input.a.fabgsite"
#160426-00014#33--mark--str--lujh
#            IF NOT cl_null(g_fabg_m.fabgsite) THEN
#               #检查组织资料的合理性             
#               IF NOT s_afat502_site_chk(g_fabg_m.fabgsite ) THEN
#                  LET g_fabg_m.fabgsite = g_fabg_m_t.fabgsite
#                  CALL afat505_fabgsite_desc()
#                  NEXT FIELD CURRENT
#               END IF 
#               #帳務人員不為空需要檢查和資產中心的權限
#               IF NOT cl_null(g_fabg_m.fabg001) THEN
#                  IF NOT s_afat502_site_user_chk(g_fabg_m.fabgsite,g_fabg_m.fabg001) THEN
#                     INITIALIZE g_errparam TO NULL
#                     LET g_errparam.code = g_errno
#                     LET g_errparam.extend = ''
#                     LET g_errparam.popup = TRUE
#                     CALL cl_err()
#                     LET g_fabg_m.fabgsite = g_fabg_m_t.fabgsite
#                     CALL afat505_fabgsite_desc()
#                     NEXT FIELD CURRENT  
#                  END IF
#               END IF   
#               #帐套不为空检查法人归属是否相同
#               IF NOT cl_null(g_fabg_m.fabgld) THEN
#                  IF NOT s_afat502_site_ld_chk(g_fabg_m.fabgsite,g_fabg_m.fabgld) THEN
#                     LET g_fabg_m.fabgsite = g_fabg_m_t.fabgsite
#                     CALL afat505_fabgsite_desc()
#                     NEXT FIELD CURRENT  
#                  END IF
#               END IF  
#              ##########################################mark by huangtao 
#            END IF           
#
#            CALL afat505_fabgsite_desc()
#160426-00014#33--mark--end--lujh

#160426-00014#33--add--str--lujh
            IF NOT cl_null(g_fabg_m.fabgsite) THEN
               #IF p_cmd = 'a' OR (p_cmd = 'u' AND (g_fabg_m.fabgsite != g_fabg_m_t.fabgsite OR g_fabg_m_t.fabgsite IS NULL )) THEN #160829-00042#1
               IF g_fabg_m.fabgsite != g_fabg_m_o.fabgsite OR g_fabg_m_o.fabgsite IS NULL THEN  #160829-00042#1               

                  #CALL s_afa_site_chk(g_fabg_m.fabgsite,g_fabg_m_t.fabgsite,'',g_fabg_m.fabgld,g_fabg_m.fabgdocdt) #160829-00042#1
                  CALL s_afa_site_chk(g_fabg_m.fabgsite,g_fabg_m_o.fabgsite,'',g_fabg_m.fabgld,g_fabg_m.fabgdocdt)  #160829-00042#1
                  RETURNING l_success,g_glaa.glaacomp,g_fabg_m.fabgld
                  
                  IF l_success = FALSE THEN 
                     #160829-00042#1 ---s---
                     #LET g_fabg_m.fabgsite = g_fabg_m_t.fabgsite
                     #LET g_fabg_m.fabgld = g_fabg_m_t.fabgld
                     LET g_fabg_m.fabgsite = g_fabg_m_o.fabgsite
                     LET g_fabg_m.fabgld = g_fabg_m_o.fabgld                     
                     #160829-00042#1---e---
                     CALL s_desc_get_ld_desc(g_fabg_m.fabgld) RETURNING g_fabg_m.fabgld_desc
                     CALL s_desc_get_department_desc(g_fabg_m.fabgsite) RETURNING g_fabg_m.fabgsite_desc  #160829-00042#1 
                     DISPLAY BY NAME g_fabg_m.fabgsite_desc,g_fabg_m.fabgld_desc                          #160829-00042#1 
                     NEXT FIELD CURRENT
                  END IF
                  
                  #人员不为空
                  IF NOT cl_null(g_fabg_m.fabg001) THEN
                     CALL s_afa_person_chk(g_fabg_m.fabgsite,g_fabg_m.fabg001)
                     RETURNING l_success
                     IF l_success = FALSE THEN
                        #LET g_fabg_m.fabgsite = g_fabg_m_t.fabgsite #160829-00042#1 ---s---
                        LET g_fabg_m.fabgsite = g_fabg_m_o.fabgsite  #160829-00042#1 ---s---
                        CALL s_desc_get_department_desc(g_fabg_m.fabgsite) RETURNING g_fabg_m.fabgsite_desc
                        DISPLAY BY NAME g_fabg_m.fabgsite_desc
                        NEXT FIELD CURRENT
                     END IF
                  END IF
               END IF
            END IF
            CALL s_fin_account_center_sons_query('5',g_fabg_m.fabgsite,g_today,'1')
            #LET g_fabg_m_t.fabgsite = g_fabg_m.fabgsite
            #LET g_fabg_m_t.fabgld = g_fabg_m.fabgld
            CALL s_desc_get_department_desc(g_fabg_m.fabgsite) RETURNING g_fabg_m.fabgsite_desc
            CALL s_desc_get_ld_desc(g_fabg_m.fabgld) RETURNING g_fabg_m.fabgld_desc
            DISPLAY BY NAME g_fabg_m.fabgsite_desc,g_fabg_m.fabgld_desc
            LET g_fabg_m_o.* = g_fabg_m.*                            #160829-00042#1 ---s---
#160426-00014#33--add--end--lujh

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fabgsite
            #add-point:BEFORE FIELD fabgsite name="input.b.fabgsite"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fabgsite
            #add-point:ON CHANGE fabgsite name="input.g.fabgsite"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fabg001
            
            #add-point:AFTER FIELD fabg001 name="input.a.fabg001"
#160426-00014#33--mark--str--lujh
#            IF NOT cl_null(g_fabg_m.fabg001) THEN
#               #檢查是否存在  員工資料檔中
#               IF NOT ap_chk_isExist(g_fabg_m.fabg001,"SELECT COUNT(1) FROM ooag_t WHERE "||"ooagent = '" ||g_enterprise|| "' AND "||"ooag001 = ? ",'aim-00069',1) THEN
#                  LET g_fabg_m.fabg001 = g_fabg_m_t.fabg001
#                   CALL afat505_fabg001_desc()                   
#                  NEXT FIELD CURRENT
#               END IF   
#               #檢查是否有效               
##               IF NOT ap_chk_isExist(g_fabg_m.fabg001,"SELECT COUNT(1) FROM ooag_t WHERE "||"ooagent = '" ||g_enterprise|| "' AND "||"ooag001 = ? AND ooagstus = 'Y'",'aim-00070',1) THEN
#                IF NOT ap_chk_isExist(g_fabg_m.fabg001,"SELECT COUNT(1) FROM ooag_t WHERE "||"ooagent = '" ||g_enterprise|| "' AND "||"ooag001 = ? AND ooagstus = 'Y'",'sub-01302','aooi130') THEN#160318-00005#11 mod  
#                  LET g_fabg_m.fabg001 = g_fabg_m_t.fabg001
#                   CALL afat505_fabg001_desc()
#                  NEXT FIELD CURRENT
#               END IF      
#                #資產中心不為空的情況下
#               IF NOT cl_null(g_fabg_m.fabgsite) THEN       
#               ##################################add by huangtao
#                  IF NOT s_afat502_site_user_chk(g_fabg_m.fabgsite,g_fabg_m.fabg001) THEN
#                     INITIALIZE g_errparam TO NULL
#                     LET g_errparam.code = g_errno
#                     LET g_errparam.extend = ''
#                     LET g_errparam.popup = TRUE
#                     CALL cl_err()
#                     LET g_fabg_m.fabg001 = g_fabg_m_t.fabg001
#                     CALL afat505_fabg001_desc() 
#                     NEXT FIELD CURRENT
#                  END IF
#               ##################################add by huangtao
#               END IF  
#               ##################################add by huangtao  
#               #帳套不為空時
#                IF NOT cl_null(g_fabg_m.fabgld) THEN
#                   IF NOT s_ld_chk_authorization(g_fabg_m.fabg001,g_fabg_m.fabgld) THEN
#                      INITIALIZE g_errparam TO NULL
#                      LET g_errparam.code = 'axr-00022'     
#                      LET g_errparam.extend = ''
#                      LET g_errparam.popup = TRUE
#                      CALL cl_err() 
#                      LET g_fabg_m.fabg001 = g_fabg_m_t.fabg001
#                      CALL afat505_fabg001_desc() 
#                      NEXT FIELD CURRENT
#                   END IF  
#                END IF                
#               ##################################add by huangtao               
#            END IF    
#            CALL afat505_fabg001_desc()   
#160426-00014#33--mark--end--lujh

#160426-00014#33--add--str--lujh
            IF NOT cl_null(g_fabg_m.fabg001) THEN 
#應用 a19 樣板自動產生(Version:2)
               #校驗代值
               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
               INITIALIZE g_chkparam.* TO NULL
               #設定g_chkparam.*的參數
               LET g_chkparam.arg1 = g_fabg_m.fabg001
                  
               #呼叫檢查存在並帶值的library
               IF cl_chk_exist("v_ooag001") THEN
                  #檢查成功時後續處理
                  #LET  = g_chkparam.return1
                  #DISPLAY BY NAME 
                  IF NOT cl_null(g_fabg_m.fabgsite) THEN 
                     CALL s_afa_person_chk(g_fabg_m.fabgsite,g_fabg_m.fabg001) RETURNING l_success
                     
                     IF l_success = FALSE THEN
                        LET g_fabg_m.fabg001 = g_fabg_m_t.fabg001
                        CALL s_desc_get_person_desc(g_fabg_m.fabg001) RETURNING g_fabg_m.fabg001_desc
                        DISPLAY BY NAME g_fabg_m.fabg001_desc  
                        NEXT FIELD CURRENT
                     END IF
                  END IF
               ELSE
                  #檢查失敗時後續處理
                  NEXT FIELD CURRENT
               END IF
            END IF 
            CALL s_desc_get_person_desc(g_fabg_m.fabg001) RETURNING g_fabg_m.fabg001_desc
            DISPLAY BY NAME g_fabg_m.fabg001_desc  
#160426-00014#33--add--end--lujh

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fabg001
            #add-point:BEFORE FIELD fabg001 name="input.b.fabg001"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fabg001
            #add-point:ON CHANGE fabg001 name="input.g.fabg001"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fabgld
            
            #add-point:AFTER FIELD fabgld name="input.a.fabgld"
            #此段落由子樣板a05產生
            #確認資料無重複
            IF  NOT cl_null(g_fabg_m.fabgld) AND NOT cl_null(g_fabg_m.fabgdocno) THEN 
               IF p_cmd = 'a' OR ( p_cmd = 'u' AND (g_fabg_m.fabgld != g_fabgld_t  OR g_fabg_m.fabgdocno != g_fabgdocno_t )) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(1) FROM fabg_t WHERE "||"fabgent = '" ||g_enterprise|| "' AND "||"fabgld = '"||g_fabg_m.fabgld ||"' AND "|| "fabgdocno = '"||g_fabg_m.fabgdocno ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF

#160426-00014#33--mark--str--lujh
#            IF NOT cl_null(g_fabg_m.fabgld) THEN 
##此段落由子樣板a19產生
#               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
#               INITIALIZE g_chkparam.* TO NULL
#               
#               #設定g_chkparam.*的參數
#               LET g_chkparam.arg1 = g_fabg_m.fabgld
#               #160318-00025#5--add--str
#               LET g_errshow = TRUE 
#               LET g_chkparam.err_str[1] = "agl-00051:sub-01302|agli010|",cl_get_progname("agli010",g_lang,"2"),"|:EXEPROGagli010"
#               #160318-00025#5--add--end
#                  
#               #呼叫檢查存在並帶值的library
#               IF cl_chk_exist("v_fabgld") THEN
#                  #帐套人员不为空时
#                  IF NOT cl_null(g_fabg_m.fabg001) THEN
#                     IF NOT s_ld_chk_authorization(g_fabg_m.fabg001,g_fabg_m.fabgld) THEN
#                        INITIALIZE g_errparam TO NULL
#                        LET g_errparam.code = 'axr-00022'
#                        LET g_errparam.extend = g_fabg_m.fabgld
#                        LET g_errparam.popup = FALSE
#                        CALL cl_err()
#                        LET g_fabg_m.fabgld = g_fabg_m_t.fabgld
#                        CALL afat505_fabgld_desc()
#                        NEXT FIELD CURRENT
#                     END IF
#                  END IF
#                  #资产中心不为空时
#                  IF NOT cl_null(g_fabg_m.fabgsite) THEN
#                     IF NOT s_afat502_site_ld_chk(g_fabg_m.fabgsite,g_fabg_m.fabgld) THEN
#                        LET g_fabg_m.fabgld = g_fabg_m_t.fabgld
#                        CALL afat505_fabgld_desc()
#                        NEXT FIELD CURRENT
#                     END IF
#                  END IF
#                  ########################################mark by huangtao
#                  CALL afat505_glaa_visible()
#               ELSE
#                  #檢查失敗時後續處理
#                  LET g_fabg_m.fabgld = g_fabg_m_t.fabgld
#                  CALL afat505_fabgld_desc()
#                  DISPLAY BY NAME g_fabg_m.fabgld,g_fabg_m.fabgld_desc 
#                  NEXT FIELD CURRENT
#               END IF
#            END IF 
#            
#            CALL afat505_fabgld_desc()
#160426-00014#33--mark--end--lujh

#160426-00014#33--add--str--lujh
            IF NOT cl_null(g_fabg_m.fabgld) THEN
               IF p_cmd = 'a' OR (p_cmd = 'u' AND (g_fabg_m.fabgld != g_fabg_m_t.fabgld OR g_fabg_m_t.fabgld IS NULL )) THEN
                  CALL s_afa_ld_chk(g_fabg_m.fabgsite,g_fabg_m.fabgld)
                  RETURNING l_success,g_glaa.glaacomp
                  
                  IF l_success = FALSE THEN 
                     LET g_fabg_m.fabgld = g_fabg_m_t.fabgld
                     CALL s_desc_get_ld_desc(g_fabg_m.fabgld) RETURNING g_fabg_m.fabgld_desc
                     DISPLAY BY NAME g_fabg_m.fabgld_desc
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF
            LET g_fabg_m_t.fabgld = g_fabg_m.fabgld
            CALL s_desc_get_ld_desc(g_fabg_m.fabgld) RETURNING g_fabg_m.fabgld_desc
            DISPLAY BY NAME g_fabg_m.fabgld_desc
#160426-00014#33--add--end--lujh 
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fabgld
            #add-point:BEFORE FIELD fabgld name="input.b.fabgld"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fabgld
            #add-point:ON CHANGE fabgld name="input.g.fabgld"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fabg002
            
            #add-point:AFTER FIELD fabg002 name="input.a.fabg002"
            IF NOT cl_null(g_fabg_m.fabg002) THEN 
#此段落由子樣板a19產生
               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
               INITIALIZE g_chkparam.* TO NULL
               
               #設定g_chkparam.*的參數
               LET g_chkparam.arg1 = g_fabg_m.fabg002
               #160318-00025#5--add--str
               LET g_errshow = TRUE 
               LET g_chkparam.err_str[1] = "aim-00070:sub-01302|aooi130|",cl_get_progname("aooi130",g_lang,"2"),"|:EXEPROGaooi130"
               #160318-00025#5--add--end  
               #呼叫檢查存在並帶值的library
               IF cl_chk_exist("v_ooag001") THEN
                  #檢查成功時後續處理
                  #LET  = g_chkparam.return1
                  #DISPLAY BY NAME 
               ELSE
                  #檢查失敗時後續處理
                  LET g_fabg_m.fabg002 = g_fabg_m_t.fabg002
                  CALL afat505_fabg002_desc()
                  NEXT FIELD CURRENT
               END IF
               #add by yangxf ----
               SELECT ooag003 INTO g_fabg_m.fabg003
                 FROM ooag_t
                WHERE ooagent = g_enterprise
                  AND ooag001 = g_fabg_m.fabg002
               CALL afat505_fabg003_desc()
               #add by yangxf ---
            END IF 
            CALL afat505_fabg002_desc()

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fabg002
            #add-point:BEFORE FIELD fabg002 name="input.b.fabg002"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fabg002
            #add-point:ON CHANGE fabg002 name="input.g.fabg002"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fabg003
            
            #add-point:AFTER FIELD fabg003 name="input.a.fabg003"
            IF NOT cl_null(g_fabg_m.fabg003) THEN 
#此段落由子樣板a19產生
               #校驗代值
               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
               INITIALIZE g_chkparam.* TO NULL
               
               #設定g_chkparam.*的參數
               LET g_chkparam.arg1 = g_fabg_m.fabg003
               LET g_chkparam.arg2 = g_today
               #160318-00025#5--add--str
               LET g_errshow = TRUE 
               LET g_chkparam.err_str[1] = "aoo-00029:sub-01302|aooi125|",cl_get_progname("aooi125",g_lang,"2"),"|:EXEPROGaooi125"
               #160318-00025#5--add--end   
               #呼叫檢查存在並帶值的library
               IF cl_chk_exist("v_ooeg001_3") THEN
                  #檢查成功時後續處理
                  #LET  = g_chkparam.return1
                  #DISPLAY BY NAME 
                  #add by yangxf ---
                  IF NOT cl_null(g_fabg_m.fabg002) THEN 
                     INITIALIZE g_chkparam.* TO NULL
                     #設定g_chkparam.*的參數
                     LET g_chkparam.arg1 = g_fabg_m.fabg002
                     LET g_chkparam.arg2 = g_fabg_m.fabg003
                        
                     #呼叫檢查存在並帶值的library
                     IF cl_chk_exist("v_ooag003") THEN
                     ELSE
                        #檢查失敗時後續處理
                        LET g_fabg_m.fabg003 = g_fabg_m_t.fabg003
                        CALL afat505_fabg003_desc()
                        NEXT FIELD CURRENT
                     END IF
                  END IF 
                  #add by yangxf ---
               ELSE
                  #檢查失敗時後續處理
                  LET g_fabg_m.fabg003 = g_fabg_m_t.fabg003
                  CALL afat505_fabg003_desc()
                  NEXT FIELD CURRENT
               END IF
           
            END IF 
            CALL afat505_fabg003_desc()
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fabg003
            #add-point:BEFORE FIELD fabg003 name="input.b.fabg003"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fabg003
            #add-point:ON CHANGE fabg003 name="input.g.fabg003"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fabg004
            #add-point:BEFORE FIELD fabg004 name="input.b.fabg004"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fabg004
            
            #add-point:AFTER FIELD fabg004 name="input.a.fabg004"
            IF NOT cl_null(g_fabg_m.fabg004) THEN 
               #單據日期不能小於關賬日期
               #S-FIN-9003
               CALL cl_get_para(g_enterprise,g_site,'S-FIN-9003') RETURNING l_ooab002
               IF g_fabg_m.fabg004 < l_ooab002 THEN 
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'afa-00060'
                  LET g_errparam.extend = ''
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
                  
                  LET g_fabg_m.fabg004 = g_fabg_m_t.fabg004
                  NEXT FIELD fabg004
               END IF
            END IF
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fabg004
            #add-point:ON CHANGE fabg004 name="input.g.fabg004"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fabg005
            #add-point:BEFORE FIELD fabg005 name="input.b.fabg005"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fabg005
            
            #add-point:AFTER FIELD fabg005 name="input.a.fabg005"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fabg005
            #add-point:ON CHANGE fabg005 name="input.g.fabg005"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fabgdocno
            #add-point:BEFORE FIELD fabgdocno name="input.b.fabgdocno"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fabgdocno
            
            #add-point:AFTER FIELD fabgdocno name="input.a.fabgdocno"
            #此段落由子樣板a05產生
            #確認資料無重複
            IF  NOT cl_null(g_fabg_m.fabgld) AND NOT cl_null(g_fabg_m.fabgdocno) THEN 
               IF p_cmd = 'a' OR ( p_cmd = 'u' AND (g_fabg_m.fabgld != g_fabgld_t  OR g_fabg_m.fabgdocno != g_fabgdocno_t )) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(1) FROM fabg_t WHERE "||"fabgent = '" ||g_enterprise|| "' AND "||"fabgld = '"||g_fabg_m.fabgld ||"' AND "|| "fabgdocno = '"||g_fabg_m.fabgdocno ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF
 
            IF NOT cl_null(g_fabg_m.fabgdocno) THEN
#mark by yangxf ---
#               IF NOT s_aooi200_chk_slip(g_fabg_m.fabgdocno,l_ooef004,g_fabg_m.fabgdocno,'afat505') THEN
#                  LET g_fabg_m.fabgdocno = g_fabg_m_t.fabgdocno
#                  NEXT FIELD CURRENT
#               END IF
#mark by yangxf ---
#add by yangxf ---
                #161215-00044#1---modify----begin-----------------
                #SELECT * INTO g_glaa.* 
                SELECT glaaent,glaaownid,glaaowndp,glaacrtid,glaacrtdp,glaacrtdt,glaamodid,glaamoddt,glaastus,glaald,
                       glaacomp,glaa001,glaa002,glaa003,glaa004,glaa005,glaa006,glaa007,glaa008,glaa009,glaa010,glaa011,
                       glaa012,glaa013,glaa014,glaa015,glaa016,glaa017,glaa018,glaa019,glaa020,glaa021,glaa022,glaa023,
                       glaa024,glaa025,glaa026,glaa100,glaa101,glaa102,glaa103,glaa111,glaa112,glaa113,glaa120,glaa121,
                       glaa122,glaa027,glaa130,glaa131,glaa132,glaa133,glaa134,glaa135,glaa136,glaa137,glaa138,glaa139,
                       glaa140,glaa123,glaa124,glaa028 INTO g_glaa.* 
                #161215-00044#1---modify----end-----------------
               FROM glaa_t WHERE glaaent = g_enterprise AND glaald = g_fabg_m.fabgld
               IF NOT s_aooi200_fin_chk_slip(g_fabg_m.fabgld,g_glaa.glaa024,g_fabg_m.fabgdocno,'afat505') THEN
                  LET g_fabg_m.fabgdocno = g_fabg_m_t.fabgdocno
                  NEXT FIELD CURRENT
               END IF
#add by yangxf ---
               #161104-00046#22 add ------
               CALL s_control_chk_doc('1',g_fabg_m.fabgdocno,'4',g_user,g_dept,'','') RETURNING g_sub_success,l_flag
               IF g_sub_success AND l_flag THEN
               ELSE
                  LET g_fabg_m.fabgdocno = g_fabg_m_t.fabgdocno
                  NEXT FIELD CURRENT
               END IF
               CALL s_aooi200_fin_get_slip(g_fabg_m.fabgdocno) RETURNING g_sub_success,g_ap_slip
               #刪除單別預設temptable
               DELETE FROM s_aooi200def1
               #以目前畫面資訊新增temp資料   #請勿調整.*
               INSERT INTO s_aooi200def1 VALUES(g_fabg_m.*)
               #依單別預設取用資訊
               CALL s_aooi200def_get('','',g_fabg_m.fabgsite,'2',g_ap_slip,'','',g_fabg_m.fabgld)
               #依單別預設值TEMP內容 給予到畫面上   #請勿調整.*
               SELECT * INTO g_fabg_m.* FROM s_aooi200def1
               #161104-00046#22 add end---
            END IF
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fabgdocno
            #add-point:ON CHANGE fabgdocno name="input.g.fabgdocno"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fabgdocdt
            #add-point:BEFORE FIELD fabgdocdt name="input.b.fabgdocdt"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fabgdocdt
            
            #add-point:AFTER FIELD fabgdocdt name="input.a.fabgdocdt"
            IF NOT cl_null(g_fabg_m.fabgdocdt) THEN 
               #單據日期不能小於關賬日期
               #S-FIN-9003
               CALL cl_get_para(g_enterprise,g_site,'S-FIN-9003') RETURNING l_ooab002
               IF g_fabg_m.fabgdocdt < l_ooab002 THEN 
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'afa-00060'
                  LET g_errparam.extend = ''
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
               
                  LET g_fabg_m.fabgdocdt = g_fabg_m_t.fabgdocdt
                  NEXT FIELD fabgdocdt
               END IF
            END IF
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fabgdocdt
            #add-point:ON CHANGE fabgdocdt name="input.g.fabgdocdt"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fabg010
            #add-point:BEFORE FIELD fabg010 name="input.b.fabg010"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fabg010
            
            #add-point:AFTER FIELD fabg010 name="input.a.fabg010"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fabg010
            #add-point:ON CHANGE fabg010 name="input.g.fabg010"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fabg017
            #add-point:BEFORE FIELD fabg017 name="input.b.fabg017"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fabg017
            
            #add-point:AFTER FIELD fabg017 name="input.a.fabg017"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fabg017
            #add-point:ON CHANGE fabg017 name="input.g.fabg017"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fabg018
            #add-point:BEFORE FIELD fabg018 name="input.b.fabg018"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fabg018
            
            #add-point:AFTER FIELD fabg018 name="input.a.fabg018"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fabg018
            #add-point:ON CHANGE fabg018 name="input.g.fabg018"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fabgstus
            #add-point:BEFORE FIELD fabgstus name="input.b.fabgstus"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fabgstus
            
            #add-point:AFTER FIELD fabgstus name="input.a.fabgstus"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fabgstus
            #add-point:ON CHANGE fabgstus name="input.g.fabgstus"
            
            #END add-point 
 
 
 #欄位檢查
                  #Ctrlp:input.c.fabgsite
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fabgsite
            #add-point:ON ACTION controlp INFIELD fabgsite name="input.c.fabgsite"
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_fabg_m.fabgsite             #給予default值
 
#            IF NOT cl_null(g_fabg_m.fabg001) THEN    
#               LET g_qryparam.where = " ooef001 IN (SELECT ooag004 FROM ooag_t WHERE ooagent = '",g_enterprise,"' AND ooag001 ='",g_fabg_m.fabg001,"')"
#            END IF
            #給予arg
            LET g_qryparam.arg1 = "" #

            LET g_qryparam.where =" ooef207='Y'"    #160426-00014#33 add lujh
            CALL q_ooef001()                                #呼叫開窗

            LET g_fabg_m.fabgsite = g_qryparam.return1              

            DISPLAY g_fabg_m.fabgsite TO fabgsite              #
            CALL afat505_fabgsite_desc()
            NEXT FIELD fabgsite                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.fabg001
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fabg001
            #add-point:ON ACTION controlp INFIELD fabg001 name="input.c.fabg001"
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_fabg_m.fabg001             #給予default值
            LET g_qryparam.default2 = "" #g_fabg_m.oofa011 #全名
            
#            IF NOT cl_null(g_fabg_m.fabgsite) THEN 
#              LET g_qryparam.where = " ooag004 IN (SELECT ooed004 FROM ooed_t WHERE ooedent = ",g_enterprise,
#                     " AND ooed001 = '5' AND ooed002 = '",g_fabg_m.fabgsite,"') "
#            END IF
            #給予arg
            LET g_qryparam.arg1 = "" #

            
            CALL q_ooag001_7()                                #呼叫開窗

            LET g_fabg_m.fabg001 = g_qryparam.return1              

            DISPLAY g_fabg_m.fabg001 TO fabg001              #
            CALL afat505_fabg001_desc()
            NEXT FIELD fabg001                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.fabgld
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fabgld
            #add-point:ON ACTION controlp INFIELD fabgld name="input.c.fabgld"
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_fabg_m.fabgld             #給予default值
            #取得资产組織下所屬成員
            CALL s_fin_account_center_sons_query('5',g_fabg_m.fabgsite,g_fabg_m.fabgdocdt,'1')
            #取得资产中心下所屬成員之帳別   
            CALL s_fin_account_center_comp_str() RETURNING l_origin_str
            #將取回的字串轉換為SQL條件
            CALL afat505_change_to_sql(l_origin_str) RETURNING l_origin_str  
            
            LET g_qryparam.where = " (glaa008 = 'Y' OR glaa014 = 'Y') AND glaacomp IN (",l_origin_str," )"

            #給予arg
            LET g_qryparam.arg1 = g_user
            LET g_qryparam.arg2 = g_dept
            
            CALL q_authorised_ld()                                #呼叫開窗

            LET g_fabg_m.fabgld = g_qryparam.return1              

            DISPLAY g_fabg_m.fabgld TO fabgld              #
            CALL afat505_fabgld_desc()
            NEXT FIELD fabgld                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.fabg002
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fabg002
            #add-point:ON ACTION controlp INFIELD fabg002 name="input.c.fabg002"
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_fabg_m.fabg002             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "" #

            
            CALL q_ooag001()                                #呼叫開窗

            LET g_fabg_m.fabg002 = g_qryparam.return1              

            DISPLAY g_fabg_m.fabg002 TO fabg002              #
            CALL afat505_fabg002_desc()
            NEXT FIELD fabg002                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.fabg003
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fabg003
            #add-point:ON ACTION controlp INFIELD fabg003 name="input.c.fabg003"
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_fabg_m.fabg003             #給予default值

            #給予arg
            LET g_qryparam.arg1 = g_today

            
            CALL q_ooeg001_4()                                #呼叫開窗

            LET g_fabg_m.fabg003 = g_qryparam.return1              

            DISPLAY g_fabg_m.fabg003 TO fabg003              #
            CALL afat505_fabg003_desc()
            NEXT FIELD fabg003                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.fabg004
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fabg004
            #add-point:ON ACTION controlp INFIELD fabg004 name="input.c.fabg004"
            
            #END add-point
 
 
         #Ctrlp:input.c.fabg005
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fabg005
            #add-point:ON ACTION controlp INFIELD fabg005 name="input.c.fabg005"
            
            #END add-point
 
 
         #Ctrlp:input.c.fabgdocno
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fabgdocno
            #add-point:ON ACTION controlp INFIELD fabgdocno name="input.c.fabgdocno"
            #此段落由子樣板a07產生
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_fabg_m.fabgdocno
#mark by yangxf
#            #給予arg
#            SELECT ooef004 INTO l_ooef004 from ooef_t,ooag_t
#             WHERE ooefent=ooagent AND ooefent = g_enterprise
#               AND ooef001 = ooag004 AND ooag001 = g_user
#
#            LET g_qryparam.arg1 = l_ooef004
#mark by yangxf
#add by yangxf ---
             #161215-00044#1---modify----begin-----------------
             #SELECT * INTO g_glaa.* 
             SELECT glaaent,glaaownid,glaaowndp,glaacrtid,glaacrtdp,glaacrtdt,glaamodid,glaamoddt,glaastus,glaald,
                    glaacomp,glaa001,glaa002,glaa003,glaa004,glaa005,glaa006,glaa007,glaa008,glaa009,glaa010,glaa011,
                    glaa012,glaa013,glaa014,glaa015,glaa016,glaa017,glaa018,glaa019,glaa020,glaa021,glaa022,glaa023,
                    glaa024,glaa025,glaa026,glaa100,glaa101,glaa102,glaa103,glaa111,glaa112,glaa113,glaa120,glaa121,
                    glaa122,glaa027,glaa130,glaa131,glaa132,glaa133,glaa134,glaa135,glaa136,glaa137,glaa138,glaa139,
                    glaa140,glaa123,glaa124,glaa028 INTO g_glaa.* 
             #161215-00044#1---modify----end-----------------
            FROM glaa_t WHERE glaaent = g_enterprise AND glaald = g_fabg_m.fabgld
            LET g_qryparam.arg1 = g_glaa.glaa024
#add by yangxf ---
            #LET g_qryparam.arg2 = "afat505"     #160705-00042#2 160711 by sakura mark
            LET g_qryparam.arg2 = g_prog         #160705-00042#2 160711 by sakura add
            #161104-00046#22 add ------
            IF NOT cl_null(g_user_slip_wc)THEN
               LET g_qryparam.where = g_user_slip_wc
            END IF
            #161104-00046#22 add end---
            CALL q_ooba002_1()
            LET g_fabg_m.fabgdocno = g_qryparam.return1
            DISPLAY g_fabg_m.fabgdocno TO fabgdocno
            NEXT FIELD fabgdocno
            #END add-point
 
 
         #Ctrlp:input.c.fabgdocdt
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fabgdocdt
            #add-point:ON ACTION controlp INFIELD fabgdocdt name="input.c.fabgdocdt"
            
            #END add-point
 
 
         #Ctrlp:input.c.fabg010
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fabg010
            #add-point:ON ACTION controlp INFIELD fabg010 name="input.c.fabg010"
            
            #END add-point
 
 
         #Ctrlp:input.c.fabg017
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fabg017
            #add-point:ON ACTION controlp INFIELD fabg017 name="input.c.fabg017"
            
            #END add-point
 
 
         #Ctrlp:input.c.fabg018
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fabg018
            #add-point:ON ACTION controlp INFIELD fabg018 name="input.c.fabg018"
            
            #END add-point
 
 
         #Ctrlp:input.c.fabgstus
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fabgstus
            #add-point:ON ACTION controlp INFIELD fabgstus name="input.c.fabgstus"
            
            #END add-point
 
 
 #欄位開窗
            
         AFTER INPUT
            IF INT_FLAG THEN
               EXIT DIALOG
            END IF
 
            #CALL cl_err_collect_show()      #錯誤訊息統整顯示
            #CALL cl_showmsg()
            DISPLAY BY NAME g_fabg_m.fabgld,g_fabg_m.fabgdocno
                        
            #add-point:單頭INPUT後 name="input.head.after_input"
            
            #end add-point
                        
            IF p_cmd <> 'u' THEN
    
               CALL s_transaction_begin()
               
               #add-point:單頭新增前 name="input.head.b_insert"
#mark by yangxf ---
#               SELECT ooag004 INTO l_ooag004 FROM ooag_t
#                WHERE ooagent = g_enterprise AND ooag001 = g_user
#               CALL s_aooi200_gen_docno(l_ooag004,g_fabg_m.fabgdocno,g_fabg_m.fabgdocdt,g_prog)
#mark by yangxf ----
#add by yangxf ---
                #161215-00044#1---modify----begin-----------------
                #SELECT * INTO g_glaa.* 
                SELECT glaaent,glaaownid,glaaowndp,glaacrtid,glaacrtdp,glaacrtdt,glaamodid,glaamoddt,glaastus,glaald,
                       glaacomp,glaa001,glaa002,glaa003,glaa004,glaa005,glaa006,glaa007,glaa008,glaa009,glaa010,glaa011,
                       glaa012,glaa013,glaa014,glaa015,glaa016,glaa017,glaa018,glaa019,glaa020,glaa021,glaa022,glaa023,
                       glaa024,glaa025,glaa026,glaa100,glaa101,glaa102,glaa103,glaa111,glaa112,glaa113,glaa120,glaa121,
                       glaa122,glaa027,glaa130,glaa131,glaa132,glaa133,glaa134,glaa135,glaa136,glaa137,glaa138,glaa139,
                       glaa140,glaa123,glaa124,glaa028 INTO g_glaa.* 
                #161215-00044#1---modify----end-----------------
               FROM glaa_t WHERE glaaent = g_enterprise AND glaald = g_fabg_m.fabgld
               CALL s_aooi200_fin_gen_docno(g_fabg_m.fabgld,'','',g_fabg_m.fabgdocno,g_fabg_m.fabgdocdt,g_prog)
#add by yangxf ---
                  RETURNING l_success,g_fabg_m.fabgdocno
               IF l_success  = 0  THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'apm-00003'
                  LET g_errparam.extend = g_fabg_m.fabgdocno
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  NEXT FIELD fabgdocno
               END IF
               DISPLAY BY NAME g_fabg_m.fabgdocno 
               #end add-point
               
               INSERT INTO fabg_t (fabgent,fabgsite,fabg001,fabgld,fabg002,fabg003,fabg004,fabg005,fabgdocno, 
                   fabgdocdt,fabg010,fabg017,fabg018,fabgstus,fabgownid,fabgowndp,fabgcrtid,fabgcrtdp, 
                   fabgcrtdt,fabgmodid,fabgmoddt,fabgcnfid,fabgcnfdt,fabgpstid,fabgpstdt)
               VALUES (g_enterprise,g_fabg_m.fabgsite,g_fabg_m.fabg001,g_fabg_m.fabgld,g_fabg_m.fabg002, 
                   g_fabg_m.fabg003,g_fabg_m.fabg004,g_fabg_m.fabg005,g_fabg_m.fabgdocno,g_fabg_m.fabgdocdt, 
                   g_fabg_m.fabg010,g_fabg_m.fabg017,g_fabg_m.fabg018,g_fabg_m.fabgstus,g_fabg_m.fabgownid, 
                   g_fabg_m.fabgowndp,g_fabg_m.fabgcrtid,g_fabg_m.fabgcrtdp,g_fabg_m.fabgcrtdt,g_fabg_m.fabgmodid, 
                   g_fabg_m.fabgmoddt,g_fabg_m.fabgcnfid,g_fabg_m.fabgcnfdt,g_fabg_m.fabgpstid,g_fabg_m.fabgpstdt)  
 
               IF SQLCA.SQLCODE THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "g_fabg_m:",SQLERRMESSAGE 
                  LET g_errparam.code = SQLCA.SQLCODE 
                  LET g_errparam.popup = TRUE 
                  CALL s_transaction_end('N','0')
                  CALL cl_err()
                  NEXT FIELD CURRENT
               END IF
               
               #add-point:單頭新增中 name="input.head.m_insert"
               
               #end add-point
               
               
               
               
               #add-point:單頭新增後 name="input.head.a_insert"
               
               #end add-point
               CALL s_transaction_end('Y','0') 
               
               IF l_cmd_t = 'r' AND p_cmd = 'a' THEN
                  CALL afat505_detail_reproduce()
                  #因應特定程式需求, 重新刷新單身資料
                  CALL afat505_b_fill()
                  CALL afat505_b_fill2('0')
               END IF
               
               #add-point:單頭新增後 name="input.head.a_insert2"
               
               #end add-point
               
               LET g_master_insert = TRUE
               
               LET p_cmd = 'u'
            ELSE
               CALL s_transaction_begin()
            
               #add-point:單頭修改前 name="input.head.b_update"
               
               #end add-point
               
               #將遮罩欄位還原
               CALL afat505_fabg_t_mask_restore('restore_mask_o')
               
               UPDATE fabg_t SET (fabgsite,fabg001,fabgld,fabg002,fabg003,fabg004,fabg005,fabgdocno, 
                   fabgdocdt,fabg010,fabg017,fabg018,fabgstus,fabgownid,fabgowndp,fabgcrtid,fabgcrtdp, 
                   fabgcrtdt,fabgmodid,fabgmoddt,fabgcnfid,fabgcnfdt,fabgpstid,fabgpstdt) = (g_fabg_m.fabgsite, 
                   g_fabg_m.fabg001,g_fabg_m.fabgld,g_fabg_m.fabg002,g_fabg_m.fabg003,g_fabg_m.fabg004, 
                   g_fabg_m.fabg005,g_fabg_m.fabgdocno,g_fabg_m.fabgdocdt,g_fabg_m.fabg010,g_fabg_m.fabg017, 
                   g_fabg_m.fabg018,g_fabg_m.fabgstus,g_fabg_m.fabgownid,g_fabg_m.fabgowndp,g_fabg_m.fabgcrtid, 
                   g_fabg_m.fabgcrtdp,g_fabg_m.fabgcrtdt,g_fabg_m.fabgmodid,g_fabg_m.fabgmoddt,g_fabg_m.fabgcnfid, 
                   g_fabg_m.fabgcnfdt,g_fabg_m.fabgpstid,g_fabg_m.fabgpstdt)
                WHERE fabgent = g_enterprise AND fabgld = g_fabgld_t
                  AND fabgdocno = g_fabgdocno_t
 
               IF SQLCA.SQLCODE THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "fabg_t:",SQLERRMESSAGE 
                  LET g_errparam.code = SQLCA.SQLCODE 
                  LET g_errparam.popup = TRUE 
                  CALL s_transaction_end('N','0')
                  CALL cl_err()
                  NEXT FIELD CURRENT
               END IF
               
               #add-point:單頭修改中 name="input.head.m_update"
               
               #end add-point
               
               
               
               
               #將遮罩欄位進行遮蔽
               CALL afat505_fabg_t_mask_restore('restore_mask_n')
               
               #修改歷程記錄(單頭修改)
               LET g_log1 = util.JSON.stringify(g_fabg_m_t)
               LET g_log2 = util.JSON.stringify(g_fabg_m)
               IF NOT cl_log_modified_record(g_log1,g_log2) THEN 
                  CALL s_transaction_end('N','0')
               ELSE
                  CALL s_transaction_end('Y','0')
               END IF
               
               #add-point:單頭修改後 name="input.head.a_update"
               
               #end add-point
            END IF
            
            LET g_master_commit = "Y"
            LET g_fabgld_t = g_fabg_m.fabgld
            LET g_fabgdocno_t = g_fabg_m.fabgdocno
 
            
      END INPUT
   
 
{</section>}
 
{<section id="afat505.input.body" >}
   
      #Page1 預設值產生於此處
      INPUT ARRAY g_fabo_d FROM s_detail1.*
          ATTRIBUTE(COUNT = g_rec_b,WITHOUT DEFAULTS, #MAXCOUNT = g_max_rec,
                  INSERT ROW = l_allow_insert, 
                  DELETE ROW = l_allow_delete,
                  APPEND ROW = l_allow_insert)
 
         #自訂ACTION(detail_input,page_1)
         
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION open_afat505_02
            LET g_action_choice="open_afat505_02"
            IF cl_auth_chk_act("open_afat505_02") THEN
               
               #add-point:ON ACTION open_afat505_02 name="input.detail_input.page1.open_afat505_02"
               #20141118 add--str--
               LET l_n = 0
               SELECT COUNT(1) INTO l_n FROM faai_t 
                WHERE faaient = g_enterprise AND faai001 = g_fabo_d[l_ac].fabo003
                  AND faai002 = g_fabo_d[l_ac].fabo001 AND faai003 = g_fabo_d[l_ac].fabo002
               IF l_n > 0 THEN                 
               #20141118 add--end--                
                  CALL afat440_01(l_cmd,g_fabo_d[l_ac].faboseq,g_fabo_d[l_ac].fabo001,g_fabo_d[l_ac].fabo002,
                               g_fabo_d[l_ac].fabo003,g_fabg_m.fabg005,g_fabg_m.fabgdocno,
                               g_fabo_d[l_ac].fabo007)
               END IF #20141118                
               #END add-point
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION open_afat505_01
            LET g_action_choice="open_afat505_01"
            IF cl_auth_chk_act("open_afat505_01") THEN
               
               #add-point:ON ACTION open_afat505_01 name="input.detail_input.page1.open_afat505_01"
               IF g_fabo_d[l_ac].fabo044 <> g_fabo_d[l_ac].fabo047 THEN
                  CALL afat505_01(g_fabg_m.fabgld,g_fabg_m.fabgdocno,g_fabo_d[g_detail_idx].faboseq,
                                  g_fabo_d[g_detail_idx].fabo001,g_fabo_d[g_detail_idx].fabo002,
                                  g_fabo_d[g_detail_idx].fabo003,
                                  g_fabo_d[g_detail_idx].fabo007,g_fabg_m.fabgdocdt,
                                  g_fabo_d[g_detail_idx].fabo044,g_fabo_d[g_detail_idx].fabo047) #20141113 add by chenying 新增传参调入/出所有组织
               ELSE
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'afa-00179'
                  LET g_errparam.extend = ''
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
                  
                  EXIT DIALOG
               END IF
               #END add-point
            END IF
 
 
 
 
         
         BEFORE INPUT
            #add-point:資料輸入前 name="input.body.before_input2"
            
            #end add-point
            IF g_insert = 'Y' AND NOT cl_null(g_insert) THEN 
              CALL FGL_SET_ARR_CURR(g_fabo_d.getLength()+1) 
              LET g_insert = 'N' 
           END IF 
 
            CALL afat505_b_fill()
            #如果一直都在單身1則控制筆數位置
            IF g_loc = 'm' AND g_rec_b != 0 THEN
               CALL FGL_SET_ARR_CURR(g_idx_group.getValue("'1',"))
            END IF
            LET g_loc = 'm'
            LET g_rec_b = g_fabo_d.getLength()
            #add-point:資料輸入前 name="input.d.before_input"
            
            #end add-point
         
         BEFORE ROW
            #add-point:modify段before row2 name="input.body.before_row2"
            
            #end add-point  
            LET l_insert = FALSE
            LET l_cmd = ''
            LET l_ac_t = l_ac 
            LET l_ac = ARR_CURR()
            LET g_detail_idx = l_ac
            LET g_detail_idx_list[1] = l_ac
            LET g_current_page = 1
            
            LET l_lock_sw = 'N'            #DEFAULT
            LET l_n = ARR_COUNT()
            DISPLAY l_ac TO FORMONLY.idx
         
            CALL s_transaction_begin()
            OPEN afat505_cl USING g_enterprise,g_fabg_m.fabgld,g_fabg_m.fabgdocno
            IF SQLCA.SQLCODE THEN   #(ver:78)
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "OPEN afat505_cl:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE   #(ver:78)
               LET g_errparam.popup = TRUE 
               CLOSE afat505_cl
               CALL s_transaction_end('N','0')
               CALL cl_err()
               RETURN
            END IF
            
            LET g_rec_b = g_fabo_d.getLength()
            
            IF g_rec_b >= l_ac 
               AND g_fabo_d[l_ac].faboseq IS NOT NULL
 
            THEN
               LET l_cmd='u'
               LET g_fabo_d_t.* = g_fabo_d[l_ac].*  #BACKUP
               LET g_fabo_d_o.* = g_fabo_d[l_ac].*  #BACKUP
               CALL afat505_set_entry_b(l_cmd)
               #add-point:modify段after_set_entry_b name="input.body.after_set_entry_b"
               
               #end add-point  
               CALL afat505_set_no_entry_b(l_cmd)
               IF NOT afat505_lock_b("fabo_t","'1'") THEN
                  LET l_lock_sw='Y'
               ELSE
                  FETCH afat505_bcl INTO g_fabo_d[l_ac].faboseq,g_fabo_d[l_ac].fabo001,g_fabo_d[l_ac].fabo002, 
                      g_fabo_d[l_ac].fabo003,g_fabo_d[l_ac].fabo005,g_fabo_d[l_ac].fabo007,g_fabo_d[l_ac].fabo043, 
                      g_fabo_d[l_ac].fabo044,g_fabo_d[l_ac].fabo045,g_fabo_d[l_ac].fabo046,g_fabo_d[l_ac].fabo047, 
                      g_fabo_d[l_ac].fabo048,g_fabo_d[l_ac].fabo023,g_fabo_d[l_ac].fabo000
                  IF SQLCA.SQLCODE THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = g_fabo_d_t.faboseq,":",SQLERRMESSAGE 
                     LET g_errparam.code = SQLCA.SQLCODE 
                     LET g_errparam.popup = TRUE 
                     CALL cl_err()
                     LET l_lock_sw = "Y"
                  END IF
                  
                  #遮罩相關處理
                  LET g_fabo_d_mask_o[l_ac].* =  g_fabo_d[l_ac].*
                  CALL afat505_fabo_t_mask()
                  LET g_fabo_d_mask_n[l_ac].* =  g_fabo_d[l_ac].*
                  
                  LET g_bfill = "N"
                  CALL afat505_show()
                  LET g_bfill = "Y"
                  
                  CALL cl_show_fld_cont()
               END IF
            ELSE
               LET l_cmd='a'
            END IF
            #add-point:modify段before row name="input.body.before_row"
            
            #end add-point  
            #其他table資料備份(確定是否更改用)
            
 
            #其他table進行lock
            
 
        
         BEFORE INSERT  
            
            IF s_transaction_chk("N",0) THEN
               CALL s_transaction_begin()
            END IF
            LET l_insert = TRUE
            LET l_n = ARR_COUNT()
            LET l_cmd = 'a'
            INITIALIZE g_fabo_d[l_ac].* TO NULL 
            INITIALIZE g_fabo_d_t.* TO NULL 
            INITIALIZE g_fabo_d_o.* TO NULL 
            #公用欄位給值(單身)
            
            #自定義預設值
                  LET g_fabo_d[l_ac].fabo000 = "17"
 
            #add-point:modify段before備份 name="input.body.insert.before_bak"
            
            #end add-point
            LET g_fabo_d_t.* = g_fabo_d[l_ac].*     #新輸入資料
            LET g_fabo_d_o.* = g_fabo_d[l_ac].*     #新輸入資料
            CALL cl_show_fld_cont()
            CALL afat505_set_entry_b(l_cmd)
            #add-point:modify段after_set_entry_b name="input.body.insert.after_set_entry_b"
            
            #end add-point
            CALL afat505_set_no_entry_b(l_cmd)
            IF lb_reproduce THEN
               LET lb_reproduce = FALSE
               LET g_fabo_d[li_reproduce_target].* = g_fabo_d[li_reproduce].*
 
               LET g_fabo_d[li_reproduce_target].faboseq = NULL
 
            END IF
            
 
            #add-point:modify段before insert name="input.body.before_insert"
            SELECT MAX(faboseq)+1 INTO g_fabo_d[l_ac].faboseq 
              FROM fabo_t 
             WHERE fabodocno = g_fabg_m.fabgdocno  
               AND fabold = g_fabg_m.fabgld
               AND faboent = g_enterprise
            IF cl_null(g_fabo_d[l_ac].faboseq) THEN 
               LET g_fabo_d[l_ac].faboseq = 1 
            END IF 
            
            #20150513--add--str--lujh
            IF cl_null(g_fabo_d[l_ac].fabo002) THEN 
               LET g_fabo_d[l_ac].fabo002=' ' 
            END IF
            #20150513--add--end--lujh
            #end add-point  
  
         AFTER INSERT
            LET l_insert = FALSE
            IF INT_FLAG THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code = 9001 
               LET g_errparam.popup = FALSE 
               CALL cl_err()
               LET INT_FLAG = 0
               CANCEL INSERT
            END IF
               
            #add-point:單身新增 name="input.body.b_a_insert"
            
            #end add-point
               
            LET l_count = 1  
            SELECT COUNT(1) INTO l_count FROM fabo_t 
             WHERE faboent = g_enterprise AND fabold = g_fabg_m.fabgld
               AND fabodocno = g_fabg_m.fabgdocno
 
               AND faboseq = g_fabo_d[l_ac].faboseq
 
                
            #資料未重複, 插入新增資料
            IF l_count = 0 THEN 
               #add-point:單身新增前 name="input.body.b_insert"
               
               #end add-point
            
               #同步新增到同層的table
                              INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_fabg_m.fabgld
               LET gs_keys[2] = g_fabg_m.fabgdocno
               LET gs_keys[3] = g_fabo_d[g_detail_idx].faboseq
               CALL afat505_insert_b('fabo_t',gs_keys,"'1'")
                           
               #add-point:單身新增後 name="input.body.a_insert"
               #20141118 add--str--
               LET l_n = 0
               SELECT COUNT(1) INTO l_n FROM faai_t 
                WHERE faaient = g_enterprise AND faai001 = g_fabo_d[l_ac].fabo003
                  AND faai002 = g_fabo_d[l_ac].fabo001 AND faai003 = g_fabo_d[l_ac].fabo002
               IF l_n > 0 THEN                 
               #20141118 add--end--                 
                  CALL afat440_01(l_cmd,g_fabo_d[l_ac].faboseq,g_fabo_d[l_ac].fabo001,g_fabo_d[l_ac].fabo002,
                                  g_fabo_d[l_ac].fabo003,g_fabg_m.fabg005,g_fabg_m.fabgdocno,
                                  g_fabo_d[l_ac].fabo007)
               END IF #20141118                   
               
               #當只是管理組織與核算組織不同時，產生資產變更檔(afat420)
               IF (g_fabo_d[l_ac].fabo043 <> g_fabo_d[l_ac].fabo046 OR
                   g_fabo_d[l_ac].fabo045 <> g_fabo_d[l_ac].fabo048) THEN 
                  
                  CALL afat505_fabe_ins()                  
               END IF
               
               IF g_fabo_d[l_ac].fabo044 <> g_fabo_d[l_ac].fabo047 THEN
                  CALL afat505_01(g_fabg_m.fabgld,g_fabg_m.fabgdocno,g_fabo_d[l_ac].faboseq,
                               g_fabo_d[l_ac].fabo001,g_fabo_d[l_ac].fabo002,
                               g_fabo_d[l_ac].fabo003,g_fabo_d[l_ac].fabo007,
                               g_fabg_m.fabgdocdt,
                               g_fabo_d[l_ac].fabo044,g_fabo_d[l_ac].fabo047) #20141113 add by chenying 新增传参调入/出所有组织
               END IF
               #end add-point
            ELSE    
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = 'INSERT' 
               LET g_errparam.code = "std-00006" 
               LET g_errparam.popup = TRUE 
               INITIALIZE g_fabo_d[l_ac].* TO NULL
               CALL s_transaction_end('N','0')
               CALL cl_err()
               CANCEL INSERT
            END IF
 
            IF SQLCA.SQLCODE THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "fabo_t:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE 
               LET g_errparam.popup = TRUE 
               CALL s_transaction_end('N','0')                    
               CALL cl_err()
               CANCEL INSERT
            ELSE
               #先刷新資料
               #CALL afat505_b_fill()
               #資料多語言用-增/改
               
               #add-point:input段-after_insert name="input.body.a_insert2"
#               CALL afat440_01(l_cmd,g_fabo_d[l_ac].faboseq,g_fabo_d[l_ac].fabo001,g_fabo_d[l_ac].fabo002,
#                                  g_fabo_d[l_ac].fabo003,g_fabg_m.fabg005,g_fabg_m.fabgdocno,
#                                  g_fabo_d[l_ac].fabo007)
               #end add-point
               CALL s_transaction_end('Y','0')
               #ERROR 'INSERT O.K'
               LET g_rec_b = g_rec_b + 1
            END IF
              
         BEFORE DELETE                            #是否取消單身
            IF l_cmd = 'a' THEN
               LET l_cmd='d'
               #add-point:單身刪除後(=d) name="input.body.after_delete_d"
               
               #end add-point
            ELSE
               #add-point:單身刪除前 name="input.body.b_delete_ask"
               
               #end add-point 
               IF NOT cl_ask_del_detail() THEN
                  CANCEL DELETE
               END IF
               IF l_lock_sw = "Y" THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "" 
                  LET g_errparam.code = -263 
                  LET g_errparam.popup = TRUE 
                  CALL cl_err()
                  CANCEL DELETE
               END IF
               
               #add-point:單身刪除前 name="input.body.b_delete"
               
               #end add-point 
               
               #取得該筆資料key值
               INITIALIZE gs_keys TO NULL
               LET gs_keys[01] = g_fabg_m.fabgld
               LET gs_keys[gs_keys.getLength()+1] = g_fabg_m.fabgdocno
 
               LET gs_keys[gs_keys.getLength()+1] = g_fabo_d_t.faboseq
 
            
               #刪除同層單身
               IF NOT afat505_delete_b('fabo_t',gs_keys,"'1'") THEN
                  CALL s_transaction_end('N','0')
                  CLOSE afat505_bcl
                  CANCEL DELETE
               END IF
    
               #刪除下層單身
               IF NOT afat505_key_delete_b(gs_keys,'fabo_t') THEN
                  CALL s_transaction_end('N','0')
                  CLOSE afat505_bcl
                  CANCEL DELETE
               END IF
               
               #刪除多語言
               
 
               
               #add-point:單身刪除中 name="input.body.m_delete"
               
               #end add-point 
               
               CALL s_transaction_end('Y','0')
               CLOSE afat505_bcl
            
               LET g_rec_b = g_rec_b-1
               #add-point:單身刪除後 name="input.body.a_delete"
                  IF (g_fabo_d[l_ac].fabo043 <> g_fabo_d[l_ac].fabo046 OR
                     g_fabo_d[l_ac].fabo045 <> g_fabo_d[l_ac].fabo048) THEN 
                     #刪除资产變更歷程檔
                     DELETE FROM fabf_t
                      WHERE fabfent = g_enterprise
                        AND fabf001 = g_fabo_d[l_ac].fabo003
                        AND fabf002 = g_fabo_d[l_ac].fabo001
                        AND fabf003 = g_fabo_d[l_ac].fabo002
                     IF SQLCA.sqlcode THEN
                        INITIALIZE g_errparam TO NULL
                        LET g_errparam.code = SQLCA.sqlcode
                        LET g_errparam.extend = "fabf_t"
                        LET g_errparam.popup = FALSE
                        CALL cl_err()
                     
                        CALL s_transaction_end('N','0')
                        RETURN
                     END IF 
                     #刪除資產變更檔
                     DELETE FROM fabe_t
                      WHERE fabeent = g_enterprise
                        AND fabe001 = g_fabo_d[l_ac].fabo003
                        AND fabe003 = g_fabo_d[l_ac].fabo001
                        AND fabe004 = g_fabo_d[l_ac].fabo002
                     IF SQLCA.sqlcode THEN
                        INITIALIZE g_errparam TO NULL
                        LET g_errparam.code = SQLCA.sqlcode
                        LET g_errparam.extend = "fabf_t"
                        LET g_errparam.popup = FALSE
                        CALL cl_err()
                     
                        CALL s_transaction_end('N','0')
                        RETURN
                     END IF 
                  END IF
                  
                  IF g_fabo_d[l_ac].fabo044 <> g_fabo_d[l_ac].fabo047 THEN
                     #刪除資產調撥單身檔
                     DELETE FROM fabu_t
                      WHERE fabuent   = g_enterprise
                        AND fabuld    = g_fabg_m.fabgld
                        AND fabudocno = g_fabg_m.fabgdocno
                        AND fabuseq   = g_fabo_d[l_ac].faboseq
                     IF SQLCA.sqlcode THEN
                        INITIALIZE g_errparam TO NULL
                        LET g_errparam.code = SQLCA.sqlcode
                        LET g_errparam.extend = "fabu_t"
                        LET g_errparam.popup = FALSE
                        CALL cl_err()
                     
                        CALL s_transaction_end('N','0')
                        RETURN
                     END IF 
                     
                     #刪除交易稅明細檔
                     DELETE FROM xrcd_t
                      WHERE xrcdent   = g_enterprise
                        AND xrcdld    = g_fabg_m.fabgld
                        AND xrcddocno = g_fabg_m.fabgdocno
                        AND xrcdseq   = g_fabo_d[l_ac].faboseq
                     
                     IF SQLCA.sqlcode THEN
                        INITIALIZE g_errparam TO NULL
                        LET g_errparam.code = SQLCA.sqlcode
                        LET g_errparam.extend = "xrcd_t"
                        LET g_errparam.popup = FALSE
                        CALL cl_err()
                     
                        CALL s_transaction_end('N','0')
                        RETURN
                     END IF 
                     
                     #刪除資產出售檔
                     SELECT fabgdocno INTO l_fabgdocno
                       FROM fabg_t
                      WHERE fabgent = g_enterprise
                        AND fabgld  = g_fabg_m.fabgld
                        AND fabg019 = g_fabg_m.fabgdocno
                        
                     #刪除資產出售單身
                     DELETE FROM fabo_t 
                      WHERE faboent   = g_enterprise
                        AND fabold    = g_fabg_m.fabgld
                        AND fabodocno = l_fabgdocno 
                        AND faboseq   = g_fabo_d[l_ac].faboseq
                        
                     IF SQLCA.sqlcode THEN
                        INITIALIZE g_errparam TO NULL
                        LET g_errparam.code = SQLCA.sqlcode
                        LET g_errparam.extend = "del fabo_t"
                        LET g_errparam.popup = TRUE
                        CALL cl_err()
                     
                        CALL s_transaction_end('N','0')
                        RETURN
                     END IF
                     
                     #刪除交易稅明細檔
                     DELETE FROM xrcd_t
                      WHERE xrcdent   = g_enterprise
                        AND xrcdld    = g_fabg_m.fabgld
                        AND xrcddocno = l_fabgdocno
                        AND xrcdseq   = g_fabo_d[l_ac].faboseq
                        
                     IF SQLCA.sqlcode THEN
                        INITIALIZE g_errparam TO NULL
                        LET g_errparam.code = SQLCA.sqlcode
                        LET g_errparam.extend = "del xrcd_t"
                        LET g_errparam.popup = TRUE
                        CALL cl_err()
                     
                        CALL s_transaction_end('N','0')
                        RETURN
                     END IF
                     
                     LET l_n = 0
                     SELECT COUNT(1) INTO l_n
                       FROM fabo_t
                      WHERE faboent   = g_enterprise
                        AND fabold    = g_fabg_m.fabgld
                        AND fabodocno = l_fabgdocno 
                        
                     IF l_n = 0 THEN 
                        #刪除資產出售單頭
                        DELETE FROM fabg_t 
                         WHERE fabgent   = g_enterprise
                           AND fabgld    = g_fabg_m.fabgld
                           AND fabgdocno = l_fabgdocno 
                           
                        IF SQLCA.sqlcode THEN
                           INITIALIZE g_errparam TO NULL
                           LET g_errparam.code = SQLCA.sqlcode
                           LET g_errparam.extend = "del fabg_t"
                           LET g_errparam.popup = TRUE
                           CALL cl_err()
                        
                           CALL s_transaction_end('N','0')
                           RETURN
                        END IF
                     END IF
                     
                     #刪除產生的新的卡片檔
                     
                     #刪除單頭
                     DELETE FROM faah_t 
                      WHERE faahent = g_enterprise 
                        AND faah003 = g_fabo_d[l_ac].fabo001 
                        AND faah004 = g_fabo_d[l_ac].fabo002
                        AND faah001 <> g_fabo_d[l_ac].fabo003
                     IF SQLCA.sqlcode THEN
                        INITIALIZE g_errparam TO NULL
                        LET g_errparam.code = SQLCA.sqlcode
                        LET g_errparam.extend = "del faah_t"
                        LET g_errparam.popup = TRUE
                        CALL cl_err()
                     
                        CALL s_transaction_end('N','0')
                        RETURN
                     END IF   
                     
                     #刪除單身                     
                     DELETE FROM faai_t 
                      WHERE faaient = g_enterprise 
                        AND faai002 = g_fabo_d[l_ac].fabo001
                        AND faai003 = g_fabo_d[l_ac].fabo002 
                        AND faai001 <> g_fabo_d[l_ac].fabo003
                     
                     IF SQLCA.sqlcode THEN
                        INITIALIZE g_errparam TO NULL
                        LET g_errparam.code = SQLCA.sqlcode
                        LET g_errparam.extend = "del faai_t"
                        LET g_errparam.popup = TRUE
                        CALL cl_err()
                     
                        CALL s_transaction_end('N','0')
                        RETURN
                     END IF                      
                        
                     DELETE FROM faaj_t 
                      WHERE faajent = g_enterprise 
                        AND faaj001 = g_fabo_d[l_ac].fabo001 
                        AND faaj002 = g_fabo_d[l_ac].fabo002 
                        AND faaj037 <> g_fabo_d[l_ac].fabo003
                        
                     IF SQLCA.sqlcode THEN
                        INITIALIZE g_errparam TO NULL
                        LET g_errparam.code = SQLCA.sqlcode
                        LET g_errparam.extend = "del faaj_t"
                        LET g_errparam.popup = TRUE
                        CALL cl_err()
                     
                        CALL s_transaction_end('N','0')
                        RETURN
                     END IF
                     
                  END IF
               #end add-point
               LET l_count = g_fabo_d.getLength()
               
               #add-point:單身刪除後(<>d) name="input.body.after_delete"
               
               #end add-point
            END IF
 
         AFTER DELETE
            #如果是最後一筆
            IF l_ac = (g_fabo_d.getLength() + 1) THEN
               CALL FGL_SET_ARR_CURR(l_ac-1)
            END IF
 
                  #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD faboseq
            #add-point:BEFORE FIELD faboseq name="input.b.page1.faboseq"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD faboseq
            
            #add-point:AFTER FIELD faboseq name="input.a.page1.faboseq"
            #此段落由子樣板a05產生
            #確認資料無重複
            IF  g_fabg_m.fabgld IS NOT NULL AND g_fabg_m.fabgdocno IS NOT NULL AND g_fabo_d[g_detail_idx].faboseq IS NOT NULL THEN 
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_fabg_m.fabgld != g_fabgld_t OR g_fabg_m.fabgdocno != g_fabgdocno_t OR g_fabo_d[g_detail_idx].faboseq != g_fabo_d_t.faboseq)) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(1) FROM fabo_t WHERE "||"faboent = '" ||g_enterprise|| "' AND "||"fabold = '"||g_fabg_m.fabgld ||"' AND "|| "fabodocno = '"||g_fabg_m.fabgdocno ||"' AND "|| "faboseq = '"||g_fabo_d[g_detail_idx].faboseq ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF


            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE faboseq
            #add-point:ON CHANGE faboseq name="input.g.page1.faboseq"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fabo001
            
            #add-point:AFTER FIELD fabo001 name="input.a.page1.fabo001"
            IF NOT cl_null(g_fabo_d[l_ac].fabo001) THEN 
               IF g_fabo_d[l_ac].fabo001 != g_fabo_d_o.fabo001 OR cl_null(g_fabo_d_o.fabo001) THEN #160829-00042#1             
                  #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
                  INITIALIZE g_chkparam.* TO NULL
                  #設定g_chkparam.*的參數
                  LET g_chkparam.arg1 = g_fabo_d[l_ac].fabo001
                  #呼叫檢查存在並帶值的library
                  IF NOT cl_chk_exist("v_faah003") THEN
                     #檢查失敗時後續處理
                     #LET g_fabo_d[l_ac].fabo001 = g_fabo_d_t.fabo001  #160829-00042#1
                     LET g_fabo_d[l_ac].fabo001 = g_fabo_d_o.fabo001   #160829-00042#1
                     NEXT FIELD CURRENT
                  END IF
                  #IF l_cmd = 'a' OR (l_cmd = 'u' AND (g_fabo_d[l_ac].fabo001 != g_fabo_d_t.fabo001)) THEN
                  IF g_fabo_d[l_ac].fabo001 != g_fabo_d_o.fabo001 OR cl_null(g_fabo_d_o.fabo001) THEN #160829-00042#1 
                     LET g_fabo_d[l_ac].fabo003 = ''
                     LET g_fabo_d_o.fabo003 = g_fabo_d[l_ac].fabo003 #160829-00042#1 
                     CALL afat505_faid_def()
                     DISPLAY g_fabo_d[l_ac].fabo003 TO s_detail1[l_ac].fabo003
                  END IF
                  IF g_fabo_d[l_ac].fabo002 IS NOT NULL AND NOT cl_null(g_fabo_d[l_ac].fabo003) THEN
                     IF g_fabo_d[l_ac].fabo001 != g_fabo_d_o.fabo001 OR cl_null(g_fabo_d_o.fabo001) THEN #160829-00042#1 
                        INITIALIZE g_chkparam.* TO NULL
                        #設定g_chkparam.*的參數
                        LET g_chkparam.arg1 = g_fabo_d[l_ac].fabo001
                        LET g_chkparam.arg2 = g_fabo_d[l_ac].fabo002
                        LET g_chkparam.arg3 = g_fabo_d[l_ac].fabo003
                        #160318-00025#5--add--str
                        LET g_errshow = TRUE 
                        LET g_chkparam.err_str[1] = "afa-00264:sub-01313|afai100|",cl_get_progname("afai100",g_lang,"2"),"|:EXEPROGafai100"
                        #160318-00025#5--add--end
                        #呼叫檢查存在並帶值的library
                        IF NOT cl_chk_exist("v_faah003_3") THEN
                           #檢查失敗時後續處理
                           #160829-00042#1---s---
                           #LET g_fabo_d[l_ac].fabo001 = g_fabo_d_t.fabo001
                           #LET g_fabo_d[l_ac].fabo002 = g_fabo_d_t.fabo002
                           #LET g_fabo_d[l_ac].fabo003 = g_fabo_d_t.fabo003
                           LET g_fabo_d[l_ac].fabo001 = g_fabo_d_o.fabo001
                           LET g_fabo_d[l_ac].fabo002 = g_fabo_d_o.fabo002
                           LET g_fabo_d[l_ac].fabo003 = g_fabo_d_o.fabo003
                           #160829-00042#1---e--- 
                           NEXT FIELD CURRENT
                        ELSE
                           #20150608--add--str--lujh
                           IF NOT cl_null(g_fabo_d[l_ac].fabo001) AND g_fabo_d[l_ac].fabo002 IS NOT NULL AND NOT cl_null(g_fabo_d[l_ac].fabo003) THEN 
                              CALL s_afa_faan_chk(g_fabg_m.fabgdocdt,g_fabo_d[l_ac].fabo003,g_fabo_d[l_ac].fabo001,g_fabo_d[l_ac].fabo002,g_fabg_m.fabgld) 
                              RETURNING l_success
                              
                              IF l_success = FALSE THEN 
                                 INITIALIZE g_errparam TO NULL 
                                 LET g_errparam.extend = ''
                                 LET g_errparam.code   = 'afa-01026'
                                 LET g_errparam.popup  = TRUE 
                                 CALL cl_err() 
                                 #LET g_fabo_d[l_ac].fabo001 = g_fabo_d_t.fabo001 #160829-00042#1
                                 LET g_fabo_d[l_ac].fabo001 = g_fabo_d_o.fabo001  #160829-00042#1
                                 LET g_fabo_d[l_ac].fabo002 = g_fabo_d_o.fabo002  #160829-00042#1
                                 LET g_fabo_d[l_ac].fabo003 = g_fabo_d_o.fabo003  #160829-00042#1
                                 NEXT FIELD CURRENT
                              END IF
                           END IF
                           #20150608--add--end--lujh
                        END IF
                        #160829-00042#1 ---s---
                        CALL afat505_faid_chk() RETURNING l_success
                        IF NOT l_success THEN
                           LET g_fabo_d[l_ac].fabo001 = g_fabo_d_o.fabo001 
                           LET g_fabo_d[l_ac].fabo002 = g_fabo_d_o.fabo002 
                           LET g_fabo_d[l_ac].fabo003 = g_fabo_d_o.fabo003 
                           NEXT FIELD CURRENT
                        END IF
                        #160829-00042#1 ---e---
                     END IF
                  END IF
                  #160829-00042#1 ---s---
                  #CALL afat505_faid_chk() RETURNING l_success
                  #IF NOT l_success THEN
                  #   NEXT FIELD CURRENT
                  #END IF
                  #160829-00042#1 ---e---
               END IF
            END IF
            #IF l_cmd = 'a' OR (l_cmd = 'u' AND (g_fabo_d[l_ac].fabo001 != g_fabo_d_t.fabo001 OR g_fabo_d[l_ac].fabo002 != g_fabo_d_t.fabo002 OR g_fabo_d[l_ac].fabo003 != g_fabo_d_t.fabo003 )) THEN  #160829-00042#1  
            IF g_fabo_d[l_ac].fabo001 != g_fabo_d_o.fabo001 OR cl_null(g_fabo_d_o.fabo001) THEN #160829-00042#1 
               CALL afat505_get_faah()
            END IF
            LET g_fabo_d_o.* = g_fabo_d[l_ac].* #160829-00042#1
#           IF NOT cl_null(g_fabo_d[l_ac].fabo001) THEN 
#              #此段落由子樣板a19產生
#              #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
#              INITIALIZE g_chkparam.* TO NULL
#              
#              #設定g_chkparam.*的參數
#              LET g_chkparam.arg1 = g_fabo_d[l_ac].fabo001
#
#                 
#              #呼叫檢查存在並帶值的library
#              IF cl_chk_exist("v_faah003") THEN
#                 #檢查成功時後續處理
#                 #LET  = g_chkparam.return1
#                 #DISPLAY BY NAME 
#                 LET l_n = 0 
#                 SELECT COUNT(1) INTO l_n
#                   FROM faaj_t
#                  WHERE faajent = g_enterprise
#                    AND faaj037 = g_fabo_d[l_ac].fabo003
#                    AND faaj001 = g_fabo_d[l_ac].fabo001
#                    AND faaj002 = g_fabo_d[l_ac].fabo002
#                    
#                 IF l_n = 0 THEN 
#                    INITIALIZE g_errparam TO NULL
#                    LET g_errparam.code = 'afa-00178'
#                    LET g_errparam.extend = ''
#                    LET g_errparam.popup = TRUE
#                    CALL cl_err()
#                    
#                    LET g_fabo_d[l_ac].fabo001 = g_fabo_d_t.fabo001
#                    LET g_fabo_d[l_ac].fabo002 = g_fabo_d_t.fabo002
#                    LET g_fabo_d[l_ac].fabo003 = g_fabo_d_t.fabo003
#                    NEXT FIELD CURRENT
#                 END IF
#              ELSE
#                 #檢查失敗時後續處理
#                 LET g_fabo_d[l_ac].fabo001 = g_fabo_d_t.fabo001
#                 LET g_fabo_d[l_ac].fabo002 = g_fabo_d_t.fabo002
#                 LET g_fabo_d[l_ac].fabo003 = g_fabo_d_t.fabo003
#                 NEXT FIELD CURRENT
#              END IF
#           END IF 
#           
#           IF NOT cl_null(g_fabo_d[l_ac].fabo003) AND NOT cl_null(g_fabo_d[l_ac].fabo002) AND NOT cl_null(g_fabo_d[l_ac].fabo001) THEN 
#           #卡片+财编+附號不為空時，需檢查卡片+财编+附號資料是否相符   
#              #LET l_n2 = 0 
#              #SELECT COUNT(1) INTO l_n2 FROM faah_t
#              # WHERE faah003 = g_fabo_d[l_ac].fabo001
#              #   AND faah004 = g_fabo_d[l_ac].fabo002 
#              #   AND faah001 = g_fabo_d[l_ac].fabo003
#              #IF l_n2 = 0 THEN    
#              #   INITIALIZE g_errparam TO NULL
#              #   LET g_errparam.code = 'afa-00068'
#              #   LET g_errparam.extend = ''
#              #   LET g_errparam.popup = TRUE
#              #   CALL cl_err()
#              #
#              #   LET g_fabo_d[l_ac].fabo001 = g_fabo_d_t.fabo001
#              #   LET g_fabo_d[l_ac].fabo002 = g_fabo_d_t.fabo002
#              #   LET g_fabo_d[l_ac].fabo003 = g_fabo_d_t.fabo003
#              #   NEXT FIELD fabo001
#              #END IF 
#              
#             #0919
#             SELECT faah015 INTO l_faah015 FROM faah_t
#              WHERE faahent = g_enterprise
#                AND faah003 = g_fabo_d[l_ac].fabo001
#                AND faah004 = g_fabo_d[l_ac].fabo002 
#                AND faah001 = g_fabo_d[l_ac].fabo003
#             #財產狀態不可為0：取得、5：出售、6：銷賬、10：被資本化
#             IF l_faah015='0' OR l_faah015='5' OR l_faah015='6' OR l_faah015='10' THEN
#                INITIALIZE g_errparam TO NULL
#                LET g_errparam.code = 'afa-00135'
#                LET g_errparam.extend = ''
#                LET g_errparam.popup = TRUE
#                CALL cl_err()
#                
#                LET g_fabo_d[l_ac].fabo001 = g_fabo_d_t.fabo001
#                LET g_fabo_d[l_ac].fabo002 = g_fabo_d_t.fabo002
#                LET g_fabo_d[l_ac].fabo003 = g_fabo_d_t.fabo003
#                NEXT FIELD fabo001      
#             END IF 
#             #0919              
#
#             #當前折畢再單，卡片+財產編號+附號不可重複
#             LET l_n1 = 0
#             SELECT COUNT(1) INTO l_n1 FROM fabo_t
#              WHERE faboent = g_enterprise
#                AND fabodocno = g_fabg_m.fabgdocno
#                AND fabo001 = g_fabo_d[l_ac].fabo001 
#                AND fabo002 = g_fabo_d[l_ac].fabo002
#                AND fabo003 = g_fabo_d[l_ac].fabo003
#             IF l_n1 >= 1 AND (l_cmd = 'a' OR (l_cmd = 'u' AND (g_fabo_d[l_ac].fabo001 != g_fabo_d_t.fabo001 OR g_fabo_d[l_ac].fabo002 != g_fabo_d_t.fabo002 OR g_fabo_d[l_ac].fabo003 != g_fabo_d_t.fabo003 ))) THEN
#                INITIALIZE g_errparam TO NULL
#                LET g_errparam.code = 'afa-00142'
#                LET g_errparam.extend = ''
#                LET g_errparam.popup = TRUE
#                CALL cl_err()
#
#                LET g_fabo_d[l_ac].fabo001 = g_fabo_d_t.fabo001
#                LET g_fabo_d[l_ac].fabo002 = g_fabo_d_t.fabo002
#                LET g_fabo_d[l_ac].fabo003 = g_fabo_d_t.fabo003
#                NEXT FIELD fabo001               
#             END IF   
#             CALL afat505_get_faah()            
#           END IF   
#           
#           #若不是開窗，直接輸入欄位時，需默認帶出相應的卡片+附號
#           #當前折畢再提單中未使用的資料
#           LET l_n6 = 1
#           LET l_n5 = 0
#           
#           SELECT COUNT(1) INTO l_n5 FROM faah_t    #符合條件的筆數
#            WHERE faahent = g_enterprise
#              AND faah003 = g_fabo_d[l_ac].fabo001
#              AND faahstus = 'Y'
#                 
#           IF cl_null(g_fabo_d[l_ac].fabo003) AND cl_null(g_fabo_d[l_ac].fabo002) AND NOT cl_null(g_fabo_d[l_ac].fabo001) THEN 
#              LET l_sql = " SELECT faah001,faah003,faah004 FROM faah_t ",
#                          "  WHERE faahent = '",g_enterprise,"'",
#                          "    AND faah003 = '",g_fabo_d[l_ac].fabo001,"'", 
#                          "    AND faahstus = 'Y' ",
#                          "  ORDER BY faah001,faah003,faah004 "
#              PREPARE afat505_pb4 FROM l_sql
#              DECLARE afat505_cs4 CURSOR FOR afat505_pb4     
#              FOREACH afat505_cs4 INTO l_fabo003,l_fabo001,l_fabo002 
#              
#              IF SQLCA.sqlcode THEN
#                 INITIALIZE g_errparam TO NULL
#                 LET g_errparam.code = SQLCA.sqlcode
#                 LET g_errparam.extend = "afat505_cs4"
#                 LET g_errparam.popup = TRUE
#                 CALL cl_err()
#
#                 EXIT FOREACH
#              END IF             
#              
#              LET l_n4 = 0
#              SELECT COUNT(1) INTO l_n4 FROM fabo_t 
#               WHERE faboent = g_enterprise
#                 AND fabodocno = g_fabg_m.fabgdocno
#                 AND fabo001 = l_fabo001 
#                 AND fabo002 = l_fabo002
#                 AND fabo003 = l_fabo003  
#              IF l_n4 >=1 THEN 
#                 LET l_n6 = l_n6 + 1  #存在重複資料時，繼續下一筆
#                 CONTINUE FOREACH
#              ELSE 
#                 LET g_fabo_d[l_ac].fabo003 = l_fabo003
#                 LET g_fabo_d[l_ac].fabo001 = l_fabo001
#                 LET g_fabo_d[l_ac].fabo002 = l_fabo002
#                 EXIT FOREACH
#              END IF 
#            END FOREACH  
#            IF l_n5 < l_n6 AND l_n5 != 0 THEN  #排除輸入的不符合條件的資料
#               INITIALIZE g_errparam TO NULL
#               LET g_errparam.code = 'afa-00143'
#               LET g_errparam.extend = ''
#               LET g_errparam.popup = TRUE
#               CALL cl_err()
#
#               LET g_fabo_d[l_ac].fabo001 = g_fabo_d_t.fabo001
#               NEXT FIELD fabo001
#            END IF    
#            CALL afat505_get_faah()           
#          END IF  

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fabo001
            #add-point:BEFORE FIELD fabo001 name="input.b.page1.fabo001"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fabo001
            #add-point:ON CHANGE fabo001 name="input.g.page1.fabo001"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fabo002
            
            #add-point:AFTER FIELD fabo002 name="input.a.page1.fabo002"
            IF cl_null(g_fabo_d[l_ac].fabo002) THEN
               LET g_fabo_d[l_ac].fabo002 = ' ' 
               LET g_fabo_d_o.fabo002 = g_fabo_d[l_ac].fabo002 #160829-00042#1
            END IF
            #IF l_cmd = 'a' OR (l_cmd = 'u' AND (g_fabo_d[l_ac].fabo002 != g_fabo_d_t.fabo002)) THEN #160829-00042#1
            IF g_fabo_d[l_ac].fabo002 != g_fabo_d_o.fabo002 OR g_fabo_d_o.fabo002 IS NULL THEN #160829-00042#1
               LET g_fabo_d[l_ac].fabo003 = ''
               CALL afat505_faid_def()
               LET g_fabo_d_o.fabo003 = g_fabo_d[l_ac].fabo003             #160829-00042#1
               DISPLAY g_fabo_d[l_ac].fabo003 TO s_detail1[l_ac].fabo003
            END IF
            IF g_fabo_d[l_ac].fabo002 IS NOT NULL AND NOT cl_null(g_fabo_d[l_ac].fabo003) AND NOT cl_null(g_fabo_d[l_ac].fabo001) THEN
               IF g_fabo_d[l_ac].fabo002 != g_fabo_d_o.fabo002 OR g_fabo_d_o.fabo002 IS NULL THEN #160829-00042#1
                  INITIALIZE g_chkparam.* TO NULL
                  #設定g_chkparam.*的參數
                  LET g_chkparam.arg1 = g_fabo_d[l_ac].fabo001
                  LET g_chkparam.arg2 = g_fabo_d[l_ac].fabo002
                  LET g_chkparam.arg3 = g_fabo_d[l_ac].fabo003
                  #160318-00025#5--add--str
                  LET g_errshow = TRUE 
                  LET g_chkparam.err_str[1] = "afa-00264:sub-01313|afai100|",cl_get_progname("afai100",g_lang,"2"),"|:EXEPROGafai100"
                  #160318-00025#5--add--end
                  #呼叫檢查存在並帶值的library
                  IF NOT cl_chk_exist("v_faah003_3") THEN
                     #檢查失敗時後續處理
                     #LET g_fabo_d[l_ac].fabo002 = g_fabo_d_t.fabo002 #160829-00042#1
                     LET g_fabo_d[l_ac].fabo001 = g_fabo_d_o.fabo001 #160829-00042#1
                     LET g_fabo_d[l_ac].fabo002 = g_fabo_d_o.fabo002 #160829-00042#1
                     LET g_fabo_d[l_ac].fabo003 = g_fabo_d_o.fabo003 #160829-00042#1
                     NEXT FIELD CURRENT
                  ELSE
                     #20150608--add--str--lujh
                     IF NOT cl_null(g_fabo_d[l_ac].fabo001) AND g_fabo_d[l_ac].fabo002 IS NOT NULL AND NOT cl_null(g_fabo_d[l_ac].fabo003) THEN 
                        CALL s_afa_faan_chk(g_fabg_m.fabgdocdt,g_fabo_d[l_ac].fabo003,g_fabo_d[l_ac].fabo001,g_fabo_d[l_ac].fabo002,g_fabg_m.fabgld) 
                        RETURNING l_success
                        
                        IF l_success = FALSE THEN 
                           INITIALIZE g_errparam TO NULL 
                           LET g_errparam.extend = ''
                           LET g_errparam.code   = 'afa-01026'
                           LET g_errparam.popup  = TRUE 
                           CALL cl_err()
                           #LET g_fabo_d[l_ac].fabo002 = g_fabo_d_t.fabo002 #160829-00042#1
                           LET g_fabo_d[l_ac].fabo001 = g_fabo_d_o.fabo001 #160829-00042#1
                           LET g_fabo_d[l_ac].fabo002 = g_fabo_d_o.fabo002 #160829-00042#1
                           LET g_fabo_d[l_ac].fabo003 = g_fabo_d_o.fabo003 #160829-00042#1
                           NEXT FIELD CURRENT
                        END IF
                     END IF
                     #20150608--add--end--lujh
                  END IF
                  #160829-00042#1---s---
                  CALL afat505_faid_chk() RETURNING l_success
                  IF NOT l_success THEN
                     LET g_fabo_d[l_ac].fabo001 = g_fabo_d_o.fabo001 
                     LET g_fabo_d[l_ac].fabo002 = g_fabo_d_o.fabo002 
                     LET g_fabo_d[l_ac].fabo003 = g_fabo_d_o.fabo003 
                     NEXT FIELD CURRENT                              
                  END IF           
                  #160829-00042#1---e---                  
               END IF
            END IF
            #160829-00042#1 ---s---
            #CALL afat505_faid_chk() RETURNING l_success
            #IF NOT l_success THEN           
            #   NEXT FIELD CURRENT
            #END IF
            #160829-00042#1---e---
            #IF l_cmd = 'a' OR (l_cmd = 'u' AND (g_fabo_d[l_ac].fabo001 != g_fabo_d_t.fabo001 OR g_fabo_d[l_ac].fabo002 != g_fabo_d_t.fabo002 OR g_fabo_d[l_ac].fabo003 != g_fabo_d_t.fabo003 )) THEN   #160829-00042#1  
            IF g_fabo_d[l_ac].fabo002 != g_fabo_d_o.fabo002 THEN #160829-00042#1
               CALL afat505_get_faah()
            END IF
            LET g_fabo_d_o.* = g_fabo_d[l_ac].*  #160829-00042#1
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fabo002
            #add-point:BEFORE FIELD fabo002 name="input.b.page1.fabo002"
            IF cl_null(g_fabo_d[l_ac].fabo002) THEN
               LET g_fabo_d[l_ac].fabo002 = ' '
            END IF
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fabo002
            #add-point:ON CHANGE fabo002 name="input.g.page1.fabo002"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fabo003
            
            #add-point:AFTER FIELD fabo003 name="input.a.page1.fabo003"
            IF g_fabo_d[l_ac].fabo002 IS NOT NULL AND NOT cl_null(g_fabo_d[l_ac].fabo003) AND NOT cl_null(g_fabo_d[l_ac].fabo001) THEN
               IF g_fabo_d[l_ac].fabo003 != g_fabo_d_o.fabo003 OR g_fabo_d_o.fabo003 IS NULL THEN #160829-00042#1
                  INITIALIZE g_chkparam.* TO NULL
                  #設定g_chkparam.*的參數
                  LET g_chkparam.arg1 = g_fabo_d[l_ac].fabo001
                  LET g_chkparam.arg2 = g_fabo_d[l_ac].fabo002
                  LET g_chkparam.arg3 = g_fabo_d[l_ac].fabo003
                  #160318-00025#5--add--str
                  LET g_errshow = TRUE 
                  LET g_chkparam.err_str[1] = "afa-00264:sub-01313|afai100|",cl_get_progname("afai100",g_lang,"2"),"|:EXEPROGafai100"
                  #160318-00025#5--add--end
                  #呼叫檢查存在並帶值的library
                  IF NOT cl_chk_exist("v_faah003_3") THEN
                     #檢查失敗時後續處理
                     #LET g_fabo_d[l_ac].fabo003 = g_fabo_d_t.fabo003 #160829-00042#1
                     LET g_fabo_d[l_ac].fabo001 = g_fabo_d_t.fabo001  #160829-00042#1
                     LET g_fabo_d[l_ac].fabo002 = g_fabo_d_t.fabo002  #160829-00042#1
                     LET g_fabo_d[l_ac].fabo003 = g_fabo_d_t.fabo003  #160829-00042#1
                     NEXT FIELD CURRENT
                  ELSE
                     #20150608--add--str--lujh
                     IF NOT cl_null(g_fabo_d[l_ac].fabo001) AND g_fabo_d[l_ac].fabo002 IS NOT NULL AND NOT cl_null(g_fabo_d[l_ac].fabo003) THEN 
                        CALL s_afa_faan_chk(g_fabg_m.fabgdocdt,g_fabo_d[l_ac].fabo003,g_fabo_d[l_ac].fabo001,g_fabo_d[l_ac].fabo002,g_fabg_m.fabgld) 
                        RETURNING l_success
                        
                        IF l_success = FALSE THEN 
                           INITIALIZE g_errparam TO NULL 
                           LET g_errparam.extend = ''
                           LET g_errparam.code   = 'afa-01026'
                           LET g_errparam.popup  = TRUE 
                           CALL cl_err()
                         # LET g_fabo_d[l_ac].fabo003 = g_fabo_d_t.fabo003  #160829-00042#1
                           LET g_fabo_d[l_ac].fabo001 = g_fabo_d_t.fabo001  #160829-00042#1
                           LET g_fabo_d[l_ac].fabo002 = g_fabo_d_t.fabo002  #160829-00042#1
                           LET g_fabo_d[l_ac].fabo003 = g_fabo_d_t.fabo003  #160829-00042#1
                           NEXT FIELD CURRENT
                        END IF
                     END IF
                     #20150608--add--end--lujh
                     #160829-00042#1---s---
                     CALL afat505_faid_chk() RETURNING l_success
                     IF NOT l_success THEN
                        LET g_fabo_d[l_ac].fabo001 = g_fabo_d_o.fabo001 
                        LET g_fabo_d[l_ac].fabo002 = g_fabo_d_o.fabo002 
                        LET g_fabo_d[l_ac].fabo003 = g_fabo_d_o.fabo003 
                        NEXT FIELD CURRENT                              
                     END IF           
                     #160829-00042#1---e---      
                  END IF
               END IF
            END IF
            #160829-00042#1---s---
            #IF NOT cl_null(g_fabo_d[l_ac].fabo003) THEN 
            #   CALL afat505_faid_chk() RETURNING l_success
            #   IF NOT l_success THEN
            #      NEXT FIELD CURRENT
            #   END IF
            #END IF
            #160829-00042#1---e---
            #IF l_cmd = 'a' OR (l_cmd = 'u' AND (g_fabo_d[l_ac].fabo001 != g_fabo_d_t.fabo001 OR g_fabo_d[l_ac].fabo002 != g_fabo_d_t.fabo002 OR g_fabo_d[l_ac].fabo003 != g_fabo_d_t.fabo003 )) THEN #160829-00042#1
            IF g_fabo_d[l_ac].fabo003 != g_fabo_d_o.fabo003 OR g_fabo_d_o.fabo003 IS NULL THEN #160829-00042#1
               CALL afat505_get_faah()
            END IF
            LET g_fabo_d_o.* = g_fabo_d[l_ac].* #160829-00042#1
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fabo003
            #add-point:BEFORE FIELD fabo003 name="input.b.page1.fabo003"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fabo003
            #add-point:ON CHANGE fabo003 name="input.g.page1.fabo003"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fabo005
            #add-point:BEFORE FIELD fabo005 name="input.b.page1.fabo005"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fabo005
            
            #add-point:AFTER FIELD fabo005 name="input.a.page1.fabo005"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fabo005
            #add-point:ON CHANGE fabo005 name="input.g.page1.fabo005"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fabo007
            #add-point:BEFORE FIELD fabo007 name="input.b.page1.fabo007"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fabo007
            
            #add-point:AFTER FIELD fabo007 name="input.a.page1.fabo007"
            IF NOT cl_null(g_fabo_d[l_ac].fabo007) THEN 
               #IF g_fabo_d[l_ac].fabo007>0 THEN 
                  IF l_cmd = 'a' OR ( g_fabo_d[l_ac].fabo007 <> g_fabo_d_t.fabo007 OR cl_null(g_fabo_d_t.fabo007)) THEN
                     SELECT faah018 INTO g_faah018 FROM faah_t
                      WHERE faahent = g_enterprise  
                        AND faah003 = g_fabo_d[l_ac].fabo001   
                        AND faah004 = g_fabo_d[l_ac].fabo002
                        AND faah001 = g_fabo_d[l_ac].fabo003 
                     IF g_fabo_d[l_ac].fabo007>g_faah018 THEN
                        INITIALIZE g_errparam TO NULL
                        LET g_errparam.code = 'afa-00261'
                        LET g_errparam.extend = g_fabo_d[l_ac].fabo007
                        LET g_errparam.popup = FALSE
                        CALL cl_err()
                        
                        LET g_fabo_d[l_ac].fabo007 = g_fabo_d_t.fabo007
                        NEXT FIELD fabo007
                     END IF
                  END IF
            END IF 
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fabo007
            #add-point:ON CHANGE fabo007 name="input.g.page1.fabo007"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fabo043
            
            #add-point:AFTER FIELD fabo043 name="input.a.page1.fabo043"
            IF NOT cl_null(g_fabo_d[l_ac].fabo043) THEN 
#此段落由子樣板a19產生
               #校驗代值
               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
               INITIALIZE g_chkparam.* TO NULL
               
               #設定g_chkparam.*的參數
               #160318-00025#5--add--str
               LET g_errshow = TRUE 
               LET g_chkparam.err_str[1] = "aoo-00095:sub-01302|aooi125|",cl_get_progname("aooi125",g_lang,"2"),"|:EXEPROGaooi125"
               #160318-00025#5--add--end
                  
               #呼叫檢查存在並帶值的library
               IF cl_chk_exist_and_ref_val("v_ooef001") THEN
                  #檢查成功時後續處理
                  #LET  = g_chkparam.return1
                  #DISPLAY BY NAME 
               ELSE
                  #檢查失敗時後續處理
                  NEXT FIELD CURRENT
               END IF
            

            END IF 


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fabo043
            #add-point:BEFORE FIELD fabo043 name="input.b.page1.fabo043"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fabo043
            #add-point:ON CHANGE fabo043 name="input.g.page1.fabo043"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fabo044
            
            #add-point:AFTER FIELD fabo044 name="input.a.page1.fabo044"
            IF NOT cl_null(g_fabo_d[l_ac].fabo044) THEN 
#此段落由子樣板a19產生
               #校驗代值
               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
               INITIALIZE g_chkparam.* TO NULL
               
               #設定g_chkparam.*的參數
               #160318-00025#5--add--str
               LET g_errshow = TRUE 
               LET g_chkparam.err_str[1] = "aoo-00095:sub-01302|aooi125|",cl_get_progname("aooi125",g_lang,"2"),"|:EXEPROGaooi125"
               #160318-00025#5--add--end
                  
               #呼叫檢查存在並帶值的library
               IF cl_chk_exist_and_ref_val("v_ooef001") THEN
                  #檢查成功時後續處理
                  #LET  = g_chkparam.return1
                  #DISPLAY BY NAME 
               ELSE
                  #檢查失敗時後續處理
                  NEXT FIELD CURRENT
               END IF
            

            END IF 


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fabo044
            #add-point:BEFORE FIELD fabo044 name="input.b.page1.fabo044"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fabo044
            #add-point:ON CHANGE fabo044 name="input.g.page1.fabo044"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fabo045
            
            #add-point:AFTER FIELD fabo045 name="input.a.page1.fabo045"
            IF NOT cl_null(g_fabo_d[l_ac].fabo045) THEN 
#此段落由子樣板a19產生
               #校驗代值
               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
               INITIALIZE g_chkparam.* TO NULL
               
               #設定g_chkparam.*的參數
               LET g_chkparam.arg2 = '參數2'
                  
               #呼叫檢查存在並帶值的library
               IF cl_chk_exist_and_ref_val("v_ooef001_3") THEN
                  #檢查成功時後續處理
                  #LET  = g_chkparam.return1
                  #DISPLAY BY NAME 
               ELSE
                  #檢查失敗時後續處理
                  NEXT FIELD CURRENT
               END IF
            

            END IF 


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fabo045
            #add-point:BEFORE FIELD fabo045 name="input.b.page1.fabo045"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fabo045
            #add-point:ON CHANGE fabo045 name="input.g.page1.fabo045"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fabo046
            
            #add-point:AFTER FIELD fabo046 name="input.a.page1.fabo046"
            IF NOT cl_null(g_fabo_d[l_ac].fabo046) THEN 
#此段落由子樣板a19產生
               #校驗代值
               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
               INITIALIZE g_chkparam.* TO NULL
               
               #設定g_chkparam.*的參數
               LET g_chkparam.arg1 = g_fabo_d[l_ac].fabo046
               #160318-00025#5--add--str
               LET g_errshow = TRUE 
               LET g_chkparam.err_str[1] = "aoo-00095:sub-01302|aooi125|",cl_get_progname("aooi125",g_lang,"2"),"|:EXEPROGaooi125"
               #160318-00025#5--add--end  
               #呼叫檢查存在並帶值的library
               IF cl_chk_exist("v_ooef001") THEN
                  #檢查成功時後續處理
                  #LET  = g_chkparam.return1
                  #DISPLAY BY NAME 
                  #161111-00049#12 add s---
                  CALL s_axrt300_get_site(g_user,'','1') RETURNING l_comp_str 
                  IF s_chr_get_index_of(l_comp_str,g_fabo_d[l_ac].fabo048,1) = 0 THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = 'afa-01118'
                     LET g_errparam.extend = ''
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                     LET g_fabo_d[l_ac].fabo046 = g_fabo_d_t.fabo046 
                     NEXT FIELD CURRENT                  
                  END IF
                  #161111-00049#12 add e---                    
               ELSE
                  #檢查失敗時後續處理
                  LET g_fabo_d[l_ac].fabo046 = g_fabo_d_t.fabo046
                  NEXT FIELD CURRENT
               END IF
            

            END IF 


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fabo046
            #add-point:BEFORE FIELD fabo046 name="input.b.page1.fabo046"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fabo046
            #add-point:ON CHANGE fabo046 name="input.g.page1.fabo046"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fabo047
            
            #add-point:AFTER FIELD fabo047 name="input.a.page1.fabo047"
            IF NOT cl_null(g_fabo_d[l_ac].fabo047) THEN 
#此段落由子樣板a19產生
               #校驗代值
               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
               INITIALIZE g_chkparam.* TO NULL
               
               #設定g_chkparam.*的參數
               LET g_chkparam.arg1 = g_fabo_d[l_ac].fabo047
               #160318-00025#5--add--str
               LET g_errshow = TRUE 
               LET g_chkparam.err_str[1] = "aoo-00095:sub-01302|aooi125|",cl_get_progname("aooi125",g_lang,"2"),"|:EXEPROGaooi125"
               #160318-00025#5--add--end  
               #呼叫檢查存在並帶值的library
               IF cl_chk_exist("v_ooef001") THEN
                  #檢查成功時後續處理
                  #LET  = g_chkparam.return1
                  #DISPLAY BY NAME 
                  #161111-00049#12 add s---
                  CALL s_axrt300_get_site(g_user,'','1') RETURNING l_comp_str 
                  IF s_chr_get_index_of(l_comp_str,g_fabo_d[l_ac].fabo048,1) = 0 THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = 'afa-01118'
                     LET g_errparam.extend = ''
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                     LET g_fabo_d[l_ac].fabo047 = g_fabo_d_t.fabo047 
                     NEXT FIELD CURRENT                  
                  END IF
                  #161111-00049#12 add e---                    
               ELSE
                  #檢查失敗時後續處理
                  LET g_fabo_d[l_ac].fabo047 = g_fabo_d_t.fabo047
                  NEXT FIELD CURRENT
               END IF
            
               #20141114 add--str-- by chenying
               #单身拨入组织的归属法人需一致
#               SELECT * INTO g_glaa.* FROM glaa_t WHERE glaaent = g_enterprise AND glaald = g_fabg_m.fabgld
               SELECT COUNT(1) INTO l_cnt1 FROM fabo_t 
                WHERE faboent = g_enterprise AND fabodocno = g_fabg_m.fabgdocno
                  AND fabold = g_fabg_m.fabgld 
               IF l_cnt1 > 0 THEN 
                  SELECT fabo047 INTO l_fabo047 FROM                
                  (SELECT fabo047 FROM fabo_t 
                    WHERE faboent = g_enterprise AND fabodocno = g_fabg_m.fabgdocno
                    ORDER BY faboseq) 
                   WHERE rownum = 1 
                  SELECT ooef017 INTO l_ooef017_1 FROM ooef_t
                   WHERE ooefent = g_enterprise AND ooef001 = l_fabo047                 
                  SELECT ooef017 INTO l_ooef017 FROM ooef_t
                   WHERE ooefent = g_enterprise AND ooef001 = g_fabo_d[l_ac].fabo047
                  IF l_ooef017 <> l_ooef017_1 THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = 'afa-00278'
                     LET g_errparam.extend = ''
                     LET g_errparam.popup = TRUE
                     CALL cl_err() 
                     NEXT FIELD fabo047                  
                  END IF 
               END IF                  
               #20141114 add--end-- 
            END IF 


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fabo047
            #add-point:BEFORE FIELD fabo047 name="input.b.page1.fabo047"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fabo047
            #add-point:ON CHANGE fabo047 name="input.g.page1.fabo047"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fabo048
            
            #add-point:AFTER FIELD fabo048 name="input.a.page1.fabo048"
            IF NOT cl_null(g_fabo_d[l_ac].fabo048) THEN 
#此段落由子樣板a19產生
               #校驗代值
               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
               INITIALIZE g_chkparam.* TO NULL
               
               #設定g_chkparam.*的參數
               LET g_chkparam.arg1 = g_fabo_d[l_ac].fabo048
#               LET g_chkparam.arg2 = '3'  #20141117 mark
                  
               #呼叫檢查存在並帶值的library
#               IF cl_chk_exist("v_ooef001_3") THEN #20141117 mark
#                IF cl_chk_exist("v_ooef001_3") THEN #20141117 add  #141201-00019#1 mark
                IF cl_chk_exist("v_ooef001_44") THEN  #141201-00019#1 add

                
                  #檢查成功時後續處理
                  #LET  = g_chkparam.return1
                  #DISPLAY BY NAME 
                  #20141117 add--str--
                  SELECT ooef204,ooef003 INTO l_ooef204,l_ooef003
                    FROM ooef_t
                   WHERE ooefent = g_enterprise
                     AND ooef001 = g_fabo_d[l_ac].fabo048
                  IF l_ooef204 = 'N' AND l_ooef003 = 'N' THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "" 
                     LET g_errparam.code   = "art-00218" 
                     LET g_errparam.popup  = TRUE 
                     CALL cl_err()
                     LET g_fabo_d[l_ac].fabo048 = g_fabo_d_t.fabo048                       
                  END IF                  
                  #20141117 add--end--
                  #161111-00049#12 add s---
                  CALL s_axrt300_get_site(g_user,'','1') RETURNING l_comp_str 
                  IF s_chr_get_index_of(l_comp_str,g_fabo_d[l_ac].fabo048,1) = 0 THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = 'afa-01118'
                     LET g_errparam.extend = ''
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                     LET g_fabo_d[l_ac].fabo048 = g_fabo_d_t.fabo048 
                     NEXT FIELD CURRENT                  
                  END IF
                  #161111-00049#12 add e---                  
               ELSE
                  #檢查失敗時後續處理
                  LET g_fabo_d[l_ac].fabo048 = g_fabo_d_t.fabo048
                  NEXT FIELD CURRENT
               END IF
            

            END IF 


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fabo048
            #add-point:BEFORE FIELD fabo048 name="input.b.page1.fabo048"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fabo048
            #add-point:ON CHANGE fabo048 name="input.g.page1.fabo048"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fabo023
            
            #add-point:AFTER FIELD fabo023 name="input.a.page1.fabo023"
            IF NOT cl_null(g_fabo_d[l_ac].fabo023) THEN 
#此段落由子樣板a19產生
               #校驗代值
               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
               INITIALIZE g_chkparam.* TO NULL
               
               #設定g_chkparam.*的參數
               LET g_chkparam.arg1 = g_fabo_d[l_ac].fabo023
                  
               #呼叫檢查存在並帶值的library
               IF cl_chk_exist("v_oocq002_3904") THEN
                  #檢查成功時後續處理
                  #LET  = g_chkparam.return1
                  #DISPLAY BY NAME 
               ELSE
                  #檢查失敗時後續處理
                  LET g_fabo_d[l_ac].fabo023 = g_fabo_d_t.fabo023
                  INITIALIZE g_ref_fields TO NULL
                  LET g_ref_fields[1] = g_fabo_d[l_ac].fabo023
                  CALL ap_ref_array2(g_ref_fields,"SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001='3904' AND oocql002=? AND oocql003='"||g_dlang||"'","") RETURNING g_rtn_fields
                  LET g_fabo_d[l_ac].fabo023_desc = '', g_rtn_fields[1] , ''
                  DISPLAY BY NAME g_fabo_d[l_ac].fabo023_desc
                  NEXT FIELD CURRENT
               END IF
            

            END IF 
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_fabo_d[l_ac].fabo023
            CALL ap_ref_array2(g_ref_fields,"SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001='3904' AND oocql002=? AND oocql003='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_fabo_d[l_ac].fabo023_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_fabo_d[l_ac].fabo023_desc


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fabo023
            #add-point:BEFORE FIELD fabo023 name="input.b.page1.fabo023"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fabo023
            #add-point:ON CHANGE fabo023 name="input.g.page1.fabo023"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fabo000
            #add-point:BEFORE FIELD fabo000 name="input.b.page1.fabo000"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fabo000
            
            #add-point:AFTER FIELD fabo000 name="input.a.page1.fabo000"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fabo000
            #add-point:ON CHANGE fabo000 name="input.g.page1.fabo000"
            
            #END add-point 
 
 
 
                  #Ctrlp:input.c.page1.faboseq
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD faboseq
            #add-point:ON ACTION controlp INFIELD faboseq name="input.c.page1.faboseq"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.fabo001
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fabo001
            #add-point:ON ACTION controlp INFIELD fabo001 name="input.c.page1.fabo001"
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_fabo_d[l_ac].fabo001             #給予default值
            LET g_qryparam.default2 = g_fabo_d[l_ac].fabo002
            LET g_qryparam.default3 = g_fabo_d[l_ac].fabo003
            LET g_qryparam.where = " faajld = '",g_fabg_m.fabgld,"' AND faah015 NOT IN('0','5','6','8','10') "
#                                   " AND faah032 IN (SELECT ooef017 FROM ooef_t WHERE ooefent = '",g_enterprise,"' AND ooef001 = '",g_fabg_m.fabgsite,"')"  
            #給予arg
            LET g_qryparam.arg1 = "" #

            #161111-00049#12 mod s---
            SELECT glaacomp INTO g_glaacomp FROM glaa_t WHERE glaaent = g_enterprise AND glaald = g_fabg_m.fabgld
            LET g_qryparam.where =  g_qryparam.where," AND faah032 = '",g_glaacomp,"'" 
            #161111-00049#12 mod s---              
            CALL q_faah003_5()                                #呼叫開窗

            LET g_fabo_d[l_ac].fabo001 = g_qryparam.return1              
            LET g_fabo_d[l_ac].fabo002 = g_qryparam.return2 
            LET g_fabo_d[l_ac].fabo003 = g_qryparam.return3 
            DISPLAY g_fabo_d[l_ac].fabo001 TO fabo001              #
            DISPLAY g_fabo_d[l_ac].fabo002 TO fabo002 #財產編號
            DISPLAY g_fabo_d[l_ac].fabo003 TO fabo003 #附號
            NEXT FIELD fabo001                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.page1.fabo002
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fabo002
            #add-point:ON ACTION controlp INFIELD fabo002 name="input.c.page1.fabo002"
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_fabo_d[l_ac].fabo001             #給予default值
            LET g_qryparam.default2 = g_fabo_d[l_ac].fabo002
            LET g_qryparam.default3 = g_fabo_d[l_ac].fabo003
            LET g_qryparam.where = " faajld = '",g_fabg_m.fabgld,"' AND faah015 NOT IN('0','5','6','8','10') "
            IF NOT cl_null(g_fabo_d[l_ac].fabo001) THEN
               LET g_qryparam.where = g_qryparam.where," AND faaj001 = '",g_fabo_d[l_ac].fabo001,"'"
            END IF
            #給予arg
            LET g_qryparam.arg1 = "" #
            #161111-00049#12 mod s---
            SELECT glaacomp INTO g_glaacomp FROM glaa_t WHERE glaaent = g_enterprise AND glaald = g_fabg_m.fabgld
            LET g_qryparam.where =  g_qryparam.where," AND faah032 = '",g_glaacomp,"'" 
            #161111-00049#12 mod s---  
            
            CALL q_faah003_6()                                #呼叫開窗

           #LET g_fabo_d[l_ac].fabo001 = g_qryparam.return1              
            LET g_fabo_d[l_ac].fabo002 = g_qryparam.return2 
           #LET g_fabo_d[l_ac].fabo003 = g_qryparam.return3 
           #DISPLAY g_fabo_d[l_ac].fabo001 TO fabo001              #
            DISPLAY g_fabo_d[l_ac].fabo002 TO fabo002 #財產編號
           #DISPLAY g_fabo_d[l_ac].fabo003 TO fabo003 #附號
            NEXT FIELD fabo002                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.page1.fabo003
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fabo003
            #add-point:ON ACTION controlp INFIELD fabo003 name="input.c.page1.fabo003"
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_fabo_d[l_ac].fabo001             #給予default值
            LET g_qryparam.default2 = g_fabo_d[l_ac].fabo002
            LET g_qryparam.default3 = g_fabo_d[l_ac].fabo003
            LET g_qryparam.where = " faajld = '",g_fabg_m.fabgld,"' AND faah015 NOT IN('0','5','6','8','10') "
            IF g_fabo_d[l_ac].fabo002 IS NOT NULL THEN
               LET g_qryparam.where = g_qryparam.where," AND faaj002 = '",g_fabo_d[l_ac].fabo002,"'"
            END IF
            IF NOT cl_null(g_fabo_d[l_ac].fabo001) THEN
               LET g_qryparam.where = g_qryparam.where," AND faaj001 = '",g_fabo_d[l_ac].fabo001,"'"
            END IF
            #給予arg
            LET g_qryparam.arg1 = "" #
            #161111-00049#12 mod s---
            SELECT glaacomp INTO g_glaacomp FROM glaa_t WHERE glaaent = g_enterprise AND glaald = g_fabg_m.fabgld
            LET g_qryparam.where =  g_qryparam.where," AND faah032 = '",g_glaacomp,"'" 
            #161111-00049#12 mod s---  
            
            CALL q_faah003_7()                                #呼叫開窗

           #LET g_fabo_d[l_ac].fabo001 = g_qryparam.return1              
           #LET g_fabo_d[l_ac].fabo002 = g_qryparam.return2 
            LET g_fabo_d[l_ac].fabo003 = g_qryparam.return3 
           #DISPLAY g_fabo_d[l_ac].fabo001 TO fabo001              #
           #DISPLAY g_fabo_d[l_ac].fabo002 TO fabo002 #財產編號
            DISPLAY g_fabo_d[l_ac].fabo003 TO fabo003 #附號
            NEXT FIELD fabo003                          #返回原欄位
            #END add-point
 
 
         #Ctrlp:input.c.page1.fabo005
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fabo005
            #add-point:ON ACTION controlp INFIELD fabo005 name="input.c.page1.fabo005"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.fabo007
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fabo007
            #add-point:ON ACTION controlp INFIELD fabo007 name="input.c.page1.fabo007"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.fabo043
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fabo043
            #add-point:ON ACTION controlp INFIELD fabo043 name="input.c.page1.fabo043"
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_fabo_d[l_ac].fabo043             #給予default值
            LET g_qryparam.default2 = "" #g_fabo_d[l_ac].ooefl003 #說明(簡稱)
            #給予arg
            LET g_qryparam.arg1 = "" #

            
            CALL q_ooef001()                                #呼叫開窗

            LET g_fabo_d[l_ac].fabo043 = g_qryparam.return1              
            #LET g_fabo_d[l_ac].ooefl003 = g_qryparam.return2 
            DISPLAY g_fabo_d[l_ac].fabo043 TO fabo043              #
            #DISPLAY g_fabo_d[l_ac].ooefl003 TO ooefl003 #說明(簡稱)
            NEXT FIELD fabo043                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.page1.fabo044
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fabo044
            #add-point:ON ACTION controlp INFIELD fabo044 name="input.c.page1.fabo044"
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_fabo_d[l_ac].fabo044             #給予default值
            LET g_qryparam.default2 = "" #g_fabo_d[l_ac].ooefl003 #說明(簡稱)
            #給予arg
            LET g_qryparam.arg1 = "" #

            
            CALL q_ooef001()                                #呼叫開窗

            LET g_fabo_d[l_ac].fabo044 = g_qryparam.return1              
            #LET g_fabo_d[l_ac].ooefl003 = g_qryparam.return2 
            DISPLAY g_fabo_d[l_ac].fabo044 TO fabo044              #
            #DISPLAY g_fabo_d[l_ac].ooefl003 TO ooefl003 #說明(簡稱)
            NEXT FIELD fabo044                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.page1.fabo045
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fabo045
            #add-point:ON ACTION controlp INFIELD fabo045 name="input.c.page1.fabo045"
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_fabo_d[l_ac].fabo045             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "" #

            
            CALL q_ooef001_04()                                #呼叫開窗

            LET g_fabo_d[l_ac].fabo045 = g_qryparam.return1              

            DISPLAY g_fabo_d[l_ac].fabo045 TO fabo045              #

            NEXT FIELD fabo045                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.page1.fabo046
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fabo046
            #add-point:ON ACTION controlp INFIELD fabo046 name="input.c.page1.fabo046"
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_fabo_d[l_ac].fabo046             #給予default值
            LET g_qryparam.default2 = "" #g_fabo_d[l_ac].ooefl003 #說明(簡稱)
            #給予arg
            LET g_qryparam.arg1 = "" #
            #161111-00049#12 mod s---
            CALL s_axrt300_get_site(g_user,'','1') RETURNING l_comp_str
            LET g_qryparam.where = l_comp_str 
            #161111-00049#12 mod s---   
            
            CALL q_ooef001()                                #呼叫開窗

            LET g_fabo_d[l_ac].fabo046 = g_qryparam.return1              
            #LET g_fabo_d[l_ac].ooefl003 = g_qryparam.return2 
            DISPLAY g_fabo_d[l_ac].fabo046 TO fabo046              #
            #DISPLAY g_fabo_d[l_ac].ooefl003 TO ooefl003 #說明(簡稱)
            NEXT FIELD fabo046                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.page1.fabo047
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fabo047
            #add-point:ON ACTION controlp INFIELD fabo047 name="input.c.page1.fabo047"
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_fabo_d[l_ac].fabo047             #給予default值
            LET g_qryparam.default2 = "" #g_fabo_d[l_ac].ooefl003 #說明(簡稱)
            #給予arg
            LET g_qryparam.arg1 = "" #

            #161111-00049#12 mod s---
            CALL s_axrt300_get_site(g_user,'','1') RETURNING l_comp_str
            LET g_qryparam.where = l_comp_str 
            #161111-00049#12 mod s---             
            CALL q_ooef001()                                #呼叫開窗

            LET g_fabo_d[l_ac].fabo047 = g_qryparam.return1              
            #LET g_fabo_d[l_ac].ooefl003 = g_qryparam.return2 
            DISPLAY g_fabo_d[l_ac].fabo047 TO fabo047              #
            #DISPLAY g_fabo_d[l_ac].ooefl003 TO ooefl003 #說明(簡稱)
            NEXT FIELD fabo047                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.page1.fabo048
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fabo048
            #add-point:ON ACTION controlp INFIELD fabo048 name="input.c.page1.fabo048"
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_fabo_d[l_ac].fabo048             #給予default值

            #給予arg
            LET g_qryparam.arg1 = '3'

#            CALL q_ooef001_04()       #141201-00019#1 mrak
            #161111-00049#12 mod s---
            CALL s_axrt300_get_site(g_user,'','1') RETURNING l_comp_str
            LET g_qryparam.where = l_comp_str 
            #161111-00049#12 mod s---   
            CALL q_ooef001_45()      #141201-00019#1 add   

            LET g_fabo_d[l_ac].fabo048 = g_qryparam.return1              

            DISPLAY g_fabo_d[l_ac].fabo048 TO fabo048              #

            NEXT FIELD fabo048                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.page1.fabo023
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fabo023
            #add-point:ON ACTION controlp INFIELD fabo023 name="input.c.page1.fabo023"
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_fabo_d[l_ac].fabo023             #給予default值
            LET g_qryparam.default2 = "" #g_fabo_d[l_ac].oocq002 #應用分類碼
            #給予arg
            LET g_qryparam.arg1 = "3904" #

            
            CALL q_oocq002()                                #呼叫開窗

            LET g_fabo_d[l_ac].fabo023 = g_qryparam.return1              
            LET g_fabo_d[l_ac].fabo023_desc = g_qryparam.return2 
            DISPLAY g_fabo_d[l_ac].fabo023 TO fabo023              #
            DISPLAY g_fabo_d[l_ac].fabo023_desc TO oocq002_desc #應用分類碼
            NEXT FIELD fabo023                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.page1.fabo000
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fabo000
            #add-point:ON ACTION controlp INFIELD fabo000 name="input.c.page1.fabo000"
            
            #END add-point
 
 
 
 
         ON ROW CHANGE
            IF INT_FLAG THEN
               LET INT_FLAG = 0
               LET g_fabo_d[l_ac].* = g_fabo_d_t.*
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code = 9001 
               LET g_errparam.popup = FALSE 
               CLOSE afat505_bcl
               CALL s_transaction_end('N','0')
               CALL cl_err()
               EXIT DIALOG 
            END IF
              
            IF l_lock_sw = 'Y' THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = g_fabo_d[l_ac].faboseq 
               LET g_errparam.code = -263 
               LET g_errparam.popup = TRUE 
               CALL cl_err()
               LET g_fabo_d[l_ac].* = g_fabo_d_t.*
            ELSE
            
               #add-point:單身修改前 name="input.body.b_update"
               
               #end add-point
               
               #寫入修改者/修改日期資訊(單身)
               
      
               #將遮罩欄位還原
               CALL afat505_fabo_t_mask_restore('restore_mask_o')
      
               UPDATE fabo_t SET (fabold,fabodocno,faboseq,fabo001,fabo002,fabo003,fabo005,fabo007,fabo043, 
                   fabo044,fabo045,fabo046,fabo047,fabo048,fabo023,fabo000) = (g_fabg_m.fabgld,g_fabg_m.fabgdocno, 
                   g_fabo_d[l_ac].faboseq,g_fabo_d[l_ac].fabo001,g_fabo_d[l_ac].fabo002,g_fabo_d[l_ac].fabo003, 
                   g_fabo_d[l_ac].fabo005,g_fabo_d[l_ac].fabo007,g_fabo_d[l_ac].fabo043,g_fabo_d[l_ac].fabo044, 
                   g_fabo_d[l_ac].fabo045,g_fabo_d[l_ac].fabo046,g_fabo_d[l_ac].fabo047,g_fabo_d[l_ac].fabo048, 
                   g_fabo_d[l_ac].fabo023,g_fabo_d[l_ac].fabo000)
                WHERE faboent = g_enterprise AND fabold = g_fabg_m.fabgld 
                  AND fabodocno = g_fabg_m.fabgdocno 
 
                  AND faboseq = g_fabo_d_t.faboseq #項次   
 
                  
               #add-point:單身修改中 name="input.body.m_update"
               
               #end add-point
               CASE
                  WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
                     LET g_fabo_d[l_ac].* = g_fabo_d_t.*
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "fabo_t" 
                     LET g_errparam.code = "std-00009" 
                     LET g_errparam.popup = TRUE 
                     CALL s_transaction_end('N','0')
                     CALL cl_err()
                     
                  WHEN SQLCA.SQLCODE #其他錯誤
                     LET g_fabo_d[l_ac].* = g_fabo_d_t.*  
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "fabo_t:",SQLERRMESSAGE 
                     LET g_errparam.code = SQLCA.SQLCODE 
                     LET g_errparam.popup = TRUE 
                     CALL s_transaction_end('N','0')
                     CALL cl_err()                   
                     
                  OTHERWISE
                     #資料多語言用-增/改
                     
                                    INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_fabg_m.fabgld
               LET gs_keys_bak[1] = g_fabgld_t
               LET gs_keys[2] = g_fabg_m.fabgdocno
               LET gs_keys_bak[2] = g_fabgdocno_t
               LET gs_keys[3] = g_fabo_d[g_detail_idx].faboseq
               LET gs_keys_bak[3] = g_fabo_d_t.faboseq
               CALL afat505_update_b('fabo_t',gs_keys,gs_keys_bak,"'1'")
               END CASE
 
               #將遮罩欄位進行遮蔽
               CALL afat505_fabo_t_mask_restore('restore_mask_n')
               
               #判斷key是否有改變
               INITIALIZE gs_keys TO NULL
               IF NOT(g_fabo_d[g_detail_idx].faboseq = g_fabo_d_t.faboseq 
 
                  ) THEN
                  LET gs_keys[01] = g_fabg_m.fabgld
                  LET gs_keys[gs_keys.getLength()+1] = g_fabg_m.fabgdocno
 
                  LET gs_keys[gs_keys.getLength()+1] = g_fabo_d_t.faboseq
 
                  CALL afat505_key_update_b(gs_keys,'fabo_t')
               END IF
               
               #修改歷程記錄(單身修改)
               LET g_log1 = util.JSON.stringify(g_fabg_m),util.JSON.stringify(g_fabo_d_t)
               LET g_log2 = util.JSON.stringify(g_fabg_m),util.JSON.stringify(g_fabo_d[l_ac])
               IF NOT cl_log_modified_record_d(g_log1,g_log2) THEN 
                  CALL s_transaction_end('N','0')
               END IF
               
               #add-point:單身修改後 name="input.body.a_update"
               IF (g_fabo_d[l_ac].fabo043 <> g_fabo_d[l_ac].fabo046 OR
                   g_fabo_d[l_ac].fabo045 <> g_fabo_d[l_ac].fabo048) THEN 
                  
                  CALL afat505_fabe_ins()                  
               END IF
               
               IF g_fabo_d[l_ac].fabo044 <> g_fabo_d[l_ac].fabo047 THEN
                  CALL afat505_01(g_fabg_m.fabgld,g_fabg_m.fabgdocno,g_fabo_d[l_ac].faboseq,
                               g_fabo_d[l_ac].fabo001,g_fabo_d[l_ac].fabo002,
                               g_fabo_d[l_ac].fabo003,g_fabo_d[l_ac].fabo007,
                               g_fabg_m.fabgdocdt,
                               g_fabo_d[l_ac].fabo044,g_fabo_d[l_ac].fabo047) #20141113 add by chenying 新增传参调入/出所有组织
               END IF
               #end add-point
 
            END IF
            
         AFTER ROW
            #add-point:單身after_row name="input.body.after_row"
            
            #end add-point
            CALL afat505_unlock_b("fabo_t","'1'")
            CALL s_transaction_end('Y','0')
            #其他table進行unlock
            #add-point:單身after_row2 name="input.body.after_row2"
            
            #end add-point
              
         AFTER INPUT
            #add-point:input段after input  name="input.body.after_input"
            
            #end add-point 
    
         ON ACTION controlo    
            IF l_insert THEN
               LET li_reproduce = l_ac_t
               LET li_reproduce_target = l_ac
               LET g_fabo_d[li_reproduce_target].* = g_fabo_d[li_reproduce].*
 
               LET g_fabo_d[li_reproduce_target].faboseq = NULL
 
            ELSE
               CALL FGL_SET_ARR_CURR(g_fabo_d.getLength()+1)
               LET lb_reproduce = TRUE
               LET li_reproduce = l_ac
               LET li_reproduce_target = g_fabo_d.getLength()+1
            END IF
            
         #ON ACTION cancel
         #   LET INT_FLAG = 1
         #   LET g_detail_idx = 1
         #   EXIT DIALOG 
 
      END INPUT
      
 
      
 
 
 
 
{</section>}
 
{<section id="afat505.input.other" >}
      
      #add-point:自定義input name="input.more_input"
      
      #end add-point
    
      BEFORE DIALOG 
         #CALL cl_err_collect_init()    
         #add-point:input段before dialog name="input.before_dialog"
         IF p_cmd = 'a' THEN
            NEXT FIELD fabgsite
         ELSE
            CASE g_aw
               WHEN "s_detail1"
                  NEXT FIELD faboseq
               WHEN "s_detail2"
                  NEXT FIELD faboseq_2
               WHEN "s_detail3"
                  NEXT FIELD faboseq_3
 
            END CASE
         END IF
         #end add-point    
         #重新導回資料到正確位置上
         CALL DIALOG.setCurrentRow("s_detail1",g_idx_group.getValue("'1',"))      
 
         #新增時強制從單頭開始填
         IF p_cmd = 'a' THEN
            #add-point:input段next_field name="input.next_field"
            
            #end add-point  
            NEXT FIELD fabgld
         ELSE
            CASE g_aw
               WHEN "s_detail1"
                  NEXT FIELD faboseq
 
               #add-point:input段modify_detail  name="input.modify_detail.other"
               
               #end add-point  
            END CASE
         END IF
      
      AFTER DIALOG
         #add-point:input段after_dialog name="input.after_dialog"
         
         #end add-point    
         
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
         #add-point:input段accept  name="input.accept"
         
         #end add-point    
         ACCEPT DIALOG
        
      ON ACTION cancel      #在dialog button (放棄)
         #add-point:input段cancel name="input.cancel"
         
         #end add-point  
         LET INT_FLAG = TRUE 
         LET g_detail_idx  = 1
         LET g_detail_idx2 = 1
         #各個page指標
         LET g_detail_idx_list[1] = 1 
 
         CALL g_curr_diag.setCurrentRow("s_detail1",1)    
 
         EXIT DIALOG
 
      ON ACTION close       #在dialog 右上角 (X)
         #add-point:input段close name="input.close"
         
         #end add-point  
         LET INT_FLAG = TRUE 
         EXIT DIALOG
 
      ON ACTION exit        #toolbar 離開
         #add-point:input段exit name="input.exit"
         
         #end add-point
         LET INT_FLAG = TRUE 
         LET g_detail_idx  = 1
         LET g_detail_idx2 = 1
         #各個page指標
         LET g_detail_idx_list[1] = 1 
 
         CALL g_curr_diag.setCurrentRow("s_detail1",1)    
 
         EXIT DIALOG
 
      #交談指令共用ACTION
      &include "common_action.4gl" 
         CONTINUE DIALOG 
   END DIALOG
    
   #add-point:input段after input  name="input.after_input"
   #151125-00006#2--add--s
   IF NOT INT_FLAG THEN
      CALL s_aooi200_fin_get_slip(g_fabg_m.fabgdocno) RETURNING l_success,l_ooba002
      CALL s_fin_orga_get_comp_ld(g_fabg_m.fabgsite) RETURNING g_sub_success,g_errno,l_fabgcomp,l_ld
      CALL s_fin_get_doc_para(g_fabg_m.fabgld,l_fabgcomp,l_ooba002,'D-FIN-0031') RETURNING l_dfin0031
      CALL s_fin_get_doc_para(g_fabg_m.fabgld,l_fabgcomp,l_ooba002,'D-FIN-0032') RETURNING l_dfin0032
      LET l_cnt = 0 
      SELECT COUNT(1) INTO l_cnt FROM fabo_t WHERE faboent = g_enterprise AND fabodocno = g_fabg_m.fabgdocno
      IF l_cnt >0 THEN 
        IF NOT cl_null(l_dfin0031) AND l_dfin0031 MATCHES '[Yy]' THEN 
           IF cl_ask_confirm('aap-00403') THEN
              CALL s_transaction_begin()
              CALL s_afat503_immediately_conf_1(g_fabg_m.fabgdocno,l_fabgcomp,g_fabg_m.fabgld,g_fabg_m.fabgdocdt,g_prog) RETURNING l_success
              IF l_success THEN 
                 CALL s_transaction_end('Y','0')
              ELSE
                 CALL s_transaction_end('N','0')
                 CALL cl_err_collect_show()
              END IF
           END IF 
        END IF
      END IF
   END IF
   #151125-00006#2--add--e
   #end add-point    
 
END FUNCTION
 
{</section>}
 
{<section id="afat505.show" >}
#+ 單頭資料重新顯示及單身資料重抓
PRIVATE FUNCTION afat505_show()
   #add-point:show段define(客製用) name="show.define_customerization"
   
   #end add-point  
   DEFINE l_ac_t    LIKE type_t.num10
   #add-point:show段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="show.define"
   
   #end add-point  
   
   #add-point:Function前置處理 name="show.before"
   IF g_fabg_m.fabgstus = 'N' THEN
      CALL cl_set_act_visible("modify,delete,modify_detail", TRUE)   
   ELSE
      CALL cl_set_act_visible("modify,delete,modify_detail", FALSE)
   END IF
   #end add-point
   
   
   
   IF g_bfill = "Y" THEN
      CALL afat505_b_fill() #單身填充
      CALL afat505_b_fill2('0') #單身填充
   END IF
     
   #帶出公用欄位reference值
   #應用 a12 樣板自動產生(Version:4)
 
 
 
   
   #顯示followup圖示
   #應用 a48 樣板自動產生(Version:3)
   CALL afat505_set_pk_array()
   #add-point:ON ACTION agendum name="show.follow_pic"
   
   #END add-point
   CALL cl_user_overview_set_follow_pic()
  
 
 
 
   
   LET l_ac_t = l_ac
   
   #讀入ref值(單頭)
   #add-point:show段reference name="show.head.reference"
   
   #end add-point
   
   #遮罩相關處理
   LET g_fabg_m_mask_o.* =  g_fabg_m.*
   CALL afat505_fabg_t_mask()
   LET g_fabg_m_mask_n.* =  g_fabg_m.*
   
   #將資料輸出到畫面上
   DISPLAY BY NAME g_fabg_m.fabgsite,g_fabg_m.fabgsite_desc,g_fabg_m.fabg001,g_fabg_m.fabg001_desc,g_fabg_m.fabgld, 
       g_fabg_m.fabgld_desc,g_fabg_m.fabg002,g_fabg_m.fabg002_desc,g_fabg_m.fabg003,g_fabg_m.fabg003_desc, 
       g_fabg_m.fabg004,g_fabg_m.fabg005,g_fabg_m.fabgdocno,g_fabg_m.fabgdocdt,g_fabg_m.fabg010,g_fabg_m.fabg017, 
       g_fabg_m.fabg018,g_fabg_m.fabgstus,g_fabg_m.fabgownid,g_fabg_m.fabgownid_desc,g_fabg_m.fabgowndp, 
       g_fabg_m.fabgowndp_desc,g_fabg_m.fabgcrtid,g_fabg_m.fabgcrtid_desc,g_fabg_m.fabgcrtdp,g_fabg_m.fabgcrtdp_desc, 
       g_fabg_m.fabgcrtdt,g_fabg_m.fabgmodid,g_fabg_m.fabgmodid_desc,g_fabg_m.fabgmoddt,g_fabg_m.fabgcnfid, 
       g_fabg_m.fabgcnfid_desc,g_fabg_m.fabgcnfdt,g_fabg_m.fabgpstid,g_fabg_m.fabgpstid_desc,g_fabg_m.fabgpstdt 
 
   
   #顯示狀態(stus)圖片
         #應用 a21 樣板自動產生(Version:3)
	  #根據當下狀態碼顯示圖片
      CASE g_fabg_m.fabgstus 
         WHEN "A"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/approved.png")
         WHEN "D"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/withdraw.png")
         WHEN "N"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/unconfirmed.png")
         WHEN "R"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/rejection.png")
         WHEN "W"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/signing.png")
         WHEN "Y"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/confirmed.png")
         WHEN "Z"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/unposted.png")
         WHEN "S"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/posted.png")
         WHEN "X"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/invalid.png")
         
      END CASE
 
 
 
   
   #讀入ref值(單身)
   FOR l_ac = 1 TO g_fabo_d.getLength()
      #add-point:show段單身reference name="show.body.reference"
      
      #end add-point
   END FOR
   
 
   
    
   
   #add-point:show段other name="show.other"
   
   #end add-point  
   
   LET l_ac = l_ac_t
   
   #移動上下筆可以連動切換資料
   CALL cl_show_fld_cont()     
 
   CALL afat505_detail_show()
 
   #add-point:show段之後 name="show.after"
   
   #end add-point
   
END FUNCTION
 
{</section>}
 
{<section id="afat505.detail_show" >}
#+ 第二階單身reference
PRIVATE FUNCTION afat505_detail_show()
   #add-point:detail_show段define(客製用) name="detail_show.define_customerization"
   
   #end add-point  
   #add-point:detail_show段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="detail_show.define"
   
   #end add-point  
   
   #add-point:Function前置處理 name="detail_show.before"
   
   #end add-point
   
   #add-point:detail_show段之後 name="detail_show.after"
   
   #end add-point
   
END FUNCTION
 
{</section>}
 
{<section id="afat505.reproduce" >}
#+ 資料複製
PRIVATE FUNCTION afat505_reproduce()
   #add-point:reproduce段define(客製用) name="reproduce.define_customerization"
   
   #end add-point   
   DEFINE l_newno     LIKE fabg_t.fabgld 
   DEFINE l_oldno     LIKE fabg_t.fabgld 
   DEFINE l_newno02     LIKE fabg_t.fabgdocno 
   DEFINE l_oldno02     LIKE fabg_t.fabgdocno 
 
   DEFINE l_master    RECORD LIKE fabg_t.* #此變數樣板目前無使用
   DEFINE l_detail    RECORD LIKE fabo_t.* #此變數樣板目前無使用
 
 
   DEFINE l_cnt       LIKE type_t.num10
   #add-point:reproduce段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="reproduce.define"
   
   #end add-point   
   
   #add-point:Function前置處理  name="reproduce.pre_function"
   
   #end add-point
   
   #切換畫面
   
   LET g_master_insert = FALSE
   
   IF g_fabg_m.fabgld IS NULL
   OR g_fabg_m.fabgdocno IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code = "std-00003" 
      LET g_errparam.popup = FALSE 
      CALL cl_err()
      RETURN
   END IF
    
   LET g_fabgld_t = g_fabg_m.fabgld
   LET g_fabgdocno_t = g_fabg_m.fabgdocno
 
    
   LET g_fabg_m.fabgld = ""
   LET g_fabg_m.fabgdocno = ""
 
 
   CALL cl_set_head_visible("","YES")
 
   #公用欄位給予預設值
   #應用 a14 樣板自動產生(Version:5)    
      #公用欄位新增給值  
      LET g_fabg_m.fabgownid = g_user
      LET g_fabg_m.fabgowndp = g_dept
      LET g_fabg_m.fabgcrtid = g_user
      LET g_fabg_m.fabgcrtdp = g_dept 
      LET g_fabg_m.fabgcrtdt = cl_get_current()
      LET g_fabg_m.fabgmodid = g_user
      LET g_fabg_m.fabgmoddt = cl_get_current()
      LET g_fabg_m.fabgstus = 'N'
 
 
 
   
   CALL s_transaction_begin()
   
   #add-point:複製輸入前 name="reproduce.head.b_input"
   #160414-00015#1 add -str
   LET g_fabg_m.fabgdocdt = g_today
   LET g_fabg_m.fabgcnfdt = NULL
   LET g_fabg_m.fabgcnfid  = NULL
   LET g_fabg_m.fabgcnfid_desc  = NULL   
   #160414-00015#1 add -end
   #end add-point
   
   #顯示狀態(stus)圖片
         #應用 a21 樣板自動產生(Version:3)
	  #根據當下狀態碼顯示圖片
      CASE g_fabg_m.fabgstus 
         WHEN "A"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/approved.png")
         WHEN "D"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/withdraw.png")
         WHEN "N"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/unconfirmed.png")
         WHEN "R"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/rejection.png")
         WHEN "W"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/signing.png")
         WHEN "Y"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/confirmed.png")
         WHEN "Z"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/unposted.png")
         WHEN "S"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/posted.png")
         WHEN "X"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/invalid.png")
         
      END CASE
 
 
 
   
   #清空key欄位的desc
      LET g_fabg_m.fabgld_desc = ''
   DISPLAY BY NAME g_fabg_m.fabgld_desc
 
   
   CALL afat505_input("r")
   
   IF INT_FLAG AND NOT g_master_insert THEN
      LET INT_FLAG = 0
      DISPLAY g_detail_cnt  TO FORMONLY.h_count    #總筆數
      DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
      LET INT_FLAG = 0
      INITIALIZE g_fabg_m.* TO NULL
      INITIALIZE g_fabo_d TO NULL
 
      #add-point:複製取消後 name="reproduce.cancel"
      
      #end add-point
      CALL afat505_show()
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = '' 
      LET g_errparam.code = 9001 
      LET g_errparam.popup = FALSE 
      CALL s_transaction_end('N','0')
      CALL cl_err()
      RETURN
   END IF
   
   #根據資料狀態切換action狀態
   CALL cl_set_act_visible("statechange,modify,modify_detail,delete,reproduce", TRUE)
   CALL afat505_set_act_visible()   
   CALL afat505_set_act_no_visible()
   
   #將新增的資料併入搜尋條件中
   LET g_fabgld_t = g_fabg_m.fabgld
   LET g_fabgdocno_t = g_fabg_m.fabgdocno
 
   
   #組合新增資料的條件
   LET g_add_browse = " fabgent = " ||g_enterprise|| " AND",
                      " fabgld = '", g_fabg_m.fabgld, "' "
                      ," AND fabgdocno = '", g_fabg_m.fabgdocno, "' "
 
   #填到最後面
   LET g_current_idx = g_browser.getLength() + 1
   CALL afat505_browser_fill("")
   
   DISPLAY g_browser_cnt TO FORMONLY.h_count    #總筆數
   DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
   CALL cl_navigator_setting(g_current_idx, g_browser_cnt)
   
   #add-point:完成複製段落後 name="reproduce.after_reproduce"
   
   #end add-point
   
   CALL afat505_idx_chk()
   
   LET g_data_owner = g_fabg_m.fabgownid      
   LET g_data_dept  = g_fabg_m.fabgowndp
   
   #功能已完成,通報訊息中心
   CALL afat505_msgcentre_notify('reproduce')
 
END FUNCTION
 
{</section>}
 
{<section id="afat505.detail_reproduce" >}
#+ 單身自動複製
PRIVATE FUNCTION afat505_detail_reproduce()
   #add-point:delete段define(客製用) name="detail_reproduce.define_customerization"
   
   #end add-point    
   DEFINE ls_sql      STRING
   DEFINE ld_date     DATETIME YEAR TO SECOND
   DEFINE l_detail    RECORD LIKE fabo_t.* #此變數樣板目前無使用
 
 
   #add-point:delete段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="detail_reproduce.define"
   
   #end add-point    
   
   #add-point:Function前置處理  name="detail_reproduce.pre_function"
   
   #end add-point
   
   CALL s_transaction_begin()
   
   LET ld_date = cl_get_current()
   
   DROP TABLE afat505_detail
   
   #add-point:單身複製前1 name="detail_reproduce.body.table1.b_insert"
   
   #end add-point
   
   #CREATE TEMP TABLE
   SELECT * FROM fabo_t
    WHERE faboent = g_enterprise AND fabold = g_fabgld_t
     AND fabodocno = g_fabgdocno_t
 
    INTO TEMP afat505_detail
 
   #將key修正為調整後   
   UPDATE afat505_detail 
      #更新key欄位
      SET fabold = g_fabg_m.fabgld
          , fabodocno = g_fabg_m.fabgdocno
 
      #更新共用欄位
      
 
   #add-point:單身修改前 name="detail_reproduce.body.table1.b_update"
   
   #end add-point                                       
  
   #將資料塞回原table   
   INSERT INTO fabo_t SELECT * FROM afat505_detail
   
   IF SQLCA.SQLCODE THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "reproduce:",SQLERRMESSAGE 
      LET g_errparam.code = SQLCA.SQLCODE 
      LET g_errparam.popup = TRUE 
      CALL cl_err()
      RETURN
   END IF
   
   #add-point:單身複製中1 name="detail_reproduce.body.table1.m_insert"
   
   #end add-point
   
   #刪除TEMP TABLE
   DROP TABLE afat505_detail
   
   #add-point:單身複製後1 name="detail_reproduce.body.table1.a_insert"
   
   #end add-point
 
 
   
 
   
   #多語言複製段落
   
   
   CALL s_transaction_end('Y','0')
   
   #已新增完, 調整資料內容(修改時使用)
   LET g_fabgld_t = g_fabg_m.fabgld
   LET g_fabgdocno_t = g_fabg_m.fabgdocno
 
   
END FUNCTION
 
{</section>}
 
{<section id="afat505.delete" >}
#+ 資料刪除
PRIVATE FUNCTION afat505_delete()
   #add-point:delete段define(客製用) name="delete.define_customerization"
   
   #end add-point     
   DEFINE  l_var_keys      DYNAMIC ARRAY OF STRING
   DEFINE  l_field_keys    DYNAMIC ARRAY OF STRING
   DEFINE  l_vars          DYNAMIC ARRAY OF STRING
   DEFINE  l_fields        DYNAMIC ARRAY OF STRING
   DEFINE  l_var_keys_bak  DYNAMIC ARRAY OF STRING
   #add-point:delete段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="delete.define"
   #161215-00044#1---modify----begin-----------------
   #DEFINE  l_fabo          RECORD LIKE fabo_t.*
   DEFINE l_fabo RECORD  #資產出售單身檔
       faboent LIKE fabo_t.faboent, #企業編碼
       fabold LIKE fabo_t.fabold, #帳套
       fabodocno LIKE fabo_t.fabodocno, #異動單號
       faboseq LIKE fabo_t.faboseq, #項次
       fabo000 LIKE fabo_t.fabo000, #資產類型
       fabo001 LIKE fabo_t.fabo001, #財產編號
       fabo002 LIKE fabo_t.fabo002, #附號
       fabo003 LIKE fabo_t.fabo003, #卡片編號
       fabo004 LIKE fabo_t.fabo004, #未折減額
       fabo005 LIKE fabo_t.fabo005, #單位
       fabo006 LIKE fabo_t.fabo006, #單價
       fabo007 LIKE fabo_t.fabo007, #調撥/出售數量
       fabo008 LIKE fabo_t.fabo008, #成本
       fabo009 LIKE fabo_t.fabo009, #稅別
       fabo010 LIKE fabo_t.fabo010, #交易幣別
       fabo011 LIKE fabo_t.fabo011, #原幣匯率
       fabo012 LIKE fabo_t.fabo012, #原幣未稅金額
       fabo013 LIKE fabo_t.fabo013, #原幣稅額
       fabo014 LIKE fabo_t.fabo014, #原幣應收金額
       fabo015 LIKE fabo_t.fabo015, #本幣未稅金額
       fabo016 LIKE fabo_t.fabo016, #本幣稅額
       fabo017 LIKE fabo_t.fabo017, #本幣應收金額
       fabo018 LIKE fabo_t.fabo018, #處置成本
       fabo019 LIKE fabo_t.fabo019, #處置累折
       fabo020 LIKE fabo_t.fabo020, #處置減值準備
       fabo021 LIKE fabo_t.fabo021, #處置本期折舊
       fabo022 LIKE fabo_t.fabo022, #處置未折減額
       fabo023 LIKE fabo_t.fabo023, #異動原因
       fabo024 LIKE fabo_t.fabo024, #異動科目
       fabo025 LIKE fabo_t.fabo025, #處置預留殘值
       fabo026 LIKE fabo_t.fabo026, #累折科目
       fabo027 LIKE fabo_t.fabo027, #減值準備科目
       fabo028 LIKE fabo_t.fabo028, #資產科目
       fabo029 LIKE fabo_t.fabo029, #應收帳款科目
       fabo030 LIKE fabo_t.fabo030, #稅額科目
       fabo031 LIKE fabo_t.fabo031, #營運據點
       fabo032 LIKE fabo_t.fabo032, #部門
       fabo033 LIKE fabo_t.fabo033, #利潤/成本中心
       fabo034 LIKE fabo_t.fabo034, #區域
       fabo035 LIKE fabo_t.fabo035, #交易客商
       fabo036 LIKE fabo_t.fabo036, #帳款客商
       fabo037 LIKE fabo_t.fabo037, #客群
       fabo038 LIKE fabo_t.fabo038, #人員
       fabo039 LIKE fabo_t.fabo039, #專案編號
       fabo040 LIKE fabo_t.fabo040, #WBS
       fabo041 LIKE fabo_t.fabo041, #帳款編號
       fabo042 LIKE fabo_t.fabo042, #摘要
       fabo043 LIKE fabo_t.fabo043, #調出管理組織
       fabo044 LIKE fabo_t.fabo044, #調出所有組織
       fabo045 LIKE fabo_t.fabo045, #調出核算組織
       fabo046 LIKE fabo_t.fabo046, #調入管理組織
       fabo047 LIKE fabo_t.fabo047, #調入所有組織
       fabo048 LIKE fabo_t.fabo048, #調入核算組織
       fabo049 LIKE fabo_t.fabo049, #處分損益
       fabo050 LIKE fabo_t.fabo050, #應收帳款單號
       fabo051 LIKE fabo_t.fabo051, #交易價格差異
       fabo052 LIKE fabo_t.fabo052, #應付帳款單號
       fabo053 LIKE fabo_t.fabo053, #已計提減值準備
       fabo054 LIKE fabo_t.fabo054, #經營方式
       fabo055 LIKE fabo_t.fabo055, #通路
       fabo056 LIKE fabo_t.fabo056, #品牌
       fabo060 LIKE fabo_t.fabo060, #自由核算項一
       fabo061 LIKE fabo_t.fabo061, #自由核算項二
       fabo062 LIKE fabo_t.fabo062, #自由核算項三
       fabo063 LIKE fabo_t.fabo063, #自由核算項四
       fabo064 LIKE fabo_t.fabo064, #自由核算項五
       fabo065 LIKE fabo_t.fabo065, #自由核算項六
       fabo066 LIKE fabo_t.fabo066, #自由核算項七
       fabo067 LIKE fabo_t.fabo067, #自由核算項八
       fabo068 LIKE fabo_t.fabo068, #自由核算項九
       fabo069 LIKE fabo_t.fabo069, #自由核算項十
       fabo101 LIKE fabo_t.fabo101, #本位幣二幣別
       fabo102 LIKE fabo_t.fabo102, #本位幣二匯率
       fabo103 LIKE fabo_t.fabo103, #本位幣二未稅金額
       fabo104 LIKE fabo_t.fabo104, #本位幣二稅額
       fabo105 LIKE fabo_t.fabo105, #本位幣二應收金額
       fabo106 LIKE fabo_t.fabo106, #本位幣二處份損益
       fabo107 LIKE fabo_t.fabo107, #本位幣二處置成本
       fabo108 LIKE fabo_t.fabo108, #本位幣二處置累折
       fabo109 LIKE fabo_t.fabo109, #本位幣二處置減值準備
       fabo110 LIKE fabo_t.fabo110, #本位幣二本期處置折舊
       fabo111 LIKE fabo_t.fabo111, #本位幣二處置後未折減額
       fabo150 LIKE fabo_t.fabo150, #本位幣三幣別
       fabo151 LIKE fabo_t.fabo151, #本位幣三匯率
       fabo152 LIKE fabo_t.fabo152, #本位幣三未稅金額
       fabo153 LIKE fabo_t.fabo153, #本位幣三稅額
       fabo154 LIKE fabo_t.fabo154, #本位幣三應收金額
       fabo155 LIKE fabo_t.fabo155, #本位幣三處份損益
       fabo156 LIKE fabo_t.fabo156, #本位幣三處置成本
       fabo157 LIKE fabo_t.fabo157, #本位幣三處置累折
       fabo158 LIKE fabo_t.fabo158, #本位幣三處置減值準備
       fabo159 LIKE fabo_t.fabo159, #本位幣三本期處置折舊
       fabo160 LIKE fabo_t.fabo160, #本位幣三處置後未折減額
       faboud001 LIKE fabo_t.faboud001, #自定義欄位(文字)001
       faboud002 LIKE fabo_t.faboud002, #自定義欄位(文字)002
       faboud003 LIKE fabo_t.faboud003, #自定義欄位(文字)003
       faboud004 LIKE fabo_t.faboud004, #自定義欄位(文字)004
       faboud005 LIKE fabo_t.faboud005, #自定義欄位(文字)005
       faboud006 LIKE fabo_t.faboud006, #自定義欄位(文字)006
       faboud007 LIKE fabo_t.faboud007, #自定義欄位(文字)007
       faboud008 LIKE fabo_t.faboud008, #自定義欄位(文字)008
       faboud009 LIKE fabo_t.faboud009, #自定義欄位(文字)009
       faboud010 LIKE fabo_t.faboud010, #自定義欄位(文字)010
       faboud011 LIKE fabo_t.faboud011, #自定義欄位(數字)011
       faboud012 LIKE fabo_t.faboud012, #自定義欄位(數字)012
       faboud013 LIKE fabo_t.faboud013, #自定義欄位(數字)013
       faboud014 LIKE fabo_t.faboud014, #自定義欄位(數字)014
       faboud015 LIKE fabo_t.faboud015, #自定義欄位(數字)015
       faboud016 LIKE fabo_t.faboud016, #自定義欄位(數字)016
       faboud017 LIKE fabo_t.faboud017, #自定義欄位(數字)017
       faboud018 LIKE fabo_t.faboud018, #自定義欄位(數字)018
       faboud019 LIKE fabo_t.faboud019, #自定義欄位(數字)019
       faboud020 LIKE fabo_t.faboud020, #自定義欄位(數字)020
       faboud021 LIKE fabo_t.faboud021, #自定義欄位(日期時間)021
       faboud022 LIKE fabo_t.faboud022, #自定義欄位(日期時間)022
       faboud023 LIKE fabo_t.faboud023, #自定義欄位(日期時間)023
       faboud024 LIKE fabo_t.faboud024, #自定義欄位(日期時間)024
       faboud025 LIKE fabo_t.faboud025, #自定義欄位(日期時間)025
       faboud026 LIKE fabo_t.faboud026, #自定義欄位(日期時間)026
       faboud027 LIKE fabo_t.faboud027, #自定義欄位(日期時間)027
       faboud028 LIKE fabo_t.faboud028, #自定義欄位(日期時間)028
       faboud029 LIKE fabo_t.faboud029, #自定義欄位(日期時間)029
       faboud030 LIKE fabo_t.faboud030, #自定義欄位(日期時間)030
       fabo112 LIKE fabo_t.fabo112, #本位幣二處置預留殘值
       fabo161 LIKE fabo_t.fabo161  #本位幣三處置預留殘值
       END RECORD
   #161215-00044#1---modify----end-----------------
   DEFINE  l_fabgdocno     LIKE fabg_t.fabgdocno
   #end add-point     
   
   #add-point:Function前置處理  name="delete.pre_function"
   
   #end add-point
   
   IF g_fabg_m.fabgld IS NULL
   OR g_fabg_m.fabgdocno IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code = "std-00003" 
      LET g_errparam.popup = FALSE 
      CALL cl_err()
      RETURN
   END IF
   
   
   
   CALL s_transaction_begin()
 
   OPEN afat505_cl USING g_enterprise,g_fabg_m.fabgld,g_fabg_m.fabgdocno
   IF SQLCA.SQLCODE THEN   #(ver:78)
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "OPEN afat505_cl:",SQLERRMESSAGE 
      LET g_errparam.code = SQLCA.SQLCODE   #(ver:78)
      LET g_errparam.popup = TRUE 
      CLOSE afat505_cl
      CALL s_transaction_end('N','0')
      CALL cl_err()
      RETURN
   END IF
 
   #顯示最新的資料
   EXECUTE afat505_master_referesh USING g_fabg_m.fabgld,g_fabg_m.fabgdocno INTO g_fabg_m.fabgsite,g_fabg_m.fabg001, 
       g_fabg_m.fabgld,g_fabg_m.fabg002,g_fabg_m.fabg003,g_fabg_m.fabg004,g_fabg_m.fabg005,g_fabg_m.fabgdocno, 
       g_fabg_m.fabgdocdt,g_fabg_m.fabg010,g_fabg_m.fabg017,g_fabg_m.fabg018,g_fabg_m.fabgstus,g_fabg_m.fabgownid, 
       g_fabg_m.fabgowndp,g_fabg_m.fabgcrtid,g_fabg_m.fabgcrtdp,g_fabg_m.fabgcrtdt,g_fabg_m.fabgmodid, 
       g_fabg_m.fabgmoddt,g_fabg_m.fabgcnfid,g_fabg_m.fabgcnfdt,g_fabg_m.fabgpstid,g_fabg_m.fabgpstdt, 
       g_fabg_m.fabgsite_desc,g_fabg_m.fabg001_desc,g_fabg_m.fabgld_desc,g_fabg_m.fabg002_desc,g_fabg_m.fabg003_desc, 
       g_fabg_m.fabgownid_desc,g_fabg_m.fabgowndp_desc,g_fabg_m.fabgcrtid_desc,g_fabg_m.fabgcrtdp_desc, 
       g_fabg_m.fabgmodid_desc,g_fabg_m.fabgcnfid_desc,g_fabg_m.fabgpstid_desc
   
   
   #檢查是否允許此動作
   IF NOT afat505_action_chk() THEN
      CALL s_transaction_end('N','0')
      RETURN
   END IF
   
   #遮罩相關處理
   LET g_fabg_m_mask_o.* =  g_fabg_m.*
   CALL afat505_fabg_t_mask()
   LET g_fabg_m_mask_n.* =  g_fabg_m.*
   
   CALL afat505_show()
   
   #add-point:delete段before ask name="delete.before_ask"
   #151231-00005#4--add--str--lujh
   IF NOT cl_null(g_fabg_m.fabgdocdt) THEN 
      IF NOT s_afa_date_chk(g_fabg_m.fabgld,'',g_fabg_m.fabgdocdt) THEN 
         CLOSE afat505_cl
         CALL s_transaction_end('N','0')
         RETURN
      END IF 
   END IF 
   #151231-00005#4--add--end--lujh
   #end add-point 
 
   IF cl_ask_del_master() THEN              #確認一下
   
      #add-point:單頭刪除前 name="delete.head.b_delete"
      
      #end add-point   
      
      #應用 a47 樣板自動產生(Version:4)
      #刪除相關文件
      CALL afat505_set_pk_array()
      #add-point:相關文件刪除前 name="delete.befroe.related_document_remove"
  
      #end add-point   
      CALL cl_doc_remove()  
 
 
 
  
  
      #資料備份
      LET g_fabgld_t = g_fabg_m.fabgld
      LET g_fabgdocno_t = g_fabg_m.fabgdocno
 
 
      DELETE FROM fabg_t
       WHERE fabgent = g_enterprise AND fabgld = g_fabg_m.fabgld
         AND fabgdocno = g_fabg_m.fabgdocno
 
       
      #add-point:單頭刪除中 name="delete.head.m_delete"
      
      #end add-point
       
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = g_fabg_m.fabgld,":",SQLERRMESSAGE  
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = FALSE 
         CALL s_transaction_end('N','0')
         CALL cl_err()
         RETURN
      END IF
      
      #add-point:單頭刪除後 name="delete.head.a_delete"
      
      #end add-point
  
      #add-point:單身刪除前 name="delete.body.b_delete"
     #CALL cl_showmsg_init()       #150731-00004#1 20150826 mark
      CALL cl_err_collect_init()   #150731-00004#1 20150826 add
      LET g_success = 'Y'
      #161215-00044#1---modify----begin-----------------
      #LET g_sql = "SELECT * FROM fabo_t ",
      LET g_sql = "SELECT faboent,fabold,fabodocno,faboseq,fabo000,fabo001,fabo002,fabo003,fabo004,fabo005,fabo006,",
                  "fabo007,fabo008,fabo009,fabo010,fabo011,fabo012,fabo013,fabo014,fabo015,fabo016,fabo017,fabo018,",
                  "fabo019,fabo020,fabo021,fabo022,fabo023,fabo024,fabo025,fabo026,fabo027,fabo028,fabo029,fabo030,",
                  "fabo031,fabo032,fabo033,fabo034,fabo035,fabo036,fabo037,fabo038,fabo039,fabo040,fabo041,fabo042,",
                  "fabo043,fabo044,fabo045,fabo046,fabo047,fabo048,fabo049,fabo050,fabo051,fabo052,fabo053,fabo054,",
                  "fabo055,fabo056,fabo060,fabo061,fabo062,fabo063,fabo064,fabo065,fabo066,fabo067,fabo068,fabo069,",
                  "fabo101,fabo102,fabo103,fabo104,fabo105,fabo106,fabo107,fabo108,fabo109,fabo110,fabo111,fabo150,",
                  "fabo151,fabo152,fabo153,fabo154,fabo155,fabo156,fabo157,fabo158,fabo159,fabo160,faboud001,faboud002,",
                  "faboud003,faboud004,faboud005,faboud006,faboud007,faboud008,faboud009,faboud010,faboud011,faboud012,",
                  "faboud013,faboud014,faboud015,faboud016,faboud017,faboud018,faboud019,faboud020,faboud021,faboud022,",
                  "faboud023,faboud024,faboud025,faboud026,faboud027,faboud028,faboud029,faboud030,fabo112,fabo161 FROM fabo_t ",
      #161215-00044#1---modify----end-----------------
                  " WHERE faboent = '",g_enterprise,"'",
                  "   AND fabold = '",g_fabg_m.fabgld,"'",
                  "   AND fabodocno = '",g_fabg_m.fabgdocno,"'"
      PREPARE del_pre FROM g_sql
      DECLARE del_cur CURSOR FOR del_pre

      FOREACH del_cur INTO l_fabo.*
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = SQLCA.sqlcode
            LET g_errparam.extend = "foreach:"
            LET g_errparam.popup = TRUE
            CALL cl_err()
         
            EXIT FOREACH
         END IF
      
         IF (l_fabo.fabo043 <> l_fabo.fabo046 OR
             l_fabo.fabo045 <> l_fabo.fabo048) THEN 
            #刪除资产變更歷程檔
            DELETE FROM fabf_t
             WHERE fabfent = g_enterprise
               AND fabf001 = l_fabo.fabo003
               AND fabf002 = l_fabo.fabo001
               AND fabf003 = l_fabo.fabo002
            IF SQLCA.sqlcode THEN
               #150731-00004#1 20150826 str---
               #CALL cl_errmsg('',l_fabo.fabo001,l_fabo.fabo002,SQLCA.sqlcode,1)
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = SQLCA.SQLCODE
               LET g_errparam.extend = l_fabo.fabo001||l_fabo.fabo002
               LET g_errparam.popup = TRUE
               CALL cl_err()
               #150731-00004#1 20150826 end---
               LET g_success = 'N'
            END IF 
            
            #刪除資產變更檔
            DELETE FROM fabe_t
             WHERE fabeent = g_enterprise
               AND fabe001 = l_fabo.fabo003
               AND fabe003 = l_fabo.fabo001
               AND fabe004 = l_fabo.fabo002
            IF SQLCA.sqlcode THEN
               #150731-00004#1 20150826 str---
               #CALL cl_errmsg('',l_fabo.fabo001,l_fabo.fabo002,SQLCA.sqlcode,1)
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = SQLCA.SQLCODE
               LET g_errparam.extend = l_fabo.fabo001||l_fabo.fabo002
               LET g_errparam.popup = TRUE
               CALL cl_err()
               #150731-00004#1 20150826 end---
               LET g_success = 'N'
            END IF 
         END IF
         
         IF l_fabo.fabo044 <> l_fabo.fabo047 THEN
            #刪除資產調撥單身檔
            DELETE FROM fabu_t
             WHERE fabuent   = g_enterprise
               AND fabuld    = g_fabg_m.fabgld
               AND fabudocno = g_fabg_m.fabgdocno
            IF SQLCA.sqlcode THEN
               #150731-00004#1 20150826 str---
               #CALL cl_errmsg('',l_fabo.fabo001,l_fabo.fabo002,SQLCA.sqlcode,1)
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = SQLCA.SQLCODE
               LET g_errparam.extend = l_fabo.fabo001||l_fabo.fabo002
               LET g_errparam.popup = TRUE
               CALL cl_err()
               #150731-00004#1 20150826 end---
               LET g_success = 'N'
            END IF 
            
            #刪除交易稅明細檔
            DELETE FROM xrcd_t
             WHERE xrcdent   = g_enterprise
               AND xrcdld    = g_fabg_m.fabgld
               AND xrcddocno = g_fabg_m.fabgdocno
            
            IF SQLCA.sqlcode THEN
               #150731-00004#1 20150826 str---
               #CALL cl_errmsg('',l_fabo.fabo001,l_fabo.fabo002,SQLCA.sqlcode,1)
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = SQLCA.SQLCODE
               LET g_errparam.extend = l_fabo.fabo001||l_fabo.fabo002
               LET g_errparam.popup = TRUE
               CALL cl_err()
               #150731-00004#1 20150826 end---
               LET g_success = 'N'
            END IF
            
            #刪除資產出售檔
            SELECT fabgdocno INTO l_fabgdocno
              FROM fabg_t
             WHERE fabgent = g_enterprise
               AND fabgld  = g_fabg_m.fabgld
               AND fabg019 = g_fabg_m.fabgdocno
               
            #刪除資產出售單頭檔
            DELETE FROM fabg_t 
             WHERE fabgent   = g_enterprise
               AND fabgld    = g_fabg_m.fabgld
               AND fabgdocno = l_fabgdocno 
               
            IF SQLCA.sqlcode THEN
               #150731-00004#1 20150826 str---
               #CALL cl_errmsg('',l_fabo.fabo001,l_fabo.fabo002,SQLCA.sqlcode,1)
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = SQLCA.SQLCODE
               LET g_errparam.extend = l_fabo.fabo001||l_fabo.fabo002
               LET g_errparam.popup = TRUE
               CALL cl_err()
               #150731-00004#1 20150826 end---
               LET g_success = 'N'
            END IF
               
            #刪除資產出售單身
            DELETE FROM fabo_t 
             WHERE faboent   = g_enterprise
               AND fabold    = g_fabg_m.fabgld
               AND fabodocno = l_fabgdocno 
               
            IF SQLCA.sqlcode THEN
               #150731-00004#1 20150826 str---
               #CALL cl_errmsg('',l_fabo.fabo001,l_fabo.fabo002,SQLCA.sqlcode,1)
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = SQLCA.SQLCODE
               LET g_errparam.extend = l_fabo.fabo001||l_fabo.fabo002
               LET g_errparam.popup = TRUE
               CALL cl_err()
               #150731-00004#1 20150826 end---
               LET g_success = 'N'
            END IF
            
            #刪除交易稅明細檔
            DELETE FROM xrcd_t
             WHERE xrcdent   = g_enterprise
               AND xrcdld    = g_fabg_m.fabgld
               AND xrcddocno = l_fabgdocno
               
            IF SQLCA.sqlcode THEN
               #150731-00004#1 20150826 str---
               #CALL cl_errmsg('',l_fabo.fabo001,l_fabo.fabo002,SQLCA.sqlcode,1)
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = SQLCA.SQLCODE
               LET g_errparam.extend = l_fabo.fabo001||l_fabo.fabo002
               LET g_errparam.popup = TRUE
               CALL cl_err()
               #150731-00004#1 20150826 end---
               LET g_success = 'N'
            END IF
            
            #刪除產生的新的卡片檔
                     
            #刪除單頭
            DELETE FROM faah_t 
             WHERE faahent = g_enterprise 
               AND faah003 = l_fabo.fabo001 
               AND faah004 = l_fabo.fabo002
               AND faah001 <> l_fabo.fabo003
               
            IF SQLCA.sqlcode THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = SQLCA.sqlcode
               LET g_errparam.extend = "del faah_t"
               LET g_errparam.popup = TRUE
               CALL cl_err()
            
               CALL s_transaction_end('N','0')
               RETURN
            END IF   
            
            #刪除單身                     
            DELETE FROM faai_t 
             WHERE faaient = g_enterprise 
               AND faai002 = l_fabo.fabo001
               AND faai003 = l_fabo.fabo002 
               AND faai001 <> l_fabo.fabo003
            
            IF SQLCA.sqlcode THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = SQLCA.sqlcode
               LET g_errparam.extend = "del faai_t"
               LET g_errparam.popup = TRUE
               CALL cl_err()
            
               CALL s_transaction_end('N','0')
               RETURN
            END IF                      
               
            DELETE FROM faaj_t 
             WHERE faajent = g_enterprise 
               AND faaj001 = l_fabo.fabo001 
               AND faaj002 = l_fabo.fabo002 
               AND faaj037 <> l_fabo.fabo003
               
            IF SQLCA.sqlcode THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = SQLCA.sqlcode
               LET g_errparam.extend = "del faaj_t"
               LET g_errparam.popup = TRUE
               CALL cl_err()
            
               CALL s_transaction_end('N','0')
               RETURN
            END IF
            
         END IF
      END FOREACH 
      
      IF g_success = 'N' THEN 
        #CALL cl_err_showmsg()         #150731-00004#1 20150826 mark
         CALL cl_err_collect_show()    #150731-00004#1 20150826 add
         CALL s_transaction_end('N','0')
      END IF
      #end add-point
      
      DELETE FROM fabo_t
       WHERE faboent = g_enterprise AND fabold = g_fabg_m.fabgld
         AND fabodocno = g_fabg_m.fabgdocno
 
 
      #add-point:單身刪除中 name="delete.body.m_delete"
      DELETE FROM fabi_t
       WHERE fabient = g_enterprise AND fabidocno = g_fabg_m.fabgdocno
         AND fabi000 = g_fabg_m.fabg005
      #end add-point
         
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "fabo_t:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = FALSE 
         CALL s_transaction_end('N','0')
         CALL cl_err()
         RETURN
      END IF    
 
      #add-point:單身刪除後 name="delete.body.a_delete"
      
      #end add-point
      
            
                                                               
 
 
 
      
      #修改歷程記錄(刪除)
      LET g_log1 = util.JSON.stringify(g_fabg_m)   #(ver:78)
      IF NOT cl_log_modified_record(g_log1,'') THEN    #(ver:78)
         CLOSE afat505_cl
         CALL s_transaction_end('N','0')
         RETURN
      END IF
             
      CLEAR FORM
      CALL g_fabo_d.clear() 
 
     
      CALL afat505_ui_browser_refresh()  
      #CALL afat505_ui_headershow()  
      #CALL afat505_ui_detailshow()
 
      #add-point:多語言刪除 name="delete.lang.before_delete"
      
      #end add-point
      
      #單頭多語言刪除
      
      
      #單身多語言刪除
      
 
   
      #add-point:多語言刪除 name="delete.lang.delete"
      
      #end add-point
      
      IF g_browser_cnt > 0 THEN 
         #CALL afat505_browser_fill("")
         CALL afat505_fetch('P')
         DISPLAY g_browser_cnt TO FORMONLY.h_count   #總筆數的顯示
         DISPLAY g_browser_cnt TO FORMONLY.b_count   #總筆數的顯示
      ELSE
         CLEAR FORM
      END IF
      
      CALL s_transaction_end('Y','0')
   ELSE
      CALL s_transaction_end('N','0')
   END IF
 
   CLOSE afat505_cl
 
   #功能已完成,通報訊息中心
   CALL afat505_msgcentre_notify('delete')
    
END FUNCTION
 
{</section>}
 
{<section id="afat505.b_fill" >}
#+ 單身陣列填充
PRIVATE FUNCTION afat505_b_fill()
   #add-point:b_fill段define(客製用) name="b_fill.define_customerization"
   
   #end add-point     
   DEFINE p_wc2      STRING
   DEFINE li_idx     LIKE type_t.num10
   #add-point:b_fill段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="b_fill.define"
   
   #end add-point     
   
   #add-point:Function前置處理  name="b_fill.pre_function"
   
   #end add-point
   
   #清空第一階單身
   CALL g_fabo_d.clear()
 
 
   #add-point:b_fill段sql_before name="b_fill.sql_before"
   
   #end add-point
   
   #判斷是否填充
   IF afat505_fill_chk(1) THEN
      #切換上下筆時不重組SQL
      IF (g_action_choice = "query" OR cl_null(g_action_choice))
      #add-point:b_fill段long_sql_if name="b_fill.long_sql_if"
      
      #end add-point
      THEN
         LET g_sql = "SELECT  DISTINCT faboseq,fabo001,fabo002,fabo003,fabo005,fabo007,fabo043,fabo044, 
             fabo045,fabo046,fabo047,fabo048,fabo023,fabo000 ,t1.oocql004 FROM fabo_t",   
                     " INNER JOIN fabg_t ON fabgent = " ||g_enterprise|| " AND fabgld = fabold ",
                     " AND fabgdocno = fabodocno ",
 
                     #"",
                     
                     "",
                     #下層單身所需的join條件
 
                                    " LEFT JOIN oocql_t t1 ON t1.oocqlent="||g_enterprise||" AND t1.oocql001='3904' AND t1.oocql002=fabo023 AND t1.oocql003='"||g_dlang||"' ",
 
                     " WHERE faboent=? AND fabold=? AND fabodocno=?"
         LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
         #add-point:b_fill段sql_before name="b_fill.body.fill_sql"
         
         #end add-point
         IF NOT cl_null(g_wc2_table1) THEN
            LET g_sql = g_sql CLIPPED, " AND ", g_wc2_table1 CLIPPED
         END IF
         
         #子單身的WC
         
         
         LET g_sql = g_sql, " ORDER BY fabo_t.faboseq"
         
         #add-point:單身填充控制 name="b_fill.sql"
         
         #end add-point
         
         LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
         PREPARE afat505_pb FROM g_sql
         DECLARE b_fill_cs CURSOR FOR afat505_pb
      END IF
      
      LET g_cnt = l_ac
      LET l_ac = 1
      
   #  OPEN b_fill_cs USING g_enterprise,g_fabg_m.fabgld,g_fabg_m.fabgdocno   #(ver:78)
                                               
      FOREACH b_fill_cs USING g_enterprise,g_fabg_m.fabgld,g_fabg_m.fabgdocno INTO g_fabo_d[l_ac].faboseq, 
          g_fabo_d[l_ac].fabo001,g_fabo_d[l_ac].fabo002,g_fabo_d[l_ac].fabo003,g_fabo_d[l_ac].fabo005, 
          g_fabo_d[l_ac].fabo007,g_fabo_d[l_ac].fabo043,g_fabo_d[l_ac].fabo044,g_fabo_d[l_ac].fabo045, 
          g_fabo_d[l_ac].fabo046,g_fabo_d[l_ac].fabo047,g_fabo_d[l_ac].fabo048,g_fabo_d[l_ac].fabo023, 
          g_fabo_d[l_ac].fabo000,g_fabo_d[l_ac].fabo023_desc   #(ver:78)
         IF SQLCA.SQLCODE THEN
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "FOREACH:",SQLERRMESSAGE 
            LET g_errparam.code = SQLCA.SQLCODE 
            LET g_errparam.popup = TRUE 
            CALL cl_err()
            EXIT FOREACH
         END IF
        
         #add-point:b_fill段資料填充 name="b_fill.fill"
         
         #end add-point
      
         IF l_ac > g_max_rec THEN
            IF g_error_show = 1 THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = l_ac
               LET g_errparam.code = 9035 
               LET g_errparam.popup = TRUE 
               CALL cl_err()
            END IF
            EXIT FOREACH
         END IF
         
         LET l_ac = l_ac + 1
      END FOREACH
      LET g_error_show = 0
   
   END IF
    
 
   
   #add-point:browser_fill段其他table處理 name="browser_fill.other_fill"
   
   #end add-point
   
   CALL g_fabo_d.deleteElement(g_fabo_d.getLength())
 
   
 
   LET l_ac = g_cnt
   LET g_cnt = 0  
   
   FREE afat505_pb
 
   
   LET li_idx = l_ac
   
   #遮罩相關處理
   FOR l_ac = 1 TO g_fabo_d.getLength()
      LET g_fabo_d_mask_o[l_ac].* =  g_fabo_d[l_ac].*
      CALL afat505_fabo_t_mask()
      LET g_fabo_d_mask_n[l_ac].* =  g_fabo_d[l_ac].*
   END FOR
   
 
   
   LET l_ac = li_idx
   
   CALL cl_ap_performance_next_end()
 
END FUNCTION
 
{</section>}
 
{<section id="afat505.delete_b" >}
#+ 刪除單身後其他table連動
PRIVATE FUNCTION afat505_delete_b(ps_table,ps_keys_bak,ps_page)
   #add-point:delete_b段define(客製用) name="delete_b.define_customerization"
   
   #end add-point     
   DEFINE ps_table    STRING
   DEFINE ps_page     STRING
   DEFINE ps_keys_bak DYNAMIC ARRAY OF VARCHAR(500)
   DEFINE ls_group    STRING
   DEFINE li_idx      LIKE type_t.num10
   #add-point:delete_b段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="delete_b.define"
   DEFINE l_n         LIKE type_t.num5
   #end add-point     
   
   #add-point:Function前置處理  name="delete_b.pre_function"
   
   #end add-point
   
   LET g_update = TRUE  
   
   #判斷是否是同一群組的table
   LET ls_group = "'1',"
   IF ls_group.getIndexOf(ps_page,1) > 0 THEN
      #add-point:delete_b段刪除前 name="delete_b.b_delete"
      
      #end add-point    
      DELETE FROM fabo_t
       WHERE faboent = g_enterprise AND
         fabold = ps_keys_bak[1] AND fabodocno = ps_keys_bak[2] AND faboseq = ps_keys_bak[3]
      #add-point:delete_b段刪除中 name="delete_b.m_delete"
      SELECT COUNT(1) INTO l_n FROM fabi_t
       WHERE fabient = g_enterprise
         AND fabidocno = ps_keys_bak[2]
         AND fabiseq = ps_keys_bak[3]
         AND fabi000 = g_fabg_m.fabg005

      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.extend = ""
         LET g_errparam.code   = SQLCA.sqlcode
         LET g_errparam.popup  = FALSE
         CALL cl_err()
      END IF

      IF l_n > 0 THEN
         DELETE FROM fabi_t
          WHERE fabient = g_enterprise
            AND fabidocno = ps_keys_bak[2]
            AND fabiseq = ps_keys_bak[3]
            AND fabi000 = g_fabg_m.fabg005
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.extend = ""
            LET g_errparam.code   = SQLCA.sqlcode
            LET g_errparam.popup  = FALSE
            CALL cl_err()
         END IF
      END IF
      #end add-point    
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = ":",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = FALSE 
         CALL cl_err()
         RETURN FALSE
      END IF
      LET li_idx = g_detail_idx
      IF ps_page <> "'1'" THEN 
         CALL g_fabo_d.deleteElement(li_idx) 
      END IF 
 
   END IF
   
 
   
 
   
   #add-point:delete_b段other name="delete_b.other"
   
   #end add-point  
   
   RETURN TRUE
   
END FUNCTION
 
{</section>}
 
{<section id="afat505.insert_b" >}
#+ 新增單身後其他table連動
PRIVATE FUNCTION afat505_insert_b(ps_table,ps_keys,ps_page)
   #add-point:insert_b段define(客製用) name="insert_b.define_customerization"
   
   #end add-point     
   DEFINE ps_table    STRING
   DEFINE ps_page     STRING
   DEFINE ps_keys     DYNAMIC ARRAY OF VARCHAR(500)
   DEFINE ls_group    STRING
   DEFINE ls_page     STRING
   DEFINE li_idx      LIKE type_t.num10
   #add-point:insert_b段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="insert_b.define"
   
   #end add-point     
   
   #add-point:Function前置處理  name="insert_b.pre_function"
   
   #end add-point
   
   LET g_update = TRUE  
   
   #判斷是否是同一群組的table
   LET ls_group = "'1',"
   IF ls_group.getIndexOf(ps_page,1) > 0 THEN
      #add-point:insert_b段資料新增前 name="insert_b.before_insert"
      
      #end add-point 
      INSERT INTO fabo_t
                  (faboent,
                   fabold,fabodocno,
                   faboseq
                   ,fabo001,fabo002,fabo003,fabo005,fabo007,fabo043,fabo044,fabo045,fabo046,fabo047,fabo048,fabo023,fabo000) 
            VALUES(g_enterprise,
                   ps_keys[1],ps_keys[2],ps_keys[3]
                   ,g_fabo_d[g_detail_idx].fabo001,g_fabo_d[g_detail_idx].fabo002,g_fabo_d[g_detail_idx].fabo003, 
                       g_fabo_d[g_detail_idx].fabo005,g_fabo_d[g_detail_idx].fabo007,g_fabo_d[g_detail_idx].fabo043, 
                       g_fabo_d[g_detail_idx].fabo044,g_fabo_d[g_detail_idx].fabo045,g_fabo_d[g_detail_idx].fabo046, 
                       g_fabo_d[g_detail_idx].fabo047,g_fabo_d[g_detail_idx].fabo048,g_fabo_d[g_detail_idx].fabo023, 
                       g_fabo_d[g_detail_idx].fabo000)
      #add-point:insert_b段資料新增中 name="insert_b.m_insert"
      
      #end add-point 
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "fabo_t:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = FALSE 
         CALL cl_err()
      END IF
      
      LET li_idx = g_detail_idx
      IF ps_page <> "'1'" THEN 
         CALL g_fabo_d.insertElement(li_idx) 
      END IF 
 
      #add-point:insert_b段資料新增後 name="insert_b.after_insert"
      
      #end add-point 
   END IF
   
 
   
 
   
   #add-point:insert_b段other name="insert_b.other"
   
   #end add-point     
   
END FUNCTION
 
{</section>}
 
{<section id="afat505.update_b" >}
#+ 修改單身後其他table連動
PRIVATE FUNCTION afat505_update_b(ps_table,ps_keys,ps_keys_bak,ps_page)
   #add-point:update_b段define(客製用) name="update_b.define_customerization"
   
   #end add-point   
   DEFINE ps_table         STRING
   DEFINE ps_page          STRING
   DEFINE ps_keys          DYNAMIC ARRAY OF VARCHAR(500)
   DEFINE ps_keys_bak      DYNAMIC ARRAY OF VARCHAR(500)
   DEFINE ls_group         STRING
   DEFINE li_idx           LIKE type_t.num10 
   DEFINE lb_chk           BOOLEAN
   DEFINE l_new_key        DYNAMIC ARRAY OF STRING
   DEFINE l_old_key        DYNAMIC ARRAY OF STRING
   DEFINE l_field_key      DYNAMIC ARRAY OF STRING
   #add-point:update_b段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="update_b.define"
   
   #end add-point   
   
   #add-point:Function前置處理  name="update_b.pre_function"
   
   #end add-point
   
   LET g_update = TRUE   
   
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
   IF ls_group.getIndexOf(ps_page,1) > 0 AND ps_table <> "fabo_t" THEN
      #add-point:update_b段修改前 name="update_b.before_update"
      
      #end add-point 
      
      #將遮罩欄位還原
      CALL afat505_fabo_t_mask_restore('restore_mask_o')
               
      UPDATE fabo_t 
         SET (fabold,fabodocno,
              faboseq
              ,fabo001,fabo002,fabo003,fabo005,fabo007,fabo043,fabo044,fabo045,fabo046,fabo047,fabo048,fabo023,fabo000) 
              = 
             (ps_keys[1],ps_keys[2],ps_keys[3]
              ,g_fabo_d[g_detail_idx].fabo001,g_fabo_d[g_detail_idx].fabo002,g_fabo_d[g_detail_idx].fabo003, 
                  g_fabo_d[g_detail_idx].fabo005,g_fabo_d[g_detail_idx].fabo007,g_fabo_d[g_detail_idx].fabo043, 
                  g_fabo_d[g_detail_idx].fabo044,g_fabo_d[g_detail_idx].fabo045,g_fabo_d[g_detail_idx].fabo046, 
                  g_fabo_d[g_detail_idx].fabo047,g_fabo_d[g_detail_idx].fabo048,g_fabo_d[g_detail_idx].fabo023, 
                  g_fabo_d[g_detail_idx].fabo000) 
         WHERE faboent = g_enterprise AND fabold = ps_keys_bak[1] AND fabodocno = ps_keys_bak[2] AND faboseq = ps_keys_bak[3]
      #add-point:update_b段修改中 name="update_b.m_update"
      
      #end add-point   
      CASE
         WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "fabo_t" 
            LET g_errparam.code = "std-00009" 
            LET g_errparam.popup = TRUE 
            CALL s_transaction_end('N','0')
            CALL cl_err()
            
         WHEN SQLCA.SQLCODE #其他錯誤
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "fabo_t:",SQLERRMESSAGE 
            LET g_errparam.code = SQLCA.SQLCODE 
            LET g_errparam.popup = TRUE 
            CALL s_transaction_end('N','0')
            CALL cl_err()
            
         OTHERWISE
 
      END CASE
      
      #將遮罩欄位進行遮蔽
      CALL afat505_fabo_t_mask_restore('restore_mask_n')
               
      #add-point:update_b段修改後 name="update_b.after_update"
      
      #end add-point  
   END IF
   
   #子表處理
   IF ls_group.getIndexOf(ps_page,1) > 0 THEN
      
   END IF
   
   
 
   
 
   
   #add-point:update_b段other name="update_b.other"
   
   #end add-point  
   
END FUNCTION
 
{</section>}
 
{<section id="afat505.key_update_b" >}
#+ 上層單身key欄位變動後, 連帶修正下層單身key欄位
PRIVATE FUNCTION afat505_key_update_b(ps_keys_bak,ps_table)
   #add-point:update_b段define(客製用) name="key_update_b.define_customerization"
   
   #end add-point
   DEFINE ps_keys_bak       DYNAMIC ARRAY OF VARCHAR(500)
   DEFINE ps_table          STRING
   DEFINE l_field_key       DYNAMIC ARRAY OF STRING
   DEFINE l_var_keys_bak    DYNAMIC ARRAY OF STRING
   DEFINE l_new_key         DYNAMIC ARRAY OF STRING
   DEFINE l_old_key         DYNAMIC ARRAY OF STRING
   #add-point:update_b段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="key_update_b.define"
   
   #end add-point
   
   #add-point:Function前置處理  name="key_update_b.pre_function"
   
   #end add-point
   
 
   
END FUNCTION
 
{</section>}
 
{<section id="afat505.key_delete_b" >}
#+ 上層單身刪除後, 連帶刪除下層單身key欄位
PRIVATE FUNCTION afat505_key_delete_b(ps_keys_bak,ps_table)
   #add-point:delete_b段define(客製用) name="key_delete_b.define_customerization"
   
   #end add-point
   DEFINE ps_keys_bak       DYNAMIC ARRAY OF VARCHAR(500)
   DEFINE ps_table          STRING
   DEFINE l_field_keys      DYNAMIC ARRAY OF STRING
   DEFINE l_var_keys_bak    DYNAMIC ARRAY OF STRING
   DEFINE l_new_key         DYNAMIC ARRAY OF STRING
   DEFINE l_old_key         DYNAMIC ARRAY OF STRING
   #add-point:delete_b段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="key_delete_b.define"
   
   #end add-point
   
   #add-point:Function前置處理  name="key_delete_b.pre_function"
   
   #end add-point
   
 
   
   RETURN TRUE
   
END FUNCTION
 
{</section>}
 
{<section id="afat505.lock_b" >}
#+ 連動lock其他單身table資料
PRIVATE FUNCTION afat505_lock_b(ps_table,ps_page)
   #add-point:lock_b段define(客製用) name="lock_b.define_customerization"
   
   #end add-point   
   DEFINE ps_page     STRING
   DEFINE ps_table    STRING
   DEFINE ls_group    STRING
   #add-point:lock_b段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="lock_b.define"
   
   #end add-point   
   
   #add-point:Function前置處理  name="lock_b.pre_function"
   
   #end add-point
    
   #先刷新資料
   #CALL afat505_b_fill()
   
   #鎖定整組table
   #LET ls_group = "'1',"
   #僅鎖定自身table
   LET ls_group = "fabo_t"
   
   IF ls_group.getIndexOf(ps_table,1) THEN
      OPEN afat505_bcl USING g_enterprise,
                                       g_fabg_m.fabgld,g_fabg_m.fabgdocno,g_fabo_d[g_detail_idx].faboseq  
                                               
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "afat505_bcl:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = TRUE 
         CALL cl_err()
         RETURN FALSE
      END IF
   END IF
                                    
 
   
 
   
   #add-point:lock_b段other name="lock_b.other"
   
   #end add-point  
   
   RETURN TRUE
 
END FUNCTION
 
{</section>}
 
{<section id="afat505.unlock_b" >}
#+ 連動unlock其他單身table資料
PRIVATE FUNCTION afat505_unlock_b(ps_table,ps_page)
   #add-point:unlock_b段define(客製用) name="unlock_b.define_customerization"
   
   #end add-point  
   DEFINE ps_page     STRING
   DEFINE ps_table    STRING
   DEFINE ls_group    STRING
   #add-point:unlock_b段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="unlock_b.define"
   
   #end add-point  
   
   #add-point:Function前置處理  name="unlock_b.pre_function"
   
   #end add-point
    
   LET ls_group = "'1',"
   
   IF ls_group.getIndexOf(ps_page,1) THEN
      CLOSE afat505_bcl
   END IF
   
 
   
 
 
   #add-point:unlock_b段other name="unlock_b.other"
   
   #end add-point  
 
END FUNCTION
 
{</section>}
 
{<section id="afat505.set_entry" >}
#+ 單頭欄位開啟設定
PRIVATE FUNCTION afat505_set_entry(p_cmd)
   #add-point:set_entry段define(客製用) name="set_entry.define_customerization"
   
   #end add-point       
   DEFINE p_cmd   LIKE type_t.chr1  
   #add-point:set_entry段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_entry.define"
   
   #end add-point       
   
   #add-point:Function前置處理  name="set_entry.pre_function"
   
   #end add-point
   
   CALL cl_set_comp_entry("fabgdocno,fabgld",TRUE)
   
   IF p_cmd = 'a' THEN
      CALL cl_set_comp_entry("fabgld,fabgdocno",TRUE)
      CALL cl_set_comp_entry("fabgdocdt",TRUE)
      #根據azzi850使用者身分開關特定欄位
      IF NOT cl_null(g_no_entry) THEN
         CALL cl_set_comp_entry(g_no_entry,TRUE)
      END IF
      #add-point:set_entry段欄位控制 name="set_entry.field_control"

      CALL cl_set_comp_entry("fabgdocdt",TRUE)  #151130-00015#2 
      #end add-point  
   END IF
   
   #add-point:set_entry段欄位控制後 name="set_entry.after_control"
   
   #end add-point 
 
END FUNCTION
 
{</section>}
 
{<section id="afat505.set_no_entry" >}
#+ 單頭欄位關閉設定
PRIVATE FUNCTION afat505_set_no_entry(p_cmd)
   #add-point:set_no_entry段define(客製用) name="set_no_entry.define_customerization"
   
   #end add-point     
   DEFINE p_cmd   LIKE type_t.chr1   
   #add-point:set_no_entry段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_no_entry.define"
   
   #end add-point     
   
   #add-point:Function前置處理  name="set_no_entry.pre_function"
   DEFINE l_dfin0033  LIKE type_t.chr1  #151130-00015#2
   DEFINE l_success   LIKE type_t.chr1  #151130-00015#2
   DEFINE l_slip      LIKE type_t.chr80 #151130-00015#2 
   DEFINE l_fabgcomp  LIKE type_t.chr80 #151130-00015#2 
   #end add-point
   
   IF p_cmd = 'u' AND g_chkey = 'N' THEN
      CALL cl_set_comp_entry("fabgld,fabgdocno",FALSE)
      #根據azzi850使用者身分開關特定欄位
      IF NOT cl_null(g_no_entry) THEN
         CALL cl_set_comp_entry(g_no_entry,FALSE)
      END IF
      #add-point:set_no_entry段欄位控制 name="set_no_entry.field_control"
      
      #end add-point 
   END IF 
   
   IF p_cmd = 'u' THEN  #docno,ld欄位確認是絕對關閉
      CALL cl_set_comp_entry("fabgdocno,fabgld",FALSE)
   END IF 
 
#  IF p_cmd = 'u' THEN  #docdt欄位依照設定關閉(FALSE則為設定不同意修正) #(ver:78)
      IF NOT cl_chk_update_docdt() THEN
         CALL cl_set_comp_entry("fabgdocdt",FALSE)
      END IF
#  END IF 
   
   #add-point:set_no_entry段欄位控制後 name="set_no_entry.after_control"

   #151130-00015#2  -add -str
   IF NOT cl_null(g_fabg_m.fabgdocno) THEN  
      #获取单别
      CALL s_aooi200_fin_get_slip(g_fabg_m.fabgdocno) RETURNING l_success,l_slip
      #判断是否可以修改单据日期
      SELECT ooef017 INTO l_fabgcomp
        FROM ooef_t
       WHERE ooefent = g_enterprise
         AND ooef001 = g_fabg_m.fabgsite
         AND ooefstus = 'Y'
      CALL s_fin_get_doc_para(g_fabg_m.fabgld,l_fabgcomp,l_slip,'D-FIN-0033') RETURNING l_dfin0033
      IF l_dfin0033 = "Y"  THEN 
         CALL cl_set_comp_entry("fabgdocdt",TRUE)   
      END IF          
   END IF 
   #151130-00015#2  -end -str
   #end add-point 
 
END FUNCTION
 
{</section>}
 
{<section id="afat505.set_entry_b" >}
#+ 單身欄位開啟設定
PRIVATE FUNCTION afat505_set_entry_b(p_cmd)
   #add-point:set_entry_b段define(客製用) name="set_entry_b.define_customerization"
   
   #end add-point     
   DEFINE p_cmd   LIKE type_t.chr1   
   #add-point:set_entry_b段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_entry_b.define"
   
   #end add-point     
   
   #add-point:Function前置處理  name="set_entry_b.pre_function"
   
   #end add-point
    
   IF p_cmd = 'a' THEN
      CALL cl_set_comp_entry("",TRUE)
      #add-point:set_entry段欄位控制 name="set_entry_b.field_control"
      
      #end add-point  
   END IF
   
   #add-point:set_entry_b段 name="set_entry_b.set_entry_b"
   
   #end add-point  
END FUNCTION
 
{</section>}
 
{<section id="afat505.set_no_entry_b" >}
#+ 單身欄位關閉設定
PRIVATE FUNCTION afat505_set_no_entry_b(p_cmd)
   #add-point:set_no_entry_b段define(客製用) name="set_no_entry_b.define_customerization"
   
   #end add-point    
   DEFINE p_cmd   LIKE type_t.chr1   
   #add-point:set_no_entry_b段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_no_entry_b.define"
   
   #end add-point    
   
   #add-point:Function前置處理  name="set_no_entry_b.pre_function"
   
   #end add-point
   
   IF p_cmd = 'u' AND g_chkey = 'N' THEN
      CALL cl_set_comp_entry("",FALSE)
      #add-point:set_no_entry_b段欄位控制 name="set_no_entry_b.field_control"
      
      #end add-point 
   END IF 
   
   #add-point:set_no_entry_b段 name="set_no_entry_b.set_no_entry_b"
   
   #end add-point     
END FUNCTION
 
{</section>}
 
{<section id="afat505.set_act_visible" >}
#+ 單頭權限開啟
PRIVATE FUNCTION afat505_set_act_visible()
   #add-point:set_act_visible段define(客製用) name="set_act_visible.define_customerization"
   
   #end add-point   
   #add-point:set_act_visible段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_visible.define"
   
   #end add-point   
   #add-point:set_act_visible段 name="set_act_visible.set_act_visible"
   CALL cl_set_act_visible("modify,delete,insert,modify_detail", TRUE)
   IF g_fabg_m.fabgstus NOT MATCHES "[NDR]" THEN   # N未確認/D抽單/R已拒絕允許修改
      CALL cl_set_act_visible("modify,delete,modify_detail", FALSE)
   END IF
   #end add-point   
END FUNCTION
 
{</section>}
 
{<section id="afat505.set_act_no_visible" >}
#+ 單頭權限關閉
PRIVATE FUNCTION afat505_set_act_no_visible()
   #add-point:set_act_no_visible段define(客製用) name="set_act_no_visible.define_customerization"
   
   #end add-point   
   #add-point:set_act_no_visible段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_no_visible.define"
   
   #end add-point   
   #add-point:set_act_no_visible段 name="set_act_no_visible.set_act_no_visible"
   #應用 a63 樣板自動產生(Version:1)
   IF g_fabg_m.fabgstus NOT MATCHES "[NDR]" THEN   # N未確認/D抽單/R已拒絕允許修改
      CALL cl_set_act_visible("modify,delete,modify_detail", FALSE)
   END IF


   #end add-point   
END FUNCTION
 
{</section>}
 
{<section id="afat505.set_act_visible_b" >}
#+ 單身權限開啟
PRIVATE FUNCTION afat505_set_act_visible_b()
   #add-point:set_act_visible_b段define(客製用) name="set_act_visible_b.define_customerization"
   
   #end add-point   
   #add-point:set_act_visible_b段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_visible_b.define"
   
   #end add-point   
   #add-point:set_act_visible_b段 name="set_act_visible_b.set_act_visible_b"
   
   #end add-point   
END FUNCTION
 
{</section>}
 
{<section id="afat505.set_act_no_visible_b" >}
#+ 單身權限關閉
PRIVATE FUNCTION afat505_set_act_no_visible_b()
   #add-point:set_act_no_visible_b段define(客製用) name="set_act_no_visible_b.define_customerization"
   
   #end add-point   
   #add-point:set_act_no_visible_b段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_no_visible_b.define"
   
   #end add-point   
   #add-point:set_act_no_visible_b段 name="set_act_no_visible_b.set_act_no_visible_b"
   
   #end add-point   
END FUNCTION
 
{</section>}
 
{<section id="afat505.default_search" >}
#+ 外部參數搜尋
PRIVATE FUNCTION afat505_default_search()
   #add-point:default_search段define(客製用) name="default_search.define_customerization"
   
   #end add-point  
   DEFINE li_idx     LIKE type_t.num10
   DEFINE li_cnt     LIKE type_t.num10
   DEFINE ls_wc      STRING
   DEFINE la_wc      DYNAMIC ARRAY OF RECORD
          tableid    STRING,
          wc         STRING
          END RECORD
   DEFINE ls_where   STRING
   #add-point:default_search段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="default_search.define"
   
   #end add-point  
   
   #add-point:Function前置處理 name="default_search.before"
   
   #end add-point  
   
   LET g_pagestart = 1
   
   IF cl_null(g_order) THEN
      LET g_order = "ASC"
   END IF
   
   IF NOT cl_null(g_argv[01]) THEN
      LET ls_wc = ls_wc, " fabgld = '", g_argv[01], "' AND "
   END IF
   
   IF NOT cl_null(g_argv[02]) THEN
      LET ls_wc = ls_wc, " fabgdocno = '", g_argv[02], "' AND "
   END IF
 
   
   #add-point:default_search段after sql name="default_search.after_sql"
   
   #end add-point  
   
   IF NOT cl_null(ls_wc) THEN
      LET g_wc = ls_wc.subString(1,ls_wc.getLength()-5)
      LET g_default = TRUE
   ELSE
      #若無外部參數則預設為1=2
      LET g_default = FALSE
      
      #預設查詢條件
      CALL cl_qbe_get_default_qryplan() RETURNING ls_where
      IF NOT cl_null(ls_where) THEN
         CALL util.JSON.parse(ls_where, la_wc)
         INITIALIZE g_wc, g_wc2,g_wc2_table1,g_wc2_extend TO NULL
 
         FOR li_idx = 1 TO la_wc.getLength()
            CASE
               WHEN la_wc[li_idx].tableid = "fabg_t" 
                  LET g_wc = la_wc[li_idx].wc
               WHEN la_wc[li_idx].tableid = "fabo_t" 
                  LET g_wc2_table1 = la_wc[li_idx].wc
 
               WHEN la_wc[li_idx].tableid = "EXTENDWC"
                  LET g_wc2_extend = la_wc[li_idx].wc
            END CASE
         END FOR
         IF NOT cl_null(g_wc) OR NOT cl_null(g_wc2_table1) 
 
            OR NOT cl_null(g_wc2_extend)
            THEN
            #組合g_wc2
            IF g_wc2_table1 <> " 1=1" AND NOT cl_null(g_wc2_table1) THEN
               LET g_wc2 = g_wc2_table1
            END IF
 
            IF g_wc2_extend <> " 1=1" AND NOT cl_null(g_wc2_extend) THEN
               LET g_wc2 = g_wc2 ," AND ", g_wc2_extend
            END IF
         
            IF g_wc2.subString(1,5) = " AND " THEN
               LET g_wc2 = g_wc2.subString(6,g_wc2.getLength())
            END IF
         END IF
      END IF
    
      IF cl_null(g_wc) AND cl_null(g_wc2) THEN
         LET g_wc = " 1=2"
      END IF
   END IF
   
   #add-point:default_search段結束前 name="default_search.after"
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
   #end add-point  
 
   IF g_wc.getIndexOf(" 1=2", 1) THEN
      LET g_default = TRUE
   END IF
 
 
END FUNCTION
 
{</section>}
 
{<section id="afat505.state_change" >}
   #應用 a09 樣板自動產生(Version:17)
#+ 確認碼變更 
PRIVATE FUNCTION afat505_statechange()
   #add-point:statechange段define(客製用) name="statechange.define_customerization"
   
   #end add-point  
   DEFINE lc_state LIKE type_t.chr5
   #add-point:statechange段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="statechange.define"
   DEFINE l_n              LIKE type_t.num5
   DEFINE l_cnt            LIKE type_t.num5
   DEFINE l_fabo001        LIKE fabo_t.fabo001
   DEFINE l_fabo002        LIKE fabo_t.fabo002
   DEFINE l_fabo003        LIKE fabo_t.fabo003
   DEFINE l_colname_1      STRING
   DEFINE l_colname_2      STRING
   DEFINE l_colname_3      STRING
   DEFINE l_comment_1      STRING
   DEFINE l_comment_2      STRING
   DEFINE l_comment_3      STRING
   DEFINE l_sql            STRING
   #20150608--add--str--lujh
   DEFINE  l_success       LIKE type_t.num5
   DEFINE  l_gzzd005       LIKE gzzd_t.gzzd005
   DEFINE  l_colname       STRING
   DEFINE  l_comment       STRING
   #20150608--add--end--lujh 
   DEFINE l_today  DATETIME YEAR TO SECOND      #151113-00013#1
   #end add-point  
   
   #add-point:Function前置處理 name="statechange.before"
   
   #end add-point  
   
   ERROR ""     #清空畫面右下側ERROR區塊
 
   IF g_fabg_m.fabgld IS NULL
      OR g_fabg_m.fabgdocno IS NULL
   THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code   = "std-00003" 
      LET g_errparam.popup  = FALSE 
      CALL cl_err()
      RETURN
   END IF
 
   CALL s_transaction_begin()
   
   OPEN afat505_cl USING g_enterprise,g_fabg_m.fabgld,g_fabg_m.fabgdocno
   IF STATUS THEN
      CLOSE afat505_cl
      CALL s_transaction_end('N','0')
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "OPEN afat505_cl:" 
      LET g_errparam.code   = STATUS 
      LET g_errparam.popup  = TRUE 
      CALL cl_err()
      RETURN
   END IF
   
   #顯示最新的資料
   EXECUTE afat505_master_referesh USING g_fabg_m.fabgld,g_fabg_m.fabgdocno INTO g_fabg_m.fabgsite,g_fabg_m.fabg001, 
       g_fabg_m.fabgld,g_fabg_m.fabg002,g_fabg_m.fabg003,g_fabg_m.fabg004,g_fabg_m.fabg005,g_fabg_m.fabgdocno, 
       g_fabg_m.fabgdocdt,g_fabg_m.fabg010,g_fabg_m.fabg017,g_fabg_m.fabg018,g_fabg_m.fabgstus,g_fabg_m.fabgownid, 
       g_fabg_m.fabgowndp,g_fabg_m.fabgcrtid,g_fabg_m.fabgcrtdp,g_fabg_m.fabgcrtdt,g_fabg_m.fabgmodid, 
       g_fabg_m.fabgmoddt,g_fabg_m.fabgcnfid,g_fabg_m.fabgcnfdt,g_fabg_m.fabgpstid,g_fabg_m.fabgpstdt, 
       g_fabg_m.fabgsite_desc,g_fabg_m.fabg001_desc,g_fabg_m.fabgld_desc,g_fabg_m.fabg002_desc,g_fabg_m.fabg003_desc, 
       g_fabg_m.fabgownid_desc,g_fabg_m.fabgowndp_desc,g_fabg_m.fabgcrtid_desc,g_fabg_m.fabgcrtdp_desc, 
       g_fabg_m.fabgmodid_desc,g_fabg_m.fabgcnfid_desc,g_fabg_m.fabgpstid_desc
   
 
   #檢查是否允許此動作
   IF NOT afat505_action_chk() THEN
      CLOSE afat505_cl
      CALL s_transaction_end('N','0')
      RETURN
   END IF
 
   #將資料顯示到畫面上
   DISPLAY BY NAME g_fabg_m.fabgsite,g_fabg_m.fabgsite_desc,g_fabg_m.fabg001,g_fabg_m.fabg001_desc,g_fabg_m.fabgld, 
       g_fabg_m.fabgld_desc,g_fabg_m.fabg002,g_fabg_m.fabg002_desc,g_fabg_m.fabg003,g_fabg_m.fabg003_desc, 
       g_fabg_m.fabg004,g_fabg_m.fabg005,g_fabg_m.fabgdocno,g_fabg_m.fabgdocdt,g_fabg_m.fabg010,g_fabg_m.fabg017, 
       g_fabg_m.fabg018,g_fabg_m.fabgstus,g_fabg_m.fabgownid,g_fabg_m.fabgownid_desc,g_fabg_m.fabgowndp, 
       g_fabg_m.fabgowndp_desc,g_fabg_m.fabgcrtid,g_fabg_m.fabgcrtid_desc,g_fabg_m.fabgcrtdp,g_fabg_m.fabgcrtdp_desc, 
       g_fabg_m.fabgcrtdt,g_fabg_m.fabgmodid,g_fabg_m.fabgmodid_desc,g_fabg_m.fabgmoddt,g_fabg_m.fabgcnfid, 
       g_fabg_m.fabgcnfid_desc,g_fabg_m.fabgcnfdt,g_fabg_m.fabgpstid,g_fabg_m.fabgpstid_desc,g_fabg_m.fabgpstdt 
 
 
   CASE g_fabg_m.fabgstus
      WHEN "A"
         CALL gfrm_curr.setElementImage("statechange", "stus/32/approved.png")
      WHEN "D"
         CALL gfrm_curr.setElementImage("statechange", "stus/32/withdraw.png")
      WHEN "N"
         CALL gfrm_curr.setElementImage("statechange", "stus/32/unconfirmed.png")
      WHEN "R"
         CALL gfrm_curr.setElementImage("statechange", "stus/32/rejection.png")
      WHEN "W"
         CALL gfrm_curr.setElementImage("statechange", "stus/32/signing.png")
      WHEN "Y"
         CALL gfrm_curr.setElementImage("statechange", "stus/32/confirmed.png")
      WHEN "Z"
         CALL gfrm_curr.setElementImage("statechange", "stus/32/unposted.png")
      WHEN "S"
         CALL gfrm_curr.setElementImage("statechange", "stus/32/posted.png")
      WHEN "X"
         CALL gfrm_curr.setElementImage("statechange", "stus/32/invalid.png")
      
   END CASE
 
   #add-point:資料刷新後 name="statechange.after_refresh"
   #151231-00005#4--add--str--lujh
   IF NOT cl_null(g_fabg_m.fabgdocdt) THEN 
      IF NOT s_afa_date_chk(g_fabg_m.fabgld,'',g_fabg_m.fabgdocdt) THEN 
         CLOSE afat505_cl
         CALL s_transaction_end('N','0')
         RETURN
      END IF 
   END IF 
   #151231-00005#4--add--end--lujh
   #end add-point
 
   MENU "" ATTRIBUTES (STYLE="popup")
      BEFORE MENU
         HIDE OPTION "approved"
         HIDE OPTION "rejection"
         CASE g_fabg_m.fabgstus
            
            WHEN "A"
               HIDE OPTION "approved"
            WHEN "D"
               HIDE OPTION "withdraw"
            WHEN "N"
               HIDE OPTION "unconfirmed"
            WHEN "R"
               HIDE OPTION "rejection"
            WHEN "W"
               HIDE OPTION "signing"
            WHEN "Y"
               HIDE OPTION "confirmed"
            WHEN "Z"
               HIDE OPTION "unposted"
            WHEN "S"
               HIDE OPTION "posted"
            WHEN "X"
               HIDE OPTION "invalid"
         END CASE
     
      #add-point:menu前 name="statechange.before_menu"
      HIDE OPTION "posted"
       #approved    已核准(不卡)
      #rejection   已拒絕(不卡)
      #signing     提交
      #withdraw    抽單

      #confirmed   確認
      #unconfirmed 取消確認
      #posted      過帳
      #unposted    取消過帳
      #invalid     作廢
      #unhold      取消留置
      #hold        留置

      CALL cl_set_act_visible("signing,withdraw",FALSE)
      CALL cl_set_act_visible("confirmed,unconfirmed,posted,unposted,invalid,unhold,hold",FALSE)

      CASE g_fabg_m.fabgstus
         WHEN "N"   #未確認
            #需提交至BPM時，則顯示「提交」功能並隱藏「確認」功能
            CALL cl_set_act_visible("invalid,confirmed",TRUE)

            IF cl_bpm_chk() THEN
               CALL cl_set_act_visible("signing",TRUE)
               CALL cl_set_act_visible("confirmed",FALSE)
            END IF

         WHEN "X"   #作廢
            CALL cl_set_act_visible("unconfirmed,invalid,confirmed,hold",FALSE) #141208-00022#1 add
            RETURN

         WHEN "Y"   #已確認
            CALL cl_set_act_visible("unconfirmed,posted,hold",TRUE)  #141208-00022#1 mark  #160616-00005#3 remark
            #CALL cl_set_act_visible("invalid,confirmed,hold",FALSE)   #141208-00022#1 add #160616-00005#3 mark  
             

         WHEN "S"   #已過帳
            CALL cl_set_act_visible("unposted",TRUE)

         WHEN "A"   #已核准
            CALL cl_set_act_visible("confirmed ",TRUE)

         WHEN "R"   #已拒絕
#141208-00022#1 mod--str--         
#            #需提交至BPM時，則顯示「提交」功能並隱藏「確認」功能
#            CALL cl_set_act_visible("invalid,confirmed",TRUE)
#
#            IF cl_bpm_chk() THEN
#               CALL cl_set_act_visible("signing",TRUE)
#               CALL cl_set_act_visible("confirmed",FALSE)
#            END IF
            #保留修改的功能(如作廢)，隱藏其他應用功能(如: 確認、未確認、留置、過帳…)
            CALL cl_set_act_visible("confirmed,unconfirmed",FALSE)
#141208-00022#1 mod--end--            

         WHEN "D"   #抽單
#141208-00022#1 mod--str--           
#            #需提交至BPM時，則顯示「提交」功能並隱藏「確認」功能
#            CALL cl_set_act_visible("invalid,confirmed",TRUE)
#
#            IF cl_bpm_chk() THEN
#               CALL cl_set_act_visible("signing",TRUE)
#               CALL cl_set_act_visible("confirmed",FALSE)
#            END IF

            #保留修改的功能(如作廢)，隱藏其他應用功能(如: 確認、未確認、留置、過帳…)
            CALL cl_set_act_visible("confirmed,unconfirmed,hold",FALSE)
#141208-00022#1 mod--end--  
         WHEN "W"   #送簽中
            CALL cl_set_act_visible("withdraw",TRUE)
            ##只能顯示抽單;其餘應用功能皆隱藏
            CALL cl_set_act_visible("unconfirmed,invalid,confirmed,hold",FALSE) #141208-00022#1 add   

         WHEN "H"  #留置
            CALL cl_set_act_visible("unhold",TRUE)

#         WHEN "UH" #取消留置
#         WHEN "Z"  #扣帳還原

      END CASE
      #end add-point
      
      #應用 a36 樣板自動產生(Version:5)
      #提交
      ON ACTION signing
         IF cl_auth_chk_act("signing") THEN
            IF NOT afat505_send() THEN
               CALL s_transaction_end('N','0')
            ELSE
               CALL s_transaction_end('Y','0')
            END IF
            #因應簽核行為, 該動作完成後不再進行後續處理
            #於此處直接返回
            CLOSE afat505_cl
            RETURN
         END IF
    
      #抽單
      ON ACTION withdraw
         IF cl_auth_chk_act("withdraw") THEN
            IF NOT afat505_draw_out() THEN
               CALL s_transaction_end('N','0')
            ELSE
               CALL s_transaction_end('Y','0')
            END IF
            #因應簽核行為, 該動作完成後不再進行後續處理
            #於此處直接返回
            CLOSE afat505_cl
            RETURN
         END IF
 
 
 
	  
      ON ACTION approved
         IF cl_auth_chk_act("approved") THEN
            LET lc_state = "A"
            #add-point:action控制 name="statechange.approved"
            
            #end add-point
         END IF
         EXIT MENU
      #ON ACTION withdraw
      #   IF cl_auth_chk_act("withdraw") THEN
      #      LET lc_state = "D"
      #      #add-point:action控制 name="statechange.withdraw"
      #      
      #      #end add-point
      #   END IF
      #   EXIT MENU
      ON ACTION unconfirmed
         IF cl_auth_chk_act("unconfirmed") THEN
            LET lc_state = "N"
            #add-point:action控制 name="statechange.unconfirmed"
            #20150608--add--str--lujh
            CALL cl_err_collect_init()
            CALL s_azzi902_get_gzzd('afap100',"lbl_faah001") RETURNING l_colname,l_comment  #卡片编号
            LET g_coll_title[1] = l_colname
            CALL s_azzi902_get_gzzd('afap100',"lbl_faah003") RETURNING l_colname,l_comment  #财产编号
            LET g_coll_title[2] = l_colname
            CALL s_azzi902_get_gzzd('afap100',"lbl_faah004") RETURNING l_colname,l_comment  #符号
            LET g_coll_title[3] = l_colname
            
            CALL s_afa_p_faan_chk(g_fabg_m.fabgld,g_fabg_m.fabgdocno,g_fabg_m.fabgdocdt,'fabo_t','fabo003','fabo001','fabo002') RETURNING l_success
            IF l_success = FALSE THEN 
               CALL cl_err_collect_show()
               RETURN 
            END IF
            CALL cl_err_collect_show()
            #20150608--add--end--lujh
            
            #0921
            LET l_n = 0
            SELECT COUNT(1) INTO l_n FROM fabg_t
             WHERE fabgent = g_enterprise
               AND fabgld  = g_fabg_m.fabgld
               AND fabg019 = g_fabg_m.fabgdocno
            IF l_n > 0 THEN 
               #调拨单取消审核时，出售单状态更新为N
               UPDATE fabg_t SET fabgstus = 'N' 
                WHERE fabgent = g_enterprise 
                  AND fabgld = g_fabg_m.fabgld
                  AND fabg019 = g_fabg_m.fabgdocno
               IF SQLCA.sqlcode THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "" 
                  LET g_errparam.code   = SQLCA.sqlcode 
                  LET g_errparam.popup  = FALSE 
                  CALL cl_err()
            
                  RETURN            
               END IF 
               #151113-00013#1---add---str-
               UPDATE fabg_t 
                   SET (fabgcnfid,fabgcnfdt) 
                     = ('','')     
                 WHERE fabgent = g_enterprise AND fabgld = g_fabg_m.fabgld
                   AND fabgdocno = g_fabg_m.fabgdocno
               #151113-00013#1---add---end-
            END IF               
            
            CALL cl_err_collect_init()  #汇总错误讯息初始化
            CALL s_azzi902_get_gzzd('afat505',"lbl_fabo001") RETURNING l_colname_1,l_comment_1
            CALL s_azzi902_get_gzzd('afat505',"lbl_fabo002") RETURNING l_colname_2,l_comment_2
            CALL s_azzi902_get_gzzd('afat505',"lbl_fabo003") RETURNING l_colname_3,l_comment_3
            LET g_coll_title[1] = l_colname_1
            LET g_coll_title[2] = l_colname_2
            LET g_coll_title[3] = l_colname_3
            LET l_sql = " SELECT UNIQUE faah003,faah004,faah001 FROM faah_t ",
                        "  WHERE faahent = ",g_enterprise," AND faah040 = '",g_fabg_m.fabgdocno,"'"
                        
            PREPARE afat505_unconfirm_prep FROM l_sql
            DECLARE afat505_unconfirm_curs CURSOR FOR afat505_unconfirm_prep
            
            LET l_cnt = 0
            
            FOREACH afat505_unconfirm_curs INTO l_fabo001,l_fabo002,l_fabo003
               LET l_cnt = l_cnt + 1
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = 'afa-00248'
               LET g_errparam.popup = TRUE
               LET g_errparam.columns[1] = "lbl_fabo001"
               LET g_errparam.coll_vals[1] = l_fabo001
               LET g_errparam.columns[2] = "lbl_fabo002"
               LET g_errparam.coll_vals[2] = l_fabo002
               LET g_errparam.columns[3] = "lbl_fabo003"
               LET g_errparam.coll_vals[3] = l_fabo003
               LET g_errparam.sqlerr = 1 #(有需要再設定，0則不顯示)
               CALL cl_err()
            END FOREACH
            CALL cl_err_collect_show()  #显示错误讯息汇总
            IF l_cnt <> 0 THEN
               RETURN
            END IF
            #end add-point
         END IF
         EXIT MENU
      ON ACTION rejection
         IF cl_auth_chk_act("rejection") THEN
            LET lc_state = "R"
            #add-point:action控制 name="statechange.rejection"
            
            #end add-point
         END IF
         EXIT MENU
      #ON ACTION signing
      #   IF cl_auth_chk_act("signing") THEN
      #      LET lc_state = "W"
      #      #add-point:action控制 name="statechange.signing"
      #      
      #      #end add-point
      #   END IF
      #   EXIT MENU
      ON ACTION confirmed
         IF cl_auth_chk_act("confirmed") THEN
            LET lc_state = "Y"
            #add-point:action控制 name="statechange.confirmed"
            IF g_fabg_m.fabgstus = 'X' THEN 
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = 'anm-00044'
               LET g_errparam.extend = g_fabg_m.fabgdocno
               LET g_errparam.popup = TRUE
               CALL cl_err()
            
               RETURN
            END IF 
            
            #20150608--add--str--lujh
            CALL cl_err_collect_init()
            CALL s_azzi902_get_gzzd('afap100',"lbl_faah001") RETURNING l_colname,l_comment  #卡片编号
            LET g_coll_title[1] = l_colname
            CALL s_azzi902_get_gzzd('afap100',"lbl_faah003") RETURNING l_colname,l_comment  #财产编号
            LET g_coll_title[2] = l_colname
            CALL s_azzi902_get_gzzd('afap100',"lbl_faah004") RETURNING l_colname,l_comment  #符号
            LET g_coll_title[3] = l_colname
            
            CALL s_afa_p_faan_chk(g_fabg_m.fabgld,g_fabg_m.fabgdocno,g_fabg_m.fabgdocdt,'fabo_t','fabo003','fabo001','fabo002') RETURNING l_success
            IF l_success = FALSE THEN 
               CALL cl_err_collect_show()
               RETURN 
            END IF
            CALL cl_err_collect_show()
            #20150608--add--end--lujh
            
            #0921
            LET l_n = 0
            SELECT COUNT(1) INTO l_n FROM fabg_t
             WHERE fabgent = g_enterprise
               AND fabgld  = g_fabg_m.fabgld
               AND fabg019 = g_fabg_m.fabgdocno
            IF l_n > 0 THEN 
               #调拨单审核时，出售单状态更新为S
               UPDATE fabg_t SET fabgstus = 'S' 
                WHERE fabgent = g_enterprise 
                  AND fabgld = g_fabg_m.fabgld
                  AND fabg019 = g_fabg_m.fabgdocno
               IF SQLCA.sqlcode THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "" 
                  LET g_errparam.code   = SQLCA.sqlcode 
                  LET g_errparam.popup  = FALSE 
                  CALL cl_err()
            
                  RETURN            
               END IF 
            END IF  
            
            #151113-00013#1---add---str-
            LET l_today = cl_get_current()
            UPDATE fabg_t 
                SET (fabgcnfid,fabgcnfdt) 
                  = (g_user,l_today)     
              WHERE fabgent = g_enterprise AND fabgld = g_fabg_m.fabgld
                AND fabgdocno = g_fabg_m.fabgdocno
             #151113-00013#1---add---end-
             
            UPDATE faah_t SET faahstus = 'Y'
                        WHERE faahent = g_enterprise
                          AND faah040 = g_fabg_m.fabgdocno
                          
            UPDATE faah_t SET faah015 = '1'
                        WHERE faahent = g_enterprise
                          AND faah040 = g_fabg_m.fabgdocno
                          AND faah033 = 'Y'
            #end add-point
         END IF
         EXIT MENU
      ON ACTION unposted
         IF cl_auth_chk_act("unposted") THEN
            LET lc_state = "Z"
            #add-point:action控制 name="statechange.unposted"
            #141124-00009#1 add -str
            LET lc_state = "Y"
            CALL s_azzi902_get_gzzd('afap100',"lbl_faah001") RETURNING l_colname,l_comment  #卡片编号
            LET g_coll_title[1] = l_colname
            CALL s_azzi902_get_gzzd('afap100',"lbl_faah003") RETURNING l_colname,l_comment  #财产编号
            LET g_coll_title[2] = l_colname
            CALL s_azzi902_get_gzzd('afap100',"lbl_faah004") RETURNING l_colname,l_comment  #符号
            LET g_coll_title[3] = l_colname
            
            CALL s_afa_p_faan_chk(g_fabg_m.fabgld,g_fabg_m.fabgdocno,g_fabg_m.fabgdocdt,'fabo_t','fabo003','fabo001','fabo002') RETURNING l_success
            IF l_success = FALSE THEN 
               CALL cl_err_collect_show()
               RETURN 
            END IF
            
            CALL s_afat503_unpost_chk_fabg(g_fabg_m.fabgld,g_fabg_m.fabgdocno) RETURNING l_success
            IF l_success = TRUE THEN
               CALL s_afat503_unpost_upd_fabo(g_fabg_m.fabgld,g_fabg_m.fabgdocno) RETURNING l_success
            END IF 
            #141124-00009#1 add -end
            #end add-point
         END IF
         EXIT MENU
      ON ACTION posted
         IF cl_auth_chk_act("posted") THEN
            LET lc_state = "S"
            #add-point:action控制 name="statechange.posted"
            
            #end add-point
         END IF
         EXIT MENU
      ON ACTION invalid
         IF cl_auth_chk_act("invalid") THEN
            LET lc_state = "X"
            #add-point:action控制 name="statechange.invalid"
            IF g_fabg_m.fabgstus = 'Y' THEN 
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = 'anm-00045'
               LET g_errparam.extend = g_fabg_m.fabgdocno
               LET g_errparam.popup = TRUE
               CALL cl_err()
            
               RETURN
            END IF
            
            #20150608--add--str--lujh
            CALL cl_err_collect_init()
            CALL s_azzi902_get_gzzd('afap100',"lbl_faah001") RETURNING l_colname,l_comment  #卡片编号
            LET g_coll_title[1] = l_colname
            CALL s_azzi902_get_gzzd('afap100',"lbl_faah003") RETURNING l_colname,l_comment  #财产编号
            LET g_coll_title[2] = l_colname
            CALL s_azzi902_get_gzzd('afap100',"lbl_faah004") RETURNING l_colname,l_comment  #符号
            LET g_coll_title[3] = l_colname
            
            CALL s_afa_p_faan_chk(g_fabg_m.fabgld,g_fabg_m.fabgdocno,g_fabg_m.fabgdocdt,'fabo_t','fabo003','fabo001','fabo002') RETURNING l_success
            IF l_success = FALSE THEN 
               CALL cl_err_collect_show()
               RETURN 
            END IF
            CALL cl_err_collect_show()
            #20150608--add--end--lujh
            #151125-00001#1 add start ------------------
            IF NOT cl_ask_confirm('aim-00109') THEN
               RETURN
            END IF
            #151125-00001#1 add end   ------------------
            #0921
            LET l_n = 0
            SELECT COUNT(1) INTO l_n FROM fabg_t
             WHERE fabgent = g_enterprise
               AND fabgld  = g_fabg_m.fabgld
               AND fabg019 = g_fabg_m.fabgdocno
            IF l_n > 0 THEN 
               #调拨单无效时，出售单状态更新为X
               UPDATE fabg_t SET fabgstus = 'X' 
                WHERE fabgent = g_enterprise 
                  AND fabgld = g_fabg_m.fabgld
                  AND fabg019 = g_fabg_m.fabgdocno
               IF SQLCA.sqlcode THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "" 
                  LET g_errparam.code   = SQLCA.sqlcode 
                  LET g_errparam.popup  = FALSE 
                  CALL cl_err()
            
                  RETURN            
               END IF 
            END IF  
            #end add-point
         END IF
         EXIT MENU
 
      #add-point:stus控制 name="statechange.more_control"
      
      #end add-point
      
   END MENU
   
   #確認被選取的狀態碼在清單中
   IF (lc_state <> "A" 
      AND lc_state <> "D"
      AND lc_state <> "N"
      AND lc_state <> "R"
      AND lc_state <> "W"
      AND lc_state <> "Y"
      AND lc_state <> "Z"
      AND lc_state <> "S"
      AND lc_state <> "X"
      ) OR 
      g_fabg_m.fabgstus = lc_state OR cl_null(lc_state) THEN
      CLOSE afat505_cl
      CALL s_transaction_end('N','0')
      RETURN
   END IF
   
   #add-point:stus修改前 name="statechange.b_update"
   
   #end add-point
   
   LET g_fabg_m.fabgmodid = g_user
   LET g_fabg_m.fabgmoddt = cl_get_current()
   LET g_fabg_m.fabgstus = lc_state
   
   #異動狀態碼欄位/修改人/修改日期
   UPDATE fabg_t 
      SET (fabgstus,fabgmodid,fabgmoddt) 
        = (g_fabg_m.fabgstus,g_fabg_m.fabgmodid,g_fabg_m.fabgmoddt)     
    WHERE fabgent = g_enterprise AND fabgld = g_fabg_m.fabgld
      AND fabgdocno = g_fabg_m.fabgdocno
    
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code   = SQLCA.sqlcode 
      LET g_errparam.popup  = FALSE 
      CALL cl_err()
   ELSE
      CASE lc_state
         WHEN "A"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/approved.png")
         WHEN "D"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/withdraw.png")
         WHEN "N"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/unconfirmed.png")
         WHEN "R"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/rejection.png")
         WHEN "W"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/signing.png")
         WHEN "Y"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/confirmed.png")
         WHEN "Z"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/unposted.png")
         WHEN "S"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/posted.png")
         WHEN "X"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/invalid.png")
         
      END CASE
    
      #撈取異動後的資料
      EXECUTE afat505_master_referesh USING g_fabg_m.fabgld,g_fabg_m.fabgdocno INTO g_fabg_m.fabgsite, 
          g_fabg_m.fabg001,g_fabg_m.fabgld,g_fabg_m.fabg002,g_fabg_m.fabg003,g_fabg_m.fabg004,g_fabg_m.fabg005, 
          g_fabg_m.fabgdocno,g_fabg_m.fabgdocdt,g_fabg_m.fabg010,g_fabg_m.fabg017,g_fabg_m.fabg018,g_fabg_m.fabgstus, 
          g_fabg_m.fabgownid,g_fabg_m.fabgowndp,g_fabg_m.fabgcrtid,g_fabg_m.fabgcrtdp,g_fabg_m.fabgcrtdt, 
          g_fabg_m.fabgmodid,g_fabg_m.fabgmoddt,g_fabg_m.fabgcnfid,g_fabg_m.fabgcnfdt,g_fabg_m.fabgpstid, 
          g_fabg_m.fabgpstdt,g_fabg_m.fabgsite_desc,g_fabg_m.fabg001_desc,g_fabg_m.fabgld_desc,g_fabg_m.fabg002_desc, 
          g_fabg_m.fabg003_desc,g_fabg_m.fabgownid_desc,g_fabg_m.fabgowndp_desc,g_fabg_m.fabgcrtid_desc, 
          g_fabg_m.fabgcrtdp_desc,g_fabg_m.fabgmodid_desc,g_fabg_m.fabgcnfid_desc,g_fabg_m.fabgpstid_desc 
 
      
      #將資料顯示到畫面上
      DISPLAY BY NAME g_fabg_m.fabgsite,g_fabg_m.fabgsite_desc,g_fabg_m.fabg001,g_fabg_m.fabg001_desc, 
          g_fabg_m.fabgld,g_fabg_m.fabgld_desc,g_fabg_m.fabg002,g_fabg_m.fabg002_desc,g_fabg_m.fabg003, 
          g_fabg_m.fabg003_desc,g_fabg_m.fabg004,g_fabg_m.fabg005,g_fabg_m.fabgdocno,g_fabg_m.fabgdocdt, 
          g_fabg_m.fabg010,g_fabg_m.fabg017,g_fabg_m.fabg018,g_fabg_m.fabgstus,g_fabg_m.fabgownid,g_fabg_m.fabgownid_desc, 
          g_fabg_m.fabgowndp,g_fabg_m.fabgowndp_desc,g_fabg_m.fabgcrtid,g_fabg_m.fabgcrtid_desc,g_fabg_m.fabgcrtdp, 
          g_fabg_m.fabgcrtdp_desc,g_fabg_m.fabgcrtdt,g_fabg_m.fabgmodid,g_fabg_m.fabgmodid_desc,g_fabg_m.fabgmoddt, 
          g_fabg_m.fabgcnfid,g_fabg_m.fabgcnfid_desc,g_fabg_m.fabgcnfdt,g_fabg_m.fabgpstid,g_fabg_m.fabgpstid_desc, 
          g_fabg_m.fabgpstdt
   END IF
 
   #add-point:stus修改後 name="statechange.a_update"
   
   #end add-point
 
   #add-point:statechange段結束前 name="statechange.after"
   
   #end add-point  
 
   CLOSE afat505_cl
   CALL s_transaction_end('Y','0')
 
   #功能已完成,通報訊息中心
   CALL afat505_msgcentre_notify('statechange:'||lc_state)
   
END FUNCTION
 
 
 
 
{</section>}
 
{<section id="afat505.idx_chk" >}
#+ 顯示正確的單身資料筆數
PRIVATE FUNCTION afat505_idx_chk()
   #add-point:idx_chk段define(客製用) name="idx_chk.define_customerization"
   
   #end add-point  
   #add-point:idx_chk段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="idx_chk.define"
   
   #end add-point  
   
   #add-point:Function前置處理  name="idx_chk.pre_function"
   
   #end add-point
   
   IF g_current_page = 1 THEN
      LET g_detail_idx = g_curr_diag.getCurrentRow("s_detail1")
      IF g_detail_idx > g_fabo_d.getLength() THEN
         LET g_detail_idx = g_fabo_d.getLength()
      END IF
      IF g_detail_idx = 0 AND g_fabo_d.getLength() <> 0 THEN
         LET g_detail_idx = 1
      END IF
      DISPLAY g_detail_idx TO FORMONLY.idx
      DISPLAY g_fabo_d.getLength() TO FORMONLY.cnt
   END IF
   
 
   
   #add-point:idx_chk段other name="idx_chk.other"
   
   #end add-point  
   
END FUNCTION
 
{</section>}
 
{<section id="afat505.b_fill2" >}
#+ 單身陣列填充2
PRIVATE FUNCTION afat505_b_fill2(pi_idx)
   #add-point:b_fill2段define(客製用) name="b_fill2.define_customerization"
   
   #end add-point
   DEFINE pi_idx                 LIKE type_t.num10
   DEFINE li_ac                  LIKE type_t.num10
   DEFINE li_detail_idx_tmp      LIKE type_t.num10
   DEFINE ls_chk                 LIKE type_t.chr1
   #add-point:b_fill2段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="b_fill2.define"
   
   #end add-point
   
   #add-point:Function前置處理  name="b_fill2.pre_function"
   
   #end add-point
   
   LET li_ac = l_ac 
   
   IF g_detail_idx <= 0 THEN
      RETURN
   END IF
   
   LET li_detail_idx_tmp = g_detail_idx
   
 
      
 
      
   #add-point:單身填充後 name="b_fill2.after_fill"
   
   #end add-point
    
   LET l_ac = li_ac
   
   CALL afat505_detail_show()
   
   LET g_detail_idx = li_detail_idx_tmp
   
END FUNCTION
 
{</section>}
 
{<section id="afat505.fill_chk" >}
#+ 單身填充確認
PRIVATE FUNCTION afat505_fill_chk(ps_idx)
   #add-point:fill_chk段define(客製用) name="fill_chk.define_customerization"
   
   #end add-point
   DEFINE ps_idx        LIKE type_t.chr10
   #add-point:fill_chk段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="fill_chk.define"
   
   #end add-point
   
   #add-point:Function前置處理 name="fill_chk.before_chk"
   
   #end add-point
   
   #此funtion功能暫時停用(2015/1/12)
   #無論傳入值為何皆回傳true(代表要填充該單身)
 
   #全部為1=1 or null時回傳true
   IF (cl_null(g_wc2_table1) OR g_wc2_table1.trim() = '1=1') THEN
      #add-point:fill_chk段other_chk name="fill_chk.other_chk"
      
      #end add-point
      RETURN TRUE
   END IF
   
   #add-point:fill_chk段after_chk name="fill_chk.after_chk"
   
   #end add-point
   
   RETURN TRUE
 
END FUNCTION
 
{</section>}
 
{<section id="afat505.status_show" >}
PRIVATE FUNCTION afat505_status_show()
   #add-point:status_show段define(客製用) name="status_show.define_customerization"
   
   #end add-point
   #add-point:status_show段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="status_show.define"
   
   #end add-point
   
   #add-point:status_show段status_show name="status_show.status_show"
   
   #end add-point
END FUNCTION
 
{</section>}
 
{<section id="afat505.mask_functions" >}
&include "erp/afa/afat505_mask.4gl"
 
{</section>}
 
{<section id="afat505.signature" >}
   #應用 a39 樣板自動產生(Version:10)
#+ BPM提交
PRIVATE FUNCTION afat505_send()
   #add-point:send段define(客製用) name="send.define_customerization"
   
   #end add-point 
   #add-point:send段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="send.define"
   
   #end add-point 
   
   #add-point:Function前置處理  name="send.pre_function"
   
   #end add-point
   
   #依據單據個數，需要指定所有單身條件為" 1=1"  (單身有幾個就要設幾個)
   LET g_wc2_table1 = " 1=1"
 
 
   CALL afat505_show()
   CALL afat505_set_pk_array()
   
   #add-point: 初始化的ADP name="send.before_send"
   IF g_fabg_m.fabgstus = 'X' THEN 
      RETURN
   END IF 
   #end add-point
   
   #公用變數初始化
   CALL cl_bpm_data_init()
                  
   #依照主檔/單身個數產生 CALL cl_bpm_set_master_data() / cl_bpm_set_detail_data() 
   #單頭固定為 CALL cl_bpm_set_master_data(util.JSONObject.fromFGL(xxxx)) 傳入參數: (1)單頭陣列  ; 回傳值: 無
   CALL cl_bpm_set_master_data(util.JSONObject.fromFGL(g_fabg_m))
                              
   #單身固定為 CALL cl_bpm_set_detail_data(s_detailX, util.JSONArray.fromFGL(xxxx)) 傳入參數: (1)單身SR名稱  (2)單身陣列  ; 回傳值: 無
   CALL cl_bpm_set_detail_data("s_detail1", util.JSONArray.fromFGL(g_fabo_d))
 
 
   # cl_bpm_cli() 裡有包含以前的aws_condition()=>送簽資料檢核和更新單據狀況碼為'W'
   # cl_bpm_cli() 傳入參數:無  ;  回傳值: 0 開單失敗; 1 開單成功
 
   #add-point: 提交前的ADP name="send.before_cli"
   
   #end add-point
 
   #開單失敗
   IF NOT cl_bpm_cli() THEN 
      RETURN FALSE
   END IF
 
   #add-point: 提交後的ADP name="send.after_send"
   
   #end add-point
 
   #此段落不需要刪除資料,但是否需要refresh圖片樣式???
   #CALL afat505_ui_browser_refresh()
 
   #重新指定此筆單據資料狀態圖片=>送簽中
   LET g_browser[g_current_idx].b_statepic = "stus/16/signing.png"
 
   #重新取得單頭/單身資料,DISPLAY在畫面上
   CALL afat505_ui_headershow()
   CALL afat505_ui_detailshow()
 
   RETURN TRUE
   
END FUNCTION
 
 
 
#應用 a40 樣板自動產生(Version:9)
#+ BPM抽單
PRIVATE FUNCTION afat505_draw_out()
   #add-point:draw段define name="draw.define_customerization"
   
   #end add-point
   #add-point:draw段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="draw.define"
   
   #end add-point
   
   #add-point:Function前置處理  name="draw.pre_function"
   
   #end add-point
   
   #抽單失敗
   IF NOT cl_bpm_draw_out() THEN 
      RETURN FALSE
   END IF    
          
   #重新指定此筆單據資料狀態圖片=>抽單
   LET g_browser[g_current_idx].b_statepic = "stus/16/draw_out.png"
 
   #重新取得單頭/單身資料,DISPLAY在畫面上
   CALL afat505_ui_headershow()  
   CALL afat505_ui_detailshow()
 
   #add-point:Function後置處理  name="draw.after_function"
   
   #end add-point
 
   RETURN TRUE
   
END FUNCTION
 
 
 
 
 
{</section>}
 
{<section id="afat505.set_pk_array" >}
   #應用 a51 樣板自動產生(Version:8)
#+ 給予pk_array內容
PRIVATE FUNCTION afat505_set_pk_array()
   #add-point:set_pk_array段define name="set_pk_array.define_customerization"
   
   #end add-point
   #add-point:set_pk_array段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_pk_array.define"
   
   #end add-point
   
   #add-point:Function前置處理 name="set_pk_array.before"
   
   #end add-point  
   
   #若l_ac<=0代表沒有資料
   IF l_ac <= 0 THEN
      RETURN
   END IF
   
   CALL g_pk_array.clear()
   LET g_pk_array[1].values = g_fabg_m.fabgld
   LET g_pk_array[1].column = 'fabgld'
   LET g_pk_array[2].values = g_fabg_m.fabgdocno
   LET g_pk_array[2].column = 'fabgdocno'
   
   #add-point:set_pk_array段之後 name="set_pk_array.after"
   
   #end add-point  
   
END FUNCTION
 
 
 
 
{</section>}
 
{<section id="afat505.other_dialog" readonly="Y" >}
   
 
{</section>}
 
{<section id="afat505.msgcentre_notify" >}
#應用 a66 樣板自動產生(Version:6)
PRIVATE FUNCTION afat505_msgcentre_notify(lc_state)
   #add-point:msgcentre_notify段define name="msgcentre_notify.define_customerization"
   
   #end add-point   
   DEFINE lc_state LIKE type_t.chr80
   #add-point:msgcentre_notify段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="msgcentre_notify.define"
   
   #end add-point
   
   #add-point:Function前置處理  name="msgcentre_notify.pre_function"
   
   #end add-point
   
   INITIALIZE g_msgparam TO NULL
 
   #action-id與狀態填寫
   LET g_msgparam.state = lc_state
 
   #PK資料填寫
   CALL afat505_set_pk_array()
   #單頭資料填寫
   LET g_msgparam.data[1] = util.JSON.stringify(g_fabg_m)
 
   #add-point:msgcentre其他通知 name="msgcentre_notify.process"
   
   #end add-point
 
   #呼叫訊息中心傳遞本關完成訊息
   CALL cl_msgcentre_notify()
 
END FUNCTION
 
 
 
 
{</section>}
 
{<section id="afat505.action_chk" >}
#+ 修改/刪除前行為檢查(是否可允許此動作), 若有其他行為須管控也可透過此段落
PRIVATE FUNCTION afat505_action_chk()
   #add-point:action_chk段define(客製用) name="action_chk.define_customerization"
   
   #end add-point
   #add-point:action_chk段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="action_chk.define"
   
   #end add-point
   
   #add-point:action_chk段action_chk name="action_chk.action_chk"
   #160818-00017#10  2016/08/25 By 07900 --add--s--
   SELECT fabgstus  INTO g_fabg_m.fabgstus
     FROM fabg_t
    WHERE fabgent = g_enterprise
      AND fabgdocno = g_fabg_m.fabgdocno
      AND fabgld  = g_fabg_m.fabgld

   IF (g_action_choice="modify" OR g_action_choice="delete" OR g_action_choice="modify_detail")  THEN
      LET g_errno = NULL
      CASE g_fabg_m.fabgstus
        WHEN 'Z'
           LET g_errno = 'sub-01351'
        WHEN 'W'
           LET g_errno = 'sub-00180'
        WHEN 'X'
           LET g_errno = 'sub-00229'
        WHEN 'Y'
           LET g_errno = 'sub-00178'
        WHEN 'S'
           LET g_errno = 'sub-00230'
     END CASE

     IF NOT cl_null(g_errno) THEN
        INITIALIZE g_errparam TO NULL
        LET g_errparam.code = g_errno
        LET g_errparam.extend = g_fabg_m.fabgdocno
        LET g_errparam.popup = TRUE
        CALL cl_err()
        LET g_errno = NULL
        CALL afat505_set_act_visible()
        CALL afat505_set_act_no_visible()
        CALL afat505_show()
        RETURN FALSE
     END IF
   END IF
   #160818-00017#10  2016/08/25 By 07900 --add--e--
   #end add-point
      
   RETURN TRUE
   
END FUNCTION
 
{</section>}
 
{<section id="afat505.other_function" readonly="Y" >}
# 資產中心名稱
PRIVATE FUNCTION afat505_fabgsite_desc()
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_fabg_m.fabgsite
   CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_fabg_m.fabgsite_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_fabg_m.fabgsite_desc
END FUNCTION
# 帳務人員名稱
PRIVATE FUNCTION afat505_fabg001_desc()
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_fabg_m.fabg001
   CALL ap_ref_array2(g_ref_fields,"SELECT ooag011 FROM ooag_t WHERE ooagent='"||g_enterprise||"' AND ooag001=? ","") RETURNING g_rtn_fields
   LET g_fabg_m.fabg001_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_fabg_m.fabg001_desc
END FUNCTION
# 帳套名稱
PRIVATE FUNCTION afat505_fabgld_desc()
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_fabg_m.fabgld
   CALL ap_ref_array2(g_ref_fields,"SELECT glaal002 FROM glaal_t WHERE glaalent='"||g_enterprise||"' AND glaalld=? AND glaal001='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_fabg_m.fabgld_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_fabg_m.fabgld_desc
END FUNCTION
# 申請人員名稱
PRIVATE FUNCTION afat505_fabg002_desc()
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_fabg_m.fabg002
   CALL ap_ref_array2(g_ref_fields,"SELECT ooag011 FROM ooag_t WHERE ooagent='"||g_enterprise||"' AND ooag001=? ","") RETURNING g_rtn_fields
   LET g_fabg_m.fabg002_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_fabg_m.fabg002_desc
END FUNCTION
# 申請部門名稱
PRIVATE FUNCTION afat505_fabg003_desc()
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_fabg_m.fabg003
   CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_fabg_m.fabg003_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_fabg_m.fabg003_desc
END FUNCTION
# 本位幣二三欄位顯示
PRIVATE FUNCTION afat505_glaa_visible()

END FUNCTION
# 自動帶出單位、數量、調出數量等值
PRIVATE FUNCTION afat505_get_faah()
   SELECT faah017,faah018,faah018,faah030,faah028,faah031
     INTO g_fabo_d[l_ac].fabo005,g_fabo_d[l_ac].fabo007,g_faah018,g_fabo_d[l_ac].fabo043,
          g_fabo_d[l_ac].fabo044,g_fabo_d[l_ac].fabo045     
     FROM faah_t
    WHERE faahent = g_enterprise  
      AND faah003 = g_fabo_d[l_ac].fabo001   
      AND faah004 = g_fabo_d[l_ac].fabo002
      AND faah001 = g_fabo_d[l_ac].fabo003 
   
   DISPLAY g_fabo_d[l_ac].fabo005 TO s_detail1[l_ac].fabo005
   DISPLAY g_fabo_d[l_ac].fabo007 TO s_detail1[l_ac].fabo007
   DISPLAY g_fabo_d[l_ac].fabo043 TO s_detail1[l_ac].fabo043
   DISPLAY g_fabo_d[l_ac].fabo044 TO s_detail1[l_ac].fabo044
   DISPLAY g_fabo_d[l_ac].fabo045 TO s_detail1[l_ac].fabo045
   
END FUNCTION
# 當只是管理組織與核算組織不同時，產生資產變更檔(afat420)
PRIVATE FUNCTION afat505_fabe_ins()
   #161215-00044#1---modify----begin-----------------
   #DEFINE l_faah       RECORD LIKE faah_t.*
   #DEFINE l_fabe       RECORD LIKE fabe_t.*
   DEFINE l_faah RECORD  #固定資產基礎資料檔
       faahent LIKE faah_t.faahent, #企業編號
       faah000 LIKE faah_t.faah000, #產生批號
       faah001 LIKE faah_t.faah001, #卡片編號
       faah002 LIKE faah_t.faah002, #型態
       faah003 LIKE faah_t.faah003, #財產編號
       faah004 LIKE faah_t.faah004, #附號
       faah005 LIKE faah_t.faah005, #資產性質
       faah006 LIKE faah_t.faah006, #資產主要類型
       faah007 LIKE faah_t.faah007, #資產次要類型
       faah008 LIKE faah_t.faah008, #資產組
       faah009 LIKE faah_t.faah009, #供應供應商
       faah010 LIKE faah_t.faah010, #製造供應商
       faah011 LIKE faah_t.faah011, #產地
       faah012 LIKE faah_t.faah012, #名稱
       faah013 LIKE faah_t.faah013, #規格型號
       faah014 LIKE faah_t.faah014, #取得日期
       faah015 LIKE faah_t.faah015, #資產狀態
       faah016 LIKE faah_t.faah016, #取得方式
       faah017 LIKE faah_t.faah017, #單位
       faah018 LIKE faah_t.faah018, #數量
       faah019 LIKE faah_t.faah019, #在外數量
       faah020 LIKE faah_t.faah020, #幣別
       faah021 LIKE faah_t.faah021, #原幣單價
       faah022 LIKE faah_t.faah022, #原幣金額
       faah023 LIKE faah_t.faah023, #本幣單價
       faah024 LIKE faah_t.faah024, #本幣金額
       faah025 LIKE faah_t.faah025, #保管人員
       faah026 LIKE faah_t.faah026, #保管部門
       faah027 LIKE faah_t.faah027, #存放位置
       faah028 LIKE faah_t.faah028, #存放組織
       faah029 LIKE faah_t.faah029, #負責人員
       faah030 LIKE faah_t.faah030, #管理組織
       faah031 LIKE faah_t.faah031, #核算組織
       faah032 LIKE faah_t.faah032, #歸屬法人
       faah033 LIKE faah_t.faah033, #直接資本化
       faah034 LIKE faah_t.faah034, #保稅
       faah035 LIKE faah_t.faah035, #保險
       faah036 LIKE faah_t.faah036, #免稅
       faah037 LIKE faah_t.faah037, #抵押
       faah038 LIKE faah_t.faah038, #採購單號
       faah039 LIKE faah_t.faah039, #收貨單號
       faah040 LIKE faah_t.faah040, #帳款單號
       faah041 LIKE faah_t.faah041, #來源營運中心
       faah042 LIKE faah_t.faah042, #資產屬性
       faah043 LIKE faah_t.faah043, #預計總工作量
       faah044 LIKE faah_t.faah044, #已使用工作量
       faah045 LIKE faah_t.faah045, #帳款編號項次
       faahownid LIKE faah_t.faahownid, #資料所有者
       faahowndp LIKE faah_t.faahowndp, #資料所屬部門
       faahcrtid LIKE faah_t.faahcrtid, #資料建立者
       faahcrtdp LIKE faah_t.faahcrtdp, #資料建立部門
       faahcrtdt LIKE faah_t.faahcrtdt, #資料創建日
       faahmodid LIKE faah_t.faahmodid, #資料修改者
       faahmoddt LIKE faah_t.faahmoddt, #最近修改日
       faahstus LIKE faah_t.faahstus, #狀態碼
       faah046 LIKE faah_t.faah046, #備註
       faahud001 LIKE faah_t.faahud001, #自定義欄位(文字)001
       faahud002 LIKE faah_t.faahud002, #自定義欄位(文字)002
       faahud003 LIKE faah_t.faahud003, #自定義欄位(文字)003
       faahud004 LIKE faah_t.faahud004, #自定義欄位(文字)004
       faahud005 LIKE faah_t.faahud005, #自定義欄位(文字)005
       faahud006 LIKE faah_t.faahud006, #自定義欄位(文字)006
       faahud007 LIKE faah_t.faahud007, #自定義欄位(文字)007
       faahud008 LIKE faah_t.faahud008, #自定義欄位(文字)008
       faahud009 LIKE faah_t.faahud009, #自定義欄位(文字)009
       faahud010 LIKE faah_t.faahud010, #自定義欄位(文字)010
       faahud011 LIKE faah_t.faahud011, #自定義欄位(數字)011
       faahud012 LIKE faah_t.faahud012, #自定義欄位(數字)012
       faahud013 LIKE faah_t.faahud013, #自定義欄位(數字)013
       faahud014 LIKE faah_t.faahud014, #自定義欄位(數字)014
       faahud015 LIKE faah_t.faahud015, #自定義欄位(數字)015
       faahud016 LIKE faah_t.faahud016, #自定義欄位(數字)016
       faahud017 LIKE faah_t.faahud017, #自定義欄位(數字)017
       faahud018 LIKE faah_t.faahud018, #自定義欄位(數字)018
       faahud019 LIKE faah_t.faahud019, #自定義欄位(數字)019
       faahud020 LIKE faah_t.faahud020, #自定義欄位(數字)020
       faahud021 LIKE faah_t.faahud021, #自定義欄位(日期時間)021
       faahud022 LIKE faah_t.faahud022, #自定義欄位(日期時間)022
       faahud023 LIKE faah_t.faahud023, #自定義欄位(日期時間)023
       faahud024 LIKE faah_t.faahud024, #自定義欄位(日期時間)024
       faahud025 LIKE faah_t.faahud025, #自定義欄位(日期時間)025
       faahud026 LIKE faah_t.faahud026, #自定義欄位(日期時間)026
       faahud027 LIKE faah_t.faahud027, #自定義欄位(日期時間)027
       faahud028 LIKE faah_t.faahud028, #自定義欄位(日期時間)028
       faahud029 LIKE faah_t.faahud029, #自定義欄位(日期時間)029
       faahud030 LIKE faah_t.faahud030, #自定義欄位(日期時間)030
       faah047 LIKE faah_t.faah047, #保稅機器擷取否
       faah048 LIKE faah_t.faah048, #投資抵減狀態
       faah049 LIKE faah_t.faah049, #投資抵減合併碼
       faah050 LIKE faah_t.faah050, #抵減率
       faah051 LIKE faah_t.faah051, #投資抵減用途
       faah052 LIKE faah_t.faah052, #抵減金額
       faah053 LIKE faah_t.faah053, #已抵減金額
       faah054 LIKE faah_t.faah054, #投資抵減否
       faah055 LIKE faah_t.faah055, #投資抵減年限
       faah056 LIKE faah_t.faah056  #免稅狀態
       END RECORD
   DEFINE l_fabe RECORD  #資產變更資料檔
       fabeent LIKE fabe_t.fabeent, #企業編號
       fabe000 LIKE fabe_t.fabe000, #產生批號
       fabe001 LIKE fabe_t.fabe001, #卡片編號
       fabe002 LIKE fabe_t.fabe002, #型態
       fabe003 LIKE fabe_t.fabe003, #財產編號
       fabe004 LIKE fabe_t.fabe004, #附號
       fabe005 LIKE fabe_t.fabe005, #資產性質
       fabe006 LIKE fabe_t.fabe006, #資產主要類型
       fabe007 LIKE fabe_t.fabe007, #資產次要類型
       fabe008 LIKE fabe_t.fabe008, #資產組
       fabe009 LIKE fabe_t.fabe009, #供應供應商
       fabe010 LIKE fabe_t.fabe010, #製造供應商
       fabe011 LIKE fabe_t.fabe011, #產地
       fabe012 LIKE fabe_t.fabe012, #名稱
       fabe013 LIKE fabe_t.fabe013, #規格型號
       fabe014 LIKE fabe_t.fabe014, #取得日期
       fabe015 LIKE fabe_t.fabe015, #資產狀態
       fabe016 LIKE fabe_t.fabe016, #取得方式
       fabe017 LIKE fabe_t.fabe017, #單位
       fabe018 LIKE fabe_t.fabe018, #數量
       fabe019 LIKE fabe_t.fabe019, #在外數量
       fabe020 LIKE fabe_t.fabe020, #幣別
       fabe021 LIKE fabe_t.fabe021, #原幣單價
       fabe022 LIKE fabe_t.fabe022, #原幣金額
       fabe023 LIKE fabe_t.fabe023, #本幣單價
       fabe024 LIKE fabe_t.fabe024, #本幣金額
       fabe025 LIKE fabe_t.fabe025, #保管人員
       fabe026 LIKE fabe_t.fabe026, #保管部門
       fabe027 LIKE fabe_t.fabe027, #存放位置
       fabe028 LIKE fabe_t.fabe028, #存放組織
       fabe029 LIKE fabe_t.fabe029, #負責人員
       fabe030 LIKE fabe_t.fabe030, #管理組織
       fabe031 LIKE fabe_t.fabe031, #核算組織
       fabe032 LIKE fabe_t.fabe032, #歸屬法人
       fabe033 LIKE fabe_t.fabe033, #直接資本化
       fabe034 LIKE fabe_t.fabe034, #保稅
       fabe035 LIKE fabe_t.fabe035, #保險
       fabe036 LIKE fabe_t.fabe036, #免稅
       fabe037 LIKE fabe_t.fabe037, #抵押
       fabe038 LIKE fabe_t.fabe038, #採購單號
       fabe039 LIKE fabe_t.fabe039, #收貨單號
       fabe040 LIKE fabe_t.fabe040, #帳款單號
       fabe041 LIKE fabe_t.fabe041, #來源營運中心
       fabe042 LIKE fabe_t.fabe042, #資產屬性
       fabe043 LIKE fabe_t.fabe043, #預計總工作量
       fabe044 LIKE fabe_t.fabe044, #已使用工作量
       fabe045 LIKE fabe_t.fabe045, #版次
       fabeownid LIKE fabe_t.fabeownid, #資料所有者
       fabeowndp LIKE fabe_t.fabeowndp, #資料所屬部門
       fabecrtid LIKE fabe_t.fabecrtid, #資料建立者
       fabecrtdp LIKE fabe_t.fabecrtdp, #資料建立部門
       fabecrtdt LIKE fabe_t.fabecrtdt, #資料創建日
       fabemodid LIKE fabe_t.fabemodid, #資料修改者
       fabemoddt LIKE fabe_t.fabemoddt, #最近修改日
       fabestus LIKE fabe_t.fabestus, #狀態碼
       fabe046 LIKE fabe_t.fabe046, #備註
       fabeud001 LIKE fabe_t.fabeud001, #自定義欄位(文字)001
       fabeud002 LIKE fabe_t.fabeud002, #自定義欄位(文字)002
       fabeud003 LIKE fabe_t.fabeud003, #自定義欄位(文字)003
       fabeud004 LIKE fabe_t.fabeud004, #自定義欄位(文字)004
       fabeud005 LIKE fabe_t.fabeud005, #自定義欄位(文字)005
       fabeud006 LIKE fabe_t.fabeud006, #自定義欄位(文字)006
       fabeud007 LIKE fabe_t.fabeud007, #自定義欄位(文字)007
       fabeud008 LIKE fabe_t.fabeud008, #自定義欄位(文字)008
       fabeud009 LIKE fabe_t.fabeud009, #自定義欄位(文字)009
       fabeud010 LIKE fabe_t.fabeud010, #自定義欄位(文字)010
       fabeud011 LIKE fabe_t.fabeud011, #自定義欄位(數字)011
       fabeud012 LIKE fabe_t.fabeud012, #自定義欄位(數字)012
       fabeud013 LIKE fabe_t.fabeud013, #自定義欄位(數字)013
       fabeud014 LIKE fabe_t.fabeud014, #自定義欄位(數字)014
       fabeud015 LIKE fabe_t.fabeud015, #自定義欄位(數字)015
       fabeud016 LIKE fabe_t.fabeud016, #自定義欄位(數字)016
       fabeud017 LIKE fabe_t.fabeud017, #自定義欄位(數字)017
       fabeud018 LIKE fabe_t.fabeud018, #自定義欄位(數字)018
       fabeud019 LIKE fabe_t.fabeud019, #自定義欄位(數字)019
       fabeud020 LIKE fabe_t.fabeud020, #自定義欄位(數字)020
       fabeud021 LIKE fabe_t.fabeud021, #自定義欄位(日期時間)021
       fabeud022 LIKE fabe_t.fabeud022, #自定義欄位(日期時間)022
       fabeud023 LIKE fabe_t.fabeud023, #自定義欄位(日期時間)023
       fabeud024 LIKE fabe_t.fabeud024, #自定義欄位(日期時間)024
       fabeud025 LIKE fabe_t.fabeud025, #自定義欄位(日期時間)025
       fabeud026 LIKE fabe_t.fabeud026, #自定義欄位(日期時間)026
       fabeud027 LIKE fabe_t.fabeud027, #自定義欄位(日期時間)027
       fabeud028 LIKE fabe_t.fabeud028, #自定義欄位(日期時間)028
       fabeud029 LIKE fabe_t.fabeud029, #自定義欄位(日期時間)029
       fabeud030 LIKE fabe_t.fabeud030  #自定義欄位(日期時間)030
       END RECORD
   #161215-00044#1---modify----end-----------------
   DEFINE l_fabecrtdt  DATETIME YEAR TO SECOND
   DEFINE l_success    LIKE type_t.num5
   
   LET g_success = 'Y'
   
   #刪除资产變更歷程檔
   DELETE FROM fabf_t
    WHERE fabfent = g_enterprise
      AND fabf001 = g_fabo_d[l_ac].fabo003
      AND fabf002 = g_fabo_d[l_ac].fabo001
      AND fabf003 = g_fabo_d[l_ac].fabo002
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = "fabf_t"
      LET g_errparam.popup = FALSE
      CALL cl_err()
   
      CALL s_transaction_end('N','0')
      RETURN
   END IF 

  #160613-00011#1 Mark ---(S)---
  ##刪除資產變更檔
  #DELETE FROM fabe_t
  # WHERE fabeent = g_enterprise
  #   AND fabe001 = g_fabo_d[l_ac].fabo003
  #   AND fabe003 = g_fabo_d[l_ac].fabo001
  #   AND fabe004 = g_fabo_d[l_ac].fabo002
  #IF SQLCA.sqlcode THEN
  #   INITIALIZE g_errparam TO NULL
  #   LET g_errparam.code = SQLCA.sqlcode
  #   LET g_errparam.extend = "fabf_t"
  #   LET g_errparam.popup = FALSE
  #   CALL cl_err()
  #
  #   CALL s_transaction_end('N','0')
  #   RETURN
  #END IF 
  #160613-00011#1 Mark ---(E)---

  #161215-00044#1---modify----end-----------------
  #SELECT * INTO l_faah.*
  SELECT faahent,faah000,faah001,faah002,faah003,faah004,faah005,faah006,faah007,faah008,faah009,faah010,faah011,
         faah012,faah013,faah014,faah015,faah016,faah017,faah018,faah019,faah020,faah021,faah022,faah023,faah024,faah025,
         faah026,faah027,faah028,faah029,faah030,faah031,faah032,faah033,faah034,faah035,faah036,faah037,faah038,faah039,
         faah040,faah041,faah042,faah043,faah044,faah045,faahownid,faahowndp,faahcrtid,faahcrtdp,faahcrtdt,faahmodid,
         faahmoddt,faahstus,faah046,faahud001,faahud002,faahud003,faahud004,faahud005,faahud006,faahud007,faahud008,
         faahud009,faahud010,faahud011,faahud012,faahud013,faahud014,faahud015,faahud016,faahud017,faahud018,faahud019,
         faahud020,faahud021,faahud022,faahud023,faahud024,faahud025,faahud026,faahud027,faahud028,faahud029,faahud030,
         faah047,faah048,faah049,faah050,faah051,faah052,faah053,faah054,faah055,faah056 INTO l_faah.*
  #161215-00044#1---modify----end-----------------
     FROM faah_t
    WHERE faahent = g_enterprise  
      AND faah003 = g_fabo_d[l_ac].fabo001   
      AND faah004 = g_fabo_d[l_ac].fabo002
      AND faah001 = g_fabo_d[l_ac].fabo003
   #141124-00009#1 add -str
   #161215-00044#1---modify----begin-----------------
   #SELECT * INTO l_fabe.*
   SELECT fabeent,fabe000,fabe001,fabe002,fabe003,fabe004,fabe005,fabe006,fabe007,fabe008,fabe009,fabe010,fabe011,
          fabe012,fabe013,fabe014,fabe015,fabe016,fabe017,fabe018,fabe019,fabe020,fabe021,fabe022,fabe023,fabe024,
          fabe025,fabe026,fabe027,fabe028,fabe029,fabe030,fabe031,fabe032,fabe033,fabe034,fabe035,fabe036,fabe037,
          fabe038,fabe039,fabe040,fabe041,fabe042,fabe043,fabe044,fabe045,fabeownid,fabeowndp,fabecrtid,fabecrtdp,
          fabecrtdt,fabemodid,fabemoddt,fabestus,fabe046,fabeud001,fabeud002,fabeud003,fabeud004,fabeud005,fabeud006,
          fabeud007,fabeud008,fabeud009,fabeud010,fabeud011,fabeud012,fabeud013,fabeud014,fabeud015,fabeud016,fabeud017,
          fabeud018,fabeud019,fabeud020,fabeud021,fabeud022,fabeud023,fabeud024,fabeud025,fabeud026,fabeud027,fabeud028,
          fabeud029,fabeud030 INTO l_fabe.*
   #161215-00044#1---modify----end-----------------
     FROM fabe_t
    WHERE fabeent = g_enterprise  
      AND fabe003 = g_fabo_d[l_ac].fabo001   
      AND fabe004 = g_fabo_d[l_ac].fabo002
      AND fabe001 = g_fabo_d[l_ac].fabo003
   #141124-00009#1 add -end
#   LET l_fabe.* = l_faah.* #141124-00009#1 mark

  #160613-00011#1 Add  ---(S)---
   IF cl_null(l_fabe.fabe001) THEN
      LET l_fabe.fabeent   = l_faah.faahent
      LET l_fabe.fabe000   = l_faah.faah000
      LET l_fabe.fabe001   = l_faah.faah001
      LET l_fabe.fabe002   = l_faah.faah002
      LET l_fabe.fabe003   = l_faah.faah003
      LET l_fabe.fabe004   = l_faah.faah004
      LET l_fabe.fabe005   = l_faah.faah005
      LET l_fabe.fabe006   = l_faah.faah006
      LET l_fabe.fabe007   = l_faah.faah007
      LET l_fabe.fabe008   = l_faah.faah008
      LET l_fabe.fabe009   = l_faah.faah009
      LET l_fabe.fabe010   = l_faah.faah010
      LET l_fabe.fabe011   = l_faah.faah011
      LET l_fabe.fabe012   = l_faah.faah012
      LET l_fabe.fabe013   = l_faah.faah013
      LET l_fabe.fabe014   = l_faah.faah014
      LET l_fabe.fabe015   = l_faah.faah015
      LET l_fabe.fabe016   = l_faah.faah016
      LET l_fabe.fabe017   = l_faah.faah017
      LET l_fabe.fabe018   = l_faah.faah018
      LET l_fabe.fabe019   = l_faah.faah019
      LET l_fabe.fabe020   = l_faah.faah020
      LET l_fabe.fabe021   = l_faah.faah021
      LET l_fabe.fabe022   = l_faah.faah022
      LET l_fabe.fabe023   = l_faah.faah023
      LET l_fabe.fabe024   = l_faah.faah024
      LET l_fabe.fabe025   = l_faah.faah025
      LET l_fabe.fabe026   = l_faah.faah026
      LET l_fabe.fabe027   = l_faah.faah027
      LET l_fabe.fabe028   = l_faah.faah028
      LET l_fabe.fabe029   = l_faah.faah029
      LET l_fabe.fabe030   = l_faah.faah030
      LET l_fabe.fabe031   = l_faah.faah031
      LET l_fabe.fabe032   = l_faah.faah032
      LET l_fabe.fabe033   = l_faah.faah033
      LET l_fabe.fabe034   = l_faah.faah034
      LET l_fabe.fabe035   = l_faah.faah035
      LET l_fabe.fabe036   = l_faah.faah036
      LET l_fabe.fabe037   = l_faah.faah037
      LET l_fabe.fabe038   = l_faah.faah038
      LET l_fabe.fabe039   = l_faah.faah039
      LET l_fabe.fabe040   = l_faah.faah040
      LET l_fabe.fabe041   = l_faah.faah041
      LET l_fabe.fabe042   = l_faah.faah042
      LET l_fabe.fabe043   = l_faah.faah043
      LET l_fabe.fabe044   = l_faah.faah044
      LET l_fabe.fabe045   = l_faah.faah045
      LET l_fabe.fabeownid = l_faah.faahownid
      LET l_fabe.fabeowndp = l_faah.faahowndp
      LET l_fabe.fabecrtid = l_faah.faahcrtid
      LET l_fabe.fabecrtdp = l_faah.faahcrtdp
      LET l_fabe.fabecrtdt = l_faah.faahcrtdt
      LET l_fabe.fabemodid = l_faah.faahmodid
      LET l_fabe.fabemoddt = l_faah.faahmoddt
      LET l_fabe.fabestus  = l_faah.faahstus
      LET l_fabe.fabe046   = l_faah.faah046
   END IF
  #160613-00011#1 Add  ---(E)---

   #版次
   SELECT MAX(fabe045) + 1 
     INTO l_fabe.fabe045
     FROM fabe_t
    WHERE fabeent = g_enterprise
      AND fabe001 = l_fabe.fabe001
   IF cl_null(l_fabe.fabe045) THEN 
      LET l_fabe.fabe045 = 1
   END IF
   
   LET l_fabe.fabestus = 'N'
   
   #管理組織與核算組織發生變更，給變更后的值
   LET l_fabe.fabe030 = g_fabo_d[l_ac].fabo046
   LET l_fabe.fabe031 = g_fabo_d[l_ac].fabo048
   LET l_fabecrtdt = cl_get_current()

  #160613-00011#1 Add  ---(S)---
   #刪除資產變更檔
   DELETE FROM fabe_t
    WHERE fabeent = g_enterprise
      AND fabe001 = g_fabo_d[l_ac].fabo003
      AND fabe003 = g_fabo_d[l_ac].fabo001
      AND fabe004 = g_fabo_d[l_ac].fabo002
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = "fabe_t"
      LET g_errparam.popup = FALSE
      CALL cl_err()
   
      CALL s_transaction_end('N','0')
      RETURN
   END IF 
  #160613-00011#1 Mark ---(E)---

   INSERT INTO fabe_t (fabeent,fabe001,fabe002,fabe000,fabe003,fabe004,fabe045,fabe006, 
                       fabe007,fabe005,fabe008,fabestus,fabe014,fabe015,fabe016,fabe042,fabe017,fabe018, 
                       fabe019,fabe020,fabe021,fabe022,fabe023,fabe024,fabe025,fabe026,fabe027,fabe028, 
                       fabe029,fabe030,fabe031,fabe032,fabe033,fabe009,fabe010,fabe011,fabe012,fabe013, 
                       fabe034,fabe035,fabe036,fabe037,fabe043,fabe044,fabe041,fabe038,fabe039,fabe040, 
                       fabeownid,fabeowndp,fabecrtid,fabecrtdp,fabecrtdt)
                  VALUES (g_enterprise,l_fabe.fabe001,l_fabe.fabe002,l_fabe.fabe000,l_fabe.fabe003, 
                          l_fabe.fabe004,l_fabe.fabe045,l_fabe.fabe006,l_fabe.fabe007,l_fabe.fabe005, 
                          l_fabe.fabe008,l_fabe.fabestus,l_fabe.fabe014,l_fabe.fabe015,l_fabe.fabe016, 
                          l_fabe.fabe042,l_fabe.fabe017,l_fabe.fabe018,l_fabe.fabe019,l_fabe.fabe020, 
                          l_fabe.fabe021,l_fabe.fabe022,l_fabe.fabe023,l_fabe.fabe024,l_fabe.fabe025, 
                          l_fabe.fabe026,l_fabe.fabe027,l_fabe.fabe028,l_fabe.fabe029,l_fabe.fabe030, 
                          l_fabe.fabe031,l_fabe.fabe032,l_fabe.fabe033,l_fabe.fabe009,l_fabe.fabe010, 
                          l_fabe.fabe011,l_fabe.fabe012,l_fabe.fabe013,l_fabe.fabe034,l_fabe.fabe035, 
                          l_fabe.fabe036,l_fabe.fabe037,l_fabe.fabe043,l_fabe.fabe044,l_fabe.fabe041, 
                          l_fabe.fabe038,l_fabe.fabe039,l_fabe.fabe040,l_fabe.fabeownid,l_fabe.fabeowndp,
                          l_fabe.fabecrtid,l_fabe.fabecrtdp,l_fabecrtdt)
   
   IF SQLCA.SQLcode  THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = "ins fabe_t"
      LET g_errparam.popup = TRUE
      CALL cl_err()
  
      LET g_success = 'N'         
   END IF
   
   #新增資產變更歷程檔
   #管理組織變更
   IF l_faah.faah030 <> l_fabe.fabe030 THEN
      LET g_fabf009 = "SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001='"||l_faah.faah030||"' AND faadl002=?"
      CALL afat505_fabf_ins(l_fabe.fabe001,l_fabe.fabe003,l_fabe.fabe004,l_fabe.fabe045,"faah030",l_faah.faah030,l_fabe.fabe030) 
      RETURNING l_success
      
      IF l_success = FALSE THEN 
         LET g_success = 'N'
      END IF
   ELSE
      CALL afat505_fabf_del(l_fabe.fabe001,l_fabe.fabe003,l_fabe.fabe004,l_fabe.fabe045,"faah030")
      RETURNING l_success
      
      IF l_success = FALSE THEN 
         LET g_success = 'N'
      END IF
   END IF
   
   #核算組織變更
   IF l_faah.faah031 <> l_fabe.fabe031 THEN 
      LET g_fabf009 = "SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001='"||l_faah.faah031||"' AND faadl002=?"
      CALL afat505_fabf_ins(l_fabe.fabe001,l_fabe.fabe003,l_fabe.fabe004,l_fabe.fabe045,"faah031",l_faah.faah031,l_fabe.fabe031) 
      RETURNING l_success
      
      IF l_success = FALSE THEN 
         LET g_success = 'N'
      END IF
   ELSE
      CALL afat505_fabf_del(l_fabe.fabe001,l_fabe.fabe003,l_fabe.fabe004,l_fabe.fabe045,"faah031")
      RETURNING l_success
      
      IF l_success = FALSE THEN 
         LET g_success = 'N'
      END IF
   END IF
   
   IF g_success = 'N' THEN
      CALL s_transaction_end('N',0)
   END IF
END FUNCTION
# 新增資產變更歷程檔
PRIVATE FUNCTION afat505_fabf_ins(p_fabe001,p_fabe003,p_fabe004,p_fabe045,p_fabf005,p_fabf006,p_fabf007)
   DEFINE p_fabe001   LIKE fabe_t.fabe001
   DEFINE p_fabe003   LIKE fabe_t.fabe003
   DEFINE p_fabe004   LIKE fabe_t.fabe004
   DEFINE p_fabe045   LIKE fabe_t.fabe045
   DEFINE p_fabf005   LIKE fabf_t.fabf005   #變更欄位
   DEFINE p_fabf006   LIKE fabf_t.fabf006   #變更前內容
   DEFINE p_fabf007   LIKE fabf_t.fabf007   #變更後內容
   DEFINE l_fabf008   LIKE fabf_t.fabf008   #最後變更時間
   DEFINE l_fabfcrtdt LIKE fabf_t.fabfcrtdt
   DEFINE r_success   LIKE type_t.num5
   
   LET r_success = TRUE
   
   LET l_fabf008 = cl_get_current()
   LET l_fabfcrtdt = cl_get_current()
   
   DELETE FROM fabf_t 
    WHERE fabfent = g_enterprise 
      AND fabf001 = p_fabe001
      AND fabf002 = p_fabe003
      AND fabf003 = p_fabe004
      AND fabf004 = p_fabe045
      AND fabf005 = p_fabf005 
   
   INSERT INTO fabf_t (fabfent,fabf001,fabf002,fabf003,fabf004,fabf005,fabf006,fabf007,fabf008,fabf009,
                       fabfownid,fabfowndp,fabfcrtid,fabfcrtdp,fabfcrtdt)
     VALUES (g_enterprise,p_fabe001,p_fabe003,p_fabe004,p_fabe045,p_fabf005,p_fabf006,p_fabf007,l_fabf008,g_fabf009,
             g_user,g_dept,g_user,g_dept,l_fabfcrtdt)  

   LET g_fabf009 = NULL
   
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = "fabf_t"
      LET g_errparam.popup = TRUE
      CALL cl_err()
  
      LET r_success = FALSE
      RETURN r_success
   END IF
   RETURN r_success
END FUNCTION
# 刪除資產變更檔
PRIVATE FUNCTION afat505_fabf_del(p_fabe001,p_fabe003,p_fabe004,p_fabe045,p_fabf005)
   DEFINE p_fabe001   LIKE fabe_t.fabe001
   DEFINE p_fabe003   LIKE fabe_t.fabe003
   DEFINE p_fabe004   LIKE fabe_t.fabe004
   DEFINE p_fabe045   LIKE fabe_t.fabe045
   DEFINE p_fabf005   LIKE fabf_t.fabf005   #變更欄位
   DEFINE r_success   LIKE type_t.num5

   LET r_success = TRUE
   
   DELETE FROM fabf_t 
    WHERE fabfent = g_enterprise 
      AND fabf001 = p_fabe001
      AND fabf002 = p_fabe003
      AND fabf003 = p_fabe004
      AND fabf004 = p_fabe045
      AND fabf005 = p_fabf005
   
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = "pmde_t"
      LET g_errparam.popup = TRUE
      CALL cl_err()
  
      LET r_success = FALSE
      RETURN r_success
   END IF
   RETURN r_success
END FUNCTION
# 撥出審核
PRIVATE FUNCTION afat505_update_fabg017(p_tpye)
   DEFINE p_tpye       LIKE type_t.chr1
   
   CALL s_transaction_begin()
   LET g_success = 'Y'
   
   #撥出審核
   IF p_tpye = 'Y' THEN 
      UPDATE fabg_t SET fabg017 = 'Y' 
       WHERE fabgent   = g_enterprise
         AND fabgld    = g_fabg_m.fabgld
         AND fabgdocno = g_fabg_m.fabgdocno
   END IF
   
   IF p_tpye = 'N' THEN 
      UPDATE fabg_t SET fabg017 = 'N' 
       WHERE fabgent   = g_enterprise
         AND fabgld    = g_fabg_m.fabgld
         AND fabgdocno = g_fabg_m.fabgdocno
   END IF
   
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = 'upd fabg'
      LET g_errparam.popup = TRUE
      CALL cl_err()

      LET g_success = 'N'       
   END IF
   
   IF g_success = 'Y' THEN
      CALL s_transaction_end('Y','1')
   ELSE
      CALL s_transaction_end('N','1')
   END IF
END FUNCTION
# 撥入審核
PRIVATE FUNCTION afat505_update_fabg018(p_tpye)
   DEFINE p_tpye       LIKE type_t.chr1
   
   CALL s_transaction_begin()
   LET g_success = 'Y'
   
   #撥出審核
   IF p_tpye = 'Y' THEN 
      UPDATE fabg_t SET fabg018 = 'Y' 
       WHERE fabgent   = g_enterprise
         AND fabgld    = g_fabg_m.fabgld
         AND fabgdocno = g_fabg_m.fabgdocno
   END IF
   
   IF p_tpye = 'N' THEN 
      UPDATE fabg_t SET fabg018 = 'N' 
       WHERE fabgent   = g_enterprise
         AND fabgld    = g_fabg_m.fabgld
         AND fabgdocno = g_fabg_m.fabgdocno
   END IF
   
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = 'upd fabg'
      LET g_errparam.popup = TRUE
      CALL cl_err()

      LET g_success = 'N'       
   END IF
   
   IF g_success = 'Y' THEN
      CALL s_transaction_end('Y','1')
   ELSE
      CALL s_transaction_end('N','1')
   END IF
END FUNCTION

################################################################################
# Descriptions...: 財產編號、附號、卡片編號檢查
# Memo...........:
# Usage..........: CALL afat505_faid_chk()
#                  RETURNING r_success
# Input parameter: 
# Return code....: r_success      執行成功否     TRUE/FALSE
# Date & Author..: 2014/09/24 By zhangweib
# Modify.........:
################################################################################
PRIVATE FUNCTION afat505_faid_chk()
   DEFINE l_faah015         LIKE faah_t.faah015
   DEFINE l_n1              LIKE type_t.num5 
   DEFINE r_success         LIKE type_t.num5
   DEFINE l_n               LIKE type_t.num5
    ########################################add by huangtao
   DEFINE l_faah006         LIKE faah_t.faah006 
   DEFINE l_faah032         LIKE faah_t.faah032 
   DEFINE l_ooef017         LIKE ooef_t.ooef017 
   DEFINE l_faal003         LIKE faal_t.faal003 
   #########################################add by huangtao
   
   LET r_success = TRUE

   #無財編、卡片編號則不需要做檢查，無附號則便是類型為'1.主件'所以不需要考慮附號有值否
   IF cl_null(g_fabo_d[l_ac].fabo001) THEN RETURN r_success END IF

   ##########################################mark by huangtao
   ##若財編、附號不為空，卡片編號為空，可自動帶出
   #IF g_fabo_d[l_ac].fabo002 IS NOT NULL AND cl_null(g_fabo_d[l_ac].fabo003) THEN
   #   CALL afat505_faid_def()
   #END IF
   #
   #IF cl_null(g_fabo_d[l_ac].fabo003) THEN RETURN r_success END IF
   IF g_fabo_d[l_ac].fabo002 IS NULL THEN RETURN r_success END IF
   #若卡片不为空。检查财编，附号，卡片是否存在afai100
  IF NOT cl_null(g_fabo_d[l_ac].fabo003) THEN 
   ##########################################mark by huangtao
      LET l_n = 0
      SELECT COUNT(1) INTO l_n
        FROM faaj_t
       WHERE faajent = g_enterprise
         AND faaj037 = g_fabo_d[l_ac].fabo003
         AND faaj001 = g_fabo_d[l_ac].fabo001
         AND faaj002 = g_fabo_d[l_ac].fabo002
      
      IF l_n = 0 THEN 
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = 'afa-00178'
         LET g_errparam.extend = ''
         LET g_errparam.popup = TRUE
         CALL cl_err()
      
         LET g_fabo_d[l_ac].fabo001 = g_fabo_d_t.fabo001
         LET g_fabo_d[l_ac].fabo002 = g_fabo_d_t.fabo002
         LET g_fabo_d[l_ac].fabo003 = g_fabo_d_t.fabo003
         LET r_success = FALSE
         RETURN r_success
      END IF
   ############################add by huangtao
   #卡片为空,根据财编，附号带出预设卡片
   ELSE
      SELECT faah001 INTO g_fabo_d[l_ac].fabo003 FROM faah_t
       WHERE faahent = g_enterprise AND faah003 = g_fabo_d[l_ac].fabo001  AND faah004 = g_fabo_d[l_ac].fabo002 
   
   END IF   
   ############################add by huangtao
   SELECT  faah006,faah015,faah032 INTO l_faah006,l_faah015,l_faah032 FROM faah_t
    WHERE faahent = g_enterprise
      AND faah003 = g_fabo_d[l_ac].fabo001
      AND faah004 = g_fabo_d[l_ac].fabo002 
      AND faah001 = g_fabo_d[l_ac].fabo003
   #財產狀態不可為0：取得、5：出售、6：銷賬、10：被資本化
   IF l_faah015='0' OR l_faah015='5' OR l_faah015='6' OR l_faah015='8' OR l_faah015='10' THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'afa-00135'
      LET g_errparam.extend = ''
      LET g_errparam.popup = TRUE
      CALL cl_err()

      LET g_fabo_d[l_ac].fabo001 = g_fabo_d_t.fabo001
      LET g_fabo_d[l_ac].fabo002 = g_fabo_d_t.fabo002
      LET g_fabo_d[l_ac].fabo003 = g_fabo_d_t.fabo003
      LET r_success = FALSE
      RETURN r_success
   END IF 

   #當前折畢再單，卡片+財產編號+附號不可重複
   LET l_n1 = 0
   SELECT COUNT(1) INTO l_n1 FROM fabo_t
    WHERE faboent = g_enterprise
      AND fabodocno = g_fabg_m.fabgdocno
      AND fabo001 = g_fabo_d[l_ac].fabo001 
      AND fabo002 = g_fabo_d[l_ac].fabo002
      AND fabo003 = g_fabo_d[l_ac].fabo003
      AND faboseq <> g_fabo_d[l_ac].faboseq
   IF l_n1 > 0 THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'afa-00142'
      LET g_errparam.extend = ''
      LET g_errparam.popup = TRUE
      CALL cl_err()

      LET g_fabo_d[l_ac].fabo001 = g_fabo_d_t.fabo001
      LET g_fabo_d[l_ac].fabo002 = g_fabo_d_t.fabo002
      LET g_fabo_d[l_ac].fabo003 = g_fabo_d_t.fabo003
      LET r_success = FALSE
      RETURN r_success
   END IF
   #################################add by huangtao
#mark by yangxf
   IF NOT s_afat502_site_comp_chk(g_fabg_m.fabgsite,l_faah032) THEN 
      LET r_success = FALSE
      RETURN r_success
   END IF 
   
   #161111-00049#12 add s---
   IF NOT s_afat503_fixed_chk(g_fabo_d[l_ac].fabo001,g_fabo_d[l_ac].fabo002,g_fabo_d[l_ac].fabo003,"afat505",g_fabg_m.fabgld,'',g_fabg_m.fabgdocdt) THEN
      LET g_fabo_d[l_ac].fabo001 = g_fabo_d_t.fabo001
      LET g_fabo_d[l_ac].fabo002 = g_fabo_d_t.fabo002
      LET g_fabo_d[l_ac].fabo003 = g_fabo_d_t.fabo003 
      LET r_success = FALSE
      RETURN r_success
   END IF  
   #161111-00049#12 add e---                  
#   #根据财编，附号 检查是否和单头资产中心帐套同一法人
#   SELECT ooef017 INTO l_ooef017 FROM ooef_t
#    WHERE ooefent = g_enterprise AND ooef001 =g_fabg_m.fabgsite
#   
#   IF l_ooef017 <> l_faah032 THEN
#      INITIALIZE g_errparam TO NULL
#      LET g_errparam.code = 'axr-00122'      #过单
#      LET g_errparam.extend = ''
#      LET g_errparam.popup = TRUE
#      CALL cl_err()
#      RETURN FALSE
#   END IF
#mark by yangxf
#检查是否存在afai021 不存在报错，存在的话，检查是否先计提折旧
   SELECT faal003 INTO l_faal003 FROM faal_t 
    WHERE faalent = g_enterprise AND faalld = g_fabg_m.fabgld AND faal001 = l_faah006

   IF STATUS =100 OR cl_null(l_faal003) THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'afa-00183'      #过单
      LET g_errparam.extend = ''
      LET g_errparam.popup = TRUE
      CALL cl_err()
      RETURN FALSE
   ELSE
      IF l_faal003 = 'Y' THEN   
         SELECT COUNT(1) INTO l_n FROM faam_t
           WHERE faament = g_enterprise AND faamld = g_fabg_m.fabgld
             AND faam000 = g_fabo_d[l_ac].fabo003 AND faam001 = g_fabo_d[l_ac].fabo001 AND faam002= g_fabo_d[l_ac].fabo002
             AND faam004 = YEAR(g_today) AND faam005 = MONTH(g_today)
          IF l_n = 0 THEN
             INITIALIZE g_errparam TO NULL
             LET g_errparam.code = 'afa-00280'
             LET g_errparam.extend = ''
             LET g_errparam.popup = TRUE
             CALL cl_err()
             RETURN FALSE
          END IF
      END IF
   END IF
#################################add by huangtao
   RETURN r_success

END FUNCTION
################################################################################
# Descriptions...: 財產編號、附號、卡片編號檢查
# Memo...........:
# Usage..........: CALL afat505_faid_chk()
#                  RETURNING r_success
# Input parameter: 
# Return code....: r_success      執行成功否     TRUE/FALSE
# Date & Author..: 2014/09/24 By zhangweib
# Modify.........:
################################################################################
PRIVATE FUNCTION afat505_faid_def()
   DEFINE l_fabo003         LIKE fabo_t.fabo003
   DEFINE l_sql             STRING
   DEFINE l_faah015         LIKE faah_t.faah015

   LET l_sql = " SELECT faaj037, faaj002, faaj001 FROM faaj_t WHERE faajent = '",g_enterprise,"'",
               "   AND NOT EXISTS (SELECT fabo003 FROM fabo_t WHERE faboent = '",g_enterprise,"'",
               "   AND fabodocno = '",g_fabg_m.fabgdocno,"'                                     ",
               "   AND fabo001 = faaj001                                                        ",
               "   AND fabo002 = faaj002                                                        ",
               "   AND fabo003 = faaj037)                                                       ",
               "   AND faaj001 = '",g_fabo_d[l_ac].fabo001,"'                                   ",
               "   AND faaj002 = '",g_fabo_d[l_ac].fabo002,"'                                   "
   PREPARE afat505_pb5 FROM l_sql
   DECLARE afat505_cs5 CURSOR FOR afat505_pb5 

      FOREACH afat505_cs5 INTO l_fabo003
         SELECT faah015 INTO l_faah015 FROM faah_t
          WHERE faahent = g_enterprise
            AND faah003 = g_fabo_d[l_ac].fabo001
            AND faah004 = g_fabo_d[l_ac].fabo002 
            AND faah001 = l_fabo003
         #財產狀態不可為0：取得、5：出售、6：銷賬、10：被資本化
         IF l_faah015='0' OR l_faah015='5' OR l_faah015='6' OR l_faah015='8' OR l_faah015='10' THEN
            CONTINUE FOREACH
         ELSE
            LET g_fabo_d[l_ac].fabo003 = l_fabo003
            EXIT FOREACH
         END IF 
      END FOREACH

END FUNCTION

################################################################################

################################################################################
PRIVATE FUNCTION afat505_change_to_sql(p_wc)
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
   LET r_wc = "'",l_str,"'"

   RETURN r_wc


END FUNCTION

 
{</section>}
 
