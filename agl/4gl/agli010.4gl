#該程式未解開Section, 採用最新樣板產出!
{<section id="agli010.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0021(2016-10-10 10:57:40), PR版次:0021(2017-02-21 17:06:46)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000508
#+ Filename...: agli010
#+ Description: 帳套資料維護作業
#+ Creator....: 02299(2013-08-26 14:41:28)
#+ Modifier...: 02599 -SD/PR- 07900
 
{</section>}
 
{<section id="agli010.global" >}
#應用 i05 樣板自動產生(Version:37)
#add-point:填寫註解說明
#140314-00001#4  20150511   By Jessy    新增合併報表頁籤
#151027-00014#1  20151027   By 03538    增加glaa137參數
#160122-00019#1  2016/01/27 By 02599    会计科目参照表开窗需要限定为【会科】的参照表号，且需要加ent条件
#160310-00008#1  2016/03/16 By 02599    根据平行辅账启用更新aoos020辅助账套值
#151216-00004#1  2016/03/17 By 02599    当该账套为主账套时币别、币别参照表、汇率参照表需等于法人设定值(aooi100),增加相应的栏位检核
#160318-00005#12 2016/03/25 by 07675    將重複內容的錯誤訊息置換為公用錯誤訊息
#160413-00010#1  2016/04/19 By 02599    显示单别说明
#160318-00025#38 2016/04/21 By 07959    將重複內容的錯誤訊息置換為公用錯誤訊息(r.v)
#151008-00009#8  2016/06/21 By 03538    增加glaa139/glaa140參數
#160811-00039#1  2016/08/11 By 02599    查询开窗及查询后显示资料要限定账套权限
#160812-00004#1  2016/08/12 By 02599    修改tree中节点图标，非主账套节点为灰色圆圈，清空没有值的节点
#160825-00017#1  2016/08/25 By 02599    新增及查询时，不检核权限；维护修改时要依账套权限管制。
#160902-00035#1  2016/09/05 By 02599    复制资料时，现行年度，现行期别，最后过账日期，关账日期，（glaa010,011,012,013)应清空
#160918-00006#1  2016/10/10 By 02599    增加栏位:glaa028(varchar2(1))汇率来源（1:日汇率、2:月汇率），default 1:日汇率，不可空白
#161111-00028#8  2016/11/28 by 02481    标准程式定义采用宣告模式,弃用.*写法
#170210-00013#1  2017/02/21 By 07900    18主机5区【参数】页签的“成本计算类型”开窗出的资料不正确，请帮忙确认，谢谢~

#end add-point
#add-point:填寫註解說明(客製用)

#end add-point
 
IMPORT os
IMPORT util
#add-point:增加匯入項目 name="global.import"
 
#end add-point
  
SCHEMA ds 
 
GLOBALS "../../cfg/top_global.inc"
 
#add-point:增加匯入變數檔 name="global.inc"

#end add-point
 
#單頭 type 宣告
PRIVATE type type_g_glaa_m RECORD
   glaald LIKE glaa_t.glaald, 
   glaal002 LIKE glaal_t.glaal002, 
   glaacomp LIKE glaa_t.glaacomp, 
   glaacomp_desc LIKE type_t.chr80, 
   glaa027 LIKE glaa_t.glaa027, 
   glaa026 LIKE glaa_t.glaa026, 
   glaa026_desc LIKE type_t.chr80, 
   glaa001 LIKE glaa_t.glaa001, 
   glaa001_desc LIKE type_t.chr80, 
   glaa002 LIKE glaa_t.glaa002, 
   glaa002_desc LIKE type_t.chr80, 
   glaa025 LIKE glaa_t.glaa025, 
   glaa028 LIKE glaa_t.glaa028, 
   glaa003 LIKE glaa_t.glaa003, 
   glaa003_desc LIKE type_t.chr80, 
   glaa004 LIKE glaa_t.glaa004, 
   glaa004_desc LIKE type_t.chr80, 
   glaa024 LIKE glaa_t.glaa024, 
   glaa024_desc LIKE type_t.chr80, 
   glaa005 LIKE glaa_t.glaa005, 
   glaa005_desc LIKE type_t.chr80, 
   glaa006 LIKE glaa_t.glaa006, 
   glaa007 LIKE glaa_t.glaa007, 
   glaa014 LIKE glaa_t.glaa014, 
   glaa008 LIKE glaa_t.glaa008, 
   glaa023 LIKE glaa_t.glaa023, 
   glaa009 LIKE glaa_t.glaa009, 
   glaa130 LIKE glaa_t.glaa130, 
   glaa010 LIKE glaa_t.glaa010, 
   glaa011 LIKE glaa_t.glaa011, 
   glaa012 LIKE glaa_t.glaa012, 
   glaa013 LIKE glaa_t.glaa013, 
   glaastus LIKE glaa_t.glaastus, 
   glaa015 LIKE glaa_t.glaa015, 
   fflabel1_desc LIKE type_t.chr80, 
   glaa019 LIKE glaa_t.glaa019, 
   glaa016 LIKE glaa_t.glaa016, 
   glaa020 LIKE glaa_t.glaa020, 
   glaa017 LIKE glaa_t.glaa017, 
   glaa021 LIKE glaa_t.glaa021, 
   glaa018 LIKE glaa_t.glaa018, 
   glaa022 LIKE glaa_t.glaa022, 
   fflabe7_desc LIKE type_t.chr80, 
   fflabel8_desc LIKE type_t.chr80, 
   glaa100 LIKE glaa_t.glaa100, 
   glaa101 LIKE glaa_t.glaa101, 
   glaa102 LIKE glaa_t.glaa102, 
   glaa103 LIKE glaa_t.glaa103, 
   glaa111 LIKE glaa_t.glaa111, 
   glaa111_desc LIKE type_t.chr80, 
   glaa112 LIKE glaa_t.glaa112, 
   glaa112_desc LIKE type_t.chr80, 
   glaa113 LIKE glaa_t.glaa113, 
   glaa113_desc LIKE type_t.chr80, 
   glaa120 LIKE glaa_t.glaa120, 
   glaa120_desc LIKE type_t.chr80, 
   glaa121 LIKE glaa_t.glaa121, 
   glaa136 LIKE glaa_t.glaa136, 
   glaa137 LIKE glaa_t.glaa137, 
   glaa139 LIKE glaa_t.glaa139, 
   glaa140 LIKE glaa_t.glaa140, 
   glaa122 LIKE glaa_t.glaa122, 
   glaa123 LIKE glaa_t.glaa123, 
   glaa124 LIKE glaa_t.glaa124, 
   glaa131 LIKE glaa_t.glaa131, 
   glaa132 LIKE glaa_t.glaa132, 
   glaa133 LIKE glaa_t.glaa133, 
   glaa134 LIKE glaa_t.glaa134, 
   glaa138 LIKE glaa_t.glaa138, 
   glaa135 LIKE glaa_t.glaa135, 
   glaa135_desc LIKE type_t.chr80, 
   glaaownid LIKE glaa_t.glaaownid, 
   glaaownid_desc LIKE type_t.chr80, 
   glaaowndp LIKE glaa_t.glaaowndp, 
   glaaowndp_desc LIKE type_t.chr80, 
   glaacrtid LIKE glaa_t.glaacrtid, 
   glaacrtid_desc LIKE type_t.chr80, 
   glaacrtdp LIKE glaa_t.glaacrtdp, 
   glaacrtdp_desc LIKE type_t.chr80, 
   glaacrtdt LIKE glaa_t.glaacrtdt, 
   glaamodid LIKE glaa_t.glaamodid, 
   glaamodid_desc LIKE type_t.chr80, 
   glaamoddt LIKE glaa_t.glaamoddt
                                  END RECORD
 
#add-point:自定義模組變數(Module Variable)(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="global.variable"
DEFINE g_wc_def              STRING
DEFINE g_glaald_ins          LIKE glaa_t.glaald
#DEFINE g_site_str            STRING  #160811-00039#1 #160825-00017#1 mark
#end add-point
                                  
#模組變數(Module Variables)
DEFINE g_glaa_m          type_g_glaa_m
DEFINE g_glaa_m_t        type_g_glaa_m
DEFINE g_glaa_m_o        type_g_glaa_m
 
   DEFINE g_glaald_t LIKE glaa_t.glaald
 
 
#DEFINE g_glaald_t        LIKE glaa_t.glaald
DEFINE g_glaacomp_t        LIKE glaa_t.glaacomp
 
DEFINE g_browser    DYNAMIC ARRAY OF RECORD    #資料瀏覽之欄位
       b_show          LIKE type_t.chr100,    #外顯欄位
       b_pid           LIKE type_t.chr100,    #父節點id
       b_id            LIKE type_t.chr100,    #本身節點id
       b_exp           LIKE type_t.chr100,    #是否展開
       b_hasC          LIKE type_t.num5,      #是否有子節點
       b_isExp         LIKE type_t.num5,      #是否已展開
       b_expcode       LIKE type_t.num5,      #展開值
       #tree自定義欄位
          b_glaald LIKE glaa_t.glaald,
      b_glaacomp LIKE glaa_t.glaacomp,
   b_glaacomp_desc LIKE type_t.chr80
                   END RECORD
 
DEFINE g_browser_root  DYNAMIC ARRAY OF INTEGER    #root資料所在
       
#多table用變數
DEFINE g_master_multi_table_t    RECORD
      glaalld LIKE glaal_t.glaalld,
      glaal002 LIKE glaal_t.glaal002
      END RECORD
 
DEFINE g_wc                  STRING
DEFINE g_sql                 STRING
DEFINE g_forupd_sql          STRING
DEFINE g_cnt                 LIKE type_t.num10
DEFINE g_current_idx         LIKE type_t.num10
DEFINE g_jump                LIKE type_t.num10
DEFINE g_no_ask              LIKE type_t.num5
DEFINE g_rec_b               LIKE type_t.num10
DEFINE l_ac                  LIKE type_t.num10
DEFINE g_curr_diag           ui.Dialog                #Current Dialog
 
DEFINE g_pagestart           LIKE type_t.num10         
DEFINE gwin_curr             ui.Window                #Current Window
DEFINE gfrm_curr             ui.Form                  #Current Form
DEFINE g_page_action         STRING                   #page action
DEFINE g_header_hidden       LIKE type_t.num5         #隱藏單頭
DEFINE g_worksheet_hidden    LIKE type_t.num5         #隱藏工作Panel
DEFINE g_browser_cnt         LIKE type_t.num10        #total count
DEFINE g_page                STRING                   #第幾頁
DEFINE g_current_row         LIKE type_t.num10        #Browser所在筆數
DEFINE g_current_sw          LIKE type_t.num10        #Browser所在筆數用開關
 
DEFINE g_searchcol           LIKE type_t.chr200
DEFINE g_searchstr           LIKE type_t.chr200
DEFINE g_searchtype          LIKE type_t.chr200
DEFINE g_ref_fields          DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
DEFINE g_rtn_fields          DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
DEFINE g_ref_vars            DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
DEFINE g_row_index           LIKE type_t.num10
DEFINE g_root_search         BOOLEAN
DEFINE g_first               LIKE type_t.num5  #標示是否要啟動s_browse重查
DEFINE g_aw                  STRING            #確定當下點擊的單身
DEFINE g_log1                STRING            #log用
DEFINE g_log2                STRING            #log用
DEFINE g_add_browse          STRING            #新增填充用WC
DEFINE g_add_idx             LIKE type_t.num5  #新增資料指標
 
#add-point:自定義客戶專用模組變數(Module Variable) name="global.variable_customerization"

#end add-point
 
#add-point:傳入參數說明(global.argv) name="global.argv"

#end add-point
 
{</section>}
 
{<section id="agli010.main" >}
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
   CALL cl_ap_init("agl","")
 
   #add-point:作業初始化 name="main.init"
      
   #end add-point
   
   
 
   #LOCK CURSOR (identifier)
   #add-point:SQL_define name="main.define_sql"
      
   #end add-point
   LET g_forupd_sql = " SELECT glaald,'',glaacomp,'',glaa027,glaa026,'',glaa001,'',glaa002,'',glaa025, 
       glaa028,glaa003,'',glaa004,'',glaa024,'',glaa005,'',glaa006,glaa007,glaa014,glaa008,glaa023,glaa009, 
       glaa130,glaa010,glaa011,glaa012,glaa013,glaastus,glaa015,'',glaa019,glaa016,glaa020,glaa017,glaa021, 
       glaa018,glaa022,'','',glaa100,glaa101,glaa102,glaa103,glaa111,'',glaa112,'',glaa113,'',glaa120, 
       '',glaa121,glaa136,glaa137,glaa139,glaa140,glaa122,glaa123,glaa124,glaa131,glaa132,glaa133,glaa134, 
       glaa138,glaa135,'',glaaownid,'',glaaowndp,'',glaacrtid,'',glaacrtdp,'',glaacrtdt,glaamodid,'', 
       glaamoddt", 
                      " FROM glaa_t",
                      " WHERE glaaent= ? AND glaald=? FOR UPDATE"
   #add-point:SQL_define name="main.after_define_sql"
      
   #end add-point
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)                #轉換不同資料庫語法
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE agli010_cl CURSOR FROM g_forupd_sql                 # LOCK CURSOR
 
   LET g_sql = " SELECT DISTINCT t0.glaald,t0.glaacomp,t0.glaa027,t0.glaa026,t0.glaa001,t0.glaa002,t0.glaa025, 
       t0.glaa028,t0.glaa003,t0.glaa004,t0.glaa024,t0.glaa005,t0.glaa006,t0.glaa007,t0.glaa014,t0.glaa008, 
       t0.glaa023,t0.glaa009,t0.glaa130,t0.glaa010,t0.glaa011,t0.glaa012,t0.glaa013,t0.glaastus,t0.glaa015, 
       t0.glaa019,t0.glaa016,t0.glaa020,t0.glaa017,t0.glaa021,t0.glaa018,t0.glaa022,t0.glaa100,t0.glaa101, 
       t0.glaa102,t0.glaa103,t0.glaa111,t0.glaa112,t0.glaa113,t0.glaa120,t0.glaa121,t0.glaa136,t0.glaa137, 
       t0.glaa139,t0.glaa140,t0.glaa122,t0.glaa123,t0.glaa124,t0.glaa131,t0.glaa132,t0.glaa133,t0.glaa134, 
       t0.glaa138,t0.glaa135,t0.glaaownid,t0.glaaowndp,t0.glaacrtid,t0.glaacrtdp,t0.glaacrtdt,t0.glaamodid, 
       t0.glaamoddt,t1.ooefl003 ,t2.ooall004 ,t3.ooail003 ,t4.ooall004 ,t5.ooall004 ,t6.ooall004 ,t7.ooall004 , 
       t8.ooall004 ,t9.oobxl003 ,t10.oobxl003 ,t11.oobxl003 ,t12.xcatl003 ,t13.ooall004 ,t14.ooag011 , 
       t15.ooefl003 ,t16.ooag011 ,t17.ooefl003 ,t18.ooag011",
               " FROM glaa_t t0",
                              " LEFT JOIN ooefl_t t1 ON t1.ooeflent="||g_enterprise||" AND t1.ooefl001=glaacomp AND t1.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooall_t t2 ON t2.ooallent="||g_enterprise||" AND t2.ooall001='10' AND t2.ooall002=glaa026 AND t2.ooall003='"||g_dlang||"' ",
               " LEFT JOIN ooail_t t3 ON t3.ooailent="||g_enterprise||" AND t3.ooail001=glaa001 AND t3.ooail002='"||g_dlang||"' ",
               " LEFT JOIN ooall_t t4 ON t4.ooallent="||g_enterprise||" AND t4.ooall001='1' AND t4.ooall002=glaa002 AND t4.ooall003='"||g_dlang||"' ",
               " LEFT JOIN ooall_t t5 ON t5.ooallent="||g_enterprise||" AND t5.ooall001='13' AND t5.ooall002=glaa003 AND t5.ooall003='"||g_dlang||"' ",
               " LEFT JOIN ooall_t t6 ON t6.ooallent="||g_enterprise||" AND t6.ooall001='0' AND t6.ooall002=glaa004 AND t6.ooall003='"||g_dlang||"' ",
               " LEFT JOIN ooall_t t7 ON t7.ooallent="||g_enterprise||" AND t7.ooall001='3' AND t7.ooall002=glaa024 AND t7.ooall003='"||g_dlang||"' ",
               " LEFT JOIN ooall_t t8 ON t8.ooallent="||g_enterprise||" AND t8.ooall001='8' AND t8.ooall002=glaa005 AND t8.ooall003='"||g_dlang||"' ",
               " LEFT JOIN oobxl_t t9 ON t9.oobxlent="||g_enterprise||" AND t9.oobxl001=glaa111 AND t9.oobxl002='"||g_dlang||"' ",
               " LEFT JOIN oobxl_t t10 ON t10.oobxlent="||g_enterprise||" AND t10.oobxl001=glaa112 AND t10.oobxl002='"||g_dlang||"' ",
               " LEFT JOIN oobxl_t t11 ON t11.oobxlent="||g_enterprise||" AND t11.oobxl001=glaa113 AND t11.oobxl002='"||g_dlang||"' ",
               " LEFT JOIN xcatl_t t12 ON t12.xcatlent="||g_enterprise||" AND t12.xcatl001=glaa120 AND t12.xcatl002='"||g_dlang||"' ",
               " LEFT JOIN ooall_t t13 ON t13.ooallent="||g_enterprise||" AND t13.ooall001='8' AND t13.ooall002=glaa135 AND t13.ooall003='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t14 ON t14.ooagent="||g_enterprise||" AND t14.ooag001=glaaownid  ",
               " LEFT JOIN ooefl_t t15 ON t15.ooeflent="||g_enterprise||" AND t15.ooefl001=glaaowndp AND t15.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t16 ON t16.ooagent="||g_enterprise||" AND t16.ooag001=glaacrtid  ",
               " LEFT JOIN ooefl_t t17 ON t17.ooeflent="||g_enterprise||" AND t17.ooefl001=glaacrtdp AND t17.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t18 ON t18.ooagent="||g_enterprise||" AND t18.ooag001=glaamodid  ",
 
               " WHERE t0.glaaent = " ||g_enterprise|| " AND t0.glaald = ?"
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   #add-point:SQL_define name="main.after_refresh_sql"
   
   #end add-point
   PREPARE agli010_master_referesh FROM g_sql
 
    
 
   
   IF g_bgjob = "Y" THEN
      #add-point:Service Call name="main.servicecall"
            
      #end add-point
   ELSE
      #畫面開啟 (identifier)
      OPEN WINDOW w_agli010 WITH FORM cl_ap_formpath("agl",g_code)
   
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
   
      #程式初始化
      CALL agli010_init()   
 
      #進入選單 Menu (="N")
      CALL agli010_ui_dialog() 
      
      #add-point:畫面關閉前 name="main.before_close"
            
      #end add-point
 
      #畫面關閉
      CLOSE WINDOW w_agli010
      
   END IF 
   
   CLOSE agli010_cl
   
   
 
   #add-point:作業離開前 name="main.exit"
      
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
END MAIN
 
 
 
 
{</section>}
 
{<section id="agli010.init" >}
#+ 瀏覽頁簽資料初始化
PRIVATE FUNCTION agli010_init()
   #add-point:init段define name="init.define_customerization"
   
   #end add-point
   #add-point:init段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="init.define"
      
   #end add-point 
   
   #add-point:Function前置處理  name="init.pre_function"
   
   #end add-point
   
      CALL cl_set_combo_scc_part('glaastus','17','N,Y')
 
      CALL cl_set_combo_scc('glaa025','40') 
   CALL cl_set_combo_scc('glaa028','9995') 
   CALL cl_set_combo_scc('glaa006','8003') 
   CALL cl_set_combo_scc('glaa007','8003') 
   CALL cl_set_combo_scc('glaa023','8021') 
   CALL cl_set_combo_scc('glaa009','8005') 
   CALL cl_set_combo_scc('glaa017','8022') 
   CALL cl_set_combo_scc('glaa021','8022') 
   CALL cl_set_combo_scc('glaa018','40') 
   CALL cl_set_combo_scc('glaa022','40') 
   CALL cl_set_combo_scc('glaa101','8031') 
   CALL cl_set_combo_scc('glaa102','8032') 
   CALL cl_set_combo_scc('glaa138','9998') 
 
   LET g_add_idx = 1
   LET g_current_idx = 1
    
   #add-point:畫面資料初始化 name="init.init"
   LET g_glaald_ins=NULL #用於記錄新增的帳套 
   #140314-00001#4-----s
   CALL cl_set_combo_scc('glaa132','9977') 
   CALL cl_set_combo_scc('glaa133','9978')
   CALL cl_set_combo_scc('glaa134','9979')
   #140314-00001#4-----e
   #end add-point
   
   CALL agli010_default_search()
    
END FUNCTION
 
{</section>}
 
{<section id="agli010.ui_dialog" >}
#+ 選單功能實際執行處
PRIVATE FUNCTION agli010_ui_dialog()
   #add-point:ui_dialog段define name="ui_dialog.define_customerization"
   
   #end add-point
   DEFINE li_exit      LIKE type_t.num5    #判別是否為離開作業
   DEFINE la_param  RECORD
          prog       STRING,
          actionid   STRING,
          background LIKE type_t.chr1,
          param      DYNAMIC ARRAY OF STRING
                    END RECORD
   DEFINE l_cmd_token           base.StringTokenizer   #報表作業cmdrun使用 
   DEFINE l_cmd_next            STRING                 #報表作業cmdrun使用
   DEFINE l_cmd_cnt             LIKE type_t.num5       #報表作業cmdrun使用
   DEFINE l_cmd_prog_arg        STRING                 #報表作業cmdrun使用
   DEFINE l_cmd_arg             STRING                 #報表作業cmdrun使用
   #add-point:ui_dialog段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="ui_dialog.define"
      
   #end add-point
   
   #add-point:Function前置處理  name="ui_dialog.pre_function"
   
   #end add-point
   
   LET li_exit = FALSE
   LET gwin_curr = ui.Window.getCurrent()
   LET gfrm_curr = gwin_curr.getForm() 
 
   #add-point:ui_dialog段before dialog  name="ui_dialog.before_dialog"
 
   #end add-point
   
   WHILE li_exit = FALSE
 
      IF g_action_choice = "logistics" THEN
         #清除畫面及相關資料
         CLEAR FORM
         CALL g_browser.clear()       
         INITIALIZE g_glaa_m.* TO NULL
         LET g_wc  = ' 1=2'
         LET g_action_choice = ""
         LET g_first = 1
         CALL agli010_init()
      END IF
 
      #當瀏覽頁簽被設定關閉時,使用MENU (開啟時使用DIALOG)
      IF g_worksheet_hidden = 1 THEN
 
         LET g_current_sw = FALSE
 
         #回歸舊筆數位置 (回到當時異動的筆數)
         LET g_current_idx = g_current_row
         LET g_current_sw = TRUE
         CALL cl_show_fld_cont() 
         CALL agli010_fetch("")    #當每次點任一筆資料都會需要用到
 
         MENU
            #add-point:ui_dialog段其他頁簽的 display array(in menu) name="ui_dialog.more_displayarray_in_menu"
                        
            #end add-point
            
            ON ACTION statechange
               LET g_action_choice = "statechange"
               CALL agli010_statechange()
            
            #ACTION表單列
            ON ACTION first
               LET g_current_idx = 1
               CALL agli010_fetch("")
               LET g_current_row = g_current_idx
            
            ON ACTION next
               LET g_current_idx = g_current_idx + 1
               CALL agli010_fetch("")
               LET g_current_row = g_current_idx
 
            ON ACTION jump
               CALL agli010_fetch("/")
               LET g_current_row = g_current_idx
 
            ON ACTION previous
               LET g_current_idx = g_current_idx - 1
               CALL agli010_fetch("")
               LET g_current_row = g_current_idx
 
            ON ACTION last 
               LET g_current_idx = g_browser_cnt
               CALL agli010_fetch("") 
               LET g_current_row = g_current_idx
 
            ON ACTION exit
               LET g_action_choice="exit"
               LET INT_FLAG = FALSE
               LET li_exit = TRUE
               EXIT MENU 
 
            ON ACTION close
               LET li_exit = TRUE
               EXIT MENU
 
            ON ACTION mainhidden       #主頁摺疊
               IF g_main_hidden THEN
                  CALL gfrm_curr.setElementHidden("mainlayout",0)
                  CALL gfrm_curr.setElementImage("mainhidden","16/worksheethidden.png")
                  LET g_main_hidden = 0
               ELSE
                  CALL gfrm_curr.setElementHidden("mainlayout",1)
                  CALL gfrm_curr.setElementImage("mainhidden","16/worksheethidden.png")
                  LET g_main_hidden = 1
               END IF
               EXIT MENU
         
            ON ACTION worksheethidden   #瀏覽頁折疊
               IF g_worksheet_hidden THEN
                  CALL gfrm_curr.setElementHidden("worksheet",0)
                  CALL gfrm_curr.setElementImage("worksheethidden","16/mainhidden.png")
                  LET g_worksheet_hidden = 0
               ELSE
                  CALL gfrm_curr.setElementHidden("worksheet",1)
                  CALL gfrm_curr.setElementImage("worksheethidden","16/mainhidden.png")
                  LET g_worksheet_hidden = 1
               END IF
               EXIT MENU
         
            ON ACTION controls      #單頭摺疊，可利用hot key "Alt-s"開啟/關閉單頭
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
               CALL agli010_modify()
               #add-point:ON ACTION modify name="menu2.modify"
                              
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION open_agli030
            LET g_action_choice="open_agli030"
            IF cl_auth_chk_act("open_agli030") THEN
               
               #add-point:ON ACTION open_agli030 name="menu2.open_agli030"
                                             CALL agli010_self_action("open_agli030")
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION open_agli100
            LET g_action_choice="open_agli100"
            IF cl_auth_chk_act("open_agli100") THEN
               
               #add-point:ON ACTION open_agli100 name="menu2.open_agli100"
               CALL agli010_self_action("open_agli100")
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION delete
            LET g_action_choice="delete"
            IF cl_auth_chk_act("delete") THEN
               CALL agli010_delete(DIALOG)
               #add-point:ON ACTION delete name="menu2.delete"
                              
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION insert
            LET g_action_choice="insert"
            IF cl_auth_chk_act("insert") THEN
               CALL agli010_insert(DIALOG)
               #add-point:ON ACTION insert name="menu2.insert"
               CALL agli010_browser_fill(g_wc,g_searchtype)
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION open_agli010_02
            LET g_action_choice="open_agli010_02"
            IF cl_auth_chk_act("open_agli010_02") THEN
               
               #add-point:ON ACTION open_agli010_02 name="menu2.open_agli010_02"
                              
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION output
            LET g_action_choice="output"
            IF cl_auth_chk_act("output") THEN
               
               #add-point:ON ACTION output name="menu2.output"
                              
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION quickprint
            LET g_action_choice="quickprint"
            IF cl_auth_chk_act("quickprint") THEN
               
               #add-point:ON ACTION quickprint name="menu2.quickprint"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION reproduce
            LET g_action_choice="reproduce"
            IF cl_auth_chk_act("reproduce") THEN
               CALL agli010_reproduce(DIALOG)
               #add-point:ON ACTION reproduce name="menu2.reproduce"
                              
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION open_agli010_01
            LET g_action_choice="open_agli010_01"
            IF cl_auth_chk_act("open_agli010_01") THEN
               
               #add-point:ON ACTION open_agli010_01 name="menu2.open_agli010_01"
                              
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION query
            LET g_action_choice="query"
            IF cl_auth_chk_act("query") THEN
               CALL agli010_query()
               #add-point:ON ACTION query name="menu2.query"
  
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION open_agli020
            LET g_action_choice="open_agli020"
            IF cl_auth_chk_act("open_agli020") THEN
               
               #add-point:ON ACTION open_agli020 name="menu2.open_agli020"
                                             CALL agli010_self_action("open_agli020")
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION open_aooi150
            LET g_action_choice="open_aooi150"
            IF cl_auth_chk_act("open_aooi150") THEN
               
               #add-point:ON ACTION open_aooi150 name="menu2.open_aooi150"
               CALL agli010_self_action("open_aooi150")
               #END add-point
               
            END IF
 
 
 
 
 
            
 
            #應用 a46 樣板自動產生(Version:3)
         #新增相關文件
         ON ACTION related_document
            CALL agli010_set_pk_array()
            IF cl_auth_chk_act("related_document") THEN
               #add-point:ON ACTION related_document name="ui_dialog.menu.related_document"
               
               #END add-point
               CALL cl_doc()
            END IF
            
         ON ACTION agendum
            CALL agli010_set_pk_array()
            #add-point:ON ACTION agendum name="ui_dialog.menu.agendum"
            
            #END add-point
            CALL cl_user_overview()
            CALL cl_user_overview_set_follow_pic()
         
         ON ACTION followup
            CALL agli010_set_pk_array()
            #add-point:ON ACTION followup name="ui_dialog.menu.followup"
            
            #END add-point
            CALL cl_user_overview_follow('')
 
 
 
            
            &include "main_menu_exit_menu.4gl"
            &include "relating_action.4gl"
            #交談指令共用ACTION
            &include "common_action.4gl"
 
         END MENU
 
      ELSE
         #第一次進入程式, 或啟動重新查詢
         IF g_first = 0 THEN 
            CALL agli010_browser_fill(g_wc,g_searchtype)
            LET g_first = 1
         END IF
      
         DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
         
            INPUT g_searchstr,g_searchcol,g_searchtype FROM formonly.searchstr,formonly.cbo_searchcol, 
                formonly.rdo_searchtype
               BEFORE INPUT
            END INPUT
            
            #左側瀏覽頁簽
            DISPLAY ARRAY g_browser TO s_browse.* ATTRIBUTE(COUNT=g_rec_b)
 
               BEFORE DISPLAY
                  CALL DIALOG.setSelectionMode("s_browse",1) #設定為單選
 
               BEFORE ROW
                  #add-point:ui_dialog段before row1 name="ui_dialog.before_row1"
                  
                  #end add-point
                  #回歸舊筆數位置 (回到當時異動的筆數)
                  LET g_current_idx = DIALOG.getCurrentRow("s_browse")
                  IF g_current_row > 1 AND g_current_sw = FALSE THEN
                     CALL DIALOG.setCurrentRow("s_browse",g_current_row)
                     LET g_current_idx = g_current_row
                  END IF
                  #add-point:ui_dialog段before row2 name="ui_dialog.before_row2"
                  
                  #end add-point
                  LET g_current_row = g_current_idx #目前指標
                  LET g_current_sw = TRUE
                  CALL cl_show_fld_cont() 
                  CALL DIALOG.setCurrentRow("s_browse",g_current_row)
 
                  CALL agli010_fetch("")  #當每次點任一筆資料都會需要用到
 
               ON EXPAND (g_row_index)
                  #樹展開
                  CALL agli010_browser_expand(g_row_index)
                  LET g_browser[g_row_index].b_isExp = 1
 
               ON COLLAPSE (g_row_index)
                  #樹關閉
                  
               #add-point:ui_dialog段action name="ui_dialog.tree_action"
               
               #end add-point
 
            END DISPLAY
 
            #add-point:ui_dialog段其他頁簽的 display array name="ui_dialog.more_displayarray"
                        
            #end add-point
 
            BEFORE DIALOG
               #action default動作(判定是否要先執行特定動作)
               #應用 a42 樣板自動產生(Version:3)
   #進入程式時預設執行的動作
   CASE g_actdefault
      WHEN "insert"
         LET g_action_choice="insert"
         LET g_actdefault = ""
         IF cl_auth_chk_act("insert") THEN
            CALL agli010_insert(DIALOG)
            #add-point:ON ACTION insert name="menu.default.insert"
            CALL agli010_browser_fill(g_wc,g_searchtype)
            #END add-point
         END IF
 
      #add-point:action default自訂 name="ui_dialog.action_default"
            
      #end add-point
      OTHERWISE
   END CASE
 
 
 
               LET g_curr_diag = ui.DIALOG.getCurrent()
               LET g_current_sw = FALSE
 
               #add-point:ui_dialog,before dialog1 name="ui_dialog.b_dialog1"
               
               #end add-point
               #回歸舊筆數位置 (回到當時異動的筆數)
               LET g_current_idx = DIALOG.getCurrentRow("s_browse")
               IF g_current_row > 1 AND g_current_sw = FALSE THEN
                  IF g_current_row > g_browser.getLength() THEN
                     LET g_current_row = g_browser.getLength()
                  END IF 
                  CALL DIALOG.setCurrentRow("s_browse",g_current_row)
                  LET g_current_idx = g_current_row
               END IF
               #add-point:ui_dialog,before dialog2 name="ui_dialog.b_dialog2"
               
               #end add-point
               LET g_current_row = g_current_idx #目前指標
               LET g_current_sw = TRUE
               CALL cl_show_fld_cont() 
               CALL DIALOG.setCurrentRow("s_browse",g_current_row)
               CALL agli010_fetch("")            #當每次點任一筆資料都會需要用到
               #add-point:ui_dialog,before dialog name="ui_dialog.b_dialog"
                              
               #end add-point
 
            AFTER DIALOG 
               #add-point:ui_dialog,after dialog name="ui_dialog.a_dialog"
                              
               #end add-point
 
            ON ACTION statechange
               LET g_action_choice = "statechange"
               CALL agli010_statechange()
 
            #一般搜尋
            ON ACTION searchdata
               LET g_searchstr = GET_FLDBUF(searchstr)
               LET g_searchcol = GET_FLDBUF(cbo_searchcol)
               #若無輸入關鍵字則查找出所有資料
               IF g_searchcol="0" AND NOT cl_null(g_searchstr) THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "searchcol:" 
                  LET g_errparam.code = "std-00001" 
                  LET g_errparam.popup = FALSE 
                  CALL cl_err()
                  CONTINUE DIALOG
               END IF 
               IF NOT cl_null(g_searchstr) THEN
                  LET g_wc = " lower(", g_searchcol, ") LIKE '%", g_searchstr, "%'"
                  LET g_wc = g_wc.toLowerCase()
               ELSE
                  LET g_wc = " 1=1 "
               END IF
               LET g_first = 0 #啟動重查
               EXIT DIALOG
 
            #進階搜尋
            #ON ACTION advancesearch
 
            ON ACTION exit
               LET g_action_choice="exit"
               LET INT_FLAG = FALSE
               LET li_exit = TRUE
               EXIT DIALOG 
            
            ON ACTION close
               LET li_exit = TRUE
               EXIT DIALOG
            
            ON ACTION mainhidden       #主頁摺疊
               IF g_main_hidden THEN
                  CALL gfrm_curr.setElementHidden("mainlayout",0)
                  CALL gfrm_curr.setElementImage("mainhidden","16/worksheethidden.png")
                  LET g_main_hidden = 0
               ELSE
                  CALL gfrm_curr.setElementHidden("mainlayout",1)
                  CALL gfrm_curr.setElementImage("mainhidden","16/mainhidden.png")
                  LET g_main_hidden = 1
               END IF
               EXIT DIALOG
 
            ON ACTION worksheethidden   #瀏覽頁折疊
               IF g_worksheet_hidden THEN
                  CALL gfrm_curr.setElementHidden("worksheet",0)
                  CALL gfrm_curr.setElementImage("worksheethidden","16/worksheethidden.png")
                  LET g_worksheet_hidden = 0
               ELSE
                  CALL gfrm_curr.setElementHidden("worksheet",1)
                  CALL gfrm_curr.setElementImage("worksheethidden","16/worksheethidden.png")
                  LET g_worksheet_hidden = 1
               END IF
               EXIT DIALOG
 
            ON ACTION controls      #單頭摺疊，可利用hot key "Alt-s"開啟/關閉單頭
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
               CALL agli010_modify()
               #add-point:ON ACTION modify name="menu.modify"
                              
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION open_agli030
            LET g_action_choice="open_agli030"
            IF cl_auth_chk_act("open_agli030") THEN
               
               #add-point:ON ACTION open_agli030 name="menu.open_agli030"
                                             CALL agli010_self_action("open_agli030")
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION open_agli100
            LET g_action_choice="open_agli100"
            IF cl_auth_chk_act("open_agli100") THEN
               
               #add-point:ON ACTION open_agli100 name="menu.open_agli100"
               CALL agli010_self_action("open_agli100")
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION delete
            LET g_action_choice="delete"
            IF cl_auth_chk_act("delete") THEN
               CALL agli010_delete(DIALOG)
               #add-point:ON ACTION delete name="menu.delete"
                                             EXIT DIALOG
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION insert
            LET g_action_choice="insert"
            IF cl_auth_chk_act("insert") THEN
               CALL agli010_insert(DIALOG)
               #add-point:ON ACTION insert name="menu.insert"
               CALL agli010_browser_fill(g_wc,g_searchtype)
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION open_agli010_02
            LET g_action_choice="open_agli010_02"
            IF cl_auth_chk_act("open_agli010_02") THEN
               
               #add-point:ON ACTION open_agli010_02 name="menu.open_agli010_02"
                                             CALL agli010_self_action("open_agli010_02")
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION output
            LET g_action_choice="output"
            IF cl_auth_chk_act("output") THEN
               
               #add-point:ON ACTION output name="menu.output"
                              
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION quickprint
            LET g_action_choice="quickprint"
            IF cl_auth_chk_act("quickprint") THEN
               
               #add-point:ON ACTION quickprint name="menu.quickprint"
                              
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION reproduce
            LET g_action_choice="reproduce"
            IF cl_auth_chk_act("reproduce") THEN
               CALL agli010_reproduce(DIALOG)
               #add-point:ON ACTION reproduce name="menu.reproduce"
                              
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION open_agli010_01
            LET g_action_choice="open_agli010_01"
            IF cl_auth_chk_act("open_agli010_01") THEN
               
               #add-point:ON ACTION open_agli010_01 name="menu.open_agli010_01"
                                             CALL agli010_self_action("open_agli010_01")
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION query
            LET g_action_choice="query"
            IF cl_auth_chk_act("query") THEN
               CALL agli010_query()
               #add-point:ON ACTION query name="menu.query"
               CONTINUE WHILE    #160812-00004#1 add
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION open_agli020
            LET g_action_choice="open_agli020"
            IF cl_auth_chk_act("open_agli020") THEN
               
               #add-point:ON ACTION open_agli020 name="menu.open_agli020"
                                             CALL agli010_self_action("open_agli020")
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION open_aooi150
            LET g_action_choice="open_aooi150"
            IF cl_auth_chk_act("open_aooi150") THEN
               
               #add-point:ON ACTION open_aooi150 name="menu.open_aooi150"
                                             CALL agli010_self_action("open_aooi150")
               #END add-point
               
            END IF
 
 
 
 
 
            
            
            #應用 a46 樣板自動產生(Version:3)
         #新增相關文件
         ON ACTION related_document
            CALL agli010_set_pk_array()
            IF cl_auth_chk_act("related_document") THEN
               #add-point:ON ACTION related_document name="ui_dialog.dialog.related_document"
               
               #END add-point
               CALL cl_doc()
            END IF
            
         ON ACTION agendum
            CALL agli010_set_pk_array()
            #add-point:ON ACTION agendum name="ui_dialog.dialog.agendum"
            
            #END add-point
            CALL cl_user_overview()
            CALL cl_user_overview_set_follow_pic()
         
         ON ACTION followup
            CALL agli010_set_pk_array()
            #add-point:ON ACTION followup name="ui_dialog.dialog.followup"
            
            #END add-point
            CALL cl_user_overview_follow('')
 
 
 
            
            &include "main_menu_exit_dialog.4gl"
            #交談指令共用ACTION
            &include "common_action.4gl"
            
         END DIALOG 
      
      END IF
      
   END WHILE
 
END FUNCTION 
 
{</section>}
 
{<section id="agli010.browser_fill" >}
#+ 瀏覽頁簽where條件組成
PRIVATE FUNCTION agli010_browser_fill(p_wc,p_type)
   #add-point:browser_fill段define name="browser_fill.define_customerization"
   
   #end add-point
   DEFINE p_wc       STRING 
   DEFINE p_type     LIKE type_t.chr10
   DEFINE l_cnt      LIKE type_t.num10
   DEFINE l_cnt2     LIKE type_t.num10   
   #add-point:browser_fill段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="browser_fill.define"
#   DEFINE l_ld_str   STRING   #160811-00039#1 #160825-00017#1 mark
   #end add-point
   
   #add-point:Function前置處理  name="browser_fill.before_fill"
#160825-00017#1--mark--str--
#   #160811-00039#1--add--str--
#   CALL s_axrt300_get_site(g_user,g_site_str,'2') RETURNING l_ld_str
#   IF NOT cl_null(p_wc) THEN
#      LET p_wc = p_wc," AND ",l_ld_str
#   ELSE
#      LET p_wc = l_ld_str
#   END IF
#   #160811-00039#1--add--end
#160825-00017#1--mark--end
   LET g_wc_def = p_wc
   #end add-point
 
   CALL g_browser.clear()
   CLEAR FORM
   LET l_cnt = 0
   LET l_cnt2 = 0
   
   DROP TABLE agli010_tmp
   
   #Create temp table
   CREATE TEMP TABLE agli010_tmp
   (
         glaald VARCHAR(500),
   glaacomp VARCHAR(500),
   glaacomp_desc VARCHAR(500),
      #僅含browser的欄位
      exp_code  VARCHAR(5)
   );
 
   #先確定搜尋範圍(若無條件搜尋則只找root出來)
   SELECT COUNT(1) INTO l_cnt FROM glaa_t WHERE glaaent = g_enterprise AND 1=1
   
   #取得符合p_wc的所有資料
   LET g_sql = "SELECT COUNT(1)",
               " FROM glaa_t ",
               "  LEFT JOIN glaal_t ON glaalent = "||g_enterprise||" AND glaald = glaalld AND glaal001 = '",g_dlang,"' ",
               " WHERE glaaent = " ||g_enterprise|| " AND ",p_wc ,cl_sql_add_filter("glaa_t")
   #add-point:browser_fill段cnt wc name="browser_fill.cnt_wc"
 
   #end add-point
              
   PREPARE master_cnt FROM g_sql
   DECLARE master_cntcur CURSOR FOR master_cnt
   OPEN master_cntcur
   IF SQLCA.SQLCODE THEN   #(ver:36)
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "OPEN master_cntcur:",SQLERRMESSAGE 
      LET g_errparam.code = SQLCA.SQLCODE   #(ver:36)
      LET g_errparam.popup = TRUE 
      CALL cl_err()
      RETURN
   END IF
 
   FETCH master_cntcur INTO l_cnt2
   LET g_root_search = FALSE
   
   IF l_cnt2 = 0 THEN
      #INITIALIZE g_errparam TO NULL 
      #LET g_errparam.extend = "" 
      #LET g_errparam.code = "-100" 
      #LET g_errparam.popup = TRUE 
      #CALL cl_err()
      RETURN
   END IF
   
   IF l_cnt = l_cnt2 THEN
      #未輸入條件時則只查找root節點
      LET p_wc = " glaald = glaacomp "
      LET g_root_search = TRUE
   END IF
 
   #取得符合p_wc的所有資料
   LET g_sql = "SELECT glaald,glaacomp,'' ",
               " FROM glaa_t",
               "  LEFT JOIN glaal_t ON glaalent = "||g_enterprise||" AND glaald = glaalld AND glaal001 = '",g_dlang,"' ",
               " WHERE glaaent = " ||g_enterprise|| " AND ",p_wc ,cl_sql_add_filter("glaa_t")
   #add-point:browser_fill段sql wc name="browser_fill.sql_wc"
   
   #end add-point
   #LET g_sql = cl_sql_add_tabid(g_sql,"glaa_t")             #WC重組
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料           
   PREPARE master_ext FROM g_sql
   DECLARE master_extcur CURSOR FOR master_ext
   
   #單筆update
   #LET g_sql = "SELECT '','','','','','','',glaald,glaacomp,'' ",
   #            " FROM glaa_t",
   #            "  LEFT JOIN glaal_t ON glaalent = "||g_enterprise||" AND glaald = glaalld AND glaal001 = '",g_dlang,"' ",
   #            " WHERE glaaent = " ||g_enterprise|| " AND ",
   #            " glaald = ?"
 
                
   LET g_sql = " SELECT t0.glaald,t0.glaacomp ",
               " FROM glaa_t t0",
               "  ",
               
               " WHERE glaaent = " ||g_enterprise|| " AND ",
               " glaald = ?"
 
 
               
   #add-point:browser_fill段sql wc name="browser_fill.refresh"
   
   #end add-point
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料           
   PREPARE master_refresh FROM g_sql
   DECLARE master_refreshcur CURSOR FOR master_refresh
 
   #搜尋建構樹所需的節點
   CASE p_type
      WHEN "1" #上推
         CALL agli010_match_node(p_wc,p_type) 
      WHEN "2" #下展
         #CALL agli010_find_speed_tbl(p_wc,p_type) 
         CALL agli010_match_node(p_wc,p_type) 
      WHEN "3" #全部
         CALL agli010_match_node(p_wc,p_type) 
   END CASE
 
   CALL agli010_browser_create(p_type)
     
END FUNCTION
 
{</section>}
 
{<section id="agli010.match_node" >}
PRIVATE FUNCTION agli010_match_node(p_wc,p_type)
   #add-point:match_node段define name="match_node.define_customerization"
   
   #end add-point
   DEFINE p_wc         LIKE type_t.chr200
   DEFINE p_type       LIKE type_t.chr10
   DEFINE ls_code      LIKE type_t.chr50
   DEFINE ls_code2     LIKE type_t.chr50
   DEFINE l_bstmp      RECORD    #body欄位
             glaald VARCHAR(500),
   glaacomp VARCHAR(500),
   glaacomp_desc VARCHAR(500)
          #僅含單身table的欄位
   END RECORD 
   DEFINE l_child_list DYNAMIC ARRAY OF RECORD    #body欄位
             glaald VARCHAR(500),
   glaacomp VARCHAR(500),
   glaacomp_desc VARCHAR(500)
          #僅含單身table的欄位
   END RECORD
   DEFINE li_cnt       LIKE type_t.num10   #(ver:35) add
   #add-point:match_node段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="match_node.define"
      
   #end add-point
   
   #add-point:Function前置處理  name="match_node.pre_function"
   
   #end add-point
   
   #先找出符合條件的節點並給予展開值
   CASE p_type
      WHEN 1
         LET ls_code = "0" #展開值0則無法展開
      WHEN 2
         LET ls_code = "2"
      WHEN 3
         LET ls_code = "2"
   END CASE
   
   IF cl_null("glaacomp") THEN
      LET ls_code = "0"
   END IF 
   
   CALL s_transaction_begin()
 
   LET g_sql = " INSERT INTO agli010_tmp (glaald,glaacomp,glaacomp_desc,exp_code) VALUES (?,?,?,?)"
   PREPARE master_tmp FROM g_sql
   
   IF g_root_search THEN
      #DECLARE master_tmp_cur CURSOR FOR master_tmp
      #OPEN master_tmp_cur
      FOREACH master_extcur INTO l_bstmp.*
         EXECUTE master_tmp USING l_bstmp.*,ls_code
         #PUT master_tmp_cur FROM l_bstmp.*,ls_code
      END FOREACH
      #FLUSH master_tmp_cur
      CALL s_transaction_end("Y","0")
      RETURN
   END IF
 
   #(ver:35) ---modify start---
   FOREACH master_extcur INTO l_bstmp.*
      #(ver:35) add glaacomp
      IF agli010_tmp_tbl_chk(l_bstmp.glaald,l_bstmp.glaacomp,ls_code   #(ver:35) add glaacomp
                  ) THEN
         EXECUTE master_tmp USING l_bstmp.*,ls_code
      END IF
 
      LET l_child_list[l_child_list.getLength()+1].* = l_bstmp.*
   END FOREACH
 
   #找出符合條件的節點的所有祖先並給予展開值
   CASE p_type
      WHEN 1
         LET ls_code2 = "1"
      WHEN 2
         LET ls_code2 = "-1"
      WHEN 3
         LET ls_code2 = "1"
   END CASE
 
   WHILE TRUE
      IF l_child_list.getLength() <= 0 THEN
         EXIT WHILE
      END IF
 
      #若pid欄位存在才進行後續處理
      #擷取該節點的所有父節點
      IF cl_null(l_child_list[1].glaald) THEN
         IF l_child_list.getLength() = 1 THEN
            EXIT WHILE
         ELSE
            CALL l_child_list.deleteElement(1)
            CONTINUE WHILE
         END IF
      END IF
 
      #確認是否有父節點
      LET g_sql = " SELECT COUNT(1) ",
                  " FROM glaa_t t0",
                  " WHERE glaaent = " ||g_enterprise|| " AND glaald = ? ",
                  cl_sql_add_filter("gzwe_t")
      PREPARE master_getparent_cnt FROM g_sql
      EXECUTE master_getparent_cnt USING l_child_list[1].glaacomp INTO li_cnt
      IF li_cnt <= 0 THEN
         CALL l_child_list.deleteElement(1)
         CONTINUE WHILE
      END IF
 
      #擷取該節點的父節點到temp table中
      LET g_sql = " SELECT glaald,glaacomp,'' ",
                  " FROM glaa_t t0",
                  " WHERE glaaent = " ||g_enterprise|| " AND glaald = ? ",
                  cl_sql_add_filter("glaa_t")
      PREPARE master_getparent_up FROM g_sql
      DECLARE master_getparent_up_cur CURSOR FOR master_getparent_up
      
   #  EXECUTE master_getparent_up USING l_child_list[1].glaacomp
   #                                    INTO l_bstmp.*
      FOREACH master_getparent_up_cur USING l_child_list[1].glaacomp
                                        INTO l_bstmp.*
 
         IF SQLCA.SQLCODE THEN
            FREE master_getparent_up
            EXIT WHILE
         END IF
         #FREE master_getparent_up
      
         #確定該節點是否存在於temp table中
         IF STATUS = 0 AND agli010_tmp_tbl_chk(l_bstmp.glaald,l_bstmp.glaacomp,ls_code2
                     ) THEN
            EXECUTE master_tmp USING l_bstmp.*,ls_code2
 
            #若已找到root，表示已到根結點
            IF l_bstmp.glaald = l_bstmp.glaacomp THEN
               CALL l_child_list.deleteElement(1)
               CONTINUE WHILE
            END IF
 
            LET l_child_list[l_child_list.getLength()+1].* = l_bstmp.*
         END IF
      END FOREACH
      CALL l_child_list.deleteElement(1)
   END WHILE
   #(ver:35) --- modify end ---
 
   CLOSE master_tmp
   
   CALL s_transaction_end("Y","0")
 
END FUNCTION
 
{</section>}
 
{<section id="agli010.tmp_tbl_chk" >}
#+ TEMP TABLE CHK
#PRIVATE FUNCTION agli010_tmp_tbl_chk(ps_id,pi_code)
PRIVATE FUNCTION agli010_tmp_tbl_chk(ps_id,ps_pid,pi_code)   #(ver:35) modify
   #add-point:tmp_tbl_chk段define name="tmp_tbl_chk.define_customerization"
   
   #end add-point
   DEFINE ps_id       STRING
   DEFINE ps_pid      STRING   #(ver:35) add
   DEFINE pi_code     LIKE type_t.num10
   DEFINE ps_type     STRING
   DEFINE ls_id       LIKE type_t.chr500
   DEFINE ls_pid      LIKE type_t.chr500   #(ver:35) add
   DEFINE ls_search   LIKE type_t.chr500
   DEFINE ls_type     LIKE type_t.chr500
   DEFINE li_cnt      LIKE type_t.num10
   DEFINE li_code     LIKE type_t.num10   
   #add-point:tmp_tbl_chk段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="tmp_tbl_chk.define"
      
   #end add-point
   
   #add-point:Function前置處理  name="tmp_tbl_chk.pre_function"
   
   #end add-point
   
   LET ls_id = ps_id
   LET ls_pid = ps_pid   #(ver:35) add
  
   IF cl_null(ls_id) THEN
      RETURN TRUE
   END IF
   
   LET g_sql = " SELECT COUNT(1) FROM agli010_tmp ", 
               " WHERE glaald = ? ",
                 " AND glaacomp = ? "   #(ver:35) add
 
   PREPARE agli010_get_cnt FROM g_sql
   EXECUTE agli010_get_cnt USING ls_id ,ls_pid   #(ver:35) add ls_pid
                                     INTO li_cnt
   FREE agli010_get_cnt
 
   IF li_cnt = 0 OR SQLCA.SQLCODE THEN
      RETURN TRUE
   ELSE
      #資料已存在, 確定是否需要更新展開值
      LET g_sql = " SELECT exp_code FROM agli010_tmp ",
                  " WHERE glaald = ? ",
                    " AND glaacomp = ? "   #(ver:35) add
 
      PREPARE agli010_chk_exp FROM g_sql
      EXECUTE agli010_chk_exp USING ls_id ,ls_pid   #(ver;35) add ls_pid
                                        INTO li_code
      FREE agli010_chk_exp
      
      #若新展開值>原展開值則做更新
      IF pi_code > li_code THEN
         LET g_sql = " UPDATE agli010_tmp SET (exp_code) = ('",pi_code,"') ",
                     " WHERE glaald = ? ",
                       " AND glaacomp = ? "   #(ver:35) add
         PREPARE agli010_upd_exp FROM g_sql
         EXECUTE agli010_upd_exp USING ls_id ,ls_pid   #(ver:35) add ls_pid
         FREE agli010_upd_exp
      END IF
      
      RETURN FALSE
   END IF
 
END FUNCTION
 
{</section>}
 
{<section id="agli010.browser_expand" >}
#+ Tree子節點展開
PRIVATE FUNCTION agli010_browser_expand(p_id)
   #add-point:browser_expand段define name="browser_expand.define_customerization"
   
   #end add-point
   DEFINE p_id          LIKE type_t.num10
   DEFINE l_id          LIKE type_t.num10
   DEFINE l_cnt         LIKE type_t.num10
   DEFINE l_keyvalue    LIKE type_t.chr50
   DEFINE l_typevalue   LIKE type_t.chr50
   DEFINE l_type        LIKE type_t.chr50
   DEFINE l_sql         STRING
   DEFINE ls_source     LIKE type_t.chr500
   DEFINE ls_exp_code   LIKE type_t.chr500
   DEFINE l_return      LIKE type_t.num5
   DEFINE ls_ent_wc     LIKE type_t.chr500
   #add-point:browser_expand段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="browser_expand.define"
      
   #end add-point
   
   #add-point:Function前置處理  name="browser_expand.pre_function"
   
   #end add-point
   
   #若已經展開
   IF g_browser[p_id].b_isExp = 1 THEN
      RETURN
   END IF
   
   LET l_return = FALSE
 
   LET l_keyvalue = g_browser[p_id].b_glaald
   
   CASE g_browser[p_id].b_expcode
      WHEN -1
         CALL g_browser.deleteElement(p_id)
      WHEN 0
         RETURN
      WHEN 1
         LET ls_source = "agli010_tmp"
         LET ls_exp_code = "exp_code"
      WHEN 2
         LET ls_source = "glaa_t"
         LET ls_exp_code = "'2'"
         LET ls_ent_wc = " glaaent = " ||g_enterprise|| " AND "
   END CASE
    
   LET l_sql = " SELECT DISTINCT '','','','FALSE','','',",ls_exp_code,",glaald,glaacomp,'' ",
               " FROM ",ls_source,
               
               " WHERE ",ls_ent_wc,"glaacomp = '", l_keyvalue,
               "' AND glaald <> glaacomp",
               " ORDER BY glaald"
   
   #add-point:browser_expand段before_pre name="browser_expand.before_pre"
      
   #end add-point
   
   LET l_sql = cl_sql_add_mask(l_sql)              #遮蔽特定資料
   PREPARE tree_expand FROM l_sql
   DECLARE tree_ex_cur CURSOR FOR tree_expand
  
   LET l_id = p_id + 1
   LET g_cnt = p_id + 1
   CALL g_browser.insertElement(l_id)
   LET l_cnt = 1
   FOREACH tree_ex_cur INTO g_browser[l_id].* 
      #pid=父節點id
      LET g_browser[l_id].b_pid = g_browser[p_id].b_id
      #id=本身節點id(採流水號遞增)
      LET g_browser[l_id].b_id = g_browser[p_id].b_id||"."||l_cnt
      #hasC=確認該節點是否有子孫
      CALL agli010_desc_show(l_id)
      LET g_browser[l_id].b_hasC = agli010_chk_hasC(l_id)
      LET l_id = l_id + 1
      LET g_cnt = l_id
      CALL g_browser.insertElement(l_id)
      LET l_cnt = l_cnt + 1
      LET l_return = TRUE
   END FOREACH
   
   #刪除空資料
   CALL g_browser.deleteElement(l_id)
   DISPLAY g_browser.getLength() TO FORMONLY.h_count 
 
END FUNCTION
 
{</section>}
 
{<section id="agli010.browser_create" >}
PRIVATE FUNCTION agli010_browser_create(p_type)
   #add-point:browser_create name="browser_create.define_customerization"
   
   #end add-point
   DEFINE p_type   LIKE type_t.chr50
   DEFINE l_pid    LIKE type_t.chr50
   #add-point:browser_create(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="browser_create.define"
         CALL agli010_tree_create()
   RETURN
   #end add-point
   
   #add-point:Function前置處理  name="browser_create.pre_function"
   
   #end add-point
   
   #先找出所有的帳別資料
   
   LET l_ac = 1
      #確定root節點所在
      #此處為帳別部分(LV-1)
      
      #抓出LV2的所有資料
      #LET g_sql = " SELECT DISTINCT t0.glaald,t0.glaacomp,exp_code FROM agli010_tmp a ",
      LET g_sql = " SELECT DISTINCT '','','','FALSE','','',exp_code,glaald,glaacomp,'' FROM agli010_tmp a ", 
 
                  
                  " WHERE ",
                  " (( SELECT COUNT(1) FROM agli010_tmp b WHERE a.glaacomp = b.glaald ", 
                  ") = 0 OR ", 
                  " a.glaald = a.glaacomp )", 
                  " ORDER BY a.glaald"
      #add-point:browser_create.before_pre name="browser_create.before_pre"
      
      #end add-point
 
      PREPARE master_getLV2 FROM g_sql
      DECLARE master_getLV2cur CURSOR FOR master_getLV2
      
      #以下為一般資料root(LV-2)
 
      LET g_cnt = l_ac
      FOREACH master_getLV2cur   #(ver:36) #(ver:37)
         INTO g_browser[g_cnt].*    #(ver:36)
         #(ver:36) ---add start---
         IF SQLCA.SQLCODE THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.extend = "Browser Create FOREACH ERROR"
            LET g_errparam.code = SQLCA.SQLCODE
            LET g_errparam.popup = TRUE
            CALL cl_err()
            RETURN
         END IF
         #(ver:36) --- add end ---
 
         #去除多餘空白
         #LET g_browser[g_cnt].b_glaald = g_browser[g_cnt].b_glaald CLIPPED
         LET g_browser[g_cnt].b_pid = l_pid
         LET g_browser[g_cnt].b_id  = l_pid,".",g_cnt USING "<<<"
         LET g_browser[g_cnt].b_exp = FALSE
         #(ver:35) ---modify start---
         #LET g_browser[g_cnt].b_expcode = 2
         CASE g_browser[g_cnt].b_expcode
            WHEN 2
               LET g_browser[g_cnt].b_hasC = agli010_chk_hasC(g_cnt)
            WHEN 1
               LET g_browser[g_cnt].b_hasC = agli010_chk_hasC(g_cnt)
            WHEN 0
               LET g_browser[g_cnt].b_hasC = FALSE
            WHEN -1
               #向下查找到展開值不等於-1得節點(temp table中查找)
               LET g_cnt = agli010_find_node(g_cnt)
         END CASE
         #(ver:35) --- modify end ---
         IF cl_null("glaacomp") THEN
            LET g_browser[g_cnt].b_hasC = FALSE
         ELSE
            LET g_browser[g_cnt].b_hasC = TRUE
         END IF
 
         LET g_cnt = g_cnt + 1
      END FOREACH
      LET l_ac = g_browser.getLength()
 
   
   #組合描述欄位&刪除多於資料
   FOR l_ac = 1 TO g_browser.getLength()
      IF cl_null(g_browser[l_ac].b_glaald) THEN
         CALL g_browser.deleteElement(l_ac)
         LET l_ac = l_ac - 1
      ELSE
         CALL agli010_desc_show(l_ac)
      END IF
   END FOR
   CALL g_browser.deleteElement(l_ac)
 
   LET g_browser_cnt = g_browser.getLength() - g_browser_root.getLength()
 
   FREE tree_expand
   FREE master_getLV2
   
END FUNCTION
 
{</section>}
 
{<section id="agli010.desc_show" >}
#+ 組合顯示在畫面上的資訊
PRIVATE FUNCTION agli010_desc_show(pi_ac)
   #add-point:desc_show段define name="desc_show.define_customerization"
   
   #end add-point
   DEFINE pi_ac   LIKE type_t.num10
   DEFINE li_tmp  LIKE type_t.num10   
   #add-point:desc_show段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="desc_show.define"
         DEFINE l_glaa014 LIKe glaa_t.glaa014
   #end add-point
   
   #add-point:Function前置處理  name="desc_show.pre_function"
   
   #end add-point
   
   LET li_tmp = l_ac
   LET l_ac = pi_ac
   
   
   #add-point:browser_create段desc處理 name="desc_show.show"
   IF cl_null(g_browser[l_ac].b_glaald) THEN
      CALL agli010_glaacomp_ref(g_browser[l_ac].b_glaacomp) RETURNING g_browser[l_ac].b_show
      LET g_browser[l_ac].b_show = 
        g_browser[l_ac].b_glaacomp,"(",g_browser[l_ac].b_show CLIPPED,")"
   ELSE
      CALL agli010_glaald_ref(g_browser[l_ac].b_glaald) RETURNING g_browser[l_ac].b_show
      LET g_browser[l_ac].b_show = 
        g_browser[l_ac].b_glaald,"(",g_browser[l_ac].b_show CLIPPED,")"
#   END IF    #160812-00004#1 mark
      LET l_glaa014 = ''
      SELECT glaa014 INTO l_glaa014 FROM glaa_t
       WHERE glaaent = g_enterprise AND glaald = g_browser[l_ac].b_glaald
      IF l_glaa014 = 'Y' THEN 
         LET g_browser[l_ac].b_glaacomp_desc = "16/bookmark.png"
         DISPLAY BY NAME g_browser[l_ac].b_glaacomp_desc 
      ELSE
         LET g_browser[l_ac].b_glaacomp_desc = "16/gray_ball.png"
         DISPLAY BY NAME g_browser[l_ac].b_glaacomp_desc
      END IF  
   END IF    #160812-00004#1 add      
   #end add-point
 
   LET l_ac = li_tmp
 
END FUNCTION
 
{</section>}
 
{<section id="agli010.find_node" >}
#+ 尋找符合條件的節點
PRIVATE FUNCTION agli010_find_node(pi_ac)
   #add-point:find_node段define name="find_node.define_customerization"
   
   #end add-point
   DEFINE pi_ac   LIKE type_t.num10
   DEFINE li_idx  LIKE type_t.num10
   DEFINE li_tmp  LIKE type_t.num10
   DEFINE ls_pid  STRING
   #add-point:find_node段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="find_node.define"
      
   #end add-point
   
   #add-point:Function前置處理  name="find_node.pre_function"
   
   #end add-point
   
   LET ls_pid = g_browser[pi_ac].b_pid
   
   LET g_sql = " SELECT DISTINCT '','','','FALSE','','',exp_code,glaald,glaacomp,'' ",
               " FROM agli010_tmp ",
               " WHERE glaacomp = ? AND glaacomp <> glaald",
               " ORDER BY glaald"
   PREPARE master_getNode FROM g_sql
   DECLARE master_getNodecur CURSOR FOR master_getNode
   
   LET li_idx = pi_ac
   WHILE li_idx <= g_browser.getLength()
      IF g_browser[li_idx].b_expcode = -1 THEN
      #  OPEN master_getNodecur USING g_browser[li_idx].b_glaald   #(ver:36)
         FOREACH master_getNodecur USING g_browser[li_idx].b_glaald INTO g_browser[g_browser.getLength()+1].*  
               #(ver:36)
 
            #(ver:36) ---start---
            IF SQLCA.SQLCODE THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "FOREACH ",SQLERRMESSAGE
               LET g_errparam.code = SQLCA.SQLCODE
               LET g_errparam.popup = TRUE 
               CALL cl_err()
               RETURN
            END IF
            #(ver:36) --- end ---
            CALL agli010_desc_show(g_browser.getLength())
            LET g_browser[g_browser.getLength()].b_pid = ls_pid
            LET g_browser[g_browser.getLength()].b_id = g_browser.getLength()
            LET g_browser[g_browser.getLength()].b_hasC = agli010_chk_hasC(g_browser.getLength())
         END FOREACH
         CALL g_browser.deleteElement(li_idx)
         CALL g_browser.deleteElement(g_browser.getLength())
      ELSE
         LET li_idx = li_idx + 1
      END IF
   
   END WHILE
   
   FREE master_getNode
   
   RETURN g_browser.getLength()
 
END FUNCTION
 
{</section>}
 
{<section id="agli010.chk_hasC" >}
#+ QBE資料查詢
PRIVATE FUNCTION agli010_chk_hasC(pi_id)
   #add-point:chk_hasC段define name="chk_hasC.define_customerization"
   
   #end add-point
   DEFINE pi_id    LIKE type_t.num10
   DEFINE li_cnt   LIKE type_t.num10
   #add-point:chk_hasC段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="chk_hasC.define"
      
   #end add-point
   
   #add-point:Function前置處理  name="chk_hasC.pre_function"
   
   #end add-point
   
   LET g_sql = "SELECT COUNT(glaacomp) FROM agli010_tmp ",
               " WHERE ",
                "glaacomp = ? AND ",
                "exp_code <> '-1' AND glaald <> glaacomp "
 
   PREPARE agli010_temp_chk FROM g_sql
 
   LET g_sql = "SELECT COUNT(1) FROM glaa_t ",
               " WHERE glaaent = " ||g_enterprise|| " AND ", 
               "glaald <> glaacomp AND ",
               "glaacomp = ? ",
               cl_sql_add_filter("glaa_t")
   
   PREPARE agli010_master_chk FROM g_sql
   
   CASE g_browser[pi_id].b_expcode 
      WHEN -1
         RETURN FALSE
      WHEN 0
         RETURN FALSE
      WHEN 1
         EXECUTE agli010_temp_chk 
           USING g_browser[pi_id].b_glaald
            INTO li_cnt
         FREE agli010_temp_chk
      WHEN 2 
         EXECUTE agli010_master_chk 
           USING g_browser[pi_id].b_glaald
            INTO li_cnt
         FREE agli010_master_chk
   END CASE
    
   IF li_cnt > 0 THEN
      RETURN TRUE
   ELSE
      RETURN FALSE
   END IF
 
END FUNCTION
 
{</section>}
 
{<section id="agli010.construct" >}
#+ QBE資料查詢
PRIVATE FUNCTION agli010_construct()
   #add-point:cs段define name="cs.define_customerization"
   
   #end add-point
   DEFINE ls_wc       STRING
   DEFINE ls_return   STRING
   DEFINE ls_result   STRING 
   #add-point:cs段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="cs.define"
#   DEFINE l_ld_str   STRING   #160811-00039#1   #160825-00017#1 mark
   #end add-point
   
   #add-point:Function前置處理  name="cs.pre_function"
#   LET g_site_str = NULL  #160811-00039#1 #160825-00017#1 mark
   #end add-point
   
   #清除畫面
   CLEAR FORM
   INITIALIZE g_glaa_m.* TO NULL
   INITIALIZE g_wc TO NULL
   LET g_qryparam.state = "c"
    
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
      CONSTRUCT BY NAME g_wc ON glaald,glaal002,glaacomp,glaa027,glaa026,glaa001,glaa002,glaa025,glaa028, 
          glaa003,glaa004,glaa024,glaa005,glaa006,glaa007,glaa014,glaa008,glaa023,glaa009,glaa130,glaa010, 
          glaa011,glaa012,glaa013,glaastus,glaa015,glaa019,glaa016,glaa020,glaa017,glaa021,glaa018,glaa022, 
          glaa100,glaa101,glaa102,glaa103,glaa111,glaa112,glaa113,glaa120,glaa121,glaa136,glaa137,glaa139, 
          glaa140,glaa122,glaa123,glaa124,glaa131,glaa132,glaa133,glaa134,glaa138,glaa135,glaaownid, 
          glaaowndp,glaacrtid,glaacrtdp,glaacrtdt,glaamodid,glaamoddt 
      
         BEFORE CONSTRUCT
            #add-point:cs段more_construct name="cs.before_construct"
            CALL cl_set_comp_visible("page_4",TRUE)   #合併報表#151113-00002#7 151117 by sakura add                         
            #end add-point 
            
         #應用 a11 樣板自動產生(Version:3)
         #共用欄位查詢處理  
         ##----<<glaacrtdt>>----
         AFTER FIELD glaacrtdt
            CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
            IF NOT cl_null(ls_result) THEN
               IF NOT cl_chk_date_symbol(ls_result) THEN
                  LET ls_result = cl_add_date_extra_cond(ls_result)
               END IF
            END IF
            CALL FGL_DIALOG_SETBUFFER(ls_result)
 
         #----<<glaamoddt>>----
         AFTER FIELD glaamoddt
            CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
            IF NOT cl_null(ls_result) THEN
               IF NOT cl_chk_date_symbol(ls_result) THEN
                  LET ls_result = cl_add_date_extra_cond(ls_result)
               END IF
            END IF
            CALL FGL_DIALOG_SETBUFFER(ls_result)
         
         #----<<glaacnfdt>>----
         
         #----<<glaapstdt>>----
 
 
 
 
                  #Ctrlp:construct.c.glaald
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glaald
            #add-point:ON ACTION controlp INFIELD glaald name="construct.c.glaald"
                                    #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
#160825-00017#1--mark--str--
#            #160811-00039#1--add--str--
#            CALL s_axrt300_get_site(g_user,g_site_str,'2') RETURNING l_ld_str
#            LET g_qryparam.where = l_ld_str
#            #160811-00039#1--add--end
#160825-00017#1--mark--end
            CALL q_glaa()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO glaald  #顯示到畫面上

            NEXT FIELD glaald                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glaald
            #add-point:BEFORE FIELD glaald name="construct.b.glaald"
                        
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glaald
            
            #add-point:AFTER FIELD glaald name="construct.a.glaald"
                        
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glaal002
            #add-point:BEFORE FIELD glaal002 name="construct.b.glaal002"
                        
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glaal002
            
            #add-point:AFTER FIELD glaal002 name="construct.a.glaal002"
                        
            #END add-point
            
 
 
         #Ctrlp:construct.c.glaal002
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glaal002
            #add-point:ON ACTION controlp INFIELD glaal002 name="construct.c.glaal002"
                        
            #END add-point
 
 
         #Ctrlp:construct.c.glaacomp
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glaacomp
            #add-point:ON ACTION controlp INFIELD glaacomp name="construct.c.glaacomp"
                                    #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooef001_2()                      #呼叫開窗
            DISPLAY g_qryparam.return1 TO glaacomp  #顯示到畫面上

            NEXT FIELD glaacomp                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glaacomp
            #add-point:BEFORE FIELD glaacomp name="construct.b.glaacomp"
                        
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glaacomp
            
            #add-point:AFTER FIELD glaacomp name="construct.a.glaacomp"
#            CALL FGL_DIALOG_GETBUFFER() RETURNING g_site_str  #160811-00039#1 #160825-00017#1 mark           
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glaa027
            #add-point:BEFORE FIELD glaa027 name="construct.b.glaa027"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glaa027
            
            #add-point:AFTER FIELD glaa027 name="construct.a.glaa027"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.glaa027
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glaa027
            #add-point:ON ACTION controlp INFIELD glaa027 name="construct.c.glaa027"
            
            #END add-point
 
 
         #Ctrlp:construct.c.glaa026
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glaa026
            #add-point:ON ACTION controlp INFIELD glaa026 name="construct.c.glaa026"
                                    #此段落由子樣板a08產生
            #開窗c段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			LET g_qryparam.reqry = FALSE
            CALL q_ooal002_10()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO glaa026  #顯示到畫面上

            NEXT FIELD glaa026                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glaa026
            #add-point:BEFORE FIELD glaa026 name="construct.b.glaa026"
                        
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glaa026
            
            #add-point:AFTER FIELD glaa026 name="construct.a.glaa026"
                        
            #END add-point
            
 
 
         #Ctrlp:construct.c.glaa001
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glaa001
            #add-point:ON ACTION controlp INFIELD glaa001 name="construct.c.glaa001"
                                    #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooai001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO glaa001  #顯示到畫面上

            NEXT FIELD glaa001                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glaa001
            #add-point:BEFORE FIELD glaa001 name="construct.b.glaa001"
                        
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glaa001
            
            #add-point:AFTER FIELD glaa001 name="construct.a.glaa001"
                        
            #END add-point
            
 
 
         #Ctrlp:construct.c.glaa002
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glaa002
            #add-point:ON ACTION controlp INFIELD glaa002 name="construct.c.glaa002"
                                    #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.where = " ooal001 = '1' "  #160122-00019#1 add
            CALL q_ooal002()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO glaa002  #顯示到畫面上

            NEXT FIELD glaa002                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glaa002
            #add-point:BEFORE FIELD glaa002 name="construct.b.glaa002"
                        
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glaa002
            
            #add-point:AFTER FIELD glaa002 name="construct.a.glaa002"
                        
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glaa025
            #add-point:BEFORE FIELD glaa025 name="construct.b.glaa025"
                        
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glaa025
            
            #add-point:AFTER FIELD glaa025 name="construct.a.glaa025"
                        
            #END add-point
            
 
 
         #Ctrlp:construct.c.glaa025
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glaa025
            #add-point:ON ACTION controlp INFIELD glaa025 name="construct.c.glaa025"
                        
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glaa028
            #add-point:BEFORE FIELD glaa028 name="construct.b.glaa028"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glaa028
            
            #add-point:AFTER FIELD glaa028 name="construct.a.glaa028"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.glaa028
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glaa028
            #add-point:ON ACTION controlp INFIELD glaa028 name="construct.c.glaa028"
            
            #END add-point
 
 
         #Ctrlp:construct.c.glaa003
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glaa003
            #add-point:ON ACTION controlp INFIELD glaa003 name="construct.c.glaa003"
                                    #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_glav001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO glaa003  #顯示到畫面上

            NEXT FIELD glaa003                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glaa003
            #add-point:BEFORE FIELD glaa003 name="construct.b.glaa003"
                        
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glaa003
            
            #add-point:AFTER FIELD glaa003 name="construct.a.glaa003"
                        
            #END add-point
            
 
 
         #Ctrlp:construct.c.glaa004
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glaa004
            #add-point:ON ACTION controlp INFIELD glaa004 name="construct.c.glaa004"
                                    #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.where = " ooal001 = '0' "  #160122-00019#1 add
            CALL q_ooal002()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO glaa004  #顯示到畫面上

            NEXT FIELD glaa004                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glaa004
            #add-point:BEFORE FIELD glaa004 name="construct.b.glaa004"
                        
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glaa004
            
            #add-point:AFTER FIELD glaa004 name="construct.a.glaa004"
                        
            #END add-point
            
 
 
         #Ctrlp:construct.c.glaa024
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glaa024
            #add-point:ON ACTION controlp INFIELD glaa024 name="construct.c.glaa024"
                                    #此段落由子樣板a08產生
            #開窗c段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			LET g_qryparam.reqry = FALSE
			   LET g_qryparam.where = " ooal001 = '3' "  #160122-00019#1 add
            CALL q_ooal002()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO glaa024  #顯示到畫面上

            NEXT FIELD glaa024                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glaa024
            #add-point:BEFORE FIELD glaa024 name="construct.b.glaa024"
                        
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glaa024
            
            #add-point:AFTER FIELD glaa024 name="construct.a.glaa024"
                        
            #END add-point
            
 
 
         #Ctrlp:construct.c.glaa005
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glaa005
            #add-point:ON ACTION controlp INFIELD glaa005 name="construct.c.glaa005"
                                    #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.where = " ooal001 = '8' "  #160122-00019#1 add
            CALL q_ooal002()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO glaa005  #顯示到畫面上

            NEXT FIELD glaa005                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glaa005
            #add-point:BEFORE FIELD glaa005 name="construct.b.glaa005"
                        
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glaa005
            
            #add-point:AFTER FIELD glaa005 name="construct.a.glaa005"
                        
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glaa006
            #add-point:BEFORE FIELD glaa006 name="construct.b.glaa006"
                        
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glaa006
            
            #add-point:AFTER FIELD glaa006 name="construct.a.glaa006"
                        
            #END add-point
            
 
 
         #Ctrlp:construct.c.glaa006
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glaa006
            #add-point:ON ACTION controlp INFIELD glaa006 name="construct.c.glaa006"
                        
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glaa007
            #add-point:BEFORE FIELD glaa007 name="construct.b.glaa007"
                        
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glaa007
            
            #add-point:AFTER FIELD glaa007 name="construct.a.glaa007"
                        
            #END add-point
            
 
 
         #Ctrlp:construct.c.glaa007
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glaa007
            #add-point:ON ACTION controlp INFIELD glaa007 name="construct.c.glaa007"
                        
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glaa014
            #add-point:BEFORE FIELD glaa014 name="construct.b.glaa014"
                        
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glaa014
            
            #add-point:AFTER FIELD glaa014 name="construct.a.glaa014"
                        
            #END add-point
            
 
 
         #Ctrlp:construct.c.glaa014
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glaa014
            #add-point:ON ACTION controlp INFIELD glaa014 name="construct.c.glaa014"
                        
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glaa008
            #add-point:BEFORE FIELD glaa008 name="construct.b.glaa008"
                        
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glaa008
            
            #add-point:AFTER FIELD glaa008 name="construct.a.glaa008"
                        
            #END add-point
            
 
 
         #Ctrlp:construct.c.glaa008
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glaa008
            #add-point:ON ACTION controlp INFIELD glaa008 name="construct.c.glaa008"
                        
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glaa023
            #add-point:BEFORE FIELD glaa023 name="construct.b.glaa023"
                        
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glaa023
            
            #add-point:AFTER FIELD glaa023 name="construct.a.glaa023"
                        
            #END add-point
            
 
 
         #Ctrlp:construct.c.glaa023
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glaa023
            #add-point:ON ACTION controlp INFIELD glaa023 name="construct.c.glaa023"
                        
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glaa009
            #add-point:BEFORE FIELD glaa009 name="construct.b.glaa009"
                        
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glaa009
            
            #add-point:AFTER FIELD glaa009 name="construct.a.glaa009"
                        
            #END add-point
            
 
 
         #Ctrlp:construct.c.glaa009
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glaa009
            #add-point:ON ACTION controlp INFIELD glaa009 name="construct.c.glaa009"
                        
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glaa130
            #add-point:BEFORE FIELD glaa130 name="construct.b.glaa130"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glaa130
            
            #add-point:AFTER FIELD glaa130 name="construct.a.glaa130"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.glaa130
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glaa130
            #add-point:ON ACTION controlp INFIELD glaa130 name="construct.c.glaa130"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glaa010
            #add-point:BEFORE FIELD glaa010 name="construct.b.glaa010"
                        
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glaa010
            
            #add-point:AFTER FIELD glaa010 name="construct.a.glaa010"
                        
            #END add-point
            
 
 
         #Ctrlp:construct.c.glaa010
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glaa010
            #add-point:ON ACTION controlp INFIELD glaa010 name="construct.c.glaa010"
                        
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glaa011
            #add-point:BEFORE FIELD glaa011 name="construct.b.glaa011"
                        
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glaa011
            
            #add-point:AFTER FIELD glaa011 name="construct.a.glaa011"
                        
            #END add-point
            
 
 
         #Ctrlp:construct.c.glaa011
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glaa011
            #add-point:ON ACTION controlp INFIELD glaa011 name="construct.c.glaa011"
                        
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glaa012
            #add-point:BEFORE FIELD glaa012 name="construct.b.glaa012"
                        
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glaa012
            
            #add-point:AFTER FIELD glaa012 name="construct.a.glaa012"
                        
            #END add-point
            
 
 
         #Ctrlp:construct.c.glaa012
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glaa012
            #add-point:ON ACTION controlp INFIELD glaa012 name="construct.c.glaa012"
                        
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glaa013
            #add-point:BEFORE FIELD glaa013 name="construct.b.glaa013"
                        
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glaa013
            
            #add-point:AFTER FIELD glaa013 name="construct.a.glaa013"
                        
            #END add-point
            
 
 
         #Ctrlp:construct.c.glaa013
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glaa013
            #add-point:ON ACTION controlp INFIELD glaa013 name="construct.c.glaa013"
                        
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glaastus
            #add-point:BEFORE FIELD glaastus name="construct.b.glaastus"
                        
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glaastus
            
            #add-point:AFTER FIELD glaastus name="construct.a.glaastus"
                        
            #END add-point
            
 
 
         #Ctrlp:construct.c.glaastus
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glaastus
            #add-point:ON ACTION controlp INFIELD glaastus name="construct.c.glaastus"
                        
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glaa015
            #add-point:BEFORE FIELD glaa015 name="construct.b.glaa015"
                        
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glaa015
            
            #add-point:AFTER FIELD glaa015 name="construct.a.glaa015"
                        
            #END add-point
            
 
 
         #Ctrlp:construct.c.glaa015
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glaa015
            #add-point:ON ACTION controlp INFIELD glaa015 name="construct.c.glaa015"
                        
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glaa019
            #add-point:BEFORE FIELD glaa019 name="construct.b.glaa019"
                        
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glaa019
            
            #add-point:AFTER FIELD glaa019 name="construct.a.glaa019"
                        
            #END add-point
            
 
 
         #Ctrlp:construct.c.glaa019
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glaa019
            #add-point:ON ACTION controlp INFIELD glaa019 name="construct.c.glaa019"
                        
            #END add-point
 
 
         #Ctrlp:construct.c.glaa016
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glaa016
            #add-point:ON ACTION controlp INFIELD glaa016 name="construct.c.glaa016"
                                    #此段落由子樣板a08產生
            #開窗c段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			LET g_qryparam.reqry = FALSE
            CALL q_ooai001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO glaa016  #顯示到畫面上

            NEXT FIELD glaa016                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glaa016
            #add-point:BEFORE FIELD glaa016 name="construct.b.glaa016"
                        
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glaa016
            
            #add-point:AFTER FIELD glaa016 name="construct.a.glaa016"
                        
            #END add-point
            
 
 
         #Ctrlp:construct.c.glaa020
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glaa020
            #add-point:ON ACTION controlp INFIELD glaa020 name="construct.c.glaa020"
                                    #此段落由子樣板a08產生
            #開窗c段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			LET g_qryparam.reqry = FALSE
            CALL q_ooai001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO glaa020  #顯示到畫面上

            NEXT FIELD glaa020                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glaa020
            #add-point:BEFORE FIELD glaa020 name="construct.b.glaa020"
                        
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glaa020
            
            #add-point:AFTER FIELD glaa020 name="construct.a.glaa020"
                        
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glaa017
            #add-point:BEFORE FIELD glaa017 name="construct.b.glaa017"
                        
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glaa017
            
            #add-point:AFTER FIELD glaa017 name="construct.a.glaa017"
                        
            #END add-point
            
 
 
         #Ctrlp:construct.c.glaa017
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glaa017
            #add-point:ON ACTION controlp INFIELD glaa017 name="construct.c.glaa017"
                        
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glaa021
            #add-point:BEFORE FIELD glaa021 name="construct.b.glaa021"
                        
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glaa021
            
            #add-point:AFTER FIELD glaa021 name="construct.a.glaa021"
                        
            #END add-point
            
 
 
         #Ctrlp:construct.c.glaa021
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glaa021
            #add-point:ON ACTION controlp INFIELD glaa021 name="construct.c.glaa021"
                        
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glaa018
            #add-point:BEFORE FIELD glaa018 name="construct.b.glaa018"
                        
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glaa018
            
            #add-point:AFTER FIELD glaa018 name="construct.a.glaa018"
                        
            #END add-point
            
 
 
         #Ctrlp:construct.c.glaa018
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glaa018
            #add-point:ON ACTION controlp INFIELD glaa018 name="construct.c.glaa018"
                        
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glaa022
            #add-point:BEFORE FIELD glaa022 name="construct.b.glaa022"
                        
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glaa022
            
            #add-point:AFTER FIELD glaa022 name="construct.a.glaa022"
                        
            #END add-point
            
 
 
         #Ctrlp:construct.c.glaa022
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glaa022
            #add-point:ON ACTION controlp INFIELD glaa022 name="construct.c.glaa022"
                        
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glaa100
            #add-point:BEFORE FIELD glaa100 name="construct.b.glaa100"
                        
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glaa100
            
            #add-point:AFTER FIELD glaa100 name="construct.a.glaa100"
                        
            #END add-point
            
 
 
         #Ctrlp:construct.c.glaa100
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glaa100
            #add-point:ON ACTION controlp INFIELD glaa100 name="construct.c.glaa100"
                        
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glaa101
            #add-point:BEFORE FIELD glaa101 name="construct.b.glaa101"
                        
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glaa101
            
            #add-point:AFTER FIELD glaa101 name="construct.a.glaa101"
                        
            #END add-point
            
 
 
         #Ctrlp:construct.c.glaa101
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glaa101
            #add-point:ON ACTION controlp INFIELD glaa101 name="construct.c.glaa101"
                        
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glaa102
            #add-point:BEFORE FIELD glaa102 name="construct.b.glaa102"
                        
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glaa102
            
            #add-point:AFTER FIELD glaa102 name="construct.a.glaa102"
                        
            #END add-point
            
 
 
         #Ctrlp:construct.c.glaa102
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glaa102
            #add-point:ON ACTION controlp INFIELD glaa102 name="construct.c.glaa102"
                        
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glaa103
            #add-point:BEFORE FIELD glaa103 name="construct.b.glaa103"
                        
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glaa103
            
            #add-point:AFTER FIELD glaa103 name="construct.a.glaa103"
                        
            #END add-point
            
 
 
         #Ctrlp:construct.c.glaa103
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glaa103
            #add-point:ON ACTION controlp INFIELD glaa103 name="construct.c.glaa103"
                        
            #END add-point
 
 
         #Ctrlp:construct.c.glaa111
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glaa111
            #add-point:ON ACTION controlp INFIELD glaa111 name="construct.c.glaa111"
                                    #此段落由子樣板a08產生
            #開窗c段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			LET g_qryparam.reqry = FALSE
            CALL q_ooba002_05()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO glaa111  #顯示到畫面上

            NEXT FIELD glaa111                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glaa111
            #add-point:BEFORE FIELD glaa111 name="construct.b.glaa111"
                        
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glaa111
            
            #add-point:AFTER FIELD glaa111 name="construct.a.glaa111"
                        
            #END add-point
            
 
 
         #Ctrlp:construct.c.glaa112
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glaa112
            #add-point:ON ACTION controlp INFIELD glaa112 name="construct.c.glaa112"
                                    #此段落由子樣板a08產生
            #開窗c段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			LET g_qryparam.reqry = FALSE
            CALL q_ooba002_05()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO glaa112  #顯示到畫面上

            NEXT FIELD glaa112                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glaa112
            #add-point:BEFORE FIELD glaa112 name="construct.b.glaa112"
                        
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glaa112
            
            #add-point:AFTER FIELD glaa112 name="construct.a.glaa112"
                        
            #END add-point
            
 
 
         #Ctrlp:construct.c.glaa113
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glaa113
            #add-point:ON ACTION controlp INFIELD glaa113 name="construct.c.glaa113"
                                    #此段落由子樣板a08產生
            #開窗c段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			LET g_qryparam.reqry = FALSE
            CALL q_ooba002_05()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO glaa113  #顯示到畫面上

            NEXT FIELD glaa113                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glaa113
            #add-point:BEFORE FIELD glaa113 name="construct.b.glaa113"
                        
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glaa113
            
            #add-point:AFTER FIELD glaa113 name="construct.a.glaa113"
                        
            #END add-point
            
 
 
         #Ctrlp:construct.c.glaa120
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glaa120
            #add-point:ON ACTION controlp INFIELD glaa120 name="construct.c.glaa120"
                                    #此段落由子樣板a08產生
            #開窗c段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			LET g_qryparam.reqry = FALSE
#			   CALL q_xcat001()           #150721-00009#1 mark
           #CALL q_xcaz001()                           #呼叫開窗  #170210-00013#1 mark
            CALL q_xcaz001_1()         #170210-00013#1 add xul
            DISPLAY g_qryparam.return1 TO glaa120  #顯示到畫面上

            NEXT FIELD glaa120                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glaa120
            #add-point:BEFORE FIELD glaa120 name="construct.b.glaa120"
                        
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glaa120
            
            #add-point:AFTER FIELD glaa120 name="construct.a.glaa120"
                        
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glaa121
            #add-point:BEFORE FIELD glaa121 name="construct.b.glaa121"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glaa121
            
            #add-point:AFTER FIELD glaa121 name="construct.a.glaa121"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.glaa121
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glaa121
            #add-point:ON ACTION controlp INFIELD glaa121 name="construct.c.glaa121"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glaa136
            #add-point:BEFORE FIELD glaa136 name="construct.b.glaa136"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glaa136
            
            #add-point:AFTER FIELD glaa136 name="construct.a.glaa136"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.glaa136
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glaa136
            #add-point:ON ACTION controlp INFIELD glaa136 name="construct.c.glaa136"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glaa137
            #add-point:BEFORE FIELD glaa137 name="construct.b.glaa137"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glaa137
            
            #add-point:AFTER FIELD glaa137 name="construct.a.glaa137"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.glaa137
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glaa137
            #add-point:ON ACTION controlp INFIELD glaa137 name="construct.c.glaa137"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glaa139
            #add-point:BEFORE FIELD glaa139 name="construct.b.glaa139"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glaa139
            
            #add-point:AFTER FIELD glaa139 name="construct.a.glaa139"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.glaa139
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glaa139
            #add-point:ON ACTION controlp INFIELD glaa139 name="construct.c.glaa139"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glaa140
            #add-point:BEFORE FIELD glaa140 name="construct.b.glaa140"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glaa140
            
            #add-point:AFTER FIELD glaa140 name="construct.a.glaa140"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.glaa140
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glaa140
            #add-point:ON ACTION controlp INFIELD glaa140 name="construct.c.glaa140"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glaa122
            #add-point:BEFORE FIELD glaa122 name="construct.b.glaa122"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glaa122
            
            #add-point:AFTER FIELD glaa122 name="construct.a.glaa122"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.glaa122
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glaa122
            #add-point:ON ACTION controlp INFIELD glaa122 name="construct.c.glaa122"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glaa123
            #add-point:BEFORE FIELD glaa123 name="construct.b.glaa123"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glaa123
            
            #add-point:AFTER FIELD glaa123 name="construct.a.glaa123"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.glaa123
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glaa123
            #add-point:ON ACTION controlp INFIELD glaa123 name="construct.c.glaa123"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glaa124
            #add-point:BEFORE FIELD glaa124 name="construct.b.glaa124"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glaa124
            
            #add-point:AFTER FIELD glaa124 name="construct.a.glaa124"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.glaa124
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glaa124
            #add-point:ON ACTION controlp INFIELD glaa124 name="construct.c.glaa124"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glaa131
            #add-point:BEFORE FIELD glaa131 name="construct.b.glaa131"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glaa131
            
            #add-point:AFTER FIELD glaa131 name="construct.a.glaa131"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.glaa131
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glaa131
            #add-point:ON ACTION controlp INFIELD glaa131 name="construct.c.glaa131"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glaa132
            #add-point:BEFORE FIELD glaa132 name="construct.b.glaa132"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glaa132
            
            #add-point:AFTER FIELD glaa132 name="construct.a.glaa132"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.glaa132
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glaa132
            #add-point:ON ACTION controlp INFIELD glaa132 name="construct.c.glaa132"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glaa133
            #add-point:BEFORE FIELD glaa133 name="construct.b.glaa133"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glaa133
            
            #add-point:AFTER FIELD glaa133 name="construct.a.glaa133"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.glaa133
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glaa133
            #add-point:ON ACTION controlp INFIELD glaa133 name="construct.c.glaa133"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glaa134
            #add-point:BEFORE FIELD glaa134 name="construct.b.glaa134"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glaa134
            
            #add-point:AFTER FIELD glaa134 name="construct.a.glaa134"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.glaa134
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glaa134
            #add-point:ON ACTION controlp INFIELD glaa134 name="construct.c.glaa134"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glaa138
            #add-point:BEFORE FIELD glaa138 name="construct.b.glaa138"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glaa138
            
            #add-point:AFTER FIELD glaa138 name="construct.a.glaa138"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.glaa138
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glaa138
            #add-point:ON ACTION controlp INFIELD glaa138 name="construct.c.glaa138"
            
            #END add-point
 
 
         #Ctrlp:construct.c.glaa135
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glaa135
            #add-point:ON ACTION controlp INFIELD glaa135 name="construct.c.glaa135"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.arg1 = '16'
            CALL q_ooal002_0()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO glaa135  #顯示到畫面上
            NEXT FIELD glaa135                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glaa135
            #add-point:BEFORE FIELD glaa135 name="construct.b.glaa135"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glaa135
            
            #add-point:AFTER FIELD glaa135 name="construct.a.glaa135"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.glaaownid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glaaownid
            #add-point:ON ACTION controlp INFIELD glaaownid name="construct.c.glaaownid"
                                    #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO glaaownid  #顯示到畫面上

            NEXT FIELD glaaownid                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glaaownid
            #add-point:BEFORE FIELD glaaownid name="construct.b.glaaownid"
                        
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glaaownid
            
            #add-point:AFTER FIELD glaaownid name="construct.a.glaaownid"
                        
            #END add-point
            
 
 
         #Ctrlp:construct.c.glaaowndp
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glaaowndp
            #add-point:ON ACTION controlp INFIELD glaaowndp name="construct.c.glaaowndp"
                                    #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooeg001_9()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO glaaowndp  #顯示到畫面上

            NEXT FIELD glaaowndp                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glaaowndp
            #add-point:BEFORE FIELD glaaowndp name="construct.b.glaaowndp"
                        
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glaaowndp
            
            #add-point:AFTER FIELD glaaowndp name="construct.a.glaaowndp"
                        
            #END add-point
            
 
 
         #Ctrlp:construct.c.glaacrtid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glaacrtid
            #add-point:ON ACTION controlp INFIELD glaacrtid name="construct.c.glaacrtid"
                                    #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO glaacrtid  #顯示到畫面上

            NEXT FIELD glaacrtid                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glaacrtid
            #add-point:BEFORE FIELD glaacrtid name="construct.b.glaacrtid"
                        
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glaacrtid
            
            #add-point:AFTER FIELD glaacrtid name="construct.a.glaacrtid"
                        
            #END add-point
            
 
 
         #Ctrlp:construct.c.glaacrtdp
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glaacrtdp
            #add-point:ON ACTION controlp INFIELD glaacrtdp name="construct.c.glaacrtdp"
                                    #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooeg001_9()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO glaacrtdp  #顯示到畫面上

            NEXT FIELD glaacrtdp                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glaacrtdp
            #add-point:BEFORE FIELD glaacrtdp name="construct.b.glaacrtdp"
                        
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glaacrtdp
            
            #add-point:AFTER FIELD glaacrtdp name="construct.a.glaacrtdp"
                        
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glaacrtdt
            #add-point:BEFORE FIELD glaacrtdt name="construct.b.glaacrtdt"
                        
            #END add-point
 
 
         #Ctrlp:construct.c.glaamodid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glaamodid
            #add-point:ON ACTION controlp INFIELD glaamodid name="construct.c.glaamodid"
                                    #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO glaamodid  #顯示到畫面上

            NEXT FIELD glaamodid                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glaamodid
            #add-point:BEFORE FIELD glaamodid name="construct.b.glaamodid"
                        
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glaamodid
            
            #add-point:AFTER FIELD glaamodid name="construct.a.glaamodid"
                        
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glaamoddt
            #add-point:BEFORE FIELD glaamoddt name="construct.b.glaamoddt"
                        
            #END add-point
 
 
 
       
      END CONSTRUCT
  
      #add-point:cs段more_construct name="cs.more_construct"
            
      #end add-point
         
      BEFORE DIALOG
         CALL cl_qbe_init()
         #add-point:cs段before dialog name="cs.before_dialog"
         
         #end add-point
      
      ON ACTION qbe_select     #條件查詢
         CALL cl_qbe_list('m') RETURNING ls_wc
      
      ON ACTION qbe_save       #條件儲存
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
 
   #add-point:cs段after_construct name="cs.after_construct"
 
   #end add-point
   
   IF INT_FLAG THEN
      RETURN
   END IF
 
END FUNCTION
 
{</section>}
 
{<section id="agli010.query" >}
#+ 資料查詢QBE功能準備
PRIVATE FUNCTION agli010_query()
   #add-point:query段define name="query.define_customerization"
   
   #end add-point
   DEFINE ls_wc STRING
   #add-point:query段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="query.define"
      
   #end add-point
   
   #add-point:Function前置處理  name="query.before_query"
  
   #end add-point
   
   #切換畫面
   IF g_main_hidden THEN
      CALL gfrm_curr.setElementHidden("mainlayout",0)
      CALL gfrm_curr.setElementHidden("worksheet",1)
      LET g_main_hidden = 0
   END IF
   
   LET INT_FLAG = 0
   LET ls_wc = g_wc
 
   #CLEAR FORM
   #CALL g_browser.clear()
 
   DISPLAY " " TO FORMONLY.h_count
 
   CALL agli010_construct()
 
   IF INT_FLAG THEN
      #取消查詢
      LET INT_FLAG = 0
      #LET g_wc = ls_wc
      LET g_wc = " 1=2"
      #add-point:query段取消 name="query.cancel"
            
      #end add-point
      #CALL agli010_browser_fill(g_wc,g_searchtype)
      CALL agli010_fetch("")
      RETURN
   ELSE
      LET g_current_row = 1
      LET g_browser_cnt = 0
      LET g_current_idx = 1
      CALL g_browser.clear()
      LET g_first = 0  #設定重新查詢資料後顯示
   END IF
 
   LET g_searchtype = "3"
   LET g_searchcol = "0"
   CALL agli010_browser_fill(g_wc,g_searchtype)
   
   IF g_browser_cnt > 0 THEN
      CALL agli010_fetch("")
   ELSE
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code = "-100" 
      LET g_errparam.popup = TRUE 
      CALL cl_err()
      RETURN
   END IF
   
   #第一層模糊搜尋
   #IF g_browser_cnt = 0 THEN
   #   LET g_wc = cl_wc_parser(g_wc)
   #   CALL agli010_browser_fill(g_wc,g_searchtype)
   #END IF
   
   #第二層速記碼搜尋
   #IF g_browser_cnt = 0 THEN
   #   INITIALIZE g_errparam TO NULL 
   #   LET g_errparam.extend = "" 
   #   LET g_errparam.code = "-100" 
   #   LET g_errparam.popup = TRUE 
   #   CALL cl_err()
   #END IF
 
END FUNCTION
 
{</section>}
 
{<section id="agli010.fetch" >}
#+ 指定PK後抓取單頭其他資料
PRIVATE FUNCTION agli010_fetch(p_flag)
   #add-point:fetch段define name="fetch.define_customerization"
   
   #end add-point
   DEFINE p_flag     LIKE type_t.chr1
   DEFINE ls_msg     STRING
   DEFINE ls_chk     STRING
   DEFINE li_idx     LIKE type_t.num10
   #add-point:fetch段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="fetch.define"
      
   #end add-point
   
   #add-point:Function前置處理  name="fetch.befroe_fetch"
      
   #end add-point 
 
 
   #瀏覽頁筆數顯示
   LET li_idx = 1
   FOR li_idx = 1 TO g_browser_root.getLength()
      IF g_browser_root[li_idx] > g_current_idx THEN
       EXIT FOR
      END IF
   END FOR
   LET li_idx = g_current_idx - li_idx + 1
   #DISPLAY li_idx TO FORMONLY.h_index   #當下筆數
 
   IF p_flag = "/" THEN
      IF (NOT g_no_ask) THEN      
         CALL cl_getmsg("fetch",g_lang) RETURNING ls_msg
         LET INT_FLAG = 0
 
         PROMPT ls_msg CLIPPED,": " FOR g_jump
            #交談指令共用ACTION
            &include "common_action.4gl" 
         END PROMPT
 
         IF INT_FLAG THEN
            LET INT_FLAG = 0
         ELSE
            IF g_jump > 0 AND g_jump <= g_browser.getLength() THEN
               LET g_current_idx = g_jump
            END IF
            LET g_no_ask = FALSE  
         END IF           
      END IF
   END IF    
   
   #若無資料則離開
   IF g_current_idx = 0 THEN
      RETURN
   END IF
 
   LET g_glaa_m.glaald = g_browser[g_current_idx].b_glaald
   LET g_glaa_m.glaacomp = g_browser[g_current_idx].b_glaacomp
    
   #add-point:fetch段refresh前 name="fetch.before_refresh"
   IF cl_null(g_glaa_m.glaald) THEN
      LET g_glaa_m.glaald=g_glaald_ins
      LET g_glaald_ins=NULL
   END IF
   IF cl_null(g_glaa_m.glaald) OR cl_null(g_glaa_m.glaacomp) THEN
      RETURN
   END IF 
   #end add-point
    
   #重讀DB,因TEMP有不被更新特性
   EXECUTE agli010_master_referesh USING g_glaa_m.glaald INTO g_glaa_m.glaald,g_glaa_m.glaacomp,g_glaa_m.glaa027, 
       g_glaa_m.glaa026,g_glaa_m.glaa001,g_glaa_m.glaa002,g_glaa_m.glaa025,g_glaa_m.glaa028,g_glaa_m.glaa003, 
       g_glaa_m.glaa004,g_glaa_m.glaa024,g_glaa_m.glaa005,g_glaa_m.glaa006,g_glaa_m.glaa007,g_glaa_m.glaa014, 
       g_glaa_m.glaa008,g_glaa_m.glaa023,g_glaa_m.glaa009,g_glaa_m.glaa130,g_glaa_m.glaa010,g_glaa_m.glaa011, 
       g_glaa_m.glaa012,g_glaa_m.glaa013,g_glaa_m.glaastus,g_glaa_m.glaa015,g_glaa_m.glaa019,g_glaa_m.glaa016, 
       g_glaa_m.glaa020,g_glaa_m.glaa017,g_glaa_m.glaa021,g_glaa_m.glaa018,g_glaa_m.glaa022,g_glaa_m.glaa100, 
       g_glaa_m.glaa101,g_glaa_m.glaa102,g_glaa_m.glaa103,g_glaa_m.glaa111,g_glaa_m.glaa112,g_glaa_m.glaa113, 
       g_glaa_m.glaa120,g_glaa_m.glaa121,g_glaa_m.glaa136,g_glaa_m.glaa137,g_glaa_m.glaa139,g_glaa_m.glaa140, 
       g_glaa_m.glaa122,g_glaa_m.glaa123,g_glaa_m.glaa124,g_glaa_m.glaa131,g_glaa_m.glaa132,g_glaa_m.glaa133, 
       g_glaa_m.glaa134,g_glaa_m.glaa138,g_glaa_m.glaa135,g_glaa_m.glaaownid,g_glaa_m.glaaowndp,g_glaa_m.glaacrtid, 
       g_glaa_m.glaacrtdp,g_glaa_m.glaacrtdt,g_glaa_m.glaamodid,g_glaa_m.glaamoddt,g_glaa_m.glaacomp_desc, 
       g_glaa_m.glaa026_desc,g_glaa_m.glaa001_desc,g_glaa_m.glaa002_desc,g_glaa_m.glaa003_desc,g_glaa_m.glaa004_desc, 
       g_glaa_m.glaa024_desc,g_glaa_m.glaa005_desc,g_glaa_m.glaa111_desc,g_glaa_m.glaa112_desc,g_glaa_m.glaa113_desc, 
       g_glaa_m.glaa120_desc,g_glaa_m.glaa135_desc,g_glaa_m.glaaownid_desc,g_glaa_m.glaaowndp_desc,g_glaa_m.glaacrtid_desc, 
       g_glaa_m.glaacrtdp_desc,g_glaa_m.glaamodid_desc 
   
   IF SQLCA.SQLCODE THEN
       INITIALIZE g_errparam TO NULL 
       LET g_errparam.extend = "glaa_t:",SQLERRMESSAGE 
       LET g_errparam.code = SQLCA.SQLCODE 
       LET g_errparam.popup = TRUE 
       CALL cl_err()
       INITIALIZE g_glaa_m.* TO NULL
       RETURN
   END IF
   
   #若無資料則關閉相關功能
   IF g_browser.getLength() = 0 THEN
      CALL cl_set_act_visible("statechange,modify,delete,reproduce", FALSE)
   ELSE
      CALL cl_set_act_visible("statechange,modify,delete,reproduce", TRUE)
   END IF
   
   #add-point:fetch段after_fetch name="fetch.after_fetch"
     
   #end add-point
 
   
   
   #保存單頭舊值
   LET g_glaa_m_t.* = g_glaa_m.*
   LET g_glaa_m_o.* = g_glaa_m.*
   
   #重新顯示
   CALL agli010_show()
   CALL cl_navigator_setting(g_current_idx, g_browser_cnt)
   DISPLAY g_browser.getLength() TO FORMONLY.h_count 
 
   
   
END FUNCTION
 
{</section>}
 
{<section id="agli010.insert" >}
#+ 資料新增
PRIVATE FUNCTION agli010_insert(l_dialog)
   #add-point:insert段define name="insert.define_customerization"
   
   #end add-point
   DEFINE l_dialog   ui.DIALOG
   DEFINE li_addpos  LIKE type_t.num10 #新增節點時產出的畫面實際位置
   DEFINE li_idx     LIKE type_t.num10
   DEFINE li_cnt     LIKE type_t.num10
   #add-point:insert段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="insert.define"
         DEFINE l_success  LIKE type_t.num5
   #end add-point
   
   #add-point:Function前置處理  name="insert.pre_function"
   
   #end add-point
   
   LET g_glaald_t = g_glaa_m.glaald
 
   LET g_glaald_t = g_glaa_m.glaald
 
   #清畫面欄位內容
   CLEAR g_glaa_m.*
 
 
   #add-point:單頭預設值 name="insert.before_insert"
      
   #end add-point 
 
   INITIALIZE g_glaa_m.* LIKE glaa_t.*
   DISPLAY BY NAME g_glaa_m.glaald,g_glaa_m.glaal002,g_glaa_m.glaacomp,g_glaa_m.glaacomp_desc,g_glaa_m.glaa027, 
       g_glaa_m.glaa026,g_glaa_m.glaa026_desc,g_glaa_m.glaa001,g_glaa_m.glaa001_desc,g_glaa_m.glaa002, 
       g_glaa_m.glaa002_desc,g_glaa_m.glaa025,g_glaa_m.glaa028,g_glaa_m.glaa003,g_glaa_m.glaa003_desc, 
       g_glaa_m.glaa004,g_glaa_m.glaa004_desc,g_glaa_m.glaa024,g_glaa_m.glaa024_desc,g_glaa_m.glaa005, 
       g_glaa_m.glaa005_desc,g_glaa_m.glaa006,g_glaa_m.glaa007,g_glaa_m.glaa014,g_glaa_m.glaa008,g_glaa_m.glaa023, 
       g_glaa_m.glaa009,g_glaa_m.glaa130,g_glaa_m.glaa010,g_glaa_m.glaa011,g_glaa_m.glaa012,g_glaa_m.glaa013, 
       g_glaa_m.glaastus,g_glaa_m.glaa015,g_glaa_m.fflabel1_desc,g_glaa_m.glaa019,g_glaa_m.glaa016,g_glaa_m.glaa020, 
       g_glaa_m.glaa017,g_glaa_m.glaa021,g_glaa_m.glaa018,g_glaa_m.glaa022,g_glaa_m.fflabe7_desc,g_glaa_m.fflabel8_desc, 
       g_glaa_m.glaa100,g_glaa_m.glaa101,g_glaa_m.glaa102,g_glaa_m.glaa103,g_glaa_m.glaa111,g_glaa_m.glaa111_desc, 
       g_glaa_m.glaa112,g_glaa_m.glaa112_desc,g_glaa_m.glaa113,g_glaa_m.glaa113_desc,g_glaa_m.glaa120, 
       g_glaa_m.glaa120_desc,g_glaa_m.glaa121,g_glaa_m.glaa136,g_glaa_m.glaa137,g_glaa_m.glaa139,g_glaa_m.glaa140, 
       g_glaa_m.glaa122,g_glaa_m.glaa123,g_glaa_m.glaa124,g_glaa_m.glaa131,g_glaa_m.glaa132,g_glaa_m.glaa133, 
       g_glaa_m.glaa134,g_glaa_m.glaa138,g_glaa_m.glaa135,g_glaa_m.glaa135_desc,g_glaa_m.glaaownid,g_glaa_m.glaaownid_desc, 
       g_glaa_m.glaaowndp,g_glaa_m.glaaowndp_desc,g_glaa_m.glaacrtid,g_glaa_m.glaacrtid_desc,g_glaa_m.glaacrtdp, 
       g_glaa_m.glaacrtdp_desc,g_glaa_m.glaacrtdt,g_glaa_m.glaamodid,g_glaa_m.glaamodid_desc,g_glaa_m.glaamoddt 
 
   CALL s_transaction_begin()
 
   #其他table資料備份(確定是否更改用)
   LET g_master_multi_table_t.glaalld = g_glaa_m.glaald
LET g_master_multi_table_t.glaal002 = g_glaa_m.glaal002
 
 
   WHILE TRUE
      #給予pid,type預設值
      LET g_glaa_m.glaacomp = g_glaald_t
      #應用 a14 樣板自動產生(Version:5)    
      #公用欄位新增給值  
      LET g_glaa_m.glaaownid = g_user
      LET g_glaa_m.glaaowndp = g_dept
      LET g_glaa_m.glaacrtid = g_user
      LET g_glaa_m.glaacrtdp = g_dept 
      LET g_glaa_m.glaacrtdt = cl_get_current()
      LET g_glaa_m.glaamodid = g_user
      LET g_glaa_m.glaamoddt = cl_get_current()
      LET g_glaa_m.glaastus = 'Y'
 
 
 
      
      CALL gfrm_curr.setElementImage("statechange", "authstatus/valid.png")
  
      
      
      #單頭預設值
            LET g_glaa_m.glaa028 = "1"
      LET g_glaa_m.glaa006 = "1"
      LET g_glaa_m.glaa007 = "1"
      LET g_glaa_m.glaa014 = "N"
      LET g_glaa_m.glaa008 = "N"
      LET g_glaa_m.glaa023 = "1"
      LET g_glaa_m.glaa009 = "1"
      LET g_glaa_m.glaa130 = "N"
      LET g_glaa_m.glaastus = "Y"
      LET g_glaa_m.glaa015 = "N"
      LET g_glaa_m.glaa019 = "N"
      LET g_glaa_m.glaa017 = "1"
      LET g_glaa_m.glaa021 = "1"
      LET g_glaa_m.glaa100 = "N"
      LET g_glaa_m.glaa101 = "2"
      LET g_glaa_m.glaa102 = "1"
      LET g_glaa_m.glaa103 = "N"
      LET g_glaa_m.glaa121 = "N"
      LET g_glaa_m.glaa136 = "Y"
      LET g_glaa_m.glaa137 = "Y"
      LET g_glaa_m.glaa139 = "N"
      LET g_glaa_m.glaa140 = "N"
      LET g_glaa_m.glaa122 = "N"
      LET g_glaa_m.glaa123 = "N"
      LET g_glaa_m.glaa124 = "N"
      LET g_glaa_m.glaa131 = "Y"
      LET g_glaa_m.glaa132 = "1"
      LET g_glaa_m.glaa133 = "1"
      LET g_glaa_m.glaa134 = "0"
      LET g_glaa_m.glaa138 = "0"
 
     
      #add-point:單頭預設值 name="insert.default"
      LET g_glaa_m.glaamodid = ''
      LET g_glaa_m.glaamoddt = ''
      LET g_glaa_m.glaa009 = "1"
      LET g_glaa_m.glaacomp = ''
      LET g_glaa_m.glaacomp_desc = ''
      LET g_glaa_m.glaa001_desc = ''
      LET g_glaa_m.glaa002_desc = ''
      LET g_glaa_m.glaa003_desc = ''
      LET g_glaa_m.glaa004_desc = ''
      LET g_glaa_m.glaa005_desc = ''
      LET g_glaa_m.glaa024 = ''
      LET g_glaa_m.glaa024_desc = ''
      SELECT ooef014,ooef016,ooef015 INTO g_glaa_m.glaa026,g_glaa_m.glaa001,g_glaa_m.glaa002
        FROM ooef_t
       WHERE ooefent = g_enterprise AND ooef001 = g_site
      CALL agli010_ooal_ref('1',g_glaa_m.glaa002) RETURNING g_glaa_m.glaa002_desc
      CALL agli010_glaa001_ref(g_glaa_m.glaa001) RETURNING g_glaa_m.glaa001_desc
      CALL agli010_glaa026_desc(g_glaa_m.glaa026)  
      DISPLAY BY NAME g_glaa_m.glaa001_desc,g_glaa_m.glaa026_desc
      DISPLAY BY NAME g_glaa_m.glaacomp_desc,g_glaa_m.glaa001_desc,g_glaa_m.glaa002_desc,g_glaa_m.glaa003_desc,g_glaa_m.glaa004_desc,g_glaa_m.glaa005_desc
      CALL s_aooi100_sel_ooef004(g_site) RETURNING l_success,g_glaa_m.glaa024     
      CALL agli010_ooal_ref('3',g_glaa_m.glaa024) RETURNING g_glaa_m.glaa024_desc
      DISPLAY BY NAME g_glaa_m.glaa024_desc
#      SELECT ooef014 INTO g_glaa_m.glaa026 FROM ooef_t 
#       WHERE ooefent=g_enterprise AND ooef001=g_glaa_m.glaacomp
      
      #end add-point 
 
      CALL agli010_input("a")
      
      #add-point:單頭輸入後 name="insert.after_insert"
      LET g_glaald_ins = g_glaa_m.glaald 
      IF g_current_idx=0 AND NOT INT_FLAG THEN
         LET g_current_idx=1
      END IF
      #end add-point
      
      IF INT_FLAG THEN
         LET INT_FLAG = 0
         LET g_glaa_m.* = g_glaa_m_t.*
         CALL agli010_show()
         INITIALIZE g_errparam TO NULL
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "" 
         LET g_errparam.code = 9001 
         LET g_errparam.popup = FALSE 
         CALL cl_err()
         EXIT WHILE
      ELSE
         #分兩種狀況-1.根節點, 2.非根節點
         IF g_glaa_m.glaacomp = g_glaa_m.glaald THEN
            #為根節點
            LET li_addpos = g_browser.getLength() + 1
            LET g_browser[li_addpos].b_glaacomp = g_glaa_m.glaacomp
            LET g_browser[li_addpos].b_glaald = g_glaa_m.glaald
            LET g_browser[li_addpos].b_exp  = FALSE
            LET g_browser[li_addpos].b_hasC = FALSE
            LET g_browser[li_addpos].b_id  = '0.add',g_add_idx USING "<<<"
            LET g_browser[li_addpos].b_pid = '0',g_add_idx USING "<<<"
            LET g_add_idx = g_add_idx + 1
            CALL agli010_desc_show(li_addpos)
            LET g_current_idx = li_addpos
         ELSE
            #非根節點, 開始搜尋其父節點(已展開才做處理)
            LET li_cnt = g_cnt
            IF g_browser.getLength() > 0 THEN
               FOR li_idx = 1 TO g_browser.getLength()
                  IF g_browser[li_idx].b_glaald = g_glaa_m.glaacomp THEN
                     LET li_addpos = l_dialog.appendNode("s_browse",li_idx)
                     LET g_cnt = li_addpos
                     LET g_browser[li_addpos].b_glaacomp = g_glaa_m.glaacomp
                     LET g_browser[li_addpos].b_glaald = g_glaa_m.glaald
                     EXECUTE master_refreshcur USING g_browser[li_addpos].b_glaald
 
                                                INTO g_browser[g_cnt].b_glaald,g_browser[g_cnt].b_glaacomp 
 
                     LET g_browser[li_addpos].b_exp  = FALSE
                     LET g_browser[li_addpos].b_hasC = FALSE
                     LET g_browser[li_addpos].b_id  = g_browser[li_idx].b_id, '.add',g_add_idx USING "<<<"
                     LET g_browser[li_addpos].b_pid = g_browser[li_idx].b_id
                     LET g_add_idx = g_add_idx + 1
                     CALL agli010_desc_show(li_addpos)
                     #打開父節點
                     LET g_browser[li_idx].b_hasC = TRUE
                     LET g_browser[li_idx].b_exp = TRUE
                     LET g_current_idx = li_addpos
                     EXIT FOR
                  END IF
               END FOR
            END IF
            LET g_cnt = li_cnt
         END IF
      END IF
      
      LET g_rec_b = 0
      EXIT WHILE
   END WHILE
   
   #撈取異動後的資料(主要是帶出reference)
   EXECUTE agli010_master_referesh USING g_glaa_m.glaald INTO g_glaa_m.glaald,g_glaa_m.glaacomp,g_glaa_m.glaa027, 
       g_glaa_m.glaa026,g_glaa_m.glaa001,g_glaa_m.glaa002,g_glaa_m.glaa025,g_glaa_m.glaa028,g_glaa_m.glaa003, 
       g_glaa_m.glaa004,g_glaa_m.glaa024,g_glaa_m.glaa005,g_glaa_m.glaa006,g_glaa_m.glaa007,g_glaa_m.glaa014, 
       g_glaa_m.glaa008,g_glaa_m.glaa023,g_glaa_m.glaa009,g_glaa_m.glaa130,g_glaa_m.glaa010,g_glaa_m.glaa011, 
       g_glaa_m.glaa012,g_glaa_m.glaa013,g_glaa_m.glaastus,g_glaa_m.glaa015,g_glaa_m.glaa019,g_glaa_m.glaa016, 
       g_glaa_m.glaa020,g_glaa_m.glaa017,g_glaa_m.glaa021,g_glaa_m.glaa018,g_glaa_m.glaa022,g_glaa_m.glaa100, 
       g_glaa_m.glaa101,g_glaa_m.glaa102,g_glaa_m.glaa103,g_glaa_m.glaa111,g_glaa_m.glaa112,g_glaa_m.glaa113, 
       g_glaa_m.glaa120,g_glaa_m.glaa121,g_glaa_m.glaa136,g_glaa_m.glaa137,g_glaa_m.glaa139,g_glaa_m.glaa140, 
       g_glaa_m.glaa122,g_glaa_m.glaa123,g_glaa_m.glaa124,g_glaa_m.glaa131,g_glaa_m.glaa132,g_glaa_m.glaa133, 
       g_glaa_m.glaa134,g_glaa_m.glaa138,g_glaa_m.glaa135,g_glaa_m.glaaownid,g_glaa_m.glaaowndp,g_glaa_m.glaacrtid, 
       g_glaa_m.glaacrtdp,g_glaa_m.glaacrtdt,g_glaa_m.glaamodid,g_glaa_m.glaamoddt,g_glaa_m.glaacomp_desc, 
       g_glaa_m.glaa026_desc,g_glaa_m.glaa001_desc,g_glaa_m.glaa002_desc,g_glaa_m.glaa003_desc,g_glaa_m.glaa004_desc, 
       g_glaa_m.glaa024_desc,g_glaa_m.glaa005_desc,g_glaa_m.glaa111_desc,g_glaa_m.glaa112_desc,g_glaa_m.glaa113_desc, 
       g_glaa_m.glaa120_desc,g_glaa_m.glaa135_desc,g_glaa_m.glaaownid_desc,g_glaa_m.glaaowndp_desc,g_glaa_m.glaacrtid_desc, 
       g_glaa_m.glaacrtdp_desc,g_glaa_m.glaamodid_desc
   
   #將資料顯示到畫面上
   DISPLAY BY NAME g_glaa_m.glaald,g_glaa_m.glaal002,g_glaa_m.glaacomp,g_glaa_m.glaacomp_desc,g_glaa_m.glaa027, 
       g_glaa_m.glaa026,g_glaa_m.glaa026_desc,g_glaa_m.glaa001,g_glaa_m.glaa001_desc,g_glaa_m.glaa002, 
       g_glaa_m.glaa002_desc,g_glaa_m.glaa025,g_glaa_m.glaa028,g_glaa_m.glaa003,g_glaa_m.glaa003_desc, 
       g_glaa_m.glaa004,g_glaa_m.glaa004_desc,g_glaa_m.glaa024,g_glaa_m.glaa024_desc,g_glaa_m.glaa005, 
       g_glaa_m.glaa005_desc,g_glaa_m.glaa006,g_glaa_m.glaa007,g_glaa_m.glaa014,g_glaa_m.glaa008,g_glaa_m.glaa023, 
       g_glaa_m.glaa009,g_glaa_m.glaa130,g_glaa_m.glaa010,g_glaa_m.glaa011,g_glaa_m.glaa012,g_glaa_m.glaa013, 
       g_glaa_m.glaastus,g_glaa_m.glaa015,g_glaa_m.fflabel1_desc,g_glaa_m.glaa019,g_glaa_m.glaa016,g_glaa_m.glaa020, 
       g_glaa_m.glaa017,g_glaa_m.glaa021,g_glaa_m.glaa018,g_glaa_m.glaa022,g_glaa_m.fflabe7_desc,g_glaa_m.fflabel8_desc, 
       g_glaa_m.glaa100,g_glaa_m.glaa101,g_glaa_m.glaa102,g_glaa_m.glaa103,g_glaa_m.glaa111,g_glaa_m.glaa111_desc, 
       g_glaa_m.glaa112,g_glaa_m.glaa112_desc,g_glaa_m.glaa113,g_glaa_m.glaa113_desc,g_glaa_m.glaa120, 
       g_glaa_m.glaa120_desc,g_glaa_m.glaa121,g_glaa_m.glaa136,g_glaa_m.glaa137,g_glaa_m.glaa139,g_glaa_m.glaa140, 
       g_glaa_m.glaa122,g_glaa_m.glaa123,g_glaa_m.glaa124,g_glaa_m.glaa131,g_glaa_m.glaa132,g_glaa_m.glaa133, 
       g_glaa_m.glaa134,g_glaa_m.glaa138,g_glaa_m.glaa135,g_glaa_m.glaa135_desc,g_glaa_m.glaaownid,g_glaa_m.glaaownid_desc, 
       g_glaa_m.glaaowndp,g_glaa_m.glaaowndp_desc,g_glaa_m.glaacrtid,g_glaa_m.glaacrtid_desc,g_glaa_m.glaacrtdp, 
       g_glaa_m.glaacrtdp_desc,g_glaa_m.glaacrtdt,g_glaa_m.glaamodid,g_glaa_m.glaamodid_desc,g_glaa_m.glaamoddt 
 
   
   #功能已完成,通報訊息中心
   CALL agli010_msgcentre_notify('insert')
   
END FUNCTION
 
{</section>}
 
{<section id="agli010.modify" >}
#+ 資料修改
PRIVATE FUNCTION agli010_modify()
   #add-point:modify段define name="modify.define_customerization"
   
   #end add-point
   #add-point:modify段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="modify.define"
   DEFINE l_pass        LIKE type_t.num5  #160825-00017#1 add
   #end add-point
   
   #add-point:Function前置處理  name="modify.pre_function"
   #160825-00017#1--add--str--
   IF g_glaa_m.glaald IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code   = "std-00003" 
      LET g_errparam.popup  = FALSE 
      CALL cl_err()
      RETURN
   END IF 
   CALL s_ld_chk_authorization(g_user,g_glaa_m.glaald) RETURNING l_pass
   IF l_pass = FALSE THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'agl-00165'
      LET g_errparam.extend = g_glaa_m.glaald
      LET g_errparam.popup = TRUE
      CALL cl_err()
    
      RETURN
   END IF
   #160825-00017#1--add--end
   #end add-point
   
   IF g_glaa_m.glaald IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code = "std-00003" 
      LET g_errparam.popup = FALSE 
      CALL cl_err()
      RETURN
   END IF 
   
   EXECUTE agli010_master_referesh USING g_glaa_m.glaald INTO g_glaa_m.glaald,g_glaa_m.glaacomp,g_glaa_m.glaa027, 
       g_glaa_m.glaa026,g_glaa_m.glaa001,g_glaa_m.glaa002,g_glaa_m.glaa025,g_glaa_m.glaa028,g_glaa_m.glaa003, 
       g_glaa_m.glaa004,g_glaa_m.glaa024,g_glaa_m.glaa005,g_glaa_m.glaa006,g_glaa_m.glaa007,g_glaa_m.glaa014, 
       g_glaa_m.glaa008,g_glaa_m.glaa023,g_glaa_m.glaa009,g_glaa_m.glaa130,g_glaa_m.glaa010,g_glaa_m.glaa011, 
       g_glaa_m.glaa012,g_glaa_m.glaa013,g_glaa_m.glaastus,g_glaa_m.glaa015,g_glaa_m.glaa019,g_glaa_m.glaa016, 
       g_glaa_m.glaa020,g_glaa_m.glaa017,g_glaa_m.glaa021,g_glaa_m.glaa018,g_glaa_m.glaa022,g_glaa_m.glaa100, 
       g_glaa_m.glaa101,g_glaa_m.glaa102,g_glaa_m.glaa103,g_glaa_m.glaa111,g_glaa_m.glaa112,g_glaa_m.glaa113, 
       g_glaa_m.glaa120,g_glaa_m.glaa121,g_glaa_m.glaa136,g_glaa_m.glaa137,g_glaa_m.glaa139,g_glaa_m.glaa140, 
       g_glaa_m.glaa122,g_glaa_m.glaa123,g_glaa_m.glaa124,g_glaa_m.glaa131,g_glaa_m.glaa132,g_glaa_m.glaa133, 
       g_glaa_m.glaa134,g_glaa_m.glaa138,g_glaa_m.glaa135,g_glaa_m.glaaownid,g_glaa_m.glaaowndp,g_glaa_m.glaacrtid, 
       g_glaa_m.glaacrtdp,g_glaa_m.glaacrtdt,g_glaa_m.glaamodid,g_glaa_m.glaamoddt,g_glaa_m.glaacomp_desc, 
       g_glaa_m.glaa026_desc,g_glaa_m.glaa001_desc,g_glaa_m.glaa002_desc,g_glaa_m.glaa003_desc,g_glaa_m.glaa004_desc, 
       g_glaa_m.glaa024_desc,g_glaa_m.glaa005_desc,g_glaa_m.glaa111_desc,g_glaa_m.glaa112_desc,g_glaa_m.glaa113_desc, 
       g_glaa_m.glaa120_desc,g_glaa_m.glaa135_desc,g_glaa_m.glaaownid_desc,g_glaa_m.glaaowndp_desc,g_glaa_m.glaacrtid_desc, 
       g_glaa_m.glaacrtdp_desc,g_glaa_m.glaamodid_desc
 
   #檢查是否允許此動作
   IF NOT agli010_action_chk() THEN
      RETURN
   END IF
  
   LET g_glaald_t = g_glaa_m.glaald
 
   
   CALL s_transaction_begin()
   
   OPEN agli010_cl USING g_enterprise,g_glaa_m.glaald
   IF SQLCA.SQLCODE THEN   #(ver:36)
      CLOSE agli010_cl
      CALL s_transaction_end("N","0")
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "OPEN agli010_cl:" 
      LET g_errparam.code = SQLCA.SQLCODE   #(ver:36)
      LET g_errparam.popup = TRUE 
      CALL cl_err()
      RETURN
   END IF
 
   #鎖住將被更改或取消的資料
   FETCH agli010_cl INTO g_glaa_m.glaald,g_glaa_m.glaal002,g_glaa_m.glaacomp,g_glaa_m.glaacomp_desc, 
       g_glaa_m.glaa027,g_glaa_m.glaa026,g_glaa_m.glaa026_desc,g_glaa_m.glaa001,g_glaa_m.glaa001_desc, 
       g_glaa_m.glaa002,g_glaa_m.glaa002_desc,g_glaa_m.glaa025,g_glaa_m.glaa028,g_glaa_m.glaa003,g_glaa_m.glaa003_desc, 
       g_glaa_m.glaa004,g_glaa_m.glaa004_desc,g_glaa_m.glaa024,g_glaa_m.glaa024_desc,g_glaa_m.glaa005, 
       g_glaa_m.glaa005_desc,g_glaa_m.glaa006,g_glaa_m.glaa007,g_glaa_m.glaa014,g_glaa_m.glaa008,g_glaa_m.glaa023, 
       g_glaa_m.glaa009,g_glaa_m.glaa130,g_glaa_m.glaa010,g_glaa_m.glaa011,g_glaa_m.glaa012,g_glaa_m.glaa013, 
       g_glaa_m.glaastus,g_glaa_m.glaa015,g_glaa_m.fflabel1_desc,g_glaa_m.glaa019,g_glaa_m.glaa016,g_glaa_m.glaa020, 
       g_glaa_m.glaa017,g_glaa_m.glaa021,g_glaa_m.glaa018,g_glaa_m.glaa022,g_glaa_m.fflabe7_desc,g_glaa_m.fflabel8_desc, 
       g_glaa_m.glaa100,g_glaa_m.glaa101,g_glaa_m.glaa102,g_glaa_m.glaa103,g_glaa_m.glaa111,g_glaa_m.glaa111_desc, 
       g_glaa_m.glaa112,g_glaa_m.glaa112_desc,g_glaa_m.glaa113,g_glaa_m.glaa113_desc,g_glaa_m.glaa120, 
       g_glaa_m.glaa120_desc,g_glaa_m.glaa121,g_glaa_m.glaa136,g_glaa_m.glaa137,g_glaa_m.glaa139,g_glaa_m.glaa140, 
       g_glaa_m.glaa122,g_glaa_m.glaa123,g_glaa_m.glaa124,g_glaa_m.glaa131,g_glaa_m.glaa132,g_glaa_m.glaa133, 
       g_glaa_m.glaa134,g_glaa_m.glaa138,g_glaa_m.glaa135,g_glaa_m.glaa135_desc,g_glaa_m.glaaownid,g_glaa_m.glaaownid_desc, 
       g_glaa_m.glaaowndp,g_glaa_m.glaaowndp_desc,g_glaa_m.glaacrtid,g_glaa_m.glaacrtid_desc,g_glaa_m.glaacrtdp, 
       g_glaa_m.glaacrtdp_desc,g_glaa_m.glaacrtdt,g_glaa_m.glaamodid,g_glaa_m.glaamodid_desc,g_glaa_m.glaamoddt 
 
 
   #資料被他人LOCK, 或是sql執行時出現錯誤
   IF SQLCA.SQLCODE THEN
      CLOSE agli010_cl
      CALL s_transaction_end("N","0")
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = g_glaa_m.glaald,":",SQLERRMESSAGE 
      LET g_errparam.code = SQLCA.SQLCODE 
      LET g_errparam.popup = FALSE 
      CALL cl_err()
      RETURN
   END IF
   #其他table資料備份(確定是否更改用)
   LET g_master_multi_table_t.glaalld = g_glaa_m.glaald
LET g_master_multi_table_t.glaal002 = g_glaa_m.glaal002
 
 
   CALL agli010_show()
   WHILE TRUE
      LET g_glaa_m.glaald = g_glaald_t
 
      
      #寫入修改者/修改日期資訊
      LET g_glaa_m.glaamodid = g_user 
LET g_glaa_m.glaamoddt = cl_get_current()
LET g_glaa_m.glaamodid_desc = cl_get_username(g_glaa_m.glaamodid)
 
      #add-point:modify段修改前 name="modify.before_input"
      LET g_glaa_m_t.* = g_glaa_m.*   #160310-00008#1 add     
      #end add-point
      
      CALL agli010_input("u")     #欄位更改
 
      #add-point:modify段修改後 name="modify.after_input"
            
      #end add-point
      
      IF INT_FLAG THEN
         LET INT_FLAG = 0
         LET g_glaa_m.* = g_glaa_m_t.*
         CALL agli010_show()
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "" 
         LET g_errparam.code = 9001 
         LET g_errparam.popup = FALSE 
         CALL cl_err()
 
         EXIT WHILE
      END IF
 
      #若有modid跟moddt則進行update
      UPDATE glaa_t SET (glaamodid,glaamoddt) = (g_glaa_m.glaamodid,g_glaa_m.glaamoddt)
       WHERE glaaent = g_enterprise AND glaald = g_glaald_t
 
      
      EXIT WHILE
  
   END WHILE
 
   CLOSE agli010_cl
   CALL s_transaction_end("Y","0")
 
   #功能已完成,通報訊息中心
   CALL agli010_msgcentre_notify('modify')
   
END FUNCTION
 
{</section>}
 
{<section id="agli010.check" >}
#+ 避免資料錯誤
PRIVATE FUNCTION agli010_check(ps_id,ps_pid)
   #add-point:check段define name="check.define_customerization"
   
   #end add-point
   DEFINE ps_id       STRING
   DEFINE ps_pid      STRING
   DEFINE ps_type     STRING
   DEFINE ls_pid      LIKE type_t.chr100
   DEFINE ls_id       LIKE type_t.chr100
   DEFINE ls_type     LIKE type_t.chr100
   DEFINE ls_return   LIKE type_t.num5
   DEFINE ls_sql      STRING
   DEFINE li_cnt      LIKE type_t.num10
   #add-point:check段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="check.define"
      
   #end add-point
   
   #add-point:Function前置處理  name="check.pre_function"
   
   #end add-point
   
   #從該節點往上檢查, 若出現ID重複的狀況代表會導致無限迴圈
   LET ls_sql = " SELECT glaald,glaacomp FROM ",
                " (SELECT glaald,glaacomp FROM glaa_t WHERE glaaent = " ||g_enterprise|| " AND glaald<>glaacomp)", 
 
                " WHERE glaald = '",ps_id,"' OR glaacomp = '",ps_id,"'",
                " START WITH glaald='",ps_pid,"'",
                " CONNECT BY PRIOR glaacomp=glaald "
 
   PREPARE check_cnt FROM ls_sql
   DECLARE check_cntcur CURSOR FOR check_cnt
   OPEN check_cntcur
   IF SQLCA.SQLCODE THEN   #(ver:36)
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "OPEN check_cntcur:",SQLERRMESSAGE 
      LET g_errparam.code = SQLCA.SQLCODE   #(ver:36)
      LET g_errparam.popup = TRUE 
      CALL cl_err()
      RETURN FALSE
   END IF
 
   FETCH check_cntcur INTO li_cnt
 
   IF li_cnt > 0 THEN
      LET ls_return = TRUE
   ELSE
      LET ls_return = FALSE
   END IF
   
   RETURN ls_return 
   
END FUNCTION
 
{</section>}
 
{<section id="agli010.reproduce" >}
#+ 資料複製
PRIVATE FUNCTION agli010_reproduce(l_dialog)
   #add-point:reproduce段define name="reproduce.define_customerization"
   
   #end add-point   
   DEFINE l_dialog      ui.DIALOG
   DEFINE li_addpos     LIKE type_t.num10
   DEFINE l_newno           LIKE glaa_t.glaald 
   DEFINE l_oldno           LIKE glaa_t.glaald 
 
   DEFINE l_master          RECORD LIKE glaa_t.*
   DEFINE l_cnt             LIKE type_t.num10  
   DEFINE li_idx            LIKE type_t.num10  
   DEFINE li_cnt            LIKE type_t.num10  
   #add-point:reproduce段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="reproduce.define"
   #161111-00028#8----modify----begin---------   
   #DEFINE l_glaal           RECORD LIKE glaal_t.*
   DEFINE l_glaal RECORD  #帳套資料檔多語言檔
       glaalent LIKE glaal_t.glaalent, #企業編號
       glaalld LIKE glaal_t.glaalld, #帳套編號
       glaal001 LIKE glaal_t.glaal001, #語言別
       glaal002 LIKE glaal_t.glaal002, #說明
       glaal003 LIKE glaal_t.glaal003  #助記碼
       END RECORD
   #161111-00028#8----modify----begin---------
   #end add-point
   
   #add-point:Function前置處理  name="reproduce.before_reproduce"
      
   #end add-point
 
   #檢查PK欄位是否均有值,若全部為NULL時退出
   IF g_glaa_m.glaald IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code = "std-00003" 
      LET g_errparam.popup = FALSE 
      CALL cl_err()
      RETURN
   END IF 
 
   EXECUTE agli010_master_referesh USING g_glaa_m.glaald INTO g_glaa_m.glaald,g_glaa_m.glaacomp,g_glaa_m.glaa027, 
       g_glaa_m.glaa026,g_glaa_m.glaa001,g_glaa_m.glaa002,g_glaa_m.glaa025,g_glaa_m.glaa028,g_glaa_m.glaa003, 
       g_glaa_m.glaa004,g_glaa_m.glaa024,g_glaa_m.glaa005,g_glaa_m.glaa006,g_glaa_m.glaa007,g_glaa_m.glaa014, 
       g_glaa_m.glaa008,g_glaa_m.glaa023,g_glaa_m.glaa009,g_glaa_m.glaa130,g_glaa_m.glaa010,g_glaa_m.glaa011, 
       g_glaa_m.glaa012,g_glaa_m.glaa013,g_glaa_m.glaastus,g_glaa_m.glaa015,g_glaa_m.glaa019,g_glaa_m.glaa016, 
       g_glaa_m.glaa020,g_glaa_m.glaa017,g_glaa_m.glaa021,g_glaa_m.glaa018,g_glaa_m.glaa022,g_glaa_m.glaa100, 
       g_glaa_m.glaa101,g_glaa_m.glaa102,g_glaa_m.glaa103,g_glaa_m.glaa111,g_glaa_m.glaa112,g_glaa_m.glaa113, 
       g_glaa_m.glaa120,g_glaa_m.glaa121,g_glaa_m.glaa136,g_glaa_m.glaa137,g_glaa_m.glaa139,g_glaa_m.glaa140, 
       g_glaa_m.glaa122,g_glaa_m.glaa123,g_glaa_m.glaa124,g_glaa_m.glaa131,g_glaa_m.glaa132,g_glaa_m.glaa133, 
       g_glaa_m.glaa134,g_glaa_m.glaa138,g_glaa_m.glaa135,g_glaa_m.glaaownid,g_glaa_m.glaaowndp,g_glaa_m.glaacrtid, 
       g_glaa_m.glaacrtdp,g_glaa_m.glaacrtdt,g_glaa_m.glaamodid,g_glaa_m.glaamoddt,g_glaa_m.glaacomp_desc, 
       g_glaa_m.glaa026_desc,g_glaa_m.glaa001_desc,g_glaa_m.glaa002_desc,g_glaa_m.glaa003_desc,g_glaa_m.glaa004_desc, 
       g_glaa_m.glaa024_desc,g_glaa_m.glaa005_desc,g_glaa_m.glaa111_desc,g_glaa_m.glaa112_desc,g_glaa_m.glaa113_desc, 
       g_glaa_m.glaa120_desc,g_glaa_m.glaa135_desc,g_glaa_m.glaaownid_desc,g_glaa_m.glaaowndp_desc,g_glaa_m.glaacrtid_desc, 
       g_glaa_m.glaacrtdp_desc,g_glaa_m.glaamodid_desc
 
   #檢查如果有子節點(hasC=1)則顯示錯誤訊息後退出
 
   ERROR ""
 
   CALL cl_set_head_visible("","YES")
 
   
 
   LET g_glaa_m.glaald = ""
 
   #應用 a14 樣板自動產生(Version:5)    
      #公用欄位新增給值  
      LET g_glaa_m.glaaownid = g_user
      LET g_glaa_m.glaaowndp = g_dept
      LET g_glaa_m.glaacrtid = g_user
      LET g_glaa_m.glaacrtdp = g_dept 
      LET g_glaa_m.glaacrtdt = cl_get_current()
      LET g_glaa_m.glaamodid = g_user
      LET g_glaa_m.glaamoddt = cl_get_current()
      LET g_glaa_m.glaastus = 'Y'
 
 
 
   
   CALL s_transaction_begin()
   
   #其他table資料備份(確定是否更改用)
   LET g_master_multi_table_t.glaalld = g_glaa_m.glaald
LET g_master_multi_table_t.glaal002 = g_glaa_m.glaal002
 
 
   #add-point:複製輸入前 name="reproduce.head.b_input"
   LET g_glaa_m.glaald = ''
   LET g_glaa_m.glaa014 = 'N'
   DISPLAY BY NAME g_glaa_m.glaa014
   LET g_glaa_m.glaacomp = g_glaa_m_t.glaacomp
#   CALL agli010_glaacomp_ref(g_glaa_m.glaacomp) RETURNING g_glaa_m.glaacomp_desc
   DISPLAY g_glaa_m.glaacomp_desc TO glaacomp_desc
   #160902-00035#1--add--str--
   LET g_glaa_m.glaa010 = NULL
   LET g_glaa_m.glaa011 = NULL
   LET g_glaa_m.glaa012 = NULL
   LET g_glaa_m.glaa013 = NULL
   DISPLAY BY NAME g_glaa_m.glaa010,g_glaa_m.glaa011,g_glaa_m.glaa012,g_glaa_m.glaa013
   #160902-00035#1--add--end
   #end add-point
   
   #直接呼叫輸入
   CALL agli010_input("r")
 
   #add-point:完成複製段落後 name="reproduce.after_reproduce"
      
   #end add-point
 
   IF INT_FLAG THEN
         LET INT_FLAG = 0
         LET g_glaa_m.* = g_glaa_m_t.*
         CALL agli010_show()
         INITIALIZE g_errparam TO NULL
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "" 
         LET g_errparam.code = 9001 
         LET g_errparam.popup = FALSE 
         CALL cl_err()
      ELSE
         #分兩種狀況-1.根節點, 2.非根節點
         IF g_glaa_m.glaacomp = g_glaa_m.glaald THEN
            #為根節點
            LET li_addpos = g_browser.getLength() + 1
            LET g_browser[li_addpos].b_glaacomp = g_glaa_m.glaacomp
            LET g_browser[li_addpos].b_glaald = g_glaa_m.glaald
            LET g_browser[li_addpos].b_exp  = FALSE
            LET g_browser[li_addpos].b_hasC = FALSE
            LET g_browser[li_addpos].b_id  = '0.add',g_add_idx USING "<<<"
            LET g_browser[li_addpos].b_pid = '0',g_add_idx USING "<<<"
            LET g_add_idx = g_add_idx + 1
            CALL agli010_desc_show(li_addpos)
            LET g_current_idx = li_addpos
         ELSE
            #非根節點, 開始搜尋其父節點(已展開才做處理)
            LET li_cnt = g_cnt
            IF g_browser.getLength() > 0 THEN
               FOR li_idx = 1 TO g_browser.getLength()
                  IF g_browser[li_idx].b_glaald = g_glaa_m.glaacomp THEN
                     LET li_addpos = l_dialog.appendNode("s_browse",li_idx)
                     LET g_cnt = li_addpos
                     LET g_browser[li_addpos].b_glaacomp = g_glaa_m.glaacomp
                     LET g_browser[li_addpos].b_glaald = g_glaa_m.glaald
                     EXECUTE master_refreshcur USING g_browser[li_addpos].b_glaald
 
                                                INTO g_browser[g_cnt].b_glaald,g_browser[g_cnt].b_glaacomp 
 
                     LET g_browser[li_addpos].b_exp  = FALSE
                     LET g_browser[li_addpos].b_hasC = FALSE
                     LET g_browser[li_addpos].b_id  = g_browser[li_idx].b_id, '.add',g_add_idx USING "<<<"
                     LET g_browser[li_addpos].b_pid = g_browser[li_idx].b_id
                     LET g_add_idx = g_add_idx + 1
                     CALL agli010_desc_show(li_addpos)
                     #打開父節點
                     LET g_browser[li_idx].b_hasC = TRUE
                     LET g_browser[li_idx].b_exp = TRUE
                     LET g_current_idx = li_addpos
                     EXIT FOR
                  END IF
               END FOR
            END IF
            LET g_cnt = li_cnt 
         END IF
      END IF
 
   #功能已完成,通報訊息中心
   CALL agli010_msgcentre_notify('reproduce')
 
END FUNCTION
 
{</section>}
 
{<section id="agli010.input" >}
#+ 資料輸入
PRIVATE FUNCTION agli010_input(p_cmd)
   #add-point:input段define name="input.define_customerization"
   
   #end add-point
   DEFINE p_cmd           LIKE type_t.chr1
   DEFINE l_cmd_t         LIKE type_t.chr1
   DEFINE l_ac_t          LIKE type_t.num10       #未取消的ARRAY CNT 
   DEFINE l_n             LIKE type_t.num10       #檢查重複用
   DEFINE l_cnt           LIKE type_t.num10       #檢查重複用
   DEFINE l_lock_sw       LIKE type_t.chr1        #單身鎖住否
   DEFINE l_allow_insert  LIKE type_t.num5        #可新增否 
   DEFINE l_allow_delete  LIKE type_t.num5        #可刪除否
   DEFINE l_count         LIKE type_t.num10
   DEFINE l_i             LIKE type_t.num10
   DEFINE l_insert        LIKE type_t.num10
   DEFINE ls_return       STRING
   DEFINE l_var_keys      DYNAMIC ARRAY OF STRING
   DEFINE l_var_keys_bak  DYNAMIC ARRAY OF STRING
   DEFINE l_field_keys    DYNAMIC ARRAY OF STRING
   DEFINE l_vars          DYNAMIC ARRAY OF STRING
   DEFINE l_fields        DYNAMIC ARRAY OF STRING
   #add-point:input段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="input.define"
   DEFINE lc_count        LIKE type_t.num10
   DEFINE l_success       LIKE type_t.num5
   DEFINE l_field         LIKE type_t.chr10
   DEFINE l_ooalstus      LIKE ooal_t.ooalstus
   DEFINE l_ooef005       LIKE ooef_t.ooef005
   DEFINE l_ooef014       LIKE ooef_t.ooef014  #151216-00004#1 add
   DEFINE l_ooef015       LIKE ooef_t.ooef015  #151216-00004#1 add
   DEFINE l_ooef016       LIKE ooef_t.ooef016  #151216-00004#1 add
   #end add-point
   
   #add-point:Function前置處理  name="input.pre_function"
   
   #end add-point
   
   #切換畫面
   IF g_main_hidden THEN
      CALL gfrm_curr.setElementHidden("mainlayout",0)
      CALL gfrm_curr.setElementHidden("worksheet",1)
      LET g_main_hidden = 0
   END IF
 
   #將資料輸出到畫面上
   DISPLAY BY NAME g_glaa_m.glaald,g_glaa_m.glaal002,g_glaa_m.glaacomp,g_glaa_m.glaacomp_desc,g_glaa_m.glaa027, 
       g_glaa_m.glaa026,g_glaa_m.glaa026_desc,g_glaa_m.glaa001,g_glaa_m.glaa001_desc,g_glaa_m.glaa002, 
       g_glaa_m.glaa002_desc,g_glaa_m.glaa025,g_glaa_m.glaa028,g_glaa_m.glaa003,g_glaa_m.glaa003_desc, 
       g_glaa_m.glaa004,g_glaa_m.glaa004_desc,g_glaa_m.glaa024,g_glaa_m.glaa024_desc,g_glaa_m.glaa005, 
       g_glaa_m.glaa005_desc,g_glaa_m.glaa006,g_glaa_m.glaa007,g_glaa_m.glaa014,g_glaa_m.glaa008,g_glaa_m.glaa023, 
       g_glaa_m.glaa009,g_glaa_m.glaa130,g_glaa_m.glaa010,g_glaa_m.glaa011,g_glaa_m.glaa012,g_glaa_m.glaa013, 
       g_glaa_m.glaastus,g_glaa_m.glaa015,g_glaa_m.fflabel1_desc,g_glaa_m.glaa019,g_glaa_m.glaa016,g_glaa_m.glaa020, 
       g_glaa_m.glaa017,g_glaa_m.glaa021,g_glaa_m.glaa018,g_glaa_m.glaa022,g_glaa_m.fflabe7_desc,g_glaa_m.fflabel8_desc, 
       g_glaa_m.glaa100,g_glaa_m.glaa101,g_glaa_m.glaa102,g_glaa_m.glaa103,g_glaa_m.glaa111,g_glaa_m.glaa111_desc, 
       g_glaa_m.glaa112,g_glaa_m.glaa112_desc,g_glaa_m.glaa113,g_glaa_m.glaa113_desc,g_glaa_m.glaa120, 
       g_glaa_m.glaa120_desc,g_glaa_m.glaa121,g_glaa_m.glaa136,g_glaa_m.glaa137,g_glaa_m.glaa139,g_glaa_m.glaa140, 
       g_glaa_m.glaa122,g_glaa_m.glaa123,g_glaa_m.glaa124,g_glaa_m.glaa131,g_glaa_m.glaa132,g_glaa_m.glaa133, 
       g_glaa_m.glaa134,g_glaa_m.glaa138,g_glaa_m.glaa135,g_glaa_m.glaa135_desc,g_glaa_m.glaaownid,g_glaa_m.glaaownid_desc, 
       g_glaa_m.glaaowndp,g_glaa_m.glaaowndp_desc,g_glaa_m.glaacrtid,g_glaa_m.glaacrtid_desc,g_glaa_m.glaacrtdp, 
       g_glaa_m.glaacrtdp_desc,g_glaa_m.glaacrtdt,g_glaa_m.glaamodid,g_glaa_m.glaamodid_desc,g_glaa_m.glaamoddt 
 
 
   #先做狀態判定
   IF p_cmd = 'r' THEN
      LET l_cmd_t = 'r' 
      LET p_cmd   = 'a'
   ELSE
      LET l_cmd_t = p_cmd
   END IF  
   
   CALL cl_set_head_visible("","YES")
 
   LET l_insert = FALSE
   LET g_action_choice = ""
   LET g_qryparam.state = "i"
   
   #控制key欄位可否輸入
   CALL agli010_set_entry(p_cmd)
   #add-point:set_entry後 name="input.after_set_entry"
      
   #end add-point
   CALL agli010_set_no_entry(p_cmd)
   #add-point:set_no_entry後 name="input.after_set_no_entry"
      
   #end add-point
 
   DISPLAY BY NAME g_glaa_m.glaald,g_glaa_m.glaal002,g_glaa_m.glaacomp,g_glaa_m.glaa027,g_glaa_m.glaa026, 
       g_glaa_m.glaa001,g_glaa_m.glaa002,g_glaa_m.glaa025,g_glaa_m.glaa028,g_glaa_m.glaa003,g_glaa_m.glaa004, 
       g_glaa_m.glaa024,g_glaa_m.glaa005,g_glaa_m.glaa006,g_glaa_m.glaa007,g_glaa_m.glaa014,g_glaa_m.glaa008, 
       g_glaa_m.glaa023,g_glaa_m.glaa009,g_glaa_m.glaa130,g_glaa_m.glaa010,g_glaa_m.glaa011,g_glaa_m.glaa012, 
       g_glaa_m.glaa013,g_glaa_m.glaastus,g_glaa_m.glaa015,g_glaa_m.glaa019,g_glaa_m.glaa016,g_glaa_m.glaa020, 
       g_glaa_m.glaa017,g_glaa_m.glaa021,g_glaa_m.glaa018,g_glaa_m.glaa022,g_glaa_m.glaa100,g_glaa_m.glaa101, 
       g_glaa_m.glaa102,g_glaa_m.glaa103,g_glaa_m.glaa111,g_glaa_m.glaa112,g_glaa_m.glaa113,g_glaa_m.glaa120, 
       g_glaa_m.glaa121,g_glaa_m.glaa136,g_glaa_m.glaa137,g_glaa_m.glaa139,g_glaa_m.glaa140,g_glaa_m.glaa122, 
       g_glaa_m.glaa123,g_glaa_m.glaa124,g_glaa_m.glaa131,g_glaa_m.glaa132,g_glaa_m.glaa133,g_glaa_m.glaa134, 
       g_glaa_m.glaa138,g_glaa_m.glaa135
   
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
   
      #單頭段
      INPUT BY NAME g_glaa_m.glaald,g_glaa_m.glaal002,g_glaa_m.glaacomp,g_glaa_m.glaa027,g_glaa_m.glaa026, 
          g_glaa_m.glaa001,g_glaa_m.glaa002,g_glaa_m.glaa025,g_glaa_m.glaa028,g_glaa_m.glaa003,g_glaa_m.glaa004, 
          g_glaa_m.glaa024,g_glaa_m.glaa005,g_glaa_m.glaa006,g_glaa_m.glaa007,g_glaa_m.glaa014,g_glaa_m.glaa008, 
          g_glaa_m.glaa023,g_glaa_m.glaa009,g_glaa_m.glaa130,g_glaa_m.glaa010,g_glaa_m.glaa011,g_glaa_m.glaa012, 
          g_glaa_m.glaa013,g_glaa_m.glaastus,g_glaa_m.glaa015,g_glaa_m.glaa019,g_glaa_m.glaa016,g_glaa_m.glaa020, 
          g_glaa_m.glaa017,g_glaa_m.glaa021,g_glaa_m.glaa018,g_glaa_m.glaa022,g_glaa_m.glaa100,g_glaa_m.glaa101, 
          g_glaa_m.glaa102,g_glaa_m.glaa103,g_glaa_m.glaa111,g_glaa_m.glaa112,g_glaa_m.glaa113,g_glaa_m.glaa120, 
          g_glaa_m.glaa121,g_glaa_m.glaa136,g_glaa_m.glaa137,g_glaa_m.glaa139,g_glaa_m.glaa140,g_glaa_m.glaa122, 
          g_glaa_m.glaa123,g_glaa_m.glaa124,g_glaa_m.glaa131,g_glaa_m.glaa132,g_glaa_m.glaa133,g_glaa_m.glaa134, 
          g_glaa_m.glaa138,g_glaa_m.glaa135 
         ATTRIBUTE(WITHOUT DEFAULTS)
         
         #自訂單頭ACTION
         
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION update_item
            LET g_action_choice="update_item"
            IF cl_auth_chk_act("update_item") THEN
               
               #add-point:ON ACTION update_item name="input.master_input.update_item"
                                       IF NOT cl_null(g_glaa_m.glaald)  THEN
                  CALL n_glaal(g_glaa_m.glaald)
                  INITIALIZE g_ref_fields TO NULL
                  LET g_ref_fields[1] = g_glaa_m.glaald
                  CALL ap_ref_array2(g_ref_fields," SELECT glaal002 FROM glaal_t WHERE glaalent = '"
                      ||g_enterprise||"' AND glaalld = ? AND glaal001 = '"||g_dlang||"'","") RETURNING g_rtn_fields
                  LET g_glaa_m.glaal002 = g_rtn_fields[1]

                  DISPLAY BY NAME g_glaa_m.glaal002
               END IF
               #END add-point
            END IF
 
 
 
 
         
         BEFORE INPUT
            IF s_transaction_chk("N",0) THEN
               CALL s_transaction_begin()
            END IF
            
            #add-point:input段define name="input.action"
            IF p_cmd = 'r' THEN
               LET g_master_multi_table_t.glaalld = ''
               LET g_master_multi_table_t.glaal002 = ''
            END IF
            #end add-point
          
                  #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glaald
            #add-point:BEFORE FIELD glaald name="input.b.glaald"
                        
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glaald
            
            #add-point:AFTER FIELD glaald name="input.a.glaald"
                                    #此段落由子樣板a05產生
            IF NOT agli010_glaald_chk(g_glaa_m.glaald,g_glaa_m_t.glaald,p_cmd) THEN
               IF p_cmd = 'a' THEN
                  LET g_glaa_m.glaald = ''
               ELSE
                  LET g_glaa_m.glaald = g_glaa_m_t.glaald
               END IF 
               NEXT FIELD glaald
            END IF 

            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE glaald
            #add-point:ON CHANGE glaald name="input.g.glaald"
                        
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glaal002
            #add-point:BEFORE FIELD glaal002 name="input.b.glaal002"
                        
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glaal002
            
            #add-point:AFTER FIELD glaal002 name="input.a.glaal002"
                      
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE glaal002
            #add-point:ON CHANGE glaal002 name="input.g.glaal002"
                        
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glaacomp
            
            #add-point:AFTER FIELD glaacomp name="input.a.glaacomp"
            DISPLAY ' ' TO glaacomp_desc
            IF NOT agli010_glaacomp_chk(g_glaa_m.glaacomp) THEN
               IF p_cmd = 'a' OR p_cmd = 'r' THEN
                  LET g_glaa_m.glaacomp = ''
               ELSE
                  LET g_glaa_m.glaacomp = g_glaa_m_t.glaacomp
               END IF
               CALL agli010_glaacomp_ref(g_glaa_m.glaacomp) 
                RETURNING g_glaa_m.glaacomp_desc
               DISPLAY BY NAME g_glaa_m.glaacomp_desc
               NEXT FIELD glaacomp
            END IF 
            CALL agli010_glaacomp_ref(g_glaa_m.glaacomp)
             RETURNING g_glaa_m.glaacomp_desc
            DISPLAY BY NAME g_glaa_m.glaacomp_desc
            IF NOT agli010_glaa008_chk(g_glaa_m.glaa008,g_glaa_m.glaacomp,g_glaa_m.glaald) THEN
               LET g_glaa_m.glaa008 = 'N'
               LET g_glaa_m.glaa009 = '1'
            END IF
            #預設幣別參照表為法人對應設置的幣別參照表號
            IF NOT cl_null(g_glaa_m.glaacomp) AND (p_cmd='a' OR cl_null(g_glaa_m.glaa026)) THEN
               SELECT ooef014,ooef016 INTO g_glaa_m.glaa026,g_glaa_m.glaa001 FROM ooef_t 
                WHERE ooefent=g_enterprise AND ooef001=g_glaa_m.glaacomp
               CALL agli010_glaa026_desc(g_glaa_m.glaa026)
               DISPLAY BY NAME g_glaa_m.glaa026,g_glaa_m.glaa026_desc
               CALL agli010_glaa001_ref(g_glaa_m.glaa001)
               RETURNING g_glaa_m.glaa001_desc
               DISPLAY BY NAME g_glaa_m.glaa001,g_glaa_m.glaa001_desc
            END IF
            IF NOT cl_null(g_glaa_m.glaacomp) THEN
               SELECT ooef014,ooef016,ooef015,ooef005
                 INTO g_glaa_m.glaa026,g_glaa_m.glaa001,g_glaa_m.glaa002,l_ooef005
                 FROM ooef_t
                WHERE ooefent = g_enterprise AND ooef001 = g_glaa_m.glaacomp
               CALL agli010_ooal_ref('1',g_glaa_m.glaa002) RETURNING g_glaa_m.glaa002_desc
               CALL agli010_glaa001_ref(g_glaa_m.glaa001) RETURNING g_glaa_m.glaa001_desc
               CALL agli010_glaa026_desc(g_glaa_m.glaa026)  
               DISPLAY BY NAME g_glaa_m.glaa001_desc,g_glaa_m.glaa002_desc,g_glaa_m.glaa026_desc
               IF cl_null(g_glaa_m.glaa027) THEN
                  LET g_glaa_m.glaa027 = l_ooef005
                  DISPLAY BY NAME g_glaa_m.glaa027
               END IF
               IF NOT cl_null(g_glaa_m.glaa027) THEN
                  CALL agli010_glaa027_chk()
                  IF NOT cl_null(g_errno) THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = g_errno
                     LET g_errparam.extend = g_glaa_m.glaa027
                     LET g_errparam.popup = FALSE
                     CALL cl_err()
                     LET g_glaa_m.glaa027 = g_glaa_m_t.glaa027
                     NEXT FIELD glaa027
                  END IF
               END IF
            END IF               
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glaacomp
            #add-point:BEFORE FIELD glaacomp name="input.b.glaacomp"
                        
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE glaacomp
            #add-point:ON CHANGE glaacomp name="input.g.glaacomp"
                        
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glaa027
            #add-point:BEFORE FIELD glaa027 name="input.b.glaa027"
            IF cl_null(g_glaa_m.glaa027) THEN
               SELECT ooef005 INTO g_glaa_m.glaa027 FROM ooef_t 
                WHERE ooefent=g_enterprise AND ooef001=g_glaa_m.glaacomp
            END IF
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glaa027
            
            #add-point:AFTER FIELD glaa027 name="input.a.glaa027"
            IF NOT cl_null(g_glaa_m.glaa027) THEN
               IF p_cmd='a' OR (p_cmd='u' AND (g_glaa_m.glaa027 <> g_glaa_m_t.glaa027 OR cl_null(g_glaa_m_t.glaa027))) THEN
                  CALL agli010_glaa027_chk()
                  IF NOT cl_null(g_errno) THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = g_errno
                     LET g_errparam.extend = g_glaa_m.glaa027
                     LET g_errparam.popup = FALSE
                     CALL cl_err()
                     LET g_glaa_m.glaa027 = g_glaa_m_t.glaa027
                     NEXT FIELD glaa027
                  END IF
               END IF
            END IF
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE glaa027
            #add-point:ON CHANGE glaa027 name="input.g.glaa027"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glaa026
            
            #add-point:AFTER FIELD glaa026 name="input.a.glaa026"
            IF NOT cl_null(g_glaa_m.glaa026) THEN
               SELECT ooalstus  INTO l_ooalstus FROM ooal_t 
                WHERE ooalent = g_enterprise
                  AND ooal002 = g_glaa_m.glaa026
                  AND ooal001 = '10'
               IF sqlca.sqlcode = 100 THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'art-00164'
                  LET g_errparam.extend = ''
                  LET g_errparam.popup = FALSE
                  CALL cl_err()

                  LET g_glaa_m.glaa026=g_glaa_m_t.glaa026
                  NEXT FIELD glaa026
               END IF
               IF l_ooalstus='N' THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'art-00165'
                  LET g_errparam.extend = ''
                  LET g_errparam.popup = FALSE
                  CALL cl_err()

                  LET g_glaa_m.glaa026=g_glaa_m_t.glaa026
                  NEXT FIELD glaa026
               END IF
               #151216-00004#1--add--str--
               #当前账套为主账套时，要求币别参照表等于法人设置的币别参照表
               IF g_glaa_m.glaa014 = 'Y' THEN
                  LET l_ooef014 = ''
                  SELECT ooef014 INTO l_ooef014 FROM ooef_t
                   WHERE ooefent=g_enterprise AND ooef001=g_glaa_m.glaacomp
                  IF NOT cl_null(l_ooef014) AND l_ooef014 <> g_glaa_m.glaa026 THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = 'agl-00430'
                     LET g_errparam.extend = ''
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                     LET g_glaa_m.glaa026 = l_ooef014
                     CALL agli010_glaa026_desc(g_glaa_m.glaa026)
                     DISPLAY BY NAME g_glaa_m.glaa026_desc
                     NEXT FIELD glaa026
                  END IF
               END IF
               #151216-00004#1--add--end
               CALL agli010_glaa026_desc(g_glaa_m.glaa026)
               DISPLAY BY NAME g_glaa_m.glaa026_desc
            END IF
            IF NOT cl_null(g_glaa_m.glaa026) AND NOT cl_null(g_glaa_m.glaa001) AND NOT cl_null(g_glaa_m.glaa002) THEN
               IF NOT agli010_glaa001_002_026_chk() THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'agl-00272'
                  LET g_errparam.extend = ''
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

               END IF
            END IF
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glaa026
            #add-point:BEFORE FIELD glaa026 name="input.b.glaa026"
                        
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE glaa026
            #add-point:ON CHANGE glaa026 name="input.g.glaa026"
                        
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glaa001
            
            #add-point:AFTER FIELD glaa001 name="input.a.glaa001"
            DISPLAY ' ' TO glaa001_desc
            IF NOT agli010_glaa001_chk(g_glaa_m.glaa001) THEN
               IF p_cmd = 'a' THEN
                  LET g_glaa_m.glaa001 = ''
               ELSE
                  LET g_glaa_m.glaa001 = g_glaa_m_t.glaa001
               END IF
               CALL agli010_glaa001_ref(g_glaa_m.glaa001)
                RETURNING g_glaa_m.glaa001_desc
               DISPLAY BY NAME g_glaa_m.glaa001_desc
               NEXT FIELD glaa001
            ELSE
               #151216-00004#1--add--str--
               #当前账套为主账套时，要求币别等于法人主币别
               IF g_glaa_m.glaa014 = 'Y' THEN
                  LET l_ooef016 = ''
                  SELECT ooef016 INTO l_ooef016 FROM ooef_t
                   WHERE ooefent=g_enterprise AND ooef001=g_glaa_m.glaacomp
                  IF NOT cl_null(l_ooef016) AND l_ooef016 <> g_glaa_m.glaa001 THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = 'agl-00428'
                     LET g_errparam.extend = ''
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                     LET g_glaa_m.glaa001 = l_ooef016
                     CALL agli010_glaa001_ref(g_glaa_m.glaa001) RETURNING g_glaa_m.glaa001_desc
                     DISPLAY BY NAME g_glaa_m.glaa001_desc
                     NEXT FIELD glaa001
                  END IF
               END IF
               #151216-00004#1--add--end
               
               IF NOT agli010_currency_chk(g_glaa_m.glaa001,g_glaa_m.glaa016,g_glaa_m.glaa020) THEN
                  IF p_cmd = 'a' THEN
                     LET g_glaa_m.glaa001 = ''
                  ELSE
                     LET g_glaa_m.glaa001 = g_glaa_m_t.glaa001
                  END IF
                  CALL agli010_glaa001_ref(g_glaa_m.glaa001)
                   RETURNING g_glaa_m.glaa001_desc
                  DISPLAY BY NAME g_glaa_m.glaa001_desc
                  NEXT FIELD glaa001
               END IF 
            END IF 
            IF NOT cl_null(g_glaa_m.glaa026) AND NOT cl_null(g_glaa_m.glaa001) AND NOT cl_null(g_glaa_m.glaa002) THEN
               IF NOT agli010_glaa001_002_026_chk() THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'agl-00272'
                  LET g_errparam.extend = ''
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

               END IF
            END IF
            CALL agli010_glaa001_ref(g_glaa_m.glaa001)
             RETURNING g_glaa_m.glaa001_desc
            DISPLAY BY NAME g_glaa_m.glaa001_desc
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glaa001
            #add-point:BEFORE FIELD glaa001 name="input.b.glaa001"
                        
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE glaa001
            #add-point:ON CHANGE glaa001 name="input.g.glaa001"
                        
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glaa002
            
            #add-point:AFTER FIELD glaa002 name="input.a.glaa002"
            DISPLAY ' ' TO glaa002_desc
            IF NOT cl_null(g_glaa_m.glaa002) THEN  #151216-00004#1 add
               IF NOT agli010_ooal_chk('1',g_glaa_m.glaa002,'glaa002') THEN
                  IF p_cmd = 'a' THEN
                     LET g_glaa_m.glaa002 = ''
                  ELSE
                     LET g_glaa_m.glaa002 = g_glaa_m_t.glaa002
                  END IF
                  CALL agli010_ooal_ref('1',g_glaa_m.glaa002) RETURNING g_glaa_m.glaa002_desc
                  DISPLAY BY NAME g_glaa_m.glaa002_desc
                  NEXT FIELD glaa002
               END IF 
               #151216-00004#1--add--str--
               #当前账套为主账套时，要求币别参照表等于法人设置的币别参照表
               IF g_glaa_m.glaa014 = 'Y' THEN
                  LET l_ooef015 = ''
                  SELECT ooef015 INTO l_ooef015 FROM ooef_t
                   WHERE ooefent=g_enterprise AND ooef001=g_glaa_m.glaacomp
                  IF NOT cl_null(l_ooef015) AND l_ooef015 <> g_glaa_m.glaa002 THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = 'agl-00431'
                     LET g_errparam.extend = ''
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                     LET g_glaa_m.glaa002 = l_ooef015
                     CALL agli010_ooal_ref('1',g_glaa_m.glaa002) RETURNING g_glaa_m.glaa002_desc
                     DISPLAY BY NAME g_glaa_m.glaa002_desc
                     NEXT FIELD glaa002
                  END IF
               END IF
               #151216-00004#1--add--end
               IF NOT cl_null(g_glaa_m.glaa026) AND NOT cl_null(g_glaa_m.glaa001) AND NOT cl_null(g_glaa_m.glaa002) THEN
                  IF NOT agli010_glaa001_002_026_chk() THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = 'agl-00272'
                     LET g_errparam.extend = ''
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
               
                  END IF
               END IF 
            END IF #151216-00004#1 add
            CALL agli010_ooal_ref('1',g_glaa_m.glaa002) RETURNING g_glaa_m.glaa002_desc
            DISPLAY BY NAME g_glaa_m.glaa002_desc

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glaa002
            #add-point:BEFORE FIELD glaa002 name="input.b.glaa002"
                        
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE glaa002
            #add-point:ON CHANGE glaa002 name="input.g.glaa002"
                        
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glaa025
            #add-point:BEFORE FIELD glaa025 name="input.b.glaa025"
                        
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glaa025
            
            #add-point:AFTER FIELD glaa025 name="input.a.glaa025"
                        
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE glaa025
            #add-point:ON CHANGE glaa025 name="input.g.glaa025"
                        
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glaa028
            #add-point:BEFORE FIELD glaa028 name="input.b.glaa028"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glaa028
            
            #add-point:AFTER FIELD glaa028 name="input.a.glaa028"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE glaa028
            #add-point:ON CHANGE glaa028 name="input.g.glaa028"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glaa003
            
            #add-point:AFTER FIELD glaa003 name="input.a.glaa003"
                                    DISPLAY ' ' TO glaa003_desc
            IF NOT agli010_glaa003_chk(g_glaa_m.glaa003) THEN
               IF p_cmd = 'a' THEN
                  LET g_glaa_m.glaa003 = ''
               ELSE
                  LET g_glaa_m.glaa003 = g_glaa_m_t.glaa003
               END IF 
               CALL agli010_ooal_ref('13',g_glaa_m.glaa003) RETURNING g_glaa_m.glaa003_desc
               DISPLAY BY NAME g_glaa_m.glaa003_desc
               NEXT FIELD glaa003
            END IF 
            CALL agli010_ooal_ref('13',g_glaa_m.glaa003) RETURNING g_glaa_m.glaa003_desc
            DISPLAY BY NAME g_glaa_m.glaa003_desc

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glaa003
            #add-point:BEFORE FIELD glaa003 name="input.b.glaa003"
                        
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE glaa003
            #add-point:ON CHANGE glaa003 name="input.g.glaa003"
                        
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glaa004
            
            #add-point:AFTER FIELD glaa004 name="input.a.glaa004"
                                    DISPLAY ' ' TO glaa004_desc
            IF NOT agli010_ooal_chk('0',g_glaa_m.glaa004,'glaa004') THEN
               IF p_cmd = 'a' THEN
                  LET g_glaa_m.glaa004 = ''
               ELSE
                  LET g_glaa_m.glaa004 = g_glaa_m_t.glaa004
               END IF 
               CALL agli010_ooal_ref('0',g_glaa_m.glaa004) RETURNING g_glaa_m.glaa004_desc
               DISPLAY BY NAME g_glaa_m.glaa004_desc
               NEXT FIELD glaa004
            END IF 
            CALL agli010_ooal_ref('0',g_glaa_m.glaa004) RETURNING g_glaa_m.glaa004_desc
            DISPLAY BY NAME g_glaa_m.glaa004_desc

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glaa004
            #add-point:BEFORE FIELD glaa004 name="input.b.glaa004"
                        
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE glaa004
            #add-point:ON CHANGE glaa004 name="input.g.glaa004"
                        
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glaa024
            
            #add-point:AFTER FIELD glaa024 name="input.a.glaa024"
                                    DISPLAY ' ' TO glaa024_desc
            IF NOT cl_null(g_glaa_m.glaa024) THEN 
#此段落由子樣板a19產生
               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
               INITIALIZE g_chkparam.* TO NULL
               
               #設定g_chkparam.*的參數
               LET g_chkparam.arg1 = g_glaa_m.glaa024
               #160318-00025#38  2016/04/21  by pengxin  add(S)
               LET g_errshow = TRUE #是否開窗 
               LET g_chkparam.err_str[1] = "aoo-00170:sub-01324|aooi073|",cl_get_progname("aooi073",g_lang,"2"),"|:EXEPROGaooi073"
               LET g_chkparam.err_str[2] = "aoo-00171:sub-01302|aooi073|",cl_get_progname("aooi073",g_lang,"2"),"|:EXEPROGaooi073"
               #160318-00025#38  2016/04/21  by pengxin  add(E)
                  
               #呼叫檢查存在並帶值的library
               IF cl_chk_exist("v_ooal002_3") THEN
                  #檢查成功時後續處理
                  #LET  = g_chkparam.return1
                  #DISPLAY BY NAME 

               ELSE
                  IF p_cmd = 'a' THEN
                     LET g_glaa_m.glaa024 = ''
                  ELSE
                     LET g_glaa_m.glaa024 = g_glaa_m_t.glaa024
                  END IF 
                  CALL agli010_ooal_ref('3',g_glaa_m.glaa024) RETURNING g_glaa_m.glaa024_desc
                  DISPLAY BY NAME g_glaa_m.glaa024_desc
                  #檢查失敗時後續處理
                  NEXT FIELD CURRENT
               END IF
            

            END IF 
            CALL agli010_ooal_ref('3',g_glaa_m.glaa024) RETURNING g_glaa_m.glaa024_desc
            DISPLAY BY NAME g_glaa_m.glaa024_desc

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glaa024
            #add-point:BEFORE FIELD glaa024 name="input.b.glaa024"
                        
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE glaa024
            #add-point:ON CHANGE glaa024 name="input.g.glaa024"
                        
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glaa005
            
            #add-point:AFTER FIELD glaa005 name="input.a.glaa005"
                                    DISPLAY ' ' TO glaa005_desc
            IF NOT agli010_ooal_chk('8',g_glaa_m.glaa005,'glaa005') THEN
               IF p_cmd = 'a' THEN
                  LET g_glaa_m.glaa005 = ''
               ELSE
                  LET g_glaa_m.glaa005 = g_glaa_m_t.glaa005
               END IF 
               CALL agli010_ooal_ref('8',g_glaa_m.glaa005) RETURNING g_glaa_m.glaa005_desc
               DISPLAY BY NAME g_glaa_m.glaa005_desc
               NEXT FIELD glaa005
            END IF 
            CALL agli010_ooal_ref('8',g_glaa_m.glaa005) RETURNING g_glaa_m.glaa005_desc
            DISPLAY BY NAME g_glaa_m.glaa005_desc

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glaa005
            #add-point:BEFORE FIELD glaa005 name="input.b.glaa005"
                        
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE glaa005
            #add-point:ON CHANGE glaa005 name="input.g.glaa005"
                        
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glaa006
            #add-point:BEFORE FIELD glaa006 name="input.b.glaa006"
                        
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glaa006
            
            #add-point:AFTER FIELD glaa006 name="input.a.glaa006"
                        
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE glaa006
            #add-point:ON CHANGE glaa006 name="input.g.glaa006"
                        
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glaa007
            #add-point:BEFORE FIELD glaa007 name="input.b.glaa007"
                        
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glaa007
            
            #add-point:AFTER FIELD glaa007 name="input.a.glaa007"
                        
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE glaa007
            #add-point:ON CHANGE glaa007 name="input.g.glaa007"
                        
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glaa014
            #add-point:BEFORE FIELD glaa014 name="input.b.glaa014"
                        
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glaa014
            
            #add-point:AFTER FIELD glaa014 name="input.a.glaa014"
                                    IF g_glaa_m.glaa014 = 'Y' THEN
               LET lc_count = 0
               SELECT COUNT(*) INTO lc_count FROM glaa_t
                WHERE glaacomp = g_glaa_m.glaacomp AND glaa014 = 'Y'
                  AND glaald != g_glaa_m.glaald AND glaaent = g_enterprise
               IF lc_count >= 1 THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'agl-00006'
                  LET g_errparam.extend = ''
                  LET g_errparam.popup = FALSE
                  CALL cl_err()

                  LET g_glaa_m.glaa014 = 'N'
                  NEXT FIELD glaa014
               END IF
            END IF
            IF g_glaa_m.glaa008 = 'Y' AND g_glaa_m.glaa014 !='Y' THEN
               IF NOT agli010_glaa008_chk(g_glaa_m.glaa008,g_glaa_m.glaacomp,g_glaa_m.glaald) THEN
                  LET g_glaa_m.glaa008 = 'N'
                  LET g_glaa_m.glaa009 = '1'
               END IF 
            END IF
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE glaa014
            #add-point:ON CHANGE glaa014 name="input.g.glaa014"
            CALL agli010_set_entry(p_cmd)
            CALL agli010_set_no_entry(p_cmd)
            #151216-00004#1--add--str--
            IF g_glaa_m.glaa014 = 'Y' THEN
               IF NOT cl_null(g_glaa_m.glaa026) AND NOT cl_null(g_glaa_m.glaa001) AND NOT cl_null(g_glaa_m.glaa002) THEN
                  LET l_cnt = 0
                  SELECT COUNT(*) INTO l_cnt FROM ooef_t
                   WHERE ooefent=g_enterprise
                     AND ooef001=g_glaa_m.glaacomp
                     AND ooef014 = g_glaa_m.glaa026
                     AND ooef015 = g_glaa_m.glaa002
                     AND ooef016 = g_glaa_m.glaa001 
                  IF l_cnt = 0 THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = 'agl-00429'
                     LET g_errparam.extend = g_glaa_m.glaacomp
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                     LET g_glaa_m.glaa014 = 'N'
                     NEXT FIELD glaa014
                  END IF
               END IF
            END IF
            #151216-00004#1--add--end
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glaa008
            #add-point:BEFORE FIELD glaa008 name="input.b.glaa008"
                        
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glaa008
            
            #add-point:AFTER FIELD glaa008 name="input.a.glaa008"
                         
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE glaa008
            #add-point:ON CHANGE glaa008 name="input.g.glaa008"
            CALL agli010_set_entry(p_cmd)
            CALL agli010_set_no_entry(p_cmd)            
            DISPLAY BY NAME g_glaa_m.glaa009
            IF g_glaa_m.glaa008 = 'Y' AND g_glaa_m.glaa014 !='Y' THEN
               IF NOT agli010_glaa008_chk(g_glaa_m.glaa008,g_glaa_m.glaacomp,g_glaa_m.glaald) THEN
                  LET g_glaa_m.glaa008 = 'N'
                  LET g_glaa_m.glaa009 = '1'
               END IF 
            END IF
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glaa023
            #add-point:BEFORE FIELD glaa023 name="input.b.glaa023"
                        
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glaa023
            
            #add-point:AFTER FIELD glaa023 name="input.a.glaa023"
                        
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE glaa023
            #add-point:ON CHANGE glaa023 name="input.g.glaa023"
            #160310-00008#1--add--str--
            IF NOT cl_null(g_glaa_m.glaa023) THEN
               LET l_cnt=0
               SELECT COUNT(*) INTO l_cnt FROM glaa_t
                WHERE glaaent=g_enterprise AND glaacomp=g_glaa_m.glaacomp
                  AND glaa008='Y' AND glaa023=g_glaa_m.glaa023
               IF l_cnt > 0 THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'agl-00427'
                  LET g_errparam.extend = g_glaa_m.glaacomp
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
                  LET g_glaa_m.glaa023 = g_glaa_m_t.glaa023
                  NEXT FIELD glaa023
               END IF
            END IF
            #160310-00008#1--add--end           
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glaa009
            #add-point:BEFORE FIELD glaa009 name="input.b.glaa009"
                                    
            CALL agli010_set_entry(p_cmd)
            CALL agli010_set_no_entry(p_cmd) 
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glaa009
            
            #add-point:AFTER FIELD glaa009 name="input.a.glaa009"
                        
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE glaa009
            #add-point:ON CHANGE glaa009 name="input.g.glaa009"
                        
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glaa130
            #add-point:BEFORE FIELD glaa130 name="input.b.glaa130"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glaa130
            
            #add-point:AFTER FIELD glaa130 name="input.a.glaa130"
 
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE glaa130
            #add-point:ON CHANGE glaa130 name="input.g.glaa130"
            #151113-00002#7 151117 by sakura add(S)
            IF g_glaa_m.glaa130 = 'Y' THEN
               CALL cl_set_comp_visible("page_4",TRUE)   #合併報表
            ELSE
               CALL cl_set_comp_visible("page_4",FALSE)   #合併報表   
            END IF
            #151113-00002#7 151117 by sakura add(E) 
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glaa010
            #add-point:BEFORE FIELD glaa010 name="input.b.glaa010"
                        
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glaa010
            
            #add-point:AFTER FIELD glaa010 name="input.a.glaa010"
                        
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE glaa010
            #add-point:ON CHANGE glaa010 name="input.g.glaa010"
                        
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glaa011
            #add-point:BEFORE FIELD glaa011 name="input.b.glaa011"
                        
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glaa011
            
            #add-point:AFTER FIELD glaa011 name="input.a.glaa011"
                        
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE glaa011
            #add-point:ON CHANGE glaa011 name="input.g.glaa011"
                        
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glaa012
            #add-point:BEFORE FIELD glaa012 name="input.b.glaa012"
                        
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glaa012
            
            #add-point:AFTER FIELD glaa012 name="input.a.glaa012"
                        
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE glaa012
            #add-point:ON CHANGE glaa012 name="input.g.glaa012"
                        
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glaa013
            #add-point:BEFORE FIELD glaa013 name="input.b.glaa013"
                        
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glaa013
            
            #add-point:AFTER FIELD glaa013 name="input.a.glaa013"
                        
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE glaa013
            #add-point:ON CHANGE glaa013 name="input.g.glaa013"
                        
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glaastus
            #add-point:BEFORE FIELD glaastus name="input.b.glaastus"
                        
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glaastus
            
            #add-point:AFTER FIELD glaastus name="input.a.glaastus"
                        
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE glaastus
            #add-point:ON CHANGE glaastus name="input.g.glaastus"
                        
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glaa015
            #add-point:BEFORE FIELD glaa015 name="input.b.glaa015"
                        
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glaa015
            
            #add-point:AFTER FIELD glaa015 name="input.a.glaa015"
                        
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE glaa015
            #add-point:ON CHANGE glaa015 name="input.g.glaa015"
                                    IF g_glaa_m.glaa015 = 'Y' THEN
               LET g_glaa_m.glaa017 = '1'
            END IF
            CALL agli010_set_entry(p_cmd)
            CALL agli010_set_no_entry(p_cmd) 
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glaa019
            #add-point:BEFORE FIELD glaa019 name="input.b.glaa019"
                        
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glaa019
            
            #add-point:AFTER FIELD glaa019 name="input.a.glaa019"
                        
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE glaa019
            #add-point:ON CHANGE glaa019 name="input.g.glaa019"
                                    IF g_glaa_m.glaa019 = 'Y' THEN
               LET g_glaa_m.glaa021 = '1'
            END IF
            CALL agli010_set_entry(p_cmd)
            CALL agli010_set_no_entry(p_cmd)
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glaa016
            #add-point:BEFORE FIELD glaa016 name="input.b.glaa016"
                        
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glaa016
            
            #add-point:AFTER FIELD glaa016 name="input.a.glaa016"
                        #            DISPLAY ' ' TO glaa016_desc
            IF NOT agli010_glaa001_chk(g_glaa_m.glaa016) THEN
               IF p_cmd = 'a' THEN
                  LET g_glaa_m.glaa016 = ''
               ELSE
                  LET g_glaa_m.glaa016 = g_glaa_m_t.glaa016
               END IF
#               CALL agli010_glaa001_ref(g_glaa_m.glaa016)
#                RETURNING g_glaa_m.glaa016_desc
#               DISPLAY BY NAME g_glaa_m.glaa016_desc
               NEXT FIELD glaa016
            ELSE
               IF not agli010_currency_chk(g_glaa_m.glaa001,g_glaa_m.glaa016,g_glaa_m.glaa020) THEN
                  IF p_cmd = 'a' THEN
                     LET g_glaa_m.glaa016 = ''
                  ELSE
                     LET g_glaa_m.glaa016 = g_glaa_m_t.glaa016
                  END IF
#                  CALL agli010_glaa001_ref(g_glaa_m.glaa016)
#                   RETURNING g_glaa_m.glaa016_desc
#                  DISPLAY BY NAME g_glaa_m.glaa016_desc
                  NEXT FIELD glaa016
               END IF
            END IF 
#            CALL agli010_glaa001_ref(g_glaa_m.glaa016)
#             RETURNING g_glaa_m.glaa016_desc
#            DISPLAY BY NAME g_glaa_m.glaa016_desc

            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE glaa016
            #add-point:ON CHANGE glaa016 name="input.g.glaa016"
                        
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glaa020
            #add-point:BEFORE FIELD glaa020 name="input.b.glaa020"
                        
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glaa020
            
            #add-point:AFTER FIELD glaa020 name="input.a.glaa020"
                        #            DISPLAY ' ' TO glaa016_desc
            IF NOT agli010_glaa001_chk(g_glaa_m.glaa020) THEN
               IF p_cmd = 'a' THEN
                  LET g_glaa_m.glaa020 = ''
               ELSE
                  LET g_glaa_m.glaa020 = g_glaa_m_t.glaa020
               END IF
#               CALL agli010_glaa001_ref(g_glaa_m.glaa020)
#                RETURNING g_glaa_m.glaa020_desc
#               DISPLAY BY NAME g_glaa_m.glaa020_desc
               NEXT FIELD glaa020
            ELSE
               IF not agli010_currency_chk(g_glaa_m.glaa001,g_glaa_m.glaa016,g_glaa_m.glaa020) THEN
                  IF p_cmd = 'a' THEN
                     LET g_glaa_m.glaa020 = ''
                  ELSE
                     LET g_glaa_m.glaa020 = g_glaa_m_t.glaa020
                  END IF
#                  CALL agli010_glaa001_ref(g_glaa_m.glaa020)
#                   RETURNING g_glaa_m.glaa020_desc
#                  DISPLAY BY NAME g_glaa_m.glaa020_desc
                  NEXT FIELD glaa020
               END IF
            END IF 
#            CALL agli010_glaa001_ref(g_glaa_m.glaa020
#             RETURNING g_glaa_m.glaa020_desc
#            DISPLAY BY NAME g_glaa_m.glaa020_desc
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE glaa020
            #add-point:ON CHANGE glaa020 name="input.g.glaa020"
                        
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glaa017
            #add-point:BEFORE FIELD glaa017 name="input.b.glaa017"
                        
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glaa017
            
            #add-point:AFTER FIELD glaa017 name="input.a.glaa017"
                        
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE glaa017
            #add-point:ON CHANGE glaa017 name="input.g.glaa017"
                        
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glaa021
            #add-point:BEFORE FIELD glaa021 name="input.b.glaa021"
                        
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glaa021
            
            #add-point:AFTER FIELD glaa021 name="input.a.glaa021"
                        
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE glaa021
            #add-point:ON CHANGE glaa021 name="input.g.glaa021"
                        
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glaa018
            #add-point:BEFORE FIELD glaa018 name="input.b.glaa018"
                        
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glaa018
            
            #add-point:AFTER FIELD glaa018 name="input.a.glaa018"
                        
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE glaa018
            #add-point:ON CHANGE glaa018 name="input.g.glaa018"
                        
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glaa022
            #add-point:BEFORE FIELD glaa022 name="input.b.glaa022"
                        
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glaa022
            
            #add-point:AFTER FIELD glaa022 name="input.a.glaa022"
                        
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE glaa022
            #add-point:ON CHANGE glaa022 name="input.g.glaa022"
                        
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glaa100
            #add-point:BEFORE FIELD glaa100 name="input.b.glaa100"
                        
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glaa100
            
            #add-point:AFTER FIELD glaa100 name="input.a.glaa100"
                        
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE glaa100
            #add-point:ON CHANGE glaa100 name="input.g.glaa100"
                        
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glaa101
            #add-point:BEFORE FIELD glaa101 name="input.b.glaa101"
                        
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glaa101
            
            #add-point:AFTER FIELD glaa101 name="input.a.glaa101"
                        
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE glaa101
            #add-point:ON CHANGE glaa101 name="input.g.glaa101"
                        
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glaa102
            #add-point:BEFORE FIELD glaa102 name="input.b.glaa102"
                        
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glaa102
            
            #add-point:AFTER FIELD glaa102 name="input.a.glaa102"
                        
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE glaa102
            #add-point:ON CHANGE glaa102 name="input.g.glaa102"
                        
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glaa103
            #add-point:BEFORE FIELD glaa103 name="input.b.glaa103"
                        
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glaa103
            
            #add-point:AFTER FIELD glaa103 name="input.a.glaa103"
                        
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE glaa103
            #add-point:ON CHANGE glaa103 name="input.g.glaa103"
                        
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glaa111
            
            #add-point:AFTER FIELD glaa111 name="input.a.glaa111"
                                    IF NOT cl_null(g_glaa_m.glaa111) THEN 
#此段落由子樣板a19產生
               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
               INITIALIZE g_chkparam.* TO NULL
               
               #設定g_chkparam.*的參數
               LET g_chkparam.arg1 = g_glaa_m.glaa024
               LET g_chkparam.arg2 = g_glaa_m.glaa111
               
               #160318-00025#38  2016/04/21  by pengxin  add(S)
               LET g_errshow = TRUE #是否開窗 
               LET g_chkparam.err_str[1] = "agl-00189:sub-01302|aooi200|",cl_get_progname("aooi200",g_lang,"2"),"|:EXEPROGaooi200"
               #160318-00025#38  2016/04/21  by pengxin  add(E)
                  
               #呼叫檢查存在並帶值的library
               IF cl_chk_exist("v_ooba002_01") THEN
                  #檢查成功時後續處理
                  #LET  = g_chkparam.return1
                  #DISPLAY BY NAME 

               ELSE
                  IF p_cmd = 'a' THEN
                     LET g_glaa_m.glaa111 = ''
                  ELSE
                     LET g_glaa_m.glaa111 = g_glaa_m_t.glaa111
                  END IF
                  #檢查失敗時後續處理
                  NEXT FIELD CURRENT
               END IF
            

            END IF 
            #160413-00010#1--add--str--
            CALL agli010_get_oobxl003(g_glaa_m.glaa111) RETURNING g_glaa_m.glaa111_desc
            DISPLAY g_glaa_m.glaa111_desc TO glaa111_desc
            #160413-00010#1--add--end
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glaa111
            #add-point:BEFORE FIELD glaa111 name="input.b.glaa111"
                                    IF cl_null(g_glaa_m.glaa024) THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = 'agl-00193'
               LET g_errparam.extend = ''
               LET g_errparam.popup = TRUE
               CALL cl_err()

               NEXT FIELD glaa024
            END IF 
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE glaa111
            #add-point:ON CHANGE glaa111 name="input.g.glaa111"
                        
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glaa112
            
            #add-point:AFTER FIELD glaa112 name="input.a.glaa112"
                                    IF NOT cl_null(g_glaa_m.glaa112) THEN 
#此段落由子樣板a19產生
               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
               INITIALIZE g_chkparam.* TO NULL
               
               #設定g_chkparam.*的參數
               LET g_chkparam.arg1 = g_glaa_m.glaa024
               LET g_chkparam.arg2 = g_glaa_m.glaa112

               #160318-00025#38  2016/04/21  by pengxin  add(S)
               LET g_errshow = TRUE #是否開窗 
               LET g_chkparam.err_str[1] = "agl-00189:sub-01302|aooi200|",cl_get_progname("aooi200",g_lang,"2"),"|:EXEPROGaooi200"
               #160318-00025#38  2016/04/21  by pengxin  add(E)
               
               #呼叫檢查存在並帶值的library
               IF cl_chk_exist("v_ooba002_02") THEN
                  #檢查成功時後續處理
                  #LET  = g_chkparam.return1
                  #DISPLAY BY NAME 

               ELSE
                  IF p_cmd = 'a' THEN
                     LET g_glaa_m.glaa112 = ''
                  ELSE
                     LET g_glaa_m.glaa112 = g_glaa_m_t.glaa112
                  END IF
                  #檢查失敗時後續處理
                  NEXT FIELD CURRENT
               END IF
            

            END IF 
            #160413-00010#1--add--str--
            CALL agli010_get_oobxl003(g_glaa_m.glaa112) RETURNING g_glaa_m.glaa112_desc
            DISPLAY g_glaa_m.glaa112_desc TO glaa112_desc
            #160413-00010#1--add--end
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glaa112
            #add-point:BEFORE FIELD glaa112 name="input.b.glaa112"
                                    IF cl_null(g_glaa_m.glaa024) THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = 'agl-00193'
               LET g_errparam.extend = ''
               LET g_errparam.popup = TRUE
               CALL cl_err()

               NEXT FIELD glaa024
            END IF 
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE glaa112
            #add-point:ON CHANGE glaa112 name="input.g.glaa112"
                        
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glaa113
            
            #add-point:AFTER FIELD glaa113 name="input.a.glaa113"
                                    IF NOT cl_null(g_glaa_m.glaa113) THEN 
#此段落由子樣板a19產生
               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
               INITIALIZE g_chkparam.* TO NULL
               
               #設定g_chkparam.*的參數
               LET g_chkparam.arg1 = g_glaa_m.glaa024
               LET g_chkparam.arg2 = g_glaa_m.glaa113
               
               #160318-00025#38  2016/04/21  by pengxin  add(S)
               LET g_errshow = TRUE #是否開窗 
               LET g_chkparam.err_str[1] = "agl-00189:sub-01302|aooi200|",cl_get_progname("aooi200",g_lang,"2"),"|:EXEPROGaooi200"
               #160318-00025#38  2016/04/21  by pengxin  add(E)
                  
               #呼叫檢查存在並帶值的library
               IF cl_chk_exist("v_ooba002_03") THEN
                  #檢查成功時後續處理
                  #LET  = g_chkparam.return1
                  #DISPLAY BY NAME 

               ELSE
                  IF p_cmd = 'a' THEN
                     LET g_glaa_m.glaa113 = ''
                  ELSE
                     LET g_glaa_m.glaa113 = g_glaa_m_t.glaa113
                  END IF
                  #檢查失敗時後續處理
                  NEXT FIELD CURRENT
               END IF
            

            END IF 
            #160413-00010#1--add--str--
            CALL agli010_get_oobxl003(g_glaa_m.glaa113) RETURNING g_glaa_m.glaa113_desc
            DISPLAY g_glaa_m.glaa113_desc TO glaa113_desc
            #160413-00010#1--add--end
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glaa113
            #add-point:BEFORE FIELD glaa113 name="input.b.glaa113"
                                    IF cl_null(g_glaa_m.glaa024) THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = 'agl-00193'
               LET g_errparam.extend = ''
               LET g_errparam.popup = TRUE
               CALL cl_err()

               NEXT FIELD glaa024
            END IF 
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE glaa113
            #add-point:ON CHANGE glaa113 name="input.g.glaa113"
                        
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glaa120
            
            #add-point:AFTER FIELD glaa120 name="input.a.glaa120"
                                    DISPLAY '' TO glaa120_desc
            IF NOT cl_null(g_glaa_m.glaa120) THEN 
               INITIALIZE g_chkparam.* TO NULL
               
               #設定g_chkparam.*的參數
               LET g_chkparam.arg1 = g_glaa_m.glaald
               LET g_chkparam.arg2 = g_glaa_m.glaa120
               #160318-00025#38  2016/04/21  by pengxin  add(S)
               LET g_errshow = TRUE #是否開窗 
               LET g_chkparam.err_str[1] = "agl-00355:sub-01302|axci101|",cl_get_progname("axci101",g_lang,"2"),"|:EXEPROGaxci101"
               #160318-00025#38  2016/04/21  by pengxin  add(E)
               #呼叫檢查存在並帶值的library
               IF cl_chk_exist("v_xcaz001") THEN
                  #檢查成功時後續處理
                  #LET  = g_chkparam.return1
                  #DISPLAY BY NAME 

               ELSE
                  IF p_cmd = 'a' THEN
                     LET g_glaa_m.glaa120 = ''
                  ELSE
                     LET g_glaa_m.glaa120 = g_glaa_m_t.glaa120
                  END IF
                  CALL agli010_glaa120_ref(g_glaa_m.glaald,g_glaa_m.glaa120)
                     RETURNING g_glaa_m.glaa120_desc
                  DISPLAY g_glaa_m.glaa120_desc TO glaa120_desc
                  #檢查失敗時後續處理
                  NEXT FIELD CURRENT
               END IF
               
            END IF 
            CALL agli010_glaa120_ref(g_glaa_m.glaald,g_glaa_m.glaa120)
               RETURNING g_glaa_m.glaa120_desc
            DISPLAY g_glaa_m.glaa120_desc TO glaa120_desc
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glaa120
            #add-point:BEFORE FIELD glaa120 name="input.b.glaa120"
                        
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE glaa120
            #add-point:ON CHANGE glaa120 name="input.g.glaa120"
                        
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glaa121
            #add-point:BEFORE FIELD glaa121 name="input.b.glaa121"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glaa121
            
            #add-point:AFTER FIELD glaa121 name="input.a.glaa121"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE glaa121
            #add-point:ON CHANGE glaa121 name="input.g.glaa121"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glaa136
            #add-point:BEFORE FIELD glaa136 name="input.b.glaa136"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glaa136
            
            #add-point:AFTER FIELD glaa136 name="input.a.glaa136"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE glaa136
            #add-point:ON CHANGE glaa136 name="input.g.glaa136"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glaa137
            #add-point:BEFORE FIELD glaa137 name="input.b.glaa137"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glaa137
            
            #add-point:AFTER FIELD glaa137 name="input.a.glaa137"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE glaa137
            #add-point:ON CHANGE glaa137 name="input.g.glaa137"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glaa139
            #add-point:BEFORE FIELD glaa139 name="input.b.glaa139"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glaa139
            
            #add-point:AFTER FIELD glaa139 name="input.a.glaa139"
 
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE glaa139
            #add-point:ON CHANGE glaa139 name="input.g.glaa139"
            CALL agli010_set_entry(p_cmd)
            CALL agli010_set_no_entry(p_cmd) 
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glaa140
            #add-point:BEFORE FIELD glaa140 name="input.b.glaa140"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glaa140
            
            #add-point:AFTER FIELD glaa140 name="input.a.glaa140"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE glaa140
            #add-point:ON CHANGE glaa140 name="input.g.glaa140"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glaa122
            #add-point:BEFORE FIELD glaa122 name="input.b.glaa122"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glaa122
            
            #add-point:AFTER FIELD glaa122 name="input.a.glaa122"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE glaa122
            #add-point:ON CHANGE glaa122 name="input.g.glaa122"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glaa123
            #add-point:BEFORE FIELD glaa123 name="input.b.glaa123"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glaa123
            
            #add-point:AFTER FIELD glaa123 name="input.a.glaa123"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE glaa123
            #add-point:ON CHANGE glaa123 name="input.g.glaa123"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glaa124
            #add-point:BEFORE FIELD glaa124 name="input.b.glaa124"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glaa124
            
            #add-point:AFTER FIELD glaa124 name="input.a.glaa124"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE glaa124
            #add-point:ON CHANGE glaa124 name="input.g.glaa124"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glaa131
            #add-point:BEFORE FIELD glaa131 name="input.b.glaa131"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glaa131
            
            #add-point:AFTER FIELD glaa131 name="input.a.glaa131"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE glaa131
            #add-point:ON CHANGE glaa131 name="input.g.glaa131"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glaa132
            #add-point:BEFORE FIELD glaa132 name="input.b.glaa132"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glaa132
            
            #add-point:AFTER FIELD glaa132 name="input.a.glaa132"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE glaa132
            #add-point:ON CHANGE glaa132 name="input.g.glaa132"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glaa133
            #add-point:BEFORE FIELD glaa133 name="input.b.glaa133"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glaa133
            
            #add-point:AFTER FIELD glaa133 name="input.a.glaa133"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE glaa133
            #add-point:ON CHANGE glaa133 name="input.g.glaa133"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glaa134
            #add-point:BEFORE FIELD glaa134 name="input.b.glaa134"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glaa134
            
            #add-point:AFTER FIELD glaa134 name="input.a.glaa134"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE glaa134
            #add-point:ON CHANGE glaa134 name="input.g.glaa134"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glaa138
            #add-point:BEFORE FIELD glaa138 name="input.b.glaa138"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glaa138
            
            #add-point:AFTER FIELD glaa138 name="input.a.glaa138"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE glaa138
            #add-point:ON CHANGE glaa138 name="input.g.glaa138"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glaa135
            
            #add-point:AFTER FIELD glaa135 name="input.a.glaa135"
            #140314-00001#4-----s
            #輸入值須存在[T:參照表檔].[C:參照表號]、[C:參照表類型]=9且為有效資料,
            #若資料不存在則詢問「輸入的參照表號不存在參照表檔,請問是否要新增此參照表號?」，
            #若選擇是則呼叫應用元件s_aooi070_ins()做參照表號的新增；
            #否則停留在本欄位
            LET g_glaa_m.glaa135_desc = ' '
            DISPLAY BY NAME g_glaa_m.glaa135_desc
            IF NOT cl_null(g_glaa_m.glaa135) THEN
               IF p_cmd = 'a' OR (p_cmd = 'u' AND (g_glaa_m.glaa135 != g_glaa_m_t.glaa135 OR g_glaa_m_t.glaa135 IS NULL )) THEN
                  CALL agli010_chk_glaa135(g_glaa_m.glaa135)RETURNING g_errno
                  IF NOT cl_null(g_errno) THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = g_errno
                     LET g_errparam.extend = g_glaa_m.glaa135
                     #160318-00005#12  --add--str
                     LET g_errparam.replace[1] ='aooi086'
                     LET g_errparam.replace[2] = cl_get_progname('aooi086',g_lang,"2")
                     LET g_errparam.exeprog    ='aooi086'
                     #160318-00005#12  --add--end
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                     LET g_glaa_m.glaa135 = g_glaa_m_t.glaa135
                     LET g_glaa_m.glaa135_desc = s_desc_ooal002_desc('16', g_glaa_m.glaa135)
                     DISPLAY BY NAME g_glaa_m.glaa135_desc
                     NEXT FIELD CURRENT
                  END IF
                  LET g_glaa_m.glaa135_desc = s_desc_ooal002_desc('16', g_glaa_m.glaa135)
                  DISPLAY BY NAME g_glaa_m.glaa135_desc
               END IF
            END IF
            LET g_glaa_m.glaa135_desc = s_desc_ooal002_desc('16', g_glaa_m.glaa135)
            DISPLAY BY NAME g_glaa_m.glaa135_desc
            
            #140314-00001#4-----e
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glaa135
            #add-point:BEFORE FIELD glaa135 name="input.b.glaa135"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE glaa135
            #add-point:ON CHANGE glaa135 name="input.g.glaa135"
            
            #END add-point 
 
 
 #欄位檢查
                  #Ctrlp:input.c.glaald
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glaald
            #add-point:ON ACTION controlp INFIELD glaald name="input.c.glaald"
                        
            #END add-point
 
 
         #Ctrlp:input.c.glaal002
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glaal002
            #add-point:ON ACTION controlp INFIELD glaal002 name="input.c.glaal002"
                        
            #END add-point
 
 
         #Ctrlp:input.c.glaacomp
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glaacomp
            #add-point:ON ACTION controlp INFIELD glaacomp name="input.c.glaacomp"
                        #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_glaa_m.glaacomp             #給予default值

            #給予arg

            CALL q_ooef001_2()                              #呼叫開窗

            LET g_glaa_m.glaacomp = g_qryparam.return1              #將開窗取得的值回傳到變數

            DISPLAY g_glaa_m.glaacomp TO glaacomp              #顯示到畫面上
            CALL agli010_glaacomp_ref(g_glaa_m.glaacomp) RETURNING g_glaa_m.glaacomp_desc
            IF NOT cl_null(g_glaa_m.glaacomp) THEN
               SELECT ooef014,ooef016,ooef015 INTO g_glaa_m.glaa026,g_glaa_m.glaa001,g_glaa_m.glaa002
                 FROM ooef_t
                WHERE ooefent = g_enterprise AND ooef001 = g_glaa_m.glaacomp
               CALL agli010_ooal_ref('1',g_glaa_m.glaa002) RETURNING g_glaa_m.glaa002_desc
               CALL agli010_glaa001_ref(g_glaa_m.glaa001) RETURNING g_glaa_m.glaa001_desc
               CALL agli010_glaa026_desc(g_glaa_m.glaa026)  
               DISPLAY BY NAME g_glaa_m.glaa001_desc,g_glaa_m.glaa002_desc,g_glaa_m.glaa026_desc
            END IF 
            DISPLAY BY NAME g_glaa_m.glaacomp_desc
            NEXT FIELD glaacomp                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.glaa027
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glaa027
            #add-point:ON ACTION controlp INFIELD glaa027 name="input.c.glaa027"
            
            #END add-point
 
 
         #Ctrlp:input.c.glaa026
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glaa026
            #add-point:ON ACTION controlp INFIELD glaa026 name="input.c.glaa026"
                        #此段落由子樣板a07產生            
            #開窗i段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
			LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_glaa_m.glaa026             #給予default值

            #給予arg

            CALL q_ooal002_10()                                #呼叫開窗

            LET g_glaa_m.glaa026 = g_qryparam.return1              #將開窗取得的值回傳到變數

            DISPLAY g_glaa_m.glaa026 TO glaa026              #顯示到畫面上
            CALL agli010_glaa026_desc(g_glaa_m.glaa026)
            DISPLAY BY NAME g_glaa_m.glaa026_desc
            NEXT FIELD glaa026                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.glaa001
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glaa001
            #add-point:ON ACTION controlp INFIELD glaa001 name="input.c.glaa001"
                        #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_glaa_m.glaa001             #給予default值

            #給予arg

            CALL q_ooai001()                                #呼叫開窗

            LET g_glaa_m.glaa001 = g_qryparam.return1              #將開窗取得的值回傳到變數

            DISPLAY g_glaa_m.glaa001 TO glaa001              #顯示到畫面上
            CALL agli010_glaa001_ref(g_glaa_m.glaa001) RETURNING g_glaa_m.glaa001_desc
            DISPLAY BY NAME g_glaa_m.glaa001_desc
            NEXT FIELD glaa001                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.glaa002
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glaa002
            #add-point:ON ACTION controlp INFIELD glaa002 name="input.c.glaa002"
                        #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_glaa_m.glaa002             #給予default值
            LET g_qryparam.where = " ooal001 = '1' "
            #給予arg

            CALL q_ooal002()                                #呼叫開窗

            LET g_glaa_m.glaa002 = g_qryparam.return1              #將開窗取得的值回傳到變數

            DISPLAY g_glaa_m.glaa002 TO glaa002              #顯示到畫面上
            LET g_qryparam.where =''
            CALL agli010_ooal_ref('1',g_glaa_m.glaa002) RETURNING g_glaa_m.glaa002_desc
            DISPLAY BY NAME g_glaa_m.glaa002_desc
            NEXT FIELD glaa002                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.glaa025
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glaa025
            #add-point:ON ACTION controlp INFIELD glaa025 name="input.c.glaa025"
                        
            #END add-point
 
 
         #Ctrlp:input.c.glaa028
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glaa028
            #add-point:ON ACTION controlp INFIELD glaa028 name="input.c.glaa028"
            
            #END add-point
 
 
         #Ctrlp:input.c.glaa003
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glaa003
            #add-point:ON ACTION controlp INFIELD glaa003 name="input.c.glaa003"
                        #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_glaa_m.glaa003             #給予default值
            #給予arg

            CALL q_glav001()                                 #呼叫開窗

            LET g_glaa_m.glaa003 = g_qryparam.return1              #將開窗取得的值回傳到變數
            LET g_qryparam.where = ''
            DISPLAY g_glaa_m.glaa003 TO glaa003              #顯示到畫面上
            CALL agli010_ooal_ref('13',g_glaa_m.glaa003) RETURNING g_glaa_m.glaa003_desc
            DISPLAY BY NAME g_glaa_m.glaa003_desc
            NEXT FIELD glaa003                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.glaa004
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glaa004
            #add-point:ON ACTION controlp INFIELD glaa004 name="input.c.glaa004"
                        #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_glaa_m.glaa004             #給予default值
            LET g_qryparam.where = " ooal001 = '0' "
            #給予arg

            CALL q_ooal002()                                #呼叫開窗

            LET g_glaa_m.glaa004 = g_qryparam.return1              #將開窗取得的值回傳到變數

            DISPLAY g_glaa_m.glaa004 TO glaa004              #顯示到畫面上
            LET g_qryparam.where = ''
            CALL agli010_ooal_ref('0',g_glaa_m.glaa004) RETURNING g_glaa_m.glaa004_desc
            DISPLAY BY NAME g_glaa_m.glaa004_desc
            NEXT FIELD glaa004                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.glaa024
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glaa024
            #add-point:ON ACTION controlp INFIELD glaa024 name="input.c.glaa024"
                        #此段落由子樣板a07產生            
            #開窗i段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
			LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_glaa_m.glaa024             #給予default值
            LET g_qryparam.where = " ooal001 = '3' "
            #給予arg

            CALL q_ooal002()                                #呼叫開窗

            LET g_glaa_m.glaa024 = g_qryparam.return1              #將開窗取得的值回傳到變數
            LET g_qryparam.where = ''
            DISPLAY g_glaa_m.glaa024 TO glaa024              #顯示到畫面上
            CALL agli010_ooal_ref('3',g_glaa_m.glaa024) RETURNING g_glaa_m.glaa024_desc
            DISPLAY BY NAME g_glaa_m.glaa024_desc
            NEXT FIELD glaa024                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.glaa005
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glaa005
            #add-point:ON ACTION controlp INFIELD glaa005 name="input.c.glaa005"
                        #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_glaa_m.glaa005             #給予default值
            LET g_qryparam.where = " ooal001 = '8' "
            #給予arg

            CALL q_ooal002()                                #呼叫開窗

            LET g_glaa_m.glaa005 = g_qryparam.return1              #將開窗取得的值回傳到變數

            DISPLAY g_glaa_m.glaa005 TO glaa005              #顯示到畫面上
            LET g_qryparam.where = ''
            CALL agli010_ooal_ref('8',g_glaa_m.glaa005) RETURNING g_glaa_m.glaa005_desc
            DISPLAY BY NAME g_glaa_m.glaa005_desc
            NEXT FIELD glaa005                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.glaa006
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glaa006
            #add-point:ON ACTION controlp INFIELD glaa006 name="input.c.glaa006"
                        
            #END add-point
 
 
         #Ctrlp:input.c.glaa007
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glaa007
            #add-point:ON ACTION controlp INFIELD glaa007 name="input.c.glaa007"
                        
            #END add-point
 
 
         #Ctrlp:input.c.glaa014
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glaa014
            #add-point:ON ACTION controlp INFIELD glaa014 name="input.c.glaa014"
                        
            #END add-point
 
 
         #Ctrlp:input.c.glaa008
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glaa008
            #add-point:ON ACTION controlp INFIELD glaa008 name="input.c.glaa008"
                        
            #END add-point
 
 
         #Ctrlp:input.c.glaa023
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glaa023
            #add-point:ON ACTION controlp INFIELD glaa023 name="input.c.glaa023"
                        
            #END add-point
 
 
         #Ctrlp:input.c.glaa009
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glaa009
            #add-point:ON ACTION controlp INFIELD glaa009 name="input.c.glaa009"
                        
            #END add-point
 
 
         #Ctrlp:input.c.glaa130
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glaa130
            #add-point:ON ACTION controlp INFIELD glaa130 name="input.c.glaa130"
            
            #END add-point
 
 
         #Ctrlp:input.c.glaa010
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glaa010
            #add-point:ON ACTION controlp INFIELD glaa010 name="input.c.glaa010"
                        
            #END add-point
 
 
         #Ctrlp:input.c.glaa011
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glaa011
            #add-point:ON ACTION controlp INFIELD glaa011 name="input.c.glaa011"
                        
            #END add-point
 
 
         #Ctrlp:input.c.glaa012
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glaa012
            #add-point:ON ACTION controlp INFIELD glaa012 name="input.c.glaa012"
                        
            #END add-point
 
 
         #Ctrlp:input.c.glaa013
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glaa013
            #add-point:ON ACTION controlp INFIELD glaa013 name="input.c.glaa013"
                        
            #END add-point
 
 
         #Ctrlp:input.c.glaastus
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glaastus
            #add-point:ON ACTION controlp INFIELD glaastus name="input.c.glaastus"
                        
            #END add-point
 
 
         #Ctrlp:input.c.glaa015
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glaa015
            #add-point:ON ACTION controlp INFIELD glaa015 name="input.c.glaa015"
                        
            #END add-point
 
 
         #Ctrlp:input.c.glaa019
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glaa019
            #add-point:ON ACTION controlp INFIELD glaa019 name="input.c.glaa019"
                        
            #END add-point
 
 
         #Ctrlp:input.c.glaa016
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glaa016
            #add-point:ON ACTION controlp INFIELD glaa016 name="input.c.glaa016"
                        #此段落由子樣板a07產生            
            #開窗i段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
			LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_glaa_m.glaa016             #給予default值

            #給予arg

            CALL q_ooai001()                                #呼叫開窗

            LET g_glaa_m.glaa016 = g_qryparam.return1              #將開窗取得的值回傳到變數

            DISPLAY g_glaa_m.glaa016 TO glaa016              #顯示到畫面上

            NEXT FIELD glaa016                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.glaa020
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glaa020
            #add-point:ON ACTION controlp INFIELD glaa020 name="input.c.glaa020"
                        #此段落由子樣板a07產生            
            #開窗i段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
			LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_glaa_m.glaa020             #給予default值

            #給予arg

            CALL q_ooai001()                                #呼叫開窗

            LET g_glaa_m.glaa020 = g_qryparam.return1              #將開窗取得的值回傳到變數

            DISPLAY g_glaa_m.glaa020 TO glaa020              #顯示到畫面上

            NEXT FIELD glaa020                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.glaa017
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glaa017
            #add-point:ON ACTION controlp INFIELD glaa017 name="input.c.glaa017"
                        
            #END add-point
 
 
         #Ctrlp:input.c.glaa021
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glaa021
            #add-point:ON ACTION controlp INFIELD glaa021 name="input.c.glaa021"
                        
            #END add-point
 
 
         #Ctrlp:input.c.glaa018
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glaa018
            #add-point:ON ACTION controlp INFIELD glaa018 name="input.c.glaa018"
                        
            #END add-point
 
 
         #Ctrlp:input.c.glaa022
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glaa022
            #add-point:ON ACTION controlp INFIELD glaa022 name="input.c.glaa022"
                        
            #END add-point
 
 
         #Ctrlp:input.c.glaa100
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glaa100
            #add-point:ON ACTION controlp INFIELD glaa100 name="input.c.glaa100"
                        
            #END add-point
 
 
         #Ctrlp:input.c.glaa101
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glaa101
            #add-point:ON ACTION controlp INFIELD glaa101 name="input.c.glaa101"
                        
            #END add-point
 
 
         #Ctrlp:input.c.glaa102
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glaa102
            #add-point:ON ACTION controlp INFIELD glaa102 name="input.c.glaa102"
                        
            #END add-point
 
 
         #Ctrlp:input.c.glaa103
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glaa103
            #add-point:ON ACTION controlp INFIELD glaa103 name="input.c.glaa103"
                        
            #END add-point
 
 
         #Ctrlp:input.c.glaa111
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glaa111
            #add-point:ON ACTION controlp INFIELD glaa111 name="input.c.glaa111"
                        #此段落由子樣板a07產生            
            #開窗i段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
			LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_glaa_m.glaa111             #給予default值

            #給予arg
            LET g_qryparam.arg1 = g_glaa_m.glaa024
            LET g_qryparam.arg2 = 'aglt310'   #150806apo            

            CALL q_ooba002_05()                                #呼叫開窗

            LET g_glaa_m.glaa111 = g_qryparam.return1              #將開窗取得的值回傳到變數

            DISPLAY g_glaa_m.glaa111 TO glaa111              #顯示到畫面上

            NEXT FIELD glaa111                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.glaa112
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glaa112
            #add-point:ON ACTION controlp INFIELD glaa112 name="input.c.glaa112"
                        #此段落由子樣板a07產生            
            #開窗i段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
			LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_glaa_m.glaa112             #給予default值

            #給予arg
            LET g_qryparam.arg1 = g_glaa_m.glaa024
            LET g_qryparam.arg2 = 'aglt310'   #150806apo
            CALL q_ooba002_05()                                #呼叫開窗

            LET g_glaa_m.glaa112 = g_qryparam.return1              #將開窗取得的值回傳到變數

            DISPLAY g_glaa_m.glaa112 TO glaa112              #顯示到畫面上

            NEXT FIELD glaa112                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.glaa113
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glaa113
            #add-point:ON ACTION controlp INFIELD glaa113 name="input.c.glaa113"
                        #此段落由子樣板a07產生            
            #開窗i段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
			LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_glaa_m.glaa113             #給予default值

            #給予arg
            LET g_qryparam.arg1 = g_glaa_m.glaa024
            LET g_qryparam.arg2 = 'aglt390'   #150806apo

            CALL q_ooba002_05()                                #呼叫開窗

            LET g_glaa_m.glaa113 = g_qryparam.return1              #將開窗取得的值回傳到變數

            DISPLAY g_glaa_m.glaa113 TO glaa113              #顯示到畫面上

            NEXT FIELD glaa113                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.glaa120
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glaa120
            #add-point:ON ACTION controlp INFIELD glaa120 name="input.c.glaa120"
                        #此段落由子樣板a07產生            
            #開窗i段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
			LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_glaa_m.glaa120             #給予default值

            #給予arg
            #150721-00009#1--mod--str--
            #CALL q_xcat001()
            LET g_qryparam.where = "xcazld = '",g_glaa_m.glaald,"'"           
            #CALL q_xcaz001()                      #呼叫開窗  #170210-00013#1 mark
            CALL q_xcaz001_1()         #170210-00013#1 add xul
            #150721-00009#1--mod--end
            LET g_glaa_m.glaa120 = g_qryparam.return1              #將開窗取得的值回傳到變數
            CALL agli010_glaa120_ref(g_glaa_m.glaald,g_glaa_m.glaa120) 
               RETURNING g_glaa_m.glaa120_desc
            DISPLAY g_glaa_m.glaa120_desc TO glaa120_desc
            DISPLAY g_glaa_m.glaa120 TO glaa120              #顯示到畫面上

            NEXT FIELD glaa120                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.glaa121
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glaa121
            #add-point:ON ACTION controlp INFIELD glaa121 name="input.c.glaa121"
            
            #END add-point
 
 
         #Ctrlp:input.c.glaa136
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glaa136
            #add-point:ON ACTION controlp INFIELD glaa136 name="input.c.glaa136"
            
            #END add-point
 
 
         #Ctrlp:input.c.glaa137
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glaa137
            #add-point:ON ACTION controlp INFIELD glaa137 name="input.c.glaa137"
            
            #END add-point
 
 
         #Ctrlp:input.c.glaa139
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glaa139
            #add-point:ON ACTION controlp INFIELD glaa139 name="input.c.glaa139"
            
            #END add-point
 
 
         #Ctrlp:input.c.glaa140
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glaa140
            #add-point:ON ACTION controlp INFIELD glaa140 name="input.c.glaa140"
            
            #END add-point
 
 
         #Ctrlp:input.c.glaa122
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glaa122
            #add-point:ON ACTION controlp INFIELD glaa122 name="input.c.glaa122"
            
            #END add-point
 
 
         #Ctrlp:input.c.glaa123
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glaa123
            #add-point:ON ACTION controlp INFIELD glaa123 name="input.c.glaa123"
            
            #END add-point
 
 
         #Ctrlp:input.c.glaa124
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glaa124
            #add-point:ON ACTION controlp INFIELD glaa124 name="input.c.glaa124"
            
            #END add-point
 
 
         #Ctrlp:input.c.glaa131
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glaa131
            #add-point:ON ACTION controlp INFIELD glaa131 name="input.c.glaa131"
            
            #END add-point
 
 
         #Ctrlp:input.c.glaa132
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glaa132
            #add-point:ON ACTION controlp INFIELD glaa132 name="input.c.glaa132"
            
            #END add-point
 
 
         #Ctrlp:input.c.glaa133
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glaa133
            #add-point:ON ACTION controlp INFIELD glaa133 name="input.c.glaa133"
            
            #END add-point
 
 
         #Ctrlp:input.c.glaa134
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glaa134
            #add-point:ON ACTION controlp INFIELD glaa134 name="input.c.glaa134"
            
            #END add-point
 
 
         #Ctrlp:input.c.glaa138
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glaa138
            #add-point:ON ACTION controlp INFIELD glaa138 name="input.c.glaa138"
            
            #END add-point
 
 
         #Ctrlp:input.c.glaa135
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glaa135
            #add-point:ON ACTION controlp INFIELD glaa135 name="input.c.glaa135"
            #應用 a07 樣板自動產生(Version:2)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.arg1 = '16'
            CALL q_ooal002_0()                                #呼叫開窗
            LET g_glaa_m.glaa135 = g_qryparam.return1              
            DISPLAY g_glaa_m.glaa135 TO glaa135               #顯示到畫面上
            LET g_glaa_m.glaa135_desc = s_desc_ooal002_desc('16', g_glaa_m.glaa135)
            DISPLAY BY NAME g_glaa_m.glaa135_desc
            NEXT FIELD glaa135                                #返回原欄位

            #END add-point
 
 
 #欄位開窗
 
         AFTER INPUT
            IF INT_FLAG THEN
               EXIT DIALOG
            END IF
 
            #避免資料錯誤的檢查
            IF agli010_check(g_glaa_m.glaald,g_glaa_m.glaacomp
               ) THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "" 
               LET g_errparam.code = "std-00020" 
               LET g_errparam.popup = TRUE 
               CALL cl_err()
               NEXT FIELD CURRENT
            END IF
 
            #CALL cl_err_collect_show()   #錯誤訊息統整顯示
            #CALL cl_showmsg()
            DISPLAY BY NAME g_glaa_m.glaald
 
            #實體新增/修改/複製段落的處理
            CASE
               WHEN p_cmd = "a" OR p_cmd = "r"
                  LET l_count = 1
 
                  SELECT COUNT(1) INTO l_count FROM glaa_t
                   WHERE glaaent = g_enterprise AND glaald = g_glaa_m.glaald
 
                         #
                  IF l_count = 0 THEN
                     #add-point:單頭新增前 name="input.head.b_insert"
                     CALL agli010_doc_chk(g_glaa_m.glaa024) 
                        RETURNING l_success,l_field
                     IF l_field = 'glaa111' THEN
                        NEXT FIELD glaa111
                     ELSE
                        IF l_field = 'glaa112' THEN
                           NEXT FIELD glaa112
                        ELSE
                           IF l_field = 'glaa113' THEN
                              NEXT FIELD glaa113
                           END IF
                        END IF
                     END IF
                     #end add-point
 
                     INSERT INTO glaa_t (glaaent,glaald,glaacomp,glaa027,glaa026,glaa001,glaa002,glaa025, 
                         glaa028,glaa003,glaa004,glaa024,glaa005,glaa006,glaa007,glaa014,glaa008,glaa023, 
                         glaa009,glaa130,glaa010,glaa011,glaa012,glaa013,glaastus,glaa015,glaa019,glaa016, 
                         glaa020,glaa017,glaa021,glaa018,glaa022,glaa100,glaa101,glaa102,glaa103,glaa111, 
                         glaa112,glaa113,glaa120,glaa121,glaa136,glaa137,glaa139,glaa140,glaa122,glaa123, 
                         glaa124,glaa131,glaa132,glaa133,glaa134,glaa138,glaa135,glaaownid,glaaowndp, 
                         glaacrtid,glaacrtdp,glaacrtdt,glaamodid,glaamoddt)
                     VALUES (g_enterprise,g_glaa_m.glaald,g_glaa_m.glaacomp,g_glaa_m.glaa027,g_glaa_m.glaa026, 
                         g_glaa_m.glaa001,g_glaa_m.glaa002,g_glaa_m.glaa025,g_glaa_m.glaa028,g_glaa_m.glaa003, 
                         g_glaa_m.glaa004,g_glaa_m.glaa024,g_glaa_m.glaa005,g_glaa_m.glaa006,g_glaa_m.glaa007, 
                         g_glaa_m.glaa014,g_glaa_m.glaa008,g_glaa_m.glaa023,g_glaa_m.glaa009,g_glaa_m.glaa130, 
                         g_glaa_m.glaa010,g_glaa_m.glaa011,g_glaa_m.glaa012,g_glaa_m.glaa013,g_glaa_m.glaastus, 
                         g_glaa_m.glaa015,g_glaa_m.glaa019,g_glaa_m.glaa016,g_glaa_m.glaa020,g_glaa_m.glaa017, 
                         g_glaa_m.glaa021,g_glaa_m.glaa018,g_glaa_m.glaa022,g_glaa_m.glaa100,g_glaa_m.glaa101, 
                         g_glaa_m.glaa102,g_glaa_m.glaa103,g_glaa_m.glaa111,g_glaa_m.glaa112,g_glaa_m.glaa113, 
                         g_glaa_m.glaa120,g_glaa_m.glaa121,g_glaa_m.glaa136,g_glaa_m.glaa137,g_glaa_m.glaa139, 
                         g_glaa_m.glaa140,g_glaa_m.glaa122,g_glaa_m.glaa123,g_glaa_m.glaa124,g_glaa_m.glaa131, 
                         g_glaa_m.glaa132,g_glaa_m.glaa133,g_glaa_m.glaa134,g_glaa_m.glaa138,g_glaa_m.glaa135, 
                         g_glaa_m.glaaownid,g_glaa_m.glaaowndp,g_glaa_m.glaacrtid,g_glaa_m.glaacrtdp, 
                         g_glaa_m.glaacrtdt,g_glaa_m.glaamodid,g_glaa_m.glaamoddt) 
 
                     #add-point:單頭新增中 name="input.head.m_insert"
                                          
                     #end add-point
 
                     IF SQLCA.SQLCODE THEN
                        INITIALIZE g_errparam TO NULL 
                        LET g_errparam.extend = "g_glaa_m:",SQLERRMESSAGE 
                        LET g_errparam.code = SQLCA.SQLCODE 
                        LET g_errparam.popup = TRUE 
                        CALL cl_err()
                        CONTINUE DIALOG
                     END IF
                  
                     #提速檔資料建置
                     IF g_glaa_m.glaald <> g_glaa_m.glaacomp THEN
                        #CALL n_glaas_generate_child(g_glaa_m.glaald,g_glaa_m.glaacomp)
                     END IF
                     
                     #add-point:單頭新增後 name="input.head.a_insert"
                     #160310-00008#1--add--str--
                     LET l_success = TRUE
                     CALL agli010_upd_aoos020('a') RETURNING l_success
                     IF l_success = FALSE THEN
                        CALL s_transaction_end("N","0")
                     END IF
                     #160310-00008#1--add--end
                     #end add-point
                     
                     #資料多語言用-增/改
                              INITIALIZE l_var_keys TO NULL 
         INITIALIZE l_field_keys TO NULL 
         INITIALIZE l_vars TO NULL 
         INITIALIZE l_fields TO NULL 
         IF g_glaa_m.glaald = g_master_multi_table_t.glaalld AND
         g_glaa_m.glaal002 = g_master_multi_table_t.glaal002  THEN
         ELSE 
            LET l_var_keys[01] = g_enterprise
            LET l_field_keys[01] = 'glaalent'
            LET l_var_keys_bak[01] = g_enterprise
            LET l_var_keys[02] = g_glaa_m.glaald
            LET l_field_keys[02] = 'glaalld'
            LET l_var_keys_bak[02] = g_master_multi_table_t.glaalld
            LET l_var_keys[03] = g_dlang
            LET l_field_keys[03] = 'glaal001'
            LET l_var_keys_bak[03] = g_dlang
            LET l_vars[01] = g_glaa_m.glaal002
            LET l_fields[01] = 'glaal002'
            CALL cl_multitable(l_var_keys,l_field_keys,l_vars,l_fields,l_var_keys_bak,'glaal_t')
         END IF 
 
                     CALL s_transaction_end("Y","0")
                  ELSE
                     CALL s_transaction_end("N","0")
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend =  g_glaa_m.glaald 
                     LET g_errparam.code =  "std-00006" 
                     LET g_errparam.popup = TRUE 
                     CALL cl_err()
                  END IF 
 
               #修改段落
               WHEN p_cmd = "u"  
                  #add-point:單頭修改前 name="input.head.b_update"
                  CALL agli010_doc_chk(g_glaa_m.glaa024) 
                     RETURNING l_success,l_field
                  IF l_field = 'glaa111' THEN
                     NEXT FIELD glaa111
                  ELSE
                     IF l_field = 'glaa112' THEN
                        NEXT FIELD glaa112
                     ELSE
                        IF l_field = 'glaa113' THEN
                           NEXT FIELD glaa113
                        END IF
                     END IF
                  END IF
                  #end add-point
                  UPDATE glaa_t SET (glaald,glaacomp,glaa027,glaa026,glaa001,glaa002,glaa025,glaa028, 
                      glaa003,glaa004,glaa024,glaa005,glaa006,glaa007,glaa014,glaa008,glaa023,glaa009, 
                      glaa130,glaa010,glaa011,glaa012,glaa013,glaastus,glaa015,glaa019,glaa016,glaa020, 
                      glaa017,glaa021,glaa018,glaa022,glaa100,glaa101,glaa102,glaa103,glaa111,glaa112, 
                      glaa113,glaa120,glaa121,glaa136,glaa137,glaa139,glaa140,glaa122,glaa123,glaa124, 
                      glaa131,glaa132,glaa133,glaa134,glaa138,glaa135,glaaownid,glaaowndp,glaacrtid, 
                      glaacrtdp,glaacrtdt,glaamodid,glaamoddt) = (g_glaa_m.glaald,g_glaa_m.glaacomp, 
                      g_glaa_m.glaa027,g_glaa_m.glaa026,g_glaa_m.glaa001,g_glaa_m.glaa002,g_glaa_m.glaa025, 
                      g_glaa_m.glaa028,g_glaa_m.glaa003,g_glaa_m.glaa004,g_glaa_m.glaa024,g_glaa_m.glaa005, 
                      g_glaa_m.glaa006,g_glaa_m.glaa007,g_glaa_m.glaa014,g_glaa_m.glaa008,g_glaa_m.glaa023, 
                      g_glaa_m.glaa009,g_glaa_m.glaa130,g_glaa_m.glaa010,g_glaa_m.glaa011,g_glaa_m.glaa012, 
                      g_glaa_m.glaa013,g_glaa_m.glaastus,g_glaa_m.glaa015,g_glaa_m.glaa019,g_glaa_m.glaa016, 
                      g_glaa_m.glaa020,g_glaa_m.glaa017,g_glaa_m.glaa021,g_glaa_m.glaa018,g_glaa_m.glaa022, 
                      g_glaa_m.glaa100,g_glaa_m.glaa101,g_glaa_m.glaa102,g_glaa_m.glaa103,g_glaa_m.glaa111, 
                      g_glaa_m.glaa112,g_glaa_m.glaa113,g_glaa_m.glaa120,g_glaa_m.glaa121,g_glaa_m.glaa136, 
                      g_glaa_m.glaa137,g_glaa_m.glaa139,g_glaa_m.glaa140,g_glaa_m.glaa122,g_glaa_m.glaa123, 
                      g_glaa_m.glaa124,g_glaa_m.glaa131,g_glaa_m.glaa132,g_glaa_m.glaa133,g_glaa_m.glaa134, 
                      g_glaa_m.glaa138,g_glaa_m.glaa135,g_glaa_m.glaaownid,g_glaa_m.glaaowndp,g_glaa_m.glaacrtid, 
                      g_glaa_m.glaacrtdp,g_glaa_m.glaacrtdt,g_glaa_m.glaamodid,g_glaa_m.glaamoddt)
                   WHERE glaaent = g_enterprise AND glaald = g_glaald_t #
 
                  #add-point:單頭修改中 name="input.head.m_update"
                                    
                  #end add-point
                  CASE
                     WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
                        CALL s_transaction_end('N','0')
                        INITIALIZE g_errparam TO NULL 
                        LET g_errparam.extend = "glaa_t" 
                        LET g_errparam.code = "std-00009" 
                        LET g_errparam.popup = TRUE 
                        CALL cl_err()
                        
                     WHEN SQLCA.SQLCODE #其他錯誤
                        INITIALIZE g_errparam TO NULL 
                        LET g_errparam.extend = "glaa_t:",SQLERRMESSAGE 
                        LET g_errparam.code = SQLCA.SQLCODE 
                        LET g_errparam.popup = TRUE 
                        CALL s_transaction_end('N','0')
                        CALL cl_err()
                        
                     OTHERWISE
                        #add-point:單頭修改後 name="input.head.a_update"
                        #160310-00008#1--add--str--
                        LET l_success = TRUE
                        CALL agli010_upd_aoos020('u') RETURNING l_success
                        IF l_success = FALSE THEN
                           CALL s_transaction_end("N","0")
                        END IF
                        #160310-00008#1--add--end                        
                        #end add-point
    
                        #資料多語言用-增/改
                                 INITIALIZE l_var_keys TO NULL 
         INITIALIZE l_field_keys TO NULL 
         INITIALIZE l_vars TO NULL 
         INITIALIZE l_fields TO NULL 
         IF g_glaa_m.glaald = g_master_multi_table_t.glaalld AND
         g_glaa_m.glaal002 = g_master_multi_table_t.glaal002  THEN
         ELSE 
            LET l_var_keys[01] = g_enterprise
            LET l_field_keys[01] = 'glaalent'
            LET l_var_keys_bak[01] = g_enterprise
            LET l_var_keys[02] = g_glaa_m.glaald
            LET l_field_keys[02] = 'glaalld'
            LET l_var_keys_bak[02] = g_master_multi_table_t.glaalld
            LET l_var_keys[03] = g_dlang
            LET l_field_keys[03] = 'glaal001'
            LET l_var_keys_bak[03] = g_dlang
            LET l_vars[01] = g_glaa_m.glaal002
            LET l_fields[01] = 'glaal002'
            CALL cl_multitable(l_var_keys,l_field_keys,l_vars,l_fields,l_var_keys_bak,'glaal_t')
         END IF 
 
                        LET g_log1 = util.JSON.stringify(g_glaa_m_t)
                        LET g_log2 = util.JSON.stringify(g_glaa_m)
                        IF NOT cl_log_modified_record(g_log1,g_log2) THEN 
                           CALL s_transaction_end('N','0')
                        ELSE
                           CALL s_transaction_end('Y','0')
                        END IF
                  END CASE
 
               OTHERWISE 
            END CASE
 
           #controlp
      END INPUT
      
      #add-point:input段more input  name="input.more_input"
      
      #end add-point
      
      BEFORE DIALOG
         #CALL cl_err_collect_init()    
         #add-point:before dialog name="input.before_dialog"
         
         #end add-point
          
      ON ACTION controlf
         CALL cl_set_focus_form(ui.Interface.getRootNode()) RETURNING g_fld_name,g_frm_name
         CALL cl_fldhelp(g_frm_name, g_fld_name, g_lang)
 
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
         ACCEPT DIALOG
        
      #在dialog button (放棄)
      ON ACTION cancel
         LET g_action_choice=""
         LET INT_FLAG = TRUE 
         EXIT DIALOG
 
      #在dialog 右上角 (X)
      ON ACTION close       
         LET INT_FLAG = TRUE 
         EXIT DIALOG
 
      #toolbar 離開
      ON ACTION exit
         LET INT_FLAG = TRUE 
         EXIT DIALOG
   
      #交談指令共用ACTION
      &include "common_action.4gl" 
         CONTINUE DIALOG 
           
   END DIALOG
   
   #add-point:input段after input  name="input.after_input"
         IF INT_FLAG THEN
   ELSE
      LET lc_count = 0 
      SELECT COUNT(*) INTO lc_count FROM glaa_t
       WHERE glaacomp = g_glaa_m.glaacomp AND glaa014 = 'Y'
         AND glaaent = g_enterprise
      IF lc_count < 1 THEN
        INITIALIZE g_errparam TO NULL
        LET g_errparam.code = 'agl-00015'
        LET g_errparam.extend = g_glaa_m.glaacomp
        LET g_errparam.popup = FALSE
        CALL cl_err()

      END IF
   END IF 
   #end add-point
    
END FUNCTION
 
{</section>}
 
{<section id="agli010.show" >}
#+ 單頭資料重新顯示及單身資料重抓
PRIVATE FUNCTION agli010_show()
   #add-point:show段define name="show.define_customerization"
   
   #end add-point
   #add-point:show段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="show.define"
   DEFINE l_pass        LIKE type_t.num5  #160825-00017#1 add   
   #end add-point
   
   #add-point:Function前置處理  name="show.before"
   #160825-00017#1--add--str--
   CALL s_ld_chk_authorization(g_user,g_glaa_m.glaald) RETURNING l_pass
   IF l_pass = FALSE THEN 
      CALL cl_set_act_visible('modify,delete',FALSE)
   ELSE
      CALL cl_set_act_visible('modify,delete',TRUE)
   END IF
   #160825-00017#1--add--end   
   #end add-point
   
       
   
   #帶出公用欄位reference值
   #應用 a12 樣板自動產生(Version:4)
 
 
 
 
   #顯示followup圖示
   #應用 a48 樣板自動產生(Version:3)
   CALL agli010_set_pk_array()
   #add-point:ON ACTION agendum name="show.follow_pic"
   
   #END add-point
   CALL cl_user_overview_set_follow_pic()
  
 
 
 
   
   #讀入ref值(單頭)
   #add-point:reference段之後 name="show.head.reference"
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_glaa_m.glaald
   CALL ap_ref_array2(g_ref_fields," SELECT glaal002 FROM glaal_t WHERE glaalent = '"||g_enterprise||"' AND glaalld = ? AND glaal001 = '"||g_dlang||"'","") RETURNING g_rtn_fields 
   LET g_glaa_m.glaal002 = g_rtn_fields[1] 
   DISPLAY BY NAME g_glaa_m.glaal002

   #140314-00001#4-----s
   #帶出群組參照表號的說明
   LET g_glaa_m.glaa135_desc = s_desc_ooal002_desc('16', g_glaa_m.glaa135)
   #140314-00001#4-----e
   
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_glaa_m.glaacomp
            CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_glaa_m.glaacomp_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_glaa_m.glaacomp_desc

            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_glaa_m.glaa001
            CALL ap_ref_array2(g_ref_fields,"SELECT ooail003 FROM ooail_t WHERE ooailent='"||g_enterprise||"' AND ooail001=? AND ooail002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_glaa_m.glaa001_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_glaa_m.glaa001_desc

            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_glaa_m.glaa002
            CALL ap_ref_array2(g_ref_fields,"SELECT ooall004 FROM ooall_t WHERE ooallent='"||g_enterprise||"' AND ooall001='1' AND ooall002=? AND ooall003='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_glaa_m.glaa002_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_glaa_m.glaa002_desc

            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_glaa_m.glaa003
            CALL ap_ref_array2(g_ref_fields,"SELECT ooall004 FROM ooall_t WHERE ooallent='"||g_enterprise||"' AND ooall001='13' AND ooall002=? AND ooall003='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_glaa_m.glaa003_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_glaa_m.glaa003_desc

            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_glaa_m.glaa004
            CALL ap_ref_array2(g_ref_fields,"SELECT ooall004 FROM ooall_t WHERE ooallent='"||g_enterprise||"' AND ooall001='0' AND ooall002=? AND ooall003='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_glaa_m.glaa004_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_glaa_m.glaa004_desc

            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_glaa_m.glaa005
            CALL ap_ref_array2(g_ref_fields,"SELECT ooall004 FROM ooall_t WHERE ooallent='"||g_enterprise||"' AND ooall001='8' AND ooall002=? AND ooall003='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_glaa_m.glaa005_desc = '', g_rtn_fields[1] , ''
            
            DISPLAY BY NAME g_glaa_m.glaa005_desc
            CALL agli010_ooal_ref('3',g_glaa_m.glaa024) RETURNING g_glaa_m.glaa024_desc
            DISPLAY BY NAME g_glaa_m.glaa024_desc
            
            CALL agli010_glaa120_ref(g_glaa_m.glaald,g_glaa_m.glaa120)
               RETURNING g_glaa_m.glaa120_desc
            DISPLAY g_glaa_m.glaa120_desc TO glaa120_desc
           
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_glaa_m.glaaownid
            CALL ap_ref_array2(g_ref_fields,"SELECT ooag011 FROM ooag_t WHERE ooagent='"||g_enterprise||"' AND ooag001=? ","") RETURNING g_rtn_fields
            LET g_glaa_m.glaaownid_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_glaa_m.glaaownid_desc

            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_glaa_m.glaaowndp
            CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_glaa_m.glaaowndp_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_glaa_m.glaaowndp_desc

            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_glaa_m.glaacrtid
            CALL ap_ref_array2(g_ref_fields,"SELECT ooag011 FROM ooag_t WHERE ooagent='"||g_enterprise||"' AND ooag001=? ","") RETURNING g_rtn_fields
            LET g_glaa_m.glaacrtid_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_glaa_m.glaacrtid_desc

            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_glaa_m.glaacrtdp
            CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_glaa_m.glaacrtdp_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_glaa_m.glaacrtdp_desc

            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_glaa_m.glaamodid
            CALL ap_ref_array2(g_ref_fields,"SELECT ooag011 FROM ooag_t WHERE ooagent='"||g_enterprise||"' AND ooag001=? ","") RETURNING g_rtn_fields
            LET g_glaa_m.glaamodid_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_glaa_m.glaamodid_desc
            
   CALL agli010_glaa026_desc(g_glaa_m.glaa026)
   #151113-00002#7 151117 by sakura add(S)
   IF g_glaa_m.glaa130 = 'Y' THEN
      CALL cl_set_comp_visible("page_4",TRUE)   #合併報表
   ELSE
      CALL cl_set_comp_visible("page_4",FALSE)   #合併報表   
   END IF
   #151113-00002#7 151117 by sakura add(E)   
   
   #160413-00010#1--add--str--
   #单别说明
   CALL agli010_get_oobxl003(g_glaa_m.glaa111) RETURNING g_glaa_m.glaa111_desc
   CALL agli010_get_oobxl003(g_glaa_m.glaa112) RETURNING g_glaa_m.glaa112_desc
   CALL agli010_get_oobxl003(g_glaa_m.glaa113) RETURNING g_glaa_m.glaa113_desc
   #160413-00010#1--add--end
   
   #end add-point
   
   #將資料輸出到畫面上
   DISPLAY BY NAME g_glaa_m.glaald,g_glaa_m.glaal002,g_glaa_m.glaacomp,g_glaa_m.glaacomp_desc,g_glaa_m.glaa027, 
       g_glaa_m.glaa026,g_glaa_m.glaa026_desc,g_glaa_m.glaa001,g_glaa_m.glaa001_desc,g_glaa_m.glaa002, 
       g_glaa_m.glaa002_desc,g_glaa_m.glaa025,g_glaa_m.glaa028,g_glaa_m.glaa003,g_glaa_m.glaa003_desc, 
       g_glaa_m.glaa004,g_glaa_m.glaa004_desc,g_glaa_m.glaa024,g_glaa_m.glaa024_desc,g_glaa_m.glaa005, 
       g_glaa_m.glaa005_desc,g_glaa_m.glaa006,g_glaa_m.glaa007,g_glaa_m.glaa014,g_glaa_m.glaa008,g_glaa_m.glaa023, 
       g_glaa_m.glaa009,g_glaa_m.glaa130,g_glaa_m.glaa010,g_glaa_m.glaa011,g_glaa_m.glaa012,g_glaa_m.glaa013, 
       g_glaa_m.glaastus,g_glaa_m.glaa015,g_glaa_m.fflabel1_desc,g_glaa_m.glaa019,g_glaa_m.glaa016,g_glaa_m.glaa020, 
       g_glaa_m.glaa017,g_glaa_m.glaa021,g_glaa_m.glaa018,g_glaa_m.glaa022,g_glaa_m.fflabe7_desc,g_glaa_m.fflabel8_desc, 
       g_glaa_m.glaa100,g_glaa_m.glaa101,g_glaa_m.glaa102,g_glaa_m.glaa103,g_glaa_m.glaa111,g_glaa_m.glaa111_desc, 
       g_glaa_m.glaa112,g_glaa_m.glaa112_desc,g_glaa_m.glaa113,g_glaa_m.glaa113_desc,g_glaa_m.glaa120, 
       g_glaa_m.glaa120_desc,g_glaa_m.glaa121,g_glaa_m.glaa136,g_glaa_m.glaa137,g_glaa_m.glaa139,g_glaa_m.glaa140, 
       g_glaa_m.glaa122,g_glaa_m.glaa123,g_glaa_m.glaa124,g_glaa_m.glaa131,g_glaa_m.glaa132,g_glaa_m.glaa133, 
       g_glaa_m.glaa134,g_glaa_m.glaa138,g_glaa_m.glaa135,g_glaa_m.glaa135_desc,g_glaa_m.glaaownid,g_glaa_m.glaaownid_desc, 
       g_glaa_m.glaaowndp,g_glaa_m.glaaowndp_desc,g_glaa_m.glaacrtid,g_glaa_m.glaacrtid_desc,g_glaa_m.glaacrtdp, 
       g_glaa_m.glaacrtdp_desc,g_glaa_m.glaacrtdt,g_glaa_m.glaamodid,g_glaa_m.glaamodid_desc,g_glaa_m.glaamoddt 
 
 
   #顯示狀態(stus)圖片
         #應用 a21 樣板自動產生(Version:3)
	  #根據當下狀態碼顯示圖片
      CASE g_glaa_m.glaastus 
         WHEN "N"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/inactive.png")
         WHEN "Y"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/active.png")
         
      END CASE
 
 
 
 
   #顯示有特殊格式設定的欄位或說明
   CALL cl_show_fld_cont()   
 
   #add-point:show段之後 name="show.after"
      
   #end add-point
   
END FUNCTION
 
{</section>}
 
{<section id="agli010.delete" >}
#+ 資料刪除
PRIVATE FUNCTION agli010_delete(l_dialog)
   #add-point:delete段define name="delete.define_customerization"
   
   #end add-point
   DEFINE l_var_keys      DYNAMIC ARRAY OF STRING
   DEFINE l_field_keys    DYNAMIC ARRAY OF STRING
   DEFINE l_vars          DYNAMIC ARRAY OF STRING
   DEFINE l_fields        DYNAMIC ARRAY OF STRING
   DEFINE l_var_keys_bak  DYNAMIC ARRAY OF STRING
   DEFINE l_dialog        ui.DIALOG
   DEFINE li_status       LIKE type_t.num5  #SQL實體資料刪除狀態
   DEFINE li_cnt          LIKE type_t.num10 #查看本階是否有兄弟資料
   #add-point:delete段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="delete.define"
   DEFINE l_success       LIKE type_t.num5  #160310-00008#1 add
   DEFINE l_pass          LIKE type_t.num5  #160825-00017#1 add
   #end add-point
   
   #add-point:Function前置處理  name="delete.pre_function"
   
   #end add-point
   
   IF g_glaa_m.glaald IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code = "std-00003" 
      LET g_errparam.popup = FALSE 
      CALL cl_err()
      RETURN
   END IF
   
   #add-point:delete段before_delete name="delete.before_delete"
   #160825-00017#1--add--str--
   CALL s_ld_chk_authorization(g_user,g_glaa_m.glaald) RETURNING l_pass
   IF l_pass = FALSE THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'agl-00165'
      LET g_errparam.extend = g_glaa_m.glaald
      LET g_errparam.popup = TRUE
      CALL cl_err()
    
      RETURN
   END IF
   #160825-00017#1--add--end   
   #end add-point
 
   EXECUTE agli010_master_referesh USING g_glaa_m.glaald INTO g_glaa_m.glaald,g_glaa_m.glaacomp,g_glaa_m.glaa027, 
       g_glaa_m.glaa026,g_glaa_m.glaa001,g_glaa_m.glaa002,g_glaa_m.glaa025,g_glaa_m.glaa028,g_glaa_m.glaa003, 
       g_glaa_m.glaa004,g_glaa_m.glaa024,g_glaa_m.glaa005,g_glaa_m.glaa006,g_glaa_m.glaa007,g_glaa_m.glaa014, 
       g_glaa_m.glaa008,g_glaa_m.glaa023,g_glaa_m.glaa009,g_glaa_m.glaa130,g_glaa_m.glaa010,g_glaa_m.glaa011, 
       g_glaa_m.glaa012,g_glaa_m.glaa013,g_glaa_m.glaastus,g_glaa_m.glaa015,g_glaa_m.glaa019,g_glaa_m.glaa016, 
       g_glaa_m.glaa020,g_glaa_m.glaa017,g_glaa_m.glaa021,g_glaa_m.glaa018,g_glaa_m.glaa022,g_glaa_m.glaa100, 
       g_glaa_m.glaa101,g_glaa_m.glaa102,g_glaa_m.glaa103,g_glaa_m.glaa111,g_glaa_m.glaa112,g_glaa_m.glaa113, 
       g_glaa_m.glaa120,g_glaa_m.glaa121,g_glaa_m.glaa136,g_glaa_m.glaa137,g_glaa_m.glaa139,g_glaa_m.glaa140, 
       g_glaa_m.glaa122,g_glaa_m.glaa123,g_glaa_m.glaa124,g_glaa_m.glaa131,g_glaa_m.glaa132,g_glaa_m.glaa133, 
       g_glaa_m.glaa134,g_glaa_m.glaa138,g_glaa_m.glaa135,g_glaa_m.glaaownid,g_glaa_m.glaaowndp,g_glaa_m.glaacrtid, 
       g_glaa_m.glaacrtdp,g_glaa_m.glaacrtdt,g_glaa_m.glaamodid,g_glaa_m.glaamoddt,g_glaa_m.glaacomp_desc, 
       g_glaa_m.glaa026_desc,g_glaa_m.glaa001_desc,g_glaa_m.glaa002_desc,g_glaa_m.glaa003_desc,g_glaa_m.glaa004_desc, 
       g_glaa_m.glaa024_desc,g_glaa_m.glaa005_desc,g_glaa_m.glaa111_desc,g_glaa_m.glaa112_desc,g_glaa_m.glaa113_desc, 
       g_glaa_m.glaa120_desc,g_glaa_m.glaa135_desc,g_glaa_m.glaaownid_desc,g_glaa_m.glaaowndp_desc,g_glaa_m.glaacrtid_desc, 
       g_glaa_m.glaacrtdp_desc,g_glaa_m.glaamodid_desc
    
   #檢查是否允許此動作
   IF NOT agli010_action_chk() THEN
      RETURN
   END IF
    
   CALL agli010_show()
   
   #Transaction開始
   CALL s_transaction_begin()
   
   LET g_master_multi_table_t.glaalld = g_glaa_m.glaald
LET g_master_multi_table_t.glaal002 = g_glaa_m.glaal002
 
 
   OPEN agli010_cl USING g_enterprise,g_glaa_m.glaald
   IF SQLCA.SQLCODE THEN   #(ver:36)
      CLOSE agli010_cl
      CALL s_transaction_end("N","0")
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "OPEN agli010_cl:",SQLERRMESSAGE 
      LET g_errparam.code = SQLCA.SQLCODE   #(ver:36)
      LET g_errparam.popup = TRUE 
      CALL cl_err()
      RETURN
   END IF
 
   #鎖住將被更改或取消的資料
   FETCH agli010_cl INTO g_glaa_m.glaald,g_glaa_m.glaal002,g_glaa_m.glaacomp,g_glaa_m.glaacomp_desc, 
       g_glaa_m.glaa027,g_glaa_m.glaa026,g_glaa_m.glaa026_desc,g_glaa_m.glaa001,g_glaa_m.glaa001_desc, 
       g_glaa_m.glaa002,g_glaa_m.glaa002_desc,g_glaa_m.glaa025,g_glaa_m.glaa028,g_glaa_m.glaa003,g_glaa_m.glaa003_desc, 
       g_glaa_m.glaa004,g_glaa_m.glaa004_desc,g_glaa_m.glaa024,g_glaa_m.glaa024_desc,g_glaa_m.glaa005, 
       g_glaa_m.glaa005_desc,g_glaa_m.glaa006,g_glaa_m.glaa007,g_glaa_m.glaa014,g_glaa_m.glaa008,g_glaa_m.glaa023, 
       g_glaa_m.glaa009,g_glaa_m.glaa130,g_glaa_m.glaa010,g_glaa_m.glaa011,g_glaa_m.glaa012,g_glaa_m.glaa013, 
       g_glaa_m.glaastus,g_glaa_m.glaa015,g_glaa_m.fflabel1_desc,g_glaa_m.glaa019,g_glaa_m.glaa016,g_glaa_m.glaa020, 
       g_glaa_m.glaa017,g_glaa_m.glaa021,g_glaa_m.glaa018,g_glaa_m.glaa022,g_glaa_m.fflabe7_desc,g_glaa_m.fflabel8_desc, 
       g_glaa_m.glaa100,g_glaa_m.glaa101,g_glaa_m.glaa102,g_glaa_m.glaa103,g_glaa_m.glaa111,g_glaa_m.glaa111_desc, 
       g_glaa_m.glaa112,g_glaa_m.glaa112_desc,g_glaa_m.glaa113,g_glaa_m.glaa113_desc,g_glaa_m.glaa120, 
       g_glaa_m.glaa120_desc,g_glaa_m.glaa121,g_glaa_m.glaa136,g_glaa_m.glaa137,g_glaa_m.glaa139,g_glaa_m.glaa140, 
       g_glaa_m.glaa122,g_glaa_m.glaa123,g_glaa_m.glaa124,g_glaa_m.glaa131,g_glaa_m.glaa132,g_glaa_m.glaa133, 
       g_glaa_m.glaa134,g_glaa_m.glaa138,g_glaa_m.glaa135,g_glaa_m.glaa135_desc,g_glaa_m.glaaownid,g_glaa_m.glaaownid_desc, 
       g_glaa_m.glaaowndp,g_glaa_m.glaaowndp_desc,g_glaa_m.glaacrtid,g_glaa_m.glaacrtid_desc,g_glaa_m.glaacrtdp, 
       g_glaa_m.glaacrtdp_desc,g_glaa_m.glaacrtdt,g_glaa_m.glaamodid,g_glaa_m.glaamodid_desc,g_glaa_m.glaamoddt 
 
   IF SQLCA.SQLCODE THEN
      CALL s_transaction_end("N","0")
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = g_glaa_m.glaald,":",SQLERRMESSAGE 
      LET g_errparam.code = SQLCA.SQLCODE 
      LET g_errparam.popup = FALSE 
      CALL cl_err()
      RETURN
   END IF
 
   #add-point:delete段before_delete name="delete.before_delete_ask"
   
   #end add-point
 
   #(ver:35) ---modify start---
   #(ver:35) 為避免刪除全部子節點可能會對其他節點造成影響，現改為只刪除當下節點
   #先判斷是否有子節點(hasC) 詢問是否砍除全部
#  IF g_browser[g_current_idx].b_hasC THEN
#     IF cl_ask_delete_all_node() THEN
#        LET li_status = agli010_sql_delete(TRUE)
#     ELSE
#        LET li_status = FALSE
#     END IF
#  ELSE
      #如果沒有子節點,詢問是否刪除本筆資料
      IF cl_ask_delete() THEN
         LET li_status = agli010_sql_delete(FALSE)
      ELSE
         LET li_status = FALSE
      END IF
#  END IF
   #(ver:35) --- modify end ---
 
   #檢查實體砍除是否發生意外中止
   IF NOT li_status THEN
      CALL s_transaction_end("N","0")
      CLOSE agli010_cl
      RETURN
   END IF
 
   #刪除節點與資料內容
   CALL l_dialog.deleteNode("s_browse",g_current_idx)  #deleteNode會順便幫忙做deleteElement
 
   #確認這一階還有沒有兄弟 (有:不異動上階屬性/否:上階hasC及exp設定成0)
   #SELECT COUNT(1) INTO li_cnt
   #  FROM glaa_t
   # WHERE glaacomp = g_glaa_m.glaacomp
   #IF g_current_idx > 1 THEN
   #   IF li_cnt = 0  THEN
   #      LET g_browser[g_current_idx - 1].b_hasC = 0
   #      LET g_browser[g_current_idx - 1].b_exp = 0
   #   END IF
   #END IF
 
   #add-point:單頭刪除後 name="delete.head.a_delete"
   #160310-00008#1--add--str--
   LET l_success = TRUE
   CALL agli010_upd_aoos020('d') RETURNING l_success
   IF l_success = FALSE THEN
      CALL s_transaction_end("N","0")
   END IF
   #160310-00008#1--add--end      
   #end add-point
   
   IF g_current_idx > 1 THEN
      LET g_current_idx = g_current_idx - 1
   END IF
   
   IF g_browser.getLength() > 0 THEN
      CALL agli010_fetch("")
   END IF
 
   LET g_log1 = util.JSON.stringify(g_glaa_m)   #(ver:36)
   IF NOT cl_log_modified_record(g_log1,'') THEN   #(ver:36)
      CLOSE agli010_cl
      CALL s_transaction_end('N','0')
   ELSE
      CLOSE agli010_cl
      CALL s_transaction_end('Y','0')
   END IF
 
   #功能已完成,通報訊息中心
   CALL agli010_msgcentre_notify('delete')
    
END FUNCTION
 
{</section>}
 
{<section id="agli010.sql_delete" >}
#+ 實體刪除FUNCTION 
PRIVATE FUNCTION agli010_sql_delete(li_node)
   #add-point:sql_delete段define name="sql_delet.define_customerization"
   
   #end add-point
   DEFINE li_node         LIKE type_t.num5  #TRUE:砍除Node Tree/FALSE:砍除Single Node
   DEFINE li_return       LIKE type_t.num5
   DEFINE l_var_keys_bak  DYNAMIC ARRAY OF STRING
   DEFINE l_field_keys    DYNAMIC ARRAY OF STRING
   DEFINE ls_sql          STRING
   DEFINE li_cnt          LIKE type_t.num10   #(ver:35) add
   #add-point:sql_delete段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="sql_delet.define"
   
   #end add-point
   
   #add-point:Function前置處理  name="sql_delet.pre_function"
   
   #end add-point
   
   LET li_return = TRUE
 
   #應用 a47 樣板自動產生(Version:4)
      #刪除相關文件
      CALL agli010_set_pk_array()
      #add-point:相關文件刪除前 name="delete.befroe.related_document_remove"
      
      #end add-point   
      CALL cl_doc_remove()  
 
 
 
 
 
   #add-point:單頭刪除前 name="delete.head.b_delete"
            DELETE FROM glaal_t 
       WHERE glaalent = g_enterprise AND glaalld = g_glaa_m.glaald 
   #end add-point
   
   IF li_node = TRUE THEN
      #砍除該節點以下所有節點
      LET ls_sql = " SELECT glaald,glaacomp FROM ",
                   " (SELECT glaald,glaacomp FROM glaa_t WHERE glaaent = " ||g_enterprise|| " AND glaald<>glaacomp)", 
 
                   " START WITH glaacomp='",g_glaa_m.glaacomp,"'",
                   " CONNECT BY PRIOR glaald = glaacomp"
 
   ELSE 
   
   END IF
 
   #刪除當下節點
   DELETE FROM glaa_t
    WHERE glaaent = g_enterprise AND glaald = g_glaa_m.glaald
 
 
   #add-point:單頭刪除中 name="delete.head.m_delete"
            
   #end add-point
 
   IF SQLCA.SQLCODE THEN
      CALL s_transaction_end("N","0")
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "glaa_t:",SQLERRMESSAGE 
      LET g_errparam.code = SQLCA.SQLCODE 
      LET g_errparam.popup = FALSE 
      CALL cl_err()
   END IF
 
   #(ver:35) ---modify start---
   # 若此節點還有存在在其他節點下，則多語言資料不可刪除
   LET li_cnt = 0
   LET ls_sql = " SELECT COUNT(1) FROM glaa_t",
                 " WHERE glaaent = " ||g_enterprise|| " AND glaald = '",g_glaa_m.glaald,"'"
 
   PREPARE master_chk_node_exist FROM ls_sql
   EXECUTE master_chk_node_exist INTO li_cnt
   IF li_cnt <= 0 THEN
      INITIALIZE l_var_keys_bak TO NULL 
   INITIALIZE l_field_keys   TO NULL 
   LET l_var_keys_bak[01] = g_enterprise
   LET l_field_keys[01] = 'glaalent'
   LET l_var_keys_bak[02] = g_master_multi_table_t.glaalld
   LET l_field_keys[02] = 'glaalld'
   CALL cl_multitable_delete(l_field_keys,l_var_keys_bak,'glaal_t')
 
   END IF
   #(ver:35) --- modify end ---
 
   RETURN li_return
 
END FUNCTION
 
{</section>}
 
{<section id="agli010.set_entry" >}
#+ 單頭欄位開啟設定
PRIVATE FUNCTION agli010_set_entry(p_cmd)
   #add-point:set_entry段define name="set_entry.define_customerization"
   
   #end add-point
   DEFINE p_cmd   LIKE type_t.chr1 
   #add-point:set_entry段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_entry.define"
   DEFINE l_cnt   LIKE type_t.num5 #160310-00008#1 add   
   #end add-point
   
   #add-point:Function前置處理  name="set_entry.pre_function"
   
   #end add-point
   
   IF p_cmd = "a" THEN
      CALL cl_set_comp_entry("glaald",TRUE)
      #根據azzi850使用者身分開關特定欄位
      IF NOT cl_null(g_no_entry) THEN
         CALL cl_set_comp_entry(g_no_entry,TRUE)
      END IF
      #add-point:set_entry段欄位控制 name="set_entry.field_control"
            
      #end add-point 
   END IF
   
   #add-point:set_entry段欄位控制後 name="set_entry.after_control"
   IF p_cmd = 'r' THEN
      CALL cl_set_comp_entry("glaald",TRUE)
   END IF 
   IF g_glaa_m.glaa015 = 'Y' THEN
      CALL cl_set_comp_entry("glaa016,glaa017,glaa018",TRUE)
      CALL cl_set_comp_required('glaa016,glaa017,glaa018',TRUE)
   END IF 
   IF g_glaa_m.glaa019 = 'Y' THEN
      CALL cl_set_comp_entry("glaa020,glaa021,glaa022",TRUE)
      CALL cl_set_comp_required('glaa020,glaa021,glaa022',TRUE)
   END IF 
   IF g_glaa_m.glaa014 = 'N' THEN
      CALL cl_set_comp_entry("glaa008",TRUE)
   END IF
   IF g_glaa_m.glaa008 = 'N' THEN
      CALL cl_set_comp_entry("glaa014",TRUE)
   ELSE
      CALL cl_set_comp_entry("glaa023",TRUE)
      #160310-00008#1--mod--str--
#      LET g_glaa_m.glaa023 = '1' 
      IF cl_null(g_glaa_m.glaa023) THEN
         LET l_cnt=0
         SELECT COUNT(*) INTO l_cnt FROM glaa_t
          WHERE glaaent=g_enterprise AND glaacomp=g_glaa_m.glaacomp
            AND glaa008='Y' AND glaa023='1'
         IF l_cnt > 0 THEN
            LET l_cnt=0
            SELECT COUNT(*) INTO l_cnt FROM glaa_t
             WHERE glaaent=g_enterprise AND glaacomp=g_glaa_m.glaacomp
               AND glaa008='Y' AND glaa023='2'
            IF l_cnt = 0 THEN
               LET g_glaa_m.glaa023 = '2'
            END IF
         ELSE
            LET g_glaa_m.glaa023 = '1'
         END IF
      END IF
      #160310-00008#1--mod--end
   END IF
   IF g_glaa_m.glaa014 = 'N' AND g_glaa_m.glaa008 = 'N' THEN
      LET g_glaa_m.glaa009 = '1' 
      CALL cl_set_comp_entry('glaa009',TRUE)
      CALL cl_set_comp_required('glaa009',TRUE)
   END IF
   CALL cl_set_comp_entry('glaa140',TRUE)    #151008-00009#8   
   #end add-point 
   
END FUNCTION
 
{</section>}
 
{<section id="agli010.set_no_entry" >}
#+ 單頭欄位關閉設定
PRIVATE FUNCTION agli010_set_no_entry(p_cmd)
   #add-point:set_no_entry段define name="set_no_entry.define_customerization"
   
   #end add-point
   DEFINE p_cmd   LIKE type_t.chr1
   #add-point:set_no_entry段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_no_entry.define"
      
   #end add-point
   
   #add-point:Function前置處理  name="set_no_entry.pre_function"
   
   #end add-point
   
   IF p_cmd = 'u' AND g_chkey = 'N' THEN
      CALL cl_set_comp_entry("glaald",FALSE)
      #根據azzi850使用者身分開關特定欄位
      IF NOT cl_null(g_no_entry) THEN
         CALL cl_set_comp_entry(g_no_entry,FALSE)
      END IF
      #add-point:set_no_entry段欄位控制 name="set_no_entry.field_control"
            
      #end add-point 
   END IF
   
   #add-point:set_no_entry段欄位控制後 name="set_no_entry.after_control"
   IF g_glaa_m.glaa015 != 'Y' THEN
      CALL cl_set_comp_entry("glaa016,glaa017,glaa018",FALSE)
      CALL cl_set_comp_required('glaa016,glaa017,glaa018',FALSE)
      LET g_glaa_m.glaa016 = ''
      LET g_glaa_m.glaa017 = ''
      LET g_glaa_m.glaa018 = ''
   END IF 
   IF g_glaa_m.glaa019 != 'Y' THEN
      CALL cl_set_comp_entry("glaa020,glaa021,glaa022",FALSE)
      CALL cl_set_comp_required('glaa020,glaa021,glaa022',FALSE)
      LET g_glaa_m.glaa020 = ''
      LET g_glaa_m.glaa021 = ''
      LET g_glaa_m.glaa022 = ''
   END IF 
   IF g_glaa_m.glaa014 = 'Y' THEN
      CALL cl_set_comp_entry("glaa008",FALSE)
      LET g_glaa_m.glaa008 = 'N'
   END IF
   IF g_glaa_m.glaa008 = 'Y' THEN
      CALL cl_set_comp_entry("glaa014",FALSE)
      LET g_glaa_m.glaa014 = 'N'
   ELSE
      CALL cl_set_comp_entry("glaa023",FALSE)
      LET g_glaa_m.glaa023 = ''
   END IF
   IF NOT (g_glaa_m.glaa014 = 'N' AND g_glaa_m.glaa008 = 'N') THEN
      LET g_glaa_m.glaa009 = '' 
      CALL cl_set_comp_entry('glaa009',FALSE)
      CALL cl_set_comp_required('glaa009',FALSE)
   END IF
   #151008-00009#8--S
   IF g_glaa_m.glaa139 = 'N' THEN
      LET g_glaa_m.glaa140 = 'N' 
      CALL cl_set_comp_entry('glaa140',FALSE)    
   END IF
   #151008-00009#8--E
   #end add-point
   
END FUNCTION
 
{</section>}
 
{<section id="agli010.default_search" >}
#+ 外部參數預設搜尋
PRIVATE FUNCTION agli010_default_search()
   #add-point:default_search段define name="default_search.define_customerization"
   
   #end add-point
   DEFINE li_idx  LIKE type_t.num10
   DEFINE li_cnt  LIKE type_t.num10
   DEFINE ls_wc   STRING
   #add-point:default_search段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="default_search.define"
      
   #end add-point
   
   #add-point:Function前置處理  name="default_search.before"
      
   #end add-point  
   
   IF g_searchtype = 0 OR cl_null(g_searchtype) THEN
      LET g_searchtype = 3
   END IF 
   
   IF NOT cl_null(g_argv[01]) THEN
      LET ls_wc = ls_wc, " glaald = '", g_argv[01], "' AND "
   END IF
   
 
   
   #add-point:default_search段after sql name="default_search.after_sql"
   
   #end add-point  
   
   IF NOT cl_null(ls_wc) THEN
      LET ls_wc = ls_wc.subString(1,ls_wc.getLength()-5)
      LET g_wc = ls_wc
   ELSE
      IF cl_null(g_wc) THEN
         LET g_wc = " 1=2"
      END IF
   END IF
   
   #CALL agli010_browser_fill(g_wc,g_searchtype)
 
   #add-point:default_search段結束前 name="default_search.after"
   IF g_wc = " 1=2" THEN
      LET g_wc = " 1=1"
   END IF
   #end add-point
 
END FUNCTION
 
{</section>}
 
{<section id="agli010.state_change" >}
   #應用 a09 樣板自動產生(Version:17)
#+ 確認碼變更 
PRIVATE FUNCTION agli010_statechange()
   #add-point:statechange段define(客製用) name="statechange.define_customerization"
   
   #end add-point  
   DEFINE lc_state LIKE type_t.chr5
   #add-point:statechange段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="statechange.define"
   DEFINE l_pass        LIKE type_t.num5  #160825-00017#1 add   
   #end add-point  
   
   #add-point:Function前置處理 name="statechange.before"
   #160825-00017#1--add--str--
   IF g_glaa_m.glaald IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code   = "std-00003" 
      LET g_errparam.popup  = FALSE 
      CALL cl_err()
      RETURN
   END IF 
   CALL s_ld_chk_authorization(g_user,g_glaa_m.glaald) RETURNING l_pass
   IF l_pass = FALSE THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'agl-00165'
      LET g_errparam.extend = g_glaa_m.glaald
      LET g_errparam.popup = TRUE
      CALL cl_err()
    
      RETURN
   END IF
   #160825-00017#1--add--end   
   #end add-point  
   
   ERROR ""     #清空畫面右下側ERROR區塊
 
   IF g_glaa_m.glaald IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code   = "std-00003" 
      LET g_errparam.popup  = FALSE 
      CALL cl_err()
      RETURN
   END IF
 
   CALL s_transaction_begin()
   
   OPEN agli010_cl USING g_enterprise,g_glaa_m.glaald
   IF STATUS THEN
      CLOSE agli010_cl
      CALL s_transaction_end('N','0')
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "OPEN agli010_cl:" 
      LET g_errparam.code   = STATUS 
      LET g_errparam.popup  = TRUE 
      CALL cl_err()
      RETURN
   END IF
   
   #顯示最新的資料
   EXECUTE agli010_master_referesh USING g_glaa_m.glaald INTO g_glaa_m.glaald,g_glaa_m.glaacomp,g_glaa_m.glaa027, 
       g_glaa_m.glaa026,g_glaa_m.glaa001,g_glaa_m.glaa002,g_glaa_m.glaa025,g_glaa_m.glaa028,g_glaa_m.glaa003, 
       g_glaa_m.glaa004,g_glaa_m.glaa024,g_glaa_m.glaa005,g_glaa_m.glaa006,g_glaa_m.glaa007,g_glaa_m.glaa014, 
       g_glaa_m.glaa008,g_glaa_m.glaa023,g_glaa_m.glaa009,g_glaa_m.glaa130,g_glaa_m.glaa010,g_glaa_m.glaa011, 
       g_glaa_m.glaa012,g_glaa_m.glaa013,g_glaa_m.glaastus,g_glaa_m.glaa015,g_glaa_m.glaa019,g_glaa_m.glaa016, 
       g_glaa_m.glaa020,g_glaa_m.glaa017,g_glaa_m.glaa021,g_glaa_m.glaa018,g_glaa_m.glaa022,g_glaa_m.glaa100, 
       g_glaa_m.glaa101,g_glaa_m.glaa102,g_glaa_m.glaa103,g_glaa_m.glaa111,g_glaa_m.glaa112,g_glaa_m.glaa113, 
       g_glaa_m.glaa120,g_glaa_m.glaa121,g_glaa_m.glaa136,g_glaa_m.glaa137,g_glaa_m.glaa139,g_glaa_m.glaa140, 
       g_glaa_m.glaa122,g_glaa_m.glaa123,g_glaa_m.glaa124,g_glaa_m.glaa131,g_glaa_m.glaa132,g_glaa_m.glaa133, 
       g_glaa_m.glaa134,g_glaa_m.glaa138,g_glaa_m.glaa135,g_glaa_m.glaaownid,g_glaa_m.glaaowndp,g_glaa_m.glaacrtid, 
       g_glaa_m.glaacrtdp,g_glaa_m.glaacrtdt,g_glaa_m.glaamodid,g_glaa_m.glaamoddt,g_glaa_m.glaacomp_desc, 
       g_glaa_m.glaa026_desc,g_glaa_m.glaa001_desc,g_glaa_m.glaa002_desc,g_glaa_m.glaa003_desc,g_glaa_m.glaa004_desc, 
       g_glaa_m.glaa024_desc,g_glaa_m.glaa005_desc,g_glaa_m.glaa111_desc,g_glaa_m.glaa112_desc,g_glaa_m.glaa113_desc, 
       g_glaa_m.glaa120_desc,g_glaa_m.glaa135_desc,g_glaa_m.glaaownid_desc,g_glaa_m.glaaowndp_desc,g_glaa_m.glaacrtid_desc, 
       g_glaa_m.glaacrtdp_desc,g_glaa_m.glaamodid_desc
   
 
   #檢查是否允許此動作
   IF NOT agli010_action_chk() THEN
      CLOSE agli010_cl
      CALL s_transaction_end('N','0')
      RETURN
   END IF
 
   #將資料顯示到畫面上
   DISPLAY BY NAME g_glaa_m.glaald,g_glaa_m.glaal002,g_glaa_m.glaacomp,g_glaa_m.glaacomp_desc,g_glaa_m.glaa027, 
       g_glaa_m.glaa026,g_glaa_m.glaa026_desc,g_glaa_m.glaa001,g_glaa_m.glaa001_desc,g_glaa_m.glaa002, 
       g_glaa_m.glaa002_desc,g_glaa_m.glaa025,g_glaa_m.glaa028,g_glaa_m.glaa003,g_glaa_m.glaa003_desc, 
       g_glaa_m.glaa004,g_glaa_m.glaa004_desc,g_glaa_m.glaa024,g_glaa_m.glaa024_desc,g_glaa_m.glaa005, 
       g_glaa_m.glaa005_desc,g_glaa_m.glaa006,g_glaa_m.glaa007,g_glaa_m.glaa014,g_glaa_m.glaa008,g_glaa_m.glaa023, 
       g_glaa_m.glaa009,g_glaa_m.glaa130,g_glaa_m.glaa010,g_glaa_m.glaa011,g_glaa_m.glaa012,g_glaa_m.glaa013, 
       g_glaa_m.glaastus,g_glaa_m.glaa015,g_glaa_m.fflabel1_desc,g_glaa_m.glaa019,g_glaa_m.glaa016,g_glaa_m.glaa020, 
       g_glaa_m.glaa017,g_glaa_m.glaa021,g_glaa_m.glaa018,g_glaa_m.glaa022,g_glaa_m.fflabe7_desc,g_glaa_m.fflabel8_desc, 
       g_glaa_m.glaa100,g_glaa_m.glaa101,g_glaa_m.glaa102,g_glaa_m.glaa103,g_glaa_m.glaa111,g_glaa_m.glaa111_desc, 
       g_glaa_m.glaa112,g_glaa_m.glaa112_desc,g_glaa_m.glaa113,g_glaa_m.glaa113_desc,g_glaa_m.glaa120, 
       g_glaa_m.glaa120_desc,g_glaa_m.glaa121,g_glaa_m.glaa136,g_glaa_m.glaa137,g_glaa_m.glaa139,g_glaa_m.glaa140, 
       g_glaa_m.glaa122,g_glaa_m.glaa123,g_glaa_m.glaa124,g_glaa_m.glaa131,g_glaa_m.glaa132,g_glaa_m.glaa133, 
       g_glaa_m.glaa134,g_glaa_m.glaa138,g_glaa_m.glaa135,g_glaa_m.glaa135_desc,g_glaa_m.glaaownid,g_glaa_m.glaaownid_desc, 
       g_glaa_m.glaaowndp,g_glaa_m.glaaowndp_desc,g_glaa_m.glaacrtid,g_glaa_m.glaacrtid_desc,g_glaa_m.glaacrtdp, 
       g_glaa_m.glaacrtdp_desc,g_glaa_m.glaacrtdt,g_glaa_m.glaamodid,g_glaa_m.glaamodid_desc,g_glaa_m.glaamoddt 
 
 
   CASE g_glaa_m.glaastus
      WHEN "N"
         CALL gfrm_curr.setElementImage("statechange", "stus/32/inactive.png")
      WHEN "Y"
         CALL gfrm_curr.setElementImage("statechange", "stus/32/active.png")
      
   END CASE
 
   #add-point:資料刷新後 name="statechange.after_refresh"
   
   #end add-point
 
   MENU "" ATTRIBUTES (STYLE="popup")
      BEFORE MENU
         HIDE OPTION "approved"
         HIDE OPTION "rejection"
         CASE g_glaa_m.glaastus
            
            WHEN "N"
               HIDE OPTION "inactive"
            WHEN "Y"
               HIDE OPTION "active"
         END CASE
     
      #add-point:menu前 name="statechange.before_menu"
            
      #end add-point
      
      
	  
      ON ACTION inactive
         IF cl_auth_chk_act("inactive") THEN
            LET lc_state = "N"
            #add-point:action控制 name="statechange.inactive"
                  
            #end add-point
         END IF
         EXIT MENU
      ON ACTION active
         IF cl_auth_chk_act("active") THEN
            LET lc_state = "Y"
            #add-point:action控制 name="statechange.active"
                  
            #end add-point
         END IF
         EXIT MENU
 
      #add-point:stus控制 name="statechange.more_control"
            
      #end add-point
      
   END MENU
   
   #確認被選取的狀態碼在清單中
   IF (lc_state <> "N" 
      AND lc_state <> "Y"
      ) OR 
      g_glaa_m.glaastus = lc_state OR cl_null(lc_state) THEN
      CLOSE agli010_cl
      CALL s_transaction_end('N','0')
      RETURN
   END IF
   
   #add-point:stus修改前 name="statechange.b_update"
      
   #end add-point
   
   LET g_glaa_m.glaamodid = g_user
   LET g_glaa_m.glaamoddt = cl_get_current()
   LET g_glaa_m.glaastus = lc_state
   
   #異動狀態碼欄位/修改人/修改日期
   UPDATE glaa_t 
      SET (glaastus,glaamodid,glaamoddt) 
        = (g_glaa_m.glaastus,g_glaa_m.glaamodid,g_glaa_m.glaamoddt)     
    WHERE glaaent = g_enterprise AND glaald = g_glaa_m.glaald
 
    
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code   = SQLCA.sqlcode 
      LET g_errparam.popup  = FALSE 
      CALL cl_err()
   ELSE
      CASE lc_state
         WHEN "N"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/inactive.png")
         WHEN "Y"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/active.png")
         
      END CASE
    
      #撈取異動後的資料
      EXECUTE agli010_master_referesh USING g_glaa_m.glaald INTO g_glaa_m.glaald,g_glaa_m.glaacomp,g_glaa_m.glaa027, 
          g_glaa_m.glaa026,g_glaa_m.glaa001,g_glaa_m.glaa002,g_glaa_m.glaa025,g_glaa_m.glaa028,g_glaa_m.glaa003, 
          g_glaa_m.glaa004,g_glaa_m.glaa024,g_glaa_m.glaa005,g_glaa_m.glaa006,g_glaa_m.glaa007,g_glaa_m.glaa014, 
          g_glaa_m.glaa008,g_glaa_m.glaa023,g_glaa_m.glaa009,g_glaa_m.glaa130,g_glaa_m.glaa010,g_glaa_m.glaa011, 
          g_glaa_m.glaa012,g_glaa_m.glaa013,g_glaa_m.glaastus,g_glaa_m.glaa015,g_glaa_m.glaa019,g_glaa_m.glaa016, 
          g_glaa_m.glaa020,g_glaa_m.glaa017,g_glaa_m.glaa021,g_glaa_m.glaa018,g_glaa_m.glaa022,g_glaa_m.glaa100, 
          g_glaa_m.glaa101,g_glaa_m.glaa102,g_glaa_m.glaa103,g_glaa_m.glaa111,g_glaa_m.glaa112,g_glaa_m.glaa113, 
          g_glaa_m.glaa120,g_glaa_m.glaa121,g_glaa_m.glaa136,g_glaa_m.glaa137,g_glaa_m.glaa139,g_glaa_m.glaa140, 
          g_glaa_m.glaa122,g_glaa_m.glaa123,g_glaa_m.glaa124,g_glaa_m.glaa131,g_glaa_m.glaa132,g_glaa_m.glaa133, 
          g_glaa_m.glaa134,g_glaa_m.glaa138,g_glaa_m.glaa135,g_glaa_m.glaaownid,g_glaa_m.glaaowndp,g_glaa_m.glaacrtid, 
          g_glaa_m.glaacrtdp,g_glaa_m.glaacrtdt,g_glaa_m.glaamodid,g_glaa_m.glaamoddt,g_glaa_m.glaacomp_desc, 
          g_glaa_m.glaa026_desc,g_glaa_m.glaa001_desc,g_glaa_m.glaa002_desc,g_glaa_m.glaa003_desc,g_glaa_m.glaa004_desc, 
          g_glaa_m.glaa024_desc,g_glaa_m.glaa005_desc,g_glaa_m.glaa111_desc,g_glaa_m.glaa112_desc,g_glaa_m.glaa113_desc, 
          g_glaa_m.glaa120_desc,g_glaa_m.glaa135_desc,g_glaa_m.glaaownid_desc,g_glaa_m.glaaowndp_desc, 
          g_glaa_m.glaacrtid_desc,g_glaa_m.glaacrtdp_desc,g_glaa_m.glaamodid_desc
      
      #將資料顯示到畫面上
      DISPLAY BY NAME g_glaa_m.glaald,g_glaa_m.glaal002,g_glaa_m.glaacomp,g_glaa_m.glaacomp_desc,g_glaa_m.glaa027, 
          g_glaa_m.glaa026,g_glaa_m.glaa026_desc,g_glaa_m.glaa001,g_glaa_m.glaa001_desc,g_glaa_m.glaa002, 
          g_glaa_m.glaa002_desc,g_glaa_m.glaa025,g_glaa_m.glaa028,g_glaa_m.glaa003,g_glaa_m.glaa003_desc, 
          g_glaa_m.glaa004,g_glaa_m.glaa004_desc,g_glaa_m.glaa024,g_glaa_m.glaa024_desc,g_glaa_m.glaa005, 
          g_glaa_m.glaa005_desc,g_glaa_m.glaa006,g_glaa_m.glaa007,g_glaa_m.glaa014,g_glaa_m.glaa008, 
          g_glaa_m.glaa023,g_glaa_m.glaa009,g_glaa_m.glaa130,g_glaa_m.glaa010,g_glaa_m.glaa011,g_glaa_m.glaa012, 
          g_glaa_m.glaa013,g_glaa_m.glaastus,g_glaa_m.glaa015,g_glaa_m.fflabel1_desc,g_glaa_m.glaa019, 
          g_glaa_m.glaa016,g_glaa_m.glaa020,g_glaa_m.glaa017,g_glaa_m.glaa021,g_glaa_m.glaa018,g_glaa_m.glaa022, 
          g_glaa_m.fflabe7_desc,g_glaa_m.fflabel8_desc,g_glaa_m.glaa100,g_glaa_m.glaa101,g_glaa_m.glaa102, 
          g_glaa_m.glaa103,g_glaa_m.glaa111,g_glaa_m.glaa111_desc,g_glaa_m.glaa112,g_glaa_m.glaa112_desc, 
          g_glaa_m.glaa113,g_glaa_m.glaa113_desc,g_glaa_m.glaa120,g_glaa_m.glaa120_desc,g_glaa_m.glaa121, 
          g_glaa_m.glaa136,g_glaa_m.glaa137,g_glaa_m.glaa139,g_glaa_m.glaa140,g_glaa_m.glaa122,g_glaa_m.glaa123, 
          g_glaa_m.glaa124,g_glaa_m.glaa131,g_glaa_m.glaa132,g_glaa_m.glaa133,g_glaa_m.glaa134,g_glaa_m.glaa138, 
          g_glaa_m.glaa135,g_glaa_m.glaa135_desc,g_glaa_m.glaaownid,g_glaa_m.glaaownid_desc,g_glaa_m.glaaowndp, 
          g_glaa_m.glaaowndp_desc,g_glaa_m.glaacrtid,g_glaa_m.glaacrtid_desc,g_glaa_m.glaacrtdp,g_glaa_m.glaacrtdp_desc, 
          g_glaa_m.glaacrtdt,g_glaa_m.glaamodid,g_glaa_m.glaamodid_desc,g_glaa_m.glaamoddt
   END IF
 
   #add-point:stus修改後 name="statechange.a_update"
      
   #end add-point
 
   #add-point:statechange段結束前 name="statechange.after"
      
   #end add-point  
 
   CLOSE agli010_cl
   CALL s_transaction_end('Y','0')
 
   #功能已完成,通報訊息中心
   CALL agli010_msgcentre_notify('statechange:'||lc_state)
   
END FUNCTION
 
 
 
 
{</section>}
 
{<section id="agli010.set_pk_array" >}
   #應用 a51 樣板自動產生(Version:8)
#+ 給予pk_array內容
PRIVATE FUNCTION agli010_set_pk_array()
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
   LET g_pk_array[1].values = g_glaa_m.glaald
   LET g_pk_array[1].column = 'glaald'
 
   
   #add-point:set_pk_array段之後 name="set_pk_array.after"
   
   #end add-point  
   
END FUNCTION
 
 
 
 
{</section>}
 
{<section id="agli010.msgcentre_notify" >}
#應用 a66 樣板自動產生(Version:6)
PRIVATE FUNCTION agli010_msgcentre_notify(lc_state)
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
   CALL agli010_set_pk_array()
   #單頭資料填寫
   LET g_msgparam.data[1] = util.JSON.stringify(g_glaa_m)
 
   #add-point:msgcentre其他通知 name="msgcentre_notify.process"
   
   #end add-point
 
   #呼叫訊息中心傳遞本關完成訊息
   CALL cl_msgcentre_notify()
 
END FUNCTION
 
 
 
 
{</section>}
 
{<section id="agli010.action_chk" >}
PRIVATE FUNCTION agli010_action_chk()
   #add-point:action_chk段define(客製用) name="action_chk.define_customerization"
   
   #end add-point
   #add-point:action_chk段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="action_chk.define"
   
   #end add-point
   
   #add-point:action_chk段action_chk name="action_chk.action_chk"
   
   #end add-point
   
   RETURN TRUE
   
END FUNCTION
 
{</section>}
 
{<section id="agli010.other_function" readonly="Y" >}
#+
PRIVATE FUNCTION agli010_tree_create()
   DEFINE l_pid    LIKE type_t.chr50   #用於樹的第一層
   DEFINE l_sql    STRING 
   #傳入的條件
   IF cl_null(g_wc_def) THEN
      LET g_wc_def = " 1=1"
   END IF
   #建立樹上面的內容
   CALL g_browser.clear()
   CLEAR FORM
   #第一層的資料
   LET l_sql = " SELECT UNIQUE glaacomp FROM glaa_t ", 
               "  WHERE glaaent = '",g_enterprise,"'",
               "    AND ",g_wc_def," ",
               "  ORDER BY glaacomp "
   PREPARE master_type_0 FROM l_sql
   DECLARE master_typecur_0 CURSOR FOR master_type_0
   #第二層的資料
   LET l_sql = " SELECT UNIQUE glaald FROM glaa_t ",
               "  WHERE glaaent = '",g_enterprise,"' AND glaacomp = ? ", 
               "    AND ",g_wc_def," ",
#               "  ORDER BY glaacomp " #160812-00004#1 mark
               "  ORDER BY glaald "    #160812-00004#1 add
               
   PREPARE master_type_1 FROM l_sql
   DECLARE master_typecur_1 CURSOR FOR master_type_1
   
   INITIALIZE g_browser_root TO NULL
   #初始化l_ac
   LET l_ac = 1
   FOREACH master_typecur_0 INTO g_browser[l_ac].b_glaacomp
      #確定第一层root節點所在
      LET g_browser_root[g_browser_root.getLength()+1] = l_ac
      #此處(LV-1)
      LET g_browser[l_ac].b_glaacomp = g_browser[l_ac].b_glaacomp
      LET g_browser[l_ac].b_pid = '0' CLIPPED
      LET g_browser[l_ac].b_id = l_ac USING "<<<"
      LET g_browser[l_ac].b_exp = TRUE
      LET g_browser[l_ac].b_hasC = TRUE
      #第一層節點編號
      LET l_pid = g_browser[l_ac].b_id CLIPPED
      LET l_ac = l_ac + 1 
      LET g_cnt = l_ac
      FOREACH master_typecur_1 USING g_browser[l_ac-1].b_glaacomp INTO g_browser[g_cnt].b_glaald
         LET g_browser[g_cnt].b_glaacomp = g_browser[l_ac-1].b_glaacomp
         LET g_browser[g_cnt].b_glaald = g_browser[g_cnt].b_glaald
         LET g_browser[g_cnt].b_pid = l_pid
         LET g_browser[g_cnt].b_id = l_pid,".",g_cnt USING "<<<"
         LET g_browser[g_cnt].b_exp = TRUE
         LET g_browser[g_cnt].b_hasC = FALSE
         LET g_cnt = g_cnt +1
      END FOREACH 
      LET l_ac = g_browser.getLength()
   END FOREACH 
   #組合描述欄位&刪除多於資料
   FOR l_ac = 1 TO g_browser.getLength()
      IF cl_null(g_browser[l_ac].b_glaacomp) THEN
         CALL g_browser.deleteElement(l_ac)
         LET l_ac = l_ac - 1
      ELSE
         CALL agli010_desc_show(l_ac)
      END IF
   END FOR
   CALL g_browser.deleteElement(l_ac)
   LET g_browser_cnt = g_browser.getLength() - g_browser_root.getLength()
   DISPLAY g_browser_cnt TO h_count
   FREE tree_expand
   FREE master_getLV2
END FUNCTION
#參照表參考欄位帶值
PRIVATE FUNCTION agli010_ooal_ref(p_ooal001,p_ooal002)
   DEFINE p_ooal001 LIKE ooal_t.ooal001
   DEFINE p_ooal002 LIKE ooal_t.ooal002
   DEFINE r_ooall004 LIKE ooall_t.ooall004

   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = p_ooal001
   LET g_ref_fields[2] = p_ooal002
   CALL ap_ref_array2(g_ref_fields,"SELECT ooall004 FROM ooall_t WHERE ooallent='"||g_enterprise||"' AND ooall001=? AND ooall002=? AND ooall003='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET r_ooall004 = g_rtn_fields[1]
   RETURN r_ooall004
END FUNCTION
#+
PRIVATE FUNCTION agli010_self_action(p_open_code)
   DEFINE p_open_code  STRING
   DEFINE la_param     RECORD
          prog         STRING,
          param        DYNAMIC ARRAY OF STRING
                       END RECORD
   DEFINE ls_js        STRING
   
   INITIALIZE la_param.* TO NULL
   
   IF p_open_code = 'open_agli020' THEN
      IF NOT cl_null(g_glaa_m.glaa004) THEN
         LET la_param.prog = 'agli020'
         LET la_param.param[1] = g_glaa_m.glaa004
         LET la_param.param[2] = NULL         
         LET ls_js = util.JSON.stringify( la_param )
         CALL cl_cmdrun(ls_js)
#         CALL cl_cmdrun("agli020 '"||g_glaa_m.glaa004||"'")
      ELSE
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = '-400'
         LET g_errparam.extend = ''
         LET g_errparam.popup = TRUE
         CALL cl_err()

      END IF 
   END IF 
   IF p_open_code = 'open_agli030' THEN
      IF NOT cl_null(g_glaa_m.glaald) THEN
         LET la_param.prog = 'agli030'
         LET la_param.param[1] = g_glaa_m.glaald        
         LET ls_js = util.JSON.stringify( la_param )
         CALL cl_cmdrun(ls_js)
#         CALL cl_cmdrun("agli030 '"||g_glaa_m.glaald||"'")
      ELSE
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = '-400'
         LET g_errparam.extend = ''
         LET g_errparam.popup = TRUE
         CALL cl_err()

      END IF
   END IF 
   IF p_open_code = 'open_aooi150' THEN
      IF NOT cl_null(g_glaa_m.glaa002) THEN
         LET la_param.prog = 'aooi150'
         LET la_param.param[1] = g_glaa_m.glaa002      
         LET ls_js = util.JSON.stringify( la_param )
         CALL cl_cmdrun(ls_js)
#         CALL cl_cmdrun("aooi150 '"||g_glaa_m.glaa002||"'")
      ELSE
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = '-400'
         LET g_errparam.extend = ''
         LET g_errparam.popup = TRUE
         CALL cl_err()

      END IF
   END IF 
   IF p_open_code = 'open_agli100' THEN
     IF NOT cl_null(g_glaa_m.glaa003) THEN 
        LET la_param.prog = 'agli100'
         LET la_param.param[1] = g_glaa_m.glaa003
         LET la_param.param[2] = g_glaa_m.glaa010         
         LET ls_js = util.JSON.stringify( la_param )
         CALL cl_cmdrun(ls_js)
     ELSE
        INITIALIZE g_errparam TO NULL
         LET g_errparam.code = '-400'
         LET g_errparam.extend = ''
         LET g_errparam.popup = TRUE
         CALL cl_err()

     END IF
   END IF 
   
   IF p_open_code = 'open_agli010_01' THEN
      IF NOT cl_null(g_glaa_m.glaald) THEN
         CALL agli010_01(g_glaa_m.glaald)
      ELSE
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = '-400'
         LET g_errparam.extend = ''
         LET g_errparam.popup = TRUE
         CALL cl_err()

      END IF
   END IF
   
   IF p_open_code = 'open_agli010_02' THEN
      IF NOT cl_null(g_glaa_m.glaald) THEN
         CALL agli010_02(g_glaa_m.glaald)
      ELSE
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = '-400'
         LET g_errparam.extend = ''
         LET g_errparam.popup = TRUE
         CALL cl_err()

      END IF
   END IF
END FUNCTION
#使用幣別參考欄位帶值
PRIVATE FUNCTION agli010_glaa001_ref(p_glaa001)
   DEFINE p_glaa001  LIKE glaa_t.glaa001
   DEFINE r_ooail003 LIKE ooail_t.ooail003
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] =  p_glaa001
   CALL ap_ref_array2(g_ref_fields,"SELECT ooail003 FROM ooail_t WHERE ooailent='"||g_enterprise||"' AND ooail001=? AND ooail002='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET r_ooail003 = g_rtn_fields[1]
   RETURN r_ooail003
END FUNCTION
#檢查法人欄位的有效性
PRIVATE FUNCTION agli010_glaacomp_chk(p_glaacomp)
   DEFINE p_glaacomp LIKE glaa_t.glaacomp
   DEFINE r_success  LIKE type_t.num5
   DEFINE lc_count   LIKE type_t.num5
   LET r_success = TRUE 
   IF NOT cl_null(p_glaacomp) THEN
      #檢查是否存在
      IF r_success THEN 
         IF NOT ap_chk_isExist(p_glaacomp,"SELECT COUNT(*) FROM ooef_t WHERE ooefent = '"
            ||g_enterprise||"' AND ooef001 = ? ","aoo-00094",0 ) THEN
            LET r_success = FALSE 
         END IF
      END IF 

      #檢查是否有效
      IF r_success THEN 
         IF NOT ap_chk_isExist(p_glaacomp,"SELECT COUNT(*) FROM ooef_t WHERE ooefent = '"
#            ||g_enterprise||"' AND ooef001 = ? AND ooefstus = 'Y' ","aoo-00095",0 ) THEN
            ||g_enterprise||"' AND ooef001 = ? AND ooefstus = 'Y' ",'sub-01302','aooi125') THEN #160318-00005#12 mod  
            LET r_success = FALSE 
         END IF
      END IF 

      #檢查組織類型是否為法人
      IF r_success THEN 
         IF NOT ap_chk_isExist(p_glaacomp,"SELECT COUNT(*) FROM ooef_t WHERE ooefent = '"
            ||g_enterprise||"' AND ooef001 = ? AND ooefstus = 'Y' AND ooef003 = 'Y' ","agl-00085",0 ) THEN
            LET r_success = FALSE 
         END IF
      END IF 
      #檢查是否同一個法人下有多個主帳套
      IF r_success AND NOT cl_null(g_glaa_m.glaald) AND g_glaa_m.glaa014 = 'Y' THEN 
         LET lc_count = 0
         SELECT COUNT(*) INTO lc_count FROM glaa_t
          WHERE glaacomp = g_glaa_m.glaacomp AND glaa014 = 'Y'
            AND glaald != g_glaa_m.glaald AND glaaent = g_enterprise
         IF lc_count >= 1 THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = 'agl-00006'
            LET g_errparam.extend = ''
            LET g_errparam.popup = FALSE
            CALL cl_err()

            LET r_success = FALSE
         END IF
      END IF
   END IF 
   RETURN r_success 
END FUNCTION
#使用幣別有效性檢查
PRIVATE FUNCTION agli010_glaa001_chk(p_glaa001)
   DEFINE p_glaa001 LIKE glaa_t.glaa001
   DEFINE r_success LIKE type_t.num5

   LET r_success = TRUE
   IF NOT cl_null(p_glaa001) THEN
      #檢查是否存在
      IF r_success THEN
         IF NOT ap_chk_isExist(p_glaa001,"SELECT COUNT(*) FROM ooai_t WHERE ooaient = '"
            ||g_enterprise||"' AND ooai001 = ? ","aoo-00028",0 ) THEN
            LET r_success = FALSE 
         END IF
      END IF 
      #檢查是否有效
      IF r_success THEN
         IF NOT ap_chk_isExist(p_glaa001,"SELECT COUNT(*) FROM ooai_t WHERE ooaient = '"
#            ||g_enterprise||"' AND ooai001 = ? AND ooaistus = 'Y' ","aoo-00011",0 ) THEN
              ||g_enterprise||"' AND ooai001 = ? AND ooaistus = 'Y' ",'sub-01302','aooi140') THEN   #160318-00005#12 mod  
            LET r_success = FALSE  
         END IF
      END IF
   END IF 
   RETURN r_success
END FUNCTION
#+
PRIVATE FUNCTION agli010_glaald_ref(p_glaald)
   DEFINE p_glaald   LIKE glaa_t.glaald
   DEFINE r_glaal002 LIKE glaal_t.glaal002

   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = p_glaald
   CALL ap_ref_array2(g_ref_fields,"SELECT glaal002 FROM glaal_t WHERE glaalent='"||g_enterprise||"' AND glaalld=? AND glaal001='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET r_glaal002 = g_rtn_fields[1]
   RETURN r_glaal002
END FUNCTION
#參照表類型檢查
PRIVATE FUNCTION agli010_ooal_chk(p_ooal001,p_ooal002,p_field)
   DEFINE p_ooal001 LIKE ooal_t.ooal001
   DEFINE p_ooal002 LIKE ooal_t.ooal002
   DEFINE p_field   LIKE type_t.chr10
   DEFINE l_errno01 LIKE type_t.chr10
   DEFINE l_errno02 LIKE type_t.chr10
   DEFINE l_errno03 LIKE type_t.chr10
   DEFINE r_success LIKE type_t.num5

   LET r_success = TRUE
   IF NOT cl_null(p_ooal001) AND NOT cl_null(p_ooal002) THEN
      IF p_field = 'glaa002' THEN 
         LET l_errno01 = 'aoo-00129'
         LET l_errno02 = 'aoo-00128' 
         LET l_errno03 = 'agl-00008'  
      END IF 
#      IF p_field = 'glaa003' THEN 
#         LET l_errno01 = 'aoo-00125'
#         LET l_errno02 = 'aoo-00124'
#         LET l_errno03 = 'agl-00005'
#      END IF 
      IF p_field = 'glaa004' THEN 
         LET l_errno01 = 'agl-00007'
         LET l_errno02 = 'agl-00004'
         LET l_errno03 = 'agl-00010'
      END IF 
      IF p_field = 'glaa005' THEN 
         LET l_errno01 = 'agl-00001'
         LET l_errno02 = 'agl-00002'
         LET l_errno03 = 'agl-00003'
      END IF
      #存在
      IF r_success THEN
         #160318-00005#12 ADD--str
         CASE l_errno01
         WHEN 'aoo-00129'
              IF NOT ap_chk_isExist(p_ooal002,"SELECT COUNT(*) FROM ooal_t WHERE ooalent = '"
             ||g_enterprise||"'  AND ooal002 = ? ",'sub-01324','aooi071') THEN
             LET r_success = FALSE 
         END IF
         OTHERWISE
         #160318-00005#12 ADD--end
             IF NOT ap_chk_isExist(p_ooal002,"SELECT COUNT(*) FROM ooal_t WHERE ooalent = '"
                ||g_enterprise||"'  AND ooal002 = ? ",l_errno01,0 ) THEN
                LET r_success = FALSE 
             END IF
         END CASE #160318-00005#12 ADD--
      END IF 
      #有效
      IF r_success THEN
      #160318-00005#12 ADD--str
         CASE l_errno02
          WHEN 'agl-00004'
                IF NOT ap_chk_isExist(p_ooal002,"SELECT COUNT(*) FROM ooal_t WHERE ooalent = '"
                 ||g_enterprise||"' AND  ooal002 = ? AND ooalstus = 'Y'",'sub-01302','aooi070') THEN
                 LET r_success = FALSE 
              END IF
         WHEN 'agl-00002'
                IF NOT ap_chk_isExist(p_ooal002,"SELECT COUNT(*) FROM ooal_t WHERE ooalent = '"
                 ||g_enterprise||"' AND  ooal002 = ? AND ooalstus = 'Y'",'sub-01302','aooi078') THEN
                 LET r_success = FALSE 
              END IF
         WHEN 'aoo-00128' 
              IF NOT ap_chk_isExist(p_ooal002,"SELECT COUNT(*) FROM ooal_t WHERE ooalent = '"
                 ||g_enterprise||"' AND  ooal002 = ? AND ooalstus = 'Y'",'sub-01302','aooi071') THEN
                 LET r_success = FALSE 
              END IF
         OTHERWISE  #160318-00005#12 ADD--end
              IF NOT ap_chk_isExist(p_ooal002,"SELECT COUNT(*) FROM ooal_t WHERE ooalent = '"
                 ||g_enterprise||"' AND  ooal002 = ? AND ooalstus = 'Y'",l_errno02,0  ) THEN
                 LET r_success = FALSE 
              END IF
         END CASE #160318-00005#12 ADD
      END IF
      #參照表類型
      IF r_success THEN
          #160318-00005#12 ADD--str
          CASE l_errno03
          WHEN 'agl-00010'
               IF NOT ap_chk_isExist(p_ooal002,"SELECT COUNT(*) FROM ooal_t WHERE ooalent = '"
                  ||g_enterprise||"' AND ooal001 = '"||p_ooal001||"' AND  ooal002 = ? AND ooalstus = 'Y' ",'sub-01305','aooi070') THEN
                  LET r_success = FALSE 
               END IF
          WHEN 'agl-00008'
                IF NOT ap_chk_isExist(p_ooal002,"SELECT COUNT(*) FROM ooal_t WHERE ooalent = '"
                  ||g_enterprise||"' AND ooal001 = '"||p_ooal001||"' AND  ooal002 = ? AND ooalstus = 'Y' ",'sub-01305','aooi071') THEN
                  LET r_success = FALSE 
               END IF
          WHEN 'agl-00003'
               IF NOT ap_chk_isExist(p_ooal002,"SELECT COUNT(*) FROM ooal_t WHERE ooalent = '"
                  ||g_enterprise||"' AND ooal001 = '"||p_ooal001||"' AND  ooal002 = ? AND ooalstus = 'Y' ",'sub-01305','aooi078') THEN
                  LET r_success = FALSE 
               END IF
          OTHERWISE
         #160318-00005#12 ADD--end
             IF NOT ap_chk_isExist(p_ooal002,"SELECT COUNT(*) FROM ooal_t WHERE ooalent = '"
               ||g_enterprise||"' AND ooal001 = '"||p_ooal001||"' AND  ooal002 = ? AND ooalstus = 'Y' ",l_errno03,0) THEN
               LET r_success = FALSE 
             END IF
         END CASE #160318-00005#12 ADD
      END IF
      
   END IF 
   RETURN r_success 
END FUNCTION
#法人參考欄位帶值
PRIVATE FUNCTION agli010_glaacomp_ref(p_glaacomp)
   DEFINE p_glaacomp LIKE glaa_t.glaacomp
   DEFINE r_ooefl003 LIKE ooefl_t.ooefl003

   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = p_glaacomp
   CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET r_ooefl003 = g_rtn_fields[1]
   RETURN r_ooefl003
END FUNCTION
#檢查帳別編號是否重複
PRIVATE FUNCTION agli010_glaald_chk(p_glaald,p_glaald_t,p_cmd)
   DEFINE p_glaald   LIKE glaa_t.glaald
   DEFINE p_glaald_t LIKE glaa_t.glaald
   DEFINE p_cmd      LIKE type_t.chr1
   DEFINE r_success  LIKE type_t.num5

   LET r_success = TRUE
   IF NOT cl_null(p_glaald) THEN 
      IF p_cmd = 'a' OR p_cmd = 'r' OR ( p_cmd = 'u' AND ( p_cmd = 'u' AND (p_glaald != p_glaald_t ))) THEN 
         IF NOT ap_chk_notDup(p_glaald,"SELECT COUNT(*) FROM glaa_t WHERE "||"glaaent = '" ||g_enterprise|| "' AND "||"glaald = '"||p_glaald ||"'",'std-00004',0) THEN 
            LET r_success = FALSE 
         END IF
      END IF
   END IF
   RETURN r_success
END FUNCTION
#+
PRIVATE FUNCTION agli010_glaa008_chk(p_glaa008,p_glaacomp,p_glaald)
   DEFINE p_glaa008 LIKE glaa_t.glaa008
   DEFINE p_glaacomp LIKE glaa_t.glaacomp
   DEFINE p_glaald LIKE glaa_t.glaald
   DEFINE l_count LIKE type_t.num5
   DEFINE r_success LIKE type_t.num5
   
   LET l_count = 0
   LET r_success = TRUE
   IF p_glaa008 != 'Y' THEN
      RETURN r_success
   END IF 
   
   IF NOT cl_null(p_glaald) AND NOT cl_null(p_glaacomp) THEN
      SELECT count(*) INTO l_count FROM glaa_t
       WHERE glaaent = g_enterprise AND glaacomp = p_glaacomp
         AND glaa008 = 'Y' AND glaald != p_glaald AND glaa014 !='Y'
   END IF 
   IF l_count > 1 THEN
      LET r_success = FALSE
   END IF 
   IF NOT r_success THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'agl-00093'
      LET g_errparam.extend = p_glaacomp
      LET g_errparam.popup = TRUE
      CALL cl_err()

   END IF 
   RETURN r_success
END FUNCTION
#+ 檢查幣別是否重複
PRIVATE FUNCTION agli010_currency_chk(p_glaa001,p_glaa016,p_glaa020)
   DEFINE p_glaa001 LIKE glaa_t.glaa001
   DEFINE p_glaa016 LIKE glaa_t.glaa016
   DEFINE p_glaa020 LIKE glaa_t.glaa020
   DEFINE r_success LIKE type_t.num5
   
   LET r_success = TRUE
   IF NOT cl_null(p_glaa001) THEN
      IF NOT cl_null(p_glaa016) THEN
         IF p_glaa001 = p_glaa016 THEN
            LET r_success = FALSE
         END IF 
      END IF
      IF NOT cl_null(p_glaa020) THEN
         IF p_glaa001 = p_glaa020 THEN
            LET r_success = FALSE
         END IF 
      END IF 
   END IF 
   
   IF NOT cl_null(p_glaa016) THEN
      IF NOT cl_null(p_glaa020) THEN
         IF p_glaa016 = p_glaa020 THEN
            LET r_success = FALSE
         END IF 
      END IF 
   END IF 
   IF NOT r_success THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'agl-00094'
      LET g_errparam.extend = p_glaa001||"'"||p_glaa016||"'"||p_glaa020
      LET g_errparam.popup = FALSE
      CALL cl_err()

   END IF 
   RETURN r_success
END FUNCTION
################################################################################
# Descriptions...: 描述说明
# Memo...........:
# Usage..........: CALL agli010_glaa003_chk(p_glaa003)
#                  RETURNING r_success
# Input parameter: p_glaa003 會計週期編號
# Return code....: r_success 資料是否有效
# Date & Author..: 20131104 By xuxz
# Modify.........:
################################################################################
PRIVATE FUNCTION agli010_glaa003_chk(p_glaa003)
   DEFINE p_glaa003 LIKE glaa_t.glaa003
   DEFINE r_success LIKE type_t.num5
   
   LET r_success = TRUE
   IF NOT cl_null(p_glaa003) THEN
      IF r_success THEN
         IF NOT ap_chk_isExist(p_glaa003,"SELECT COUNT(*) FROM glav_t WHERE glavent = '"
            ||g_enterprise||"' AND  glav001 = ? ","agl-00129",0 ) THEN
            LET r_success = FALSE 
         END IF
      END IF 
      
      IF r_success THEN
         IF NOT ap_chk_isExist(p_glaa003,"SELECT COUNT(*) FROM glav_t WHERE glavent = '"
#            ||g_enterprise||"' AND  glav001 = ? AND glavstus = 'Y' ","agl-00130",0 ) THEN
            ||g_enterprise||"' AND  glav001 = ? AND glavstus = 'Y' ",'sub-01302','agli100') THEN #160318-00005#12 mod 
            LET r_success = FALSE 
         END IF
      END IF 
   END IF 
   RETURN r_success
END FUNCTION
################################################################################
# Descriptions...: glaa120带出说明栏位
# Memo...........:
# Usage..........: agli010_glaa120_ref(p_glaald,p_glaa120)
#                  RETURNING r_xcatl003
# Input parameter: p_glaa120  成本類型
#                : p_glaald   帳套
# Return code....: r_xcatl003
# Date & Author..: 2014/01/09 By 徐晓治
# Modify.........: 2015/07/21 by 02599
################################################################################
PRIVATE FUNCTION agli010_glaa120_ref(p_glaald,p_glaa120)
   DEFINE p_glaald  LIKE glaa_t.glaald
   DEFINE p_glaa120 LIKE glaa_t.glaa120
   DEFINE r_xcazl003 LIKE xcazl_t.xcazl003

   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = p_glaald
   LET g_ref_fields[2] = p_glaa120
   CALL ap_ref_array2(g_ref_fields,"SELECT xcazl003 FROM xcazl_t WHERE xcazlent='"||g_enterprise||"' AND xcazlld=? AND xcazl001=? AND xcazl002='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET r_xcazl003 = g_rtn_fields[1]
   RETURN r_xcazl003
END FUNCTION
################################################################################
# Descriptions...: 描述说明
# Memo...........:
# Usage..........: CALL agli010_doc_chk(p_glaa024)
#                  RETURNING r_success,r_field
# Input parameter: p_glaa024
# Return code....: r_success
#                : r_field
# Modify.........:
################################################################################
PRIVATE FUNCTION agli010_doc_chk(p_glaa024)
   DEFINE p_glaa024 LIKE glaa_t.glaa024
   DEFINE r_success LIKE type_t.num5
   DEFINE r_field   LIKE type_t.chr10
   
   LET r_field = ''
   LET r_success = TRUE
   
   #glaa111
   IF r_success AND NOT cl_null(g_glaa_m.glaa111) THEN
      INITIALIZE g_chkparam.* TO NULL
      LET g_chkparam.arg1 = p_glaa024
      LET g_chkparam.arg2 = g_glaa_m.glaa111
      #160318-00025#38  2016/04/21  by pengxin  add(S)
      LET g_errshow = TRUE #是否開窗 
      LET g_chkparam.err_str[1] = "agl-00189:sub-01302|aooi200|",cl_get_progname("aooi200",g_lang,"2"),"|:EXEPROGaooi200"
      #160318-00025#38  2016/04/21  by pengxin  add(E)
      IF NOT cl_chk_exist("v_ooba002_01") THEN
         LET r_success = FALSE
         LET r_field = 'glaa111'
      END IF
   END IF
   #glaa112
   IF r_success AND NOT cl_null(g_glaa_m.glaa112) THEN
      INITIALIZE g_chkparam.* TO NULL
      LET g_chkparam.arg1 = p_glaa024
      LET g_chkparam.arg2 = g_glaa_m.glaa112
      #160318-00025#38  2016/04/21  by pengxin  add(S)
      LET g_errshow = TRUE #是否開窗 
      LET g_chkparam.err_str[1] = "agl-00189:sub-01302|aooi200|",cl_get_progname("aooi200",g_lang,"2"),"|:EXEPROGaooi200"
      #160318-00025#38  2016/04/21  by pengxin  add(E)
      IF NOT cl_chk_exist("v_ooba002_02") THEN
         LET r_success = FALSE
         LET r_field = 'glaa112'
      END IF 
   END IF
   #glaa113
   IF r_success AND NOT cl_null(g_glaa_m.glaa113) THEN
      INITIALIZE g_chkparam.* TO NULL
      LET g_chkparam.arg1 = p_glaa024
      LET g_chkparam.arg2 = g_glaa_m.glaa113
      #160318-00025#38  2016/04/21  by pengxin  add(S)
      LET g_errshow = TRUE #是否開窗 
      LET g_chkparam.err_str[1] = "agl-00189:sub-01302|aooi200|",cl_get_progname("aooi200",g_lang,"2"),"|:EXEPROGaooi200"
      #160318-00025#38  2016/04/21  by pengxin  add(E)
      IF NOT cl_chk_exist("v_ooba002_03") THEN
         LET r_success = FALSE
         LET r_field = 'glaa113'
      END IF 
   END IF
   
   RETURN r_success,r_field
END FUNCTION
################################################################################
# Descriptions...: 獲取幣別參照表說明
# Memo...........:
# Usage..........: CALL agli010_glaa026_desc(p_glaa026)
# Input parameter: p_glaa026      幣別參照表號
# Date & Author..: 2014/03/06 By wangrr
# Modify.........:
################################################################################
PRIVATE FUNCTION agli010_glaa026_desc(p_glaa026)
   DEFINE p_glaa026    LIKE glaa_t.glaa026
   
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = p_glaa026
   CALL ap_ref_array2(g_ref_fields,"SELECT ooall004 FROM ooall_t WHERE ooallent='"||g_enterprise||"' AND ooall001='10' AND ooall002=? AND ooall003='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_glaa_m.glaa026_desc = '', g_rtn_fields[1] , ''
END FUNCTION

################################################################################
# Descriptions...: 檢查匯率參照表，幣別參照表及幣別與組織基本資料不同
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
PRIVATE FUNCTION agli010_glaa001_002_026_chk()
DEFINE l_n         LIKE type_t.num5
DEFINE r_success   LIKE type_t.num5

   LET r_success = TRUE
   SELECT COUNT(*) INTO l_n FROM ooef_t
    WHERE ooefent = g_enterprise AND ooef014 = g_glaa_m.glaa026
      AND ooef016 = g_glaa_m.glaa001 AND ooef015 = g_glaa_m.glaa002
   IF l_n = 0 THEN
      LET r_success =FALSE
   END IF
   RETURN r_success

END FUNCTION

################################################################################
# Descriptions...: 单据据点代号检查
# Memo...........:
# Usage..........: CALL agli010_glaa027_chk()
# Date & Author..: 2014/12/25 By wangrr
# Modify.........:
################################################################################
PRIVATE FUNCTION agli010_glaa027_chk()
   DEFINE l_len,l_len1       LIKE type_t.num5
   DEFINE l_str              STRING
   
   LET g_errno=''
   IF NOT cl_null(g_glaa_m.glaacomp) THEN
      #依參數設定，對輸入值長度判斷
      LET l_len = 0
      LET l_len1 = 0
      LET l_len = cl_get_para(g_enterprise,g_glaa_m.glaacomp,'E-COM-0003')
      LET l_str = g_glaa_m.glaa027  #轉換成STRING類型
      LET l_len1 = l_str.getLength()
      IF l_len1 > l_len THEN   #輸入值大於設定的長度
         LET l_str = l_str.subString(1,l_len)
         LET g_glaa_m.glaa027 = l_str
      END IF
   
      #輸入值不可重複
      LET l_len=0
      SELECT COUNT(*) INTO l_len FROM glaa_t WHERE glaaent = g_enterprise AND glaa027 = g_glaa_m.glaa027
      IF l_len >0 THEN
         LET g_errno='aoo-00277'                    
      END IF
   END IF
END FUNCTION

################################################################################
# Descriptions...: 檢查現金異動碼錶編碼是否存在參照表
# Memo...........: #140314-00001#4
# Usage..........: CALL agli010_chk_glaa135(p_glaa135)
# Date & Author..: 150511 By Jessy
################################################################################
PRIVATE FUNCTION agli010_chk_glaa135(p_glaa135)
   DEFINE p_glaa135    LIKE glaa_t.glaa135
   DEFINE r_errno      LIKE type_t.chr20
   DEFINE l_ooal002    LIKE ooal_t.ooal002
   DEFINE l_ooalstus   LIKE ooal_t.ooalstus
   
      LET r_errno = ''
   
      SELECT ooal002,ooalstus INTO l_ooal002,l_ooalstus
         FROM ooal_t
      WHERE ooalent = g_enterprise
         AND ooal001 = 16
         AND ooal002 = p_glaa135
   
      CASE
         WHEN sqlca.sqlcode = 100   LET r_errno = 'sub-01309' #'anm-02906' #160318-00005#12 mod
         WHEN l_ooalstus ='N'       LET r_errno = 'sub-01302'#'anm-02907' #160318-00005#12 mod  
      END CASE
      RETURN r_errno
END FUNCTION

################################################################################
# Descriptions...: 更新aoos020中辅账资料
# Memo...........: #160310-00008#1
# Usage..........: CALL agli010_upd_aoos020(p_cmd)
#                  RETURNING r_success
# Input parameter: p_cmd          当前操作状态
# Return code....: r_success      更新结果TRUE/FALSE
# Date & Author..: 2016/03/16 By 02599
# Modify.........:
################################################################################
PRIVATE FUNCTION agli010_upd_aoos020(p_cmd)
   DEFINE p_cmd        LIKE type_t.chr1
   DEFINE r_success    LIKE type_t.num5
   
   LET r_success = TRUE
   CASE
      #新增:更新对应辅账顺序为当前账套
      WHEN p_cmd='a' 
         IF g_glaa_m.glaa008 = 'Y' THEN
            IF g_glaa_m.glaa023 = '1' THEN
               UPDATE ooab_t SET ooab002=g_glaa_m.glaald
                WHERE ooabent=g_enterprise AND ooabsite=g_glaa_m.glaacomp AND ooab001='S-FIN-0001'
            ELSE
               UPDATE ooab_t SET ooab002=g_glaa_m.glaald
                WHERE ooabent=g_enterprise AND ooabsite=g_glaa_m.glaacomp AND ooab001='S-FIN-0002'
            END IF
         END IF
      #删除:更新对应辅账顺序为NULL
      WHEN p_cmd='d'
         IF g_glaa_m.glaa008 = 'Y' THEN
            IF g_glaa_m.glaa023 = '1' THEN
               UPDATE ooab_t SET ooab002=NULL
                WHERE ooabent=g_enterprise AND ooabsite=g_glaa_m.glaacomp AND ooab001='S-FIN-0001'
            ELSE
               UPDATE ooab_t SET ooab002=NULL
                WHERE ooabent=g_enterprise AND ooabsite=g_glaa_m.glaacomp AND ooab001='S-FIN-0002'
            END IF
         END IF
      #修改
      WHEN p_cmd='u'
         #从未启用辅账变成启用辅账
         IF g_glaa_m_t.glaa008 = 'N' AND g_glaa_m.glaa008 = 'Y' THEN
            IF g_glaa_m.glaa023 = '1' THEN
               UPDATE ooab_t SET ooab002=g_glaa_m.glaald
                WHERE ooabent=g_enterprise AND ooabsite=g_glaa_m.glaacomp AND ooab001='S-FIN-0001'
            ELSE
               UPDATE ooab_t SET ooab002=g_glaa_m.glaald
                WHERE ooabent=g_enterprise AND ooabsite=g_glaa_m.glaacomp AND ooab001='S-FIN-0002'
            END IF
         END IF
         #从启用辅账变成未启用辅账
         IF g_glaa_m_t.glaa008 = 'Y' AND g_glaa_m.glaa008 = 'N' THEN
            IF g_glaa_m_t.glaa023 = '1' THEN
               UPDATE ooab_t SET ooab002=NULL
                WHERE ooabent=g_enterprise AND ooabsite=g_glaa_m.glaacomp AND ooab001='S-FIN-0001'
            ELSE
               UPDATE ooab_t SET ooab002=NULL
                WHERE ooabent=g_enterprise AND ooabsite=g_glaa_m.glaacomp AND ooab001='S-FIN-0002'
            END IF
         END IF
         #一直是启用辅账,辅账顺序发生变化
         IF g_glaa_m_t.glaa008 = 'Y' AND g_glaa_m.glaa008 = 'Y' THEN
            IF g_glaa_m.glaa023='1' AND g_glaa_m_t.glaa023='2' THEN
               #更新辅账一为当前账套
               UPDATE ooab_t SET ooab002=g_glaa_m.glaald
                WHERE ooabent=g_enterprise AND ooabsite=g_glaa_m.glaacomp AND ooab001='S-FIN-0001'
               #更新辅账二位NULL
               UPDATE ooab_t SET ooab002=NULL
                WHERE ooabent=g_enterprise AND ooabsite=g_glaa_m.glaacomp AND ooab001='S-FIN-0002'
            END IF
            IF g_glaa_m.glaa023='2' AND g_glaa_m_t.glaa023='1' THEN
               #更新辅账一为NULL
               UPDATE ooab_t SET ooab002=NULL
                WHERE ooabent=g_enterprise AND ooabsite=g_glaa_m.glaacomp AND ooab001='S-FIN-0001'
               #更新辅账二位当前账套
               UPDATE ooab_t SET ooab002=g_glaa_m.glaald
                WHERE ooabent=g_enterprise AND ooabsite=g_glaa_m.glaacomp AND ooab001='S-FIN-0002'
            END IF
         END IF
   END CASE 
   IF SQLCA.SQLcode  THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "update ooab_t" 
      LET g_errparam.code   = SQLCA.sqlcode 
      LET g_errparam.popup  = TRUE 
      CALL cl_err()
      LET r_success = FALSE
   END IF
   RETURN r_success
END FUNCTION

################################################################################
# Descriptions...: 抓取单别说明
# Memo...........: #160413-00010#1
# Usage..........: CALL agli010_get_oobxl003(p_oobxl001)
#                  RETURNING r_oobxl003
# Input parameter: p_oobxl001     单别
# Return code....: r_oobxl003     单别说明
# Date & Author..: 2016/04/19 By 02599
# Modify.........:
################################################################################
PRIVATE FUNCTION agli010_get_oobxl003(p_oobxl001)
   DEFINE p_oobxl001    LIKE oobxl_t.oobxl001
   DEFINE r_oobxl003    LIKE oobxl_t.oobxl003
   
   LET r_oobxl003 = ''
   SELECT oobxl003 INTO r_oobxl003 FROM oobxl_t
    WHERE oobxlent=g_enterprise AND oobxl001=p_oobxl001
      AND oobxl002=g_dlang
   RETURN r_oobxl003
END FUNCTION

 
{</section>}
 
