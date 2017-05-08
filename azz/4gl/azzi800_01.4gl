#該程式未解開Section, 採用最新樣板產出!
{<section id="azzi800_01.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0033(2014-12-29 16:47:50), PR版次:0033(2016-12-26 13:34:20)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000582
#+ Filename...: azzi800_01
#+ Description: 設定使用者可用的營運據點
#+ Creator....: 01258(2013-08-16 10:57:13)
#+ Modifier...: 01856 -SD/PR- 01856
 
{</section>}
 
{<section id="azzi800_01.global" >}
#應用 p00 樣板自動產生(Version:5)
#add-point:填寫註解說明 name="main.memo"
#160422-00024 #1  2016/04/25 By jrg542   azzi850 azzi800 不可選用 azzi850 失效的資料。azzi850 做失效前要檢查azzi800無使用，才可失效
#160318-00025 #47 2016/04/29 By 07959    將重複內容的錯誤訊息置換為公用錯誤訊息(r.v)
#160616-00004 #1  2016/06/14 By jrg542   新增同一員工編號的不同用戶編號，增加同一角色會報錯
#160630-00009 #1  2016/06/30 By Sarah    azzi800_01有新增或修改後要同步回寫gxza_t的最近修改者與最近修改日期
#160802-00042 #1  2016/08/02 By jrg542   3.當 azzi800 配置可拜訪據點允許下展時 ，登入畫面的營運據點沒有可挑選到下展後的所有據點
#160815-00018 #1  2016/08/15 By dorislai 修正azzi800的頁籤-角色據點設定，刪除資料時，不會更新最近修改者、最近修改日期的問題
#161107-00022 #1  2016/11/07 By jrg542   修改員工編號，會跳出預設登入據點不存在據點列表內
#161130-00018 #1  2016/11/07 By jrg542   修改第一個單身使用者”角色”權限時不要把第二個單身的據點資料清掉
#161220-00024 #1  2016/12/20 By jrg542   新增據點編號"ALL"不可以新增 一併處理 BUG_外部問題修正單161220-00042 
#161225-00003 #3  2016/12/26 By jrg542   azzi800點選資料權限的設定時，必須回去原始程式查看是否存在 g_data_owner，沒有就不給設定 (只能為 0.不管制)
#end add-point
#add-point:填寫註解說明(客製用) name="main.memo_customerization"

#end add-point
 
IMPORT os
#add-point:增加匯入項目 name="main.import"
IMPORT util
#end add-point
 
SCHEMA ds
 
GLOBALS "../../cfg/top_global.inc"
#add-point:增加匯入變數檔 name="global.inc"

#end add-point
 
{</section>}
 
{<section id="azzi800_01.free_style_variable" >}
#add-point:free_style模組變數(Module Variable) name="free_style.variable"
TYPE type_g_gzxa_m RECORD
   gzxa001 LIKE gzxa_t.gzxa001,
   gzxa002 LIKE gzxa_t.gzxa002,
   gzxa003 LIKE gzxa_t.gzxa003,
   gzxa003_desc LIKE type_t.chr80,
   gzxastus LIKE gzxa_t.gzxastus,
   gzxa010 LIKE gzxa_t.gzxa010,
   gzxa007 LIKE gzxa_t.gzxa007,
   gzxa007_desc LIKE type_t.chr80, 
   gzxa011 LIKE gzxa_t.gzxa011,
   gzxa011_desc LIKE type_t.chr80,
   #gzxa012 LIKE gzxa_t.gzxa012,
   gzxa013 LIKE gzxa_t.gzxa013,
   gzxa013_desc LIKE type_t.chr80,
   #gzxa004 LIKE gzxa_t.gzxa004,
   gzxa005 LIKE gzxa_t.gzxa005,
   #gzxa006 LIKE gzxa_t.gzxa006,
   gzxa008 LIKE gzxa_t.gzxa008,
   gzxa009 LIKE gzxa_t.gzxa009,
   gzxa016 LIKE gzxa_t.gzxa016,
   gzxa017 LIKE gzxa_t.gzxa017,
   gzxz002 LIKE gzxz_t.gzxz002,
   gzxz003 LIKE gzxz_t.gzxz003,
   gzxd004 LIKE gzxd_t.gzxd004,
   gzxz005 LIKE gzxz_t.gzxz005,
   gzxz006 LIKE gzxz_t.gzxz006,
   gzxz007 LIKE gzxz_t.gzxz007, 
   gzxz008 LIKE gzxz_t.gzxz008, 
   gzxz009 LIKE gzxz_t.gzxz009, 
   gzxz010 LIKE gzxz_t.gzxz010, 
   gzxaownid LIKE gzxa_t.gzxaownid,
   gzxaownid_desc LIKE type_t.chr80,
   gzxaowndp LIKE gzxa_t.gzxaowndp,
   gzxaowndp_desc LIKE type_t.chr80,
   gzxacrtid LIKE gzxa_t.gzxacrtid,
   gzxacrtid_desc LIKE type_t.chr80,
   gzxacrtdp LIKE gzxa_t.gzxacrtdp,
   gzxacrtdp_desc LIKE type_t.chr80,
   gzxacrtdt DATETIME YEAR TO SECOND,
   gzxamodid LIKE gzxa_t.gzxamodid,
   gzxamodid_desc LIKE type_t.chr80,
   gzxamoddt DATETIME YEAR TO SECOND
       END RECORD

GLOBALS
   DEFINE g_gzxa_m        type_g_gzxa_m
   DEFINE g_detail_insert   LIKE type_t.num5   # 單身的新增權限
   DEFINE g_detail_delete   LIKE type_t.num5   # 單身的刪除權限
   DEFINE g_wc2_01          STRING             # 單身一QBE條件
   DEFINE g_wc2_02          STRING             # 單身二QBE條件
   DEFINE g_wc3_01          STRING             # 單身三QBE條件  配置可拜訪據點
   DEFINE g_detail_idx_01   LIKE type_t.num5   # 單身 所在筆數(所有資料)
   DEFINE g_detail_idx_03   LIKE type_t.num5   # 單身 所在筆數(所有資料)
   DEFINE g_detail_cnt_01   LIKE type_t.num5   # 單身 總筆數(所有資料)
   DEFINE g_detail_cnt_03   LIKE type_t.num5   # 單身 總筆數(所有資料)
   DEFINE g_gzxa003_d       LIKE gzxa_t.gzxa003 # 新增功能傳遞到子程式Key值
   DEFINE g_appoint_idx     LIKE type_t.num5   # 指定進入單身行數
   DEFINE l_ac_01              LIKE type_t.num5              #目前處理的ARRAY CNT
   DEFINE l_ac_03              LIKE type_t.num5              #目前處理的ARRAY CNT
   DEFINE g_gzxb002_d       LIKE gzxb_t.gzxb002 # 新增功能傳遞到子程式Key值
   DEFINE g_gzxb003_d       LIKE gzxb_t.gzxb003 # 新增功能傳遞到子程式Key值
   DEFINE g_update          BOOLEAN                       #確定單頭/身是否異動過
   
   TYPE type_g_gzxb_d RECORD
   gzxbstus LIKE gzxb_t.gzxbstus,
   gzxb001 LIKE gzxb_t.gzxb001,
   gzxb002 LIKE gzxb_t.gzxb002,
   gzxb003 LIKE gzxb_t.gzxb003,
   gzxb003_desc LIKE type_t.chr80,  
   gzxb004 LIKE gzxb_t.gzxb004,
   gzxb005 LIKE gzxb_t.gzxb005,
   gzxh004 LIKE type_t.chr500,
   gzxb006 LIKE gzxb_t.gzxb006,
   gzxb007 LIKE gzxb_t.gzxb007,
   gzxb008 LIKE gzxb_t.gzxb008
       END RECORD
   
   TYPE type_g_gzxc_d RECORD
   gzxcstus LIKE gzxc_t.gzxcstus,
   gzxc001 LIKE gzxc_t.gzxc001,
   gzxc002 LIKE gzxc_t.gzxc002,
   gzxc003 LIKE gzxc_t.gzxc003,
   gzxc004 LIKE gzxc_t.gzxc004,
   gzxc004_desc LIKE type_t.chr80,
   gzxc005 LIKE gzxc_t.gzxc005,
   gzxc006 LIKE gzxc_t.gzxc006,
   gzxc007 LIKE gzxc_t.gzxc007
       END RECORD
       
   DEFINE g_gzxc_d          DYNAMIC ARRAY OF type_g_gzxc_d       
   DEFINE g_gzxc_d_t        type_g_gzxc_d
   DEFINE g_gzxc_d_o        type_g_gzxc_d
   DEFINE g_gzxb_d          DYNAMIC ARRAY OF type_g_gzxb_d
   DEFINE g_gzxb_d_t        type_g_gzxb_d
   DEFINE g_gzxb_d_o        type_g_gzxb_d
END GLOBALS
DEFINE g_log1                STRING                        #log用
DEFINE g_log2                STRING                        #log用
{<Module define>}

#單身 type 宣告
 
       
 TYPE type_g_gzxb_d2 RECORD
   gzxbstus LIKE gzxb_t.gzxbstus,
   gzxb001 LIKE gzxb_t.gzxb001,
   gzxb002 LIKE gzxb_t.gzxb002,
   gzxb003 LIKE gzxb_t.gzxb003,
   gzxb003_desc LIKE type_t.chr80,  
   gzxb004 LIKE gzxb_t.gzxb004,
   gzxb005 LIKE gzxb_t.gzxb005,
   gzxh004 LIKE type_t.chr500,
   gzxb006 LIKE gzxb_t.gzxb006,
   gzxb007 LIKE gzxb_t.gzxb007,
   gzxb008 LIKE gzxb_t.gzxb008,
   gzxbownid LIKE gzxb_t.gzxbownid,
   gzxbowndp LIKE gzxb_t.gzxbowndp,
   gzxbcrtid LIKE gzxb_t.gzxbcrtid,
   gzxbcrtdp LIKE gzxb_t.gzxbcrtdp,
   gzxbcrtdt LIKE gzxb_t.gzxbcrtdt,
   gzxbmodid LIKE gzxb_t.gzxbmodid,
   gzxbmoddt LIKE gzxb_t.gzxbmoddt
       END RECORD 
       
TYPE type_g_gzxc_d2 RECORD
   gzxcstus LIKE gzxc_t.gzxcstus,
   gzxc001 LIKE gzxc_t.gzxc001,
   gzxc002 LIKE gzxc_t.gzxc002,
   gzxc003 LIKE gzxc_t.gzxc003,
   gzxc004 LIKE gzxc_t.gzxc004,
   gzxc004_desc LIKE type_t.chr80,
   gzxc005 LIKE gzxc_t.gzxc005,
   gzxc006 LIKE gzxc_t.gzxc006,
   gzxc007 LIKE gzxc_t.gzxc007,
   gzxcownid LIKE gzxc_t.gzxcownid,
   gzxcowndp LIKE gzxc_t.gzxcowndp,
   gzxccrtid LIKE gzxc_t.gzxccrtid,
   gzxccrtdp LIKE gzxc_t.gzxccrtdp,
   gzxccrtdt LIKE gzxc_t.gzxccrtdt,
   gzxcmodid LIKE gzxc_t.gzxcmodid,
   gzxcmoddt LIKE gzxc_t.gzxcmoddt
       END RECORD 
#無單身append欄位定義

#模組變數(Module Variables)
TYPE type_g_gzxg_m RECORD
   gzxgstus  LIKE gzxg_t.gzxgstus,
   gzxg001   LIKE gzxg_t.gzxg001,
   gzxg002   LIKE gzxg_t.gzxg002,
   gzxgownid LIKE gzxg_t.gzxgownid,
   gzxgowndp LIKE gzxg_t.gzxgowndp,
   gzxgcrtid LIKE gzxg_t.gzxgcrtid,
   gzxgcrtdp LIKE gzxg_t.gzxgcrtdp,
   gzxgcrtdt LIKE gzxg_t.gzxgcrtdt,
   gzxgmodid LIKE gzxg_t.gzxgmodid,
   gzxgmoddt LIKE gzxg_t.gzxgmoddt
       END RECORD   
DEFINE g_wc2                STRING
DEFINE g_sql                STRING
DEFINE g_forupd_sql         STRING                        #SELECT ... FOR UPDATE SQL
DEFINE g_before_input_done  LIKE type_t.num5
DEFINE g_cnt                LIKE type_t.num10
DEFINE l_ac                 LIKE type_t.num5              #目前處理的ARRAY CNT
DEFINE g_curr_diag          ui.Dialog                     #Current Dialog
DEFINE gwin_curr            ui.Window                     #Current Window
DEFINE gfrm_curr            ui.Form                       #Current Form
DEFINE g_temp_idx           LIKE type_t.num5              #單身 所在筆數(暫存用)
DEFINE g_detail_idx         LIKE type_t.num5              #單身 所在筆數(所有資料)
DEFINE g_detail_cnt         LIKE type_t.num5              #單身 總筆數(所有資料)
DEFINE g_ref_fields         DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
DEFINE g_rtn_fields         DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
DEFINE g_ref_vars           DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
DEFINE gs_keys              DYNAMIC ARRAY OF VARCHAR(500) #同步資料用陣列
DEFINE gs_keys_bak          DYNAMIC ARRAY OF VARCHAR(500) #同步資料用陣列
DEFINE g_insert             LIKE type_t.chr5              #是否導到其他page
DEFINE g_error_show         LIKE type_t.num5

#多table用wc
DEFINE g_wc_table           STRING

#DEFINE l_ac_01              LIKE type_t.num5              #目前處理的ARRAY CNT
#DEFINE l_ac_03              LIKE type_t.num5              #目前處理的ARRAY CNT
DEFINE g_temp_idx_01        LIKE type_t.num5              #單身 所在筆數(暫存用)
DEFINE g_temp_idx_03        LIKE type_t.num5              #單身 所在筆數(暫存用)
DEFINE gs_gzxb002           STRING
{</Module define>}
#end add-point
 
{</section>}
 
{<section id="azzi800_01.global_variable" >}
#add-point:自定義模組變數(Module Variable) name="global.variable"

#end add-point
 
{</section>}
 
{<section id="azzi800_01.other_dialog" >}
################################################################################
# Descriptions...: 單身顯示SUBDIALOG共用函式
# Memo...........:
# Usage..........: CALL azzi800_01_display()                RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 日期 By 作者
# Modify.........:
################################################################################
DIALOG azzi800_01_display()
   DISPLAY ARRAY g_gzxb_d TO s_detail1_01.* ATTRIBUTE(COUNT=g_detail_cnt_01)

      BEFORE DISPLAY
         CALL azzi800_01_show_scc()
         CALL FGL_SET_ARR_CURR(g_detail_idx_01)
         #單身不連動, 所以進入單身時, 要重新顯示單身筆數
         DISPLAY g_detail_idx_01, g_detail_cnt_01 TO FORMONLY.idx, FORMONLY.cnt
      BEFORE ROW
         LET g_detail_idx_01 = DIALOG.getCurrentRow("s_detail1_01")
         LET l_ac_01 = g_detail_idx_01
         LET g_temp_idx_01 = l_ac_01
         DISPLAY g_detail_idx_01 TO FORMONLY.idx
         CALL cl_show_fld_cont()
         LET g_gzxb002_d = g_gzxb_d[l_ac_01].gzxb002  
         LET g_gzxb003_d = g_gzxb_d[l_ac_01].gzxb003   
         CALL azzi800_01_b2_fill(g_wc3_01)
      #自訂ACTION(detail_show,page_1)

   END DISPLAY
END DIALOG
################################################################################
# Descriptions...: 描述说明
# Memo...........:
# Usage..........: azzi800_01_1_display()
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 日期 By 作者
# Modify.........:
################################################################################
DIALOG azzi800_01_1_display()
   DISPLAY ARRAY g_gzxc_d TO s_detail1_03.* ATTRIBUTE(COUNT=g_detail_cnt_03)

      BEFORE DISPLAY
         CALL FGL_SET_ARR_CURR(g_detail_idx_01)
         #單身不連動, 所以進入單身時, 要重新顯示單身筆數
         DISPLAY g_detail_idx_03, g_detail_cnt_03 TO FORMONLY.idx, FORMONLY.cnt
      BEFORE ROW
         LET g_detail_idx_03 = DIALOG.getCurrentRow("s_detail1_03")
         LET l_ac_03 = g_detail_idx_03
         LET g_temp_idx_03 = l_ac_03
         DISPLAY g_detail_idx_03 TO FORMONLY.idx
         CALL cl_show_fld_cont()

      #自訂ACTION(detail_show,page_1)

   END DISPLAY
END DIALOG
################################################################################
# Descriptions...: 配置可拜訪據點
# Memo...........:
# Usage..........: azzi800_01_1_input()
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 日期 By 作者
# Modify.........:
################################################################################
DIALOG azzi800_01_1_input()
   DEFINE l_count        LIKE type_t.num5
   DEFINE l_cmd          LIKE type_t.chr5
   DEFINE p_gzxb002      LIKE gzxb_t.gzxb002
   #DEFINE l_gzxc         RECORD LIKE gzxc_t.*
   DEFINE l_gzxc          type_g_gzxc_d2 
   DEFINE l_lock_sw_1      LIKE type_t.chr1 
   DEFINE l_success      LIKE type_t.num5
   DEFINE l_wc           STRING
   DEFINE l_n            LIKE type_t.num5
   DEFINE l_rec_b2        LIKE type_t.num5
   DEFINE l_forupd_sql   STRING
   DEFINE li_chk         LIKE type_t.num5  #確認是否取消單身刪除
   DEFINE li_cnt         LIKE type_t.num5  #
   
   INPUT ARRAY g_gzxc_d FROM s_detail1_03.*
          ATTRIBUTE(COUNT = g_detail_cnt_03,MAXCOUNT = g_max_rec,WITHOUT DEFAULTS,
                  INSERT ROW = g_detail_insert,
                  DELETE ROW = g_detail_delete,
                  APPEND ROW = g_detail_insert)

         #自訂ACTION(detail_input,page_1)


         BEFORE INPUT
            #add-point:單身輸入前處理

            LET l_forupd_sql = " SELECT gzxcstus,gzxc001,gzxc002,gzxc003,gzxc004,'',gzxc005,gzxc006,gzxc007",
                               " FROM gzxc_t WHERE gzxcent = ? AND gzxc001 = ?  AND gzxc002 = ? AND gzxc003 = ? AND gzxc004 = ? FOR UPDATE"
            LET l_forupd_sql = cl_sql_forupd(l_forupd_sql)  
            PREPARE azzi800_01_1_pb FROM l_forupd_sql
            DECLARE azzi800_01_1_bcl CURSOR FOR azzi800_01_1_pb
            IF g_appoint_idx > 0 THEN
               CALL DIALOG.setCurrentRow("s_detail1_03", g_appoint_idx)
            END IF

         BEFORE ROW
            LET l_cmd = ''
            LET l_ac_03 = ARR_CURR()
            LET l_lock_sw_1 = 'N'            #DEFAULT
            DISPLAY l_ac_03 TO FORMONLY.idx
            IF s_transaction_chk("N",0) THEN
                CALL s_transaction_begin()
            END IF 
            #CALL s_transaction_begin()
            LET l_rec_b2 = g_gzxc_d.getLength()

            IF l_rec_b2 >= l_ac_03 AND NOT cl_null(g_gzxc_d[l_ac_03].gzxc004) THEN   
               LET l_cmd='u'
               LET g_gzxc_d_t.* = g_gzxc_d[l_ac_03].*  #BACKUP
               LET li_chk = FALSE
               IF NOT azzi800_01_lock_b("gzxc_t") THEN
                  LET l_lock_sw_1='Y'
               ELSE                                       
                  FETCH azzi800_01_1_bcl INTO g_gzxc_d[l_ac_03].gzxcstus,g_gzxc_d[l_ac_03].gzxc001,g_gzxc_d[l_ac_03].gzxc002,
                                              g_gzxc_d[l_ac_03].gzxc003,g_gzxc_d[l_ac_03].gzxc004,g_gzxc_d[l_ac_03].gzxc004_desc,
                                              g_gzxc_d[l_ac_03].gzxc005,g_gzxc_d[l_ac_03].gzxc006,g_gzxc_d[l_ac_03].gzxc007
                  
                  IF SQLCA.sqlcode THEN
                     LET l_lock_sw_1 = "Y"
                  END IF
                  CALL azzi800_01_detail_show("gzxc_t") 
                  CALL cl_show_fld_cont()
               END IF
            ELSE
               LET l_cmd='a'
            END IF
            
         BEFORE INSERT
            #CALL s_transaction_begin()
            LET l_cmd = 'a'
            INITIALIZE g_gzxc_d_t.* TO NULL
            INITIALIZE g_gzxc_d[l_ac_03].* TO NULL 
            
            LET g_gzxc_d_t.* = g_gzxc_d[l_ac_03].*     #新輸入資料
            CALL cl_show_fld_cont()   
            LET g_gzxc_d[l_ac_03].gzxcstus = 'Y'
            LET g_gzxc_d[l_ac_03].gzxc007 = 'N'
            
         AFTER INSERT
            IF INT_FLAG THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = 9001
               LET g_errparam.extend = ''
               LET g_errparam.popup = FALSE
               CALL cl_err()

               LET INT_FLAG = 0
               EXIT DIALOG
#subdialog limit
#              CANCEL INSERT
            END IF

            LET l_gzxc.gzxcstus = g_gzxc_d[l_ac_03].gzxcstus                  
            LET l_gzxc.gzxc001 = g_gzxa003_d
            LET l_gzxc.gzxc002 = g_gzxb_d[l_ac_01].gzxb002
            LET l_gzxc.gzxc003 = g_gzxb_d[l_ac_01].gzxb003 
            LET l_gzxc.gzxc004 = g_gzxc_d[l_ac_03].gzxc004 
            LET l_gzxc.gzxc005 = g_gzxc_d[l_ac_03].gzxc005
            LET l_gzxc.gzxc006 = g_gzxc_d[l_ac_03].gzxc006
            LET l_gzxc.gzxc007 = g_gzxc_d[l_ac_03].gzxc007
            LET l_gzxc.gzxcownid = g_user
            LET l_gzxc.gzxcowndp = g_dept
            LET l_gzxc.gzxccrtid = g_user
            LET l_gzxc.gzxccrtdp = g_dept 
            LET l_gzxc.gzxccrtdt = cl_get_current()
            LET l_gzxc.gzxcmodid = g_user
            LET l_gzxc.gzxcmoddt = cl_get_current()
            
            SELECT COUNT(1) INTO l_count FROM gzxc_t 
               WHERE gzxcent = g_enterprise 
                AND gzxc001 = g_gzxa003_d 
                AND gzxc002 = l_gzxc.gzxc002
                AND gzxc003 = l_gzxc.gzxc003
                AND gzxc004 = g_gzxc_d[l_ac_03].gzxc004 
                                     
            #資料未重複, 插入新增資料
            IF l_count = 0 THEN 
               #INSERT INTO gzxc_t VALUES(l_gzxc.*)
               INSERT INTO gzxc_t(gzxcent,gzxc001,gzxc002,gzxc003,
                                  gzxcstus,gzxc004,gzxc005,gzxc006,
                                  gzxc007,gzxcownid,gzxcowndp,gzxccrtid,
                                  gzxccrtdp,gzxccrtdt,gzxcmodid,gzxcmoddt)
                           VALUES(g_enterprise,l_gzxc.gzxc001,l_gzxc.gzxc002,l_gzxc.gzxc003,
                                  l_gzxc.gzxcstus,l_gzxc.gzxc004,l_gzxc.gzxc005,l_gzxc.gzxc006,
                                  l_gzxc.gzxc007,l_gzxc.gzxcownid,l_gzxc.gzxcowndp,l_gzxc.gzxccrtid,
                                  l_gzxc.gzxccrtdp,l_gzxc.gzxccrtdt,l_gzxc.gzxcmodid,l_gzxc.gzxcmoddt)     

                    
               IF SQLCA.sqlcode THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = SQLCA.sqlcode
                  LET g_errparam.extend = "gzxc_t"
                  LET g_errparam.popup = FALSE
                  CALL cl_err()
#160630-00009#1-s
               ELSE
                  #異動最近修改者/最近修改日期
                  UPDATE gzxa_t
                     SET (gzxamodid,gzxamoddt)
                       = (l_gzxc.gzxcmodid,l_gzxc.gzxcmoddt)
                   WHERE gzxaent = g_enterprise AND gzxa003 = g_gzxa003_d
                  IF SQLCA.sqlcode THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.extend = ""
                     LET g_errparam.code   = SQLCA.sqlcode
                     LET g_errparam.popup  = FALSE
                     CALL cl_err()
                     CALL s_transaction_end('N',0)
                     EXIT DIALOG
                  END IF
#160630-00009#1-e
               END IF
            ELSE    
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = "std-00006"
               LET g_errparam.extend = 'INSERT'
               LET g_errparam.popup = TRUE
               CALL cl_err()

               INITIALIZE g_gzxc_d[l_ac_03].* TO NULL
               CALL s_transaction_end('N',0)
               EXIT DIALOG
#subdialog limit
#              CANCEL INSERT
            END IF
 
            IF SQLCA.SQLcode  THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = SQLCA.sqlcode
               LET g_errparam.extend = "gzxc_t"
               LET g_errparam.popup = TRUE
               CALL cl_err()
  
               CALL s_transaction_end('N',0)
               EXIT DIALOG               
#subdialog limit
#              CANCEL INSERT
            ELSE
              
               CALL s_transaction_end('Y',0)
               
               ERROR 'INSERT O.K'
               LET l_rec_b2 = l_rec_b2 + 1
            END IF

        BEFORE DELETE                            #是否取消單身
            IF NOT cl_null(g_gzxc_d[l_ac_03].gzxc004) THEN
                
               IF NOT cl_ask_del_detail() THEN
                  LET li_chk = TRUE 
                  RETURN
#subdialog limit
#                 CANCEL DELETE
                   
               END IF
               IF l_lock_sw_1 = "Y" THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code =  -263
                  LET g_errparam.extend = ""
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
                  LET li_chk = TRUE 
                  RETURN 
#subdialog limit                  
#                 CANCEL DELETE
               END IF
               
                 #取得該筆資料key值
                  INITIALIZE gs_keys TO NULL
                  LET gs_keys[01] = g_gzxa003_d
                  LET gs_keys[gs_keys.getLength()+1] = g_gzxc_d[l_ac_03].gzxc002
                  LET gs_keys[gs_keys.getLength()+1] = g_gzxc_d[l_ac_03].gzxc003
                  LET gs_keys[gs_keys.getLength()+1] = g_gzxc_d[l_ac_03].gzxc004
 
                  LET li_cnt = azzi800_01_cnt_gzxc(gs_keys) 
                  #至少要有一筆資料 
                  IF li_cnt =  1 THEN 
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code =  "azz-00318"
                     LET g_errparam.extend = "gzxc_t"
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                     LET li_chk = TRUE 
                     RETURN
                  END IF
                  #刪除同層單身
                  IF NOT azzi800_01_delete_b('gzxc_t',gs_keys,"'1'") THEN
                     CALL s_transaction_end('N','0')
                     CLOSE azzi800_01_1_bcl
                     LET li_chk = TRUE 
                     RETURN
                  END IF
                  LET l_rec_b2 = l_rec_b2-1
                  
                  CALL s_transaction_end('Y',0)
                  CLOSE azzi800_01_1_bcl
                  LET l_count = g_gzxc_d.getLength()
            END IF 
            
         ON ROW CHANGE
            IF INT_FLAG THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = 9001
               LET g_errparam.extend = ''
               LET g_errparam.popup = FALSE
               CALL cl_err()

               LET INT_FLAG = 0
               LET g_gzxc_d[l_ac_03].* = g_gzxc_d_t.*
               CLOSE azzi800_01_1_bcl
               CALL s_transaction_end('N',0)
               EXIT DIALOG 
            END IF
 
            IF l_lock_sw_1 = 'Y' THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = -263
               LET g_errparam.extend = g_gzxc_d_t.gzxc004
               LET g_errparam.popup = TRUE
               CALL cl_err()

               LET g_gzxc_d[l_ac_03].* = g_gzxc_d_t.*
            ELSE
               UPDATE gzxc_t SET (gzxcstus,gzxc001,gzxc002,gzxc003,gzxc004,gzxc005,gzxc006,gzxc007 ) = 
                  (g_gzxc_d[l_ac_03].gzxcstus,g_gzxa003_d,g_gzxc_d[l_ac_03].gzxc002,g_gzxc_d[l_ac_03].gzxc003,g_gzxc_d[l_ac_03].gzxc004,g_gzxc_d[l_ac_03].gzxc005,g_gzxc_d[l_ac_03].gzxc006,g_gzxc_d[l_ac_03].gzxc007)
                  WHERE gzxcent = g_enterprise 
                     AND gzxc001 = g_gzxa003_d 
                     AND gzxc002 = g_gzxc_d_t.gzxc002
                     AND gzxc003 = g_gzxc_d_t.gzxc003
                     AND gzxc004 = g_gzxc_d_t.gzxc004

               IF SQLCA.sqlcode THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = SQLCA.sqlcode
                  LET g_errparam.extend = "gzxc_t"
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
   
                  LET g_gzxc_d[l_ac_03].* = g_gzxc_d_t.*
                  CALL s_transaction_end('N',0) 
               ELSE
#160630-00009#1-s
                  #異動最近修改者/最近修改日期
                  LET l_gzxc.gzxcmodid = g_user
                  LET l_gzxc.gzxcmoddt = cl_get_current()
                  UPDATE gzxa_t
                     SET (gzxamodid,gzxamoddt)
                       = (l_gzxc.gzxcmodid,l_gzxc.gzxcmoddt)
                   WHERE gzxaent = g_enterprise AND gzxa003 = g_gzxa003_d
                  IF SQLCA.sqlcode THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.extend = ""
                     LET g_errparam.code   = SQLCA.sqlcode
                     LET g_errparam.popup  = FALSE
                     CALL cl_err()
                     CALL s_transaction_end('N',0)
                  ELSE
#160630-00009#1-e              
                     LET g_log1 = util.JSON.stringify(g_gzxa_m),util.JSON.stringify(g_gzxc_d_t)
                     LET g_log2 = util.JSON.stringify(g_gzxa_m),util.JSON.stringify(g_gzxc_d[l_ac_03])
                     IF NOT cl_log_modified_record(g_log1,g_log2) THEN 
                        CALL s_transaction_end('N','0')
                     END IF
                  END IF   #160630-00009#1                     
                  #CALL s_transaction_end('Y',0)                
               END IF
            END IF
            
         AFTER ROW
            IF li_chk THEN 
               #還原
               CALL g_gzxc_d.insertElement(l_ac_03) 
               LET g_gzxc_d[l_ac_03].* = g_gzxc_d_t.*
            END IF
            CALL azzi800_01_unlock_b("gzxc_t")
            CALL s_transaction_end('Y','0')
            
            #end add-point
          
         #---------------------<  Detail: page1  >---------------------

         #----<<gzxc008>>----
         #此段落由子樣板a01產生
         BEFORE FIELD gzxc002
            #add-point:BEFORE FIELD gzxc002

            #END add-point

         #此段落由子樣板a02產生
         AFTER FIELD gzxc002
            
            #add-point:AFTER FIELD gzxc002
            
            #END add-point
            

         #此段落由子樣板a04產生
         ON CHANGE gzxc002
            #add-point:ON CHANGE gzxc002

            #END add-point

         #----<<gzxc009>>----
         #此段落由子樣板a02產生
         AFTER FIELD gzxc003
            
            #add-point:AFTER FIELD gzxc003
            
            #END add-point
            

         #此段落由子樣板a01產生
         BEFORE FIELD gzxc003
            #add-point:BEFORE FIELD gzxc003

            #END add-point

         #此段落由子樣板a04產生
         ON CHANGE gzxc003
            #add-point:ON CHANGE gzxc003

            #END add-point

         #----<<gzxc010>>----
         #此段落由子樣板a01產生
         BEFORE FIELD gzxc004
            #add-point:BEFORE FIELD gzxc004
            CALL DIALOG.setFieldTouched("s_detail1_03.gzxc004",TRUE)
            #END add-point

         #此段落由子樣板a02產生
         AFTER FIELD gzxc004
            
            #add-point:AFTER FIELD gzxc004

            IF NOT cl_null(g_gzxc_d[l_ac_03].gzxc004)  THEN
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_gzxc_d[l_ac_03].gzxc004 != g_gzxc_d_t.gzxc004)) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(1) FROM gzxc_t WHERE "||"gzxcent = '" ||g_enterprise|| "' AND "||"gzxc001 = '"||g_gzxa003_d||"' AND gzxc002='"||g_gzxb_d[l_ac_01].gzxb002||"' AND gzxc003 = '"||g_gzxb_d[l_ac_01].gzxb003||"' AND gzxc004 = '"||g_gzxc_d[l_ac_03].gzxc004||"'",'std-00004',0) THEN 
                     NEXT FIELD gzxc004
                  END IF
                  #161220-00024 start
                  IF UPSHIFT(g_gzxc_d[l_ac_03].gzxc004) = "ALL" OR g_gzxc_d[l_ac_03].gzxc004 = "all" THEN 
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.extend = ""
                     LET g_errparam.code   = "azz-00427"
                     LET g_errparam.popup  = TRUE 
                     CALL cl_err()
                     NEXT FIELD gzxc004
                  END IF 
                  #161220-00024 end
               END IF
               
               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
               INITIALIZE g_chkparam.* TO NULL
               #設定g_chkparam.*的參數
               LET g_chkparam.arg1 = g_gzxc_d[l_ac_03].gzxc004
               #160318-00025#47  2016/04/29  by pengxin  add(S)
               LET g_errshow = TRUE #是否開窗 
               LET g_chkparam.err_str[1] = "aoo-00095:sub-01302|aooi125|",cl_get_progname("aooi125",g_lang,"2"),"|:EXEPROGaooi125"
               #160318-00025#47  2016/04/29  by pengxin  add(E)
               #呼叫檢查存在並帶值的library
               IF cl_chk_exist("v_ooef001") THEN
                #檢查成功時後續處理
                #LET  = g_chkparam.return1
                #DISPLAY BY NAME
               ELSE
                #檢查失敗時後續處理
                
                  NEXT FIELD CURRENT
               END IF
               
               INITIALIZE g_ref_fields TO NULL
               LET g_ref_fields[1] = g_gzxc_d[l_ac_03].gzxc004
               CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
               LET g_gzxc_d[l_ac_03].gzxc004_desc = '', g_rtn_fields[1] , ''
               DISPLAY BY NAME g_gzxc_d[l_ac_03].gzxc004_desc
            END IF
            
            #END add-point
            
         ON ACTION controlp INFIELD gzxc004
           LET g_qryparam.reqry = FALSE
           LET g_qryparam.default1 = g_gzxc_d[l_ac_03].gzxc004    #給予default值
           #給予arg
           CALL q_ooef001_14()                                    #呼叫開窗
           LET g_gzxc_d[l_ac_03].gzxc004 = g_qryparam.return1     #將開窗取得的值回傳到變數
           #DISPLAY g_gzxc_d[l_ac_03].gzxc004                     #顯示到畫面上
           NEXT FIELD gzxc004                                     #返回原欄位
           

         #此段落由子樣板a04產生
         ON CHANGE gzxc004
            #add-point:ON CHANGE gzxc010

            #END add-point

         #----<<gzxc005>>----
         #此段落由子樣板a01產生
         BEFORE FIELD gzxc005
            #add-point:BEFORE FIELD gzxc005

            #END add-point

         #此段落由子樣板a02產生
         AFTER FIELD gzxc005
            
            #add-point:AFTER FIELD gzxc005

            #END add-point
            

         #此段落由子樣板a04產生
         ON CHANGE gzxc005
            #add-point:ON CHANGE gzxc005

            #END add-point

         AFTER INPUT
            #add-point:單身輸入後處理

            #end add-point

      END INPUT
