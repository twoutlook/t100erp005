#該程式未解開Section, 採用最新樣板產出!
{<section id="aprt310.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0019(2016-01-07 17:58:34), PR版次:0019(2017-01-22 16:13:22)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000096
#+ Filename...: aprt310
#+ Description: 促銷談判條件申請
#+ Creator....: 01251(2015-05-14 15:36:02)
#+ Modifier...: 01251 -SD/PR- 06189
 
{</section>}
 
{<section id="aprt310.global" >}
#應用 t01 樣板自動產生(Version:79)
#add-point:填寫註解說明 name="global.memo" 
#160318-00025#6   2016/04/19  By 07675       將重複內容的錯誤訊息置換為公用錯誤訊息(r.v）
#160523-00024#1   2016/05/25  by 08172       促销方案错误信息修改
#160604-00001#1   2016/06/30  by 08172       新增BPM集成功能
#160720-00013#1   2016/07/21  by 08172       将临时表放入元件中
#160727-00019#14 2016/08/02 By 08742         系统中定义的临时表名称超过15码在执行时会出错,所以需要将系统中定义的临时表长度超过15码的全部改掉	 	
#                                            Mod   aprt310_preh_tmp -->aprt310_tmp01
#                                            Mod   aprt310_preb_tmp -->aprt310_tmp02
#160816-00068#12  2016/08/22  By 08209       調整transaction
#160818-00017#31  2016/08/30  By 08742       删除修改未重新判断状态码
#160905-00007#13  20160905 by geza           sql加上ent条件
#161101-00022#1   2016/11/01  By 02481       aooi500规范调整
#161111-00028#4   2016/11/21  by 02481       标准程式定义采用宣告模式,弃用.*写法
#160824-00007#147 2016/11/23  by 06814       新舊值相關
#170122-00004#2   2017/01/22  by geza        调整系统中无ENT的SQL条件增加ent
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
PRIVATE type type_g_prea_m        RECORD
       preasite LIKE prea_t.preasite, 
   preasite_desc LIKE type_t.chr80, 
   preadocdt LIKE prea_t.preadocdt, 
   preadocno LIKE prea_t.preadocno, 
   prea000 LIKE prea_t.prea000, 
   preaunit LIKE prea_t.preaunit, 
   prea001 LIKE prea_t.prea001, 
   prea002 LIKE prea_t.prea002, 
   preal002 LIKE type_t.chr500, 
   preaacti LIKE prea_t.preaacti, 
   preastus LIKE prea_t.preastus, 
   prea003 LIKE prea_t.prea003, 
   prea003_desc LIKE type_t.chr80, 
   prea004 LIKE prea_t.prea004, 
   prea052 LIKE prea_t.prea052, 
   prea005 LIKE prea_t.prea005, 
   prea006 LIKE prea_t.prea006, 
   prea006_desc LIKE type_t.chr80, 
   preb003_1 LIKE type_t.dat, 
   preb004_1 LIKE type_t.dat, 
   prea051 LIKE prea_t.prea051, 
   prea008 LIKE prea_t.prea008, 
   prea008_desc LIKE type_t.chr80, 
   prea007 LIKE prea_t.prea007, 
   prea007_desc LIKE type_t.chr80, 
   prea009 LIKE prea_t.prea009, 
   prea009_desc LIKE type_t.chr80, 
   prea010 LIKE prea_t.prea010, 
   prea010_desc LIKE type_t.chr80, 
   preb005_1 LIKE type_t.chr8, 
   preb006_1 LIKE type_t.chr8, 
   prea013 LIKE prea_t.prea013, 
   prea050 LIKE prea_t.prea050, 
   prea011 LIKE prea_t.prea011, 
   prea011_desc LIKE type_t.chr80, 
   prea012 LIKE prea_t.prea012, 
   prea012_desc LIKE type_t.chr80, 
   prea014 LIKE prea_t.prea014, 
   prea015 LIKE prea_t.prea015, 
   preb007_1 LIKE type_t.chr10, 
   preb008_1 LIKE type_t.chr1, 
   preaownid LIKE prea_t.preaownid, 
   preaownid_desc LIKE type_t.chr80, 
   preaowndp LIKE prea_t.preaowndp, 
   preaowndp_desc LIKE type_t.chr80, 
   preacrtid LIKE prea_t.preacrtid, 
   preacrtid_desc LIKE type_t.chr80, 
   preacrtdp LIKE prea_t.preacrtdp, 
   preacrtdp_desc LIKE type_t.chr80, 
   preacrtdt LIKE prea_t.preacrtdt, 
   preamodid LIKE prea_t.preamodid, 
   preamodid_desc LIKE type_t.chr80, 
   preamoddt LIKE prea_t.preamoddt, 
   preacnfid LIKE prea_t.preacnfid, 
   preacnfid_desc LIKE type_t.chr80, 
   preacnfdt LIKE prea_t.preacnfdt, 
   preapstid LIKE prea_t.preapstid, 
   preapstid_desc LIKE type_t.chr80, 
   preapstdt LIKE prea_t.preapstdt
       END RECORD
 
#單身 type 宣告
PRIVATE TYPE type_g_prec_d        RECORD
       precacti LIKE prec_t.precacti, 
   precseq LIKE prec_t.precseq, 
   prec003 LIKE prec_t.prec003, 
   prec003_desc LIKE type_t.chr500, 
   prec004 LIKE prec_t.prec004, 
   prec004_desc LIKE type_t.chr500, 
   prec005 LIKE prec_t.prec005, 
   prec005_desc LIKE type_t.chr500, 
   prec006 LIKE prec_t.prec006, 
   prec006_desc LIKE type_t.chr500, 
   prec007 LIKE prec_t.prec007, 
   prec008 LIKE prec_t.prec008, 
   prec009 LIKE prec_t.prec009, 
   prec010 LIKE prec_t.prec010, 
   prec011 LIKE prec_t.prec011, 
   prec012 LIKE prec_t.prec012, 
   prec013 LIKE prec_t.prec013, 
   prec014 LIKE prec_t.prec014, 
   prec015 LIKE prec_t.prec015, 
   prec016 LIKE prec_t.prec016, 
   prec017 LIKE prec_t.prec017, 
   prec018 LIKE prec_t.prec018, 
   prec019 LIKE prec_t.prec019, 
   prec020 LIKE prec_t.prec020, 
   prec021 LIKE prec_t.prec021, 
   prec022 LIKE prec_t.prec022, 
   prec023 LIKE prec_t.prec023, 
   prec024 LIKE prec_t.prec024, 
   prec025 LIKE prec_t.prec025, 
   prec026 LIKE prec_t.prec026, 
   prec027 LIKE prec_t.prec027, 
   prec028 LIKE prec_t.prec028, 
   prec029 LIKE prec_t.prec029, 
   prec030 LIKE prec_t.prec030, 
   prec031 LIKE prec_t.prec031, 
   prec032 LIKE prec_t.prec032, 
   prec033 LIKE prec_t.prec033, 
   prec034 LIKE prec_t.prec034, 
   prec035 LIKE prec_t.prec035, 
   prec036 LIKE prec_t.prec036, 
   prec037 LIKE prec_t.prec037, 
   prec038 LIKE prec_t.prec038, 
   prec039 LIKE prec_t.prec039, 
   prec040 LIKE prec_t.prec040, 
   prec041 LIKE prec_t.prec041, 
   prec042 LIKE prec_t.prec042, 
   prec043 LIKE prec_t.prec043, 
   prec044 LIKE prec_t.prec044, 
   prec045 LIKE prec_t.prec045, 
   prec098 LIKE prec_t.prec098, 
   prec046 LIKE prec_t.prec046, 
   prec047 LIKE prec_t.prec047, 
   prec048 LIKE prec_t.prec048, 
   prec049 LIKE prec_t.prec049, 
   prec050 LIKE prec_t.prec050, 
   prec051 LIKE prec_t.prec051, 
   prec052 LIKE prec_t.prec052, 
   prec053 LIKE prec_t.prec053, 
   prec054 LIKE prec_t.prec054, 
   prec055 LIKE prec_t.prec055, 
   prec056 LIKE prec_t.prec056, 
   prec057 LIKE prec_t.prec057, 
   prec058 LIKE prec_t.prec058, 
   prec059 LIKE prec_t.prec059, 
   prec060 LIKE prec_t.prec060, 
   prec061 LIKE prec_t.prec061, 
   prec062 LIKE prec_t.prec062, 
   prec063 LIKE prec_t.prec063, 
   prec064 LIKE prec_t.prec064, 
   prec065 LIKE prec_t.prec065, 
   prec066 LIKE prec_t.prec066, 
   prec067 LIKE prec_t.prec067, 
   prec068 LIKE prec_t.prec068, 
   prec069 LIKE prec_t.prec069, 
   prec070 LIKE prec_t.prec070, 
   prec071 LIKE prec_t.prec071, 
   prec072 LIKE prec_t.prec072, 
   prec073 LIKE prec_t.prec073, 
   prec074 LIKE prec_t.prec074, 
   prec075 LIKE prec_t.prec075, 
   prec078 LIKE prec_t.prec078, 
   prec079 LIKE prec_t.prec079, 
   prec081 LIKE prec_t.prec081, 
   prec001 LIKE prec_t.prec001
       END RECORD
PRIVATE TYPE type_g_prec2_d RECORD
       precseq LIKE prec_t.precseq, 
   prec080 LIKE prec_t.prec080, 
   prec082 LIKE prec_t.prec082, 
   prec083 LIKE prec_t.prec083, 
   prec084 LIKE prec_t.prec084, 
   prec085 LIKE prec_t.prec085, 
   prec086 LIKE prec_t.prec086, 
   prec087 LIKE prec_t.prec087, 
   prec088 LIKE prec_t.prec088, 
   prec089 LIKE prec_t.prec089, 
   prec090 LIKE prec_t.prec090, 
   prec091 LIKE prec_t.prec091, 
   prec092 LIKE prec_t.prec092, 
   prec093 LIKE prec_t.prec093, 
   prec094 LIKE prec_t.prec094, 
   prec095 LIKE prec_t.prec095, 
   prec096 LIKE prec_t.prec096, 
   prec097 LIKE prec_t.prec097, 
   precunit LIKE prec_t.precunit, 
   precsite LIKE prec_t.precsite
       END RECORD
PRIVATE TYPE type_g_prec3_d RECORD
       predacti LIKE pred_t.predacti, 
   predseq1 LIKE pred_t.predseq1, 
   pred001 LIKE pred_t.pred001, 
   pred002 LIKE pred_t.pred002, 
   pred002_desc LIKE type_t.chr500, 
   pred003 LIKE pred_t.pred003, 
   pred003_desc LIKE type_t.chr500, 
   predseq LIKE pred_t.predseq, 
   pred004 LIKE pred_t.pred004, 
   pred006 LIKE pred_t.pred006, 
   pred005 LIKE pred_t.pred005, 
   pred007 LIKE pred_t.pred007, 
   predsite LIKE pred_t.predsite, 
   predunit LIKE pred_t.predunit
       END RECORD
PRIVATE TYPE type_g_prec4_d RECORD
       preb002 LIKE preb_t.preb002, 
   preb003 LIKE preb_t.preb003, 
   preb004 LIKE preb_t.preb004, 
   preb005 LIKE preb_t.preb005, 
   preb006 LIKE preb_t.preb006, 
   preb007 LIKE preb_t.preb007, 
   preb008 LIKE preb_t.preb008, 
   prebacti LIKE preb_t.prebacti, 
   prebsite LIKE preb_t.prebsite, 
   prebunit LIKE preb_t.prebunit, 
   preb001 LIKE preb_t.preb001
       END RECORD
 
 
PRIVATE TYPE type_browser RECORD
         b_statepic     LIKE type_t.chr50,
            b_preadocno LIKE prea_t.preadocno
       END RECORD
       
#add-point:自定義模組變數(Module Variable) (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="global.variable"
DEFINE g_site_flag           LIKE type_t.num5
#end add-point
       
#模組變數(Module Variables)
DEFINE g_prea_m          type_g_prea_m
DEFINE g_prea_m_t        type_g_prea_m
DEFINE g_prea_m_o        type_g_prea_m
DEFINE g_prea_m_mask_o   type_g_prea_m #轉換遮罩前資料
DEFINE g_prea_m_mask_n   type_g_prea_m #轉換遮罩後資料
 
   DEFINE g_preadocno_t LIKE prea_t.preadocno
 
 
DEFINE g_prec_d          DYNAMIC ARRAY OF type_g_prec_d
DEFINE g_prec_d_t        type_g_prec_d
DEFINE g_prec_d_o        type_g_prec_d
DEFINE g_prec_d_mask_o   DYNAMIC ARRAY OF type_g_prec_d #轉換遮罩前資料
DEFINE g_prec_d_mask_n   DYNAMIC ARRAY OF type_g_prec_d #轉換遮罩後資料
DEFINE g_prec2_d          DYNAMIC ARRAY OF type_g_prec2_d
DEFINE g_prec2_d_t        type_g_prec2_d
DEFINE g_prec2_d_o        type_g_prec2_d
DEFINE g_prec2_d_mask_o   DYNAMIC ARRAY OF type_g_prec2_d #轉換遮罩前資料
DEFINE g_prec2_d_mask_n   DYNAMIC ARRAY OF type_g_prec2_d #轉換遮罩後資料
DEFINE g_prec3_d          DYNAMIC ARRAY OF type_g_prec3_d
DEFINE g_prec3_d_t        type_g_prec3_d
DEFINE g_prec3_d_o        type_g_prec3_d
DEFINE g_prec3_d_mask_o   DYNAMIC ARRAY OF type_g_prec3_d #轉換遮罩前資料
DEFINE g_prec3_d_mask_n   DYNAMIC ARRAY OF type_g_prec3_d #轉換遮罩後資料
DEFINE g_prec4_d          DYNAMIC ARRAY OF type_g_prec4_d
DEFINE g_prec4_d_t        type_g_prec4_d
DEFINE g_prec4_d_o        type_g_prec4_d
DEFINE g_prec4_d_mask_o   DYNAMIC ARRAY OF type_g_prec4_d #轉換遮罩前資料
DEFINE g_prec4_d_mask_n   DYNAMIC ARRAY OF type_g_prec4_d #轉換遮罩後資料
 
 
DEFINE g_browser         DYNAMIC ARRAY OF type_browser
DEFINE g_browser_f       DYNAMIC ARRAY OF type_browser
 
DEFINE g_master_multi_table_t    RECORD
      prealdocno LIKE preal_t.prealdocno,
      preal002 LIKE preal_t.preal002
      END RECORD
 
DEFINE g_wc                  STRING
DEFINE g_wc_t                STRING
DEFINE g_wc2                 STRING                          #單身CONSTRUCT結果
DEFINE g_wc2_table1          STRING
DEFINE g_wc2_table2   STRING
 
DEFINE g_wc2_table3   STRING
 
 
 
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
 
{<section id="aprt310.main" >}
#應用 a26 樣板自動產生(Version:7)
#+ 作業開始(主程式類型)
MAIN
   #add-point:main段define(客製用) name="main.define_customerization"
   
   #end add-point   
   #add-point:main段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="main.define"
   DEFINE l_success     LIKE type_t.num5
   #end add-point   
   
   OPTIONS
   INPUT NO WRAP
   DEFER INTERRUPT
   
   #設定SQL錯誤記錄方式 (模組內定義有效)
   WHENEVER ERROR CALL cl_err_msg_log
       
   #依模組進行系統初始化設定(系統設定)
   CALL cl_ap_init("apr","")
 
   #add-point:作業初始化 name="main.init"
   CALL s_aooi390_cre_tmp_table() RETURNING l_success   #add--2015/07/30 By shiun
   #end add-point
   
   
 
   #LOCK CURSOR (identifier)
   #add-point:SQL_define name="main.define_sql"
   
   #end add-point
   LET g_forupd_sql = " SELECT preasite,'',preadocdt,preadocno,prea000,preaunit,prea001,prea002,'',preaacti, 
       preastus,prea003,'',prea004,prea052,prea005,prea006,'','','',prea051,prea008,'',prea007,'',prea009, 
       '',prea010,'','','',prea013,prea050,prea011,'',prea012,'',prea014,prea015,'','',preaownid,'', 
       preaowndp,'',preacrtid,'',preacrtdp,'',preacrtdt,preamodid,'',preamoddt,preacnfid,'',preacnfdt, 
       preapstid,'',preapstdt", 
                      " FROM prea_t",
                      " WHERE preaent= ? AND preadocno=? FOR UPDATE"
   #add-point:SQL_define name="main.after_define_sql"
   
   #end add-point
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)                #轉換不同資料庫語法
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE aprt310_cl CURSOR FROM g_forupd_sql                 # LOCK CURSOR
 
   LET g_sql = " SELECT DISTINCT t0.preasite,t0.preadocdt,t0.preadocno,t0.prea000,t0.preaunit,t0.prea001, 
       t0.prea002,t0.preaacti,t0.preastus,t0.prea003,t0.prea004,t0.prea052,t0.prea005,t0.prea006,t0.prea051, 
       t0.prea008,t0.prea007,t0.prea009,t0.prea010,t0.prea013,t0.prea050,t0.prea011,t0.prea012,t0.prea014, 
       t0.prea015,t0.preaownid,t0.preaowndp,t0.preacrtid,t0.preacrtdp,t0.preacrtdt,t0.preamodid,t0.preamoddt, 
       t0.preacnfid,t0.preacnfdt,t0.preapstid,t0.preapstdt,t2.prcfl003 ,t3.mmanl003 ,t4.oocql004 ,t5.prcdl003 , 
       t6.oocql004 ,t7.oocql004 ,t8.ooag011 ,t9.ooefl003 ,t10.ooag011 ,t11.ooefl003 ,t12.ooag011 ,t13.ooefl003 , 
       t14.ooag011 ,t15.ooag011 ,t16.ooag011",
               " FROM prea_t t0",
                              " LEFT JOIN prcfl_t t2 ON t2.prcflent="||g_enterprise||" AND t2.prcfl001=t0.prea003 AND t2.prcfl002='"||g_dlang||"' ",
               " LEFT JOIN mmanl_t t3 ON t3.mmanlent="||g_enterprise||" AND t3.mmanl001=t0.prea006 AND t3.mmanl002='"||g_dlang||"' ",
               " LEFT JOIN oocql_t t4 ON t4.oocqlent="||g_enterprise||" AND t4.oocql001='2135' AND t4.oocql002=t0.prea008 AND t4.oocql003='"||g_dlang||"' ",
               " LEFT JOIN prcdl_t t5 ON t5.prcdlent="||g_enterprise||" AND t5.prcdl001=t0.prea007 AND t5.prcdl002='"||g_dlang||"' ",
               " LEFT JOIN oocql_t t6 ON t6.oocqlent="||g_enterprise||" AND t6.oocql001='2100' AND t6.oocql002=t0.prea009 AND t6.oocql003='"||g_dlang||"' ",
               " LEFT JOIN oocql_t t7 ON t7.oocqlent="||g_enterprise||" AND t7.oocql001='2101' AND t7.oocql002=t0.prea010 AND t7.oocql003='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t8 ON t8.ooagent="||g_enterprise||" AND t8.ooag001=t0.prea011  ",
               " LEFT JOIN ooefl_t t9 ON t9.ooeflent="||g_enterprise||" AND t9.ooefl001=t0.prea012 AND t9.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t10 ON t10.ooagent="||g_enterprise||" AND t10.ooag001=t0.preaownid  ",
               " LEFT JOIN ooefl_t t11 ON t11.ooeflent="||g_enterprise||" AND t11.ooefl001=t0.preaowndp AND t11.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t12 ON t12.ooagent="||g_enterprise||" AND t12.ooag001=t0.preacrtid  ",
               " LEFT JOIN ooefl_t t13 ON t13.ooeflent="||g_enterprise||" AND t13.ooefl001=t0.preacrtdp AND t13.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t14 ON t14.ooagent="||g_enterprise||" AND t14.ooag001=t0.preamodid  ",
               " LEFT JOIN ooag_t t15 ON t15.ooagent="||g_enterprise||" AND t15.ooag001=t0.preacnfid  ",
               " LEFT JOIN ooag_t t16 ON t16.ooagent="||g_enterprise||" AND t16.ooag001=t0.preapstid  ",
 
               " WHERE t0.preaent = " ||g_enterprise|| " AND t0.preadocno = ?"
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   #add-point:SQL_define name="main.after_refresh_sql"
   
   #end add-point
   PREPARE aprt310_master_referesh FROM g_sql
 
    
 
   
   IF g_bgjob = "Y" THEN
      #add-point:Service Call name="main.servicecall"
      
      #end add-point
   ELSE
      #畫面開啟 (identifier)
      OPEN WINDOW w_aprt310 WITH FORM cl_ap_formpath("apr",g_code)
   
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
   
      #程式初始化
      CALL aprt310_init()   
 
      #進入選單 Menu (="N")
      CALL aprt310_ui_dialog() 
      
      #add-point:畫面關閉前 name="main.before_close"
      CALL s_aooi500_drop_temp() RETURNING l_success   
#      CALL s_aooi390_drop_tmp_table()   
      #end add-point
 
      #畫面關閉
      CLOSE WINDOW w_aprt310
      
   END IF 
   
   CLOSE aprt310_cl
   
   
 
   #add-point:作業離開前 name="main.exit"
   CALL s_aooi390_drop_tmp_table()   #add--2015/03/20 By shiun
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
END MAIN
 
 
 
 
{</section>}
 
{<section id="aprt310.init" >}
#+ 瀏覽頁簽資料初始化
PRIVATE FUNCTION aprt310_init()
   #add-point:init段define(客製用) name="init.define_customerization"
   
   #end add-point    
   #add-point:init段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="init.define"
   DEFINE l_success     LIKE type_t.num5
   #end add-point   
   
   #add-point:Function前置處理  name="init.pre_function"
   
   #end add-point
   
   LET g_bfill       = "Y"
   LET g_detail_idx  = 1 #第一層單身指標
   LET g_detail_idx2 = 1 #第二層單身指標
   
   #各個page指標
   LET g_detail_idx_list[1] = 1 
   LET g_detail_idx_list[2] = 1
   LET g_detail_idx_list[3] = 1
   LET g_detail_idx_list[4] = 1
 
   LET g_error_show  = 1
   LET l_ac = 1 #單身指標
      CALL cl_set_combo_scc_part('preastus','13','N,Y,A,D,R,W,X')
 
   
   LET gwin_curr = ui.Window.getCurrent()  #取得現行畫面
   LET gfrm_curr = gwin_curr.getForm()     #取出物件化後的畫面物件
   
   #page群組
   LET g_idx_group = om.SaxAttributes.create()
   CALL g_idx_group.addAttribute("'1','2',","1")
   CALL g_idx_group.addAttribute("'3',","1")
   CALL g_idx_group.addAttribute("'4',","1")
   CALL g_idx_group.addAttribute("","1")
 
 
   #add-point:畫面資料初始化 name="init.init"
   CALL cl_set_combo_scc('prea000','32')
   CALL cl_set_combo_scc('prea004','6808')
   CALL cl_set_combo_scc('prea005','6805')
   CALL cl_set_combo_scc('prec060','6801')
   CALL cl_set_combo_scc('prec061','6802')
   CALL cl_set_combo_scc('prec075','6803')
   CALL cl_set_combo_scc('prec081','6809')
   CALL cl_set_combo_scc('pred004','6804')
   CALL cl_set_combo_scc('preb007','6520')
   CALL cl_set_combo_scc('preb008','6810')
   CALL cl_set_combo_scc('preb007_1','6520')
   CALL cl_set_combo_scc('preb008_1','30')
   CALL cl_set_combo_scc('prec098','6860')
   CALL cl_set_combo_scc_part('prea052','6027','1,3')  #160104-00012#2 add

   CALL cl_set_combo_scc('prea051','6866')
   CALL s_aooi500_create_temp() RETURNING l_success
#   CALL aprt310_check_prec003_createtemp() RETURNING l_success
   CALL s_aprt310_create_tmp() RETURNING l_success
   #end add-point
   
   #初始化搜尋條件
   CALL aprt310_default_search()
    
END FUNCTION
 
{</section>}
 
{<section id="aprt310.ui_dialog" >}
#+ 功能選單
PRIVATE FUNCTION aprt310_ui_dialog()
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
            CALL aprt310_insert()
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
         INITIALIZE g_prea_m.* TO NULL
         CALL g_prec_d.clear()
         CALL g_prec2_d.clear()
         CALL g_prec3_d.clear()
         CALL g_prec4_d.clear()
 
         LET g_wc  = ' 1=2'
         LET g_wc2 = ' 1=1'
         LET g_action_choice = ""
         CALL aprt310_init()
      END IF
   
            
      DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
 
    
         DISPLAY ARRAY g_prec_d TO s_detail1.* ATTRIBUTES(COUNT=g_rec_b) #page1  
    
            BEFORE ROW
               #顯示單身筆數
               CALL aprt310_idx_chk()
               #確定當下選擇的筆數
               LET l_ac = DIALOG.getCurrentRow("s_detail1")
               LET g_detail_idx = l_ac
               LET g_detail_idx_list[1] = l_ac
               CALL g_idx_group.addAttribute("'1','2',",l_ac)
               
               #add-point:page1, before row動作 name="ui_dialog.page1.before_row"
               
               #end add-point
               
            BEFORE DISPLAY
               #如果一直都在單身1則控制筆數位置
               IF g_loc = 'm' THEN
                  CALL FGL_SET_ARR_CURR(g_idx_group.getValue("'1','2',"))
               END IF
               LET g_loc = 'm'
               LET l_ac = DIALOG.getCurrentRow("s_detail1")
               LET g_current_page = 1
               #顯示單身筆數
               CALL aprt310_idx_chk()
               #add-point:page1自定義行為 name="ui_dialog.page1.before_display"
               
               #end add-point
               
            #自訂ACTION(detail_show,page_1)
            
               
            #add-point:page1自定義行為 name="ui_dialog.page1.action"
            
            #end add-point
               
         END DISPLAY
        
         #第一階單身段落
         DISPLAY ARRAY g_prec2_d TO s_detail2.* ATTRIBUTES(COUNT=g_rec_b)  
    
            BEFORE ROW
               #顯示單身筆數
               CALL aprt310_idx_chk()
               LET l_ac = DIALOG.getCurrentRow("s_detail2")
               LET g_detail_idx = l_ac
               LET g_detail_idx_list[2] = l_ac
               CALL g_idx_group.addAttribute("'3',",l_ac)
               
               #add-point:page2, before row動作 name="ui_dialog.body2.before_row"
               
               #end add-point
               
            BEFORE DISPLAY
               #如果一直都在單身1則控制筆數位置
               IF g_loc = 'm' THEN
                  CALL FGL_SET_ARR_CURR(g_idx_group.getValue("'3',"))
               END IF
               LET g_loc = 'm'
               LET l_ac = DIALOG.getCurrentRow("s_detail2")
               LET g_current_page = 2
               #顯示單身筆數
               CALL aprt310_idx_chk()
               #add-point:page2自定義行為 name="ui_dialog.body2.before_display"
               
               #end add-point
      
            #自訂ACTION(detail_show,page_2)
            
         
            #add-point:page2自定義行為 name="ui_dialog.body2.action"
            
            #end add-point
         
         END DISPLAY
         #第一階單身段落
         DISPLAY ARRAY g_prec3_d TO s_detail3.* ATTRIBUTES(COUNT=g_rec_b)  
    
            BEFORE ROW
               #顯示單身筆數
               CALL aprt310_idx_chk()
               LET l_ac = DIALOG.getCurrentRow("s_detail3")
               LET g_detail_idx = l_ac
               LET g_detail_idx_list[3] = l_ac
               CALL g_idx_group.addAttribute("'4',",l_ac)
               
               #add-point:page3, before row動作 name="ui_dialog.body3.before_row"
               
               #end add-point
               
            BEFORE DISPLAY
               #如果一直都在單身1則控制筆數位置
               IF g_loc = 'm' THEN
                  CALL FGL_SET_ARR_CURR(g_idx_group.getValue("'4',"))
               END IF
               LET g_loc = 'm'
               LET l_ac = DIALOG.getCurrentRow("s_detail3")
               LET g_current_page = 3
               #顯示單身筆數
               CALL aprt310_idx_chk()
               #add-point:page3自定義行為 name="ui_dialog.body3.before_display"
               
               #end add-point
      
            #自訂ACTION(detail_show,page_3)
            
         
            #add-point:page3自定義行為 name="ui_dialog.body3.action"
            
            #end add-point
         
         END DISPLAY
         #第一階單身段落
         DISPLAY ARRAY g_prec4_d TO s_detail4.* ATTRIBUTES(COUNT=g_rec_b)  
    
            BEFORE ROW
               #顯示單身筆數
               CALL aprt310_idx_chk()
               LET l_ac = DIALOG.getCurrentRow("s_detail4")
               LET g_detail_idx = l_ac
               LET g_detail_idx_list[4] = l_ac
               CALL g_idx_group.addAttribute("",l_ac)
               
               #add-point:page4, before row動作 name="ui_dialog.body4.before_row"
               
               #end add-point
               
            BEFORE DISPLAY
               #如果一直都在單身1則控制筆數位置
               IF g_loc = 'm' THEN
                  CALL FGL_SET_ARR_CURR(g_idx_group.getValue(""))
               END IF
               LET g_loc = 'm'
               LET l_ac = DIALOG.getCurrentRow("s_detail4")
               LET g_current_page = 4
               #顯示單身筆數
               CALL aprt310_idx_chk()
               #add-point:page4自定義行為 name="ui_dialog.body4.before_display"
               
               #end add-point
      
            #自訂ACTION(detail_show,page_4)
            
         
            #add-point:page4自定義行為 name="ui_dialog.body4.action"
            
            #end add-point
         
         END DISPLAY
 
         
 
         
         #add-point:ui_dialog段自定義display array name="ui_dialog.more_displayarray"
         
         #end add-point
         
      
         BEFORE DIALOG
            #先填充browser資料
            CALL aprt310_browser_fill("")
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
               CALL aprt310_fetch('') # reload data
            END IF
            #LET g_detail_idx = 1
            CALL aprt310_ui_detailshow() #Setting the current row 
            
            #筆數顯示
            LET g_current_page = 1
            CALL aprt310_idx_chk()
            CALL cl_ap_performance_cal()
            #add-point:ui_dialog段before_dialog2 name="ui_dialog.before_dialog2"
            
            #end add-point
 
         #add-point:ui_dialog段more_action name="ui_dialog.more_action"
         
         #end add-point
 
         #狀態碼切換
         ON ACTION statechange
            LET g_action_choice = "statechange"
            CALL aprt310_statechange()
            #根據資料狀態切換action狀態
            CALL cl_set_act_visible("statechange,modify,modify_detail,delete,reproduce", TRUE)
            CALL aprt310_set_act_visible()   
            CALL aprt310_set_act_no_visible()
            IF NOT (g_prea_m.preadocno IS NULL
 
              ) THEN
               #組合條件
               LET g_add_browse = " preaent = " ||g_enterprise|| " AND",
                                  " preadocno = '", g_prea_m.preadocno, "' "
 
               #填到對應位置
               CALL aprt310_browser_fill("")
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
               INITIALIZE g_wc2_table2 TO NULL
 
               INITIALIZE g_wc2_table3 TO NULL
 
 
               FOR li_idx = 1 TO la_wc.getLength()
                  CASE
                     WHEN la_wc[li_idx].tableid = "prea_t" 
                        LET g_wc = la_wc[li_idx].wc
                     WHEN la_wc[li_idx].tableid = "prec_t" 
                        LET g_wc2_table1 = la_wc[li_idx].wc
                     WHEN la_wc[li_idx].tableid = "pred_t" 
                        LET g_wc2_table2 = la_wc[li_idx].wc
 
                     WHEN la_wc[li_idx].tableid = "preb_t" 
                        LET g_wc2_table3 = la_wc[li_idx].wc
 
 
                     WHEN la_wc[li_idx].tableid = "EXTENDWC"
                        LET g_wc2_extend = la_wc[li_idx].wc
                  END CASE
               END FOR
               IF NOT cl_null(g_wc) OR NOT cl_null(g_wc2_table1) 
                  OR NOT cl_null(g_wc2_table2)
 
                  OR NOT cl_null(g_wc2_table3)
 
 
                  OR NOT cl_null(g_wc2_extend)
                  THEN
                  #組合g_wc2
                  IF g_wc2_table1 <> " 1=1" AND NOT cl_null(g_wc2_table1) THEN
                     LET g_wc2 = g_wc2_table1
                  END IF
                  IF g_wc2_table2 <> " 1=1" AND NOT cl_null(g_wc2_table2) THEN
                     LET g_wc2 = g_wc2 ," AND ", g_wc2_table2
                  END IF
 
                  IF g_wc2_table3 <> " 1=1" AND NOT cl_null(g_wc2_table3) THEN
                     LET g_wc2 = g_wc2 ," AND ", g_wc2_table3
                  END IF
 
 
                  IF g_wc2_extend <> " 1=1" AND NOT cl_null(g_wc2_extend) THEN
                     LET g_wc2 = g_wc2 ," AND ", g_wc2_extend
                  END IF
 
                  IF g_wc2.subString(1,5) = " AND " THEN
                     LET g_wc2 = g_wc2.subString(6,g_wc2.getLength())
                  END IF
               END IF
               CALL aprt310_browser_fill("F")   #browser_fill()會將notice區塊清空
            END IF
         
         #查詢方案選擇
         ON ACTION qbe_select
            CALL cl_qbe_list("m") RETURNING ls_wc
            IF NOT cl_null(ls_wc) THEN
               CALL util.JSON.parse(ls_wc, la_wc)
               INITIALIZE g_wc, g_wc2,g_wc2_table1,g_wc2_extend TO NULL
               INITIALIZE g_wc2_table2 TO NULL
 
               INITIALIZE g_wc2_table3 TO NULL
 
 
               FOR li_idx = 1 TO la_wc.getLength()
                  CASE
                     WHEN la_wc[li_idx].tableid = "prea_t" 
                        LET g_wc = la_wc[li_idx].wc
                     WHEN la_wc[li_idx].tableid = "prec_t" 
                        LET g_wc2_table1 = la_wc[li_idx].wc
                     WHEN la_wc[li_idx].tableid = "pred_t" 
                        LET g_wc2_table2 = la_wc[li_idx].wc
 
                     WHEN la_wc[li_idx].tableid = "preb_t" 
                        LET g_wc2_table3 = la_wc[li_idx].wc
 
 
                     WHEN la_wc[li_idx].tableid = "EXTENDWC"
                        LET g_wc2_extend = la_wc[li_idx].wc
                  END CASE
               END FOR
               IF NOT cl_null(g_wc) OR NOT cl_null(g_wc2_table1)
                  OR NOT cl_null(g_wc2_table2)
 
                  OR NOT cl_null(g_wc2_table3)
 
 
                  OR NOT cl_null(g_wc2_extend)
                  THEN
                  IF g_wc2_table1 <> " 1=1" AND NOT cl_null(g_wc2_table1) THEN
                     LET g_wc2 = g_wc2_table1
                  END IF
                  IF g_wc2_table2 <> " 1=1" AND NOT cl_null(g_wc2_table2) THEN
                     LET g_wc2 = g_wc2 ," AND ", g_wc2_table2
                  END IF
 
                  IF g_wc2_table3 <> " 1=1" AND NOT cl_null(g_wc2_table3) THEN
                     LET g_wc2 = g_wc2 ," AND ", g_wc2_table3
                  END IF
 
 
                  IF g_wc2_extend <> " 1=1" AND NOT cl_null(g_wc2_extend) THEN
                     LET g_wc2 = g_wc2 ," AND ", g_wc2_extend
                  END IF
                  IF g_wc2.subString(1,5) = " AND " THEN
                     LET g_wc2 = g_wc2.subString(6,g_wc2.getLength())
                  END IF
                  #取得條件後需要重查、跳到結果第一筆資料的功能程式段
                  CALL aprt310_browser_fill("F")
                  IF g_browser_cnt = 0 THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "" 
                     LET g_errparam.code = "-100" 
                     LET g_errparam.popup = TRUE 
                     CALL cl_err()
                     CLEAR FORM
                  ELSE
                     CALL aprt310_fetch("F")
                  END IF
               END IF
            END IF
            #重新搜尋會將notice區塊清空,此處不可用EXIT DIALOG, SUBDIALOG重讀會導致部分變數消失
          
         
         
         ON ACTION first
            LET g_action_choice = "fetch"
            CALL aprt310_fetch('F')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL aprt310_idx_chk()
            
         ON ACTION previous
            LET g_action_choice = "fetch"
            CALL aprt310_fetch('P')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL aprt310_idx_chk()
            
         ON ACTION jump
            LET g_action_choice = "fetch"
            CALL aprt310_fetch('/')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL aprt310_idx_chk()
            
         ON ACTION next
            LET g_action_choice = "fetch"
            CALL aprt310_fetch('N')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL aprt310_idx_chk()
            
         ON ACTION last
            LET g_action_choice = "fetch"
            CALL aprt310_fetch('L')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL aprt310_idx_chk()
          
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
                  LET g_export_node[1] = base.typeInfo.create(g_prec_d)
                  LET g_export_id[1]   = "s_detail1"
                  LET g_export_node[2] = base.typeInfo.create(g_prec2_d)
                  LET g_export_id[2]   = "s_detail2"
                  LET g_export_node[3] = base.typeInfo.create(g_prec3_d)
                  LET g_export_id[3]   = "s_detail3"
                  LET g_export_node[4] = base.typeInfo.create(g_prec4_d)
                  LET g_export_id[4]   = "s_detail4"
 
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
               CALL aprt310_modify()
               #add-point:ON ACTION modify name="menu.modify"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION modify_detail
            LET g_action_choice="modify_detail"
            IF cl_auth_chk_act("modify") THEN
               LET g_aw = g_curr_diag.getCurrentItem()
               CALL aprt310_modify()
               #add-point:ON ACTION modify_detail name="menu.modify_detail"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION delete
            LET g_action_choice="delete"
            IF cl_auth_chk_act("delete") THEN
               CALL aprt310_delete()
               #add-point:ON ACTION delete name="menu.delete"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION insert
            LET g_action_choice="insert"
            IF cl_auth_chk_act("insert") THEN
               CALL aprt310_insert()
               #add-point:ON ACTION insert name="menu.insert"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION output
            LET g_action_choice="output"
            IF cl_auth_chk_act("output") THEN
               
               #add-point:ON ACTION output name="menu.output"
               
               #END add-point
               &include "erp/apr/aprt310_rep.4gl"
               #add-point:ON ACTION output.after name="menu.after_output"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION quickprint
            LET g_action_choice="quickprint"
            IF cl_auth_chk_act("quickprint") THEN
               
               #add-point:ON ACTION quickprint name="menu.quickprint"
               
               #END add-point
               &include "erp/apr/aprt310_rep.4gl"
               #add-point:ON ACTION quickprint.after name="menu.after_quickprint"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION query
            LET g_action_choice="query"
            IF cl_auth_chk_act("query") THEN
               CALL aprt310_query()
               #add-point:ON ACTION query name="menu.query"
               
               #END add-point
               #應用 a59 樣板自動產生(Version:3)  
               CALL g_curr_diag.setCurrentRow("s_detail1",1)
               CALL g_curr_diag.setCurrentRow("s_detail2",1)
               CALL g_curr_diag.setCurrentRow("s_detail3",1)
               CALL g_curr_diag.setCurrentRow("s_detail4",1)
 
 
 
 
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION excel_load
            LET g_action_choice="excel_load"
            IF cl_auth_chk_act("excel_load") THEN
               
               #add-point:ON ACTION excel_load name="menu.excel_load"
               #ETL导入前，删除中间表数据
               CALL s_aprt310_01_into_exceldel()               
              
               #ETL导入               
               LET la_param.prog = 'awsp200'
               LET la_param.param[1] = g_prog
               LET la_param.param[2] = "excel_load"
               LET la_param.param[3] = util.JSON.stringify(g_etlparam)

               LET ls_js = util.JSON.stringify( la_param )
               CALL cl_cmdrun_wait(ls_js)
               
               #从中间表插入到aprt310的表中，并检查
               CALL s_aprt310_01_into_excel()   
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION excel_example
            LET g_action_choice="excel_example"
            IF cl_auth_chk_act("excel_example") THEN
               
               #add-point:ON ACTION excel_example name="menu.excel_example"
               LET la_param.prog = 'awsp200'
               LET la_param.param[1] = g_prog
               LET la_param.param[2] = "excel_example"
               LET ls_js = util.JSON.stringify( la_param )

               CALL cl_cmdrun_wait(ls_js)
               #END add-point
               
            END IF
 
 
 
 
         
         #應用 a46 樣板自動產生(Version:3)
         #新增相關文件
         ON ACTION related_document
            CALL aprt310_set_pk_array()
            IF cl_auth_chk_act("related_document") THEN
               #add-point:ON ACTION related_document name="ui_dialog.dialog.related_document"
               
               #END add-point
               CALL cl_doc()
            END IF
            
         ON ACTION agendum
            CALL aprt310_set_pk_array()
            #add-point:ON ACTION agendum name="ui_dialog.dialog.agendum"
            
            #END add-point
            CALL cl_user_overview()
            CALL cl_user_overview_set_follow_pic()
         
         ON ACTION followup
            CALL aprt310_set_pk_array()
            #add-point:ON ACTION followup name="ui_dialog.dialog.followup"
            
            #END add-point
            CALL cl_user_overview_follow(g_prea_m.preadocdt)
 
 
 
         
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
 
{<section id="aprt310.browser_fill" >}
#+ 瀏覽頁簽資料填充
PRIVATE FUNCTION aprt310_browser_fill(ps_page_action)
   #add-point:browser_fill段define(客製用) name="browser_fill.define_customerization"
   
   #end add-point  
   DEFINE ps_page_action    STRING
   DEFINE l_wc              STRING
   DEFINE l_wc2             STRING
   DEFINE l_sql             STRING
   DEFINE l_sub_sql         STRING
   DEFINE l_sql_rank        STRING
   #add-point:browser_fill段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="browser_fill.define"
   DEFINE l_where           STRING
   #end add-point    
   
   #add-point:Function前置處理 name="browser_fill.before_browser_fill"
   CALL s_aooi500_sql_where(g_prog,'preasite') RETURNING l_where
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
   
   #end add-point
   
   IF g_wc2 <> " 1=1" THEN
      #單身有輸入搜尋條件                      
      LET l_sub_sql = " SELECT DISTINCT preadocno ",
                      " FROM prea_t ",
                      " ",
                      " LEFT JOIN prec_t ON precent = preaent AND preadocno = precdocno ", "  ",
                      #add-point:browser_fill段sql(prec_t1) name="browser_fill.cnt.join.}"
                      
                      #end add-point
                      " LEFT JOIN pred_t ON predent = preaent AND preadocno = preddocno", "  ",
                      #add-point:browser_fill段sql(pred_t1) name="browser_fill.cnt.join.pred_t1"
                      
                      #end add-point
 
                      " LEFT JOIN preb_t ON prebent = preaent AND preadocno = prebdocno", "  ",
                      #add-point:browser_fill段sql(preb_t1) name="browser_fill.cnt.join.preb_t1"
                      
                      #end add-point
 
 
 
                      " LEFT JOIN preal_t ON prealent = "||g_enterprise||" AND preadocno = prealdocno AND preal001 = '",g_dlang,"' ", 
                      " ", 
                      " ",                      
 
                      " ",                      
 
 
 
                      " WHERE preaent = " ||g_enterprise|| " AND precent = " ||g_enterprise|| " AND ",l_wc, " AND ", l_wc2, cl_sql_add_filter("prea_t")
   ELSE
      #單身未輸入搜尋條件
      LET l_sub_sql = " SELECT DISTINCT preadocno ",
                      " FROM prea_t ", 
                      "  ",
                      "  LEFT JOIN preal_t ON prealent = "||g_enterprise||" AND preadocno = prealdocno AND preal001 = '",g_dlang,"' ",
                      " WHERE preaent = " ||g_enterprise|| " AND ",l_wc CLIPPED, cl_sql_add_filter("prea_t")
   END IF
   
   #add-point:browser_fill,cnt wc name="browser_fill.cnt_sqlwc"
   LET l_sub_sql = l_sub_sql," AND ", l_where
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
      INITIALIZE g_prea_m.* TO NULL
      CALL g_prec_d.clear()        
      CALL g_prec2_d.clear() 
      CALL g_prec3_d.clear() 
      CALL g_prec4_d.clear() 
 
      #add-point:browser_fill g_add_browse段額外處理 name="browser_fill.add_browse.other"
      
      #end add-point   
      CALL g_browser.clear()
      LET g_cnt = 1
   ELSE
      LET l_wc  = g_add_browse
      LET l_wc2 = " 1=1" 
      LET g_cnt = g_current_idx
   END IF
 
   #依照t0.preadocno Browser欄位定義(取代原本bs_sql功能)
   #考量到單身可能下條件, 所以此處需join單身所有table
   #DISTINCT是為了避免在join時出現重複的資料(如果不加DISTINCT則須在程式中過濾)
   IF g_wc2 <> " 1=1" THEN
      #單身有輸入搜尋條件   
      LET g_sql = " SELECT DISTINCT t0.preastus,t0.preadocno ",
                  " FROM prea_t t0",
                  "  ",
                  "  LEFT JOIN prec_t ON precent = preaent AND preadocno = precdocno ", "  ", 
                  #add-point:browser_fill段sql(prec_t1) name="browser_fill.join.prec_t1"
                  
                  #end add-point
                  "  LEFT JOIN pred_t ON predent = preaent AND preadocno = preddocno", "  ", 
                  #add-point:browser_fill段sql(pred_t1) name="browser_fill.join.pred_t1"
                  
                  #end add-point
 
                  "  LEFT JOIN preb_t ON prebent = preaent AND preadocno = prebdocno", "  ", 
                  #add-point:browser_fill段sql(preb_t1) name="browser_fill.join.preb_t1"
                  
                  #end add-point
 
 
 
                  " ", 
                  " ",                      
 
                  " ",                      
 
 
 
                  
               " LEFT JOIN preal_t ON prealent = "||g_enterprise||" AND preadocno = prealdocno AND preal001 = '",g_dlang,"' ",
                  " WHERE t0.preaent = " ||g_enterprise|| " AND ",l_wc," AND ",l_wc2, cl_sql_add_filter("prea_t")
   ELSE
      #單身無輸入搜尋條件   
      LET g_sql = " SELECT DISTINCT t0.preastus,t0.preadocno ",
                  " FROM prea_t t0",
                  "  ",
                  
               " LEFT JOIN preal_t ON prealent = "||g_enterprise||" AND preadocno = prealdocno AND preal001 = '",g_dlang,"' ",
                  " WHERE t0.preaent = " ||g_enterprise|| " AND ",l_wc, cl_sql_add_filter("prea_t")
   END IF
   #add-point:browser_fill,sql wc name="browser_fill.fill_sqlwc"
   LET g_sql = g_sql," AND ", l_where
   #end add-point
   LET g_sql = g_sql, " ORDER BY preadocno ",g_order
 
   #add-point:browser_fill,before_prepare name="browser_fill.before_prepare"
   
   #end add-point
        
   #LET g_sql = cl_sql_add_tabid(g_sql,"prea_t") #WC重組
   LET g_sql = cl_sql_add_mask(g_sql) #遮蔽特定資料
   
   IF g_sql.getIndexOf(" 1=2",1) THEN
      DISPLAY "INFO: 1=2 jumped!"
   ELSE
      PREPARE browse_pre FROM g_sql
      DECLARE browse_cur CURSOR FOR browse_pre
      
      #add-point:browser_fill段open cursor name="browser_fill.open"
      
      #end add-point
      
      FOREACH browse_cur INTO g_browser[g_cnt].b_statepic,g_browser[g_cnt].b_preadocno
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
         WHEN "N"
            LET g_browser[g_cnt].b_statepic = "stus/16/unconfirmed.png"
         WHEN "Y"
            LET g_browser[g_cnt].b_statepic = "stus/16/confirmed.png"
         WHEN "A"
            LET g_browser[g_cnt].b_statepic = "stus/16/approved.png"
         WHEN "D"
            LET g_browser[g_cnt].b_statepic = "stus/16/withdraw.png"
         WHEN "R"
            LET g_browser[g_cnt].b_statepic = "stus/16/rejection.png"
         WHEN "W"
            LET g_browser[g_cnt].b_statepic = "stus/16/signing.png"
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
   
   IF cl_null(g_browser[g_cnt].b_preadocno) THEN
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
 
{<section id="aprt310.ui_headershow" >}
#+ 單頭資料重新顯示
PRIVATE FUNCTION aprt310_ui_headershow()
   #add-point:ui_headershow段define(客製用) name="ui_headershow.define_customerization"
   
   #end add-point  
   #add-point:ui_headershow段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="ui_headershow.define"
   
   #end add-point      
   
   #add-point:Function前置處理  name="ui_headershow.pre_function"
   
   #end add-point
   
   LET g_prea_m.preadocno = g_browser[g_current_idx].b_preadocno   
 
   EXECUTE aprt310_master_referesh USING g_prea_m.preadocno INTO g_prea_m.preasite,g_prea_m.preadocdt, 
       g_prea_m.preadocno,g_prea_m.prea000,g_prea_m.preaunit,g_prea_m.prea001,g_prea_m.prea002,g_prea_m.preaacti, 
       g_prea_m.preastus,g_prea_m.prea003,g_prea_m.prea004,g_prea_m.prea052,g_prea_m.prea005,g_prea_m.prea006, 
       g_prea_m.prea051,g_prea_m.prea008,g_prea_m.prea007,g_prea_m.prea009,g_prea_m.prea010,g_prea_m.prea013, 
       g_prea_m.prea050,g_prea_m.prea011,g_prea_m.prea012,g_prea_m.prea014,g_prea_m.prea015,g_prea_m.preaownid, 
       g_prea_m.preaowndp,g_prea_m.preacrtid,g_prea_m.preacrtdp,g_prea_m.preacrtdt,g_prea_m.preamodid, 
       g_prea_m.preamoddt,g_prea_m.preacnfid,g_prea_m.preacnfdt,g_prea_m.preapstid,g_prea_m.preapstdt, 
       g_prea_m.prea003_desc,g_prea_m.prea006_desc,g_prea_m.prea008_desc,g_prea_m.prea007_desc,g_prea_m.prea009_desc, 
       g_prea_m.prea010_desc,g_prea_m.prea011_desc,g_prea_m.prea012_desc,g_prea_m.preaownid_desc,g_prea_m.preaowndp_desc, 
       g_prea_m.preacrtid_desc,g_prea_m.preacrtdp_desc,g_prea_m.preamodid_desc,g_prea_m.preacnfid_desc, 
       g_prea_m.preapstid_desc
   
   CALL aprt310_prea_t_mask()
   CALL aprt310_show()
      
END FUNCTION
 
{</section>}
 
{<section id="aprt310.ui_detailshow" >}
#+ 單身資料重新顯示
PRIVATE FUNCTION aprt310_ui_detailshow()
   #add-point:ui_detailshow段define(客製用) name="ui_detailshow.define_customerization"
   
   #end add-point    
   #add-point:ui_detailshow段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="ui_detailshow.define"
   
   #end add-point    
 
   #add-point:Function前置處理 name="ui_detailshow.before"
   
   #end add-point    
   
   IF g_curr_diag IS NOT NULL THEN
      CALL g_curr_diag.setCurrentRow("s_detail1",g_detail_idx)      
      CALL g_curr_diag.setCurrentRow("s_detail2",g_detail_idx)
      CALL g_curr_diag.setCurrentRow("s_detail3",g_detail_idx)
      CALL g_curr_diag.setCurrentRow("s_detail4",g_detail_idx)
 
   END IF
   
   #add-point:ui_detailshow段after name="ui_detailshow.after"
   
   #end add-point    
   
END FUNCTION
 
{</section>}
 
{<section id="aprt310.ui_browser_refresh" >}
#+ 瀏覽頁簽資料重新顯示
PRIVATE FUNCTION aprt310_ui_browser_refresh()
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
      IF g_browser[l_i].b_preadocno = g_prea_m.preadocno 
 
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
 
{<section id="aprt310.construct" >}
#+ QBE資料查詢
PRIVATE FUNCTION aprt310_construct()
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
   
   #end add-point    
   
   #add-point:Function前置處理  name="cs.pre_function"
   
   #end add-point
    
   #清除畫面
   CLEAR FORM                
   INITIALIZE g_prea_m.* TO NULL
   CALL g_prec_d.clear()        
   CALL g_prec2_d.clear() 
   CALL g_prec3_d.clear() 
   CALL g_prec4_d.clear() 
 
   
   LET g_action_choice = ""
    
   INITIALIZE g_wc TO NULL
   INITIALIZE g_wc2 TO NULL
   
   INITIALIZE g_wc2_table1 TO NULL
   INITIALIZE g_wc2_table2 TO NULL
 
   INITIALIZE g_wc2_table3 TO NULL
 
 
    
   LET g_qryparam.state = 'c'
   
   #add-point:cs段開始前 name="cs.before_construct"
   
   #end add-point 
   
   #使用DIALOG包住 單頭CONSTRUCT及單身CONSTRUCT
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
      
      #單頭
      CONSTRUCT BY NAME g_wc ON preasite,preadocdt,preadocno,prea000,preaunit,prea001,prea002,preal002, 
          preaacti,preastus,prea003,prea004,prea052,prea005,prea006,prea051,prea008,prea007,prea009, 
          prea010,prea013,prea050,prea011,prea012,prea014,prea015,preaownid,preaowndp,preacrtid,preacrtdp, 
          preacrtdt,preamodid,preamoddt,preacnfid,preacnfdt,preapstid,preapstdt
 
         BEFORE CONSTRUCT
            #add-point:cs段before_construct name="cs.head.before_construct"
            
            #end add-point 
            
         #公用欄位開窗相關處理
         #應用 a11 樣板自動產生(Version:3)
         #共用欄位查詢處理  
         ##----<<preacrtdt>>----
         AFTER FIELD preacrtdt
            CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
            IF NOT cl_null(ls_result) THEN
               IF NOT cl_chk_date_symbol(ls_result) THEN
                  LET ls_result = cl_add_date_extra_cond(ls_result)
               END IF
            END IF
            CALL FGL_DIALOG_SETBUFFER(ls_result)
 
         #----<<preamoddt>>----
         AFTER FIELD preamoddt
            CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
            IF NOT cl_null(ls_result) THEN
               IF NOT cl_chk_date_symbol(ls_result) THEN
                  LET ls_result = cl_add_date_extra_cond(ls_result)
               END IF
            END IF
            CALL FGL_DIALOG_SETBUFFER(ls_result)
         
         #----<<preacnfdt>>----
         AFTER FIELD preacnfdt
            CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
            IF NOT cl_null(ls_result) THEN
               IF NOT cl_chk_date_symbol(ls_result) THEN
                  LET ls_result = cl_add_date_extra_cond(ls_result)
               END IF
            END IF
            CALL FGL_DIALOG_SETBUFFER(ls_result)
         
         #----<<preapstdt>>----
         AFTER FIELD preapstdt
            CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
            IF NOT cl_null(ls_result) THEN
               IF NOT cl_chk_date_symbol(ls_result) THEN
                  LET ls_result = cl_add_date_extra_cond(ls_result)
               END IF
            END IF
            CALL FGL_DIALOG_SETBUFFER(ls_result)
 
 
 
            
         #一般欄位開窗相關處理    
                  #Ctrlp:construct.c.preasite
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD preasite
            #add-point:ON ACTION controlp INFIELD preasite name="construct.c.preasite"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.where = s_aooi500_q_where(g_prog,'preasite',g_site,'c')
            #CALL q_ooef001()                           #呼叫開窗   #161101-00022#1--mark
            CALL q_ooef001_24()                         #呼叫開窗   #161101-00022#1--add
            DISPLAY g_qryparam.return1 TO preasite  #顯示到畫面上
            NEXT FIELD preasite                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD preasite
            #add-point:BEFORE FIELD preasite name="construct.b.preasite"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD preasite
            
            #add-point:AFTER FIELD preasite name="construct.a.preasite"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD preadocdt
            #add-point:BEFORE FIELD preadocdt name="construct.b.preadocdt"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD preadocdt
            
            #add-point:AFTER FIELD preadocdt name="construct.a.preadocdt"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.preadocdt
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD preadocdt
            #add-point:ON ACTION controlp INFIELD preadocdt name="construct.c.preadocdt"
            
            #END add-point
 
 
         #Ctrlp:construct.c.preadocno
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD preadocno
            #add-point:ON ACTION controlp INFIELD preadocno name="construct.c.preadocno"
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_preadocno()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO preadocno  #顯示到畫面上
            NEXT FIELD preadocno                    #返回原欄位
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD preadocno
            #add-point:BEFORE FIELD preadocno name="construct.b.preadocno"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD preadocno
            
            #add-point:AFTER FIELD preadocno name="construct.a.preadocno"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prea000
            #add-point:BEFORE FIELD prea000 name="construct.b.prea000"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prea000
            
            #add-point:AFTER FIELD prea000 name="construct.a.prea000"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.prea000
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prea000
            #add-point:ON ACTION controlp INFIELD prea000 name="construct.c.prea000"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD preaunit
            #add-point:BEFORE FIELD preaunit name="construct.b.preaunit"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD preaunit
            
            #add-point:AFTER FIELD preaunit name="construct.a.preaunit"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.preaunit
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD preaunit
            #add-point:ON ACTION controlp INFIELD preaunit name="construct.c.preaunit"
            
            #END add-point
 
 
         #Ctrlp:construct.c.prea001
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prea001
            #add-point:ON ACTION controlp INFIELD prea001 name="construct.c.prea001"
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_prea001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO prea001  #顯示到畫面上
            NEXT FIELD prea001                     #返回原欄位
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prea001
            #add-point:BEFORE FIELD prea001 name="construct.b.prea001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prea001
            
            #add-point:AFTER FIELD prea001 name="construct.a.prea001"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prea002
            #add-point:BEFORE FIELD prea002 name="construct.b.prea002"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prea002
            
            #add-point:AFTER FIELD prea002 name="construct.a.prea002"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.prea002
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prea002
            #add-point:ON ACTION controlp INFIELD prea002 name="construct.c.prea002"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD preal002
            #add-point:BEFORE FIELD preal002 name="construct.b.preal002"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD preal002
            
            #add-point:AFTER FIELD preal002 name="construct.a.preal002"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.preal002
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD preal002
            #add-point:ON ACTION controlp INFIELD preal002 name="construct.c.preal002"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD preaacti
            #add-point:BEFORE FIELD preaacti name="construct.b.preaacti"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD preaacti
            
            #add-point:AFTER FIELD preaacti name="construct.a.preaacti"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.preaacti
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD preaacti
            #add-point:ON ACTION controlp INFIELD preaacti name="construct.c.preaacti"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD preastus
            #add-point:BEFORE FIELD preastus name="construct.b.preastus"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD preastus
            
            #add-point:AFTER FIELD preastus name="construct.a.preastus"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.preastus
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD preastus
            #add-point:ON ACTION controlp INFIELD preastus name="construct.c.preastus"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prea003
            #add-point:BEFORE FIELD prea003 name="construct.b.prea003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prea003
            
            #add-point:AFTER FIELD prea003 name="construct.a.prea003"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.prea003
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prea003
            #add-point:ON ACTION controlp INFIELD prea003 name="construct.c.prea003"
			  INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			   LET g_qryparam.reqry = FALSE
			   LET g_qryparam.arg1 = '3'
            CALL q_prcf001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO prea003  #顯示到畫面上

            NEXT FIELD prea003                     #返回原欄位
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prea004
            #add-point:BEFORE FIELD prea004 name="construct.b.prea004"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prea004
            
            #add-point:AFTER FIELD prea004 name="construct.a.prea004"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.prea004
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prea004
            #add-point:ON ACTION controlp INFIELD prea004 name="construct.c.prea004"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prea052
            #add-point:BEFORE FIELD prea052 name="construct.b.prea052"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prea052
            
            #add-point:AFTER FIELD prea052 name="construct.a.prea052"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.prea052
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prea052
            #add-point:ON ACTION controlp INFIELD prea052 name="construct.c.prea052"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prea005
            #add-point:BEFORE FIELD prea005 name="construct.b.prea005"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prea005
            
            #add-point:AFTER FIELD prea005 name="construct.a.prea005"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.prea005
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prea005
            #add-point:ON ACTION controlp INFIELD prea005 name="construct.c.prea005"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prea006
            #add-point:BEFORE FIELD prea006 name="construct.b.prea006"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prea006
            
            #add-point:AFTER FIELD prea006 name="construct.a.prea006"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.prea006
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prea006
            #add-point:ON ACTION controlp INFIELD prea006 name="construct.c.prea006"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prea051
            #add-point:BEFORE FIELD prea051 name="construct.b.prea051"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prea051
            
            #add-point:AFTER FIELD prea051 name="construct.a.prea051"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.prea051
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prea051
            #add-point:ON ACTION controlp INFIELD prea051 name="construct.c.prea051"
            
            #END add-point
 
 
         #Ctrlp:construct.c.prea008
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prea008
            #add-point:ON ACTION controlp INFIELD prea008 name="construct.c.prea008"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.arg1 = '2135'
            CALL q_oocq002()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO prea008  #顯示到畫面上
            NEXT FIELD prea008                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prea008
            #add-point:BEFORE FIELD prea008 name="construct.b.prea008"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prea008
            
            #add-point:AFTER FIELD prea008 name="construct.a.prea008"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.prea007
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prea007
            #add-point:ON ACTION controlp INFIELD prea007 name="construct.c.prea007"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.arg1 = '1'
            CALL q_prcd001_1()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO prea007  #顯示到畫面上
            NEXT FIELD prea007                     #返回原欄位
   

            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prea007
            #add-point:BEFORE FIELD prea007 name="construct.b.prea007"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prea007
            
            #add-point:AFTER FIELD prea007 name="construct.a.prea007"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.prea009
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prea009
            #add-point:ON ACTION controlp INFIELD prea009 name="construct.c.prea009"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.arg1 ='2100'
            CALL q_oocq002()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO prea009  #顯示到畫面上
            NEXT FIELD prea009                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prea009
            #add-point:BEFORE FIELD prea009 name="construct.b.prea009"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prea009
            
            #add-point:AFTER FIELD prea009 name="construct.a.prea009"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.prea010
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prea010
            #add-point:ON ACTION controlp INFIELD prea010 name="construct.c.prea010"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.arg1 ='2100'
            CALL q_oocq002()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO prea010  #顯示到畫面上
            NEXT FIELD prea010                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prea010
            #add-point:BEFORE FIELD prea010 name="construct.b.prea010"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prea010
            
            #add-point:AFTER FIELD prea010 name="construct.a.prea010"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prea013
            #add-point:BEFORE FIELD prea013 name="construct.b.prea013"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prea013
            
            #add-point:AFTER FIELD prea013 name="construct.a.prea013"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.prea013
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prea013
            #add-point:ON ACTION controlp INFIELD prea013 name="construct.c.prea013"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prea050
            #add-point:BEFORE FIELD prea050 name="construct.b.prea050"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prea050
            
            #add-point:AFTER FIELD prea050 name="construct.a.prea050"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.prea050
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prea050
            #add-point:ON ACTION controlp INFIELD prea050 name="construct.c.prea050"
            
            #END add-point
 
 
         #Ctrlp:construct.c.prea011
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prea011
            #add-point:ON ACTION controlp INFIELD prea011 name="construct.c.prea011"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO prea011  #顯示到畫面上
            NEXT FIELD prea011                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prea011
            #add-point:BEFORE FIELD prea011 name="construct.b.prea011"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prea011
            
            #add-point:AFTER FIELD prea011 name="construct.a.prea011"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.prea012
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prea012
            #add-point:ON ACTION controlp INFIELD prea012 name="construct.c.prea012"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooeg001_9()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO prea012  #顯示到畫面上
            NEXT FIELD prea012                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prea012
            #add-point:BEFORE FIELD prea012 name="construct.b.prea012"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prea012
            
            #add-point:AFTER FIELD prea012 name="construct.a.prea012"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prea014
            #add-point:BEFORE FIELD prea014 name="construct.b.prea014"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prea014
            
            #add-point:AFTER FIELD prea014 name="construct.a.prea014"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.prea014
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prea014
            #add-point:ON ACTION controlp INFIELD prea014 name="construct.c.prea014"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prea015
            #add-point:BEFORE FIELD prea015 name="construct.b.prea015"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prea015
            
            #add-point:AFTER FIELD prea015 name="construct.a.prea015"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.prea015
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prea015
            #add-point:ON ACTION controlp INFIELD prea015 name="construct.c.prea015"
            
            #END add-point
 
 
         #Ctrlp:construct.c.preaownid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD preaownid
            #add-point:ON ACTION controlp INFIELD preaownid name="construct.c.preaownid"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO preaownid  #顯示到畫面上
            NEXT FIELD preaownid                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD preaownid
            #add-point:BEFORE FIELD preaownid name="construct.b.preaownid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD preaownid
            
            #add-point:AFTER FIELD preaownid name="construct.a.preaownid"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.preaowndp
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD preaowndp
            #add-point:ON ACTION controlp INFIELD preaowndp name="construct.c.preaowndp"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooeg001_9()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO preaowndp  #顯示到畫面上
            NEXT FIELD preaowndp                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD preaowndp
            #add-point:BEFORE FIELD preaowndp name="construct.b.preaowndp"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD preaowndp
            
            #add-point:AFTER FIELD preaowndp name="construct.a.preaowndp"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.preacrtid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD preacrtid
            #add-point:ON ACTION controlp INFIELD preacrtid name="construct.c.preacrtid"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO preacrtid  #顯示到畫面上
            NEXT FIELD preacrtid                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD preacrtid
            #add-point:BEFORE FIELD preacrtid name="construct.b.preacrtid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD preacrtid
            
            #add-point:AFTER FIELD preacrtid name="construct.a.preacrtid"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.preacrtdp
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD preacrtdp
            #add-point:ON ACTION controlp INFIELD preacrtdp name="construct.c.preacrtdp"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooeg001_9()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO preacrtdp  #顯示到畫面上
            NEXT FIELD preacrtdp                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD preacrtdp
            #add-point:BEFORE FIELD preacrtdp name="construct.b.preacrtdp"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD preacrtdp
            
            #add-point:AFTER FIELD preacrtdp name="construct.a.preacrtdp"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD preacrtdt
            #add-point:BEFORE FIELD preacrtdt name="construct.b.preacrtdt"
            
            #END add-point
 
 
         #Ctrlp:construct.c.preamodid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD preamodid
            #add-point:ON ACTION controlp INFIELD preamodid name="construct.c.preamodid"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO preamodid  #顯示到畫面上
            NEXT FIELD preamodid                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD preamodid
            #add-point:BEFORE FIELD preamodid name="construct.b.preamodid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD preamodid
            
            #add-point:AFTER FIELD preamodid name="construct.a.preamodid"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD preamoddt
            #add-point:BEFORE FIELD preamoddt name="construct.b.preamoddt"
            
            #END add-point
 
 
         #Ctrlp:construct.c.preacnfid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD preacnfid
            #add-point:ON ACTION controlp INFIELD preacnfid name="construct.c.preacnfid"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO preacnfid  #顯示到畫面上
            NEXT FIELD preacnfid                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD preacnfid
            #add-point:BEFORE FIELD preacnfid name="construct.b.preacnfid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD preacnfid
            
            #add-point:AFTER FIELD preacnfid name="construct.a.preacnfid"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD preacnfdt
            #add-point:BEFORE FIELD preacnfdt name="construct.b.preacnfdt"
            
            #END add-point
 
 
         #Ctrlp:construct.c.preapstid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD preapstid
            #add-point:ON ACTION controlp INFIELD preapstid name="construct.c.preapstid"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO preapstid  #顯示到畫面上
            NEXT FIELD preapstid                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD preapstid
            #add-point:BEFORE FIELD preapstid name="construct.b.preapstid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD preapstid
            
            #add-point:AFTER FIELD preapstid name="construct.a.preapstid"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD preapstdt
            #add-point:BEFORE FIELD preapstdt name="construct.b.preapstdt"
            
            #END add-point
 
 
 
         
      END CONSTRUCT
 
      #單身根據table分拆construct
      CONSTRUCT g_wc2_table1 ON precacti,precseq,prec003,prec004,prec005,prec006,prec007,prec008,prec009, 
          prec010,prec011,prec012,prec013,prec014,prec015,prec016,prec017,prec018,prec019,prec020,prec021, 
          prec022,prec023,prec024,prec025,prec026,prec027,prec028,prec029,prec030,prec031,prec032,prec033, 
          prec034,prec035,prec036,prec037,prec038,prec039,prec040,prec041,prec042,prec043,prec044,prec045, 
          prec098,prec046,prec047,prec048,prec049,prec050,prec051,prec052,prec053,prec054,prec055,prec056, 
          prec057,prec058,prec059,prec060,prec061,prec062,prec063,prec064,prec065,prec066,prec067,prec068, 
          prec069,prec070,prec071,prec072,prec073,prec074,prec075,prec078,prec079,prec081,prec001,prec080, 
          prec082,prec083,prec084,prec085,prec086,prec087,prec088,prec089,prec090,prec091,prec092,prec093, 
          prec094,prec095,prec096,prec097,precunit,precsite
           FROM s_detail1[1].precacti,s_detail1[1].precseq,s_detail1[1].prec003,s_detail1[1].prec004, 
               s_detail1[1].prec005,s_detail1[1].prec006,s_detail1[1].prec007,s_detail1[1].prec008,s_detail1[1].prec009, 
               s_detail1[1].prec010,s_detail1[1].prec011,s_detail1[1].prec012,s_detail1[1].prec013,s_detail1[1].prec014, 
               s_detail1[1].prec015,s_detail1[1].prec016,s_detail1[1].prec017,s_detail1[1].prec018,s_detail1[1].prec019, 
               s_detail1[1].prec020,s_detail1[1].prec021,s_detail1[1].prec022,s_detail1[1].prec023,s_detail1[1].prec024, 
               s_detail1[1].prec025,s_detail1[1].prec026,s_detail1[1].prec027,s_detail1[1].prec028,s_detail1[1].prec029, 
               s_detail1[1].prec030,s_detail1[1].prec031,s_detail1[1].prec032,s_detail1[1].prec033,s_detail1[1].prec034, 
               s_detail1[1].prec035,s_detail1[1].prec036,s_detail1[1].prec037,s_detail1[1].prec038,s_detail1[1].prec039, 
               s_detail1[1].prec040,s_detail1[1].prec041,s_detail1[1].prec042,s_detail1[1].prec043,s_detail1[1].prec044, 
               s_detail1[1].prec045,s_detail1[1].prec098,s_detail1[1].prec046,s_detail1[1].prec047,s_detail1[1].prec048, 
               s_detail1[1].prec049,s_detail1[1].prec050,s_detail1[1].prec051,s_detail1[1].prec052,s_detail1[1].prec053, 
               s_detail1[1].prec054,s_detail1[1].prec055,s_detail1[1].prec056,s_detail1[1].prec057,s_detail1[1].prec058, 
               s_detail1[1].prec059,s_detail1[1].prec060,s_detail1[1].prec061,s_detail1[1].prec062,s_detail1[1].prec063, 
               s_detail1[1].prec064,s_detail1[1].prec065,s_detail1[1].prec066,s_detail1[1].prec067,s_detail1[1].prec068, 
               s_detail1[1].prec069,s_detail1[1].prec070,s_detail1[1].prec071,s_detail1[1].prec072,s_detail1[1].prec073, 
               s_detail1[1].prec074,s_detail1[1].prec075,s_detail1[1].prec078,s_detail1[1].prec079,s_detail1[1].prec081, 
               s_detail1[1].prec001,s_detail2[1].prec080,s_detail2[1].prec082,s_detail2[1].prec083,s_detail2[1].prec084, 
               s_detail2[1].prec085,s_detail2[1].prec086,s_detail2[1].prec087,s_detail2[1].prec088,s_detail2[1].prec089, 
               s_detail2[1].prec090,s_detail2[1].prec091,s_detail2[1].prec092,s_detail2[1].prec093,s_detail2[1].prec094, 
               s_detail2[1].prec095,s_detail2[1].prec096,s_detail2[1].prec097,s_detail2[1].precunit, 
               s_detail2[1].precsite
                      
         BEFORE CONSTRUCT
            #add-point:cs段before_construct name="cs.body.before_construct"
            
            #end add-point 
            
       #單身公用欄位開窗相關處理
       
         
       #單身一般欄位開窗相關處理
                #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD precacti
            #add-point:BEFORE FIELD precacti name="construct.b.page1.precacti"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD precacti
            
            #add-point:AFTER FIELD precacti name="construct.a.page1.precacti"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.precacti
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD precacti
            #add-point:ON ACTION controlp INFIELD precacti name="construct.c.page1.precacti"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD precseq
            #add-point:BEFORE FIELD precseq name="construct.b.page1.precseq"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD precseq
            
            #add-point:AFTER FIELD precseq name="construct.a.page1.precseq"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.precseq
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD precseq
            #add-point:ON ACTION controlp INFIELD precseq name="construct.c.page1.precseq"
            
            #END add-point
 
 
         #Ctrlp:construct.c.page1.prec003
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prec003
            #add-point:ON ACTION controlp INFIELD prec003 name="construct.c.page1.prec003"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_inaa001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO prec003  #顯示到畫面上
            NEXT FIELD prec003                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prec003
            #add-point:BEFORE FIELD prec003 name="construct.b.page1.prec003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prec003
            
            #add-point:AFTER FIELD prec003 name="construct.a.page1.prec003"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.prec004
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prec004
            #add-point:ON ACTION controlp INFIELD prec004 name="construct.c.page1.prec004"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_mhae001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO prec004  #顯示到畫面上
            NEXT FIELD prec004                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prec004
            #add-point:BEFORE FIELD prec004 name="construct.b.page1.prec004"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prec004
            
            #add-point:AFTER FIELD prec004 name="construct.a.page1.prec004"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.prec005
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prec005
            #add-point:ON ACTION controlp INFIELD prec005 name="construct.c.page1.prec005"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooeg001_9()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO prec005  #顯示到畫面上
            NEXT FIELD prec005                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prec005
            #add-point:BEFORE FIELD prec005 name="construct.b.page1.prec005"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prec005
            
            #add-point:AFTER FIELD prec005 name="construct.a.page1.prec005"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.prec006
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prec006
            #add-point:ON ACTION controlp INFIELD prec006 name="construct.c.page1.prec006"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_rtax001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO prec006  #顯示到畫面上
            NEXT FIELD prec006                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prec006
            #add-point:BEFORE FIELD prec006 name="construct.b.page1.prec006"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prec006
            
            #add-point:AFTER FIELD prec006 name="construct.a.page1.prec006"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prec007
            #add-point:BEFORE FIELD prec007 name="construct.b.page1.prec007"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prec007
            
            #add-point:AFTER FIELD prec007 name="construct.a.page1.prec007"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.prec007
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prec007
            #add-point:ON ACTION controlp INFIELD prec007 name="construct.c.page1.prec007"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prec008
            #add-point:BEFORE FIELD prec008 name="construct.b.page1.prec008"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prec008
            
            #add-point:AFTER FIELD prec008 name="construct.a.page1.prec008"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.prec008
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prec008
            #add-point:ON ACTION controlp INFIELD prec008 name="construct.c.page1.prec008"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prec009
            #add-point:BEFORE FIELD prec009 name="construct.b.page1.prec009"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prec009
            
            #add-point:AFTER FIELD prec009 name="construct.a.page1.prec009"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.prec009
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prec009
            #add-point:ON ACTION controlp INFIELD prec009 name="construct.c.page1.prec009"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prec010
            #add-point:BEFORE FIELD prec010 name="construct.b.page1.prec010"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prec010
            
            #add-point:AFTER FIELD prec010 name="construct.a.page1.prec010"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.prec010
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prec010
            #add-point:ON ACTION controlp INFIELD prec010 name="construct.c.page1.prec010"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prec011
            #add-point:BEFORE FIELD prec011 name="construct.b.page1.prec011"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prec011
            
            #add-point:AFTER FIELD prec011 name="construct.a.page1.prec011"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.prec011
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prec011
            #add-point:ON ACTION controlp INFIELD prec011 name="construct.c.page1.prec011"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prec012
            #add-point:BEFORE FIELD prec012 name="construct.b.page1.prec012"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prec012
            
            #add-point:AFTER FIELD prec012 name="construct.a.page1.prec012"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.prec012
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prec012
            #add-point:ON ACTION controlp INFIELD prec012 name="construct.c.page1.prec012"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prec013
            #add-point:BEFORE FIELD prec013 name="construct.b.page1.prec013"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prec013
            
            #add-point:AFTER FIELD prec013 name="construct.a.page1.prec013"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.prec013
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prec013
            #add-point:ON ACTION controlp INFIELD prec013 name="construct.c.page1.prec013"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prec014
            #add-point:BEFORE FIELD prec014 name="construct.b.page1.prec014"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prec014
            
            #add-point:AFTER FIELD prec014 name="construct.a.page1.prec014"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.prec014
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prec014
            #add-point:ON ACTION controlp INFIELD prec014 name="construct.c.page1.prec014"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prec015
            #add-point:BEFORE FIELD prec015 name="construct.b.page1.prec015"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prec015
            
            #add-point:AFTER FIELD prec015 name="construct.a.page1.prec015"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.prec015
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prec015
            #add-point:ON ACTION controlp INFIELD prec015 name="construct.c.page1.prec015"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prec016
            #add-point:BEFORE FIELD prec016 name="construct.b.page1.prec016"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prec016
            
            #add-point:AFTER FIELD prec016 name="construct.a.page1.prec016"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.prec016
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prec016
            #add-point:ON ACTION controlp INFIELD prec016 name="construct.c.page1.prec016"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prec017
            #add-point:BEFORE FIELD prec017 name="construct.b.page1.prec017"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prec017
            
            #add-point:AFTER FIELD prec017 name="construct.a.page1.prec017"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.prec017
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prec017
            #add-point:ON ACTION controlp INFIELD prec017 name="construct.c.page1.prec017"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prec018
            #add-point:BEFORE FIELD prec018 name="construct.b.page1.prec018"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prec018
            
            #add-point:AFTER FIELD prec018 name="construct.a.page1.prec018"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.prec018
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prec018
            #add-point:ON ACTION controlp INFIELD prec018 name="construct.c.page1.prec018"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prec019
            #add-point:BEFORE FIELD prec019 name="construct.b.page1.prec019"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prec019
            
            #add-point:AFTER FIELD prec019 name="construct.a.page1.prec019"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.prec019
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prec019
            #add-point:ON ACTION controlp INFIELD prec019 name="construct.c.page1.prec019"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prec020
            #add-point:BEFORE FIELD prec020 name="construct.b.page1.prec020"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prec020
            
            #add-point:AFTER FIELD prec020 name="construct.a.page1.prec020"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.prec020
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prec020
            #add-point:ON ACTION controlp INFIELD prec020 name="construct.c.page1.prec020"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prec021
            #add-point:BEFORE FIELD prec021 name="construct.b.page1.prec021"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prec021
            
            #add-point:AFTER FIELD prec021 name="construct.a.page1.prec021"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.prec021
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prec021
            #add-point:ON ACTION controlp INFIELD prec021 name="construct.c.page1.prec021"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prec022
            #add-point:BEFORE FIELD prec022 name="construct.b.page1.prec022"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prec022
            
            #add-point:AFTER FIELD prec022 name="construct.a.page1.prec022"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.prec022
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prec022
            #add-point:ON ACTION controlp INFIELD prec022 name="construct.c.page1.prec022"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prec023
            #add-point:BEFORE FIELD prec023 name="construct.b.page1.prec023"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prec023
            
            #add-point:AFTER FIELD prec023 name="construct.a.page1.prec023"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.prec023
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prec023
            #add-point:ON ACTION controlp INFIELD prec023 name="construct.c.page1.prec023"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prec024
            #add-point:BEFORE FIELD prec024 name="construct.b.page1.prec024"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prec024
            
            #add-point:AFTER FIELD prec024 name="construct.a.page1.prec024"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.prec024
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prec024
            #add-point:ON ACTION controlp INFIELD prec024 name="construct.c.page1.prec024"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prec025
            #add-point:BEFORE FIELD prec025 name="construct.b.page1.prec025"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prec025
            
            #add-point:AFTER FIELD prec025 name="construct.a.page1.prec025"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.prec025
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prec025
            #add-point:ON ACTION controlp INFIELD prec025 name="construct.c.page1.prec025"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prec026
            #add-point:BEFORE FIELD prec026 name="construct.b.page1.prec026"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prec026
            
            #add-point:AFTER FIELD prec026 name="construct.a.page1.prec026"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.prec026
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prec026
            #add-point:ON ACTION controlp INFIELD prec026 name="construct.c.page1.prec026"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prec027
            #add-point:BEFORE FIELD prec027 name="construct.b.page1.prec027"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prec027
            
            #add-point:AFTER FIELD prec027 name="construct.a.page1.prec027"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.prec027
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prec027
            #add-point:ON ACTION controlp INFIELD prec027 name="construct.c.page1.prec027"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prec028
            #add-point:BEFORE FIELD prec028 name="construct.b.page1.prec028"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prec028
            
            #add-point:AFTER FIELD prec028 name="construct.a.page1.prec028"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.prec028
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prec028
            #add-point:ON ACTION controlp INFIELD prec028 name="construct.c.page1.prec028"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prec029
            #add-point:BEFORE FIELD prec029 name="construct.b.page1.prec029"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prec029
            
            #add-point:AFTER FIELD prec029 name="construct.a.page1.prec029"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.prec029
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prec029
            #add-point:ON ACTION controlp INFIELD prec029 name="construct.c.page1.prec029"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prec030
            #add-point:BEFORE FIELD prec030 name="construct.b.page1.prec030"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prec030
            
            #add-point:AFTER FIELD prec030 name="construct.a.page1.prec030"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.prec030
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prec030
            #add-point:ON ACTION controlp INFIELD prec030 name="construct.c.page1.prec030"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prec031
            #add-point:BEFORE FIELD prec031 name="construct.b.page1.prec031"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prec031
            
            #add-point:AFTER FIELD prec031 name="construct.a.page1.prec031"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.prec031
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prec031
            #add-point:ON ACTION controlp INFIELD prec031 name="construct.c.page1.prec031"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prec032
            #add-point:BEFORE FIELD prec032 name="construct.b.page1.prec032"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prec032
            
            #add-point:AFTER FIELD prec032 name="construct.a.page1.prec032"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.prec032
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prec032
            #add-point:ON ACTION controlp INFIELD prec032 name="construct.c.page1.prec032"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prec033
            #add-point:BEFORE FIELD prec033 name="construct.b.page1.prec033"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prec033
            
            #add-point:AFTER FIELD prec033 name="construct.a.page1.prec033"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.prec033
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prec033
            #add-point:ON ACTION controlp INFIELD prec033 name="construct.c.page1.prec033"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prec034
            #add-point:BEFORE FIELD prec034 name="construct.b.page1.prec034"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prec034
            
            #add-point:AFTER FIELD prec034 name="construct.a.page1.prec034"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.prec034
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prec034
            #add-point:ON ACTION controlp INFIELD prec034 name="construct.c.page1.prec034"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prec035
            #add-point:BEFORE FIELD prec035 name="construct.b.page1.prec035"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prec035
            
            #add-point:AFTER FIELD prec035 name="construct.a.page1.prec035"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.prec035
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prec035
            #add-point:ON ACTION controlp INFIELD prec035 name="construct.c.page1.prec035"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prec036
            #add-point:BEFORE FIELD prec036 name="construct.b.page1.prec036"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prec036
            
            #add-point:AFTER FIELD prec036 name="construct.a.page1.prec036"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.prec036
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prec036
            #add-point:ON ACTION controlp INFIELD prec036 name="construct.c.page1.prec036"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prec037
            #add-point:BEFORE FIELD prec037 name="construct.b.page1.prec037"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prec037
            
            #add-point:AFTER FIELD prec037 name="construct.a.page1.prec037"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.prec037
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prec037
            #add-point:ON ACTION controlp INFIELD prec037 name="construct.c.page1.prec037"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prec038
            #add-point:BEFORE FIELD prec038 name="construct.b.page1.prec038"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prec038
            
            #add-point:AFTER FIELD prec038 name="construct.a.page1.prec038"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.prec038
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prec038
            #add-point:ON ACTION controlp INFIELD prec038 name="construct.c.page1.prec038"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prec039
            #add-point:BEFORE FIELD prec039 name="construct.b.page1.prec039"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prec039
            
            #add-point:AFTER FIELD prec039 name="construct.a.page1.prec039"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.prec039
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prec039
            #add-point:ON ACTION controlp INFIELD prec039 name="construct.c.page1.prec039"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prec040
            #add-point:BEFORE FIELD prec040 name="construct.b.page1.prec040"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prec040
            
            #add-point:AFTER FIELD prec040 name="construct.a.page1.prec040"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.prec040
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prec040
            #add-point:ON ACTION controlp INFIELD prec040 name="construct.c.page1.prec040"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prec041
            #add-point:BEFORE FIELD prec041 name="construct.b.page1.prec041"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prec041
            
            #add-point:AFTER FIELD prec041 name="construct.a.page1.prec041"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.prec041
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prec041
            #add-point:ON ACTION controlp INFIELD prec041 name="construct.c.page1.prec041"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prec042
            #add-point:BEFORE FIELD prec042 name="construct.b.page1.prec042"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prec042
            
            #add-point:AFTER FIELD prec042 name="construct.a.page1.prec042"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.prec042
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prec042
            #add-point:ON ACTION controlp INFIELD prec042 name="construct.c.page1.prec042"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prec043
            #add-point:BEFORE FIELD prec043 name="construct.b.page1.prec043"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prec043
            
            #add-point:AFTER FIELD prec043 name="construct.a.page1.prec043"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.prec043
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prec043
            #add-point:ON ACTION controlp INFIELD prec043 name="construct.c.page1.prec043"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prec044
            #add-point:BEFORE FIELD prec044 name="construct.b.page1.prec044"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prec044
            
            #add-point:AFTER FIELD prec044 name="construct.a.page1.prec044"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.prec044
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prec044
            #add-point:ON ACTION controlp INFIELD prec044 name="construct.c.page1.prec044"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prec045
            #add-point:BEFORE FIELD prec045 name="construct.b.page1.prec045"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prec045
            
            #add-point:AFTER FIELD prec045 name="construct.a.page1.prec045"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.prec045
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prec045
            #add-point:ON ACTION controlp INFIELD prec045 name="construct.c.page1.prec045"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prec098
            #add-point:BEFORE FIELD prec098 name="construct.b.page1.prec098"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prec098
            
            #add-point:AFTER FIELD prec098 name="construct.a.page1.prec098"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.prec098
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prec098
            #add-point:ON ACTION controlp INFIELD prec098 name="construct.c.page1.prec098"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prec046
            #add-point:BEFORE FIELD prec046 name="construct.b.page1.prec046"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prec046
            
            #add-point:AFTER FIELD prec046 name="construct.a.page1.prec046"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.prec046
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prec046
            #add-point:ON ACTION controlp INFIELD prec046 name="construct.c.page1.prec046"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prec047
            #add-point:BEFORE FIELD prec047 name="construct.b.page1.prec047"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prec047
            
            #add-point:AFTER FIELD prec047 name="construct.a.page1.prec047"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.prec047
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prec047
            #add-point:ON ACTION controlp INFIELD prec047 name="construct.c.page1.prec047"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prec048
            #add-point:BEFORE FIELD prec048 name="construct.b.page1.prec048"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prec048
            
            #add-point:AFTER FIELD prec048 name="construct.a.page1.prec048"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.prec048
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prec048
            #add-point:ON ACTION controlp INFIELD prec048 name="construct.c.page1.prec048"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prec049
            #add-point:BEFORE FIELD prec049 name="construct.b.page1.prec049"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prec049
            
            #add-point:AFTER FIELD prec049 name="construct.a.page1.prec049"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.prec049
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prec049
            #add-point:ON ACTION controlp INFIELD prec049 name="construct.c.page1.prec049"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prec050
            #add-point:BEFORE FIELD prec050 name="construct.b.page1.prec050"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prec050
            
            #add-point:AFTER FIELD prec050 name="construct.a.page1.prec050"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.prec050
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prec050
            #add-point:ON ACTION controlp INFIELD prec050 name="construct.c.page1.prec050"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prec051
            #add-point:BEFORE FIELD prec051 name="construct.b.page1.prec051"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prec051
            
            #add-point:AFTER FIELD prec051 name="construct.a.page1.prec051"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.prec051
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prec051
            #add-point:ON ACTION controlp INFIELD prec051 name="construct.c.page1.prec051"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prec052
            #add-point:BEFORE FIELD prec052 name="construct.b.page1.prec052"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prec052
            
            #add-point:AFTER FIELD prec052 name="construct.a.page1.prec052"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.prec052
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prec052
            #add-point:ON ACTION controlp INFIELD prec052 name="construct.c.page1.prec052"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prec053
            #add-point:BEFORE FIELD prec053 name="construct.b.page1.prec053"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prec053
            
            #add-point:AFTER FIELD prec053 name="construct.a.page1.prec053"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.prec053
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prec053
            #add-point:ON ACTION controlp INFIELD prec053 name="construct.c.page1.prec053"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prec054
            #add-point:BEFORE FIELD prec054 name="construct.b.page1.prec054"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prec054
            
            #add-point:AFTER FIELD prec054 name="construct.a.page1.prec054"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.prec054
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prec054
            #add-point:ON ACTION controlp INFIELD prec054 name="construct.c.page1.prec054"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prec055
            #add-point:BEFORE FIELD prec055 name="construct.b.page1.prec055"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prec055
            
            #add-point:AFTER FIELD prec055 name="construct.a.page1.prec055"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.prec055
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prec055
            #add-point:ON ACTION controlp INFIELD prec055 name="construct.c.page1.prec055"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prec056
            #add-point:BEFORE FIELD prec056 name="construct.b.page1.prec056"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prec056
            
            #add-point:AFTER FIELD prec056 name="construct.a.page1.prec056"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.prec056
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prec056
            #add-point:ON ACTION controlp INFIELD prec056 name="construct.c.page1.prec056"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prec057
            #add-point:BEFORE FIELD prec057 name="construct.b.page1.prec057"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prec057
            
            #add-point:AFTER FIELD prec057 name="construct.a.page1.prec057"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.prec057
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prec057
            #add-point:ON ACTION controlp INFIELD prec057 name="construct.c.page1.prec057"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prec058
            #add-point:BEFORE FIELD prec058 name="construct.b.page1.prec058"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prec058
            
            #add-point:AFTER FIELD prec058 name="construct.a.page1.prec058"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.prec058
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prec058
            #add-point:ON ACTION controlp INFIELD prec058 name="construct.c.page1.prec058"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prec059
            #add-point:BEFORE FIELD prec059 name="construct.b.page1.prec059"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prec059
            
            #add-point:AFTER FIELD prec059 name="construct.a.page1.prec059"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.prec059
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prec059
            #add-point:ON ACTION controlp INFIELD prec059 name="construct.c.page1.prec059"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prec060
            #add-point:BEFORE FIELD prec060 name="construct.b.page1.prec060"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prec060
            
            #add-point:AFTER FIELD prec060 name="construct.a.page1.prec060"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.prec060
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prec060
            #add-point:ON ACTION controlp INFIELD prec060 name="construct.c.page1.prec060"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prec061
            #add-point:BEFORE FIELD prec061 name="construct.b.page1.prec061"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prec061
            
            #add-point:AFTER FIELD prec061 name="construct.a.page1.prec061"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.prec061
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prec061
            #add-point:ON ACTION controlp INFIELD prec061 name="construct.c.page1.prec061"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prec062
            #add-point:BEFORE FIELD prec062 name="construct.b.page1.prec062"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prec062
            
            #add-point:AFTER FIELD prec062 name="construct.a.page1.prec062"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.prec062
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prec062
            #add-point:ON ACTION controlp INFIELD prec062 name="construct.c.page1.prec062"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prec063
            #add-point:BEFORE FIELD prec063 name="construct.b.page1.prec063"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prec063
            
            #add-point:AFTER FIELD prec063 name="construct.a.page1.prec063"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.prec063
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prec063
            #add-point:ON ACTION controlp INFIELD prec063 name="construct.c.page1.prec063"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prec064
            #add-point:BEFORE FIELD prec064 name="construct.b.page1.prec064"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prec064
            
            #add-point:AFTER FIELD prec064 name="construct.a.page1.prec064"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.prec064
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prec064
            #add-point:ON ACTION controlp INFIELD prec064 name="construct.c.page1.prec064"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prec065
            #add-point:BEFORE FIELD prec065 name="construct.b.page1.prec065"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prec065
            
            #add-point:AFTER FIELD prec065 name="construct.a.page1.prec065"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.prec065
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prec065
            #add-point:ON ACTION controlp INFIELD prec065 name="construct.c.page1.prec065"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prec066
            #add-point:BEFORE FIELD prec066 name="construct.b.page1.prec066"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prec066
            
            #add-point:AFTER FIELD prec066 name="construct.a.page1.prec066"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.prec066
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prec066
            #add-point:ON ACTION controlp INFIELD prec066 name="construct.c.page1.prec066"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prec067
            #add-point:BEFORE FIELD prec067 name="construct.b.page1.prec067"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prec067
            
            #add-point:AFTER FIELD prec067 name="construct.a.page1.prec067"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.prec067
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prec067
            #add-point:ON ACTION controlp INFIELD prec067 name="construct.c.page1.prec067"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prec068
            #add-point:BEFORE FIELD prec068 name="construct.b.page1.prec068"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prec068
            
            #add-point:AFTER FIELD prec068 name="construct.a.page1.prec068"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.prec068
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prec068
            #add-point:ON ACTION controlp INFIELD prec068 name="construct.c.page1.prec068"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prec069
            #add-point:BEFORE FIELD prec069 name="construct.b.page1.prec069"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prec069
            
            #add-point:AFTER FIELD prec069 name="construct.a.page1.prec069"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.prec069
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prec069
            #add-point:ON ACTION controlp INFIELD prec069 name="construct.c.page1.prec069"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prec070
            #add-point:BEFORE FIELD prec070 name="construct.b.page1.prec070"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prec070
            
            #add-point:AFTER FIELD prec070 name="construct.a.page1.prec070"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.prec070
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prec070
            #add-point:ON ACTION controlp INFIELD prec070 name="construct.c.page1.prec070"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prec071
            #add-point:BEFORE FIELD prec071 name="construct.b.page1.prec071"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prec071
            
            #add-point:AFTER FIELD prec071 name="construct.a.page1.prec071"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.prec071
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prec071
            #add-point:ON ACTION controlp INFIELD prec071 name="construct.c.page1.prec071"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prec072
            #add-point:BEFORE FIELD prec072 name="construct.b.page1.prec072"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prec072
            
            #add-point:AFTER FIELD prec072 name="construct.a.page1.prec072"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.prec072
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prec072
            #add-point:ON ACTION controlp INFIELD prec072 name="construct.c.page1.prec072"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prec073
            #add-point:BEFORE FIELD prec073 name="construct.b.page1.prec073"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prec073
            
            #add-point:AFTER FIELD prec073 name="construct.a.page1.prec073"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.prec073
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prec073
            #add-point:ON ACTION controlp INFIELD prec073 name="construct.c.page1.prec073"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prec074
            #add-point:BEFORE FIELD prec074 name="construct.b.page1.prec074"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prec074
            
            #add-point:AFTER FIELD prec074 name="construct.a.page1.prec074"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.prec074
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prec074
            #add-point:ON ACTION controlp INFIELD prec074 name="construct.c.page1.prec074"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prec075
            #add-point:BEFORE FIELD prec075 name="construct.b.page1.prec075"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prec075
            
            #add-point:AFTER FIELD prec075 name="construct.a.page1.prec075"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.prec075
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prec075
            #add-point:ON ACTION controlp INFIELD prec075 name="construct.c.page1.prec075"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prec078
            #add-point:BEFORE FIELD prec078 name="construct.b.page1.prec078"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prec078
            
            #add-point:AFTER FIELD prec078 name="construct.a.page1.prec078"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.prec078
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prec078
            #add-point:ON ACTION controlp INFIELD prec078 name="construct.c.page1.prec078"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prec079
            #add-point:BEFORE FIELD prec079 name="construct.b.page1.prec079"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prec079
            
            #add-point:AFTER FIELD prec079 name="construct.a.page1.prec079"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.prec079
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prec079
            #add-point:ON ACTION controlp INFIELD prec079 name="construct.c.page1.prec079"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prec081
            #add-point:BEFORE FIELD prec081 name="construct.b.page1.prec081"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prec081
            
            #add-point:AFTER FIELD prec081 name="construct.a.page1.prec081"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.prec081
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prec081
            #add-point:ON ACTION controlp INFIELD prec081 name="construct.c.page1.prec081"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prec001
            #add-point:BEFORE FIELD prec001 name="construct.b.page1.prec001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prec001
            
            #add-point:AFTER FIELD prec001 name="construct.a.page1.prec001"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.prec001
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prec001
            #add-point:ON ACTION controlp INFIELD prec001 name="construct.c.page1.prec001"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prec080
            #add-point:BEFORE FIELD prec080 name="construct.b.page2.prec080"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prec080
            
            #add-point:AFTER FIELD prec080 name="construct.a.page2.prec080"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.prec080
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prec080
            #add-point:ON ACTION controlp INFIELD prec080 name="construct.c.page2.prec080"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prec082
            #add-point:BEFORE FIELD prec082 name="construct.b.page2.prec082"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prec082
            
            #add-point:AFTER FIELD prec082 name="construct.a.page2.prec082"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.prec082
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prec082
            #add-point:ON ACTION controlp INFIELD prec082 name="construct.c.page2.prec082"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prec083
            #add-point:BEFORE FIELD prec083 name="construct.b.page2.prec083"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prec083
            
            #add-point:AFTER FIELD prec083 name="construct.a.page2.prec083"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.prec083
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prec083
            #add-point:ON ACTION controlp INFIELD prec083 name="construct.c.page2.prec083"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prec084
            #add-point:BEFORE FIELD prec084 name="construct.b.page2.prec084"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prec084
            
            #add-point:AFTER FIELD prec084 name="construct.a.page2.prec084"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.prec084
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prec084
            #add-point:ON ACTION controlp INFIELD prec084 name="construct.c.page2.prec084"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prec085
            #add-point:BEFORE FIELD prec085 name="construct.b.page2.prec085"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prec085
            
            #add-point:AFTER FIELD prec085 name="construct.a.page2.prec085"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.prec085
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prec085
            #add-point:ON ACTION controlp INFIELD prec085 name="construct.c.page2.prec085"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prec086
            #add-point:BEFORE FIELD prec086 name="construct.b.page2.prec086"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prec086
            
            #add-point:AFTER FIELD prec086 name="construct.a.page2.prec086"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.prec086
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prec086
            #add-point:ON ACTION controlp INFIELD prec086 name="construct.c.page2.prec086"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prec087
            #add-point:BEFORE FIELD prec087 name="construct.b.page2.prec087"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prec087
            
            #add-point:AFTER FIELD prec087 name="construct.a.page2.prec087"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.prec087
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prec087
            #add-point:ON ACTION controlp INFIELD prec087 name="construct.c.page2.prec087"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prec088
            #add-point:BEFORE FIELD prec088 name="construct.b.page2.prec088"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prec088
            
            #add-point:AFTER FIELD prec088 name="construct.a.page2.prec088"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.prec088
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prec088
            #add-point:ON ACTION controlp INFIELD prec088 name="construct.c.page2.prec088"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prec089
            #add-point:BEFORE FIELD prec089 name="construct.b.page2.prec089"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prec089
            
            #add-point:AFTER FIELD prec089 name="construct.a.page2.prec089"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.prec089
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prec089
            #add-point:ON ACTION controlp INFIELD prec089 name="construct.c.page2.prec089"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prec090
            #add-point:BEFORE FIELD prec090 name="construct.b.page2.prec090"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prec090
            
            #add-point:AFTER FIELD prec090 name="construct.a.page2.prec090"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.prec090
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prec090
            #add-point:ON ACTION controlp INFIELD prec090 name="construct.c.page2.prec090"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prec091
            #add-point:BEFORE FIELD prec091 name="construct.b.page2.prec091"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prec091
            
            #add-point:AFTER FIELD prec091 name="construct.a.page2.prec091"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.prec091
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prec091
            #add-point:ON ACTION controlp INFIELD prec091 name="construct.c.page2.prec091"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prec092
            #add-point:BEFORE FIELD prec092 name="construct.b.page2.prec092"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prec092
            
            #add-point:AFTER FIELD prec092 name="construct.a.page2.prec092"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.prec092
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prec092
            #add-point:ON ACTION controlp INFIELD prec092 name="construct.c.page2.prec092"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prec093
            #add-point:BEFORE FIELD prec093 name="construct.b.page2.prec093"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prec093
            
            #add-point:AFTER FIELD prec093 name="construct.a.page2.prec093"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.prec093
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prec093
            #add-point:ON ACTION controlp INFIELD prec093 name="construct.c.page2.prec093"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prec094
            #add-point:BEFORE FIELD prec094 name="construct.b.page2.prec094"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prec094
            
            #add-point:AFTER FIELD prec094 name="construct.a.page2.prec094"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.prec094
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prec094
            #add-point:ON ACTION controlp INFIELD prec094 name="construct.c.page2.prec094"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prec095
            #add-point:BEFORE FIELD prec095 name="construct.b.page2.prec095"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prec095
            
            #add-point:AFTER FIELD prec095 name="construct.a.page2.prec095"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.prec095
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prec095
            #add-point:ON ACTION controlp INFIELD prec095 name="construct.c.page2.prec095"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prec096
            #add-point:BEFORE FIELD prec096 name="construct.b.page2.prec096"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prec096
            
            #add-point:AFTER FIELD prec096 name="construct.a.page2.prec096"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.prec096
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prec096
            #add-point:ON ACTION controlp INFIELD prec096 name="construct.c.page2.prec096"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prec097
            #add-point:BEFORE FIELD prec097 name="construct.b.page2.prec097"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prec097
            
            #add-point:AFTER FIELD prec097 name="construct.a.page2.prec097"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.prec097
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prec097
            #add-point:ON ACTION controlp INFIELD prec097 name="construct.c.page2.prec097"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD precunit
            #add-point:BEFORE FIELD precunit name="construct.b.page2.precunit"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD precunit
            
            #add-point:AFTER FIELD precunit name="construct.a.page2.precunit"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.precunit
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD precunit
            #add-point:ON ACTION controlp INFIELD precunit name="construct.c.page2.precunit"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD precsite
            #add-point:BEFORE FIELD precsite name="construct.b.page2.precsite"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD precsite
            
            #add-point:AFTER FIELD precsite name="construct.a.page2.precsite"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.precsite
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD precsite
            #add-point:ON ACTION controlp INFIELD precsite name="construct.c.page2.precsite"
            
            #END add-point
 
 
   
       
      END CONSTRUCT
      
      CONSTRUCT g_wc2_table2 ON predacti,predseq1,pred001,pred002,pred003,predseq,pred004,pred006,pred005, 
          pred007,predsite,predunit
           FROM s_detail3[1].predacti,s_detail3[1].predseq1,s_detail3[1].pred001,s_detail3[1].pred002, 
               s_detail3[1].pred003,s_detail3[1].predseq,s_detail3[1].pred004,s_detail3[1].pred006,s_detail3[1].pred005, 
               s_detail3[1].pred007,s_detail3[1].predsite,s_detail3[1].predunit
                      
         BEFORE CONSTRUCT
            #add-point:cs段before_construct name="cs.body2.before_construct"
            
            #end add-point 
            
       #單身公用欄位開窗相關處理(table 2)
       
       
       #單身一般欄位開窗相關處理       
                #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD predacti
            #add-point:BEFORE FIELD predacti name="construct.b.page3.predacti"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD predacti
            
            #add-point:AFTER FIELD predacti name="construct.a.page3.predacti"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page3.predacti
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD predacti
            #add-point:ON ACTION controlp INFIELD predacti name="construct.c.page3.predacti"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD predseq1
            #add-point:BEFORE FIELD predseq1 name="construct.b.page3.predseq1"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD predseq1
            
            #add-point:AFTER FIELD predseq1 name="construct.a.page3.predseq1"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page3.predseq1
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD predseq1
            #add-point:ON ACTION controlp INFIELD predseq1 name="construct.c.page3.predseq1"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pred001
            #add-point:BEFORE FIELD pred001 name="construct.b.page3.pred001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pred001
            
            #add-point:AFTER FIELD pred001 name="construct.a.page3.pred001"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page3.pred001
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pred001
            #add-point:ON ACTION controlp INFIELD pred001 name="construct.c.page3.pred001"
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_prea001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO pred001  #顯示到畫面上
            NEXT FIELD pred001                     #返回原欄位
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pred002
            #add-point:BEFORE FIELD pred002 name="construct.b.page3.pred002"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pred002
            
            #add-point:AFTER FIELD pred002 name="construct.a.page3.pred002"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page3.pred002
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pred002
            #add-point:ON ACTION controlp INFIELD pred002 name="construct.c.page3.pred002"
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_inaa001_14()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO pred002  #顯示到畫面上
            NEXT FIELD pred002                     #返回原欄位
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pred003
            #add-point:BEFORE FIELD pred003 name="construct.b.page3.pred003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pred003
            
            #add-point:AFTER FIELD pred003 name="construct.a.page3.pred003"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page3.pred003
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pred003
            #add-point:ON ACTION controlp INFIELD pred003 name="construct.c.page3.pred003"
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_mhae001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO pred003  #顯示到畫面上
            NEXT FIELD pred003                     #返回原欄位
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD predseq
            #add-point:BEFORE FIELD predseq name="construct.b.page3.predseq"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD predseq
            
            #add-point:AFTER FIELD predseq name="construct.a.page3.predseq"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page3.predseq
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD predseq
            #add-point:ON ACTION controlp INFIELD predseq name="construct.c.page3.predseq"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pred004
            #add-point:BEFORE FIELD pred004 name="construct.b.page3.pred004"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pred004
            
            #add-point:AFTER FIELD pred004 name="construct.a.page3.pred004"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page3.pred004
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pred004
            #add-point:ON ACTION controlp INFIELD pred004 name="construct.c.page3.pred004"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pred006
            #add-point:BEFORE FIELD pred006 name="construct.b.page3.pred006"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pred006
            
            #add-point:AFTER FIELD pred006 name="construct.a.page3.pred006"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page3.pred006
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pred006
            #add-point:ON ACTION controlp INFIELD pred006 name="construct.c.page3.pred006"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pred005
            #add-point:BEFORE FIELD pred005 name="construct.b.page3.pred005"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pred005
            
            #add-point:AFTER FIELD pred005 name="construct.a.page3.pred005"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page3.pred005
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pred005
            #add-point:ON ACTION controlp INFIELD pred005 name="construct.c.page3.pred005"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pred007
            #add-point:BEFORE FIELD pred007 name="construct.b.page3.pred007"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pred007
            
            #add-point:AFTER FIELD pred007 name="construct.a.page3.pred007"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page3.pred007
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pred007
            #add-point:ON ACTION controlp INFIELD pred007 name="construct.c.page3.pred007"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD predsite
            #add-point:BEFORE FIELD predsite name="construct.b.page3.predsite"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD predsite
            
            #add-point:AFTER FIELD predsite name="construct.a.page3.predsite"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page3.predsite
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD predsite
            #add-point:ON ACTION controlp INFIELD predsite name="construct.c.page3.predsite"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD predunit
            #add-point:BEFORE FIELD predunit name="construct.b.page3.predunit"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD predunit
            
            #add-point:AFTER FIELD predunit name="construct.a.page3.predunit"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page3.predunit
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD predunit
            #add-point:ON ACTION controlp INFIELD predunit name="construct.c.page3.predunit"
            
            #END add-point
 
 
   
       
      END CONSTRUCT
 
      CONSTRUCT g_wc2_table3 ON preb002,preb003,preb004,preb005,preb006,preb007,preb008,prebacti,prebsite, 
          prebunit,preb001
           FROM s_detail4[1].preb002,s_detail4[1].preb003,s_detail4[1].preb004,s_detail4[1].preb005, 
               s_detail4[1].preb006,s_detail4[1].preb007,s_detail4[1].preb008,s_detail4[1].prebacti, 
               s_detail4[1].prebsite,s_detail4[1].prebunit,s_detail4[1].preb001
                      
         BEFORE CONSTRUCT
            #add-point:cs段before_construct name="cs.body3.before_construct"
            
            #end add-point 
            
       #單身公用欄位開窗相關處理(table 3)
       
       
       #單身一般欄位開窗相關處理       
                #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD preb002
            #add-point:BEFORE FIELD preb002 name="construct.b.page4.preb002"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD preb002
            
            #add-point:AFTER FIELD preb002 name="construct.a.page4.preb002"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page4.preb002
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD preb002
            #add-point:ON ACTION controlp INFIELD preb002 name="construct.c.page4.preb002"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD preb003
            #add-point:BEFORE FIELD preb003 name="construct.b.page4.preb003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD preb003
            
            #add-point:AFTER FIELD preb003 name="construct.a.page4.preb003"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page4.preb003
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD preb003
            #add-point:ON ACTION controlp INFIELD preb003 name="construct.c.page4.preb003"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD preb004
            #add-point:BEFORE FIELD preb004 name="construct.b.page4.preb004"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD preb004
            
            #add-point:AFTER FIELD preb004 name="construct.a.page4.preb004"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page4.preb004
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD preb004
            #add-point:ON ACTION controlp INFIELD preb004 name="construct.c.page4.preb004"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD preb005
            #add-point:BEFORE FIELD preb005 name="construct.b.page4.preb005"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD preb005
            
            #add-point:AFTER FIELD preb005 name="construct.a.page4.preb005"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page4.preb005
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD preb005
            #add-point:ON ACTION controlp INFIELD preb005 name="construct.c.page4.preb005"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD preb006
            #add-point:BEFORE FIELD preb006 name="construct.b.page4.preb006"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD preb006
            
            #add-point:AFTER FIELD preb006 name="construct.a.page4.preb006"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page4.preb006
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD preb006
            #add-point:ON ACTION controlp INFIELD preb006 name="construct.c.page4.preb006"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD preb007
            #add-point:BEFORE FIELD preb007 name="construct.b.page4.preb007"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD preb007
            
            #add-point:AFTER FIELD preb007 name="construct.a.page4.preb007"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page4.preb007
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD preb007
            #add-point:ON ACTION controlp INFIELD preb007 name="construct.c.page4.preb007"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD preb008
            #add-point:BEFORE FIELD preb008 name="construct.b.page4.preb008"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD preb008
            
            #add-point:AFTER FIELD preb008 name="construct.a.page4.preb008"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page4.preb008
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD preb008
            #add-point:ON ACTION controlp INFIELD preb008 name="construct.c.page4.preb008"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prebacti
            #add-point:BEFORE FIELD prebacti name="construct.b.page4.prebacti"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prebacti
            
            #add-point:AFTER FIELD prebacti name="construct.a.page4.prebacti"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page4.prebacti
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prebacti
            #add-point:ON ACTION controlp INFIELD prebacti name="construct.c.page4.prebacti"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prebsite
            #add-point:BEFORE FIELD prebsite name="construct.b.page4.prebsite"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prebsite
            
            #add-point:AFTER FIELD prebsite name="construct.a.page4.prebsite"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page4.prebsite
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prebsite
            #add-point:ON ACTION controlp INFIELD prebsite name="construct.c.page4.prebsite"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prebunit
            #add-point:BEFORE FIELD prebunit name="construct.b.page4.prebunit"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prebunit
            
            #add-point:AFTER FIELD prebunit name="construct.a.page4.prebunit"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page4.prebunit
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prebunit
            #add-point:ON ACTION controlp INFIELD prebunit name="construct.c.page4.prebunit"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD preb001
            #add-point:BEFORE FIELD preb001 name="construct.b.page4.preb001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD preb001
            
            #add-point:AFTER FIELD preb001 name="construct.a.page4.preb001"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page4.preb001
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD preb001
            #add-point:ON ACTION controlp INFIELD preb001 name="construct.c.page4.preb001"
            
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
            INITIALIZE g_wc2_table2 TO NULL
 
            INITIALIZE g_wc2_table3 TO NULL
 
 
            FOR li_idx = 1 TO la_wc.getLength()
               CASE
                  WHEN la_wc[li_idx].tableid = "prea_t" 
                     LET g_wc = la_wc[li_idx].wc
                  WHEN la_wc[li_idx].tableid = "prec_t" 
                     LET g_wc2_table1 = la_wc[li_idx].wc
                  WHEN la_wc[li_idx].tableid = "pred_t" 
                     LET g_wc2_table2 = la_wc[li_idx].wc
 
                  WHEN la_wc[li_idx].tableid = "preb_t" 
                     LET g_wc2_table3 = la_wc[li_idx].wc
 
 
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
   IF g_wc2_table2 <> " 1=1" THEN
      LET g_wc2 = g_wc2 ," AND ", g_wc2_table2
   END IF
 
   IF g_wc2_table3 <> " 1=1" THEN
      LET g_wc2 = g_wc2 ," AND ", g_wc2_table3
   END IF
 
 
 
 
   
   #add-point:cs段結束前 name="cs.after_construct"
   
   #end add-point    
 
   IF INT_FLAG THEN
      RETURN
   END IF
 
END FUNCTION
 
{</section>}
 
{<section id="aprt310.query" >}
#+ 資料查詢QBE功能準備
PRIVATE FUNCTION aprt310_query()
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
   CALL g_prec_d.clear()
   CALL g_prec2_d.clear()
   CALL g_prec3_d.clear()
   CALL g_prec4_d.clear()
 
   
   #add-point:query段other name="query.other"
   CALL cl_set_comp_visible("page_5", TRUE)
   #end add-point   
   
   DISPLAY '' TO FORMONLY.idx
   DISPLAY '' TO FORMONLY.cnt
   DISPLAY '' TO FORMONLY.b_index
   DISPLAY '' TO FORMONLY.b_count
   DISPLAY '' TO FORMONLY.h_index
   DISPLAY '' TO FORMONLY.h_count
   
   CALL aprt310_construct()
 
   IF INT_FLAG THEN
      #取消查詢
      LET INT_FLAG = 0
      #LET g_wc = ls_wc
      LET g_wc = " 1=2"
      CALL aprt310_browser_fill("")
      CALL aprt310_fetch("")
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
   LET g_detail_idx_list[2] = 1
   LET g_detail_idx_list[3] = 1
   LET g_detail_idx_list[4] = 1
 
   LET g_error_show  = 1
   LET g_wc_filter   = ""
   LET l_ac = 1
   CALL FGL_SET_ARR_CURR(1)
   CALL aprt310_browser_fill("F")
         
   IF g_browser_cnt = 0 THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code = "-100" 
      LET g_errparam.popup = TRUE 
      CALL cl_err()
   ELSE
      CALL aprt310_fetch("F") 
      #顯示單身筆數
      CALL aprt310_idx_chk()
   END IF
 
END FUNCTION
 
{</section>}
 
{<section id="aprt310.fetch" >}
#+ 指定PK後抓取單頭其他資料
PRIVATE FUNCTION aprt310_fetch(p_flag)
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
   
   LET g_prea_m.preadocno = g_browser[g_current_idx].b_preadocno
 
   
   #重讀DB,因TEMP有不被更新特性
   EXECUTE aprt310_master_referesh USING g_prea_m.preadocno INTO g_prea_m.preasite,g_prea_m.preadocdt, 
       g_prea_m.preadocno,g_prea_m.prea000,g_prea_m.preaunit,g_prea_m.prea001,g_prea_m.prea002,g_prea_m.preaacti, 
       g_prea_m.preastus,g_prea_m.prea003,g_prea_m.prea004,g_prea_m.prea052,g_prea_m.prea005,g_prea_m.prea006, 
       g_prea_m.prea051,g_prea_m.prea008,g_prea_m.prea007,g_prea_m.prea009,g_prea_m.prea010,g_prea_m.prea013, 
       g_prea_m.prea050,g_prea_m.prea011,g_prea_m.prea012,g_prea_m.prea014,g_prea_m.prea015,g_prea_m.preaownid, 
       g_prea_m.preaowndp,g_prea_m.preacrtid,g_prea_m.preacrtdp,g_prea_m.preacrtdt,g_prea_m.preamodid, 
       g_prea_m.preamoddt,g_prea_m.preacnfid,g_prea_m.preacnfdt,g_prea_m.preapstid,g_prea_m.preapstdt, 
       g_prea_m.prea003_desc,g_prea_m.prea006_desc,g_prea_m.prea008_desc,g_prea_m.prea007_desc,g_prea_m.prea009_desc, 
       g_prea_m.prea010_desc,g_prea_m.prea011_desc,g_prea_m.prea012_desc,g_prea_m.preaownid_desc,g_prea_m.preaowndp_desc, 
       g_prea_m.preacrtid_desc,g_prea_m.preacrtdp_desc,g_prea_m.preamodid_desc,g_prea_m.preacnfid_desc, 
       g_prea_m.preapstid_desc
   
   #遮罩相關處理
   LET g_prea_m_mask_o.* =  g_prea_m.*
   CALL aprt310_prea_t_mask()
   LET g_prea_m_mask_n.* =  g_prea_m.*
   
   #根據資料狀態切換action狀態
   CALL cl_set_act_visible("statechange,modify,modify_detail,delete,reproduce", TRUE)
   CALL aprt310_set_act_visible()   
   CALL aprt310_set_act_no_visible()
   
   #add-point:fetch段action控制 name="fetch.action_control"

   IF g_prea_m.prea013 = 'Y' THEN
      CALL cl_set_comp_visible("page_5", TRUE)
      CALL cl_set_comp_visible("lbl_preb003", FALSE)
      CALL cl_set_comp_visible("lbl_preb004", FALSE)
      CALL cl_set_comp_visible("lbl_preb005", FALSE)
      CALL cl_set_comp_visible("lbl_preb006", FALSE)
      CALL cl_set_comp_visible("lbl_preb007", FALSE)
      CALL cl_set_comp_visible("lbl_preb008", FALSE)
      CALL cl_set_comp_visible("preb003_1", FALSE)
      CALL cl_set_comp_visible("preb004_1", FALSE)
      CALL cl_set_comp_visible("preb005_1", FALSE)
      CALL cl_set_comp_visible("preb006_1", FALSE)
      CALL cl_set_comp_visible("preb007_1", FALSE)
      CALL cl_set_comp_visible("preb008_1", FALSE) 
      
   ELSE
      CALL cl_set_comp_visible("page_5", FALSE)
      CALL cl_set_comp_visible("lbl_preb003", TRUE)
      CALL cl_set_comp_visible("lbl_preb004", TRUE)
      CALL cl_set_comp_visible("lbl_preb005", TRUE)
      CALL cl_set_comp_visible("lbl_preb006", TRUE)
      CALL cl_set_comp_visible("lbl_preb007", TRUE)
      CALL cl_set_comp_visible("lbl_preb008", TRUE)
      CALL cl_set_comp_visible("preb003_1", TRUE)
      CALL cl_set_comp_visible("preb004_1", TRUE)
      CALL cl_set_comp_visible("preb005_1", TRUE)
      CALL cl_set_comp_visible("preb006_1", TRUE)
      CALL cl_set_comp_visible("preb007_1", TRUE)
      CALL cl_set_comp_visible("preb008_1", TRUE)          
   END IF
   #160604-00001#1 -s by 08172
   IF g_browser_cnt = 0 THEN
      CALL cl_set_act_visible("modify_detail", FALSE)
   ELSE
      CALL cl_set_act_visible("modify_detail",TRUE)
   END IF
   CALL aprt310_set_act_visible()   
   CALL aprt310_set_act_no_visible()                  
   #160604-00001#1 -e by 08172
   #end add-point  
   
   
   
   #add-point:fetch結束前 name="fetch.after"
   
   #end add-point
   
   #保存單頭舊值
   LET g_prea_m_t.* = g_prea_m.*
   LET g_prea_m_o.* = g_prea_m.*
   
   LET g_data_owner = g_prea_m.preaownid      
   LET g_data_dept  = g_prea_m.preaowndp
   
   #重新顯示   
   CALL aprt310_show()
 
   #應用 a56 樣板自動產生(Version:3)
   #檢查此單據是否需顯示BPM簽核狀況按鈕 
   IF cl_bpm_chk() THEN
      CALL cl_set_act_visible("bpm_status",TRUE)
   ELSE
      CALL cl_set_act_visible("bpm_status",FALSE)
   END IF
 
 
 
 
 
END FUNCTION
 
{</section>}
 
{<section id="aprt310.insert" >}
#+ 資料新增
PRIVATE FUNCTION aprt310_insert()
   #add-point:insert段define(客製用) name="insert.define_customerization"
   
   #end add-point    
   #add-point:insert段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="insert.define"
   DEFINE r_success     LIKE type_t.num5
   DEFINE r_doctype     LIKE rtai_t.rtai004
   DEFINE l_insert      LIKE type_t.num5
   #end add-point    
   
   #add-point:Function前置處理  name="insert.pre_function"
   
   #end add-point
   
   #清畫面欄位內容
   CLEAR FORM                    
   CALL g_prec_d.clear()   
   CALL g_prec2_d.clear()  
   CALL g_prec3_d.clear()  
   CALL g_prec4_d.clear()  
 
 
   INITIALIZE g_prea_m.* TO NULL             #DEFAULT 設定
   
   LET g_preadocno_t = NULL
 
   
   LET g_master_insert = FALSE
   
   #add-point:insert段before name="insert.before"
   
   #end add-point    
   
   CALL s_transaction_begin()
   WHILE TRUE
      #公用欄位給值(單頭)
      #應用 a14 樣板自動產生(Version:5)    
      #公用欄位新增給值  
      LET g_prea_m.preaownid = g_user
      LET g_prea_m.preaowndp = g_dept
      LET g_prea_m.preacrtid = g_user
      LET g_prea_m.preacrtdp = g_dept 
      LET g_prea_m.preacrtdt = cl_get_current()
      LET g_prea_m.preamodid = g_user
      LET g_prea_m.preamoddt = cl_get_current()
      LET g_prea_m.preastus = 'N'
 
 
 
 
      #append欄位給值
      
     
      #一般欄位給值
            LET g_prea_m.preaacti = "Y"
      LET g_prea_m.prea013 = "N"
      LET g_prea_m.prea050 = "Y"
 
  
      #add-point:單頭預設值 name="insert.default"
      LET g_prea_m.prea013 = "N"
      LET g_prea_m.prea000='I'
      LET g_prea_m.preadocdt = g_today
      LET g_prea_m.prea014 = g_today
      LET g_prea_m.prea015 = '00:00:00'
      
      LET g_prea_m.prea011 = g_user
      LET g_prea_m.prea012 = g_dept
      LET g_prea_m.preb005_1 = '00:00:00'
      LET g_prea_m.preb006_1 = '23:59:59'
      LET g_prea_m.prea015 = '00:00:00'
           
      LET g_site_flag = FALSE
      CALL s_aooi500_default(g_prog,'preasite',g_prea_m.preasite)
         RETURNING l_insert,g_prea_m.preasite
      IF NOT l_insert THEN
         RETURN
      END IF
      LET g_prea_m.preaunit = g_prea_m.preasite
      LET r_success = ''
      LET r_doctype = ''
      CALL s_arti200_get_def_doc_type(g_prea_m.preasite,g_prog,'1')
           RETURNING r_success,r_doctype
      LET g_prea_m.preadocno = r_doctype  
      
      INITIALIZE g_ref_fields TO NULL
      LET g_ref_fields[1] = g_prea_m.prea011
      CALL ap_ref_array2(g_ref_fields,"SELECT ooag011 FROM ooag_t WHERE ooagent='"||g_enterprise||"' AND ooag001=? ","") RETURNING g_rtn_fields
      LET g_prea_m.prea011_desc = '', g_rtn_fields[1] , ''
      DISPLAY BY NAME g_prea_m.prea011_desc      
       
      INITIALIZE g_ref_fields TO NULL
      LET g_ref_fields[1] = g_prea_m.prea012
      CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
      LET g_prea_m.prea012_desc = '', g_rtn_fields[1] , ''
      DISPLAY BY NAME g_prea_m.prea012_desc
      
      IF g_prea_m.prea013 = 'Y' THEN
         CALL cl_set_comp_visible("page_5", TRUE)
         CALL cl_set_comp_visible("lbl_preb003", FALSE)
         CALL cl_set_comp_visible("lbl_preb004", FALSE)
         CALL cl_set_comp_visible("lbl_preb005", FALSE)
         CALL cl_set_comp_visible("lbl_preb006", FALSE)
         CALL cl_set_comp_visible("lbl_preb007", FALSE)
         CALL cl_set_comp_visible("lbl_preb008", FALSE)
         CALL cl_set_comp_visible("preb003_1", FALSE)
         CALL cl_set_comp_visible("preb004_1", FALSE)
         CALL cl_set_comp_visible("preb005_1", FALSE)
         CALL cl_set_comp_visible("preb006_1", FALSE)
         CALL cl_set_comp_visible("preb007_1", FALSE)
         CALL cl_set_comp_visible("preb008_1", FALSE) 
         
      ELSE
         CALL cl_set_comp_visible("page_5", FALSE)
         CALL cl_set_comp_visible("lbl_preb003", TRUE)
         CALL cl_set_comp_visible("lbl_preb004", TRUE)
         CALL cl_set_comp_visible("lbl_preb005", TRUE)
         CALL cl_set_comp_visible("lbl_preb006", TRUE)
         CALL cl_set_comp_visible("lbl_preb007", TRUE)
         CALL cl_set_comp_visible("lbl_preb008", TRUE)
         CALL cl_set_comp_visible("preb003_1", TRUE)
         CALL cl_set_comp_visible("preb004_1", TRUE)
         CALL cl_set_comp_visible("preb005_1", TRUE)
         CALL cl_set_comp_visible("preb006_1", TRUE)
         CALL cl_set_comp_visible("preb007_1", TRUE)
         CALL cl_set_comp_visible("preb008_1", TRUE)          
      END IF

      #end add-point 
      
      #保存單頭舊值(用於資料輸入錯誤還原預設值時使用)
      LET g_prea_m_t.* = g_prea_m.*
      LET g_prea_m_o.* = g_prea_m.*
      
      #顯示狀態(stus)圖片
            #應用 a21 樣板自動產生(Version:3)
	  #根據當下狀態碼顯示圖片
      CASE g_prea_m.preastus 
         WHEN "N"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/unconfirmed.png")
         WHEN "Y"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/confirmed.png")
         WHEN "A"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/approved.png")
         WHEN "D"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/withdraw.png")
         WHEN "R"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/rejection.png")
         WHEN "W"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/signing.png")
         WHEN "X"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/invalid.png")
         
      END CASE
 
 
 
    
      CALL aprt310_input("a")
      
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
         INITIALIZE g_prea_m.* TO NULL
         INITIALIZE g_prec_d TO NULL
         INITIALIZE g_prec2_d TO NULL
         INITIALIZE g_prec3_d TO NULL
         INITIALIZE g_prec4_d TO NULL
 
         #add-point:取消新增後 name="insert.cancel"
         
         #end add-point 
         CALL aprt310_show()
         RETURN
      END IF
      
      LET INT_FLAG = 0
      #CALL g_prec_d.clear()
      #CALL g_prec2_d.clear()
      #CALL g_prec3_d.clear()
      #CALL g_prec4_d.clear()
 
 
      LET g_rec_b = 0
      CALL s_transaction_end('Y','0')
      EXIT WHILE
        
   END WHILE
   
   #根據資料狀態切換action狀態
   CALL cl_set_act_visible("statechange,modify,modify_detail,delete,reproduce", TRUE)
   CALL aprt310_set_act_visible()   
   CALL aprt310_set_act_no_visible()
   
   #將新增的資料併入搜尋條件中
   LET g_preadocno_t = g_prea_m.preadocno
 
   
   #組合新增資料的條件
   LET g_add_browse = " preaent = " ||g_enterprise|| " AND",
                      " preadocno = '", g_prea_m.preadocno, "' "
 
                      
   #add-point:組合新增資料的條件後 name="insert.after.add_browse"
   
   #end add-point
      
   #填到最後面
   LET g_current_idx = g_browser.getLength() + 1
   CALL aprt310_browser_fill("")
   
   DISPLAY g_browser_cnt TO FORMONLY.h_count    #總筆數
   DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
   CALL cl_navigator_setting(g_current_idx, g_browser_cnt)
   
   CLOSE aprt310_cl
   
   CALL aprt310_idx_chk()
   
   #撈取異動後的資料(主要是帶出reference)
   EXECUTE aprt310_master_referesh USING g_prea_m.preadocno INTO g_prea_m.preasite,g_prea_m.preadocdt, 
       g_prea_m.preadocno,g_prea_m.prea000,g_prea_m.preaunit,g_prea_m.prea001,g_prea_m.prea002,g_prea_m.preaacti, 
       g_prea_m.preastus,g_prea_m.prea003,g_prea_m.prea004,g_prea_m.prea052,g_prea_m.prea005,g_prea_m.prea006, 
       g_prea_m.prea051,g_prea_m.prea008,g_prea_m.prea007,g_prea_m.prea009,g_prea_m.prea010,g_prea_m.prea013, 
       g_prea_m.prea050,g_prea_m.prea011,g_prea_m.prea012,g_prea_m.prea014,g_prea_m.prea015,g_prea_m.preaownid, 
       g_prea_m.preaowndp,g_prea_m.preacrtid,g_prea_m.preacrtdp,g_prea_m.preacrtdt,g_prea_m.preamodid, 
       g_prea_m.preamoddt,g_prea_m.preacnfid,g_prea_m.preacnfdt,g_prea_m.preapstid,g_prea_m.preapstdt, 
       g_prea_m.prea003_desc,g_prea_m.prea006_desc,g_prea_m.prea008_desc,g_prea_m.prea007_desc,g_prea_m.prea009_desc, 
       g_prea_m.prea010_desc,g_prea_m.prea011_desc,g_prea_m.prea012_desc,g_prea_m.preaownid_desc,g_prea_m.preaowndp_desc, 
       g_prea_m.preacrtid_desc,g_prea_m.preacrtdp_desc,g_prea_m.preamodid_desc,g_prea_m.preacnfid_desc, 
       g_prea_m.preapstid_desc
   
   
   #遮罩相關處理
   LET g_prea_m_mask_o.* =  g_prea_m.*
   CALL aprt310_prea_t_mask()
   LET g_prea_m_mask_n.* =  g_prea_m.*
   
   #將資料顯示到畫面上
   DISPLAY BY NAME g_prea_m.preasite,g_prea_m.preasite_desc,g_prea_m.preadocdt,g_prea_m.preadocno,g_prea_m.prea000, 
       g_prea_m.preaunit,g_prea_m.prea001,g_prea_m.prea002,g_prea_m.preal002,g_prea_m.preaacti,g_prea_m.preastus, 
       g_prea_m.prea003,g_prea_m.prea003_desc,g_prea_m.prea004,g_prea_m.prea052,g_prea_m.prea005,g_prea_m.prea006, 
       g_prea_m.prea006_desc,g_prea_m.preb003_1,g_prea_m.preb004_1,g_prea_m.prea051,g_prea_m.prea008, 
       g_prea_m.prea008_desc,g_prea_m.prea007,g_prea_m.prea007_desc,g_prea_m.prea009,g_prea_m.prea009_desc, 
       g_prea_m.prea010,g_prea_m.prea010_desc,g_prea_m.preb005_1,g_prea_m.preb006_1,g_prea_m.prea013, 
       g_prea_m.prea050,g_prea_m.prea011,g_prea_m.prea011_desc,g_prea_m.prea012,g_prea_m.prea012_desc, 
       g_prea_m.prea014,g_prea_m.prea015,g_prea_m.preb007_1,g_prea_m.preb008_1,g_prea_m.preaownid,g_prea_m.preaownid_desc, 
       g_prea_m.preaowndp,g_prea_m.preaowndp_desc,g_prea_m.preacrtid,g_prea_m.preacrtid_desc,g_prea_m.preacrtdp, 
       g_prea_m.preacrtdp_desc,g_prea_m.preacrtdt,g_prea_m.preamodid,g_prea_m.preamodid_desc,g_prea_m.preamoddt, 
       g_prea_m.preacnfid,g_prea_m.preacnfid_desc,g_prea_m.preacnfdt,g_prea_m.preapstid,g_prea_m.preapstid_desc, 
       g_prea_m.preapstdt
   
   #add-point:新增結束後 name="insert.after"
   
   #end add-point 
   
   LET g_data_owner = g_prea_m.preaownid      
   LET g_data_dept  = g_prea_m.preaowndp
   
   #功能已完成,通報訊息中心
   CALL aprt310_msgcentre_notify('insert')
   
END FUNCTION
 
{</section>}
 
{<section id="aprt310.modify" >}
#+ 資料修改
PRIVATE FUNCTION aprt310_modify()
   #add-point:modify段define(客製用) name="modify.define_customerization"
   
   #end add-point    
   DEFINE l_new_key    DYNAMIC ARRAY OF STRING
   DEFINE l_old_key    DYNAMIC ARRAY OF STRING
   DEFINE l_field_key  DYNAMIC ARRAY OF STRING
   DEFINE l_wc2_table1          STRING
   DEFINE l_wc2_table2   STRING
 
   DEFINE l_wc2_table3   STRING
 
 
 
   #add-point:modify段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="modify.define"
   
   #end add-point    
   
   #add-point:Function前置處理  name="modify.pre_function"
   
   #end add-point
   
   #保存單頭舊值
   LET g_prea_m_t.* = g_prea_m.*
   LET g_prea_m_o.* = g_prea_m.*
   
   IF g_prea_m.preadocno IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code = "std-00003" 
      LET g_errparam.popup = FALSE 
      CALL cl_err()
      RETURN
   END IF
 
   ERROR ""
  
   LET g_preadocno_t = g_prea_m.preadocno
 
   CALL s_transaction_begin()
   
   OPEN aprt310_cl USING g_enterprise,g_prea_m.preadocno
   IF SQLCA.SQLCODE THEN   #(ver:78)
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "OPEN aprt310_cl:",SQLERRMESSAGE 
      LET g_errparam.code = SQLCA.SQLCODE   #(ver:78)
      LET g_errparam.popup = TRUE 
      CLOSE aprt310_cl
      CALL s_transaction_end('N','0')
      CALL cl_err()
      RETURN
   END IF
 
   #顯示最新的資料
   EXECUTE aprt310_master_referesh USING g_prea_m.preadocno INTO g_prea_m.preasite,g_prea_m.preadocdt, 
       g_prea_m.preadocno,g_prea_m.prea000,g_prea_m.preaunit,g_prea_m.prea001,g_prea_m.prea002,g_prea_m.preaacti, 
       g_prea_m.preastus,g_prea_m.prea003,g_prea_m.prea004,g_prea_m.prea052,g_prea_m.prea005,g_prea_m.prea006, 
       g_prea_m.prea051,g_prea_m.prea008,g_prea_m.prea007,g_prea_m.prea009,g_prea_m.prea010,g_prea_m.prea013, 
       g_prea_m.prea050,g_prea_m.prea011,g_prea_m.prea012,g_prea_m.prea014,g_prea_m.prea015,g_prea_m.preaownid, 
       g_prea_m.preaowndp,g_prea_m.preacrtid,g_prea_m.preacrtdp,g_prea_m.preacrtdt,g_prea_m.preamodid, 
       g_prea_m.preamoddt,g_prea_m.preacnfid,g_prea_m.preacnfdt,g_prea_m.preapstid,g_prea_m.preapstdt, 
       g_prea_m.prea003_desc,g_prea_m.prea006_desc,g_prea_m.prea008_desc,g_prea_m.prea007_desc,g_prea_m.prea009_desc, 
       g_prea_m.prea010_desc,g_prea_m.prea011_desc,g_prea_m.prea012_desc,g_prea_m.preaownid_desc,g_prea_m.preaowndp_desc, 
       g_prea_m.preacrtid_desc,g_prea_m.preacrtdp_desc,g_prea_m.preamodid_desc,g_prea_m.preacnfid_desc, 
       g_prea_m.preapstid_desc
   
   #檢查是否允許此動作
   IF NOT aprt310_action_chk() THEN
      CALL s_transaction_end('N','0')
      RETURN
   END IF
   
   #遮罩相關處理
   LET g_prea_m_mask_o.* =  g_prea_m.*
   CALL aprt310_prea_t_mask()
   LET g_prea_m_mask_n.* =  g_prea_m.*
   
   
   
   #add-point:modify段show之前 name="modify.before_show"
   
   #end add-point  
   
   #LET l_wc2_table1 = g_wc2_table1
   #LET g_wc2_table1 = " 1=1"
   #LET l_wc2_table2 = g_wc2_table2
   #LET l_wc2_table2 = " 1=1"
 
   #LET l_wc2_table3 = g_wc2_table3
   #LET l_wc2_table3 = " 1=1"
 
 
 
   
   CALL aprt310_show()
   #add-point:modify段show之後 name="modify.after_show"
   
   #end add-point
   
   #LET g_wc2_table1 = l_wc2_table1
   #LET  g_wc2_table2 = l_wc2_table2 
 
   #LET  g_wc2_table3 = l_wc2_table3 
 
 
 
    
   WHILE TRUE
      LET g_preadocno_t = g_prea_m.preadocno
 
      
      #寫入修改者/修改日期資訊(單頭)
      LET g_prea_m.preamodid = g_user 
LET g_prea_m.preamoddt = cl_get_current()
LET g_prea_m.preamodid_desc = cl_get_username(g_prea_m.preamodid)
      
      #add-point:modify段修改前 name="modify.before_input"
      #160604-00001#1 -s by 08172
      #「D抽單 / R已拒絕」狀況碼更改資料後，需還原為「N未確認」
      IF g_prea_m.preastus MATCHES "[DR]" THEN 
         LET g_prea_m.preastus = "N"
      END IF
      #160604-00001#1 -e by 08172
      #end add-point
      
      #欄位更改
      LET g_loc = 'n'
      LET g_update = FALSE
      LET g_master_commit = "N"
      CALL aprt310_input("u")
      LET g_loc = 'n'
 
      #add-point:modify段修改後 name="modify.after_input"
      
      #end add-point
      
      IF g_update OR NOT INT_FLAG THEN
         #若有modid跟moddt則進行update
         UPDATE prea_t SET (preamodid,preamoddt) = (g_prea_m.preamodid,g_prea_m.preamoddt)
          WHERE preaent = g_enterprise AND preadocno = g_preadocno_t
 
      END IF
    
      IF INT_FLAG THEN
         CALL s_transaction_end('N','0')
         LET INT_FLAG = 0
         #若單頭無commit則還原
         IF g_master_commit = "N" THEN
            LET g_prea_m.* = g_prea_m_t.*
            CALL aprt310_show()
         END IF
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = '' 
         LET g_errparam.code = 9001 
         LET g_errparam.popup = FALSE 
         CALL cl_err()
         RETURN
      END IF 
                  
      #若單頭key欄位有變更
      IF g_prea_m.preadocno != g_prea_m_t.preadocno
 
      THEN
         CALL s_transaction_begin()
         
         #add-point:單身fk修改前 name="modify.body.b_fk_update"
         
         #end add-point
         
         #更新單身key值
         UPDATE prec_t SET precdocno = g_prea_m.preadocno
 
          WHERE precent = g_enterprise AND precdocno = g_prea_m_t.preadocno
 
            
         #add-point:單身fk修改中 name="modify.body.m_fk_update"
         
         #end add-point
 
         CASE
            WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
            #   INITIALIZE g_errparam TO NULL 
            #   LET g_errparam.extend = "prec_t" 
            #   LET g_errparam.code = "std-00009" 
            #   LET g_errparam.popup = TRUE 
            #   CALL cl_err()
            #   CALL s_transaction_end('N','0')
            #   CONTINUE WHILE
            WHEN SQLCA.SQLCODE #其他錯誤
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "prec_t:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE 
               LET g_errparam.popup = TRUE 
               CALL s_transaction_end('N','0')
               CALL cl_err()
               CONTINUE WHILE
         END CASE
         
         #add-point:單身fk修改後 name="modify.body.a_fk_update"
         
         #end add-point
         
         #更新單身key值
         #add-point:單身fk修改前 name="modify.body.b_fk_update2"
         
         #end add-point
         
         UPDATE pred_t
            SET preddocno = g_prea_m.preadocno
 
          WHERE predent = g_enterprise AND
                preddocno = g_preadocno_t
 
         #add-point:單身fk修改中 name="modify.body.m_fk_update2"
         
         #end add-point
         CASE
            WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
            #   INITIALIZE g_errparam TO NULL 
            #   LET g_errparam.extend = "pred_t" 
            #   LET g_errparam.code = "std-00009" 
            #   LET g_errparam.popup = TRUE 
            #   CALL cl_err()
            #   CALL s_transaction_end('N','0')
            #   CONTINUE WHILE
            WHEN SQLCA.SQLCODE #其他錯誤
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "pred_t:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE 
               LET g_errparam.popup = TRUE 
               CALL s_transaction_end('N','0')
               CALL cl_err()
               CONTINUE WHILE
         END CASE
         #add-point:單身fk修改後 name="modify.body.a_fk_update2"
         
         #end add-point
 
         #更新單身key值
         #add-point:單身fk修改前 name="modify.body.b_fk_update3"
         
         #end add-point
         
         UPDATE preb_t
            SET prebdocno = g_prea_m.preadocno
 
          WHERE prebent = g_enterprise AND
                prebdocno = g_preadocno_t
 
         #add-point:單身fk修改中 name="modify.body.m_fk_update3"
         
         #end add-point
         CASE
            WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
            #   INITIALIZE g_errparam TO NULL 
            #   LET g_errparam.extend = "preb_t" 
            #   LET g_errparam.code = "std-00009" 
            #   LET g_errparam.popup = TRUE 
            #   CALL cl_err()
            #   CALL s_transaction_end('N','0')
            #   CONTINUE WHILE
            WHEN SQLCA.SQLCODE #其他錯誤
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "preb_t:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE 
               LET g_errparam.popup = TRUE 
               CALL s_transaction_end('N','0')
               CALL cl_err()
               CONTINUE WHILE
         END CASE
         #add-point:單身fk修改後 name="modify.body.a_fk_update3"
         
         #end add-point
 
 
         
 
         
         #UPDATE 多語言table key值
         
         
         
         
 
         CALL s_transaction_end('Y','0')
      END IF
    
      EXIT WHILE
   END WHILE
 
   #根據資料狀態切換action狀態
   CALL cl_set_act_visible("statechange,modify,modify_detail,delete,reproduce", TRUE)
   CALL aprt310_set_act_visible()   
   CALL aprt310_set_act_no_visible()
 
   #組合新增資料的條件
   LET g_add_browse = " preaent = " ||g_enterprise|| " AND",
                      " preadocno = '", g_prea_m.preadocno, "' "
 
   #填到對應位置
   CALL aprt310_browser_fill("")
 
   CLOSE aprt310_cl
   
   CALL s_transaction_end('Y','0')
 
   #功能已完成,通報訊息中心
   CALL aprt310_msgcentre_notify('modify')
 
END FUNCTION 
 
{</section>}
 
{<section id="aprt310.input" >}
#+ 資料輸入
PRIVATE FUNCTION aprt310_input(p_cmd)
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
   DEFINE  l_success             LIKE type_t.num5
   DEFINE  l_errno               LIKE type_t.chr10
   DEFINE  l_n1                  LIKE type_t.num5
   DEFINE  l_prea001             LIKE prea_t.prea001
   DEFINE  l_prcf030             LIKE prcf_t.prcf030
   DEFINE  l_inaa135             LIKE inaa_t.inaa135
   DEFINE  l_ooef004             LIKE ooef_t.ooef004
   DEFINE  l_numprea002          LIKE type_t.num5   
   DEFINE  l_prcf009             LIKE prcf_t.prcf009
   DEFINE  l_prcf010             LIKE prcf_t.prcf010
   DEFINE  l_prcf053             LIKE prcf_t.prcf053
   DEFINE  l_prcf054             LIKE prcf_t.prcf054  
   DEFINE  l_inaa141             LIKE inaa_t.inaa141
   DEFINE  l_stfa001             LIKE stfa_t.stfa001   
   #add--2015/07/30 By shiun--(S)
   DEFINE l_oofg_return    DYNAMIC ARRAY OF RECORD
                   oofg019     LIKE oofg_t.oofg019,   #field
                   oofg020     LIKE oofg_t.oofg020    #value
                           END RECORD
   #add--2015/07/30 By shiun--(E)
   DEFINE l_flag                LIKE type_t.chr1
   DEFINE l_prec060             LIKE prec_t.prec060
   DEFINE l_pred004             LIKE pred_t.pred004
   DEFINE l_stfa019             LIKE stfa_t.stfa019
   DEFINE l_stfa017             LIKE stfa_t.stfa017
   DEFINE l_oocq009             LIKE oocq_t.oocq009
   DEFINE l_prec010             LIKE prec_t.prec010
   DEFINE l_num20               LIKE prec_t.prec009   #151202-00007#1-----add
   DEFINE l_num20_2             LIKE prec_t.prec009   #151202-00007#1-----add   
   DEFINE l_countrtdx025        LIKE type_t.num5      #lanjj add on 2016-09-07
   DEFINE rtdx025_n             LIKE rtdx_t.rtdx025   #lanjj add on 2016-10-24
   DEFINE l_stfc019_1           LIKE stfc_t.stfc019   #lanjj add on 2016-10-24
   DEFINE l_preb003_1           LIKE preb_t.preb003   #lanjj add on 2016-10-24

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
   DISPLAY BY NAME g_prea_m.preasite,g_prea_m.preasite_desc,g_prea_m.preadocdt,g_prea_m.preadocno,g_prea_m.prea000, 
       g_prea_m.preaunit,g_prea_m.prea001,g_prea_m.prea002,g_prea_m.preal002,g_prea_m.preaacti,g_prea_m.preastus, 
       g_prea_m.prea003,g_prea_m.prea003_desc,g_prea_m.prea004,g_prea_m.prea052,g_prea_m.prea005,g_prea_m.prea006, 
       g_prea_m.prea006_desc,g_prea_m.preb003_1,g_prea_m.preb004_1,g_prea_m.prea051,g_prea_m.prea008, 
       g_prea_m.prea008_desc,g_prea_m.prea007,g_prea_m.prea007_desc,g_prea_m.prea009,g_prea_m.prea009_desc, 
       g_prea_m.prea010,g_prea_m.prea010_desc,g_prea_m.preb005_1,g_prea_m.preb006_1,g_prea_m.prea013, 
       g_prea_m.prea050,g_prea_m.prea011,g_prea_m.prea011_desc,g_prea_m.prea012,g_prea_m.prea012_desc, 
       g_prea_m.prea014,g_prea_m.prea015,g_prea_m.preb007_1,g_prea_m.preb008_1,g_prea_m.preaownid,g_prea_m.preaownid_desc, 
       g_prea_m.preaowndp,g_prea_m.preaowndp_desc,g_prea_m.preacrtid,g_prea_m.preacrtid_desc,g_prea_m.preacrtdp, 
       g_prea_m.preacrtdp_desc,g_prea_m.preacrtdt,g_prea_m.preamodid,g_prea_m.preamodid_desc,g_prea_m.preamoddt, 
       g_prea_m.preacnfid,g_prea_m.preacnfid_desc,g_prea_m.preacnfdt,g_prea_m.preapstid,g_prea_m.preapstid_desc, 
       g_prea_m.preapstdt
   
   #切換畫面
 
   CALL cl_set_head_visible("","YES")  
 
   LET l_insert = FALSE
   LET g_action_choice = ""
 
   #add-point:input段define_sql name="input.define_sql"
   
   #end add-point 
   LET g_forupd_sql = "SELECT precacti,precseq,prec003,prec004,prec005,prec006,prec007,prec008,prec009, 
       prec010,prec011,prec012,prec013,prec014,prec015,prec016,prec017,prec018,prec019,prec020,prec021, 
       prec022,prec023,prec024,prec025,prec026,prec027,prec028,prec029,prec030,prec031,prec032,prec033, 
       prec034,prec035,prec036,prec037,prec038,prec039,prec040,prec041,prec042,prec043,prec044,prec045, 
       prec098,prec046,prec047,prec048,prec049,prec050,prec051,prec052,prec053,prec054,prec055,prec056, 
       prec057,prec058,prec059,prec060,prec061,prec062,prec063,prec064,prec065,prec066,prec067,prec068, 
       prec069,prec070,prec071,prec072,prec073,prec074,prec075,prec078,prec079,prec081,prec001,precseq, 
       prec080,prec082,prec083,prec084,prec085,prec086,prec087,prec088,prec089,prec090,prec091,prec092, 
       prec093,prec094,prec095,prec096,prec097,precunit,precsite FROM prec_t WHERE precent=? AND precdocno=?  
       AND precseq=? FOR UPDATE"
   #add-point:input段define_sql name="input.after_define_sql"
   
   #end add-point 
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE aprt310_bcl CURSOR FROM g_forupd_sql
   
   #add-point:input段define_sql name="input.define_sql2"
   
   #end add-point    
   LET g_forupd_sql = "SELECT predacti,predseq1,pred001,pred002,pred003,predseq,pred004,pred006,pred005, 
       pred007,predsite,predunit FROM pred_t WHERE predent=? AND preddocno=? AND predseq=? AND predseq1=?  
       FOR UPDATE"
   #add-point:input段define_sql name="input.after_define_sql2"
   
   #end add-point
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE aprt310_bcl2 CURSOR FROM g_forupd_sql
 
   #add-point:input段define_sql name="input.define_sql3"
   
   #end add-point    
   LET g_forupd_sql = "SELECT preb002,preb003,preb004,preb005,preb006,preb007,preb008,prebacti,prebsite, 
       prebunit,preb001 FROM preb_t WHERE prebent=? AND prebdocno=? AND preb002=? FOR UPDATE"
   #add-point:input段define_sql name="input.after_define_sql3"
   
   #end add-point
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE aprt310_bcl3 CURSOR FROM g_forupd_sql
 
 
   
 
 
   #add-point:input段define_sql name="input.other_sql"
   
   #end add-point 
 
   LET l_allow_insert = cl_auth_detail_input("insert")
   LET l_allow_delete = cl_auth_detail_input("delete")
   LET g_qryparam.state = 'i'
   
   #控制key欄位可否輸入
   CALL aprt310_set_entry(p_cmd)
   #add-point:set_entry後 name="input.after_set_entry"
   
   #end add-point
   CALL aprt310_set_no_entry(p_cmd)
 
   DISPLAY BY NAME g_prea_m.preasite,g_prea_m.preadocdt,g_prea_m.preadocno,g_prea_m.prea000,g_prea_m.preaunit, 
       g_prea_m.prea001,g_prea_m.prea002,g_prea_m.preal002,g_prea_m.preaacti,g_prea_m.preastus,g_prea_m.prea003, 
       g_prea_m.prea004,g_prea_m.prea052,g_prea_m.prea005,g_prea_m.prea006,g_prea_m.preb003_1,g_prea_m.preb004_1, 
       g_prea_m.prea051,g_prea_m.prea008,g_prea_m.prea007,g_prea_m.prea009,g_prea_m.prea010,g_prea_m.preb005_1, 
       g_prea_m.preb006_1,g_prea_m.prea013,g_prea_m.prea050,g_prea_m.prea011,g_prea_m.prea012,g_prea_m.prea014, 
       g_prea_m.prea015,g_prea_m.preb007_1,g_prea_m.preb008_1
   
   LET lb_reproduce = FALSE
   LET l_ac_t = 1
   
   #關閉被遮罩相關欄位輸入, 無法確定USER是否會需要輸入此欄位
   #因此先行關閉, 若有需要可於下方add-point中自行開啟
   CALL cl_mask_set_no_entry()
   
   #add-point:資料輸入前 name="input.before_input"
   
   #end add-point
   
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
 
{</section>}
 
{<section id="aprt310.input.head" >}
      #單頭段
      INPUT BY NAME g_prea_m.preasite,g_prea_m.preadocdt,g_prea_m.preadocno,g_prea_m.prea000,g_prea_m.preaunit, 
          g_prea_m.prea001,g_prea_m.prea002,g_prea_m.preal002,g_prea_m.preaacti,g_prea_m.preastus,g_prea_m.prea003, 
          g_prea_m.prea004,g_prea_m.prea052,g_prea_m.prea005,g_prea_m.prea006,g_prea_m.preb003_1,g_prea_m.preb004_1, 
          g_prea_m.prea051,g_prea_m.prea008,g_prea_m.prea007,g_prea_m.prea009,g_prea_m.prea010,g_prea_m.preb005_1, 
          g_prea_m.preb006_1,g_prea_m.prea013,g_prea_m.prea050,g_prea_m.prea011,g_prea_m.prea012,g_prea_m.prea014, 
          g_prea_m.prea015,g_prea_m.preb007_1,g_prea_m.preb008_1 
         ATTRIBUTE(WITHOUT DEFAULTS)
         
         #自訂ACTION(master_input)
         
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION update_item
            LET g_action_choice="update_item"
            IF cl_auth_chk_act("update_item") THEN
               
               #add-point:ON ACTION update_item name="input.master_input.update_item"
               
               #add-point:ON ACTION update_item
            CALL n_preal(g_prea_m.preadocno)
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_prea_m.preadocno
            CALL ap_ref_array2(g_ref_fields," SELECT preal002 FROM preal_t WHERE prealent = '"
                ||g_enterprise||"' AND prealdocno = ? AND preal001 = '"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_prea_m.preal002 = g_rtn_fields[1]
            DISPLAY BY NAME g_prea_m.preal002
               #END add-point
            END IF
 
 
 
 
     
         BEFORE INPUT
            IF s_transaction_chk("N",0) THEN
               CALL s_transaction_begin()
            END IF
            OPEN aprt310_cl USING g_enterprise,g_prea_m.preadocno
            IF SQLCA.SQLCODE THEN   #(ver:78)
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "OPEN aprt310_cl:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE   #(ver:78)
               LET g_errparam.popup = TRUE 
               CLOSE aprt310_cl
               CALL s_transaction_end('N','0')
               CALL cl_err()
               RETURN
            END IF
            LET g_master_multi_table_t.prealdocno = g_prea_m.preadocno
LET g_master_multi_table_t.preal002 = g_prea_m.preal002
 
            IF l_cmd_t = 'r' THEN
               LET g_master_multi_table_t.prealdocno = ''
LET g_master_multi_table_t.preal002 = ''
 
            END IF
            #因應離開單頭後已寫入資料庫, 若重新回到單頭則視為修改
            #因此需於此處開啟/關閉欄位
            CALL aprt310_set_entry(p_cmd)
            #add-point:資料輸入前 name="input.m.before_input"
#huangrh-----add---按照顾问要求，把此代码拿到BEFORE INPUT-----begin--20150902---
            IF g_prea_m.prea000 = 'I' AND p_cmd = 'a' AND cl_null(g_prea_m.prea001) THEN
               LET l_n1 = 0
               SELECT COUNT(*) INTO l_n1
                 FROM oofg_t
                WHERE oofgent = g_enterprise
                  AND oofg002 = '23'
                  AND oofgstus = 'Y'
               IF l_n1 > 0 THEN
                  CALL s_aooi390_gen('23') RETURNING l_success,g_prea_m.prea001,l_oofg_return
               END IF
               LET g_prea_m.prea002 = 1
               
            END IF
#huangrh-----add---按照顾问要求，把此代码拿到BEFORE INPUT-----end--20150902---            
            #end add-point
            CALL aprt310_set_no_entry(p_cmd)
    
                  #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD preasite
            
            #add-point:AFTER FIELD preasite name="input.a.preasite"
            IF NOT cl_null(g_prea_m.preasite) THEN
               CALL s_aooi500_chk(g_prog,'preasite',g_prea_m.preasite,g_prea_m.preasite)
                  RETURNING l_success,l_errno
               IF NOT l_success THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.extend = ''
                  LET g_errparam.code   = l_errno
                  LET g_errparam.popup  = TRUE
                  CALL cl_err()            
                  LET g_prea_m.preasite = g_prea_m_t.preasite
                  NEXT FIELD CURRENT
               END IF
            ELSE
               INITIALIZE g_errparam TO NULL
               LET g_errparam.extend = ''
               LET g_errparam.code   = 'axc-00120'
               LET g_errparam.popup  = TRUE
               CALL cl_err()               
               LET g_prea_m.preasite = g_prea_m_t.preasite
               NEXT FIELD CURRENT 
            END IF                              
            
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_prea_m.preasite
            CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_prea_m.preasite_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_prea_m.preasite_desc
            LET g_site_flag = TRUE                 #161101-00022#1--ADD
            CALL aprt310_set_entry(p_cmd)
            CALL aprt310_set_no_entry(p_cmd) 
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD preasite
            #add-point:BEFORE FIELD preasite name="input.b.preasite"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE preasite
            #add-point:ON CHANGE preasite name="input.g.preasite"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD preadocdt
            #add-point:BEFORE FIELD preadocdt name="input.b.preadocdt"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD preadocdt
            
            #add-point:AFTER FIELD preadocdt name="input.a.preadocdt"
            IF  NOT cl_null(g_prea_m.preadocdt) THEN 
               IF p_cmd = 'a' OR ( p_cmd = 'u' AND (g_prea_m.preadocdt != g_prea_m_t.preadocdt )) THEN
                  IF NOT cl_null(g_prea_m.prea014) THEN                 
                     IF g_prea_m.prea014 > g_prea_m.preadocdt THEN    
                        INITIALIZE g_errparam TO NULL
                        LET g_errparam.extend = ''
                        LET g_errparam.code   = 'apr-00380'
                        LET g_errparam.popup  = TRUE
                        CALL cl_err()            
                        LET g_prea_m.preadocdt = g_prea_m_t.preadocdt
                        NEXT FIELD CURRENT
                     END IF
                  END IF

               END IF
            END IF
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE preadocdt
            #add-point:ON CHANGE preadocdt name="input.g.preadocdt"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD preadocno
            #add-point:BEFORE FIELD preadocno name="input.b.preadocno"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD preadocno
            
            #add-point:AFTER FIELD preadocno name="input.a.preadocno"
            #應用 a05 樣板自動產生(Version:2)
            #確認資料無重複
            IF  NOT cl_null(g_prea_m.preadocno) THEN 
               IF p_cmd = 'a' OR ( p_cmd = 'u' AND (g_prea_m.preadocno != g_preadocno_t )) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM prea_t WHERE "||"preaent = '" ||g_enterprise|| "' AND "||"preadocno = '"||g_prea_m.preadocno ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
               CALL s_aooi200_chk_docno(g_prea_m.preasite,g_prea_m.preadocno,g_prea_m.preadocdt,g_prog) RETURNING l_success 
               IF NOT l_success THEN
                  LET g_prea_m.preadocno = g_preadocno_t
                  NEXT FIELD CURRENT
               END IF               
            END IF

            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE preadocno
            #add-point:ON CHANGE preadocno name="input.g.preadocno"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prea000
            #add-point:BEFORE FIELD prea000 name="input.b.prea000"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prea000
            
            #add-point:AFTER FIELD prea000 name="input.a.prea000"
            IF NOT cl_null(g_prea_m.prea000) THEN
               IF p_cmd = 'a' OR ( p_cmd = 'u' AND (g_prea_m.prea000 != g_prea_m_t.prea000 )) THEN 
                  IF g_prea_m.prea000 != g_prea_m_o.prea000 OR cl_null(g_prea_m_o.prea000) THEN
                     CALL aprt310_prea000_init()
                  END IF
               END IF
               IF g_prea_m.prea000 = 'I' THEN
                  LET g_prea_m.prea002 = 1
               ELSE
                 IF NOT cl_null(g_prea_m.prea001) THEN
                    SELECT MAX(to_number(preg002)) +1 INTO l_numprea002
                      FROM preg_t
                     WHERE pregent = g_enterprise
                       AND preg001 = g_prea_m.prea001
                    IF cl_null(l_numprea002) THEN
                       LET g_prea_m.prea002 = 1
                    ELSE
                       LET g_prea_m.prea002 = l_numprea002
                    END IF
                 END IF
               END IF 
            END IF
            LET g_prea_m_o.* = g_prea_m.*
            CALL aprt310_set_entry(p_cmd)
            CALL aprt310_set_no_entry(p_cmd)
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE prea000
            #add-point:ON CHANGE prea000 name="input.g.prea000"
            CALL aprt310_set_entry(p_cmd)
            CALL aprt310_set_no_entry(p_cmd)
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD preaunit
            #add-point:BEFORE FIELD preaunit name="input.b.preaunit"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD preaunit
            
            #add-point:AFTER FIELD preaunit name="input.a.preaunit"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE preaunit
            #add-point:ON CHANGE preaunit name="input.g.preaunit"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prea001
            #add-point:BEFORE FIELD prea001 name="input.b.prea001"
#huangrh-----mark---按照顾问要求，mark，把此代码拿到BEFORE INPUT-----begin--20150902---
#            IF g_prea_m.prea000 = 'I' AND p_cmd = 'a' AND cl_null(g_prea_m.prea001) THEN
#               LET l_n1 = 0
#               SELECT COUNT(*) INTO l_n1
#                 FROM oofg_t
#                WHERE oofgent = g_enterprise
#                  AND oofg002 = '23'
#                  AND oofgstus = 'Y'
#               IF l_n1 > 0 THEN
#                  #modify--2015/07/30 By shiun--(S)
##                  CALL s_aooi390('23') RETURNING l_success,l_prea001
##                  LET g_action_choice = ''
##                  IF l_success THEN
##                     LET g_prea_m.prea001 = l_prea001
##                  END IF 
#                  CALL s_aooi390_gen('23') RETURNING l_success,g_prea_m.prea001,l_oofg_return
#                  #modify--2015/07/30 By shiun--(E)
#                  IF NOT cl_null(g_prea_m.prea001) THEN
#                     CALL aprt310_chk_prea001()
#                     IF NOT cl_null(g_errno) THEN
#                        INITIALIZE g_errparam TO NULL
#                        LET g_errparam.code = g_errno
#                        LET g_errparam.extend = g_prea_m.prea001
#                        LET g_errparam.popup = TRUE
#                        CALL cl_err()
#
#                        LET g_prea_m.prea001 = g_prea_m_t.prea001
#                        NEXT FIELD prea001
#                     END IF
#                  END IF
#               END IF
#            END IF
#huangrh-----mark---按照顾问要求，mark，把此代码拿到BEFORE INPUT-----end--20150902---
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prea001
            
            #add-point:AFTER FIELD prea001 name="input.a.prea001"
            IF NOT cl_null(g_prea_m.prea001) THEN
               IF p_cmd = 'a' OR ( p_cmd = 'u' AND (g_prea_m.prea001 != g_prea_m_t.prea001 )) THEN 
                  CALL aprt310_chk_prea001()
                  IF NOT cl_null(g_errno) THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = g_errno
                     LET g_errparam.extend = g_prea_m.prea001
                     LET g_errparam.popup = TRUE
                     CALL cl_err()

                     LET g_prea_m.prea001 = g_prea_m_t.prea001
                     NEXT FIELD prea001
                  END IF
                  
                  #add--2015/07/30 By shiun--(S)
                  IF NOT s_aooi390_chk('23',g_prea_m.prea001) THEN
                     LET g_prea_m.prea001 = g_prea_m_t.prea001
                     DISPLAY BY NAME g_prea_m.prea001
                     NEXT FIELD CURRENT
                  END IF
                  #add--2015/07/30 By shiun--(E)
                  
                  IF g_prea_m.prea000 = 'U' THEN
                     LET l_n1 = 0
                     SELECT COUNT(*) INTO l_n1
                       FROM prea_t
                      WHERE preaent = g_enterprise
                        AND prea001 = g_prea_m.prea001
                        AND preastus = 'N'
                     IF l_n1 > 0 THEN
                        INITIALIZE g_errparam TO NULL
                        LET g_errparam.code = 'apr-00262'
                        LET g_errparam.extend = g_prea_m.prea001
                        LET g_errparam.popup = TRUE
                        CALL cl_err()

                        LET g_prea_m.prea001 = g_prea_m_t.prea001
                        NEXT FIELD prea001
                     END IF  
                     IF g_prea_m.prea001 != g_prea_m_o.prea001 OR cl_null(g_prea_m_o.prea001) THEN
                        CALL aprt310_prea001_init()
                     END IF                     
                  END IF

               END IF
               IF g_prea_m.prea000 = 'U' THEN 
                  SELECT MAX(to_number(preg002)) +1 INTO l_numprea002
                    FROM preg_t
                   WHERE pregent = g_enterprise
                     AND preg001 = g_prea_m.prea001
                  IF cl_null(l_numprea002) THEN
                     LET g_prea_m.prea002 = 1
                  ELSE
                     LET g_prea_m.prea002 = l_numprea002
                  END IF
               ELSE
                  LET g_prea_m.prea002 = 1
               END IF
            END IF
            LET g_prea_m_o.* = g_prea_m.*
            CALL aprt310_set_entry(p_cmd)
            CALL aprt310_set_no_entry(p_cmd)
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE prea001
            #add-point:ON CHANGE prea001 name="input.g.prea001"
            CALL aprt310_set_entry(p_cmd)
            CALL aprt310_set_no_entry(p_cmd)
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prea002
            #add-point:BEFORE FIELD prea002 name="input.b.prea002"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prea002
            
            #add-point:AFTER FIELD prea002 name="input.a.prea002"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE prea002
            #add-point:ON CHANGE prea002 name="input.g.prea002"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD preal002
            #add-point:BEFORE FIELD preal002 name="input.b.preal002"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD preal002
            
            #add-point:AFTER FIELD preal002 name="input.a.preal002"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE preal002
            #add-point:ON CHANGE preal002 name="input.g.preal002"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD preaacti
            #add-point:BEFORE FIELD preaacti name="input.b.preaacti"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD preaacti
            
            #add-point:AFTER FIELD preaacti name="input.a.preaacti"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE preaacti
            #add-point:ON CHANGE preaacti name="input.g.preaacti"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD preastus
            #add-point:BEFORE FIELD preastus name="input.b.preastus"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD preastus
            
            #add-point:AFTER FIELD preastus name="input.a.preastus"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE preastus
            #add-point:ON CHANGE preastus name="input.g.preastus"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prea003
            
            #add-point:AFTER FIELD prea003 name="input.a.prea003"
            IF NOT cl_null(g_prea_m.prea003) THEN 
               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
               INITIALIZE g_chkparam.* TO NULL
               #設定g_chkparam.*的參數
               LET g_chkparam.arg1 = g_prea_m.prea003
               LET g_chkparam.arg2 = '3'
               #160318-00025#6--add--str
               LET g_errshow = TRUE 
#               LET g_chkparam.err_str[1] = "apr-00060:sub-01307|aprm201|",cl_get_progname("aprm201",g_lang,"2"),"|:EXEPROGaprm201"   #160523-00024#1
#               LET g_chkparam.err_str[2] = "apr-00059:sub-01302|aprm201|",cl_get_progname("aprm201",g_lang,"2"),"|:EXEPROGaprm201"   #160523-00024#1
               
               LET g_chkparam.err_str[1] = "apr-00060:sub-01307|",cl_get_progname("aprm300",g_lang,"2"),"|:EXEPROGaprm300"     #160523-00024#1
               LET g_chkparam.err_str[2] = "apr-00059:sub-01302|",cl_get_progname("aprm300",g_lang,"2"),"|:EXEPROGaprm300"     #160523-00024#1
               LET g_chkparam.err_str[3] = "apr-00058:apr-00522|",cl_get_progname("aprm300",g_lang,"2"),"|",cl_get_progname("aprm300",g_lang,"2"),"|:EXEPROGaprm300"     #160523-00024#1
               #160318-00025#6--add--end
               #呼叫檢查存在並帶值的library
               IF NOT cl_chk_exist("v_prcf001_1") THEN
                  #LET g_prea_m.prea003 = g_prea_m_t.prea003   #160824-00007#147 mark by beckxie
                  #160824-00007#147 add by beckxie---S
                  LET g_prea_m.prea003 = g_prea_m_o.prea003   
                  LET g_prea_m.prea007 = g_prea_m_o.prea007
                  LET g_prea_m.prea009 = g_prea_m_o.prea009
                  LET g_prea_m.prea010 = g_prea_m_o.prea010
                  LET g_prea_m.prea004 = g_prea_m_o.prea004
                  LET g_prea_m.prea005 = g_prea_m_o.prea005
                  LET g_prea_m.prea006 = g_prea_m_o.prea006
                  LET g_prea_m.prea006_desc = g_prea_m_o.prea006_desc
                  LET g_prea_m.prea007_desc = g_prea_m_o.prea007_desc
                  LET g_prea_m.prea009_desc = g_prea_m_o.prea009_desc
                  LET g_prea_m.prea010_desc = g_prea_m_o.prea010_desc
                  LET g_prea_m.preb003_1 = g_prea_m_o.preb003_1
                  LET g_prea_m.preb004_1 = g_prea_m_o.preb004_1
                  LET g_prea_m.preb005_1 = g_prea_m_o.preb005_1
                  LET g_prea_m.preb006_1 = g_prea_m_o.preb006_1
                  LET g_prea_m.prea014 = g_prea_m_o.prea014
                  LET g_prea_m.prea008 = g_prea_m_o.prea008
                  LET g_prea_m.prea009 = g_prea_m_o.prea009
                  DISPLAY BY NAME g_prea_m.prea003      ,g_prea_m.prea007  ,g_prea_m.prea009      ,g_prea_m.prea010      ,g_prea_m.prea004 ,
                                  g_prea_m.prea005      ,g_prea_m.prea006  ,g_prea_m.prea006_desc ,g_prea_m.prea007_desc ,g_prea_m.prea009_desc ,
                                  g_prea_m.prea010_desc ,g_prea_m.preb003_1,    g_prea_m.preb004_1,g_prea_m.preb005_1    ,g_prea_m.preb006_1,
                                  g_prea_m.prea014      ,g_prea_m.prea008  ,g_prea_m.prea009 
                  #160824-00007#147 add by beckxie---E
                  NEXT FIELD CURRENT
               END IF
               #IF p_cmd = 'a' OR ( p_cmd = 'u' AND (g_prea_m.prea003 != g_prea_m_t.prea003  )) THEN   #160824-00007#147 mark by beckxie
               IF (g_prea_m.prea003 != g_prea_m_o.prea003) OR cl_null(g_prea_m_o.prea003) THEN         #160824-00007#147 add by beckxie
                  SELECT prcf002,prcf007,prcf008,
                         prcf051,prcf055,prcf056,
                         prcf009,prcf010,prcf053,prcf054,prcf005
                    INTO g_prea_m.prea007,g_prea_m.prea009,g_prea_m.prea010,
                         g_prea_m.prea004,g_prea_m.prea005,g_prea_m.prea006,
                         g_prea_m.preb003_1,g_prea_m.preb004_1,g_prea_m.preb005_1,g_prea_m.preb006_1,g_prea_m.prea052  #160104-00012#2--add prea052
                    FROM prcf_t
                   WHERE prcfent = g_enterprise
                     AND prcf001 = g_prea_m.prea003
                  DISPLAY BY NAME g_prea_m.prea007,g_prea_m.prea009,g_prea_m.prea010,g_prea_m.prea004,g_prea_m.prea005,g_prea_m.prea006,g_prea_m.preb003_1,g_prea_m.preb004_1,g_prea_m.preb005_1,g_prea_m.preb006_1
                  IF g_prea_m.preb003_1>g_today THEN 
                     LET g_prea_m.prea014=g_prea_m.preb003_1
                     DISPLAY BY NAME g_prea_m.prea014   
                  END IF                  
                  IF g_prea_m.prea004<>'1' AND g_prea_m.prea004<>'2' THEN
                     LET g_prea_m.prea005='' 
                     LET g_prea_m.prea006=''
                     LET g_prea_m.prea006_desc=''
                     DISPLAY BY NAME g_prea_m.prea005,g_prea_m.prea006,g_prea_m.prea006_desc                  
                  END IF   
                  
               END IF
            ELSE
               IF cl_null(g_prea_m.prea007) THEN
                  LET g_prea_m.prea008 = ''
                  LET g_prea_m.prea009 = '' 
               END IF
            END IF             
        
            CALL aprt310_set_entry(p_cmd)
            CALL aprt310_set_no_entry(p_cmd)      
            
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_prea_m.prea003
            CALL ap_ref_array2(g_ref_fields,"SELECT prcfl003 FROM prcfl_t WHERE prcflent='"||g_enterprise||"' AND prcfl001=? AND prcfl002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_prea_m.prea003_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_prea_m.prea003_desc

            IF g_prea_m.prea005='1' THEN
               INITIALIZE g_ref_fields TO NULL
               LET g_ref_fields[1] = g_prea_m.prea006
               CALL ap_ref_array2(g_ref_fields,"SELECT mmanl003 FROM mmanl_t WHERE mmanlent='"||g_enterprise||"' AND mmanl001=? AND mmanl002='"||g_dlang||"'","") RETURNING g_rtn_fields
               LET g_prea_m.prea006_desc = '', g_rtn_fields[1] , ''
               DISPLAY BY NAME g_prea_m.prea006_desc                  
            END IF
            IF g_prea_m.prea005='2' THEN
             
               INITIALIZE g_ref_fields TO NULL
               LET g_ref_fields[1] = g_prea_m.prea006
               CALL ap_ref_array2(g_ref_fields,"SELECT gcafl003 FROM gcafl_t WHERE gcaflent='"||g_enterprise||"' AND gcafl001=? AND gcafl002='"||g_dlang||"'","") RETURNING g_rtn_fields
               LET g_prea_m.prea006_desc = '', g_rtn_fields[1] , ''
               DISPLAY BY NAME g_prea_m.prea006_desc                      
            END IF            

            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_prea_m.prea007
            CALL ap_ref_array2(g_ref_fields,"SELECT prcdl003 FROM prcdl_t WHERE prcdlent='"||g_enterprise||"' AND prcdl001=? AND prcdl002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_prea_m.prea007_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_prea_m.prea007_desc 
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_prea_m.prea009
            CALL ap_ref_array2(g_ref_fields,"SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001='2100' AND oocql002=? AND oocql003='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_prea_m.prea009_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_prea_m.prea009_desc
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_prea_m.prea010
            CALL ap_ref_array2(g_ref_fields,"SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001='2101' AND oocql002=? AND oocql003='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_prea_m.prea010_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_prea_m.prea010_desc
            LET g_prea_m_o.* = g_prea_m.* #160824-00007#147 add by beckxie
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prea003
            #add-point:BEFORE FIELD prea003 name="input.b.prea003"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE prea003
            #add-point:ON CHANGE prea003 name="input.g.prea003"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prea004
            #add-point:BEFORE FIELD prea004 name="input.b.prea004"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prea004
            
            #add-point:AFTER FIELD prea004 name="input.a.prea004"
            IF g_prea_m.prea004<>'1' AND g_prea_m.prea004<>'2' THEN
               LET g_prea_m.prea005='' 
               LET g_prea_m.prea006=''
               LET g_prea_m.prea006_desc=''
               DISPLAY BY NAME g_prea_m.prea005,g_prea_m.prea006,g_prea_m.prea006_desc                  
            END IF      
            #160104-00012#2----add---begin----by huangrh--20160107---
            #買送/買減/買換---滿額促銷
            #倍換---一般促銷
            #折扣---一般促銷或滿額促銷
            IF NOT cl_null(g_prea_m.prea004) THEN
               #買送/買減/買換---滿額促銷
               IF g_prea_m.prea004='1' OR g_prea_m.prea004='2' OR g_prea_m.prea004='3' THEN
                  LET g_prea_m.prea052='3'
               END IF
               #倍換---一般促銷
               IF g_prea_m.prea004='5' THEN
                  LET g_prea_m.prea052='1'
               END IF                           
            END IF
            #160104-00012#2----add--end ----by huangrh--20160107---             
            CALL aprt310_set_entry(p_cmd)
            CALL aprt310_set_no_entry(p_cmd) 
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE prea004
            #add-point:ON CHANGE prea004 name="input.g.prea004"
            IF g_prea_m.prea004<>'1' AND g_prea_m.prea004<>'2' THEN
               LET g_prea_m.prea005='' 
               LET g_prea_m.prea006=''
               LET g_prea_m.prea006_desc=''
               DISPLAY BY NAME g_prea_m.prea005,g_prea_m.prea006,g_prea_m.prea006_desc                  
            END IF    
            #160104-00012#2----add---begin----by huangrh--20160107---
            #買送/買減/買換---滿額促銷
            #倍換---一般促銷
            #折扣---一般促銷或滿額促銷
            IF NOT cl_null(g_prea_m.prea004) THEN
               #買送/買減/買換---滿額促銷
               IF g_prea_m.prea004='1' OR g_prea_m.prea004='2' OR g_prea_m.prea004='3' THEN
                  LET g_prea_m.prea052='3'
               END IF
               #倍換---一般促銷
               IF g_prea_m.prea004='5' THEN
                  LET g_prea_m.prea052='1'
               END IF                           
            END IF
            #160104-00012#2----add--end ----by huangrh--20160107---               
            CALL aprt310_set_entry(p_cmd)
            CALL aprt310_set_no_entry(p_cmd) 
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prea052
            #add-point:BEFORE FIELD prea052 name="input.b.prea052"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prea052
            
            #add-point:AFTER FIELD prea052 name="input.a.prea052"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE prea052
            #add-point:ON CHANGE prea052 name="input.g.prea052"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prea005
            #add-point:BEFORE FIELD prea005 name="input.b.prea005"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prea005
            
            #add-point:AFTER FIELD prea005 name="input.a.prea005"
            IF  NOT cl_null(g_prea_m.prea005) THEN 
               IF p_cmd = 'a' OR ( p_cmd = 'u' AND (g_prea_m.prea005 != g_prea_m_t.prea005 )) THEN 
                  LET g_prea_m.prea006=''
                  LET g_prea_m.prea006_desc=''
                  DISPLAY BY NAME g_prea_m.prea006,g_prea_m.prea006_desc
               END IF
            END IF
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE prea005
            #add-point:ON CHANGE prea005 name="input.g.prea005"
            LET g_prea_m.prea006=''
            LET g_prea_m.prea006_desc=''
            DISPLAY BY NAME g_prea_m.prea006,g_prea_m.prea006_desc
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prea006
            
            #add-point:AFTER FIELD prea006 name="input.a.prea006"

            IF NOT cl_null(g_prea_m.prea006) AND NOT cl_null(g_prea_m.prea005) THEN 
               IF g_prea_m.prea005='1' THEN #卡
                  #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
                  INITIALIZE g_chkparam.* TO NULL
                  #設定g_chkparam.*的參數
                  LET g_chkparam.arg1 = g_prea_m.prea006
                     
                  #呼叫檢查存在並帶值的library
                  IF cl_chk_exist("v_mman001") THEN
                     #檢查成功時後續處理
                     #LET  = g_chkparam.return1
                     #DISPLAY BY NAME 
                  ELSE
                     #檢查失敗時後續處理
                      LET g_prea_m.prea006 = g_prea_m_t.prea006
                     NEXT FIELD CURRENT
                  END IF
                  INITIALIZE g_ref_fields TO NULL
                  LET g_ref_fields[1] = g_prea_m.prea006
                  CALL ap_ref_array2(g_ref_fields,"SELECT mmanl003 FROM mmanl_t WHERE mmanlent='"||g_enterprise||"' AND mmanl001=? AND mmanl002='"||g_dlang||"'","") RETURNING g_rtn_fields
                  LET g_prea_m.prea006_desc = '', g_rtn_fields[1] , ''
                  DISPLAY BY NAME g_prea_m.prea006_desc                  
               END IF
               IF g_prea_m.prea005='2' THEN  #券
                  #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
                  INITIALIZE g_chkparam.* TO NULL
                  #設定g_chkparam.*的參數
                  LET g_chkparam.arg1 = g_prea_m.prea006
                     
                  #呼叫檢查存在並帶值的library
                  IF cl_chk_exist("v_gcaf001_2") THEN
                     #檢查成功時後續處理
                     #LET  = g_chkparam.return1
                     #DISPLAY BY NAME 
                  ELSE
                     #檢查失敗時後續處理
                      LET g_prea_m.prea006 = g_prea_m_t.prea006
                     NEXT FIELD CURRENT
                  END IF
                  #150922-00016--add--begin---20151026--by huangrh---
                  #若為券，單身贈送金額與券面額不一致需提示,僅提示！
                  SELECT oocq009 INTO l_oocq009
                    FROM oocq_t,gcaf_t
                   WHERE oocqent=gcafent
                     AND gcaf001=g_prea_m.prea006
                     AND oocqent=g_enterprise
                     AND oocq001='2071'
                     AND oocq002=gcaf012
                  LET l_prec010=l_oocq009
                  
                  LET l_count=0
                  SELECT COUNT(*) INTO l_count
                    FROM prec_t
                   WHERE precent=g_enterprise
                     AND precdocno=g_prea_m.preadocno
                     AND (prec010<>l_prec010 OR prec012<>l_prec010 OR prec014<>l_prec010 OR prec016<>l_prec010 OR prec018<>l_prec010 OR prec020<>l_prec010)
                  IF NOT cl_null(l_count) AND l_count>0 THEN
                      INITIALIZE g_errparam TO NULL
                      LET g_errparam.extend = ''
                      LET g_errparam.code   = 'apr-00471'
                      LET g_errparam.popup  = TRUE
                      CALL cl_err()                            
                  END IF
                  #150922-00016--add--end---20151026--by huangrh---
                  INITIALIZE g_ref_fields TO NULL
                  LET g_ref_fields[1] = g_prea_m.prea006
                  CALL ap_ref_array2(g_ref_fields,"SELECT gcafl003 FROM gcafl_t WHERE gcaflent='"||g_enterprise||"' AND gcafl001=? AND gcafl002='"||g_dlang||"'","") RETURNING g_rtn_fields
                  LET g_prea_m.prea006_desc = '', g_rtn_fields[1] , ''
                  DISPLAY BY NAME g_prea_m.prea006_desc                      
               END IF 

            END IF            
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prea006
            #add-point:BEFORE FIELD prea006 name="input.b.prea006"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE prea006
            #add-point:ON CHANGE prea006 name="input.g.prea006"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD preb003_1
            #add-point:BEFORE FIELD preb003_1 name="input.b.preb003_1"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD preb003_1
            
            #add-point:AFTER FIELD preb003_1 name="input.a.preb003_1"
            IF NOT cl_null(g_prea_m.preb003_1) THEN 
               IF NOT cl_null(g_prea_m.preb004_1) THEN
                  IF g_prea_m.preb003_1 > g_prea_m.preb004_1 THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = 'amm-00080'
                     LET g_errparam.extend = g_prea_m.preb003_1
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                  
                     LET g_prea_m.preb003_1 = g_prea_m_t.preb003_1
                     NEXT FIELD preb003_1
                  END IF
               END IF
               IF NOT cl_null(g_prea_m.prea003) THEN
                  SELECT prcf009,prcf010 INTO l_prcf009,l_prcf010
                    FROM prcf_t
                   WHERE prcfent=g_enterprise
                     AND prcf001=g_prea_m.prea003
                  IF g_prea_m.preb003_1<l_prcf009 THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = 'apr-00426'
                     LET g_errparam.extend = g_prea_m.preb003_1
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                  
                     LET g_prea_m.preb003_1 = g_prea_m_t.preb003_1
                     NEXT FIELD preb003_1                  
               
                  END IF
               END IF   
               IF g_prea_m.preb003_1>g_today THEN 
                  LET g_prea_m.prea014=g_prea_m.preb003_1
               END IF 
               DISPLAY BY NAME g_prea_m.prea014 
               
               #促銷談判條件的開始日期，小於對應合約的生效日期，小於專櫃的進場日期，則報錯
               
               LET l_count=''
               SELECT COUNT(*) INTO l_count
                 FROM prec_t,stfa_t
                WHERE precent=g_enterprise
                  AND precdocno=g_prea_m.preadocno
                  AND stfaent=precent
                  AND stfa005=prec004
                  AND stfastus='Y'
                  AND precacti='Y'
                  AND stfa019>g_prea_m.preb003_1
                  AND stfa017>g_prea_m.preb003_1
               IF NOT cl_null(l_count) AND l_count>0 THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'apr-00466'
                  LET g_errparam.extend = g_prea_m.preb003_1
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
                  
                  LET g_prea_m.preb003_1 = g_prea_m_t.preb003_1
                  NEXT FIELD preb003_1                                              
               END IF               
            END IF           
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE preb003_1
            #add-point:ON CHANGE preb003_1 name="input.g.preb003_1"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD preb004_1
            #add-point:BEFORE FIELD preb004_1 name="input.b.preb004_1"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD preb004_1
            
            #add-point:AFTER FIELD preb004_1 name="input.a.preb004_1"
            IF NOT cl_null(g_prea_m.preb004_1) THEN 
               IF NOT cl_null(g_prea_m.preb003_1) THEN
                  IF g_prea_m.preb003_1 > g_prea_m.preb004_1 THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = 'amm-00081'
                     LET g_errparam.extend = g_prea_m.preb004_1
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                  
                     LET g_prea_m.preb004_1 = g_prea_m_t.preb004_1
                     NEXT FIELD preb004_1
                  END IF
               END IF
               IF NOT cl_null(g_prea_m.prea003) THEN
                  SELECT prcf009,prcf010 INTO l_prcf009,l_prcf010
                    FROM prcf_t
                   WHERE prcfent=g_enterprise
                     AND prcf001=g_prea_m.prea003
                  IF g_prea_m.preb004_1>l_prcf010 THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = 'apr-00426'
                     LET g_errparam.extend = g_prea_m.preb004_1
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                  
                     LET g_prea_m.preb004_1 = g_prea_m_t.preb004_1
                     NEXT FIELD preb004_1                  
               
                  END IF
               END IF               
            END IF 
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE preb004_1
            #add-point:ON CHANGE preb004_1 name="input.g.preb004_1"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prea051
            #add-point:BEFORE FIELD prea051 name="input.b.prea051"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prea051
            
            #add-point:AFTER FIELD prea051 name="input.a.prea051"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE prea051
            #add-point:ON CHANGE prea051 name="input.g.prea051"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prea008
            
            #add-point:AFTER FIELD prea008 name="input.a.prea008"
            IF NOT cl_null(g_prea_m.prea008) THEN 
            #應用 a19 樣板自動產生(Version:2)
               #校驗代值
               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
               INITIALIZE g_chkparam.* TO NULL
               #設定g_chkparam.*的參數
               LET g_chkparam.arg1 = "2135"
               LET g_chkparam.arg2 = g_prea_m.prea008
               #160318-00025#6--add--str
               LET g_errshow = TRUE 
               LET g_chkparam.err_str[1] = "aqc-00032:sub-01302|aqci030|",cl_get_progname("aqci030",g_lang,"2"),"|:EXEPROGaqci030"
               #160318-00025#6--add--end  
               #呼叫檢查存在並帶值的library
               IF cl_chk_exist("v_oocq002_01") THEN
                  #檢查成功時後續處理
                  #LET  = g_chkparam.return1
                  #DISPLAY BY NAME 
               ELSE
                  #檢查失敗時後續處理
                   LET g_prea_m.prea008 = g_prea_m_t.prea008
                  NEXT FIELD CURRENT
               END IF
            

            END IF            


            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_prea_m.prea008
            CALL ap_ref_array2(g_ref_fields,"SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001='2135' AND oocql002=? AND oocql003='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_prea_m.prea008_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_prea_m.prea008_desc


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prea008
            #add-point:BEFORE FIELD prea008 name="input.b.prea008"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE prea008
            #add-point:ON CHANGE prea008 name="input.g.prea008"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prea007
            
            #add-point:AFTER FIELD prea007 name="input.a.prea007"
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_prea_m.prea007
            CALL ap_ref_array2(g_ref_fields,"SELECT prcdl003 FROM prcdl_t WHERE prcdlent='"||g_enterprise||"' AND prcdl001=? AND prcdl002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_prea_m.prea007_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_prea_m.prea007_desc


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prea007
            #add-point:BEFORE FIELD prea007 name="input.b.prea007"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE prea007
            #add-point:ON CHANGE prea007 name="input.g.prea007"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prea009
            
            #add-point:AFTER FIELD prea009 name="input.a.prea009"
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_prea_m.prea009
            CALL ap_ref_array2(g_ref_fields,"SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001='2100' AND oocql002=? AND oocql003='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_prea_m.prea009_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_prea_m.prea009_desc


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prea009
            #add-point:BEFORE FIELD prea009 name="input.b.prea009"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE prea009
            #add-point:ON CHANGE prea009 name="input.g.prea009"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prea010
            
            #add-point:AFTER FIELD prea010 name="input.a.prea010"
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_prea_m.prea010
            CALL ap_ref_array2(g_ref_fields,"SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001='2101' AND oocql002=? AND oocql003='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_prea_m.prea010_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_prea_m.prea010_desc


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prea010
            #add-point:BEFORE FIELD prea010 name="input.b.prea010"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE prea010
            #add-point:ON CHANGE prea010 name="input.g.prea010"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD preb005_1
            #add-point:BEFORE FIELD preb005_1 name="input.b.preb005_1"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD preb005_1
            
            #add-point:AFTER FIELD preb005_1 name="input.a.preb005_1"
            IF NOT cl_null(g_prea_m.preb005_1) THEN              
              IF NOT cl_null(g_prea_m.prea003) THEN
                  SELECT prcf009,prcf010,prcf053,prcf054 INTO l_prcf009,l_prcf010,l_prcf053,l_prcf054
                    FROM prcf_t
                   WHERE prcfent=g_enterprise
                     AND prcf001=g_prea_m.prea003
                  IF g_prea_m.preb003_1=l_prcf009 AND g_prea_m.preb005_1<l_prcf053 THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = 'apr-00426'
                     LET g_errparam.extend = g_prea_m.preb005_1
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                  
                     LET g_prea_m.preb005_1 = g_prea_m_t.preb005_1
                     NEXT FIELD preb005_1                  
               
                  END IF
               END IF    
            END IF               
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE preb005_1
            #add-point:ON CHANGE preb005_1 name="input.g.preb005_1"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD preb006_1
            #add-point:BEFORE FIELD preb006_1 name="input.b.preb006_1"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD preb006_1
            
            #add-point:AFTER FIELD preb006_1 name="input.a.preb006_1"
            IF NOT cl_null(g_prea_m.preb006_1) THEN              
              IF NOT cl_null(g_prea_m.prea003) THEN
                  SELECT prcf009,prcf010,prcf053,prcf054 INTO l_prcf009,l_prcf010,l_prcf053,l_prcf054
                    FROM prcf_t
                   WHERE prcfent=g_enterprise
                     AND prcf001=g_prea_m.prea003
                  IF g_prea_m.preb003_1=l_prcf009 AND g_prea_m.preb006_1>l_prcf054 THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = 'apr-00426'
                     LET g_errparam.extend = g_prea_m.preb006_1
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                  
                     LET g_prea_m.preb006_1 = g_prea_m_t.preb006_1
                     NEXT FIELD preb006_1                  
               
                  END IF
               END IF    
            END IF
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE preb006_1
            #add-point:ON CHANGE preb006_1 name="input.g.preb006_1"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prea013
            #add-point:BEFORE FIELD prea013 name="input.b.prea013"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prea013
            
            #add-point:AFTER FIELD prea013 name="input.a.prea013"
            IF g_prea_m.prea013 = 'Y' THEN
               CALL cl_set_comp_visible("page_5", TRUE)
               CALL cl_set_comp_visible("lbl_preb003", FALSE)
               CALL cl_set_comp_visible("lbl_preb004", FALSE)
               CALL cl_set_comp_visible("lbl_preb005", FALSE)
               CALL cl_set_comp_visible("lbl_preb006", FALSE)
               CALL cl_set_comp_visible("lbl_preb007", FALSE)
               CALL cl_set_comp_visible("lbl_preb008", FALSE)
               CALL cl_set_comp_visible("preb003_1", FALSE)
               CALL cl_set_comp_visible("preb004_1", FALSE)
               CALL cl_set_comp_visible("preb005_1", FALSE)
               CALL cl_set_comp_visible("preb006_1", FALSE)
               CALL cl_set_comp_visible("preb007_1", FALSE)
               CALL cl_set_comp_visible("preb008_1", FALSE) 
               
            ELSE
               CALL cl_set_comp_visible("page_5", FALSE)
               CALL cl_set_comp_visible("lbl_preb003", TRUE)
               CALL cl_set_comp_visible("lbl_preb004", TRUE)
               CALL cl_set_comp_visible("lbl_preb005", TRUE)
               CALL cl_set_comp_visible("lbl_preb006", TRUE)
               CALL cl_set_comp_visible("lbl_preb007", TRUE)
               CALL cl_set_comp_visible("lbl_preb008", TRUE)
               CALL cl_set_comp_visible("preb003_1", TRUE)
               CALL cl_set_comp_visible("preb004_1", TRUE)
               CALL cl_set_comp_visible("preb005_1", TRUE)
               CALL cl_set_comp_visible("preb006_1", TRUE)
               CALL cl_set_comp_visible("preb007_1", TRUE)
               CALL cl_set_comp_visible("preb008_1", TRUE)          
            END IF
#            IF  NOT cl_null(g_prea_m.prea013) THEN 
#               IF p_cmd = 'a' OR ( p_cmd = 'u' AND (g_prea_m.prea013 != g_prea_m_t.prea013 )) THEN              
#                  DELETE FROM prdd_t 
#                   WHERE prddent = g_enterprise
#                     AND prdddocno = g_prea_m.preadocno
#               END IF
#            END IF
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE prea013
            #add-point:ON CHANGE prea013 name="input.g.prea013"
            IF g_prea_m.prea013 = 'Y' THEN
               CALL cl_set_comp_visible("page_5", TRUE)
               CALL cl_set_comp_visible("lbl_preb003", FALSE)
               CALL cl_set_comp_visible("lbl_preb004", FALSE)
               CALL cl_set_comp_visible("lbl_preb005", FALSE)
               CALL cl_set_comp_visible("lbl_preb006", FALSE)
               CALL cl_set_comp_visible("lbl_preb007", FALSE)
               CALL cl_set_comp_visible("lbl_preb008", FALSE)
               CALL cl_set_comp_visible("preb003_1", FALSE)
               CALL cl_set_comp_visible("preb004_1", FALSE)
               CALL cl_set_comp_visible("preb005_1", FALSE)
               CALL cl_set_comp_visible("preb006_1", FALSE)
               CALL cl_set_comp_visible("preb007_1", FALSE)
               CALL cl_set_comp_visible("preb008_1", FALSE) 
               
            ELSE
               CALL cl_set_comp_visible("page_5", FALSE)
               CALL cl_set_comp_visible("lbl_preb003", TRUE)
               CALL cl_set_comp_visible("lbl_preb004", TRUE)
               CALL cl_set_comp_visible("lbl_preb005", TRUE)
               CALL cl_set_comp_visible("lbl_preb006", TRUE)
               CALL cl_set_comp_visible("lbl_preb007", TRUE)
               CALL cl_set_comp_visible("lbl_preb008", TRUE)
               CALL cl_set_comp_visible("preb003_1", TRUE)
               CALL cl_set_comp_visible("preb004_1", TRUE)
               CALL cl_set_comp_visible("preb005_1", TRUE)
               CALL cl_set_comp_visible("preb006_1", TRUE)
               CALL cl_set_comp_visible("preb007_1", TRUE)
               CALL cl_set_comp_visible("preb008_1", TRUE)          
            END IF
            IF  NOT cl_null(g_prea_m.prea013) THEN 
               IF p_cmd = 'a' OR ( p_cmd = 'u' AND (g_prea_m.prea013 != g_prea_m_t.prea013 )) THEN              
                IF g_prea_m.prea013 = 'N' THEN
                   LET g_prea_m.preb005_1 = '00:00:00'
                   LET g_prea_m.preb006_1 = '23:59:59'
                END IF
               END IF
            END IF            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prea050
            #add-point:BEFORE FIELD prea050 name="input.b.prea050"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prea050
            
            #add-point:AFTER FIELD prea050 name="input.a.prea050"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE prea050
            #add-point:ON CHANGE prea050 name="input.g.prea050"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prea011
            
            #add-point:AFTER FIELD prea011 name="input.a.prea011"
            IF NOT cl_null(g_prea_m.prea011) THEN 
               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
               INITIALIZE g_chkparam.* TO NULL
               #設定g_chkparam.*的參數
               LET g_chkparam.arg1 = g_prea_m.prea011
               #160318-00025#6--add--str
               LET g_errshow = TRUE 
               LET g_chkparam.err_str[1] = "aim-00070:sub-01302|aooi130|",cl_get_progname("aooi130",g_lang,"2"),"|:EXEPROGaooi130"
               #160318-00025#6--add--end
               #呼叫檢查存在並帶值的library
               IF NOT cl_chk_exist("v_ooag001") THEN
                  LET g_prea_m.prea011 = g_prea_m_t.prea011
                  NEXT FIELD CURRENT
               END IF
               SELECT ooag003 INTO g_prea_m.prea012
                 FROM ooag_t
                WHERE ooagent = g_enterprise
                  AND ooag001 = g_prea_m.prea011
            END IF            
                       
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_prea_m.prea011
            CALL ap_ref_array2(g_ref_fields,"SELECT ooag011 FROM ooag_t WHERE ooagent='"||g_enterprise||"' AND ooag001=? ","") RETURNING g_rtn_fields
            LET g_prea_m.prea011_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_prea_m.prea011_desc


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prea011
            #add-point:BEFORE FIELD prea011 name="input.b.prea011"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE prea011
            #add-point:ON CHANGE prea011 name="input.g.prea011"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prea012
            
            #add-point:AFTER FIELD prea012 name="input.a.prea012"
            IF NOT cl_null(g_prea_m.prea012) THEN 
               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
               INITIALIZE g_chkparam.* TO NULL
               
               #設定g_chkparam.*的參數
               LET g_chkparam.arg1 = g_prea_m.prea012
               LET g_chkparam.arg2 = g_prea_m.preadocdt
               #160318-00025#6--add--str
               LET g_errshow = TRUE 
               LET g_chkparam.err_str[1] = "aoo-00029:sub-01302|aooi125|",cl_get_progname("aooi125",g_lang,"2"),"|:EXEPROGaooi125"
               #160318-00025#6--add--end
               #呼叫檢查存在並帶值的library
               IF NOT cl_chk_exist("v_ooeg001") THEN
                  LET g_prea_m.prea012 = g_prea_m_t.prea012
                  NEXT FIELD CURRENT
               END IF
            END IF             
            
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_prea_m.prea012
            CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_prea_m.prea012_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_prea_m.prea012_desc


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prea012
            #add-point:BEFORE FIELD prea012 name="input.b.prea012"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE prea012
            #add-point:ON CHANGE prea012 name="input.g.prea012"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prea014
            #add-point:BEFORE FIELD prea014 name="input.b.prea014"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prea014
            
            #add-point:AFTER FIELD prea014 name="input.a.prea014"
            IF  NOT cl_null(g_prea_m.prea014) THEN 
               IF p_cmd = 'a' OR ( p_cmd = 'u' AND (g_prea_m.prea014 != g_prea_m_t.prea014 )) THEN
                  IF NOT cl_null(g_prea_m.preadocdt) THEN                 
                     IF g_prea_m.prea014 < g_prea_m.preadocdt THEN    
                        INITIALIZE g_errparam TO NULL
                        LET g_errparam.extend = ''
                        LET g_errparam.code   = 'apr-00379'
                        LET g_errparam.popup  = TRUE
                        CALL cl_err()            
                        LET g_prea_m.prea014 = g_prea_m_t.prea014
                        NEXT FIELD CURRENT
                     END IF
                  END IF

               END IF
            END IF            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE prea014
            #add-point:ON CHANGE prea014 name="input.g.prea014"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prea015
            #add-point:BEFORE FIELD prea015 name="input.b.prea015"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prea015
            
            #add-point:AFTER FIELD prea015 name="input.a.prea015"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE prea015
            #add-point:ON CHANGE prea015 name="input.g.prea015"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD preb007_1
            #add-point:BEFORE FIELD preb007_1 name="input.b.preb007_1"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD preb007_1
            
            #add-point:AFTER FIELD preb007_1 name="input.a.preb007_1"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE preb007_1
            #add-point:ON CHANGE preb007_1 name="input.g.preb007_1"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD preb008_1
            #add-point:BEFORE FIELD preb008_1 name="input.b.preb008_1"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD preb008_1
            
            #add-point:AFTER FIELD preb008_1 name="input.a.preb008_1"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE preb008_1
            #add-point:ON CHANGE preb008_1 name="input.g.preb008_1"
            
            #END add-point 
 
 
 #欄位檢查
                  #Ctrlp:input.c.preasite
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD preasite
            #add-point:ON ACTION controlp INFIELD preasite name="input.c.preasite"
            #應用 a07 樣板自動產生(Version:2)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_prea_m.preasite             #給予default值
            LET g_qryparam.default2 = "" #g_prea_m.ooefl003 #說明(簡稱)
            #給予arg
            LET g_qryparam.arg1 = "" #
            LET g_qryparam.where = s_aooi500_q_where(g_prog,'preasite',g_prea_m.preasite,'i')
            CALL q_ooef001_24()                                #呼叫開窗

            LET g_prea_m.preasite = g_qryparam.return1              
            #LET g_prea_m.ooefl003 = g_qryparam.return2 
            DISPLAY g_prea_m.preasite TO preasite              #
            #DISPLAY g_prea_m.ooefl003 TO ooefl003 #說明(簡稱)
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_prea_m.preasite
            CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_prea_m.preasite_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_prea_m.preasite_desc            
            NEXT FIELD preasite                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.preadocdt
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD preadocdt
            #add-point:ON ACTION controlp INFIELD preadocdt name="input.c.preadocdt"
            
            #END add-point
 
 
         #Ctrlp:input.c.preadocno
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD preadocno
            #add-point:ON ACTION controlp INFIELD preadocno name="input.c.preadocno"
			   INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
			   LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_prea_m.preadocno             #給予default值

            #給予arg
            SELECT ooef004 INTO l_ooef004 FROM ooef_t WHERE ooef001 = g_site AND ooefent  = g_enterprise
            LET g_qryparam.arg1 = l_ooef004 #參照表編號
            LET g_qryparam.arg2 = g_prog #作业代号

            CALL q_ooba002_1()                                #呼叫開窗

            LET g_prea_m.preadocno = g_qryparam.return1              #將開窗取得的值回傳到變數

            DISPLAY g_prea_m.preadocno TO preadocno              #顯示到畫面上

            NEXT FIELD preadocno                          #返回原欄位
            #END add-point
 
 
         #Ctrlp:input.c.prea000
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prea000
            #add-point:ON ACTION controlp INFIELD prea000 name="input.c.prea000"
            
            #END add-point
 
 
         #Ctrlp:input.c.preaunit
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD preaunit
            #add-point:ON ACTION controlp INFIELD preaunit name="input.c.preaunit"
            
            #END add-point
 
 
         #Ctrlp:input.c.prea001
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prea001
            #add-point:ON ACTION controlp INFIELD prea001 name="input.c.prea001"
            IF g_prea_m.prea000='U' THEN
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'i'
               LET g_qryparam.reqry = FALSE
               
               LET g_qryparam.default1 = g_prea_m.prea001             #給予default值
               
               #給予arg          
               CALL q_preg001()                                 #呼叫開窗
               
               LET g_prea_m.prea001 = g_qryparam.return1              
               
               DISPLAY g_prea_m.prea001 TO prea001              #
            END IF
            #END add-point
 
 
         #Ctrlp:input.c.prea002
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prea002
            #add-point:ON ACTION controlp INFIELD prea002 name="input.c.prea002"
            
            #END add-point
 
 
         #Ctrlp:input.c.preal002
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD preal002
            #add-point:ON ACTION controlp INFIELD preal002 name="input.c.preal002"
            
            #END add-point
 
 
         #Ctrlp:input.c.preaacti
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD preaacti
            #add-point:ON ACTION controlp INFIELD preaacti name="input.c.preaacti"
            
            #END add-point
 
 
         #Ctrlp:input.c.preastus
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD preastus
            #add-point:ON ACTION controlp INFIELD preastus name="input.c.preastus"
            
            #END add-point
 
 
         #Ctrlp:input.c.prea003
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prea003
            #add-point:ON ACTION controlp INFIELD prea003 name="input.c.prea003"
            #應用 a07 樣板自動產生(Version:2)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_prea_m.prea003             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "3" 


            CALL q_prcf001()                                #呼叫開窗

            LET g_prea_m.prea003 = g_qryparam.return1              

            DISPLAY g_prea_m.prea003 TO prea003              #
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_prea_m.prea003
            CALL ap_ref_array2(g_ref_fields,"SELECT prcfl003 FROM prcfl_t WHERE prcflent='"||g_enterprise||"' AND prcfl001=? AND prcfl002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_prea_m.prea003_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_prea_m.prea003_desc
            NEXT FIELD prea003                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.prea004
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prea004
            #add-point:ON ACTION controlp INFIELD prea004 name="input.c.prea004"
            
            #END add-point
 
 
         #Ctrlp:input.c.prea052
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prea052
            #add-point:ON ACTION controlp INFIELD prea052 name="input.c.prea052"
            
            #END add-point
 
 
         #Ctrlp:input.c.prea005
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prea005
            #add-point:ON ACTION controlp INFIELD prea005 name="input.c.prea005"
            
            #END add-point
 
 
         #Ctrlp:input.c.prea006
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prea006
            #add-point:ON ACTION controlp INFIELD prea006 name="input.c.prea006"
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_prea_m.prea006             #給予default值

            IF g_prea_m.prea005='1' THEN
               CALL q_mman001()
               INITIALIZE g_ref_fields TO NULL
               LET g_ref_fields[1] = g_prea_m.prea006
               CALL ap_ref_array2(g_ref_fields,"SELECT mmanl003 FROM mmanl_t WHERE mmanlent='"||g_enterprise||"' AND mmanl001=? AND mmanl002='"||g_dlang||"'","") RETURNING g_rtn_fields
               LET g_prea_m.prea006_desc = '', g_rtn_fields[1] , ''
               DISPLAY BY NAME g_prea_m.prea006_desc                 
            END IF
            IF g_prea_m.prea005='2' THEN
               CALL q_gcaf001()
               INITIALIZE g_ref_fields TO NULL
               LET g_ref_fields[1] = g_prea_m.prea006
               CALL ap_ref_array2(g_ref_fields,"SELECT gcafl003 FROM gcafl_t WHERE gcaflent='"||g_enterprise||"' AND gcafl001=? AND gcafl002='"||g_dlang||"'","") RETURNING g_rtn_fields
               LET g_prea_m.prea006_desc = '', g_rtn_fields[1] , ''
               DISPLAY BY NAME g_prea_m.prea006_desc                 
            END IF                                            

            LET g_prea_m.prea006 = g_qryparam.return1              

            DISPLAY g_prea_m.prea006 TO prea006              #

            NEXT FIELD prea006                          #返回原欄位
            #END add-point
 
 
         #Ctrlp:input.c.preb003_1
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD preb003_1
            #add-point:ON ACTION controlp INFIELD preb003_1 name="input.c.preb003_1"
            
            #END add-point
 
 
         #Ctrlp:input.c.preb004_1
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD preb004_1
            #add-point:ON ACTION controlp INFIELD preb004_1 name="input.c.preb004_1"
            
            #END add-point
 
 
         #Ctrlp:input.c.prea051
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prea051
            #add-point:ON ACTION controlp INFIELD prea051 name="input.c.prea051"
            
            #END add-point
 
 
         #Ctrlp:input.c.prea008
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prea008
            #add-point:ON ACTION controlp INFIELD prea008 name="input.c.prea008"
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_prea_m.prea008             #給予default值
            LET g_qryparam.default2 = "" #g_prda_m.oocql004 #說明
            #給予arg
            LET g_qryparam.arg1 = "2135" #s


            CALL q_oocq002()                                #呼叫開窗

            LET g_prea_m.prea008 = g_qryparam.return1        
            DISPLAY g_prea_m.prea008 TO prea008              
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_prea_m.prea008
            CALL ap_ref_array2(g_ref_fields,"SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001='2135' AND oocql002=? AND oocql003='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_prea_m.prea008_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_prea_m.prea008_desc
            NEXT FIELD prea008                          #返回原欄位
            #END add-point
 
 
         #Ctrlp:input.c.prea007
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prea007
            #add-point:ON ACTION controlp INFIELD prea007 name="input.c.prea007"
            
            #END add-point
 
 
         #Ctrlp:input.c.prea009
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prea009
            #add-point:ON ACTION controlp INFIELD prea009 name="input.c.prea009"
            
            #END add-point
 
 
         #Ctrlp:input.c.prea010
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prea010
            #add-point:ON ACTION controlp INFIELD prea010 name="input.c.prea010"
            
            #END add-point
 
 
         #Ctrlp:input.c.preb005_1
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD preb005_1
            #add-point:ON ACTION controlp INFIELD preb005_1 name="input.c.preb005_1"
            
            #END add-point
 
 
         #Ctrlp:input.c.preb006_1
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD preb006_1
            #add-point:ON ACTION controlp INFIELD preb006_1 name="input.c.preb006_1"
            
            #END add-point
 
 
         #Ctrlp:input.c.prea013
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prea013
            #add-point:ON ACTION controlp INFIELD prea013 name="input.c.prea013"
            
            #END add-point
 
 
         #Ctrlp:input.c.prea050
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prea050
            #add-point:ON ACTION controlp INFIELD prea050 name="input.c.prea050"
            
            #END add-point
 
 
         #Ctrlp:input.c.prea011
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prea011
            #add-point:ON ACTION controlp INFIELD prea011 name="input.c.prea011"
            #應用 a07 樣板自動產生(Version:2)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_prea_m.prea011             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "" #s


            CALL q_ooag001()                                #呼叫開窗

            LET g_prea_m.prea011 = g_qryparam.return1              

            DISPLAY g_prea_m.prea011 TO prea011              #
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_prea_m.prea011
            CALL ap_ref_array2(g_ref_fields,"SELECT ooag011 FROM ooag_t WHERE ooagent='"||g_enterprise||"' AND ooag001=? ","") RETURNING g_rtn_fields
            LET g_prea_m.prea011_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_prea_m.prea011_desc
            NEXT FIELD prea011                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.prea012
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prea012
            #add-point:ON ACTION controlp INFIELD prea012 name="input.c.prea012"
            #應用 a07 樣板自動產生(Version:2)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_prea_m.prea012             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "" #s


            CALL q_ooeg001_9()                                #呼叫開窗

            LET g_prea_m.prea012 = g_qryparam.return1              

            DISPLAY g_prea_m.prea012 TO prea012              #
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_prea_m.prea012
            CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_prea_m.prea012_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_prea_m.prea012_desc
            NEXT FIELD prea012                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.prea014
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prea014
            #add-point:ON ACTION controlp INFIELD prea014 name="input.c.prea014"
            
            #END add-point
 
 
         #Ctrlp:input.c.prea015
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prea015
            #add-point:ON ACTION controlp INFIELD prea015 name="input.c.prea015"
            
            #END add-point
 
 
         #Ctrlp:input.c.preb007_1
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD preb007_1
            #add-point:ON ACTION controlp INFIELD preb007_1 name="input.c.preb007_1"
            
            #END add-point
 
 
         #Ctrlp:input.c.preb008_1
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD preb008_1
            #add-point:ON ACTION controlp INFIELD preb008_1 name="input.c.preb008_1"
            
            #END add-point
 
 
 #欄位開窗
            
         AFTER INPUT
            IF INT_FLAG THEN
               EXIT DIALOG
            END IF
 
            #CALL cl_err_collect_show()      #錯誤訊息統整顯示
            #CALL cl_showmsg()
            DISPLAY BY NAME g_prea_m.preadocno
                        
            #add-point:單頭INPUT後 name="input.head.after_input"
            
            #end add-point
                        
            IF p_cmd <> 'u' THEN
    
               CALL s_transaction_begin()
               
               #add-point:單頭新增前 name="input.head.b_insert"
               CALL s_aooi200_gen_docno(g_prea_m.preasite,g_prea_m.preadocno,g_prea_m.preadocdt,g_prog) RETURNING l_success,g_prea_m.preadocno 
               IF NOT l_success THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'apm-00003'
                  LET g_errparam.extend = g_prea_m.preadocno
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  LET g_prea_m.preadocno = g_preadocno_t
                  NEXT FIELD preadocno
               END IF
               LET g_prea_m.preaunit = g_prea_m.preasite #
               
               #add--2015/07/30 By shiun--(S)
               CALL s_aooi390_get_auto_no('23',g_prea_m.prea001) RETURNING l_success,g_prea_m.prea001
               IF NOT l_success THEN
                  CALL s_transaction_end('N','0')
                  NEXT FIELD CURRENT
               END IF   
               DISPLAY BY NAME g_prea_m.prea001              
               CALL s_aooi390_oofi_upd('23',g_prea_m.prea001) RETURNING l_success
               #add--2015/07/30 By shiun--(E)
               #end add-point
               
               INSERT INTO prea_t (preaent,preasite,preadocdt,preadocno,prea000,preaunit,prea001,prea002, 
                   preaacti,preastus,prea003,prea004,prea052,prea005,prea006,prea051,prea008,prea007, 
                   prea009,prea010,prea013,prea050,prea011,prea012,prea014,prea015,preaownid,preaowndp, 
                   preacrtid,preacrtdp,preacrtdt,preamodid,preamoddt,preacnfid,preacnfdt,preapstid,preapstdt) 
 
               VALUES (g_enterprise,g_prea_m.preasite,g_prea_m.preadocdt,g_prea_m.preadocno,g_prea_m.prea000, 
                   g_prea_m.preaunit,g_prea_m.prea001,g_prea_m.prea002,g_prea_m.preaacti,g_prea_m.preastus, 
                   g_prea_m.prea003,g_prea_m.prea004,g_prea_m.prea052,g_prea_m.prea005,g_prea_m.prea006, 
                   g_prea_m.prea051,g_prea_m.prea008,g_prea_m.prea007,g_prea_m.prea009,g_prea_m.prea010, 
                   g_prea_m.prea013,g_prea_m.prea050,g_prea_m.prea011,g_prea_m.prea012,g_prea_m.prea014, 
                   g_prea_m.prea015,g_prea_m.preaownid,g_prea_m.preaowndp,g_prea_m.preacrtid,g_prea_m.preacrtdp, 
                   g_prea_m.preacrtdt,g_prea_m.preamodid,g_prea_m.preamoddt,g_prea_m.preacnfid,g_prea_m.preacnfdt, 
                   g_prea_m.preapstid,g_prea_m.preapstdt) 
               IF SQLCA.SQLCODE THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "g_prea_m:",SQLERRMESSAGE 
                  LET g_errparam.code = SQLCA.SQLCODE 
                  LET g_errparam.popup = TRUE 
                  CALL s_transaction_end('N','0')
                  CALL cl_err()
                  NEXT FIELD CURRENT
               END IF
               
               #add-point:單頭新增中 name="input.head.m_insert"
               
               #end add-point
               
               
                        INITIALIZE l_var_keys TO NULL 
         INITIALIZE l_field_keys TO NULL 
         INITIALIZE l_vars TO NULL 
         INITIALIZE l_fields TO NULL 
         IF g_prea_m.preadocno = g_master_multi_table_t.prealdocno AND
         g_prea_m.preal002 = g_master_multi_table_t.preal002  THEN
         ELSE 
            LET l_var_keys[01] = g_enterprise
            LET l_field_keys[01] = 'prealent'
            LET l_var_keys_bak[01] = g_enterprise
            LET l_var_keys[02] = g_prea_m.preadocno
            LET l_field_keys[02] = 'prealdocno'
            LET l_var_keys_bak[02] = g_master_multi_table_t.prealdocno
            LET l_var_keys[03] = g_dlang
            LET l_field_keys[03] = 'preal001'
            LET l_var_keys_bak[03] = g_dlang
            LET l_vars[01] = g_prea_m.preal002
            LET l_fields[01] = 'preal002'
            CALL cl_multitable(l_var_keys,l_field_keys,l_vars,l_fields,l_var_keys_bak,'preal_t')
         END IF 
 
               
               #add-point:單頭新增後 name="input.head.a_insert"
               CALL aprt310_prdd()
               IF g_prea_m.prea000 = 'U' THEN
                  CALL aprt310_detail_init()
                  CALL aprt310_b_fill()
               END IF               
               #end add-point
               CALL s_transaction_end('Y','0') 
               
               IF l_cmd_t = 'r' AND p_cmd = 'a' THEN
                  CALL aprt310_detail_reproduce()
                  #因應特定程式需求, 重新刷新單身資料
                  CALL aprt310_b_fill()
                  CALL aprt310_b_fill2('0')
               END IF
               
               #add-point:單頭新增後 name="input.head.a_insert2"
               
               #end add-point
               
               LET g_master_insert = TRUE
               
               LET p_cmd = 'u'
            ELSE
               CALL s_transaction_begin()
            
               #add-point:單頭修改前 name="input.head.b_update"
               #修改的時候，不開啟規則編號欄位---暫時mark掉自動編號--------begin--20150921--huangrh             
               ##add--2015/07/30 By shiun--(S)
               #CALL s_aooi390_get_auto_no('23',g_prea_m.prea001) RETURNING l_success,g_prea_m.prea001
               #IF NOT l_success THEN
               #   CALL s_transaction_end('N','0')
               #   NEXT FIELD CURRENT
               #END IF   
               #DISPLAY BY NAME g_prea_m.prea001              
               #CALL s_aooi390_oofi_upd('23',g_prea_m.prea001) RETURNING l_success
               #add--2015/07/30 By shiun--(E)
               #修改的時候，不開啟規則編號欄位---暫時mark掉自動編號--------end--20150921--huangrh  
               #end add-point
               
               #將遮罩欄位還原
               CALL aprt310_prea_t_mask_restore('restore_mask_o')
               
               UPDATE prea_t SET (preasite,preadocdt,preadocno,prea000,preaunit,prea001,prea002,preaacti, 
                   preastus,prea003,prea004,prea052,prea005,prea006,prea051,prea008,prea007,prea009, 
                   prea010,prea013,prea050,prea011,prea012,prea014,prea015,preaownid,preaowndp,preacrtid, 
                   preacrtdp,preacrtdt,preamodid,preamoddt,preacnfid,preacnfdt,preapstid,preapstdt) = (g_prea_m.preasite, 
                   g_prea_m.preadocdt,g_prea_m.preadocno,g_prea_m.prea000,g_prea_m.preaunit,g_prea_m.prea001, 
                   g_prea_m.prea002,g_prea_m.preaacti,g_prea_m.preastus,g_prea_m.prea003,g_prea_m.prea004, 
                   g_prea_m.prea052,g_prea_m.prea005,g_prea_m.prea006,g_prea_m.prea051,g_prea_m.prea008, 
                   g_prea_m.prea007,g_prea_m.prea009,g_prea_m.prea010,g_prea_m.prea013,g_prea_m.prea050, 
                   g_prea_m.prea011,g_prea_m.prea012,g_prea_m.prea014,g_prea_m.prea015,g_prea_m.preaownid, 
                   g_prea_m.preaowndp,g_prea_m.preacrtid,g_prea_m.preacrtdp,g_prea_m.preacrtdt,g_prea_m.preamodid, 
                   g_prea_m.preamoddt,g_prea_m.preacnfid,g_prea_m.preacnfdt,g_prea_m.preapstid,g_prea_m.preapstdt) 
 
                WHERE preaent = g_enterprise AND preadocno = g_preadocno_t
 
               IF SQLCA.SQLCODE THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "prea_t:",SQLERRMESSAGE 
                  LET g_errparam.code = SQLCA.SQLCODE 
                  LET g_errparam.popup = TRUE 
                  CALL s_transaction_end('N','0')
                  CALL cl_err()
                  NEXT FIELD CURRENT
               END IF
               
               #add-point:單頭修改中 name="input.head.m_update"
               CALL aprt310_prdd()
               #end add-point
               
               
                        INITIALIZE l_var_keys TO NULL 
         INITIALIZE l_field_keys TO NULL 
         INITIALIZE l_vars TO NULL 
         INITIALIZE l_fields TO NULL 
         IF g_prea_m.preadocno = g_master_multi_table_t.prealdocno AND
         g_prea_m.preal002 = g_master_multi_table_t.preal002  THEN
         ELSE 
            LET l_var_keys[01] = g_enterprise
            LET l_field_keys[01] = 'prealent'
            LET l_var_keys_bak[01] = g_enterprise
            LET l_var_keys[02] = g_prea_m.preadocno
            LET l_field_keys[02] = 'prealdocno'
            LET l_var_keys_bak[02] = g_master_multi_table_t.prealdocno
            LET l_var_keys[03] = g_dlang
            LET l_field_keys[03] = 'preal001'
            LET l_var_keys_bak[03] = g_dlang
            LET l_vars[01] = g_prea_m.preal002
            LET l_fields[01] = 'preal002'
            CALL cl_multitable(l_var_keys,l_field_keys,l_vars,l_fields,l_var_keys_bak,'preal_t')
         END IF 
 
               
               #將遮罩欄位進行遮蔽
               CALL aprt310_prea_t_mask_restore('restore_mask_n')
               
               #修改歷程記錄(單頭修改)
               LET g_log1 = util.JSON.stringify(g_prea_m_t)
               LET g_log2 = util.JSON.stringify(g_prea_m)
               IF NOT cl_log_modified_record(g_log1,g_log2) THEN 
                  CALL s_transaction_end('N','0')
               ELSE
                  CALL s_transaction_end('Y','0')
               END IF
               
               #add-point:單頭修改後 name="input.head.a_update"
               
               #end add-point
            END IF
            
            LET g_master_commit = "Y"
            LET g_preadocno_t = g_prea_m.preadocno
 
            
      END INPUT
   
 
{</section>}
 
{<section id="aprt310.input.body" >}
   
      #Page1 預設值產生於此處
      INPUT ARRAY g_prec_d FROM s_detail1.*
          ATTRIBUTE(COUNT = g_rec_b,WITHOUT DEFAULTS, #MAXCOUNT = g_max_rec,
                  INSERT ROW = l_allow_insert, 
                  DELETE ROW = l_allow_delete,
                  APPEND ROW = l_allow_insert)
 
         #自訂ACTION(detail_input,page_1)
         
         
         BEFORE INPUT
            #add-point:資料輸入前 name="input.body.before_input2"
            
            #end add-point
            IF g_insert = 'Y' AND NOT cl_null(g_insert) THEN 
              CALL FGL_SET_ARR_CURR(g_prec_d.getLength()+1) 
              LET g_insert = 'N' 
           END IF 
 
            CALL aprt310_b_fill()
            #如果一直都在單身1則控制筆數位置
            IF g_loc = 'm' AND g_rec_b != 0 THEN
               CALL FGL_SET_ARR_CURR(g_idx_group.getValue("'1','2',"))
            END IF
            LET g_loc = 'm'
            LET g_rec_b = g_prec_d.getLength()
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
            OPEN aprt310_cl USING g_enterprise,g_prea_m.preadocno
            IF SQLCA.SQLCODE THEN   #(ver:78)
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "OPEN aprt310_cl:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE   #(ver:78)
               LET g_errparam.popup = TRUE 
               CLOSE aprt310_cl
               CALL s_transaction_end('N','0')
               CALL cl_err()
               RETURN
            END IF
            
            LET g_rec_b = g_prec_d.getLength()
            
            IF g_rec_b >= l_ac 
               AND g_prec_d[l_ac].precseq IS NOT NULL
 
            THEN
               LET l_cmd='u'
               LET g_prec_d_t.* = g_prec_d[l_ac].*  #BACKUP
               LET g_prec_d_o.* = g_prec_d[l_ac].*  #BACKUP
               CALL aprt310_set_entry_b(l_cmd)
               #add-point:modify段after_set_entry_b name="input.body.after_set_entry_b"
               
               #end add-point  
               CALL aprt310_set_no_entry_b(l_cmd)
               IF NOT aprt310_lock_b("prec_t","'1'") THEN
                  LET l_lock_sw='Y'
               ELSE
                  FETCH aprt310_bcl INTO g_prec_d[l_ac].precacti,g_prec_d[l_ac].precseq,g_prec_d[l_ac].prec003, 
                      g_prec_d[l_ac].prec004,g_prec_d[l_ac].prec005,g_prec_d[l_ac].prec006,g_prec_d[l_ac].prec007, 
                      g_prec_d[l_ac].prec008,g_prec_d[l_ac].prec009,g_prec_d[l_ac].prec010,g_prec_d[l_ac].prec011, 
                      g_prec_d[l_ac].prec012,g_prec_d[l_ac].prec013,g_prec_d[l_ac].prec014,g_prec_d[l_ac].prec015, 
                      g_prec_d[l_ac].prec016,g_prec_d[l_ac].prec017,g_prec_d[l_ac].prec018,g_prec_d[l_ac].prec019, 
                      g_prec_d[l_ac].prec020,g_prec_d[l_ac].prec021,g_prec_d[l_ac].prec022,g_prec_d[l_ac].prec023, 
                      g_prec_d[l_ac].prec024,g_prec_d[l_ac].prec025,g_prec_d[l_ac].prec026,g_prec_d[l_ac].prec027, 
                      g_prec_d[l_ac].prec028,g_prec_d[l_ac].prec029,g_prec_d[l_ac].prec030,g_prec_d[l_ac].prec031, 
                      g_prec_d[l_ac].prec032,g_prec_d[l_ac].prec033,g_prec_d[l_ac].prec034,g_prec_d[l_ac].prec035, 
                      g_prec_d[l_ac].prec036,g_prec_d[l_ac].prec037,g_prec_d[l_ac].prec038,g_prec_d[l_ac].prec039, 
                      g_prec_d[l_ac].prec040,g_prec_d[l_ac].prec041,g_prec_d[l_ac].prec042,g_prec_d[l_ac].prec043, 
                      g_prec_d[l_ac].prec044,g_prec_d[l_ac].prec045,g_prec_d[l_ac].prec098,g_prec_d[l_ac].prec046, 
                      g_prec_d[l_ac].prec047,g_prec_d[l_ac].prec048,g_prec_d[l_ac].prec049,g_prec_d[l_ac].prec050, 
                      g_prec_d[l_ac].prec051,g_prec_d[l_ac].prec052,g_prec_d[l_ac].prec053,g_prec_d[l_ac].prec054, 
                      g_prec_d[l_ac].prec055,g_prec_d[l_ac].prec056,g_prec_d[l_ac].prec057,g_prec_d[l_ac].prec058, 
                      g_prec_d[l_ac].prec059,g_prec_d[l_ac].prec060,g_prec_d[l_ac].prec061,g_prec_d[l_ac].prec062, 
                      g_prec_d[l_ac].prec063,g_prec_d[l_ac].prec064,g_prec_d[l_ac].prec065,g_prec_d[l_ac].prec066, 
                      g_prec_d[l_ac].prec067,g_prec_d[l_ac].prec068,g_prec_d[l_ac].prec069,g_prec_d[l_ac].prec070, 
                      g_prec_d[l_ac].prec071,g_prec_d[l_ac].prec072,g_prec_d[l_ac].prec073,g_prec_d[l_ac].prec074, 
                      g_prec_d[l_ac].prec075,g_prec_d[l_ac].prec078,g_prec_d[l_ac].prec079,g_prec_d[l_ac].prec081, 
                      g_prec_d[l_ac].prec001,g_prec2_d[l_ac].precseq,g_prec2_d[l_ac].prec080,g_prec2_d[l_ac].prec082, 
                      g_prec2_d[l_ac].prec083,g_prec2_d[l_ac].prec084,g_prec2_d[l_ac].prec085,g_prec2_d[l_ac].prec086, 
                      g_prec2_d[l_ac].prec087,g_prec2_d[l_ac].prec088,g_prec2_d[l_ac].prec089,g_prec2_d[l_ac].prec090, 
                      g_prec2_d[l_ac].prec091,g_prec2_d[l_ac].prec092,g_prec2_d[l_ac].prec093,g_prec2_d[l_ac].prec094, 
                      g_prec2_d[l_ac].prec095,g_prec2_d[l_ac].prec096,g_prec2_d[l_ac].prec097,g_prec2_d[l_ac].precunit, 
                      g_prec2_d[l_ac].precsite
                  IF SQLCA.SQLCODE THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = g_prec_d_t.precseq,":",SQLERRMESSAGE 
                     LET g_errparam.code = SQLCA.SQLCODE 
                     LET g_errparam.popup = TRUE 
                     CALL cl_err()
                     LET l_lock_sw = "Y"
                  END IF
                  
                  #遮罩相關處理
                  LET g_prec_d_mask_o[l_ac].* =  g_prec_d[l_ac].*
                  CALL aprt310_prec_t_mask()
                  LET g_prec_d_mask_n[l_ac].* =  g_prec_d[l_ac].*
                  
                  LET g_bfill = "N"
                  CALL aprt310_show()
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
            INITIALIZE g_prec_d[l_ac].* TO NULL 
            INITIALIZE g_prec_d_t.* TO NULL 
            INITIALIZE g_prec_d_o.* TO NULL 
            #公用欄位給值(單身)
            
            #自定義預設值
                  LET g_prec_d[l_ac].precacti = "Y"
      LET g_prec_d[l_ac].prec007 = "N"
      LET g_prec_d[l_ac].prec008 = "99999999"
      LET g_prec_d[l_ac].prec009 = "0"
      LET g_prec_d[l_ac].prec011 = "0"
      LET g_prec_d[l_ac].prec013 = "0"
      LET g_prec_d[l_ac].prec015 = "0"
      LET g_prec_d[l_ac].prec017 = "0"
      LET g_prec_d[l_ac].prec019 = "0"
      LET g_prec_d[l_ac].prec022 = "N"
      LET g_prec_d[l_ac].prec023 = "99999999"
      LET g_prec_d[l_ac].prec034 = "0.1"
      LET g_prec_d[l_ac].prec035 = "0.1"
      LET g_prec_d[l_ac].prec036 = "0"
      LET g_prec_d[l_ac].prec037 = "0"
      LET g_prec_d[l_ac].prec038 = "0"
      LET g_prec_d[l_ac].prec039 = "0"
      LET g_prec_d[l_ac].prec040 = "0"
      LET g_prec_d[l_ac].prec041 = "0"
      LET g_prec_d[l_ac].prec042 = "0"
      LET g_prec_d[l_ac].prec043 = "0"
      LET g_prec_d[l_ac].prec044 = "0"
      LET g_prec_d[l_ac].prec045 = "0"
      LET g_prec_d[l_ac].prec046 = "0"
      LET g_prec_d[l_ac].prec047 = "0"
      LET g_prec_d[l_ac].prec048 = "0"
      LET g_prec_d[l_ac].prec049 = "0"
      LET g_prec_d[l_ac].prec050 = "0"
      LET g_prec_d[l_ac].prec051 = "0"
      LET g_prec_d[l_ac].prec052 = "0"
      LET g_prec_d[l_ac].prec053 = "0"
      LET g_prec_d[l_ac].prec054 = "0"
      LET g_prec_d[l_ac].prec055 = "0"
      LET g_prec_d[l_ac].prec056 = "0"
      LET g_prec_d[l_ac].prec057 = "0"
      LET g_prec_d[l_ac].prec058 = "0"
      LET g_prec_d[l_ac].prec059 = "N"
      LET g_prec_d[l_ac].prec062 = "Y"
      LET g_prec_d[l_ac].prec063 = "0"
      LET g_prec_d[l_ac].prec064 = "0"
      LET g_prec_d[l_ac].prec065 = "0"
      LET g_prec_d[l_ac].prec066 = "0"
      LET g_prec_d[l_ac].prec067 = "0"
      LET g_prec_d[l_ac].prec068 = "0"
      LET g_prec_d[l_ac].prec069 = "0"
      LET g_prec_d[l_ac].prec070 = "0"
      LET g_prec_d[l_ac].prec071 = "0"
      LET g_prec_d[l_ac].prec072 = "0"
      LET g_prec_d[l_ac].prec073 = "0"
      LET g_prec_d[l_ac].prec078 = "0"
 
            #add-point:modify段before備份 name="input.body.insert.before_bak"
           LET g_prec_d[l_ac].prec062 = "N"     #150619-00010#3 add  
           LET g_prec_d[l_ac].prec074 = "Y"          
           LET g_prec_d[l_ac].prec036 = "0.1"
           LET g_prec_d[l_ac].prec037 = "0.1"
           LET g_prec_d[l_ac].prec038 = "0.1"
           LET g_prec_d[l_ac].prec039 = "0.1"
           LET g_prec_d[l_ac].prec040 = "0.1"
           LET g_prec_d[l_ac].prec041 = "0.1"
           LET g_prec_d[l_ac].prec042 = "0.1"
           LET g_prec_d[l_ac].prec043 = "0.1"
           LET g_prec_d[l_ac].prec044 = "0.1"
           LET g_prec_d[l_ac].prec045 = "0.1" 

           LET g_prec_d[l_ac].prec060 = '1'
           LET g_prec_d[l_ac].prec061 = '0'  
           
           LET g_prec_d[l_ac].prec081 = "0"    
           LET g_prec_d[l_ac].prec098 = "1"
           LET g_prec_d[l_ac].prec007 = "Y"           
           LET g_prec_d[l_ac].prec001 = g_prea_m.prea001
            SELECT MAX(precseq)+1 INTO g_prec_d[l_ac].precseq
              FROM prec_t
             WHERE precent = g_enterprise
               AND precdocno = g_prea_m.preadocno
            IF cl_null(g_prec_d[l_ac].precseq) THEN
               LET g_prec_d[l_ac].precseq = 1
            END IF      
            #151202-00007#1-----add---begin---20151208----
#取促銷方案的贈送起點和金額
            SELECT prcf047,prcf048 INTO g_prec_d[l_ac].prec009,g_prec_d[l_ac].prec010
              FROM prcf_t
             WHERE prcfent=g_enterprise
               AND prcf001=g_prea_m.prea003
            IF cl_null(g_prec_d[l_ac].prec009) THEN
               LET g_prec_d[l_ac].prec009 = "0"
            END IF
            IF cl_null(g_prec_d[l_ac].prec010) THEN
               LET g_prec_d[l_ac].prec010 = "0"
            END IF
            
            #單身錄入僅判斷此筆單據內，不同的類型（散客/會員等級1-5）買換力度一樣。
            IF g_prea_m.prea004='1'  THEN #買換  
               LET l_count=0
               SELECT COUNT(*) INTO l_count
                 FROM prec_t
                WHERE precent=g_enterprise
                  AND precdocno=g_prea_m.preadocno
               #單身有資料
               IF NOT cl_null(l_count) AND l_count>0 THEN
                  SELECT prec009,prec010,prec011,prec012,prec013,prec014,prec015,prec016,prec017,prec018,prec019,prec020
                    INTO g_prec_d[l_ac].prec009,g_prec_d[l_ac].prec010,g_prec_d[l_ac].prec011,g_prec_d[l_ac].prec012,g_prec_d[l_ac].prec013,
                         g_prec_d[l_ac].prec014,g_prec_d[l_ac].prec015,g_prec_d[l_ac].prec016,g_prec_d[l_ac].prec017,g_prec_d[l_ac].prec018,
                         g_prec_d[l_ac].prec019,g_prec_d[l_ac].prec020
                    FROM prec_t
                   WHERE precent=g_enterprise
                     AND precdocno=g_prea_m.preadocno
                     AND precseq=g_prec_d[l_ac].precseq-1 
               ELSE
                  LET g_prec_d[l_ac].prec011=g_prec_d[l_ac].prec009
                  LET g_prec_d[l_ac].prec013=g_prec_d[l_ac].prec009
                  LET g_prec_d[l_ac].prec015=g_prec_d[l_ac].prec009
                  LET g_prec_d[l_ac].prec017=g_prec_d[l_ac].prec009            
                  LET g_prec_d[l_ac].prec019=g_prec_d[l_ac].prec009 
                  
                  LET g_prec_d[l_ac].prec012=g_prec_d[l_ac].prec010
                  LET g_prec_d[l_ac].prec014=g_prec_d[l_ac].prec010
                  LET g_prec_d[l_ac].prec016=g_prec_d[l_ac].prec010
                  LET g_prec_d[l_ac].prec018=g_prec_d[l_ac].prec010            
                  LET g_prec_d[l_ac].prec020=g_prec_d[l_ac].prec010                
               END IF
            ELSE
            #151202-00007#1-----add---END---20151208----   
              
               LET g_prec_d[l_ac].prec011=g_prec_d[l_ac].prec009
               LET g_prec_d[l_ac].prec013=g_prec_d[l_ac].prec009
               LET g_prec_d[l_ac].prec015=g_prec_d[l_ac].prec009
               LET g_prec_d[l_ac].prec017=g_prec_d[l_ac].prec009            
               LET g_prec_d[l_ac].prec019=g_prec_d[l_ac].prec009 
               
               LET g_prec_d[l_ac].prec012=g_prec_d[l_ac].prec010
               LET g_prec_d[l_ac].prec014=g_prec_d[l_ac].prec010
               LET g_prec_d[l_ac].prec016=g_prec_d[l_ac].prec010
               LET g_prec_d[l_ac].prec018=g_prec_d[l_ac].prec010            
               LET g_prec_d[l_ac].prec020=g_prec_d[l_ac].prec010  

            END IF #151202-00007#1-----add
           
 
#“促销折扣率”：
#1:买换：折扣率 =(赠送金额-赠送起点)/赠送金额*100
#2:买送21赠卡：折扣率 =赠送金额/赠送起点*100
#2:买送11-19赠券：折扣率 =赠送金额/（赠送起点+赠送金额）*100
#3:买减：折扣率 = 赠送金额/赠送起点*100
#4:折扣: 折扣率 = 赠送金额/100*100
#5:倍换：折扣率 = (赠送金额-赠送起点)/赠送金额*100            
            IF cl_null(g_prec_d[l_ac].prec009) OR cl_null(g_prec_d[l_ac].prec010) THEN
               LET g_prec_d[l_ac].prec021 = 100
            END IF
            IF NOT cl_null(g_prec_d[l_ac].prec010) AND NOT cl_null(g_prec_d[l_ac].prec010) THEN
               IF g_prea_m.prea004='1' THEN
                  LET g_prec_d[l_ac].prec021 =(g_prec_d[l_ac].prec010-g_prec_d[l_ac].prec009)/g_prec_d[l_ac].prec010*100
               END IF
               IF g_prea_m.prea004='2' AND g_prea_m.prea005='1' THEN
                  LET g_prec_d[l_ac].prec021 =g_prec_d[l_ac].prec010/g_prec_d[l_ac].prec009*100
               END IF
               IF g_prea_m.prea004='2' AND g_prea_m.prea005='2' THEN
                  LET g_prec_d[l_ac].prec021 =g_prec_d[l_ac].prec010/(g_prec_d[l_ac].prec009+g_prec_d[l_ac].prec010)*100
               END IF    
               IF g_prea_m.prea004='3' THEN
                  LET g_prec_d[l_ac].prec021 =g_prec_d[l_ac].prec010/g_prec_d[l_ac].prec009*100
               END IF
               IF g_prea_m.prea004='4' THEN
                  LET g_prec_d[l_ac].prec021 =g_prec_d[l_ac].prec010
               END IF      
               IF g_prea_m.prea004='5' THEN
                  LET g_prec_d[l_ac].prec021 =(g_prec_d[l_ac].prec010-g_prec_d[l_ac].prec009)/g_prec_d[l_ac].prec010*100
               END IF               
            END IF    

               
            #end add-point
            LET g_prec_d_t.* = g_prec_d[l_ac].*     #新輸入資料
            LET g_prec_d_o.* = g_prec_d[l_ac].*     #新輸入資料
            CALL cl_show_fld_cont()
            CALL aprt310_set_entry_b(l_cmd)
            #add-point:modify段after_set_entry_b name="input.body.insert.after_set_entry_b"
            
            #end add-point
            CALL aprt310_set_no_entry_b(l_cmd)
            IF lb_reproduce THEN
               LET lb_reproduce = FALSE
               LET g_prec_d[li_reproduce_target].* = g_prec_d[li_reproduce].*
               LET g_prec2_d[li_reproduce_target].* = g_prec2_d[li_reproduce].*
 
               LET g_prec_d[li_reproduce_target].precseq = NULL
 
            END IF
            
 
 
            #add-point:modify段before insert name="input.body.before_insert"
            
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
            SELECT COUNT(1) INTO l_count FROM prec_t 
             WHERE precent = g_enterprise AND precdocno = g_prea_m.preadocno
 
               AND precseq = g_prec_d[l_ac].precseq
 
                
            #資料未重複, 插入新增資料
            IF l_count = 0 THEN 
               #add-point:單身新增前 name="input.body.b_insert"
               
               #end add-point
            
               #同步新增到同層的table
                              INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_prea_m.preadocno
               LET gs_keys[2] = g_prec_d[g_detail_idx].precseq
               CALL aprt310_insert_b('prec_t',gs_keys,"'1'")
                           
               #add-point:單身新增後 name="input.body.a_insert"
               
               #end add-point
            ELSE    
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = 'INSERT' 
               LET g_errparam.code = "std-00006" 
               LET g_errparam.popup = TRUE 
               INITIALIZE g_prec_d[l_ac].* TO NULL
               CALL s_transaction_end('N','0')
               CALL cl_err()
               CANCEL INSERT
            END IF
 
            IF SQLCA.SQLCODE THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "prec_t:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE 
               LET g_errparam.popup = TRUE 
               CALL s_transaction_end('N','0')                    
               CALL cl_err()
               CANCEL INSERT
            ELSE
               #先刷新資料
               #CALL aprt310_b_fill()
               #資料多語言用-增/改
               
               #add-point:input段-after_insert name="input.body.a_insert2"
               
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
               LET gs_keys[01] = g_prea_m.preadocno
 
               LET gs_keys[gs_keys.getLength()+1] = g_prec_d_t.precseq
 
            
               #刪除同層單身
               IF NOT aprt310_delete_b('prec_t',gs_keys,"'1'") THEN
                  CALL s_transaction_end('N','0')
                  CLOSE aprt310_bcl
                  CANCEL DELETE
               END IF
    
               #刪除下層單身
               IF NOT aprt310_key_delete_b(gs_keys,'prec_t') THEN
                  CALL s_transaction_end('N','0')
                  CLOSE aprt310_bcl
                  CANCEL DELETE
               END IF
               
               #刪除多語言
               
 
 
               
               #add-point:單身刪除中 name="input.body.m_delete"
               
               #end add-point 
               
               CALL s_transaction_end('Y','0')
               CLOSE aprt310_bcl
            
               LET g_rec_b = g_rec_b-1
               #add-point:單身刪除後 name="input.body.a_delete"
               
               #end add-point
               LET l_count = g_prec_d.getLength()
               
               #add-point:單身刪除後(<>d) name="input.body.after_delete"
               
               #end add-point
            END IF
 
         AFTER DELETE
            #如果是最後一筆
            IF l_ac = (g_prec_d.getLength() + 1) THEN
               CALL FGL_SET_ARR_CURR(l_ac-1)
            END IF
 
                  #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD precacti
            #add-point:BEFORE FIELD precacti name="input.b.page1.precacti"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD precacti
            
            #add-point:AFTER FIELD precacti name="input.a.page1.precacti"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE precacti
            #add-point:ON CHANGE precacti name="input.g.page1.precacti"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD precseq
            #add-point:BEFORE FIELD precseq name="input.b.page1.precseq"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD precseq
            
            #add-point:AFTER FIELD precseq name="input.a.page1.precseq"
            #應用 a05 樣板自動產生(Version:2)
            #確認資料無重複
            IF  g_prea_m.preadocno IS NOT NULL AND g_prec_d[g_detail_idx].precseq IS NOT NULL THEN 
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_prea_m.preadocno != g_preadocno_t OR g_prec_d[g_detail_idx].precseq != g_prec_d_t.precseq)) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM prec_t WHERE "||"precent = '" ||g_enterprise|| "' AND "||"precdocno = '"||g_prea_m.preadocno ||"' AND "|| "precseq = '"||g_prec_d[g_detail_idx].precseq ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF


            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE precseq
            #add-point:ON CHANGE precseq name="input.g.page1.precseq"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prec003
            
            #add-point:AFTER FIELD prec003 name="input.a.page1.prec003"
         IF NOT cl_null(g_prec_d[l_ac].prec003) THEN 
            #IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_prec_d[l_ac].prec003 != g_prec_d_t.prec003)) THEN   #160824-00007#147 20161123 mark  by beckxie
            IF (g_prec_d[l_ac].prec003 != g_prec_d_o.prec003) OR cl_null(g_prec_d_o.prec003) THEN   #160824-00007#147 20161123 add by beckxie
               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
               INITIALIZE g_chkparam.* TO NULL
               #設定g_chkparam.*的參數
               LET g_chkparam.arg1 = g_prea_m.preasite
               LET g_chkparam.arg2 = g_prec_d[l_ac].prec003
               #160318-00025#6--add--str
               LET g_errshow = TRUE 
               LET g_chkparam.err_str[1] = "aim-00065:sub-01302|aini001|",cl_get_progname("aini001",g_lang,"2"),"|:EXEPROGaini001"
               #160318-00025#6--add--end
               #呼叫檢查存在並帶值的library
               IF NOT cl_chk_exist("v_inaa001") THEN
                  #LET g_prec_d[l_ac].prec003 = g_prec_d_t.prec003   #160824-00007#147 20161123 mark by beckxie
                  #160824-00007#147 20161123 add by beckxie---S
                  LET g_prec_d[l_ac].prec003 = g_prec_d_o.prec003   
                  LET g_prec_d[l_ac].prec003_desc = g_prec_d_o.prec003_desc
                  LET g_prec_d[l_ac].prec004 = g_prec_d_o.prec004   
                  LET g_prec_d[l_ac].prec004_desc = g_prec_d_o.prec004_desc
                  LET g_prec_d[l_ac].prec005 = g_prec_d_o.prec005
                  LET g_prec_d[l_ac].prec005_desc = g_prec_d_o.prec005_desc
                  LET g_prec_d[l_ac].prec006 = g_prec_d_o.prec006
                  LET g_prec_d[l_ac].prec006_desc = g_prec_d_o.prec006_desc
                  LET g_prec_d[l_ac].prec059 = g_prec_d_o.prec059
                  LET g_prec_d[l_ac].prec057 = g_prec_d_o.prec057
                  LET g_prec_d[l_ac].prec058 = g_prec_d_o.prec058
                  LET g_prec_d[l_ac].prec055 = g_prec_d_o.prec055
                  LET g_prec_d[l_ac].prec056 = g_prec_d_o.prec056
                  LET g_prec_d[l_ac].prec063 = g_prec_d_o.prec063
                  LET g_prec_d[l_ac].prec064 = g_prec_d_o.prec064
                  LET g_prec_d[l_ac].prec065 = g_prec_d_o.prec065
                  LET g_prec_d[l_ac].prec066 = g_prec_d_o.prec066
                  LET g_prec_d[l_ac].prec067 = g_prec_d_o.prec067
                  LET g_prec_d[l_ac].prec068 = g_prec_d_o.prec068
                  LET g_prec_d[l_ac].prec070 = g_prec_d_o.prec070
                  LET g_prec_d[l_ac].prec071 = g_prec_d_o.prec071
                  LET g_prec_d[l_ac].prec075 = g_prec_d_o.prec075
                  LET g_prec_d[l_ac].prec053 = g_prec_d_o.prec053
                  LET g_prec_d[l_ac].prec054 = g_prec_d_o.prec054
                  LET g_prec_d[l_ac].prec072 = g_prec_d_o.prec072
                  LET g_prec_d[l_ac].prec073 = g_prec_d_o.prec073
                  #160824-00007#147 20161123 add by beckxie---E
                  NEXT FIELD CURRENT
               END IF
               SELECT inaa135 INTO l_inaa135
                 FROM inaa_t
                WHERE inaaent=g_enterprise
                  AND inaasite=g_prea_m.preasite
                  AND inaa001=g_prec_d[l_ac].prec003
               IF l_inaa135<>'2' THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'apr-00389'
                  LET g_errparam.extend = g_prec_d[l_ac].prec003
                  LET g_errparam.popup = TRUE
                  CALL cl_err()                
                  #LET g_prec_d[l_ac].prec003 = g_prec_d_t.prec003   #160824-00007#147 20161123 mark by beckxie
                  #160824-00007#147 20161123 add by beckxie---S
                  LET g_prec_d[l_ac].prec003 = g_prec_d_o.prec003   
                  LET g_prec_d[l_ac].prec003_desc = g_prec_d_o.prec003_desc
                  LET g_prec_d[l_ac].prec004 = g_prec_d_o.prec004   
                  LET g_prec_d[l_ac].prec004_desc = g_prec_d_o.prec004_desc
                  LET g_prec_d[l_ac].prec005 = g_prec_d_o.prec005
                  LET g_prec_d[l_ac].prec005_desc = g_prec_d_o.prec005_desc
                  LET g_prec_d[l_ac].prec006 = g_prec_d_o.prec006
                  LET g_prec_d[l_ac].prec006_desc = g_prec_d_o.prec006_desc
                  LET g_prec_d[l_ac].prec059 = g_prec_d_o.prec059
                  LET g_prec_d[l_ac].prec057 = g_prec_d_o.prec057
                  LET g_prec_d[l_ac].prec058 = g_prec_d_o.prec058
                  LET g_prec_d[l_ac].prec055 = g_prec_d_o.prec055
                  LET g_prec_d[l_ac].prec056 = g_prec_d_o.prec056
                  LET g_prec_d[l_ac].prec063 = g_prec_d_o.prec063
                  LET g_prec_d[l_ac].prec064 = g_prec_d_o.prec064
                  LET g_prec_d[l_ac].prec065 = g_prec_d_o.prec065
                  LET g_prec_d[l_ac].prec066 = g_prec_d_o.prec066
                  LET g_prec_d[l_ac].prec067 = g_prec_d_o.prec067
                  LET g_prec_d[l_ac].prec068 = g_prec_d_o.prec068
                  LET g_prec_d[l_ac].prec070 = g_prec_d_o.prec070
                  LET g_prec_d[l_ac].prec071 = g_prec_d_o.prec071
                  LET g_prec_d[l_ac].prec075 = g_prec_d_o.prec075
                  LET g_prec_d[l_ac].prec053 = g_prec_d_o.prec053
                  LET g_prec_d[l_ac].prec054 = g_prec_d_o.prec054
                  LET g_prec_d[l_ac].prec072 = g_prec_d_o.prec072
                  LET g_prec_d[l_ac].prec073 = g_prec_d_o.prec073
                  #160824-00007#147 20161123 add by beckxie---E
                  NEXT FIELD CURRENT                              
               END IF
               #促銷庫區不能重复 
                LET l_count=0
                SELECT count(*) INTO l_count
                  FROM prec_t
                 WHERE precent=g_enterprise
                   AND precdocno=g_prea_m.preadocno
                   AND precseq<>g_prec_d[l_ac].precseq
                   AND prec003=g_prec_d[l_ac].prec003
               IF l_count>0 AND NOT cl_null(l_count) THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'apr-00435'
                  LET g_errparam.extend = g_prec_d[l_ac].prec003
                  LET g_errparam.popup = TRUE
                  CALL cl_err()                
                  #LET g_prec_d[l_ac].prec003 = g_prec_d_t.prec003   #160824-00007#147 20161123 mark by beckxie
                  #160824-00007#147 20161123 add by beckxie---S
                  LET g_prec_d[l_ac].prec003 = g_prec_d_o.prec003   
                  LET g_prec_d[l_ac].prec003_desc = g_prec_d_o.prec003_desc
                  LET g_prec_d[l_ac].prec004 = g_prec_d_o.prec004   
                  LET g_prec_d[l_ac].prec004_desc = g_prec_d_o.prec004_desc
                  LET g_prec_d[l_ac].prec005 = g_prec_d_o.prec005
                  LET g_prec_d[l_ac].prec005_desc = g_prec_d_o.prec005_desc
                  LET g_prec_d[l_ac].prec006 = g_prec_d_o.prec006
                  LET g_prec_d[l_ac].prec006_desc = g_prec_d_o.prec006_desc
                  LET g_prec_d[l_ac].prec059 = g_prec_d_o.prec059
                  LET g_prec_d[l_ac].prec057 = g_prec_d_o.prec057
                  LET g_prec_d[l_ac].prec058 = g_prec_d_o.prec058
                  LET g_prec_d[l_ac].prec055 = g_prec_d_o.prec055
                  LET g_prec_d[l_ac].prec056 = g_prec_d_o.prec056
                  LET g_prec_d[l_ac].prec063 = g_prec_d_o.prec063
                  LET g_prec_d[l_ac].prec064 = g_prec_d_o.prec064
                  LET g_prec_d[l_ac].prec065 = g_prec_d_o.prec065
                  LET g_prec_d[l_ac].prec066 = g_prec_d_o.prec066
                  LET g_prec_d[l_ac].prec067 = g_prec_d_o.prec067
                  LET g_prec_d[l_ac].prec068 = g_prec_d_o.prec068
                  LET g_prec_d[l_ac].prec070 = g_prec_d_o.prec070
                  LET g_prec_d[l_ac].prec071 = g_prec_d_o.prec071
                  LET g_prec_d[l_ac].prec075 = g_prec_d_o.prec075
                  LET g_prec_d[l_ac].prec053 = g_prec_d_o.prec053
                  LET g_prec_d[l_ac].prec054 = g_prec_d_o.prec054
                  LET g_prec_d[l_ac].prec072 = g_prec_d_o.prec072
                  LET g_prec_d[l_ac].prec073 = g_prec_d_o.prec073
                  #160824-00007#147 20161123 add by beckxie---E
                  NEXT FIELD CURRENT                              
               END IF                
               #本筆資料中，同一常規庫區的促銷庫區只能有一筆資料
               #AOOS020---专柜库区商品化--Y:促销库区的M档资料---日期范围内，不能重叠。
               #-------------------------N:常規庫區下的促銷庫區的M檔資料--的日期範圍，與此筆申請單的日期範圍是否重疊
               LET l_flag=cl_get_para(g_enterprise,g_prea_m.preasite,'S-CIR-2011')
#              IF l_flag='N' THEN                #mark by yangxf 
               IF l_flag != '2' OR cl_null(l_flag) THEN   #add by yangxf 
                   SELECT inaa141 INTO l_inaa141
                     FROM inaa_t
                    WHERE inaaent=g_enterprise
                      AND inaa001=g_prec_d[l_ac].prec003 
                   LET l_count=0
                   SELECT count(*) INTO l_count
                     FROM prec_t
                    WHERE precent=g_enterprise
                      AND precdocno=g_prea_m.preadocno
                      AND prec003 IN (SELECT inaa001 FROM inaa_t WHERE inaa141=l_inaa141 AND inaaent = g_enterprise ) #add by geza 20160905 #160905-00007#13 add inaaent
                      AND precseq<>g_prec_d[l_ac].precseq
                  IF l_count>0 AND NOT cl_null(l_count) THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = 'apr-00427'
                     LET g_errparam.extend = g_prec_d[l_ac].prec003
                     LET g_errparam.popup = TRUE
                     CALL cl_err()                
                     #LET g_prec_d[l_ac].prec003 = g_prec_d_t.prec003   #160824-00007#147 20161123 mark by beckxie
                     #160824-00007#147 20161123 add by beckxie---S
                     LET g_prec_d[l_ac].prec003 = g_prec_d_o.prec003   
                     LET g_prec_d[l_ac].prec003_desc = g_prec_d_o.prec003_desc
                     LET g_prec_d[l_ac].prec004 = g_prec_d_o.prec004   
                     LET g_prec_d[l_ac].prec004_desc = g_prec_d_o.prec004_desc
                     LET g_prec_d[l_ac].prec005 = g_prec_d_o.prec005
                     LET g_prec_d[l_ac].prec005_desc = g_prec_d_o.prec005_desc
                     LET g_prec_d[l_ac].prec006 = g_prec_d_o.prec006
                     LET g_prec_d[l_ac].prec006_desc = g_prec_d_o.prec006_desc
                     LET g_prec_d[l_ac].prec059 = g_prec_d_o.prec059
                     LET g_prec_d[l_ac].prec057 = g_prec_d_o.prec057
                     LET g_prec_d[l_ac].prec058 = g_prec_d_o.prec058
                     LET g_prec_d[l_ac].prec055 = g_prec_d_o.prec055
                     LET g_prec_d[l_ac].prec056 = g_prec_d_o.prec056
                     LET g_prec_d[l_ac].prec063 = g_prec_d_o.prec063
                     LET g_prec_d[l_ac].prec064 = g_prec_d_o.prec064
                     LET g_prec_d[l_ac].prec065 = g_prec_d_o.prec065
                     LET g_prec_d[l_ac].prec066 = g_prec_d_o.prec066
                     LET g_prec_d[l_ac].prec067 = g_prec_d_o.prec067
                     LET g_prec_d[l_ac].prec068 = g_prec_d_o.prec068
                     LET g_prec_d[l_ac].prec070 = g_prec_d_o.prec070
                     LET g_prec_d[l_ac].prec071 = g_prec_d_o.prec071
                     LET g_prec_d[l_ac].prec075 = g_prec_d_o.prec075
                     LET g_prec_d[l_ac].prec053 = g_prec_d_o.prec053
                     LET g_prec_d[l_ac].prec054 = g_prec_d_o.prec054
                     LET g_prec_d[l_ac].prec072 = g_prec_d_o.prec072
                     LET g_prec_d[l_ac].prec073 = g_prec_d_o.prec073
                     #160824-00007#147 20161123 add by beckxie---E
                     NEXT FIELD CURRENT                              
                  END IF    
               END IF     
               
               #lanjj add on 2016-09-07 start 
#               SELECT COUNT(1) INTO l_countrtdx025
#                 FROM rtdx_t
#                WHERE rtdxent = g_enterprise
#                  AND rtdxsite = g_prea_m.preasite
#                  AND EXISTS ( SELECT 1 FROM rtei_t WHERE rteient = g_enterprise AND rtei001 =g_prec_d[l_ac].prec003 AND rtei002 = rtdx001)
#                  AND rtdx025 = 'N'
#               IF l_countrtdx025 > 0 THEN 
#                  INITIALIZE g_errparam TO NULL 
#                  LET g_errparam.extend = g_prec_d[l_ac].prec003," :该库区状态为不可售" 
#                  LET g_errparam.code   = "adz-00482"
#                  LET g_errparam.popup  = TRUE 
#                  CALL cl_err() 
#                  NEXT FIELD CURRENT
#               END IF 
                SELECT COUNT(1) INTO l_countrtdx025
                  FROM stfc_t,stfa_t
                 WHERE stfaent = stfcent
                   AND stfa001 = stfc001 
                   AND stfaent = g_enterprise #add by geza 20170122 #170122-00004#2 
                   AND stfc002 = g_prec_d[l_ac].prec003
                   AND stfa004 IN ('6','7')
                IF l_countrtdx025 > 0 THEN 
                   INITIALIZE g_errparam TO NULL 
                   LET g_errparam.extend = g_prec_d[l_ac].prec003," :该库区所属合同正清退中或已失效" 
                   LET g_errparam.code   = "adz-00482"
                   LET g_errparam.popup  = TRUE 
                   CALL cl_err() 
                   NEXT FIELD CURRENT
                END IF 
               #lanjj add on 2016-09-07 END 

               #lanjj add on 2016-10-24 start 判断导入的库区对应的常规库区在artq400可售否=N时，判断如果互动的开始日大于合同的开始日期，则不允许录入或导入该库区编号。

                SELECT rtdx025 INTO rtdx025_n FROM rtdx_t 
                 WHERE rtdxent = g_enterprise AND rtdxsite = g_prea_m.preasite
                   AND EXISTS ( SELECT 1 FROM stfc_t,stfa_t 
                                 WHERE stfcent = stfaent 
                                   AND stfc001 = stfa001 
                                   AND stfc001 = (select stfc001 FROM stfc_t WHERE stfc002 = g_prec_d[l_ac].prec003 AND rownum = 1 )
                                   AND stfc024 = '1'
                                   AND stfc002 = rtdx001 
                              )
                   AND EXISTS (SELECT 1
                                 FROM stfc_t
                                WHERE substr(stfc002,0,9) = substr(rtdx001,0,9)
                                  AND stfc002 = g_prec_d[l_ac].prec003) #lanjj add on 2017-01-03 找出唯一一笔常规库区
                              
                IF NOT cl_null(rtdx025_n) AND rtdx025_n = 'N' THEN 
                   SELECT stfc019 INTO l_stfc019_1 FROM stfc_t WHERE stfcent = g_enterprise AND stfc002 = g_prec_d[l_ac].prec003 AND rownum = 1
                   
                   SELECT preb003 INTO l_preb003_1 FROM preb_t WHERE prebent = g_enterprise AND prebdocno = g_prea_m.preadocno AND rownum = 1
                   
                   IF l_stfc019_1 > l_preb003_1 THEN
                      INITIALIZE g_errparam TO NULL 
                      LET g_errparam.extend = g_prec_d[l_ac].prec003," :该库区活动的开始日小于合同的开始日期且不可售，不可录入" 
                      LET g_errparam.code   = "adz-00482"
                      LET g_errparam.popup  = TRUE 
                      CALL cl_err() 
                      NEXT FIELD CURRENT
                   END IF 
                   
                END IF 
               #lanjj add on 2016-10-24 END  rtdx025_n,l_stfc019_1,l_preb003_1
               
               #管控統一個常規庫區對應的促銷庫區同一日期範圍內只能存在一筆                    
#               IF NOT aprt310_chck_prec003(g_prec_d[l_ac].prec003) THEN    #160720-00013#1   by 08172
               IF NOT s_aprt310_chk_prec003(g_prea_m.preadocno,g_prec_d[l_ac].prec003) THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'apr-00398'
                  LET g_errparam.extend = g_prec_d[l_ac].prec003
                  LET g_errparam.popup = TRUE
                  CALL cl_err()                
                  #LET g_prec_d[l_ac].prec003 = g_prec_d_t.prec003   #160824-00007#147 20161123 mark by beckxie
                  #160824-00007#147 20161123 add by beckxie---S
                  LET g_prec_d[l_ac].prec003 = g_prec_d_o.prec003   
                  LET g_prec_d[l_ac].prec003_desc = g_prec_d_o.prec003_desc
                  LET g_prec_d[l_ac].prec004 = g_prec_d_o.prec004   
                  LET g_prec_d[l_ac].prec004_desc = g_prec_d_o.prec004_desc
                  LET g_prec_d[l_ac].prec005 = g_prec_d_o.prec005
                  LET g_prec_d[l_ac].prec005_desc = g_prec_d_o.prec005_desc
                  LET g_prec_d[l_ac].prec006 = g_prec_d_o.prec006
                  LET g_prec_d[l_ac].prec006_desc = g_prec_d_o.prec006_desc
                  LET g_prec_d[l_ac].prec059 = g_prec_d_o.prec059
                  LET g_prec_d[l_ac].prec057 = g_prec_d_o.prec057
                  LET g_prec_d[l_ac].prec058 = g_prec_d_o.prec058
                  LET g_prec_d[l_ac].prec055 = g_prec_d_o.prec055
                  LET g_prec_d[l_ac].prec056 = g_prec_d_o.prec056
                  LET g_prec_d[l_ac].prec063 = g_prec_d_o.prec063
                  LET g_prec_d[l_ac].prec064 = g_prec_d_o.prec064
                  LET g_prec_d[l_ac].prec065 = g_prec_d_o.prec065
                  LET g_prec_d[l_ac].prec066 = g_prec_d_o.prec066
                  LET g_prec_d[l_ac].prec067 = g_prec_d_o.prec067
                  LET g_prec_d[l_ac].prec068 = g_prec_d_o.prec068
                  LET g_prec_d[l_ac].prec070 = g_prec_d_o.prec070
                  LET g_prec_d[l_ac].prec071 = g_prec_d_o.prec071
                  LET g_prec_d[l_ac].prec075 = g_prec_d_o.prec075
                  LET g_prec_d[l_ac].prec053 = g_prec_d_o.prec053
                  LET g_prec_d[l_ac].prec054 = g_prec_d_o.prec054
                  LET g_prec_d[l_ac].prec072 = g_prec_d_o.prec072
                  LET g_prec_d[l_ac].prec073 = g_prec_d_o.prec073
                  #160824-00007#147 20161123 add by beckxie---E
                  NEXT FIELD CURRENT                              
               END IF
               
               SELECT inaa120,inaa106 INTO g_prec_d[l_ac].prec004,g_prec_d[l_ac].prec006
                 FROM inaa_t
                WHERE inaaent=g_enterprise
                  AND inaasite=g_prea_m.preasite
                  AND inaa001=g_prec_d[l_ac].prec003 
                  
               SELECT mhae004 INTO g_prec_d[l_ac].prec005
                 FROM mhae_t
                WHERE mhaeent=g_enterprise
                  AND mhaesite=g_prea_m.preasite
                  AND mhae001=g_prec_d[l_ac].prec004
                  
               SELECT mhael023 INTO g_prec_d[l_ac].prec004_desc
                 FROM mhael_t
                WHERE mhaelent=g_enterprise
                  AND mhaelsite=g_prea_m.preasite
                  AND mhael022=g_dlang
                  AND mhael001=g_prec_d[l_ac].prec004
                  
              #促銷談判條件的開始日期，小於對應合約的生效日期，小於專櫃的進場日期，則報錯
               LET l_stfa019=''
               LET l_stfa017=''
               SELECT stfa019,stfa017 INTO l_stfa019,l_stfa017
                 FROM stfa_t
                WHERE stfaent=g_enterprise
                  AND stfa005=g_prec_d[l_ac].prec004
                  AND stfastus='Y'
               LET l_count=''
               SELECT COUNT(*) INTO l_count
                 FROM preb_t
                WHERE prebent=g_enterprise
                  AND prebdocno=g_prea_m.preadocno
                  AND prebacti='Y'
                  AND preb003<l_stfa019
               IF NOT cl_null(l_count) AND l_count>0 THEN
                  LET l_count=''
                  SELECT COUNT(*) INTO l_count
                    FROM preb_t
                   WHERE prebent=g_enterprise
                     AND prebdocno=g_prea_m.preadocno
                     AND prebacti='Y'
                     AND preb003<l_stfa017  
                  IF NOT cl_null(l_count) AND l_count>0 THEN                     
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = 'apr-00466'
                     LET g_errparam.extend = g_prec_d[l_ac].prec003
                     LET g_errparam.popup = TRUE
                     CALL cl_err()                
                     #LET g_prec_d[l_ac].prec003 = g_prec_d_t.prec003   #160824-00007#147 20161123 mark by beckxie
                     #160824-00007#147 20161123 add by beckxie---S
                     LET g_prec_d[l_ac].prec003 = g_prec_d_o.prec003   
                     LET g_prec_d[l_ac].prec003_desc = g_prec_d_o.prec003_desc
                     LET g_prec_d[l_ac].prec004 = g_prec_d_o.prec004   
                     LET g_prec_d[l_ac].prec004_desc = g_prec_d_o.prec004_desc
                     LET g_prec_d[l_ac].prec005 = g_prec_d_o.prec005
                     LET g_prec_d[l_ac].prec005_desc = g_prec_d_o.prec005_desc
                     LET g_prec_d[l_ac].prec006 = g_prec_d_o.prec006
                     LET g_prec_d[l_ac].prec006_desc = g_prec_d_o.prec006_desc
                     LET g_prec_d[l_ac].prec059 = g_prec_d_o.prec059
                     LET g_prec_d[l_ac].prec057 = g_prec_d_o.prec057
                     LET g_prec_d[l_ac].prec058 = g_prec_d_o.prec058
                     LET g_prec_d[l_ac].prec055 = g_prec_d_o.prec055
                     LET g_prec_d[l_ac].prec056 = g_prec_d_o.prec056
                     LET g_prec_d[l_ac].prec063 = g_prec_d_o.prec063
                     LET g_prec_d[l_ac].prec064 = g_prec_d_o.prec064
                     LET g_prec_d[l_ac].prec065 = g_prec_d_o.prec065
                     LET g_prec_d[l_ac].prec066 = g_prec_d_o.prec066
                     LET g_prec_d[l_ac].prec067 = g_prec_d_o.prec067
                     LET g_prec_d[l_ac].prec068 = g_prec_d_o.prec068
                     LET g_prec_d[l_ac].prec070 = g_prec_d_o.prec070
                     LET g_prec_d[l_ac].prec071 = g_prec_d_o.prec071
                     LET g_prec_d[l_ac].prec075 = g_prec_d_o.prec075
                     LET g_prec_d[l_ac].prec053 = g_prec_d_o.prec053
                     LET g_prec_d[l_ac].prec054 = g_prec_d_o.prec054
                     LET g_prec_d[l_ac].prec072 = g_prec_d_o.prec072
                     LET g_prec_d[l_ac].prec073 = g_prec_d_o.prec073
                     #160824-00007#147 20161123 add by beckxie---E
                     NEXT FIELD CURRENT
                  END IF                     
               END IF
                  
               #参与保底否                  
               SELECT stfa053 INTO g_prec_d[l_ac].prec059
                 FROM stfa_t
                WHERE stfaent=g_enterprise
                  AND stfa005=g_prec_d[l_ac].prec004
                  AND stfastus='Y'
                  AND stfa019<=g_today
                  AND stfa020>=g_today                 
#合同扣率----取常规库区的
                SELECT inaa141 INTO l_inaa141
                  FROM inaa_t
                 WHERE inaaent=g_enterprise
                   AND inaa001=g_prec_d[l_ac].prec003 
                   
               SELECT stfc018 INTO g_prec_d[l_ac].prec057
                 FROM stfc_t,stfa_t
                WHERE stfcent=g_enterprise
                  AND stfcent=stfaent
                  AND stfa001=stfc001
                  AND stfastus='Y'
                  AND stfa004 < 6       #lanjj add 2016-03-07  合同状态小于6
                  #AND stfa019<=g_today #lanjj mark 2016-03-07 
                  #AND stfa020>=g_today #lanjj mark 2016-03-07 
                  AND stfc002=l_inaa141
               IF cl_null(g_prec_d[l_ac].prec057) THEN
                  LET g_prec_d[l_ac].prec057=0
               END IF  
               #执行扣率=合同扣率+非VIP价内加扣点----150619-00010#3--add
               IF NOT cl_null(g_prec_d[l_ac].prec046) THEN
                  LET g_prec_d[l_ac].prec058=g_prec_d[l_ac].prec057+g_prec_d[l_ac].prec046
               END IF               
#保盈利價內加扣點                  
                LET  g_prec_d[l_ac].prec055=g_prec_d[l_ac].prec021-g_prec_d[l_ac].prec057 
#保本價內加扣點
                SELECT prcf030 INTO l_prcf030
                  FROM prcf_t
                 WHERE prcfent=g_enterprise
                   AND prcf001=g_prea_m.prea003
                IF cl_null(l_prcf030) THEN
                   LET l_prcf030=0
                END IF
                LET  g_prec_d[l_ac].prec056=g_prec_d[l_ac].prec055*(1-1/(1+l_prcf030))
                
#回款率
                LET  g_prec_d[l_ac].prec063=100-g_prec_d[l_ac].prec057-g_prec_d[l_ac].prec046
                LET  g_prec_d[l_ac].prec064=100-g_prec_d[l_ac].prec057-g_prec_d[l_ac].prec047
                LET  g_prec_d[l_ac].prec065=100-g_prec_d[l_ac].prec057-g_prec_d[l_ac].prec048
                LET  g_prec_d[l_ac].prec066=100-g_prec_d[l_ac].prec057-g_prec_d[l_ac].prec049
                LET  g_prec_d[l_ac].prec067=100-g_prec_d[l_ac].prec057-g_prec_d[l_ac].prec050
                LET  g_prec_d[l_ac].prec068=100-g_prec_d[l_ac].prec057-g_prec_d[l_ac].prec051
                LET  g_prec_d[l_ac].prec070=100-g_prec_d[l_ac].prec057-g_prec_d[l_ac].prec056
                LET  g_prec_d[l_ac].prec071=100-g_prec_d[l_ac].prec057-g_prec_d[l_ac].prec055
                IF cl_null(g_prec_d[l_ac].prec063) THEN
                   LET g_prec_d[l_ac].prec063=0
                END IF
                IF cl_null(g_prec_d[l_ac].prec064) THEN
                   LET g_prec_d[l_ac].prec064=0
                END IF
                IF cl_null(g_prec_d[l_ac].prec065) THEN
                   LET g_prec_d[l_ac].prec065=0
                END IF
                IF cl_null(g_prec_d[l_ac].prec067) THEN
                   LET g_prec_d[l_ac].prec067=0
                END IF
                IF cl_null(g_prec_d[l_ac].prec068) THEN
                   LET g_prec_d[l_ac].prec068=0
                END IF
                IF cl_null(g_prec_d[l_ac].prec070) THEN
                   LET g_prec_d[l_ac].prec070=0
                END IF
                IF cl_null(g_prec_d[l_ac].prec071) THEN
                   LET g_prec_d[l_ac].prec071=0
                END IF     
#評估結果
#1.  如果 价内加扣点<保本价内加扣点，则=重谈 '1'
#2.  如果价内加扣点>=保盈利价内点，则=成功 '2'
#3.  如果“保本价内加扣点<=价内加扣点<保盈价内加扣点 则=再争取  '3'
#4. 如果“保本价内加扣点<=价内加扣点<保盈价内加扣点   且<本次参考价内加扣点”，则=重谈
#5.  如果“保本价内加扣点<=价内加扣点<保盈价内加扣点   且>=本次参考价内加扣点且>最近一次价内加扣点”，则=可行   '4'
#6.  如果“保本价内加扣点<=价内加扣点 且>=本次参考价内加扣点,且<最近一次价内加扣点”，则=争取
#參考價內加扣點--暫時不用，此邏輯有問題，需重新整理
                IF g_prec_d[l_ac].prec046<g_prec_d[l_ac].prec056 THEN
                   LET g_prec_d[l_ac].prec075='1'
                END IF                 
                IF g_prec_d[l_ac].prec046>=g_prec_d[l_ac].prec055 THEN
                   LET g_prec_d[l_ac].prec075='2'
                END IF 
                IF g_prec_d[l_ac].prec056<=g_prec_d[l_ac].prec046 AND g_prec_d[l_ac].prec046<g_prec_d[l_ac].prec055 THEN
                   LET g_prec_d[l_ac].prec075='3'
                END IF
                IF g_prec_d[l_ac].prec056<=g_prec_d[l_ac].prec046 AND g_prec_d[l_ac].prec046<g_prec_d[l_ac].prec055 THEN
                   LET g_prec_d[l_ac].prec075='1'
                END IF   
                IF g_prec_d[l_ac].prec056<=g_prec_d[l_ac].prec046 AND g_prec_d[l_ac].prec046<g_prec_d[l_ac].prec055 AND g_prec_d[l_ac].prec046>g_prec_d[l_ac].prec053 THEN
                   LET g_prec_d[l_ac].prec075='4'
                END IF   
                IF g_prec_d[l_ac].prec056<=g_prec_d[l_ac].prec046 AND g_prec_d[l_ac].prec046>g_prec_d[l_ac].prec053 THEN
                   LET g_prec_d[l_ac].prec075='3'
                END IF               
                DISPLAY BY NAME g_prec_d[l_ac].prec075 
                
                DISPLAY BY NAME g_prec_d[l_ac].prec004,g_prec_d[l_ac].prec005,g_prec_d[l_ac].prec006,
                                g_prec_d[l_ac].prec021,g_prec_d[l_ac].prec055,g_prec_d[l_ac].prec056,
                                g_prec_d[l_ac].prec057,g_prec_d[l_ac].prec063,g_prec_d[l_ac].prec064,
                                g_prec_d[l_ac].prec065,g_prec_d[l_ac].prec066,g_prec_d[l_ac].prec067,
                                g_prec_d[l_ac].prec068,g_prec_d[l_ac].prec070,g_prec_d[l_ac].prec071
                                
#參考價內扣點：(资料来源于aprm310))同门店同库区同促銷方式最近时间的参考 非VIP价内加扣点--此欄位隱藏暫不給值
#最近價內扣點：同门店同库区同促銷方式最近时间的最近 非VIP价内加扣点(资料来源于aprm310)
#最高價內扣點：同门店同库区同促銷方式最高 非VIP价内加扣点 (资料来源于aprm310)
#最近回扣率：(资料来源于aprm310)同门店同库区同促銷方式最近 非VIP回款率
#最低回扣率：(资料来源于aprm310)同门店同库区同促銷方式最小 非VIP回款率
               SELECT prei046 INTO g_prec_d[l_ac].prec053
                 FROM prei_t,preg_t
                WHERE preient=pregent
                  AND prei001=preg001
                  AND preiacti='Y'
                  AND pregstus<>'X'
                  AND pregsite=g_prea_m.preasite
                  AND prei003=g_prec_d[l_ac].prec003
                  AND preg004=g_prea_m.prea004
                  AND pregcrtdt=(SELECT MAX(pregcrtdt) 
                                   FROM prei_t,preg_t
                                  WHERE preient=pregent
                                    AND prei001=preg001
                                    AND preiacti='Y'
                                    AND pregstus<>'X'
                                    AND pregsite=g_prea_m.preasite
                                    AND prei003=g_prec_d[l_ac].prec003
                                    AND preg004=g_prea_m.prea004
                                  )
               IF cl_null(g_prec_d[l_ac].prec053) THEN
                  LET g_prec_d[l_ac].prec053=0
               END IF               
               SELECT MAX(prei046) INTO g_prec_d[l_ac].prec054
                 FROM prei_t,preg_t
                WHERE preient=pregent
                  AND prei001=preg001
                  AND preiacti='Y'
                  AND pregstus<>'X'
                  AND pregsite=g_prea_m.preasite
                  AND prei003=g_prec_d[l_ac].prec003
                  AND preg004=g_prea_m.prea004
               IF cl_null(g_prec_d[l_ac].prec054) THEN
                  LET g_prec_d[l_ac].prec054=0
               END IF    
               
               SELECT prei063 INTO g_prec_d[l_ac].prec072
                 FROM prei_t,preg_t
                WHERE preient=pregent
                  AND prei001=preg001
                  AND preiacti='Y'
                  AND pregstus<>'X'
                  AND pregsite=g_prea_m.preasite
                  AND prei003=g_prec_d[l_ac].prec003
                  AND preg004=g_prea_m.prea004
                  AND pregcrtdt=(SELECT MAX(pregcrtdt) 
                                   FROM prei_t,preg_t
                                  WHERE preient=pregent
                                    AND prei001=preg001
                                    AND preiacti='Y'
                                    AND pregstus<>'X'
                                    AND pregsite=g_prea_m.preasite
                                    AND prei003=g_prec_d[l_ac].prec003
                                    AND preg004=g_prea_m.prea004
                                  )
               IF cl_null(g_prec_d[l_ac].prec072) THEN
                  LET g_prec_d[l_ac].prec072=0
               END IF 
               SELECT MIN(prei063) INTO g_prec_d[l_ac].prec073
                 FROM prei_t,preg_t
                WHERE preient=pregent
                  AND prei001=preg001
                  AND preiacti='Y'
                  AND pregstus<>'X'
                  AND pregsite=g_prea_m.preasite
                  AND prei003=g_prec_d[l_ac].prec003
                  AND preg004=g_prea_m.prea004               
               IF cl_null(g_prec_d[l_ac].prec073) THEN
                  LET g_prec_d[l_ac].prec073=0
               END IF   
               
               DISPLAY BY NAME g_prec_d[l_ac].prec053,g_prec_d[l_ac].prec054,g_prec_d[l_ac].prec072,g_prec_d[l_ac].prec073
            END IF
         END IF            
            
         INITIALIZE g_ref_fields TO NULL
         LET g_ref_fields[1] = g_prec_d[l_ac].prec006
         CALL ap_ref_array2(g_ref_fields,"SELECT rtaxl003 FROM rtaxl_t WHERE rtaxlent='"||g_enterprise||"' AND rtaxl001=? AND rtaxl002='"||g_dlang||"'","") RETURNING g_rtn_fields
         LET g_prec_d[l_ac].prec006_desc = '', g_rtn_fields[1] , ''
         DISPLAY BY NAME g_prec_d[l_ac].prec006_desc
         
         
         INITIALIZE g_ref_fields TO NULL
         LET g_ref_fields[1] = g_prec_d[l_ac].prec005
         CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
         LET g_prec_d[l_ac].prec005_desc = '', g_rtn_fields[1] , ''
         DISPLAY BY NAME g_prec_d[l_ac].prec005_desc
          
         INITIALIZE g_ref_fields TO NULL
         LET g_ref_fields[1] = g_prec_d[l_ac].prec003
         CALL ap_ref_array2(g_ref_fields,"SELECT inayl003 FROM inayl_t WHERE inaylent='"||g_enterprise||"' AND inayl001=? AND inayl002='"||g_dlang||"'","") RETURNING g_rtn_fields
         LET g_prec_d[l_ac].prec003_desc = '', g_rtn_fields[1] , ''
         DISPLAY BY NAME g_prec_d[l_ac].prec003_desc


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prec003
            #add-point:BEFORE FIELD prec003 name="input.b.page1.prec003"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE prec003
            #add-point:ON CHANGE prec003 name="input.g.page1.prec003"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prec004
            
            #add-point:AFTER FIELD prec004 name="input.a.page1.prec004"
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_prea_m.preasite
            LET g_ref_fields[2] = g_prec_d[l_ac].prec004
            CALL ap_ref_array2(g_ref_fields,"SELECT mhael023 FROM mhael_t WHERE mhaelent='"||g_enterprise||"' AND mhaelsite=? AND mhael001=? AND mhael022='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_prec_d[l_ac].prec004_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_prec_d[l_ac].prec004_desc


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prec004
            #add-point:BEFORE FIELD prec004 name="input.b.page1.prec004"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE prec004
            #add-point:ON CHANGE prec004 name="input.g.page1.prec004"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prec005
            
            #add-point:AFTER FIELD prec005 name="input.a.page1.prec005"
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_prec_d[l_ac].prec005
            CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_prec_d[l_ac].prec005_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_prec_d[l_ac].prec005_desc


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prec005
            #add-point:BEFORE FIELD prec005 name="input.b.page1.prec005"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE prec005
            #add-point:ON CHANGE prec005 name="input.g.page1.prec005"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prec006
            
            #add-point:AFTER FIELD prec006 name="input.a.page1.prec006"
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_prec_d[l_ac].prec006
            CALL ap_ref_array2(g_ref_fields,"SELECT rtaxl003 FROM rtaxl_t WHERE rtaxlent='"||g_enterprise||"' AND rtaxl001=? AND rtaxl002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_prec_d[l_ac].prec006_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_prec_d[l_ac].prec006_desc


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prec006
            #add-point:BEFORE FIELD prec006 name="input.b.page1.prec006"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE prec006
            #add-point:ON CHANGE prec006 name="input.g.page1.prec006"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prec007
            #add-point:BEFORE FIELD prec007 name="input.b.page1.prec007"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prec007
            
            #add-point:AFTER FIELD prec007 name="input.a.page1.prec007"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE prec007
            #add-point:ON CHANGE prec007 name="input.g.page1.prec007"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prec008
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_prec_d[l_ac].prec008,"0","1","","","azz-00079",1) THEN
               NEXT FIELD prec008
            END IF 
 
 
 
            #add-point:AFTER FIELD prec008 name="input.a.page1.prec008"
            IF NOT cl_null(g_prec_d[l_ac].prec008) THEN 
            END IF 


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prec008
            #add-point:BEFORE FIELD prec008 name="input.b.page1.prec008"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE prec008
            #add-point:ON CHANGE prec008 name="input.g.page1.prec008"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prec009
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_prec_d[l_ac].prec009,"0","1","","","azz-00079",1) THEN
               NEXT FIELD prec009
            END IF 
 
 
 
            #add-point:AFTER FIELD prec009 name="input.a.page1.prec009"

            IF NOT cl_null(g_prec_d[l_ac].prec009) THEN
               IF NOT cl_null(g_prec_d[l_ac].prec010) THEN
                  #151202-00007#1-----add---begin---20151203----
                  #買換--控管同一门店，同一日期範圍內換贈的卡種/券種，不同的類型（散客/會員等級1-5）買換力度一樣
                  #單身錄入僅判斷此筆單據內，不同的類型（散客/會員等級1-5）買換力度一樣，審核時候再嚴格檢查判斷。
                  IF g_prea_m.prea004='1'  THEN #買換           
                     #IF l_cmd='a' OR (l_cmd='u' AND g_prec_d[l_ac].prec009<>g_prec_d_t.prec009) THEN   #160824-00007#147 20161123 mark by beckxie
                     IF g_prec_d[l_ac].prec009<>g_prec_d_o.prec009 OR cl_null(g_prec_d_o.prec009) THEN   #160824-00007#147 20161123 add by beckxie
                        #力度判斷---力度=起點/贈送
                        #防止出現無盡小數，採用以下對比方式
                        LET l_num20=g_prec_d[l_ac].prec009/g_prec_d[l_ac].prec010
                        LET l_num20_2=''
                        SELECT DISTINCT(prec009/prec010) INTO l_num20_2
                          FROM prec_t
                         WHERE precent=g_enterprise
                           AND precdocno=g_prea_m.preadocno
                           AND precseq<>g_prec_d[l_ac].precseq  
                        IF NOT cl_null(l_num20_2) AND l_num20_2<>l_num20 THEN
                           INITIALIZE g_errparam TO NULL
                           LET g_errparam.code = 'apr-00486'
                           LET g_errparam.extend = ''
                           LET g_errparam.popup = TRUE
                           CALL cl_err()                
                           #LET g_prec_d[l_ac].prec009 = g_prec_d_t.prec009   #160824-00007#147 20161123 mark by beckxie
                           #160824-00007#147 20161123 add by beckxie---S
                           LET g_prec_d[l_ac].prec009 = g_prec_d_o.prec009
                           LET g_prec_d[l_ac].prec021 = g_prec_d_o.prec021
                           LET g_prec_d[l_ac].prec055 = g_prec_d_o.prec055
                           LET g_prec_d[l_ac].prec056 = g_prec_d_o.prec056
                           LET g_prec_d[l_ac].prec070 = g_prec_d_o.prec070
                           LET g_prec_d[l_ac].prec071 = g_prec_d_o.prec071
                           LET g_prec_d[l_ac].prec075 = g_prec_d_o.prec075
                           LET g_prec_d[l_ac].prec011 = g_prec_d_o.prec011
                           LET g_prec_d[l_ac].prec013 = g_prec_d_o.prec013
                           LET g_prec_d[l_ac].prec015 = g_prec_d_o.prec015
                           LET g_prec_d[l_ac].prec017 = g_prec_d_o.prec017
                           LET g_prec_d[l_ac].prec019 = g_prec_d_o.prec019
                           #160824-00007#147 20161123 add by beckxie---E
                           NEXT FIELD CURRENT                                      
                        END IF
                        
                     END IF 
                  END IF
                  #151202-00007#1-----add---end---20151203----     
                  
                             
                  IF g_prea_m.prea004='1' THEN
                     LET g_prec_d[l_ac].prec021 =(g_prec_d[l_ac].prec010-g_prec_d[l_ac].prec009)/g_prec_d[l_ac].prec010*100
                  END IF
                  IF g_prea_m.prea004='2' AND g_prea_m.prea005='1' THEN
                     LET g_prec_d[l_ac].prec021 =g_prec_d[l_ac].prec010/g_prec_d[l_ac].prec009*100
                  END IF
                  IF g_prea_m.prea004='2' AND g_prea_m.prea005='2' THEN
                     LET g_prec_d[l_ac].prec021 =g_prec_d[l_ac].prec010/(g_prec_d[l_ac].prec009+g_prec_d[l_ac].prec010)*100
                  END IF    
                  IF g_prea_m.prea004='3' THEN
                     LET g_prec_d[l_ac].prec021 =g_prec_d[l_ac].prec010/g_prec_d[l_ac].prec009*100
                  END IF
                  IF g_prea_m.prea004='4' THEN
                     LET g_prec_d[l_ac].prec021 =g_prec_d[l_ac].prec010
                  END IF      
                  IF g_prea_m.prea004='5' THEN
                     LET g_prec_d[l_ac].prec021 =(g_prec_d[l_ac].prec010-g_prec_d[l_ac].prec009)/g_prec_d[l_ac].prec010*100
                  END IF  
#保盈利價內加扣點                    
                  LET  g_prec_d[l_ac].prec055=g_prec_d[l_ac].prec021-g_prec_d[l_ac].prec057 
#保本價內加扣點    
                  SELECT prcf030 INTO l_prcf030
                    FROM prcf_t
                   WHERE prcfent=g_enterprise
                     AND prcf001=g_prea_m.prea003
                  IF cl_null(l_prcf030) THEN
                     LET l_prcf030=0
                  END IF
                  LET  g_prec_d[l_ac].prec056=g_prec_d[l_ac].prec055*(1-1/(1+l_prcf030))                  
#回款率           
                  LET  g_prec_d[l_ac].prec070=100-g_prec_d[l_ac].prec057-g_prec_d[l_ac].prec056
                  LET  g_prec_d[l_ac].prec071=100-g_prec_d[l_ac].prec057-g_prec_d[l_ac].prec055
                  IF cl_null(g_prec_d[l_ac].prec070) THEN
                     LET g_prec_d[l_ac].prec070=0
                  END IF
                  IF cl_null(g_prec_d[l_ac].prec071) THEN
                     LET g_prec_d[l_ac].prec071=0
                  END IF 
                  DISPLAY BY NAME g_prec_d[l_ac].prec055  
                  DISPLAY BY NAME g_prec_d[l_ac].prec056  
                  DISPLAY BY NAME g_prec_d[l_ac].prec070
                  DISPLAY BY NAME g_prec_d[l_ac].prec071
#評估結果
#1.  如果 价内加扣点<保本价内加扣点，则=重谈 '1'
#2.  如果价内加扣点>=保盈利价内点，则=成功 '2'
#3.  如果“保本价内加扣点<=价内加扣点<保盈价内加扣点 则=再争取  '3'
#4. 如果“保本价内加扣点<=价内加扣点<保盈价内加扣点   且<本次参考价内加扣点”，则=重谈
#5.  如果“保本价内加扣点<=价内加扣点<保盈价内加扣点   且>=本次参考价内加扣点且>最近一次价内加扣点”，则=可行   '4'
#6.  如果“保本价内加扣点<=价内加扣点 且>=本次参考价内加扣点,且<最近一次价内加扣点”，则=争取
#參考價內加扣點--暫時不用，此邏輯有問題，需重新整理
                  IF g_prec_d[l_ac].prec046<g_prec_d[l_ac].prec056 THEN
                     LET g_prec_d[l_ac].prec075='1'
                  END IF                 
                  IF g_prec_d[l_ac].prec046>=g_prec_d[l_ac].prec055 THEN
                     LET g_prec_d[l_ac].prec075='2'
                  END IF 
                  IF g_prec_d[l_ac].prec056<=g_prec_d[l_ac].prec046 AND g_prec_d[l_ac].prec046<g_prec_d[l_ac].prec055 THEN
                     LET g_prec_d[l_ac].prec075='3'
                  END IF
                  IF g_prec_d[l_ac].prec056<=g_prec_d[l_ac].prec046 AND g_prec_d[l_ac].prec046<g_prec_d[l_ac].prec055 THEN
                     LET g_prec_d[l_ac].prec075='1'
                  END IF   
                  IF g_prec_d[l_ac].prec056<=g_prec_d[l_ac].prec046 AND g_prec_d[l_ac].prec046<g_prec_d[l_ac].prec055 AND g_prec_d[l_ac].prec046>g_prec_d[l_ac].prec053 THEN
                     LET g_prec_d[l_ac].prec075='4'
                  END IF   
                  IF g_prec_d[l_ac].prec056<=g_prec_d[l_ac].prec046 AND g_prec_d[l_ac].prec046>g_prec_d[l_ac].prec053 THEN
                     LET g_prec_d[l_ac].prec075='3'
                  END IF               
                  DISPLAY BY NAME g_prec_d[l_ac].prec075                  
               END IF
               
               #151202-00007#1---add---begin----
               #單身是否有資料
               LET l_count=0
               SELECT COUNT(*) INTO l_count
                 FROM prec_t
                WHERE precent=g_enterprise
                  AND precdocno=g_prea_m.preadocno
                  AND precseq<>g_prec_d[l_ac].precseq
               IF g_prea_m.prea004<>'1' OR (cl_null(l_count) OR l_count=0)  THEN #非買換
               #151202-00007#1---add---end----               
                  #IF l_cmd='a' OR (l_cmd='u' AND g_prec_d[l_ac].prec009<>g_prec_d_t.prec009) THEN   #160824-00007#147 20161123 mark by beckxie
                  IF g_prec_d[l_ac].prec009<>g_prec_d_o.prec009 OR cl_null(g_prec_d_o.prec009) THEN   #160824-00007#147 20161123 add by beckxie
                     LET g_prec_d[l_ac].prec011=g_prec_d[l_ac].prec009
                     LET g_prec_d[l_ac].prec013=g_prec_d[l_ac].prec009
                     LET g_prec_d[l_ac].prec015=g_prec_d[l_ac].prec009
                     LET g_prec_d[l_ac].prec017=g_prec_d[l_ac].prec009            
                     LET g_prec_d[l_ac].prec019=g_prec_d[l_ac].prec009 
                  END IF
               END IF #151202-00007#1---add
            END IF
            #LET g_prec_d[l_ac].prec012=g_prec_d[l_ac].prec010
            #LET g_prec_d[l_ac].prec014=g_prec_d[l_ac].prec010
            #LET g_prec_d[l_ac].prec016=g_prec_d[l_ac].prec010
            #LET g_prec_d[l_ac].prec018=g_prec_d[l_ac].prec010            
            #LET g_prec_d[l_ac].prec020=g_prec_d[l_ac].prec010 
            
            LET g_prec_d_o.* = g_prec_d[l_ac].* #160824-00007#147 20161123 add by beckxie

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prec009
            #add-point:BEFORE FIELD prec009 name="input.b.page1.prec009"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE prec009
            #add-point:ON CHANGE prec009 name="input.g.page1.prec009"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prec010
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_prec_d[l_ac].prec010,"0","0","","","azz-00079",1) THEN
               NEXT FIELD prec010
            END IF 
 
 
 
            #add-point:AFTER FIELD prec010 name="input.a.page1.prec010"
            IF NOT cl_null(g_prec_d[l_ac].prec010) THEN
               IF NOT cl_null(g_prec_d[l_ac].prec009) THEN
                  #151202-00007#1-----add---begin---20151203----
                  #買換--控管同一门店，同一日期範圍內換贈的卡種/券種，不同的類型（散客/會員等級1-5）買換力度一樣
                  #單身錄入僅判斷此筆單據內，不同的類型（散客/會員等級1-5）買換力度一樣，審核時候再嚴格檢查判斷。
                  IF g_prea_m.prea004='1'  THEN #買換           
                     #IF l_cmd='a' OR (l_cmd='u' AND g_prec_d[l_ac].prec010<>g_prec_d_t.prec010) THEN   #160824-00007#147 20161123 mark by beckxie
                     IF g_prec_d[l_ac].prec010<>g_prec_d_o.prec010 OR cl_null(g_prec_d_o.prec010) THEN   #160824-00007#147 20161123 add by beckxie
                        #力度判斷---力度=起點/贈送
                        #防止出現無盡小數，採用以下對比方式
                        LET l_num20=g_prec_d[l_ac].prec009/g_prec_d[l_ac].prec010
                        LET l_num20_2=''
                        SELECT DISTINCT(prec009/prec010) INTO l_num20_2
                          FROM prec_t
                         WHERE precent=g_enterprise
                           AND precdocno=g_prea_m.preadocno
                           AND precseq<>g_prec_d[l_ac].precseq  
                        IF NOT cl_null(l_num20_2) AND l_num20_2<>l_num20 THEN
                           INITIALIZE g_errparam TO NULL
                           LET g_errparam.code = 'apr-00486'
                           LET g_errparam.extend = ''
                           LET g_errparam.popup = TRUE
                           CALL cl_err()                
                           #LET g_prec_d[l_ac].prec010 = g_prec_d_t.prec010   #160824-00007#147 20161123 mark by beckxie
                           #160824-00007#147 20161123 add by beckxie---S
                           LET g_prec_d[l_ac].prec010 = g_prec_d_o.prec010
                           LET g_prec_d[l_ac].prec021 = g_prec_d_o.prec021
                           LET g_prec_d[l_ac].prec055 = g_prec_d_o.prec055
                           LET g_prec_d[l_ac].prec056 = g_prec_d_o.prec056
                           LET g_prec_d[l_ac].prec070 = g_prec_d_o.prec070
                           LET g_prec_d[l_ac].prec071 = g_prec_d_o.prec071
                           LET g_prec_d[l_ac].prec075 = g_prec_d_o.prec075
                           LET g_prec_d[l_ac].prec012 = g_prec_d_o.prec012
                           LET g_prec_d[l_ac].prec071 = g_prec_d_o.prec071
                           LET g_prec_d[l_ac].prec012 = g_prec_d_o.prec012
                           LET g_prec_d[l_ac].prec014 = g_prec_d_o.prec014
                           LET g_prec_d[l_ac].prec016 = g_prec_d_o.prec016
                           LET g_prec_d[l_ac].prec018 = g_prec_d_o.prec018
                           LET g_prec_d[l_ac].prec020 = g_prec_d_o.prec020
                           #160824-00007#147 20161123 add by beckxie---E
                           NEXT FIELD CURRENT                                      
                        END IF
                        
                     END IF 
                  END IF
                  #151202-00007#1-----add---end---20151203----  
                  
                  IF g_prea_m.prea004='1' THEN
                     LET g_prec_d[l_ac].prec021 =(g_prec_d[l_ac].prec010-g_prec_d[l_ac].prec009)/g_prec_d[l_ac].prec010*100
                  END IF
                  IF g_prea_m.prea004='2' AND g_prea_m.prea005='1' THEN
                     LET g_prec_d[l_ac].prec021 =g_prec_d[l_ac].prec010/g_prec_d[l_ac].prec009*100
                  END IF
                  IF g_prea_m.prea004='2' AND g_prea_m.prea005='2' THEN
                     LET g_prec_d[l_ac].prec021 =g_prec_d[l_ac].prec010/(g_prec_d[l_ac].prec009+g_prec_d[l_ac].prec010)*100
                  END IF    
                  IF g_prea_m.prea004='3' THEN
                     LET g_prec_d[l_ac].prec021 =g_prec_d[l_ac].prec010/g_prec_d[l_ac].prec009*100
                  END IF
                  IF g_prea_m.prea004='4' THEN
                     LET g_prec_d[l_ac].prec021 =g_prec_d[l_ac].prec010
                  END IF      
                  IF g_prea_m.prea004='5' THEN
                     LET g_prec_d[l_ac].prec021 =(g_prec_d[l_ac].prec010-g_prec_d[l_ac].prec009)/g_prec_d[l_ac].prec010*100
                  END IF  
#保盈利價內加扣點                    
                  LET  g_prec_d[l_ac].prec055=g_prec_d[l_ac].prec021-g_prec_d[l_ac].prec057 
#保本價內加扣點    
                  SELECT prcf030 INTO l_prcf030
                    FROM prcf_t
                   WHERE prcfent=g_enterprise
                     AND prcf001=g_prea_m.prea003
                  IF cl_null(l_prcf030) THEN
                     LET l_prcf030=0
                  END IF
                  LET  g_prec_d[l_ac].prec056=g_prec_d[l_ac].prec055*(1-1/(1+l_prcf030))                  
#回款率           
                  LET  g_prec_d[l_ac].prec070=100-g_prec_d[l_ac].prec057-g_prec_d[l_ac].prec056
                  LET  g_prec_d[l_ac].prec071=100-g_prec_d[l_ac].prec057-g_prec_d[l_ac].prec055
                  IF cl_null(g_prec_d[l_ac].prec070) THEN
                     LET g_prec_d[l_ac].prec070=0
                  END IF
                  IF cl_null(g_prec_d[l_ac].prec071) THEN
                     LET g_prec_d[l_ac].prec071=0
                  END IF 
#評估結果
#1.  如果 价内加扣点<保本价内加扣点，则=重谈 '1'
#2.  如果价内加扣点>=保盈利价内点，则=成功 '2'
#3.  如果“保本价内加扣点<=价内加扣点<保盈价内加扣点 则=再争取  '3'
#4. 如果“保本价内加扣点<=价内加扣点<保盈价内加扣点   且<本次参考价内加扣点”，则=重谈
#5.  如果“保本价内加扣点<=价内加扣点<保盈价内加扣点   且>=本次参考价内加扣点且>最近一次价内加扣点”，则=可行   '4'
#6.  如果“保本价内加扣点<=价内加扣点 且>=本次参考价内加扣点,且<最近一次价内加扣点”，则=争取
#參考價內加扣點--暫時不用，此邏輯有問題，需重新整理
                  IF g_prec_d[l_ac].prec046<g_prec_d[l_ac].prec056 THEN
                     LET g_prec_d[l_ac].prec075='1'
                  END IF                 
                  IF g_prec_d[l_ac].prec046>=g_prec_d[l_ac].prec055 THEN
                     LET g_prec_d[l_ac].prec075='2'
                  END IF 
                  IF g_prec_d[l_ac].prec056<=g_prec_d[l_ac].prec046 AND g_prec_d[l_ac].prec046<g_prec_d[l_ac].prec055 THEN
                     LET g_prec_d[l_ac].prec075='3'
                  END IF
                  IF g_prec_d[l_ac].prec056<=g_prec_d[l_ac].prec046 AND g_prec_d[l_ac].prec046<g_prec_d[l_ac].prec055 THEN
                     LET g_prec_d[l_ac].prec075='1'
                  END IF   
                  IF g_prec_d[l_ac].prec056<=g_prec_d[l_ac].prec046 AND g_prec_d[l_ac].prec046<g_prec_d[l_ac].prec055 AND g_prec_d[l_ac].prec046>g_prec_d[l_ac].prec053 THEN
                     LET g_prec_d[l_ac].prec075='4'
                  END IF   
                  IF g_prec_d[l_ac].prec056<=g_prec_d[l_ac].prec046 AND g_prec_d[l_ac].prec046>g_prec_d[l_ac].prec053 THEN
                     LET g_prec_d[l_ac].prec075='3'
                  END IF               
                  DISPLAY BY NAME g_prec_d[l_ac].prec075                     
                  DISPLAY BY NAME g_prec_d[l_ac].prec055  
                  DISPLAY BY NAME g_prec_d[l_ac].prec056  
                  DISPLAY BY NAME g_prec_d[l_ac].prec070
                  DISPLAY BY NAME g_prec_d[l_ac].prec071                   
               END IF
               #IF l_cmd='a' OR (l_cmd='u' AND g_prec_d[l_ac].prec010<>g_prec_d_t.prec010) THEN   #160824-00007#147 20161123 mark by beckxie
               IF g_prec_d[l_ac].prec010<>g_prec_d_o.prec010 OR cl_null(g_prec_d_o.prec010) THEN   #160824-00007#147 20161123 add by beckxie
                  #150922-00016--add--begin---20151026--by huangrh---
                  IF g_prea_m.prea005='2' AND NOT cl_null(g_prea_m.prea006) THEN
                     #若為券，單身贈送金額與券面額不一致需提示,僅提示！
                     SELECT oocq009 INTO l_oocq009
                       FROM oocq_t,gcaf_t
                      WHERE oocqent=gcafent
                        AND gcaf001=g_prea_m.prea006
                        AND oocqent=g_enterprise
                        AND oocq001='2071'
                        AND oocq002=gcaf012
                     LET l_prec010=l_oocq009
                     
                     IF g_prec_d[l_ac].prec010<>l_prec010 THEN 
                         INITIALIZE g_errparam TO NULL
                         LET g_errparam.extend = ''
                         LET g_errparam.code   = 'apr-00471'
                         LET g_errparam.popup  = TRUE
                         CALL cl_err()                            
                     END IF
                  END IF
                  #150922-00016--add--end---20151026--by huangrh---   

                  #151202-00007#1---add---begin----
                  #單身是否有資料
                  LET l_count=0
                  SELECT COUNT(*) INTO l_count
                    FROM prec_t
                   WHERE precent=g_enterprise
                     AND precdocno=g_prea_m.preadocno
                     AND precseq<>g_prec_d[l_ac].precseq
                  IF g_prea_m.prea004<>'1' OR (cl_null(l_count) OR l_count=0)  THEN #非買換
                  #151202-00007#1---add---end----    
                     LET g_prec_d[l_ac].prec012=g_prec_d[l_ac].prec010
                     LET g_prec_d[l_ac].prec014=g_prec_d[l_ac].prec010
                     LET g_prec_d[l_ac].prec016=g_prec_d[l_ac].prec010
                     LET g_prec_d[l_ac].prec018=g_prec_d[l_ac].prec010            
                     LET g_prec_d[l_ac].prec020=g_prec_d[l_ac].prec010
                  END IF  #151202-00007#1---add 
               END IF
            END IF
 
            LET g_prec_d_o.* = g_prec_d[l_ac].* #160824-00007#147 20161123 add by beckxie

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prec010
            #add-point:BEFORE FIELD prec010 name="input.b.page1.prec010"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE prec010
            #add-point:ON CHANGE prec010 name="input.g.page1.prec010"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prec011
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_prec_d[l_ac].prec011,"0","1","","","azz-00079",1) THEN
               NEXT FIELD prec011
            END IF 
 
 
 
            #add-point:AFTER FIELD prec011 name="input.a.page1.prec011"
            IF NOT cl_null(g_prec_d[l_ac].prec011) THEN 
               #151202-00007#1-----add---begin---20151203----
               #買換--控管同一日期範圍內換贈的卡種/券種，不同的類型（散客/會員等級1-5）買換力度一樣
               #單身錄入僅判斷此筆單據內，不同的類型（散客/會員等級1-5）買換力度一樣，審核時候再嚴格檢查判斷。
               IF NOT cl_null(g_prec_d[l_ac].prec012) THEN 
                  IF g_prea_m.prea004='1'  THEN #買換           
                     #IF l_cmd='a' OR (l_cmd='u' AND g_prec_d[l_ac].prec011<>g_prec_d_t.prec011) THEN   #160824-00007#147 20161123 mark by beckxie
                     IF g_prec_d[l_ac].prec011<>g_prec_d_o.prec011 OR cl_null(g_prec_d_o.prec011) THEN   #160824-00007#147 20161123 add by beckxie
                        #力度判斷---力度=起點/贈送
                        #防止出現無盡小數，採用以下對比方式
                        LET l_num20=g_prec_d[l_ac].prec011/g_prec_d[l_ac].prec012
                        LET l_num20_2=''
                        SELECT DISTINCT(prec011/prec012) INTO l_num20_2
                          FROM prec_t
                         WHERE precent=g_enterprise
                           AND precdocno=g_prea_m.preadocno
                           AND precseq<>g_prec_d[l_ac].precseq  
                        IF NOT cl_null(l_num20_2) AND l_num20_2<>l_num20 THEN
                           INITIALIZE g_errparam TO NULL
                           LET g_errparam.code = 'apr-00487'
                           LET g_errparam.extend = ''
                           LET g_errparam.popup = TRUE
                           CALL cl_err()                
                           #LET g_prec_d[l_ac].prec011 = g_prec_d_t.prec011   #160824-00007#147 20161123 mark by beckxie
                           #160824-00007#147 20161123 add by beckxie---S
                           LET g_prec_d[l_ac].prec011 = g_prec_d_o.prec011   
                           LET g_prec_d[l_ac].prec013 = g_prec_d_o.prec013   
                           LET g_prec_d[l_ac].prec015 = g_prec_d_o.prec015   
                           LET g_prec_d[l_ac].prec017 = g_prec_d_o.prec017   
                           LET g_prec_d[l_ac].prec019 = g_prec_d_o.prec019   
                           #160824-00007#147 20161123 add by beckxie---E
                           NEXT FIELD CURRENT                                      
                        END IF
                        
                     END IF 
                  END IF
               END IF
               #151202-00007#1-----add---end---20151203----  
                  
               #IF l_cmd='a' OR (l_cmd='u' AND g_prec_d[l_ac].prec011<>g_prec_d_t.prec011) THEN   #160824-00007#147 20161123 mark by beckxie
               IF g_prec_d[l_ac].prec011<>g_prec_d_o.prec011 OR cl_null(g_prec_d_o.prec011) THEN   #160824-00007#147 20161123 add by beckxie
                  #151202-00007#1---add---begin----
                  #單身是否有資料
                  LET l_count=0
                  SELECT COUNT(*) INTO l_count
                    FROM prec_t
                   WHERE precent=g_enterprise
                     AND precdocno=g_prea_m.preadocno
                     AND precseq<>g_prec_d[l_ac].precseq
                  IF g_prea_m.prea004<>'1' OR (cl_null(l_count) OR l_count=0)  THEN #非買換
                  #151202-00007#1---add---end----                 
                     LET g_prec_d[l_ac].prec013=g_prec_d[l_ac].prec011
                     LET g_prec_d[l_ac].prec015=g_prec_d[l_ac].prec011
                     LET g_prec_d[l_ac].prec017=g_prec_d[l_ac].prec011            
                     LET g_prec_d[l_ac].prec019=g_prec_d[l_ac].prec011 
                  END IF #151202-00007#1---add
               END IF            
            END IF 

            LET g_prec_d_o.* = g_prec_d[l_ac].*  #160824-00007#147 20161123 add by beckxie
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prec011
            #add-point:BEFORE FIELD prec011 name="input.b.page1.prec011"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE prec011
            #add-point:ON CHANGE prec011 name="input.g.page1.prec011"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prec012
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_prec_d[l_ac].prec012,"0","0","","","azz-00079",1) THEN
               NEXT FIELD prec012
            END IF 
 
 
 
            #add-point:AFTER FIELD prec012 name="input.a.page1.prec012"
            IF NOT cl_null(g_prec_d[l_ac].prec012) THEN 
               #151202-00007#1-----add---begin---20151203----
               #買換--控管同一门店，同一日期範圍內換贈的卡種/券種，不同的類型（散客/會員等級1-5）買換力度一樣
               #單身錄入僅判斷此筆單據內，不同的類型（散客/會員等級1-5）買換力度一樣，審核時候再嚴格檢查判斷。
               IF NOT cl_null(g_prec_d[l_ac].prec011) THEN 
                  IF g_prea_m.prea004='1'  THEN #買換           
                     #IF l_cmd='a' OR (l_cmd='u' AND g_prec_d[l_ac].prec012<>g_prec_d_t.prec012) THEN   #160824-00007#147 20161123 mark by beckxie
                     IF g_prec_d[l_ac].prec012<>g_prec_d_o.prec012 OR cl_null(g_prec_d_o.prec012) THEN   #160824-00007#147 20161123 add by beckxie
                        #力度判斷---力度=起點/贈送
                        #防止出現無盡小數，採用以下對比方式
                        LET l_num20=g_prec_d[l_ac].prec011/g_prec_d[l_ac].prec012
                        LET l_num20_2=''
                        SELECT DISTINCT(prec011/prec012) INTO l_num20_2
                          FROM prec_t
                         WHERE precent=g_enterprise
                           AND precdocno=g_prea_m.preadocno
                           AND precseq<>g_prec_d[l_ac].precseq  
                        IF NOT cl_null(l_num20_2) AND l_num20_2<>l_num20 THEN
                           INITIALIZE g_errparam TO NULL
                           LET g_errparam.code = 'apr-00487'
                           LET g_errparam.extend = ''
                           LET g_errparam.popup = TRUE
                           CALL cl_err()                
                           #LET g_prec_d[l_ac].prec012 = g_prec_d_t.prec012   #160824-00007#147 20161123 mark by beckxie
                           #160824-00007#147 20161123 add by beckxie---S
                           LET g_prec_d[l_ac].prec012 = g_prec_d_o.prec012   
                           LET g_prec_d[l_ac].prec014 = g_prec_d_o.prec014   
                           LET g_prec_d[l_ac].prec016 = g_prec_d_o.prec016   
                           LET g_prec_d[l_ac].prec018 = g_prec_d_o.prec018   
                           LET g_prec_d[l_ac].prec020 = g_prec_d_o.prec020   
                           #160824-00007#147 20161123 add by beckxie---E
                           NEXT FIELD CURRENT                                      
                        END IF
                        
                     END IF 
                  END IF
               END IF
               #151202-00007#1-----add---end---20151203---- 
               
               #IF l_cmd='a' OR (l_cmd='u' AND g_prec_d[l_ac].prec012<>g_prec_d_t.prec012) THEN   #160824-00007#147 20161123 mark by beckxie
               IF g_prec_d[l_ac].prec012<>g_prec_d_o.prec012 OR cl_null(g_prec_d_o.prec012) THEN   #160824-00007#147 20161123 add by beckxie
                  #151202-00007#1---add---begin----
                  #單身是否有資料
                  LET l_count=0
                  SELECT COUNT(*) INTO l_count
                    FROM prec_t
                   WHERE precent=g_enterprise
                     AND precdocno=g_prea_m.preadocno
                     AND precseq<>g_prec_d[l_ac].precseq
                  IF g_prea_m.prea004<>'1' OR (cl_null(l_count) OR l_count=0)  THEN #非買換
                  #151202-00007#1---add---end----                   
                     LET g_prec_d[l_ac].prec014=g_prec_d[l_ac].prec012
                     LET g_prec_d[l_ac].prec016=g_prec_d[l_ac].prec012
                     LET g_prec_d[l_ac].prec018=g_prec_d[l_ac].prec012            
                     LET g_prec_d[l_ac].prec020=g_prec_d[l_ac].prec012
                  END IF #151202-00007#1---add
                  #150922-00016--add--begin---20151026--by huangrh---
                  IF g_prea_m.prea005='2' AND NOT cl_null(g_prea_m.prea006) THEN
                     #若為券，單身贈送金額與券面額不一致需提示,僅提示！
                     SELECT oocq009 INTO l_oocq009
                       FROM oocq_t,gcaf_t
                      WHERE oocqent=gcafent
                        AND gcaf001=g_prea_m.prea006
                        AND oocqent=g_enterprise
                        AND oocq001='2071'
                        AND oocq002=gcaf012
                     LET l_prec010=l_oocq009
                     
                     IF g_prec_d[l_ac].prec012<>l_prec010 THEN 
                         INITIALIZE g_errparam TO NULL
                         LET g_errparam.extend = ''
                         LET g_errparam.code   = 'apr-00471'
                         LET g_errparam.popup  = TRUE
                         CALL cl_err()                            
                     END IF
                  END IF
                  #150922-00016--add--end---20151026--by huangrh---                   
                END IF            
            END IF 
            LET g_prec_d_o.* = g_prec_d[l_ac].*  #160824-00007#147 20161123 add by beckxie

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prec012
            #add-point:BEFORE FIELD prec012 name="input.b.page1.prec012"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE prec012
            #add-point:ON CHANGE prec012 name="input.g.page1.prec012"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prec013
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_prec_d[l_ac].prec013,"0","1","","","azz-00079",1) THEN
               NEXT FIELD prec013
            END IF 
 
 
 
            #add-point:AFTER FIELD prec013 name="input.a.page1.prec013"
            IF NOT cl_null(g_prec_d[l_ac].prec013) THEN 
               #151202-00007#1-----add---begin---20151203----
               #買換--控管同一门店，同一日期範圍內換贈的卡種/券種，不同的類型（散客/會員等級1-5）買換力度一樣
               #單身錄入僅判斷此筆單據內，不同的類型（散客/會員等級1-5）買換力度一樣，審核時候再嚴格檢查判斷。
               IF NOT cl_null(g_prec_d[l_ac].prec014) THEN 
                  IF g_prea_m.prea004='1'  THEN #買換           
                     #IF l_cmd='a' OR (l_cmd='u' AND g_prec_d[l_ac].prec013<>g_prec_d_t.prec013) THEN   #160824-00007#147 20161123 mark by beckxie
                     IF g_prec_d[l_ac].prec013<>g_prec_d_o.prec013 OR cl_null(g_prec_d_o.prec013) THEN   #160824-00007#147 20161123 add by beckxie
                        #力度判斷---力度=起點/贈送
                        #防止出現無盡小數，採用以下對比方式
                        LET l_num20=g_prec_d[l_ac].prec013/g_prec_d[l_ac].prec014
                        LET l_num20_2=''
                        SELECT DISTINCT(prec013/prec014) INTO l_num20_2
                          FROM prec_t
                         WHERE precent=g_enterprise
                           AND precdocno=g_prea_m.preadocno
                           AND precseq<>g_prec_d[l_ac].precseq  
                        IF NOT cl_null(l_num20_2) AND l_num20_2<>l_num20 THEN
                           INITIALIZE g_errparam TO NULL
                           LET g_errparam.code = 'apr-00488'
                           LET g_errparam.extend = ''
                           LET g_errparam.popup = TRUE
                           CALL cl_err()                
                           #LET g_prec_d[l_ac].prec013 = g_prec_d_t.prec013   #160824-00007#147 20161123 mark by beckxie
                           #160824-00007#147 20161123 add by beckxie---S
                           LET g_prec_d[l_ac].prec013 = g_prec_d_o.prec013
                           LET g_prec_d[l_ac].prec015 = g_prec_d_o.prec015
                           LET g_prec_d[l_ac].prec017 = g_prec_d_o.prec017
                           LET g_prec_d[l_ac].prec019 = g_prec_d_o.prec019
                           #160824-00007#147 20161123 add by beckxie---E
                           NEXT FIELD CURRENT                                      
                        END IF
                        
                     END IF 
                  END IF
               END IF
               #151202-00007#1-----add---end---20151203----
               
               #IF l_cmd='a' OR (l_cmd='u' AND g_prec_d[l_ac].prec013<>g_prec_d_t.prec013) THEN   #160824-00007#147 20161123 mark by beckxie
               IF g_prec_d[l_ac].prec013<>g_prec_d_o.prec013 OR cl_null(g_prec_d_o.prec013) THEN   #160824-00007#147 20161123 add by beckxie
                  #151202-00007#1---add---begin----
                  #單身是否有資料
                  LET l_count=0
                  SELECT COUNT(*) INTO l_count
                    FROM prec_t
                   WHERE precent=g_enterprise
                     AND precdocno=g_prea_m.preadocno
                     AND precseq<>g_prec_d[l_ac].precseq
                  IF g_prea_m.prea004<>'1' OR (cl_null(l_count) OR l_count=0)  THEN #非買換
                  #151202-00007#1---add---end----               
                     LET g_prec_d[l_ac].prec015=g_prec_d[l_ac].prec013
                     LET g_prec_d[l_ac].prec017=g_prec_d[l_ac].prec013            
                     LET g_prec_d[l_ac].prec019=g_prec_d[l_ac].prec013 
                  END IF #151202-00007#1---add
               END IF            
            END IF 
            LET g_prec_d_o.* = g_prec_d[l_ac].* #160824-00007#147 20161123 add by beckxie


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prec013
            #add-point:BEFORE FIELD prec013 name="input.b.page1.prec013"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE prec013
            #add-point:ON CHANGE prec013 name="input.g.page1.prec013"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prec014
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_prec_d[l_ac].prec014,"0","0","","","azz-00079",1) THEN
               NEXT FIELD prec014
            END IF 
 
 
 
            #add-point:AFTER FIELD prec014 name="input.a.page1.prec014"
            IF NOT cl_null(g_prec_d[l_ac].prec014) THEN 
               #151202-00007#1-----add---begin---20151203----
               #買換--控管同一门店，同一日期範圍內換贈的卡種/券種，不同的類型（散客/會員等級1-5）買換力度一樣
               #單身錄入僅判斷此筆單據內，不同的類型（散客/會員等級1-5）買換力度一樣，審核時候再嚴格檢查判斷。
               IF NOT cl_null(g_prec_d[l_ac].prec013) THEN 
                  IF g_prea_m.prea004='1'  THEN #買換           
                     #IF l_cmd='a' OR (l_cmd='u' AND g_prec_d[l_ac].prec014<>g_prec_d_t.prec014) THEN   #160824-00007#147 20161123 mark by beckxie
                     IF g_prec_d[l_ac].prec014<>g_prec_d_o.prec014 OR cl_null(g_prec_d_o.prec014) THEN   #160824-00007#147 20161123 add by beckxie
                        #力度判斷---力度=起點/贈送
                        #防止出現無盡小數，採用以下對比方式
                        LET l_num20=g_prec_d[l_ac].prec013/g_prec_d[l_ac].prec014
                        LET l_num20_2=''
                        SELECT DISTINCT(prec013/prec014) INTO l_num20_2
                          FROM prec_t
                         WHERE precent=g_enterprise
                           AND precdocno=g_prea_m.preadocno
                           AND precseq<>g_prec_d[l_ac].precseq  
                        IF NOT cl_null(l_num20_2) AND l_num20_2<>l_num20 THEN
                           INITIALIZE g_errparam TO NULL
                           LET g_errparam.code = 'apr-00488'
                           LET g_errparam.extend = ''
                           LET g_errparam.popup = TRUE
                           CALL cl_err()                
                           #LET g_prec_d[l_ac].prec014 = g_prec_d_t.prec014   #160824-00007#147 20161123 mark by beckxie
                           #160824-00007#147 20161123 add by beckxie---S
                           LET g_prec_d[l_ac].prec014 = g_prec_d_o.prec014   
                           LET g_prec_d[l_ac].prec016 = g_prec_d_o.prec016
                           LET g_prec_d[l_ac].prec018 = g_prec_d_o.prec018
                           LET g_prec_d[l_ac].prec020 = g_prec_d_o.prec020
                           #160824-00007#147 20161123 add by beckxie---E
                           NEXT FIELD CURRENT                                      
                        END IF
                        
                     END IF 
                  END IF
               END IF
               #151202-00007#1-----add---begin---20151203----
                           
               #IF l_cmd='a' OR (l_cmd='u' AND g_prec_d[l_ac].prec014<>g_prec_d_t.prec014) THEN   #160824-00007#147 20161123 mark by beckxie
               IF g_prec_d[l_ac].prec014<>g_prec_d_o.prec014 OR cl_null(g_prec_d_o.prec014) THEN   #160824-00007#147 20161123 add by beckxie
                  #151202-00007#1---add---begin----
                  #單身是否有資料
                  LET l_count=0
                  SELECT COUNT(*) INTO l_count
                    FROM prec_t
                   WHERE precent=g_enterprise
                     AND precdocno=g_prea_m.preadocno
                     AND precseq<>g_prec_d[l_ac].precseq
                  IF g_prea_m.prea004<>'1' OR (cl_null(l_count) OR l_count=0)  THEN #非買換
                  #151202-00007#1---add---end----                
                     LET g_prec_d[l_ac].prec016=g_prec_d[l_ac].prec014
                     LET g_prec_d[l_ac].prec018=g_prec_d[l_ac].prec014            
                     LET g_prec_d[l_ac].prec020=g_prec_d[l_ac].prec014
                  END IF #151202-00007#1---add
                  #150922-00016--add--begin---20151026--by huangrh---
                  IF g_prea_m.prea005='2' AND NOT cl_null(g_prea_m.prea006) THEN
                     #若為券，單身贈送金額與券面額不一致需提示,僅提示！
                     SELECT oocq009 INTO l_oocq009
                       FROM oocq_t,gcaf_t
                      WHERE oocqent=gcafent
                        AND gcaf001=g_prea_m.prea006
                        AND oocqent=g_enterprise
                        AND oocq001='2071'
                        AND oocq002=gcaf012
                     LET l_prec010=l_oocq009
                     
                     IF g_prec_d[l_ac].prec014<>l_prec010 THEN 
                         INITIALIZE g_errparam TO NULL
                         LET g_errparam.extend = ''
                         LET g_errparam.code   = 'apr-00471'
                         LET g_errparam.popup  = TRUE
                         CALL cl_err()                            
                     END IF
                  END IF
                  #150922-00016--add--end---20151026--by huangrh---                   
                END IF            
            END IF 
            LET g_prec_d_o.* = g_prec_d[l_ac].*  #160824-00007#147 20161123 add by beckxie

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prec014
            #add-point:BEFORE FIELD prec014 name="input.b.page1.prec014"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE prec014
            #add-point:ON CHANGE prec014 name="input.g.page1.prec014"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prec015
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_prec_d[l_ac].prec015,"0","1","","","azz-00079",1) THEN
               NEXT FIELD prec015
            END IF 
 
 
 
            #add-point:AFTER FIELD prec015 name="input.a.page1.prec015"
            IF NOT cl_null(g_prec_d[l_ac].prec015) THEN 
               #151202-00007#1-----add---begin---20151203----
               #買換--控管同一门店，同一日期範圍內換贈的卡種/券種，不同的類型（散客/會員等級1-5）買換力度一樣
               #單身錄入僅判斷此筆單據內，不同的類型（散客/會員等級1-5）買換力度一樣，審核時候再嚴格檢查判斷。
               IF NOT cl_null(g_prec_d[l_ac].prec016) THEN 
                  IF g_prea_m.prea004='1'  THEN #買換           
                     IF l_cmd='a' OR (l_cmd='u' AND g_prec_d[l_ac].prec015<>g_prec_d_t.prec015) THEN
                        #力度判斷---力度=起點/贈送
                        #防止出現無盡小數，採用以下對比方式
                        LET l_num20=g_prec_d[l_ac].prec015/g_prec_d[l_ac].prec016
                        LET l_num20_2=''
                        SELECT DISTINCT(prec015/prec016) INTO l_num20_2
                          FROM prec_t
                         WHERE precent=g_enterprise
                           AND precdocno=g_prea_m.preadocno
                           AND precseq<>g_prec_d[l_ac].precseq  
                        IF NOT cl_null(l_num20_2) AND l_num20_2<>l_num20 THEN
                           INITIALIZE g_errparam TO NULL
                           LET g_errparam.code = 'apr-00489'
                           LET g_errparam.extend = ''
                           LET g_errparam.popup = TRUE
                           CALL cl_err()                
                           #LET g_prec_d[l_ac].prec015 = g_prec_d_t.prec015   #160824-00007#147 20161123 mark by beckxie                           
                           #160824-00007#147 20161123 add by beckxie---S
                           LET g_prec_d[l_ac].prec015 = g_prec_d_o.prec015
                           LET g_prec_d[l_ac].prec017 = g_prec_d_o.prec017
                           LET g_prec_d[l_ac].prec019 = g_prec_d_o.prec019
                           #160824-00007#147 20161123 add by beckxie---E
                           NEXT FIELD CURRENT                                      
                        END IF
                        
                     END IF 
                  END IF
               END IF
               #151202-00007#1-----add---begin---20151203----
               
               #IF l_cmd='a' OR (l_cmd='u' AND g_prec_d[l_ac].prec015<>g_prec_d_t.prec015) THEN   #160824-00007#147 20161123 mark by beckxie
               IF g_prec_d[l_ac].prec015<>g_prec_d_o.prec015 OR cl_null(g_prec_d_o.prec015) THEN   #160824-00007#147 20161123 add by beckxie
                  #151202-00007#1---add---begin----
                  #單身是否有資料
                  LET l_count=0
                  SELECT COUNT(*) INTO l_count
                    FROM prec_t
                   WHERE precent=g_enterprise
                     AND precdocno=g_prea_m.preadocno
                     AND precseq<>g_prec_d[l_ac].precseq
                  IF g_prea_m.prea004<>'1' OR (cl_null(l_count) OR l_count=0)  THEN #非買換
                  #151202-00007#1---add---end----               
                     LET g_prec_d[l_ac].prec017=g_prec_d[l_ac].prec015            
                     LET g_prec_d[l_ac].prec019=g_prec_d[l_ac].prec015 
                  END IF #151202-00007#1---add-
               END IF            
            END IF 
            LET g_prec_d_o.* = g_prec_d[l_ac].* #160824-00007#147 20161123 add by beckxie

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prec015
            #add-point:BEFORE FIELD prec015 name="input.b.page1.prec015"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE prec015
            #add-point:ON CHANGE prec015 name="input.g.page1.prec015"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prec016
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_prec_d[l_ac].prec016,"0","0","","","azz-00079",1) THEN
               NEXT FIELD prec016
            END IF 
 
 
 
            #add-point:AFTER FIELD prec016 name="input.a.page1.prec016"
            IF NOT cl_null(g_prec_d[l_ac].prec016) THEN 
               #151202-00007#1-----add---begin---20151203----
               #買換--控管同一门店，同一日期範圍內換贈的卡種/券種，不同的類型（散客/會員等級1-5）買換力度一樣
               #單身錄入僅判斷此筆單據內，不同的類型（散客/會員等級1-5）買換力度一樣，審核時候再嚴格檢查判斷。
               IF NOT cl_null(g_prec_d[l_ac].prec015) THEN 
                  IF g_prea_m.prea004='1'  THEN #買換           
                     #IF l_cmd='a' OR (l_cmd='u' AND g_prec_d[l_ac].prec016<>g_prec_d_t.prec016) THEN   #160824-00007#147 20161123 mark by beckxie
                     IF g_prec_d[l_ac].prec016<>g_prec_d_o.prec016 OR cl_null(g_prec_d_o.prec016) THEN   #160824-00007#147 20161123 add by beckxie
                        #力度判斷---力度=起點/贈送
                        #防止出現無盡小數，採用以下對比方式
                        LET l_num20=g_prec_d[l_ac].prec015/g_prec_d[l_ac].prec016
                        LET l_num20_2=''
                        SELECT DISTINCT(prec015/prec016) INTO l_num20_2
                          FROM prec_t
                         WHERE precent=g_enterprise
                           AND precdocno=g_prea_m.preadocno
                           AND precseq<>g_prec_d[l_ac].precseq  
                        IF NOT cl_null(l_num20_2) AND l_num20_2<>l_num20 THEN
                           INITIALIZE g_errparam TO NULL
                           LET g_errparam.code = 'apr-00489'
                           LET g_errparam.extend = ''
                           LET g_errparam.popup = TRUE
                           CALL cl_err()                
                           #LET g_prec_d[l_ac].prec016 = g_prec_d_t.prec016   #160824-00007#147 20161123 mark by beckxie
                           LET g_prec_d[l_ac].prec016 = g_prec_d_o.prec016    #160824-00007#147 20161123 add by beckxie
                           LET g_prec_d[l_ac].prec018 = g_prec_d_o.prec018    #160824-00007#147 20161123 add by beckxie
                           LET g_prec_d[l_ac].prec020 = g_prec_d_o.prec020    #160824-00007#147 20161123 add by beckxie
                           NEXT FIELD CURRENT                                      
                        END IF
                        
                     END IF 
                  END IF
               END IF
               #151202-00007#1-----add---end---20151203----
               
               #IF l_cmd='a' OR (l_cmd='u' AND g_prec_d[l_ac].prec016<>g_prec_d_t.prec016) THEN   #160824-00007#147 20161123 mark by beckxie
               IF g_prec_d[l_ac].prec016<>g_prec_d_o.prec016 OR cl_null(g_prec_d_o.prec016) THEN   #160824-00007#147 20161123 add by beckxie
                  #151202-00007#1---add---begin----
                  #單身是否有資料
                  LET l_count=0
                  SELECT COUNT(*) INTO l_count
                    FROM prec_t
                   WHERE precent=g_enterprise
                     AND precdocno=g_prea_m.preadocno
                     AND precseq<>g_prec_d[l_ac].precseq
                  IF g_prea_m.prea004<>'1' OR (cl_null(l_count) OR l_count=0)  THEN #非買換
                  #151202-00007#1---add---end----                 
                     LET g_prec_d[l_ac].prec018=g_prec_d[l_ac].prec016            
                     LET g_prec_d[l_ac].prec020=g_prec_d[l_ac].prec016
                  END IF #151202-00007#1---add
                  
                  #150922-00016--add--begin---20151026--by huangrh---
                  IF g_prea_m.prea005='2' AND NOT cl_null(g_prea_m.prea006) THEN
                     #若為券，單身贈送金額與券面額不一致需提示,僅提示！
                     SELECT oocq009 INTO l_oocq009
                       FROM oocq_t,gcaf_t
                      WHERE oocqent=gcafent
                        AND gcaf001=g_prea_m.prea006
                        AND oocqent=g_enterprise
                        AND oocq001='2071'
                        AND oocq002=gcaf012
                     LET l_prec010=l_oocq009
                     
                     IF g_prec_d[l_ac].prec016<>l_prec010 THEN 
                         INITIALIZE g_errparam TO NULL
                         LET g_errparam.extend = ''
                         LET g_errparam.code   = 'apr-00471'
                         LET g_errparam.popup  = TRUE
                         CALL cl_err()                            
                     END IF
                  END IF
                  #150922-00016--add--end---20151026--by huangrh---                   
                END IF            
            END IF 
            LET g_prec_d_o.* = g_prec_d[l_ac].*   #160824-00007#147 20161123 add by beckxie

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prec016
            #add-point:BEFORE FIELD prec016 name="input.b.page1.prec016"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE prec016
            #add-point:ON CHANGE prec016 name="input.g.page1.prec016"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prec017
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_prec_d[l_ac].prec017,"0","1","","","azz-00079",1) THEN
               NEXT FIELD prec017
            END IF 
 
 
 
            #add-point:AFTER FIELD prec017 name="input.a.page1.prec017"
            IF NOT cl_null(g_prec_d[l_ac].prec017) THEN 
               #151202-00007#1-----add---begin---20151203----
               #買換--控管同一门店，同一日期範圍內換贈的卡種/券種，不同的類型（散客/會員等級1-5）買換力度一樣
               #單身錄入僅判斷此筆單據內，不同的類型（散客/會員等級1-5）買換力度一樣，審核時候再嚴格檢查判斷。
               IF NOT cl_null(g_prec_d[l_ac].prec018) THEN 
                  IF g_prea_m.prea004='1'  THEN #買換           
                     #IF l_cmd='a' OR (l_cmd='u' AND g_prec_d[l_ac].prec017<>g_prec_d_t.prec017) THEN   #160824-00007#147 20161123 mark by beckxie
                     IF l_cmd='a' OR (l_cmd='u' AND g_prec_d[l_ac].prec017<>g_prec_d_o.prec017) THEN   #160824-00007#147 20161123 add by beckxie
                        #力度判斷---力度=起點/贈送
                        #防止出現無盡小數，採用以下對比方式
                        LET l_num20=g_prec_d[l_ac].prec017/g_prec_d[l_ac].prec018
                        LET l_num20_2=''
                        SELECT DISTINCT(prec017/prec018) INTO l_num20_2
                          FROM prec_t
                         WHERE precent=g_enterprise
                           AND precdocno=g_prea_m.preadocno
                           AND precseq<>g_prec_d[l_ac].precseq  
                        IF NOT cl_null(l_num20_2) AND l_num20_2<>l_num20 THEN
                           INITIALIZE g_errparam TO NULL
                           LET g_errparam.code = 'apr-00490'
                           LET g_errparam.extend = ''
                           LET g_errparam.popup = TRUE
                           CALL cl_err()                
                           #LET g_prec_d[l_ac].prec017 = g_prec_d_t.prec017   #160824-00007#147 20161123 mark by beckxie
                           LET g_prec_d[l_ac].prec017 = g_prec_d_o.prec017   #160824-00007#147 20161123 add by beckxie
                           LET g_prec_d[l_ac].prec019 = g_prec_d_o.prec019   #160824-00007#147 20161123 add by beckxie
                           NEXT FIELD CURRENT                                      
                        END IF
                        
                     END IF 
                  END IF
               END IF
               #151202-00007#1-----add---end---20151203----
               
               #IF l_cmd='a' OR (l_cmd='u' AND g_prec_d[l_ac].prec017<>g_prec_d_t.prec017) THEN    #160824-00007#147 20161123 mark by beckxie
               IF g_prec_d[l_ac].prec017<>g_prec_d_o.prec017 OR cl_null(g_prec_d_o.prec017) THEN    #160824-00007#147 20161123 add by beckxie
                  #151202-00007#1---add---begin----
                  #單身是否有資料
                  LET l_count=0
                  SELECT COUNT(*) INTO l_count
                    FROM prec_t
                   WHERE precent=g_enterprise
                     AND precdocno=g_prea_m.preadocno
                     AND precseq<>g_prec_d[l_ac].precseq
                  IF g_prea_m.prea004<>'1' OR (cl_null(l_count) OR l_count=0)  THEN #非買換
                  #151202-00007#1---add---end----               
                     LET g_prec_d[l_ac].prec019=g_prec_d[l_ac].prec017 
                  END IF #151202-00007#1---add
               END IF            
            END IF 

            LET g_prec_d_o.* = g_prec_d[l_ac].* #160824-00007#147 20161123 add by beckxie
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prec017
            #add-point:BEFORE FIELD prec017 name="input.b.page1.prec017"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE prec017
            #add-point:ON CHANGE prec017 name="input.g.page1.prec017"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prec018
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_prec_d[l_ac].prec018,"0","0","","","azz-00079",1) THEN
               NEXT FIELD prec018
            END IF 
 
 
 
            #add-point:AFTER FIELD prec018 name="input.a.page1.prec018"
            IF NOT cl_null(g_prec_d[l_ac].prec018) THEN 
               #151202-00007#1-----add---begin---20151203----
               #買換--控管同一门店，同一日期範圍內換贈的卡種/券種，不同的類型（散客/會員等級1-5）買換力度一樣
               #單身錄入僅判斷此筆單據內，不同的類型（散客/會員等級1-5）買換力度一樣，審核時候再嚴格檢查判斷。
               IF NOT cl_null(g_prec_d[l_ac].prec017) THEN 
                  IF g_prea_m.prea004='1'  THEN #買換           
                     #IF l_cmd='a' OR (l_cmd='u' AND g_prec_d[l_ac].prec018<>g_prec_d_t.prec018) THEN   #160824-00007#147 20161123 mark by beckxie
                     IF g_prec_d[l_ac].prec018<>g_prec_d_o.prec018 OR cl_null(g_prec_d_o.prec018) THEN   #160824-00007#147 20161123 add by beckxie
                        #力度判斷---力度=起點/贈送
                        #防止出現無盡小數，採用以下對比方式
                        LET l_num20=g_prec_d[l_ac].prec017/g_prec_d[l_ac].prec018
                        LET l_num20_2=''
                        SELECT DISTINCT(prec017/prec018) INTO l_num20_2
                          FROM prec_t
                         WHERE precent=g_enterprise
                           AND precdocno=g_prea_m.preadocno
                           AND precseq<>g_prec_d[l_ac].precseq  
                        IF NOT cl_null(l_num20_2) AND l_num20_2<>l_num20 THEN
                           INITIALIZE g_errparam TO NULL
                           LET g_errparam.code = 'apr-00490'
                           LET g_errparam.extend = ''
                           LET g_errparam.popup = TRUE
                           CALL cl_err()                
                           #LET g_prec_d[l_ac].prec018 = g_prec_d_t.prec018   #160824-00007#147 20161123 mark by beckxie
                           LET g_prec_d[l_ac].prec018 = g_prec_d_o.prec018   #160824-00007#147 20161123 add by beckxie
                           LET g_prec_d[l_ac].prec020 = g_prec_d_o.prec020   #160824-00007#147 20161123 add by beckxie
                           NEXT FIELD CURRENT                                      
                        END IF
                        
                     END IF 
                  END IF
               END IF
               #151202-00007#1-----add---begin---20151203----            
            
               #IF l_cmd='a' OR (l_cmd='u' AND g_prec_d[l_ac].prec018<>g_prec_d_t.prec018) THEN    #160824-00007#147 20161123 mark by beckxie
               IF g_prec_d[l_ac].prec018<>g_prec_d_o.prec018 OR cl_null(g_prec_d_o.prec018) THEN    #160824-00007#147 20161123 add by beckxie
                  #151202-00007#1---add---begin----
                  #單身是否有資料
                  LET l_count=0
                  SELECT COUNT(*) INTO l_count
                    FROM prec_t
                   WHERE precent=g_enterprise
                     AND precdocno=g_prea_m.preadocno
                     AND precseq<>g_prec_d[l_ac].precseq
                  IF g_prea_m.prea004<>'1' OR (cl_null(l_count) OR l_count=0)  THEN #非買換
                  #151202-00007#1---add---end----                 
                     LET g_prec_d[l_ac].prec020=g_prec_d[l_ac].prec018
                  END IF #151202-00007#1---add 
                  #150922-00016--add--begin---20151026--by huangrh---
                  IF g_prea_m.prea005='2' AND NOT cl_null(g_prea_m.prea006) THEN
                     #若為券，單身贈送金額與券面額不一致需提示,僅提示！
                     SELECT oocq009 INTO l_oocq009
                       FROM oocq_t,gcaf_t
                      WHERE oocqent=gcafent
                        AND gcaf001=g_prea_m.prea006
                        AND oocqent=g_enterprise
                        AND oocq001='2071'
                        AND oocq002=gcaf012
                     LET l_prec010=l_oocq009
                     
                     IF g_prec_d[l_ac].prec018<>l_prec010 THEN 
                         INITIALIZE g_errparam TO NULL
                         LET g_errparam.extend = ''
                         LET g_errparam.code   = 'apr-00471'
                         LET g_errparam.popup  = TRUE
                         CALL cl_err()                            
                     END IF
                  END IF
                  #150922-00016--add--end---20151026--by huangrh---                   
                END IF            
            END IF 

            LET g_prec_d_o.* = g_prec_d[l_ac].* #160824-00007#147 20161123 add by beckxie
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prec018
            #add-point:BEFORE FIELD prec018 name="input.b.page1.prec018"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE prec018
            #add-point:ON CHANGE prec018 name="input.g.page1.prec018"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prec019
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_prec_d[l_ac].prec019,"0","1","","","azz-00079",1) THEN
               NEXT FIELD prec019
            END IF 
 
 
 
            #add-point:AFTER FIELD prec019 name="input.a.page1.prec019"
            IF NOT cl_null(g_prec_d[l_ac].prec019) THEN 
               #151202-00007#1-----add---begin---20151203----
               #買換--控管同一门店，同一日期範圍內換贈的卡種/券種，不同的類型（散客/會員等級1-5）買換力度一樣
               #單身錄入僅判斷此筆單據內，不同的類型（散客/會員等級1-5）買換力度一樣，審核時候再嚴格檢查判斷。
               IF NOT cl_null(g_prec_d[l_ac].prec020) THEN 
                  IF g_prea_m.prea004='1'  THEN #買換           
                     IF l_cmd='a' OR (l_cmd='u' AND g_prec_d[l_ac].prec019<>g_prec_d_t.prec019) THEN
                        #力度判斷---力度=起點/贈送
                        #防止出現無盡小數，採用以下對比方式
                        LET l_num20=g_prec_d[l_ac].prec019/g_prec_d[l_ac].prec020
                        LET l_num20_2=''
                        SELECT DISTINCT(prec019/prec020) INTO l_num20_2
                          FROM prec_t
                         WHERE precent=g_enterprise
                           AND precdocno=g_prea_m.preadocno
                           AND precseq<>g_prec_d[l_ac].precseq  
                        IF NOT cl_null(l_num20_2) AND l_num20_2<>l_num20 THEN
                           INITIALIZE g_errparam TO NULL
                           LET g_errparam.code = 'apr-00491'
                           LET g_errparam.extend = ''
                           LET g_errparam.popup = TRUE
                           CALL cl_err()                
                           LET g_prec_d[l_ac].prec019 = g_prec_d_t.prec019
                           NEXT FIELD CURRENT                                      
                        END IF
                        
                     END IF 
                  END IF
               END IF
               #151202-00007#1-----add---end---20151203----   
               
            END IF 


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prec019
            #add-point:BEFORE FIELD prec019 name="input.b.page1.prec019"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE prec019
            #add-point:ON CHANGE prec019 name="input.g.page1.prec019"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prec020
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_prec_d[l_ac].prec020,"0","0","","","azz-00079",1) THEN
               NEXT FIELD prec020
            END IF 
 
 
 
            #add-point:AFTER FIELD prec020 name="input.a.page1.prec020"

            IF NOT cl_null(g_prec_d[l_ac].prec020) THEN 
               #151202-00007#1-----add---begin---20151203----
               #買換--控管同一门店，同一日期範圍內換贈的卡種/券種，不同的類型（散客/會員等級1-5）買換力度一樣
               #單身錄入僅判斷此筆單據內，不同的類型（散客/會員等級1-5）買換力度一樣，審核時候再嚴格檢查判斷。
               IF NOT cl_null(g_prec_d[l_ac].prec019) THEN 
                  IF g_prea_m.prea004='1'  THEN #買換           
                     IF l_cmd='a' OR (l_cmd='u' AND g_prec_d[l_ac].prec020<>g_prec_d_t.prec020) THEN
                        #力度判斷---力度=起點/贈送
                        #防止出現無盡小數，採用以下對比方式
                        LET l_num20=g_prec_d[l_ac].prec019/g_prec_d[l_ac].prec020
                        LET l_num20_2=''
                        SELECT DISTINCT(prec019/prec020) INTO l_num20_2
                          FROM prec_t
                         WHERE precent=g_enterprise
                           AND precdocno=g_prea_m.preadocno
                           AND precseq<>g_prec_d[l_ac].precseq  
                        IF NOT cl_null(l_num20_2) AND l_num20_2<>l_num20 THEN
                           INITIALIZE g_errparam TO NULL
                           LET g_errparam.code = 'apr-00491'
                           LET g_errparam.extend = ''
                           LET g_errparam.popup = TRUE
                           CALL cl_err()                
                           LET g_prec_d[l_ac].prec020 = g_prec_d_t.prec020
                           NEXT FIELD CURRENT                                      
                        END IF
                        
                     END IF 
                  END IF
               END IF
               #151202-00007#1-----add---begin---20151203----
               
               IF l_cmd='a' OR (l_cmd='u' AND g_prec_d[l_ac].prec020<>g_prec_d_t.prec020) THEN
                  #150922-00016--add--begin---20151026--by huangrh---
                  IF g_prea_m.prea005='2' AND NOT cl_null(g_prea_m.prea006) THEN
                     #若為券，單身贈送金額與券面額不一致需提示,僅提示！
                     SELECT oocq009 INTO l_oocq009
                       FROM oocq_t,gcaf_t
                      WHERE oocqent=gcafent
                        AND gcaf001=g_prea_m.prea006
                        AND oocqent=g_enterprise
                        AND oocq001='2071'
                        AND oocq002=gcaf012
                     LET l_prec010=l_oocq009
                     
                     IF g_prec_d[l_ac].prec020<>l_prec010 THEN 
                         INITIALIZE g_errparam TO NULL
                         LET g_errparam.extend = ''
                         LET g_errparam.code   = 'apr-00471'
                         LET g_errparam.popup  = TRUE
                         CALL cl_err()                            
                     END IF
                  END IF
                  #150922-00016--add--end---20151026--by huangrh---                   
                END IF            
            END IF 
            LET g_prec_d_o.* = g_prec_d[l_ac].*   #160824-00007#147 20161123 add by beckxie
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prec020
            #add-point:BEFORE FIELD prec020 name="input.b.page1.prec020"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE prec020
            #add-point:ON CHANGE prec020 name="input.g.page1.prec020"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prec021
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_prec_d[l_ac].prec021,"0","1","","","azz-00079",1) THEN
               NEXT FIELD prec021
            END IF 
 
 
 
            #add-point:AFTER FIELD prec021 name="input.a.page1.prec021"
            IF NOT cl_null(g_prec_d[l_ac].prec021) THEN 
#保盈利價內加扣點                  
                LET  g_prec_d[l_ac].prec055=g_prec_d[l_ac].prec021-g_prec_d[l_ac].prec057 
#保本價內加扣點
                SELECT prcf030 INTO l_prcf030
                  FROM prcf_t
                 WHERE prcfent=g_enterprise
                   AND prcf001=g_prea_m.prea003
                IF cl_null(l_prcf030) THEN
                   LET l_prcf030=0
                END IF
                LET  g_prec_d[l_ac].prec056=g_prec_d[l_ac].prec055*(1-1/(1+l_prcf030))
#回款率
                LET  g_prec_d[l_ac].prec070=100-g_prec_d[l_ac].prec057-g_prec_d[l_ac].prec056
                LET  g_prec_d[l_ac].prec071=100-g_prec_d[l_ac].prec057-g_prec_d[l_ac].prec055
                IF cl_null(g_prec_d[l_ac].prec070) THEN
                   LET g_prec_d[l_ac].prec070=0
                END IF
                IF cl_null(g_prec_d[l_ac].prec071) THEN
                   LET g_prec_d[l_ac].prec071=0
                END IF 
                DISPLAY BY NAME g_prec_d[l_ac].prec055  
                DISPLAY BY NAME g_prec_d[l_ac].prec056  
                DISPLAY BY NAME g_prec_d[l_ac].prec070
                DISPLAY BY NAME g_prec_d[l_ac].prec071
#評估結果
#1.  如果 价内加扣点<保本价内加扣点，则=重谈 '1'
#2.  如果价内加扣点>=保盈利价内点，则=成功 '2'
#3.  如果“保本价内加扣点<=价内加扣点<保盈价内加扣点 则=再争取  '3'
#4. 如果“保本价内加扣点<=价内加扣点<保盈价内加扣点   且<本次参考价内加扣点”，则=重谈
#5.  如果“保本价内加扣点<=价内加扣点<保盈价内加扣点   且>=本次参考价内加扣点且>最近一次价内加扣点”，则=可行   '4'
#6.  如果“保本价内加扣点<=价内加扣点 且>=本次参考价内加扣点,且<最近一次价内加扣点”，则=争取
#參考價內加扣點--暫時不用，此邏輯有問題，需重新和SA確認后整理
               IF g_prec_d[l_ac].prec046<g_prec_d[l_ac].prec056 THEN
                  LET g_prec_d[l_ac].prec075='1'
               END IF                 
               IF g_prec_d[l_ac].prec046>=g_prec_d[l_ac].prec055 THEN
                  LET g_prec_d[l_ac].prec075='2'
               END IF 
               IF g_prec_d[l_ac].prec056<=g_prec_d[l_ac].prec046 AND g_prec_d[l_ac].prec046<g_prec_d[l_ac].prec055 THEN
                  LET g_prec_d[l_ac].prec075='3'
               END IF
               IF g_prec_d[l_ac].prec056<=g_prec_d[l_ac].prec046 AND g_prec_d[l_ac].prec046<g_prec_d[l_ac].prec055 THEN
                  LET g_prec_d[l_ac].prec075='1'
               END IF   
               IF g_prec_d[l_ac].prec056<=g_prec_d[l_ac].prec046 AND g_prec_d[l_ac].prec046<g_prec_d[l_ac].prec055 AND g_prec_d[l_ac].prec046>g_prec_d[l_ac].prec053 THEN
                  LET g_prec_d[l_ac].prec075='4'
               END IF   
               IF g_prec_d[l_ac].prec056<=g_prec_d[l_ac].prec046 AND g_prec_d[l_ac].prec046>g_prec_d[l_ac].prec053 THEN
                  LET g_prec_d[l_ac].prec075='3'
               END IF               
               DISPLAY BY NAME g_prec_d[l_ac].prec075                
            END IF 


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prec021
            #add-point:BEFORE FIELD prec021 name="input.b.page1.prec021"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE prec021
            #add-point:ON CHANGE prec021 name="input.g.page1.prec021"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prec022
            #add-point:BEFORE FIELD prec022 name="input.b.page1.prec022"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prec022
            
            #add-point:AFTER FIELD prec022 name="input.a.page1.prec022"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE prec022
            #add-point:ON CHANGE prec022 name="input.g.page1.prec022"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prec023
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_prec_d[l_ac].prec023,"0","1","","","azz-00079",1) THEN
               NEXT FIELD prec023
            END IF 
 
 
 
            #add-point:AFTER FIELD prec023 name="input.a.page1.prec023"
            IF NOT cl_null(g_prec_d[l_ac].prec023) THEN 
            END IF 


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prec023
            #add-point:BEFORE FIELD prec023 name="input.b.page1.prec023"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE prec023
            #add-point:ON CHANGE prec023 name="input.g.page1.prec023"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prec024
            #add-point:BEFORE FIELD prec024 name="input.b.page1.prec024"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prec024
            
            #add-point:AFTER FIELD prec024 name="input.a.page1.prec024"
            IF NOT cl_null(g_prec_d[l_ac].prec024) THEN 
               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
               INITIALIZE g_chkparam.* TO NULL
               #設定g_chkparam.*的參數
               LET g_chkparam.arg1 = g_prec_d[l_ac].prec024
               #呼叫檢查存在並帶值的library
               IF NOT cl_chk_exist("v_mman001") THEN
                  LET g_prec_d[l_ac].prec024 = g_prec_d_t.prec024
                  NEXT FIELD CURRENT
               END IF           
                 
            END IF 


            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE prec024
            #add-point:ON CHANGE prec024 name="input.g.page1.prec024"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prec025
            #add-point:BEFORE FIELD prec025 name="input.b.page1.prec025"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prec025
            
            #add-point:AFTER FIELD prec025 name="input.a.page1.prec025"
            IF NOT cl_null(g_prec_d[l_ac].prec025) THEN 
               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
               INITIALIZE g_chkparam.* TO NULL
               #設定g_chkparam.*的參數
               LET g_chkparam.arg1 = g_prec_d[l_ac].prec025
               #呼叫檢查存在並帶值的library
               IF NOT cl_chk_exist("v_mman001") THEN
                  LET g_prec_d[l_ac].prec025 = g_prec_d_t.prec025
                  NEXT FIELD CURRENT
               END IF           
                 
            END IF 
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE prec025
            #add-point:ON CHANGE prec025 name="input.g.page1.prec025"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prec026
            #add-point:BEFORE FIELD prec026 name="input.b.page1.prec026"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prec026
            
            #add-point:AFTER FIELD prec026 name="input.a.page1.prec026"
            IF NOT cl_null(g_prec_d[l_ac].prec026) THEN 
               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
               INITIALIZE g_chkparam.* TO NULL
               #設定g_chkparam.*的參數
               LET g_chkparam.arg1 = g_prec_d[l_ac].prec026
               #呼叫檢查存在並帶值的library
               IF NOT cl_chk_exist("v_mman001") THEN
                  LET g_prec_d[l_ac].prec026 = g_prec_d_t.prec026
                  NEXT FIELD CURRENT
               END IF           
                 
            END IF 
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE prec026
            #add-point:ON CHANGE prec026 name="input.g.page1.prec026"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prec027
            #add-point:BEFORE FIELD prec027 name="input.b.page1.prec027"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prec027
            
            #add-point:AFTER FIELD prec027 name="input.a.page1.prec027"
            IF NOT cl_null(g_prec_d[l_ac].prec027) THEN 
               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
               INITIALIZE g_chkparam.* TO NULL
               #設定g_chkparam.*的參數
               LET g_chkparam.arg1 = g_prec_d[l_ac].prec027
               #呼叫檢查存在並帶值的library
               IF NOT cl_chk_exist("v_mman001") THEN
                  LET g_prec_d[l_ac].prec027 = g_prec_d_t.prec027
                  NEXT FIELD CURRENT
               END IF           
                 
            END IF 
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE prec027
            #add-point:ON CHANGE prec027 name="input.g.page1.prec027"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prec028
            #add-point:BEFORE FIELD prec028 name="input.b.page1.prec028"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prec028
            
            #add-point:AFTER FIELD prec028 name="input.a.page1.prec028"
            IF NOT cl_null(g_prec_d[l_ac].prec028) THEN 
               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
               INITIALIZE g_chkparam.* TO NULL
               #設定g_chkparam.*的參數
               LET g_chkparam.arg1 = g_prec_d[l_ac].prec028
               #呼叫檢查存在並帶值的library
               IF NOT cl_chk_exist("v_mman001") THEN
                  LET g_prec_d[l_ac].prec028 = g_prec_d_t.prec028
                  NEXT FIELD CURRENT
               END IF           
                 
            END IF
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE prec028
            #add-point:ON CHANGE prec028 name="input.g.page1.prec028"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prec029
            #add-point:BEFORE FIELD prec029 name="input.b.page1.prec029"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prec029
            
            #add-point:AFTER FIELD prec029 name="input.a.page1.prec029"
            IF NOT cl_null(g_prec_d[l_ac].prec029) THEN 
               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
               INITIALIZE g_chkparam.* TO NULL
               #設定g_chkparam.*的參數
               LET g_chkparam.arg1 = g_prec_d[l_ac].prec029
               #呼叫檢查存在並帶值的library
               IF NOT cl_chk_exist("v_gcaf001_2") THEN
                  LET g_prec_d[l_ac].prec029 = g_prec_d_t.prec029
                  NEXT FIELD CURRENT
               END IF           
                 
            END IF

            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE prec029
            #add-point:ON CHANGE prec029 name="input.g.page1.prec029"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prec030
            #add-point:BEFORE FIELD prec030 name="input.b.page1.prec030"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prec030
            
            #add-point:AFTER FIELD prec030 name="input.a.page1.prec030"
            IF NOT cl_null(g_prec_d[l_ac].prec030) THEN 
               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
               INITIALIZE g_chkparam.* TO NULL
               #設定g_chkparam.*的參數
               LET g_chkparam.arg1 = g_prec_d[l_ac].prec030
               #呼叫檢查存在並帶值的library
               IF NOT cl_chk_exist("v_gcaf001_2") THEN
                  LET g_prec_d[l_ac].prec030 = g_prec_d_t.prec030
                  NEXT FIELD CURRENT
               END IF           
                 
            END IF
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE prec030
            #add-point:ON CHANGE prec030 name="input.g.page1.prec030"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prec031
            #add-point:BEFORE FIELD prec031 name="input.b.page1.prec031"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prec031
            
            #add-point:AFTER FIELD prec031 name="input.a.page1.prec031"
            IF NOT cl_null(g_prec_d[l_ac].prec031) THEN 
               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
               INITIALIZE g_chkparam.* TO NULL
               #設定g_chkparam.*的參數
               LET g_chkparam.arg1 = g_prec_d[l_ac].prec031
               #呼叫檢查存在並帶值的library
               IF NOT cl_chk_exist("v_gcaf001_2") THEN
                  LET g_prec_d[l_ac].prec031 = g_prec_d_t.prec031
                  NEXT FIELD CURRENT
               END IF           
                 
            END IF
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE prec031
            #add-point:ON CHANGE prec031 name="input.g.page1.prec031"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prec032
            #add-point:BEFORE FIELD prec032 name="input.b.page1.prec032"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prec032
            
            #add-point:AFTER FIELD prec032 name="input.a.page1.prec032"
            IF NOT cl_null(g_prec_d[l_ac].prec032) THEN 
               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
               INITIALIZE g_chkparam.* TO NULL
               #設定g_chkparam.*的參數
               LET g_chkparam.arg1 = g_prec_d[l_ac].prec032
               #呼叫檢查存在並帶值的library
               IF NOT cl_chk_exist("v_gcaf001_2") THEN
                  LET g_prec_d[l_ac].prec032 = g_prec_d_t.prec032
                  NEXT FIELD CURRENT
               END IF           
                 
            END IF
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE prec032
            #add-point:ON CHANGE prec032 name="input.g.page1.prec032"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prec033
            #add-point:BEFORE FIELD prec033 name="input.b.page1.prec033"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prec033
            
            #add-point:AFTER FIELD prec033 name="input.a.page1.prec033"
            IF NOT cl_null(g_prec_d[l_ac].prec033) THEN 
               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
               INITIALIZE g_chkparam.* TO NULL
               #設定g_chkparam.*的參數
               LET g_chkparam.arg1 = g_prec_d[l_ac].prec033
               #呼叫檢查存在並帶值的library
               IF NOT cl_chk_exist("v_gcaf001_2") THEN
                  LET g_prec_d[l_ac].prec033 = g_prec_d_t.prec033
                  NEXT FIELD CURRENT
               END IF           
                 
            END IF
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE prec033
            #add-point:ON CHANGE prec033 name="input.g.page1.prec033"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prec034
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_prec_d[l_ac].prec034,"0","1","","","azz-00079",1) THEN
               NEXT FIELD prec034
            END IF 
 
 
 
            #add-point:AFTER FIELD prec034 name="input.a.page1.prec034"
            IF NOT cl_null(g_prec_d[l_ac].prec034) THEN
               IF l_cmd='a' OR (l_cmd='u' AND g_prec_d[l_ac].prec034<>g_prec_d_t.prec034) THEN
                  LET g_prec_d[l_ac].prec036=g_prec_d[l_ac].prec034
                  LET g_prec_d[l_ac].prec038=g_prec_d[l_ac].prec034
                  LET g_prec_d[l_ac].prec040=g_prec_d[l_ac].prec034
                  LET g_prec_d[l_ac].prec042=g_prec_d[l_ac].prec034            
                  LET g_prec_d[l_ac].prec044=g_prec_d[l_ac].prec034
                END IF
            END IF

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prec034
            #add-point:BEFORE FIELD prec034 name="input.b.page1.prec034"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE prec034
            #add-point:ON CHANGE prec034 name="input.g.page1.prec034"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prec035
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_prec_d[l_ac].prec035,"0","1","","","azz-00079",1) THEN
               NEXT FIELD prec035
            END IF 
 
 
 
            #add-point:AFTER FIELD prec035 name="input.a.page1.prec035"
            IF NOT cl_null(g_prec_d[l_ac].prec035) THEN
               IF l_cmd='a' OR (l_cmd='u' AND g_prec_d[l_ac].prec035<>g_prec_d_t.prec035) THEN
                  LET g_prec_d[l_ac].prec037=g_prec_d[l_ac].prec035
                  LET g_prec_d[l_ac].prec039=g_prec_d[l_ac].prec035
                  LET g_prec_d[l_ac].prec041=g_prec_d[l_ac].prec035
                  LET g_prec_d[l_ac].prec043=g_prec_d[l_ac].prec035            
                  LET g_prec_d[l_ac].prec045=g_prec_d[l_ac].prec035
                END IF
            END IF


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prec035
            #add-point:BEFORE FIELD prec035 name="input.b.page1.prec035"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE prec035
            #add-point:ON CHANGE prec035 name="input.g.page1.prec035"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prec036
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_prec_d[l_ac].prec036,"0","1","","","azz-00079",1) THEN
               NEXT FIELD prec036
            END IF 
 
 
 
            #add-point:AFTER FIELD prec036 name="input.a.page1.prec036"
            IF NOT cl_null(g_prec_d[l_ac].prec036) THEN 
            END IF 


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prec036
            #add-point:BEFORE FIELD prec036 name="input.b.page1.prec036"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE prec036
            #add-point:ON CHANGE prec036 name="input.g.page1.prec036"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prec037
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_prec_d[l_ac].prec037,"0","1","","","azz-00079",1) THEN
               NEXT FIELD prec037
            END IF 
 
 
 
            #add-point:AFTER FIELD prec037 name="input.a.page1.prec037"
            IF NOT cl_null(g_prec_d[l_ac].prec037) THEN 
            END IF 


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prec037
            #add-point:BEFORE FIELD prec037 name="input.b.page1.prec037"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE prec037
            #add-point:ON CHANGE prec037 name="input.g.page1.prec037"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prec038
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_prec_d[l_ac].prec038,"0","1","","","azz-00079",1) THEN
               NEXT FIELD prec038
            END IF 
 
 
 
            #add-point:AFTER FIELD prec038 name="input.a.page1.prec038"
            IF NOT cl_null(g_prec_d[l_ac].prec038) THEN 
            END IF 


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prec038
            #add-point:BEFORE FIELD prec038 name="input.b.page1.prec038"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE prec038
            #add-point:ON CHANGE prec038 name="input.g.page1.prec038"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prec039
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_prec_d[l_ac].prec039,"0","1","","","azz-00079",1) THEN
               NEXT FIELD prec039
            END IF 
 
 
 
            #add-point:AFTER FIELD prec039 name="input.a.page1.prec039"
            IF NOT cl_null(g_prec_d[l_ac].prec039) THEN 
            END IF 


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prec039
            #add-point:BEFORE FIELD prec039 name="input.b.page1.prec039"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE prec039
            #add-point:ON CHANGE prec039 name="input.g.page1.prec039"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prec040
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_prec_d[l_ac].prec040,"0","1","","","azz-00079",1) THEN
               NEXT FIELD prec040
            END IF 
 
 
 
            #add-point:AFTER FIELD prec040 name="input.a.page1.prec040"
            IF NOT cl_null(g_prec_d[l_ac].prec040) THEN 
            END IF 


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prec040
            #add-point:BEFORE FIELD prec040 name="input.b.page1.prec040"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE prec040
            #add-point:ON CHANGE prec040 name="input.g.page1.prec040"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prec041
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_prec_d[l_ac].prec041,"0","1","","","azz-00079",1) THEN
               NEXT FIELD prec041
            END IF 
 
 
 
            #add-point:AFTER FIELD prec041 name="input.a.page1.prec041"
            IF NOT cl_null(g_prec_d[l_ac].prec041) THEN 
            END IF 


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prec041
            #add-point:BEFORE FIELD prec041 name="input.b.page1.prec041"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE prec041
            #add-point:ON CHANGE prec041 name="input.g.page1.prec041"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prec042
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_prec_d[l_ac].prec042,"0","1","","","azz-00079",1) THEN
               NEXT FIELD prec042
            END IF 
 
 
 
            #add-point:AFTER FIELD prec042 name="input.a.page1.prec042"
            IF NOT cl_null(g_prec_d[l_ac].prec042) THEN 
            END IF 


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prec042
            #add-point:BEFORE FIELD prec042 name="input.b.page1.prec042"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE prec042
            #add-point:ON CHANGE prec042 name="input.g.page1.prec042"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prec043
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_prec_d[l_ac].prec043,"0","1","","","azz-00079",1) THEN
               NEXT FIELD prec043
            END IF 
 
 
 
            #add-point:AFTER FIELD prec043 name="input.a.page1.prec043"
            IF NOT cl_null(g_prec_d[l_ac].prec043) THEN 
            END IF 


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prec043
            #add-point:BEFORE FIELD prec043 name="input.b.page1.prec043"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE prec043
            #add-point:ON CHANGE prec043 name="input.g.page1.prec043"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prec044
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_prec_d[l_ac].prec044,"0","1","","","azz-00079",1) THEN
               NEXT FIELD prec044
            END IF 
 
 
 
            #add-point:AFTER FIELD prec044 name="input.a.page1.prec044"
            IF NOT cl_null(g_prec_d[l_ac].prec044) THEN 
            END IF 


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prec044
            #add-point:BEFORE FIELD prec044 name="input.b.page1.prec044"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE prec044
            #add-point:ON CHANGE prec044 name="input.g.page1.prec044"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prec045
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_prec_d[l_ac].prec045,"0","1","","","azz-00079",1) THEN
               NEXT FIELD prec045
            END IF 
 
 
 
            #add-point:AFTER FIELD prec045 name="input.a.page1.prec045"
            IF NOT cl_null(g_prec_d[l_ac].prec045) THEN 
            END IF 


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prec045
            #add-point:BEFORE FIELD prec045 name="input.b.page1.prec045"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE prec045
            #add-point:ON CHANGE prec045 name="input.g.page1.prec045"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prec098
            #add-point:BEFORE FIELD prec098 name="input.b.page1.prec098"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prec098
            
            #add-point:AFTER FIELD prec098 name="input.a.page1.prec098"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE prec098
            #add-point:ON CHANGE prec098 name="input.g.page1.prec098"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prec046
            #add-point:BEFORE FIELD prec046 name="input.b.page1.prec046"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prec046
            
            #add-point:AFTER FIELD prec046 name="input.a.page1.prec046"
            IF NOT cl_null(g_prec_d[l_ac].prec046) THEN 
               IF l_cmd='a' OR (l_cmd='u' AND g_prec_d[l_ac].prec046<>g_prec_d_t.prec046) THEN
                  LET g_prec_d[l_ac].prec047=g_prec_d[l_ac].prec046
                  LET g_prec_d[l_ac].prec048=g_prec_d[l_ac].prec046
                  LET g_prec_d[l_ac].prec049=g_prec_d[l_ac].prec046
                  LET g_prec_d[l_ac].prec050=g_prec_d[l_ac].prec046
                  LET g_prec_d[l_ac].prec051=g_prec_d[l_ac].prec046
                  #执行扣率=合同扣率+非VIP价内加扣点----150619-00010#3--add
                  IF NOT cl_null(g_prec_d[l_ac].prec057) THEN
                     LET g_prec_d[l_ac].prec058=g_prec_d[l_ac].prec057+g_prec_d[l_ac].prec046
                  END IF                  
               END IF

               
#回款率
                LET  g_prec_d[l_ac].prec063=100-g_prec_d[l_ac].prec057-g_prec_d[l_ac].prec046
                LET  g_prec_d[l_ac].prec064=100-g_prec_d[l_ac].prec057-g_prec_d[l_ac].prec047
                LET  g_prec_d[l_ac].prec065=100-g_prec_d[l_ac].prec057-g_prec_d[l_ac].prec048
                LET  g_prec_d[l_ac].prec066=100-g_prec_d[l_ac].prec057-g_prec_d[l_ac].prec049
                LET  g_prec_d[l_ac].prec067=100-g_prec_d[l_ac].prec057-g_prec_d[l_ac].prec050
                LET  g_prec_d[l_ac].prec068=100-g_prec_d[l_ac].prec057-g_prec_d[l_ac].prec051
                IF cl_null(g_prec_d[l_ac].prec063) THEN
                   LET g_prec_d[l_ac].prec063=0
                END IF
                IF cl_null(g_prec_d[l_ac].prec064) THEN
                   LET g_prec_d[l_ac].prec064=0
                END IF
                IF cl_null(g_prec_d[l_ac].prec065) THEN
                   LET g_prec_d[l_ac].prec065=0
                END IF
                IF cl_null(g_prec_d[l_ac].prec067) THEN
                   LET g_prec_d[l_ac].prec067=0
                END IF
                IF cl_null(g_prec_d[l_ac].prec068) THEN
                   LET g_prec_d[l_ac].prec068=0
                END IF     
                DISPLAY BY NAME g_prec_d[l_ac].prec063,g_prec_d[l_ac].prec064,g_prec_d[l_ac].prec065,
                                g_prec_d[l_ac].prec066,g_prec_d[l_ac].prec067,g_prec_d[l_ac].prec068

#評估結果
#1.  如果 价内加扣点<保本价内加扣点，则=重谈 '1'
#2.  如果价内加扣点>=保盈利价内点，则=成功 '2'
#3.  如果“保本价内加扣点<=价内加扣点<保盈价内加扣点 则=再争取  '3'
#4. 如果“保本价内加扣点<=价内加扣点<保盈价内加扣点   且<本次参考价内加扣点”，则=重谈
#5.  如果“保本价内加扣点<=价内加扣点<保盈价内加扣点   且>=本次参考价内加扣点且>最近一次价内加扣点”，则=可行   '4'
#6.  如果“保本价内加扣点<=价内加扣点 且>=本次参考价内加扣点,且<最近一次价内加扣点”，则=争取
#參考價內加扣點--暫時不用，此邏輯有問題，需重新整理
              IF g_prec_d[l_ac].prec046<g_prec_d[l_ac].prec056 THEN
                 LET g_prec_d[l_ac].prec075='1'
              END IF                 
              IF g_prec_d[l_ac].prec046>=g_prec_d[l_ac].prec055 THEN
                 LET g_prec_d[l_ac].prec075='2'
              END IF 
              IF g_prec_d[l_ac].prec056<=g_prec_d[l_ac].prec046 AND g_prec_d[l_ac].prec046<g_prec_d[l_ac].prec055 THEN
                 LET g_prec_d[l_ac].prec075='3'
              END IF
              IF g_prec_d[l_ac].prec056<=g_prec_d[l_ac].prec046 AND g_prec_d[l_ac].prec046<g_prec_d[l_ac].prec055 THEN
                 LET g_prec_d[l_ac].prec075='1'
              END IF   
              IF g_prec_d[l_ac].prec056<=g_prec_d[l_ac].prec046 AND g_prec_d[l_ac].prec046<g_prec_d[l_ac].prec055 AND g_prec_d[l_ac].prec046>g_prec_d[l_ac].prec053 THEN
                 LET g_prec_d[l_ac].prec075='4'
              END IF   
              IF g_prec_d[l_ac].prec056<=g_prec_d[l_ac].prec046 AND g_prec_d[l_ac].prec046>g_prec_d[l_ac].prec053 THEN
                 LET g_prec_d[l_ac].prec075='3'
              END IF               
              DISPLAY BY NAME g_prec_d[l_ac].prec075  
            END IF 


            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE prec046
            #add-point:ON CHANGE prec046 name="input.g.page1.prec046"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prec047
            #add-point:BEFORE FIELD prec047 name="input.b.page1.prec047"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prec047
            
            #add-point:AFTER FIELD prec047 name="input.a.page1.prec047"
            IF NOT cl_null(g_prec_d[l_ac].prec047) THEN 
#回款率
                LET  g_prec_d[l_ac].prec063=100-g_prec_d[l_ac].prec057-g_prec_d[l_ac].prec046
                LET  g_prec_d[l_ac].prec064=100-g_prec_d[l_ac].prec057-g_prec_d[l_ac].prec047
                LET  g_prec_d[l_ac].prec065=100-g_prec_d[l_ac].prec057-g_prec_d[l_ac].prec048
                LET  g_prec_d[l_ac].prec066=100-g_prec_d[l_ac].prec057-g_prec_d[l_ac].prec049
                LET  g_prec_d[l_ac].prec067=100-g_prec_d[l_ac].prec057-g_prec_d[l_ac].prec050
                LET  g_prec_d[l_ac].prec068=100-g_prec_d[l_ac].prec057-g_prec_d[l_ac].prec051
                IF cl_null(g_prec_d[l_ac].prec063) THEN
                   LET g_prec_d[l_ac].prec063=0
                END IF
                IF cl_null(g_prec_d[l_ac].prec064) THEN
                   LET g_prec_d[l_ac].prec064=0
                END IF
                IF cl_null(g_prec_d[l_ac].prec065) THEN
                   LET g_prec_d[l_ac].prec065=0
                END IF
                IF cl_null(g_prec_d[l_ac].prec067) THEN
                   LET g_prec_d[l_ac].prec067=0
                END IF
                IF cl_null(g_prec_d[l_ac].prec068) THEN
                   LET g_prec_d[l_ac].prec068=0
                END IF     
                DISPLAY BY NAME g_prec_d[l_ac].prec063,g_prec_d[l_ac].prec064,g_prec_d[l_ac].prec065,
                                g_prec_d[l_ac].prec066,g_prec_d[l_ac].prec067,g_prec_d[l_ac].prec068             
            END IF 


            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE prec047
            #add-point:ON CHANGE prec047 name="input.g.page1.prec047"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prec048
            #add-point:BEFORE FIELD prec048 name="input.b.page1.prec048"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prec048
            
            #add-point:AFTER FIELD prec048 name="input.a.page1.prec048"
            IF NOT cl_null(g_prec_d[l_ac].prec048) THEN 
#回款率
                LET  g_prec_d[l_ac].prec063=100-g_prec_d[l_ac].prec057-g_prec_d[l_ac].prec046
                LET  g_prec_d[l_ac].prec064=100-g_prec_d[l_ac].prec057-g_prec_d[l_ac].prec047
                LET  g_prec_d[l_ac].prec065=100-g_prec_d[l_ac].prec057-g_prec_d[l_ac].prec048
                LET  g_prec_d[l_ac].prec066=100-g_prec_d[l_ac].prec057-g_prec_d[l_ac].prec049
                LET  g_prec_d[l_ac].prec067=100-g_prec_d[l_ac].prec057-g_prec_d[l_ac].prec050
                LET  g_prec_d[l_ac].prec068=100-g_prec_d[l_ac].prec057-g_prec_d[l_ac].prec051
                IF cl_null(g_prec_d[l_ac].prec063) THEN
                   LET g_prec_d[l_ac].prec063=0
                END IF
                IF cl_null(g_prec_d[l_ac].prec064) THEN
                   LET g_prec_d[l_ac].prec064=0
                END IF
                IF cl_null(g_prec_d[l_ac].prec065) THEN
                   LET g_prec_d[l_ac].prec065=0
                END IF
                IF cl_null(g_prec_d[l_ac].prec067) THEN
                   LET g_prec_d[l_ac].prec067=0
                END IF
                IF cl_null(g_prec_d[l_ac].prec068) THEN
                   LET g_prec_d[l_ac].prec068=0
                END IF     
                DISPLAY BY NAME g_prec_d[l_ac].prec063,g_prec_d[l_ac].prec064,g_prec_d[l_ac].prec065,
                                g_prec_d[l_ac].prec066,g_prec_d[l_ac].prec067,g_prec_d[l_ac].prec068             
            END IF 


            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE prec048
            #add-point:ON CHANGE prec048 name="input.g.page1.prec048"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prec049
            #add-point:BEFORE FIELD prec049 name="input.b.page1.prec049"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prec049
            
            #add-point:AFTER FIELD prec049 name="input.a.page1.prec049"
            IF NOT cl_null(g_prec_d[l_ac].prec049) THEN 
#回款率
                LET  g_prec_d[l_ac].prec063=100-g_prec_d[l_ac].prec057-g_prec_d[l_ac].prec046
                LET  g_prec_d[l_ac].prec064=100-g_prec_d[l_ac].prec057-g_prec_d[l_ac].prec047
                LET  g_prec_d[l_ac].prec065=100-g_prec_d[l_ac].prec057-g_prec_d[l_ac].prec048
                LET  g_prec_d[l_ac].prec066=100-g_prec_d[l_ac].prec057-g_prec_d[l_ac].prec049
                LET  g_prec_d[l_ac].prec067=100-g_prec_d[l_ac].prec057-g_prec_d[l_ac].prec050
                LET  g_prec_d[l_ac].prec068=100-g_prec_d[l_ac].prec057-g_prec_d[l_ac].prec051
                IF cl_null(g_prec_d[l_ac].prec063) THEN
                   LET g_prec_d[l_ac].prec063=0
                END IF
                IF cl_null(g_prec_d[l_ac].prec064) THEN
                   LET g_prec_d[l_ac].prec064=0
                END IF
                IF cl_null(g_prec_d[l_ac].prec065) THEN
                   LET g_prec_d[l_ac].prec065=0
                END IF
                IF cl_null(g_prec_d[l_ac].prec067) THEN
                   LET g_prec_d[l_ac].prec067=0
                END IF
                IF cl_null(g_prec_d[l_ac].prec068) THEN
                   LET g_prec_d[l_ac].prec068=0
                END IF     
                DISPLAY BY NAME g_prec_d[l_ac].prec063,g_prec_d[l_ac].prec064,g_prec_d[l_ac].prec065,
                                g_prec_d[l_ac].prec066,g_prec_d[l_ac].prec067,g_prec_d[l_ac].prec068             
            END IF 


            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE prec049
            #add-point:ON CHANGE prec049 name="input.g.page1.prec049"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prec050
            #add-point:BEFORE FIELD prec050 name="input.b.page1.prec050"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prec050
            
            #add-point:AFTER FIELD prec050 name="input.a.page1.prec050"
            IF NOT cl_null(g_prec_d[l_ac].prec050) THEN 
#回款率
                LET  g_prec_d[l_ac].prec063=100-g_prec_d[l_ac].prec057-g_prec_d[l_ac].prec046
                LET  g_prec_d[l_ac].prec064=100-g_prec_d[l_ac].prec057-g_prec_d[l_ac].prec047
                LET  g_prec_d[l_ac].prec065=100-g_prec_d[l_ac].prec057-g_prec_d[l_ac].prec048
                LET  g_prec_d[l_ac].prec066=100-g_prec_d[l_ac].prec057-g_prec_d[l_ac].prec049
                LET  g_prec_d[l_ac].prec067=100-g_prec_d[l_ac].prec057-g_prec_d[l_ac].prec050
                LET  g_prec_d[l_ac].prec068=100-g_prec_d[l_ac].prec057-g_prec_d[l_ac].prec051
                IF cl_null(g_prec_d[l_ac].prec063) THEN
                   LET g_prec_d[l_ac].prec063=0
                END IF
                IF cl_null(g_prec_d[l_ac].prec064) THEN
                   LET g_prec_d[l_ac].prec064=0
                END IF
                IF cl_null(g_prec_d[l_ac].prec065) THEN
                   LET g_prec_d[l_ac].prec065=0
                END IF
                IF cl_null(g_prec_d[l_ac].prec067) THEN
                   LET g_prec_d[l_ac].prec067=0
                END IF
                IF cl_null(g_prec_d[l_ac].prec068) THEN
                   LET g_prec_d[l_ac].prec068=0
                END IF     
                DISPLAY BY NAME g_prec_d[l_ac].prec063,g_prec_d[l_ac].prec064,g_prec_d[l_ac].prec065,
                                g_prec_d[l_ac].prec066,g_prec_d[l_ac].prec067,g_prec_d[l_ac].prec068             
            END IF 


            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE prec050
            #add-point:ON CHANGE prec050 name="input.g.page1.prec050"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prec051
            #add-point:BEFORE FIELD prec051 name="input.b.page1.prec051"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prec051
            
            #add-point:AFTER FIELD prec051 name="input.a.page1.prec051"
            IF NOT cl_null(g_prec_d[l_ac].prec051) THEN 
#回款率
                LET  g_prec_d[l_ac].prec063=100-g_prec_d[l_ac].prec057-g_prec_d[l_ac].prec046
                LET  g_prec_d[l_ac].prec064=100-g_prec_d[l_ac].prec057-g_prec_d[l_ac].prec047
                LET  g_prec_d[l_ac].prec065=100-g_prec_d[l_ac].prec057-g_prec_d[l_ac].prec048
                LET  g_prec_d[l_ac].prec066=100-g_prec_d[l_ac].prec057-g_prec_d[l_ac].prec049
                LET  g_prec_d[l_ac].prec067=100-g_prec_d[l_ac].prec057-g_prec_d[l_ac].prec050
                LET  g_prec_d[l_ac].prec068=100-g_prec_d[l_ac].prec057-g_prec_d[l_ac].prec051
                IF cl_null(g_prec_d[l_ac].prec063) THEN
                   LET g_prec_d[l_ac].prec063=0
                END IF
                IF cl_null(g_prec_d[l_ac].prec064) THEN
                   LET g_prec_d[l_ac].prec064=0
                END IF
                IF cl_null(g_prec_d[l_ac].prec065) THEN
                   LET g_prec_d[l_ac].prec065=0
                END IF
                IF cl_null(g_prec_d[l_ac].prec067) THEN
                   LET g_prec_d[l_ac].prec067=0
                END IF
                IF cl_null(g_prec_d[l_ac].prec068) THEN
                   LET g_prec_d[l_ac].prec068=0
                END IF     
                DISPLAY BY NAME g_prec_d[l_ac].prec063,g_prec_d[l_ac].prec064,g_prec_d[l_ac].prec065,
                                g_prec_d[l_ac].prec066,g_prec_d[l_ac].prec067,g_prec_d[l_ac].prec068             
            END IF 


            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE prec051
            #add-point:ON CHANGE prec051 name="input.g.page1.prec051"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prec052
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_prec_d[l_ac].prec052,"0","1","","","azz-00079",1) THEN
               NEXT FIELD prec052
            END IF 
 
 
 
            #add-point:AFTER FIELD prec052 name="input.a.page1.prec052"
            IF NOT cl_null(g_prec_d[l_ac].prec052) THEN 
            END IF 


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prec052
            #add-point:BEFORE FIELD prec052 name="input.b.page1.prec052"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE prec052
            #add-point:ON CHANGE prec052 name="input.g.page1.prec052"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prec053
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_prec_d[l_ac].prec053,"0","1","","","azz-00079",1) THEN
               NEXT FIELD prec053
            END IF 
 
 
 
            #add-point:AFTER FIELD prec053 name="input.a.page1.prec053"
            IF NOT cl_null(g_prec_d[l_ac].prec053) THEN 
            END IF 


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prec053
            #add-point:BEFORE FIELD prec053 name="input.b.page1.prec053"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE prec053
            #add-point:ON CHANGE prec053 name="input.g.page1.prec053"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prec054
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_prec_d[l_ac].prec054,"0","1","","","azz-00079",1) THEN
               NEXT FIELD prec054
            END IF 
 
 
 
            #add-point:AFTER FIELD prec054 name="input.a.page1.prec054"
            IF NOT cl_null(g_prec_d[l_ac].prec054) THEN 
            END IF 


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prec054
            #add-point:BEFORE FIELD prec054 name="input.b.page1.prec054"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE prec054
            #add-point:ON CHANGE prec054 name="input.g.page1.prec054"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prec055
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_prec_d[l_ac].prec055,"0","1","","","azz-00079",1) THEN
               NEXT FIELD prec055
            END IF 
 
 
 
            #add-point:AFTER FIELD prec055 name="input.a.page1.prec055"
            IF NOT cl_null(g_prec_d[l_ac].prec055) THEN 
            END IF 


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prec055
            #add-point:BEFORE FIELD prec055 name="input.b.page1.prec055"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE prec055
            #add-point:ON CHANGE prec055 name="input.g.page1.prec055"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prec056
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_prec_d[l_ac].prec056,"0","1","","","azz-00079",1) THEN
               NEXT FIELD prec056
            END IF 
 
 
 
            #add-point:AFTER FIELD prec056 name="input.a.page1.prec056"
            IF NOT cl_null(g_prec_d[l_ac].prec056) THEN 
            END IF 


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prec056
            #add-point:BEFORE FIELD prec056 name="input.b.page1.prec056"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE prec056
            #add-point:ON CHANGE prec056 name="input.g.page1.prec056"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prec057
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_prec_d[l_ac].prec057,"0","1","","","azz-00079",1) THEN
               NEXT FIELD prec057
            END IF 
 
 
 
            #add-point:AFTER FIELD prec057 name="input.a.page1.prec057"
            IF NOT cl_null(g_prec_d[l_ac].prec057) THEN 
            END IF 


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prec057
            #add-point:BEFORE FIELD prec057 name="input.b.page1.prec057"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE prec057
            #add-point:ON CHANGE prec057 name="input.g.page1.prec057"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prec058
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_prec_d[l_ac].prec058,"0","1","","","azz-00079",1) THEN
               NEXT FIELD prec058
            END IF 
 
 
 
            #add-point:AFTER FIELD prec058 name="input.a.page1.prec058"
            IF NOT cl_null(g_prec_d[l_ac].prec058) THEN 
            END IF 


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prec058
            #add-point:BEFORE FIELD prec058 name="input.b.page1.prec058"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE prec058
            #add-point:ON CHANGE prec058 name="input.g.page1.prec058"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prec059
            #add-point:BEFORE FIELD prec059 name="input.b.page1.prec059"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prec059
            
            #add-point:AFTER FIELD prec059 name="input.a.page1.prec059"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE prec059
            #add-point:ON CHANGE prec059 name="input.g.page1.prec059"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prec060
            #add-point:BEFORE FIELD prec060 name="input.b.page1.prec060"
 
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prec060
            
            #add-point:AFTER FIELD prec060 name="input.a.page1.prec060"
            #检查保底类型                  
            IF NOT cl_null(g_prec_d[l_ac].prec060)   THEN
               LET l_pred004=''
               SELECT pred004 INTO l_pred004
                 FROM pred_t
                WHERE predent=g_enterprise
                  AND preddocno=g_prea_m.preadocno
                  AND predseq1=g_prec_d[l_ac].precseq
               IF NOT cl_null(l_pred004) THEN   #存在保底资料
                  IF g_prec_d[l_ac].prec060='1' THEN
                     LET g_errparam.code = 'apr-00446'
                     LET g_errparam.extend = g_prec_d[l_ac].prec003
                     LET g_errparam.popup = TRUE
                     CALL cl_err()                
                     LET g_prec_d[l_ac].prec060 = g_prec_d_t.prec060
                     NEXT FIELD CURRENT                   
                  
                  END IF  
                  IF g_prec_d[l_ac].prec060='2' AND l_pred004='2' THEN
                     LET g_errparam.code = 'apr-00447'
                     LET g_errparam.extend = g_prec_d[l_ac].prec003
                     LET g_errparam.popup = TRUE
                     CALL cl_err()                
                     LET g_prec_d[l_ac].prec060 = g_prec_d_t.prec060
                     NEXT FIELD CURRENT                   
                  
                  END IF  
                  IF g_prec_d[l_ac].prec060='4' AND l_pred004='1' THEN
                     LET g_errparam.code = 'apr-00448'
                     LET g_errparam.extend = g_prec_d[l_ac].prec003
                     LET g_errparam.popup = TRUE
                     CALL cl_err()                
                     LET g_prec_d[l_ac].prec060 = g_prec_d_t.prec060
                     NEXT FIELD CURRENT                   
                  
                  END IF
                    
               END IF                  
            END IF  
            CALL aprt310_set_entry_b(l_cmd) 
            CALL aprt310_set_no_entry_b(l_cmd)
            IF g_prec_d[l_ac].prec060<>'3' AND g_prec_d[l_ac].prec060<>'4' THEN
               LET g_prec_d[l_ac].prec061='0'                       
            END IF
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE prec060
            #add-point:ON CHANGE prec060 name="input.g.page1.prec060"
            #检查保底类型                  
            IF NOT cl_null(g_prec_d[l_ac].prec060)   THEN
               LET l_pred004=''
               SELECT pred004 INTO l_pred004
                 FROM pred_t
                WHERE predent=g_enterprise
                  AND preddocno=g_prea_m.preadocno
                  AND predseq1=g_prec_d[l_ac].precseq
               IF NOT cl_null(l_pred004) THEN   #存在保底资料
                  IF g_prec_d[l_ac].prec060='1' THEN
                     LET g_errparam.code = 'apr-00446'
                     LET g_errparam.extend = g_prec_d[l_ac].prec003
                     LET g_errparam.popup = TRUE
                     CALL cl_err()                
                     LET g_prec_d[l_ac].prec060 = g_prec_d_t.prec060
                     NEXT FIELD CURRENT                   
                  
                  END IF  
                  IF g_prec_d[l_ac].prec060='2' AND l_pred004='2' THEN
                     LET g_errparam.code = 'apr-00447'
                     LET g_errparam.extend = g_prec_d[l_ac].prec003
                     LET g_errparam.popup = TRUE
                     CALL cl_err()                
                     LET g_prec_d[l_ac].prec060 = g_prec_d_t.prec060
                     NEXT FIELD CURRENT                   
                  
                  END IF  
                  IF g_prec_d[l_ac].prec060='4' AND l_pred004='1' THEN
                     LET g_errparam.code = 'apr-00448'
                     LET g_errparam.extend = g_prec_d[l_ac].prec003
                     LET g_errparam.popup = TRUE
                     CALL cl_err()                
                     LET g_prec_d[l_ac].prec060 = g_prec_d_t.prec060
                     NEXT FIELD CURRENT                   
                  
                  END IF
                    
               END IF                  
            END IF
            CALL aprt310_set_entry_b(l_cmd) 
            CALL aprt310_set_no_entry_b(l_cmd)
            IF g_prec_d[l_ac].prec060<>'3' AND g_prec_d[l_ac].prec060<>'4' THEN
               LET g_prec_d[l_ac].prec061='0'                       
            END IF 
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prec061
            #add-point:BEFORE FIELD prec061 name="input.b.page1.prec061"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prec061
            
            #add-point:AFTER FIELD prec061 name="input.a.page1.prec061"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE prec061
            #add-point:ON CHANGE prec061 name="input.g.page1.prec061"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prec062
            #add-point:BEFORE FIELD prec062 name="input.b.page1.prec062"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prec062
            
            #add-point:AFTER FIELD prec062 name="input.a.page1.prec062"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE prec062
            #add-point:ON CHANGE prec062 name="input.g.page1.prec062"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prec063
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_prec_d[l_ac].prec063,"0","1","","","azz-00079",1) THEN
               NEXT FIELD prec063
            END IF 
 
 
 
            #add-point:AFTER FIELD prec063 name="input.a.page1.prec063"
            IF NOT cl_null(g_prec_d[l_ac].prec063) THEN 
            END IF 


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prec063
            #add-point:BEFORE FIELD prec063 name="input.b.page1.prec063"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE prec063
            #add-point:ON CHANGE prec063 name="input.g.page1.prec063"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prec064
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_prec_d[l_ac].prec064,"0","1","","","azz-00079",1) THEN
               NEXT FIELD prec064
            END IF 
 
 
 
            #add-point:AFTER FIELD prec064 name="input.a.page1.prec064"
            IF NOT cl_null(g_prec_d[l_ac].prec064) THEN 
            END IF 


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prec064
            #add-point:BEFORE FIELD prec064 name="input.b.page1.prec064"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE prec064
            #add-point:ON CHANGE prec064 name="input.g.page1.prec064"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prec065
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_prec_d[l_ac].prec065,"0","1","","","azz-00079",1) THEN
               NEXT FIELD prec065
            END IF 
 
 
 
            #add-point:AFTER FIELD prec065 name="input.a.page1.prec065"
            IF NOT cl_null(g_prec_d[l_ac].prec065) THEN 
            END IF 


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prec065
            #add-point:BEFORE FIELD prec065 name="input.b.page1.prec065"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE prec065
            #add-point:ON CHANGE prec065 name="input.g.page1.prec065"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prec066
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_prec_d[l_ac].prec066,"0","1","","","azz-00079",1) THEN
               NEXT FIELD prec066
            END IF 
 
 
 
            #add-point:AFTER FIELD prec066 name="input.a.page1.prec066"
            IF NOT cl_null(g_prec_d[l_ac].prec066) THEN 
            END IF 


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prec066
            #add-point:BEFORE FIELD prec066 name="input.b.page1.prec066"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE prec066
            #add-point:ON CHANGE prec066 name="input.g.page1.prec066"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prec067
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_prec_d[l_ac].prec067,"0","1","","","azz-00079",1) THEN
               NEXT FIELD prec067
            END IF 
 
 
 
            #add-point:AFTER FIELD prec067 name="input.a.page1.prec067"
            IF NOT cl_null(g_prec_d[l_ac].prec067) THEN 
            END IF 


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prec067
            #add-point:BEFORE FIELD prec067 name="input.b.page1.prec067"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE prec067
            #add-point:ON CHANGE prec067 name="input.g.page1.prec067"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prec068
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_prec_d[l_ac].prec068,"0","1","","","azz-00079",1) THEN
               NEXT FIELD prec068
            END IF 
 
 
 
            #add-point:AFTER FIELD prec068 name="input.a.page1.prec068"
            IF NOT cl_null(g_prec_d[l_ac].prec068) THEN 
            END IF 


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prec068
            #add-point:BEFORE FIELD prec068 name="input.b.page1.prec068"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE prec068
            #add-point:ON CHANGE prec068 name="input.g.page1.prec068"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prec069
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_prec_d[l_ac].prec069,"0","1","","","azz-00079",1) THEN
               NEXT FIELD prec069
            END IF 
 
 
 
            #add-point:AFTER FIELD prec069 name="input.a.page1.prec069"
            IF NOT cl_null(g_prec_d[l_ac].prec069) THEN 
            END IF 


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prec069
            #add-point:BEFORE FIELD prec069 name="input.b.page1.prec069"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE prec069
            #add-point:ON CHANGE prec069 name="input.g.page1.prec069"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prec070
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_prec_d[l_ac].prec070,"0","1","","","azz-00079",1) THEN
               NEXT FIELD prec070
            END IF 
 
 
 
            #add-point:AFTER FIELD prec070 name="input.a.page1.prec070"
            IF NOT cl_null(g_prec_d[l_ac].prec070) THEN 
            END IF 


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prec070
            #add-point:BEFORE FIELD prec070 name="input.b.page1.prec070"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE prec070
            #add-point:ON CHANGE prec070 name="input.g.page1.prec070"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prec071
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_prec_d[l_ac].prec071,"0","1","","","azz-00079",1) THEN
               NEXT FIELD prec071
            END IF 
 
 
 
            #add-point:AFTER FIELD prec071 name="input.a.page1.prec071"
            IF NOT cl_null(g_prec_d[l_ac].prec071) THEN 
            END IF 


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prec071
            #add-point:BEFORE FIELD prec071 name="input.b.page1.prec071"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE prec071
            #add-point:ON CHANGE prec071 name="input.g.page1.prec071"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prec072
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_prec_d[l_ac].prec072,"0","1","","","azz-00079",1) THEN
               NEXT FIELD prec072
            END IF 
 
 
 
            #add-point:AFTER FIELD prec072 name="input.a.page1.prec072"
            IF NOT cl_null(g_prec_d[l_ac].prec072) THEN 
            END IF 


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prec072
            #add-point:BEFORE FIELD prec072 name="input.b.page1.prec072"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE prec072
            #add-point:ON CHANGE prec072 name="input.g.page1.prec072"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prec073
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_prec_d[l_ac].prec073,"0","1","","","azz-00079",1) THEN
               NEXT FIELD prec073
            END IF 
 
 
 
            #add-point:AFTER FIELD prec073 name="input.a.page1.prec073"
            IF NOT cl_null(g_prec_d[l_ac].prec073) THEN 
            END IF 


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prec073
            #add-point:BEFORE FIELD prec073 name="input.b.page1.prec073"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE prec073
            #add-point:ON CHANGE prec073 name="input.g.page1.prec073"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prec074
            #add-point:BEFORE FIELD prec074 name="input.b.page1.prec074"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prec074
            
            #add-point:AFTER FIELD prec074 name="input.a.page1.prec074"
 
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE prec074
            #add-point:ON CHANGE prec074 name="input.g.page1.prec074"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prec075
            #add-point:BEFORE FIELD prec075 name="input.b.page1.prec075"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prec075
            
            #add-point:AFTER FIELD prec075 name="input.a.page1.prec075"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE prec075
            #add-point:ON CHANGE prec075 name="input.g.page1.prec075"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prec078
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_prec_d[l_ac].prec078,"0","1","","","azz-00079",1) THEN
               NEXT FIELD prec078
            END IF 
 
 
 
            #add-point:AFTER FIELD prec078 name="input.a.page1.prec078"
            IF NOT cl_null(g_prec_d[l_ac].prec078) THEN 
            END IF 


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prec078
            #add-point:BEFORE FIELD prec078 name="input.b.page1.prec078"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE prec078
            #add-point:ON CHANGE prec078 name="input.g.page1.prec078"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prec079
            #add-point:BEFORE FIELD prec079 name="input.b.page1.prec079"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prec079
            
            #add-point:AFTER FIELD prec079 name="input.a.page1.prec079"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE prec079
            #add-point:ON CHANGE prec079 name="input.g.page1.prec079"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prec081
            #add-point:BEFORE FIELD prec081 name="input.b.page1.prec081"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prec081
            
            #add-point:AFTER FIELD prec081 name="input.a.page1.prec081"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE prec081
            #add-point:ON CHANGE prec081 name="input.g.page1.prec081"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prec001
            #add-point:BEFORE FIELD prec001 name="input.b.page1.prec001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prec001
            
            #add-point:AFTER FIELD prec001 name="input.a.page1.prec001"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE prec001
            #add-point:ON CHANGE prec001 name="input.g.page1.prec001"
            
            #END add-point 
 
 
 
                  #Ctrlp:input.c.page1.precacti
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD precacti
            #add-point:ON ACTION controlp INFIELD precacti name="input.c.page1.precacti"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.precseq
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD precseq
            #add-point:ON ACTION controlp INFIELD precseq name="input.c.page1.precseq"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.prec003
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prec003
            #add-point:ON ACTION controlp INFIELD prec003 name="input.c.page1.prec003"
            #應用 a07 樣板自動產生(Version:2)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_prec_d[l_ac].prec003             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "" #s
            LET g_qryparam.where = " inaa135='2' AND inaasite='",g_prea_m.preasite,"' " #促銷庫區

            CALL q_inaa001()                                #呼叫開窗

            LET g_prec_d[l_ac].prec003 = g_qryparam.return1              

            DISPLAY g_prec_d[l_ac].prec003 TO prec003              #
            #150907-00033#2 20150915 mark by beckxie---S
            #INITIALIZE g_ref_fields TO NULL
            #LET g_ref_fields[1] = g_prea_m.preasite
            #LET g_ref_fields[2] = g_prec_d[l_ac].prec003
            #CALL ap_ref_array2(g_ref_fields,"SELECT inaa002 FROM inaa_t WHERE inaaent='"||g_enterprise||"' AND inaasite=? AND inaa001=? ","") RETURNING g_rtn_fields
            #LET g_prec_d[l_ac].prec003_desc = '', g_rtn_fields[1] , ''
            #DISPLAY BY NAME g_prec_d[l_ac].prec003_desc
            #150907-00033#2 20150915 mark by beckxie---E
            #150907-00033#2 20150915  add by beckxie---S
            CALL s_desc_get_stock_desc(g_prea_m.preasite,g_prec_d[l_ac].prec003) RETURNING g_prec_d[l_ac].prec003_desc
            DISPLAY BY NAME g_prec_d[l_ac].prec003_desc
            #150907-00033#2 20150915  add by beckxie---E
            NEXT FIELD prec003                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.page1.prec004
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prec004
            #add-point:ON ACTION controlp INFIELD prec004 name="input.c.page1.prec004"
            #應用 a07 樣板自動產生(Version:2)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_prec_d[l_ac].prec004             #給予default值
            LET g_qryparam.default2 = "" #g_prec_d[l_ac].mhael023 #简称
            #給予arg
            LET g_qryparam.arg1 = "" #s


            CALL q_mhae001()                                #呼叫開窗

            LET g_prec_d[l_ac].prec004 = g_qryparam.return1              
            #LET g_prec_d[l_ac].mhael023 = g_qryparam.return2 
            DISPLAY g_prec_d[l_ac].prec004 TO prec004              #
            #DISPLAY g_prec_d[l_ac].mhael023 TO mhael023 #简称
            NEXT FIELD prec004                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.page1.prec005
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prec005
            #add-point:ON ACTION controlp INFIELD prec005 name="input.c.page1.prec005"
            #應用 a07 樣板自動產生(Version:2)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_prec_d[l_ac].prec005             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "" #s


            CALL q_ooeg001_9()                                #呼叫開窗

            LET g_prec_d[l_ac].prec005 = g_qryparam.return1              

            DISPLAY g_prec_d[l_ac].prec005 TO prec005              #

            NEXT FIELD prec005                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.page1.prec006
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prec006
            #add-point:ON ACTION controlp INFIELD prec006 name="input.c.page1.prec006"
            #應用 a07 樣板自動產生(Version:2)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_prec_d[l_ac].prec006             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "" #s


            CALL q_rtax001()                                #呼叫開窗

            LET g_prec_d[l_ac].prec006 = g_qryparam.return1              

            DISPLAY g_prec_d[l_ac].prec006 TO prec006              #

            NEXT FIELD prec006                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.page1.prec007
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prec007
            #add-point:ON ACTION controlp INFIELD prec007 name="input.c.page1.prec007"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.prec008
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prec008
            #add-point:ON ACTION controlp INFIELD prec008 name="input.c.page1.prec008"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.prec009
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prec009
            #add-point:ON ACTION controlp INFIELD prec009 name="input.c.page1.prec009"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.prec010
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prec010
            #add-point:ON ACTION controlp INFIELD prec010 name="input.c.page1.prec010"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.prec011
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prec011
            #add-point:ON ACTION controlp INFIELD prec011 name="input.c.page1.prec011"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.prec012
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prec012
            #add-point:ON ACTION controlp INFIELD prec012 name="input.c.page1.prec012"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.prec013
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prec013
            #add-point:ON ACTION controlp INFIELD prec013 name="input.c.page1.prec013"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.prec014
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prec014
            #add-point:ON ACTION controlp INFIELD prec014 name="input.c.page1.prec014"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.prec015
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prec015
            #add-point:ON ACTION controlp INFIELD prec015 name="input.c.page1.prec015"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.prec016
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prec016
            #add-point:ON ACTION controlp INFIELD prec016 name="input.c.page1.prec016"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.prec017
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prec017
            #add-point:ON ACTION controlp INFIELD prec017 name="input.c.page1.prec017"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.prec018
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prec018
            #add-point:ON ACTION controlp INFIELD prec018 name="input.c.page1.prec018"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.prec019
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prec019
            #add-point:ON ACTION controlp INFIELD prec019 name="input.c.page1.prec019"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.prec020
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prec020
            #add-point:ON ACTION controlp INFIELD prec020 name="input.c.page1.prec020"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.prec021
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prec021
            #add-point:ON ACTION controlp INFIELD prec021 name="input.c.page1.prec021"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.prec022
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prec022
            #add-point:ON ACTION controlp INFIELD prec022 name="input.c.page1.prec022"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.prec023
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prec023
            #add-point:ON ACTION controlp INFIELD prec023 name="input.c.page1.prec023"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.prec024
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prec024
            #add-point:ON ACTION controlp INFIELD prec024 name="input.c.page1.prec024"
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_prec_d[l_ac].prec024             #給予default值

            CALL q_mman001_7()                                #呼叫開窗

            LET g_prec_d[l_ac].prec024 = g_qryparam.return1              

            DISPLAY g_prec_d[l_ac].prec024 TO prec024              #

            NEXT FIELD prec024                         #返回原欄位
            #END add-point
 
 
         #Ctrlp:input.c.page1.prec025
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prec025
            #add-point:ON ACTION controlp INFIELD prec025 name="input.c.page1.prec025"
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_prec_d[l_ac].prec025             #給予default值

            CALL q_mman001_7()                                #呼叫開窗

            LET g_prec_d[l_ac].prec025 = g_qryparam.return1              

            DISPLAY g_prec_d[l_ac].prec025 TO prec025              #

            NEXT FIELD prec025                         #返回原欄位
            #END add-point
 
 
         #Ctrlp:input.c.page1.prec026
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prec026
            #add-point:ON ACTION controlp INFIELD prec026 name="input.c.page1.prec026"
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_prec_d[l_ac].prec026             #給予default值

            CALL q_mman001_7()                                #呼叫開窗

            LET g_prec_d[l_ac].prec026 = g_qryparam.return1              

            DISPLAY g_prec_d[l_ac].prec026 TO prec026              #

            NEXT FIELD prec026                         #返回原欄位
            #END add-point
 
 
         #Ctrlp:input.c.page1.prec027
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prec027
            #add-point:ON ACTION controlp INFIELD prec027 name="input.c.page1.prec027"
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_prec_d[l_ac].prec027             #給予default值

            CALL q_mman001_7()                                #呼叫開窗

            LET g_prec_d[l_ac].prec027 = g_qryparam.return1              

            DISPLAY g_prec_d[l_ac].prec027 TO prec027              #

            NEXT FIELD prec027                         #返回原欄位
            #END add-point
 
 
         #Ctrlp:input.c.page1.prec028
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prec028
            #add-point:ON ACTION controlp INFIELD prec028 name="input.c.page1.prec028"
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_prec_d[l_ac].prec028             #給予default值

            CALL q_mman001_7()                                #呼叫開窗

            LET g_prec_d[l_ac].prec028 = g_qryparam.return1              

            DISPLAY g_prec_d[l_ac].prec028 TO prec028              #

            NEXT FIELD prec028                         #返回原欄位
            #END add-point
 
 
         #Ctrlp:input.c.page1.prec029
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prec029
            #add-point:ON ACTION controlp INFIELD prec029 name="input.c.page1.prec029"
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_prec_d[l_ac].prec029             #給予default值

            CALL q_gcaf001()                                #呼叫開窗

            LET g_prec_d[l_ac].prec029 = g_qryparam.return1              

            DISPLAY g_prec_d[l_ac].prec029 TO prec029              #

            NEXT FIELD prec029                         #返回原欄位

            #END add-point
 
 
         #Ctrlp:input.c.page1.prec030
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prec030
            #add-point:ON ACTION controlp INFIELD prec030 name="input.c.page1.prec030"
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_prec_d[l_ac].prec030             #給予default值

            CALL q_gcaf001()                                #呼叫開窗

            LET g_prec_d[l_ac].prec030 = g_qryparam.return1              

            DISPLAY g_prec_d[l_ac].prec030 TO prec030              #

            NEXT FIELD prec030                         #返回原欄位
            #END add-point
 
 
         #Ctrlp:input.c.page1.prec031
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prec031
            #add-point:ON ACTION controlp INFIELD prec031 name="input.c.page1.prec031"
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_prec_d[l_ac].prec031             #給予default值

            CALL q_gcaf001()                                #呼叫開窗

            LET g_prec_d[l_ac].prec031 = g_qryparam.return1              

            DISPLAY g_prec_d[l_ac].prec031 TO prec031              #

            NEXT FIELD prec031                         #返回原欄位
            #END add-point
 
 
         #Ctrlp:input.c.page1.prec032
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prec032
            #add-point:ON ACTION controlp INFIELD prec032 name="input.c.page1.prec032"
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_prec_d[l_ac].prec032             #給予default值

            CALL q_gcaf001()                                #呼叫開窗

            LET g_prec_d[l_ac].prec032 = g_qryparam.return1              

            DISPLAY g_prec_d[l_ac].prec032 TO prec032              #

            NEXT FIELD prec032                         #返回原欄位
            #END add-point
 
 
         #Ctrlp:input.c.page1.prec033
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prec033
            #add-point:ON ACTION controlp INFIELD prec033 name="input.c.page1.prec033"
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_prec_d[l_ac].prec033             #給予default值

            CALL q_gcaf001()                                #呼叫開窗

            LET g_prec_d[l_ac].prec033 = g_qryparam.return1              

            DISPLAY g_prec_d[l_ac].prec033 TO prec033              #

            NEXT FIELD prec033                         #返回原欄位
            #END add-point
 
 
         #Ctrlp:input.c.page1.prec034
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prec034
            #add-point:ON ACTION controlp INFIELD prec034 name="input.c.page1.prec034"
 
            #END add-point
 
 
         #Ctrlp:input.c.page1.prec035
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prec035
            #add-point:ON ACTION controlp INFIELD prec035 name="input.c.page1.prec035"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.prec036
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prec036
            #add-point:ON ACTION controlp INFIELD prec036 name="input.c.page1.prec036"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.prec037
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prec037
            #add-point:ON ACTION controlp INFIELD prec037 name="input.c.page1.prec037"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.prec038
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prec038
            #add-point:ON ACTION controlp INFIELD prec038 name="input.c.page1.prec038"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.prec039
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prec039
            #add-point:ON ACTION controlp INFIELD prec039 name="input.c.page1.prec039"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.prec040
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prec040
            #add-point:ON ACTION controlp INFIELD prec040 name="input.c.page1.prec040"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.prec041
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prec041
            #add-point:ON ACTION controlp INFIELD prec041 name="input.c.page1.prec041"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.prec042
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prec042
            #add-point:ON ACTION controlp INFIELD prec042 name="input.c.page1.prec042"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.prec043
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prec043
            #add-point:ON ACTION controlp INFIELD prec043 name="input.c.page1.prec043"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.prec044
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prec044
            #add-point:ON ACTION controlp INFIELD prec044 name="input.c.page1.prec044"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.prec045
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prec045
            #add-point:ON ACTION controlp INFIELD prec045 name="input.c.page1.prec045"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.prec098
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prec098
            #add-point:ON ACTION controlp INFIELD prec098 name="input.c.page1.prec098"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.prec046
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prec046
            #add-point:ON ACTION controlp INFIELD prec046 name="input.c.page1.prec046"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.prec047
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prec047
            #add-point:ON ACTION controlp INFIELD prec047 name="input.c.page1.prec047"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.prec048
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prec048
            #add-point:ON ACTION controlp INFIELD prec048 name="input.c.page1.prec048"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.prec049
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prec049
            #add-point:ON ACTION controlp INFIELD prec049 name="input.c.page1.prec049"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.prec050
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prec050
            #add-point:ON ACTION controlp INFIELD prec050 name="input.c.page1.prec050"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.prec051
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prec051
            #add-point:ON ACTION controlp INFIELD prec051 name="input.c.page1.prec051"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.prec052
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prec052
            #add-point:ON ACTION controlp INFIELD prec052 name="input.c.page1.prec052"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.prec053
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prec053
            #add-point:ON ACTION controlp INFIELD prec053 name="input.c.page1.prec053"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.prec054
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prec054
            #add-point:ON ACTION controlp INFIELD prec054 name="input.c.page1.prec054"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.prec055
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prec055
            #add-point:ON ACTION controlp INFIELD prec055 name="input.c.page1.prec055"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.prec056
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prec056
            #add-point:ON ACTION controlp INFIELD prec056 name="input.c.page1.prec056"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.prec057
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prec057
            #add-point:ON ACTION controlp INFIELD prec057 name="input.c.page1.prec057"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.prec058
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prec058
            #add-point:ON ACTION controlp INFIELD prec058 name="input.c.page1.prec058"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.prec059
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prec059
            #add-point:ON ACTION controlp INFIELD prec059 name="input.c.page1.prec059"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.prec060
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prec060
            #add-point:ON ACTION controlp INFIELD prec060 name="input.c.page1.prec060"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.prec061
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prec061
            #add-point:ON ACTION controlp INFIELD prec061 name="input.c.page1.prec061"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.prec062
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prec062
            #add-point:ON ACTION controlp INFIELD prec062 name="input.c.page1.prec062"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.prec063
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prec063
            #add-point:ON ACTION controlp INFIELD prec063 name="input.c.page1.prec063"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.prec064
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prec064
            #add-point:ON ACTION controlp INFIELD prec064 name="input.c.page1.prec064"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.prec065
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prec065
            #add-point:ON ACTION controlp INFIELD prec065 name="input.c.page1.prec065"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.prec066
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prec066
            #add-point:ON ACTION controlp INFIELD prec066 name="input.c.page1.prec066"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.prec067
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prec067
            #add-point:ON ACTION controlp INFIELD prec067 name="input.c.page1.prec067"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.prec068
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prec068
            #add-point:ON ACTION controlp INFIELD prec068 name="input.c.page1.prec068"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.prec069
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prec069
            #add-point:ON ACTION controlp INFIELD prec069 name="input.c.page1.prec069"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.prec070
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prec070
            #add-point:ON ACTION controlp INFIELD prec070 name="input.c.page1.prec070"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.prec071
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prec071
            #add-point:ON ACTION controlp INFIELD prec071 name="input.c.page1.prec071"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.prec072
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prec072
            #add-point:ON ACTION controlp INFIELD prec072 name="input.c.page1.prec072"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.prec073
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prec073
            #add-point:ON ACTION controlp INFIELD prec073 name="input.c.page1.prec073"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.prec074
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prec074
            #add-point:ON ACTION controlp INFIELD prec074 name="input.c.page1.prec074"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.prec075
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prec075
            #add-point:ON ACTION controlp INFIELD prec075 name="input.c.page1.prec075"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.prec078
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prec078
            #add-point:ON ACTION controlp INFIELD prec078 name="input.c.page1.prec078"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.prec079
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prec079
            #add-point:ON ACTION controlp INFIELD prec079 name="input.c.page1.prec079"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.prec081
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prec081
            #add-point:ON ACTION controlp INFIELD prec081 name="input.c.page1.prec081"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.prec001
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prec001
            #add-point:ON ACTION controlp INFIELD prec001 name="input.c.page1.prec001"
            
            #END add-point
 
 
 
 
         ON ROW CHANGE
            IF INT_FLAG THEN
               LET INT_FLAG = 0
               LET g_prec_d[l_ac].* = g_prec_d_t.*
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code = 9001 
               LET g_errparam.popup = FALSE 
               CLOSE aprt310_bcl
               CALL s_transaction_end('N','0')
               CALL cl_err()
               EXIT DIALOG 
            END IF
              
            IF l_lock_sw = 'Y' THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = g_prec_d[l_ac].precseq 
               LET g_errparam.code = -263 
               LET g_errparam.popup = TRUE 
               CALL cl_err()
               LET g_prec_d[l_ac].* = g_prec_d_t.*
            ELSE
            
               #add-point:單身修改前 name="input.body.b_update"
               #疊加活動否                
               IF g_prec_d[l_ac].prec074<>g_prec_d_t.prec074 THEN
                  LET g_prec2_d[l_ac].prec083=100
                  LET g_prec2_d[l_ac].prec085=100
                  LET g_prec2_d[l_ac].prec087=100
                  LET g_prec2_d[l_ac].prec089=100
                  LET g_prec2_d[l_ac].prec091=100
                  LET g_prec2_d[l_ac].prec093=100
                  LET g_prec2_d[l_ac].prec094=100
                  LET g_prec2_d[l_ac].prec095=100
                  LET g_prec2_d[l_ac].prec096=100
                  LET g_prec2_d[l_ac].prec097=100  
                  LET g_prec2_d[l_ac].prec084=0
                  LET g_prec2_d[l_ac].prec086=0
                  LET g_prec2_d[l_ac].prec088=0
                  LET g_prec2_d[l_ac].prec090=0
                  LET g_prec2_d[l_ac].prec092=0  
                  
                  IF g_prec_d[l_ac].prec074='N' THEN
                     LET g_prec2_d[l_ac].prec080='N'
                     LET g_prec2_d[l_ac].prec082='N' 
                  END IF  
                  
                  IF g_prec_d[l_ac].prec074='Y' THEN
                     LET g_prec2_d[l_ac].prec080='Y'
                     LET g_prec2_d[l_ac].prec082='Y'
                      
                     SELECT stfa001 INTO l_stfa001 #合同編號
                       FROM stfa_t
                      WHERE stfaent=g_enterprise
                        AND stfa005=g_prec_d[l_ac].prec004
                      SELECT inaa141 INTO l_inaa141 #常规库区
                        FROM inaa_t
                       WHERE inaaent=g_enterprise
                         AND inaa001=g_prec_d[l_ac].prec003 
                         
                     SELECT stfd006,stfd007,stfd009 INTO g_prec2_d[l_ac].prec083,g_prec2_d[l_ac].prec093,g_prec2_d[l_ac].prec084
                       FROM stfd_t,oocq_t
                      WHERE stfdent=g_enterprise
                        AND stfd003=l_inaa141
                        AND stfd001=l_stfa001
                        AND oocqent=g_enterprise
                        AND oocq001='2024'
                        AND oocqstus='Y'                  
                        AND oocq002=stfd004
                        AND oocq009='1'    #會員等級一
                        
                     SELECT stfd006,stfd007,stfd009 INTO g_prec2_d[l_ac].prec085,g_prec2_d[l_ac].prec094,g_prec2_d[l_ac].prec086
                       FROM stfd_t,oocq_t
                      WHERE stfdent=g_enterprise
                        AND stfd003=l_inaa141
                        AND stfd001=l_stfa001
                        AND oocqent=g_enterprise
                        AND oocq001='2024'
                        AND oocqstus='Y'                  
                        AND oocq002=stfd004
                        AND oocq009='2'    #會員等級2         
                     SELECT stfd006,stfd007,stfd009 INTO g_prec2_d[l_ac].prec087,g_prec2_d[l_ac].prec095,g_prec2_d[l_ac].prec088
                       FROM stfd_t,oocq_t
                      WHERE stfdent=g_enterprise
                        AND stfd003=l_inaa141
                        AND stfd001=l_stfa001
                        AND oocqent=g_enterprise
                        AND oocq001='2024'
                        AND oocqstus='Y'                  
                        AND oocq002=stfd004
                        AND oocq009='3'    #會員等級3        
                     SELECT stfd006,stfd007,stfd009  INTO g_prec2_d[l_ac].prec089,g_prec2_d[l_ac].prec096,g_prec2_d[l_ac].prec090
                       FROM stfd_t,oocq_t
                      WHERE stfdent=g_enterprise
                        AND stfd003=l_inaa141
                        AND stfd001=l_stfa001
                        AND oocqent=g_enterprise
                        AND oocq001='2024'
                        AND oocqstus='Y'                  
                        AND oocq002=stfd004
                        AND oocq009='4'    #會員等級4  
                     SELECT stfd006,stfd007,stfd009  INTO g_prec2_d[l_ac].prec091,g_prec2_d[l_ac].prec097,g_prec2_d[l_ac].prec092
                       FROM stfd_t,oocq_t
                      WHERE stfdent=g_enterprise
                        AND stfd003=l_inaa141
                        AND stfd001=l_stfa001
                        AND oocqent=g_enterprise
                        AND oocq001='2024'
                        AND oocqstus='Y'                  
                        AND oocq002=stfd004
                        AND oocq009='5'    #會員等級5    
                                      
                  END IF  
               END IF
               #end add-point
               
               #寫入修改者/修改日期資訊(單身)
               
      
               #將遮罩欄位還原
               CALL aprt310_prec_t_mask_restore('restore_mask_o')
      
               UPDATE prec_t SET (precdocno,precacti,precseq,prec003,prec004,prec005,prec006,prec007, 
                   prec008,prec009,prec010,prec011,prec012,prec013,prec014,prec015,prec016,prec017,prec018, 
                   prec019,prec020,prec021,prec022,prec023,prec024,prec025,prec026,prec027,prec028,prec029, 
                   prec030,prec031,prec032,prec033,prec034,prec035,prec036,prec037,prec038,prec039,prec040, 
                   prec041,prec042,prec043,prec044,prec045,prec098,prec046,prec047,prec048,prec049,prec050, 
                   prec051,prec052,prec053,prec054,prec055,prec056,prec057,prec058,prec059,prec060,prec061, 
                   prec062,prec063,prec064,prec065,prec066,prec067,prec068,prec069,prec070,prec071,prec072, 
                   prec073,prec074,prec075,prec078,prec079,prec081,prec001,prec080,prec082,prec083,prec084, 
                   prec085,prec086,prec087,prec088,prec089,prec090,prec091,prec092,prec093,prec094,prec095, 
                   prec096,prec097,precunit,precsite) = (g_prea_m.preadocno,g_prec_d[l_ac].precacti, 
                   g_prec_d[l_ac].precseq,g_prec_d[l_ac].prec003,g_prec_d[l_ac].prec004,g_prec_d[l_ac].prec005, 
                   g_prec_d[l_ac].prec006,g_prec_d[l_ac].prec007,g_prec_d[l_ac].prec008,g_prec_d[l_ac].prec009, 
                   g_prec_d[l_ac].prec010,g_prec_d[l_ac].prec011,g_prec_d[l_ac].prec012,g_prec_d[l_ac].prec013, 
                   g_prec_d[l_ac].prec014,g_prec_d[l_ac].prec015,g_prec_d[l_ac].prec016,g_prec_d[l_ac].prec017, 
                   g_prec_d[l_ac].prec018,g_prec_d[l_ac].prec019,g_prec_d[l_ac].prec020,g_prec_d[l_ac].prec021, 
                   g_prec_d[l_ac].prec022,g_prec_d[l_ac].prec023,g_prec_d[l_ac].prec024,g_prec_d[l_ac].prec025, 
                   g_prec_d[l_ac].prec026,g_prec_d[l_ac].prec027,g_prec_d[l_ac].prec028,g_prec_d[l_ac].prec029, 
                   g_prec_d[l_ac].prec030,g_prec_d[l_ac].prec031,g_prec_d[l_ac].prec032,g_prec_d[l_ac].prec033, 
                   g_prec_d[l_ac].prec034,g_prec_d[l_ac].prec035,g_prec_d[l_ac].prec036,g_prec_d[l_ac].prec037, 
                   g_prec_d[l_ac].prec038,g_prec_d[l_ac].prec039,g_prec_d[l_ac].prec040,g_prec_d[l_ac].prec041, 
                   g_prec_d[l_ac].prec042,g_prec_d[l_ac].prec043,g_prec_d[l_ac].prec044,g_prec_d[l_ac].prec045, 
                   g_prec_d[l_ac].prec098,g_prec_d[l_ac].prec046,g_prec_d[l_ac].prec047,g_prec_d[l_ac].prec048, 
                   g_prec_d[l_ac].prec049,g_prec_d[l_ac].prec050,g_prec_d[l_ac].prec051,g_prec_d[l_ac].prec052, 
                   g_prec_d[l_ac].prec053,g_prec_d[l_ac].prec054,g_prec_d[l_ac].prec055,g_prec_d[l_ac].prec056, 
                   g_prec_d[l_ac].prec057,g_prec_d[l_ac].prec058,g_prec_d[l_ac].prec059,g_prec_d[l_ac].prec060, 
                   g_prec_d[l_ac].prec061,g_prec_d[l_ac].prec062,g_prec_d[l_ac].prec063,g_prec_d[l_ac].prec064, 
                   g_prec_d[l_ac].prec065,g_prec_d[l_ac].prec066,g_prec_d[l_ac].prec067,g_prec_d[l_ac].prec068, 
                   g_prec_d[l_ac].prec069,g_prec_d[l_ac].prec070,g_prec_d[l_ac].prec071,g_prec_d[l_ac].prec072, 
                   g_prec_d[l_ac].prec073,g_prec_d[l_ac].prec074,g_prec_d[l_ac].prec075,g_prec_d[l_ac].prec078, 
                   g_prec_d[l_ac].prec079,g_prec_d[l_ac].prec081,g_prec_d[l_ac].prec001,g_prec2_d[l_ac].prec080, 
                   g_prec2_d[l_ac].prec082,g_prec2_d[l_ac].prec083,g_prec2_d[l_ac].prec084,g_prec2_d[l_ac].prec085, 
                   g_prec2_d[l_ac].prec086,g_prec2_d[l_ac].prec087,g_prec2_d[l_ac].prec088,g_prec2_d[l_ac].prec089, 
                   g_prec2_d[l_ac].prec090,g_prec2_d[l_ac].prec091,g_prec2_d[l_ac].prec092,g_prec2_d[l_ac].prec093, 
                   g_prec2_d[l_ac].prec094,g_prec2_d[l_ac].prec095,g_prec2_d[l_ac].prec096,g_prec2_d[l_ac].prec097, 
                   g_prec2_d[l_ac].precunit,g_prec2_d[l_ac].precsite)
                WHERE precent = g_enterprise AND precdocno = g_prea_m.preadocno 
 
                  AND precseq = g_prec_d_t.precseq #項次   
 
                  
               #add-point:單身修改中 name="input.body.m_update"
               
               #end add-point
               CASE
                  WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
                     LET g_prec_d[l_ac].* = g_prec_d_t.*
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "prec_t" 
                     LET g_errparam.code = "std-00009" 
                     LET g_errparam.popup = TRUE 
                     CALL s_transaction_end('N','0')
                     CALL cl_err()
                     
                  WHEN SQLCA.SQLCODE #其他錯誤
                     LET g_prec_d[l_ac].* = g_prec_d_t.*  
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "prec_t:",SQLERRMESSAGE 
                     LET g_errparam.code = SQLCA.SQLCODE 
                     LET g_errparam.popup = TRUE 
                     CALL s_transaction_end('N','0')
                     CALL cl_err()                   
                     
                  OTHERWISE
                     #資料多語言用-增/改
                     
                                    INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_prea_m.preadocno
               LET gs_keys_bak[1] = g_preadocno_t
               LET gs_keys[2] = g_prec_d[g_detail_idx].precseq
               LET gs_keys_bak[2] = g_prec_d_t.precseq
               CALL aprt310_update_b('prec_t',gs_keys,gs_keys_bak,"'1'")
               END CASE
 
               #將遮罩欄位進行遮蔽
               CALL aprt310_prec_t_mask_restore('restore_mask_n')
               
               #判斷key是否有改變
               INITIALIZE gs_keys TO NULL
               IF NOT(g_prec_d[g_detail_idx].precseq = g_prec_d_t.precseq 
 
                  ) THEN
                  LET gs_keys[01] = g_prea_m.preadocno
 
                  LET gs_keys[gs_keys.getLength()+1] = g_prec_d_t.precseq
 
                  CALL aprt310_key_update_b(gs_keys,'prec_t')
               END IF
               
               #修改歷程記錄(單身修改)
               LET g_log1 = util.JSON.stringify(g_prea_m),util.JSON.stringify(g_prec_d_t)
               LET g_log2 = util.JSON.stringify(g_prea_m),util.JSON.stringify(g_prec_d[l_ac])
               IF NOT cl_log_modified_record_d(g_log1,g_log2) THEN 
                  CALL s_transaction_end('N','0')
               END IF
               
               #add-point:單身修改後 name="input.body.a_update"
               
               #end add-point
 
            END IF
            
         AFTER ROW
            #add-point:單身after_row name="input.body.after_row"
            
            #end add-point
            CALL aprt310_unlock_b("prec_t","'1'")
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
               LET g_prec_d[li_reproduce_target].* = g_prec_d[li_reproduce].*
               LET g_prec2_d[li_reproduce_target].* = g_prec2_d[li_reproduce].*
 
               LET g_prec_d[li_reproduce_target].precseq = NULL
 
            ELSE
               CALL FGL_SET_ARR_CURR(g_prec_d.getLength()+1)
               LET lb_reproduce = TRUE
               LET li_reproduce = l_ac
               LET li_reproduce_target = g_prec_d.getLength()+1
            END IF
            
         #ON ACTION cancel
         #   LET INT_FLAG = 1
         #   LET g_detail_idx = 1
         #   EXIT DIALOG 
 
      END INPUT
      
      INPUT ARRAY g_prec2_d FROM s_detail2.*
         ATTRIBUTE(COUNT = g_rec_b,WITHOUT DEFAULTS, #MAXCOUNT = g_max_rec,
                 INSERT ROW = FALSE, #此頁面insert功能由產生器控制, 手動之設定無效! 
 
                 DELETE ROW = l_allow_delete,
                 APPEND ROW = l_allow_insert)
                 
         #自訂ACTION(detail_input,page_2)
         
         
         BEFORE INPUT
            #add-point:資料輸入前 name="input.body2.before_input2"
            #150619-00010#3--add---begin---

            #150619-00010#3--add---end---
            #end add-point
            
            CALL aprt310_b_fill()
            #如果一直都在單身1則控制筆數位置
            IF g_loc = 'd' AND g_rec_b != 0 THEN
               CALL FGL_SET_ARR_CURR(g_idx_group.getValue("'3',"))
            END IF
            LET g_loc = 'd'
            LET g_rec_b = g_prec2_d.getLength()
            #add-point:資料輸入前 name="input.body2.before_input"
            
            #end add-point
            
         BEFORE INSERT
            IF s_transaction_chk("N",0) THEN
               CALL s_transaction_begin()
            END IF
            LET l_insert = TRUE
            LET l_n = ARR_COUNT()
            LET l_cmd = 'a'
            INITIALIZE g_prec2_d[l_ac].* TO NULL 
            INITIALIZE g_prec2_d_t.* TO NULL 
            INITIALIZE g_prec2_d_o.* TO NULL 
            #公用欄位給值(單身2)
            
            #自定義預設值(單身2)
                  LET g_prec2_d[l_ac].prec080 = "Y"
      LET g_prec2_d[l_ac].prec082 = "Y"
      LET g_prec2_d[l_ac].prec083 = "0"
      LET g_prec2_d[l_ac].prec084 = "0"
      LET g_prec2_d[l_ac].prec085 = "0"
      LET g_prec2_d[l_ac].prec086 = "0"
      LET g_prec2_d[l_ac].prec087 = "0"
      LET g_prec2_d[l_ac].prec088 = "0"
      LET g_prec2_d[l_ac].prec089 = "0"
      LET g_prec2_d[l_ac].prec090 = "0"
      LET g_prec2_d[l_ac].prec091 = "0"
      LET g_prec2_d[l_ac].prec092 = "0"
      LET g_prec2_d[l_ac].prec093 = "0"
      LET g_prec2_d[l_ac].prec094 = "0"
      LET g_prec2_d[l_ac].prec095 = "0"
      LET g_prec2_d[l_ac].prec096 = "0"
      LET g_prec2_d[l_ac].prec097 = "0"
 
            #add-point:modify段before備份 name="input.body2.insert.before_bak"
            LET g_prec2_d[l_ac].precsite=g_prea_m.preasite
            LET g_prec2_d[l_ac].precunit=g_prea_m.preaunit
            DISPLAY BY NAME g_prec2_d[l_ac].prec080,g_prec2_d[l_ac].prec082
            CANCEL INSERT
            #end add-point
            LET g_prec2_d_t.* = g_prec2_d[l_ac].*     #新輸入資料
            LET g_prec2_d_o.* = g_prec2_d[l_ac].*     #新輸入資料
            CALL cl_show_fld_cont()
            CALL aprt310_set_entry_b(l_cmd)
            #add-point:modify段after_set_entry_b name="input.body2.insert.after_set_entry_b"
            
            #end add-point
            CALL aprt310_set_no_entry_b(l_cmd)
            IF lb_reproduce THEN
               LET lb_reproduce = FALSE
               LET g_prec_d[li_reproduce_target].* = g_prec_d[li_reproduce].*
               LET g_prec2_d[li_reproduce_target].* = g_prec2_d[li_reproduce].*
 
               LET g_prec2_d[li_reproduce_target].precseq = NULL
            END IF
            
 
 
            #add-point:modify段before insert name="input.body2.before_insert"
            
            #end add-point  
 
         BEFORE ROW     
            #add-point:modify段before row2 name="input.body2.before_row2"
            
            #end add-point  
            LET l_insert = FALSE
            LET l_cmd = ''
            LET l_ac_t = l_ac 
            LET g_detail_idx_list[2] = l_ac
            LET l_ac = ARR_CURR()
            LET g_detail_idx = l_ac
            LET g_current_page = 2
              
            LET l_lock_sw = 'N'            #DEFAULT
            LET l_n = ARR_COUNT()
            DISPLAY l_ac TO FORMONLY.idx
         
            CALL s_transaction_begin()
            OPEN aprt310_cl USING g_enterprise,g_prea_m.preadocno
            IF SQLCA.SQLCODE THEN   #(ver:78)
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "OPEN aprt310_cl:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE   #(ver:78)
               LET g_errparam.popup = TRUE 
               CLOSE aprt310_cl
               CALL s_transaction_end('N','0')
               CALL cl_err()
               RETURN
            END IF
            
            LET g_rec_b = g_prec2_d.getLength()
            
            IF g_rec_b >= l_ac 
               AND g_prec2_d[l_ac].precseq IS NOT NULL
            THEN 
               LET l_cmd='u'
               LET g_prec2_d_t.* = g_prec2_d[l_ac].*  #BACKUP
               LET g_prec2_d_o.* = g_prec2_d[l_ac].*  #BACKUP
               CALL aprt310_set_entry_b(l_cmd)
               #add-point:modify段after_set_entry_b name="input.body2.after_set_entry_b"
               
               #end add-point  
               CALL aprt310_set_no_entry_b(l_cmd)
               IF NOT aprt310_lock_b("prec_t","'2'") THEN
                  LET l_lock_sw='Y'
               ELSE
                  FETCH aprt310_bcl INTO g_prec_d[l_ac].precacti,g_prec_d[l_ac].precseq,g_prec_d[l_ac].prec003, 
                      g_prec_d[l_ac].prec004,g_prec_d[l_ac].prec005,g_prec_d[l_ac].prec006,g_prec_d[l_ac].prec007, 
                      g_prec_d[l_ac].prec008,g_prec_d[l_ac].prec009,g_prec_d[l_ac].prec010,g_prec_d[l_ac].prec011, 
                      g_prec_d[l_ac].prec012,g_prec_d[l_ac].prec013,g_prec_d[l_ac].prec014,g_prec_d[l_ac].prec015, 
                      g_prec_d[l_ac].prec016,g_prec_d[l_ac].prec017,g_prec_d[l_ac].prec018,g_prec_d[l_ac].prec019, 
                      g_prec_d[l_ac].prec020,g_prec_d[l_ac].prec021,g_prec_d[l_ac].prec022,g_prec_d[l_ac].prec023, 
                      g_prec_d[l_ac].prec024,g_prec_d[l_ac].prec025,g_prec_d[l_ac].prec026,g_prec_d[l_ac].prec027, 
                      g_prec_d[l_ac].prec028,g_prec_d[l_ac].prec029,g_prec_d[l_ac].prec030,g_prec_d[l_ac].prec031, 
                      g_prec_d[l_ac].prec032,g_prec_d[l_ac].prec033,g_prec_d[l_ac].prec034,g_prec_d[l_ac].prec035, 
                      g_prec_d[l_ac].prec036,g_prec_d[l_ac].prec037,g_prec_d[l_ac].prec038,g_prec_d[l_ac].prec039, 
                      g_prec_d[l_ac].prec040,g_prec_d[l_ac].prec041,g_prec_d[l_ac].prec042,g_prec_d[l_ac].prec043, 
                      g_prec_d[l_ac].prec044,g_prec_d[l_ac].prec045,g_prec_d[l_ac].prec098,g_prec_d[l_ac].prec046, 
                      g_prec_d[l_ac].prec047,g_prec_d[l_ac].prec048,g_prec_d[l_ac].prec049,g_prec_d[l_ac].prec050, 
                      g_prec_d[l_ac].prec051,g_prec_d[l_ac].prec052,g_prec_d[l_ac].prec053,g_prec_d[l_ac].prec054, 
                      g_prec_d[l_ac].prec055,g_prec_d[l_ac].prec056,g_prec_d[l_ac].prec057,g_prec_d[l_ac].prec058, 
                      g_prec_d[l_ac].prec059,g_prec_d[l_ac].prec060,g_prec_d[l_ac].prec061,g_prec_d[l_ac].prec062, 
                      g_prec_d[l_ac].prec063,g_prec_d[l_ac].prec064,g_prec_d[l_ac].prec065,g_prec_d[l_ac].prec066, 
                      g_prec_d[l_ac].prec067,g_prec_d[l_ac].prec068,g_prec_d[l_ac].prec069,g_prec_d[l_ac].prec070, 
                      g_prec_d[l_ac].prec071,g_prec_d[l_ac].prec072,g_prec_d[l_ac].prec073,g_prec_d[l_ac].prec074, 
                      g_prec_d[l_ac].prec075,g_prec_d[l_ac].prec078,g_prec_d[l_ac].prec079,g_prec_d[l_ac].prec081, 
                      g_prec_d[l_ac].prec001,g_prec2_d[l_ac].precseq,g_prec2_d[l_ac].prec080,g_prec2_d[l_ac].prec082, 
                      g_prec2_d[l_ac].prec083,g_prec2_d[l_ac].prec084,g_prec2_d[l_ac].prec085,g_prec2_d[l_ac].prec086, 
                      g_prec2_d[l_ac].prec087,g_prec2_d[l_ac].prec088,g_prec2_d[l_ac].prec089,g_prec2_d[l_ac].prec090, 
                      g_prec2_d[l_ac].prec091,g_prec2_d[l_ac].prec092,g_prec2_d[l_ac].prec093,g_prec2_d[l_ac].prec094, 
                      g_prec2_d[l_ac].prec095,g_prec2_d[l_ac].prec096,g_prec2_d[l_ac].prec097,g_prec2_d[l_ac].precunit, 
                      g_prec2_d[l_ac].precsite
                  IF SQLCA.SQLCODE THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = SQLERRMESSAGE  
                     LET g_errparam.code = SQLCA.SQLCODE 
                     LET g_errparam.popup = TRUE 
                     CALL cl_err()
                     LET l_lock_sw = "Y"
                  END IF
                  
                  #遮罩相關處理
                  LET g_prec2_d_mask_o[l_ac].* =  g_prec2_d[l_ac].*
                  CALL aprt310_prec_t_mask()
                  LET g_prec2_d_mask_n[l_ac].* =  g_prec2_d[l_ac].*
                  
                  LET g_bfill = "N"
                  CALL aprt310_show()
                  LET g_bfill = "Y"
                  
                  CALL cl_show_fld_cont()
               END IF
            ELSE
               LET l_cmd='a'
            END IF
            #add-point:modify段before row name="input.body2.before_row"
            IF g_prec_d[l_ac].prec074='N' THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = 'apr-00428'
               LET g_errparam.extend = ''
               LET g_errparam.popup = TRUE
               CALL cl_err()            
               NEXT FIELD precseq_2
            END IF
            IF g_prec2_d[l_ac].prec082='N' THEN
               LET g_prec2_d[l_ac].prec084=0
               LET g_prec2_d[l_ac].prec086=0
               LET g_prec2_d[l_ac].prec088=0
               LET g_prec2_d[l_ac].prec090=0
               LET g_prec2_d[l_ac].prec092=0  
               UPDATE prec_t SET prec084=0,
                                 prec086=0,
                                 prec088=0,
                                 prec090=0,   
                                 prec092=0
                WHERE precent=g_enterprise
                  AND precdocno=g_prea_m.preadocno
                  AND precseq=g_prec_d[l_ac].precseq                  
            END IF  
            IF g_prec2_d[l_ac].prec080='N' THEN
               LET g_prec2_d[l_ac].prec083=100
               LET g_prec2_d[l_ac].prec085=100
               LET g_prec2_d[l_ac].prec087=100
               LET g_prec2_d[l_ac].prec089=100
               LET g_prec2_d[l_ac].prec091=100
               LET g_prec2_d[l_ac].prec093=100
               LET g_prec2_d[l_ac].prec094=100
               LET g_prec2_d[l_ac].prec095=100
               LET g_prec2_d[l_ac].prec096=100
               LET g_prec2_d[l_ac].prec097=100 
               UPDATE prec_t SET prec083=100,
                                 prec085=100,
                                 prec087=100,
                                 prec089=100,   
                                 prec091=100,
                                 prec093=100,
                                 prec094=100,
                                 prec095=100,
                                 prec096=100,
                                 prec097=100
                WHERE precent=g_enterprise
                  AND precdocno=g_prea_m.preadocno
                  AND precseq=g_prec_d[l_ac].precseq                 
            END IF 
                                                
            #end add-point  
            #其他table資料備份(確定是否更改用)
            
 
 
            #其他table進行lock
            
 
 
            
         BEFORE DELETE                            #是否取消單身
            IF l_cmd = 'a' THEN
               LET l_cmd='d'
               #add-point:單身AFTER DELETE (=d) name="input.body2.after_delete_d"
               CANCEL DELETE
               #end add-point
            ELSE
               #add-point:單身刪除前 name="input.body2.b_delete_ask"
               
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
               
               #add-point:單身2刪除前 name="input.body2.b_delete"
               CANCEL DELETE
               #end add-point    
                  
               #取得該筆資料key值
               INITIALIZE gs_keys TO NULL
               LET gs_keys[01] = g_prea_m.preadocno
               LET gs_keys[gs_keys.getLength()+1] = g_prec2_d_t.precseq
            
               #刪除同層單身
               IF NOT aprt310_delete_b('prec_t',gs_keys,"'2'") THEN
                  CALL s_transaction_end('N','0')
                  CLOSE aprt310_bcl
                  CANCEL DELETE
               END IF
    
               #刪除下層單身
               IF NOT aprt310_key_delete_b(gs_keys,'prec_t') THEN
                  CALL s_transaction_end('N','0')
                  CLOSE aprt310_bcl
                  CANCEL DELETE
               END IF
               
               #刪除多語言
               
 
 
               
               #add-point:單身2刪除中 name="input.body2.m_delete"
               
               #end add-point    
               
               CALL s_transaction_end('Y','0')
               CLOSE aprt310_bcl
 
               LET g_rec_b = g_rec_b-1
               #add-point:單身2刪除後 name="input.body2.a_delete"
               
               #end add-point
               LET l_count = g_prec_d.getLength()
               
               #add-point:單身刪除後(<>d) name="input.body2.after_delete"
               
               #end add-point
            END IF 
 
         AFTER DELETE
            #如果是最後一筆
            IF l_ac = (g_prec2_d.getLength() + 1) THEN
               CALL FGL_SET_ARR_CURR(l_ac-1)
            END IF
 
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
               
            #add-point:單身2新增前 name="input.body2.b_a_insert"
            
            #end add-point
               
            LET l_count = 1  
            SELECT COUNT(1) INTO l_count FROM prec_t 
             WHERE precent = g_enterprise AND precdocno = g_prea_m.preadocno
               AND precseq = g_prec2_d[l_ac].precseq
                
            #資料未重複, 插入新增資料
            IF l_count = 0 THEN 
               #add-point:單身2新增前 name="input.body2.b_insert"
               
               #end add-point
            
                              INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_prea_m.preadocno
               LET gs_keys[2] = g_prec2_d[g_detail_idx].precseq
               CALL aprt310_insert_b('prec_t',gs_keys,"'2'")
                           
               #add-point:單身新增後2 name="input.body2.a_insert"
               
               #end add-point
            ELSE    
               INITIALIZE g_prec_d[l_ac].* TO NULL
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = 'INSERT' 
               LET g_errparam.code = "std-00006" 
               LET g_errparam.popup = TRUE 
               CALL s_transaction_end('N','0')
               CALL cl_err()
               CANCEL INSERT
            END IF
 
            IF SQLCA.SQLCODE THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "prec_t:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE 
               LET g_errparam.popup = TRUE 
               CALL s_transaction_end('N','0')                    
               CALL cl_err()
               CANCEL INSERT
            ELSE
               #先刷新資料
               #CALL aprt310_b_fill()
               #資料多語言用-增/改
               
               #add-point:單身新增後 name="input.body2.after_insert"
               
               #end add-point
               CALL s_transaction_end('Y','0')
               #ERROR 'INSERT O.K'
               LET g_rec_b = g_rec_b + 1
            END IF
            
         ON ROW CHANGE 
            IF INT_FLAG THEN
               LET INT_FLAG = 0
               LET g_prec2_d[l_ac].* = g_prec2_d_t.*
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code = 9001 
               LET g_errparam.popup = FALSE 
               CLOSE aprt310_bcl
               CALL s_transaction_end('N','0')
               CALL cl_err()
               EXIT DIALOG 
            END IF
            
            IF l_lock_sw = 'Y' THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code = -263 
               LET g_errparam.popup = TRUE 
               CALL cl_err()
               LET g_prec2_d[l_ac].* = g_prec2_d_t.*
            ELSE
               #add-point:單身page2修改前 name="input.body2.b_update"
               
               #end add-point
               
               #寫入修改者/修改日期資訊(單身2)
               
               
               #將遮罩欄位還原
               CALL aprt310_prec_t_mask_restore('restore_mask_o')
                              
               UPDATE prec_t SET (precdocno,precacti,precseq,prec003,prec004,prec005,prec006,prec007, 
                   prec008,prec009,prec010,prec011,prec012,prec013,prec014,prec015,prec016,prec017,prec018, 
                   prec019,prec020,prec021,prec022,prec023,prec024,prec025,prec026,prec027,prec028,prec029, 
                   prec030,prec031,prec032,prec033,prec034,prec035,prec036,prec037,prec038,prec039,prec040, 
                   prec041,prec042,prec043,prec044,prec045,prec098,prec046,prec047,prec048,prec049,prec050, 
                   prec051,prec052,prec053,prec054,prec055,prec056,prec057,prec058,prec059,prec060,prec061, 
                   prec062,prec063,prec064,prec065,prec066,prec067,prec068,prec069,prec070,prec071,prec072, 
                   prec073,prec074,prec075,prec078,prec079,prec081,prec001,prec080,prec082,prec083,prec084, 
                   prec085,prec086,prec087,prec088,prec089,prec090,prec091,prec092,prec093,prec094,prec095, 
                   prec096,prec097,precunit,precsite) = (g_prea_m.preadocno,g_prec_d[l_ac].precacti, 
                   g_prec_d[l_ac].precseq,g_prec_d[l_ac].prec003,g_prec_d[l_ac].prec004,g_prec_d[l_ac].prec005, 
                   g_prec_d[l_ac].prec006,g_prec_d[l_ac].prec007,g_prec_d[l_ac].prec008,g_prec_d[l_ac].prec009, 
                   g_prec_d[l_ac].prec010,g_prec_d[l_ac].prec011,g_prec_d[l_ac].prec012,g_prec_d[l_ac].prec013, 
                   g_prec_d[l_ac].prec014,g_prec_d[l_ac].prec015,g_prec_d[l_ac].prec016,g_prec_d[l_ac].prec017, 
                   g_prec_d[l_ac].prec018,g_prec_d[l_ac].prec019,g_prec_d[l_ac].prec020,g_prec_d[l_ac].prec021, 
                   g_prec_d[l_ac].prec022,g_prec_d[l_ac].prec023,g_prec_d[l_ac].prec024,g_prec_d[l_ac].prec025, 
                   g_prec_d[l_ac].prec026,g_prec_d[l_ac].prec027,g_prec_d[l_ac].prec028,g_prec_d[l_ac].prec029, 
                   g_prec_d[l_ac].prec030,g_prec_d[l_ac].prec031,g_prec_d[l_ac].prec032,g_prec_d[l_ac].prec033, 
                   g_prec_d[l_ac].prec034,g_prec_d[l_ac].prec035,g_prec_d[l_ac].prec036,g_prec_d[l_ac].prec037, 
                   g_prec_d[l_ac].prec038,g_prec_d[l_ac].prec039,g_prec_d[l_ac].prec040,g_prec_d[l_ac].prec041, 
                   g_prec_d[l_ac].prec042,g_prec_d[l_ac].prec043,g_prec_d[l_ac].prec044,g_prec_d[l_ac].prec045, 
                   g_prec_d[l_ac].prec098,g_prec_d[l_ac].prec046,g_prec_d[l_ac].prec047,g_prec_d[l_ac].prec048, 
                   g_prec_d[l_ac].prec049,g_prec_d[l_ac].prec050,g_prec_d[l_ac].prec051,g_prec_d[l_ac].prec052, 
                   g_prec_d[l_ac].prec053,g_prec_d[l_ac].prec054,g_prec_d[l_ac].prec055,g_prec_d[l_ac].prec056, 
                   g_prec_d[l_ac].prec057,g_prec_d[l_ac].prec058,g_prec_d[l_ac].prec059,g_prec_d[l_ac].prec060, 
                   g_prec_d[l_ac].prec061,g_prec_d[l_ac].prec062,g_prec_d[l_ac].prec063,g_prec_d[l_ac].prec064, 
                   g_prec_d[l_ac].prec065,g_prec_d[l_ac].prec066,g_prec_d[l_ac].prec067,g_prec_d[l_ac].prec068, 
                   g_prec_d[l_ac].prec069,g_prec_d[l_ac].prec070,g_prec_d[l_ac].prec071,g_prec_d[l_ac].prec072, 
                   g_prec_d[l_ac].prec073,g_prec_d[l_ac].prec074,g_prec_d[l_ac].prec075,g_prec_d[l_ac].prec078, 
                   g_prec_d[l_ac].prec079,g_prec_d[l_ac].prec081,g_prec_d[l_ac].prec001,g_prec2_d[l_ac].prec080, 
                   g_prec2_d[l_ac].prec082,g_prec2_d[l_ac].prec083,g_prec2_d[l_ac].prec084,g_prec2_d[l_ac].prec085, 
                   g_prec2_d[l_ac].prec086,g_prec2_d[l_ac].prec087,g_prec2_d[l_ac].prec088,g_prec2_d[l_ac].prec089, 
                   g_prec2_d[l_ac].prec090,g_prec2_d[l_ac].prec091,g_prec2_d[l_ac].prec092,g_prec2_d[l_ac].prec093, 
                   g_prec2_d[l_ac].prec094,g_prec2_d[l_ac].prec095,g_prec2_d[l_ac].prec096,g_prec2_d[l_ac].prec097, 
                   g_prec2_d[l_ac].precunit,g_prec2_d[l_ac].precsite) #自訂欄位頁簽
                WHERE precent = g_enterprise AND precdocno = g_prea_m.preadocno
                  AND precseq = g_prec2_d_t.precseq #項次 
                  
               #add-point:單身page2修改中 name="input.body2.m_update"
               
               #end add-point
                  
               CASE
                  WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
                     LET g_prec2_d[l_ac].* = g_prec2_d_t.*
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "prec_t" 
                     LET g_errparam.code = "std-00009" 
                     LET g_errparam.popup = TRUE 
                     CALL s_transaction_end('N','0')
                     CALL cl_err()
                     
                  WHEN SQLCA.SQLCODE #其他錯誤
                     LET g_prec2_d[l_ac].* = g_prec2_d_t.*
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "prec_t:",SQLERRMESSAGE 
                     LET g_errparam.code = SQLCA.SQLCODE 
                     LET g_errparam.popup = TRUE 
                     CALL s_transaction_end('N','0')
                     CALL cl_err()
                     
                  OTHERWISE
                     #資料多語言用-增/改
                     
                                    INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_prea_m.preadocno
               LET gs_keys_bak[1] = g_preadocno_t
               LET gs_keys[2] = g_prec2_d[g_detail_idx].precseq
               LET gs_keys_bak[2] = g_prec2_d_t.precseq
               CALL aprt310_update_b('prec_t',gs_keys,gs_keys_bak,"'2'")
               END CASE
               
               #將遮罩欄位進行遮蔽
               CALL aprt310_prec_t_mask_restore('restore_mask_n')
               
               #判斷key是否有改變
               INITIALIZE gs_keys TO NULL
               IF NOT (g_prec2_d[g_detail_idx].precseq = g_prec2_d_t.precseq 
                  ) THEN
                  LET gs_keys[01] = g_prea_m.preadocno
                  LET gs_keys[gs_keys.getLength()+1] = g_prec2_d_t.precseq
                  CALL aprt310_key_update_b(gs_keys,'prec_t')
               END IF
               
               #修改歷程記錄(單身修改)
               LET g_log1 = util.JSON.stringify(g_prea_m),util.JSON.stringify(g_prec2_d_t)
               LET g_log2 = util.JSON.stringify(g_prea_m),util.JSON.stringify(g_prec2_d[l_ac])
               IF NOT cl_log_modified_record_d(g_log1,g_log2) THEN 
                  CALL s_transaction_end('N','0')
               END IF
               
               #add-point:單身page2修改後 name="input.body2.a_update"
               
               #end add-point
            END IF
         
                  #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prec080
            #add-point:BEFORE FIELD prec080 name="input.b.page2.prec080"
            IF g_prec_d[l_ac].prec074='N' THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = 'apr-00428'
               LET g_errparam.extend = ''
               LET g_errparam.popup = TRUE
               CALL cl_err()            
               NEXT FIELD precseq_2
            END IF
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prec080
            
            #add-point:AFTER FIELD prec080 name="input.a.page2.prec080"
#            CALL aprt310_set_entry_b(l_cmd) 
#            CALL aprt310_set_no_entry_b(l_cmd)
            #各等級會員折扣率，各等級會員供應商承擔比例，從astm401專櫃合同取值。
            IF g_prec2_d[l_ac].prec080='Y' THEN
               LET g_prec2_d[l_ac].prec083=100
               LET g_prec2_d[l_ac].prec085=100
               LET g_prec2_d[l_ac].prec087=100
               LET g_prec2_d[l_ac].prec089=100
               LET g_prec2_d[l_ac].prec091=100
               LET g_prec2_d[l_ac].prec093=100
               LET g_prec2_d[l_ac].prec094=100
               LET g_prec2_d[l_ac].prec095=100
               LET g_prec2_d[l_ac].prec096=100
               LET g_prec2_d[l_ac].prec097=100
               
               SELECT stfa001 INTO l_stfa001 #合同編號
                 FROM stfa_t
                WHERE stfaent=g_enterprise
                  AND stfa005=g_prec_d[l_ac].prec004
                SELECT inaa141 INTO l_inaa141 #常规库区
                  FROM inaa_t
                 WHERE inaaent=g_enterprise
                   AND inaa001=g_prec_d[l_ac].prec003                   
               SELECT stfd006,stfd007 INTO g_prec2_d[l_ac].prec083,g_prec2_d[l_ac].prec093
                 FROM stfd_t,oocq_t
                WHERE stfdent=g_enterprise
                  AND stfd003=l_inaa141
                  AND stfd001=l_stfa001
                  AND oocqent=g_enterprise
                  AND oocq001='2024'
                  AND oocqstus='Y'                  
                  AND oocq002=stfd004
                  AND oocq009='1'    #會員等級一
               SELECT stfd006,stfd007 INTO g_prec2_d[l_ac].prec085,g_prec2_d[l_ac].prec094
                 FROM stfd_t,oocq_t
                WHERE stfdent=g_enterprise
                  AND stfd003=l_inaa141
                  AND stfd001=l_stfa001
                  AND oocqent=g_enterprise
                  AND oocq001='2024'
                  AND oocqstus='Y'                  
                  AND oocq002=stfd004
                  AND oocq009='2'    #會員等級2         
               SELECT stfd006,stfd007 INTO g_prec2_d[l_ac].prec087,g_prec2_d[l_ac].prec095
                 FROM stfd_t,oocq_t
                WHERE stfdent=g_enterprise
                  AND stfd003=l_inaa141
                  AND stfd001=l_stfa001
                  AND oocqent=g_enterprise
                  AND oocq001='2024'
                  AND oocqstus='Y'                  
                  AND oocq002=stfd004
                  AND oocq009='3'    #會員等級3        
               SELECT stfd006,stfd007 INTO g_prec2_d[l_ac].prec089,g_prec2_d[l_ac].prec096
                 FROM stfd_t,oocq_t
                WHERE stfdent=g_enterprise
                  AND stfd003=l_inaa141
                  AND stfd001=l_stfa001
                  AND oocqent=g_enterprise
                  AND oocq001='2024'
                  AND oocqstus='Y'                  
                  AND oocq002=stfd004
                  AND oocq009='4'    #會員等級4  
               SELECT stfd006,stfd007 INTO g_prec2_d[l_ac].prec091,g_prec2_d[l_ac].prec097
                 FROM stfd_t,oocq_t
                WHERE stfdent=g_enterprise
                  AND stfd003=l_inaa141
                  AND stfd001=l_stfa001
                  AND oocqent=g_enterprise
                  AND oocq001='2024'
                  AND oocqstus='Y'                  
                  AND oocq002=stfd004
                  AND oocq009='5'    #會員等級5                    
            END IF
            IF g_prec2_d[l_ac].prec080='N' THEN
               LET g_prec2_d[l_ac].prec083=100
               LET g_prec2_d[l_ac].prec085=100
               LET g_prec2_d[l_ac].prec087=100
               LET g_prec2_d[l_ac].prec089=100
               LET g_prec2_d[l_ac].prec091=100
               LET g_prec2_d[l_ac].prec093=100
               LET g_prec2_d[l_ac].prec094=100
               LET g_prec2_d[l_ac].prec095=100
               LET g_prec2_d[l_ac].prec096=100
               LET g_prec2_d[l_ac].prec097=100                
            END IF            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE prec080
            #add-point:ON CHANGE prec080 name="input.g.page2.prec080"

#            CALL aprt310_set_entry_b(l_cmd) 
#            CALL aprt310_set_no_entry_b(l_cmd)
            #各等級會員折扣率，各等級會員供應商承擔比例，從astm401專櫃合同取值。
            IF g_prec2_d[l_ac].prec080='Y' THEN
               LET g_prec2_d[l_ac].prec083=100
               LET g_prec2_d[l_ac].prec085=100
               LET g_prec2_d[l_ac].prec087=100
               LET g_prec2_d[l_ac].prec089=100
               LET g_prec2_d[l_ac].prec091=100
               LET g_prec2_d[l_ac].prec093=100
               LET g_prec2_d[l_ac].prec094=100
               LET g_prec2_d[l_ac].prec095=100
               LET g_prec2_d[l_ac].prec096=100
               LET g_prec2_d[l_ac].prec097=100  
               
               SELECT stfa001 INTO l_stfa001 #合同編號
                 FROM stfa_t
                WHERE stfaent=g_enterprise
                  AND stfa005=g_prec_d[l_ac].prec004
                SELECT inaa141 INTO l_inaa141 #常规库区
                  FROM inaa_t
                 WHERE inaaent=g_enterprise
                   AND inaa001=g_prec_d[l_ac].prec003                   
               SELECT stfd006,stfd007 INTO g_prec2_d[l_ac].prec083,g_prec2_d[l_ac].prec093
                 FROM stfd_t,oocq_t
                WHERE stfdent=g_enterprise
                  AND stfd003=l_inaa141
                  AND stfd001=l_stfa001
                  AND oocqent=g_enterprise
                  AND oocq001='2024'
                  AND oocqstus='Y'                  
                  AND oocq002=stfd004
                  AND oocq009='1'    #會員等級一
               SELECT stfd006,stfd007 INTO g_prec2_d[l_ac].prec085,g_prec2_d[l_ac].prec094
                 FROM stfd_t,oocq_t
                WHERE stfdent=g_enterprise
                  AND stfd003=l_inaa141
                  AND stfd001=l_stfa001
                  AND oocqent=g_enterprise
                  AND oocq001='2024'
                  AND oocqstus='Y'                  
                  AND oocq002=stfd004
                  AND oocq009='2'    #會員等級2         
               SELECT stfd006,stfd007 INTO g_prec2_d[l_ac].prec087,g_prec2_d[l_ac].prec095
                 FROM stfd_t,oocq_t
                WHERE stfdent=g_enterprise
                  AND stfd003=l_inaa141
                  AND stfd001=l_stfa001
                  AND oocqent=g_enterprise
                  AND oocq001='2024'
                  AND oocqstus='Y'                  
                  AND oocq002=stfd004
                  AND oocq009='3'    #會員等級3        
               SELECT stfd006,stfd007 INTO g_prec2_d[l_ac].prec089,g_prec2_d[l_ac].prec096
                 FROM stfd_t,oocq_t
                WHERE stfdent=g_enterprise
                  AND stfd003=l_inaa141
                  AND stfd001=l_stfa001
                  AND oocqent=g_enterprise
                  AND oocq001='2024'
                  AND oocqstus='Y'                  
                  AND oocq002=stfd004
                  AND oocq009='4'    #會員等級4  
               SELECT stfd006,stfd007 INTO g_prec2_d[l_ac].prec091,g_prec2_d[l_ac].prec097
                 FROM stfd_t,oocq_t
                WHERE stfdent=g_enterprise
                  AND stfd003=l_inaa141
                  AND stfd001=l_stfa001
                  AND oocqent=g_enterprise
                  AND oocq001='2024'
                  AND oocqstus='Y'                  
                  AND oocq002=stfd004
                  AND oocq009='5'    #會員等級5                 
            END IF
            IF g_prec2_d[l_ac].prec080='N' THEN
               LET g_prec2_d[l_ac].prec083=100
               LET g_prec2_d[l_ac].prec085=100
               LET g_prec2_d[l_ac].prec087=100
               LET g_prec2_d[l_ac].prec089=100
               LET g_prec2_d[l_ac].prec091=100
               LET g_prec2_d[l_ac].prec093=100
               LET g_prec2_d[l_ac].prec094=100
               LET g_prec2_d[l_ac].prec095=100
               LET g_prec2_d[l_ac].prec096=100
               LET g_prec2_d[l_ac].prec097=100                
            END IF            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prec082
            #add-point:BEFORE FIELD prec082 name="input.b.page2.prec082"
            IF g_prec_d[l_ac].prec074='N' THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = 'apr-00428'
               LET g_errparam.extend = ''
               LET g_errparam.popup = TRUE
               CALL cl_err()            
               NEXT FIELD precseq_2
            END IF
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prec082
            
            #add-point:AFTER FIELD prec082 name="input.a.page2.prec082"
            CALL aprt310_set_entry_b(l_cmd) 
            CALL aprt310_set_no_entry_b(l_cmd)
            #各等級會員積分，從astm401專櫃合同取值。--取对应的常规库区特价积分
            IF g_prec2_d[l_ac].prec082='Y' THEN
               LET g_prec2_d[l_ac].prec084=0
               LET g_prec2_d[l_ac].prec086=0
               LET g_prec2_d[l_ac].prec088=0
               LET g_prec2_d[l_ac].prec090=0
               LET g_prec2_d[l_ac].prec092=0   
               
               SELECT stfa001 INTO l_stfa001 #合同編號
                 FROM stfa_t
                WHERE stfaent=g_enterprise
                  AND stfa005=g_prec_d[l_ac].prec004
                  
                SELECT inaa141 INTO l_inaa141 #常规库区
                  FROM inaa_t
                 WHERE inaaent=g_enterprise
                   AND inaa001=g_prec_d[l_ac].prec003   
                                 
               SELECT stfd009 INTO g_prec2_d[l_ac].prec084
                 FROM stfd_t,oocq_t
                WHERE stfdent=g_enterprise
                  AND stfd003=l_inaa141
                  AND stfd001=l_stfa001
                  AND oocqent=g_enterprise
                  AND oocq001='2024'
                  AND oocqstus='Y'                  
                  AND oocq002=stfd004
                  AND oocq009='1'    #會員等級1 
               SELECT stfd009 INTO g_prec2_d[l_ac].prec086
                 FROM stfd_t,oocq_t
                WHERE stfdent=g_enterprise
                  AND stfd003=l_inaa141
                  AND stfd001=l_stfa001
                  AND oocqent=g_enterprise
                  AND oocq001='2024'
                  AND oocqstus='Y'                  
                  AND oocq002=stfd004
                  AND oocq009='2'    #會員等級2           
               SELECT stfd009 INTO g_prec2_d[l_ac].prec088
                 FROM stfd_t,oocq_t
                WHERE stfdent=g_enterprise
                  AND stfd003=l_inaa141
                  AND stfd001=l_stfa001
                  AND oocqent=g_enterprise
                  AND oocq001='2024'
                  AND oocqstus='Y'                  
                  AND oocq002=stfd004
                  AND oocq009='3'    #會員等級3           
               SELECT stfd009 INTO g_prec2_d[l_ac].prec090
                 FROM stfd_t,oocq_t
                WHERE stfdent=g_enterprise
                  AND stfd003=l_inaa141
                  AND stfd001=l_stfa001
                  AND oocqent=g_enterprise
                  AND oocq001='2024'
                  AND oocqstus='Y'                  
                  AND oocq002=stfd004
                  AND oocq009='4'    #會員等級4  
               SELECT stfd009 INTO g_prec2_d[l_ac].prec092
                 FROM stfd_t,oocq_t
                WHERE stfdent=g_enterprise
                  AND stfd003=l_inaa141
                  AND stfd001=l_stfa001
                  AND oocqent=g_enterprise
                  AND oocq001='2024'
                  AND oocqstus='Y'                  
                  AND oocq002=stfd004
                  AND oocq009='5'    #會員等級5                  
            END IF
            IF g_prec2_d[l_ac].prec082='N' THEN
               LET g_prec2_d[l_ac].prec084=0
               LET g_prec2_d[l_ac].prec086=0
               LET g_prec2_d[l_ac].prec088=0
               LET g_prec2_d[l_ac].prec090=0
               LET g_prec2_d[l_ac].prec092=0               
            END IF             
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE prec082
            #add-point:ON CHANGE prec082 name="input.g.page2.prec082"
            CALL aprt310_set_entry_b(l_cmd) 
            CALL aprt310_set_no_entry_b(l_cmd)
            #各等級會員積分，從astm401專櫃合同取值。
            IF g_prec2_d[l_ac].prec082='Y' THEN
               LET g_prec2_d[l_ac].prec084=0
               LET g_prec2_d[l_ac].prec086=0
               LET g_prec2_d[l_ac].prec088=0
               LET g_prec2_d[l_ac].prec090=0
               LET g_prec2_d[l_ac].prec092=0    
               
               SELECT stfa001 INTO l_stfa001 #合同編號
                 FROM stfa_t
                WHERE stfaent=g_enterprise
                  AND stfa005=g_prec_d[l_ac].prec004
                SELECT inaa141 INTO l_inaa141 #常规库区
                  FROM inaa_t
                 WHERE inaaent=g_enterprise
                   AND inaa001=g_prec_d[l_ac].prec003                   
               SELECT stfd009 INTO g_prec2_d[l_ac].prec084
                 FROM stfd_t,oocq_t
                WHERE stfdent=g_enterprise
                  AND stfd003=l_inaa141
                  AND stfd001=l_stfa001
                  AND oocqent=g_enterprise
                  AND oocq001='2024'
                  AND oocqstus='Y'                  
                  AND oocq002=stfd004
                  AND oocq009='1'    #會員等級1 
               SELECT stfd009 INTO g_prec2_d[l_ac].prec086
                 FROM stfd_t,oocq_t
                WHERE stfdent=g_enterprise
                  AND stfd003=l_inaa141
                  AND stfd001=l_stfa001
                  AND oocqent=g_enterprise
                  AND oocq001='2024'
                  AND oocqstus='Y'                  
                  AND oocq002=stfd004
                  AND oocq009='2'    #會員等級2           
               SELECT stfd009 INTO g_prec2_d[l_ac].prec088
                 FROM stfd_t,oocq_t
                WHERE stfdent=g_enterprise
                  AND stfd003=l_inaa141
                  AND stfd001=l_stfa001
                  AND oocqent=g_enterprise
                  AND oocq001='2024'
                  AND oocqstus='Y'                  
                  AND oocq002=stfd004
                  AND oocq009='3'    #會員等級3           
               SELECT stfd009 INTO g_prec2_d[l_ac].prec090
                 FROM stfd_t,oocq_t
                WHERE stfdent=g_enterprise
                  AND stfd003=l_inaa141
                  AND stfd001=l_stfa001
                  AND oocqent=g_enterprise
                  AND oocq001='2024'
                  AND oocqstus='Y'                  
                  AND oocq002=stfd004
                  AND oocq009='4'    #會員等級4  
               SELECT stfd009 INTO g_prec2_d[l_ac].prec092
                 FROM stfd_t,oocq_t
                WHERE stfdent=g_enterprise
                  AND stfd003=l_inaa141
                  AND stfd001=l_stfa001
                  AND oocqent=g_enterprise
                  AND oocq001='2024'
                  AND oocqstus='Y'                  
                  AND oocq002=stfd004
                  AND oocq009='5'    #會員等級5                   
            END IF
            IF g_prec2_d[l_ac].prec082='N' THEN
               LET g_prec2_d[l_ac].prec084=0
               LET g_prec2_d[l_ac].prec086=0
               LET g_prec2_d[l_ac].prec088=0
               LET g_prec2_d[l_ac].prec090=0
               LET g_prec2_d[l_ac].prec092=0               
            END IF              
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prec083
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_prec2_d[l_ac].prec083,"0","1","","","azz-00079",1) THEN
               NEXT FIELD prec083
            END IF 
 
 
 
            #add-point:AFTER FIELD prec083 name="input.a.page2.prec083"
            IF NOT cl_null(g_prec2_d[l_ac].prec083) THEN 
            END IF 


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prec083
            #add-point:BEFORE FIELD prec083 name="input.b.page2.prec083"
            IF g_prec_d[l_ac].prec074='N' THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = 'apr-00428'
               LET g_errparam.extend = ''
               LET g_errparam.popup = TRUE
               CALL cl_err()            
               NEXT FIELD precseq_2
            END IF
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE prec083
            #add-point:ON CHANGE prec083 name="input.g.page2.prec083"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prec084
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_prec2_d[l_ac].prec084,"0","1","","","azz-00079",1) THEN
               NEXT FIELD prec084
            END IF 
 
 
 
            #add-point:AFTER FIELD prec084 name="input.a.page2.prec084"
            IF NOT cl_null(g_prec2_d[l_ac].prec084) THEN 
            END IF 


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prec084
            #add-point:BEFORE FIELD prec084 name="input.b.page2.prec084"
            IF g_prec_d[l_ac].prec074='N' THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = 'apr-00428'
               LET g_errparam.extend = ''
               LET g_errparam.popup = TRUE
               CALL cl_err()            
               NEXT FIELD precseq_2
            END IF
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE prec084
            #add-point:ON CHANGE prec084 name="input.g.page2.prec084"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prec085
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_prec2_d[l_ac].prec085,"0","1","","","azz-00079",1) THEN
               NEXT FIELD prec085
            END IF 
 
 
 
            #add-point:AFTER FIELD prec085 name="input.a.page2.prec085"
            IF NOT cl_null(g_prec2_d[l_ac].prec085) THEN 
            END IF 


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prec085
            #add-point:BEFORE FIELD prec085 name="input.b.page2.prec085"
            IF g_prec_d[l_ac].prec074='N' THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = 'apr-00428'
               LET g_errparam.extend = ''
               LET g_errparam.popup = TRUE
               CALL cl_err()            
               NEXT FIELD precseq_2
            END IF
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE prec085
            #add-point:ON CHANGE prec085 name="input.g.page2.prec085"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prec086
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_prec2_d[l_ac].prec086,"0","1","","","azz-00079",1) THEN
               NEXT FIELD prec086
            END IF 
 
 
 
            #add-point:AFTER FIELD prec086 name="input.a.page2.prec086"
            IF NOT cl_null(g_prec2_d[l_ac].prec086) THEN 
            END IF 


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prec086
            #add-point:BEFORE FIELD prec086 name="input.b.page2.prec086"
            IF g_prec_d[l_ac].prec074='N' THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = 'apr-00428'
               LET g_errparam.extend = ''
               LET g_errparam.popup = TRUE
               CALL cl_err()            
               NEXT FIELD precseq_2
            END IF
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE prec086
            #add-point:ON CHANGE prec086 name="input.g.page2.prec086"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prec087
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_prec2_d[l_ac].prec087,"0","1","","","azz-00079",1) THEN
               NEXT FIELD prec087
            END IF 
 
 
 
            #add-point:AFTER FIELD prec087 name="input.a.page2.prec087"
            IF NOT cl_null(g_prec2_d[l_ac].prec087) THEN 
            END IF 


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prec087
            #add-point:BEFORE FIELD prec087 name="input.b.page2.prec087"
            IF g_prec_d[l_ac].prec074='N' THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = 'apr-00428'
               LET g_errparam.extend = ''
               LET g_errparam.popup = TRUE
               CALL cl_err()            
               NEXT FIELD precseq_2
            END IF
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE prec087
            #add-point:ON CHANGE prec087 name="input.g.page2.prec087"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prec088
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_prec2_d[l_ac].prec088,"0","1","","","azz-00079",1) THEN
               NEXT FIELD prec088
            END IF 
 
 
 
            #add-point:AFTER FIELD prec088 name="input.a.page2.prec088"
            IF NOT cl_null(g_prec2_d[l_ac].prec088) THEN 
            END IF 


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prec088
            #add-point:BEFORE FIELD prec088 name="input.b.page2.prec088"
            IF g_prec_d[l_ac].prec074='N' THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = 'apr-00428'
               LET g_errparam.extend = ''
               LET g_errparam.popup = TRUE
               CALL cl_err()            
               NEXT FIELD precseq_2
            END IF
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE prec088
            #add-point:ON CHANGE prec088 name="input.g.page2.prec088"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prec089
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_prec2_d[l_ac].prec089,"0","1","","","azz-00079",1) THEN
               NEXT FIELD prec089
            END IF 
 
 
 
            #add-point:AFTER FIELD prec089 name="input.a.page2.prec089"
            IF NOT cl_null(g_prec2_d[l_ac].prec089) THEN 
            END IF 


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prec089
            #add-point:BEFORE FIELD prec089 name="input.b.page2.prec089"
            IF g_prec_d[l_ac].prec074='N' THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = 'apr-00428'
               LET g_errparam.extend = ''
               LET g_errparam.popup = TRUE
               CALL cl_err()            
               NEXT FIELD precseq_2
            END IF
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE prec089
            #add-point:ON CHANGE prec089 name="input.g.page2.prec089"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prec090
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_prec2_d[l_ac].prec090,"0","1","","","azz-00079",1) THEN
               NEXT FIELD prec090
            END IF 
 
 
 
            #add-point:AFTER FIELD prec090 name="input.a.page2.prec090"
            IF NOT cl_null(g_prec2_d[l_ac].prec090) THEN 
            END IF 


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prec090
            #add-point:BEFORE FIELD prec090 name="input.b.page2.prec090"
            IF g_prec_d[l_ac].prec074='N' THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = 'apr-00428'
               LET g_errparam.extend = ''
               LET g_errparam.popup = TRUE
               CALL cl_err()            
               NEXT FIELD precseq_2
            END IF
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE prec090
            #add-point:ON CHANGE prec090 name="input.g.page2.prec090"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prec091
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_prec2_d[l_ac].prec091,"0","1","","","azz-00079",1) THEN
               NEXT FIELD prec091
            END IF 
 
 
 
            #add-point:AFTER FIELD prec091 name="input.a.page2.prec091"
            IF NOT cl_null(g_prec2_d[l_ac].prec091) THEN 
            END IF 


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prec091
            #add-point:BEFORE FIELD prec091 name="input.b.page2.prec091"
            IF g_prec_d[l_ac].prec074='N' THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = 'apr-00428'
               LET g_errparam.extend = ''
               LET g_errparam.popup = TRUE
               CALL cl_err()            
               NEXT FIELD precseq_2
            END IF
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE prec091
            #add-point:ON CHANGE prec091 name="input.g.page2.prec091"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prec092
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_prec2_d[l_ac].prec092,"0","1","","","azz-00079",1) THEN
               NEXT FIELD prec092
            END IF 
 
 
 
            #add-point:AFTER FIELD prec092 name="input.a.page2.prec092"
            IF NOT cl_null(g_prec2_d[l_ac].prec092) THEN 
            END IF 


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prec092
            #add-point:BEFORE FIELD prec092 name="input.b.page2.prec092"
            IF g_prec_d[l_ac].prec074='N' THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = 'apr-00428'
               LET g_errparam.extend = ''
               LET g_errparam.popup = TRUE
               CALL cl_err()            
               NEXT FIELD precseq_2
            END IF
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE prec092
            #add-point:ON CHANGE prec092 name="input.g.page2.prec092"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prec093
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_prec2_d[l_ac].prec093,"0","1","","","azz-00079",1) THEN
               NEXT FIELD prec093
            END IF 
 
 
 
            #add-point:AFTER FIELD prec093 name="input.a.page2.prec093"
            IF NOT cl_null(g_prec2_d[l_ac].prec093) THEN 
            END IF 


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prec093
            #add-point:BEFORE FIELD prec093 name="input.b.page2.prec093"
            IF g_prec_d[l_ac].prec074='N' THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = 'apr-00428'
               LET g_errparam.extend = ''
               LET g_errparam.popup = TRUE
               CALL cl_err()            
               NEXT FIELD precseq_2
            END IF
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE prec093
            #add-point:ON CHANGE prec093 name="input.g.page2.prec093"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prec094
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_prec2_d[l_ac].prec094,"0","1","","","azz-00079",1) THEN
               NEXT FIELD prec094
            END IF 
 
 
 
            #add-point:AFTER FIELD prec094 name="input.a.page2.prec094"
            IF NOT cl_null(g_prec2_d[l_ac].prec094) THEN 
            END IF 


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prec094
            #add-point:BEFORE FIELD prec094 name="input.b.page2.prec094"
            IF g_prec_d[l_ac].prec074='N' THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = 'apr-00428'
               LET g_errparam.extend = ''
               LET g_errparam.popup = TRUE
               CALL cl_err()            
               NEXT FIELD precseq_2
            END IF
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE prec094
            #add-point:ON CHANGE prec094 name="input.g.page2.prec094"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prec095
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_prec2_d[l_ac].prec095,"0","1","","","azz-00079",1) THEN
               NEXT FIELD prec095
            END IF 
 
 
 
            #add-point:AFTER FIELD prec095 name="input.a.page2.prec095"
            IF NOT cl_null(g_prec2_d[l_ac].prec095) THEN 
            END IF 


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prec095
            #add-point:BEFORE FIELD prec095 name="input.b.page2.prec095"
            IF g_prec_d[l_ac].prec074='N' THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = 'apr-00428'
               LET g_errparam.extend = ''
               LET g_errparam.popup = TRUE
               CALL cl_err()            
               NEXT FIELD precseq_2
            END IF
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE prec095
            #add-point:ON CHANGE prec095 name="input.g.page2.prec095"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prec096
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_prec2_d[l_ac].prec096,"0","1","","","azz-00079",1) THEN
               NEXT FIELD prec096
            END IF 
 
 
 
            #add-point:AFTER FIELD prec096 name="input.a.page2.prec096"
            IF NOT cl_null(g_prec2_d[l_ac].prec096) THEN 
            END IF 


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prec096
            #add-point:BEFORE FIELD prec096 name="input.b.page2.prec096"
            IF g_prec_d[l_ac].prec074='N' THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = 'apr-00428'
               LET g_errparam.extend = ''
               LET g_errparam.popup = TRUE
               CALL cl_err()            
               NEXT FIELD precseq_2
            END IF
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE prec096
            #add-point:ON CHANGE prec096 name="input.g.page2.prec096"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prec097
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_prec2_d[l_ac].prec097,"0","1","","","azz-00079",1) THEN
               NEXT FIELD prec097
            END IF 
 
 
 
            #add-point:AFTER FIELD prec097 name="input.a.page2.prec097"
            IF NOT cl_null(g_prec2_d[l_ac].prec097) THEN 
            END IF 


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prec097
            #add-point:BEFORE FIELD prec097 name="input.b.page2.prec097"
            IF g_prec_d[l_ac].prec074='N' THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = 'apr-00428'
               LET g_errparam.extend = ''
               LET g_errparam.popup = TRUE
               CALL cl_err()            
               NEXT FIELD precseq_2
            END IF
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE prec097
            #add-point:ON CHANGE prec097 name="input.g.page2.prec097"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD precunit
            #add-point:BEFORE FIELD precunit name="input.b.page2.precunit"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD precunit
            
            #add-point:AFTER FIELD precunit name="input.a.page2.precunit"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE precunit
            #add-point:ON CHANGE precunit name="input.g.page2.precunit"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD precsite
            #add-point:BEFORE FIELD precsite name="input.b.page2.precsite"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD precsite
            
            #add-point:AFTER FIELD precsite name="input.a.page2.precsite"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE precsite
            #add-point:ON CHANGE precsite name="input.g.page2.precsite"
            
            #END add-point 
 
 
 
                  #Ctrlp:input.c.page2.prec080
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prec080
            #add-point:ON ACTION controlp INFIELD prec080 name="input.c.page2.prec080"
            
            #END add-point
 
 
         #Ctrlp:input.c.page2.prec082
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prec082
            #add-point:ON ACTION controlp INFIELD prec082 name="input.c.page2.prec082"
            
            #END add-point
 
 
         #Ctrlp:input.c.page2.prec083
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prec083
            #add-point:ON ACTION controlp INFIELD prec083 name="input.c.page2.prec083"
            
            #END add-point
 
 
         #Ctrlp:input.c.page2.prec084
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prec084
            #add-point:ON ACTION controlp INFIELD prec084 name="input.c.page2.prec084"
            
            #END add-point
 
 
         #Ctrlp:input.c.page2.prec085
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prec085
            #add-point:ON ACTION controlp INFIELD prec085 name="input.c.page2.prec085"
            
            #END add-point
 
 
         #Ctrlp:input.c.page2.prec086
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prec086
            #add-point:ON ACTION controlp INFIELD prec086 name="input.c.page2.prec086"
            
            #END add-point
 
 
         #Ctrlp:input.c.page2.prec087
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prec087
            #add-point:ON ACTION controlp INFIELD prec087 name="input.c.page2.prec087"
            
            #END add-point
 
 
         #Ctrlp:input.c.page2.prec088
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prec088
            #add-point:ON ACTION controlp INFIELD prec088 name="input.c.page2.prec088"
            
            #END add-point
 
 
         #Ctrlp:input.c.page2.prec089
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prec089
            #add-point:ON ACTION controlp INFIELD prec089 name="input.c.page2.prec089"
            
            #END add-point
 
 
         #Ctrlp:input.c.page2.prec090
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prec090
            #add-point:ON ACTION controlp INFIELD prec090 name="input.c.page2.prec090"
            
            #END add-point
 
 
         #Ctrlp:input.c.page2.prec091
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prec091
            #add-point:ON ACTION controlp INFIELD prec091 name="input.c.page2.prec091"
            
            #END add-point
 
 
         #Ctrlp:input.c.page2.prec092
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prec092
            #add-point:ON ACTION controlp INFIELD prec092 name="input.c.page2.prec092"
            
            #END add-point
 
 
         #Ctrlp:input.c.page2.prec093
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prec093
            #add-point:ON ACTION controlp INFIELD prec093 name="input.c.page2.prec093"
            
            #END add-point
 
 
         #Ctrlp:input.c.page2.prec094
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prec094
            #add-point:ON ACTION controlp INFIELD prec094 name="input.c.page2.prec094"
            
            #END add-point
 
 
         #Ctrlp:input.c.page2.prec095
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prec095
            #add-point:ON ACTION controlp INFIELD prec095 name="input.c.page2.prec095"
            
            #END add-point
 
 
         #Ctrlp:input.c.page2.prec096
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prec096
            #add-point:ON ACTION controlp INFIELD prec096 name="input.c.page2.prec096"
            
            #END add-point
 
 
         #Ctrlp:input.c.page2.prec097
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prec097
            #add-point:ON ACTION controlp INFIELD prec097 name="input.c.page2.prec097"
            
            #END add-point
 
 
         #Ctrlp:input.c.page2.precunit
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD precunit
            #add-point:ON ACTION controlp INFIELD precunit name="input.c.page2.precunit"
            
            #END add-point
 
 
         #Ctrlp:input.c.page2.precsite
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD precsite
            #add-point:ON ACTION controlp INFIELD precsite name="input.c.page2.precsite"
            
            #END add-point
 
 
 
 
         AFTER ROW
            #add-point:單身page2 after_row name="input.body2.after_row"
            
            #end add-point
            LET l_ac = ARR_CURR()
            IF INT_FLAG THEN
               LET INT_FLAG = 0
               IF l_cmd = 'u' THEN
                  LET g_prec2_d[l_ac].* = g_prec2_d_t.*
               END IF
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code = 9001 
               LET g_errparam.popup = FALSE 
               CLOSE aprt310_bcl
               CALL s_transaction_end('N','0')
               CALL cl_err()
               EXIT DIALOG 
            END IF
            
            #其他table進行unlock
            
            CALL aprt310_unlock_b("prec_t","'2'")
            CALL s_transaction_end('Y','0')
            #add-point:單身page2 after_row2 name="input.body2.after_row2"
            
            #end add-point
 
         AFTER INPUT
            #add-point:input段after input  name="input.body2.after_input"
            
            #end add-point   
    
         ON ACTION controlo
            IF l_insert THEN
               LET li_reproduce = l_ac_t
               LET li_reproduce_target = l_ac
               LET g_prec_d[li_reproduce_target].* = g_prec_d[li_reproduce].*
               LET g_prec2_d[li_reproduce_target].* = g_prec2_d[li_reproduce].*
 
               LET g_prec2_d[li_reproduce_target].precseq = NULL
            ELSE
               CALL FGL_SET_ARR_CURR(g_prec2_d.getLength()+1)
               LET lb_reproduce = TRUE
               LET li_reproduce = l_ac
               LET li_reproduce_target = g_prec2_d.getLength()+1
            END IF
            
      END INPUT
      INPUT ARRAY g_prec3_d FROM s_detail3.*
         ATTRIBUTE(COUNT = g_rec_b,WITHOUT DEFAULTS, #MAXCOUNT = g_max_rec,
                 INSERT ROW = l_allow_insert, #此頁面insert功能由產生器控制, 手動之設定無效! 
 
                 DELETE ROW = l_allow_delete,
                 APPEND ROW = l_allow_insert)
                 
         #自訂ACTION(detail_input,page_3)
         
         
         BEFORE INPUT
            #add-point:資料輸入前 name="input.body3.before_input2"
            
            #end add-point
            IF g_insert = 'Y' AND NOT cl_null(g_insert) THEN 
              CALL FGL_SET_ARR_CURR(g_prec3_d.getLength()+1) 
              LET g_insert = 'N' 
           END IF 
 
            CALL aprt310_b_fill()
            #如果一直都在單身1則控制筆數位置
            IF g_loc = 'd' AND g_rec_b != 0 THEN
               CALL FGL_SET_ARR_CURR(g_idx_group.getValue("'4',"))
            END IF
            LET g_loc = 'd'
            LET g_rec_b = g_prec3_d.getLength()
            #add-point:資料輸入前 name="input.body3.before_input"
            
            #end add-point
            
         BEFORE INSERT
            IF s_transaction_chk("N",0) THEN
               CALL s_transaction_begin()
            END IF
            LET l_insert = TRUE
            LET l_n = ARR_COUNT()
            LET l_cmd = 'a'
            INITIALIZE g_prec3_d[l_ac].* TO NULL 
            INITIALIZE g_prec3_d_t.* TO NULL 
            INITIALIZE g_prec3_d_o.* TO NULL 
            #公用欄位給值(單身3)
            
            #自定義預設值(單身3)
                  LET g_prec3_d[l_ac].predacti = "Y"
      LET g_prec3_d[l_ac].pred006 = "0"
      LET g_prec3_d[l_ac].pred005 = "0"
 
            #add-point:modify段before備份 name="input.body3.insert.before_bak"
            LET g_prec3_d[l_ac].predsite=g_prea_m.preasite
            LET g_prec3_d[l_ac].predunit=g_prea_m.preaunit 
            #end add-point
            LET g_prec3_d_t.* = g_prec3_d[l_ac].*     #新輸入資料
            LET g_prec3_d_o.* = g_prec3_d[l_ac].*     #新輸入資料
            CALL cl_show_fld_cont()
            CALL aprt310_set_entry_b(l_cmd)
            #add-point:modify段after_set_entry_b name="input.body3.insert.after_set_entry_b"
            
            #end add-point
            CALL aprt310_set_no_entry_b(l_cmd)
            IF lb_reproduce THEN
               LET lb_reproduce = FALSE
               LET g_prec3_d[li_reproduce_target].* = g_prec3_d[li_reproduce].*
 
               LET g_prec3_d[li_reproduce_target].predseq = NULL
               LET g_prec3_d[li_reproduce_target].predseq1 = NULL
            END IF
            
 
            #add-point:modify段before insert name="input.body3.before_insert"
            
            #end add-point  
 
         BEFORE ROW     
            #add-point:modify段before row2 name="input.body3.before_row2"
            
            #end add-point  
            LET l_insert = FALSE
            LET l_cmd = ''
            LET l_ac_t = l_ac 
            LET g_detail_idx_list[3] = l_ac
            LET l_ac = ARR_CURR()
            LET g_detail_idx = l_ac
            LET g_current_page = 3
              
            LET l_lock_sw = 'N'            #DEFAULT
            LET l_n = ARR_COUNT()
            DISPLAY l_ac TO FORMONLY.idx
         
            CALL s_transaction_begin()
            OPEN aprt310_cl USING g_enterprise,g_prea_m.preadocno
            IF SQLCA.SQLCODE THEN   #(ver:78)
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "OPEN aprt310_cl:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE   #(ver:78)
               LET g_errparam.popup = TRUE 
               CLOSE aprt310_cl
               CALL s_transaction_end('N','0')
               CALL cl_err()
               RETURN
            END IF
            
            LET g_rec_b = g_prec3_d.getLength()
            
            IF g_rec_b >= l_ac 
               AND g_prec3_d[l_ac].predseq IS NOT NULL
               AND g_prec3_d[l_ac].predseq1 IS NOT NULL
            THEN 
               LET l_cmd='u'
               LET g_prec3_d_t.* = g_prec3_d[l_ac].*  #BACKUP
               LET g_prec3_d_o.* = g_prec3_d[l_ac].*  #BACKUP
               CALL aprt310_set_entry_b(l_cmd)
               #add-point:modify段after_set_entry_b name="input.body3.after_set_entry_b"
               
               #end add-point  
               CALL aprt310_set_no_entry_b(l_cmd)
               IF NOT aprt310_lock_b("pred_t","'3'") THEN
                  LET l_lock_sw='Y'
               ELSE
                  FETCH aprt310_bcl2 INTO g_prec3_d[l_ac].predacti,g_prec3_d[l_ac].predseq1,g_prec3_d[l_ac].pred001, 
                      g_prec3_d[l_ac].pred002,g_prec3_d[l_ac].pred003,g_prec3_d[l_ac].predseq,g_prec3_d[l_ac].pred004, 
                      g_prec3_d[l_ac].pred006,g_prec3_d[l_ac].pred005,g_prec3_d[l_ac].pred007,g_prec3_d[l_ac].predsite, 
                      g_prec3_d[l_ac].predunit
                  IF SQLCA.SQLCODE THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = SQLERRMESSAGE  
                     LET g_errparam.code = SQLCA.SQLCODE 
                     LET g_errparam.popup = TRUE 
                     CALL cl_err()
                     LET l_lock_sw = "Y"
                  END IF
                  
                  #遮罩相關處理
                  LET g_prec3_d_mask_o[l_ac].* =  g_prec3_d[l_ac].*
                  CALL aprt310_pred_t_mask()
                  LET g_prec3_d_mask_n[l_ac].* =  g_prec3_d[l_ac].*
                  
                  LET g_bfill = "N"
                  CALL aprt310_show()
                  LET g_bfill = "Y"
                  
                  CALL cl_show_fld_cont()
               END IF
            ELSE
               LET l_cmd='a'
            END IF
            #add-point:modify段before row name="input.body3.before_row"
            
            #end add-point  
            #其他table資料備份(確定是否更改用)
            
 
            #其他table進行lock
            
 
            
         BEFORE DELETE                            #是否取消單身
            IF l_cmd = 'a' THEN
               LET l_cmd='d'
               #add-point:單身AFTER DELETE (=d) name="input.body3.after_delete_d"
               
               #end add-point
            ELSE
               #add-point:單身刪除前 name="input.body3.b_delete_ask"
               
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
               
               #add-point:單身3刪除前 name="input.body3.b_delete"
               
               #end add-point    
                  
               #取得該筆資料key值
               INITIALIZE gs_keys TO NULL
               LET gs_keys[01] = g_prea_m.preadocno
               LET gs_keys[gs_keys.getLength()+1] = g_prec3_d_t.predseq
               LET gs_keys[gs_keys.getLength()+1] = g_prec3_d_t.predseq1
            
               #刪除同層單身
               IF NOT aprt310_delete_b('pred_t',gs_keys,"'3'") THEN
                  CALL s_transaction_end('N','0')
                  CLOSE aprt310_bcl
                  CANCEL DELETE
               END IF
    
               #刪除下層單身
               IF NOT aprt310_key_delete_b(gs_keys,'pred_t') THEN
                  CALL s_transaction_end('N','0')
                  CLOSE aprt310_bcl
                  CANCEL DELETE
               END IF
               
               #刪除多語言
               
 
               
               #add-point:單身3刪除中 name="input.body3.m_delete"
               
               #end add-point    
               
               CALL s_transaction_end('Y','0')
               CLOSE aprt310_bcl
 
               LET g_rec_b = g_rec_b-1
               #add-point:單身3刪除後 name="input.body3.a_delete"
               
               #end add-point
               LET l_count = g_prec_d.getLength()
               
               #add-point:單身刪除後(<>d) name="input.body3.after_delete"
               
               #end add-point
            END IF 
 
         AFTER DELETE
            #如果是最後一筆
            IF l_ac = (g_prec3_d.getLength() + 1) THEN
               CALL FGL_SET_ARR_CURR(l_ac-1)
            END IF
 
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
               
            #add-point:單身3新增前 name="input.body3.b_a_insert"
            
            #end add-point
               
            LET l_count = 1  
            SELECT COUNT(1) INTO l_count FROM pred_t 
             WHERE predent = g_enterprise AND preddocno = g_prea_m.preadocno
               AND predseq = g_prec3_d[l_ac].predseq
               AND predseq1 = g_prec3_d[l_ac].predseq1
                
            #資料未重複, 插入新增資料
            IF l_count = 0 THEN 
               #add-point:單身3新增前 name="input.body3.b_insert"
               
               #end add-point
            
                              INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_prea_m.preadocno
               LET gs_keys[2] = g_prec3_d[g_detail_idx].predseq
               LET gs_keys[3] = g_prec3_d[g_detail_idx].predseq1
               CALL aprt310_insert_b('pred_t',gs_keys,"'3'")
                           
               #add-point:單身新增後3 name="input.body3.a_insert"
               
               #end add-point
            ELSE    
               INITIALIZE g_prec_d[l_ac].* TO NULL
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = 'INSERT' 
               LET g_errparam.code = "std-00006" 
               LET g_errparam.popup = TRUE 
               CALL s_transaction_end('N','0')
               CALL cl_err()
               CANCEL INSERT
            END IF
 
            IF SQLCA.SQLCODE THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "pred_t:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE 
               LET g_errparam.popup = TRUE 
               CALL s_transaction_end('N','0')                    
               CALL cl_err()
               CANCEL INSERT
            ELSE
               #先刷新資料
               #CALL aprt310_b_fill()
               #資料多語言用-增/改
               
               #add-point:單身新增後 name="input.body3.after_insert"
               
               #end add-point
               CALL s_transaction_end('Y','0')
               #ERROR 'INSERT O.K'
               LET g_rec_b = g_rec_b + 1
            END IF
            
         ON ROW CHANGE 
            IF INT_FLAG THEN
               LET INT_FLAG = 0
               LET g_prec3_d[l_ac].* = g_prec3_d_t.*
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code = 9001 
               LET g_errparam.popup = FALSE 
               CLOSE aprt310_bcl2
               CALL s_transaction_end('N','0')
               CALL cl_err()
               EXIT DIALOG 
            END IF
            
            IF l_lock_sw = 'Y' THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code = -263 
               LET g_errparam.popup = TRUE 
               CALL cl_err()
               LET g_prec3_d[l_ac].* = g_prec3_d_t.*
            ELSE
               #add-point:單身page3修改前 name="input.body3.b_update"
               
               #end add-point
               
               #寫入修改者/修改日期資訊(單身3)
               
               
               #將遮罩欄位還原
               CALL aprt310_pred_t_mask_restore('restore_mask_o')
                              
               UPDATE pred_t SET (preddocno,predacti,predseq1,pred001,pred002,pred003,predseq,pred004, 
                   pred006,pred005,pred007,predsite,predunit) = (g_prea_m.preadocno,g_prec3_d[l_ac].predacti, 
                   g_prec3_d[l_ac].predseq1,g_prec3_d[l_ac].pred001,g_prec3_d[l_ac].pred002,g_prec3_d[l_ac].pred003, 
                   g_prec3_d[l_ac].predseq,g_prec3_d[l_ac].pred004,g_prec3_d[l_ac].pred006,g_prec3_d[l_ac].pred005, 
                   g_prec3_d[l_ac].pred007,g_prec3_d[l_ac].predsite,g_prec3_d[l_ac].predunit) #自訂欄位頁簽 
 
                WHERE predent = g_enterprise AND preddocno = g_prea_m.preadocno
                  AND predseq = g_prec3_d_t.predseq #項次 
                  AND predseq1 = g_prec3_d_t.predseq1
                  
               #add-point:單身page3修改中 name="input.body3.m_update"
               
               #end add-point
                  
               CASE
                  WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
                     LET g_prec3_d[l_ac].* = g_prec3_d_t.*
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "pred_t" 
                     LET g_errparam.code = "std-00009" 
                     LET g_errparam.popup = TRUE 
                     CALL s_transaction_end('N','0')
                     CALL cl_err()
                     
                  WHEN SQLCA.SQLCODE #其他錯誤
                     LET g_prec3_d[l_ac].* = g_prec3_d_t.*
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "pred_t:",SQLERRMESSAGE 
                     LET g_errparam.code = SQLCA.SQLCODE 
                     LET g_errparam.popup = TRUE 
                     CALL s_transaction_end('N','0')
                     CALL cl_err()
                     
                  OTHERWISE
                     #資料多語言用-增/改
                     
                                    INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_prea_m.preadocno
               LET gs_keys_bak[1] = g_preadocno_t
               LET gs_keys[2] = g_prec3_d[g_detail_idx].predseq
               LET gs_keys_bak[2] = g_prec3_d_t.predseq
               LET gs_keys[3] = g_prec3_d[g_detail_idx].predseq1
               LET gs_keys_bak[3] = g_prec3_d_t.predseq1
               CALL aprt310_update_b('pred_t',gs_keys,gs_keys_bak,"'3'")
               END CASE
               
               #將遮罩欄位進行遮蔽
               CALL aprt310_pred_t_mask_restore('restore_mask_n')
               
               #判斷key是否有改變
               INITIALIZE gs_keys TO NULL
               IF NOT (g_prec3_d[g_detail_idx].predseq = g_prec3_d_t.predseq 
                  AND g_prec3_d[g_detail_idx].predseq1 = g_prec3_d_t.predseq1 
                  ) THEN
                  LET gs_keys[01] = g_prea_m.preadocno
                  LET gs_keys[gs_keys.getLength()+1] = g_prec3_d_t.predseq
                  LET gs_keys[gs_keys.getLength()+1] = g_prec3_d_t.predseq1
                  CALL aprt310_key_update_b(gs_keys,'pred_t')
               END IF
               
               #修改歷程記錄(單身修改)
               LET g_log1 = util.JSON.stringify(g_prea_m),util.JSON.stringify(g_prec3_d_t)
               LET g_log2 = util.JSON.stringify(g_prea_m),util.JSON.stringify(g_prec3_d[l_ac])
               IF NOT cl_log_modified_record_d(g_log1,g_log2) THEN 
                  CALL s_transaction_end('N','0')
               END IF
               
               #add-point:單身page3修改後 name="input.body3.a_update"
               
               #end add-point
            END IF
         
                  #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD predacti
            #add-point:BEFORE FIELD predacti name="input.b.page3.predacti"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD predacti
            
            #add-point:AFTER FIELD predacti name="input.a.page3.predacti"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE predacti
            #add-point:ON CHANGE predacti name="input.g.page3.predacti"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD predseq1
            #add-point:BEFORE FIELD predseq1 name="input.b.page3.predseq1"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD predseq1
            
            #add-point:AFTER FIELD predseq1 name="input.a.page3.predseq1"
            #應用 a05 樣板自動產生(Version:2)
            #確認資料無重複
            IF  g_prea_m.preadocno IS NOT NULL AND g_prec3_d[g_detail_idx].predseq IS NOT NULL AND g_prec3_d[g_detail_idx].predseq1 IS NOT NULL THEN 
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_prea_m.preadocno != g_preadocno_t OR g_prec3_d[g_detail_idx].predseq != g_prec3_d_t.predseq OR g_prec3_d[g_detail_idx].predseq1 != g_prec3_d_t.predseq1)) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM pred_t WHERE "||"predent = '" ||g_enterprise|| "' AND "||"preddocno = '"||g_prea_m.preadocno ||"' AND "|| "predseq = '"||g_prec3_d[g_detail_idx].predseq ||"' AND "|| "predseq1 = '"||g_prec3_d[g_detail_idx].predseq1 ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF              
               END IF
            END IF
            IF NOT cl_null(g_prec3_d[l_ac].predseq1) THEN
                  LET l_n1=0
                  SELECT count(*) INTO l_n1
                    FROM prec_t
                   WHERE precent=g_enterprise
                     AND precdocno=g_prea_m.preadocno
                     AND precseq=g_prec3_d[l_ac].predseq1
                  IF cl_null(l_n1) OR l_n1=0 THEN
                     LET g_errparam.code = 'apr-00390'
                     LET g_errparam.extend = g_prec3_d[l_ac].predseq1
                     LET g_errparam.popup = TRUE
                     CALL cl_err()                
                     #LET g_prec3_d[l_ac].predseq1 = g_prec3_d_t.predseq1   #160824-00007#147 20161123 mark by beckxie
                     #160824-00007#147 20161123 add by beckxie---S
                     LET g_prec3_d[l_ac].predseq1 = g_prec3_d_o.predseq1    
                     LET g_prec3_d[l_ac].pred001 = g_prec3_d_o.pred001 
                     LET g_prec3_d[l_ac].pred002 = g_prec3_d_o.pred002
                     LET g_prec3_d[l_ac].pred002_desc = g_prec3_d_o.pred002_desc
                     LET g_prec3_d[l_ac].pred003 = g_prec3_d_o.pred003
                     LET g_prec3_d[l_ac].pred003_desc = g_prec3_d_o.pred003_desc
                     #160824-00007#147 20161123 add by beckxie---E
                     NEXT FIELD CURRENT                   
             
                  END IF
                  #检查是否需要录入保底                  
                  LET l_n1=0
                  SELECT count(*) INTO l_n1
                    FROM prec_t
                   WHERE precent=g_enterprise
                     AND precdocno=g_prea_m.preadocno
                     AND precseq=g_prec3_d[l_ac].predseq1
                     AND prec060<>'1'
                  IF cl_null(l_n1) OR l_n1=0 THEN
                     LET g_errparam.code = 'apr-00443'
                     LET g_errparam.extend = g_prec3_d[l_ac].predseq1
                     LET g_errparam.popup = TRUE
                     CALL cl_err()                
                     #LET g_prec3_d[l_ac].predseq1 = g_prec3_d_t.predseq1   #160824-00007#147 20161123 mark by beckxie
                     #160824-00007#147 20161123 add by beckxie---S
                     LET g_prec3_d[l_ac].predseq1 = g_prec3_d_o.predseq1    
                     LET g_prec3_d[l_ac].pred001 = g_prec3_d_o.pred001 
                     LET g_prec3_d[l_ac].pred002 = g_prec3_d_o.pred002
                     LET g_prec3_d[l_ac].pred002_desc = g_prec3_d_o.pred002_desc
                     LET g_prec3_d[l_ac].pred003 = g_prec3_d_o.pred003
                     LET g_prec3_d[l_ac].pred003_desc = g_prec3_d_o.pred003_desc
                     #160824-00007#147 20161123 add by beckxie---E
                     NEXT FIELD CURRENT                   
             
                  END IF   
                  LET g_prec3_d[l_ac].pred004=''
                  
                  SELECT prec001,prec003,prec004 INTO g_prec3_d[l_ac].pred001,g_prec3_d[l_ac].pred002,g_prec3_d[l_ac].pred003
                    FROM prec_t
                   WHERE precent=g_enterprise
                     AND precdocno=g_prea_m.preadocno
                     AND precseq=g_prec3_d[l_ac].predseq1  
                  
            END IF                     
            SELECT mhael023 INTO g_prec3_d[l_ac].pred003_desc
              FROM mhael_t
             WHERE mhaelent=g_enterprise
               AND mhaelsite=g_prea_m.preasite
               AND mhael022=g_dlang
               AND mhael001=g_prec3_d[l_ac].pred003
            DISPLAY BY NAME g_prec3_d[l_ac].pred003_desc 
            #150907-00033#2 20150915 mark by beckxie---S
            #INITIALIZE g_ref_fields TO NULL
            #LET g_ref_fields[1] = g_prea_m.preasite
            #LET g_ref_fields[2] = g_prec3_d[l_ac].pred002
            #CALL ap_ref_array2(g_ref_fields,"SELECT inaa002 FROM inaa_t WHERE inaaent='"||g_enterprise||"' AND inaasite=? AND inaa001=? ","") RETURNING g_rtn_fields
            #LET g_prec3_d[l_ac].pred002_desc = '', g_rtn_fields[1] , ''
            #DISPLAY BY NAME g_prec3_d[l_ac].pred002_desc
            #150907-00033#2 20150915 mark by beckxie---E
            #150907-00033#2 20150915  add by beckxie---S
            CALL s_desc_get_stock_desc(g_prea_m.preasite,g_prec3_d[l_ac].pred002) RETURNING g_prec3_d[l_ac].pred002_desc
            DISPLAY BY NAME g_prec3_d[l_ac].pred002_desc
            #150907-00033#2 20150915  add by beckxie---E
            LET g_prec3_d_o.* = g_prec3_d[l_ac].*   #160824-00007#147 20161123 add by beckxie
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE predseq1
            #add-point:ON CHANGE predseq1 name="input.g.page3.predseq1"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pred001
            #add-point:BEFORE FIELD pred001 name="input.b.page3.pred001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pred001
            
            #add-point:AFTER FIELD pred001 name="input.a.page3.pred001"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pred001
            #add-point:ON CHANGE pred001 name="input.g.page3.pred001"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pred002
            
            #add-point:AFTER FIELD pred002 name="input.a.page3.pred002"
            #150907-00033#2 20150915 mark by beckxie---S
            #INITIALIZE g_ref_fields TO NULL
            #LET g_ref_fields[1] = g_prec3_d[l_ac].predsite
            #LET g_ref_fields[2] = g_prec3_d[l_ac].pred002
            #CALL ap_ref_array2(g_ref_fields,"SELECT inaa002 FROM inaa_t WHERE inaaent='"||g_enterprise||"' AND inaasite=? AND inaa001=? ","") RETURNING g_rtn_fields
            #LET g_prec3_d[l_ac].pred002_desc = '', g_rtn_fields[1] , ''
            #DISPLAY BY NAME g_prec3_d[l_ac].pred002_desc
            #150907-00033#2 20150915 mark by beckxie---E
            #150907-00033#2 20150915  add by beckxie---S
            CALL s_desc_get_stock_desc(g_prec3_d[l_ac].predsite,g_prec3_d[l_ac].pred002) RETURNING g_prec3_d[l_ac].pred002_desc
            DISPLAY BY NAME g_prec3_d[l_ac].pred002_desc
            #150907-00033#2 20150915  add by beckxie---E

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pred002
            #add-point:BEFORE FIELD pred002 name="input.b.page3.pred002"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pred002
            #add-point:ON CHANGE pred002 name="input.g.page3.pred002"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pred003
            
            #add-point:AFTER FIELD pred003 name="input.a.page3.pred003"
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_prec3_d[l_ac].predsite
            LET g_ref_fields[2] = g_prec3_d[l_ac].pred003
            CALL ap_ref_array2(g_ref_fields,"SELECT mhael023 FROM mhael_t WHERE mhaelent='"||g_enterprise||"' AND mhaelsite=? AND mhael001=? AND mhael022='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_prec3_d[l_ac].pred003_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_prec3_d[l_ac].pred003_desc


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pred003
            #add-point:BEFORE FIELD pred003 name="input.b.page3.pred003"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pred003
            #add-point:ON CHANGE pred003 name="input.g.page3.pred003"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD predseq
            #add-point:BEFORE FIELD predseq name="input.b.page3.predseq"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD predseq
            
            #add-point:AFTER FIELD predseq name="input.a.page3.predseq"
            #應用 a05 樣板自動產生(Version:2)
            #確認資料無重複
            IF  g_prea_m.preadocno IS NOT NULL AND g_prec3_d[g_detail_idx].predseq IS NOT NULL AND g_prec3_d[g_detail_idx].predseq1 IS NOT NULL THEN 
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_prea_m.preadocno != g_preadocno_t OR g_prec3_d[g_detail_idx].predseq != g_prec3_d_t.predseq OR g_prec3_d[g_detail_idx].predseq1 != g_prec3_d_t.predseq1)) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM pred_t WHERE "||"predent = '" ||g_enterprise|| "' AND "||"preddocno = '"||g_prea_m.preadocno ||"' AND "|| "predseq = '"||g_prec3_d[g_detail_idx].predseq ||"' AND "|| "predseq1 = '"||g_prec3_d[g_detail_idx].predseq1 ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF


            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE predseq
            #add-point:ON CHANGE predseq name="input.g.page3.predseq"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pred004
            #add-point:BEFORE FIELD pred004 name="input.b.page3.pred004"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pred004
            
            #add-point:AFTER FIELD pred004 name="input.a.page3.pred004"
            #检查保底类型                  
            IF NOT cl_null(g_prec3_d[l_ac].predseq1)  AND NOT cl_null(g_prec3_d[l_ac].pred004) THEN
               SELECT prec060 INTO l_prec060
                 FROM prec_t
                WHERE precent=g_enterprise
                  AND precdocno=g_prea_m.preadocno
                  AND precseq=g_prec3_d[l_ac].predseq1
               IF l_prec060='1' THEN
                  LET g_errparam.code = 'apr-00443'
                  LET g_errparam.extend = g_prec3_d[l_ac].predseq1
                  LET g_errparam.popup = TRUE
                  CALL cl_err()                
                  LET g_prec3_d[l_ac].pred004 = g_prec3_d_t.pred004
                  NEXT FIELD CURRENT                   
               
               END IF  
               IF l_prec060='2' AND g_prec3_d[l_ac].pred004='2' THEN
                  LET g_errparam.code = 'apr-00444'
                  LET g_errparam.extend = g_prec3_d[l_ac].predseq1
                  LET g_errparam.popup = TRUE
                  CALL cl_err()                
                  LET g_prec3_d[l_ac].pred004 = g_prec3_d_t.pred004
                  NEXT FIELD CURRENT                   
               
               END IF   
               IF l_prec060='4' AND g_prec3_d[l_ac].pred004='1' THEN
                  LET g_errparam.code = 'apr-00445'
                  LET g_errparam.extend = g_prec3_d[l_ac].predseq1
                  LET g_errparam.popup = TRUE
                  CALL cl_err()                
                  LET g_prec3_d[l_ac].pred004 = g_prec3_d_t.pred004
                  NEXT FIELD CURRENT                   
               
               END IF                
            END IF  
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pred004
            #add-point:ON CHANGE pred004 name="input.g.page3.pred004"
            #检查保底类型                  
            IF NOT cl_null(g_prec3_d[l_ac].predseq1)  AND NOT cl_null(g_prec3_d[l_ac].pred004) THEN
               SELECT prec060 INTO l_prec060
                 FROM prec_t
                WHERE precent=g_enterprise
                  AND precdocno=g_prea_m.preadocno
                  AND precseq=g_prec3_d[l_ac].predseq1
               IF l_prec060='1' THEN
                  LET g_errparam.code = 'apr-00443'
                  LET g_errparam.extend = g_prec3_d[l_ac].predseq1
                  LET g_errparam.popup = TRUE
                  CALL cl_err()                
                  LET g_prec3_d[l_ac].pred004 = g_prec3_d_t.pred004
                  NEXT FIELD CURRENT                   
               
               END IF  
               IF l_prec060='2' AND g_prec3_d[l_ac].pred004='2' THEN
                  LET g_errparam.code = 'apr-00444'
                  LET g_errparam.extend = g_prec3_d[l_ac].predseq1
                  LET g_errparam.popup = TRUE
                  CALL cl_err()                
                  LET g_prec3_d[l_ac].pred004 = g_prec3_d_t.pred004
                  NEXT FIELD CURRENT                   
               
               END IF   
               IF l_prec060='4' AND g_prec3_d[l_ac].pred004='1' THEN
                  LET g_errparam.code = 'apr-00445'
                  LET g_errparam.extend = g_prec3_d[l_ac].predseq1
                  LET g_errparam.popup = TRUE
                  CALL cl_err()                
                  LET g_prec3_d[l_ac].pred004 = g_prec3_d_t.pred004
                  NEXT FIELD CURRENT                   
               
               END IF                
            END IF               
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pred006
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_prec3_d[l_ac].pred006,"0","1","","","azz-00079",1) THEN
               NEXT FIELD pred006
            END IF 
 
 
 
            #add-point:AFTER FIELD pred006 name="input.a.page3.pred006"
            IF NOT cl_null(g_prec3_d[l_ac].pred006) THEN 
            END IF 


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pred006
            #add-point:BEFORE FIELD pred006 name="input.b.page3.pred006"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pred006
            #add-point:ON CHANGE pred006 name="input.g.page3.pred006"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pred005
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_prec3_d[l_ac].pred005,"0","1","","","azz-00079",1) THEN
               NEXT FIELD pred005
            END IF 
 
 
 
            #add-point:AFTER FIELD pred005 name="input.a.page3.pred005"
            IF NOT cl_null(g_prec3_d[l_ac].pred005) THEN 
            END IF 


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pred005
            #add-point:BEFORE FIELD pred005 name="input.b.page3.pred005"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pred005
            #add-point:ON CHANGE pred005 name="input.g.page3.pred005"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pred007
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_prec3_d[l_ac].pred007,"0","1","","","azz-00079",1) THEN
               NEXT FIELD pred007
            END IF 
 
 
 
            #add-point:AFTER FIELD pred007 name="input.a.page3.pred007"
            IF NOT cl_null(g_prec3_d[l_ac].pred007) THEN 
            END IF 


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pred007
            #add-point:BEFORE FIELD pred007 name="input.b.page3.pred007"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pred007
            #add-point:ON CHANGE pred007 name="input.g.page3.pred007"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD predsite
            #add-point:BEFORE FIELD predsite name="input.b.page3.predsite"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD predsite
            
            #add-point:AFTER FIELD predsite name="input.a.page3.predsite"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE predsite
            #add-point:ON CHANGE predsite name="input.g.page3.predsite"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD predunit
            #add-point:BEFORE FIELD predunit name="input.b.page3.predunit"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD predunit
            
            #add-point:AFTER FIELD predunit name="input.a.page3.predunit"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE predunit
            #add-point:ON CHANGE predunit name="input.g.page3.predunit"
            
            #END add-point 
 
 
 
                  #Ctrlp:input.c.page3.predacti
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD predacti
            #add-point:ON ACTION controlp INFIELD predacti name="input.c.page3.predacti"
            
            #END add-point
 
 
         #Ctrlp:input.c.page3.predseq1
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD predseq1
            #add-point:ON ACTION controlp INFIELD predseq1 name="input.c.page3.predseq1"
            
            #END add-point
 
 
         #Ctrlp:input.c.page3.pred001
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pred001
            #add-point:ON ACTION controlp INFIELD pred001 name="input.c.page3.pred001"
            
            #END add-point
 
 
         #Ctrlp:input.c.page3.pred002
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pred002
            #add-point:ON ACTION controlp INFIELD pred002 name="input.c.page3.pred002"
            
            #END add-point
 
 
         #Ctrlp:input.c.page3.pred003
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pred003
            #add-point:ON ACTION controlp INFIELD pred003 name="input.c.page3.pred003"
            
            #END add-point
 
 
         #Ctrlp:input.c.page3.predseq
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD predseq
            #add-point:ON ACTION controlp INFIELD predseq name="input.c.page3.predseq"
            
            #END add-point
 
 
         #Ctrlp:input.c.page3.pred004
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pred004
            #add-point:ON ACTION controlp INFIELD pred004 name="input.c.page3.pred004"
            
            #END add-point
 
 
         #Ctrlp:input.c.page3.pred006
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pred006
            #add-point:ON ACTION controlp INFIELD pred006 name="input.c.page3.pred006"
            
            #END add-point
 
 
         #Ctrlp:input.c.page3.pred005
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pred005
            #add-point:ON ACTION controlp INFIELD pred005 name="input.c.page3.pred005"
            
            #END add-point
 
 
         #Ctrlp:input.c.page3.pred007
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pred007
            #add-point:ON ACTION controlp INFIELD pred007 name="input.c.page3.pred007"
            
            #END add-point
 
 
         #Ctrlp:input.c.page3.predsite
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD predsite
            #add-point:ON ACTION controlp INFIELD predsite name="input.c.page3.predsite"
            
            #END add-point
 
 
         #Ctrlp:input.c.page3.predunit
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD predunit
            #add-point:ON ACTION controlp INFIELD predunit name="input.c.page3.predunit"
            
            #END add-point
 
 
 
 
         AFTER ROW
            #add-point:單身page3 after_row name="input.body3.after_row"
            
            #end add-point
            LET l_ac = ARR_CURR()
            IF INT_FLAG THEN
               LET INT_FLAG = 0
               IF l_cmd = 'u' THEN
                  LET g_prec3_d[l_ac].* = g_prec3_d_t.*
               END IF
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code = 9001 
               LET g_errparam.popup = FALSE 
               CLOSE aprt310_bcl2
               CALL s_transaction_end('N','0')
               CALL cl_err()
               EXIT DIALOG 
            END IF
            
            #其他table進行unlock
            
            CALL aprt310_unlock_b("pred_t","'3'")
            CALL s_transaction_end('Y','0')
            #add-point:單身page3 after_row2 name="input.body3.after_row2"
            
            #end add-point
 
         AFTER INPUT
            #add-point:input段after input  name="input.body3.after_input"
            
            #end add-point   
    
         ON ACTION controlo
            IF l_insert THEN
               LET li_reproduce = l_ac_t
               LET li_reproduce_target = l_ac
               LET g_prec3_d[li_reproduce_target].* = g_prec3_d[li_reproduce].*
 
               LET g_prec3_d[li_reproduce_target].predseq = NULL
               LET g_prec3_d[li_reproduce_target].predseq1 = NULL
            ELSE
               CALL FGL_SET_ARR_CURR(g_prec3_d.getLength()+1)
               LET lb_reproduce = TRUE
               LET li_reproduce = l_ac
               LET li_reproduce_target = g_prec3_d.getLength()+1
            END IF
            
      END INPUT
      INPUT ARRAY g_prec4_d FROM s_detail4.*
         ATTRIBUTE(COUNT = g_rec_b,WITHOUT DEFAULTS, #MAXCOUNT = g_max_rec,
                 INSERT ROW = l_allow_insert, #此頁面insert功能由產生器控制, 手動之設定無效! 
 
                 DELETE ROW = l_allow_delete,
                 APPEND ROW = l_allow_insert)
                 
         #自訂ACTION(detail_input,page_4)
         
         
         BEFORE INPUT
            #add-point:資料輸入前 name="input.body4.before_input2"
            
            #end add-point
            IF g_insert = 'Y' AND NOT cl_null(g_insert) THEN 
              CALL FGL_SET_ARR_CURR(g_prec4_d.getLength()+1) 
              LET g_insert = 'N' 
           END IF 
 
            CALL aprt310_b_fill()
            #如果一直都在單身1則控制筆數位置
            IF g_loc = 'd' AND g_rec_b != 0 THEN
               CALL FGL_SET_ARR_CURR(g_idx_group.getValue(""))
            END IF
            LET g_loc = 'd'
            LET g_rec_b = g_prec4_d.getLength()
            #add-point:資料輸入前 name="input.body4.before_input"
            
            #end add-point
            
         BEFORE INSERT
            IF s_transaction_chk("N",0) THEN
               CALL s_transaction_begin()
            END IF
            LET l_insert = TRUE
            LET l_n = ARR_COUNT()
            LET l_cmd = 'a'
            INITIALIZE g_prec4_d[l_ac].* TO NULL 
            INITIALIZE g_prec4_d_t.* TO NULL 
            INITIALIZE g_prec4_d_o.* TO NULL 
            #公用欄位給值(單身4)
            
            #自定義預設值(單身4)
                  LET g_prec4_d[l_ac].prebacti = "Y"
 
            #add-point:modify段before備份 name="input.body4.insert.before_bak"

            SELECT MAX(preb002)+1 INTO g_prec4_d[l_ac].preb002
              FROM preb_t
             WHERE prebent = g_enterprise
               AND prebdocno = g_prea_m.preadocno
            IF cl_null(g_prec4_d[l_ac].preb002) THEN
               LET g_prec4_d[l_ac].preb002 = 1
            END IF 
            LET g_prec4_d[l_ac].prebsite=g_prea_m.preasite
            LET g_prec4_d[l_ac].prebunit=g_prea_m.preaunit 
            LET g_prec4_d[l_ac].preb001=g_prea_m.prea001
            LET g_prec4_d[l_ac].preb005='00:00:00'
            LET g_prec4_d[l_ac].preb006='23:59:59'            
            #end add-point
            LET g_prec4_d_t.* = g_prec4_d[l_ac].*     #新輸入資料
            LET g_prec4_d_o.* = g_prec4_d[l_ac].*     #新輸入資料
            CALL cl_show_fld_cont()
            CALL aprt310_set_entry_b(l_cmd)
            #add-point:modify段after_set_entry_b name="input.body4.insert.after_set_entry_b"
            
            #end add-point
            CALL aprt310_set_no_entry_b(l_cmd)
            IF lb_reproduce THEN
               LET lb_reproduce = FALSE
               LET g_prec4_d[li_reproduce_target].* = g_prec4_d[li_reproduce].*
 
               LET g_prec4_d[li_reproduce_target].preb002 = NULL
            END IF
            
 
            #add-point:modify段before insert name="input.body4.before_insert"
  
            #end add-point  
 
         BEFORE ROW     
            #add-point:modify段before row2 name="input.body4.before_row2"
            
            #end add-point  
            LET l_insert = FALSE
            LET l_cmd = ''
            LET l_ac_t = l_ac 
            LET g_detail_idx_list[4] = l_ac
            LET l_ac = ARR_CURR()
            LET g_detail_idx = l_ac
            LET g_current_page = 4
              
            LET l_lock_sw = 'N'            #DEFAULT
            LET l_n = ARR_COUNT()
            DISPLAY l_ac TO FORMONLY.idx
         
            CALL s_transaction_begin()
            OPEN aprt310_cl USING g_enterprise,g_prea_m.preadocno
            IF SQLCA.SQLCODE THEN   #(ver:78)
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "OPEN aprt310_cl:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE   #(ver:78)
               LET g_errparam.popup = TRUE 
               CLOSE aprt310_cl
               CALL s_transaction_end('N','0')
               CALL cl_err()
               RETURN
            END IF
            
            LET g_rec_b = g_prec4_d.getLength()
            
            IF g_rec_b >= l_ac 
               AND g_prec4_d[l_ac].preb002 IS NOT NULL
            THEN 
               LET l_cmd='u'
               LET g_prec4_d_t.* = g_prec4_d[l_ac].*  #BACKUP
               LET g_prec4_d_o.* = g_prec4_d[l_ac].*  #BACKUP
               CALL aprt310_set_entry_b(l_cmd)
               #add-point:modify段after_set_entry_b name="input.body4.after_set_entry_b"
               
               #end add-point  
               CALL aprt310_set_no_entry_b(l_cmd)
               IF NOT aprt310_lock_b("preb_t","'4'") THEN
                  LET l_lock_sw='Y'
               ELSE
                  FETCH aprt310_bcl3 INTO g_prec4_d[l_ac].preb002,g_prec4_d[l_ac].preb003,g_prec4_d[l_ac].preb004, 
                      g_prec4_d[l_ac].preb005,g_prec4_d[l_ac].preb006,g_prec4_d[l_ac].preb007,g_prec4_d[l_ac].preb008, 
                      g_prec4_d[l_ac].prebacti,g_prec4_d[l_ac].prebsite,g_prec4_d[l_ac].prebunit,g_prec4_d[l_ac].preb001 
 
                  IF SQLCA.SQLCODE THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = SQLERRMESSAGE  
                     LET g_errparam.code = SQLCA.SQLCODE 
                     LET g_errparam.popup = TRUE 
                     CALL cl_err()
                     LET l_lock_sw = "Y"
                  END IF
                  
                  #遮罩相關處理
                  LET g_prec4_d_mask_o[l_ac].* =  g_prec4_d[l_ac].*
                  CALL aprt310_preb_t_mask()
                  LET g_prec4_d_mask_n[l_ac].* =  g_prec4_d[l_ac].*
                  
                  LET g_bfill = "N"
                  CALL aprt310_show()
                  LET g_bfill = "Y"
                  
                  CALL cl_show_fld_cont()
               END IF
            ELSE
               LET l_cmd='a'
            END IF
            #add-point:modify段before row name="input.body4.before_row"
            
            #end add-point  
            #其他table資料備份(確定是否更改用)
            
 
            #其他table進行lock
            
 
            
         BEFORE DELETE                            #是否取消單身
            IF l_cmd = 'a' THEN
               LET l_cmd='d'
               #add-point:單身AFTER DELETE (=d) name="input.body4.after_delete_d"
               
               #end add-point
            ELSE
               #add-point:單身刪除前 name="input.body4.b_delete_ask"
               
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
               
               #add-point:單身4刪除前 name="input.body4.b_delete"
               
               #end add-point    
                  
               #取得該筆資料key值
               INITIALIZE gs_keys TO NULL
               LET gs_keys[01] = g_prea_m.preadocno
               LET gs_keys[gs_keys.getLength()+1] = g_prec4_d_t.preb002
            
               #刪除同層單身
               IF NOT aprt310_delete_b('preb_t',gs_keys,"'4'") THEN
                  CALL s_transaction_end('N','0')
                  CLOSE aprt310_bcl
                  CANCEL DELETE
               END IF
    
               #刪除下層單身
               IF NOT aprt310_key_delete_b(gs_keys,'preb_t') THEN
                  CALL s_transaction_end('N','0')
                  CLOSE aprt310_bcl
                  CANCEL DELETE
               END IF
               
               #刪除多語言
               
 
               
               #add-point:單身4刪除中 name="input.body4.m_delete"
               
               #end add-point    
               
               CALL s_transaction_end('Y','0')
               CLOSE aprt310_bcl
 
               LET g_rec_b = g_rec_b-1
               #add-point:單身4刪除後 name="input.body4.a_delete"
               
               #end add-point
               LET l_count = g_prec_d.getLength()
               
               #add-point:單身刪除後(<>d) name="input.body4.after_delete"
               
               #end add-point
            END IF 
 
         AFTER DELETE
            #如果是最後一筆
            IF l_ac = (g_prec4_d.getLength() + 1) THEN
               CALL FGL_SET_ARR_CURR(l_ac-1)
            END IF
 
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
               
            #add-point:單身4新增前 name="input.body4.b_a_insert"
            
            #end add-point
               
            LET l_count = 1  
            SELECT COUNT(1) INTO l_count FROM preb_t 
             WHERE prebent = g_enterprise AND prebdocno = g_prea_m.preadocno
               AND preb002 = g_prec4_d[l_ac].preb002
                
            #資料未重複, 插入新增資料
            IF l_count = 0 THEN 
               #add-point:單身4新增前 name="input.body4.b_insert"
               
               #end add-point
            
                              INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_prea_m.preadocno
               LET gs_keys[2] = g_prec4_d[g_detail_idx].preb002
               CALL aprt310_insert_b('preb_t',gs_keys,"'4'")
                           
               #add-point:單身新增後4 name="input.body4.a_insert"
               
               #end add-point
            ELSE    
               INITIALIZE g_prec_d[l_ac].* TO NULL
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = 'INSERT' 
               LET g_errparam.code = "std-00006" 
               LET g_errparam.popup = TRUE 
               CALL s_transaction_end('N','0')
               CALL cl_err()
               CANCEL INSERT
            END IF
 
            IF SQLCA.SQLCODE THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "preb_t:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE 
               LET g_errparam.popup = TRUE 
               CALL s_transaction_end('N','0')                    
               CALL cl_err()
               CANCEL INSERT
            ELSE
               #先刷新資料
               #CALL aprt310_b_fill()
               #資料多語言用-增/改
               
               #add-point:單身新增後 name="input.body4.after_insert"
               
               #end add-point
               CALL s_transaction_end('Y','0')
               #ERROR 'INSERT O.K'
               LET g_rec_b = g_rec_b + 1
            END IF
            
         ON ROW CHANGE 
            IF INT_FLAG THEN
               LET INT_FLAG = 0
               LET g_prec4_d[l_ac].* = g_prec4_d_t.*
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code = 9001 
               LET g_errparam.popup = FALSE 
               CLOSE aprt310_bcl3
               CALL s_transaction_end('N','0')
               CALL cl_err()
               EXIT DIALOG 
            END IF
            
            IF l_lock_sw = 'Y' THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code = -263 
               LET g_errparam.popup = TRUE 
               CALL cl_err()
               LET g_prec4_d[l_ac].* = g_prec4_d_t.*
            ELSE
               #add-point:單身page4修改前 name="input.body4.b_update"
               
               #end add-point
               
               #寫入修改者/修改日期資訊(單身4)
               
               
               #將遮罩欄位還原
               CALL aprt310_preb_t_mask_restore('restore_mask_o')
                              
               UPDATE preb_t SET (prebdocno,preb002,preb003,preb004,preb005,preb006,preb007,preb008, 
                   prebacti,prebsite,prebunit,preb001) = (g_prea_m.preadocno,g_prec4_d[l_ac].preb002, 
                   g_prec4_d[l_ac].preb003,g_prec4_d[l_ac].preb004,g_prec4_d[l_ac].preb005,g_prec4_d[l_ac].preb006, 
                   g_prec4_d[l_ac].preb007,g_prec4_d[l_ac].preb008,g_prec4_d[l_ac].prebacti,g_prec4_d[l_ac].prebsite, 
                   g_prec4_d[l_ac].prebunit,g_prec4_d[l_ac].preb001) #自訂欄位頁簽
                WHERE prebent = g_enterprise AND prebdocno = g_prea_m.preadocno
                  AND preb002 = g_prec4_d_t.preb002 #項次 
                  
               #add-point:單身page4修改中 name="input.body4.m_update"
               
               #end add-point
                  
               CASE
                  WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
                     LET g_prec4_d[l_ac].* = g_prec4_d_t.*
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "preb_t" 
                     LET g_errparam.code = "std-00009" 
                     LET g_errparam.popup = TRUE 
                     CALL s_transaction_end('N','0')
                     CALL cl_err()
                     
                  WHEN SQLCA.SQLCODE #其他錯誤
                     LET g_prec4_d[l_ac].* = g_prec4_d_t.*
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "preb_t:",SQLERRMESSAGE 
                     LET g_errparam.code = SQLCA.SQLCODE 
                     LET g_errparam.popup = TRUE 
                     CALL s_transaction_end('N','0')
                     CALL cl_err()
                     
                  OTHERWISE
                     #資料多語言用-增/改
                     
                                    INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_prea_m.preadocno
               LET gs_keys_bak[1] = g_preadocno_t
               LET gs_keys[2] = g_prec4_d[g_detail_idx].preb002
               LET gs_keys_bak[2] = g_prec4_d_t.preb002
               CALL aprt310_update_b('preb_t',gs_keys,gs_keys_bak,"'4'")
               END CASE
               
               #將遮罩欄位進行遮蔽
               CALL aprt310_preb_t_mask_restore('restore_mask_n')
               
               #判斷key是否有改變
               INITIALIZE gs_keys TO NULL
               IF NOT (g_prec4_d[g_detail_idx].preb002 = g_prec4_d_t.preb002 
                  ) THEN
                  LET gs_keys[01] = g_prea_m.preadocno
                  LET gs_keys[gs_keys.getLength()+1] = g_prec4_d_t.preb002
                  CALL aprt310_key_update_b(gs_keys,'preb_t')
               END IF
               
               #修改歷程記錄(單身修改)
               LET g_log1 = util.JSON.stringify(g_prea_m),util.JSON.stringify(g_prec4_d_t)
               LET g_log2 = util.JSON.stringify(g_prea_m),util.JSON.stringify(g_prec4_d[l_ac])
               IF NOT cl_log_modified_record_d(g_log1,g_log2) THEN 
                  CALL s_transaction_end('N','0')
               END IF
               
               #add-point:單身page4修改後 name="input.body4.a_update"
               
               #end add-point
            END IF
         
                  #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD preb002
            #add-point:BEFORE FIELD preb002 name="input.b.page4.preb002"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD preb002
            
            #add-point:AFTER FIELD preb002 name="input.a.page4.preb002"
            #應用 a05 樣板自動產生(Version:2)
            #確認資料無重複
            IF  g_prea_m.preadocno IS NOT NULL AND g_prec4_d[g_detail_idx].preb002 IS NOT NULL THEN 
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_prea_m.preadocno != g_preadocno_t OR g_prec4_d[g_detail_idx].preb002 != g_prec4_d_t.preb002)) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM preb_t WHERE "||"prebent = '" ||g_enterprise|| "' AND "||"prebdocno = '"||g_prea_m.preadocno ||"' AND "|| "preb002 = '"||g_prec4_d[g_detail_idx].preb002 ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF


            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE preb002
            #add-point:ON CHANGE preb002 name="input.g.page4.preb002"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD preb003
            #add-point:BEFORE FIELD preb003 name="input.b.page4.preb003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD preb003
            
            #add-point:AFTER FIELD preb003 name="input.a.page4.preb003"
            IF NOT cl_null(g_prec4_d[l_ac].preb003) THEN
               IF NOT cl_null(g_prec4_d[l_ac].preb004) THEN
                  IF g_prec4_d[l_ac].preb003>g_prec4_d[l_ac].preb004 THEN
                        INITIALIZE g_errparam TO NULL
                        LET g_errparam.extend = ''
                        LET g_errparam.code   = 'amm-00080'
                        LET g_errparam.popup  = TRUE
                        CALL cl_err()            
                        LET g_prec4_d[l_ac].preb003 = g_prec4_d_t.preb003
                        NEXT FIELD CURRENT                               
                  END IF
               END IF
               IF NOT cl_null(g_prea_m.prea003) THEN
                  SELECT prcf009,prcf010 INTO l_prcf009,l_prcf010
                    FROM prcf_t
                   WHERE prcfent=g_enterprise
                     AND prcf001=g_prea_m.prea003
                  IF g_prec4_d[l_ac].preb003<l_prcf009 THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = 'apr-00426'
                     LET g_errparam.extend = g_prec4_d[l_ac].preb003
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                  
                     LET g_prec4_d[l_ac].preb003 = g_prec4_d_t.preb003
                     NEXT FIELD CURRENT                               
                  END IF
               END IF   
               
            END IF
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE preb003
            #add-point:ON CHANGE preb003 name="input.g.page4.preb003"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD preb004
            #add-point:BEFORE FIELD preb004 name="input.b.page4.preb004"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD preb004
            
            #add-point:AFTER FIELD preb004 name="input.a.page4.preb004"
            IF NOT cl_null(g_prec4_d[l_ac].preb004) THEN
               IF NOT cl_null(g_prec4_d[l_ac].preb003) THEN
                  IF g_prec4_d[l_ac].preb004<g_prec4_d[l_ac].preb003 THEN
                        INITIALIZE g_errparam TO NULL
                        LET g_errparam.extend = ''
                        LET g_errparam.code   = 'amm-00081'
                        LET g_errparam.popup  = TRUE
                        CALL cl_err()            
                        LET g_prec4_d[l_ac].preb004 = g_prec4_d_t.preb004
                        NEXT FIELD CURRENT                               
                  END IF
               END IF
               IF NOT cl_null(g_prea_m.prea003) THEN
                  SELECT prcf009,prcf010 INTO l_prcf009,l_prcf010
                    FROM prcf_t
                   WHERE prcfent=g_enterprise
                     AND prcf001=g_prea_m.prea003
                  IF g_prec4_d[l_ac].preb004>l_prcf010 THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = 'apr-00426'
                     LET g_errparam.extend = g_prec4_d[l_ac].preb004
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                  
                     LET g_prec4_d[l_ac].preb004 = g_prec4_d_t.preb004
                     NEXT FIELD CURRENT                                   
                  END IF
               END IF  
               
            END IF
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE preb004
            #add-point:ON CHANGE preb004 name="input.g.page4.preb004"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD preb005
            #add-point:BEFORE FIELD preb005 name="input.b.page4.preb005"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD preb005
            
            #add-point:AFTER FIELD preb005 name="input.a.page4.preb005"
            IF NOT cl_null(g_prec4_d[l_ac].preb005) THEN  
               IF NOT cl_null(g_prec4_d[l_ac].preb006) THEN              
                  IF NOT cl_null(g_prec4_d[l_ac].preb004) AND NOT cl_null(g_prec4_d[l_ac].preb003) AND g_prec4_d[l_ac].preb003=g_prec4_d[l_ac].preb004 THEN
                     IF g_prec4_d[l_ac].preb005>g_prec4_d[l_ac].preb006 THEN
                        INITIALIZE g_errparam TO NULL
                        LET g_errparam.extend = ''
                        LET g_errparam.code   = 'amm-00067'
                        LET g_errparam.popup  = TRUE
                        CALL cl_err()            
                        LET g_prec4_d[l_ac].preb005 = g_prec4_d_t.preb005
                        NEXT FIELD CURRENT   
                     END IF
                  END IF
               END IF
            END IF
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE preb005
            #add-point:ON CHANGE preb005 name="input.g.page4.preb005"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD preb006
            #add-point:BEFORE FIELD preb006 name="input.b.page4.preb006"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD preb006
            
            #add-point:AFTER FIELD preb006 name="input.a.page4.preb006"
            IF NOT cl_null(g_prec4_d[l_ac].preb006) THEN  
               IF NOT cl_null(g_prec4_d[l_ac].preb005) THEN              
                  IF NOT cl_null(g_prec4_d[l_ac].preb004) AND NOT cl_null(g_prec4_d[l_ac].preb003) AND g_prec4_d[l_ac].preb003=g_prec4_d[l_ac].preb004 THEN
                     IF g_prec4_d[l_ac].preb006<g_prec4_d[l_ac].preb005 THEN
                        INITIALIZE g_errparam TO NULL
                        LET g_errparam.extend = ''
                        LET g_errparam.code   = 'amm-00093'
                        LET g_errparam.popup  = TRUE
                        CALL cl_err()            
                        LET g_prec4_d[l_ac].preb006 = g_prec4_d_t.preb006
                        NEXT FIELD CURRENT   
                     END IF
                  END IF
               END IF
            END IF
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE preb006
            #add-point:ON CHANGE preb006 name="input.g.page4.preb006"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD preb007
            #add-point:BEFORE FIELD preb007 name="input.b.page4.preb007"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD preb007
            
            #add-point:AFTER FIELD preb007 name="input.a.page4.preb007"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE preb007
            #add-point:ON CHANGE preb007 name="input.g.page4.preb007"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD preb008
            #add-point:BEFORE FIELD preb008 name="input.b.page4.preb008"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD preb008
            
            #add-point:AFTER FIELD preb008 name="input.a.page4.preb008"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE preb008
            #add-point:ON CHANGE preb008 name="input.g.page4.preb008"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prebacti
            #add-point:BEFORE FIELD prebacti name="input.b.page4.prebacti"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prebacti
            
            #add-point:AFTER FIELD prebacti name="input.a.page4.prebacti"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE prebacti
            #add-point:ON CHANGE prebacti name="input.g.page4.prebacti"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prebsite
            #add-point:BEFORE FIELD prebsite name="input.b.page4.prebsite"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prebsite
            
            #add-point:AFTER FIELD prebsite name="input.a.page4.prebsite"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE prebsite
            #add-point:ON CHANGE prebsite name="input.g.page4.prebsite"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prebunit
            #add-point:BEFORE FIELD prebunit name="input.b.page4.prebunit"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prebunit
            
            #add-point:AFTER FIELD prebunit name="input.a.page4.prebunit"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE prebunit
            #add-point:ON CHANGE prebunit name="input.g.page4.prebunit"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD preb001
            #add-point:BEFORE FIELD preb001 name="input.b.page4.preb001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD preb001
            
            #add-point:AFTER FIELD preb001 name="input.a.page4.preb001"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE preb001
            #add-point:ON CHANGE preb001 name="input.g.page4.preb001"
            
            #END add-point 
 
 
 
                  #Ctrlp:input.c.page4.preb002
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD preb002
            #add-point:ON ACTION controlp INFIELD preb002 name="input.c.page4.preb002"
            
            #END add-point
 
 
         #Ctrlp:input.c.page4.preb003
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD preb003
            #add-point:ON ACTION controlp INFIELD preb003 name="input.c.page4.preb003"
            
            #END add-point
 
 
         #Ctrlp:input.c.page4.preb004
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD preb004
            #add-point:ON ACTION controlp INFIELD preb004 name="input.c.page4.preb004"
            
            #END add-point
 
 
         #Ctrlp:input.c.page4.preb005
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD preb005
            #add-point:ON ACTION controlp INFIELD preb005 name="input.c.page4.preb005"
            
            #END add-point
 
 
         #Ctrlp:input.c.page4.preb006
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD preb006
            #add-point:ON ACTION controlp INFIELD preb006 name="input.c.page4.preb006"
            
            #END add-point
 
 
         #Ctrlp:input.c.page4.preb007
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD preb007
            #add-point:ON ACTION controlp INFIELD preb007 name="input.c.page4.preb007"
            
            #END add-point
 
 
         #Ctrlp:input.c.page4.preb008
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD preb008
            #add-point:ON ACTION controlp INFIELD preb008 name="input.c.page4.preb008"
            
            #END add-point
 
 
         #Ctrlp:input.c.page4.prebacti
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prebacti
            #add-point:ON ACTION controlp INFIELD prebacti name="input.c.page4.prebacti"
            
            #END add-point
 
 
         #Ctrlp:input.c.page4.prebsite
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prebsite
            #add-point:ON ACTION controlp INFIELD prebsite name="input.c.page4.prebsite"
            
            #END add-point
 
 
         #Ctrlp:input.c.page4.prebunit
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prebunit
            #add-point:ON ACTION controlp INFIELD prebunit name="input.c.page4.prebunit"
            
            #END add-point
 
 
         #Ctrlp:input.c.page4.preb001
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD preb001
            #add-point:ON ACTION controlp INFIELD preb001 name="input.c.page4.preb001"
            
            #END add-point
 
 
 
 
         AFTER ROW
            #add-point:單身page4 after_row name="input.body4.after_row"
            
            #end add-point
            LET l_ac = ARR_CURR()
            IF INT_FLAG THEN
               LET INT_FLAG = 0
               IF l_cmd = 'u' THEN
                  LET g_prec4_d[l_ac].* = g_prec4_d_t.*
               END IF
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code = 9001 
               LET g_errparam.popup = FALSE 
               CLOSE aprt310_bcl3
               CALL s_transaction_end('N','0')
               CALL cl_err()
               EXIT DIALOG 
            END IF
            
            #其他table進行unlock
            
            CALL aprt310_unlock_b("preb_t","'4'")
            CALL s_transaction_end('Y','0')
            #add-point:單身page4 after_row2 name="input.body4.after_row2"
            
            #end add-point
 
         AFTER INPUT
            #add-point:input段after input  name="input.body4.after_input"
            
            #end add-point   
    
         ON ACTION controlo
            IF l_insert THEN
               LET li_reproduce = l_ac_t
               LET li_reproduce_target = l_ac
               LET g_prec4_d[li_reproduce_target].* = g_prec4_d[li_reproduce].*
 
               LET g_prec4_d[li_reproduce_target].preb002 = NULL
            ELSE
               CALL FGL_SET_ARR_CURR(g_prec4_d.getLength()+1)
               LET lb_reproduce = TRUE
               LET li_reproduce = l_ac
               LET li_reproduce_target = g_prec4_d.getLength()+1
            END IF
            
      END INPUT
 
      
 
 
 
 
{</section>}
 
{<section id="aprt310.input.other" >}
      
      #add-point:自定義input name="input.more_input"
      
      #end add-point
    
      BEFORE DIALOG 
         #CALL cl_err_collect_init()    
         #add-point:input段before dialog name="input.before_dialog"
         
         #end add-point    
         #重新導回資料到正確位置上
         CALL DIALOG.setCurrentRow("s_detail1",g_idx_group.getValue("'1','2',"))      
         CALL DIALOG.setCurrentRow("s_detail2",g_idx_group.getValue("'3',"))
         CALL DIALOG.setCurrentRow("s_detail3",g_idx_group.getValue("'4',"))
         CALL DIALOG.setCurrentRow("s_detail4",g_idx_group.getValue(""))
 
         #新增時強制從單頭開始填
         IF p_cmd = 'a' THEN
            #add-point:input段next_field name="input.next_field"
            NEXT FIELD preasite   #161101-00022#1--add
            #end add-point  
            NEXT FIELD preadocno
         ELSE
            CASE g_aw
               WHEN "s_detail1"
                  NEXT FIELD precacti
               WHEN "s_detail2"
                  NEXT FIELD precseq_2
               WHEN "s_detail3"
                  NEXT FIELD predacti
               WHEN "s_detail4"
                  NEXT FIELD preb002
 
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
         LET g_detail_idx_list[2] = 1
         LET g_detail_idx_list[3] = 1
         LET g_detail_idx_list[4] = 1
 
         CALL g_curr_diag.setCurrentRow("s_detail1",1)    
         CALL g_curr_diag.setCurrentRow("s_detail2",1)
         CALL g_curr_diag.setCurrentRow("s_detail3",1)
         CALL g_curr_diag.setCurrentRow("s_detail4",1)
 
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
         LET g_detail_idx_list[2] = 1
         LET g_detail_idx_list[3] = 1
         LET g_detail_idx_list[4] = 1
 
         CALL g_curr_diag.setCurrentRow("s_detail1",1)    
         CALL g_curr_diag.setCurrentRow("s_detail2",1)
         CALL g_curr_diag.setCurrentRow("s_detail3",1)
         CALL g_curr_diag.setCurrentRow("s_detail4",1)
 
         EXIT DIALOG
 
      #交談指令共用ACTION
      &include "common_action.4gl" 
         CONTINUE DIALOG 
   END DIALOG
    
   #add-point:input段after input  name="input.after_input"
   
   #end add-point    
 
END FUNCTION
 
{</section>}
 
{<section id="aprt310.show" >}
#+ 單頭資料重新顯示及單身資料重抓
PRIVATE FUNCTION aprt310_show()
   #add-point:show段define(客製用) name="show.define_customerization"
   
   #end add-point  
   DEFINE l_ac_t    LIKE type_t.num10
   #add-point:show段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="show.define"
   
   #end add-point  
   
   #add-point:Function前置處理 name="show.before"
   
   #end add-point
   
   
   
   IF g_bfill = "Y" THEN
      CALL aprt310_b_fill() #單身填充
      CALL aprt310_b_fill2('0') #單身填充
   END IF
     
   #帶出公用欄位reference值
   #應用 a12 樣板自動產生(Version:4)
 
 
 
   
   #顯示followup圖示
   #應用 a48 樣板自動產生(Version:3)
   CALL aprt310_set_pk_array()
   #add-point:ON ACTION agendum name="show.follow_pic"
   
   #END add-point
   CALL cl_user_overview_set_follow_pic()
  
 
 
 
   
   LET l_ac_t = l_ac
   
   #讀入ref值(單頭)
   #add-point:show段reference name="show.head.reference"

   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_prea_m.preadocno
   CALL ap_ref_array2(g_ref_fields," SELECT preal002 FROM preal_t WHERE prealent = '"||g_enterprise||"' AND prealdocno = ? AND preal001 = '"||g_dlang||"'","") RETURNING g_rtn_fields 
   LET g_prea_m.preal002 = g_rtn_fields[1] 
   DISPLAY g_prea_m.preal002 TO preal002
   
   #日期
   IF g_prea_m.prea013 = 'N' THEN
      SELECT preb003,preb004,preb005,preb006,preb007,preb008 
        INTO g_prea_m.preb003_1,g_prea_m.preb004_1,g_prea_m.preb005_1,g_prea_m.preb006_1,g_prea_m.preb007_1,g_prea_m.preb008_1
        FROM preb_t
       WHERE prebent = g_enterprise
         AND prebdocno = g_prea_m.preadocno
         AND preb002 = 1
   END IF 
 
   IF g_prea_m.prea005='1' THEN
      INITIALIZE g_ref_fields TO NULL
      LET g_ref_fields[1] = g_prea_m.prea006
      CALL ap_ref_array2(g_ref_fields,"SELECT mmanl003 FROM mmanl_t WHERE mmanlent='"||g_enterprise||"' AND mmanl001=? AND mmanl002='"||g_dlang||"'","") RETURNING g_rtn_fields
      LET g_prea_m.prea006_desc = '', g_rtn_fields[1] , ''
      DISPLAY BY NAME g_prea_m.prea006_desc                  
   END IF
   IF g_prea_m.prea005='2' THEN    
      INITIALIZE g_ref_fields TO NULL
      LET g_ref_fields[1] = g_prea_m.prea006
      CALL ap_ref_array2(g_ref_fields,"SELECT gcafl003 FROM gcafl_t WHERE gcaflent='"||g_enterprise||"' AND gcafl001=? AND gcafl002='"||g_dlang||"'","") RETURNING g_rtn_fields
      LET g_prea_m.prea006_desc = '', g_rtn_fields[1] , ''
      DISPLAY BY NAME g_prea_m.prea006_desc                      
   END IF

   #end add-point
   
   #遮罩相關處理
   LET g_prea_m_mask_o.* =  g_prea_m.*
   CALL aprt310_prea_t_mask()
   LET g_prea_m_mask_n.* =  g_prea_m.*
   
   #將資料輸出到畫面上
   DISPLAY BY NAME g_prea_m.preasite,g_prea_m.preasite_desc,g_prea_m.preadocdt,g_prea_m.preadocno,g_prea_m.prea000, 
       g_prea_m.preaunit,g_prea_m.prea001,g_prea_m.prea002,g_prea_m.preal002,g_prea_m.preaacti,g_prea_m.preastus, 
       g_prea_m.prea003,g_prea_m.prea003_desc,g_prea_m.prea004,g_prea_m.prea052,g_prea_m.prea005,g_prea_m.prea006, 
       g_prea_m.prea006_desc,g_prea_m.preb003_1,g_prea_m.preb004_1,g_prea_m.prea051,g_prea_m.prea008, 
       g_prea_m.prea008_desc,g_prea_m.prea007,g_prea_m.prea007_desc,g_prea_m.prea009,g_prea_m.prea009_desc, 
       g_prea_m.prea010,g_prea_m.prea010_desc,g_prea_m.preb005_1,g_prea_m.preb006_1,g_prea_m.prea013, 
       g_prea_m.prea050,g_prea_m.prea011,g_prea_m.prea011_desc,g_prea_m.prea012,g_prea_m.prea012_desc, 
       g_prea_m.prea014,g_prea_m.prea015,g_prea_m.preb007_1,g_prea_m.preb008_1,g_prea_m.preaownid,g_prea_m.preaownid_desc, 
       g_prea_m.preaowndp,g_prea_m.preaowndp_desc,g_prea_m.preacrtid,g_prea_m.preacrtid_desc,g_prea_m.preacrtdp, 
       g_prea_m.preacrtdp_desc,g_prea_m.preacrtdt,g_prea_m.preamodid,g_prea_m.preamodid_desc,g_prea_m.preamoddt, 
       g_prea_m.preacnfid,g_prea_m.preacnfid_desc,g_prea_m.preacnfdt,g_prea_m.preapstid,g_prea_m.preapstid_desc, 
       g_prea_m.preapstdt
   
   #顯示狀態(stus)圖片
         #應用 a21 樣板自動產生(Version:3)
	  #根據當下狀態碼顯示圖片
      CASE g_prea_m.preastus 
         WHEN "N"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/unconfirmed.png")
         WHEN "Y"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/confirmed.png")
         WHEN "A"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/approved.png")
         WHEN "D"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/withdraw.png")
         WHEN "R"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/rejection.png")
         WHEN "W"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/signing.png")
         WHEN "X"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/invalid.png")
         
      END CASE
 
 
 
   
   #讀入ref值(單身)
   FOR l_ac = 1 TO g_prec_d.getLength()
      #add-point:show段單身reference name="show.body.reference"
      #150907-00033#2 20150930 mark by beckxie---S
      #SELECT mhael023 INTO g_prec_d[l_ac].prec004_desc
      #  FROM mhael_t
      # WHERE mhaelent=g_enterprise
      #   AND mhaelsite=g_prea_m.preasite
      #   AND mhael022=g_dlang
      #   AND mhael001=g_prec_d[l_ac].prec004
      #INITIALIZE g_ref_fields TO NULL
      #LET g_ref_fields[1] = g_prec_d[l_ac].prec006
      #CALL ap_ref_array2(g_ref_fields,"SELECT rtaxl003 FROM rtaxl_t WHERE rtaxlent='"||g_enterprise||"' AND rtaxl001=? AND rtaxl002='"||g_dlang||"'","") RETURNING g_rtn_fields
      #LET g_prec_d[l_ac].prec006_desc = '', g_rtn_fields[1] , ''
      #DISPLAY BY NAME g_prec_d[l_ac].prec006_desc
      #
      #
      #INITIALIZE g_ref_fields TO NULL
      #LET g_ref_fields[1] = g_prec_d[l_ac].prec005
      #CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
      #LET g_prec_d[l_ac].prec005_desc = '', g_rtn_fields[1] , ''
      #DISPLAY BY NAME g_prec_d[l_ac].prec005_desc
      # 
      #INITIALIZE g_ref_fields TO NULL
      #LET g_ref_fields[1] = g_prec_d[l_ac].prec003
      #CALL ap_ref_array2(g_ref_fields,"SELECT inayl003 FROM inayl_t WHERE inaylent='"||g_enterprise||"' AND inayl001=? AND inayl002='"||g_dlang||"'","") RETURNING g_rtn_fields
      #LET g_prec_d[l_ac].prec003_desc = '', g_rtn_fields[1] , ''
      #DISPLAY BY NAME g_prec_d[l_ac].prec003_desc      
      #INITIALIZE g_ref_fields TO NULL
      #LET g_ref_fields[1] = g_prec_d[l_ac].prec005
      #CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
      #LET g_prec_d[l_ac].prec005_desc = '', g_rtn_fields[1] , ''
      #DISPLAY BY NAME g_prec_d[l_ac].prec005_desc
      #150907-00033#2 20150930 mark by beckxie---E
      #end add-point
   END FOR
   
   FOR l_ac = 1 TO g_prec2_d.getLength()
      #add-point:show段單身reference name="show.body2.reference"
      
      #end add-point
   END FOR
   FOR l_ac = 1 TO g_prec3_d.getLength()
      #add-point:show段單身reference name="show.body3.reference"
      #150907-00033#2 20150930 mark by beckxie---S
      #SELECT mhael023 INTO g_prec3_d[l_ac].pred003_desc
      #  FROM mhael_t
      # WHERE mhaelent=g_enterprise
      #   AND mhaelsite=g_prea_m.preasite
      #   AND mhael022=g_dlang
      #   AND mhael001=g_prec3_d[l_ac].pred003
      #DISPLAY BY NAME g_prec3_d[l_ac].pred003_desc 
      #
      #INITIALIZE g_ref_fields TO NULL
      #LET g_ref_fields[1] = g_prec3_d[l_ac].pred002
      #CALL ap_ref_array2(g_ref_fields,"SELECT inayl003 FROM inayl_t WHERE inaylent='"||g_enterprise||"' AND inayl001=? AND inayl002='"||g_dlang||"'","") RETURNING g_rtn_fields
      #LET g_prec3_d[l_ac].pred002_desc = '', g_rtn_fields[1] , ''
      #DISPLAY BY NAME g_prec3_d[l_ac].pred002_desc     
      #150907-00033#2 20150930 mark by beckxie---E
      #end add-point
   END FOR
   FOR l_ac = 1 TO g_prec4_d.getLength()
      #add-point:show段單身reference name="show.body4.reference"
      
      #end add-point
   END FOR
 
   
    
   
   #add-point:show段other name="show.other"
   
   #end add-point  
   
   LET l_ac = l_ac_t
   
   #移動上下筆可以連動切換資料
   CALL cl_show_fld_cont()     
 
   CALL aprt310_detail_show()
 
   #add-point:show段之後 name="show.after"
   
   #end add-point
   
END FUNCTION
 
{</section>}
 
{<section id="aprt310.detail_show" >}
#+ 第二階單身reference
PRIVATE FUNCTION aprt310_detail_show()
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
 
{<section id="aprt310.reproduce" >}
#+ 資料複製
PRIVATE FUNCTION aprt310_reproduce()
   #add-point:reproduce段define(客製用) name="reproduce.define_customerization"
   
   #end add-point   
   DEFINE l_newno     LIKE prea_t.preadocno 
   DEFINE l_oldno     LIKE prea_t.preadocno 
 
   DEFINE l_master    RECORD LIKE prea_t.* #此變數樣板目前無使用
   DEFINE l_detail    RECORD LIKE prec_t.* #此變數樣板目前無使用
   DEFINE l_detail2    RECORD LIKE pred_t.* #此變數樣板目前無使用
 
   DEFINE l_detail3    RECORD LIKE preb_t.* #此變數樣板目前無使用
 
 
 
   DEFINE l_cnt       LIKE type_t.num10
   #add-point:reproduce段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="reproduce.define"
   DEFINE r_success     LIKE type_t.num5
   DEFINE r_doctype     LIKE rtai_t.rtai004 
   DEFINE l_insert      LIKE type_t.num5 
   #end add-point   
   
   #add-point:Function前置處理  name="reproduce.pre_function"
   
   #end add-point
   
   #切換畫面
   
   LET g_master_insert = FALSE
   
   IF g_prea_m.preadocno IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code = "std-00003" 
      LET g_errparam.popup = FALSE 
      CALL cl_err()
      RETURN
   END IF
    
   LET g_preadocno_t = g_prea_m.preadocno
 
    
   LET g_prea_m.preadocno = ""
 
 
   CALL cl_set_head_visible("","YES")
 
   #公用欄位給予預設值
   #應用 a14 樣板自動產生(Version:5)    
      #公用欄位新增給值  
      LET g_prea_m.preaownid = g_user
      LET g_prea_m.preaowndp = g_dept
      LET g_prea_m.preacrtid = g_user
      LET g_prea_m.preacrtdp = g_dept 
      LET g_prea_m.preacrtdt = cl_get_current()
      LET g_prea_m.preamodid = g_user
      LET g_prea_m.preamoddt = cl_get_current()
      LET g_prea_m.preastus = 'N'
 
 
 
   
   CALL s_transaction_begin()
   
   #add-point:複製輸入前 name="reproduce.head.b_input"
   CALL s_aooi500_default(g_prog,'preasite',g_prea_m.preasite)
      RETURNING l_insert,g_prea_m.preasite
   IF l_insert = FALSE THEN
      RETURN
   END IF 
   #預設單據的單別
   LET r_success = ''
   LET r_doctype = ''
   CALL s_arti200_get_def_doc_type(g_prea_m.preasite,g_prog,'1')
       RETURNING r_success,r_doctype
   LET g_prea_m.preadocno = r_doctype 
   #end add-point
   
   #顯示狀態(stus)圖片
         #應用 a21 樣板自動產生(Version:3)
	  #根據當下狀態碼顯示圖片
      CASE g_prea_m.preastus 
         WHEN "N"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/unconfirmed.png")
         WHEN "Y"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/confirmed.png")
         WHEN "A"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/approved.png")
         WHEN "D"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/withdraw.png")
         WHEN "R"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/rejection.png")
         WHEN "W"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/signing.png")
         WHEN "X"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/invalid.png")
         
      END CASE
 
 
 
   
   #清空key欄位的desc
   
   
   CALL aprt310_input("r")
   
   IF INT_FLAG AND NOT g_master_insert THEN
      LET INT_FLAG = 0
      DISPLAY g_detail_cnt  TO FORMONLY.h_count    #總筆數
      DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
      LET INT_FLAG = 0
      INITIALIZE g_prea_m.* TO NULL
      INITIALIZE g_prec_d TO NULL
      INITIALIZE g_prec2_d TO NULL
      INITIALIZE g_prec3_d TO NULL
      INITIALIZE g_prec4_d TO NULL
 
      #add-point:複製取消後 name="reproduce.cancel"
      
      #end add-point
      CALL aprt310_show()
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
   CALL aprt310_set_act_visible()   
   CALL aprt310_set_act_no_visible()
   
   #將新增的資料併入搜尋條件中
   LET g_preadocno_t = g_prea_m.preadocno
 
   
   #組合新增資料的條件
   LET g_add_browse = " preaent = " ||g_enterprise|| " AND",
                      " preadocno = '", g_prea_m.preadocno, "' "
 
   #填到最後面
   LET g_current_idx = g_browser.getLength() + 1
   CALL aprt310_browser_fill("")
   
   DISPLAY g_browser_cnt TO FORMONLY.h_count    #總筆數
   DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
   CALL cl_navigator_setting(g_current_idx, g_browser_cnt)
   
   #add-point:完成複製段落後 name="reproduce.after_reproduce"
   
   #end add-point
   
   CALL aprt310_idx_chk()
   
   LET g_data_owner = g_prea_m.preaownid      
   LET g_data_dept  = g_prea_m.preaowndp
   
   #功能已完成,通報訊息中心
   CALL aprt310_msgcentre_notify('reproduce')
 
END FUNCTION
 
{</section>}
 
{<section id="aprt310.detail_reproduce" >}
#+ 單身自動複製
PRIVATE FUNCTION aprt310_detail_reproduce()
   #add-point:delete段define(客製用) name="detail_reproduce.define_customerization"
   
   #end add-point    
   DEFINE ls_sql      STRING
   DEFINE ld_date     DATETIME YEAR TO SECOND
   DEFINE l_detail    RECORD LIKE prec_t.* #此變數樣板目前無使用
   DEFINE l_detail2    RECORD LIKE pred_t.* #此變數樣板目前無使用
 
   DEFINE l_detail3    RECORD LIKE preb_t.* #此變數樣板目前無使用
 
 
 
   #add-point:delete段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="detail_reproduce.define"
   
   #end add-point    
   
   #add-point:Function前置處理  name="detail_reproduce.pre_function"
   
   #end add-point
   
   CALL s_transaction_begin()
   
   LET ld_date = cl_get_current()
   
   DROP TABLE aprt310_detail
   
   #add-point:單身複製前1 name="detail_reproduce.body.table1.b_insert"
   
   #end add-point
   
   #CREATE TEMP TABLE
   SELECT * FROM prec_t
    WHERE precent = g_enterprise AND precdocno = g_preadocno_t
 
    INTO TEMP aprt310_detail
 
   #將key修正為調整後   
   UPDATE aprt310_detail 
      #更新key欄位
      SET precdocno = g_prea_m.preadocno
 
      #更新共用欄位
      
 
   #add-point:單身修改前 name="detail_reproduce.body.table1.b_update"
   
   #end add-point                                       
  
   #將資料塞回原table   
   INSERT INTO prec_t SELECT * FROM aprt310_detail
   
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
   DROP TABLE aprt310_detail
   
   #add-point:單身複製後1 name="detail_reproduce.body.table1.a_insert"
   
   #end add-point
 
   #add-point:單身複製前 name="detail_reproduce.body.table2.b_insert"
   
   #end add-point
   
   #CREATE TEMP TABLE
   SELECT * FROM pred_t 
    WHERE predent = g_enterprise AND preddocno = g_preadocno_t
 
    INTO TEMP aprt310_detail
 
   #將key修正為調整後   
   UPDATE aprt310_detail SET preddocno = g_prea_m.preadocno
 
  
   #add-point:單身修改前 name="detail_reproduce.body.table2.b_update"
   
   #end add-point    
 
   #將資料塞回原table   
   INSERT INTO pred_t SELECT * FROM aprt310_detail
   
   #add-point:單身複製中 name="detail_reproduce.body.table2.m_insert"
   
   #end add-point
   
   #刪除TEMP TABLE
   DROP TABLE aprt310_detail
   
   #add-point:單身複製後 name="detail_reproduce.body.table2.a_insert"
   
   #end add-point
 
   #add-point:單身複製前 name="detail_reproduce.body.table3.b_insert"
   
   #end add-point
   
   #CREATE TEMP TABLE
   SELECT * FROM preb_t 
    WHERE prebent = g_enterprise AND prebdocno = g_preadocno_t
 
    INTO TEMP aprt310_detail
 
   #將key修正為調整後   
   UPDATE aprt310_detail SET prebdocno = g_prea_m.preadocno
 
  
   #add-point:單身修改前 name="detail_reproduce.body.table3.b_update"
   
   #end add-point    
 
   #將資料塞回原table   
   INSERT INTO preb_t SELECT * FROM aprt310_detail
   
   #add-point:單身複製中 name="detail_reproduce.body.table3.m_insert"
   
   #end add-point
   
   #刪除TEMP TABLE
   DROP TABLE aprt310_detail
   
   #add-point:單身複製後 name="detail_reproduce.body.table3.a_insert"
   
   #end add-point
 
 
   
 
   
   #多語言複製段落
   
   
   CALL s_transaction_end('Y','0')
   
   #已新增完, 調整資料內容(修改時使用)
   LET g_preadocno_t = g_prea_m.preadocno
 
   
END FUNCTION
 
{</section>}
 
{<section id="aprt310.delete" >}
#+ 資料刪除
PRIVATE FUNCTION aprt310_delete()
   #add-point:delete段define(客製用) name="delete.define_customerization"
   
   #end add-point     
   DEFINE  l_var_keys      DYNAMIC ARRAY OF STRING
   DEFINE  l_field_keys    DYNAMIC ARRAY OF STRING
   DEFINE  l_vars          DYNAMIC ARRAY OF STRING
   DEFINE  l_fields        DYNAMIC ARRAY OF STRING
   DEFINE  l_var_keys_bak  DYNAMIC ARRAY OF STRING
   #add-point:delete段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="delete.define"
   
   #end add-point     
   
   #add-point:Function前置處理  name="delete.pre_function"
   
   #end add-point
   
   IF g_prea_m.preadocno IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code = "std-00003" 
      LET g_errparam.popup = FALSE 
      CALL cl_err()
      RETURN
   END IF
   
   LET g_master_multi_table_t.prealdocno = g_prea_m.preadocno
LET g_master_multi_table_t.preal002 = g_prea_m.preal002
 
   
   CALL s_transaction_begin()
 
   OPEN aprt310_cl USING g_enterprise,g_prea_m.preadocno
   IF SQLCA.SQLCODE THEN   #(ver:78)
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "OPEN aprt310_cl:",SQLERRMESSAGE 
      LET g_errparam.code = SQLCA.SQLCODE   #(ver:78)
      LET g_errparam.popup = TRUE 
      CLOSE aprt310_cl
      CALL s_transaction_end('N','0')
      CALL cl_err()
      RETURN
   END IF
 
   #顯示最新的資料
   EXECUTE aprt310_master_referesh USING g_prea_m.preadocno INTO g_prea_m.preasite,g_prea_m.preadocdt, 
       g_prea_m.preadocno,g_prea_m.prea000,g_prea_m.preaunit,g_prea_m.prea001,g_prea_m.prea002,g_prea_m.preaacti, 
       g_prea_m.preastus,g_prea_m.prea003,g_prea_m.prea004,g_prea_m.prea052,g_prea_m.prea005,g_prea_m.prea006, 
       g_prea_m.prea051,g_prea_m.prea008,g_prea_m.prea007,g_prea_m.prea009,g_prea_m.prea010,g_prea_m.prea013, 
       g_prea_m.prea050,g_prea_m.prea011,g_prea_m.prea012,g_prea_m.prea014,g_prea_m.prea015,g_prea_m.preaownid, 
       g_prea_m.preaowndp,g_prea_m.preacrtid,g_prea_m.preacrtdp,g_prea_m.preacrtdt,g_prea_m.preamodid, 
       g_prea_m.preamoddt,g_prea_m.preacnfid,g_prea_m.preacnfdt,g_prea_m.preapstid,g_prea_m.preapstdt, 
       g_prea_m.prea003_desc,g_prea_m.prea006_desc,g_prea_m.prea008_desc,g_prea_m.prea007_desc,g_prea_m.prea009_desc, 
       g_prea_m.prea010_desc,g_prea_m.prea011_desc,g_prea_m.prea012_desc,g_prea_m.preaownid_desc,g_prea_m.preaowndp_desc, 
       g_prea_m.preacrtid_desc,g_prea_m.preacrtdp_desc,g_prea_m.preamodid_desc,g_prea_m.preacnfid_desc, 
       g_prea_m.preapstid_desc
   
   
   #檢查是否允許此動作
   IF NOT aprt310_action_chk() THEN
      CALL s_transaction_end('N','0')
      RETURN
   END IF
   
   #遮罩相關處理
   LET g_prea_m_mask_o.* =  g_prea_m.*
   CALL aprt310_prea_t_mask()
   LET g_prea_m_mask_n.* =  g_prea_m.*
   
   CALL aprt310_show()
   
   #add-point:delete段before ask name="delete.before_ask"
   
   #end add-point 
 
   IF cl_ask_del_master() THEN              #確認一下
   
      #add-point:單頭刪除前 name="delete.head.b_delete"
      
      #end add-point   
      
      #應用 a47 樣板自動產生(Version:4)
      #刪除相關文件
      CALL aprt310_set_pk_array()
      #add-point:相關文件刪除前 name="delete.befroe.related_document_remove"
      
      #end add-point   
      CALL cl_doc_remove()  
 
 
 
  
  
      #資料備份
      LET g_preadocno_t = g_prea_m.preadocno
 
 
      DELETE FROM prea_t
       WHERE preaent = g_enterprise AND preadocno = g_prea_m.preadocno
 
       
      #add-point:單頭刪除中 name="delete.head.m_delete"
      
      #end add-point
       
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = g_prea_m.preadocno,":",SQLERRMESSAGE  
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = FALSE 
         CALL s_transaction_end('N','0')
         CALL cl_err()
         RETURN
      END IF
      
      #add-point:單頭刪除後 name="delete.head.a_delete"
      
      #end add-point
  
      #add-point:單身刪除前 name="delete.body.b_delete"
      
      #end add-point
      
      DELETE FROM prec_t
       WHERE precent = g_enterprise AND precdocno = g_prea_m.preadocno
 
 
      #add-point:單身刪除中 name="delete.body.m_delete"
      
      #end add-point
         
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "prec_t:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = FALSE 
         CALL s_transaction_end('N','0')
         CALL cl_err()
         RETURN
      END IF    
 
      #add-point:單身刪除後 name="delete.body.a_delete"
      
      #end add-point
      
            
                                                               
      #add-point:單身刪除前 name="delete.body.b_delete2"
      
      #end add-point
      DELETE FROM pred_t
       WHERE predent = g_enterprise AND
             preddocno = g_prea_m.preadocno
      #add-point:單身刪除中 name="delete.body.m_delete2"
      
      #end add-point
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "prec_t:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = FALSE 
         CALL s_transaction_end('N','0')
         CALL cl_err()
         RETURN
      END IF      
 
      #add-point:單身刪除後 name="delete.body.a_delete2"
      
      #end add-point
 
      #add-point:單身刪除前 name="delete.body.b_delete3"
      
      #end add-point
      DELETE FROM preb_t
       WHERE prebent = g_enterprise AND
             prebdocno = g_prea_m.preadocno
      #add-point:單身刪除中 name="delete.body.m_delete3"
      
      #end add-point
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "pred_t:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = FALSE 
         CALL s_transaction_end('N','0')
         CALL cl_err()
         RETURN
      END IF      
 
      #add-point:單身刪除後 name="delete.body.a_delete3"
      
      #end add-point
 
 
 
 
      
      #修改歷程記錄(刪除)
      LET g_log1 = util.JSON.stringify(g_prea_m)   #(ver:78)
      IF NOT cl_log_modified_record(g_log1,'') THEN    #(ver:78)
         CLOSE aprt310_cl
         CALL s_transaction_end('N','0')
         RETURN
      END IF
             
      CLEAR FORM
      CALL g_prec_d.clear() 
      CALL g_prec2_d.clear()       
      CALL g_prec3_d.clear()       
      CALL g_prec4_d.clear()       
 
     
      CALL aprt310_ui_browser_refresh()  
      #CALL aprt310_ui_headershow()  
      #CALL aprt310_ui_detailshow()
 
      #add-point:多語言刪除 name="delete.lang.before_delete"
      
      #end add-point
      
      #單頭多語言刪除
      INITIALIZE l_var_keys_bak TO NULL 
   INITIALIZE l_field_keys   TO NULL 
   LET l_var_keys_bak[01] = g_enterprise
   LET l_field_keys[01] = 'prealent'
   LET l_var_keys_bak[02] = g_master_multi_table_t.prealdocno
   LET l_field_keys[02] = 'prealdocno'
   CALL cl_multitable_delete(l_field_keys,l_var_keys_bak,'preal_t')
 
      
      #單身多語言刪除
      
      
      
      
 
   
      #add-point:多語言刪除 name="delete.lang.delete"
      
      #end add-point
      
      IF g_browser_cnt > 0 THEN 
         #CALL aprt310_browser_fill("")
         CALL aprt310_fetch('P')
         DISPLAY g_browser_cnt TO FORMONLY.h_count   #總筆數的顯示
         DISPLAY g_browser_cnt TO FORMONLY.b_count   #總筆數的顯示
      ELSE
         CLEAR FORM
      END IF
      
      CALL s_transaction_end('Y','0')
   ELSE
      CALL s_transaction_end('N','0')
   END IF
 
   CLOSE aprt310_cl
 
   #功能已完成,通報訊息中心
   CALL aprt310_msgcentre_notify('delete')
    
END FUNCTION
 
{</section>}
 
{<section id="aprt310.b_fill" >}
#+ 單身陣列填充
PRIVATE FUNCTION aprt310_b_fill()
   #add-point:b_fill段define(客製用) name="b_fill.define_customerization"
   
   #end add-point     
   DEFINE p_wc2      STRING
   DEFINE li_idx     LIKE type_t.num10
   #add-point:b_fill段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="b_fill.define"
   
   #end add-point     
   
   #add-point:Function前置處理  name="b_fill.pre_function"
   
   #end add-point
   
   #清空第一階單身
   CALL g_prec_d.clear()
   CALL g_prec2_d.clear()
   CALL g_prec3_d.clear()
   CALL g_prec4_d.clear()
 
 
   #add-point:b_fill段sql_before name="b_fill.sql_before"
   
   #end add-point
   
   #判斷是否填充
   IF aprt310_fill_chk(1) THEN
      #切換上下筆時不重組SQL
      IF (g_action_choice = "query" OR cl_null(g_action_choice))
      #add-point:b_fill段long_sql_if name="b_fill.long_sql_if"
      
      #end add-point
      THEN
         LET g_sql = "SELECT  DISTINCT precacti,precseq,prec003,prec004,prec005,prec006,prec007,prec008, 
             prec009,prec010,prec011,prec012,prec013,prec014,prec015,prec016,prec017,prec018,prec019, 
             prec020,prec021,prec022,prec023,prec024,prec025,prec026,prec027,prec028,prec029,prec030, 
             prec031,prec032,prec033,prec034,prec035,prec036,prec037,prec038,prec039,prec040,prec041, 
             prec042,prec043,prec044,prec045,prec098,prec046,prec047,prec048,prec049,prec050,prec051, 
             prec052,prec053,prec054,prec055,prec056,prec057,prec058,prec059,prec060,prec061,prec062, 
             prec063,prec064,prec065,prec066,prec067,prec068,prec069,prec070,prec071,prec072,prec073, 
             prec074,prec075,prec078,prec079,prec081,prec001,precseq,prec080,prec082,prec083,prec084, 
             prec085,prec086,prec087,prec088,prec089,prec090,prec091,prec092,prec093,prec094,prec095, 
             prec096,prec097,precunit,precsite ,t1.inayl003 ,t2.mhael023 ,t3.ooefl003 ,t4.rtaxl003 FROM prec_t", 
                
                     " INNER JOIN prea_t ON preaent = " ||g_enterprise|| " AND preadocno = precdocno ",
 
                     #"",
                     
                     "",
                     #下層單身所需的join條件
 
                                    " LEFT JOIN inayl_t t1 ON t1.inaylent="||g_enterprise||" AND t1.inayl001=prec003 AND t1.inayl002='"||g_dlang||"' ",
               " LEFT JOIN mhael_t t2 ON t2.mhaelent="||g_enterprise||" AND t2.mhaelsite=precsite AND t2.mhael001=prec004 AND t2.mhael022='"||g_dlang||"' ",
               " LEFT JOIN ooefl_t t3 ON t3.ooeflent="||g_enterprise||" AND t3.ooefl001=prec005 AND t3.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN rtaxl_t t4 ON t4.rtaxlent="||g_enterprise||" AND t4.rtaxl001=prec006 AND t4.rtaxl002='"||g_dlang||"' ",
 
                     " WHERE precent=? AND precdocno=?"
         LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
         #add-point:b_fill段sql_before name="b_fill.body.fill_sql"
         
         #end add-point
         IF NOT cl_null(g_wc2_table1) THEN
            LET g_sql = g_sql CLIPPED, " AND ", g_wc2_table1 CLIPPED
         END IF
         
         #子單身的WC
         
         
         LET g_sql = g_sql, " ORDER BY prec_t.precseq"
         
         #add-point:單身填充控制 name="b_fill.sql"
         
         #end add-point
         
         LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
         PREPARE aprt310_pb FROM g_sql
         DECLARE b_fill_cs CURSOR FOR aprt310_pb
      END IF
      
      LET g_cnt = l_ac
      LET l_ac = 1
      
   #  OPEN b_fill_cs USING g_enterprise,g_prea_m.preadocno   #(ver:78)
                                               
      FOREACH b_fill_cs USING g_enterprise,g_prea_m.preadocno INTO g_prec_d[l_ac].precacti,g_prec_d[l_ac].precseq, 
          g_prec_d[l_ac].prec003,g_prec_d[l_ac].prec004,g_prec_d[l_ac].prec005,g_prec_d[l_ac].prec006, 
          g_prec_d[l_ac].prec007,g_prec_d[l_ac].prec008,g_prec_d[l_ac].prec009,g_prec_d[l_ac].prec010, 
          g_prec_d[l_ac].prec011,g_prec_d[l_ac].prec012,g_prec_d[l_ac].prec013,g_prec_d[l_ac].prec014, 
          g_prec_d[l_ac].prec015,g_prec_d[l_ac].prec016,g_prec_d[l_ac].prec017,g_prec_d[l_ac].prec018, 
          g_prec_d[l_ac].prec019,g_prec_d[l_ac].prec020,g_prec_d[l_ac].prec021,g_prec_d[l_ac].prec022, 
          g_prec_d[l_ac].prec023,g_prec_d[l_ac].prec024,g_prec_d[l_ac].prec025,g_prec_d[l_ac].prec026, 
          g_prec_d[l_ac].prec027,g_prec_d[l_ac].prec028,g_prec_d[l_ac].prec029,g_prec_d[l_ac].prec030, 
          g_prec_d[l_ac].prec031,g_prec_d[l_ac].prec032,g_prec_d[l_ac].prec033,g_prec_d[l_ac].prec034, 
          g_prec_d[l_ac].prec035,g_prec_d[l_ac].prec036,g_prec_d[l_ac].prec037,g_prec_d[l_ac].prec038, 
          g_prec_d[l_ac].prec039,g_prec_d[l_ac].prec040,g_prec_d[l_ac].prec041,g_prec_d[l_ac].prec042, 
          g_prec_d[l_ac].prec043,g_prec_d[l_ac].prec044,g_prec_d[l_ac].prec045,g_prec_d[l_ac].prec098, 
          g_prec_d[l_ac].prec046,g_prec_d[l_ac].prec047,g_prec_d[l_ac].prec048,g_prec_d[l_ac].prec049, 
          g_prec_d[l_ac].prec050,g_prec_d[l_ac].prec051,g_prec_d[l_ac].prec052,g_prec_d[l_ac].prec053, 
          g_prec_d[l_ac].prec054,g_prec_d[l_ac].prec055,g_prec_d[l_ac].prec056,g_prec_d[l_ac].prec057, 
          g_prec_d[l_ac].prec058,g_prec_d[l_ac].prec059,g_prec_d[l_ac].prec060,g_prec_d[l_ac].prec061, 
          g_prec_d[l_ac].prec062,g_prec_d[l_ac].prec063,g_prec_d[l_ac].prec064,g_prec_d[l_ac].prec065, 
          g_prec_d[l_ac].prec066,g_prec_d[l_ac].prec067,g_prec_d[l_ac].prec068,g_prec_d[l_ac].prec069, 
          g_prec_d[l_ac].prec070,g_prec_d[l_ac].prec071,g_prec_d[l_ac].prec072,g_prec_d[l_ac].prec073, 
          g_prec_d[l_ac].prec074,g_prec_d[l_ac].prec075,g_prec_d[l_ac].prec078,g_prec_d[l_ac].prec079, 
          g_prec_d[l_ac].prec081,g_prec_d[l_ac].prec001,g_prec2_d[l_ac].precseq,g_prec2_d[l_ac].prec080, 
          g_prec2_d[l_ac].prec082,g_prec2_d[l_ac].prec083,g_prec2_d[l_ac].prec084,g_prec2_d[l_ac].prec085, 
          g_prec2_d[l_ac].prec086,g_prec2_d[l_ac].prec087,g_prec2_d[l_ac].prec088,g_prec2_d[l_ac].prec089, 
          g_prec2_d[l_ac].prec090,g_prec2_d[l_ac].prec091,g_prec2_d[l_ac].prec092,g_prec2_d[l_ac].prec093, 
          g_prec2_d[l_ac].prec094,g_prec2_d[l_ac].prec095,g_prec2_d[l_ac].prec096,g_prec2_d[l_ac].prec097, 
          g_prec2_d[l_ac].precunit,g_prec2_d[l_ac].precsite,g_prec_d[l_ac].prec003_desc,g_prec_d[l_ac].prec004_desc, 
          g_prec_d[l_ac].prec005_desc,g_prec_d[l_ac].prec006_desc   #(ver:78)
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
    
   #判斷是否填充
   IF aprt310_fill_chk(2) THEN
      IF (g_action_choice = "query" OR cl_null(g_action_choice))
         #add-point:b_fill段long_sql_if name="b_fill.body2.long_sql_if"
         
         #end add-point
      THEN
         LET g_sql = "SELECT  DISTINCT predacti,predseq1,pred001,pred002,pred003,predseq,pred004,pred006, 
             pred005,pred007,predsite,predunit ,t5.inayl003 ,t6.mhael023 FROM pred_t",   
                     " INNER JOIN  prea_t ON preaent = " ||g_enterprise|| " AND preadocno = preddocno ",
 
                     "",
                     
                                    " LEFT JOIN inayl_t t5 ON t5.inaylent="||g_enterprise||" AND t5.inayl001=pred002 AND t5.inayl002='"||g_dlang||"' ",
               " LEFT JOIN mhael_t t6 ON t6.mhaelent="||g_enterprise||" AND t6.mhaelsite=predsite AND t6.mhael001=pred003 AND t6.mhael022='"||g_dlang||"' ",
 
                     " WHERE predent=? AND preddocno=?"   
         LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
         #add-point:b_fill段fill_sql name="b_fill.body2.fill_sql"
         
         #end add-point
         IF NOT cl_null(g_wc2_table2) THEN
            LET g_sql = g_sql CLIPPED," AND ",g_wc2_table2 CLIPPED
         END IF
         
         #子單身的WC
         
         
         LET g_sql = g_sql, " ORDER BY pred_t.predseq,pred_t.predseq1"
         
         #add-point:單身填充控制 name="b_fill.sql2"
         
         #end add-point
         
         LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
         PREPARE aprt310_pb2 FROM g_sql
         DECLARE b_fill_cs2 CURSOR FOR aprt310_pb2
      END IF
    
      LET l_ac = 1
      
   #  OPEN b_fill_cs2 USING g_enterprise,g_prea_m.preadocno   #(ver:78)
                                               
      FOREACH b_fill_cs2 USING g_enterprise,g_prea_m.preadocno INTO g_prec3_d[l_ac].predacti,g_prec3_d[l_ac].predseq1, 
          g_prec3_d[l_ac].pred001,g_prec3_d[l_ac].pred002,g_prec3_d[l_ac].pred003,g_prec3_d[l_ac].predseq, 
          g_prec3_d[l_ac].pred004,g_prec3_d[l_ac].pred006,g_prec3_d[l_ac].pred005,g_prec3_d[l_ac].pred007, 
          g_prec3_d[l_ac].predsite,g_prec3_d[l_ac].predunit,g_prec3_d[l_ac].pred002_desc,g_prec3_d[l_ac].pred003_desc  
            #(ver:78)
         IF SQLCA.SQLCODE THEN
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "FOREACH:",SQLERRMESSAGE 
            LET g_errparam.code = SQLCA.SQLCODE 
            LET g_errparam.popup = TRUE 
            CALL cl_err()
            EXIT FOREACH
         END IF
        
         #add-point:b_fill段資料填充 name="b_fill2.fill"
         
         #end add-point
      
         LET l_ac = l_ac + 1
         IF l_ac > g_max_rec THEN
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = l_ac
            LET g_errparam.code = 9035 
            LET g_errparam.popup = TRUE 
            CALL cl_err()
            EXIT FOREACH
         END IF
         
      END FOREACH
   END IF
 
   #判斷是否填充
   IF aprt310_fill_chk(3) THEN
      IF (g_action_choice = "query" OR cl_null(g_action_choice))
         #add-point:b_fill段long_sql_if name="b_fill.body3.long_sql_if"
         
         #end add-point
      THEN
         LET g_sql = "SELECT  DISTINCT preb002,preb003,preb004,preb005,preb006,preb007,preb008,prebacti, 
             prebsite,prebunit,preb001  FROM preb_t",   
                     " INNER JOIN  prea_t ON preaent = " ||g_enterprise|| " AND preadocno = prebdocno ",
 
                     "",
                     
                     
                     " WHERE prebent=? AND prebdocno=?"   
         LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
         #add-point:b_fill段fill_sql name="b_fill.body3.fill_sql"
         
         #end add-point
         IF NOT cl_null(g_wc2_table3) THEN
            LET g_sql = g_sql CLIPPED," AND ",g_wc2_table3 CLIPPED
         END IF
         
         #子單身的WC
         
         
         LET g_sql = g_sql, " ORDER BY preb_t.preb002"
         
         #add-point:單身填充控制 name="b_fill.sql3"
         
         #end add-point
         
         LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
         PREPARE aprt310_pb3 FROM g_sql
         DECLARE b_fill_cs3 CURSOR FOR aprt310_pb3
      END IF
    
      LET l_ac = 1
      
   #  OPEN b_fill_cs3 USING g_enterprise,g_prea_m.preadocno   #(ver:78)
                                               
      FOREACH b_fill_cs3 USING g_enterprise,g_prea_m.preadocno INTO g_prec4_d[l_ac].preb002,g_prec4_d[l_ac].preb003, 
          g_prec4_d[l_ac].preb004,g_prec4_d[l_ac].preb005,g_prec4_d[l_ac].preb006,g_prec4_d[l_ac].preb007, 
          g_prec4_d[l_ac].preb008,g_prec4_d[l_ac].prebacti,g_prec4_d[l_ac].prebsite,g_prec4_d[l_ac].prebunit, 
          g_prec4_d[l_ac].preb001   #(ver:78)
         IF SQLCA.SQLCODE THEN
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "FOREACH:",SQLERRMESSAGE 
            LET g_errparam.code = SQLCA.SQLCODE 
            LET g_errparam.popup = TRUE 
            CALL cl_err()
            EXIT FOREACH
         END IF
        
         #add-point:b_fill段資料填充 name="b_fill3.fill"
         
         #end add-point
      
         LET l_ac = l_ac + 1
         IF l_ac > g_max_rec THEN
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = l_ac
            LET g_errparam.code = 9035 
            LET g_errparam.popup = TRUE 
            CALL cl_err()
            EXIT FOREACH
         END IF
         
      END FOREACH
   END IF
 
 
   
   #add-point:browser_fill段其他table處理 name="browser_fill.other_fill"
   
   #end add-point
   
   CALL g_prec_d.deleteElement(g_prec_d.getLength())
   CALL g_prec2_d.deleteElement(g_prec2_d.getLength())
   CALL g_prec3_d.deleteElement(g_prec3_d.getLength())
   CALL g_prec4_d.deleteElement(g_prec4_d.getLength())
 
   
 
   LET l_ac = g_cnt
   LET g_cnt = 0  
   
   FREE aprt310_pb
   FREE aprt310_pb2
 
   FREE aprt310_pb3
 
 
   
   LET li_idx = l_ac
   
   #遮罩相關處理
   FOR l_ac = 1 TO g_prec_d.getLength()
      LET g_prec_d_mask_o[l_ac].* =  g_prec_d[l_ac].*
      CALL aprt310_prec_t_mask()
      LET g_prec_d_mask_n[l_ac].* =  g_prec_d[l_ac].*
   END FOR
   
   LET g_prec2_d_mask_o.* =  g_prec2_d.*
   FOR l_ac = 1 TO g_prec2_d.getLength()
      LET g_prec2_d_mask_o[l_ac].* =  g_prec2_d[l_ac].*
      CALL aprt310_prec_t_mask()
      LET g_prec2_d_mask_n[l_ac].* =  g_prec2_d[l_ac].*
   END FOR
   LET g_prec3_d_mask_o.* =  g_prec3_d.*
   FOR l_ac = 1 TO g_prec3_d.getLength()
      LET g_prec3_d_mask_o[l_ac].* =  g_prec3_d[l_ac].*
      CALL aprt310_pred_t_mask()
      LET g_prec3_d_mask_n[l_ac].* =  g_prec3_d[l_ac].*
   END FOR
   LET g_prec4_d_mask_o.* =  g_prec4_d.*
   FOR l_ac = 1 TO g_prec4_d.getLength()
      LET g_prec4_d_mask_o[l_ac].* =  g_prec4_d[l_ac].*
      CALL aprt310_preb_t_mask()
      LET g_prec4_d_mask_n[l_ac].* =  g_prec4_d[l_ac].*
   END FOR
 
   
   LET l_ac = li_idx
   
   CALL cl_ap_performance_next_end()
 
END FUNCTION
 
{</section>}
 
{<section id="aprt310.delete_b" >}
#+ 刪除單身後其他table連動
PRIVATE FUNCTION aprt310_delete_b(ps_table,ps_keys_bak,ps_page)
   #add-point:delete_b段define(客製用) name="delete_b.define_customerization"
   
   #end add-point     
   DEFINE ps_table    STRING
   DEFINE ps_page     STRING
   DEFINE ps_keys_bak DYNAMIC ARRAY OF VARCHAR(500)
   DEFINE ls_group    STRING
   DEFINE li_idx      LIKE type_t.num10
   #add-point:delete_b段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="delete_b.define"
   
   #end add-point     
   
   #add-point:Function前置處理  name="delete_b.pre_function"
   
   #end add-point
   
   LET g_update = TRUE  
   
   #判斷是否是同一群組的table
   LET ls_group = "'1','2',"
   IF ls_group.getIndexOf(ps_page,1) > 0 THEN
      #add-point:delete_b段刪除前 name="delete_b.b_delete"
      
      #end add-point    
      DELETE FROM prec_t
       WHERE precent = g_enterprise AND
         precdocno = ps_keys_bak[1] AND precseq = ps_keys_bak[2]
      #add-point:delete_b段刪除中 name="delete_b.m_delete"
      
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
         CALL g_prec_d.deleteElement(li_idx) 
      END IF 
      IF ps_page <> "'2'" THEN 
         CALL g_prec2_d.deleteElement(li_idx) 
      END IF 
 
   END IF
   
   LET ls_group = "'3',"
   #判斷是否是同一群組的table
   IF ls_group.getIndexOf(ps_page,1) > 0 THEN
      #add-point:delete_b段刪除前 name="delete_b.b_delete2"
      
      #end add-point    
      DELETE FROM pred_t
       WHERE predent = g_enterprise AND
             preddocno = ps_keys_bak[1] AND predseq = ps_keys_bak[2] AND predseq1 = ps_keys_bak[3]
      #add-point:delete_b段刪除中 name="delete_b.m_delete2"
      
      #end add-point    
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "pred_t:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = FALSE 
         CALL cl_err()
         RETURN FALSE
      END IF
      
      LET li_idx = g_detail_idx
      IF ps_page <> "'3'" THEN 
         CALL g_prec3_d.deleteElement(li_idx) 
      END IF 
 
      #add-point:delete_b段刪除後 name="delete_b.a_delete2"
      
      #end add-point    
   END IF
 
   LET ls_group = "'4',"
   #判斷是否是同一群組的table
   IF ls_group.getIndexOf(ps_page,1) > 0 THEN
      #add-point:delete_b段刪除前 name="delete_b.b_delete3"
      
      #end add-point    
      DELETE FROM preb_t
       WHERE prebent = g_enterprise AND
             prebdocno = ps_keys_bak[1] AND preb002 = ps_keys_bak[2]
      #add-point:delete_b段刪除中 name="delete_b.m_delete3"
      
      #end add-point    
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "preb_t:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = FALSE 
         CALL cl_err()
         RETURN FALSE
      END IF
      
      LET li_idx = g_detail_idx
      IF ps_page <> "'4'" THEN 
         CALL g_prec4_d.deleteElement(li_idx) 
      END IF 
 
      #add-point:delete_b段刪除後 name="delete_b.a_delete3"
      
      #end add-point    
   END IF
 
 
   
 
   
   #add-point:delete_b段other name="delete_b.other"
   
   #end add-point  
   
   RETURN TRUE
   
END FUNCTION
 
{</section>}
 
{<section id="aprt310.insert_b" >}
#+ 新增單身後其他table連動
PRIVATE FUNCTION aprt310_insert_b(ps_table,ps_keys,ps_page)
   #add-point:insert_b段define(客製用) name="insert_b.define_customerization"
   
   #end add-point     
   DEFINE ps_table    STRING
   DEFINE ps_page     STRING
   DEFINE ps_keys     DYNAMIC ARRAY OF VARCHAR(500)
   DEFINE ls_group    STRING
   DEFINE ls_page     STRING
   DEFINE li_idx      LIKE type_t.num10
   #add-point:insert_b段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="insert_b.define"
   DEFINE l_stfa001        LIKE stfa_t.stfa001
   DEFINE l_inaa141        LIKE inaa_t.inaa141
   #end add-point     
   
   #add-point:Function前置處理  name="insert_b.pre_function"
   
   #end add-point
   
   LET g_update = TRUE  
   
   #判斷是否是同一群組的table
   LET ls_group = "'1','2',"
   IF ls_group.getIndexOf(ps_page,1) > 0 THEN
      #add-point:insert_b段資料新增前 name="insert_b.before_insert"
      LET g_prec2_d[g_detail_idx].prec083=100
      LET g_prec2_d[g_detail_idx].prec085=100
      LET g_prec2_d[g_detail_idx].prec087=100
      LET g_prec2_d[g_detail_idx].prec089=100
      LET g_prec2_d[g_detail_idx].prec091=100
      LET g_prec2_d[g_detail_idx].prec093=100
      LET g_prec2_d[g_detail_idx].prec094=100
      LET g_prec2_d[g_detail_idx].prec095=100
      LET g_prec2_d[g_detail_idx].prec096=100
      LET g_prec2_d[g_detail_idx].prec097=100  
      LET g_prec2_d[g_detail_idx].prec084=0
      LET g_prec2_d[g_detail_idx].prec086=0
      LET g_prec2_d[g_detail_idx].prec088=0
      LET g_prec2_d[g_detail_idx].prec090=0
      LET g_prec2_d[g_detail_idx].prec092=0   
      
      IF g_prec_d[g_detail_idx].prec074='N' THEN
         LET g_prec2_d[g_detail_idx].prec080='N'
         LET g_prec2_d[g_detail_idx].prec082='N'  
      END IF  
      IF g_prec_d[g_detail_idx].prec074='Y' THEN
         LET g_prec2_d[g_detail_idx].prec080='Y'
         LET g_prec2_d[g_detail_idx].prec082='Y'      
         
         SELECT stfa001 INTO l_stfa001 #合同編號
           FROM stfa_t
          WHERE stfaent=g_enterprise
            AND stfa005=g_prec_d[g_detail_idx].prec004
          SELECT inaa141 INTO l_inaa141 #常规库区
            FROM inaa_t
           WHERE inaaent=g_enterprise
             AND inaa001=g_prec_d[g_detail_idx].prec003 
             
         SELECT stfd006,stfd007,stfd009 INTO g_prec2_d[g_detail_idx].prec083,g_prec2_d[g_detail_idx].prec093,g_prec2_d[g_detail_idx].prec084
           FROM stfd_t,oocq_t
          WHERE stfdent=g_enterprise
            AND stfd003=l_inaa141
            AND stfd001=l_stfa001
            AND oocqent=g_enterprise
            AND oocq001='2024'
            AND oocqstus='Y'                  
            AND oocq002=stfd004
            AND oocq009='1'    #會員等級一
            
         SELECT stfd006,stfd007,stfd009 INTO g_prec2_d[g_detail_idx].prec085,g_prec2_d[g_detail_idx].prec094,g_prec2_d[g_detail_idx].prec086
           FROM stfd_t,oocq_t
          WHERE stfdent=g_enterprise
            AND stfd003=l_inaa141
            AND stfd001=l_stfa001
            AND oocqent=g_enterprise
            AND oocq001='2024'
            AND oocqstus='Y'                  
            AND oocq002=stfd004
            AND oocq009='2'    #會員等級2         
         SELECT stfd006,stfd007,stfd009 INTO g_prec2_d[g_detail_idx].prec087,g_prec2_d[g_detail_idx].prec095,g_prec2_d[g_detail_idx].prec088
           FROM stfd_t,oocq_t
          WHERE stfdent=g_enterprise
            AND stfd003=l_inaa141
            AND stfd001=l_stfa001
            AND oocqent=g_enterprise
            AND oocq001='2024'
            AND oocqstus='Y'                  
            AND oocq002=stfd004
            AND oocq009='3'    #會員等級3        
         SELECT stfd006,stfd007,stfd009  INTO g_prec2_d[g_detail_idx].prec089,g_prec2_d[g_detail_idx].prec096,g_prec2_d[g_detail_idx].prec090
           FROM stfd_t,oocq_t
          WHERE stfdent=g_enterprise
            AND stfd003=l_inaa141
            AND stfd001=l_stfa001
            AND oocqent=g_enterprise
            AND oocq001='2024'
            AND oocqstus='Y'                  
            AND oocq002=stfd004
            AND oocq009='4'    #會員等級4  
         SELECT stfd006,stfd007,stfd009  INTO g_prec2_d[g_detail_idx].prec091,g_prec2_d[g_detail_idx].prec097,g_prec2_d[g_detail_idx].prec092
           FROM stfd_t,oocq_t
          WHERE stfdent=g_enterprise
            AND stfd003=l_inaa141
            AND stfd001=l_stfa001
            AND oocqent=g_enterprise
            AND oocq001='2024'
            AND oocqstus='Y'                  
            AND oocq002=stfd004
            AND oocq009='5'    #會員等級5    
                          
      END IF      

      IF cl_null(g_prec2_d[g_detail_idx].precsite) THEN
         LET g_prec2_d[g_detail_idx].precsite=g_prea_m.preasite
      END IF      
      IF cl_null(g_prec2_d[g_detail_idx].precunit) THEN
         LET g_prec2_d[g_detail_idx].precunit=g_prea_m.preaunit
      END IF  
      
      
      #end add-point 
      INSERT INTO prec_t
                  (precent,
                   precdocno,
                   precseq
                   ,precacti,prec003,prec004,prec005,prec006,prec007,prec008,prec009,prec010,prec011,prec012,prec013,prec014,prec015,prec016,prec017,prec018,prec019,prec020,prec021,prec022,prec023,prec024,prec025,prec026,prec027,prec028,prec029,prec030,prec031,prec032,prec033,prec034,prec035,prec036,prec037,prec038,prec039,prec040,prec041,prec042,prec043,prec044,prec045,prec098,prec046,prec047,prec048,prec049,prec050,prec051,prec052,prec053,prec054,prec055,prec056,prec057,prec058,prec059,prec060,prec061,prec062,prec063,prec064,prec065,prec066,prec067,prec068,prec069,prec070,prec071,prec072,prec073,prec074,prec075,prec078,prec079,prec081,prec001,prec080,prec082,prec083,prec084,prec085,prec086,prec087,prec088,prec089,prec090,prec091,prec092,prec093,prec094,prec095,prec096,prec097,precunit,precsite) 
            VALUES(g_enterprise,
                   ps_keys[1],ps_keys[2]
                   ,g_prec_d[g_detail_idx].precacti,g_prec_d[g_detail_idx].prec003,g_prec_d[g_detail_idx].prec004, 
                       g_prec_d[g_detail_idx].prec005,g_prec_d[g_detail_idx].prec006,g_prec_d[g_detail_idx].prec007, 
                       g_prec_d[g_detail_idx].prec008,g_prec_d[g_detail_idx].prec009,g_prec_d[g_detail_idx].prec010, 
                       g_prec_d[g_detail_idx].prec011,g_prec_d[g_detail_idx].prec012,g_prec_d[g_detail_idx].prec013, 
                       g_prec_d[g_detail_idx].prec014,g_prec_d[g_detail_idx].prec015,g_prec_d[g_detail_idx].prec016, 
                       g_prec_d[g_detail_idx].prec017,g_prec_d[g_detail_idx].prec018,g_prec_d[g_detail_idx].prec019, 
                       g_prec_d[g_detail_idx].prec020,g_prec_d[g_detail_idx].prec021,g_prec_d[g_detail_idx].prec022, 
                       g_prec_d[g_detail_idx].prec023,g_prec_d[g_detail_idx].prec024,g_prec_d[g_detail_idx].prec025, 
                       g_prec_d[g_detail_idx].prec026,g_prec_d[g_detail_idx].prec027,g_prec_d[g_detail_idx].prec028, 
                       g_prec_d[g_detail_idx].prec029,g_prec_d[g_detail_idx].prec030,g_prec_d[g_detail_idx].prec031, 
                       g_prec_d[g_detail_idx].prec032,g_prec_d[g_detail_idx].prec033,g_prec_d[g_detail_idx].prec034, 
                       g_prec_d[g_detail_idx].prec035,g_prec_d[g_detail_idx].prec036,g_prec_d[g_detail_idx].prec037, 
                       g_prec_d[g_detail_idx].prec038,g_prec_d[g_detail_idx].prec039,g_prec_d[g_detail_idx].prec040, 
                       g_prec_d[g_detail_idx].prec041,g_prec_d[g_detail_idx].prec042,g_prec_d[g_detail_idx].prec043, 
                       g_prec_d[g_detail_idx].prec044,g_prec_d[g_detail_idx].prec045,g_prec_d[g_detail_idx].prec098, 
                       g_prec_d[g_detail_idx].prec046,g_prec_d[g_detail_idx].prec047,g_prec_d[g_detail_idx].prec048, 
                       g_prec_d[g_detail_idx].prec049,g_prec_d[g_detail_idx].prec050,g_prec_d[g_detail_idx].prec051, 
                       g_prec_d[g_detail_idx].prec052,g_prec_d[g_detail_idx].prec053,g_prec_d[g_detail_idx].prec054, 
                       g_prec_d[g_detail_idx].prec055,g_prec_d[g_detail_idx].prec056,g_prec_d[g_detail_idx].prec057, 
                       g_prec_d[g_detail_idx].prec058,g_prec_d[g_detail_idx].prec059,g_prec_d[g_detail_idx].prec060, 
                       g_prec_d[g_detail_idx].prec061,g_prec_d[g_detail_idx].prec062,g_prec_d[g_detail_idx].prec063, 
                       g_prec_d[g_detail_idx].prec064,g_prec_d[g_detail_idx].prec065,g_prec_d[g_detail_idx].prec066, 
                       g_prec_d[g_detail_idx].prec067,g_prec_d[g_detail_idx].prec068,g_prec_d[g_detail_idx].prec069, 
                       g_prec_d[g_detail_idx].prec070,g_prec_d[g_detail_idx].prec071,g_prec_d[g_detail_idx].prec072, 
                       g_prec_d[g_detail_idx].prec073,g_prec_d[g_detail_idx].prec074,g_prec_d[g_detail_idx].prec075, 
                       g_prec_d[g_detail_idx].prec078,g_prec_d[g_detail_idx].prec079,g_prec_d[g_detail_idx].prec081, 
                       g_prec_d[g_detail_idx].prec001,g_prec2_d[g_detail_idx].prec080,g_prec2_d[g_detail_idx].prec082, 
                       g_prec2_d[g_detail_idx].prec083,g_prec2_d[g_detail_idx].prec084,g_prec2_d[g_detail_idx].prec085, 
                       g_prec2_d[g_detail_idx].prec086,g_prec2_d[g_detail_idx].prec087,g_prec2_d[g_detail_idx].prec088, 
                       g_prec2_d[g_detail_idx].prec089,g_prec2_d[g_detail_idx].prec090,g_prec2_d[g_detail_idx].prec091, 
                       g_prec2_d[g_detail_idx].prec092,g_prec2_d[g_detail_idx].prec093,g_prec2_d[g_detail_idx].prec094, 
                       g_prec2_d[g_detail_idx].prec095,g_prec2_d[g_detail_idx].prec096,g_prec2_d[g_detail_idx].prec097, 
                       g_prec2_d[g_detail_idx].precunit,g_prec2_d[g_detail_idx].precsite)
      #add-point:insert_b段資料新增中 name="insert_b.m_insert"
      
      #end add-point 
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "prec_t:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = FALSE 
         CALL cl_err()
      END IF
      
      LET li_idx = g_detail_idx
      IF ps_page <> "'1'" THEN 
         CALL g_prec_d.insertElement(li_idx) 
      END IF 
      IF ps_page <> "'2'" THEN 
         CALL g_prec2_d.insertElement(li_idx) 
      END IF 
 
      #add-point:insert_b段資料新增後 name="insert_b.after_insert"
      
      #end add-point 
   END IF
   
   LET ls_group = "'3',"
   #判斷是否是同一群組的table
   IF ls_group.getIndexOf(ps_page,1) > 0 THEN
      #add-point:insert_b段資料新增前 name="insert_b.before_insert2"
      
      #end add-point 
      INSERT INTO pred_t
                  (predent,
                   preddocno,
                   predseq,predseq1
                   ,predacti,pred001,pred002,pred003,pred004,pred006,pred005,pred007,predsite,predunit) 
            VALUES(g_enterprise,
                   ps_keys[1],ps_keys[2],ps_keys[3]
                   ,g_prec3_d[g_detail_idx].predacti,g_prec3_d[g_detail_idx].pred001,g_prec3_d[g_detail_idx].pred002, 
                       g_prec3_d[g_detail_idx].pred003,g_prec3_d[g_detail_idx].pred004,g_prec3_d[g_detail_idx].pred006, 
                       g_prec3_d[g_detail_idx].pred005,g_prec3_d[g_detail_idx].pred007,g_prec3_d[g_detail_idx].predsite, 
                       g_prec3_d[g_detail_idx].predunit)
      #add-point:insert_b段資料新增中 name="insert_b.m_insert2"
      
      #end add-point
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "pred_t:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = FALSE 
         CALL cl_err()
      END IF
      
      LET li_idx = g_detail_idx
      IF ps_page <> "'3'" THEN 
         CALL g_prec3_d.insertElement(li_idx) 
      END IF 
 
      #add-point:insert_b段資料新增後 name="insert_b.after_insert2"
      
      #end add-point
   END IF
 
   LET ls_group = "'4',"
   #判斷是否是同一群組的table
   IF ls_group.getIndexOf(ps_page,1) > 0 THEN
      #add-point:insert_b段資料新增前 name="insert_b.before_insert3"
      
      #end add-point 
      INSERT INTO preb_t
                  (prebent,
                   prebdocno,
                   preb002
                   ,preb003,preb004,preb005,preb006,preb007,preb008,prebacti,prebsite,prebunit,preb001) 
            VALUES(g_enterprise,
                   ps_keys[1],ps_keys[2]
                   ,g_prec4_d[g_detail_idx].preb003,g_prec4_d[g_detail_idx].preb004,g_prec4_d[g_detail_idx].preb005, 
                       g_prec4_d[g_detail_idx].preb006,g_prec4_d[g_detail_idx].preb007,g_prec4_d[g_detail_idx].preb008, 
                       g_prec4_d[g_detail_idx].prebacti,g_prec4_d[g_detail_idx].prebsite,g_prec4_d[g_detail_idx].prebunit, 
                       g_prec4_d[g_detail_idx].preb001)
      #add-point:insert_b段資料新增中 name="insert_b.m_insert3"
      
      #end add-point
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "preb_t:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = FALSE 
         CALL cl_err()
      END IF
      
      LET li_idx = g_detail_idx
      IF ps_page <> "'4'" THEN 
         CALL g_prec4_d.insertElement(li_idx) 
      END IF 
 
      #add-point:insert_b段資料新增後 name="insert_b.after_insert3"
      
      #end add-point
   END IF
 
 
   
 
   
   #add-point:insert_b段other name="insert_b.other"
   
   #end add-point     
   
END FUNCTION
 
{</section>}
 
{<section id="aprt310.update_b" >}
#+ 修改單身後其他table連動
PRIVATE FUNCTION aprt310_update_b(ps_table,ps_keys,ps_keys_bak,ps_page)
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
   DEFINE l_stfa001        LIKE stfa_t.stfa001
   DEFINE l_inaa141        LIKE inaa_t.inaa141
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
   LET ls_group = "'1','2',"
   IF ls_group.getIndexOf(ps_page,1) > 0 AND ps_table <> "prec_t" THEN
      #add-point:update_b段修改前 name="update_b.before_update"
 
      #end add-point 
      
      #將遮罩欄位還原
      CALL aprt310_prec_t_mask_restore('restore_mask_o')
               
      UPDATE prec_t 
         SET (precdocno,
              precseq
              ,precacti,prec003,prec004,prec005,prec006,prec007,prec008,prec009,prec010,prec011,prec012,prec013,prec014,prec015,prec016,prec017,prec018,prec019,prec020,prec021,prec022,prec023,prec024,prec025,prec026,prec027,prec028,prec029,prec030,prec031,prec032,prec033,prec034,prec035,prec036,prec037,prec038,prec039,prec040,prec041,prec042,prec043,prec044,prec045,prec098,prec046,prec047,prec048,prec049,prec050,prec051,prec052,prec053,prec054,prec055,prec056,prec057,prec058,prec059,prec060,prec061,prec062,prec063,prec064,prec065,prec066,prec067,prec068,prec069,prec070,prec071,prec072,prec073,prec074,prec075,prec078,prec079,prec081,prec001,prec080,prec082,prec083,prec084,prec085,prec086,prec087,prec088,prec089,prec090,prec091,prec092,prec093,prec094,prec095,prec096,prec097,precunit,precsite) 
              = 
             (ps_keys[1],ps_keys[2]
              ,g_prec_d[g_detail_idx].precacti,g_prec_d[g_detail_idx].prec003,g_prec_d[g_detail_idx].prec004, 
                  g_prec_d[g_detail_idx].prec005,g_prec_d[g_detail_idx].prec006,g_prec_d[g_detail_idx].prec007, 
                  g_prec_d[g_detail_idx].prec008,g_prec_d[g_detail_idx].prec009,g_prec_d[g_detail_idx].prec010, 
                  g_prec_d[g_detail_idx].prec011,g_prec_d[g_detail_idx].prec012,g_prec_d[g_detail_idx].prec013, 
                  g_prec_d[g_detail_idx].prec014,g_prec_d[g_detail_idx].prec015,g_prec_d[g_detail_idx].prec016, 
                  g_prec_d[g_detail_idx].prec017,g_prec_d[g_detail_idx].prec018,g_prec_d[g_detail_idx].prec019, 
                  g_prec_d[g_detail_idx].prec020,g_prec_d[g_detail_idx].prec021,g_prec_d[g_detail_idx].prec022, 
                  g_prec_d[g_detail_idx].prec023,g_prec_d[g_detail_idx].prec024,g_prec_d[g_detail_idx].prec025, 
                  g_prec_d[g_detail_idx].prec026,g_prec_d[g_detail_idx].prec027,g_prec_d[g_detail_idx].prec028, 
                  g_prec_d[g_detail_idx].prec029,g_prec_d[g_detail_idx].prec030,g_prec_d[g_detail_idx].prec031, 
                  g_prec_d[g_detail_idx].prec032,g_prec_d[g_detail_idx].prec033,g_prec_d[g_detail_idx].prec034, 
                  g_prec_d[g_detail_idx].prec035,g_prec_d[g_detail_idx].prec036,g_prec_d[g_detail_idx].prec037, 
                  g_prec_d[g_detail_idx].prec038,g_prec_d[g_detail_idx].prec039,g_prec_d[g_detail_idx].prec040, 
                  g_prec_d[g_detail_idx].prec041,g_prec_d[g_detail_idx].prec042,g_prec_d[g_detail_idx].prec043, 
                  g_prec_d[g_detail_idx].prec044,g_prec_d[g_detail_idx].prec045,g_prec_d[g_detail_idx].prec098, 
                  g_prec_d[g_detail_idx].prec046,g_prec_d[g_detail_idx].prec047,g_prec_d[g_detail_idx].prec048, 
                  g_prec_d[g_detail_idx].prec049,g_prec_d[g_detail_idx].prec050,g_prec_d[g_detail_idx].prec051, 
                  g_prec_d[g_detail_idx].prec052,g_prec_d[g_detail_idx].prec053,g_prec_d[g_detail_idx].prec054, 
                  g_prec_d[g_detail_idx].prec055,g_prec_d[g_detail_idx].prec056,g_prec_d[g_detail_idx].prec057, 
                  g_prec_d[g_detail_idx].prec058,g_prec_d[g_detail_idx].prec059,g_prec_d[g_detail_idx].prec060, 
                  g_prec_d[g_detail_idx].prec061,g_prec_d[g_detail_idx].prec062,g_prec_d[g_detail_idx].prec063, 
                  g_prec_d[g_detail_idx].prec064,g_prec_d[g_detail_idx].prec065,g_prec_d[g_detail_idx].prec066, 
                  g_prec_d[g_detail_idx].prec067,g_prec_d[g_detail_idx].prec068,g_prec_d[g_detail_idx].prec069, 
                  g_prec_d[g_detail_idx].prec070,g_prec_d[g_detail_idx].prec071,g_prec_d[g_detail_idx].prec072, 
                  g_prec_d[g_detail_idx].prec073,g_prec_d[g_detail_idx].prec074,g_prec_d[g_detail_idx].prec075, 
                  g_prec_d[g_detail_idx].prec078,g_prec_d[g_detail_idx].prec079,g_prec_d[g_detail_idx].prec081, 
                  g_prec_d[g_detail_idx].prec001,g_prec2_d[g_detail_idx].prec080,g_prec2_d[g_detail_idx].prec082, 
                  g_prec2_d[g_detail_idx].prec083,g_prec2_d[g_detail_idx].prec084,g_prec2_d[g_detail_idx].prec085, 
                  g_prec2_d[g_detail_idx].prec086,g_prec2_d[g_detail_idx].prec087,g_prec2_d[g_detail_idx].prec088, 
                  g_prec2_d[g_detail_idx].prec089,g_prec2_d[g_detail_idx].prec090,g_prec2_d[g_detail_idx].prec091, 
                  g_prec2_d[g_detail_idx].prec092,g_prec2_d[g_detail_idx].prec093,g_prec2_d[g_detail_idx].prec094, 
                  g_prec2_d[g_detail_idx].prec095,g_prec2_d[g_detail_idx].prec096,g_prec2_d[g_detail_idx].prec097, 
                  g_prec2_d[g_detail_idx].precunit,g_prec2_d[g_detail_idx].precsite) 
         WHERE precent = g_enterprise AND precdocno = ps_keys_bak[1] AND precseq = ps_keys_bak[2]
      #add-point:update_b段修改中 name="update_b.m_update"
      
      #end add-point   
      CASE
         WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "prec_t" 
            LET g_errparam.code = "std-00009" 
            LET g_errparam.popup = TRUE 
            CALL s_transaction_end('N','0')
            CALL cl_err()
            
         WHEN SQLCA.SQLCODE #其他錯誤
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "prec_t:",SQLERRMESSAGE 
            LET g_errparam.code = SQLCA.SQLCODE 
            LET g_errparam.popup = TRUE 
            CALL s_transaction_end('N','0')
            CALL cl_err()
            
         OTHERWISE
 
      END CASE
      
      #將遮罩欄位進行遮蔽
      CALL aprt310_prec_t_mask_restore('restore_mask_n')
               
      #add-point:update_b段修改後 name="update_b.after_update"
      
      #end add-point  
   END IF
   
   #子表處理
   IF ls_group.getIndexOf(ps_page,1) > 0 THEN
      
   END IF
   
   
   LET ls_group = "'3',"
   #判斷是否是同一群組的table
   IF ls_group.getIndexOf(ps_page,1) > 0 AND ps_table <> "pred_t" THEN
      #add-point:update_b段修改前 name="update_b.before_update2"
      
      #end add-point  
      
      #將遮罩欄位還原
      CALL aprt310_pred_t_mask_restore('restore_mask_o')
               
      UPDATE pred_t 
         SET (preddocno,
              predseq,predseq1
              ,predacti,pred001,pred002,pred003,pred004,pred006,pred005,pred007,predsite,predunit) 
              = 
             (ps_keys[1],ps_keys[2],ps_keys[3]
              ,g_prec3_d[g_detail_idx].predacti,g_prec3_d[g_detail_idx].pred001,g_prec3_d[g_detail_idx].pred002, 
                  g_prec3_d[g_detail_idx].pred003,g_prec3_d[g_detail_idx].pred004,g_prec3_d[g_detail_idx].pred006, 
                  g_prec3_d[g_detail_idx].pred005,g_prec3_d[g_detail_idx].pred007,g_prec3_d[g_detail_idx].predsite, 
                  g_prec3_d[g_detail_idx].predunit) 
         WHERE predent = g_enterprise AND preddocno = ps_keys_bak[1] AND predseq = ps_keys_bak[2] AND predseq1 = ps_keys_bak[3]
      #add-point:update_b段修改中 name="update_b.m_update2"
      
      #end add-point  
      CASE
         WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "pred_t" 
            LET g_errparam.code = "std-00009" 
            LET g_errparam.popup = TRUE 
            CALL s_transaction_end('N','0')
            CALL cl_err()
            
         WHEN SQLCA.SQLCODE #其他錯誤
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "pred_t:",SQLERRMESSAGE 
            LET g_errparam.code = SQLCA.SQLCODE 
            LET g_errparam.popup = TRUE 
            CALL s_transaction_end('N','0')
            CALL cl_err()
            
         OTHERWISE
          
      END CASE
      
      #將遮罩欄位進行遮蔽
      CALL aprt310_pred_t_mask_restore('restore_mask_n')
 
      #add-point:update_b段修改後 name="update_b.after_update2"
      
      #end add-point  
   END IF
 
   #子表處理
   IF ls_group.getIndexOf(ps_page,1) > 0 THEN
      
   END IF
 
   LET ls_group = "'4',"
   #判斷是否是同一群組的table
   IF ls_group.getIndexOf(ps_page,1) > 0 AND ps_table <> "preb_t" THEN
      #add-point:update_b段修改前 name="update_b.before_update3"
      
      #end add-point  
      
      #將遮罩欄位還原
      CALL aprt310_preb_t_mask_restore('restore_mask_o')
               
      UPDATE preb_t 
         SET (prebdocno,
              preb002
              ,preb003,preb004,preb005,preb006,preb007,preb008,prebacti,prebsite,prebunit,preb001) 
              = 
             (ps_keys[1],ps_keys[2]
              ,g_prec4_d[g_detail_idx].preb003,g_prec4_d[g_detail_idx].preb004,g_prec4_d[g_detail_idx].preb005, 
                  g_prec4_d[g_detail_idx].preb006,g_prec4_d[g_detail_idx].preb007,g_prec4_d[g_detail_idx].preb008, 
                  g_prec4_d[g_detail_idx].prebacti,g_prec4_d[g_detail_idx].prebsite,g_prec4_d[g_detail_idx].prebunit, 
                  g_prec4_d[g_detail_idx].preb001) 
         WHERE prebent = g_enterprise AND prebdocno = ps_keys_bak[1] AND preb002 = ps_keys_bak[2]
      #add-point:update_b段修改中 name="update_b.m_update3"
      
      #end add-point  
      CASE
         WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "preb_t" 
            LET g_errparam.code = "std-00009" 
            LET g_errparam.popup = TRUE 
            CALL s_transaction_end('N','0')
            CALL cl_err()
            
         WHEN SQLCA.SQLCODE #其他錯誤
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "preb_t:",SQLERRMESSAGE 
            LET g_errparam.code = SQLCA.SQLCODE 
            LET g_errparam.popup = TRUE 
            CALL s_transaction_end('N','0')
            CALL cl_err()
            
         OTHERWISE
          
      END CASE
      
      #將遮罩欄位進行遮蔽
      CALL aprt310_preb_t_mask_restore('restore_mask_n')
 
      #add-point:update_b段修改後 name="update_b.after_update3"
      
      #end add-point  
   END IF
 
   #子表處理
   IF ls_group.getIndexOf(ps_page,1) > 0 THEN
      
   END IF
 
 
   
 
   
   #add-point:update_b段other name="update_b.other"
   
   #end add-point  
   
END FUNCTION
 
{</section>}
 
{<section id="aprt310.key_update_b" >}
#+ 上層單身key欄位變動後, 連帶修正下層單身key欄位
PRIVATE FUNCTION aprt310_key_update_b(ps_keys_bak,ps_table)
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
 
{<section id="aprt310.key_delete_b" >}
#+ 上層單身刪除後, 連帶刪除下層單身key欄位
PRIVATE FUNCTION aprt310_key_delete_b(ps_keys_bak,ps_table)
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
 
{<section id="aprt310.lock_b" >}
#+ 連動lock其他單身table資料
PRIVATE FUNCTION aprt310_lock_b(ps_table,ps_page)
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
   #CALL aprt310_b_fill()
   
   #鎖定整組table
   #LET ls_group = "'1','2',"
   #僅鎖定自身table
   LET ls_group = "prec_t"
   
   IF ls_group.getIndexOf(ps_table,1) THEN
      OPEN aprt310_bcl USING g_enterprise,
                                       g_prea_m.preadocno,g_prec_d[g_detail_idx].precseq     
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "aprt310_bcl:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = TRUE 
         CALL cl_err()
         RETURN FALSE
      END IF
   END IF
                                    
   #鎖定整組table
   #LET ls_group = "'3',"
   #僅鎖定自身table
   LET ls_group = "pred_t"
   IF ls_group.getIndexOf(ps_table,1) THEN
   
      OPEN aprt310_bcl2 USING g_enterprise,
                                             g_prea_m.preadocno,g_prec3_d[g_detail_idx].predseq,g_prec3_d[g_detail_idx].predseq1 
 
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "aprt310_bcl2:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = TRUE 
         CALL cl_err()
         RETURN FALSE
      END IF
   END IF
 
   #鎖定整組table
   #LET ls_group = "'4',"
   #僅鎖定自身table
   LET ls_group = "preb_t"
   IF ls_group.getIndexOf(ps_table,1) THEN
   
      OPEN aprt310_bcl3 USING g_enterprise,
                                             g_prea_m.preadocno,g_prec4_d[g_detail_idx].preb002
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "aprt310_bcl3:",SQLERRMESSAGE 
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
 
{<section id="aprt310.unlock_b" >}
#+ 連動unlock其他單身table資料
PRIVATE FUNCTION aprt310_unlock_b(ps_table,ps_page)
   #add-point:unlock_b段define(客製用) name="unlock_b.define_customerization"
   
   #end add-point  
   DEFINE ps_page     STRING
   DEFINE ps_table    STRING
   DEFINE ls_group    STRING
   #add-point:unlock_b段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="unlock_b.define"
   
   #end add-point  
   
   #add-point:Function前置處理  name="unlock_b.pre_function"
   
   #end add-point
    
   LET ls_group = "'1','2',"
   
   IF ls_group.getIndexOf(ps_page,1) THEN
      CLOSE aprt310_bcl
   END IF
   
   LET ls_group = "'3',"
   
   IF ls_group.getIndexOf(ps_page,1) THEN
      CLOSE aprt310_bcl2
   END IF
 
   LET ls_group = "'4',"
   
   IF ls_group.getIndexOf(ps_page,1) THEN
      CLOSE aprt310_bcl3
   END IF
 
 
   
 
 
   #add-point:unlock_b段other name="unlock_b.other"
   
   #end add-point  
 
END FUNCTION
 
{</section>}
 
{<section id="aprt310.set_entry" >}
#+ 單頭欄位開啟設定
PRIVATE FUNCTION aprt310_set_entry(p_cmd)
   #add-point:set_entry段define(客製用) name="set_entry.define_customerization"
   
   #end add-point       
   DEFINE p_cmd   LIKE type_t.chr1  
   #add-point:set_entry段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_entry.define"
   
   #end add-point       
   
   #add-point:Function前置處理  name="set_entry.pre_function"
   
   #end add-point
   
   CALL cl_set_comp_entry("preadocno",TRUE)
   
   IF p_cmd = 'a' THEN
      CALL cl_set_comp_entry("preadocno",TRUE)
      CALL cl_set_comp_entry("preadocdt",TRUE)
      #根據azzi850使用者身分開關特定欄位
      IF NOT cl_null(g_no_entry) THEN
         CALL cl_set_comp_entry(g_no_entry,TRUE)
      END IF
      #add-point:set_entry段欄位控制 name="set_entry.field_control"
      CALL cl_set_comp_entry("prea001,prea000,prea003,prea004",TRUE)
      CALL cl_set_comp_entry("preasite",TRUE)   #161101-00022#1--add
      #end add-point  
   END IF
   
   #add-point:set_entry段欄位控制後 name="set_entry.after_control"
   IF g_prea_m.prea004='1' OR g_prea_m.prea004='2' THEN
      CALL cl_set_comp_entry("prea005,prea006",TRUE)
      CALL cl_set_comp_required("prea005,prea006",TRUE)                     
   END IF  
   CALL cl_set_comp_entry("prea052",TRUE)        #160104-00012#2----add-----by huangrh--20160106---   
   #end add-point 
 
END FUNCTION
 
{</section>}
 
{<section id="aprt310.set_no_entry" >}
#+ 單頭欄位關閉設定
PRIVATE FUNCTION aprt310_set_no_entry(p_cmd)
   #add-point:set_no_entry段define(客製用) name="set_no_entry.define_customerization"
   
   #end add-point     
   DEFINE p_cmd   LIKE type_t.chr1   
   #add-point:set_no_entry段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_no_entry.define"
   
   #end add-point     
   
   #add-point:Function前置處理  name="set_no_entry.pre_function"
   
   #end add-point
   
   IF p_cmd = 'u' AND g_chkey = 'N' THEN
      CALL cl_set_comp_entry("preadocno",FALSE)
      #根據azzi850使用者身分開關特定欄位
      IF NOT cl_null(g_no_entry) THEN
         CALL cl_set_comp_entry(g_no_entry,FALSE)
      END IF
      #add-point:set_no_entry段欄位控制 name="set_no_entry.field_control"
      CALL cl_set_comp_entry("prea001,prea000,prea003,prea004",FALSE)
      #end add-point 
   END IF 
   
   IF p_cmd = 'u' THEN  #docno,ld欄位確認是絕對關閉
      CALL cl_set_comp_entry("preadocno",FALSE)
   END IF 
 
#  IF p_cmd = 'u' THEN  #docdt欄位依照設定關閉(FALSE則為設定不同意修正) #(ver:78)
      IF NOT cl_chk_update_docdt() THEN
         CALL cl_set_comp_entry("preadocdt",FALSE)
      END IF
#  END IF 
   
   #add-point:set_no_entry段欄位控制後 name="set_no_entry.after_control"
   IF NOT s_aooi500_comp_entry(g_prog,'preasite') OR g_site_flag THEN
      CALL cl_set_comp_entry("preasite",FALSE)
   END IF 
   IF g_prea_m.prea004<>'1' AND g_prea_m.prea004<>'2' THEN
      CALL cl_set_comp_required("prea005,prea006",FALSE) 
      CALL cl_set_comp_entry("prea005,prea006",FALSE)                     
   END IF   
   #160104-00012#1----add---begin--by huangrh--20160107--- 
   IF g_prea_m.prea004<>'4' THEN
      CALL cl_set_comp_entry("prea052",FALSE)          
   END IF
   #160104-00012#1----add---end--by huangrh--20160107---     
   #end add-point 
 
END FUNCTION
 
{</section>}
 
{<section id="aprt310.set_entry_b" >}
#+ 單身欄位開啟設定
PRIVATE FUNCTION aprt310_set_entry_b(p_cmd)
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
#   IF g_prec2_d[l_ac].prec080='Y' THEN
#      CALL cl_set_comp_required("prec083,prec085,prec087,prec089,prec091",TRUE) 
#   END IF
#   IF g_prec2_d[l_ac].prec082='Y' THEN
#      CALL cl_set_comp_entry("prec084,prec086,prec088,prec090,prec092",TRUE) 
#      CALL cl_set_comp_required("prec084,prec086,prec088,prec090,prec092",TRUE) 
#   END IF   
   IF g_prec_d[l_ac].prec060='3' OR g_prec_d[l_ac].prec060='4' THEN
      CALL cl_set_comp_entry("prec061",TRUE)
      CALL cl_set_comp_required("prec061",TRUE)                     
   END IF   
   #end add-point  
END FUNCTION
 
{</section>}
 
{<section id="aprt310.set_no_entry_b" >}
#+ 單身欄位關閉設定
PRIVATE FUNCTION aprt310_set_no_entry_b(p_cmd)
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
#   IF g_prec2_d[l_ac].prec080='N' THEN
#      CALL cl_set_comp_required("prec083,prec085,prec087,prec089,prec091",FALSE) 
#   END IF
#   IF g_prec2_d[l_ac].prec082='N' THEN
#      CALL cl_set_comp_required("prec084,prec086,prec088,prec090,prec092",FALSE) 
#      CALL cl_set_comp_entry("prec084,prec086,prec088,prec090,prec092",FALSE)  
#   END IF 
   IF g_prec_d[l_ac].prec060<>'3' AND g_prec_d[l_ac].prec060<>'4' THEN
      CALL cl_set_comp_required("prec061",FALSE) 
      CALL cl_set_comp_entry("prec061",FALSE)                         
   END IF    
   #end add-point     
END FUNCTION
 
{</section>}
 
{<section id="aprt310.set_act_visible" >}
#+ 單頭權限開啟
PRIVATE FUNCTION aprt310_set_act_visible()
   #add-point:set_act_visible段define(客製用) name="set_act_visible.define_customerization"
   
   #end add-point   
   #add-point:set_act_visible段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_visible.define"
   
   #end add-point   
   #add-point:set_act_visible段 name="set_act_visible.set_act_visible"
   
   #end add-point   
END FUNCTION
 
{</section>}
 
{<section id="aprt310.set_act_no_visible" >}
#+ 單頭權限關閉
PRIVATE FUNCTION aprt310_set_act_no_visible()
   #add-point:set_act_no_visible段define(客製用) name="set_act_no_visible.define_customerization"
   
   #end add-point   
   #add-point:set_act_no_visible段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_no_visible.define"
   
   #end add-point   
   #add-point:set_act_no_visible段 name="set_act_no_visible.set_act_no_visible"
   #應用 a63 樣板自動產生(Version:1)
   IF g_prea_m.preastus NOT MATCHES "[NDR]" THEN   # N未確認/D抽單/R已拒絕允許修改
      CALL cl_set_act_visible("modify,delete,modify_detail", FALSE)
   END IF


   #end add-point   
END FUNCTION
 
{</section>}
 
{<section id="aprt310.set_act_visible_b" >}
#+ 單身權限開啟
PRIVATE FUNCTION aprt310_set_act_visible_b()
   #add-point:set_act_visible_b段define(客製用) name="set_act_visible_b.define_customerization"
   
   #end add-point   
   #add-point:set_act_visible_b段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_visible_b.define"
   
   #end add-point   
   #add-point:set_act_visible_b段 name="set_act_visible_b.set_act_visible_b"
   
   #end add-point   
END FUNCTION
 
{</section>}
 
{<section id="aprt310.set_act_no_visible_b" >}
#+ 單身權限關閉
PRIVATE FUNCTION aprt310_set_act_no_visible_b()
   #add-point:set_act_no_visible_b段define(客製用) name="set_act_no_visible_b.define_customerization"
   
   #end add-point   
   #add-point:set_act_no_visible_b段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_no_visible_b.define"
   
   #end add-point   
   #add-point:set_act_no_visible_b段 name="set_act_no_visible_b.set_act_no_visible_b"
   
   #end add-point   
END FUNCTION
 
{</section>}
 
{<section id="aprt310.default_search" >}
#+ 外部參數搜尋
PRIVATE FUNCTION aprt310_default_search()
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
      LET ls_wc = ls_wc, " preadocno = '", g_argv[01], "' AND "
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
         INITIALIZE g_wc2_table2 TO NULL
 
         INITIALIZE g_wc2_table3 TO NULL
 
 
         FOR li_idx = 1 TO la_wc.getLength()
            CASE
               WHEN la_wc[li_idx].tableid = "prea_t" 
                  LET g_wc = la_wc[li_idx].wc
               WHEN la_wc[li_idx].tableid = "prec_t" 
                  LET g_wc2_table1 = la_wc[li_idx].wc
               WHEN la_wc[li_idx].tableid = "pred_t" 
                  LET g_wc2_table2 = la_wc[li_idx].wc
 
               WHEN la_wc[li_idx].tableid = "preb_t" 
                  LET g_wc2_table3 = la_wc[li_idx].wc
 
 
               WHEN la_wc[li_idx].tableid = "EXTENDWC"
                  LET g_wc2_extend = la_wc[li_idx].wc
            END CASE
         END FOR
         IF NOT cl_null(g_wc) OR NOT cl_null(g_wc2_table1) 
            OR NOT cl_null(g_wc2_table2)
 
            OR NOT cl_null(g_wc2_table3)
 
 
            OR NOT cl_null(g_wc2_extend)
            THEN
            #組合g_wc2
            IF g_wc2_table1 <> " 1=1" AND NOT cl_null(g_wc2_table1) THEN
               LET g_wc2 = g_wc2_table1
            END IF
            IF g_wc2_table2 <> " 1=1" AND NOT cl_null(g_wc2_table2) THEN
               LET g_wc2 = g_wc2 ," AND ", g_wc2_table2
            END IF
 
            IF g_wc2_table3 <> " 1=1" AND NOT cl_null(g_wc2_table3) THEN
               LET g_wc2 = g_wc2 ," AND ", g_wc2_table3
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
   
   #end add-point  
 
   IF g_wc.getIndexOf(" 1=2", 1) THEN
      LET g_default = TRUE
   END IF
 
 
END FUNCTION
 
{</section>}
 
{<section id="aprt310.state_change" >}
   #應用 a09 樣板自動產生(Version:17)
#+ 確認碼變更 
PRIVATE FUNCTION aprt310_statechange()
   #add-point:statechange段define(客製用) name="statechange.define_customerization"
   
   #end add-point  
   DEFINE lc_state LIKE type_t.chr5
   #add-point:statechange段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="statechange.define"
   DEFINE l_time      DATETIME YEAR TO SECOND
   DEFINE l_success   LIKE type_t.num5
   DEFINE l_prea014   LIKE prea_t.prea014
   DEFINE l_prea015   LIKE prea_t.prea015
   DEFINE l_chr50     LIKE type_t.chr50
   #end add-point  
   
   #add-point:Function前置處理 name="statechange.before"
   IF g_prea_m.preastus = 'X' OR g_prea_m.preastus = 'Y' THEN
      RETURN
   END IF
   #end add-point  
   
   ERROR ""     #清空畫面右下側ERROR區塊
 
   IF g_prea_m.preadocno IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code   = "std-00003" 
      LET g_errparam.popup  = FALSE 
      CALL cl_err()
      RETURN
   END IF
 
   CALL s_transaction_begin()
   
   OPEN aprt310_cl USING g_enterprise,g_prea_m.preadocno
   IF STATUS THEN
      CLOSE aprt310_cl
      CALL s_transaction_end('N','0')
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "OPEN aprt310_cl:" 
      LET g_errparam.code   = STATUS 
      LET g_errparam.popup  = TRUE 
      CALL cl_err()
      RETURN
   END IF
   
   #顯示最新的資料
   EXECUTE aprt310_master_referesh USING g_prea_m.preadocno INTO g_prea_m.preasite,g_prea_m.preadocdt, 
       g_prea_m.preadocno,g_prea_m.prea000,g_prea_m.preaunit,g_prea_m.prea001,g_prea_m.prea002,g_prea_m.preaacti, 
       g_prea_m.preastus,g_prea_m.prea003,g_prea_m.prea004,g_prea_m.prea052,g_prea_m.prea005,g_prea_m.prea006, 
       g_prea_m.prea051,g_prea_m.prea008,g_prea_m.prea007,g_prea_m.prea009,g_prea_m.prea010,g_prea_m.prea013, 
       g_prea_m.prea050,g_prea_m.prea011,g_prea_m.prea012,g_prea_m.prea014,g_prea_m.prea015,g_prea_m.preaownid, 
       g_prea_m.preaowndp,g_prea_m.preacrtid,g_prea_m.preacrtdp,g_prea_m.preacrtdt,g_prea_m.preamodid, 
       g_prea_m.preamoddt,g_prea_m.preacnfid,g_prea_m.preacnfdt,g_prea_m.preapstid,g_prea_m.preapstdt, 
       g_prea_m.prea003_desc,g_prea_m.prea006_desc,g_prea_m.prea008_desc,g_prea_m.prea007_desc,g_prea_m.prea009_desc, 
       g_prea_m.prea010_desc,g_prea_m.prea011_desc,g_prea_m.prea012_desc,g_prea_m.preaownid_desc,g_prea_m.preaowndp_desc, 
       g_prea_m.preacrtid_desc,g_prea_m.preacrtdp_desc,g_prea_m.preamodid_desc,g_prea_m.preacnfid_desc, 
       g_prea_m.preapstid_desc
   
 
   #檢查是否允許此動作
   IF NOT aprt310_action_chk() THEN
      CLOSE aprt310_cl
      CALL s_transaction_end('N','0')
      RETURN
   END IF
 
   #將資料顯示到畫面上
   DISPLAY BY NAME g_prea_m.preasite,g_prea_m.preasite_desc,g_prea_m.preadocdt,g_prea_m.preadocno,g_prea_m.prea000, 
       g_prea_m.preaunit,g_prea_m.prea001,g_prea_m.prea002,g_prea_m.preal002,g_prea_m.preaacti,g_prea_m.preastus, 
       g_prea_m.prea003,g_prea_m.prea003_desc,g_prea_m.prea004,g_prea_m.prea052,g_prea_m.prea005,g_prea_m.prea006, 
       g_prea_m.prea006_desc,g_prea_m.preb003_1,g_prea_m.preb004_1,g_prea_m.prea051,g_prea_m.prea008, 
       g_prea_m.prea008_desc,g_prea_m.prea007,g_prea_m.prea007_desc,g_prea_m.prea009,g_prea_m.prea009_desc, 
       g_prea_m.prea010,g_prea_m.prea010_desc,g_prea_m.preb005_1,g_prea_m.preb006_1,g_prea_m.prea013, 
       g_prea_m.prea050,g_prea_m.prea011,g_prea_m.prea011_desc,g_prea_m.prea012,g_prea_m.prea012_desc, 
       g_prea_m.prea014,g_prea_m.prea015,g_prea_m.preb007_1,g_prea_m.preb008_1,g_prea_m.preaownid,g_prea_m.preaownid_desc, 
       g_prea_m.preaowndp,g_prea_m.preaowndp_desc,g_prea_m.preacrtid,g_prea_m.preacrtid_desc,g_prea_m.preacrtdp, 
       g_prea_m.preacrtdp_desc,g_prea_m.preacrtdt,g_prea_m.preamodid,g_prea_m.preamodid_desc,g_prea_m.preamoddt, 
       g_prea_m.preacnfid,g_prea_m.preacnfid_desc,g_prea_m.preacnfdt,g_prea_m.preapstid,g_prea_m.preapstid_desc, 
       g_prea_m.preapstdt
 
   CASE g_prea_m.preastus
      WHEN "N"
         CALL gfrm_curr.setElementImage("statechange", "stus/32/unconfirmed.png")
      WHEN "Y"
         CALL gfrm_curr.setElementImage("statechange", "stus/32/confirmed.png")
      WHEN "A"
         CALL gfrm_curr.setElementImage("statechange", "stus/32/approved.png")
      WHEN "D"
         CALL gfrm_curr.setElementImage("statechange", "stus/32/withdraw.png")
      WHEN "R"
         CALL gfrm_curr.setElementImage("statechange", "stus/32/rejection.png")
      WHEN "W"
         CALL gfrm_curr.setElementImage("statechange", "stus/32/signing.png")
      WHEN "X"
         CALL gfrm_curr.setElementImage("statechange", "stus/32/invalid.png")
      
   END CASE
 
   #add-point:資料刷新後 name="statechange.after_refresh"
   
   #end add-point
 
   MENU "" ATTRIBUTES (STYLE="popup")
      BEFORE MENU
         HIDE OPTION "approved"
         HIDE OPTION "rejection"
         CASE g_prea_m.preastus
            
            WHEN "N"
               HIDE OPTION "unconfirmed"
            WHEN "Y"
               HIDE OPTION "confirmed"
            WHEN "A"
               HIDE OPTION "approved"
            WHEN "D"
               HIDE OPTION "withdraw"
            WHEN "R"
               HIDE OPTION "rejection"
            WHEN "W"
               HIDE OPTION "signing"
            WHEN "X"
               HIDE OPTION "invalid"
         END CASE
     
      #add-point:menu前 name="statechange.before_menu"
      CALL cl_set_act_visible("released", FALSE)
      #160604-00001#1 -e by 08172
      CALL cl_set_act_visible("signing,withdraw",FALSE)
      CALL cl_set_act_visible("unconfirmed,invalid,confirmed",TRUE)
      
      CASE g_prea_m.preastus
         WHEN "N"
            CALL cl_set_act_visible("open,unconfirmed",FALSE)
            #需提交至BPM時，則顯示「提交」功能並隱藏「確認」功能
            IF cl_bpm_chk() THEN
                CALL cl_set_act_visible("signing",TRUE)
                CALL cl_set_act_visible("confirmed",FALSE)
            END IF
         WHEN "R"   #保留修改的功能(如作廢)，隱藏其他應用功能(如: 確認、未確認、留置、過帳…)
            CALL cl_set_act_visible("confirmed,unconfirmed",FALSE)

         WHEN "D"   #保留修改的功能(如作廢)，隱藏其他應用功能(如: 確認、未確認、留置、過帳…)
            CALL cl_set_act_visible("confirmed,unconfirmed",FALSE)
         WHEN "W"    #只能顯示抽單;其餘應用功能皆隱藏
             CALL cl_set_act_visible("withdraw",TRUE)  
             CALL cl_set_act_visible("unconfirmed,invalid,confirmed",FALSE)
         
         WHEN "A"     #只能顯示確認; 其餘應用功能皆隱藏
             CALL cl_set_act_visible("confirmed ",TRUE)  
             CALL cl_set_act_visible("unconfirmed,invalid",FALSE)
            
         WHEN "Y"
            CALL cl_set_act_visible("open,invalid,confirmed",FALSE)

         WHEN "X"
            CALL cl_set_act_visible("invalid,confirmed",FALSE)
      
      END CASE
      #160604-00001#1 -e by 08172
      #end add-point
      
      #應用 a36 樣板自動產生(Version:5)
      #提交
      ON ACTION signing
         IF cl_auth_chk_act("signing") THEN
            IF NOT aprt310_send() THEN
               CALL s_transaction_end('N','0')
            ELSE
               CALL s_transaction_end('Y','0')
            END IF
            #因應簽核行為, 該動作完成後不再進行後續處理
            #於此處直接返回
            CLOSE aprt310_cl
            RETURN
         END IF
    
      #抽單
      ON ACTION withdraw
         IF cl_auth_chk_act("withdraw") THEN
            IF NOT aprt310_draw_out() THEN
               CALL s_transaction_end('N','0')
            ELSE
               CALL s_transaction_end('Y','0')
            END IF
            #因應簽核行為, 該動作完成後不再進行後續處理
            #於此處直接返回
            CLOSE aprt310_cl
            RETURN
         END IF
 
 
 
	  
      ON ACTION unconfirmed
         IF cl_auth_chk_act("unconfirmed") THEN
            LET lc_state = "N"
            #add-point:action控制 name="statechange.unconfirmed"
            
            #end add-point
         END IF
         EXIT MENU
      ON ACTION confirmed
         IF cl_auth_chk_act("confirmed") THEN
            LET lc_state = "Y"
            #add-point:action控制 name="statechange.confirmed"
            #確認時間大約發佈時間，直接發佈
#            IF g_today>g_prea_m.prea014 OR (g_today=g_prea_m.prea014 AND g_time>g_prea_m.prea015)  THEN            
#               LET lc_state = "F"
#            END IF

            LET l_success = TRUE
            CALL s_transaction_begin()
            #160604-00001#1 -s by 08172
#            CALL aprt310_conf_chk() RETURNING l_success,g_errno,l_chr50
#            IF NOT l_success THEN
#               IF cl_null(l_chr50) THEN
#                  LET l_chr50=g_prea_m.preadocno
#               END IF                  
#               INITIALIZE g_errparam TO NULL
#               LET g_errparam.code = g_errno
#               LET g_errparam.extend = l_chr50
#               LET g_errparam.popup = TRUE
#               CALL cl_err()
#            
#               CALL s_transaction_end('N','0')
#               RETURN
#            ELSE
#               IF NOT cl_ask_confirm('aim-00108') THEN
#                  CALL s_transaction_end('N','0')
#                  RETURN
#               ELSE
#                  CALL aprt310_conf_upd() RETURNING l_success
#                  IF NOT l_success THEN
#                     CALL s_transaction_end('N','0')
#                     RETURN
#                  END IF
#               END IF
#            END IF
            CALL s_aprt310_conf_chk(g_prea_m.preadocno) RETURNING l_success
            IF NOT l_success THEN
               CALL s_transaction_end('N','0')
               RETURN
            ELSE
               IF NOT cl_ask_confirm('aim-00108') THEN
                  CALL s_transaction_end('N','0')
                  RETURN
               ELSE
                  CALL s_aprt310_conf_upd(g_prea_m.preadocno) RETURNING l_success
                  IF NOT l_success THEN
                     CALL s_transaction_end('N','0')
                     RETURN
                  END IF
               END IF
            END IF
            #160604-00001#1 -e by 08172
            LET l_time = cl_get_current()
            UPDATE prea_t SET preacnfid = g_user,
                              preacnfdt = l_time                             
             WHERE preaent = g_enterprise 
               AND preadocno = g_prea_m.preadocno
            #end add-point
         END IF
         EXIT MENU
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
      ON ACTION invalid
         IF cl_auth_chk_act("invalid") THEN
            LET lc_state = "X"
            #add-point:action控制 name="statechange.invalid"
             IF NOT cl_ask_confirm('aim-00109') THEN
                CALL s_transaction_end('N','0')   #160816-00068#12 by 08209 add
                RETURN
             END IF
            #end add-point
         END IF
         EXIT MENU
 
      #add-point:stus控制 name="statechange.more_control"
      
      #end add-point
      
   END MENU
   
   #確認被選取的狀態碼在清單中
   IF (lc_state <> "N" 
      AND lc_state <> "Y"
      AND lc_state <> "A"
      AND lc_state <> "D"
      AND lc_state <> "R"
      AND lc_state <> "W"
      AND lc_state <> "X"
      ) OR 
      g_prea_m.preastus = lc_state OR cl_null(lc_state) THEN
      CLOSE aprt310_cl
      CALL s_transaction_end('N','0')
      RETURN
   END IF
   
   #add-point:stus修改前 name="statechange.b_update"
   
   #end add-point
   
   LET g_prea_m.preamodid = g_user
   LET g_prea_m.preamoddt = cl_get_current()
   LET g_prea_m.preastus = lc_state
   
   #異動狀態碼欄位/修改人/修改日期
   UPDATE prea_t 
      SET (preastus,preamodid,preamoddt) 
        = (g_prea_m.preastus,g_prea_m.preamodid,g_prea_m.preamoddt)     
    WHERE preaent = g_enterprise AND preadocno = g_prea_m.preadocno
 
    
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code   = SQLCA.sqlcode 
      LET g_errparam.popup  = FALSE 
      CALL cl_err()
   ELSE
      CASE lc_state
         WHEN "N"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/unconfirmed.png")
         WHEN "Y"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/confirmed.png")
         WHEN "A"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/approved.png")
         WHEN "D"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/withdraw.png")
         WHEN "R"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/rejection.png")
         WHEN "W"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/signing.png")
         WHEN "X"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/invalid.png")
         
      END CASE
    
      #撈取異動後的資料
      EXECUTE aprt310_master_referesh USING g_prea_m.preadocno INTO g_prea_m.preasite,g_prea_m.preadocdt, 
          g_prea_m.preadocno,g_prea_m.prea000,g_prea_m.preaunit,g_prea_m.prea001,g_prea_m.prea002,g_prea_m.preaacti, 
          g_prea_m.preastus,g_prea_m.prea003,g_prea_m.prea004,g_prea_m.prea052,g_prea_m.prea005,g_prea_m.prea006, 
          g_prea_m.prea051,g_prea_m.prea008,g_prea_m.prea007,g_prea_m.prea009,g_prea_m.prea010,g_prea_m.prea013, 
          g_prea_m.prea050,g_prea_m.prea011,g_prea_m.prea012,g_prea_m.prea014,g_prea_m.prea015,g_prea_m.preaownid, 
          g_prea_m.preaowndp,g_prea_m.preacrtid,g_prea_m.preacrtdp,g_prea_m.preacrtdt,g_prea_m.preamodid, 
          g_prea_m.preamoddt,g_prea_m.preacnfid,g_prea_m.preacnfdt,g_prea_m.preapstid,g_prea_m.preapstdt, 
          g_prea_m.prea003_desc,g_prea_m.prea006_desc,g_prea_m.prea008_desc,g_prea_m.prea007_desc,g_prea_m.prea009_desc, 
          g_prea_m.prea010_desc,g_prea_m.prea011_desc,g_prea_m.prea012_desc,g_prea_m.preaownid_desc, 
          g_prea_m.preaowndp_desc,g_prea_m.preacrtid_desc,g_prea_m.preacrtdp_desc,g_prea_m.preamodid_desc, 
          g_prea_m.preacnfid_desc,g_prea_m.preapstid_desc
      
      #將資料顯示到畫面上
      DISPLAY BY NAME g_prea_m.preasite,g_prea_m.preasite_desc,g_prea_m.preadocdt,g_prea_m.preadocno, 
          g_prea_m.prea000,g_prea_m.preaunit,g_prea_m.prea001,g_prea_m.prea002,g_prea_m.preal002,g_prea_m.preaacti, 
          g_prea_m.preastus,g_prea_m.prea003,g_prea_m.prea003_desc,g_prea_m.prea004,g_prea_m.prea052, 
          g_prea_m.prea005,g_prea_m.prea006,g_prea_m.prea006_desc,g_prea_m.preb003_1,g_prea_m.preb004_1, 
          g_prea_m.prea051,g_prea_m.prea008,g_prea_m.prea008_desc,g_prea_m.prea007,g_prea_m.prea007_desc, 
          g_prea_m.prea009,g_prea_m.prea009_desc,g_prea_m.prea010,g_prea_m.prea010_desc,g_prea_m.preb005_1, 
          g_prea_m.preb006_1,g_prea_m.prea013,g_prea_m.prea050,g_prea_m.prea011,g_prea_m.prea011_desc, 
          g_prea_m.prea012,g_prea_m.prea012_desc,g_prea_m.prea014,g_prea_m.prea015,g_prea_m.preb007_1, 
          g_prea_m.preb008_1,g_prea_m.preaownid,g_prea_m.preaownid_desc,g_prea_m.preaowndp,g_prea_m.preaowndp_desc, 
          g_prea_m.preacrtid,g_prea_m.preacrtid_desc,g_prea_m.preacrtdp,g_prea_m.preacrtdp_desc,g_prea_m.preacrtdt, 
          g_prea_m.preamodid,g_prea_m.preamodid_desc,g_prea_m.preamoddt,g_prea_m.preacnfid,g_prea_m.preacnfid_desc, 
          g_prea_m.preacnfdt,g_prea_m.preapstid,g_prea_m.preapstid_desc,g_prea_m.preapstdt
   END IF
 
   #add-point:stus修改後 name="statechange.a_update"
   
   #end add-point
 
   #add-point:statechange段結束前 name="statechange.after"
   
   #end add-point  
 
   CLOSE aprt310_cl
   CALL s_transaction_end('Y','0')
 
   #功能已完成,通報訊息中心
   CALL aprt310_msgcentre_notify('statechange:'||lc_state)
   
END FUNCTION
 
 
 
 
{</section>}
 
{<section id="aprt310.idx_chk" >}
#+ 顯示正確的單身資料筆數
PRIVATE FUNCTION aprt310_idx_chk()
   #add-point:idx_chk段define(客製用) name="idx_chk.define_customerization"
   
   #end add-point  
   #add-point:idx_chk段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="idx_chk.define"
   
   #end add-point  
   
   #add-point:Function前置處理  name="idx_chk.pre_function"
   
   #end add-point
   
   IF g_current_page = 1 THEN
      LET g_detail_idx = g_curr_diag.getCurrentRow("s_detail1")
      IF g_detail_idx > g_prec_d.getLength() THEN
         LET g_detail_idx = g_prec_d.getLength()
      END IF
      IF g_detail_idx = 0 AND g_prec_d.getLength() <> 0 THEN
         LET g_detail_idx = 1
      END IF
      DISPLAY g_detail_idx TO FORMONLY.idx
      DISPLAY g_prec_d.getLength() TO FORMONLY.cnt
   END IF
   
   IF g_current_page = 2 THEN
      LET g_detail_idx = g_curr_diag.getCurrentRow("s_detail2")
      IF g_detail_idx > g_prec2_d.getLength() THEN
         LET g_detail_idx = g_prec2_d.getLength()
      END IF
      IF g_detail_idx = 0 AND g_prec2_d.getLength() <> 0 THEN
         LET g_detail_idx = 1
      END IF
      DISPLAY g_detail_idx TO FORMONLY.idx
      DISPLAY g_prec2_d.getLength() TO FORMONLY.cnt
   END IF
   IF g_current_page = 3 THEN
      LET g_detail_idx = g_curr_diag.getCurrentRow("s_detail3")
      IF g_detail_idx > g_prec3_d.getLength() THEN
         LET g_detail_idx = g_prec3_d.getLength()
      END IF
      IF g_detail_idx = 0 AND g_prec3_d.getLength() <> 0 THEN
         LET g_detail_idx = 1
      END IF
      DISPLAY g_detail_idx TO FORMONLY.idx
      DISPLAY g_prec3_d.getLength() TO FORMONLY.cnt
   END IF
   IF g_current_page = 4 THEN
      LET g_detail_idx = g_curr_diag.getCurrentRow("s_detail4")
      IF g_detail_idx > g_prec4_d.getLength() THEN
         LET g_detail_idx = g_prec4_d.getLength()
      END IF
      IF g_detail_idx = 0 AND g_prec4_d.getLength() <> 0 THEN
         LET g_detail_idx = 1
      END IF
      DISPLAY g_detail_idx TO FORMONLY.idx
      DISPLAY g_prec4_d.getLength() TO FORMONLY.cnt
   END IF
 
   
   #add-point:idx_chk段other name="idx_chk.other"
   
   #end add-point  
   
END FUNCTION
 
{</section>}
 
{<section id="aprt310.b_fill2" >}
#+ 單身陣列填充2
PRIVATE FUNCTION aprt310_b_fill2(pi_idx)
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
   
   CALL aprt310_detail_show()
   
   LET g_detail_idx = li_detail_idx_tmp
   
END FUNCTION
 
{</section>}
 
{<section id="aprt310.fill_chk" >}
#+ 單身填充確認
PRIVATE FUNCTION aprt310_fill_chk(ps_idx)
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
   IF (cl_null(g_wc2_table1) OR g_wc2_table1.trim() = '1=1')  AND 
      (cl_null(g_wc2_table2) OR g_wc2_table2.trim() = '1=1')  AND 
      (cl_null(g_wc2_table3) OR g_wc2_table3.trim() = '1=1') THEN
      #add-point:fill_chk段other_chk name="fill_chk.other_chk"
      
      #end add-point
      RETURN TRUE
   END IF
   
   #add-point:fill_chk段after_chk name="fill_chk.after_chk"
   
   #end add-point
   
   RETURN TRUE
 
END FUNCTION
 
{</section>}
 
{<section id="aprt310.status_show" >}
PRIVATE FUNCTION aprt310_status_show()
   #add-point:status_show段define(客製用) name="status_show.define_customerization"
   
   #end add-point
   #add-point:status_show段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="status_show.define"
   
   #end add-point
   
   #add-point:status_show段status_show name="status_show.status_show"
   
   #end add-point
END FUNCTION
 
{</section>}
 
{<section id="aprt310.mask_functions" >}
&include "erp/apr/aprt310_mask.4gl"
 
{</section>}
 
{<section id="aprt310.signature" >}
   #應用 a39 樣板自動產生(Version:10)
#+ BPM提交
PRIVATE FUNCTION aprt310_send()
   #add-point:send段define(客製用) name="send.define_customerization"
   
   #end add-point 
   #add-point:send段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="send.define"
   DEFINE l_success   LIKE type_t.num5
   DEFINE l_chr50   LIKE type_t.num5
   #end add-point 
   
   #add-point:Function前置處理  name="send.pre_function"
   
   #end add-point
   
   #依據單據個數，需要指定所有單身條件為" 1=1"  (單身有幾個就要設幾個)
   LET g_wc2_table1 = " 1=1"
   LET g_wc2_table2 = " 1=1"
   LET g_wc2_table3 = " 1=1"
 
 
   CALL aprt310_show()
   CALL aprt310_set_pk_array()
   
   #add-point: 初始化的ADP name="send.before_send"
   #160604-00001#1 -s by 08172
   CALL aprt310_conf_chk() RETURNING l_success,g_errno,l_chr50
   IF NOT l_success THEN
      IF cl_null(l_chr50) THEN
         LET l_chr50=g_prea_m.preadocno
      END IF                  
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = g_errno
      LET g_errparam.extend = l_chr50
      LET g_errparam.popup = TRUE
      CALL cl_err()
      RETURN FALSE
   END IF 
   #160604-00001#1 -e by 08172 
   #end add-point
   
   #公用變數初始化
   CALL cl_bpm_data_init()
                  
   #依照主檔/單身個數產生 CALL cl_bpm_set_master_data() / cl_bpm_set_detail_data() 
   #單頭固定為 CALL cl_bpm_set_master_data(util.JSONObject.fromFGL(xxxx)) 傳入參數: (1)單頭陣列  ; 回傳值: 無
   CALL cl_bpm_set_master_data(util.JSONObject.fromFGL(g_prea_m))
                              
   #單身固定為 CALL cl_bpm_set_detail_data(s_detailX, util.JSONArray.fromFGL(xxxx)) 傳入參數: (1)單身SR名稱  (2)單身陣列  ; 回傳值: 無
   CALL cl_bpm_set_detail_data("s_detail1", util.JSONArray.fromFGL(g_prec_d))
   CALL cl_bpm_set_detail_data("s_detail2", util.JSONArray.fromFGL(g_prec2_d))
   CALL cl_bpm_set_detail_data("s_detail3", util.JSONArray.fromFGL(g_prec3_d))
   CALL cl_bpm_set_detail_data("s_detail4", util.JSONArray.fromFGL(g_prec4_d))
 
 
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
   #CALL aprt310_ui_browser_refresh()
 
   #重新指定此筆單據資料狀態圖片=>送簽中
   LET g_browser[g_current_idx].b_statepic = "stus/16/signing.png"
 
   #重新取得單頭/單身資料,DISPLAY在畫面上
   CALL aprt310_ui_headershow()
   CALL aprt310_ui_detailshow()
 
   RETURN TRUE
   
END FUNCTION
 
 
 
#應用 a40 樣板自動產生(Version:9)
#+ BPM抽單
PRIVATE FUNCTION aprt310_draw_out()
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
   CALL aprt310_ui_headershow()  
   CALL aprt310_ui_detailshow()
 
   #add-point:Function後置處理  name="draw.after_function"
   
   #end add-point
 
   RETURN TRUE
   
END FUNCTION
 
 
 
 
 
{</section>}
 
{<section id="aprt310.set_pk_array" >}
   #應用 a51 樣板自動產生(Version:8)
#+ 給予pk_array內容
PRIVATE FUNCTION aprt310_set_pk_array()
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
   LET g_pk_array[1].values = g_prea_m.preadocno
   LET g_pk_array[1].column = 'preadocno'
 
   
   #add-point:set_pk_array段之後 name="set_pk_array.after"
   
   #end add-point  
   
END FUNCTION
 
 
 
 
{</section>}
 
{<section id="aprt310.other_dialog" readonly="Y" >}
   
 
{</section>}
 
{<section id="aprt310.msgcentre_notify" >}
#應用 a66 樣板自動產生(Version:6)
PRIVATE FUNCTION aprt310_msgcentre_notify(lc_state)
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
   CALL aprt310_set_pk_array()
   #單頭資料填寫
   LET g_msgparam.data[1] = util.JSON.stringify(g_prea_m)
 
   #add-point:msgcentre其他通知 name="msgcentre_notify.process"
   
   #end add-point
 
   #呼叫訊息中心傳遞本關完成訊息
   CALL cl_msgcentre_notify()
 
END FUNCTION
 
 
 
 
{</section>}
 
{<section id="aprt310.action_chk" >}
#+ 修改/刪除前行為檢查(是否可允許此動作), 若有其他行為須管控也可透過此段落
PRIVATE FUNCTION aprt310_action_chk()
   #add-point:action_chk段define(客製用) name="action_chk.define_customerization"
   
   #end add-point
   #add-point:action_chk段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="action_chk.define"
   
   #end add-point
   
   #add-point:action_chk段action_chk name="action_chk.action_chk"
   #160818-00017#31 add-S
   SELECT preastus  INTO g_prea_m.preastus
     FROM prea_t
    WHERE preaent = g_enterprise
      AND preadocno = g_prea_m.preadocno

  IF(g_action_choice="modify" OR g_action_choice="delete" OR g_action_choice="modify_detail")  THEN
     LET g_errno = NULL
     CASE g_prea_m.preastus
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
        LET g_errparam.extend = g_prea_m.preadocno
        LET g_errparam.popup = TRUE
        CALL cl_err()
        LET g_errno = NULL
        CALL aprt310_set_act_visible()
        CALL aprt310_set_act_no_visible()
        CALL aprt310_show()
        RETURN FALSE
     END IF
   END IF
   #160818-00017#31 add-E
   #end add-point
      
   RETURN TRUE
   
END FUNCTION
 
{</section>}
 
{<section id="aprt310.other_function" readonly="Y" >}

################################################################################
# Descriptions...: 規則編號檢查
# Memo...........:
# Usage..........: CALL aprt310_chk_prea001()
# Input parameter: 無
# Return code....: 無
# Date & Author..: 2015/05/18 By huangrh
# Modify.........:
################################################################################
PRIVATE FUNCTION aprt310_chk_prea001()
DEFINE l_n              LIKE type_t.num5
DEFINE l_pregstus       LIKE preg_t.pregstus

   LET g_errno = ""
   
   IF g_prea_m.prea000 = 'I' THEN
      LET l_n = 0
      SELECT COUNT(*) INTO l_n
        FROM preg_t
       WHERE pregent = g_enterprise
         AND preg001 = g_prea_m.prea001
      IF l_n > 0 THEN
         LET g_errno = 'apr-00394'
         RETURN
      END IF
      LET l_n = 0
      SELECT COUNT(*) INTO l_n
        FROM prea_t
       WHERE preaent = g_enterprise
         AND prea001 = g_prea_m.prea001
         AND preadocno <> g_prea_m.preadocno
      IF l_n > 0 THEN
         LET g_errno = 'apr-00381'
         RETURN
      END IF
   END IF
   IF g_prea_m.prea000 = 'U' THEN
      LET l_n = 0
      SELECT COUNT(*) INTO l_n
        FROM preg_t
       WHERE pregent = g_enterprise
         AND preg001 = g_prea_m.prea001
      IF l_n = 0 THEN
         LET g_errno = 'apr-00395'
         RETURN
      END IF
      LET l_pregstus = ''
      SELECT pregstus INTO l_pregstus
        FROM preg_t
       WHERE pregent = g_enterprise
         AND preg001 = g_prea_m.prea001
      IF l_pregstus = 'X' THEN
         LET g_errno = 'apr-00396'
         RETURN
      END IF
      IF l_pregstus = 'N' THEN
         LET g_errno = 'apr-00397'
         RETURN
      END IF
      IF l_pregstus = 'F' THEN
         LET g_errno = 'apr-00393'
         RETURN
      END IF

   END IF
END FUNCTION

################################################################################
# Descriptions...: 預設單頭資料
# Memo...........:
# Usage..........: CALL aprt310_prea000_init()
# Input parameter: 無
# Return code....: 無
# Date & Author..: 2015/05/18 By huangrh
# Modify.........:
################################################################################
PRIVATE FUNCTION aprt310_prea000_init()
DEFINE r_success     LIKE type_t.num5
DEFINE r_doctype     LIKE rtai_t.rtai004
DEFINE l_insert      LIKE type_t.num5
   
      IF cl_null(g_prea_m.prea001) THEN
         RETURN
      END IF
      INITIALIZE g_prea_m.preaacti,g_prea_m.prea013,g_prea_m.preadocdt,g_prea_m.prea011,g_prea_m.prea012,
                 g_prea_m.preb003_1,g_prea_m.preb004_1,g_prea_m.preb005_1,g_prea_m.preb006_1,g_prea_m.preb007_1,
                 g_prea_m.preb008_1,g_prea_m.prea003,g_prea_m.prea004,g_prea_m.prea005,g_prea_m.prea006,
                 g_prea_m.prea007,g_prea_m.prea008,g_prea_m.prea009,g_prea_m.prea010,g_prea_m.prea014,g_prea_m.prea015,
                 g_prea_m.preal002,g_prea_m.prea050,g_prea_m.prea052  TO NULL 

 
      LET g_prea_m.preaacti = "Y"
      LET g_prea_m.prea013 = "N"
      LET g_prea_m.preadocdt = g_today
      LET g_prea_m.prea011 = g_user
      LET g_prea_m.prea012 = g_dept
      LET g_prea_m.preb005_1 = '00:00:00'
      LET g_prea_m.preb006_1 = '23:59:59'
      LET g_prea_m.prea014 = g_today
      LET g_prea_m.prea015 = '00:00:00' 
      LET g_prea_m.prea050 ='Y'      
      
      IF g_prea_m.prea013 = 'Y' THEN
         CALL cl_set_comp_visible("page_5", TRUE)
         CALL cl_set_comp_visible("lbl_preb003", FALSE)
         CALL cl_set_comp_visible("lbl_preb004", FALSE)
         CALL cl_set_comp_visible("lbl_preb005", FALSE)
         CALL cl_set_comp_visible("lbl_preb006", FALSE)
         CALL cl_set_comp_visible("lbl_preb007", FALSE)
         CALL cl_set_comp_visible("lbl_preb008", FALSE)
         CALL cl_set_comp_visible("preb003_1", FALSE)
         CALL cl_set_comp_visible("preb004_1", FALSE)
         CALL cl_set_comp_visible("preb005_1", FALSE)
         CALL cl_set_comp_visible("preb006_1", FALSE)
         CALL cl_set_comp_visible("preb007_1", FALSE)
         CALL cl_set_comp_visible("preb008_1", FALSE) 
         
      ELSE
         CALL cl_set_comp_visible("page_5", FALSE)
         CALL cl_set_comp_visible("lbl_preb003", TRUE)
         CALL cl_set_comp_visible("lbl_preb004", TRUE)
         CALL cl_set_comp_visible("lbl_preb005", TRUE)
         CALL cl_set_comp_visible("lbl_preb006", TRUE)
         CALL cl_set_comp_visible("lbl_preb007", TRUE)
         CALL cl_set_comp_visible("lbl_preb008", TRUE)
         CALL cl_set_comp_visible("preb003_1", TRUE)
         CALL cl_set_comp_visible("preb004_1", TRUE)
         CALL cl_set_comp_visible("preb005_1", TRUE)
         CALL cl_set_comp_visible("preb006_1", TRUE)
         CALL cl_set_comp_visible("preb007_1", TRUE)
         CALL cl_set_comp_visible("preb008_1", TRUE)          
      END IF
      
      DISPLAY BY NAME g_prea_m.preasite,g_prea_m.preasite_desc,g_prea_m.preadocdt,g_prea_m.preadocno,g_prea_m.prea000, 
          g_prea_m.prea001,g_prea_m.prea002,g_prea_m.preal002,g_prea_m.preaacti,g_prea_m.preastus,g_prea_m.prea003, 
          g_prea_m.prea003_desc,g_prea_m.prea004,g_prea_m.prea005,g_prea_m.prea006,g_prea_m.prea006_desc, 
          g_prea_m.preb003_1,g_prea_m.preb004_1,g_prea_m.prea007,g_prea_m.prea007_desc,g_prea_m.prea008, 
          g_prea_m.prea008_desc,g_prea_m.prea009,g_prea_m.prea009_desc,g_prea_m.prea010,g_prea_m.prea010_desc, 
          g_prea_m.preb005_1,g_prea_m.preb006_1,g_prea_m.prea011,g_prea_m.prea011_desc,g_prea_m.prea012, 
          g_prea_m.prea012_desc,g_prea_m.prea014,g_prea_m.prea013,g_prea_m.preb007_1,g_prea_m.preaunit, 
          g_prea_m.preb008_1,g_prea_m.preaownid,g_prea_m.preaownid_desc,g_prea_m.preaowndp,g_prea_m.preaowndp_desc, 
          g_prea_m.preacrtid,g_prea_m.preacrtid_desc,g_prea_m.preacrtdp,g_prea_m.preacrtdp_desc,g_prea_m.preacrtdt, 
          g_prea_m.preamodid,g_prea_m.preamodid_desc,g_prea_m.preamoddt,g_prea_m.preacnfid,g_prea_m.preacnfid_desc, 
          g_prea_m.preacnfdt,g_prea_m.preapstid,g_prea_m.preapstid_desc,g_prea_m.preapstdt,g_prea_m.prea050,g_prea_m.prea052 
       
END FUNCTION

################################################################################
# Descriptions...: 預設單頭資料
# Memo...........:
# Usage..........: CALL aprt310_prea001_init()
# Input parameter: 無
# Return code....: 無
# Date & Author..: 2015/05/18 By huangrh
# Modify.........:
################################################################################
PRIVATE FUNCTION aprt310_prea001_init()
#161111-00028#4 --mdofy---begin--------
#DEFINE l_preg        RECORD LIKE preg_t.*
DEFINE l_preg RECORD  #促銷談判結果單頭資料表
       pregent LIKE preg_t.pregent, #企業編號
       pregunit LIKE preg_t.pregunit, #制定組織
       pregsite LIKE preg_t.pregsite, #營運組織
       pregstus LIKE preg_t.pregstus, #狀態碼
       preg001 LIKE preg_t.preg001, #規則編號
       preg002 LIKE preg_t.preg002, #版本
       preg003 LIKE preg_t.preg003, #促銷方案編號
       preg004 LIKE preg_t.preg004, #促銷方式
       preg005 LIKE preg_t.preg005, #換贈對象
       preg006 LIKE preg_t.preg006, #換贈編號
       preg007 LIKE preg_t.preg007, #活動計劃
       preg008 LIKE preg_t.preg008, #活動類型
       preg009 LIKE preg_t.preg009, #檔期類型
       preg010 LIKE preg_t.preg010, #活動等級
       preg011 LIKE preg_t.preg011, #申請人員
       preg012 LIKE preg_t.preg012, #申請部門
       preg013 LIKE preg_t.preg013, #日期高階設定
       preg014 LIKE preg_t.preg014, #發佈日期
       preg015 LIKE preg_t.preg015, #終止日期
       preg016 LIKE preg_t.preg016, #發布人員
       preg017 LIKE preg_t.preg017, #終止人員
       preg018 LIKE preg_t.preg018, #釋出時間
       pregownid LIKE preg_t.pregownid, #資料所屬者
       pregowndp LIKE preg_t.pregowndp, #資料所有部門
       pregcrtid LIKE preg_t.pregcrtid, #資料建立者
       pregcrtdp LIKE preg_t.pregcrtdp, #資料建立部門
       pregcrtdt LIKE preg_t.pregcrtdt, #資料創建日
       pregmodid LIKE preg_t.pregmodid, #資料修改者
       pregmoddt LIKE preg_t.pregmoddt, #最近修改日
       pregcnfid LIKE preg_t.pregcnfid, #資料確認者
       pregcnfdt LIKE preg_t.pregcnfdt, #資料確認日
       pregpstid LIKE preg_t.pregpstid, #資料過帳者
       pregpstdt LIKE preg_t.pregpstdt, #資料過帳日
       preg050 LIKE preg_t.preg050, #相同基數取最低
       preg051 LIKE preg_t.preg051, #主題分類
       preg052 LIKE preg_t.preg052  #促銷類型
       END RECORD

#161111-00028#4 --mdofy---end--------
DEFINE r_success     LIKE type_t.num5
DEFINE r_doctype     LIKE rtai_t.rtai004
DEFINE l_insert      LIKE type_t.num5

   IF cl_null(g_prea_m.prea000) OR cl_null(g_prea_m.prea001) THEN
      RETURN
   END IF 
   IF g_prea_m.prea000 = 'U' THEN
      INITIALIZE l_preg.* TO NULL
     #161111-00028#4 --mdofy---begin-------- 
     # SELECT * INTO l_preg.*
       SELECT pregent,pregunit,pregsite,pregstus,preg001,preg002,preg003,preg004,preg005,preg006,preg007,
              preg008,preg009,preg010,preg011,preg012,preg013,preg014,preg015,preg016,preg017,preg018,
              pregownid,pregowndp,pregcrtid,pregcrtdp,pregcrtdt,pregmodid,pregmoddt,pregcnfid,pregcnfdt,
              pregpstid,pregpstdt,preg050,preg051,preg052 INTO l_preg.*
     #161111-00028#4 --mdofy---end--------
        FROM preg_t
       WHERE pregent = g_enterprise
         AND preg001 = g_prea_m.prea001
      LET g_prea_m.prea001 = l_preg.preg001 
      LET g_prea_m.prea003 = l_preg.preg003
      LET g_prea_m.prea004 = l_preg.preg004
      LET g_prea_m.prea005 = l_preg.preg005
      LET g_prea_m.prea006 = l_preg.preg006
      LET g_prea_m.prea007 = l_preg.preg007
      LET g_prea_m.prea008 = l_preg.preg008
      LET g_prea_m.prea009 = l_preg.preg009
      LET g_prea_m.prea011 = l_preg.preg011
      LET g_prea_m.prea012 = l_preg.preg012 
      LET g_prea_m.prea013 = l_preg.preg013 
      LET g_prea_m.prea050 = l_preg.preg050 
      LET g_prea_m.prea051 = l_preg.preg051   
      LET g_prea_m.prea052 = l_preg.preg052      
 
      IF l_preg.pregstus = 'X' THEN
         LET g_prea_m.preaacti = 'N'
      ELSE
         LET g_prea_m.preaacti = 'Y'
      END IF
      
      SELECT pregl003 INTO  g_prea_m.preal002
        FROM pregl_t
       WHERE preglent = g_enterprise
         AND pregl001 = g_prea_m.prea001
         AND pregl002 =  g_dlang
      IF g_prea_m.prea013 = 'N' THEN
         SELECT preh003,preh004,preh005,preh006,preh007,preh008
           INTO g_prea_m.preb003_1,g_prea_m.preb004_1,g_prea_m.preb005_1,g_prea_m.preb006_1,g_prea_m.preb007_1,g_prea_m.preb008_1
           FROM preh_t
          WHERE prehent = g_enterprise
            AND preh001 = g_prea_m.prea001
            AND preh002 = 1
      END IF
   ELSE
      INITIALIZE g_prea_m.preaacti,g_prea_m.prea013,g_prea_m.preadocdt,g_prea_m.prea011,g_prea_m.prea012,
                 g_prea_m.preb003_1,g_prea_m.preb004_1,g_prea_m.preb005_1,g_prea_m.preb006_1,g_prea_m.preb007_1,
                 g_prea_m.preb008_1,g_prea_m.prea003,g_prea_m.prea004,g_prea_m.prea005,g_prea_m.prea006,
                 g_prea_m.prea007,g_prea_m.prea008,g_prea_m.prea009,g_prea_m.prea010,g_prea_m.prea014,g_prea_m.prea015,
                 g_prea_m.preal002,g_prea_m.prea052 TO NULL 

 
      LET g_prea_m.preaacti = "Y"
      LET g_prea_m.prea013 = "N"
      LET g_prea_m.preadocdt = g_today
      LET g_prea_m.prea011 = g_user
      LET g_prea_m.prea012 = g_dept
      LET g_prea_m.preb005_1 = '00:00:00'
      LET g_prea_m.preb006_1 = '23:59:59'
      LET g_prea_m.prea014 = g_today
      LET g_prea_m.prea015 = '00:00:00'      
      LET g_prea_m.prea050 ='Y'
      
 
   END IF
   IF g_prea_m.prea013 = 'Y' THEN
      CALL cl_set_comp_visible("page_5", TRUE)
      CALL cl_set_comp_visible("lbl_preb003", FALSE)
      CALL cl_set_comp_visible("lbl_preb004", FALSE)
      CALL cl_set_comp_visible("lbl_preb005", FALSE)
      CALL cl_set_comp_visible("lbl_preb006", FALSE)
      CALL cl_set_comp_visible("lbl_preb007", FALSE)
      CALL cl_set_comp_visible("lbl_preb008", FALSE)
      CALL cl_set_comp_visible("preb003_1", FALSE)
      CALL cl_set_comp_visible("preb004_1", FALSE)
      CALL cl_set_comp_visible("preb005_1", FALSE)
      CALL cl_set_comp_visible("preb006_1", FALSE)
      CALL cl_set_comp_visible("preb007_1", FALSE)
      CALL cl_set_comp_visible("preb008_1", FALSE) 
      
   ELSE
      CALL cl_set_comp_visible("page_5", FALSE)
      CALL cl_set_comp_visible("lbl_preb003", TRUE)
      CALL cl_set_comp_visible("lbl_preb004", TRUE)
      CALL cl_set_comp_visible("lbl_preb005", TRUE)
      CALL cl_set_comp_visible("lbl_preb006", TRUE)
      CALL cl_set_comp_visible("lbl_preb007", TRUE)
      CALL cl_set_comp_visible("lbl_preb008", TRUE)
      CALL cl_set_comp_visible("preb003_1", TRUE)
      CALL cl_set_comp_visible("preb004_1", TRUE)
      CALL cl_set_comp_visible("preb005_1", TRUE)
      CALL cl_set_comp_visible("preb006_1", TRUE)
      CALL cl_set_comp_visible("preb007_1", TRUE)
      CALL cl_set_comp_visible("preb008_1", TRUE)          
   END IF
   
   DISPLAY BY NAME g_prea_m.preasite,g_prea_m.preasite_desc,g_prea_m.preadocdt,g_prea_m.preadocno,g_prea_m.prea000, 
       g_prea_m.prea001,g_prea_m.prea002,g_prea_m.preal002,g_prea_m.preaacti,g_prea_m.preastus,g_prea_m.prea003, 
       g_prea_m.prea003_desc,g_prea_m.prea004,g_prea_m.prea005,g_prea_m.prea006,g_prea_m.prea006_desc, 
       g_prea_m.preb003_1,g_prea_m.preb004_1,g_prea_m.prea007,g_prea_m.prea007_desc,g_prea_m.prea008, 
       g_prea_m.prea008_desc,g_prea_m.prea009,g_prea_m.prea009_desc,g_prea_m.prea010,g_prea_m.prea010_desc, 
       g_prea_m.preb005_1,g_prea_m.preb006_1,g_prea_m.prea011,g_prea_m.prea011_desc,g_prea_m.prea012, 
       g_prea_m.prea012_desc,g_prea_m.prea014,g_prea_m.prea013,g_prea_m.preb007_1,g_prea_m.preaunit, 
       g_prea_m.preb008_1,g_prea_m.preaownid,g_prea_m.preaownid_desc,g_prea_m.preaowndp,g_prea_m.preaowndp_desc, 
       g_prea_m.preacrtid,g_prea_m.preacrtid_desc,g_prea_m.preacrtdp,g_prea_m.preacrtdp_desc,g_prea_m.preacrtdt, 
       g_prea_m.preamodid,g_prea_m.preamodid_desc,g_prea_m.preamoddt,g_prea_m.preacnfid,g_prea_m.preacnfid_desc, 
       g_prea_m.preacnfdt,g_prea_m.preapstid,g_prea_m.preapstid_desc,g_prea_m.preapstdt,g_prea_m.prea050,g_prea_m.prea052      
       
END FUNCTION

################################################################################
# Descriptions...: 更新prdd日期檔
# Memo...........:
# Usage..........: CALL aprt310_prdd()
# Input parameter: 
# Return code....: 
# Date & Author..: 20150522 By huangrh
# Modify.........:
################################################################################
PRIVATE FUNCTION aprt310_prdd()
DEFINE  l_n        LIKE type_t.num5 

   #日期
   IF g_prea_m.prea013 = 'N' THEN
      DELETE FROM preb_t WHERE prebent = g_enterprise AND prebdocno = g_prea_m.preadocno
      INSERT INTO preb_t(prebent,prebunit,prebsite,prebdocno,preb001,preb002,preb003,preb004,preb005,preb006,preb007,preb008,prebacti)
                  VALUES(g_enterprise,g_prea_m.preaunit,g_prea_m.preasite,g_prea_m.preadocno,g_prea_m.prea001,1,g_prea_m.preb003_1,g_prea_m.preb004_1,g_prea_m.preb005_1,g_prea_m.preb006_1,g_prea_m.preb007_1,g_prea_m.preb008_1,'Y')
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = 'ins preb'
         LET g_errparam.popup = TRUE
         CALL cl_err()
      END IF    
   END IF
  
   
END FUNCTION

################################################################################
# Descriptions...: 審核檢核
# Memo...........:
# Usage..........: CALL aprt310_conf_chk()
#                  RETURNING r_success,r_errno
# Input parameter: 
# Return code....: r_success      TRUE/FALSE
#                : r_errno        錯誤信息
#                : r_chr50        庫區編號
# Date & Author..: 20150525 By huangrh
# Modify.........:
################################################################################
PRIVATE FUNCTION aprt310_conf_chk()
DEFINE r_success       LIKE type_t.num5
DEFINE r_errno         STRING
DEFINE r_chr50         LIKE type_t.chr50
DEFINE l_pregstus      LIKE preg_t.pregstus
DEFINE l_count         LIKE type_t.num5
DEFINE l_prec003       LIKE prec_t.prec003
DEFINE l_flag          LIKE type_t.chr1
DEFINE l_inaa141       LIKE inaa_t.inaa141


   LET r_success=TRUE
   LET r_errno=''
   LET r_chr50=''
       
   #160604-00001#1 -s by 08172
   IF g_prea_m.preastus NOT MATCHES '[NA]' THEN  
      LET r_errno= 'sub-00697'
      LET r_success = FALSE
      RETURN r_success,r_errno,r_chr50
   END IF
   #160604-00001#1 -s by 08172
   SELECT pregstus INTO l_pregstus
     FROM preg_t
    WHERE pregent = g_enterprise
      AND preg001 = g_prea_m.prea001
   IF NOT cl_null(l_pregstus) AND l_pregstus='F' THEN
      LET r_success = FALSE
      LET r_errno='apr-00393'
       
      RETURN r_success,r_errno,r_chr50
   END IF   

#无单身资料不可以审核
   LET l_count=0 
   SELECT count(*) INTO l_count
     FROM prec_t
    WHERE precent=g_enterprise
      AND precdocno=g_prea_m.preadocno
   IF cl_null(l_count) OR l_count=0 THEN
      LET r_success = FALSE
      LET r_errno='apr-00451'           
      RETURN r_success,r_errno,r_chr50
   END IF        
      



#如果基本资料单身"保底方式" 不为1.无保底,无目标,一定要有對應的促銷保底設置
   LET l_count=0 
   SELECT count(*) INTO l_count
     FROM prec_t
    WHERE precent=g_enterprise
      AND precdocno=g_prea_m.preadocno
      AND prec060<>'1'
   IF NOT cl_null(l_count) AND l_count>0 THEN
      LET l_count=0
      SELECT COUNT(*) INTO l_count
        FROM prec_t
       WHERE precent=g_enterprise
         AND precdocno=g_prea_m.preadocno
         AND prec060<>'1'
         AND NOT EXISTS (SELECT 1 FROM pred_t WHERE predent=g_enterprise AND preddocno=precdocno AND predseq1=precseq)
       IF NOT cl_null(l_count) AND l_count>0 THEN
          LET r_success = FALSE
          LET r_errno='apr-00399'           
          RETURN r_success,r_errno,r_chr50
       END IF                   
   END IF
#如果基本资料单身"保底方式" 为1.无保底,无目标,不可以有對應的促銷保底設置
   LET l_count=0
   SELECT COUNT(*) INTO l_count
     FROM prec_t
    WHERE precent=g_enterprise
      AND precdocno=g_prea_m.preadocno
      AND prec060='1'
      AND EXISTS (SELECT 1 FROM pred_t WHERE predent=g_enterprise AND preddocno=precdocno AND predseq1=precseq)
    IF NOT cl_null(l_count) AND l_count>0 THEN
       LET r_success = FALSE
       LET r_errno='apr-00449'           
       RETURN r_success,r_errno,r_chr50
    END IF 


    #151202-00007#1-----add---begin---20151202----
    #買換--控管同一日期範圍內換贈的卡種/券種，不同的類型（散客/會員等級1-5）買換力度一樣
#    CALL aprt310_check_prec(g_prea_m.preadocno) RETURNING r_success,r_errno   #160720-00013#1   by 08172
    CALL s_aprt310_check_prec(g_prea_m.preadocno) RETURNING r_success   #160720-00013#1   by 08172
    IF NOT r_success THEN          
#       RETURN r_success,r_errno,r_chr50       #160720-00013#1   by 08172               
       RETURN r_success                        #160720-00013#1   by 08172
    END IF   
    #151202-00007#1-----add---begin---20151202----



   
#管控統一個常規庫區對應的促銷庫區同一日期範圍內只能存在一筆   
  DECLARE aprt310_curs_chprec003 CURSOR FOR SELECT DISTINCT prec003 FROM prec_t WHERE precent=g_enterprise AND precdocno=g_prea_m.preadocno
  
  FOREACH aprt310_curs_chprec003 INTO l_prec003
  
#add20150902-----add---begin--------配合excel导入使用 
     #促銷庫區不能重复 
      LET l_count=0
      SELECT count(*) INTO l_count
        FROM prec_t
       WHERE precent=g_enterprise
         AND precdocno=g_prea_m.preadocno
         AND prec003=l_prec003
     IF l_count>1 AND NOT cl_null(l_count) THEN
        LET r_errno='apr-00435'
        RETURN r_success,r_errno,r_chr50                            
     END IF                
     #本筆資料中，同一常規庫區的促銷庫區只能有一筆資料
     #AOOS020---专柜库区商品化--Y:促销库区的M档资料---日期范围内，不能重叠。
     #-------------------------N:常規庫區下的促銷庫區的M檔資料--的日期範圍，與此筆申請單的日期範圍是否重疊
     LET l_flag=cl_get_para(g_enterprise,g_prea_m.preasite,'S-CIR-2011')
#    IF l_flag='N' THEN                         #mark by yangxf
     IF l_flag != '2' OR cl_null(l_flag) THEN   #add by yangxf 
         SELECT inaa141 INTO l_inaa141
           FROM inaa_t
          WHERE inaaent=g_enterprise
            AND inaa001=l_prec003
         LET l_count=0
         SELECT count(*) INTO l_count
           FROM prec_t
          WHERE precent=g_enterprise
            AND precdocno=g_prea_m.preadocno
            AND prec003 IN (SELECT inaa001 FROM inaa_t WHERE inaa141=l_inaa141 AND inaaent = g_enterprise ) #add by geza 20160905 #160905-00007#13 add inaaent
        IF l_count>1 AND NOT cl_null(l_count) THEN
           LET r_errno='apr-00427'
           RETURN r_success,r_errno,r_chr50             
        END IF    
     END IF   
#add20150902-----add---end--------配合excel导入使用   
#     CALL aprt310_chck_prec003(l_prec003) RETURNING r_success     #160720-00013#1   by 08172
     CALL s_aprt310_chk_prec003(g_prea_m.preadocno,l_prec003) RETURNING r_success    #160720-00013#1   by 08172
     IF NOT r_success THEN
        LET r_errno='apr-00398'
        LET r_chr50=l_prec003
        RETURN r_success,r_errno,r_chr50
     END IF
  END FOREACH 
   
   
   
   
   RETURN r_success,r_errno,r_chr50

END FUNCTION

################################################################################
# Descriptions...: 審核
# Memo...........:
# Usage..........: CALL aprt310_conf_upd()
#                  RETURNING r_success
# Input parameter: 
# Return code....: r_success      TRUE/FALSE
# Date & Author..: 20150525 By huangrh
# Modify.........:
################################################################################
PRIVATE FUNCTION aprt310_conf_upd()
DEFINE r_success            LIKE type_t.num5
DEFINE l_time               DATETIME YEAR TO SECOND
DEFINE l_sql                STRING
DEFINE l_n                  LIKE type_t.num5
#161111-00028#4 --mdofy---begin--------
#DEFINE l_prea               RECORD LIKE prea_t.*
#DEFINE l_preg               RECORD LIKE preg_t.*
DEFINE l_preg RECORD  #促銷談判結果單頭資料表
       pregent LIKE preg_t.pregent, #企業編號
       pregunit LIKE preg_t.pregunit, #制定組織
       pregsite LIKE preg_t.pregsite, #營運組織
       pregstus LIKE preg_t.pregstus, #狀態碼
       preg001 LIKE preg_t.preg001, #規則編號
       preg002 LIKE preg_t.preg002, #版本
       preg003 LIKE preg_t.preg003, #促銷方案編號
       preg004 LIKE preg_t.preg004, #促銷方式
       preg005 LIKE preg_t.preg005, #換贈對象
       preg006 LIKE preg_t.preg006, #換贈編號
       preg007 LIKE preg_t.preg007, #活動計劃
       preg008 LIKE preg_t.preg008, #活動類型
       preg009 LIKE preg_t.preg009, #檔期類型
       preg010 LIKE preg_t.preg010, #活動等級
       preg011 LIKE preg_t.preg011, #申請人員
       preg012 LIKE preg_t.preg012, #申請部門
       preg013 LIKE preg_t.preg013, #日期高階設定
       preg014 LIKE preg_t.preg014, #發佈日期
       preg015 LIKE preg_t.preg015, #終止日期
       preg016 LIKE preg_t.preg016, #發布人員
       preg017 LIKE preg_t.preg017, #終止人員
       preg018 LIKE preg_t.preg018, #釋出時間
       pregownid LIKE preg_t.pregownid, #資料所屬者
       pregowndp LIKE preg_t.pregowndp, #資料所有部門
       pregcrtid LIKE preg_t.pregcrtid, #資料建立者
       pregcrtdp LIKE preg_t.pregcrtdp, #資料建立部門
       pregcrtdt LIKE preg_t.pregcrtdt, #資料創建日
       pregmodid LIKE preg_t.pregmodid, #資料修改者
       pregmoddt LIKE preg_t.pregmoddt, #最近修改日
       pregcnfid LIKE preg_t.pregcnfid, #資料確認者
       pregcnfdt LIKE preg_t.pregcnfdt, #資料確認日
       pregpstid LIKE preg_t.pregpstid, #資料過帳者
       pregpstdt LIKE preg_t.pregpstdt, #資料過帳日
       preg050 LIKE preg_t.preg050, #相同基數取最低
       preg051 LIKE preg_t.preg051, #主題分類
       preg052 LIKE preg_t.preg052  #促銷類型
       END RECORD

DEFINE l_prea RECORD  #促銷談判條件單頭資料表
       preaent LIKE prea_t.preaent, #企業編號
       preaunit LIKE prea_t.preaunit, #制定組織
       preasite LIKE prea_t.preasite, #營運組織
       preadocno LIKE prea_t.preadocno, #促銷談判單號
       preadocdt LIKE prea_t.preadocdt, #申請日期
       preaacti LIKE prea_t.preaacti, #資料有效
       preastus LIKE prea_t.preastus, #狀態碼
       prea000 LIKE prea_t.prea000, #作業方式
       prea001 LIKE prea_t.prea001, #規則編號
       prea002 LIKE prea_t.prea002, #版本
       prea003 LIKE prea_t.prea003, #促銷方案編號
       prea004 LIKE prea_t.prea004, #促銷方式
       prea005 LIKE prea_t.prea005, #換贈對象
       prea006 LIKE prea_t.prea006, #換贈編號
       prea007 LIKE prea_t.prea007, #活動計劃
       prea008 LIKE prea_t.prea008, #活動類型
       prea009 LIKE prea_t.prea009, #檔期類型
       prea010 LIKE prea_t.prea010, #活動等級
       prea011 LIKE prea_t.prea011, #申請人員
       prea012 LIKE prea_t.prea012, #申請部門
       prea013 LIKE prea_t.prea013, #日期高階設定
       prea014 LIKE prea_t.prea014, #發佈日期
       prea015 LIKE prea_t.prea015, #釋出時間
       preaownid LIKE prea_t.preaownid, #資料所屬者
       preaowndp LIKE prea_t.preaowndp, #資料所有部門
       preacrtid LIKE prea_t.preacrtid, #資料建立者
       preacrtdp LIKE prea_t.preacrtdp, #資料建立部門
       preacrtdt LIKE prea_t.preacrtdt, #資料創建日
       preamodid LIKE prea_t.preamodid, #資料修改者
       preamoddt LIKE prea_t.preamoddt, #最近修改日
       preacnfid LIKE prea_t.preacnfid, #資料確認者
       preacnfdt LIKE prea_t.preacnfdt, #資料確認日
       preapstid LIKE prea_t.preapstid, #資料過帳者
       preapstdt LIKE prea_t.preapstdt, #資料過帳日
       prea050 LIKE prea_t.prea050, #相同基數取最低
       prea051 LIKE prea_t.prea051, #主題分類
       prea052 LIKE prea_t.prea052  #促銷類型
       END RECORD

#161111-00028#4 --mdofy---end--------
DEFINE l_stus               LIKE prea_t.preastus
DEFINE l_prea015            LIKE prea_t.prea015


   WHENEVER ERROR CONTINUE
   LET r_success = TRUE
   #检查:应在事物中的
   IF NOT s_transaction_chk('Y','0') THEN
      LET r_success = FALSE
      RETURN r_success
   END IF
   LET l_time = cl_get_current()   
   
   #INS促銷規則單頭資料檔(prdl_t)
   INITIALIZE l_prea.* TO NULL
   #161111-00028#4 --mdofy---begin--------
  #SELECT * INTO l_prea.*
   SELECT preaent,preaunit,preasite,preadocno,preadocdt,preaacti,preastus,prea000,prea001,prea002,prea003,prea004,
          prea005,prea006,prea007,prea008,prea009,prea010,prea011,prea012,prea013,prea014,prea015,preaownid,preaowndp,
          preacrtid,preacrtdp,preacrtdt,preamodid,preamoddt,preacnfid,preacnfdt,preapstid,preapstdt,prea050,
          prea051,prea052 INTO l_prea.*
   #161111-00028#4 --mdofy---end--------
     FROM prea_t
    WHERE preaent = g_enterprise
      AND preadocno = g_prea_m.preadocno

   LET l_n = 0
   SELECT COUNT(*) INTO l_n
     FROM preg_t
    WHERE pregent = g_enterprise
      AND preg001 = l_prea.prea001
   IF l_n = 0 THEN
      IF l_prea.preaacti = 'Y' THEN
         LET l_stus = 'Y'
      ELSE
         LET l_stus = 'X'
      END IF
      LET l_preg.pregent = g_enterprise
      LET l_preg.pregunit = l_prea.preaunit
      LET l_preg.pregsite = l_prea.preasite
      LET l_preg.pregstus = l_stus      
      LET l_preg.preg001 = l_prea.prea001
      LET l_preg.preg002 = l_prea.prea002
      LET l_preg.preg003 = l_prea.prea003
      LET l_preg.preg004 = l_prea.prea004
      LET l_preg.preg005 = l_prea.prea005
      LET l_preg.preg006 = l_prea.prea006
      LET l_preg.preg007 = l_prea.prea007 
      LET l_preg.preg008 = l_prea.prea008
      LET l_preg.preg009 = l_prea.prea009
      LET l_preg.preg010 = l_prea.prea010
      LET l_preg.preg011 = l_prea.prea011
      LET l_preg.preg012 = l_prea.prea012
      LET l_preg.preg013 = l_prea.prea013
      LET l_preg.preg014 = l_prea.prea014
      LET l_preg.preg018 = l_prea.prea015
      LET l_preg.preg050 = l_prea.prea050
      LET l_preg.preg051 = l_prea.prea051
      LET l_preg.preg052 = l_prea.prea052      
      LET l_preg.pregownid = g_user
      LET l_preg.pregowndp = g_dept
      LET l_preg.pregcrtid = g_user
      LET l_preg.pregcrtdp = g_dept
      LET l_preg.pregcrtdt = l_time
      LET l_preg.pregmodid = ''
      LET l_preg.pregmoddt = ''
      LET l_preg.pregcnfid = ''
      LET l_preg.pregcnfdt = ''
     #161111-00028#4 --mdofy---begin-------- 
     # INSERT INTO preg_t VALUES(l_preg.*)
      INSERT INTO preg_t (pregent,pregunit,pregsite,pregstus,preg001,preg002,preg003,preg004,preg005,preg006,preg007,
                          preg008,preg009,preg010,preg011,preg012,preg013,preg014,preg015,preg016,preg017,preg018,
                          pregownid,pregowndp,pregcrtid,pregcrtdp,pregcrtdt,pregmodid,pregmoddt,pregcnfid,pregcnfdt,
                          pregpstid,pregpstdt,preg050,preg051,preg052)
       VALUES(l_preg.pregent,l_preg.pregunit,l_preg.pregsite,l_preg.pregstus,l_preg.preg001,l_preg.preg002,l_preg.preg003,l_preg.preg004,l_preg.preg005,l_preg.preg006,l_preg.preg007,
              l_preg.preg008,l_preg.preg009,l_preg.preg010,l_preg.preg011,l_preg.preg012,l_preg.preg013,l_preg.preg014,l_preg.preg015,l_preg.preg016,l_preg.preg017,l_preg.preg018,
              l_preg.pregownid,l_preg.pregowndp,l_preg.pregcrtid,l_preg.pregcrtdp,l_preg.pregcrtdt,l_preg.pregmodid,l_preg.pregmoddt,l_preg.pregcnfid,l_preg.pregcnfdt,
              l_preg.pregpstid,l_preg.pregpstdt,l_preg.preg050,l_preg.preg051,l_preg.preg052)
     #161111-00028#4 --mdofy---end--------
      IF SQLCA.sqlcode THEN
         LET r_success = FALSE
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = 'sub-00034'
         LET g_errparam.extend = l_prea.prea001
         LET g_errparam.popup = TRUE
         CALL cl_err()

         RETURN r_success
      END IF  
      
   ELSE 
      IF l_prea.preaacti = 'Y' THEN
         LET l_stus = 'Y'
      ELSE
         LET l_stus = 'X'
      END IF
      UPDATE preg_t SET pregsite = l_prea.preasite, 
                        pregunit = l_prea.preaunit,      
                        preg002 = l_prea.prea002,
                        preg003 = l_prea.prea003,
                        preg004 = l_prea.prea004,
                        preg005 = l_prea.prea005,
                        preg006 = l_prea.prea006,
                        preg007 = l_prea.prea007,
                        preg008 = l_prea.prea008,
                        preg009 = l_prea.prea009,
                        preg010 = l_prea.prea010,
                        preg011 = l_prea.prea011,
                        preg012 = l_prea.prea012,
                        preg013 = l_prea.prea013,
                        preg014 = l_prea.prea014,
                        preg018 = l_prea.prea015,
                        preg050 = l_prea.prea050,
                        preg051 = l_prea.prea051,
                        pregstus = l_stus,
                        pregmodid = g_user,
                        pregmoddt = l_time
       WHERE pregent = g_enterprise
         AND preg001 = l_prea.prea001
      IF SQLCA.sqlcode THEN
         LET r_success = FALSE
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = 'sub-00034'
         LET g_errparam.extend = l_prea.prea001
         LET g_errparam.popup = TRUE
         CALL cl_err()
         RETURN r_success
      END IF
   END IF

#更新確認人員和確認時間
   IF l_stus = 'Y' THEN
      UPDATE preg_t SET pregcnfid = g_user,
                        pregcnfdt = l_time,
                        pregstus='Y'
       WHERE pregent = g_enterprise
         AND preg001 = l_prea.prea001
      IF SQLCA.sqlcode THEN
         LET r_success = FALSE
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = 'sub-00034'
         LET g_errparam.extend = l_prea.prea001
         LET g_errparam.popup = TRUE
         CALL cl_err()
    
         RETURN r_success
      END IF   
   END IF

   #INS促銷談判結果單頭資料檔多語言檔(pregl_t)
   DELETE FROM pregl_t
    WHERE preglent = g_enterprise
      AND pregl001 = l_prea.prea001
   IF SQLCA.sqlcode THEN
      LET r_success = FALSE
      INITIALIZE g_errparam TO NULL
         LET g_errparam.code = 'sub-00034'
         LET g_errparam.extend = l_prea.prea001
         LET g_errparam.popup = TRUE
         CALL cl_err()

      RETURN r_success
   END IF   
   INSERT INTO pregl_t(preglent,pregl001,pregl002,pregl003,pregl004)  
   SELECT g_enterprise,l_prea.prea001,preal001,preal002,preal003
     FROM preal_t
    WHERE prealent = g_enterprise
      AND prealdocno = l_prea.preadocno
   IF SQLCA.sqlcode THEN
      LET r_success = FALSE
      INITIALIZE g_errparam TO NULL
         LET g_errparam.code = 'sub-00034'
         LET g_errparam.extend = l_prea.prea001
         LET g_errparam.popup = TRUE
         CALL cl_err()

      RETURN r_success
   END IF


   #INS促銷談判結果時間資料表(preh_t)
   DELETE FROM preh_t
    WHERE prehent = g_enterprise
      AND preh001 = l_prea.prea001
   IF SQLCA.sqlcode THEN
      LET r_success = FALSE
      INITIALIZE g_errparam TO NULL
         LET g_errparam.code = 'sub-00034'
         LET g_errparam.extend = l_prea.prea001
         LET g_errparam.popup = TRUE
         CALL cl_err()

      RETURN r_success
   END IF   
   INSERT INTO preh_t(prehent,prehunit,prehsite,prehacti,preh001,preh002,preh003,preh004,preh005,preh006,preh007,preh008)  
   SELECT prebent,prebunit,prebsite,prebacti,preb001,preb002,preb003,preb004,preb005,preb006,preb007,preb008
     FROM preb_t
    WHERE prebent = g_enterprise
      AND prebdocno = l_prea.preadocno
   IF SQLCA.sqlcode THEN
      LET r_success = FALSE
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'sub-00034'
      LET g_errparam.extend = l_prea.prea001
      LET g_errparam.popup = TRUE
      CALL cl_err()

      RETURN r_success
   END IF
   
   
   #INS促銷談判結果明細檔(prei_t)
   DELETE FROM prei_t
    WHERE preient = g_enterprise
      AND prei001 = l_prea.prea001
   IF SQLCA.sqlcode THEN
      LET r_success = FALSE
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'sub-00034'
      LET g_errparam.extend = l_prea.prea001
      LET g_errparam.popup = TRUE
      CALL cl_err()

      RETURN r_success
   END IF   
   
   INSERT INTO prei_t(preient,preiunit,preisite,preiacti,
                      preiseq,prei001,prei002,prei003,prei004,prei005,prei006,prei007,prei008,prei009,
                      prei010,prei011,prei012,prei013,prei014,prei015,prei016,prei017,prei018,prei019,
                      prei020,prei021,prei022,prei023,prei024,prei025,prei026,prei027,prei028,prei029,
                      prei030,prei031,prei032,prei033,prei034,prei035,prei036,prei037,prei038,prei039,
                      prei040,prei041,prei042,prei043,prei044,prei045,prei046,prei047,prei048,prei049,
                      prei050,prei051,prei052,prei053,prei054,prei055,prei056,prei057,prei058,prei059,
                      prei060,prei061,prei062,prei063,prei064,prei065,prei066,prei067,prei068,prei069,
                      prei070,prei071,prei072,prei073,prei074,prei075,prei076,prei077,prei078,prei079,
                      prei080,prei081,prei082,prei083,prei084,prei085,prei086,prei087,prei088,prei089,
                      prei090,prei091,prei092,prei093,prei094,prei095,prei096,prei097,prei098,prei099,prei100)  
   SELECT precent,precunit,precsite,precacti,
                      precseq,prec001,prec002,prec003,prec004,prec005,prec006,prec007,prec008,prec009,
                      prec010,prec011,prec012,prec013,prec014,prec015,prec016,prec017,prec018,prec019,
                      prec020,prec021,prec022,prec023,prec024,prec025,prec026,prec027,prec028,prec029,
                      prec030,prec031,prec032,prec033,prec034,prec035,prec036,prec037,prec038,prec039,
                      prec040,prec041,prec042,prec043,prec044,prec045,prec046,prec047,prec048,prec049,
                      prec050,prec051,prec052,prec053,prec054,prec055,prec056,prec057,prec058,prec059,
                      prec060,prec061,prec062,prec063,prec064,prec065,prec066,prec067,prec068,prec069,
                      prec070,prec071,prec072,prec073,prec074,prec075,prec076,prec077,prec078,prec079,
                      prec080,prec081,prec082,prec083,prec084,prec085,prec086,prec087,prec088,prec089,
                      prec090,prec091,prec092,prec093,prec094,prec095,prec096,prec097,'','',prec098
     FROM prec_t
    WHERE precent = g_enterprise
      AND precdocno = l_prea.preadocno
   IF SQLCA.sqlcode THEN
      LET r_success = FALSE
      INITIALIZE g_errparam TO NULL
         LET g_errparam.code = 'sub-00034'
         LET g_errparam.extend = l_prea.prea001
         LET g_errparam.popup = TRUE
         CALL cl_err()

      RETURN r_success
   END IF
   
   #INS促銷談判結果保底費用明細檔(prej_t)
   DELETE FROM prej_t
    WHERE prejent = g_enterprise
      AND prej001 = l_prea.prea001
   IF SQLCA.sqlcode THEN
      LET r_success = FALSE
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'sub-00034'
      LET g_errparam.extend = l_prea.prea001
      LET g_errparam.popup = TRUE
      CALL cl_err()

      RETURN r_success
   END IF   
   INSERT INTO prej_t(prejent,prejunit,prejsite,prejseq,prejacti,prejseq1,prej001,prej002,prej003,prej004,prej005,prej006,prej007)  
   SELECT predent,predunit,predsite,predseq,predacti,predseq1,pred001,pred002,pred003,pred004,pred005,pred006,pred007
     FROM pred_t
    WHERE predent = g_enterprise
      AND preddocno = l_prea.preadocno
   IF SQLCA.sqlcode THEN
      LET r_success = FALSE
      INITIALIZE g_errparam TO NULL
         LET g_errparam.code = 'sub-00034'
         LET g_errparam.extend = l_prea.prea001
         LET g_errparam.popup = TRUE
         CALL cl_err()

      RETURN r_success
   END IF

   #異動狀態碼欄位/修改人/修改日期
   LET l_time = cl_get_current()
   UPDATE prea_t 
     SET (preastus,preamodid,preamoddt) 
       = ('Y',g_user,l_time)     
   WHERE preaent = g_enterprise AND preadocno = l_prea.preadocno
   IF SQLCA.sqlcode THEN
      LET r_success = FALSE
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'sub-00034'
      LET g_errparam.extend = l_prea.preadocno
      LET g_errparam.popup = TRUE
      CALL cl_err()
   
      RETURN r_success
   END IF

   #確認時間大約發佈時間，直接發佈
   LET l_prea015=cl_get_time()
   IF g_today>g_prea_m.prea014 OR (g_today=g_prea_m.prea014 AND l_prea015>=g_prea_m.prea015)  THEN            
      IF cl_ask_confirm('amm-00178') THEN
         CALL s_aprp310_release(l_prea.prea001) RETURNING r_success #审核发布 
         IF NOT r_success THEN
            RETURN r_success                         
         END IF    
         
         
         #異動狀態碼欄位/修改人/修改日期
         LET l_time = cl_get_current()
         UPDATE preg_t 
           SET (pregstus,pregmodid,pregmoddt) 
             = ('F',g_user,l_time)     
         WHERE pregent = g_enterprise AND preg001 = l_prea.prea001
         IF SQLCA.sqlcode THEN
            LET r_success = FALSE
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = 'sub-00034'
            LET g_errparam.extend = l_prea.prea001
            LET g_errparam.popup = TRUE
            CALL cl_err()
         
            RETURN r_success
         END IF     
       END IF         
   END IF

   
   RETURN r_success

END FUNCTION

################################################################################
# Descriptions...: 單身預設資料
# Memo...........:
# Usage..........: CALL aprt310_detail_init()
# Input parameter: 無
# Return code....: 無
# Date & Author..: 2015/05/25 By huangrh
# Modify.........:
################################################################################
PRIVATE FUNCTION aprt310_detail_init()


   #INS促銷談判結果時間資料表(preb_t)  
   IF g_prea_m.prea013 = 'Y' THEN
      INSERT INTO preb_t(prebent,prebunit,prebsite,prebacti,prebdocno,preb001,preb002,preb003,preb004,preb005,preb006,preb007,preb008)  
      SELECT g_enterprise,g_prea_m.preaunit,g_prea_m.preasite,prehacti,g_prea_m.preadocno,preh001,preh002,preh003,preh004,preh005,preh006,preh007,preh008
        FROM preh_t
       WHERE prehent = g_enterprise
         AND preh001 = g_prea_m.prea001
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = 'sub-00034'
         LET g_errparam.extend = g_prea_m.prea001
         LET g_errparam.popup = TRUE
         CALL cl_err()
      END IF
   END IF
   
   #INS促銷談判結果明細檔(prec_t)     
   INSERT INTO prec_t(precent,precunit,precsite,precacti,precdocno,
                      precseq,prec001,prec002,prec003,prec004,prec005,prec006,prec007,prec008,prec009,
                      prec010,prec011,prec012,prec013,prec014,prec015,prec016,prec017,prec018,prec019,
                      prec020,prec021,prec022,prec023,prec024,prec025,prec026,prec027,prec028,prec029,
                      prec030,prec031,prec032,prec033,prec034,prec035,prec036,prec037,prec038,prec039,
                      prec040,prec041,prec042,prec043,prec044,prec045,prec046,prec047,prec048,prec049,
                      prec050,prec051,prec052,prec053,prec054,prec055,prec056,prec057,prec058,prec059,
                      prec060,prec061,prec062,prec063,prec064,prec065,prec066,prec067,prec068,prec069,
                      prec070,prec071,prec072,prec073,prec074,prec075,prec076,prec077,prec078,prec079,
                      prec080,prec081,prec082,prec083,prec084,prec085,prec086,prec087,prec088,prec089,
                      prec090,prec091,prec092,prec093,prec094,prec095,prec096,prec097,prec098)  
   SELECT g_enterprise,g_prea_m.preaunit,g_prea_m.preasite,preiacti,g_prea_m.preadocno,
                      preiseq,prei001,prei002,prei003,prei004,prei005,prei006,prei007,prei008,prei009,
                      prei010,prei011,prei012,prei013,prei014,prei015,prei016,prei017,prei018,prei019,
                      prei020,prei021,prei022,prei023,prei024,prei025,prei026,prei027,prei028,prei029,
                      prei030,prei031,prei032,prei033,prei034,prei035,prei036,prei037,prei038,prei039,
                      prei040,prei041,prei042,prei043,prei044,prei045,prei046,prei047,prei048,prei049,
                      prei050,prei051,prei052,prei053,prei054,prei055,prei056,prei057,prei058,prei059,
                      prei060,prei061,prei062,prei063,prei064,prei065,prei066,prei067,prei068,prei069,
                      prei070,prei071,prei072,prei073,prei074,prei075,prei076,prei077,prei078,prei079,
                      prei080,prei081,prei082,prei083,prei084,prei085,prei086,prei087,prei088,prei089,
                      prei090,prei091,prei092,prei093,prei094,prei095,prei096,prei097,prei100
     FROM prei_t
    WHERE preient = g_enterprise
      AND prei001 = g_prea_m.prea001
      AND prei081<>'2'
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'sub-00034'
      LET g_errparam.extend = g_prea_m.prea001
      LET g_errparam.popup = TRUE
      CALL cl_err()
   END IF
   
   #INS促銷談判結果保底費用明細檔(pred_t)  
   INSERT INTO pred_t(predent,predunit,predsite,predseq,predacti,predseq1,preddocno,pred001,pred002,pred003,pred004,pred005,pred006,pred007)  
   SELECT g_enterprise,g_prea_m.preaunit,g_prea_m.preasite,prejseq,prejacti,prejseq1,g_prea_m.preadocno,prej001,prej002,prej003,prej004,prej005,prej006,prej007
     FROM prej_t
    WHERE prejent = g_enterprise
      AND prej001 = g_prea_m.prea001
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'sub-00034'
      LET g_errparam.extend = g_prea_m.prea001
      LET g_errparam.popup = TRUE
      CALL cl_err()
   END IF
  
 
END FUNCTION

################################################################################
# Descriptions...: #管控統一個常規庫區對應的促銷庫區同一日期範圍內只能存在一筆 
# Memo...........:
# Usage..........: CALL aprt310_chck_prec003(p_prec003) 
#                  RETURNING r_success
# Input parameter: p_prec003  促銷庫區編號
# Return code....: r_success  TRUE/FASE
# Date & Author..: 20150525 By huangrh
# Modify.........:
################################################################################
PRIVATE FUNCTION aprt310_chck_prec003(p_prec003)
DEFINE r_success     LIKE type_t.num5
DEFINE p_prec003     LIKE prec_t.prec003
DEFINE l_inaa141     LIKE inaa_t.inaa141
DEFINE l_count       LIKE type_t.num5
DEFINE l_preh001     LIKE preh_t.preh001
DEFINE l_preh002     LIKE preh_t.preh002
DEFINE l_preh003     LIKE preh_t.preh003
DEFINE l_preh004     LIKE preh_t.preh004
DEFINE l_preh005     LIKE preh_t.preh005
DEFINE l_preh006     LIKE preh_t.preh006
DEFINE l_preh007     LIKE preh_t.preh007
DEFINE l_preh008     LIKE preh_t.preh008
DEFINE l_preb003     LIKE preb_t.preb003
DEFINE l_preb004     LIKE preb_t.preb004
DEFINE l_preb005     LIKE preb_t.preb005
DEFINE l_preb006     LIKE preb_t.preb006
DEFINE l_preb007     LIKE preb_t.preb007
DEFINE l_preb008     LIKE preb_t.preb008
DEFINE l_sdate       LIKE preb_t.preb003
DEFINE l_edate       LIKE preb_t.preb004
DEFINE l_stime       LIKE preb_t.preb005
DEFINE l_etime       LIKE preb_t.preb006
DEFINE l_day         LIKE type_t.num5
DEFINE l_weekday     LIKE type_t.num5
DEFINE l_insert      LIKE type_t.num5
DEFINE l_sql         STRING
DEFINE l_flag        LIKE type_t.chr1



     LET r_success=TRUE
  
     #促銷庫區對應的常規庫區
     SELECT inaa141 INTO l_inaa141
       FROM inaa_t
      WHERE inaaent=g_enterprise
        AND inaa001=p_prec003 
     IF cl_null(l_inaa141) THEN
        RETURN r_success
     END IF
     
     #常規庫區下的促銷庫區是否存在M檔資料
     LET l_count=0
     SELECT COUNT(*) INTO l_count
       FROM inaa_t,prei_t,preg_t
      WHERE preient=pregent
        AND prei001=preg001
        AND prei003=inaa001
        AND inaa135='2'
        AND inaa141=l_inaa141
        AND prei001<>g_prea_m.prea001
        AND pregstus<>'X'
        AND inaastus='Y'
     IF cl_null(l_count) OR l_count=0 THEN
        RETURN r_success
     END IF

    DELETE FROM aprt310_tmp01    #160727-00019#14 Mod   aprt310_preh_tmp -->aprt310_tmp01
    DELETE FROM aprt310_tmp02    #160727-00019#14 Mod   aprt310_preb_tmp -->aprt310_tmp02
    
     #AOOS020---专柜库区商品化--Y:促销库区的M档资料---日期范围内，不能重叠。
     #-------------------------N:常規庫區下的促銷庫區的M檔資料--的日期範圍，與此筆申請單的日期範圍是否重疊
     LET l_flag=cl_get_para(g_enterprise,g_prea_m.preasite,'S-CIR-2011')
#     IF l_flag='Y' THEN     #mark by yangxf 
     IF l_flag = '2' THEN    #add by yangxf 
        LET l_sql="SELECT DISTINCT preh001,preh002,preh003,preh004,preh005,preh006,preh007,preh008 ",
                  "  FROM prei_t,preh_t,preg_t",
                  " WHERE preient=pregent",
                  "   AND prehent=pregent",
                  "   AND prei001=preg001",
                  "   AND preh001=preg001",
                  "   AND prei003='",p_prec003,"'",
                  "   AND prei001<>'",g_prea_m.prea001,"'",
                  "   AND pregstus<>'X'",
                  "   AND prehacti='Y'",
                  "   AND prei081<>'2'"  #非終止發佈狀態
     END IF     
#    IF l_flag='N' THEN                         #mark by yangxf 
     IF l_flag != '2' OR cl_null(l_flag) THEN   #add by yangxf 
        LET l_sql="SELECT DISTINCT preh001,preh002,preh003,preh004,preh005,preh006,preh007,preh008 ",
                  "  FROM inaa_t,prei_t,preh_t,preg_t",
                  " WHERE preient=pregent",
                  "   AND prehent=pregent",
                  "   AND prei001=preg001",
                  "   AND preh001=preg001",
                  "   AND prei003=inaa001",
                  "   AND inaa135='2'",
                  "   AND inaa141='",l_inaa141,"'",
                  "   AND prei001<>'",g_prea_m.prea001,"'",
                  "   AND pregstus<>'X'",
                  "   AND prehacti='Y'",
                  "   AND prei081<>'2'"  #非終止發佈狀態
     END IF
     
     PREPARE aprt310_pre_preh FROM l_sql
     DECLARE aprt310_curs_preh CURSOR FOR aprt310_pre_preh


     DECLARE aprt310_curs_preb CURSOR FOR SELECT preb003,preb004,preb005,preb006,preb007,preb008 
                                            FROM preb_t
                                           WHERE prebent=g_enterprise
                                             AND prebdocno=g_prea_m.preadocno
                                             AND prebacti='Y'  
                                             
     FOREACH aprt310_curs_preh INTO l_preh001,l_preh002,l_preh003,l_preh004,l_preh005,l_preh006,l_preh007,l_preh008
        #暂时不管，固定日期和固定星期的设置(mark掉判断代码)
        #只判断开始日期和结束日期，开始时间和截止时间---20150824-by huangrh
        INSERT INTO aprt310_tmp01 VALUES(l_preh001,l_preh003,l_preh004,l_preh005,l_preh006)   #160727-00019#14 Mod   aprt310_preh_tmp -->aprt310_tmp01
             
        #暂时不管，固定日期和固定星期的设置(mark掉下面判断代码)---begin---     
        #IF cl_null(l_preh007) AND cl_null(l_preh008) THEN
        #   INSERT INTO aprt310_preh_tmp VALUES(l_preh001,l_preh003,l_preh004,l_preh005,l_preh006)
        #ELSE
        #   LET l_sdate=l_preh003  #日期
        #   LET l_edate=l_preh004  #結束日期
        #   WHILE TRUE
        #      LET l_insert=TRUE
        #      IF NOT cl_null(l_preh007) THEN
        #         LET l_day=DAY(l_sdate)
        #         IF l_day<>l_preh007 THEN
        #            LET l_insert=FALSE                 
        #         END IF
        #      END IF
        #      IF NOT cl_null(l_preh008) THEN
        #         LET l_weekday=WEEKDAY(l_sdate)
        #         IF l_weekday<>l_preh008 THEN
        #            LET l_insert=FALSE 
        #         END IF                
        #      END IF              
        #      IF l_insert THEN
        #         IF l_sdate=l_preh003 THEN   #日期等於開始日期       
        #            LET l_stime=l_preh005
        #         ELSE
        #            LET l_stime='00:00:00'
        #         END IF
        #         IF l_sdate=l_preh004 THEN  #日期等於結束日期       
        #            LET l_etime=l_preh006
        #         ELSE
        #            LET l_etime='23:59:59' 
        #         END IF                          
        #         INSERT INTO aprt310_preh_tmp VALUES(l_preh001,l_sdate,l_sdate,l_stime,l_etime)
        #      END IF   
        #      LET l_sdate=l_sdate+1
        #      IF l_sdate>l_edate THEN
        #         EXIT WHILE
        #      END IF                 
        #   END WHILE
        #END IF   
        #暂时不管，固定日期和固定星期的设置(mark掉上面判断代码)---end---          
     END FOREACH
  
     FOREACH aprt310_curs_preb INTO l_preb003,l_preb004,l_preb005,l_preb006,l_preb007,l_preb008
        #暂时不管，固定日期和固定星期的设置(mark掉判断代码)
        #只判断开始日期和结束日期，开始时间和截止时间---20150824-by huangrh
        INSERT INTO aprt310_tmp02 VALUES(l_preb003,l_preb004,l_preb005,l_preb006)       #160727-00019#14 Mod   aprt310_preb_tmp -->aprt310_tmp02
                
        #暂时不管，固定日期和固定星期的设置(mark掉下面判断代码)---begin---  
        #IF cl_null(l_preb007) AND cl_null(l_preb008) THEN
        #   INSERT INTO aprt310_preb_tmp VALUES(l_preb003,l_preb004,l_preb005,l_preb006)
        #ELSE
        #   LET l_sdate=l_preb003  #日期
        #   LET l_edate=l_preb004  #結束日期
        #   WHILE TRUE
        #      LET l_insert=TRUE
        #      IF NOT cl_null(l_preb007) THEN
        #         LET l_day=DAY(l_sdate)
        #         IF l_day<>l_preb007 THEN
        #            LET l_insert=FALSE                 
        #         END IF
        #      END IF
        #      IF NOT cl_null(l_preb008) THEN
        #         LET l_weekday=WEEKDAY(l_sdate)
        #         IF l_weekday<>l_preb008 THEN
        #            LET l_insert=FALSE 
        #         END IF                
        #      END IF              
        #      IF l_insert THEN
        #         IF l_sdate=l_preb003 THEN   #日期等於開始日期       
        #            LET l_stime=l_preb005
        #         ELSE
        #            LET l_stime='00:00:00'
        #         END IF
        #         IF l_sdate=l_preh004 THEN  #日期等於結束日期       
        #            LET l_etime=l_preb006
        #         ELSE
        #            LET l_etime='23:59:59' 
        #         END IF                          
        #         INSERT INTO aprt310_preb_tmp VALUES(l_sdate,l_sdate,l_stime,l_etime)
        #      END IF        
        #      LET l_sdate=l_sdate+1
        #      IF l_sdate>l_edate THEN
        #         EXIT WHILE
        #      END IF 
        #   END WHILE
        #END IF    
        #暂时不管，固定日期和固定星期的设置(mark掉上面判断代码)---end---        
     END FOREACH  
 
#日期範圍是否重疊判斷
#---1、先判斷日期不等於情況
#---2、再判斷日期等於情況
     LET l_count=0
     SELECT count(*) INTO l_count   
       FROM aprt310_tmp01,aprt310_tmp02      #160727-00019#14 Mod   aprt310_preh_tmp -->aprt310_tmp01 ， aprt310_preb_tmp -->aprt310_tmp02
      WHERE (preh003>preb003 AND preh003<preb004)
         OR (preh004>preb003 AND preh004<preb004)   
         OR (preb003>preh003 AND preb003<preh004) 
         OR (preb004>preh003 AND preb004<preh004)
     IF NOT cl_null(l_count) AND l_count>0 THEN         
        LET r_success=FALSE
        RETURN r_success
     END IF
        
     LET l_count=0
     SELECT count(*) INTO l_count   
       FROM aprt310_tmp01,aprt310_tmp02      #160727-00019#14 Mod   aprt310_preh_tmp -->aprt310_tmp01 ， aprt310_preb_tmp -->aprt310_tmp02
      WHERE (preh003=preb003 AND ((preh005>=preb005 AND preh005<=preb006) OR (preb005>=preh005 AND preb005<=preh006)))
         OR (preh003=preb004 AND ((preh005>=preb005 AND preh005<=preb006) OR (preb006>=preh005 AND preb006<=preh006)))
         OR (preh004=preb003 AND ((preh006>=preb005 AND preh006<=preb006) OR (preb005>=preh005 AND preb005<=preh006)))
         OR (preh004=preb004 AND ((preh006>=preb005 AND preh006<=preb006) OR (preb006>=preh005 AND preb006<=preh006)))
         
     IF NOT cl_null(l_count) AND l_count>0 THEN         
        LET r_success=FALSE
        RETURN r_success
     END IF

    RETURN r_success

END FUNCTION

################################################################################
# Descriptions...: #创建临时表
# Memo...........:
# Usage..........: CALL aprt310_check_prec003_createtemp()
#                  RETURNING r_success
# Input parameter: 
# Return code....: r_success  TRUE/FASE
# Date & Author..: 20150914 By huangrh
# Modify.........:
################################################################################
PRIVATE FUNCTION aprt310_check_prec003_createtemp()
DEFINE r_success     LIKE type_t.num5


     LET r_success=TRUE
     
     #先刪除一次臨時表(怕有殘留)
     DROP TABLE aprt310_tmp01;       #160727-00019#14 Mod   aprt310_preh_tmp -->aprt310_tmp01
     DROP TABLE aprt310_tmp02;     #160727-00019#14 Mod    aprt310_preb_tmp -->aprt310_tmp02

     #建立臨時表
     ##151202-00007#1-----add---preh001---20151202
     CREATE TEMP TABLE aprt310_tmp01(  #160727-00019#14 Mod   aprt310_preh_tmp -->aprt310_tmp01
      preh001 LIKE preh_t.preh001, #促銷規則編號
      preh003 LIKE preh_t.preh003, #開始日期
      preh004 LIKE preh_t.preh004, #結束日期
      preh005 LIKE preh_t.preh005, #開始時間
      preh006 LIKE preh_t.preh006  #結束時間
      );
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = 'sub-00034'
         LET g_errparam.extend = ''
         LET g_errparam.popup = TRUE
         CALL cl_err()
      END IF    
      
     #建立臨時表
     CREATE TEMP TABLE aprt310_tmp02(   #160727-00019#14 Mod    aprt310_preb_tmp -->aprt310_tmp02
      preb003 LIKE preb_t.preb003, #開始日期
      preb004 LIKE preb_t.preb004, #結束日期
      preb005 LIKE preb_t.preb005, #開始時間
      preb006 LIKE preb_t.preb006  #結束時間
      );
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = 'sub-00034'
         LET g_errparam.extend = ''
         LET g_errparam.popup = TRUE
         CALL cl_err()
      END IF   

      RETURN r_success
END FUNCTION

################################################################################
# Descriptions...: 檢查買換的力度
# Memo...........:
# Usage..........: CALL aprt310_check_prec(p_preadocno)
#                  RETURNING r_success
# Input parameter: p_preadocno    單據編號
# Return code....: r_success      TRUE/FALSE
#                  r_errno        錯誤信息代碼
# Date & Author..: 20151202 By huangrh
# Modify.........:
################################################################################
PRIVATE FUNCTION aprt310_check_prec(p_preadocno)
DEFINE p_preadocno      LIKE prea_t.preadocno
DEFINE r_success        LIKE type_t.num5
DEFINE r_errno          STRING
DEFINE l_prea004        LIKE prea_t.prea004
DEFINE l_count          LIKE type_t.num5
#161111-00028#4 --mdofy---begin--------
#DEFINE l_prea    RECORD LIKE prea_t.*
DEFINE l_prea RECORD  #促銷談判條件單頭資料表
       preaent LIKE prea_t.preaent, #企業編號
       preaunit LIKE prea_t.preaunit, #制定組織
       preasite LIKE prea_t.preasite, #營運組織
       preadocno LIKE prea_t.preadocno, #促銷談判單號
       preadocdt LIKE prea_t.preadocdt, #申請日期
       preaacti LIKE prea_t.preaacti, #資料有效
       preastus LIKE prea_t.preastus, #狀態碼
       prea000 LIKE prea_t.prea000, #作業方式
       prea001 LIKE prea_t.prea001, #規則編號
       prea002 LIKE prea_t.prea002, #版本
       prea003 LIKE prea_t.prea003, #促銷方案編號
       prea004 LIKE prea_t.prea004, #促銷方式
       prea005 LIKE prea_t.prea005, #換贈對象
       prea006 LIKE prea_t.prea006, #換贈編號
       prea007 LIKE prea_t.prea007, #活動計劃
       prea008 LIKE prea_t.prea008, #活動類型
       prea009 LIKE prea_t.prea009, #檔期類型
       prea010 LIKE prea_t.prea010, #活動等級
       prea011 LIKE prea_t.prea011, #申請人員
       prea012 LIKE prea_t.prea012, #申請部門
       prea013 LIKE prea_t.prea013, #日期高階設定
       prea014 LIKE prea_t.prea014, #發佈日期
       prea015 LIKE prea_t.prea015, #釋出時間
       preaownid LIKE prea_t.preaownid, #資料所屬者
       preaowndp LIKE prea_t.preaowndp, #資料所有部門
       preacrtid LIKE prea_t.preacrtid, #資料建立者
       preacrtdp LIKE prea_t.preacrtdp, #資料建立部門
       preacrtdt LIKE prea_t.preacrtdt, #資料創建日
       preamodid LIKE prea_t.preamodid, #資料修改者
       preamoddt LIKE prea_t.preamoddt, #最近修改日
       preacnfid LIKE prea_t.preacnfid, #資料確認者
       preacnfdt LIKE prea_t.preacnfdt, #資料確認日
       preapstid LIKE prea_t.preapstid, #資料過帳者
       preapstdt LIKE prea_t.preapstdt, #資料過帳日
       prea050 LIKE prea_t.prea050, #相同基數取最低
       prea051 LIKE prea_t.prea051, #主題分類
       prea052 LIKE prea_t.prea052  #促銷類型
       END RECORD

#161111-00028#4 --mdofy---end--------

DEFINE l_preh001        LIKE preh_t.preh001
DEFINE l_preh002        LIKE preh_t.preh002
DEFINE l_preh003        LIKE preh_t.preh003
DEFINE l_preh004        LIKE preh_t.preh004
DEFINE l_preh005        LIKE preh_t.preh005
DEFINE l_preh006        LIKE preh_t.preh006
DEFINE l_preh007        LIKE preh_t.preh007
DEFINE l_preh008        LIKE preh_t.preh008
DEFINE l_preb003        LIKE preb_t.preb003
DEFINE l_preb004        LIKE preb_t.preb004
DEFINE l_preb005        LIKE preb_t.preb005
DEFINE l_preb006        LIKE preb_t.preb006
DEFINE l_preb007        LIKE preb_t.preb007
DEFINE l_preb008        LIKE preb_t.preb008
DEFINE l_sdate          LIKE preb_t.preb003
DEFINE l_edate          LIKE preb_t.preb004
DEFINE l_stime          LIKE preb_t.preb005
DEFINE l_etime          LIKE preb_t.preb006
DEFINE l_day            LIKE type_t.num5
DEFINE l_weekday        LIKE type_t.num5
DEFINE l_insert         LIKE type_t.num5
DEFINE l_sql            STRING
DEFINE l_num20          LIKE prec_t.prec009
DEFINE l_oocq009        LIKE oocq_t.oocq009

#買換--控管同一門店，同一日期範圍內換贈的卡種/券種，促銷規則不能有多筆。
##買換--控管同一門店，同一日期範圍內換贈的卡種/券種，不同的類型（散客/會員等級1-5）買換力度一樣
    LET r_success=TRUE
    LET r_errno=''

    
    #是否為買換
    LET l_prea004=''
    SELECT prea004 INTO l_prea004
      FROM prea_t
     WHERE preaent=g_enterprise
       AND preadocno=p_preadocno
    IF l_prea004<>'1' THEN
       LET r_success=TRUE
       RETURN r_success,r_errno
    END IF
    
    #單身是否有資料
    LET l_count=0
    SELECT COUNT(*) INTO l_count
      FROM prec_t
     WHERE precent=g_enterprise
       AND precdocno=p_preadocno
    #單身無資料   
    IF cl_null(l_count) OR  l_count=0 THEN
       LET r_success=TRUE
       RETURN r_success,r_errno                   
    END IF   

    #此單據內，散客的換贈力度，會員等級1-5是否一致。----主要給excel導入后，審核使用
    #散客力度
    LET l_count=0
    SELECT COUNT(DISTINCT(prec009/prec010)) INTO l_count
      FROM prec_t
     WHERE precent=g_enterprise
       AND precdocno=p_preadocno
    IF NOT cl_null(l_count) AND l_count>1 THEN
       LET r_success = FALSE
       LET r_errno='apr-00486'           
       RETURN r_success,r_errno
    END IF       
 
    #會員等級一力度
    LET l_count=0
    SELECT COUNT(DISTINCT(prec011/prec012)) INTO l_count
      FROM prec_t
     WHERE precent=g_enterprise
       AND precdocno=p_preadocno
    IF NOT cl_null(l_count) AND l_count>1 THEN
       LET r_success = FALSE
       LET r_errno='apr-00487'           
       RETURN r_success,r_errno
    END IF

    #會員等級二力度
    LET l_count=0
    SELECT COUNT(DISTINCT(prec013/prec014)) INTO l_count
      FROM prec_t
     WHERE precent=g_enterprise
       AND precdocno=p_preadocno
    IF NOT cl_null(l_count) AND l_count>1 THEN
       LET r_success = FALSE
       LET r_errno='apr-00488'           
       RETURN r_success,r_errno
    END IF

    #會員等級三力度
    LET l_count=0
    SELECT COUNT(DISTINCT(prec015/prec016)) INTO l_count
      FROM prec_t
     WHERE precent=g_enterprise
       AND precdocno=p_preadocno
    IF NOT cl_null(l_count) AND l_count>1 THEN
       LET r_success = FALSE
       LET r_errno='apr-00489'           
       RETURN r_success,r_errno
    END IF

    #會員等級四力度
    LET l_count=0
    SELECT COUNT(DISTINCT(prec017/prec018)) INTO l_count
      FROM prec_t
     WHERE precent=g_enterprise
       AND precdocno=p_preadocno
    IF NOT cl_null(l_count) AND l_count>1 THEN
       LET r_success = FALSE
       LET r_errno='apr-00490'           
       RETURN r_success,r_errno
    END IF

    #會員等級五力度
    LET l_count=0
    SELECT COUNT(DISTINCT(prec019/prec020)) INTO l_count
      FROM prec_t
     WHERE precent=g_enterprise
       AND precdocno=p_preadocno
    IF NOT cl_null(l_count) AND l_count>1 THEN
       LET r_success = FALSE
       LET r_errno='apr-00491'           
       RETURN r_success,r_errno
    END IF
    

    #提取資料
    INITIALIZE l_prea.* TO NULL    
    #161111-00028#4 --mdofy---begin--------
   #SELECT * INTO l_prea.*
    SELECT preaent,preaunit,preasite,preadocno,preadocdt,preaacti,preastus,prea000,prea001,prea002,prea003,prea004,
           prea005,prea006,prea007,prea008,prea009,prea010,prea011,prea012,prea013,prea014,prea015,preaownid,preaowndp,
           preacrtid,preacrtdp,preacrtdt,preamodid,preamoddt,preacnfid,preacnfdt,preapstid,preapstdt,prea050,
           prea051,prea052 INTO l_prea.*
    #161111-00028#4 --mdofy---end--------
      FROM prea_t
     WHERE preaent=g_enterprise
       AND preadocno=p_preadocno
       
    #M檔是否存在此卡/券的買換
    LET l_count=0
    SELECT COUNT(*) INTO l_count
      FROM prei_t,preg_t
     WHERE preient=pregent
       AND prei001=preg001
       AND preg001<>l_prea.prea001
       AND pregstus<>'X'
       AND preg004=l_prea.prea004
       AND preg005=l_prea.prea005
       AND preg006=l_prea.prea006
       AND pregsite=l_prea.preasite
       AND prei081<>'2'
       
    IF cl_null(l_count) OR l_count=0 THEN
       LET r_success=TRUE
       RETURN r_success,r_errno
    END IF    

    #M檔是存在此卡/券的買換---再判斷時間是否有重疊
    DELETE FROM aprt310_tmp01        #160727-00019#14 Mod   aprt310_preh_tmp -->aprt310_tmp01
    DELETE FROM aprt310_tmp02        #160727-00019#14 Mod    aprt310_preb_tmp -->aprt310_tmp02


    LET l_sql="SELECT DISTINCT preh001,preh002,preh003,preh004,preh005,preh006,preh007,preh008 ",
              "  FROM prei_t,preh_t,preg_t",
              " WHERE preient=pregent",
              "   AND prehent=pregent",
              "   AND prei001=preg001",
              "   AND preh001=preg001",
              "   AND preg001<>'",l_prea.prea001,"'",
              "   AND preg004='",l_prea.prea004,"'",
              "   AND preg005='",l_prea.prea005,"'",
              "   AND preg006='",l_prea.prea006,"'", 
              "   AND pregsite='",l_prea.preasite,"'",              
              "   AND pregstus<>'X'",
              "   AND prehacti='Y'",
              "   AND prei081<>'2'"  #非終止發佈狀態       
     
     PREPARE aprt310_pre_preh2 FROM l_sql
     DECLARE aprt310_curs_preh2 CURSOR FOR aprt310_pre_preh2
                                             
     FOREACH aprt310_curs_preh2 INTO l_preh001,l_preh002,l_preh003,l_preh004,l_preh005,l_preh006,l_preh007,l_preh008
        #暂时不管，固定日期和固定星期的设置(mark掉判断代码)
        #只判断开始日期和结束日期，开始时间和截止时间---20151202-by huangrh
        INSERT INTO aprt310_tmp01 VALUES(l_preh001,l_preh003,l_preh004,l_preh005,l_preh006)    #160727-00019#14 Mod   aprt310_preh_tmp -->aprt310_tmp01
             
        #暂时不管，固定日期和固定星期的设置(mark掉下面判断代码)---begin---     
        #IF cl_null(l_preh007) AND cl_null(l_preh008) THEN
        #   INSERT INTO aprt310_preh_tmp VALUES(l_preh001,l_preh003,l_preh004,l_preh005,l_preh006)
        #ELSE
        #   LET l_sdate=l_preh003  #日期
        #   LET l_edate=l_preh004  #結束日期
        #   WHILE TRUE
        #      LET l_insert=TRUE
        #      IF NOT cl_null(l_preh007) THEN
        #         LET l_day=DAY(l_sdate)
        #         IF l_day<>l_preh007 THEN
        #            LET l_insert=FALSE                 
        #         END IF
        #      END IF
        #      IF NOT cl_null(l_preh008) THEN
        #         LET l_weekday=WEEKDAY(l_sdate)
        #         IF l_weekday<>l_preh008 THEN
        #            LET l_insert=FALSE 
        #         END IF                
        #      END IF              
        #      IF l_insert THEN
        #         IF l_sdate=l_preh003 THEN   #日期等於開始日期       
        #            LET l_stime=l_preh005
        #         ELSE
        #            LET l_stime='00:00:00'
        #         END IF
        #         IF l_sdate=l_preh004 THEN  #日期等於結束日期       
        #            LET l_etime=l_preh006
        #         ELSE
        #            LET l_etime='23:59:59' 
        #         END IF                          
        #         INSERT INTO aprt310_preh_tmp VALUES(l_preh001,l_sdate,l_sdate,l_stime,l_etime)
        #      END IF   
        #      LET l_sdate=l_sdate+1
        #      IF l_sdate>l_edate THEN
        #         EXIT WHILE
        #      END IF                 
        #   END WHILE
        #END IF   
        #暂时不管，固定日期和固定星期的设置(mark掉上面判断代码)---end---          
     END FOREACH

     DECLARE aprt310_curs_preb2 CURSOR FOR SELECT preb003,preb004,preb005,preb006,preb007,preb008 
                                            FROM preb_t
                                           WHERE prebent=g_enterprise
                                             AND prebdocno=l_prea.preadocno
                                             AND prebacti='Y'  
                                             
     FOREACH aprt310_curs_preb2 INTO l_preb003,l_preb004,l_preb005,l_preb006,l_preb007,l_preb008
        #暂时不管，固定日期和固定星期的设置(mark掉判断代码)
        #只判断开始日期和结束日期，开始时间和截止时间---20151202-by huangrh
        INSERT INTO aprt310_tmp02 VALUES(l_preb003,l_preb004,l_preb005,l_preb006)   #160727-00019#14 Mod    aprt310_preb_tmp -->aprt310_tmp02
                
        #暂时不管，固定日期和固定星期的设置(mark掉下面判断代码)---begin---  
        #IF cl_null(l_preb007) AND cl_null(l_preb008) THEN
        #   INSERT INTO aprt310_preb_tmp VALUES(l_preb003,l_preb004,l_preb005,l_preb006)
        #ELSE
        #   LET l_sdate=l_preb003  #日期
        #   LET l_edate=l_preb004  #結束日期
        #   WHILE TRUE
        #      LET l_insert=TRUE
        #      IF NOT cl_null(l_preb007) THEN
        #         LET l_day=DAY(l_sdate)
        #         IF l_day<>l_preb007 THEN
        #            LET l_insert=FALSE                 
        #         END IF
        #      END IF
        #      IF NOT cl_null(l_preb008) THEN
        #         LET l_weekday=WEEKDAY(l_sdate)
        #         IF l_weekday<>l_preb008 THEN
        #            LET l_insert=FALSE 
        #         END IF                
        #      END IF              
        #      IF l_insert THEN
        #         IF l_sdate=l_preb003 THEN   #日期等於開始日期       
        #            LET l_stime=l_preb005
        #         ELSE
        #            LET l_stime='00:00:00'
        #         END IF
        #         IF l_sdate=l_preh004 THEN  #日期等於結束日期       
        #            LET l_etime=l_preb006
        #         ELSE
        #            LET l_etime='23:59:59' 
        #         END IF                          
        #         INSERT INTO aprt310_preb_tmp VALUES(l_sdate,l_sdate,l_stime,l_etime)
        #      END IF        
        #      LET l_sdate=l_sdate+1
        #      IF l_sdate>l_edate THEN
        #         EXIT WHILE
        #      END IF 
        #   END WHILE
        #END IF    
        #暂时不管，固定日期和固定星期的设置(mark掉上面判断代码)---end---        
     END FOREACH  
 
#日期範圍是否重疊判斷
#---1、先判斷日期不等於情況
#---2、再判斷日期等於情況
     LET l_count=0
     SELECT count(*) INTO l_count   
       FROM aprt310_tmp01,aprt310_tmp02       #160727-00019#14 Mod   aprt310_preh_tmp -->aprt310_tmp01，aprt310_preb_tmp -->aprt310_tmp02
      WHERE (preh003>preb003 AND preh003<preb004)
         OR (preh004>preb003 AND preh004<preb004)   
         OR (preb003>preh003 AND preb003<preh004) 
         OR (preb004>preh003 AND preb004<preh004)
     IF cl_null(l_count) OR  l_count=0 THEN  #日期沒有重疊----繼續判斷日期時間是否重疊       
         LET l_count=0
         SELECT count(*) INTO l_count   
           FROM aprt310_tmp01,aprt310_tmp02      #160727-00019#14 Mod   aprt310_preh_tmp -->aprt310_tmp01，aprt310_preb_tmp -->aprt310_tmp02
          WHERE (preh003=preb003 AND ((preh005>=preb005 AND preh005<=preb006) OR (preb005>=preh005 AND preb005<=preh006)))
             OR (preh003=preb004 AND ((preh005>=preb005 AND preh005<=preb006) OR (preb006>=preh005 AND preb006<=preh006)))
             OR (preh004=preb003 AND ((preh006>=preb005 AND preh006<=preb006) OR (preb005>=preh005 AND preb005<=preh006)))
             OR (preh004=preb004 AND ((preh006>=preb005 AND preh006<=preb006) OR (preb006>=preh005 AND preb006<=preh006)))
             
         IF cl_null(l_count) OR l_count=0 THEN  #日期時間沒有重疊        
            LET r_success=TRUE
            RETURN r_success,r_errno
         END IF
     END IF
 
#1:買換--控管同一門店，同一日期範圍內換贈的同一卡種/券種，促銷規則不能有多筆。
#2:第一點控管住了，同一門店，同一時間範圍內同一卡種/券種，不同類型（散客和會員等級1-5）促銷力度不可能有不同了。
     IF NOT cl_null(l_count) AND l_count>0 THEN
        LET r_success=FALSE
        LET r_errno='apr-00493'
        RETURN r_success,r_errno 
     END IF        


##日期範圍有重疊----再盤點不同類型（散客和會員等級1-5）促銷力度是否一樣
#     
#     #散客
#     #散客促銷力度
#     LET l_num20=0
#     SELECT DISTINCT(prec009/prec010) INTO l_num20
#       FROM prec_t
#      WHERE precent=g_enterprise
#        AND precdocno=l_prea.preadocno
#        
#     #散客促銷力度，在一定時間範圍內，是否存在不同的力度。   
#     LET l_count=0   
#     SELECT COUNT(*) INTO l_count
#       FROM prei_t,preg_t
#      WHERE preient=pregent
#        AND prei001=preg001
#        AND prei001<>l_prea.prea001
#        AND pregstus<>'X'
#        AND preg004=l_prea.prea004
#        AND preg005=l_prea.prea005
#        AND preg006=l_prea.prea006
#        AND pregsite=l_prea.preasite        
#        AND preient=g_enterprise
#        AND prei009/prei010<>l_num20
#        AND prei001 IN (SELECT DISTINCT preh001
#                           FROM aprt310_preh_tmp,aprt310_preb_tmp 
#                          WHERE ((preh003>preb003 AND preh003<preb004) OR
#                                 (preh004>preb003 AND preh004<preb004) OR  
#                                 (preb003>preh003 AND preb003<preh004) OR
#                                 (preb004>preh003 AND preb004<preh004)
#                                ) OR (                               
#                                    (preh003=preb003 AND ((preh005>=preb005 AND preh005<=preb006) OR (preb005>=preh005 AND preb005<=preh006)))
#                                 OR (preh003=preb004 AND ((preh005>=preb005 AND preh005<=preb006) OR (preb006>=preh005 AND preb006<=preh006)))
#                                 OR (preh004=preb003 AND ((preh006>=preb005 AND preh006<=preb006) OR (preb005>=preh005 AND preb005<=preh006)))
#                                 OR (preh004=preb004 AND ((preh006>=preb005 AND preh006<=preb006) OR (preb006>=preh005 AND preb006<=preh006)))
#                                    )   
#                        )  
#     IF NOT cl_null(l_count) AND l_count>0 THEN #存在不同力度，報錯 return false     
#     
#        LET r_success=FALSE
#        LET r_errno='apr-00492'
#        RETURN r_success,r_errno           
#     END IF        
#
#     #各會員等級
#     #各會員等級促銷力度     
#     DECLARE aprt310_seloocq_cs CURSOR FOR SELECT DISTINCT oocq009 #會員等級
#                                               FROM oocq_t
#                                              WHERE oocqent = g_enterprise
#                                                AND oocq001 = '2024'
#                                                AND oocqstus='Y'
#                                                AND (oocq009='1' OR oocq009='2' OR oocq009='3' OR oocq009='4' OR oocq009='5')  #会员等级一\会员等级二\会员等级三\会员等级四\会员等级五
#     
#     FOREACH aprt310_seloocq_cs INTO l_oocq009
#        IF l_oocq009='1' THEN  #會員等級一            
#            LET l_num20=0
#            SELECT DISTINCT(prec011/prec012) INTO l_num20
#              FROM prec_t
#             WHERE precent=g_enterprise
#               AND precdocno=l_prea.preadocno
#               
#            #會員等級一 促銷力度，在一定時間範圍內，是否存在不同的力度。   
#            LET l_count=0   
#            SELECT COUNT(*) INTO l_count
#              FROM prei_t,preg_t
#             WHERE preient=pregent
#               AND prei001=preg001
#               AND preient=g_enterprise
#               AND prei001<>l_prea.prea001
#               AND pregstus<>'X'
#               AND preg004=l_prea.prea004
#               AND preg005=l_prea.prea005
#               AND preg006=l_prea.prea006
#               AND pregsite=l_prea.preasite                
#               AND prei011/prei012<>l_num20
#               AND prei001 IN (SELECT DISTINCT preh001
#                                  FROM aprt310_preh_tmp,aprt310_preb_tmp 
#                                 WHERE ((preh003>preb003 AND preh003<preb004) OR
#                                        (preh004>preb003 AND preh004<preb004) OR  
#                                        (preb003>preh003 AND preb003<preh004) OR
#                                        (preb004>preh003 AND preb004<preh004)
#                                       ) OR (                               
#                                           (preh003=preb003 AND ((preh005>=preb005 AND preh005<=preb006) OR (preb005>=preh005 AND preb005<=preh006)))
#                                        OR (preh003=preb004 AND ((preh005>=preb005 AND preh005<=preb006) OR (preb006>=preh005 AND preb006<=preh006)))
#                                        OR (preh004=preb003 AND ((preh006>=preb005 AND preh006<=preb006) OR (preb005>=preh005 AND preb005<=preh006)))
#                                        OR (preh004=preb004 AND ((preh006>=preb005 AND preh006<=preb006) OR (preb006>=preh005 AND preb006<=preh006)))
#                                           )   
#                               )  
#            IF NOT cl_null(l_count) AND l_count>0 THEN #存在不同力度，報錯 return false     
#            
#               LET r_success=FALSE
#               LET r_errno='apr-00492'
#               RETURN r_success,r_errno    
#            END IF                
#        END IF
#        
#        IF l_oocq009='2' THEN  #會員等級二           
#            LET l_num20=0
#            SELECT DISTINCT(prec013/prec014) INTO l_num20
#              FROM prec_t
#             WHERE precent=g_enterprise
#               AND precdocno=l_prea.preadocno
#               
#            #會員等級二 促銷力度，在一定時間範圍內，是否存在不同的力度。   
#            LET l_count=0   
#            SELECT COUNT(*) INTO l_count
#              FROM prei_t,preg_t
#             WHERE preient=pregent
#               AND prei001=preg001
#               AND preient=g_enterprise
#               AND prei001<>l_prea.prea001
#               AND pregstus<>'X'
#               AND preg004=l_prea.prea004
#               AND preg005=l_prea.prea005
#               AND preg006=l_prea.prea006
#               AND pregsite=l_prea.preasite               
#               AND prei013/prei014<>l_num20
#               AND prei001 IN (SELECT DISTINCT preh001
#                                  FROM aprt310_preh_tmp,aprt310_preb_tmp 
#                                 WHERE ((preh003>preb003 AND preh003<preb004) OR
#                                        (preh004>preb003 AND preh004<preb004) OR  
#                                        (preb003>preh003 AND preb003<preh004) OR
#                                        (preb004>preh003 AND preb004<preh004)
#                                       ) OR (                               
#                                           (preh003=preb003 AND ((preh005>=preb005 AND preh005<=preb006) OR (preb005>=preh005 AND preb005<=preh006)))
#                                        OR (preh003=preb004 AND ((preh005>=preb005 AND preh005<=preb006) OR (preb006>=preh005 AND preb006<=preh006)))
#                                        OR (preh004=preb003 AND ((preh006>=preb005 AND preh006<=preb006) OR (preb005>=preh005 AND preb005<=preh006)))
#                                        OR (preh004=preb004 AND ((preh006>=preb005 AND preh006<=preb006) OR (preb006>=preh005 AND preb006<=preh006)))
#                                           )   
#                               )  
#            IF NOT cl_null(l_count) AND l_count>0 THEN #存在不同力度，報錯 return false     
#            
#               LET r_success=FALSE
#               LET r_errno='apr-00492'
#               RETURN r_success,r_errno 
#            END IF                
#        END IF
#
#
#        IF l_oocq009='3' THEN  #會員等級三            
#            LET l_num20=0
#            SELECT DISTINCT(prec015/prec016) INTO l_num20
#              FROM prec_t
#             WHERE precent=g_enterprise
#               AND precdocno=l_prea.preadocno
#               
#            #會員等級三 促銷力度，在一定時間範圍內，是否存在不同的力度。   
#            LET l_count=0   
#            SELECT COUNT(*) INTO l_count
#              FROM prei_t,preg_t
#             WHERE preient=pregent
#               AND prei001=preg001
#               AND preient=g_enterprise
#               AND prei001<>l_prea.prea001 
#               AND pregstus<>'X'
#               AND preg004=l_prea.prea004
#               AND preg005=l_prea.prea005
#               AND preg006=l_prea.prea006
#               AND pregsite=l_prea.preasite               
#               AND prei015/prei016<>l_num20
#               AND prei001 IN (SELECT DISTINCT preh001
#                                  FROM aprt310_preh_tmp,aprt310_preb_tmp 
#                                 WHERE ((preh003>preb003 AND preh003<preb004) OR
#                                        (preh004>preb003 AND preh004<preb004) OR  
#                                        (preb003>preh003 AND preb003<preh004) OR
#                                        (preb004>preh003 AND preb004<preh004)
#                                       ) OR (                               
#                                           (preh003=preb003 AND ((preh005>=preb005 AND preh005<=preb006) OR (preb005>=preh005 AND preb005<=preh006)))
#                                        OR (preh003=preb004 AND ((preh005>=preb005 AND preh005<=preb006) OR (preb006>=preh005 AND preb006<=preh006)))
#                                        OR (preh004=preb003 AND ((preh006>=preb005 AND preh006<=preb006) OR (preb005>=preh005 AND preb005<=preh006)))
#                                        OR (preh004=preb004 AND ((preh006>=preb005 AND preh006<=preb006) OR (preb006>=preh005 AND preb006<=preh006)))
#                                           )   
#                               )  
#            IF NOT cl_null(l_count) AND l_count>0 THEN #存在不同力度，報錯 return false     
#            
#               LET r_success=FALSE
#               LET r_errno='apr-00492'
#               RETURN r_success,r_errno  
#            END IF                
#        END IF
#
#        IF l_oocq009='4' THEN  #會員等級四            
#            LET l_num20=0
#            SELECT DISTINCT(prec017/prec018) INTO l_num20
#              FROM prec_t
#             WHERE precent=g_enterprise
#               AND precdocno=l_prea.preadocno
#               
#            #會員等級四 促銷力度，在一定時間範圍內，是否存在不同的力度。   
#            LET l_count=0   
#            SELECT COUNT(*) INTO l_count
#              FROM prei_t,preg_t
#             WHERE preient=pregent
#               AND prei001=preg001
#               AND preient=g_enterprise
#               AND prei001<>l_prea.prea001 
#               AND pregstus<>'X'
#               AND preg004=l_prea.prea004
#               AND preg005=l_prea.prea005
#               AND preg006=l_prea.prea006
#               AND pregsite=l_prea.preasite               
#               AND prei017/prei018<>l_num20
#               AND prei001 IN (SELECT DISTINCT preh001
#                                  FROM aprt310_preh_tmp,aprt310_preb_tmp 
#                                 WHERE ((preh003>preb003 AND preh003<preb004) OR
#                                        (preh004>preb003 AND preh004<preb004) OR  
#                                        (preb003>preh003 AND preb003<preh004) OR
#                                        (preb004>preh003 AND preb004<preh004)
#                                       ) OR (                               
#                                           (preh003=preb003 AND ((preh005>=preb005 AND preh005<=preb006) OR (preb005>=preh005 AND preb005<=preh006)))
#                                        OR (preh003=preb004 AND ((preh005>=preb005 AND preh005<=preb006) OR (preb006>=preh005 AND preb006<=preh006)))
#                                        OR (preh004=preb003 AND ((preh006>=preb005 AND preh006<=preb006) OR (preb005>=preh005 AND preb005<=preh006)))
#                                        OR (preh004=preb004 AND ((preh006>=preb005 AND preh006<=preb006) OR (preb006>=preh005 AND preb006<=preh006)))
#                                           )   
#                               )  
#            IF NOT cl_null(l_count) AND l_count>0 THEN #存在不同力度，報錯 return false     
#            
#               LET r_success=FALSE
#               LET r_errno='apr-00492'
#               RETURN r_success,r_errno  
#            END IF                
#        END IF
#
#        IF l_oocq009='5' THEN  #會員等級五            
#            LET l_num20=0
#            SELECT DISTINCT(prec019/prec020) INTO l_num20
#              FROM prec_t
#             WHERE precent=g_enterprise
#               AND precdocno=l_prea.preadocno
#               
#            #會員等級五 促銷力度，在一定時間範圍內，是否存在不同的力度。   
#            LET l_count=0   
#            SELECT COUNT(*) INTO l_count
#              FROM prei_t,preg_t
#             WHERE preient=pregent
#               AND prei001=preg001
#               AND preient=g_enterprise
#               AND prei001<>l_prea.prea001 
#               AND pregstus<>'X'
#               AND preg004=l_prea.prea004
#               AND preg005=l_prea.prea005
#               AND preg006=l_prea.prea006
#               AND pregsite=l_prea.preasite               
#               AND prei019/prei020<>l_num20
#               AND prei001 IN (SELECT DISTINCT preh001
#                                  FROM aprt310_preh_tmp,aprt310_preb_tmp 
#                                 WHERE ((preh003>preb003 AND preh003<preb004) OR
#                                        (preh004>preb003 AND preh004<preb004) OR  
#                                        (preb003>preh003 AND preb003<preh004) OR
#                                        (preb004>preh003 AND preb004<preh004)
#                                       ) OR (                               
#                                           (preh003=preb003 AND ((preh005>=preb005 AND preh005<=preb006) OR (preb005>=preh005 AND preb005<=preh006)))
#                                        OR (preh003=preb004 AND ((preh005>=preb005 AND preh005<=preb006) OR (preb006>=preh005 AND preb006<=preh006)))
#                                        OR (preh004=preb003 AND ((preh006>=preb005 AND preh006<=preb006) OR (preb005>=preh005 AND preb005<=preh006)))
#                                        OR (preh004=preb004 AND ((preh006>=preb005 AND preh006<=preb006) OR (preb006>=preh005 AND preb006<=preh006)))
#                                           )   
#                               )  
#            IF NOT cl_null(l_count) AND l_count>0 THEN #存在不同力度，報錯 return false     
#            
#               LET r_success=FALSE
#               LET r_errno='apr-00492'
#               RETURN r_success,r_errno  
#            END IF                
#        END IF
#     END FOREACH

     RETURN r_success,r_errno  
    
END FUNCTION

################################################################################
# Descriptions...: 整合用的确认功能元件
# Date & Author..: 160604-00001#1 2016/06/30 By 08172
# Modify.........:
################################################################################
PRIVATE FUNCTION aprt310_ws_confirm()
   DEFINE r_success   LIKE type_t.num5
   DEFINE l_chr50   LIKE type_t.num5
   LET r_success = TRUE
   LET l_chr50=''
   CALL aprt310_conf_chk() RETURNING r_success,g_errno,l_chr50
   IF r_success THEN
      CALL aprt310_conf_upd() RETURNING r_success
   ELSE
      IF cl_null(l_chr50) THEN
         LET l_chr50=g_prea_m.preadocno
      END IF                  
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = g_errno
      LET g_errparam.extend = l_chr50
      LET g_errparam.popup = TRUE
      CALL cl_err()
   END IF
   RETURN r_success 
END FUNCTION

 
{</section>}
 
