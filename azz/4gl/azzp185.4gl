#該程式已解開Section, 不再透過樣板產出!
{<section id="azzp185.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0008(1900-01-01 00:00:00), PR版次:0008(2017-01-11 17:01:12)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000050
#+ Filename...: azzp185
#+ Description: 授權功能更新作業
#+ Creator....: 01856(2014-07-29 17:20:14)
#+ Modifier...: 00000 -SD/PR- 01856
 
{</section>}
 
{<section id="azzp185.global" >}
#應用 i00 樣板自動產生(Version:10)
#add-point:填寫註解說明 name="global.memo"
#+ Modifier...: No.161207-00061 #1   2016/12/07 by jrg542  修改 azzp185 背景訊息提示 由error  改成warning  DISPLAY "Warning: Enterpise ",g_enterprise," 不存在角色:",lc_gzyb001
#+ Modifier...: No.170111-00036 #1   2017/01/11 by jrg542  補做 azzp195 更新 action 動作
#end add-point
#add-point:填寫註解說明(客製用) name="global.memo_customerization"

#end add-point
 
IMPORT os
IMPORT FGL lib_cl_dlg
#add-point:增加匯入項目 name="global.import"

#end add-point
 
SCHEMA ds
 
GLOBALS "../../cfg/top_global.inc"
 
#add-point:free_style模組變數(Module Variable) name="free_style.variable"

#end add-point
 
#add-point:自定義模組變數(Module Variable) name="global.variable"
TYPE type_common_info RECORD

   gzybmodid LIKE gzyb_t.gzybmodid, 
   gzybmoddt LIKE gzyb_t.gzybmoddt, 
   gzybownid LIKE gzyb_t.gzybownid, 
   gzybowndp LIKE gzyb_t.gzybowndp, 
   gzybcrtid LIKE gzyb_t.gzybcrtid,  
   gzybcrtdp LIKE gzyb_t.gzybcrtdp, 
   gzybcrtdt LIKE gzyb_t.gzybcrtdt
       END RECORD
#end add-point
 
#add-point:自定義客戶專用模組變數(Module Variable) name="global.variable_customerization"

#end add-point
 
{</section>}
 
{<section id="azzp185.main" >}
#+ 作業開始
MAIN
   #add-point:main段define
   DEFINE lb_chk        LIKE type_t.num5   
   DEFINE ls_msg        STRING  
   DEFINE lc_gzyb001    LIKE gzyb_t.gzyb001
   DEFINE lc_gzyb002    LIKE gzyb_t.gzyb002
   DEFINE li_enterprise LIKE type_t.num5
   #end add-point    
 
   #定義在其他link的程式則無效
   WHENEVER ERROR CALL cl_err_msg_log
   LET g_bgjob = "Y"
   #依模組進行系統初始化設定(系統設定)
   CALL cl_ap_init("azz","")
 
   #add-point:作業初始化
   LET lc_gzyb001 = g_argv[1]      #職能角色編號
   LET lc_gzyb002 = g_argv[2]      #作業編號
   LET li_enterprise = g_argv[3]   #企業編號
 
   IF lc_gzyb002 IS NULL THEN
      CALL azzp185_err_msg()
   ELSE
      CALL azzp185_process(lc_gzyb001,lc_gzyb002,li_enterprise)
   END IF
   #end add-point
 
   #add-point:SQL_define

   #end add-point
#   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)    #轉換不同資料庫語法
#   DECLARE azzp185_cl CURSOR FROM g_forupd_sql 
#   
#   IF g_bgjob = "Y" THEN
 
      #add-point:Service Call

      #end add-point
#   ELSE
#      #畫面開啟 (identifier)
#      OPEN WINDOW w_azzp185 WITH FORM cl_ap_formpath("azz",g_code)
#   
#      #程式初始化
#      CALL azzp185_init()
#   
#      #瀏覽頁簽資料初始化
#      CALL cl_ui_init()
#   
#      #進入選單 Menu (='N')
#      CALL azzp185_ui_dialog()
#   
#      #畫面關閉
#      CLOSE WINDOW w_azzp185
#   END IF
 
   #add-point:作業離開前

   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
 
END MAIN
 
{</section>}
 
{<section id="azzp185.other_function" readonly="Y" >}
#add-point:自定義元件(Function) name="other.function"

PRIVATE FUNCTION azzp185_process(lc_gzyb001,lc_gzyb002,li_enterprise)
   DEFINE lc_gzyb001    LIKE gzyb_t.gzyb001
   DEFINE lc_gzyb002    LIKE gzyb_t.gzyb002
   DEFINE li_enterprise LIKE type_t.num5
   #DEFINE ls_sql        STRING             170111-00036  mark
   DEFINE la_gzzr002    DYNAMIC ARRAY OF LIKE gzzr_t.gzzr002
   DEFINE lc_gzyc004    LIKE gzyc_t.gzyc004
   DEFINE lc_gzyc005    LIKE gzyc_t.gzyc005
   DEFINE lc_gzzzstus   LIKE gzzz_t.gzzzstus
   DEFINE lc_gzzz002    LIKE gzzz_t.gzzz002
   DEFINE li_cnt        LIKE type_t.num5
   DEFINE li_cntzy      LIKE type_t.num5   
   DEFINE lc_gzybcrtdt  LIKE gzyb_t.gzybcrtdt
   DEFINE lc_common     type_common_info
   DEFINE ls_str        STRING              #170111-00036  add

   LET lc_gzyc004 = "Y"   #功能授權
   LET lc_gzyc005 = "F"   #資料授權類別 F:不管制
   #LET lc_gzyc006 = "0"   #資料授權範圍 0:全部開放
   LET lc_common.gzybmodid = g_user
   LET lc_common.gzybowndp = g_dept
   LET lc_common.gzybcrtid = g_user
   LET lc_common.gzybcrtdp = g_dept
   LET lc_common.gzybcrtdt = cl_get_current()
   LET lc_common.gzybmodid = g_user
   LET lc_common.gzybmoddt = cl_get_current()
   
   IF NOT cl_null(li_enterprise) THEN 
      LET g_enterprise = li_enterprise
   END IF
   
   #檢查角色名稱是否已存在
   SELECT COUNT(*) INTO li_cnt FROM gzya_t
    WHERE gzyaent = g_enterprise AND gzya001 = lc_gzyb001
   IF li_cnt = 0 THEN
      #161207-00061 start
      IF FGL_GETENV("DGENV") = "c" THEN
         DISPLAY "Error: Enterpise ",g_enterprise," 不存在角色:",lc_gzyb001
      ELSE
         DISPLAY "Warning: Enterpise ",g_enterprise," 不存在角色:",lc_gzyb001
      END IF
      RETURN
      #161207-00061 end
   END IF

   #由作業名稱轉換為程式名稱
   SELECT gzzzstus,gzzz002 INTO lc_gzzzstus,lc_gzzz002 FROM gzzz_t
    WHERE gzzz001 = lc_gzyb002
   IF SQLCA.SQLCODE OR lc_gzzzstus = "N" THEN
      #161207-00061 start 
      IF FGL_GETENV("DGENV") = "c" THEN
         DISPLAY "Error:",lc_gzyb002," 指定的作業不存在!"
      ELSE
         DISPLAY "Warning:",lc_gzyb002," 指定的作業不存在!"
      END IF
      #161207-00061 end
      RETURN
   ELSE
      #補做一次 只更新 action 不比對群組
      LET ls_str = "r.r azzp195 ",lc_gzzz002 ," N"
      RUN ls_str
      
      CALL azzp185_qry_gzzr(lc_gzzz002) RETURNING la_gzzr002
      IF la_gzzr002.getLength() > 0 THEN
#         DELETE FROM gzyc_t 
#          WHERE gzycent = g_enterprise  
#            AND gzyc001 = lc_gzyb001 
#            AND gzyc002 = lc_gzyb002

         FOR li_cnt = 1 TO la_gzzr002.getLength()
            SELECT COUNT(*) INTO li_cntzy FROM gzyc_t
             WHERE gzycent = g_enterprise AND gzyc001=lc_gzyb001 AND gzyc002=lc_gzyb002
               AND gzyc003 = la_gzzr002[li_cnt]
            IF li_cntzy < 1 THEN
            INSERT INTO gzyc_t(gzycent,gzyc001,gzyc002,gzyc003,gzyc004,gzyc005)
             VALUES(g_enterprise,lc_gzyb001,lc_gzyb002,la_gzzr002[li_cnt],
                    lc_gzyc004,lc_gzyc005)
            IF SQLCA.SQLCODE THEN 
               DISPLAY "Info:新增 ", g_enterprise , " ",lc_gzyb001 ," ",  lc_gzyb002 ," " ,la_gzzr002[li_cnt] ,"重複"
            END IF
            END IF
         END FOR
         
         DISPLAY "Info:新增",li_cnt USING "<<<<<","筆資料"
      ELSE
         DISPLAY "Info:本作業",lc_gzyb002,"(原程式:",lc_gzzz002,")查無action資料"
         DISPLAY "Info:建議先對原程式進行 r.r azzp195 ",lc_gzzz002," 的動作"
      END IF
      
      #比對查看一下 gzyb_t 是否存在
      SELECT COUNT(*) INTO li_cnt FROM gzyb_t 
       WHERE gzybent = g_enterprise AND gzyb001=lc_gzyb001 AND gzyb002 = lc_gzyb002
      IF li_cnt = 0 THEN
         #LET lc_gzybcrtdt = cl_get_current()
         INSERT INTO gzyb_t(gzybent,gzyb001,gzyb002,gzyb003,gzyb004,gzyb005,gzyb006,gzyb007,
                            gzybownid,gzybowndp,gzybcrtid,gzybcrtdp,gzybcrtdt,gzybmodid,gzybmoddt)
          VALUES(g_enterprise,lc_gzyb001,lc_gzyb002,'0','0','0','0','0',
                 lc_common.gzybownid,lc_common.gzybowndp,lc_common.gzybcrtid,lc_common.gzybcrtdp,
                 lc_common.gzybcrtdt,lc_common.gzybmodid,lc_common.gzybmoddt)
      ELSE
         UPDATE gzyb_t SET gzybmodid=g_user, gzybmoddt=lc_common.gzybmoddt
          WHERE gzybent = g_enterprise AND gzyb001=lc_gzyb001 AND gzyb002 = lc_gzyb002
      END IF
      IF SQLCA.SQLCODE THEN 
         DISPLAY "Info:gzyb_t 新增/更新 ", g_enterprise , " ",lc_gzyb001 ," ",  lc_gzyb002, "有問題"
      END IF
   END IF
END FUNCTION

PRIVATE FUNCTION azzp185_qry_gzzr(lc_gzzr001)
   DEFINE lc_gzzr001 LIKE gzzr_t.gzzr001
   DEFINE la_gzzr002 DYNAMIC ARRAY OF LIKE gzzr_t.gzzr002
   DEFINE ls_sql     STRING
   DEFINE li_cnt     LIKE type_t.num5
   #gzzr005  #功能權限識別碼 (1:功能/2:權限/3:都有)
   LET ls_sql = "SELECT gzzr002 FROM gzzr_t ",
                " WHERE gzzr001 = '",lc_gzzr001 CLIPPED,"' ",
                  " AND (gzzr005 = '2' OR gzzr005 = '3')"

   DECLARE azzp185_qry_gzzr_cs CURSOR FROM ls_sql

   #存在本作業權限項目時, 展開營運據點(全部)
   CALL la_gzzr002.clear()
   LET li_cnt = 1
   FOREACH azzp185_qry_gzzr_cs INTO la_gzzr002[li_cnt]
      IF la_gzzr002[li_cnt] IS NULL THEN
         CALL la_gzzr002.deleteElement(li_cnt)
      END IF
      LET li_cnt = la_gzzr002.getLength() + 1
   END FOREACH
   CALL la_gzzr002.deleteElement(li_cnt)

   CLOSE azzp185_qry_gzzr_cs
   FREE azzp185_qry_gzzr_cs

   RETURN la_gzzr002

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
PRIVATE FUNCTION azzp185_err_msg()
  DISPLAY "INFO:  r.r azzp185 職能角色編號  作業編號"
  DISPLAY "Sample:r.r azzp185 admin-01 azzi900"
END FUNCTION

#end add-point
 
{</section>}
 