END DIALOG
################################################################################
# Descriptions...: 單身QBE SUBDIALOG共用函式
# Memo...........:  
# Usage..........: CALL azzi800_01_construct()
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 日期 By 作者
# Modify.........:
################################################################################
DIALOG azzi800_01_construct()
    
    CONSTRUCT g_wc2_01 ON gzxbstus,gzxb001,gzxb002,gzxb003,gzxb004,gzxb005

         FROM s_detail1_01[1].gzxbstus,s_detail1_01[1].gzxb001,s_detail1_01[1].gzxb002,s_detail1_01[1].gzxb003,s_detail1_01[1].gzxb004,s_detail1_01[1].gzxb005


         #---------------------<  Detail: page1  >---------------------
         #----<<gzxbstus>>----
         #此段落由子樣板a01產生
         BEFORE FIELD gzxbstus
            #add-point:BEFORE FIELD gzxbstus
            
            #END add-point

         #此段落由子樣板a02產生
         AFTER FIELD gzxbstus

            #add-point:AFTER FIELD gzxbstus
            {<point name="query.a.page1.gzxbstus" />}
            #END add-point

         #----<<gzxb001>>----
         #此段落由子樣板a01產生
         BEFORE FIELD gzxb001
            #add-point:BEFORE FIELD gzxb001
            {<point name="query.b.page1.gzxb001" />}
            #END add-point

         #此段落由子樣板a02產生
         AFTER FIELD gzxb001

            #add-point:AFTER FIELD gzxb001
            {<point name="query.a.page1.gzxb001" />}
            #END add-point

         #此段落由子樣板a02產生
         AFTER FIELD gzxb002

            #add-point:AFTER FIELD gzxb002
            --{<point name="query.a.page1.gzxb002" />}
            CALL FGL_DIALOG_GETBUFFER() RETURNING g_gzxb_d[1].gzxb002
            #END add-point

         #----<<gzxb003>>----
         #此段落由子樣板a01產生
         BEFORE FIELD gzxb003
            #add-point:BEFORE FIELD gzxb003
            --{<point name="query.b.page1.gzxb003" />}
            #END add-point

         #此段落由子樣板a02產生
         AFTER FIELD gzxb003

            #add-point:AFTER FIELD gzxb003
            {<point name="query.a.page1.gzxb003" />}
            #END add-point

         #Ctrlp:query.c.page1.gzxb003
         ON ACTION controlp INFIELD gzxb003
            #add-point:ON ACTION controlp INFIELD gzxb003
                                                 
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE

            IF g_gzxb_d[1].gzxb002 = "1" THEN #1 角色 0 作業
                  CALL q_gzya001()                           #呼叫開窗                 
               ELSE 
                  CALL q_gzzz001_1()
               END IF
            DISPLAY g_qryparam.return1 TO gzxb003            #顯示到畫面上
            
            NEXT FIELD gzxb003                               #返回原欄位
            #END add-point

         #此段落由子樣板a02產生
         AFTER FIELD gzxb004

            #add-point:AFTER FIELD gzxb004
            {<point name="query.a.page1.gzxb004" />}
            #END add-point

         #----<<gzxb005>>----
         #Ctrlp:construct.c.page1.gzxb005
         ON ACTION controlp INFIELD gzxb005
            #add-point:ON ACTION controlp INFIELD gzxb015
            #此段落由子樣板a08產生
            #開窗c段

            NEXT FIELD gzxb005                     #返回原欄位


            #END add-point

         #此段落由子樣板a02產生
         AFTER FIELD gzxb005


         BEFORE CONSTRUCT
            #CALL cl_qbe_init()
            #add-point:cs段more_construct
            --{<point name="cs.before_construct"/>}

            #end add-point

         ON ACTION qbe_select
            #CALL cl_qbe_select()

         ON ACTION qbe_save
            #CALL cl_qbe_save()

      END CONSTRUCT
