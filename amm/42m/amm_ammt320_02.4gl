#該程式未解開Section, 採用最新樣板產出!
{<section id="ammt320_02.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0004(2013-11-25 16:40:34), PR版次:0004(2016-11-21 14:25:58)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000125
#+ Filename...: ammt320_02
#+ Description: 會員卡種基本資料申請維護作業-效期延長規則設定
#+ Creator....: 01752(2013-11-20 10:16:46)
#+ Modifier...: 01752 -SD/PR- 02159
 
{</section>}
 
{<section id="ammt320_02.global" >}
#應用 c02b 樣板自動產生(Version:10)
#add-point:填寫註解說明 name="global.memo"
#Memos
#161111-00028#1   2016/11/11 BY 02481   标准程式定义采用宣告模式,弃用.*写法
#160824-00007#110 2016/11/21 By sakura  新舊值備份處理
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
PRIVATE TYPE type_g_mmal_d        RECORD
       mmaldocno LIKE mmal_t.mmaldocno, 
   mmal000 LIKE mmal_t.mmal000, 
   mmal001 LIKE mmal_t.mmal001, 
   mmal002 LIKE mmal_t.mmal002, 
   mmal003 LIKE mmal_t.mmal003, 
   mmal004 LIKE mmal_t.mmal004, 
   mmalacti LIKE mmal_t.mmalacti
       END RECORD
 
 
#add-point:自定義模組變數(Module Variable)(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="global.variable"
DEFINE g_mmal_d_o        type_g_mmal_d  #160824-00007#110
#end add-point
 
DEFINE g_mmal_d          DYNAMIC ARRAY OF type_g_mmal_d
DEFINE g_mmal_d_t        type_g_mmal_d
 
 
DEFINE g_mmaldocno_t   LIKE mmal_t.mmaldocno    #Key值備份
DEFINE g_mmal002_t      LIKE mmal_t.mmal002    #Key值備份
DEFINE g_mmal003_t      LIKE mmal_t.mmal003    #Key值備份
 
 
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
 
{<section id="ammt320_02.input" >}
#+ 資料輸入
PUBLIC FUNCTION ammt320_02(--)
   #add-point:input段變數傳入 name="input.get_var"
   p_mmakdocno,p_mmak000,p_mmak001
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
   DEFINE p_mmakdocno     LIKE mmal_t.mmaldocno
   DEFINE p_mmak000       LIKE mmal_t.mmal000
   DEFINE p_mmak001       LIKE mmal_t.mmal001
 # DEFINE l_mmal          RECORD LIKE mmal_t.*  #161111-00028#1--mark
   #161111-00028#1---add---begin-----------
   DEFINE l_mmal RECORD  #卡效期延長規則申請檔
       mmalent LIKE mmal_t.mmalent, #企業編號
       mmaldocno LIKE mmal_t.mmaldocno, #單據編號
       mmal000 LIKE mmal_t.mmal000, #申請類別
       mmal001 LIKE mmal_t.mmal001, #卡種編碼
       mmal002 LIKE mmal_t.mmal002, #組別
       mmal003 LIKE mmal_t.mmal003, #效期延長
       mmal004 LIKE mmal_t.mmal004, #規則下限
       mmalacti LIKE mmal_t.mmalacti #資料有效碼
       END RECORD
   #161111-00028#1---add-----end------------
   DEFINE l_forupd_sql    STRING
   DEFINE l_lock_sw       LIKE type_t.chr1 
   DEFINE l_stus          LIKE type_t.chr1 
   #end add-point
 
   #畫面開啟 (identifier)
   OPEN WINDOW w_ammt320_02 WITH FORM cl_ap_formpath("amm","ammt320_02")
 
   #瀏覽頁簽資料初始化
   CALL cl_ui_init()
   
   LET g_qryparam.state = "i"
   
   LET l_allow_insert = cl_auth_detail_input("insert")
   LET l_allow_delete = cl_auth_detail_input("delete")
   
   #輸入前處理
   #add-point:單身前置處理 name="input.pre_input"
   WHENEVER ERROR CALL cl_err_msg_log
   CALL ammt320_02_b_fill(p_mmakdocno)   
   CALL cl_set_combo_scc('mmal003','6508')
   
   LET l_stus = ''
   SELECT mmakstus INTO l_stus FROM mmak_t
    WHERE mmakent = g_enterprise
      AND mmakdocno = p_mmakdocno
   IF l_stus != 'N' THEN
      CALL ammt320_02_ui_dialog()
      LET INT_FLAG = FALSE
      CLOSE WINDOW w_ammt320_02 
      RETURN
   END IF
   
   LET l_forupd_sql = " SELECT mmaldocno,mmal000,mmal001,mmal002,mmal003,mmal004,mmalacti ",
                      "   FROM mmal_t ",
                      "  WHERE mmalent = '",g_enterprise,"' ",
                      "    AND mmaldocno = ? AND mmal002 = ? AND mmal003 = ? FOR UPDATE"
   LET l_forupd_sql = cl_sql_forupd(l_forupd_sql)  
   PREPARE ammt320_02_b FROM l_forupd_sql
   DECLARE ammt320_02_cs CURSOR FOR ammt320_02_b 
   LET INT_FLAG = FALSE   
   #end add-point
  
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
   
      #輸入開始
      INPUT ARRAY g_mmal_d FROM s_detail1.*
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
               LET g_mmal_d_t.* = g_mmal_d[l_ac].*  #BACKUP
               LET g_mmal_d_o.* = g_mmal_d[l_ac].*  #BACKUP #160824-00007#110
               OPEN ammt320_02_cs USING p_mmakdocno,g_mmal_d[l_ac].mmal002,g_mmal_d[l_ac].mmal003

               IF SQLCA.sqlcode THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = SQLCA.sqlcode
                  LET g_errparam.extend = "ammt320_02_cs"
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  LET l_lock_sw='Y'
               ELSE
                  FETCH ammt320_02_cs INTO g_mmal_d[l_ac].*
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
            INITIALIZE g_mmal_d_t.* TO NULL
            INITIALIZE g_mmal_d_o.* TO NULL #160824-00007#110
            INITIALIZE g_mmal_d[l_ac].* TO NULL 
            LET g_mmal_d[l_ac].mmaldocno = p_mmakdocno
            LET g_mmal_d[l_ac].mmal000 = p_mmak000
            LET g_mmal_d[l_ac].mmal001 = p_mmak001
            LET g_mmal_d[l_ac].mmalacti = 'Y'
            LET g_mmal_d_t.* = g_mmal_d[l_ac].*     #新輸入資料
            LET g_mmal_d_o.* = g_mmal_d[l_ac].*     #新輸入資料 #160824-00007#110
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

            INITIALIZE l_mmal.* TO NULL
            LET l_mmal.mmalent = g_enterprise        
            LET l_mmal.mmaldocno = g_mmal_d[l_ac].mmaldocno
            LET l_mmal.mmal000 = g_mmal_d[l_ac].mmal000
            LET l_mmal.mmal001 = g_mmal_d[l_ac].mmal001
            LET l_mmal.mmal002 = g_mmal_d[l_ac].mmal002
            LET l_mmal.mmal003 = g_mmal_d[l_ac].mmal003
            LET l_mmal.mmal004 = g_mmal_d[l_ac].mmal004
            LET l_mmal.mmalacti = g_mmal_d[l_ac].mmalacti
         
            SELECT COUNT(*) INTO l_count FROM mmal_t 
             WHERE mmalent   = g_enterprise
               AND mmaldocno = p_mmakdocno
               AND mmal002   = g_mmal_d[l_ac].mmal002
               AND mmal003   = g_mmal_d[l_ac].mmal003
                
            #資料未重複, 插入新增資料
            IF l_count = 0 THEN 
            #  INSERT INTO mmal_t VALUES (l_mmal.*)  #161111-00028#1--mark
               #161111-00028#1---add-----begin----------
               INSERT INTO mmal_t (mmalent,mmaldocno,mmal000,mmal001,mmal002,mmal003,mmal004,mmalacti)
               VALUES (l_mmal.mmalent,l_mmal.mmaldocno,l_mmal.mmal000,l_mmal.mmal001,l_mmal.mmal002,l_mmal.mmal003,l_mmal.mmal004,l_mmal.mmalacti)
                #161111-00028#1---add-----end----------
               IF SQLCA.sqlcode THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = SQLCA.sqlcode
                  LET g_errparam.extend = "mmal_t"
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

               INITIALIZE g_mmal_d[l_ac].* TO NULL
               CALL s_transaction_end('N',0)
               CANCEL INSERT
            END IF
 
            IF SQLCA.SQLcode THEN
               INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = SQLCA.sqlcode
                  LET g_errparam.extend = "mmal_t"
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
            IF NOT cl_null(p_mmakdocno) AND NOT cl_null(g_mmal_d_t.mmal002) AND
               NOT cl_null(g_mmal_d_t.mmal003)THEN

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
               DELETE FROM mmal_t
                WHERE mmalent = g_enterprise 
                  AND mmaldocno = p_mmakdocno
                  AND mmal002 = g_mmal_d_t.mmal002
                  AND mmal003 = g_mmal_d_t.mmal003
 
               IF SQLCA.sqlcode THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = SQLCA.sqlcode
                  LET g_errparam.extend = "mmal_t"
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  CALL s_transaction_end('N',0)
                  CANCEL DELETE   
               ELSE
                  LET g_rec_b = g_rec_b-1
                  CALL s_transaction_end('Y',0)
               END IF 
               CLOSE ammt320_02_cs
            END IF 
            
         ON ROW CHANGE
            IF INT_FLAG THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = 9001
               LET g_errparam.extend = ''
               LET g_errparam.popup = FALSE
               CALL cl_err()

               LET INT_FLAG = 0
               LET g_mmal_d[l_ac].* = g_mmal_d_t.*
               CLOSE ammt320_02_cs
               CALL s_transaction_end('N',0)
               EXIT DIALOG 
            END IF
              
            IF l_lock_sw = 'Y' THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = -263
               LET g_errparam.extend = l_mmal.mmal001
               LET g_errparam.popup = TRUE
               CALL cl_err()

               LET g_mmal_d[l_ac].* = g_mmal_d_t.*
            ELSE
               UPDATE mmal_t SET (mmal002,mmal003,mmal004,mmalacti) = 
                                 (g_mmal_d[l_ac].mmal002,g_mmal_d[l_ac].mmal003,
                                  g_mmal_d[l_ac].mmal004,g_mmal_d[l_ac].mmalacti)
                WHERE mmalent = g_enterprise
                  AND mmaldocno = p_mmakdocno
                  AND mmal002 = g_mmal_d_t.mmal002
                  AND mmal003 = g_mmal_d_t.mmal003
               IF SQLCA.sqlcode THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = SQLCA.sqlcode
                  LET g_errparam.extend = "mmal_t"
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
   
                  LET g_mmal_d[l_ac].* = g_mmal_d_t.*
                  CALL s_transaction_end('N',0)
               ELSE
                  CALL s_transaction_end('Y',0)               
               END IF
            END IF
            
         AFTER ROW
            CLOSE ammt320_02_cs   
            #end add-point
          
                  #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mmaldocno
            #add-point:BEFORE FIELD mmaldocno name="input.b.page1.mmaldocno"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mmaldocno
            
            #add-point:AFTER FIELD mmaldocno name="input.a.page1.mmaldocno"
            #此段落由子樣板a05產生

            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mmaldocno
            #add-point:ON CHANGE mmaldocno name="input.g.page1.mmaldocno"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mmal000
            #add-point:BEFORE FIELD mmal000 name="input.b.page1.mmal000"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mmal000
            
            #add-point:AFTER FIELD mmal000 name="input.a.page1.mmal000"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mmal000
            #add-point:ON CHANGE mmal000 name="input.g.page1.mmal000"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mmal001
            #add-point:BEFORE FIELD mmal001 name="input.b.page1.mmal001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mmal001
            
            #add-point:AFTER FIELD mmal001 name="input.a.page1.mmal001"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mmal001
            #add-point:ON CHANGE mmal001 name="input.g.page1.mmal001"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mmal002
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_mmal_d[l_ac].mmal002,"1.000","1","","","azz-00079",1) THEN
               NEXT FIELD mmal002
            END IF 
 
 
 
            #add-point:AFTER FIELD mmal002 name="input.a.page1.mmal002"
            #此段落由子樣板a05產生
            IF NOT cl_null(g_mmal_d[l_ac].mmal002) AND NOT cl_null(g_mmal_d[l_ac].mmal003) THEN 
               #IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_mmal_d[l_ac].mmal002 != g_mmal_d_t.mmal002 OR g_mmal_d_t.mmal002 IS NULL)) THEN #160824-00008#110 by sakura mark
               IF g_mmal_d[l_ac].mmal002 != g_mmal_d_o.mmal002 OR cl_null(g_mmal_d_o.mmal002) THEN #160824-00007#110 by sakura add
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM mmal_t WHERE "||"mmalent = '" ||g_enterprise|| "' AND "||"mmaldocno = '"||g_mmal_d[l_ac].mmaldocno ||"' AND "|| "mmal002 = '"||g_mmal_d[l_ac].mmal002 ||"' AND "|| "mmal003 = '"||g_mmal_d[l_ac].mmal003 ||"'",'std-00004',0) THEN 
                     #LET g_mmal_d[l_ac].mmal002 = g_mmal_d_t.mmal002 #160824-00007#110 by sakura mark
                     LET g_mmal_d[l_ac].mmal002 = g_mmal_d_o.mmal002  #160824-00007#110 by sakura mark
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF
            LET g_mmal_d_o.* = g_mmal_d[l_ac].*  #160824-00007#110 by sakura add
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mmal002
            #add-point:BEFORE FIELD mmal002 name="input.b.page1.mmal002"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mmal002
            #add-point:ON CHANGE mmal002 name="input.g.page1.mmal002"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mmal003
            #add-point:BEFORE FIELD mmal003 name="input.b.page1.mmal003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mmal003
            
            #add-point:AFTER FIELD mmal003 name="input.a.page1.mmal003"
            #此段落由子樣板a05產生
            IF NOT cl_null(g_mmal_d[l_ac].mmal002) AND NOT cl_null(g_mmal_d[l_ac].mmal003) THEN 
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_mmal_d[l_ac].mmal003 != g_mmal_d_t.mmal003 OR g_mmal_d_t.mmal003 IS NULL)) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM mmal_t WHERE "||"mmalent = '" ||g_enterprise|| "' AND "||"mmaldocno = '"||g_mmal_d[l_ac].mmaldocno ||"' AND "|| "mmal002 = '"||g_mmal_d[l_ac].mmal002 ||"' AND "|| "mmal003 = '"||g_mmal_d[l_ac].mmal003 ||"'",'std-00004',0) THEN 
                     LET g_mmal_d[l_ac].mmal003 = g_mmal_d_t.mmal003
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mmal003
            #add-point:ON CHANGE mmal003 name="input.g.page1.mmal003"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mmal004
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_mmal_d[l_ac].mmal004,"0.000","1","","","azz-00079",1) THEN
               NEXT FIELD mmal004
            END IF 
 
 
 
            #add-point:AFTER FIELD mmal004 name="input.a.page1.mmal004"
 
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mmal004
            #add-point:BEFORE FIELD mmal004 name="input.b.page1.mmal004"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mmal004
            #add-point:ON CHANGE mmal004 name="input.g.page1.mmal004"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mmalacti
            #add-point:BEFORE FIELD mmalacti name="input.b.page1.mmalacti"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mmalacti
            
            #add-point:AFTER FIELD mmalacti name="input.a.page1.mmalacti"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mmalacti
            #add-point:ON CHANGE mmalacti name="input.g.page1.mmalacti"
            
            #END add-point 
 
 
 
                  #Ctrlp:input.c.page1.mmaldocno
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mmaldocno
            #add-point:ON ACTION controlp INFIELD mmaldocno name="input.c.page1.mmaldocno"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.mmal000
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mmal000
            #add-point:ON ACTION controlp INFIELD mmal000 name="input.c.page1.mmal000"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.mmal001
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mmal001
            #add-point:ON ACTION controlp INFIELD mmal001 name="input.c.page1.mmal001"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.mmal002
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mmal002
            #add-point:ON ACTION controlp INFIELD mmal002 name="input.c.page1.mmal002"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.mmal003
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mmal003
            #add-point:ON ACTION controlp INFIELD mmal003 name="input.c.page1.mmal003"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.mmal004
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mmal004
            #add-point:ON ACTION controlp INFIELD mmal004 name="input.c.page1.mmal004"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.mmalacti
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mmalacti
            #add-point:ON ACTION controlp INFIELD mmalacti name="input.c.page1.mmalacti"
            
            #END add-point
 
 
 
 
         #自訂ACTION
         #add-point:單身其他段落處理(EX:on row change, etc...) name="input.other"
         
         #end add-point
 
         AFTER INPUT
            #add-point:單身輸入後處理 name="input.after_input"
            CLOSE ammt320_02_cs
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
   CLOSE WINDOW w_ammt320_02 
   
   #add-point:input段after input name="input.post_input"
   LET INT_FLAG = FALSE
   CLOSE ammt320_02_cs
   CALL s_transaction_end('Y',0)
   #end add-point    
   
