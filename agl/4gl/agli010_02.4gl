#該程式未解開Section, 採用最新樣板產出!
{<section id="agli010_02.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0003(2013-10-17 00:00:00), PR版次:0003(2016-03-28 09:39:24)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000149
#+ Filename...: agli010_02
#+ Description: 部門設限
#+ Creator....: 02299(2013-10-17 00:00:00)
#+ Modifier...: 02299 -SD/PR- 07675
 
{</section>}
 
{<section id="agli010_02.global" >}
#應用 c02b 樣板自動產生(Version:10)
#add-point:填寫註解說明 name="global.memo"
#160318-00005#13  2016/03/25 by 07675  將重複內容的錯誤訊息置換為公用錯誤訊息
#end add-point
#add-point:填寫註解說明(客製用) name="global.memo_customerization"

#end add-point
 
IMPORT os
IMPORT FGL lib_cl_dlg
#add-point:增加匯入項目 name="global.import"

#end add-point
 
SCHEMA ds
 
GLOBALS "../../cfg/top_global.inc"
 
#add-point:增加匯入變數檔 name="global.inc"

#end add-point
 
#單身 type 宣告
PRIVATE TYPE type_g_glbb_d        RECORD
       glbbld LIKE glbb_t.glbbld, 
   glbb001 LIKE glbb_t.glbb001, 
   glbb001_desc LIKE type_t.chr500
       END RECORD
 
 
#add-point:自定義模組變數(Module Variable)(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="global.variable"
DEFINE g_detail_cnt         LIKE type_t.num5              #單身 總筆數(所有資料)
DEFINE g_forupd_sql         STRING           {#ADP版次:1#}
#end add-point
 
DEFINE g_glbb_d          DYNAMIC ARRAY OF type_g_glbb_d
DEFINE g_glbb_d_t        type_g_glbb_d
 
 
DEFINE g_glbbld_t   LIKE glbb_t.glbbld    #Key值備份
DEFINE g_glbb001_t      LIKE glbb_t.glbb001    #Key值備份
 
 
DEFINE l_ac                  LIKE type_t.num10
DEFINE g_ref_fields          DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
DEFINE g_rtn_fields          DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
DEFINE g_ref_vars            DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
DEFINE g_rec_b               LIKE type_t.num10 
DEFINE g_detail_idx          LIKE type_t.num10
 
#add-point:自定義客戶專用模組變數(Module Variable) name="global.variable_customerization"

#end add-point
    
#add-point:傳入參數說明(global.argv) name="global.argv"

#end add-point    
 
{</section>}
 
{<section id="agli010_02.input" >}
#+ 資料輸入
PUBLIC FUNCTION agli010_02(--)
   #add-point:input段變數傳入 name="input.get_var"
   p_glaald
   #end add-point
   )
   #add-point:input段define name="input.define_customerization"
   
   #end add-point
   DEFINE l_ac_t          LIKE type_t.num10       #未取消的ARRAY CNT 
   DEFINE l_allow_insert  LIKE type_t.num5        #可新增否 
   DEFINE l_allow_delete  LIKE type_t.num5        #可刪除否  
   DEFINE l_count         LIKE type_t.num10
   DEFINE l_insert        LIKE type_t.num5
   DEFINE l_cmd           LIKE type_t.chr5
   #add-point:input段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="input.define"
   DEFINE p_glaald LIKE glaa_t.glaald
   DEFINE  l_n             LIKE type_t.num5                #檢查重複用
   DEFINE  l_cnt           LIKE type_t.num5                #檢查重複用
   DEFINE  l_lock_sw       LIKE type_t.chr1                #單身鎖住否
   DEFINE l_glbbcrtdt     LIKE glbb_t.glbbcrtdt
   DEFINE l_glbbmoddt     LIKE glbb_t.glbbmoddt 
   #end add-point
 
   #畫面開啟 (identifier)
   OPEN WINDOW w_agli010_02 WITH FORM cl_ap_formpath("agl","agli010_02")
 
   #瀏覽頁簽資料初始化
   CALL cl_ui_init()
   
   LET g_qryparam.state = "i"
   
   LET l_allow_insert = cl_auth_detail_input("insert")
   LET l_allow_delete = cl_auth_detail_input("delete")
   
   #輸入前處理
   #add-point:單身前置處理 name="input.pre_input"
   WHENEVER ERROR CALL cl_err_msg_log
   LET l_glbbcrtdt = cl_get_current()
   LET l_glbbmoddt = cl_get_current()

   CALL agli010_02_b_fill(p_glaald) 
   LET g_forupd_sql = "SELECT glbbld,glbb001,'' FROM glbb_t ",
                      " WHERE glbbent = '",g_enterprise,"' AND glbbld = '",p_glaald,"' AND glbb001 = ? FOR UPDATE"

   DECLARE agli010_02_bcl CURSOR FROM g_forupd_sql      # LOCK CURSOR

   LET INT_FLAG = FALSE 
   #end add-point
  
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
   
      #輸入開始
      INPUT ARRAY g_glbb_d FROM s_detail1.*
          ATTRIBUTE(COUNT = g_rec_b,MAXCOUNT = g_max_rec,WITHOUT DEFAULTS, 
                  INSERT ROW = l_allow_insert,
                  DELETE ROW = l_allow_delete,
                  APPEND ROW = l_allow_insert)
         
         #自訂ACTION
         #add-point:單身前置處理 name="input.action"
         BEFORE INSERT
            CALL s_transaction_begin()
            #LET l_n = ARR_COUNT()
            LET l_cmd = 'a'
            INITIALIZE g_glbb_d_t.* TO NULL
            INITIALIZE g_glbb_d[l_ac].* TO NULL
            LET g_glbb_d[l_ac].glbbld = p_glaald
            
         AFTER INSERT
            IF INT_FLAG THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = 9001
               LET g_errparam.extend = ''
               LET g_errparam.popup = FALSE
               CALL cl_err()

               LET INT_FLAG = 0
               CANCEL INSERT
            END IF
            
            INSERT INTO glbb_t(glbbent,glbbld,glbb001,glbbownid,glbbowndp,glbbcrtid,glbbcrtdt,glbbcrtdp,glbbstus) 
             VALUES(g_enterprise,p_glaald,g_glbb_d[l_ac].glbb001,g_user,g_dept,g_user,l_glbbcrtdt,g_dept,'Y')
             
            IF SQLCA.SQLcode  THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = SQLCA.sqlcode
               LET g_errparam.extend = "glbb_t"
               LET g_errparam.popup = TRUE
               CALL cl_err()

               CALL s_transaction_end('N','0')
               CANCEL INSERT
            ELSE
               CALL s_transaction_end('Y','0')
               ERROR 'INSERT O.K'
               #LET g_detail_cnt = g_detail_cnt + 1
            END IF
            
        BEFORE DELETE
           IF NOT cl_null(g_glbb_d[l_ac].glbb001) THEN
              IF NOT cl_ask_del_detail() THEN
                 CANCEL DELETE
              END IF

              DELETE FROM glbb_t
               WHERE glbbent = g_enterprise AND glbbld = p_glaald
                 AND glbb001 = g_glbb_d[l_ac].glbb001
                 
              IF SQLCA.sqlcode THEN
                 INITIALIZE g_errparam TO NULL
               LET g_errparam.code = SQLCA.sqlcode
               LET g_errparam.extend = "glbb_t"
               LET g_errparam.popup = TRUE
               CALL cl_err()

                 CALL s_transaction_end('N','0')
                 CANCEL DELETE
              END IF 
            END IF
            
         BEFORE ROW
            LET g_detail_idx = DIALOG.getCurrentRow("s_detail1")
            LET l_cmd = ''
            LET l_ac = ARR_CURR()
            LET l_lock_sw = 'N'            #DEFAULT
            LET l_n = ARR_COUNT()
            DISPLAY l_ac TO FORMONLY.idx
            DISPLAY g_glbb_d.getlength() TO cnt
            CALL s_transaction_begin()
            LET g_detail_cnt = g_glbb_d.getLength()

            IF g_detail_cnt >= l_ac
               AND NOT cl_null(g_glbb_d[l_ac].glbbld)
            THEN
               LET l_cmd='u'
               LET g_glbb_d_t.* = g_glbb_d[l_ac].*  #BACKUP
               IF NOT agli010_02_lock_b("glbb_t") THEN
                  LET l_lock_sw='Y'
               ELSE
                  FETCH agli010_02_bcl INTO g_glbb_d[l_ac].glbbld,g_glbb_d[l_ac].glbb001,g_glbb_d[l_ac].glbb001_desc
                  IF SQLCA.sqlcode THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = SQLCA.sqlcode
                     LET g_errparam.extend = g_glbb_d_t.glbb001
                     LET g_errparam.popup = TRUE
                     CALL cl_err()

                     LET l_lock_sw = "Y"
                  END IF
                  CALL agli010_02_detail_show(g_glbb_d[l_ac].glbb001) 
                     RETURNING g_glbb_d[l_ac].glbb001_desc
                  DISPLAY g_glbb_d[l_ac].glbb001_desc TO s_detail1[l_ac].glbb001_desc
                  CALL cl_show_fld_cont()
               END IF
            ELSE
               LET l_cmd='a'
            END IF
         ON ROW CHANGE
            IF INT_FLAG THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = 9001
               LET g_errparam.extend = ''
               LET g_errparam.popup = FALSE
               CALL cl_err()

               LET INT_FLAG = 0
               LET g_glbb_d[l_ac].* = g_glbb_d_t.*
               CLOSE agli010_02_bcl
               CALL s_transaction_end('N','0')
               EXIT DIALOG
            END IF

            IF l_lock_sw = 'Y' THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = -263
               LET g_errparam.extend = g_glbb_d[l_ac].glbbld
               LET g_errparam.popup = TRUE
               CALL cl_err()

               LET g_glbb_d[l_ac].* = g_glbb_d_t.*
            ELSE
               UPDATE glbb_t SET glbb001 = g_glbb_d[l_ac].glbb001,
                                 glbbmodid= g_user,glbbmoddt=l_glbbmoddt
                WHERE glbbent = g_enterprise AND glbbld = p_glaald
                  AND glbb001 = g_glbb_d_t.glbb001
           
            END IF
         AFTER ROW
            CALL agli010_02_unlock_b("glbb_t")
            CALL s_transaction_end('Y','0')
            #其他table進行unlock
            CALL cl_multitable_unlock()  
         #end add-point
         
         #自訂ACTION(detail_input)
         
         
         BEFORE INPUT
            #add-point:單身輸入前處理 name="input.before_input"
            
            #end add-point
          
                  #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glbbld
            #add-point:BEFORE FIELD glbbld name="input.b.page1.glbbld"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glbbld
            
            #add-point:AFTER FIELD glbbld name="input.a.page1.glbbld"
            #此段落由子樣板a05產生

            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE glbbld
            #add-point:ON CHANGE glbbld name="input.g.page1.glbbld"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glbb001
            
            #add-point:AFTER FIELD glbb001 name="input.a.page1.glbb001"
            #此段落由子樣板a05產生
            CALL agli010_02_detail_show(g_glbb_d[l_ac].glbb001) 
               RETURNING g_glbb_d[l_ac].glbb001_desc
            DISPLAY g_glbb_d[l_ac].glbb001_desc TO s_detail1[l_ac].glbb001_desc
            IF  NOT cl_null(g_glbb_d[l_ac].glbbld) AND NOT cl_null(g_glbb_d[l_ac].glbb001) THEN 
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND ( l_cmd = 'u' AND (g_glbb_d[l_ac].glbbld != g_glbb_d_t.glbbld OR g_glbb_d[l_ac].glbb001 != g_glbb_d_t.glbb001))) THEN 
                  IF NOT ap_chk_notDup(g_glbb_d[l_ac].glbb001,"SELECT COUNT(*) FROM glbb_t WHERE "||"glbbent = '" ||g_enterprise|| "' AND "||"glbbld = '"||g_glbb_d[l_ac].glbbld ||"' AND "|| "glbb001 = '"||g_glbb_d[l_ac].glbb001 ||"'",'std-00004',0) THEN 
                     LET g_glbb_d[l_ac].glbb001 = g_glbb_d_t.glbb001
                     CALL agli010_02_detail_show(g_glbb_d[l_ac].glbb001) 
                        RETURNING g_glbb_d[l_ac].glbb001_desc
                     DISPLAY g_glbb_d[l_ac].glbb001_desc TO s_detail1[l_ac].glbb001_desc
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF
            IF NOT agli010_02_glbb001_chk(g_glbb_d[l_ac].glbb001) THEN
               LET g_glbb_d[l_ac].glbb001 = g_glbb_d_t.glbb001
               CALL agli010_02_detail_show(g_glbb_d[l_ac].glbb001) 
                  RETURNING g_glbb_d[l_ac].glbb001_desc
               DISPLAY g_glbb_d[l_ac].glbb001_desc TO s_detail1[l_ac].glbb001_desc
               NEXT FIELD CURRENT
            END IF 
            CALL agli010_02_detail_show(g_glbb_d[l_ac].glbb001) 
               RETURNING g_glbb_d[l_ac].glbb001_desc
            DISPLAY g_glbb_d[l_ac].glbb001_desc TO s_detail1[l_ac].glbb001_desc

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glbb001
            #add-point:BEFORE FIELD glbb001 name="input.b.page1.glbb001"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE glbb001
            #add-point:ON CHANGE glbb001 name="input.g.page1.glbb001"
            
            #END add-point 
 
 
 
                  #Ctrlp:input.c.page1.glbbld
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glbbld
            #add-point:ON ACTION controlp INFIELD glbbld name="input.c.page1.glbbld"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.glbb001
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glbb001
            #add-point:ON ACTION controlp INFIELD glbb001 name="input.c.page1.glbb001"