END DIALOG
################################################################################
# Descriptions...: 單身輸入SUBDIALOG共用函式
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
DIALOG azzi800_01_input()
   DEFINE l_count        LIKE type_t.num5
   DEFINE l_cmd          LIKE type_t.chr5
   DEFINE p_gzxb002      LIKE gzxb_t.gzxb002
   #DEFINE l_gzxb         RECORD LIKE gzxb_t.*
   DEFINE l_gzxb         type_g_gzxb_d2
   DEFINE l_lock_sw      LIKE type_t.chr1 
   DEFINE l_success      LIKE type_t.num5
   DEFINE l_wc           STRING
   DEFINE l_n            LIKE type_t.num5
   DEFINE l_rec_b        LIKE type_t.num5
   DEFINE l_forupd_sql   STRING
   DEFINE li_rtn         LIKE type_t.num5
   DEFINE ls_str         STRING
   DEFINE li_chk         LIKE type_t.num5     #確認是否取消單身刪除
   DEFINE li_cnt         LIKE type_t.num5     #
   DEFINE lc_gzzz002     LIKE gzzz_t.gzzz002  #161225-00003 #3
   
   INPUT ARRAY g_gzxb_d FROM s_detail1_01.*
          ATTRIBUTE(COUNT = g_detail_cnt_01,MAXCOUNT = g_max_rec,WITHOUT DEFAULTS,
                  INSERT ROW = g_detail_insert,
                  DELETE ROW = g_detail_delete,
                  APPEND ROW = g_detail_insert)

         #自訂ACTION(detail_input,page_1)

         BEFORE INPUT
            #DISPLAY "BEFORE INPUT g_gzxa003_d:",g_gzxa003_d
            #add-point:單身輸入前處理
            CALL azzi800_01_show_scc()
            LET l_forupd_sql = " SELECT gzxbstus,gzxb001,gzxb002,gzxb003,'',gzxb004,gzxb005,'',gzxb006,gzxb007,gzxb008",
                               " FROM gzxb_t WHERE gzxbent = ? AND gzxb001 = ?  AND gzxb002 = ? AND gzxb003 = ? FOR UPDATE"
            LET l_forupd_sql = cl_sql_forupd(l_forupd_sql)  
            PREPARE azzi800_01_p FROM l_forupd_sql
            DECLARE azzi800_01_bcl CURSOR FOR azzi800_01_p
            IF g_appoint_idx > 0 THEN
               CALL DIALOG.setCurrentRow("s_detail1_01", g_appoint_idx)
            END IF

         BEFORE ROW
           # DISPLAY "BEFORE ROW"
            LET l_cmd = ''
            LET l_ac_01 = ARR_CURR()
            LET l_lock_sw = 'N'            #DEFAULT
            DISPLAY l_ac_01 TO FORMONLY.idx
            IF s_transaction_chk("N",0) THEN
                CALL s_transaction_begin()
            END IF 
            #CALL s_transaction_begin()
            IF g_gzxb_d.getLength() = 0 THEN
               LET g_gzxb002_d = ''
               LET g_gzxb003_d = ''
            ELSE
               LET g_gzxb002_d = g_gzxb_d[l_ac_01].gzxb002  
               LET g_gzxb003_d = g_gzxb_d[l_ac_01].gzxb003  
            END IF
            CALL azzi800_01_b2_fill(g_wc3_01) 
            LET l_rec_b = g_gzxb_d.getLength()
            IF l_rec_b >= l_ac_01 AND NOT cl_null(g_gzxb_d[l_ac_01].gzxb002) AND NOT cl_null(g_gzxb_d[l_ac_01].gzxb003) THEN  
               LET l_cmd='u'
               LET g_gzxb_d_t.* = g_gzxb_d[l_ac_01].*  #BACKUP
               LET li_chk = FALSE
               IF NOT azzi800_01_lock_b("gzxb_t") THEN
                  LET l_lock_sw='Y'
               ELSE
                   
                   FETCH azzi800_01_bcl INTO g_gzxb_d[l_ac_01].*
                   
                   IF SQLCA.sqlcode THEN
                      LET l_lock_sw = "Y"
                   END IF
                   CALL azzi800_01_detail_show("gzxb_t")
                   IF g_gzxb_d[l_ac_01].gzxb002 = "0" THEN 
                      LET g_gzxb_d[l_ac_01].gzxh004 = azzi800_01_get_gzxh003(l_ac_01) 
                   END IF
                   CALL cl_show_fld_cont()
               END IF
            ELSE
               LET l_cmd='a'
            END IF

         BEFORE INSERT
            #DISPLAY "BEFORE INSERT"
            CALL s_transaction_begin()
            LET l_cmd = 'a'
            INITIALIZE g_gzxb_d_t.* TO NULL
            INITIALIZE g_gzxb_d[l_ac_01].* TO NULL 
            CALL g_gzxc_d.clear()
            LET g_gzxb_d_t.* = g_gzxb_d[l_ac_01].*     #新輸入資料
            CALL cl_show_fld_cont()  
            LET g_gzxb_d[l_ac_01].gzxbstus = 'Y' 
            #功能授權 部門資料授權 個人資料授權 單身處理方式 全部開放   
            CALL cl_set_comp_entry("l_gzxh004,gzxb006,gzxb007,gzxb008",TRUE)             
            
         AFTER INSERT
            #display "01 AFTER INSERT "
            IF INT_FLAG THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = 9001
               LET g_errparam.extend = ''
               LET g_errparam.popup = FALSE
               CALL cl_err()

               LET INT_FLAG = 0
               EXIT DIALOG
#subdialog limit
#              CANCEL INSERT
            END IF

            LET l_gzxb.gzxbstus = g_gzxb_d[l_ac_01].gzxbstus        
            LET l_gzxb.gzxb001 = g_gzxa003_d
            LET l_gzxb.gzxb002 = g_gzxb_d[l_ac_01].gzxb002
            LET l_gzxb.gzxb003 = g_gzxb_d[l_ac_01].gzxb003
            LET l_gzxb.gzxb004 = g_gzxb_d[l_ac_01].gzxb004 
            LET l_gzxb.gzxb005 = g_gzxb_d[l_ac_01].gzxb005
            LET l_gzxb.gzxb006 = g_gzxb_d[l_ac_01].gzxb006
            LET l_gzxb.gzxb007 = g_gzxb_d[l_ac_01].gzxb007
            LET l_gzxb.gzxb008 = g_gzxb_d[l_ac_01].gzxb008
            LET l_gzxb.gzxbownid = g_user
            LET l_gzxb.gzxbowndp = g_dept
            LET l_gzxb.gzxbcrtid = g_user
            LET l_gzxb.gzxbcrtdp = g_dept 
            LET l_gzxb.gzxbcrtdt = cl_get_current()
            LET l_gzxb.gzxbmodid = g_user
            LET l_gzxb.gzxbmoddt = cl_get_current()
            
            SELECT COUNT(1) INTO l_count FROM gzxb_t 
             WHERE gzxbent = g_enterprise 
               AND gzxb001 = g_gzxa003_d 
               AND gzxb002 = g_gzxb_d[l_ac_01].gzxb002
               AND gzxb003 = g_gzxb_d[l_ac_01].gzxb003 
               
            #資料未重複, 插入新增資料
            IF l_count = 0 THEN 
                #INSERT INTO gzxb_t VALUES(l_gzxb.*)
               INSERT INTO gzxb_t(gzxbent,gzxb001,gzxb002,gzxb003,
                                  gzxbstus,gzxb004,gzxb005,gzxb006,
                                  gzxb007,gzxb008,gzxbownid,gzxbowndp,
                                  gzxbcrtid,gzxbcrtdp,gzxbcrtdt,gzxbmodid,
                                  gzxbmoddt)
                           VALUES(g_enterprise,l_gzxb.gzxb001,l_gzxb.gzxb002,l_gzxb.gzxb003,
                                  l_gzxb.gzxbstus,l_gzxb.gzxb004,l_gzxb.gzxb005,l_gzxb.gzxb006,
                                  l_gzxb.gzxb007,l_gzxb.gzxb008,l_gzxb.gzxbownid,l_gzxb.gzxbowndp,
                                  l_gzxb.gzxbcrtid,l_gzxb.gzxbcrtdp,l_gzxb.gzxbcrtdt,l_gzxb.gzxbmodid,
                                  l_gzxb.gzxbmoddt)
               
                    
               IF SQLCA.sqlcode THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = SQLCA.sqlcode
                  LET g_errparam.extend = "gzxb_t"
                  LET g_errparam.popup = FALSE
                  CALL cl_err()
#160630-00009#1-s
               ELSE
                  #異動最近修改者/最近修改日期
                  UPDATE gzxa_t
                     SET (gzxamodid,gzxamoddt)
                       = (l_gzxb.gzxbmodid,l_gzxb.gzxbmoddt)
                   WHERE gzxaent = g_enterprise AND gzxa003 = g_gzxa003_d
                  IF SQLCA.sqlcode THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.extend = ""
                     LET g_errparam.code   = SQLCA.sqlcode
                     LET g_errparam.popup  = FALSE
                     CALL cl_err()
                     CALL s_transaction_end('N',0)
                     EXIT DIALOG
                  END IF
#160630-00009#1-e
               END IF
            ELSE    
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = "std-00006"
               LET g_errparam.extend = 'INSERT'
               LET g_errparam.popup = TRUE
               CALL cl_err()

               INITIALIZE g_gzxb_d[l_ac_01].* TO NULL
               CALL s_transaction_end('N',0)
               EXIT DIALOG
#subdialog limit
#              CANCEL INSERT
              
            END IF
 
            IF SQLCA.SQLcode  THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = SQLCA.sqlcode
               LET g_errparam.extend = "gzxb_t"
               LET g_errparam.popup = TRUE
               CALL cl_err()
  
               CALL s_transaction_end('N',0) 
               EXIT DIALOG               
#subdialog limit
#              CANCEL INSERT
            ELSE
              
               CALL s_transaction_end('Y',0)
               
               ERROR 'INSERT O.K'
               LET l_rec_b = l_rec_b + 1
            END IF
            
        BEFORE DELETE                            #是否取消單身
            IF NOT cl_null(g_gzxb_d[l_ac_01].gzxb002) AND NOT cl_null(g_gzxb_d[l_ac_01].gzxb003) THEN

               IF NOT cl_ask_del_detail() THEN
                  LET li_chk = TRUE 
                  RETURN 
#subdialog limit
#                 CANCEL DELETE
               END IF
               IF l_lock_sw = "Y" THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code =  -263
                  LET g_errparam.extend = ""
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
                  LET li_chk = TRUE 
                  RETURN
