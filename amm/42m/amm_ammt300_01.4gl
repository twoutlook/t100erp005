#該程式未解開Section, 採用最新樣板產出!
{<section id="ammt300_01.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0001(2013-08-16 00:00:00), PR版次:0001(2014-01-15 10:34:30)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000217
#+ Filename...: ammt300_01
#+ Description: 會員地址快速輸入
#+ Creator....: 01258(2013-08-16 10:41:15)
#+ Modifier...: 02296 -SD/PR- 02296
 
{</section>}
 
{<section id="ammt300_01.global" >}
#應用 c01b 樣板自動產生(Version:10)
#add-point:填寫註解說明 name="global.memo"
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
 
#add-point:增加匯入變數檔 name="global.inc" name="global.inc"

#end add-point
 
#單頭 type 宣告
PRIVATE type type_g_oocn_m        RECORD
       oocn001 LIKE type_t.chr500, 
   oocn003 LIKE type_t.chr500, 
   oocn004 LIKE type_t.chr500, 
   oocn005 LIKE type_t.chr500, 
   oocn006 LIKE type_t.chr500, 
   oocn002 LIKE type_t.chr500, 
   oocn007 LIKE type_t.chr500
       END RECORD
	   
#add-point:自定義模組變數(Module Variable)(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="global.variable"
DEFINE  g_oocn002            LIKE oocn_t.oocn002
DEFINE  g_oocn011            LIKE mmaa_t.mmaa011
DEFINE  g_oocn_m_t           type_g_oocn_m 
DEFINE  g_type               LIKE type_t.num5          #標記是否確定
DEFINE  l_oocn002            LIKE type_t.chr80
DEFINE  l_sql                STRING
DEFINE  l_oocn006            LIKE type_t.chr80
#end add-point
 
DEFINE g_oocn_m        type_g_oocn_m
 
   
 
DEFINE g_ref_fields          DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
DEFINE g_rtn_fields          DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
 
#add-point:自定義客戶專用模組變數(Module Variable) name="global.variable_customerization"

#end add-point
 
#add-point:傳入參數說明(global.argv) name="global.argv"

#end add-point
 
{</section>}
 
{<section id="ammt300_01.input" >}
#+ 資料輸入
PUBLIC FUNCTION ammt300_01(--)
   #add-point:input段變數傳入 name="input.get_var"
   p_mmaadocno,p_mmaaent,p_sign 
   #end add-point
   )
   #add-point:input段define name="input.define_customerization"
   
   #end add-point
   DEFINE l_ac_t          LIKE type_t.num10       #未取消的ARRAY CNT 
   DEFINE l_allow_insert  LIKE type_t.num5        #可新增否 
   DEFINE l_allow_delete  LIKE type_t.num5        #可刪除否  
   DEFINE l_count         LIKE type_t.num10
   DEFINE l_insert        LIKE type_t.num5
   DEFINE p_cmd           LIKE type_t.chr5
   #add-point:input段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="input.define"
   DEFINE p_mmaadocno     LIKE mmay_t.mmaydocno
   DEFINE p_mmaaent       LIKE mmay_t.mmayent
   DEFINE r_errno         LIKE type_t.chr20
   DEFINE  p_sign         LIKE type_t.chr1
   #end add-point
   
   #畫面開啟 (identifier)
   OPEN WINDOW w_ammt300_01 WITH FORM cl_ap_formpath("amm","ammt300_01")
 
   #瀏覽頁簽資料初始化
   CALL cl_ui_init()
   
   LET g_qryparam.state = "i"
   LET p_cmd = 'a'
   
   #輸入前處理
   #add-point:單頭前置處理 name="input.pre_input"
   CALL ammt300_01_display_init()
   INITIALIZE g_oocn_m.* TO NULL
   LET r_errno = null
   #end add-point
  
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
   
      #輸入開始
      INPUT BY NAME g_oocn_m.oocn001,g_oocn_m.oocn003,g_oocn_m.oocn004,g_oocn_m.oocn005,g_oocn_m.oocn006, 
          g_oocn_m.oocn002,g_oocn_m.oocn007 ATTRIBUTE(WITHOUT DEFAULTS)
         
         #自訂ACTION
         #add-point:單頭前置處理 name="input.action"
         
         #end add-point
         
         #自訂ACTION(master_input)
         
         
         BEFORE INPUT
            #add-point:單頭輸入前處理 name="input.before_input"
            
            LET g_oocn_m.oocn001 = g_chkparam.return1
            DISPLAY BY NAME g_oocn_m.oocn001
            #end add-point
          
                  #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD oocn001
            #add-point:BEFORE FIELD oocn001 name="input.b.oocn001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD oocn001
            
            #add-point:AFTER FIELD oocn001 name="input.a.oocn001"
            #此段落由子樣板a05產生
            
            IF cl_null(g_oocn_m.oocn001) THEN
               INITIALIZE g_oocn_m.* TO null
            END IF
            IF p_cmd = 'a'  THEN 
               LET g_oocn_m.oocn003 = NULL
               LET g_oocn_m.oocn004 = NULL
               LET g_oocn_m.oocn005 = NULL
               LET g_oocn_m.oocn006 = NULL
               LET g_oocn_m.oocn002 = NULL
               CALL ammt300_01_display_oocn003()
               CALL ammt300_01_display_oocn004()
               CALL ammt300_01_display_oocn005()
               CALL ammt300_01_display_oocn006()
               CALL ammt300_01_display_oocn002()
                              
            END IF
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE oocn001
            #add-point:ON CHANGE oocn001 name="input.g.oocn001"
            IF p_cmd = 'a'  THEN 
               LET g_oocn_m.oocn003 = NULL
               LET g_oocn_m.oocn004 = NULL
               LET g_oocn_m.oocn005 = NULL
               LET g_oocn_m.oocn006 = NULL
               LET g_oocn_m.oocn002 = NULL
               CALL ammt300_01_display_oocn003()
               CALL ammt300_01_display_oocn004()
               CALL ammt300_01_display_oocn005()
               CALL ammt300_01_display_oocn006()
               CALL ammt300_01_display_oocn002()
                              
            END IF
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD oocn003
            #add-point:BEFORE FIELD oocn003 name="input.b.oocn003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD oocn003
            
            #add-point:AFTER FIELD oocn003 name="input.a.oocn003"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE oocn003
            #add-point:ON CHANGE oocn003 name="input.g.oocn003"
            IF p_cmd = 'a'  THEN 
               LET g_oocn_m.oocn004 = NULL
               LET g_oocn_m.oocn005 = NULL
               LET g_oocn_m.oocn006 = NULL
               LET g_oocn_m.oocn002 = NULL
               CALL ammt300_01_display_oocn004()
               CALL ammt300_01_display_oocn005()
               CALL ammt300_01_display_oocn006()
               CALL ammt300_01_display_oocn002()
                              
            END IF
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD oocn004
            #add-point:BEFORE FIELD oocn004 name="input.b.oocn004"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD oocn004
            
            #add-point:AFTER FIELD oocn004 name="input.a.oocn004"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE oocn004
            #add-point:ON CHANGE oocn004 name="input.g.oocn004"
            IF p_cmd = 'a'  THEN 
               LET g_oocn_m.oocn005 = NULL
               LET g_oocn_m.oocn006 = NULL
               LET g_oocn_m.oocn002 = NULL
               CALL ammt300_01_display_oocn005()
               CALL ammt300_01_display_oocn006() 
               CALL ammt300_01_display_oocn002()
                             
            END IF
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD oocn005
            #add-point:BEFORE FIELD oocn005 name="input.b.oocn005"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD oocn005
            
            #add-point:AFTER FIELD oocn005 name="input.a.oocn005"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE oocn005
            #add-point:ON CHANGE oocn005 name="input.g.oocn005"
            IF p_cmd = 'a'  THEN
               LET g_oocn_m.oocn006 = NULL
               LET g_oocn_m.oocn002 = NULL
               CALL ammt300_01_display_oocn006()
               CALL ammt300_01_display_oocn002()
                              
            END IF
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD oocn006
            #add-point:BEFORE FIELD oocn006 name="input.b.oocn006"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD oocn006
            
            #add-point:AFTER FIELD oocn006 name="input.a.oocn006"
            
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE oocn006
            #add-point:ON CHANGE oocn006 name="input.g.oocn006"
            IF p_cmd = 'a'  THEN
               CALL ammt300_01_display_oocn002()               
            END IF
 
            LET l_sql=" SELECT oocn002  FROM oocn_t WHERE oocnent = '",g_enterprise,"' AND rownum = 1 "
            IF NOT cl_null(g_oocn_m.oocn001)  THEN
               LET l_sql = l_sql clipped," AND oocn001='",g_oocn_m.oocn001,"' "
            END IF
            IF NOT cl_null(g_oocn_m.oocn003)  THEN
               LET l_sql = l_sql clipped," AND oocn003='",g_oocn_m.oocn003,"' "
            END IF
            IF NOT cl_null(g_oocn_m.oocn004)  THEN
               LET l_sql = l_sql clipped," AND oocn004='",g_oocn_m.oocn004,"' "
            END IF
            IF NOT cl_null(g_oocn_m.oocn005)  THEN
               LET l_sql = l_sql clipped," AND oocn005='",g_oocn_m.oocn005,"' "
            END IF
            IF NOT cl_null(g_oocn_m.oocn006)  THEN
               LET l_sql = l_sql clipped," AND oocn006='",g_oocn_m.oocn006,"' "
            END IF
            PREPARE l_sql_oocn_oocn002 FROM l_sql
            EXECUTE l_sql_oocn_oocn002 INTO l_oocn002
            LET  g_oocn_m.oocn002 = l_oocn002
            DISPLAY BY NAME g_oocn_m.oocn002
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD oocn002
            #add-point:BEFORE FIELD oocn002 name="input.b.oocn002"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD oocn002
            
            #add-point:AFTER FIELD oocn002 name="input.a.oocn002"
            #此段落由子樣板a05產生
            



            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE oocn002
            #add-point:ON CHANGE oocn002 name="input.g.oocn002"
            IF p_cmd = 'a'  THEN
               CALL ammt300_01_display_oocn006()               
            END IF
            LET l_sql=" SELECT oocn006  FROM oocn_t WHERE oocnent = '",g_enterprise,"' AND rownum = 1 "
            IF NOT cl_null(g_oocn_m.oocn001)  THEN
               LET l_sql = l_sql clipped," AND oocn001='",g_oocn_m.oocn001,"' "
            END IF
            IF NOT cl_null(g_oocn_m.oocn003)  THEN
               LET l_sql = l_sql clipped," AND oocn003='",g_oocn_m.oocn003,"' "
            END IF
            IF NOT cl_null(g_oocn_m.oocn004)  THEN
               LET l_sql = l_sql clipped," AND oocn004='",g_oocn_m.oocn004,"' "
            END IF
            IF NOT cl_null(g_oocn_m.oocn005)  THEN
               LET l_sql = l_sql clipped," AND oocn005='",g_oocn_m.oocn005,"' "
            END IF
            IF NOT cl_null(g_oocn_m.oocn002)  THEN
               LET l_sql = l_sql clipped," AND oocn002='",g_oocn_m.oocn002,"' "
            END IF
            
            PREPARE l_sql_oocn_oocn006 FROM l_sql
            EXECUTE l_sql_oocn_oocn006 INTO l_oocn006
            LET  g_oocn_m.oocn006 = l_oocn006
            DISPLAY BY NAME g_oocn_m.oocn006
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD oocn007
            #add-point:BEFORE FIELD oocn007 name="input.b.oocn007"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD oocn007
            
            #add-point:AFTER FIELD oocn007 name="input.a.oocn007"
            #此段落由子樣板a05產生
            

            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE oocn007
            #add-point:ON CHANGE oocn007 name="input.g.oocn007"
            
            #END add-point 
 
 
 #欄位檢查
                  #Ctrlp:input.c.oocn001
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD oocn001
            #add-point:ON ACTION controlp INFIELD oocn001 name="input.c.oocn001"
            
            #END add-point
 
 
         #Ctrlp:input.c.oocn003
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD oocn003
            #add-point:ON ACTION controlp INFIELD oocn003 name="input.c.oocn003"
            
            #END add-point
 
 
         #Ctrlp:input.c.oocn004
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD oocn004
            #add-point:ON ACTION controlp INFIELD oocn004 name="input.c.oocn004"
            
            #END add-point
 
 
         #Ctrlp:input.c.oocn005
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD oocn005
            #add-point:ON ACTION controlp INFIELD oocn005 name="input.c.oocn005"
            
            #END add-point
 
 
         #Ctrlp:input.c.oocn006
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD oocn006
            #add-point:ON ACTION controlp INFIELD oocn006 name="input.c.oocn006"
            
            #END add-point
 
 
         #Ctrlp:input.c.oocn002
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD oocn002
            #add-point:ON ACTION controlp INFIELD oocn002 name="input.c.oocn002"
            
            #END add-point
 
 
         #Ctrlp:input.c.oocn007
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD oocn007
            #add-point:ON ACTION controlp INFIELD oocn007 name="input.c.oocn007"
            
            #END add-point
 
 
 #欄位開窗
 
         AFTER INPUT
            #add-point:單頭輸入後處理 name="input.after_input"
            CALL ammt300_01_cat()
            IF (p_sign<>'u' OR p_sign<>'a') THEN
            UPDATE mmaa_t SET mmaa010 = g_oocn002,
                              mmaa011 = g_oocn011
             WHERE mmaadocno = p_mmaadocno
               AND mmaaent = p_mmaaent 
            IF SQLCA.sqlcode THEN
               LET r_errno = "SQLCA.sqlcode"
               RETURN r_errno,g_oocn002,g_oocn011
            END IF 
            END IF            
            #end add-point
            
      END INPUT
    
      #add-point:自定義input name="input.more_input"
      
      #end add-point
    
      #公用action
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
 
   #add-point:畫面關閉前 name="input.before_close"
   
   #end add-point
   
   #畫面關閉
   CLOSE WINDOW w_ammt300_01 
   
   #add-point:input段after input name="input.post_input"
   RETURN r_errno,g_oocn002,g_oocn011
   #end add-point    
   
