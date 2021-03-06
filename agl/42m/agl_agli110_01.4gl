#該程式未解開Section, 採用最新樣板產出!
{<section id="agli110_01.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0006(2016-08-16 15:32:09), PR版次:0006(2016-11-28 15:46:03)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000177
#+ Filename...: agli110_01
#+ Description: 整批產生
#+ Creator....: 02114(2013-10-24 13:50:39)
#+ Modifier...: 02599 -SD/PR- 02481
 
{</section>}
 
{<section id="agli110_01.global" >}
#應用 c01c 樣板自動產生(Version:10)
#add-point:填寫註解說明 name="global.memo"
#Memos
#160816-00039#1    2016/08/16 By 02599   BUG修正，查询栏位glaw001与glaw002分开在两个CONSTRUCT中，以便得到两个字段的条件(g_wc/g_wc2)
#                                        故修改画面中glaw002栏位字段属性：勾选排除组件
#                                        glaw003 glaw006 glaw007这3个栏位是input录入，故修改程序画面为，这3个栏位只可编辑不可查询
#160811-00039#6   2016/08/25 By 02599    抓取有权限的账套产生资料
#161111-00028#8   2016/11/28 by 02481    标准程式定义采用宣告模式,弃用.*写法
#end add-point
#add-point:填寫註解說明(客製用) name="global.memo_customerization"

#end add-point
 
IMPORT os
IMPORT FGL lib_cl_dlg
#add-point:增加匯入項目 name="global.import"

#end add-point
 
SCHEMA ds
 
GLOBALS "../../cfg/top_global.inc"
 
#add-point:增加匯入變數檔 name="global.inc" name="global.inc"

#end add-point
 
DEFINE g_rec_b               LIKE type_t.num10
DEFINE g_wc                  STRING
DEFINE g_ref_fields          DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
DEFINE g_rtn_fields          DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
DEFINE g_ref_vars            DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
 
 
#add-point:自定義模組變數(Module Variable)(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="global.variable"
DEFINE g_glaw_n       RECORD
       glaw002 LIKE glaw_t.glaw002 
       END RECORD
DEFINE g_wc1          STRING
DEFINE g_glaw       RECORD
       glaw003 LIKE glaw_t.glaw003, 
       glaw003_desc LIKE type_t.chr80,
       glaw006 LIKE glaw_t.glaw006, 
       glaw007 LIKE glaw_t.glaw007
       END RECORD
DEFINE g_sql          STRING       
#end add-point
 
#add-point:自定義客戶專用模組變數(Module Variable) name="global.variable_customerization"

#end add-point
 
#add-point:傳入參數說明(global.argv) name="global.argv"

#end add-point  
 
{</section>}
 
{<section id="agli110_01.input" >}
#+ 資料輸入
PUBLIC FUNCTION agli110_01(--)
   #add-point:construct段變數傳入 name="construct.get_var"
   
   #end add-point
   )
   #add-point:construct段define name="construct.define_customerization"
   
   #end add-point
   DEFINE l_ac_t          LIKE type_t.num10       #未取消的ARRAY CNT 
   DEFINE l_allow_insert  LIKE type_t.num5        #可新增否 
   DEFINE l_allow_delete  LIKE type_t.num5        #可刪除否  
   DEFINE l_count         LIKE type_t.num10
   DEFINE l_insert        LIKE type_t.num5
   #add-point:construct段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="construct.define"
   
   #end add-point
 
   #畫面開啟 (identifier)
   OPEN WINDOW w_agli110_01 WITH FORM cl_ap_formpath("agl","agli110_01")
 
   #瀏覽頁簽資料初始化
   CALL cl_ui_init()
   
   LET g_qryparam.state = "i"
   
   #輸入前處理
   #add-point:單頭前置處理 name="construct.pre_construct"
   LET g_glaw.glaw006 = g_today
   LET g_glaw.glaw007 = g_today
   LET g_glaw.glaw003 = ''
   #end add-point
   
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
   
      #輸入開始
      CONSTRUCT BY NAME g_wc ON glaw001 
      
            #add-point:自定義action name="construct.action"
            
            #end add-point
      
         BEFORE CONSTRUCT
            #add-point:單頭輸入前處理 name="construct.before_construct"
            ON ACTION controlp INFIELD glaw001
	           INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c'
               LET g_qryparam.reqry = FALSE
               #160811-00039#6--add--str--
               LET g_qryparam.arg1 = g_user
               LET g_qryparam.arg2 = g_dept
               CALL q_authorised_ld() 
               #160811-00039#6--add--end
