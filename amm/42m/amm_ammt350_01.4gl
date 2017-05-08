#該程式未解開Section, 採用最新樣板產出!
{<section id="ammt350_01.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0005(2013-12-27 16:03:33), PR版次:0005(2016-11-21 17:55:52)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000160
#+ Filename...: ammt350_01
#+ Description: 會員卡績點規則申請作業
#+ Creator....: 01533(2013-12-26 10:47:41)
#+ Modifier...: 01533 -SD/PR- 02159
 
{</section>}
 
{<section id="ammt350_01.global" >}
#應用 c02b 樣板自動產生(Version:10)
#add-point:填寫註解說明 name="global.memo"
#160318-00005#23  2016/03/30 by 07675   將重複內容的錯誤訊息置換為公用錯誤訊息
#160824-00007#113 2016/11/21 By sakura  新舊值備份處理
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
PRIVATE TYPE type_g_mmbq_d        RECORD
       mmbqunit LIKE mmbq_t.mmbqunit, 
   mmbqsite LIKE mmbq_t.mmbqsite, 
   mmbqdocno LIKE mmbq_t.mmbqdocno, 
   mmbq001 LIKE mmbq_t.mmbq001, 
   mmbq002 LIKE mmbq_t.mmbq002, 
   mmbq003 LIKE mmbq_t.mmbq003, 
   mmbq004 LIKE mmbq_t.mmbq004, 
   mmbq004_desc LIKE type_t.chr500, 
   mmbqacti LIKE mmbq_t.mmbqacti
       END RECORD
 
 
#add-point:自定義模組變數(Module Variable)(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="global.variable"
DEFINE g_forupd_sql          STRING
DEFINE g_sql                 STRING
DEFINE gs_keys               DYNAMIC ARRAY OF VARCHAR(500) #同步資料用陣列
DEFINE g_cnt                 LIKE type_t.num5  
DEFINE g_mmbosite            LIKE mmbo_t.mmbosite
DEFINE g_mmbq_d_o            type_g_mmbq_d  #160824-00007#113 by sakura add
#end add-point
 
DEFINE g_mmbq_d          DYNAMIC ARRAY OF type_g_mmbq_d
DEFINE g_mmbq_d_t        type_g_mmbq_d
 
 
DEFINE g_mmbqdocno_t   LIKE mmbq_t.mmbqdocno    #Key值備份
DEFINE g_mmbq003_t      LIKE mmbq_t.mmbq003    #Key值備份
DEFINE g_mmbq004_t      LIKE mmbq_t.mmbq004    #Key值備份
 
 
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
 
{<section id="ammt350_01.input" >}
#+ 資料輸入
PUBLIC FUNCTION ammt350_01(--)
   #add-point:input段變數傳入 name="input.get_var"
   p_mmbodocno,p_mmbo001,p_mmbo005,p_mmbo008,p_mmbosite,p_mmbounit
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
   DEFINE p_mmbodocno     LIKE mmbo_t.mmbodocno      
   DEFINE p_mmbo001       LIKE mmbo_t.mmbo001        #规则编号
   DEFINE p_mmbo005       LIKE mmbo_t.mmbo005
   DEFINE p_mmbo008       LIKE mmbo_t.mmbo008        #排除方式
   DEFINE p_mmbosite      LIKE mmbo_t.mmbosite
   DEFINE p_mmbounit     LIKE mmbo_t.mmbounit
   DEFINE l_lock_sw      LIKE type_t.chr1
   DEFINE l_n            LIKE type_t.num5 
   DEFINE l_mmbostus     LIKE mmbo_t.mmbostus
   DEFINE l_flag         LIKE type_t.num5 
   #160519-00025#1 Add By Ken 160524(S)
   DEFINE l_win          ui.Window                  
   DEFINE l_win_title    STRING
   #160519-00025#1 Add By Ken 160524(E)
   #end add-point
 
   #畫面開啟 (identifier)
   OPEN WINDOW w_ammt350_01 WITH FORM cl_ap_formpath("amm","ammt350_01")
 
   #瀏覽頁簽資料初始化
   CALL cl_ui_init()
   
   LET g_qryparam.state = "i"
   
   LET l_allow_insert = cl_auth_detail_input("insert")
   LET l_allow_delete = cl_auth_detail_input("delete")
   
   #輸入前處理
   #add-point:單身前置處理 name="input.pre_input"
   #160519-00025#1 Add By Ken 160524(S)
   IF g_prog = 'agct415' OR g_prog = 'agcm415' OR g_prog = 'agcm416' THEN
      LET l_win_title = cl_getmsg('amm-00756',g_dlang)
      LET l_win = ui.Window.getCurrent()
      CALL l_win.setText(l_win_title)   
   END IF
   #160519-00025#1 Add By Ken 160524(E)
   WHENEVER ERROR CALL cl_err_msg_log
   IF p_mmbo008 = '0' THEN
      CLOSE WINDOW w_ammt350_01
      RETURN
   END IF
   LET g_mmbosite = p_mmbosite
  
   CALL ammt350_01_b_fill(p_mmbodocno,p_mmbo008)
  
   LET g_forupd_sql = "SELECT * FROM mmbo_t WHERE mmboent= ? AND mmbodocno=? FOR UPDATE"

   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)                #轉換不同資料庫語法
   DECLARE ammt350_01_cl CURSOR FROM g_forupd_sql                 # LOCK CURSOR
   
   
   LET g_forupd_sql = "SELECT mmbqdocno,mmbq003,mmbq004,'',mmbqacti FROM mmbq_t WHERE mmbqent=? AND mmbqdocno=? AND mmbq003=? AND mmbq004=? FOR UPDATE"
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)
   DECLARE ammt350_01_bcl CURSOR FROM g_forupd_sql
   
   SELECT mmbostus INTO l_mmbostus FROM mmbo_t WHERE mmboent = g_enterprise AND mmbodocno = p_mmbodocno 
   IF l_mmbostus = 'Y' THEN     #確認的單據只可查看
      DISPLAY ARRAY g_mmbq_d TO s_detail1.* ATTRIBUTES(COUNT=g_rec_b)
      
         BEFORE DISPLAY 
           
         BEFORE ROW 
            LET l_ac = ARR_CURR()
            LET g_detail_idx = l_ac    
            LET l_n = ARR_COUNT()
            DISPLAY l_ac TO FORMONLY.idx
            
         ON ACTION cancel
           LET INT_FLAG = TRUE 
            EXIT DISPLAY 
 
        ON ACTION close
           LET INT_FLAG = TRUE 
           EXIT DISPLAY
 
         ON ACTION exit
           LET INT_FLAG = TRUE 
           EXIT DISPLAY
      END DISPLAY 
   ELSE
   #end add-point
  
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
   
      #輸入開始
      INPUT ARRAY g_mmbq_d FROM s_detail1.*
          ATTRIBUTE(COUNT = g_rec_b,MAXCOUNT = g_max_rec,WITHOUT DEFAULTS, 
                  INSERT ROW = l_allow_insert,
                  DELETE ROW = l_allow_delete,
                  APPEND ROW = l_allow_insert)
         
         #自訂ACTION
         #add-point:單身前置處理 name="input.action"
 BEFORE ROW     
            LET l_insert = FALSE
            LET l_cmd = ''
            LET l_ac = ARR_CURR()
            LET g_detail_idx = l_ac
              
            LET l_lock_sw = 'N'            #DEFAULT
            LET l_n = ARR_COUNT()
            DISPLAY l_ac TO FORMONLY.idx
         
            CALL s_transaction_begin() 
            OPEN ammt350_01_cl USING g_enterprise,p_mmbodocno
            IF STATUS THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code =  STATUS
               LET g_errparam.extend = "OPEN ammt350_01_cl:"
               LET g_errparam.popup = TRUE
               CALL cl_err()

               CLOSE ammt350_01_cl
               CALL s_transaction_end('N','0')
               EXIT DIALOG
            END IF
                   
       
            LET g_rec_b = g_mmbq_d.getLength()
            
            IF g_rec_b >= l_ac 
               AND NOT cl_null(g_mmbq_d[l_ac].mmbq003) 
               AND NOT cl_null(g_mmbq_d[l_ac].mmbq004) 

            THEN 
               LET l_cmd='u'
               LET g_mmbq_d_t.* = g_mmbq_d[l_ac].*
               LET g_mmbq_d_o.* = g_mmbq_d[l_ac].*  #160824-00007#113 by sakura add
          
               IF NOT ammt350_01_lock_b(p_mmbodocno) THEN
                  LET l_lock_sw='Y'
               ELSE
                  FETCH ammt350_01_bcl INTO g_mmbq_d[l_ac].mmbqdocno,g_mmbq_d[l_ac].mmbq003,g_mmbq_d[l_ac].mmbq004,g_mmbq_d[l_ac].mmbq004_desc,g_mmbq_d[l_ac].mmbqacti
                  IF SQLCA.sqlcode THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = SQLCA.sqlcode
                     LET g_errparam.extend = ''
                     LET g_errparam.popup = TRUE
                     CALL cl_err()

                     LET l_lock_sw = "Y"
                  END IF
                  LET g_mmbq_d[l_ac].mmbq004_desc = ammt350_01_mmbq004_ref(g_mmbq_d[l_ac].mmbq003,g_mmbq_d[l_ac].mmbq004)    
                  CALL cl_show_fld_cont()
               END IF
            ELSE
               LET l_cmd='a'
            END IF
            
         BEFORE INSERT
            
            LET l_insert = TRUE
            LET l_n  = ARR_COUNT()
            LET l_cmd = 'a'
            INITIALIZE g_mmbq_d[l_ac].* TO NULL 
            LET g_mmbq_d[l_ac].mmbqsite = p_mmbosite
            LET g_mmbq_d[l_ac].mmbqunit = p_mmbounit
            LET g_mmbq_d[l_ac].mmbq001 = p_mmbo001
            LET g_mmbq_d[l_ac].mmbq002 = p_mmbo005
            LET g_mmbq_d[l_ac].mmbqdocno = p_mmbodocno
            LET g_mmbq_d[l_ac].mmbq003 = p_mmbo008
            LET g_mmbq_d[l_ac].mmbqacti = "Y"
            LET g_mmbq_d_t.* = g_mmbq_d[l_ac].*
            LET g_mmbq_d_o.* = g_mmbq_d[l_ac].* #160824-00007#113 by sakura add
            CALL cl_show_fld_cont()
            
         AFTER INSERT
            LET l_insert = FALSE
            IF INT_FLAG THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = 9001
               LET g_errparam.extend = ''
               LET g_errparam.popup = FALSE
               CALL cl_err()

               LET INT_FLAG = 0
               CANCEL INSERT
            END IF
               
               
            LET l_count = 1  
            SELECT COUNT(*) INTO l_count FROM mmbq_t 
             WHERE mmbqent = g_enterprise AND mmbqdocno = p_mmbodocno

               AND mmbq003 = g_mmbq_d[l_ac].mmbq003
               AND mmbq004 = g_mmbq_d[l_ac].mmbq004


                
            #資料未重複, 插入新增資料
            IF l_count = 0 THEN 
 
            
               INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = p_mmbodocno
               LET gs_keys[2] = g_mmbq_d[g_detail_idx].mmbq003
               LET gs_keys[3] = g_mmbq_d[g_detail_idx].mmbq004
               CALL ammt350_01_insert_b(gs_keys)
                           
            ELSE    
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = "std-00006"
               LET g_errparam.extend = 'INSERT'
               LET g_errparam.popup = TRUE
               CALL cl_err()

               INITIALIZE g_mmbq_d[l_ac].* TO NULL
               CALL s_transaction_end('N','0')
               CANCEL INSERT
            END IF
 
            IF SQLCA.SQLcode  THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = SQLCA.sqlcode
               LET g_errparam.extend = "mmbq_t"
               LET g_errparam.popup = TRUE
               CALL cl_err()
  
               CALL s_transaction_end('N','0')                    
               CANCEL INSERT
            ELSE
            
               CALL s_transaction_end('Y','0')
               ERROR 'INSERT O.K'
               LET g_rec_b = g_rec_b + 1
               DISPLAY g_rec_b TO FORMONLY.cnt
            END IF
  
          BEFORE DELETE                            #是否取消單身
            IF l_cmd = 'a' THEN
               CALL FGL_SET_ARR_CURR(l_ac-1)
               CALL g_mmbq_d.deleteElement(l_ac)
               NEXT FIELD mmbq004
            END IF
         
            IF NOT cl_null(g_mmbq_d[l_ac].mmbq003) 
               AND NOT cl_null(g_mmbq_d_t.mmbq004) 

               THEN 
               
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
               
    
               
               DELETE FROM mmbq_t
                WHERE mmbqent = g_enterprise AND mmbqdocno =p_mmbodocno AND

                      mmbq003 = g_mmbq_d_t.mmbq003
                  AND mmbq004 = g_mmbq_d_t.mmbq004


           
               
               IF SQLCA.sqlcode THEN
                  INITIALIZE g_errparam TO NULL
               LET g_errparam.code = SQLCA.sqlcode
               LET g_errparam.extend = "mmbq_t"
               LET g_errparam.popup = TRUE
               CALL cl_err()

                  CALL s_transaction_end('N','0')
                  CANCEL DELETE   
               ELSE
                  LET g_rec_b = g_rec_b-1
                  
  
                  CALL s_transaction_end('Y','0')
               END IF 
               DISPLAY g_rec_b TO FORMONLY.cnt
               CLOSE ammt350_01_bcl
               LET l_count = g_mmbq_d.getLength()
            END IF 
            
                           INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = p_mmbodocno
               LET gs_keys[2] = g_mmbq_d[g_detail_idx].mmbq003
               LET gs_keys[3] = g_mmbq_d[g_detail_idx].mmbq004
               
        ON ROW CHANGE
            IF INT_FLAG THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = 9001
               LET g_errparam.extend = ''
               LET g_errparam.popup = FALSE
               CALL cl_err()

               LET INT_FLAG = 0
               LET g_mmbq_d[l_ac].* = g_mmbq_d_t.*
               CLOSE ammt350_01_bcl
               CALL s_transaction_end('N','0')
               EXIT DIALOG 
            END IF
              
            IF l_lock_sw = 'Y' THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = -263
               LET g_errparam.extend = g_mmbq_d[l_ac].mmbq003
               LET g_errparam.popup = TRUE
               CALL cl_err()

               LET g_mmbq_d[l_ac].* = g_mmbq_d_t.*
            ELSE
            
      
               UPDATE mmbq_t SET (mmbqdocno,mmbq003,mmbq004,mmbqacti) = (p_mmbodocno,g_mmbq_d[l_ac].mmbq003,g_mmbq_d[l_ac].mmbq004,g_mmbq_d[l_ac].mmbqacti)
                WHERE mmbqent = g_enterprise AND mmbqdocno = p_mmbodocno 

                  AND mmbq003 = g_mmbq_d_t.mmbq003  
                  AND mmbq004 = g_mmbq_d_t.mmbq004  

               
               IF SQLCA.sqlcode THEN
                  INITIALIZE g_errparam TO NULL
               LET g_errparam.code = SQLCA.sqlcode
               LET g_errparam.extend = "mmbq_t"
               LET g_errparam.popup = TRUE
               CALL cl_err()
   
                  LET g_mmbq_d[l_ac].* = g_mmbq_d_t.*
               
                  
               END IF
 
            END IF

        AFTER ROW
       
            CLOSE ammt350_01_bcl
            CALL s_transaction_end('Y','0')
            #其他table進行unlock
         #end add-point
         
         #自訂ACTION(detail_input)
         
         
         BEFORE INPUT
            #add-point:單身輸入前處理 name="input.before_input"
            
            #end add-point
          
                  #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mmbqunit
            #add-point:BEFORE FIELD mmbqunit name="input.b.page1.mmbqunit"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mmbqunit
            
            #add-point:AFTER FIELD mmbqunit name="input.a.page1.mmbqunit"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mmbqunit
            #add-point:ON CHANGE mmbqunit name="input.g.page1.mmbqunit"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mmbqsite
            #add-point:BEFORE FIELD mmbqsite name="input.b.page1.mmbqsite"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mmbqsite
            
            #add-point:AFTER FIELD mmbqsite name="input.a.page1.mmbqsite"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mmbqsite
            #add-point:ON CHANGE mmbqsite name="input.g.page1.mmbqsite"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mmbqdocno
            #add-point:BEFORE FIELD mmbqdocno name="input.b.page1.mmbqdocno"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mmbqdocno
            
            #add-point:AFTER FIELD mmbqdocno name="input.a.page1.mmbqdocno"
            #此段落由子樣板a05產生
            IF  g_mmbq_d[g_detail_idx].mmbqdocno IS NOT NULL AND g_mmbq_d[g_detail_idx].mmbq003 IS NOT NULL AND g_mmbq_d[g_detail_idx].mmbq004 IS NOT NULL THEN 
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_mmbq_d[g_detail_idx].mmbqdocno != g_mmbq_d_t.mmbqdocno OR g_mmbq_d[g_detail_idx].mmbq003 != g_mmbq_d_t.mmbq003 OR g_mmbq_d[g_detail_idx].mmbq004 != g_mmbq_d_t.mmbq004)) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM mmbq_t WHERE "||"mmbqent = '" ||g_enterprise|| "' AND "||"mmbqdocno = '"||g_mmbq_d[g_detail_idx].mmbqdocno ||"' AND "|| "mmbq003 = '"||g_mmbq_d[g_detail_idx].mmbq003 ||"' AND "|| "mmbq004 = '"||g_mmbq_d[g_detail_idx].mmbq004 ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF


            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mmbqdocno
            #add-point:ON CHANGE mmbqdocno name="input.g.page1.mmbqdocno"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mmbq001
            #add-point:BEFORE FIELD mmbq001 name="input.b.page1.mmbq001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mmbq001
            
            #add-point:AFTER FIELD mmbq001 name="input.a.page1.mmbq001"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mmbq001
            #add-point:ON CHANGE mmbq001 name="input.g.page1.mmbq001"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mmbq002
            #add-point:BEFORE FIELD mmbq002 name="input.b.page1.mmbq002"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mmbq002
            
            #add-point:AFTER FIELD mmbq002 name="input.a.page1.mmbq002"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mmbq002
            #add-point:ON CHANGE mmbq002 name="input.g.page1.mmbq002"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mmbq003
            #add-point:BEFORE FIELD mmbq003 name="input.b.page1.mmbq003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mmbq003
            
            #add-point:AFTER FIELD mmbq003 name="input.a.page1.mmbq003"
            #此段落由子樣板a05產生
            IF g_mmbq_d[g_detail_idx].mmbqdocno IS NOT NULL AND g_mmbq_d[g_detail_idx].mmbq003 IS NOT NULL AND g_mmbq_d[g_detail_idx].mmbq004 IS NOT NULL THEN 
               #IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_mmbq_d[g_detail_idx].mmbqdocno != g_mmbq_d_t.mmbqdocno OR g_mmbq_d[g_detail_idx].mmbq003 != g_mmbq_d_t.mmbq003 OR g_mmbq_d[g_detail_idx].mmbq004 != g_mmbq_d_t.mmbq004)) THEN #160824-00008#113 by sakura mark
               IF g_mmbq_d[l_ac].mmbq003 != g_mmbq_d_o.mmbq003 OR cl_null(g_mmbq_d_o.mmbq003) THEN     #160824-00007#113 by sakura add
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM mmbq_t WHERE "||"mmbqent = '" ||g_enterprise|| "' AND "||"mmbqdocno = '"||g_mmbq_d[g_detail_idx].mmbqdocno ||"' AND "|| "mmbq003 = '"||g_mmbq_d[g_detail_idx].mmbq003 ||"' AND "|| "mmbq004 = '"||g_mmbq_d[g_detail_idx].mmbq004 ||"'",'std-00004',0) THEN 
                     LET g_mmbq_d[l_ac].mmbq003 = g_mmbq_d_o.mmbq003  #160824-00007#113 by sakura add
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF
            LET g_mmbq_d_o.* = g_mmbq_d[l_ac].*  #160824-00007#113 by sakura add
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mmbq003
            #add-point:ON CHANGE mmbq003 name="input.g.page1.mmbq003"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mmbq004
            
            #add-point:AFTER FIELD mmbq004 name="input.a.page1.mmbq004"
            #此段落由子樣板a05產生
            LET g_mmbq_d[l_ac].mmbq004_desc = ''
            IF  g_mmbq_d[g_detail_idx].mmbqdocno IS NOT NULL AND g_mmbq_d[g_detail_idx].mmbq003 IS NOT NULL AND g_mmbq_d[g_detail_idx].mmbq004 IS NOT NULL THEN 
               #IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_mmbq_d[g_detail_idx].mmbqdocno != g_mmbq_d_t.mmbqdocno OR g_mmbq_d[g_detail_idx].mmbq003 != g_mmbq_d_t.mmbq003 OR g_mmbq_d[g_detail_idx].mmbq004 != g_mmbq_d_t.mmbq004)) THEN #160824-00008#113 by sakura mark
               IF g_mmbq_d[l_ac].mmbq004 != g_mmbq_d_o.mmbq004 OR cl_null(g_mmbq_d_o.mmbq004) THEN     #160824-00007#113 by sakura add
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM mmbq_t WHERE "||"mmbqent = '" ||g_enterprise|| "' AND "||"mmbqdocno = '"||g_mmbq_d[g_detail_idx].mmbqdocno ||"' AND "|| "mmbq003 = '"||g_mmbq_d[g_detail_idx].mmbq003 ||"' AND "|| "mmbq004 = '"||g_mmbq_d[g_detail_idx].mmbq004 ||"'",'std-00004',0) THEN 
                     LET g_mmbq_d[l_ac].mmbq004 = g_mmbq_d_o.mmbq004 #160824-00007#113 by sakura add
                     NEXT FIELD CURRENT
                  END IF
               END IF
               CALL s_aint800_01_check(g_mmbq_d[l_ac].mmbq003,g_mmbq_d[l_ac].mmbq004,'',g_mmbosite,'') RETURNING l_flag,g_mmbq_d[l_ac].mmbq004_desc    
               IF NOT l_flag THEN
                  #LET g_mmbq_d[l_ac].mmbq004 = g_mmbq_d_t.mmbq004 #160824-00007#113 by sakura mark
                  LET g_mmbq_d[l_ac].mmbq004 = g_mmbq_d_o.mmbq004 #160824-00007#113 by sakura add
                  LET g_mmbq_d[l_ac].mmbq004_desc= ammt350_01_mmbq004_ref(g_mmbq_d[l_ac].mmbq003,g_mmbq_d[l_ac].mmbq004)
                  NEXT FIELD CURRENT
               END IF
            END IF
            LET g_mmbq_d[l_ac].mmbq004_desc= ammt350_01_mmbq004_ref(g_mmbq_d[l_ac].mmbq003,g_mmbq_d[l_ac].mmbq004)
            LET g_mmbq_d_o.* = g_mmbq_d[l_ac].*  #160824-00007#113 by sakura add
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mmbq004
            #add-point:BEFORE FIELD mmbq004 name="input.b.page1.mmbq004"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mmbq004
            #add-point:ON CHANGE mmbq004 name="input.g.page1.mmbq004"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mmbq004_desc
            #add-point:BEFORE FIELD mmbq004_desc name="input.b.page1.mmbq004_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mmbq004_desc
            
            #add-point:AFTER FIELD mmbq004_desc name="input.a.page1.mmbq004_desc"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mmbq004_desc
            #add-point:ON CHANGE mmbq004_desc name="input.g.page1.mmbq004_desc"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mmbqacti
            #add-point:BEFORE FIELD mmbqacti name="input.b.page1.mmbqacti"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mmbqacti
            
            #add-point:AFTER FIELD mmbqacti name="input.a.page1.mmbqacti"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mmbqacti
            #add-point:ON CHANGE mmbqacti name="input.g.page1.mmbqacti"
            
            #END add-point 
 
 
 
                  #Ctrlp:input.c.page1.mmbqunit
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mmbqunit
            #add-point:ON ACTION controlp INFIELD mmbqunit name="input.c.page1.mmbqunit"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.mmbqsite
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mmbqsite
            #add-point:ON ACTION controlp INFIELD mmbqsite name="input.c.page1.mmbqsite"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.mmbqdocno
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mmbqdocno
            #add-point:ON ACTION controlp INFIELD mmbqdocno name="input.c.page1.mmbqdocno"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.mmbq001
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mmbq001
            #add-point:ON ACTION controlp INFIELD mmbq001 name="input.c.page1.mmbq001"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.mmbq002
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mmbq002
            #add-point:ON ACTION controlp INFIELD mmbq002 name="input.c.page1.mmbq002"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.mmbq003
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mmbq003
            #add-point:ON ACTION controlp INFIELD mmbq003 name="input.c.page1.mmbq003"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.mmbq004
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mmbq004
            #add-point:ON ACTION controlp INFIELD mmbq004 name="input.c.page1.mmbq004"
            LET g_qryparam.reqry = FALSE
            CALL s_aint800_01_controlp(g_mmbq_d[l_ac].mmbq003,'',p_mmbosite) RETURNING l_flag    
            LET g_mmbq_d[l_ac].mmbq004 = g_qryparam.return1
            DISPLAY g_qryparam.return1 TO  mmbq004     #顯示到畫面上
            CALL s_aint800_01_show(g_mmbq_d[l_ac].mmbq003,g_mmbq_d[l_ac].mmbq004,'',p_mmbosite,'') RETURNING l_flag,g_mmbq_d[l_ac].mmbq004_desc 
            NEXT FIELD mmbq004                     #返回原欄位
            #END add-point
 
 
         #Ctrlp:input.c.page1.mmbq004_desc
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mmbq004_desc
            #add-point:ON ACTION controlp INFIELD mmbq004_desc name="input.c.page1.mmbq004_desc"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.mmbqacti
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mmbqacti
            #add-point:ON ACTION controlp INFIELD mmbqacti name="input.c.page1.mmbqacti"
            
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
   CLOSE ammt350_01_cl
   END IF
   
   #end add-point
   
   #畫面關閉
   CLOSE WINDOW w_ammt350_01 
   
   #add-point:input段after input name="input.post_input"
   LET INT_FLAG = 0
   #end add-point    
   