END FUNCTION
 
{</section>}
 
{<section id="ammt300_01.other_dialog" readonly="Y" >}

 
{</section>}
 
{<section id="ammt300_01.other_function" readonly="Y" >}
#+
PRIVATE FUNCTION ammt300_01_display_oocn002()
   DEFINE l_oocn002      LIKE oocn_t.oocn002
   DEFINE l_str_oocn002  LIKE type_t.chr100
   DEFINE l_cnt          LIKE type_t.num5
   DEFINE l_sql          STRING 
   DEFINE cb002             ui.ComboBox
   
   LET cb002 = ui.ComboBox.forName("oocn002")
   CALL cb002.clear()
   LET l_sql = "SELECT DISTINCT oocn002 FROM oocn_t ",
               "  WHERE oocnstus='Y' AND oocnent=",g_enterprise
   
   IF NOT cl_null( g_oocn_m.oocn001) THEN
      LET l_sql = l_sql clipped," AND oocn001='",g_oocn_m.oocn001,"' "
   END IF
   IF NOT cl_null( g_oocn_m.oocn003) THEN
      LET l_sql = l_sql clipped," AND oocn003='",g_oocn_m.oocn003,"' "
   END IF
   IF NOT cl_null( g_oocn_m.oocn004) THEN
      LET l_sql = l_sql clipped," AND oocn004='",g_oocn_m.oocn004,"' "
   END IF
   IF NOT cl_null( g_oocn_m.oocn005) THEN
      LET l_sql = l_sql clipped," AND oocn005='",g_oocn_m.oocn005,"' "
   END IF
   IF NOT cl_null( g_oocn_m.oocn006) THEN
      LET l_sql = l_sql clipped," AND oocn006='",g_oocn_m.oocn006,"' "
   END IF   
   PREPARE l_sql_pre6 FROM l_sql
   DECLARE l_sql_cs6 CURSOR FOR l_sql_pre6
   LET l_cnt = 1
   FOREACH  l_sql_cs6 INTO l_oocn002
      CALL cb002.addItem(l_oocn002,l_oocn002)
      LET l_cnt = l_cnt+1
   END FOREACH