#               CALL q_glaa001_2()   #160811-00039#6 mark          #呼叫開窗
               DISPLAY g_qryparam.return1 TO glaw001  #顯示到畫面上

               NEXT FIELD glaw001                     #返回原欄位
               
            #end add-point
            
         AFTER CONSTRUCT
            #add-point:單頭輸入後處理 name="construct.after_construct"
            
            #end add-point
            
         
 
         
       
      END CONSTRUCT
 
      #add-point:自定義construct name="construct.more_construct"
      CONSTRUCT BY NAME g_wc1 ON glaw002 
      
         BEFORE CONSTRUCT
               
            ON ACTION controlp INFIELD glaw002
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c'
		       LET g_qryparam.reqry = FALSE
               #給予arg
               LET g_wc = cl_replace_str(g_wc,"glaw001","gladld")
               LET g_qryparam.where = g_wc
               CALL q_glad001_2()                           #呼叫開窗
               DISPLAY g_qryparam.return1 TO glaw002  #顯示到畫面上

               NEXT FIELD glaw002                     #返回原欄位
            
      END CONSTRUCT
      
      INPUT BY NAME g_glaw.glaw003,g_glaw.glaw006,g_glaw.glaw007 ATTRIBUTE(WITHOUT DEFAULTS)
         AFTER FIELD glaw003
            IF NOT cl_null(g_glaw.glaw003) THEN 
               IF NOT agli110_01_glaw003_chk() THEN 
                  LET g_glaw.glaw003 = ''
                  NEXT FIELD glaw003
               END IF 
            END IF 
            
         AFTER FIELD glaw006
            IF NOT cl_null(g_glaw.glaw006) THEN 
               IF g_glaw.glaw006 > g_glaw.glaw007 THEN 
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'ais-00047'
                  LET g_errparam.extend = g_glaw.glaw006
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  NEXT FIELD glaw006
               END IF
            END IF 
            
         AFTER FIELD glaw007
            IF NOT cl_null(g_glaw.glaw007) THEN 
               IF g_glaw.glaw007 < g_glaw.glaw006 THEN 
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'ais-00048'
                  LET g_errparam.extend = g_glaw.glaw007
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  NEXT FIELD glaw007
               END IF
            END IF 
         
         ON ACTION controlp INFIELD glaw003
            #add-point:ON ACTION controlp INFIELD glaw003
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
			LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_glaw.glaw003             #給予default值

            #給予arg
            #160811-00039#6--add--str--
            LET g_qryparam.arg1 = g_user
            LET g_qryparam.arg2 = g_dept
            CALL q_authorised_ld() 
            #160811-00039#6--add--end
#            CALL q_glaa001_2()   #160811-00039#6 mark               #呼叫開窗

            LET g_glaw.glaw003 = g_qryparam.return1              #將開窗取得的值回傳到變數
            SELECT glaal002 INTO g_glaw.glaw003_desc
              FROM glaal_t
             WHERE glaalent = g_enterprise
               AND glaalld = g_glaw.glaw003
               AND glaal001 = g_dlang
            DISPLAY g_glaw.glaw003 TO glaw003              #顯示到畫面上
            DISPLAY g_glaw.glaw003_desc TO glaw003_desc 
            NEXT FIELD glaw003                          #返回原欄位
            #END add-point
            
         AFTER INPUT
            #add-point:單頭輸入後處理

            #end add-point
            
      END INPUT
      #end add-point
      
      ON ACTION accept
         ACCEPT DIALOG
        
      ON ACTION cancel
         LET INT_FLAG = TRUE 
         EXIT DIALOG
 
      ON ACTION close
         LET INT_FLAG = TRUE 
         EXIT DIALOG
 
      ON ACTION exit
         LET INT_FLAG = TRUE 
         EXIT DIALOG
   
      #交談指令共用ACTION
      &include "common_action.4gl" 
         CONTINUE DIALOG 
         
   END DIALOG
 
   #add-point:畫面關閉前 name="construct.before_close"
   
   #end add-point 
   
   #畫面關閉
   CLOSE WINDOW w_agli110_01 
   
   #add-point:construct段after construct name="construct.post_construct"
   IF INT_FLAG THEN
      LET g_success = ''
      RETURN g_success
   END IF
   
   CALL agli110_01_glaw_ins()
   RETURN g_success
   #end add-point 
 