#此段落由子樣板a07產生            
            #開窗i段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
			LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_glbb_d[l_ac].glbb001             #給予default值

            #給予arg
            LET g_qryparam.arg1 = today
            CALL q_ooeg001()                                #呼叫開窗

            LET g_glbb_d[l_ac].glbb001 = g_qryparam.return1              #將開窗取得的值回傳到變數

            DISPLAY g_glbb_d[l_ac].glbb001 TO glbb001              #顯示到畫面上
            CALL agli010_02_detail_show(g_glbb_d[l_ac].glbb001) 
               RETURNING g_glbb_d[l_ac].glbb001_desc
            DISPLAY g_glbb_d[l_ac].glbb001_desc TO s_detail1[l_ac].glbb001_desc
            NEXT FIELD glbb001                          #返回原欄位


            #END add-point
 
 
 
 
         #自訂ACTION
         #add-point:單身其他段落處理(EX:on row change, etc...) name="input.other"
         
         #end add-point
 
         AFTER INPUT
            #add-point:單身輸入後處理 name="input.after_input"
            
            #end add-point
            
      END INPUT
      
 
      
      #add-point:自定義input name="input.more_input"
      
      #end add-point
    
      #公用action
      ON ACTION accept
         ACCEPT DIALOG
        
      ON ACTION cancel
         #add-point:cancel name="input.cancel"
         
         #end add-point
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
 
   #add-point:畫面關閉前 name="input.before_close"
   
   #end add-point
   
   #畫面關閉
   CLOSE WINDOW w_agli010_02 
   
   #add-point:input段after input name="input.post_input"
   
   #end add-point    
   