END FUNCTION
#+
PRIVATE FUNCTION ammt300_01_display_oocn003()
   DEFINE l_ooci002      LIKE ooci_t.ooci002
   DEFINE l_str_oocn003  LIKE type_t.chr100
   DEFINE l_cnt          LIKE type_t.num5
   DEFINE l_sql          STRING
   DEFINE cb003          ui.ComboBox
   
   LET cb003 = ui.ComboBox.forName("oocn003")   
   CALL cb003.clear()
   LET l_sql = "SELECT DISTINCT ooci002,oocil004 FROM ooci_t  LEFT JOIN oocil_t ON ooci001=oocil001 AND oocient=oocilent AND ooci002 = oocil002 ",
               "    AND oocil003='",g_dlang,"' ",
               "  WHERE oocistus='Y' AND oocient=",g_enterprise
               
   IF NOT cl_null( g_oocn_m.oocn001) THEN
      LET l_sql = l_sql clipped," AND ooci001='",g_oocn_m.oocn001,"' "
   END IF
   PREPARE l_sql_pre2 FROM l_sql
   DECLARE l_sql_cs2 CURSOR FOR l_sql_pre2
   LET l_cnt = 1
   FOREACH  l_sql_cs2 INTO l_ooci002,l_str_oocn003
      IF cl_null(l_str_oocn003) THEN
         CALL cb003.addItem(l_ooci002,l_ooci002) 
      ELSE          
         CALL cb003.addItem(l_ooci002,l_str_oocn003)
      END IF   
      LET l_cnt = l_cnt+1
   END FOREACH