END FUNCTION
 
{</section>}
 
{<section id="agli110_01.other_dialog" readonly="Y" >}

 
{</section>}
 
{<section id="agli110_01.other_function" readonly="Y" >}
#+ 整批產生glaw資料
PRIVATE FUNCTION agli110_01_glaw_ins()
   DEFINE l_glaald       LIKE glaa_t.glaald
   DEFINE l_glad001      LIKE glad_t.glad001
   #161111-00028#8----modify----begin---------
   #DEFINE l_glaw   RECORD   LIKE glaw_t.*
   DEFINE l_glaw RECORD  #帳套科目對應檔
       glawent LIKE glaw_t.glawent, #企業編號
       glawownid LIKE glaw_t.glawownid, #資料所有者
       glawowndp LIKE glaw_t.glawowndp, #資料所屬部門
       glawcrtid LIKE glaw_t.glawcrtid, #資料建立者
       glawcrtdp LIKE glaw_t.glawcrtdp, #資料建立部門
       glawcrtdt LIKE glaw_t.glawcrtdt, #資料創建日
       glawmodid LIKE glaw_t.glawmodid, #資料修改者
       glawmoddt LIKE glaw_t.glawmoddt, #最近修改日
       glawstus LIKE glaw_t.glawstus, #狀態碼
       glaw001 LIKE glaw_t.glaw001, #來源帳套
       glaw002 LIKE glaw_t.glaw002, #來源科目
       glaw003 LIKE glaw_t.glaw003, #對應帳套
       glaw004 LIKE glaw_t.glaw004, #對應科目
       glaw005 LIKE glaw_t.glaw005, #對應比例
       glaw006 LIKE glaw_t.glaw006, #生效日期
       glaw007 LIKE glaw_t.glaw007  #失效日期
       END RECORD

   #161111-00028#8----modify----end---------   
   DEFINE l_n            LIKE type_t.num5
   DEFINE l_ld_str       STRING   #160811-00039#6
   
   LET g_wc = cl_replace_str(g_wc,"glaw001","glaald")
   
   #160811-00039#6--add--str--
   CALL s_ld_sel_authority_sql(g_user,g_dept) RETURNING l_ld_str
   LET g_wc = g_wc," AND ",l_ld_str
   #160811-00039#6--add--end
   
   LET g_sql = "SELECT glaald FROM glaa_t",
               " WHERE glaaent = '",g_enterprise,"'",
               "   AND ",g_wc               
               
   PREPARE glaw001_pre FROM g_sql
   DECLARE glaw001_cur CURSOR FOR glaw001_pre
   
   FOREACH glaw001_cur INTO l_glaald
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "FOREACH:"
         LET g_errparam.popup = TRUE
         CALL cl_err()

         EXIT FOREACH
      END IF
      
      LET g_wc1 = cl_replace_str(g_wc1,"glaw002","glad001")
      LET g_sql = "SELECT glad001 FROM glad_t",
                  " WHERE gladent = '",g_enterprise,"'",
                  "   AND gladld = '",l_glaald,"'",
                  "   AND ",g_wc1
                  
      PREPARE glad001_pre FROM g_sql
      DECLARE glad001_cur CURSOR FOR glad001_pre
      
      FOREACH glad001_cur INTO l_glad001
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "FOREACH:"
         LET g_errparam.popup = TRUE
         CALL cl_err()

            EXIT FOREACH
         END IF
         
         LET l_glaw.glawent = g_enterprise
         LET l_glaw.glawstus = 'Y'
         LET l_glaw.glaw001 = l_glaald
         LET l_glaw.glaw002 = l_glad001
         LET l_glaw.glaw003 = g_glaw.glaw003
         LET l_glaw.glaw004 = l_glad001
         LET l_glaw.glaw005 = 100
         LET l_glaw.glaw006 = g_glaw.glaw006
         LET l_glaw.glaw007 = g_glaw.glaw007
         
         SELECT count(*) INTO l_n
           FROM glaw_t
          WHERE glawent = g_enterprise
            AND glaw001 = l_glaald
            AND glaw002 = l_glad001
            AND glaw003 = g_glaw.glaw003
            AND glaw004 = l_glad001
         IF l_n > 0 THEN 
            CONTINUE FOREACH 
         END IF 
         
         #161111-00028#8----modify----begin---------
         #INSERT INTO glaw_t values(l_glaw.*)
         INSERT INTO glaw_t (glawent,glawownid,glawowndp,glawcrtid,glawcrtdp,glawcrtdt,glawmodid,glawmoddt,glawstus,
                             glaw001,glaw002,glaw003,glaw004,glaw005,glaw006,glaw007)
          VALUES(l_glaw.glawent,l_glaw.glawownid,l_glaw.glawowndp,l_glaw.glawcrtid,l_glaw.glawcrtdp,l_glaw.glawcrtdt,l_glaw.glawmodid,l_glaw.glawmoddt,l_glaw.glawstus,
                 l_glaw.glaw001,l_glaw.glaw002,l_glaw.glaw003,l_glaw.glaw004,l_glaw.glaw005,l_glaw.glaw006,l_glaw.glaw007)
         #161111-00028#8----modify----end---------
         IF SQLCA.SQLcode  THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = SQLCA.sqlcode
            LET g_errparam.extend = "g_glaw"
            LET g_errparam.popup = TRUE
            CALL cl_err()
  
            LET g_success = 'N'                 
         ELSE
            LET g_success = 'Y'           
         END IF
      END FOREACH 
   END FOREACH 