END FUNCTION
 
{</section>}
 
{<section id="ammt350_01.other_dialog" readonly="Y" >}

 
{</section>}
 
{<section id="ammt350_01.other_function" readonly="Y" >}
################################################################################
# Descriptions...: 描述说明
# Memo...........:
# Usage..........: CALL ammt350_01_mmbq004_chk(p_mmbq003,p_mmbq004)
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 日期 By 作者
# Modify.........:
################################################################################
PUBLIC FUNCTION ammt350_01_mmbq004_chk(p_mmbq003,p_mmbq004)
DEFINE p_mmbq003  LIKE mmbq_t.mmbq003
DEFINE p_mmbq004  LIKE mmbq_t.mmbq004
DEFINE l_oocqstus LIKE oocq_t.oocqstus
DEFINE l_ooiastus LIKE ooia_t.ooiastus
DEFINE l_imaastus LIKE imaa_t.imaastus
DEFINE l_rtaxstus LIKE rtax_t.rtaxstus
DEFINE l_rtax005  LIKE rtax_t.rtax005
DEFINE l_n        LIKE type_t.num5

    CASE p_mmbq003 
       WHEN  '1'
          #會員等級
           SELECT oocqstus INTO l_oocqstus FROM oocq_t
           WHERE oocqent =  g_enterprise AND oocq001 = '2024' AND oocq002 = p_mmbq004
    
          IF STATUS = 100 OR cl_null(l_oocqstus) THEN
             INITIALIZE g_errparam TO NULL
             LET g_errparam.code = 'amm-00076'
             LET g_errparam.extend = ''
             LET g_errparam.popup = TRUE
             CALL cl_err()

             RETURN FALSE
          ELSE
             IF l_oocqstus = 'N' THEN
                INITIALIZE g_errparam TO NULL
                LET g_errparam.code = 'amm-00077'
                LET g_errparam.extend = ''
                LET g_errparam.popup = TRUE
                CALL cl_err()

                RETURN FALSE
             END IF
          END IF
          RETURN TRUE
       WHEN  '2' 
          #會員類型
          
          SELECT oocqstus INTO l_oocqstus FROM oocq_t
           WHERE oocqent =  g_enterprise AND oocq001 = '2025' AND oocq002 = p_mmbq004
    
          IF STATUS = 100 OR cl_null(l_oocqstus) THEN
             INITIALIZE g_errparam TO NULL
             LET g_errparam.code = 'amm-00074'
             LET g_errparam.extend = ''
             LET g_errparam.popup = TRUE
             CALL cl_err()

             RETURN FALSE
          ELSE
             IF l_oocqstus = 'N' THEN
                INITIALIZE g_errparam TO NULL
                LET g_errparam.code = 'amm-00075'
                LET g_errparam.extend = ''
                LET g_errparam.popup = TRUE
                CALL cl_err()

                RETURN FALSE
             END IF
          END IF
          RETURN TRUE
          
       WHEN  '3'
          #款別類型
          
          SELECT ooiastus INTO l_ooiastus FROM ooia_t WHERE ooiaent = g_enterprise AND ooia001 = p_mmbq004
          IF STATUS = 100 OR cl_null(l_ooiastus) THEN
             INITIALIZE g_errparam TO NULL
             LET g_errparam.code = 'aoo-00195'
             LET g_errparam.extend = ''
             LET g_errparam.popup = TRUE
             CALL cl_err()

             RETURN FALSE
          ELSE
             IF l_ooiastus = 'N' THEN
                INITIALIZE g_errparam TO NULL
                LET g_errparam.code = 'sub-01302'  #160318-00005#23 mod'aoo-00196'
                LET g_errparam.extend = ''
                #160318-00005#23  --add--str
                LET g_errparam.replace[1] ='aooi713'
                LET g_errparam.replace[2] = cl_get_progname('aooi713',g_lang,"2")
                LET g_errparam.exeprog    ='aooi713'
                #160318-00005#23 --add--end
                LET g_errparam.popup = TRUE
                CALL cl_err()

                RETURN FALSE
             END IF
          END IF
          RETURN TRUE
          
       WHEN  '4'
          #商品編號
          SELECT imaastus INTO l_imaastus FROM imaa_t WHERE imaaent = g_enterprise AND imaa001 = p_mmbq004
           IF STATUS = 100 OR cl_null(l_imaastus) THEN
             INITIALIZE g_errparam TO NULL
             LET g_errparam.code = 'art-00016'
             LET g_errparam.extend = ''
             LET g_errparam.popup = TRUE
             CALL cl_err()

             RETURN FALSE
          ELSE
             IF l_imaastus = 'N' THEN
                INITIALIZE g_errparam TO NULL
                LET g_errparam.code = 'sub-01302'  #160318-00005#23 mod'art-00050'
                LET g_errparam.extend = ''
                #160318-00005#23  --add--str
                LET g_errparam.replace[1] ='aimm200'
                LET g_errparam.replace[2] = cl_get_progname('aimm200',g_lang,"2")
                LET g_errparam.exeprog    ='aimm200'
                #160318-00005#23 --add--end
                LET g_errparam.popup = TRUE
                CALL cl_err()

                RETURN FALSE
             END IF
          END IF
          RETURN TRUE
          
       WHEN  '5'
          #商品分類
           SELECT rtaxstus ,rtax005 INTO l_rtaxstus,l_rtax005 FROM rtax_t WHERE rtaxent = g_enterprise AND rtax001 = p_mmbq004
           IF STATUS = 100 OR cl_null(l_rtaxstus) THEN
             INITIALIZE g_errparam TO NULL
             LET g_errparam.code = 'art-00059'
             LET g_errparam.extend = ''
             LET g_errparam.popup = TRUE
             CALL cl_err()

             RETURN FALSE
          ELSE
             IF l_rtaxstus = 'N' THEN
                INITIALIZE g_errparam TO NULL
                LET g_errparam.code = 'art-00048'
                LET g_errparam.extend = ''
                LET g_errparam.popup = TRUE
                CALL cl_err()

                RETURN FALSE
             END IF
             IF l_rtax005 <> 0 THEN
                INITIALIZE g_errparam TO NULL
                LET g_errparam.code = 'art-00003'
                LET g_errparam.extend = ''
                LET g_errparam.popup = TRUE
                CALL cl_err()

                RETURN FALSE
             END IF
          END IF
          RETURN TRUE
          
       WHEN  '6'
          #商品屬性-產地分類
          SELECT oocqstus INTO l_oocqstus FROM oocq_t
           WHERE oocqent =  g_enterprise AND oocq001 = '2000' AND oocq002 = p_mmbq004
    
          IF STATUS = 100 OR cl_null(l_oocqstus) THEN
             INITIALIZE g_errparam TO NULL
             LET g_errparam.code = 'art-00077'
             LET g_errparam.extend = ''
             LET g_errparam.popup = TRUE
             CALL cl_err()

             RETURN FALSE
          ELSE
             IF l_oocqstus = 'N' THEN
                INITIALIZE g_errparam TO NULL
                LET g_errparam.code = 'art-00078'
                LET g_errparam.extend = ''
                LET g_errparam.popup = TRUE
                CALL cl_err()

                RETURN FALSE
             END IF
          END IF
          RETURN TRUE
          
          
       WHEN  '7'
          #商品屬性-價格帶
          SELECT oocqstus INTO l_oocqstus FROM oocq_t
           WHERE oocqent =  g_enterprise AND oocq001 = '2001' AND oocq002 = p_mmbq004
    
          IF STATUS = 100 OR cl_null(l_oocqstus) THEN
             INITIALIZE g_errparam TO NULL
             LET g_errparam.code = 'art-00079'
             LET g_errparam.extend = ''
             LET g_errparam.popup = TRUE
             CALL cl_err()

             RETURN FALSE
          ELSE
             IF l_oocqstus = 'N' THEN
                INITIALIZE g_errparam TO NULL
                LET g_errparam.code = 'art-00080'
                LET g_errparam.extend = ''
                LET g_errparam.popup = TRUE
                CALL cl_err()

                RETURN FALSE
             END IF
          END IF
          RETURN TRUE
          
       WHEN  '8'
          #商品屬性-品牌
          SELECT oocqstus INTO l_oocqstus FROM oocq_t
           WHERE oocqent =  g_enterprise AND oocq001 = '2002' AND oocq002 = p_mmbq004
    
          IF STATUS = 100 OR cl_null(l_oocqstus) THEN
             INITIALIZE g_errparam TO NULL
             LET g_errparam.code = 'art-00081'
             LET g_errparam.extend = ''
             LET g_errparam.popup = TRUE
             CALL cl_err()

             RETURN FALSE
          ELSE
             IF l_oocqstus = 'N' THEN
                INITIALIZE g_errparam TO NULL
                LET g_errparam.code = 'art-00082'
                LET g_errparam.extend = ''
                LET g_errparam.popup = TRUE
                CALL cl_err()

                RETURN FALSE
             END IF
          END IF
          RETURN TRUE
          
       WHEN  '9'
          #商品屬性-系列
           SELECT oocqstus INTO l_oocqstus FROM oocq_t
           WHERE oocqent =  g_enterprise AND oocq001 = '2003' AND oocq002 = p_mmbq004
    
          IF STATUS = 100 OR cl_null(l_oocqstus) THEN
             INITIALIZE g_errparam TO NULL
             LET g_errparam.code = 'art-00083'
             LET g_errparam.extend = ''
             LET g_errparam.popup = TRUE
             CALL cl_err()

             RETURN FALSE
          ELSE
             IF l_oocqstus = 'N' THEN
                INITIALIZE g_errparam TO NULL
                LET g_errparam.code = 'art-00084'
                LET g_errparam.extend = ''
                LET g_errparam.popup = TRUE
                CALL cl_err()

                RETURN FALSE
             END IF
          END IF
          RETURN TRUE
       WHEN  'A'
          #商品屬性-型別
          SELECT oocqstus INTO l_oocqstus FROM oocq_t
           WHERE oocqent =  g_enterprise AND oocq001 = '2004' AND oocq002 = p_mmbq004
    
          IF STATUS = 100 OR cl_null(l_oocqstus) THEN
             INITIALIZE g_errparam TO NULL
             LET g_errparam.code = 'art-00085'
             LET g_errparam.extend = ''
             LET g_errparam.popup = TRUE
             CALL cl_err()

             RETURN FALSE
          ELSE
             IF l_oocqstus = 'N' THEN
                INITIALIZE g_errparam TO NULL
                LET g_errparam.code = 'art-00086'
                LET g_errparam.extend = ''
                LET g_errparam.popup = TRUE
                CALL cl_err()

                RETURN FALSE
             END IF
          END IF
          RETURN TRUE
          
       WHEN  'B'
          #商品屬性-功能
           SELECT oocqstus INTO l_oocqstus FROM oocq_t
           WHERE oocqent =  g_enterprise AND oocq001 = '2005' AND oocq002 = p_mmbq004
    
          IF STATUS = 100 OR cl_null(l_oocqstus) THEN
             INITIALIZE g_errparam TO NULL
             LET g_errparam.code = 'art-00087'
             LET g_errparam.extend = ''
             LET g_errparam.popup = TRUE
             CALL cl_err()

             RETURN FALSE
          ELSE
             IF l_oocqstus = 'N' THEN
                INITIALIZE g_errparam TO NULL
                LET g_errparam.code = 'art-00088'
                LET g_errparam.extend = ''
                LET g_errparam.popup = TRUE
                CALL cl_err()

                RETURN FALSE
             END IF
          END IF
          RETURN TRUE
       WHEN  'C'
          #商品屬性-其它屬性一
           SELECT oocqstus INTO l_oocqstus FROM oocq_t
           WHERE oocqent =  g_enterprise AND oocq001 = '2006' AND oocq002 = p_mmbq004
    
          IF STATUS = 100 OR cl_null(l_oocqstus) THEN
             INITIALIZE g_errparam TO NULL
             LET g_errparam.code = 'art-00089'
             LET g_errparam.extend = ''
             LET g_errparam.popup = TRUE
             CALL cl_err()

             RETURN FALSE
          ELSE
             IF l_oocqstus = 'N' THEN
                INITIALIZE g_errparam TO NULL
                LET g_errparam.code = 'art-00090'
                LET g_errparam.extend = ''
                LET g_errparam.popup = TRUE
                CALL cl_err()

                RETURN FALSE
             END IF
          END IF
          RETURN TRUE
       WHEN  'D'
          #商品屬性-其它屬性二
          SELECT oocqstus INTO l_oocqstus FROM oocq_t
           WHERE oocqent =  g_enterprise AND oocq001 = '2007' AND oocq002 = p_mmbq004
    
          IF STATUS = 100 OR cl_null(l_oocqstus) THEN
             INITIALIZE g_errparam TO NULL
             LET g_errparam.code = 'art-00091'
             LET g_errparam.extend = ''
             LET g_errparam.popup = TRUE
             CALL cl_err()

             RETURN FALSE
          ELSE
             IF l_oocqstus = 'N' THEN
                INITIALIZE g_errparam TO NULL
                LET g_errparam.code = 'art-00092'
                LET g_errparam.extend = ''
                LET g_errparam.popup = TRUE
                CALL cl_err()

                RETURN FALSE
             END IF
          END IF
          RETURN TRUE
       WHEN  'E'
          #商品屬性-其它屬性三
          SELECT oocqstus INTO l_oocqstus FROM oocq_t
           WHERE oocqent =  g_enterprise AND oocq001 = '2008' AND oocq002 = p_mmbq004
    
          IF STATUS = 100 OR cl_null(l_oocqstus) THEN
             INITIALIZE g_errparam TO NULL
             LET g_errparam.code = 'art-00093'
             LET g_errparam.extend = ''
             LET g_errparam.popup = TRUE
             CALL cl_err()

             RETURN FALSE
          ELSE
             IF l_oocqstus = 'N' THEN
                INITIALIZE g_errparam TO NULL
                LET g_errparam.code = 'art-00094'
                LET g_errparam.extend = ''
                LET g_errparam.popup = TRUE
                CALL cl_err()

                RETURN FALSE
             END IF
          END IF
          RETURN TRUE
          
       WHEN  'F'
          #商品屬性-其它屬性四
           SELECT oocqstus INTO l_oocqstus FROM oocq_t
           WHERE oocqent =  g_enterprise AND oocq001 = '2009' AND oocq002 = p_mmbq004
    
          IF STATUS = 100 OR cl_null(l_oocqstus) THEN
             INITIALIZE g_errparam TO NULL
             LET g_errparam.code = 'art-00095'
             LET g_errparam.extend = ''
             LET g_errparam.popup = TRUE
             CALL cl_err()

             RETURN FALSE
          ELSE
             IF l_oocqstus = 'N' THEN
                INITIALIZE g_errparam TO NULL
                LET g_errparam.code = 'art-00096'
                LET g_errparam.extend = ''
                LET g_errparam.popup = TRUE
                CALL cl_err()

                RETURN FALSE
             END IF
          END IF
          RETURN TRUE
          
       WHEN  'G'
          #商品屬性-其它屬性五
          SELECT oocqstus INTO l_oocqstus FROM oocq_t
           WHERE oocqent =  g_enterprise AND oocq001 = '2010' AND oocq002 = p_mmbq004
    
          IF STATUS = 100 OR cl_null(l_oocqstus) THEN
             INITIALIZE g_errparam TO NULL
             LET g_errparam.code = 'art-00097'
             LET g_errparam.extend = ''
             LET g_errparam.popup = TRUE
             CALL cl_err()

             RETURN FALSE
          ELSE
             IF l_oocqstus = 'N' THEN
                INITIALIZE g_errparam TO NULL
                LET g_errparam.code = 'art-00098'
                LET g_errparam.extend = ''
                LET g_errparam.popup = TRUE
                CALL cl_err()

                RETURN FALSE
             END IF
          END IF
          RETURN TRUE
          
       WHEN  'H'
          #商品屬性-其它屬性六
           SELECT oocqstus INTO l_oocqstus FROM oocq_t
           WHERE oocqent =  g_enterprise AND oocq001 = '2011' AND oocq002 = p_mmbq004
    
          IF STATUS = 100 OR cl_null(l_oocqstus) THEN
             INITIALIZE g_errparam TO NULL
             LET g_errparam.code = 'art-00099'
             LET g_errparam.extend = ''
             LET g_errparam.popup = TRUE
             CALL cl_err()

             RETURN FALSE
          ELSE
             IF l_oocqstus = 'N' THEN
                INITIALIZE g_errparam TO NULL
                LET g_errparam.code = 'art-00100'
                LET g_errparam.extend = ''
                LET g_errparam.popup = TRUE
                CALL cl_err()

                RETURN FALSE
             END IF
          END IF
          RETURN TRUE
       WHEN  'I'
          #商品屬性-其它屬性七
          SELECT oocqstus INTO l_oocqstus FROM oocq_t
           WHERE oocqent =  g_enterprise AND oocq001 = '2012' AND oocq002 = p_mmbq004
    
          IF STATUS = 100 OR cl_null(l_oocqstus) THEN
             INITIALIZE g_errparam TO NULL
             LET g_errparam.code = 'art-00101'
             LET g_errparam.extend = ''
             LET g_errparam.popup = TRUE
             CALL cl_err()

             RETURN FALSE
          ELSE
             IF l_oocqstus = 'N' THEN
                INITIALIZE g_errparam TO NULL
                LET g_errparam.code = 'art-00102'
                LET g_errparam.extend = ''
                LET g_errparam.popup = TRUE
                CALL cl_err()

                RETURN FALSE
             END IF
          END IF
          RETURN TRUE
       WHEN  'J'
          #商品屬性-其它屬性八
           SELECT oocqstus INTO l_oocqstus FROM oocq_t
           WHERE oocqent =  g_enterprise AND oocq001 = '2013' AND oocq002 = p_mmbq004
    
          IF STATUS = 100 OR cl_null(l_oocqstus) THEN
             INITIALIZE g_errparam TO NULL
             LET g_errparam.code = 'art-00103'
             LET g_errparam.extend = ''
             LET g_errparam.popup = TRUE
             CALL cl_err()

             RETURN FALSE
          ELSE
             IF l_oocqstus = 'N' THEN
                INITIALIZE g_errparam TO NULL
                LET g_errparam.code = 'art-00104'
                LET g_errparam.extend = ''
                LET g_errparam.popup = TRUE
                CALL cl_err()

                RETURN FALSE
             END IF
          END IF
          RETURN TRUE
       WHEN  'K'
          #商品屬性-其它屬性九
            SELECT oocqstus INTO l_oocqstus FROM oocq_t
           WHERE oocqent =  g_enterprise AND oocq001 = '2014' AND oocq002 = p_mmbq004
    
          IF STATUS = 100 OR cl_null(l_oocqstus) THEN
             INITIALIZE g_errparam TO NULL
             LET g_errparam.code = 'art-00105'
             LET g_errparam.extend = ''
             LET g_errparam.popup = TRUE
             CALL cl_err()

             RETURN FALSE
          ELSE
             IF l_oocqstus = 'N' THEN
                INITIALIZE g_errparam TO NULL
                LET g_errparam.code = 'art-00106'
                LET g_errparam.extend = ''
                LET g_errparam.popup = TRUE
                CALL cl_err()

                RETURN FALSE
             END IF
          END IF
          RETURN TRUE
       WHEN  'L'
          #商品屬性-其它屬性十
          SELECT oocqstus INTO l_oocqstus FROM oocq_t
           WHERE oocqent =  g_enterprise AND oocq001 = '2015' AND oocq002 = p_mmbq004
    
          IF STATUS = 100 OR cl_null(l_oocqstus) THEN
             INITIALIZE g_errparam TO NULL
             LET g_errparam.code = 'art-00107'
             LET g_errparam.extend = ''
             LET g_errparam.popup = TRUE
             CALL cl_err()

             RETURN FALSE
          ELSE
             IF l_oocqstus = 'N' THEN
                INITIALIZE g_errparam TO NULL
                LET g_errparam.code = 'art-00108'
                LET g_errparam.extend = ''
                LET g_errparam.popup = TRUE
                CALL cl_err()

                RETURN FALSE
             END IF
          END IF
          RETURN TRUE
          
       WHEN 'U'
         #庫區類別
         SELECT COUNT(*) INTO l_n FROM gzcb_t WHERE gzcb001 = '6200' AND gzcb002 = p_mmbq004
         IF l_n = 0 THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = 'amm-00114'
            LET g_errparam.extend = ''
            LET g_errparam.popup = TRUE
            CALL cl_err()

            RETURN FALSE
         END IF
         RETURN TRUE
       WHEN 'V' 
         #庫區品類(层级未添加）
          SELECT rtaxstus ,rtax005 INTO l_rtaxstus,l_rtax005 FROM rtax_t WHERE rtaxent = g_enterprise AND rtax001 = p_mmbq004
           IF STATUS = 100 OR cl_null(l_rtaxstus) THEN
             INITIALIZE g_errparam TO NULL
             LET g_errparam.code = 'art-00059'
             LET g_errparam.extend = ''
             LET g_errparam.popup = TRUE
             CALL cl_err()

             RETURN FALSE
          ELSE
             IF l_rtaxstus = 'N' THEN
                INITIALIZE g_errparam TO NULL
                LET g_errparam.code = 'art-00048'
                LET g_errparam.extend = ''
                LET g_errparam.popup = TRUE
                CALL cl_err()

                RETURN FALSE
             END IF
             IF l_rtax005 <> 0 THEN
                INITIALIZE g_errparam TO NULL
                LET g_errparam.code = 'art-00003'
                LET g_errparam.extend = ''
                LET g_errparam.popup = TRUE
                CALL cl_err()

                RETURN FALSE
             END IF
          END IF
          RETURN TRUE
         
      
    END CASE