END FUNCTION
#+ 拼接地址
PRIVATE FUNCTION ammt300_01_cat()
   DEFINE l_oocgl003      LIKE oocgl_t.oocgl003
   DEFINE l_oocil004      LIKE oocil_t.oocil004
   DEFINE l_oockl005      LIKE oockl_t.oockl005
   DEFINE l_oocml006      LIKE oocml_t.oocml006 
   DEFINE l_oocn007       STRING
   DEFINE l_sql           STRING
   
   LET l_sql = " SELECT COALESCE(oockl005,oockl003) FROM oockl_t,oock_t ",
               "  WHERE oocklent='",g_enterprise,"' ",
               "    AND oock001=oockl001 AND oock002=oockl002 AND oock003=oockl003 ",
               "    AND oockstus='Y' AND oockl004='",g_dlang,"' "
   IF NOT cl_null(g_oocn_m.oocn001)  THEN
      LET l_sql = l_sql clipped," AND oockl001='",g_oocn_m.oocn001,"' "
   END IF 
   IF NOT cl_null(g_oocn_m.oocn003)  THEN
      LET l_sql = l_sql clipped," AND oockl002='",g_oocn_m.oocn003,"' "
   END IF   
   IF NOT cl_null(g_oocn_m.oocn004)  THEN
      LET l_sql = l_sql clipped," AND oockl003='",g_oocn_m.oocn004,"' "
   END IF
   PREPARE l_sql_oockl FROM l_sql
   EXECUTE l_sql_oockl INTO l_oockl005
      
   LET l_sql=" SELECT COALESCE(oocil004,oocil002) FROM oocil_t WHERE oocil003 = '",g_dlang,"'  AND oocilent = '",g_enterprise,"' "
   IF NOT cl_null(g_oocn_m.oocn001)  THEN
      LET l_sql = l_sql clipped," AND oocil001='",g_oocn_m.oocn001,"' "
   END IF
   IF NOT cl_null(g_oocn_m.oocn003)  THEN
      LET l_sql = l_sql clipped," AND oocil002='",g_oocn_m.oocn003,"' "
   END IF
   PREPARE l_sql_oocil FROM l_sql
   EXECUTE l_sql_oocil INTO l_oocil004

      
   LET l_sql=" SELECT COALESCE(oocml006,oocml004)  FROM oocml_t  WHERE oocml005 = '",g_dlang,"' AND oocmlent = '",g_enterprise,"' "
   IF NOT cl_null(g_oocn_m.oocn001)  THEN
      LET l_sql = l_sql clipped," AND oocml001='",g_oocn_m.oocn001,"' "
   END IF
   IF NOT cl_null(g_oocn_m.oocn003)  THEN
      LET l_sql = l_sql clipped," AND oocml002='",g_oocn_m.oocn003,"' "
   END IF
   IF NOT cl_null(g_oocn_m.oocn004)  THEN
      LET l_sql = l_sql clipped," AND oocml003='",g_oocn_m.oocn004,"' "
   END IF
   IF NOT cl_null(g_oocn_m.oocn005)  THEN
      LET l_sql = l_sql clipped," AND oocml004='",g_oocn_m.oocn005,"' "
   END IF
   PREPARE l_sql_oocml FROM l_sql
   EXECUTE l_sql_oocml INTO l_oocml006
   
   LET l_sql=" SELECT COALESCE(oocgl003,oocgl001) FROM oocgl_t WHERE oocgl002 = '",g_dlang,"' AND oocglent = '",g_enterprise,"' "
   IF NOT cl_null(g_oocn_m.oocn001)  THEN
      LET l_sql = l_sql clipped," AND oocgl001='",g_oocn_m.oocn001,"' "
   END IF 
   PREPARE l_sql_oocgl FROM l_sql
   EXECUTE l_sql_oocgl INTO l_oocgl003 

   IF cl_null(l_oockl005) THEN LET l_oockl005 = g_oocn_m.oocn004 END IF
   IF cl_null(l_oocil004) THEN LET l_oocil004 = g_oocn_m.oocn003 END IF
   IF cl_null(l_oocml006) THEN LET l_oocml006 = g_oocn_m.oocn005 END IF
   IF cl_null(l_oocgl003) THEN LET l_oocgl003 = g_oocn_m.oocn001 END IF
   LET g_oocn002 = g_oocn_m.oocn002
   LET g_oocn011 = l_oocgl003 CLIPPED,l_oocil004 CLIPPED,l_oockl005 CLIPPED,l_oocml006 CLIPPED,g_oocn_m.oocn006 CLIPPED,g_oocn_m.oocn007 CLIPPED
   