END FUNCTION
#+ glaw003欄位檢查
PRIVATE FUNCTION agli110_01_glaw003_chk()
   DEFINE l_n            LIKE type_t.num5
   DEFINE l_glaald       LIKE glaa_t.glaald
   DEFINE l_pass         LIKE type_t.num5 #160811-00039#6
   
   LET g_wc = cl_replace_str(g_wc,"glaw001","glaald")
   LET g_sql = "SELECT glaald FROM glaa_t",
               " WHERE glaaent = '",g_enterprise,"'",
               "   AND ",g_wc               
               
   PREPARE glawld_pre FROM g_sql
   DECLARE glawld_cur CURSOR FOR glawld_pre
   
   LET g_success = 'Y'
   FOREACH glawld_cur INTO l_glaald
      IF l_glaald = g_glaw.glaw003 THEN 
         LET g_glaw.glaw003_desc = ''
         DISPLAY g_glaw.glaw003_desc TO glaw003_desc
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = 'agl-00112'
         LET g_errparam.extend = g_glaw.glaw003
         LET g_errparam.popup = TRUE
         CALL cl_err()

         LET g_success = 'N'
         EXIT FOREACH 
      END IF 
   END FOREACH 
   
   IF g_success = 'N' THEN 
      RETURN FALSE
   END IF
   
   #判斷資料是否存在
   SELECT COUNT(*) INTO l_n
     FROM glaa_t
    WHERE glaaent = g_enterprise
      AND glaald = g_glaw.glaw003
      
   IF l_n = 0 THEN 
      LET g_glaw.glaw003_desc = ''
      DISPLAY g_glaw.glaw003_desc TO glaw003_desc
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'ais-00043'
      LET g_errparam.extend = g_glaw.glaw003
      LET g_errparam.popup = TRUE
      CALL cl_err()

      RETURN FALSE
   END IF 
   
   #判斷資料是否有效
   SELECT COUNT(*) INTO l_n
     FROM glaa_t
    WHERE glaaent = g_enterprise
      AND glaald = g_glaw.glaw003
      AND glaastus = 'Y'
      
   IF l_n = 0 THEN 
      LET g_glaw.glaw003_desc = ''
      DISPLAY g_glaw.glaw003_desc TO glaw003_desc
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'ais-00044'
      LET g_errparam.extend = g_glaw.glaw003
      LET g_errparam.popup = TRUE
      CALL cl_err()

      RETURN FALSE
   END IF
   
   #160811-00039#6--add--str--
   CALL s_ld_chk_authorization(g_user,g_glaw.glaw003) RETURNING l_pass
   IF l_pass = FALSE THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'agl-00165'
      LET g_errparam.extend = g_glaw.glaw003
      LET g_errparam.popup = TRUE
      CALL cl_err()
      RETURN FALSE
   END IF
   #160811-00039#6--add--end
   
   #帶值
   SELECT glaal002 INTO g_glaw.glaw003_desc
     FROM glaal_t
    WHERE glaalent = g_enterprise
      AND glaalld = g_glaw.glaw003
      AND glaal001 = g_dlang
   DISPLAY g_glaw.glaw003_desc TO glaw003_desc 
   
   RETURN TRUE
END FUNCTION

 
{</section>}
 