END FUNCTION
 
{</section>}
 
{<section id="ammt320_02.other_dialog" readonly="Y" >}

 
{</section>}
 
{<section id="ammt320_02.other_function" readonly="Y" >}

PRIVATE FUNCTION ammt320_02_b_fill(p_mmakdocno)
   DEFINE p_mmakdocno     LIKE mmak_t.mmakdocno
   DEFINE l_sql           STRING
   DEFINE l_ac_t          LIKE type_t.num5

   LET l_sql = " SELECT mmaldocno,mmal000,mmal001,mmal002,mmal003,mmal004,mmalacti ",
               "   FROM mmal_t ",
               "  WHERE mmalent   = ",g_enterprise,
               "    AND mmaldocno = '",p_mmakdocno,"' ",
               "  ORDER BY mmal002,mmal003 " 
   PREPARE ammt320_02_pb FROM l_sql
   DECLARE b_fill_curs CURSOR FOR ammt320_02_pb 
   
   CALL g_mmal_d.clear()
   LET l_ac_t = l_ac
   LET l_ac = 1
   FOREACH b_fill_curs INTO g_mmal_d[l_ac].*
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
   CALL g_mmal_d.deleteElement(g_mmal_d.getLength())   
   LET g_rec_b = l_ac - 1
   DISPLAY g_rec_b TO FORMONLY.cnt
   LET l_ac = l_ac_t
   CLOSE b_fill_curs
   FREE ammt320_02_pb
END FUNCTION

PRIVATE FUNCTION ammt320_02_ui_dialog()
   DISPLAY ARRAY g_mmal_d TO s_detail1.* ATTRIBUTE(COUNT=g_rec_b)
END FUNCTION

 
{</section>}
 
