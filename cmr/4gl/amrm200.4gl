#該程式未解開Section, 採用最新樣板產出!
{<section id="amrm200.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0003(2016-07-29 01:31:05), PR版次:0003(2016-12-26 14:13:30)
#+ Customerized Version.: SD版次:0003(2017-04-10 16:07:29), PR版次:0003(2017-04-13 18:16:18)
#+ Build......: 000254
#+ Filename...: amrm200
#+ Description: 資源主檔維護作業
#+ Creator....: 01996(2014-01-20 19:12:14)
#+ Modifier...: 00593 -SD/PR- 06978
 
{</section>}
 
{<section id="amrm200.global" >}
#應用 t01 樣板自動產生(Version:79)
#add-point:填寫註解說明 name="global.memo" 
#151215-00002#3    2016/01/07 By Dorislai   1.資源群組開窗、校驗判斷amri003的類型(amrm200資源群組←→amri003類型)
#                                           2.單頭輸入確認後，檢查資源編號+資源群組是否存在於mrbi_t，不存在則新增一筆mrbi_t。
#                                           3.資料刪除時，一併刪除該資料編號的mrbi_t
#160318-00025#6    2016/04/14 By 07675      將重複內容的錯誤訊息置換為公用錯誤訊息(r.v）
#150615-00004#1    2016/05/09 By Dorislai   1.修正"頁籤-適用機台資源"資源名稱、資源簡稱沒顯示的問題
#                                           2.修正按"Action-使用"後，"頁籤-資源壽命管理"的資源啟動日期沒有立即重新顯示
#160524-00044#1    2016/06/03 By shiun      资源日产能、产能单位、嫁动日起始时间拿掉、穴数改用一个栏位表示、拿掉mrba037 
#160624-00006#1    2016/07/01 By catmoon    1.啟用日期(mrba033).累積運作次數(mrba041)不可直接輸入
#                                           2.取得日期(mrba032)在確認之後不可修改
#                                           3.除役日期(mrba034)不可小於啟用日期(mrba033)
#160716-00011#1    2016/07/22 By Sarah      所有權據點的1.開窗目前使用q_ooef001_04,開出來的資料不對,請改成使用q_ooef001_12
#                                                      2.校驗目前使用v_ooef001_3,檢查結果不對,請改成使用v_ooef001_20
#160716-00003#1    2016/07/28 By Sarah      原本使用q_imaa001開窗的通通改成開據點級的料號,使用v_imaa001校驗的通通改成v_imaf001
#160801-00023#4    2016/08/02 By 02097      不使用進階APS時，資源編號皆視為設備，且不新增進mrbi_t內
#160812-00017#5    2016/08/15 By 06137      在satatchange( )的FUNCTION中，有RETURN指令但沒有加上transaction_end( ) 造成transaction沒有結束就直接RETURN
#160818-00017#32   2016/08/25 By 08742      删除修改未重新判断状态码
#160818-00017#47   2016/09/01 By lixiang    审核之后可以修改
#160816-00009#1    2016/09/21 By Sarah      做完整單操作的任一動作後，要重讀狀態來判斷其他ACTION可不可以執行
#161013-00051#1    2016/10/18 By shiun      整批調整據點組織開窗
#161226-00026#1    2016/12/26 By ywtsai     查詢時所有權據點/客戶(mrba020)開窗使q_mrba020
#end add-point
#add-point:填寫註解說明(客製用) name="global.memo_customerization"
#C2017041001guotao  新增修改时，当mrba000='3'时，当前位置mrba018字段 不可为空，为必填字段且数据来源只能是cmri001中oocq039='1'的位置编码  
#C2017041301chenyang  修改#C2017041001guotao bug
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
PRIVATE type type_g_mrba_m        RECORD
       mrba019 LIKE mrba_t.mrba019, 
   mrba000 LIKE mrba_t.mrba000, 
   mrba001 LIKE mrba_t.mrba001, 
   mrba002 LIKE mrba_t.mrba002, 
   mrba003 LIKE mrba_t.mrba003, 
   mrba066 LIKE mrba_t.mrba066, 
   mrba004 LIKE mrba_t.mrba004, 
   mrba005 LIKE mrba_t.mrba005, 
   mrba007 LIKE mrba_t.mrba007, 
   mrba008 LIKE mrba_t.mrba008, 
   mrba009 LIKE mrba_t.mrba009, 
   mrba010 LIKE mrba_t.mrba010, 
   mrba010_desc LIKE type_t.chr80, 
   mrba011 LIKE mrba_t.mrba011, 
   mrba011_desc LIKE type_t.chr80, 
   mrba020 LIKE mrba_t.mrba020, 
   mrba020_desc LIKE type_t.chr80, 
   mrba006 LIKE mrba_t.mrba006, 
   mrba104 LIKE mrba_t.mrba104, 
   mrba012 LIKE mrba_t.mrba012, 
   mrba012_desc LIKE type_t.chr80, 
   mrba013 LIKE mrba_t.mrba013, 
   mrba013_desc LIKE type_t.chr80, 
   mrba014 LIKE mrba_t.mrba014, 
   mrba014_desc LIKE type_t.chr80, 
   mrba015 LIKE mrba_t.mrba015, 
   mrba016 LIKE mrba_t.mrba016, 
   mrba016_desc LIKE type_t.chr80, 
   mrba017 LIKE mrba_t.mrba017, 
   mrba017_desc LIKE type_t.chr80, 
   mrba018 LIKE mrba_t.mrba018, 
   mrba018_desc LIKE type_t.chr80, 
   mrba102 LIKE mrba_t.mrba102, 
   mrba100 LIKE mrba_t.mrba100, 
   mrba101 LIKE mrba_t.mrba101, 
   mrbastus LIKE mrba_t.mrbastus, 
   mrba021 LIKE mrba_t.mrba021, 
   mrba021_desc LIKE type_t.chr80, 
   mrba022 LIKE mrba_t.mrba022, 
   mrba022_desc LIKE type_t.chr80, 
   mrba025 LIKE mrba_t.mrba025, 
   mrba026 LIKE mrba_t.mrba026, 
   mrba027 LIKE mrba_t.mrba027, 
   mrba027_desc LIKE type_t.chr80, 
   mrba103 LIKE mrba_t.mrba103, 
   mrba103_desc LIKE type_t.chr80, 
   mrba029 LIKE mrba_t.mrba029, 
   mrba031 LIKE mrba_t.mrba031, 
   mrba032 LIKE mrba_t.mrba032, 
   mrba033 LIKE mrba_t.mrba033, 
   mrba034 LIKE mrba_t.mrba034, 
   mrba035 LIKE mrba_t.mrba035, 
   mrba036 LIKE mrba_t.mrba036, 
   mrba038 LIKE mrba_t.mrba038, 
   mrba039 LIKE mrba_t.mrba039, 
   mrba040 LIKE mrba_t.mrba040, 
   mrba040_desc LIKE type_t.chr80, 
   mrba041 LIKE mrba_t.mrba041, 
   mrba042 LIKE mrba_t.mrba042, 
   mrbaownid LIKE mrba_t.mrbaownid, 
   mrbaownid_desc LIKE type_t.chr80, 
   mrbaowndp LIKE mrba_t.mrbaowndp, 
   mrbaowndp_desc LIKE type_t.chr80, 
   mrbacrtid LIKE mrba_t.mrbacrtid, 
   mrbacrtid_desc LIKE type_t.chr80, 
   mrbacrtdp LIKE mrba_t.mrbacrtdp, 
   mrbacrtdp_desc LIKE type_t.chr80, 
   mrbacrtdt LIKE mrba_t.mrbacrtdt, 
   mrbamodid LIKE mrba_t.mrbamodid, 
   mrbamodid_desc LIKE type_t.chr80, 
   mrbamoddt LIKE mrba_t.mrbamoddt, 
   mrbacnfid LIKE mrba_t.mrbacnfid, 
   mrbacnfid_desc LIKE type_t.chr80, 
   mrbacnfdt LIKE mrba_t.mrbacnfdt
       END RECORD
 
#單身 type 宣告
PRIVATE TYPE type_g_mrbb_d        RECORD
       mrbbstus LIKE mrbb_t.mrbbstus, 
   mrbb002 LIKE mrbb_t.mrbb002, 
   mrbb003 LIKE mrbb_t.mrbb003, 
   mrbb003_desc LIKE type_t.chr500, 
   mrbb004 LIKE mrbb_t.mrbb004, 
   mrbb004_desc LIKE type_t.chr500, 
   mrbb005 LIKE mrbb_t.mrbb005, 
   mrbb006 LIKE mrbb_t.mrbb006, 
   mrbb006_desc LIKE type_t.chr500, 
   mrbb007 LIKE mrbb_t.mrbb007, 
   mrbb008 LIKE mrbb_t.mrbb008, 
   mrbb009 LIKE mrbb_t.mrbb009, 
   mrbb010 LIKE mrbb_t.mrbb010, 
   mrbb011 LIKE mrbb_t.mrbb011, 
   mrbb012 LIKE mrbb_t.mrbb012, 
   mrbb012_desc LIKE type_t.chr500, 
   mrbb013 LIKE mrbb_t.mrbb013
       END RECORD
PRIVATE TYPE type_g_mrbb2_d RECORD
       mrbc002 LIKE mrbc_t.mrbc002, 
   mrbc003 LIKE mrbc_t.mrbc003, 
   mrbc004 LIKE mrbc_t.mrbc004, 
   mrbc005 LIKE mrbc_t.mrbc005, 
   mrbc006 LIKE mrbc_t.mrbc006, 
   mrbc007 LIKE mrbc_t.mrbc007, 
   mrbc008 LIKE mrbc_t.mrbc008, 
   mrbc009 LIKE mrbc_t.mrbc009, 
   mrbc010 LIKE mrbc_t.mrbc010, 
   mrbc011 LIKE mrbc_t.mrbc011
       END RECORD
PRIVATE TYPE type_g_mrbb3_d RECORD
       mrbd002 LIKE mrbd_t.mrbd002, 
   mrbd003 LIKE mrbd_t.mrbd003, 
   mrbd003_desc LIKE type_t.chr500, 
   mrbd003_desc_desc LIKE type_t.chr500, 
   mrbd004 LIKE mrbd_t.mrbd004, 
   mrbd005 LIKE mrbd_t.mrbd005, 
   mrbd005_desc LIKE type_t.chr500, 
   mrbd006 LIKE mrbd_t.mrbd006, 
   mrbd006_desc LIKE type_t.chr500, 
   mrbd007 LIKE mrbd_t.mrbd007, 
   mrbd008 LIKE mrbd_t.mrbd008, 
   mrbd009 LIKE mrbd_t.mrbd009, 
   mrbd010 LIKE mrbd_t.mrbd010, 
   inag008 LIKE type_t.num20_6
       END RECORD
PRIVATE TYPE type_g_mrbb4_d RECORD
       mrbe002 LIKE mrbe_t.mrbe002, 
   mrbe002_desc LIKE type_t.chr500, 
   mrbe002_desc_desc LIKE type_t.chr500
       END RECORD
PRIVATE TYPE type_g_mrbb5_d RECORD
       mrbf002 LIKE mrbf_t.mrbf002, 
   mrbf002_desc LIKE type_t.chr500, 
   mrbf002_desc_desc LIKE type_t.chr500
       END RECORD
PRIVATE TYPE type_g_mrbb6_d RECORD
       mrbg002 LIKE mrbg_t.mrbg002, 
   mrbg003 LIKE mrbg_t.mrbg003, 
   mrbg004 LIKE mrbg_t.mrbg004, 
   mrbg004_desc LIKE type_t.chr500, 
   mrbg005 LIKE mrbg_t.mrbg005, 
   mrbg006 LIKE mrbg_t.mrbg006, 
   mrbg007 LIKE mrbg_t.mrbg007, 
   mrbg008 LIKE mrbg_t.mrbg008
       END RECORD
 
 
PRIVATE TYPE type_browser RECORD
         b_statepic     LIKE type_t.chr50,
            b_mrba001 LIKE mrba_t.mrba001,
      b_mrba000 LIKE mrba_t.mrba000,
      b_mrba002 LIKE mrba_t.mrba002,
      b_mrba003 LIKE mrba_t.mrba003,
      b_mrba004 LIKE mrba_t.mrba004,
      b_mrba005 LIKE mrba_t.mrba005
       END RECORD
       
#add-point:自定義模組變數(Module Variable) (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="global.variable"
DEFINE g_flag              LIKE type_t.num5
DEFINE g_page_choice       STRING
DEFINE g_smfg0036          LIKE type_t.chr1     #160801-00023#4
#end add-point
       
#模組變數(Module Variables)
DEFINE g_mrba_m          type_g_mrba_m
DEFINE g_mrba_m_t        type_g_mrba_m
DEFINE g_mrba_m_o        type_g_mrba_m
DEFINE g_mrba_m_mask_o   type_g_mrba_m #轉換遮罩前資料
DEFINE g_mrba_m_mask_n   type_g_mrba_m #轉換遮罩後資料
 
   DEFINE g_mrba001_t LIKE mrba_t.mrba001
 
 
DEFINE g_mrbb_d          DYNAMIC ARRAY OF type_g_mrbb_d
DEFINE g_mrbb_d_t        type_g_mrbb_d
DEFINE g_mrbb_d_o        type_g_mrbb_d
DEFINE g_mrbb_d_mask_o   DYNAMIC ARRAY OF type_g_mrbb_d #轉換遮罩前資料
DEFINE g_mrbb_d_mask_n   DYNAMIC ARRAY OF type_g_mrbb_d #轉換遮罩後資料
DEFINE g_mrbb2_d          DYNAMIC ARRAY OF type_g_mrbb2_d
DEFINE g_mrbb2_d_t        type_g_mrbb2_d
DEFINE g_mrbb2_d_o        type_g_mrbb2_d
DEFINE g_mrbb2_d_mask_o   DYNAMIC ARRAY OF type_g_mrbb2_d #轉換遮罩前資料
DEFINE g_mrbb2_d_mask_n   DYNAMIC ARRAY OF type_g_mrbb2_d #轉換遮罩後資料
DEFINE g_mrbb3_d          DYNAMIC ARRAY OF type_g_mrbb3_d
DEFINE g_mrbb3_d_t        type_g_mrbb3_d
DEFINE g_mrbb3_d_o        type_g_mrbb3_d
DEFINE g_mrbb3_d_mask_o   DYNAMIC ARRAY OF type_g_mrbb3_d #轉換遮罩前資料
DEFINE g_mrbb3_d_mask_n   DYNAMIC ARRAY OF type_g_mrbb3_d #轉換遮罩後資料
DEFINE g_mrbb4_d          DYNAMIC ARRAY OF type_g_mrbb4_d
DEFINE g_mrbb4_d_t        type_g_mrbb4_d
DEFINE g_mrbb4_d_o        type_g_mrbb4_d
DEFINE g_mrbb4_d_mask_o   DYNAMIC ARRAY OF type_g_mrbb4_d #轉換遮罩前資料
DEFINE g_mrbb4_d_mask_n   DYNAMIC ARRAY OF type_g_mrbb4_d #轉換遮罩後資料
DEFINE g_mrbb5_d          DYNAMIC ARRAY OF type_g_mrbb5_d
DEFINE g_mrbb5_d_t        type_g_mrbb5_d
DEFINE g_mrbb5_d_o        type_g_mrbb5_d
DEFINE g_mrbb5_d_mask_o   DYNAMIC ARRAY OF type_g_mrbb5_d #轉換遮罩前資料
DEFINE g_mrbb5_d_mask_n   DYNAMIC ARRAY OF type_g_mrbb5_d #轉換遮罩後資料
DEFINE g_mrbb6_d          DYNAMIC ARRAY OF type_g_mrbb6_d
DEFINE g_mrbb6_d_t        type_g_mrbb6_d
DEFINE g_mrbb6_d_o        type_g_mrbb6_d
DEFINE g_mrbb6_d_mask_o   DYNAMIC ARRAY OF type_g_mrbb6_d #轉換遮罩前資料
DEFINE g_mrbb6_d_mask_n   DYNAMIC ARRAY OF type_g_mrbb6_d #轉換遮罩後資料
 
 
DEFINE g_browser         DYNAMIC ARRAY OF type_browser
DEFINE g_browser_f       DYNAMIC ARRAY OF type_browser
 
 
DEFINE g_wc                  STRING
DEFINE g_wc_t                STRING
DEFINE g_wc2                 STRING                          #單身CONSTRUCT結果
DEFINE g_wc2_table1          STRING
DEFINE g_wc2_table2   STRING
 
DEFINE g_wc2_table3   STRING
 
DEFINE g_wc2_table4   STRING
 
DEFINE g_wc2_table5   STRING
 
DEFINE g_wc2_table6   STRING
 
 
 
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
 
{<section id="amrm200.main" >}
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
   CALL cl_ap_init("cmr","")
 
   #add-point:作業初始化 name="main.init"
   LET g_flag  = FALSE
   INITIALIZE g_page_choice TO NULL
   CALL s_amri007_crt_temp_table()
   #end add-point
   
   
 
   #LOCK CURSOR (identifier)
   #add-point:SQL_define name="main.define_sql"
   
   #end add-point
   LET g_forupd_sql = " SELECT mrba019,mrba000,mrba001,mrba002,mrba003,mrba066,mrba004,mrba005,mrba007, 
       mrba008,mrba009,mrba010,'',mrba011,'',mrba020,'',mrba006,mrba104,mrba012,'',mrba013,'',mrba014, 
       '',mrba015,mrba016,'',mrba017,'',mrba018,'',mrba102,mrba100,mrba101,mrbastus,mrba021,'',mrba022, 
       '',mrba025,mrba026,mrba027,'',mrba103,'',mrba029,mrba031,mrba032,mrba033,mrba034,mrba035,mrba036, 
       mrba038,mrba039,mrba040,'',mrba041,mrba042,mrbaownid,'',mrbaowndp,'',mrbacrtid,'',mrbacrtdp,'', 
       mrbacrtdt,mrbamodid,'',mrbamoddt,mrbacnfid,'',mrbacnfdt", 
                      " FROM mrba_t",
                      " WHERE mrbaent= ? AND mrbasite= ? AND mrba001=? FOR UPDATE"
   #add-point:SQL_define name="main.after_define_sql"
   
   #end add-point
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)                #轉換不同資料庫語法
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE amrm200_cl CURSOR FROM g_forupd_sql                 # LOCK CURSOR
 
   LET g_sql = " SELECT DISTINCT t0.mrba019,t0.mrba000,t0.mrba001,t0.mrba002,t0.mrba003,t0.mrba066,t0.mrba004, 
       t0.mrba005,t0.mrba007,t0.mrba008,t0.mrba009,t0.mrba010,t0.mrba011,t0.mrba020,t0.mrba006,t0.mrba104, 
       t0.mrba012,t0.mrba013,t0.mrba014,t0.mrba015,t0.mrba016,t0.mrba017,t0.mrba018,t0.mrba102,t0.mrba100, 
       t0.mrba101,t0.mrbastus,t0.mrba021,t0.mrba022,t0.mrba025,t0.mrba026,t0.mrba027,t0.mrba103,t0.mrba029, 
       t0.mrba031,t0.mrba032,t0.mrba033,t0.mrba034,t0.mrba035,t0.mrba036,t0.mrba038,t0.mrba039,t0.mrba040, 
       t0.mrba041,t0.mrba042,t0.mrbaownid,t0.mrbaowndp,t0.mrbacrtid,t0.mrbacrtdp,t0.mrbacrtdt,t0.mrbamodid, 
       t0.mrbamoddt,t0.mrbacnfid,t0.mrbacnfdt,t1.oocql004 ,t2.oocql004 ,t3.ooefl003 ,t4.oocgl003 ,t5.pmaal004 , 
       t6.pmaal004 ,t7.ooag011 ,t8.ooefl003 ,t9.oocql004 ,t10.oocql004 ,t11.ecaa002 ,t12.oocql004 ,t13.oogd002 , 
       t14.ooail003 ,t15.ooag011 ,t16.ooefl003 ,t17.ooag011 ,t18.ooefl003 ,t19.ooag011 ,t20.ooag011", 
 
               " FROM mrba_t t0",
                              " LEFT JOIN oocql_t t1 ON t1.oocqlent="||g_enterprise||" AND t1.oocql001='1101' AND t1.oocql002=t0.mrba010 AND t1.oocql003='"||g_dlang||"' ",
               " LEFT JOIN oocql_t t2 ON t2.oocqlent="||g_enterprise||" AND t2.oocql001='1102' AND t2.oocql002=t0.mrba011 AND t2.oocql003='"||g_dlang||"' ",
               " LEFT JOIN ooefl_t t3 ON t3.ooeflent="||g_enterprise||" AND t3.ooefl001=t0.mrba020 AND t3.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN oocgl_t t4 ON t4.oocglent="||g_enterprise||" AND t4.oocgl001=t0.mrba012 AND t4.oocgl002='"||g_dlang||"' ",
               " LEFT JOIN pmaal_t t5 ON t5.pmaalent="||g_enterprise||" AND t5.pmaal001=t0.mrba013 AND t5.pmaal002='"||g_dlang||"' ",
               " LEFT JOIN pmaal_t t6 ON t6.pmaalent="||g_enterprise||" AND t6.pmaal001=t0.mrba014 AND t6.pmaal002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t7 ON t7.ooagent="||g_enterprise||" AND t7.ooag001=t0.mrba016  ",
               " LEFT JOIN ooefl_t t8 ON t8.ooeflent="||g_enterprise||" AND t8.ooefl001=t0.mrba017 AND t8.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN oocql_t t9 ON t9.oocqlent="||g_enterprise||" AND t9.oocql001='9001' AND t9.oocql002=t0.mrba018 AND t9.oocql003='"||g_dlang||"' ",
               " LEFT JOIN oocql_t t10 ON t10.oocqlent="||g_enterprise||" AND t10.oocql001='221' AND t10.oocql002=t0.mrba021 AND t10.oocql003='"||g_dlang||"' ",
               " LEFT JOIN ecaa_t t11 ON t11.ecaaent="||g_enterprise||" AND t11.ecaasite=t0.mrbasite AND t11.ecaa001=t0.mrba022  ",
               " LEFT JOIN oocql_t t12 ON t12.oocqlent="||g_enterprise||" AND t12.oocql001='1103' AND t12.oocql002=t0.mrba027 AND t12.oocql003='"||g_dlang||"' ",
               " LEFT JOIN oogd_t t13 ON t13.oogdent="||g_enterprise||" AND t13.oogdsite=t0.mrbasite AND t13.oogd001=t0.mrba103  ",
               " LEFT JOIN ooail_t t14 ON t14.ooailent="||g_enterprise||" AND t14.ooail001=t0.mrba040 AND t14.ooail002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t15 ON t15.ooagent="||g_enterprise||" AND t15.ooag001=t0.mrbaownid  ",
               " LEFT JOIN ooefl_t t16 ON t16.ooeflent="||g_enterprise||" AND t16.ooefl001=t0.mrbaowndp AND t16.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t17 ON t17.ooagent="||g_enterprise||" AND t17.ooag001=t0.mrbacrtid  ",
               " LEFT JOIN ooefl_t t18 ON t18.ooeflent="||g_enterprise||" AND t18.ooefl001=t0.mrbacrtdp AND t18.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t19 ON t19.ooagent="||g_enterprise||" AND t19.ooag001=t0.mrbamodid  ",
               " LEFT JOIN ooag_t t20 ON t20.ooagent="||g_enterprise||" AND t20.ooag001=t0.mrbacnfid  ",
 
               " WHERE t0.mrbaent = " ||g_enterprise|| " AND t0.mrbasite = ? AND t0.mrba001 = ?"
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   #add-point:SQL_define name="main.after_refresh_sql"
   
   #end add-point
   PREPARE amrm200_master_referesh FROM g_sql
 
    
 
   
   IF g_bgjob = "Y" THEN
      #add-point:Service Call name="main.servicecall"
      
      #end add-point
   ELSE
      #畫面開啟 (identifier)
      OPEN WINDOW w_amrm200 WITH FORM cl_ap_formpath("cmr",g_code)
   
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
   
      #程式初始化
      CALL amrm200_init()   
 
      #進入選單 Menu (="N")
      CALL amrm200_ui_dialog() 
      
      #add-point:畫面關閉前 name="main.before_close"
      CALL s_amri007_drop_temp_table()
      #end add-point
 
      #畫面關閉
      CLOSE WINDOW w_amrm200
      
   END IF 
   
   CLOSE amrm200_cl
   
   
 
   #add-point:作業離開前 name="main.exit"
   
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
END MAIN
 
 
 
 
{</section>}
 
{<section id="amrm200.init" >}
#+ 瀏覽頁簽資料初始化
PRIVATE FUNCTION amrm200_init()
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
   LET g_detail_idx_list[2] = 1
   LET g_detail_idx_list[3] = 1
   LET g_detail_idx_list[4] = 1
   LET g_detail_idx_list[5] = 1
   LET g_detail_idx_list[6] = 1
 
   LET g_error_show  = 1
   LET l_ac = 1 #單身指標
      CALL cl_set_combo_scc_part('mrbastus','50','N,Y,X')
 
      CALL cl_set_combo_scc('mrba019','5201') 
   CALL cl_set_combo_scc('mrba000','5202') 
   CALL cl_set_combo_scc('mrba100','5203') 
   CALL cl_set_combo_scc('mrba031','5205') 
   CALL cl_set_combo_scc('mrba039','5204') 
   CALL cl_set_combo_scc('mrba042','5206') 
   CALL cl_set_combo_scc('mrbb005','5201') 
   CALL cl_set_combo_scc('mrbb010','5204') 
   CALL cl_set_combo_scc('mrbc004','5207') 
   CALL cl_set_combo_scc('mrbc005','5208') 
 
   LET gwin_curr = ui.Window.getCurrent()  #取得現行畫面
   LET gfrm_curr = gwin_curr.getForm()     #取出物件化後的畫面物件
   
   #page群組
   LET g_idx_group = om.SaxAttributes.create()
   CALL g_idx_group.addAttribute("'1',","1")
   CALL g_idx_group.addAttribute("'2',","1")
   CALL g_idx_group.addAttribute("'3',","1")
   CALL g_idx_group.addAttribute("'4',","1")
   CALL g_idx_group.addAttribute("'5',","1")
   CALL g_idx_group.addAttribute("'6',","1")
 
 
   #add-point:畫面資料初始化 name="init.init"
   CALL cl_set_combo_scc('b_mrba000','5202') 
   CALL cl_get_para(g_enterprise,g_site,'S-MFG-0036') RETURNING g_smfg0036          #160801-00023#4
   #end add-point
   
   #初始化搜尋條件
   CALL amrm200_default_search()
    
END FUNCTION
 
{</section>}
 
{<section id="amrm200.ui_dialog" >}
#+ 功能選單
PRIVATE FUNCTION amrm200_ui_dialog()
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
 
   #因應查詢方案進行處理
   IF g_default THEN
      CALL gfrm_curr.setElementHidden("mainlayout",0)
      CALL gfrm_curr.setElementHidden("worksheet",1)
      LET g_main_hidden = 0
   ELSE
      CALL gfrm_curr.setElementHidden("mainlayout",1)
      CALL gfrm_curr.setElementHidden("worksheet",0)
      LET g_main_hidden = 1
   END IF
   
   #action default動作
   #應用 a42 樣板自動產生(Version:3)
   #進入程式時預設執行的動作
   CASE g_actdefault
      WHEN "insert"
         LET g_action_choice="insert"
         LET g_actdefault = ""
         IF cl_auth_chk_act("insert") THEN
            CALL amrm200_insert()
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
         INITIALIZE g_mrba_m.* TO NULL
         CALL g_mrbb_d.clear()
         CALL g_mrbb2_d.clear()
         CALL g_mrbb3_d.clear()
         CALL g_mrbb4_d.clear()
         CALL g_mrbb5_d.clear()
         CALL g_mrbb6_d.clear()
 
         LET g_wc  = ' 1=2'
         LET g_wc2 = ' 1=1'
         LET g_action_choice = ""
         CALL amrm200_init()
      END IF
   
      CALL lib_cl_dlg.cl_dlg_before_display()
            
      DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
 
         #左側瀏覽頁簽
         DISPLAY ARRAY g_browser TO s_browse.* ATTRIBUTES(COUNT=g_header_cnt)
            BEFORE ROW
               #回歸舊筆數位置 (回到當時異動的筆數)
               LET g_current_idx = DIALOG.getCurrentRow("s_browse")
               IF g_current_row > 1 AND g_current_idx = 1 AND g_current_sw = FALSE THEN
                  CALL DIALOG.setCurrentRow("s_browse",g_current_row)
                  LET g_current_idx = g_current_row
               END IF
               LET g_current_row = g_current_idx #目前指標
               LET g_current_sw = TRUE
         
               IF g_current_idx > g_browser.getLength() THEN
                  LET g_current_idx = g_browser.getLength()
               END IF 
               
               CALL amrm200_fetch('') # reload data
               LET l_ac = 1
               CALL amrm200_ui_detailshow() #Setting the current row 
         
               CALL amrm200_idx_chk()
               #NEXT FIELD mrbb002
         
               ON ACTION qbefield_user   #欄位隱藏設定 
                  LET g_action_choice="qbefield_user"
                  CALL cl_ui_qbefield_user()
         END DISPLAY
    
         DISPLAY ARRAY g_mrbb_d TO s_detail1.* ATTRIBUTES(COUNT=g_rec_b) #page1  
    
            BEFORE ROW
               #顯示單身筆數
               CALL amrm200_idx_chk()
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
               CALL amrm200_idx_chk()
               #add-point:page1自定義行為 name="ui_dialog.page1.before_display"
               
               #end add-point
               
            #自訂ACTION(detail_show,page_1)
            
               
            #add-point:page1自定義行為 name="ui_dialog.page1.action"
            
            #end add-point
               
         END DISPLAY
        
         #第一階單身段落
         DISPLAY ARRAY g_mrbb2_d TO s_detail2.* ATTRIBUTES(COUNT=g_rec_b)  
    
            BEFORE ROW
               #顯示單身筆數
               CALL amrm200_idx_chk()
               LET l_ac = DIALOG.getCurrentRow("s_detail2")
               LET g_detail_idx = l_ac
               LET g_detail_idx_list[2] = l_ac
               CALL g_idx_group.addAttribute("'2',",l_ac)
               
               #add-point:page2, before row動作 name="ui_dialog.body2.before_row"
               
               #end add-point
               
            BEFORE DISPLAY
               #如果一直都在單身1則控制筆數位置
               IF g_loc = 'm' THEN
                  CALL FGL_SET_ARR_CURR(g_idx_group.getValue("'2',"))
               END IF
               LET g_loc = 'm'
               LET l_ac = DIALOG.getCurrentRow("s_detail2")
               LET g_current_page = 2
               #顯示單身筆數
               CALL amrm200_idx_chk()
               #add-point:page2自定義行為 name="ui_dialog.body2.before_display"
               
               #end add-point
      
            #自訂ACTION(detail_show,page_2)
            
         
            #add-point:page2自定義行為 name="ui_dialog.body2.action"
            
            #end add-point
         
         END DISPLAY
         #第一階單身段落
         DISPLAY ARRAY g_mrbb3_d TO s_detail3.* ATTRIBUTES(COUNT=g_rec_b)  
    
            BEFORE ROW
               #顯示單身筆數
               CALL amrm200_idx_chk()
               LET l_ac = DIALOG.getCurrentRow("s_detail3")
               LET g_detail_idx = l_ac
               LET g_detail_idx_list[3] = l_ac
               CALL g_idx_group.addAttribute("'3',",l_ac)
               
               #add-point:page3, before row動作 name="ui_dialog.body3.before_row"
               
               #end add-point
               
            BEFORE DISPLAY
               #如果一直都在單身1則控制筆數位置
               IF g_loc = 'm' THEN
                  CALL FGL_SET_ARR_CURR(g_idx_group.getValue("'3',"))
               END IF
               LET g_loc = 'm'
               LET l_ac = DIALOG.getCurrentRow("s_detail3")
               LET g_current_page = 3
               #顯示單身筆數
               CALL amrm200_idx_chk()
               #add-point:page3自定義行為 name="ui_dialog.body3.before_display"
               
               #end add-point
      
            #自訂ACTION(detail_show,page_3)
            
         
            #add-point:page3自定義行為 name="ui_dialog.body3.action"
            
            #end add-point
         
         END DISPLAY
         #第一階單身段落
         DISPLAY ARRAY g_mrbb4_d TO s_detail4.* ATTRIBUTES(COUNT=g_rec_b)  
    
            BEFORE ROW
               #顯示單身筆數
               CALL amrm200_idx_chk()
               LET l_ac = DIALOG.getCurrentRow("s_detail4")
               LET g_detail_idx = l_ac
               LET g_detail_idx_list[4] = l_ac
               CALL g_idx_group.addAttribute("'4',",l_ac)
               
               #add-point:page4, before row動作 name="ui_dialog.body4.before_row"
               
               #end add-point
               
            BEFORE DISPLAY
               #如果一直都在單身1則控制筆數位置
               IF g_loc = 'm' THEN
                  CALL FGL_SET_ARR_CURR(g_idx_group.getValue("'4',"))
               END IF
               LET g_loc = 'm'
               LET l_ac = DIALOG.getCurrentRow("s_detail4")
               LET g_current_page = 4
               #顯示單身筆數
               CALL amrm200_idx_chk()
               #add-point:page4自定義行為 name="ui_dialog.body4.before_display"
               
               #end add-point
      
            #自訂ACTION(detail_show,page_4)
            
         
            #add-point:page4自定義行為 name="ui_dialog.body4.action"
            
            #end add-point
         
         END DISPLAY
         #第一階單身段落
         DISPLAY ARRAY g_mrbb5_d TO s_detail5.* ATTRIBUTES(COUNT=g_rec_b)  
    
            BEFORE ROW
               #顯示單身筆數
               CALL amrm200_idx_chk()
               LET l_ac = DIALOG.getCurrentRow("s_detail5")
               LET g_detail_idx = l_ac
               LET g_detail_idx_list[5] = l_ac
               CALL g_idx_group.addAttribute("'5',",l_ac)
               
               #add-point:page5, before row動作 name="ui_dialog.body5.before_row"
               
               #end add-point
               
            BEFORE DISPLAY
               #如果一直都在單身1則控制筆數位置
               IF g_loc = 'm' THEN
                  CALL FGL_SET_ARR_CURR(g_idx_group.getValue("'5',"))
               END IF
               LET g_loc = 'm'
               LET l_ac = DIALOG.getCurrentRow("s_detail5")
               LET g_current_page = 5
               #顯示單身筆數
               CALL amrm200_idx_chk()
               #add-point:page5自定義行為 name="ui_dialog.body5.before_display"
               
               #end add-point
      
            #自訂ACTION(detail_show,page_5)
            
         
            #add-point:page5自定義行為 name="ui_dialog.body5.action"
            
            #end add-point
         
         END DISPLAY
         #第一階單身段落
         DISPLAY ARRAY g_mrbb6_d TO s_detail6.* ATTRIBUTES(COUNT=g_rec_b)  
    
            BEFORE ROW
               #顯示單身筆數
               CALL amrm200_idx_chk()
               LET l_ac = DIALOG.getCurrentRow("s_detail6")
               LET g_detail_idx = l_ac
               LET g_detail_idx_list[6] = l_ac
               CALL g_idx_group.addAttribute("'6',",l_ac)
               
               #add-point:page6, before row動作 name="ui_dialog.body6.before_row"
               
               #end add-point
               
            BEFORE DISPLAY
               #如果一直都在單身1則控制筆數位置
               IF g_loc = 'm' THEN
                  CALL FGL_SET_ARR_CURR(g_idx_group.getValue("'6',"))
               END IF
               LET g_loc = 'm'
               LET l_ac = DIALOG.getCurrentRow("s_detail6")
               LET g_current_page = 6
               #顯示單身筆數
               CALL amrm200_idx_chk()
               #add-point:page6自定義行為 name="ui_dialog.body6.before_display"
               
               #end add-point
      
            #自訂ACTION(detail_show,page_6)
            
         
            #add-point:page6自定義行為 name="ui_dialog.body6.action"
            
            #end add-point
         
         END DISPLAY
 
         
 
         
         #add-point:ui_dialog段自定義display array name="ui_dialog.more_displayarray"
         
         #end add-point
         
         SUBDIALOG lib_cl_dlg.cl_dlg_qryplan
         SUBDIALOG lib_cl_dlg.cl_dlg_relateapps
      
         BEFORE DIALOG
            #先填充browser資料
            CALL amrm200_browser_fill("")
            CALL cl_notice()
            CALL cl_navigator_setting(g_current_idx, g_detail_cnt)
            LET g_curr_diag = ui.DIALOG.getCurrent()
            LET g_current_sw = FALSE
            #回歸舊筆數位置 (回到當時異動的筆數)
            LET g_current_idx = DIALOG.getCurrentRow("s_browse")
            IF g_current_row > 1 AND g_current_idx = 1 AND g_current_sw = FALSE THEN
               CALL DIALOG.setCurrentRow("s_browse",g_current_row)
               LET g_current_idx = g_current_row
            END IF
            
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
               CALL amrm200_fetch('') # reload data
            END IF
            #LET g_detail_idx = 1
            CALL amrm200_ui_detailshow() #Setting the current row 
            
            #筆數顯示
            LET g_current_page = 1
            CALL amrm200_idx_chk()
            CALL cl_ap_performance_cal()
            #add-point:ui_dialog段before_dialog2 name="ui_dialog.before_dialog2"
            
            #end add-point
 
         #add-point:ui_dialog段more_action name="ui_dialog.more_action"
         
         #end add-point
 
         #狀態碼切換
         ON ACTION statechange
            LET g_action_choice = "statechange"
            CALL amrm200_statechange()
            #根據資料狀態切換action狀態
            CALL cl_set_act_visible("statechange,modify,modify_detail,delete,reproduce", TRUE)
            CALL amrm200_set_act_visible()   
            CALL amrm200_set_act_no_visible()
            IF NOT (g_mrba_m.mrba001 IS NULL
 
              ) THEN
               #組合條件
               LET g_add_browse = " mrbaent = " ||g_enterprise|| " AND mrbasite = '" ||g_site|| "' AND",
                                  " mrba001 = '", g_mrba_m.mrba001, "' "
 
               #填到對應位置
               CALL amrm200_browser_fill("")
            END IF
         
          
         #查詢方案選擇 
         ON ACTION queryplansel
            CALL cl_dlg_qryplan_select() RETURNING ls_wc
            #不是空條件才寫入g_wc跟重新找資料
            IF NOT cl_null(ls_wc) THEN
               CALL util.JSON.parse(ls_wc, la_wc)
               INITIALIZE g_wc, g_wc2,g_wc2_table1,g_wc2_extend TO NULL
               INITIALIZE g_wc2_table2 TO NULL
 
               INITIALIZE g_wc2_table3 TO NULL
 
               INITIALIZE g_wc2_table4 TO NULL
 
               INITIALIZE g_wc2_table5 TO NULL
 
               INITIALIZE g_wc2_table6 TO NULL
 
 
               FOR li_idx = 1 TO la_wc.getLength()
                  CASE
                     WHEN la_wc[li_idx].tableid = "mrba_t" 
                        LET g_wc = la_wc[li_idx].wc
                     WHEN la_wc[li_idx].tableid = "mrbb_t" 
                        LET g_wc2_table1 = la_wc[li_idx].wc
                     WHEN la_wc[li_idx].tableid = "mrbc_t" 
                        LET g_wc2_table2 = la_wc[li_idx].wc
 
                     WHEN la_wc[li_idx].tableid = "mrbd_t" 
                        LET g_wc2_table3 = la_wc[li_idx].wc
 
                     WHEN la_wc[li_idx].tableid = "mrbe_t" 
                        LET g_wc2_table4 = la_wc[li_idx].wc
 
                     WHEN la_wc[li_idx].tableid = "mrbf_t" 
                        LET g_wc2_table5 = la_wc[li_idx].wc
 
                     WHEN la_wc[li_idx].tableid = "mrbg_t" 
                        LET g_wc2_table6 = la_wc[li_idx].wc
 
 
                     WHEN la_wc[li_idx].tableid = "EXTENDWC"
                        LET g_wc2_extend = la_wc[li_idx].wc
                  END CASE
               END FOR
               IF NOT cl_null(g_wc) OR NOT cl_null(g_wc2_table1) 
                  OR NOT cl_null(g_wc2_table2)
 
                  OR NOT cl_null(g_wc2_table3)
 
                  OR NOT cl_null(g_wc2_table4)
 
                  OR NOT cl_null(g_wc2_table5)
 
                  OR NOT cl_null(g_wc2_table6)
 
 
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
 
                  IF g_wc2_table4 <> " 1=1" AND NOT cl_null(g_wc2_table4) THEN
                     LET g_wc2 = g_wc2 ," AND ", g_wc2_table4
                  END IF
 
                  IF g_wc2_table5 <> " 1=1" AND NOT cl_null(g_wc2_table5) THEN
                     LET g_wc2 = g_wc2 ," AND ", g_wc2_table5
                  END IF
 
                  IF g_wc2_table6 <> " 1=1" AND NOT cl_null(g_wc2_table6) THEN
                     LET g_wc2 = g_wc2 ," AND ", g_wc2_table6
                  END IF
 
 
                  IF g_wc2_extend <> " 1=1" AND NOT cl_null(g_wc2_extend) THEN
                     LET g_wc2 = g_wc2 ," AND ", g_wc2_extend
                  END IF
 
                  IF g_wc2.subString(1,5) = " AND " THEN
                     LET g_wc2 = g_wc2.subString(6,g_wc2.getLength())
                  END IF
               END IF
               CALL amrm200_browser_fill("F")   #browser_fill()會將notice區塊清空
               CALL cl_notice()   #重新顯示,此處不可用EXIT DIALOG, SUBDIALOG重讀會導致部分變數消失
            END IF
         
         #查詢方案選擇
         ON ACTION qbe_select
            CALL cl_qbe_list("m") RETURNING ls_wc
            IF NOT cl_null(ls_wc) THEN
               CALL util.JSON.parse(ls_wc, la_wc)
               INITIALIZE g_wc, g_wc2,g_wc2_table1,g_wc2_extend TO NULL
               INITIALIZE g_wc2_table2 TO NULL
 
               INITIALIZE g_wc2_table3 TO NULL
 
               INITIALIZE g_wc2_table4 TO NULL
 
               INITIALIZE g_wc2_table5 TO NULL
 
               INITIALIZE g_wc2_table6 TO NULL
 
 
               FOR li_idx = 1 TO la_wc.getLength()
                  CASE
                     WHEN la_wc[li_idx].tableid = "mrba_t" 
                        LET g_wc = la_wc[li_idx].wc
                     WHEN la_wc[li_idx].tableid = "mrbb_t" 
                        LET g_wc2_table1 = la_wc[li_idx].wc
                     WHEN la_wc[li_idx].tableid = "mrbc_t" 
                        LET g_wc2_table2 = la_wc[li_idx].wc
 
                     WHEN la_wc[li_idx].tableid = "mrbd_t" 
                        LET g_wc2_table3 = la_wc[li_idx].wc
 
                     WHEN la_wc[li_idx].tableid = "mrbe_t" 
                        LET g_wc2_table4 = la_wc[li_idx].wc
 
                     WHEN la_wc[li_idx].tableid = "mrbf_t" 
                        LET g_wc2_table5 = la_wc[li_idx].wc
 
                     WHEN la_wc[li_idx].tableid = "mrbg_t" 
                        LET g_wc2_table6 = la_wc[li_idx].wc
 
 
                     WHEN la_wc[li_idx].tableid = "EXTENDWC"
                        LET g_wc2_extend = la_wc[li_idx].wc
                  END CASE
               END FOR
               IF NOT cl_null(g_wc) OR NOT cl_null(g_wc2_table1)
                  OR NOT cl_null(g_wc2_table2)
 
                  OR NOT cl_null(g_wc2_table3)
 
                  OR NOT cl_null(g_wc2_table4)
 
                  OR NOT cl_null(g_wc2_table5)
 
                  OR NOT cl_null(g_wc2_table6)
 
 
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
 
                  IF g_wc2_table4 <> " 1=1" AND NOT cl_null(g_wc2_table4) THEN
                     LET g_wc2 = g_wc2 ," AND ", g_wc2_table4
                  END IF
 
                  IF g_wc2_table5 <> " 1=1" AND NOT cl_null(g_wc2_table5) THEN
                     LET g_wc2 = g_wc2 ," AND ", g_wc2_table5
                  END IF
 
                  IF g_wc2_table6 <> " 1=1" AND NOT cl_null(g_wc2_table6) THEN
                     LET g_wc2 = g_wc2 ," AND ", g_wc2_table6
                  END IF
 
 
                  IF g_wc2_extend <> " 1=1" AND NOT cl_null(g_wc2_extend) THEN
                     LET g_wc2 = g_wc2 ," AND ", g_wc2_extend
                  END IF
                  IF g_wc2.subString(1,5) = " AND " THEN
                     LET g_wc2 = g_wc2.subString(6,g_wc2.getLength())
                  END IF
                  #取得條件後需要重查、跳到結果第一筆資料的功能程式段
                  CALL amrm200_browser_fill("F")
                  IF g_browser_cnt = 0 THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "" 
                     LET g_errparam.code = "-100" 
                     LET g_errparam.popup = TRUE 
                     CALL cl_err()
                     CLEAR FORM
                  ELSE
                     CALL amrm200_fetch("F")
                  END IF
               END IF
            END IF
            #重新搜尋會將notice區塊清空,此處不可用EXIT DIALOG, SUBDIALOG重讀會導致部分變數消失
            CALL cl_notice()
          
         #應用 a49 樣板自動產生(Version:4)
            #過濾瀏覽頁資料
            ON ACTION filter
               LET g_action_choice = "fetch"
               #add-point:filter action name="ui_dialog.action.filter"
               
               #end add-point
               CALL amrm200_filter()
               EXIT DIALOG
 
 
 
         
         ON ACTION first
            LET g_action_choice = "fetch"
            CALL amrm200_fetch('F')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL amrm200_idx_chk()
            
         ON ACTION previous
            LET g_action_choice = "fetch"
            CALL amrm200_fetch('P')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL amrm200_idx_chk()
            
         ON ACTION jump
            LET g_action_choice = "fetch"
            CALL amrm200_fetch('/')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL amrm200_idx_chk()
            
         ON ACTION next
            LET g_action_choice = "fetch"
            CALL amrm200_fetch('N')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL amrm200_idx_chk()
            
         ON ACTION last
            LET g_action_choice = "fetch"
            CALL amrm200_fetch('L')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL amrm200_idx_chk()
          
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
                  LET g_export_node[1] = base.typeInfo.create(g_mrbb_d)
                  LET g_export_id[1]   = "s_detail1"
                  LET g_export_node[2] = base.typeInfo.create(g_mrbb2_d)
                  LET g_export_id[2]   = "s_detail2"
                  LET g_export_node[3] = base.typeInfo.create(g_mrbb3_d)
                  LET g_export_id[3]   = "s_detail3"
                  LET g_export_node[4] = base.typeInfo.create(g_mrbb4_d)
                  LET g_export_id[4]   = "s_detail4"
                  LET g_export_node[5] = base.typeInfo.create(g_mrbb5_d)
                  LET g_export_id[5]   = "s_detail5"
                  LET g_export_node[6] = base.typeInfo.create(g_mrbb6_d)
                  LET g_export_id[6]   = "s_detail6"
 
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
            
         #瀏覽頁折疊
         ON ACTION worksheethidden   
            IF g_main_hidden THEN
               CALL gfrm_curr.setElementHidden("mainlayout",0)
               CALL gfrm_curr.setElementHidden("worksheet",1)
               LET g_main_hidden = 0
            ELSE
               CALL gfrm_curr.setElementHidden("mainlayout",1)
               CALL gfrm_curr.setElementHidden("worksheet",0)
               LET g_main_hidden = 1
            END IF
            IF lb_first THEN
               LET lb_first = FALSE
               NEXT FIELD mrbb002
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
               CALL amrm200_modify()
               #add-point:ON ACTION modify name="menu.modify"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION modify_detail
            LET g_action_choice="modify_detail"
            IF cl_auth_chk_act("modify") THEN
               LET g_aw = g_curr_diag.getCurrentItem()
               CALL amrm200_modify()
               #add-point:ON ACTION modify_detail name="menu.modify_detail"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION act_5
            LET g_action_choice="act_5"
            IF cl_auth_chk_act("act_5") THEN
               
               #add-point:ON ACTION act_5 name="menu.act_5"
               IF cl_ask_confirm('amr-00016') THEN
                  CALL s_transaction_begin()
                  CALL s_amrm200_upd_status_1(g_mrba_m.mrba001,g_mrba_m.mrbastus,g_mrba_m.mrba100) RETURNING g_success,g_errno
                  IF NOT g_success THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = g_errno
                     LET g_errparam.extend = ''
                     LET g_errparam.popup = TRUE
                     CALL cl_err()

                     CALL s_transaction_end('N','1')
                  ELSE
                     CALL s_transaction_end('Y','1')  
                  END IF
                  CALL amrm200_mrba100_show()
#160816-00009#1-s add
                  CALL amrm200_set_act_visible()
                  CALL amrm200_set_act_no_visible()
#160816-00009#1-e add
               END IF
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION act_2
            LET g_action_choice="act_2"
            IF cl_auth_chk_act("act_2") THEN
               
               #add-point:ON ACTION act_2 name="menu.act_2"
               IF cl_ask_confirm('amr-00013') THEN
                  CALL s_transaction_begin()
                  CALL s_amrm200_upd_status_2(g_mrba_m.mrba001,g_mrba_m.mrbastus,g_mrba_m.mrba100) RETURNING g_success,g_errno
                  IF NOT g_success THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = g_errno
                     LET g_errparam.extend = ''
                     LET g_errparam.popup = TRUE
                     CALL cl_err()

                     CALL s_transaction_end('N','1')
                  ELSE
                     CALL s_transaction_end('Y','1')  
                  END IF
                  CALL amrm200_mrba100_show()
#160816-00009#1-s add
                  CALL amrm200_set_act_visible()
                  CALL amrm200_set_act_no_visible()
#160816-00009#1-e add
               END IF
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION delete
            LET g_action_choice="delete"
            IF cl_auth_chk_act("delete") THEN
               CALL amrm200_delete()
               #add-point:ON ACTION delete name="menu.delete"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION insert
            LET g_action_choice="insert"
            IF cl_auth_chk_act("insert") THEN
               CALL amrm200_insert()
               #add-point:ON ACTION insert name="menu.insert"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION act_3
            LET g_action_choice="act_3"
            IF cl_auth_chk_act("act_3") THEN
               
               #add-point:ON ACTION act_3 name="menu.act_3"
               IF cl_ask_confirm('amr-00014') THEN
                  CALL s_transaction_begin()
                  CALL s_amrm200_upd_status_1(g_mrba_m.mrba001,g_mrba_m.mrbastus,g_mrba_m.mrba100) RETURNING g_success,g_errno
                  IF NOT g_success THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = g_errno
                     LET g_errparam.extend = ''
                     LET g_errparam.popup = TRUE
                     CALL cl_err()

                     CALL s_transaction_end('N','1')
                  ELSE
                     CALL s_transaction_end('Y','1')  
                  END IF
                  CALL amrm200_mrba100_show()
#160816-00009#1-s add
                  CALL amrm200_set_act_visible()
                  CALL amrm200_set_act_no_visible()
#160816-00009#1-e add
               END IF
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
               CALL amrm200_reproduce()
               #add-point:ON ACTION reproduce name="menu.reproduce"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION act_1
            LET g_action_choice="act_1"
            IF cl_auth_chk_act("act_1") THEN
               
               #add-point:ON ACTION act_1 name="menu.act_1"
               IF cl_ask_confirm('amr-00012') THEN
                  CALL s_transaction_begin()
                  CALL s_amrm200_upd_status_1(g_mrba_m.mrba001,g_mrba_m.mrbastus,g_mrba_m.mrba100) RETURNING g_success,g_errno
                  IF NOT g_success THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = g_errno
                     LET g_errparam.extend = ''
                     LET g_errparam.popup = TRUE
                     CALL cl_err()

                     CALL s_transaction_end('N','1')
                  ELSE
                     CALL s_transaction_end('Y','1')  
                  END IF
                  CALL amrm200_mrba100_show()
#160816-00009#1-s add
                  CALL amrm200_set_act_visible()
                  CALL amrm200_set_act_no_visible()
#160816-00009#1-e add
               END IF
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION query
            LET g_action_choice="query"
            IF cl_auth_chk_act("query") THEN
               CALL amrm200_query()
               #add-point:ON ACTION query name="menu.query"
               
               #END add-point
               #應用 a59 樣板自動產生(Version:3)  
               CALL g_curr_diag.setCurrentRow("s_detail1",1)
               CALL g_curr_diag.setCurrentRow("s_detail2",1)
               CALL g_curr_diag.setCurrentRow("s_detail3",1)
               CALL g_curr_diag.setCurrentRow("s_detail4",1)
               CALL g_curr_diag.setCurrentRow("s_detail5",1)
               CALL g_curr_diag.setCurrentRow("s_detail6",1)
 
 
 
 
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION act_4
            LET g_action_choice="act_4"
            IF cl_auth_chk_act("act_4") THEN
               
               #add-point:ON ACTION act_4 name="menu.act_4"
               IF cl_ask_confirm('amr-00015') THEN
                  CALL s_transaction_begin()
                  CALL s_amrm200_upd_status_3(g_mrba_m.mrba001,g_mrba_m.mrbastus,g_mrba_m.mrba100) RETURNING g_success,g_errno
                  IF NOT g_success THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = g_errno
                     LET g_errparam.extend = ''
                     LET g_errparam.popup = TRUE
                     CALL cl_err()

                     CALL s_transaction_end('N','1')
                  ELSE
                     CALL s_transaction_end('Y','1')  
                  END IF
                  CALL amrm200_mrba100_show()
#160816-00009#1-s add
                  CALL amrm200_set_act_visible()
                  CALL amrm200_set_act_no_visible()
#160816-00009#1-e add
               END IF
               #END add-point
               
            END IF
 
 
 
 
         
         #應用 a46 樣板自動產生(Version:3)
         #新增相關文件
         ON ACTION related_document
            CALL amrm200_set_pk_array()
            IF cl_auth_chk_act("related_document") THEN
               #add-point:ON ACTION related_document name="ui_dialog.dialog.related_document"
               
               #END add-point
               CALL cl_doc()
            END IF
            
         ON ACTION agendum
            CALL amrm200_set_pk_array()
            #add-point:ON ACTION agendum name="ui_dialog.dialog.agendum"
            
            #END add-point
            CALL cl_user_overview()
            CALL cl_user_overview_set_follow_pic()
         
         ON ACTION followup
            CALL amrm200_set_pk_array()
            #add-point:ON ACTION followup name="ui_dialog.dialog.followup"
            
            #END add-point
            CALL cl_user_overview_follow('')
 
 
 
         
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
 
{<section id="amrm200.browser_fill" >}
#+ 瀏覽頁簽資料填充
PRIVATE FUNCTION amrm200_browser_fill(ps_page_action)
   #add-point:browser_fill段define(客製用) name="browser_fill.define_customerization"
   
   #end add-point  
   DEFINE ps_page_action    STRING
   DEFINE l_wc              STRING
   DEFINE l_wc2             STRING
   DEFINE l_sql             STRING
   DEFINE l_sub_sql         STRING
   DEFINE l_sql_rank        STRING
   #add-point:browser_fill段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="browser_fill.define"
   
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
   
   #end add-point
   
   IF g_wc2 <> " 1=1" THEN
      #單身有輸入搜尋條件                      
      LET l_sub_sql = " SELECT DISTINCT mrba001 ",
                      " FROM mrba_t ",
                      " ",
                      " LEFT JOIN mrbb_t ON mrbbent = mrbaent AND mrbbsite = mrbasite AND mrba001 = mrbb001 ", "  ",
                      #add-point:browser_fill段sql(mrbb_t1) name="browser_fill.cnt.join.}"
                      
                      #end add-point
                      " LEFT JOIN mrbc_t ON mrbcent = mrbaent AND mrbcsite = mrbasite AND mrba001 = mrbc001", "  ",
                      #add-point:browser_fill段sql(mrbc_t1) name="browser_fill.cnt.join.mrbc_t1"
                      
                      #end add-point
 
                      " LEFT JOIN mrbd_t ON mrbdent = mrbaent AND mrbdsite = mrbasite AND mrba001 = mrbd001", "  ",
                      #add-point:browser_fill段sql(mrbd_t1) name="browser_fill.cnt.join.mrbd_t1"
                      
                      #end add-point
 
                      " LEFT JOIN mrbe_t ON mrbeent = mrbaent AND mrbesite = mrbasite AND mrba001 = mrbe001", "  ",
                      #add-point:browser_fill段sql(mrbe_t1) name="browser_fill.cnt.join.mrbe_t1"
                      
                      #end add-point
 
                      " LEFT JOIN mrbf_t ON mrbfent = mrbaent AND mrbfsite = mrbasite AND mrba001 = mrbf001", "  ",
                      #add-point:browser_fill段sql(mrbf_t1) name="browser_fill.cnt.join.mrbf_t1"
                      
                      #end add-point
 
                      " LEFT JOIN mrbg_t ON mrbgent = mrbaent AND mrbgsite = mrbasite AND mrba001 = mrbg001", "  ",
                      #add-point:browser_fill段sql(mrbg_t1) name="browser_fill.cnt.join.mrbg_t1"
                      
                      #end add-point
 
 
 
                      " ", 
                      " ", 
                      " ",                      
 
                      " ",                      
 
                      " ",                      
 
                      " ",                      
 
                      " ",                      
 
 
 
                      " WHERE mrbaent = " ||g_enterprise|| " AND mrbasite = '" ||g_site|| "' AND mrbbent = " ||g_enterprise|| " AND mrbbsite = '" ||g_site|| "' AND ",l_wc, " AND ", l_wc2, cl_sql_add_filter("mrba_t")
   ELSE
      #單身未輸入搜尋條件
      LET l_sub_sql = " SELECT DISTINCT mrba001 ",
                      " FROM mrba_t ", 
                      "  ",
                      "  ",
                      " WHERE mrbaent = " ||g_enterprise|| " AND mrbasite = '" ||g_site|| "' AND ",l_wc CLIPPED, cl_sql_add_filter("mrba_t")
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
      INITIALIZE g_mrba_m.* TO NULL
      CALL g_mrbb_d.clear()        
      CALL g_mrbb2_d.clear() 
      CALL g_mrbb3_d.clear() 
      CALL g_mrbb4_d.clear() 
      CALL g_mrbb5_d.clear() 
      CALL g_mrbb6_d.clear() 
 
      #add-point:browser_fill g_add_browse段額外處理 name="browser_fill.add_browse.other"
      
      #end add-point   
      CALL g_browser.clear()
      LET g_cnt = 1
   ELSE
      LET l_wc  = g_add_browse
      LET l_wc2 = " 1=1" 
      LET g_cnt = g_current_idx
   END IF
 
   #依照t0.mrba001,t0.mrba000,t0.mrba002,t0.mrba003,t0.mrba004,t0.mrba005 Browser欄位定義(取代原本bs_sql功能)
   #考量到單身可能下條件, 所以此處需join單身所有table
   #DISTINCT是為了避免在join時出現重複的資料(如果不加DISTINCT則須在程式中過濾)
   IF g_wc2 <> " 1=1" THEN
      #單身有輸入搜尋條件   
      LET g_sql = " SELECT DISTINCT t0.mrbastus,t0.mrba001,t0.mrba000,t0.mrba002,t0.mrba003,t0.mrba004, 
          t0.mrba005 ",
                  " FROM mrba_t t0",
                  "  ",
                  "  LEFT JOIN mrbb_t ON mrbbent = mrbaent AND mrbbsite = mrbasite AND mrba001 = mrbb001 ", "  ", 
                  #add-point:browser_fill段sql(mrbb_t1) name="browser_fill.join.mrbb_t1"
                  
                  #end add-point
                  "  LEFT JOIN mrbc_t ON mrbcent = mrbaent AND mrbcsite = mrbasite AND mrba001 = mrbc001", "  ", 
                  #add-point:browser_fill段sql(mrbc_t1) name="browser_fill.join.mrbc_t1"
                  
                  #end add-point
 
                  "  LEFT JOIN mrbd_t ON mrbdent = mrbaent AND mrbdsite = mrbasite AND mrba001 = mrbd001", "  ", 
                  #add-point:browser_fill段sql(mrbd_t1) name="browser_fill.join.mrbd_t1"
                  
                  #end add-point
 
                  "  LEFT JOIN mrbe_t ON mrbeent = mrbaent AND mrbesite = mrbasite AND mrba001 = mrbe001", "  ", 
                  #add-point:browser_fill段sql(mrbe_t1) name="browser_fill.join.mrbe_t1"
                  
                  #end add-point
 
                  "  LEFT JOIN mrbf_t ON mrbfent = mrbaent AND mrbfsite = mrbasite AND mrba001 = mrbf001", "  ", 
                  #add-point:browser_fill段sql(mrbf_t1) name="browser_fill.join.mrbf_t1"
                  
                  #end add-point
 
                  "  LEFT JOIN mrbg_t ON mrbgent = mrbaent AND mrbgsite = mrbasite AND mrba001 = mrbg001", "  ", 
                  #add-point:browser_fill段sql(mrbg_t1) name="browser_fill.join.mrbg_t1"
                  
                  #end add-point
 
 
 
                  " ", 
                  " ",                      
 
                  " ",                      
 
                  " ",                      
 
                  " ",                      
 
                  " ",                      
 
 
 
                  
                  " WHERE t0.mrbaent = " ||g_enterprise|| " AND t0.mrbasite = '" ||g_site|| "' AND ",l_wc," AND ",l_wc2, cl_sql_add_filter("mrba_t")
   ELSE
      #單身無輸入搜尋條件   
      LET g_sql = " SELECT DISTINCT t0.mrbastus,t0.mrba001,t0.mrba000,t0.mrba002,t0.mrba003,t0.mrba004, 
          t0.mrba005 ",
                  " FROM mrba_t t0",
                  "  ",
                  
                  " WHERE t0.mrbaent = " ||g_enterprise|| " AND t0.mrbasite = '" ||g_site|| "' AND ",l_wc, cl_sql_add_filter("mrba_t")
   END IF
   #add-point:browser_fill,sql wc name="browser_fill.fill_sqlwc"
   
   #end add-point
   LET g_sql = g_sql, " ORDER BY mrba001 ",g_order
 
   #add-point:browser_fill,before_prepare name="browser_fill.before_prepare"
   
   #end add-point
        
   #LET g_sql = cl_sql_add_tabid(g_sql,"mrba_t") #WC重組
   LET g_sql = cl_sql_add_mask(g_sql) #遮蔽特定資料
   
   IF g_sql.getIndexOf(" 1=2",1) THEN
      DISPLAY "INFO: 1=2 jumped!"
   ELSE
      PREPARE browse_pre FROM g_sql
      DECLARE browse_cur CURSOR FOR browse_pre
      
      #add-point:browser_fill段open cursor name="browser_fill.open"
      
      #end add-point
      
      FOREACH browse_cur INTO g_browser[g_cnt].b_statepic,g_browser[g_cnt].b_mrba001,g_browser[g_cnt].b_mrba000, 
          g_browser[g_cnt].b_mrba002,g_browser[g_cnt].b_mrba003,g_browser[g_cnt].b_mrba004,g_browser[g_cnt].b_mrba005 
 
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
      
         #遮罩相關處理
         CALL amrm200_browser_mask()
      
               #應用 a24 樣板自動產生(Version:3)
      #browser顯示圖片
      CASE g_browser[g_cnt].b_statepic
         WHEN "N"
            LET g_browser[g_cnt].b_statepic = "stus/16/open.png"
         WHEN "Y"
            LET g_browser[g_cnt].b_statepic = "stus/16/valid.png"
         WHEN "X"
            LET g_browser[g_cnt].b_statepic = "stus/16/void.png"
         
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
   
   IF cl_null(g_browser[g_cnt].b_mrba001) THEN
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
 
{<section id="amrm200.ui_headershow" >}
#+ 單頭資料重新顯示
PRIVATE FUNCTION amrm200_ui_headershow()
   #add-point:ui_headershow段define(客製用) name="ui_headershow.define_customerization"
   
   #end add-point  
   #add-point:ui_headershow段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="ui_headershow.define"
   
   #end add-point      
   
   #add-point:Function前置處理  name="ui_headershow.pre_function"
   
   #end add-point
   
   LET g_mrba_m.mrba001 = g_browser[g_current_idx].b_mrba001   
 
   EXECUTE amrm200_master_referesh USING g_site,g_mrba_m.mrba001 INTO g_mrba_m.mrba019,g_mrba_m.mrba000, 
       g_mrba_m.mrba001,g_mrba_m.mrba002,g_mrba_m.mrba003,g_mrba_m.mrba066,g_mrba_m.mrba004,g_mrba_m.mrba005, 
       g_mrba_m.mrba007,g_mrba_m.mrba008,g_mrba_m.mrba009,g_mrba_m.mrba010,g_mrba_m.mrba011,g_mrba_m.mrba020, 
       g_mrba_m.mrba006,g_mrba_m.mrba104,g_mrba_m.mrba012,g_mrba_m.mrba013,g_mrba_m.mrba014,g_mrba_m.mrba015, 
       g_mrba_m.mrba016,g_mrba_m.mrba017,g_mrba_m.mrba018,g_mrba_m.mrba102,g_mrba_m.mrba100,g_mrba_m.mrba101, 
       g_mrba_m.mrbastus,g_mrba_m.mrba021,g_mrba_m.mrba022,g_mrba_m.mrba025,g_mrba_m.mrba026,g_mrba_m.mrba027, 
       g_mrba_m.mrba103,g_mrba_m.mrba029,g_mrba_m.mrba031,g_mrba_m.mrba032,g_mrba_m.mrba033,g_mrba_m.mrba034, 
       g_mrba_m.mrba035,g_mrba_m.mrba036,g_mrba_m.mrba038,g_mrba_m.mrba039,g_mrba_m.mrba040,g_mrba_m.mrba041, 
       g_mrba_m.mrba042,g_mrba_m.mrbaownid,g_mrba_m.mrbaowndp,g_mrba_m.mrbacrtid,g_mrba_m.mrbacrtdp, 
       g_mrba_m.mrbacrtdt,g_mrba_m.mrbamodid,g_mrba_m.mrbamoddt,g_mrba_m.mrbacnfid,g_mrba_m.mrbacnfdt, 
       g_mrba_m.mrba010_desc,g_mrba_m.mrba011_desc,g_mrba_m.mrba020_desc,g_mrba_m.mrba012_desc,g_mrba_m.mrba013_desc, 
       g_mrba_m.mrba014_desc,g_mrba_m.mrba016_desc,g_mrba_m.mrba017_desc,g_mrba_m.mrba018_desc,g_mrba_m.mrba021_desc, 
       g_mrba_m.mrba022_desc,g_mrba_m.mrba027_desc,g_mrba_m.mrba103_desc,g_mrba_m.mrba040_desc,g_mrba_m.mrbaownid_desc, 
       g_mrba_m.mrbaowndp_desc,g_mrba_m.mrbacrtid_desc,g_mrba_m.mrbacrtdp_desc,g_mrba_m.mrbamodid_desc, 
       g_mrba_m.mrbacnfid_desc
   
   CALL amrm200_mrba_t_mask()
   CALL amrm200_show()
      
END FUNCTION
 
{</section>}
 
{<section id="amrm200.ui_detailshow" >}
#+ 單身資料重新顯示
PRIVATE FUNCTION amrm200_ui_detailshow()
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
      CALL g_curr_diag.setCurrentRow("s_detail5",g_detail_idx)
      CALL g_curr_diag.setCurrentRow("s_detail6",g_detail_idx)
 
   END IF
   
   #add-point:ui_detailshow段after name="ui_detailshow.after"
   
   #end add-point    
   
END FUNCTION
 
{</section>}
 
{<section id="amrm200.ui_browser_refresh" >}
#+ 瀏覽頁簽資料重新顯示
PRIVATE FUNCTION amrm200_ui_browser_refresh()
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
      IF g_browser[l_i].b_mrba001 = g_mrba_m.mrba001 
 
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
 
{<section id="amrm200.construct" >}
#+ QBE資料查詢
PRIVATE FUNCTION amrm200_construct()
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
   DEFINE l_mrba000   LIKE mrba_t.mrba000  #151215-00002#3-add
   #end add-point    
   
   #add-point:Function前置處理  name="cs.pre_function"
   
   #end add-point
    
   #清除畫面
   CLEAR FORM                
   INITIALIZE g_mrba_m.* TO NULL
   CALL g_mrbb_d.clear()        
   CALL g_mrbb2_d.clear() 
   CALL g_mrbb3_d.clear() 
   CALL g_mrbb4_d.clear() 
   CALL g_mrbb5_d.clear() 
   CALL g_mrbb6_d.clear() 
 
   
   LET g_action_choice = ""
    
   INITIALIZE g_wc TO NULL
   INITIALIZE g_wc2 TO NULL
   
   INITIALIZE g_wc2_table1 TO NULL
   INITIALIZE g_wc2_table2 TO NULL
 
   INITIALIZE g_wc2_table3 TO NULL
 
   INITIALIZE g_wc2_table4 TO NULL
 
   INITIALIZE g_wc2_table5 TO NULL
 
   INITIALIZE g_wc2_table6 TO NULL
 
 
    
   LET g_qryparam.state = 'c'
   
   #add-point:cs段開始前 name="cs.before_construct"
   
   #end add-point 
   
   #使用DIALOG包住 單頭CONSTRUCT及單身CONSTRUCT
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
      
      #單頭
      CONSTRUCT BY NAME g_wc ON mrba019,mrba000,mrba001,mrba002,mrba003,mrba066,mrba004,mrba005,mrba007, 
          mrba008,mrba009,mrba010,mrba011,mrba020,mrba006,mrba104,mrba012,mrba013,mrba014,mrba015,mrba016, 
          mrba017,mrba018,mrba102,mrba100,mrba101,mrbastus,mrba021,mrba022,mrba025,mrba026,mrba027,mrba103, 
          mrba029,mrba031,mrba032,mrba033,mrba034,mrba035,mrba036,mrba038,mrba039,mrba040,mrba041,mrba042, 
          mrbaownid,mrbaowndp,mrbacrtid,mrbacrtdp,mrbacrtdt,mrbamodid,mrbamoddt,mrbacnfid,mrbacnfdt
 
         BEFORE CONSTRUCT
            #add-point:cs段before_construct name="cs.head.before_construct"
            
            #end add-point 
            
         #公用欄位開窗相關處理
         #應用 a11 樣板自動產生(Version:3)
         #共用欄位查詢處理  
         ##----<<mrbacrtdt>>----
         AFTER FIELD mrbacrtdt
            CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
            IF NOT cl_null(ls_result) THEN
               IF NOT cl_chk_date_symbol(ls_result) THEN
                  LET ls_result = cl_add_date_extra_cond(ls_result)
               END IF
            END IF
            CALL FGL_DIALOG_SETBUFFER(ls_result)
 
         #----<<mrbamoddt>>----
         AFTER FIELD mrbamoddt
            CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
            IF NOT cl_null(ls_result) THEN
               IF NOT cl_chk_date_symbol(ls_result) THEN
                  LET ls_result = cl_add_date_extra_cond(ls_result)
               END IF
            END IF
            CALL FGL_DIALOG_SETBUFFER(ls_result)
         
         #----<<mrbacnfdt>>----
         AFTER FIELD mrbacnfdt
            CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
            IF NOT cl_null(ls_result) THEN
               IF NOT cl_chk_date_symbol(ls_result) THEN
                  LET ls_result = cl_add_date_extra_cond(ls_result)
               END IF
            END IF
            CALL FGL_DIALOG_SETBUFFER(ls_result)
         
         #----<<mrbapstdt>>----
 
 
 
            
         #一般欄位開窗相關處理    
                  #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mrba019
            #add-point:BEFORE FIELD mrba019 name="construct.b.mrba019"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mrba019
            
            #add-point:AFTER FIELD mrba019 name="construct.a.mrba019"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.mrba019
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mrba019
            #add-point:ON ACTION controlp INFIELD mrba019 name="construct.c.mrba019"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mrba000
            #add-point:BEFORE FIELD mrba000 name="construct.b.mrba000"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mrba000
            
            #add-point:AFTER FIELD mrba000 name="construct.a.mrba000"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.mrba000
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mrba000
            #add-point:ON ACTION controlp INFIELD mrba000 name="construct.c.mrba000"
            
            #END add-point
 
 
         #Ctrlp:construct.c.mrba001
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mrba001
            #add-point:ON ACTION controlp INFIELD mrba001 name="construct.c.mrba001"
            #此段落由子樣板a08產生
            #開窗c段
			   INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			   LET g_qryparam.reqry = FALSE
            CALL q_mrba001_1()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO mrba001  #顯示到畫面上

            NEXT FIELD mrba001                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mrba001
            #add-point:BEFORE FIELD mrba001 name="construct.b.mrba001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mrba001
            
            #add-point:AFTER FIELD mrba001 name="construct.a.mrba001"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.mrba002
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mrba002
            #add-point:ON ACTION controlp INFIELD mrba002 name="construct.c.mrba002"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_faah003()                       #呼叫開窗
            DISPLAY g_qryparam.return1 TO mrba002  #顯示到畫面上
            NEXT FIELD mrba002                     #返回原欄位
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mrba002
            #add-point:BEFORE FIELD mrba002 name="construct.b.mrba002"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mrba002
            
            #add-point:AFTER FIELD mrba002 name="construct.a.mrba002"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.mrba003
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mrba003
            #add-point:ON ACTION controlp INFIELD mrba003 name="construct.c.mrba003"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_faah004()                       #呼叫開窗
            DISPLAY g_qryparam.return1 TO mrba003  #顯示到畫面上
            NEXT FIELD mrba003                     #返回原欄位
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mrba003
            #add-point:BEFORE FIELD mrba003 name="construct.b.mrba003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mrba003
            
            #add-point:AFTER FIELD mrba003 name="construct.a.mrba003"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.mrba066
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mrba066
            #add-point:ON ACTION controlp INFIELD mrba066 name="construct.c.mrba066"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_faah001()                       #呼叫開窗
            DISPLAY g_qryparam.return1 TO mrba066  #顯示到畫面上
            NEXT FIELD mrba066                     #返回原欄位
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mrba066
            #add-point:BEFORE FIELD mrba066 name="construct.b.mrba066"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mrba066
            
            #add-point:AFTER FIELD mrba066 name="construct.a.mrba066"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mrba004
            #add-point:BEFORE FIELD mrba004 name="construct.b.mrba004"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mrba004
            
            #add-point:AFTER FIELD mrba004 name="construct.a.mrba004"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.mrba004
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mrba004
            #add-point:ON ACTION controlp INFIELD mrba004 name="construct.c.mrba004"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mrba005
            #add-point:BEFORE FIELD mrba005 name="construct.b.mrba005"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mrba005
            
            #add-point:AFTER FIELD mrba005 name="construct.a.mrba005"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.mrba005
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mrba005
            #add-point:ON ACTION controlp INFIELD mrba005 name="construct.c.mrba005"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mrba007
            #add-point:BEFORE FIELD mrba007 name="construct.b.mrba007"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mrba007
            
            #add-point:AFTER FIELD mrba007 name="construct.a.mrba007"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.mrba007
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mrba007
            #add-point:ON ACTION controlp INFIELD mrba007 name="construct.c.mrba007"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mrba008
            #add-point:BEFORE FIELD mrba008 name="construct.b.mrba008"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mrba008
            
            #add-point:AFTER FIELD mrba008 name="construct.a.mrba008"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.mrba008
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mrba008
            #add-point:ON ACTION controlp INFIELD mrba008 name="construct.c.mrba008"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mrba009
            #add-point:BEFORE FIELD mrba009 name="construct.b.mrba009"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mrba009
            
            #add-point:AFTER FIELD mrba009 name="construct.a.mrba009"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.mrba009
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mrba009
            #add-point:ON ACTION controlp INFIELD mrba009 name="construct.c.mrba009"
            
            #END add-point
 
 
         #Ctrlp:construct.c.mrba010
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mrba010
            #add-point:ON ACTION controlp INFIELD mrba010 name="construct.c.mrba010"
            #此段落由子樣板a08產生
            #開窗c段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			LET g_qryparam.reqry = FALSE
            CALL q_oocq002()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO mrba010  #顯示到畫面上

            NEXT FIELD mrba010                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mrba010
            #add-point:BEFORE FIELD mrba010 name="construct.b.mrba010"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mrba010
            
            #add-point:AFTER FIELD mrba010 name="construct.a.mrba010"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.mrba011
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mrba011
            #add-point:ON ACTION controlp INFIELD mrba011 name="construct.c.mrba011"
            #此段落由子樣板a08產生
            #開窗c段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			LET g_qryparam.reqry = FALSE
            CALL q_oocq002()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO mrba011  #顯示到畫面上

            NEXT FIELD mrba011                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mrba011
            #add-point:BEFORE FIELD mrba011 name="construct.b.mrba011"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mrba011
            
            #add-point:AFTER FIELD mrba011 name="construct.a.mrba011"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mrba020
            #add-point:BEFORE FIELD mrba020 name="construct.b.mrba020"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mrba020
            
            #add-point:AFTER FIELD mrba020 name="construct.a.mrba020"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.mrba020
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mrba020
            #add-point:ON ACTION controlp INFIELD mrba020 name="construct.c.mrba020"
            #161226-00026#1 add---start---
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_mrba020()
            DISPLAY g_qryparam.return1 TO mrba020
            NEXT FIELD mrba020
            #161226-00026#1 add---end---
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mrba006
            #add-point:BEFORE FIELD mrba006 name="construct.b.mrba006"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mrba006
            
            #add-point:AFTER FIELD mrba006 name="construct.a.mrba006"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.mrba006
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mrba006
            #add-point:ON ACTION controlp INFIELD mrba006 name="construct.c.mrba006"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mrba104
            #add-point:BEFORE FIELD mrba104 name="construct.b.mrba104"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mrba104
            
            #add-point:AFTER FIELD mrba104 name="construct.a.mrba104"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.mrba104
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mrba104
            #add-point:ON ACTION controlp INFIELD mrba104 name="construct.c.mrba104"
            
            #END add-point
 
 
         #Ctrlp:construct.c.mrba012
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mrba012
            #add-point:ON ACTION controlp INFIELD mrba012 name="construct.c.mrba012"
            #此段落由子樣板a08產生
            #開窗c段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			LET g_qryparam.reqry = FALSE
            CALL q_oocg001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO mrba012  #顯示到畫面上

            NEXT FIELD mrba012                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mrba012
            #add-point:BEFORE FIELD mrba012 name="construct.b.mrba012"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mrba012
            
            #add-point:AFTER FIELD mrba012 name="construct.a.mrba012"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.mrba013
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mrba013
            #add-point:ON ACTION controlp INFIELD mrba013 name="construct.c.mrba013"
            #此段落由子樣板a08產生
            #開窗c段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			LET g_qryparam.reqry = FALSE
            CALL q_pmaa001_3()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO mrba013  #顯示到畫面上

            NEXT FIELD mrba013                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mrba013
            #add-point:BEFORE FIELD mrba013 name="construct.b.mrba013"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mrba013
            
            #add-point:AFTER FIELD mrba013 name="construct.a.mrba013"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.mrba014
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mrba014
            #add-point:ON ACTION controlp INFIELD mrba014 name="construct.c.mrba014"
            #此段落由子樣板a08產生
            #開窗c段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			LET g_qryparam.reqry = FALSE
            CALL q_pmaa001_3()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO mrba014  #顯示到畫面上

            NEXT FIELD mrba014                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mrba014
            #add-point:BEFORE FIELD mrba014 name="construct.b.mrba014"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mrba014
            
            #add-point:AFTER FIELD mrba014 name="construct.a.mrba014"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mrba015
            #add-point:BEFORE FIELD mrba015 name="construct.b.mrba015"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mrba015
            
            #add-point:AFTER FIELD mrba015 name="construct.a.mrba015"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.mrba015
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mrba015
            #add-point:ON ACTION controlp INFIELD mrba015 name="construct.c.mrba015"
            
            #END add-point
 
 
         #Ctrlp:construct.c.mrba016
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mrba016
            #add-point:ON ACTION controlp INFIELD mrba016 name="construct.c.mrba016"
            #此段落由子樣板a08產生
            #開窗c段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO mrba016  #顯示到畫面上

            NEXT FIELD mrba016                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mrba016
            #add-point:BEFORE FIELD mrba016 name="construct.b.mrba016"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mrba016
            
            #add-point:AFTER FIELD mrba016 name="construct.a.mrba016"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.mrba017
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mrba017
            #add-point:ON ACTION controlp INFIELD mrba017 name="construct.c.mrba017"
            #此段落由子樣板a08產生
            #開窗c段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			LET g_qryparam.reqry = FALSE
            CALL q_ooeg001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO mrba017  #顯示到畫面上

            NEXT FIELD mrba017                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mrba017
            #add-point:BEFORE FIELD mrba017 name="construct.b.mrba017"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mrba017
            
            #add-point:AFTER FIELD mrba017 name="construct.a.mrba017"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.mrba018
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mrba018
            #add-point:ON ACTION controlp INFIELD mrba018 name="construct.c.mrba018"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL cq_oocq002()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO mrba018  #顯示到畫面上
            NEXT FIELD mrba018                     #返回原欄位
    



            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mrba018
            #add-point:BEFORE FIELD mrba018 name="construct.b.mrba018"
            

            
           
             
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mrba018
            
            #add-point:AFTER FIELD mrba018 name="construct.a.mrba018"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mrba102
            #add-point:BEFORE FIELD mrba102 name="construct.b.mrba102"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mrba102
            
            #add-point:AFTER FIELD mrba102 name="construct.a.mrba102"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.mrba102
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mrba102
            #add-point:ON ACTION controlp INFIELD mrba102 name="construct.c.mrba102"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mrba100
            #add-point:BEFORE FIELD mrba100 name="construct.b.mrba100"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mrba100
            
            #add-point:AFTER FIELD mrba100 name="construct.a.mrba100"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.mrba100
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mrba100
            #add-point:ON ACTION controlp INFIELD mrba100 name="construct.c.mrba100"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mrba101
            #add-point:BEFORE FIELD mrba101 name="construct.b.mrba101"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mrba101
            
            #add-point:AFTER FIELD mrba101 name="construct.a.mrba101"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.mrba101
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mrba101
            #add-point:ON ACTION controlp INFIELD mrba101 name="construct.c.mrba101"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mrbastus
            #add-point:BEFORE FIELD mrbastus name="construct.b.mrbastus"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mrbastus
            
            #add-point:AFTER FIELD mrbastus name="construct.a.mrbastus"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.mrbastus
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mrbastus
            #add-point:ON ACTION controlp INFIELD mrbastus name="construct.c.mrbastus"
            
            #END add-point
 
 
         #Ctrlp:construct.c.mrba021
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mrba021
            #add-point:ON ACTION controlp INFIELD mrba021 name="construct.c.mrba021"
            #此段落由子樣板a08產生
            #開窗c段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			LET g_qryparam.reqry = FALSE
            CALL q_oocq002()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO mrba021  #顯示到畫面上

            NEXT FIELD mrba021                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mrba021
            #add-point:BEFORE FIELD mrba021 name="construct.b.mrba021"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mrba021
            
            #add-point:AFTER FIELD mrba021 name="construct.a.mrba021"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.mrba022
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mrba022
            #add-point:ON ACTION controlp INFIELD mrba022 name="construct.c.mrba022"
            #此段落由子樣板a08產生
            #開窗c段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			LET g_qryparam.reqry = FALSE
            CALL q_ecaa001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO mrba022  #顯示到畫面上

            NEXT FIELD mrba022                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mrba022
            #add-point:BEFORE FIELD mrba022 name="construct.b.mrba022"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mrba022
            
            #add-point:AFTER FIELD mrba022 name="construct.a.mrba022"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mrba025
            #add-point:BEFORE FIELD mrba025 name="construct.b.mrba025"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mrba025
            
            #add-point:AFTER FIELD mrba025 name="construct.a.mrba025"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.mrba025
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mrba025
            #add-point:ON ACTION controlp INFIELD mrba025 name="construct.c.mrba025"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mrba026
            #add-point:BEFORE FIELD mrba026 name="construct.b.mrba026"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mrba026
            
            #add-point:AFTER FIELD mrba026 name="construct.a.mrba026"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.mrba026
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mrba026
            #add-point:ON ACTION controlp INFIELD mrba026 name="construct.c.mrba026"
            
            #END add-point
 
 
         #Ctrlp:construct.c.mrba027
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mrba027
            #add-point:ON ACTION controlp INFIELD mrba027 name="construct.c.mrba027"
            #此段落由子樣板a08產生
            #開窗c段
			   INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			   LET g_qryparam.reqry = FALSE
			   LET g_qryparam.arg1 = '1103'
            CALL q_oocq002()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO mrba027  #顯示到畫面上

            NEXT FIELD mrba027                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mrba027
            #add-point:BEFORE FIELD mrba027 name="construct.b.mrba027"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mrba027
            
            #add-point:AFTER FIELD mrba027 name="construct.a.mrba027"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.mrba103
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mrba103
            #add-point:ON ACTION controlp INFIELD mrba103 name="construct.c.mrba103"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_oogd001_01()                    #呼叫開窗
            DISPLAY g_qryparam.return1 TO mrba103  #顯示到畫面上
            NEXT FIELD mrba103                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mrba103
            #add-point:BEFORE FIELD mrba103 name="construct.b.mrba103"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mrba103
            
            #add-point:AFTER FIELD mrba103 name="construct.a.mrba103"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mrba029
            #add-point:BEFORE FIELD mrba029 name="construct.b.mrba029"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mrba029
            
            #add-point:AFTER FIELD mrba029 name="construct.a.mrba029"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.mrba029
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mrba029
            #add-point:ON ACTION controlp INFIELD mrba029 name="construct.c.mrba029"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mrba031
            #add-point:BEFORE FIELD mrba031 name="construct.b.mrba031"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mrba031
            
            #add-point:AFTER FIELD mrba031 name="construct.a.mrba031"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.mrba031
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mrba031
            #add-point:ON ACTION controlp INFIELD mrba031 name="construct.c.mrba031"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mrba032
            #add-point:BEFORE FIELD mrba032 name="construct.b.mrba032"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mrba032
            
            #add-point:AFTER FIELD mrba032 name="construct.a.mrba032"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.mrba032
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mrba032
            #add-point:ON ACTION controlp INFIELD mrba032 name="construct.c.mrba032"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mrba033
            #add-point:BEFORE FIELD mrba033 name="construct.b.mrba033"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mrba033
            
            #add-point:AFTER FIELD mrba033 name="construct.a.mrba033"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.mrba033
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mrba033
            #add-point:ON ACTION controlp INFIELD mrba033 name="construct.c.mrba033"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mrba034
            #add-point:BEFORE FIELD mrba034 name="construct.b.mrba034"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mrba034
            
            #add-point:AFTER FIELD mrba034 name="construct.a.mrba034"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.mrba034
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mrba034
            #add-point:ON ACTION controlp INFIELD mrba034 name="construct.c.mrba034"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mrba035
            #add-point:BEFORE FIELD mrba035 name="construct.b.mrba035"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mrba035
            
            #add-point:AFTER FIELD mrba035 name="construct.a.mrba035"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.mrba035
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mrba035
            #add-point:ON ACTION controlp INFIELD mrba035 name="construct.c.mrba035"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mrba036
            #add-point:BEFORE FIELD mrba036 name="construct.b.mrba036"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mrba036
            
            #add-point:AFTER FIELD mrba036 name="construct.a.mrba036"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.mrba036
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mrba036
            #add-point:ON ACTION controlp INFIELD mrba036 name="construct.c.mrba036"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mrba038
            #add-point:BEFORE FIELD mrba038 name="construct.b.mrba038"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mrba038
            
            #add-point:AFTER FIELD mrba038 name="construct.a.mrba038"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.mrba038
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mrba038
            #add-point:ON ACTION controlp INFIELD mrba038 name="construct.c.mrba038"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mrba039
            #add-point:BEFORE FIELD mrba039 name="construct.b.mrba039"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mrba039
            
            #add-point:AFTER FIELD mrba039 name="construct.a.mrba039"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.mrba039
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mrba039
            #add-point:ON ACTION controlp INFIELD mrba039 name="construct.c.mrba039"
            
            #END add-point
 
 
         #Ctrlp:construct.c.mrba040
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mrba040
            #add-point:ON ACTION controlp INFIELD mrba040 name="construct.c.mrba040"
            #此段落由子樣板a08產生
            #開窗c段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			LET g_qryparam.reqry = FALSE
            CALL q_ooaj002_1()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO mrba040  #顯示到畫面上

            NEXT FIELD mrba040                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mrba040
            #add-point:BEFORE FIELD mrba040 name="construct.b.mrba040"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mrba040
            
            #add-point:AFTER FIELD mrba040 name="construct.a.mrba040"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mrba041
            #add-point:BEFORE FIELD mrba041 name="construct.b.mrba041"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mrba041
            
            #add-point:AFTER FIELD mrba041 name="construct.a.mrba041"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.mrba041
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mrba041
            #add-point:ON ACTION controlp INFIELD mrba041 name="construct.c.mrba041"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mrba042
            #add-point:BEFORE FIELD mrba042 name="construct.b.mrba042"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mrba042
            
            #add-point:AFTER FIELD mrba042 name="construct.a.mrba042"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.mrba042
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mrba042
            #add-point:ON ACTION controlp INFIELD mrba042 name="construct.c.mrba042"
            
            #END add-point
 
 
         #Ctrlp:construct.c.mrbaownid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mrbaownid
            #add-point:ON ACTION controlp INFIELD mrbaownid name="construct.c.mrbaownid"
            #此段落由子樣板a08產生
            #開窗c段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO mrbaownid  #顯示到畫面上

            NEXT FIELD mrbaownid                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mrbaownid
            #add-point:BEFORE FIELD mrbaownid name="construct.b.mrbaownid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mrbaownid
            
            #add-point:AFTER FIELD mrbaownid name="construct.a.mrbaownid"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.mrbaowndp
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mrbaowndp
            #add-point:ON ACTION controlp INFIELD mrbaowndp name="construct.c.mrbaowndp"
            #此段落由子樣板a08產生
            #開窗c段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			LET g_qryparam.reqry = FALSE
            CALL q_ooeg001_9()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO mrbaowndp  #顯示到畫面上

            NEXT FIELD mrbaowndp                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mrbaowndp
            #add-point:BEFORE FIELD mrbaowndp name="construct.b.mrbaowndp"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mrbaowndp
            
            #add-point:AFTER FIELD mrbaowndp name="construct.a.mrbaowndp"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.mrbacrtid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mrbacrtid
            #add-point:ON ACTION controlp INFIELD mrbacrtid name="construct.c.mrbacrtid"
            #此段落由子樣板a08產生
            #開窗c段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO mrbacrtid  #顯示到畫面上

            NEXT FIELD mrbacrtid                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mrbacrtid
            #add-point:BEFORE FIELD mrbacrtid name="construct.b.mrbacrtid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mrbacrtid
            
            #add-point:AFTER FIELD mrbacrtid name="construct.a.mrbacrtid"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.mrbacrtdp
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mrbacrtdp
            #add-point:ON ACTION controlp INFIELD mrbacrtdp name="construct.c.mrbacrtdp"
            #此段落由子樣板a08產生
            #開窗c段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			LET g_qryparam.reqry = FALSE
            CALL q_ooeg001_9()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO mrbacrtdp  #顯示到畫面上

            NEXT FIELD mrbacrtdp                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mrbacrtdp
            #add-point:BEFORE FIELD mrbacrtdp name="construct.b.mrbacrtdp"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mrbacrtdp
            
            #add-point:AFTER FIELD mrbacrtdp name="construct.a.mrbacrtdp"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mrbacrtdt
            #add-point:BEFORE FIELD mrbacrtdt name="construct.b.mrbacrtdt"
            
            #END add-point
 
 
         #Ctrlp:construct.c.mrbamodid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mrbamodid
            #add-point:ON ACTION controlp INFIELD mrbamodid name="construct.c.mrbamodid"
            #此段落由子樣板a08產生
            #開窗c段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO mrbamodid  #顯示到畫面上

            NEXT FIELD mrbamodid                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mrbamodid
            #add-point:BEFORE FIELD mrbamodid name="construct.b.mrbamodid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mrbamodid
            
            #add-point:AFTER FIELD mrbamodid name="construct.a.mrbamodid"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mrbamoddt
            #add-point:BEFORE FIELD mrbamoddt name="construct.b.mrbamoddt"
            
            #END add-point
 
 
         #Ctrlp:construct.c.mrbacnfid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mrbacnfid
            #add-point:ON ACTION controlp INFIELD mrbacnfid name="construct.c.mrbacnfid"
            #此段落由子樣板a08產生
            #開窗c段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO mrbacnfid  #顯示到畫面上

            NEXT FIELD mrbacnfid                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mrbacnfid
            #add-point:BEFORE FIELD mrbacnfid name="construct.b.mrbacnfid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mrbacnfid
            
            #add-point:AFTER FIELD mrbacnfid name="construct.a.mrbacnfid"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mrbacnfdt
            #add-point:BEFORE FIELD mrbacnfdt name="construct.b.mrbacnfdt"
            
            #END add-point
 
 
 
         
      END CONSTRUCT
 
      #單身根據table分拆construct
      CONSTRUCT g_wc2_table1 ON mrbbstus,mrbb002,mrbb003,mrbb004,mrbb005,mrbb006,mrbb007,mrbb008,mrbb009, 
          mrbb010,mrbb011,mrbb012,mrbb013
           FROM s_detail1[1].mrbbstus,s_detail1[1].mrbb002,s_detail1[1].mrbb003,s_detail1[1].mrbb004, 
               s_detail1[1].mrbb005,s_detail1[1].mrbb006,s_detail1[1].mrbb007,s_detail1[1].mrbb008,s_detail1[1].mrbb009, 
               s_detail1[1].mrbb010,s_detail1[1].mrbb011,s_detail1[1].mrbb012,s_detail1[1].mrbb013
                      
         BEFORE CONSTRUCT
            #add-point:cs段before_construct name="cs.body.before_construct"
            
            #end add-point 
            
       #單身公用欄位開窗相關處理
       #應用 a11 樣板自動產生(Version:3)
         #共用欄位查詢處理  
         ##----<<mrbbcrtdt>>----
 
         #----<<mrbbmoddt>>----
         
         #----<<mrbbcnfdt>>----
         
         #----<<mrbbpstdt>>----
 
 
 
         
       #單身一般欄位開窗相關處理
                #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mrbbstus
            #add-point:BEFORE FIELD mrbbstus name="construct.b.page1.mrbbstus"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mrbbstus
            
            #add-point:AFTER FIELD mrbbstus name="construct.a.page1.mrbbstus"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.mrbbstus
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mrbbstus
            #add-point:ON ACTION controlp INFIELD mrbbstus name="construct.c.page1.mrbbstus"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mrbb002
            #add-point:BEFORE FIELD mrbb002 name="construct.b.page1.mrbb002"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mrbb002
            
            #add-point:AFTER FIELD mrbb002 name="construct.a.page1.mrbb002"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.mrbb002
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mrbb002
            #add-point:ON ACTION controlp INFIELD mrbb002 name="construct.c.page1.mrbb002"
            
            #END add-point
 
 
         #Ctrlp:construct.c.page1.mrbb003
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mrbb003
            #add-point:ON ACTION controlp INFIELD mrbb003 name="construct.c.page1.mrbb003"
            #此段落由子樣板a08產生
            #開窗c段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			LET g_qryparam.reqry = FALSE
            CALL q_oocq002()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO mrbb003  #顯示到畫面上

            NEXT FIELD mrbb003                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mrbb003
            #add-point:BEFORE FIELD mrbb003 name="construct.b.page1.mrbb003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mrbb003
            
            #add-point:AFTER FIELD mrbb003 name="construct.a.page1.mrbb003"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.mrbb004
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mrbb004
            #add-point:ON ACTION controlp INFIELD mrbb004 name="construct.c.page1.mrbb004"
            #此段落由子樣板a08產生
            #開窗c段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			LET g_qryparam.reqry = FALSE
            CALL q_mraa001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO mrbb004  #顯示到畫面上

            NEXT FIELD mrbb004                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mrbb004
            #add-point:BEFORE FIELD mrbb004 name="construct.b.page1.mrbb004"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mrbb004
            
            #add-point:AFTER FIELD mrbb004 name="construct.a.page1.mrbb004"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mrbb005
            #add-point:BEFORE FIELD mrbb005 name="construct.b.page1.mrbb005"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mrbb005
            
            #add-point:AFTER FIELD mrbb005 name="construct.a.page1.mrbb005"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.mrbb005
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mrbb005
            #add-point:ON ACTION controlp INFIELD mrbb005 name="construct.c.page1.mrbb005"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mrbb006
            #add-point:BEFORE FIELD mrbb006 name="construct.b.page1.mrbb006"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mrbb006
            
            #add-point:AFTER FIELD mrbb006 name="construct.a.page1.mrbb006"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.mrbb006
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mrbb006
            #add-point:ON ACTION controlp INFIELD mrbb006 name="construct.c.page1.mrbb006"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mrbb007
            #add-point:BEFORE FIELD mrbb007 name="construct.b.page1.mrbb007"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mrbb007
            
            #add-point:AFTER FIELD mrbb007 name="construct.a.page1.mrbb007"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.mrbb007
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mrbb007
            #add-point:ON ACTION controlp INFIELD mrbb007 name="construct.c.page1.mrbb007"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mrbb008
            #add-point:BEFORE FIELD mrbb008 name="construct.b.page1.mrbb008"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mrbb008
            
            #add-point:AFTER FIELD mrbb008 name="construct.a.page1.mrbb008"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.mrbb008
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mrbb008
            #add-point:ON ACTION controlp INFIELD mrbb008 name="construct.c.page1.mrbb008"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mrbb009
            #add-point:BEFORE FIELD mrbb009 name="construct.b.page1.mrbb009"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mrbb009
            
            #add-point:AFTER FIELD mrbb009 name="construct.a.page1.mrbb009"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.mrbb009
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mrbb009
            #add-point:ON ACTION controlp INFIELD mrbb009 name="construct.c.page1.mrbb009"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mrbb010
            #add-point:BEFORE FIELD mrbb010 name="construct.b.page1.mrbb010"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mrbb010
            
            #add-point:AFTER FIELD mrbb010 name="construct.a.page1.mrbb010"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.mrbb010
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mrbb010
            #add-point:ON ACTION controlp INFIELD mrbb010 name="construct.c.page1.mrbb010"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mrbb011
            #add-point:BEFORE FIELD mrbb011 name="construct.b.page1.mrbb011"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mrbb011
            
            #add-point:AFTER FIELD mrbb011 name="construct.a.page1.mrbb011"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.mrbb011
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mrbb011
            #add-point:ON ACTION controlp INFIELD mrbb011 name="construct.c.page1.mrbb011"
            
            #END add-point
 
 
         #Ctrlp:construct.c.page1.mrbb012
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mrbb012
            #add-point:ON ACTION controlp INFIELD mrbb012 name="construct.c.page1.mrbb012"
            #此段落由子樣板a08產生
            #開窗c段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO mrbb012  #顯示到畫面上

            NEXT FIELD mrbb012                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mrbb012
            #add-point:BEFORE FIELD mrbb012 name="construct.b.page1.mrbb012"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mrbb012
            
            #add-point:AFTER FIELD mrbb012 name="construct.a.page1.mrbb012"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mrbb013
            #add-point:BEFORE FIELD mrbb013 name="construct.b.page1.mrbb013"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mrbb013
            
            #add-point:AFTER FIELD mrbb013 name="construct.a.page1.mrbb013"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.mrbb013
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mrbb013
            #add-point:ON ACTION controlp INFIELD mrbb013 name="construct.c.page1.mrbb013"
            
            #END add-point
 
 
   
       
      END CONSTRUCT
      
      CONSTRUCT g_wc2_table2 ON mrbc002,mrbc003,mrbc004,mrbc005,mrbc006,mrbc007,mrbc008,mrbc009,mrbc010, 
          mrbc011
           FROM s_detail2[1].mrbc002,s_detail2[1].mrbc003,s_detail2[1].mrbc004,s_detail2[1].mrbc005, 
               s_detail2[1].mrbc006,s_detail2[1].mrbc007,s_detail2[1].mrbc008,s_detail2[1].mrbc009,s_detail2[1].mrbc010, 
               s_detail2[1].mrbc011
                      
         BEFORE CONSTRUCT
            #add-point:cs段before_construct name="cs.body2.before_construct"
            
            #end add-point 
            
       #單身公用欄位開窗相關處理(table 2)
       
       
       #單身一般欄位開窗相關處理       
                #Ctrlp:construct.c.page2.mrbc002
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mrbc002
            #add-point:ON ACTION controlp INFIELD mrbc002 name="construct.c.page2.mrbc002"
            #此段落由子樣板a08產生
            #開窗c段
			   INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			   LET g_qryparam.reqry = FALSE
            CALL q_mrbc002()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO mrbc002  #顯示到畫面上

            NEXT FIELD mrbc002                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mrbc002
            #add-point:BEFORE FIELD mrbc002 name="construct.b.page2.mrbc002"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mrbc002
            
            #add-point:AFTER FIELD mrbc002 name="construct.a.page2.mrbc002"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mrbc003
            #add-point:BEFORE FIELD mrbc003 name="construct.b.page2.mrbc003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mrbc003
            
            #add-point:AFTER FIELD mrbc003 name="construct.a.page2.mrbc003"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.mrbc003
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mrbc003
            #add-point:ON ACTION controlp INFIELD mrbc003 name="construct.c.page2.mrbc003"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mrbc004
            #add-point:BEFORE FIELD mrbc004 name="construct.b.page2.mrbc004"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mrbc004
            
            #add-point:AFTER FIELD mrbc004 name="construct.a.page2.mrbc004"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.mrbc004
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mrbc004
            #add-point:ON ACTION controlp INFIELD mrbc004 name="construct.c.page2.mrbc004"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mrbc005
            #add-point:BEFORE FIELD mrbc005 name="construct.b.page2.mrbc005"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mrbc005
            
            #add-point:AFTER FIELD mrbc005 name="construct.a.page2.mrbc005"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.mrbc005
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mrbc005
            #add-point:ON ACTION controlp INFIELD mrbc005 name="construct.c.page2.mrbc005"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mrbc006
            #add-point:BEFORE FIELD mrbc006 name="construct.b.page2.mrbc006"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mrbc006
            
            #add-point:AFTER FIELD mrbc006 name="construct.a.page2.mrbc006"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.mrbc006
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mrbc006
            #add-point:ON ACTION controlp INFIELD mrbc006 name="construct.c.page2.mrbc006"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mrbc007
            #add-point:BEFORE FIELD mrbc007 name="construct.b.page2.mrbc007"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mrbc007
            
            #add-point:AFTER FIELD mrbc007 name="construct.a.page2.mrbc007"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.mrbc007
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mrbc007
            #add-point:ON ACTION controlp INFIELD mrbc007 name="construct.c.page2.mrbc007"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mrbc008
            #add-point:BEFORE FIELD mrbc008 name="construct.b.page2.mrbc008"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mrbc008
            
            #add-point:AFTER FIELD mrbc008 name="construct.a.page2.mrbc008"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.mrbc008
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mrbc008
            #add-point:ON ACTION controlp INFIELD mrbc008 name="construct.c.page2.mrbc008"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mrbc009
            #add-point:BEFORE FIELD mrbc009 name="construct.b.page2.mrbc009"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mrbc009
            
            #add-point:AFTER FIELD mrbc009 name="construct.a.page2.mrbc009"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.mrbc009
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mrbc009
            #add-point:ON ACTION controlp INFIELD mrbc009 name="construct.c.page2.mrbc009"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mrbc010
            #add-point:BEFORE FIELD mrbc010 name="construct.b.page2.mrbc010"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mrbc010
            
            #add-point:AFTER FIELD mrbc010 name="construct.a.page2.mrbc010"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.mrbc010
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mrbc010
            #add-point:ON ACTION controlp INFIELD mrbc010 name="construct.c.page2.mrbc010"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mrbc011
            #add-point:BEFORE FIELD mrbc011 name="construct.b.page2.mrbc011"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mrbc011
            
            #add-point:AFTER FIELD mrbc011 name="construct.a.page2.mrbc011"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.mrbc011
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mrbc011
            #add-point:ON ACTION controlp INFIELD mrbc011 name="construct.c.page2.mrbc011"
            
            #END add-point
 
 
   
       
      END CONSTRUCT
 
      CONSTRUCT g_wc2_table3 ON mrbd002,mrbd003,mrbd004,mrbd005,mrbd006,mrbd007,mrbd008,mrbd009,mrbd010 
 
           FROM s_detail3[1].mrbd002,s_detail3[1].mrbd003,s_detail3[1].mrbd004,s_detail3[1].mrbd005, 
               s_detail3[1].mrbd006,s_detail3[1].mrbd007,s_detail3[1].mrbd008,s_detail3[1].mrbd009,s_detail3[1].mrbd010 
 
                      
         BEFORE CONSTRUCT
            #add-point:cs段before_construct name="cs.body3.before_construct"
            
            #end add-point 
            
       #單身公用欄位開窗相關處理(table 3)
       
       
       #單身一般欄位開窗相關處理       
                #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mrbd002
            #add-point:BEFORE FIELD mrbd002 name="construct.b.page3.mrbd002"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mrbd002
            
            #add-point:AFTER FIELD mrbd002 name="construct.a.page3.mrbd002"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page3.mrbd002
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mrbd002
            #add-point:ON ACTION controlp INFIELD mrbd002 name="construct.c.page3.mrbd002"
            
            #END add-point
 
 
         #Ctrlp:construct.c.page3.mrbd003
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mrbd003
            #add-point:ON ACTION controlp INFIELD mrbd003 name="construct.c.page3.mrbd003"
            #此段落由子樣板a08產生
            #開窗c段
			   INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			   LET g_qryparam.reqry = FALSE
#160716-00003#1-s
#           CALL q_imaa001()                       #呼叫開窗
            CALL q_imaf001_15()                    #呼叫開窗
#160716-00003#1-e
            DISPLAY g_qryparam.return1 TO mrbd003  #顯示到畫面上
            NEXT FIELD mrbd003                     #返回原欄位
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mrbd003
            #add-point:BEFORE FIELD mrbd003 name="construct.b.page3.mrbd003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mrbd003
            
            #add-point:AFTER FIELD mrbd003 name="construct.a.page3.mrbd003"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mrbd004
            #add-point:BEFORE FIELD mrbd004 name="construct.b.page3.mrbd004"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mrbd004
            
            #add-point:AFTER FIELD mrbd004 name="construct.a.page3.mrbd004"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page3.mrbd004
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mrbd004
            #add-point:ON ACTION controlp INFIELD mrbd004 name="construct.c.page3.mrbd004"
            
            #END add-point
 
 
         #Ctrlp:construct.c.page3.mrbd005
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mrbd005
            #add-point:ON ACTION controlp INFIELD mrbd005 name="construct.c.page3.mrbd005"
            #此段落由子樣板a08產生
            #開窗c段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			LET g_qryparam.reqry = FALSE
            CALL q_oocq002()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO mrbd005  #顯示到畫面上

            NEXT FIELD mrbd005                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mrbd005
            #add-point:BEFORE FIELD mrbd005 name="construct.b.page3.mrbd005"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mrbd005
            
            #add-point:AFTER FIELD mrbd005 name="construct.a.page3.mrbd005"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page3.mrbd006
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mrbd006
            #add-point:ON ACTION controlp INFIELD mrbd006 name="construct.c.page3.mrbd006"
            #此段落由子樣板a08產生
            #開窗c段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			LET g_qryparam.reqry = FALSE
            CALL q_ooca001_1()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO mrbd006  #顯示到畫面上

            NEXT FIELD mrbd006                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mrbd006
            #add-point:BEFORE FIELD mrbd006 name="construct.b.page3.mrbd006"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mrbd006
            
            #add-point:AFTER FIELD mrbd006 name="construct.a.page3.mrbd006"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mrbd007
            #add-point:BEFORE FIELD mrbd007 name="construct.b.page3.mrbd007"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mrbd007
            
            #add-point:AFTER FIELD mrbd007 name="construct.a.page3.mrbd007"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page3.mrbd007
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mrbd007
            #add-point:ON ACTION controlp INFIELD mrbd007 name="construct.c.page3.mrbd007"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mrbd008
            #add-point:BEFORE FIELD mrbd008 name="construct.b.page3.mrbd008"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mrbd008
            
            #add-point:AFTER FIELD mrbd008 name="construct.a.page3.mrbd008"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page3.mrbd008
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mrbd008
            #add-point:ON ACTION controlp INFIELD mrbd008 name="construct.c.page3.mrbd008"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mrbd009
            #add-point:BEFORE FIELD mrbd009 name="construct.b.page3.mrbd009"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mrbd009
            
            #add-point:AFTER FIELD mrbd009 name="construct.a.page3.mrbd009"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page3.mrbd009
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mrbd009
            #add-point:ON ACTION controlp INFIELD mrbd009 name="construct.c.page3.mrbd009"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mrbd010
            #add-point:BEFORE FIELD mrbd010 name="construct.b.page3.mrbd010"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mrbd010
            
            #add-point:AFTER FIELD mrbd010 name="construct.a.page3.mrbd010"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page3.mrbd010
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mrbd010
            #add-point:ON ACTION controlp INFIELD mrbd010 name="construct.c.page3.mrbd010"
            
            #END add-point
 
 
   
       
      END CONSTRUCT
 
      CONSTRUCT g_wc2_table4 ON mrbe002
           FROM s_detail4[1].mrbe002
                      
         BEFORE CONSTRUCT
            #add-point:cs段before_construct name="cs.body4.before_construct"
            
            #end add-point 
            
       #單身公用欄位開窗相關處理(table 4)
       
       
       #單身一般欄位開窗相關處理       
                #Ctrlp:construct.c.page4.mrbe002
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mrbe002
            #add-point:ON ACTION controlp INFIELD mrbe002 name="construct.c.page4.mrbe002"
            #此段落由子樣板a08產生
            #開窗c段
			   INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			   LET g_qryparam.reqry = FALSE
#160716-00003#1-s
#           CALL q_imaa001()                       #呼叫開窗
            CALL q_imaf001()                       #呼叫開窗
#160716-00003#1-e            
            DISPLAY g_qryparam.return1 TO mrbe002  #顯示到畫面上
            NEXT FIELD mrbe002                     #返回原欄位
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mrbe002
            #add-point:BEFORE FIELD mrbe002 name="construct.b.page4.mrbe002"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mrbe002
            
            #add-point:AFTER FIELD mrbe002 name="construct.a.page4.mrbe002"
            
            #END add-point
            
 
 
   
       
      END CONSTRUCT
 
      CONSTRUCT g_wc2_table5 ON mrbf002
           FROM s_detail5[1].mrbf002
                      
         BEFORE CONSTRUCT
            #add-point:cs段before_construct name="cs.body5.before_construct"
            
            #end add-point 
            
       #單身公用欄位開窗相關處理(table 5)
       
       
       #單身一般欄位開窗相關處理       
                #Ctrlp:construct.c.page5.mrbf002
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mrbf002
            #add-point:ON ACTION controlp INFIELD mrbf002 name="construct.c.page5.mrbf002"
            #此段落由子樣板a08產生
            #開窗c段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			LET g_qryparam.reqry = FALSE
            CALL q_mrba001_2()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO mrbf002  #顯示到畫面上

            NEXT FIELD mrbf002                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mrbf002
            #add-point:BEFORE FIELD mrbf002 name="construct.b.page5.mrbf002"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mrbf002
            
            #add-point:AFTER FIELD mrbf002 name="construct.a.page5.mrbf002"
            
            #END add-point
            
 
 
   
       
      END CONSTRUCT
 
      CONSTRUCT g_wc2_table6 ON mrbg002,mrbg003,mrbg004,mrbg005,mrbg006,mrbg007,mrbg008
           FROM s_detail6[1].mrbg002,s_detail6[1].mrbg003,s_detail6[1].mrbg004,s_detail6[1].mrbg005, 
               s_detail6[1].mrbg006,s_detail6[1].mrbg007,s_detail6[1].mrbg008
                      
         BEFORE CONSTRUCT
            #add-point:cs段before_construct name="cs.body6.before_construct"
            
            #end add-point 
            
       #單身公用欄位開窗相關處理(table 6)
       
       
       #單身一般欄位開窗相關處理       
                #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mrbg002
            #add-point:BEFORE FIELD mrbg002 name="construct.b.page6.mrbg002"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mrbg002
            
            #add-point:AFTER FIELD mrbg002 name="construct.a.page6.mrbg002"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page6.mrbg002
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mrbg002
            #add-point:ON ACTION controlp INFIELD mrbg002 name="construct.c.page6.mrbg002"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mrbg003
            #add-point:BEFORE FIELD mrbg003 name="construct.b.page6.mrbg003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mrbg003
            
            #add-point:AFTER FIELD mrbg003 name="construct.a.page6.mrbg003"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page6.mrbg003
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mrbg003
            #add-point:ON ACTION controlp INFIELD mrbg003 name="construct.c.page6.mrbg003"
            
            #END add-point
 
 
         #Ctrlp:construct.c.page6.mrbg004
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mrbg004
            #add-point:ON ACTION controlp INFIELD mrbg004 name="construct.c.page6.mrbg004"
            #此段落由子樣板a08產生
            #開窗c段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			LET g_qryparam.reqry = FALSE
            CALL q_oocq002()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO mrbg004  #顯示到畫面上

            NEXT FIELD mrbg004                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mrbg004
            #add-point:BEFORE FIELD mrbg004 name="construct.b.page6.mrbg004"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mrbg004
            
            #add-point:AFTER FIELD mrbg004 name="construct.a.page6.mrbg004"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mrbg005
            #add-point:BEFORE FIELD mrbg005 name="construct.b.page6.mrbg005"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mrbg005
            
            #add-point:AFTER FIELD mrbg005 name="construct.a.page6.mrbg005"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page6.mrbg005
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mrbg005
            #add-point:ON ACTION controlp INFIELD mrbg005 name="construct.c.page6.mrbg005"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mrbg006
            #add-point:BEFORE FIELD mrbg006 name="construct.b.page6.mrbg006"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mrbg006
            
            #add-point:AFTER FIELD mrbg006 name="construct.a.page6.mrbg006"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page6.mrbg006
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mrbg006
            #add-point:ON ACTION controlp INFIELD mrbg006 name="construct.c.page6.mrbg006"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mrbg007
            #add-point:BEFORE FIELD mrbg007 name="construct.b.page6.mrbg007"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mrbg007
            
            #add-point:AFTER FIELD mrbg007 name="construct.a.page6.mrbg007"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page6.mrbg007
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mrbg007
            #add-point:ON ACTION controlp INFIELD mrbg007 name="construct.c.page6.mrbg007"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mrbg008
            #add-point:BEFORE FIELD mrbg008 name="construct.b.page6.mrbg008"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mrbg008
            
            #add-point:AFTER FIELD mrbg008 name="construct.a.page6.mrbg008"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page6.mrbg008
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mrbg008
            #add-point:ON ACTION controlp INFIELD mrbg008 name="construct.c.page6.mrbg008"
            
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
 
            INITIALIZE g_wc2_table4 TO NULL
 
            INITIALIZE g_wc2_table5 TO NULL
 
            INITIALIZE g_wc2_table6 TO NULL
 
 
            FOR li_idx = 1 TO la_wc.getLength()
               CASE
                  WHEN la_wc[li_idx].tableid = "mrba_t" 
                     LET g_wc = la_wc[li_idx].wc
                  WHEN la_wc[li_idx].tableid = "mrbb_t" 
                     LET g_wc2_table1 = la_wc[li_idx].wc
                  WHEN la_wc[li_idx].tableid = "mrbc_t" 
                     LET g_wc2_table2 = la_wc[li_idx].wc
 
                  WHEN la_wc[li_idx].tableid = "mrbd_t" 
                     LET g_wc2_table3 = la_wc[li_idx].wc
 
                  WHEN la_wc[li_idx].tableid = "mrbe_t" 
                     LET g_wc2_table4 = la_wc[li_idx].wc
 
                  WHEN la_wc[li_idx].tableid = "mrbf_t" 
                     LET g_wc2_table5 = la_wc[li_idx].wc
 
                  WHEN la_wc[li_idx].tableid = "mrbg_t" 
                     LET g_wc2_table6 = la_wc[li_idx].wc
 
 
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
 
   IF g_wc2_table4 <> " 1=1" THEN
      LET g_wc2 = g_wc2 ," AND ", g_wc2_table4
   END IF
 
   IF g_wc2_table5 <> " 1=1" THEN
      LET g_wc2 = g_wc2 ," AND ", g_wc2_table5
   END IF
 
   IF g_wc2_table6 <> " 1=1" THEN
      LET g_wc2 = g_wc2 ," AND ", g_wc2_table6
   END IF
 
 
 
 
   
   #add-point:cs段結束前 name="cs.after_construct"
   
   #end add-point    
 
   IF INT_FLAG THEN
      RETURN
   END IF
 
END FUNCTION
 
{</section>}
 
{<section id="amrm200.filter" >}
#應用 a50 樣板自動產生(Version:8)
#+ filter過濾功能
PRIVATE FUNCTION amrm200_filter()
   #add-point:filter段define name="filter.define_customerization"
   
   #end add-point   
   #add-point:filter段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="filter.define"
   
   #end add-point   
   
   #add-point:Function前置處理  name="filter.pre_function"
   
   #end add-point
   
   #切換畫面
   IF NOT g_main_hidden THEN
      CALL gfrm_curr.setElementHidden("mainlayout",1)
      CALL gfrm_curr.setElementHidden("worksheet",0)
      LET g_main_hidden = 1
   END IF   
 
   LET INT_FLAG = 0
 
   LET g_qryparam.state = 'c'
 
   LET g_wc_filter_t = g_wc_filter.trim()
   LET g_wc_t = g_wc
 
   LET g_wc = cl_replace_str(g_wc, g_wc_filter_t, '')
 
   #使用DIALOG包住 單頭CONSTRUCT及單身CONSTRUCT
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
 
      #單頭
      CONSTRUCT g_wc_filter ON mrba001,mrba000,mrba002,mrba003,mrba004,mrba005
                          FROM s_browse[1].b_mrba001,s_browse[1].b_mrba000,s_browse[1].b_mrba002,s_browse[1].b_mrba003, 
                              s_browse[1].b_mrba004,s_browse[1].b_mrba005
 
         BEFORE CONSTRUCT
               DISPLAY amrm200_filter_parser('mrba001') TO s_browse[1].b_mrba001
            DISPLAY amrm200_filter_parser('mrba000') TO s_browse[1].b_mrba000
            DISPLAY amrm200_filter_parser('mrba002') TO s_browse[1].b_mrba002
            DISPLAY amrm200_filter_parser('mrba003') TO s_browse[1].b_mrba003
            DISPLAY amrm200_filter_parser('mrba004') TO s_browse[1].b_mrba004
            DISPLAY amrm200_filter_parser('mrba005') TO s_browse[1].b_mrba005
      
         #add-point:filter段cs_ctrl name="filter.cs_ctrl"
         
         #end add-point
      
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
 
   IF NOT INT_FLAG THEN
      LET g_wc_filter = "   AND   ", g_wc_filter, "   "
      LET g_wc = g_wc , g_wc_filter
   ELSE
      LET g_wc_filter = g_wc_filter_t
      LET g_wc = g_wc_t
   END IF
 
      CALL amrm200_filter_show('mrba001')
   CALL amrm200_filter_show('mrba000')
   CALL amrm200_filter_show('mrba002')
   CALL amrm200_filter_show('mrba003')
   CALL amrm200_filter_show('mrba004')
   CALL amrm200_filter_show('mrba005')
 
END FUNCTION
 
{</section>}
 
{<section id="amrm200.filter_parser" >}
#+ filter過濾功能
PRIVATE FUNCTION amrm200_filter_parser(ps_field)
   #add-point:filter段define name="filter_parser.define_customerization"
   
   #end add-point    
   DEFINE ps_field   STRING
   DEFINE ls_tmp     STRING
   DEFINE li_tmp     LIKE type_t.num10
   DEFINE li_tmp2    LIKE type_t.num10
   DEFINE ls_var     STRING
   #add-point:filter段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="filter_parser.define"
   
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
 
{<section id="amrm200.filter_show" >}
#+ 顯示過濾條件
PRIVATE FUNCTION amrm200_filter_show(ps_field)
   DEFINE ps_field         STRING
   DEFINE lnode_item       om.DomNode
   DEFINE ls_title         STRING
   DEFINE ls_name          STRING
   DEFINE ls_condition     STRING
 
   LET ls_name = "formonly.b_", ps_field
   LET lnode_item = gfrm_curr.findNode("TableColumn", ls_name)
   LET ls_title = lnode_item.getAttribute("text")
   IF ls_title.getIndexOf('※',1) > 0 THEN
      LEt ls_title = ls_title.subString(1,ls_title.getIndexOf('※',1)-1)
   END IF
 
   #顯示資料組合
   LET ls_condition = amrm200_filter_parser(ps_field)
   IF NOT cl_null(ls_condition) THEN
      LET ls_title = ls_title, '※', ls_condition, '※'
   END IF
 
   #將資料顯示回去
   CALL lnode_item.setAttribute("text",ls_title)
 
END FUNCTION
 
{</section>}
 
{<section id="amrm200.query" >}
#+ 資料查詢QBE功能準備
PRIVATE FUNCTION amrm200_query()
   #add-point:query段define(客製用) name="query.define_customerization"
   
   #end add-point   
   DEFINE ls_wc STRING
   #add-point:query段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="query.define"
   
   #end add-point   
   
   #add-point:Function前置處理  name="query.pre_function"
   
   #end add-point
   
   #切換畫面
   IF g_main_hidden THEN
      CALL gfrm_curr.setElementHidden("mainlayout",0)
      CALL gfrm_curr.setElementHidden("worksheet",1)
      LET g_main_hidden = 0
   END IF   
   
   LET ls_wc = g_wc
   
   LET INT_FLAG = 0
   CALL cl_navigator_setting( g_current_idx, g_detail_cnt )
   ERROR ""
   
   #清除畫面及相關資料
   CLEAR FORM
   CALL g_browser.clear()       
   CALL g_mrbb_d.clear()
   CALL g_mrbb2_d.clear()
   CALL g_mrbb3_d.clear()
   CALL g_mrbb4_d.clear()
   CALL g_mrbb5_d.clear()
   CALL g_mrbb6_d.clear()
 
   
   #add-point:query段other name="query.other"
   
   #end add-point   
   
   DISPLAY '' TO FORMONLY.idx
   DISPLAY '' TO FORMONLY.cnt
   DISPLAY '' TO FORMONLY.b_index
   DISPLAY '' TO FORMONLY.b_count
   DISPLAY '' TO FORMONLY.h_index
   DISPLAY '' TO FORMONLY.h_count
   
   CALL amrm200_construct()
 
   IF INT_FLAG THEN
      #取消查詢
      LET INT_FLAG = 0
      #LET g_wc = ls_wc
      LET g_wc = " 1=2"
      CALL amrm200_browser_fill("")
      CALL amrm200_fetch("")
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
   LET g_detail_idx_list[5] = 1
   LET g_detail_idx_list[6] = 1
 
   LET g_error_show  = 1
   LET g_wc_filter   = ""
   LET l_ac = 1
   CALL FGL_SET_ARR_CURR(1)
      CALL amrm200_filter_show('mrba001')
   CALL amrm200_filter_show('mrba000')
   CALL amrm200_filter_show('mrba002')
   CALL amrm200_filter_show('mrba003')
   CALL amrm200_filter_show('mrba004')
   CALL amrm200_filter_show('mrba005')
   CALL amrm200_browser_fill("F")
         
   IF g_browser_cnt = 0 THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code = "-100" 
      LET g_errparam.popup = TRUE 
      CALL cl_err()
   ELSE
      CALL amrm200_fetch("F") 
      #顯示單身筆數
      CALL amrm200_idx_chk()
   END IF
 
END FUNCTION
 
{</section>}
 
{<section id="amrm200.fetch" >}
#+ 指定PK後抓取單頭其他資料
PRIVATE FUNCTION amrm200_fetch(p_flag)
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
 
   CALL g_curr_diag.setCurrentRow("s_browse", g_current_idx) #設定browse 索引
   
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
   LET g_browser_idx = g_pagestart+g_current_idx-1
   DISPLAY g_browser_idx TO FORMONLY.b_index   #當下筆數
   DISPLAY g_browser_idx TO FORMONLY.h_index   #當下筆數
   
   CALL cl_navigator_setting( g_current_idx, g_browser_cnt )
 
   #代表沒有資料
   IF g_current_idx = 0 OR g_browser.getLength() = 0 THEN
      RETURN
   END IF
   
   #避免超出browser資料筆數上限
   IF g_current_idx > g_browser.getLength() THEN
      LET g_browser_idx = g_browser.getLength()
      LET g_current_idx = g_browser.getLength()
   END IF
   
   LET g_mrba_m.mrba001 = g_browser[g_current_idx].b_mrba001
 
   
   #重讀DB,因TEMP有不被更新特性
   EXECUTE amrm200_master_referesh USING g_site,g_mrba_m.mrba001 INTO g_mrba_m.mrba019,g_mrba_m.mrba000, 
       g_mrba_m.mrba001,g_mrba_m.mrba002,g_mrba_m.mrba003,g_mrba_m.mrba066,g_mrba_m.mrba004,g_mrba_m.mrba005, 
       g_mrba_m.mrba007,g_mrba_m.mrba008,g_mrba_m.mrba009,g_mrba_m.mrba010,g_mrba_m.mrba011,g_mrba_m.mrba020, 
       g_mrba_m.mrba006,g_mrba_m.mrba104,g_mrba_m.mrba012,g_mrba_m.mrba013,g_mrba_m.mrba014,g_mrba_m.mrba015, 
       g_mrba_m.mrba016,g_mrba_m.mrba017,g_mrba_m.mrba018,g_mrba_m.mrba102,g_mrba_m.mrba100,g_mrba_m.mrba101, 
       g_mrba_m.mrbastus,g_mrba_m.mrba021,g_mrba_m.mrba022,g_mrba_m.mrba025,g_mrba_m.mrba026,g_mrba_m.mrba027, 
       g_mrba_m.mrba103,g_mrba_m.mrba029,g_mrba_m.mrba031,g_mrba_m.mrba032,g_mrba_m.mrba033,g_mrba_m.mrba034, 
       g_mrba_m.mrba035,g_mrba_m.mrba036,g_mrba_m.mrba038,g_mrba_m.mrba039,g_mrba_m.mrba040,g_mrba_m.mrba041, 
       g_mrba_m.mrba042,g_mrba_m.mrbaownid,g_mrba_m.mrbaowndp,g_mrba_m.mrbacrtid,g_mrba_m.mrbacrtdp, 
       g_mrba_m.mrbacrtdt,g_mrba_m.mrbamodid,g_mrba_m.mrbamoddt,g_mrba_m.mrbacnfid,g_mrba_m.mrbacnfdt, 
       g_mrba_m.mrba010_desc,g_mrba_m.mrba011_desc,g_mrba_m.mrba020_desc,g_mrba_m.mrba012_desc,g_mrba_m.mrba013_desc, 
       g_mrba_m.mrba014_desc,g_mrba_m.mrba016_desc,g_mrba_m.mrba017_desc,g_mrba_m.mrba018_desc,g_mrba_m.mrba021_desc, 
       g_mrba_m.mrba022_desc,g_mrba_m.mrba027_desc,g_mrba_m.mrba103_desc,g_mrba_m.mrba040_desc,g_mrba_m.mrbaownid_desc, 
       g_mrba_m.mrbaowndp_desc,g_mrba_m.mrbacrtid_desc,g_mrba_m.mrbacrtdp_desc,g_mrba_m.mrbamodid_desc, 
       g_mrba_m.mrbacnfid_desc
   
   #遮罩相關處理
   LET g_mrba_m_mask_o.* =  g_mrba_m.*
   CALL amrm200_mrba_t_mask()
   LET g_mrba_m_mask_n.* =  g_mrba_m.*
   
   #根據資料狀態切換action狀態
   CALL cl_set_act_visible("statechange,modify,modify_detail,delete,reproduce", TRUE)
   CALL amrm200_set_act_visible()   
   CALL amrm200_set_act_no_visible()
   
   #add-point:fetch段action控制 name="fetch.action_control"
   
   #end add-point  
   
   
   
   #add-point:fetch結束前 name="fetch.after"
   
   #end add-point
   
   #保存單頭舊值
   LET g_mrba_m_t.* = g_mrba_m.*
   LET g_mrba_m_o.* = g_mrba_m.*
   
   LET g_data_owner = g_mrba_m.mrbaownid      
   LET g_data_dept  = g_mrba_m.mrbaowndp
   
   #重新顯示   
   CALL amrm200_show()
 
   
 
END FUNCTION
 
{</section>}
 
{<section id="amrm200.insert" >}
#+ 資料新增
PRIVATE FUNCTION amrm200_insert()
   #add-point:insert段define(客製用) name="insert.define_customerization"
   
   #end add-point    
   #add-point:insert段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="insert.define"
   
   #end add-point    
   
   #add-point:Function前置處理  name="insert.pre_function"
   
   #end add-point
   
   #清畫面欄位內容
   CLEAR FORM                    
   CALL g_mrbb_d.clear()   
   CALL g_mrbb2_d.clear()  
   CALL g_mrbb3_d.clear()  
   CALL g_mrbb4_d.clear()  
   CALL g_mrbb5_d.clear()  
   CALL g_mrbb6_d.clear()  
 
 
   INITIALIZE g_mrba_m.* TO NULL             #DEFAULT 設定
   
   LET g_mrba001_t = NULL
 
   
   LET g_master_insert = FALSE
   
   #add-point:insert段before name="insert.before"
   
   #end add-point    
   
   CALL s_transaction_begin()
   WHILE TRUE
      #公用欄位給值(單頭)
      #應用 a14 樣板自動產生(Version:5)    
      #公用欄位新增給值  
      LET g_mrba_m.mrbaownid = g_user
      LET g_mrba_m.mrbaowndp = g_dept
      LET g_mrba_m.mrbacrtid = g_user
      LET g_mrba_m.mrbacrtdp = g_dept 
      LET g_mrba_m.mrbacrtdt = cl_get_current()
      LET g_mrba_m.mrbamodid = g_user
      LET g_mrba_m.mrbamoddt = cl_get_current()
      LET g_mrba_m.mrbastus = 'N'
 
 
 
 
      #append欄位給值
      
     
      #一般欄位給值
            LET g_mrba_m.mrba019 = "0"
      LET g_mrba_m.mrba000 = "0"
      LET g_mrba_m.mrba006 = "1"
      LET g_mrba_m.mrba104 = "0"
      LET g_mrba_m.mrba100 = "0"
      LET g_mrba_m.mrbastus = "N"
      LET g_mrba_m.mrba031 = "1"
      LET g_mrba_m.mrba036 = "1"
      LET g_mrba_m.mrba039 = "3"
      LET g_mrba_m.mrba042 = "1"
 
  
      #add-point:單頭預設值 name="insert.default"
      CALL amrm200_mrba020_default()
      LET g_mrba_m.mrba032 = g_today
      LET g_mrba_m.mrba033 = g_today
      LET g_mrba_m.mrba034 = g_today
      LET g_mrba_m_t.* = g_mrba_m.*
      #end add-point 
      
      #保存單頭舊值(用於資料輸入錯誤還原預設值時使用)
      LET g_mrba_m_t.* = g_mrba_m.*
      LET g_mrba_m_o.* = g_mrba_m.*
      
      #顯示狀態(stus)圖片
            #應用 a21 樣板自動產生(Version:3)
	  #根據當下狀態碼顯示圖片
      CASE g_mrba_m.mrbastus 
         WHEN "N"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/open.png")
         WHEN "Y"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/valid.png")
         WHEN "X"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/void.png")
         
      END CASE
 
 
 
    
      CALL amrm200_input("a")
      
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
         INITIALIZE g_mrba_m.* TO NULL
         INITIALIZE g_mrbb_d TO NULL
         INITIALIZE g_mrbb2_d TO NULL
         INITIALIZE g_mrbb3_d TO NULL
         INITIALIZE g_mrbb4_d TO NULL
         INITIALIZE g_mrbb5_d TO NULL
         INITIALIZE g_mrbb6_d TO NULL
 
         #add-point:取消新增後 name="insert.cancel"
         
         #end add-point 
         CALL amrm200_show()
         RETURN
      END IF
      
      LET INT_FLAG = 0
      #CALL g_mrbb_d.clear()
      #CALL g_mrbb2_d.clear()
      #CALL g_mrbb3_d.clear()
      #CALL g_mrbb4_d.clear()
      #CALL g_mrbb5_d.clear()
      #CALL g_mrbb6_d.clear()
 
 
      LET g_rec_b = 0
      CALL s_transaction_end('Y','0')
      EXIT WHILE
        
   END WHILE
   
   #根據資料狀態切換action狀態
   CALL cl_set_act_visible("statechange,modify,modify_detail,delete,reproduce", TRUE)
   CALL amrm200_set_act_visible()   
   CALL amrm200_set_act_no_visible()
   
   #將新增的資料併入搜尋條件中
   LET g_mrba001_t = g_mrba_m.mrba001
 
   
   #組合新增資料的條件
   LET g_add_browse = " mrbaent = " ||g_enterprise|| " AND mrbasite = '" ||g_site|| "' AND",
                      " mrba001 = '", g_mrba_m.mrba001, "' "
 
                      
   #add-point:組合新增資料的條件後 name="insert.after.add_browse"
   
   #end add-point
      
   #填到最後面
   LET g_current_idx = g_browser.getLength() + 1
   CALL amrm200_browser_fill("")
   
   DISPLAY g_browser_cnt TO FORMONLY.h_count    #總筆數
   DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
   CALL cl_navigator_setting(g_current_idx, g_browser_cnt)
   
   CLOSE amrm200_cl
   
   CALL amrm200_idx_chk()
   
   #撈取異動後的資料(主要是帶出reference)
   EXECUTE amrm200_master_referesh USING g_site,g_mrba_m.mrba001 INTO g_mrba_m.mrba019,g_mrba_m.mrba000, 
       g_mrba_m.mrba001,g_mrba_m.mrba002,g_mrba_m.mrba003,g_mrba_m.mrba066,g_mrba_m.mrba004,g_mrba_m.mrba005, 
       g_mrba_m.mrba007,g_mrba_m.mrba008,g_mrba_m.mrba009,g_mrba_m.mrba010,g_mrba_m.mrba011,g_mrba_m.mrba020, 
       g_mrba_m.mrba006,g_mrba_m.mrba104,g_mrba_m.mrba012,g_mrba_m.mrba013,g_mrba_m.mrba014,g_mrba_m.mrba015, 
       g_mrba_m.mrba016,g_mrba_m.mrba017,g_mrba_m.mrba018,g_mrba_m.mrba102,g_mrba_m.mrba100,g_mrba_m.mrba101, 
       g_mrba_m.mrbastus,g_mrba_m.mrba021,g_mrba_m.mrba022,g_mrba_m.mrba025,g_mrba_m.mrba026,g_mrba_m.mrba027, 
       g_mrba_m.mrba103,g_mrba_m.mrba029,g_mrba_m.mrba031,g_mrba_m.mrba032,g_mrba_m.mrba033,g_mrba_m.mrba034, 
       g_mrba_m.mrba035,g_mrba_m.mrba036,g_mrba_m.mrba038,g_mrba_m.mrba039,g_mrba_m.mrba040,g_mrba_m.mrba041, 
       g_mrba_m.mrba042,g_mrba_m.mrbaownid,g_mrba_m.mrbaowndp,g_mrba_m.mrbacrtid,g_mrba_m.mrbacrtdp, 
       g_mrba_m.mrbacrtdt,g_mrba_m.mrbamodid,g_mrba_m.mrbamoddt,g_mrba_m.mrbacnfid,g_mrba_m.mrbacnfdt, 
       g_mrba_m.mrba010_desc,g_mrba_m.mrba011_desc,g_mrba_m.mrba020_desc,g_mrba_m.mrba012_desc,g_mrba_m.mrba013_desc, 
       g_mrba_m.mrba014_desc,g_mrba_m.mrba016_desc,g_mrba_m.mrba017_desc,g_mrba_m.mrba018_desc,g_mrba_m.mrba021_desc, 
       g_mrba_m.mrba022_desc,g_mrba_m.mrba027_desc,g_mrba_m.mrba103_desc,g_mrba_m.mrba040_desc,g_mrba_m.mrbaownid_desc, 
       g_mrba_m.mrbaowndp_desc,g_mrba_m.mrbacrtid_desc,g_mrba_m.mrbacrtdp_desc,g_mrba_m.mrbamodid_desc, 
       g_mrba_m.mrbacnfid_desc
   
   
   #遮罩相關處理
   LET g_mrba_m_mask_o.* =  g_mrba_m.*
   CALL amrm200_mrba_t_mask()
   LET g_mrba_m_mask_n.* =  g_mrba_m.*
   
   #將資料顯示到畫面上
   DISPLAY BY NAME g_mrba_m.mrba019,g_mrba_m.mrba000,g_mrba_m.mrba001,g_mrba_m.mrba002,g_mrba_m.mrba003, 
       g_mrba_m.mrba066,g_mrba_m.mrba004,g_mrba_m.mrba005,g_mrba_m.mrba007,g_mrba_m.mrba008,g_mrba_m.mrba009, 
       g_mrba_m.mrba010,g_mrba_m.mrba010_desc,g_mrba_m.mrba011,g_mrba_m.mrba011_desc,g_mrba_m.mrba020, 
       g_mrba_m.mrba020_desc,g_mrba_m.mrba006,g_mrba_m.mrba104,g_mrba_m.mrba012,g_mrba_m.mrba012_desc, 
       g_mrba_m.mrba013,g_mrba_m.mrba013_desc,g_mrba_m.mrba014,g_mrba_m.mrba014_desc,g_mrba_m.mrba015, 
       g_mrba_m.mrba016,g_mrba_m.mrba016_desc,g_mrba_m.mrba017,g_mrba_m.mrba017_desc,g_mrba_m.mrba018, 
       g_mrba_m.mrba018_desc,g_mrba_m.mrba102,g_mrba_m.mrba100,g_mrba_m.mrba101,g_mrba_m.mrbastus,g_mrba_m.mrba021, 
       g_mrba_m.mrba021_desc,g_mrba_m.mrba022,g_mrba_m.mrba022_desc,g_mrba_m.mrba025,g_mrba_m.mrba026, 
       g_mrba_m.mrba027,g_mrba_m.mrba027_desc,g_mrba_m.mrba103,g_mrba_m.mrba103_desc,g_mrba_m.mrba029, 
       g_mrba_m.mrba031,g_mrba_m.mrba032,g_mrba_m.mrba033,g_mrba_m.mrba034,g_mrba_m.mrba035,g_mrba_m.mrba036, 
       g_mrba_m.mrba038,g_mrba_m.mrba039,g_mrba_m.mrba040,g_mrba_m.mrba040_desc,g_mrba_m.mrba041,g_mrba_m.mrba042, 
       g_mrba_m.mrbaownid,g_mrba_m.mrbaownid_desc,g_mrba_m.mrbaowndp,g_mrba_m.mrbaowndp_desc,g_mrba_m.mrbacrtid, 
       g_mrba_m.mrbacrtid_desc,g_mrba_m.mrbacrtdp,g_mrba_m.mrbacrtdp_desc,g_mrba_m.mrbacrtdt,g_mrba_m.mrbamodid, 
       g_mrba_m.mrbamodid_desc,g_mrba_m.mrbamoddt,g_mrba_m.mrbacnfid,g_mrba_m.mrbacnfid_desc,g_mrba_m.mrbacnfdt 
 
   
   #add-point:新增結束後 name="insert.after"
   CALL amrm200_fetch("") #150615-00004#1-add
   #end add-point 
   
   LET g_data_owner = g_mrba_m.mrbaownid      
   LET g_data_dept  = g_mrba_m.mrbaowndp
   
   #功能已完成,通報訊息中心
   CALL amrm200_msgcentre_notify('insert')
   
END FUNCTION
 
{</section>}
 
{<section id="amrm200.modify" >}
#+ 資料修改
PRIVATE FUNCTION amrm200_modify()
   #add-point:modify段define(客製用) name="modify.define_customerization"
   
   #end add-point    
   DEFINE l_new_key    DYNAMIC ARRAY OF STRING
   DEFINE l_old_key    DYNAMIC ARRAY OF STRING
   DEFINE l_field_key  DYNAMIC ARRAY OF STRING
   DEFINE l_wc2_table1          STRING
   DEFINE l_wc2_table2   STRING
 
   DEFINE l_wc2_table3   STRING
 
   DEFINE l_wc2_table4   STRING
 
   DEFINE l_wc2_table5   STRING
 
   DEFINE l_wc2_table6   STRING
 
 
 
   #add-point:modify段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="modify.define"
   
   #end add-point    
   
   #add-point:Function前置處理  name="modify.pre_function"
   
   #end add-point
   
   #保存單頭舊值
   LET g_mrba_m_t.* = g_mrba_m.*
   LET g_mrba_m_o.* = g_mrba_m.*
   
   IF g_mrba_m.mrba001 IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code = "std-00003" 
      LET g_errparam.popup = FALSE 
      CALL cl_err()
      RETURN
   END IF
 
   ERROR ""
  
   LET g_mrba001_t = g_mrba_m.mrba001
 
   CALL s_transaction_begin()
   
   OPEN amrm200_cl USING g_enterprise, g_site,g_mrba_m.mrba001
   IF SQLCA.SQLCODE THEN   #(ver:78)
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "OPEN amrm200_cl:",SQLERRMESSAGE 
      LET g_errparam.code = SQLCA.SQLCODE   #(ver:78)
      LET g_errparam.popup = TRUE 
      CLOSE amrm200_cl
      CALL s_transaction_end('N','0')
      CALL cl_err()
      RETURN
   END IF
 
   #顯示最新的資料
   EXECUTE amrm200_master_referesh USING g_site,g_mrba_m.mrba001 INTO g_mrba_m.mrba019,g_mrba_m.mrba000, 
       g_mrba_m.mrba001,g_mrba_m.mrba002,g_mrba_m.mrba003,g_mrba_m.mrba066,g_mrba_m.mrba004,g_mrba_m.mrba005, 
       g_mrba_m.mrba007,g_mrba_m.mrba008,g_mrba_m.mrba009,g_mrba_m.mrba010,g_mrba_m.mrba011,g_mrba_m.mrba020, 
       g_mrba_m.mrba006,g_mrba_m.mrba104,g_mrba_m.mrba012,g_mrba_m.mrba013,g_mrba_m.mrba014,g_mrba_m.mrba015, 
       g_mrba_m.mrba016,g_mrba_m.mrba017,g_mrba_m.mrba018,g_mrba_m.mrba102,g_mrba_m.mrba100,g_mrba_m.mrba101, 
       g_mrba_m.mrbastus,g_mrba_m.mrba021,g_mrba_m.mrba022,g_mrba_m.mrba025,g_mrba_m.mrba026,g_mrba_m.mrba027, 
       g_mrba_m.mrba103,g_mrba_m.mrba029,g_mrba_m.mrba031,g_mrba_m.mrba032,g_mrba_m.mrba033,g_mrba_m.mrba034, 
       g_mrba_m.mrba035,g_mrba_m.mrba036,g_mrba_m.mrba038,g_mrba_m.mrba039,g_mrba_m.mrba040,g_mrba_m.mrba041, 
       g_mrba_m.mrba042,g_mrba_m.mrbaownid,g_mrba_m.mrbaowndp,g_mrba_m.mrbacrtid,g_mrba_m.mrbacrtdp, 
       g_mrba_m.mrbacrtdt,g_mrba_m.mrbamodid,g_mrba_m.mrbamoddt,g_mrba_m.mrbacnfid,g_mrba_m.mrbacnfdt, 
       g_mrba_m.mrba010_desc,g_mrba_m.mrba011_desc,g_mrba_m.mrba020_desc,g_mrba_m.mrba012_desc,g_mrba_m.mrba013_desc, 
       g_mrba_m.mrba014_desc,g_mrba_m.mrba016_desc,g_mrba_m.mrba017_desc,g_mrba_m.mrba018_desc,g_mrba_m.mrba021_desc, 
       g_mrba_m.mrba022_desc,g_mrba_m.mrba027_desc,g_mrba_m.mrba103_desc,g_mrba_m.mrba040_desc,g_mrba_m.mrbaownid_desc, 
       g_mrba_m.mrbaowndp_desc,g_mrba_m.mrbacrtid_desc,g_mrba_m.mrbacrtdp_desc,g_mrba_m.mrbamodid_desc, 
       g_mrba_m.mrbacnfid_desc
   
   #檢查是否允許此動作
   IF NOT amrm200_action_chk() THEN
      CALL s_transaction_end('N','0')
      RETURN
   END IF
   
   #遮罩相關處理
   LET g_mrba_m_mask_o.* =  g_mrba_m.*
   CALL amrm200_mrba_t_mask()
   LET g_mrba_m_mask_n.* =  g_mrba_m.*
   
   
   
   #add-point:modify段show之前 name="modify.before_show"
   
   #end add-point  
   
   #LET l_wc2_table1 = g_wc2_table1
   #LET g_wc2_table1 = " 1=1"
   #LET l_wc2_table2 = g_wc2_table2
   #LET l_wc2_table2 = " 1=1"
 
   #LET l_wc2_table3 = g_wc2_table3
   #LET l_wc2_table3 = " 1=1"
 
   #LET l_wc2_table4 = g_wc2_table4
   #LET l_wc2_table4 = " 1=1"
 
   #LET l_wc2_table5 = g_wc2_table5
   #LET l_wc2_table5 = " 1=1"
 
   #LET l_wc2_table6 = g_wc2_table6
   #LET l_wc2_table6 = " 1=1"
 
 
 
   
   CALL amrm200_show()
   #add-point:modify段show之後 name="modify.after_show"
   
   #end add-point
   
   #LET g_wc2_table1 = l_wc2_table1
   #LET  g_wc2_table2 = l_wc2_table2 
 
   #LET  g_wc2_table3 = l_wc2_table3 
 
   #LET  g_wc2_table4 = l_wc2_table4 
 
   #LET  g_wc2_table5 = l_wc2_table5 
 
   #LET  g_wc2_table6 = l_wc2_table6 
 
 
 
    
   WHILE TRUE
      LET g_mrba001_t = g_mrba_m.mrba001
 
      
      #寫入修改者/修改日期資訊(單頭)
      LET g_mrba_m.mrbamodid = g_user 
LET g_mrba_m.mrbamoddt = cl_get_current()
LET g_mrba_m.mrbamodid_desc = cl_get_username(g_mrba_m.mrbamodid)
      
      #add-point:modify段修改前 name="modify.before_input"
      
      #end add-point
      
      #欄位更改
      LET g_loc = 'n'
      LET g_update = FALSE
      LET g_master_commit = "N"
      CALL amrm200_input("u")
      LET g_loc = 'n'
 
      #add-point:modify段修改後 name="modify.after_input"
      
      #end add-point
      
      IF g_update OR NOT INT_FLAG THEN
         #若有modid跟moddt則進行update
         UPDATE mrba_t SET (mrbamodid,mrbamoddt) = (g_mrba_m.mrbamodid,g_mrba_m.mrbamoddt)
          WHERE mrbaent = g_enterprise AND mrbasite = g_site AND mrba001 = g_mrba001_t
 
      END IF
    
      IF INT_FLAG THEN
         CALL s_transaction_end('N','0')
         LET INT_FLAG = 0
         #若單頭無commit則還原
         IF g_master_commit = "N" THEN
            LET g_mrba_m.* = g_mrba_m_t.*
            CALL amrm200_show()
         END IF
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = '' 
         LET g_errparam.code = 9001 
         LET g_errparam.popup = FALSE 
         CALL cl_err()
         RETURN
      END IF 
                  
      #若單頭key欄位有變更
      IF g_mrba_m.mrba001 != g_mrba_m_t.mrba001
 
      THEN
         CALL s_transaction_begin()
         
         #add-point:單身fk修改前 name="modify.body.b_fk_update"
         
         #end add-point
         
         #更新單身key值
         UPDATE mrbb_t SET mrbb001 = g_mrba_m.mrba001
 
          WHERE mrbbent = g_enterprise AND mrbbsite = g_site AND mrbb001 = g_mrba_m_t.mrba001
 
            
         #add-point:單身fk修改中 name="modify.body.m_fk_update"
         
         #end add-point
 
         CASE
            WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
            #   INITIALIZE g_errparam TO NULL 
            #   LET g_errparam.extend = "mrbb_t" 
            #   LET g_errparam.code = "std-00009" 
            #   LET g_errparam.popup = TRUE 
            #   CALL cl_err()
            #   CALL s_transaction_end('N','0')
            #   CONTINUE WHILE
            WHEN SQLCA.SQLCODE #其他錯誤
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "mrbb_t:",SQLERRMESSAGE 
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
         
         UPDATE mrbc_t
            SET mrbc001 = g_mrba_m.mrba001
 
          WHERE mrbcent = g_enterprise AND mrbcsite = g_site AND
                mrbc001 = g_mrba001_t
 
         #add-point:單身fk修改中 name="modify.body.m_fk_update2"
         
         #end add-point
         CASE
            WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
            #   INITIALIZE g_errparam TO NULL 
            #   LET g_errparam.extend = "mrbc_t" 
            #   LET g_errparam.code = "std-00009" 
            #   LET g_errparam.popup = TRUE 
            #   CALL cl_err()
            #   CALL s_transaction_end('N','0')
            #   CONTINUE WHILE
            WHEN SQLCA.SQLCODE #其他錯誤
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "mrbc_t:",SQLERRMESSAGE 
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
         
         UPDATE mrbd_t
            SET mrbd001 = g_mrba_m.mrba001
 
          WHERE mrbdent = g_enterprise AND mrbdsite = g_site AND
                mrbd001 = g_mrba001_t
 
         #add-point:單身fk修改中 name="modify.body.m_fk_update3"
         
         #end add-point
         CASE
            WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
            #   INITIALIZE g_errparam TO NULL 
            #   LET g_errparam.extend = "mrbd_t" 
            #   LET g_errparam.code = "std-00009" 
            #   LET g_errparam.popup = TRUE 
            #   CALL cl_err()
            #   CALL s_transaction_end('N','0')
            #   CONTINUE WHILE
            WHEN SQLCA.SQLCODE #其他錯誤
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "mrbd_t:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE 
               LET g_errparam.popup = TRUE 
               CALL s_transaction_end('N','0')
               CALL cl_err()
               CONTINUE WHILE
         END CASE
         #add-point:單身fk修改後 name="modify.body.a_fk_update3"
         
         #end add-point
 
         #更新單身key值
         #add-point:單身fk修改前 name="modify.body.b_fk_update4"
         
         #end add-point
         
         UPDATE mrbe_t
            SET mrbe001 = g_mrba_m.mrba001
 
          WHERE mrbeent = g_enterprise AND mrbesite = g_site AND
                mrbe001 = g_mrba001_t
 
         #add-point:單身fk修改中 name="modify.body.m_fk_update4"
         
         #end add-point
         CASE
            WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
            #   INITIALIZE g_errparam TO NULL 
            #   LET g_errparam.extend = "mrbe_t" 
            #   LET g_errparam.code = "std-00009" 
            #   LET g_errparam.popup = TRUE 
            #   CALL cl_err()
            #   CALL s_transaction_end('N','0')
            #   CONTINUE WHILE
            WHEN SQLCA.SQLCODE #其他錯誤
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "mrbe_t:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE 
               LET g_errparam.popup = TRUE 
               CALL s_transaction_end('N','0')
               CALL cl_err()
               CONTINUE WHILE
         END CASE
         #add-point:單身fk修改後 name="modify.body.a_fk_update4"
         
         #end add-point
 
         #更新單身key值
         #add-point:單身fk修改前 name="modify.body.b_fk_update5"
         
         #end add-point
         
         UPDATE mrbf_t
            SET mrbf001 = g_mrba_m.mrba001
 
          WHERE mrbfent = g_enterprise AND mrbfsite = g_site AND
                mrbf001 = g_mrba001_t
 
         #add-point:單身fk修改中 name="modify.body.m_fk_update5"
         
         #end add-point
         CASE
            WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
            #   INITIALIZE g_errparam TO NULL 
            #   LET g_errparam.extend = "mrbf_t" 
            #   LET g_errparam.code = "std-00009" 
            #   LET g_errparam.popup = TRUE 
            #   CALL cl_err()
            #   CALL s_transaction_end('N','0')
            #   CONTINUE WHILE
            WHEN SQLCA.SQLCODE #其他錯誤
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "mrbf_t:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE 
               LET g_errparam.popup = TRUE 
               CALL s_transaction_end('N','0')
               CALL cl_err()
               CONTINUE WHILE
         END CASE
         #add-point:單身fk修改後 name="modify.body.a_fk_update5"
         
         #end add-point
 
         #更新單身key值
         #add-point:單身fk修改前 name="modify.body.b_fk_update6"
         
         #end add-point
         
         UPDATE mrbg_t
            SET mrbg001 = g_mrba_m.mrba001
 
          WHERE mrbgent = g_enterprise AND mrbgsite = g_site AND
                mrbg001 = g_mrba001_t
 
         #add-point:單身fk修改中 name="modify.body.m_fk_update6"
         
         #end add-point
         CASE
            WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
            #   INITIALIZE g_errparam TO NULL 
            #   LET g_errparam.extend = "mrbg_t" 
            #   LET g_errparam.code = "std-00009" 
            #   LET g_errparam.popup = TRUE 
            #   CALL cl_err()
            #   CALL s_transaction_end('N','0')
            #   CONTINUE WHILE
            WHEN SQLCA.SQLCODE #其他錯誤
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "mrbg_t:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE 
               LET g_errparam.popup = TRUE 
               CALL s_transaction_end('N','0')
               CALL cl_err()
               CONTINUE WHILE
         END CASE
         #add-point:單身fk修改後 name="modify.body.a_fk_update6"
         
         #end add-point
 
 
         
 
         
         #UPDATE 多語言table key值
         
         
         
         
         
         
 
         CALL s_transaction_end('Y','0')
      END IF
    
      EXIT WHILE
   END WHILE
 
   #根據資料狀態切換action狀態
   CALL cl_set_act_visible("statechange,modify,modify_detail,delete,reproduce", TRUE)
   CALL amrm200_set_act_visible()   
   CALL amrm200_set_act_no_visible()
 
   #組合新增資料的條件
   LET g_add_browse = " mrbaent = " ||g_enterprise|| " AND mrbasite = '" ||g_site|| "' AND",
                      " mrba001 = '", g_mrba_m.mrba001, "' "
 
   #填到對應位置
   CALL amrm200_browser_fill("")
 
   CLOSE amrm200_cl
   
   CALL s_transaction_end('Y','0')
 
   #功能已完成,通報訊息中心
   CALL amrm200_msgcentre_notify('modify')
 
END FUNCTION 
 
{</section>}
 
{<section id="amrm200.input" >}
#+ 資料輸入
PRIVATE FUNCTION amrm200_input(p_cmd)
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
   DEFINE  l_imaa006             LIKE imaa_t.imaa006
   DEFINE  l_success             LIKE type_t.num5
   DEFINE  l_rate                LIKE inaj_t.inaj014
   #mark--160524-00044#1 By shiun--(S)
#   DEFINE l_mrba028         STRING
#   DEFINE l_mrba028_1       LIKE type_t.num5
#   DEFINE l_mrba028_2       LIKE type_t.num5
#   DEFINE l_mrba028_3       LIKE type_t.chr10
#   DEFINE l_mrba028_4       LIKE type_t.chr10
   #mark--160524-00044#1 By shiun--(E)
   DEFINE l_hour_top        LIKE type_t.num5
   DEFINE l_minute_top      LIKE type_t.num5
   DEFINE l_mrba000         LIKE mrba_t.mrba000 #151215-00002#3
   DEFINE l_oocq019         LIKE oocq_t.oocq019 #要紀錄群組編號的類型 #151215-00002#3
   
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
   DISPLAY BY NAME g_mrba_m.mrba019,g_mrba_m.mrba000,g_mrba_m.mrba001,g_mrba_m.mrba002,g_mrba_m.mrba003, 
       g_mrba_m.mrba066,g_mrba_m.mrba004,g_mrba_m.mrba005,g_mrba_m.mrba007,g_mrba_m.mrba008,g_mrba_m.mrba009, 
       g_mrba_m.mrba010,g_mrba_m.mrba010_desc,g_mrba_m.mrba011,g_mrba_m.mrba011_desc,g_mrba_m.mrba020, 
       g_mrba_m.mrba020_desc,g_mrba_m.mrba006,g_mrba_m.mrba104,g_mrba_m.mrba012,g_mrba_m.mrba012_desc, 
       g_mrba_m.mrba013,g_mrba_m.mrba013_desc,g_mrba_m.mrba014,g_mrba_m.mrba014_desc,g_mrba_m.mrba015, 
       g_mrba_m.mrba016,g_mrba_m.mrba016_desc,g_mrba_m.mrba017,g_mrba_m.mrba017_desc,g_mrba_m.mrba018, 
       g_mrba_m.mrba018_desc,g_mrba_m.mrba102,g_mrba_m.mrba100,g_mrba_m.mrba101,g_mrba_m.mrbastus,g_mrba_m.mrba021, 
       g_mrba_m.mrba021_desc,g_mrba_m.mrba022,g_mrba_m.mrba022_desc,g_mrba_m.mrba025,g_mrba_m.mrba026, 
       g_mrba_m.mrba027,g_mrba_m.mrba027_desc,g_mrba_m.mrba103,g_mrba_m.mrba103_desc,g_mrba_m.mrba029, 
       g_mrba_m.mrba031,g_mrba_m.mrba032,g_mrba_m.mrba033,g_mrba_m.mrba034,g_mrba_m.mrba035,g_mrba_m.mrba036, 
       g_mrba_m.mrba038,g_mrba_m.mrba039,g_mrba_m.mrba040,g_mrba_m.mrba040_desc,g_mrba_m.mrba041,g_mrba_m.mrba042, 
       g_mrba_m.mrbaownid,g_mrba_m.mrbaownid_desc,g_mrba_m.mrbaowndp,g_mrba_m.mrbaowndp_desc,g_mrba_m.mrbacrtid, 
       g_mrba_m.mrbacrtid_desc,g_mrba_m.mrbacrtdp,g_mrba_m.mrbacrtdp_desc,g_mrba_m.mrbacrtdt,g_mrba_m.mrbamodid, 
       g_mrba_m.mrbamodid_desc,g_mrba_m.mrbamoddt,g_mrba_m.mrbacnfid,g_mrba_m.mrbacnfid_desc,g_mrba_m.mrbacnfdt 
 
   
   #切換畫面
   IF g_main_hidden THEN
      CALL gfrm_curr.setElementHidden("mainlayout",0)
      CALL gfrm_curr.setElementHidden("worksheet",1)
      LET g_main_hidden = 0
   END IF
 
   CALL cl_set_head_visible("","YES")  
 
   LET l_insert = FALSE
   LET g_action_choice = ""
 
   #add-point:input段define_sql name="input.define_sql"
   
   #end add-point 
   LET g_forupd_sql = "SELECT mrbbstus,mrbb002,mrbb003,mrbb004,mrbb005,mrbb006,mrbb007,mrbb008,mrbb009, 
       mrbb010,mrbb011,mrbb012,mrbb013 FROM mrbb_t WHERE mrbbent=? AND mrbbsite=? AND mrbb001=? AND  
       mrbb002=? FOR UPDATE"
   #add-point:input段define_sql name="input.after_define_sql"
   
   #end add-point 
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE amrm200_bcl CURSOR FROM g_forupd_sql
   
   #add-point:input段define_sql name="input.define_sql2"
   
   #end add-point    
   LET g_forupd_sql = "SELECT mrbc002,mrbc003,mrbc004,mrbc005,mrbc006,mrbc007,mrbc008,mrbc009,mrbc010, 
       mrbc011 FROM mrbc_t WHERE mrbcent=? AND mrbcsite=? AND mrbc001=? AND mrbc002=? FOR UPDATE"
   #add-point:input段define_sql name="input.after_define_sql2"
   
   #end add-point
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE amrm200_bcl2 CURSOR FROM g_forupd_sql
 
   #add-point:input段define_sql name="input.define_sql3"
   
   #end add-point    
   LET g_forupd_sql = "SELECT mrbd002,mrbd003,mrbd004,mrbd005,mrbd006,mrbd007,mrbd008,mrbd009,mrbd010  
       FROM mrbd_t WHERE mrbdent=? AND mrbdsite=? AND mrbd001=? AND mrbd002=? FOR UPDATE"
   #add-point:input段define_sql name="input.after_define_sql3"
   
   #end add-point
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE amrm200_bcl3 CURSOR FROM g_forupd_sql
 
   #add-point:input段define_sql name="input.define_sql4"
   
   #end add-point    
   LET g_forupd_sql = "SELECT mrbe002 FROM mrbe_t WHERE mrbeent=? AND mrbesite=? AND mrbe001=? AND mrbe002=?  
       FOR UPDATE"
   #add-point:input段define_sql name="input.after_define_sql4"
   
   #end add-point
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE amrm200_bcl4 CURSOR FROM g_forupd_sql
 
   #add-point:input段define_sql name="input.define_sql5"
   
   #end add-point    
   LET g_forupd_sql = "SELECT mrbf002 FROM mrbf_t WHERE mrbfent=? AND mrbfsite=? AND mrbf001=? AND mrbf002=?  
       FOR UPDATE"
   #add-point:input段define_sql name="input.after_define_sql5"
   
   #end add-point
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE amrm200_bcl5 CURSOR FROM g_forupd_sql
 
   #add-point:input段define_sql name="input.define_sql6"
   
   #end add-point    
   LET g_forupd_sql = "SELECT mrbg002,mrbg003,mrbg004,mrbg005,mrbg006,mrbg007,mrbg008 FROM mrbg_t WHERE  
       mrbgent=? AND mrbgsite=? AND mrbg001=? AND mrbg002=? FOR UPDATE"
   #add-point:input段define_sql name="input.after_define_sql6"
   
   #end add-point
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE amrm200_bcl6 CURSOR FROM g_forupd_sql
 
 
   
 
 
   #add-point:input段define_sql name="input.other_sql"
   
   #end add-point 
 
   LET l_allow_insert = cl_auth_detail_input("insert")
   LET l_allow_delete = cl_auth_detail_input("delete")
   LET g_qryparam.state = 'i'
   
   #控制key欄位可否輸入
   CALL amrm200_set_entry(p_cmd)
   #add-point:set_entry後 name="input.after_set_entry"
   
   #end add-point
   CALL amrm200_set_no_entry(p_cmd)
 
   DISPLAY BY NAME g_mrba_m.mrba019,g_mrba_m.mrba000,g_mrba_m.mrba001,g_mrba_m.mrba002,g_mrba_m.mrba003, 
       g_mrba_m.mrba066,g_mrba_m.mrba004,g_mrba_m.mrba005,g_mrba_m.mrba007,g_mrba_m.mrba008,g_mrba_m.mrba009, 
       g_mrba_m.mrba010,g_mrba_m.mrba011,g_mrba_m.mrba020,g_mrba_m.mrba006,g_mrba_m.mrba012,g_mrba_m.mrba013, 
       g_mrba_m.mrba014,g_mrba_m.mrba015,g_mrba_m.mrba016,g_mrba_m.mrba017,g_mrba_m.mrba018,g_mrba_m.mrba102, 
       g_mrba_m.mrba100,g_mrba_m.mrba101,g_mrba_m.mrbastus,g_mrba_m.mrba021,g_mrba_m.mrba022,g_mrba_m.mrba025, 
       g_mrba_m.mrba026,g_mrba_m.mrba027,g_mrba_m.mrba103,g_mrba_m.mrba029,g_mrba_m.mrba031,g_mrba_m.mrba032, 
       g_mrba_m.mrba033,g_mrba_m.mrba034,g_mrba_m.mrba035,g_mrba_m.mrba036,g_mrba_m.mrba038,g_mrba_m.mrba039, 
       g_mrba_m.mrba040,g_mrba_m.mrba041,g_mrba_m.mrba042
   
   LET lb_reproduce = FALSE
   LET l_ac_t = 1
   
   #關閉被遮罩相關欄位輸入, 無法確定USER是否會需要輸入此欄位
   #因此先行關閉, 若有需要可於下方add-point中自行開啟
   CALL cl_mask_set_no_entry()
   
   #add-point:資料輸入前 name="input.before_input"
   CALL amrm200_mrba040_required()
   LET g_errshow = 1
   #end add-point
   
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
 
{</section>}
 
{<section id="amrm200.input.head" >}
      #單頭段
      INPUT BY NAME g_mrba_m.mrba019,g_mrba_m.mrba000,g_mrba_m.mrba001,g_mrba_m.mrba002,g_mrba_m.mrba003, 
          g_mrba_m.mrba066,g_mrba_m.mrba004,g_mrba_m.mrba005,g_mrba_m.mrba007,g_mrba_m.mrba008,g_mrba_m.mrba009, 
          g_mrba_m.mrba010,g_mrba_m.mrba011,g_mrba_m.mrba020,g_mrba_m.mrba006,g_mrba_m.mrba012,g_mrba_m.mrba013, 
          g_mrba_m.mrba014,g_mrba_m.mrba015,g_mrba_m.mrba016,g_mrba_m.mrba017,g_mrba_m.mrba018,g_mrba_m.mrba102, 
          g_mrba_m.mrba100,g_mrba_m.mrba101,g_mrba_m.mrbastus,g_mrba_m.mrba021,g_mrba_m.mrba022,g_mrba_m.mrba025, 
          g_mrba_m.mrba026,g_mrba_m.mrba027,g_mrba_m.mrba103,g_mrba_m.mrba029,g_mrba_m.mrba031,g_mrba_m.mrba032, 
          g_mrba_m.mrba033,g_mrba_m.mrba034,g_mrba_m.mrba035,g_mrba_m.mrba036,g_mrba_m.mrba038,g_mrba_m.mrba039, 
          g_mrba_m.mrba040,g_mrba_m.mrba041,g_mrba_m.mrba042 
         ATTRIBUTE(WITHOUT DEFAULTS)
         
         #自訂ACTION(master_input)
         
     
         BEFORE INPUT
            IF s_transaction_chk("N",0) THEN
               CALL s_transaction_begin()
            END IF
            OPEN amrm200_cl USING g_enterprise, g_site,g_mrba_m.mrba001
            IF SQLCA.SQLCODE THEN   #(ver:78)
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "OPEN amrm200_cl:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE   #(ver:78)
               LET g_errparam.popup = TRUE 
               CLOSE amrm200_cl
               CALL s_transaction_end('N','0')
               CALL cl_err()
               RETURN
            END IF
            
            IF l_cmd_t = 'r' THEN
               
            END IF
            #因應離開單頭後已寫入資料庫, 若重新回到單頭則視為修改
            #因此需於此處開啟/關閉欄位
            CALL amrm200_set_entry(p_cmd)
            #add-point:資料輸入前 name="input.m.before_input"
            
            #end add-point
            CALL amrm200_set_no_entry(p_cmd)
    
                  #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mrba019
            #add-point:BEFORE FIELD mrba019 name="input.b.mrba019"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mrba019
            
            #add-point:AFTER FIELD mrba019 name="input.a.mrba019"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mrba019
            #add-point:ON CHANGE mrba019 name="input.g.mrba019"
            IF NOT amrm200_mrba020_chk() THEN
               NEXT FIELD CURRENT
            END IF
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mrba000
            #add-point:BEFORE FIELD mrba000 name="input.b.mrba000"
 
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mrba000
            
            #add-point:AFTER FIELD mrba000 name="input.a.mrba000"
            LET g_mrba_m_o.mrba000 = g_mrba_m.mrba000 #151215-00002#3-add
            
            
             #C2017041001guotao---s add 新增修改时，当mrba000='3'时，当前位置mrba018字段 不可为空，为必填字段且数据来源只能是cmri001中oocq039='1'的位置编码  
             IF g_mrba_m.mrba000 ='3' THEN
                CALL cl_set_comp_required("mrba018",TRUE)
             ELSE 
                CALL cl_set_comp_required("mrba018",false)      
             END IF
             #C2017041001guotao---e
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mrba000
            #add-point:ON CHANGE mrba000 name="input.g.mrba000"
            IF g_smfg0036 = '2' THEN   #160801-00023#4
               #151215-00002#3-add----(S)
               #資源編號=0.1       → amri003類型的1(機器)
   			   #資源編號=2.3.4.5.6 → amri003類型的2(工具)
   			   SELECT oocq019 INTO l_oocq019
   			     FROM oocq_t
   			    WHERE oocqent = g_enterprise
   			      AND oocq001 = '1103'
   			      AND oocq002 = g_mrba_m.mrba027
   			   IF g_mrba_m.mrba000 MATCHES '[01]' THEN
   			      LET l_mrba000 = 1
   			   ELSE
   			      LET l_mrba000 = 2
   			   END IF
   			   IF l_mrba000 <> l_oocq019 THEN
   			      IF cl_ask_confirm('amr-00112') THEN #輸入的資料類型與資源群組不符，請問是否清空資源群組？
   			         LET g_mrba_m.mrba027 = ''
   			         DISPLAY BY NAME g_mrba_m.mrba027
   			      ELSE
   			         LET g_mrba_m.mrba000 = g_mrba_m_t.mrba000
   			         DISPLAY BY NAME g_mrba_m.mrba000
   			      END IF
   			   END IF
   			   #151215-00002#3-add----(E)
			   END IF            #160801-00023#4
             #C2017041001guotao---s  新增修改时，当mrba000='3'时，当前位置mrba018字段 不可为空，为必填字段且数据来源只能是cmri001中oocq039='1'的位置编码  
             IF g_mrba_m.mrba000 ='3' THEN
                CALL cl_set_comp_required("mrba018",TRUE)
             ELSE 
                CALL cl_set_comp_required("mrba018",false)      
             END IF
             #C2017041001guotao---e
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mrba001
            #add-point:BEFORE FIELD mrba001 name="input.b.mrba001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mrba001
            
            #add-point:AFTER FIELD mrba001 name="input.a.mrba001"
            #此段落由子樣板a05產生
            IF  NOT cl_null(g_mrba_m.mrba001) THEN 
               IF p_cmd = 'a' OR ( p_cmd = 'u' AND (g_mrba_m.mrba001 != g_mrba001_t )) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM mrba_t WHERE "||"mrbaent = '" ||g_enterprise|| "' AND mrbasite = '" ||g_site|| "' AND "||"mrba001 = '"||g_mrba_m.mrba001 ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF



            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mrba001
            #add-point:ON CHANGE mrba001 name="input.g.mrba001"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mrba002
            
            #add-point:AFTER FIELD mrba002 name="input.a.mrba002"
            IF NOT cl_null(g_mrba_m.mrba002) THEN 
               #應用 a17 樣板自動產生(Version:2)
               #欄位存在檢查
               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
               INITIALIZE g_chkparam.* TO NULL
               #設定g_chkparam.*的參數
               LET g_chkparam.arg1 = g_mrba_m.mrba002                  
               #呼叫檢查存在並帶值的library
               IF cl_chk_exist("v_faah003") THEN
                  #檢查成功時後續處理
                  IF NOT amrm200_faah_chk() THEN
                     NEXT FIELD CURRENT
                  END IF
               ELSE
                  #檢查失敗時後續處理
                  LET g_mrba_m.mrba002 = g_mrba_m_t.mrba002
                  NEXT FIELD CURRENT
               END IF
            END IF
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mrba002
            #add-point:BEFORE FIELD mrba002 name="input.b.mrba002"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mrba002
            #add-point:ON CHANGE mrba002 name="input.g.mrba002"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mrba003
            
            #add-point:AFTER FIELD mrba003 name="input.a.mrba003"
            IF g_mrba_m.mrba003 IS NOT NULL THEN 
               #應用 a17 樣板自動產生(Version:2)
               #欄位存在檢查
               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
               INITIALIZE g_chkparam.* TO NULL
               #設定g_chkparam.*的參數
               LET g_chkparam.arg1 = g_mrba_m.mrba003                  
               #呼叫檢查存在並帶值的library
               IF cl_chk_exist("v_faah004") THEN
                  #檢查成功時後續處理
                  IF NOT amrm200_faah_chk() THEN
                     NEXT FIELD CURRENT
                  END IF
               ELSE
                  #檢查失敗時後續處理
                  LET g_mrba_m.mrba003 = g_mrba_m_t.mrba003
                  NEXT FIELD CURRENT
               END IF
            END IF
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mrba003
            #add-point:BEFORE FIELD mrba003 name="input.b.mrba003"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mrba003
            #add-point:ON CHANGE mrba003 name="input.g.mrba003"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mrba066
            
            #add-point:AFTER FIELD mrba066 name="input.a.mrba066"
            IF NOT cl_null(g_mrba_m.mrba066) THEN 
               #應用 a17 樣板自動產生(Version:2)
               #欄位存在檢查
               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
               INITIALIZE g_chkparam.* TO NULL
               #設定g_chkparam.*的參數
               LET g_chkparam.arg1 = g_mrba_m.mrba066                  
               #呼叫檢查存在並帶值的library
               IF cl_chk_exist("v_faah001") THEN
                  #檢查成功時後續處理
                  IF NOT amrm200_faah_chk() THEN
                     NEXT FIELD CURRENT
                  END IF
               ELSE
                  #檢查失敗時後續處理
                  LET g_mrba_m.mrba066 = g_mrba_m_t.mrba066
                  NEXT FIELD CURRENT
               END IF
            END IF            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mrba066
            #add-point:BEFORE FIELD mrba066 name="input.b.mrba066"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mrba066
            #add-point:ON CHANGE mrba066 name="input.g.mrba066"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mrba004
            #add-point:BEFORE FIELD mrba004 name="input.b.mrba004"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mrba004
            
            #add-point:AFTER FIELD mrba004 name="input.a.mrba004"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mrba004
            #add-point:ON CHANGE mrba004 name="input.g.mrba004"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mrba005
            #add-point:BEFORE FIELD mrba005 name="input.b.mrba005"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mrba005
            
            #add-point:AFTER FIELD mrba005 name="input.a.mrba005"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mrba005
            #add-point:ON CHANGE mrba005 name="input.g.mrba005"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mrba007
            #add-point:BEFORE FIELD mrba007 name="input.b.mrba007"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mrba007
            
            #add-point:AFTER FIELD mrba007 name="input.a.mrba007"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mrba007
            #add-point:ON CHANGE mrba007 name="input.g.mrba007"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mrba008
            #add-point:BEFORE FIELD mrba008 name="input.b.mrba008"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mrba008
            
            #add-point:AFTER FIELD mrba008 name="input.a.mrba008"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mrba008
            #add-point:ON CHANGE mrba008 name="input.g.mrba008"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mrba009
            #add-point:BEFORE FIELD mrba009 name="input.b.mrba009"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mrba009
            
            #add-point:AFTER FIELD mrba009 name="input.a.mrba009"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mrba009
            #add-point:ON CHANGE mrba009 name="input.g.mrba009"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mrba010
            
            #add-point:AFTER FIELD mrba010 name="input.a.mrba010"
            CALL amrm200_mrba010_desc(g_mrba_m.mrba010)
            IF NOT cl_null(g_mrba_m.mrba010) THEN
               IF NOT s_azzi650_chk_exist('1101',g_mrba_m.mrba010) THEN
                  LET g_mrba_m.mrba010 = g_mrba_m_t.mrba010
                  CALL amrm200_mrba010_desc(g_mrba_m.mrba010)
                  NEXT FIELD CURRENT
               END IF
            END IF
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mrba010
            #add-point:BEFORE FIELD mrba010 name="input.b.mrba010"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mrba010
            #add-point:ON CHANGE mrba010 name="input.g.mrba010"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mrba011
            
            #add-point:AFTER FIELD mrba011 name="input.a.mrba011"
            CALL amrm200_mrba011_desc(g_mrba_m.mrba011)
            IF NOT cl_null(g_mrba_m.mrba011) THEN
               IF NOT s_azzi650_chk_exist('1102',g_mrba_m.mrba011) THEN
                  LET g_mrba_m.mrba011 = g_mrba_m_t.mrba011
                  CALL amrm200_mrba011_desc(g_mrba_m.mrba011)
                  NEXT FIELD CURRENT
               END IF
            END IF
            


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mrba011
            #add-point:BEFORE FIELD mrba011 name="input.b.mrba011"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mrba011
            #add-point:ON CHANGE mrba011 name="input.g.mrba011"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mrba020
            
            #add-point:AFTER FIELD mrba020 name="input.a.mrba020"
            CALL amrm200_mrba020_desc(g_mrba_m.mrba020)
            IF NOT amrm200_mrba020_chk() THEN
               LET g_mrba_m.mrba020 = g_mrba_m_t.mrba020
               CALL amrm200_mrba020_desc(g_mrba_m.mrba020)
               NEXT FIELD CURRENT
            END IF
                    
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mrba020
            #add-point:BEFORE FIELD mrba020 name="input.b.mrba020"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mrba020
            #add-point:ON CHANGE mrba020 name="input.g.mrba020"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mrba006
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_mrba_m.mrba006,"0.000","0","","","azz-00079",1) THEN
               NEXT FIELD mrba006
            END IF 
 
 
 
            #add-point:AFTER FIELD mrba006 name="input.a.mrba006"
            IF NOT cl_null(g_mrba_m.mrba006) THEN 
            END IF 

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mrba006
            #add-point:BEFORE FIELD mrba006 name="input.b.mrba006"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mrba006
            #add-point:ON CHANGE mrba006 name="input.g.mrba006"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mrba012
            
            #add-point:AFTER FIELD mrba012 name="input.a.mrba012"
            CALL amrm200_mrba012_desc(g_mrba_m.mrba012)
            IF NOT cl_null(g_mrba_m.mrba012) THEN
 
               INITIALIZE g_chkparam.* TO NULL
 
               LET g_chkparam.arg1 = g_mrba_m.mrba012

               #呼叫?查存在??值的library
               IF NOT cl_chk_exist("v_oocg001") THEN
                  LET g_mrba_m.mrba012 = g_mrba_m_t.mrba012
                  CALL amrm200_mrba012_desc(g_mrba_m.mrba012)
                  NEXT FIELD CURRENT
               END IF


            END IF
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mrba012
            #add-point:BEFORE FIELD mrba012 name="input.b.mrba012"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mrba012
            #add-point:ON CHANGE mrba012 name="input.g.mrba012"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mrba013
            
            #add-point:AFTER FIELD mrba013 name="input.a.mrba013"
            CALL amrm200_mrba013_desc(g_mrba_m.mrba013)
            IF NOT cl_null(g_mrba_m.mrba013) THEN
 
               INITIALIZE g_chkparam.* TO NULL
 
               LET g_chkparam.arg1 = g_mrba_m.mrba013

               IF NOT cl_chk_exist("v_pmaa001_1") THEN
                  LET g_mrba_m.mrba013 = g_mrba_m_t.mrba013
                  CALL amrm200_mrba013_desc(g_mrba_m.mrba013)
                  NEXT FIELD CURRENT
               END IF


            END IF
            
            

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mrba013
            #add-point:BEFORE FIELD mrba013 name="input.b.mrba013"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mrba013
            #add-point:ON CHANGE mrba013 name="input.g.mrba013"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mrba014
            
            #add-point:AFTER FIELD mrba014 name="input.a.mrba014"
            CALL amrm200_mrba014_desc(g_mrba_m.mrba014)
            IF NOT cl_null(g_mrba_m.mrba014) THEN
 
               INITIALIZE g_chkparam.* TO NULL
 
               LET g_chkparam.arg1 = g_mrba_m.mrba014

               IF NOT cl_chk_exist("v_pmaa001_1") THEN
                  LET g_mrba_m.mrba014 = g_mrba_m_t.mrba014
                  CALL amrm200_mrba014_desc(g_mrba_m.mrba014)
                  NEXT FIELD CURRENT
               END IF


            END IF
            
            

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mrba014
            #add-point:BEFORE FIELD mrba014 name="input.b.mrba014"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mrba014
            #add-point:ON CHANGE mrba014 name="input.g.mrba014"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mrba015
            #add-point:BEFORE FIELD mrba015 name="input.b.mrba015"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mrba015
            
            #add-point:AFTER FIELD mrba015 name="input.a.mrba015"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mrba015
            #add-point:ON CHANGE mrba015 name="input.g.mrba015"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mrba016
            
            #add-point:AFTER FIELD mrba016 name="input.a.mrba016"
            CALL amrm200_mrba016_desc(g_mrba_m.mrba016)
            IF NOT cl_null(g_mrba_m.mrba016) THEN
 
               INITIALIZE g_chkparam.* TO NULL
 
               LET g_chkparam.arg1 = g_mrba_m.mrba016
               #160318-00025#6--add--str
               LET g_errshow = TRUE 
               LET g_chkparam.err_str[1] = "aim-00070:sub-01302|aooi130|",cl_get_progname("aooi130",g_lang,"2"),"|:EXEPROGaooi130"
               #160318-00025#6--add--end
               IF NOT cl_chk_exist("v_ooag001") THEN
                  LET g_mrba_m.mrba016 = g_mrba_m_t.mrba016
                  CALL amrm200_mrba016_desc(g_mrba_m.mrba016)
                  NEXT FIELD CURRENT
               ELSE
                  SELECT ooag003 INTO g_mrba_m.mrba017 FROM ooag_t
                   WHERE ooagent = g_enterprise AND ooag001 = g_mrba_m.mrba016
                  DISPLAY BY NAME g_mrba_m.mrba017
               END IF

            END IF

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mrba016
            #add-point:BEFORE FIELD mrba016 name="input.b.mrba016"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mrba016
            #add-point:ON CHANGE mrba016 name="input.g.mrba016"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mrba017
            
            #add-point:AFTER FIELD mrba017 name="input.a.mrba017"
            CALL amrm200_mrba017_desc(g_mrba_m.mrba017)
            IF NOT cl_null(g_mrba_m.mrba017) THEN
 
               INITIALIZE g_chkparam.* TO NULL
      
               LET g_chkparam.arg1 = g_mrba_m.mrba017
               LET g_chkparam.arg2 = g_today
               #160318-00025#6--add--str
               LET g_errshow = TRUE 
               LET g_chkparam.err_str[1] = "aoo-00029:sub-01302|aooi125|",cl_get_progname("aooi125",g_lang,"2"),"|:EXEPROGaooi125"
               #160318-00025#6--add--end
               IF NOT cl_chk_exist("v_ooeg001") THEN
                  LET g_mrba_m.mrba017 = g_mrba_m_t.mrba017
                  CALL amrm200_mrba017_desc(g_mrba_m.mrba017)
                  NEXT FIELD CURRENT
               END IF

            END IF
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mrba017
            #add-point:BEFORE FIELD mrba017 name="input.b.mrba017"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mrba017
            #add-point:ON CHANGE mrba017 name="input.g.mrba017"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mrba018
            
            #add-point:AFTER FIELD mrba018 name="input.a.mrba018"
            IF NOT cl_null(g_mrba_m.mrba018) THEN 
               #應用 a17 樣板自動產生(Version:3)
               #欄位存在檢查
               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
               INITIALIZE g_chkparam.* TO NULL
 
               #設定g_chkparam.*的參數
               LET g_chkparam.arg1 = g_mrba_m.mrba018
               #C2017041301chenyang---s add
               IF g_mrba_m.mrba000 = '3' THEN
                  LET g_chkparam.where = " oocq039 = '1' "
               END IF
               #C2017041301chenyang---e
                  
               #呼叫檢查存在並帶值的library
               IF cl_chk_exist("cv_mrba018") THEN
                  #檢查成功時後續處理
               ELSE
                  #檢查失敗時後續處理
                  NEXT FIELD CURRENT
               END IF
 


            END IF 
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mrba018
            #add-point:BEFORE FIELD mrba018 name="input.b.mrba018"
       
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mrba018
            #add-point:ON CHANGE mrba018 name="input.g.mrba018"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mrba102
            #add-point:BEFORE FIELD mrba102 name="input.b.mrba102"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mrba102
            
            #add-point:AFTER FIELD mrba102 name="input.a.mrba102"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mrba102
            #add-point:ON CHANGE mrba102 name="input.g.mrba102"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mrba100
            #add-point:BEFORE FIELD mrba100 name="input.b.mrba100"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mrba100
            
            #add-point:AFTER FIELD mrba100 name="input.a.mrba100"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mrba100
            #add-point:ON CHANGE mrba100 name="input.g.mrba100"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mrba101
            #add-point:BEFORE FIELD mrba101 name="input.b.mrba101"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mrba101
            
            #add-point:AFTER FIELD mrba101 name="input.a.mrba101"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mrba101
            #add-point:ON CHANGE mrba101 name="input.g.mrba101"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mrbastus
            #add-point:BEFORE FIELD mrbastus name="input.b.mrbastus"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mrbastus
            
            #add-point:AFTER FIELD mrbastus name="input.a.mrbastus"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mrbastus
            #add-point:ON CHANGE mrbastus name="input.g.mrbastus"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mrba021
            
            #add-point:AFTER FIELD mrba021 name="input.a.mrba021"
            CALL amrm200_mrba021_desc(g_mrba_m.mrba021)
            IF NOT cl_null(g_mrba_m.mrba021) THEN
               IF NOT s_azzi650_chk_exist('221',g_mrba_m.mrba021) THEN
                  LET g_mrba_m.mrba021 = g_mrba_m_t.mrba021
                  CALL amrm200_mrba021_desc(g_mrba_m.mrba021)
                  NEXT FIELD CURRENT
               END IF
            END IF
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mrba021
            #add-point:BEFORE FIELD mrba021 name="input.b.mrba021"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mrba021
            #add-point:ON CHANGE mrba021 name="input.g.mrba021"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mrba022
            
            #add-point:AFTER FIELD mrba022 name="input.a.mrba022"
            CALL amrm200_mrba022_desc(g_mrba_m.mrba022)
            IF NOT cl_null(g_mrba_m.mrba022) THEN
 
               INITIALIZE g_chkparam.* TO NULL
 
               LET g_chkparam.arg1 = g_site
               LET g_chkparam.arg2 = g_mrba_m.mrba022
               IF NOT cl_chk_exist("v_ecaa001") THEN
                  LET g_mrba_m.mrba022 = g_mrba_m_t.mrba022
                  CALL amrm200_mrba022_desc(g_mrba_m.mrba022)
                  NEXT FIELD CURRENT
               END IF

            END IF
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mrba022
            #add-point:BEFORE FIELD mrba022 name="input.b.mrba022"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mrba022
            #add-point:ON CHANGE mrba022 name="input.g.mrba022"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mrba025
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_mrba_m.mrba025,"0","1","","","azz-00079",1) THEN
               NEXT FIELD mrba025
            END IF 
 
 
 
            #add-point:AFTER FIELD mrba025 name="input.a.mrba025"
            IF NOT cl_null(g_mrba_m.mrba025) THEN 
            END IF 

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mrba025
            #add-point:BEFORE FIELD mrba025 name="input.b.mrba025"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mrba025
            #add-point:ON CHANGE mrba025 name="input.g.mrba025"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mrba026
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_mrba_m.mrba026,"1","1","","","azz-00079",1) THEN
               NEXT FIELD mrba026
            END IF 
 
 
 
            #add-point:AFTER FIELD mrba026 name="input.a.mrba026"
            IF NOT cl_null(g_mrba_m.mrba026) THEN 
            END IF 

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mrba026
            #add-point:BEFORE FIELD mrba026 name="input.b.mrba026"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mrba026
            #add-point:ON CHANGE mrba026 name="input.g.mrba026"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mrba027
            
            #add-point:AFTER FIELD mrba027 name="input.a.mrba027"
            CALL amrm200_mrba027_desc(g_mrba_m.mrba027)
            IF NOT cl_null(g_mrba_m.mrba027) THEN
               IF g_smfg0036 <> '2' THEN   #160801-00023#4
                 
    			     IF NOT s_azzi650_chk_exist('1103',g_mrba_m.mrba027) THEN
                     LET g_mrba_m.mrba027 = g_mrba_m_t.mrba027
                     CALL amrm200_mrba027_desc(g_mrba_m.mrba027)
                     NEXT FIELD CURRENT
                  END IF
               ELSE           #160801-00023#4
                  #151215-00002#3-mod----(S)
   			     #資源編號=0.1       → amri003類型的1(機器)
   			     #資源編號=2.3.4.5.6→ amri003類型的2(工具)
   			     IF g_mrba_m.mrba000 = '0' OR g_mrba_m.mrba000 = '1' THEN
   			        LET l_mrba000 = '1'
   			     ELSE
   			        LET l_mrba000 = '2'
   			     END IF
   			     INITIALIZE g_chkparam.* TO NULL
   			     LET g_chkparam.arg1 = "1103"
   			     LET g_chkparam.arg2 = g_mrba_m.mrba027
   			     LET g_chkparam.where = " oocq019 = '",l_mrba000,"'"
   			     #160318-00025#6--add--str
                 LET g_errshow = TRUE 
                 LET g_chkparam.err_str[1] = "aqc-00032:sub-01302|aqci030|",cl_get_progname("aqci030",g_lang,"2"),"|:EXEPROGaqci030"
                 #160318-00025#6--add--end
   			     IF NOT cl_chk_exist("v_oocq002_1") THEN
   			        LET g_mrba_m.mrba027 = g_mrba_m_t.mrba027
                    CALL amrm200_mrba027_desc(g_mrba_m.mrba027)
                    NEXT FIELD CURRENT
   			     END IF
   			     #151215-00002#3-mod----(E)
			     END IF    #160801-00023#4
            END IF
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mrba027
            #add-point:BEFORE FIELD mrba027 name="input.b.mrba027"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mrba027
            #add-point:ON CHANGE mrba027 name="input.g.mrba027"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mrba103
            
            #add-point:AFTER FIELD mrba103 name="input.a.mrba103"
            CALL amrm200_mrba103_desc()
            IF NOT cl_null(g_mrba_m.mrba103) THEN
               INITIALIZE g_chkparam.* TO NULL
               LET g_chkparam.arg1 = g_site
               LET g_chkparam.arg2 = g_mrba_m.mrba103
               IF NOT cl_chk_exist("v_oogd001") THEN
                  LET g_mrba_m.mrba103 = g_mrba_m_t.mrba103
                  CALL amrm200_mrba103_desc()
                  NEXT FIELD CURRENT
               END IF
            END IF

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mrba103
            #add-point:BEFORE FIELD mrba103 name="input.b.mrba103"
            CALL amrm200_mrba103_desc()
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mrba103
            #add-point:ON CHANGE mrba103 name="input.g.mrba103"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mrba029
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_mrba_m.mrba029,"0","1","100","1","azz-00087",1) THEN
               NEXT FIELD mrba029
            END IF 
 
 
 
            #add-point:AFTER FIELD mrba029 name="input.a.mrba029"
            IF NOT cl_null(g_mrba_m.mrba029) THEN 
            END IF 

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mrba029
            #add-point:BEFORE FIELD mrba029 name="input.b.mrba029"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mrba029
            #add-point:ON CHANGE mrba029 name="input.g.mrba029"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mrba031
            #add-point:BEFORE FIELD mrba031 name="input.b.mrba031"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mrba031
            
            #add-point:AFTER FIELD mrba031 name="input.a.mrba031"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mrba031
            #add-point:ON CHANGE mrba031 name="input.g.mrba031"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mrba032
            #add-point:BEFORE FIELD mrba032 name="input.b.mrba032"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mrba032
            
            #add-point:AFTER FIELD mrba032 name="input.a.mrba032"
            #160624-00006#1--add--start--
            IF NOT amrm200_mrba034_chk('1') THEN
               NEXT FIELD mrba032
            END IF
            #160624-00006#1--add--end----
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mrba032
            #add-point:ON CHANGE mrba032 name="input.g.mrba032"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mrba033
            #add-point:BEFORE FIELD mrba033 name="input.b.mrba033"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mrba033
            
            #add-point:AFTER FIELD mrba033 name="input.a.mrba033"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mrba033
            #add-point:ON CHANGE mrba033 name="input.g.mrba033"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mrba034
            #add-point:BEFORE FIELD mrba034 name="input.b.mrba034"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mrba034
            
            #add-point:AFTER FIELD mrba034 name="input.a.mrba034"
            #160624-00006#1--add--start--
            IF NOT amrm200_mrba034_chk('1') THEN
               NEXT FIELD mrba034
            END IF
            IF NOT amrm200_mrba034_chk('2') THEN
               NEXT FIELD mrba034
            END IF
            #160624-00006#1--add--end----
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mrba034
            #add-point:ON CHANGE mrba034 name="input.g.mrba034"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mrba035
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_mrba_m.mrba035,"1","1","","","azz-00079",1) THEN
               NEXT FIELD mrba035
            END IF 
 
 
 
            #add-point:AFTER FIELD mrba035 name="input.a.mrba035"
            IF NOT cl_null(g_mrba_m.mrba035) THEN 
            END IF 

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mrba035
            #add-point:BEFORE FIELD mrba035 name="input.b.mrba035"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mrba035
            #add-point:ON CHANGE mrba035 name="input.g.mrba035"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mrba036
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_mrba_m.mrba036,"0","0","","","azz-00079",1) THEN
               NEXT FIELD mrba036
            END IF 
 
 
 
            #add-point:AFTER FIELD mrba036 name="input.a.mrba036"
            IF NOT cl_null(g_mrba_m.mrba036) THEN 
            END IF 

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mrba036
            #add-point:BEFORE FIELD mrba036 name="input.b.mrba036"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mrba036
            #add-point:ON CHANGE mrba036 name="input.g.mrba036"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mrba038
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_mrba_m.mrba038,"0","0","","","azz-00079",1) THEN
               NEXT FIELD mrba038
            END IF 
 
 
 
            #add-point:AFTER FIELD mrba038 name="input.a.mrba038"
            IF NOT cl_null(g_mrba_m.mrba038) THEN 
            END IF 
            CALL amrm200_mrba040_required()
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mrba038
            #add-point:BEFORE FIELD mrba038 name="input.b.mrba038"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mrba038
            #add-point:ON CHANGE mrba038 name="input.g.mrba038"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mrba039
            #add-point:BEFORE FIELD mrba039 name="input.b.mrba039"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mrba039
            
            #add-point:AFTER FIELD mrba039 name="input.a.mrba039"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mrba039
            #add-point:ON CHANGE mrba039 name="input.g.mrba039"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mrba040
            
            #add-point:AFTER FIELD mrba040 name="input.a.mrba040"
            CALL amrm200_mrba040_desc(g_mrba_m.mrba040)
            IF NOT cl_null(g_mrba_m.mrba040) THEN
 
               INITIALIZE g_chkparam.* TO NULL
 
               LET g_chkparam.arg1 = g_site
               LET g_chkparam.arg2 = g_mrba_m.mrba040
               #160318-00025#6--add--str
               LET g_errshow = TRUE 
               LET g_chkparam.err_str[1] = "aoo-00176:sub-01302|aooi150|",cl_get_progname("aooi150",g_lang,"2"),"|:EXEPROGaooi150"
               #160318-00025#6--add--end
               IF NOT cl_chk_exist("v_ooaj002") THEN
                  LET g_mrba_m.mrba040 = g_mrba_m_t.mrba040
                  CALL amrm200_mrba040_desc(g_mrba_m.mrba040)
                  NEXT FIELD CURRENT
               END IF

            END IF
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mrba040
            #add-point:BEFORE FIELD mrba040 name="input.b.mrba040"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mrba040
            #add-point:ON CHANGE mrba040 name="input.g.mrba040"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mrba041
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_mrba_m.mrba041,"0","0","","","azz-00079",1) THEN
               NEXT FIELD mrba041
            END IF 
 
 
 
            #add-point:AFTER FIELD mrba041 name="input.a.mrba041"
            IF NOT cl_null(g_mrba_m.mrba041) THEN 
            END IF 

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mrba041
            #add-point:BEFORE FIELD mrba041 name="input.b.mrba041"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mrba041
            #add-point:ON CHANGE mrba041 name="input.g.mrba041"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mrba042
            #add-point:BEFORE FIELD mrba042 name="input.b.mrba042"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mrba042
            
            #add-point:AFTER FIELD mrba042 name="input.a.mrba042"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mrba042
            #add-point:ON CHANGE mrba042 name="input.g.mrba042"
            
            #END add-point 
 
 
 #欄位檢查
                  #Ctrlp:input.c.mrba019
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mrba019
            #add-point:ON ACTION controlp INFIELD mrba019 name="input.c.mrba019"
            
            #END add-point
 
 
         #Ctrlp:input.c.mrba000
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mrba000
            #add-point:ON ACTION controlp INFIELD mrba000 name="input.c.mrba000"
            
            #END add-point
 
 
         #Ctrlp:input.c.mrba001
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mrba001
            #add-point:ON ACTION controlp INFIELD mrba001 name="input.c.mrba001"
            
            #END add-point
 
 
         #Ctrlp:input.c.mrba002
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mrba002
            #add-point:ON ACTION controlp INFIELD mrba002 name="input.c.mrba002"
            #應用 a07 樣板自動產生(Version:2)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_mrba_m.mrba002  #給予default值
            #給予arg
            LET g_qryparam.arg1 = ""
            CALL q_faah003_3()                            #呼叫開窗
            LET g_mrba_m.mrba002 = g_qryparam.return1
            LET g_mrba_m.mrba003 = g_qryparam.return2
            LET g_mrba_m.mrba066 = g_qryparam.return3
            IF cl_null(g_mrba_m.mrba003) THEN LET g_mrba_m.mrba003=' ' END IF
            DISPLAY g_mrba_m.mrba002 TO mrba002
            DISPLAY g_mrba_m.mrba003 TO mrba003
            DISPLAY g_mrba_m.mrba066 TO mrba066
            NEXT FIELD mrba002                          #返回原欄位
            #END add-point
 
 
         #Ctrlp:input.c.mrba003
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mrba003
            #add-point:ON ACTION controlp INFIELD mrba003 name="input.c.mrba003"
            #應用 a07 樣板自動產生(Version:2)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_mrba_m.mrba003  #給予default值
            #給予arg
            LET g_qryparam.arg1 = ""
            CALL q_faah003_3()                            #呼叫開窗
            LET g_mrba_m.mrba002 = g_qryparam.return1
            LET g_mrba_m.mrba003 = g_qryparam.return2
            LET g_mrba_m.mrba066 = g_qryparam.return3
            IF cl_null(g_mrba_m.mrba003) THEN LET g_mrba_m.mrba003=' ' END IF
            DISPLAY g_mrba_m.mrba002 TO mrba002
            DISPLAY g_mrba_m.mrba003 TO mrba003
            DISPLAY g_mrba_m.mrba066 TO mrba066
            NEXT FIELD mrba003                          #返回原欄位
            #END add-point
 
 
         #Ctrlp:input.c.mrba066
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mrba066
            #add-point:ON ACTION controlp INFIELD mrba066 name="input.c.mrba066"
            #應用 a07 樣板自動產生(Version:2)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_mrba_m.mrba066  #給予default值
            #給予arg
            LET g_qryparam.arg1 = ""
            CALL q_faah003_3()                            #呼叫開窗
            LET g_mrba_m.mrba002 = g_qryparam.return1
            LET g_mrba_m.mrba003 = g_qryparam.return2
            LET g_mrba_m.mrba066 = g_qryparam.return3
            IF cl_null(g_mrba_m.mrba003) THEN LET g_mrba_m.mrba003=' ' END IF
            DISPLAY g_mrba_m.mrba002 TO mrba002
            DISPLAY g_mrba_m.mrba003 TO mrba003
            DISPLAY g_mrba_m.mrba066 TO mrba066
            NEXT FIELD mrba066                          #返回原欄位
            #END add-point
 
 
         #Ctrlp:input.c.mrba004
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mrba004
            #add-point:ON ACTION controlp INFIELD mrba004 name="input.c.mrba004"
            
            #END add-point
 
 
         #Ctrlp:input.c.mrba005
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mrba005
            #add-point:ON ACTION controlp INFIELD mrba005 name="input.c.mrba005"
            
            #END add-point
 
 
         #Ctrlp:input.c.mrba007
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mrba007
            #add-point:ON ACTION controlp INFIELD mrba007 name="input.c.mrba007"
            
            #END add-point
 
 
         #Ctrlp:input.c.mrba008
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mrba008
            #add-point:ON ACTION controlp INFIELD mrba008 name="input.c.mrba008"
            
            #END add-point
 
 
         #Ctrlp:input.c.mrba009
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mrba009
            #add-point:ON ACTION controlp INFIELD mrba009 name="input.c.mrba009"
            
            #END add-point
 
 
         #Ctrlp:input.c.mrba010
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mrba010
            #add-point:ON ACTION controlp INFIELD mrba010 name="input.c.mrba010"
#此段落由子樣板a07產生            
            #開窗i段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
			LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_mrba_m.mrba010             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "1101" #

            CALL q_oocq002()                                #呼叫開窗

            LET g_mrba_m.mrba010 = g_qryparam.return1              #將開窗取得的值回傳到變數

            DISPLAY g_mrba_m.mrba010 TO mrba010              #顯示到畫面上
            CALL amrm200_mrba010_desc(g_mrba_m.mrba010)
            NEXT FIELD mrba010                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.mrba011
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mrba011
            #add-point:ON ACTION controlp INFIELD mrba011 name="input.c.mrba011"
#此段落由子樣板a07產生            
            #開窗i段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
			LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_mrba_m.mrba011             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "1102" #

            CALL q_oocq002()                                #呼叫開窗

            LET g_mrba_m.mrba011 = g_qryparam.return1              #將開窗取得的值回傳到變數

            DISPLAY g_mrba_m.mrba011 TO mrba011              #顯示到畫面上
            CALL amrm200_mrba011_desc(g_mrba_m.mrba011)
            NEXT FIELD mrba011                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.mrba020
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mrba020
            #add-point:ON ACTION controlp INFIELD mrba020 name="input.c.mrba020"
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
			LET g_qryparam.reqry = FALSE
			LET g_qryparam.default1 = g_mrba_m.mrba020
			IF g_mrba_m.mrba019 = '0' THEN
#160716-00011#1-s
#所有權據點的開窗目前使用q_ooef001_04,開出來的資料不對,請改成使用q_ooef001_12
#           LET g_qryparam.arg1 = '2'
#			   CALL q_ooef001_04()
			   #mod--161013-00051#1 By shiun--(S)
#			   CALL q_ooef001_12()
			   CALL q_ooef001_1()
            #mod--161013-00051#1 By shiun--(E)
#160716-00011#1-e
			ELSE
			   LET g_qryparam.arg1 = g_site
			   CALL q_pmaa001_6()
			END IF
			
			LET g_mrba_m.mrba020 = g_qryparam.return1              #將開窗取得的值回傳到變數

            DISPLAY g_mrba_m.mrba020 TO mrba020
            CALL amrm200_mrba020_desc(g_mrba_m.mrba020)
            NEXT FIELD mrba020
            #END add-point
 
 
         #Ctrlp:input.c.mrba006
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mrba006
            #add-point:ON ACTION controlp INFIELD mrba006 name="input.c.mrba006"
            
            #END add-point
 
 
         #Ctrlp:input.c.mrba012
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mrba012
            #add-point:ON ACTION controlp INFIELD mrba012 name="input.c.mrba012"
#此段落由子樣板a07產生            
            #開窗i段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
			LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_mrba_m.mrba012             #給予default值

            #給予arg

            CALL q_oocg001()                                #呼叫開窗

            LET g_mrba_m.mrba012 = g_qryparam.return1              #將開窗取得的值回傳到變數

            DISPLAY g_mrba_m.mrba012 TO mrba012              #顯示到畫面上
            CALL amrm200_mrba012_desc(g_mrba_m.mrba012)
            NEXT FIELD mrba012                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.mrba013
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mrba013
            #add-point:ON ACTION controlp INFIELD mrba013 name="input.c.mrba013"
#此段落由子樣板a07產生            
            #開窗i段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
			LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_mrba_m.mrba013             #給予default值

            #給予arg

            CALL q_pmaa001_3()                                #呼叫開窗

            LET g_mrba_m.mrba013 = g_qryparam.return1              #將開窗取得的值回傳到變數

            DISPLAY g_mrba_m.mrba013 TO mrba013              #顯示到畫面上
            CALL amrm200_mrba013_desc(g_mrba_m.mrba013)
            NEXT FIELD mrba013                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.mrba014
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mrba014
            #add-point:ON ACTION controlp INFIELD mrba014 name="input.c.mrba014"
#此段落由子樣板a07產生            
            #開窗i段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
			LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_mrba_m.mrba014             #給予default值

            #給予arg

            CALL q_pmaa001_3()                                #呼叫開窗

            LET g_mrba_m.mrba014 = g_qryparam.return1              #將開窗取得的值回傳到變數

            DISPLAY g_mrba_m.mrba014 TO mrba014              #顯示到畫面上
            CALL amrm200_mrba014_desc(g_mrba_m.mrba014)
            NEXT FIELD mrba014                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.mrba015
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mrba015
            #add-point:ON ACTION controlp INFIELD mrba015 name="input.c.mrba015"
            
            #END add-point
 
 
         #Ctrlp:input.c.mrba016
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mrba016
            #add-point:ON ACTION controlp INFIELD mrba016 name="input.c.mrba016"
            #此段落由子樣板a07產生            
            #開窗i段
			   INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
			   LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_mrba_m.mrba016      #給予default值
            #給予arg
            CALL q_ooag001()                                #呼叫開窗
            LET g_mrba_m.mrba016 = g_qryparam.return1       #將開窗取得的值回傳到變數
            DISPLAY g_mrba_m.mrba016 TO mrba016             #顯示到畫面上
            CALL amrm200_mrba016_desc(g_mrba_m.mrba016)
            NEXT FIELD mrba016                              #返回原欄位
            #END add-point
 
 
         #Ctrlp:input.c.mrba017
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mrba017
            #add-point:ON ACTION controlp INFIELD mrba017 name="input.c.mrba017"
#此段落由子樣板a07產生            
            #開窗i段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
			LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_mrba_m.mrba017             #給予default值

            #給予arg
            LET g_qryparam.arg1 = g_today #

            CALL q_ooeg001()                                #呼叫開窗

            LET g_mrba_m.mrba017 = g_qryparam.return1              #將開窗取得的值回傳到變數

            DISPLAY g_mrba_m.mrba017 TO mrba017              #顯示到畫面上
            CALL amrm200_mrba017_desc(g_mrba_m.mrba017)
            NEXT FIELD mrba017                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.mrba018
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mrba018
            #add-point:ON ACTION controlp INFIELD mrba018 name="input.c.mrba018"
            #應用 a07 樣板自動產生(Version:3)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
 
            LET g_qryparam.default1 = g_mrba_m.mrba018             #給予default值
            
            #C2017041301chenyang---s add
            IF g_mrba_m.mrba000 = '3' THEN
               LET g_qryparam.where = " oocq039 = '1' "
            END IF
            #C2017041301chenyang---e
            
            #給予arg
            LET g_qryparam.arg1 = "" #s

 
            CALL cq_oocq002()                                #呼叫開窗
 
            LET g_mrba_m.mrba018 = g_qryparam.return1              

            DISPLAY g_mrba_m.mrba018 TO mrba018              #

            NEXT FIELD mrba018                          #返回原欄位



            #END add-point
 
 
         #Ctrlp:input.c.mrba102
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mrba102
            #add-point:ON ACTION controlp INFIELD mrba102 name="input.c.mrba102"
            
            #END add-point
 
 
         #Ctrlp:input.c.mrba100
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mrba100
            #add-point:ON ACTION controlp INFIELD mrba100 name="input.c.mrba100"
            
            #END add-point
 
 
         #Ctrlp:input.c.mrba101
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mrba101
            #add-point:ON ACTION controlp INFIELD mrba101 name="input.c.mrba101"
            
            #END add-point
 
 
         #Ctrlp:input.c.mrbastus
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mrbastus
            #add-point:ON ACTION controlp INFIELD mrbastus name="input.c.mrbastus"
            
            #END add-point
 
 
         #Ctrlp:input.c.mrba021
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mrba021
            #add-point:ON ACTION controlp INFIELD mrba021 name="input.c.mrba021"
#此段落由子樣板a07產生            
            #開窗i段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
			LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_mrba_m.mrba021             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "221" #

            CALL q_oocq002()                                #呼叫開窗

            LET g_mrba_m.mrba021 = g_qryparam.return1              #將開窗取得的值回傳到變數

            DISPLAY g_mrba_m.mrba021 TO mrba021              #顯示到畫面上
            CALL amrm200_mrba021_desc(g_mrba_m.mrba021)
            NEXT FIELD mrba021                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.mrba022
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mrba022
            #add-point:ON ACTION controlp INFIELD mrba022 name="input.c.mrba022"
#此段落由子樣板a07產生            
            #開窗i段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
			LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_mrba_m.mrba022             #給予default值

            #給予arg

            CALL q_ecaa001()                                #呼叫開窗

            LET g_mrba_m.mrba022 = g_qryparam.return1              #將開窗取得的值回傳到變數

            DISPLAY g_mrba_m.mrba022 TO mrba022              #顯示到畫面上
            CALL amrm200_mrba022_desc(g_mrba_m.mrba022)
            NEXT FIELD mrba022                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.mrba025
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mrba025
            #add-point:ON ACTION controlp INFIELD mrba025 name="input.c.mrba025"
            
            #END add-point
 
 
         #Ctrlp:input.c.mrba026
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mrba026
            #add-point:ON ACTION controlp INFIELD mrba026 name="input.c.mrba026"
            
            #END add-point
 
 
         #Ctrlp:input.c.mrba027
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mrba027
            #add-point:ON ACTION controlp INFIELD mrba027 name="input.c.mrba027"
            #此段落由子樣板a07產生            
            #開窗i段
			   INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
			   LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_mrba_m.mrba027      #給予default值
            LET g_qryparam.arg1 = "1103"                    #給予arg
            IF g_smfg0036 = '2' THEN   #160801-00023#4
               #151215-00002#3-add----(S)
   	         #資源編號=0.1       → amri003類型的1(機器)
   	         #資源編號=2.3.4.5.6→ amri003類型的2(工具)
   	         IF g_mrba_m.mrba000 = '0' OR g_mrba_m.mrba000 = '1' THEN
   	            LET l_mrba000 = '1'
   	         ELSE
   	            LET l_mrba000 = '2'
   	         END IF
   	         LET g_qryparam.where = " oocq019 = '",l_mrba000,"'"
   			   #151215-00002#3-add----(E)
   			END IF                     #160801-00023#4
            CALL q_oocq002()                                #呼叫開窗
            LET g_mrba_m.mrba027 = g_qryparam.return1       #將開窗取得的值回傳到變數
            DISPLAY g_mrba_m.mrba027 TO mrba027             #顯示到畫面上
            CALL amrm200_mrba027_desc(g_mrba_m.mrba027)
            NEXT FIELD mrba027                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.mrba103
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mrba103
            #add-point:ON ACTION controlp INFIELD mrba103 name="input.c.mrba103"
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_mrba_m.mrba103             #給予default值
            LET g_qryparam.default2 = "" #g_mrba_m.oocq002 #應用分類碼
            
            CALL q_oogd001_01()                                #呼叫開窗

            LET g_mrba_m.mrba103 = g_qryparam.return1              
            #LET g_mrba_m.oocq002 = g_qryparam.return2 
            DISPLAY g_mrba_m.mrba103 TO mrba103              #
            #DISPLAY g_mrba_m.oocq002 TO oocq002 #應用分類碼
            NEXT FIELD mrba103                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.mrba029
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mrba029
            #add-point:ON ACTION controlp INFIELD mrba029 name="input.c.mrba029"
            
            #END add-point
 
 
         #Ctrlp:input.c.mrba031
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mrba031
            #add-point:ON ACTION controlp INFIELD mrba031 name="input.c.mrba031"
            
            #END add-point
 
 
         #Ctrlp:input.c.mrba032
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mrba032
            #add-point:ON ACTION controlp INFIELD mrba032 name="input.c.mrba032"
            
            #END add-point
 
 
         #Ctrlp:input.c.mrba033
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mrba033
            #add-point:ON ACTION controlp INFIELD mrba033 name="input.c.mrba033"
            
            #END add-point
 
 
         #Ctrlp:input.c.mrba034
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mrba034
            #add-point:ON ACTION controlp INFIELD mrba034 name="input.c.mrba034"
            
            #END add-point
 
 
         #Ctrlp:input.c.mrba035
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mrba035
            #add-point:ON ACTION controlp INFIELD mrba035 name="input.c.mrba035"
            
            #END add-point
 
 
         #Ctrlp:input.c.mrba036
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mrba036
            #add-point:ON ACTION controlp INFIELD mrba036 name="input.c.mrba036"
            
            #END add-point
 
 
         #Ctrlp:input.c.mrba038
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mrba038
            #add-point:ON ACTION controlp INFIELD mrba038 name="input.c.mrba038"
            
            #END add-point
 
 
         #Ctrlp:input.c.mrba039
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mrba039
            #add-point:ON ACTION controlp INFIELD mrba039 name="input.c.mrba039"
            
            #END add-point
 
 
         #Ctrlp:input.c.mrba040
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mrba040
            #add-point:ON ACTION controlp INFIELD mrba040 name="input.c.mrba040"
#此段落由子樣板a07產生            
            #開窗i段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
			LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_mrba_m.mrba040             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "ALL" #

            CALL q_ooaj002_1()                                #呼叫開窗

            LET g_mrba_m.mrba040 = g_qryparam.return1              #將開窗取得的值回傳到變數

            DISPLAY g_mrba_m.mrba040 TO mrba040              #顯示到畫面上
            CALL amrm200_mrba040_desc(g_mrba_m.mrba040)
            NEXT FIELD mrba040                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.mrba041
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mrba041
            #add-point:ON ACTION controlp INFIELD mrba041 name="input.c.mrba041"
            
            #END add-point
 
 
         #Ctrlp:input.c.mrba042
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mrba042
            #add-point:ON ACTION controlp INFIELD mrba042 name="input.c.mrba042"
            
            #END add-point
 
 
 #欄位開窗
            
         AFTER INPUT
            IF INT_FLAG THEN
               EXIT DIALOG
            END IF
 
            #CALL cl_err_collect_show()      #錯誤訊息統整顯示
            #CALL cl_showmsg()
            DISPLAY BY NAME g_mrba_m.mrba001
                        
            #add-point:單頭INPUT後 name="input.head.after_input"
            #160624-00006#1--add--start--
            IF NOT amrm200_mrba034_chk('1') THEN
               NEXT FIELD mrba034
            END IF
            IF NOT amrm200_mrba034_chk('2') THEN
               NEXT FIELD mrba034
            END IF
            #160624-00006#1--add--end----
            #end add-point
                        
            IF p_cmd <> 'u' THEN
    
               CALL s_transaction_begin()
               
               #add-point:單頭新增前 name="input.head.b_insert"
               
               #end add-point
               
               INSERT INTO mrba_t (mrbaent, mrbasite,mrba019,mrba000,mrba001,mrba002,mrba003,mrba066, 
                   mrba004,mrba005,mrba007,mrba008,mrba009,mrba010,mrba011,mrba020,mrba006,mrba104,mrba012, 
                   mrba013,mrba014,mrba015,mrba016,mrba017,mrba018,mrba102,mrba100,mrba101,mrbastus, 
                   mrba021,mrba022,mrba025,mrba026,mrba027,mrba103,mrba029,mrba031,mrba032,mrba033,mrba034, 
                   mrba035,mrba036,mrba038,mrba039,mrba040,mrba041,mrba042,mrbaownid,mrbaowndp,mrbacrtid, 
                   mrbacrtdp,mrbacrtdt,mrbamodid,mrbamoddt,mrbacnfid,mrbacnfdt)
               VALUES (g_enterprise, g_site,g_mrba_m.mrba019,g_mrba_m.mrba000,g_mrba_m.mrba001,g_mrba_m.mrba002, 
                   g_mrba_m.mrba003,g_mrba_m.mrba066,g_mrba_m.mrba004,g_mrba_m.mrba005,g_mrba_m.mrba007, 
                   g_mrba_m.mrba008,g_mrba_m.mrba009,g_mrba_m.mrba010,g_mrba_m.mrba011,g_mrba_m.mrba020, 
                   g_mrba_m.mrba006,g_mrba_m.mrba104,g_mrba_m.mrba012,g_mrba_m.mrba013,g_mrba_m.mrba014, 
                   g_mrba_m.mrba015,g_mrba_m.mrba016,g_mrba_m.mrba017,g_mrba_m.mrba018,g_mrba_m.mrba102, 
                   g_mrba_m.mrba100,g_mrba_m.mrba101,g_mrba_m.mrbastus,g_mrba_m.mrba021,g_mrba_m.mrba022, 
                   g_mrba_m.mrba025,g_mrba_m.mrba026,g_mrba_m.mrba027,g_mrba_m.mrba103,g_mrba_m.mrba029, 
                   g_mrba_m.mrba031,g_mrba_m.mrba032,g_mrba_m.mrba033,g_mrba_m.mrba034,g_mrba_m.mrba035, 
                   g_mrba_m.mrba036,g_mrba_m.mrba038,g_mrba_m.mrba039,g_mrba_m.mrba040,g_mrba_m.mrba041, 
                   g_mrba_m.mrba042,g_mrba_m.mrbaownid,g_mrba_m.mrbaowndp,g_mrba_m.mrbacrtid,g_mrba_m.mrbacrtdp, 
                   g_mrba_m.mrbacrtdt,g_mrba_m.mrbamodid,g_mrba_m.mrbamoddt,g_mrba_m.mrbacnfid,g_mrba_m.mrbacnfdt)  
 
               IF SQLCA.SQLCODE THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "g_mrba_m:",SQLERRMESSAGE 
                  LET g_errparam.code = SQLCA.SQLCODE 
                  LET g_errparam.popup = TRUE 
                  CALL s_transaction_end('N','0')
                  CALL cl_err()
                  NEXT FIELD CURRENT
               END IF
               
               #add-point:單頭新增中 name="input.head.m_insert"
               IF g_smfg0036 = '2' THEN   #160801-00023#4
                  #151215-00002#3-add----(S)
                  CALL amrm200_ins_mrbi() RETURNING l_success 
                  IF NOT l_success THEN
                     CALL s_transaction_end('N','0') 
                  END IF
                  #151215-00002#3-add----(E)
               END IF               #160801-00023#4
               #end add-point
               
               
               
               
               #add-point:單頭新增後 name="input.head.a_insert"
               
               #end add-point
               CALL s_transaction_end('Y','0') 
               
               IF l_cmd_t = 'r' AND p_cmd = 'a' THEN
                  CALL amrm200_detail_reproduce()
                  #因應特定程式需求, 重新刷新單身資料
                  CALL amrm200_b_fill()
                  CALL amrm200_b_fill2('0')
               END IF
               
               #add-point:單頭新增後 name="input.head.a_insert2"
               
               #end add-point
               
               LET g_master_insert = TRUE
               
               LET p_cmd = 'u'
            ELSE
               CALL s_transaction_begin()
            
               #add-point:單頭修改前 name="input.head.b_update"
               #ming ------------------------------------------------------(S) 
               IF g_mrba_m.mrba022 <> g_mrba_m_t.mrba022 THEN 
                  LET l_cnt = 0 
                  SELECT COUNT(*) INTO l_cnt 
                    FROM mrbh_t 
                   WHERE mrbhent = g_enterprise 
                     AND mrbhsite = g_site 
                     AND mrbh001 = g_mrba_m_t.mrba001 
                     AND mrbh006 = g_mrba_m_t.mrba022 
                  
                  IF l_cnt > 0 THEN 
                     UPDATE mrbh_t SET mrbh006 = g_mrba_m.mrba022 
                      WHERE mrbhent = g_enterprise 
                        AND mrbhsite = g_site 
                        AND mrbh001 = g_mrba_m_t.mrba001 
                        AND mrbh006 = g_mrba_m_t.mrba022 
                     IF SQLCA.sqlcode THEN 
                        INITIALIZE g_errparam TO NULL 
                        LET g_errparam.extend = "mrbh_t"  
                        LET g_errparam.code = SQLCA.sqlcode 
                        LET g_errparam.popup = TRUE  
                        CALL cl_err() 
                  
                        CALL s_transaction_end('N','0') 
                        CONTINUE DIALOG 
                     END IF 
                  END IF 
               END IF 
               #ming ------------------------------------------------------(E)
               IF g_smfg0036 = '2' THEN   #160801-00023#4
                  #151215-00002#3-add----(S)
                  #舊值0.1 & 輸入的值2.3.4.5.6 或 舊值2.3.4.5.6 & 輸入的值 0.1
                  IF (g_mrba_m_t.mrba000 < 2 AND g_mrba_m.mrba000 >= 2 ) OR
                     (g_mrba_m_t.mrba000 >= 2 AND g_mrba_m.mrba000 < 2 ) THEN
                     DELETE FROM mrbi_t
                      WHERE mrbient = g_enterprise
                        AND mrbisite = g_site
                        AND mrbi002 = g_mrba_m_t.mrba001
                     IF SQLCA.sqlcode THEN 
                        INITIALIZE g_errparam TO NULL 
                        LET g_errparam.extend = "DELETE mrbi_t"  
                        LET g_errparam.code = SQLCA.sqlcode 
                        LET g_errparam.popup = TRUE  
                        CALL cl_err() 
                        CALL s_transaction_end('N','0') 
                     END IF 
                  END IF
                  #151215-00002#3-add----(E)
               END IF             #160801-00023#4
               #end add-point
               
               #將遮罩欄位還原
               CALL amrm200_mrba_t_mask_restore('restore_mask_o')
               
               UPDATE mrba_t SET (mrba019,mrba000,mrba001,mrba002,mrba003,mrba066,mrba004,mrba005,mrba007, 
                   mrba008,mrba009,mrba010,mrba011,mrba020,mrba006,mrba104,mrba012,mrba013,mrba014,mrba015, 
                   mrba016,mrba017,mrba018,mrba102,mrba100,mrba101,mrbastus,mrba021,mrba022,mrba025, 
                   mrba026,mrba027,mrba103,mrba029,mrba031,mrba032,mrba033,mrba034,mrba035,mrba036,mrba038, 
                   mrba039,mrba040,mrba041,mrba042,mrbaownid,mrbaowndp,mrbacrtid,mrbacrtdp,mrbacrtdt, 
                   mrbamodid,mrbamoddt,mrbacnfid,mrbacnfdt) = (g_mrba_m.mrba019,g_mrba_m.mrba000,g_mrba_m.mrba001, 
                   g_mrba_m.mrba002,g_mrba_m.mrba003,g_mrba_m.mrba066,g_mrba_m.mrba004,g_mrba_m.mrba005, 
                   g_mrba_m.mrba007,g_mrba_m.mrba008,g_mrba_m.mrba009,g_mrba_m.mrba010,g_mrba_m.mrba011, 
                   g_mrba_m.mrba020,g_mrba_m.mrba006,g_mrba_m.mrba104,g_mrba_m.mrba012,g_mrba_m.mrba013, 
                   g_mrba_m.mrba014,g_mrba_m.mrba015,g_mrba_m.mrba016,g_mrba_m.mrba017,g_mrba_m.mrba018, 
                   g_mrba_m.mrba102,g_mrba_m.mrba100,g_mrba_m.mrba101,g_mrba_m.mrbastus,g_mrba_m.mrba021, 
                   g_mrba_m.mrba022,g_mrba_m.mrba025,g_mrba_m.mrba026,g_mrba_m.mrba027,g_mrba_m.mrba103, 
                   g_mrba_m.mrba029,g_mrba_m.mrba031,g_mrba_m.mrba032,g_mrba_m.mrba033,g_mrba_m.mrba034, 
                   g_mrba_m.mrba035,g_mrba_m.mrba036,g_mrba_m.mrba038,g_mrba_m.mrba039,g_mrba_m.mrba040, 
                   g_mrba_m.mrba041,g_mrba_m.mrba042,g_mrba_m.mrbaownid,g_mrba_m.mrbaowndp,g_mrba_m.mrbacrtid, 
                   g_mrba_m.mrbacrtdp,g_mrba_m.mrbacrtdt,g_mrba_m.mrbamodid,g_mrba_m.mrbamoddt,g_mrba_m.mrbacnfid, 
                   g_mrba_m.mrbacnfdt)
                WHERE mrbaent = g_enterprise AND mrbasite = g_site AND mrba001 = g_mrba001_t
 
               IF SQLCA.SQLCODE THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "mrba_t:",SQLERRMESSAGE 
                  LET g_errparam.code = SQLCA.SQLCODE 
                  LET g_errparam.popup = TRUE 
                  CALL s_transaction_end('N','0')
                  CALL cl_err()
                  NEXT FIELD CURRENT
               END IF
               
               #add-point:單頭修改中 name="input.head.m_update"
               IF g_smfg0036 = '2' THEN   #160801-00023#4
                  #151215-00002#3-add----(S)
                  CALL amrm200_ins_mrbi() RETURNING l_success
                  IF NOT l_success THEN
                     CALL s_transaction_end('N','0')
                  END IF
                  #151215-00002#3-add----(E)
               END IF               #160801-00023#4
               #end add-point
               
               
               
               
               #將遮罩欄位進行遮蔽
               CALL amrm200_mrba_t_mask_restore('restore_mask_n')
               
               #修改歷程記錄(單頭修改)
               LET g_log1 = util.JSON.stringify(g_mrba_m_t)
               LET g_log2 = util.JSON.stringify(g_mrba_m)
               IF NOT cl_log_modified_record(g_log1,g_log2) THEN 
                  CALL s_transaction_end('N','0')
               ELSE
                  CALL s_transaction_end('Y','0')
               END IF
               
               #add-point:單頭修改後 name="input.head.a_update"
               
               #end add-point
            END IF
            
            LET g_master_commit = "Y"
            LET g_mrba001_t = g_mrba_m.mrba001
 
            
      END INPUT
   
 
{</section>}
 
{<section id="amrm200.input.body" >}
   
      #Page1 預設值產生於此處
      INPUT ARRAY g_mrbb_d FROM s_detail1.*
          ATTRIBUTE(COUNT = g_rec_b,WITHOUT DEFAULTS, #MAXCOUNT = g_max_rec,
                  INSERT ROW = l_allow_insert, 
                  DELETE ROW = l_allow_delete,
                  APPEND ROW = l_allow_insert)
 
         #自訂ACTION(detail_input,page_1)
         
         
         BEFORE INPUT
            #add-point:資料輸入前 name="input.body.before_input2"
            
            #end add-point
            IF g_insert = 'Y' AND NOT cl_null(g_insert) THEN 
              CALL FGL_SET_ARR_CURR(g_mrbb_d.getLength()+1) 
              LET g_insert = 'N' 
           END IF 
 
            CALL amrm200_b_fill()
            #如果一直都在單身1則控制筆數位置
            IF g_loc = 'm' AND g_rec_b != 0 THEN
               CALL FGL_SET_ARR_CURR(g_idx_group.getValue("'1',"))
            END IF
            LET g_loc = 'm'
            LET g_rec_b = g_mrbb_d.getLength()
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
            OPEN amrm200_cl USING g_enterprise, g_site,g_mrba_m.mrba001
            IF SQLCA.SQLCODE THEN   #(ver:78)
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "OPEN amrm200_cl:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE   #(ver:78)
               LET g_errparam.popup = TRUE 
               CLOSE amrm200_cl
               CALL s_transaction_end('N','0')
               CALL cl_err()
               RETURN
            END IF
            
            LET g_rec_b = g_mrbb_d.getLength()
            
            IF g_rec_b >= l_ac 
               AND g_mrbb_d[l_ac].mrbb002 IS NOT NULL
 
            THEN
               LET l_cmd='u'
               LET g_mrbb_d_t.* = g_mrbb_d[l_ac].*  #BACKUP
               LET g_mrbb_d_o.* = g_mrbb_d[l_ac].*  #BACKUP
               CALL amrm200_set_entry_b(l_cmd)
               #add-point:modify段after_set_entry_b name="input.body.after_set_entry_b"
               
               #end add-point  
               CALL amrm200_set_no_entry_b(l_cmd)
               IF NOT amrm200_lock_b("mrbb_t","'1'") THEN
                  LET l_lock_sw='Y'
               ELSE
                  FETCH amrm200_bcl INTO g_mrbb_d[l_ac].mrbbstus,g_mrbb_d[l_ac].mrbb002,g_mrbb_d[l_ac].mrbb003, 
                      g_mrbb_d[l_ac].mrbb004,g_mrbb_d[l_ac].mrbb005,g_mrbb_d[l_ac].mrbb006,g_mrbb_d[l_ac].mrbb007, 
                      g_mrbb_d[l_ac].mrbb008,g_mrbb_d[l_ac].mrbb009,g_mrbb_d[l_ac].mrbb010,g_mrbb_d[l_ac].mrbb011, 
                      g_mrbb_d[l_ac].mrbb012,g_mrbb_d[l_ac].mrbb013
                  IF SQLCA.SQLCODE THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = g_mrbb_d_t.mrbb002,":",SQLERRMESSAGE 
                     LET g_errparam.code = SQLCA.SQLCODE 
                     LET g_errparam.popup = TRUE 
                     CALL cl_err()
                     LET l_lock_sw = "Y"
                  END IF
                  
                  #遮罩相關處理
                  LET g_mrbb_d_mask_o[l_ac].* =  g_mrbb_d[l_ac].*
                  CALL amrm200_mrbb_t_mask()
                  LET g_mrbb_d_mask_n[l_ac].* =  g_mrbb_d[l_ac].*
                  
                  LET g_bfill = "N"
                  CALL amrm200_show()
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
            INITIALIZE g_mrbb_d[l_ac].* TO NULL 
            INITIALIZE g_mrbb_d_t.* TO NULL 
            INITIALIZE g_mrbb_d_o.* TO NULL 
            #公用欄位給值(單身)
            #應用 a14 樣板自動產生(Version:5)    
      #公用欄位新增給值  
      LET g_mrbb_d[l_ac].mrbbstus = 'N'
 
 
 
            #自定義預設值
                  LET g_mrbb_d[l_ac].mrbbstus = "Y"
      LET g_mrbb_d[l_ac].mrbb005 = "0"
      LET g_mrbb_d[l_ac].mrbb010 = "3"
      LET g_mrbb_d[l_ac].mrbb013 = "N"
 
            #add-point:modify段before備份 name="input.body.insert.before_bak"
            
            #end add-point
            LET g_mrbb_d_t.* = g_mrbb_d[l_ac].*     #新輸入資料
            LET g_mrbb_d_o.* = g_mrbb_d[l_ac].*     #新輸入資料
            CALL cl_show_fld_cont()
            CALL amrm200_set_entry_b(l_cmd)
            #add-point:modify段after_set_entry_b name="input.body.insert.after_set_entry_b"
            
            #end add-point
            CALL amrm200_set_no_entry_b(l_cmd)
            IF lb_reproduce THEN
               LET lb_reproduce = FALSE
               LET g_mrbb_d[li_reproduce_target].* = g_mrbb_d[li_reproduce].*
 
               LET g_mrbb_d[li_reproduce_target].mrbb002 = NULL
 
            END IF
            
 
            #add-point:modify段before insert name="input.body.before_insert"
            SELECT MAX(mrbb002) + 1 INTO g_mrbb_d[l_ac].mrbb002 FROM mrbb_t
             WHERE mrbbent = g_enterprise AND mrbbsite = g_site AND mrbb001 = g_mrba_m.mrba001
            IF cl_null(g_mrbb_d[l_ac].mrbb002) THEN LET g_mrbb_d[l_ac].mrbb002 = 1 END IF
            
            LET g_mrbb_d_t.* = g_mrbb_d[l_ac].*
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
            SELECT COUNT(1) INTO l_count FROM mrbb_t 
             WHERE mrbbent = g_enterprise AND mrbbsite = g_site AND mrbb001 = g_mrba_m.mrba001
 
               AND mrbb002 = g_mrbb_d[l_ac].mrbb002
 
                
            #資料未重複, 插入新增資料
            IF l_count = 0 THEN 
               #add-point:單身新增前 name="input.body.b_insert"
               
               #end add-point
            
               #同步新增到同層的table
                              INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_mrba_m.mrba001
               LET gs_keys[2] = g_mrbb_d[g_detail_idx].mrbb002
               CALL amrm200_insert_b('mrbb_t',gs_keys,"'1'")
                           
               #add-point:單身新增後 name="input.body.a_insert"
               
               #end add-point
            ELSE    
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = 'INSERT' 
               LET g_errparam.code = "std-00006" 
               LET g_errparam.popup = TRUE 
               INITIALIZE g_mrbb_d[l_ac].* TO NULL
               CALL s_transaction_end('N','0')
               CALL cl_err()
               CANCEL INSERT
            END IF
 
            IF SQLCA.SQLCODE THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "mrbb_t:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE 
               LET g_errparam.popup = TRUE 
               CALL s_transaction_end('N','0')                    
               CALL cl_err()
               CANCEL INSERT
            ELSE
               #先刷新資料
               #CALL amrm200_b_fill()
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
               LET gs_keys[01] = g_mrba_m.mrba001
 
               LET gs_keys[gs_keys.getLength()+1] = g_mrbb_d_t.mrbb002
 
            
               #刪除同層單身
               IF NOT amrm200_delete_b('mrbb_t',gs_keys,"'1'") THEN
                  CALL s_transaction_end('N','0')
                  CLOSE amrm200_bcl
                  CANCEL DELETE
               END IF
    
               #刪除下層單身
               IF NOT amrm200_key_delete_b(gs_keys,'mrbb_t') THEN
                  CALL s_transaction_end('N','0')
                  CLOSE amrm200_bcl
                  CANCEL DELETE
               END IF
               
               #刪除多語言
               
 
               
               #add-point:單身刪除中 name="input.body.m_delete"
               
               #end add-point 
               
               CALL s_transaction_end('Y','0')
               CLOSE amrm200_bcl
            
               LET g_rec_b = g_rec_b-1
               #add-point:單身刪除後 name="input.body.a_delete"
               
               #end add-point
               LET l_count = g_mrbb_d.getLength()
               
               #add-point:單身刪除後(<>d) name="input.body.after_delete"
               
               #end add-point
            END IF
 
         AFTER DELETE
            #如果是最後一筆
            IF l_ac = (g_mrbb_d.getLength() + 1) THEN
               CALL FGL_SET_ARR_CURR(l_ac-1)
            END IF
 
                  #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mrbbstus
            #add-point:BEFORE FIELD mrbbstus name="input.b.page1.mrbbstus"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mrbbstus
            
            #add-point:AFTER FIELD mrbbstus name="input.a.page1.mrbbstus"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mrbbstus
            #add-point:ON CHANGE mrbbstus name="input.g.page1.mrbbstus"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mrbb002
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_mrbb_d[l_ac].mrbb002,"0","0","","","azz-00079",1) THEN
               NEXT FIELD mrbb002
            END IF 
 
 
 
            #add-point:AFTER FIELD mrbb002 name="input.a.page1.mrbb002"
            #此段落由子樣板a05產生
            IF  g_mrba_m.mrba001 IS NOT NULL AND g_mrbb_d[g_detail_idx].mrbb002 IS NOT NULL THEN 
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_mrba_m.mrba001 != g_mrba001_t OR g_mrbb_d[g_detail_idx].mrbb002 != g_mrbb_d_t.mrbb002)) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM mrbb_t WHERE "||"mrbbent = '" ||g_enterprise|| "' AND mrbbsite = '" ||g_site|| "' AND "||"mrbb001 = '"||g_mrba_m.mrba001 ||"' AND "|| "mrbb002 = '"||g_mrbb_d[g_detail_idx].mrbb002 ||"'",'std-00004',0) THEN 
                     LET g_mrbb_d[g_detail_idx].mrbb002 = g_mrbb_d_t.mrbb002
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mrbb002
            #add-point:BEFORE FIELD mrbb002 name="input.b.page1.mrbb002"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mrbb002
            #add-point:ON CHANGE mrbb002 name="input.g.page1.mrbb002"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mrbb003
            
            #add-point:AFTER FIELD mrbb003 name="input.a.page1.mrbb003"
            CALL amrm200_mrbb003_desc(g_mrbb_d[l_ac].mrbb003)
            IF NOT cl_null(g_mrbb_d[l_ac].mrbb003) THEN
               IF NOT s_azzi650_chk_exist('1104',g_mrbb_d[l_ac].mrbb003) THEN
                  LET g_mrbb_d[l_ac].mrbb003 = g_mrbb_d_t.mrbb003
                  CALL amrm200_mrbb003_desc(g_mrbb_d[l_ac].mrbb003)
                  NEXT FIELD CURRENT 
               END IF
            END IF
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mrbb003
            #add-point:BEFORE FIELD mrbb003 name="input.b.page1.mrbb003"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mrbb003
            #add-point:ON CHANGE mrbb003 name="input.g.page1.mrbb003"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mrbb004
            
            #add-point:AFTER FIELD mrbb004 name="input.a.page1.mrbb004"
            CALL amrm200_mrbb004_desc(g_mrbb_d[l_ac].mrbb004)
            IF NOT cl_null(g_mrbb_d[l_ac].mrbb004) THEN
               INITIALIZE g_chkparam.* TO NULL
                           
               LET g_chkparam.arg1 = g_mrbb_d[l_ac].mrbb004
               #160318-00025#6--add--str
               LET g_errshow = TRUE 
               LET g_chkparam.err_str[1] = "amr-00009:sub-01302|amri007|",cl_get_progname("amri007",g_lang,"2"),"|:EXEPROGamri007"
               #160318-00025#6--add--end
               IF NOT cl_chk_exist("v_mraa001") THEN
                  LET g_mrbb_d[l_ac].mrbb004 = g_mrbb_d_t.mrbb004
                  CALL amrm200_mrbb004_desc(g_mrbb_d[l_ac].mrbb004)
                  NEXT FIELD CURRENT 
               END IF
            END IF
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mrbb004
            #add-point:BEFORE FIELD mrbb004 name="input.b.page1.mrbb004"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mrbb004
            #add-point:ON CHANGE mrbb004 name="input.g.page1.mrbb004"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mrbb005
            #add-point:BEFORE FIELD mrbb005 name="input.b.page1.mrbb005"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mrbb005
            
            #add-point:AFTER FIELD mrbb005 name="input.a.page1.mrbb005"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mrbb005
            #add-point:ON CHANGE mrbb005 name="input.g.page1.mrbb005"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mrbb006
            
            #add-point:AFTER FIELD mrbb006 name="input.a.page1.mrbb006"
            CALL amrm200_mrbb006_desc(g_mrbb_d[l_ac].mrbb006)
            IF NOT cl_null(g_mrbb_d[l_ac].mrbb006) THEN
                INITIALIZE g_chkparam.* TO NULL
                LET g_chkparam.arg1 = g_mrbb_d[l_ac].mrbb006
                IF g_mrbb_d[l_ac].mrbb005 = '0' THEN
                   LET g_chkparam.arg2 = g_today
                   #160318-00025#6--add--str
                   LET g_errshow = TRUE 
                   LET g_chkparam.err_str[1] = "aoo-00029:sub-01302|aooi125|",cl_get_progname("aooi125",g_lang,"2"),"|:EXEPROGaooi125"
                   #160318-00025#6--add--end
                   IF NOT cl_chk_exist("v_ooeg001") THEN
                      LET g_mrbb_d[l_ac].mrbb006 = g_mrbb_d_t.mrbb006
                      CALL amrm200_mrbb006_desc(g_mrbb_d[l_ac].mrbb006)
                      NEXT FIELD CURRENT
                   END IF
                END IF
                IF g_mrbb_d[l_ac].mrbb005 = '1' THEN
                   IF NOT cl_chk_exist("v_pmaa001_1") THEN
                      LET g_mrbb_d[l_ac].mrbb006 = g_mrbb_d_t.mrbb006
                      CALL amrm200_mrbb006_desc(g_mrbb_d[l_ac].mrbb006)
                      NEXT FIELD CURRENT
                   END IF
                END IF
            END IF

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mrbb006
            #add-point:BEFORE FIELD mrbb006 name="input.b.page1.mrbb006"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mrbb006
            #add-point:ON CHANGE mrbb006 name="input.g.page1.mrbb006"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mrbb007
            #add-point:BEFORE FIELD mrbb007 name="input.b.page1.mrbb007"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mrbb007
            
            #add-point:AFTER FIELD mrbb007 name="input.a.page1.mrbb007"
            IF NOT cl_null(g_mrbb_d[l_ac].mrbb007) THEN
               CALL s_amri007_get_next_date(g_site,g_mrbb_d[l_ac].mrbb004,g_mrbb_d[l_ac].mrbb007) RETURNING g_success,g_errno,g_mrbb_d[l_ac].mrbb008
               IF NOT g_success  THEN
                  IF NOT cl_null(g_errno) THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = g_errno
                     LET g_errparam.extend = ''
                     LET g_errparam.popup = TRUE
                     CALL cl_err()

                  END IF
                  LET g_mrbb_d[l_ac].mrbb007 = g_mrbb_d_t.mrbb007
                  NEXT FIELD CURRENT
               END IF
               DISPLAY BY NAME g_mrbb_d[l_ac].mrbb008
               IF NOT amrm200_mrbb007_mrbb008_chk() THEN
                  LET g_mrbb_d[l_ac].mrbb007 = g_mrbb_d_t.mrbb007
                  NEXT FIELD CURRENT
               END IF
            END IF
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mrbb007
            #add-point:ON CHANGE mrbb007 name="input.g.page1.mrbb007"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mrbb008
            #add-point:BEFORE FIELD mrbb008 name="input.b.page1.mrbb008"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mrbb008
            
            #add-point:AFTER FIELD mrbb008 name="input.a.page1.mrbb008"
            IF NOT cl_null(g_mrbb_d[l_ac].mrbb008) THEN   
               IF NOT amrm200_mrbb007_mrbb008_chk() THEN
                  LET g_mrbb_d[l_ac].mrbb008 = g_mrbb_d_t.mrbb008
                  NEXT FIELD CURRENT
               END IF
            END IF
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mrbb008
            #add-point:ON CHANGE mrbb008 name="input.g.page1.mrbb008"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mrbb009
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_mrbb_d[l_ac].mrbb009,"0","1","","","azz-00079",1) THEN
               NEXT FIELD mrbb009
            END IF 
 
 
 
            #add-point:AFTER FIELD mrbb009 name="input.a.page1.mrbb009"
            IF NOT cl_null(g_mrbb_d[l_ac].mrbb009) THEN 
            END IF 

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mrbb009
            #add-point:BEFORE FIELD mrbb009 name="input.b.page1.mrbb009"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mrbb009
            #add-point:ON CHANGE mrbb009 name="input.g.page1.mrbb009"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mrbb010
            #add-point:BEFORE FIELD mrbb010 name="input.b.page1.mrbb010"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mrbb010
            
            #add-point:AFTER FIELD mrbb010 name="input.a.page1.mrbb010"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mrbb010
            #add-point:ON CHANGE mrbb010 name="input.g.page1.mrbb010"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mrbb011
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_mrbb_d[l_ac].mrbb011,"0","1","","","azz-00079",1) THEN
               NEXT FIELD mrbb011
            END IF 
 
 
 
            #add-point:AFTER FIELD mrbb011 name="input.a.page1.mrbb011"
            IF NOT cl_null(g_mrbb_d[l_ac].mrbb011) THEN 
            END IF 

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mrbb011
            #add-point:BEFORE FIELD mrbb011 name="input.b.page1.mrbb011"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mrbb011
            #add-point:ON CHANGE mrbb011 name="input.g.page1.mrbb011"
 
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mrbb012
            
            #add-point:AFTER FIELD mrbb012 name="input.a.page1.mrbb012"
            CALL amrm200_mrbb012_desc(g_mrbb_d[l_ac].mrbb012)
            IF NOT cl_null(g_mrbb_d[l_ac].mrbb012) THEN
               INITIALIZE g_chkparam.* TO NULL
 
               LET g_chkparam.arg1 = g_mrbb_d[l_ac].mrbb012
               #160318-00025#6--add--str
               LET g_errshow = TRUE 
               LET g_chkparam.err_str[1] = "aim-00070:sub-01302|aooi130|",cl_get_progname("aooi130",g_lang,"2"),"|:EXEPROGaooi130"
               #160318-00025#6--add--end
               IF NOT cl_chk_exist("v_ooag001") THEN
                  LET g_mrbb_d[l_ac].mrbb012 = g_mrbb_d_t.mrbb012
                  CALL amrm200_mrbb012_desc(g_mrbb_d[l_ac].mrbb012)
                  NEXT FIELD CURRENT
               END IF
            END IF
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mrbb012
            #add-point:BEFORE FIELD mrbb012 name="input.b.page1.mrbb012"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mrbb012
            #add-point:ON CHANGE mrbb012 name="input.g.page1.mrbb012"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mrbb013
            #add-point:BEFORE FIELD mrbb013 name="input.b.page1.mrbb013"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mrbb013
            
            #add-point:AFTER FIELD mrbb013 name="input.a.page1.mrbb013"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mrbb013
            #add-point:ON CHANGE mrbb013 name="input.g.page1.mrbb013"
            
            #END add-point 
 
 
 
                  #Ctrlp:input.c.page1.mrbbstus
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mrbbstus
            #add-point:ON ACTION controlp INFIELD mrbbstus name="input.c.page1.mrbbstus"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.mrbb002
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mrbb002
            #add-point:ON ACTION controlp INFIELD mrbb002 name="input.c.page1.mrbb002"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.mrbb003
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mrbb003
            #add-point:ON ACTION controlp INFIELD mrbb003 name="input.c.page1.mrbb003"
#此段落由子樣板a07產生            
            #開窗i段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
			LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_mrbb_d[l_ac].mrbb003             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "1104" #

            CALL q_oocq002()                                #呼叫開窗

            LET g_mrbb_d[l_ac].mrbb003 = g_qryparam.return1              #將開窗取得的值回傳到變數

            DISPLAY g_mrbb_d[l_ac].mrbb003 TO mrbb003              #顯示到畫面上
            CALL amrm200_mrbb003_desc(g_mrbb_d[l_ac].mrbb003)
            NEXT FIELD mrbb003                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.page1.mrbb004
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mrbb004
            #add-point:ON ACTION controlp INFIELD mrbb004 name="input.c.page1.mrbb004"
#此段落由子樣板a07產生            
            #開窗i段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
			LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_mrbb_d[l_ac].mrbb004             #給予default值

            #給予arg

            CALL q_mraa001()                                #呼叫開窗

            LET g_mrbb_d[l_ac].mrbb004 = g_qryparam.return1              #將開窗取得的值回傳到變數

            DISPLAY g_mrbb_d[l_ac].mrbb004 TO mrbb004              #顯示到畫面上
            CALL amrm200_mrbb004_desc(g_mrbb_d[l_ac].mrbb004)
            NEXT FIELD mrbb004                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.page1.mrbb005
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mrbb005
            #add-point:ON ACTION controlp INFIELD mrbb005 name="input.c.page1.mrbb005"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.mrbb006
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mrbb006
            #add-point:ON ACTION controlp INFIELD mrbb006 name="input.c.page1.mrbb006"
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
			LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_mrbb_d[l_ac].mrbb006             #給予default值

            #給予arg
            IF g_mrbb_d[l_ac].mrbb005 = '0' THEN
               LET g_qryparam.arg1 = g_today 
               CALL q_ooeg001()                                #呼叫開窗
            END IF
            IF g_mrbb_d[l_ac].mrbb005 = '1' THEN
               CALL q_pmaa001_3() 
            END IF

            LET g_mrbb_d[l_ac].mrbb006 = g_qryparam.return1              #將開窗取得的值回傳到變數

            DISPLAY g_mrbb_d[l_ac].mrbb006 TO mrbb006              #顯示到畫面上
            CALL amrm200_mrbb006_desc(g_mrbb_d[l_ac].mrbb006)
            NEXT FIELD mrbb006 
            #END add-point
 
 
         #Ctrlp:input.c.page1.mrbb007
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mrbb007
            #add-point:ON ACTION controlp INFIELD mrbb007 name="input.c.page1.mrbb007"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.mrbb008
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mrbb008
            #add-point:ON ACTION controlp INFIELD mrbb008 name="input.c.page1.mrbb008"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.mrbb009
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mrbb009
            #add-point:ON ACTION controlp INFIELD mrbb009 name="input.c.page1.mrbb009"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.mrbb010
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mrbb010
            #add-point:ON ACTION controlp INFIELD mrbb010 name="input.c.page1.mrbb010"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.mrbb011
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mrbb011
            #add-point:ON ACTION controlp INFIELD mrbb011 name="input.c.page1.mrbb011"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.mrbb012
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mrbb012
            #add-point:ON ACTION controlp INFIELD mrbb012 name="input.c.page1.mrbb012"
#此段落由子樣板a07產生            
            #開窗i段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
			LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_mrbb_d[l_ac].mrbb012             #給予default值

            #給予arg

            CALL q_ooag001()                                #呼叫開窗

            LET g_mrbb_d[l_ac].mrbb012 = g_qryparam.return1              #將開窗取得的值回傳到變數

            DISPLAY g_mrbb_d[l_ac].mrbb012 TO mrbb012              #顯示到畫面上
            CALL amrm200_mrbb012_desc(g_mrbb_d[l_ac].mrbb012)
            NEXT FIELD mrbb012                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.page1.mrbb013
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mrbb013
            #add-point:ON ACTION controlp INFIELD mrbb013 name="input.c.page1.mrbb013"
            
            #END add-point
 
 
 
 
         ON ROW CHANGE
            IF INT_FLAG THEN
               LET INT_FLAG = 0
               LET g_mrbb_d[l_ac].* = g_mrbb_d_t.*
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code = 9001 
               LET g_errparam.popup = FALSE 
               CLOSE amrm200_bcl
               CALL s_transaction_end('N','0')
               CALL cl_err()
               EXIT DIALOG 
            END IF
              
            IF l_lock_sw = 'Y' THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = g_mrbb_d[l_ac].mrbb002 
               LET g_errparam.code = -263 
               LET g_errparam.popup = TRUE 
               CALL cl_err()
               LET g_mrbb_d[l_ac].* = g_mrbb_d_t.*
            ELSE
            
               #add-point:單身修改前 name="input.body.b_update"
               
               #end add-point
               
               #寫入修改者/修改日期資訊(單身)
      
               #將遮罩欄位還原
               CALL amrm200_mrbb_t_mask_restore('restore_mask_o')
      
               UPDATE mrbb_t SET (mrbb001,mrbbstus,mrbb002,mrbb003,mrbb004,mrbb005,mrbb006,mrbb007,mrbb008, 
                   mrbb009,mrbb010,mrbb011,mrbb012,mrbb013) = (g_mrba_m.mrba001,g_mrbb_d[l_ac].mrbbstus, 
                   g_mrbb_d[l_ac].mrbb002,g_mrbb_d[l_ac].mrbb003,g_mrbb_d[l_ac].mrbb004,g_mrbb_d[l_ac].mrbb005, 
                   g_mrbb_d[l_ac].mrbb006,g_mrbb_d[l_ac].mrbb007,g_mrbb_d[l_ac].mrbb008,g_mrbb_d[l_ac].mrbb009, 
                   g_mrbb_d[l_ac].mrbb010,g_mrbb_d[l_ac].mrbb011,g_mrbb_d[l_ac].mrbb012,g_mrbb_d[l_ac].mrbb013) 
 
                WHERE mrbbent = g_enterprise AND mrbbsite = g_site AND mrbb001 = g_mrba_m.mrba001 
 
                  AND mrbb002 = g_mrbb_d_t.mrbb002 #項次   
 
                  
               #add-point:單身修改中 name="input.body.m_update"
               
               #end add-point
               CASE
                  WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
                     LET g_mrbb_d[l_ac].* = g_mrbb_d_t.*
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "mrbb_t" 
                     LET g_errparam.code = "std-00009" 
                     LET g_errparam.popup = TRUE 
                     CALL s_transaction_end('N','0')
                     CALL cl_err()
                     
                  WHEN SQLCA.SQLCODE #其他錯誤
                     LET g_mrbb_d[l_ac].* = g_mrbb_d_t.*  
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "mrbb_t:",SQLERRMESSAGE 
                     LET g_errparam.code = SQLCA.SQLCODE 
                     LET g_errparam.popup = TRUE 
                     CALL s_transaction_end('N','0')
                     CALL cl_err()                   
                     
                  OTHERWISE
                     #資料多語言用-增/改
                     
                                    INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_mrba_m.mrba001
               LET gs_keys_bak[1] = g_mrba001_t
               LET gs_keys[2] = g_mrbb_d[g_detail_idx].mrbb002
               LET gs_keys_bak[2] = g_mrbb_d_t.mrbb002
               CALL amrm200_update_b('mrbb_t',gs_keys,gs_keys_bak,"'1'")
               END CASE
 
               #將遮罩欄位進行遮蔽
               CALL amrm200_mrbb_t_mask_restore('restore_mask_n')
               
               #判斷key是否有改變
               INITIALIZE gs_keys TO NULL
               IF NOT(g_mrbb_d[g_detail_idx].mrbb002 = g_mrbb_d_t.mrbb002 
 
                  ) THEN
                  LET gs_keys[01] = g_mrba_m.mrba001
 
                  LET gs_keys[gs_keys.getLength()+1] = g_mrbb_d_t.mrbb002
 
                  CALL amrm200_key_update_b(gs_keys,'mrbb_t')
               END IF
               
               #修改歷程記錄(單身修改)
               LET g_log1 = util.JSON.stringify(g_mrba_m),util.JSON.stringify(g_mrbb_d_t)
               LET g_log2 = util.JSON.stringify(g_mrba_m),util.JSON.stringify(g_mrbb_d[l_ac])
               IF NOT cl_log_modified_record_d(g_log1,g_log2) THEN 
                  CALL s_transaction_end('N','0')
               END IF
               
               #add-point:單身修改後 name="input.body.a_update"
               
               #end add-point
 
            END IF
            
         AFTER ROW
            #add-point:單身after_row name="input.body.after_row"
            
            #end add-point
            CALL amrm200_unlock_b("mrbb_t","'1'")
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
               LET g_mrbb_d[li_reproduce_target].* = g_mrbb_d[li_reproduce].*
 
               LET g_mrbb_d[li_reproduce_target].mrbb002 = NULL
 
            ELSE
               CALL FGL_SET_ARR_CURR(g_mrbb_d.getLength()+1)
               LET lb_reproduce = TRUE
               LET li_reproduce = l_ac
               LET li_reproduce_target = g_mrbb_d.getLength()+1
            END IF
            
         #ON ACTION cancel
         #   LET INT_FLAG = 1
         #   LET g_detail_idx = 1
         #   EXIT DIALOG 
 
      END INPUT
      
      INPUT ARRAY g_mrbb2_d FROM s_detail2.*
         ATTRIBUTE(COUNT = g_rec_b,WITHOUT DEFAULTS, #MAXCOUNT = g_max_rec,
                 INSERT ROW = l_allow_insert, #此頁面insert功能由產生器控制, 手動之設定無效! 
 
                 DELETE ROW = l_allow_delete,
                 APPEND ROW = l_allow_insert)
                 
         #自訂ACTION(detail_input,page_2)
         
         
         BEFORE INPUT
            #add-point:資料輸入前 name="input.body2.before_input2"
            
            #end add-point
            IF g_insert = 'Y' AND NOT cl_null(g_insert) THEN 
              CALL FGL_SET_ARR_CURR(g_mrbb2_d.getLength()+1) 
              LET g_insert = 'N' 
           END IF 
 
            CALL amrm200_b_fill()
            #如果一直都在單身1則控制筆數位置
            IF g_loc = 'd' AND g_rec_b != 0 THEN
               CALL FGL_SET_ARR_CURR(g_idx_group.getValue("'2',"))
            END IF
            LET g_loc = 'd'
            LET g_rec_b = g_mrbb2_d.getLength()
            #add-point:資料輸入前 name="input.body2.before_input"
            
            #end add-point
            
         BEFORE INSERT
            IF s_transaction_chk("N",0) THEN
               CALL s_transaction_begin()
            END IF
            LET l_insert = TRUE
            LET l_n = ARR_COUNT()
            LET l_cmd = 'a'
            INITIALIZE g_mrbb2_d[l_ac].* TO NULL 
            INITIALIZE g_mrbb2_d_t.* TO NULL 
            INITIALIZE g_mrbb2_d_o.* TO NULL 
            #公用欄位給值(單身2)
            
            #自定義預設值(單身2)
            
            #add-point:modify段before備份 name="input.body2.insert.before_bak"
            
            #end add-point
            LET g_mrbb2_d_t.* = g_mrbb2_d[l_ac].*     #新輸入資料
            LET g_mrbb2_d_o.* = g_mrbb2_d[l_ac].*     #新輸入資料
            CALL cl_show_fld_cont()
            CALL amrm200_set_entry_b(l_cmd)
            #add-point:modify段after_set_entry_b name="input.body2.insert.after_set_entry_b"
            
            #end add-point
            CALL amrm200_set_no_entry_b(l_cmd)
            IF lb_reproduce THEN
               LET lb_reproduce = FALSE
               LET g_mrbb2_d[li_reproduce_target].* = g_mrbb2_d[li_reproduce].*
 
               LET g_mrbb2_d[li_reproduce_target].mrbc002 = NULL
            END IF
            
 
            #add-point:modify段before insert name="input.body2.before_insert"
            LET g_mrbb2_d[l_ac].mrbc011 = g_today
            LET g_mrbb2_d_t.* = g_mrbb2_d[l_ac].* 
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
            OPEN amrm200_cl USING g_enterprise, g_site,g_mrba_m.mrba001
            IF SQLCA.SQLCODE THEN   #(ver:78)
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "OPEN amrm200_cl:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE   #(ver:78)
               LET g_errparam.popup = TRUE 
               CLOSE amrm200_cl
               CALL s_transaction_end('N','0')
               CALL cl_err()
               RETURN
            END IF
            
            LET g_rec_b = g_mrbb2_d.getLength()
            
            IF g_rec_b >= l_ac 
               AND g_mrbb2_d[l_ac].mrbc002 IS NOT NULL
            THEN 
               LET l_cmd='u'
               LET g_mrbb2_d_t.* = g_mrbb2_d[l_ac].*  #BACKUP
               LET g_mrbb2_d_o.* = g_mrbb2_d[l_ac].*  #BACKUP
               CALL amrm200_set_entry_b(l_cmd)
               #add-point:modify段after_set_entry_b name="input.body2.after_set_entry_b"
               
               #end add-point  
               CALL amrm200_set_no_entry_b(l_cmd)
               IF NOT amrm200_lock_b("mrbc_t","'2'") THEN
                  LET l_lock_sw='Y'
               ELSE
                  FETCH amrm200_bcl2 INTO g_mrbb2_d[l_ac].mrbc002,g_mrbb2_d[l_ac].mrbc003,g_mrbb2_d[l_ac].mrbc004, 
                      g_mrbb2_d[l_ac].mrbc005,g_mrbb2_d[l_ac].mrbc006,g_mrbb2_d[l_ac].mrbc007,g_mrbb2_d[l_ac].mrbc008, 
                      g_mrbb2_d[l_ac].mrbc009,g_mrbb2_d[l_ac].mrbc010,g_mrbb2_d[l_ac].mrbc011
                  IF SQLCA.SQLCODE THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = SQLERRMESSAGE  
                     LET g_errparam.code = SQLCA.SQLCODE 
                     LET g_errparam.popup = TRUE 
                     CALL cl_err()
                     LET l_lock_sw = "Y"
                  END IF
                  
                  #遮罩相關處理
                  LET g_mrbb2_d_mask_o[l_ac].* =  g_mrbb2_d[l_ac].*
                  CALL amrm200_mrbc_t_mask()
                  LET g_mrbb2_d_mask_n[l_ac].* =  g_mrbb2_d[l_ac].*
                  
                  LET g_bfill = "N"
                  CALL amrm200_show()
                  LET g_bfill = "Y"
                  
                  CALL cl_show_fld_cont()
               END IF
            ELSE
               LET l_cmd='a'
            END IF
            #add-point:modify段before row name="input.body2.before_row"
            
            #end add-point  
            #其他table資料備份(確定是否更改用)
            
 
            #其他table進行lock
            
 
            
         BEFORE DELETE                            #是否取消單身
            IF l_cmd = 'a' THEN
               LET l_cmd='d'
               #add-point:單身AFTER DELETE (=d) name="input.body2.after_delete_d"
               
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
               
               #end add-point    
                  
               #取得該筆資料key值
               INITIALIZE gs_keys TO NULL
               LET gs_keys[01] = g_mrba_m.mrba001
               LET gs_keys[gs_keys.getLength()+1] = g_mrbb2_d_t.mrbc002
            
               #刪除同層單身
               IF NOT amrm200_delete_b('mrbc_t',gs_keys,"'2'") THEN
                  CALL s_transaction_end('N','0')
                  CLOSE amrm200_bcl
                  CANCEL DELETE
               END IF
    
               #刪除下層單身
               IF NOT amrm200_key_delete_b(gs_keys,'mrbc_t') THEN
                  CALL s_transaction_end('N','0')
                  CLOSE amrm200_bcl
                  CANCEL DELETE
               END IF
               
               #刪除多語言
               
 
               
               #add-point:單身2刪除中 name="input.body2.m_delete"
               
               #end add-point    
               
               CALL s_transaction_end('Y','0')
               CLOSE amrm200_bcl
 
               LET g_rec_b = g_rec_b-1
               #add-point:單身2刪除後 name="input.body2.a_delete"
               
               #end add-point
               LET l_count = g_mrbb_d.getLength()
               
               #add-point:單身刪除後(<>d) name="input.body2.after_delete"
               
               #end add-point
            END IF 
 
         AFTER DELETE
            #如果是最後一筆
            IF l_ac = (g_mrbb2_d.getLength() + 1) THEN
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
            SELECT COUNT(1) INTO l_count FROM mrbc_t 
             WHERE mrbcent = g_enterprise AND mrbcsite = g_site AND mrbc001 = g_mrba_m.mrba001
               AND mrbc002 = g_mrbb2_d[l_ac].mrbc002
                
            #資料未重複, 插入新增資料
            IF l_count = 0 THEN 
               #add-point:單身2新增前 name="input.body2.b_insert"
               
               #end add-point
            
                              INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_mrba_m.mrba001
               LET gs_keys[2] = g_mrbb2_d[g_detail_idx].mrbc002
               CALL amrm200_insert_b('mrbc_t',gs_keys,"'2'")
                           
               #add-point:單身新增後2 name="input.body2.a_insert"
               
               #end add-point
            ELSE    
               INITIALIZE g_mrbb_d[l_ac].* TO NULL
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
               LET g_errparam.extend = "mrbc_t:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE 
               LET g_errparam.popup = TRUE 
               CALL s_transaction_end('N','0')                    
               CALL cl_err()
               CANCEL INSERT
            ELSE
               #先刷新資料
               #CALL amrm200_b_fill()
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
               LET g_mrbb2_d[l_ac].* = g_mrbb2_d_t.*
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code = 9001 
               LET g_errparam.popup = FALSE 
               CLOSE amrm200_bcl2
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
               LET g_mrbb2_d[l_ac].* = g_mrbb2_d_t.*
            ELSE
               #add-point:單身page2修改前 name="input.body2.b_update"
               
               #end add-point
               
               #寫入修改者/修改日期資訊(單身2)
               
               
               #將遮罩欄位還原
               CALL amrm200_mrbc_t_mask_restore('restore_mask_o')
                              
               UPDATE mrbc_t SET (mrbc001,mrbc002,mrbc003,mrbc004,mrbc005,mrbc006,mrbc007,mrbc008,mrbc009, 
                   mrbc010,mrbc011) = (g_mrba_m.mrba001,g_mrbb2_d[l_ac].mrbc002,g_mrbb2_d[l_ac].mrbc003, 
                   g_mrbb2_d[l_ac].mrbc004,g_mrbb2_d[l_ac].mrbc005,g_mrbb2_d[l_ac].mrbc006,g_mrbb2_d[l_ac].mrbc007, 
                   g_mrbb2_d[l_ac].mrbc008,g_mrbb2_d[l_ac].mrbc009,g_mrbb2_d[l_ac].mrbc010,g_mrbb2_d[l_ac].mrbc011)  
                   #自訂欄位頁簽
                WHERE mrbcent = g_enterprise AND mrbcsite = g_site AND mrbc001 = g_mrba_m.mrba001
                  AND mrbc002 = g_mrbb2_d_t.mrbc002 #項次 
                  
               #add-point:單身page2修改中 name="input.body2.m_update"
               
               #end add-point
                  
               CASE
                  WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
                     LET g_mrbb2_d[l_ac].* = g_mrbb2_d_t.*
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "mrbc_t" 
                     LET g_errparam.code = "std-00009" 
                     LET g_errparam.popup = TRUE 
                     CALL s_transaction_end('N','0')
                     CALL cl_err()
                     
                  WHEN SQLCA.SQLCODE #其他錯誤
                     LET g_mrbb2_d[l_ac].* = g_mrbb2_d_t.*
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "mrbc_t:",SQLERRMESSAGE 
                     LET g_errparam.code = SQLCA.SQLCODE 
                     LET g_errparam.popup = TRUE 
                     CALL s_transaction_end('N','0')
                     CALL cl_err()
                     
                  OTHERWISE
                     #資料多語言用-增/改
                     
                                    INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_mrba_m.mrba001
               LET gs_keys_bak[1] = g_mrba001_t
               LET gs_keys[2] = g_mrbb2_d[g_detail_idx].mrbc002
               LET gs_keys_bak[2] = g_mrbb2_d_t.mrbc002
               CALL amrm200_update_b('mrbc_t',gs_keys,gs_keys_bak,"'2'")
               END CASE
               
               #將遮罩欄位進行遮蔽
               CALL amrm200_mrbc_t_mask_restore('restore_mask_n')
               
               #判斷key是否有改變
               INITIALIZE gs_keys TO NULL
               IF NOT (g_mrbb2_d[g_detail_idx].mrbc002 = g_mrbb2_d_t.mrbc002 
                  ) THEN
                  LET gs_keys[01] = g_mrba_m.mrba001
                  LET gs_keys[gs_keys.getLength()+1] = g_mrbb2_d_t.mrbc002
                  CALL amrm200_key_update_b(gs_keys,'mrbc_t')
               END IF
               
               #修改歷程記錄(單身修改)
               LET g_log1 = util.JSON.stringify(g_mrba_m),util.JSON.stringify(g_mrbb2_d_t)
               LET g_log2 = util.JSON.stringify(g_mrba_m),util.JSON.stringify(g_mrbb2_d[l_ac])
               IF NOT cl_log_modified_record_d(g_log1,g_log2) THEN 
                  CALL s_transaction_end('N','0')
               END IF
               
               #add-point:單身page2修改後 name="input.body2.a_update"
               
               #end add-point
            END IF
         
                  #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mrbc002
            #add-point:BEFORE FIELD mrbc002 name="input.b.page2.mrbc002"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mrbc002
            
            #add-point:AFTER FIELD mrbc002 name="input.a.page2.mrbc002"
            #此段落由子樣板a05產生
            IF  g_mrba_m.mrba001 IS NOT NULL AND g_mrbb2_d[g_detail_idx].mrbc002 IS NOT NULL THEN 
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_mrba_m.mrba001 != g_mrba001_t OR g_mrbb2_d[g_detail_idx].mrbc002 != g_mrbb2_d_t.mrbc002)) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM mrbc_t WHERE "||"mrbcent = '" ||g_enterprise|| "' AND mrbcsite = '" ||g_site|| "' AND "||"mrbc001 = '"||g_mrba_m.mrba001 ||"' AND "|| "mrbc002 = '"||g_mrbb2_d[g_detail_idx].mrbc002 ||"'",'std-00004',0) THEN 
                     LET g_mrbb2_d[g_detail_idx].mrbc002 = g_mrbb2_d_t.mrbc002
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF


            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mrbc002
            #add-point:ON CHANGE mrbc002 name="input.g.page2.mrbc002"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mrbc003
            #add-point:BEFORE FIELD mrbc003 name="input.b.page2.mrbc003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mrbc003
            
            #add-point:AFTER FIELD mrbc003 name="input.a.page2.mrbc003"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mrbc003
            #add-point:ON CHANGE mrbc003 name="input.g.page2.mrbc003"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mrbc004
            #add-point:BEFORE FIELD mrbc004 name="input.b.page2.mrbc004"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mrbc004
            
            #add-point:AFTER FIELD mrbc004 name="input.a.page2.mrbc004"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mrbc004
            #add-point:ON CHANGE mrbc004 name="input.g.page2.mrbc004"
            CALL amrm200_set_entry_b('')
            CALL amrm200_set_no_entry_b('')
            IF g_mrbb2_d[l_ac].mrbc004 = '2' THEN
               LET g_mrbb2_d[l_ac].mrbc011 = g_today
            END IF
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mrbc005
            #add-point:BEFORE FIELD mrbc005 name="input.b.page2.mrbc005"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mrbc005
            
            #add-point:AFTER FIELD mrbc005 name="input.a.page2.mrbc005"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mrbc005
            #add-point:ON CHANGE mrbc005 name="input.g.page2.mrbc005"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mrbc006
            #add-point:BEFORE FIELD mrbc006 name="input.b.page2.mrbc006"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mrbc006
            
            #add-point:AFTER FIELD mrbc006 name="input.a.page2.mrbc006"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mrbc006
            #add-point:ON CHANGE mrbc006 name="input.g.page2.mrbc006"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mrbc007
            #add-point:BEFORE FIELD mrbc007 name="input.b.page2.mrbc007"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mrbc007
            
            #add-point:AFTER FIELD mrbc007 name="input.a.page2.mrbc007"
            IF NOT amrm200_mrbc007_mrbc008_compare() THEN
               LET g_mrbb2_d[l_ac].mrbc007 = g_mrbb2_d_t.mrbc007
               NEXT FIELD CURRENT
            END IF
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mrbc007
            #add-point:ON CHANGE mrbc007 name="input.g.page2.mrbc007"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mrbc008
            #add-point:BEFORE FIELD mrbc008 name="input.b.page2.mrbc008"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mrbc008
            
            #add-point:AFTER FIELD mrbc008 name="input.a.page2.mrbc008"
            IF NOT amrm200_mrbc007_mrbc008_compare() THEN
               LET g_mrbb2_d[l_ac].mrbc008 = g_mrbb2_d_t.mrbc008
               NEXT FIELD CURRENT
            END IF
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mrbc008
            #add-point:ON CHANGE mrbc008 name="input.g.page2.mrbc008"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mrbc009
            #add-point:BEFORE FIELD mrbc009 name="input.b.page2.mrbc009"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mrbc009
            
            #add-point:AFTER FIELD mrbc009 name="input.a.page2.mrbc009"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mrbc009
            #add-point:ON CHANGE mrbc009 name="input.g.page2.mrbc009"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mrbc010
            #add-point:BEFORE FIELD mrbc010 name="input.b.page2.mrbc010"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mrbc010
            
            #add-point:AFTER FIELD mrbc010 name="input.a.page2.mrbc010"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mrbc010
            #add-point:ON CHANGE mrbc010 name="input.g.page2.mrbc010"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mrbc011
            #add-point:BEFORE FIELD mrbc011 name="input.b.page2.mrbc011"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mrbc011
            
            #add-point:AFTER FIELD mrbc011 name="input.a.page2.mrbc011"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mrbc011
            #add-point:ON CHANGE mrbc011 name="input.g.page2.mrbc011"
            
            #END add-point 
 
 
 
                  #Ctrlp:input.c.page2.mrbc002
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mrbc002
            #add-point:ON ACTION controlp INFIELD mrbc002 name="input.c.page2.mrbc002"
            
            #END add-point
 
 
         #Ctrlp:input.c.page2.mrbc003
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mrbc003
            #add-point:ON ACTION controlp INFIELD mrbc003 name="input.c.page2.mrbc003"
            
            #END add-point
 
 
         #Ctrlp:input.c.page2.mrbc004
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mrbc004
            #add-point:ON ACTION controlp INFIELD mrbc004 name="input.c.page2.mrbc004"
            
            #END add-point
 
 
         #Ctrlp:input.c.page2.mrbc005
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mrbc005
            #add-point:ON ACTION controlp INFIELD mrbc005 name="input.c.page2.mrbc005"
            
            #END add-point
 
 
         #Ctrlp:input.c.page2.mrbc006
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mrbc006
            #add-point:ON ACTION controlp INFIELD mrbc006 name="input.c.page2.mrbc006"
            
            #END add-point
 
 
         #Ctrlp:input.c.page2.mrbc007
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mrbc007
            #add-point:ON ACTION controlp INFIELD mrbc007 name="input.c.page2.mrbc007"
            
            #END add-point
 
 
         #Ctrlp:input.c.page2.mrbc008
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mrbc008
            #add-point:ON ACTION controlp INFIELD mrbc008 name="input.c.page2.mrbc008"
            
            #END add-point
 
 
         #Ctrlp:input.c.page2.mrbc009
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mrbc009
            #add-point:ON ACTION controlp INFIELD mrbc009 name="input.c.page2.mrbc009"
            
            #END add-point
 
 
         #Ctrlp:input.c.page2.mrbc010
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mrbc010
            #add-point:ON ACTION controlp INFIELD mrbc010 name="input.c.page2.mrbc010"
            
            #END add-point
 
 
         #Ctrlp:input.c.page2.mrbc011
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mrbc011
            #add-point:ON ACTION controlp INFIELD mrbc011 name="input.c.page2.mrbc011"
            
            #END add-point
 
 
 
 
         AFTER ROW
            #add-point:單身page2 after_row name="input.body2.after_row"
            
            #end add-point
            LET l_ac = ARR_CURR()
            IF INT_FLAG THEN
               LET INT_FLAG = 0
               IF l_cmd = 'u' THEN
                  LET g_mrbb2_d[l_ac].* = g_mrbb2_d_t.*
               END IF
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code = 9001 
               LET g_errparam.popup = FALSE 
               CLOSE amrm200_bcl2
               CALL s_transaction_end('N','0')
               CALL cl_err()
               EXIT DIALOG 
            END IF
            
            #其他table進行unlock
            
            CALL amrm200_unlock_b("mrbc_t","'2'")
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
               LET g_mrbb2_d[li_reproduce_target].* = g_mrbb2_d[li_reproduce].*
 
               LET g_mrbb2_d[li_reproduce_target].mrbc002 = NULL
            ELSE
               CALL FGL_SET_ARR_CURR(g_mrbb2_d.getLength()+1)
               LET lb_reproduce = TRUE
               LET li_reproduce = l_ac
               LET li_reproduce_target = g_mrbb2_d.getLength()+1
            END IF
            
      END INPUT
      INPUT ARRAY g_mrbb3_d FROM s_detail3.*
         ATTRIBUTE(COUNT = g_rec_b,WITHOUT DEFAULTS, #MAXCOUNT = g_max_rec,
                 INSERT ROW = l_allow_insert, #此頁面insert功能由產生器控制, 手動之設定無效! 
 
                 DELETE ROW = l_allow_delete,
                 APPEND ROW = l_allow_insert)
                 
         #自訂ACTION(detail_input,page_3)
         
         
         BEFORE INPUT
            #add-point:資料輸入前 name="input.body3.before_input2"
            
            #end add-point
            IF g_insert = 'Y' AND NOT cl_null(g_insert) THEN 
              CALL FGL_SET_ARR_CURR(g_mrbb3_d.getLength()+1) 
              LET g_insert = 'N' 
           END IF 
 
            CALL amrm200_b_fill()
            #如果一直都在單身1則控制筆數位置
            IF g_loc = 'd' AND g_rec_b != 0 THEN
               CALL FGL_SET_ARR_CURR(g_idx_group.getValue("'3',"))
            END IF
            LET g_loc = 'd'
            LET g_rec_b = g_mrbb3_d.getLength()
            #add-point:資料輸入前 name="input.body3.before_input"
 
            #end add-point
            
         BEFORE INSERT
            IF s_transaction_chk("N",0) THEN
               CALL s_transaction_begin()
            END IF
            LET l_insert = TRUE
            LET l_n = ARR_COUNT()
            LET l_cmd = 'a'
            INITIALIZE g_mrbb3_d[l_ac].* TO NULL 
            INITIALIZE g_mrbb3_d_t.* TO NULL 
            INITIALIZE g_mrbb3_d_o.* TO NULL 
            #公用欄位給值(單身3)
            
            #自定義預設值(單身3)
                  LET g_mrbb3_d[l_ac].mrbd007 = "1"
 
            #add-point:modify段before備份 name="input.body3.insert.before_bak"
            
            #end add-point
            LET g_mrbb3_d_t.* = g_mrbb3_d[l_ac].*     #新輸入資料
            LET g_mrbb3_d_o.* = g_mrbb3_d[l_ac].*     #新輸入資料
            CALL cl_show_fld_cont()
            CALL amrm200_set_entry_b(l_cmd)
            #add-point:modify段after_set_entry_b name="input.body3.insert.after_set_entry_b"
            
            #end add-point
            CALL amrm200_set_no_entry_b(l_cmd)
            IF lb_reproduce THEN
               LET lb_reproduce = FALSE
               LET g_mrbb3_d[li_reproduce_target].* = g_mrbb3_d[li_reproduce].*
 
               LET g_mrbb3_d[li_reproduce_target].mrbd002 = NULL
            END IF
            
 
            #add-point:modify段before insert name="input.body3.before_insert"
             SELECT MAX(mrbd002) + 1 INTO g_mrbb3_d[l_ac].mrbd002 FROM mrbd_t
             WHERE mrbdent = g_enterprise AND mrbdsite = g_site AND mrbd001 = g_mrba_m.mrba001
            IF cl_null(g_mrbb3_d[l_ac].mrbd002 ) THEN LET g_mrbb3_d[l_ac].mrbd002  = 1 END IF
            
            LET g_mrbb3_d_t.* = g_mrbb3_d[l_ac].*
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
            OPEN amrm200_cl USING g_enterprise, g_site,g_mrba_m.mrba001
            IF SQLCA.SQLCODE THEN   #(ver:78)
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "OPEN amrm200_cl:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE   #(ver:78)
               LET g_errparam.popup = TRUE 
               CLOSE amrm200_cl
               CALL s_transaction_end('N','0')
               CALL cl_err()
               RETURN
            END IF
            
            LET g_rec_b = g_mrbb3_d.getLength()
            
            IF g_rec_b >= l_ac 
               AND g_mrbb3_d[l_ac].mrbd002 IS NOT NULL
            THEN 
               LET l_cmd='u'
               LET g_mrbb3_d_t.* = g_mrbb3_d[l_ac].*  #BACKUP
               LET g_mrbb3_d_o.* = g_mrbb3_d[l_ac].*  #BACKUP
               CALL amrm200_set_entry_b(l_cmd)
               #add-point:modify段after_set_entry_b name="input.body3.after_set_entry_b"
               
               #end add-point  
               CALL amrm200_set_no_entry_b(l_cmd)
               IF NOT amrm200_lock_b("mrbd_t","'3'") THEN
                  LET l_lock_sw='Y'
               ELSE
                  FETCH amrm200_bcl3 INTO g_mrbb3_d[l_ac].mrbd002,g_mrbb3_d[l_ac].mrbd003,g_mrbb3_d[l_ac].mrbd004, 
                      g_mrbb3_d[l_ac].mrbd005,g_mrbb3_d[l_ac].mrbd006,g_mrbb3_d[l_ac].mrbd007,g_mrbb3_d[l_ac].mrbd008, 
                      g_mrbb3_d[l_ac].mrbd009,g_mrbb3_d[l_ac].mrbd010
                  IF SQLCA.SQLCODE THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = SQLERRMESSAGE  
                     LET g_errparam.code = SQLCA.SQLCODE 
                     LET g_errparam.popup = TRUE 
                     CALL cl_err()
                     LET l_lock_sw = "Y"
                  END IF
                  
                  #遮罩相關處理
                  LET g_mrbb3_d_mask_o[l_ac].* =  g_mrbb3_d[l_ac].*
                  CALL amrm200_mrbd_t_mask()
                  LET g_mrbb3_d_mask_n[l_ac].* =  g_mrbb3_d[l_ac].*
                  
                  LET g_bfill = "N"
                  CALL amrm200_show()
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
               LET gs_keys[01] = g_mrba_m.mrba001
               LET gs_keys[gs_keys.getLength()+1] = g_mrbb3_d_t.mrbd002
            
               #刪除同層單身
               IF NOT amrm200_delete_b('mrbd_t',gs_keys,"'3'") THEN
                  CALL s_transaction_end('N','0')
                  CLOSE amrm200_bcl
                  CANCEL DELETE
               END IF
    
               #刪除下層單身
               IF NOT amrm200_key_delete_b(gs_keys,'mrbd_t') THEN
                  CALL s_transaction_end('N','0')
                  CLOSE amrm200_bcl
                  CANCEL DELETE
               END IF
               
               #刪除多語言
               
 
               
               #add-point:單身3刪除中 name="input.body3.m_delete"
               
               #end add-point    
               
               CALL s_transaction_end('Y','0')
               CLOSE amrm200_bcl
 
               LET g_rec_b = g_rec_b-1
               #add-point:單身3刪除後 name="input.body3.a_delete"
               
               #end add-point
               LET l_count = g_mrbb_d.getLength()
               
               #add-point:單身刪除後(<>d) name="input.body3.after_delete"
               
               #end add-point
            END IF 
 
         AFTER DELETE
            #如果是最後一筆
            IF l_ac = (g_mrbb3_d.getLength() + 1) THEN
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
            SELECT COUNT(1) INTO l_count FROM mrbd_t 
             WHERE mrbdent = g_enterprise AND mrbdsite = g_site AND mrbd001 = g_mrba_m.mrba001
               AND mrbd002 = g_mrbb3_d[l_ac].mrbd002
                
            #資料未重複, 插入新增資料
            IF l_count = 0 THEN 
               #add-point:單身3新增前 name="input.body3.b_insert"
               
               #end add-point
            
                              INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_mrba_m.mrba001
               LET gs_keys[2] = g_mrbb3_d[g_detail_idx].mrbd002
               CALL amrm200_insert_b('mrbd_t',gs_keys,"'3'")
                           
               #add-point:單身新增後3 name="input.body3.a_insert"
               
               #end add-point
            ELSE    
               INITIALIZE g_mrbb_d[l_ac].* TO NULL
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
               LET g_errparam.extend = "mrbd_t:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE 
               LET g_errparam.popup = TRUE 
               CALL s_transaction_end('N','0')                    
               CALL cl_err()
               CANCEL INSERT
            ELSE
               #先刷新資料
               #CALL amrm200_b_fill()
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
               LET g_mrbb3_d[l_ac].* = g_mrbb3_d_t.*
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code = 9001 
               LET g_errparam.popup = FALSE 
               CLOSE amrm200_bcl3
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
               LET g_mrbb3_d[l_ac].* = g_mrbb3_d_t.*
            ELSE
               #add-point:單身page3修改前 name="input.body3.b_update"
               
               #end add-point
               
               #寫入修改者/修改日期資訊(單身3)
               
               
               #將遮罩欄位還原
               CALL amrm200_mrbd_t_mask_restore('restore_mask_o')
                              
               UPDATE mrbd_t SET (mrbd001,mrbd002,mrbd003,mrbd004,mrbd005,mrbd006,mrbd007,mrbd008,mrbd009, 
                   mrbd010) = (g_mrba_m.mrba001,g_mrbb3_d[l_ac].mrbd002,g_mrbb3_d[l_ac].mrbd003,g_mrbb3_d[l_ac].mrbd004, 
                   g_mrbb3_d[l_ac].mrbd005,g_mrbb3_d[l_ac].mrbd006,g_mrbb3_d[l_ac].mrbd007,g_mrbb3_d[l_ac].mrbd008, 
                   g_mrbb3_d[l_ac].mrbd009,g_mrbb3_d[l_ac].mrbd010) #自訂欄位頁簽
                WHERE mrbdent = g_enterprise AND mrbdsite = g_site AND mrbd001 = g_mrba_m.mrba001
                  AND mrbd002 = g_mrbb3_d_t.mrbd002 #項次 
                  
               #add-point:單身page3修改中 name="input.body3.m_update"
               
               #end add-point
                  
               CASE
                  WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
                     LET g_mrbb3_d[l_ac].* = g_mrbb3_d_t.*
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "mrbd_t" 
                     LET g_errparam.code = "std-00009" 
                     LET g_errparam.popup = TRUE 
                     CALL s_transaction_end('N','0')
                     CALL cl_err()
                     
                  WHEN SQLCA.SQLCODE #其他錯誤
                     LET g_mrbb3_d[l_ac].* = g_mrbb3_d_t.*
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "mrbd_t:",SQLERRMESSAGE 
                     LET g_errparam.code = SQLCA.SQLCODE 
                     LET g_errparam.popup = TRUE 
                     CALL s_transaction_end('N','0')
                     CALL cl_err()
                     
                  OTHERWISE
                     #資料多語言用-增/改
                     
                                    INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_mrba_m.mrba001
               LET gs_keys_bak[1] = g_mrba001_t
               LET gs_keys[2] = g_mrbb3_d[g_detail_idx].mrbd002
               LET gs_keys_bak[2] = g_mrbb3_d_t.mrbd002
               CALL amrm200_update_b('mrbd_t',gs_keys,gs_keys_bak,"'3'")
               END CASE
               
               #將遮罩欄位進行遮蔽
               CALL amrm200_mrbd_t_mask_restore('restore_mask_n')
               
               #判斷key是否有改變
               INITIALIZE gs_keys TO NULL
               IF NOT (g_mrbb3_d[g_detail_idx].mrbd002 = g_mrbb3_d_t.mrbd002 
                  ) THEN
                  LET gs_keys[01] = g_mrba_m.mrba001
                  LET gs_keys[gs_keys.getLength()+1] = g_mrbb3_d_t.mrbd002
                  CALL amrm200_key_update_b(gs_keys,'mrbd_t')
               END IF
               
               #修改歷程記錄(單身修改)
               LET g_log1 = util.JSON.stringify(g_mrba_m),util.JSON.stringify(g_mrbb3_d_t)
               LET g_log2 = util.JSON.stringify(g_mrba_m),util.JSON.stringify(g_mrbb3_d[l_ac])
               IF NOT cl_log_modified_record_d(g_log1,g_log2) THEN 
                  CALL s_transaction_end('N','0')
               END IF
               
               #add-point:單身page3修改後 name="input.body3.a_update"
               
               #end add-point
            END IF
         
                  #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mrbd002
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_mrbb3_d[l_ac].mrbd002,"0","0","","","azz-00079",1) THEN
               NEXT FIELD mrbd002
            END IF 
 
 
 
            #add-point:AFTER FIELD mrbd002 name="input.a.page3.mrbd002"
            #此段落由子樣板a05產生
            IF  g_mrba_m.mrba001 IS NOT NULL AND g_mrbb3_d[g_detail_idx].mrbd002 IS NOT NULL THEN 
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_mrba_m.mrba001 != g_mrba001_t OR g_mrbb3_d[g_detail_idx].mrbd002 != g_mrbb3_d_t.mrbd002)) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM mrbd_t WHERE "||"mrbdent = '" ||g_enterprise|| "' AND mrbdsite = '" ||g_site|| "' AND "||"mrbd001 = '"||g_mrba_m.mrba001 ||"' AND "|| "mrbd002 = '"||g_mrbb3_d[g_detail_idx].mrbd002 ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mrbd002
            #add-point:BEFORE FIELD mrbd002 name="input.b.page3.mrbd002"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mrbd002
            #add-point:ON CHANGE mrbd002 name="input.g.page3.mrbd002"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mrbd003
            
            #add-point:AFTER FIELD mrbd003 name="input.a.page3.mrbd003"
            CALL amrm200_mrbd003_desc(g_mrbb3_d[l_ac].mrbd003)
            IF NOT cl_null(g_mrbb3_d[l_ac].mrbd003) THEN                  
               INITIALIZE g_chkparam.* TO NULL
               LET g_chkparam.arg1 = g_mrbb3_d[l_ac].mrbd003
#160716-00003#1-s
#                 IF NOT cl_chk_exist("v_imaa001") THEN
                  IF NOT cl_chk_exist("v_imaf001_14") THEN
#160716-00003#1-e
                     LET g_mrbb3_d[l_ac].mrbd003 = g_mrbb3_d_t.mrbd003  
                     CALL amrm200_mrbd003_desc(g_mrbb3_d[l_ac].mrbd003)
                     NEXT FIELD CURRENT
                  END IF
            END IF
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mrbd003
            #add-point:BEFORE FIELD mrbd003 name="input.b.page3.mrbd003"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mrbd003
            #add-point:ON CHANGE mrbd003 name="input.g.page3.mrbd003"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mrbd004
            #add-point:BEFORE FIELD mrbd004 name="input.b.page3.mrbd004"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mrbd004
            
            #add-point:AFTER FIELD mrbd004 name="input.a.page3.mrbd004"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mrbd004
            #add-point:ON CHANGE mrbd004 name="input.g.page3.mrbd004"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mrbd005
            
            #add-point:AFTER FIELD mrbd005 name="input.a.page3.mrbd005"
            CALL amrm200_mrbd005_desc(g_mrbb3_d[l_ac].mrbd005)
            IF NOT cl_null(g_mrbb3_d[l_ac].mrbd005) THEN
               IF NOT s_azzi650_chk_exist('1105',g_mrbb3_d[l_ac].mrbd005) THEN
                  LET g_mrbb3_d[l_ac].mrbd005 = g_mrbb3_d_t.mrbd005
                  CALL amrm200_mrbd005_desc(g_mrbb3_d[l_ac].mrbd005)
                  NEXT FIELD CURRENT
               END IF
            END IF

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mrbd005
            #add-point:BEFORE FIELD mrbd005 name="input.b.page3.mrbd005"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mrbd005
            #add-point:ON CHANGE mrbd005 name="input.g.page3.mrbd005"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mrbd006
            
            #add-point:AFTER FIELD mrbd006 name="input.a.page3.mrbd006"
            CALL amrm200_mrbd006_desc(g_mrbb3_d[l_ac].mrbd006)
            IF NOT cl_null(g_mrbb3_d[l_ac].mrbd006) THEN
               INITIALIZE g_chkparam.* TO NULL

               LET g_chkparam.arg1 = g_mrbb3_d[l_ac].mrbd006
               #160318-00025#6--add--str
               LET g_errshow = TRUE 
               LET g_chkparam.err_str[1] = "aim-00005:sub-01302|aooi250|",cl_get_progname("aooi250",g_lang,"2"),"|:EXEPROGaooi250"
               #160318-00025#6--add--end
               IF NOT cl_chk_exist("v_ooca001") THEN
                  LET g_mrbb3_d[l_ac].mrbd006 = g_mrbb3_d_t.mrbd006
                  CALL amrm200_mrbd006_desc(g_mrbb3_d[l_ac].mrbd006)
                  NEXT FIELD CURRENT
               END IF
               SELECT imaa006 INTO l_imaa006 FROM imaa_t WHERE imaaent = g_enterprise AND imaa001 = g_mrbb3_d[l_ac].mrbd003
               CALL s_aimi190_get_convert(g_mrbb3_d[l_ac].mrbd003,g_mrbb3_d[l_ac].mrbd006,l_imaa006) RETURNING l_success,l_rate
            END IF
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mrbd006
            #add-point:BEFORE FIELD mrbd006 name="input.b.page3.mrbd006"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mrbd006
            #add-point:ON CHANGE mrbd006 name="input.g.page3.mrbd006"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mrbd007
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_mrbb3_d[l_ac].mrbd007,"0","0","","","azz-00079",1) THEN
               NEXT FIELD mrbd007
            END IF 
 
 
 
            #add-point:AFTER FIELD mrbd007 name="input.a.page3.mrbd007"
            IF NOT cl_null(g_mrbb3_d[l_ac].mrbd007) THEN 
            END IF 

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mrbd007
            #add-point:BEFORE FIELD mrbd007 name="input.b.page3.mrbd007"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mrbd007
            #add-point:ON CHANGE mrbd007 name="input.g.page3.mrbd007"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mrbd008
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_mrbb3_d[l_ac].mrbd008,"0","1","","","azz-00079",1) THEN
               NEXT FIELD mrbd008
            END IF 
 
 
 
            #add-point:AFTER FIELD mrbd008 name="input.a.page3.mrbd008"
            IF NOT cl_null(g_mrbb3_d[l_ac].mrbd008) THEN 
            END IF 

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mrbd008
            #add-point:BEFORE FIELD mrbd008 name="input.b.page3.mrbd008"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mrbd008
            #add-point:ON CHANGE mrbd008 name="input.g.page3.mrbd008"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mrbd009
            #add-point:BEFORE FIELD mrbd009 name="input.b.page3.mrbd009"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mrbd009
            
            #add-point:AFTER FIELD mrbd009 name="input.a.page3.mrbd009"
            IF NOT cl_null(g_mrbb3_d[l_ac].mrbd009) THEN
               IF NOT amrm200_mrbd009_mrbd010_chk() THEN
                  LET g_mrbb3_d[l_ac].mrbd009 = g_mrbb3_d_t.mrbd009
                  NEXT FIELD CURRENT
               END IF
            END IF
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mrbd009
            #add-point:ON CHANGE mrbd009 name="input.g.page3.mrbd009"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mrbd010
            #add-point:BEFORE FIELD mrbd010 name="input.b.page3.mrbd010"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mrbd010
            
            #add-point:AFTER FIELD mrbd010 name="input.a.page3.mrbd010"
            IF NOT cl_null(g_mrbb3_d[l_ac].mrbd010) THEN
               IF NOT amrm200_mrbd009_mrbd010_chk() THEN
                  LET g_mrbb3_d[l_ac].mrbd010 = g_mrbb3_d_t.mrbd010
                  NEXT FIELD CURRENT
               END IF
            END IF
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mrbd010
            #add-point:ON CHANGE mrbd010 name="input.g.page3.mrbd010"
            
            #END add-point 
 
 
 
                  #Ctrlp:input.c.page3.mrbd002
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mrbd002
            #add-point:ON ACTION controlp INFIELD mrbd002 name="input.c.page3.mrbd002"
            
            #END add-point
 
 
         #Ctrlp:input.c.page3.mrbd003
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mrbd003
            #add-point:ON ACTION controlp INFIELD mrbd003 name="input.c.page3.mrbd003"
            #此段落由子樣板a07產生            
            #開窗i段
			   INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
			   LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_mrbb3_d[l_ac].mrbd003   #給予default值
#160716-00003#1-s
#           CALL q_imaa001()                                    #呼叫開窗
            CALL q_imaf001_15()                                 #呼叫開窗
#160716-00003#1-e            
            LET g_mrbb3_d[l_ac].mrbd003 = g_qryparam.return1    #將開窗取得的值回傳到變數
            DISPLAY g_mrbb3_d[l_ac].mrbd003 TO mrbd003          #顯示到畫面上
            CALL amrm200_mrbd003_desc(g_mrbb3_d[l_ac].mrbd003)
            NEXT FIELD mrbd003                                  #返回原欄位
            #END add-point
 
 
         #Ctrlp:input.c.page3.mrbd004
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mrbd004
            #add-point:ON ACTION controlp INFIELD mrbd004 name="input.c.page3.mrbd004"
            
            #END add-point
 
 
         #Ctrlp:input.c.page3.mrbd005
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mrbd005
            #add-point:ON ACTION controlp INFIELD mrbd005 name="input.c.page3.mrbd005"
#此段落由子樣板a07產生            
            #開窗i段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
			LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_mrbb3_d[l_ac].mrbd005             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "1105" #

            CALL q_oocq002()                                #呼叫開窗

            LET g_mrbb3_d[l_ac].mrbd005 = g_qryparam.return1              #將開窗取得的值回傳到變數

            DISPLAY g_mrbb3_d[l_ac].mrbd005 TO mrbd005              #顯示到畫面上
            CALL amrm200_mrbd005_desc(g_mrbb3_d[l_ac].mrbd005)
            NEXT FIELD mrbd005                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.page3.mrbd006
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mrbd006
            #add-point:ON ACTION controlp INFIELD mrbd006 name="input.c.page3.mrbd006"
#此段落由子樣板a07產生            
            #開窗i段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
			LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_mrbb3_d[l_ac].mrbd006             #給予default值

            #給予arg

            CALL q_ooca001_1()                                #呼叫開窗

            LET g_mrbb3_d[l_ac].mrbd006 = g_qryparam.return1              #將開窗取得的值回傳到變數

            DISPLAY g_mrbb3_d[l_ac].mrbd006 TO mrbd006              #顯示到畫面上
            CALL amrm200_mrbd006_desc(g_mrbb3_d[l_ac].mrbd006)
            NEXT FIELD mrbd006                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.page3.mrbd007
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mrbd007
            #add-point:ON ACTION controlp INFIELD mrbd007 name="input.c.page3.mrbd007"
            
            #END add-point
 
 
         #Ctrlp:input.c.page3.mrbd008
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mrbd008
            #add-point:ON ACTION controlp INFIELD mrbd008 name="input.c.page3.mrbd008"
            
            #END add-point
 
 
         #Ctrlp:input.c.page3.mrbd009
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mrbd009
            #add-point:ON ACTION controlp INFIELD mrbd009 name="input.c.page3.mrbd009"
            
            #END add-point
 
 
         #Ctrlp:input.c.page3.mrbd010
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mrbd010
            #add-point:ON ACTION controlp INFIELD mrbd010 name="input.c.page3.mrbd010"
            
            #END add-point
 
 
 
 
         AFTER ROW
            #add-point:單身page3 after_row name="input.body3.after_row"
            
            #end add-point
            LET l_ac = ARR_CURR()
            IF INT_FLAG THEN
               LET INT_FLAG = 0
               IF l_cmd = 'u' THEN
                  LET g_mrbb3_d[l_ac].* = g_mrbb3_d_t.*
               END IF
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code = 9001 
               LET g_errparam.popup = FALSE 
               CLOSE amrm200_bcl3
               CALL s_transaction_end('N','0')
               CALL cl_err()
               EXIT DIALOG 
            END IF
            
            #其他table進行unlock
            
            CALL amrm200_unlock_b("mrbd_t","'3'")
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
               LET g_mrbb3_d[li_reproduce_target].* = g_mrbb3_d[li_reproduce].*
 
               LET g_mrbb3_d[li_reproduce_target].mrbd002 = NULL
            ELSE
               CALL FGL_SET_ARR_CURR(g_mrbb3_d.getLength()+1)
               LET lb_reproduce = TRUE
               LET li_reproduce = l_ac
               LET li_reproduce_target = g_mrbb3_d.getLength()+1
            END IF
            
      END INPUT
      INPUT ARRAY g_mrbb4_d FROM s_detail4.*
         ATTRIBUTE(COUNT = g_rec_b,WITHOUT DEFAULTS, #MAXCOUNT = g_max_rec,
                 INSERT ROW = l_allow_insert, #此頁面insert功能由產生器控制, 手動之設定無效! 
 
                 DELETE ROW = l_allow_delete,
                 APPEND ROW = l_allow_insert)
                 
         #自訂ACTION(detail_input,page_4)
         
         
         BEFORE INPUT
            #add-point:資料輸入前 name="input.body4.before_input2"
            
            #end add-point
            IF g_insert = 'Y' AND NOT cl_null(g_insert) THEN 
              CALL FGL_SET_ARR_CURR(g_mrbb4_d.getLength()+1) 
              LET g_insert = 'N' 
           END IF 
 
            CALL amrm200_b_fill()
            #如果一直都在單身1則控制筆數位置
            IF g_loc = 'd' AND g_rec_b != 0 THEN
               CALL FGL_SET_ARR_CURR(g_idx_group.getValue("'4',"))
            END IF
            LET g_loc = 'd'
            LET g_rec_b = g_mrbb4_d.getLength()
            #add-point:資料輸入前 name="input.body4.before_input"
            
            #end add-point
            
         BEFORE INSERT
            IF s_transaction_chk("N",0) THEN
               CALL s_transaction_begin()
            END IF
            LET l_insert = TRUE
            LET l_n = ARR_COUNT()
            LET l_cmd = 'a'
            INITIALIZE g_mrbb4_d[l_ac].* TO NULL 
            INITIALIZE g_mrbb4_d_t.* TO NULL 
            INITIALIZE g_mrbb4_d_o.* TO NULL 
            #公用欄位給值(單身4)
            
            #自定義預設值(單身4)
            
            #add-point:modify段before備份 name="input.body4.insert.before_bak"
            
            #end add-point
            LET g_mrbb4_d_t.* = g_mrbb4_d[l_ac].*     #新輸入資料
            LET g_mrbb4_d_o.* = g_mrbb4_d[l_ac].*     #新輸入資料
            CALL cl_show_fld_cont()
            CALL amrm200_set_entry_b(l_cmd)
            #add-point:modify段after_set_entry_b name="input.body4.insert.after_set_entry_b"
            
            #end add-point
            CALL amrm200_set_no_entry_b(l_cmd)
            IF lb_reproduce THEN
               LET lb_reproduce = FALSE
               LET g_mrbb4_d[li_reproduce_target].* = g_mrbb4_d[li_reproduce].*
 
               LET g_mrbb4_d[li_reproduce_target].mrbe002 = NULL
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
            OPEN amrm200_cl USING g_enterprise, g_site,g_mrba_m.mrba001
            IF SQLCA.SQLCODE THEN   #(ver:78)
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "OPEN amrm200_cl:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE   #(ver:78)
               LET g_errparam.popup = TRUE 
               CLOSE amrm200_cl
               CALL s_transaction_end('N','0')
               CALL cl_err()
               RETURN
            END IF
            
            LET g_rec_b = g_mrbb4_d.getLength()
            
            IF g_rec_b >= l_ac 
               AND g_mrbb4_d[l_ac].mrbe002 IS NOT NULL
            THEN 
               LET l_cmd='u'
               LET g_mrbb4_d_t.* = g_mrbb4_d[l_ac].*  #BACKUP
               LET g_mrbb4_d_o.* = g_mrbb4_d[l_ac].*  #BACKUP
               CALL amrm200_set_entry_b(l_cmd)
               #add-point:modify段after_set_entry_b name="input.body4.after_set_entry_b"
               
               #end add-point  
               CALL amrm200_set_no_entry_b(l_cmd)
               IF NOT amrm200_lock_b("mrbe_t","'4'") THEN
                  LET l_lock_sw='Y'
               ELSE
                  FETCH amrm200_bcl4 INTO g_mrbb4_d[l_ac].mrbe002
                  IF SQLCA.SQLCODE THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = SQLERRMESSAGE  
                     LET g_errparam.code = SQLCA.SQLCODE 
                     LET g_errparam.popup = TRUE 
                     CALL cl_err()
                     LET l_lock_sw = "Y"
                  END IF
                  
                  #遮罩相關處理
                  LET g_mrbb4_d_mask_o[l_ac].* =  g_mrbb4_d[l_ac].*
                  CALL amrm200_mrbe_t_mask()
                  LET g_mrbb4_d_mask_n[l_ac].* =  g_mrbb4_d[l_ac].*
                  
                  LET g_bfill = "N"
                  CALL amrm200_show()
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
               LET gs_keys[01] = g_mrba_m.mrba001
               LET gs_keys[gs_keys.getLength()+1] = g_mrbb4_d_t.mrbe002
            
               #刪除同層單身
               IF NOT amrm200_delete_b('mrbe_t',gs_keys,"'4'") THEN
                  CALL s_transaction_end('N','0')
                  CLOSE amrm200_bcl
                  CANCEL DELETE
               END IF
    
               #刪除下層單身
               IF NOT amrm200_key_delete_b(gs_keys,'mrbe_t') THEN
                  CALL s_transaction_end('N','0')
                  CLOSE amrm200_bcl
                  CANCEL DELETE
               END IF
               
               #刪除多語言
               
 
               
               #add-point:單身4刪除中 name="input.body4.m_delete"
               
               #end add-point    
               
               CALL s_transaction_end('Y','0')
               CLOSE amrm200_bcl
 
               LET g_rec_b = g_rec_b-1
               #add-point:單身4刪除後 name="input.body4.a_delete"
               
               #end add-point
               LET l_count = g_mrbb_d.getLength()
               
               #add-point:單身刪除後(<>d) name="input.body4.after_delete"
               
               #end add-point
            END IF 
 
         AFTER DELETE
            #如果是最後一筆
            IF l_ac = (g_mrbb4_d.getLength() + 1) THEN
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
            SELECT COUNT(1) INTO l_count FROM mrbe_t 
             WHERE mrbeent = g_enterprise AND mrbesite = g_site AND mrbe001 = g_mrba_m.mrba001
               AND mrbe002 = g_mrbb4_d[l_ac].mrbe002
                
            #資料未重複, 插入新增資料
            IF l_count = 0 THEN 
               #add-point:單身4新增前 name="input.body4.b_insert"
               
               #end add-point
            
                              INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_mrba_m.mrba001
               LET gs_keys[2] = g_mrbb4_d[g_detail_idx].mrbe002
               CALL amrm200_insert_b('mrbe_t',gs_keys,"'4'")
                           
               #add-point:單身新增後4 name="input.body4.a_insert"
               
               #end add-point
            ELSE    
               INITIALIZE g_mrbb_d[l_ac].* TO NULL
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
               LET g_errparam.extend = "mrbe_t:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE 
               LET g_errparam.popup = TRUE 
               CALL s_transaction_end('N','0')                    
               CALL cl_err()
               CANCEL INSERT
            ELSE
               #先刷新資料
               #CALL amrm200_b_fill()
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
               LET g_mrbb4_d[l_ac].* = g_mrbb4_d_t.*
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code = 9001 
               LET g_errparam.popup = FALSE 
               CLOSE amrm200_bcl4
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
               LET g_mrbb4_d[l_ac].* = g_mrbb4_d_t.*
            ELSE
               #add-point:單身page4修改前 name="input.body4.b_update"
               
               #end add-point
               
               #寫入修改者/修改日期資訊(單身4)
               
               
               #將遮罩欄位還原
               CALL amrm200_mrbe_t_mask_restore('restore_mask_o')
                              
               UPDATE mrbe_t SET (mrbe001,mrbe002) = (g_mrba_m.mrba001,g_mrbb4_d[l_ac].mrbe002) #自訂欄位頁簽 
 
                WHERE mrbeent = g_enterprise AND mrbesite = g_site AND mrbe001 = g_mrba_m.mrba001
                  AND mrbe002 = g_mrbb4_d_t.mrbe002 #項次 
                  
               #add-point:單身page4修改中 name="input.body4.m_update"
               
               #end add-point
                  
               CASE
                  WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
                     LET g_mrbb4_d[l_ac].* = g_mrbb4_d_t.*
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "mrbe_t" 
                     LET g_errparam.code = "std-00009" 
                     LET g_errparam.popup = TRUE 
                     CALL s_transaction_end('N','0')
                     CALL cl_err()
                     
                  WHEN SQLCA.SQLCODE #其他錯誤
                     LET g_mrbb4_d[l_ac].* = g_mrbb4_d_t.*
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "mrbe_t:",SQLERRMESSAGE 
                     LET g_errparam.code = SQLCA.SQLCODE 
                     LET g_errparam.popup = TRUE 
                     CALL s_transaction_end('N','0')
                     CALL cl_err()
                     
                  OTHERWISE
                     #資料多語言用-增/改
                     
                                    INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_mrba_m.mrba001
               LET gs_keys_bak[1] = g_mrba001_t
               LET gs_keys[2] = g_mrbb4_d[g_detail_idx].mrbe002
               LET gs_keys_bak[2] = g_mrbb4_d_t.mrbe002
               CALL amrm200_update_b('mrbe_t',gs_keys,gs_keys_bak,"'4'")
               END CASE
               
               #將遮罩欄位進行遮蔽
               CALL amrm200_mrbe_t_mask_restore('restore_mask_n')
               
               #判斷key是否有改變
               INITIALIZE gs_keys TO NULL
               IF NOT (g_mrbb4_d[g_detail_idx].mrbe002 = g_mrbb4_d_t.mrbe002 
                  ) THEN
                  LET gs_keys[01] = g_mrba_m.mrba001
                  LET gs_keys[gs_keys.getLength()+1] = g_mrbb4_d_t.mrbe002
                  CALL amrm200_key_update_b(gs_keys,'mrbe_t')
               END IF
               
               #修改歷程記錄(單身修改)
               LET g_log1 = util.JSON.stringify(g_mrba_m),util.JSON.stringify(g_mrbb4_d_t)
               LET g_log2 = util.JSON.stringify(g_mrba_m),util.JSON.stringify(g_mrbb4_d[l_ac])
               IF NOT cl_log_modified_record_d(g_log1,g_log2) THEN 
                  CALL s_transaction_end('N','0')
               END IF
               
               #add-point:單身page4修改後 name="input.body4.a_update"
               
               #end add-point
            END IF
         
                  #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mrbe002
            
            #add-point:AFTER FIELD mrbe002 name="input.a.page4.mrbe002"
            CALL amrm200_mrbe002_desc(g_mrbb4_d[l_ac].mrbe002)
            IF NOT amrm200_mrbe002_chk(l_cmd,g_mrbb4_d[l_ac].mrbe002) THEN
               LET g_mrbb4_d[l_ac].mrbe002 = g_mrbb4_d_t.mrbe002
               CALL amrm200_mrbe002_desc(g_mrbb4_d[l_ac].mrbe002)
               NEXT FIELD CURRENT
            END IF
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mrbe002
            #add-point:BEFORE FIELD mrbe002 name="input.b.page4.mrbe002"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mrbe002
            #add-point:ON CHANGE mrbe002 name="input.g.page4.mrbe002"
            
            #END add-point 
 
 
 
                  #Ctrlp:input.c.page4.mrbe002
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mrbe002
            #add-point:ON ACTION controlp INFIELD mrbe002 name="input.c.page4.mrbe002"
            #此段落由子樣板a07產生            
            #開窗i段
			   INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = "c"	
			   LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_mrbb4_d[l_ac].mrbe002             #給予default值
            LET g_qryparam.where = " imaa004 = 'A' AND imaastus = 'Y'"
#160716-00003#1-s
#           CALL q_imaa001()                                #呼叫開窗
            CALL q_imaf001()                                #呼叫開窗
#160716-00003#1-e
            IF NOT cl_null(g_qryparam.return1) THEN
               LET g_errshow = 0
               CALL amrm200_mrbe002_controlp_chk()
            ELSE
               LET g_flag = FALSE
               INITIALIZE g_page_choice TO NULL
               NEXT FIELD CURRENT
            END IF
            CALL amrm200_show()
            LET g_page_choice = 'mrbe'
            LET g_flag = TRUE
            EXIT DIALOG
            #END add-point
 
 
 
 
         AFTER ROW
            #add-point:單身page4 after_row name="input.body4.after_row"
            
            #end add-point
            LET l_ac = ARR_CURR()
            IF INT_FLAG THEN
               LET INT_FLAG = 0
               IF l_cmd = 'u' THEN
                  LET g_mrbb4_d[l_ac].* = g_mrbb4_d_t.*
               END IF
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code = 9001 
               LET g_errparam.popup = FALSE 
               CLOSE amrm200_bcl4
               CALL s_transaction_end('N','0')
               CALL cl_err()
               EXIT DIALOG 
            END IF
            
            #其他table進行unlock
            
            CALL amrm200_unlock_b("mrbe_t","'4'")
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
               LET g_mrbb4_d[li_reproduce_target].* = g_mrbb4_d[li_reproduce].*
 
               LET g_mrbb4_d[li_reproduce_target].mrbe002 = NULL
            ELSE
               CALL FGL_SET_ARR_CURR(g_mrbb4_d.getLength()+1)
               LET lb_reproduce = TRUE
               LET li_reproduce = l_ac
               LET li_reproduce_target = g_mrbb4_d.getLength()+1
            END IF
            
      END INPUT
      INPUT ARRAY g_mrbb5_d FROM s_detail5.*
         ATTRIBUTE(COUNT = g_rec_b,WITHOUT DEFAULTS, #MAXCOUNT = g_max_rec,
                 INSERT ROW = l_allow_insert, #此頁面insert功能由產生器控制, 手動之設定無效! 
 
                 DELETE ROW = l_allow_delete,
                 APPEND ROW = l_allow_insert)
                 
         #自訂ACTION(detail_input,page_5)
         
         
         BEFORE INPUT
            #add-point:資料輸入前 name="input.body5.before_input2"
            
            #end add-point
            IF g_insert = 'Y' AND NOT cl_null(g_insert) THEN 
              CALL FGL_SET_ARR_CURR(g_mrbb5_d.getLength()+1) 
              LET g_insert = 'N' 
           END IF 
 
            CALL amrm200_b_fill()
            #如果一直都在單身1則控制筆數位置
            IF g_loc = 'd' AND g_rec_b != 0 THEN
               CALL FGL_SET_ARR_CURR(g_idx_group.getValue("'5',"))
            END IF
            LET g_loc = 'd'
            LET g_rec_b = g_mrbb5_d.getLength()
            #add-point:資料輸入前 name="input.body5.before_input"
            
            #end add-point
            
         BEFORE INSERT
            IF s_transaction_chk("N",0) THEN
               CALL s_transaction_begin()
            END IF
            LET l_insert = TRUE
            LET l_n = ARR_COUNT()
            LET l_cmd = 'a'
            INITIALIZE g_mrbb5_d[l_ac].* TO NULL 
            INITIALIZE g_mrbb5_d_t.* TO NULL 
            INITIALIZE g_mrbb5_d_o.* TO NULL 
            #公用欄位給值(單身5)
            
            #自定義預設值(單身5)
            
            #add-point:modify段before備份 name="input.body5.insert.before_bak"
            
            #end add-point
            LET g_mrbb5_d_t.* = g_mrbb5_d[l_ac].*     #新輸入資料
            LET g_mrbb5_d_o.* = g_mrbb5_d[l_ac].*     #新輸入資料
            CALL cl_show_fld_cont()
            CALL amrm200_set_entry_b(l_cmd)
            #add-point:modify段after_set_entry_b name="input.body5.insert.after_set_entry_b"
            
            #end add-point
            CALL amrm200_set_no_entry_b(l_cmd)
            IF lb_reproduce THEN
               LET lb_reproduce = FALSE
               LET g_mrbb5_d[li_reproduce_target].* = g_mrbb5_d[li_reproduce].*
 
               LET g_mrbb5_d[li_reproduce_target].mrbf002 = NULL
            END IF
            
 
            #add-point:modify段before insert name="input.body5.before_insert"
            
            #end add-point  
 
         BEFORE ROW     
            #add-point:modify段before row2 name="input.body5.before_row2"
            
            #end add-point  
            LET l_insert = FALSE
            LET l_cmd = ''
            LET l_ac_t = l_ac 
            LET g_detail_idx_list[5] = l_ac
            LET l_ac = ARR_CURR()
            LET g_detail_idx = l_ac
            LET g_current_page = 5
              
            LET l_lock_sw = 'N'            #DEFAULT
            LET l_n = ARR_COUNT()
            DISPLAY l_ac TO FORMONLY.idx
         
            CALL s_transaction_begin()
            OPEN amrm200_cl USING g_enterprise, g_site,g_mrba_m.mrba001
            IF SQLCA.SQLCODE THEN   #(ver:78)
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "OPEN amrm200_cl:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE   #(ver:78)
               LET g_errparam.popup = TRUE 
               CLOSE amrm200_cl
               CALL s_transaction_end('N','0')
               CALL cl_err()
               RETURN
            END IF
            
            LET g_rec_b = g_mrbb5_d.getLength()
            
            IF g_rec_b >= l_ac 
               AND g_mrbb5_d[l_ac].mrbf002 IS NOT NULL
            THEN 
               LET l_cmd='u'
               LET g_mrbb5_d_t.* = g_mrbb5_d[l_ac].*  #BACKUP
               LET g_mrbb5_d_o.* = g_mrbb5_d[l_ac].*  #BACKUP
               CALL amrm200_set_entry_b(l_cmd)
               #add-point:modify段after_set_entry_b name="input.body5.after_set_entry_b"
               
               #end add-point  
               CALL amrm200_set_no_entry_b(l_cmd)
               IF NOT amrm200_lock_b("mrbf_t","'5'") THEN
                  LET l_lock_sw='Y'
               ELSE
                  FETCH amrm200_bcl5 INTO g_mrbb5_d[l_ac].mrbf002
                  IF SQLCA.SQLCODE THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = SQLERRMESSAGE  
                     LET g_errparam.code = SQLCA.SQLCODE 
                     LET g_errparam.popup = TRUE 
                     CALL cl_err()
                     LET l_lock_sw = "Y"
                  END IF
                  
                  #遮罩相關處理
                  LET g_mrbb5_d_mask_o[l_ac].* =  g_mrbb5_d[l_ac].*
                  CALL amrm200_mrbf_t_mask()
                  LET g_mrbb5_d_mask_n[l_ac].* =  g_mrbb5_d[l_ac].*
                  
                  LET g_bfill = "N"
                  CALL amrm200_show()
                  LET g_bfill = "Y"
                  
                  CALL cl_show_fld_cont()
               END IF
            ELSE
               LET l_cmd='a'
            END IF
            #add-point:modify段before row name="input.body5.before_row"
            
            #end add-point  
            #其他table資料備份(確定是否更改用)
            
 
            #其他table進行lock
            
 
            
         BEFORE DELETE                            #是否取消單身
            IF l_cmd = 'a' THEN
               LET l_cmd='d'
               #add-point:單身AFTER DELETE (=d) name="input.body5.after_delete_d"
               
               #end add-point
            ELSE
               #add-point:單身刪除前 name="input.body5.b_delete_ask"
               
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
               
               #add-point:單身5刪除前 name="input.body5.b_delete"
               
               #end add-point    
                  
               #取得該筆資料key值
               INITIALIZE gs_keys TO NULL
               LET gs_keys[01] = g_mrba_m.mrba001
               LET gs_keys[gs_keys.getLength()+1] = g_mrbb5_d_t.mrbf002
            
               #刪除同層單身
               IF NOT amrm200_delete_b('mrbf_t',gs_keys,"'5'") THEN
                  CALL s_transaction_end('N','0')
                  CLOSE amrm200_bcl
                  CANCEL DELETE
               END IF
    
               #刪除下層單身
               IF NOT amrm200_key_delete_b(gs_keys,'mrbf_t') THEN
                  CALL s_transaction_end('N','0')
                  CLOSE amrm200_bcl
                  CANCEL DELETE
               END IF
               
               #刪除多語言
               
 
               
               #add-point:單身5刪除中 name="input.body5.m_delete"
               
               #end add-point    
               
               CALL s_transaction_end('Y','0')
               CLOSE amrm200_bcl
 
               LET g_rec_b = g_rec_b-1
               #add-point:單身5刪除後 name="input.body5.a_delete"
               
               #end add-point
               LET l_count = g_mrbb_d.getLength()
               
               #add-point:單身刪除後(<>d) name="input.body5.after_delete"
               
               #end add-point
            END IF 
 
         AFTER DELETE
            #如果是最後一筆
            IF l_ac = (g_mrbb5_d.getLength() + 1) THEN
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
               
            #add-point:單身5新增前 name="input.body5.b_a_insert"
            
            #end add-point
               
            LET l_count = 1  
            SELECT COUNT(1) INTO l_count FROM mrbf_t 
             WHERE mrbfent = g_enterprise AND mrbfsite = g_site AND mrbf001 = g_mrba_m.mrba001
               AND mrbf002 = g_mrbb5_d[l_ac].mrbf002
                
            #資料未重複, 插入新增資料
            IF l_count = 0 THEN 
               #add-point:單身5新增前 name="input.body5.b_insert"
               
               #end add-point
            
                              INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_mrba_m.mrba001
               LET gs_keys[2] = g_mrbb5_d[g_detail_idx].mrbf002
               CALL amrm200_insert_b('mrbf_t',gs_keys,"'5'")
                           
               #add-point:單身新增後5 name="input.body5.a_insert"
               
               #end add-point
            ELSE    
               INITIALIZE g_mrbb_d[l_ac].* TO NULL
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
               LET g_errparam.extend = "mrbf_t:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE 
               LET g_errparam.popup = TRUE 
               CALL s_transaction_end('N','0')                    
               CALL cl_err()
               CANCEL INSERT
            ELSE
               #先刷新資料
               #CALL amrm200_b_fill()
               #資料多語言用-增/改
               
               #add-point:單身新增後 name="input.body5.after_insert"
               
               #end add-point
               CALL s_transaction_end('Y','0')
               #ERROR 'INSERT O.K'
               LET g_rec_b = g_rec_b + 1
            END IF
            
         ON ROW CHANGE 
            IF INT_FLAG THEN
               LET INT_FLAG = 0
               LET g_mrbb5_d[l_ac].* = g_mrbb5_d_t.*
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code = 9001 
               LET g_errparam.popup = FALSE 
               CLOSE amrm200_bcl5
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
               LET g_mrbb5_d[l_ac].* = g_mrbb5_d_t.*
            ELSE
               #add-point:單身page5修改前 name="input.body5.b_update"
               
               #end add-point
               
               #寫入修改者/修改日期資訊(單身5)
               
               
               #將遮罩欄位還原
               CALL amrm200_mrbf_t_mask_restore('restore_mask_o')
                              
               UPDATE mrbf_t SET (mrbf001,mrbf002) = (g_mrba_m.mrba001,g_mrbb5_d[l_ac].mrbf002) #自訂欄位頁簽 
 
                WHERE mrbfent = g_enterprise AND mrbfsite = g_site AND mrbf001 = g_mrba_m.mrba001
                  AND mrbf002 = g_mrbb5_d_t.mrbf002 #項次 
                  
               #add-point:單身page5修改中 name="input.body5.m_update"
               
               #end add-point
                  
               CASE
                  WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
                     LET g_mrbb5_d[l_ac].* = g_mrbb5_d_t.*
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "mrbf_t" 
                     LET g_errparam.code = "std-00009" 
                     LET g_errparam.popup = TRUE 
                     CALL s_transaction_end('N','0')
                     CALL cl_err()
                     
                  WHEN SQLCA.SQLCODE #其他錯誤
                     LET g_mrbb5_d[l_ac].* = g_mrbb5_d_t.*
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "mrbf_t:",SQLERRMESSAGE 
                     LET g_errparam.code = SQLCA.SQLCODE 
                     LET g_errparam.popup = TRUE 
                     CALL s_transaction_end('N','0')
                     CALL cl_err()
                     
                  OTHERWISE
                     #資料多語言用-增/改
                     
                                    INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_mrba_m.mrba001
               LET gs_keys_bak[1] = g_mrba001_t
               LET gs_keys[2] = g_mrbb5_d[g_detail_idx].mrbf002
               LET gs_keys_bak[2] = g_mrbb5_d_t.mrbf002
               CALL amrm200_update_b('mrbf_t',gs_keys,gs_keys_bak,"'5'")
               END CASE
               
               #將遮罩欄位進行遮蔽
               CALL amrm200_mrbf_t_mask_restore('restore_mask_n')
               
               #判斷key是否有改變
               INITIALIZE gs_keys TO NULL
               IF NOT (g_mrbb5_d[g_detail_idx].mrbf002 = g_mrbb5_d_t.mrbf002 
                  ) THEN
                  LET gs_keys[01] = g_mrba_m.mrba001
                  LET gs_keys[gs_keys.getLength()+1] = g_mrbb5_d_t.mrbf002
                  CALL amrm200_key_update_b(gs_keys,'mrbf_t')
               END IF
               
               #修改歷程記錄(單身修改)
               LET g_log1 = util.JSON.stringify(g_mrba_m),util.JSON.stringify(g_mrbb5_d_t)
               LET g_log2 = util.JSON.stringify(g_mrba_m),util.JSON.stringify(g_mrbb5_d[l_ac])
               IF NOT cl_log_modified_record_d(g_log1,g_log2) THEN 
                  CALL s_transaction_end('N','0')
               END IF
               
               #add-point:單身page5修改後 name="input.body5.a_update"
               
               #end add-point
            END IF
         
                  #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mrbf002
            
            #add-point:AFTER FIELD mrbf002 name="input.a.page5.mrbf002"
            CALL amrm200_mrbf002_desc(g_mrbb5_d[l_ac].mrbf002)
            IF NOT amrm200_mrbf002_chk(l_cmd,g_mrbb5_d[l_ac].mrbf002) THEN
               LET g_mrbb5_d[l_ac].mrbf002 = g_mrbb5_d_t.mrbf002
               CALL amrm200_mrbf002_desc(g_mrbb5_d[l_ac].mrbf002)
               NEXT FIELD CURRENT
            END IF
            
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mrbf002
            #add-point:BEFORE FIELD mrbf002 name="input.b.page5.mrbf002"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mrbf002
            #add-point:ON CHANGE mrbf002 name="input.g.page5.mrbf002"
            
            #END add-point 
 
 
 
                  #Ctrlp:input.c.page5.mrbf002
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mrbf002
            #add-point:ON ACTION controlp INFIELD mrbf002 name="input.c.page5.mrbf002"
#此段落由子樣板a07產生            
            #開窗i段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_mrbb5_d[l_ac].mrbf002             #給予default值

            #給予arg

            CALL q_mrba001_2()                                #呼叫開窗

            IF NOT cl_null(g_qryparam.return1) THEN
               LET g_errshow = 0
               CALL amrm200_mrbf002_controlp_chk()
            ELSE
               LET g_flag = FALSE
               INITIALIZE g_page_choice TO NULL
               NEXT FIELD CURRENT
            END IF
            CALL amrm200_show()
            LET g_page_choice = 'mrbf'
            LET g_flag = TRUE
            EXIT DIALOG                        #返回原欄位


            #END add-point
 
 
 
 
         AFTER ROW
            #add-point:單身page5 after_row name="input.body5.after_row"
            
            #end add-point
            LET l_ac = ARR_CURR()
            IF INT_FLAG THEN
               LET INT_FLAG = 0
               IF l_cmd = 'u' THEN
                  LET g_mrbb5_d[l_ac].* = g_mrbb5_d_t.*
               END IF
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code = 9001 
               LET g_errparam.popup = FALSE 
               CLOSE amrm200_bcl5
               CALL s_transaction_end('N','0')
               CALL cl_err()
               EXIT DIALOG 
            END IF
            
            #其他table進行unlock
            
            CALL amrm200_unlock_b("mrbf_t","'5'")
            CALL s_transaction_end('Y','0')
            #add-point:單身page5 after_row2 name="input.body5.after_row2"
            
            #end add-point
 
         AFTER INPUT
            #add-point:input段after input  name="input.body5.after_input"
            
            #end add-point   
    
         ON ACTION controlo
            IF l_insert THEN
               LET li_reproduce = l_ac_t
               LET li_reproduce_target = l_ac
               LET g_mrbb5_d[li_reproduce_target].* = g_mrbb5_d[li_reproduce].*
 
               LET g_mrbb5_d[li_reproduce_target].mrbf002 = NULL
            ELSE
               CALL FGL_SET_ARR_CURR(g_mrbb5_d.getLength()+1)
               LET lb_reproduce = TRUE
               LET li_reproduce = l_ac
               LET li_reproduce_target = g_mrbb5_d.getLength()+1
            END IF
            
      END INPUT
      INPUT ARRAY g_mrbb6_d FROM s_detail6.*
         ATTRIBUTE(COUNT = g_rec_b,WITHOUT DEFAULTS, #MAXCOUNT = g_max_rec,
                 INSERT ROW = l_allow_insert, #此頁面insert功能由產生器控制, 手動之設定無效! 
 
                 DELETE ROW = l_allow_delete,
                 APPEND ROW = l_allow_insert)
                 
         #自訂ACTION(detail_input,page_6)
         
         
         BEFORE INPUT
            #add-point:資料輸入前 name="input.body6.before_input2"
            
            #end add-point
            IF g_insert = 'Y' AND NOT cl_null(g_insert) THEN 
              CALL FGL_SET_ARR_CURR(g_mrbb6_d.getLength()+1) 
              LET g_insert = 'N' 
           END IF 
 
            CALL amrm200_b_fill()
            #如果一直都在單身1則控制筆數位置
            IF g_loc = 'd' AND g_rec_b != 0 THEN
               CALL FGL_SET_ARR_CURR(g_idx_group.getValue("'6',"))
            END IF
            LET g_loc = 'd'
            LET g_rec_b = g_mrbb6_d.getLength()
            #add-point:資料輸入前 name="input.body6.before_input"
            
            #end add-point
            
         BEFORE INSERT
            IF s_transaction_chk("N",0) THEN
               CALL s_transaction_begin()
            END IF
            LET l_insert = TRUE
            LET l_n = ARR_COUNT()
            LET l_cmd = 'a'
            INITIALIZE g_mrbb6_d[l_ac].* TO NULL 
            INITIALIZE g_mrbb6_d_t.* TO NULL 
            INITIALIZE g_mrbb6_d_o.* TO NULL 
            #公用欄位給值(單身6)
            
            #自定義預設值(單身6)
            
            #add-point:modify段before備份 name="input.body6.insert.before_bak"
            
            #end add-point
            LET g_mrbb6_d_t.* = g_mrbb6_d[l_ac].*     #新輸入資料
            LET g_mrbb6_d_o.* = g_mrbb6_d[l_ac].*     #新輸入資料
            CALL cl_show_fld_cont()
            CALL amrm200_set_entry_b(l_cmd)
            #add-point:modify段after_set_entry_b name="input.body6.insert.after_set_entry_b"
            
            #end add-point
            CALL amrm200_set_no_entry_b(l_cmd)
            IF lb_reproduce THEN
               LET lb_reproduce = FALSE
               LET g_mrbb6_d[li_reproduce_target].* = g_mrbb6_d[li_reproduce].*
 
               LET g_mrbb6_d[li_reproduce_target].mrbg002 = NULL
            END IF
            
 
            #add-point:modify段before insert name="input.body6.before_insert"
            SELECT MAX(mrbg002) + 1 INTO g_mrbb6_d[l_ac].mrbg002 FROM mrbg_t
             WHERE mrbgent = g_enterprise AND mrbgsite = g_site AND mrbg001 = g_mrba_m.mrba001
            IF cl_null(g_mrbb6_d[l_ac].mrbg002) THEN LET g_mrbb6_d[l_ac].mrbg002 = 1 END IF
            LET g_mrbb6_d_t.* = g_mrbb6_d[l_ac].* 
            #end add-point  
 
         BEFORE ROW     
            #add-point:modify段before row2 name="input.body6.before_row2"
            
            #end add-point  
            LET l_insert = FALSE
            LET l_cmd = ''
            LET l_ac_t = l_ac 
            LET g_detail_idx_list[6] = l_ac
            LET l_ac = ARR_CURR()
            LET g_detail_idx = l_ac
            LET g_current_page = 6
              
            LET l_lock_sw = 'N'            #DEFAULT
            LET l_n = ARR_COUNT()
            DISPLAY l_ac TO FORMONLY.idx
         
            CALL s_transaction_begin()
            OPEN amrm200_cl USING g_enterprise, g_site,g_mrba_m.mrba001
            IF SQLCA.SQLCODE THEN   #(ver:78)
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "OPEN amrm200_cl:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE   #(ver:78)
               LET g_errparam.popup = TRUE 
               CLOSE amrm200_cl
               CALL s_transaction_end('N','0')
               CALL cl_err()
               RETURN
            END IF
            
            LET g_rec_b = g_mrbb6_d.getLength()
            
            IF g_rec_b >= l_ac 
               AND g_mrbb6_d[l_ac].mrbg002 IS NOT NULL
            THEN 
               LET l_cmd='u'
               LET g_mrbb6_d_t.* = g_mrbb6_d[l_ac].*  #BACKUP
               LET g_mrbb6_d_o.* = g_mrbb6_d[l_ac].*  #BACKUP
               CALL amrm200_set_entry_b(l_cmd)
               #add-point:modify段after_set_entry_b name="input.body6.after_set_entry_b"
               
               #end add-point  
               CALL amrm200_set_no_entry_b(l_cmd)
               IF NOT amrm200_lock_b("mrbg_t","'6'") THEN
                  LET l_lock_sw='Y'
               ELSE
                  FETCH amrm200_bcl6 INTO g_mrbb6_d[l_ac].mrbg002,g_mrbb6_d[l_ac].mrbg003,g_mrbb6_d[l_ac].mrbg004, 
                      g_mrbb6_d[l_ac].mrbg005,g_mrbb6_d[l_ac].mrbg006,g_mrbb6_d[l_ac].mrbg007,g_mrbb6_d[l_ac].mrbg008 
 
                  IF SQLCA.SQLCODE THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = SQLERRMESSAGE  
                     LET g_errparam.code = SQLCA.SQLCODE 
                     LET g_errparam.popup = TRUE 
                     CALL cl_err()
                     LET l_lock_sw = "Y"
                  END IF
                  
                  #遮罩相關處理
                  LET g_mrbb6_d_mask_o[l_ac].* =  g_mrbb6_d[l_ac].*
                  CALL amrm200_mrbg_t_mask()
                  LET g_mrbb6_d_mask_n[l_ac].* =  g_mrbb6_d[l_ac].*
                  
                  LET g_bfill = "N"
                  CALL amrm200_show()
                  LET g_bfill = "Y"
                  
                  CALL cl_show_fld_cont()
               END IF
            ELSE
               LET l_cmd='a'
            END IF
            #add-point:modify段before row name="input.body6.before_row"
            
            #end add-point  
            #其他table資料備份(確定是否更改用)
            
 
            #其他table進行lock
            
 
            
         BEFORE DELETE                            #是否取消單身
            IF l_cmd = 'a' THEN
               LET l_cmd='d'
               #add-point:單身AFTER DELETE (=d) name="input.body6.after_delete_d"
               
               #end add-point
            ELSE
               #add-point:單身刪除前 name="input.body6.b_delete_ask"
               
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
               
               #add-point:單身6刪除前 name="input.body6.b_delete"
               
               #end add-point    
                  
               #取得該筆資料key值
               INITIALIZE gs_keys TO NULL
               LET gs_keys[01] = g_mrba_m.mrba001
               LET gs_keys[gs_keys.getLength()+1] = g_mrbb6_d_t.mrbg002
            
               #刪除同層單身
               IF NOT amrm200_delete_b('mrbg_t',gs_keys,"'6'") THEN
                  CALL s_transaction_end('N','0')
                  CLOSE amrm200_bcl
                  CANCEL DELETE
               END IF
    
               #刪除下層單身
               IF NOT amrm200_key_delete_b(gs_keys,'mrbg_t') THEN
                  CALL s_transaction_end('N','0')
                  CLOSE amrm200_bcl
                  CANCEL DELETE
               END IF
               
               #刪除多語言
               
 
               
               #add-point:單身6刪除中 name="input.body6.m_delete"
               
               #end add-point    
               
               CALL s_transaction_end('Y','0')
               CLOSE amrm200_bcl
 
               LET g_rec_b = g_rec_b-1
               #add-point:單身6刪除後 name="input.body6.a_delete"
               
               #end add-point
               LET l_count = g_mrbb_d.getLength()
               
               #add-point:單身刪除後(<>d) name="input.body6.after_delete"
               
               #end add-point
            END IF 
 
         AFTER DELETE
            #如果是最後一筆
            IF l_ac = (g_mrbb6_d.getLength() + 1) THEN
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
               
            #add-point:單身6新增前 name="input.body6.b_a_insert"
            
            #end add-point
               
            LET l_count = 1  
            SELECT COUNT(1) INTO l_count FROM mrbg_t 
             WHERE mrbgent = g_enterprise AND mrbgsite = g_site AND mrbg001 = g_mrba_m.mrba001
               AND mrbg002 = g_mrbb6_d[l_ac].mrbg002
                
            #資料未重複, 插入新增資料
            IF l_count = 0 THEN 
               #add-point:單身6新增前 name="input.body6.b_insert"
               
               #end add-point
            
                              INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_mrba_m.mrba001
               LET gs_keys[2] = g_mrbb6_d[g_detail_idx].mrbg002
               CALL amrm200_insert_b('mrbg_t',gs_keys,"'6'")
                           
               #add-point:單身新增後6 name="input.body6.a_insert"
               
               #end add-point
            ELSE    
               INITIALIZE g_mrbb_d[l_ac].* TO NULL
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
               LET g_errparam.extend = "mrbg_t:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE 
               LET g_errparam.popup = TRUE 
               CALL s_transaction_end('N','0')                    
               CALL cl_err()
               CANCEL INSERT
            ELSE
               #先刷新資料
               #CALL amrm200_b_fill()
               #資料多語言用-增/改
               
               #add-point:單身新增後 name="input.body6.after_insert"
               
               #end add-point
               CALL s_transaction_end('Y','0')
               #ERROR 'INSERT O.K'
               LET g_rec_b = g_rec_b + 1
            END IF
            
         ON ROW CHANGE 
            IF INT_FLAG THEN
               LET INT_FLAG = 0
               LET g_mrbb6_d[l_ac].* = g_mrbb6_d_t.*
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code = 9001 
               LET g_errparam.popup = FALSE 
               CLOSE amrm200_bcl6
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
               LET g_mrbb6_d[l_ac].* = g_mrbb6_d_t.*
            ELSE
               #add-point:單身page6修改前 name="input.body6.b_update"
               
               #end add-point
               
               #寫入修改者/修改日期資訊(單身6)
               
               
               #將遮罩欄位還原
               CALL amrm200_mrbg_t_mask_restore('restore_mask_o')
                              
               UPDATE mrbg_t SET (mrbg001,mrbg002,mrbg003,mrbg004,mrbg005,mrbg006,mrbg007,mrbg008) = (g_mrba_m.mrba001, 
                   g_mrbb6_d[l_ac].mrbg002,g_mrbb6_d[l_ac].mrbg003,g_mrbb6_d[l_ac].mrbg004,g_mrbb6_d[l_ac].mrbg005, 
                   g_mrbb6_d[l_ac].mrbg006,g_mrbb6_d[l_ac].mrbg007,g_mrbb6_d[l_ac].mrbg008) #自訂欄位頁簽 
 
                WHERE mrbgent = g_enterprise AND mrbgsite = g_site AND mrbg001 = g_mrba_m.mrba001
                  AND mrbg002 = g_mrbb6_d_t.mrbg002 #項次 
                  
               #add-point:單身page6修改中 name="input.body6.m_update"
               
               #end add-point
                  
               CASE
                  WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
                     LET g_mrbb6_d[l_ac].* = g_mrbb6_d_t.*
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "mrbg_t" 
                     LET g_errparam.code = "std-00009" 
                     LET g_errparam.popup = TRUE 
                     CALL s_transaction_end('N','0')
                     CALL cl_err()
                     
                  WHEN SQLCA.SQLCODE #其他錯誤
                     LET g_mrbb6_d[l_ac].* = g_mrbb6_d_t.*
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "mrbg_t:",SQLERRMESSAGE 
                     LET g_errparam.code = SQLCA.SQLCODE 
                     LET g_errparam.popup = TRUE 
                     CALL s_transaction_end('N','0')
                     CALL cl_err()
                     
                  OTHERWISE
                     #資料多語言用-增/改
                     
                                    INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_mrba_m.mrba001
               LET gs_keys_bak[1] = g_mrba001_t
               LET gs_keys[2] = g_mrbb6_d[g_detail_idx].mrbg002
               LET gs_keys_bak[2] = g_mrbb6_d_t.mrbg002
               CALL amrm200_update_b('mrbg_t',gs_keys,gs_keys_bak,"'6'")
               END CASE
               
               #將遮罩欄位進行遮蔽
               CALL amrm200_mrbg_t_mask_restore('restore_mask_n')
               
               #判斷key是否有改變
               INITIALIZE gs_keys TO NULL
               IF NOT (g_mrbb6_d[g_detail_idx].mrbg002 = g_mrbb6_d_t.mrbg002 
                  ) THEN
                  LET gs_keys[01] = g_mrba_m.mrba001
                  LET gs_keys[gs_keys.getLength()+1] = g_mrbb6_d_t.mrbg002
                  CALL amrm200_key_update_b(gs_keys,'mrbg_t')
               END IF
               
               #修改歷程記錄(單身修改)
               LET g_log1 = util.JSON.stringify(g_mrba_m),util.JSON.stringify(g_mrbb6_d_t)
               LET g_log2 = util.JSON.stringify(g_mrba_m),util.JSON.stringify(g_mrbb6_d[l_ac])
               IF NOT cl_log_modified_record_d(g_log1,g_log2) THEN 
                  CALL s_transaction_end('N','0')
               END IF
               
               #add-point:單身page6修改後 name="input.body6.a_update"
               
               #end add-point
            END IF
         
                  #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mrbg002
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_mrbb6_d[l_ac].mrbg002,"0","0","","","azz-00079",1) THEN
               NEXT FIELD mrbg002
            END IF 
 
 
 
            #add-point:AFTER FIELD mrbg002 name="input.a.page6.mrbg002"
            #此段落由子樣板a05產生
            IF  g_mrba_m.mrba001 IS NOT NULL AND g_mrbb6_d[g_detail_idx].mrbg002 IS NOT NULL THEN 
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_mrba_m.mrba001 != g_mrba001_t OR g_mrbb6_d[g_detail_idx].mrbg002 != g_mrbb6_d_t.mrbg002)) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM mrbg_t WHERE "||"mrbgent = '" ||g_enterprise|| "' AND mrbgsite = '" ||g_site|| "' AND "||"mrbg001 = '"||g_mrba_m.mrba001 ||"' AND "|| "mrbg002 = '"||g_mrbb6_d[g_detail_idx].mrbg002 ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mrbg002
            #add-point:BEFORE FIELD mrbg002 name="input.b.page6.mrbg002"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mrbg002
            #add-point:ON CHANGE mrbg002 name="input.g.page6.mrbg002"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mrbg003
            #add-point:BEFORE FIELD mrbg003 name="input.b.page6.mrbg003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mrbg003
            
            #add-point:AFTER FIELD mrbg003 name="input.a.page6.mrbg003"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mrbg003
            #add-point:ON CHANGE mrbg003 name="input.g.page6.mrbg003"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mrbg004
            
            #add-point:AFTER FIELD mrbg004 name="input.a.page6.mrbg004"
            CALL amrm200_mrbg004_desc(g_mrbb6_d[l_ac].mrbg004)
            IF NOT cl_null(g_mrbb6_d[l_ac].mrbg004) THEN
               IF NOT s_azzi650_chk_exist('1107',g_mrbb6_d[l_ac].mrbg004) THEN
                  LET g_mrbb6_d[l_ac].mrbg004 = g_mrbb6_d_t.mrbg004
                  CALL amrm200_mrbg004_desc(g_mrbb6_d[l_ac].mrbg004)
                  NEXT FIELD CURRENT
               END IF
            END IF
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mrbg004
            #add-point:BEFORE FIELD mrbg004 name="input.b.page6.mrbg004"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mrbg004
            #add-point:ON CHANGE mrbg004 name="input.g.page6.mrbg004"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mrbg005
            #add-point:BEFORE FIELD mrbg005 name="input.b.page6.mrbg005"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mrbg005
            
            #add-point:AFTER FIELD mrbg005 name="input.a.page6.mrbg005"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mrbg005
            #add-point:ON CHANGE mrbg005 name="input.g.page6.mrbg005"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mrbg006
            #add-point:BEFORE FIELD mrbg006 name="input.b.page6.mrbg006"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mrbg006
            
            #add-point:AFTER FIELD mrbg006 name="input.a.page6.mrbg006"
            IF NOT cl_null(g_mrbb6_d[l_ac].mrbg006) THEN
               IF NOT amrm200_mrbg006_mrbg007_chk() THEN
                  LET g_mrbb6_d[l_ac].mrbg006 = g_mrbb6_d_t.mrbg006
                  NEXT FIELD CURRENT
               END IF
            END IF
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mrbg006
            #add-point:ON CHANGE mrbg006 name="input.g.page6.mrbg006"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mrbg007
            #add-point:BEFORE FIELD mrbg007 name="input.b.page6.mrbg007"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mrbg007
            
            #add-point:AFTER FIELD mrbg007 name="input.a.page6.mrbg007"
            IF NOT cl_null(g_mrbb6_d[l_ac].mrbg007) THEN
               IF NOT amrm200_mrbg006_mrbg007_chk() THEN
                  LET g_mrbb6_d[l_ac].mrbg007 = g_mrbb6_d_t.mrbg007
                  NEXT FIELD CURRENT
               END IF
            END IF
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mrbg007
            #add-point:ON CHANGE mrbg007 name="input.g.page6.mrbg007"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mrbg008
            #add-point:BEFORE FIELD mrbg008 name="input.b.page6.mrbg008"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mrbg008
            
            #add-point:AFTER FIELD mrbg008 name="input.a.page6.mrbg008"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mrbg008
            #add-point:ON CHANGE mrbg008 name="input.g.page6.mrbg008"
            
            #END add-point 
 
 
 
                  #Ctrlp:input.c.page6.mrbg002
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mrbg002
            #add-point:ON ACTION controlp INFIELD mrbg002 name="input.c.page6.mrbg002"
            
            #END add-point
 
 
         #Ctrlp:input.c.page6.mrbg003
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mrbg003
            #add-point:ON ACTION controlp INFIELD mrbg003 name="input.c.page6.mrbg003"
            
            #END add-point
 
 
         #Ctrlp:input.c.page6.mrbg004
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mrbg004
            #add-point:ON ACTION controlp INFIELD mrbg004 name="input.c.page6.mrbg004"
#此段落由子樣板a07產生            
            #開窗i段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
			LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_mrbb6_d[l_ac].mrbg004             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "1107" #

            CALL q_oocq002()                                #呼叫開窗

            LET g_mrbb6_d[l_ac].mrbg004 = g_qryparam.return1              #將開窗取得的值回傳到變數

            DISPLAY g_mrbb6_d[l_ac].mrbg004 TO mrbg004              #顯示到畫面上
            CALL amrm200_mrbg004_desc(g_mrbb6_d[l_ac].mrbg004)
            NEXT FIELD mrbg004                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.page6.mrbg005
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mrbg005
            #add-point:ON ACTION controlp INFIELD mrbg005 name="input.c.page6.mrbg005"
            
            #END add-point
 
 
         #Ctrlp:input.c.page6.mrbg006
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mrbg006
            #add-point:ON ACTION controlp INFIELD mrbg006 name="input.c.page6.mrbg006"
            
            #END add-point
 
 
         #Ctrlp:input.c.page6.mrbg007
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mrbg007
            #add-point:ON ACTION controlp INFIELD mrbg007 name="input.c.page6.mrbg007"
            
            #END add-point
 
 
         #Ctrlp:input.c.page6.mrbg008
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mrbg008
            #add-point:ON ACTION controlp INFIELD mrbg008 name="input.c.page6.mrbg008"
            
            #END add-point
 
 
 
 
         AFTER ROW
            #add-point:單身page6 after_row name="input.body6.after_row"
            
            #end add-point
            LET l_ac = ARR_CURR()
            IF INT_FLAG THEN
               LET INT_FLAG = 0
               IF l_cmd = 'u' THEN
                  LET g_mrbb6_d[l_ac].* = g_mrbb6_d_t.*
               END IF
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code = 9001 
               LET g_errparam.popup = FALSE 
               CLOSE amrm200_bcl6
               CALL s_transaction_end('N','0')
               CALL cl_err()
               EXIT DIALOG 
            END IF
            
            #其他table進行unlock
            
            CALL amrm200_unlock_b("mrbg_t","'6'")
            CALL s_transaction_end('Y','0')
            #add-point:單身page6 after_row2 name="input.body6.after_row2"
            
            #end add-point
 
         AFTER INPUT
            #add-point:input段after input  name="input.body6.after_input"
            
            #end add-point   
    
         ON ACTION controlo
            IF l_insert THEN
               LET li_reproduce = l_ac_t
               LET li_reproduce_target = l_ac
               LET g_mrbb6_d[li_reproduce_target].* = g_mrbb6_d[li_reproduce].*
 
               LET g_mrbb6_d[li_reproduce_target].mrbg002 = NULL
            ELSE
               CALL FGL_SET_ARR_CURR(g_mrbb6_d.getLength()+1)
               LET lb_reproduce = TRUE
               LET li_reproduce = l_ac
               LET li_reproduce_target = g_mrbb6_d.getLength()+1
            END IF
            
      END INPUT
 
      
 
 
 
 
{</section>}
 
{<section id="amrm200.input.other" >}
      
      #add-point:自定義input name="input.more_input"
      
      #end add-point
    
      BEFORE DIALOG 
         #CALL cl_err_collect_init()    
         #add-point:input段before dialog name="input.before_dialog"
         IF g_flag THEN
            LET g_flag = FALSE
            IF g_page_choice = "mrbe" THEN
               INITIALIZE g_page_choice TO NULL
               NEXT FIELD mrbe002
            END IF
            IF g_page_choice = "mrbf" THEN
               INITIALIZE g_page_choice TO NULL
               NEXT FIELD mrbf002
            END IF
         END IF
         #end add-point    
         #重新導回資料到正確位置上
         CALL DIALOG.setCurrentRow("s_detail1",g_idx_group.getValue("'1',"))      
         CALL DIALOG.setCurrentRow("s_detail2",g_idx_group.getValue("'2',"))
         CALL DIALOG.setCurrentRow("s_detail3",g_idx_group.getValue("'3',"))
         CALL DIALOG.setCurrentRow("s_detail4",g_idx_group.getValue("'4',"))
         CALL DIALOG.setCurrentRow("s_detail5",g_idx_group.getValue("'5',"))
         CALL DIALOG.setCurrentRow("s_detail6",g_idx_group.getValue("'6',"))
 
         #新增時強制從單頭開始填
         IF p_cmd = 'a' THEN
            #add-point:input段next_field name="input.next_field"
            
            #end add-point  
            NEXT FIELD mrba001
         ELSE
            CASE g_aw
               WHEN "s_detail1"
                  NEXT FIELD mrbbstus
               WHEN "s_detail2"
                  NEXT FIELD mrbc002
               WHEN "s_detail3"
                  NEXT FIELD mrbd002
               WHEN "s_detail4"
                  NEXT FIELD mrbe002
               WHEN "s_detail5"
                  NEXT FIELD mrbf002
               WHEN "s_detail6"
                  NEXT FIELD mrbg002
 
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
         LET g_detail_idx_list[5] = 1
         LET g_detail_idx_list[6] = 1
 
         CALL g_curr_diag.setCurrentRow("s_detail1",1)    
         CALL g_curr_diag.setCurrentRow("s_detail2",1)
         CALL g_curr_diag.setCurrentRow("s_detail3",1)
         CALL g_curr_diag.setCurrentRow("s_detail4",1)
         CALL g_curr_diag.setCurrentRow("s_detail5",1)
         CALL g_curr_diag.setCurrentRow("s_detail6",1)
 
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
         LET g_detail_idx_list[5] = 1
         LET g_detail_idx_list[6] = 1
 
         CALL g_curr_diag.setCurrentRow("s_detail1",1)    
         CALL g_curr_diag.setCurrentRow("s_detail2",1)
         CALL g_curr_diag.setCurrentRow("s_detail3",1)
         CALL g_curr_diag.setCurrentRow("s_detail4",1)
         CALL g_curr_diag.setCurrentRow("s_detail5",1)
         CALL g_curr_diag.setCurrentRow("s_detail6",1)
 
         EXIT DIALOG
 
      #交談指令共用ACTION
      &include "common_action.4gl" 
         CONTINUE DIALOG 
   END DIALOG
    
   #add-point:input段after input  name="input.after_input"
   IF g_flag THEN
      CALL amrm200_input('u')
   END IF
   IF INT_FLAG THEN
      LET INT_FLAG = 0
      CALL s_transaction_end('N','0')
   END IF
   CALL amrm200_fetch("") #151215-00002#3-add
   #end add-point    
 
END FUNCTION
 
{</section>}
 
{<section id="amrm200.show" >}
#+ 單頭資料重新顯示及單身資料重抓
PRIVATE FUNCTION amrm200_show()
   #add-point:show段define(客製用) name="show.define_customerization"
   
   #end add-point  
   DEFINE l_ac_t    LIKE type_t.num10
   #add-point:show段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="show.define"
   
   #end add-point  
   
   #add-point:Function前置處理 name="show.before"
   
   #end add-point
   
   
   
   IF g_bfill = "Y" THEN
      CALL amrm200_b_fill() #單身填充
      CALL amrm200_b_fill2('0') #單身填充
   END IF
     
   #帶出公用欄位reference值
   #應用 a12 樣板自動產生(Version:4)
 
 
 
   
   #顯示followup圖示
   #應用 a48 樣板自動產生(Version:3)
   CALL amrm200_set_pk_array()
   #add-point:ON ACTION agendum name="show.follow_pic"
   
   #END add-point
   CALL cl_user_overview_set_follow_pic()
  
 
 
 
   
   LET l_ac_t = l_ac
   
   #讀入ref值(單頭)
   #add-point:show段reference name="show.head.reference"
#            INITIALIZE g_ref_fields TO NULL
#            LET g_ref_fields[1] = g_mrba_m.mrba010
#            CALL ap_ref_array2(g_ref_fields,"SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001='1101' AND oocql002=? AND oocql003='"||g_dlang||"'","") RETURNING g_rtn_fields
#            LET g_mrba_m.mrba010_desc = '', g_rtn_fields[1] , ''
#            DISPLAY BY NAME g_mrba_m.mrba010_desc
#
#            INITIALIZE g_ref_fields TO NULL
#            LET g_ref_fields[1] = g_mrba_m.mrba011
#            CALL ap_ref_array2(g_ref_fields,"SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001='1102' AND oocql002=? AND oocql003='"||g_dlang||"'","") RETURNING g_rtn_fields
#            LET g_mrba_m.mrba011_desc = '', g_rtn_fields[1] , ''
#            DISPLAY BY NAME g_mrba_m.mrba011_desc
#
#            INITIALIZE g_ref_fields TO NULL
#            LET g_ref_fields[1] = g_mrba_m.mrba012
#            CALL ap_ref_array2(g_ref_fields,"SELECT oocgl003 FROM oocgl_t WHERE oocglent='"||g_enterprise||"' AND oocgl001=? AND oocgl002='"||g_dlang||"'","") RETURNING g_rtn_fields
#            LET g_mrba_m.mrba012_desc = '', g_rtn_fields[1] , ''
#            DISPLAY BY NAME g_mrba_m.mrba012_desc
#
#            INITIALIZE g_ref_fields TO NULL
#            LET g_ref_fields[1] = g_mrba_m.mrba013
#            CALL ap_ref_array2(g_ref_fields,"SELECT pmaal004 FROM pmaal_t WHERE pmaalent='"||g_enterprise||"' AND pmaal001=? AND pmaal002='"||g_dlang||"'","") RETURNING g_rtn_fields
#            LET g_mrba_m.mrba013_desc = '', g_rtn_fields[1] , ''
#            DISPLAY BY NAME g_mrba_m.mrba013_desc
#
#            INITIALIZE g_ref_fields TO NULL
#            LET g_ref_fields[1] = g_mrba_m.mrba014
#            CALL ap_ref_array2(g_ref_fields,"SELECT pmaal004 FROM pmaal_t WHERE pmaalent='"||g_enterprise||"' AND pmaal001=? AND pmaal002='"||g_dlang||"'","") RETURNING g_rtn_fields
#            LET g_mrba_m.mrba014_desc = '', g_rtn_fields[1] , ''
#            DISPLAY BY NAME g_mrba_m.mrba014_desc
#
#            INITIALIZE g_ref_fields TO NULL
#            LET g_ref_fields[1] = g_mrba_m.mrba016
#            CALL ap_ref_array2(g_ref_fields,"SELECT ooag011 FROM ooag_t WHERE ooagent='"||g_enterprise||"' AND ooag001=? ","") RETURNING g_rtn_fields
#            LET g_mrba_m.mrba016_desc = '', g_rtn_fields[1] , ''
#            DISPLAY BY NAME g_mrba_m.mrba016_desc
#
#            INITIALIZE g_ref_fields TO NULL
#            LET g_ref_fields[1] = g_mrba_m.mrba017
#            CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
#            LET g_mrba_m.mrba017_desc = '', g_rtn_fields[1] , ''
#            DISPLAY BY NAME g_mrba_m.mrba017_desc
#
#            CALL amrm200_mrba020_desc(g_mrba_m.mrba020)
#
#            INITIALIZE g_ref_fields TO NULL
#            LET g_ref_fields[1] = g_mrba_m.mrba021
#            CALL ap_ref_array2(g_ref_fields,"SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001='221' AND oocql002=? AND oocql003='"||g_dlang||"'","") RETURNING g_rtn_fields
#            LET g_mrba_m.mrba021_desc = '', g_rtn_fields[1] , ''
#            DISPLAY BY NAME g_mrba_m.mrba021_desc
#
#            INITIALIZE g_ref_fields TO NULL
#            LET g_ref_fields[1] = g_site
#            LET g_ref_fields[2] = g_mrba_m.mrba022
#            CALL ap_ref_array2(g_ref_fields,"SELECT ecaa002 FROM ecaa_t WHERE ecaaent='"||g_enterprise||"' AND ecaasite=? AND ecaa001=? ","") RETURNING g_rtn_fields
#            LET g_mrba_m.mrba022_desc = '', g_rtn_fields[1] , ''
#            DISPLAY BY NAME g_mrba_m.mrba022_desc
#
#            INITIALIZE g_ref_fields TO NULL
#            LET g_ref_fields[1] = g_mrba_m.mrba027
#            CALL ap_ref_array2(g_ref_fields,"SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001='1103' AND oocql002=? AND oocql003='"||g_dlang||"'","") RETURNING g_rtn_fields
#            LET g_mrba_m.mrba027_desc = '', g_rtn_fields[1] , ''
#            DISPLAY BY NAME g_mrba_m.mrba027_desc
#
#            INITIALIZE g_ref_fields TO NULL
#            LET g_ref_fields[1] = g_mrba_m.mrba040
#            CALL ap_ref_array2(g_ref_fields,"SELECT ooail003 FROM ooail_t WHERE ooailent='"||g_enterprise||"' AND ooail001=? AND ooail002='"||g_dlang||"'","") RETURNING g_rtn_fields
#            LET g_mrba_m.mrba040_desc = '', g_rtn_fields[1] , ''
#            DISPLAY BY NAME g_mrba_m.mrba040_desc
#
#            INITIALIZE g_ref_fields TO NULL
#            LET g_ref_fields[1] = g_mrba_m.mrbaownid
#            CALL ap_ref_array2(g_ref_fields,"SELECT ooag011 FROM ooag_t WHERE ooagent='"||g_enterprise||"' AND ooag001=? ","") RETURNING g_rtn_fields
#            LET g_mrba_m.mrbaownid_desc = '', g_rtn_fields[1] , ''
#            DISPLAY BY NAME g_mrba_m.mrbaownid_desc
#
#            INITIALIZE g_ref_fields TO NULL
#            LET g_ref_fields[1] = g_mrba_m.mrbaowndp
#            CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
#            LET g_mrba_m.mrbaowndp_desc = '', g_rtn_fields[1] , ''
#            DISPLAY BY NAME g_mrba_m.mrbaowndp_desc
#
#            INITIALIZE g_ref_fields TO NULL
#            LET g_ref_fields[1] = g_mrba_m.mrbacrtid
#            CALL ap_ref_array2(g_ref_fields,"SELECT ooag011 FROM ooag_t WHERE ooagent='"||g_enterprise||"' AND ooag001=? ","") RETURNING g_rtn_fields
#            LET g_mrba_m.mrbacrtid_desc = '', g_rtn_fields[1] , ''
#            DISPLAY BY NAME g_mrba_m.mrbacrtid_desc
#
#            INITIALIZE g_ref_fields TO NULL
#            LET g_ref_fields[1] = g_mrba_m.mrbacrtdp
#            CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
#            LET g_mrba_m.mrbacrtdp_desc = '', g_rtn_fields[1] , ''
#            DISPLAY BY NAME g_mrba_m.mrbacrtdp_desc
#
#            INITIALIZE g_ref_fields TO NULL
#            LET g_ref_fields[1] = g_mrba_m.mrbamodid
#            CALL ap_ref_array2(g_ref_fields,"SELECT ooag011 FROM ooag_t WHERE ooagent='"||g_enterprise||"' AND ooag001=? ","") RETURNING g_rtn_fields
#            LET g_mrba_m.mrbamodid_desc = '', g_rtn_fields[1] , ''
#            DISPLAY BY NAME g_mrba_m.mrbamodid_desc
#
#            INITIALIZE g_ref_fields TO NULL
#            LET g_ref_fields[1] = g_mrba_m.mrbacnfid
#            CALL ap_ref_array2(g_ref_fields,"SELECT ooag011 FROM ooag_t WHERE ooagent='"||g_enterprise||"' AND ooag001=? ","") RETURNING g_rtn_fields
#            LET g_mrba_m.mrbacnfid_desc = '', g_rtn_fields[1] , ''
#            DISPLAY BY NAME g_mrba_m.mrbacnfid_desc

   #end add-point
   
   #遮罩相關處理
   LET g_mrba_m_mask_o.* =  g_mrba_m.*
   CALL amrm200_mrba_t_mask()
   LET g_mrba_m_mask_n.* =  g_mrba_m.*
   
   #將資料輸出到畫面上
   DISPLAY BY NAME g_mrba_m.mrba019,g_mrba_m.mrba000,g_mrba_m.mrba001,g_mrba_m.mrba002,g_mrba_m.mrba003, 
       g_mrba_m.mrba066,g_mrba_m.mrba004,g_mrba_m.mrba005,g_mrba_m.mrba007,g_mrba_m.mrba008,g_mrba_m.mrba009, 
       g_mrba_m.mrba010,g_mrba_m.mrba010_desc,g_mrba_m.mrba011,g_mrba_m.mrba011_desc,g_mrba_m.mrba020, 
       g_mrba_m.mrba020_desc,g_mrba_m.mrba006,g_mrba_m.mrba104,g_mrba_m.mrba012,g_mrba_m.mrba012_desc, 
       g_mrba_m.mrba013,g_mrba_m.mrba013_desc,g_mrba_m.mrba014,g_mrba_m.mrba014_desc,g_mrba_m.mrba015, 
       g_mrba_m.mrba016,g_mrba_m.mrba016_desc,g_mrba_m.mrba017,g_mrba_m.mrba017_desc,g_mrba_m.mrba018, 
       g_mrba_m.mrba018_desc,g_mrba_m.mrba102,g_mrba_m.mrba100,g_mrba_m.mrba101,g_mrba_m.mrbastus,g_mrba_m.mrba021, 
       g_mrba_m.mrba021_desc,g_mrba_m.mrba022,g_mrba_m.mrba022_desc,g_mrba_m.mrba025,g_mrba_m.mrba026, 
       g_mrba_m.mrba027,g_mrba_m.mrba027_desc,g_mrba_m.mrba103,g_mrba_m.mrba103_desc,g_mrba_m.mrba029, 
       g_mrba_m.mrba031,g_mrba_m.mrba032,g_mrba_m.mrba033,g_mrba_m.mrba034,g_mrba_m.mrba035,g_mrba_m.mrba036, 
       g_mrba_m.mrba038,g_mrba_m.mrba039,g_mrba_m.mrba040,g_mrba_m.mrba040_desc,g_mrba_m.mrba041,g_mrba_m.mrba042, 
       g_mrba_m.mrbaownid,g_mrba_m.mrbaownid_desc,g_mrba_m.mrbaowndp,g_mrba_m.mrbaowndp_desc,g_mrba_m.mrbacrtid, 
       g_mrba_m.mrbacrtid_desc,g_mrba_m.mrbacrtdp,g_mrba_m.mrbacrtdp_desc,g_mrba_m.mrbacrtdt,g_mrba_m.mrbamodid, 
       g_mrba_m.mrbamodid_desc,g_mrba_m.mrbamoddt,g_mrba_m.mrbacnfid,g_mrba_m.mrbacnfid_desc,g_mrba_m.mrbacnfdt 
 
   
   #顯示狀態(stus)圖片
         #應用 a21 樣板自動產生(Version:3)
	  #根據當下狀態碼顯示圖片
      CASE g_mrba_m.mrbastus 
         WHEN "N"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/open.png")
         WHEN "Y"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/valid.png")
         WHEN "X"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/void.png")
         
      END CASE
 
 
 
   
   #讀入ref值(單身)
   FOR l_ac = 1 TO g_mrbb_d.getLength()
      #add-point:show段單身reference name="show.body.reference"
#            INITIALIZE g_ref_fields TO NULL
#            LET g_ref_fields[1] = g_mrbb_d[l_ac].mrbb003
#            CALL ap_ref_array2(g_ref_fields,"SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001='1104' AND oocql002=? AND oocql003='"||g_dlang||"'","") RETURNING g_rtn_fields
#            LET g_mrbb_d[l_ac].mrbb003_desc = '', g_rtn_fields[1] , ''
#            DISPLAY BY NAME g_mrbb_d[l_ac].mrbb003_desc
#
#            INITIALIZE g_ref_fields TO NULL
#            LET g_ref_fields[1] = g_mrbb_d[l_ac].mrbb004
#            CALL ap_ref_array2(g_ref_fields,"SELECT mraal003 FROM mraal_t WHERE mraalent='"||g_enterprise||"' AND mraal001=? AND mraal002='"||g_dlang||"'","") RETURNING g_rtn_fields
#            LET g_mrbb_d[l_ac].mrbb004_desc = '', g_rtn_fields[1] , ''
#            DISPLAY BY NAME g_mrbb_d[l_ac].mrbb004_desc
#
#            CALL amrm200_mrbb006_desc(g_mrbb_d[l_ac].mrbb006)
#
#            INITIALIZE g_ref_fields TO NULL
#            LET g_ref_fields[1] = g_mrbb_d[l_ac].mrbb012
#            CALL ap_ref_array2(g_ref_fields,"SELECT ooag011 FROM ooag_t WHERE ooagent='"||g_enterprise||"' AND ooag001=? ","") RETURNING g_rtn_fields
#            LET g_mrbb_d[l_ac].mrbb012_desc = '', g_rtn_fields[1] , ''
#            DISPLAY BY NAME g_mrbb_d[l_ac].mrbb012_desc

      #end add-point
   END FOR
   
   FOR l_ac = 1 TO g_mrbb2_d.getLength()
      #add-point:show段單身reference name="show.body2.reference"
      
      #end add-point
   END FOR
   FOR l_ac = 1 TO g_mrbb3_d.getLength()
      #add-point:show段單身reference name="show.body3.reference"
#            CALL amrm200_mrbd003_desc(g_mrbb3_d[l_ac].mrbd003)
#
#            INITIALIZE g_ref_fields TO NULL
#            LET g_ref_fields[1] = g_mrbb3_d[l_ac].mrbd005
#            CALL ap_ref_array2(g_ref_fields,"SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001='1105' AND oocql002=? AND oocql003='"||g_dlang||"'","") RETURNING g_rtn_fields
#            LET g_mrbb3_d[l_ac].mrbd005_desc = '', g_rtn_fields[1] , ''
#            DISPLAY BY NAME g_mrbb3_d[l_ac].mrbd005_desc
#
#            INITIALIZE g_ref_fields TO NULL
#            LET g_ref_fields[1] = g_mrbb3_d[l_ac].mrbd006
#            CALL ap_ref_array2(g_ref_fields,"SELECT oocal003 FROM oocal_t WHERE oocalent='"||g_enterprise||"' AND oocal001=? AND oocal002='"||g_dlang||"'","") RETURNING g_rtn_fields
#            LET g_mrbb3_d[l_ac].mrbd006_desc = '', g_rtn_fields[1] , ''
#            DISPLAY BY NAME g_mrbb3_d[l_ac].mrbd006_desc

      #end add-point
   END FOR
   FOR l_ac = 1 TO g_mrbb4_d.getLength()
      #add-point:show段單身reference name="show.body4.reference"
#            CALL amrm200_mrbe002_desc(g_mrbb4_d[l_ac].mrbe002)

      #end add-point
   END FOR
   FOR l_ac = 1 TO g_mrbb5_d.getLength()
      #add-point:show段單身reference name="show.body5.reference"
#            CALL amrm200_mrbf002_desc(g_mrbb5_d[l_ac].mrbf002)

      #end add-point
   END FOR
   FOR l_ac = 1 TO g_mrbb6_d.getLength()
      #add-point:show段單身reference name="show.body6.reference"
#            INITIALIZE g_ref_fields TO NULL
#            LET g_ref_fields[1] = g_mrbb6_d[l_ac].mrbg004
#            CALL ap_ref_array2(g_ref_fields,"SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001='1107' AND oocql002=? AND oocql003='"||g_dlang||"'","") RETURNING g_rtn_fields
#            LET g_mrbb6_d[l_ac].mrbg004_desc = '', g_rtn_fields[1] , ''
#            DISPLAY BY NAME g_mrbb6_d[l_ac].mrbg004_desc

      #end add-point
   END FOR
 
   
    
   
   #add-point:show段other name="show.other"
   
   #end add-point  
   
   LET l_ac = l_ac_t
   
   #移動上下筆可以連動切換資料
   CALL cl_show_fld_cont()     
 
   CALL amrm200_detail_show()
 
   #add-point:show段之後 name="show.after"
   
   #end add-point
   
END FUNCTION
 
{</section>}
 
{<section id="amrm200.detail_show" >}
#+ 第二階單身reference
PRIVATE FUNCTION amrm200_detail_show()
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
 
{<section id="amrm200.reproduce" >}
#+ 資料複製
PRIVATE FUNCTION amrm200_reproduce()
   #add-point:reproduce段define(客製用) name="reproduce.define_customerization"
   
   #end add-point   
   DEFINE l_newno     LIKE mrba_t.mrba001 
   DEFINE l_oldno     LIKE mrba_t.mrba001 
 
   DEFINE l_master    RECORD LIKE mrba_t.* #此變數樣板目前無使用
   DEFINE l_detail    RECORD LIKE mrbb_t.* #此變數樣板目前無使用
   DEFINE l_detail2    RECORD LIKE mrbc_t.* #此變數樣板目前無使用
 
   DEFINE l_detail3    RECORD LIKE mrbd_t.* #此變數樣板目前無使用
 
   DEFINE l_detail4    RECORD LIKE mrbe_t.* #此變數樣板目前無使用
 
   DEFINE l_detail5    RECORD LIKE mrbf_t.* #此變數樣板目前無使用
 
   DEFINE l_detail6    RECORD LIKE mrbg_t.* #此變數樣板目前無使用
 
 
 
   DEFINE l_cnt       LIKE type_t.num10
   #add-point:reproduce段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="reproduce.define"
   
   #end add-point   
   
   #add-point:Function前置處理  name="reproduce.pre_function"
   
   #end add-point
   
   #切換畫面
   IF g_main_hidden THEN
      CALL gfrm_curr.setElementHidden("mainlayout",0)
      CALL gfrm_curr.setElementHidden("worksheet",1)
      LET g_main_hidden = 0
   END IF
   
   LET g_master_insert = FALSE
   
   IF g_mrba_m.mrba001 IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code = "std-00003" 
      LET g_errparam.popup = FALSE 
      CALL cl_err()
      RETURN
   END IF
    
   LET g_mrba001_t = g_mrba_m.mrba001
 
    
   LET g_mrba_m.mrba001 = ""
 
 
   CALL cl_set_head_visible("","YES")
 
   #公用欄位給予預設值
   #應用 a14 樣板自動產生(Version:5)    
      #公用欄位新增給值  
      LET g_mrba_m.mrbaownid = g_user
      LET g_mrba_m.mrbaowndp = g_dept
      LET g_mrba_m.mrbacrtid = g_user
      LET g_mrba_m.mrbacrtdp = g_dept 
      LET g_mrba_m.mrbacrtdt = cl_get_current()
      LET g_mrba_m.mrbamodid = g_user
      LET g_mrba_m.mrbamoddt = cl_get_current()
      LET g_mrba_m.mrbastus = 'N'
 
 
 
   
   CALL s_transaction_begin()
   
   #add-point:複製輸入前 name="reproduce.head.b_input"
      LET g_mrba_m.mrbacnfid = ""
      LET g_mrba_m.mrbacnfdt = ""
      LET g_mrba_m.mrbastus = "N"
      LET g_mrba_m.mrba100 = "0"
   #end add-point
   
   #顯示狀態(stus)圖片
         #應用 a21 樣板自動產生(Version:3)
	  #根據當下狀態碼顯示圖片
      CASE g_mrba_m.mrbastus 
         WHEN "N"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/open.png")
         WHEN "Y"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/valid.png")
         WHEN "X"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/void.png")
         
      END CASE
 
 
 
   
   #清空key欄位的desc
   
   
   CALL amrm200_input("r")
   
   IF INT_FLAG AND NOT g_master_insert THEN
      LET INT_FLAG = 0
      DISPLAY g_detail_cnt  TO FORMONLY.h_count    #總筆數
      DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
      LET INT_FLAG = 0
      INITIALIZE g_mrba_m.* TO NULL
      INITIALIZE g_mrbb_d TO NULL
      INITIALIZE g_mrbb2_d TO NULL
      INITIALIZE g_mrbb3_d TO NULL
      INITIALIZE g_mrbb4_d TO NULL
      INITIALIZE g_mrbb5_d TO NULL
      INITIALIZE g_mrbb6_d TO NULL
 
      #add-point:複製取消後 name="reproduce.cancel"
      
      #end add-point
      CALL amrm200_show()
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
   CALL amrm200_set_act_visible()   
   CALL amrm200_set_act_no_visible()
   
   #將新增的資料併入搜尋條件中
   LET g_mrba001_t = g_mrba_m.mrba001
 
   
   #組合新增資料的條件
   LET g_add_browse = " mrbaent = " ||g_enterprise|| " AND mrbasite = '" ||g_site|| "' AND",
                      " mrba001 = '", g_mrba_m.mrba001, "' "
 
   #填到最後面
   LET g_current_idx = g_browser.getLength() + 1
   CALL amrm200_browser_fill("")
   
   DISPLAY g_browser_cnt TO FORMONLY.h_count    #總筆數
   DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
   CALL cl_navigator_setting(g_current_idx, g_browser_cnt)
   
   #add-point:完成複製段落後 name="reproduce.after_reproduce"
   
   #end add-point
   
   CALL amrm200_idx_chk()
   
   LET g_data_owner = g_mrba_m.mrbaownid      
   LET g_data_dept  = g_mrba_m.mrbaowndp
   
   #功能已完成,通報訊息中心
   CALL amrm200_msgcentre_notify('reproduce')
 
END FUNCTION
 
{</section>}
 
{<section id="amrm200.detail_reproduce" >}
#+ 單身自動複製
PRIVATE FUNCTION amrm200_detail_reproduce()
   #add-point:delete段define(客製用) name="detail_reproduce.define_customerization"
   
   #end add-point    
   DEFINE ls_sql      STRING
   DEFINE ld_date     DATETIME YEAR TO SECOND
   DEFINE l_detail    RECORD LIKE mrbb_t.* #此變數樣板目前無使用
   DEFINE l_detail2    RECORD LIKE mrbc_t.* #此變數樣板目前無使用
 
   DEFINE l_detail3    RECORD LIKE mrbd_t.* #此變數樣板目前無使用
 
   DEFINE l_detail4    RECORD LIKE mrbe_t.* #此變數樣板目前無使用
 
   DEFINE l_detail5    RECORD LIKE mrbf_t.* #此變數樣板目前無使用
 
   DEFINE l_detail6    RECORD LIKE mrbg_t.* #此變數樣板目前無使用
 
 
 
   #add-point:delete段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="detail_reproduce.define"
   
   #end add-point    
   
   #add-point:Function前置處理  name="detail_reproduce.pre_function"
   
   #end add-point
   
   CALL s_transaction_begin()
   
   LET ld_date = cl_get_current()
   
   DROP TABLE amrm200_detail
   
   #add-point:單身複製前1 name="detail_reproduce.body.table1.b_insert"
   
   #end add-point
   
   #CREATE TEMP TABLE
   SELECT * FROM mrbb_t
    WHERE mrbbent = g_enterprise AND mrbbsite = g_site AND mrbb001 = g_mrba001_t
 
    INTO TEMP amrm200_detail
 
   #將key修正為調整後   
   UPDATE amrm200_detail 
      #更新key欄位
      SET mrbb001 = g_mrba_m.mrba001
 
      #更新共用欄位
      #應用 a13 樣板自動產生(Version:4)
      #, mrbbstus = "Y" 
 
 
 
 
   #add-point:單身修改前 name="detail_reproduce.body.table1.b_update"
   
   #end add-point                                       
  
   #將資料塞回原table   
   INSERT INTO mrbb_t SELECT * FROM amrm200_detail
   
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
   DROP TABLE amrm200_detail
   
   #add-point:單身複製後1 name="detail_reproduce.body.table1.a_insert"
   
   #end add-point
 
   #add-point:單身複製前 name="detail_reproduce.body.table2.b_insert"
   
   #end add-point
   
   #CREATE TEMP TABLE
   SELECT * FROM mrbc_t 
    WHERE mrbcent = g_enterprise AND mrbcsite = g_site AND mrbc001 = g_mrba001_t
 
    INTO TEMP amrm200_detail
 
   #將key修正為調整後   
   UPDATE amrm200_detail SET mrbc001 = g_mrba_m.mrba001
 
  
   #add-point:單身修改前 name="detail_reproduce.body.table2.b_update"
   
   #end add-point    
 
   #將資料塞回原table   
   INSERT INTO mrbc_t SELECT * FROM amrm200_detail
   
   #add-point:單身複製中 name="detail_reproduce.body.table2.m_insert"
   
   #end add-point
   
   #刪除TEMP TABLE
   DROP TABLE amrm200_detail
   
   #add-point:單身複製後 name="detail_reproduce.body.table2.a_insert"
   
   #end add-point
 
   #add-point:單身複製前 name="detail_reproduce.body.table3.b_insert"
   
   #end add-point
   
   #CREATE TEMP TABLE
   SELECT * FROM mrbd_t 
    WHERE mrbdent = g_enterprise AND mrbdsite = g_site AND mrbd001 = g_mrba001_t
 
    INTO TEMP amrm200_detail
 
   #將key修正為調整後   
   UPDATE amrm200_detail SET mrbd001 = g_mrba_m.mrba001
 
  
   #add-point:單身修改前 name="detail_reproduce.body.table3.b_update"
   
   #end add-point    
 
   #將資料塞回原table   
   INSERT INTO mrbd_t SELECT * FROM amrm200_detail
   
   #add-point:單身複製中 name="detail_reproduce.body.table3.m_insert"
   
   #end add-point
   
   #刪除TEMP TABLE
   DROP TABLE amrm200_detail
   
   #add-point:單身複製後 name="detail_reproduce.body.table3.a_insert"
   
   #end add-point
 
   #add-point:單身複製前 name="detail_reproduce.body.table4.b_insert"
   
   #end add-point
   
   #CREATE TEMP TABLE
   SELECT * FROM mrbe_t 
    WHERE mrbeent = g_enterprise AND mrbesite = g_site AND mrbe001 = g_mrba001_t
 
    INTO TEMP amrm200_detail
 
   #將key修正為調整後   
   UPDATE amrm200_detail SET mrbe001 = g_mrba_m.mrba001
 
  
   #add-point:單身修改前 name="detail_reproduce.body.table4.b_update"
   
   #end add-point    
 
   #將資料塞回原table   
   INSERT INTO mrbe_t SELECT * FROM amrm200_detail
   
   #add-point:單身複製中 name="detail_reproduce.body.table4.m_insert"
   
   #end add-point
   
   #刪除TEMP TABLE
   DROP TABLE amrm200_detail
   
   #add-point:單身複製後 name="detail_reproduce.body.table4.a_insert"
   
   #end add-point
 
   #add-point:單身複製前 name="detail_reproduce.body.table5.b_insert"
   
   #end add-point
   
   #CREATE TEMP TABLE
   SELECT * FROM mrbf_t 
    WHERE mrbfent = g_enterprise AND mrbfsite = g_site AND mrbf001 = g_mrba001_t
 
    INTO TEMP amrm200_detail
 
   #將key修正為調整後   
   UPDATE amrm200_detail SET mrbf001 = g_mrba_m.mrba001
 
  
   #add-point:單身修改前 name="detail_reproduce.body.table5.b_update"
   
   #end add-point    
 
   #將資料塞回原table   
   INSERT INTO mrbf_t SELECT * FROM amrm200_detail
   
   #add-point:單身複製中 name="detail_reproduce.body.table5.m_insert"
   
   #end add-point
   
   #刪除TEMP TABLE
   DROP TABLE amrm200_detail
   
   #add-point:單身複製後 name="detail_reproduce.body.table5.a_insert"
   
   #end add-point
 
   #add-point:單身複製前 name="detail_reproduce.body.table6.b_insert"
   
   #end add-point
   
   #CREATE TEMP TABLE
   SELECT * FROM mrbg_t 
    WHERE mrbgent = g_enterprise AND mrbgsite = g_site AND mrbg001 = g_mrba001_t
 
    INTO TEMP amrm200_detail
 
   #將key修正為調整後   
   UPDATE amrm200_detail SET mrbg001 = g_mrba_m.mrba001
 
  
   #add-point:單身修改前 name="detail_reproduce.body.table6.b_update"
   
   #end add-point    
 
   #將資料塞回原table   
   INSERT INTO mrbg_t SELECT * FROM amrm200_detail
   
   #add-point:單身複製中 name="detail_reproduce.body.table6.m_insert"
   
   #end add-point
   
   #刪除TEMP TABLE
   DROP TABLE amrm200_detail
   
   #add-point:單身複製後 name="detail_reproduce.body.table6.a_insert"
   
   #end add-point
 
 
   
 
   
   #多語言複製段落
   
   
   CALL s_transaction_end('Y','0')
   
   #已新增完, 調整資料內容(修改時使用)
   LET g_mrba001_t = g_mrba_m.mrba001
 
   
END FUNCTION
 
{</section>}
 
{<section id="amrm200.delete" >}
#+ 資料刪除
PRIVATE FUNCTION amrm200_delete()
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
   
   IF g_mrba_m.mrba001 IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code = "std-00003" 
      LET g_errparam.popup = FALSE 
      CALL cl_err()
      RETURN
   END IF
   
   
   
   CALL s_transaction_begin()
 
   OPEN amrm200_cl USING g_enterprise, g_site,g_mrba_m.mrba001
   IF SQLCA.SQLCODE THEN   #(ver:78)
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "OPEN amrm200_cl:",SQLERRMESSAGE 
      LET g_errparam.code = SQLCA.SQLCODE   #(ver:78)
      LET g_errparam.popup = TRUE 
      CLOSE amrm200_cl
      CALL s_transaction_end('N','0')
      CALL cl_err()
      RETURN
   END IF
 
   #顯示最新的資料
   EXECUTE amrm200_master_referesh USING g_site,g_mrba_m.mrba001 INTO g_mrba_m.mrba019,g_mrba_m.mrba000, 
       g_mrba_m.mrba001,g_mrba_m.mrba002,g_mrba_m.mrba003,g_mrba_m.mrba066,g_mrba_m.mrba004,g_mrba_m.mrba005, 
       g_mrba_m.mrba007,g_mrba_m.mrba008,g_mrba_m.mrba009,g_mrba_m.mrba010,g_mrba_m.mrba011,g_mrba_m.mrba020, 
       g_mrba_m.mrba006,g_mrba_m.mrba104,g_mrba_m.mrba012,g_mrba_m.mrba013,g_mrba_m.mrba014,g_mrba_m.mrba015, 
       g_mrba_m.mrba016,g_mrba_m.mrba017,g_mrba_m.mrba018,g_mrba_m.mrba102,g_mrba_m.mrba100,g_mrba_m.mrba101, 
       g_mrba_m.mrbastus,g_mrba_m.mrba021,g_mrba_m.mrba022,g_mrba_m.mrba025,g_mrba_m.mrba026,g_mrba_m.mrba027, 
       g_mrba_m.mrba103,g_mrba_m.mrba029,g_mrba_m.mrba031,g_mrba_m.mrba032,g_mrba_m.mrba033,g_mrba_m.mrba034, 
       g_mrba_m.mrba035,g_mrba_m.mrba036,g_mrba_m.mrba038,g_mrba_m.mrba039,g_mrba_m.mrba040,g_mrba_m.mrba041, 
       g_mrba_m.mrba042,g_mrba_m.mrbaownid,g_mrba_m.mrbaowndp,g_mrba_m.mrbacrtid,g_mrba_m.mrbacrtdp, 
       g_mrba_m.mrbacrtdt,g_mrba_m.mrbamodid,g_mrba_m.mrbamoddt,g_mrba_m.mrbacnfid,g_mrba_m.mrbacnfdt, 
       g_mrba_m.mrba010_desc,g_mrba_m.mrba011_desc,g_mrba_m.mrba020_desc,g_mrba_m.mrba012_desc,g_mrba_m.mrba013_desc, 
       g_mrba_m.mrba014_desc,g_mrba_m.mrba016_desc,g_mrba_m.mrba017_desc,g_mrba_m.mrba018_desc,g_mrba_m.mrba021_desc, 
       g_mrba_m.mrba022_desc,g_mrba_m.mrba027_desc,g_mrba_m.mrba103_desc,g_mrba_m.mrba040_desc,g_mrba_m.mrbaownid_desc, 
       g_mrba_m.mrbaowndp_desc,g_mrba_m.mrbacrtid_desc,g_mrba_m.mrbacrtdp_desc,g_mrba_m.mrbamodid_desc, 
       g_mrba_m.mrbacnfid_desc
   
   
   #檢查是否允許此動作
   IF NOT amrm200_action_chk() THEN
      CALL s_transaction_end('N','0')
      RETURN
   END IF
   
   #遮罩相關處理
   LET g_mrba_m_mask_o.* =  g_mrba_m.*
   CALL amrm200_mrba_t_mask()
   LET g_mrba_m_mask_n.* =  g_mrba_m.*
   
   CALL amrm200_show()
   
   #add-point:delete段before ask name="delete.before_ask"
   
   #end add-point 
 
   IF cl_ask_del_master() THEN              #確認一下
   
      #add-point:單頭刪除前 name="delete.head.b_delete"
      
      #end add-point   
      
      #應用 a47 樣板自動產生(Version:4)
      #刪除相關文件
      CALL amrm200_set_pk_array()
      #add-point:相關文件刪除前 name="delete.befroe.related_document_remove"
      
      #end add-point   
      CALL cl_doc_remove()  
 
 
 
  
  
      #資料備份
      LET g_mrba001_t = g_mrba_m.mrba001
 
 
      DELETE FROM mrba_t
       WHERE mrbaent = g_enterprise AND mrbasite = g_site AND mrba001 = g_mrba_m.mrba001
 
       
      #add-point:單頭刪除中 name="delete.head.m_delete"
      
      #end add-point
       
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = g_mrba_m.mrba001,":",SQLERRMESSAGE  
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
      
      DELETE FROM mrbb_t
       WHERE mrbbent = g_enterprise AND mrbbsite = g_site AND mrbb001 = g_mrba_m.mrba001
 
 
      #add-point:單身刪除中 name="delete.body.m_delete"
      
      #end add-point
         
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "mrbb_t:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = FALSE 
         CALL s_transaction_end('N','0')
         CALL cl_err()
         RETURN
      END IF    
 
      #add-point:單身刪除後 name="delete.body.a_delete"
      IF g_smfg0036 = '2' THEN   #160801-00023#4
         CALL amrm200_del_mrbi() #151215-00002#3-add
      END IF         #160801-00023#4
      #end add-point
      
            
                                                               
      #add-point:單身刪除前 name="delete.body.b_delete2"
      
      #end add-point
      DELETE FROM mrbc_t
       WHERE mrbcent = g_enterprise AND mrbcsite = g_site AND
             mrbc001 = g_mrba_m.mrba001
      #add-point:單身刪除中 name="delete.body.m_delete2"
      
      #end add-point
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "mrbc_t:",SQLERRMESSAGE 
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
      DELETE FROM mrbd_t
       WHERE mrbdent = g_enterprise AND mrbdsite = g_site AND
             mrbd001 = g_mrba_m.mrba001
      #add-point:單身刪除中 name="delete.body.m_delete3"
      
      #end add-point
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "mrbd_t:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = FALSE 
         CALL s_transaction_end('N','0')
         CALL cl_err()
         RETURN
      END IF      
 
      #add-point:單身刪除後 name="delete.body.a_delete3"
      
      #end add-point
 
      #add-point:單身刪除前 name="delete.body.b_delete4"
      
      #end add-point
      DELETE FROM mrbe_t
       WHERE mrbeent = g_enterprise AND mrbesite = g_site AND
             mrbe001 = g_mrba_m.mrba001
      #add-point:單身刪除中 name="delete.body.m_delete4"
      
      #end add-point
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "mrbe_t:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = FALSE 
         CALL s_transaction_end('N','0')
         CALL cl_err()
         RETURN
      END IF      
 
      #add-point:單身刪除後 name="delete.body.a_delete4"
      
      #end add-point
 
      #add-point:單身刪除前 name="delete.body.b_delete5"
      
      #end add-point
      DELETE FROM mrbf_t
       WHERE mrbfent = g_enterprise AND mrbfsite = g_site AND
             mrbf001 = g_mrba_m.mrba001
      #add-point:單身刪除中 name="delete.body.m_delete5"
      
      #end add-point
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "mrbf_t:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = FALSE 
         CALL s_transaction_end('N','0')
         CALL cl_err()
         RETURN
      END IF      
 
      #add-point:單身刪除後 name="delete.body.a_delete5"
      
      #end add-point
 
      #add-point:單身刪除前 name="delete.body.b_delete6"
      
      #end add-point
      DELETE FROM mrbg_t
       WHERE mrbgent = g_enterprise AND mrbgsite = g_site AND
             mrbg001 = g_mrba_m.mrba001
      #add-point:單身刪除中 name="delete.body.m_delete6"
      
      #end add-point
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "mrbg_t:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = FALSE 
         CALL s_transaction_end('N','0')
         CALL cl_err()
         RETURN
      END IF      
 
      #add-point:單身刪除後 name="delete.body.a_delete6"
      
      #end add-point
 
 
 
 
      
      #修改歷程記錄(刪除)
      LET g_log1 = util.JSON.stringify(g_mrba_m)   #(ver:78)
      IF NOT cl_log_modified_record(g_log1,'') THEN    #(ver:78)
         CLOSE amrm200_cl
         CALL s_transaction_end('N','0')
         RETURN
      END IF
             
      CLEAR FORM
      CALL g_mrbb_d.clear() 
      CALL g_mrbb2_d.clear()       
      CALL g_mrbb3_d.clear()       
      CALL g_mrbb4_d.clear()       
      CALL g_mrbb5_d.clear()       
      CALL g_mrbb6_d.clear()       
 
     
      CALL amrm200_ui_browser_refresh()  
      #CALL amrm200_ui_headershow()  
      #CALL amrm200_ui_detailshow()
 
      #add-point:多語言刪除 name="delete.lang.before_delete"
      
      #end add-point
      
      #單頭多語言刪除
      
      
      #單身多語言刪除
      
      
      
      
      
      
 
   
      #add-point:多語言刪除 name="delete.lang.delete"
      
      #end add-point
      
      IF g_browser_cnt > 0 THEN 
         #CALL amrm200_browser_fill("")
         CALL amrm200_fetch('P')
         DISPLAY g_browser_cnt TO FORMONLY.h_count   #總筆數的顯示
         DISPLAY g_browser_cnt TO FORMONLY.b_count   #總筆數的顯示
      ELSE
         CLEAR FORM
      END IF
      
      CALL s_transaction_end('Y','0')
   ELSE
      CALL s_transaction_end('N','0')
   END IF
 
   CLOSE amrm200_cl
 
   #功能已完成,通報訊息中心
   CALL amrm200_msgcentre_notify('delete')
    
END FUNCTION
 
{</section>}
 
{<section id="amrm200.b_fill" >}
#+ 單身陣列填充
PRIVATE FUNCTION amrm200_b_fill()
   #add-point:b_fill段define(客製用) name="b_fill.define_customerization"
   
   #end add-point     
   DEFINE p_wc2      STRING
   DEFINE li_idx     LIKE type_t.num10
   #add-point:b_fill段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="b_fill.define"
   
   #end add-point     
   
   #add-point:Function前置處理  name="b_fill.pre_function"
   
   #end add-point
   
   #清空第一階單身
   CALL g_mrbb_d.clear()
   CALL g_mrbb2_d.clear()
   CALL g_mrbb3_d.clear()
   CALL g_mrbb4_d.clear()
   CALL g_mrbb5_d.clear()
   CALL g_mrbb6_d.clear()
 
 
   #add-point:b_fill段sql_before name="b_fill.sql_before"
   
   #end add-point
   
   #判斷是否填充
   IF amrm200_fill_chk(1) THEN
      #切換上下筆時不重組SQL
      IF (g_action_choice = "query" OR cl_null(g_action_choice))
      #add-point:b_fill段long_sql_if name="b_fill.long_sql_if"
      
      #end add-point
      THEN
         LET g_sql = "SELECT  DISTINCT mrbbstus,mrbb002,mrbb003,mrbb004,mrbb005,mrbb006,mrbb007,mrbb008, 
             mrbb009,mrbb010,mrbb011,mrbb012,mrbb013 ,t1.oocql004 ,t2.mraal003 ,t3.ooefl003 ,t4.ooag011 FROM mrbb_t", 
                
                     " INNER JOIN mrba_t ON mrbaent = " ||g_enterprise|| " AND mrbasite = '" ||g_site|| "' AND mrba001 = mrbb001 ",
 
                     #"",
                     
                     "",
                     #下層單身所需的join條件
 
                                    " LEFT JOIN oocql_t t1 ON t1.oocqlent="||g_enterprise||" AND t1.oocql001='1104' AND t1.oocql002=mrbb003 AND t1.oocql003='"||g_dlang||"' ",
               " LEFT JOIN mraal_t t2 ON t2.mraalent="||g_enterprise||" AND t2.mraal001=mrbb004 AND t2.mraal002='"||g_dlang||"' ",
               " LEFT JOIN ooefl_t t3 ON t3.ooeflent="||g_enterprise||" AND t3.ooefl001=mrbb006 AND t3.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t4 ON t4.ooagent="||g_enterprise||" AND t4.ooag001=mrbb012  ",
 
                     " WHERE mrbbent=? AND mrbbsite=? AND mrbb001=?"
         LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
         #add-point:b_fill段sql_before name="b_fill.body.fill_sql"
         
         #end add-point
         IF NOT cl_null(g_wc2_table1) THEN
            LET g_sql = g_sql CLIPPED, " AND ", g_wc2_table1 CLIPPED
         END IF
         
         #子單身的WC
         
         
         LET g_sql = g_sql, " ORDER BY mrbb_t.mrbb002"
         
         #add-point:單身填充控制 name="b_fill.sql"
         
         #end add-point
         
         LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
         PREPARE amrm200_pb FROM g_sql
         DECLARE b_fill_cs CURSOR FOR amrm200_pb
      END IF
      
      LET g_cnt = l_ac
      LET l_ac = 1
      
   #  OPEN b_fill_cs USING g_enterprise, g_site,g_mrba_m.mrba001   #(ver:78)
                                               
      FOREACH b_fill_cs USING g_enterprise, g_site,g_mrba_m.mrba001 INTO g_mrbb_d[l_ac].mrbbstus,g_mrbb_d[l_ac].mrbb002, 
          g_mrbb_d[l_ac].mrbb003,g_mrbb_d[l_ac].mrbb004,g_mrbb_d[l_ac].mrbb005,g_mrbb_d[l_ac].mrbb006, 
          g_mrbb_d[l_ac].mrbb007,g_mrbb_d[l_ac].mrbb008,g_mrbb_d[l_ac].mrbb009,g_mrbb_d[l_ac].mrbb010, 
          g_mrbb_d[l_ac].mrbb011,g_mrbb_d[l_ac].mrbb012,g_mrbb_d[l_ac].mrbb013,g_mrbb_d[l_ac].mrbb003_desc, 
          g_mrbb_d[l_ac].mrbb004_desc,g_mrbb_d[l_ac].mrbb006_desc,g_mrbb_d[l_ac].mrbb012_desc   #(ver:78) 
 
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
   IF amrm200_fill_chk(2) THEN
      IF (g_action_choice = "query" OR cl_null(g_action_choice))
         #add-point:b_fill段long_sql_if name="b_fill.body2.long_sql_if"
         
         #end add-point
      THEN
         LET g_sql = "SELECT  DISTINCT mrbc002,mrbc003,mrbc004,mrbc005,mrbc006,mrbc007,mrbc008,mrbc009, 
             mrbc010,mrbc011  FROM mrbc_t",   
                     " INNER JOIN  mrba_t ON mrbaent = " ||g_enterprise|| " AND mrbasite = '" ||g_site|| "' AND mrba001 = mrbc001 ",
 
                     "",
                     
                     
                     " WHERE mrbcent=? AND mrbcsite=? AND mrbc001=?"   
         LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
         #add-point:b_fill段fill_sql name="b_fill.body2.fill_sql"
         
         #end add-point
         IF NOT cl_null(g_wc2_table2) THEN
            LET g_sql = g_sql CLIPPED," AND ",g_wc2_table2 CLIPPED
         END IF
         
         #子單身的WC
         
         
         LET g_sql = g_sql, " ORDER BY mrbc_t.mrbc002"
         
         #add-point:單身填充控制 name="b_fill.sql2"
         
         #end add-point
         
         LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
         PREPARE amrm200_pb2 FROM g_sql
         DECLARE b_fill_cs2 CURSOR FOR amrm200_pb2
      END IF
    
      LET l_ac = 1
      
   #  OPEN b_fill_cs2 USING g_enterprise, g_site,g_mrba_m.mrba001   #(ver:78)
                                               
      FOREACH b_fill_cs2 USING g_enterprise, g_site,g_mrba_m.mrba001 INTO g_mrbb2_d[l_ac].mrbc002,g_mrbb2_d[l_ac].mrbc003, 
          g_mrbb2_d[l_ac].mrbc004,g_mrbb2_d[l_ac].mrbc005,g_mrbb2_d[l_ac].mrbc006,g_mrbb2_d[l_ac].mrbc007, 
          g_mrbb2_d[l_ac].mrbc008,g_mrbb2_d[l_ac].mrbc009,g_mrbb2_d[l_ac].mrbc010,g_mrbb2_d[l_ac].mrbc011  
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
   IF amrm200_fill_chk(3) THEN
      IF (g_action_choice = "query" OR cl_null(g_action_choice))
         #add-point:b_fill段long_sql_if name="b_fill.body3.long_sql_if"
         
         #end add-point
      THEN
         LET g_sql = "SELECT  DISTINCT mrbd002,mrbd003,mrbd004,mrbd005,mrbd006,mrbd007,mrbd008,mrbd009, 
             mrbd010 ,t5.imaal003 ,t6.imaal004 ,t7.oocql004 ,t8.oocal003 FROM mrbd_t",   
                     " INNER JOIN  mrba_t ON mrbaent = " ||g_enterprise|| " AND mrbasite = '" ||g_site|| "' AND mrba001 = mrbd001 ",
 
                     "",
                     
                                    " LEFT JOIN imaal_t t5 ON t5.imaalent="||g_enterprise||" AND t5.imaal001=mrbd003 AND t5.imaal002='"||g_dlang||"' ",
               " LEFT JOIN imaal_t t6 ON t6.imaalent="||g_enterprise||" AND t6.imaal001=mrbd003 AND t6.imaal002='"||g_dlang||"' ",
               " LEFT JOIN oocql_t t7 ON t7.oocqlent="||g_enterprise||" AND t7.oocql001='1105' AND t7.oocql002=mrbd005 AND t7.oocql003='"||g_dlang||"' ",
               " LEFT JOIN oocal_t t8 ON t8.oocalent="||g_enterprise||" AND t8.oocal001=mrbd006 AND t8.oocal002='"||g_dlang||"' ",
 
                     " WHERE mrbdent=? AND mrbdsite=? AND mrbd001=?"   
         LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
         #add-point:b_fill段fill_sql name="b_fill.body3.fill_sql"
         
         #end add-point
         IF NOT cl_null(g_wc2_table3) THEN
            LET g_sql = g_sql CLIPPED," AND ",g_wc2_table3 CLIPPED
         END IF
         
         #子單身的WC
         
         
         LET g_sql = g_sql, " ORDER BY mrbd_t.mrbd002"
         
         #add-point:單身填充控制 name="b_fill.sql3"
         
         #end add-point
         
         LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
         PREPARE amrm200_pb3 FROM g_sql
         DECLARE b_fill_cs3 CURSOR FOR amrm200_pb3
      END IF
    
      LET l_ac = 1
      
   #  OPEN b_fill_cs3 USING g_enterprise, g_site,g_mrba_m.mrba001   #(ver:78)
                                               
      FOREACH b_fill_cs3 USING g_enterprise, g_site,g_mrba_m.mrba001 INTO g_mrbb3_d[l_ac].mrbd002,g_mrbb3_d[l_ac].mrbd003, 
          g_mrbb3_d[l_ac].mrbd004,g_mrbb3_d[l_ac].mrbd005,g_mrbb3_d[l_ac].mrbd006,g_mrbb3_d[l_ac].mrbd007, 
          g_mrbb3_d[l_ac].mrbd008,g_mrbb3_d[l_ac].mrbd009,g_mrbb3_d[l_ac].mrbd010,g_mrbb3_d[l_ac].mrbd003_desc, 
          g_mrbb3_d[l_ac].mrbd003_desc_desc,g_mrbb3_d[l_ac].mrbd005_desc,g_mrbb3_d[l_ac].mrbd006_desc  
            #(ver:78)
         IF SQLCA.SQLCODE THEN
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "FOREACH:",SQLERRMESSAGE 
            LET g_errparam.code = SQLCA.SQLCODE 
            LET g_errparam.popup = TRUE 
            CALL cl_err()
            EXIT FOREACH
         END IF
        
         #add-point:b_fill段資料填充 name="b_fill3.fill"
         SELECT SUM(inag008) INTO g_mrbb3_d[l_ac].inag008 FROM inag_t WHERE inag001 = g_mrbb3_d[l_ac].mrbd003 
            AND inag007 = g_mrbb3_d[l_ac].mrbd006 AND inagent = g_enterprise AND inagsite = g_site
            
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
   IF amrm200_fill_chk(4) THEN
      IF (g_action_choice = "query" OR cl_null(g_action_choice))
         #add-point:b_fill段long_sql_if name="b_fill.body4.long_sql_if"
         
         #end add-point
      THEN
         LET g_sql = "SELECT  DISTINCT mrbe002 ,t9.imaal003 ,t10.imaal004 FROM mrbe_t",   
                     " INNER JOIN  mrba_t ON mrbaent = " ||g_enterprise|| " AND mrbasite = '" ||g_site|| "' AND mrba001 = mrbe001 ",
 
                     "",
                     
                                    " LEFT JOIN imaal_t t9 ON t9.imaalent="||g_enterprise||" AND t9.imaal001=mrbe002 AND t9.imaal002='"||g_dlang||"' ",
               " LEFT JOIN imaal_t t10 ON t10.imaalent="||g_enterprise||" AND t10.imaal001=mrbe002 AND t10.imaal002='"||g_dlang||"' ",
 
                     " WHERE mrbeent=? AND mrbesite=? AND mrbe001=?"   
         LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
         #add-point:b_fill段fill_sql name="b_fill.body4.fill_sql"
         
         #end add-point
         IF NOT cl_null(g_wc2_table4) THEN
            LET g_sql = g_sql CLIPPED," AND ",g_wc2_table4 CLIPPED
         END IF
         
         #子單身的WC
         
         
         LET g_sql = g_sql, " ORDER BY mrbe_t.mrbe002"
         
         #add-point:單身填充控制 name="b_fill.sql4"
         
         #end add-point
         
         LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
         PREPARE amrm200_pb4 FROM g_sql
         DECLARE b_fill_cs4 CURSOR FOR amrm200_pb4
      END IF
    
      LET l_ac = 1
      
   #  OPEN b_fill_cs4 USING g_enterprise, g_site,g_mrba_m.mrba001   #(ver:78)
                                               
      FOREACH b_fill_cs4 USING g_enterprise, g_site,g_mrba_m.mrba001 INTO g_mrbb4_d[l_ac].mrbe002,g_mrbb4_d[l_ac].mrbe002_desc, 
          g_mrbb4_d[l_ac].mrbe002_desc_desc   #(ver:78)
         IF SQLCA.SQLCODE THEN
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "FOREACH:",SQLERRMESSAGE 
            LET g_errparam.code = SQLCA.SQLCODE 
            LET g_errparam.popup = TRUE 
            CALL cl_err()
            EXIT FOREACH
         END IF
        
         #add-point:b_fill段資料填充 name="b_fill4.fill"
         
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
   IF amrm200_fill_chk(5) THEN
      IF (g_action_choice = "query" OR cl_null(g_action_choice))
         #add-point:b_fill段long_sql_if name="b_fill.body5.long_sql_if"
         
         #end add-point
      THEN
         LET g_sql = "SELECT  DISTINCT mrbf002 ,t11.mrba004 ,t12.mrba005 FROM mrbf_t",   
                     " INNER JOIN  mrba_t ON mrbaent = " ||g_enterprise|| " AND mrbasite = '" ||g_site|| "' AND mrba001 = mrbf001 ",
 
                     "",
                     
                                    " LEFT JOIN mrba_t t11 ON t11.mrbaent="||g_enterprise||" AND t11.mrbasite=mrbfsite AND t11.mrba001=mrbf002  ",
               " LEFT JOIN mrba_t t12 ON t12.mrbaent="||g_enterprise||" AND t12.mrbasite=mrbfsite AND t12.mrba001=mrbf002  ",
 
                     " WHERE mrbfent=? AND mrbfsite=? AND mrbf001=?"   
         LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
         #add-point:b_fill段fill_sql name="b_fill.body5.fill_sql"
         
         #end add-point
         IF NOT cl_null(g_wc2_table5) THEN
            LET g_sql = g_sql CLIPPED," AND ",g_wc2_table5 CLIPPED
         END IF
         
         #子單身的WC
         
         
         LET g_sql = g_sql, " ORDER BY mrbf_t.mrbf002"
         
         #add-point:單身填充控制 name="b_fill.sql5"
         
         #end add-point
         
         LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
         PREPARE amrm200_pb5 FROM g_sql
         DECLARE b_fill_cs5 CURSOR FOR amrm200_pb5
      END IF
    
      LET l_ac = 1
      
   #  OPEN b_fill_cs5 USING g_enterprise, g_site,g_mrba_m.mrba001   #(ver:78)
                                               
      FOREACH b_fill_cs5 USING g_enterprise, g_site,g_mrba_m.mrba001 INTO g_mrbb5_d[l_ac].mrbf002,g_mrbb5_d[l_ac].mrbf002_desc, 
          g_mrbb5_d[l_ac].mrbf002_desc_desc   #(ver:78)
         IF SQLCA.SQLCODE THEN
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "FOREACH:",SQLERRMESSAGE 
            LET g_errparam.code = SQLCA.SQLCODE 
            LET g_errparam.popup = TRUE 
            CALL cl_err()
            EXIT FOREACH
         END IF
        
         #add-point:b_fill段資料填充 name="b_fill5.fill"
         
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
   IF amrm200_fill_chk(6) THEN
      IF (g_action_choice = "query" OR cl_null(g_action_choice))
         #add-point:b_fill段long_sql_if name="b_fill.body6.long_sql_if"
         
         #end add-point
      THEN
         LET g_sql = "SELECT  DISTINCT mrbg002,mrbg003,mrbg004,mrbg005,mrbg006,mrbg007,mrbg008 ,t13.oocql004 FROM mrbg_t", 
                
                     " INNER JOIN  mrba_t ON mrbaent = " ||g_enterprise|| " AND mrbasite = '" ||g_site|| "' AND mrba001 = mrbg001 ",
 
                     "",
                     
                                    " LEFT JOIN oocql_t t13 ON t13.oocqlent="||g_enterprise||" AND t13.oocql001='1107' AND t13.oocql002=mrbg004 AND t13.oocql003='"||g_dlang||"' ",
 
                     " WHERE mrbgent=? AND mrbgsite=? AND mrbg001=?"   
         LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
         #add-point:b_fill段fill_sql name="b_fill.body6.fill_sql"
         
         #end add-point
         IF NOT cl_null(g_wc2_table6) THEN
            LET g_sql = g_sql CLIPPED," AND ",g_wc2_table6 CLIPPED
         END IF
         
         #子單身的WC
         
         
         LET g_sql = g_sql, " ORDER BY mrbg_t.mrbg002"
         
         #add-point:單身填充控制 name="b_fill.sql6"
         
         #end add-point
         
         LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
         PREPARE amrm200_pb6 FROM g_sql
         DECLARE b_fill_cs6 CURSOR FOR amrm200_pb6
      END IF
    
      LET l_ac = 1
      
   #  OPEN b_fill_cs6 USING g_enterprise, g_site,g_mrba_m.mrba001   #(ver:78)
                                               
      FOREACH b_fill_cs6 USING g_enterprise, g_site,g_mrba_m.mrba001 INTO g_mrbb6_d[l_ac].mrbg002,g_mrbb6_d[l_ac].mrbg003, 
          g_mrbb6_d[l_ac].mrbg004,g_mrbb6_d[l_ac].mrbg005,g_mrbb6_d[l_ac].mrbg006,g_mrbb6_d[l_ac].mrbg007, 
          g_mrbb6_d[l_ac].mrbg008,g_mrbb6_d[l_ac].mrbg004_desc   #(ver:78)
         IF SQLCA.SQLCODE THEN
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "FOREACH:",SQLERRMESSAGE 
            LET g_errparam.code = SQLCA.SQLCODE 
            LET g_errparam.popup = TRUE 
            CALL cl_err()
            EXIT FOREACH
         END IF
        
         #add-point:b_fill段資料填充 name="b_fill6.fill"
         
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
   
   CALL g_mrbb_d.deleteElement(g_mrbb_d.getLength())
   CALL g_mrbb2_d.deleteElement(g_mrbb2_d.getLength())
   CALL g_mrbb3_d.deleteElement(g_mrbb3_d.getLength())
   CALL g_mrbb4_d.deleteElement(g_mrbb4_d.getLength())
   CALL g_mrbb5_d.deleteElement(g_mrbb5_d.getLength())
   CALL g_mrbb6_d.deleteElement(g_mrbb6_d.getLength())
 
   
 
   LET l_ac = g_cnt
   LET g_cnt = 0  
   
   FREE amrm200_pb
   FREE amrm200_pb2
 
   FREE amrm200_pb3
 
   FREE amrm200_pb4
 
   FREE amrm200_pb5
 
   FREE amrm200_pb6
 
 
   
   LET li_idx = l_ac
   
   #遮罩相關處理
   FOR l_ac = 1 TO g_mrbb_d.getLength()
      LET g_mrbb_d_mask_o[l_ac].* =  g_mrbb_d[l_ac].*
      CALL amrm200_mrbb_t_mask()
      LET g_mrbb_d_mask_n[l_ac].* =  g_mrbb_d[l_ac].*
   END FOR
   
   LET g_mrbb2_d_mask_o.* =  g_mrbb2_d.*
   FOR l_ac = 1 TO g_mrbb2_d.getLength()
      LET g_mrbb2_d_mask_o[l_ac].* =  g_mrbb2_d[l_ac].*
      CALL amrm200_mrbc_t_mask()
      LET g_mrbb2_d_mask_n[l_ac].* =  g_mrbb2_d[l_ac].*
   END FOR
   LET g_mrbb3_d_mask_o.* =  g_mrbb3_d.*
   FOR l_ac = 1 TO g_mrbb3_d.getLength()
      LET g_mrbb3_d_mask_o[l_ac].* =  g_mrbb3_d[l_ac].*
      CALL amrm200_mrbd_t_mask()
      LET g_mrbb3_d_mask_n[l_ac].* =  g_mrbb3_d[l_ac].*
   END FOR
   LET g_mrbb4_d_mask_o.* =  g_mrbb4_d.*
   FOR l_ac = 1 TO g_mrbb4_d.getLength()
      LET g_mrbb4_d_mask_o[l_ac].* =  g_mrbb4_d[l_ac].*
      CALL amrm200_mrbe_t_mask()
      LET g_mrbb4_d_mask_n[l_ac].* =  g_mrbb4_d[l_ac].*
   END FOR
   LET g_mrbb5_d_mask_o.* =  g_mrbb5_d.*
   FOR l_ac = 1 TO g_mrbb5_d.getLength()
      LET g_mrbb5_d_mask_o[l_ac].* =  g_mrbb5_d[l_ac].*
      CALL amrm200_mrbf_t_mask()
      LET g_mrbb5_d_mask_n[l_ac].* =  g_mrbb5_d[l_ac].*
   END FOR
   LET g_mrbb6_d_mask_o.* =  g_mrbb6_d.*
   FOR l_ac = 1 TO g_mrbb6_d.getLength()
      LET g_mrbb6_d_mask_o[l_ac].* =  g_mrbb6_d[l_ac].*
      CALL amrm200_mrbg_t_mask()
      LET g_mrbb6_d_mask_n[l_ac].* =  g_mrbb6_d[l_ac].*
   END FOR
 
   
   LET l_ac = li_idx
   
   CALL cl_ap_performance_next_end()
 
END FUNCTION
 
{</section>}
 
{<section id="amrm200.delete_b" >}
#+ 刪除單身後其他table連動
PRIVATE FUNCTION amrm200_delete_b(ps_table,ps_keys_bak,ps_page)
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
   LET ls_group = "'1',"
   IF ls_group.getIndexOf(ps_page,1) > 0 THEN
      #add-point:delete_b段刪除前 name="delete_b.b_delete"
      
      #end add-point    
      DELETE FROM mrbb_t
       WHERE mrbbent = g_enterprise AND mrbbsite = g_site AND
         mrbb001 = ps_keys_bak[1] AND mrbb002 = ps_keys_bak[2]
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
         CALL g_mrbb_d.deleteElement(li_idx) 
      END IF 
 
   END IF
   
   LET ls_group = "'2',"
   #判斷是否是同一群組的table
   IF ls_group.getIndexOf(ps_page,1) > 0 THEN
      #add-point:delete_b段刪除前 name="delete_b.b_delete2"
      
      #end add-point    
      DELETE FROM mrbc_t
       WHERE mrbcent = g_enterprise AND mrbcsite = g_site AND
             mrbc001 = ps_keys_bak[1] AND mrbc002 = ps_keys_bak[2]
      #add-point:delete_b段刪除中 name="delete_b.m_delete2"
      
      #end add-point    
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "mrbc_t:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = FALSE 
         CALL cl_err()
         RETURN FALSE
      END IF
      
      LET li_idx = g_detail_idx
      IF ps_page <> "'2'" THEN 
         CALL g_mrbb2_d.deleteElement(li_idx) 
      END IF 
 
      #add-point:delete_b段刪除後 name="delete_b.a_delete2"
      
      #end add-point    
   END IF
 
   LET ls_group = "'3',"
   #判斷是否是同一群組的table
   IF ls_group.getIndexOf(ps_page,1) > 0 THEN
      #add-point:delete_b段刪除前 name="delete_b.b_delete3"
      
      #end add-point    
      DELETE FROM mrbd_t
       WHERE mrbdent = g_enterprise AND mrbdsite = g_site AND
             mrbd001 = ps_keys_bak[1] AND mrbd002 = ps_keys_bak[2]
      #add-point:delete_b段刪除中 name="delete_b.m_delete3"
      
      #end add-point    
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "mrbd_t:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = FALSE 
         CALL cl_err()
         RETURN FALSE
      END IF
      
      LET li_idx = g_detail_idx
      IF ps_page <> "'3'" THEN 
         CALL g_mrbb3_d.deleteElement(li_idx) 
      END IF 
 
      #add-point:delete_b段刪除後 name="delete_b.a_delete3"
      
      #end add-point    
   END IF
 
   LET ls_group = "'4',"
   #判斷是否是同一群組的table
   IF ls_group.getIndexOf(ps_page,1) > 0 THEN
      #add-point:delete_b段刪除前 name="delete_b.b_delete4"
      
      #end add-point    
      DELETE FROM mrbe_t
       WHERE mrbeent = g_enterprise AND mrbesite = g_site AND
             mrbe001 = ps_keys_bak[1] AND mrbe002 = ps_keys_bak[2]
      #add-point:delete_b段刪除中 name="delete_b.m_delete4"
      
      #end add-point    
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "mrbe_t:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = FALSE 
         CALL cl_err()
         RETURN FALSE
      END IF
      
      LET li_idx = g_detail_idx
      IF ps_page <> "'4'" THEN 
         CALL g_mrbb4_d.deleteElement(li_idx) 
      END IF 
 
      #add-point:delete_b段刪除後 name="delete_b.a_delete4"
      
      #end add-point    
   END IF
 
   LET ls_group = "'5',"
   #判斷是否是同一群組的table
   IF ls_group.getIndexOf(ps_page,1) > 0 THEN
      #add-point:delete_b段刪除前 name="delete_b.b_delete5"
      
      #end add-point    
      DELETE FROM mrbf_t
       WHERE mrbfent = g_enterprise AND mrbfsite = g_site AND
             mrbf001 = ps_keys_bak[1] AND mrbf002 = ps_keys_bak[2]
      #add-point:delete_b段刪除中 name="delete_b.m_delete5"
      
      #end add-point    
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "mrbf_t:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = FALSE 
         CALL cl_err()
         RETURN FALSE
      END IF
      
      LET li_idx = g_detail_idx
      IF ps_page <> "'5'" THEN 
         CALL g_mrbb5_d.deleteElement(li_idx) 
      END IF 
 
      #add-point:delete_b段刪除後 name="delete_b.a_delete5"
      
      #end add-point    
   END IF
 
   LET ls_group = "'6',"
   #判斷是否是同一群組的table
   IF ls_group.getIndexOf(ps_page,1) > 0 THEN
      #add-point:delete_b段刪除前 name="delete_b.b_delete6"
      
      #end add-point    
      DELETE FROM mrbg_t
       WHERE mrbgent = g_enterprise AND mrbgsite = g_site AND
             mrbg001 = ps_keys_bak[1] AND mrbg002 = ps_keys_bak[2]
      #add-point:delete_b段刪除中 name="delete_b.m_delete6"
      
      #end add-point    
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "mrbg_t:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = FALSE 
         CALL cl_err()
         RETURN FALSE
      END IF
      
      LET li_idx = g_detail_idx
      IF ps_page <> "'6'" THEN 
         CALL g_mrbb6_d.deleteElement(li_idx) 
      END IF 
 
      #add-point:delete_b段刪除後 name="delete_b.a_delete6"
      
      #end add-point    
   END IF
 
 
   
 
   
   #add-point:delete_b段other name="delete_b.other"
   
   #end add-point  
   
   RETURN TRUE
   
END FUNCTION
 
{</section>}
 
{<section id="amrm200.insert_b" >}
#+ 新增單身後其他table連動
PRIVATE FUNCTION amrm200_insert_b(ps_table,ps_keys,ps_page)
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
      INSERT INTO mrbb_t
                  (mrbbent, mrbbsite,
                   mrbb001,
                   mrbb002
                   ,mrbbstus,mrbb003,mrbb004,mrbb005,mrbb006,mrbb007,mrbb008,mrbb009,mrbb010,mrbb011,mrbb012,mrbb013) 
            VALUES(g_enterprise, g_site,
                   ps_keys[1],ps_keys[2]
                   ,g_mrbb_d[g_detail_idx].mrbbstus,g_mrbb_d[g_detail_idx].mrbb003,g_mrbb_d[g_detail_idx].mrbb004, 
                       g_mrbb_d[g_detail_idx].mrbb005,g_mrbb_d[g_detail_idx].mrbb006,g_mrbb_d[g_detail_idx].mrbb007, 
                       g_mrbb_d[g_detail_idx].mrbb008,g_mrbb_d[g_detail_idx].mrbb009,g_mrbb_d[g_detail_idx].mrbb010, 
                       g_mrbb_d[g_detail_idx].mrbb011,g_mrbb_d[g_detail_idx].mrbb012,g_mrbb_d[g_detail_idx].mrbb013) 
 
      #add-point:insert_b段資料新增中 name="insert_b.m_insert"
      
      #end add-point 
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "mrbb_t:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = FALSE 
         CALL cl_err()
      END IF
      
      LET li_idx = g_detail_idx
      IF ps_page <> "'1'" THEN 
         CALL g_mrbb_d.insertElement(li_idx) 
      END IF 
 
      #add-point:insert_b段資料新增後 name="insert_b.after_insert"
      
      #end add-point 
   END IF
   
   LET ls_group = "'2',"
   #判斷是否是同一群組的table
   IF ls_group.getIndexOf(ps_page,1) > 0 THEN
      #add-point:insert_b段資料新增前 name="insert_b.before_insert2"
      
      #end add-point 
      INSERT INTO mrbc_t
                  (mrbcent, mrbcsite,
                   mrbc001,
                   mrbc002
                   ,mrbc003,mrbc004,mrbc005,mrbc006,mrbc007,mrbc008,mrbc009,mrbc010,mrbc011) 
            VALUES(g_enterprise, g_site,
                   ps_keys[1],ps_keys[2]
                   ,g_mrbb2_d[g_detail_idx].mrbc003,g_mrbb2_d[g_detail_idx].mrbc004,g_mrbb2_d[g_detail_idx].mrbc005, 
                       g_mrbb2_d[g_detail_idx].mrbc006,g_mrbb2_d[g_detail_idx].mrbc007,g_mrbb2_d[g_detail_idx].mrbc008, 
                       g_mrbb2_d[g_detail_idx].mrbc009,g_mrbb2_d[g_detail_idx].mrbc010,g_mrbb2_d[g_detail_idx].mrbc011) 
 
      #add-point:insert_b段資料新增中 name="insert_b.m_insert2"
      
      #end add-point
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "mrbc_t:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = FALSE 
         CALL cl_err()
      END IF
      
      LET li_idx = g_detail_idx
      IF ps_page <> "'2'" THEN 
         CALL g_mrbb2_d.insertElement(li_idx) 
      END IF 
 
      #add-point:insert_b段資料新增後 name="insert_b.after_insert2"
      
      #end add-point
   END IF
 
   LET ls_group = "'3',"
   #判斷是否是同一群組的table
   IF ls_group.getIndexOf(ps_page,1) > 0 THEN
      #add-point:insert_b段資料新增前 name="insert_b.before_insert3"
      
      #end add-point 
      INSERT INTO mrbd_t
                  (mrbdent, mrbdsite,
                   mrbd001,
                   mrbd002
                   ,mrbd003,mrbd004,mrbd005,mrbd006,mrbd007,mrbd008,mrbd009,mrbd010) 
            VALUES(g_enterprise, g_site,
                   ps_keys[1],ps_keys[2]
                   ,g_mrbb3_d[g_detail_idx].mrbd003,g_mrbb3_d[g_detail_idx].mrbd004,g_mrbb3_d[g_detail_idx].mrbd005, 
                       g_mrbb3_d[g_detail_idx].mrbd006,g_mrbb3_d[g_detail_idx].mrbd007,g_mrbb3_d[g_detail_idx].mrbd008, 
                       g_mrbb3_d[g_detail_idx].mrbd009,g_mrbb3_d[g_detail_idx].mrbd010)
      #add-point:insert_b段資料新增中 name="insert_b.m_insert3"
      
      #end add-point
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "mrbd_t:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = FALSE 
         CALL cl_err()
      END IF
      
      LET li_idx = g_detail_idx
      IF ps_page <> "'3'" THEN 
         CALL g_mrbb3_d.insertElement(li_idx) 
      END IF 
 
      #add-point:insert_b段資料新增後 name="insert_b.after_insert3"
      
      #end add-point
   END IF
 
   LET ls_group = "'4',"
   #判斷是否是同一群組的table
   IF ls_group.getIndexOf(ps_page,1) > 0 THEN
      #add-point:insert_b段資料新增前 name="insert_b.before_insert4"
      
      #end add-point 
      INSERT INTO mrbe_t
                  (mrbeent, mrbesite,
                   mrbe001,
                   mrbe002
                   ) 
            VALUES(g_enterprise, g_site,
                   ps_keys[1],ps_keys[2]
                   )
      #add-point:insert_b段資料新增中 name="insert_b.m_insert4"
      
      #end add-point
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "mrbe_t:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = FALSE 
         CALL cl_err()
      END IF
      
      LET li_idx = g_detail_idx
      IF ps_page <> "'4'" THEN 
         CALL g_mrbb4_d.insertElement(li_idx) 
      END IF 
 
      #add-point:insert_b段資料新增後 name="insert_b.after_insert4"
      
      #end add-point
   END IF
 
   LET ls_group = "'5',"
   #判斷是否是同一群組的table
   IF ls_group.getIndexOf(ps_page,1) > 0 THEN
      #add-point:insert_b段資料新增前 name="insert_b.before_insert5"
      
      #end add-point 
      INSERT INTO mrbf_t
                  (mrbfent, mrbfsite,
                   mrbf001,
                   mrbf002
                   ) 
            VALUES(g_enterprise, g_site,
                   ps_keys[1],ps_keys[2]
                   )
      #add-point:insert_b段資料新增中 name="insert_b.m_insert5"
      
      #end add-point
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "mrbf_t:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = FALSE 
         CALL cl_err()
      END IF
      
      LET li_idx = g_detail_idx
      IF ps_page <> "'5'" THEN 
         CALL g_mrbb5_d.insertElement(li_idx) 
      END IF 
 
      #add-point:insert_b段資料新增後 name="insert_b.after_insert5"
      
      #end add-point
   END IF
 
   LET ls_group = "'6',"
   #判斷是否是同一群組的table
   IF ls_group.getIndexOf(ps_page,1) > 0 THEN
      #add-point:insert_b段資料新增前 name="insert_b.before_insert6"
      
      #end add-point 
      INSERT INTO mrbg_t
                  (mrbgent, mrbgsite,
                   mrbg001,
                   mrbg002
                   ,mrbg003,mrbg004,mrbg005,mrbg006,mrbg007,mrbg008) 
            VALUES(g_enterprise, g_site,
                   ps_keys[1],ps_keys[2]
                   ,g_mrbb6_d[g_detail_idx].mrbg003,g_mrbb6_d[g_detail_idx].mrbg004,g_mrbb6_d[g_detail_idx].mrbg005, 
                       g_mrbb6_d[g_detail_idx].mrbg006,g_mrbb6_d[g_detail_idx].mrbg007,g_mrbb6_d[g_detail_idx].mrbg008) 
 
      #add-point:insert_b段資料新增中 name="insert_b.m_insert6"
      
      #end add-point
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "mrbg_t:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = FALSE 
         CALL cl_err()
      END IF
      
      LET li_idx = g_detail_idx
      IF ps_page <> "'6'" THEN 
         CALL g_mrbb6_d.insertElement(li_idx) 
      END IF 
 
      #add-point:insert_b段資料新增後 name="insert_b.after_insert6"
      
      #end add-point
   END IF
 
 
   
 
   
   #add-point:insert_b段other name="insert_b.other"
   
   #end add-point     
   
END FUNCTION
 
{</section>}
 
{<section id="amrm200.update_b" >}
#+ 修改單身後其他table連動
PRIVATE FUNCTION amrm200_update_b(ps_table,ps_keys,ps_keys_bak,ps_page)
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
   IF ls_group.getIndexOf(ps_page,1) > 0 AND ps_table <> "mrbb_t" THEN
      #add-point:update_b段修改前 name="update_b.before_update"
      
      #end add-point 
      
      #將遮罩欄位還原
      CALL amrm200_mrbb_t_mask_restore('restore_mask_o')
               
      UPDATE mrbb_t 
         SET (mrbb001,
              mrbb002
              ,mrbbstus,mrbb003,mrbb004,mrbb005,mrbb006,mrbb007,mrbb008,mrbb009,mrbb010,mrbb011,mrbb012,mrbb013) 
              = 
             (ps_keys[1],ps_keys[2]
              ,g_mrbb_d[g_detail_idx].mrbbstus,g_mrbb_d[g_detail_idx].mrbb003,g_mrbb_d[g_detail_idx].mrbb004, 
                  g_mrbb_d[g_detail_idx].mrbb005,g_mrbb_d[g_detail_idx].mrbb006,g_mrbb_d[g_detail_idx].mrbb007, 
                  g_mrbb_d[g_detail_idx].mrbb008,g_mrbb_d[g_detail_idx].mrbb009,g_mrbb_d[g_detail_idx].mrbb010, 
                  g_mrbb_d[g_detail_idx].mrbb011,g_mrbb_d[g_detail_idx].mrbb012,g_mrbb_d[g_detail_idx].mrbb013)  
 
         WHERE mrbbent = g_enterprise AND mrbbsite = g_site AND mrbb001 = ps_keys_bak[1] AND mrbb002 = ps_keys_bak[2]
      #add-point:update_b段修改中 name="update_b.m_update"
      
      #end add-point   
      CASE
         WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "mrbb_t" 
            LET g_errparam.code = "std-00009" 
            LET g_errparam.popup = TRUE 
            CALL s_transaction_end('N','0')
            CALL cl_err()
            
         WHEN SQLCA.SQLCODE #其他錯誤
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "mrbb_t:",SQLERRMESSAGE 
            LET g_errparam.code = SQLCA.SQLCODE 
            LET g_errparam.popup = TRUE 
            CALL s_transaction_end('N','0')
            CALL cl_err()
            
         OTHERWISE
 
      END CASE
      
      #將遮罩欄位進行遮蔽
      CALL amrm200_mrbb_t_mask_restore('restore_mask_n')
               
      #add-point:update_b段修改後 name="update_b.after_update"
      
      #end add-point  
   END IF
   
   #子表處理
   IF ls_group.getIndexOf(ps_page,1) > 0 THEN
      
   END IF
   
   
   LET ls_group = "'2',"
   #判斷是否是同一群組的table
   IF ls_group.getIndexOf(ps_page,1) > 0 AND ps_table <> "mrbc_t" THEN
      #add-point:update_b段修改前 name="update_b.before_update2"
      
      #end add-point  
      
      #將遮罩欄位還原
      CALL amrm200_mrbc_t_mask_restore('restore_mask_o')
               
      UPDATE mrbc_t 
         SET (mrbc001,
              mrbc002
              ,mrbc003,mrbc004,mrbc005,mrbc006,mrbc007,mrbc008,mrbc009,mrbc010,mrbc011) 
              = 
             (ps_keys[1],ps_keys[2]
              ,g_mrbb2_d[g_detail_idx].mrbc003,g_mrbb2_d[g_detail_idx].mrbc004,g_mrbb2_d[g_detail_idx].mrbc005, 
                  g_mrbb2_d[g_detail_idx].mrbc006,g_mrbb2_d[g_detail_idx].mrbc007,g_mrbb2_d[g_detail_idx].mrbc008, 
                  g_mrbb2_d[g_detail_idx].mrbc009,g_mrbb2_d[g_detail_idx].mrbc010,g_mrbb2_d[g_detail_idx].mrbc011)  
 
         WHERE mrbcent = g_enterprise AND mrbcsite = g_site AND mrbc001 = ps_keys_bak[1] AND mrbc002 = ps_keys_bak[2]
      #add-point:update_b段修改中 name="update_b.m_update2"
      
      #end add-point  
      CASE
         WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "mrbc_t" 
            LET g_errparam.code = "std-00009" 
            LET g_errparam.popup = TRUE 
            CALL s_transaction_end('N','0')
            CALL cl_err()
            
         WHEN SQLCA.SQLCODE #其他錯誤
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "mrbc_t:",SQLERRMESSAGE 
            LET g_errparam.code = SQLCA.SQLCODE 
            LET g_errparam.popup = TRUE 
            CALL s_transaction_end('N','0')
            CALL cl_err()
            
         OTHERWISE
          
      END CASE
      
      #將遮罩欄位進行遮蔽
      CALL amrm200_mrbc_t_mask_restore('restore_mask_n')
 
      #add-point:update_b段修改後 name="update_b.after_update2"
      
      #end add-point  
   END IF
 
   #子表處理
   IF ls_group.getIndexOf(ps_page,1) > 0 THEN
      
   END IF
 
   LET ls_group = "'3',"
   #判斷是否是同一群組的table
   IF ls_group.getIndexOf(ps_page,1) > 0 AND ps_table <> "mrbd_t" THEN
      #add-point:update_b段修改前 name="update_b.before_update3"
      
      #end add-point  
      
      #將遮罩欄位還原
      CALL amrm200_mrbd_t_mask_restore('restore_mask_o')
               
      UPDATE mrbd_t 
         SET (mrbd001,
              mrbd002
              ,mrbd003,mrbd004,mrbd005,mrbd006,mrbd007,mrbd008,mrbd009,mrbd010) 
              = 
             (ps_keys[1],ps_keys[2]
              ,g_mrbb3_d[g_detail_idx].mrbd003,g_mrbb3_d[g_detail_idx].mrbd004,g_mrbb3_d[g_detail_idx].mrbd005, 
                  g_mrbb3_d[g_detail_idx].mrbd006,g_mrbb3_d[g_detail_idx].mrbd007,g_mrbb3_d[g_detail_idx].mrbd008, 
                  g_mrbb3_d[g_detail_idx].mrbd009,g_mrbb3_d[g_detail_idx].mrbd010) 
         WHERE mrbdent = g_enterprise AND mrbdsite = g_site AND mrbd001 = ps_keys_bak[1] AND mrbd002 = ps_keys_bak[2]
      #add-point:update_b段修改中 name="update_b.m_update3"
      
      #end add-point  
      CASE
         WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "mrbd_t" 
            LET g_errparam.code = "std-00009" 
            LET g_errparam.popup = TRUE 
            CALL s_transaction_end('N','0')
            CALL cl_err()
            
         WHEN SQLCA.SQLCODE #其他錯誤
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "mrbd_t:",SQLERRMESSAGE 
            LET g_errparam.code = SQLCA.SQLCODE 
            LET g_errparam.popup = TRUE 
            CALL s_transaction_end('N','0')
            CALL cl_err()
            
         OTHERWISE
          
      END CASE
      
      #將遮罩欄位進行遮蔽
      CALL amrm200_mrbd_t_mask_restore('restore_mask_n')
 
      #add-point:update_b段修改後 name="update_b.after_update3"
      
      #end add-point  
   END IF
 
   #子表處理
   IF ls_group.getIndexOf(ps_page,1) > 0 THEN
      
   END IF
 
   LET ls_group = "'4',"
   #判斷是否是同一群組的table
   IF ls_group.getIndexOf(ps_page,1) > 0 AND ps_table <> "mrbe_t" THEN
      #add-point:update_b段修改前 name="update_b.before_update4"
      
      #end add-point  
      
      #將遮罩欄位還原
      CALL amrm200_mrbe_t_mask_restore('restore_mask_o')
               
      UPDATE mrbe_t 
         SET (mrbe001,
              mrbe002
              ) 
              = 
             (ps_keys[1],ps_keys[2]
              ) 
         WHERE mrbeent = g_enterprise AND mrbesite = g_site AND mrbe001 = ps_keys_bak[1] AND mrbe002 = ps_keys_bak[2]
      #add-point:update_b段修改中 name="update_b.m_update4"
      
      #end add-point  
      CASE
         WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "mrbe_t" 
            LET g_errparam.code = "std-00009" 
            LET g_errparam.popup = TRUE 
            CALL s_transaction_end('N','0')
            CALL cl_err()
            
         WHEN SQLCA.SQLCODE #其他錯誤
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "mrbe_t:",SQLERRMESSAGE 
            LET g_errparam.code = SQLCA.SQLCODE 
            LET g_errparam.popup = TRUE 
            CALL s_transaction_end('N','0')
            CALL cl_err()
            
         OTHERWISE
          
      END CASE
      
      #將遮罩欄位進行遮蔽
      CALL amrm200_mrbe_t_mask_restore('restore_mask_n')
 
      #add-point:update_b段修改後 name="update_b.after_update4"
      
      #end add-point  
   END IF
 
   #子表處理
   IF ls_group.getIndexOf(ps_page,1) > 0 THEN
      
   END IF
 
   LET ls_group = "'5',"
   #判斷是否是同一群組的table
   IF ls_group.getIndexOf(ps_page,1) > 0 AND ps_table <> "mrbf_t" THEN
      #add-point:update_b段修改前 name="update_b.before_update5"
      
      #end add-point  
      
      #將遮罩欄位還原
      CALL amrm200_mrbf_t_mask_restore('restore_mask_o')
               
      UPDATE mrbf_t 
         SET (mrbf001,
              mrbf002
              ) 
              = 
             (ps_keys[1],ps_keys[2]
              ) 
         WHERE mrbfent = g_enterprise AND mrbfsite = g_site AND mrbf001 = ps_keys_bak[1] AND mrbf002 = ps_keys_bak[2]
      #add-point:update_b段修改中 name="update_b.m_update5"
      
      #end add-point  
      CASE
         WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "mrbf_t" 
            LET g_errparam.code = "std-00009" 
            LET g_errparam.popup = TRUE 
            CALL s_transaction_end('N','0')
            CALL cl_err()
            
         WHEN SQLCA.SQLCODE #其他錯誤
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "mrbf_t:",SQLERRMESSAGE 
            LET g_errparam.code = SQLCA.SQLCODE 
            LET g_errparam.popup = TRUE 
            CALL s_transaction_end('N','0')
            CALL cl_err()
            
         OTHERWISE
          
      END CASE
      
      #將遮罩欄位進行遮蔽
      CALL amrm200_mrbf_t_mask_restore('restore_mask_n')
 
      #add-point:update_b段修改後 name="update_b.after_update5"
      
      #end add-point  
   END IF
 
   #子表處理
   IF ls_group.getIndexOf(ps_page,1) > 0 THEN
      
   END IF
 
   LET ls_group = "'6',"
   #判斷是否是同一群組的table
   IF ls_group.getIndexOf(ps_page,1) > 0 AND ps_table <> "mrbg_t" THEN
      #add-point:update_b段修改前 name="update_b.before_update6"
      
      #end add-point  
      
      #將遮罩欄位還原
      CALL amrm200_mrbg_t_mask_restore('restore_mask_o')
               
      UPDATE mrbg_t 
         SET (mrbg001,
              mrbg002
              ,mrbg003,mrbg004,mrbg005,mrbg006,mrbg007,mrbg008) 
              = 
             (ps_keys[1],ps_keys[2]
              ,g_mrbb6_d[g_detail_idx].mrbg003,g_mrbb6_d[g_detail_idx].mrbg004,g_mrbb6_d[g_detail_idx].mrbg005, 
                  g_mrbb6_d[g_detail_idx].mrbg006,g_mrbb6_d[g_detail_idx].mrbg007,g_mrbb6_d[g_detail_idx].mrbg008)  
 
         WHERE mrbgent = g_enterprise AND mrbgsite = g_site AND mrbg001 = ps_keys_bak[1] AND mrbg002 = ps_keys_bak[2]
      #add-point:update_b段修改中 name="update_b.m_update6"
      
      #end add-point  
      CASE
         WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "mrbg_t" 
            LET g_errparam.code = "std-00009" 
            LET g_errparam.popup = TRUE 
            CALL s_transaction_end('N','0')
            CALL cl_err()
            
         WHEN SQLCA.SQLCODE #其他錯誤
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "mrbg_t:",SQLERRMESSAGE 
            LET g_errparam.code = SQLCA.SQLCODE 
            LET g_errparam.popup = TRUE 
            CALL s_transaction_end('N','0')
            CALL cl_err()
            
         OTHERWISE
          
      END CASE
      
      #將遮罩欄位進行遮蔽
      CALL amrm200_mrbg_t_mask_restore('restore_mask_n')
 
      #add-point:update_b段修改後 name="update_b.after_update6"
      
      #end add-point  
   END IF
 
   #子表處理
   IF ls_group.getIndexOf(ps_page,1) > 0 THEN
      
   END IF
 
 
   
 
   
   #add-point:update_b段other name="update_b.other"
   
   #end add-point  
   
END FUNCTION
 
{</section>}
 
{<section id="amrm200.key_update_b" >}
#+ 上層單身key欄位變動後, 連帶修正下層單身key欄位
PRIVATE FUNCTION amrm200_key_update_b(ps_keys_bak,ps_table)
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
 
{<section id="amrm200.key_delete_b" >}
#+ 上層單身刪除後, 連帶刪除下層單身key欄位
PRIVATE FUNCTION amrm200_key_delete_b(ps_keys_bak,ps_table)
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
 
{<section id="amrm200.lock_b" >}
#+ 連動lock其他單身table資料
PRIVATE FUNCTION amrm200_lock_b(ps_table,ps_page)
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
   #CALL amrm200_b_fill()
   
   #鎖定整組table
   #LET ls_group = "'1',"
   #僅鎖定自身table
   LET ls_group = "mrbb_t"
   
   IF ls_group.getIndexOf(ps_table,1) THEN
      OPEN amrm200_bcl USING g_enterprise, g_site,
                                       g_mrba_m.mrba001,g_mrbb_d[g_detail_idx].mrbb002     
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "amrm200_bcl:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = TRUE 
         CALL cl_err()
         RETURN FALSE
      END IF
   END IF
                                    
   #鎖定整組table
   #LET ls_group = "'2',"
   #僅鎖定自身table
   LET ls_group = "mrbc_t"
   IF ls_group.getIndexOf(ps_table,1) THEN
   
      OPEN amrm200_bcl2 USING g_enterprise, g_site,
                                             g_mrba_m.mrba001,g_mrbb2_d[g_detail_idx].mrbc002
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "amrm200_bcl2:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = TRUE 
         CALL cl_err()
         RETURN FALSE
      END IF
   END IF
 
   #鎖定整組table
   #LET ls_group = "'3',"
   #僅鎖定自身table
   LET ls_group = "mrbd_t"
   IF ls_group.getIndexOf(ps_table,1) THEN
   
      OPEN amrm200_bcl3 USING g_enterprise, g_site,
                                             g_mrba_m.mrba001,g_mrbb3_d[g_detail_idx].mrbd002
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "amrm200_bcl3:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = TRUE 
         CALL cl_err()
         RETURN FALSE
      END IF
   END IF
 
   #鎖定整組table
   #LET ls_group = "'4',"
   #僅鎖定自身table
   LET ls_group = "mrbe_t"
   IF ls_group.getIndexOf(ps_table,1) THEN
   
      OPEN amrm200_bcl4 USING g_enterprise, g_site,
                                             g_mrba_m.mrba001,g_mrbb4_d[g_detail_idx].mrbe002
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "amrm200_bcl4:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = TRUE 
         CALL cl_err()
         RETURN FALSE
      END IF
   END IF
 
   #鎖定整組table
   #LET ls_group = "'5',"
   #僅鎖定自身table
   LET ls_group = "mrbf_t"
   IF ls_group.getIndexOf(ps_table,1) THEN
   
      OPEN amrm200_bcl5 USING g_enterprise, g_site,
                                             g_mrba_m.mrba001,g_mrbb5_d[g_detail_idx].mrbf002
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "amrm200_bcl5:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = TRUE 
         CALL cl_err()
         RETURN FALSE
      END IF
   END IF
 
   #鎖定整組table
   #LET ls_group = "'6',"
   #僅鎖定自身table
   LET ls_group = "mrbg_t"
   IF ls_group.getIndexOf(ps_table,1) THEN
   
      OPEN amrm200_bcl6 USING g_enterprise, g_site,
                                             g_mrba_m.mrba001,g_mrbb6_d[g_detail_idx].mrbg002
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "amrm200_bcl6:",SQLERRMESSAGE 
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
 
{<section id="amrm200.unlock_b" >}
#+ 連動unlock其他單身table資料
PRIVATE FUNCTION amrm200_unlock_b(ps_table,ps_page)
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
      CLOSE amrm200_bcl
   END IF
   
   LET ls_group = "'2',"
   
   IF ls_group.getIndexOf(ps_page,1) THEN
      CLOSE amrm200_bcl2
   END IF
 
   LET ls_group = "'3',"
   
   IF ls_group.getIndexOf(ps_page,1) THEN
      CLOSE amrm200_bcl3
   END IF
 
   LET ls_group = "'4',"
   
   IF ls_group.getIndexOf(ps_page,1) THEN
      CLOSE amrm200_bcl4
   END IF
 
   LET ls_group = "'5',"
   
   IF ls_group.getIndexOf(ps_page,1) THEN
      CLOSE amrm200_bcl5
   END IF
 
   LET ls_group = "'6',"
   
   IF ls_group.getIndexOf(ps_page,1) THEN
      CLOSE amrm200_bcl6
   END IF
 
 
   
 
 
   #add-point:unlock_b段other name="unlock_b.other"
   
   #end add-point  
 
END FUNCTION
 
{</section>}
 
{<section id="amrm200.set_entry" >}
#+ 單頭欄位開啟設定
PRIVATE FUNCTION amrm200_set_entry(p_cmd)
   #add-point:set_entry段define(客製用) name="set_entry.define_customerization"
   
   #end add-point       
   DEFINE p_cmd   LIKE type_t.chr1  
   #add-point:set_entry段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_entry.define"
   
   #end add-point       
   
   #add-point:Function前置處理  name="set_entry.pre_function"
   
   #end add-point
   
   CALL cl_set_comp_entry("",TRUE)
   
   IF p_cmd = 'a' THEN
      CALL cl_set_comp_entry("mrba001",TRUE)
      CALL cl_set_comp_entry("",TRUE)
      #根據azzi850使用者身分開關特定欄位
      IF NOT cl_null(g_no_entry) THEN
         CALL cl_set_comp_entry(g_no_entry,TRUE)
      END IF
      #add-point:set_entry段欄位控制 name="set_entry.field_control"
      CALL cl_set_comp_entry("mrba032",TRUE)  #160624-00006#1 add
      #end add-point  
   END IF
   
   #add-point:set_entry段欄位控制後 name="set_entry.after_control"
   #160624-00006#1--add--start--
   IF p_cmd = 'u' AND g_mrba_m.mrbastus <> 'Y' THEN
      CALL cl_set_comp_entry("mrba032",TRUE)
   END IF
   #160624-00006#1--add--end----
   
   #C207041301chenyang---s  新增修改时，当mrba000='3'时，当前位置mrba018字段 不可为空，为必填字段且数据来源只能是cmri001中oocq039='1'的位置编码  
   IF g_mrba_m.mrba000 ='3' AND ( p_cmd = 'u' OR p_cmd = 'a' ) THEN
      CALL cl_set_comp_required("mrba018",TRUE)  
   END IF
   #C207041301chenyang---e
   #end add-point 
 
END FUNCTION
 
{</section>}
 
{<section id="amrm200.set_no_entry" >}
#+ 單頭欄位關閉設定
PRIVATE FUNCTION amrm200_set_no_entry(p_cmd)
   #add-point:set_no_entry段define(客製用) name="set_no_entry.define_customerization"
   
   #end add-point     
   DEFINE p_cmd   LIKE type_t.chr1   
   #add-point:set_no_entry段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_no_entry.define"
   
   #end add-point     
   
   #add-point:Function前置處理  name="set_no_entry.pre_function"
   
   #end add-point
   
   IF p_cmd = 'u' AND g_chkey = 'N' THEN
      CALL cl_set_comp_entry("mrba001",FALSE)
      #根據azzi850使用者身分開關特定欄位
      IF NOT cl_null(g_no_entry) THEN
         CALL cl_set_comp_entry(g_no_entry,FALSE)
      END IF
      #add-point:set_no_entry段欄位控制 name="set_no_entry.field_control"
 
      #end add-point 
   END IF 
   
   IF p_cmd = 'u' THEN  #docno,ld欄位確認是絕對關閉
      CALL cl_set_comp_entry("",FALSE)
   END IF 
 
#  IF p_cmd = 'u' THEN  #docdt欄位依照設定關閉(FALSE則為設定不同意修正) #(ver:78)
      IF NOT cl_chk_update_docdt() THEN
         CALL cl_set_comp_entry("",FALSE)
      END IF
#  END IF 
   
   #add-point:set_no_entry段欄位控制後 name="set_no_entry.after_control"
   #160624-00006#1--add--start--
   IF p_cmd = 'u' AND g_mrba_m.mrbastus = 'Y' THEN
      CALL cl_set_comp_entry("mrba032",FALSE)
   END IF
   #160624-00006#1--add--end----
   #C207041301chenyang---s  新增修改时，当mrba000='3'时，当前位置mrba018字段 不可为空，为必填字段且数据来源只能是cmri001中oocq039='1'的位置编码  
   IF NOT(g_mrba_m.mrba000 ='3' AND ( p_cmd = 'u' OR p_cmd = 'a' )) THEN
      CALL cl_set_comp_required("mrba018",FALSE)  
   END IF
   #C207041301chenyang---e
   #end add-point 
 
END FUNCTION
 
{</section>}
 
{<section id="amrm200.set_entry_b" >}
#+ 單身欄位開啟設定
PRIVATE FUNCTION amrm200_set_entry_b(p_cmd)
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
   CALL cl_set_comp_entry("mrbc007,mrbc008,mrbc009,mrbc010,mrbc011",TRUE)
   CALL cl_set_comp_required("mrbc007,mrbc008,mrbc009",TRUE)
   #end add-point  
END FUNCTION
 
{</section>}
 
{<section id="amrm200.set_no_entry_b" >}
#+ 單身欄位關閉設定
PRIVATE FUNCTION amrm200_set_no_entry_b(p_cmd)
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
   IF g_mrbb2_d[l_ac].mrbc004 != '1' THEN
      INITIALIZE g_mrbb2_d[l_ac].mrbc007 TO NULL
      DISPLAY BY NAME g_mrbb2_d[l_ac].mrbc007
      INITIALIZE g_mrbb2_d[l_ac].mrbc008 TO NULL
      DISPLAY BY NAME g_mrbb2_d[l_ac].mrbc008
      CALL cl_set_comp_entry("mrbc007,mrbc008",FALSE)
   END IF
   IF g_mrbb2_d[l_ac].mrbc004 != '2' THEN
      INITIALIZE g_mrbb2_d[l_ac].mrbc009 TO NULL
      DISPLAY BY NAME g_mrbb2_d[l_ac].mrbc009
      INITIALIZE g_mrbb2_d[l_ac].mrbc010 TO NULL
      DISPLAY BY NAME g_mrbb2_d[l_ac].mrbc010
      INITIALIZE g_mrbb2_d[l_ac].mrbc011 TO NULL
      DISPLAY BY NAME g_mrbb2_d[l_ac].mrbc011
      CALL cl_set_comp_entry("mrbc009,mrbc010,mrbc011",FALSE)
   END IF
   #end add-point     
END FUNCTION
 
{</section>}
 
{<section id="amrm200.set_act_visible" >}
#+ 單頭權限開啟
PRIVATE FUNCTION amrm200_set_act_visible()
   #add-point:set_act_visible段define(客製用) name="set_act_visible.define_customerization"
   
   #end add-point   
   #add-point:set_act_visible段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_visible.define"
   
   #end add-point   
   #add-point:set_act_visible段 name="set_act_visible.set_act_visible"
   CALL cl_set_act_visible("act_1,act_2,act_3,act_4,act_5",TRUE)
   CASE g_mrba_m.mrba100 
      WHEN '0' 
        CALL cl_set_act_visible("act_1",TRUE)
      WHEN '1'
        CALL cl_set_act_visible("act_2,act_4",TRUE) 
      WHEN '2'
        CALL cl_set_act_visible("act_3",TRUE)
      WHEN '3'
        CALL cl_set_act_visible("act_5",TRUE)
   END CASE
   
   CALL cl_set_act_visible("delete",TRUE)

   #end add-point   
END FUNCTION
 
{</section>}
 
{<section id="amrm200.set_act_no_visible" >}
#+ 單頭權限關閉
PRIVATE FUNCTION amrm200_set_act_no_visible()
   #add-point:set_act_no_visible段define(客製用) name="set_act_no_visible.define_customerization"
   
   #end add-point   
   #add-point:set_act_no_visible段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_no_visible.define"
   
   #end add-point   
   #add-point:set_act_no_visible段 name="set_act_no_visible.set_act_no_visible"
   CASE g_mrba_m.mrba100 
      WHEN '0' 
        CALL cl_set_act_visible("act_2,act_4,act_3,act_5",FALSE)
      WHEN '1'
        CALL cl_set_act_visible("act_1,act_3,act_5",FALSE) 
      WHEN '2'
        CALL cl_set_act_visible("act_1,act_2,act_4,act_5",FALSE)
      WHEN '3'
        CALL cl_set_act_visible("act_1,act_2,act_4,act_3",FALSE)
   END CASE
   
   IF g_mrba_m.mrbastus = 'Y' OR  g_mrba_m.mrbastus = 'X' THEN
      CALL cl_set_act_visible("delete",FALSE)
   END IF
   #end add-point   
END FUNCTION
 
{</section>}
 
{<section id="amrm200.set_act_visible_b" >}
#+ 單身權限開啟
PRIVATE FUNCTION amrm200_set_act_visible_b()
   #add-point:set_act_visible_b段define(客製用) name="set_act_visible_b.define_customerization"
   
   #end add-point   
   #add-point:set_act_visible_b段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_visible_b.define"
   
   #end add-point   
   #add-point:set_act_visible_b段 name="set_act_visible_b.set_act_visible_b"
   
   #end add-point   
END FUNCTION
 
{</section>}
 
{<section id="amrm200.set_act_no_visible_b" >}
#+ 單身權限關閉
PRIVATE FUNCTION amrm200_set_act_no_visible_b()
   #add-point:set_act_no_visible_b段define(客製用) name="set_act_no_visible_b.define_customerization"
   
   #end add-point   
   #add-point:set_act_no_visible_b段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_no_visible_b.define"
   
   #end add-point   
   #add-point:set_act_no_visible_b段 name="set_act_no_visible_b.set_act_no_visible_b"
   
   #end add-point   
END FUNCTION
 
{</section>}
 
{<section id="amrm200.default_search" >}
#+ 外部參數搜尋
PRIVATE FUNCTION amrm200_default_search()
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
      LET ls_wc = ls_wc, " mrba001 = '", g_argv[01], "' AND "
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
 
         INITIALIZE g_wc2_table4 TO NULL
 
         INITIALIZE g_wc2_table5 TO NULL
 
         INITIALIZE g_wc2_table6 TO NULL
 
 
         FOR li_idx = 1 TO la_wc.getLength()
            CASE
               WHEN la_wc[li_idx].tableid = "mrba_t" 
                  LET g_wc = la_wc[li_idx].wc
               WHEN la_wc[li_idx].tableid = "mrbb_t" 
                  LET g_wc2_table1 = la_wc[li_idx].wc
               WHEN la_wc[li_idx].tableid = "mrbc_t" 
                  LET g_wc2_table2 = la_wc[li_idx].wc
 
               WHEN la_wc[li_idx].tableid = "mrbd_t" 
                  LET g_wc2_table3 = la_wc[li_idx].wc
 
               WHEN la_wc[li_idx].tableid = "mrbe_t" 
                  LET g_wc2_table4 = la_wc[li_idx].wc
 
               WHEN la_wc[li_idx].tableid = "mrbf_t" 
                  LET g_wc2_table5 = la_wc[li_idx].wc
 
               WHEN la_wc[li_idx].tableid = "mrbg_t" 
                  LET g_wc2_table6 = la_wc[li_idx].wc
 
 
               WHEN la_wc[li_idx].tableid = "EXTENDWC"
                  LET g_wc2_extend = la_wc[li_idx].wc
            END CASE
         END FOR
         IF NOT cl_null(g_wc) OR NOT cl_null(g_wc2_table1) 
            OR NOT cl_null(g_wc2_table2)
 
            OR NOT cl_null(g_wc2_table3)
 
            OR NOT cl_null(g_wc2_table4)
 
            OR NOT cl_null(g_wc2_table5)
 
            OR NOT cl_null(g_wc2_table6)
 
 
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
 
            IF g_wc2_table4 <> " 1=1" AND NOT cl_null(g_wc2_table4) THEN
               LET g_wc2 = g_wc2 ," AND ", g_wc2_table4
            END IF
 
            IF g_wc2_table5 <> " 1=1" AND NOT cl_null(g_wc2_table5) THEN
               LET g_wc2 = g_wc2 ," AND ", g_wc2_table5
            END IF
 
            IF g_wc2_table6 <> " 1=1" AND NOT cl_null(g_wc2_table6) THEN
               LET g_wc2 = g_wc2 ," AND ", g_wc2_table6
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
 
{<section id="amrm200.state_change" >}
   #應用 a09 樣板自動產生(Version:17)
#+ 確認碼變更 
PRIVATE FUNCTION amrm200_statechange()
   #add-point:statechange段define(客製用) name="statechange.define_customerization"
   
   #end add-point  
   DEFINE lc_state LIKE type_t.chr5
   #add-point:statechange段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="statechange.define"
   DEFINE l_open_state   LIKE type_t.chr1
   #end add-point  
   
   #add-point:Function前置處理 name="statechange.before"
   
   #end add-point  
   
   ERROR ""     #清空畫面右下側ERROR區塊
 
   IF g_mrba_m.mrba001 IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code   = "std-00003" 
      LET g_errparam.popup  = FALSE 
      CALL cl_err()
      RETURN
   END IF
 
   CALL s_transaction_begin()
   
   OPEN amrm200_cl USING g_enterprise, g_site,g_mrba_m.mrba001
   IF STATUS THEN
      CLOSE amrm200_cl
      CALL s_transaction_end('N','0')
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "OPEN amrm200_cl:" 
      LET g_errparam.code   = STATUS 
      LET g_errparam.popup  = TRUE 
      CALL cl_err()
      RETURN
   END IF
   
   #顯示最新的資料
   EXECUTE amrm200_master_referesh USING g_site,g_mrba_m.mrba001 INTO g_mrba_m.mrba019,g_mrba_m.mrba000, 
       g_mrba_m.mrba001,g_mrba_m.mrba002,g_mrba_m.mrba003,g_mrba_m.mrba066,g_mrba_m.mrba004,g_mrba_m.mrba005, 
       g_mrba_m.mrba007,g_mrba_m.mrba008,g_mrba_m.mrba009,g_mrba_m.mrba010,g_mrba_m.mrba011,g_mrba_m.mrba020, 
       g_mrba_m.mrba006,g_mrba_m.mrba104,g_mrba_m.mrba012,g_mrba_m.mrba013,g_mrba_m.mrba014,g_mrba_m.mrba015, 
       g_mrba_m.mrba016,g_mrba_m.mrba017,g_mrba_m.mrba018,g_mrba_m.mrba102,g_mrba_m.mrba100,g_mrba_m.mrba101, 
       g_mrba_m.mrbastus,g_mrba_m.mrba021,g_mrba_m.mrba022,g_mrba_m.mrba025,g_mrba_m.mrba026,g_mrba_m.mrba027, 
       g_mrba_m.mrba103,g_mrba_m.mrba029,g_mrba_m.mrba031,g_mrba_m.mrba032,g_mrba_m.mrba033,g_mrba_m.mrba034, 
       g_mrba_m.mrba035,g_mrba_m.mrba036,g_mrba_m.mrba038,g_mrba_m.mrba039,g_mrba_m.mrba040,g_mrba_m.mrba041, 
       g_mrba_m.mrba042,g_mrba_m.mrbaownid,g_mrba_m.mrbaowndp,g_mrba_m.mrbacrtid,g_mrba_m.mrbacrtdp, 
       g_mrba_m.mrbacrtdt,g_mrba_m.mrbamodid,g_mrba_m.mrbamoddt,g_mrba_m.mrbacnfid,g_mrba_m.mrbacnfdt, 
       g_mrba_m.mrba010_desc,g_mrba_m.mrba011_desc,g_mrba_m.mrba020_desc,g_mrba_m.mrba012_desc,g_mrba_m.mrba013_desc, 
       g_mrba_m.mrba014_desc,g_mrba_m.mrba016_desc,g_mrba_m.mrba017_desc,g_mrba_m.mrba018_desc,g_mrba_m.mrba021_desc, 
       g_mrba_m.mrba022_desc,g_mrba_m.mrba027_desc,g_mrba_m.mrba103_desc,g_mrba_m.mrba040_desc,g_mrba_m.mrbaownid_desc, 
       g_mrba_m.mrbaowndp_desc,g_mrba_m.mrbacrtid_desc,g_mrba_m.mrbacrtdp_desc,g_mrba_m.mrbamodid_desc, 
       g_mrba_m.mrbacnfid_desc
   
 
   #檢查是否允許此動作
   IF NOT amrm200_action_chk() THEN
      CLOSE amrm200_cl
      CALL s_transaction_end('N','0')
      RETURN
   END IF
 
   #將資料顯示到畫面上
   DISPLAY BY NAME g_mrba_m.mrba019,g_mrba_m.mrba000,g_mrba_m.mrba001,g_mrba_m.mrba002,g_mrba_m.mrba003, 
       g_mrba_m.mrba066,g_mrba_m.mrba004,g_mrba_m.mrba005,g_mrba_m.mrba007,g_mrba_m.mrba008,g_mrba_m.mrba009, 
       g_mrba_m.mrba010,g_mrba_m.mrba010_desc,g_mrba_m.mrba011,g_mrba_m.mrba011_desc,g_mrba_m.mrba020, 
       g_mrba_m.mrba020_desc,g_mrba_m.mrba006,g_mrba_m.mrba104,g_mrba_m.mrba012,g_mrba_m.mrba012_desc, 
       g_mrba_m.mrba013,g_mrba_m.mrba013_desc,g_mrba_m.mrba014,g_mrba_m.mrba014_desc,g_mrba_m.mrba015, 
       g_mrba_m.mrba016,g_mrba_m.mrba016_desc,g_mrba_m.mrba017,g_mrba_m.mrba017_desc,g_mrba_m.mrba018, 
       g_mrba_m.mrba018_desc,g_mrba_m.mrba102,g_mrba_m.mrba100,g_mrba_m.mrba101,g_mrba_m.mrbastus,g_mrba_m.mrba021, 
       g_mrba_m.mrba021_desc,g_mrba_m.mrba022,g_mrba_m.mrba022_desc,g_mrba_m.mrba025,g_mrba_m.mrba026, 
       g_mrba_m.mrba027,g_mrba_m.mrba027_desc,g_mrba_m.mrba103,g_mrba_m.mrba103_desc,g_mrba_m.mrba029, 
       g_mrba_m.mrba031,g_mrba_m.mrba032,g_mrba_m.mrba033,g_mrba_m.mrba034,g_mrba_m.mrba035,g_mrba_m.mrba036, 
       g_mrba_m.mrba038,g_mrba_m.mrba039,g_mrba_m.mrba040,g_mrba_m.mrba040_desc,g_mrba_m.mrba041,g_mrba_m.mrba042, 
       g_mrba_m.mrbaownid,g_mrba_m.mrbaownid_desc,g_mrba_m.mrbaowndp,g_mrba_m.mrbaowndp_desc,g_mrba_m.mrbacrtid, 
       g_mrba_m.mrbacrtid_desc,g_mrba_m.mrbacrtdp,g_mrba_m.mrbacrtdp_desc,g_mrba_m.mrbacrtdt,g_mrba_m.mrbamodid, 
       g_mrba_m.mrbamodid_desc,g_mrba_m.mrbamoddt,g_mrba_m.mrbacnfid,g_mrba_m.mrbacnfid_desc,g_mrba_m.mrbacnfdt 
 
 
   CASE g_mrba_m.mrbastus
      WHEN "N"
         CALL gfrm_curr.setElementImage("statechange", "stus/32/open.png")
      WHEN "Y"
         CALL gfrm_curr.setElementImage("statechange", "stus/32/valid.png")
      WHEN "X"
         CALL gfrm_curr.setElementImage("statechange", "stus/32/void.png")
      
   END CASE
 
   #add-point:資料刷新後 name="statechange.after_refresh"
   
   #end add-point
 
   MENU "" ATTRIBUTES (STYLE="popup")
      BEFORE MENU
         HIDE OPTION "approved"
         HIDE OPTION "rejection"
         CASE g_mrba_m.mrbastus
            
            WHEN "N"
               HIDE OPTION "open"
            WHEN "Y"
               HIDE OPTION "valid"
            WHEN "X"
               HIDE OPTION "void"
         END CASE
     
      #add-point:menu前 name="statechange.before_menu"
      CALL cl_set_act_visible("open,void,valid",TRUE)
      IF g_mrba_m.mrbastus MATCHES '[YX]' THEN
         CALL cl_set_act_visible("void,valid",FALSE)
      ELSE
         CALL cl_set_act_visible("open",FALSE)
      END IF 
      #end add-point
      
      
	  
      ON ACTION open
         IF cl_auth_chk_act("open") THEN
            LET lc_state = "N"
            #add-point:action控制 name="statechange.open"
         IF g_mrba_m.mrbastus = 'X' THEN LET l_open_state = 'V' END IF
         IF g_mrba_m.mrbastus = 'Y' THEN LET l_open_state = 'C' END IF
            #end add-point
         END IF
         EXIT MENU
      ON ACTION valid
         IF cl_auth_chk_act("valid") THEN
            LET lc_state = "Y"
            #add-point:action控制 name="statechange.valid"
            
            #end add-point
         END IF
         EXIT MENU
      ON ACTION void
         IF cl_auth_chk_act("void") THEN
            LET lc_state = "X"
            #add-point:action控制 name="statechange.void"
            
            #end add-point
         END IF
         EXIT MENU
 
      #add-point:stus控制 name="statechange.more_control"
      
      #end add-point
      
   END MENU
   
   #確認被選取的狀態碼在清單中
   IF (lc_state <> "N" 
      AND lc_state <> "Y"
      AND lc_state <> "X"
      ) OR 
      g_mrba_m.mrbastus = lc_state OR cl_null(lc_state) THEN
      CLOSE amrm200_cl
      CALL s_transaction_end('N','0')
      RETURN
   END IF
   
   #add-point:stus修改前 name="statechange.b_update"
   CASE 
      WHEN lc_state = 'Y'
         CALL s_amrm200_conf_chk(g_mrba_m.mrba001,g_mrba_m.mrbastus) RETURNING g_success,g_errno
         IF g_success THEN
            IF cl_ask_confirm('lib-054') THEN
               CALL s_transaction_begin()
               CALL s_amrm200_conf_upd(g_mrba_m.mrba001) RETURNING g_success,g_errno
               IF g_success THEN
                  CALL s_transaction_end('Y','0')
               ELSE
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = g_errno
                  LET g_errparam.extend = g_mrba_m.mrba001
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  CALL s_transaction_end('N','0')
                  RETURN
               END IF
            ELSE
               CALL s_transaction_end('N','0')   #160812-00017#3 Add By Ken 160815
               RETURN
            END IF
         ELSE
            INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = g_errno
                  LET g_errparam.extend = g_mrba_m.mrba001
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
            CALL s_transaction_end('N','0')   #160812-00017#3 Add By Ken 160815
            RETURN
         END IF
     WHEN lc_state = 'N'
         IF l_open_state = 'C' THEN
            CALL s_amrm200_unconf_chk(g_mrba_m.mrba001,g_mrba_m.mrbastus) RETURNING g_success,g_errno
            IF g_success THEN
               IF cl_ask_confirm('aim-00110') THEN
                  CALL s_transaction_begin()
                  CALL s_amrm200_unconf_upd(g_mrba_m.mrba001) RETURNING g_success,g_errno
                  IF g_success THEN
                     CALL s_transaction_end('Y','0')
                  ELSE
                     INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = g_errno
                  LET g_errparam.extend = g_mrba_m.mrba001
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                     CALL s_transaction_end('N','0')
                     RETURN
                  END IF
               ELSE
                  CALL s_transaction_end('N','0')   #160812-00017#3 Add By Ken 160815
                  RETURN
               END IF
            ELSE
               INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = g_errno
                  LET g_errparam.extend = g_mrba_m.mrba001
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
               CALL s_transaction_end('N','0')   #160812-00017#3 Add By Ken 160815
               RETURN
            END IF
         ELSE
            CALL s_amrm200_unvoid_chk(g_mrba_m.mrba001,g_mrba_m.mrbastus) RETURNING g_success,g_errno
            IF g_success THEN
               IF cl_ask_confirm('lib-017') THEN
                  CALL s_transaction_begin()
                  CALL s_amrm200_unvoid_upd(g_mrba_m.mrba001) RETURNING g_success,g_errno
                  IF g_success THEN
                     CALL s_transaction_end('Y','0')
                  ELSE
                     INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = g_errno
                  LET g_errparam.extend = g_mrba_m.mrba001
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                     CALL s_transaction_end('N','0')
                     RETURN
                  END IF
               ELSE
                  CALL s_transaction_end('N','0')   #160812-00017#3 Add By Ken 160815
                  RETURN
               END IF
            ELSE
               INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = g_errno
                  LET g_errparam.extend = g_mrba_m.mrba001
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
               CALL s_transaction_end('N','0')   #160812-00017#3 Add By Ken 160815
               RETURN
            END IF
         END IF
      WHEN lc_state = 'X'
         CALL s_amrm200_void_chk(g_mrba_m.mrba001,g_mrba_m.mrbastus) RETURNING g_success,g_errno
         IF g_success THEN
            IF cl_ask_confirm('lib-016') THEN
               CALL s_transaction_begin()
               CALL s_amrm200_void_upd(g_mrba_m.mrba001) RETURNING g_success,g_errno
               IF g_success THEN
                  CALL s_transaction_end('Y','0')
               ELSE
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = g_errno
                  LET g_errparam.extend = g_mrba_m.mrba001
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  CALL s_transaction_end('N','0')
                  RETURN
               END IF
            ELSE
               CALL s_transaction_end('N','0')   #160812-00017#3 Add By Ken 160815
               RETURN
            END IF
         ELSE
            INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = g_errno
                  LET g_errparam.extend = g_mrba_m.mrba001
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
            CALL s_transaction_end('N','0')   #160812-00017#3 Add By Ken 160815
            RETURN
         END IF
   END CASE
   #end add-point
   
   LET g_mrba_m.mrbamodid = g_user
   LET g_mrba_m.mrbamoddt = cl_get_current()
   LET g_mrba_m.mrbastus = lc_state
   
   #異動狀態碼欄位/修改人/修改日期
   UPDATE mrba_t 
      SET (mrbastus,mrbamodid,mrbamoddt) 
        = (g_mrba_m.mrbastus,g_mrba_m.mrbamodid,g_mrba_m.mrbamoddt)     
    WHERE mrbaent = g_enterprise AND mrbasite = g_site AND mrba001 = g_mrba_m.mrba001
 
    
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code   = SQLCA.sqlcode 
      LET g_errparam.popup  = FALSE 
      CALL cl_err()
   ELSE
      CASE lc_state
         WHEN "N"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/open.png")
         WHEN "Y"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/valid.png")
         WHEN "X"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/void.png")
         
      END CASE
    
      #撈取異動後的資料
      EXECUTE amrm200_master_referesh USING g_site,g_mrba_m.mrba001 INTO g_mrba_m.mrba019,g_mrba_m.mrba000, 
          g_mrba_m.mrba001,g_mrba_m.mrba002,g_mrba_m.mrba003,g_mrba_m.mrba066,g_mrba_m.mrba004,g_mrba_m.mrba005, 
          g_mrba_m.mrba007,g_mrba_m.mrba008,g_mrba_m.mrba009,g_mrba_m.mrba010,g_mrba_m.mrba011,g_mrba_m.mrba020, 
          g_mrba_m.mrba006,g_mrba_m.mrba104,g_mrba_m.mrba012,g_mrba_m.mrba013,g_mrba_m.mrba014,g_mrba_m.mrba015, 
          g_mrba_m.mrba016,g_mrba_m.mrba017,g_mrba_m.mrba018,g_mrba_m.mrba102,g_mrba_m.mrba100,g_mrba_m.mrba101, 
          g_mrba_m.mrbastus,g_mrba_m.mrba021,g_mrba_m.mrba022,g_mrba_m.mrba025,g_mrba_m.mrba026,g_mrba_m.mrba027, 
          g_mrba_m.mrba103,g_mrba_m.mrba029,g_mrba_m.mrba031,g_mrba_m.mrba032,g_mrba_m.mrba033,g_mrba_m.mrba034, 
          g_mrba_m.mrba035,g_mrba_m.mrba036,g_mrba_m.mrba038,g_mrba_m.mrba039,g_mrba_m.mrba040,g_mrba_m.mrba041, 
          g_mrba_m.mrba042,g_mrba_m.mrbaownid,g_mrba_m.mrbaowndp,g_mrba_m.mrbacrtid,g_mrba_m.mrbacrtdp, 
          g_mrba_m.mrbacrtdt,g_mrba_m.mrbamodid,g_mrba_m.mrbamoddt,g_mrba_m.mrbacnfid,g_mrba_m.mrbacnfdt, 
          g_mrba_m.mrba010_desc,g_mrba_m.mrba011_desc,g_mrba_m.mrba020_desc,g_mrba_m.mrba012_desc,g_mrba_m.mrba013_desc, 
          g_mrba_m.mrba014_desc,g_mrba_m.mrba016_desc,g_mrba_m.mrba017_desc,g_mrba_m.mrba018_desc,g_mrba_m.mrba021_desc, 
          g_mrba_m.mrba022_desc,g_mrba_m.mrba027_desc,g_mrba_m.mrba103_desc,g_mrba_m.mrba040_desc,g_mrba_m.mrbaownid_desc, 
          g_mrba_m.mrbaowndp_desc,g_mrba_m.mrbacrtid_desc,g_mrba_m.mrbacrtdp_desc,g_mrba_m.mrbamodid_desc, 
          g_mrba_m.mrbacnfid_desc
      
      #將資料顯示到畫面上
      DISPLAY BY NAME g_mrba_m.mrba019,g_mrba_m.mrba000,g_mrba_m.mrba001,g_mrba_m.mrba002,g_mrba_m.mrba003, 
          g_mrba_m.mrba066,g_mrba_m.mrba004,g_mrba_m.mrba005,g_mrba_m.mrba007,g_mrba_m.mrba008,g_mrba_m.mrba009, 
          g_mrba_m.mrba010,g_mrba_m.mrba010_desc,g_mrba_m.mrba011,g_mrba_m.mrba011_desc,g_mrba_m.mrba020, 
          g_mrba_m.mrba020_desc,g_mrba_m.mrba006,g_mrba_m.mrba104,g_mrba_m.mrba012,g_mrba_m.mrba012_desc, 
          g_mrba_m.mrba013,g_mrba_m.mrba013_desc,g_mrba_m.mrba014,g_mrba_m.mrba014_desc,g_mrba_m.mrba015, 
          g_mrba_m.mrba016,g_mrba_m.mrba016_desc,g_mrba_m.mrba017,g_mrba_m.mrba017_desc,g_mrba_m.mrba018, 
          g_mrba_m.mrba018_desc,g_mrba_m.mrba102,g_mrba_m.mrba100,g_mrba_m.mrba101,g_mrba_m.mrbastus, 
          g_mrba_m.mrba021,g_mrba_m.mrba021_desc,g_mrba_m.mrba022,g_mrba_m.mrba022_desc,g_mrba_m.mrba025, 
          g_mrba_m.mrba026,g_mrba_m.mrba027,g_mrba_m.mrba027_desc,g_mrba_m.mrba103,g_mrba_m.mrba103_desc, 
          g_mrba_m.mrba029,g_mrba_m.mrba031,g_mrba_m.mrba032,g_mrba_m.mrba033,g_mrba_m.mrba034,g_mrba_m.mrba035, 
          g_mrba_m.mrba036,g_mrba_m.mrba038,g_mrba_m.mrba039,g_mrba_m.mrba040,g_mrba_m.mrba040_desc, 
          g_mrba_m.mrba041,g_mrba_m.mrba042,g_mrba_m.mrbaownid,g_mrba_m.mrbaownid_desc,g_mrba_m.mrbaowndp, 
          g_mrba_m.mrbaowndp_desc,g_mrba_m.mrbacrtid,g_mrba_m.mrbacrtid_desc,g_mrba_m.mrbacrtdp,g_mrba_m.mrbacrtdp_desc, 
          g_mrba_m.mrbacrtdt,g_mrba_m.mrbamodid,g_mrba_m.mrbamodid_desc,g_mrba_m.mrbamoddt,g_mrba_m.mrbacnfid, 
          g_mrba_m.mrbacnfid_desc,g_mrba_m.mrbacnfdt
   END IF
 
   #add-point:stus修改後 name="statechange.a_update"
   
   #end add-point
 
   #add-point:statechange段結束前 name="statechange.after"
   
   #end add-point  
 
   CLOSE amrm200_cl
   CALL s_transaction_end('Y','0')
 
   #功能已完成,通報訊息中心
   CALL amrm200_msgcentre_notify('statechange:'||lc_state)
   
END FUNCTION
 
 
 
 
{</section>}
 
{<section id="amrm200.idx_chk" >}
#+ 顯示正確的單身資料筆數
PRIVATE FUNCTION amrm200_idx_chk()
   #add-point:idx_chk段define(客製用) name="idx_chk.define_customerization"
   
   #end add-point  
   #add-point:idx_chk段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="idx_chk.define"
   
   #end add-point  
   
   #add-point:Function前置處理  name="idx_chk.pre_function"
   
   #end add-point
   
   IF g_current_page = 1 THEN
      LET g_detail_idx = g_curr_diag.getCurrentRow("s_detail1")
      IF g_detail_idx > g_mrbb_d.getLength() THEN
         LET g_detail_idx = g_mrbb_d.getLength()
      END IF
      IF g_detail_idx = 0 AND g_mrbb_d.getLength() <> 0 THEN
         LET g_detail_idx = 1
      END IF
      DISPLAY g_detail_idx TO FORMONLY.idx
      DISPLAY g_mrbb_d.getLength() TO FORMONLY.cnt
   END IF
   
   IF g_current_page = 2 THEN
      LET g_detail_idx = g_curr_diag.getCurrentRow("s_detail2")
      IF g_detail_idx > g_mrbb2_d.getLength() THEN
         LET g_detail_idx = g_mrbb2_d.getLength()
      END IF
      IF g_detail_idx = 0 AND g_mrbb2_d.getLength() <> 0 THEN
         LET g_detail_idx = 1
      END IF
      DISPLAY g_detail_idx TO FORMONLY.idx
      DISPLAY g_mrbb2_d.getLength() TO FORMONLY.cnt
   END IF
   IF g_current_page = 3 THEN
      LET g_detail_idx = g_curr_diag.getCurrentRow("s_detail3")
      IF g_detail_idx > g_mrbb3_d.getLength() THEN
         LET g_detail_idx = g_mrbb3_d.getLength()
      END IF
      IF g_detail_idx = 0 AND g_mrbb3_d.getLength() <> 0 THEN
         LET g_detail_idx = 1
      END IF
      DISPLAY g_detail_idx TO FORMONLY.idx
      DISPLAY g_mrbb3_d.getLength() TO FORMONLY.cnt
   END IF
   IF g_current_page = 4 THEN
      LET g_detail_idx = g_curr_diag.getCurrentRow("s_detail4")
      IF g_detail_idx > g_mrbb4_d.getLength() THEN
         LET g_detail_idx = g_mrbb4_d.getLength()
      END IF
      IF g_detail_idx = 0 AND g_mrbb4_d.getLength() <> 0 THEN
         LET g_detail_idx = 1
      END IF
      DISPLAY g_detail_idx TO FORMONLY.idx
      DISPLAY g_mrbb4_d.getLength() TO FORMONLY.cnt
   END IF
   IF g_current_page = 5 THEN
      LET g_detail_idx = g_curr_diag.getCurrentRow("s_detail5")
      IF g_detail_idx > g_mrbb5_d.getLength() THEN
         LET g_detail_idx = g_mrbb5_d.getLength()
      END IF
      IF g_detail_idx = 0 AND g_mrbb5_d.getLength() <> 0 THEN
         LET g_detail_idx = 1
      END IF
      DISPLAY g_detail_idx TO FORMONLY.idx
      DISPLAY g_mrbb5_d.getLength() TO FORMONLY.cnt
   END IF
   IF g_current_page = 6 THEN
      LET g_detail_idx = g_curr_diag.getCurrentRow("s_detail6")
      IF g_detail_idx > g_mrbb6_d.getLength() THEN
         LET g_detail_idx = g_mrbb6_d.getLength()
      END IF
      IF g_detail_idx = 0 AND g_mrbb6_d.getLength() <> 0 THEN
         LET g_detail_idx = 1
      END IF
      DISPLAY g_detail_idx TO FORMONLY.idx
      DISPLAY g_mrbb6_d.getLength() TO FORMONLY.cnt
   END IF
 
   
   #add-point:idx_chk段other name="idx_chk.other"
   
   #end add-point  
   
END FUNCTION
 
{</section>}
 
{<section id="amrm200.b_fill2" >}
#+ 單身陣列填充2
PRIVATE FUNCTION amrm200_b_fill2(pi_idx)
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
   
   CALL amrm200_detail_show()
   
   LET g_detail_idx = li_detail_idx_tmp
   
END FUNCTION
 
{</section>}
 
{<section id="amrm200.fill_chk" >}
#+ 單身填充確認
PRIVATE FUNCTION amrm200_fill_chk(ps_idx)
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
      (cl_null(g_wc2_table3) OR g_wc2_table3.trim() = '1=1')  AND 
      (cl_null(g_wc2_table4) OR g_wc2_table4.trim() = '1=1')  AND 
      (cl_null(g_wc2_table5) OR g_wc2_table5.trim() = '1=1')  AND 
      (cl_null(g_wc2_table6) OR g_wc2_table6.trim() = '1=1') THEN
      #add-point:fill_chk段other_chk name="fill_chk.other_chk"
      
      #end add-point
      RETURN TRUE
   END IF
   
   #add-point:fill_chk段after_chk name="fill_chk.after_chk"
   
   #end add-point
   
   RETURN TRUE
 
END FUNCTION
 
{</section>}
 
{<section id="amrm200.status_show" >}
PRIVATE FUNCTION amrm200_status_show()
   #add-point:status_show段define(客製用) name="status_show.define_customerization"
   
   #end add-point
   #add-point:status_show段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="status_show.define"
   
   #end add-point
   
   #add-point:status_show段status_show name="status_show.status_show"
   
   #end add-point
END FUNCTION
 
{</section>}
 
{<section id="amrm200.mask_functions" >}
&include "erp/cmr/amrm200_mask.4gl"
 
{</section>}
 
{<section id="amrm200.signature" >}
   
 
{</section>}
 
{<section id="amrm200.set_pk_array" >}
   #應用 a51 樣板自動產生(Version:8)
#+ 給予pk_array內容
PRIVATE FUNCTION amrm200_set_pk_array()
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
   LET g_pk_array[1].values = g_mrba_m.mrba001
   LET g_pk_array[1].column = 'mrba001'
 
   
   #add-point:set_pk_array段之後 name="set_pk_array.after"
   
   #end add-point  
   
END FUNCTION
 
 
 
 
{</section>}
 
{<section id="amrm200.other_dialog" readonly="Y" >}
   
 
{</section>}
 
{<section id="amrm200.msgcentre_notify" >}
#應用 a66 樣板自動產生(Version:6)
PRIVATE FUNCTION amrm200_msgcentre_notify(lc_state)
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
   CALL amrm200_set_pk_array()
   #單頭資料填寫
   LET g_msgparam.data[1] = util.JSON.stringify(g_mrba_m)
 
   #add-point:msgcentre其他通知 name="msgcentre_notify.process"
   
   #end add-point
 
   #呼叫訊息中心傳遞本關完成訊息
   CALL cl_msgcentre_notify()
 
END FUNCTION
 
 
 
 
{</section>}
 
{<section id="amrm200.action_chk" >}
#+ 修改/刪除前行為檢查(是否可允許此動作), 若有其他行為須管控也可透過此段落
PRIVATE FUNCTION amrm200_action_chk()
   #add-point:action_chk段define(客製用) name="action_chk.define_customerization"
   
   #end add-point
   #add-point:action_chk段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="action_chk.define"
   
   #end add-point
   
   #add-point:action_chk段action_chk name="action_chk.action_chk"
   #160818-00017#23 add-S
   SELECT mrbastus  INTO g_mrba_m.mrbastus
     FROM mrba_t
    WHERE mrbaent = g_enterprise
      AND mrba001 = g_mrba_m.mrba001
      AND mrbasite = g_site

   #IF(g_action_choice="modify" OR g_action_choice="delete" OR g_action_choice="modify_detail")  THEN #160818-00017#47
   IF g_action_choice="delete" THEN  #160818-00017#47
     LET g_errno = NULL
     CASE g_mrba_m.mrbastus
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
        LET g_errparam.extend = g_mrba_m.mrba001
        LET g_errparam.popup = TRUE
        CALL cl_err()
        LET g_errno = NULL
        CALL amrm200_set_act_visible()
        CALL amrm200_set_act_no_visible()
        CALL amrm200_show()
        RETURN FALSE
     END IF
   END IF
   #160818-00017#23 add-E
   #160818-00017#47--S
   IF (g_action_choice="modify" OR g_action_choice="modify_detail")  THEN
      LET g_errno = NULL
      CASE g_mrba_m.mrbastus
         WHEN 'W'
            LET g_errno = 'sub-00180'
         WHEN 'X'
            LET g_errno = 'sub-00229'
         WHEN 'S'
            LET g_errno = 'sub-00230'
      END CASE
    
     IF NOT cl_null(g_errno) THEN
        INITIALIZE g_errparam TO NULL
        LET g_errparam.code = g_errno
        LET g_errparam.extend = g_mrba_m.mrba001
        LET g_errparam.popup = TRUE
        CALL cl_err()
        LET g_errno = NULL
        CALL amrm200_set_act_visible()
        CALL amrm200_set_act_no_visible()
        CALL amrm200_show()
        RETURN FALSE
     END IF
   END IF
   #160818-00017#47--E  
   #end add-point
      
   RETURN TRUE
   
END FUNCTION
 
{</section>}
 
{<section id="amrm200.other_function" readonly="Y" >}

PRIVATE FUNCTION amrm200_mrba010_desc(p_mrba010)
DEFINE p_mrba010   LIKE mrba_t.mrba010
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = p_mrba010
   CALL ap_ref_array2(g_ref_fields,"SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001='1101' AND oocql002=? AND oocql003='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_mrba_m.mrba010_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_mrba_m.mrba010_desc
END FUNCTION

PRIVATE FUNCTION amrm200_mrba011_desc(p_mrba011)
DEFINE p_mrba011  LIKE mrba_t.mrba011
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = p_mrba011
   CALL ap_ref_array2(g_ref_fields,"SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001='1102' AND oocql002=? AND oocql003='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_mrba_m.mrba011_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_mrba_m.mrba011_desc
END FUNCTION

PRIVATE FUNCTION amrm200_mrba012_desc(p_mrba012)
DEFINE p_mrba012   LIKE mrba_t.mrba012
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = p_mrba012
   CALL ap_ref_array2(g_ref_fields,"SELECT oocgl003 FROM oocgl_t WHERE oocglent='"||g_enterprise||"' AND oocgl001=? AND oocgl002='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_mrba_m.mrba012_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_mrba_m.mrba012_desc
END FUNCTION

PRIVATE FUNCTION amrm200_mrba013_desc(p_mrba013)
DEFINE p_mrba013   LIKE mrba_t.mrba013
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = p_mrba013
   CALL ap_ref_array2(g_ref_fields,"SELECT pmaal004 FROM pmaal_t WHERE pmaalent='"||g_enterprise||"' AND pmaal001=? AND pmaal002='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_mrba_m.mrba013_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_mrba_m.mrba013_desc
END FUNCTION

PRIVATE FUNCTION amrm200_mrba014_desc(p_mrba014)
DEFINE p_mrba014   LIKE mrba_t.mrba014
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = p_mrba014 
   CALL ap_ref_array2(g_ref_fields,"SELECT pmaal004 FROM pmaal_t WHERE pmaalent='"||g_enterprise||"' AND pmaal001=? AND pmaal002='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_mrba_m.mrba014_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_mrba_m.mrba014_desc
END FUNCTION

PRIVATE FUNCTION amrm200_mrba020_default()
   IF g_mrba_m.mrba019 = '0' THEN
      LET g_mrba_m.mrba020 = g_site
      DISPLAY BY NAME g_mrba_m.mrba020
   END IF
   
END FUNCTION

PRIVATE FUNCTION amrm200_mrba016_desc(p_mrba016)
DEFINE p_mrba016   LIKE mrba_t.mrba016
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = p_mrba016 
   CALL ap_ref_array2(g_ref_fields,"SELECT ooag011 FROM ooag_t WHERE ooagent='"||g_enterprise||"' AND ooag001=? ","") RETURNING g_rtn_fields
   LET g_mrba_m.mrba016_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_mrba_m.mrba016_desc
END FUNCTION

PRIVATE FUNCTION amrm200_mrba020_chk()
   IF NOT cl_null(g_mrba_m.mrba020) AND NOT cl_null(g_mrba_m.mrba019) THEN
      INITIALIZE g_chkparam.* TO NULL
      LET g_chkparam.arg1 = g_mrba_m.mrba020
      IF g_mrba_m.mrba019 = '0' THEN
#160716-00011#1-s
#所有權據點的校驗目前使用v_ooef001_3,檢查結果不對,請改成使用v_ooef001_20
#         LET g_chkparam.arg2 = '2'
#         IF NOT cl_chk_exist("v_ooef001_3") THEN
         IF NOT cl_chk_exist("v_ooef001_20") THEN
#160716-00011#1-e
            RETURN FALSE
         END IF
      END IF
      IF g_mrba_m.mrba019 = '1' THEN
         LET g_chkparam.arg2 = g_site
         #160318-00025#6--add--str
         LET g_errshow = TRUE 
         LET g_chkparam.err_str[1] = "apm-00201:sub-01302|axmm200|",cl_get_progname("axmm200",g_lang,"2"),"|:EXEPROGaxmm200"
         #160318-00025#6--add--end
         IF NOT cl_chk_exist("v_pmaa001_3") THEN  
            RETURN FALSE
         END IF
      END IF
   END IF
   RETURN TRUE
END FUNCTION

PRIVATE FUNCTION amrm200_mrba020_desc(p_mrba020)
DEFINE p_mrba020   LIKE mrba_t.mrba020
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = p_mrba020 
   IF g_mrba_m.mrba019 = '0' THEN
      CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
   END IF
   IF g_mrba_m.mrba019 = '1' THEN
      CALL ap_ref_array2(g_ref_fields,"SELECT pmaal004 FROM pmaal_t WHERE pmaalent='"||g_enterprise||"' AND pmaal001=? AND pmaal002='"||g_dlang||"'","") RETURNING g_rtn_fields
   END IF
   LET g_mrba_m.mrba020_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_mrba_m.mrba020_desc
END FUNCTION

PRIVATE FUNCTION amrm200_mrba017_desc(p_mrba017)
DEFINE p_mrba017   LIKE mrba_t.mrba017
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = p_mrba017
   CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_mrba_m.mrba017_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_mrba_m.mrba017_desc
END FUNCTION

PRIVATE FUNCTION amrm200_mrba021_desc(p_mrba021)
DEFINE p_mrba021   LIKE mrba_t.mrba021
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = p_mrba021
   CALL ap_ref_array2(g_ref_fields,"SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001='221' AND oocql002=? AND oocql003='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_mrba_m.mrba021_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_mrba_m.mrba021_desc
END FUNCTION

PRIVATE FUNCTION amrm200_mrba022_desc(p_mrba022)
DEFINE p_mrba022   LIKE mrba_t.mrba022
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_site
   LET g_ref_fields[2] = p_mrba022
   CALL ap_ref_array2(g_ref_fields,"SELECT ecaa002 FROM ecaa_t WHERE ecaaent='"||g_enterprise||"' AND ecaasite=? AND ecaa001=? ","") RETURNING g_rtn_fields
   LET g_mrba_m.mrba022_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_mrba_m.mrba022_desc
END FUNCTION

PRIVATE FUNCTION amrm200_mrba027_desc(p_mrba027)
DEFINE p_mrba027  LIKE mrba_t.mrba027
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = p_mrba027
   CALL ap_ref_array2(g_ref_fields,"SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001='1103' AND oocql002=? AND oocql003='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_mrba_m.mrba027_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_mrba_m.mrba027_desc
END FUNCTION

PRIVATE FUNCTION amrm200_mrba040_desc(p_mrba040)
DEFINE p_mrba040   LIKE mrba_t.mrba040
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = p_mrba040
   CALL ap_ref_array2(g_ref_fields,"SELECT ooail003 FROM ooail_t WHERE ooailent='"||g_enterprise||"' AND ooail001=? AND ooail002='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_mrba_m.mrba040_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_mrba_m.mrba040_desc
END FUNCTION

PRIVATE FUNCTION amrm200_mrbb003_desc(p_mrbb003)
DEFINE p_mrbb003  LIKE mrbb_t.mrbb003
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = p_mrbb003
   CALL ap_ref_array2(g_ref_fields,"SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001='1104' AND oocql002=? AND oocql003='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_mrbb_d[l_ac].mrbb003_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_mrbb_d[l_ac].mrbb003_desc
END FUNCTION

PRIVATE FUNCTION amrm200_mrbb004_desc(p_mrbb004)
DEFINE p_mrbb004   LIKE mrbb_t.mrbb004   
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = p_mrbb004
   CALL ap_ref_array2(g_ref_fields,"SELECT mraal003 FROM mraal_t WHERE mraalent='"||g_enterprise||"' AND mraal001=? AND mraal002='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_mrbb_d[l_ac].mrbb004_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_mrbb_d[l_ac].mrbb004_desc
END FUNCTION

PRIVATE FUNCTION amrm200_mrbb006_desc(p_mrbb006)
DEFINE p_mrbb006   LIKE mrbb_t.mrbb006
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = p_mrbb006
   IF g_mrbb_d[l_ac].mrbb005 = '0' THEN
      CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
   END IF
   IF g_mrbb_d[l_ac].mrbb005 = '1' THEN
      CALL ap_ref_array2(g_ref_fields,"SELECT pmaal004 FROM pmaal_t WHERE pmaalent='"||g_enterprise||"' AND pmaal001=? AND pmaal002='"||g_dlang||"'","") RETURNING g_rtn_fields
   END IF
   LET g_mrbb_d[l_ac].mrbb006_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_mrbb_d[l_ac].mrbb006_desc
END FUNCTION

PRIVATE FUNCTION amrm200_mrbb012_desc(p_mrbb012)
DEFINE p_mrbb012  LIKE mrbb_t.mrbb012
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = p_mrbb012
   CALL ap_ref_array2(g_ref_fields,"SELECT ooag011 FROM ooag_t WHERE ooagent='"||g_enterprise||"' AND ooag001=? ","") RETURNING g_rtn_fields
   LET g_mrbb_d[l_ac].mrbb012_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_mrbb_d[l_ac].mrbb012_desc
END FUNCTION

PRIVATE FUNCTION amrm200_mrbc007_mrbc008_compare()
   IF NOT cl_null(g_mrbb2_d[l_ac].mrbc007) AND NOT cl_null(g_mrbb2_d[l_ac].mrbc008) THEN
      IF g_mrbb2_d[l_ac].mrbc007 > g_mrbb2_d[l_ac].mrbc008 THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = 'amr-00011'
         LET g_errparam.extend = g_mrbb2_d[l_ac].mrbc007||">"||g_mrbb2_d[l_ac].mrbc008
         LET g_errparam.popup = TRUE
         CALL cl_err()

         RETURN FALSE
      END IF
   END IF
   RETURN TRUE
END FUNCTION

PRIVATE FUNCTION amrm200_mrbd003_desc(p_mrbd003)
DEFINE p_mrbd003   LIKE mrbd_t.mrbd003
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = p_mrbd003
   CALL ap_ref_array2(g_ref_fields,"SELECT imaal003,imaal004 FROM imaal_t WHERE imaalent='"||g_enterprise||"' AND imaal001=? AND imaal002='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_mrbb3_d[l_ac].mrbd003_desc = '', g_rtn_fields[1] , ''
   LET g_mrbb3_d[l_ac].mrbd003_desc_desc = g_rtn_fields[2]
   DISPLAY BY NAME g_mrbb3_d[l_ac].mrbd003_desc,g_mrbb3_d[l_ac].mrbd003_desc_desc   
   IF cl_null(g_mrbb3_d[l_ac].mrbd006) THEN
      SELECT imaa006 INTO g_mrbb3_d[l_ac].mrbd006 FROM imaa_t 
       WHERE imaaent = g_enterprise AND imaa001 = p_mrbd003
      DISPLAY BY NAME g_mrbb3_d[l_ac].mrbd006
   END IF
END FUNCTION

PRIVATE FUNCTION amrm200_mrbd005_desc(p_mrbd005)
DEFINE p_mrbd005   LIKE mrbd_t.mrbd005
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = p_mrbd005
   CALL ap_ref_array2(g_ref_fields,"SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001='1105' AND oocql002=? AND oocql003='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_mrbb3_d[l_ac].mrbd005_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_mrbb3_d[l_ac].mrbd005_desc
END FUNCTION

PRIVATE FUNCTION amrm200_mrbd006_desc(p_mrbd006)
DEFINE p_mrbd006   LIKE mrbd_t.mrbd006
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = p_mrbd006
   CALL ap_ref_array2(g_ref_fields,"SELECT oocal003 FROM oocal_t WHERE oocalent='"||g_enterprise||"' AND oocal001=? AND oocal002='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_mrbb3_d[l_ac].mrbd006_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_mrbb3_d[l_ac].mrbd006_desc
END FUNCTION

PRIVATE FUNCTION amrm200_mrbe002_chk(p_cmd,p_mrbe002)
DEFINE p_cmd     LIKE type_t.chr1 
DEFINE p_mrbe002 LIKE mrbe_t.mrbe002
   IF NOT cl_null(p_mrbe002) THEN
      IF  g_mrba_m.mrba001 IS NOT NULL AND g_mrbb4_d[g_detail_idx].mrbe002 IS NOT NULL THEN 
         IF p_cmd = 'a' OR ( p_cmd = 'u' AND (g_mrba_m.mrba001 != g_mrba001_t OR g_mrbb4_d[g_detail_idx].mrbe002 != g_mrbb4_d_t.mrbe002)) THEN 
            IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM mrbe_t WHERE "||"mrbeent = '" ||g_enterprise|| "' AND mrbesite = '" ||g_site|| "' AND "||"mrbe001 = '"||g_mrba_m.mrba001 ||"' AND "|| "mrbe002 = '"||g_mrbb4_d[g_detail_idx].mrbe002 ||"'",'std-00004',0) THEN 
               RETURN FALSE
            END IF
         END IF
      END IF
      INITIALIZE g_chkparam.* TO NULL
        
      LET g_chkparam.arg1 = p_mrbe002
      IF NOT cl_chk_exist("v_imaa001_6") THEN
         RETURN FALSE
      END IF
   END IF
   RETURN TRUE
END FUNCTION

PRIVATE FUNCTION amrm200_mrbe002_controlp_chk()
DEFINE  tok            base.StringTokenizer
DEFINE  l_imaa001         LIKE imaa_t.imaa001
   LET tok = base.StringTokenizer.create(g_qryparam.return1,"|")
   WHILE tok.hasMoreTokens()
       LET l_imaa001 = tok.nextToken()
       IF NOT amrm200_mrbe002_chk('a',l_imaa001) THEN
          CONTINUE WHILE
       END IF
       CALL amrm200_mrbe_insert(l_imaa001)
   END WHILE    
END FUNCTION

PRIVATE FUNCTION amrm200_mrbe_insert(p_imaa001)
DEFINE p_imaa001   LIKE imaa_t.imaa001
   INSERT INTO mrbe_t (mrbeent,mrbesite,mrbe001,mrbe002)
               VALUES (g_enterprise,g_site,g_mrba_m.mrba001,p_imaa001)
   IF SQLCA.SQLCODE THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.SQLCODE
      LET g_errparam.extend = ''
      LET g_errparam.popup = FALSE
      CALL cl_err()

   END IF
END FUNCTION

PRIVATE FUNCTION amrm200_mrbe002_desc(p_mrbe002)
DEFINE p_mrbe002   LIKE mrbe_t.mrbe002

   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = p_mrbe002
   CALL ap_ref_array2(g_ref_fields,"SELECT imaal003,imaal004 FROM imaal_t WHERE imaalent='"||g_enterprise||"' AND imaal001=? AND imaal002='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_mrbb4_d[l_ac].mrbe002_desc = '', g_rtn_fields[1] , ''
   LET g_mrbb4_d[l_ac].mrbe002_desc_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_mrbb4_d[l_ac].mrbe002_desc,g_mrbb4_d[l_ac].mrbe002_desc_desc 
END FUNCTION

PRIVATE FUNCTION amrm200_mrbf002_chk(p_cmd,p_mrbf002)
DEFINE p_cmd      LIKE type_t.chr1
DEFINE p_mrbf002  LIKE mrbf_t.mrbf002
   IF NOT cl_null(p_mrbf002) THEN
      IF  g_mrba_m.mrba001 IS NOT NULL AND g_mrbb5_d[g_detail_idx].mrbf002 IS NOT NULL THEN 
         IF p_cmd = 'a' OR ( p_cmd = 'u' AND (g_mrba_m.mrba001 != g_mrba001_t OR g_mrbb5_d[g_detail_idx].mrbf002 != g_mrbb5_d_t.mrbf002)) THEN 
            IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM mrbf_t WHERE "||"mrbfent = '" ||g_enterprise|| "' AND mrbfsite = '" ||g_site|| "' AND "||"mrbf001 = '"||g_mrba_m.mrba001 ||"' AND "|| "mrbf002 = '"||g_mrbb5_d[g_detail_idx].mrbf002 ||"'",'std-00004',0) THEN 
               RETURN FALSE
            END IF
         END IF
      END IF
      INITIALIZE g_chkparam.* TO NULL
           
      LET g_chkparam.arg1 = p_mrbf002
      #160318-00025#6--add--str
      LET g_errshow = TRUE 
      LET g_chkparam.err_str[1] = "amr-00004:sub-01302|amrm200|",cl_get_progname("amrm200",g_lang,"2"),"|:EXEPROGamrm200"
      #160318-00025#6--add--end
      IF NOT cl_chk_exist("v_mrba001_2") THEN
         RETURN FALSE
      END IF
   END IF
   RETURN TRUE
   
END FUNCTION

PRIVATE FUNCTION amrm200_mrbf002_desc(p_mrbf002)
DEFINE p_mrbf002   LIKE mrbf_t.mrbf002
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_site
   LET g_ref_fields[2] = p_mrbf002
   #150615-00004#1-mod-(S) mrbasite打錯
#   CALL ap_ref_array2(g_ref_fields,"SELECT mrba004,mrba005 FROM mrba_t WHERE mrbaent='"||g_enterprise||"' AND mrbastie=? AND mrba001=? ","") RETURNING g_rtn_fields
   CALL ap_ref_array2(g_ref_fields,"SELECT mrba004,mrba005 FROM mrba_t WHERE mrbaent='"||g_enterprise||"' AND mrbasite=? AND mrba001=? ","") RETURNING g_rtn_fields
   #150615-00004#1-mod-(E)
   LET g_mrbb5_d[l_ac].mrbf002_desc = '', g_rtn_fields[1] , ''
   LET g_mrbb5_d[l_ac].mrbf002_desc_desc = '', g_rtn_fields[2] , ''
   DISPLAY BY NAME g_mrbb5_d[l_ac].mrbf002_desc,g_mrbb5_d[l_ac].mrbf002_desc_desc
END FUNCTION

PRIVATE FUNCTION amrm200_mrbf002_controlp_chk()
DEFINE  tok            base.StringTokenizer
DEFINE  l_mrba001      LIKE mrba_t.mrba001
   LET tok = base.StringTokenizer.create(g_qryparam.return1,"|")
   WHILE tok.hasMoreTokens()
       LET l_mrba001 = tok.nextToken()
       IF NOT amrm200_mrbf002_chk('a',l_mrba001) THEN
          CONTINUE WHILE
       END IF
       CALL amrm200_mrbf_insert(l_mrba001)
   END WHILE 
END FUNCTION

PRIVATE FUNCTION amrm200_mrbf_insert(p_mrba001)
DEFINE p_mrba001  LIKE mrba_t.mrba001
   INSERT INTO mrbf_t (mrbfent,mrbfsite,mrbf001,mrbf002)
               VALUES (g_enterprise,g_site,g_mrba_m.mrba001,p_mrba001)
   IF SQLCA.SQLCODE THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.SQLCODE
      LET g_errparam.extend = ''
      LET g_errparam.popup = FALSE
      CALL cl_err()

   END IF
END FUNCTION

PRIVATE FUNCTION amrm200_mrbg004_desc(p_mrbg004)
DEFINE p_mrbg004   LIKE mrbg_t.mrbg004
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = p_mrbg004
   CALL ap_ref_array2(g_ref_fields,"SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001='1107' AND oocql002=? AND oocql003='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_mrbb6_d[l_ac].mrbg004_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_mrbb6_d[l_ac].mrbg004_desc
END FUNCTION

PRIVATE FUNCTION amrm200_mrba040_required()
   CALL cl_set_comp_required("mrba040",FALSE)
   IF NOT cl_null(g_mrba_m.mrba038) THEN
      CALL cl_set_comp_required("mrba040",TRUE)
   END IF
END FUNCTION

PRIVATE FUNCTION amrm200_mrbb007_mrbb008_chk()
   IF g_mrbb_d[l_ac].mrbb007 > g_mrbb_d[l_ac].mrbb008 THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'amr-00045'
      LET g_errparam.extend = g_mrbb_d[l_ac].mrbb007||" > "||g_mrbb_d[l_ac].mrbb008
      LET g_errparam.popup = TRUE
      CALL cl_err()

      RETURN FALSE
   END IF
   RETURN TRUE
END FUNCTION

PRIVATE FUNCTION amrm200_mrbd009_mrbd010_chk()
   IF g_mrbb3_d[l_ac].mrbd009 > g_mrbb3_d[l_ac].mrbd010 THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'amr-00046'
      LET g_errparam.extend = g_mrbb3_d[l_ac].mrbd009||" > "||g_mrbb3_d[l_ac].mrbd010
      LET g_errparam.popup = TRUE
      CALL cl_err()

      RETURN FALSE
   END IF
   RETURN TRUE
END FUNCTION

PRIVATE FUNCTION amrm200_mrbg006_mrbg007_chk()
   IF g_mrbb6_d[l_ac].mrbg006 > g_mrbb6_d[l_ac].mrbg007 THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'amr-00047'
      LET g_errparam.extend = g_mrbb6_d[l_ac].mrbg006||" > "||g_mrbb6_d[l_ac].mrbg007
      LET g_errparam.popup = TRUE
      CALL cl_err()

      RETURN FALSE
   END IF
   RETURN TRUE
END FUNCTION

PRIVATE FUNCTION amrm200_mrba103_desc()
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_mrba_m.mrba103
   CALL ap_ref_array2(g_ref_fields,"SELECT oogd002 FROM oogd_t WHERE oogdent='"||g_enterprise||"' AND oogdsite='"||g_site||"' AND oogd001=? ","") RETURNING g_rtn_fields
   LET g_mrba_m.mrba103_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_mrba_m.mrba103_desc
END FUNCTION

################################################################################
# Descriptions...: 檢查輸入的財產編號+附號+卡片編號要存在固定資產基本資料
# Memo...........:
# Usage..........: CALL amrm200_faah_chk()
#                  RETURNING r_success
# Input parameter: 無
# Return code....: r_success   檢查結果(TRUE:正確,FALSE:錯誤)
# Date & Author..: 15/06/26 By Sarah
# Modify.........:
################################################################################
PRIVATE FUNCTION amrm200_faah_chk()
DEFINE r_success LIKE type_t.num5
DEFINE l_cnt     LIKE type_t.num5

   LET r_success = TRUE

   IF NOT cl_null(g_mrba_m.mrba002) AND g_mrba_m.mrba003 IS NOT NULL AND
      NOT cl_null(g_mrba_m.mrba066) THEN
      #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
      INITIALIZE g_chkparam.* TO NULL
      #設定g_chkparam.*的參數
      LET g_chkparam.arg1 = g_mrba_m.mrba002
      LET g_chkparam.arg2 = g_mrba_m.mrba003
      LET g_chkparam.arg3 = g_mrba_m.mrba066
      #160318-00025#6--add--str
      LET g_errshow = TRUE 
      LET g_chkparam.err_str[1] = "afa-00264:sub-01313|afai100|",cl_get_progname("afai100",g_lang,"2"),"|:EXEPROGafai100"
      #160318-00025#6--add--end
      #呼叫檢查存在並帶值的library
      IF cl_chk_exist("v_faah003_3") THEN
         #檢查財產編號+附號+卡片編號+企業編號在資源主檔table中不可重複
         LET l_cnt = 0
         SELECT COUNT(*) INTO l_cnt
           FROM mrba_t
          WHERE mrbaent = g_enterprise
            AND mrba002 = g_mrba_m.mrba002
            AND mrba003 = g_mrba_m.mrba003
            AND mrba066 = g_mrba_m.mrba066
            AND mrba001 <> g_mrba_m.mrba001
         IF cl_null(l_cnt) THEN LET l_cnt = 0 END IF
         IF l_cnt > 0 THEN
            LET g_mrba_m.mrba002 = g_mrba_m_t.mrba002
            LET g_mrba_m.mrba003 = g_mrba_m_t.mrba003
            LET g_mrba_m.mrba066 = g_mrba_m_t.mrba066
            LET g_mrba_m.mrba004 = g_mrba_m_t.mrba004
            LET g_mrba_m.mrba006 = g_mrba_m_t.mrba006
            LET g_mrba_m.mrba104 = g_mrba_m_t.mrba104
            LET g_mrba_m.mrba018 = g_mrba_m_t.mrba018
            
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = 'amr-00111'   #財產編號+附號+卡片編號+企業編號在資源主檔中不可重複
            LET g_errparam.extend = ''
            LET g_errparam.popup = TRUE
            CALL cl_err()
            LET r_success = FALSE
         ELSE      
            #檢查成功時後續處理
            #依財產編號+附號+卡片編號+企業編號自動帶出資源名稱、資源數量、已借出數量、存放位置
            SELECT faah012,faah018,faah019,faah027
              INTO g_mrba_m.mrba004,g_mrba_m.mrba006,g_mrba_m.mrba104,g_mrba_m.mrba018
              FROM faah_t
             WHERE faahent = g_enterprise
               AND faah001 = g_mrba_m.mrba066
               AND faah003 = g_mrba_m.mrba002
               AND faah004 = g_mrba_m.mrba003
            DISPLAY BY NAME g_mrba_m.mrba004,g_mrba_m.mrba006,
                            g_mrba_m.mrba104,g_mrba_m.mrba018
         END IF
      ELSE
         #檢查失敗時後續處理
         LET g_mrba_m.mrba002 = g_mrba_m_t.mrba002
         LET g_mrba_m.mrba003 = g_mrba_m_t.mrba003
         LET g_mrba_m.mrba066 = g_mrba_m_t.mrba066
         LET r_success = FALSE
      END IF
   END IF
 
   RETURN r_success

END FUNCTION

################################################################################
# Descriptions...: 執行整單操作改變了資源狀態後,重新顯示資源狀態的值
# Memo...........:
# Usage..........: CALL amrm200_mrba100_show()
# Input parameter: 無
# Return code....: 無
# Date & Author..: 15/07/31 By Sarah
# Modify.........:
################################################################################
PRIVATE FUNCTION amrm200_mrba100_show()
   #150615-00004#1-mod-(S)
#   SELECT mrba100 INTO g_mrba_m.mrba100
#     FROM mrba_t
#    WHERE mrbaent = g_enterprise
#      AND mrba001 = g_mrba_m.mrba001
#      AND mrbasite = g_site
#   DISPLAY BY NAME g_mrba_m.mrba100
   SELECT mrba100,mrba033 INTO g_mrba_m.mrba100,g_mrba_m.mrba033
     FROM mrba_t
    WHERE mrbaent = g_enterprise
      AND mrba001 = g_mrba_m.mrba001
      AND mrbasite = g_site
   DISPLAY BY NAME g_mrba_m.mrba100,g_mrba_m.mrba033
   #150615-00004#1-mod-(E)
END FUNCTION

################################################################################
# Descriptions...: 若資源編號(mrba001)+資源群組(mrba027)不存在mrbi_t中，則新增
# Memo...........:
# Usage..........: CALL amrm200_ins_mrbi()
#                  RETURNING r_success
# Input parameter: 
# Return code....: r_success 新增成功否(TRUE/FALSE)
# Date & Author..: 2016/01/07 By Dorislai(151215-00002#3)
# Modify.........:
################################################################################
PRIVATE FUNCTION amrm200_ins_mrbi()
   DEFINE l_cnt     LIKE type_t.num5
   DEFINE r_success LIKE type_t.num5
   
   LET l_cnt = 0
   LET r_success = TRUE
   IF NOT cl_null(g_mrba_m.mrba027) AND NOT cl_null(g_mrba_m.mrba001) THEN
      SELECT COUNT(1) INTO l_cnt
        FROM mrbi_t
       WHERE mrbient  = g_enterprise
         AND mrbisite = g_site
         AND mrbi001  = g_mrba_m.mrba027
         AND mrbi002  = g_mrba_m.mrba001
      IF l_cnt = 0 THEN
         INSERT INTO mrbi_t(mrbient,mrbisite,mrbi001,mrbi002)
              VALUES(g_enterprise,g_site,g_mrba_m.mrba027,g_mrba_m.mrba001)
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "INSERT INTO mrbi_t" 
            LET g_errparam.code   = SQLCA.sqlcode 
            LET g_errparam.popup  = TRUE 
            CALL cl_err()
            LET r_success = FALSE
         END IF
      END IF
   END IF
   
   RETURN r_success
END FUNCTION

################################################################################
# Descriptions...: 資料刪除時，一併刪除該資料編號的mrbi_t
# Memo...........: #在刪除時，amri201裡相同的資源編號都要刪除
# Usage..........: amrm200_del_mrbi()
# Input parameter: 
# Return code....:
# Date & Author..: 2016/01/07 By Dorislai(151215-00002#3)
# Modify.........: 
################################################################################
PRIVATE FUNCTION amrm200_del_mrbi()
   DEFINE l_cnt LIKE type_t.num5
   
   LET l_cnt = 0
   IF NOT cl_null(g_mrba_m.mrba001) THEN
      SELECT COUNT(1) INTO l_cnt
        FROM mrbi_t
       WHERE mrbient  = g_enterprise
         AND mrbisite = g_site
         AND mrbi002  = g_mrba_m.mrba001
      IF l_cnt > 0 THEN
         DELETE FROM mrbi_t
          WHERE mrbient  = g_enterprise
            AND mrbisite = g_site
            AND mrbi002  = g_mrba_m.mrba001
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "DELETE mrbi_t" 
            LET g_errparam.code   = SQLCA.sqlcode 
            LET g_errparam.popup  = TRUE 
            CALL cl_err()
         END IF
      END IF
   END IF
END FUNCTION

################################################################################
# Descriptions...: 檢查預估除役日期
# Memo...........:
# Usage..........: CALL amrm200_mrba034_chk(p_field)
#                  RETURNING r_success
# Input parameter: p_field(1.mrba032/2.mrba033)
# Return code....: r_success 成功否(TRUE/FALSE)
# Date & Author..: #160624-00006#1 2016/07/01 By catmoon
# Modify.........:
################################################################################
PRIVATE FUNCTION amrm200_mrba034_chk(p_field)
   #160624-00006#1--add--start--
   DEFINE p_field LIKE type_t.num5
   DEFINE r_success LIKE type_t.num5
   
   LET r_success = TRUE
   
   IF cl_null(g_mrba_m.mrba034) THEN 
      RETURN r_success
   END IF
   
   CASE p_field
      WHEN '1'
         IF NOT cl_null(g_mrba_m.mrba032) THEN
            IF g_mrba_m.mrba032 > g_mrba_m.mrba034 THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = ""
               LET g_errparam.code   = 'amr-00048' 
               LET g_errparam.popup  = TRUE 
               CALL cl_err()
               LET r_success = FALSE
            END IF 
         END IF 
      WHEN '2'   
         IF NOT cl_null(g_mrba_m.mrba034) THEN   
            IF g_mrba_m.mrba033 > g_mrba_m.mrba034 THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = ""
               LET g_errparam.code   = 'amr-00117' 
               LET g_errparam.popup  = TRUE 
               CALL cl_err()
               LET r_success = FALSE
            END IF
         END IF  
   END CASE
   
   RETURN r_success
   
#160624-00006#1--add--end----
END FUNCTION

 
{</section>}
 
