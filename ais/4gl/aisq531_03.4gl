#該程式未解開Section, 採用最新樣板產出!
{<section id="aisq531_03.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0001(2016-03-03 10:49:53), PR版次:0001(2016-03-03 13:38:09)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000026
#+ Filename...: aisq531_03
#+ Description: 列印碼異動清單
#+ Creator....: 05016(2016-03-02 15:15:28)
#+ Modifier...: 05016 -SD/PR- 05016
 
{</section>}
 
{<section id="aisq531_03.global" >}
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
PRIVATE type type_g_isax_m        RECORD
       isaxcomp LIKE isax_t.isaxcomp, 
   isax001 LIKE isax_t.isax001, 
   isax002 LIKE isax_t.isax002, 
   isax003 LIKE isax_t.isax003
       END RECORD
	   
#add-point:自定義模組變數(Module Variable)(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="global.variable"
DEFINE g_isax DYNAMIC ARRAY OF RECORD
   isax004 LIKE isax_t.isax004,
   isax005 LIKE isax_t.isax005,
   isaxseq LIKE isax_t.isaxseq,
   isax006 LIKE isax_t.isax006,
   isax008 LIKE isax_t.isax008,
   isax007 LIKE isax_t.isax007,
   isax010 LIKE isax_t.isax010,
   ooag011 LIKE ooag_t.ooag011,
   isax009 LIKE isax_t.isax009,
   isax011 LIkE isax_t.isax011
       END RECORD 



#end add-point
 
DEFINE g_isax_m        type_g_isax_m
 
   DEFINE g_isax001_t LIKE isax_t.isax001
DEFINE g_isax002_t LIKE isax_t.isax002
DEFINE g_isax003_t LIKE isax_t.isax003
 
 
DEFINE g_ref_fields          DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
DEFINE g_rtn_fields          DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
 
#add-point:自定義客戶專用模組變數(Module Variable) name="global.variable_customerization"

#end add-point
 
#add-point:傳入參數說明(global.argv) name="global.argv"

#end add-point
 
{</section>}
 
{<section id="aisq531_03.input" >}
#+ 資料輸入
PUBLIC FUNCTION aisq531_03(--)
   #add-point:input段變數傳入 name="input.get_var"
   p_isaxcomp,p_isax001,p_isax002,p_isax003
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
   DEFINE p_isaxcomp LIKE isax_t.isaxcomp
   DEFINE p_isax001  LIKE isax_t.isax001
   DEFINE p_isax002  LIKE isax_t.isax002
   DEFINE p_isax003  LIKE isax_t.isax003
   
   
   #end add-point
   
   #畫面開啟 (identifier)
   OPEN WINDOW w_aisq531_03 WITH FORM cl_ap_formpath("ais","aisq531_03")
 
   #瀏覽頁簽資料初始化
   CALL cl_ui_init()
   
   LET g_qryparam.state = "i"
   LET p_cmd = 'a'
   
   #輸入前處理
   #add-point:單頭前置處理 name="input.pre_input"
   CALL cl_set_combo_scc('isax008','9757')
   CALL cl_set_combo_scc('isax007','9758')
   LET g_isax_m.isaxcomp = p_isaxcomp
   LET g_isax_m.isax001  = p_isax001
   LET g_isax_m.isax002  = p_isax002
   LET g_isax_m.isax003  = p_isax003
   DISPLAY BY NAME g_isax_m.isaxcomp,g_isax_m.isax001,
                   g_isax_m.isax002,g_isax_m.isax003
   CALL aisq531_03_b_fill()
   #end add-point
  
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
   
      #輸入開始
      INPUT BY NAME g_isax_m.isaxcomp,g_isax_m.isax001,g_isax_m.isax002,g_isax_m.isax003 ATTRIBUTE(WITHOUT  
          DEFAULTS)
         
         #自訂ACTION
         #add-point:單頭前置處理 name="input.action"
         
         #end add-point
         
         #自訂ACTION(master_input)
         
         
         BEFORE INPUT
            #add-point:單頭輸入前處理 name="input.before_input"
            
            #end add-point
          
                  #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD isaxcomp
            #add-point:BEFORE FIELD isaxcomp name="input.b.isaxcomp"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD isaxcomp
            
            #add-point:AFTER FIELD isaxcomp name="input.a.isaxcomp"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE isaxcomp
            #add-point:ON CHANGE isaxcomp name="input.g.isaxcomp"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD isax001
            #add-point:BEFORE FIELD isax001 name="input.b.isax001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD isax001
            
            #add-point:AFTER FIELD isax001 name="input.a.isax001"
 
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE isax001
            #add-point:ON CHANGE isax001 name="input.g.isax001"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD isax002
            #add-point:BEFORE FIELD isax002 name="input.b.isax002"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD isax002
            
            #add-point:AFTER FIELD isax002 name="input.a.isax002"
 
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE isax002
            #add-point:ON CHANGE isax002 name="input.g.isax002"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD isax003
            #add-point:BEFORE FIELD isax003 name="input.b.isax003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD isax003
            
            #add-point:AFTER FIELD isax003 name="input.a.isax003"
 
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE isax003
            #add-point:ON CHANGE isax003 name="input.g.isax003"
            
            #END add-point 
 
 
 #欄位檢查
                  #Ctrlp:input.c.isaxcomp
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD isaxcomp
            #add-point:ON ACTION controlp INFIELD isaxcomp name="input.c.isaxcomp"
            
            #END add-point
 
 
         #Ctrlp:input.c.isax001
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD isax001
            #add-point:ON ACTION controlp INFIELD isax001 name="input.c.isax001"
            
            #END add-point
 
 
         #Ctrlp:input.c.isax002
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD isax002
            #add-point:ON ACTION controlp INFIELD isax002 name="input.c.isax002"
            
            #END add-point
 
 
         #Ctrlp:input.c.isax003
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD isax003
            #add-point:ON ACTION controlp INFIELD isax003 name="input.c.isax003"
            
            #END add-point
 
 
 #欄位開窗
 
         AFTER INPUT
            #add-point:單頭輸入後處理 name="input.after_input"
           
            #end add-point
            
      END INPUT
    
      #add-point:自定義input name="input.more_input"
      
      DISPLAY ARRAY g_isax TO s_detail1.* ATTRIBUTE(COUNT=1) 
         ON ACTION exporttoexcel   #匯出excel
            LET g_action_choice="exporttoexcel"
            IF cl_auth_chk_act("exporttoexcel") THEN
               CALL g_export_node.clear()
               LET g_export_node[1] = base.typeInfo.create(g_isax)
               LET g_export_id[1]   = "s_detail1"
             
            
               CALL cl_export_to_excel_getpage()
               CALL cl_export_to_excel()
            END IF

   
      END DISPLAY
      
     
      
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
   CLOSE WINDOW w_aisq531_03 
   
   #add-point:input段after input name="input.post_input"
   
   #end add-point    
   
END FUNCTION
 
{</section>}
 
{<section id="aisq531_03.other_dialog" readonly="Y" >}

 
{</section>}
 
{<section id="aisq531_03.other_function" readonly="Y" >}

################################################################################
# Descriptions...: 單身填充
# Memo...........:
# Usage..........: CALL aisq531_03_b_fill()
# Date & Author..: 2016/03/02 By Hans
# Modify.........:
################################################################################
PRIVATE FUNCTION aisq531_03_b_fill()
DEFINE l_i LIKE type_t.num5
DEFINE l_sql STRING
   
   LET l_i = 1
   LET l_sql = "  SELECT isax004,isax005,isaxseq,isax006,isax008, ",
               "         isax007,isax010,'',isax009,isax011       ",
               "   FROM isax_t                                    ",
               "  WHERE isaxent = '",g_enterprise,"'              ",
               "    AND isaxcomp = '",g_isax_m.isaxcomp,"'        ",
               "    AND isax001 = '",g_isax_m.isax001,"'          ",              
               "    AND isax002 = '",g_isax_m.isax002,"'          ",
               "    AND isax003 = '",g_isax_m.isax003,"'          ",
               " ORDER BY isaxseq                                 "
   PREPARE aisq531_03_prep01 FROM l_sql
   DECLARE aisq531_03_curs01 CURSOR FOR aisq531_03_prep01
   FOREACH aisq531_03_curs01 INTO g_isax[l_i].*
   
      LET g_isax[l_i].ooag011 = s_desc_get_person_desc(g_isax[l_i].isax010)
   
      LET l_i = l_i +1    
   
   
   END FOREACH
   CALL g_isax.deleteElement(g_isax.getLength())

END FUNCTION

 
{</section>}
 