#subdialog limit                  
#                 CANCEL DELETE
               END IF
               
                  #取得該筆資料key值
                  INITIALIZE gs_keys TO NULL
                  LET gs_keys[01] = g_gzxa003_d
                  LET gs_keys[gs_keys.getLength()+1] = g_gzxb_d[l_ac_01].gzxb002
                  LET gs_keys[gs_keys.getLength()+1] = g_gzxb_d[l_ac_01].gzxb003
                  
                  IF g_gzxb_d[l_ac_01].gzxb002 = "1" THEN 
                     LET li_cnt = azzi800_01_cnt_gzxb(gs_keys) 
                     #至少要有一筆資料 
                     IF li_cnt =  1 THEN 
                        INITIALIZE g_errparam TO NULL
                        LET g_errparam.code =  "azz-00321"
                        LET g_errparam.extend = ""
                        LET g_errparam.popup = TRUE
                        CALL cl_err()
                        LET li_chk = TRUE 
                        RETURN
                      END IF
                  END IF 
                  

                  #刪除同層單身
                  IF NOT azzi800_01_delete_b('gzxb_t',gs_keys,"'1'") THEN
                     CALL s_transaction_end('N','0')
                     CLOSE azzi800_01_bcl
                     LET li_chk = TRUE 
                     RETURN
                  END IF
                  #刪除下層單身
                  LET gs_gzxb002 = g_gzxb_d[l_ac_01].gzxb002
                  IF NOT azzi800_01_key_delete_b(gs_keys,'gzxb_t') THEN
                     CALL s_transaction_end('N','0')
                     CLOSE azzi800_01_bcl
                     LET li_chk = TRUE 
                     RETURN
                  END IF
                  LET l_rec_b = l_rec_b-1
                  CALL s_transaction_end('Y','0')             
                  CLOSE azzi800_01_bcl
                  LET l_count = g_gzxb_d.getLength()
               
#               DELETE FROM gzxb_t
#                  WHERE gzxbent = g_enterprise 
#                     AND gzxb001 = g_gzxa003_d 
#                     AND gzxb002 = g_gzxb_d[l_ac_01].gzxb002 
#                     AND gzxb003 = g_gzxb_d[l_ac_01].gzxb003
#  
#               IF SQLCA.sqlcode THEN
#                  INITIALIZE g_errparam TO NULL
#                  LET g_errparam.code = SQLCA.sqlcode
#                  LET g_errparam.extend = "gzxb_t"
#                  LET g_errparam.popup = TRUE
#                  CALL cl_err()
#
#                  CALL s_transaction_end('N',0)
#                  LET li_chk = TRUE 
#                  RETURN
##subdialog limit
##                 CANCEL DELETE   
#               ELSE
#                  LET l_rec_b = l_rec_b-1
#                  DELETE FROM gzxc_t
#                  WHERE gzxcent = g_enterprise 
#                     AND gzxc001 = g_gzxa003_d               #員工編號
#                     AND gzxc002 = g_gzxb_d[l_ac_01].gzxb002 #類別
#                     AND gzxc003 = g_gzxb_d[l_ac_01].gzxb003 #角色編號或作業編號 
#                     IF SQLCA.sqlcode THEN
#                        INITIALIZE g_errparam TO NULL
#                        LET g_errparam.code = SQLCA.sqlcode
#                        LET g_errparam.extend = "gzxc_t"
#                        LET g_errparam.popup = TRUE
#                        CALL cl_err()
#
#                        CALL s_transaction_end('N',0) 
#                     ELSE 
#                        IF g_gzxb_d[l_ac_01].gzxb002 = "0" THEN 
#                           DELETE FROM gzxg_t
#                            WHERE gzxgent = g_enterprise
#                             AND  gzxg001 = g_gzxa003_d
#                             AND  gzxg002 = g_gzxb_d[l_ac_01].gzxb003  #角色編號或作業編號 
#                           IF SQLCA.sqlcode THEN
#                              INITIALIZE g_errparam TO NULL
#                              LET g_errparam.code = SQLCA.sqlcode
#                              LET g_errparam.extend = "gzxg_t"
#                              LET g_errparam.popup = TRUE
#                              CALL cl_err()
#                              CALL s_transaction_end('N',0) 
#                           END IF   
#                        
#                           DELETE FROM gzxh_t
#                            WHERE gzxhent = g_enterprise 
#                             AND gzxh001 = g_gzxa003_d                #員工編號
#                             AND gzxh002 = g_gzxb_d[l_ac_01].gzxb003  #角色編號或作業編號
#                           IF SQLCA.sqlcode THEN
#                              INITIALIZE g_errparam TO NULL
#                              LET g_errparam.code = SQLCA.sqlcode
#                              LET g_errparam.extend = "gzxh_t"
#                              LET g_errparam.popup = TRUE
#                              CALL cl_err()
#
#                              CALL s_transaction_end('N',0) 
#                            END IF  
#                        END IF #g_gzxb_d[l_ac_01].gzxb002 = "0" 
#                        CALL s_transaction_end('Y',0)
#                     END IF # gzyc_t IF SQLCA.sqlcode THEN        
#               END IF # gzyb_t IF SQLCA.sqlcode THEN                
               CLOSE azzi800_01_bcl
               LET l_count = g_gzxb_d.getLength()
            END IF #IF NOT cl_null(g_gzxb_d[l_ac_01].gzxb002)
            
         ON ROW CHANGE
            IF INT_FLAG THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = 9001
               LET g_errparam.extend = ''
               LET g_errparam.popup = FALSE
               CALL cl_err()

               LET INT_FLAG = 0
               LET g_gzxb_d[l_ac_01].* = g_gzxb_d_t.*
               CLOSE azzi800_01_bcl
               CALL s_transaction_end('N',0)
               EXIT DIALOG 
            END IF
              
            IF l_lock_sw = 'Y' THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = -263
               LET g_errparam.extend = g_gzxb_d_t.gzxb002
               LET g_errparam.popup = TRUE
               CALL cl_err()

               LET g_gzxb_d[l_ac_01].* = g_gzxb_d_t.*
            ELSE
               IF g_gzxb_d[l_ac_01].gzxb002 = "0" THEN #作業
                  IF cl_null(g_gzxb_d[l_ac_01].gzxb006) THEN 
                     NEXT FIELD gzxb006
                  END IF 
                  IF cl_null(g_gzxb_d[l_ac_01].gzxb007) THEN 
                     NEXT FIELD gzxb007
                  END IF
                  IF cl_null(g_gzxb_d[l_ac_01].gzxb008) THEN 
                     NEXT FIELD gzxb008
                  END IF
               ELSE
                  IF g_gzxb_d_t.gzxb002 = "0" THEN #作業
                  
                    INITIALIZE gs_keys TO NULL
                    LET gs_keys[01] = g_gzxa003_d
                    LET gs_keys[gs_keys.getLength()+1] = g_gzxb_d_t.gzxb002
                    LET gs_keys[gs_keys.getLength()+1] = g_gzxb_d_t.gzxb003

                     #刪除下層單身
                     LET gs_gzxb002 = g_gzxb_d_t.gzxb002
                     IF NOT azzi800_01_key_delete_b(gs_keys,'gzxb_t') THEN
                        CALL s_transaction_end('N','0')
                        CLOSE azzi800_01_bcl
                        LET li_chk = TRUE 
                        RETURN
                     END IF
                   END IF  #g_gzxb_d_t.gzxb002 = "0"  
                END IF #g_gzxb_d[l_ac_01].gzxb002 = "0" 
                           
               UPDATE gzxb_t SET (gzxbstus,gzxb001,gzxb002,gzxb003,gzxb004,gzxb005,gzxb006,gzxb007,gzxb008 )= 
                (g_gzxb_d[l_ac_01].gzxbstus,g_gzxa003_d,g_gzxb_d[l_ac_01].gzxb002,g_gzxb_d[l_ac_01].gzxb003,g_gzxb_d[l_ac_01].gzxb004,g_gzxb_d[l_ac_01].gzxb005,g_gzxb_d[l_ac_01].gzxb006,g_gzxb_d[l_ac_01].gzxb007,g_gzxb_d[l_ac_01].gzxb008)
                  WHERE gzxbent = g_enterprise 
                     AND gzxb001 = g_gzxa003_d 
                     AND gzxb002 = g_gzxb_d_t.gzxb002
                     AND gzxb003 = g_gzxb_d_t.gzxb003
 
               IF SQLCA.sqlcode THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = SQLCA.sqlcode
                  LET g_errparam.extend = "gzxb_t"
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
   
                  LET g_gzxb_d[l_ac_01].* = g_gzxb_d_t.*
                  CALL s_transaction_end('N',0) 
               ELSE
#160630-00009#1-s
                  #異動最近修改者/最近修改日期
                  LET l_gzxb.gzxbmodid = g_user
                  LET l_gzxb.gzxbmoddt = cl_get_current()
                  UPDATE gzxa_t
                     SET (gzxamodid,gzxamoddt)
                       = (l_gzxb.gzxbmodid,l_gzxb.gzxbmoddt)
                   WHERE gzxaent = g_enterprise AND gzxa003 = g_gzxa003_d
                  IF SQLCA.sqlcode THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.extend = ""
                     LET g_errparam.code   = SQLCA.sqlcode
                     LET g_errparam.popup  = FALSE
                     CALL cl_err()
                     CALL s_transaction_end('N',0)
                  ELSE
#160630-00009#1-e               
                     LET g_log1 = util.JSON.stringify(g_gzxa_m),util.JSON.stringify(g_gzxb_d_t)
                     LET g_log2 = util.JSON.stringify(g_gzxa_m),util.JSON.stringify(g_gzxb_d[l_ac_01])
                  
                     IF NOT cl_log_modified_record(g_log1,g_log2) THEN 
                        CALL s_transaction_end('N','0')
                     END IF
                  END IF   #160630-00009#1
                  #CALL s_transaction_end('Y',0)
                  #161130-00018 start                  
                  #更新gzxc_t
                  #異動最近修改者/最近修改日期
                  LET l_gzxb.gzxbmodid = g_user
                  LET l_gzxb.gzxbmoddt = cl_get_current()
                  LET l_gzxb.gzxb002 = g_gzxb_d[l_ac_01].gzxb002 
                  LET l_gzxb.gzxb003 = g_gzxb_d[l_ac_01].gzxb003 
                  
                  #161220-00042
                  SELECT COUNT(gzxc003) INTO li_cnt FROM gzxc_t 
                    WHERE gzxcent = g_enterprise 
                     AND  gzxc001 = g_gzxa003_d 
                     AND  gzxc002 = l_gzxb.gzxb002
                     AND  gzxc003 = l_gzxb.gzxb003
                   #有資料就不更新
                   IF li_cnt > 0 THEN 
                      RETURN
                   END IF
                  #161220-00042
                  
                     UPDATE gzxc_t
                       SET (gzxc002,gzxc003,
                            gzxcmodid,gzxcmoddt)
                       = (l_gzxb.gzxb002,l_gzxb.gzxb003,
                          l_gzxb.gzxbmodid,l_gzxb.gzxbmoddt)
                      WHERE gzxcent = g_enterprise 
                      AND gzxc001 = g_gzxa003_d
                      AND gzxc002 = g_gzxb_d_t.gzxb002
                      AND gzxc003 = g_gzxb_d_t.gzxb003
                     IF SQLCA.sqlcode THEN
                       INITIALIZE g_errparam TO NULL
                       LET g_errparam.code = SQLCA.sqlcode
                       LET g_errparam.extend = "gzxc_t"
                       LET g_errparam.popup = TRUE
                       CALL cl_err()
   
                       LET g_gzxb_d[l_ac_01].* = g_gzxb_d_t.*
                       CALL s_transaction_end('N',0) 
                    
                     END IF 
                     #161130-00018 end
                 
               END IF  #IF SQLCA.sqlcode IF ELSE END IF

            END IF
            
         AFTER ROW
            IF li_chk THEN 
               CALL g_gzxb_d.insertElement(l_ac_01) 
               LET g_gzxb_d[l_ac_01].* = g_gzxb_d_t.*
            END IF
            CALL azzi800_01_unlock_b("gzxb_t")
            CALL s_transaction_end('Y','0')
            #功能授權 部門資料授權 個人資料授權 單身處理方式 全部開放   
            CALL cl_set_comp_entry("l_gzxh004,gzxb006,gzxb007,gzxb008",TRUE) 
            #end add-point
          
         #----<<gzxb002>>----
         #此段落由子樣板a01產生
         BEFORE FIELD gzxb002
            #add-point:BEFORE FIELD gzxb002
            {<point name="input.b.page1.gzxb002" />}
            #END add-point

         #此段落由子樣板a02產生
         AFTER FIELD gzxb002

            #add-point:AFTER FIELD gzxb002
            #此段落由子樣板a05產生

            IF  NOT cl_null(g_gzxb_d[l_ac_01].gzxb002) AND NOT cl_null(g_gzxb_d[l_ac_01].gzxb003) THEN             
              
              IF l_cmd = 'a' OR ( l_cmd = 'u' AND ( g_gzxb_d[l_ac_01].gzxb002 != g_gzxb_d_t.gzxb002 OR g_gzxb_d[l_ac_01].gzxb003 != g_gzxb_d_t.gzxb003)) THEN            
                 #160616-00004 #1 start
