#該程式未解開Section, 採用最新樣板產出!
{<section id="agli030_01.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0005(2014-10-11 15:19:46), PR版次:0005(2016-09-05 16:06:49)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000270
#+ Filename...: agli030_01
#+ Description: 
#+ Creator....: 02299(2013-09-11 09:49:13)
#+ Modifier...: 02599 -SD/PR- 05423
 
{</section>}
 
{<section id="agli030_01.global" >}
#應用 c01b 樣板自動產生(Version:10)
#add-point:填寫註解說明 name="global.memo"
#160318-00005#13  2016/03/25 by 07675   將重複內容的錯誤訊息置換為公用錯誤訊息
#160905-00007#3   2016/09/05 By zhujing 调整系统中无ENT的SQL条件增加ent
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
PRIVATE type type_g_glad_m        RECORD
       gladld LIKE glad_t.gladld, 
   gladld_desc LIKE type_t.chr80, 
   glad001 LIKE glad_t.glad001, 
   glad001_desc LIKE type_t.chr80, 
   gladstus LIKE glad_t.gladstus, 
   glad030 LIKE glad_t.glad030, 
   glad002 LIKE glad_t.glad002, 
   glad003 LIKE glad_t.glad003, 
   glad004 LIKE glad_t.glad004, 
   glad005 LIKE glad_t.glad005, 
   glad006 LIKE glad_t.glad006, 
   glad006_desc LIKE type_t.chr80, 
   glad007 LIKE glad_t.glad007, 
   fflabel_1 LIKE type_t.chr80, 
   glad031 LIKE glad_t.glad031, 
   glad008 LIKE glad_t.glad008, 
   glad032 LIKE glad_t.glad032, 
   glad009 LIKE glad_t.glad009, 
   glad033 LIKE glad_t.glad033, 
   glad010 LIKE glad_t.glad010, 
   glad013 LIKE glad_t.glad013, 
   glad027 LIKE glad_t.glad027, 
   glad015 LIKE glad_t.glad015, 
   glad011 LIKE glad_t.glad011, 
   glad016 LIKE glad_t.glad016, 
   glad012 LIKE glad_t.glad012, 
   glad017 LIKE glad_t.glad017, 
   glad0171 LIKE glad_t.glad0171, 
   glad0171_desc LIKE type_t.chr80, 
   glad0172 LIKE glad_t.glad0172, 
   glad018 LIKE glad_t.glad018, 
   glad0181 LIKE glad_t.glad0181, 
   glad0181_desc LIKE type_t.chr80, 
   glad0182 LIKE glad_t.glad0182, 
   glad019 LIKE glad_t.glad019, 
   glad0191 LIKE glad_t.glad0191, 
   glad0191_desc LIKE type_t.chr80, 
   glad0192 LIKE glad_t.glad0192, 
   glad020 LIKE glad_t.glad020, 
   glad0201 LIKE glad_t.glad0201, 
   glad0201_desc LIKE type_t.chr80, 
   glad0202 LIKE glad_t.glad0202, 
   glad021 LIKE glad_t.glad021, 
   glad0211 LIKE glad_t.glad0211, 
   glad0211_desc LIKE type_t.chr80, 
   glad0212 LIKE glad_t.glad0212, 
   glad022 LIKE glad_t.glad022, 
   glad0221 LIKE glad_t.glad0221, 
   glad0221_desc LIKE type_t.chr80, 
   glad0222 LIKE glad_t.glad0222, 
   glad023 LIKE glad_t.glad023, 
   glad0231 LIKE glad_t.glad0231, 
   glad0231_desc LIKE type_t.chr80, 
   glad0232 LIKE glad_t.glad0232, 
   glad024 LIKE glad_t.glad024, 
   glad0241 LIKE glad_t.glad0241, 
   glad0241_desc LIKE type_t.chr80, 
   glad0242 LIKE glad_t.glad0242, 
   glad025 LIKE glad_t.glad025, 
   glad0251 LIKE glad_t.glad0251, 
   glad0251_desc LIKE type_t.chr80, 
   glad0252 LIKE glad_t.glad0252, 
   glad026 LIKE glad_t.glad026, 
   glad0261 LIKE glad_t.glad0261, 
   glad0261_desc LIKE type_t.chr80, 
   glad0262 LIKE glad_t.glad0262
       END RECORD
	   
#add-point:自定義模組變數(Module Variable)(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="global.variable"
DEFINE gwin_curr             ui.Window                #Current Window
DEFINE gfrm_curr             ui.Form                  #Current Form
DEFINE g_glad_m_t        type_g_glad_m
#end add-point
 
DEFINE g_glad_m        type_g_glad_m
 
   DEFINE g_gladld_t LIKE glad_t.gladld
DEFINE g_glad001_t LIKE glad_t.glad001
 
 
DEFINE g_ref_fields          DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
DEFINE g_rtn_fields          DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
 
#add-point:自定義客戶專用模組變數(Module Variable) name="global.variable_customerization"

#end add-point
 
#add-point:傳入參數說明(global.argv) name="global.argv"

#end add-point
 
{</section>}
 
{<section id="agli030_01.input" >}
#+ 資料輸入
PUBLIC FUNCTION agli030_01(--)
   #add-point:input段變數傳入 name="input.get_var"
   ps_cmd,p_gladld,p_glad001
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
   DEFINE p_gladld        LIKE glad_t.gladld
   DEFINE p_glad001       LIKE glad_t.glad001
   DEFINE l_glaa005       LIKE glaa_t.glaa005
   DEFINE l_gladcrtdt     LIKE glad_t.gladcrtdt
   DEFINE l_gladmoddt     LIKE glad_t.gladmoddt
   DEFINE l_glac016       LIKE glac_t.glac016
   DEFINE l_glac001       LIKE glac_t.glac001
   DEFINE ps_cmd          LIKE type_t.chr5
   #end add-point
   
   #畫面開啟 (identifier)
   OPEN WINDOW w_agli030_01 WITH FORM cl_ap_formpath("agl","agli030_01")
 
   #瀏覽頁簽資料初始化
   CALL cl_ui_init()
   
   LET g_qryparam.state = "i"
   LET p_cmd = 'a'
   
   #輸入前處理
   #add-point:單頭前置處理 name="input.pre_input"
   CALL cl_ui_init()
   LET p_cmd = ps_cmd  
   INITIALIZE g_glad_m.* TO NULL
   WHENEVER ERROR CALL cl_err_msg_log
   LET gwin_curr = ui.Window.getCurrent()
   LET gfrm_curr = gwin_curr.getForm()
   LET INT_FLAG = 0  
   #下拉框給值
   CALL cl_set_combo_scc_part('gladstus','17','N,Y')
   CALL cl_set_combo_scc('glad004','8020')
   CALL cl_set_combo_scc('glad0172','8019')
   CALL cl_set_combo_scc('glad0182','8019')
   CALL cl_set_combo_scc('glad0192','8019')
   CALL cl_set_combo_scc('glad0202','8019')
   CALL cl_set_combo_scc('glad0212','8019')
   CALL cl_set_combo_scc('glad0222','8019')
   CALL cl_set_combo_scc('glad0232','8019')
   CALL cl_set_combo_scc('glad0242','8019')
   CALL cl_set_combo_scc('glad0252','8019')
   CALL cl_set_combo_scc('glad0262','8019')
   LET g_glad_m.gladld = p_gladld
      LET g_glad_m.glad001 = p_glad001
   #p_cmd= 'a' 且檢查后資料不重複
   IF p_cmd = 'a' THEN
      CALL agli030_01_insert()
      CALL agli030_01_gladld_ref_glaal002(g_glad_m.gladld)
         RETURNING g_glad_m.gladld_desc
      DISPLAY g_glad_m.gladld_desc TO gladld_desc
   END IF 
   #p_cmd= 'u' 
   IF p_cmd = 'u' THEN
      CALL agli030_01_update()
   END IF 
   #p_cmd= 'c' 
   IF p_cmd = 'c' THEN
      CALL agli030_01_copy()
   END IF 
   #統一要做的動作
   #有效碼欄位的圖片顯示
   CASE g_glad_m.gladstus
      WHEN "Y"
         CALL gfrm_curr.setElementImage("statechange","authstatus/valid.png")
      WHEN "N"
         CALL gfrm_curr.setElementImage("statechange","authstatus/void.png")
   END CASE
   #entry，noentry，required
   CALL agli030_01_set_entry(p_cmd)
   CALL agli030_01_set_noentry(p_cmd)
   CALL agli030_01_set_required(p_cmd)
   LET g_glad_m_t.* = g_glad_m.*
   LET l_gladcrtdt = cl_get_current()
   LET l_gladmoddt = cl_get_current()
   
   #根據glac016設定glad006是否required
   LET l_glac001 = ''
   LET l_glac016 = ''
   SELECT glaa004 INTO l_glac001 FROM glaa_t
    WHERE glaaent = g_enterprise AND glaald = p_gladld
   
   SELECT glac016 INTO l_glac016 FROM glac_t
    WHERE glacent = g_enterprise AND glac002 = p_glad001 AND glac001 = l_glac001
    
   CALL cl_set_comp_required('glad006',l_glac016 = 'Y') 
   CALL agli030_01_glad001_ref(g_glad_m.gladld,g_glad_m.glad001) 
      RETURNING g_glad_m.glad001_desc
   DISPLAY g_glad_m.glad001_desc TO glad001_desc
   #end add-point
  
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
   
      #輸入開始
      INPUT BY NAME g_glad_m.gladld,g_glad_m.glad001,g_glad_m.gladstus,g_glad_m.glad030,g_glad_m.glad002, 
          g_glad_m.glad003,g_glad_m.glad004,g_glad_m.glad005,g_glad_m.glad006,g_glad_m.glad007,g_glad_m.glad031, 
          g_glad_m.glad008,g_glad_m.glad032,g_glad_m.glad009,g_glad_m.glad033,g_glad_m.glad010,g_glad_m.glad013, 
          g_glad_m.glad027,g_glad_m.glad015,g_glad_m.glad011,g_glad_m.glad016,g_glad_m.glad012,g_glad_m.glad017, 
          g_glad_m.glad0171,g_glad_m.glad0172,g_glad_m.glad018,g_glad_m.glad0181,g_glad_m.glad0182,g_glad_m.glad019, 
          g_glad_m.glad0191,g_glad_m.glad0192,g_glad_m.glad020,g_glad_m.glad0201,g_glad_m.glad0202,g_glad_m.glad021, 
          g_glad_m.glad0211,g_glad_m.glad0212,g_glad_m.glad022,g_glad_m.glad0221,g_glad_m.glad0222,g_glad_m.glad023, 
          g_glad_m.glad0231,g_glad_m.glad0232,g_glad_m.glad024,g_glad_m.glad0241,g_glad_m.glad0242,g_glad_m.glad025, 
          g_glad_m.glad0251,g_glad_m.glad0252,g_glad_m.glad026,g_glad_m.glad0261,g_glad_m.glad0262 ATTRIBUTE(WITHOUT  
          DEFAULTS)
         
         #自訂ACTION
         #add-point:單頭前置處理 name="input.action"
         
         #end add-point
         
         #自訂ACTION(master_input)
         
         
         BEFORE INPUT
            #add-point:單頭輸入前處理 name="input.before_input"
            
            #end add-point
          
                  #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gladld
            
            #add-point:AFTER FIELD gladld name="input.a.gladld"
 
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gladld
            #add-point:BEFORE FIELD gladld name="input.b.gladld"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE gladld
            #add-point:ON CHANGE gladld name="input.g.gladld"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glad001
            
            #add-point:AFTER FIELD glad001 name="input.a.glad001"
            #此段落由子樣板a05產生
            DISPLAY '' TO glad001_desc
            IF NOT agli030_01_glad001_chk(g_glad_m.gladld,g_glad_m.glad001) THEN
               LET g_glad_m.glad001 = ''
               NEXT FIELD glad001
            END IF 
            CALL agli030_01_glad001_ref(g_glad_m.gladld,g_glad_m.glad001) 
               RETURNING g_glad_m.glad001_desc
            DISPLAY g_glad_m.glad001_desc TO glad001_desc
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glad001
            #add-point:BEFORE FIELD glad001 name="input.b.glad001"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE glad001
            #add-point:ON CHANGE glad001 name="input.g.glad001"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gladstus
            #add-point:BEFORE FIELD gladstus name="input.b.gladstus"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gladstus
            
            #add-point:AFTER FIELD gladstus name="input.a.gladstus"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE gladstus
            #add-point:ON CHANGE gladstus name="input.g.gladstus"
            CASE g_glad_m.gladstus
               WHEN "Y"
                  CALL gfrm_curr.setElementImage("statechange","authstatus/valid.png")
               WHEN "N"
                  CALL gfrm_curr.setElementImage("statechange","authstatus/void.png")
            END CASE
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glad030
            #add-point:BEFORE FIELD glad030 name="input.b.glad030"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glad030
            
            #add-point:AFTER FIELD glad030 name="input.a.glad030"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE glad030
            #add-point:ON CHANGE glad030 name="input.g.glad030"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glad002
            #add-point:BEFORE FIELD glad002 name="input.b.glad002"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glad002
            
            #add-point:AFTER FIELD glad002 name="input.a.glad002"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE glad002
            #add-point:ON CHANGE glad002 name="input.g.glad002"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glad003
            #add-point:BEFORE FIELD glad003 name="input.b.glad003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glad003
            
            #add-point:AFTER FIELD glad003 name="input.a.glad003"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE glad003
            #add-point:ON CHANGE glad003 name="input.g.glad003"
            CALL agli030_01_set_entry(p_cmd)
            CALL agli030_01_set_noentry(p_cmd)
            CALL agli030_01_set_required(p_cmd)
            IF g_glad_m.glad003 = 'N' THEN
               LEt g_glad_m.glad004 = ''
               DISPLAY g_glad_m.glad004 TO glad004
            END IF
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glad004
            #add-point:BEFORE FIELD glad004 name="input.b.glad004"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glad004
            
            #add-point:AFTER FIELD glad004 name="input.a.glad004"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE glad004
            #add-point:ON CHANGE glad004 name="input.g.glad004"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glad005
            #add-point:BEFORE FIELD glad005 name="input.b.glad005"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glad005
            
            #add-point:AFTER FIELD glad005 name="input.a.glad005"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE glad005
            #add-point:ON CHANGE glad005 name="input.g.glad005"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glad006
            
            #add-point:AFTER FIELD glad006 name="input.a.glad006"
            DISPLAY '' TO glad006_desc
            IF NOT agli030_01_glad006_chk(g_glad_m.gladld,g_glad_m.glad006) THEN
               LET g_glad_m.glad006 = g_glad_m_t.glad006
               CALL agli030_01_glad006_ref(g_glad_m.gladld,g_glad_m.glad006)
                  RETURNING g_glad_m.glad006_desc
               DISPLAY g_glad_m.glad006_desc TO glad006_desc
               NEXT FIELD glad006
            END IF 
            CALL agli030_01_glad006_ref(g_glad_m.gladld,g_glad_m.glad006)
               RETURNING g_glad_m.glad006_desc
            DISPLAY g_glad_m.glad006_desc TO glad006_desc
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glad006
            #add-point:BEFORE FIELD glad006 name="input.b.glad006"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE glad006
            #add-point:ON CHANGE glad006 name="input.g.glad006"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glad007
            #add-point:BEFORE FIELD glad007 name="input.b.glad007"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glad007
            
            #add-point:AFTER FIELD glad007 name="input.a.glad007"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE glad007
            #add-point:ON CHANGE glad007 name="input.g.glad007"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glad031
            #add-point:BEFORE FIELD glad031 name="input.b.glad031"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glad031
            
            #add-point:AFTER FIELD glad031 name="input.a.glad031"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE glad031
            #add-point:ON CHANGE glad031 name="input.g.glad031"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glad008
            #add-point:BEFORE FIELD glad008 name="input.b.glad008"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glad008
            
            #add-point:AFTER FIELD glad008 name="input.a.glad008"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE glad008
            #add-point:ON CHANGE glad008 name="input.g.glad008"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glad032
            #add-point:BEFORE FIELD glad032 name="input.b.glad032"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glad032
            
            #add-point:AFTER FIELD glad032 name="input.a.glad032"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE glad032
            #add-point:ON CHANGE glad032 name="input.g.glad032"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glad009
            #add-point:BEFORE FIELD glad009 name="input.b.glad009"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glad009
            
            #add-point:AFTER FIELD glad009 name="input.a.glad009"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE glad009
            #add-point:ON CHANGE glad009 name="input.g.glad009"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glad033
            #add-point:BEFORE FIELD glad033 name="input.b.glad033"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glad033
            
            #add-point:AFTER FIELD glad033 name="input.a.glad033"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE glad033
            #add-point:ON CHANGE glad033 name="input.g.glad033"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glad010
            #add-point:BEFORE FIELD glad010 name="input.b.glad010"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glad010
            
            #add-point:AFTER FIELD glad010 name="input.a.glad010"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE glad010
            #add-point:ON CHANGE glad010 name="input.g.glad010"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glad013
            #add-point:BEFORE FIELD glad013 name="input.b.glad013"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glad013
            
            #add-point:AFTER FIELD glad013 name="input.a.glad013"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE glad013
            #add-point:ON CHANGE glad013 name="input.g.glad013"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glad027
            #add-point:BEFORE FIELD glad027 name="input.b.glad027"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glad027
            
            #add-point:AFTER FIELD glad027 name="input.a.glad027"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE glad027
            #add-point:ON CHANGE glad027 name="input.g.glad027"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glad015
            #add-point:BEFORE FIELD glad015 name="input.b.glad015"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glad015
            
            #add-point:AFTER FIELD glad015 name="input.a.glad015"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE glad015
            #add-point:ON CHANGE glad015 name="input.g.glad015"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glad011
            #add-point:BEFORE FIELD glad011 name="input.b.glad011"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glad011
            
            #add-point:AFTER FIELD glad011 name="input.a.glad011"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE glad011
            #add-point:ON CHANGE glad011 name="input.g.glad011"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glad016
            #add-point:BEFORE FIELD glad016 name="input.b.glad016"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glad016
            
            #add-point:AFTER FIELD glad016 name="input.a.glad016"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE glad016
            #add-point:ON CHANGE glad016 name="input.g.glad016"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glad012
            #add-point:BEFORE FIELD glad012 name="input.b.glad012"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glad012
            
            #add-point:AFTER FIELD glad012 name="input.a.glad012"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE glad012
            #add-point:ON CHANGE glad012 name="input.g.glad012"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glad017
            #add-point:BEFORE FIELD glad017 name="input.b.glad017"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glad017
            
            #add-point:AFTER FIELD glad017 name="input.a.glad017"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE glad017
            #add-point:ON CHANGE glad017 name="input.g.glad017"
            CALL agli030_01_set_entry(p_cmd)
            CALL agli030_01_set_noentry(p_cmd)
            CALL agli030_01_set_required(p_cmd)
            IF g_glad_m.glad017 = 'N' THEN
               LET g_glad_m.glad0171 = ''
               LET g_glad_m.glad0172 = ''            
               DISPLAY g_glad_m.glad0171 TO glad0171
               DISPLAY g_glad_m.glad0172 TO glad0172
               LET g_glad_m.glad0171_desc = ''
               DISPLAY g_glad_m.glad0171_desc TO glad0171_desc
            END IF 
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glad0171
            
            #add-point:AFTER FIELD glad0171 name="input.a.glad0171"
            DISPLAY '' TO glad0171_desc
            IF NOT agli030_01_glad0171_glad0261_chk(g_glad_m.glad0171) THEN
               LET g_glad_m.glad0171 = g_glad_m_t.glad0171
               CALL agli030_01_hsx_ref(g_glad_m.glad0171)
                  RETURNING g_glad_m.glad0171_desc
               DISPLAY g_glad_m.glad0171_desc TO glad0171_desc
               NEXT FIELD glad0171
            END IF 
            CALL agli030_01_hsx_ref(g_glad_m.glad0171)
                  RETURNING g_glad_m.glad0171_desc
            DISPLAY g_glad_m.glad0171_desc TO glad0171_desc
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glad0171
            #add-point:BEFORE FIELD glad0171 name="input.b.glad0171"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE glad0171
            #add-point:ON CHANGE glad0171 name="input.g.glad0171"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glad0172
            #add-point:BEFORE FIELD glad0172 name="input.b.glad0172"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glad0172
            
            #add-point:AFTER FIELD glad0172 name="input.a.glad0172"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE glad0172
            #add-point:ON CHANGE glad0172 name="input.g.glad0172"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glad018
            #add-point:BEFORE FIELD glad018 name="input.b.glad018"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glad018
            
            #add-point:AFTER FIELD glad018 name="input.a.glad018"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE glad018
            #add-point:ON CHANGE glad018 name="input.g.glad018"
            CALL agli030_01_set_entry(p_cmd)
            CALL agli030_01_set_noentry(p_cmd)
            CALL agli030_01_set_required(p_cmd)
            IF g_glad_m.glad018 = 'N' THEN
               LET g_glad_m.glad0181 = ''
               LET g_glad_m.glad0182 = ''
               DISPLAY g_glad_m.glad0181 TO glad0181
               DISPLAY g_glad_m.glad0182 TO glad0182
               LET g_glad_m.glad0181_desc = ''
               DISPLAY g_glad_m.glad0181_desc TO glad0181_desc
            END IF
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glad0181
            
            #add-point:AFTER FIELD glad0181 name="input.a.glad0181"
            DISPLAY '' TO glad0181_desc
            IF NOT agli030_01_glad0171_glad0261_chk(g_glad_m.glad0181) THEN
               LET g_glad_m.glad0181 = g_glad_m_t.glad0181
               CALL agli030_01_hsx_ref(g_glad_m.glad0181)
                  RETURNING g_glad_m.glad0181_desc
               DISPLAY g_glad_m.glad0181_desc TO glad0181_desc
               NEXT FIELD glad0181
            END IF 
            CALL agli030_01_hsx_ref(g_glad_m.glad0181)
                  RETURNING g_glad_m.glad0181_desc
            DISPLAY g_glad_m.glad0181_desc TO glad0181_desc

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glad0181
            #add-point:BEFORE FIELD glad0181 name="input.b.glad0181"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE glad0181
            #add-point:ON CHANGE glad0181 name="input.g.glad0181"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glad0182
            #add-point:BEFORE FIELD glad0182 name="input.b.glad0182"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glad0182
            
            #add-point:AFTER FIELD glad0182 name="input.a.glad0182"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE glad0182
            #add-point:ON CHANGE glad0182 name="input.g.glad0182"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glad019
            #add-point:BEFORE FIELD glad019 name="input.b.glad019"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glad019
            
            #add-point:AFTER FIELD glad019 name="input.a.glad019"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE glad019
            #add-point:ON CHANGE glad019 name="input.g.glad019"
            CALL agli030_01_set_entry(p_cmd)
            CALL agli030_01_set_noentry(p_cmd)
            CALL agli030_01_set_required(p_cmd)
            IF g_glad_m.glad019 = 'N' THEN
               LET g_glad_m.glad0191 = ''
               LET g_glad_m.glad0192 = ''
               DISPLAY g_glad_m.glad0191 TO glad0191
               DISPLAY g_glad_m.glad0192 TO glad0192
               LET g_glad_m.glad0191_desc = ''
               DISPLAY g_glad_m.glad0191_desc TO glad0191_desc
            END IF
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glad0191
            
            #add-point:AFTER FIELD glad0191 name="input.a.glad0191"
            DISPLAY '' TO glad0191_desc
            IF NOT agli030_01_glad0171_glad0261_chk(g_glad_m.glad0191) THEN
               LET g_glad_m.glad0191 = g_glad_m_t.glad0191
               CALL agli030_01_hsx_ref(g_glad_m.glad0191)
                  RETURNING g_glad_m.glad0191_desc
               DISPLAY g_glad_m.glad0191_desc TO glad0191_desc
               NEXT FIELD glad0191
            END IF 
            CALL agli030_01_hsx_ref(g_glad_m.glad0191)
                  RETURNING g_glad_m.glad0191_desc
            DISPLAY g_glad_m.glad0191_desc TO glad0191_desc

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glad0191
            #add-point:BEFORE FIELD glad0191 name="input.b.glad0191"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE glad0191
            #add-point:ON CHANGE glad0191 name="input.g.glad0191"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glad0192
            #add-point:BEFORE FIELD glad0192 name="input.b.glad0192"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glad0192
            
            #add-point:AFTER FIELD glad0192 name="input.a.glad0192"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE glad0192
            #add-point:ON CHANGE glad0192 name="input.g.glad0192"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glad020
            #add-point:BEFORE FIELD glad020 name="input.b.glad020"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glad020
            
            #add-point:AFTER FIELD glad020 name="input.a.glad020"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE glad020
            #add-point:ON CHANGE glad020 name="input.g.glad020"
            CALL agli030_01_set_entry(p_cmd)
            CALL agli030_01_set_noentry(p_cmd)
            CALL agli030_01_set_required(p_cmd)
            IF g_glad_m.glad020 = 'N' THEN
               LET g_glad_m.glad0201 = ''
               LET g_glad_m.glad0202 = ''
               DISPLAY g_glad_m.glad0201 TO glad0201
               DISPLAY g_glad_m.glad0202 TO glad0202
               LET g_glad_m.glad0201_desc = ''
               DISPLAY g_glad_m.glad0201_desc TO glad0201_desc
            END IF
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glad0201
            
            #add-point:AFTER FIELD glad0201 name="input.a.glad0201"
            DISPLAY '' TO glad0201_desc
            IF NOT agli030_01_glad0171_glad0261_chk(g_glad_m.glad0201) THEN
               LET g_glad_m.glad0201 = g_glad_m_t.glad0201
               CALL agli030_01_hsx_ref(g_glad_m.glad0201)
                  RETURNING g_glad_m.glad0201_desc
               DISPLAY g_glad_m.glad0201_desc TO glad0201_desc
               NEXT FIELD glad0201
            END IF 
            CALL agli030_01_hsx_ref(g_glad_m.glad0201)
                  RETURNING g_glad_m.glad0201_desc
            DISPLAY g_glad_m.glad0201_desc TO glad0201_desc

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glad0201
            #add-point:BEFORE FIELD glad0201 name="input.b.glad0201"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE glad0201
            #add-point:ON CHANGE glad0201 name="input.g.glad0201"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glad0202
            #add-point:BEFORE FIELD glad0202 name="input.b.glad0202"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glad0202
            
            #add-point:AFTER FIELD glad0202 name="input.a.glad0202"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE glad0202
            #add-point:ON CHANGE glad0202 name="input.g.glad0202"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glad021
            #add-point:BEFORE FIELD glad021 name="input.b.glad021"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glad021
            
            #add-point:AFTER FIELD glad021 name="input.a.glad021"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE glad021
            #add-point:ON CHANGE glad021 name="input.g.glad021"
            CALL agli030_01_set_entry(p_cmd)
            CALL agli030_01_set_noentry(p_cmd)
            CALL agli030_01_set_required(p_cmd)
            IF g_glad_m.glad021 = 'N' THEN
               LET g_glad_m.glad0211 = ''
               LET g_glad_m.glad0212 = ''
               DISPLAY g_glad_m.glad0211 TO glad0211
               DISPLAY g_glad_m.glad0212 TO glad0212
               LET g_glad_m.glad0211_desc = ''
               DISPLAY g_glad_m.glad0211_desc TO glad0211_desc
            END IF
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glad0211
            
            #add-point:AFTER FIELD glad0211 name="input.a.glad0211"
            DISPLAY '' TO glad0211_desc
            IF NOT agli030_01_glad0171_glad0261_chk(g_glad_m.glad0211) THEN
               LET g_glad_m.glad0211 = g_glad_m_t.glad0211
               CALL agli030_01_hsx_ref(g_glad_m.glad0211)
                  RETURNING g_glad_m.glad0211_desc
               DISPLAY g_glad_m.glad0211_desc TO glad0211_desc
               NEXT FIELD glad0211
            END IF 
            CALL agli030_01_hsx_ref(g_glad_m.glad0211)
                  RETURNING g_glad_m.glad0211_desc
            DISPLAY g_glad_m.glad0211_desc TO glad0211_desc

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glad0211
            #add-point:BEFORE FIELD glad0211 name="input.b.glad0211"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE glad0211
            #add-point:ON CHANGE glad0211 name="input.g.glad0211"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glad0212
            #add-point:BEFORE FIELD glad0212 name="input.b.glad0212"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glad0212
            
            #add-point:AFTER FIELD glad0212 name="input.a.glad0212"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE glad0212
            #add-point:ON CHANGE glad0212 name="input.g.glad0212"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glad022
            #add-point:BEFORE FIELD glad022 name="input.b.glad022"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glad022
            
            #add-point:AFTER FIELD glad022 name="input.a.glad022"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE glad022
            #add-point:ON CHANGE glad022 name="input.g.glad022"
            CALL agli030_01_set_entry(p_cmd)
            CALL agli030_01_set_noentry(p_cmd)
            CALL agli030_01_set_required(p_cmd)
            IF g_glad_m.glad022 = 'N' THEN
               LET g_glad_m.glad0221 = ''
               LET g_glad_m.glad0222 = ''
               DISPLAY g_glad_m.glad0221 TO glad0221
               DISPLAY g_glad_m.glad0222 TO glad0222
               LET g_glad_m.glad0221_desc = ''
               DISPLAY g_glad_m.glad0221_desc TO glad0221_desc
            END IF
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glad0221
            
            #add-point:AFTER FIELD glad0221 name="input.a.glad0221"
            DISPLAY '' TO glad0221_desc
            IF NOT agli030_01_glad0171_glad0261_chk(g_glad_m.glad0221) THEN
               LET g_glad_m.glad0221 = g_glad_m_t.glad0221
               CALL agli030_01_hsx_ref(g_glad_m.glad0221)
                  RETURNING g_glad_m.glad0221_desc
               DISPLAY g_glad_m.glad0221_desc TO glad0221_desc
               NEXT FIELD glad0221
            END IF 
            CALL agli030_01_hsx_ref(g_glad_m.glad0221)
                  RETURNING g_glad_m.glad0221_desc
            DISPLAY g_glad_m.glad0221_desc TO glad0221_desc

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glad0221
            #add-point:BEFORE FIELD glad0221 name="input.b.glad0221"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE glad0221
            #add-point:ON CHANGE glad0221 name="input.g.glad0221"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glad0222
            #add-point:BEFORE FIELD glad0222 name="input.b.glad0222"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glad0222
            
            #add-point:AFTER FIELD glad0222 name="input.a.glad0222"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE glad0222
            #add-point:ON CHANGE glad0222 name="input.g.glad0222"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glad023
            #add-point:BEFORE FIELD glad023 name="input.b.glad023"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glad023
            
            #add-point:AFTER FIELD glad023 name="input.a.glad023"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE glad023
            #add-point:ON CHANGE glad023 name="input.g.glad023"
            CALL agli030_01_set_entry(p_cmd)
            CALL agli030_01_set_noentry(p_cmd)
            CALL agli030_01_set_required(p_cmd)
            IF g_glad_m.glad023 = 'N' THEN
               LET g_glad_m.glad0231 = ''
               LET g_glad_m.glad0232 = ''
               DISPLAY g_glad_m.glad0231 TO glad0231
               DISPLAY g_glad_m.glad0232 TO glad0232
               LET g_glad_m.glad0231_desc = ''
               DISPLAY g_glad_m.glad0231_desc TO glad0231_desc
            END IF
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glad0231
            
            #add-point:AFTER FIELD glad0231 name="input.a.glad0231"
            DISPLAY '' TO glad0231_desc
            IF NOT agli030_01_glad0171_glad0261_chk(g_glad_m.glad0231) THEN
               LET g_glad_m.glad0231 = g_glad_m_t.glad0231
               CALL agli030_01_hsx_ref(g_glad_m.glad0231)
                  RETURNING g_glad_m.glad0231_desc
               DISPLAY g_glad_m.glad0231_desc TO glad0231_desc
               NEXT FIELD glad0231
            END IF 
            CALL agli030_01_hsx_ref(g_glad_m.glad0231)
                  RETURNING g_glad_m.glad0231_desc
            DISPLAY g_glad_m.glad0231_desc TO glad0231_desc

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glad0231
            #add-point:BEFORE FIELD glad0231 name="input.b.glad0231"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE glad0231
            #add-point:ON CHANGE glad0231 name="input.g.glad0231"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glad0232
            #add-point:BEFORE FIELD glad0232 name="input.b.glad0232"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glad0232
            
            #add-point:AFTER FIELD glad0232 name="input.a.glad0232"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE glad0232
            #add-point:ON CHANGE glad0232 name="input.g.glad0232"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glad024
            #add-point:BEFORE FIELD glad024 name="input.b.glad024"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glad024
            
            #add-point:AFTER FIELD glad024 name="input.a.glad024"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE glad024
            #add-point:ON CHANGE glad024 name="input.g.glad024"
            CALL agli030_01_set_entry(p_cmd)
            CALL agli030_01_set_noentry(p_cmd)
            CALL agli030_01_set_required(p_cmd)
            IF g_glad_m.glad024 = 'N' THEN
               LET g_glad_m.glad0241 = ''
               LET g_glad_m.glad0242 = ''
               DISPLAY g_glad_m.glad0241 TO glad0241
               DISPLAY g_glad_m.glad0242 TO glad0242
               LET g_glad_m.glad0241_desc = ''
               DISPLAY g_glad_m.glad0241_desc TO glad0241_desc
            END IF
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glad0241
            
            #add-point:AFTER FIELD glad0241 name="input.a.glad0241"
            DISPLAY '' TO glad0241_desc
            IF NOT agli030_01_glad0171_glad0261_chk(g_glad_m.glad0241) THEN
               LET g_glad_m.glad0241 = g_glad_m_t.glad0241
               CALL agli030_01_hsx_ref(g_glad_m.glad0241)
                  RETURNING g_glad_m.glad0241_desc
               DISPLAY g_glad_m.glad0241_desc TO glad0241_desc
               NEXT FIELD glad0241
            END IF 
            CALL agli030_01_hsx_ref(g_glad_m.glad0241)
                  RETURNING g_glad_m.glad0241_desc
            DISPLAY g_glad_m.glad0241_desc TO glad0241_desc

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glad0241
            #add-point:BEFORE FIELD glad0241 name="input.b.glad0241"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE glad0241
            #add-point:ON CHANGE glad0241 name="input.g.glad0241"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glad0242
            #add-point:BEFORE FIELD glad0242 name="input.b.glad0242"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glad0242
            
            #add-point:AFTER FIELD glad0242 name="input.a.glad0242"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE glad0242
            #add-point:ON CHANGE glad0242 name="input.g.glad0242"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glad025
            #add-point:BEFORE FIELD glad025 name="input.b.glad025"
         
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glad025
            
            #add-point:AFTER FIELD glad025 name="input.a.glad025"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE glad025
            #add-point:ON CHANGE glad025 name="input.g.glad025"
            CALL agli030_01_set_entry(p_cmd)
            CALL agli030_01_set_noentry(p_cmd)
            CALL agli030_01_set_required(p_cmd)
            IF g_glad_m.glad025 = 'N' THEN
               LET g_glad_m.glad0251 = ''
               LET g_glad_m.glad0252 = ''
               DISPLAY g_glad_m.glad0251 TO glad0251
               DISPLAY g_glad_m.glad0252 TO glad0252
               LET g_glad_m.glad0251_desc = ''
               DISPLAY g_glad_m.glad0251_desc TO glad0251_desc
            END IF
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glad0251
            
            #add-point:AFTER FIELD glad0251 name="input.a.glad0251"
            DISPLAY '' TO glad0251_desc
            IF NOT agli030_01_glad0171_glad0261_chk(g_glad_m.glad0251) THEN
               LET g_glad_m.glad0251 = g_glad_m_t.glad0251
               CALL agli030_01_hsx_ref(g_glad_m.glad0251)
                  RETURNING g_glad_m.glad0251_desc
               DISPLAY g_glad_m.glad0251_desc TO glad0251_desc
               NEXT FIELD glad0251
            END IF 
            CALL agli030_01_hsx_ref(g_glad_m.glad0251)
                  RETURNING g_glad_m.glad0251_desc
            DISPLAY g_glad_m.glad0251_desc TO glad0251_desc

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glad0251
            #add-point:BEFORE FIELD glad0251 name="input.b.glad0251"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE glad0251
            #add-point:ON CHANGE glad0251 name="input.g.glad0251"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glad0252
            #add-point:BEFORE FIELD glad0252 name="input.b.glad0252"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glad0252
            
            #add-point:AFTER FIELD glad0252 name="input.a.glad0252"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE glad0252
            #add-point:ON CHANGE glad0252 name="input.g.glad0252"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glad026
            #add-point:BEFORE FIELD glad026 name="input.b.glad026"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glad026
            
            #add-point:AFTER FIELD glad026 name="input.a.glad026"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE glad026
            #add-point:ON CHANGE glad026 name="input.g.glad026"
            CALL agli030_01_set_entry(p_cmd)
            CALL agli030_01_set_noentry(p_cmd)
            CALL agli030_01_set_required(p_cmd)
            IF g_glad_m.glad026 = 'N' THEN
               LET g_glad_m.glad0261 = ''
               LET g_glad_m.glad0262 = ''
               DISPLAY g_glad_m.glad0261 TO glad0261
               DISPLAY g_glad_m.glad0262 TO glad0262
               LET g_glad_m.glad0261_desc = ''
               DISPLAY g_glad_m.glad0261_desc TO glad0261_desc
            END IF
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glad0261
            
            #add-point:AFTER FIELD glad0261 name="input.a.glad0261"
            DISPLAY '' TO glad0261_desc
            IF NOT agli030_01_glad0171_glad0261_chk(g_glad_m.glad0261) THEN
               LET g_glad_m.glad0261 = g_glad_m_t.glad0261
               CALL agli030_01_hsx_ref(g_glad_m.glad0261)
                  RETURNING g_glad_m.glad0261_desc
               DISPLAY g_glad_m.glad0261_desc TO glad0261_desc
               NEXT FIELD glad0261
            END IF 
            CALL agli030_01_hsx_ref(g_glad_m.glad0261)
                  RETURNING g_glad_m.glad0261_desc
            DISPLAY g_glad_m.glad0261_desc TO glad0261_desc

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glad0261
            #add-point:BEFORE FIELD glad0261 name="input.b.glad0261"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE glad0261
            #add-point:ON CHANGE glad0261 name="input.g.glad0261"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glad0262
            #add-point:BEFORE FIELD glad0262 name="input.b.glad0262"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glad0262
            
            #add-point:AFTER FIELD glad0262 name="input.a.glad0262"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE glad0262
            #add-point:ON CHANGE glad0262 name="input.g.glad0262"
            
            #END add-point 
 
 
 #欄位檢查
                  #Ctrlp:input.c.gladld
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gladld
            #add-point:ON ACTION controlp INFIELD gladld name="input.c.gladld"
#此段落由子樣板a07產生            
            #開窗i段
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_glad_m.gladld             #給予default值

            #給予arg

            CALL q_glaa()                                #呼叫開窗

            LET g_glad_m.gladld = g_qryparam.return1              #將開窗取得的值回傳到變數

            DISPLAY g_glad_m.gladld TO gladld              #顯示到畫面上

            NEXT FIELD gladld                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.glad001
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glad001
            #add-point:ON ACTION controlp INFIELD glad001 name="input.c.glad001"
#此段落由子樣板a07產生            
            #開窗i段
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_glad_m.glad001             #給予default值
            LET g_qryparam.where = " glac003 !='1' "
            #給予arg

            LET g_qryparam.arg1 = l_glac001
            CALL q_glac()                                #呼叫開窗

            LET g_glad_m.glad001 = g_qryparam.return1              #將開窗取得的值回傳到變數
            LET g_qryparam.where = ''
            DISPLAY g_glad_m.glad001 TO glad001              #顯示到畫面上
            CALL agli030_01_glad001_ref(g_glad_m.gladld,g_glad_m.glad001) 
               RETURNING g_glad_m.glad001_desc
            DISPLAY g_glad_m.glad001_desc TO glad001_desc
            NEXT FIELD glad001                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.gladstus
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gladstus
            #add-point:ON ACTION controlp INFIELD gladstus name="input.c.gladstus"
            
            #END add-point
 
 
         #Ctrlp:input.c.glad030
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glad030
            #add-point:ON ACTION controlp INFIELD glad030 name="input.c.glad030"
            
            #END add-point
 
 
         #Ctrlp:input.c.glad002
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glad002
            #add-point:ON ACTION controlp INFIELD glad002 name="input.c.glad002"
            
            #END add-point
 
 
         #Ctrlp:input.c.glad003
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glad003
            #add-point:ON ACTION controlp INFIELD glad003 name="input.c.glad003"
            
            #END add-point
 
 
         #Ctrlp:input.c.glad004
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glad004
            #add-point:ON ACTION controlp INFIELD glad004 name="input.c.glad004"
            
            #END add-point
 
 
         #Ctrlp:input.c.glad005
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glad005
            #add-point:ON ACTION controlp INFIELD glad005 name="input.c.glad005"
            
            #END add-point
 
 
         #Ctrlp:input.c.glad006
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glad006
            #add-point:ON ACTION controlp INFIELD glad006 name="input.c.glad006"
#此段落由子樣板a07產生            
            #開窗i段
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_glad_m.glad006             #給予default值
            LET l_glaa005 = ''
            SELECT glaa005 INTO l_glaa005 FROM glaa_t
             WHERE glaaent = g_enterprise AND glaald = g_glad_m.gladld
            LET g_qryparam.where = " nmai001 = '",l_glaa005,"'"
            #給予arg

            CALL q_nmai002()                                #呼叫開窗

            LET g_glad_m.glad006 = g_qryparam.return1              #將開窗取得的值回傳到變數

            DISPLAY g_glad_m.glad006 TO glad006              #顯示到畫面上
            CALL agli030_01_glad006_ref(g_glad_m.gladld,g_glad_m.glad006) 
               RETURNING g_glad_m.glad006_desc
            DISPLAY g_glad_m.glad006_desc TO glad006_desc
            LET g_qryparam.where = ''
            NEXT FIELD glad006                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.glad007
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glad007
            #add-point:ON ACTION controlp INFIELD glad007 name="input.c.glad007"
            
            #END add-point
 
 
         #Ctrlp:input.c.glad031
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glad031
            #add-point:ON ACTION controlp INFIELD glad031 name="input.c.glad031"
            
            #END add-point
 
 
         #Ctrlp:input.c.glad008
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glad008
            #add-point:ON ACTION controlp INFIELD glad008 name="input.c.glad008"
            
            #END add-point
 
 
         #Ctrlp:input.c.glad032
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glad032
            #add-point:ON ACTION controlp INFIELD glad032 name="input.c.glad032"
            
            #END add-point
 
 
         #Ctrlp:input.c.glad009
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glad009
            #add-point:ON ACTION controlp INFIELD glad009 name="input.c.glad009"
            
            #END add-point
 
 
         #Ctrlp:input.c.glad033
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glad033
            #add-point:ON ACTION controlp INFIELD glad033 name="input.c.glad033"
            
            #END add-point
 
 
         #Ctrlp:input.c.glad010
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glad010
            #add-point:ON ACTION controlp INFIELD glad010 name="input.c.glad010"
            
            #END add-point
 
 
         #Ctrlp:input.c.glad013
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glad013
            #add-point:ON ACTION controlp INFIELD glad013 name="input.c.glad013"
            
            #END add-point
 
 
         #Ctrlp:input.c.glad027
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glad027
            #add-point:ON ACTION controlp INFIELD glad027 name="input.c.glad027"
            
            #END add-point
 
 
         #Ctrlp:input.c.glad015
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glad015
            #add-point:ON ACTION controlp INFIELD glad015 name="input.c.glad015"
            
            #END add-point
 
 
         #Ctrlp:input.c.glad011
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glad011
            #add-point:ON ACTION controlp INFIELD glad011 name="input.c.glad011"
            
            #END add-point
 
 
         #Ctrlp:input.c.glad016
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glad016
            #add-point:ON ACTION controlp INFIELD glad016 name="input.c.glad016"
            
            #END add-point
 
 
         #Ctrlp:input.c.glad012
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glad012
            #add-point:ON ACTION controlp INFIELD glad012 name="input.c.glad012"
            
            #END add-point
 
 
         #Ctrlp:input.c.glad017
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glad017
            #add-point:ON ACTION controlp INFIELD glad017 name="input.c.glad017"
            
            #END add-point
 
 
         #Ctrlp:input.c.glad0171
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glad0171
            #add-point:ON ACTION controlp INFIELD glad0171 name="input.c.glad0171"
#此段落由子樣板a07產生            
            #開窗i段
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_glad_m.glad0171             #給予default值
            LET g_qryparam.default2 = "" #g_glad_m.glael003 #說明

            #給予arg

            CALL q_glae001()                                #呼叫開窗

            LET g_glad_m.glad0171 = g_qryparam.return1              #將開窗取得的值回傳到變數
            CALL agli030_01_hsx_ref(g_glad_m.glad0171)
               RETURNING g_glad_m.glad0171_desc
            DISPLAY g_glad_m.glad0171_desc TO glad0171_desc

            DISPLAY g_glad_m.glad0171 TO glad0171              #顯示到畫面上

            NEXT FIELD glad0171                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.glad0172
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glad0172
            #add-point:ON ACTION controlp INFIELD glad0172 name="input.c.glad0172"
            
            #END add-point
 
 
         #Ctrlp:input.c.glad018
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glad018
            #add-point:ON ACTION controlp INFIELD glad018 name="input.c.glad018"
            
            #END add-point
 
 
         #Ctrlp:input.c.glad0181
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glad0181
            #add-point:ON ACTION controlp INFIELD glad0181 name="input.c.glad0181"
#此段落由子樣板a07產生            
            #開窗i段
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_glad_m.glad0181             #給予default值
            LET g_qryparam.default2 = "" #g_glad_m.glael003 #說明

            #給予arg

            CALL q_glae001()                                #呼叫開窗

            LET g_glad_m.glad0181 = g_qryparam.return1              #將開窗取得的值回傳到變數
            CALL agli030_01_hsx_ref(g_glad_m.glad0181)
               RETURNING g_glad_m.glad0181_desc
            DISPLAY g_glad_m.glad0181_desc TO glad0181_desc

            DISPLAY g_glad_m.glad0181 TO glad0181              #顯示到畫面上

            NEXT FIELD glad0181                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.glad0182
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glad0182
            #add-point:ON ACTION controlp INFIELD glad0182 name="input.c.glad0182"
            
            #END add-point
 
 
         #Ctrlp:input.c.glad019
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glad019
            #add-point:ON ACTION controlp INFIELD glad019 name="input.c.glad019"
            
            #END add-point
 
 
         #Ctrlp:input.c.glad0191
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glad0191
            #add-point:ON ACTION controlp INFIELD glad0191 name="input.c.glad0191"
#此段落由子樣板a07產生            
            #開窗i段
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_glad_m.glad0191             #給予default值
            LET g_qryparam.default2 = "" #g_glad_m.glael003 #說明

            #給予arg

            CALL q_glae001()                                #呼叫開窗

            LET g_glad_m.glad0191 = g_qryparam.return1              #將開窗取得的值回傳到變數
            CALL agli030_01_hsx_ref(g_glad_m.glad0191)
               RETURNING g_glad_m.glad0191_desc
            DISPLAY g_glad_m.glad0191_desc TO glad0191_desc

            DISPLAY g_glad_m.glad0191 TO glad0191              #顯示到畫面上

            NEXT FIELD glad0191                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.glad0192
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glad0192
            #add-point:ON ACTION controlp INFIELD glad0192 name="input.c.glad0192"
            
            #END add-point
 
 
         #Ctrlp:input.c.glad020
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glad020
            #add-point:ON ACTION controlp INFIELD glad020 name="input.c.glad020"
            
            #END add-point
 
 
         #Ctrlp:input.c.glad0201
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glad0201
            #add-point:ON ACTION controlp INFIELD glad0201 name="input.c.glad0201"
#此段落由子樣板a07產生            
            #開窗i段
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_glad_m.glad0201             #給予default值
            LET g_qryparam.default2 = "" #g_glad_m.glael003 #說明

            #給予arg

            CALL q_glae001()                                #呼叫開窗

            LET g_glad_m.glad0201 = g_qryparam.return1              #將開窗取得的值回傳到變數
            CALL agli030_01_hsx_ref(g_glad_m.glad0201)
               RETURNING g_glad_m.glad0201_desc
            DISPLAY g_glad_m.glad0201_desc TO glad0201_desc

            DISPLAY g_glad_m.glad0201 TO glad0201              #顯示到畫面上

            NEXT FIELD glad0201                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.glad0202
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glad0202
            #add-point:ON ACTION controlp INFIELD glad0202 name="input.c.glad0202"
            
            #END add-point
 
 
         #Ctrlp:input.c.glad021
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glad021
            #add-point:ON ACTION controlp INFIELD glad021 name="input.c.glad021"
            
            #END add-point
 
 
         #Ctrlp:input.c.glad0211
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glad0211
            #add-point:ON ACTION controlp INFIELD glad0211 name="input.c.glad0211"
#此段落由子樣板a07產生            
            #開窗i段
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_glad_m.glad0211             #給予default值
            LET g_qryparam.default2 = "" #g_glad_m.glael003 #說明

            #給予arg

            CALL q_glae001()                                #呼叫開窗

            LET g_glad_m.glad0211 = g_qryparam.return1              #將開窗取得的值回傳到變數
            CALL agli030_01_hsx_ref(g_glad_m.glad0211)
               RETURNING g_glad_m.glad0211_desc
            DISPLAY g_glad_m.glad0211_desc TO glad0211_desc

            DISPLAY g_glad_m.glad0211 TO glad0211              #顯示到畫面上

            NEXT FIELD glad0211                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.glad0212
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glad0212
            #add-point:ON ACTION controlp INFIELD glad0212 name="input.c.glad0212"
            
            #END add-point
 
 
         #Ctrlp:input.c.glad022
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glad022
            #add-point:ON ACTION controlp INFIELD glad022 name="input.c.glad022"
            
            #END add-point
 
 
         #Ctrlp:input.c.glad0221
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glad0221
            #add-point:ON ACTION controlp INFIELD glad0221 name="input.c.glad0221"
#此段落由子樣板a07產生            
            #開窗i段
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_glad_m.glad0221             #給予default值
            LET g_qryparam.default2 = "" #g_glad_m.glael003 #說明

            #給予arg

            CALL q_glae001()                                #呼叫開窗

            LET g_glad_m.glad0221 = g_qryparam.return1              #將開窗取得的值回傳到變數
            CALL agli030_01_hsx_ref(g_glad_m.glad0221)
               RETURNING g_glad_m.glad0221_desc
            DISPLAY g_glad_m.glad0221_desc TO glad0221_desc

            DISPLAY g_glad_m.glad0221 TO glad0221              #顯示到畫面上

            NEXT FIELD glad0221                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.glad0222
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glad0222
            #add-point:ON ACTION controlp INFIELD glad0222 name="input.c.glad0222"
            
            #END add-point
 
 
         #Ctrlp:input.c.glad023
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glad023
            #add-point:ON ACTION controlp INFIELD glad023 name="input.c.glad023"
            
            #END add-point
 
 
         #Ctrlp:input.c.glad0231
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glad0231
            #add-point:ON ACTION controlp INFIELD glad0231 name="input.c.glad0231"
#此段落由子樣板a07產生            
            #開窗i段
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_glad_m.glad0231             #給予default值
            LET g_qryparam.default2 = "" #g_glad_m.glael003 #說明

            #給予arg

            CALL q_glae001()                                #呼叫開窗

            LET g_glad_m.glad0231 = g_qryparam.return1              #將開窗取得的值回傳到變數
            CALL agli030_01_hsx_ref(g_glad_m.glad0231)
               RETURNING g_glad_m.glad0231_desc
            DISPLAY g_glad_m.glad0231_desc TO glad0231_desc

            DISPLAY g_glad_m.glad0231 TO glad0231              #顯示到畫面上

            NEXT FIELD glad0231                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.glad0232
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glad0232
            #add-point:ON ACTION controlp INFIELD glad0232 name="input.c.glad0232"
            
            #END add-point
 
 
         #Ctrlp:input.c.glad024
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glad024
            #add-point:ON ACTION controlp INFIELD glad024 name="input.c.glad024"
            
            #END add-point
 
 
         #Ctrlp:input.c.glad0241
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glad0241
            #add-point:ON ACTION controlp INFIELD glad0241 name="input.c.glad0241"
#此段落由子樣板a07產生            
            #開窗i段
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_glad_m.glad0241             #給予default值
            LET g_qryparam.default2 = "" #g_glad_m.glael003 #說明

            #給予arg

            CALL q_glae001()                                #呼叫開窗

            LET g_glad_m.glad0241 = g_qryparam.return1              #將開窗取得的值回傳到變數
            CALL agli030_01_hsx_ref(g_glad_m.glad0241)
               RETURNING g_glad_m.glad0241_desc
            DISPLAY g_glad_m.glad0241_desc TO glad0241_desc

            DISPLAY g_glad_m.glad0241 TO glad0241              #顯示到畫面上

            NEXT FIELD glad0241                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.glad0242
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glad0242
            #add-point:ON ACTION controlp INFIELD glad0242 name="input.c.glad0242"
            
            #END add-point
 
 
         #Ctrlp:input.c.glad025
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glad025
            #add-point:ON ACTION controlp INFIELD glad025 name="input.c.glad025"
            
            #END add-point
 
 
         #Ctrlp:input.c.glad0251
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glad0251
            #add-point:ON ACTION controlp INFIELD glad0251 name="input.c.glad0251"
#此段落由子樣板a07產生            
            #開窗i段
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_glad_m.glad0251             #給予default值
            LET g_qryparam.default2 = "" #g_glad_m.glael003 #說明

            #給予arg

            CALL q_glae001()                                #呼叫開窗

            LET g_glad_m.glad0251 = g_qryparam.return1              #將開窗取得的值回傳到變數
            CALL agli030_01_hsx_ref(g_glad_m.glad0251)
               RETURNING g_glad_m.glad0251_desc
            DISPLAY g_glad_m.glad0251_desc TO glad0251_desc

            DISPLAY g_glad_m.glad0251 TO glad0251              #顯示到畫面上

            NEXT FIELD glad0251                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.glad0252
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glad0252
            #add-point:ON ACTION controlp INFIELD glad0252 name="input.c.glad0252"
            
            #END add-point
 
 
         #Ctrlp:input.c.glad026
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glad026
            #add-point:ON ACTION controlp INFIELD glad026 name="input.c.glad026"
            
            #END add-point
 
 
         #Ctrlp:input.c.glad0261
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glad0261
            #add-point:ON ACTION controlp INFIELD glad0261 name="input.c.glad0261"
#此段落由子樣板a07產生            
            #開窗i段
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_glad_m.glad0261             #給予default值
            LET g_qryparam.default2 = "" #g_glad_m.glael003 #說明

            #給予arg

            CALL q_glae001()                                #呼叫開窗

            LET g_glad_m.glad0261 = g_qryparam.return1              #將開窗取得的值回傳到變數
            CALL agli030_01_hsx_ref(g_glad_m.glad0261)
               RETURNING g_glad_m.glad0261_desc
            DISPLAY g_glad_m.glad0261_desc TO glad0261_desc

            DISPLAY g_glad_m.glad0261 TO glad0261              #顯示到畫面上

            NEXT FIELD glad0261                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.glad0262
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glad0262
            #add-point:ON ACTION controlp INFIELD glad0262 name="input.c.glad0262"
            
            #END add-point
 
 
 #欄位開窗
 
         AFTER INPUT
            #add-point:單頭輸入後處理 name="input.after_input"
            IF INT_FLAG THEN
               EXIT DIALOG
            END IF 
#            CALL cl_showmsg()
            IF p_cmd <> 'u' THEN
               LET l_count = 1
               SELECT COUNT(*) INTO l_count FROM glad_t
                WHERE gladld = g_glad_m.gladld AND glad001 = g_glad_m.glad001
                  AND gladent = g_enterprise #160905-00007#3 add
               IF l_count = 0 THEN
                  INSERT INTO glad_t(gladent,gladld,glad001,glad002,glad003,glad004,
                                     glad005,glad006,glad007,glad008,glad009,
                                     glad010,glad011,glad012,glad013,
                                     glad015,glad016,glad030,glad031,glad032,glad033,
                                     glad017,glad0171,glad0172,glad018,glad0181,glad0182,
                                     glad019,glad0191,glad0192,glad020,glad0201,glad0202,
                                     glad021,glad0211,glad0212,glad022,glad0221,glad0222,
                                     glad023,glad0231,glad0232,glad024,glad0241,glad0242,
                                     glad025,glad0251,glad0252,glad026,glad0261,glad0262,glad027,
                                     gladstus,gladownid,gladowndp,gladcrtid,gladcrtdt,gladcrtdp,gladmodid,gladmoddt)
                  VALUES(g_enterprise,g_glad_m.gladld,g_glad_m.glad001,g_glad_m.glad002,g_glad_m.glad003,g_glad_m.glad004,
                         g_glad_m.glad005,g_glad_m.glad006,g_glad_m.glad007,g_glad_m.glad008,g_glad_m.glad009,
                         g_glad_m.glad010,g_glad_m.glad011,g_glad_m.glad012,g_glad_m.glad013,
                         g_glad_m.glad015,g_glad_m.glad016,g_glad_m.glad030,g_glad_m.glad031,g_glad_m.glad032,g_glad_m.glad033,
                         g_glad_m.glad017,g_glad_m.glad0171,g_glad_m.glad0172,g_glad_m.glad018,g_glad_m.glad0181,g_glad_m.glad0182,
                         g_glad_m.glad019,g_glad_m.glad0191,g_glad_m.glad0192,g_glad_m.glad020,g_glad_m.glad0201,g_glad_m.glad0202,
                         g_glad_m.glad021,g_glad_m.glad0211,g_glad_m.glad0212,g_glad_m.glad022,g_glad_m.glad0221,g_glad_m.glad0222,
                         g_glad_m.glad023,g_glad_m.glad0231,g_glad_m.glad0232,g_glad_m.glad024,g_glad_m.glad0241,g_glad_m.glad0242,
                         g_glad_m.glad025,g_glad_m.glad0251,g_glad_m.glad0252,g_glad_m.glad026,g_glad_m.glad0261,g_glad_m.glad0262,
                         g_glad_m.glad027,
                         g_glad_m.gladstus,g_user,g_dept,g_user,l_gladcrtdt,g_dept,'','')
                  IF SQLCA.sqlcode THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = SQLCA.sqlcode
                     LET g_errparam.extend = "g_glad_m"
                     LET g_errparam.popup = TRUE
                     CALL cl_err()

                     CONTINUE DIALOG
                  END IF                  
                  CALL s_transaction_end('Y','0')
               ELSE
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code =  'std-00006'
                  LET g_errparam.extend =  g_glad_m.glad001
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  CALL s_transaction_end('N','0')
               END IF
            ELSE
               UPDATE glad_t SET gladld = g_glad_m.gladld,glad001 = g_glad_m.glad001,glad002 = g_glad_m.glad002,
                                 glad003 = g_glad_m.glad003,glad004 = g_glad_m.glad004,glad005 = g_glad_m.glad005,
                                 glad006 = g_glad_m.glad006,glad007 = g_glad_m.glad007,glad008 = g_glad_m.glad008,
                                 glad009 = g_glad_m.glad009,glad010 = g_glad_m.glad010,glad011 = g_glad_m.glad011,
                                 glad012 = g_glad_m.glad012,glad013 = g_glad_m.glad013,
                                 glad015 = g_glad_m.glad015,glad016 = g_glad_m.glad016,glad027 = g_glad_m.glad027,
                                 glad030 = g_glad_m.glad030,glad031 = g_glad_m.glad031,
                                 glad032 = g_glad_m.glad032,glad033 = g_glad_m.glad033,
                                 glad017 = g_glad_m.glad017,glad0171 = g_glad_m.glad0171,glad0172 = g_glad_m.glad0172,
                                 glad018 = g_glad_m.glad018,glad0181 = g_glad_m.glad0181,glad0182 = g_glad_m.glad0182,
                                 glad019 = g_glad_m.glad019,glad0191 = g_glad_m.glad0191,glad0192 = g_glad_m.glad0192,
                                 glad020 = g_glad_m.glad020,glad0201 = g_glad_m.glad0201,glad0202 = g_glad_m.glad0202,
                                 glad021 = g_glad_m.glad021,glad0211 = g_glad_m.glad0211,glad0212 = g_glad_m.glad0212,
                                 glad022 = g_glad_m.glad022,glad0221 = g_glad_m.glad0221,glad0222 = g_glad_m.glad0222,
                                 glad023 = g_glad_m.glad023,glad0231 = g_glad_m.glad0231,glad0232 = g_glad_m.glad0232,
                                 glad024 = g_glad_m.glad024,glad0241 = g_glad_m.glad0241,glad0242 = g_glad_m.glad0242,
                                 glad025 = g_glad_m.glad025,glad0251 = g_glad_m.glad0251,glad0252 = g_glad_m.glad0252,
                                 glad026 = g_glad_m.glad026,glad0261 = g_glad_m.glad0261,glad0262 = g_glad_m.glad0262,
                                 gladstus = g_glad_m.gladstus,
                                 gladmodid = g_user,gladmoddt = l_gladmoddt
                WHERE gladent = g_enterprise AND gladld = g_glad_m_t.gladld AND glad001 = g_glad_m_t.glad001
               IF SQLCA.sqlcode THEN
                  INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = SQLCA.sqlcode
                     LET g_errparam.extend = "g_glad_m"
                     LET g_errparam.popup = TRUE
                     CALL cl_err()

                  CALL s_transaction_end('N','0')
               ELSE                  
                  CALL s_transaction_end('Y','0')
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
   CLOSE WINDOW w_agli030_01 
   
   #add-point:input段after input name="input.post_input"
   
   #end add-point    
   
END FUNCTION
 
{</section>}
 
{<section id="agli030_01.other_dialog" readonly="Y" >}

 
{</section>}
 
{<section id="agli030_01.other_function" readonly="Y" >}
#根據帳別導出現金變動碼值
PRIVATE FUNCTION agli030_01_gladld_ref(p_gladld)
   DEFINE p_gladld LIKE glad_t.gladld
   DEFINE r_glaa005 LIKE glaa_t.glaa005

   LET r_glaa005 = ''
   IF NOT cl_null(p_gladld) THEN
      SELECT glaa005 INTO r_glaa005 FROM glaa_t
       WHERE glaaent = g_enterprise AND glaald = p_gladld
   END IF 
   RETURN r_glaa005
END FUNCTION
#檢查glad006的有效性
PRIVATE FUNCTION agli030_01_glad006_chk(p_gladld,p_glad006)
   DEFINE p_gladld  LIKE glad_t.gladld
   DEFINE p_glad006 LIKE glad_t.glad006
   DEFINE l_nmai001 LIKE nmai_t.nmai001
   DEFINE r_success LIKE type_t.num5

   LET r_success = TRUE
   
   IF NOT cl_null(p_glad006) AND NOT cl_null(p_gladld) THEN
      CALL agli030_01_gladld_ref(p_gladld)
         RETURNING l_nmai001
      IF r_success THEN 
         IF NOT ap_chk_isExist(p_glad006,"SELECT COUNT(*) FROM nmai_t WHERE nmaient = '"
            ||g_enterprise||"'  AND nmai001 = '"||l_nmai001||"' AND nmai002 = ? ",'anm-00008',0 ) THEN
            LET r_success = FALSE
         END IF
      END IF 
      IF r_success THEN
         IF NOT ap_chk_isExist(p_glad006,"SELECT COUNT(*) FROM nmai_t WHERE nmaient = '"
#            ||g_enterprise||"'  AND nmai001 = '"||l_nmai001||"' AND nmai002 = ? AND nmaistus = 'Y'",'anm-00021',0 ) THEN
             ||g_enterprise||"'  AND nmai001 = '"||l_nmai001||"' AND nmai002 = ? AND nmaistus = 'Y'",'sub-01302','anmi160') THEN#160318-00005#13 mod 
            LET r_success = FALSE
         END IF
      END IF 
      IF r_success THEN 
      END IF
   END IF  
   RETURN r_success 
END FUNCTION
##核算項管理類型有效性檢查
PRIVATE FUNCTION agli030_01_glad0171_glad0261_chk(p_chk_str)
   DEFINE p_chk_str LIKE glad_t.glad0171
   DEFINE r_success LIKE type_t.num5

   LET r_success = TRUE
   IF NOT cl_null(p_chk_str) THEN
      IF r_success THEN 
         IF NOT ap_chk_isExist(p_chk_str,"SELECT COUNT(*) FROM glae_t WHERE glaeent = '"
            ||g_enterprise||"'  AND glae001 = ? ",'agl-00062',0 ) THEN
            LET r_success = FALSE
         END IF
      END IF 
      IF r_success THEN 
         IF NOT ap_chk_isExist(p_chk_str,"SELECT COUNT(*) FROM glae_t WHERE glaeent = '"
#            ||g_enterprise||"'  AND glae001 = ? AND glaestus = 'Y'",'agl-00063',0 ) THEN
             ||g_enterprise||"'  AND glae001 = ? AND glaestus = 'Y'",'sub-01302','agli041') THEN#160318-00005#13 mod 
            LET r_success = FALSE
         END IF
      END IF
   END IF 
   RETURN r_success 
END FUNCTION
#+
PRIVATE FUNCTION agli030_01_update()
   SELECT gladld,glad001,glad002,glad003,glad004,glad005,glad006,glad007,glad008,glad009,glad010,glad011,
   glad012,glad013,glad015,glad016,glad017,glad0171,glad0172,glad018,glad0181,glad0182,glad019,
   glad0191,glad0192,glad020,glad0201,glad0202,glad021,glad0211,glad0212,glad022,glad0221,glad0222,glad023,
   glad0231,glad0232,glad024,glad0241,glad0242,glad025,glad0251,glad0252,glad026,glad0261,glad0262,gladstus,
   glad027,glad030,glad031,glad032,glad033
     INTO g_glad_m.gladld,g_glad_m.glad001,g_glad_m.glad002,g_glad_m.glad003,g_glad_m.glad004,
        g_glad_m.glad005,g_glad_m.glad006,g_glad_m.glad007,g_glad_m.glad008,g_glad_m.glad009,
        g_glad_m.glad010,g_glad_m.glad011,g_glad_m.glad012,g_glad_m.glad013,
        g_glad_m.glad015,g_glad_m.glad016,
        g_glad_m.glad017,g_glad_m.glad0171,g_glad_m.glad0172,g_glad_m.glad018,g_glad_m.glad0181,g_glad_m.glad0182,
        g_glad_m.glad019,g_glad_m.glad0191,g_glad_m.glad0192,g_glad_m.glad020,g_glad_m.glad0201,g_glad_m.glad0202,
        g_glad_m.glad021,g_glad_m.glad0211,g_glad_m.glad0212,g_glad_m.glad022,g_glad_m.glad0221,g_glad_m.glad0222,
        g_glad_m.glad023,g_glad_m.glad0231,g_glad_m.glad0232,g_glad_m.glad024,g_glad_m.glad0241,g_glad_m.glad0242,
        g_glad_m.glad025,g_glad_m.glad0251,g_glad_m.glad0252,g_glad_m.glad026,g_glad_m.glad0261,g_glad_m.glad0262,
        g_glad_m.gladstus,g_glad_m.glad027,g_glad_m.glad030,g_glad_m.glad031,g_glad_m.glad032,g_glad_m.glad033
     FROM glad_t 
    WHERE gladent= g_enterprise AND gladld=g_glad_m.gladld AND glad001 = g_glad_m.glad001
   CALL agli030_01_gladld_ref_glaal002(g_glad_m.gladld) 
      RETURNING g_glad_m.gladld_desc
   DISPLAY g_glad_m.gladld_desc TO gladld_desc
   CALL agli030_01_glad006_ref(g_glad_m.gladld,g_glad_m.glad006)
      RETURNING g_glad_m.glad006_desc
   DISPLAY g_glad_m.glad006_desc TO glad006_desc
   CALL agli030_01_hsx_ref(g_glad_m.glad0171) RETURNING g_glad_m.glad0171_desc
   CALL agli030_01_hsx_ref(g_glad_m.glad0181) RETURNING g_glad_m.glad0181_desc
   CALL agli030_01_hsx_ref(g_glad_m.glad0191) RETURNING g_glad_m.glad0191_desc
   CALL agli030_01_hsx_ref(g_glad_m.glad0201) RETURNING g_glad_m.glad0201_desc
   CALL agli030_01_hsx_ref(g_glad_m.glad0211) RETURNING g_glad_m.glad0211_desc
   CALL agli030_01_hsx_ref(g_glad_m.glad0221) RETURNING g_glad_m.glad0221_desc
   CALL agli030_01_hsx_ref(g_glad_m.glad0231) RETURNING g_glad_m.glad0231_desc
   CALL agli030_01_hsx_ref(g_glad_m.glad0241) RETURNING g_glad_m.glad0241_desc
   CALL agli030_01_hsx_ref(g_glad_m.glad0251) RETURNING g_glad_m.glad0251_desc
   CALL agli030_01_hsx_ref(g_glad_m.glad0261) RETURNING g_glad_m.glad0261_desc
   DISPLAY g_glad_m.glad0171_desc TO glad0171_desc
   DISPLAY g_glad_m.glad0181_desc TO glad0181_desc
   DISPLAY g_glad_m.glad0191_desc TO glad0191_desc
   DISPLAY g_glad_m.glad0201_desc TO glad0201_desc
   DISPLAY g_glad_m.glad0211_desc TO glad0211_desc
   DISPLAY g_glad_m.glad0221_desc TO glad0221_desc
   DISPLAY g_glad_m.glad0231_desc TO glad0231_desc
   DISPLAY g_glad_m.glad0241_desc TO glad0241_desc
   DISPLAY g_glad_m.glad0251_desc TO glad0251_desc
   DISPLAY g_glad_m.glad0261_desc TO glad0261_desc
   
END FUNCTION
#+
PRIVATE FUNCTION agli030_01_insert()
   DEFINE l_glaa004 LIKE glaa_t.glaa004 
   LET g_glad_m.glad002 = "N"
   LET g_glad_m.glad003 = "N"
   LET g_glad_m.glad005 = "N"
#   LET g_glad_m.glad007 = "N"
#   LET g_glad_m.glad012 = "N"
#   LET g_glad_m.glad008 = "N"
#   LET g_glad_m.glad013 = "N"
#   LET g_glad_m.glad009 = "N"
#   LET g_glad_m.glad014 = "N"
#   LET g_glad_m.glad010 = "N"
#   LET g_glad_m.glad015 = "N"
#   LET g_glad_m.glad011 = "N"
#   LET g_glad_m.glad016 = "N"
   LET g_glad_m.glad017 = "N"
   LET g_glad_m.glad022 = "N"
   LET g_glad_m.glad018 = "N"
   LET g_glad_m.glad023 = "N"
   LET g_glad_m.glad019 = "N"
   LET g_glad_m.glad024 = "N"
   LET g_glad_m.glad020 = "N"
   LET g_glad_m.glad025 = "N"
   LET g_glad_m.glad021 = "N"
   LET g_glad_m.glad026 = "N"
   LET g_glad_m.glad027 = "N"
   LET g_glad_m.glad030 = "N"
   SELECT glaa004 INTO l_glaa004 FROM glaa_t
    WHERE glaaent = g_enterprise AND glaald = g_glad_m.gladld
   SELECT glac017,glac018,glac019,glac020,glac021,glac022,glac023,glac025,
          glac026,glac027,glac028,glac029,glac030
     INTO g_glad_m.glad007,g_glad_m.glad008,g_glad_m.glad009,g_glad_m.glad010,g_glad_m.glad011,
          g_glad_m.glad012,g_glad_m.glad013,g_glad_m.glad015,g_glad_m.glad016,g_glad_m.glad027,
          g_glad_m.glad031,g_glad_m.glad032,g_glad_m.glad033
     FROM glac_t
    WHERE glacent = g_enterprise AND glac001 = l_glaa004 AND glac002 = g_glad_m.glad001
   LET g_glad_m.gladstus = "Y"
END FUNCTION
#+
PRIVATE FUNCTION agli030_01_copy()
   CALL agli030_01_update()
   LET g_glad_m.glad001 = ''
   CALL cl_set_comp_entry('glad001',TRUE)
END FUNCTION
#+
PRIVATE FUNCTION agli030_01_set_noentry(p_cmd)
   DEFINE p_cmd LIKE type_t.chr5
   
   CALL cl_set_comp_entry('glad004',g_glad_m.glad003='Y')
   CALL cl_set_comp_entry('glad0171,glad0172',g_glad_m.glad017 = 'Y' )
   CALL cl_set_comp_entry('glad0181,glad0182',g_glad_m.glad018 = 'Y' )
   CALL cl_set_comp_entry('glad0191,glad0192',g_glad_m.glad019 = 'Y' )
   CALL cl_set_comp_entry('glad0201,glad0202',g_glad_m.glad020 = 'Y' )
   CALL cl_set_comp_entry('glad0211,glad0212',g_glad_m.glad021 = 'Y' )
   CALL cl_set_comp_entry('glad0221,glad0222',g_glad_m.glad022 = 'Y' )
   CALL cl_set_comp_entry('glad0231,glad0232',g_glad_m.glad023 = 'Y' )
   CALL cl_set_comp_entry('glad0241,glad0242',g_glad_m.glad024 = 'Y' )
   CALL cl_set_comp_entry('glad0251,glad0252',g_glad_m.glad025 = 'Y' )
   CALL cl_set_comp_entry('glad0261,glad0262',g_glad_m.glad026 = 'Y' )
   IF p_cmd = 'c' THEN
      CALL cl_set_comp_entry('glad002,glad003,glad004,glad005,glad006,glad007,glad008,glad009,glad010',FALSE)
      CALL cl_set_comp_entry('glad011,glad012,glad013,glad015,glad016,glad017,glad018,glad019',FALSE)
      CALL cl_set_comp_entry('glad020,glad021,glad022,glad023,glad024,glad025,glad026,glad027',FALSE)
      CALL cl_set_comp_entry('glad0171,glad0181,glad0191,glad0172,glad0182,glad0192',FALSE)
      CALL cl_set_comp_entry('glad0201,glad0211,glad0221,glad0231,glad0241,glad0251,glad0261',FALSE)
      CALL cl_set_comp_entry('glad0202,glad0212,glad0222,glad0232,glad0242,glad0252,glad0262',FALSE)
      CALL cl_set_comp_entry('glad030,glad031,glad032,glad033',FALSE)
   END IF
END FUNCTION
#+
PRIVATE FUNCTION agli030_01_set_entry(p_cmd)
   DEFINE p_cmd LIKE type_t.chr5
   
   CALL cl_set_comp_entry('glad004',TRUE)
   CALL cl_set_comp_entry('glad0171,glad0172,glad0181,glad0182,glad0191,glad0192,glad0201,glad0202',TRUE)
   CALL cl_set_comp_entry('glad0211,glad0212,glad0221,gad0222,glad0231,glad0232,glad0241,glad0242',TRUE)
   CALL cl_set_comp_entry('glad0251,glad0252,glad0261,glad0262',TRUE)
END FUNCTION
#+
PRIVATE FUNCTION agli030_01_set_required(p_cmd)
   DEFINE p_cmd LIKE type_t.chr5
   
   CALL cl_set_comp_required('glad004',g_glad_m.glad003='Y')
   CALL cl_set_comp_required('glad0171,glad0172',g_glad_m.glad017 = 'Y' )
   CALL cl_set_comp_required('glad0181,glad0182',g_glad_m.glad018 = 'Y' )
   CALL cl_set_comp_required('glad0191,glad0192',g_glad_m.glad019 = 'Y' )
   CALL cl_set_comp_required('glad0201,glad0202',g_glad_m.glad020 = 'Y' )
   CALL cl_set_comp_required('glad0211,glad0212',g_glad_m.glad021 = 'Y' )
   CALL cl_set_comp_required('glad0221,glad0222',g_glad_m.glad022 = 'Y' )
   CALL cl_set_comp_required('glad0231,glad0232',g_glad_m.glad023 = 'Y' )
   CALL cl_set_comp_required('glad0241,glad0242',g_glad_m.glad024 = 'Y' )
   CALL cl_set_comp_required('glad0251,glad0252',g_glad_m.glad025 = 'Y' )
   CALL cl_set_comp_required('glad0261,glad0262',g_glad_m.glad026 = 'Y' )
END FUNCTION
#+
PRIVATE FUNCTION agli030_01_hsx_ref(p_hsx)
   DEFINE p_hsx LIKE glad_t.glad0171
   DEFINE r_glael003 LIKE glael_t.glael003
   
   LET r_glael003 = ''
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = p_hsx
   CALL ap_ref_array2(g_ref_fields,"SELECT glael003 FROM glael_t WHERE glaelent='"||g_enterprise||"' AND glael001=? AND glael002='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET r_glael003  = g_rtn_fields[1]
   RETURN r_glael003
END FUNCTION
#+
PRIVATE FUNCTION agli030_01_glad006_ref(p_gladld,p_glad006)
   DEFINE p_gladld LIKE glad_t.gladld
   DEFINE p_glad006 LIKE glad_t.glad006
   DEFINE r_nmail004 LIKE nmail_t.nmail004
   
   LET r_nmail004 = ''
   INITIALIZE g_ref_fields TO NULL
   CALL agli030_01_gladld_ref(p_gladld) 
      RETURNING g_ref_fields[1]
   LET g_ref_fields[2] = p_glad006
   CALL ap_ref_array2(g_ref_fields,"SELECT nmail004 FROM nmail_t WHERE nmailent='"||g_enterprise||"' AND nmail001=? AND nmail002=? AND nmail003='"||g_dlang||"'","") 
      RETURNING g_rtn_fields
   LET r_nmail004  = g_rtn_fields[1]

   RETURN r_nmail004
END FUNCTION
#+
PRIVATE FUNCTION agli030_01_gladld_ref_glaal002(p_gladld)
   DEFINE p_gladld LIKE glad_t.gladld
   DEFINE r_glaal002 LIKE glaal_t.glaal002
   
   LET r_glaal002 = ''
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = p_gladld
   CALL ap_ref_array2(g_ref_fields,"SELECT glaal002 FROM glaal_t WHERE glaalent='"||g_enterprise||"' AND glaalld=? AND glaal001='"||g_dlang||"'","") 
      RETURNING g_rtn_fields
   LET r_glaal002  = g_rtn_fields[1]
   RETURN r_glaal002
END FUNCTION
#+
PRIVATE FUNCTION agli030_01_glad001_ref(p_gladld,p_glad001)
   DEFINE p_gladld LIKE glad_t.gladld
   DEFINE p_glad001 LIKE glad_t.glad001
   DEFINE l_glaa004 LIKE glaa_t.glaa004
   DEFINE r_glacl004 LIKE glacl_t.glacl004

   LET r_glacl004  = ''
   LET l_glaa004 = ''
   SELECT glaa004 INTO l_glaa004 FROM glaa_t
    WHERE glaaent = g_enterprise AND glaald = p_gladld
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = l_glaa004
   LET g_ref_fields[2] = p_glad001
   CALL ap_ref_array2(g_ref_fields,"SELECT glacl004 FROM glacl_t WHERE glaclent='"
      ||g_enterprise||"' AND glacl001=? AND glacl002 = ? AND glacl003 = '"||g_dlang||"' ","")
      RETURNING g_rtn_fields
   LET r_glacl004 = g_rtn_fields[1]
   RETURN r_glacl004
END FUNCTION
#+
PRIVATE FUNCTION agli030_01_glad001_chk(p_gladld,p_glad001)
   DEFINE p_gladld LIKE glad_t.gladld
   DEFINE p_glad001 LIKE glad_t.glad001
   DEFINE l_glaa004 LIKE glaa_t.glaa004
   DEFINE r_success LIKE type_t.num5

   LET r_success = TRUE
   IF cl_null(p_gladld) THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = ''
      LET g_errparam.extend = ''
      LET g_errparam.popup = TRUE
      CALL cl_err()

      LET r_success = FALSE
   END IF
   IF NOT cl_null(p_gladld) AND NOT cl_null(p_glad001) THEN
      #根據帳別得出會計科目參照表號
      LET l_glaa004 = ''
      SELECT glaa004 INTO l_glaa004 FROM glaa_t
       WHERE glaaent = g_enterprise AND glaald = p_gladld
      IF cl_null(l_glaa004) THEN
         INITIALIZE g_errparam TO NULL
      LET g_errparam.code = ''
      LET g_errparam.extend = ''
      LET g_errparam.popup = TRUE
      CALL cl_err()

         LET r_success = FALSE
      END IF
      #檢查是否重複
      IF r_success THEN
         IF NOT ap_chk_notDup(p_glad001,"SELECT COUNT(*) FROM glad_t WHERE "||"gladent = '"
            ||g_enterprise|| "' AND "||"gladld = '"||p_gladld ||"' AND "
            || "glad001 = '"||p_glad001 ||"'",'std-00004',0) THEN
            LET r_success = FALSE
         END IF
      END IF 
      #判斷是否存在
      IF r_success THEN
         IF NOT ap_chk_isExist(p_glad001,"SELECT COUNT(*) FROM glac_t WHERE "
            ||"glacent = '" ||g_enterprise|| "' AND glac001= '"||l_glaa004||"' AND glac002 = ? ",'agl-00011',0) THEN
            LET r_success = FALSE
         END IF
      END IF
      #判斷是否有效
      IF r_success THEN
         IF NOT ap_chk_isExist(p_glad001,"SELECT COUNT(*) FROM glac_t WHERE "
#            ||"glacent = '" ||g_enterprise|| "' AND glac001= '"||l_glaa004||"' AND glac002 = ? AND glacstus = 'Y' ",'agl-00012',0) THEN
             ||"glacent = '" ||g_enterprise|| "' AND glac001= '"||l_glaa004||"' AND glac002 = ? AND glacstus = 'Y' ",'sub-01302','agli020') THEN#160318-00005#13 mod
            LET r_success = FALSE
         END IF
      END IF
      #判斷是否不為統制科目
      IF r_success THEN
         IF NOT ap_chk_isExist(p_glad001,"SELECT COUNT(*) FROM glac_t WHERE "
            ||"glacent = '" ||g_enterprise|| "' AND glac001= '"||l_glaa004||"' AND glac002 = ? AND glacstus = 'Y' AND glac003 !='1' ",'agl-00013',0) THEN
            LET r_success = FALSE
         END IF
      END IF
   END IF
   RETURN r_success
END FUNCTION

 
{</section>}
 