END FUNCTION
 
{</section>}
 
{<section id="agli010_02.other_dialog" readonly="Y" >}

 
{</section>}
 
{<section id="agli010_02.other_function" readonly="Y" >}
#+
PRIVATE FUNCTION agli010_02_b_fill(p_glaald)
   DEFINE p_glaald LIKE glaa_t.glaald
   DEFINE l_sql STRING
   
   LET l_sql = " SELECT glbbld,glbb001 FROM glbb_t ",
               "  WHERE glbbent = '",g_enterprise,"' AND glbbld = '",p_glaald,"'"
   PREPARE agli010_02_b_fill_pre FROM l_sql
   DECLARE agli010_02_b_fill_cs CURSOR FOR agli010_02_b_fill_pre
   CALL g_glbb_d.clear()
   LET l_ac = 1
   FOREACH agli010_02_b_fill_cs INTO g_glbb_d[l_ac].glbbld,g_glbb_d[l_ac].glbb001
      CALL agli010_02_detail_show(g_glbb_d[l_ac].glbb001) 
         RETURNING g_glbb_d[l_ac].glbb001_desc
      LET l_ac = l_ac + 1
   END FOREACH
   CALL g_glbb_d.deleteElement(g_glbb_d.getLength())
   DISPLAY g_glbb_d.getlength() TO cnt