END FUNCTION
################################################################################
# Descriptions...: 描述说明
# Memo...........:
# Usage..........: CALL ammt350_01_mmbq004_ref(p_mmbq003,p_mmbq004)
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 日期 By 作者
# Modify.........:
################################################################################
PUBLIC FUNCTION ammt350_01_mmbq004_ref(p_mmbq003,p_mmbq004)
DEFINE p_mmbq003     LIKE mmbq_t.mmbq003
DEFINE p_mmbq004     LIKE mmbq_t.mmbq004
DEFINE l_flag        LIKE type_t.num5
DEFINE l_mmbq004_desc LIKE type_t.chr80

    CALL s_aint800_01_show(p_mmbq003,p_mmbq004,'',g_mmbosite,'') RETURNING l_flag,l_mmbq004_desc
    RETURN  l_mmbq004_desc 
END FUNCTION
################################################################################
# Descriptions...: 描述说明
# Memo...........:
# Usage..........: CALL ammt350_01_insert_b(ps_keys)
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 日期 By 作者
# Modify.........:
################################################################################
PUBLIC FUNCTION ammt350_01_insert_b(ps_keys)
DEFINE ps_keys     DYNAMIC ARRAY OF VARCHAR(500)
   
   INSERT INTO mmbq_t
                  (mmbqent, mmbqunit,mmbqsite,mmbq001, mmbqdocno, mmbq002,mmbq003,mmbq004,mmbqacti) 
            VALUES(g_enterprise,g_mmbq_d[g_detail_idx].mmbqunit,g_mmbq_d[g_detail_idx].mmbqsite,g_mmbq_d[g_detail_idx].mmbq001, ps_keys[1],g_mmbq_d[g_detail_idx].mmbq002,ps_keys[2],ps_keys[3],g_mmbq_d[g_detail_idx].mmbqacti)