END FUNCTION
#+init
PRIVATE FUNCTION ammt300_01_display_init()
   DEFINE l_oocg001      LIKE oocg_t.oocg001
   DEFINE l_str_oocn001  LIKE type_t.chr100
   DEFINE l_cnt          LIKE type_t.num5
   DEFINE l_sql          STRING
   DEFINE cb001             ui.ComboBox
   
   
   LET cb001 = ui.ComboBox.forName("oocn001")
   CALL cb001.clear()
   LET l_sql = "SELECT DISTINCT oocg001,oocgl003 FROM oocg_t LEFT JOIN oocgl_t ON oocg001=oocgl001 AND oocgent=oocglent ",
               "    AND oocgl002='",g_dlang,"' ",
               "  WHERE oocgstus='Y' AND oocgent=",g_enterprise 
   PREPARE l_sql_pre FROM l_sql
   DECLARE l_sql_cs CURSOR FOR l_sql_pre
   LET l_cnt = 1
   FOREACH  l_sql_cs INTO l_oocg001,l_str_oocn001 
      IF NOT cl_null(l_str_oocn001) THEN
         CALL cb001.addItem(l_oocg001,l_str_oocn001)
      ELSE
         CALL cb001.addItem(l_oocg001,l_oocg001)
      END IF      
      LET l_cnt = l_cnt+1
   END FOREACH      
      
