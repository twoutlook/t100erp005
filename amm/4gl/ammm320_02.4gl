#該程式未解開Section, 採用最新樣板產出!
{<section id="ammm320_02.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0002(2013-11-25 17:28:56), PR版次:0002(2016-11-11 14:11:13)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000125
#+ Filename...: ammm320_02
#+ Description: 會員卡種基本資料維護作業-效期延長規則設定
#+ Creator....: 01752(2013-11-22 10:19:01)
#+ Modifier...: 01752 -SD/PR- 02481
 
{</section>}
 
{<section id="ammm320_02.global" >}
#應用 c02b 樣板自動產生(Version:10)
#add-point:填寫註解說明 name="global.memo"
#161111-00028#1   2016/11/11 BY 02481    标准程式定义采用宣告模式,弃用.*写法
#Memos
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
PRIVATE TYPE type_g_mmao_d        RECORD
       mmao001 LIKE mmao_t.mmao001, 
   mmao002 LIKE mmao_t.mmao002, 
   mmao003 LIKE mmao_t.mmao003, 
   mmao004 LIKE mmao_t.mmao004, 
   mmaostus LIKE mmao_t.mmaostus
       END RECORD
 
 
#add-point:自定義模組變數(Module Variable)(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="global.variable"

#end add-point
 
DEFINE g_mmao_d          DYNAMIC ARRAY OF type_g_mmao_d
DEFINE g_mmao_d_t        type_g_mmao_d
 
 
DEFINE g_mmao001_t   LIKE mmao_t.mmao001    #Key值備份
DEFINE g_mmao002_t      LIKE mmao_t.mmao002    #Key值備份
DEFINE g_mmao003_t      LIKE mmao_t.mmao003    #Key值備份
 
 
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
 
{<section id="ammm320_02.input" >}
#+ 資料輸入
PUBLIC FUNCTION ammm320_02(--)
   #add-point:input段變數傳入 name="input.get_var"
   p_mman001
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
   DEFINE p_mman001       LIKE mmao_t.mmao001
  #DEFINE l_mmao          RECORD LIKE mmao_t.*  #161111-00028#1--mark
  #161111-00028#1---add----begin------------
   DEFINE l_mmao RECORD  #效期延長規則設定檔
       mmaoent LIKE mmao_t.mmaoent, #企業編號
       mmao001 LIKE mmao_t.mmao001, #卡種編號
       mmao002 LIKE mmao_t.mmao002, #組別
       mmao003 LIKE mmao_t.mmao003, #效期延長規則
       mmao004 LIKE mmao_t.mmao004, #規則下限
       mmaostus LIKE mmao_t.mmaostus #有效
      END RECORD
   #161111-00028#1---add----end------------    
   DEFINE l_forupd_sql    STRING
   DEFINE l_lock_sw       LIKE type_t.chr1 
   DEFINE l_stus          LIKE type_t.chr1  
   #end add-point
 
   #畫面開啟 (identifier)
   OPEN WINDOW w_ammm320_02 WITH FORM cl_ap_formpath("amm","ammm320_02")
 
   #瀏覽頁簽資料初始化
   CALL cl_ui_init()
   
   LET g_qryparam.state = "i"
   
   LET l_allow_insert = cl_auth_detail_input("insert")
   LET l_allow_delete = cl_auth_detail_input("delete")
   
   #輸入前處理
   #add-point:單身前置處理 name="input.pre_input"
   WHENEVER ERROR CALL cl_err_msg_log
   CALL ammm320_02_b_fill(p_mman001)   
   CALL cl_set_combo_scc('mmao003','6508')
   
   LET l_stus = ''
   SELECT mmanstus INTO l_stus FROM mman_t
    WHERE mmanent = g_enterprise
      AND mman001 = p_mman001
   IF l_stus != 'N' THEN
      CALL ammm320_02_ui_dialog()
      LET INT_FLAG = FALSE
      CLOSE WINDOW w_ammm320_02 
      RETURN
   END IF
   
   LET l_forupd_sql = " SELECT mmao001,mmao002,mmao003,mmao004,mmaostus ",
                      "   FROM mmao_t ",
                      "  WHERE mmaoent = '",g_enterprise,"' ",
                      "    AND mmao001 = ? AND mmao002 = ? AND mmao003 = ? FOR UPDATE"
   LET l_forupd_sql = cl_sql_forupd(l_forupd_sql)  
   PREPARE ammm320_02_b FROM l_forupd_sql
   DECLARE ammm320_02_cs CURSOR FOR ammm320_02_b 
   LET INT_FLAG = FALSE    
   #end add-point
  
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
   
      #輸入開始
      INPUT ARRAY g_mmao_d FROM s_detail1.*
          ATTRIBUTE(COUNT = g_rec_b,MAXCOUNT = g_max_rec,WITHOUT DEFAULTS, 
                  INSERT ROW = l_allow_insert,
                  DELETE ROW = l_allow_delete,
                  APPEND ROW = l_allow_insert)
         
         #自訂ACTION
         #add-point:單身前置處理 name="input.action"
         
         #end add-point
         
         #自訂ACTION(detail_input)
         
         
         BEFORE INPUT
            #add-point:單身輸入前處理 name="input.before_input"
         BEFORE ROW
            LET l_cmd = ''
            LET l_ac = ARR_CURR()
            LET l_lock_sw = 'N'            #DEFAULT
            DISPLAY l_ac TO FORMONLY.idx
         
            CALL s_transaction_begin()
            
            IF g_rec_b >= l_ac THEN  
               LET l_cmd='u'
               LET g_mmao_d_t.* = g_mmao_d[l_ac].*  #BACKUP
               OPEN ammm320_02_cs USING p_mman001,g_mmao_d[l_ac].mmao002,g_mmao_d[l_ac].mmao003

               IF SQLCA.sqlcode THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = SQLCA.sqlcode
                  LET g_errparam.extend = "ammm320_02_cs"
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  LET l_lock_sw='Y'
               ELSE
                  FETCH ammm320_02_cs INTO g_mmao_d[l_ac].*
                  IF SQLCA.sqlcode THEN
                     LET l_lock_sw = "Y"
                  END IF            
                  CALL cl_show_fld_cont()
               END IF
            ELSE
               LET l_cmd='a'
            END IF
            
         BEFORE INSERT
            CALL s_transaction_begin()
            LET l_cmd = 'a'
            INITIALIZE g_mmao_d_t.* TO NULL
            INITIALIZE g_mmao_d[l_ac].* TO NULL 
            LET g_mmao_d[l_ac].mmao001 = p_mman001
            LET g_mmao_d[l_ac].mmaostus = 'Y'
            LET g_mmao_d_t.* = g_mmao_d[l_ac].*     #新輸入資料
            CALL cl_show_fld_cont()  
            
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

            INITIALIZE l_mmao.* TO NULL
            LET l_mmao.mmaoent = g_enterprise        
            LET l_mmao.mmao001 = g_mmao_d[l_ac].mmao001
            LET l_mmao.mmao002 = g_mmao_d[l_ac].mmao002
            LET l_mmao.mmao003 = g_mmao_d[l_ac].mmao003
            LET l_mmao.mmao004 = g_mmao_d[l_ac].mmao004
            LET l_mmao.mmaostus = g_mmao_d[l_ac].mmaostus
         
            SELECT COUNT(*) INTO l_count FROM mmao_t 
             WHERE mmaoent = g_enterprise
               AND mmao001 = p_mman001
               AND mmao002 = g_mmao_d[l_ac].mmao002
               AND mmao003 = g_mmao_d[l_ac].mmao003
                
            #資料未重複, 插入新增資料
            IF l_count = 0 THEN 
              #INSERT INTO mmao_t VALUES (l_mmao.*)  #161111-00028#1--mark
               #161111-00028#1----add----begin----------------
               INSERT INTO mmao_t (mmaoent,mmao001,mmao002,mmao003,mmao004,mmaostus)
               VALUES (l_mmao.mmaoent,l_mmao.mmao001,l_mmao.mmao002,l_mmao.mmao003,l_mmao.mmao004,l_mmao.mmaostus)
 
               #161111-00028#1----add----end----------------
               IF SQLCA.sqlcode THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = SQLCA.sqlcode
                  LET g_errparam.extend = "mmao_t"
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  CONTINUE DIALOG
               END IF
            ELSE    
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = "std-00006"
               LET g_errparam.extend = 'INSERT'
               LET g_errparam.popup = TRUE
               CALL cl_err()

               INITIALIZE g_mmao_d[l_ac].* TO NULL
               CALL s_transaction_end('N',0)
               CANCEL INSERT
            END IF
 
            IF SQLCA.SQLcode THEN
               INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = SQLCA.sqlcode
                  LET g_errparam.extend = "mmao_t"
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
  
               CALL s_transaction_end('N',0)                   
               CANCEL INSERT
            ELSE
               CALL s_transaction_end('Y',0)
               ERROR 'INSERT O.K'
               LET g_rec_b = g_rec_b + 1
            END IF
 
        BEFORE DELETE                            #是否取消單身
            IF NOT cl_null(p_mman001) AND NOT cl_null(g_mmao_d_t.mmao002) AND
               NOT cl_null(g_mmao_d_t.mmao003)THEN

               IF NOT cl_ask_del_detail() THEN
                  CANCEL DELETE
               END IF
               IF l_lock_sw = "Y" THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code =  -263
                  LET g_errparam.extend = ""
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  CANCEL DELETE
               END IF
               DELETE FROM mmao_t
                WHERE mmaoent = g_enterprise 
                  AND mmao001 = p_mman001
                  AND mmao002 = g_mmao_d_t.mmao002
                  AND mmao003 = g_mmao_d_t.mmao003
 
               IF SQLCA.sqlcode THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = SQLCA.sqlcode
                  LET g_errparam.extend = "mmao_t"
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  CALL s_transaction_end('N',0)
                  CANCEL DELETE   
               ELSE
                  LET g_rec_b = g_rec_b-1
                  CALL s_transaction_end('Y',0)
               END IF 
               CLOSE ammm320_02_cs
            END IF 
            
         ON ROW CHANGE
            IF INT_FLAG THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = 9001
               LET g_errparam.extend = ''
               LET g_errparam.popup = FALSE
               CALL cl_err()

               LET INT_FLAG = 0
               LET g_mmao_d[l_ac].* = g_mmao_d_t.*
               CLOSE ammm320_02_cs
               CALL s_transaction_end('N',0)
               EXIT DIALOG 
            END IF
              
            IF l_lock_sw = 'Y' THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = -263
               LET g_errparam.extend = l_mmao.mmao001
               LET g_errparam.popup = TRUE
               CALL cl_err()

               LET g_mmao_d[l_ac].* = g_mmao_d_t.*
            ELSE
               UPDATE mmao_t SET (mmao002,mmao003,mmao004,mmaostus) = 
                                 (g_mmao_d[l_ac].mmao002,g_mmao_d[l_ac].mmao003,
                                  g_mmao_d[l_ac].mmao004,g_mmao_d[l_ac].mmaostus)
                WHERE mmaoent = g_enterprise
                  AND mmao001 = p_mman001
                  AND mmao002 = g_mmao_d_t.mmao002
                  AND mmao003 = g_mmao_d_t.mmao003
               IF SQLCA.sqlcode THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = SQLCA.sqlcode
                  LET g_errparam.extend = "mmao_t"
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
   
                  LET g_mmao_d[l_ac].* = g_mmao_d_t.*
                  CALL s_transaction_end('N',0)
               ELSE
                  CALL s_transaction_end('Y',0)               
               END IF
            END IF
            
         AFTER ROW
            CLOSE ammm320_02_cs   
            #end add-point
          
                  #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mmao001
            #add-point:BEFORE FIELD mmao001 name="input.b.page1.mmao001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mmao001
            
            #add-point:AFTER FIELD mmao001 name="input.a.page1.mmao001"
 
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mmao001
            #add-point:ON CHANGE mmao001 name="input.g.page1.mmao001"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mmao002
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_mmao_d[l_ac].mmao002,"1.000","1","","","azz-00079",1) THEN
               NEXT FIELD mmao002
            END IF 
 
 
 
            #add-point:AFTER FIELD mmao002 name="input.a.page1.mmao002"
            IF NOT cl_null(g_mmao_d[l_ac].mmao002) AND NOT cl_null(g_mmao_d[l_ac].mmao003) THEN 
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_mmao_d[l_ac].mmao002 != g_mmao_d_t.mmao002 OR g_mmao_d_t.mmao002 IS NULL)) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM mmao_t WHERE "||"mmaoent = '" ||g_enterprise|| "' AND "||"mmao001 = '"||g_mmao_d[l_ac].mmao001 ||"' AND "|| "mmao002 = '"||g_mmao_d[l_ac].mmao002 ||"' AND "|| "mmao003 = '"||g_mmao_d[l_ac].mmao003 ||"'",'std-00004',0) THEN 
                     LET g_mmao_d[l_ac].mmao002 = g_mmao_d_t.mmao002
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF  
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mmao002
            #add-point:BEFORE FIELD mmao002 name="input.b.page1.mmao002"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mmao002
            #add-point:ON CHANGE mmao002 name="input.g.page1.mmao002"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mmao003
            #add-point:BEFORE FIELD mmao003 name="input.b.page1.mmao003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mmao003
            
            #add-point:AFTER FIELD mmao003 name="input.a.page1.mmao003"
            #此段落由子樣板a05產生
            IF NOT cl_null(g_mmao_d[l_ac].mmao002) AND NOT cl_null(g_mmao_d[l_ac].mmao003) THEN 
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_mmao_d[l_ac].mmao003 != g_mmao_d_t.mmao003 OR g_mmao_d_t.mmao003 IS NULL)) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM mmao_t WHERE "||"mmaoent = '" ||g_enterprise|| "' AND "||"mmao001 = '"||g_mmao_d[l_ac].mmao001 ||"' AND "|| "mmao002 = '"||g_mmao_d[l_ac].mmao002 ||"' AND "|| "mmao003 = '"||g_mmao_d[l_ac].mmao003 ||"'",'std-00004',0) THEN 
                     LET g_mmao_d[l_ac].mmao003 = g_mmao_d_t.mmao003
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF  
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mmao003
            #add-point:ON CHANGE mmao003 name="input.g.page1.mmao003"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mmao004
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_mmao_d[l_ac].mmao004,"0.000","1","","","azz-00079",1) THEN
               NEXT FIELD mmao004
            END IF 
 
 
 
            #add-point:AFTER FIELD mmao004 name="input.a.page1.mmao004"
            IF NOT cl_null(g_mmao_d[l_ac].mmao004) THEN 
            END IF 

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mmao004
            #add-point:BEFORE FIELD mmao004 name="input.b.page1.mmao004"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mmao004
            #add-point:ON CHANGE mmao004 name="input.g.page1.mmao004"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mmaostus
            #add-point:BEFORE FIELD mmaostus name="input.b.page1.mmaostus"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mmaostus
            
            #add-point:AFTER FIELD mmaostus name="input.a.page1.mmaostus"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mmaostus
            #add-point:ON CHANGE mmaostus name="input.g.page1.mmaostus"
            
            #END add-point 
 
 
 
                  #Ctrlp:input.c.page1.mmao001
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mmao001
            #add-point:ON ACTION controlp INFIELD mmao001 name="input.c.page1.mmao001"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.mmao002
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mmao002
            #add-point:ON ACTION controlp INFIELD mmao002 name="input.c.page1.mmao002"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.mmao003
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mmao003
            #add-point:ON ACTION controlp INFIELD mmao003 name="input.c.page1.mmao003"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.mmao004
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mmao004
            #add-point:ON ACTION controlp INFIELD mmao004 name="input.c.page1.mmao004"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.mmaostus
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mmaostus
            #add-point:ON ACTION controlp INFIELD mmaostus name="input.c.page1.mmaostus"
            
            #END add-point
 
 
 
 
         #自訂ACTION
         #add-point:單身其他段落處理(EX:on row change, etc...) name="input.other"
         
         #end add-point
 
         AFTER INPUT
            #add-point:單身輸入後處理 name="input.after_input"
            CLOSE ammm320_02_cs
            CALL s_transaction_end('Y',0)    
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
   CLOSE WINDOW w_ammm320_02 
   
   #add-point:input段after input name="input.post_input"
   LET INT_FLAG = FALSE
   CLOSE ammm320_02_cs
   CALL s_transaction_end('Y',0)    
   #end add-point    
   