#                  IF NOT ap_chk_notDup("","SELECT COUNT(1) FROM gzxb_t WHERE "||"gzxbent = '" ||g_enterprise|| "' AND "||"gzxb001 = '"||g_gzxa003_d ||"' AND "|| "gzxb002 = '"||g_gzxb_d[l_ac_01].gzxb002 ||"' AND "|| "gzxb003 = '"||g_gzxb_d[l_ac_01].gzxb003 ||"'",'std-00004',0) THEN                    
#                     NEXT FIELD CURRENT
#                  END IF
                  SELECT COUNT(1) INTO li_cnt FROM gzxb_t 
                   WHERE gzxbent = g_enterprise 
                    AND gzxb001 = g_gzxa003_d 
                    AND gzxb002 = g_gzxb_d[l_ac_01].gzxb002 
                    AND gzxb003 = g_gzxb_d[l_ac_01].gzxb003
                    
                  IF li_cnt > 0 THEN 
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = "std-00006"
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                     EXIT DIALOG
                  END IF
                  #160616-00004 #1 end
               END IF
               
               
            END IF
            
            IF NOT cl_null(g_gzxb_d[l_ac_01].gzxb002) THEN 
               IF l_cmd = 'a' THEN 
                  IF g_gzxb_d[l_ac_01].gzxb002 = "0" THEN 
                     LET g_gzxb_d[l_ac_01].gzxb006 = "0"
                     LET g_gzxb_d[l_ac_01].gzxb007 = "0"
                     LET g_gzxb_d[l_ac_01].gzxb008 = "0"
                  END IF 
               END IF 
               #開放或關閉欄位
               CALL azzi800_01_chk_entey()
            END IF 

          {#ADP版次:1#}
            #END add-point


         #此段落由子樣板a04產生
         ON CHANGE gzxb002
            IF g_gzxb_d[l_ac_01].gzxb002 = "1" THEN #角色
               LET g_gzxb_d[l_ac_01].gzxh004 = ""
               LET g_gzxb_d[l_ac_01].gzxb006 = ""
               LET g_gzxb_d[l_ac_01].gzxb007 = ""
               LET g_gzxb_d[l_ac_01].gzxb008 = ""
               #額外delete gzxg_t gzxh_t 避免資料殘留
               CALL azzi800_01_extra_del(l_ac_01)
            ELSE
               LET g_gzxb_d[l_ac_01].gzxb006 = "0"
               LET g_gzxb_d[l_ac_01].gzxb007 = "0"
               LET g_gzxb_d[l_ac_01].gzxb008 = "0"            
            END IF
            LET g_gzxb_d[l_ac_01].gzxb003 = ""
            LET g_gzxb_d[l_ac_01].gzxb003_desc = ""                
            CALL g_gzxc_d.clear()

         #----<<gzxb003>>----
         #此段落由子樣板a01產生
         #角色或作業編號
         BEFORE FIELD gzxb003
            #add-point:BEFORE FIELD gzxb003
            {<point name="input.b.page1.gzxb003" />}
            #END add-point


          
           AFTER FIELD gzxb003
            #此段落由子樣板a05產生
           IF NOT cl_null(g_gzxb_d[l_ac_01].gzxb002) AND NOT cl_null(g_gzxb_d[l_ac_01].gzxb003) THEN     
              IF l_cmd = 'a' OR ( l_cmd = 'u' AND ( g_gzxb_d[l_ac_01].gzxb002 != g_gzxb_d_t.gzxb002 OR g_gzxb_d[l_ac_01].gzxb003 != g_gzxb_d_t.gzxb003)) THEN
                  #160616-00004 #1 start
#                  IF NOT ap_chk_notDup("","SELECT COUNT(1) FROM gzxb_t WHERE "||"gzxbent = '" ||g_enterprise|| "' AND "||"gzxb001 = '"||g_gzxa003_d ||"' AND "|| "gzxb002 = '"||g_gzxb_d[l_ac_01].gzxb002 ||"' AND "|| "gzxb003 = '"||g_gzxb_d[l_ac_01].gzxb003 ||"'",'std-00004',0) THEN
#                     NEXT FIELD CURRENT
#                  END IF
                  SELECT COUNT(1) INTO li_cnt FROM gzxb_t 
                   WHERE gzxbent = g_enterprise 
                    AND gzxb001 = g_gzxa003_d 
                    AND gzxb002 = g_gzxb_d[l_ac_01].gzxb002 
                    AND gzxb003 = g_gzxb_d[l_ac_01].gzxb003

                   IF li_cnt > 0 THEN 
                      INITIALIZE g_errparam TO NULL
                      LET g_errparam.code = "std-00006"
                      LET g_errparam.popup = TRUE
                      CALL cl_err()
                      EXIT DIALOG
                   END IF
                   #160616-00004 #1 end
                  INITIALIZE g_ref_fields TO NULL
                  LET g_ref_fields[1] = g_gzxb_d[l_ac_01].gzxb003
                  IF g_gzxb_d[l_ac_01].gzxb002 = "0" THEN #作業
                    CALL ap_ref_array2(g_ref_fields,"SELECT gzzal003 FROM gzzal_t WHERE  gzzal001=? AND gzzal002='"||g_dlang||"'","") RETURNING g_rtn_fields
                    LET g_gzxb_d[l_ac_01].gzxb003_desc = '', g_rtn_fields[1] , ''
                    DISPLAY BY NAME g_gzxb_d[l_ac_01].gzxb003_desc
                    #報表類不用進入功能授權管控 或 沒有action不管控
                    #CALL azzi800_01_chk_gzxb003()RETURNING li_rtn             #161225-00003 #3 mark
                    CALL azzi800_01_chk_gzxb003()RETURNING li_rtn,lc_gzzz002   #161225-00003 #3 add
                    CASE li_rtn
                       WHEN -1 
                          INITIALIZE g_errparam TO NULL 
                          LET g_errparam.extend = "" 
                          LET g_errparam.code   = "azz-00090"  #作業編號不存在或已經為無效資料
                          LET g_errparam.popup  = TRUE 
                          CALL cl_err()
                          NEXT FIELD gzxb003
                       WHEN -2
                          INITIALIZE g_errparam TO NULL
                          LET g_errparam.code = "azz-00219"
                          LET g_errparam.extend = ""
                          LET g_errparam.popup = TRUE
                          CALL cl_err()
                          NEXT FIELD gzxb003
                       WHEN 1
                          LET g_gzxb_d[l_ac_01].gzxb006 = "0" 
                          LET g_gzxb_d[l_ac_01].gzxb007 = "0"
                          LET g_gzxb_d[l_ac_01].gzxb008 = "0" 
                       OTHERWISE 
                          #先暫時不管控 
                          #IF cl_null( g_gzxb_d[l_ac_01].gzxh004)  THEN 
                          #   NEXT FIELD l_gzxh004
                          #END IF
                          #161225-00003 #3 start
                          IF l_cmd = 'u' AND (g_gzxb_d[l_ac_01].gzxb003 != g_gzxb_d_t.gzxb003  )THEN 
                             IF g_gzxb_d[l_ac_01].gzxb006 <> "0" OR g_gzxb_d[l_ac_01].gzxb007 <> "0" OR g_gzxb_d[l_ac_01].gzxb008 <> "0" THEN 
                                IF NOT s_azzi800_chk_data_permission(lc_gzzz002) THEN 
                                   LET g_gzxb_d[l_ac_01].gzxb003 = g_gzxb_d_t.gzxb003
                                   DISPLAY BY NAME g_gzxb_d[l_ac_01].gzxb003

                                   NEXT FIELD gzxb003
                                END IF
                             END IF   
                          END IF
                         #161225-00003 #3 end                          
                              
                    END CASE 
                    IF l_cmd = 'a' THEN 
                       #抓取資料授權
                       IF g_gzxb_d[l_ac_01].gzxb002 = "0" THEN 
                          IF azzi800_01_ins_gzxg() THEN
                             LET g_gzxb_d[l_ac_01].gzxh004 = azzi800_01_get_gzxh003(l_ac_01) 
                          END IF
                       END IF 
                    END IF 
                  ELSE #角色
                     SELECT COUNT(gzya001) INTO li_cnt FROM gzya_t
                       WHERE gzyastus = 'Y'
                        AND gzyaent = g_enterprise 
                        AND gzya001 = g_gzxb_d[l_ac_01].gzxb003

                      IF li_cnt = 0 THEN 
                         INITIALIZE g_errparam TO NULL
                          LET g_errparam.code = "azz-00689"
                          LET g_errparam.extend = ""
                          LET g_errparam.popup = TRUE
                          CALL cl_err()
                          NEXT FIELD gzxb003
                      END IF   
                       
                      CALL ap_ref_array2(g_ref_fields,"SELECT gzyal003 FROM gzyal_t WHERE gzyalent='"||g_enterprise||"' AND gzyal001=? AND gzyal002='"||g_dlang||"'","") RETURNING g_rtn_fields
                      LET g_gzxb_d[l_ac_01].gzxb003_desc = '', g_rtn_fields[1] , ''
                      DISPLAY BY NAME g_gzxb_d[l_ac_01].gzxb003_desc
                  END IF 
               END IF #l_cmd = 'a' OR ( l_cmd = 'u')
            END IF

          {#ADP版次:1#}
            #END add-point


         #此段落由子樣板a04產生
         ON CHANGE gzxb003
            #add-point:ON CHANGE gzxb003
            {<point name="input.g.page1.gzxb003" />}
            #END add-point

         #----<<gzxb004>>----
         #此段落由子樣板a01產生
         BEFORE FIELD gzxb004
            #add-point:BEFORE FIELD gzxb004
            {<point name="input.b.page1.gzxb004" />}
            #END add-point

         #此段落由子樣板a02產生
         AFTER FIELD gzxb004

            #add-point:AFTER FIELD gzxb004
            IF g_gzxb_d[l_ac_01].gzxb002 = "1" AND g_gzxb_d[l_ac_01].gzxb003 = "admin" THEN 
               IF NOT cl_null(g_gzxb_d[l_ac_01].gzxb004) THEN 
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = ""
                  LET g_errparam.code   = "azz-00319" 
                  LET g_errparam.popup  = TRUE 
                  CALL cl_err()
                  NEXT FIELD gzxb004
               END IF  
            END IF 
            #END add-point


         #此段落由子樣板a04產生
         ON CHANGE gzxb004
            #add-point:ON CHANGE gzxb004
            {<point name="input.g.page1.gzxb004" />}
            #END add-point

         #----<<gzxb005>>----
         #此段落由子樣板a01產生
         BEFORE FIELD gzxb005
            #add-point:BEFORE FIELD gzxb005
            {<point name="input.b.page1.gzxb005" />}
            #END add-point

         #此段落由子樣板a02產生
         AFTER FIELD gzxb005

            #add-point:AFTER FIELD gzxb005
           IF g_gzxb_d[l_ac_01].gzxb002 = "1" AND g_gzxb_d[l_ac_01].gzxb003 = "admin" THEN 
               IF NOT cl_null(g_gzxb_d[l_ac_01].gzxb005) THEN 
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = ""
                  LET g_errparam.code   = "azz-00319" 
                  LET g_errparam.popup  = TRUE 
                  CALL cl_err()
                  NEXT FIELD gzxb005
               END IF  
            END IF
            #END add-point


         #此段落由子樣板a04產生
         ON CHANGE gzxb005
            #add-point:ON CHANGE gzxb005
            {<point name="input.g.page1.gzxb005" />}
            #END add-point
            
         BEFORE FIELD l_gzxh004 
            IF NOT cl_null(g_gzxb_d[l_ac_01].gzxb002) THEN 
               CALL azzi800_01_chk_entey()
            END IF 
            
         AFTER FIELD l_gzxh004
               IF g_gzxb_d[l_ac_01].gzxb002 = "0" THEN #作業
                  #報表類不用進入功能授權管控 或 沒有action不管控
                  #CALL azzi800_01_chk_gzxb003()RETURNING li_rtn 161225-00003 mark
                  CALL azzi800_01_chk_gzxb003()RETURNING li_rtn,lc_gzzz002   #161225-00003 add 
                    CASE li_rtn
                       WHEN -1 
                          INITIALIZE g_errparam TO NULL 
                          LET g_errparam.extend = "" 
                          LET g_errparam.code   = "azz-00090"  #作業編號不存在或已經為無效資料
                          LET g_errparam.popup  = TRUE 
                          CALL cl_err()
                          NEXT FIELD gzxb003
                       WHEN -2
                          INITIALIZE g_errparam TO NULL
                          LET g_errparam.code = "azz-00219"
                          LET g_errparam.extend = ""
                          LET g_errparam.popup = TRUE
                          CALL cl_err()
                          NEXT FIELD gzxb003
                       WHEN 1
                          LET g_gzxb_d[l_ac_01].gzxb006 = "0" 
                          LET g_gzxb_d[l_ac_01].gzxb007 = "0"
                          LET g_gzxb_d[l_ac_01].gzxb008 = "0" 
                       OTHERWISE 
                          #先暫時不管控  start
                          #IF cl_null(g_gzxb_d[l_ac_01].gzxh004) THEN 
                          #   NEXT FIELD l_gzxh004
                          #END IF 
                          #IF cl_null(g_gzxb_d[l_ac_01].gzxb006) THEN 
                          #   NEXT FIELD gzxb006
                          #END IF 
                          #IF cl_null(g_gzxb_d[l_ac_01].gzxb007) THEN 
                          #   NEXT FIELD gzxb007
                          #END IF
                          #IF cl_null(g_gzxb_d[l_ac_01].gzxb008) THEN 
                          #   NEXT FIELD gzxb008
                          #END IF
                          #           end  
                    END CASE                                           
               END IF
        
        BEFORE FIELD gzxb006 
           IF NOT cl_null(g_gzxb_d[l_ac_01].gzxb002) THEN 
               CALL azzi800_01_chk_entey()
            END IF            
        
        AFTER FIELD gzxb006
           #161225-00003 #3 start
           IF NOT cl_null(g_gzxb_d[l_ac_01].gzxb006) THEN
              CALL cl_get_prog_code(g_gzxb_d[l_ac_01].gzxb003) RETURNING lc_gzzz002 
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_gzxb_d[l_ac_01].gzxb006 != g_gzxb_d_t.gzxb006)) THEN 
                  IF g_gzxb_d[l_ac_01].gzxb006 <> "0" THEN
                     IF NOT s_azzi800_chk_data_permission(lc_gzzz002) THEN 
                        LET g_gzxb_d[l_ac_01].gzxb006 = "0"
                        DISPLAY BY NAME g_gzxb_d[l_ac_01].gzxb006
                        NEXT FIELD gzxb006
                     END IF
                  END IF 
               END IF 
           END IF 
          #161225-00003 #3 end 
          
         BEFORE FIELD gzxb007
            IF NOT cl_null(g_gzxb_d[l_ac_01].gzxb002) THEN 
               CALL azzi800_01_chk_entey()
            END IF    
         
         AFTER FIELD gzxb007
           #161225-00003 #3 start         
           IF NOT cl_null(g_gzxb_d[l_ac_01].gzxb007) THEN
              CALL cl_get_prog_code(g_gzxb_d[l_ac_01].gzxb003) RETURNING lc_gzzz002 
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_gzxb_d[l_ac_01].gzxb007 != g_gzxb_d_t.gzxb007)) THEN 
                  IF g_gzxb_d[l_ac_01].gzxb007 <> "0" THEN
                     IF NOT s_azzi800_chk_data_permission(lc_gzzz002) THEN 
                        LET g_gzxb_d[l_ac_01].gzxb007 = "0"
                        DISPLAY BY NAME g_gzxb_d[l_ac_01].gzxb007
                        NEXT FIELD gzxb007
                     END IF
                  END IF 
               END IF 
           END IF
           #161225-00003 #3 end
           
         BEFORE FIELD gzxb008
            IF NOT cl_null(g_gzxb_d[l_ac_01].gzxb002) THEN 
               CALL azzi800_01_chk_entey()
            END IF
            
         AFTER FIELD gzxb008
           #161225-00003 #3 start
           IF NOT cl_null(g_gzxb_d[l_ac_01].gzxb008) THEN           
               CALL cl_get_prog_code(g_gzxb_d[l_ac_01].gzxb003) RETURNING lc_gzzz002  
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_gzxb_d[l_ac_01].gzxb008 != g_gzxb_d_t.gzxb008)) THEN 
                  IF g_gzxb_d[l_ac_01].gzxb008 <> "0" THEN  
                     IF NOT s_azzi800_chk_data_permission(lc_gzzz002) THEN 
                       LET g_gzxb_d[l_ac_01].gzxb008 = "0"
                       DISPLAY BY NAME g_gzxb_d[l_ac_01].gzxb008
                       NEXT FIELD gzxb008
                     END IF
                  END IF 
               END IF 
           END IF         
           #161225-00003 #3 end
           
         #----<<gzxb003>>----
         #Ctrlp:input.c.page1.gzxb003
         ON ACTION controlp INFIELD gzxb003
           #add-point:ON ACTION controlp INFIELD gzxb003
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_gzxb_d[l_ac_01].gzxb003              #給予default值
            IF NOT cl_null(g_gzxb_d[l_ac_01].gzxb002) THEN 
               IF g_gzxb_d[l_ac_01].gzxb002 = "1" THEN #1 角色 0 作業
                  CALL q_gzya001()                                           #呼叫開窗            
               ELSE 
                  CALL q_gzzz001_1()
               END IF
               LET g_gzxb_d[l_ac_01].gzxb003 = g_qryparam.return1            #將開窗取得的值回傳到變數
               DISPLAY g_gzxb_d[l_ac_01].gzxb003 TO gzxb003                  #顯示到畫面上
               NEXT FIELD gzxb003   
            END IF 
            #END add-point

         ON ACTION controlp INFIELD l_gzxh004
             IF g_gzxb_d[l_ac_01].gzxb002 = "0" THEN 
                IF azzi800_01_ins_gzxg() THEN
                   CALL azzi800_03(g_gzxa003_d,g_gzxb_d[l_ac_01].gzxb003) RETURNING ls_str,li_rtn
                END IF
             END IF    
             IF li_rtn THEN
               LET g_gzxb_d[l_ac_01].gzxh004 = ls_str
            END IF

         AFTER INPUT
            #add-point:單身輸入後處理

            #end add-point

      END INPUT
END DIALOG
################################################################################
# Descriptions...: 描述说明
# Memo...........:
# Usage..........: azzi800_01_1_construct()
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 日期 By 作者
# Modify.........:
################################################################################
DIALOG azzi800_01_1_construct()
    CONSTRUCT g_wc3_01 ON gzxcstus,gzxc004,gzxc005,gzxc006,gzxc007

         FROM s_detail1_03[1].gzxcstus,s_detail1_03[1].gzxc004,s_detail1_03[1].gzxc005,s_detail1_03[1].gzxc006,s_detail1_03[1].gzxc007


         #---------------------<  Detail: page1  >---------------------
         #----<<gzxcstus>>----
         #此段落由子樣板a01產生
         BEFORE FIELD gzxcstus
            #add-point:BEFORE FIELD gzxcstus
            {<point name="query.b.page1.gzxcstus" />}
            #END add-point

         #此段落由子樣板a02產生
         AFTER FIELD gzxcstus

            #add-point:AFTER FIELD gzxcstus
            {<point name="query.a.page1.gzxcstus" />}
            #END add-point

         #----<<gzxc004>>----
         #此段落由子樣板a01產生
         BEFORE FIELD gzxc004
            #add-point:BEFORE FIELD gzxc004
            {<point name="query.b.page1.gzxc001" />}
            #END add-point

         #此段落由子樣板a02產生
         AFTER FIELD gzxc004

            #add-point:AFTER FIELD gzxc004
            {<point name="query.a.page1.gzxc004" />}
            #END add-point


         #Ctrlp:query.c.page1.gzxc004
         ON ACTION controlp INFIELD gzxc004
            #add-point:ON ACTION controlp INFIELD gzxc004
                       
           INITIALIZE g_qryparam.* TO NULL
           LET g_qryparam.state = 'c'
           LET g_qryparam.reqry = FALSE
           
           LET g_qryparam.default1 = g_gzxc_d[l_ac_03].gzxc004       #給予default值
           #給予arg
           CALL q_gzxc004()                                          #呼叫開窗
           DISPLAY g_qryparam.return1 TO gzxc004                     #顯示到畫面上
           NEXT FIELD gzxc004  
            #END add-point

         #此段落由子樣板a02產生
         AFTER FIELD gzxc005

         #----<<gzxc006>>----
         #此段落由子樣板a01產生
         BEFORE FIELD gzxc006
            #add-point:BEFORE FIELD gzxc006
            --{<point name="query.b.page1.gzxc006" />}
            #END add-point

         #此段落由子樣板a02產生
         AFTER FIELD gzxc006

            #add-point:AFTER FIELD gzxc006
            {<point name="query.a.page1.gzxc006" />}
            #END add-point

        #此段落由子樣板a02產生
         AFTER FIELD gzxc007

            #add-point:AFTER FIELD gzxc007
            {<point name="query.a.page1.gzxc007" />}
            #END add-point

         #----<<gzxc007>>----
         #Ctrlp:construct.c.page1.gzxc007
         ON ACTION controlp INFIELD gzxc007
            #add-point:ON ACTION controlp INFIELD gzxc007
            #此段落由子樣板a08產生
            #開窗c段

            NEXT FIELD gzxc007                     #返回原欄位


            #END add-point


         BEFORE CONSTRUCT
            #CALL cl_qbe_init()
            #add-point:cs段more_construct
            --{<point name="cs.before_construct"/>}

            #end add-point

         ON ACTION qbe_select
            #CALL cl_qbe_select()

         ON ACTION qbe_save
            #CALL cl_qbe_save()

      END CONSTRUCT