END FUNCTION
################################################################################
# Descriptions...: 描述说明
# Memo...........:
# Usage..........: CALL ammt350_01_b_fill(p_mmbodocno,p_mmbo008)
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 日期 By 作者
# Modify.........:
################################################################################
PUBLIC FUNCTION ammt350_01_b_fill(p_mmbodocno,p_mmbo008)
DEFINE p_mmbodocno    LIKE mmbo_t.mmbodocno 
DEFINE p_mmbo008    LIKE mmbo_t.mmbo008

    CALL g_mmbq_d.clear()

    LET g_sql = "SELECT  UNIQUE mmbqunit,mmbqsite,mmbqdocno,mmbq001, mmbq002,mmbq003,mmbq004,'',mmbqacti FROM mmbq_t",   
                  
                  " WHERE mmbqent=? AND mmbqdocno=?"
                  
    LET g_sql = g_sql, " ORDER BY mmbq_t.mmbq003,mmbq_t.mmbq004"   


    PREPARE ammt350_01_pb FROM g_sql
      DECLARE b_fill_cs CURSOR FOR ammt350_01_pb
      
      LET g_cnt = l_ac
      LET l_ac = 1
      
      OPEN b_fill_cs USING g_enterprise,p_mmbodocno

                                               
      FOREACH b_fill_cs INTO g_mmbq_d[l_ac].mmbqunit,g_mmbq_d[l_ac].mmbqsite,g_mmbq_d[l_ac].mmbqdocno,g_mmbq_d[l_ac].mmbq001,g_mmbq_d[l_ac].mmbq002,g_mmbq_d[l_ac].mmbq003,g_mmbq_d[l_ac].mmbq004,g_mmbq_d[l_ac].mmbq004_desc,g_mmbq_d[l_ac].mmbqacti
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = SQLCA.sqlcode
            LET g_errparam.extend = "FOREACH:"
            LET g_errparam.popup = TRUE
            CALL cl_err()

            EXIT FOREACH
         END IF
 
         LET g_mmbq_d[l_ac].mmbq004_desc = ammt350_01_mmbq004_ref(p_mmbo008,g_mmbq_d[l_ac].mmbq004)
       
         LET l_ac = l_ac + 1
         IF l_ac > g_max_rec  THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code =  9035
            LET g_errparam.extend =  ''
            LET g_errparam.popup = TRUE
            CALL cl_err()

            EXIT FOREACH
         END IF
         
      END FOREACH

      CALL g_mmbq_d.deleteElement(g_mmbq_d.getLength())  
      LET g_rec_b = g_mmbq_d.getLength()
      DISPLAY g_rec_b TO FORMONLY.cnt