END FUNCTION
#+
PRIVATE FUNCTION ammt300_01_display_oocn004()
   DEFINE l_oock003      LIKE oock_t.oock003
   DEFINE l_str_oocn004  LIKE type_t.chr100
   DEFINE l_cnt          LIKE type_t.num5
   DEFINE l_sql          STRING
   DEFINE cb004          ui.ComboBox
   
   LET cb004 = ui.ComboBox.forName("oocn004")   
   CALL cb004.clear()
   LET l_sql = "SELECT DISTINCT oock003,oockl005 FROM oock_t LEFT JOIN oockl_t ON oock001=oockl001 AND oockent=oocklent AND oock002 = oockl002 AND oock003 = oockl003 ",
               "    AND oockl004='",g_dlang,"' ",
               "  WHERE  oockstus='Y' AND oockent=",g_enterprise
               
   IF NOT cl_null( g_oocn_m.oocn001) THEN
      LET l_sql = l_sql clipped," AND oock001='",g_oocn_m.oocn001,"' "
   END IF
   IF NOT cl_null( g_oocn_m.oocn003) THEN
      LET l_sql = l_sql clipped," AND oock002='",g_oocn_m.oocn003,"' "
   END IF
   PREPARE l_sql_pre3 FROM l_sql
   DECLARE l_sql_cs3 CURSOR FOR l_sql_pre3
   LET l_cnt = 1
   FOREACH  l_sql_cs3 INTO l_oock003,l_str_oocn004 
      IF cl_null(l_str_oocn004) THEN
         CALL cb004.addItem(l_oock003,l_oock003) 
      ELSE         
         CALL cb004.addItem(l_oock003,l_str_oocn004)
      END IF   
      LET l_cnt = l_cnt+1
   END FOREACH