END FUNCTION
#+
PRIVATE FUNCTION agli010_02_detail_show(p_glbb001)
   DEFINE p_glbb001 LIKE glbb_t.glbb001
   DEFINE r_ooefl003 LIKE ooefl_t.ooefl003
   
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_glbb_d[l_ac].glbb001
   CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET r_ooefl003 = g_rtn_fields[1]
   RETURN r_ooefl003
   
END FUNCTION
#+
PRIVATE FUNCTION agli010_02_lock_b(ps_table)
   DEFINE ps_table STRING
   DEFINE ls_group STRING

   #鎖定整組table

   #僅鎖定自身table
   LET ls_group = "glbb_t"

   IF ls_group.getIndexOf(ps_table,1) THEN

      OPEN agli010_02_bcl USING g_glbb_d[l_ac].glbb001

      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "agli010_02_bcl"
         LET g_errparam.popup = TRUE
         CALL cl_err()

         RETURN FALSE
      END IF

   END IF

   RETURN TRUE
END FUNCTION
#+
PRIVATE FUNCTION agli010_02_unlock_b(ps_table)
   DEFINE ps_table STRING

   CLOSE agli010_02_bcl
END FUNCTION
#+
PRIVATE FUNCTION agli010_02_glbb001_chk(p_glbb001)
   DEFINE p_glbb001 LIKE glbb_t.glbb001
   DEFINE r_success  LIKE type_t.num5
   DEFINE l_date     LIKE ooeg_t.ooeg006
   LET r_success = TRUE
   IF NOT cl_null(p_glbb001) THEN
      #檢查是否存在
      IF r_success THEN
         IF NOT ap_chk_isExist(p_glbb001,"SELECT COUNT(*) FROM ooeg_t WHERE ooegent = '"
            ||g_enterprise||"' AND ooeg001 = ? ","abm-00006",1) THEN
            LET r_success = FALSE
         END IF
      END IF

      #檢查是否有效
      IF r_success THEN
         IF NOT ap_chk_isExist(p_glbb001,"SELECT COUNT(*) FROM ooeg_t WHERE ooegent = '"
#            ||g_enterprise||"' AND ooeg001 = ? AND ooegstus = 'Y' ","abm-00007",1) THEN
             ||g_enterprise||"' AND ooeg001 = ? AND ooegstus = 'Y' ",'sub-01302','aooi125') THEN  #160318-00005#13 mod  
            LET r_success = FALSE
         END IF
      END IF
      #檢查是否在日期範圍內
      IF r_success THEN
         LET l_date = cl_get_current()
         IF NOT ap_chk_isExist(p_glbb001,"SELECT COUNT(*) FROM ooeg_t WHERE ooegent = '"
            ||g_enterprise||"' AND ooeg001 = ? AND ooegstus = 'Y' AND (ooeg006 <= '" ||l_date||"' AND (ooeg007 IS NULL OR ooeg007 > '" ||l_date||"' )) ","aoo-00201",1) THEN
            LET r_success = FALSE
         END IF
      END IF
   END IF
   RETURN r_success

END FUNCTION

 
{</section>}
 
