#該程式未解開Section, 採用最新樣板產出!
{<section id="aimt300.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0038(2016-10-24 17:51:57), PR版次:0038(2017-02-20 11:04:34)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000783
#+ Filename...: aimt300
#+ Description: 料件申請維護作業
#+ Creator....: 02482(2013-07-18 16:10:46)
#+ Modifier...: 07804 -SD/PR- 01996
 
{</section>}
 
{<section id="aimt300.global" >}
#應用 t01 樣板自動產生(Version:79)
#add-point:填寫註解說明 name="global.memo" 
#141231-00009#1   2016/03/17   By lixiang  1.录入主分群码后，统计分类的资料带出不正确，品牌，价格等级的资料没有带出，系列带成了品牌的资料，其他栏位也有错位
#                                          2.统计分类页签没有显示资料对应说明
#                                          3.请拿掉超量容差，超重容差后的%
#                                          4.录入主分群码后，没有带出产品特征值页签资料
#160321-00016#32  2016/03/25   By Jessy    修正azzi920重複定義之錯誤訊息
#160318-00005#21  2016/03/30   by 07675    將重複內容的錯誤訊息置換為公用錯誤訊息
#160318-00025#29  2016/04/13   by 07959    將重複內容的錯誤訊息置換為公用錯誤訊息(r.v)
#160510-00028#1   2016/05/11   By lixiang  增加对开窗数组g_qryparam的初始化
#160511-00040#4   2016/05/24   By shiun    新增欄位預設
#160511-00040#5   2016/05/27   By shiun    新增欄位預設值
#160816-00042#1   2016/08/18   By xianghui s_azzi610_check检查时增加据点参数
#160817-00052#1   2016/08/22   By dorislai aimt300修改料件生命週期(imba010)存檔後,同步更新aimt301的據點生命週期(imbf016)
#160818-00017#15  2016/08/24   By 07900     删除修改未重新判断状态码
#160901-00023#1   2016/09/09   By Charles4m 將取單號邏輯改到AFTER INPUT，才不會有鎖單別問題
#161004-00020#1   2016/10/05   by catmoon 當基礎單位(imba006)變更時，需一併更新成本單位(imba146)
#161021-00028#1   2016/10/24   By Ann_Huang 調整規格料件編號(imba001)為必要欄位
#161024-00050#1   2016/10/24   By Ann_Huang 修正#161021-00028#1 調整規格料件編號(imba001)取消必要欄位,可透過事後整單操作中[補料號]進行料號輸入
#161124-00048#3   2016/12/08   By 08734     星号整批调整
#161222-00018#1   2016/12/22   By ywtsai    調整確認時因DDL指令造成transaction破壞問題
#160824-00007#266 2017/01/03   By 06137     修正舊值備份寫法
#170113-00035#1   2017/01/22   By lixiang   將 aimt300 裡 call s_aimt300_carry_chk 及 call s_aimt300_carry_upd 移到 s_aimt300 的 s_aimt300_conf_upd裡
#170123-00049#1   2017/01/24   By lixiang   寄送mail不能使用cl_jmail
#170213-00038#1   2017/02/15   By 08734     修改资料维护组织栏位和主要模具编号栏位开窗
#160711-00040#14  2017/02/20   By xujing   T類作業的單別開窗的where條件(找CALL q_ooba002_開頭的)增加如下程式段
#                                          CALL s_control_get_docno_sql(g_user,g_dept) RETURNING l_success,l_sql1
#end add-point
#add-point:填寫註解說明(客製用) name="global.memo_customerization"

#end add-point
 
IMPORT os
IMPORT util
IMPORT FGL lib_cl_dlg
#add-point:增加匯入項目 name="global.import"
IMPORT FGL aoo_aooi360_01
IMPORT FGL aim_aimt300_01
#end add-point 
 
SCHEMA ds 
 
GLOBALS "../../cfg/top_global.inc"
 
#add-point:增加匯入變數檔 name="global.inc"

#end add-point
 
#單頭 type 宣告
PRIVATE type type_g_imba_m        RECORD
       imbadocno LIKE imba_t.imbadocno, 
   oobxl003 LIKE type_t.chr80, 
   imbadocdt LIKE imba_t.imbadocdt, 
   imba000 LIKE imba_t.imba000, 
   imba900 LIKE imba_t.imba900, 
   imba900_desc LIKE type_t.chr80, 
   imba901 LIKE imba_t.imba901, 
   imba901_desc LIKE type_t.chr80, 
   imbastus LIKE imba_t.imbastus, 
   imba001 LIKE imba_t.imba001, 
   imba002 LIKE imba_t.imba002, 
   imbal002 LIKE imbal_t.imbal002, 
   imbal003 LIKE imbal_t.imbal003, 
   imbal004 LIKE imbal_t.imbal004, 
   imba009 LIKE imba_t.imba009, 
   imba009_desc LIKE type_t.chr80, 
   imba003 LIKE imba_t.imba003, 
   imba003_desc LIKE type_t.chr80, 
   imba004 LIKE imba_t.imba004, 
   imba005 LIKE imba_t.imba005, 
   imba005_desc LIKE type_t.chr80, 
   imba006 LIKE imba_t.imba006, 
   imba006_desc LIKE type_t.chr80, 
   imba010 LIKE imba_t.imba010, 
   imba010_desc LIKE type_t.chr80, 
   imba126 LIKE imba_t.imba126, 
   imba126_desc LIKE type_t.chr80, 
   imba127 LIKE imba_t.imba127, 
   imba127_desc LIKE type_t.chr80, 
   imba131 LIKE imba_t.imba131, 
   imba131_desc LIKE type_t.chr80, 
   imba128 LIKE imba_t.imba128, 
   imba128_desc LIKE type_t.chr80, 
   imba129 LIKE imba_t.imba129, 
   imba129_desc LIKE type_t.chr80, 
   imba130 LIKE imba_t.imba130, 
   imba132 LIKE imba_t.imba132, 
   imba132_desc LIKE type_t.chr80, 
   imba133 LIKE imba_t.imba133, 
   imba133_desc LIKE type_t.chr80, 
   imba134 LIKE imba_t.imba134, 
   imba134_desc LIKE type_t.chr80, 
   imba135 LIKE imba_t.imba135, 
   imba135_desc LIKE type_t.chr80, 
   imba136 LIKE imba_t.imba136, 
   imba136_desc LIKE type_t.chr80, 
   imba137 LIKE imba_t.imba137, 
   imba137_desc LIKE type_t.chr80, 
   imba138 LIKE imba_t.imba138, 
   imba138_desc LIKE type_t.chr80, 
   imba139 LIKE imba_t.imba139, 
   imba139_desc LIKE type_t.chr80, 
   imba140 LIKE imba_t.imba140, 
   imba140_desc LIKE type_t.chr80, 
   imba141 LIKE imba_t.imba141, 
   imba141_desc LIKE type_t.chr80, 
   imbaownid LIKE imba_t.imbaownid, 
   imbaownid_desc LIKE type_t.chr80, 
   imbaowndp LIKE imba_t.imbaowndp, 
   imbaowndp_desc LIKE type_t.chr80, 
   imbacrtid LIKE imba_t.imbacrtid, 
   imbacrtid_desc LIKE type_t.chr80, 
   imbacrtdp LIKE imba_t.imbacrtdp, 
   imbacrtdp_desc LIKE type_t.chr80, 
   imbacrtdt LIKE imba_t.imbacrtdt, 
   imbamodid LIKE imba_t.imbamodid, 
   imbamodid_desc LIKE type_t.chr80, 
   imbamoddt LIKE imba_t.imbamoddt, 
   imbacnfid LIKE imba_t.imbacnfid, 
   imbacnfid_desc LIKE type_t.chr80, 
   imbacnfdt LIKE imba_t.imbacnfdt, 
   imba011 LIKE imba_t.imba011, 
   imba012 LIKE imba_t.imba012, 
   imba013 LIKE imba_t.imba013, 
   imba014 LIKE imba_t.imba014, 
   imba142 LIKE imba_t.imba142, 
   imba142_desc LIKE type_t.chr80, 
   imba108 LIKE imba_t.imba108, 
   imba100 LIKE imba_t.imba100, 
   imba109 LIKE imba_t.imba109, 
   imba101 LIKE imba_t.imba101, 
   imba104 LIKE imba_t.imba104, 
   imba105 LIKE imba_t.imba105, 
   imba106 LIKE imba_t.imba106, 
   imba107 LIKE imba_t.imba107, 
   imba124 LIKE imba_t.imba124, 
   imba145 LIKE imba_t.imba145, 
   imba146 LIKE imba_t.imba146, 
   imba016 LIKE imba_t.imba016, 
   imba017 LIKE imba_t.imba017, 
   imba018 LIKE imba_t.imba018, 
   imba018_desc LIKE type_t.chr80, 
   imba019 LIKE imba_t.imba019, 
   imba020 LIKE imba_t.imba020, 
   imba021 LIKE imba_t.imba021, 
   imba022 LIKE imba_t.imba022, 
   imba022_desc LIKE type_t.chr80, 
   imba023 LIKE imba_t.imba023, 
   imba024 LIKE imba_t.imba024, 
   imba025 LIKE imba_t.imba025, 
   imba026 LIKE imba_t.imba026, 
   imba027 LIKE imba_t.imba027, 
   imba028 LIKE imba_t.imba028, 
   imba029 LIKE imba_t.imba029, 
   imba029_desc LIKE type_t.chr80, 
   imba030 LIKE imba_t.imba030, 
   imba031 LIKE imba_t.imba031, 
   imba032 LIKE imba_t.imba032, 
   imba032_desc LIKE type_t.chr80, 
   imba033 LIKE imba_t.imba033, 
   imba034 LIKE imba_t.imba034, 
   imba035 LIKE imba_t.imba035, 
   imba036 LIKE imba_t.imba036, 
   imba037 LIKE imba_t.imba037, 
   imba043 LIKE imba_t.imba043, 
   imba038 LIKE imba_t.imba038, 
   imba041 LIKE imba_t.imba041, 
   imba042 LIKE imba_t.imba042, 
   imba044 LIKE imba_t.imba044, 
   imba122 LIKE imba_t.imba122, 
   imba122_desc LIKE type_t.chr80, 
   imba045 LIKE imba_t.imba045, 
   imba045_desc LIKE type_t.chr80, 
   imba123 LIKE imba_t.imba123
       END RECORD
 
#單身 type 宣告
PRIVATE TYPE type_g_imbj_d        RECORD
       imbj002 LIKE imbj_t.imbj002, 
   imbj002_desc LIKE type_t.chr500, 
   imbj003 LIKE imbj_t.imbj003, 
   imbj003_desc LIKE type_t.chr500, 
   imbj004 LIKE imbj_t.imbj004, 
   imbj005 LIKE imbj_t.imbj005, 
   imbj005_desc LIKE type_t.chr500, 
   imbj006 LIKE imbj_t.imbj006, 
   imbj006_desc LIKE type_t.chr500
       END RECORD
PRIVATE TYPE type_g_imbj2_d RECORD
       imbl002 LIKE imbl_t.imbl002, 
   oocql004 LIKE type_t.chr500, 
   oocq005 LIKE type_t.chr500
       END RECORD
PRIVATE TYPE type_g_imbj3_d RECORD
       imbm002 LIKE imbm_t.imbm002, 
   imbm005 LIKE imbm_t.imbm005, 
   imbm003 LIKE imbm_t.imbm003, 
   imbm006 LIKE imbm_t.imbm006, 
   imbm004 LIKE imbm_t.imbm004
       END RECORD
PRIVATE TYPE type_g_imbj4_d RECORD
       imbo002 LIKE imbo_t.imbo002, 
   imbo002_desc LIKE type_t.chr500
       END RECORD
 
 
PRIVATE TYPE type_browser RECORD
         b_statepic     LIKE type_t.chr50,
            b_imba000 LIKE imba_t.imba000,
      b_imbadocno LIKE imba_t.imbadocno,
      b_imbadocdt LIKE imba_t.imbadocdt,
      b_imba001 LIKE imba_t.imba001,
   b_imbal002 LIKE imbal_t.imbal002,
   b_imbal003 LIKE imbal_t.imbal003,
      b_imba009 LIKE imba_t.imba009,
   b_imba009_desc LIKE type_t.chr80,
      b_imba003 LIKE imba_t.imba003,
   b_imba003_desc LIKE type_t.chr80,
      b_imba004 LIKE imba_t.imba004,
      b_imba005 LIKE imba_t.imba005,
   b_imba005_desc LIKE type_t.chr80,
      b_imba006 LIKE imba_t.imba006,
   b_imba006_desc LIKE type_t.chr80,
      b_imba010 LIKE imba_t.imba010,
   b_imba010_desc LIKE type_t.chr80
       END RECORD
       
#add-point:自定義模組變數(Module Variable) (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="global.variable"
DEFINE l_success         LIKE type_t.num5
DEFINE g_con             LIKE type_t.chr1
DEFINE g_imba003_o       LIKE imba_t.imba003
DEFINE g_imba009_o       LIKE imba_t.imba009
DEFINE l_sys             LIKE type_t.chr1

GLOBALS
   DEFINE g_detail_insert   LIKE type_t.num5   #單身的新增權限
   DEFINE g_detail_delete   LIKE type_t.num5   #單身的刪除權限
   DEFINE g_wc2_i36001      STRING             
   DEFINE g_d_idx_i36001    LIKE type_t.num5   
   DEFINE g_d_cnt_i36001    LIKE type_t.num5  
   DEFINE g_imbadocno_d     LIKE imba_t.imbadocno
   DEFINE g_imba001_d       LIKE imba_t.imba001
   DEFINE g_wc2_t30001      STRING              
   DEFINE g_d_idx_t30001    LIKE type_t.num5    
   DEFINE g_d_cnt_t30001    LIKE type_t.num5
   #備註類型:1.人員備註2.客商備註3.料號備註4.BOM單頭備註5.BO單身備註6.單據單頭備註
   #7.單據單身備註8.製程料號單頭備註9.製程料號單身備註
   DEFINE g_ooff001_d       LIKE ooff_t.ooff001
   DEFINE g_ooff002_d       LIKE ooff_t.ooff002   #第一Key值
   DEFINE g_ooff003_d       LIKE ooff_t.ooff003   #第二Key值
   DEFINE g_ooff004_d       LIKE ooff_t.ooff004   #第三Key值
   DEFINE g_ooff005_d       LIKE ooff_t.ooff005   #第四Key值
   DEFINE g_ooff006_d       LIKE ooff_t.ooff006   #第五Key值
   DEFINE g_ooff007_d       LIKE ooff_t.ooff007   #第六Key值
   DEFINE g_ooff008_d       LIKE ooff_t.ooff008   #第七Key值
   DEFINE g_ooff009_d       LIKE ooff_t.ooff009   #第八Key值
   DEFINE g_ooff010_d       LIKE ooff_t.ooff010   #第九Key值
   DEFINE g_ooff011_d       LIKE ooff_t.ooff011   #第十Key值   
   
 TYPE type_g_ooff_d        RECORD
       ooff001 LIKE ooff_t.ooff001, 
   ooff002 LIKE ooff_t.ooff002, 
   ooff004 LIKE ooff_t.ooff004, 
   ooff005 LIKE ooff_t.ooff005, 
   ooff006 LIKE ooff_t.ooff006, 
   ooff007 LIKE ooff_t.ooff007, 
   ooff008 LIKE ooff_t.ooff008, 
   ooff009 LIKE ooff_t.ooff009, 
   ooff010 LIKE ooff_t.ooff010, 
   ooff011 LIKE ooff_t.ooff011, 
   ooff003 LIKE ooff_t.ooff003, 
   ooff012 LIKE ooff_t.ooff012, 
   ooff013 LIKE ooff_t.ooff013, 
   ooff014 LIKE ooff_t.ooff014
       END RECORD
DEFINE g_ooff_d4          DYNAMIC ARRAY OF type_g_ooff_d

TYPE type_g_imbk_d        RECORD
       imbkdocno LIKE imbk_t.imbkdocno, 
   imbk002 LIKE imbk_t.imbk002, 
   imbk002_desc LIKE type_t.chr500, 
   imbk003 LIKE imbk_t.imbk003, 
   imbk003_desc LIKE type_t.chr500
       END RECORD
       
DEFINE g_imbk_d4          DYNAMIC ARRAY OF type_g_imbk_d
       

END GLOBALS
DEFINE g_detail_id          STRING             #紀錄停留在聯絡地址, 通訊方式或不在此兩個Page
DEFINE g_field              STRING             #當前光標停留的欄位
DEFINE ga_field             DYNAMIC ARRAY OF VARCHAR(500)   #2015/06/30 by stellar add
#end add-point
       
#模組變數(Module Variables)
DEFINE g_imba_m          type_g_imba_m
DEFINE g_imba_m_t        type_g_imba_m
DEFINE g_imba_m_o        type_g_imba_m
DEFINE g_imba_m_mask_o   type_g_imba_m #轉換遮罩前資料
DEFINE g_imba_m_mask_n   type_g_imba_m #轉換遮罩後資料
 
   DEFINE g_imbadocno_t LIKE imba_t.imbadocno
 
 
DEFINE g_imbj_d          DYNAMIC ARRAY OF type_g_imbj_d
DEFINE g_imbj_d_t        type_g_imbj_d
DEFINE g_imbj_d_o        type_g_imbj_d
DEFINE g_imbj_d_mask_o   DYNAMIC ARRAY OF type_g_imbj_d #轉換遮罩前資料
DEFINE g_imbj_d_mask_n   DYNAMIC ARRAY OF type_g_imbj_d #轉換遮罩後資料
DEFINE g_imbj2_d          DYNAMIC ARRAY OF type_g_imbj2_d
DEFINE g_imbj2_d_t        type_g_imbj2_d
DEFINE g_imbj2_d_o        type_g_imbj2_d
DEFINE g_imbj2_d_mask_o   DYNAMIC ARRAY OF type_g_imbj2_d #轉換遮罩前資料
DEFINE g_imbj2_d_mask_n   DYNAMIC ARRAY OF type_g_imbj2_d #轉換遮罩後資料
DEFINE g_imbj3_d          DYNAMIC ARRAY OF type_g_imbj3_d
DEFINE g_imbj3_d_t        type_g_imbj3_d
DEFINE g_imbj3_d_o        type_g_imbj3_d
DEFINE g_imbj3_d_mask_o   DYNAMIC ARRAY OF type_g_imbj3_d #轉換遮罩前資料
DEFINE g_imbj3_d_mask_n   DYNAMIC ARRAY OF type_g_imbj3_d #轉換遮罩後資料
DEFINE g_imbj4_d          DYNAMIC ARRAY OF type_g_imbj4_d
DEFINE g_imbj4_d_t        type_g_imbj4_d
DEFINE g_imbj4_d_o        type_g_imbj4_d
DEFINE g_imbj4_d_mask_o   DYNAMIC ARRAY OF type_g_imbj4_d #轉換遮罩前資料
DEFINE g_imbj4_d_mask_n   DYNAMIC ARRAY OF type_g_imbj4_d #轉換遮罩後資料
 
 
DEFINE g_browser         DYNAMIC ARRAY OF type_browser
DEFINE g_browser_f       DYNAMIC ARRAY OF type_browser
 
DEFINE g_master_multi_table_t    RECORD
      imbaldocno LIKE imbal_t.imbaldocno,
      imbal002 LIKE imbal_t.imbal002,
      imbal003 LIKE imbal_t.imbal003,
      imbal004 LIKE imbal_t.imbal004
      END RECORD
 
DEFINE g_wc                  STRING
DEFINE g_wc_t                STRING
DEFINE g_wc2                 STRING                          #單身CONSTRUCT結果
DEFINE g_wc2_table1          STRING
DEFINE g_wc2_table2   STRING
 
DEFINE g_wc2_table3   STRING
 
DEFINE g_wc2_table4   STRING
 
 
 
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
 
{<section id="aimt300.main" >}
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
   CALL cl_ap_init("aim","")
 
   #add-point:作業初始化 name="main.init"
   CALL s_auto_item_desc_cre_tmp_table() RETURNING l_success
   CALL s_auto_item_spec_cre_tmp_table() RETURNING l_success   #add--2015/08/19 By shiun
   CALL s_aooi390_cre_tmp_table() RETURNING l_success   #add--2015/03/19 By shiun
   #end add-point
   
   
 
   #LOCK CURSOR (identifier)
   #add-point:SQL_define name="main.define_sql"
      
   #end add-point
   LET g_forupd_sql = " SELECT imbadocno,'',imbadocdt,imba000,imba900,'',imba901,'',imbastus,imba001, 
       imba002,'','','',imba009,'',imba003,'',imba004,imba005,'',imba006,'',imba010,'',imba126,'',imba127, 
       '',imba131,'',imba128,'',imba129,'',imba130,imba132,'',imba133,'',imba134,'',imba135,'',imba136, 
       '',imba137,'',imba138,'',imba139,'',imba140,'',imba141,'',imbaownid,'',imbaowndp,'',imbacrtid, 
       '',imbacrtdp,'',imbacrtdt,imbamodid,'',imbamoddt,imbacnfid,'',imbacnfdt,imba011,imba012,imba013, 
       imba014,imba142,'',imba108,imba100,imba109,imba101,imba104,imba105,imba106,imba107,imba124,imba145, 
       imba146,imba016,imba017,imba018,'',imba019,imba020,imba021,imba022,'',imba023,imba024,imba025, 
       imba026,imba027,imba028,imba029,'',imba030,imba031,imba032,'',imba033,imba034,imba035,imba036, 
       imba037,imba043,imba038,imba041,imba042,imba044,imba122,'',imba045,'',imba123", 
                      " FROM imba_t",
                      " WHERE imbaent= ? AND imbadocno=? FOR UPDATE"
   #add-point:SQL_define name="main.after_define_sql"
      
   #end add-point
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)                #轉換不同資料庫語法
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE aimt300_cl CURSOR FROM g_forupd_sql                 # LOCK CURSOR
 
   LET g_sql = " SELECT DISTINCT t0.imbadocno,t0.imbadocdt,t0.imba000,t0.imba900,t0.imba901,t0.imbastus, 
       t0.imba001,t0.imba002,t0.imba009,t0.imba003,t0.imba004,t0.imba005,t0.imba006,t0.imba010,t0.imba126, 
       t0.imba127,t0.imba131,t0.imba128,t0.imba129,t0.imba130,t0.imba132,t0.imba133,t0.imba134,t0.imba135, 
       t0.imba136,t0.imba137,t0.imba138,t0.imba139,t0.imba140,t0.imba141,t0.imbaownid,t0.imbaowndp,t0.imbacrtid, 
       t0.imbacrtdp,t0.imbacrtdt,t0.imbamodid,t0.imbamoddt,t0.imbacnfid,t0.imbacnfdt,t0.imba011,t0.imba012, 
       t0.imba013,t0.imba014,t0.imba142,t0.imba108,t0.imba100,t0.imba109,t0.imba101,t0.imba104,t0.imba105, 
       t0.imba106,t0.imba107,t0.imba124,t0.imba145,t0.imba146,t0.imba016,t0.imba017,t0.imba018,t0.imba019, 
       t0.imba020,t0.imba021,t0.imba022,t0.imba023,t0.imba024,t0.imba025,t0.imba026,t0.imba027,t0.imba028, 
       t0.imba029,t0.imba030,t0.imba031,t0.imba032,t0.imba033,t0.imba034,t0.imba035,t0.imba036,t0.imba037, 
       t0.imba043,t0.imba038,t0.imba041,t0.imba042,t0.imba044,t0.imba122,t0.imba045,t0.imba123,t1.ooag011 , 
       t2.ooefl003 ,t3.rtaxl003 ,t4.oocql004 ,t5.imeal003 ,t6.oocal003 ,t7.oocql004 ,t8.oocql004 ,t9.oocql004 , 
       t10.oocql004 ,t11.oocql004 ,t12.oocql004 ,t13.oocql004 ,t14.oocql004 ,t15.oocql004 ,t16.oocql004 , 
       t17.oocql004 ,t18.oocql004 ,t19.oocql004 ,t20.oocql004 ,t21.oocql004 ,t22.oocql004 ,t23.ooag011 , 
       t24.ooefl003 ,t25.ooag011 ,t26.ooefl003 ,t27.ooag011 ,t28.ooag011 ,t29.ooefl003 ,t30.oocal003 , 
       t31.oocal003 ,t32.oocal003 ,t33.oocal003 ,t34.oocql004 ,t35.oocgl003",
               " FROM imba_t t0",
                              " LEFT JOIN ooag_t t1 ON t1.ooagent="||g_enterprise||" AND t1.ooag001=t0.imba900  ",
               " LEFT JOIN ooefl_t t2 ON t2.ooeflent="||g_enterprise||" AND t2.ooefl001=t0.imba901 AND t2.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN rtaxl_t t3 ON t3.rtaxlent="||g_enterprise||" AND t3.rtaxl001=t0.imba009 AND t3.rtaxl002='"||g_dlang||"' ",
               " LEFT JOIN oocql_t t4 ON t4.oocqlent="||g_enterprise||" AND t4.oocql001='200' AND t4.oocql002=t0.imba003 AND t4.oocql003='"||g_dlang||"' ",
               " LEFT JOIN imeal_t t5 ON t5.imealent="||g_enterprise||" AND t5.imeal001=t0.imba005 AND t5.imeal002='"||g_dlang||"' ",
               " LEFT JOIN oocal_t t6 ON t6.oocalent="||g_enterprise||" AND t6.oocal001=t0.imba006 AND t6.oocal002='"||g_dlang||"' ",
               " LEFT JOIN oocql_t t7 ON t7.oocqlent="||g_enterprise||" AND t7.oocql001='210' AND t7.oocql002=t0.imba010 AND t7.oocql003='"||g_dlang||"' ",
               " LEFT JOIN oocql_t t8 ON t8.oocqlent="||g_enterprise||" AND t8.oocql001='2002' AND t8.oocql002=t0.imba126 AND t8.oocql003='"||g_dlang||"' ",
               " LEFT JOIN oocql_t t9 ON t9.oocqlent="||g_enterprise||" AND t9.oocql001='2003' AND t9.oocql002=t0.imba127 AND t9.oocql003='"||g_dlang||"' ",
               " LEFT JOIN oocql_t t10 ON t10.oocqlent="||g_enterprise||" AND t10.oocql001='2001' AND t10.oocql002=t0.imba131 AND t10.oocql003='"||g_dlang||"' ",
               " LEFT JOIN oocql_t t11 ON t11.oocqlent="||g_enterprise||" AND t11.oocql001='2004' AND t11.oocql002=t0.imba128 AND t11.oocql003='"||g_dlang||"' ",
               " LEFT JOIN oocql_t t12 ON t12.oocqlent="||g_enterprise||" AND t12.oocql001='2005' AND t12.oocql002=t0.imba129 AND t12.oocql003='"||g_dlang||"' ",
               " LEFT JOIN oocql_t t13 ON t13.oocqlent="||g_enterprise||" AND t13.oocql001='2006' AND t13.oocql002=t0.imba132 AND t13.oocql003='"||g_dlang||"' ",
               " LEFT JOIN oocql_t t14 ON t14.oocqlent="||g_enterprise||" AND t14.oocql001='2007' AND t14.oocql002=t0.imba133 AND t14.oocql003='"||g_dlang||"' ",
               " LEFT JOIN oocql_t t15 ON t15.oocqlent="||g_enterprise||" AND t15.oocql001='2008' AND t15.oocql002=t0.imba134 AND t15.oocql003='"||g_dlang||"' ",
               " LEFT JOIN oocql_t t16 ON t16.oocqlent="||g_enterprise||" AND t16.oocql001='2009' AND t16.oocql002=t0.imba135 AND t16.oocql003='"||g_dlang||"' ",
               " LEFT JOIN oocql_t t17 ON t17.oocqlent="||g_enterprise||" AND t17.oocql001='2010' AND t17.oocql002=t0.imba136 AND t17.oocql003='"||g_dlang||"' ",
               " LEFT JOIN oocql_t t18 ON t18.oocqlent="||g_enterprise||" AND t18.oocql001='2011' AND t18.oocql002=t0.imba137 AND t18.oocql003='"||g_dlang||"' ",
               " LEFT JOIN oocql_t t19 ON t19.oocqlent="||g_enterprise||" AND t19.oocql001='2012' AND t19.oocql002=t0.imba138 AND t19.oocql003='"||g_dlang||"' ",
               " LEFT JOIN oocql_t t20 ON t20.oocqlent="||g_enterprise||" AND t20.oocql001='2013' AND t20.oocql002=t0.imba139 AND t20.oocql003='"||g_dlang||"' ",
               " LEFT JOIN oocql_t t21 ON t21.oocqlent="||g_enterprise||" AND t21.oocql001='2014' AND t21.oocql002=t0.imba140 AND t21.oocql003='"||g_dlang||"' ",
               " LEFT JOIN oocql_t t22 ON t22.oocqlent="||g_enterprise||" AND t22.oocql001='2015' AND t22.oocql002=t0.imba141 AND t22.oocql003='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t23 ON t23.ooagent="||g_enterprise||" AND t23.ooag001=t0.imbaownid  ",
               " LEFT JOIN ooefl_t t24 ON t24.ooeflent="||g_enterprise||" AND t24.ooefl001=t0.imbaowndp AND t24.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t25 ON t25.ooagent="||g_enterprise||" AND t25.ooag001=t0.imbacrtid  ",
               " LEFT JOIN ooefl_t t26 ON t26.ooeflent="||g_enterprise||" AND t26.ooefl001=t0.imbacrtdp AND t26.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t27 ON t27.ooagent="||g_enterprise||" AND t27.ooag001=t0.imbamodid  ",
               " LEFT JOIN ooag_t t28 ON t28.ooagent="||g_enterprise||" AND t28.ooag001=t0.imbacnfid  ",
               " LEFT JOIN ooefl_t t29 ON t29.ooeflent="||g_enterprise||" AND t29.ooefl001=t0.imba142 AND t29.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN oocal_t t30 ON t30.oocalent="||g_enterprise||" AND t30.oocal001=t0.imba018 AND t30.oocal002='"||g_dlang||"' ",
               " LEFT JOIN oocal_t t31 ON t31.oocalent="||g_enterprise||" AND t31.oocal001=t0.imba022 AND t31.oocal002='"||g_dlang||"' ",
               " LEFT JOIN oocal_t t32 ON t32.oocalent="||g_enterprise||" AND t32.oocal001=t0.imba029 AND t32.oocal002='"||g_dlang||"' ",
               " LEFT JOIN oocal_t t33 ON t33.oocalent="||g_enterprise||" AND t33.oocal001=t0.imba032 AND t33.oocal002='"||g_dlang||"' ",
               " LEFT JOIN oocql_t t34 ON t34.oocqlent="||g_enterprise||" AND t34.oocql001='2000' AND t34.oocql002=t0.imba122 AND t34.oocql003='"||g_dlang||"' ",
               " LEFT JOIN oocgl_t t35 ON t35.oocglent="||g_enterprise||" AND t35.oocgl001=t0.imba045 AND t35.oocgl002='"||g_dlang||"' ",
 
               " WHERE t0.imbaent = " ||g_enterprise|| " AND t0.imbadocno = ?"
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   #add-point:SQL_define name="main.after_refresh_sql"
   
   #end add-point
   PREPARE aimt300_master_referesh FROM g_sql
 
    
 
   
   IF g_bgjob = "Y" THEN
      #add-point:Service Call name="main.servicecall"
            
      #end add-point
   ELSE
      #畫面開啟 (identifier)
      OPEN WINDOW w_aimt300 WITH FORM cl_ap_formpath("aim",g_code)
   
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
   
      #程式初始化
      CALL aimt300_init()   
 
      #進入選單 Menu (="N")
      CALL aimt300_ui_dialog() 
      
      #add-point:畫面關閉前 name="main.before_close"
            
      #end add-point
 
      #畫面關閉
      CLOSE WINDOW w_aimt300
      
   END IF 
   
   CLOSE aimt300_cl
   
   
 
   #add-point:作業離開前 name="main.exit"
   CALL s_auto_item_desc_drop_tmp_table()
   CALL s_auto_item_spec_drop_tmp_table()
   CALL s_aooi390_drop_tmp_table()   #add--2015/03/19 By shiun
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
END MAIN
 
 
 
 
{</section>}
 
{<section id="aimt300.init" >}
#+ 瀏覽頁簽資料初始化
PRIVATE FUNCTION aimt300_init()
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
 
   LET g_error_show  = 1
   LET l_ac = 1 #單身指標
      CALL cl_set_combo_scc_part('imbastus','13','N,W,A,Y,D,R,X')
 
      CALL cl_set_combo_scc('imba000','32') 
   CALL cl_set_combo_scc('imba004','1001') 
   CALL cl_set_combo_scc('imba011','1002') 
   CALL cl_set_combo_scc('imba108','2002') 
   CALL cl_set_combo_scc('imba100','2003') 
   CALL cl_set_combo_scc('imba109','2004') 
   CALL cl_set_combo_scc('imba034','1003') 
   CALL cl_set_combo_scc('imba044','1004') 
   CALL cl_set_combo_scc('imbm002','1006') 
 
   LET gwin_curr = ui.Window.getCurrent()  #取得現行畫面
   LET gfrm_curr = gwin_curr.getForm()     #取出物件化後的畫面物件
   
   #page群組
   LET g_idx_group = om.SaxAttributes.create()
   CALL g_idx_group.addAttribute("'1',","1")
   CALL g_idx_group.addAttribute("'2',","1")
   CALL g_idx_group.addAttribute("'3',","1")
   CALL g_idx_group.addAttribute("'4',","1")
 
 
   #add-point:畫面資料初始化 name="init.init"
         CALL cl_set_combo_scc("imba000",32)
   CALL cl_set_combo_scc("imba004",1001)
   CALL cl_set_combo_scc("imba011",1002)
   CALL cl_set_combo_scc("imba034",1003)
   CALL cl_set_combo_scc("imba044",1004)
   CALL cl_set_combo_scc("imbm002",1006)
   CALL cl_set_combo_scc('b_imba000','32') 
   CALL cl_set_combo_scc('b_imba004','1001') 
   CALL cl_set_combo_scc_part('imba109','6553','1,4,5')   #add--160511-00040#4 By shiun
   LET g_con = 'N'
   CALL aimt300_crt_tmp()
   
   #子程式畫面取代主程式元件
   CALL cl_ui_replace_sub_window(cl_ap_formpath("aoo", "aooi360_01"), "grid_remark", "Table", "s_detail1_aooi360_01")
   CALL cl_set_combo_scc('ooff012','11')
   CALL cl_set_comp_visible("ooff003",FALSE)
  
   CALL cl_ui_replace_sub_window(cl_ap_formpath("aim", "aimt300_01"), "grid_feature", "Table", "s_detail1_aimt300_01")
   
   #end add-point
   
   #初始化搜尋條件
   CALL aimt300_default_search()
    
END FUNCTION
 
{</section>}
 
{<section id="aimt300.ui_dialog" >}
#+ 功能選單
PRIVATE FUNCTION aimt300_ui_dialog()
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
            CALL aimt300_insert()
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
         INITIALIZE g_imba_m.* TO NULL
         CALL g_imbj_d.clear()
         CALL g_imbj2_d.clear()
         CALL g_imbj3_d.clear()
         CALL g_imbj4_d.clear()
 
         LET g_wc  = ' 1=2'
         LET g_wc2 = ' 1=1'
         LET g_action_choice = ""
         CALL aimt300_init()
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
               
               CALL aimt300_fetch('') # reload data
               LET l_ac = 1
               CALL aimt300_ui_detailshow() #Setting the current row 
         
               CALL aimt300_idx_chk()
               #NEXT FIELD imbj002
         
               ON ACTION qbefield_user   #欄位隱藏設定 
                  LET g_action_choice="qbefield_user"
                  CALL cl_ui_qbefield_user()
         END DISPLAY
    
         DISPLAY ARRAY g_imbj_d TO s_detail1.* ATTRIBUTES(COUNT=g_rec_b) #page1  
    
            BEFORE ROW
               #顯示單身筆數
               CALL aimt300_idx_chk()
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
               CALL aimt300_idx_chk()
               #add-point:page1自定義行為 name="ui_dialog.page1.before_display"
                              
               #end add-point
               
            #自訂ACTION(detail_show,page_1)
            
               
            #add-point:page1自定義行為 name="ui_dialog.page1.action"
                        
            #end add-point
               
         END DISPLAY
        
         #第一階單身段落
         DISPLAY ARRAY g_imbj2_d TO s_detail2.* ATTRIBUTES(COUNT=g_rec_b)  
    
            BEFORE ROW
               #顯示單身筆數
               CALL aimt300_idx_chk()
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
               CALL aimt300_idx_chk()
               #add-point:page2自定義行為 name="ui_dialog.body2.before_display"
                              
               #end add-point
      
            #自訂ACTION(detail_show,page_2)
            
         
            #add-point:page2自定義行為 name="ui_dialog.body2.action"
                        
            #end add-point
         
         END DISPLAY
         #第一階單身段落
         DISPLAY ARRAY g_imbj3_d TO s_detail3.* ATTRIBUTES(COUNT=g_rec_b)  
    
            BEFORE ROW
               #顯示單身筆數
               CALL aimt300_idx_chk()
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
               CALL aimt300_idx_chk()
               #add-point:page3自定義行為 name="ui_dialog.body3.before_display"
                              
               #end add-point
      
            #自訂ACTION(detail_show,page_3)
            
         
            #add-point:page3自定義行為 name="ui_dialog.body3.action"
                        
            #end add-point
         
         END DISPLAY
         #第一階單身段落
         DISPLAY ARRAY g_imbj4_d TO s_detail4.* ATTRIBUTES(COUNT=g_rec_b)  
    
            BEFORE ROW
               #顯示單身筆數
               CALL aimt300_idx_chk()
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
               CALL aimt300_idx_chk()
               #add-point:page4自定義行為 name="ui_dialog.body4.before_display"
                              
               #end add-point
      
            #自訂ACTION(detail_show,page_4)
            
         
            #add-point:page4自定義行為 name="ui_dialog.body4.action"
                        
            #end add-point
         
         END DISPLAY
 
         
 
         
         #add-point:ui_dialog段自定義display array name="ui_dialog.more_displayarray"
         #嵌入單身顯示
         SUBDIALOG aoo_aooi360_01.aooi360_01_display 
         SUBDIALOG aim_aimt300_01.aimt300_01_display
         #end add-point
         
         SUBDIALOG lib_cl_dlg.cl_dlg_qryplan
         SUBDIALOG lib_cl_dlg.cl_dlg_relateapps
      
         BEFORE DIALOG
            #先填充browser資料
            CALL aimt300_browser_fill("")
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
               CALL aimt300_fetch('') # reload data
            END IF
            #LET g_detail_idx = 1
            CALL aimt300_ui_detailshow() #Setting the current row 
            
            #筆數顯示
            LET g_current_page = 1
            CALL aimt300_idx_chk()
            CALL cl_ap_performance_cal()
            #add-point:ui_dialog段before_dialog2 name="ui_dialog.before_dialog2"
                        
            #end add-point
 
         #add-point:ui_dialog段more_action name="ui_dialog.more_action"
         
         #end add-point
 
         #狀態碼切換
         ON ACTION statechange
            LET g_action_choice = "statechange"
            CALL aimt300_statechange()
            #根據資料狀態切換action狀態
            CALL cl_set_act_visible("statechange,modify,modify_detail,delete,reproduce", TRUE)
            CALL aimt300_set_act_visible()   
            CALL aimt300_set_act_no_visible()
            IF NOT (g_imba_m.imbadocno IS NULL
 
              ) THEN
               #組合條件
               LET g_add_browse = " imbaent = " ||g_enterprise|| " AND",
                                  " imbadocno = '", g_imba_m.imbadocno, "' "
 
               #填到對應位置
               CALL aimt300_browser_fill("")
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
 
               INITIALIZE g_wc2_table4 TO NULL
 
 
               FOR li_idx = 1 TO la_wc.getLength()
                  CASE
                     WHEN la_wc[li_idx].tableid = "imba_t" 
                        LET g_wc = la_wc[li_idx].wc
                     WHEN la_wc[li_idx].tableid = "imbj_t" 
                        LET g_wc2_table1 = la_wc[li_idx].wc
                     WHEN la_wc[li_idx].tableid = "imbl_t" 
                        LET g_wc2_table2 = la_wc[li_idx].wc
 
                     WHEN la_wc[li_idx].tableid = "imbm_t" 
                        LET g_wc2_table3 = la_wc[li_idx].wc
 
                     WHEN la_wc[li_idx].tableid = "imbo_t" 
                        LET g_wc2_table4 = la_wc[li_idx].wc
 
 
                     WHEN la_wc[li_idx].tableid = "EXTENDWC"
                        LET g_wc2_extend = la_wc[li_idx].wc
                  END CASE
               END FOR
               IF NOT cl_null(g_wc) OR NOT cl_null(g_wc2_table1) 
                  OR NOT cl_null(g_wc2_table2)
 
                  OR NOT cl_null(g_wc2_table3)
 
                  OR NOT cl_null(g_wc2_table4)
 
 
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
 
 
                  IF g_wc2_extend <> " 1=1" AND NOT cl_null(g_wc2_extend) THEN
                     LET g_wc2 = g_wc2 ," AND ", g_wc2_extend
                  END IF
 
                  IF g_wc2.subString(1,5) = " AND " THEN
                     LET g_wc2 = g_wc2.subString(6,g_wc2.getLength())
                  END IF
               END IF
               CALL aimt300_browser_fill("F")   #browser_fill()會將notice區塊清空
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
 
 
               FOR li_idx = 1 TO la_wc.getLength()
                  CASE
                     WHEN la_wc[li_idx].tableid = "imba_t" 
                        LET g_wc = la_wc[li_idx].wc
                     WHEN la_wc[li_idx].tableid = "imbj_t" 
                        LET g_wc2_table1 = la_wc[li_idx].wc
                     WHEN la_wc[li_idx].tableid = "imbl_t" 
                        LET g_wc2_table2 = la_wc[li_idx].wc
 
                     WHEN la_wc[li_idx].tableid = "imbm_t" 
                        LET g_wc2_table3 = la_wc[li_idx].wc
 
                     WHEN la_wc[li_idx].tableid = "imbo_t" 
                        LET g_wc2_table4 = la_wc[li_idx].wc
 
 
                     WHEN la_wc[li_idx].tableid = "EXTENDWC"
                        LET g_wc2_extend = la_wc[li_idx].wc
                  END CASE
               END FOR
               IF NOT cl_null(g_wc) OR NOT cl_null(g_wc2_table1)
                  OR NOT cl_null(g_wc2_table2)
 
                  OR NOT cl_null(g_wc2_table3)
 
                  OR NOT cl_null(g_wc2_table4)
 
 
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
 
 
                  IF g_wc2_extend <> " 1=1" AND NOT cl_null(g_wc2_extend) THEN
                     LET g_wc2 = g_wc2 ," AND ", g_wc2_extend
                  END IF
                  IF g_wc2.subString(1,5) = " AND " THEN
                     LET g_wc2 = g_wc2.subString(6,g_wc2.getLength())
                  END IF
                  #取得條件後需要重查、跳到結果第一筆資料的功能程式段
                  CALL aimt300_browser_fill("F")
                  IF g_browser_cnt = 0 THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "" 
                     LET g_errparam.code = "-100" 
                     LET g_errparam.popup = TRUE 
                     CALL cl_err()
                     CLEAR FORM
                  ELSE
                     CALL aimt300_fetch("F")
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
               CALL aimt300_filter()
               EXIT DIALOG
 
 
 
         
         ON ACTION first
            LET g_action_choice = "fetch"
            CALL aimt300_fetch('F')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL aimt300_idx_chk()
            
         ON ACTION previous
            LET g_action_choice = "fetch"
            CALL aimt300_fetch('P')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL aimt300_idx_chk()
            
         ON ACTION jump
            LET g_action_choice = "fetch"
            CALL aimt300_fetch('/')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL aimt300_idx_chk()
            
         ON ACTION next
            LET g_action_choice = "fetch"
            CALL aimt300_fetch('N')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL aimt300_idx_chk()
            
         ON ACTION last
            LET g_action_choice = "fetch"
            CALL aimt300_fetch('L')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL aimt300_idx_chk()
          
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
                  LET g_export_node[1] = base.typeInfo.create(g_imbj_d)
                  LET g_export_id[1]   = "s_detail1"
                  LET g_export_node[2] = base.typeInfo.create(g_imbj2_d)
                  LET g_export_id[2]   = "s_detail2"
                  LET g_export_node[3] = base.typeInfo.create(g_imbj3_d)
                  LET g_export_id[3]   = "s_detail3"
                  LET g_export_node[4] = base.typeInfo.create(g_imbj4_d)
                  LET g_export_id[4]   = "s_detail4"
 
                  #add-point:ON ACTION exporttoexcel name="menu.exporttoexcel"
                  ------2015.1.9 zj mod----------
                  LET g_export_node[5] = base.typeInfo.create(g_ooff_d4)
                  LET g_export_id[5]   = "s_detail1_aooi360_01"
                  LET g_export_node[6] = base.typeInfo.create(g_imbk_d4)
                  LET g_export_id[6]   = "s_detail1_aimt300_01"
                  ------2015.1.9 zj mod----------

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
               NEXT FIELD imbj002
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
               CALL aimt300_modify()
               #add-point:ON ACTION modify name="menu.modify"
               CALL gfrm_curr.ensureFieldVisible("g_field")               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION modify_detail
            LET g_action_choice="modify_detail"
            IF cl_auth_chk_act("modify") THEN
               LET g_aw = g_curr_diag.getCurrentItem()
               CALL aimt300_modify()
               #add-point:ON ACTION modify_detail name="menu.modify_detail"
               CALL gfrm_curr.ensureFieldVisible("imba_t.imba011")               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION open_aimt306
            LET g_action_choice="open_aimt306"
            IF cl_auth_chk_act("open_aimt306") THEN
               
               #add-point:ON ACTION open_aimt306 name="menu.open_aimt306"
               IF NOT cl_null(g_imba_m.imbadocno) THEN
                  LET la_param.prog = 'aimt306'
                  LET la_param.param[1] = g_imba_m.imbadocno
                  LET ls_js = util.JSON.stringify( la_param )
                  CALL cl_cmdrun(ls_js)
                END IF
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION open_aimt307
            LET g_action_choice="open_aimt307"
            IF cl_auth_chk_act("open_aimt307") THEN
               
               #add-point:ON ACTION open_aimt307 name="menu.open_aimt307"
               IF NOT cl_null(g_imba_m.imbadocno) THEN
                  LET la_param.prog = 'aimt307'
                  LET la_param.param[1] = g_imba_m.imbadocno
                  LET ls_js = util.JSON.stringify( la_param )
                  CALL cl_cmdrun(ls_js)
                END IF
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION open_aimt308
            LET g_action_choice="open_aimt308"
            IF cl_auth_chk_act("open_aimt308") THEN
               
               #add-point:ON ACTION open_aimt308 name="menu.open_aimt308"
               IF NOT cl_null(g_imba_m.imbadocno) THEN
                  LET la_param.prog = 'aimt308'
                  LET la_param.param[1] = g_imba_m.imbadocno
                  LET ls_js = util.JSON.stringify( la_param )
                  CALL cl_cmdrun(ls_js)
               END IF
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION delete
            LET g_action_choice="delete"
            IF cl_auth_chk_act("delete") THEN
               CALL aimt300_delete()
               #add-point:ON ACTION delete name="menu.delete"
               CALL gfrm_curr.ensureFieldVisible("imba_t.imba011")                
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION insert
            LET g_action_choice="insert"
            IF cl_auth_chk_act("insert") THEN
               CALL aimt300_insert()
               #add-point:ON ACTION insert name="menu.insert"
               CALL gfrm_curr.ensureFieldVisible("imba_t.imba011")                 
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION open_aimt310
            LET g_action_choice="open_aimt310"
            IF cl_auth_chk_act("open_aimt310") THEN
               
               #add-point:ON ACTION open_aimt310 name="menu.open_aimt310"
               IF NOT cl_null(g_imba_m.imbadocno) THEN
                  LET la_param.prog = 'aimt310'
                  LET la_param.param[1] = g_imba_m.imbadocno
                  LET ls_js = util.JSON.stringify( la_param )
                  CALL cl_cmdrun(ls_js)
               END IF
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION open_s_carry_query
            LET g_action_choice="open_s_carry_query"
            IF cl_auth_chk_act("open_s_carry_query") THEN
               
               #add-point:ON ACTION open_s_carry_query name="menu.open_s_carry_query"
               #2015/06/30 by stellar add ----- (S)
               IF g_imba_m.imba000 = 'U' AND NOT cl_null(g_imba_m.imba001) THEN
                  LET ga_field[1] = g_imba_m.imba001
                  CALL s_carry_query('1',ga_field)
               END IF
               #2015/06/30 by stellar add ----- (E)
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION open_aimt303
            LET g_action_choice="open_aimt303"
            IF cl_auth_chk_act("open_aimt303") THEN
               
               #add-point:ON ACTION open_aimt303 name="menu.open_aimt303"
               IF NOT cl_null(g_imba_m.imbadocno) THEN
                  LET la_param.prog = 'aimt303'
                  LET la_param.param[1] = g_imba_m.imbadocno
                  LET ls_js = util.JSON.stringify( la_param )
                  CALL cl_cmdrun(ls_js)
                END IF
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION output
            LET g_action_choice="output"
            IF cl_auth_chk_act("output") THEN
               
               #add-point:ON ACTION output name="menu.output"
                              
               #END add-point
               &include "erp/aim/aimt300_rep.4gl"
               #add-point:ON ACTION output.after name="menu.after_output"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION quickprint
            LET g_action_choice="quickprint"
            IF cl_auth_chk_act("quickprint") THEN
               
               #add-point:ON ACTION quickprint name="menu.quickprint"
                              
               #END add-point
               &include "erp/aim/aimt300_rep.4gl"
               #add-point:ON ACTION quickprint.after name="menu.after_quickprint"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION reproduce
            LET g_action_choice="reproduce"
            IF cl_auth_chk_act("reproduce") THEN
               CALL aimt300_reproduce()
               #add-point:ON ACTION reproduce name="menu.reproduce"
                              
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION fillprd
            LET g_action_choice="fillprd"
            IF cl_auth_chk_act("fillprd") THEN
               
               #add-point:ON ACTION fillprd name="menu.fillprd"
               IF NOT (g_imba_m.imbastus = 'Y' OR g_imba_m.imbastus = 'X') THEN
                  CALL cl_set_comp_entry("imba001",TRUE)
                  CALL aimt300_fillprd()
               END IF
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION open_aimt301
            LET g_action_choice="open_aimt301"
            IF cl_auth_chk_act("open_aimt301") THEN
               
               #add-point:ON ACTION open_aimt301 name="menu.open_aimt301"
               IF NOT cl_null(g_imba_m.imbadocno) THEN
                  LET la_param.prog = 'aimt301'
                  LET la_param.param[1] = g_imba_m.imbadocno
                  LET ls_js = util.JSON.stringify( la_param )
                  CALL cl_cmdrun(ls_js)
                END IF
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION query
            LET g_action_choice="query"
            IF cl_auth_chk_act("query") THEN
               CALL aimt300_query()
               #add-point:ON ACTION query name="menu.query"
               CALL gfrm_curr.ensureFieldVisible("imba_t.imba011")                
               #END add-point
               #應用 a59 樣板自動產生(Version:3)  
               CALL g_curr_diag.setCurrentRow("s_detail1",1)
               CALL g_curr_diag.setCurrentRow("s_detail2",1)
               CALL g_curr_diag.setCurrentRow("s_detail3",1)
               CALL g_curr_diag.setCurrentRow("s_detail4",1)
 
 
 
 
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION image_next
            LET g_action_choice="image_next"
               
               #add-point:ON ACTION image_next name="menu.image_next"
               DISPLAY cl_doc_set_pic_seq(TRUE) TO ffimage
               #END add-point
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION open_aimt302
            LET g_action_choice="open_aimt302"
            IF cl_auth_chk_act("open_aimt302") THEN
               
               #add-point:ON ACTION open_aimt302 name="menu.open_aimt302"
               IF NOT cl_null(g_imba_m.imbadocno) THEN
                  LET la_param.prog = 'aimt302'
                  LET la_param.param[1] = g_imba_m.imbadocno
                  LET ls_js = util.JSON.stringify( la_param )
                  CALL cl_cmdrun(ls_js)
                END IF
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION open_aimt304
            LET g_action_choice="open_aimt304"
            IF cl_auth_chk_act("open_aimt304") THEN
               
               #add-point:ON ACTION open_aimt304 name="menu.open_aimt304"
               IF NOT cl_null(g_imba_m.imbadocno) THEN
                  LET la_param.prog = 'aimt304'
                  LET la_param.param[1] = g_imba_m.imbadocno
                  LET ls_js = util.JSON.stringify( la_param )
                  CALL cl_cmdrun(ls_js)
                END IF
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION chptz
            LET g_action_choice="chptz"
            IF cl_auth_chk_act("chptz") THEN
               
               #add-point:ON ACTION chptz name="menu.chptz"
               IF NOT cl_null(g_imba_m.imbadocno) AND NOT cl_null(g_imba_m.imba001) AND NOT cl_null(g_imba_m.imba005) THEN
                  CALL aimt300_01(g_imba_m.imbadocno,g_imba_m.imba001,g_imba_m.imba005)
               END IF
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION image_previous
            LET g_action_choice="image_previous"
               
               #add-point:ON ACTION image_previous name="menu.image_previous"
               DISPLAY cl_doc_set_pic_seq(FALSE) TO ffimage
               #END add-point
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION ljbzh
            LET g_action_choice="ljbzh"
            IF cl_auth_chk_act("ljbzh") THEN
               
               #add-point:ON ACTION ljbzh name="menu.ljbzh"
               IF NOT cl_null(g_imba_m.imbadocno) THEN
                  CALL aooi360_01('6',g_imba_m.imbadocno,'','','','','','','','','')
               END IF
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION open_aimt305
            LET g_action_choice="open_aimt305"
            IF cl_auth_chk_act("open_aimt305") THEN
               
               #add-point:ON ACTION open_aimt305 name="menu.open_aimt305"
               IF NOT cl_null(g_imba_m.imbadocno) THEN
                  LET la_param.prog = 'aimt305'
                  LET la_param.param[1] = g_imba_m.imbadocno
                  LET ls_js = util.JSON.stringify( la_param )
                  CALL cl_cmdrun(ls_js)
                END IF
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION prog_imba009
            LET g_action_choice="prog_imba009"
            IF cl_auth_chk_act("prog_imba009") THEN
               
               #add-point:ON ACTION prog_imba009 name="menu.prog_imba009"
               INITIALIZE la_param.* TO NULL
               LET la_param.prog     = "aimi010"
               LET la_param.param[1] = g_imba_m.imba009
               
               LET ls_js = util.JSON.stringify(la_param)
               CALL cl_cmdrun(ls_js)               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION prog_imba003
            LET g_action_choice="prog_imba003"
            IF cl_auth_chk_act("prog_imba003") THEN
               
               #add-point:ON ACTION prog_imba003 name="menu.prog_imba003"
               INITIALIZE la_param.* TO NULL
               LET la_param.prog     = "aimi100"
               LET la_param.param[1] = g_imba_m.imba003
               
               LET ls_js = util.JSON.stringify(la_param)
               CALL cl_cmdrun(ls_js)                    
               #END add-point
               
            END IF
 
 
 
 
         
         #應用 a46 樣板自動產生(Version:3)
         #新增相關文件
         ON ACTION related_document
            CALL aimt300_set_pk_array()
            IF cl_auth_chk_act("related_document") THEN
               #add-point:ON ACTION related_document name="ui_dialog.dialog.related_document"
               
               #END add-point
               CALL cl_doc()
            END IF
            
         ON ACTION agendum
            CALL aimt300_set_pk_array()
            #add-point:ON ACTION agendum name="ui_dialog.dialog.agendum"
            
            #END add-point
            CALL cl_user_overview()
            CALL cl_user_overview_set_follow_pic()
         
         ON ACTION followup
            CALL aimt300_set_pk_array()
            #add-point:ON ACTION followup name="ui_dialog.dialog.followup"
            
            #END add-point
            CALL cl_user_overview_follow(g_imba_m.imbadocdt)
 
 
 
         
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
 
{<section id="aimt300.browser_fill" >}
#+ 瀏覽頁簽資料填充
PRIVATE FUNCTION aimt300_browser_fill(ps_page_action)
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
    #根據行為確定資料填充位置及WC
   IF cl_null(g_add_browse) THEN
      CALL aooi360_01_clear_detail()   
      CALL aimt300_01_clear_detail()   
   END IF
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
      LET l_sub_sql = " SELECT DISTINCT imbadocno ",
                      " FROM imba_t ",
                      " ",
                      " LEFT JOIN imbj_t ON imbjent = imbaent AND imbadocno = imbjdocno ", "  ",
                      #add-point:browser_fill段sql(imbj_t1) name="browser_fill.cnt.join.}"
                      
                      #end add-point
                      " LEFT JOIN imbl_t ON imblent = imbaent AND imbadocno = imbldocno", "  ",
                      #add-point:browser_fill段sql(imbl_t1) name="browser_fill.cnt.join.imbl_t1"
                      
                      #end add-point
 
                      " LEFT JOIN imbm_t ON imbment = imbaent AND imbadocno = imbmdocno", "  ",
                      #add-point:browser_fill段sql(imbm_t1) name="browser_fill.cnt.join.imbm_t1"
                      
                      #end add-point
 
                      " LEFT JOIN imbo_t ON imboent = imbaent AND imbadocno = imbodocno", "  ",
                      #add-point:browser_fill段sql(imbo_t1) name="browser_fill.cnt.join.imbo_t1"
                      
                      #end add-point
 
 
 
                      " LEFT JOIN imbal_t ON imbalent = "||g_enterprise||" AND imbadocno = imbaldocno AND imbal001 = '",g_dlang,"' ", 
                      " ", 
                      " ",                      
 
                      " ",                      
 
                      " ",                      
 
 
 
                      " WHERE imbaent = " ||g_enterprise|| " AND imbjent = " ||g_enterprise|| " AND ",l_wc, " AND ", l_wc2, cl_sql_add_filter("imba_t")
   ELSE
      #單身未輸入搜尋條件
      LET l_sub_sql = " SELECT DISTINCT imbadocno ",
                      " FROM imba_t ", 
                      "  ",
                      "  LEFT JOIN imbal_t ON imbalent = "||g_enterprise||" AND imbadocno = imbaldocno AND imbal001 = '",g_dlang,"' ",
                      " WHERE imbaent = " ||g_enterprise|| " AND ",l_wc CLIPPED, cl_sql_add_filter("imba_t")
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
      INITIALIZE g_imba_m.* TO NULL
      CALL g_imbj_d.clear()        
      CALL g_imbj2_d.clear() 
      CALL g_imbj3_d.clear() 
      CALL g_imbj4_d.clear() 
 
      #add-point:browser_fill g_add_browse段額外處理 name="browser_fill.add_browse.other"
      
      #end add-point   
      CALL g_browser.clear()
      LET g_cnt = 1
   ELSE
      LET l_wc  = g_add_browse
      LET l_wc2 = " 1=1" 
      LET g_cnt = g_current_idx
   END IF
 
   #依照t0.imba000,t0.imbadocno,t0.imbadocdt,t0.imba001,t0.imba009,t0.imba003,t0.imba004,t0.imba005,t0.imba006,t0.imba010 Browser欄位定義(取代原本bs_sql功能)
   #考量到單身可能下條件, 所以此處需join單身所有table
   #DISTINCT是為了避免在join時出現重複的資料(如果不加DISTINCT則須在程式中過濾)
   IF g_wc2 <> " 1=1" THEN
      #單身有輸入搜尋條件   
      LET g_sql = " SELECT DISTINCT t0.imbastus,t0.imba000,t0.imbadocno,t0.imbadocdt,t0.imba001,t0.imba009, 
          t0.imba003,t0.imba004,t0.imba005,t0.imba006,t0.imba010,t1.rtaxl003 ,t2.oocql004 ,t3.imeal003 , 
          t4.oocal003 ,t5.oocql004 ",
                  " FROM imba_t t0",
                  "  ",
                  "  LEFT JOIN imbj_t ON imbjent = imbaent AND imbadocno = imbjdocno ", "  ", 
                  #add-point:browser_fill段sql(imbj_t1) name="browser_fill.join.imbj_t1"
                  
                  #end add-point
                  "  LEFT JOIN imbl_t ON imblent = imbaent AND imbadocno = imbldocno", "  ", 
                  #add-point:browser_fill段sql(imbl_t1) name="browser_fill.join.imbl_t1"
                  
                  #end add-point
 
                  "  LEFT JOIN imbm_t ON imbment = imbaent AND imbadocno = imbmdocno", "  ", 
                  #add-point:browser_fill段sql(imbm_t1) name="browser_fill.join.imbm_t1"
                  
                  #end add-point
 
                  "  LEFT JOIN imbo_t ON imboent = imbaent AND imbadocno = imbodocno", "  ", 
                  #add-point:browser_fill段sql(imbo_t1) name="browser_fill.join.imbo_t1"
                  
                  #end add-point
 
 
 
                  " ", 
                  " ",                      
 
                  " ",                      
 
                  " ",                      
 
 
 
                                 " LEFT JOIN rtaxl_t t1 ON t1.rtaxlent="||g_enterprise||" AND t1.rtaxl001=t0.imba009 AND t1.rtaxl002='"||g_dlang||"' ",
               " LEFT JOIN oocql_t t2 ON t2.oocqlent="||g_enterprise||" AND t2.oocql001='200' AND t2.oocql002=t0.imba003 AND t2.oocql003='"||g_dlang||"' ",
               " LEFT JOIN imeal_t t3 ON t3.imealent="||g_enterprise||" AND t3.imeal001=t0.imba005 AND t3.imeal002='"||g_dlang||"' ",
               " LEFT JOIN oocal_t t4 ON t4.oocalent="||g_enterprise||" AND t4.oocal001=t0.imba006 AND t4.oocal002='"||g_dlang||"' ",
               " LEFT JOIN oocql_t t5 ON t5.oocqlent="||g_enterprise||" AND t5.oocql001='210' AND t5.oocql002=t0.imba010 AND t5.oocql003='"||g_dlang||"' ",
 
               " LEFT JOIN imbal_t ON imbalent = "||g_enterprise||" AND imbadocno = imbaldocno AND imbal001 = '",g_dlang,"' ",
                  " WHERE t0.imbaent = " ||g_enterprise|| " AND ",l_wc," AND ",l_wc2, cl_sql_add_filter("imba_t")
   ELSE
      #單身無輸入搜尋條件   
      LET g_sql = " SELECT DISTINCT t0.imbastus,t0.imba000,t0.imbadocno,t0.imbadocdt,t0.imba001,t0.imba009, 
          t0.imba003,t0.imba004,t0.imba005,t0.imba006,t0.imba010,t1.rtaxl003 ,t2.oocql004 ,t3.imeal003 , 
          t4.oocal003 ,t5.oocql004 ",
                  " FROM imba_t t0",
                  "  ",
                                 " LEFT JOIN rtaxl_t t1 ON t1.rtaxlent="||g_enterprise||" AND t1.rtaxl001=t0.imba009 AND t1.rtaxl002='"||g_dlang||"' ",
               " LEFT JOIN oocql_t t2 ON t2.oocqlent="||g_enterprise||" AND t2.oocql001='200' AND t2.oocql002=t0.imba003 AND t2.oocql003='"||g_dlang||"' ",
               " LEFT JOIN imeal_t t3 ON t3.imealent="||g_enterprise||" AND t3.imeal001=t0.imba005 AND t3.imeal002='"||g_dlang||"' ",
               " LEFT JOIN oocal_t t4 ON t4.oocalent="||g_enterprise||" AND t4.oocal001=t0.imba006 AND t4.oocal002='"||g_dlang||"' ",
               " LEFT JOIN oocql_t t5 ON t5.oocqlent="||g_enterprise||" AND t5.oocql001='210' AND t5.oocql002=t0.imba010 AND t5.oocql003='"||g_dlang||"' ",
 
               " LEFT JOIN imbal_t ON imbalent = "||g_enterprise||" AND imbadocno = imbaldocno AND imbal001 = '",g_dlang,"' ",
                  " WHERE t0.imbaent = " ||g_enterprise|| " AND ",l_wc, cl_sql_add_filter("imba_t")
   END IF
   #add-point:browser_fill,sql wc name="browser_fill.fill_sqlwc"
   
   #end add-point
   LET g_sql = g_sql, " ORDER BY imbadocno ",g_order
 
   #add-point:browser_fill,before_prepare name="browser_fill.before_prepare"
      
   #end add-point
        
   #LET g_sql = cl_sql_add_tabid(g_sql,"imba_t") #WC重組
   LET g_sql = cl_sql_add_mask(g_sql) #遮蔽特定資料
   
   IF g_sql.getIndexOf(" 1=2",1) THEN
      DISPLAY "INFO: 1=2 jumped!"
   ELSE
      PREPARE browse_pre FROM g_sql
      DECLARE browse_cur CURSOR FOR browse_pre
      
      #add-point:browser_fill段open cursor name="browser_fill.open"
      
      #end add-point
      
      FOREACH browse_cur INTO g_browser[g_cnt].b_statepic,g_browser[g_cnt].b_imba000,g_browser[g_cnt].b_imbadocno, 
          g_browser[g_cnt].b_imbadocdt,g_browser[g_cnt].b_imba001,g_browser[g_cnt].b_imba009,g_browser[g_cnt].b_imba003, 
          g_browser[g_cnt].b_imba004,g_browser[g_cnt].b_imba005,g_browser[g_cnt].b_imba006,g_browser[g_cnt].b_imba010, 
          g_browser[g_cnt].b_imba009_desc,g_browser[g_cnt].b_imba003_desc,g_browser[g_cnt].b_imba005_desc, 
          g_browser[g_cnt].b_imba006_desc,g_browser[g_cnt].b_imba010_desc
         IF SQLCA.SQLCODE THEN
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "Foreach:",SQLERRMESSAGE 
            LET g_errparam.code = SQLCA.SQLCODE 
            LET g_errparam.popup = TRUE 
            CALL cl_err()
            EXIT FOREACH
         END IF
      
         #add-point:browser_fill段reference name="browser_fill.reference"
                  CALL aimt300_browser_desc()
         #end add-point
      
         #遮罩相關處理
         CALL aimt300_browser_mask()
      
               #應用 a24 樣板自動產生(Version:3)
      #browser顯示圖片
      CASE g_browser[g_cnt].b_statepic
         WHEN "N"
            LET g_browser[g_cnt].b_statepic = "stus/16/unconfirmed.png"
         WHEN "W"
            LET g_browser[g_cnt].b_statepic = "stus/16/signing.png"
         WHEN "A"
            LET g_browser[g_cnt].b_statepic = "stus/16/approved.png"
         WHEN "Y"
            LET g_browser[g_cnt].b_statepic = "stus/16/confirmed.png"
         WHEN "D"
            LET g_browser[g_cnt].b_statepic = "stus/16/withdraw.png"
         WHEN "R"
            LET g_browser[g_cnt].b_statepic = "stus/16/rejection.png"
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
   
   IF cl_null(g_browser[g_cnt].b_imbadocno) THEN
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
 
{<section id="aimt300.ui_headershow" >}
#+ 單頭資料重新顯示
PRIVATE FUNCTION aimt300_ui_headershow()
   #add-point:ui_headershow段define(客製用) name="ui_headershow.define_customerization"
   
   #end add-point  
   #add-point:ui_headershow段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="ui_headershow.define"
      
   #end add-point      
   
   #add-point:Function前置處理  name="ui_headershow.pre_function"
   
   #end add-point
   
   LET g_imba_m.imbadocno = g_browser[g_current_idx].b_imbadocno   
 
   EXECUTE aimt300_master_referesh USING g_imba_m.imbadocno INTO g_imba_m.imbadocno,g_imba_m.imbadocdt, 
       g_imba_m.imba000,g_imba_m.imba900,g_imba_m.imba901,g_imba_m.imbastus,g_imba_m.imba001,g_imba_m.imba002, 
       g_imba_m.imba009,g_imba_m.imba003,g_imba_m.imba004,g_imba_m.imba005,g_imba_m.imba006,g_imba_m.imba010, 
       g_imba_m.imba126,g_imba_m.imba127,g_imba_m.imba131,g_imba_m.imba128,g_imba_m.imba129,g_imba_m.imba130, 
       g_imba_m.imba132,g_imba_m.imba133,g_imba_m.imba134,g_imba_m.imba135,g_imba_m.imba136,g_imba_m.imba137, 
       g_imba_m.imba138,g_imba_m.imba139,g_imba_m.imba140,g_imba_m.imba141,g_imba_m.imbaownid,g_imba_m.imbaowndp, 
       g_imba_m.imbacrtid,g_imba_m.imbacrtdp,g_imba_m.imbacrtdt,g_imba_m.imbamodid,g_imba_m.imbamoddt, 
       g_imba_m.imbacnfid,g_imba_m.imbacnfdt,g_imba_m.imba011,g_imba_m.imba012,g_imba_m.imba013,g_imba_m.imba014, 
       g_imba_m.imba142,g_imba_m.imba108,g_imba_m.imba100,g_imba_m.imba109,g_imba_m.imba101,g_imba_m.imba104, 
       g_imba_m.imba105,g_imba_m.imba106,g_imba_m.imba107,g_imba_m.imba124,g_imba_m.imba145,g_imba_m.imba146, 
       g_imba_m.imba016,g_imba_m.imba017,g_imba_m.imba018,g_imba_m.imba019,g_imba_m.imba020,g_imba_m.imba021, 
       g_imba_m.imba022,g_imba_m.imba023,g_imba_m.imba024,g_imba_m.imba025,g_imba_m.imba026,g_imba_m.imba027, 
       g_imba_m.imba028,g_imba_m.imba029,g_imba_m.imba030,g_imba_m.imba031,g_imba_m.imba032,g_imba_m.imba033, 
       g_imba_m.imba034,g_imba_m.imba035,g_imba_m.imba036,g_imba_m.imba037,g_imba_m.imba043,g_imba_m.imba038, 
       g_imba_m.imba041,g_imba_m.imba042,g_imba_m.imba044,g_imba_m.imba122,g_imba_m.imba045,g_imba_m.imba123, 
       g_imba_m.imba900_desc,g_imba_m.imba901_desc,g_imba_m.imba009_desc,g_imba_m.imba003_desc,g_imba_m.imba005_desc, 
       g_imba_m.imba006_desc,g_imba_m.imba010_desc,g_imba_m.imba126_desc,g_imba_m.imba127_desc,g_imba_m.imba131_desc, 
       g_imba_m.imba128_desc,g_imba_m.imba129_desc,g_imba_m.imba132_desc,g_imba_m.imba133_desc,g_imba_m.imba134_desc, 
       g_imba_m.imba135_desc,g_imba_m.imba136_desc,g_imba_m.imba137_desc,g_imba_m.imba138_desc,g_imba_m.imba139_desc, 
       g_imba_m.imba140_desc,g_imba_m.imba141_desc,g_imba_m.imbaownid_desc,g_imba_m.imbaowndp_desc,g_imba_m.imbacrtid_desc, 
       g_imba_m.imbacrtdp_desc,g_imba_m.imbamodid_desc,g_imba_m.imbacnfid_desc,g_imba_m.imba142_desc, 
       g_imba_m.imba018_desc,g_imba_m.imba022_desc,g_imba_m.imba029_desc,g_imba_m.imba032_desc,g_imba_m.imba122_desc, 
       g_imba_m.imba045_desc
   
   CALL aimt300_imba_t_mask()
   CALL aimt300_show()
      
END FUNCTION
 
{</section>}
 
{<section id="aimt300.ui_detailshow" >}
#+ 單身資料重新顯示
PRIVATE FUNCTION aimt300_ui_detailshow()
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
 
{<section id="aimt300.ui_browser_refresh" >}
#+ 瀏覽頁簽資料重新顯示
PRIVATE FUNCTION aimt300_ui_browser_refresh()
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
      IF g_browser[l_i].b_imbadocno = g_imba_m.imbadocno 
 
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
 
{<section id="aimt300.construct" >}
#+ QBE資料查詢
PRIVATE FUNCTION aimt300_construct()
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
   INITIALIZE g_imba_m.* TO NULL
   CALL g_imbj_d.clear()        
   CALL g_imbj2_d.clear() 
   CALL g_imbj3_d.clear() 
   CALL g_imbj4_d.clear() 
 
   
   LET g_action_choice = ""
    
   INITIALIZE g_wc TO NULL
   INITIALIZE g_wc2 TO NULL
   
   INITIALIZE g_wc2_table1 TO NULL
   INITIALIZE g_wc2_table2 TO NULL
 
   INITIALIZE g_wc2_table3 TO NULL
 
   INITIALIZE g_wc2_table4 TO NULL
 
 
    
   LET g_qryparam.state = 'c'
   
   #add-point:cs段開始前 name="cs.before_construct"
      
   #end add-point 
   
   #使用DIALOG包住 單頭CONSTRUCT及單身CONSTRUCT
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
      
      #單頭
      CONSTRUCT BY NAME g_wc ON imbadocno,imbadocdt,imba000,imba900,imba901,imbastus,imba001,imba002, 
          imbal002,imbal003,imbal004,imba009,imba003,imba004,imba005,imba006,imba010,imba126,imba127, 
          imba131,imba128,imba129,imba130,imba132,imba133,imba134,imba135,imba136,imba137,imba138,imba139, 
          imba140,imba141,imbaownid,imbaowndp,imbacrtid,imbacrtdp,imbacrtdt,imbamodid,imbamoddt,imbacnfid, 
          imbacnfdt,imba011,imba012,imba013,imba014,imba142,imba108,imba100,imba109,imba101,imba104, 
          imba105,imba106,imba107,imba124,imba145,imba146,imba016,imba017,imba018,imba019,imba020,imba021, 
          imba022,imba023,imba024,imba025,imba026,imba027,imba028,imba029,imba030,imba031,imba032,imba033, 
          imba034,imba035,imba036,imba037,imba043,imba038,imba041,imba042,imba044,imba122,imba045,imba123 
 
 
         BEFORE CONSTRUCT
            #add-point:cs段before_construct name="cs.head.before_construct"
                        
            #end add-point 
            
         #公用欄位開窗相關處理
         #應用 a11 樣板自動產生(Version:3)
         #共用欄位查詢處理  
         ##----<<imbacrtdt>>----
         AFTER FIELD imbacrtdt
            CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
            IF NOT cl_null(ls_result) THEN
               IF NOT cl_chk_date_symbol(ls_result) THEN
                  LET ls_result = cl_add_date_extra_cond(ls_result)
               END IF
            END IF
            CALL FGL_DIALOG_SETBUFFER(ls_result)
 
         #----<<imbamoddt>>----
         AFTER FIELD imbamoddt
            CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
            IF NOT cl_null(ls_result) THEN
               IF NOT cl_chk_date_symbol(ls_result) THEN
                  LET ls_result = cl_add_date_extra_cond(ls_result)
               END IF
            END IF
            CALL FGL_DIALOG_SETBUFFER(ls_result)
         
         #----<<imbacnfdt>>----
         AFTER FIELD imbacnfdt
            CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
            IF NOT cl_null(ls_result) THEN
               IF NOT cl_chk_date_symbol(ls_result) THEN
                  LET ls_result = cl_add_date_extra_cond(ls_result)
               END IF
            END IF
            CALL FGL_DIALOG_SETBUFFER(ls_result)
         
         #----<<imbapstdt>>----
 
 
 
            
         #一般欄位開窗相關處理    
                  #Ctrlp:construct.c.imbadocno
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imbadocno
            #add-point:ON ACTION controlp INFIELD imbadocno name="construct.c.imbadocno"
                                    #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL  #160510-00028#1  add
            LET g_qryparam.state = 'c'       #160510-00028#1  add
            LET g_qryparam.reqry = FALSE
            CALL q_imbadocno()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO imbadocno  #顯示到畫面上

            NEXT FIELD imbadocno                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imbadocno
            #add-point:BEFORE FIELD imbadocno name="construct.b.imbadocno"
                        
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imbadocno
            
            #add-point:AFTER FIELD imbadocno name="construct.a.imbadocno"
                                    
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imbadocdt
            #add-point:BEFORE FIELD imbadocdt name="construct.b.imbadocdt"
                        
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imbadocdt
            
            #add-point:AFTER FIELD imbadocdt name="construct.a.imbadocdt"
                        
            #END add-point
            
 
 
         #Ctrlp:construct.c.imbadocdt
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imbadocdt
            #add-point:ON ACTION controlp INFIELD imbadocdt name="construct.c.imbadocdt"
                        
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imba000
            #add-point:BEFORE FIELD imba000 name="construct.b.imba000"
                        
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imba000
            
            #add-point:AFTER FIELD imba000 name="construct.a.imba000"
                        
            #END add-point
            
 
 
         #Ctrlp:construct.c.imba000
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imba000
            #add-point:ON ACTION controlp INFIELD imba000 name="construct.c.imba000"
                        
            #END add-point
 
 
         #Ctrlp:construct.c.imba900
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imba900
            #add-point:ON ACTION controlp INFIELD imba900 name="construct.c.imba900"
                                    #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL  #160510-00028#1  add
            LET g_qryparam.state = 'c'       #160510-00028#1  add
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO imba900  #顯示到畫面上

            NEXT FIELD imba900                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imba900
            #add-point:BEFORE FIELD imba900 name="construct.b.imba900"
                        
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imba900
            
            #add-point:AFTER FIELD imba900 name="construct.a.imba900"
                        
            #END add-point
            
 
 
         #Ctrlp:construct.c.imba901
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imba901
            #add-point:ON ACTION controlp INFIELD imba901 name="construct.c.imba901"
                                    #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL  #160510-00028#1  add
            LET g_qryparam.state = 'c'       #160510-00028#1  add
            LET g_qryparam.reqry = FALSE
            CALL q_ooeg001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO imba901  #顯示到畫面上

            NEXT FIELD imba901                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imba901
            #add-point:BEFORE FIELD imba901 name="construct.b.imba901"
                        
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imba901
            
            #add-point:AFTER FIELD imba901 name="construct.a.imba901"
                        
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imbastus
            #add-point:BEFORE FIELD imbastus name="construct.b.imbastus"
                        
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imbastus
            
            #add-point:AFTER FIELD imbastus name="construct.a.imbastus"
                        
            #END add-point
            
 
 
         #Ctrlp:construct.c.imbastus
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imbastus
            #add-point:ON ACTION controlp INFIELD imbastus name="construct.c.imbastus"
                        
            #END add-point
 
 
         #Ctrlp:construct.c.imba001
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imba001
            #add-point:ON ACTION controlp INFIELD imba001 name="construct.c.imba001"
                                    #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL  #160510-00028#1  add
            LET g_qryparam.state = 'c'       #160510-00028#1  add
            LET g_qryparam.reqry = FALSE
            CALL q_imaa001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO imba001  #顯示到畫面上

            NEXT FIELD imba001                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imba001
            #add-point:BEFORE FIELD imba001 name="construct.b.imba001"
                        
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imba001
            
            #add-point:AFTER FIELD imba001 name="construct.a.imba001"
                        
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imba002
            #add-point:BEFORE FIELD imba002 name="construct.b.imba002"
                        
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imba002
            
            #add-point:AFTER FIELD imba002 name="construct.a.imba002"
                        
            #END add-point
            
 
 
         #Ctrlp:construct.c.imba002
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imba002
            #add-point:ON ACTION controlp INFIELD imba002 name="construct.c.imba002"
                        
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imbal002
            #add-point:BEFORE FIELD imbal002 name="construct.b.imbal002"
                        
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imbal002
            
            #add-point:AFTER FIELD imbal002 name="construct.a.imbal002"
                        
            #END add-point
            
 
 
         #Ctrlp:construct.c.imbal002
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imbal002
            #add-point:ON ACTION controlp INFIELD imbal002 name="construct.c.imbal002"
                        
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imbal003
            #add-point:BEFORE FIELD imbal003 name="construct.b.imbal003"
                        
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imbal003
            
            #add-point:AFTER FIELD imbal003 name="construct.a.imbal003"
                        
            #END add-point
            
 
 
         #Ctrlp:construct.c.imbal003
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imbal003
            #add-point:ON ACTION controlp INFIELD imbal003 name="construct.c.imbal003"
                        
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imbal004
            #add-point:BEFORE FIELD imbal004 name="construct.b.imbal004"
                        
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imbal004
            
            #add-point:AFTER FIELD imbal004 name="construct.a.imbal004"
                        
            #END add-point
            
 
 
         #Ctrlp:construct.c.imbal004
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imbal004
            #add-point:ON ACTION controlp INFIELD imbal004 name="construct.c.imbal004"
                        
            #END add-point
 
 
         #Ctrlp:construct.c.imba009
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imba009
            #add-point:ON ACTION controlp INFIELD imba009 name="construct.c.imba009"
                                    #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL  #160510-00028#1  add
            LET g_qryparam.state = 'c'       #160510-00028#1  add
            LET g_qryparam.reqry = FALSE
            CALL q_rtax001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO imba009  #顯示到畫面上

            NEXT FIELD imba009                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imba009
            #add-point:BEFORE FIELD imba009 name="construct.b.imba009"
                        
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imba009
            
            #add-point:AFTER FIELD imba009 name="construct.a.imba009"
                        
            #END add-point
            
 
 
         #Ctrlp:construct.c.imba003
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imba003
            #add-point:ON ACTION controlp INFIELD imba003 name="construct.c.imba003"
                                    #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL  #160510-00028#1  add
            LET g_qryparam.state = 'c'       #160510-00028#1  add
            LET g_qryparam.reqry = FALSE
            CALL q_imca001_1()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO imba003  #顯示到畫面上

            NEXT FIELD imba003                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imba003
            #add-point:BEFORE FIELD imba003 name="construct.b.imba003"
                        
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imba003
            
            #add-point:AFTER FIELD imba003 name="construct.a.imba003"
                        
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imba004
            #add-point:BEFORE FIELD imba004 name="construct.b.imba004"
                        
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imba004
            
            #add-point:AFTER FIELD imba004 name="construct.a.imba004"
                        
            #END add-point
            
 
 
         #Ctrlp:construct.c.imba004
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imba004
            #add-point:ON ACTION controlp INFIELD imba004 name="construct.c.imba004"
                        
            #END add-point
 
 
         #Ctrlp:construct.c.imba005
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imba005
            #add-point:ON ACTION controlp INFIELD imba005 name="construct.c.imba005"
                        #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = "c"
            LET g_qryparam.reqry = FALSE
            CALL q_imea001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO imba005  #顯示到畫面上

            NEXT FIELD imba005                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imba005
            #add-point:BEFORE FIELD imba005 name="construct.b.imba005"
                        
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imba005
            
            #add-point:AFTER FIELD imba005 name="construct.a.imba005"
                        
            #END add-point
            
 
 
         #Ctrlp:construct.c.imba006
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imba006
            #add-point:ON ACTION controlp INFIELD imba006 name="construct.c.imba006"
                                    #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL  #160510-00028#1  add
            LET g_qryparam.state = 'c'       #160510-00028#1  add
            LET g_qryparam.reqry = FALSE
            CALL q_ooca001_1()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO imba006  #顯示到畫面上
            NEXT FIELD imba006                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imba006
            #add-point:BEFORE FIELD imba006 name="construct.b.imba006"
                        
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imba006
            
            #add-point:AFTER FIELD imba006 name="construct.a.imba006"
                        
            #END add-point
            
 
 
         #Ctrlp:construct.c.imba010
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imba010
            #add-point:ON ACTION controlp INFIELD imba010 name="construct.c.imba010"
                                    #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL  #160510-00028#1  add
            LET g_qryparam.state = 'c'       #160510-00028#1  add
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.arg1 = "210" #應用分類
            CALL q_oocq002()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO imba010  #顯示到畫面上

            NEXT FIELD imba010                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imba010
            #add-point:BEFORE FIELD imba010 name="construct.b.imba010"
                        
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imba010
            
            #add-point:AFTER FIELD imba010 name="construct.a.imba010"
                        
            #END add-point
            
 
 
         #Ctrlp:construct.c.imba126
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imba126
            #add-point:ON ACTION controlp INFIELD imba126 name="construct.c.imba126"
                                    #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL  #160510-00028#1  add
            LET g_qryparam.state = 'c'       #160510-00028#1  add
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.arg1 = "2002" #應用分類
            CALL q_oocq002()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO imba126  #顯示到畫面上

            NEXT FIELD imba126                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imba126
            #add-point:BEFORE FIELD imba126 name="construct.b.imba126"
                        
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imba126
            
            #add-point:AFTER FIELD imba126 name="construct.a.imba126"
                        
            #END add-point
            
 
 
         #Ctrlp:construct.c.imba127
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imba127
            #add-point:ON ACTION controlp INFIELD imba127 name="construct.c.imba127"
                                    #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL  #160510-00028#1  add
            LET g_qryparam.state = 'c'       #160510-00028#1  add
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.arg1 = "2003" #應用分類
            CALL q_oocq002()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO imba127  #顯示到畫面上

            NEXT FIELD imba127                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imba127
            #add-point:BEFORE FIELD imba127 name="construct.b.imba127"
                        
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imba127
            
            #add-point:AFTER FIELD imba127 name="construct.a.imba127"
                        
            #END add-point
            
 
 
         #Ctrlp:construct.c.imba131
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imba131
            #add-point:ON ACTION controlp INFIELD imba131 name="construct.c.imba131"
                                    #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL  #160510-00028#1  add
            LET g_qryparam.state = 'c'       #160510-00028#1  add
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.arg1 = "2001" #應用分類
            CALL q_oocq002()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO imba131  #顯示到畫面上

            NEXT FIELD imba131                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imba131
            #add-point:BEFORE FIELD imba131 name="construct.b.imba131"
                        
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imba131
            
            #add-point:AFTER FIELD imba131 name="construct.a.imba131"
                        
            #END add-point
            
 
 
         #Ctrlp:construct.c.imba128
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imba128
            #add-point:ON ACTION controlp INFIELD imba128 name="construct.c.imba128"
                                    #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL  #160510-00028#1  add
            LET g_qryparam.state = 'c'       #160510-00028#1  add
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.arg1 = "2004" #應用分類
            CALL q_oocq002()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO imba128  #顯示到畫面上

            NEXT FIELD imba128                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imba128
            #add-point:BEFORE FIELD imba128 name="construct.b.imba128"
                        
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imba128
            
            #add-point:AFTER FIELD imba128 name="construct.a.imba128"
                        
            #END add-point
            
 
 
         #Ctrlp:construct.c.imba129
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imba129
            #add-point:ON ACTION controlp INFIELD imba129 name="construct.c.imba129"
                                    #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL  #160510-00028#1  add
            LET g_qryparam.state = 'c'       #160510-00028#1  add
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.arg1 = "2005" #應用分類
            CALL q_oocq002()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO imba129  #顯示到畫面上

            NEXT FIELD imba129                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imba129
            #add-point:BEFORE FIELD imba129 name="construct.b.imba129"
                        
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imba129
            
            #add-point:AFTER FIELD imba129 name="construct.a.imba129"
                        
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imba130
            #add-point:BEFORE FIELD imba130 name="construct.b.imba130"
                        
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imba130
            
            #add-point:AFTER FIELD imba130 name="construct.a.imba130"
                        
            #END add-point
            
 
 
         #Ctrlp:construct.c.imba130
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imba130
            #add-point:ON ACTION controlp INFIELD imba130 name="construct.c.imba130"
                        
            #END add-point
 
 
         #Ctrlp:construct.c.imba132
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imba132
            #add-point:ON ACTION controlp INFIELD imba132 name="construct.c.imba132"
                                    #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL  #160510-00028#1  add
            LET g_qryparam.state = 'c'       #160510-00028#1  add
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.arg1 = "2006" #應用分類
            CALL q_oocq002()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO imba132  #顯示到畫面上

            NEXT FIELD imba132                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imba132
            #add-point:BEFORE FIELD imba132 name="construct.b.imba132"
                        
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imba132
            
            #add-point:AFTER FIELD imba132 name="construct.a.imba132"
                        
            #END add-point
            
 
 
         #Ctrlp:construct.c.imba133
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imba133
            #add-point:ON ACTION controlp INFIELD imba133 name="construct.c.imba133"
                                    #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL  #160510-00028#1  add
            LET g_qryparam.state = 'c'       #160510-00028#1  add
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.arg1 = "2007" #應用分類
            CALL q_oocq002()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO imba133  #顯示到畫面上

            NEXT FIELD imba133                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imba133
            #add-point:BEFORE FIELD imba133 name="construct.b.imba133"
                        
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imba133
            
            #add-point:AFTER FIELD imba133 name="construct.a.imba133"
                        
            #END add-point
            
 
 
         #Ctrlp:construct.c.imba134
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imba134
            #add-point:ON ACTION controlp INFIELD imba134 name="construct.c.imba134"
                                    #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL  #160510-00028#1  add
            LET g_qryparam.state = 'c'       #160510-00028#1  add
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.arg1 = "2008" #應用分類
            CALL q_oocq002()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO imba134  #顯示到畫面上

            NEXT FIELD imba134                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imba134
            #add-point:BEFORE FIELD imba134 name="construct.b.imba134"
                        
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imba134
            
            #add-point:AFTER FIELD imba134 name="construct.a.imba134"
                        
            #END add-point
            
 
 
         #Ctrlp:construct.c.imba135
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imba135
            #add-point:ON ACTION controlp INFIELD imba135 name="construct.c.imba135"
                                    #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL  #160510-00028#1  add
            LET g_qryparam.state = 'c'       #160510-00028#1  add
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.arg1 = "2009" #應用分類
            CALL q_oocq002()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO imba135  #顯示到畫面上

            NEXT FIELD imba135                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imba135
            #add-point:BEFORE FIELD imba135 name="construct.b.imba135"
                        
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imba135
            
            #add-point:AFTER FIELD imba135 name="construct.a.imba135"
                        
            #END add-point
            
 
 
         #Ctrlp:construct.c.imba136
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imba136
            #add-point:ON ACTION controlp INFIELD imba136 name="construct.c.imba136"
                                    #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL  #160510-00028#1  add
            LET g_qryparam.state = 'c'       #160510-00028#1  add
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.arg1 = "2010" #應用分類
            CALL q_oocq002()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO imba136  #顯示到畫面上

            NEXT FIELD imba136                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imba136
            #add-point:BEFORE FIELD imba136 name="construct.b.imba136"
                        
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imba136
            
            #add-point:AFTER FIELD imba136 name="construct.a.imba136"
                        
            #END add-point
            
 
 
         #Ctrlp:construct.c.imba137
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imba137
            #add-point:ON ACTION controlp INFIELD imba137 name="construct.c.imba137"
                                    #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL  #160510-00028#1  add
            LET g_qryparam.state = 'c'       #160510-00028#1  add
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.arg1 = "2011" #應用分類
            CALL q_oocq002()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO imba137  #顯示到畫面上

            NEXT FIELD imba137                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imba137
            #add-point:BEFORE FIELD imba137 name="construct.b.imba137"
                        
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imba137
            
            #add-point:AFTER FIELD imba137 name="construct.a.imba137"
                        
            #END add-point
            
 
 
         #Ctrlp:construct.c.imba138
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imba138
            #add-point:ON ACTION controlp INFIELD imba138 name="construct.c.imba138"
                                    #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL  #160510-00028#1  add
            LET g_qryparam.state = 'c'       #160510-00028#1  add
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.arg1 = "2012" #應用分類
            CALL q_oocq002()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO imba138  #顯示到畫面上

            NEXT FIELD imba138                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imba138
            #add-point:BEFORE FIELD imba138 name="construct.b.imba138"
                        
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imba138
            
            #add-point:AFTER FIELD imba138 name="construct.a.imba138"
                        
            #END add-point
            
 
 
         #Ctrlp:construct.c.imba139
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imba139
            #add-point:ON ACTION controlp INFIELD imba139 name="construct.c.imba139"
                                    #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL  #160510-00028#1  add
            LET g_qryparam.state = 'c'       #160510-00028#1  add
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.arg1 = "2013" #應用分類
            CALL q_oocq002()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO imba139  #顯示到畫面上

            NEXT FIELD imba139                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imba139
            #add-point:BEFORE FIELD imba139 name="construct.b.imba139"
                        
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imba139
            
            #add-point:AFTER FIELD imba139 name="construct.a.imba139"
                        
            #END add-point
            
 
 
         #Ctrlp:construct.c.imba140
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imba140
            #add-point:ON ACTION controlp INFIELD imba140 name="construct.c.imba140"
                                    #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL  #160510-00028#1  add
            LET g_qryparam.state = 'c'       #160510-00028#1  add
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.arg1 = "2014" #應用分類
            CALL q_oocq002()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO imba140  #顯示到畫面上

            NEXT FIELD imba140                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imba140
            #add-point:BEFORE FIELD imba140 name="construct.b.imba140"
                        
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imba140
            
            #add-point:AFTER FIELD imba140 name="construct.a.imba140"
                        
            #END add-point
            
 
 
         #Ctrlp:construct.c.imba141
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imba141
            #add-point:ON ACTION controlp INFIELD imba141 name="construct.c.imba141"
                                    #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL  #160510-00028#1  add
            LET g_qryparam.state = 'c'       #160510-00028#1  add
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.arg1 = "2015" #應用分類
            CALL q_oocq002()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO imba141  #顯示到畫面上

            NEXT FIELD imba141                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imba141
            #add-point:BEFORE FIELD imba141 name="construct.b.imba141"
                        
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imba141
            
            #add-point:AFTER FIELD imba141 name="construct.a.imba141"
                        
            #END add-point
            
 
 
         #Ctrlp:construct.c.imbaownid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imbaownid
            #add-point:ON ACTION controlp INFIELD imbaownid name="construct.c.imbaownid"
                                    #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL  #160510-00028#1  add
            LET g_qryparam.state = 'c'       #160510-00028#1  add
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO imbaownid  #顯示到畫面上

            NEXT FIELD imbaownid                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imbaownid
            #add-point:BEFORE FIELD imbaownid name="construct.b.imbaownid"
                        
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imbaownid
            
            #add-point:AFTER FIELD imbaownid name="construct.a.imbaownid"
                        
            #END add-point
            
 
 
         #Ctrlp:construct.c.imbaowndp
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imbaowndp
            #add-point:ON ACTION controlp INFIELD imbaowndp name="construct.c.imbaowndp"
                                    #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL  #160510-00028#1  add
            LET g_qryparam.state = 'c'       #160510-00028#1  add
            LET g_qryparam.reqry = FALSE
            CALL q_ooeg001_9()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO imbaowndp  #顯示到畫面上

            NEXT FIELD imbaowndp                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imbaowndp
            #add-point:BEFORE FIELD imbaowndp name="construct.b.imbaowndp"
                        
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imbaowndp
            
            #add-point:AFTER FIELD imbaowndp name="construct.a.imbaowndp"
                        
            #END add-point
            
 
 
         #Ctrlp:construct.c.imbacrtid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imbacrtid
            #add-point:ON ACTION controlp INFIELD imbacrtid name="construct.c.imbacrtid"
                                    #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL  #160510-00028#1  add
            LET g_qryparam.state = 'c'       #160510-00028#1  add
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO imbacrtid  #顯示到畫面上

            NEXT FIELD imbacrtid                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imbacrtid
            #add-point:BEFORE FIELD imbacrtid name="construct.b.imbacrtid"
                        
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imbacrtid
            
            #add-point:AFTER FIELD imbacrtid name="construct.a.imbacrtid"
                        
            #END add-point
            
 
 
         #Ctrlp:construct.c.imbacrtdp
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imbacrtdp
            #add-point:ON ACTION controlp INFIELD imbacrtdp name="construct.c.imbacrtdp"
                                    #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL  #160510-00028#1  add
            LET g_qryparam.state = 'c'       #160510-00028#1  add
            LET g_qryparam.reqry = FALSE
            CALL q_ooeg001_9()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO imbacrtdp  #顯示到畫面上

            NEXT FIELD imbacrtdp                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imbacrtdp
            #add-point:BEFORE FIELD imbacrtdp name="construct.b.imbacrtdp"
                        
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imbacrtdp
            
            #add-point:AFTER FIELD imbacrtdp name="construct.a.imbacrtdp"
                        
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imbacrtdt
            #add-point:BEFORE FIELD imbacrtdt name="construct.b.imbacrtdt"
                        
            #END add-point
 
 
         #Ctrlp:construct.c.imbamodid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imbamodid
            #add-point:ON ACTION controlp INFIELD imbamodid name="construct.c.imbamodid"
                                    #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL  #160510-00028#1  add
            LET g_qryparam.state = 'c'       #160510-00028#1  add
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO imbamodid  #顯示到畫面上

            NEXT FIELD imbamodid                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imbamodid
            #add-point:BEFORE FIELD imbamodid name="construct.b.imbamodid"
                        
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imbamodid
            
            #add-point:AFTER FIELD imbamodid name="construct.a.imbamodid"
                        
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imbamoddt
            #add-point:BEFORE FIELD imbamoddt name="construct.b.imbamoddt"
                        
            #END add-point
 
 
         #Ctrlp:construct.c.imbacnfid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imbacnfid
            #add-point:ON ACTION controlp INFIELD imbacnfid name="construct.c.imbacnfid"
                                    #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL  #160510-00028#1  add
            LET g_qryparam.state = 'c'       #160510-00028#1  add
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO imbacnfid  #顯示到畫面上

            NEXT FIELD imbacnfid                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imbacnfid
            #add-point:BEFORE FIELD imbacnfid name="construct.b.imbacnfid"
                        
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imbacnfid
            
            #add-point:AFTER FIELD imbacnfid name="construct.a.imbacnfid"
                        
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imbacnfdt
            #add-point:BEFORE FIELD imbacnfdt name="construct.b.imbacnfdt"
                        
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imba011
            #add-point:BEFORE FIELD imba011 name="construct.b.imba011"
                        
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imba011
            
            #add-point:AFTER FIELD imba011 name="construct.a.imba011"
                        
            #END add-point
            
 
 
         #Ctrlp:construct.c.imba011
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imba011
            #add-point:ON ACTION controlp INFIELD imba011 name="construct.c.imba011"
                        
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imba012
            #add-point:BEFORE FIELD imba012 name="construct.b.imba012"
                        
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imba012
            
            #add-point:AFTER FIELD imba012 name="construct.a.imba012"
                        
            #END add-point
            
 
 
         #Ctrlp:construct.c.imba012
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imba012
            #add-point:ON ACTION controlp INFIELD imba012 name="construct.c.imba012"
                        
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imba013
            #add-point:BEFORE FIELD imba013 name="construct.b.imba013"
                        
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imba013
            
            #add-point:AFTER FIELD imba013 name="construct.a.imba013"
                        
            #END add-point
            
 
 
         #Ctrlp:construct.c.imba013
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imba013
            #add-point:ON ACTION controlp INFIELD imba013 name="construct.c.imba013"
                        
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imba014
            #add-point:BEFORE FIELD imba014 name="construct.b.imba014"
                        
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imba014
            
            #add-point:AFTER FIELD imba014 name="construct.a.imba014"
                        
            #END add-point
            
 
 
         #Ctrlp:construct.c.imba014
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imba014
            #add-point:ON ACTION controlp INFIELD imba014 name="construct.c.imba014"
                        
            #END add-point
 
 
         #Ctrlp:construct.c.imba142
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imba142
            #add-point:ON ACTION controlp INFIELD imba142 name="construct.c.imba142"
                                    #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL  #160510-00028#1  add
            LET g_qryparam.state = 'c'       #160510-00028#1  add
            LET g_qryparam.reqry = FALSE
            #CALL q_imba142()                           #呼叫開窗  #170213-00038#1   2017/02/15   By 08734 mark
            CALL q_ooef001_15()                           #呼叫開窗  #170213-00038#1   2017/02/15   By 08734 add
            DISPLAY g_qryparam.return1 TO imba142  #顯示到畫面上

            NEXT FIELD imba142                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imba142
            #add-point:BEFORE FIELD imba142 name="construct.b.imba142"
                        
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imba142
            
            #add-point:AFTER FIELD imba142 name="construct.a.imba142"
                        
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imba108
            #add-point:BEFORE FIELD imba108 name="construct.b.imba108"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imba108
            
            #add-point:AFTER FIELD imba108 name="construct.a.imba108"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.imba108
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imba108
            #add-point:ON ACTION controlp INFIELD imba108 name="construct.c.imba108"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imba100
            #add-point:BEFORE FIELD imba100 name="construct.b.imba100"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imba100
            
            #add-point:AFTER FIELD imba100 name="construct.a.imba100"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.imba100
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imba100
            #add-point:ON ACTION controlp INFIELD imba100 name="construct.c.imba100"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imba109
            #add-point:BEFORE FIELD imba109 name="construct.b.imba109"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imba109
            
            #add-point:AFTER FIELD imba109 name="construct.a.imba109"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.imba109
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imba109
            #add-point:ON ACTION controlp INFIELD imba109 name="construct.c.imba109"
            
            #END add-point
 
 
         #Ctrlp:construct.c.imba101
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imba101
            #add-point:ON ACTION controlp INFIELD imba101 name="construct.c.imba101"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_pmaa001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO imba101  #顯示到畫面上
            NEXT FIELD imba101                     #返回原欄位
    



            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imba101
            #add-point:BEFORE FIELD imba101 name="construct.b.imba101"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imba101
            
            #add-point:AFTER FIELD imba101 name="construct.a.imba101"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.imba104
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imba104
            #add-point:ON ACTION controlp INFIELD imba104 name="construct.c.imba104"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooca001_1()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO imba104  #顯示到畫面上
            NEXT FIELD imba104                     #返回原欄位
    



            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imba104
            #add-point:BEFORE FIELD imba104 name="construct.b.imba104"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imba104
            
            #add-point:AFTER FIELD imba104 name="construct.a.imba104"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.imba105
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imba105
            #add-point:ON ACTION controlp INFIELD imba105 name="construct.c.imba105"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooca001_1()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO imba105  #顯示到畫面上
            NEXT FIELD imba105                     #返回原欄位
    



            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imba105
            #add-point:BEFORE FIELD imba105 name="construct.b.imba105"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imba105
            
            #add-point:AFTER FIELD imba105 name="construct.a.imba105"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.imba106
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imba106
            #add-point:ON ACTION controlp INFIELD imba106 name="construct.c.imba106"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooca001_1()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO imba106  #顯示到畫面上
            NEXT FIELD imba106                     #返回原欄位
    



            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imba106
            #add-point:BEFORE FIELD imba106 name="construct.b.imba106"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imba106
            
            #add-point:AFTER FIELD imba106 name="construct.a.imba106"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.imba107
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imba107
            #add-point:ON ACTION controlp INFIELD imba107 name="construct.c.imba107"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooca001_1()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO imba107  #顯示到畫面上
            NEXT FIELD imba107                     #返回原欄位
    



            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imba107
            #add-point:BEFORE FIELD imba107 name="construct.b.imba107"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imba107
            
            #add-point:AFTER FIELD imba107 name="construct.a.imba107"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.imba124
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imba124
            #add-point:ON ACTION controlp INFIELD imba124 name="construct.c.imba124"
            #此段落由子樣板a08產生
            #開窗c段
#            LET g_qryparam.reqry = FALSE
#            CALL q_oodc001_2()                           #呼叫開窗
#            DISPLAY g_qryparam.return1 TO imba124  #顯示到畫面上
#
#            NEXT FIELD imba124                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imba124
            #add-point:BEFORE FIELD imba124 name="construct.b.imba124"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imba124
            
            #add-point:AFTER FIELD imba124 name="construct.a.imba124"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.imba145
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imba145
            #add-point:ON ACTION controlp INFIELD imba145 name="construct.c.imba145"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooca001_1()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO imba145  #顯示到畫面上
            NEXT FIELD imba145                     #返回原欄位
    



            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imba145
            #add-point:BEFORE FIELD imba145 name="construct.b.imba145"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imba145
            
            #add-point:AFTER FIELD imba145 name="construct.a.imba145"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imba146
            #add-point:BEFORE FIELD imba146 name="construct.b.imba146"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imba146
            
            #add-point:AFTER FIELD imba146 name="construct.a.imba146"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.imba146
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imba146
            #add-point:ON ACTION controlp INFIELD imba146 name="construct.c.imba146"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imba016
            #add-point:BEFORE FIELD imba016 name="construct.b.imba016"
                        
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imba016
            
            #add-point:AFTER FIELD imba016 name="construct.a.imba016"
                        
            #END add-point
            
 
 
         #Ctrlp:construct.c.imba016
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imba016
            #add-point:ON ACTION controlp INFIELD imba016 name="construct.c.imba016"
                        
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imba017
            #add-point:BEFORE FIELD imba017 name="construct.b.imba017"
                        
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imba017
            
            #add-point:AFTER FIELD imba017 name="construct.a.imba017"
                        
            #END add-point
            
 
 
         #Ctrlp:construct.c.imba017
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imba017
            #add-point:ON ACTION controlp INFIELD imba017 name="construct.c.imba017"
                        
            #END add-point
 
 
         #Ctrlp:construct.c.imba018
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imba018
            #add-point:ON ACTION controlp INFIELD imba018 name="construct.c.imba018"
                                    #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL  #160510-00028#1  add
            LET g_qryparam.state = 'c'       #160510-00028#1  add
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.where = " ooca003 = '3'"
            CALL q_ooca001_1()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO imba018  #顯示到畫面上
            LET g_qryparam.where = ""
            NEXT FIELD imba018                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imba018
            #add-point:BEFORE FIELD imba018 name="construct.b.imba018"
                        
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imba018
            
            #add-point:AFTER FIELD imba018 name="construct.a.imba018"
                        
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imba019
            #add-point:BEFORE FIELD imba019 name="construct.b.imba019"
                        
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imba019
            
            #add-point:AFTER FIELD imba019 name="construct.a.imba019"
                        
            #END add-point
            
 
 
         #Ctrlp:construct.c.imba019
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imba019
            #add-point:ON ACTION controlp INFIELD imba019 name="construct.c.imba019"
                        
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imba020
            #add-point:BEFORE FIELD imba020 name="construct.b.imba020"
                        
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imba020
            
            #add-point:AFTER FIELD imba020 name="construct.a.imba020"
                        
            #END add-point
            
 
 
         #Ctrlp:construct.c.imba020
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imba020
            #add-point:ON ACTION controlp INFIELD imba020 name="construct.c.imba020"
                        
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imba021
            #add-point:BEFORE FIELD imba021 name="construct.b.imba021"
                        
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imba021
            
            #add-point:AFTER FIELD imba021 name="construct.a.imba021"
                        
            #END add-point
            
 
 
         #Ctrlp:construct.c.imba021
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imba021
            #add-point:ON ACTION controlp INFIELD imba021 name="construct.c.imba021"
                        
            #END add-point
 
 
         #Ctrlp:construct.c.imba022
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imba022
            #add-point:ON ACTION controlp INFIELD imba022 name="construct.c.imba022"
                                    #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL  #160510-00028#1  add
            LET g_qryparam.state = 'c'       #160510-00028#1  add
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.where = " ooca003 = '2'"            
            CALL q_ooca001_1()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO imba022  #顯示到畫面上
            LET g_qryparam.where = ""
            NEXT FIELD imba022                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imba022
            #add-point:BEFORE FIELD imba022 name="construct.b.imba022"
                        
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imba022
            
            #add-point:AFTER FIELD imba022 name="construct.a.imba022"
                        
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imba023
            #add-point:BEFORE FIELD imba023 name="construct.b.imba023"
                        
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imba023
            
            #add-point:AFTER FIELD imba023 name="construct.a.imba023"
                        
            #END add-point
            
 
 
         #Ctrlp:construct.c.imba023
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imba023
            #add-point:ON ACTION controlp INFIELD imba023 name="construct.c.imba023"
                        
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imba024
            #add-point:BEFORE FIELD imba024 name="construct.b.imba024"
                        
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imba024
            
            #add-point:AFTER FIELD imba024 name="construct.a.imba024"
                        
            #END add-point
            
 
 
         #Ctrlp:construct.c.imba024
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imba024
            #add-point:ON ACTION controlp INFIELD imba024 name="construct.c.imba024"
                                    #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL  #160510-00028#1  add
            LET g_qryparam.state = 'c'       #160510-00028#1  add
            LET g_qryparam.reqry = FALSE
            CALL q_ooca001_1()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO imba024  #顯示到畫面上

            NEXT FIELD imba024                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imba025
            #add-point:BEFORE FIELD imba025 name="construct.b.imba025"
                        
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imba025
            
            #add-point:AFTER FIELD imba025 name="construct.a.imba025"
                        
            #END add-point
            
 
 
         #Ctrlp:construct.c.imba025
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imba025
            #add-point:ON ACTION controlp INFIELD imba025 name="construct.c.imba025"
                        
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imba026
            #add-point:BEFORE FIELD imba026 name="construct.b.imba026"
                        
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imba026
            
            #add-point:AFTER FIELD imba026 name="construct.a.imba026"
                        
            #END add-point
            
 
 
         #Ctrlp:construct.c.imba026
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imba026
            #add-point:ON ACTION controlp INFIELD imba026 name="construct.c.imba026"
                                    #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL  #160510-00028#1  add
            LET g_qryparam.state = 'c'       #160510-00028#1  add
            LET g_qryparam.reqry = FALSE
            CALL q_ooca001_1()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO imba026  #顯示到畫面上

            NEXT FIELD imba026                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imba027
            #add-point:BEFORE FIELD imba027 name="construct.b.imba027"
                        
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imba027
            
            #add-point:AFTER FIELD imba027 name="construct.a.imba027"
                        
            #END add-point
            
 
 
         #Ctrlp:construct.c.imba027
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imba027
            #add-point:ON ACTION controlp INFIELD imba027 name="construct.c.imba027"
                        
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imba028
            #add-point:BEFORE FIELD imba028 name="construct.b.imba028"
                        
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imba028
            
            #add-point:AFTER FIELD imba028 name="construct.a.imba028"
                        
            #END add-point
            
 
 
         #Ctrlp:construct.c.imba028
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imba028
            #add-point:ON ACTION controlp INFIELD imba028 name="construct.c.imba028"
                        
            #END add-point
 
 
         #Ctrlp:construct.c.imba029
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imba029
            #add-point:ON ACTION controlp INFIELD imba029 name="construct.c.imba029"
                                    #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL  #160510-00028#1  add
            LET g_qryparam.state = 'c'       #160510-00028#1  add
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.where = " ooca003 = '5'"            
            CALL q_ooca001_1()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO imba029  #顯示到畫面上
            LET g_qryparam.where = ""
            NEXT FIELD imba029                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imba029
            #add-point:BEFORE FIELD imba029 name="construct.b.imba029"
                        
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imba029
            
            #add-point:AFTER FIELD imba029 name="construct.a.imba029"
                        
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imba030
            #add-point:BEFORE FIELD imba030 name="construct.b.imba030"
                        
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imba030
            
            #add-point:AFTER FIELD imba030 name="construct.a.imba030"
                        
            #END add-point
            
 
 
         #Ctrlp:construct.c.imba030
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imba030
            #add-point:ON ACTION controlp INFIELD imba030 name="construct.c.imba030"
                        
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imba031
            #add-point:BEFORE FIELD imba031 name="construct.b.imba031"
                        
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imba031
            
            #add-point:AFTER FIELD imba031 name="construct.a.imba031"
                        
            #END add-point
            
 
 
         #Ctrlp:construct.c.imba031
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imba031
            #add-point:ON ACTION controlp INFIELD imba031 name="construct.c.imba031"
                        
            #END add-point
 
 
         #Ctrlp:construct.c.imba032
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imba032
            #add-point:ON ACTION controlp INFIELD imba032 name="construct.c.imba032"
                                    #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL  #160510-00028#1  add
            LET g_qryparam.state = 'c'       #160510-00028#1  add
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.where = " ooca003 = '3'"            
            CALL q_ooca001_1()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO imba032  #顯示到畫面上
            LET g_qryparam.where = ""
            NEXT FIELD imba032                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imba032
            #add-point:BEFORE FIELD imba032 name="construct.b.imba032"
                        
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imba032
            
            #add-point:AFTER FIELD imba032 name="construct.a.imba032"
                        
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imba033
            #add-point:BEFORE FIELD imba033 name="construct.b.imba033"
                        
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imba033
            
            #add-point:AFTER FIELD imba033 name="construct.a.imba033"
                        
            #END add-point
            
 
 
         #Ctrlp:construct.c.imba033
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imba033
            #add-point:ON ACTION controlp INFIELD imba033 name="construct.c.imba033"
                        
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imba034
            #add-point:BEFORE FIELD imba034 name="construct.b.imba034"
                        
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imba034
            
            #add-point:AFTER FIELD imba034 name="construct.a.imba034"
                        
            #END add-point
            
 
 
         #Ctrlp:construct.c.imba034
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imba034
            #add-point:ON ACTION controlp INFIELD imba034 name="construct.c.imba034"
                        
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imba035
            #add-point:BEFORE FIELD imba035 name="construct.b.imba035"
                        
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imba035
            
            #add-point:AFTER FIELD imba035 name="construct.a.imba035"
                        
            #END add-point
            
 
 
         #Ctrlp:construct.c.imba035
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imba035
            #add-point:ON ACTION controlp INFIELD imba035 name="construct.c.imba035"
                        
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imba036
            #add-point:BEFORE FIELD imba036 name="construct.b.imba036"
                        
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imba036
            
            #add-point:AFTER FIELD imba036 name="construct.a.imba036"
                        
            #END add-point
            
 
 
         #Ctrlp:construct.c.imba036
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imba036
            #add-point:ON ACTION controlp INFIELD imba036 name="construct.c.imba036"
                        
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imba037
            #add-point:BEFORE FIELD imba037 name="construct.b.imba037"
                        
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imba037
            
            #add-point:AFTER FIELD imba037 name="construct.a.imba037"
                        
            #END add-point
            
 
 
         #Ctrlp:construct.c.imba037
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imba037
            #add-point:ON ACTION controlp INFIELD imba037 name="construct.c.imba037"
                        
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imba043
            #add-point:BEFORE FIELD imba043 name="construct.b.imba043"
                        
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imba043
            
            #add-point:AFTER FIELD imba043 name="construct.a.imba043"
                        
            #END add-point
            
 
 
         #Ctrlp:construct.c.imba043
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imba043
            #add-point:ON ACTION controlp INFIELD imba043 name="construct.c.imba043"
                                    #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL  #160510-00028#1  add
            LET g_qryparam.state = 'c'       #160510-00028#1  add
            LET g_qryparam.reqry = FALSE
            CALL q_oocq002()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO imba043  #顯示到畫面上

            NEXT FIELD imba043                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imba038
            #add-point:BEFORE FIELD imba038 name="construct.b.imba038"
                        
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imba038
            
            #add-point:AFTER FIELD imba038 name="construct.a.imba038"
                        
            #END add-point
            
 
 
         #Ctrlp:construct.c.imba038
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imba038
            #add-point:ON ACTION controlp INFIELD imba038 name="construct.c.imba038"
                        
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imba041
            #add-point:BEFORE FIELD imba041 name="construct.b.imba041"
                        
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imba041
            
            #add-point:AFTER FIELD imba041 name="construct.a.imba041"
                        
            #END add-point
            
 
 
         #Ctrlp:construct.c.imba041
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imba041
            #add-point:ON ACTION controlp INFIELD imba041 name="construct.c.imba041"
                        
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imba042
            #add-point:BEFORE FIELD imba042 name="construct.b.imba042"
                        
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imba042
            
            #add-point:AFTER FIELD imba042 name="construct.a.imba042"
                        
            #END add-point
            
 
 
         #Ctrlp:construct.c.imba042
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imba042
            #add-point:ON ACTION controlp INFIELD imba042 name="construct.c.imba042"
            #170213-00038#1   2017/02/15   By 08734 add(S)
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			   LET g_qryparam.reqry = FALSE
            CALL q_mrba001_12()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO imba042  #顯示到畫面上

            NEXT FIELD imba042                     #返回原欄位 
            #170213-00038#1   2017/02/15   By 08734 add(E)            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imba044
            #add-point:BEFORE FIELD imba044 name="construct.b.imba044"
                        
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imba044
            
            #add-point:AFTER FIELD imba044 name="construct.a.imba044"
                        
            #END add-point
            
 
 
         #Ctrlp:construct.c.imba044
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imba044
            #add-point:ON ACTION controlp INFIELD imba044 name="construct.c.imba044"
                        
            #END add-point
 
 
         #Ctrlp:construct.c.imba122
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imba122
            #add-point:ON ACTION controlp INFIELD imba122 name="construct.c.imba122"
            INITIALIZE g_qryparam.* TO NULL  #160510-00028#1  add
            LET g_qryparam.state = 'c'       #160510-00028#1  add
            LET g_qryparam.reqry = FALSE

            #給予arg
            LET g_qryparam.arg1 = "2000" #應用分類
            CALL q_oocq002()                                #呼叫開窗

            DISPLAY g_qryparam.return1 TO imba122  #顯示到畫面上      
            NEXT FIELD imba122                          #返回原欄位   
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imba122
            #add-point:BEFORE FIELD imba122 name="construct.b.imba122"
                        
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imba122
            
            #add-point:AFTER FIELD imba122 name="construct.a.imba122"
                        
            #END add-point
            
 
 
         #Ctrlp:construct.c.imba045
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imba045
            #add-point:ON ACTION controlp INFIELD imba045 name="construct.c.imba045"
                                    #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL  #160510-00028#1  add
            LET g_qryparam.state = 'c'       #160510-00028#1  add
            LET g_qryparam.reqry = FALSE
            CALL q_oocg001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO imba045  #顯示到畫面上

            NEXT FIELD imba045                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imba045
            #add-point:BEFORE FIELD imba045 name="construct.b.imba045"
                        
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imba045
            
            #add-point:AFTER FIELD imba045 name="construct.a.imba045"
                        
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imba123
            #add-point:BEFORE FIELD imba123 name="construct.b.imba123"
                        
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imba123
            
            #add-point:AFTER FIELD imba123 name="construct.a.imba123"
                        
            #END add-point
            
 
 
         #Ctrlp:construct.c.imba123
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imba123
            #add-point:ON ACTION controlp INFIELD imba123 name="construct.c.imba123"
                        
            #END add-point
 
 
 
         
      END CONSTRUCT
 
      #單身根據table分拆construct
      CONSTRUCT g_wc2_table1 ON imbj002,imbj003,imbj004,imbj005,imbj006
           FROM s_detail1[1].imbj002,s_detail1[1].imbj003,s_detail1[1].imbj004,s_detail1[1].imbj005, 
               s_detail1[1].imbj006
                      
         BEFORE CONSTRUCT
            #add-point:cs段before_construct name="cs.body.before_construct"
                        
            #end add-point 
            
       #單身公用欄位開窗相關處理
       
         
       #單身一般欄位開窗相關處理
                #Ctrlp:construct.c.page1.imbj002
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imbj002
            #add-point:ON ACTION controlp INFIELD imbj002 name="construct.c.page1.imbj002"
                                    #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL  #160510-00028#1  add
            LET g_qryparam.state = 'c'       #160510-00028#1  add
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.arg1 = "270" #應用分類
            CALL q_oocq002_1()                      #呼叫開窗
            DISPLAY g_qryparam.return1 TO imbj002  #顯示到畫面上

            NEXT FIELD imbj002                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imbj002
            #add-point:BEFORE FIELD imbj002 name="construct.b.page1.imbj002"
                        
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imbj002
            
            #add-point:AFTER FIELD imbj002 name="construct.a.page1.imbj002"
                        
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.imbj003
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imbj003
            #add-point:ON ACTION controlp INFIELD imbj003 name="construct.c.page1.imbj003"
                                    #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL  #160510-00028#1  add
            LET g_qryparam.state = 'c'       #160510-00028#1  add
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.arg1 = "271" #應用分類
            CALL q_oocq002_1()                               #呼叫開窗
            DISPLAY g_qryparam.return1 TO imbj003  #顯示到畫面上

            NEXT FIELD imbj003                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imbj003
            #add-point:BEFORE FIELD imbj003 name="construct.b.page1.imbj003"
                        
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imbj003
            
            #add-point:AFTER FIELD imbj003 name="construct.a.page1.imbj003"
                        
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imbj004
            #add-point:BEFORE FIELD imbj004 name="construct.b.page1.imbj004"
                        
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imbj004
            
            #add-point:AFTER FIELD imbj004 name="construct.a.page1.imbj004"
                        
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.imbj004
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imbj004
            #add-point:ON ACTION controlp INFIELD imbj004 name="construct.c.page1.imbj004"
                        
            #END add-point
 
 
         #Ctrlp:construct.c.page1.imbj005
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imbj005
            #add-point:ON ACTION controlp INFIELD imbj005 name="construct.c.page1.imbj005"
                                    #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL  #160510-00028#1  add
            LET g_qryparam.state = 'c'       #160510-00028#1  add
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.where = " ooca003 = '3'"
            CALL q_ooca001_1()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO imbj005  #顯示到畫面上
            LET g_qryparam.where = ""
            NEXT FIELD imbj005                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imbj005
            #add-point:BEFORE FIELD imbj005 name="construct.b.page1.imbj005"
                        
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imbj005
            
            #add-point:AFTER FIELD imbj005 name="construct.a.page1.imbj005"
                        
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.imbj006
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imbj006
            #add-point:ON ACTION controlp INFIELD imbj006 name="construct.c.page1.imbj006"
                                    #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL  #160510-00028#1  add
            LET g_qryparam.state = 'c'       #160510-00028#1  add
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.arg1 = "272" #應用分類
            CALL q_oocq002_1()                            #呼叫開窗
            DISPLAY g_qryparam.return1 TO imbj006  #顯示到畫面上

            NEXT FIELD imbj006                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imbj006
            #add-point:BEFORE FIELD imbj006 name="construct.b.page1.imbj006"
                        
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imbj006
            
            #add-point:AFTER FIELD imbj006 name="construct.a.page1.imbj006"
                        
            #END add-point
            
 
 
   
       
      END CONSTRUCT
      
      CONSTRUCT g_wc2_table2 ON imbl002
           FROM s_detail2[1].imbl002
                      
         BEFORE CONSTRUCT
            #add-point:cs段before_construct name="cs.body2.before_construct"
                        
            #end add-point 
            
       #單身公用欄位開窗相關處理(table 2)
       
       
       #單身一般欄位開窗相關處理       
                #Ctrlp:construct.c.page2.imbl002
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imbl002
            #add-point:ON ACTION controlp INFIELD imbl002 name="construct.c.page2.imbl002"
                                    #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL  #160510-00028#1  add
            LET g_qryparam.state = 'c'       #160510-00028#1  add
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.arg1 = "213" #應用分類
            CALL q_oocq002_1()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO imbl002  #顯示到畫面上

            NEXT FIELD imbl002                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imbl002
            #add-point:BEFORE FIELD imbl002 name="construct.b.page2.imbl002"
                        
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imbl002
            
            #add-point:AFTER FIELD imbl002 name="construct.a.page2.imbl002"
                        
            #END add-point
            
 
 
   
       
      END CONSTRUCT
 
      CONSTRUCT g_wc2_table3 ON imbm002,imbm005,imbm003,imbm006
           FROM s_detail3[1].imbm002,s_detail3[1].imbm005,s_detail3[1].imbm003,s_detail3[1].imbm006
                      
         BEFORE CONSTRUCT
            #add-point:cs段before_construct name="cs.body3.before_construct"
                        
            #end add-point 
            
       #單身公用欄位開窗相關處理(table 3)
       
       
       #單身一般欄位開窗相關處理       
                #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imbm002
            #add-point:BEFORE FIELD imbm002 name="construct.b.page3.imbm002"
                        
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imbm002
            
            #add-point:AFTER FIELD imbm002 name="construct.a.page3.imbm002"
                        
            #END add-point
            
 
 
         #Ctrlp:construct.c.page3.imbm002
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imbm002
            #add-point:ON ACTION controlp INFIELD imbm002 name="construct.c.page3.imbm002"
                        
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imbm005
            #add-point:BEFORE FIELD imbm005 name="construct.b.page3.imbm005"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imbm005
            
            #add-point:AFTER FIELD imbm005 name="construct.a.page3.imbm005"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page3.imbm005
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imbm005
            #add-point:ON ACTION controlp INFIELD imbm005 name="construct.c.page3.imbm005"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imbm003
            #add-point:BEFORE FIELD imbm003 name="construct.b.page3.imbm003"
                        
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imbm003
            
            #add-point:AFTER FIELD imbm003 name="construct.a.page3.imbm003"
                        
            #END add-point
            
 
 
         #Ctrlp:construct.c.page3.imbm003
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imbm003
            #add-point:ON ACTION controlp INFIELD imbm003 name="construct.c.page3.imbm003"
                        
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imbm006
            #add-point:BEFORE FIELD imbm006 name="construct.b.page3.imbm006"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imbm006
            
            #add-point:AFTER FIELD imbm006 name="construct.a.page3.imbm006"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page3.imbm006
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imbm006
            #add-point:ON ACTION controlp INFIELD imbm006 name="construct.c.page3.imbm006"
            
            #END add-point
 
 
   
       
      END CONSTRUCT
 
      CONSTRUCT g_wc2_table4 ON imbo002
           FROM s_detail4[1].imbo002
                      
         BEFORE CONSTRUCT
            #add-point:cs段before_construct name="cs.body4.before_construct"
                        
            #end add-point 
            
       #單身公用欄位開窗相關處理(table 4)
       
       
       #單身一般欄位開窗相關處理       
                #Ctrlp:construct.c.page4.imbo002
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imbo002
            #add-point:ON ACTION controlp INFIELD imbo002 name="construct.c.page4.imbo002"
                                    #此段落由子樣板a08產生
            #開窗c段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			LET g_qryparam.reqry = FALSE
            CALL q_ooca001_1()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO imbo002  #顯示到畫面上

            NEXT FIELD imbo002                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imbo002
            #add-point:BEFORE FIELD imbo002 name="construct.b.page4.imbo002"
                        
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imbo002
            
            #add-point:AFTER FIELD imbo002 name="construct.a.page4.imbo002"
                        
            #END add-point
            
 
 
   
       
      END CONSTRUCT
 
 
      
 
      
      #add-point:cs段add_cs(本段內只能出現新的CONSTRUCT指令) name="cs.add_cs"
      SUBDIALOG aoo_aooi360_01.aooi360_01_construct
      SUBDIALOG aim_aimt300_01.aimt300_01_construct
      #end add-point
 
      BEFORE DIALOG
         CALL cl_qbe_init()
         #add-point:cs段b_dialog name="cs.b_dialog"
         NEXT FIELD imbadocno        
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
 
 
            FOR li_idx = 1 TO la_wc.getLength()
               CASE
                  WHEN la_wc[li_idx].tableid = "imba_t" 
                     LET g_wc = la_wc[li_idx].wc
                  WHEN la_wc[li_idx].tableid = "imbj_t" 
                     LET g_wc2_table1 = la_wc[li_idx].wc
                  WHEN la_wc[li_idx].tableid = "imbl_t" 
                     LET g_wc2_table2 = la_wc[li_idx].wc
 
                  WHEN la_wc[li_idx].tableid = "imbm_t" 
                     LET g_wc2_table3 = la_wc[li_idx].wc
 
                  WHEN la_wc[li_idx].tableid = "imbo_t" 
                     LET g_wc2_table4 = la_wc[li_idx].wc
 
 
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
 
 
 
 
   
   #add-point:cs段結束前 name="cs.after_construct"
      
   #end add-point    
 
   IF INT_FLAG THEN
      RETURN
   END IF
 
END FUNCTION
 
{</section>}
 
{<section id="aimt300.filter" >}
#應用 a50 樣板自動產生(Version:8)
#+ filter過濾功能
PRIVATE FUNCTION aimt300_filter()
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
      CONSTRUCT g_wc_filter ON imba000,imbadocno,imbadocdt,imba001,imba009,imba003,imba004,imba005,imba006, 
          imba010
                          FROM s_browse[1].b_imba000,s_browse[1].b_imbadocno,s_browse[1].b_imbadocdt, 
                              s_browse[1].b_imba001,s_browse[1].b_imba009,s_browse[1].b_imba003,s_browse[1].b_imba004, 
                              s_browse[1].b_imba005,s_browse[1].b_imba006,s_browse[1].b_imba010
 
         BEFORE CONSTRUCT
               DISPLAY aimt300_filter_parser('imba000') TO s_browse[1].b_imba000
            DISPLAY aimt300_filter_parser('imbadocno') TO s_browse[1].b_imbadocno
            DISPLAY aimt300_filter_parser('imbadocdt') TO s_browse[1].b_imbadocdt
            DISPLAY aimt300_filter_parser('imba001') TO s_browse[1].b_imba001
            DISPLAY aimt300_filter_parser('imba009') TO s_browse[1].b_imba009
            DISPLAY aimt300_filter_parser('imba003') TO s_browse[1].b_imba003
            DISPLAY aimt300_filter_parser('imba004') TO s_browse[1].b_imba004
            DISPLAY aimt300_filter_parser('imba005') TO s_browse[1].b_imba005
            DISPLAY aimt300_filter_parser('imba006') TO s_browse[1].b_imba006
            DISPLAY aimt300_filter_parser('imba010') TO s_browse[1].b_imba010
      
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
 
      CALL aimt300_filter_show('imba000')
   CALL aimt300_filter_show('imbadocno')
   CALL aimt300_filter_show('imbadocdt')
   CALL aimt300_filter_show('imba001')
   CALL aimt300_filter_show('imba009')
   CALL aimt300_filter_show('imba003')
   CALL aimt300_filter_show('imba004')
   CALL aimt300_filter_show('imba005')
   CALL aimt300_filter_show('imba006')
   CALL aimt300_filter_show('imba010')
 
END FUNCTION
 
{</section>}
 
{<section id="aimt300.filter_parser" >}
#+ filter過濾功能
PRIVATE FUNCTION aimt300_filter_parser(ps_field)
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
 
{<section id="aimt300.filter_show" >}
#+ 顯示過濾條件
PRIVATE FUNCTION aimt300_filter_show(ps_field)
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
   LET ls_condition = aimt300_filter_parser(ps_field)
   IF NOT cl_null(ls_condition) THEN
      LET ls_title = ls_title, '※', ls_condition, '※'
   END IF
 
   #將資料顯示回去
   CALL lnode_item.setAttribute("text",ls_title)
 
END FUNCTION
 
{</section>}
 
{<section id="aimt300.query" >}
#+ 資料查詢QBE功能準備
PRIVATE FUNCTION aimt300_query()
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
   CALL g_imbj_d.clear()
   CALL g_imbj2_d.clear()
   CALL g_imbj3_d.clear()
   CALL g_imbj4_d.clear()
 
   
   #add-point:query段other name="query.other"
      
   #end add-point   
   
   DISPLAY '' TO FORMONLY.idx
   DISPLAY '' TO FORMONLY.cnt
   DISPLAY '' TO FORMONLY.b_index
   DISPLAY '' TO FORMONLY.b_count
   DISPLAY '' TO FORMONLY.h_index
   DISPLAY '' TO FORMONLY.h_count
   
   CALL aimt300_construct()
 
   IF INT_FLAG THEN
      #取消查詢
      LET INT_FLAG = 0
      #LET g_wc = ls_wc
      LET g_wc = " 1=2"
      CALL aimt300_browser_fill("")
      CALL aimt300_fetch("")
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
      CALL aimt300_filter_show('imba000')
   CALL aimt300_filter_show('imbadocno')
   CALL aimt300_filter_show('imbadocdt')
   CALL aimt300_filter_show('imba001')
   CALL aimt300_filter_show('imba009')
   CALL aimt300_filter_show('imba003')
   CALL aimt300_filter_show('imba004')
   CALL aimt300_filter_show('imba005')
   CALL aimt300_filter_show('imba006')
   CALL aimt300_filter_show('imba010')
   CALL aimt300_browser_fill("F")
         
   IF g_browser_cnt = 0 THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code = "-100" 
      LET g_errparam.popup = TRUE 
      CALL cl_err()
   ELSE
      CALL aimt300_fetch("F") 
      #顯示單身筆數
      CALL aimt300_idx_chk()
   END IF
 
END FUNCTION
 
{</section>}
 
{<section id="aimt300.fetch" >}
#+ 指定PK後抓取單頭其他資料
PRIVATE FUNCTION aimt300_fetch(p_flag)
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
   
   LET g_imba_m.imbadocno = g_browser[g_current_idx].b_imbadocno
 
   
   #重讀DB,因TEMP有不被更新特性
   EXECUTE aimt300_master_referesh USING g_imba_m.imbadocno INTO g_imba_m.imbadocno,g_imba_m.imbadocdt, 
       g_imba_m.imba000,g_imba_m.imba900,g_imba_m.imba901,g_imba_m.imbastus,g_imba_m.imba001,g_imba_m.imba002, 
       g_imba_m.imba009,g_imba_m.imba003,g_imba_m.imba004,g_imba_m.imba005,g_imba_m.imba006,g_imba_m.imba010, 
       g_imba_m.imba126,g_imba_m.imba127,g_imba_m.imba131,g_imba_m.imba128,g_imba_m.imba129,g_imba_m.imba130, 
       g_imba_m.imba132,g_imba_m.imba133,g_imba_m.imba134,g_imba_m.imba135,g_imba_m.imba136,g_imba_m.imba137, 
       g_imba_m.imba138,g_imba_m.imba139,g_imba_m.imba140,g_imba_m.imba141,g_imba_m.imbaownid,g_imba_m.imbaowndp, 
       g_imba_m.imbacrtid,g_imba_m.imbacrtdp,g_imba_m.imbacrtdt,g_imba_m.imbamodid,g_imba_m.imbamoddt, 
       g_imba_m.imbacnfid,g_imba_m.imbacnfdt,g_imba_m.imba011,g_imba_m.imba012,g_imba_m.imba013,g_imba_m.imba014, 
       g_imba_m.imba142,g_imba_m.imba108,g_imba_m.imba100,g_imba_m.imba109,g_imba_m.imba101,g_imba_m.imba104, 
       g_imba_m.imba105,g_imba_m.imba106,g_imba_m.imba107,g_imba_m.imba124,g_imba_m.imba145,g_imba_m.imba146, 
       g_imba_m.imba016,g_imba_m.imba017,g_imba_m.imba018,g_imba_m.imba019,g_imba_m.imba020,g_imba_m.imba021, 
       g_imba_m.imba022,g_imba_m.imba023,g_imba_m.imba024,g_imba_m.imba025,g_imba_m.imba026,g_imba_m.imba027, 
       g_imba_m.imba028,g_imba_m.imba029,g_imba_m.imba030,g_imba_m.imba031,g_imba_m.imba032,g_imba_m.imba033, 
       g_imba_m.imba034,g_imba_m.imba035,g_imba_m.imba036,g_imba_m.imba037,g_imba_m.imba043,g_imba_m.imba038, 
       g_imba_m.imba041,g_imba_m.imba042,g_imba_m.imba044,g_imba_m.imba122,g_imba_m.imba045,g_imba_m.imba123, 
       g_imba_m.imba900_desc,g_imba_m.imba901_desc,g_imba_m.imba009_desc,g_imba_m.imba003_desc,g_imba_m.imba005_desc, 
       g_imba_m.imba006_desc,g_imba_m.imba010_desc,g_imba_m.imba126_desc,g_imba_m.imba127_desc,g_imba_m.imba131_desc, 
       g_imba_m.imba128_desc,g_imba_m.imba129_desc,g_imba_m.imba132_desc,g_imba_m.imba133_desc,g_imba_m.imba134_desc, 
       g_imba_m.imba135_desc,g_imba_m.imba136_desc,g_imba_m.imba137_desc,g_imba_m.imba138_desc,g_imba_m.imba139_desc, 
       g_imba_m.imba140_desc,g_imba_m.imba141_desc,g_imba_m.imbaownid_desc,g_imba_m.imbaowndp_desc,g_imba_m.imbacrtid_desc, 
       g_imba_m.imbacrtdp_desc,g_imba_m.imbamodid_desc,g_imba_m.imbacnfid_desc,g_imba_m.imba142_desc, 
       g_imba_m.imba018_desc,g_imba_m.imba022_desc,g_imba_m.imba029_desc,g_imba_m.imba032_desc,g_imba_m.imba122_desc, 
       g_imba_m.imba045_desc
   
   #遮罩相關處理
   LET g_imba_m_mask_o.* =  g_imba_m.*
   CALL aimt300_imba_t_mask()
   LET g_imba_m_mask_n.* =  g_imba_m.*
   
   #根據資料狀態切換action狀態
   CALL cl_set_act_visible("statechange,modify,modify_detail,delete,reproduce", TRUE)
   CALL aimt300_set_act_visible()   
   CALL aimt300_set_act_no_visible()
   
   #add-point:fetch段action控制 name="fetch.action_control"
   #mark 151111 ---s---
  #IF g_imba_m.imbastus = 'N'  THEN
  #   CALL cl_set_act_visible("modify,delete", TRUE)
  #ELSE
  #   CALL cl_set_act_visible("modify,delete", FALSE)
  #END IF
   #mark 151111 ---e---
   #end add-point  
   
   
   
   #add-point:fetch結束前 name="fetch.after"
      
   #end add-point
   
   #保存單頭舊值
   LET g_imba_m_t.* = g_imba_m.*
   LET g_imba_m_o.* = g_imba_m.*
   
   LET g_data_owner = g_imba_m.imbaownid      
   LET g_data_dept  = g_imba_m.imbaowndp
   
   #重新顯示   
   CALL aimt300_show()
 
   #應用 a56 樣板自動產生(Version:3)
   #檢查此單據是否需顯示BPM簽核狀況按鈕 
   IF cl_bpm_chk() THEN
      CALL cl_set_act_visible("bpm_status",TRUE)
   ELSE
      CALL cl_set_act_visible("bpm_status",FALSE)
   END IF
 
 
 
 
 
END FUNCTION
 
{</section>}
 
{<section id="aimt300.insert" >}
#+ 資料新增
PRIVATE FUNCTION aimt300_insert()
   #add-point:insert段define(客製用) name="insert.define_customerization"
   
   #end add-point    
   #add-point:insert段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="insert.define"
      
   #end add-point    
   
   #add-point:Function前置處理  name="insert.pre_function"
   
   #end add-point
   
   #清畫面欄位內容
   CLEAR FORM                    
   CALL g_imbj_d.clear()   
   CALL g_imbj2_d.clear()  
   CALL g_imbj3_d.clear()  
   CALL g_imbj4_d.clear()  
 
 
   INITIALIZE g_imba_m.* TO NULL             #DEFAULT 設定
   
   LET g_imbadocno_t = NULL
 
   
   LET g_master_insert = FALSE
   
   #add-point:insert段before name="insert.before"
   
   #end add-point    
   
   CALL s_transaction_begin()
   WHILE TRUE
      #公用欄位給值(單頭)
      #應用 a14 樣板自動產生(Version:5)    
      #公用欄位新增給值  
      LET g_imba_m.imbaownid = g_user
      LET g_imba_m.imbaowndp = g_dept
      LET g_imba_m.imbacrtid = g_user
      LET g_imba_m.imbacrtdp = g_dept 
      LET g_imba_m.imbacrtdt = cl_get_current()
      LET g_imba_m.imbamodid = g_user
      LET g_imba_m.imbamoddt = cl_get_current()
      LET g_imba_m.imbastus = 'N'
 
 
 
 
      #append欄位給值
      
     
      #一般欄位給值
            LET g_imba_m.imba000 = "I"
      LET g_imba_m.imbastus = "N"
      LET g_imba_m.imba004 = "M"
      LET g_imba_m.imba011 = "0"
      LET g_imba_m.imba012 = "Y"
      LET g_imba_m.imba019 = "0"
      LET g_imba_m.imba020 = "0"
      LET g_imba_m.imba021 = "0"
      LET g_imba_m.imba023 = "0"
      LET g_imba_m.imba025 = "0"
      LET g_imba_m.imba027 = "N"
      LET g_imba_m.imba028 = "0"
      LET g_imba_m.imba030 = "0"
      LET g_imba_m.imba031 = "0"
      LET g_imba_m.imba033 = "0"
      LET g_imba_m.imba034 = "1"
      LET g_imba_m.imba036 = "N"
      LET g_imba_m.imba037 = "N"
      LET g_imba_m.imba043 = "N"
      LET g_imba_m.imba038 = "N"
      LET g_imba_m.imba044 = "3"
 
  
      #add-point:單頭預設值 name="insert.default"
      LET g_imba_m.imbadocdt = g_today
      LET g_imba_m.imba142 = g_site
      LET g_imba_m.imba900 = g_user
      LET g_imba_m.imba901 = g_dept
      #add--160511-00040#4 By shiun--(S)
      LET g_imba_m.imba100 = '1'
      LET g_imba_m.imba108 = '1'
      LET g_imba_m.imba109 = '1'
      #add--160511-00040#4 By shiun--(E)
      INITIALIZE g_imba_m_t.* TO NULL
      INITIALIZE g_imba_m_o.* TO NULL
      LET g_imba003_o = ''
      LET g_imba009_o = ''
      CALL aimt300_desc()
      LET g_con = 'N'
      
      CALL aooi360_01_clear_detail()   
      CALL aimt300_01_clear_detail()  
      #end add-point 
      
      #保存單頭舊值(用於資料輸入錯誤還原預設值時使用)
      LET g_imba_m_t.* = g_imba_m.*
      LET g_imba_m_o.* = g_imba_m.*
      
      #顯示狀態(stus)圖片
            #應用 a21 樣板自動產生(Version:3)
	  #根據當下狀態碼顯示圖片
      CASE g_imba_m.imbastus 
         WHEN "N"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/unconfirmed.png")
         WHEN "W"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/signing.png")
         WHEN "A"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/approved.png")
         WHEN "Y"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/confirmed.png")
         WHEN "D"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/withdraw.png")
         WHEN "R"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/rejection.png")
         WHEN "X"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/invalid.png")
         
      END CASE
 
 
 
    
      CALL aimt300_input("a")
      
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
         INITIALIZE g_imba_m.* TO NULL
         INITIALIZE g_imbj_d TO NULL
         INITIALIZE g_imbj2_d TO NULL
         INITIALIZE g_imbj3_d TO NULL
         INITIALIZE g_imbj4_d TO NULL
 
         #add-point:取消新增後 name="insert.cancel"
         
         #end add-point 
         CALL aimt300_show()
         RETURN
      END IF
      
      LET INT_FLAG = 0
      #CALL g_imbj_d.clear()
      #CALL g_imbj2_d.clear()
      #CALL g_imbj3_d.clear()
      #CALL g_imbj4_d.clear()
 
 
      LET g_rec_b = 0
      CALL s_transaction_end('Y','0')
      EXIT WHILE
        
   END WHILE
   
   #根據資料狀態切換action狀態
   CALL cl_set_act_visible("statechange,modify,modify_detail,delete,reproduce", TRUE)
   CALL aimt300_set_act_visible()   
   CALL aimt300_set_act_no_visible()
   
   #將新增的資料併入搜尋條件中
   LET g_imbadocno_t = g_imba_m.imbadocno
 
   
   #組合新增資料的條件
   LET g_add_browse = " imbaent = " ||g_enterprise|| " AND",
                      " imbadocno = '", g_imba_m.imbadocno, "' "
 
                      
   #add-point:組合新增資料的條件後 name="insert.after.add_browse"
   
   #end add-point
      
   #填到最後面
   LET g_current_idx = g_browser.getLength() + 1
   CALL aimt300_browser_fill("")
   
   DISPLAY g_browser_cnt TO FORMONLY.h_count    #總筆數
   DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
   CALL cl_navigator_setting(g_current_idx, g_browser_cnt)
   
   CLOSE aimt300_cl
   
   CALL aimt300_idx_chk()
   
   #撈取異動後的資料(主要是帶出reference)
   EXECUTE aimt300_master_referesh USING g_imba_m.imbadocno INTO g_imba_m.imbadocno,g_imba_m.imbadocdt, 
       g_imba_m.imba000,g_imba_m.imba900,g_imba_m.imba901,g_imba_m.imbastus,g_imba_m.imba001,g_imba_m.imba002, 
       g_imba_m.imba009,g_imba_m.imba003,g_imba_m.imba004,g_imba_m.imba005,g_imba_m.imba006,g_imba_m.imba010, 
       g_imba_m.imba126,g_imba_m.imba127,g_imba_m.imba131,g_imba_m.imba128,g_imba_m.imba129,g_imba_m.imba130, 
       g_imba_m.imba132,g_imba_m.imba133,g_imba_m.imba134,g_imba_m.imba135,g_imba_m.imba136,g_imba_m.imba137, 
       g_imba_m.imba138,g_imba_m.imba139,g_imba_m.imba140,g_imba_m.imba141,g_imba_m.imbaownid,g_imba_m.imbaowndp, 
       g_imba_m.imbacrtid,g_imba_m.imbacrtdp,g_imba_m.imbacrtdt,g_imba_m.imbamodid,g_imba_m.imbamoddt, 
       g_imba_m.imbacnfid,g_imba_m.imbacnfdt,g_imba_m.imba011,g_imba_m.imba012,g_imba_m.imba013,g_imba_m.imba014, 
       g_imba_m.imba142,g_imba_m.imba108,g_imba_m.imba100,g_imba_m.imba109,g_imba_m.imba101,g_imba_m.imba104, 
       g_imba_m.imba105,g_imba_m.imba106,g_imba_m.imba107,g_imba_m.imba124,g_imba_m.imba145,g_imba_m.imba146, 
       g_imba_m.imba016,g_imba_m.imba017,g_imba_m.imba018,g_imba_m.imba019,g_imba_m.imba020,g_imba_m.imba021, 
       g_imba_m.imba022,g_imba_m.imba023,g_imba_m.imba024,g_imba_m.imba025,g_imba_m.imba026,g_imba_m.imba027, 
       g_imba_m.imba028,g_imba_m.imba029,g_imba_m.imba030,g_imba_m.imba031,g_imba_m.imba032,g_imba_m.imba033, 
       g_imba_m.imba034,g_imba_m.imba035,g_imba_m.imba036,g_imba_m.imba037,g_imba_m.imba043,g_imba_m.imba038, 
       g_imba_m.imba041,g_imba_m.imba042,g_imba_m.imba044,g_imba_m.imba122,g_imba_m.imba045,g_imba_m.imba123, 
       g_imba_m.imba900_desc,g_imba_m.imba901_desc,g_imba_m.imba009_desc,g_imba_m.imba003_desc,g_imba_m.imba005_desc, 
       g_imba_m.imba006_desc,g_imba_m.imba010_desc,g_imba_m.imba126_desc,g_imba_m.imba127_desc,g_imba_m.imba131_desc, 
       g_imba_m.imba128_desc,g_imba_m.imba129_desc,g_imba_m.imba132_desc,g_imba_m.imba133_desc,g_imba_m.imba134_desc, 
       g_imba_m.imba135_desc,g_imba_m.imba136_desc,g_imba_m.imba137_desc,g_imba_m.imba138_desc,g_imba_m.imba139_desc, 
       g_imba_m.imba140_desc,g_imba_m.imba141_desc,g_imba_m.imbaownid_desc,g_imba_m.imbaowndp_desc,g_imba_m.imbacrtid_desc, 
       g_imba_m.imbacrtdp_desc,g_imba_m.imbamodid_desc,g_imba_m.imbacnfid_desc,g_imba_m.imba142_desc, 
       g_imba_m.imba018_desc,g_imba_m.imba022_desc,g_imba_m.imba029_desc,g_imba_m.imba032_desc,g_imba_m.imba122_desc, 
       g_imba_m.imba045_desc
   
   
   #遮罩相關處理
   LET g_imba_m_mask_o.* =  g_imba_m.*
   CALL aimt300_imba_t_mask()
   LET g_imba_m_mask_n.* =  g_imba_m.*
   
   #將資料顯示到畫面上
   DISPLAY BY NAME g_imba_m.imbadocno,g_imba_m.oobxl003,g_imba_m.imbadocdt,g_imba_m.imba000,g_imba_m.imba900, 
       g_imba_m.imba900_desc,g_imba_m.imba901,g_imba_m.imba901_desc,g_imba_m.imbastus,g_imba_m.imba001, 
       g_imba_m.imba002,g_imba_m.imbal002,g_imba_m.imbal003,g_imba_m.imbal004,g_imba_m.imba009,g_imba_m.imba009_desc, 
       g_imba_m.imba003,g_imba_m.imba003_desc,g_imba_m.imba004,g_imba_m.imba005,g_imba_m.imba005_desc, 
       g_imba_m.imba006,g_imba_m.imba006_desc,g_imba_m.imba010,g_imba_m.imba010_desc,g_imba_m.imba126, 
       g_imba_m.imba126_desc,g_imba_m.imba127,g_imba_m.imba127_desc,g_imba_m.imba131,g_imba_m.imba131_desc, 
       g_imba_m.imba128,g_imba_m.imba128_desc,g_imba_m.imba129,g_imba_m.imba129_desc,g_imba_m.imba130, 
       g_imba_m.imba132,g_imba_m.imba132_desc,g_imba_m.imba133,g_imba_m.imba133_desc,g_imba_m.imba134, 
       g_imba_m.imba134_desc,g_imba_m.imba135,g_imba_m.imba135_desc,g_imba_m.imba136,g_imba_m.imba136_desc, 
       g_imba_m.imba137,g_imba_m.imba137_desc,g_imba_m.imba138,g_imba_m.imba138_desc,g_imba_m.imba139, 
       g_imba_m.imba139_desc,g_imba_m.imba140,g_imba_m.imba140_desc,g_imba_m.imba141,g_imba_m.imba141_desc, 
       g_imba_m.imbaownid,g_imba_m.imbaownid_desc,g_imba_m.imbaowndp,g_imba_m.imbaowndp_desc,g_imba_m.imbacrtid, 
       g_imba_m.imbacrtid_desc,g_imba_m.imbacrtdp,g_imba_m.imbacrtdp_desc,g_imba_m.imbacrtdt,g_imba_m.imbamodid, 
       g_imba_m.imbamodid_desc,g_imba_m.imbamoddt,g_imba_m.imbacnfid,g_imba_m.imbacnfid_desc,g_imba_m.imbacnfdt, 
       g_imba_m.imba011,g_imba_m.imba012,g_imba_m.imba013,g_imba_m.imba014,g_imba_m.imba142,g_imba_m.imba142_desc, 
       g_imba_m.imba108,g_imba_m.imba100,g_imba_m.imba109,g_imba_m.imba101,g_imba_m.imba104,g_imba_m.imba105, 
       g_imba_m.imba106,g_imba_m.imba107,g_imba_m.imba124,g_imba_m.imba145,g_imba_m.imba146,g_imba_m.imba016, 
       g_imba_m.imba017,g_imba_m.imba018,g_imba_m.imba018_desc,g_imba_m.imba019,g_imba_m.imba020,g_imba_m.imba021, 
       g_imba_m.imba022,g_imba_m.imba022_desc,g_imba_m.imba023,g_imba_m.imba024,g_imba_m.imba025,g_imba_m.imba026, 
       g_imba_m.imba027,g_imba_m.imba028,g_imba_m.imba029,g_imba_m.imba029_desc,g_imba_m.imba030,g_imba_m.imba031, 
       g_imba_m.imba032,g_imba_m.imba032_desc,g_imba_m.imba033,g_imba_m.imba034,g_imba_m.imba035,g_imba_m.imba036, 
       g_imba_m.imba037,g_imba_m.imba043,g_imba_m.imba038,g_imba_m.imba041,g_imba_m.imba042,g_imba_m.imba044, 
       g_imba_m.imba122,g_imba_m.imba122_desc,g_imba_m.imba045,g_imba_m.imba045_desc,g_imba_m.imba123 
 
   
   #add-point:新增結束後 name="insert.after"
   
   #end add-point 
   
   LET g_data_owner = g_imba_m.imbaownid      
   LET g_data_dept  = g_imba_m.imbaowndp
   
   #功能已完成,通報訊息中心
   CALL aimt300_msgcentre_notify('insert')
   
END FUNCTION
 
{</section>}
 
{<section id="aimt300.modify" >}
#+ 資料修改
PRIVATE FUNCTION aimt300_modify()
   #add-point:modify段define(客製用) name="modify.define_customerization"
   
   #end add-point    
   DEFINE l_new_key    DYNAMIC ARRAY OF STRING
   DEFINE l_old_key    DYNAMIC ARRAY OF STRING
   DEFINE l_field_key  DYNAMIC ARRAY OF STRING
   DEFINE l_wc2_table1          STRING
   DEFINE l_wc2_table2   STRING
 
   DEFINE l_wc2_table3   STRING
 
   DEFINE l_wc2_table4   STRING
 
 
 
   #add-point:modify段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="modify.define"
      
   #end add-point    
   
   #add-point:Function前置處理  name="modify.pre_function"
   
   #end add-point
   
   #保存單頭舊值
   LET g_imba_m_t.* = g_imba_m.*
   LET g_imba_m_o.* = g_imba_m.*
   
   IF g_imba_m.imbadocno IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code = "std-00003" 
      LET g_errparam.popup = FALSE 
      CALL cl_err()
      RETURN
   END IF
 
   ERROR ""
  
   LET g_imbadocno_t = g_imba_m.imbadocno
 
   CALL s_transaction_begin()
   
   OPEN aimt300_cl USING g_enterprise,g_imba_m.imbadocno
   IF SQLCA.SQLCODE THEN   #(ver:78)
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "OPEN aimt300_cl:",SQLERRMESSAGE 
      LET g_errparam.code = SQLCA.SQLCODE   #(ver:78)
      LET g_errparam.popup = TRUE 
      CLOSE aimt300_cl
      CALL s_transaction_end('N','0')
      CALL cl_err()
      RETURN
   END IF
 
   #顯示最新的資料
   EXECUTE aimt300_master_referesh USING g_imba_m.imbadocno INTO g_imba_m.imbadocno,g_imba_m.imbadocdt, 
       g_imba_m.imba000,g_imba_m.imba900,g_imba_m.imba901,g_imba_m.imbastus,g_imba_m.imba001,g_imba_m.imba002, 
       g_imba_m.imba009,g_imba_m.imba003,g_imba_m.imba004,g_imba_m.imba005,g_imba_m.imba006,g_imba_m.imba010, 
       g_imba_m.imba126,g_imba_m.imba127,g_imba_m.imba131,g_imba_m.imba128,g_imba_m.imba129,g_imba_m.imba130, 
       g_imba_m.imba132,g_imba_m.imba133,g_imba_m.imba134,g_imba_m.imba135,g_imba_m.imba136,g_imba_m.imba137, 
       g_imba_m.imba138,g_imba_m.imba139,g_imba_m.imba140,g_imba_m.imba141,g_imba_m.imbaownid,g_imba_m.imbaowndp, 
       g_imba_m.imbacrtid,g_imba_m.imbacrtdp,g_imba_m.imbacrtdt,g_imba_m.imbamodid,g_imba_m.imbamoddt, 
       g_imba_m.imbacnfid,g_imba_m.imbacnfdt,g_imba_m.imba011,g_imba_m.imba012,g_imba_m.imba013,g_imba_m.imba014, 
       g_imba_m.imba142,g_imba_m.imba108,g_imba_m.imba100,g_imba_m.imba109,g_imba_m.imba101,g_imba_m.imba104, 
       g_imba_m.imba105,g_imba_m.imba106,g_imba_m.imba107,g_imba_m.imba124,g_imba_m.imba145,g_imba_m.imba146, 
       g_imba_m.imba016,g_imba_m.imba017,g_imba_m.imba018,g_imba_m.imba019,g_imba_m.imba020,g_imba_m.imba021, 
       g_imba_m.imba022,g_imba_m.imba023,g_imba_m.imba024,g_imba_m.imba025,g_imba_m.imba026,g_imba_m.imba027, 
       g_imba_m.imba028,g_imba_m.imba029,g_imba_m.imba030,g_imba_m.imba031,g_imba_m.imba032,g_imba_m.imba033, 
       g_imba_m.imba034,g_imba_m.imba035,g_imba_m.imba036,g_imba_m.imba037,g_imba_m.imba043,g_imba_m.imba038, 
       g_imba_m.imba041,g_imba_m.imba042,g_imba_m.imba044,g_imba_m.imba122,g_imba_m.imba045,g_imba_m.imba123, 
       g_imba_m.imba900_desc,g_imba_m.imba901_desc,g_imba_m.imba009_desc,g_imba_m.imba003_desc,g_imba_m.imba005_desc, 
       g_imba_m.imba006_desc,g_imba_m.imba010_desc,g_imba_m.imba126_desc,g_imba_m.imba127_desc,g_imba_m.imba131_desc, 
       g_imba_m.imba128_desc,g_imba_m.imba129_desc,g_imba_m.imba132_desc,g_imba_m.imba133_desc,g_imba_m.imba134_desc, 
       g_imba_m.imba135_desc,g_imba_m.imba136_desc,g_imba_m.imba137_desc,g_imba_m.imba138_desc,g_imba_m.imba139_desc, 
       g_imba_m.imba140_desc,g_imba_m.imba141_desc,g_imba_m.imbaownid_desc,g_imba_m.imbaowndp_desc,g_imba_m.imbacrtid_desc, 
       g_imba_m.imbacrtdp_desc,g_imba_m.imbamodid_desc,g_imba_m.imbacnfid_desc,g_imba_m.imba142_desc, 
       g_imba_m.imba018_desc,g_imba_m.imba022_desc,g_imba_m.imba029_desc,g_imba_m.imba032_desc,g_imba_m.imba122_desc, 
       g_imba_m.imba045_desc
   
   #檢查是否允許此動作
   IF NOT aimt300_action_chk() THEN
      CALL s_transaction_end('N','0')
      RETURN
   END IF
   
   #遮罩相關處理
   LET g_imba_m_mask_o.* =  g_imba_m.*
   CALL aimt300_imba_t_mask()
   LET g_imba_m_mask_n.* =  g_imba_m.*
   
   
   
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
 
 
 
   
   CALL aimt300_show()
   #add-point:modify段show之後 name="modify.after_show"
   
   #end add-point
   
   #LET g_wc2_table1 = l_wc2_table1
   #LET  g_wc2_table2 = l_wc2_table2 
 
   #LET  g_wc2_table3 = l_wc2_table3 
 
   #LET  g_wc2_table4 = l_wc2_table4 
 
 
 
    
   WHILE TRUE
      LET g_imbadocno_t = g_imba_m.imbadocno
 
      
      #寫入修改者/修改日期資訊(單頭)
      LET g_imba_m.imbamodid = g_user 
LET g_imba_m.imbamoddt = cl_get_current()
LET g_imba_m.imbamodid_desc = cl_get_username(g_imba_m.imbamodid)
      
      #add-point:modify段修改前 name="modify.before_input"
      LET g_imba_m.imbamoddt = cl_get_current()
      LET g_con = 'N'
      #「D抽單 / R已拒絕」狀況碼更改資料後，需還原為「N未確認」
      IF g_imba_m.imbastus MATCHES "[DR]" THEN 
         LET g_imba_m.imbastus = "N"
      END IF
      
      #end add-point
      
      #欄位更改
      LET g_loc = 'n'
      LET g_update = FALSE
      LET g_master_commit = "N"
      CALL aimt300_input("u")
      LET g_loc = 'n'
 
      #add-point:modify段修改後 name="modify.after_input"
            
      #end add-point
      
      IF g_update OR NOT INT_FLAG THEN
         #若有modid跟moddt則進行update
         UPDATE imba_t SET (imbamodid,imbamoddt) = (g_imba_m.imbamodid,g_imba_m.imbamoddt)
          WHERE imbaent = g_enterprise AND imbadocno = g_imbadocno_t
 
      END IF
    
      IF INT_FLAG THEN
         CALL s_transaction_end('N','0')
         LET INT_FLAG = 0
         #若單頭無commit則還原
         IF g_master_commit = "N" THEN
            LET g_imba_m.* = g_imba_m_t.*
            CALL aimt300_show()
         END IF
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = '' 
         LET g_errparam.code = 9001 
         LET g_errparam.popup = FALSE 
         CALL cl_err()
         RETURN
      END IF 
                  
      #若單頭key欄位有變更
      IF g_imba_m.imbadocno != g_imba_m_t.imbadocno
 
      THEN
         CALL s_transaction_begin()
         
         #add-point:單身fk修改前 name="modify.body.b_fk_update"
                  
         #end add-point
         
         #更新單身key值
         UPDATE imbj_t SET imbjdocno = g_imba_m.imbadocno
 
          WHERE imbjent = g_enterprise AND imbjdocno = g_imba_m_t.imbadocno
 
            
         #add-point:單身fk修改中 name="modify.body.m_fk_update"
                  
         #end add-point
 
         CASE
            WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
            #   INITIALIZE g_errparam TO NULL 
            #   LET g_errparam.extend = "imbj_t" 
            #   LET g_errparam.code = "std-00009" 
            #   LET g_errparam.popup = TRUE 
            #   CALL cl_err()
            #   CALL s_transaction_end('N','0')
            #   CONTINUE WHILE
            WHEN SQLCA.SQLCODE #其他錯誤
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "imbj_t:",SQLERRMESSAGE 
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
         
         UPDATE imbl_t
            SET imbldocno = g_imba_m.imbadocno
 
          WHERE imblent = g_enterprise AND
                imbldocno = g_imbadocno_t
 
         #add-point:單身fk修改中 name="modify.body.m_fk_update2"
                  
         #end add-point
         CASE
            WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
            #   INITIALIZE g_errparam TO NULL 
            #   LET g_errparam.extend = "imbl_t" 
            #   LET g_errparam.code = "std-00009" 
            #   LET g_errparam.popup = TRUE 
            #   CALL cl_err()
            #   CALL s_transaction_end('N','0')
            #   CONTINUE WHILE
            WHEN SQLCA.SQLCODE #其他錯誤
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "imbl_t:",SQLERRMESSAGE 
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
         
         UPDATE imbm_t
            SET imbmdocno = g_imba_m.imbadocno
 
          WHERE imbment = g_enterprise AND
                imbmdocno = g_imbadocno_t
 
         #add-point:單身fk修改中 name="modify.body.m_fk_update3"
                  
         #end add-point
         CASE
            WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
            #   INITIALIZE g_errparam TO NULL 
            #   LET g_errparam.extend = "imbm_t" 
            #   LET g_errparam.code = "std-00009" 
            #   LET g_errparam.popup = TRUE 
            #   CALL cl_err()
            #   CALL s_transaction_end('N','0')
            #   CONTINUE WHILE
            WHEN SQLCA.SQLCODE #其他錯誤
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "imbm_t:",SQLERRMESSAGE 
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
         
         UPDATE imbo_t
            SET imbodocno = g_imba_m.imbadocno
 
          WHERE imboent = g_enterprise AND
                imbodocno = g_imbadocno_t
 
         #add-point:單身fk修改中 name="modify.body.m_fk_update4"
                  
         #end add-point
         CASE
            WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
            #   INITIALIZE g_errparam TO NULL 
            #   LET g_errparam.extend = "imbo_t" 
            #   LET g_errparam.code = "std-00009" 
            #   LET g_errparam.popup = TRUE 
            #   CALL cl_err()
            #   CALL s_transaction_end('N','0')
            #   CONTINUE WHILE
            WHEN SQLCA.SQLCODE #其他錯誤
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "imbo_t:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE 
               LET g_errparam.popup = TRUE 
               CALL s_transaction_end('N','0')
               CALL cl_err()
               CONTINUE WHILE
         END CASE
         #add-point:單身fk修改後 name="modify.body.a_fk_update4"
                  
         #end add-point
 
 
         
 
         
         #UPDATE 多語言table key值
         
         
         
         
 
         CALL s_transaction_end('Y','0')
      END IF
    
      EXIT WHILE
   END WHILE
 
   #根據資料狀態切換action狀態
   CALL cl_set_act_visible("statechange,modify,modify_detail,delete,reproduce", TRUE)
   CALL aimt300_set_act_visible()   
   CALL aimt300_set_act_no_visible()
 
   #組合新增資料的條件
   LET g_add_browse = " imbaent = " ||g_enterprise|| " AND",
                      " imbadocno = '", g_imba_m.imbadocno, "' "
 
   #填到對應位置
   CALL aimt300_browser_fill("")
 
   CLOSE aimt300_cl
   
   CALL s_transaction_end('Y','0')
 
   #功能已完成,通報訊息中心
   CALL aimt300_msgcentre_notify('modify')
 
END FUNCTION 
 
{</section>}
 
{<section id="aimt300.input" >}
#+ 資料輸入
PRIVATE FUNCTION aimt300_input(p_cmd)
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
         DEFINE l_arg1           LIKE ooef_t.ooef004  
   DEFINE p_req_data       DYNAMIC ARRAY OF VARCHAR(500)
   DEFINE l_imba003        LIKE imba_t.imba003
   DEFINE l_n1             LIKE type_t.num5
   DEFINE l_imba001        STRING
   DEFINE l_imbal002       STRING
   DEFINE l_imbal003       STRING
   #add--2015/03/16--By shiun--(S)
   DEFINE l_para           LIKE type_t.chr1
   DEFINE l_dlang          LIKE type_t.chr10
   DEFINE l_imbal002_trn   LIKE imbal_t.imbal002
   DEFINE l_imbal003_trn   LIKE imbal_t.imbal003
   DEFINE l_imbal004_trn   LIKE imbal_t.imbal004
   DEFINE l_num            LIKE type_t.num5
   #add--2015/03/16--By shiun--(E)
   DEFINE l_count_chk      LIKE type_t.num5           #15/06/09 Sarah add
   DEFINE l_oofg_return    DYNAMIC ARRAY OF RECORD    #15/06/09 Sarah add
                   oofg019     LIKE oofg_t.oofg019,   #field
                   oofg020     LIKE oofg_t.oofg020    #value
                           END RECORD
                           
   DEFINE l_qty1           LIKE imad_t.imad003   #add by lixiang 2015/12/04
   DEFINE l_qty2           LIKE imad_t.imad005   #add by lixiang 2015/12/04
   DEFINE l_use            LIKE type_t.num5      #add by lixiang 2015/12/04  
   DEFINE  l_sql1          STRING     #160711-00040#14 add
   DEFINE l_success        LIKE type_t.num5     #160711-00040#14 add
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
   DISPLAY BY NAME g_imba_m.imbadocno,g_imba_m.oobxl003,g_imba_m.imbadocdt,g_imba_m.imba000,g_imba_m.imba900, 
       g_imba_m.imba900_desc,g_imba_m.imba901,g_imba_m.imba901_desc,g_imba_m.imbastus,g_imba_m.imba001, 
       g_imba_m.imba002,g_imba_m.imbal002,g_imba_m.imbal003,g_imba_m.imbal004,g_imba_m.imba009,g_imba_m.imba009_desc, 
       g_imba_m.imba003,g_imba_m.imba003_desc,g_imba_m.imba004,g_imba_m.imba005,g_imba_m.imba005_desc, 
       g_imba_m.imba006,g_imba_m.imba006_desc,g_imba_m.imba010,g_imba_m.imba010_desc,g_imba_m.imba126, 
       g_imba_m.imba126_desc,g_imba_m.imba127,g_imba_m.imba127_desc,g_imba_m.imba131,g_imba_m.imba131_desc, 
       g_imba_m.imba128,g_imba_m.imba128_desc,g_imba_m.imba129,g_imba_m.imba129_desc,g_imba_m.imba130, 
       g_imba_m.imba132,g_imba_m.imba132_desc,g_imba_m.imba133,g_imba_m.imba133_desc,g_imba_m.imba134, 
       g_imba_m.imba134_desc,g_imba_m.imba135,g_imba_m.imba135_desc,g_imba_m.imba136,g_imba_m.imba136_desc, 
       g_imba_m.imba137,g_imba_m.imba137_desc,g_imba_m.imba138,g_imba_m.imba138_desc,g_imba_m.imba139, 
       g_imba_m.imba139_desc,g_imba_m.imba140,g_imba_m.imba140_desc,g_imba_m.imba141,g_imba_m.imba141_desc, 
       g_imba_m.imbaownid,g_imba_m.imbaownid_desc,g_imba_m.imbaowndp,g_imba_m.imbaowndp_desc,g_imba_m.imbacrtid, 
       g_imba_m.imbacrtid_desc,g_imba_m.imbacrtdp,g_imba_m.imbacrtdp_desc,g_imba_m.imbacrtdt,g_imba_m.imbamodid, 
       g_imba_m.imbamodid_desc,g_imba_m.imbamoddt,g_imba_m.imbacnfid,g_imba_m.imbacnfid_desc,g_imba_m.imbacnfdt, 
       g_imba_m.imba011,g_imba_m.imba012,g_imba_m.imba013,g_imba_m.imba014,g_imba_m.imba142,g_imba_m.imba142_desc, 
       g_imba_m.imba108,g_imba_m.imba100,g_imba_m.imba109,g_imba_m.imba101,g_imba_m.imba104,g_imba_m.imba105, 
       g_imba_m.imba106,g_imba_m.imba107,g_imba_m.imba124,g_imba_m.imba145,g_imba_m.imba146,g_imba_m.imba016, 
       g_imba_m.imba017,g_imba_m.imba018,g_imba_m.imba018_desc,g_imba_m.imba019,g_imba_m.imba020,g_imba_m.imba021, 
       g_imba_m.imba022,g_imba_m.imba022_desc,g_imba_m.imba023,g_imba_m.imba024,g_imba_m.imba025,g_imba_m.imba026, 
       g_imba_m.imba027,g_imba_m.imba028,g_imba_m.imba029,g_imba_m.imba029_desc,g_imba_m.imba030,g_imba_m.imba031, 
       g_imba_m.imba032,g_imba_m.imba032_desc,g_imba_m.imba033,g_imba_m.imba034,g_imba_m.imba035,g_imba_m.imba036, 
       g_imba_m.imba037,g_imba_m.imba043,g_imba_m.imba038,g_imba_m.imba041,g_imba_m.imba042,g_imba_m.imba044, 
       g_imba_m.imba122,g_imba_m.imba122_desc,g_imba_m.imba045,g_imba_m.imba045_desc,g_imba_m.imba123 
 
   
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
   LET g_forupd_sql = "SELECT imbj002,imbj003,imbj004,imbj005,imbj006 FROM imbj_t WHERE imbjent=? AND  
       imbjdocno=? AND imbj002=? AND imbj003=? FOR UPDATE"
   #add-point:input段define_sql name="input.after_define_sql"
      
   #end add-point 
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE aimt300_bcl CURSOR FROM g_forupd_sql
   
   #add-point:input段define_sql name="input.define_sql2"
      
   #end add-point    
   LET g_forupd_sql = "SELECT imbl002 FROM imbl_t WHERE imblent=? AND imbldocno=? AND imbl002=? FOR  
       UPDATE"
   #add-point:input段define_sql name="input.after_define_sql2"
      
   #end add-point
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE aimt300_bcl2 CURSOR FROM g_forupd_sql
 
   #add-point:input段define_sql name="input.define_sql3"
      
   #end add-point    
   LET g_forupd_sql = "SELECT imbm002,imbm005,imbm003,imbm006,imbm004 FROM imbm_t WHERE imbment=? AND  
       imbmdocno=? AND imbm002=? FOR UPDATE"
   #add-point:input段define_sql name="input.after_define_sql3"
      
   #end add-point
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE aimt300_bcl3 CURSOR FROM g_forupd_sql
 
   #add-point:input段define_sql name="input.define_sql4"
      
   #end add-point    
   LET g_forupd_sql = "SELECT imbo002 FROM imbo_t WHERE imboent=? AND imbodocno=? AND imbo002=? FOR  
       UPDATE"
   #add-point:input段define_sql name="input.after_define_sql4"
      
   #end add-point
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE aimt300_bcl4 CURSOR FROM g_forupd_sql
 
 
   
 
 
   #add-point:input段define_sql name="input.other_sql"
      
   #end add-point 
 
   LET l_allow_insert = cl_auth_detail_input("insert")
   LET l_allow_delete = cl_auth_detail_input("delete")
   LET g_qryparam.state = 'i'
   
   #控制key欄位可否輸入
   CALL aimt300_set_entry(p_cmd)
   #add-point:set_entry後 name="input.after_set_entry"
         LET g_errshow = 1
   #end add-point
   CALL aimt300_set_no_entry(p_cmd)
 
   DISPLAY BY NAME g_imba_m.imbadocno,g_imba_m.imbadocdt,g_imba_m.imba000,g_imba_m.imba900,g_imba_m.imba901, 
       g_imba_m.imbastus,g_imba_m.imba001,g_imba_m.imba002,g_imba_m.imbal002,g_imba_m.imbal003,g_imba_m.imbal004, 
       g_imba_m.imba009,g_imba_m.imba003,g_imba_m.imba004,g_imba_m.imba005,g_imba_m.imba006,g_imba_m.imba010, 
       g_imba_m.imba126,g_imba_m.imba127,g_imba_m.imba131,g_imba_m.imba128,g_imba_m.imba129,g_imba_m.imba130, 
       g_imba_m.imba132,g_imba_m.imba133,g_imba_m.imba134,g_imba_m.imba135,g_imba_m.imba136,g_imba_m.imba137, 
       g_imba_m.imba138,g_imba_m.imba139,g_imba_m.imba140,g_imba_m.imba141,g_imba_m.imba011,g_imba_m.imba012, 
       g_imba_m.imba013,g_imba_m.imba014,g_imba_m.imba142,g_imba_m.imba108,g_imba_m.imba100,g_imba_m.imba109, 
       g_imba_m.imba101,g_imba_m.imba104,g_imba_m.imba105,g_imba_m.imba106,g_imba_m.imba107,g_imba_m.imba124, 
       g_imba_m.imba145,g_imba_m.imba146,g_imba_m.imba016,g_imba_m.imba017,g_imba_m.imba018,g_imba_m.imba019, 
       g_imba_m.imba020,g_imba_m.imba021,g_imba_m.imba022,g_imba_m.imba023,g_imba_m.imba024,g_imba_m.imba025, 
       g_imba_m.imba026,g_imba_m.imba027,g_imba_m.imba028,g_imba_m.imba029,g_imba_m.imba030,g_imba_m.imba031, 
       g_imba_m.imba032,g_imba_m.imba033,g_imba_m.imba034,g_imba_m.imba035,g_imba_m.imba036,g_imba_m.imba037, 
       g_imba_m.imba043,g_imba_m.imba038,g_imba_m.imba041,g_imba_m.imba042,g_imba_m.imba044,g_imba_m.imba122, 
       g_imba_m.imba045,g_imba_m.imba123
   
   LET lb_reproduce = FALSE
   LET l_ac_t = 1
   
   #關閉被遮罩相關欄位輸入, 無法確定USER是否會需要輸入此欄位
   #因此先行關閉, 若有需要可於下方add-point中自行開啟
   CALL cl_mask_set_no_entry()
   
   #add-point:資料輸入前 name="input.before_input"
   #將單身輸入權限放入共用變數給嵌入的子程式用, 若子程式要自己控管, 還是可以從子程式中覆蓋掉值
   LET g_detail_insert = TRUE
   LET g_detail_delete = TRUE    
   #end add-point
   
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
 
{</section>}
 
{<section id="aimt300.input.head" >}
      #單頭段
      INPUT BY NAME g_imba_m.imbadocno,g_imba_m.imbadocdt,g_imba_m.imba000,g_imba_m.imba900,g_imba_m.imba901, 
          g_imba_m.imbastus,g_imba_m.imba001,g_imba_m.imba002,g_imba_m.imbal002,g_imba_m.imbal003,g_imba_m.imbal004, 
          g_imba_m.imba009,g_imba_m.imba003,g_imba_m.imba004,g_imba_m.imba005,g_imba_m.imba006,g_imba_m.imba010, 
          g_imba_m.imba126,g_imba_m.imba127,g_imba_m.imba131,g_imba_m.imba128,g_imba_m.imba129,g_imba_m.imba130, 
          g_imba_m.imba132,g_imba_m.imba133,g_imba_m.imba134,g_imba_m.imba135,g_imba_m.imba136,g_imba_m.imba137, 
          g_imba_m.imba138,g_imba_m.imba139,g_imba_m.imba140,g_imba_m.imba141,g_imba_m.imba011,g_imba_m.imba012, 
          g_imba_m.imba013,g_imba_m.imba014,g_imba_m.imba142,g_imba_m.imba108,g_imba_m.imba100,g_imba_m.imba109, 
          g_imba_m.imba101,g_imba_m.imba104,g_imba_m.imba105,g_imba_m.imba106,g_imba_m.imba107,g_imba_m.imba124, 
          g_imba_m.imba145,g_imba_m.imba146,g_imba_m.imba016,g_imba_m.imba017,g_imba_m.imba018,g_imba_m.imba019, 
          g_imba_m.imba020,g_imba_m.imba021,g_imba_m.imba022,g_imba_m.imba023,g_imba_m.imba024,g_imba_m.imba025, 
          g_imba_m.imba026,g_imba_m.imba027,g_imba_m.imba028,g_imba_m.imba029,g_imba_m.imba030,g_imba_m.imba031, 
          g_imba_m.imba032,g_imba_m.imba033,g_imba_m.imba034,g_imba_m.imba035,g_imba_m.imba036,g_imba_m.imba037, 
          g_imba_m.imba043,g_imba_m.imba038,g_imba_m.imba041,g_imba_m.imba042,g_imba_m.imba044,g_imba_m.imba122, 
          g_imba_m.imba045,g_imba_m.imba123 
         ATTRIBUTE(WITHOUT DEFAULTS)
         
         #自訂ACTION(master_input)
         
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION update_item
            LET g_action_choice="update_item"
            IF cl_auth_chk_act("update_item") THEN
               
               #add-point:ON ACTION update_item name="input.master_input.update_item"
                                       IF NOT cl_null(g_imba_m.imbadocno)  THEN
                  CALL n_imbal(g_imba_m.imbadocno)
                  INITIALIZE g_ref_fields TO NULL
                  LET g_ref_fields[1] = g_imba_m.imbadocno
                  CALL ap_ref_array2(g_ref_fields," SELECT imbal002,imbal003,imbal004 FROM imbal_t WHERE imbalent = '"
                      ||g_enterprise||"' AND imbaldocno = ? AND imbal001 = '"||g_dlang||"'","") RETURNING g_rtn_fields
                  LET g_imba_m.imbal002 = g_rtn_fields[1]
                  LET g_imba_m.imbal003 = g_rtn_fields[2]
                  LET g_imba_m.imbal004 = g_rtn_fields[3]

                  DISPLAY BY NAME g_imba_m.imbal002 
                  DISPLAY BY NAME g_imba_m.imbal003
                  DISPLAY BY NAME g_imba_m.imbal004
               END IF
               #END add-point
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION open_s_carry_query
            LET g_action_choice="open_s_carry_query"
            IF cl_auth_chk_act("open_s_carry_query") THEN
               
               #add-point:ON ACTION open_s_carry_query name="input.master_input.open_s_carry_query"
               #2015/06/30 by stellar add ----- (S)
               IF g_imba_m.imba000 = 'U' AND NOT cl_null(g_imba_m.imba001) THEN
                  LET ga_field[1] = g_imba_m.imba001
                  CALL s_carry_query('1',ga_field)
               END IF
               #2015/06/30 by stellar add ----- (E)
               #END add-point
            END IF
 
 
 
 
     
         BEFORE INPUT
            IF s_transaction_chk("N",0) THEN
               CALL s_transaction_begin()
            END IF
            OPEN aimt300_cl USING g_enterprise,g_imba_m.imbadocno
            IF SQLCA.SQLCODE THEN   #(ver:78)
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "OPEN aimt300_cl:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE   #(ver:78)
               LET g_errparam.popup = TRUE 
               CLOSE aimt300_cl
               CALL s_transaction_end('N','0')
               CALL cl_err()
               RETURN
            END IF
            LET g_master_multi_table_t.imbaldocno = g_imba_m.imbadocno
LET g_master_multi_table_t.imbal002 = g_imba_m.imbal002
LET g_master_multi_table_t.imbal003 = g_imba_m.imbal003
LET g_master_multi_table_t.imbal004 = g_imba_m.imbal004
 
            IF l_cmd_t = 'r' THEN
               LET g_master_multi_table_t.imbaldocno = ''
LET g_master_multi_table_t.imbal002 = ''
LET g_master_multi_table_t.imbal003 = ''
LET g_master_multi_table_t.imbal004 = ''
 
            END IF
            #因應離開單頭後已寫入資料庫, 若重新回到單頭則視為修改
            #因此需於此處開啟/關閉欄位
            CALL aimt300_set_entry(p_cmd)
            #add-point:資料輸入前 name="input.m.before_input"
                        
            #end add-point
            CALL aimt300_set_no_entry(p_cmd)
    
                  #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imbadocno
            #add-point:BEFORE FIELD imbadocno name="input.b.imbadocno"
                        
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imbadocno
            
            #add-point:AFTER FIELD imbadocno name="input.a.imbadocno"
                                    #此段落由子樣板a05產生
            IF NOT cl_null(g_imba_m.imbadocno) THEN
               LET p_req_data[1] = g_imba_m.imbadocno
               CALL s_aimt300_fields_chk('imbadocno',p_req_data,'Y') RETURNING l_success,g_errno
               IF NOT l_success THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = g_errno
                  LET g_errparam.extend = g_imba_m.imbadocno
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  LET g_imba_m.imbadocno = g_imba_m_t.imbadocno
                  DISPLAY g_imba_m.imbadocno TO imbadocno
                  NEXT FIELD imbadocno
               END IF
               IF p_cmd =  'a' OR (p_cmd = 'u' AND g_imba_m.imbadocno <> g_imba_m_t.imbadocno) THEN
                  IF NOT ap_chk_notDup(g_imba_m.imbadocno,"SELECT COUNT(*) FROM imba_t WHERE imbaent = '" ||g_enterprise||"' AND imbadocno = '"|| g_imba_m.imbadocno||"' ","std-00004",0) THEN
                     LET g_imba_m.imbadocno = g_imba_m_t.imbadocno
                     DISPLAY g_imba_m.imbadocno TO imbadocno
                     NEXT FIELD imbadocno
                  END IF
               END IF
               CALL aimt300_get_oobxl003()
               NEXT FIELD imbadocdt
            ELSE
               LET g_imba_m.oobxl003 = ''
               DISPLAY BY NAME g_imba_m.oobxl003
               NEXT FIELD imbadocno
            END IF
           
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE imbadocno
            #add-point:ON CHANGE imbadocno name="input.g.imbadocno"
                        
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imbadocdt
            #add-point:BEFORE FIELD imbadocdt name="input.b.imbadocdt"
                        
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imbadocdt
            
            #add-point:AFTER FIELD imbadocdt name="input.a.imbadocdt"
            #160901-00023#1 ---mark (s)---
            #                        IF NOT cl_null(g_imba_m.imbadocdt) THEN
            #   CALL s_aooi200_gen_docno(g_site,g_imba_m.imbadocno,g_imba_m.imbadocdt,g_prog) RETURNING l_success,g_imba_m.imbadocno
            #   IF NOT l_success THEN
            #      INITIALIZE g_errparam TO NULL
            #      LET g_errparam.code = 'apm-00003'
            #      LET g_errparam.extend = g_imba_m.imbadocdt
            #      LET g_errparam.popup = TRUE
            #      CALL cl_err()
            #
            #      LET g_imba_m.imbadocdt = g_imba_m_t.imbadocdt
            #      DISPLAY g_imba_m.imbadocdt TO imbadocdt
            #      NEXT FIELD imbadocno            
            #   END IF
            #ELSE
            #   NEXT FIELD imbadocdt
            #END IF
            #CALL cl_set_comp_entry("imbadocno",FALSE)
            #CALL cl_set_comp_entry("imbadocdt",FALSE)
            #160901-00023#1 ---mark (e)---
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE imbadocdt
            #add-point:ON CHANGE imbadocdt name="input.g.imbadocdt"
                        
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imba000
            #add-point:BEFORE FIELD imba000 name="input.b.imba000"
                        
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imba000
            
            #add-point:AFTER FIELD imba000 name="input.a.imba000"
            #IF p_cmd = 'a' OR (p_cmd = 'u' AND g_imba_m.imba000 <> g_imba_m_t.imba000) THEN   #160824-00007#266 Mark By Ken 170103 
            IF g_imba_m.imba000 <> g_imba_m_o.imba000 OR cl_null(g_imba_m_o.imba000) THEN   #160824-00007#266 Add By Ken 170103 
               CALL aimt300_chk_imba001()
               IF NOT cl_null(g_errno) THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = g_errno
                  LET g_errparam.extend = g_imba_m.imba000
                  #160318-00005#21  --add--str
                  LET g_errparam.replace[1] ='aimm200'
                  LET g_errparam.replace[2] = cl_get_progname('aimm200',g_lang,"2")
                  LET g_errparam.exeprog    ='aimm200'
                  #160318-00005#21 --add--end
                  LET g_errparam.popup = FALSE
                  CALL cl_err()

                  #LET g_imba_m.imba000 = g_imba_m_t.imba001  #160824-00007#266 Mark By Ken 170103 
                  LET g_imba_m.imba000 = g_imba_m_o.imba001   #160824-00007#266 Add By Ken 170103 
                  NEXT FIELD imba000
               END IF
            END IF
            LET g_imba_m_o.* = g_imba_m.*    #160824-00007#266 Add By Ken 170103 
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE imba000
            #add-point:ON CHANGE imba000 name="input.g.imba000"
                        
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imba900
            
            #add-point:AFTER FIELD imba900 name="input.a.imba900"
                                    DISPLAY "" TO imba900_desc
            IF NOT cl_null(g_imba_m.imba900) THEN
               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
               INITIALIZE g_chkparam.* TO NULL
               LET g_errshow = TRUE #是否開窗 #160318-00025#29  add
               #設定g_chkparam.*的參數
               LET g_chkparam.arg1 = g_imba_m.imba900
               LET g_chkparam.err_str[1] = "aim-00070:sub-01302|aooi130|",cl_get_progname("aooi130",g_lang,"2"),"|:EXEPROGaooi130"  #160318-00025#29  add
               #呼叫檢查存在並帶值的library
               IF NOT cl_chk_exist("v_ooag001") THEN
                  LET g_imba_m.imba900 = g_imba_m_t.imba900
                  CALL aimt300_desc()
                  NEXT FIELD imba900
               END IF
               SELECT ooag003 INTO g_imba_m.imba901 
                 FROM ooag_t
                WHERE ooagent = g_enterprise
                  AND ooag001 = g_imba_m.imba900
            END IF
            CALL aimt300_desc()
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imba900
            #add-point:BEFORE FIELD imba900 name="input.b.imba900"
                        
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE imba900
            #add-point:ON CHANGE imba900 name="input.g.imba900"
                        
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imba901
            
            #add-point:AFTER FIELD imba901 name="input.a.imba901"
                                    DISPLAY "" TO imba901_desc
            IF NOT cl_null(g_imba_m.imba901) THEN
               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
               INITIALIZE g_chkparam.* TO NULL
               LET g_errshow = TRUE #是否開窗 #160318-00025#29  add
               #設定g_chkparam.*的參數
               LET g_chkparam.arg1 = g_imba_m.imba901
               LET g_chkparam.err_str[1] = "aoo-00029:sub-01302|aooi125|",cl_get_progname("aooi125",g_lang,"2"),"|:EXEPROGaooi125"  #160318-00025#29  add
               #呼叫檢查存在並帶值的library
               IF NOT cl_chk_exist("v_ooeg001_3") THEN
                  LET g_imba_m.imba901 = g_imba_m_t.imba901
                  CALL aimt300_desc()
                  NEXT FIELD imba901
               END IF
            END IF
            CALL aimt300_desc()
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imba901
            #add-point:BEFORE FIELD imba901 name="input.b.imba901"
                        
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE imba901
            #add-point:ON CHANGE imba901 name="input.g.imba901"
                        
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imbastus
            #add-point:BEFORE FIELD imbastus name="input.b.imbastus"
                        
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imbastus
            
            #add-point:AFTER FIELD imbastus name="input.a.imbastus"
                        
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE imbastus
            #add-point:ON CHANGE imbastus name="input.g.imbastus"
                        
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imba001
            #add-point:BEFORE FIELD imba001 name="input.b.imba001"
            IF g_imba_m.imba000 = 'I' AND cl_null(g_imba_m.imba001) THEN
               CALL cl_get_para(g_enterprise,g_site,'E-BAS-0012') RETURNING l_sys
               IF l_sys = 'Y' THEN
               
                  #150310---earl---mod---s
                  #CALL s_aooi390('1') RETURNING l_success,g_imba_m.imba001
                  #DISPLAY BY NAME g_imba_m.imba001
                  
                  CALL aimt300_aooi390_default()
                  #150310---earl---mod---e
                  
                  #NEXT FIELD imba001
               END IF
            END IF
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imba001
            
            #add-point:AFTER FIELD imba001 name="input.a.imba001"
            DISPLAY "" TO g_imba_m.imbal002
            DISPLAY "" TO g_imba_m.imbal003
            DISPLAY "" TO g_imba_m.imbal004
            IF NOT cl_null(g_imba_m.imba001) THEN
               #IF p_cmd = 'a' OR (p_cmd = 'u' AND (g_imba_m.imba001 <> g_imba_m_t.imba001 OR cl_null(g_imba_m_t.imba001))) THEN  #mark by lixiang 2015/12/03
               IF g_imba_m.imba001 <> g_imba_m_o.imba001 OR cl_null(g_imba_m_o.imba001) THEN #add by lixiang 2015/12/03
                  CALL aimt300_chk_imba001()
                  IF NOT cl_null(g_errno) THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = g_errno
                     LET g_errparam.extend = g_imba_m.imba001
                     #160318-00005#21  --add--str
                     LET g_errparam.replace[1] ='aimm200'
                     LET g_errparam.replace[2] = cl_get_progname('aimm200',g_lang,"2")
                     LET g_errparam.exeprog    ='aimm200'
                     #160318-00005#21 --add--end
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                     #LET g_imba_m.imba001 = g_imba_m_t.imba001   #mark by lixiang 2015/12/03
                     LET g_imba_m.imba001 = g_imba_m_o.imba001    #add by lixiang 2015/12/03
                     CALL aimt300_desc()
                     NEXT FIELD imba001
                  END IF
                  #add--2015/05/08 By shiun--(S)
                  IF NOT s_aooi390_chk('1',g_imba_m.imba001) THEN
                     #LET g_imba_m.imba001 = g_imba_m_t.imba001   #mark by lixiang 2015/12/03
                     LET g_imba_m.imba001 = g_imba_m_o.imba001    #add by lixiang 2015/12/03
                     DISPLAY BY NAME g_imba_m.imba001
                     NEXT FIELD CURRENT
                  END IF
                  #add--2015/05/08 By shiun--(E)
                  
                  
                  #申請類型為修改時，才從imaa等料件基本資料檔中重新帶出當前料號維護的資料，若是申請類型為新增，無需從imaa等表帶出資料
                  IF g_imba_m.imba000 = 'U' THEN  #add by lixiang 2015/12/03
                     CALL aimt300_imaa_desc()
                     CALL aimt300_imaa_b_fill()
                  END IF         #add by lixiang 2015/12/03
               END IF
               CALL aimt300_set_entry(p_cmd)
               CALL aimt300_set_no_entry(p_cmd)
               
               LET l_imba001 = g_imba_m.imba001
               LET l_n = l_imba001.getLength()
               IF l_n > cl_get_para(g_enterprise,g_site,'E-BAS-0003') THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'aim-00215'
                  LET g_errparam.extend = g_imba_m.imba001
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
                  #LET g_imba_m.imba001 = g_imba_m_t.imba001  #mark by lixiang 2015/12/03
                  LET g_imba_m.imba001 = g_imba_m_o.imba001  #add by lixiang 2015/12/03
                  NEXT FIELD CURRENT
               END IF
            END IF
            CALL aimt300_desc()
            LET g_imba_m_o.imba001 = g_imba_m.imba001  #add by lixiang 2015/12/03
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE imba001
            #add-point:ON CHANGE imba001 name="input.g.imba001"
                        
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imba002
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_imba_m.imba002,"0.000","1","","","azz-00079",1) THEN
               NEXT FIELD imba002
            END IF 
 
 
 
            #add-point:AFTER FIELD imba002 name="input.a.imba002"
                                    IF g_imba_m.imba002 < 0  THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = 'aim-00009'
               LET g_errparam.extend = g_imba_m.imba002
               LET g_errparam.popup = FALSE
               CALL cl_err()

               #LET g_imba_m.imba002 = g_imba_m_t.imba002  #160824-00007#266 Mark By Ken 170103
               LET g_imba_m.imba002 = g_imba_m_o.imba002   #160824-00007#266 Add By Ken 170103
               NEXT FIELD imba002
            END IF
            LET g_imba_m_o.* = g_imba_m.*    #160824-00007#266 Add By Ken 170103 
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imba002
            #add-point:BEFORE FIELD imba002 name="input.b.imba002"
                        
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE imba002
            #add-point:ON CHANGE imba002 name="input.g.imba002"
                        
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imbal002
            #add-point:BEFORE FIELD imbal002 name="input.b.imbal002"
            #add--2015/03/16--By shiun--(S)
            CALL cl_get_para(g_enterprise,g_site,'E-BAS-0017') RETURNING l_para
            IF l_para = 'Y' AND cl_null(g_imba_m.imbal002) THEN
               CALL s_auto_item_desc_auto_no() RETURNING l_success,g_imba_m.imbal002
               IF l_success THEN
                  LET l_num = 0
                  CASE g_dlang
                     WHEN 'zh_TW'
                        LET l_dlang = 'zh_CN'
                     WHEN 'zh_CN'
                        LET l_dlang = 'zh_TW'
                  END CASE
                  CALL cl_trans_code_tw_cn(l_dlang,g_imba_m.imbal002) RETURNING l_imbal002_trn
                  CALL cl_trans_code_tw_cn(l_dlang,g_imba_m.imbal003) RETURNING l_imbal003_trn
                  CALL cl_trans_code_tw_cn(l_dlang,g_imba_m.imbal004) RETURNING l_imbal004_trn
                  SELECT COUNT(*) INTO l_num
                    FROM imbal_t
                   WHERE imbalent = g_enterprise
                     AND imbaldocno = g_imba_m.imbadocno
                     AND imbal001 = l_dlang
                  IF l_num = 0 THEN
                     INSERT INTO imbal_t (imbalent,imbaldocno,imbal001,imbal002,imbal003,imbal004)
                     VALUES(g_enterprise,g_imba_m.imbadocno,l_dlang,l_imbal002_trn,l_imbal003_trn,l_imbal004_trn)
                     IF SQLCA.sqlcode THEN
                        INITIALIZE g_errparam TO NULL 
                        LET g_errparam.extend = "imbal_t" 
                        LET g_errparam.code   = SQLCA.sqlcode 
                        LET g_errparam.popup  = TRUE 
                        CALL cl_err()
                        CALL s_transaction_end('N','0')
                        NEXT FIELD CURRENT
                     END IF
                  ELSE
                     UPDATE imbal_t SET imbal002 = l_imbal002_trn,
                                        imbal003 = l_imbal003_trn,
                                        imbal004 = l_imbal004_trn
                      WHERE imbalent = g_enterprise 
                        AND imbaldocno = g_imba_m.imbadocno
                        AND imbal001 = l_dlang
                        
                     IF SQLCA.sqlcode THEN
                        INITIALIZE g_errparam TO NULL 
                        LET g_errparam.extend = "imbal_t" 
                        LET g_errparam.code   = SQLCA.sqlcode 
                        LET g_errparam.popup  = TRUE 
                        CALL cl_err()
                        CALL s_transaction_end('N','0')
                        NEXT FIELD CURRENT
                     END IF
                  END IF
               END IF
            END IF
            #add--2015/03/16--By shiun--(E)
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imbal002
            
            #add-point:AFTER FIELD imbal002 name="input.a.imbal002"
            IF NOT cl_null(g_imba_m.imbal002) THEN 
               LET l_imbal002 = g_imba_m.imbal002
               LET l_n = l_imbal002.getLength()
               IF l_n > cl_get_para(g_enterprise,g_site,'E-BAS-0006') THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'aim-00216'
                  LET g_errparam.extend = g_imba_m.imbal002
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  LET g_imba_m.imbal002 = g_imba_m_t.imbal002
                  NEXT FIELD CURRENT
               END IF
            END IF            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE imbal002
            #add-point:ON CHANGE imbal002 name="input.g.imbal002"
                        
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imbal003
            #add-point:BEFORE FIELD imbal003 name="input.b.imbal003"
            #add--2015/03/16--By shiun--(S)
            CALL cl_get_para(g_enterprise,g_site,'E-BAS-0027') RETURNING l_para
            IF l_para = 'Y' AND cl_null(g_imba_m.imbal003) THEN
               CALL s_auto_item_spec_auto_no() RETURNING l_success,g_imba_m.imbal003
               IF l_success THEN
                  LET l_num = 0
                  CASE g_dlang
                     WHEN 'zh_TW'
                        LET l_dlang = 'zh_CN'
                     WHEN 'zh_CN'
                        LET l_dlang = 'zh_TW'
                  END CASE
                  CALL cl_trans_code_tw_cn(l_dlang,g_imba_m.imbal002) RETURNING l_imbal002_trn
                  CALL cl_trans_code_tw_cn(l_dlang,g_imba_m.imbal003) RETURNING l_imbal003_trn
                  CALL cl_trans_code_tw_cn(l_dlang,g_imba_m.imbal004) RETURNING l_imbal004_trn
                  SELECT COUNT(*) INTO l_num
                    FROM imbal_t
                   WHERE imbalent = g_enterprise
                     AND imbaldocno = g_imba_m.imbadocno
                     AND imbal001 = l_dlang
                  IF l_num = 0 THEN
                     INSERT INTO imbal_t (imbalent,imbaldocno,imbal001,imbal002,imbal003,imbal004)
                     VALUES(g_enterprise,g_imba_m.imbadocno,l_dlang,l_imbal002_trn,l_imbal003_trn,l_imbal004_trn)
                     IF SQLCA.sqlcode THEN
                        INITIALIZE g_errparam TO NULL 
                        LET g_errparam.extend = "imbal_t" 
                        LET g_errparam.code   = SQLCA.sqlcode 
                        LET g_errparam.popup  = TRUE 
                        CALL cl_err()
                        CALL s_transaction_end('N','0')
                        NEXT FIELD CURRENT
                     END IF
                  ELSE
                     UPDATE imbal_t SET imbal002 = l_imbal002_trn,
                                        imbal003 = l_imbal003_trn,
                                        imbal004 = l_imbal004_trn
                      WHERE imbalent = g_enterprise 
                        AND imbaldocno = g_imba_m.imbadocno
                        AND imbal001 = l_dlang
                        
                     IF SQLCA.sqlcode THEN
                        INITIALIZE g_errparam TO NULL 
                        LET g_errparam.extend = "imbal_t" 
                        LET g_errparam.code   = SQLCA.sqlcode 
                        LET g_errparam.popup  = TRUE 
                        CALL cl_err()
                        CALL s_transaction_end('N','0')
                        NEXT FIELD CURRENT
                     END IF
                  END IF
               END IF
            END IF
            #add--2015/03/16--By shiun--(E)
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imbal003
            
            #add-point:AFTER FIELD imbal003 name="input.a.imbal003"
            IF NOT cl_null(g_imba_m.imbal003) THEN 
               LET l_imbal003 = g_imba_m.imbal003
               LET l_n = l_imbal003.getLength()
               IF l_n > cl_get_para(g_enterprise,g_site,'E-BAS-0007') THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'aim-00217'
                  LET g_errparam.extend = g_imba_m.imbal003
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  LET g_imba_m.imbal003 = g_imba_m_t.imbal003
                  NEXT FIELD CURRENT
               END IF
            END IF            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE imbal003
            #add-point:ON CHANGE imbal003 name="input.g.imbal003"
                        
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imbal004
            #add-point:BEFORE FIELD imbal004 name="input.b.imbal004"
                        
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imbal004
            
            #add-point:AFTER FIELD imbal004 name="input.a.imbal004"
                        
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE imbal004
            #add-point:ON CHANGE imbal004 name="input.g.imbal004"
                        
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imba009
            
            #add-point:AFTER FIELD imba009 name="input.a.imba009"
                                    DISPLAY "" TO g_imba_m.imba009_desc
            IF NOT cl_null(g_imba_m.imba009) THEN 
               CALL aimt300_desc()
               LET p_req_data[1] = g_imba_m.imba009
               CALL s_aimt300_fields_chk('imba009',p_req_data,'Y') RETURNING l_success,g_errno
               IF NOT l_success THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = g_errno
                  LET g_errparam.extend = g_imba_m.imba009
                  #160321-00016#32 --s add
                  LET g_errparam.replace[1] = 'arti202'
                  LET g_errparam.replace[2] = cl_get_progname('arti202',g_lang,"2")
                  LET g_errparam.exeprog = 'arti202'
                  #160321-00016#32 --e add
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  #LET g_imba_m.imba009 = g_imba_m_t.imba009  #160824-00007#266 Mark By Ken 170103
                  LET g_imba_m.imba009 = g_imba_m_o.imba009   #160824-00007#266 Add By Ken 170103
                  CALL aimt300_desc()
                  NEXT FIELD imba009
               END IF
               #2015/05/20 by stellar modify ----- (S)
#               IF g_imba_m.imba009 <> g_imba009_o THEN
               IF cl_null(g_imba009_o) OR g_imba_m.imba009 <> g_imba009_o THEN
               #2015/05/20 by stellar modify ----- (E)
                  SELECT rtax007 INTO g_imba_m.imba003 
                    FROM rtax_t
                   WHERE rtax001 = g_imba_m.imba009
                     AND rtaxent = g_enterprise
                  DISPLAY BY NAME g_imba_m.imba003
               END IF
               CALL aimt300_ask(p_cmd,g_imba_m.imba000,g_imba_m.imba003,g_imba_m_t.imba003,g_imba003_o)
            END IF
            LET g_imba003_o = g_imba_m.imba003
            LET g_imba009_o = g_imba_m.imba009
            CALL aimt300_desc()
            LET g_imba_m_o.* = g_imba_m.*    #160824-00007#266 Add By Ken 170103 
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imba009
            #add-point:BEFORE FIELD imba009 name="input.b.imba009"
                        
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE imba009
            #add-point:ON CHANGE imba009 name="input.g.imba009"
                        
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imba003
            
            #add-point:AFTER FIELD imba003 name="input.a.imba003"
            DISPLAY "" TO g_imba_m.imba003_desc
            IF NOT cl_null(g_imba_m.imba003) THEN     
               LET p_req_data[1] = g_imba_m.imba003
               CALL s_aimt300_fields_chk('imba003',p_req_data,'Y') RETURNING l_success,g_errno
               IF NOT l_success THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = g_errno
                  LET g_errparam.extend = g_imba_m.imba003
                  #160321-00016#32 --s add
                  LET g_errparam.replace[1] = 'aimi100'
                  LET g_errparam.replace[2] = cl_get_progname('aimi100',g_lang,"2")
                  LET g_errparam.exeprog = 'aimi100'
                  #160321-00016#32 --e add
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  #LET g_imba_m.imba003 = g_imba_m_t.imba003  #160824-00007#266 Mark By Ken 170103
                  LET g_imba_m.imba003 = g_imba_m_o.imba003   #160824-00007#266 Add By Ken 170103
                  CALL aimt300_desc()
                  NEXT FIELD imba003
               END IF
               CALL aimt300_ask(p_cmd,g_imba_m.imba000,g_imba_m.imba003,g_imba_m_t.imba003,g_imba003_o)
            END IF
            LET g_imba003_o = g_imba_m.imba003
            CALL aimt300_desc()
            LET g_imba_m_o.* = g_imba_m.*    #160824-00007#266 Add By Ken 170103 
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imba003
            #add-point:BEFORE FIELD imba003 name="input.b.imba003"
                        
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE imba003
            #add-point:ON CHANGE imba003 name="input.g.imba003"
                        
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imba004
            #add-point:BEFORE FIELD imba004 name="input.b.imba004"
                        
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imba004
            
            #add-point:AFTER FIELD imba004 name="input.a.imba004"
                        
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE imba004
            #add-point:ON CHANGE imba004 name="input.g.imba004"
                        
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imba005
            
            #add-point:AFTER FIELD imba005 name="input.a.imba005"
                                    DISPLAY "" TO imba005_desc
            IF NOT cl_null(g_imba_m.imba005) THEN          
               LET p_req_data[1] = g_imba_m.imba005
               CALL s_aimt300_fields_chk('imba005',p_req_data,'N') RETURNING l_success,g_errno
               IF NOT l_success THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = g_errno
                  LET g_errparam.extend = g_imba_m.imba005
                  #160321-00016#32 --s add
                  LET g_errparam.replace[1] = 'aimi092'
                  LET g_errparam.replace[2] = cl_get_progname('aimi092',g_lang,"2")
                  LET g_errparam.exeprog = 'aimi092'
                  #160321-00016#32 --e add
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  LET g_imba_m.imba005 = g_imba_m_o.imba005
                  CALL aimt300_desc()
                  NEXT FIELD imba005
               END IF
               IF p_cmd = 'u' AND g_imba_m.imba005 <> g_imba_m_o.imba005 THEN
                  DELETE FROM imbk_t WHERE imbkent = g_enterprise AND imbkdocno = g_imba_m.imbadocno
               END IF
               IF p_cmd = 'a' OR (p_cmd = 'u' AND (cl_null(g_imba_m_o.imba005) OR g_imba_m.imba005 <> g_imba_m_o.imba005)) THEN
                  IF NOT aimt300_ins_imbk() THEN
                     LET g_imba_m.imba005 = g_imba_m_o.imba005
                     CALL aimt300_desc()
                     NEXT FIELD imba005
                  END IF
                  LET l_n = 0
                  SELECT COUNT(*) INTO l_n FROM imbk_t WHERE imbkent = g_enterprise AND imbkdocno = g_imba_m.imbadocno
                  IF l_n > 0 THEN
                     CALL aimt300_01(g_imba_m.imbadocno,g_imba_m.imba001,g_imba_m.imba005)
                  END IF

               END IF
            #141231-00009#1---add---begin---    
            ELSE
               CALL aimt300_01_clear_detail()
               DELETE FROM imbk_t WHERE imbkent = g_enterprise AND imbkdocno = g_imba_m.imbadocno
               LET g_imbadocno_d = g_imba_m.imbadocno
               CALL aimt300_01_b_fill(g_imbadocno_d)
            END IF
            #141231-00009#1---add---end---    
            LET g_imba_m_o.imba005 = g_imba_m.imba005
            CALL aimt300_desc()
            LET g_imba_m_o.* = g_imba_m.*    #160824-00007#266 Add By Ken 170103 
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imba005
            #add-point:BEFORE FIELD imba005 name="input.b.imba005"
                        
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE imba005
            #add-point:ON CHANGE imba005 name="input.g.imba005"
                        
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imba006
            
            #add-point:AFTER FIELD imba006 name="input.a.imba006"
            DISPLAY "" TO g_imba_m.imba006_desc
            IF NOT cl_null(g_imba_m.imba006) THEN 
               CALL aimt300_desc()
               LET p_req_data[1] = g_imba_m.imba006
               CALL s_aimt300_fields_chk('imba006',p_req_data,'Y') RETURNING l_success,g_errno
               IF NOT l_success THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = g_errno
                  LET g_errparam.extend = g_imba_m.imba006
                  #160321-00016#32 --s add
                  LET g_errparam.replace[1] = 'aooi250'
                  LET g_errparam.replace[2] = cl_get_progname('aooi250',g_lang,"2")
                  LET g_errparam.exeprog = 'aooi250'
                  #160321-00016#32 --e add
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  #LET g_imba_m.imba006 = g_imba_m_t.imba006  #160824-00007#266 Mark By Ken 170103
                  LET g_imba_m.imba006 = g_imba_m_o.imba006   #160824-00007#266 Add By Ken 170103
                  CALL aimt300_desc()
                  NEXT FIELD imba006
               END IF
               
               #add by lixiang 2015/12/04--begin---
               #單位修改時判斷，當前料號是否有在單據作業中使用，若有，則需判斷當前維護的單位與舊值單位是否存在換算
               #資料類型為修改時，且料號不為空才進行判斷，
               #IF g_imba_m.imba000 = 'U' AND (NOT cl_null(g_imba_m.imba001)) AND g_imba_m.imba006 <> g_imba_m_t.imba006 THEN   #160824-00007#266 Mark By Ken 170103
               IF g_imba_m.imba000 = 'U' AND (NOT cl_null(g_imba_m.imba001)) AND (g_imba_m.imba006 <> g_imba_m_o.imba006 OR cl_null(g_imba_m_o.imba006)) THEN    #160824-00007#266 Add By Ken 170103
                  #CALL s_azzi610_check('1',g_imba_m.imba001) RETURNING l_success,l_use  #160816-00042#1
                  CALL s_azzi610_check('1',g_imba_m.imba001,'') RETURNING l_success,l_use  #160816-00042#1
                  #該料號已使用
                  IF l_use THEN
                     #CALL s_aimi190_get_convert1(g_imba_m.imba001,g_imba_m.imba006,g_imba_m_t.imba006) RETURNING l_success,l_qty1,l_qty2   #160824-00007#266 Mark By Ken 170103
                     CALL s_aimi190_get_convert1(g_imba_m.imba001,g_imba_m.imba006,g_imba_m_o.imba006) RETURNING l_success,l_qty1,l_qty2    #160824-00007#266 Add By Ken 170103
                     IF NOT l_success THEN
                        #160824-00007#266 Mark By Ken 170103(S)
                        #LET g_imba_m.imba006 = g_imba_m_t.imba006
                        #LET g_imba_m.imba006_desc = g_imba_m_t.imba006_desc
                        #160824-00007#266 Mark By Ken 170103(E)
                        #160824-00007#266 Add By Ken 170103(S)
                        LET g_imba_m.imba006 = g_imba_m_o.imba006
                        LET g_imba_m.imba006_desc = g_imba_m_o.imba006_desc                        
                        #160824-00007#266 Add By Ken 170103(E)
                        DISPLAY BY NAME g_imba_m_t.imba006_desc
                        NEXT FIELD imba006
                     END IF
                  END IF
               END IF
               #add by lixiang 2015/12/04--end-----
            END IF
            CALL aimt300_desc()
            #161004-00020#1--add--start--
            LET g_imba_m.imba146 = g_imba_m.imba006
            DISPLAY BY NAME g_imba_m.imba146
            #161004-00020#1--add--end----
            LET g_imba_m_o.* = g_imba_m.*    #160824-00007#266 Add By Ken 170103 
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imba006
            #add-point:BEFORE FIELD imba006 name="input.b.imba006"
                        
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE imba006
            #add-point:ON CHANGE imba006 name="input.g.imba006"
                        
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imba010
            
            #add-point:AFTER FIELD imba010 name="input.a.imba010"
                                    DISPLAY "" TO g_imba_m.imba010_desc
            IF NOT cl_null(g_imba_m.imba010) THEN 
               CALL aimt300_desc()
               LET p_req_data[1] = 210
               LET p_req_data[2] = g_imba_m.imba010
               CALL s_aimt300_fields_chk('ACC',p_req_data,'Y') RETURNING l_success,g_errno
               IF NOT l_success THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = g_errno
                  LET g_errparam.extend = g_imba_m.imba010
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  #LET g_imba_m.imba010 = g_imba_m_t.imba010  #160824-00007#266 Mark By Ken 170103
                  LET g_imba_m.imba010 = g_imba_m_o.imba010   #160824-00007#266 Add By Ken 170103
                  CALL aimt300_desc()
                  NEXT FIELD imba010
               END IF
            END IF
            CALL aimt300_desc()
            LET g_imba_m_o.* = g_imba_m.*    #160824-00007#266 Add By Ken 170103 
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imba010
            #add-point:BEFORE FIELD imba010 name="input.b.imba010"
                        
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE imba010
            #add-point:ON CHANGE imba010 name="input.g.imba010"
                        
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imba126
            
            #add-point:AFTER FIELD imba126 name="input.a.imba126"
            #141231-00009#1--add--begin----
            CALL s_desc_get_acc_desc('2002',g_imba_m.imba126) RETURNING g_imba_m.imba126_desc
            DISPLAY BY NAME g_imba_m.imba126_desc
            #141231-00009#1--add--end----
            IF NOT cl_null(g_imba_m.imba126) THEN 
               LET p_req_data[1] = 2002
               LET p_req_data[2] = g_imba_m.imba126
               CALL s_aimt300_fields_chk('ACC',p_req_data,'Y') RETURNING l_success,g_errno
               IF NOT l_success THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = g_errno
                  LET g_errparam.extend = g_imba_m.imba126
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
                  LET g_imba_m.imba126 = g_imba_m_t.imba126
                  #141231-00009#1--add--begin----
                  CALL s_desc_get_acc_desc('2002',g_imba_m.imba126) RETURNING g_imba_m.imba126_desc
                  DISPLAY BY NAME g_imba_m.imba126_desc
                  #141231-00009#1--add--end----
                  NEXT FIELD imba126
               END IF
            END IF
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imba126
            #add-point:BEFORE FIELD imba126 name="input.b.imba126"
                        
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE imba126
            #add-point:ON CHANGE imba126 name="input.g.imba126"
                        
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imba127
            
            #add-point:AFTER FIELD imba127 name="input.a.imba127"
            #141231-00009#1--add--begin----
            CALL s_desc_get_acc_desc('2003',g_imba_m.imba127) RETURNING g_imba_m.imba127_desc
            DISPLAY BY NAME g_imba_m.imba127_desc
            #141231-00009#1--add--end----
            IF NOT cl_null(g_imba_m.imba127) THEN 
               LET p_req_data[1] = 2003
               LET p_req_data[2] = g_imba_m.imba127
               CALL s_aimt300_fields_chk('ACC',p_req_data,'Y') RETURNING l_success,g_errno
               IF NOT l_success THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = g_errno
                  LET g_errparam.extend = g_imba_m.imba127
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
                  LET g_imba_m.imba127 = g_imba_m_t.imba127
                  #141231-00009#1--add--begin----
                  CALL s_desc_get_acc_desc('2003',g_imba_m.imba127) RETURNING g_imba_m.imba127_desc
                  DISPLAY BY NAME g_imba_m.imba127_desc
                  #141231-00009#1--add--end----
                  NEXT FIELD imba127
               END IF
            END IF
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imba127
            #add-point:BEFORE FIELD imba127 name="input.b.imba127"
                        
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE imba127
            #add-point:ON CHANGE imba127 name="input.g.imba127"
                        
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imba131
            
            #add-point:AFTER FIELD imba131 name="input.a.imba131"
            #141231-00009#1--add--begin----
            CALL s_desc_get_acc_desc('2001',g_imba_m.imba131) RETURNING g_imba_m.imba131_desc
            DISPLAY BY NAME g_imba_m.imba131_desc
            #141231-00009#1--add--end----
            IF NOT cl_null(g_imba_m.imba131) THEN 
               LET p_req_data[1] = 2001
               LET p_req_data[2] = g_imba_m.imba131
               CALL s_aimt300_fields_chk('ACC',p_req_data,'Y') RETURNING l_success,g_errno
               IF NOT l_success THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = g_errno
                  LET g_errparam.extend = g_imba_m.imba131
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
                  LET g_imba_m.imba131 = g_imba_m_t.imba131
                  #141231-00009#1--add--begin----
                  CALL s_desc_get_acc_desc('2001',g_imba_m.imba131) RETURNING g_imba_m.imba131_desc
                  DISPLAY BY NAME g_imba_m.imba131_desc
                  #141231-00009#1--add--end----
                  NEXT FIELD imba131
               END IF
            END IF
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imba131
            #add-point:BEFORE FIELD imba131 name="input.b.imba131"
                        
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE imba131
            #add-point:ON CHANGE imba131 name="input.g.imba131"
                        
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imba128
            
            #add-point:AFTER FIELD imba128 name="input.a.imba128"
            #141231-00009#1--add--begin----
            CALL s_desc_get_acc_desc('2004',g_imba_m.imba128) RETURNING g_imba_m.imba128_desc
            DISPLAY BY NAME g_imba_m.imba128_desc
            #141231-00009#1--add--end----
            IF NOT cl_null(g_imba_m.imba128) THEN 
               LET p_req_data[1] = 2004
               LET p_req_data[2] = g_imba_m.imba128
               CALL s_aimt300_fields_chk('ACC',p_req_data,'Y') RETURNING l_success,g_errno
               IF NOT l_success THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = g_errno
                  LET g_errparam.extend = g_imba_m.imba128
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
                  LET g_imba_m.imba128 = g_imba_m_t.imba128
                  #141231-00009#1--add--begin----
                  CALL s_desc_get_acc_desc('2004',g_imba_m.imba128) RETURNING g_imba_m.imba128_desc
                  DISPLAY BY NAME g_imba_m.imba128_desc
                  #141231-00009#1--add--end----
                  NEXT FIELD imba128
               END IF
            END IF
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imba128
            #add-point:BEFORE FIELD imba128 name="input.b.imba128"
                        
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE imba128
            #add-point:ON CHANGE imba128 name="input.g.imba128"
                        
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imba129
            
            #add-point:AFTER FIELD imba129 name="input.a.imba129"
            #141231-00009#1--add--begin----
            CALL s_desc_get_acc_desc('2005',g_imba_m.imba129) RETURNING g_imba_m.imba129_desc
            DISPLAY BY NAME g_imba_m.imba129_desc
            #141231-00009#1--add--end----
            IF NOT cl_null(g_imba_m.imba129) THEN 
               LET p_req_data[1] = 2005
               LET p_req_data[2] = g_imba_m.imba129
               CALL s_aimt300_fields_chk('ACC',p_req_data,'Y') RETURNING l_success,g_errno
               IF NOT l_success THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = g_errno
                  LET g_errparam.extend = g_imba_m.imba129
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
                  LET g_imba_m.imba129 = g_imba_m_t.imba129
                  #141231-00009#1--add--begin----
                  CALL s_desc_get_acc_desc('2005',g_imba_m.imba129) RETURNING g_imba_m.imba129_desc
                  DISPLAY BY NAME g_imba_m.imba129_desc
                  #141231-00009#1--add--end----
                  NEXT FIELD imba129
               END IF
            END IF
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imba129
            #add-point:BEFORE FIELD imba129 name="input.b.imba129"
                        
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE imba129
            #add-point:ON CHANGE imba129 name="input.g.imba129"
                        
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imba130
            #add-point:BEFORE FIELD imba130 name="input.b.imba130"
                        
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imba130
            
            #add-point:AFTER FIELD imba130 name="input.a.imba130"
                        
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE imba130
            #add-point:ON CHANGE imba130 name="input.g.imba130"
                        
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imba132
            
            #add-point:AFTER FIELD imba132 name="input.a.imba132"
            #141231-00009#1--add--begin----
            CALL s_desc_get_acc_desc('2006',g_imba_m.imba132) RETURNING g_imba_m.imba132_desc
            DISPLAY BY NAME g_imba_m.imba132_desc
            #141231-00009#1--add--end----
            IF NOT cl_null(g_imba_m.imba132) THEN 
               LET p_req_data[1] = 2006
               LET p_req_data[2] = g_imba_m.imba132
               CALL s_aimt300_fields_chk('ACC',p_req_data,'Y') RETURNING l_success,g_errno
               IF NOT l_success THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = g_errno
                  LET g_errparam.extend = g_imba_m.imba132
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
                  LET g_imba_m.imba132 = g_imba_m_t.imba132
                  #141231-00009#1--add--begin----
                  CALL s_desc_get_acc_desc('2006',g_imba_m.imba132) RETURNING g_imba_m.imba132_desc
                  DISPLAY BY NAME g_imba_m.imba132_desc
                  #141231-00009#1--add--end----
                  NEXT FIELD imba132
               END IF
            END IF
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imba132
            #add-point:BEFORE FIELD imba132 name="input.b.imba132"
                        
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE imba132
            #add-point:ON CHANGE imba132 name="input.g.imba132"
                        
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imba133
            
            #add-point:AFTER FIELD imba133 name="input.a.imba133"
            #141231-00009#1--add--begin----
            CALL s_desc_get_acc_desc('2007',g_imba_m.imba133) RETURNING g_imba_m.imba133_desc
            DISPLAY BY NAME g_imba_m.imba133_desc
            #141231-00009#1--add--end----
            IF NOT cl_null(g_imba_m.imba133) THEN 
               LET p_req_data[1] = 2007
               LET p_req_data[2] = g_imba_m.imba133
               CALL s_aimt300_fields_chk('ACC',p_req_data,'Y') RETURNING l_success,g_errno
               IF NOT l_success THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = g_errno
                  LET g_errparam.extend = g_imba_m.imba133
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
                  LET g_imba_m.imba133 = g_imba_m_t.imba133
                  #141231-00009#1--add--begin----
                  CALL s_desc_get_acc_desc('2007',g_imba_m.imba133) RETURNING g_imba_m.imba133_desc
                  DISPLAY BY NAME g_imba_m.imba133_desc
                  #141231-00009#1--add--end----
                  NEXT FIELD imba133
               END IF
            END IF
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imba133
            #add-point:BEFORE FIELD imba133 name="input.b.imba133"
                        
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE imba133
            #add-point:ON CHANGE imba133 name="input.g.imba133"
                        
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imba134
            
            #add-point:AFTER FIELD imba134 name="input.a.imba134"
            #141231-00009#1--add--begin----
            CALL s_desc_get_acc_desc('2008',g_imba_m.imba134) RETURNING g_imba_m.imba134_desc
            DISPLAY BY NAME g_imba_m.imba134_desc
            #141231-00009#1--add--end----
            IF NOT cl_null(g_imba_m.imba134) THEN 
               LET p_req_data[1] = 2008
               LET p_req_data[2] = g_imba_m.imba134
               CALL s_aimt300_fields_chk('ACC',p_req_data,'Y') RETURNING l_success,g_errno
               IF NOT l_success THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = g_errno
                  LET g_errparam.extend = g_imba_m.imba134
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
                  LET g_imba_m.imba134 = g_imba_m_t.imba134
                  #141231-00009#1--add--begin----
                  CALL s_desc_get_acc_desc('2008',g_imba_m.imba134) RETURNING g_imba_m.imba134_desc
                  DISPLAY BY NAME g_imba_m.imba134_desc
                  #141231-00009#1--add--end----
                  NEXT FIELD imba134
               END IF
            END IF
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imba134
            #add-point:BEFORE FIELD imba134 name="input.b.imba134"
                        
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE imba134
            #add-point:ON CHANGE imba134 name="input.g.imba134"
                        
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imba135
            
            #add-point:AFTER FIELD imba135 name="input.a.imba135"
            #141231-00009#1--add--begin----
            CALL s_desc_get_acc_desc('2009',g_imba_m.imba135) RETURNING g_imba_m.imba135_desc
            DISPLAY BY NAME g_imba_m.imba135_desc
            #141231-00009#1--add--end----
            IF NOT cl_null(g_imba_m.imba135) THEN 
               LET p_req_data[1] = 2009
               LET p_req_data[2] = g_imba_m.imba135
               CALL s_aimt300_fields_chk('ACC',p_req_data,'Y') RETURNING l_success,g_errno
               IF NOT l_success THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = g_errno
                  LET g_errparam.extend = g_imba_m.imba135
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  LET g_imba_m.imba135 = g_imba_m_t.imba135
                  #141231-00009#1--add--begin----
                  CALL s_desc_get_acc_desc('2009',g_imba_m.imba135) RETURNING g_imba_m.imba135_desc
                  DISPLAY BY NAME g_imba_m.imba135_desc
                  #141231-00009#1--add--end----
                  NEXT FIELD imba135
               END IF
            END IF
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imba135
            #add-point:BEFORE FIELD imba135 name="input.b.imba135"
                        
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE imba135
            #add-point:ON CHANGE imba135 name="input.g.imba135"
                        
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imba136
            
            #add-point:AFTER FIELD imba136 name="input.a.imba136"
            #141231-00009#1--add--begin----
            CALL s_desc_get_acc_desc('2010',g_imba_m.imba136) RETURNING g_imba_m.imba136_desc
            DISPLAY BY NAME g_imba_m.imba136_desc
            #141231-00009#1--add--end----
            IF NOT cl_null(g_imba_m.imba136) THEN 
               LET p_req_data[1] = 2010
               LET p_req_data[2] = g_imba_m.imba136
               CALL s_aimt300_fields_chk('ACC',p_req_data,'Y') RETURNING l_success,g_errno
               IF NOT l_success THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = g_errno
                  LET g_errparam.extend = g_imba_m.imba136
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  LET g_imba_m.imba136 = g_imba_m_t.imba136
                  #141231-00009#1--add--begin----
                  CALL s_desc_get_acc_desc('2010',g_imba_m.imba136) RETURNING g_imba_m.imba136_desc
                  DISPLAY BY NAME g_imba_m.imba136_desc
                  #141231-00009#1--add--end----
                  NEXT FIELD imba136
               END IF
            END IF
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imba136
            #add-point:BEFORE FIELD imba136 name="input.b.imba136"
                        
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE imba136
            #add-point:ON CHANGE imba136 name="input.g.imba136"
                        
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imba137
            
            #add-point:AFTER FIELD imba137 name="input.a.imba137"
            #141231-00009#1--add--begin----
            CALL s_desc_get_acc_desc('2011',g_imba_m.imba137) RETURNING g_imba_m.imba137_desc
            DISPLAY BY NAME g_imba_m.imba137_desc
            #141231-00009#1--add--end----
            IF NOT cl_null(g_imba_m.imba137) THEN 
               LET p_req_data[1] = 2011
               LET p_req_data[2] = g_imba_m.imba137
               CALL s_aimt300_fields_chk('ACC',p_req_data,'Y') RETURNING l_success,g_errno
               IF NOT l_success THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = g_errno
                  LET g_errparam.extend = g_imba_m.imba137
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  LET g_imba_m.imba137 = g_imba_m_t.imba137
                  #141231-00009#1--add--begin----
                  CALL s_desc_get_acc_desc('2011',g_imba_m.imba137) RETURNING g_imba_m.imba137_desc
                  DISPLAY BY NAME g_imba_m.imba137_desc
                  #141231-00009#1--add--end----
                  NEXT FIELD imba137
               END IF
            END IF
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imba137
            #add-point:BEFORE FIELD imba137 name="input.b.imba137"
                        
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE imba137
            #add-point:ON CHANGE imba137 name="input.g.imba137"
                        
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imba138
            
            #add-point:AFTER FIELD imba138 name="input.a.imba138"
            #141231-00009#1--add--begin----
            CALL s_desc_get_acc_desc('2012',g_imba_m.imba138) RETURNING g_imba_m.imba138_desc
            DISPLAY BY NAME g_imba_m.imba138_desc
            #141231-00009#1--add--end----
            IF NOT cl_null(g_imba_m.imba138) THEN 
               LET p_req_data[1] = 2012
               LET p_req_data[2] = g_imba_m.imba138
               CALL s_aimt300_fields_chk('ACC',p_req_data,'Y') RETURNING l_success,g_errno
               IF NOT l_success THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = g_errno
                  LET g_errparam.extend = g_imba_m.imba138
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  LET g_imba_m.imba138 = g_imba_m_t.imba138
                  #141231-00009#1--add--begin----
                  CALL s_desc_get_acc_desc('2012',g_imba_m.imba138) RETURNING g_imba_m.imba138_desc
                  DISPLAY BY NAME g_imba_m.imba138_desc
                  #141231-00009#1--add--end----
                  NEXT FIELD imba138
               END IF
            END IF
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imba138
            #add-point:BEFORE FIELD imba138 name="input.b.imba138"
                        
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE imba138
            #add-point:ON CHANGE imba138 name="input.g.imba138"
                        
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imba139
            
            #add-point:AFTER FIELD imba139 name="input.a.imba139"
            #141231-00009#1--add--begin----
            CALL s_desc_get_acc_desc('2013',g_imba_m.imba139) RETURNING g_imba_m.imba139_desc
            DISPLAY BY NAME g_imba_m.imba139_desc
            #141231-00009#1--add--end----
            IF NOT cl_null(g_imba_m.imba139) THEN 
               LET p_req_data[1] = 2013
               LET p_req_data[2] = g_imba_m.imba139
               CALL s_aimt300_fields_chk('ACC',p_req_data,'Y') RETURNING l_success,g_errno
               IF NOT l_success THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = g_errno
                  LET g_errparam.extend = g_imba_m.imba139
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  LET g_imba_m.imba139 = g_imba_m_t.imba139
                  #141231-00009#1--add--begin----
                  CALL s_desc_get_acc_desc('2013',g_imba_m.imba139) RETURNING g_imba_m.imba139_desc
                  DISPLAY BY NAME g_imba_m.imba139_desc
                  #141231-00009#1--add--end----
                  NEXT FIELD imba139
               END IF
            END IF
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imba139
            #add-point:BEFORE FIELD imba139 name="input.b.imba139"
                        
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE imba139
            #add-point:ON CHANGE imba139 name="input.g.imba139"
                        
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imba140
            
            #add-point:AFTER FIELD imba140 name="input.a.imba140"
            #141231-00009#1--add--begin----
            CALL s_desc_get_acc_desc('2014',g_imba_m.imba140) RETURNING g_imba_m.imba140_desc
            DISPLAY BY NAME g_imba_m.imba140_desc
            #141231-00009#1--add--end----
            IF NOT cl_null(g_imba_m.imba140) THEN 
               LET p_req_data[1] = 2014
               LET p_req_data[2] = g_imba_m.imba140
               CALL s_aimt300_fields_chk('ACC',p_req_data,'Y') RETURNING l_success,g_errno
               IF NOT l_success THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = g_errno
                  LET g_errparam.extend = g_imba_m.imba140
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  LET g_imba_m.imba140 = g_imba_m_t.imba140
                  #141231-00009#1--add--begin----
                  CALL s_desc_get_acc_desc('2014',g_imba_m.imba140) RETURNING g_imba_m.imba140_desc
                  DISPLAY BY NAME g_imba_m.imba140_desc
                  #141231-00009#1--add--end----
                  NEXT FIELD imba140
               END IF
            END IF
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imba140
            #add-point:BEFORE FIELD imba140 name="input.b.imba140"
                        
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE imba140
            #add-point:ON CHANGE imba140 name="input.g.imba140"
                        
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imba141
            
            #add-point:AFTER FIELD imba141 name="input.a.imba141"
            #141231-00009#1--add--begin----
            CALL s_desc_get_acc_desc('2015',g_imba_m.imba141) RETURNING g_imba_m.imba141_desc
            DISPLAY BY NAME g_imba_m.imba141_desc
            #141231-00009#1--add--end----
            IF NOT cl_null(g_imba_m.imba141) THEN 
               LET p_req_data[1] = 2015
               LET p_req_data[2] = g_imba_m.imba141
               CALL s_aimt300_fields_chk('ACC',p_req_data,'Y') RETURNING l_success,g_errno
               IF NOT l_success THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = g_errno
                  LET g_errparam.extend = g_imba_m.imba141
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  LET g_imba_m.imba141 = g_imba_m_t.imba141
                  #141231-00009#1--add--begin----
                  CALL s_desc_get_acc_desc('2015',g_imba_m.imba141) RETURNING g_imba_m.imba141_desc
                  DISPLAY BY NAME g_imba_m.imba141_desc
                  #141231-00009#1--add--end----
                  NEXT FIELD imba141
               END IF
            END IF
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imba141
            #add-point:BEFORE FIELD imba141 name="input.b.imba141"
                        
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE imba141
            #add-point:ON CHANGE imba141 name="input.g.imba141"
                        
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imba011
            #add-point:BEFORE FIELD imba011 name="input.b.imba011"
                        
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imba011
            
            #add-point:AFTER FIELD imba011 name="input.a.imba011"
                        
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE imba011
            #add-point:ON CHANGE imba011 name="input.g.imba011"
                        
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imba012
            #add-point:BEFORE FIELD imba012 name="input.b.imba012"
                        
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imba012
            
            #add-point:AFTER FIELD imba012 name="input.a.imba012"
                                    IF NOT cl_null(g_imba_m.imba012) THEN 
               LET p_req_data[1] = g_imba_m.imba012
               CALL s_aimt300_fields_chk('imba012',p_req_data,'Y') RETURNING l_success,g_errno
               IF NOT l_success THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = g_errno
                  LET g_errparam.extend = g_imba_m.imba012
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  LET g_imba_m.imba012 = g_imba_m_t.imba012
                  NEXT FIELD imba012
               END IF
            END IF
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE imba012
            #add-point:ON CHANGE imba012 name="input.g.imba012"
                        
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imba013
            #add-point:BEFORE FIELD imba013 name="input.b.imba013"
                        
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imba013
            
            #add-point:AFTER FIELD imba013 name="input.a.imba013"
                        
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE imba013
            #add-point:ON CHANGE imba013 name="input.g.imba013"
                        
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imba014
            #add-point:BEFORE FIELD imba014 name="input.b.imba014"
                        
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imba014
            
            #add-point:AFTER FIELD imba014 name="input.a.imba014"
                        
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE imba014
            #add-point:ON CHANGE imba014 name="input.g.imba014"
                        
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imba142
            
            #add-point:AFTER FIELD imba142 name="input.a.imba142"
                                    IF NOT cl_null(g_imba_m.imba142) THEN 
               LET p_req_data[1] = g_imba_m.imba142
               CALL s_aimt300_fields_chk('imba142',p_req_data,'Y') RETURNING l_success,g_errno
               IF NOT l_success THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = g_errno
                  LET g_errparam.extend = g_imba_m.imba142
                  #160321-00016#32 --s add
                  LET g_errparam.replace[1] = 'aooi125'
                  LET g_errparam.replace[2] = cl_get_progname('aooi125',g_lang,"2")
                  LET g_errparam.exeprog = 'aooi125'
                  #160321-00016#32 --e add
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  LET g_imba_m.imba142 = g_imba_m_t.imba142
                  NEXT FIELD imba142
               END IF
            END IF
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_imba_m.imba142
            CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_imba_m.imba142_desc = g_rtn_fields[1]
            DISPLAY BY NAME g_imba_m.imba142_desc

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imba142
            #add-point:BEFORE FIELD imba142 name="input.b.imba142"
                        
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE imba142
            #add-point:ON CHANGE imba142 name="input.g.imba142"
                        
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imba108
            #add-point:BEFORE FIELD imba108 name="input.b.imba108"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imba108
            
            #add-point:AFTER FIELD imba108 name="input.a.imba108"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE imba108
            #add-point:ON CHANGE imba108 name="input.g.imba108"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imba100
            #add-point:BEFORE FIELD imba100 name="input.b.imba100"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imba100
            
            #add-point:AFTER FIELD imba100 name="input.a.imba100"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE imba100
            #add-point:ON CHANGE imba100 name="input.g.imba100"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imba109
            #add-point:BEFORE FIELD imba109 name="input.b.imba109"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imba109
            
            #add-point:AFTER FIELD imba109 name="input.a.imba109"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE imba109
            #add-point:ON CHANGE imba109 name="input.g.imba109"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imba101
            #add-point:BEFORE FIELD imba101 name="input.b.imba101"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imba101
            
            #add-point:AFTER FIELD imba101 name="input.a.imba101"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE imba101
            #add-point:ON CHANGE imba101 name="input.g.imba101"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imba104
            #add-point:BEFORE FIELD imba104 name="input.b.imba104"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imba104
            
            #add-point:AFTER FIELD imba104 name="input.a.imba104"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE imba104
            #add-point:ON CHANGE imba104 name="input.g.imba104"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imba105
            #add-point:BEFORE FIELD imba105 name="input.b.imba105"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imba105
            
            #add-point:AFTER FIELD imba105 name="input.a.imba105"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE imba105
            #add-point:ON CHANGE imba105 name="input.g.imba105"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imba106
            #add-point:BEFORE FIELD imba106 name="input.b.imba106"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imba106
            
            #add-point:AFTER FIELD imba106 name="input.a.imba106"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE imba106
            #add-point:ON CHANGE imba106 name="input.g.imba106"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imba107
            #add-point:BEFORE FIELD imba107 name="input.b.imba107"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imba107
            
            #add-point:AFTER FIELD imba107 name="input.a.imba107"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE imba107
            #add-point:ON CHANGE imba107 name="input.g.imba107"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imba124
            #add-point:BEFORE FIELD imba124 name="input.b.imba124"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imba124
            
            #add-point:AFTER FIELD imba124 name="input.a.imba124"
            DISPLAY "" TO g_imba_m.imba124  
            IF NOT cl_null(g_imba_m.imba124)THEN
               CALL aimt300_desc()
               IF p_cmd = 'a' OR (p_cmd = 'u' AND (g_imba_m.imba124 != g_imba_m_t.imba124 OR cl_null(g_imba_m_t.imba124))) THEN
                  IF NOT ap_chk_isExist(g_imba_m.imba124,"SELECT COUNT(*) FROM oodc_t WHERE oodcent = '" ||g_enterprise||"' AND oodc001 = ? ","aoo-00157",0) THEN
                     LET g_imba_m.imba124 = g_imba_m_t.imba124
                     CALL aimt300_desc()
                     NEXT FIELD CURRENT
                  END IF
                  IF NOT ap_chk_isExist(g_imba_m.imba124,"SELECT COUNT(*) FROM oodc_t WHERE oodcent = '" ||g_enterprise||"' AND oodc001 = ? AND oodcstus = 'Y' ","aoo-00158",0) THEN
                     LET g_imba_m.imba124 = g_imba_m_t.imba124
                     CALL aimt300_desc()
                     NEXT FIELD CURRENT
                  END IF
               END IF 
            END IF
            
            CALL aimt300_desc()

            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE imba124
            #add-point:ON CHANGE imba124 name="input.g.imba124"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imba145
            #add-point:BEFORE FIELD imba145 name="input.b.imba145"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imba145
            
            #add-point:AFTER FIELD imba145 name="input.a.imba145"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE imba145
            #add-point:ON CHANGE imba145 name="input.g.imba145"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imba146
            #add-point:BEFORE FIELD imba146 name="input.b.imba146"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imba146
            
            #add-point:AFTER FIELD imba146 name="input.a.imba146"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE imba146
            #add-point:ON CHANGE imba146 name="input.g.imba146"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imba016
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_imba_m.imba016,"0.000","1","","","azz-00079",1) THEN
               NEXT FIELD imba016
            END IF 
 
 
 
            #add-point:AFTER FIELD imba016 name="input.a.imba016"
                                    IF NOT cl_null(g_imba_m.imba016) THEN 
            END IF 

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imba016
            #add-point:BEFORE FIELD imba016 name="input.b.imba016"
                        
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE imba016
            #add-point:ON CHANGE imba016 name="input.g.imba016"
                        
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imba017
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_imba_m.imba017,"0.000","1","","","azz-00079",1) THEN
               NEXT FIELD imba017
            END IF 
 
 
 
            #add-point:AFTER FIELD imba017 name="input.a.imba017"
                                    IF NOT cl_null(g_imba_m.imba017) THEN 
            END IF 

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imba017
            #add-point:BEFORE FIELD imba017 name="input.b.imba017"
                        
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE imba017
            #add-point:ON CHANGE imba017 name="input.g.imba017"
                        
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imba018
            
            #add-point:AFTER FIELD imba018 name="input.a.imba018"
                                    DISPLAY "" TO g_imba_m.imba018_desc
            IF NOT cl_null(g_imba_m.imba018) THEN 
               CALL aimt300_desc()
               LET p_req_data[1] = g_imba_m.imba018
               CALL s_aimt300_fields_chk('imba018',p_req_data,'Y') RETURNING l_success,g_errno
               IF NOT l_success THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = g_errno
                  LET g_errparam.extend = g_imba_m.imba018
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  LET g_imba_m.imba018 = g_imba_m_t.imba018
                  CALL aimt300_desc()
                  NEXT FIELD imba018
               END IF
            END IF
            CALL aimt300_desc()

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imba018
            #add-point:BEFORE FIELD imba018 name="input.b.imba018"
                        
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE imba018
            #add-point:ON CHANGE imba018 name="input.g.imba018"
                        
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imba019
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_imba_m.imba019,"0.000","1","","","azz-00079",1) THEN
               NEXT FIELD imba019
            END IF 
 
 
 
            #add-point:AFTER FIELD imba019 name="input.a.imba019"
                                    IF NOT cl_null(g_imba_m.imba019) AND NOT cl_null(g_imba_m.imba020)THEN 
               LET g_imba_m.imba023 = g_imba_m.imba019 * g_imba_m.imba020
               DISPLAY BY NAME g_imba_m.imba023
               IF NOT cl_null(g_imba_m.imba021) THEN
                  LET g_imba_m.imba025 = g_imba_m.imba019 * g_imba_m.imba020 * g_imba_m.imba021
                  DISPLAY BY NAME g_imba_m.imba025
               END IF
            END IF 
            

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imba019
            #add-point:BEFORE FIELD imba019 name="input.b.imba019"
                        
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE imba019
            #add-point:ON CHANGE imba019 name="input.g.imba019"
                        
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imba020
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_imba_m.imba020,"0.000","1","","","azz-00079",1) THEN
               NEXT FIELD imba020
            END IF 
 
 
 
            #add-point:AFTER FIELD imba020 name="input.a.imba020"
                                    IF NOT cl_null(g_imba_m.imba019) AND NOT cl_null(g_imba_m.imba020)THEN 
               LET g_imba_m.imba023 = g_imba_m.imba019 * g_imba_m.imba020
               DISPLAY BY NAME g_imba_m.imba023
               IF NOT cl_null(g_imba_m.imba021) THEN
                  LET g_imba_m.imba025 = g_imba_m.imba019 * g_imba_m.imba020 * g_imba_m.imba021
                  DISPLAY BY NAME g_imba_m.imba025
               END IF
            END IF 

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imba020
            #add-point:BEFORE FIELD imba020 name="input.b.imba020"
                        
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE imba020
            #add-point:ON CHANGE imba020 name="input.g.imba020"
                        
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imba021
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_imba_m.imba021,"0.000","1","","","azz-00079",1) THEN
               NEXT FIELD imba021
            END IF 
 
 
 
            #add-point:AFTER FIELD imba021 name="input.a.imba021"
                                    IF NOT cl_null(g_imba_m.imba019) AND NOT cl_null(g_imba_m.imba020)THEN 
               LET g_imba_m.imba023 = g_imba_m.imba019 * g_imba_m.imba020
               DISPLAY BY NAME g_imba_m.imba023
               IF NOT cl_null(g_imba_m.imba021) THEN
                  LET g_imba_m.imba025 = g_imba_m.imba019 * g_imba_m.imba020 * g_imba_m.imba021
                  DISPLAY BY NAME g_imba_m.imba025
               END IF
            END IF 

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imba021
            #add-point:BEFORE FIELD imba021 name="input.b.imba021"
                        
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE imba021
            #add-point:ON CHANGE imba021 name="input.g.imba021"
                        
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imba022
            
            #add-point:AFTER FIELD imba022 name="input.a.imba022"
                                    DISPLAY "" TO g_imba_m.imba022_desc          
            IF NOT cl_null(g_imba_m.imba022) THEN
               CALL aimt300_desc()
               LET p_req_data[1] = g_imba_m.imba022
               CALL s_aimt300_fields_chk('imba022',p_req_data,'Y') RETURNING l_success,g_errno
               IF NOT l_success THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = g_errno
                  LET g_errparam.extend = g_imba_m.imba022
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  LET g_imba_m.imba022 = g_imba_m_t.imba022
                  CALL aimt300_desc()
                  NEXT FIELD imba022
               END IF
            END IF
            CALL aimt300_desc()
            SELECT ooca006,ooca007 INTO g_imba_m.imba024,g_imba_m.imba026
              FROM ooca_t
             WHERE ooca001 = g_imba_m.imba022
               AND oocaent = g_enterprise
            DISPLAY BY NAME g_imba_m.imba024,g_imba_m.imba026
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imba022
            #add-point:BEFORE FIELD imba022 name="input.b.imba022"
                        
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE imba022
            #add-point:ON CHANGE imba022 name="input.g.imba022"
                        
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imba023
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_imba_m.imba023,"0.000","1","","","azz-00079",1) THEN
               NEXT FIELD imba023
            END IF 
 
 
 
            #add-point:AFTER FIELD imba023 name="input.a.imba023"
                                    IF NOT cl_null(g_imba_m.imba023) THEN 
               LET p_req_data[1] = g_imba_m.imba023
               CALL s_aimt300_fields_chk('imba023',p_req_data,'Y') RETURNING l_success,g_errno
               IF NOT l_success THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = g_errno
                  LET g_errparam.extend = g_imba_m.imba023
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  LET g_imba_m.imba023 = g_imba_m_t.imba023
                  NEXT FIELD imba023
               END IF
            END IF
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imba023
            #add-point:BEFORE FIELD imba023 name="input.b.imba023"
                        
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE imba023
            #add-point:ON CHANGE imba023 name="input.g.imba023"
                        
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imba024
            #add-point:BEFORE FIELD imba024 name="input.b.imba024"
                        
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imba024
            
            #add-point:AFTER FIELD imba024 name="input.a.imba024"
                        
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE imba024
            #add-point:ON CHANGE imba024 name="input.g.imba024"
                        
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imba025
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_imba_m.imba025,"0.000","1","","","azz-00079",1) THEN
               NEXT FIELD imba025
            END IF 
 
 
 
            #add-point:AFTER FIELD imba025 name="input.a.imba025"
                                    IF NOT cl_null(g_imba_m.imba025) THEN 
               LET p_req_data[1] = g_imba_m.imba025
               CALL s_aimt300_fields_chk('imba025',p_req_data,'Y') RETURNING l_success,g_errno
               IF NOT l_success THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = g_errno
                  LET g_errparam.extend = g_imba_m.imba025
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  LET g_imba_m.imba025 = g_imba_m_t.imba025
                  NEXT FIELD imba025
               END IF
            END IF
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imba025
            #add-point:BEFORE FIELD imba025 name="input.b.imba025"
                        
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE imba025
            #add-point:ON CHANGE imba025 name="input.g.imba025"
                        
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imba026
            #add-point:BEFORE FIELD imba026 name="input.b.imba026"
                        
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imba026
            
            #add-point:AFTER FIELD imba026 name="input.a.imba026"
                        
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE imba026
            #add-point:ON CHANGE imba026 name="input.g.imba026"
                        
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imba027
            #add-point:BEFORE FIELD imba027 name="input.b.imba027"
                        
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imba027
            
            #add-point:AFTER FIELD imba027 name="input.a.imba027"
                                    IF NOT cl_null(g_imba_m.imba027) THEN 
               LET p_req_data[1] = g_imba_m.imba027
               CALL s_aimt300_fields_chk('imba027',p_req_data,'Y') RETURNING l_success,g_errno
               IF NOT l_success THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = g_errno
                  LET g_errparam.extend = g_imba_m.imba027
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  LET g_imba_m.imba027 = g_imba_m_t.imba027
                  NEXT FIELD imba027
               END IF
            END IF
            CALL aimt300_set_entry(l_cmd)
            CALL aimt300_set_no_entry(l_cmd)
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE imba027
            #add-point:ON CHANGE imba027 name="input.g.imba027"
                                    CALL aimt300_set_entry(l_cmd)
            CALL aimt300_set_no_entry(l_cmd)
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imba028
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_imba_m.imba028,"0.000","1","","","azz-00079",1) THEN
               NEXT FIELD imba028
            END IF 
 
 
 
            #add-point:AFTER FIELD imba028 name="input.a.imba028"
                                    IF NOT cl_null(g_imba_m.imba028) THEN 
            END IF 

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imba028
            #add-point:BEFORE FIELD imba028 name="input.b.imba028"
                        
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE imba028
            #add-point:ON CHANGE imba028 name="input.g.imba028"
                        
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imba029
            
            #add-point:AFTER FIELD imba029 name="input.a.imba029"
                                    DISPLAY "" TO g_imba_m.imba029_desc
            IF NOT cl_null(g_imba_m.imba029) THEN 
               CALL aimt300_desc()
               LET p_req_data[1] = g_imba_m.imba029
               CALL s_aimt300_fields_chk('imba029',p_req_data,'Y') RETURNING l_success,g_errno
               IF NOT l_success THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = g_errno
                  LET g_errparam.extend = g_imba_m.imba029
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  LET g_imba_m.imba029 = g_imba_m_t.imba029
                  CALL aimt300_desc()
                  NEXT FIELD imba029
               END IF
            END IF
            CALL aimt300_desc()

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imba029
            #add-point:BEFORE FIELD imba029 name="input.b.imba029"
                        
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE imba029
            #add-point:ON CHANGE imba029 name="input.g.imba029"
                        
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imba030
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_imba_m.imba030,"0.000","1","100.000","1","azz-00087",1) THEN
               NEXT FIELD imba030
            END IF 
 
 
 
            #add-point:AFTER FIELD imba030 name="input.a.imba030"
                        
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imba030
            #add-point:BEFORE FIELD imba030 name="input.b.imba030"
                        
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE imba030
            #add-point:ON CHANGE imba030 name="input.g.imba030"
                        
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imba031
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_imba_m.imba031,"0.000","1","","","azz-00079",1) THEN
               NEXT FIELD imba031
            END IF 
 
 
 
            #add-point:AFTER FIELD imba031 name="input.a.imba031"
                                    IF NOT cl_null(g_imba_m.imba031) THEN 
            END IF 

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imba031
            #add-point:BEFORE FIELD imba031 name="input.b.imba031"
                        
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE imba031
            #add-point:ON CHANGE imba031 name="input.g.imba031"
                        
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imba032
            
            #add-point:AFTER FIELD imba032 name="input.a.imba032"
                                    DISPLAY "" TO g_imba_m.imba032_desc          
            IF NOT cl_null(g_imba_m.imba032) THEN 
               CALL aimt300_desc()
               LET p_req_data[1] = g_imba_m.imba032
               CALL s_aimt300_fields_chk('imba032',p_req_data,'Y') RETURNING l_success,g_errno
               IF NOT l_success THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = g_errno
                  LET g_errparam.extend = g_imba_m.imba032
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  LET g_imba_m.imba032 = g_imba_m_t.imba032
                  CALL aimt300_desc()
                  NEXT FIELD imba032
               END IF
            END IF
            CALL aimt300_desc()

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imba032
            #add-point:BEFORE FIELD imba032 name="input.b.imba032"
                        
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE imba032
            #add-point:ON CHANGE imba032 name="input.g.imba032"
                        
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imba033
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_imba_m.imba033,"0.000","1","100.000","1","azz-00087",1) THEN
               NEXT FIELD imba033
            END IF 
 
 
 
            #add-point:AFTER FIELD imba033 name="input.a.imba033"
                        
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imba033
            #add-point:BEFORE FIELD imba033 name="input.b.imba033"
                        
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE imba033
            #add-point:ON CHANGE imba033 name="input.g.imba033"
                        
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imba034
            #add-point:BEFORE FIELD imba034 name="input.b.imba034"
                        
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imba034
            
            #add-point:AFTER FIELD imba034 name="input.a.imba034"
                        
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE imba034
            #add-point:ON CHANGE imba034 name="input.g.imba034"
                        
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imba035
            #add-point:BEFORE FIELD imba035 name="input.b.imba035"
                        
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imba035
            
            #add-point:AFTER FIELD imba035 name="input.a.imba035"
                        
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE imba035
            #add-point:ON CHANGE imba035 name="input.g.imba035"
                        
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imba036
            #add-point:BEFORE FIELD imba036 name="input.b.imba036"
                        
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imba036
            
            #add-point:AFTER FIELD imba036 name="input.a.imba036"
                        
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE imba036
            #add-point:ON CHANGE imba036 name="input.g.imba036"
                        
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imba037
            #add-point:BEFORE FIELD imba037 name="input.b.imba037"
                        
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imba037
            
            #add-point:AFTER FIELD imba037 name="input.a.imba037"
                        
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE imba037
            #add-point:ON CHANGE imba037 name="input.g.imba037"
                        
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imba043
            #add-point:BEFORE FIELD imba043 name="input.b.imba043"
                        
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imba043
            
            #add-point:AFTER FIELD imba043 name="input.a.imba043"
                        
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE imba043
            #add-point:ON CHANGE imba043 name="input.g.imba043"
                        
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imba038
            #add-point:BEFORE FIELD imba038 name="input.b.imba038"
                        
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imba038
            
            #add-point:AFTER FIELD imba038 name="input.a.imba038"
                        
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE imba038
            #add-point:ON CHANGE imba038 name="input.g.imba038"
                        
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imba041
            #add-point:BEFORE FIELD imba041 name="input.b.imba041"
                        
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imba041
            
            #add-point:AFTER FIELD imba041 name="input.a.imba041"
                        
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE imba041
            #add-point:ON CHANGE imba041 name="input.g.imba041"
                        
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imba042
            #add-point:BEFORE FIELD imba042 name="input.b.imba042"
                        
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imba042
            
            #add-point:AFTER FIELD imba042 name="input.a.imba042"
                        
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE imba042
            #add-point:ON CHANGE imba042 name="input.g.imba042"
                        
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imba044
            #add-point:BEFORE FIELD imba044 name="input.b.imba044"
                        
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imba044
            
            #add-point:AFTER FIELD imba044 name="input.a.imba044"
                        
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE imba044
            #add-point:ON CHANGE imba044 name="input.g.imba044"
                        
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imba122
            
            #add-point:AFTER FIELD imba122 name="input.a.imba122"
                                    DISPLAY "" TO g_imba_m.imba122_desc
            IF NOT cl_null(g_imba_m.imba122) THEN  
               CALL aimt300_desc()            
               LET p_req_data[1] = 2000
               LET p_req_data[2] = g_imba_m.imba122
               CALL s_aimt300_fields_chk('ACC',p_req_data,'Y') RETURNING l_success,g_errno
               IF NOT l_success THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = g_errno
                  LET g_errparam.extend = g_imba_m.imba122
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  LET g_imba_m.imba122 = g_imba_m_t.imba122
                  CALL aimt300_desc()
                  NEXT FIELD imba122
               END IF
            END IF
            CALL aimt300_desc()

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imba122
            #add-point:BEFORE FIELD imba122 name="input.b.imba122"
                        
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE imba122
            #add-point:ON CHANGE imba122 name="input.g.imba122"
                        
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imba045
            
            #add-point:AFTER FIELD imba045 name="input.a.imba045"
                                    DISPLAY "" TO g_imba_m.imba045_desc
            IF NOT cl_null(g_imba_m.imba045) THEN  
               CALL aimt300_desc()            
               LET p_req_data[1] = g_imba_m.imba045
               CALL s_aimt300_fields_chk('imba045',p_req_data,'Y') RETURNING l_success,g_errno
               IF NOT l_success THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = g_errno
                  LET g_errparam.extend = g_imba_m.imba045
                  #160321-00016#32 --s add
                  LET g_errparam.replace[1] = 'aooi020'
                  LET g_errparam.replace[2] = cl_get_progname('aooi020',g_lang,"2")
                  LET g_errparam.exeprog = 'aooi020'
                  #160321-00016#32 --e add
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  LET g_imba_m.imba045 = g_imba_m_t.imba045
                  CALL aimt300_desc()
                  NEXT FIELD imba045
               END IF
            END IF
            CALL aimt300_desc()

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imba045
            #add-point:BEFORE FIELD imba045 name="input.b.imba045"
                        
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE imba045
            #add-point:ON CHANGE imba045 name="input.g.imba045"
                        
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imba123
            #add-point:BEFORE FIELD imba123 name="input.b.imba123"
                        
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imba123
            
            #add-point:AFTER FIELD imba123 name="input.a.imba123"
                        
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE imba123
            #add-point:ON CHANGE imba123 name="input.g.imba123"
                        
            #END add-point 
 
 
 #欄位檢查
                  #Ctrlp:input.c.imbadocno
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imbadocno
            #add-point:ON ACTION controlp INFIELD imbadocno name="input.c.imbadocno"
                        #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL  #160510-00028#1  add
            LET g_qryparam.state = 'i'       #160510-00028#1  add
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_imba_m.imbadocno             #給予default值

            #給予arg
            SELECT ooef004 INTO l_arg1 FROM ooef_t WHERE ooef001 = g_site AND ooefent  = g_enterprise
            LET g_qryparam.arg1 = l_arg1 #參照表編號
            #LET g_qryparam.arg2 = "aimt300" #單據性質   #160705-00042#6 160711 by sakura mark
            LET g_qryparam.arg2 = g_prog                #160705-00042#6 160711 by sakura add
            #160711-00040#14 add(s)
            CALL s_control_get_docno_sql(g_user,g_dept)
                RETURNING l_success,l_sql1
            IF NOT cl_null(l_sql1) THEN
               LET g_qryparam.where = l_sql1
            END IF
            #160711-00040#14 add(e)
            CALL q_ooba002_1()                                #呼叫開窗

            LET g_imba_m.imbadocno = g_qryparam.return1              #將開窗取得的值回傳到變數

            DISPLAY g_imba_m.imbadocno TO imbadocno              #顯示到畫面上

            NEXT FIELD imbadocno                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.imbadocdt
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imbadocdt
            #add-point:ON ACTION controlp INFIELD imbadocdt name="input.c.imbadocdt"
                        
            #END add-point
 
 
         #Ctrlp:input.c.imba000
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imba000
            #add-point:ON ACTION controlp INFIELD imba000 name="input.c.imba000"
                        
            #END add-point
 
 
         #Ctrlp:input.c.imba900
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imba900
            #add-point:ON ACTION controlp INFIELD imba900 name="input.c.imba900"
                        #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL  #160510-00028#1  add
            LET g_qryparam.state = 'i'       #160510-00028#1  add
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_imba_m.imba900             #給予default值

            #給予arg

            CALL q_ooag001()                                #呼叫開窗

            LET g_imba_m.imba900 = g_qryparam.return1              #將開窗取得的值回傳到變數

            DISPLAY g_imba_m.imba900 TO imba900              #顯示到畫面上
            CALL aimt300_desc()
            NEXT FIELD imba900                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.imba901
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imba901
            #add-point:ON ACTION controlp INFIELD imba901 name="input.c.imba901"
                        #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL  #160510-00028#1  add
            LET g_qryparam.state = 'i'       #160510-00028#1  add
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_imba_m.imba901             #給予default值

            #給予arg
            IF NOT cl_null(g_imba_m.imbadocdt) THEN
               LET g_qryparam.arg1 = g_imba_m.imbadocdt
            END IF
            CALL q_ooeg001()                                #呼叫開窗

            LET g_imba_m.imba901 = g_qryparam.return1              #將開窗取得的值回傳到變數

            DISPLAY g_imba_m.imba901 TO imba901              #顯示到畫面上
            LET g_qryparam.arg1 = ""
            CALL aimt300_desc()
            NEXT FIELD imba901                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.imbastus
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imbastus
            #add-point:ON ACTION controlp INFIELD imbastus name="input.c.imbastus"
                        
            #END add-point
 
 
         #Ctrlp:input.c.imba001
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imba001
            #add-point:ON ACTION controlp INFIELD imba001 name="input.c.imba001"
                        #此段落由子樣板a07產生            
            IF g_imba_m.imba000 = 'U' THEN
               #開窗i段
               INITIALIZE g_qryparam.* TO NULL  #160510-00028#1  add
               LET g_qryparam.state = 'i'       #160510-00028#1  add
               LET g_qryparam.reqry = FALSE
		       
               LET g_qryparam.default1 = g_imba_m.imba001             #給予default值
		       
               #給予arg
		       
               CALL q_imaa001()                                #呼叫開窗
		       
               LET g_imba_m.imba001 = g_qryparam.return1              #將開窗取得的值回傳到變數
		       
               DISPLAY g_imba_m.imba001 TO imba001              #顯示到畫面上
		       
               NEXT FIELD imba001                          #返回原欄位

            END IF
            
            #150313---earl---mod---s
            IF g_imba_m.imba000 = 'I' AND cl_null(g_imba_m.imba001) THEN
               CALL cl_get_para(g_enterprise,g_site,'E-BAS-0012') RETURNING l_sys
               IF l_sys = 'Y' THEN
                  CALL aimt300_aooi390_default()
               END IF
            END IF
            #150313---earl---mod---e
            
            #END add-point
 
 
         #Ctrlp:input.c.imba002
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imba002
            #add-point:ON ACTION controlp INFIELD imba002 name="input.c.imba002"
                        
            #END add-point
 
 
         #Ctrlp:input.c.imbal002
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imbal002
            #add-point:ON ACTION controlp INFIELD imbal002 name="input.c.imbal002"
                        
            #END add-point
 
 
         #Ctrlp:input.c.imbal003
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imbal003
            #add-point:ON ACTION controlp INFIELD imbal003 name="input.c.imbal003"
                        
            #END add-point
 
 
         #Ctrlp:input.c.imbal004
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imbal004
            #add-point:ON ACTION controlp INFIELD imbal004 name="input.c.imbal004"
                        
            #END add-point
 
 
         #Ctrlp:input.c.imba009
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imba009
            #add-point:ON ACTION controlp INFIELD imba009 name="input.c.imba009"
                        #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL  #160510-00028#1  add
            LET g_qryparam.state = 'i'       #160510-00028#1  add
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_imba_m.imba009             #給予default值

            #給予arg

            CALL q_rtax001()                                #呼叫開窗

            LET g_imba_m.imba009 = g_qryparam.return1              #將開窗取得的值回傳到變數

            DISPLAY g_imba_m.imba009 TO imba009              #顯示到畫面上

            NEXT FIELD imba009                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.imba003
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imba003
            #add-point:ON ACTION controlp INFIELD imba003 name="input.c.imba003"
                        #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL  #160510-00028#1  add
            LET g_qryparam.state = 'i'       #160510-00028#1  add
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_imba_m.imba003             #給予default值

            #給予arg

            CALL q_imca001_1()                                #呼叫開窗

            LET g_imba_m.imba003 = g_qryparam.return1              #將開窗取得的值回傳到變數

            DISPLAY g_imba_m.imba003 TO imba003              #顯示到畫面上

            NEXT FIELD imba003                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.imba004
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imba004
            #add-point:ON ACTION controlp INFIELD imba004 name="input.c.imba004"
                        
            #END add-point
 
 
         #Ctrlp:input.c.imba005
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imba005
            #add-point:ON ACTION controlp INFIELD imba005 name="input.c.imba005"
                        #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_imba_m.imba005             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "" #

            CALL q_imea001()                                #呼叫開窗

            LET g_imba_m.imba005 = g_qryparam.return1              #將開窗取得的值回傳到變數

            DISPLAY g_imba_m.imba005 TO imba005              #顯示到畫面上
            CALL aimt300_desc()
            NEXT FIELD imba005                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.imba006
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imba006
            #add-point:ON ACTION controlp INFIELD imba006 name="input.c.imba006"
                        #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL  #160510-00028#1  add
            LET g_qryparam.state = 'i'       #160510-00028#1  add
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_imba_m.imba006             #給予default值

            #給予arg

            CALL q_ooca001_1()                                #呼叫開窗

            LET g_imba_m.imba006 = g_qryparam.return1              #將開窗取得的值回傳到變數

            DISPLAY g_imba_m.imba006 TO imba006              #顯示到畫面上
            CALL aimt300_desc()
            NEXT FIELD imba006                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.imba010
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imba010
            #add-point:ON ACTION controlp INFIELD imba010 name="input.c.imba010"
                        #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL  #160510-00028#1  add
            LET g_qryparam.state = 'i'       #160510-00028#1  add
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_imba_m.imba010             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "210" #應用分類

            CALL q_oocq002()                                #呼叫開窗

            LET g_imba_m.imba010 = g_qryparam.return1              #將開窗取得的值回傳到變數

            DISPLAY g_imba_m.imba010 TO imba010              #顯示到畫面上
            CALL aimt300_desc()
            NEXT FIELD imba010                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.imba126
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imba126
            #add-point:ON ACTION controlp INFIELD imba126 name="input.c.imba126"
                        #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL  #160510-00028#1  add
            LET g_qryparam.state = 'i'       #160510-00028#1  add
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_imba_m.imba126             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "2002" #應用分類

            CALL q_oocq002()                                #呼叫開窗

            LET g_imba_m.imba126 = g_qryparam.return1              #將開窗取得的值回傳到變數

            DISPLAY g_imba_m.imba126 TO imba126              #顯示到畫面上
            
            #141231-00009#1--add--begin----
            CALL s_desc_get_acc_desc('2002',g_imba_m.imba126) RETURNING g_imba_m.imba126_desc
            DISPLAY BY NAME g_imba_m.imba126_desc
            #141231-00009#1--add--end----

            NEXT FIELD imba126                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.imba127
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imba127
            #add-point:ON ACTION controlp INFIELD imba127 name="input.c.imba127"
                        #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL  #160510-00028#1  add
            LET g_qryparam.state = 'i'       #160510-00028#1  add
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_imba_m.imba127             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "2003" #應用分類

            CALL q_oocq002()                                #呼叫開窗

            LET g_imba_m.imba127 = g_qryparam.return1              #將開窗取得的值回傳到變數

            DISPLAY g_imba_m.imba127 TO imba127              #顯示到畫面上
            
            #141231-00009#1--add--begin----
            CALL s_desc_get_acc_desc('2003',g_imba_m.imba127) RETURNING g_imba_m.imba127_desc
            DISPLAY BY NAME g_imba_m.imba127_desc
            #141231-00009#1--add--end----         

            NEXT FIELD imba127                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.imba131
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imba131
            #add-point:ON ACTION controlp INFIELD imba131 name="input.c.imba131"
                        #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL  #160510-00028#1  add
            LET g_qryparam.state = 'i'       #160510-00028#1  add
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_imba_m.imba131             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "2001" #應用分類

            CALL q_oocq002()                                #呼叫開窗

            LET g_imba_m.imba131 = g_qryparam.return1              #將開窗取得的值回傳到變數

            DISPLAY g_imba_m.imba131 TO imba131              #顯示到畫面上
            
            #141231-00009#1--add--begin----
            CALL s_desc_get_acc_desc('2001',g_imba_m.imba131) RETURNING g_imba_m.imba131_desc
            DISPLAY BY NAME g_imba_m.imba131_desc
            #141231-00009#1--add--end---- 

            NEXT FIELD imba131                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.imba128
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imba128
            #add-point:ON ACTION controlp INFIELD imba128 name="input.c.imba128"
                        #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL  #160510-00028#1  add
            LET g_qryparam.state = 'i'       #160510-00028#1  add
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_imba_m.imba128             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "2004" #應用分類

            CALL q_oocq002()                                #呼叫開窗

            LET g_imba_m.imba128 = g_qryparam.return1              #將開窗取得的值回傳到變數

            DISPLAY g_imba_m.imba128 TO imba128              #顯示到畫面上
            
            #141231-00009#1--add--begin----
            CALL s_desc_get_acc_desc('2004',g_imba_m.imba128) RETURNING g_imba_m.imba128_desc
            DISPLAY BY NAME g_imba_m.imba128_desc
            #141231-00009#1--add--end----

            NEXT FIELD imba128                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.imba129
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imba129
            #add-point:ON ACTION controlp INFIELD imba129 name="input.c.imba129"
                        #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL  #160510-00028#1  add
            LET g_qryparam.state = 'i'       #160510-00028#1  add
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_imba_m.imba129             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "2005" #應用分類

            CALL q_oocq002()                                #呼叫開窗

            LET g_imba_m.imba129 = g_qryparam.return1              #將開窗取得的值回傳到變數

            DISPLAY g_imba_m.imba129 TO imba129              #顯示到畫面上
            
            #141231-00009#1--add--begin----
            CALL s_desc_get_acc_desc('2005',g_imba_m.imba129) RETURNING g_imba_m.imba129_desc
            DISPLAY BY NAME g_imba_m.imba129_desc
            #141231-00009#1--add--end----

            NEXT FIELD imba129                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.imba130
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imba130
            #add-point:ON ACTION controlp INFIELD imba130 name="input.c.imba130"
                        
            #END add-point
 
 
         #Ctrlp:input.c.imba132
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imba132
            #add-point:ON ACTION controlp INFIELD imba132 name="input.c.imba132"
                        #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL  #160510-00028#1  add
            LET g_qryparam.state = 'i'       #160510-00028#1  add
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_imba_m.imba132             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "2006" #應用分類

            CALL q_oocq002()                                #呼叫開窗

            LET g_imba_m.imba132 = g_qryparam.return1              #將開窗取得的值回傳到變數

            DISPLAY g_imba_m.imba132 TO imba132              #顯示到畫面上
            
            #141231-00009#1--add--begin----
            CALL s_desc_get_acc_desc('2006',g_imba_m.imba132) RETURNING g_imba_m.imba132_desc
            DISPLAY BY NAME g_imba_m.imba132_desc
            #141231-00009#1--add--end----

            NEXT FIELD imba132                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.imba133
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imba133
            #add-point:ON ACTION controlp INFIELD imba133 name="input.c.imba133"
                        #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL  #160510-00028#1  add
            LET g_qryparam.state = 'i'       #160510-00028#1  add
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_imba_m.imba133             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "2007" #應用分類

            CALL q_oocq002()                                #呼叫開窗

            LET g_imba_m.imba133 = g_qryparam.return1              #將開窗取得的值回傳到變數

            DISPLAY g_imba_m.imba133 TO imba133              #顯示到畫面上
            
            #141231-00009#1--add--begin----
            CALL s_desc_get_acc_desc('2007',g_imba_m.imba133) RETURNING g_imba_m.imba133_desc
            DISPLAY BY NAME g_imba_m.imba133_desc
            #141231-00009#1--add--end----

            NEXT FIELD imba133                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.imba134
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imba134
            #add-point:ON ACTION controlp INFIELD imba134 name="input.c.imba134"
                        #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL  #160510-00028#1  add
            LET g_qryparam.state = 'i'       #160510-00028#1  add
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_imba_m.imba134             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "2008" #應用分類

            CALL q_oocq002()                                #呼叫開窗

            LET g_imba_m.imba134 = g_qryparam.return1              #將開窗取得的值回傳到變數

            DISPLAY g_imba_m.imba134 TO imba134              #顯示到畫面上
            
            #141231-00009#1--add--begin----
            CALL s_desc_get_acc_desc('2008',g_imba_m.imba134) RETURNING g_imba_m.imba134_desc
            DISPLAY BY NAME g_imba_m.imba134_desc
            #141231-00009#1--add--end----

            NEXT FIELD imba134                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.imba135
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imba135
            #add-point:ON ACTION controlp INFIELD imba135 name="input.c.imba135"
                        #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL  #160510-00028#1  add
            LET g_qryparam.state = 'i'       #160510-00028#1  add
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_imba_m.imba135             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "2009" #應用分類

            CALL q_oocq002()                                #呼叫開窗

            LET g_imba_m.imba135 = g_qryparam.return1              #將開窗取得的值回傳到變數

            DISPLAY g_imba_m.imba135 TO imba135              #顯示到畫面上
            
            #141231-00009#1--add--begin----
            CALL s_desc_get_acc_desc('2009',g_imba_m.imba135) RETURNING g_imba_m.imba135_desc
            DISPLAY BY NAME g_imba_m.imba135_desc
            #141231-00009#1--add--end----

            NEXT FIELD imba135                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.imba136
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imba136
            #add-point:ON ACTION controlp INFIELD imba136 name="input.c.imba136"
                        #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL  #160510-00028#1  add
            LET g_qryparam.state = 'i'       #160510-00028#1  add
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_imba_m.imba136             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "2010" #應用分類

            CALL q_oocq002()                                #呼叫開窗

            LET g_imba_m.imba136 = g_qryparam.return1              #將開窗取得的值回傳到變數

            DISPLAY g_imba_m.imba136 TO imba136              #顯示到畫面上
            
            #141231-00009#1--add--begin----
            CALL s_desc_get_acc_desc('2010',g_imba_m.imba136) RETURNING g_imba_m.imba136_desc
            DISPLAY BY NAME g_imba_m.imba136_desc
            #141231-00009#1--add--end----

            NEXT FIELD imba136                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.imba137
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imba137
            #add-point:ON ACTION controlp INFIELD imba137 name="input.c.imba137"
                        #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL  #160510-00028#1  add
            LET g_qryparam.state = 'i'       #160510-00028#1  add
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_imba_m.imba137             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "2011" #應用分類

            CALL q_oocq002()                                #呼叫開窗

            LET g_imba_m.imba137 = g_qryparam.return1              #將開窗取得的值回傳到變數

            DISPLAY g_imba_m.imba137 TO imba137              #顯示到畫面上
            
            #141231-00009#1--add--begin----
            CALL s_desc_get_acc_desc('2011',g_imba_m.imba137) RETURNING g_imba_m.imba137_desc
            DISPLAY BY NAME g_imba_m.imba137_desc
            #141231-00009#1--add--end----

            NEXT FIELD imba137                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.imba138
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imba138
            #add-point:ON ACTION controlp INFIELD imba138 name="input.c.imba138"
                        #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL  #160510-00028#1  add
            LET g_qryparam.state = 'i'       #160510-00028#1  add
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_imba_m.imba138             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "2012" #應用分類

            CALL q_oocq002()                                #呼叫開窗

            LET g_imba_m.imba138 = g_qryparam.return1              #將開窗取得的值回傳到變數

            DISPLAY g_imba_m.imba138 TO imba138              #顯示到畫面上
            
            #141231-00009#1--add--begin----
            CALL s_desc_get_acc_desc('2012',g_imba_m.imba138) RETURNING g_imba_m.imba138_desc
            DISPLAY BY NAME g_imba_m.imba138_desc
            #141231-00009#1--add--end----

            NEXT FIELD imba138                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.imba139
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imba139
            #add-point:ON ACTION controlp INFIELD imba139 name="input.c.imba139"
                        #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL  #160510-00028#1  add
            LET g_qryparam.state = 'i'       #160510-00028#1  add
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_imba_m.imba139             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "2013" #應用分類

            CALL q_oocq002()                                #呼叫開窗

            LET g_imba_m.imba139 = g_qryparam.return1              #將開窗取得的值回傳到變數

            DISPLAY g_imba_m.imba139 TO imba139              #顯示到畫面上
            
            #141231-00009#1--add--begin----
            CALL s_desc_get_acc_desc('2013',g_imba_m.imba139) RETURNING g_imba_m.imba139_desc
            DISPLAY BY NAME g_imba_m.imba139_desc
            #141231-00009#1--add--end----

            NEXT FIELD imba139                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.imba140
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imba140
            #add-point:ON ACTION controlp INFIELD imba140 name="input.c.imba140"
                        #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL  #160510-00028#1  add
            LET g_qryparam.state = 'i'       #160510-00028#1  add
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_imba_m.imba140             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "2014" #應用分類

            CALL q_oocq002()                                #呼叫開窗

            LET g_imba_m.imba140 = g_qryparam.return1              #將開窗取得的值回傳到變數

            DISPLAY g_imba_m.imba140 TO imba140              #顯示到畫面上
            
            #141231-00009#1--add--begin----
            CALL s_desc_get_acc_desc('2014',g_imba_m.imba140) RETURNING g_imba_m.imba140_desc
            DISPLAY BY NAME g_imba_m.imba140_desc
            #141231-00009#1--add--end----

            NEXT FIELD imba140                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.imba141
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imba141
            #add-point:ON ACTION controlp INFIELD imba141 name="input.c.imba141"
                        #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL  #160510-00028#1  add
            LET g_qryparam.state = 'i'       #160510-00028#1  add
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_imba_m.imba141             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "2015" #應用分類

            CALL q_oocq002()                                #呼叫開窗

            LET g_imba_m.imba141 = g_qryparam.return1              #將開窗取得的值回傳到變數

            DISPLAY g_imba_m.imba141 TO imba141              #顯示到畫面上
            #141231-00009#1--add--begin----
            CALL s_desc_get_acc_desc('2015',g_imba_m.imba141) RETURNING g_imba_m.imba141_desc
            DISPLAY BY NAME g_imba_m.imba141_desc
            #141231-00009#1--add--end----

            NEXT FIELD imba141                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.imba011
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imba011
            #add-point:ON ACTION controlp INFIELD imba011 name="input.c.imba011"
                        
            #END add-point
 
 
         #Ctrlp:input.c.imba012
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imba012
            #add-point:ON ACTION controlp INFIELD imba012 name="input.c.imba012"
                        
            #END add-point
 
 
         #Ctrlp:input.c.imba013
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imba013
            #add-point:ON ACTION controlp INFIELD imba013 name="input.c.imba013"
                        
            #END add-point
 
 
         #Ctrlp:input.c.imba014
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imba014
            #add-point:ON ACTION controlp INFIELD imba014 name="input.c.imba014"
                        
            #END add-point
 
 
         #Ctrlp:input.c.imba142
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imba142
            #add-point:ON ACTION controlp INFIELD imba142 name="input.c.imba142"
                        #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL  #160510-00028#1  add
            LET g_qryparam.state = 'i'       #160510-00028#1  add
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_imba_m.imba142             #給予default值

            #給予arg

            #CALL q_ooea001()                                #呼叫開窗  #170213-00038#1   2017/02/15   By 08734 mark
            CALL q_ooef001()                                 #呼叫開窗  #170213-00038#1   2017/02/15   By 08734 add

            LET g_imba_m.imba142 = g_qryparam.return1              #將開窗取得的值回傳到變數

            DISPLAY g_imba_m.imba142 TO imba142              #顯示到畫面上

            NEXT FIELD imba142                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.imba108
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imba108
            #add-point:ON ACTION controlp INFIELD imba108 name="input.c.imba108"
            
            #END add-point
 
 
         #Ctrlp:input.c.imba100
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imba100
            #add-point:ON ACTION controlp INFIELD imba100 name="input.c.imba100"
            
            #END add-point
 
 
         #Ctrlp:input.c.imba109
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imba109
            #add-point:ON ACTION controlp INFIELD imba109 name="input.c.imba109"
            
            #END add-point
 
 
         #Ctrlp:input.c.imba101
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imba101
            #add-point:ON ACTION controlp INFIELD imba101 name="input.c.imba101"
            #應用 a07 樣板自動產生(Version:3)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
 
            LET g_qryparam.default1 = g_imba_m.imba101             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "" #s

 
            CALL q_pmaa001()                                #呼叫開窗
 
            LET g_imba_m.imba101 = g_qryparam.return1              

            DISPLAY g_imba_m.imba101 TO imba101              #

            NEXT FIELD imba101                          #返回原欄位



            #END add-point
 
 
         #Ctrlp:input.c.imba104
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imba104
            #add-point:ON ACTION controlp INFIELD imba104 name="input.c.imba104"
            #應用 a07 樣板自動產生(Version:3)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
 
            LET g_qryparam.default1 = g_imba_m.imba104             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "" #s

 
            CALL q_ooca001_1()                                #呼叫開窗
 
            LET g_imba_m.imba104 = g_qryparam.return1              

            DISPLAY g_imba_m.imba104 TO imba104              #

            NEXT FIELD imba104                          #返回原欄位



            #END add-point
 
 
         #Ctrlp:input.c.imba105
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imba105
            #add-point:ON ACTION controlp INFIELD imba105 name="input.c.imba105"
            #應用 a07 樣板自動產生(Version:3)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
 
            LET g_qryparam.default1 = g_imba_m.imba105             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "" #s

 
            CALL q_ooca001_1()                                #呼叫開窗
 
            LET g_imba_m.imba105 = g_qryparam.return1              

            DISPLAY g_imba_m.imba105 TO imba105              #

            NEXT FIELD imba105                          #返回原欄位



            #END add-point
 
 
         #Ctrlp:input.c.imba106
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imba106
            #add-point:ON ACTION controlp INFIELD imba106 name="input.c.imba106"
            #應用 a07 樣板自動產生(Version:3)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
 
            LET g_qryparam.default1 = g_imba_m.imba106             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "" #s

 
            CALL q_ooca001_1()                                #呼叫開窗
 
            LET g_imba_m.imba106 = g_qryparam.return1              

            DISPLAY g_imba_m.imba106 TO imba106              #

            NEXT FIELD imba106                          #返回原欄位



            #END add-point
 
 
         #Ctrlp:input.c.imba107
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imba107
            #add-point:ON ACTION controlp INFIELD imba107 name="input.c.imba107"
            #應用 a07 樣板自動產生(Version:3)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
 
            LET g_qryparam.default1 = g_imba_m.imba107             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "" #s

 
            CALL q_ooca001_1()                                #呼叫開窗
 
            LET g_imba_m.imba107 = g_qryparam.return1              

            DISPLAY g_imba_m.imba107 TO imba107              #

            NEXT FIELD imba107                          #返回原欄位



            #END add-point
 
 
         #Ctrlp:input.c.imba124
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imba124
            #add-point:ON ACTION controlp INFIELD imba124 name="input.c.imba124"
#此段落由子樣板a07產生            
#            #開窗i段
#            LET g_qryparam.reqry = FALSE
#
#            LET g_qryparam.default1 = g_imba_m.imba124             #給予default值
#
#            #給予arg
#            LET g_qryparam.arg1 = "" #組織編號
#
#            CALL q_oodc001_2()                                #呼叫開窗
#
#            LET g_imba_m.imba124 = g_qryparam.return1              #將開窗取得的值回傳到變數
#
#            DISPLAY g_imba_m.imba124 TO imba124              #顯示到畫面上
#
#            NEXT FIELD imba124                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.imba145
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imba145
            #add-point:ON ACTION controlp INFIELD imba145 name="input.c.imba145"
            #應用 a07 樣板自動產生(Version:3)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
 
            LET g_qryparam.default1 = g_imba_m.imba145             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "" #s

 
            CALL q_ooca001_1()                                #呼叫開窗
 
            LET g_imba_m.imba145 = g_qryparam.return1              

            DISPLAY g_imba_m.imba145 TO imba145              #

            NEXT FIELD imba145                          #返回原欄位



            #END add-point
 
 
         #Ctrlp:input.c.imba146
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imba146
            #add-point:ON ACTION controlp INFIELD imba146 name="input.c.imba146"
            
            #END add-point
 
 
         #Ctrlp:input.c.imba016
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imba016
            #add-point:ON ACTION controlp INFIELD imba016 name="input.c.imba016"
                        
            #END add-point
 
 
         #Ctrlp:input.c.imba017
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imba017
            #add-point:ON ACTION controlp INFIELD imba017 name="input.c.imba017"
                        
            #END add-point
 
 
         #Ctrlp:input.c.imba018
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imba018
            #add-point:ON ACTION controlp INFIELD imba018 name="input.c.imba018"
                        #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL  #160510-00028#1  add
            LET g_qryparam.state = 'i'       #160510-00028#1  add
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_imba_m.imba018             #給予default值

            #給予arg
            LET g_qryparam.where = " ooca003 = '3'"
            CALL q_ooca001_1()                                #呼叫開窗

            LET g_imba_m.imba018 = g_qryparam.return1              #將開窗取得的值回傳到變數

            DISPLAY g_imba_m.imba018 TO imba018              #顯示到畫面上
            LET g_qryparam.where = ""
            CALL aimt300_desc()
            NEXT FIELD imba018                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.imba019
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imba019
            #add-point:ON ACTION controlp INFIELD imba019 name="input.c.imba019"
                        
            #END add-point
 
 
         #Ctrlp:input.c.imba020
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imba020
            #add-point:ON ACTION controlp INFIELD imba020 name="input.c.imba020"
                        
            #END add-point
 
 
         #Ctrlp:input.c.imba021
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imba021
            #add-point:ON ACTION controlp INFIELD imba021 name="input.c.imba021"
                        
            #END add-point
 
 
         #Ctrlp:input.c.imba022
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imba022
            #add-point:ON ACTION controlp INFIELD imba022 name="input.c.imba022"
                        #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL  #160510-00028#1  add
            LET g_qryparam.state = 'i'       #160510-00028#1  add
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_imba_m.imba022             #給予default值

            #給予arg
            LET g_qryparam.where = " ooca003 = '2'"
            CALL q_ooca001_1()                                #呼叫開窗

            LET g_imba_m.imba022 = g_qryparam.return1              #將開窗取得的值回傳到變數

            DISPLAY g_imba_m.imba022 TO imba022              #顯示到畫面上
            LET g_qryparam.where = ""
            CALL aimt300_desc()
            NEXT FIELD imba022                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.imba023
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imba023
            #add-point:ON ACTION controlp INFIELD imba023 name="input.c.imba023"
                        
            #END add-point
 
 
         #Ctrlp:input.c.imba024
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imba024
            #add-point:ON ACTION controlp INFIELD imba024 name="input.c.imba024"
                        #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL  #160510-00028#1  add
            LET g_qryparam.state = 'i'       #160510-00028#1  add
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_imba_m.imba024             #給予default值

            #給予arg

            CALL q_ooca001_1()                                #呼叫開窗

            LET g_imba_m.imba024 = g_qryparam.return1              #將開窗取得的值回傳到變數

            DISPLAY g_imba_m.imba024 TO imba024              #顯示到畫面上

            NEXT FIELD imba024                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.imba025
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imba025
            #add-point:ON ACTION controlp INFIELD imba025 name="input.c.imba025"
                        
            #END add-point
 
 
         #Ctrlp:input.c.imba026
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imba026
            #add-point:ON ACTION controlp INFIELD imba026 name="input.c.imba026"
                        #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL  #160510-00028#1  add
            LET g_qryparam.state = 'i'       #160510-00028#1  add
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_imba_m.imba026             #給予default值

            #給予arg

            CALL q_ooca001_1()                                #呼叫開窗

            LET g_imba_m.imba026 = g_qryparam.return1              #將開窗取得的值回傳到變數

            DISPLAY g_imba_m.imba026 TO imba026              #顯示到畫面上

            NEXT FIELD imba026                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.imba027
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imba027
            #add-point:ON ACTION controlp INFIELD imba027 name="input.c.imba027"
                        
            #END add-point
 
 
         #Ctrlp:input.c.imba028
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imba028
            #add-point:ON ACTION controlp INFIELD imba028 name="input.c.imba028"
                        
            #END add-point
 
 
         #Ctrlp:input.c.imba029
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imba029
            #add-point:ON ACTION controlp INFIELD imba029 name="input.c.imba029"
                        #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL  #160510-00028#1  add
            LET g_qryparam.state = 'i'       #160510-00028#1  add
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_imba_m.imba029             #給予default值

            #給予arg
            LET g_qryparam.where = " ooca003 = '5'"
            CALL q_ooca001_1()                                #呼叫開窗

            LET g_imba_m.imba029 = g_qryparam.return1              #將開窗取得的值回傳到變數
            LET g_qryparam.where = ""
            DISPLAY g_imba_m.imba029 TO imba029              #顯示到畫面上
            CALL aimt300_desc()
            NEXT FIELD imba029                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.imba030
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imba030
            #add-point:ON ACTION controlp INFIELD imba030 name="input.c.imba030"
                        
            #END add-point
 
 
         #Ctrlp:input.c.imba031
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imba031
            #add-point:ON ACTION controlp INFIELD imba031 name="input.c.imba031"
                        
            #END add-point
 
 
         #Ctrlp:input.c.imba032
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imba032
            #add-point:ON ACTION controlp INFIELD imba032 name="input.c.imba032"
                        #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL  #160510-00028#1  add
            LET g_qryparam.state = 'i'       #160510-00028#1  add
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_imba_m.imba032             #給予default值

            #給予arg
            LET g_qryparam.where = " ooca003 = '3'"
            CALL q_ooca001_1()                                #呼叫開窗

            LET g_imba_m.imba032 = g_qryparam.return1              #將開窗取得的值回傳到變數

            DISPLAY g_imba_m.imba032 TO imba032              #顯示到畫面上
            LET g_qryparam.where = ""
            CALL aimt300_desc()
            NEXT FIELD imba032                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.imba033
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imba033
            #add-point:ON ACTION controlp INFIELD imba033 name="input.c.imba033"
                        
            #END add-point
 
 
         #Ctrlp:input.c.imba034
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imba034
            #add-point:ON ACTION controlp INFIELD imba034 name="input.c.imba034"
                        
            #END add-point
 
 
         #Ctrlp:input.c.imba035
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imba035
            #add-point:ON ACTION controlp INFIELD imba035 name="input.c.imba035"
                        
            #END add-point
 
 
         #Ctrlp:input.c.imba036
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imba036
            #add-point:ON ACTION controlp INFIELD imba036 name="input.c.imba036"
                        
            #END add-point
 
 
         #Ctrlp:input.c.imba037
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imba037
            #add-point:ON ACTION controlp INFIELD imba037 name="input.c.imba037"
                        
            #END add-point
 
 
         #Ctrlp:input.c.imba043
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imba043
            #add-point:ON ACTION controlp INFIELD imba043 name="input.c.imba043"
                        #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL  #160510-00028#1  add
            LET g_qryparam.state = 'i'       #160510-00028#1  add
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_imba_m.imba043             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "" #應用分類

            CALL q_oocq002()                                #呼叫開窗

            LET g_imba_m.imba043 = g_qryparam.return1              #將開窗取得的值回傳到變數

            DISPLAY g_imba_m.imba043 TO imba043              #顯示到畫面上

            NEXT FIELD imba043                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.imba038
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imba038
            #add-point:ON ACTION controlp INFIELD imba038 name="input.c.imba038"
                        
            #END add-point
 
 
         #Ctrlp:input.c.imba041
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imba041
            #add-point:ON ACTION controlp INFIELD imba041 name="input.c.imba041"
                        
            #END add-point
 
 
         #Ctrlp:input.c.imba042
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imba042
            #add-point:ON ACTION controlp INFIELD imba042 name="input.c.imba042"
            #170213-00038#1   2017/02/15   By 08734 add(S)
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
			   LET g_qryparam.reqry = FALSE
            CALL q_mrba001_12()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO imba042  #顯示到畫面上

            NEXT FIELD imba042                     #返回原欄位 
            #170213-00038#1   2017/02/15   By 08734 add(E)             
            #END add-point
 
 
         #Ctrlp:input.c.imba044
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imba044
            #add-point:ON ACTION controlp INFIELD imba044 name="input.c.imba044"
                        
            #END add-point
 
 
         #Ctrlp:input.c.imba122
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imba122
            #add-point:ON ACTION controlp INFIELD imba122 name="input.c.imba122"
                                    #開窗i段
            INITIALIZE g_qryparam.* TO NULL  #160510-00028#1  add
            LET g_qryparam.state = 'i'       #160510-00028#1  add                        
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_imba_m.imba122             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "2000" #應用分類
            CALL q_oocq002()                                #呼叫開窗

            LET g_imba_m.imba122 = g_qryparam.return1              #將開窗取得的值回傳到變數

            DISPLAY g_imba_m.imba122 TO imba122              #顯示到畫面上
            CALL aimt300_desc()
            NEXT FIELD imba122                          #返回原欄位
            #END add-point
 
 
         #Ctrlp:input.c.imba045
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imba045
            #add-point:ON ACTION controlp INFIELD imba045 name="input.c.imba045"
                        #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL  #160510-00028#1  add
            LET g_qryparam.state = 'i'       #160510-00028#1  add
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_imba_m.imba045             #給予default值

            #給予arg
      
            CALL q_oocg001()                                #呼叫開窗

            LET g_imba_m.imba045 = g_qryparam.return1              #將開窗取得的值回傳到變數

            DISPLAY g_imba_m.imba045 TO imba045              #顯示到畫面上
            CALL aimt300_desc()
            NEXT FIELD imba045                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.imba123
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imba123
            #add-point:ON ACTION controlp INFIELD imba123 name="input.c.imba123"
                        
            #END add-point
 
 
 #欄位開窗
            
         AFTER INPUT
            IF INT_FLAG THEN
               EXIT DIALOG
            END IF
 
            #CALL cl_err_collect_show()      #錯誤訊息統整顯示
            #CALL cl_showmsg()
            DISPLAY BY NAME g_imba_m.imbadocno
                        
            #add-point:單頭INPUT後 name="input.head.after_input"
            
            #end add-point
                        
            IF p_cmd <> 'u' THEN
    
               CALL s_transaction_begin()
               
               #add-point:單頭新增前 name="input.head.b_insert"
                              #               CALL s_aooi200_gen_docno(g_site,g_imba_m.imbadocno,g_imba_m.imbadocdt,g_prog) RETURNING l_success,g_imba_m.imbadocno
#               IF NOT l_success THEN
#                  CALL cl_err()
#                  NEXT FIELD imbadocno            
#               END IF
              #160901-00023#1 ---add (s)---                                   
               CALL s_aooi200_gen_docno(g_site,g_imba_m.imbadocno,g_imba_m.imbadocdt,g_prog) RETURNING l_success,g_imba_m.imbadocno
               IF NOT l_success THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'apm-00003'
                  LET g_errparam.extend = g_imba_m.imbadocdt
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
                  LET g_imba_m.imbadocdt = g_imba_m_t.imbadocdt
                  DISPLAY g_imba_m.imbadocdt TO imbadocdt
                  NEXT FIELD imbadocno            
               END IF
              #160901-00023#1 ---add (e)---
              #15/06/09 Sarah add
               CALL s_aooi390_get_auto_no('1',g_imba_m.imba001) RETURNING l_success,g_imba_m.imba001
               IF NOT l_success THEN
                  CALL s_transaction_end('N','0')
                  NEXT FIELD CURRENT
               END IF
              #15/06/09 Sarah add
              
               #15/06/30 Sarah add
               #如果新的編碼與舊的不一樣 應該做更新 
               IF g_imba_m_o.imba001 != g_imba_m.imba001 AND NOT cl_null(g_imba_m_o.imba001) THEN
                  LET l_count_chk = 0
                  SELECT COUNT(*) INTO l_count_chk
                    FROM imbo_t
                   WHERE imboent = g_enterprise
                     AND imbo001 = g_imba_m_o.imba001
                  IF l_count_chk > 0 THEN
                     UPDATE imbo_t SET imbo001 = g_imba_m.imba001
                      WHERE imboent = g_enterprise
                        AND imbo001 = g_imba_m_o.imba001
                     IF SQLCA.sqlcode THEN
                        INITIALIZE g_errparam TO NULL
                        LET g_errparam.extend = 'upd imbo_t'
                        LET g_errparam.code   = SQLCA.sqlcode
                        LET g_errparam.popup  = TRUE
                        CALL cl_err()

                        CALL s_transaction_end('N','0')
                        NEXT FIELD CURRENT
                     END IF
                  END IF

                  LET l_count_chk = 0
                  SELECT COUNT(*) INTO l_count_chk
                    FROM imbj_t
                   WHERE imbjent = g_enterprise
                     AND imbj001 = g_imba_m_o.imba001
                  IF l_count_chk > 0 THEN
                     UPDATE imbj_t SET imbj001 = g_imba_m.imba001
                      WHERE imbjent = g_enterprise
                        AND imbj001 = g_imba_m_o.imba001
                     IF SQLCA.sqlcode THEN
                        INITIALIZE g_errparam TO NULL
                        LET g_errparam.extend = 'upd imbj_t'
                        LET g_errparam.code   = SQLCA.sqlcode
                        LET g_errparam.popup  = TRUE
                        CALL cl_err()

                        CALL s_transaction_end('N','0')
                        NEXT FIELD CURRENT
                     END IF
                  END IF

                  LET l_count_chk = 0
                  SELECT COUNT(*) INTO l_count_chk
                    FROM imbk_t
                   WHERE imbkent = g_enterprise
                     AND imbk001 = g_imba_m_o.imba001
                  IF l_count_chk > 0 THEN
                     UPDATE imbk_t SET imbk001 = g_imba_m.imba001
                      WHERE imbkent = g_enterprise
                        AND imbk001 = g_imba_m_o.imba001
                     IF SQLCA.sqlcode THEN
                        INITIALIZE g_errparam TO NULL
                        LET g_errparam.extend = 'upd imbk_t'
                        LET g_errparam.code   = SQLCA.sqlcode
                        LET g_errparam.popup  = TRUE
                        CALL cl_err()

                        CALL s_transaction_end('N','0')
                        NEXT FIELD CURRENT
                     END IF
                  END IF

                  LET l_count_chk = 0
                  SELECT COUNT(*) INTO l_count_chk
                    FROM imbl_t
                   WHERE imblent = g_enterprise
                     AND imbl001 = g_imba_m_o.imba001
                  IF l_count_chk > 0 THEN
                     UPDATE imbl_t SET imbl001 = g_imba_m.imba001
                      WHERE imblent = g_enterprise
                        AND imbl001 = g_imba_m_o.imba001
                     IF SQLCA.sqlcode THEN
                        INITIALIZE g_errparam TO NULL
                        LET g_errparam.extend = 'upd imbl_t'
                        LET g_errparam.code   = SQLCA.sqlcode
                        LET g_errparam.popup  = TRUE
                        CALL cl_err()

                        CALL s_transaction_end('N','0')
                        NEXT FIELD CURRENT
                     END IF
                  END IF

                  LET l_count_chk = 0
                  SELECT COUNT(*) INTO l_count_chk
                    FROM imbm_t
                   WHERE imbment = g_enterprise
                     AND imbm001 = g_imba_m_o.imba001
                  IF l_count_chk > 0 THEN
                     UPDATE imbm_t SET imbm001 = g_imba_m.imba001
                      WHERE imbment = g_enterprise
                        AND imbm001 = g_imba_m_o.imba001
                     IF SQLCA.sqlcode THEN
                        INITIALIZE g_errparam TO NULL
                        LET g_errparam.extend = 'upd imbm_t'
                        LET g_errparam.code   = SQLCA.sqlcode
                        LET g_errparam.popup  = TRUE
                        CALL cl_err()

                        CALL s_transaction_end('N','0')
                        NEXT FIELD CURRENT
                     END IF
                  END IF
               END IF
               #15/06/30 Sarah add

               CALL s_aooi390_oofi_upd('1',g_imba_m.imba001) RETURNING l_success  #add--2015/05/08 By shiun 增加編碼功能
               LET g_imba_m.imba146 = g_imba_m.imba006  #161004-00020#1 add
               #end add-point
               
               INSERT INTO imba_t (imbaent,imbadocno,imbadocdt,imba000,imba900,imba901,imbastus,imba001, 
                   imba002,imba009,imba003,imba004,imba005,imba006,imba010,imba126,imba127,imba131,imba128, 
                   imba129,imba130,imba132,imba133,imba134,imba135,imba136,imba137,imba138,imba139,imba140, 
                   imba141,imbaownid,imbaowndp,imbacrtid,imbacrtdp,imbacrtdt,imbamodid,imbamoddt,imbacnfid, 
                   imbacnfdt,imba011,imba012,imba013,imba014,imba142,imba108,imba100,imba109,imba101, 
                   imba104,imba105,imba106,imba107,imba124,imba145,imba146,imba016,imba017,imba018,imba019, 
                   imba020,imba021,imba022,imba023,imba024,imba025,imba026,imba027,imba028,imba029,imba030, 
                   imba031,imba032,imba033,imba034,imba035,imba036,imba037,imba043,imba038,imba041,imba042, 
                   imba044,imba122,imba045,imba123)
               VALUES (g_enterprise,g_imba_m.imbadocno,g_imba_m.imbadocdt,g_imba_m.imba000,g_imba_m.imba900, 
                   g_imba_m.imba901,g_imba_m.imbastus,g_imba_m.imba001,g_imba_m.imba002,g_imba_m.imba009, 
                   g_imba_m.imba003,g_imba_m.imba004,g_imba_m.imba005,g_imba_m.imba006,g_imba_m.imba010, 
                   g_imba_m.imba126,g_imba_m.imba127,g_imba_m.imba131,g_imba_m.imba128,g_imba_m.imba129, 
                   g_imba_m.imba130,g_imba_m.imba132,g_imba_m.imba133,g_imba_m.imba134,g_imba_m.imba135, 
                   g_imba_m.imba136,g_imba_m.imba137,g_imba_m.imba138,g_imba_m.imba139,g_imba_m.imba140, 
                   g_imba_m.imba141,g_imba_m.imbaownid,g_imba_m.imbaowndp,g_imba_m.imbacrtid,g_imba_m.imbacrtdp, 
                   g_imba_m.imbacrtdt,g_imba_m.imbamodid,g_imba_m.imbamoddt,g_imba_m.imbacnfid,g_imba_m.imbacnfdt, 
                   g_imba_m.imba011,g_imba_m.imba012,g_imba_m.imba013,g_imba_m.imba014,g_imba_m.imba142, 
                   g_imba_m.imba108,g_imba_m.imba100,g_imba_m.imba109,g_imba_m.imba101,g_imba_m.imba104, 
                   g_imba_m.imba105,g_imba_m.imba106,g_imba_m.imba107,g_imba_m.imba124,g_imba_m.imba145, 
                   g_imba_m.imba146,g_imba_m.imba016,g_imba_m.imba017,g_imba_m.imba018,g_imba_m.imba019, 
                   g_imba_m.imba020,g_imba_m.imba021,g_imba_m.imba022,g_imba_m.imba023,g_imba_m.imba024, 
                   g_imba_m.imba025,g_imba_m.imba026,g_imba_m.imba027,g_imba_m.imba028,g_imba_m.imba029, 
                   g_imba_m.imba030,g_imba_m.imba031,g_imba_m.imba032,g_imba_m.imba033,g_imba_m.imba034, 
                   g_imba_m.imba035,g_imba_m.imba036,g_imba_m.imba037,g_imba_m.imba043,g_imba_m.imba038, 
                   g_imba_m.imba041,g_imba_m.imba042,g_imba_m.imba044,g_imba_m.imba122,g_imba_m.imba045, 
                   g_imba_m.imba123) 
               IF SQLCA.SQLCODE THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "g_imba_m:",SQLERRMESSAGE 
                  LET g_errparam.code = SQLCA.SQLCODE 
                  LET g_errparam.popup = TRUE 
                  CALL s_transaction_end('N','0')
                  CALL cl_err()
                  NEXT FIELD CURRENT
               END IF
               
               #add-point:單頭新增中 name="input.head.m_insert"
                                              LET g_imbadocno_t = g_imba_m.imbadocno
               CALL aimt300_ins_detail() RETURNING l_success
               IF NOT l_success THEN
                  CALL s_transaction_end('N','0')
                  RETURN
               END IF
               IF g_con = 'Y' THEN
                  CALL s_aimt300_ins_item_site(g_imba_m.imbadocno,g_imba_m.imba001,g_imba_m.imba003) RETURNING l_success
                  IF NOT l_success THEN
                     CALL s_transaction_end('N','0')
                     RETURN
                  END IF
               END IF
               IF g_con = 'N' AND g_imba_m.imba000 = 'U' THEN
                  CALL aimt300_ins_other() RETURNING l_success
                  IF NOT l_success THEN
                     CALL s_transaction_end('N','0')
                     RETURN
                  END IF
               END IF 
               LET l_n1 = 0
               SELECT COUNT(*) INTO l_n1
                 FROM imbo_t
                WHERE imboent = g_enterprise
                  AND imbodocno = g_imba_m.imbadocno
               IF l_n1 = 0 THEN
                  INSERT INTO imbo_t(imboent,imbodocno,imbo000,imbo001,imbo002)
                           VALUES(g_enterprise,g_imba_m.imbadocno,g_imba_m.imba000,g_imba_m.imba001,g_imba_m.imba006)
                  IF SQLCA.sqlcode THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = SQLCA.sqlcode
                     LET g_errparam.extend = "ins imbo_t"
                     LET g_errparam.popup = TRUE
                     CALL cl_err()

                     CALL s_transaction_end('N','0')
                     RETURN
                  END IF
               END IF
               #end add-point
               
               
                        INITIALIZE l_var_keys TO NULL 
         INITIALIZE l_field_keys TO NULL 
         INITIALIZE l_vars TO NULL 
         INITIALIZE l_fields TO NULL 
         IF g_imba_m.imbadocno = g_master_multi_table_t.imbaldocno AND
         g_imba_m.imbal002 = g_master_multi_table_t.imbal002 AND 
         g_imba_m.imbal003 = g_master_multi_table_t.imbal003 AND 
         g_imba_m.imbal004 = g_master_multi_table_t.imbal004  THEN
         ELSE 
            LET l_var_keys[01] = g_enterprise
            LET l_field_keys[01] = 'imbalent'
            LET l_var_keys_bak[01] = g_enterprise
            LET l_var_keys[02] = g_imba_m.imbadocno
            LET l_field_keys[02] = 'imbaldocno'
            LET l_var_keys_bak[02] = g_master_multi_table_t.imbaldocno
            LET l_var_keys[03] = g_dlang
            LET l_field_keys[03] = 'imbal001'
            LET l_var_keys_bak[03] = g_dlang
            LET l_vars[01] = g_imba_m.imbal002
            LET l_fields[01] = 'imbal002'
            LET l_vars[02] = g_imba_m.imbal003
            LET l_fields[02] = 'imbal003'
            LET l_vars[03] = g_imba_m.imbal004
            LET l_fields[03] = 'imbal004'
            CALL cl_multitable(l_var_keys,l_field_keys,l_vars,l_fields,l_var_keys_bak,'imbal_t')
         END IF 
 
               
               #add-point:單頭新增後 name="input.head.a_insert"
               LET g_ooff001_d = '6'
               LET g_ooff002_d = g_imba_m.imbadocno
               LET g_ooff003_d = ' '
               LET g_ooff004_d = ' '
               LET g_ooff005_d = ' '
               LET g_ooff006_d = ' '
               LET g_ooff007_d = ' '
               LET g_ooff008_d = ' '
               LET g_ooff009_d = ' '
               LET g_ooff010_d = ' '
               LET g_ooff011_d = ' '
               
               LET g_imbadocno_d = g_imba_m.imbadocno
               LET g_imba001_d = g_imba_m.imba001
               #end add-point
               CALL s_transaction_end('Y','0') 
               
               IF l_cmd_t = 'r' AND p_cmd = 'a' THEN
                  CALL aimt300_detail_reproduce()
                  #因應特定程式需求, 重新刷新單身資料
                  CALL aimt300_b_fill()
                  CALL aimt300_b_fill2('0')
               END IF
               
               #add-point:單頭新增後 name="input.head.a_insert2"
              #15/06/09 Sarah add
               #如果新的編碼與舊的不一樣 應該做更新
               IF g_imba_m_o.imba001 != g_imba_m.imba001 AND NOT cl_null(g_imba_m_o.imba001) THEN
                  LET l_count_chk = 0
                  SELECT COUNT(*) INTO l_count_chk
                    FROM imbal_t
                   WHERE imbalent = g_enterprise
                     AND imbaldocno = g_imba_m_o.imbadocno
                  IF l_count_chk > 0 THEN
                     UPDATE imbal_t SET imbaldocno = g_imba_m.imbadocno
                      WHERE imbalent = g_enterprise
                        AND imbaldocno = g_imba_m_o.imbadocno
                     IF SQLCA.sqlcode THEN
                        INITIALIZE g_errparam TO NULL
                        LET g_errparam.extend = 'upd imbal_t'
                        LET g_errparam.code   = SQLCA.sqlcode
                        LET g_errparam.popup  = TRUE
                        CALL cl_err()
                        CALL s_transaction_end('N','0')
                        NEXT FIELD CURRENT
                     END IF
                  END IF
                  LET l_count_chk = 0
                  SELECT COUNT(*) INTO l_count_chk
                    FROM imbo_t
                   WHERE imboent = g_enterprise
                     AND imbodocno = g_imba_m_o.imbadocno
                  IF l_count_chk > 0 THEN
                     UPDATE imbo_t SET imbodocno = g_imba_m.imbadocno,
                                       imbo001 = g_imba_m.imba001
                      WHERE imboent = g_enterprise
                        AND imbodocno = g_imba_m_o.imbadocno
                     IF SQLCA.sqlcode THEN
                        INITIALIZE g_errparam TO NULL
                        LET g_errparam.extend = 'upd imbo_t'
                        LET g_errparam.code   = SQLCA.sqlcode
                        LET g_errparam.popup  = TRUE
                        CALL cl_err()
                        CALL s_transaction_end('N','0')
                        NEXT FIELD CURRENT
                     END IF
                  END IF
                  LET l_count_chk = 0
                  SELECT COUNT(*) INTO l_count_chk
                    FROM imbj_t
                   WHERE imbjent = g_enterprise
                     AND imbjdocno = g_imba_m_o.imbadocno
                  IF l_count_chk > 0 THEN
                     UPDATE imbj_t SET imbjdocno = g_imba_m.imbadocno,
                                       imbj001 = g_imba_m.imba001
                      WHERE imbjent = g_enterprise
                        AND imbjdocno = g_imba_m_o.imbadocno
                     IF SQLCA.sqlcode THEN
                        INITIALIZE g_errparam TO NULL
                        LET g_errparam.extend = 'upd imbj_t'
                        LET g_errparam.code   = SQLCA.sqlcode
                        LET g_errparam.popup  = TRUE
                        CALL cl_err()
                        CALL s_transaction_end('N','0')
                        NEXT FIELD CURRENT
                     END IF
                  END IF
                  LET l_count_chk = 0
                  SELECT COUNT(*) INTO l_count_chk
                    FROM imbk_t
                   WHERE imbkent = g_enterprise
                     AND imbkdocno = g_imba_m_o.imbadocno
                  IF l_count_chk > 0 THEN
                     UPDATE imbk_t SET imbkdocno = g_imba_m.imbadocno,
                                       imbk001 = g_imba_m.imba001
                      WHERE imbkent = g_enterprise
                        AND imbkdocno = g_imba_m_o.imbadocno
                     IF SQLCA.sqlcode THEN
                        INITIALIZE g_errparam TO NULL
                        LET g_errparam.extend = 'upd imbk_t'
                        LET g_errparam.code   = SQLCA.sqlcode
                        LET g_errparam.popup  = TRUE
                        CALL cl_err()
                        CALL s_transaction_end('N','0')
                        NEXT FIELD CURRENT
                     END IF
                  END IF
                  LET l_count_chk = 0
                  SELECT COUNT(*) INTO l_count_chk
                    FROM imbl_t
                   WHERE imblent = g_enterprise
                     AND imbldocno = g_imba_m_o.imbadocno
                  IF l_count_chk > 0 THEN
                     UPDATE imbl_t SET imbldocno = g_imba_m.imbadocno,
                                       imbl001 = g_imba_m.imba001
                      WHERE imblent = g_enterprise
                        AND imbldocno = g_imba_m_o.imbadocno
                     IF SQLCA.sqlcode THEN
                        INITIALIZE g_errparam TO NULL
                        LET g_errparam.extend = 'upd imbl_t'
                        LET g_errparam.code   = SQLCA.sqlcode
                        LET g_errparam.popup  = TRUE
                        CALL cl_err()
                        CALL s_transaction_end('N','0')
                        NEXT FIELD CURRENT
                     END IF
                  END IF
                  LET l_count_chk = 0
                  SELECT COUNT(*) INTO l_count_chk
                    FROM imbm_t
                   WHERE imbment = g_enterprise
                     AND imbmdocno = g_imba_m_o.imbadocno
                  IF l_count_chk > 0 THEN
                     UPDATE imbm_t SET imbmdocno = g_imba_m.imbadocno,
                                       imbm001 = g_imba_m.imba001
                      WHERE imbment = g_enterprise
                        AND imbmdocno = g_imba_m_o.imbadocno
                     IF SQLCA.sqlcode THEN
                        INITIALIZE g_errparam TO NULL
                        LET g_errparam.extend = 'upd imbm_t'
                        LET g_errparam.code   = SQLCA.sqlcode
                        LET g_errparam.popup  = TRUE
                        CALL cl_err()
                        CALL s_transaction_end('N','0')
                        NEXT FIELD CURRENT
                     END IF
                  END IF
               END IF
              #15/06/09 Sarah add
               #end add-point
               
               LET g_master_insert = TRUE
               
               LET p_cmd = 'u'
            ELSE
               CALL s_transaction_begin()
            
               #add-point:單頭修改前 name="input.head.b_update"
   #20151030 by stellar add ----- (S)
               CALL s_aooi390_get_auto_no('1',g_imba_m.imba001) RETURNING l_success,g_imba_m.imba001
               IF NOT l_success THEN
                  CALL s_transaction_end('N','0')
                  NEXT FIELD CURRENT
               END IF

               CALL s_aooi390_oofi_upd('1',g_imba_m.imba001) RETURNING l_success  #增加編碼功能
               IF NOT l_success THEN
                  CALL s_transaction_end('N','0')
                  LET g_imba_m.imba001 = ''
                  DISPLAY BY NAME g_imba_m.imba001
                  RETURN
               END IF
               DISPLAY BY NAME g_imba_m.imba001
   #20151030 by stellar add ----- (E)                 
               LET g_imba_m.imba146 = g_imba_m.imba006  #161004-00020#1 add   
               #end add-point
               
               #將遮罩欄位還原
               CALL aimt300_imba_t_mask_restore('restore_mask_o')
               
               UPDATE imba_t SET (imbadocno,imbadocdt,imba000,imba900,imba901,imbastus,imba001,imba002, 
                   imba009,imba003,imba004,imba005,imba006,imba010,imba126,imba127,imba131,imba128,imba129, 
                   imba130,imba132,imba133,imba134,imba135,imba136,imba137,imba138,imba139,imba140,imba141, 
                   imbaownid,imbaowndp,imbacrtid,imbacrtdp,imbacrtdt,imbamodid,imbamoddt,imbacnfid,imbacnfdt, 
                   imba011,imba012,imba013,imba014,imba142,imba108,imba100,imba109,imba101,imba104,imba105, 
                   imba106,imba107,imba124,imba145,imba146,imba016,imba017,imba018,imba019,imba020,imba021, 
                   imba022,imba023,imba024,imba025,imba026,imba027,imba028,imba029,imba030,imba031,imba032, 
                   imba033,imba034,imba035,imba036,imba037,imba043,imba038,imba041,imba042,imba044,imba122, 
                   imba045,imba123) = (g_imba_m.imbadocno,g_imba_m.imbadocdt,g_imba_m.imba000,g_imba_m.imba900, 
                   g_imba_m.imba901,g_imba_m.imbastus,g_imba_m.imba001,g_imba_m.imba002,g_imba_m.imba009, 
                   g_imba_m.imba003,g_imba_m.imba004,g_imba_m.imba005,g_imba_m.imba006,g_imba_m.imba010, 
                   g_imba_m.imba126,g_imba_m.imba127,g_imba_m.imba131,g_imba_m.imba128,g_imba_m.imba129, 
                   g_imba_m.imba130,g_imba_m.imba132,g_imba_m.imba133,g_imba_m.imba134,g_imba_m.imba135, 
                   g_imba_m.imba136,g_imba_m.imba137,g_imba_m.imba138,g_imba_m.imba139,g_imba_m.imba140, 
                   g_imba_m.imba141,g_imba_m.imbaownid,g_imba_m.imbaowndp,g_imba_m.imbacrtid,g_imba_m.imbacrtdp, 
                   g_imba_m.imbacrtdt,g_imba_m.imbamodid,g_imba_m.imbamoddt,g_imba_m.imbacnfid,g_imba_m.imbacnfdt, 
                   g_imba_m.imba011,g_imba_m.imba012,g_imba_m.imba013,g_imba_m.imba014,g_imba_m.imba142, 
                   g_imba_m.imba108,g_imba_m.imba100,g_imba_m.imba109,g_imba_m.imba101,g_imba_m.imba104, 
                   g_imba_m.imba105,g_imba_m.imba106,g_imba_m.imba107,g_imba_m.imba124,g_imba_m.imba145, 
                   g_imba_m.imba146,g_imba_m.imba016,g_imba_m.imba017,g_imba_m.imba018,g_imba_m.imba019, 
                   g_imba_m.imba020,g_imba_m.imba021,g_imba_m.imba022,g_imba_m.imba023,g_imba_m.imba024, 
                   g_imba_m.imba025,g_imba_m.imba026,g_imba_m.imba027,g_imba_m.imba028,g_imba_m.imba029, 
                   g_imba_m.imba030,g_imba_m.imba031,g_imba_m.imba032,g_imba_m.imba033,g_imba_m.imba034, 
                   g_imba_m.imba035,g_imba_m.imba036,g_imba_m.imba037,g_imba_m.imba043,g_imba_m.imba038, 
                   g_imba_m.imba041,g_imba_m.imba042,g_imba_m.imba044,g_imba_m.imba122,g_imba_m.imba045, 
                   g_imba_m.imba123)
                WHERE imbaent = g_enterprise AND imbadocno = g_imbadocno_t
 
               IF SQLCA.SQLCODE THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "imba_t:",SQLERRMESSAGE 
                  LET g_errparam.code = SQLCA.SQLCODE 
                  LET g_errparam.popup = TRUE 
                  CALL s_transaction_end('N','0')
                  CALL cl_err()
                  NEXT FIELD CURRENT
               END IF
               
               #add-point:單頭修改中 name="input.head.m_update"
               IF p_cmd = 'u' AND (g_imba_m.imba001 <> g_imba_m_t.imba001 OR cl_null(g_imba_m_t.imba001)) THEN
                  IF NOT aimt300_upd_imba001() THEN
                     CALL s_transaction_end('N','0')
                     CONTINUE DIALOG
                  END IF
               END IF
               IF g_con = 'Y' THEN
                  IF p_cmd = 'u' AND g_imba_m.imba003 <> g_imba_m_t.imba003 THEN
                     CALL aimt300_ins_detail() RETURNING l_success
                     IF NOT l_success THEN
                        CALL s_transaction_end('N','0')
                        RETURN
                     END IF
                     CALL s_aimt300_upd_item_site(g_imba_m.imbadocno,g_imba_m.imba001,g_imba_m.imba003) RETURNING l_success
                     IF NOT l_success THEN
                        CALL s_transaction_end('N','0')
                        CONTINUE DIALOG
                     END IF
                  END IF
               END IF
               #160817-00052#1-add-(S)
               #同步更新aimt301的據點生命週期
               IF g_imba_m.imba010 <> g_imba_m_t.imba010 THEN
                  UPDATE imbf_t SET imbf016 = g_imba_m.imba010
                   WHERE imbfent = g_enterprise
                     AND imbfsite = 'ALL'
                     AND imbfdocno = g_imba_m.imbadocno
                     AND imbf001 = g_imba_m.imba001
                  IF SQLCA.sqlcode THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = SQLCA.sqlcode
                     LET g_errparam.extend = "imbf_t"
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                     CALL s_transaction_end('N','0')
                     NEXT FIELD CURRENT 
                  END IF 
               END IF
               #160817-00052#1-add-(E)
               #end add-point
               
               
                        INITIALIZE l_var_keys TO NULL 
         INITIALIZE l_field_keys TO NULL 
         INITIALIZE l_vars TO NULL 
         INITIALIZE l_fields TO NULL 
         IF g_imba_m.imbadocno = g_master_multi_table_t.imbaldocno AND
         g_imba_m.imbal002 = g_master_multi_table_t.imbal002 AND 
         g_imba_m.imbal003 = g_master_multi_table_t.imbal003 AND 
         g_imba_m.imbal004 = g_master_multi_table_t.imbal004  THEN
         ELSE 
            LET l_var_keys[01] = g_enterprise
            LET l_field_keys[01] = 'imbalent'
            LET l_var_keys_bak[01] = g_enterprise
            LET l_var_keys[02] = g_imba_m.imbadocno
            LET l_field_keys[02] = 'imbaldocno'
            LET l_var_keys_bak[02] = g_master_multi_table_t.imbaldocno
            LET l_var_keys[03] = g_dlang
            LET l_field_keys[03] = 'imbal001'
            LET l_var_keys_bak[03] = g_dlang
            LET l_vars[01] = g_imba_m.imbal002
            LET l_fields[01] = 'imbal002'
            LET l_vars[02] = g_imba_m.imbal003
            LET l_fields[02] = 'imbal003'
            LET l_vars[03] = g_imba_m.imbal004
            LET l_fields[03] = 'imbal004'
            CALL cl_multitable(l_var_keys,l_field_keys,l_vars,l_fields,l_var_keys_bak,'imbal_t')
         END IF 
 
               
               #將遮罩欄位進行遮蔽
               CALL aimt300_imba_t_mask_restore('restore_mask_n')
               
               #修改歷程記錄(單頭修改)
               LET g_log1 = util.JSON.stringify(g_imba_m_t)
               LET g_log2 = util.JSON.stringify(g_imba_m)
               IF NOT cl_log_modified_record(g_log1,g_log2) THEN 
                  CALL s_transaction_end('N','0')
               ELSE
                  CALL s_transaction_end('Y','0')
               END IF
               
               #add-point:單頭修改後 name="input.head.a_update"
               
               #end add-point
            END IF
            
            LET g_master_commit = "Y"
            LET g_imbadocno_t = g_imba_m.imbadocno
 
            
      END INPUT
   
 
{</section>}
 
{<section id="aimt300.input.body" >}
   
      #Page1 預設值產生於此處
      INPUT ARRAY g_imbj_d FROM s_detail1.*
          ATTRIBUTE(COUNT = g_rec_b,WITHOUT DEFAULTS, #MAXCOUNT = g_max_rec,
                  INSERT ROW = l_allow_insert, 
                  DELETE ROW = l_allow_delete,
                  APPEND ROW = l_allow_insert)
 
         #自訂ACTION(detail_input,page_1)
         
         
         BEFORE INPUT
            #add-point:資料輸入前 name="input.body.before_input2"
            
            #end add-point
            IF g_insert = 'Y' AND NOT cl_null(g_insert) THEN 
              CALL FGL_SET_ARR_CURR(g_imbj_d.getLength()+1) 
              LET g_insert = 'N' 
           END IF 
 
            CALL aimt300_b_fill()
            #如果一直都在單身1則控制筆數位置
            IF g_loc = 'm' AND g_rec_b != 0 THEN
               CALL FGL_SET_ARR_CURR(g_idx_group.getValue("'1',"))
            END IF
            LET g_loc = 'm'
            LET g_rec_b = g_imbj_d.getLength()
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
            OPEN aimt300_cl USING g_enterprise,g_imba_m.imbadocno
            IF SQLCA.SQLCODE THEN   #(ver:78)
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "OPEN aimt300_cl:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE   #(ver:78)
               LET g_errparam.popup = TRUE 
               CLOSE aimt300_cl
               CALL s_transaction_end('N','0')
               CALL cl_err()
               RETURN
            END IF
            
            LET g_rec_b = g_imbj_d.getLength()
            
            IF g_rec_b >= l_ac 
               AND g_imbj_d[l_ac].imbj002 IS NOT NULL
               AND g_imbj_d[l_ac].imbj003 IS NOT NULL
 
            THEN
               LET l_cmd='u'
               LET g_imbj_d_t.* = g_imbj_d[l_ac].*  #BACKUP
               LET g_imbj_d_o.* = g_imbj_d[l_ac].*  #BACKUP
               CALL aimt300_set_entry_b(l_cmd)
               #add-point:modify段after_set_entry_b name="input.body.after_set_entry_b"
                              
               #end add-point  
               CALL aimt300_set_no_entry_b(l_cmd)
               IF NOT aimt300_lock_b("imbj_t","'1'") THEN
                  LET l_lock_sw='Y'
               ELSE
                  FETCH aimt300_bcl INTO g_imbj_d[l_ac].imbj002,g_imbj_d[l_ac].imbj003,g_imbj_d[l_ac].imbj004, 
                      g_imbj_d[l_ac].imbj005,g_imbj_d[l_ac].imbj006
                  IF SQLCA.SQLCODE THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = g_imbj_d_t.imbj002,":",SQLERRMESSAGE 
                     LET g_errparam.code = SQLCA.SQLCODE 
                     LET g_errparam.popup = TRUE 
                     CALL cl_err()
                     LET l_lock_sw = "Y"
                  END IF
                  
                  #遮罩相關處理
                  LET g_imbj_d_mask_o[l_ac].* =  g_imbj_d[l_ac].*
                  CALL aimt300_imbj_t_mask()
                  LET g_imbj_d_mask_n[l_ac].* =  g_imbj_d[l_ac].*
                  
                  LET g_bfill = "N"
                  CALL aimt300_show()
                  LET g_bfill = "Y"
                  
                  CALL cl_show_fld_cont()
               END IF
            ELSE
               LET l_cmd='a'
            END IF
            #add-point:modify段before row name="input.body.before_row"
                                    CALL aimt300_imbj_desc()
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
            INITIALIZE g_imbj_d[l_ac].* TO NULL 
            INITIALIZE g_imbj_d_t.* TO NULL 
            INITIALIZE g_imbj_d_o.* TO NULL 
            #公用欄位給值(單身)
            
            #自定義預設值
            
            #add-point:modify段before備份 name="input.body.insert.before_bak"
            
            #end add-point
            LET g_imbj_d_t.* = g_imbj_d[l_ac].*     #新輸入資料
            LET g_imbj_d_o.* = g_imbj_d[l_ac].*     #新輸入資料
            CALL cl_show_fld_cont()
            CALL aimt300_set_entry_b(l_cmd)
            #add-point:modify段after_set_entry_b name="input.body.insert.after_set_entry_b"
                        
            #end add-point
            CALL aimt300_set_no_entry_b(l_cmd)
            IF lb_reproduce THEN
               LET lb_reproduce = FALSE
               LET g_imbj_d[li_reproduce_target].* = g_imbj_d[li_reproduce].*
 
               LET g_imbj_d[li_reproduce_target].imbj002 = NULL
               LET g_imbj_d[li_reproduce_target].imbj003 = NULL
 
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
            SELECT COUNT(1) INTO l_count FROM imbj_t 
             WHERE imbjent = g_enterprise AND imbjdocno = g_imba_m.imbadocno
 
               AND imbj002 = g_imbj_d[l_ac].imbj002
               AND imbj003 = g_imbj_d[l_ac].imbj003
 
                
            #資料未重複, 插入新增資料
            IF l_count = 0 THEN 
               #add-point:單身新增前 name="input.body.b_insert"
                              
               #end add-point
            
               #同步新增到同層的table
                              INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_imba_m.imbadocno
               LET gs_keys[2] = g_imbj_d[g_detail_idx].imbj002
               LET gs_keys[3] = g_imbj_d[g_detail_idx].imbj003
               CALL aimt300_insert_b('imbj_t',gs_keys,"'1'")
                           
               #add-point:單身新增後 name="input.body.a_insert"
                              
               #end add-point
            ELSE    
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = 'INSERT' 
               LET g_errparam.code = "std-00006" 
               LET g_errparam.popup = TRUE 
               INITIALIZE g_imbj_d[l_ac].* TO NULL
               CALL s_transaction_end('N','0')
               CALL cl_err()
               CANCEL INSERT
            END IF
 
            IF SQLCA.SQLCODE THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "imbj_t:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE 
               LET g_errparam.popup = TRUE 
               CALL s_transaction_end('N','0')                    
               CALL cl_err()
               CANCEL INSERT
            ELSE
               #先刷新資料
               #CALL aimt300_b_fill()
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
               LET gs_keys[01] = g_imba_m.imbadocno
 
               LET gs_keys[gs_keys.getLength()+1] = g_imbj_d_t.imbj002
               LET gs_keys[gs_keys.getLength()+1] = g_imbj_d_t.imbj003
 
            
               #刪除同層單身
               IF NOT aimt300_delete_b('imbj_t',gs_keys,"'1'") THEN
                  CALL s_transaction_end('N','0')
                  CLOSE aimt300_bcl
                  CANCEL DELETE
               END IF
    
               #刪除下層單身
               IF NOT aimt300_key_delete_b(gs_keys,'imbj_t') THEN
                  CALL s_transaction_end('N','0')
                  CLOSE aimt300_bcl
                  CANCEL DELETE
               END IF
               
               #刪除多語言
               
 
               
               #add-point:單身刪除中 name="input.body.m_delete"
                              
               #end add-point 
               
               CALL s_transaction_end('Y','0')
               CLOSE aimt300_bcl
            
               LET g_rec_b = g_rec_b-1
               #add-point:單身刪除後 name="input.body.a_delete"
                                    
               #end add-point
               LET l_count = g_imbj_d.getLength()
               
               #add-point:單身刪除後(<>d) name="input.body.after_delete"
                        
               #end add-point
            END IF
 
         AFTER DELETE
            #如果是最後一筆
            IF l_ac = (g_imbj_d.getLength() + 1) THEN
               CALL FGL_SET_ARR_CURR(l_ac-1)
            END IF
 
                  #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imbj002
            
            #add-point:AFTER FIELD imbj002 name="input.a.page1.imbj002"
                                    #此段落由子樣板a05產生
            DISPLAY "" TO s_detail1[l_ac].imbj002_desc
            IF  NOT cl_null(g_imba_m.imbadocno) AND NOT cl_null(g_imbj_d[l_ac].imbj002) AND NOT cl_null(g_imbj_d[l_ac].imbj003) THEN 
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND ( l_cmd = 'u' AND (g_imba_m.imbadocno != g_imbadocno_t OR g_imbj_d[l_ac].imbj002 != g_imbj_d_t.imbj002 OR g_imbj_d[l_ac].imbj003 != g_imbj_d_t.imbj003))) THEN 
                  IF NOT ap_chk_notDup(g_imbj_d[l_ac].imbj002,"SELECT COUNT(*) FROM imbj_t WHERE "||"imbjent = '" ||g_enterprise|| "' AND "||"imbjdocno = '"||g_imba_m.imbadocno ||"' AND "|| "imbj002 = '"||g_imbj_d[l_ac].imbj002 ||"' AND "|| "imbj003 = '"||g_imbj_d[l_ac].imbj003 ||"'",'std-00004',0) THEN 
                     LET g_imbj_d[l_ac].imbj002 = g_imbj_d_t.imbj002
                     CALL aimt300_imbj_desc()
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF
            IF NOT cl_null(g_imbj_d[l_ac].imbj002) THEN
               LET p_req_data[1] = 270
               LET p_req_data[2] = g_imbj_d[l_ac].imbj002
               CALL s_aimt300_fields_chk('ACC',p_req_data,'Y') RETURNING l_success,g_errno
               IF NOT l_success THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = g_errno
                  LET g_errparam.extend = g_imbj_d[l_ac].imbj002
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  LET g_imbj_d[l_ac].imbj002 = g_imbj_d_t.imbj002
                  CALL aimt300_imbj_desc()
                  NEXT FIELD imbj002
               END IF
            END IF
            CALL aimt300_imbj_desc()
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imbj002
            #add-point:BEFORE FIELD imbj002 name="input.b.page1.imbj002"
                        
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE imbj002
            #add-point:ON CHANGE imbj002 name="input.g.page1.imbj002"
                        
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imbj003
            
            #add-point:AFTER FIELD imbj003 name="input.a.page1.imbj003"
                                    #此段落由子樣板a05產生
            DISPLAY "" TO s_detail1[l_ac].imbj003_desc
            IF NOT cl_null(g_imba_m.imbadocno) AND NOT cl_null(g_imbj_d[l_ac].imbj002) AND NOT cl_null(g_imbj_d[l_ac].imbj003) THEN 
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND ( l_cmd = 'u' AND (g_imba_m.imbadocno != g_imbadocno_t OR g_imbj_d[l_ac].imbj002 != g_imbj_d_t.imbj002 OR g_imbj_d[l_ac].imbj003 != g_imbj_d_t.imbj003))) THEN 
                  IF NOT ap_chk_notDup(g_imbj_d[l_ac].imbj003,"SELECT COUNT(*) FROM imbj_t WHERE "||"imbjent = '" ||g_enterprise|| "' AND "||"imbjdocno = '"||g_imba_m.imbadocno ||"' AND "|| "imbj002 = '"||g_imbj_d[l_ac].imbj002 ||"' AND "|| "imbj003 = '"||g_imbj_d[l_ac].imbj003 ||"'",'std-00004',0) THEN 
                     LET g_imbj_d[l_ac].imbj005 = g_imbj_d_t.imbj005
                     CALL aimt300_imbj_desc()
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF
            IF NOT cl_null(g_imbj_d[l_ac].imbj003) THEN
               LET p_req_data[1] = 271
               LET p_req_data[2] = g_imbj_d[l_ac].imbj003
               CALL s_aimt300_fields_chk('ACC',p_req_data,'Y') RETURNING l_success,g_errno
               IF NOT l_success THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = g_errno
                  LET g_errparam.extend = g_imbj_d[l_ac].imbj003
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  LET g_imbj_d[l_ac].imbj003 = g_imbj_d_t.imbj003
                  CALL aimt300_imbj_desc()
                  NEXT FIELD imbj003
               END IF
            END IF
            CALL aimt300_imbj_desc()
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imbj003
            #add-point:BEFORE FIELD imbj003 name="input.b.page1.imbj003"
                        
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE imbj003
            #add-point:ON CHANGE imbj003 name="input.g.page1.imbj003"
                        
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imbj004
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_imbj_d[l_ac].imbj004,"0","1","","","azz-00079",1) THEN
               NEXT FIELD imbj004
            END IF 
 
 
 
            #add-point:AFTER FIELD imbj004 name="input.a.page1.imbj004"
                                    IF NOT cl_null(g_imbj_d[l_ac].imbj004) THEN 
            END IF 

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imbj004
            #add-point:BEFORE FIELD imbj004 name="input.b.page1.imbj004"
                        
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE imbj004
            #add-point:ON CHANGE imbj004 name="input.g.page1.imbj004"
                        
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imbj005
            
            #add-point:AFTER FIELD imbj005 name="input.a.page1.imbj005"
                                    DISPLAY "" TO s_detail1[l_ac].imbj005_desc
            IF NOT cl_null(g_imbj_d[l_ac].imbj005) THEN
               CALL aimt300_imbj_desc()
               LET p_req_data[1] = g_imbj_d[l_ac].imbj005
               CALL s_aimt300_fields_chk('imba018',p_req_data,'Y') RETURNING l_success,g_errno
               IF NOT l_success THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = g_errno
                  LET g_errparam.extend = g_imbj_d[l_ac].imbj005
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  LET g_imbj_d[l_ac].imbj005 = g_imbj_d_t.imbj005
                  CALL aimt300_imbj_desc()
                  NEXT FIELD imbj005
               END IF
            END IF
            CALL aimt300_imbj_desc()
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imbj005
            #add-point:BEFORE FIELD imbj005 name="input.b.page1.imbj005"
                        
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE imbj005
            #add-point:ON CHANGE imbj005 name="input.g.page1.imbj005"
                        
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imbj006
            
            #add-point:AFTER FIELD imbj006 name="input.a.page1.imbj006"
                                    DISPLAY "" TO s_detail1[l_ac].imbj006_desc
            IF NOT cl_null(g_imbj_d[l_ac].imbj006) THEN
               CALL aimt300_imbj_desc()
               LET p_req_data[1] = 272
               LET p_req_data[2] = g_imbj_d[l_ac].imbj006
               CALL s_aimt300_fields_chk('ACC',p_req_data,'Y') RETURNING l_success,g_errno
               IF NOT l_success THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = g_errno
                  LET g_errparam.extend = g_imbj_d[l_ac].imbj006
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  LET g_imbj_d[l_ac].imbj006 = g_imbj_d_t.imbj006
                  CALL aimt300_imbj_desc()
                  NEXT FIELD imbj006
               END IF
            END IF
            CALL aimt300_imbj_desc()
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imbj006
            #add-point:BEFORE FIELD imbj006 name="input.b.page1.imbj006"
                        
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE imbj006
            #add-point:ON CHANGE imbj006 name="input.g.page1.imbj006"
                        
            #END add-point 
 
 
 
                  #Ctrlp:input.c.page1.imbj002
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imbj002
            #add-point:ON ACTION controlp INFIELD imbj002 name="input.c.page1.imbj002"
                        #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL  #160510-00028#1  add
            LET g_qryparam.state = 'i'       #160510-00028#1  add
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_imbj_d[l_ac].imbj002             #給予default值

            #給予arg

            LET g_qryparam.arg1 = "270" #應用分類
            CALL q_oocq002_1()                                      #呼叫開窗

            LET g_imbj_d[l_ac].imbj002 = g_qryparam.return1              #將開窗取得的值回傳到變數

            DISPLAY g_imbj_d[l_ac].imbj002 TO imbj002              #顯示到畫面上
            CALL aimt300_imbj_desc()
            NEXT FIELD imbj002                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.page1.imbj003
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imbj003
            #add-point:ON ACTION controlp INFIELD imbj003 name="input.c.page1.imbj003"
                        #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL  #160510-00028#1  add
            LET g_qryparam.state = 'i'       #160510-00028#1  add
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_imbj_d[l_ac].imbj003             #給予default值

            #給予arg

            LET g_qryparam.arg1 = "271" #應用分類
            CALL q_oocq002_1()                                  #呼叫開窗

            LET g_imbj_d[l_ac].imbj003 = g_qryparam.return1              #將開窗取得的值回傳到變數

            DISPLAY g_imbj_d[l_ac].imbj003 TO imbj003              #顯示到畫面上
            CALL aimt300_imbj_desc()
            NEXT FIELD imbj003                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.page1.imbj004
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imbj004
            #add-point:ON ACTION controlp INFIELD imbj004 name="input.c.page1.imbj004"
                        
            #END add-point
 
 
         #Ctrlp:input.c.page1.imbj005
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imbj005
            #add-point:ON ACTION controlp INFIELD imbj005 name="input.c.page1.imbj005"
                        #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL  #160510-00028#1  add
            LET g_qryparam.state = 'i'       #160510-00028#1  add
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_imbj_d[l_ac].imbj005             #給予default值

            #給予arg
            LET g_qryparam.where = " ooca003 = '3'"
            CALL q_ooca001_1()                                #呼叫開窗

            LET g_imbj_d[l_ac].imbj005 = g_qryparam.return1              #將開窗取得的值回傳到變數

            DISPLAY g_imbj_d[l_ac].imbj005 TO imbj005              #顯示到畫面上
            CALL aimt300_imbj_desc()
            LET g_qryparam.where = ""
            NEXT FIELD imbj005                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.page1.imbj006
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imbj006
            #add-point:ON ACTION controlp INFIELD imbj006 name="input.c.page1.imbj006"
                        #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL  #160510-00028#1  add
            LET g_qryparam.state = 'i'       #160510-00028#1  add
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_imbj_d[l_ac].imbj006             #給予default值

            #給予arg

            LET g_qryparam.arg1 = "272" #應用分類
            CALL q_oocq002_1()                                     #呼叫開窗

            LET g_imbj_d[l_ac].imbj006 = g_qryparam.return1              #將開窗取得的值回傳到變數

            DISPLAY g_imbj_d[l_ac].imbj006 TO imbj006              #顯示到畫面上
            CALL aimt300_imbj_desc()
            NEXT FIELD imbj006                          #返回原欄位


            #END add-point
 
 
 
 
         ON ROW CHANGE
            IF INT_FLAG THEN
               LET INT_FLAG = 0
               LET g_imbj_d[l_ac].* = g_imbj_d_t.*
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code = 9001 
               LET g_errparam.popup = FALSE 
               CLOSE aimt300_bcl
               CALL s_transaction_end('N','0')
               CALL cl_err()
               EXIT DIALOG 
            END IF
              
            IF l_lock_sw = 'Y' THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = g_imbj_d[l_ac].imbj002 
               LET g_errparam.code = -263 
               LET g_errparam.popup = TRUE 
               CALL cl_err()
               LET g_imbj_d[l_ac].* = g_imbj_d_t.*
            ELSE
            
               #add-point:單身修改前 name="input.body.b_update"
                              
               #end add-point
               
               #寫入修改者/修改日期資訊(單身)
               
      
               #將遮罩欄位還原
               CALL aimt300_imbj_t_mask_restore('restore_mask_o')
      
               UPDATE imbj_t SET (imbjdocno,imbj002,imbj003,imbj004,imbj005,imbj006) = (g_imba_m.imbadocno, 
                   g_imbj_d[l_ac].imbj002,g_imbj_d[l_ac].imbj003,g_imbj_d[l_ac].imbj004,g_imbj_d[l_ac].imbj005, 
                   g_imbj_d[l_ac].imbj006)
                WHERE imbjent = g_enterprise AND imbjdocno = g_imba_m.imbadocno 
 
                  AND imbj002 = g_imbj_d_t.imbj002 #項次   
                  AND imbj003 = g_imbj_d_t.imbj003  
 
                  
               #add-point:單身修改中 name="input.body.m_update"
                              
               #end add-point
               CASE
                  WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
                     LET g_imbj_d[l_ac].* = g_imbj_d_t.*
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "imbj_t" 
                     LET g_errparam.code = "std-00009" 
                     LET g_errparam.popup = TRUE 
                     CALL s_transaction_end('N','0')
                     CALL cl_err()
                     
                  WHEN SQLCA.SQLCODE #其他錯誤
                     LET g_imbj_d[l_ac].* = g_imbj_d_t.*  
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "imbj_t:",SQLERRMESSAGE 
                     LET g_errparam.code = SQLCA.SQLCODE 
                     LET g_errparam.popup = TRUE 
                     CALL s_transaction_end('N','0')
                     CALL cl_err()                   
                     
                  OTHERWISE
                     #資料多語言用-增/改
                     
                                    INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_imba_m.imbadocno
               LET gs_keys_bak[1] = g_imbadocno_t
               LET gs_keys[2] = g_imbj_d[g_detail_idx].imbj002
               LET gs_keys_bak[2] = g_imbj_d_t.imbj002
               LET gs_keys[3] = g_imbj_d[g_detail_idx].imbj003
               LET gs_keys_bak[3] = g_imbj_d_t.imbj003
               CALL aimt300_update_b('imbj_t',gs_keys,gs_keys_bak,"'1'")
               END CASE
 
               #將遮罩欄位進行遮蔽
               CALL aimt300_imbj_t_mask_restore('restore_mask_n')
               
               #判斷key是否有改變
               INITIALIZE gs_keys TO NULL
               IF NOT(g_imbj_d[g_detail_idx].imbj002 = g_imbj_d_t.imbj002 
                  AND g_imbj_d[g_detail_idx].imbj003 = g_imbj_d_t.imbj003 
 
                  ) THEN
                  LET gs_keys[01] = g_imba_m.imbadocno
 
                  LET gs_keys[gs_keys.getLength()+1] = g_imbj_d_t.imbj002
                  LET gs_keys[gs_keys.getLength()+1] = g_imbj_d_t.imbj003
 
                  CALL aimt300_key_update_b(gs_keys,'imbj_t')
               END IF
               
               #修改歷程記錄(單身修改)
               LET g_log1 = util.JSON.stringify(g_imba_m),util.JSON.stringify(g_imbj_d_t)
               LET g_log2 = util.JSON.stringify(g_imba_m),util.JSON.stringify(g_imbj_d[l_ac])
               IF NOT cl_log_modified_record_d(g_log1,g_log2) THEN 
                  CALL s_transaction_end('N','0')
               END IF
               
               #add-point:單身修改後 name="input.body.a_update"
                              
               #end add-point
 
            END IF
            
         AFTER ROW
            #add-point:單身after_row name="input.body.after_row"
                        
            #end add-point
            CALL aimt300_unlock_b("imbj_t","'1'")
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
               LET g_imbj_d[li_reproduce_target].* = g_imbj_d[li_reproduce].*
 
               LET g_imbj_d[li_reproduce_target].imbj002 = NULL
               LET g_imbj_d[li_reproduce_target].imbj003 = NULL
 
            ELSE
               CALL FGL_SET_ARR_CURR(g_imbj_d.getLength()+1)
               LET lb_reproduce = TRUE
               LET li_reproduce = l_ac
               LET li_reproduce_target = g_imbj_d.getLength()+1
            END IF
            
         #ON ACTION cancel
         #   LET INT_FLAG = 1
         #   LET g_detail_idx = 1
         #   EXIT DIALOG 
 
      END INPUT
      
      INPUT ARRAY g_imbj2_d FROM s_detail2.*
         ATTRIBUTE(COUNT = g_rec_b,WITHOUT DEFAULTS, #MAXCOUNT = g_max_rec,
                 INSERT ROW = l_allow_insert, #此頁面insert功能由產生器控制, 手動之設定無效! 
 
                 DELETE ROW = l_allow_delete,
                 APPEND ROW = l_allow_insert)
                 
         #自訂ACTION(detail_input,page_2)
         
         
         BEFORE INPUT
            #add-point:資料輸入前 name="input.body2.before_input2"
            
            #end add-point
            IF g_insert = 'Y' AND NOT cl_null(g_insert) THEN 
              CALL FGL_SET_ARR_CURR(g_imbj2_d.getLength()+1) 
              LET g_insert = 'N' 
           END IF 
 
            CALL aimt300_b_fill()
            #如果一直都在單身1則控制筆數位置
            IF g_loc = 'd' AND g_rec_b != 0 THEN
               CALL FGL_SET_ARR_CURR(g_idx_group.getValue("'2',"))
            END IF
            LET g_loc = 'd'
            LET g_rec_b = g_imbj2_d.getLength()
            #add-point:資料輸入前 name="input.body2.before_input"
                        
            #end add-point
            
         BEFORE INSERT
            IF s_transaction_chk("N",0) THEN
               CALL s_transaction_begin()
            END IF
            LET l_insert = TRUE
            LET l_n = ARR_COUNT()
            LET l_cmd = 'a'
            INITIALIZE g_imbj2_d[l_ac].* TO NULL 
            INITIALIZE g_imbj2_d_t.* TO NULL 
            INITIALIZE g_imbj2_d_o.* TO NULL 
            #公用欄位給值(單身2)
            
            #自定義預設值(單身2)
            
            #add-point:modify段before備份 name="input.body2.insert.before_bak"
            
            #end add-point
            LET g_imbj2_d_t.* = g_imbj2_d[l_ac].*     #新輸入資料
            LET g_imbj2_d_o.* = g_imbj2_d[l_ac].*     #新輸入資料
            CALL cl_show_fld_cont()
            CALL aimt300_set_entry_b(l_cmd)
            #add-point:modify段after_set_entry_b name="input.body2.insert.after_set_entry_b"
                        
            #end add-point
            CALL aimt300_set_no_entry_b(l_cmd)
            IF lb_reproduce THEN
               LET lb_reproduce = FALSE
               LET g_imbj2_d[li_reproduce_target].* = g_imbj2_d[li_reproduce].*
 
               LET g_imbj2_d[li_reproduce_target].imbl002 = NULL
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
            OPEN aimt300_cl USING g_enterprise,g_imba_m.imbadocno
            IF SQLCA.SQLCODE THEN   #(ver:78)
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "OPEN aimt300_cl:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE   #(ver:78)
               LET g_errparam.popup = TRUE 
               CLOSE aimt300_cl
               CALL s_transaction_end('N','0')
               CALL cl_err()
               RETURN
            END IF
            
            LET g_rec_b = g_imbj2_d.getLength()
            
            IF g_rec_b >= l_ac 
               AND g_imbj2_d[l_ac].imbl002 IS NOT NULL
            THEN 
               LET l_cmd='u'
               LET g_imbj2_d_t.* = g_imbj2_d[l_ac].*  #BACKUP
               LET g_imbj2_d_o.* = g_imbj2_d[l_ac].*  #BACKUP
               CALL aimt300_set_entry_b(l_cmd)
               #add-point:modify段after_set_entry_b name="input.body2.after_set_entry_b"
                              
               #end add-point  
               CALL aimt300_set_no_entry_b(l_cmd)
               IF NOT aimt300_lock_b("imbl_t","'2'") THEN
                  LET l_lock_sw='Y'
               ELSE
                  FETCH aimt300_bcl2 INTO g_imbj2_d[l_ac].imbl002
                  IF SQLCA.SQLCODE THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = SQLERRMESSAGE  
                     LET g_errparam.code = SQLCA.SQLCODE 
                     LET g_errparam.popup = TRUE 
                     CALL cl_err()
                     LET l_lock_sw = "Y"
                  END IF
                  
                  #遮罩相關處理
                  LET g_imbj2_d_mask_o[l_ac].* =  g_imbj2_d[l_ac].*
                  CALL aimt300_imbl_t_mask()
                  LET g_imbj2_d_mask_n[l_ac].* =  g_imbj2_d[l_ac].*
                  
                  LET g_bfill = "N"
                  CALL aimt300_show()
                  LET g_bfill = "Y"
                  
                  CALL cl_show_fld_cont()
               END IF
            ELSE
               LET l_cmd='a'
            END IF
            #add-point:modify段before row name="input.body2.before_row"
                                    CALL aimt300_imbl_desc() 
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
               LET gs_keys[01] = g_imba_m.imbadocno
               LET gs_keys[gs_keys.getLength()+1] = g_imbj2_d_t.imbl002
            
               #刪除同層單身
               IF NOT aimt300_delete_b('imbl_t',gs_keys,"'2'") THEN
                  CALL s_transaction_end('N','0')
                  CLOSE aimt300_bcl
                  CANCEL DELETE
               END IF
    
               #刪除下層單身
               IF NOT aimt300_key_delete_b(gs_keys,'imbl_t') THEN
                  CALL s_transaction_end('N','0')
                  CLOSE aimt300_bcl
                  CANCEL DELETE
               END IF
               
               #刪除多語言
               
 
               
               #add-point:單身2刪除中 name="input.body2.m_delete"
                              
               #end add-point    
               
               CALL s_transaction_end('Y','0')
               CLOSE aimt300_bcl
 
               LET g_rec_b = g_rec_b-1
               #add-point:單身2刪除後 name="input.body2.a_delete"
                                    
               #end add-point
               LET l_count = g_imbj_d.getLength()
               
               #add-point:單身刪除後(<>d) name="input.body2.after_delete"
                        
               #end add-point
            END IF 
 
         AFTER DELETE
            #如果是最後一筆
            IF l_ac = (g_imbj2_d.getLength() + 1) THEN
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
            SELECT COUNT(1) INTO l_count FROM imbl_t 
             WHERE imblent = g_enterprise AND imbldocno = g_imba_m.imbadocno
               AND imbl002 = g_imbj2_d[l_ac].imbl002
                
            #資料未重複, 插入新增資料
            IF l_count = 0 THEN 
               #add-point:單身2新增前 name="input.body2.b_insert"
                              
               #end add-point
            
                              INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_imba_m.imbadocno
               LET gs_keys[2] = g_imbj2_d[g_detail_idx].imbl002
               CALL aimt300_insert_b('imbl_t',gs_keys,"'2'")
                           
               #add-point:單身新增後2 name="input.body2.a_insert"
                              
               #end add-point
            ELSE    
               INITIALIZE g_imbj_d[l_ac].* TO NULL
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
               LET g_errparam.extend = "imbl_t:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE 
               LET g_errparam.popup = TRUE 
               CALL s_transaction_end('N','0')                    
               CALL cl_err()
               CANCEL INSERT
            ELSE
               #先刷新資料
               #CALL aimt300_b_fill()
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
               LET g_imbj2_d[l_ac].* = g_imbj2_d_t.*
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code = 9001 
               LET g_errparam.popup = FALSE 
               CLOSE aimt300_bcl2
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
               LET g_imbj2_d[l_ac].* = g_imbj2_d_t.*
            ELSE
               #add-point:單身page2修改前 name="input.body2.b_update"
                              
               #end add-point
               
               #寫入修改者/修改日期資訊(單身2)
               
               
               #將遮罩欄位還原
               CALL aimt300_imbl_t_mask_restore('restore_mask_o')
                              
               UPDATE imbl_t SET (imbldocno,imbl002) = (g_imba_m.imbadocno,g_imbj2_d[l_ac].imbl002)  
                   #自訂欄位頁簽
                WHERE imblent = g_enterprise AND imbldocno = g_imba_m.imbadocno
                  AND imbl002 = g_imbj2_d_t.imbl002 #項次 
                  
               #add-point:單身page2修改中 name="input.body2.m_update"
                              
               #end add-point
                  
               CASE
                  WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
                     LET g_imbj2_d[l_ac].* = g_imbj2_d_t.*
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "imbl_t" 
                     LET g_errparam.code = "std-00009" 
                     LET g_errparam.popup = TRUE 
                     CALL s_transaction_end('N','0')
                     CALL cl_err()
                     
                  WHEN SQLCA.SQLCODE #其他錯誤
                     LET g_imbj2_d[l_ac].* = g_imbj2_d_t.*
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "imbl_t:",SQLERRMESSAGE 
                     LET g_errparam.code = SQLCA.SQLCODE 
                     LET g_errparam.popup = TRUE 
                     CALL s_transaction_end('N','0')
                     CALL cl_err()
                     
                  OTHERWISE
                     #資料多語言用-增/改
                     
                                    INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_imba_m.imbadocno
               LET gs_keys_bak[1] = g_imbadocno_t
               LET gs_keys[2] = g_imbj2_d[g_detail_idx].imbl002
               LET gs_keys_bak[2] = g_imbj2_d_t.imbl002
               CALL aimt300_update_b('imbl_t',gs_keys,gs_keys_bak,"'2'")
               END CASE
               
               #將遮罩欄位進行遮蔽
               CALL aimt300_imbl_t_mask_restore('restore_mask_n')
               
               #判斷key是否有改變
               INITIALIZE gs_keys TO NULL
               IF NOT (g_imbj2_d[g_detail_idx].imbl002 = g_imbj2_d_t.imbl002 
                  ) THEN
                  LET gs_keys[01] = g_imba_m.imbadocno
                  LET gs_keys[gs_keys.getLength()+1] = g_imbj2_d_t.imbl002
                  CALL aimt300_key_update_b(gs_keys,'imbl_t')
               END IF
               
               #修改歷程記錄(單身修改)
               LET g_log1 = util.JSON.stringify(g_imba_m),util.JSON.stringify(g_imbj2_d_t)
               LET g_log2 = util.JSON.stringify(g_imba_m),util.JSON.stringify(g_imbj2_d[l_ac])
               IF NOT cl_log_modified_record_d(g_log1,g_log2) THEN 
                  CALL s_transaction_end('N','0')
               END IF
               
               #add-point:單身page2修改後 name="input.body2.a_update"
                              
               #end add-point
            END IF
         
                  #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imbl002
            #add-point:BEFORE FIELD imbl002 name="input.b.page2.imbl002"
                        
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imbl002
            
            #add-point:AFTER FIELD imbl002 name="input.a.page2.imbl002"
                                    #此段落由子樣板a05產生
            DISPLAY "" TO s_detail2[l_ac].oocql004
            DISPLAY "" TO s_detail2[l_ac].oocq005
            IF NOT cl_null(g_imba_m.imbadocno) AND NOT cl_null(g_imbj2_d[l_ac].imbl002) THEN
               CALL aimt300_imbl_desc()            
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND ( l_cmd = 'u' AND (g_imba_m.imbadocno != g_imbadocno_t OR g_imbj2_d[l_ac].imbl002 != g_imbj2_d_t.imbl002))) THEN 
                  IF NOT ap_chk_notDup(g_imbj2_d[l_ac].imbl002,"SELECT COUNT(*) FROM imbl_t WHERE "||"imblent = '" ||g_enterprise|| "' AND "||"imbldocno = '"||g_imba_m.imbadocno ||"' AND "|| "imbl002 = '"||g_imbj2_d[l_ac].imbl002 ||"'",'std-00004',0) THEN 
                     LET g_imbj2_d[l_ac].imbl002 = g_imbj2_d_t.imbl002
                     CALL aimt300_imbl_desc()
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF
            IF NOT cl_null(g_imbj2_d[l_ac].imbl002) THEN
               CALL aimt300_imbl_desc()
               LET p_req_data[1] = 213
               LET p_req_data[2] = g_imbj2_d[l_ac].imbl002
               CALL s_aimt300_fields_chk('ACC',p_req_data,'Y') RETURNING l_success,g_errno
               IF NOT l_success THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = g_errno
                  LET g_errparam.extend = g_imbj2_d[l_ac].imbl002
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  LET g_imbj2_d[l_ac].imbl002 = g_imbj2_d_t.imbl002
                  CALL aimt300_imbl_desc()
                  NEXT FIELD imbl002
               END IF
            END IF
            CALL aimt300_imbl_desc()     

            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE imbl002
            #add-point:ON CHANGE imbl002 name="input.g.page2.imbl002"
                        
            #END add-point 
 
 
 
                  #Ctrlp:input.c.page2.imbl002
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imbl002
            #add-point:ON ACTION controlp INFIELD imbl002 name="input.c.page2.imbl002"
                        #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL  #160510-00028#1  add
            LET g_qryparam.state = 'i'       #160510-00028#1  add
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_imbj2_d[l_ac].imbl002             #給予default值

            #給予arg

            LET g_qryparam.arg1 = "213" #應用分類
            CALL q_oocq002_1()                                #呼叫開窗

            LET g_imbj2_d[l_ac].imbl002 = g_qryparam.return1              #將開窗取得的值回傳到變數

            DISPLAY g_imbj2_d[l_ac].imbl002 TO imbl002              #顯示到畫面上
            CALL aimt300_imbl_desc() 
            NEXT FIELD imbl002                          #返回原欄位


            #END add-point
 
 
 
 
         AFTER ROW
            #add-point:單身page2 after_row name="input.body2.after_row"
                        
            #end add-point
            LET l_ac = ARR_CURR()
            IF INT_FLAG THEN
               LET INT_FLAG = 0
               IF l_cmd = 'u' THEN
                  LET g_imbj2_d[l_ac].* = g_imbj2_d_t.*
               END IF
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code = 9001 
               LET g_errparam.popup = FALSE 
               CLOSE aimt300_bcl2
               CALL s_transaction_end('N','0')
               CALL cl_err()
               EXIT DIALOG 
            END IF
            
            #其他table進行unlock
            
            CALL aimt300_unlock_b("imbl_t","'2'")
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
               LET g_imbj2_d[li_reproduce_target].* = g_imbj2_d[li_reproduce].*
 
               LET g_imbj2_d[li_reproduce_target].imbl002 = NULL
            ELSE
               CALL FGL_SET_ARR_CURR(g_imbj2_d.getLength()+1)
               LET lb_reproduce = TRUE
               LET li_reproduce = l_ac
               LET li_reproduce_target = g_imbj2_d.getLength()+1
            END IF
            
      END INPUT
      INPUT ARRAY g_imbj3_d FROM s_detail3.*
         ATTRIBUTE(COUNT = g_rec_b,WITHOUT DEFAULTS, #MAXCOUNT = g_max_rec,
                 INSERT ROW = l_allow_insert, #此頁面insert功能由產生器控制, 手動之設定無效! 
 
                 DELETE ROW = l_allow_delete,
                 APPEND ROW = l_allow_insert)
                 
         #自訂ACTION(detail_input,page_3)
         
         
         BEFORE INPUT
            #add-point:資料輸入前 name="input.body3.before_input2"
            
            #end add-point
            IF g_insert = 'Y' AND NOT cl_null(g_insert) THEN 
              CALL FGL_SET_ARR_CURR(g_imbj3_d.getLength()+1) 
              LET g_insert = 'N' 
           END IF 
 
            CALL aimt300_b_fill()
            #如果一直都在單身1則控制筆數位置
            IF g_loc = 'd' AND g_rec_b != 0 THEN
               CALL FGL_SET_ARR_CURR(g_idx_group.getValue("'3',"))
            END IF
            LET g_loc = 'd'
            LET g_rec_b = g_imbj3_d.getLength()
            #add-point:資料輸入前 name="input.body3.before_input"
                        
            #end add-point
            
         BEFORE INSERT
            IF s_transaction_chk("N",0) THEN
               CALL s_transaction_begin()
            END IF
            LET l_insert = TRUE
            LET l_n = ARR_COUNT()
            LET l_cmd = 'a'
            INITIALIZE g_imbj3_d[l_ac].* TO NULL 
            INITIALIZE g_imbj3_d_t.* TO NULL 
            INITIALIZE g_imbj3_d_o.* TO NULL 
            #公用欄位給值(單身3)
            
            #自定義預設值(單身3)
            
            #add-point:modify段before備份 name="input.body3.insert.before_bak"
            
            #end add-point
            LET g_imbj3_d_t.* = g_imbj3_d[l_ac].*     #新輸入資料
            LET g_imbj3_d_o.* = g_imbj3_d[l_ac].*     #新輸入資料
            CALL cl_show_fld_cont()
            CALL aimt300_set_entry_b(l_cmd)
            #add-point:modify段after_set_entry_b name="input.body3.insert.after_set_entry_b"
                        
            #end add-point
            CALL aimt300_set_no_entry_b(l_cmd)
            IF lb_reproduce THEN
               LET lb_reproduce = FALSE
               LET g_imbj3_d[li_reproduce_target].* = g_imbj3_d[li_reproduce].*
 
               LET g_imbj3_d[li_reproduce_target].imbm002 = NULL
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
            OPEN aimt300_cl USING g_enterprise,g_imba_m.imbadocno
            IF SQLCA.SQLCODE THEN   #(ver:78)
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "OPEN aimt300_cl:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE   #(ver:78)
               LET g_errparam.popup = TRUE 
               CLOSE aimt300_cl
               CALL s_transaction_end('N','0')
               CALL cl_err()
               RETURN
            END IF
            
            LET g_rec_b = g_imbj3_d.getLength()
            
            IF g_rec_b >= l_ac 
               AND g_imbj3_d[l_ac].imbm002 IS NOT NULL
            THEN 
               LET l_cmd='u'
               LET g_imbj3_d_t.* = g_imbj3_d[l_ac].*  #BACKUP
               LET g_imbj3_d_o.* = g_imbj3_d[l_ac].*  #BACKUP
               CALL aimt300_set_entry_b(l_cmd)
               #add-point:modify段after_set_entry_b name="input.body3.after_set_entry_b"
                              
               #end add-point  
               CALL aimt300_set_no_entry_b(l_cmd)
               IF NOT aimt300_lock_b("imbm_t","'3'") THEN
                  LET l_lock_sw='Y'
               ELSE
                  FETCH aimt300_bcl3 INTO g_imbj3_d[l_ac].imbm002,g_imbj3_d[l_ac].imbm005,g_imbj3_d[l_ac].imbm003, 
                      g_imbj3_d[l_ac].imbm006,g_imbj3_d[l_ac].imbm004
                  IF SQLCA.SQLCODE THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = SQLERRMESSAGE  
                     LET g_errparam.code = SQLCA.SQLCODE 
                     LET g_errparam.popup = TRUE 
                     CALL cl_err()
                     LET l_lock_sw = "Y"
                  END IF
                  
                  #遮罩相關處理
                  LET g_imbj3_d_mask_o[l_ac].* =  g_imbj3_d[l_ac].*
                  CALL aimt300_imbm_t_mask()
                  LET g_imbj3_d_mask_n[l_ac].* =  g_imbj3_d[l_ac].*
                  
                  LET g_bfill = "N"
                  CALL aimt300_show()
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
               LET gs_keys[01] = g_imba_m.imbadocno
               LET gs_keys[gs_keys.getLength()+1] = g_imbj3_d_t.imbm002
            
               #刪除同層單身
               IF NOT aimt300_delete_b('imbm_t',gs_keys,"'3'") THEN
                  CALL s_transaction_end('N','0')
                  CLOSE aimt300_bcl
                  CANCEL DELETE
               END IF
    
               #刪除下層單身
               IF NOT aimt300_key_delete_b(gs_keys,'imbm_t') THEN
                  CALL s_transaction_end('N','0')
                  CLOSE aimt300_bcl
                  CANCEL DELETE
               END IF
               
               #刪除多語言
               
 
               
               #add-point:單身3刪除中 name="input.body3.m_delete"
                              
               #end add-point    
               
               CALL s_transaction_end('Y','0')
               CLOSE aimt300_bcl
 
               LET g_rec_b = g_rec_b-1
               #add-point:單身3刪除後 name="input.body3.a_delete"
                                    
               #end add-point
               LET l_count = g_imbj_d.getLength()
               
               #add-point:單身刪除後(<>d) name="input.body3.after_delete"
                        
               #end add-point
            END IF 
 
         AFTER DELETE
            #如果是最後一筆
            IF l_ac = (g_imbj3_d.getLength() + 1) THEN
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
            SELECT COUNT(1) INTO l_count FROM imbm_t 
             WHERE imbment = g_enterprise AND imbmdocno = g_imba_m.imbadocno
               AND imbm002 = g_imbj3_d[l_ac].imbm002
                
            #資料未重複, 插入新增資料
            IF l_count = 0 THEN 
               #add-point:單身3新增前 name="input.body3.b_insert"
                              
               #end add-point
            
                              INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_imba_m.imbadocno
               LET gs_keys[2] = g_imbj3_d[g_detail_idx].imbm002
               CALL aimt300_insert_b('imbm_t',gs_keys,"'3'")
                           
               #add-point:單身新增後3 name="input.body3.a_insert"
                              
               #end add-point
            ELSE    
               INITIALIZE g_imbj_d[l_ac].* TO NULL
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
               LET g_errparam.extend = "imbm_t:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE 
               LET g_errparam.popup = TRUE 
               CALL s_transaction_end('N','0')                    
               CALL cl_err()
               CANCEL INSERT
            ELSE
               #先刷新資料
               #CALL aimt300_b_fill()
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
               LET g_imbj3_d[l_ac].* = g_imbj3_d_t.*
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code = 9001 
               LET g_errparam.popup = FALSE 
               CLOSE aimt300_bcl3
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
               LET g_imbj3_d[l_ac].* = g_imbj3_d_t.*
            ELSE
               #add-point:單身page3修改前 name="input.body3.b_update"
                              
               #end add-point
               
               #寫入修改者/修改日期資訊(單身3)
               
               
               #將遮罩欄位還原
               CALL aimt300_imbm_t_mask_restore('restore_mask_o')
                              
               UPDATE imbm_t SET (imbmdocno,imbm002,imbm005,imbm003,imbm006,imbm004) = (g_imba_m.imbadocno, 
                   g_imbj3_d[l_ac].imbm002,g_imbj3_d[l_ac].imbm005,g_imbj3_d[l_ac].imbm003,g_imbj3_d[l_ac].imbm006, 
                   g_imbj3_d[l_ac].imbm004) #自訂欄位頁簽
                WHERE imbment = g_enterprise AND imbmdocno = g_imba_m.imbadocno
                  AND imbm002 = g_imbj3_d_t.imbm002 #項次 
                  
               #add-point:單身page3修改中 name="input.body3.m_update"
                              
               #end add-point
                  
               CASE
                  WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
                     LET g_imbj3_d[l_ac].* = g_imbj3_d_t.*
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "imbm_t" 
                     LET g_errparam.code = "std-00009" 
                     LET g_errparam.popup = TRUE 
                     CALL s_transaction_end('N','0')
                     CALL cl_err()
                     
                  WHEN SQLCA.SQLCODE #其他錯誤
                     LET g_imbj3_d[l_ac].* = g_imbj3_d_t.*
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "imbm_t:",SQLERRMESSAGE 
                     LET g_errparam.code = SQLCA.SQLCODE 
                     LET g_errparam.popup = TRUE 
                     CALL s_transaction_end('N','0')
                     CALL cl_err()
                     
                  OTHERWISE
                     #資料多語言用-增/改
                     
                                    INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_imba_m.imbadocno
               LET gs_keys_bak[1] = g_imbadocno_t
               LET gs_keys[2] = g_imbj3_d[g_detail_idx].imbm002
               LET gs_keys_bak[2] = g_imbj3_d_t.imbm002
               CALL aimt300_update_b('imbm_t',gs_keys,gs_keys_bak,"'3'")
               END CASE
               
               #將遮罩欄位進行遮蔽
               CALL aimt300_imbm_t_mask_restore('restore_mask_n')
               
               #判斷key是否有改變
               INITIALIZE gs_keys TO NULL
               IF NOT (g_imbj3_d[g_detail_idx].imbm002 = g_imbj3_d_t.imbm002 
                  ) THEN
                  LET gs_keys[01] = g_imba_m.imbadocno
                  LET gs_keys[gs_keys.getLength()+1] = g_imbj3_d_t.imbm002
                  CALL aimt300_key_update_b(gs_keys,'imbm_t')
               END IF
               
               #修改歷程記錄(單身修改)
               LET g_log1 = util.JSON.stringify(g_imba_m),util.JSON.stringify(g_imbj3_d_t)
               LET g_log2 = util.JSON.stringify(g_imba_m),util.JSON.stringify(g_imbj3_d[l_ac])
               IF NOT cl_log_modified_record_d(g_log1,g_log2) THEN 
                  CALL s_transaction_end('N','0')
               END IF
               
               #add-point:單身page3修改後 name="input.body3.a_update"
                              
               #end add-point
            END IF
         
                  #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imbm002
            #add-point:BEFORE FIELD imbm002 name="input.b.page3.imbm002"
                        
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imbm002
            
            #add-point:AFTER FIELD imbm002 name="input.a.page3.imbm002"
                                    #此段落由子樣板a05產生
            IF  NOT cl_null(g_imba_m.imbadocno) AND NOT cl_null(g_imbj3_d[l_ac].imbm002) THEN 
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND ( l_cmd = 'u' AND (g_imba_m.imbadocno != g_imbadocno_t OR g_imbj3_d[l_ac].imbm002 != g_imbj3_d_t.imbm002))) THEN 
                  IF NOT ap_chk_notDup(g_imbj3_d[l_ac].imbm002,"SELECT COUNT(*) FROM imbm_t WHERE "||"imbment = '" ||g_enterprise|| "' AND "||"imbmdocno = '"||g_imba_m.imbadocno ||"' AND "|| "imbm002 = '"||g_imbj3_d[l_ac].imbm002 ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF


            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE imbm002
            #add-point:ON CHANGE imbm002 name="input.g.page3.imbm002"
                        
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imbm005
            #add-point:BEFORE FIELD imbm005 name="input.b.page3.imbm005"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imbm005
            
            #add-point:AFTER FIELD imbm005 name="input.a.page3.imbm005"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE imbm005
            #add-point:ON CHANGE imbm005 name="input.g.page3.imbm005"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imbm003
            #add-point:BEFORE FIELD imbm003 name="input.b.page3.imbm003"
                        
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imbm003
            
            #add-point:AFTER FIELD imbm003 name="input.a.page3.imbm003"
                        
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE imbm003
            #add-point:ON CHANGE imbm003 name="input.g.page3.imbm003"
                        
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imbm006
            #add-point:BEFORE FIELD imbm006 name="input.b.page3.imbm006"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imbm006
            
            #add-point:AFTER FIELD imbm006 name="input.a.page3.imbm006"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE imbm006
            #add-point:ON CHANGE imbm006 name="input.g.page3.imbm006"
            
            #END add-point 
 
 
 
                  #Ctrlp:input.c.page3.imbm002
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imbm002
            #add-point:ON ACTION controlp INFIELD imbm002 name="input.c.page3.imbm002"
                        
            #END add-point
 
 
         #Ctrlp:input.c.page3.imbm005
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imbm005
            #add-point:ON ACTION controlp INFIELD imbm005 name="input.c.page3.imbm005"
            
            #END add-point
 
 
         #Ctrlp:input.c.page3.imbm003
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imbm003
            #add-point:ON ACTION controlp INFIELD imbm003 name="input.c.page3.imbm003"
                        
            #END add-point
 
 
         #Ctrlp:input.c.page3.imbm006
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imbm006
            #add-point:ON ACTION controlp INFIELD imbm006 name="input.c.page3.imbm006"
            
            #END add-point
 
 
 
 
         AFTER ROW
            #add-point:單身page3 after_row name="input.body3.after_row"
                        
            #end add-point
            LET l_ac = ARR_CURR()
            IF INT_FLAG THEN
               LET INT_FLAG = 0
               IF l_cmd = 'u' THEN
                  LET g_imbj3_d[l_ac].* = g_imbj3_d_t.*
               END IF
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code = 9001 
               LET g_errparam.popup = FALSE 
               CLOSE aimt300_bcl3
               CALL s_transaction_end('N','0')
               CALL cl_err()
               EXIT DIALOG 
            END IF
            
            #其他table進行unlock
            
            CALL aimt300_unlock_b("imbm_t","'3'")
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
               LET g_imbj3_d[li_reproduce_target].* = g_imbj3_d[li_reproduce].*
 
               LET g_imbj3_d[li_reproduce_target].imbm002 = NULL
            ELSE
               CALL FGL_SET_ARR_CURR(g_imbj3_d.getLength()+1)
               LET lb_reproduce = TRUE
               LET li_reproduce = l_ac
               LET li_reproduce_target = g_imbj3_d.getLength()+1
            END IF
            
      END INPUT
      INPUT ARRAY g_imbj4_d FROM s_detail4.*
         ATTRIBUTE(COUNT = g_rec_b,WITHOUT DEFAULTS, #MAXCOUNT = g_max_rec,
                 INSERT ROW = l_allow_insert, #此頁面insert功能由產生器控制, 手動之設定無效! 
 
                 DELETE ROW = l_allow_delete,
                 APPEND ROW = l_allow_insert)
                 
         #自訂ACTION(detail_input,page_4)
         
         
         BEFORE INPUT
            #add-point:資料輸入前 name="input.body4.before_input2"
            
            #end add-point
            IF g_insert = 'Y' AND NOT cl_null(g_insert) THEN 
              CALL FGL_SET_ARR_CURR(g_imbj4_d.getLength()+1) 
              LET g_insert = 'N' 
           END IF 
 
            CALL aimt300_b_fill()
            #如果一直都在單身1則控制筆數位置
            IF g_loc = 'd' AND g_rec_b != 0 THEN
               CALL FGL_SET_ARR_CURR(g_idx_group.getValue("'4',"))
            END IF
            LET g_loc = 'd'
            LET g_rec_b = g_imbj4_d.getLength()
            #add-point:資料輸入前 name="input.body4.before_input"
                        
            #end add-point
            
         BEFORE INSERT
            IF s_transaction_chk("N",0) THEN
               CALL s_transaction_begin()
            END IF
            LET l_insert = TRUE
            LET l_n = ARR_COUNT()
            LET l_cmd = 'a'
            INITIALIZE g_imbj4_d[l_ac].* TO NULL 
            INITIALIZE g_imbj4_d_t.* TO NULL 
            INITIALIZE g_imbj4_d_o.* TO NULL 
            #公用欄位給值(單身4)
            
            #自定義預設值(單身4)
            
            #add-point:modify段before備份 name="input.body4.insert.before_bak"
            
            #end add-point
            LET g_imbj4_d_t.* = g_imbj4_d[l_ac].*     #新輸入資料
            LET g_imbj4_d_o.* = g_imbj4_d[l_ac].*     #新輸入資料
            CALL cl_show_fld_cont()
            CALL aimt300_set_entry_b(l_cmd)
            #add-point:modify段after_set_entry_b name="input.body4.insert.after_set_entry_b"
                        
            #end add-point
            CALL aimt300_set_no_entry_b(l_cmd)
            IF lb_reproduce THEN
               LET lb_reproduce = FALSE
               LET g_imbj4_d[li_reproduce_target].* = g_imbj4_d[li_reproduce].*
 
               LET g_imbj4_d[li_reproduce_target].imbo002 = NULL
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
            OPEN aimt300_cl USING g_enterprise,g_imba_m.imbadocno
            IF SQLCA.SQLCODE THEN   #(ver:78)
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "OPEN aimt300_cl:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE   #(ver:78)
               LET g_errparam.popup = TRUE 
               CLOSE aimt300_cl
               CALL s_transaction_end('N','0')
               CALL cl_err()
               RETURN
            END IF
            
            LET g_rec_b = g_imbj4_d.getLength()
            
            IF g_rec_b >= l_ac 
               AND g_imbj4_d[l_ac].imbo002 IS NOT NULL
            THEN 
               LET l_cmd='u'
               LET g_imbj4_d_t.* = g_imbj4_d[l_ac].*  #BACKUP
               LET g_imbj4_d_o.* = g_imbj4_d[l_ac].*  #BACKUP
               CALL aimt300_set_entry_b(l_cmd)
               #add-point:modify段after_set_entry_b name="input.body4.after_set_entry_b"
                              
               #end add-point  
               CALL aimt300_set_no_entry_b(l_cmd)
               IF NOT aimt300_lock_b("imbo_t","'4'") THEN
                  LET l_lock_sw='Y'
               ELSE
                  FETCH aimt300_bcl4 INTO g_imbj4_d[l_ac].imbo002
                  IF SQLCA.SQLCODE THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = SQLERRMESSAGE  
                     LET g_errparam.code = SQLCA.SQLCODE 
                     LET g_errparam.popup = TRUE 
                     CALL cl_err()
                     LET l_lock_sw = "Y"
                  END IF
                  
                  #遮罩相關處理
                  LET g_imbj4_d_mask_o[l_ac].* =  g_imbj4_d[l_ac].*
                  CALL aimt300_imbo_t_mask()
                  LET g_imbj4_d_mask_n[l_ac].* =  g_imbj4_d[l_ac].*
                  
                  LET g_bfill = "N"
                  CALL aimt300_show()
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
               LET gs_keys[01] = g_imba_m.imbadocno
               LET gs_keys[gs_keys.getLength()+1] = g_imbj4_d_t.imbo002
            
               #刪除同層單身
               IF NOT aimt300_delete_b('imbo_t',gs_keys,"'4'") THEN
                  CALL s_transaction_end('N','0')
                  CLOSE aimt300_bcl
                  CANCEL DELETE
               END IF
    
               #刪除下層單身
               IF NOT aimt300_key_delete_b(gs_keys,'imbo_t') THEN
                  CALL s_transaction_end('N','0')
                  CLOSE aimt300_bcl
                  CANCEL DELETE
               END IF
               
               #刪除多語言
               
 
               
               #add-point:單身4刪除中 name="input.body4.m_delete"
                              
               #end add-point    
               
               CALL s_transaction_end('Y','0')
               CLOSE aimt300_bcl
 
               LET g_rec_b = g_rec_b-1
               #add-point:單身4刪除後 name="input.body4.a_delete"
                                    
               #end add-point
               LET l_count = g_imbj_d.getLength()
               
               #add-point:單身刪除後(<>d) name="input.body4.after_delete"
                        
               #end add-point
            END IF 
 
         AFTER DELETE
            #如果是最後一筆
            IF l_ac = (g_imbj4_d.getLength() + 1) THEN
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
            SELECT COUNT(1) INTO l_count FROM imbo_t 
             WHERE imboent = g_enterprise AND imbodocno = g_imba_m.imbadocno
               AND imbo002 = g_imbj4_d[l_ac].imbo002
                
            #資料未重複, 插入新增資料
            IF l_count = 0 THEN 
               #add-point:單身4新增前 name="input.body4.b_insert"
                              
               #end add-point
            
                              INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_imba_m.imbadocno
               LET gs_keys[2] = g_imbj4_d[g_detail_idx].imbo002
               CALL aimt300_insert_b('imbo_t',gs_keys,"'4'")
                           
               #add-point:單身新增後4 name="input.body4.a_insert"
                              
               #end add-point
            ELSE    
               INITIALIZE g_imbj_d[l_ac].* TO NULL
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
               LET g_errparam.extend = "imbo_t:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE 
               LET g_errparam.popup = TRUE 
               CALL s_transaction_end('N','0')                    
               CALL cl_err()
               CANCEL INSERT
            ELSE
               #先刷新資料
               #CALL aimt300_b_fill()
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
               LET g_imbj4_d[l_ac].* = g_imbj4_d_t.*
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code = 9001 
               LET g_errparam.popup = FALSE 
               CLOSE aimt300_bcl4
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
               LET g_imbj4_d[l_ac].* = g_imbj4_d_t.*
            ELSE
               #add-point:單身page4修改前 name="input.body4.b_update"
                              
               #end add-point
               
               #寫入修改者/修改日期資訊(單身4)
               
               
               #將遮罩欄位還原
               CALL aimt300_imbo_t_mask_restore('restore_mask_o')
                              
               UPDATE imbo_t SET (imbodocno,imbo002) = (g_imba_m.imbadocno,g_imbj4_d[l_ac].imbo002)  
                   #自訂欄位頁簽
                WHERE imboent = g_enterprise AND imbodocno = g_imba_m.imbadocno
                  AND imbo002 = g_imbj4_d_t.imbo002 #項次 
                  
               #add-point:單身page4修改中 name="input.body4.m_update"
                              
               #end add-point
                  
               CASE
                  WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
                     LET g_imbj4_d[l_ac].* = g_imbj4_d_t.*
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "imbo_t" 
                     LET g_errparam.code = "std-00009" 
                     LET g_errparam.popup = TRUE 
                     CALL s_transaction_end('N','0')
                     CALL cl_err()
                     
                  WHEN SQLCA.SQLCODE #其他錯誤
                     LET g_imbj4_d[l_ac].* = g_imbj4_d_t.*
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "imbo_t:",SQLERRMESSAGE 
                     LET g_errparam.code = SQLCA.SQLCODE 
                     LET g_errparam.popup = TRUE 
                     CALL s_transaction_end('N','0')
                     CALL cl_err()
                     
                  OTHERWISE
                     #資料多語言用-增/改
                     
                                    INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_imba_m.imbadocno
               LET gs_keys_bak[1] = g_imbadocno_t
               LET gs_keys[2] = g_imbj4_d[g_detail_idx].imbo002
               LET gs_keys_bak[2] = g_imbj4_d_t.imbo002
               CALL aimt300_update_b('imbo_t',gs_keys,gs_keys_bak,"'4'")
               END CASE
               
               #將遮罩欄位進行遮蔽
               CALL aimt300_imbo_t_mask_restore('restore_mask_n')
               
               #判斷key是否有改變
               INITIALIZE gs_keys TO NULL
               IF NOT (g_imbj4_d[g_detail_idx].imbo002 = g_imbj4_d_t.imbo002 
                  ) THEN
                  LET gs_keys[01] = g_imba_m.imbadocno
                  LET gs_keys[gs_keys.getLength()+1] = g_imbj4_d_t.imbo002
                  CALL aimt300_key_update_b(gs_keys,'imbo_t')
               END IF
               
               #修改歷程記錄(單身修改)
               LET g_log1 = util.JSON.stringify(g_imba_m),util.JSON.stringify(g_imbj4_d_t)
               LET g_log2 = util.JSON.stringify(g_imba_m),util.JSON.stringify(g_imbj4_d[l_ac])
               IF NOT cl_log_modified_record_d(g_log1,g_log2) THEN 
                  CALL s_transaction_end('N','0')
               END IF
               
               #add-point:單身page4修改後 name="input.body4.a_update"
                              
               #end add-point
            END IF
         
                  #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imbo002
            
            #add-point:AFTER FIELD imbo002 name="input.a.page4.imbo002"
                                    #此段落由子樣板a05產生
            CALL aimt300_imbo_desc()
            IF g_imbj4_d[l_ac].imbo002 IS NOT NULL THEN 
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND g_imbj4_d[l_ac].imbo002 != g_imbj4_d_t.imbo002) THEN 
                  IF NOT ap_chk_notDup(g_imbj4_d[l_ac].imbo002,"SELECT COUNT(*) FROM imbo_t WHERE "||"imboent = '" ||g_enterprise|| "' AND "||"imbodocno = '"||g_imba_m.imbadocno ||"' AND "|| "imbo002 = '"||g_imbj4_d[l_ac].imbo002 ||"'",'std-00004',0) THEN 
                     LET g_imbj4_d[l_ac].imbo002 = g_imbj4_d_t.imbo002
                     CALL aimt300_imbo_desc()
                     NEXT FIELD CURRENT
                  END IF
               END IF
               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
               INITIALIZE g_chkparam.* TO NULL
               LET g_errshow = TRUE #是否開窗 #160318-00025#29  add
               #設定g_chkparam.*的參數
               LET g_chkparam.arg1 = g_imbj4_d[l_ac].imbo002
               LET g_chkparam.err_str[1] = "aim-00005:sub-01302|aooi250|",cl_get_progname("aooi250",g_lang,"2"),"|:EXEPROGaooi250"  #160318-00025#29  add
               #呼叫檢查存在並帶值的library
               IF NOT cl_chk_exist("v_ooca001") THEN
                  LET g_imbj4_d[l_ac].imbo002 = g_imbj4_d_t.imbo002
                  CALL aimt300_imbo_desc()
                  NEXT FIELD CURRENT
               END IF
            END IF


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imbo002
            #add-point:BEFORE FIELD imbo002 name="input.b.page4.imbo002"
                        
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE imbo002
            #add-point:ON CHANGE imbo002 name="input.g.page4.imbo002"
                        
            #END add-point 
 
 
 
                  #Ctrlp:input.c.page4.imbo002
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imbo002
            #add-point:ON ACTION controlp INFIELD imbo002 name="input.c.page4.imbo002"
                        #此段落由子樣板a07產生            
            #開窗i段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
			LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_imbj4_d[l_ac].imbo002             #給予default值

            #給予arg

            CALL q_ooca001_1()                                #呼叫開窗

            LET g_imbj4_d[l_ac].imbo002 = g_qryparam.return1              #將開窗取得的值回傳到變數

            DISPLAY g_imbj4_d[l_ac].imbo002 TO imbo002              #顯示到畫面上
            CALL aimt300_imbo_desc()
            NEXT FIELD imbo002                          #返回原欄位


            #END add-point
 
 
 
 
         AFTER ROW
            #add-point:單身page4 after_row name="input.body4.after_row"
                        
            #end add-point
            LET l_ac = ARR_CURR()
            IF INT_FLAG THEN
               LET INT_FLAG = 0
               IF l_cmd = 'u' THEN
                  LET g_imbj4_d[l_ac].* = g_imbj4_d_t.*
               END IF
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code = 9001 
               LET g_errparam.popup = FALSE 
               CLOSE aimt300_bcl4
               CALL s_transaction_end('N','0')
               CALL cl_err()
               EXIT DIALOG 
            END IF
            
            #其他table進行unlock
            
            CALL aimt300_unlock_b("imbo_t","'4'")
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
               LET g_imbj4_d[li_reproduce_target].* = g_imbj4_d[li_reproduce].*
 
               LET g_imbj4_d[li_reproduce_target].imbo002 = NULL
            ELSE
               CALL FGL_SET_ARR_CURR(g_imbj4_d.getLength()+1)
               LET lb_reproduce = TRUE
               LET li_reproduce = l_ac
               LET li_reproduce_target = g_imbj4_d.getLength()+1
            END IF
            
      END INPUT
 
      
 
 
 
 
{</section>}
 
{<section id="aimt300.input.other" >}
      
      #add-point:自定義input name="input.more_input"
      SUBDIALOG aoo_aooi360_01.aooi360_01_input
      SUBDIALOG aim_aimt300_01.aimt300_01_input        
      #end add-point
    
      BEFORE DIALOG 
         #CALL cl_err_collect_init()    
         #add-point:input段before dialog name="input.before_dialog"
         #為了修改功能doubleClick可以直接進入單身, 需指定要進入哪一個單身
         IF NOT cl_null(p_cmd) AND p_cmd != 'a' THEN
            CASE g_aw
               WHEN "s_detail1_aooi360_01"
                  NEXT FIELD ooff001
               WHEN "s_detail1_aimt300_01"
                  NEXT FIELD imbk003          
            END CASE
         END IF                
         #end add-point    
         #重新導回資料到正確位置上
         CALL DIALOG.setCurrentRow("s_detail1",g_idx_group.getValue("'1',"))      
         CALL DIALOG.setCurrentRow("s_detail2",g_idx_group.getValue("'2',"))
         CALL DIALOG.setCurrentRow("s_detail3",g_idx_group.getValue("'3',"))
         CALL DIALOG.setCurrentRow("s_detail4",g_idx_group.getValue("'4',"))
 
         #新增時強制從單頭開始填
         IF p_cmd = 'a' THEN
            #add-point:input段next_field name="input.next_field"
            
            #end add-point  
            NEXT FIELD imbadocno
         ELSE
            CASE g_aw
               WHEN "s_detail1"
                  NEXT FIELD imbj002
               WHEN "s_detail2"
                  NEXT FIELD imbl002
               WHEN "s_detail3"
                  NEXT FIELD imbm002
               WHEN "s_detail4"
                  NEXT FIELD imbo002
 
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
         LET g_field = DIALOG.getCurrentItem()
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
 
{<section id="aimt300.show" >}
#+ 單頭資料重新顯示及單身資料重抓
PRIVATE FUNCTION aimt300_show()
   #add-point:show段define(客製用) name="show.define_customerization"
   
   #end add-point  
   DEFINE l_ac_t    LIKE type_t.num10
   #add-point:show段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="show.define"
         DEFINE l_flag          LIKE type_t.num5          #标识符，TRUE/FALSE
   DEFINE l_flag1         LIKE type_t.num5          #标识符，TRUE/FALSE
   DEFINE l_ooba002       LIKE ooba_t.ooba002       #单据别
   DEFINE l_site          LIKE type_t.chr20 
   #end add-point  
   
   #add-point:Function前置處理 name="show.before"
         LET g_imba_m_o.* = g_imba_m.*
   LET g_imba003_o = g_imba_m.imba003
   LET g_imba009_o = g_imba_m.imba009
   #end add-point
   
   
   
   IF g_bfill = "Y" THEN
      CALL aimt300_b_fill() #單身填充
      CALL aimt300_b_fill2('0') #單身填充
   END IF
     
   #帶出公用欄位reference值
   #應用 a12 樣板自動產生(Version:4)
 
 
 
   
   #顯示followup圖示
   #應用 a48 樣板自動產生(Version:3)
   CALL aimt300_set_pk_array()
   #add-point:ON ACTION agendum name="show.follow_pic"
   
   #END add-point
   CALL cl_user_overview_set_follow_pic()
  
 
 
 
   
   LET l_ac_t = l_ac
   
   #讀入ref值(單頭)
   #add-point:show段reference name="show.head.reference"
            SELECT imbal002,imbal003,imbal004 INTO g_imba_m.imbal002,g_imba_m.imbal003,g_imba_m.imbal004
               FROM imbal_t
              WHERE imbalent = g_enterprise
                AND imbaldocno = g_imba_m.imbadocno
                AND imbal001 = g_lang
             DISPLAY BY NAME g_imba_m.imbal002
             DISPLAY BY NAME g_imba_m.imbal003
             DISPLAY BY NAME g_imba_m.imbal004
   
            
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_imba_m.imbaownid
            CALL ap_ref_array2(g_ref_fields,"SELECT ooag011 FROM ooag_t WHERE ooagent='"||g_enterprise||"' AND ooag001=? ","") RETURNING g_rtn_fields
            LET g_imba_m.imbaownid_desc = g_rtn_fields[1] 
            DISPLAY BY NAME g_imba_m.imbaownid_desc

            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_imba_m.imbaowndp
            CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_imba_m.imbaowndp_desc = g_rtn_fields[1] 
            DISPLAY BY NAME g_imba_m.imbaowndp_desc

            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_imba_m.imbacrtid
            CALL ap_ref_array2(g_ref_fields,"SELECT ooag011 FROM ooag_t WHERE ooagent='"||g_enterprise||"' AND ooag001=? ","") RETURNING g_rtn_fields
            LET g_imba_m.imbacrtid_desc = g_rtn_fields[1] 
            DISPLAY BY NAME g_imba_m.imbacrtid_desc

            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_imba_m.imbacrtdp
            CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_imba_m.imbacrtdp_desc = g_rtn_fields[1]
            DISPLAY BY NAME g_imba_m.imbacrtdp_desc

            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_imba_m.imbamodid
            CALL ap_ref_array2(g_ref_fields,"SELECT ooag011 FROM ooag_t WHERE ooagent='"||g_enterprise||"' AND ooag001=? ","") RETURNING g_rtn_fields
            LET g_imba_m.imbamodid_desc = g_rtn_fields[1] 
            DISPLAY BY NAME g_imba_m.imbamodid_desc

            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_imba_m.imbacnfid
            CALL ap_ref_array2(g_ref_fields,"SELECT ooag011 FROM ooag_t WHERE ooagent='"||g_enterprise||"' AND ooag001=? ","") RETURNING g_rtn_fields
            LET g_imba_m.imbacnfid_desc =  g_rtn_fields[1]
            DISPLAY BY NAME g_imba_m.imbacnfid_desc
            
            LET g_imba_m.oobxl003 = ""  
            IF NOT cl_null(g_imba_m.imbadocno) THEN
               CALL s_aooi200_get_slip(g_imba_m.imbadocno) RETURNING l_flag1,l_ooba002
               IF l_flag1 THEN
                  IF NOT cl_null(l_ooba002) THEN
                     SELECT oobxl003 INTO g_imba_m.oobxl003
                       FROM oobxl_t
                      WHERE oobxl001 = l_ooba002
                        AND oobxl002 = g_dlang
                        AND oobxlent = g_enterprise
                  ELSE
                     LET g_imba_m.oobxl003 = ""        
                  END IF
               END IF
            END IF
            DISPLAY BY NAME g_imba_m.oobxl003
   
            #CALL aimt300_desc()
   #end add-point
   
   #遮罩相關處理
   LET g_imba_m_mask_o.* =  g_imba_m.*
   CALL aimt300_imba_t_mask()
   LET g_imba_m_mask_n.* =  g_imba_m.*
   
   #將資料輸出到畫面上
   DISPLAY BY NAME g_imba_m.imbadocno,g_imba_m.oobxl003,g_imba_m.imbadocdt,g_imba_m.imba000,g_imba_m.imba900, 
       g_imba_m.imba900_desc,g_imba_m.imba901,g_imba_m.imba901_desc,g_imba_m.imbastus,g_imba_m.imba001, 
       g_imba_m.imba002,g_imba_m.imbal002,g_imba_m.imbal003,g_imba_m.imbal004,g_imba_m.imba009,g_imba_m.imba009_desc, 
       g_imba_m.imba003,g_imba_m.imba003_desc,g_imba_m.imba004,g_imba_m.imba005,g_imba_m.imba005_desc, 
       g_imba_m.imba006,g_imba_m.imba006_desc,g_imba_m.imba010,g_imba_m.imba010_desc,g_imba_m.imba126, 
       g_imba_m.imba126_desc,g_imba_m.imba127,g_imba_m.imba127_desc,g_imba_m.imba131,g_imba_m.imba131_desc, 
       g_imba_m.imba128,g_imba_m.imba128_desc,g_imba_m.imba129,g_imba_m.imba129_desc,g_imba_m.imba130, 
       g_imba_m.imba132,g_imba_m.imba132_desc,g_imba_m.imba133,g_imba_m.imba133_desc,g_imba_m.imba134, 
       g_imba_m.imba134_desc,g_imba_m.imba135,g_imba_m.imba135_desc,g_imba_m.imba136,g_imba_m.imba136_desc, 
       g_imba_m.imba137,g_imba_m.imba137_desc,g_imba_m.imba138,g_imba_m.imba138_desc,g_imba_m.imba139, 
       g_imba_m.imba139_desc,g_imba_m.imba140,g_imba_m.imba140_desc,g_imba_m.imba141,g_imba_m.imba141_desc, 
       g_imba_m.imbaownid,g_imba_m.imbaownid_desc,g_imba_m.imbaowndp,g_imba_m.imbaowndp_desc,g_imba_m.imbacrtid, 
       g_imba_m.imbacrtid_desc,g_imba_m.imbacrtdp,g_imba_m.imbacrtdp_desc,g_imba_m.imbacrtdt,g_imba_m.imbamodid, 
       g_imba_m.imbamodid_desc,g_imba_m.imbamoddt,g_imba_m.imbacnfid,g_imba_m.imbacnfid_desc,g_imba_m.imbacnfdt, 
       g_imba_m.imba011,g_imba_m.imba012,g_imba_m.imba013,g_imba_m.imba014,g_imba_m.imba142,g_imba_m.imba142_desc, 
       g_imba_m.imba108,g_imba_m.imba100,g_imba_m.imba109,g_imba_m.imba101,g_imba_m.imba104,g_imba_m.imba105, 
       g_imba_m.imba106,g_imba_m.imba107,g_imba_m.imba124,g_imba_m.imba145,g_imba_m.imba146,g_imba_m.imba016, 
       g_imba_m.imba017,g_imba_m.imba018,g_imba_m.imba018_desc,g_imba_m.imba019,g_imba_m.imba020,g_imba_m.imba021, 
       g_imba_m.imba022,g_imba_m.imba022_desc,g_imba_m.imba023,g_imba_m.imba024,g_imba_m.imba025,g_imba_m.imba026, 
       g_imba_m.imba027,g_imba_m.imba028,g_imba_m.imba029,g_imba_m.imba029_desc,g_imba_m.imba030,g_imba_m.imba031, 
       g_imba_m.imba032,g_imba_m.imba032_desc,g_imba_m.imba033,g_imba_m.imba034,g_imba_m.imba035,g_imba_m.imba036, 
       g_imba_m.imba037,g_imba_m.imba043,g_imba_m.imba038,g_imba_m.imba041,g_imba_m.imba042,g_imba_m.imba044, 
       g_imba_m.imba122,g_imba_m.imba122_desc,g_imba_m.imba045,g_imba_m.imba045_desc,g_imba_m.imba123 
 
   
   #顯示狀態(stus)圖片
         #應用 a21 樣板自動產生(Version:3)
	  #根據當下狀態碼顯示圖片
      CASE g_imba_m.imbastus 
         WHEN "N"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/unconfirmed.png")
         WHEN "W"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/signing.png")
         WHEN "A"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/approved.png")
         WHEN "Y"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/confirmed.png")
         WHEN "D"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/withdraw.png")
         WHEN "R"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/rejection.png")
         WHEN "X"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/invalid.png")
         
      END CASE
 
 
 
   
   #讀入ref值(單身)
   FOR l_ac = 1 TO g_imbj_d.getLength()
      #add-point:show段單身reference name="show.body.reference"
      #CALL aimt300_imbj_desc()
      
      #end add-point
   END FOR
   
   FOR l_ac = 1 TO g_imbj2_d.getLength()
      #add-point:show段單身reference name="show.body2.reference"
      CALL aimt300_imbl_desc()
      #end add-point
   END FOR
   FOR l_ac = 1 TO g_imbj3_d.getLength()
      #add-point:show段單身reference name="show.body3.reference"
            
      #end add-point
   END FOR
   FOR l_ac = 1 TO g_imbj4_d.getLength()
      #add-point:show段單身reference name="show.body4.reference"
      #CALL aimt300_imbo_desc()
      #end add-point
   END FOR
 
   
    
   
   #add-point:show段other name="show.other"
      
   #end add-point  
   
   LET l_ac = l_ac_t
   
   #移動上下筆可以連動切換資料
   CALL cl_show_fld_cont()     
 
   CALL aimt300_detail_show()
 
   #add-point:show段之後 name="show.after"
   CALL aimt300_set_pk_array()
   DISPLAY cl_doc_get_pic() TO ffimage      
   #end add-point
   
END FUNCTION
 
{</section>}
 
{<section id="aimt300.detail_show" >}
#+ 第二階單身reference
PRIVATE FUNCTION aimt300_detail_show()
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
 
{<section id="aimt300.reproduce" >}
#+ 資料複製
PRIVATE FUNCTION aimt300_reproduce()
   #add-point:reproduce段define(客製用) name="reproduce.define_customerization"
   
   #end add-point   
   DEFINE l_newno     LIKE imba_t.imbadocno 
   DEFINE l_oldno     LIKE imba_t.imbadocno 
 
   DEFINE l_master    RECORD LIKE imba_t.* #此變數樣板目前無使用
   DEFINE l_detail    RECORD LIKE imbj_t.* #此變數樣板目前無使用
   DEFINE l_detail2    RECORD LIKE imbl_t.* #此變數樣板目前無使用
 
   DEFINE l_detail3    RECORD LIKE imbm_t.* #此變數樣板目前無使用
 
   DEFINE l_detail4    RECORD LIKE imbo_t.* #此變數樣板目前無使用
 
 
 
   DEFINE l_cnt       LIKE type_t.num10
   #add-point:reproduce段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="reproduce.define"
         DEFINE l_arg1           LIKE ooef_t.ooef004  
   DEFINE p_req_data       DYNAMIC ARRAY OF VARCHAR(500)
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
   
   IF g_imba_m.imbadocno IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code = "std-00003" 
      LET g_errparam.popup = FALSE 
      CALL cl_err()
      RETURN
   END IF
    
   LET g_imbadocno_t = g_imba_m.imbadocno
 
    
   LET g_imba_m.imbadocno = ""
 
 
   CALL cl_set_head_visible("","YES")
 
   #公用欄位給予預設值
   #應用 a14 樣板自動產生(Version:5)    
      #公用欄位新增給值  
      LET g_imba_m.imbaownid = g_user
      LET g_imba_m.imbaowndp = g_dept
      LET g_imba_m.imbacrtid = g_user
      LET g_imba_m.imbacrtdp = g_dept 
      LET g_imba_m.imbacrtdt = cl_get_current()
      LET g_imba_m.imbamodid = g_user
      LET g_imba_m.imbamoddt = cl_get_current()
      LET g_imba_m.imbastus = 'N'
 
 
 
   
   CALL s_transaction_begin()
   
   #add-point:複製輸入前 name="reproduce.head.b_input"
   LET g_imba_m.imba001 = ''   #將料件編號清空
   #end add-point
   
   #顯示狀態(stus)圖片
         #應用 a21 樣板自動產生(Version:3)
	  #根據當下狀態碼顯示圖片
      CASE g_imba_m.imbastus 
         WHEN "N"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/unconfirmed.png")
         WHEN "W"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/signing.png")
         WHEN "A"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/approved.png")
         WHEN "Y"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/confirmed.png")
         WHEN "D"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/withdraw.png")
         WHEN "R"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/rejection.png")
         WHEN "X"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/invalid.png")
         
      END CASE
 
 
 
   
   #清空key欄位的desc
   
   
   CALL aimt300_input("r")
   
   IF INT_FLAG AND NOT g_master_insert THEN
      LET INT_FLAG = 0
      DISPLAY g_detail_cnt  TO FORMONLY.h_count    #總筆數
      DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
      LET INT_FLAG = 0
      INITIALIZE g_imba_m.* TO NULL
      INITIALIZE g_imbj_d TO NULL
      INITIALIZE g_imbj2_d TO NULL
      INITIALIZE g_imbj3_d TO NULL
      INITIALIZE g_imbj4_d TO NULL
 
      #add-point:複製取消後 name="reproduce.cancel"
      
      #end add-point
      CALL aimt300_show()
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
   CALL aimt300_set_act_visible()   
   CALL aimt300_set_act_no_visible()
   
   #將新增的資料併入搜尋條件中
   LET g_imbadocno_t = g_imba_m.imbadocno
 
   
   #組合新增資料的條件
   LET g_add_browse = " imbaent = " ||g_enterprise|| " AND",
                      " imbadocno = '", g_imba_m.imbadocno, "' "
 
   #填到最後面
   LET g_current_idx = g_browser.getLength() + 1
   CALL aimt300_browser_fill("")
   
   DISPLAY g_browser_cnt TO FORMONLY.h_count    #總筆數
   DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
   CALL cl_navigator_setting(g_current_idx, g_browser_cnt)
   
   #add-point:完成複製段落後 name="reproduce.after_reproduce"
      
   #end add-point
   
   CALL aimt300_idx_chk()
   
   LET g_data_owner = g_imba_m.imbaownid      
   LET g_data_dept  = g_imba_m.imbaowndp
   
   #功能已完成,通報訊息中心
   CALL aimt300_msgcentre_notify('reproduce')
 
END FUNCTION
 
{</section>}
 
{<section id="aimt300.detail_reproduce" >}
#+ 單身自動複製
PRIVATE FUNCTION aimt300_detail_reproduce()
   #add-point:delete段define(客製用) name="detail_reproduce.define_customerization"
   
   #end add-point    
   DEFINE ls_sql      STRING
   DEFINE ld_date     DATETIME YEAR TO SECOND
   DEFINE l_detail    RECORD LIKE imbj_t.* #此變數樣板目前無使用
   DEFINE l_detail2    RECORD LIKE imbl_t.* #此變數樣板目前無使用
 
   DEFINE l_detail3    RECORD LIKE imbm_t.* #此變數樣板目前無使用
 
   DEFINE l_detail4    RECORD LIKE imbo_t.* #此變數樣板目前無使用
 
 
 
   #add-point:delete段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="detail_reproduce.define"
  
   #end add-point    
   
   #add-point:Function前置處理  name="detail_reproduce.pre_function"
   
   #end add-point
   
   CALL s_transaction_begin()
   
   LET ld_date = cl_get_current()
   
   DROP TABLE aimt300_detail
   
   #add-point:單身複製前1 name="detail_reproduce.body.table1.b_insert"
      
   #end add-point
   
   #CREATE TEMP TABLE
   SELECT * FROM imbj_t
    WHERE imbjent = g_enterprise AND imbjdocno = g_imbadocno_t
 
    INTO TEMP aimt300_detail
 
   #將key修正為調整後   
   UPDATE aimt300_detail 
      #更新key欄位
      SET imbjdocno = g_imba_m.imbadocno
 
      #更新共用欄位
      
 
   #add-point:單身修改前 name="detail_reproduce.body.table1.b_update"
   
   #end add-point                                       
  
   #將資料塞回原table   
   INSERT INTO imbj_t SELECT * FROM aimt300_detail
   
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
   DROP TABLE aimt300_detail
   
   #add-point:單身複製後1 name="detail_reproduce.body.table1.a_insert"
      
   #end add-point
 
   #add-point:單身複製前 name="detail_reproduce.body.table2.b_insert"
      
   #end add-point
   
   #CREATE TEMP TABLE
   SELECT * FROM imbl_t 
    WHERE imblent = g_enterprise AND imbldocno = g_imbadocno_t
 
    INTO TEMP aimt300_detail
 
   #將key修正為調整後   
   UPDATE aimt300_detail SET imbldocno = g_imba_m.imbadocno
 
  
   #add-point:單身修改前 name="detail_reproduce.body.table2.b_update"
   
   #end add-point    
 
   #將資料塞回原table   
   INSERT INTO imbl_t SELECT * FROM aimt300_detail
   
   #add-point:單身複製中 name="detail_reproduce.body.table2.m_insert"
      
   #end add-point
   
   #刪除TEMP TABLE
   DROP TABLE aimt300_detail
   
   #add-point:單身複製後 name="detail_reproduce.body.table2.a_insert"
      
   #end add-point
 
   #add-point:單身複製前 name="detail_reproduce.body.table3.b_insert"
      
   #end add-point
   
   #CREATE TEMP TABLE
   SELECT * FROM imbm_t 
    WHERE imbment = g_enterprise AND imbmdocno = g_imbadocno_t
 
    INTO TEMP aimt300_detail
 
   #將key修正為調整後   
   UPDATE aimt300_detail SET imbmdocno = g_imba_m.imbadocno
 
  
   #add-point:單身修改前 name="detail_reproduce.body.table3.b_update"
   
   #end add-point    
 
   #將資料塞回原table   
   INSERT INTO imbm_t SELECT * FROM aimt300_detail
   
   #add-point:單身複製中 name="detail_reproduce.body.table3.m_insert"
      
   #end add-point
   
   #刪除TEMP TABLE
   DROP TABLE aimt300_detail
   
   #add-point:單身複製後 name="detail_reproduce.body.table3.a_insert"
      
   #end add-point
 
   #add-point:單身複製前 name="detail_reproduce.body.table4.b_insert"
      
   #end add-point
   
   #CREATE TEMP TABLE
   SELECT * FROM imbo_t 
    WHERE imboent = g_enterprise AND imbodocno = g_imbadocno_t
 
    INTO TEMP aimt300_detail
 
   #將key修正為調整後   
   UPDATE aimt300_detail SET imbodocno = g_imba_m.imbadocno
 
  
   #add-point:單身修改前 name="detail_reproduce.body.table4.b_update"
   
   #end add-point    
 
   #將資料塞回原table   
   INSERT INTO imbo_t SELECT * FROM aimt300_detail
   
   #add-point:單身複製中 name="detail_reproduce.body.table4.m_insert"
      
   #end add-point
   
   #刪除TEMP TABLE
   DROP TABLE aimt300_detail
   
   #add-point:單身複製後 name="detail_reproduce.body.table4.a_insert"
   #CREATE TEMP TABLE
   LET ls_sql = 
      "CREATE GLOBAL TEMPORARY TABLE aimt300_detail AS ",
      "SELECT * FROM imbk_t " 
   PREPARE repro_tbl5 FROM ls_sql
   EXECUTE repro_tbl5
   FREE repro_tbl5
      
   #將符合條件的資料丟入TEMP TABLE
   INSERT INTO aimt300_detail SELECT * FROM imbk_t
                                         WHERE imbkent = g_enterprise AND imbkdocno = g_imbadocno_t
 
 
   #將key修正為調整後   
   UPDATE aimt300_detail SET imbkdocno = g_imba_m.imbadocno
 
  
   #將資料塞回原table   
   INSERT INTO imbk_t SELECT * FROM aimt300_detail

   #刪除TEMP TABLE
   DROP TABLE aimt300_detail  
   
   #end add-point
 
 
   
 
   
   #多語言複製段落
   
   
   CALL s_transaction_end('Y','0')
   
   #已新增完, 調整資料內容(修改時使用)
   LET g_imbadocno_t = g_imba_m.imbadocno
 
   
END FUNCTION
 
{</section>}
 
{<section id="aimt300.delete" >}
#+ 資料刪除
PRIVATE FUNCTION aimt300_delete()
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
   
   IF g_imba_m.imbadocno IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code = "std-00003" 
      LET g_errparam.popup = FALSE 
      CALL cl_err()
      RETURN
   END IF
   
   LET g_master_multi_table_t.imbaldocno = g_imba_m.imbadocno
LET g_master_multi_table_t.imbal002 = g_imba_m.imbal002
LET g_master_multi_table_t.imbal003 = g_imba_m.imbal003
LET g_master_multi_table_t.imbal004 = g_imba_m.imbal004
 
   
   CALL s_transaction_begin()
 
   OPEN aimt300_cl USING g_enterprise,g_imba_m.imbadocno
   IF SQLCA.SQLCODE THEN   #(ver:78)
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "OPEN aimt300_cl:",SQLERRMESSAGE 
      LET g_errparam.code = SQLCA.SQLCODE   #(ver:78)
      LET g_errparam.popup = TRUE 
      CLOSE aimt300_cl
      CALL s_transaction_end('N','0')
      CALL cl_err()
      RETURN
   END IF
 
   #顯示最新的資料
   EXECUTE aimt300_master_referesh USING g_imba_m.imbadocno INTO g_imba_m.imbadocno,g_imba_m.imbadocdt, 
       g_imba_m.imba000,g_imba_m.imba900,g_imba_m.imba901,g_imba_m.imbastus,g_imba_m.imba001,g_imba_m.imba002, 
       g_imba_m.imba009,g_imba_m.imba003,g_imba_m.imba004,g_imba_m.imba005,g_imba_m.imba006,g_imba_m.imba010, 
       g_imba_m.imba126,g_imba_m.imba127,g_imba_m.imba131,g_imba_m.imba128,g_imba_m.imba129,g_imba_m.imba130, 
       g_imba_m.imba132,g_imba_m.imba133,g_imba_m.imba134,g_imba_m.imba135,g_imba_m.imba136,g_imba_m.imba137, 
       g_imba_m.imba138,g_imba_m.imba139,g_imba_m.imba140,g_imba_m.imba141,g_imba_m.imbaownid,g_imba_m.imbaowndp, 
       g_imba_m.imbacrtid,g_imba_m.imbacrtdp,g_imba_m.imbacrtdt,g_imba_m.imbamodid,g_imba_m.imbamoddt, 
       g_imba_m.imbacnfid,g_imba_m.imbacnfdt,g_imba_m.imba011,g_imba_m.imba012,g_imba_m.imba013,g_imba_m.imba014, 
       g_imba_m.imba142,g_imba_m.imba108,g_imba_m.imba100,g_imba_m.imba109,g_imba_m.imba101,g_imba_m.imba104, 
       g_imba_m.imba105,g_imba_m.imba106,g_imba_m.imba107,g_imba_m.imba124,g_imba_m.imba145,g_imba_m.imba146, 
       g_imba_m.imba016,g_imba_m.imba017,g_imba_m.imba018,g_imba_m.imba019,g_imba_m.imba020,g_imba_m.imba021, 
       g_imba_m.imba022,g_imba_m.imba023,g_imba_m.imba024,g_imba_m.imba025,g_imba_m.imba026,g_imba_m.imba027, 
       g_imba_m.imba028,g_imba_m.imba029,g_imba_m.imba030,g_imba_m.imba031,g_imba_m.imba032,g_imba_m.imba033, 
       g_imba_m.imba034,g_imba_m.imba035,g_imba_m.imba036,g_imba_m.imba037,g_imba_m.imba043,g_imba_m.imba038, 
       g_imba_m.imba041,g_imba_m.imba042,g_imba_m.imba044,g_imba_m.imba122,g_imba_m.imba045,g_imba_m.imba123, 
       g_imba_m.imba900_desc,g_imba_m.imba901_desc,g_imba_m.imba009_desc,g_imba_m.imba003_desc,g_imba_m.imba005_desc, 
       g_imba_m.imba006_desc,g_imba_m.imba010_desc,g_imba_m.imba126_desc,g_imba_m.imba127_desc,g_imba_m.imba131_desc, 
       g_imba_m.imba128_desc,g_imba_m.imba129_desc,g_imba_m.imba132_desc,g_imba_m.imba133_desc,g_imba_m.imba134_desc, 
       g_imba_m.imba135_desc,g_imba_m.imba136_desc,g_imba_m.imba137_desc,g_imba_m.imba138_desc,g_imba_m.imba139_desc, 
       g_imba_m.imba140_desc,g_imba_m.imba141_desc,g_imba_m.imbaownid_desc,g_imba_m.imbaowndp_desc,g_imba_m.imbacrtid_desc, 
       g_imba_m.imbacrtdp_desc,g_imba_m.imbamodid_desc,g_imba_m.imbacnfid_desc,g_imba_m.imba142_desc, 
       g_imba_m.imba018_desc,g_imba_m.imba022_desc,g_imba_m.imba029_desc,g_imba_m.imba032_desc,g_imba_m.imba122_desc, 
       g_imba_m.imba045_desc
   
   
   #檢查是否允許此動作
   IF NOT aimt300_action_chk() THEN
      CALL s_transaction_end('N','0')
      RETURN
   END IF
   
   #遮罩相關處理
   LET g_imba_m_mask_o.* =  g_imba_m.*
   CALL aimt300_imba_t_mask()
   LET g_imba_m_mask_n.* =  g_imba_m.*
   
   CALL aimt300_show()
   
   #add-point:delete段before ask name="delete.before_ask"
   
   #end add-point 
 
   IF cl_ask_del_master() THEN              #確認一下
   
      #add-point:單頭刪除前 name="delete.head.b_delete"
            
      #end add-point   
      
      #應用 a47 樣板自動產生(Version:4)
      #刪除相關文件
      CALL aimt300_set_pk_array()
      #add-point:相關文件刪除前 name="delete.befroe.related_document_remove"
      
      #end add-point   
      CALL cl_doc_remove()  
 
 
 
  
  
      #資料備份
      LET g_imbadocno_t = g_imba_m.imbadocno
 
 
      DELETE FROM imba_t
       WHERE imbaent = g_enterprise AND imbadocno = g_imba_m.imbadocno
 
       
      #add-point:單頭刪除中 name="delete.head.m_delete"
                  IF NOT s_aooi200_del_docno(g_imba_m.imbadocno,g_imba_m.imbadocdt) THEN CALL s_transaction_end('N','0') RETURN END IF   #wujie 测试联动删除/检查最大流水码表
      #end add-point
       
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = g_imba_m.imbadocno,":",SQLERRMESSAGE  
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = FALSE 
         CALL s_transaction_end('N','0')
         CALL cl_err()
         RETURN
      END IF
      
      #add-point:單頭刪除後 name="delete.head.a_delete"
                  CALL s_aooi360_del('6',g_imba_m.imbadocno,' ',' ',' ',' ',' ',' ',' ',' ',' ','1') RETURNING l_success
      CALL s_aooi360_del('6',g_imba_m.imbadocno,' ',' ',' ',' ',' ',' ',' ',' ',' ','2') RETURNING l_success
      CALL s_aooi360_del('6',g_imba_m.imbadocno,' ',' ',' ',' ',' ',' ',' ',' ',' ','3') RETURNING l_success
      CALL s_aooi360_del('6',g_imba_m.imbadocno,' ',' ',' ',' ',' ',' ',' ',' ',' ','4') RETURNING l_success
      #end add-point
  
      #add-point:單身刪除前 name="delete.body.b_delete"
                  DELETE FROM imbe_t
       WHERE imbeent = g_enterprise 
         AND imbedocno = g_imba_m.imbadocno
         
      DELETE FROM imbf_t
       WHERE imbfent = g_enterprise 
         AND imbfdocno = g_imba_m.imbadocno

      DELETE FROM imbg_t
       WHERE imbgent = g_enterprise 
         AND imbgdocno = g_imba_m.imbadocno
     #20150430--POLLY--imbh_t改為imbn_t--(S)    
     #DELETE FROM imbh_t
     # WHERE imbhent = g_enterprise 
     #   AND imbhdocno = g_imba_m.imbadocno
      DELETE FROM imbn_t
       WHERE imbnent = g_enterprise 
         AND imbndocno = g_imba_m.imbadocno         
    #20150430--POLLY--imbh_t改為imbn_t--(E)
      DELETE FROM imbk_t
       WHERE imbkent = g_enterprise 
         AND imbkdocno = g_imba_m.imbadocno   
      #end add-point
      
      DELETE FROM imbj_t
       WHERE imbjent = g_enterprise AND imbjdocno = g_imba_m.imbadocno
 
 
      #add-point:單身刪除中 name="delete.body.m_delete"
            
      #end add-point
         
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "imbj_t:",SQLERRMESSAGE 
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
      DELETE FROM imbl_t
       WHERE imblent = g_enterprise AND
             imbldocno = g_imba_m.imbadocno
      #add-point:單身刪除中 name="delete.body.m_delete2"
            
      #end add-point
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "imbl_t:",SQLERRMESSAGE 
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
      DELETE FROM imbm_t
       WHERE imbment = g_enterprise AND
             imbmdocno = g_imba_m.imbadocno
      #add-point:單身刪除中 name="delete.body.m_delete3"
            
      #end add-point
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "imbm_t:",SQLERRMESSAGE 
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
      DELETE FROM imbo_t
       WHERE imboent = g_enterprise AND
             imbodocno = g_imba_m.imbadocno
      #add-point:單身刪除中 name="delete.body.m_delete4"
            
      #end add-point
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "imbo_t:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = FALSE 
         CALL s_transaction_end('N','0')
         CALL cl_err()
         RETURN
      END IF      
 
      #add-point:單身刪除後 name="delete.body.a_delete4"
      CALL aooi360_01_clear_detail()   
      CALL aimt300_01_clear_detail()   #清除交易夥伴
      #15/06/09 Sarah add
      #更新自動編碼最大流水號檔
      IF NOT cl_null(g_imba_m.imba001) THEN
         CALL s_aooi390_oofi_del('1',g_imba_m.imba001) RETURNING g_success
         IF NOT g_success THEN
            CALL s_transaction_end('N','0')
            RETURN
         END IF
      END IF
      #15/06/09 Sarah add
      #end add-point
 
 
 
 
      
      #修改歷程記錄(刪除)
      LET g_log1 = util.JSON.stringify(g_imba_m)   #(ver:78)
      IF NOT cl_log_modified_record(g_log1,'') THEN    #(ver:78)
         CLOSE aimt300_cl
         CALL s_transaction_end('N','0')
         RETURN
      END IF
             
      CLEAR FORM
      CALL g_imbj_d.clear() 
      CALL g_imbj2_d.clear()       
      CALL g_imbj3_d.clear()       
      CALL g_imbj4_d.clear()       
 
     
      CALL aimt300_ui_browser_refresh()  
      #CALL aimt300_ui_headershow()  
      #CALL aimt300_ui_detailshow()
 
      #add-point:多語言刪除 name="delete.lang.before_delete"
  
      #end add-point
      
      #單頭多語言刪除
      INITIALIZE l_var_keys_bak TO NULL 
   INITIALIZE l_field_keys   TO NULL 
   LET l_var_keys_bak[01] = g_enterprise
   LET l_field_keys[01] = 'imbalent'
   LET l_var_keys_bak[02] = g_master_multi_table_t.imbaldocno
   LET l_field_keys[02] = 'imbaldocno'
   CALL cl_multitable_delete(l_field_keys,l_var_keys_bak,'imbal_t')
 
      
      #單身多語言刪除
      
      
      
      
 
   
      #add-point:多語言刪除 name="delete.lang.delete"
      
      #end add-point
      
      IF g_browser_cnt > 0 THEN 
         #CALL aimt300_browser_fill("")
         CALL aimt300_fetch('P')
         DISPLAY g_browser_cnt TO FORMONLY.h_count   #總筆數的顯示
         DISPLAY g_browser_cnt TO FORMONLY.b_count   #總筆數的顯示
      ELSE
         CLEAR FORM
      END IF
      
      CALL s_transaction_end('Y','0')
   ELSE
      CALL s_transaction_end('N','0')
   END IF
 
   CLOSE aimt300_cl
 
   #功能已完成,通報訊息中心
   CALL aimt300_msgcentre_notify('delete')
    
END FUNCTION
 
{</section>}
 
{<section id="aimt300.b_fill" >}
#+ 單身陣列填充
PRIVATE FUNCTION aimt300_b_fill()
   #add-point:b_fill段define(客製用) name="b_fill.define_customerization"
   
   #end add-point     
   DEFINE p_wc2      STRING
   DEFINE li_idx     LIKE type_t.num10
   #add-point:b_fill段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="b_fill.define"
      
   #end add-point     
   
   #add-point:Function前置處理  name="b_fill.pre_function"
   
   #end add-point
   
   #清空第一階單身
   CALL g_imbj_d.clear()
   CALL g_imbj2_d.clear()
   CALL g_imbj3_d.clear()
   CALL g_imbj4_d.clear()
 
 
   #add-point:b_fill段sql_before name="b_fill.sql_before"
      
   #end add-point
   
   #判斷是否填充
   IF aimt300_fill_chk(1) THEN
      #切換上下筆時不重組SQL
      IF (g_action_choice = "query" OR cl_null(g_action_choice))
      #add-point:b_fill段long_sql_if name="b_fill.long_sql_if"
      
      #end add-point
      THEN
         LET g_sql = "SELECT  DISTINCT imbj002,imbj003,imbj004,imbj005,imbj006 ,t1.oocql004 ,t2.oocql004 , 
             t3.oocal003 ,t4.oocql004 FROM imbj_t",   
                     " INNER JOIN imba_t ON imbaent = " ||g_enterprise|| " AND imbadocno = imbjdocno ",
 
                     #"",
                     
                     "",
                     #下層單身所需的join條件
 
                                    " LEFT JOIN oocql_t t1 ON t1.oocqlent="||g_enterprise||" AND t1.oocql001='270' AND t1.oocql002=imbj002 AND t1.oocql003='"||g_dlang||"' ",
               " LEFT JOIN oocql_t t2 ON t2.oocqlent="||g_enterprise||" AND t2.oocql001='271' AND t2.oocql002=imbj003 AND t2.oocql003='"||g_dlang||"' ",
               " LEFT JOIN oocal_t t3 ON t3.oocalent="||g_enterprise||" AND t3.oocal001=imbj005 AND t3.oocal002='"||g_dlang||"' ",
               " LEFT JOIN oocql_t t4 ON t4.oocqlent="||g_enterprise||" AND t4.oocql001='272' AND t4.oocql002=imbj006 AND t4.oocql003='"||g_dlang||"' ",
 
                     " WHERE imbjent=? AND imbjdocno=?"
         LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
         #add-point:b_fill段sql_before name="b_fill.body.fill_sql"
            
         #end add-point
         IF NOT cl_null(g_wc2_table1) THEN
            LET g_sql = g_sql CLIPPED, " AND ", g_wc2_table1 CLIPPED
         END IF
         
         #子單身的WC
         
         
         LET g_sql = g_sql, " ORDER BY imbj_t.imbj002,imbj_t.imbj003"
         
         #add-point:單身填充控制 name="b_fill.sql"
            
         #end add-point
         
         LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
         PREPARE aimt300_pb FROM g_sql
         DECLARE b_fill_cs CURSOR FOR aimt300_pb
      END IF
      
      LET g_cnt = l_ac
      LET l_ac = 1
      
   #  OPEN b_fill_cs USING g_enterprise,g_imba_m.imbadocno   #(ver:78)
                                               
      FOREACH b_fill_cs USING g_enterprise,g_imba_m.imbadocno INTO g_imbj_d[l_ac].imbj002,g_imbj_d[l_ac].imbj003, 
          g_imbj_d[l_ac].imbj004,g_imbj_d[l_ac].imbj005,g_imbj_d[l_ac].imbj006,g_imbj_d[l_ac].imbj002_desc, 
          g_imbj_d[l_ac].imbj003_desc,g_imbj_d[l_ac].imbj005_desc,g_imbj_d[l_ac].imbj006_desc   #(ver:78) 
 
         IF SQLCA.SQLCODE THEN
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "FOREACH:",SQLERRMESSAGE 
            LET g_errparam.code = SQLCA.SQLCODE 
            LET g_errparam.popup = TRUE 
            CALL cl_err()
            EXIT FOREACH
         END IF
        
         #add-point:b_fill段資料填充 name="b_fill.fill"
                        CALL aimt300_imbj_desc()
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
   IF aimt300_fill_chk(2) THEN
      IF (g_action_choice = "query" OR cl_null(g_action_choice))
         #add-point:b_fill段long_sql_if name="b_fill.body2.long_sql_if"
         
         #end add-point
      THEN
         LET g_sql = "SELECT  DISTINCT imbl002  FROM imbl_t",   
                     " INNER JOIN  imba_t ON imbaent = " ||g_enterprise|| " AND imbadocno = imbldocno ",
 
                     "",
                     
                     
                     " WHERE imblent=? AND imbldocno=?"   
         LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
         #add-point:b_fill段fill_sql name="b_fill.body2.fill_sql"
            
         #end add-point
         IF NOT cl_null(g_wc2_table2) THEN
            LET g_sql = g_sql CLIPPED," AND ",g_wc2_table2 CLIPPED
         END IF
         
         #子單身的WC
         
         
         LET g_sql = g_sql, " ORDER BY imbl_t.imbl002"
         
         #add-point:單身填充控制 name="b_fill.sql2"
            
         #end add-point
         
         LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
         PREPARE aimt300_pb2 FROM g_sql
         DECLARE b_fill_cs2 CURSOR FOR aimt300_pb2
      END IF
    
      LET l_ac = 1
      
   #  OPEN b_fill_cs2 USING g_enterprise,g_imba_m.imbadocno   #(ver:78)
                                               
      FOREACH b_fill_cs2 USING g_enterprise,g_imba_m.imbadocno INTO g_imbj2_d[l_ac].imbl002   #(ver:78) 
 
         IF SQLCA.SQLCODE THEN
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "FOREACH:",SQLERRMESSAGE 
            LET g_errparam.code = SQLCA.SQLCODE 
            LET g_errparam.popup = TRUE 
            CALL cl_err()
            EXIT FOREACH
         END IF
        
         #add-point:b_fill段資料填充 name="b_fill2.fill"
                        CALL aimt300_imbl_desc()
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
   IF aimt300_fill_chk(3) THEN
      IF (g_action_choice = "query" OR cl_null(g_action_choice))
         #add-point:b_fill段long_sql_if name="b_fill.body3.long_sql_if"
         
         #end add-point
      THEN
         LET g_sql = "SELECT  DISTINCT imbm002,imbm005,imbm003,imbm006,imbm004  FROM imbm_t",   
                     " INNER JOIN  imba_t ON imbaent = " ||g_enterprise|| " AND imbadocno = imbmdocno ",
 
                     "",
                     
                     
                     " WHERE imbment=? AND imbmdocno=?"   
         LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
         #add-point:b_fill段fill_sql name="b_fill.body3.fill_sql"
            
         #end add-point
         IF NOT cl_null(g_wc2_table3) THEN
            LET g_sql = g_sql CLIPPED," AND ",g_wc2_table3 CLIPPED
         END IF
         
         #子單身的WC
         
         
         LET g_sql = g_sql, " ORDER BY imbm_t.imbm002"
         
         #add-point:單身填充控制 name="b_fill.sql3"
            
         #end add-point
         
         LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
         PREPARE aimt300_pb3 FROM g_sql
         DECLARE b_fill_cs3 CURSOR FOR aimt300_pb3
      END IF
    
      LET l_ac = 1
      
   #  OPEN b_fill_cs3 USING g_enterprise,g_imba_m.imbadocno   #(ver:78)
                                               
      FOREACH b_fill_cs3 USING g_enterprise,g_imba_m.imbadocno INTO g_imbj3_d[l_ac].imbm002,g_imbj3_d[l_ac].imbm005, 
          g_imbj3_d[l_ac].imbm003,g_imbj3_d[l_ac].imbm006,g_imbj3_d[l_ac].imbm004   #(ver:78)
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
 
   #判斷是否填充
   IF aimt300_fill_chk(4) THEN
      IF (g_action_choice = "query" OR cl_null(g_action_choice))
         #add-point:b_fill段long_sql_if name="b_fill.body4.long_sql_if"
         
         #end add-point
      THEN
         LET g_sql = "SELECT  DISTINCT imbo002 ,t5.oocal003 FROM imbo_t",   
                     " INNER JOIN  imba_t ON imbaent = " ||g_enterprise|| " AND imbadocno = imbodocno ",
 
                     "",
                     
                                    " LEFT JOIN oocal_t t5 ON t5.oocalent="||g_enterprise||" AND t5.oocal001=imbo002 AND t5.oocal002='"||g_dlang||"' ",
 
                     " WHERE imboent=? AND imbodocno=?"   
         LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
         #add-point:b_fill段fill_sql name="b_fill.body4.fill_sql"
            
         #end add-point
         IF NOT cl_null(g_wc2_table4) THEN
            LET g_sql = g_sql CLIPPED," AND ",g_wc2_table4 CLIPPED
         END IF
         
         #子單身的WC
         
         
         LET g_sql = g_sql, " ORDER BY imbo_t.imbo002"
         
         #add-point:單身填充控制 name="b_fill.sql4"
            
         #end add-point
         
         LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
         PREPARE aimt300_pb4 FROM g_sql
         DECLARE b_fill_cs4 CURSOR FOR aimt300_pb4
      END IF
    
      LET l_ac = 1
      
   #  OPEN b_fill_cs4 USING g_enterprise,g_imba_m.imbadocno   #(ver:78)
                                               
      FOREACH b_fill_cs4 USING g_enterprise,g_imba_m.imbadocno INTO g_imbj4_d[l_ac].imbo002,g_imbj4_d[l_ac].imbo002_desc  
            #(ver:78)
         IF SQLCA.SQLCODE THEN
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "FOREACH:",SQLERRMESSAGE 
            LET g_errparam.code = SQLCA.SQLCODE 
            LET g_errparam.popup = TRUE 
            CALL cl_err()
            EXIT FOREACH
         END IF
        
         #add-point:b_fill段資料填充 name="b_fill4.fill"
                           CALL aimt300_imbo_desc()
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
   LET g_ooff001_d = '6'
   LET g_ooff002_d = g_imba_m.imbadocno
   LET g_ooff003_d = ' '
   LET g_ooff004_d = ' '
   LET g_ooff005_d = ' '
   LET g_ooff006_d = ' '
   LET g_ooff007_d = ' '
   LET g_ooff008_d = ' '
   LET g_ooff009_d = ' '
   LET g_ooff010_d = ' '
   LET g_ooff011_d = ' '
   CALL aooi360_01_b_fill(g_ooff001_d,g_ooff002_d,g_ooff003_d,g_ooff004_d,g_ooff005_d,g_ooff006_d,g_ooff007_d,g_ooff008_d,g_ooff009_d,g_ooff010_d,g_ooff011_d)
   
   LET g_imbadocno_d = g_imba_m.imbadocno
   LET g_imba001_d = g_imba_m.imba001
   CALL aimt300_01_b_fill(g_imbadocno_d)
   #end add-point
   
   CALL g_imbj_d.deleteElement(g_imbj_d.getLength())
   CALL g_imbj2_d.deleteElement(g_imbj2_d.getLength())
   CALL g_imbj3_d.deleteElement(g_imbj3_d.getLength())
   CALL g_imbj4_d.deleteElement(g_imbj4_d.getLength())
 
   
 
   LET l_ac = g_cnt
   LET g_cnt = 0  
   
   FREE aimt300_pb
   FREE aimt300_pb2
 
   FREE aimt300_pb3
 
   FREE aimt300_pb4
 
 
   
   LET li_idx = l_ac
   
   #遮罩相關處理
   FOR l_ac = 1 TO g_imbj_d.getLength()
      LET g_imbj_d_mask_o[l_ac].* =  g_imbj_d[l_ac].*
      CALL aimt300_imbj_t_mask()
      LET g_imbj_d_mask_n[l_ac].* =  g_imbj_d[l_ac].*
   END FOR
   
   LET g_imbj2_d_mask_o.* =  g_imbj2_d.*
   FOR l_ac = 1 TO g_imbj2_d.getLength()
      LET g_imbj2_d_mask_o[l_ac].* =  g_imbj2_d[l_ac].*
      CALL aimt300_imbl_t_mask()
      LET g_imbj2_d_mask_n[l_ac].* =  g_imbj2_d[l_ac].*
   END FOR
   LET g_imbj3_d_mask_o.* =  g_imbj3_d.*
   FOR l_ac = 1 TO g_imbj3_d.getLength()
      LET g_imbj3_d_mask_o[l_ac].* =  g_imbj3_d[l_ac].*
      CALL aimt300_imbm_t_mask()
      LET g_imbj3_d_mask_n[l_ac].* =  g_imbj3_d[l_ac].*
   END FOR
   LET g_imbj4_d_mask_o.* =  g_imbj4_d.*
   FOR l_ac = 1 TO g_imbj4_d.getLength()
      LET g_imbj4_d_mask_o[l_ac].* =  g_imbj4_d[l_ac].*
      CALL aimt300_imbo_t_mask()
      LET g_imbj4_d_mask_n[l_ac].* =  g_imbj4_d[l_ac].*
   END FOR
 
   
   LET l_ac = li_idx
   
   CALL cl_ap_performance_next_end()
 
END FUNCTION
 
{</section>}
 
{<section id="aimt300.delete_b" >}
#+ 刪除單身後其他table連動
PRIVATE FUNCTION aimt300_delete_b(ps_table,ps_keys_bak,ps_page)
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
      DELETE FROM imbj_t
       WHERE imbjent = g_enterprise AND
         imbjdocno = ps_keys_bak[1] AND imbj002 = ps_keys_bak[2] AND imbj003 = ps_keys_bak[3]
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
         CALL g_imbj_d.deleteElement(li_idx) 
      END IF 
 
   END IF
   
   LET ls_group = "'2',"
   #判斷是否是同一群組的table
   IF ls_group.getIndexOf(ps_page,1) > 0 THEN
      #add-point:delete_b段刪除前 name="delete_b.b_delete2"
            
      #end add-point    
      DELETE FROM imbl_t
       WHERE imblent = g_enterprise AND
             imbldocno = ps_keys_bak[1] AND imbl002 = ps_keys_bak[2]
      #add-point:delete_b段刪除中 name="delete_b.m_delete2"
            
      #end add-point    
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "imbl_t:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = FALSE 
         CALL cl_err()
         RETURN FALSE
      END IF
      
      LET li_idx = g_detail_idx
      IF ps_page <> "'2'" THEN 
         CALL g_imbj2_d.deleteElement(li_idx) 
      END IF 
 
      #add-point:delete_b段刪除後 name="delete_b.a_delete2"
            
      #end add-point    
   END IF
 
   LET ls_group = "'3',"
   #判斷是否是同一群組的table
   IF ls_group.getIndexOf(ps_page,1) > 0 THEN
      #add-point:delete_b段刪除前 name="delete_b.b_delete3"
            
      #end add-point    
      DELETE FROM imbm_t
       WHERE imbment = g_enterprise AND
             imbmdocno = ps_keys_bak[1] AND imbm002 = ps_keys_bak[2]
      #add-point:delete_b段刪除中 name="delete_b.m_delete3"
            
      #end add-point    
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "imbm_t:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = FALSE 
         CALL cl_err()
         RETURN FALSE
      END IF
      
      LET li_idx = g_detail_idx
      IF ps_page <> "'3'" THEN 
         CALL g_imbj3_d.deleteElement(li_idx) 
      END IF 
 
      #add-point:delete_b段刪除後 name="delete_b.a_delete3"
            
      #end add-point    
   END IF
 
   LET ls_group = "'4',"
   #判斷是否是同一群組的table
   IF ls_group.getIndexOf(ps_page,1) > 0 THEN
      #add-point:delete_b段刪除前 name="delete_b.b_delete4"
            
      #end add-point    
      DELETE FROM imbo_t
       WHERE imboent = g_enterprise AND
             imbodocno = ps_keys_bak[1] AND imbo002 = ps_keys_bak[2]
      #add-point:delete_b段刪除中 name="delete_b.m_delete4"
            
      #end add-point    
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "imbo_t:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = FALSE 
         CALL cl_err()
         RETURN FALSE
      END IF
      
      LET li_idx = g_detail_idx
      IF ps_page <> "'4'" THEN 
         CALL g_imbj4_d.deleteElement(li_idx) 
      END IF 
 
      #add-point:delete_b段刪除後 name="delete_b.a_delete4"
            
      #end add-point    
   END IF
 
 
   
 
   
   #add-point:delete_b段other name="delete_b.other"
      
   #end add-point  
   
   RETURN TRUE
   
END FUNCTION
 
{</section>}
 
{<section id="aimt300.insert_b" >}
#+ 新增單身後其他table連動
PRIVATE FUNCTION aimt300_insert_b(ps_table,ps_keys,ps_page)
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
      INSERT INTO imbj_t
                  (imbjent,
                   imbjdocno,
                   imbj002,imbj003
                   ,imbj004,imbj005,imbj006) 
            VALUES(g_enterprise,
                   ps_keys[1],ps_keys[2],ps_keys[3]
                   ,g_imbj_d[g_detail_idx].imbj004,g_imbj_d[g_detail_idx].imbj005,g_imbj_d[g_detail_idx].imbj006) 
 
      #add-point:insert_b段資料新增中 name="insert_b.m_insert"
            
      #end add-point 
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "imbj_t:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = FALSE 
         CALL cl_err()
      END IF
      
      LET li_idx = g_detail_idx
      IF ps_page <> "'1'" THEN 
         CALL g_imbj_d.insertElement(li_idx) 
      END IF 
 
      #add-point:insert_b段資料新增後 name="insert_b.after_insert"
                  UPDATE imbj_t SET imbj001 = g_imba_m.imba001
       WHERE imbjent = g_enterprise
         AND imbjdocno = ps_keys[1]
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "imbj_t"
         LET g_errparam.popup = FALSE
         CALL cl_err()

      END IF
      #end add-point 
   END IF
   
   LET ls_group = "'2',"
   #判斷是否是同一群組的table
   IF ls_group.getIndexOf(ps_page,1) > 0 THEN
      #add-point:insert_b段資料新增前 name="insert_b.before_insert2"
            
      #end add-point 
      INSERT INTO imbl_t
                  (imblent,
                   imbldocno,
                   imbl002
                   ) 
            VALUES(g_enterprise,
                   ps_keys[1],ps_keys[2]
                   )
      #add-point:insert_b段資料新增中 name="insert_b.m_insert2"
            
      #end add-point
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "imbl_t:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = FALSE 
         CALL cl_err()
      END IF
      
      LET li_idx = g_detail_idx
      IF ps_page <> "'2'" THEN 
         CALL g_imbj2_d.insertElement(li_idx) 
      END IF 
 
      #add-point:insert_b段資料新增後 name="insert_b.after_insert2"
                  UPDATE imbl_t SET imbl001 = g_imba_m.imba001
       WHERE imblent = g_enterprise
         AND imbldocno = ps_keys[1]
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "imbl_t"
         LET g_errparam.popup = FALSE
         CALL cl_err()

      END IF
      #end add-point
   END IF
 
   LET ls_group = "'3',"
   #判斷是否是同一群組的table
   IF ls_group.getIndexOf(ps_page,1) > 0 THEN
      #add-point:insert_b段資料新增前 name="insert_b.before_insert3"
            
      #end add-point 
      INSERT INTO imbm_t
                  (imbment,
                   imbmdocno,
                   imbm002
                   ,imbm005,imbm003,imbm006,imbm004) 
            VALUES(g_enterprise,
                   ps_keys[1],ps_keys[2]
                   ,g_imbj3_d[g_detail_idx].imbm005,g_imbj3_d[g_detail_idx].imbm003,g_imbj3_d[g_detail_idx].imbm006, 
                       g_imbj3_d[g_detail_idx].imbm004)
      #add-point:insert_b段資料新增中 name="insert_b.m_insert3"
            
      #end add-point
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "imbm_t:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = FALSE 
         CALL cl_err()
      END IF
      
      LET li_idx = g_detail_idx
      IF ps_page <> "'3'" THEN 
         CALL g_imbj3_d.insertElement(li_idx) 
      END IF 
 
      #add-point:insert_b段資料新增後 name="insert_b.after_insert3"
                  UPDATE imbm_t SET imbm001 = g_imba_m.imba001
       WHERE imbment = g_enterprise
         AND imbmdocno = ps_keys[1]
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "imbm_t"
         LET g_errparam.popup = FALSE
         CALL cl_err()

      END IF
      #end add-point
   END IF
 
   LET ls_group = "'4',"
   #判斷是否是同一群組的table
   IF ls_group.getIndexOf(ps_page,1) > 0 THEN
      #add-point:insert_b段資料新增前 name="insert_b.before_insert4"
            
      #end add-point 
      INSERT INTO imbo_t
                  (imboent,
                   imbodocno,
                   imbo002
                   ) 
            VALUES(g_enterprise,
                   ps_keys[1],ps_keys[2]
                   )
      #add-point:insert_b段資料新增中 name="insert_b.m_insert4"
                  
      #end add-point
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "imbo_t:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = FALSE 
         CALL cl_err()
      END IF
      
      LET li_idx = g_detail_idx
      IF ps_page <> "'4'" THEN 
         CALL g_imbj4_d.insertElement(li_idx) 
      END IF 
 
      #add-point:insert_b段資料新增後 name="insert_b.after_insert4"
                  UPDATE imbo_t SET imbo000 = g_imba_m.imba000,
                        imbo001 = g_imba_m.imba001
       WHERE imboent = g_enterprise 
         AND imbodocno = ps_keys[1]
         AND imbo002 = ps_keys[2]
      #end add-point
   END IF
 
 
   
 
   
   #add-point:insert_b段other name="insert_b.other"
      
   #end add-point     
   
END FUNCTION
 
{</section>}
 
{<section id="aimt300.update_b" >}
#+ 修改單身後其他table連動
PRIVATE FUNCTION aimt300_update_b(ps_table,ps_keys,ps_keys_bak,ps_page)
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
   IF ls_group.getIndexOf(ps_page,1) > 0 AND ps_table <> "imbj_t" THEN
      #add-point:update_b段修改前 name="update_b.before_update"
            
      #end add-point 
      
      #將遮罩欄位還原
      CALL aimt300_imbj_t_mask_restore('restore_mask_o')
               
      UPDATE imbj_t 
         SET (imbjdocno,
              imbj002,imbj003
              ,imbj004,imbj005,imbj006) 
              = 
             (ps_keys[1],ps_keys[2],ps_keys[3]
              ,g_imbj_d[g_detail_idx].imbj004,g_imbj_d[g_detail_idx].imbj005,g_imbj_d[g_detail_idx].imbj006)  
 
         WHERE imbjent = g_enterprise AND imbjdocno = ps_keys_bak[1] AND imbj002 = ps_keys_bak[2] AND imbj003 = ps_keys_bak[3]
      #add-point:update_b段修改中 name="update_b.m_update"
            
      #end add-point   
      CASE
         WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "imbj_t" 
            LET g_errparam.code = "std-00009" 
            LET g_errparam.popup = TRUE 
            CALL s_transaction_end('N','0')
            CALL cl_err()
            
         WHEN SQLCA.SQLCODE #其他錯誤
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "imbj_t:",SQLERRMESSAGE 
            LET g_errparam.code = SQLCA.SQLCODE 
            LET g_errparam.popup = TRUE 
            CALL s_transaction_end('N','0')
            CALL cl_err()
            
         OTHERWISE
 
      END CASE
      
      #將遮罩欄位進行遮蔽
      CALL aimt300_imbj_t_mask_restore('restore_mask_n')
               
      #add-point:update_b段修改後 name="update_b.after_update"
            
      #end add-point  
   END IF
   
   #子表處理
   IF ls_group.getIndexOf(ps_page,1) > 0 THEN
      
   END IF
   
   
   LET ls_group = "'2',"
   #判斷是否是同一群組的table
   IF ls_group.getIndexOf(ps_page,1) > 0 AND ps_table <> "imbl_t" THEN
      #add-point:update_b段修改前 name="update_b.before_update2"
            
      #end add-point  
      
      #將遮罩欄位還原
      CALL aimt300_imbl_t_mask_restore('restore_mask_o')
               
      UPDATE imbl_t 
         SET (imbldocno,
              imbl002
              ) 
              = 
             (ps_keys[1],ps_keys[2]
              ) 
         WHERE imblent = g_enterprise AND imbldocno = ps_keys_bak[1] AND imbl002 = ps_keys_bak[2]
      #add-point:update_b段修改中 name="update_b.m_update2"
            
      #end add-point  
      CASE
         WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "imbl_t" 
            LET g_errparam.code = "std-00009" 
            LET g_errparam.popup = TRUE 
            CALL s_transaction_end('N','0')
            CALL cl_err()
            
         WHEN SQLCA.SQLCODE #其他錯誤
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "imbl_t:",SQLERRMESSAGE 
            LET g_errparam.code = SQLCA.SQLCODE 
            LET g_errparam.popup = TRUE 
            CALL s_transaction_end('N','0')
            CALL cl_err()
            
         OTHERWISE
          
      END CASE
      
      #將遮罩欄位進行遮蔽
      CALL aimt300_imbl_t_mask_restore('restore_mask_n')
 
      #add-point:update_b段修改後 name="update_b.after_update2"
            
      #end add-point  
   END IF
 
   #子表處理
   IF ls_group.getIndexOf(ps_page,1) > 0 THEN
      
   END IF
 
   LET ls_group = "'3',"
   #判斷是否是同一群組的table
   IF ls_group.getIndexOf(ps_page,1) > 0 AND ps_table <> "imbm_t" THEN
      #add-point:update_b段修改前 name="update_b.before_update3"
            
      #end add-point  
      
      #將遮罩欄位還原
      CALL aimt300_imbm_t_mask_restore('restore_mask_o')
               
      UPDATE imbm_t 
         SET (imbmdocno,
              imbm002
              ,imbm005,imbm003,imbm006,imbm004) 
              = 
             (ps_keys[1],ps_keys[2]
              ,g_imbj3_d[g_detail_idx].imbm005,g_imbj3_d[g_detail_idx].imbm003,g_imbj3_d[g_detail_idx].imbm006, 
                  g_imbj3_d[g_detail_idx].imbm004) 
         WHERE imbment = g_enterprise AND imbmdocno = ps_keys_bak[1] AND imbm002 = ps_keys_bak[2]
      #add-point:update_b段修改中 name="update_b.m_update3"
            
      #end add-point  
      CASE
         WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "imbm_t" 
            LET g_errparam.code = "std-00009" 
            LET g_errparam.popup = TRUE 
            CALL s_transaction_end('N','0')
            CALL cl_err()
            
         WHEN SQLCA.SQLCODE #其他錯誤
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "imbm_t:",SQLERRMESSAGE 
            LET g_errparam.code = SQLCA.SQLCODE 
            LET g_errparam.popup = TRUE 
            CALL s_transaction_end('N','0')
            CALL cl_err()
            
         OTHERWISE
          
      END CASE
      
      #將遮罩欄位進行遮蔽
      CALL aimt300_imbm_t_mask_restore('restore_mask_n')
 
      #add-point:update_b段修改後 name="update_b.after_update3"
            
      #end add-point  
   END IF
 
   #子表處理
   IF ls_group.getIndexOf(ps_page,1) > 0 THEN
      
   END IF
 
   LET ls_group = "'4',"
   #判斷是否是同一群組的table
   IF ls_group.getIndexOf(ps_page,1) > 0 AND ps_table <> "imbo_t" THEN
      #add-point:update_b段修改前 name="update_b.before_update4"
            
      #end add-point  
      
      #將遮罩欄位還原
      CALL aimt300_imbo_t_mask_restore('restore_mask_o')
               
      UPDATE imbo_t 
         SET (imbodocno,
              imbo002
              ) 
              = 
             (ps_keys[1],ps_keys[2]
              ) 
         WHERE imboent = g_enterprise AND imbodocno = ps_keys_bak[1] AND imbo002 = ps_keys_bak[2]
      #add-point:update_b段修改中 name="update_b.m_update4"
            
      #end add-point  
      CASE
         WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "imbo_t" 
            LET g_errparam.code = "std-00009" 
            LET g_errparam.popup = TRUE 
            CALL s_transaction_end('N','0')
            CALL cl_err()
            
         WHEN SQLCA.SQLCODE #其他錯誤
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "imbo_t:",SQLERRMESSAGE 
            LET g_errparam.code = SQLCA.SQLCODE 
            LET g_errparam.popup = TRUE 
            CALL s_transaction_end('N','0')
            CALL cl_err()
            
         OTHERWISE
          
      END CASE
      
      #將遮罩欄位進行遮蔽
      CALL aimt300_imbo_t_mask_restore('restore_mask_n')
 
      #add-point:update_b段修改後 name="update_b.after_update4"
            
      #end add-point  
   END IF
 
   #子表處理
   IF ls_group.getIndexOf(ps_page,1) > 0 THEN
      
   END IF
 
 
   
 
   
   #add-point:update_b段other name="update_b.other"
      
   #end add-point  
   
END FUNCTION
 
{</section>}
 
{<section id="aimt300.key_update_b" >}
#+ 上層單身key欄位變動後, 連帶修正下層單身key欄位
PRIVATE FUNCTION aimt300_key_update_b(ps_keys_bak,ps_table)
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
 
{<section id="aimt300.key_delete_b" >}
#+ 上層單身刪除後, 連帶刪除下層單身key欄位
PRIVATE FUNCTION aimt300_key_delete_b(ps_keys_bak,ps_table)
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
 
{<section id="aimt300.lock_b" >}
#+ 連動lock其他單身table資料
PRIVATE FUNCTION aimt300_lock_b(ps_table,ps_page)
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
   #CALL aimt300_b_fill()
   
   #鎖定整組table
   #LET ls_group = "'1',"
   #僅鎖定自身table
   LET ls_group = "imbj_t"
   
   IF ls_group.getIndexOf(ps_table,1) THEN
      OPEN aimt300_bcl USING g_enterprise,
                                       g_imba_m.imbadocno,g_imbj_d[g_detail_idx].imbj002,g_imbj_d[g_detail_idx].imbj003  
                                               
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "aimt300_bcl:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = TRUE 
         CALL cl_err()
         RETURN FALSE
      END IF
   END IF
                                    
   #鎖定整組table
   #LET ls_group = "'2',"
   #僅鎖定自身table
   LET ls_group = "imbl_t"
   IF ls_group.getIndexOf(ps_table,1) THEN
   
      OPEN aimt300_bcl2 USING g_enterprise,
                                             g_imba_m.imbadocno,g_imbj2_d[g_detail_idx].imbl002
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "aimt300_bcl2:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = TRUE 
         CALL cl_err()
         RETURN FALSE
      END IF
   END IF
 
   #鎖定整組table
   #LET ls_group = "'3',"
   #僅鎖定自身table
   LET ls_group = "imbm_t"
   IF ls_group.getIndexOf(ps_table,1) THEN
   
      OPEN aimt300_bcl3 USING g_enterprise,
                                             g_imba_m.imbadocno,g_imbj3_d[g_detail_idx].imbm002
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "aimt300_bcl3:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = TRUE 
         CALL cl_err()
         RETURN FALSE
      END IF
   END IF
 
   #鎖定整組table
   #LET ls_group = "'4',"
   #僅鎖定自身table
   LET ls_group = "imbo_t"
   IF ls_group.getIndexOf(ps_table,1) THEN
   
      OPEN aimt300_bcl4 USING g_enterprise,
                                             g_imba_m.imbadocno,g_imbj4_d[g_detail_idx].imbo002
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "aimt300_bcl4:",SQLERRMESSAGE 
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
 
{<section id="aimt300.unlock_b" >}
#+ 連動unlock其他單身table資料
PRIVATE FUNCTION aimt300_unlock_b(ps_table,ps_page)
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
      CLOSE aimt300_bcl
   END IF
   
   LET ls_group = "'2',"
   
   IF ls_group.getIndexOf(ps_page,1) THEN
      CLOSE aimt300_bcl2
   END IF
 
   LET ls_group = "'3',"
   
   IF ls_group.getIndexOf(ps_page,1) THEN
      CLOSE aimt300_bcl3
   END IF
 
   LET ls_group = "'4',"
   
   IF ls_group.getIndexOf(ps_page,1) THEN
      CLOSE aimt300_bcl4
   END IF
 
 
   
 
 
   #add-point:unlock_b段other name="unlock_b.other"
      
   #end add-point  
 
END FUNCTION
 
{</section>}
 
{<section id="aimt300.set_entry" >}
#+ 單頭欄位開啟設定
PRIVATE FUNCTION aimt300_set_entry(p_cmd)
   #add-point:set_entry段define(客製用) name="set_entry.define_customerization"
   
   #end add-point       
   DEFINE p_cmd   LIKE type_t.chr1  
   #add-point:set_entry段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_entry.define"
      
   #end add-point       
   
   #add-point:Function前置處理  name="set_entry.pre_function"
   
   #end add-point
   
   CALL cl_set_comp_entry("imbadocno",TRUE)
   
   IF p_cmd = 'a' THEN
      CALL cl_set_comp_entry("imbadocno",TRUE)
      CALL cl_set_comp_entry("imbadocdt",TRUE)
      #根據azzi850使用者身分開關特定欄位
      IF NOT cl_null(g_no_entry) THEN
         CALL cl_set_comp_entry(g_no_entry,TRUE)
      END IF
      #add-point:set_entry段欄位控制 name="set_entry.field_control"
                  CALL cl_set_comp_entry("imbadocdt",TRUE)
      #end add-point  
   END IF
   
   #add-point:set_entry段欄位控制後 name="set_entry.after_control"
         CALL cl_set_comp_entry("imba028",TRUE)
   CALL cl_set_comp_entry("imba029",TRUE)
   CALL cl_set_comp_entry("imba030",TRUE)
   CALL cl_set_comp_entry("imba031",TRUE)
   CALL cl_set_comp_entry("imba032",TRUE)
   CALL cl_set_comp_entry("imba033",TRUE)
   CALL cl_set_comp_entry("imba005,imba009,imba003",TRUE)
   #end add-point 
 
END FUNCTION
 
{</section>}
 
{<section id="aimt300.set_no_entry" >}
#+ 單頭欄位關閉設定
PRIVATE FUNCTION aimt300_set_no_entry(p_cmd)
   #add-point:set_no_entry段define(客製用) name="set_no_entry.define_customerization"
   
   #end add-point     
   DEFINE p_cmd   LIKE type_t.chr1   
   #add-point:set_no_entry段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_no_entry.define"
         DEFINE l_n     LIKE type_t.num5
   #end add-point     
   
   #add-point:Function前置處理  name="set_no_entry.pre_function"
   
   #end add-point
   
   IF p_cmd = 'u' AND g_chkey = 'N' THEN
      CALL cl_set_comp_entry("imbadocno",FALSE)
      #根據azzi850使用者身分開關特定欄位
      IF NOT cl_null(g_no_entry) THEN
         CALL cl_set_comp_entry(g_no_entry,FALSE)
      END IF
      #add-point:set_no_entry段欄位控制 name="set_no_entry.field_control"
                  CALL cl_set_comp_entry("imbadocdt",FALSE)
      #end add-point 
   END IF 
   
   IF p_cmd = 'u' THEN  #docno,ld欄位確認是絕對關閉
      CALL cl_set_comp_entry("imbadocno",FALSE)
   END IF 
 
#  IF p_cmd = 'u' THEN  #docdt欄位依照設定關閉(FALSE則為設定不同意修正) #(ver:78)
      IF NOT cl_chk_update_docdt() THEN
         CALL cl_set_comp_entry("imbadocdt",FALSE)
      END IF
#  END IF 
   
   #add-point:set_no_entry段欄位控制後 name="set_no_entry.after_control"
         IF g_imba_m.imba027 = 'N' THEN
      CALL cl_set_comp_entry("imba028",FALSE)
      CALL cl_set_comp_entry("imba029",FALSE)
      CALL cl_set_comp_entry("imba030",FALSE)
      CALL cl_set_comp_entry("imba031",FALSE)
      CALL cl_set_comp_entry("imba032",FALSE)
      CALL cl_set_comp_entry("imba033",FALSE)
      LET g_imba_m.imba028 = ""
      LET g_imba_m.imba029 = ""
      LET g_imba_m.imba030 = ""
      LET g_imba_m.imba031 = ""
      LET g_imba_m.imba032 = ""
      LET g_imba_m.imba033 = ""
      DISPLAY g_imba_m.imba028
      DISPLAY g_imba_m.imba029
      DISPLAY g_imba_m.imba030
      DISPLAY g_imba_m.imba031
      DISPLAY g_imba_m.imba032
      DISPLAY g_imba_m.imba033
   END IF
#15/06/17 Sarah mark
#偉聖說不用因為有inag_t就鎖不能改產品分類碼與主分群碼
#   LET l_n = 0
#   SELECT COUNT(*) INTO l_n
#     FROM inag_t
#    WHERE inagent = g_enterprise
#      AND inagsite = g_site
#      AND inag001 = g_imba_m.imba001
#   IF l_n > 0 THEN
#      CALL cl_set_comp_entry("imba005,imba009,imba003",FALSE)
#   END IF
#15/06/17 Sarah mark
   #end add-point 
 
END FUNCTION
 
{</section>}
 
{<section id="aimt300.set_entry_b" >}
#+ 單身欄位開啟設定
PRIVATE FUNCTION aimt300_set_entry_b(p_cmd)
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
 
{<section id="aimt300.set_no_entry_b" >}
#+ 單身欄位關閉設定
PRIVATE FUNCTION aimt300_set_no_entry_b(p_cmd)
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
 
{<section id="aimt300.set_act_visible" >}
#+ 單頭權限開啟
PRIVATE FUNCTION aimt300_set_act_visible()
   #add-point:set_act_visible段define(客製用) name="set_act_visible.define_customerization"
   
   #end add-point   
   #add-point:set_act_visible段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_visible.define"
   
   #end add-point   
   #add-point:set_act_visible段 name="set_act_visible.set_act_visible"
   CALL cl_set_act_visible("fillprd,chptz", TRUE)   #add by lixiang 2015/12/03
   #end add-point   
END FUNCTION
 
{</section>}
 
{<section id="aimt300.set_act_no_visible" >}
#+ 單頭權限關閉
PRIVATE FUNCTION aimt300_set_act_no_visible()
   #add-point:set_act_no_visible段define(客製用) name="set_act_no_visible.define_customerization"
   
   #end add-point   
   #add-point:set_act_no_visible段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_no_visible.define"
DEFINE l_n     LIKE type_t.num5
   #end add-point   
   #add-point:set_act_no_visible段 name="set_act_no_visible.set_act_no_visible"
   #應用 a63 樣板自動產生(Version:1)
   IF g_imba_m.imbastus NOT MATCHES "[NDR]" THEN   # N未確認/D抽單/R已拒絕允許修改
      CALL cl_set_act_visible("modify,delete,modify_detail", FALSE)
      CALL cl_set_act_visible("fillprd", FALSE)   #add by lixiang 2015/12/03
   END IF

   #add by lixiang 2015/12/03---begin--
   LET l_n = 0
   SELECT COUNT(*) INTO l_n FROM inag_t WHERE inagent = g_enterprise AND inag001 = g_imba_m.imba001
   IF l_n > 0 OR cl_null(g_imba_m.imba005) THEN
      CALL cl_set_act_visible("chptz", FALSE)
   END IF
   #add by lixiang 2015/12/03---end---
   
   #end add-point   
END FUNCTION
 
{</section>}
 
{<section id="aimt300.set_act_visible_b" >}
#+ 單身權限開啟
PRIVATE FUNCTION aimt300_set_act_visible_b()
   #add-point:set_act_visible_b段define(客製用) name="set_act_visible_b.define_customerization"
   
   #end add-point   
   #add-point:set_act_visible_b段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_visible_b.define"
   
   #end add-point   
   #add-point:set_act_visible_b段 name="set_act_visible_b.set_act_visible_b"
   
   #end add-point   
END FUNCTION
 
{</section>}
 
{<section id="aimt300.set_act_no_visible_b" >}
#+ 單身權限關閉
PRIVATE FUNCTION aimt300_set_act_no_visible_b()
   #add-point:set_act_no_visible_b段define(客製用) name="set_act_no_visible_b.define_customerization"
   
   #end add-point   
   #add-point:set_act_no_visible_b段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_no_visible_b.define"
   
   #end add-point   
   #add-point:set_act_no_visible_b段 name="set_act_no_visible_b.set_act_no_visible_b"
   
   #end add-point   
END FUNCTION
 
{</section>}
 
{<section id="aimt300.default_search" >}
#+ 外部參數搜尋
PRIVATE FUNCTION aimt300_default_search()
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
      LET ls_wc = ls_wc, " imbadocno = '", g_argv[01], "' AND "
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
 
 
         FOR li_idx = 1 TO la_wc.getLength()
            CASE
               WHEN la_wc[li_idx].tableid = "imba_t" 
                  LET g_wc = la_wc[li_idx].wc
               WHEN la_wc[li_idx].tableid = "imbj_t" 
                  LET g_wc2_table1 = la_wc[li_idx].wc
               WHEN la_wc[li_idx].tableid = "imbl_t" 
                  LET g_wc2_table2 = la_wc[li_idx].wc
 
               WHEN la_wc[li_idx].tableid = "imbm_t" 
                  LET g_wc2_table3 = la_wc[li_idx].wc
 
               WHEN la_wc[li_idx].tableid = "imbo_t" 
                  LET g_wc2_table4 = la_wc[li_idx].wc
 
 
               WHEN la_wc[li_idx].tableid = "EXTENDWC"
                  LET g_wc2_extend = la_wc[li_idx].wc
            END CASE
         END FOR
         IF NOT cl_null(g_wc) OR NOT cl_null(g_wc2_table1) 
            OR NOT cl_null(g_wc2_table2)
 
            OR NOT cl_null(g_wc2_table3)
 
            OR NOT cl_null(g_wc2_table4)
 
 
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
 
{<section id="aimt300.state_change" >}
   #應用 a09 樣板自動產生(Version:17)
#+ 確認碼變更 
PRIVATE FUNCTION aimt300_statechange()
   #add-point:statechange段define(客製用) name="statechange.define_customerization"
   
   #end add-point  
   DEFINE lc_state LIKE type_t.chr5
   #add-point:statechange段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="statechange.define"
         DEFINE l_time   DATETIME YEAR TO SECOND
         
#150312---earl---add---s
   DEFINE la_param       RECORD
             prog        STRING,
             param       DYNAMIC ARRAY OF STRING
                         END RECORD
   DEFINE ls_js          STRING
#150312---earl---add---e
         
   #end add-point  
   
   #add-point:Function前置處理 name="statechange.before"
   IF g_imba_m.imbastus MATCHES '[XY]' THEN
      RETURN
   END IF    
   #end add-point  
   
   ERROR ""     #清空畫面右下側ERROR區塊
 
   IF g_imba_m.imbadocno IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code   = "std-00003" 
      LET g_errparam.popup  = FALSE 
      CALL cl_err()
      RETURN
   END IF
 
   CALL s_transaction_begin()
   
   OPEN aimt300_cl USING g_enterprise,g_imba_m.imbadocno
   IF STATUS THEN
      CLOSE aimt300_cl
      CALL s_transaction_end('N','0')
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "OPEN aimt300_cl:" 
      LET g_errparam.code   = STATUS 
      LET g_errparam.popup  = TRUE 
      CALL cl_err()
      RETURN
   END IF
   
   #顯示最新的資料
   EXECUTE aimt300_master_referesh USING g_imba_m.imbadocno INTO g_imba_m.imbadocno,g_imba_m.imbadocdt, 
       g_imba_m.imba000,g_imba_m.imba900,g_imba_m.imba901,g_imba_m.imbastus,g_imba_m.imba001,g_imba_m.imba002, 
       g_imba_m.imba009,g_imba_m.imba003,g_imba_m.imba004,g_imba_m.imba005,g_imba_m.imba006,g_imba_m.imba010, 
       g_imba_m.imba126,g_imba_m.imba127,g_imba_m.imba131,g_imba_m.imba128,g_imba_m.imba129,g_imba_m.imba130, 
       g_imba_m.imba132,g_imba_m.imba133,g_imba_m.imba134,g_imba_m.imba135,g_imba_m.imba136,g_imba_m.imba137, 
       g_imba_m.imba138,g_imba_m.imba139,g_imba_m.imba140,g_imba_m.imba141,g_imba_m.imbaownid,g_imba_m.imbaowndp, 
       g_imba_m.imbacrtid,g_imba_m.imbacrtdp,g_imba_m.imbacrtdt,g_imba_m.imbamodid,g_imba_m.imbamoddt, 
       g_imba_m.imbacnfid,g_imba_m.imbacnfdt,g_imba_m.imba011,g_imba_m.imba012,g_imba_m.imba013,g_imba_m.imba014, 
       g_imba_m.imba142,g_imba_m.imba108,g_imba_m.imba100,g_imba_m.imba109,g_imba_m.imba101,g_imba_m.imba104, 
       g_imba_m.imba105,g_imba_m.imba106,g_imba_m.imba107,g_imba_m.imba124,g_imba_m.imba145,g_imba_m.imba146, 
       g_imba_m.imba016,g_imba_m.imba017,g_imba_m.imba018,g_imba_m.imba019,g_imba_m.imba020,g_imba_m.imba021, 
       g_imba_m.imba022,g_imba_m.imba023,g_imba_m.imba024,g_imba_m.imba025,g_imba_m.imba026,g_imba_m.imba027, 
       g_imba_m.imba028,g_imba_m.imba029,g_imba_m.imba030,g_imba_m.imba031,g_imba_m.imba032,g_imba_m.imba033, 
       g_imba_m.imba034,g_imba_m.imba035,g_imba_m.imba036,g_imba_m.imba037,g_imba_m.imba043,g_imba_m.imba038, 
       g_imba_m.imba041,g_imba_m.imba042,g_imba_m.imba044,g_imba_m.imba122,g_imba_m.imba045,g_imba_m.imba123, 
       g_imba_m.imba900_desc,g_imba_m.imba901_desc,g_imba_m.imba009_desc,g_imba_m.imba003_desc,g_imba_m.imba005_desc, 
       g_imba_m.imba006_desc,g_imba_m.imba010_desc,g_imba_m.imba126_desc,g_imba_m.imba127_desc,g_imba_m.imba131_desc, 
       g_imba_m.imba128_desc,g_imba_m.imba129_desc,g_imba_m.imba132_desc,g_imba_m.imba133_desc,g_imba_m.imba134_desc, 
       g_imba_m.imba135_desc,g_imba_m.imba136_desc,g_imba_m.imba137_desc,g_imba_m.imba138_desc,g_imba_m.imba139_desc, 
       g_imba_m.imba140_desc,g_imba_m.imba141_desc,g_imba_m.imbaownid_desc,g_imba_m.imbaowndp_desc,g_imba_m.imbacrtid_desc, 
       g_imba_m.imbacrtdp_desc,g_imba_m.imbamodid_desc,g_imba_m.imbacnfid_desc,g_imba_m.imba142_desc, 
       g_imba_m.imba018_desc,g_imba_m.imba022_desc,g_imba_m.imba029_desc,g_imba_m.imba032_desc,g_imba_m.imba122_desc, 
       g_imba_m.imba045_desc
   
 
   #檢查是否允許此動作
   IF NOT aimt300_action_chk() THEN
      CLOSE aimt300_cl
      CALL s_transaction_end('N','0')
      RETURN
   END IF
 
   #將資料顯示到畫面上
   DISPLAY BY NAME g_imba_m.imbadocno,g_imba_m.oobxl003,g_imba_m.imbadocdt,g_imba_m.imba000,g_imba_m.imba900, 
       g_imba_m.imba900_desc,g_imba_m.imba901,g_imba_m.imba901_desc,g_imba_m.imbastus,g_imba_m.imba001, 
       g_imba_m.imba002,g_imba_m.imbal002,g_imba_m.imbal003,g_imba_m.imbal004,g_imba_m.imba009,g_imba_m.imba009_desc, 
       g_imba_m.imba003,g_imba_m.imba003_desc,g_imba_m.imba004,g_imba_m.imba005,g_imba_m.imba005_desc, 
       g_imba_m.imba006,g_imba_m.imba006_desc,g_imba_m.imba010,g_imba_m.imba010_desc,g_imba_m.imba126, 
       g_imba_m.imba126_desc,g_imba_m.imba127,g_imba_m.imba127_desc,g_imba_m.imba131,g_imba_m.imba131_desc, 
       g_imba_m.imba128,g_imba_m.imba128_desc,g_imba_m.imba129,g_imba_m.imba129_desc,g_imba_m.imba130, 
       g_imba_m.imba132,g_imba_m.imba132_desc,g_imba_m.imba133,g_imba_m.imba133_desc,g_imba_m.imba134, 
       g_imba_m.imba134_desc,g_imba_m.imba135,g_imba_m.imba135_desc,g_imba_m.imba136,g_imba_m.imba136_desc, 
       g_imba_m.imba137,g_imba_m.imba137_desc,g_imba_m.imba138,g_imba_m.imba138_desc,g_imba_m.imba139, 
       g_imba_m.imba139_desc,g_imba_m.imba140,g_imba_m.imba140_desc,g_imba_m.imba141,g_imba_m.imba141_desc, 
       g_imba_m.imbaownid,g_imba_m.imbaownid_desc,g_imba_m.imbaowndp,g_imba_m.imbaowndp_desc,g_imba_m.imbacrtid, 
       g_imba_m.imbacrtid_desc,g_imba_m.imbacrtdp,g_imba_m.imbacrtdp_desc,g_imba_m.imbacrtdt,g_imba_m.imbamodid, 
       g_imba_m.imbamodid_desc,g_imba_m.imbamoddt,g_imba_m.imbacnfid,g_imba_m.imbacnfid_desc,g_imba_m.imbacnfdt, 
       g_imba_m.imba011,g_imba_m.imba012,g_imba_m.imba013,g_imba_m.imba014,g_imba_m.imba142,g_imba_m.imba142_desc, 
       g_imba_m.imba108,g_imba_m.imba100,g_imba_m.imba109,g_imba_m.imba101,g_imba_m.imba104,g_imba_m.imba105, 
       g_imba_m.imba106,g_imba_m.imba107,g_imba_m.imba124,g_imba_m.imba145,g_imba_m.imba146,g_imba_m.imba016, 
       g_imba_m.imba017,g_imba_m.imba018,g_imba_m.imba018_desc,g_imba_m.imba019,g_imba_m.imba020,g_imba_m.imba021, 
       g_imba_m.imba022,g_imba_m.imba022_desc,g_imba_m.imba023,g_imba_m.imba024,g_imba_m.imba025,g_imba_m.imba026, 
       g_imba_m.imba027,g_imba_m.imba028,g_imba_m.imba029,g_imba_m.imba029_desc,g_imba_m.imba030,g_imba_m.imba031, 
       g_imba_m.imba032,g_imba_m.imba032_desc,g_imba_m.imba033,g_imba_m.imba034,g_imba_m.imba035,g_imba_m.imba036, 
       g_imba_m.imba037,g_imba_m.imba043,g_imba_m.imba038,g_imba_m.imba041,g_imba_m.imba042,g_imba_m.imba044, 
       g_imba_m.imba122,g_imba_m.imba122_desc,g_imba_m.imba045,g_imba_m.imba045_desc,g_imba_m.imba123 
 
 
   CASE g_imba_m.imbastus
      WHEN "N"
         CALL gfrm_curr.setElementImage("statechange", "stus/32/unconfirmed.png")
      WHEN "W"
         CALL gfrm_curr.setElementImage("statechange", "stus/32/signing.png")
      WHEN "A"
         CALL gfrm_curr.setElementImage("statechange", "stus/32/approved.png")
      WHEN "Y"
         CALL gfrm_curr.setElementImage("statechange", "stus/32/confirmed.png")
      WHEN "D"
         CALL gfrm_curr.setElementImage("statechange", "stus/32/withdraw.png")
      WHEN "R"
         CALL gfrm_curr.setElementImage("statechange", "stus/32/rejection.png")
      WHEN "X"
         CALL gfrm_curr.setElementImage("statechange", "stus/32/invalid.png")
      
   END CASE
 
   #add-point:資料刷新後 name="statechange.after_refresh"
   
   #end add-point
 
   MENU "" ATTRIBUTES (STYLE="popup")
      BEFORE MENU
         HIDE OPTION "approved"
         HIDE OPTION "rejection"
         CASE g_imba_m.imbastus
            
            WHEN "N"
               HIDE OPTION "unconfirmed"
            WHEN "W"
               HIDE OPTION "signing"
            WHEN "A"
               HIDE OPTION "approved"
            WHEN "Y"
               HIDE OPTION "confirmed"
            WHEN "D"
               HIDE OPTION "withdraw"
            WHEN "R"
               HIDE OPTION "rejection"
            WHEN "X"
               HIDE OPTION "invalid"
         END CASE
     
      #add-point:menu前 name="statechange.before_menu"
      CALL cl_set_act_visible("invalid,confirmed",TRUE)
      CALL cl_set_act_visible("closed",FALSE)
      CALL cl_set_act_visible("signing,withdraw",FALSE)      
      
      CASE g_imba_m.imbastus
         WHEN "N"
            CALL cl_set_act_visible("unconfirmed",FALSE)
            #需提交至BPM時，則顯示「提交」功能並隱藏「確認」功能
            IF cl_bpm_chk() THEN
                CALL cl_set_act_visible("signing",TRUE)
                CALL cl_set_act_visible("confirmed",FALSE)
            END IF
            
         WHEN "R"   #保留修改的功能(如作廢)，隱藏其他應用功能(如: 確認、未確認、留置、過帳…)
            CALL cl_set_act_visible("confirmed,unconfirmed",FALSE)

         WHEN "D"   #保留修改的功能(如作廢)，隱藏其他應用功能(如: 確認、未確認、留置、過帳…)
            CALL cl_set_act_visible("confirmed,unconfirmed",FALSE) 
   
         WHEN "X"
            CALL cl_set_act_visible("unconfirmed,invalid,confirmed",FALSE)

         WHEN "Y"
            CALL cl_set_act_visible("invalid,confirmed",FALSE)
            
         WHEN "W"    #只能顯示抽單;其餘應用功能皆隱藏
             CALL cl_set_act_visible("withdraw",TRUE)  
             CALL cl_set_act_visible("unconfirmed,invalid,confirmed",FALSE)
         
         WHEN "A"     #只能顯示確認; 其餘應用功能皆隱藏
             CALL cl_set_act_visible("confirmed ",TRUE)  
             CALL cl_set_act_visible("unconfirmed,invalid",FALSE)
   
      END CASE
      #end add-point
      
      #應用 a36 樣板自動產生(Version:5)
      #提交
      ON ACTION signing
         IF cl_auth_chk_act("signing") THEN
            IF NOT aimt300_send() THEN
               CALL s_transaction_end('N','0')
            ELSE
               CALL s_transaction_end('Y','0')
            END IF
            #因應簽核行為, 該動作完成後不再進行後續處理
            #於此處直接返回
            CLOSE aimt300_cl
            RETURN
         END IF
    
      #抽單
      ON ACTION withdraw
         IF cl_auth_chk_act("withdraw") THEN
            IF NOT aimt300_draw_out() THEN
               CALL s_transaction_end('N','0')
            ELSE
               CALL s_transaction_end('Y','0')
            END IF
            #因應簽核行為, 該動作完成後不再進行後續處理
            #於此處直接返回
            CLOSE aimt300_cl
            RETURN
         END IF
 
 
 
	  
      ON ACTION unconfirmed
         IF cl_auth_chk_act("unconfirmed") THEN
            LET lc_state = "N"
            #add-point:action控制 name="statechange.unconfirmed"
            
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
      ON ACTION approved
         IF cl_auth_chk_act("approved") THEN
            LET lc_state = "A"
            #add-point:action控制 name="statechange.approved"
            
            #end add-point
         END IF
         EXIT MENU
      ON ACTION confirmed
         IF cl_auth_chk_act("confirmed") THEN
            LET lc_state = "Y"
            #add-point:action控制 name="statechange.confirmed"
                  
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
      ON ACTION invalid
         IF cl_auth_chk_act("invalid") THEN
            LET lc_state = "X"
            #add-point:action控制 name="statechange.invalid"
                  
            #end add-point
         END IF
         EXIT MENU
 
      #add-point:stus控制 name="statechange.more_control"
                  
      #end add-point
      
   END MENU
   
   #確認被選取的狀態碼在清單中
   IF (lc_state <> "N" 
      AND lc_state <> "W"
      AND lc_state <> "A"
      AND lc_state <> "Y"
      AND lc_state <> "D"
      AND lc_state <> "R"
      AND lc_state <> "X"
      ) OR 
      g_imba_m.imbastus = lc_state OR cl_null(lc_state) THEN
      CLOSE aimt300_cl
      CALL s_transaction_end('N','0')
      RETURN
   END IF
   
   #add-point:stus修改前 name="statechange.b_update"
   LET l_success = TRUE
   CALL s_aimm200_create_tmp()      #161222-00018#1 add
   CALL s_transaction_begin()
   IF lc_state = 'Y' THEN
      CALL s_aimt300_conf_chk(g_imba_m.imbadocno,g_imba_m.imbastus) RETURNING l_success
      IF NOT l_success THEN
         CALL s_transaction_end('N','0')
         RETURN
      ELSE
         IF NOT cl_ask_confirm('aim-00108') THEN 
            RETURN
         ELSE
            CALL s_aimt300_conf_upd(g_imba_m.imbadocno) RETURNING l_success
            IF NOT l_success THEN
               CALL s_transaction_end('N','0')
               RETURN
            END IF
            #170113-00035#1--mark---s
            #CALL s_aimt300_carry_chk(g_imba_m.imbadocno,'Y') RETURNING l_success
            #IF NOT l_success THEN
            #   CALL s_transaction_end('N','0')
            #   RETURN
            #END IF
            #CALL s_aimt300_carry_upd(g_imba_m.imbadocno) RETURNING l_success
            #IF NOT l_success THEN
            #   CALL s_transaction_end('N','0')
            #   RETURN
            #END IF
            #170113-00035#1--mark---e
            CALL aimt300_send_mail()
         END IF
      END IF
   END IF
   IF lc_state = 'X' THEN
      CALL s_aimt300_void_chk(g_imba_m.imbadocno,g_imba_m.imbastus) RETURNING l_success
      IF NOT l_success THEN
         CALL s_transaction_end('N','0')
         RETURN
      ELSE
         IF NOT cl_ask_confirm('aim-00109') THEN 
            RETURN
         ELSE
            CALL s_aimt300_void_upd(g_imba_m.imbadocno) RETURNING l_success
            IF NOT l_success THEN
               CALL s_transaction_end('N','0')
               RETURN
            END IF
         END IF
      END IF
   END IF
   CALL s_transaction_end('Y','0')
   
   #150312---earl---add---s
   #若無單位轉換率開啟aimi190
   IF lc_state = 'Y' THEN
      IF NOT s_aimm300_unit_chk(g_imba_m.imbadocno,'','','') THEN
         INITIALIZE la_param.* TO NULL
         LET la_param.prog = 'aimi190'
         LET la_param.param[1] = g_imba_m.imba001
         LET la_param.param[2] = 'Y'

         LET ls_js = util.JSON.stringify( la_param )
         CALL cl_cmdrun(ls_js)
         
      END IF
   END IF
   #150312---earl---add---e
   #end add-point
   
   LET g_imba_m.imbamodid = g_user
   LET g_imba_m.imbamoddt = cl_get_current()
   LET g_imba_m.imbastus = lc_state
   
   #異動狀態碼欄位/修改人/修改日期
   UPDATE imba_t 
      SET (imbastus,imbamodid,imbamoddt) 
        = (g_imba_m.imbastus,g_imba_m.imbamodid,g_imba_m.imbamoddt)     
    WHERE imbaent = g_enterprise AND imbadocno = g_imba_m.imbadocno
 
    
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
         WHEN "W"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/signing.png")
         WHEN "A"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/approved.png")
         WHEN "Y"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/confirmed.png")
         WHEN "D"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/withdraw.png")
         WHEN "R"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/rejection.png")
         WHEN "X"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/invalid.png")
         
      END CASE
    
      #撈取異動後的資料
      EXECUTE aimt300_master_referesh USING g_imba_m.imbadocno INTO g_imba_m.imbadocno,g_imba_m.imbadocdt, 
          g_imba_m.imba000,g_imba_m.imba900,g_imba_m.imba901,g_imba_m.imbastus,g_imba_m.imba001,g_imba_m.imba002, 
          g_imba_m.imba009,g_imba_m.imba003,g_imba_m.imba004,g_imba_m.imba005,g_imba_m.imba006,g_imba_m.imba010, 
          g_imba_m.imba126,g_imba_m.imba127,g_imba_m.imba131,g_imba_m.imba128,g_imba_m.imba129,g_imba_m.imba130, 
          g_imba_m.imba132,g_imba_m.imba133,g_imba_m.imba134,g_imba_m.imba135,g_imba_m.imba136,g_imba_m.imba137, 
          g_imba_m.imba138,g_imba_m.imba139,g_imba_m.imba140,g_imba_m.imba141,g_imba_m.imbaownid,g_imba_m.imbaowndp, 
          g_imba_m.imbacrtid,g_imba_m.imbacrtdp,g_imba_m.imbacrtdt,g_imba_m.imbamodid,g_imba_m.imbamoddt, 
          g_imba_m.imbacnfid,g_imba_m.imbacnfdt,g_imba_m.imba011,g_imba_m.imba012,g_imba_m.imba013,g_imba_m.imba014, 
          g_imba_m.imba142,g_imba_m.imba108,g_imba_m.imba100,g_imba_m.imba109,g_imba_m.imba101,g_imba_m.imba104, 
          g_imba_m.imba105,g_imba_m.imba106,g_imba_m.imba107,g_imba_m.imba124,g_imba_m.imba145,g_imba_m.imba146, 
          g_imba_m.imba016,g_imba_m.imba017,g_imba_m.imba018,g_imba_m.imba019,g_imba_m.imba020,g_imba_m.imba021, 
          g_imba_m.imba022,g_imba_m.imba023,g_imba_m.imba024,g_imba_m.imba025,g_imba_m.imba026,g_imba_m.imba027, 
          g_imba_m.imba028,g_imba_m.imba029,g_imba_m.imba030,g_imba_m.imba031,g_imba_m.imba032,g_imba_m.imba033, 
          g_imba_m.imba034,g_imba_m.imba035,g_imba_m.imba036,g_imba_m.imba037,g_imba_m.imba043,g_imba_m.imba038, 
          g_imba_m.imba041,g_imba_m.imba042,g_imba_m.imba044,g_imba_m.imba122,g_imba_m.imba045,g_imba_m.imba123, 
          g_imba_m.imba900_desc,g_imba_m.imba901_desc,g_imba_m.imba009_desc,g_imba_m.imba003_desc,g_imba_m.imba005_desc, 
          g_imba_m.imba006_desc,g_imba_m.imba010_desc,g_imba_m.imba126_desc,g_imba_m.imba127_desc,g_imba_m.imba131_desc, 
          g_imba_m.imba128_desc,g_imba_m.imba129_desc,g_imba_m.imba132_desc,g_imba_m.imba133_desc,g_imba_m.imba134_desc, 
          g_imba_m.imba135_desc,g_imba_m.imba136_desc,g_imba_m.imba137_desc,g_imba_m.imba138_desc,g_imba_m.imba139_desc, 
          g_imba_m.imba140_desc,g_imba_m.imba141_desc,g_imba_m.imbaownid_desc,g_imba_m.imbaowndp_desc, 
          g_imba_m.imbacrtid_desc,g_imba_m.imbacrtdp_desc,g_imba_m.imbamodid_desc,g_imba_m.imbacnfid_desc, 
          g_imba_m.imba142_desc,g_imba_m.imba018_desc,g_imba_m.imba022_desc,g_imba_m.imba029_desc,g_imba_m.imba032_desc, 
          g_imba_m.imba122_desc,g_imba_m.imba045_desc
      
      #將資料顯示到畫面上
      DISPLAY BY NAME g_imba_m.imbadocno,g_imba_m.oobxl003,g_imba_m.imbadocdt,g_imba_m.imba000,g_imba_m.imba900, 
          g_imba_m.imba900_desc,g_imba_m.imba901,g_imba_m.imba901_desc,g_imba_m.imbastus,g_imba_m.imba001, 
          g_imba_m.imba002,g_imba_m.imbal002,g_imba_m.imbal003,g_imba_m.imbal004,g_imba_m.imba009,g_imba_m.imba009_desc, 
          g_imba_m.imba003,g_imba_m.imba003_desc,g_imba_m.imba004,g_imba_m.imba005,g_imba_m.imba005_desc, 
          g_imba_m.imba006,g_imba_m.imba006_desc,g_imba_m.imba010,g_imba_m.imba010_desc,g_imba_m.imba126, 
          g_imba_m.imba126_desc,g_imba_m.imba127,g_imba_m.imba127_desc,g_imba_m.imba131,g_imba_m.imba131_desc, 
          g_imba_m.imba128,g_imba_m.imba128_desc,g_imba_m.imba129,g_imba_m.imba129_desc,g_imba_m.imba130, 
          g_imba_m.imba132,g_imba_m.imba132_desc,g_imba_m.imba133,g_imba_m.imba133_desc,g_imba_m.imba134, 
          g_imba_m.imba134_desc,g_imba_m.imba135,g_imba_m.imba135_desc,g_imba_m.imba136,g_imba_m.imba136_desc, 
          g_imba_m.imba137,g_imba_m.imba137_desc,g_imba_m.imba138,g_imba_m.imba138_desc,g_imba_m.imba139, 
          g_imba_m.imba139_desc,g_imba_m.imba140,g_imba_m.imba140_desc,g_imba_m.imba141,g_imba_m.imba141_desc, 
          g_imba_m.imbaownid,g_imba_m.imbaownid_desc,g_imba_m.imbaowndp,g_imba_m.imbaowndp_desc,g_imba_m.imbacrtid, 
          g_imba_m.imbacrtid_desc,g_imba_m.imbacrtdp,g_imba_m.imbacrtdp_desc,g_imba_m.imbacrtdt,g_imba_m.imbamodid, 
          g_imba_m.imbamodid_desc,g_imba_m.imbamoddt,g_imba_m.imbacnfid,g_imba_m.imbacnfid_desc,g_imba_m.imbacnfdt, 
          g_imba_m.imba011,g_imba_m.imba012,g_imba_m.imba013,g_imba_m.imba014,g_imba_m.imba142,g_imba_m.imba142_desc, 
          g_imba_m.imba108,g_imba_m.imba100,g_imba_m.imba109,g_imba_m.imba101,g_imba_m.imba104,g_imba_m.imba105, 
          g_imba_m.imba106,g_imba_m.imba107,g_imba_m.imba124,g_imba_m.imba145,g_imba_m.imba146,g_imba_m.imba016, 
          g_imba_m.imba017,g_imba_m.imba018,g_imba_m.imba018_desc,g_imba_m.imba019,g_imba_m.imba020, 
          g_imba_m.imba021,g_imba_m.imba022,g_imba_m.imba022_desc,g_imba_m.imba023,g_imba_m.imba024, 
          g_imba_m.imba025,g_imba_m.imba026,g_imba_m.imba027,g_imba_m.imba028,g_imba_m.imba029,g_imba_m.imba029_desc, 
          g_imba_m.imba030,g_imba_m.imba031,g_imba_m.imba032,g_imba_m.imba032_desc,g_imba_m.imba033, 
          g_imba_m.imba034,g_imba_m.imba035,g_imba_m.imba036,g_imba_m.imba037,g_imba_m.imba043,g_imba_m.imba038, 
          g_imba_m.imba041,g_imba_m.imba042,g_imba_m.imba044,g_imba_m.imba122,g_imba_m.imba122_desc, 
          g_imba_m.imba045,g_imba_m.imba045_desc,g_imba_m.imba123
   END IF
 
   #add-point:stus修改後 name="statechange.a_update"
 
   #end add-point
 
   #add-point:statechange段結束前 name="statechange.after"
      
   #end add-point  
 
   CLOSE aimt300_cl
   CALL s_transaction_end('Y','0')
 
   #功能已完成,通報訊息中心
   CALL aimt300_msgcentre_notify('statechange:'||lc_state)
   
END FUNCTION
 
 
 
 
{</section>}
 
{<section id="aimt300.idx_chk" >}
#+ 顯示正確的單身資料筆數
PRIVATE FUNCTION aimt300_idx_chk()
   #add-point:idx_chk段define(客製用) name="idx_chk.define_customerization"
   
   #end add-point  
   #add-point:idx_chk段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="idx_chk.define"
      
   #end add-point  
   
   #add-point:Function前置處理  name="idx_chk.pre_function"
   
   #end add-point
   
   IF g_current_page = 1 THEN
      LET g_detail_idx = g_curr_diag.getCurrentRow("s_detail1")
      IF g_detail_idx > g_imbj_d.getLength() THEN
         LET g_detail_idx = g_imbj_d.getLength()
      END IF
      IF g_detail_idx = 0 AND g_imbj_d.getLength() <> 0 THEN
         LET g_detail_idx = 1
      END IF
      DISPLAY g_detail_idx TO FORMONLY.idx
      DISPLAY g_imbj_d.getLength() TO FORMONLY.cnt
   END IF
   
   IF g_current_page = 2 THEN
      LET g_detail_idx = g_curr_diag.getCurrentRow("s_detail2")
      IF g_detail_idx > g_imbj2_d.getLength() THEN
         LET g_detail_idx = g_imbj2_d.getLength()
      END IF
      IF g_detail_idx = 0 AND g_imbj2_d.getLength() <> 0 THEN
         LET g_detail_idx = 1
      END IF
      DISPLAY g_detail_idx TO FORMONLY.idx
      DISPLAY g_imbj2_d.getLength() TO FORMONLY.cnt
   END IF
   IF g_current_page = 3 THEN
      LET g_detail_idx = g_curr_diag.getCurrentRow("s_detail3")
      IF g_detail_idx > g_imbj3_d.getLength() THEN
         LET g_detail_idx = g_imbj3_d.getLength()
      END IF
      IF g_detail_idx = 0 AND g_imbj3_d.getLength() <> 0 THEN
         LET g_detail_idx = 1
      END IF
      DISPLAY g_detail_idx TO FORMONLY.idx
      DISPLAY g_imbj3_d.getLength() TO FORMONLY.cnt
   END IF
   IF g_current_page = 4 THEN
      LET g_detail_idx = g_curr_diag.getCurrentRow("s_detail4")
      IF g_detail_idx > g_imbj4_d.getLength() THEN
         LET g_detail_idx = g_imbj4_d.getLength()
      END IF
      IF g_detail_idx = 0 AND g_imbj4_d.getLength() <> 0 THEN
         LET g_detail_idx = 1
      END IF
      DISPLAY g_detail_idx TO FORMONLY.idx
      DISPLAY g_imbj4_d.getLength() TO FORMONLY.cnt
   END IF
 
   
   #add-point:idx_chk段other name="idx_chk.other"
      
   #end add-point  
   
END FUNCTION
 
{</section>}
 
{<section id="aimt300.b_fill2" >}
#+ 單身陣列填充2
PRIVATE FUNCTION aimt300_b_fill2(pi_idx)
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
   
   CALL aimt300_detail_show()
   
   LET g_detail_idx = li_detail_idx_tmp
   
END FUNCTION
 
{</section>}
 
{<section id="aimt300.fill_chk" >}
#+ 單身填充確認
PRIVATE FUNCTION aimt300_fill_chk(ps_idx)
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
      (cl_null(g_wc2_table4) OR g_wc2_table4.trim() = '1=1') THEN
      #add-point:fill_chk段other_chk name="fill_chk.other_chk"
            
      #end add-point
      RETURN TRUE
   END IF
   
   #add-point:fill_chk段after_chk name="fill_chk.after_chk"
   
   #end add-point
   
   RETURN TRUE
 
END FUNCTION
 
{</section>}
 
{<section id="aimt300.status_show" >}
PRIVATE FUNCTION aimt300_status_show()
   #add-point:status_show段define(客製用) name="status_show.define_customerization"
   
   #end add-point
   #add-point:status_show段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="status_show.define"
   
   #end add-point
   
   #add-point:status_show段status_show name="status_show.status_show"
   
   #end add-point
END FUNCTION
 
{</section>}
 
{<section id="aimt300.mask_functions" >}
&include "erp/aim/aimt300_mask.4gl"
 
{</section>}
 
{<section id="aimt300.signature" >}
   #應用 a39 樣板自動產生(Version:10)
#+ BPM提交
PRIVATE FUNCTION aimt300_send()
   #add-point:send段define(客製用) name="send.define_customerization"
   
   #end add-point 
   #add-point:send段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="send.define"
   DEFINE l_success LIKE type_t.num5
   #end add-point 
   
   #add-point:Function前置處理  name="send.pre_function"
   
   #end add-point
   
   #依據單據個數，需要指定所有單身條件為" 1=1"  (單身有幾個就要設幾個)
   LET g_wc2_table1 = " 1=1"
   LET g_wc2_table2 = " 1=1"
   LET g_wc2_table3 = " 1=1"
   LET g_wc2_table4 = " 1=1"
 
 
   CALL aimt300_show()
   CALL aimt300_set_pk_array()
   
   #add-point: 初始化的ADP name="send.before_send"
   CALL s_aimt300_conf_chk(g_imba_m.imbadocno,g_imba_m.imbastus) RETURNING l_success
   IF NOT l_success THEN
      RETURN
   END IF
   #end add-point
   
   #公用變數初始化
   CALL cl_bpm_data_init()
                  
   #依照主檔/單身個數產生 CALL cl_bpm_set_master_data() / cl_bpm_set_detail_data() 
   #單頭固定為 CALL cl_bpm_set_master_data(util.JSONObject.fromFGL(xxxx)) 傳入參數: (1)單頭陣列  ; 回傳值: 無
   CALL cl_bpm_set_master_data(util.JSONObject.fromFGL(g_imba_m))
                              
   #單身固定為 CALL cl_bpm_set_detail_data(s_detailX, util.JSONArray.fromFGL(xxxx)) 傳入參數: (1)單身SR名稱  (2)單身陣列  ; 回傳值: 無
   CALL cl_bpm_set_detail_data("s_detail1", util.JSONArray.fromFGL(g_imbj_d))
   CALL cl_bpm_set_detail_data("s_detail2", util.JSONArray.fromFGL(g_imbj2_d))
   CALL cl_bpm_set_detail_data("s_detail3", util.JSONArray.fromFGL(g_imbj3_d))
   CALL cl_bpm_set_detail_data("s_detail4", util.JSONArray.fromFGL(g_imbj4_d))
 
 
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
   #CALL aimt300_ui_browser_refresh()
 
   #重新指定此筆單據資料狀態圖片=>送簽中
   LET g_browser[g_current_idx].b_statepic = "stus/16/signing.png"
 
   #重新取得單頭/單身資料,DISPLAY在畫面上
   CALL aimt300_ui_headershow()
   CALL aimt300_ui_detailshow()
 
   RETURN TRUE
   
END FUNCTION
 
 
 
#應用 a40 樣板自動產生(Version:9)
#+ BPM抽單
PRIVATE FUNCTION aimt300_draw_out()
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
   CALL aimt300_ui_headershow()  
   CALL aimt300_ui_detailshow()
 
   #add-point:Function後置處理  name="draw.after_function"
   
   #end add-point
 
   RETURN TRUE
   
END FUNCTION
 
 
 
 
 
{</section>}
 
{<section id="aimt300.set_pk_array" >}
   #應用 a51 樣板自動產生(Version:8)
#+ 給予pk_array內容
PRIVATE FUNCTION aimt300_set_pk_array()
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
   LET g_pk_array[1].values = g_imba_m.imbadocno
   LET g_pk_array[1].column = 'imbadocno'
 
   
   #add-point:set_pk_array段之後 name="set_pk_array.after"
   
   #end add-point  
   
END FUNCTION
 
 
 
 
{</section>}
 
{<section id="aimt300.other_dialog" readonly="Y" >}
   
 
{</section>}
 
{<section id="aimt300.msgcentre_notify" >}
#應用 a66 樣板自動產生(Version:6)
PRIVATE FUNCTION aimt300_msgcentre_notify(lc_state)
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
   CALL aimt300_set_pk_array()
   #單頭資料填寫
   LET g_msgparam.data[1] = util.JSON.stringify(g_imba_m)
 
   #add-point:msgcentre其他通知 name="msgcentre_notify.process"
   
   #end add-point
 
   #呼叫訊息中心傳遞本關完成訊息
   CALL cl_msgcentre_notify()
 
END FUNCTION
 
 
 
 
{</section>}
 
{<section id="aimt300.action_chk" >}
#+ 修改/刪除前行為檢查(是否可允許此動作), 若有其他行為須管控也可透過此段落
PRIVATE FUNCTION aimt300_action_chk()
   #add-point:action_chk段define(客製用) name="action_chk.define_customerization"
   
   #end add-point
   #add-point:action_chk段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="action_chk.define"
   
   #end add-point
   
   #add-point:action_chk段action_chk name="action_chk.action_chk"
   #160818-00017#15  2016/08/24   By 07900  --add--s--
   SELECT imbastus INTO g_imba_m.imbastus
     FROM imba_t
    WHERE imbaent = g_enterprise
      AND imbadocno = g_imba_m.imbadocno

   IF (g_action_choice="modify" OR g_action_choice="delete" OR g_action_choice="modify_detail")  THEN
     LET g_errno = NULL
     CASE g_imba_m.imbastus
       
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
        LET g_errparam.extend = g_imba_m.imbadocno
        LET g_errparam.popup = TRUE
        CALL cl_err()
        LET g_errno = NULL
        CALL aimt300_set_act_visible()
        CALL aimt300_set_act_no_visible()
        CALL aimt300_show()
        RETURN FALSE
     END IF
   END IF
   #160818-00017#15  2016/08/24   By 07900  --add--e--
   #end add-point
      
   RETURN TRUE
   
END FUNCTION
 
{</section>}
 
{<section id="aimt300.other_function" readonly="Y" >}
#創建臨時表
PRIVATE FUNCTION aimt300_crt_tmp()
   #150310---earl---add---s
   DEFINE l_sql          STRING
   
   #建立temp table
   DROP TABLE aimt300_imba_tmp
   
   LET l_sql = "CREATE GLOBAL TEMPORARY TABLE aimt300_imba_tmp AS ",
               "SELECT * FROM imba_t "
   PREPARE aimt300_aooi390_pre01 FROM l_sql
   EXECUTE aimt300_aooi390_pre01
   FREE aimt300_aooi390_pre01
   #150310---earl---add---e
   
   CREATE TEMP TABLE imbj_tmp
   (
       imbjent       INT,
       imbj000       VARCHAR(10),
       imbj001       VARCHAR(40),
       imbj002       VARCHAR(10),
       imbj003       VARCHAR(10),
       imbj004       INT,
       imbj005       VARCHAR(10),
       imbj006       VARCHAR(10),
       imbjdocno     VARCHAR(20)
   );
   
   CREATE TEMP TABLE imbl_tmp
   (
       imblent       INT,
       imbldocno     VARCHAR(20),
       imbl000       VARCHAR(10),
       imbl001       VARCHAR(40),
       imbl002       VARCHAR(10)
   );
   
    CREATE TEMP TABLE imbm_tmp
   (
       imbment       INT,
       imbm000       VARCHAR(10),
       imbm001       VARCHAR(40),
       imbm002       VARCHAR(10),
       imbm003       VARCHAR(40),
       imbm004       VARCHAR(255),
       imbm005       VARCHAR(255),
       imbm006       DATE,
       imbmdocno     VARCHAR(20)
   );
   CREATE TEMP TABLE imbk_tmp
   (
       imbkent       INT,
       imbk001       VARCHAR(40),
       imbk002       VARCHAR(10),
       imbk003       VARCHAR(30),
       imbkdocno     VARCHAR(20)
   );
   CREATE TEMP TABLE imbo_tmp
   (
       imboent       INT,
       imbo000       VARCHAR(10),
       imbo001       VARCHAR(40),
       imbo002       VARCHAR(10),
       imbodocno     VARCHAR(20)
   );
END FUNCTION
#單頭參考欄位顯示
PRIVATE FUNCTION aimt300_desc()
DEFINE l_ooag002       LIKE ooag_t.ooag002
DEFINE l_flag          LIKE type_t.num5          #标识符，TRUE/FALSE
DEFINE l_flag1         LIKE type_t.num5          #标识符，TRUE/FALSE
DEFINE l_site          LIKE type_t.chr20   

   LET l_flag = TRUE 
   LET l_flag1 = TRUE 
   
   #品名規格欄位的帶值不能放到此處，防止錄入狀態下，修改了品名規格，而過其他欄位時，又調用此函數，導致又從數據庫重新撈值
   #mark by lixiang 2015/12/03--begin----
   #SELECT imbal002,imbal003,imbal004 INTO g_imba_m.imbal002,g_imba_m.imbal003,g_imba_m.imbal004
   #  FROM imbal_t
   # WHERE imbalent = g_enterprise
   #   AND imbaldocno = g_imba_m.imbadocno
   #   AND imbal001 = g_lang
   #DISPLAY BY NAME g_imba_m.imbal002
   #DISPLAY BY NAME g_imba_m.imbal003
   #DISPLAY BY NAME g_imba_m.imbal004
   #mark by lixiang 2015/12/03--end----
   
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_imba_m.imba009
   CALL ap_ref_array2(g_ref_fields,"SELECT rtaxl003 FROM rtaxl_t WHERE rtaxlent='"||g_enterprise||"' AND rtaxl001=? AND rtaxl002='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_imba_m.imba009_desc = g_rtn_fields[1]
   DISPLAY BY NAME g_imba_m.imba009_desc

   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_imba_m.imba003
   CALL ap_ref_array2(g_ref_fields,"SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001 = '200' AND oocql002=? AND oocql003='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_imba_m.imba003_desc = g_rtn_fields[1]
   DISPLAY BY NAME g_imba_m.imba003_desc
   
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_imba_m.imba005
   CALL ap_ref_array2(g_ref_fields,"SELECT imeal003 FROM imeal_t WHERE imealent='"||g_enterprise||"' AND imeal001=? AND imeal002='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_imba_m.imba005_desc = g_rtn_fields[1]
   DISPLAY BY NAME g_imba_m.imba005_desc

   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_imba_m.imba006
   CALL ap_ref_array2(g_ref_fields,"SELECT oocal003 FROM oocal_t WHERE oocalent='"||g_enterprise||"' AND oocal001=? AND oocal002='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_imba_m.imba006_desc = g_rtn_fields[1]
   DISPLAY BY NAME g_imba_m.imba006_desc
   #161004-00020#1--add--start--
   LET g_imba_m.imba146 =  g_imba_m.imba006
   DISPLAY BY NAME g_imba_m.imba146
   #161004-00020#1--add--end----
   
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_imba_m.imba010
   CALL ap_ref_array2(g_ref_fields,"SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001 = '210' AND oocql002=? AND oocql003='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_imba_m.imba010_desc = g_rtn_fields[1]
   DISPLAY BY NAME g_imba_m.imba010_desc
   
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_imba_m.imba018
   CALL ap_ref_array2(g_ref_fields,"SELECT oocal003 FROM oocal_t WHERE oocalent='"||g_enterprise||"' AND oocal001=? AND oocal002='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_imba_m.imba018_desc =  g_rtn_fields[1] 
   DISPLAY BY NAME g_imba_m.imba018_desc
   
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_imba_m.imba022
   CALL ap_ref_array2(g_ref_fields,"SELECT oocal003 FROM oocal_t WHERE oocalent='"||g_enterprise||"' AND oocal001=? AND oocal002='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_imba_m.imba022_desc =  g_rtn_fields[1]
   DISPLAY BY NAME g_imba_m.imba022_desc
   
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_imba_m.imba029
   CALL ap_ref_array2(g_ref_fields,"SELECT oocal003 FROM oocal_t WHERE oocalent='"||g_enterprise||"' AND oocal001=? AND oocal002='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_imba_m.imba029_desc =  g_rtn_fields[1]
   DISPLAY BY NAME g_imba_m.imba029_desc
   
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_imba_m.imba032
   CALL ap_ref_array2(g_ref_fields,"SELECT oocal003 FROM oocal_t WHERE oocalent='"||g_enterprise||"' AND oocal001=? AND oocal002='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_imba_m.imba032_desc =  g_rtn_fields[1]
   DISPLAY BY NAME g_imba_m.imba032_desc
   
   
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_imba_m.imba142
   CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_imba_m.imba142_desc =  g_rtn_fields[1]
   DISPLAY BY NAME g_imba_m.imba142_desc
   
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_imba_m.imba045
   CALL ap_ref_array2(g_ref_fields,"SELECT oocgl003 FROM oocgl_t WHERE oocglent='"||g_enterprise||"' AND oocgl001=? AND oocgl002='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_imba_m.imba045_desc = g_rtn_fields[1]
   DISPLAY BY NAME g_imba_m.imba045_desc
   
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_imba_m.imba900
   CALL ap_ref_array2(g_ref_fields,"SELECT ooag011 FROM ooag_t WHERE ooagent='"||g_enterprise||"' AND ooag001=? ","") RETURNING g_rtn_fields
   LET g_imba_m.imba900_desc = g_rtn_fields[1]
   DISPLAY BY NAME g_imba_m.imba900_desc
   
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_imba_m.imba901
   CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_imba_m.imba901_desc = g_rtn_fields[1] 
   DISPLAY BY NAME g_imba_m.imba901_desc
   
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_imba_m.imba122
   CALL ap_ref_array2(g_ref_fields,"SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001 = '2000' AND oocql002=? AND oocql003='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_imba_m.imba122_desc = g_rtn_fields[1]
   DISPLAY BY NAME g_imba_m.imba122_desc
   
   #141231-00009#1--add--begin----
   #统计分类页签的栏位说明
   CALL s_desc_get_acc_desc('2002',g_imba_m.imba126) RETURNING g_imba_m.imba126_desc
   DISPLAY BY NAME g_imba_m.imba126_desc
   
   CALL s_desc_get_acc_desc('2003',g_imba_m.imba127) RETURNING g_imba_m.imba127_desc
   DISPLAY BY NAME g_imba_m.imba127_desc
   
   CALL s_desc_get_acc_desc('2001',g_imba_m.imba131) RETURNING g_imba_m.imba131_desc
   DISPLAY BY NAME g_imba_m.imba131_desc
   
   CALL s_desc_get_acc_desc('2004',g_imba_m.imba128) RETURNING g_imba_m.imba128_desc
   DISPLAY BY NAME g_imba_m.imba128_desc
   
   CALL s_desc_get_acc_desc('2005',g_imba_m.imba129) RETURNING g_imba_m.imba129_desc
   DISPLAY BY NAME g_imba_m.imba129_desc
   
   CALL s_desc_get_acc_desc('2006',g_imba_m.imba132) RETURNING g_imba_m.imba132_desc
   DISPLAY BY NAME g_imba_m.imba132_desc
   
   CALL s_desc_get_acc_desc('2007',g_imba_m.imba133) RETURNING g_imba_m.imba133_desc
   DISPLAY BY NAME g_imba_m.imba133_desc
   
   CALL s_desc_get_acc_desc('2008',g_imba_m.imba134) RETURNING g_imba_m.imba134_desc
   DISPLAY BY NAME g_imba_m.imba134_desc
   
   CALL s_desc_get_acc_desc('2009',g_imba_m.imba135) RETURNING g_imba_m.imba135_desc
   DISPLAY BY NAME g_imba_m.imba135_desc
   
   CALL s_desc_get_acc_desc('2010',g_imba_m.imba136) RETURNING g_imba_m.imba136_desc
   DISPLAY BY NAME g_imba_m.imba136_desc
   
   CALL s_desc_get_acc_desc('2011',g_imba_m.imba137) RETURNING g_imba_m.imba137_desc
   DISPLAY BY NAME g_imba_m.imba137_desc
   
   CALL s_desc_get_acc_desc('2012',g_imba_m.imba138) RETURNING g_imba_m.imba138_desc
   DISPLAY BY NAME g_imba_m.imba138_desc
   
   CALL s_desc_get_acc_desc('2013',g_imba_m.imba139) RETURNING g_imba_m.imba139_desc
   DISPLAY BY NAME g_imba_m.imba139_desc
   
   CALL s_desc_get_acc_desc('2014',g_imba_m.imba140) RETURNING g_imba_m.imba140_desc
   DISPLAY BY NAME g_imba_m.imba140_desc
   
   CALL s_desc_get_acc_desc('2015',g_imba_m.imba141) RETURNING g_imba_m.imba141_desc
   DISPLAY BY NAME g_imba_m.imba141_desc
   #141231-00009#1--add--end----
   
END FUNCTION
#料件編號帶單身
PRIVATE FUNCTION aimt300_imaa_b_fill()
   DEFINE l_sql      STRING


   DELETE FROM imbj_tmp WHERE imbjent = g_enterprise AND imbjdocno = g_imba_m.imbadocno
   DELETE FROM imbl_tmp WHERE imblent = g_enterprise AND imbldocno = g_imba_m.imbadocno
   DELETE FROM imbm_tmp WHERE imbment = g_enterprise AND imbmdocno = g_imba_m.imbadocno
   DELETE FROM imbk_tmp WHERE imbkent = g_enterprise AND imbkdocno = g_imba_m.imbadocno  #141231-00009#1--cancel---mark----
   DELETE FROM imbo_tmp WHERE imboent = g_enterprise AND imbodocno = g_imba_m.imbadocno
   	

   
   IF g_imba_m.imba000 = 'U' THEN
      LET l_sql = "INSERT INTO imbj_tmp(imbjent,imbjdocno,imbj001,imbj002,imbj003,imbj004,imbj005,imbj006) ",
               "SELECT '",g_enterprise,"','",g_imba_m.imbadocno,"',imaj001,imaj002,imaj003,imaj004,imaj005,imaj006 ",
               "  FROM imaj_t ",
               " WHERE imajent = '",g_enterprise,"' ",
               "   AND imaj001 = '",g_imba_m.imba001,"' "
      PREPARE imaa_ins_imbj_pre FROM l_sql
      EXECUTE imaa_ins_imbj_pre 
      
      LET l_sql = "INSERT INTO imbl_tmp(imblent,imbldocno,imbl001,imbl002) ",
               "SELECT '",g_enterprise,"','",g_imba_m.imbadocno,"',imal001,imal002 ",
               "  FROM imal_t ",
               " WHERE imalent = '",g_enterprise,"' ",
               "   AND imal001 = '",g_imba_m.imba001,"' "
      PREPARE imaa_ins_imbl_pre FROM l_sql
      EXECUTE imaa_ins_imbl_pre 
      
      LET l_sql = "INSERT INTO imbm_tmp(imbment,imbmdocno,imbm001,imbm002,imbm003,imbm004,imbm005,imbm006) ",
               "SELECT '",g_enterprise,"','",g_imba_m.imbadocno,"',imam001,imam002,imam003,imam004,imam005,imam006 ",
               "  FROM imam_t ",
               " WHERE imament = '",g_enterprise,"' ",
               "   AND imam001 = '",g_imba_m.imba001,"' "
      PREPARE imaa_ins_imbm_pre FROM l_sql
      EXECUTE imaa_ins_imbm_pre 
      
      LET l_sql = "INSERT INTO imbo_tmp(imboent,imbodocno,imbo000,imbo001,imbo002) ",
                  "SELECT '",g_enterprise,"','",g_imba_m.imbadocno,"','",g_imba_m.imba000,"',imao001,imao002 ",
                  "  FROM imao_t ",
                  " WHERE imaoent = '",g_enterprise,"' ",
                  "   AND imao001 = '",g_imba_m.imba001,"' "
      PREPARE imaa_ins_imbo_pre FROM l_sql
      EXECUTE imaa_ins_imbo_pre 
      
      #141231-00009#1--cancel---mark----begin----
      LET l_sql = "INSERT INTO imbk_tmp(imbkent,imbkdocno,imbk001,imbk002,imbk003) ",
               "SELECT '",g_enterprise,"','",g_imba_m.imbadocno,"',imak001,imak002,imak003 ",
               "  FROM imak_t ",
               " WHERE imakent = '",g_enterprise,"' ",
               "   AND imak001 = '",g_imba_m.imba001,"' "
      PREPARE imaa_ins_imbk_pre FROM l_sql
      EXECUTE imaa_ins_imbk_pre 
      #141231-00009#1--cancel---mark----end----
   END IF
   CALL aimt300_tmp_b_fill()
END FUNCTION
#成份與物質單身參考欄位顯示
PRIVATE FUNCTION aimt300_imbj_desc()
   
   INITIALIZE g_ref_fields TO NULL 
   LET g_ref_fields[1] = g_imbj_d[l_ac].imbj002
   CALL ap_ref_array2(g_ref_fields," SELECT oocql004 FROM oocql_t WHERE oocqlent = '"||g_enterprise||"' AND oocql001 = '270' AND oocql002 = ? AND oocql003 = '"||g_dlang||"'","") RETURNING g_rtn_fields 
   LET g_imbj_d[l_ac].imbj002_desc = g_rtn_fields[1] 
   DISPLAY BY NAME g_imbj_d[l_ac].imbj002_desc
   
   INITIALIZE g_ref_fields TO NULL 
   LET g_ref_fields[1] = g_imbj_d[l_ac].imbj003
   CALL ap_ref_array2(g_ref_fields," SELECT oocql004 FROM oocql_t WHERE oocqlent = '"||g_enterprise||"' AND oocql001 = '271' AND oocql002 = ? AND oocql003 = '"||g_dlang||"'","") RETURNING g_rtn_fields 
   LET g_imbj_d[l_ac].imbj003_desc = g_rtn_fields[1] 
   DISPLAY BY NAME g_imbj_d[l_ac].imbj003_desc
   
   
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_imbj_d[l_ac].imbj005
   CALL ap_ref_array2(g_ref_fields,"SELECT oocal003 FROM oocal_t WHERE oocalent='"||g_enterprise||"' AND oocal001=? AND oocal002='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_imbj_d[l_ac].imbj005_desc = g_rtn_fields[1]
   DISPLAY BY NAME g_imbj_d[l_ac].imbj005_desc
   
   INITIALIZE g_ref_fields TO NULL 
   LET g_ref_fields[1] = g_imbj_d[l_ac].imbj006
   CALL ap_ref_array2(g_ref_fields," SELECT oocql004 FROM oocql_t WHERE oocqlent = '"||g_enterprise||"' AND oocql001 = '272' AND oocql002 = ? AND oocql003 = '"||g_dlang||"'","") RETURNING g_rtn_fields 
   LET g_imbj_d[l_ac].imbj006_desc = g_rtn_fields[1] 
   DISPLAY BY NAME g_imbj_d[l_ac].imbj006_desc
END FUNCTION
#料件編號帶值
PRIVATE FUNCTION aimt300_imaa_desc()
   IF NOT cl_null(g_imba_m.imba001) AND g_imba_m.imba000 = 'U' THEN
      SELECT imaa004,imaa005,imaa006,imaa009,imaa010,imaa011,imaa012,imaa013,imaa014,imaa016,imaa017,
             imaa018,imaa022,imaa024,imaa026,imaa027,imaa029,imaa030,imaa032,imaa033,
             imaa036,imaa037,imaa038,imaa041,imaa042,imaa044,imaa045,
             imaa122,imaa123,imaa126,imaa127,imaa128,imaa129,imaa130,
             imaa131,imaa132,imaa133,imaa134,imaa135,imaa136,imaa137,imaa138,
             imaa139,imaa140,imaa141,imaa019,imaa020,imaa021,imaa023,imaa025,
             imaa028,imaa031,imaa034,imaa035,
             imaa100,imaa108,imaa109   #add--160511-00040#4 By shiun
        INTO g_imba_m.imba004,g_imba_m.imba005,g_imba_m.imba006,g_imba_m.imba009,g_imba_m.imba010,
             g_imba_m.imba011,g_imba_m.imba012,g_imba_m.imba013,g_imba_m.imba014,g_imba_m.imba016,g_imba_m.imba017,
             g_imba_m.imba018,g_imba_m.imba022,g_imba_m.imba024,g_imba_m.imba026,
             g_imba_m.imba027,g_imba_m.imba029,g_imba_m.imba030,g_imba_m.imba032,g_imba_m.imba033,
             g_imba_m.imba036,g_imba_m.imba037,g_imba_m.imba038,g_imba_m.imba041,
             g_imba_m.imba042,g_imba_m.imba044,g_imba_m.imba045,
             g_imba_m.imba122,g_imba_m.imba123,g_imba_m.imba126,
             g_imba_m.imba127,g_imba_m.imba128,g_imba_m.imba129,g_imba_m.imba130,
             g_imba_m.imba131,g_imba_m.imba132,g_imba_m.imba133,g_imba_m.imba134,
             g_imba_m.imba135,g_imba_m.imba136,g_imba_m.imba137,g_imba_m.imba138,
             g_imba_m.imba139,g_imba_m.imba140,g_imba_m.imba141,g_imba_m.imba019,
             g_imba_m.imba020,g_imba_m.imba021,g_imba_m.imba023,g_imba_m.imba025,
             g_imba_m.imba028,g_imba_m.imba031,g_imba_m.imba034,g_imba_m.imba035,
             g_imba_m.imba100,g_imba_m.imba108,g_imba_m.imba109   #add--160511-00040#4 By shiun
        FROM imaa_t
       WHERE imaa001 = g_imba_m.imba001
         AND imaaent = g_enterprise
      LET g_imba003_o = g_imba_m.imba003
      LET g_imba009_o = g_imba_m.imba009
      IF cl_null(g_imba_m.imba004) THEN LET g_imba_m.imba004 = "M" END IF
      IF cl_null(g_imba_m.imba011) THEN LET g_imba_m.imba011 = "0" END IF
      IF cl_null(g_imba_m.imba012) THEN LET g_imba_m.imba012 = "Y" END IF
      IF cl_null(g_imba_m.imba027) THEN LET g_imba_m.imba027 = "N" END IF
      IF cl_null(g_imba_m.imba034) THEN LET g_imba_m.imba034 = "1" END IF
      IF cl_null(g_imba_m.imba036) THEN LET g_imba_m.imba036 = "N" END IF
      IF cl_null(g_imba_m.imba037) THEN LET g_imba_m.imba037 = "N" END IF
      IF cl_null(g_imba_m.imba038) THEN LET g_imba_m.imba038 = "N" END IF
      IF cl_null(g_imba_m.imba044) THEN LET g_imba_m.imba044 = "3" END IF
      DISPLAY BY NAME g_imba_m.imba004,g_imba_m.imba005,g_imba_m.imba006,g_imba_m.imba009,g_imba_m.imba010,
                      g_imba_m.imba011,g_imba_m.imba012,g_imba_m.imba013,g_imba_m.imba014,g_imba_m.imba016,g_imba_m.imba017,
                      g_imba_m.imba018,g_imba_m.imba022,g_imba_m.imba024,g_imba_m.imba026,
                      g_imba_m.imba027,g_imba_m.imba029,g_imba_m.imba030,g_imba_m.imba032,g_imba_m.imba033,
                      g_imba_m.imba036,g_imba_m.imba037,g_imba_m.imba038,g_imba_m.imba041,
                      g_imba_m.imba042,g_imba_m.imba044,g_imba_m.imba045,
                      g_imba_m.imba122,g_imba_m.imba123,g_imba_m.imba126,
                      g_imba_m.imba127,g_imba_m.imba128,g_imba_m.imba129,g_imba_m.imba130,
                      g_imba_m.imba131,g_imba_m.imba132,g_imba_m.imba133,g_imba_m.imba134,
                      g_imba_m.imba135,g_imba_m.imba136,g_imba_m.imba137,g_imba_m.imba138,
                      g_imba_m.imba139,g_imba_m.imba140,g_imba_m.imba141,g_imba_m.imba019,
                      g_imba_m.imba020,g_imba_m.imba021,g_imba_m.imba023,g_imba_m.imba025,
                      g_imba_m.imba028,g_imba_m.imba031,g_imba_m.imba034,g_imba_m.imba035
      CALL aimt300_desc()
   END IF
END FUNCTION
#料件编号检查 带值
PRIVATE FUNCTION aimt300_chk_imba001()
DEFINE l_n         LIKE type_t.num5

   LET g_errno = ''
   
   IF NOT cl_null(g_imba_m.imba001) THEN
      IF g_imba_m.imba000 = 'I' THEN
         LET l_n = 0
         SELECT COUNT(*) INTO l_n
           FROM imaa_t
          WHERE imaa001 = g_imba_m.imba001
            AND imaaent = g_enterprise
         IF l_n > 0 THEN
            LET g_errno = 'aim-00105'
         ELSE
             LET l_n = 0
             SELECT COUNT(*) INTO l_n
               FROM imba_t
              WHERE imbaent = g_enterprise
                AND imba001 = g_imba_m.imba001
                AND imbastus <> 'X'
             IF l_n > 0 THEN
                LET g_errno = 'aim-00106'
             END IF
         END IF
      END IF
      IF g_imba_m.imba000 = 'U' THEN
         LET l_n = 0
         SELECT COUNT(*) INTO l_n
           FROM imaa_t
          WHERE imaa001 = g_imba_m.imba001
            AND imaaent = g_enterprise
         IF l_n = 0 THEN
            LET g_errno = 'aim-00001'
         ELSE
            LET l_n = 0
            SELECT COUNT(*) INTO l_n
              FROM imaa_t
             WHERE imaa001 = g_imba_m.imba001
               AND imaaent = g_enterprise
               AND imaastus = 'X'
            IF l_n > 0 THEN
               LET g_errno = 'sub-01302'  #160318-00005#21 mod #'aim-00002'
            END IF
            LET l_n = 0
            SELECT COUNT(*) INTO l_n
              FROM imaa_t
             WHERE imaa001 = g_imba_m.imba001
               AND imaaent = g_enterprise
               AND imaastus = 'N'
            IF l_n > 0 THEN
               LET g_errno = 'sub-01302'  #160318-00005#21 mod#'aim-00121'
            END IF
         END IF
         LET l_n = 0
         SELECT COUNT(*) INTO l_n
           FROM imba_t
          WHERE imbaent = g_enterprise
            AND imba001 = g_imba_m.imba001
            AND imbastus = 'N'
         IF l_n > 0 THEN
            LET g_errno = 'aim-00107'
         END IF
         IF cl_null(g_errno) THEN
            SELECT imaa002,imaa003,imaa004,imaa005,imaa006,imaa009,imaa010
              INTO g_imba_m.imba002,g_imba_m.imba003,g_imba_m.imba004,g_imba_m.imba005,g_imba_m.imba006,g_imba_m.imba009,g_imba_m.imba010
              FROM imaa_t
             WHERE imaa001 = g_imba_m.imba001
               AND imaaent = g_enterprise
            DISPLAY BY NAME g_imba_m.imba002,g_imba_m.imba003,g_imba_m.imba004,g_imba_m.imba005,g_imba_m.imba006,g_imba_m.imba009,g_imba_m.imba010
            SELECT imaal003,imaal004,imaal005
              INTO g_imba_m.imbal002,g_imba_m.imbal003,g_imba_m.imbal004
              FROM imaal_t
             WHERE imaal001 = g_imba_m.imba001
               AND imaalent = g_enterprise
               AND imaal002 = g_dlang
            DISPLAY BY NAME g_imba_m.imbal002,g_imba_m.imbal003,g_imba_m.imbal004
         END IF
      END IF
   END IF
END FUNCTION
#查詢方案欄位顯示
PRIVATE FUNCTION aimt300_browser_desc()
   
   SELECT imbal002,imbal003 INTO g_browser[g_cnt].b_imbal002,g_browser[g_cnt].b_imbal003
     FROM imbal_t
    WHERE imbalent = g_enterprise
      AND imbaldocno = g_browser[g_cnt].b_imbadocno
      AND imbal001 = g_lang
   DISPLAY BY NAME g_browser[g_cnt].b_imbal002
   DISPLAY BY NAME g_browser[g_cnt].b_imbal003
   
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_browser[g_cnt].b_imba009
   CALL ap_ref_array2(g_ref_fields,"SELECT rtaxl003 FROM rtaxl_t WHERE rtaxlent='"||g_enterprise||"' AND rtaxl001=? AND rtaxl002='"||g_lang||"'","") RETURNING g_rtn_fields
   LET g_browser[g_cnt].b_imba009_desc = g_rtn_fields[1] 
   DISPLAY BY NAME g_browser[g_cnt].b_imba009_desc

   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_browser[g_cnt].b_imba003
   CALL ap_ref_array2(g_ref_fields,"SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001 = '200' AND oocql002=? AND oocql003='"||g_lang||"'","") RETURNING g_rtn_fields
   LET g_browser[g_cnt].b_imba003_desc = g_rtn_fields[1] 
   DISPLAY BY NAME g_browser[g_cnt].b_imba003_desc

   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_browser[g_cnt].b_imba006
   CALL ap_ref_array2(g_ref_fields,"SELECT oocal003 FROM oocal_t WHERE oocalent='"||g_enterprise||"' AND oocal001=? AND oocal002='"||g_lang||"'","") RETURNING g_rtn_fields
   LET g_browser[g_cnt].b_imba006_desc = g_rtn_fields[1] 
   DISPLAY BY NAME g_browser[g_cnt].b_imba006_desc

   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_browser[g_cnt].b_imba010
   CALL ap_ref_array2(g_ref_fields,"SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001 = '210' AND oocql002=? AND oocql003='"||g_lang||"'","") RETURNING g_rtn_fields
   LET g_browser[g_cnt].b_imba010_desc = g_rtn_fields[1] 
   DISPLAY BY NAME g_browser[g_cnt].b_imba010_desc
END FUNCTION
#是否重帶分群資料
PRIVATE FUNCTION aimt300_ask(p_cmd,p_imba000,p_imba003,p_imba003_t,p_imba003_o)
DEFINE p_cmd            LIKE type_t.chr1
DEFINE p_imba000        LIKE imba_t.imba000
DEFINE p_imba003        LIKE imba_t.imba003
DEFINE p_imba003_t      LIKE imba_t.imba003
DEFINE p_imba003_o      LIKE imba_t.imba003

   IF p_cmd = 'a' THEN
      IF p_imba000 = 'I' THEN
         LET g_con = 'Y'
      END IF
      IF p_imba000 = 'U' AND p_imba003 <> p_imba003_o THEN
         IF NOT cl_ask_confirm('aim-00120') THEN
            LET g_con = 'N'
         ELSE
            LET g_con = 'Y'
         END IF
      END IF
   END IF
   IF p_cmd = 'u' AND p_imba003 <> p_imba003_t THEN   
      IF NOT cl_ask_confirm('aim-00120') THEN
         LET g_con = 'N'
      ELSE
         LET g_con = 'Y'
      END IF
   END IF
   
   IF g_con = 'Y' THEN
      CALL aimt300_imca_desc()
      CALL aimt300_imca_b_fill()
   END IF
END FUNCTION
#產品標籤單身參考欄位顯示
PRIVATE FUNCTION aimt300_imbl_desc()
   INITIALIZE g_ref_fields TO NULL 
   LET g_ref_fields[1] = g_imbj2_d[l_ac].imbl002
   CALL ap_ref_array2(g_ref_fields," SELECT oocql004 FROM oocql_t WHERE oocqlent = '"||g_enterprise||"' AND oocql001 = '213' AND oocql002 = ? AND oocql003 = '"||g_dlang||"'","") RETURNING g_rtn_fields 
   LET g_imbj2_d[l_ac].oocql004 = g_rtn_fields[1] 
   DISPLAY BY NAME g_imbj2_d[l_ac].oocql004
   
   INITIALIZE g_ref_fields TO NULL 
   LET g_ref_fields[1] = g_imbj2_d[l_ac].imbl002
   CALL ap_ref_array2(g_ref_fields," SELECT oocq005 FROM oocq_t WHERE oocqent = '"||g_enterprise||"' AND oocq001 = '213' AND oocq002 = ? ","") RETURNING g_rtn_fields 
   LET g_imbj2_d[l_ac].oocq005 = g_rtn_fields[1]
   DISPLAY BY NAME g_imbj2_d[l_ac].oocq005
END FUNCTION
#主分群碼帶值
PRIVATE FUNCTION aimt300_imca_desc()
DEFINE l_n     LIKE type_t.num5
   
   
   IF NOT cl_null(g_imba_m.imba003) THEN
      LET l_n = 0
      SELECT COUNT(*) INTO l_n
        FROM inag_t
       WHERE inagent = g_enterprise
         AND inagsite = g_site
         AND inag001 = g_imba_m.imba001
      IF l_n = 0 THEN
         SELECT imca005 INTO g_imba_m.imba005
           FROM imca_t
          WHERE imca001 = g_imba_m.imba003
            AND imcaent = g_enterprise
      END IF
      SELECT imca004,imca006,imca010,imca011,imca012,imca013,imca014,
             imca018,imca022,imca024,imca026,imca027,imca029,imca030,imca032,imca033,
             imca036,imca037,imca038,imca041,imca042,imca044,imca045,
             imca122,imca123,imca126,imca127,imca128,imca129,imca130,
             imca131,imca132,imca133,imca134,imca135,imca136,imca137,imca138,
             imca139,imca140,imca141
        INTO g_imba_m.imba004,g_imba_m.imba006,g_imba_m.imba010,
             g_imba_m.imba011,g_imba_m.imba012,g_imba_m.imba013,g_imba_m.imba014,
             g_imba_m.imba018,g_imba_m.imba022,g_imba_m.imba024,g_imba_m.imba026,
             g_imba_m.imba027,g_imba_m.imba029,g_imba_m.imba030,g_imba_m.imba032,g_imba_m.imba033,
             g_imba_m.imba036,g_imba_m.imba037,g_imba_m.imba038,g_imba_m.imba041,
             g_imba_m.imba042,g_imba_m.imba044,g_imba_m.imba045,
             g_imba_m.imba122,g_imba_m.imba123,g_imba_m.imba126,
             g_imba_m.imba127,g_imba_m.imba128,g_imba_m.imba129,g_imba_m.imba130,
             g_imba_m.imba131,g_imba_m.imba132,g_imba_m.imba133,g_imba_m.imba134,
             g_imba_m.imba135,g_imba_m.imba136,g_imba_m.imba137,g_imba_m.imba138,
             g_imba_m.imba139,g_imba_m.imba140,g_imba_m.imba141
        FROM imca_t
       WHERE imca001 = g_imba_m.imba003
         AND imcaent = g_enterprise
      IF cl_null(g_imba_m.imba004) THEN LET g_imba_m.imba004 = "M" END IF
      IF cl_null(g_imba_m.imba011) THEN LET g_imba_m.imba011 = "0" END IF
      IF cl_null(g_imba_m.imba012) THEN LET g_imba_m.imba012 = "Y" END IF
      IF cl_null(g_imba_m.imba027) THEN LET g_imba_m.imba027 = "N" END IF
      IF cl_null(g_imba_m.imba034) THEN LET g_imba_m.imba034 = "1" END IF
      IF cl_null(g_imba_m.imba036) THEN LET g_imba_m.imba036 = "N" END IF
      IF cl_null(g_imba_m.imba037) THEN LET g_imba_m.imba037 = "N" END IF
      IF cl_null(g_imba_m.imba038) THEN LET g_imba_m.imba038 = "N" END IF
      IF cl_null(g_imba_m.imba044) THEN LET g_imba_m.imba044 = "3" END IF
      DISPLAY BY NAME g_imba_m.imba004,g_imba_m.imba005,g_imba_m.imba006,g_imba_m.imba010,
                      g_imba_m.imba011,g_imba_m.imba012,g_imba_m.imba013,g_imba_m.imba014,
                      g_imba_m.imba018,g_imba_m.imba022,g_imba_m.imba024,g_imba_m.imba026,
                      g_imba_m.imba027,g_imba_m.imba029,g_imba_m.imba030,g_imba_m.imba032,g_imba_m.imba033,
                      g_imba_m.imba036,g_imba_m.imba037,g_imba_m.imba038,g_imba_m.imba041,
                      g_imba_m.imba042,g_imba_m.imba044,g_imba_m.imba045,
                      g_imba_m.imba122,g_imba_m.imba123,g_imba_m.imba126,
                      g_imba_m.imba127,g_imba_m.imba128,g_imba_m.imba129,g_imba_m.imba130,
                      g_imba_m.imba131,g_imba_m.imba132,g_imba_m.imba133,g_imba_m.imba134,
                      g_imba_m.imba135,g_imba_m.imba136,g_imba_m.imba137,g_imba_m.imba138,
                      g_imba_m.imba139,g_imba_m.imba140,g_imba_m.imba141
      CALL aimt300_desc()
   END IF
END FUNCTION
#主分群碼帶單身
PRIVATE FUNCTION aimt300_imca_b_fill()
DEFINE l_sql      STRING

   DELETE FROM imbj_tmp WHERE imbjent = g_enterprise AND imbjdocno = g_imba_m.imbadocno
   DELETE FROM imbl_tmp WHERE imblent = g_enterprise AND imbldocno = g_imba_m.imbadocno
   DELETE FROM imbm_tmp WHERE imbment = g_enterprise AND imbmdocno = g_imba_m.imbadocno
   DELETE FROM imbk_tmp WHERE imbkent = g_enterprise AND imbkdocno = g_imba_m.imbadocno  #141231-00009#1--cancel---mark---
   DELETE FROM imbo_tmp WHERE imboent = g_enterprise AND imbodocno = g_imba_m.imbadocno
   
   LET l_sql = "INSERT INTO imbj_tmp(imbjent,imbjdocno,imbj001,imbj002,imbj003,imbj004,imbj005,imbj006) ",
               "SELECT '",g_enterprise,"','",g_imba_m.imbadocno,"','",g_imba_m.imba001,"',imcj002,imcj003,imcj004,imcj005,imcj006 ",
               "  FROM imcj_t ",
               " WHERE imcjent = '",g_enterprise,"' ",
               "   AND imcj001 = '",g_imba_m.imba003,"' "
   PREPARE imca_ins_imbj_pre FROM l_sql
   EXECUTE imca_ins_imbj_pre 
   
   LET l_sql = "INSERT INTO imbl_tmp(imblent,imbldocno,imbl001,imbl002) ",
               "SELECT '",g_enterprise,"','",g_imba_m.imbadocno,"','",g_imba_m.imba001,"',imcl002 ",
               "  FROM imcl_t ",
               " WHERE imclent = '",g_enterprise,"' ",
               "   AND imcl001 = '",g_imba_m.imba003,"' "
   PREPARE imca_ins_imbl_pre FROM l_sql
   EXECUTE imca_ins_imbl_pre 
   
   LET l_sql = "INSERT INTO imbm_tmp(imbment,imbmdocno,imbm001,imbm002,imbm003,imbm004,imbm005,imbm006) ",
               "SELECT '",g_enterprise,"','",g_imba_m.imbadocno,"','",g_imba_m.imba001,"',imcm002,imcm003,imcm004,imcm005,imcm006 ",
               "  FROM imcm_t ",
               " WHERE imcment = '",g_enterprise,"' ",
               "   AND imcm001 = '",g_imba_m.imba003,"' "
   PREPARE imca_ins_imbm_pre FROM l_sql
   EXECUTE imca_ins_imbm_pre 
   
   LET l_sql = "INSERT INTO imbo_tmp(imboent,imbodocno,imbo000,imbo001,imbo002) ",
               "SELECT '",g_enterprise,"','",g_imba_m.imbadocno,"','",g_imba_m.imba000,"','",g_imba_m.imba001,"',imco002 ",
               "  FROM imco_t ",
               " WHERE imcoent = '",g_enterprise,"' ",
               "   AND imco001 = '",g_imba_m.imba003,"' "
   PREPARE imca_ins_imbo_pre FROM l_sql
   EXECUTE imca_ins_imbo_pre 
   
   #141231-00009#1--cancel---mark----begin----
   LET l_sql = "INSERT INTO imbk_tmp(imbkent,imbkdocno,imbk001,imbk002,imbk003) ",
               #"SELECT '",g_enterprise,"','",g_imba_m.imbadocno,"','",g_imba_m.imba003,"','",g_imba_m.imba001,"',imcn003 ",  #141231-00009#1 mark
               "SELECT '",g_enterprise,"','",g_imba_m.imbadocno,"','",g_imba_m.imba001,"',imcn002,imcn003 ",  #141231-00009#1 add
               "  FROM imcn_t ",
               " WHERE imcnent = '",g_enterprise,"' ",
               "   AND imcn001 = '",g_imba_m.imba003,"' "
   PREPARE imca_ins_imbk_pre FROM l_sql
   EXECUTE imca_ins_imbk_pre 
   #141231-00009#1--cancel---mark----end----
   
   CALL aimt300_tmp_b_fill()
END FUNCTION
#將臨時表資料寫入實體表
PRIVATE FUNCTION aimt300_ins_detail()
DEFINE l_sql            STRING
DEFINE r_success        LIKE type_t.num5

   LET r_success = TRUE
   DELETE FROM imbj_t WHERE imbjent = g_enterprise AND imbjdocno = g_imba_m.imbadocno
   DELETE FROM imbl_t WHERE imblent = g_enterprise AND imbldocno = g_imba_m.imbadocno
   DELETE FROM imbm_t WHERE imbment = g_enterprise AND imbmdocno = g_imba_m.imbadocno
   DELETE FROM imbo_t WHERE imboent = g_enterprise AND imbodocno = g_imba_m.imbadocno
   
   
   LET l_sql = "INSERT INTO imbj_t(imbjent,imbjdocno,imbj001,imbj002,imbj003,imbj004,imbj005,imbj006) ",
               "SELECT imbjent,imbjdocno,imbj001,imbj002,imbj003,imbj004,imbj005,imbj006 ",
               "  FROM imbj_tmp ",
               " WHERE imbjent = '",g_enterprise,"' ",
               "   AND imbjdocno = '",g_imba_m.imbadocno,"' "
   PREPARE detail_ins_imbj_pre FROM l_sql
   EXECUTE detail_ins_imbj_pre 
   IF SQLCA.sqlcode THEN
      LET r_success = FALSE
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = g_imba_m.imbadocno
      LET g_errparam.popup = TRUE
      CALL cl_err()

      RETURN r_success
   END IF
   
   LET l_sql = "INSERT INTO imbl_t(imblent,imbldocno,imbl001,imbl002) ",
               "SELECT imblent,imbldocno,imbl001,imbl002 ",
               "  FROM imbl_tmp ",
               " WHERE imblent = '",g_enterprise,"' ",
               "   AND imbldocno = '",g_imba_m.imbadocno,"' "
   PREPARE detail_ins_imbl_pre FROM l_sql
   EXECUTE detail_ins_imbl_pre 
   IF SQLCA.sqlcode THEN
      LET r_success = FALSE
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = g_imba_m.imbadocno
      LET g_errparam.popup = TRUE
      CALL cl_err()

      RETURN r_success
   END IF
   
   LET l_sql = "INSERT INTO imbm_t(imbment,imbmdocno,imbm001,imbm002,imbm003,imbm004,imbm005,imbm006) ",
               "SELECT imbment,imbmdocno,imbm001,imbm002,imbm003,imbm004,imbm005,imbm006 ",
               "  FROM imbm_tmp ",
               " WHERE imbment = '",g_enterprise,"' ",
               "   AND imbmdocno = '",g_imba_m.imbadocno,"' "
   PREPARE detail_ins_imbm_pre FROM l_sql
   EXECUTE detail_ins_imbm_pre 
   IF SQLCA.sqlcode THEN
      LET r_success = FALSE
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = g_imba_m.imbadocno
      LET g_errparam.popup = TRUE
      CALL cl_err()

      RETURN r_success
   END IF
   
   LET l_sql = "INSERT INTO imbo_t(imboent,imbodocno,imbo000,imbo001,imbo002) ",
               "SELECT imboent,imbodocno,imbo000,imbo001,imbo002 ",
               "  FROM imbo_tmp ",
               " WHERE imboent = '",g_enterprise,"' ",
               "   AND imbodocno = '",g_imba_m.imbadocno,"' "
   PREPARE detail_ins_imbo_pre FROM l_sql
   EXECUTE detail_ins_imbo_pre 
   IF SQLCA.sqlcode THEN
      LET r_success = FALSE
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = g_imba_m.imbadocno
      LET g_errparam.popup = TRUE
      CALL cl_err()

      RETURN r_success
   END IF
   
   #141231-00009#1--cancel---mark----begin----
   DELETE FROM imbk_t WHERE imbkent = g_enterprise AND imbkdocno = g_imba_m.imbadocno
   LET l_sql = "INSERT INTO imbk_t(imbkent,imbkdocno,imbk001,imbk002,imbk003) ",
               "SELECT imbkent,imbkdocno,imbk001,imbk002,imbk003 ",
               "  FROM imbk_tmp ",
               " WHERE imbkent = '",g_enterprise,"' ",
               "   AND imbkdocno = '",g_imba_m.imbadocno,"' "
   PREPARE detail_ins_imbk_pre FROM l_sql
   EXECUTE detail_ins_imbk_pre 
   IF SQLCA.sqlcode THEN
      LET r_success = FALSE
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = g_imba_m.imbadocno
      LET g_errparam.popup = TRUE
      CALL cl_err()

      RETURN r_success
   END IF
   #141231-00009#1--cancel---mark----end----
   
   CALL aimt300_b_fill()

   RETURN r_success
END FUNCTION
#臨時表資料顯示單身
PRIVATE FUNCTION aimt300_tmp_b_fill()
   CALL g_imbj_d.clear()  
   CALL g_imbj2_d.clear()
   CALL g_imbj3_d.clear()
   CALL g_imbj4_d.clear()
   
   LET g_sql = "SELECT UNIQUE imbj002,imbj003,imbj004,imbj005,'',imbj006,'' FROM imbj_tmp",    
               " WHERE imbjent=? AND imbjdocno=?",
               " ORDER BY imbj002"

   PREPARE aimt300_tmp_pb FROM g_sql
   DECLARE b_fill_tmp_cs CURSOR FOR aimt300_tmp_pb
 
   LET g_cnt = l_ac
   LET l_ac = 1
 
   OPEN b_fill_tmp_cs USING g_enterprise,g_imba_m.imbadocno
                                            
   FOREACH b_fill_tmp_cs INTO g_imbj_d[l_ac].imbj002,g_imbj_d[l_ac].imbj003,g_imbj_d[l_ac].imbj004,g_imbj_d[l_ac].imbj005,g_imbj_d[l_ac].imbj005_desc,g_imbj_d[l_ac].imbj006,g_imbj_d[l_ac].imbj006_desc
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "FOREACH:"
         LET g_errparam.popup = TRUE
         CALL cl_err()

         EXIT FOREACH
      END IF
      
      CALL aimt300_imbj_desc()
 
      LET l_ac = l_ac + 1
      IF l_ac > g_max_rec THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code =  9035
         LET g_errparam.extend =  ''
         LET g_errparam.popup = TRUE
         CALL cl_err()

         EXIT FOREACH
      END IF
      
   END FOREACH
   
   LET g_sql = "SELECT UNIQUE imbl002,'','' FROM imbl_tmp",    
               " WHERE imblent=? AND imbldocno=?",
               " ORDER BY imbl002"
 
   PREPARE aimt300_tmp_pb2 FROM g_sql
   DECLARE b_fill_tmp_cs2 CURSOR FOR aimt300_tmp_pb2
 
   LET l_ac = 1

   OPEN b_fill_tmp_cs2 USING g_enterprise,g_imba_m.imbadocno
                                            
   FOREACH b_fill_tmp_cs2 INTO g_imbj2_d[l_ac].imbl002,g_imbj2_d[l_ac].oocql004,g_imbj2_d[l_ac].oocq005
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "FOREACH:"
         LET g_errparam.popup = TRUE
         CALL cl_err()

         EXIT FOREACH
      END IF
     
      CALL aimt300_imbl_desc()

      LET l_ac = l_ac + 1
      IF l_ac > g_max_rec THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code =  9035
         LET g_errparam.extend =  ''
         LET g_errparam.popup = TRUE
         CALL cl_err()

         EXIT FOREACH
      END IF
      
   END FOREACH

   LET g_sql = "SELECT UNIQUE imbm002,imbm003,imbm004,imbm005,imbm006 FROM imbm_tmp",    
               " WHERE imbment=? AND imbmdocno=?",
               " ORDER BY imbm002"
 
   
   PREPARE aimt300_tmp_pb3 FROM g_sql
   DECLARE b_fill_tmp_cs3 CURSOR FOR aimt300_tmp_pb3
 
   LET l_ac = 1

   OPEN b_fill_tmp_cs3 USING g_enterprise,g_imba_m.imbadocno
                                            
   FOREACH b_fill_tmp_cs3 INTO g_imbj3_d[l_ac].imbm002,g_imbj3_d[l_ac].imbm003,g_imbj3_d[l_ac].imbm004,g_imbj3_d[l_ac].imbm005,g_imbj3_d[l_ac].imbm006
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "FOREACH:"
         LET g_errparam.popup = TRUE
         CALL cl_err()

         EXIT FOREACH
      END IF
     
      LET l_ac = l_ac + 1
      IF l_ac > g_max_rec THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code =  9035
         LET g_errparam.extend =  ''
         LET g_errparam.popup = TRUE
         CALL cl_err()

         EXIT FOREACH
      END IF
      
   END FOREACH

   LET g_sql = "SELECT UNIQUE imbo002,'' FROM imbo_tmp",    
               " WHERE imboent=? AND imbodocno=?",
               " ORDER BY imbo002"
 
   
   PREPARE aimt300_tmp_pb4 FROM g_sql
   DECLARE b_fill_tmp_cs4 CURSOR FOR aimt300_tmp_pb4
 
   LET l_ac = 1

   OPEN b_fill_tmp_cs4 USING g_enterprise,g_imba_m.imbadocno
                                            
   FOREACH b_fill_tmp_cs4 INTO g_imbj4_d[l_ac].imbo002,g_imbj4_d[l_ac].imbo002_desc
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "FOREACH:"
         LET g_errparam.popup = TRUE
         CALL cl_err()

         EXIT FOREACH
      END IF
      CALL aimt300_imbo_desc() 
      LET l_ac = l_ac + 1
      IF l_ac > g_max_rec THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code =  9035
         LET g_errparam.extend =  ''
         LET g_errparam.popup = TRUE
         CALL cl_err()

         EXIT FOREACH
      END IF
      
   END FOREACH

   CALL g_imbj_d.deleteElement(g_imbj_d.getLength())
   CALL g_imbj2_d.deleteElement(g_imbj2_d.getLength())
   CALL g_imbj3_d.deleteElement(g_imbj3_d.getLength())
   CALL g_imbj4_d.deleteElement(g_imbj4_d.getLength())
   
   LET l_ac = g_cnt
   LET g_cnt = 0  
   FREE aimt300_tmp_pb
   FREE aimt300_tmp_pb2
   FREE aimt300_tmp_pb3
   FREE aimt300_tmp_pb4
    
END FUNCTION
#補料號操作
PRIVATE FUNCTION aimt300_fillprd()
DEFINE l_true          LIKE type_t.num5
DEFINE l_imba001       STRING
DEFINE l_n             LIKE type_t.num5
DEFINE l_success       LIKE type_t.num5

   LET l_true = TRUE
   CALL s_transaction_begin()
   INPUT BY NAME g_imba_m.imba001  ATTRIBUTE(WITHOUT DEFAULTS)
   
      BEFORE FIELD imba001
         IF g_imba_m.imba000 = 'I' AND cl_null(g_imba_m.imba001) THEN
            CALL cl_get_para(g_enterprise,g_site,'E-BAS-0012') RETURNING l_sys
            IF l_sys = 'Y' THEN
            
               #150310---earl---mod---s
               #CALL s_aooi390('1') RETURNING l_success,g_imba_m.imba001
               #DISPLAY BY NAME g_imba_m.imba001
               
               CALL aimt300_aooi390_default()
               #150310---earl---mod---e
               
               #NEXT FIELD imba001
            END IF
         END IF
      
      AFTER FIELD imba001
         IF NOT cl_null(g_imba_m.imba001) THEN
            IF g_imba_m.imba001 <> g_imba_m_t.imba001 OR cl_null(g_imba_m_t.imba001) THEN
               CALL aimt300_chk_imba001_fillprd()
               IF NOT cl_null(g_errno) THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = g_errno
                  LET g_errparam.extend = g_imba_m.imba001
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  LET g_imba_m.imba001 = g_imba_m_t.imba001
                  NEXT FIELD imba001
               END IF
               #add--2015/05/08 By shiun--(S)
               IF NOT s_aooi390_chk('1',g_imba_m.imba001) THEN
                  LET g_imba_m.imba001 = g_imba_m_t.imba001
                  DISPLAY BY NAME g_imba_m.imba001
                  NEXT FIELD CURRENT
               END IF
               #add--2015/05/08 By shiun--(E)
            END IF
            
            LET l_imba001 = g_imba_m.imba001
            LET l_n = l_imba001.getLength()
            IF l_n > cl_get_para(g_enterprise,g_site,'E-BAS-0003') THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = 'aim-00215'
               LET g_errparam.extend = g_imba_m.imba001
               LET g_errparam.popup = TRUE
               CALL cl_err()

               LET g_imba_m.imba001 = g_imba_m_t.imba001
               NEXT FIELD CURRENT
            END IF
         END IF
            
      AFTER INPUT 
        #UPDATE imba_t 
        #   SET imba001 = g_imba_m.imba001
        # WHERE imbaent = g_enterprise 
        #   AND imbadocno = g_imba_m.imbadocno
        #IF SQLCA.sqlcode THEN
        #   INITIALIZE g_errparam TO NULL
        #   LET g_errparam.code = SQLCA.sqlcode
        #   LET g_errparam.extend = "upd_imba"
        #   LET g_errparam.popup = TRUE
        #   CALL cl_err()
        #   LET l_true = FALSE
        #END IF
        #
        #CALL aimt300_upd_imba001() RETURNING l_true
        #
        #IF NOT l_true THEN        
        #   CALL s_transaction_end('N','0')
        #ELSE
        #   CALL s_transaction_end('Y','0')
        #END IF        
        #EXIT INPUT
   END INPUT
   
   IF INT_FLAG OR g_imba_m.imba001 IS NULL THEN
      LET INT_FLAG = 0
      CALL s_transaction_end('N','0')
      LET g_imba_m.imba001 = ''
      DISPLAY BY NAME g_imba_m.imba001
      RETURN
   END IF
   
   #20151030 by stellar add ----- (S)
   #自動取號
   CALL s_aooi390_get_auto_no('1',g_imba_m.imba001) RETURNING l_success,g_imba_m.imba001
   IF NOT l_success THEN
      CALL s_transaction_end('N','0')
      LET g_imba_m.imba001 = ''
      DISPLAY BY NAME g_imba_m.imba001
      RETURN
   END IF
              
   CALL s_aooi390_oofi_upd('1',g_imba_m.imba001) RETURNING l_success  #增加編碼功能 
   IF NOT l_success THEN
      CALL s_transaction_end('N','0')
      LET g_imba_m.imba001 = ''
      DISPLAY BY NAME g_imba_m.imba001
      RETURN
   END IF
   #20151030 by stellar add ----- (E)
   
   UPDATE imba_t 
      SET imba001 = g_imba_m.imba001
    WHERE imbaent = g_enterprise 
      AND imbadocno = g_imba_m.imbadocno
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = "upd_imba"
      LET g_errparam.popup = TRUE
      CALL cl_err()
      LET l_true = FALSE
   END IF
   
   CALL aimt300_upd_imba001() RETURNING l_true
   
   IF NOT l_true THEN        
      CALL s_transaction_end('N','0')
   ELSE
      CALL s_transaction_end('Y','0')
   END IF  
   
END FUNCTION
#補料號，料號檢查
PRIVATE FUNCTION aimt300_chk_imba001_fillprd()
DEFINE l_n         LIKE type_t.num5

   LET g_errno = ''
   
   IF NOT cl_null(g_imba_m.imba001) THEN
      IF g_imba_m.imba000 = 'I' THEN
         LET l_n = 0
         SELECT COUNT(*) INTO l_n
           FROM imaa_t
          WHERE imaa001 = g_imba_m.imba001
            AND imaaent = g_enterprise
         IF l_n > 0 THEN
            LET g_errno = 'aim-00105'
         ELSE
             LET l_n = 0
             SELECT COUNT(*) INTO l_n
               FROM imba_t
              WHERE imbaent = g_enterprise
                AND imba001 = g_imba_m.imba001
                AND imbastus <> 'X'
             IF l_n > 0 THEN
                LET g_errno = 'aim-00106'
             END IF
         END IF
      END IF
   END IF
END FUNCTION
#錄入單據顯示單據說明
PRIVATE FUNCTION aimt300_get_oobxl003()
   LET g_imba_m.oobxl003 = ""
   IF NOT cl_null(g_imba_m.imbadocno) THEN
      SELECT oobxl003 INTO g_imba_m.oobxl003
        FROM oobxl_t
       WHERE oobxl001 = g_imba_m.imbadocno
         AND oobxl002 = g_dlang
         AND oobxlent = g_enterprise
   END IF
   DISPLAY BY NAME g_imba_m.oobxl003
END FUNCTION
################################################################################
# Descriptions...: 寫入其它資料
# Memo...........: 將imae_t,imaf_t,imag_t,imah_t新增到imbe_t,imbf_t,imbg_t,imbh_t
# Usage..........: CALL aimt300_ins_other()
#                : r_success   處理結果
# Input parameter: 
#                : 
# Return code....: r_success   TRUE/FALSE
# Date & Author..: 
# Modify.........: 2015/04/30 BY polly 料件據點關務檔(imah_t)改為iman_t
#                                      料件申請料號據點關務檔(imbh_t)改為imbn_t
################################################################################
PRIVATE FUNCTION aimt300_ins_other()
#DEFINE l_imae      RECORD LIKE imae_t.*  #161124-00048#3 2016/12/08 By 08734 mark
#161124-00048#3 2016/12/08 By 08734 add(S)
DEFINE l_imae RECORD  #料件據點製造檔
       imaeent LIKE imae_t.imaeent, #企業編號
       imaesite LIKE imae_t.imaesite, #營運據點
       imae001 LIKE imae_t.imae001, #料件編號
       imae011 LIKE imae_t.imae011, #生管分群
       imae012 LIKE imae_t.imae012, #計畫員
       imae013 LIKE imae_t.imae013, #生產型態
       imae014 LIKE imae_t.imae014, #領發料機制
       imae015 LIKE imae_t.imae015, #生產損耗率
       imae016 LIKE imae_t.imae016, #生產單位
       imae017 LIKE imae_t.imae017, #生產單位批量
       imae018 LIKE imae_t.imae018, #最小生產數量
       imae019 LIKE imae_t.imae019, #生產批量控管方式
       imae020 LIKE imae_t.imae020, #生產超交率
       imae021 LIKE imae_t.imae021, #生產命令展開選項
       imae022 LIKE imae_t.imae022, #工單拆分批量
       imae023 LIKE imae_t.imae023, #必要性質
       imae031 LIKE imae_t.imae031, #預設工單別
       imae032 LIKE imae_t.imae032, #製程料號
       imae033 LIKE imae_t.imae033, #預設製程編號
       imae034 LIKE imae_t.imae034, #預設部門/供應商
       imae035 LIKE imae_t.imae035, #預設成本中心
       imae036 LIKE imae_t.imae036, #允許需求合併生產
       imae037 LIKE imae_t.imae037, #預設BOM特性
       imae041 LIKE imae_t.imae041, #預設入庫庫位
       imae042 LIKE imae_t.imae042, #預設入庫儲位
       imae051 LIKE imae_t.imae051, #標準人工工時
       imae052 LIKE imae_t.imae052, #標準機器工時
       imae061 LIKE imae_t.imae061, #MPS計算
       imae062 LIKE imae_t.imae062, #預測無效天數
       imae063 LIKE imae_t.imae063, #供給匯整時距
       imae064 LIKE imae_t.imae064, #計畫匯整時距
       imae065 LIKE imae_t.imae065, #建議新單量
       imae066 LIKE imae_t.imae066, #預計停產日
       imae071 LIKE imae_t.imae071, #固定生產前置時間
       imae072 LIKE imae_t.imae072, #變動生產前置時間
       imae073 LIKE imae_t.imae073, #變動批量
       imae074 LIKE imae_t.imae074, #QC前置時間
       imae075 LIKE imae_t.imae075, #累計前置時間
       imae076 LIKE imae_t.imae076, #嚴守交期前置時間
       imae077 LIKE imae_t.imae077, #計畫批次移轉量
       imae078 LIKE imae_t.imae078, #物料規劃移轉時間
       imae079 LIKE imae_t.imae079, #主料需求保留天數
       imae080 LIKE imae_t.imae080, #關鍵物料
       imae081 LIKE imae_t.imae081, #發料單位
       imae082 LIKE imae_t.imae082, #發料單位批量
       imae083 LIKE imae_t.imae083, #最小發料數量
       imae084 LIKE imae_t.imae084, #發料批量控管方式
       imae085 LIKE imae_t.imae085, #預設投料時距
       imae091 LIKE imae_t.imae091, #倒扣料
       imae092 LIKE imae_t.imae092, #發料前調撥
       imae101 LIKE imae_t.imae101, #預設發料庫位
       imae102 LIKE imae_t.imae102, #預設發料儲位
       imae103 LIKE imae_t.imae103, #預設退料庫位
       imae104 LIKE imae_t.imae104, #預設退料儲位
       imae111 LIKE imae_t.imae111, #品管分群
       imae112 LIKE imae_t.imae112, #品管員
       imae113 LIKE imae_t.imae113, #檢驗單位
       imae114 LIKE imae_t.imae114, #進料檢驗否
       imae115 LIKE imae_t.imae115, #檢驗程度
       imae116 LIKE imae_t.imae116, #檢驗水準
       imae117 LIKE imae_t.imae117, #檢驗級數
       imae118 LIKE imae_t.imae118, #庫存失效提前通知天數
       imae119 LIKE imae_t.imae119, #檢驗標準工時
       imae120 LIKE imae_t.imae120, #使用品檢判定等級功能
       imaeownid LIKE imae_t.imaeownid, #資料所有者
       imaeowndp LIKE imae_t.imaeowndp, #資料所屬部門
       imaecrtid LIKE imae_t.imaecrtid, #資料建立者
       imaecrtdt LIKE imae_t.imaecrtdt, #資料創建日
       imaecrtdp LIKE imae_t.imaecrtdp, #資料建立部門
       imaemodid LIKE imae_t.imaemodid, #資料修改者
       imaemoddt LIKE imae_t.imaemoddt, #最近修改日
       imaecnfid LIKE imae_t.imaecnfid, #資料確認者
       imaecnfdt LIKE imae_t.imaecnfdt, #資料確認日
       imaestus LIKE imae_t.imaestus, #資料有效碼
       imaeud001 LIKE imae_t.imaeud001, #自定義欄位(文字)001
       imaeud002 LIKE imae_t.imaeud002, #自定義欄位(文字)002
       imaeud003 LIKE imae_t.imaeud003, #自定義欄位(文字)003
       imaeud004 LIKE imae_t.imaeud004, #自定義欄位(文字)004
       imaeud005 LIKE imae_t.imaeud005, #自定義欄位(文字)005
       imaeud006 LIKE imae_t.imaeud006, #自定義欄位(文字)006
       imaeud007 LIKE imae_t.imaeud007, #自定義欄位(文字)007
       imaeud008 LIKE imae_t.imaeud008, #自定義欄位(文字)008
       imaeud009 LIKE imae_t.imaeud009, #自定義欄位(文字)009
       imaeud010 LIKE imae_t.imaeud010, #自定義欄位(文字)010
       imaeud011 LIKE imae_t.imaeud011, #自定義欄位(數字)011
       imaeud012 LIKE imae_t.imaeud012, #自定義欄位(數字)012
       imaeud013 LIKE imae_t.imaeud013, #自定義欄位(數字)013
       imaeud014 LIKE imae_t.imaeud014, #自定義欄位(數字)014
       imaeud015 LIKE imae_t.imaeud015, #自定義欄位(數字)015
       imaeud016 LIKE imae_t.imaeud016, #自定義欄位(數字)016
       imaeud017 LIKE imae_t.imaeud017, #自定義欄位(數字)017
       imaeud018 LIKE imae_t.imaeud018, #自定義欄位(數字)018
       imaeud019 LIKE imae_t.imaeud019, #自定義欄位(數字)019
       imaeud020 LIKE imae_t.imaeud020, #自定義欄位(數字)020
       imaeud021 LIKE imae_t.imaeud021, #自定義欄位(日期時間)021
       imaeud022 LIKE imae_t.imaeud022, #自定義欄位(日期時間)022
       imaeud023 LIKE imae_t.imaeud023, #自定義欄位(日期時間)023
       imaeud024 LIKE imae_t.imaeud024, #自定義欄位(日期時間)024
       imaeud025 LIKE imae_t.imaeud025, #自定義欄位(日期時間)025
       imaeud026 LIKE imae_t.imaeud026, #自定義欄位(日期時間)026
       imaeud027 LIKE imae_t.imaeud027, #自定義欄位(日期時間)027
       imaeud028 LIKE imae_t.imaeud028, #自定義欄位(日期時間)028
       imaeud029 LIKE imae_t.imaeud029, #自定義欄位(日期時間)029
       imaeud030 LIKE imae_t.imaeud030, #自定義欄位(日期時間)030
       imae086 LIKE imae_t.imae086 #庫存可混批供給
END RECORD
#161124-00048#3 2016/12/08 By 08734 add(E)
#DEFINE l_imaf      RECORD LIKE imaf_t.*  #161124-00048#3 2016/12/08 By 08734 mark
#161124-00048#3 2016/12/08 By 08734 add(S)
DEFINE l_imaf RECORD  #料件據點進銷存檔
       imafent LIKE imaf_t.imafent, #企业编号
       imafsite LIKE imaf_t.imafsite, #营运据点
       imaf001 LIKE imaf_t.imaf001, #料件编号
       imaf011 LIKE imaf_t.imaf011, #主分群
       imaf012 LIKE imaf_t.imaf012, #存货控制方法
       imaf013 LIKE imaf_t.imaf013, #补给策略
       imaf014 LIKE imaf_t.imaf014, #需求计算方法
       imaf015 LIKE imaf_t.imaf015, #参考单位
       imaf016 LIKE imaf_t.imaf016, #据点生命周期
       imaf017 LIKE imaf_t.imaf017, #税种
       imaf018 LIKE imaf_t.imaf018, #使用附属零件
       imaf021 LIKE imaf_t.imaf021, #期间采购月数
       imaf022 LIKE imaf_t.imaf022, #期间采购日数
       imaf023 LIKE imaf_t.imaf023, #期间补足量
       imaf024 LIKE imaf_t.imaf024, #再订货点
       imaf025 LIKE imaf_t.imaf025, #再订货点量
       imaf026 LIKE imaf_t.imaf026, #安全库存量
       imaf027 LIKE imaf_t.imaf027, #警戒库存量
       imaf031 LIKE imaf_t.imaf031, #有效期月数
       imaf032 LIKE imaf_t.imaf032, #有效期加天数
       imaf033 LIKE imaf_t.imaf033, #检疫/隔离天数
       imaf034 LIKE imaf_t.imaf034, #保税料件
       imaf035 LIKE imaf_t.imaf035, #对应非保税料号
       imaf051 LIKE imaf_t.imaf051, #库存分群
       imaf052 LIKE imaf_t.imaf052, #仓管员
       imaf053 LIKE imaf_t.imaf053, #据点库存单位
       imaf054 LIKE imaf_t.imaf054, #库存多单位
       imaf055 LIKE imaf_t.imaf055, #库存管理特微
       imaf056 LIKE imaf_t.imaf056, #no use
       imaf057 LIKE imaf_t.imaf057, #ABC码
       imaf058 LIKE imaf_t.imaf058, #存货备置策略
       imaf059 LIKE imaf_t.imaf059, #捡货策略
       imaf061 LIKE imaf_t.imaf061, #库存批号控管方式
       imaf062 LIKE imaf_t.imaf062, #库存批号自动编码否
       imaf063 LIKE imaf_t.imaf063, #库存批号编码方式
       imaf064 LIKE imaf_t.imaf064, #库存批号唯一性检查控管
       imaf071 LIKE imaf_t.imaf071, #制造批号控管方式
       imaf072 LIKE imaf_t.imaf072, #制造批号自动编码否
       imaf073 LIKE imaf_t.imaf073, #制造批号编码方式
       imaf074 LIKE imaf_t.imaf074, #制造批号唯一性检查控管
       imaf081 LIKE imaf_t.imaf081, #序号控管方式
       imaf082 LIKE imaf_t.imaf082, #序号自动编码否
       imaf083 LIKE imaf_t.imaf083, #序号编码方式
       imaf084 LIKE imaf_t.imaf084, #序号唯一性检查控管
       imaf091 LIKE imaf_t.imaf091, #默认库位
       imaf092 LIKE imaf_t.imaf092, #默认储位
       imaf093 LIKE imaf_t.imaf093, #no use
       imaf094 LIKE imaf_t.imaf094, #盘点容差数
       imaf095 LIKE imaf_t.imaf095, #盘点容差率
       imaf096 LIKE imaf_t.imaf096, #开账呆滞日期
       imaf097 LIKE imaf_t.imaf097, #no use
       imaf101 LIKE imaf_t.imaf101, #调拨批量
       imaf102 LIKE imaf_t.imaf102, #最小调拨数量
       imaf111 LIKE imaf_t.imaf111, #销售分群
       imaf112 LIKE imaf_t.imaf112, #销售单位
       imaf113 LIKE imaf_t.imaf113, #销售计价单位
       imaf114 LIKE imaf_t.imaf114, #销售批量
       imaf115 LIKE imaf_t.imaf115, #最小销售数量
       imaf116 LIKE imaf_t.imaf116, #销售批量控管方式
       imaf117 LIKE imaf_t.imaf117, #保证(固)月数
       imaf118 LIKE imaf_t.imaf118, #保证(固)天数
       imaf121 LIKE imaf_t.imaf121, #默认内外销
       imaf122 LIKE imaf_t.imaf122, #订单子件拆解方式
       imaf123 LIKE imaf_t.imaf123, #惯用包装容器
       imaf124 LIKE imaf_t.imaf124, #销售备货提前天数
       imaf125 LIKE imaf_t.imaf125, #预测料号
       imaf126 LIKE imaf_t.imaf126, #出货替代
       imaf127 LIKE imaf_t.imaf127, #统计除外商品
       imaf128 LIKE imaf_t.imaf128, #销售超交率
       imaf141 LIKE imaf_t.imaf141, #采购分群
       imaf142 LIKE imaf_t.imaf142, #采购员
       imaf143 LIKE imaf_t.imaf143, #采购单位
       imaf144 LIKE imaf_t.imaf144, #采购计价单位
       imaf145 LIKE imaf_t.imaf145, #采购单位批量
       imaf146 LIKE imaf_t.imaf146, #最小采购数量
       imaf147 LIKE imaf_t.imaf147, #采购批量控管方式
       imaf148 LIKE imaf_t.imaf148, #经济订购量
       imaf149 LIKE imaf_t.imaf149, #平均订购量
       imaf151 LIKE imaf_t.imaf151, #默认内外购
       imaf152 LIKE imaf_t.imaf152, #供应商选择方式
       imaf153 LIKE imaf_t.imaf153, #主要供应商
       imaf154 LIKE imaf_t.imaf154, #主供应商分配限量
       imaf155 LIKE imaf_t.imaf155, #分配进位倍数
       imaf156 LIKE imaf_t.imaf156, #供货模式
       imaf157 LIKE imaf_t.imaf157, #惯用包装容器
       imaf158 LIKE imaf_t.imaf158, #接单拆解方式(采购)
       imaf161 LIKE imaf_t.imaf161, #采购替代
       imaf162 LIKE imaf_t.imaf162, #采购收货替代
       imaf163 LIKE imaf_t.imaf163, #采购合同冲销
       imaf164 LIKE imaf_t.imaf164, #采购时损耗率
       imaf165 LIKE imaf_t.imaf165, #采购时备品率
       imaf166 LIKE imaf_t.imaf166, #采购超交率
       imaf171 LIKE imaf_t.imaf171, #采购文档前置时间
       imaf172 LIKE imaf_t.imaf172, #采购交货前置时间
       imaf173 LIKE imaf_t.imaf173, #采购到厂前置时间
       imaf174 LIKE imaf_t.imaf174, #采购入库前置时间
       imaf175 LIKE imaf_t.imaf175, #严守交期前置时间
       imaf176 LIKE imaf_t.imaf176, #收货时段
       imafownid LIKE imaf_t.imafownid, #资料所有者
       imafowndp LIKE imaf_t.imafowndp, #资料所有部门
       imafcrtid LIKE imaf_t.imafcrtid, #资料录入者
       imafcrtdp LIKE imaf_t.imafcrtdp, #资料录入部门
       imafcrtdt LIKE imaf_t.imafcrtdt, #资料创建日
       imafmodid LIKE imaf_t.imafmodid, #资料更改者
       imafmoddt LIKE imaf_t.imafmoddt, #最近更改日
       imafcnfid LIKE imaf_t.imafcnfid, #资料审核者
       imafcnfdt LIKE imaf_t.imafcnfdt, #数据审核日
       imafstus LIKE imaf_t.imafstus, #状态码
       imafud001 LIKE imaf_t.imafud001, #自定义字段(文本)001
       imafud002 LIKE imaf_t.imafud002, #自定义字段(文本)002
       imafud003 LIKE imaf_t.imafud003, #自定义字段(文本)003
       imafud004 LIKE imaf_t.imafud004, #自定义字段(文本)004
       imafud005 LIKE imaf_t.imafud005, #自定义字段(文本)005
       imafud006 LIKE imaf_t.imafud006, #自定义字段(文本)006
       imafud007 LIKE imaf_t.imafud007, #自定义字段(文本)007
       imafud008 LIKE imaf_t.imafud008, #自定义字段(文本)008
       imafud009 LIKE imaf_t.imafud009, #自定义字段(文本)009
       imafud010 LIKE imaf_t.imafud010, #自定义字段(文本)010
       imafud011 LIKE imaf_t.imafud011, #自定义字段(数字)011
       imafud012 LIKE imaf_t.imafud012, #自定义字段(数字)012
       imafud013 LIKE imaf_t.imafud013, #自定义字段(数字)013
       imafud014 LIKE imaf_t.imafud014, #自定义字段(数字)014
       imafud015 LIKE imaf_t.imafud015, #自定义字段(数字)015
       imafud016 LIKE imaf_t.imafud016, #自定义字段(数字)016
       imafud017 LIKE imaf_t.imafud017, #自定义字段(数字)017
       imafud018 LIKE imaf_t.imafud018, #自定义字段(数字)018
       imafud019 LIKE imaf_t.imafud019, #自定义字段(数字)019
       imafud020 LIKE imaf_t.imafud020, #自定义字段(数字)020
       imafud021 LIKE imaf_t.imafud021, #自定义字段(日期时间)021
       imafud022 LIKE imaf_t.imafud022, #自定义字段(日期时间)022
       imafud023 LIKE imaf_t.imafud023, #自定义字段(日期时间)023
       imafud024 LIKE imaf_t.imafud024, #自定义字段(日期时间)024
       imafud025 LIKE imaf_t.imafud025, #自定义字段(日期时间)025
       imafud026 LIKE imaf_t.imafud026, #自定义字段(日期时间)026
       imafud027 LIKE imaf_t.imafud027, #自定义字段(日期时间)027
       imafud028 LIKE imaf_t.imafud028, #自定义字段(日期时间)028
       imafud029 LIKE imaf_t.imafud029, #自定义字段(日期时间)029
       imafud030 LIKE imaf_t.imafud030, #自定义字段(日期时间)030
       imaf177 LIKE imaf_t.imaf177, #箱盒号条码管理
       imaf178 LIKE imaf_t.imaf178, #条码编码方式
       imaf179 LIKE imaf_t.imaf179, #条码包装数量
       imaf129 LIKE imaf_t.imaf129, #销售合同冲销
       imaf130 LIKE imaf_t.imaf130 #销售时备品率
END RECORD
#161124-00048#3 2016/12/08 By 08734 add(E)
#DEFINE l_imbe      RECORD LIKE imbe_t.*  #161124-00048#3 2016/12/08 By 08734 mark
#161124-00048#3 2016/12/08 By 08734 add(S)
DEFINE l_imbe RECORD  #料件申請料號據點製造檔
       imbeent LIKE imbe_t.imbeent, #企业编号
       imbesite LIKE imbe_t.imbesite, #营运据点
       imbe001 LIKE imbe_t.imbe001, #料件编号
       imbe011 LIKE imbe_t.imbe011, #生管分群
       imbe012 LIKE imbe_t.imbe012, #计划员
       imbe013 LIKE imbe_t.imbe013, #生产型态
       imbe014 LIKE imbe_t.imbe014, #领发料机制
       imbe015 LIKE imbe_t.imbe015, #生产损耗率
       imbe016 LIKE imbe_t.imbe016, #生产单位
       imbe017 LIKE imbe_t.imbe017, #生产单位批量
       imbe018 LIKE imbe_t.imbe018, #最小生产数量
       imbe019 LIKE imbe_t.imbe019, #生产批量控管方式
       imbe020 LIKE imbe_t.imbe020, #生产超交率
       imbe021 LIKE imbe_t.imbe021, #生产指令展开选项
       imbe022 LIKE imbe_t.imbe022, #工单拆分批量
       imbe023 LIKE imbe_t.imbe023, #必要性质
       imbe031 LIKE imbe_t.imbe031, #默认工单别
       imbe032 LIKE imbe_t.imbe032, #工艺料号
       imbe033 LIKE imbe_t.imbe033, #默认工艺编号
       imbe034 LIKE imbe_t.imbe034, #默认部门/供应商
       imbe035 LIKE imbe_t.imbe035, #默认成本中心
       imbe036 LIKE imbe_t.imbe036, #允许需求合并生产
       imbe037 LIKE imbe_t.imbe037, #默认BOM特性
       imbe041 LIKE imbe_t.imbe041, #默认入库库位
       imbe042 LIKE imbe_t.imbe042, #默认入库储位
       imbe051 LIKE imbe_t.imbe051, #标准人工工时
       imbe052 LIKE imbe_t.imbe052, #标准机器工时
       imbe061 LIKE imbe_t.imbe061, #MPS计算
       imbe062 LIKE imbe_t.imbe062, #预测无效天数
       imbe063 LIKE imbe_t.imbe063, #需求汇整时距
       imbe064 LIKE imbe_t.imbe064, #供给汇整时距
       imbe065 LIKE imbe_t.imbe065, #建议新单量
       imbe066 LIKE imbe_t.imbe066, #预计停产日
       imbe071 LIKE imbe_t.imbe071, #固定生产前置时间
       imbe072 LIKE imbe_t.imbe072, #变动生产前置时间
       imbe073 LIKE imbe_t.imbe073, #变动批量
       imbe074 LIKE imbe_t.imbe074, #QC前置时间
       imbe075 LIKE imbe_t.imbe075, #累计前置时间
       imbe076 LIKE imbe_t.imbe076, #严守交期前置时间
       imbe077 LIKE imbe_t.imbe077, #计划批次移转量
       imbe078 LIKE imbe_t.imbe078, #物规划移转时间
       imbe079 LIKE imbe_t.imbe079, #主料需求保留天数
       imbe080 LIKE imbe_t.imbe080, #关键物料
       imbe081 LIKE imbe_t.imbe081, #发料单位
       imbe082 LIKE imbe_t.imbe082, #发料单位批量
       imbe083 LIKE imbe_t.imbe083, #最小发料数量
       imbe084 LIKE imbe_t.imbe084, #发料批量控管方式
       imbe085 LIKE imbe_t.imbe085, #默认投料时距
       imbe091 LIKE imbe_t.imbe091, #倒扣料
       imbe092 LIKE imbe_t.imbe092, #发料前调拨
       imbe101 LIKE imbe_t.imbe101, #默认发料库位
       imbe102 LIKE imbe_t.imbe102, #默认发料储位
       imbe103 LIKE imbe_t.imbe103, #默认退料库位
       imbe104 LIKE imbe_t.imbe104, #默认退料储位
       imbe111 LIKE imbe_t.imbe111, #品管分群
       imbe112 LIKE imbe_t.imbe112, #品管员
       imbe113 LIKE imbe_t.imbe113, #检验单位
       imbe114 LIKE imbe_t.imbe114, #进料检验否
       imbe115 LIKE imbe_t.imbe115, #检验程度
       imbe116 LIKE imbe_t.imbe116, #检验水准
       imbe117 LIKE imbe_t.imbe117, #检验级数
       imbe118 LIKE imbe_t.imbe118, #库存失效提前通知天数
       imbe119 LIKE imbe_t.imbe119, #检验标准工时
       imbe120 LIKE imbe_t.imbe120, #使用品检判定等级功能
       imbedocno LIKE imbe_t.imbedocno, #申请单号
       imbeownid LIKE imbe_t.imbeownid, #资料所有者
       imbeowndp LIKE imbe_t.imbeowndp, #资料所有部门
       imbecrtid LIKE imbe_t.imbecrtid, #资料录入者
       imbecrtdt LIKE imbe_t.imbecrtdt, #资料创建日
       imbecrtdp LIKE imbe_t.imbecrtdp, #资料录入部门
       imbemodid LIKE imbe_t.imbemodid, #资料更改者
       imbemoddt LIKE imbe_t.imbemoddt, #最近更改日
       imbecnfid LIKE imbe_t.imbecnfid, #资料审核者
       imbecnfdt LIKE imbe_t.imbecnfdt, #数据审核日
       imbepstid LIKE imbe_t.imbepstid, #资料过账者
       imbepstdt LIKE imbe_t.imbepstdt, #资料过账日
       imbeacti LIKE imbe_t.imbeacti, #数据有效码
       imbestus LIKE imbe_t.imbestus #状态码
END RECORD
#161124-00048#3 2016/12/08 By 08734 add(E)
#DEFINE l_imbf      RECORD LIKE imbf_t.*  #161124-00048#3 2016/12/08 By 08734 mark
#161124-00048#3 2016/12/08 By 08734 add(S)
DEFINE l_imbf RECORD  #料件申請單料號據點進銷存檔
       imbfent LIKE imbf_t.imbfent, #企业编号
       imbfsite LIKE imbf_t.imbfsite, #营运据点
       imbfdocno LIKE imbf_t.imbfdocno, #申请单号
       imbf001 LIKE imbf_t.imbf001, #料件编号
       imbf011 LIKE imbf_t.imbf011, #主分群
       imbf012 LIKE imbf_t.imbf012, #存货控制方法
       imbf013 LIKE imbf_t.imbf013, #补给策略
       imbf014 LIKE imbf_t.imbf014, #需求计算方法
       imbf015 LIKE imbf_t.imbf015, #参考单位
       imbf016 LIKE imbf_t.imbf016, #据点生命周期
       imbf017 LIKE imbf_t.imbf017, #税种
       imbf018 LIKE imbf_t.imbf018, #使用附属零件
       imbf021 LIKE imbf_t.imbf021, #期间采购月数
       imbf022 LIKE imbf_t.imbf022, #期间采购日数
       imbf023 LIKE imbf_t.imbf023, #期间补足量
       imbf024 LIKE imbf_t.imbf024, #再订货点
       imbf025 LIKE imbf_t.imbf025, #再订货点量
       imbf026 LIKE imbf_t.imbf026, #安全库存量
       imbf027 LIKE imbf_t.imbf027, #警戒库存量
       imbf031 LIKE imbf_t.imbf031, #有效期月数
       imbf032 LIKE imbf_t.imbf032, #有效期加天数
       imbf033 LIKE imbf_t.imbf033, #检疫/隔离天数
       imbf034 LIKE imbf_t.imbf034, #保税料件
       imbf035 LIKE imbf_t.imbf035, #对应非保税料号
       imbf051 LIKE imbf_t.imbf051, #库存分群
       imbf052 LIKE imbf_t.imbf052, #仓管员
       imbf053 LIKE imbf_t.imbf053, #据点库存单位
       imbf054 LIKE imbf_t.imbf054, #库存多单位
       imbf055 LIKE imbf_t.imbf055, #库存管理特微
       imbf056 LIKE imbf_t.imbf056, #库存管理特征可空白
       imbf057 LIKE imbf_t.imbf057, #ABC码
       imbf058 LIKE imbf_t.imbf058, #存货备置策略
       imbf059 LIKE imbf_t.imbf059, #捡货策略
       imbf061 LIKE imbf_t.imbf061, #库存批号控管方式
       imbf062 LIKE imbf_t.imbf062, #库存批号自动编码否
       imbf063 LIKE imbf_t.imbf063, #库存批号编码方式
       imbf064 LIKE imbf_t.imbf064, #库存批号唯一性检查控管
       imbf071 LIKE imbf_t.imbf071, #制造批号控管方式
       imbf072 LIKE imbf_t.imbf072, #制造批号自动编码否
       imbf073 LIKE imbf_t.imbf073, #制造批号编码方式
       imbf074 LIKE imbf_t.imbf074, #制造批号唯一性检查控管
       imbf081 LIKE imbf_t.imbf081, #序号控管方式
       imbf082 LIKE imbf_t.imbf082, #序号自动编码否
       imbf083 LIKE imbf_t.imbf083, #序号编码方式
       imbf084 LIKE imbf_t.imbf084, #序号唯一性检查控管
       imbf091 LIKE imbf_t.imbf091, #默认库位
       imbf092 LIKE imbf_t.imbf092, #默认储位
       imbf093 LIKE imbf_t.imbf093, #no use
       imbf094 LIKE imbf_t.imbf094, #盘点容差数
       imbf095 LIKE imbf_t.imbf095, #盘点容差率
       imbf096 LIKE imbf_t.imbf096, #呆滞日期开账
       imbf097 LIKE imbf_t.imbf097, #no use
       imbf101 LIKE imbf_t.imbf101, #调拨批量
       imbf102 LIKE imbf_t.imbf102, #最小调拨数量
       imbf111 LIKE imbf_t.imbf111, #销售分群
       imbf112 LIKE imbf_t.imbf112, #销售单位
       imbf113 LIKE imbf_t.imbf113, #销售计价单位
       imbf114 LIKE imbf_t.imbf114, #销售批量
       imbf115 LIKE imbf_t.imbf115, #最小销售数量
       imbf116 LIKE imbf_t.imbf116, #销售批量控管方式
       imbf117 LIKE imbf_t.imbf117, #保证(固)月数
       imbf118 LIKE imbf_t.imbf118, #保证(固)天数
       imbf121 LIKE imbf_t.imbf121, #默认内外销
       imbf122 LIKE imbf_t.imbf122, #接单拆解方式
       imbf123 LIKE imbf_t.imbf123, #惯用包装容器
       imbf124 LIKE imbf_t.imbf124, #销售备货提前天数
       imbf125 LIKE imbf_t.imbf125, #预测料号
       imbf126 LIKE imbf_t.imbf126, #出货替代
       imbf127 LIKE imbf_t.imbf127, #统计除外商品
       imbf128 LIKE imbf_t.imbf128, #销售超交率
       imbf141 LIKE imbf_t.imbf141, #采购分群
       imbf142 LIKE imbf_t.imbf142, #采购员
       imbf143 LIKE imbf_t.imbf143, #采购单位
       imbf144 LIKE imbf_t.imbf144, #采购计价单位
       imbf145 LIKE imbf_t.imbf145, #采购单位批量
       imbf146 LIKE imbf_t.imbf146, #最小采购数量
       imbf147 LIKE imbf_t.imbf147, #采购批量控管方式
       imbf148 LIKE imbf_t.imbf148, #经济订购量
       imbf149 LIKE imbf_t.imbf149, #平均订购量
       imbf151 LIKE imbf_t.imbf151, #默认内外购
       imbf152 LIKE imbf_t.imbf152, #供应商选择方式
       imbf153 LIKE imbf_t.imbf153, #主要供应商
       imbf154 LIKE imbf_t.imbf154, #主供应商分配限量
       imbf155 LIKE imbf_t.imbf155, #分配进位倍数
       imbf156 LIKE imbf_t.imbf156, #供货模式
       imbf157 LIKE imbf_t.imbf157, #惯用包装容器
       imbf158 LIKE imbf_t.imbf158, #接单拆解方式(采购)
       imbf161 LIKE imbf_t.imbf161, #采购替代
       imbf162 LIKE imbf_t.imbf162, #采购收货替代
       imbf163 LIKE imbf_t.imbf163, #采购合同冲销
       imbf164 LIKE imbf_t.imbf164, #采购时损耗率
       imbf165 LIKE imbf_t.imbf165, #采购时备品率
       imbf166 LIKE imbf_t.imbf166, #采购超交率
       imbf171 LIKE imbf_t.imbf171, #采购文档前置时间
       imbf172 LIKE imbf_t.imbf172, #采购交货前置时间
       imbf173 LIKE imbf_t.imbf173, #采购到厂前置时间
       imbf174 LIKE imbf_t.imbf174, #采购入库前置时间
       imbf175 LIKE imbf_t.imbf175, #严守交期前置时间
       imbf176 LIKE imbf_t.imbf176, #收货时段
       imbfownid LIKE imbf_t.imbfownid, #资料所有者
       imbfowndp LIKE imbf_t.imbfowndp, #资料所有部门
       imbfcrtid LIKE imbf_t.imbfcrtid, #资料录入者
       imbfcrtdt LIKE imbf_t.imbfcrtdt, #资料创建日
       imbfcrtdp LIKE imbf_t.imbfcrtdp, #资料录入部门
       imbfmodid LIKE imbf_t.imbfmodid, #资料更改者
       imbfmoddt LIKE imbf_t.imbfmoddt, #最近更改日
       imbfcnfid LIKE imbf_t.imbfcnfid, #资料审核者
       imbfcnfdt LIKE imbf_t.imbfcnfdt, #数据审核日
       imbfpstid LIKE imbf_t.imbfpstid, #资料过账者
       imbfpstdt LIKE imbf_t.imbfpstdt, #资料过账日
       imbfstus LIKE imbf_t.imbfstus, #数据有效码 
       imbf177 LIKE imbf_t.imbf177, #箱盒号条码管理
       imbf178 LIKE imbf_t.imbf178, #条码编码方式
       imbf179 LIKE imbf_t.imbf179, #条码包装数量
       imbf130 LIKE imbf_t.imbf130 #销售时备品率
END RECORD
#161124-00048#3 2016/12/08 By 08734 add(E)
DEFINE l_time      DATETIME YEAR TO SECOND
DEFINE r_success   LIKE type_t.num5
DEFINE l_sql       STRING

   LET r_success = TRUE
   INITIALIZE l_imae.* TO NULL
   INITIALIZE l_imaf.* TO NULL
   #SELECT * INTO l_imaf.*  #161124-00048#3 2016/12/08 By 08734 mark
   SELECT imafent,imafsite,imaf001,imaf011,imaf012,imaf013,imaf014,imaf015,imaf016,imaf017,imaf018,imaf021,imaf022,imaf023,imaf024,imaf025,imaf026,imaf027,imaf031,imaf032,imaf033,imaf034,imaf035,imaf051,imaf052,imaf053,imaf054,imaf055,imaf056,imaf057,imaf058,
       imaf059,imaf061,imaf062,imaf063,imaf064,imaf071,imaf072,imaf073,imaf074,imaf081,imaf082,imaf083,imaf084,imaf091,imaf092,imaf093,imaf094,imaf095,imaf096,imaf097,imaf101,imaf102,imaf111,imaf112,imaf113,imaf114,imaf115,imaf116,imaf117,imaf118,imaf121,imaf122,imaf123,imaf124,imaf125,imaf126,imaf127,imaf128,imaf141,imaf142,imaf143,imaf144,imaf145,
       imaf146,imaf147,imaf148,imaf149,imaf151,imaf152,imaf153,imaf154,imaf155,imaf156,imaf157,imaf158,imaf161,imaf162,imaf163,imaf164,imaf165,imaf166,imaf171,imaf172,imaf173,imaf174,imaf175,imaf176,imafownid,imafowndp,imafcrtid,imafcrtdp,imafcrtdt,imafmodid,imafmoddt,imafcnfid,imafcnfdt,imafstus,imafud001,imafud002,imafud003,imafud004,imafud005,imafud006,imafud007,imafud008,imafud009,imafud010,imafud011,imafud012,imafud013,imafud014,imafud015,imafud016,imafud017,imafud018,imafud019,imafud020,imafud021,imafud022,imafud023,imafud024,imafud025,imafud026,imafud027,imafud028,imafud029,imafud030,imaf177,imaf178,imaf179,imaf129,imaf130  #161124-00048#3 2016/12/08 By 08734 add 
     INTO l_imaf.*   
     FROM imaf_t
    WHERE imafent = g_enterprise
      AND imafsite = 'ALL'
      AND imaf001 = g_imba_m.imba001
   #SELECT * INTO l_imae.*  #161124-00048#3   2016/12/08 By 08734 mark
   SELECT imaeent,imaesite,imae001,imae011,imae012,imae013,imae014,imae015,imae016,imae017,imae018,imae019,imae020,imae021,imae022,imae023,imae031,imae032,imae033,imae034,imae035,imae036,imae037,imae041,imae042,imae051,imae052,  #161124-00048#3   2016/12/08 By 08734 add
       imae061,imae062,imae063,imae064,imae065,imae066,imae071,imae072,imae073,imae074,imae075,imae076,imae077,imae078,imae079,imae080,imae081,imae082,imae083,imae084,imae085,imae091,imae092,imae101,imae102,imae103,imae104,imae111,imae112,imae113,imae114,imae115,imae116,imae117,imae118,imae119,imae120,imaeownid,imaeowndp,imaecrtid,imaecrtdt,imaecrtdp,imaemodid,imaemoddt,imaecnfid,imaecnfdt,imaestus,imaeud001,imaeud002,imaeud003,imaeud004,imaeud005,imaeud006,imaeud007,imaeud008,imaeud009,imaeud010,imaeud011,imaeud012,imaeud013,imaeud014,imaeud015,imaeud016,imaeud017,imaeud018,imaeud019,imaeud020,imaeud021,imaeud022,imaeud023,imaeud024,imaeud025,imaeud026,imaeud027,imaeud028,imaeud029,imaeud030,imae086 
     INTO l_imae.*
     FROM imae_t
    WHERE imaeent = g_enterprise
      AND imaesite = 'ALL'
      AND imae001 = g_imba_m.imba001

   INITIALIZE l_imbe.* TO NULL
   INITIALIZE l_imbf.* TO NULL
   LET l_imbf.imbf011 = l_imaf.imaf011
   LET l_imbf.imbf012 = l_imaf.imaf012
   LET l_imbf.imbf013 = l_imaf.imaf013
   LET l_imbf.imbf014 = l_imaf.imaf014
   LET l_imbf.imbf015 = l_imaf.imaf015
   LET l_imbf.imbf017 = l_imaf.imaf017
   LET l_imbf.imbf016 = l_imaf.imaf016
   LET l_imbf.imbf018 = l_imaf.imaf018
   LET l_imbf.imbf017 = l_imaf.imaf017
   LET l_imbf.imbf021 = l_imaf.imaf021
   LET l_imbf.imbf022 = l_imaf.imaf022
   LET l_imbf.imbf023 = l_imaf.imaf023
   LET l_imbf.imbf024 = l_imaf.imaf024
   LET l_imbf.imbf025 = l_imaf.imaf025
   LET l_imbf.imbf026 = l_imaf.imaf026
   LET l_imbf.imbf027 = l_imaf.imaf027
   LET l_imbf.imbf031 = l_imaf.imaf031
   LET l_imbf.imbf032 = l_imaf.imaf032
   LET l_imbf.imbf033 = l_imaf.imaf033
   LET l_imbf.imbf034 = l_imaf.imaf034
   LET l_imbf.imbf035 = l_imaf.imaf035
   LET l_imbf.imbf051 = l_imaf.imaf051
   LET l_imbf.imbf052 = l_imaf.imaf052
   LET l_imbf.imbf053 = l_imaf.imaf053
   LET l_imbf.imbf054 = l_imaf.imaf054
   LET l_imbf.imbf055 = l_imaf.imaf055
   LET l_imbf.imbf056 = l_imaf.imaf056
   LET l_imbf.imbf057 = l_imaf.imaf057
   LET l_imbf.imbf058 = l_imaf.imaf058
   LET l_imbf.imbf059 = l_imaf.imaf059
   LET l_imbf.imbf061 = l_imaf.imaf061
   LET l_imbf.imbf062 = l_imaf.imaf062
   LET l_imbf.imbf063 = l_imaf.imaf063
   LET l_imbf.imbf064 = l_imaf.imaf064
   LET l_imbf.imbf071 = l_imaf.imaf071
   LET l_imbf.imbf072 = l_imaf.imaf072
   LET l_imbf.imbf073 = l_imaf.imaf073
   LET l_imbf.imbf074 = l_imaf.imaf074
   LET l_imbf.imbf081 = l_imaf.imaf081
   LET l_imbf.imbf082 = l_imaf.imaf082
   LET l_imbf.imbf083 = l_imaf.imaf083
   LET l_imbf.imbf084 = l_imaf.imaf084
   LET l_imbf.imbf091 = l_imaf.imaf091
   LET l_imbf.imbf092 = l_imaf.imaf092
   LET l_imbf.imbf093 = l_imaf.imaf093
   LET l_imbf.imbf094 = l_imaf.imaf094
   LET l_imbf.imbf095 = l_imaf.imaf095
   LET l_imbf.imbf096 = l_imaf.imaf096
   LET l_imbf.imbf101 = l_imaf.imaf101
   LET l_imbf.imbf102 = l_imaf.imaf102
   LET l_imbf.imbf111 = l_imaf.imaf111
   LET l_imbf.imbf112 = l_imaf.imaf112
   LET l_imbf.imbf113 = l_imaf.imaf113
   LET l_imbf.imbf114 = l_imaf.imaf114
   LET l_imbf.imbf115 = l_imaf.imaf115
   LET l_imbf.imbf116 = l_imaf.imaf116
   LET l_imbf.imbf117 = l_imaf.imaf117
   LET l_imbf.imbf118 = l_imaf.imaf118
   LET l_imbf.imbf121 = l_imaf.imaf121
   LET l_imbf.imbf122 = l_imaf.imaf122
   LET l_imbf.imbf123 = l_imaf.imaf123
   LET l_imbf.imbf124 = l_imaf.imaf124
   LET l_imbf.imbf125 = l_imaf.imaf125
   LET l_imbf.imbf126 = l_imaf.imaf126
   LET l_imbf.imbf127 = l_imaf.imaf127
   LET l_imbf.imbf141 = l_imaf.imaf141
   LET l_imbf.imbf142 = l_imaf.imaf142
   LET l_imbf.imbf143 = l_imaf.imaf143
   LET l_imbf.imbf144 = l_imaf.imaf144
   LET l_imbf.imbf145 = l_imaf.imaf145
   LET l_imbf.imbf146 = l_imaf.imaf146
   LET l_imbf.imbf147 = l_imaf.imaf147
   LET l_imbf.imbf148 = l_imaf.imaf148
   LET l_imbf.imbf149 = l_imaf.imaf149
   LET l_imbf.imbf151 = l_imaf.imaf151
   LET l_imbf.imbf152 = l_imaf.imaf152
   LET l_imbf.imbf153 = l_imaf.imaf153
   LET l_imbf.imbf154 = l_imaf.imaf154
   LET l_imbf.imbf155 = l_imaf.imaf155
   LET l_imbf.imbf156 = l_imaf.imaf156
   LET l_imbf.imbf157 = l_imaf.imaf157
   LET l_imbf.imbf161 = l_imaf.imaf161
   LET l_imbf.imbf162 = l_imaf.imaf162
   LET l_imbf.imbf163 = l_imaf.imaf163
   LET l_imbf.imbf164 = l_imaf.imaf164
   LET l_imbf.imbf165 = l_imaf.imaf165
   LET l_imbf.imbf171 = l_imaf.imaf171
   LET l_imbf.imbf172 = l_imaf.imaf172
   LET l_imbf.imbf173 = l_imaf.imaf173
   LET l_imbf.imbf174 = l_imaf.imaf174
   LET l_imbf.imbf175 = l_imaf.imaf175
   LET l_imbf.imbf176 = l_imaf.imaf176
   #add--2015/05/28 By shiun--(S)
   LET l_imbf.imbf177 = l_imaf.imaf177
   LET l_imbf.imbf178 = l_imaf.imaf178
   LET l_imbf.imbf179 = l_imaf.imaf179
   #add--2015/05/28 By shiun--(E)
   LET l_imbf.imbfownid = g_user
   LET l_imbf.imbfowndp = g_dept
   LET l_imbf.imbfcrtid = g_user
   LET l_imbf.imbfcrtdp = g_dept
   LET l_imbf.imbfcrtdt = cl_get_current()
   LET l_imbf.imbfmodid = g_user
   LET l_imbf.imbfmoddt = cl_get_current()
   LET l_imbf.imbfent = g_enterprise
   LET l_imbf.imbfsite = 'ALL'
   LET l_imbf.imbf001 = g_imba_m.imba001
   LET l_imbf.imbfdocno = g_imba_m.imbadocno
   #add--160511-00040#5 By shiun--(S)
   LET g_imba_m.imba101 = l_imbf.imbf153
   LET g_imba_m.imba104 = l_imbf.imbf053
   LET g_imba_m.imba105 = l_imbf.imbf112
   LET g_imba_m.imba106 = l_imbf.imbf113
   LET g_imba_m.imba107 = l_imbf.imbf143
   LET g_imba_m.imba124 = l_imbf.imbf017
   LET g_imba_m.imba145 = l_imbf.imbf144
   SELECT imag014 INTO g_imba_m.imba146
     FROM imag_t,ooef_t 
    WHERE ooefent = imagent 
      AND ooef001 = 'ALL'
      AND ooef017 = imagsite 
      AND imagent = g_enterprise
      AND imag001 = g_imba_m.imba001
   #add--160511-00040#5 By shiun--(E)
   LET l_time = cl_get_current()
   #INSERT INTO imbf_t VALUES(l_imbf.*)  #161124-00048#3   2016/12/08 By 08734 mark
   INSERT INTO imbf_t(imbfent,imbfsite,imbfdocno,imbf001,imbf011,imbf012,imbf013,imbf014,imbf015,imbf016,imbf017,imbf018,imbf021,imbf022,imbf023,imbf024,imbf025,imbf026,imbf027,imbf031,imbf032,imbf033,imbf034,imbf035,imbf051,imbf052,imbf053,imbf054,imbf055,imbf056,imbf057,imbf058,imbf059,imbf061,imbf062,imbf063,imbf064,imbf071,imbf072,imbf073,
       imbf074,imbf081,imbf082,imbf083,imbf084,imbf091,imbf092,imbf093,imbf094,imbf095,imbf096,imbf097,imbf101,imbf102,imbf111,imbf112,imbf113,imbf114,imbf115,imbf116,imbf117,imbf118,imbf121,imbf122,imbf123,imbf124,imbf125,imbf126,imbf127,imbf128,imbf141,imbf142,imbf143,imbf144,imbf145,imbf146,imbf147,imbf148,imbf149,
       imbf151,imbf152,imbf153,imbf154,imbf155,imbf156,imbf157,imbf158,imbf161,imbf162,imbf163,imbf164,imbf165,imbf166,imbf171,imbf172,imbf173,imbf174,imbf175,imbf176,imbfownid,imbfowndp,imbfcrtid,imbfcrtdt,imbfcrtdp,imbfmodid,imbfmoddt,imbfcnfid,imbfcnfdt,imbfpstid,imbfpstdt,imbfstus,imbf177,imbf178,imbf179,imbf130)
      VALUES(l_imbf.imbfent,l_imbf.imbfsite,l_imbf.imbfdocno,l_imbf.imbf001,l_imbf.imbf011,l_imbf.imbf012,l_imbf.imbf013,l_imbf.imbf014,l_imbf.imbf015,l_imbf.imbf016,l_imbf.imbf017,l_imbf.imbf018,l_imbf.imbf021,l_imbf.imbf022,l_imbf.imbf023,l_imbf.imbf024,l_imbf.imbf025,l_imbf.imbf026,l_imbf.imbf027,l_imbf.imbf031,l_imbf.imbf032,l_imbf.imbf033,l_imbf.imbf034,l_imbf.imbf035,l_imbf.imbf051,l_imbf.imbf052,l_imbf.imbf053,l_imbf.imbf054,l_imbf.imbf055,l_imbf.imbf056,l_imbf.imbf057,l_imbf.imbf058,l_imbf.imbf059,l_imbf.imbf061,l_imbf.imbf062,l_imbf.imbf063,l_imbf.imbf064,l_imbf.imbf071,l_imbf.imbf072,l_imbf.imbf073,
       l_imbf.imbf074,l_imbf.imbf081,l_imbf.imbf082,l_imbf.imbf083,l_imbf.imbf084,l_imbf.imbf091,l_imbf.imbf092,l_imbf.imbf093,l_imbf.imbf094,l_imbf.imbf095,l_imbf.imbf096,l_imbf.imbf097,l_imbf.imbf101,l_imbf.imbf102,l_imbf.imbf111,l_imbf.imbf112,l_imbf.imbf113,l_imbf.imbf114,l_imbf.imbf115,l_imbf.imbf116,l_imbf.imbf117,l_imbf.imbf118,l_imbf.imbf121,l_imbf.imbf122,l_imbf.imbf123,l_imbf.imbf124,l_imbf.imbf125,l_imbf.imbf126,l_imbf.imbf127,l_imbf.imbf128,l_imbf.imbf141,l_imbf.imbf142,l_imbf.imbf143,l_imbf.imbf144,l_imbf.imbf145,l_imbf.imbf146,l_imbf.imbf147,l_imbf.imbf148,l_imbf.imbf149,
       l_imbf.imbf151,l_imbf.imbf152,l_imbf.imbf153,l_imbf.imbf154,l_imbf.imbf155,l_imbf.imbf156,l_imbf.imbf157,l_imbf.imbf158,l_imbf.imbf161,l_imbf.imbf162,l_imbf.imbf163,l_imbf.imbf164,l_imbf.imbf165,l_imbf.imbf166,l_imbf.imbf171,l_imbf.imbf172,l_imbf.imbf173,l_imbf.imbf174,l_imbf.imbf175,l_imbf.imbf176,l_imbf.imbfownid,l_imbf.imbfowndp,l_imbf.imbfcrtid,l_imbf.imbfcrtdt,l_imbf.imbfcrtdp,l_imbf.imbfmodid,l_imbf.imbfmoddt,l_imbf.imbfcnfid,l_imbf.imbfcnfdt,l_imbf.imbfpstid,l_imbf.imbfpstdt,l_imbf.imbfstus,l_imbf.imbf177,l_imbf.imbf178,l_imbf.imbf179,l_imbf.imbf130)  #161124-00048#3   2016/12/08 By 08734 add
   IF SQLCA.sqlcode THEN
      LET r_success = FALSE
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = g_imba_m.imbadocno
      LET g_errparam.popup = TRUE
      CALL cl_err()

      RETURN r_success
   END IF
   UPDATE imbf_t SET imbfcrtdt = l_time,
                     imbfmodid = l_time
    WHERE imbfent = g_enterprise
      AND imbfsite = l_imbf.imbfsite
      AND imbf001 = l_imbf.imbf001
   IF SQLCA.sqlcode THEN
      LET r_success = FALSE
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = g_imba_m.imbadocno
      LET g_errparam.popup = TRUE
      CALL cl_err()

      RETURN r_success
   END IF   
   
   LET l_imbe.imbe011 = l_imae.imae011
   LET l_imbe.imbe012 = l_imae.imae012
   LET l_imbe.imbe013 = l_imae.imae013
   LET l_imbe.imbe014 = l_imae.imae014
   LET l_imbe.imbe015 = l_imae.imae015
   LET l_imbe.imbe016 = l_imae.imae016
   LET l_imbe.imbe017 = l_imae.imae017
   LET l_imbe.imbe018 = l_imae.imae018
   LET l_imbe.imbe019 = l_imae.imae019
   LET l_imbe.imbe020 = l_imae.imae020
   LET l_imbe.imbe021 = l_imae.imae021
   LET l_imbe.imbe022 = l_imae.imae022
   LET l_imbe.imbe023 = l_imae.imae023
   LET l_imbe.imbe031 = l_imae.imae031
   LET l_imbe.imbe032 = l_imae.imae032
   LET l_imbe.imbe033 = l_imae.imae033
   LET l_imbe.imbe034 = l_imae.imae034
   LET l_imbe.imbe035 = l_imae.imae035
   LET l_imbe.imbe036 = l_imae.imae036
   LET l_imbe.imbe037 = l_imae.imae037
   LET l_imbe.imbe041 = l_imae.imae041
   LET l_imbe.imbe042 = l_imae.imae042
   LET l_imbe.imbe051 = l_imae.imae051
   LET l_imbe.imbe052 = l_imae.imae052
   LET l_imbe.imbe061 = l_imae.imae061
   LET l_imbe.imbe062 = l_imae.imae062
   LET l_imbe.imbe063 = l_imae.imae063
   LET l_imbe.imbe064 = l_imae.imae064
   LET l_imbe.imbe065 = l_imae.imae065
   LET l_imbe.imbe066 = l_imae.imae066
   LET l_imbe.imbe071 = l_imae.imae071
   LET l_imbe.imbe072 = l_imae.imae072
   LET l_imbe.imbe073 = l_imae.imae073
   LET l_imbe.imbe074 = l_imae.imae074
   LET l_imbe.imbe075 = l_imae.imae075
   LET l_imbe.imbe076 = l_imae.imae076
   LET l_imbe.imbe077 = l_imae.imae077
   LET l_imbe.imbe078 = l_imae.imae078
   LET l_imbe.imbe079 = l_imae.imae079
   LET l_imbe.imbe080 = l_imae.imae080
   LET l_imbe.imbe081 = l_imae.imae081
   LET l_imbe.imbe082 = l_imae.imae082
   LET l_imbe.imbe083 = l_imae.imae083
   LET l_imbe.imbe084 = l_imae.imae084
   LET l_imbe.imbe085 = l_imae.imae085
   LET l_imbe.imbe091 = l_imae.imae091
   LET l_imbe.imbe092 = l_imae.imae092
   LET l_imbe.imbe101 = l_imae.imae101
   LET l_imbe.imbe102 = l_imae.imae102
   LET l_imbe.imbe103 = l_imae.imae103
   LET l_imbe.imbe104 = l_imae.imae104
   LET l_imbe.imbe111 = l_imae.imae111
   LET l_imbe.imbe112 = l_imae.imae112
   LET l_imbe.imbe113 = l_imae.imae113
   LET l_imbe.imbe114 = l_imae.imae114
   LET l_imbe.imbe115 = l_imae.imae115
   LET l_imbe.imbe116 = l_imae.imae116
   LET l_imbe.imbe117 = l_imae.imae117
   LET l_imbe.imbe118 = l_imae.imae118
   IF cl_null(l_imbe.imbe118) THEN
      LET l_imbe.imbe118 = 0
   END IF
   
   LET l_imbe.imbe119 = l_imae.imae119
   IF cl_null(l_imbe.imbe119) THEN
      LET l_imbe.imbe119 = 0
   END IF
   
   LET l_imbe.imbe120 = l_imae.imae120
   LET l_imbe.imbeownid = g_user
   LET l_imbe.imbeowndp = g_dept
   LET l_imbe.imbecrtid = g_user
   LET l_imbe.imbecrtdp = g_dept
   LET l_imbe.imbecrtdt = cl_get_current()
   LET l_imbe.imbemodid = g_user
   LET l_imbe.imbemoddt = cl_get_current()
   LET l_imbe.imbeent = g_enterprise
   LET l_imbe.imbesite = 'ALL'
   LET l_imbe.imbe001 = g_imba_m.imba001
   LET l_imbe.imbedocno = g_imba_m.imbadocno
   LET l_time = cl_get_current()
   #INSERT INTO imbe_t VALUES(l_imbe.*)  #161124-00048#3   2016/12/08 By 08734 mark
   INSERT INTO imbe_t(imbeent,imbesite,imbe001,imbe011,imbe012,imbe013,imbe014,imbe015,imbe016,imbe017,imbe018,imbe019,imbe020,imbe021,imbe022,imbe023,imbe031,imbe032,imbe033,imbe034,imbe035,imbe036,imbe037,imbe041,imbe042,imbe051,imbe052,imbe061,imbe062,imbe063,imbe064,imbe065,imbe066,imbe071,imbe072,
       imbe073,imbe074,imbe075,imbe076,imbe077,imbe078,imbe079,imbe080,imbe081,imbe082,imbe083,imbe084,imbe085,imbe091,imbe092,imbe101,imbe102,imbe103,imbe104,imbe111,imbe112,imbe113,imbe114,imbe115,imbe116,imbe117,imbe118,imbe119,imbe120,imbedocno,imbeownid,imbeowndp,imbecrtid,imbecrtdt,imbecrtdp,imbemodid,imbemoddt,imbecnfid,imbecnfdt,imbepstid,imbepstdt,imbeacti,imbestus)
      VALUES(l_imbe.imbeent,l_imbe.imbesite,l_imbe.imbe001,l_imbe.imbe011,l_imbe.imbe012,l_imbe.imbe013,l_imbe.imbe014,l_imbe.imbe015,l_imbe.imbe016,l_imbe.imbe017,l_imbe.imbe018,l_imbe.imbe019,l_imbe.imbe020,l_imbe.imbe021,l_imbe.imbe022,l_imbe.imbe023,l_imbe.imbe031,l_imbe.imbe032,l_imbe.imbe033,l_imbe.imbe034,l_imbe.imbe035,l_imbe.imbe036,l_imbe.imbe037,l_imbe.imbe041,l_imbe.imbe042,l_imbe.imbe051,l_imbe.imbe052,l_imbe.imbe061,l_imbe.imbe062,l_imbe.imbe063,l_imbe.imbe064,l_imbe.imbe065,l_imbe.imbe066,l_imbe.imbe071,l_imbe.imbe072,   #161124-00048#3   2016/12/08 By 08734 add
       l_imbe.imbe073,l_imbe.imbe074,l_imbe.imbe075,l_imbe.imbe076,l_imbe.imbe077,l_imbe.imbe078,l_imbe.imbe079,l_imbe.imbe080,l_imbe.imbe081,l_imbe.imbe082,l_imbe.imbe083,l_imbe.imbe084,l_imbe.imbe085,l_imbe.imbe091,l_imbe.imbe092,l_imbe.imbe101,l_imbe.imbe102,l_imbe.imbe103,l_imbe.imbe104,l_imbe.imbe111,l_imbe.imbe112,l_imbe.imbe113,l_imbe.imbe114,l_imbe.imbe115,l_imbe.imbe116,l_imbe.imbe117,l_imbe.imbe118,l_imbe.imbe119,l_imbe.imbe120,l_imbe.imbedocno,l_imbe.imbeownid,l_imbe.imbeowndp,l_imbe.imbecrtid,l_imbe.imbecrtdt,l_imbe.imbecrtdp,l_imbe.imbemodid,l_imbe.imbemoddt,l_imbe.imbecnfid,l_imbe.imbecnfdt,l_imbe.imbepstid,l_imbe.imbepstdt,l_imbe.imbeacti,l_imbe.imbestus)
   IF SQLCA.sqlcode THEN
      LET r_success = FALSE
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = g_imba_m.imbadocno
      LET g_errparam.popup = TRUE
      CALL cl_err()

      RETURN r_success
   END IF
   UPDATE imbe_t SET imbecrtdt = l_time,
                     imbemodid = l_time
    WHERE imbeent = g_enterprise
      AND imbesite = l_imbe.imbesite
      AND imbe001 = l_imbe.imbe001
   IF SQLCA.sqlcode THEN
      LET r_success = FALSE
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = g_imba_m.imbadocno
      LET g_errparam.popup = TRUE
      CALL cl_err()

      RETURN r_success
   END IF 
   
   LET l_time = cl_get_current()
   LET l_sql = " INSERT INTO imbg_t(imbgdocno,imbgent,imbgsite,imbg001,imbg011,imbg012,imbg013,imbg014,imbg015,imbgownid,imbgowndp,imbgcrtid,imbgcrtdp,imbgcrtdt,imbgmodid,imbgmoddt,imbgcnfid,imbgcnfdt,imbg024 ) ",  #xujing add imbg024 151117
               " SELECT '",g_imba_m.imbadocno,"',imagent,imagsite,imag001,imag011,imag012,imag013,imag014,imag015,'",g_user,"','",g_dept,"','",g_user,"','",g_dept,"',to_date('",l_time,"','yyyy-mm-dd hh24:mi:ss'),'",g_user,"',to_date('",l_time,"','yyyy-mm-dd hh24:mi:ss'),'','',imag024 ", #xujing add imag024 151117
               "   FROM imag_t,ooef_t ",
               "  WHERE ooefent = imagent AND ooef001 = 'ALL' ",
               "    AND ooef017 = imagsite ",
               "    AND imagent = '",g_enterprise,"' ",
               "    AND imag001 = '",g_imba_m.imba001,"' "
   PREPARE aimt300_ins_imbg_pre FROM l_sql
   EXECUTE aimt300_ins_imbg_pre 
   IF SQLCA.sqlcode THEN
      LET r_success = FALSE
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = g_imba_m.imbadocno
      LET g_errparam.popup = TRUE
      CALL cl_err()

      RETURN r_success
   END IF
   
   LET l_time = cl_get_current()
   #20150430--POLLY--MARK-(S)   
   #LET l_sql = " INSERT INTO imbh_t(imbhdocno,imbhent,imbhsite,imbh001,imbh011,imbh012,imbh013,imbh014,imbh015,imbh016,imbh017,imbh018,imbh019,imbhownid,imbhowndp,imbhcrtid,imbhcrtdp,imbhcrtdt,imbhmodid,imbhmoddt,imbhcnfid,imbhcnfdt) ",
   #            " SELECT '",g_imba_m.imbadocno,"',imahent,imahsite,imah001,imah011,imah012,imah013,imah014,imah015,imah016,imah017,imah018,imah019,'",g_user,"','",g_dept,"','",g_user,"','",g_dept,"',to_date('",l_time,"','yyyy-mm-dd hh24:mi:ss'),'",g_user,"',to_date('",l_time,"','yyyy-mm-dd hh24:mi:ss'),'',''  ",
   #            "   FROM imah_t ",
   #            "  WHERE imahsite = 'ALL' ",
   #            "    AND imahent = '",g_enterprise,"' ",
   #            "    AND imah001 = '",g_imba_m.imba001,"' "
   #PREPARE aimt300_ins_imbh_pre FROM l_sql
   #EXECUTE aimt300_ins_imbh_pre 
   #20150430--POLLY--MARK-(E)
   #20150430--POLLY--ADD-(S)
   LET l_sql = " INSERT INTO imbn_t(imbndocno,imbnent,imbnsite,imbn001,imbn011,imbn012,imbn013,imbn014,imbn021,imbn022,imbn023,imbn024,imbn025,imbn031,imbn032,imbn033,imbn034,imbnownid,imbnowndp,imbncrtid,imbncrtdp,imbncrtdt,imbnmodid,imbnmoddt,imbncnfid,imbncnfdt) ",
               " SELECT '",g_imba_m.imbadocno,"',imanent,imansite,iman001,iman011,iman012,iman013,iman014,iman021,iman022,iman023,iman024,iman025,iman031,iman032,iman033,iman034,'",g_user,"','",g_dept,"','",g_user,"','",g_dept,"',to_date('",l_time,"','yyyy-mm-dd hh24:mi:ss'),'",g_user,"',to_date('",l_time,"','yyyy-mm-dd hh24:mi:ss'),'',''  ",
               "   FROM iman_t ",
               "  WHERE imansite = 'ALL' ",
               "    AND imanent = '",g_enterprise,"' ",
               "    AND iman001 = '",g_imba_m.imba001,"' "
   PREPARE aimt300_ins_imbn_pre FROM l_sql
   EXECUTE aimt300_ins_imbn_pre    
   #20150430--POLLY--ADD-(E)
   IF SQLCA.sqlcode THEN
      LET r_success = FALSE
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = g_imba_m.imbadocno
      LET g_errparam.popup = TRUE
      CALL cl_err()
      RETURN r_success
   END IF

   RETURN r_success
END FUNCTION
################################################################################
# Descriptions...: 單位轉換率檢查
# Memo...........:
# Usage..........: CALL aimt300_chk_rate(p_unit)
# Input parameter: p_unit         需要轉換的資料
# Return code....: 無
# Date & Author..: 2013/12/02 By xumm
# Modify.........:
################################################################################
PRIVATE FUNCTION aimt300_chk_rate(p_unit)
DEFINE p_unit         LIKE imba_t.imba018
DEFINE r_success      LIKE type_t.num5
DEFINE r_rate         LIKE type_t.num26_10

       
    LET g_errno = ''
    LET r_rate = ''
    IF cl_null(p_unit) THEN RETURN END IF
    IF NOT cl_null(g_imba_m.imba001) THEN
        IF NOT cl_null(g_imba_m.imba006) THEN
           CALL s_aimi190_get_convert(g_imba_m.imba001,p_unit,g_imba_m.imba006) RETURNING r_success,r_rate
           IF NOT r_success THEN
              RETURN FALSE
           END IF
        END IF
    END IF
    RETURN TRUE   
END FUNCTION
################################################################################
# Descriptions...: 新增特征值资料
# Memo...........:
# Usage..........: CALL aimt300_ins_imbk()
# Input parameter: 無
# Return code....: 無
# Date & Author..: 2013/12/28 By xumm
# Modify.........:
################################################################################
PRIVATE FUNCTION aimt300_ins_imbk()
DEFINE l_sql            STRING
DEFINE r_success        LIKE type_t.num5
#DEFINE l_imeb           RECORD LIKE imeb_t.*  #161124-00048#3 2016/12/08 By 08734 mark
#161124-00048#3 2016/12/08 By 08734 add(S)
DEFINE l_imeb RECORD  #料件特徵群組單身檔
       imebent LIKE imeb_t.imebent, #企业编号
       imeb001 LIKE imeb_t.imeb001, #特征群组编号
       imeb002 LIKE imeb_t.imeb002, #项次
       imeb003 LIKE imeb_t.imeb003, #归属层级
       imeb004 LIKE imeb_t.imeb004, #类型
       imeb005 LIKE imeb_t.imeb005, #赋值方式
       imeb006 LIKE imeb_t.imeb006, #属性类型
       imeb007 LIKE imeb_t.imeb007, #码长
       imeb008 LIKE imeb_t.imeb008, #小数字数
       imeb009 LIKE imeb_t.imeb009, #默认值
       imeb010 LIKE imeb_t.imeb010, #最小限制
       imeb011 LIKE imeb_t.imeb011, #最大限制
       imeb012 LIKE imeb_t.imeb012, #二维录入
       imeb013 LIKE imeb_t.imeb013 #限定数据源
END RECORD
#161124-00048#3 2016/12/08 By 08734 add(E)
#DEFINE l_imbk           RECORD LIKE imbk_t.*  #161124-00048#3 2016/12/08 By 08734 mark
#161124-00048#3 2016/12/08 By 08734 add(S)
DEFINE l_imbk RECORD  #料件申請料號特徵檔
       imbkent LIKE imbk_t.imbkent, #企业编号
       imbk001 LIKE imbk_t.imbk001, #料件编号
       imbk002 LIKE imbk_t.imbk002, #特征类型
       imbk003 LIKE imbk_t.imbk003, #特征值
       imbkdocno LIKE imbk_t.imbkdocno #申请编号
END RECORD
#161124-00048#3 2016/12/08 By 08734 add(E)
DEFINE l_n              LIKE type_t.num5

   LET r_success = TRUE
   INITIALIZE l_imeb.* TO NULL
   
   #先刪掉再重新插入
   DELETE FROM imbk_t WHERE imbkent = g_enterprise AND imbkdocno = g_imba_m.imbadocno #141231-00009#1 add
   
   #LET l_sql = " SELECT * FROM imeb_t",  #161124-00048#3 2016/12/08 By 08734 mark
   LET l_sql = " SELECT imebent,imeb001,imeb002,imeb003,imeb004,imeb005,imeb006,imeb007,imeb008,imeb009,imeb010,imeb011,imeb012,imeb013 FROM imeb_t",  #161124-00048#3 2016/12/08 By 08734 add
               "  WHERE imebent = '",g_enterprise,"'",
               "    AND imeb001 = '",g_imba_m.imba005,"'",
               "    AND imeb003 = '1' "
   PREPARE aimt300_sel_imeb_p FROM l_sql
   DECLARE aimt300_sel_imeb_c CURSOR FOR aimt300_sel_imeb_p
   FOREACH aimt300_sel_imeb_c INTO l_imeb.*
      IF SQLCA.sqlcode THEN
         LET r_success = FALSE
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = 'sel_imeb'
         LET g_errparam.popup = TRUE
         CALL cl_err()

         RETURN r_success
      END IF
      INITIALIZE l_imbk.* TO NULL
      LET l_imbk.imbkent = g_enterprise
      LET l_imbk.imbkdocno = g_imba_m.imbadocno
      LET l_imbk.imbk001 = g_imba_m.imba001
      LET l_imbk.imbk002 = l_imeb.imeb004
      LET l_imbk.imbk003 = l_imeb.imeb009
      LET l_n = 0
      SELECT COUNT(*) INTO l_n
        FROM imbk_t
       WHERE imbkent = l_imbk.imbkent
         AND imbkdocno = l_imbk.imbkdocno
         AND imbk002 = l_imbk.imbk002
      IF l_n = 0 THEN
         #INSERT INTO imbk_t VALUES(l_imbk.*)  #161124-00048#3 2016/12/08 By 08734 mark
         INSERT INTO imbk_t(imbkent,imbk001,imbk002,imbk003,imbkdocno) VALUES(l_imbk.imbkent,l_imbk.imbk001,l_imbk.imbk002,l_imbk.imbk003,l_imbk.imbkdocno)  #161124-00048#3 2016/12/08 By 08734 add
         IF SQLCA.sqlcode THEN
            LET r_success = FALSE
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = SQLCA.sqlcode
            LET g_errparam.extend = 'ins_imbk'
            LET g_errparam.popup = TRUE
            CALL cl_err()

            RETURN r_success
         END IF
      ELSE
         UPDATE imbk_t SET imbk001= l_imbk.imbk001,
                           imbk003 = l_imbk.imbk003
          WHERE imbkent = l_imbk.imbkent
            AND imbkdocno = l_imbk.imbkdocno
            AND imbk002 = l_imbk.imbk002
         IF SQLCA.sqlcode THEN
            LET r_success = FALSE
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = SQLCA.sqlcode
            LET g_errparam.extend = 'upd_imbk'
            LET g_errparam.popup = TRUE
            CALL cl_err()

            RETURN r_success
         END IF
      END IF
   END FOREACH
   RETURN r_success
END FUNCTION
################################################################################
# Descriptions...: imbo_t單身參考欄位顯示
# Memo...........:
# Usage..........: CALL aimt300_imbo_desc()
# Input parameter: 無
# Return code....: 無
# Date & Author..: 2014/01/24 By xumm
# Modify.........:
################################################################################
PRIVATE FUNCTION aimt300_imbo_desc()
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_imbj4_d[l_ac].imbo002
   CALL ap_ref_array2(g_ref_fields,"SELECT oocal003 FROM oocal_t WHERE oocalent='"||g_enterprise||"' AND oocal001=? AND oocal002='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_imbj4_d[l_ac].imbo002_desc = g_rtn_fields[1]
   DISPLAY BY NAME g_imbj4_d[l_ac].imbo002_desc
END FUNCTION

#修改料號時，同時更新相關表的料號
PRIVATE FUNCTION aimt300_upd_imba001()
DEFINE r_success  LIKE type_t.num5

       LET r_success = TRUE
    
       UPDATE imbf_t 
           SET imbf001 = g_imba_m.imba001
         WHERE imbfent = g_enterprise 
           AND imbfdocno = g_imba_m.imbadocno
        IF SQLCA.sqlcode THEN
           INITIALIZE g_errparam TO NULL
           LET g_errparam.code = SQLCA.sqlcode
           LET g_errparam.extend = "upd_imbf"
           LET g_errparam.popup = TRUE
           CALL cl_err()
           LET r_success = FALSE
           RETURN r_success
        END IF 
        
        UPDATE imbe_t 
           SET imbe001 = g_imba_m.imba001
         WHERE imbeent = g_enterprise 
           AND imbedocno = g_imba_m.imbadocno
        IF SQLCA.sqlcode THEN
           INITIALIZE g_errparam TO NULL
           LET g_errparam.code = SQLCA.sqlcode
           LET g_errparam.extend = "upd_imbe"
           LET g_errparam.popup = TRUE
           CALL cl_err()
           LET r_success = FALSE
           RETURN r_success
        END IF  
        
        UPDATE imbj_t 
           SET imbj001 = g_imba_m.imba001
         WHERE imbjent = g_enterprise 
           AND imbjdocno = g_imba_m.imbadocno
        IF SQLCA.sqlcode THEN
           INITIALIZE g_errparam TO NULL
           LET g_errparam.code = SQLCA.sqlcode
           LET g_errparam.extend = "upd_imbj"
           LET g_errparam.popup = TRUE
           CALL cl_err()
           LET r_success = FALSE
           RETURN r_success
        END IF 
        
        UPDATE imbk_t 
           SET imbk001 = g_imba_m.imba001
         WHERE imbkent = g_enterprise 
           AND imbkdocno = g_imba_m.imbadocno
        IF SQLCA.sqlcode THEN
           INITIALIZE g_errparam TO NULL
           LET g_errparam.code = SQLCA.sqlcode
           LET g_errparam.extend = "upd_imbk"
           LET g_errparam.popup = TRUE
           CALL cl_err()
           LET r_success = FALSE
           RETURN r_success
        END IF
        
        UPDATE imbl_t 
           SET imbl001 = g_imba_m.imba001
         WHERE imblent = g_enterprise 
           AND imbldocno = g_imba_m.imbadocno
        IF SQLCA.sqlcode THEN
           INITIALIZE g_errparam TO NULL
           LET g_errparam.code = SQLCA.sqlcode
           LET g_errparam.extend = "upd_imbl"
           LET g_errparam.popup = TRUE
           CALL cl_err()
           LET r_success = FALSE
           RETURN r_success
        END IF 
        
        UPDATE imbm_t 
           SET imbm001 = g_imba_m.imba001
         WHERE imbment = g_enterprise 
           AND imbmdocno = g_imba_m.imbadocno
        IF SQLCA.sqlcode THEN
           INITIALIZE g_errparam TO NULL
           LET g_errparam.code = SQLCA.sqlcode
           LET g_errparam.extend = "upd_imbm"
           LET g_errparam.popup = TRUE
           CALL cl_err()
           LET r_success = FALSE
           RETURN r_success
        END IF
        
        UPDATE imbg_t 
           SET imbg001 = g_imba_m.imba001
         WHERE imbgent = g_enterprise 
           AND imbgdocno = g_imba_m.imbadocno
        IF SQLCA.sqlcode THEN
           INITIALIZE g_errparam TO NULL
           LET g_errparam.code = SQLCA.sqlcode
           LET g_errparam.extend = "upd_imbg"
           LET g_errparam.popup = TRUE
           CALL cl_err()
           LET r_success = FALSE
           RETURN r_success
        END IF
        
       #--150713--polly--add--(S) 
        UPDATE imbn_t 
           SET imbn001 = g_imba_m.imba001
         WHERE imbnent = g_enterprise 
           AND imbndocno = g_imba_m.imbadocno
        IF SQLCA.sqlcode THEN
           INITIALIZE g_errparam TO NULL
           LET g_errparam.code = SQLCA.sqlcode
           LET g_errparam.extend = "upd_imbn"
           LET g_errparam.popup = TRUE
           CALL cl_err()
           LET r_success = FALSE
           RETURN r_success
        END IF       
       #--150713--polly--add--(E)
       
        #add by lixiang 2015/12/03--begin--
        #同步更新單位檔中的料號
        UPDATE imbo_t 
           SET imbo001 = g_imba_m.imba001
         WHERE imboent = g_enterprise 
           AND imbodocno = g_imba_m.imbadocno
        IF SQLCA.sqlcode THEN
           INITIALIZE g_errparam TO NULL
           LET g_errparam.code = SQLCA.sqlcode
           LET g_errparam.extend = "upd_imbo"
           LET g_errparam.popup = TRUE
           CALL cl_err()
           LET r_success = FALSE
           RETURN r_success
        END IF     
        #add by lixiang 2015/12/03--begin--

#160511-00040#4-s
        #同步更新多條碼檔中的料號
        UPDATE imby_t 
           SET imby001 = g_imba_m.imba001
         WHERE imbyent = g_enterprise 
           AND imbydocno = g_imba_m.imbadocno
        IF SQLCA.sqlcode THEN
           INITIALIZE g_errparam TO NULL
           LET g_errparam.code = SQLCA.sqlcode
           LET g_errparam.extend = "upd_imby"
           LET g_errparam.popup = TRUE
           CALL cl_err()
           LET r_success = FALSE
           RETURN r_success
        END IF     
#160511-00040#4-e

        RETURN r_success
        
END FUNCTION

################################################################################
# Descriptions...: 料件確認後，會寄mail給相關負責人
# Memo...........: 
# Usage..........: CALL aimt300_send_mail()
# Input parameter: no
# Return code....: no
# Date & Author..: 
# Modify.........: 150410 by whitney no.150409-00008#1
################################################################################
PRIVATE FUNCTION aimt300_send_mail()
   DEFINE ls_tmp       STRING
   DEFINE li_result    LIKE type_t.num5
   DEFINE ls_file      STRING
   DEFINE lc_channel   base.Channel
   DEFINE ls_text      STRING
   DEFINE ls_path      STRING
   DEFINE l_imed  RECORD
       imed003    LIKE imed_t.imed003,
       imed004    LIKE imed_t.imed004,
       imed006    LIKE imed_t.imed006,
       imed007    LIKE imed_t.imed007
   END RECORD
   DEFINE l_str        STRING
   DEFINE l_imed003    LIKE type_t.chr10
   DEFINE l_gzzal001   LIKE gzzal_t.gzzal001

   #信件暫存檔案路徑
   LET ls_file = "aimt300Mail_",FGL_GETPID() USING "<<<<<",".txt"
   LET ls_file = os.Path.join(FGL_GETENV("TEMPDIR"),ls_file)

   IF os.Path.exists(ls_file) THEN
      IF os.Path.delete(ls_file) THEN END IF
   END IF
   
   INITIALIZE l_imed.* TO NULL
   DECLARE mail_send CURSOR FOR 
      SELECT imed003,imed004,imed006,imed007 FROM imed_t 
       WHERE imedent = g_enterprise
         AND imed001 = g_site
         AND imed002 = g_imba_m.imba003
   FOREACH mail_send INTO l_imed.imed003,l_imed.imed004,l_imed.imed006,l_imed.imed007
      IF SQLCA.sqlcode THEN
         EXIT FOREACH
      END IF
      
      IF cl_null(l_imed.imed007) THEN
         CONTINUE FOREACH
      END IF
      
      #職能
      INITIALIZE g_ref_fields TO NULL
      LET g_ref_fields[1] = l_imed.imed003
      CALL ap_ref_array2(g_ref_fields,"SELECT gzcbl004 FROM gzcbl_t WHERE gzcbl001='1017' AND gzcbl002=? AND gzcbl003='"||g_dlang||"'","") RETURNING g_rtn_fields
      LET l_imed003 = '', g_rtn_fields[1] , ''
      
      #全名
      INITIALIZE g_ref_fields TO NULL
      LET g_ref_fields[1] = l_imed.imed006
      CALL ap_ref_array2(g_ref_fields,"SELECT ooag011 FROM ooag_t WHERE ooagent='"||g_enterprise||"' AND ooag001=? ","") RETURNING g_rtn_fields
      LET l_str = '', g_rtn_fields[1] , ''
      #%1先生/小姐：
      LET ls_text = cl_getmsg_parm('aim-00235',g_lang,l_str),"<br>","<br>"
      #產品檢核類型
      INITIALIZE g_ref_fields TO NULL
      LET g_ref_fields[1] = l_imed.imed004
      CALL ap_ref_array2(g_ref_fields,"SELECT gzcbl004 FROM gzcbl_t WHERE gzcbl001='1007' AND gzcbl002=? AND gzcbl003='"||g_dlang||"'","") RETURNING g_rtn_fields
      LET l_str = '', g_rtn_fields[1] , ''
      #料件編號imaa001需做%1資料的%2檢查
      LET l_str = cl_getmsg_parm('aim-00236',g_lang,g_imba_m.imba001 ||'|'|| l_imed003 ||'|'|| l_str)
      LET ls_text = ls_text ,"&ensp;&ensp;" ,l_str,"<br>"
      #作業
      LET l_gzzal001 = ''
      CASE l_imed.imed003
         WHEN '1'
            LET l_gzzal001 = 'aimm211'
         WHEN '2'
            LET l_gzzal001 = 'aimm212'
         WHEN '3'
            LET l_gzzal001 = 'aimm213'
         WHEN '4'
            LET l_gzzal001 = 'aimm214'
         WHEN '5'
            LET l_gzzal001 = 'aimm215'
         WHEN '6'
            LET l_gzzal001 = 'aimm216'
#         WHEN '7'
#            LET l_gzzal001 = ''
         WHEN '8'
            LET l_gzzal001 = 'aimm210'
         OTHERWISE EXIT CASE
      END CASE
      #作業名
      INITIALIZE g_ref_fields TO NULL
      LET g_ref_fields[1] = l_gzzal001
      CALL ap_ref_array2(g_ref_fields,"SELECT gzzal003 FROM gzzal_t WHERE gzzal001=? AND gzzal002='"||g_dlang||"'","") RETURNING g_rtn_fields
      LET l_str = '', g_rtn_fields[1] , ''
      #請執行%1(%2)檢核資料的正確性
      LET l_str = cl_getmsg_parm('aim-00237',g_lang,l_gzzal001 ||'|'|| l_str)
      LET ls_text = ls_text ,"&ensp;&ensp;" ,l_str,"<br>"
      #若需調整資料請執行修改功能做修正
      LET l_str = cl_getmsg('aim-00238',g_lang)
      LET ls_text = ls_text ,"&ensp;&ensp;" ,l_str,"<br>"
      
      #信件檔案
      LET lc_channel = base.Channel.create()
      CALL lc_channel.openFile(ls_file CLIPPED, "w" )
      CALL lc_channel.setDelimiter("")
      CALL lc_channel.write(ls_text)
      CALL lc_channel.close()
      
      #料件主檔
      SELECT dzeal003 INTO g_xml.subject
        FROM dzeal_t
       WHERE dzeal001 = 'imaa_t'
         AND dzeal002 = g_dlang
      #據點%1資料檢核通知
      LET l_str = cl_getmsg_parm('aim-00234',g_lang,l_imed003)
      #信件主旨
      LET g_xml.subject = g_xml.subject,' ',g_today,' ',l_str
      #信件本文
      LET g_xml.body = ls_file
      #寄信人-必須要寫@後面的mail address
      LET g_xml.sender = "top18@digiwin.biz:TOP18_Admin"
      
      #收件者
      LET g_xml.recipient = l_imed.imed007
      
      #寄發mail
      #CALL cl_jmail() RETURNING ls_tmp    #170123-00049#1 mark
      #DISPLAY ls_tmp                      #170123-00049#1 mark
      CALL cl_send_mail(g_xml.recipient,g_xml.subject,g_xml.body)  #170123-00049#1

      INITIALIZE l_imed.* TO NULL
   END FOREACH

END FUNCTION

################################################################################
# Descriptions...: 自動編碼並預帶連動欄位值
# Memo...........:
# Usage..........: CALL aimt300_aooi390_default()
#                  
# Input parameter: 
#                : 
# Return code....: 
#                : 
# Date & Author..: 150310 By earl
# Modify.........:
################################################################################
PRIVATE FUNCTION aimt300_aooi390_default()
   DEFINE l_sql                STRING
   DEFINE l_str                STRING
   DEFINE l_i                  LIKE type_t.num5
   DEFINE l_success            LIKE type_t.num5
   DEFINE l_oofg_return    DYNAMIC ARRAY OF RECORD
                   oofg019     LIKE oofg_t.oofg019,   #field
                   oofg020     LIKE oofg_t.oofg020    #value
                           END RECORD

#   CALL s_aooi390_auto_no('1') RETURNING l_success,g_imba_m.imba001,l_oofg_return   #mark--2015/05/08 By shiun--
   CALL s_aooi390_gen('1') RETURNING l_success,g_imba_m.imba001,l_oofg_return   #add--2015/05/08 By shiun

   DISPLAY BY NAME g_imba_m.imba001
   
   IF NOT l_success THEN
      RETURN
   END IF
   
#   CALL s_transaction_begin()   #因為s_aooi390_auto_no中有commit    #mark--2015/05/08 By shiun--

   DELETE FROM aimt300_imba_tmp
   
   INSERT INTO aimt300_imba_tmp (imbaent,imbadocno,imbadocdt,imba000,imba900,imba901,imbastus,imba001, 
                                 imba002,imba009,imba003,imba004,imba005,imba006,imba010,imba126,imba127,imba131,imba128, 
                                 imba129,imba130,imba132,imba133,imba134,imba135,imba136,imba137,imba138,imba139,imba140, 
                                 imba141,imbaownid,imbaowndp,imbacrtid,imbacrtdp,imbacrtdt,imbamodid,imbamoddt,imbacnfid, 
                                 imbacnfdt,imba011,imba012,imba013,imba014,imba142,imba016,imba017,imba018,imba019, 
                                 imba020,imba021,imba022,imba023,imba024,imba025,imba026,imba027,imba028,imba029,imba030, 
                                 imba031,imba032,imba033,imba034,imba035,imba036,imba037,imba043,imba038,imba041,imba042, 
                                 imba044,imba122,imba045,imba123)
   VALUES (g_enterprise,g_imba_m.imbadocno,g_imba_m.imbadocdt,g_imba_m.imba000,g_imba_m.imba900, 
       g_imba_m.imba901,g_imba_m.imbastus,g_imba_m.imba001,g_imba_m.imba002,g_imba_m.imba009, 
       g_imba_m.imba003,g_imba_m.imba004,g_imba_m.imba005,g_imba_m.imba006,g_imba_m.imba010, 
       g_imba_m.imba126,g_imba_m.imba127,g_imba_m.imba131,g_imba_m.imba128,g_imba_m.imba129, 
       g_imba_m.imba130,g_imba_m.imba132,g_imba_m.imba133,g_imba_m.imba134,g_imba_m.imba135, 
       g_imba_m.imba136,g_imba_m.imba137,g_imba_m.imba138,g_imba_m.imba139,g_imba_m.imba140, 
       g_imba_m.imba141,g_imba_m.imbaownid,g_imba_m.imbaowndp,g_imba_m.imbacrtid,g_imba_m.imbacrtdp, 
       g_imba_m.imbacrtdt,g_imba_m.imbamodid,g_imba_m.imbamoddt,g_imba_m.imbacnfid,g_imba_m.imbacnfdt, 
       g_imba_m.imba011,g_imba_m.imba012,g_imba_m.imba013,g_imba_m.imba014,g_imba_m.imba142, 
       g_imba_m.imba016,g_imba_m.imba017,g_imba_m.imba018,g_imba_m.imba019,g_imba_m.imba020, 
       g_imba_m.imba021,g_imba_m.imba022,g_imba_m.imba023,g_imba_m.imba024,g_imba_m.imba025, 
       g_imba_m.imba026,g_imba_m.imba027,g_imba_m.imba028,g_imba_m.imba029,g_imba_m.imba030, 
       g_imba_m.imba031,g_imba_m.imba032,g_imba_m.imba033,g_imba_m.imba034,g_imba_m.imba035, 
       g_imba_m.imba036,g_imba_m.imba037,g_imba_m.imba043,g_imba_m.imba038,g_imba_m.imba041, 
       g_imba_m.imba042,g_imba_m.imba044,g_imba_m.imba122,g_imba_m.imba045,g_imba_m.imba123)

   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "aimt300_imba_tmp" 
      LET g_errparam.code   = SQLCA.sqlcode 
      LET g_errparam.popup  = TRUE 
      CALL cl_err()

      RETURN
   END IF

   FOR l_i = 1 TO l_oofg_return.getLength()
      #無設定
      IF cl_null(l_oofg_return[l_i].oofg019) THEN
         CONTINUE FOR
      END IF
      
      #開頭為imaa時，自動當成imba
      LET l_str = l_oofg_return[l_i].oofg019
      CALL cl_str_replace_multistr(l_str,"imaa","imba") RETURNING l_str
      LET l_oofg_return[l_i].oofg019 = l_str

      LET l_sql = "UPDATE aimt300_imba_tmp",
                  "   SET ",l_oofg_return[l_i].oofg019," = '",l_oofg_return[l_i].oofg020,"'"
      PREPARE aimt300_aooi390_pre02 FROM l_sql
      EXECUTE aimt300_aooi390_pre02
      FREE aimt300_aooi390_pre02

   END FOR

   LET l_sql = " SELECT UNIQUE t0.imbadocno,t0.imbadocdt,t0.imba000,t0.imba900,t0.imba901,t0.imbastus, 
                               t0.imba001,t0.imba002,t0.imba009,t0.imba003,t0.imba004,t0.imba005,t0.imba006,t0.imba010,t0.imba126, 
                               t0.imba127,t0.imba131,t0.imba128,t0.imba129,t0.imba130,t0.imba132,t0.imba133,t0.imba134,t0.imba135, 
                               t0.imba136,t0.imba137,t0.imba138,t0.imba139,t0.imba140,t0.imba141,t0.imbaownid,t0.imbaowndp,t0.imbacrtid, 
                               t0.imbacrtdp,t0.imbacrtdt,t0.imbamodid,t0.imbamoddt,t0.imbacnfid,t0.imbacnfdt,t0.imba011,t0.imba012, 
                               t0.imba013,t0.imba014,t0.imba142,t0.imba016,t0.imba017,t0.imba018,t0.imba019,t0.imba020,t0.imba021, 
                               t0.imba022,t0.imba023,t0.imba024,t0.imba025,t0.imba026,t0.imba027,t0.imba028,t0.imba029,t0.imba030, 
                               t0.imba031,t0.imba032,t0.imba033,t0.imba034,t0.imba035,t0.imba036,t0.imba037,t0.imba043,t0.imba038, 
                               t0.imba041,t0.imba042,t0.imba044,t0.imba122,t0.imba045,t0.imba123,t1.ooag011 ,t2.ooefl003 ,t3.rtaxl003 , 
                               t4.oocql004 ,t5.imeal003 ,t6.oocal003 ,t7.oocql004 ,t8.ooag011 ,t9.ooefl003 ,t10.ooag011 ,t11.ooefl003 , 
                               t12.ooag011 ,t13.ooag011 ,t14.ooefl003 ,t15.oocal003 ,t16.oocal003 ,t17.oocal003 ,t18.oocal003 , 
                               t19.oocql004 ,t20.oocgl003",
               " FROM aimt300_imba_tmp t0",
               " LEFT JOIN ooag_t t1 ON t1.ooagent='"||g_enterprise||"' AND t1.ooag001=t0.imba900  ",
               " LEFT JOIN ooefl_t t2 ON t2.ooeflent='"||g_enterprise||"' AND t2.ooefl001=t0.imba901 AND t2.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN rtaxl_t t3 ON t3.rtaxlent='"||g_enterprise||"' AND t3.rtaxl001=t0.imba009 AND t3.rtaxl002='"||g_dlang||"' ",
               " LEFT JOIN oocql_t t4 ON t4.oocqlent='"||g_enterprise||"' AND t4.oocql001='200' AND t4.oocql002=t0.imba003 AND t4.oocql003='"||g_dlang||"' ",
               " LEFT JOIN imeal_t t5 ON t5.imealent='"||g_enterprise||"' AND t5.imeal001=t0.imba005 AND t5.imeal002='"||g_dlang||"' ",
               " LEFT JOIN oocal_t t6 ON t6.oocalent='"||g_enterprise||"' AND t6.oocal001=t0.imba006 AND t6.oocal002='"||g_dlang||"' ",
               " LEFT JOIN oocql_t t7 ON t7.oocqlent='"||g_enterprise||"' AND t7.oocql001='210' AND t7.oocql002=t0.imba010 AND t7.oocql003='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t8 ON t8.ooagent='"||g_enterprise||"' AND t8.ooag001=t0.imbaownid  ",
               " LEFT JOIN ooefl_t t9 ON t9.ooeflent='"||g_enterprise||"' AND t9.ooefl001=t0.imbaowndp AND t9.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t10 ON t10.ooagent='"||g_enterprise||"' AND t10.ooag001=t0.imbacrtid  ",
               " LEFT JOIN ooefl_t t11 ON t11.ooeflent='"||g_enterprise||"' AND t11.ooefl001=t0.imbacrtdp AND t11.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t12 ON t12.ooagent='"||g_enterprise||"' AND t12.ooag001=t0.imbamodid  ",
               " LEFT JOIN ooag_t t13 ON t13.ooagent='"||g_enterprise||"' AND t13.ooag001=t0.imbacnfid  ",
               " LEFT JOIN ooefl_t t14 ON t14.ooeflent='"||g_enterprise||"' AND t14.ooefl001=t0.imba142 AND t14.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN oocal_t t15 ON t15.oocalent='"||g_enterprise||"' AND t15.oocal001=t0.imba018 AND t15.oocal002='"||g_dlang||"' ",
               " LEFT JOIN oocal_t t16 ON t16.oocalent='"||g_enterprise||"' AND t16.oocal001=t0.imba022 AND t16.oocal002='"||g_dlang||"' ",
               " LEFT JOIN oocal_t t17 ON t17.oocalent='"||g_enterprise||"' AND t17.oocal001=t0.imba029 AND t17.oocal002='"||g_dlang||"' ",
               " LEFT JOIN oocal_t t18 ON t18.oocalent='"||g_enterprise||"' AND t18.oocal001=t0.imba032 AND t18.oocal002='"||g_dlang||"' ",
               " LEFT JOIN oocql_t t19 ON t19.oocqlent='"||g_enterprise||"' AND t19.oocql001='2000' AND t19.oocql002=t0.imba122 AND t19.oocql003='"||g_dlang||"' ",
               " LEFT JOIN oocgl_t t20 ON t20.oocglent='"||g_enterprise||"' AND t20.oocgl001=t0.imba045 AND t20.oocgl002='"||g_dlang||"' "
   PREPARE aimt300_aooi390_pre03 FROM l_sql
   
   EXECUTE aimt300_aooi390_pre03 INTO g_imba_m.imbadocno,g_imba_m.imbadocdt, 
       g_imba_m.imba000,g_imba_m.imba900,g_imba_m.imba901,g_imba_m.imbastus,g_imba_m.imba001,g_imba_m.imba002, 
       g_imba_m.imba009,g_imba_m.imba003,g_imba_m.imba004,g_imba_m.imba005,g_imba_m.imba006,g_imba_m.imba010, 
       g_imba_m.imba126,g_imba_m.imba127,g_imba_m.imba131,g_imba_m.imba128,g_imba_m.imba129,g_imba_m.imba130, 
       g_imba_m.imba132,g_imba_m.imba133,g_imba_m.imba134,g_imba_m.imba135,g_imba_m.imba136,g_imba_m.imba137, 
       g_imba_m.imba138,g_imba_m.imba139,g_imba_m.imba140,g_imba_m.imba141,g_imba_m.imbaownid,g_imba_m.imbaowndp, 
       g_imba_m.imbacrtid,g_imba_m.imbacrtdp,g_imba_m.imbacrtdt,g_imba_m.imbamodid,g_imba_m.imbamoddt, 
       g_imba_m.imbacnfid,g_imba_m.imbacnfdt,g_imba_m.imba011,g_imba_m.imba012,g_imba_m.imba013,g_imba_m.imba014, 
       g_imba_m.imba142,g_imba_m.imba016,g_imba_m.imba017,g_imba_m.imba018,g_imba_m.imba019,g_imba_m.imba020, 
       g_imba_m.imba021,g_imba_m.imba022,g_imba_m.imba023,g_imba_m.imba024,g_imba_m.imba025,g_imba_m.imba026, 
       g_imba_m.imba027,g_imba_m.imba028,g_imba_m.imba029,g_imba_m.imba030,g_imba_m.imba031,g_imba_m.imba032, 
       g_imba_m.imba033,g_imba_m.imba034,g_imba_m.imba035,g_imba_m.imba036,g_imba_m.imba037,g_imba_m.imba043, 
       g_imba_m.imba038,g_imba_m.imba041,g_imba_m.imba042,g_imba_m.imba044,g_imba_m.imba122,g_imba_m.imba045, 
       g_imba_m.imba123,g_imba_m.imba900_desc,g_imba_m.imba901_desc,g_imba_m.imba009_desc,g_imba_m.imba003_desc, 
       g_imba_m.imba005_desc,g_imba_m.imba006_desc,g_imba_m.imba010_desc,g_imba_m.imbaownid_desc,g_imba_m.imbaowndp_desc, 
       g_imba_m.imbacrtid_desc,g_imba_m.imbacrtdp_desc,g_imba_m.imbamodid_desc,g_imba_m.imbacnfid_desc, 
       g_imba_m.imba142_desc,g_imba_m.imba018_desc,g_imba_m.imba022_desc,g_imba_m.imba029_desc,g_imba_m.imba032_desc, 
       g_imba_m.imba122_desc,g_imba_m.imba045_desc
       
   FREE aimt300_aooi390_pre03
   
   CALL aimt300_show()
END FUNCTION

 
{</section>}
 