END FUNCTION
 
{</section>}
 
{<section id="ammm320_02.other_dialog" readonly="Y" >}

 
{</section>}
 
{<section id="ammm320_02.other_function" readonly="Y" >}

PRIVATE FUNCTION ammm320_02_b_fill(p_mman001)
   DEFINE p_mman001     LIKE mman_t.mman001
   DEFINE l_sql           STRING
   DEFINE l_ac_t          LIKE type_t.num5

   LET l_sql = " SELECT mmao001,mmao002,mmao003,mmao004,mmaostus ",
               "   FROM mmao_t ",
               "  WHERE mmaoent = ",g_enterprise,
               "    AND mmao001 = '",p_mman001,"' ",
               "  ORDER BY mmao002,mmao003 " 
   PREPARE ammm320_02_pb FROM l_sql
   DECLARE b_fill_curs CURSOR FOR ammm320_02_pb 
   
   CALL g_mmao_d.clear()
   LET l_ac_t = l_ac
   LET l_ac = 1
   FOREACH b_fill_curs INTO g_mmao_d[l_ac].*
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
         EXIT FOREACH
      END IF
   END FOREACH 
   CALL g_mmao_d.deleteElement(g_mmao_d.getLength())   
   LET g_rec_b = l_ac - 1
   DISPLAY g_rec_b TO FORMONLY.cnt
   LET l_ac = l_ac_t
   CLOSE b_fill_curs
   FREE ammm320_02_pb
END FUNCTION

PRIVATE FUNCTION ammm320_02_ui_dialog()
   DISPLAY ARRAY g_mmao_d TO s_detail1.* ATTRIBUTE(COUNT=g_rec_b)
END FUNCTION

 
{</section>}
 
