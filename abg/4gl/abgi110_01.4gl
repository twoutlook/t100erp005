#該程式未解開Section, 採用最新樣板產出!
{<section id="abgi110_01.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0001(2016-04-11 16:36:21), PR版次:0001(2016-04-25 18:22:09)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000025
#+ Filename...: abgi110_01
#+ Description: 依預算項目參照表自動產生
#+ Creator....: 06821(2016-04-11 16:18:08)
#+ Modifier...: 06821 -SD/PR- 06821
 
{</section>}
 
{<section id="abgi110_01.global" >}
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
PRIVATE type type_g_bgaa_m        RECORD
       bgaa008 LIKE bgaa_t.bgaa008, 
   bgaa008_desc LIKE type_t.chr80
       END RECORD
	   
#add-point:自定義模組變數(Module Variable)(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="global.variable"

#end add-point
 
DEFINE g_bgaa_m        type_g_bgaa_m
 
   
 
DEFINE g_ref_fields          DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
DEFINE g_rtn_fields          DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
 
#add-point:自定義客戶專用模組變數(Module Variable) name="global.variable_customerization"

#end add-point
 
#add-point:傳入參數說明(global.argv) name="global.argv"

#end add-point
 
{</section>}
 
{<section id="abgi110_01.input" >}
#+ 資料輸入
PUBLIC FUNCTION abgi110_01(--)
   #add-point:input段變數傳入 name="input.get_var"
   p_bgal001,p_bgal002
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
   DEFINE p_bgal001       LIKE bgal_t.bgal001
   DEFINE p_bgal002       LIKE bgal_t.bgal002
   DEFINE l_bgaa008       LIKE bgaa_t.bgaa008
   DEFINE g_bgal001       LIKE bgal_t.bgal001
   DEFINE g_bgal002       LIKE bgal_t.bgal002
   DEFINE r_success       LIKE type_t.num5
   #end add-point
   
   #畫面開啟 (identifier)
   OPEN WINDOW w_abgi110_01 WITH FORM cl_ap_formpath("abg","abgi110_01")
 
   #瀏覽頁簽資料初始化
   CALL cl_ui_init()
   
   LET g_qryparam.state = "i"
   LET p_cmd = 'a'
   
   #輸入前處理
   #add-point:單頭前置處理 name="input.pre_input"
   CLEAR FORM
   WHENEVER ERROR CONTINUE
   
   INITIALIZE g_bgaa_m.* TO NULL
   LET g_bgal001 = p_bgal001
   LET g_bgal002 = p_bgal002
   IF cl_null(g_bgal001) THEN RETURN END IF
   #end add-point
  
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
   
      #輸入開始
      INPUT BY NAME g_bgaa_m.bgaa008 ATTRIBUTE(WITHOUT DEFAULTS)
         
         #自訂ACTION
         #add-point:單頭前置處理 name="input.action"
 
         #end add-point
         
         #自訂ACTION(master_input)
         
         
         BEFORE INPUT
            #add-point:單頭輸入前處理 name="input.before_input"
            SELECT bgaa008 INTO g_bgaa_m.bgaa008 FROM bgaa_t 
             WHERE bgaaent = g_enterprise AND bgaa001 = g_bgal001
             
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_bgaa_m.bgaa008
            CALL ap_ref_array2(g_ref_fields,"SELECT ooall004 FROM ooall_t WHERE ooallent='"||g_enterprise||"' AND ooall001='11' AND ooall002=? AND ooall003='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_bgaa_m.bgaa008_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_bgaa_m.bgaa008,g_bgaa_m.bgaa008_desc
            #end add-point
          
                  #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgaa008
            
            #add-point:AFTER FIELD bgaa008 name="input.a.bgaa008"
            LET g_bgaa_m.bgaa008_desc = ''
            DISPLAY BY NAME g_bgaa_m.bgaa008_desc
            IF NOT cl_null(g_bgaa_m.bgaa008) THEN 
               #檢查是否為該組織下使用之預算參照表
               SELECT bgaa008 INTO l_bgaa008 FROM bgaa_t 
                WHERE bgaaent = g_enterprise AND bgaa001 = g_bgal001
               IF l_bgaa008 <> g_bgaa_m.bgaa008 THEN 
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.code   = 'abg-00128'
                  LET g_errparam.extend = g_bgaa_m.bgaa008
                  LET g_errparam.popup  = TRUE 
                  CALL cl_err()
                  LET g_bgaa_m.bgaa008 = ''
                  INITIALIZE g_ref_fields TO NULL
                  LET g_ref_fields[1] = g_bgaa_m.bgaa008
                  CALL ap_ref_array2(g_ref_fields,"SELECT ooall004 FROM ooall_t WHERE ooallent='"||g_enterprise||"' AND ooall001='11' AND ooall002=? AND ooall003='"||g_dlang||"'","") RETURNING g_rtn_fields
                  LET g_bgaa_m.bgaa008_desc = '', g_rtn_fields[1] , ''
                  DISPLAY BY NAME g_bgaa_m.bgaa008,g_bgaa_m.bgaa008_desc
                  NEXT FIELD CURRENT                  
               END IF
                  
               #檢查是否存在abgi045
               LET l_count = 0
               SELECT COUNT(*) INTO l_count 
                 FROM bgae_t
                WHERE bgaeent = g_enterprise AND bgae006 = g_bgaa_m.bgaa008
               IF cl_null(l_count) THEN LET l_count = 0 END IF
               IF l_count = 0 THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.code   = 'abg-00127'
                  LET g_errparam.extend = g_bgaa_m.bgaa008
                  LET g_errparam.popup  = TRUE 
                  CALL cl_err()
                  LET g_bgaa_m.bgaa008 = ''
                  INITIALIZE g_ref_fields TO NULL
                  LET g_ref_fields[1] = g_bgaa_m.bgaa008
                  CALL ap_ref_array2(g_ref_fields,"SELECT ooall004 FROM ooall_t WHERE ooallent='"||g_enterprise||"' AND ooall001='11' AND ooall002=? AND ooall003='"||g_dlang||"'","") RETURNING g_rtn_fields
                  LET g_bgaa_m.bgaa008_desc = '', g_rtn_fields[1] , ''
                  DISPLAY BY NAME g_bgaa_m.bgaa008,g_bgaa_m.bgaa008_desc
                  NEXT FIELD CURRENT
               END IF
            END IF 
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_bgaa_m.bgaa008
            CALL ap_ref_array2(g_ref_fields,"SELECT ooall004 FROM ooall_t WHERE ooallent='"||g_enterprise||"' AND ooall001='11' AND ooall002=? AND ooall003='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_bgaa_m.bgaa008_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_bgaa_m.bgaa008_desc
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgaa008
            #add-point:BEFORE FIELD bgaa008 name="input.b.bgaa008"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE bgaa008
            #add-point:ON CHANGE bgaa008 name="input.g.bgaa008"
            
            #END add-point 
 
 
 #欄位檢查
                  #Ctrlp:input.c.bgaa008
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgaa008
            #add-point:ON ACTION controlp INFIELD bgaa008 name="input.c.bgaa008"
            #應用 a07 樣板自動產生(Version:3)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_bgaa_m.bgaa008  #給予default值
            #給予arg
            LET g_qryparam.where = " bgae006 IN (SELECT bgaa008 FROM bgaa_t 
                                                  WHERE bgaaent = '",g_enterprise,"' 
                                                    AND bgaa001 = '",g_bgal001,"' )" 
            CALL q_bgae006()                            #呼叫開窗
            LET g_bgaa_m.bgaa008 = g_qryparam.return1              
            DISPLAY g_bgaa_m.bgaa008 TO bgaa008        
            NEXT FIELD bgaa008                          #返回原欄位
            #END add-point
 
 
 #欄位開窗
 
         AFTER INPUT
            #add-point:單頭輸入後處理 name="input.after_input"
            
            #end add-point
            
      END INPUT
    
      #add-point:自定義input name="input.more_input"
      BEFORE DIALOG
         SELECT bgaa008 INTO g_bgaa_m.bgaa008 FROM bgaa_t 
          WHERE bgaaent = g_enterprise AND bgaa001 = g_bgal001
          
         INITIALIZE g_ref_fields TO NULL
         LET g_ref_fields[1] = g_bgaa_m.bgaa008
         CALL ap_ref_array2(g_ref_fields,"SELECT ooall004 FROM ooall_t WHERE ooallent='"||g_enterprise||"' AND ooall001='11' AND ooall002=? AND ooall003='"||g_dlang||"'","") RETURNING g_rtn_fields
         LET g_bgaa_m.bgaa008_desc = '', g_rtn_fields[1] , ''
         DISPLAY BY NAME g_bgaa_m.bgaa008,g_bgaa_m.bgaa008_desc
         EXIT DIALOG
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
   CLOSE WINDOW w_abgi110_01 
   
   #add-point:input段after input name="input.post_input"
   LET r_success = TRUE
   
   CALL cl_err_collect_init()
   IF INT_FLAG THEN
      LET r_success= FALSE
      LET INT_FLAG = 0
   ELSE
      CALL abgi110_01_ins_bgal(p_bgal001,p_bgal002) RETURNING g_sub_success
      IF NOT g_sub_success THEN
         LET r_success= FALSE
      END IF
   END IF
   CALL cl_err_collect_show()
   
   RETURN r_success
   #end add-point    
   
END FUNCTION
 
{</section>}
 
{<section id="abgi110_01.other_dialog" readonly="Y" >}

 
{</section>}
 
{<section id="abgi110_01.other_function" readonly="Y" >}

################################################################################
# Descriptions...: 寫入資料
# Memo...........:
# Usage..........: CALL abgi110_01_ins_bgal(p_bgal001,p_bgal002)
# Input parameter: p_bgal001   传入参数变量说明1
#                : p_bgal002   传入参数变量说明2
# Date & Author..: 160411 By Jessy
# Modify.........:
################################################################################
PRIVATE FUNCTION abgi110_01_ins_bgal(p_bgal001,p_bgal002)
DEFINE p_bgal001     LIKE bgal_t.bgal001
DEFINE p_bgal002     LIKE bgal_t.bgal002
DEFINE ld_date       DATETIME YEAR TO SECOND
DEFINE l_sql         STRING
DEFINE l_bgae        RECORD                 #來源table
         bgae001     LIKE bgae_t.bgae001,
         bgae037     LIKE bgae_t.bgae037,
         bgae015     LIKE bgae_t.bgae015,
         bgae016     LIKE bgae_t.bgae016,
         bgae017     LIKE bgae_t.bgae017,
         bgae018     LIKE bgae_t.bgae018,
         bgae019     LIKE bgae_t.bgae019,
         bgae020     LIKE bgae_t.bgae020,
         bgae021     LIKE bgae_t.bgae021,
         bgae022     LIKE bgae_t.bgae022,
         bgae023     LIKE bgae_t.bgae023,
         bgae024     LIKE bgae_t.bgae024,
         bgae025     LIKE bgae_t.bgae025,
         bgae040     LIKE bgae_t.bgae040,
         bgae041     LIKE bgae_t.bgae041,
         bgae026     LIKE bgae_t.bgae026,
         bgae027     LIKE bgae_t.bgae027,
         bgae028     LIKE bgae_t.bgae028,
         bgae029     LIKE bgae_t.bgae029,
         bgae030     LIKE bgae_t.bgae030,
         bgae031     LIKE bgae_t.bgae031,
         bgae032     LIKE bgae_t.bgae032,
         bgae033     LIKE bgae_t.bgae033,
         bgae034     LIKE bgae_t.bgae034,
         bgae035     LIKE bgae_t.bgae035
                     END RECORD
DEFINE r_success     LIKE type_t.num5

   LET r_success = TRUE
   WHENEVER ERROR CONTINUE
   
   LET ld_date = cl_get_current()  
   
   #撈出會計科目表資訊agli021
   INITIALIZE l_bgae.* TO NULL
   LET l_sql = " SELECT bgae001,bgae037,bgae015,bgae016,bgae017,bgae018,
                        bgae019,bgae020,bgae021,bgae022,bgae023,bgae024,
                        bgae025,bgae040,bgae041,bgae026,bgae027,bgae028,
                        bgae029,bgae030,bgae031,bgae032,bgae033,bgae034,
                        bgae035 ",
               "   FROM bgae_t ",
               "  WHERE bgaeent = ",g_enterprise,
               "    AND bgae006 = '",g_bgaa_m.bgaa008,"' ",
               "    AND bgae007 = '1' ",
               "  ORDER BY bgae001 "
               
   PREPARE abgi110_01_p FROM l_sql
   DECLARE abgi110_01_c CURSOR FOR abgi110_01_p
   FOREACH abgi110_01_c INTO l_bgae.*
      
      #因可重覆執行,寫入前先刪除資料
      DELETE FROM bgal_t 
       WHERE bgalent = g_enterprise 
         AND bgal001 = p_bgal001   
         AND bgal002 = p_bgal002
         AND bgal003 = l_bgae.bgae001
      
      #寫入bgal_t      
      INSERT INTO bgal_t(bgalent,bgal001,bgal002,bgal003,bgal004,bgal005,
                         bgal006,bgal007,bgal008,bgal009,bgal010,bgal011,
                         bgal012,bgal013,bgal014,bgal025,bgal026,bgal027,
                         bgal015,bgal016,bgal017,bgal018,bgal019,bgal020,
                         bgal021,bgal022,bgal023,bgal024,bgalstus,bgalownid,
                         bgalowndp,bgalcrtid,bgalcrtdp,bgalcrtdt,bgalmodid,bgalmoddt) 
                  VALUES(g_enterprise,p_bgal001,p_bgal002,l_bgae.bgae001,l_bgae.bgae037,l_bgae.bgae015,
                         l_bgae.bgae016,l_bgae.bgae017,l_bgae.bgae018,l_bgae.bgae019,l_bgae.bgae020,l_bgae.bgae021,
                         l_bgae.bgae022,l_bgae.bgae023,l_bgae.bgae024,l_bgae.bgae025,l_bgae.bgae040,l_bgae.bgae041,
                         l_bgae.bgae026,l_bgae.bgae027,l_bgae.bgae028,l_bgae.bgae029,l_bgae.bgae030,l_bgae.bgae031,
                         l_bgae.bgae032,l_bgae.bgae033,l_bgae.bgae034,l_bgae.bgae035,'Y',g_user,
                         g_dept,g_user,g_dept,ld_date,g_user,ld_date)
                         
      IF SQLCA.SQLcode  THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.SQLCODE
         LET g_errparam.extend = "ins_bgal wrong!!"
         LET g_errparam.popup = TRUE
         CALL cl_err()
         LET r_success = FALSE
         EXIT FOREACH
      END IF
      
   END FOREACH
   
   RETURN r_success
END FUNCTION

 
{</section>}
 