END FUNCTION
#+ chk oocn005()
PRIVATE FUNCTION ammt300_01_display_oocn005()
   DEFINE l_oocm004      LIKE oocm_t.oocm004
   DEFINE l_str_oocn005  LIKE type_t.chr100
   DEFINE l_cnt          LIKE type_t.num5
   DEFINE l_sql          STRING 
   DEFINE cb005          ui.ComboBox
   
   LET cb005 = ui.ComboBox.forName("oocn005")
   CALL cb005.clear()
   LET l_sql = "SELECT DISTINCT oocm004,oocml006 FROM oocm_t LEFT JOIN oocml_t ON oocm001=oocml001 AND oocment=oocmlent AND oocm002 = oocml002 AND oocm003 = oocml003 AND oocm004 = oocml004 ",
               "    AND oocml005='",g_dlang,"' ",
               "  WHERE oocmstus='Y' AND oocment=",g_enterprise
               
   IF NOT cl_null( g_oocn_m.oocn001) THEN
      LET l_sql = l_sql clipped," AND oocm001='",g_oocn_m.oocn001,"' "
   END IF
   IF NOT cl_null( g_oocn_m.oocn003) THEN
      LET l_sql = l_sql clipped," AND oocm002='",g_oocn_m.oocn003,"' "
   END IF
   IF NOT cl_null( g_oocn_m.oocn004) THEN
      LET l_sql = l_sql clipped," AND oocm003='",g_oocn_m.oocn004,"' "
   END IF   
   PREPARE l_sql_pre4 FROM l_sql
   DECLARE l_sql_cs4 CURSOR FOR l_sql_pre4
   LET l_cnt = 1
   FOREACH  l_sql_cs4 INTO l_oocm004,l_str_oocn005 
      IF cl_null(l_str_oocn005) THEN
         CALL cb005.addItem(l_oocm004,l_oocm004) 
      ELSE         
         CALL cb005.addItem(l_oocm004,l_str_oocn005)
      END IF   
      LET l_cnt = l_cnt+1
   END FOREACH 
END FUNCTION
#+ chk oocn006
PRIVATE FUNCTION ammt300_01_display_oocn006()
   DEFINE l_oocn006      LIKE oocn_t.oocn006
   DEFINE l_str_oocn006  LIKE type_t.chr100
   DEFINE l_cnt          LIKE type_t.num5
   DEFINE l_sql          STRING 
   DEFINE cb006          ui.ComboBox
   
   LET cb006 = ui.ComboBox.forName("oocn006")
   CALL cb006.clear()
   LET l_sql = "SELECT DISTINCT oocn006 FROM oocn_t ",
               "  WHERE oocnstus='Y' AND oocnent=",g_enterprise
               
   IF NOT cl_null( g_oocn_m.oocn001) THEN
      LET l_sql = l_sql clipped," AND oocn001='",g_oocn_m.oocn001,"' "
   END IF
   IF NOT cl_null( g_oocn_m.oocn003) THEN
      LET l_sql = l_sql clipped," AND oocn003='",g_oocn_m.oocn003,"' "
   END IF
   IF NOT cl_null( g_oocn_m.oocn004) THEN
      LET l_sql = l_sql clipped," AND oocn004='",g_oocn_m.oocn004,"' "
   END IF
   IF NOT cl_null( g_oocn_m.oocn005) THEN
      LET l_sql = l_sql clipped," AND oocn005='",g_oocn_m.oocn005,"' "
   END IF
   IF NOT cl_null(g_oocn_m.oocn002) THEN
      LET l_sql = l_sql clipped,"    AND oocn002 = '",g_oocn_m.oocn002,"' "      
   END IF   
   PREPARE l_sql_pre5 FROM l_sql
   DECLARE l_sql_cs5 CURSOR FOR l_sql_pre5
   LET l_cnt = 1
   FOREACH  l_sql_cs5 INTO l_oocn006   
      CALL cb006.addItem(l_oocn006,l_oocn006)
      LET l_cnt = l_cnt+1
   END FOREACH
     
END FUNCTION

 
{</section>}
 