END FUNCTION
################################################################################
# Descriptions...: 描述说明
# Memo...........:
# Usage..........: CALL ammt350_01_lock_b(p_mmbodocno)
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 日期 By 作者
# Modify.........:
################################################################################
PUBLIC FUNCTION ammt350_01_lock_b(p_mmbodocno)
DEFINE p_mmbodocno  LIKE mmbo_t.mmbodocno

     OPEN ammt350_01_bcl USING g_enterprise,
                                       p_mmbodocno,g_mmbq_d[g_detail_idx].mmbq003,g_mmbq_d[g_detail_idx].mmbq004
                                       
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "ammt350_01_bcl"
         LET g_errparam.popup = TRUE
         CALL cl_err()

         RETURN FALSE
      END IF
     RETURN TRUE
END FUNCTION
################################################################################
# Descriptions...: 描述说明
# Memo...........:
# Usage..........: CALL ammt350_01_b_reflesh()
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 日期 By 作者
# Modify.........:
################################################################################
PUBLIC FUNCTION ammt350_01_b_reflesh()
   DISPLAY ARRAY g_mmbq_d TO s_detail1.* ATTRIBUTES(COUNT=g_rec_b)
      BEFORE DISPLAY 
         EXIT DISPLAY
   END DISPLAY
END FUNCTION

 
{</section>}
 