END DIALOG

 
{</section>}
 
{<section id="azzi800_01.other_function" readonly="Y" >}

PUBLIC FUNCTION azzi800_01(--)
   #add-point:main段變數傳入
   {<point name="main.get_var"/>}
   #end add-point
   )
   #add-point:main段define
   {<point name="main.define"/>}
   #end add-point

   #設定SQL錯誤記錄方式 (模組內定義有效)
   WHENEVER ERROR CALL cl_err_msg_log

   #add-point:作業初始化
   {<point name="main.init" />}
   #end add-point



   #LOCK CURSOR (identifier)
   #add-point:SQL_define
   {<point name="main.define_sql" mark="Y"/>}
   #end add-point
   LET g_forupd_sql = ""
   #add-point:SQL_define
   {<point name="main.after_define_sql"/>}
   #end add-point
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)   #轉換不同資料庫語法
   DECLARE azzi800_01_cl CURSOR FROM g_forupd_sql     # LOCK CURSOR


   #畫面開啟 (identifier)
   OPEN WINDOW w_azzi800_01 WITH FORM cl_ap_formpath("azz","azzi800_01")

   #瀏覽頁簽資料初始化
   CALL cl_ui_init()

   #程式初始化
   CALL azzi800_01_init()

   #進入選單 Menu (="N")
   CALL azzi800_01_ui_dialog()

   #畫面關閉
   CLOSE WINDOW w_azzi800_01

   CLOSE azzi800_01_cl

   #add-point:離開前
   {<point name="main.exit" />}
   #end add-point

END FUNCTION

PRIVATE FUNCTION azzi800_01_init()
   #add-point:init段define
   {<point name="init.define"/>}
   #end add-point

   CALL cl_set_combo_scc('gzxb002','86')
#   CALL cl_set_combo_scc('gzxb006','154') 
#   CALL cl_set_combo_scc('gzxb007','155') 
#   CALL cl_set_combo_scc('gzxb008','156') 
   LET g_error_show = 1

   #add-point:畫面資料初始化
   {<point name="init.init" />}
   #end add-point

   CALL azzi800_01_default_search()

END FUNCTION

PRIVATE FUNCTION azzi800_01_ui_dialog()
   {<Local define>}
   DEFINE li_idx   LIKE type_t.num5
   {</Local define>}
   #add-point:ui_dialog段define
   {<point name="ui_dialog.define"/>}
   #end add-point

   LET g_action_choice = " "
   LET gwin_curr = ui.Window.getCurrent()
   LET gfrm_curr = gwin_curr.getForm()

   CALL cl_set_act_visible("accept,cancel", FALSE)

   LET g_detail_idx = 1

   #add-point:ui_dialog段before dialog
   {<point name="ui_dialog.before_dialog"/>}
   #end add-point

   WHILE TRUE

      CALL azzi800_01_b_fill(g_wc2)

      DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
         DISPLAY ARRAY g_gzxb_d TO s_detail1.* ATTRIBUTE(COUNT=g_detail_cnt)

            BEFORE DISPLAY
               CALL FGL_SET_ARR_CURR(g_detail_idx)

            BEFORE ROW
               LET g_detail_idx = DIALOG.getCurrentRow("s_detail1")
               LET l_ac = g_detail_idx
               LET g_temp_idx = l_ac

               DISPLAY g_detail_idx TO FORMONLY.idx
               CALL cl_show_fld_cont()

            #自訂ACTION(detail_show,page_1)

         END DISPLAY

         #add-point:ui_dialog段define
         {<point name="ui_dialog.more_displayarray"/>}
         #end add-point

         BEFORE DIALOG
            IF g_temp_idx > 0 THEN
               LET l_ac = g_temp_idx
               CALL DIALOG.setCurrentRow("s_detail1",l_ac)
               LET g_temp_idx = 1
            END IF
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL DIALOG.setSelectionMode("s_detail1", 1)
            NEXT FIELD CURRENT


         ON ACTION close
            LET INT_FLAG=FALSE
            LET g_action_choice="exit"
            EXIT DIALOG

         ON ACTION exit
            LET g_action_choice="exit"
            EXIT DIALOG


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

PRIVATE FUNCTION azzi800_01_query()
   {<Local define>}
   DEFINE ls_wc      LIKE type_t.chr500
   DEFINE ls_return  STRING
   DEFINE ls_result  STRING
   {</Local define>}
   #add-point:query段define
   {<point name="query.define"/>}
   #end add-point

   LET INT_FLAG = 0
   CLEAR FORM
   CALL g_gzxb_d.clear()

   LET g_qryparam.state = "c"

   #wc備份
   LET ls_wc = g_wc2_01

   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)

      # 取代原CONSTRUCT區塊
      SUBDIALOG azzi800_01_construct
      #end add-point

      #add-point:query段more_construct
      {<point name="query.more_construct"/>}
      #end add-point

      ON ACTION accept
         EXIT DIALOG

      ON ACTION cancel
         LET INT_FLAG = 1
         EXIT DIALOG

      #交談指令共用ACTION
      &include "common_action.4gl"
         CONTINUE DIALOG
   END DIALOG

   #add-point:query段after_construct
   {<point name="query.after_construct"/>}
   #end add-point

   #LET g_wc2 = g_wc2 CLIPPED, cl_get_extra_cond("", "")

   IF INT_FLAG THEN
      LET INT_FLAG = 0
      #還原
      LET g_wc2_01 = ls_wc
   END IF

   LET g_error_show = 1
   CALL azzi800_01_b_fill(g_wc2_01)

   IF g_detail_cnt = 0 AND NOT INT_FLAG THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = -100
      LET g_errparam.extend = ""
      LET g_errparam.popup = TRUE
      CALL cl_err()

   END IF

   LET INT_FLAG = FALSE

END FUNCTION

PRIVATE FUNCTION azzi800_01_insert()
   {<Local define>}
   DEFINE li_ac LIKE type_t.num5
   DEFINE l_var_keys      DYNAMIC ARRAY OF STRING
   DEFINE l_var_keys_bak  DYNAMIC ARRAY OF STRING
   DEFINE l_field_keys    DYNAMIC ARRAY OF STRING
   DEFINE l_vars          DYNAMIC ARRAY OF STRING
   DEFINE l_fields        DYNAMIC ARRAY OF STRING
   {</Local define>}
   #add-point:delete段define
   {<point name="insert.define"/>}
   #end add-point

   #輸入前動作
   LET li_ac = l_ac
   LET l_ac = 1
   LET g_before_input_done = FALSE
   CALL azzi800_01_set_entry_b("a")

   CALL azzi800_01_set_no_entry_b("a")
   LET g_before_input_done = TRUE

   #append欄位

   #add-point:insert段before insert
   {<point name="insert.before_insert"/>}
   #end add-point

   #資料輸入
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)

         # 取代原INPUT ARRAY區塊
         SUBDIALOG azzi800_01_input
         SUBDIALOG azzi800_01_1_input

      BEFORE DIALOG

   END DIALOG

   #輸入後動作
   IF INT_FLAG THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 9001
      LET g_errparam.extend = ""
      LET g_errparam.popup = FALSE
      CALL cl_err()

      LET INT_FLAG = 1
      RETURN
   END IF

   CALL s_transaction_begin()

   #add-point:單身新增前
   {<point name="insert.b_insert"/>}
   #end add-point


   #add-point:單身新增後
   {<point name="insert.a_insert"/>}
   #end add-point

END FUNCTION

PRIVATE FUNCTION azzi800_01_delete()
   DEFINE li_ac LIKE type_t.num5
   #add-point:delete段define
   {<point name="delete.define"/>}
   #end add-point

#   IF NOT cl_ask_delete() THEN
#      LET INT_FLAG = 1 #不刪除
#   ELSE
#      LET INT_FLAG = 0 #要刪除
#   END IF
#
#   LET li_ac = ARR_CURR()
#
#   CALL s_transaction_begin()
#
#   #add-point:delete段刪除前
#   {<point name="delete.b_delete" mark="Y"/>}
#   #end add-point
#   DELETE FROM gzxb_t
#         WHERE gzxb001 = g_gzxb_d[li_ac].gzxb001
#           AND gzxb002 = g_gzxb_d[li_ac].gzxb002
#
#           AND gzxb003 = g_gzxb_d[li_ac].gzxb003
#
#
#   #add-point:delete段刪除中
#   {<point name="delete.m_delete"/>}
#   #end add-point
#   IF SQLCA.sqlcode THEN
#      CALL cl_err("gzxb_t",SQLCA.sqlcode,1)
#      CALL s_transaction_end('N','0')
#   ELSE
#      CALL s_transaction_end('Y','0')
#   END IF
#   #add-point:delete段刪除後
#   {<point name="delete.a_delete"/>}
#   #end add-point
#
END FUNCTION

PRIVATE FUNCTION azzi800_01_modify()
   {<Local define>}
   DEFINE  l_cmd           LIKE type_t.chr1
   DEFINE  l_ac_t          LIKE type_t.num5                #未取消的ARRAY CNT
   DEFINE  l_n             LIKE type_t.num5                #檢查重複用
   DEFINE  l_cnt           LIKE type_t.num5                #檢查重複用
   DEFINE  l_lock_sw       LIKE type_t.chr1                #單身鎖住否
   DEFINE  l_allow_insert  LIKE type_t.num5                #可新增否
   DEFINE  l_allow_delete  LIKE type_t.num5                #可刪除否
   DEFINE  l_count         LIKE type_t.num5
   DEFINE  l_i             LIKE type_t.num5
   DEFINE  ls_return       STRING
   DEFINE  l_var_keys      DYNAMIC ARRAY OF STRING
   DEFINE  l_field_keys    DYNAMIC ARRAY OF STRING
   DEFINE  l_vars          DYNAMIC ARRAY OF STRING
   DEFINE  l_fields        DYNAMIC ARRAY OF STRING
   DEFINE  l_var_keys_bak  DYNAMIC ARRAY OF STRING
   {</Local define>}
   #add-point:modify段define
   {<point name="modify.define"/>}
   #end add-point

   LET g_action_choice = ""

   LET g_qryparam.state = "i"

   LET l_allow_insert = cl_auth_detail_input("insert")
   LET l_allow_delete = cl_auth_detail_input("delete")

   #add-point:modify段define_sql
   {<point name="modify.define_sql" mark="Y"/>}
   #end add-point
   #LET g_forupd_sql = "SELECT gzxbstus,gzxb001,gzxb002,gzxb003,gzxb004,gzxb005 FROM gzxb_t WHERE gzxbent=? AND gzxb001=? AND gzxb002=? AND gzxb003=? FOR UPDATE"
   #add-point:modify段define_sql
   {<point name="modify.after_define_sql"/>}
   #end add-point
   #LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)
   #DECLARE azzi800_01_bcl CURSOR FROM g_forupd_sql      # LOCK CURSOR

   LET INT_FLAG = FALSE

   #add-point:modify段修改前
   {<point name="modify.before_input"/>}
   #end add-point

   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)

      # 取代原INPUT ARRAY區塊
      SUBDIALOG azzi800_01_input
      SUBDIALOG azzi800_01_1_input

      BEFORE DIALOG
         LET g_curr_diag = ui.DIALOG.getCurrent()
         
      ON ACTION accept
         ACCEPT DIALOG

      ON ACTION cancel
         LET INT_FLAG = TRUE
         EXIT DIALOG

      ON ACTION controlr
         CALL cl_show_req_fields()

      ON ACTION controlf
         CALL cl_set_focus_form(ui.Interface.getRootNode())
              RETURNING g_fld_name,g_frm_name
         CALL cl_fldhelp(g_frm_name,g_fld_name,g_dlang)

      #交談指令共用ACTION
      &include "common_action.4gl"
         CONTINUE DIALOG

   END DIALOG

   #add-point:modify段修改後
   {<point name="modify.after_input"/>}
   #end add-point

   CLOSE azzi800_01_1_bcl
   CLOSE azzi800_01_bcl
   CALL s_transaction_end('Y','0')

END FUNCTION

PUBLIC FUNCTION azzi800_01_b_fill(p_wc2)
   #BODY FILL UP
   {<Local define>}
   DEFINE p_wc2           STRING
   {</Local define>}
   #add-point:b_fill段define
   {<point name="b_fill.define"/>}
   #end add-point

   IF cl_null(p_wc2) THEN
      LET p_wc2 = " 1=1"
   END IF

   #add-point:b_fill段sql
   {<point name="b_fill.sql_before"/>}
   # 避免移動到下一筆時, cnt, idx值未清空
   LET g_detail_idx_01 = 0
   LET g_detail_cnt_01 = 0
   #end add-point

   LET g_sql = "SELECT  DISTINCT gzxbstus,gzxb001,gzxb002,gzxb003,'',gzxb004,gzxb005,'',gzxb006,gzxb007,gzxb008 FROM gzxb_t",
               " INNER JOIN gzxa_t ON gzxa003 = gzxb001 ",
               " LEFT  JOIN gzxe_t ON gzxe001 = gzxb001 ",

                  "",
                  " LEFT JOIN gzxc_t ON gzxbent = gzxcent AND gzxb001 = gzxc001 AND gzxb002 = gzxc002 AND gzxb003 = gzxc003 ",
                  " WHERE gzxbent='",g_enterprise CLIPPED,"' AND 1=1 AND ",p_wc2
    LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
    IF NOT cl_null(g_wc2_01) THEN
         LET g_sql = g_sql CLIPPED, " AND ", g_wc2_01 CLIPPED
    END IF

      #子單身的WC
    IF NOT cl_null(g_wc3_01) THEN
      LET g_sql = g_sql CLIPPED," AND ", g_wc3_01 CLIPPED
    END IF

    IF NOT cl_null(g_wc2_02) THEN
      LET g_sql = g_sql CLIPPED," AND ", g_wc2_02 CLIPPED
    END IF  
   LET g_sql = g_sql, " ORDER BY gzxb_t.gzxb001"

   PREPARE azzi800_01_pb FROM g_sql
   DECLARE b_fill_curs CURSOR FOR azzi800_01_pb
   CALL g_gzxb_d.clear()
   #假如是0 預設給1避免g_cnt為0
   IF l_ac_01 = 0 THEN 
      LET l_ac_01 = 1
   END IF   
   LET g_cnt = l_ac_01
   LET l_ac_01 = 1

#   ERROR "Searching!"

   FOREACH b_fill_curs INTO g_gzxb_d[l_ac_01].gzxbstus,g_gzxb_d[l_ac_01].gzxb001,g_gzxb_d[l_ac_01].gzxb002,
                            g_gzxb_d[l_ac_01].gzxb003,g_gzxb_d[l_ac_01].gzxb003_desc,g_gzxb_d[l_ac_01].gzxb004,
                            g_gzxb_d[l_ac_01].gzxb005,g_gzxb_d[l_ac_01].gzxh004,g_gzxb_d[l_ac_01].gzxb006,g_gzxb_d[l_ac_01].gzxb007,g_gzxb_d[l_ac_01].gzxb008
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "FOREACH:"
         LET g_errparam.popup = TRUE
         CALL cl_err()

         EXIT FOREACH
      END IF

      #add-point:b_fill段資料填充
      {<point name="b_fill.fill"/>}
      #end add-point
      CALL azzi800_01_detail_show("gzxb_t")

      IF g_gzxb_d[l_ac_01].gzxb002 = "0" THEN 
         LET g_gzxb_d[l_ac_01].gzxh004 = azzi800_01_get_gzxh003(l_ac_01) 
      END IF 
      LET l_ac_01 = l_ac_01 + 1
      IF l_ac_01 > g_max_rec THEN
         #CALL cl_err( "", 9035, 0 )
         EXIT FOREACH
      END IF

   END FOREACH

   CALL g_gzxb_d.deleteElement(g_gzxb_d.getLength())

   #將key欄位填到每個page
   #FOR l_ac_01 = 1 TO g_gzxb_d.getLength()

   #END FOR
  
   #add-point:b_fill段資料填充(其他單身)
   {<point name="b_fill.others.fill"/>}
   # 預設搜尋後第一次的index值
   IF g_gzxb_d.getLength() > 0 THEN
      LET g_detail_idx_01 = 1
   END IF
   #end add-point

   LET g_detail_cnt_01 = l_ac_01 - 1
   DISPLAY g_detail_cnt_01 TO FORMONLY.cnt
   IF g_cnt > g_gzxb_d.getLength() THEN
      LET l_ac_01 = g_gzxb_d.getLength()
   ELSE
      LET l_ac_01 = g_cnt
   END IF

   LET g_cnt = 0

   IF l_ac_01 = 0 OR g_gzxb_d.getLength() = 0 THEN
       LET g_gzxb002_d = ''
       LET g_gzxb003_d = ''
   ELSE
       LET g_gzxb002_d = g_gzxb_d[l_ac_01].gzxb002  
       LET g_gzxb003_d = g_gzxb_d[l_ac_01].gzxb003  
   END IF

   CALL azzi800_01_b2_fill(g_wc3_01) 
   CLOSE b_fill_curs
   FREE azzi800_01_pb

END FUNCTION

PRIVATE FUNCTION azzi800_01_detail_show(ps_table)
   #add-point:show段define
   {<point name="detail_show.define"/>}
   DEFINE ps_table STRING 
   #end add-point

   #add-point:detail_show段之前
   {<point name="detail_show.before"/>}
   #end add-point

   #帶出公用欄位reference值page1
   #此段落由子樣板a12產生
      INITIALIZE g_ref_fields TO NULL
      IF ps_table = "gzxb_t" THEN 
          
         LET g_ref_fields[1] = g_gzxb_d[l_ac_01].gzxb003         
         IF g_gzxb_d[l_ac_01].gzxb002 = "0" THEN #作業
            CALL ap_ref_array2(g_ref_fields,"SELECT gzzal003 FROM gzzal_t WHERE  gzzal001=? AND gzzal002='"||g_dlang||"'","") RETURNING g_rtn_fields
         ELSE
            CALL ap_ref_array2(g_ref_fields,"SELECT gzyal003 FROM gzyal_t WHERE gzyalent='"||g_enterprise||"' AND gzyal001=? AND gzyal002='"||g_dlang||"'","") RETURNING g_rtn_fields         
         END IF 
         LET g_gzxb_d[l_ac_01].gzxb003_desc = '', g_rtn_fields[1] , ''
         DISPLAY BY NAME g_gzxb_d[l_ac_01].gzxb003_desc
      ELSE 
         #INITIALIZE g_ref_fields TO NULL
         LET g_ref_fields[1] = g_gzxc_d[l_ac_03].gzxc004
         CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
         LET g_gzxc_d[l_ac_03].gzxc004_desc = '', g_rtn_fields[1] , ''
         DISPLAY BY NAME g_gzxc_d[l_ac_03].gzxc004_desc
      
      END IF 
     
   #讀入ref值
   #add-point:show段單身reference
   {<point name="detail_show.reference"/>}
   #end add-point

   #add-point:detail_show段之後
   {<point name="detail_show.after"/>}
   #end add-point

END FUNCTION

PRIVATE FUNCTION azzi800_01_set_entry_b(p_cmd)
   {<Local define>}
   DEFINE p_cmd   LIKE type_t.chr1
   {</Local define>}
   #add-point:set_entry_b段define
   {<point name="set_entry_b.define"/>}
   #end add-point

   #add-point:set_entry_b段control
   {<point name="set_entry_b.set_entry_b"/>}
   #end add-point

END FUNCTION

PRIVATE FUNCTION azzi800_01_set_no_entry_b(p_cmd)
   {<Local define>}
   DEFINE p_cmd   LIKE type_t.chr1
   {</Local define>}
   #add-point:set_no_entry_b段define
   {<point name="set_no_entry_b.define"/>}
   #end add-point

   #add-point:set_no_entry_b段control
   {<point name="set_no_entry_b.set_no_entry_b"/>}
   #end add-point

END FUNCTION

PRIVATE FUNCTION azzi800_01_default_search()
   {<Local define>}
   DEFINE li_idx  LIKE type_t.num5
   DEFINE li_cnt  LIKE type_t.num5
   DEFINE ls_wc   STRING
   {</Local define>}
   #add-point:default_search段define
   {<point name="default_search.define"/>}
   #end add-point

   IF NOT cl_null(g_argv[1]) THEN
      LET ls_wc = ls_wc, " gzxb001 = '", g_argv[1], "' AND "
   END IF

   IF NOT cl_null(g_argv[02]) THEN
      LET ls_wc = ls_wc, " gzxb002 = ", g_argv[02], " AND "
   END IF

   IF NOT cl_null(g_argv[03]) THEN
      LET ls_wc = ls_wc, " gzxb003 = ", g_argv[03], " AND "
   END IF

   IF NOT cl_null(ls_wc) THEN
      LET ls_wc = ls_wc.subString(1,ls_wc.getLength()-5)
      LET g_wc2 = ls_wc
   ELSE
      LET g_wc2 = " 1=1"
   END IF

END FUNCTION

PRIVATE FUNCTION azzi800_01_delete_b(ps_table,ps_keys_bak,ps_page)
   DEFINE ps_table    STRING
   DEFINE ps_page     STRING
   DEFINE ps_keys_bak DYNAMIC ARRAY OF VARCHAR(500)
   DEFINE ls_group    STRING
   DEFINE li_idx      LIKE type_t.num5
   DEFINE l_gzxbmodid LIKE gzxb_t.gzxbmodid  #160815-00018#1-add
   DEFINE l_gzxbmoddt LIKE gzxb_t.gzxbmoddt  #160815-00018#1-add   
   
   LET g_update = TRUE  
   
   #判斷是否是同一群組的table
   LET ls_group = "'1',"
   IF ps_table.getIndexOf("gzxb_t",1)  THEN
   
       DELETE FROM gzxb_t WHERE gzxbent = g_enterprise 
         AND gzxb001 = ps_keys_bak[1] 
         AND gzxb002 = ps_keys_bak[2] 
         AND gzxb003 = ps_keys_bak[3]

      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "gzxb_t" 
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = FALSE 
         CALL cl_err()
         RETURN FALSE
      #160815-00018#1-add-(S)
      ELSE
         #異動最近修改者/最近修改日期
         LET l_gzxbmodid = g_user
         LET l_gzxbmoddt = cl_get_current()
         UPDATE gzxa_t
            SET (gzxamodid,gzxamoddt)
              = (l_gzxbmodid,l_gzxbmoddt)
          WHERE gzxaent = g_enterprise AND gzxa003 = ps_keys_bak[1] 
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.EXTEND = ""
            LET g_errparam.code   = SQLCA.sqlcode
            LET g_errparam.popup  = FALSE
            CALL cl_err()
            RETURN FALSE
         END IF
      #160815-00018#1-add-(E)
      END IF
      LET li_idx = g_detail_idx_01
      IF ps_page <> "'1'" THEN 
         CALL g_gzxb_d.deleteElement(li_idx) 
      END IF 
 
   END IF

   IF ps_table.getIndexOf("gzxc_t",1)  THEN

      DELETE FROM gzxc_t 
       WHERE gzxcent = g_enterprise 
        AND gzxc001 = ps_keys_bak[1] 
        AND gzxc002 = ps_keys_bak[2]  
        AND gzxc003 = ps_keys_bak[3] 
        AND gzxc004 = ps_keys_bak[4]

        IF SQLCA.sqlcode THEN
           INITIALIZE g_errparam TO NULL 
           LET g_errparam.extend = "gzxc_t" 
           LET g_errparam.code   = SQLCA.sqlcode 
           LET g_errparam.popup  = FALSE 
           CALL cl_err()
           RETURN FALSE
        END IF 
        LET li_idx = g_detail_idx_03
        IF ps_page <> "'1'" THEN 
           CALL g_gzxc_d.deleteElement(li_idx) 
        END IF
   END IF 
   
   RETURN TRUE
END FUNCTION

PRIVATE FUNCTION azzi800_01_insert_b(ps_table,ps_keys,ps_page)
   {<Local define>}
   DEFINE ps_table    STRING
   DEFINE ps_page     STRING
   DEFINE ps_keys     DYNAMIC ARRAY OF VARCHAR(500)
   DEFINE ls_group    STRING
   {</Local define>}
   #add-point:insert_b段define
   {<point name="insert_b.define"/>}
   #end add-point

   #判斷是否是同一群組的table
   LET ls_group = "gzxb_t,"
      #add-point:insert_b段新增前
      {<point name="insert_b.b_insert" mark="Y"/>}
      #end add-point
      INSERT INTO gzxb_t
                  (gzxbent,
                   gzxb001,gzxb002,gzxb003
                   ,gzxbstus,gzxb004,gzxb005)
            VALUES(g_enterprise,
                   ps_keys[1],ps_keys[2],ps_keys[3]
                   ,g_gzxb_d[l_ac].gzxbstus,g_gzxb_d[l_ac].gzxb004,g_gzxb_d[l_ac].gzxb005)
      #add-point:insert_b段新增中
      {<point name="insert_b.m_insert"/>}
      #end add-point
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "gzxb_t"
         LET g_errparam.popup = FALSE
         CALL cl_err()

      END IF
      #add-point:insert_b段新增後
      {<point name="insert_b.a_insert"/>}
      #end add-point
END FUNCTION

PRIVATE FUNCTION azzi800_01_update_b(ps_table,ps_keys,ps_keys_bak,ps_page)
   {<Local define>}
   DEFINE ps_page          STRING
   DEFINE ps_table         STRING
   DEFINE ps_keys          DYNAMIC ARRAY OF VARCHAR(500)
   DEFINE ps_keys_bak      DYNAMIC ARRAY OF VARCHAR(500)
   DEFINE ls_group         STRING
   DEFINE li_idx           LIKE type_t.num5
   DEFINE lb_chk           BOOLEAN
   DEFINE l_new_key        DYNAMIC ARRAY OF STRING
   DEFINE l_old_key        DYNAMIC ARRAY OF STRING
   DEFINE l_field_key      DYNAMIC ARRAY OF STRING
   {</Local define>}
   #add-point:update_b段define
   {<point name="update_b.define"/>}
   #end add-point

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
   LET ls_group = "gzxb_t,"
      #add-point:update_b段修改前
      {<point name="update_b.b_update" mark="Y"/>}
      #end add-point
      UPDATE gzxb_t
         SET (gzxb001,gzxb002,gzxb003
              ,gzxbstus,gzxb004,gzxb005)
              =
             (ps_keys[1],ps_keys[2],ps_keys[3]
              ,g_gzxb_d[l_ac].gzxbstus,g_gzxb_d[l_ac].gzxb004,g_gzxb_d[l_ac].gzxb005)
         WHERE gzxb001 = ps_keys_bak[1] AND gzxb002 = ps_keys_bak[2] AND gzxb003 = ps_keys_bak[3]
      #add-point:update_b段修改中
      {<point name="update_b.m_update"/>}
      #end add-point
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = ""
         LET g_errparam.popup = FALSE
         CALL cl_err()
      ELSE

      END IF
      #add-point:update_b段修改後
      {<point name="update_b.a_update"/>}
      #end add-point
      RETURN
END FUNCTION

PRIVATE FUNCTION azzi800_01_lock_b(ps_table)
   DEFINE ps_table STRING
   DEFINE ls_group STRING
   #add-point:lock_b段define
   {<point name="lock_b.define"/>}
   #end add-point

   #先刷新資料

   #鎖定整組table
   #僅鎖定自身table
   LET ls_group = "gzxb_t"

   IF ls_group.getIndexOf(ps_table,1) THEN

      OPEN azzi800_01_bcl USING g_enterprise,
                                    g_gzxa003_d,g_gzxb_d[l_ac_01].gzxb002,g_gzxb_d[l_ac_01].gzxb003

      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "azzi800_01_bcl"
         LET g_errparam.popup = TRUE
         CALL cl_err()

         RETURN FALSE
      END IF
    ELSE 
      OPEN azzi800_01_1_bcl USING g_enterprise,
           g_gzxa003_d,g_gzxb_d[l_ac_01].gzxb002 ,g_gzxb_d[l_ac_01].gzxb003,g_gzxc_d[l_ac_03].gzxc004                     
      
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "azzi800_01_1_bcl"
         LET g_errparam.popup = TRUE
         CALL cl_err()

         RETURN FALSE
      END IF  
   END IF

   RETURN TRUE

END FUNCTION

PRIVATE FUNCTION azzi800_01_unlock_b(ps_table)
   DEFINE ps_table STRING
   DEFINE ls_group STRING
   #add-point:unlock_b段define
   {<point name="unlock_b.define"/>}
   #end add-point

   LET ls_group = ""

   IF ls_group.getIndexOf(ps_table,1) THEN
      CLOSE azzi800_01_bcl
   ELSE  
      CLOSE azzi800_01_1_bcl
   END IF
END FUNCTION
################################################################################
# Descriptions...: 清除單身資料
# Memo...........:
# Usage..........: CALL azzi800_01_clear_detail()
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 日期 By 作者
# Modify.........:
################################################################################
PUBLIC FUNCTION azzi800_01_clear_detail()
       CALL g_gzxb_d.clear()
       CALL g_gzxc_d.clear()
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
PUBLIC FUNCTION azzi800_01_gzxb001_batch_delete(pc_gzxb001)
   DEFINE   pc_gzxb001   LIKE gzxb_t.gzxb001
  
   DELETE FROM gzxb_t
      WHERE gzxbent = g_enterprise AND gzxb001 = pc_gzxb001
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = "gzxb_t"
      LET g_errparam.popup = FALSE
      CALL cl_err()

      CALL s_transaction_end('N','0')
   END IF
   DELETE FROM gzxc_t
      WHERE gzxcent = g_enterprise AND gzxc001 = pc_gzxb001
      
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = "gzxc_t"
      LET g_errparam.popup = FALSE
      CALL cl_err()

      CALL s_transaction_end('N','0')
   END IF
    DELETE FROM gzxg_t
    WHERE gzxgent = g_enterprise AND gzxg001 = pc_gzxb001 
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = "gzxg_t"
      LET g_errparam.popup = FALSE
      CALL cl_err()

      CALL s_transaction_end('N','0')
   END IF 

   DELETE FROM gzxh_t
    WHERE gzxhent = g_enterprise AND gzxh001 = pc_gzxb001 
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = "gzxh_t"
      LET g_errparam.popup = FALSE
      CALL cl_err()
      CALL s_transaction_end('N','0')
   END IF 
END FUNCTION
################################################################################
# Descriptions...: 描述说明
# Memo...........:
# Usage..........: azzi800_01_b2_fill(p_wc2)
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 日期 By 作者
# Modify.........:
################################################################################
PUBLIC FUNCTION azzi800_01_b2_fill(p_wc2)
      #BODY FILL UP
   {<Local define>}
   DEFINE p_wc2           STRING
   DEFINE li_cnt   LIKE type_t.num5
   {</Local define>}
   #add-point:b_fill段define
   {<point name="b_fill.define"/>}
   #end add-point

   IF cl_null(p_wc2) THEN
      LET p_wc2 = " 1=1"
   END IF

   #add-point:b_fill段sql
   {<point name="b_fill.sql_before"/>}
   # 避免移動到下一筆時, cnt, idx值未清空
   LET g_detail_idx_03 = 0
   LET g_detail_cnt_03 = 0
   
   #end add-point
   LET g_sql = "SELECT  DISTINCT gzxcstus,gzxc001,gzxc002,gzxc003,gzxc004,'',gzxc005,gzxc006,gzxc007 FROM gzxc_t",
               "",
               " WHERE gzxcent='",g_enterprise CLIPPED,"' AND 1=1  AND gzxc001 = '",g_gzxa003_d CLIPPED ,"' AND gzxc002='",g_gzxb002_d CLIPPED, "' AND gzxc003 ='" ,g_gzxb003_d CLIPPED, "' AND " , p_wc2
 
   LET g_sql = g_sql, " ORDER BY gzxc001"
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   PREPARE azzi800_01_pb2 FROM g_sql
   DECLARE b2_fill_curs CURSOR FOR azzi800_01_pb2
   CALL g_gzxc_d.clear()
   LET g_cnt = l_ac_03
   LET l_ac_03 = 1

   FOREACH b2_fill_curs INTO 
           g_gzxc_d[l_ac_03].gzxcstus,g_gzxc_d[l_ac_03].gzxc001,g_gzxc_d[l_ac_03].gzxc002,
           g_gzxc_d[l_ac_03].gzxc003,g_gzxc_d[l_ac_03].gzxc004,g_gzxc_d[l_ac_03].gzxc004_desc,
           g_gzxc_d[l_ac_03].gzxc005,g_gzxc_d[l_ac_03].gzxc006,g_gzxc_d[l_ac_03].gzxc007
           
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "FOREACH:"
         LET g_errparam.popup = TRUE
         CALL cl_err()
         EXIT FOREACH
      END IF     
      CALL azzi800_01_detail_show("gzxc_t")    
      LET l_ac_03 = l_ac_03 + 1
      IF l_ac_03 > g_max_rec THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.extend = l_ac
         LET g_errparam.code   = 9035
         LET g_errparam.popup  = TRUE
         CALL cl_err()
         EXIT FOREACH
      END IF

    END FOREACH     

   CALL g_gzxc_d.deleteElement(g_gzxc_d.getLength())  
  
   #將key欄位填到每個page
   #T100註解 會產生空的空白列
   #FOR l_ac_03 = 1 TO g_gzxc_d.getLength()

   #END FOR

   #add-point:b_fill段資料填充(其他單身)
   {<point name="b_fill.others.fill"/>}
   # 預設搜尋後第一次的index值
   LET li_cnt = g_gzxc_d.getLength()
   IF li_cnt > 0 THEN
      LET g_detail_idx_03 = 1
   END IF
   #end add-point

   LET g_detail_cnt_03 = l_ac_03 - 1
   DISPLAY g_detail_cnt_03 TO FORMONLY.cnt
   IF g_cnt > g_gzxc_d.getLength() THEN
      LET l_ac_03 = g_gzxc_d.getLength()
   ELSE
      LET l_ac_03 = g_cnt
   END IF
   LET g_cnt = 0

   CLOSE b2_fill_curs
   FREE azzi800_01_pb2
END FUNCTION
################################################################################
# Descriptions...: 描述说明
# Memo...........:
# Usage..........: CALL azzi800_01_ins_gzxg()
#                  
# Input parameter: 
#                : 
# Return code....: 
#                : 
# Date & Author..: 日期 By 作者
# Modify.........:
################################################################################
PRIVATE FUNCTION azzi800_01_ins_gzxg()
   DEFINE li_cnt     LIKE type_t.num5
   DEFINE lr_gzxg    type_g_gzxg_m      # RECORD LIKE gzxg_t.*  
   DEFINE lc_gzzr002 LIKE gzzr_t.gzzr002
   DEFINE lc_gzzz002 LIKE gzzz_t.gzzz002
   DEFINE li_gzxh_cnt LIKE type_t.num5

   SELECT gzzz002 INTO lc_gzzz002 FROM gzzz_t
    WHERE gzzz001 = g_gzxb_d[l_ac_01].gzxb003
   IF SQLCA.SQLCODE THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = "azz-00083"
      LET g_errparam.extend = sqlca.sqlcode
      LET g_errparam.popup = TRUE
      CALL cl_err()
      RETURN FALSE
   END IF
   
   SELECT COUNT(1) INTO li_cnt FROM gzxg_t 
    WHERE gzxgent = g_enterprise 
      AND gzxg001 = g_gzxa003_d
      AND gzxg002 = g_gzxb_d[l_ac_01].gzxb003
   IF li_cnt = 0 THEN
      #LET lr_gzxg.gzxgent = g_enterprise
      LET lr_gzxg.gzxg001 = g_gzxa003_d
      LET lr_gzxg.gzxg002 = g_gzxb_d[l_ac_01].gzxb003
      LET lr_gzxg.gzxgstus = "Y"
      LET lr_gzxg.gzxgownid = g_user
      LET lr_gzxg.gzxgowndp = g_dept
      LET lr_gzxg.gzxgcrtid = g_user
      LET lr_gzxg.gzxgcrtdp = g_dept 
      LET lr_gzxg.gzxgcrtdt = cl_get_current()
      
      INSERT INTO gzxg_t(gzxgent,gzxg001,gzxg002,gzxgstus,gzxgownid,gzxgowndp,gzxgcrtid,gzxgcrtdp,gzxgcrtdt)
         VALUES (g_enterprise,lr_gzxg.gzxg001,lr_gzxg.gzxg002,lr_gzxg.gzxgstus,lr_gzxg.gzxgownid, 
                 lr_gzxg.gzxgowndp,lr_gzxg.gzxgcrtid,lr_gzxg.gzxgcrtdp,lr_gzxg.gzxgcrtdt) 
   END IF
   
   #比對單身 gzxh 項目是否也正常
   #讀取 gzzr_t 程式功能
   DECLARE azzi800_01_gzxh_cs CURSOR FOR 
   SELECT gzzr002 FROM gzzr_t
    WHERE gzzr001 = lc_gzzz002
      AND (gzzr005 = '2' OR gzzr005 = '3')  #功能權限識別碼 (1:功能/2:權限/3:都有)

   FOREACH azzi800_01_gzxh_cs INTO lc_gzzr002
      SELECT COUNT(1) INTO li_gzxh_cnt FROM gzxh_t
       WHERE gzxhent = g_enterprise
         AND gzxh001 = g_gzxa003_d
         AND gzxh002 = g_gzxb_d[l_ac_01].gzxb003
         AND gzxh003 = lc_gzzr002
      IF li_gzxh_cnt = 0 THEN
         INSERT INTO gzxh_t(gzxhent,gzxh001,gzxh002,gzxh003,gzxh004,gzxh005)
         VALUES(g_enterprise,g_gzxa003_d,g_gzxb_d[l_ac_01].gzxb003,lc_gzzr002,'Y','F') 
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = SQLCA.sqlcode
            LET g_errparam.extend = "gzxh_t"
            LET g_errparam.popup = TRUE
            CALL cl_err()
            EXIT FOREACH
         END IF
      END IF
   END FOREACH

   RETURN TRUE
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
PRIVATE FUNCTION azzi800_01_show_scc()
   CALL cl_set_combo_scc('gzxb006','154') 
   CALL cl_set_combo_scc('gzxb007','155') 
   CALL cl_set_combo_scc('gzxb008','156')
END FUNCTION

################################################################################
# Descriptions...: 描述说明
# Memo...........:
# Usage..........: CALL azzi800_01_get_gzxh003(pc_l_ac)
#                  RETURNING ls_temp
# Input parameter: pc_l_a 筆數 NUMBER(5)
#                : 
# Return code....: ls_temp STRING
#                : 
# Date & Author..: 日期 By 作者
# Modify.........:
################################################################################
PRIVATE FUNCTION azzi800_01_get_gzxh003(pc_l_ac)
   DEFINE pc_l_ac     LIKE type_t.num5
   DEFINE lc_gzxh003  LIKE gzxh_t.gzxh003
   DEFINE lc_gzxh004  LIKE gzxh_t.gzxh003
   DEFINE ls_temp     STRING 

   DECLARE azzi800_01_gzxh003 CURSOR FOR 
    SELECT gzxh003,gzxh004 FROM gzxh_t
     WHERE gzxhent = g_enterprise
      AND gzxh001 = g_gzxa003_d 
      AND gzxh002 = g_gzxb_d[pc_l_ac].gzxb003

  FOREACH azzi800_01_gzxh003 INTO lc_gzxh003,lc_gzxh004

     IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "FOREACH:"
         LET g_errparam.popup = TRUE
         CALL cl_err()
         EXIT FOREACH
      END IF
      IF lc_gzxh004 = "Y" THEN 
         LET ls_temp = ls_temp,lc_gzxh003,","
      END IF 
      
   END FOREACH   

   LET ls_temp = ls_temp.subString(1,ls_temp.getLength()-1)
   CLOSE azzi800_01_gzxh003
   RETURN ls_temp
END FUNCTION

################################################################################
# Descriptions...: #報表類不用進入功能授權管控 或 沒有action不管控
# Memo...........:
# Usage..........: CALL azzi800_01_chk_gzxb003()
#                  RETURNING 回传参数
# Input parameter: 
# Return code....: li_status:-1 -2 1
# Date & Author..: 2014/12/29 By jrg542
# Modify.........:
################################################################################
PRIVATE FUNCTION azzi800_01_chk_gzxb003()
   DEFINE li_status LIKE type_t.num5
   DEFINE li_cnt    LIKE type_t.num5   
   DEFINE lc_gzzzstus    LIKE gzzz_t.gzzzstus
   DEFINE lc_gzzz002     LIKE gzzz_t.gzzz002
   DEFINE ls_progtype    STRING
   DEFINE ls_temp        STRING 
  
  #由作業名稱轉換為程式名稱
   SELECT gzzzstus,gzzz002 INTO lc_gzzzstus,lc_gzzz002 FROM gzzz_t
    WHERE gzzz001 = g_gzxb_d[l_ac_01].gzxb003

   LET li_status = 0    
   IF SQLCA.SQLCODE OR lc_gzzzstus = "N" THEN
      LET li_status = -1
      RETURN li_status
   END IF

   LET ls_progtype = lc_gzzz002[4,4]
   IF cl_chk_progtype(UPSHIFT(ls_progtype)) THEN
      LET li_status = -2
      RETURN li_status
   END IF

   IF ls_progtype = "r" THEN 
      LET li_status = 1
      RETURN li_status
   END IF 
   #沒有action 也不管控
   SELECT COUNT(1) INTO li_cnt FROM gzzr_t
    WHERE gzzr001 = lc_gzzz002
      AND (gzzr005 = '2' OR gzzr005 = '3')  #功能權限識別碼 (1:功能/2:權限/3:都有)
   
   IF li_cnt = 0 THEN 
      LET li_status = 1
   END IF 
   
   RETURN li_status,lc_gzzz002
END FUNCTION

################################################################################
# Descriptions...: 刪除 gzxc_t gzxg_t gzxh_t
# Memo...........:
# Usage..........: CALL azzi800_01_key_delete_b(ps_keys_bak,ps_table)
#                  RETURNING 回传参数
# Input parameter: ps_keys_bak
# Input parameter: ps_table
# Return code....: 
# Date & Author..: 2015/01/27 By jrg542
# Modify.........:
################################################################################
PRIVATE FUNCTION azzi800_01_key_delete_b(ps_keys_bak,ps_table)
   DEFINE ps_keys_bak DYNAMIC ARRAY OF VARCHAR(500)
   DEFINE ps_table    STRING
   DEFINE ps_gzxb002  STRING 
   
   #如果是上層單身則進行delete
   IF ps_table = 'gzxb_t' THEN

      DELETE FROM gzxc_t
        WHERE gzxcent = g_enterprise 
         AND gzxc001 = ps_keys_bak[1]     #員工編號
         AND gzxc002 = ps_keys_bak[2]     #類別
         AND gzxc003 = ps_keys_bak[3]     #角色編號或作業編號 
         
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "gzxc_t"
         LET g_errparam.popup = TRUE
         CALL cl_err()
     
         RETURN FALSE
      END IF 
   END IF

   IF gs_gzxb002 = "0" THEN 
      DELETE FROM gzxg_t
       WHERE gzxgent = g_enterprise
        AND  gzxg001 = ps_keys_bak[1]
        AND  gzxg002 = ps_keys_bak[3]  #角色編號或作業編號 

      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "gzxg_t"
         LET g_errparam.popup = TRUE
         CALL cl_err()
         RETURN FALSE
      END IF  

      DELETE FROM gzxh_t
       WHERE gzxhent = g_enterprise 
        AND gzxh001 = ps_keys_bak[1]           #員工編號
        AND gzxh002 = ps_keys_bak[3]           #角色編號或作業編號

     IF SQLCA.sqlcode THEN
        INITIALIZE g_errparam TO NULL
        LET g_errparam.code = SQLCA.sqlcode
        LET g_errparam.extend = "gzxh_t"
        LET g_errparam.popup = TRUE
        CALL cl_err()
        RETURN FALSE
     END IF    
   END IF 
   RETURN TRUE  
END FUNCTION

################################################################################
# Descriptions...: 描述说明
# Memo...........:
# Usage..........: CALL azzi800_01_cnt_gzxc(ps_keys_bak)
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
# Return code....: 回传参数变量1   回传参数变量说明1
# Date & Author..: 2015/03/25 By jrg542
# Modify.........:
################################################################################
PRIVATE FUNCTION azzi800_01_cnt_gzxc(ps_keys_bak)
   DEFINE ps_keys_bak DYNAMIC ARRAY OF VARCHAR(500)
   DEFINE li_cnt      LIKE type_t.num5
   
   SELECT COUNT(1) INTO li_cnt FROM gzxc_t
    WHERE gzxcent = g_enterprise 
     AND gzxc001 = ps_keys_bak[1]     #員工編號
     AND gzxc002 = ps_keys_bak[2]     #類別
     AND gzxc003 = ps_keys_bak[3]     #角色編號或作業編號 

   RETURN li_cnt 
END FUNCTION

################################################################################
# Descriptions...: 描述说明
# Memo...........:
# Usage..........: CALL azzi800_01_cnt_gzxb(ps_keys_bak)
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
# Return code....: 回传参数变量1   回传参数变量说明1
# Date & Author..: 2015/03/25 By jrg542
# Modify.........:
################################################################################
PRIVATE FUNCTION azzi800_01_cnt_gzxb(ps_keys_bak)
   DEFINE ps_keys_bak DYNAMIC ARRAY OF VARCHAR(500)
   DEFINE li_cnt      LIKE type_t.num5
   
   SELECT COUNT(1) INTO li_cnt FROM gzxb_t 
    WHERE gzxbent = g_enterprise 
     AND gzxb001 = ps_keys_bak[1]
     AND gzxb002 = '1'

    RETURN li_cnt
END FUNCTION

PRIVATE FUNCTION azzi800_01_chk_entey()

   CASE
      WHEN g_gzxb_d[l_ac_01].gzxb002 = "0" #作業
           CALL cl_set_comp_entry("l_gzxh004,gzxb006,gzxb007,gzxb008",TRUE)
      WHEN g_gzxb_d[l_ac_01].gzxb002 = "1" #角色
           CALL cl_set_comp_entry("l_gzxh004,gzxb006,gzxb007,gzxb008",FALSE)
   END CASE

END FUNCTION

################################################################################
# Descriptions...: 額外刪除gzxg gzxh
# Memo...........:
# Usage..........: CALL azzi800_01_extra_del(pc_l_ac)
#                  RETURNING 回传参数
# Input parameter: pc_l_ac
# Return code....: 
# Date & Author..: 2015/11/06 By jrg542
# Modify.........:
################################################################################
PRIVATE FUNCTION azzi800_01_extra_del(pc_l_ac)
   DEFINE pc_l_ac LIKE type_t.num5

   #刪除gzxg_t單頭 使用者定義運行作業功表 
   DELETE FROM gzxg_t
    WHERE gzxgent = g_enterprise 
     AND gzxg001 = g_gzxa003_d 
     AND gzxg002 = g_gzxb_d[pc_l_ac].gzxb003

   #刪除gzxh_t單身 使用者定義運行作業功能明細
   DELETE FROM gzxh_t
    WHERE gzxhent = g_enterprise 
     AND gzxh001 = pc_gzxb001
     AND gzxh002 = g_gzxb_d[pc_l_ac].gzxb003 
END FUNCTION

PUBLIC FUNCTION azzi800_01_gzxb001_batch_upate(pc_gzxb001_new,pc_gzxb001_old)
   DEFINE pc_gzxb001_new   LIKE gzxb_t.gzxb001
   DEFINE pc_gzxb001_old   LIKE gzxb_t.gzxb001
   DEFINE l_gzxbmodid      LIKE gzxb_t.gzxbmodid
   DEFINE l_gzxbmoddt      LIKE gzxb_t.gzxbmoddt

   LET l_gzxbmodid = g_user
   LET l_gzxbmoddt = cl_get_current()

   UPDATE gzxb_t SET (gzxb001,gzxbmodid,gzxbmoddt)=
                     (pc_gzxb001_new,l_gzxbmodid,l_gzxbmoddt)
    WHERE gzxbent = g_enterprise
     AND gzxb001 = pc_gzxb001_old

   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = "gzxb_t"
      LET g_errparam.popup = FALSE
      CALL cl_err()
      CALL s_transaction_end('N','0')
   END IF

   UPDATE gzxc_t SET (gzxc001,gzxcmodid,gzxcmoddt)=
                     (pc_gzxb001_new,l_gzxbmodid,l_gzxbmoddt)
    WHERE gzxcent = g_enterprise
     AND gzxc001 = pc_gzxb001_old

   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = "gzxc_t"
      LET g_errparam.popup = FALSE
      CALL cl_err()
      CALL s_transaction_end('N','0')
   END IF

END FUNCTION

 
{</section>}
 
